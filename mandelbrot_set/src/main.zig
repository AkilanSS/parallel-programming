const std = @import("std");
const Io = std.Io;
const mandelbrot_set = @import("mandelbrot_set");

const a: comptime_float = -2;
const b: comptime_float = 2;
const subdivisions: comptime_int = 1000;

const max_iterations: comptime_int = 255;
const abs_bound = 10;

const WorkerArgs = struct {
    x_start: u16,
    x_end: u16,
    y_start: u16,
    y_end: u16,

    mandelbrot_set_result: *[subdivisions + 1][subdivisions + 1]u16,
};

pub fn main(init: std.process.Init) !void {
    var mandelbrot_set_result: [subdivisions + 1][subdivisions + 1]u16 = [_][subdivisions + 1]u16{[_]u16{max_iterations} ** (subdivisions + 1)} ** (subdivisions + 1);

    const time_taken_serial = serial_compute(init, &mandelbrot_set_result);
    const time_taken_threads = parallel_compute1(init, &mandelbrot_set_result);
    std.debug.print("Time taken (Serial): {any} milliseconds\n", .{time_taken_serial});
    std.debug.print("Time taken (4 threads): {any} milliseconds\n", .{time_taken_threads});

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

/// Here we use 4 threads to parallelize conputation
fn parallel_compute1(init: std.process.Init, mandelbrot_set_result: *[subdivisions + 1][subdivisions + 1]u16) !i64 {
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
        })},
    );

    std.Thread.join(thread1);
    std.Thread.join(thread2);
    std.Thread.join(thread3);
    std.Thread.join(thread4);

    const end_time = Io.Timestamp.now(init.io, .awake);
    return start_time.durationTo(end_time).toMilliseconds();
}

fn partial_compute(worker_args: WorkerArgs) void {
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
