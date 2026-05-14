const std = @import("std");
const Io = std.Io;

const ispc = @import("ispc");

const a: comptime_float = -2;
const b: comptime_float = 2;
const subdivisions: comptime_int = 1000;

const max_iterations: comptime_int = 255;

extern fn simple(in: [*]const f32, vout: [*]f32, count: i32) callconv(.c) void;
extern fn mandelbrot_set(result: [*][*]u32, a: f32, b: f32, subdivisions: u32) callconv(.c) void;

pub fn main(init: std.process.Init) !void {
    _ = init;
    var mandelbrot_set_result: [subdivisions + 1][subdivisions + 1]u32 = [_][subdivisions + 1]u32{[_]u32{max_iterations} ** (subdivisions + 1)} ** (subdivisions + 1);
    mandelbrot_set(&mandelbrot_set_result, a, b, subdivisions);
}
