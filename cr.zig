const std = @import("std");

fn letterValue(c: u8) i32 {
    return @intCast(i32, c - 'a' + 1);
}

fn extractNumber(s: []const u8) i32 {
    var n: i32 = 0;
    var found = false;
    for (s) |c| {
        if (c >= '0' and c <= '9') {
            found = true;
            n = n * 10 + @intCast(i32, c - '0');
        }
    }
    return if (found) n else -1;
}

pub fn main() void {
    const cmd = "f(10)";

    const sum = letterValue(cmd[0]) + letterValue(cmd[2]);
    const number = extractNumber(cmd);

    if (sum == 6 and number >= 0) {
        std.debug.print("const result: i32 = {};\n", .{number});
    } else {
        std.debug.print("// BOX\n", .{});
    }
}
