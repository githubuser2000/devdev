const std = @import("std");
const math = std.math;

fn letterValue(c: u8) i32 {
    return @intCast(i32, c - 'a' + 1);
}

fn letterSumArray(s: []const u8) void {
    var first = true;
    std.debug.print("[", .{});
    for (s) |c| {
        if ((c >= 'a' and c <= 'z') or (c >= 'A' and c <= 'Z')) {
            if (!first) std.debug.print(", '+', ", .{});
            std.debug.print("{d}", .{letterValue(c)});
            first = false;
        }
    }
    std.debug.print("]\n", .{});
}

fn partitions(n: i32, arr: []i32, pos: usize) void {
    if (n == 0) {
        std.debug.print("[", .{});
        for (arr[0..pos]) |v, i| {
            if (i != 0) std.debug.print(", '+', ", .{});
            std.debug.print("{d}", .{v});
        }
        std.debug.print("]\n", .{});
        return;
    }
    for (i32(1)..=n) |i| {
        arr[pos] = i;
        partitions(n-i, arr, pos+1);
    }
}

fn specialFormula(n: i32) void {
    std.debug.print("[2, '*', {d}, '-', {d}]\n", .{n, n});
}

fn meaning(sum: i32) []const u8 {
    return switch(sum){
        1 => "BOX",
        6 => "ZAHL",
        7 => "WINKEL",
        9 => "RAUM",
        else => "ANDERE"
    };
}

fn printWinkel(a: i32, b: i32) void {
    std.debug.print("[1, '+', {d}, '+', {d}]\n", .{a,b});
}

fn printRaum(dim_count: i32, angles: []f64, points: [][]f64, ids: [][]const u8) void {
    std.debug.print("// RAUM: dim_count={d}\n", .{dim_count});
    for (angles) |angle, i| {
        std.debug.print("Angle {d}: {f}\n", .{i+1, angle});
        std.debug.print("Point {d}: ({f},{f},{f}) id={s}\n", .{i+1, points[i][0], points[i][1], points[i][2], ids[i]});
    }
}

pub fn main() void {
    const cmd = "abc";

    std.debug.print("// Buchstabenaufsummierung:\n", .{});
    letterSumArray(cmd);

    std.debug.print("// Alle Aufsummierungen von 3:\n", .{});
    var arr: [10]i32 = undefined;
    partitions(3, arr[0..], 0);

    std.debug.print("// Spezielle Formel für 9:\n", .{});
    specialFormula(9);

    std.debug.print("// Bedeutungen:\n", .{});
    for (1..=9) |s| {
        std.debug.print("Summe {d}: {s}\n", .{s, meaning(s)});
    }

    std.debug.print("// Beispiel WINKEL (Summe 7):\n", .{});
    printWinkel(2,3);

    std.debug.print("// Beispiel RAUM (Summe 9):\n", .{});
    const dim_count: i32 = 3;
    const angles: [3]f64 = [3]f64{0.5, math.pi/4, math.pi/6};
    const points: [[3]f64] = [[3]f64{0,0,0}, [3]f64{1,0,0}, [3]f64{0,1,0}];
    const ids: [_][]const u8 = [_][]const u8{"p1","p2","p3"};
    printRaum(dim_count, angles[0..], points[0..], ids);
}
