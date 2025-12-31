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
    if (std.mem.indexOf(u8, str, "/") != null) {
        var parts = std.mem.split(u8, str, "/");
        const p = std.fmt.parseInt(i32, parts[0], 10) catch 0;
        const q = std.fmt.parseInt(i32, parts[1], 10) catch 1;
        return @intToFloat(f64, p)/@intToFloat(f64,q);
    }
    return std.fmt.parseFloat(f64,str,10) catch 0.0;
}

fn cot(x:f64) f64 {
    return 1.0 / math.tan(x);
}

fn meaning(sum: i32) []const u8 {
    return switch(sum){
        5 => "BOX",
        6 => "ZAHL",
        7 => "WINKEL",
        8 => "RAUM",
        else => "INVALID"
    };
}

pub fn main() void {
    const cmd = "d;h(3;1/2,cot(1/2);0,0,0;1,0,0;p1,p2)";
    const sum = letterValue(cmd[0]) + letterValue(cmd[2]);
    const num = extractNumber(cmd);

    std.debug.print("// Befehl: {s}\n", .{meaning(sum)});
    if (sum == 6) {
        std.debug.print("value: f64 = {f}\n", .{num});
    } else if (sum == 7) {
        std.debug.print("tan_theta: f64 = {f}\n", .{math.tan(num)});
        std.debug.print("cot_theta: f64 = {f}\n", .{cot(num)});
    } else if (sum == 8) {
        const dim_count: i32 = 3;
        const angles: [3]f64 = [3]f64{0.5, cot(0.5), math.pi/4};
        const points: [[3]f64] = [[3]f64{0,0,0}, [3]f64{1,0,0}, [3]f64{0,1,0}];
        const ids: [3][]const u8 = [_][]const u8{"p1","p2","p3"};

        std.debug.print("// RAUM: dim_count={d}\n", .{dim_count});
        for (angles) |angle, i| {
            std.debug.print("Angle {d}: tan={f} cot={f}\n", .{i+1, angle, cot(angle)});
            std.debug.print("Point {d}: ({f},{f},{f}) id={s}\n", .{i+1, points[i][0], points[i][1], points[i][2], ids[i]});
        }
    } else if (sum == 5) {
        std.debug.print("// BOX\n", .{});
    }
}/
