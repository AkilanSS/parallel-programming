const std = @import("std");
const Io = std.Io;
const mandelbrot_set = @import("mandelbrot_set");

const a: comptime_float = -2;
const b: comptime_float = 2;
const subdivisions: comptime_int = 1000;

const max_iterations: comptime_int = 255;
const abs_bound = 10;

const WorkerArgs = struct {
    thread_num: u8,

    x_start: u16,
    x_end: u16,
    y_start: u16,
    y_end: u16,

    mandelbrot_set_result: *[subdivisions + 1][subdivisions + 1]u16,
    init: std.process.Init,
};

pub fn main(init: std.process.Init) !void {
    var mandelbrot_set_result: [subdivisions + 1][subdivisions + 1]u16 = [_][subdivisions + 1]u16{[_]u16{max_iterations} ** (subdivisions + 1)} ** (subdivisions + 1);
    const num_threads_array = [_]u8{ 1, 2, 3, 4, 5, 6, 7, 8, 12, 16, 32, 64, 128, 255 };

    var serial_time_taken: i64 = undefined;
    for (num_threads_array) |num_threads| {
        const time_taken = try parallel_row_compute(num_threads, init, &mandelbrot_set_result);
        if (num_threads == 1) serial_time_taken = time_taken;
        std.debug.print(
            "Time to compute with {d} threads: {d:.3} ms ({d:.3} x) \n",
            .{
                num_threads,
                @as(f64, @floatFromInt(time_taken)) / 1000,
                @as(f64, @floatFromInt(serial_time_taken)) / @as(f64, @floatFromInt(time_taken)),
            },
        );
    }

    try save_render(init, &mandelbrot_set_result);
}

inline fn range(i: u32) f64 {
    const del: f64 = (b - a) / @as(f64, @floatFromInt(subdivisions));
    return a + del * @as(f64, @floatFromInt(i));
}

fn serial_compute(init: std.process.Init, mandelbrot_set_result: *[subdivisions + 1][subdivisions + 1]u16) i64 {
    const start_time = std.Io.Timestamp.now(init.io, .awake);
    for (0..subdivisions + 1) |i| {
        for (0..subdivisions + 1) |j| {
            var z_re: f64 = 0;
            var z_im: f64 = 0;

            const c_re = range(@as(u32, @intCast(j)));
            const c_im = range(@as(u32, @intCast(i)));

            for (0..max_iterations) |k| {
                if (std.math.sqrt(z_re * z_re + z_im * z_im) >= abs_bound) {
                    mandelbrot_set_result[i][j] = @as(u16, @intCast(k));
                    break;
                }
                const z_re_new = z_re * z_re - z_im * z_im + c_re;
                const z_im_new = 2 * z_re * z_im + c_im;

                z_re = z_re_new;
                z_im = z_im_new;
            }
        }
    }
    const end_time = Io.Timestamp.now(init.io, .awake);
    return start_time.durationTo(end_time).toMilliseconds();
}

/// Here we use 4 threads to parallelize conputation (quadrants, but it shouldnt matter if it is quadrant or not (hopium cache hits))
fn parallel_compute_quad(init: std.process.Init, mandelbrot_set_result: *[subdivisions + 1][subdivisions + 1]u16) !i64 {
    const start_time = Io.Timestamp.now(init.io, .awake);
    const thread1 = try std.Thread.spawn(
        .{},
        partial_compute,
        .{@as(WorkerArgs, .{
            .x_start = 0,
            .x_end = subdivisions / 2,
            .y_start = 0,
            .y_end = subdivisions / 2,
            .mandelbrot_set_result = mandelbrot_set_result,
            .init = init,
        })},
    );

    const thread2 = try std.Thread.spawn(
        .{},
        partial_compute,
        .{@as(WorkerArgs, .{
            .x_start = 0,
            .x_end = subdivisions / 2,
            .y_start = subdivisions / 2,
            .y_end = subdivisions + 1,
            .mandelbrot_set_result = mandelbrot_set_result,
            .init = init,
        })},
    );

    const thread3 = try std.Thread.spawn(
        .{},
        partial_compute,
        .{@as(WorkerArgs, .{
            .x_start = subdivisions / 2,
            .x_end = subdivisions + 1,
            .y_start = 0,
            .y_end = subdivisions / 2,
            .mandelbrot_set_result = mandelbrot_set_result,
            .init = init,
        })},
    );

    const thread4 = try std.Thread.spawn(
        .{},
        partial_compute,
        .{@as(WorkerArgs, .{
            .x_start = subdivisions / 2,
            .x_end = subdivisions + 1,
            .y_start = subdivisions / 2,
            .y_end = subdivisions + 1,
            .mandelbrot_set_result = mandelbrot_set_result,
            .init = init,
        })},
    );

    std.Thread.join(thread1);
    std.Thread.join(thread2);
    std.Thread.join(thread3);
    std.Thread.join(thread4);

    const end_time = Io.Timestamp.now(init.io, .awake);
    return start_time.durationTo(end_time).toMilliseconds();
}

fn parallel_row_compute(num_threads: u8, init: std.process.Init, mandelbrot_set_result: *[subdivisions + 1][subdivisions + 1]u16) !i64 {
    var threads_list = std.ArrayList(std.Thread).empty;
    defer threads_list.deinit(init.gpa);
    var threads = try threads_list.addManyAsSlice(init.gpa, num_threads);

    std.debug.print("{any} threads\n", .{threads.len});
    const start_time = Io.Timestamp.now(init.io, .awake);
    for (0..num_threads) |i| {
        const start_row = @as(u16, @intCast(i)) * (subdivisions / @as(u16, num_threads));
        const end_row = @as(u16, @intCast(i + 1)) * (subdivisions / @as(u16, num_threads));
        threads[i] = try std.Thread.spawn(
            .{},
            partial_compute,
            .{@as(WorkerArgs, .{
                .thread_num = @as(u8, @intCast(i)),
                .x_start = start_row,
                .x_end = end_row,
                .y_start = 0,
                .y_end = subdivisions + 1,
                .mandelbrot_set_result = mandelbrot_set_result,
                .init = init,
            })},
        );
    }
    for (0..num_threads) |i| {
        threads[i].join();
    }
    const end_time = Io.Timestamp.now(init.io, .awake);
    return start_time.durationTo(end_time).toMicroseconds();
}

fn partial_compute(worker_args: WorkerArgs) void {
    const start_time = std.Io.Timestamp.now(worker_args.init.io, .awake);
    for (worker_args.x_start..worker_args.x_end) |i| {
        for (worker_args.y_start..worker_args.y_end) |j| {
            var z_re: f64 = 0;
            var z_im: f64 = 0;

            const c_re = range(@as(u32, @intCast(j)));
            const c_im = range(@as(u32, @intCast(i)));

            // The below are not independent
            for (0..max_iterations) |k| {
                if (std.math.sqrt(z_re * z_re + z_im * z_im) >= abs_bound) {
                    worker_args.mandelbrot_set_result[i][j] = @as(u16, @intCast(k));
                    break;
                }
                const z_re_new = z_re * z_re - z_im * z_im + c_re;
                const z_im_new = 2 * z_re * z_im + c_im;

                z_re = z_re_new;
                z_im = z_im_new;
            }
        }
    }
    const end_time = Io.Timestamp.now(worker_args.init.io, .awake);
    std.debug.print("[Thread {any}]: {d:.3} ms \n", .{ worker_args.thread_num, @as(f64, @floatFromInt(start_time.durationTo(end_time).toMicroseconds())) / 1000 });
}

fn save_render(init: std.process.Init, mandelbrot_set_result: *[subdivisions + 1][subdivisions + 1]u16) !void {
    // Create a file and store the content in ppm format
    var file_buffer: [1024]u8 = undefined;
    var save_file = try Io.Dir.cwd().createFile(init.io, "render/mandelbrot_render.ppm", .{});
    var file_writer = save_file.writer(init.io, &file_buffer);
    var writer_interface = &file_writer.interface;

    //Write PPM format
    _ = try writer_interface.print("P3\n", .{});
    _ = try writer_interface.print("{any} {any}\n", .{ subdivisions + 1, subdivisions + 1 });
    _ = try writer_interface.print("{d}\n", .{max_iterations});

    //Write the mandelbrot set
    for (0..subdivisions + 1) |i| {
        for (0..subdivisions + 1) |j| {
            _ = try writer_interface.print("{any} {any} {any}  ", .{ mandelbrot_set_result[i][j], mandelbrot_set_result[i][j], mandelbrot_set_result[i][j] });
            try writer_interface.flush();
        }
        _ = try writer_interface.print("\n", .{});
    }
    defer save_file.close(init.io);
}
