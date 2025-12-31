const std = @import("std");

pub fn main() void {
    const cmds = [_]struct {
        table1: []const u8,
        table2: []const u8,
        value: i32,
    }{
        .{ "a", "e", 10 },
        .{ "b", "d", 10 },
        .{ "c", "c", 10 },
        .{ "d", "b", 10 },
        .{ "e", "a", 10 },
    };

    for (cmds) |cmd| {
        std.debug.print("var result: i32 = {d}; // from {s};{s}\n", .{cmd.value, cmd.table1, cmd.table2});
    }
}
