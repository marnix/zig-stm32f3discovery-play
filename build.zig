const std = @import("std");
const stm32 = @import("stm32");

fn root() []const u8 {
    return comptime (std.fs.path.dirname(@src().file) orelse ".");
}
const build_root = root();

pub fn build(b: *std.Build) !void {
    const microzig = @import("microzig").init(b, "microzig");

    const firmware = microzig.addFirmware(b, .{
        .name = "zig-stm32f3discovery-play",
        .target = stm32.boards.stm32f3discovery,
        .optimize = b.standardOptimizeOption(.{ .preferred_optimize_mode = .ReleaseSmall }),
        .source_file = .{ .path = "src/main.zig" },
    });
    std.debug.assert(firmware.mz == microzig); // ...just a sanity check

    const install_step = microzig.addInstallFirmware(b, firmware, .{ .format = .bin });
    b.getInstallStep().dependOn(&install_step.step);

    const flash_cmd = b.addSystemCommand(&[_][]const u8{
        "st-flash",
        //"--reset",
        "--connect-under-reset",
        "write",
        b.getInstallPath(install_step.dir, install_step.dest_rel_path),
        "0x8000000",
    });
    flash_cmd.step.dependOn(&install_step.step);
    const flash_step = b.step("flash", "Flash and run the app on your STM32F3Discovery");
    flash_step.dependOn(&flash_cmd.step);
}
