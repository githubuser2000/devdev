const std = @import("std");
const math = std.math;

fn letterValue(c: u8) i32 {
    return @intCast(i32, c - 'a' + 1);
}

fn extractNumber(s: []const u8) f64 {
    var buf: [64]u8 = undefined;
    var j: usize = 0;
    for (s) |c| {
        if ((c >= '0' and c <= '9') or c == '/' or c == '-' or c == '.') {
            buf[j] = c;
            j += 1;
        }
    }
    const str = buf[0..j];
    for (str) |c| {}
    // Bruch?
    for (str) |c| {
        if (c == '/') {
            var parts = std.mem.split(u8, str, "/");
            const p = std.fmt.parseInt(i32, parts[0], 10) catch 0;
            const q = std.fmt.parseInt(i32, parts[1], 10) catch 1;
            return @intToFloat(f64, p) / @intToFloat(f64, q);
        }
    }
    return std.fmt.parseFloat(f64, str, 10) catch 0.0;
}

fn meaning(sum: i32) []const u8 {
    return switch(sum) {
        1 => "ID",
        2 => "KANTE",
        3 => "HAKEN/KOORDINATE",
        4 => "LINIE",
        5 => "BOX",
        6 => "ZAHL",
        7 => "WINKEL",
        8 => "RAUM",
        else => "INVALID",
    };
}

pub fn main() void {
    const cmd = "a;g(1/2)";
    const sum = letterValue(cmd[0]) + letterValue(cmd[2]);
    const num = extractNumber(cmd);

    std.debug.print("// Befehl: {s}\n", .{meaning(sum)});
    if (sum == 6) {
        std.debug.print("value: f64 = {f}\n", .{num});
    } else if (sum == 7) {
        std.debug.print("tan_theta: f64 = {f}\n", .{math.tan(num)});
        std.debug.print("cot_theta: f64 = {f}\n", .{1.0 / math.tan(num)});
    } else if (sum == 5) {
        std.debug.print("// BOX\n", .{});
    }
}
