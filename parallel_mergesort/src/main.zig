const std = @import("std");
const Io = std.Io;

const parallel_mergesort = @import("parallel_mergesort");

const WorkerArgs = struct {
    arr: []u32,
    temp: []u32,
    depth: u8,
};

pub fn main(init: std.process.Init) !void {
    const seed: u64 = 67;
    var prng = std.Random.DefaultPrng.init(seed);
    const rand = prng.random();

    const len_args = try init.minimal.args.toSlice(init.arena.allocator());

    var arr = try gen_random_arr(try std.fmt.parseInt(u32, len_args[1], 10), u32, init.gpa, rand);
    var arr_parallel = try init.gpa.dupe(u32, arr);
    var temp = try init.gpa.alloc(u32, arr.len);
    defer init.gpa.free(arr);
    defer init.gpa.free(arr_parallel);
    defer init.gpa.free(temp);

    const start_time = std.Io.Clock.now(.real, init.io);
    mergesort(arr, temp);
    const end_time = std.Io.Clock.now(.real, init.io);
    const time_elapsed = start_time.durationTo(end_time).toNanoseconds();
    std.debug.print("Time taken: {d}\n", .{time_elapsed});

    const start_time_parallel = std.Io.Clock.now(.real, init.io);
    try parallel_sort(WorkerArgs{
        .arr = arr_parallel,
        .temp = temp,
        .depth = 5,
    });
    const end_time_parallel = std.Io.Clock.now(.real, init.io);
    const time_elapsed_parallel = start_time_parallel.durationTo(end_time_parallel).toNanoseconds();
    std.debug.print("Time taken: {d}\n", .{time_elapsed_parallel});
    _ = &temp;
    _ = &arr;
    _ = &arr_parallel;

    std.debug.print("Speedup: {d}\n", .{@as(f64, @floatFromInt(time_elapsed)) / @as(f64, @floatFromInt(time_elapsed_parallel))});
}

fn gen_random_arr(len: u32, T: type, gpa: std.mem.Allocator, random: std.Random) ![]T {
    var arr = try gpa.alloc(T, len);
    for (0..len) |i| {
        arr[i] = random.intRangeAtMost(T, 0, 30);
    }
    return arr;
}

fn merge(arr: []u32, temp: []u32, left: usize, mid: usize, right: usize) void {
    const left_arr = arr[left..mid];
    const right_arr = arr[mid..right];

    var i: usize = 0;
    var j: usize = 0;
    var k: usize = 0;

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

fn mergesort(arr: []u32, temp: []u32) void {
    if (arr.len <= 1) {
        return;
    }

    const left: usize = 0;
    const right: usize = arr.len;
    const mid: usize = left + (right - left) / 2;

    mergesort(arr[left..mid], temp);
    mergesort(arr[mid..right], temp);
    merge(arr, temp, left, mid, right);
}

fn parallel_sort(args: WorkerArgs) !void {
    if (args.arr.len <= 1024 or args.depth == 0) {
        mergesort(args.arr, args.temp);
        return;
    }

    const left: usize = 0;
    const right: usize = args.arr.len;
    const mid: usize = left + (right - left) / 2;

    var left_subtree = try std.Thread.spawn(
        .{},
        parallel_sort,
        .{@as(WorkerArgs, .{
            .arr = args.arr[left..mid],
            .temp = args.temp[left..mid],
            .depth = args.depth - 1,
        })},
    );
    try parallel_sort(.{
        .arr = args.arr[mid..right],
        .temp = args.temp[mid..right],
        .depth = args.depth - 1,
    });

    left_subtree.join();
    merge(args.arr, args.temp, left, mid, right);
}
