const std = @import("std");

// Reuse compute_totients from the C code of problem 70
const p70 = @cImport({
    @cDefine("P72", {});
    @cInclude("p70.c");
});

pub fn main() !void {
    // Compute totients 1..1000000
    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena.deinit();

    const allocator = arena.allocator();
    const limit = 1000001;
    const totients = try allocator.alloc(c_uint, limit);

    p70.compute_totients(limit, @ptrCast(totients));

    // Per Gauss
    var sum: u64 = 0;
    for (totients[2..limit]) |t| {
        sum += t;
    }

    const stdout = std.io.getStdOut().writer();
    try stdout.print("{d}\n", .{sum});
}
