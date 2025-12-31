const std = @import("std");

fn letterValue(c: u8) i32 {
    return @intCast(i32, c - 'a' + 1);
}

fn letterSumArray(s: []const u8) void {
    var first = true;
    std.debug.print("[", .{});
    for (s) |c| {
        if (c >= 'a' and c <= 'z') or (c >= 'A' and c <= 'Z') {
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
}
