// Serial Implementation of rendering mandelbrot_set

const std = @import("std");
const Io = std.Io;
const mandelbrot_set = @import("mandelbrot_set");

const a: comptime_float = -2;
const b: comptime_float = 2;
const subdivisions: comptime_int = 1000;

const max_iterations: comptime_int = 255;
const abs_bound = 10;

pub fn main(init: std.process.Init) !void {
    var mandelbrot_set_result: [subdivisions + 1][subdivisions + 1]u16 = [_][subdivisions + 1]u16{[_]u16{max_iterations} ** (subdivisions + 1)} ** (subdivisions + 1);
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

    // Create a file and store the content in ppm format
    var file_buffer: [1024]u8 = undefined;
    var save_file = try Io.Dir.cwd().createFile(init.io, "render/mandelbrot_serial.ppm", .{});
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
        }
        _ = try writer_interface.print("\n", .{});
    }
    defer save_file.close(init.io);
}

inline fn range(i: u32) f64 {
    const del: f64 = (b - a) / @as(f64, @floatFromInt(subdivisions));
    return a + del * @as(f64, @floatFromInt(i));
}
