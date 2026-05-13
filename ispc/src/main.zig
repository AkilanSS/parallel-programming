const std = @import("std");
const Io = std.Io;

const ispc = @import("ispc");

extern fn simple(in: [*]const f32, vout: [*]f32, count: i32) callconv(.c) void;

pub fn main(init: std.process.Init) !void {
    const count: i32 = 100000;

    var vin = try init.gpa.alloc(f32, count);
    var vout = try init.gpa.alloc(f32, count);

    defer init.gpa.free(vin);
    defer init.gpa.free(vout);
    _ = &vout;
    _ = &vin;

    for (0..count) |i| {
        vin[i] = @as(f32, @floatFromInt(i));
    }

    simple(vin.ptr, vout.ptr, count);

    for (0..count) |i| {
        std.debug.print("{d}\n", .{vout[i]});
    }
}
