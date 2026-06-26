const std = @import("std");
const Io = std.Io;

const parallel_mergesort = @import("parallel_mergesort");

pub fn main(init: std.process.Init) !void {
    var arr = [_]u32{ 1, 3, 5, 7, 2, 4, 6, 8 };
    var temp = try init.gpa.alloc(u32, arr.len);
    defer init.gpa.free(temp);
    merge(&arr, temp, 0, 4, 8);
    _ = &temp;

    std.debug.print("{any}\n", .{arr});
}

fn merge(arr: []u32, temp: []u32, left: u32, mid: u32, right: u32) void {
    const left_arr = arr[left..mid];
    const right_arr = arr[mid..right];

    var i: u32 = 0;
    var j: u32 = 0;
    var k: u32 = 0;

    while (i < left_arr.len and j < right_arr.len) : (k += 1) {
        if (left_arr[i] <= right_arr[j]) {
            temp[k] = left_arr[i];
            i += 1;
        } else {
            temp[k] = right_arr[j];
            j += 1;
        }
    }

    while (i < left_arr.len) : (k += 1) {
        temp[k] = left_arr[i];
        i += 1;
    }

    while (j < right_arr.len) : (k += 1) {
        temp[k] = right_arr[j];
        j += 1;
    }

    for (left..right, 0..) |p, q| {
        arr[p] = temp[q];
    }
}
