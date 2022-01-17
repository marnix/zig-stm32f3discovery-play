const Builder = @import("std").build.Builder;
const builtin = @import("builtin");
const std = @import("std");

const microzig = @import("libs/microzig/src/main.zig");

pub fn build(b: *Builder) !void {
    // Standard release options allow the person running `zig build` to select
    // between Debug, ReleaseSafe, ReleaseFast, and ReleaseSmall.
    const mode = b.standardReleaseOptions();

    const elf = try microzig.addEmbeddedExecutable(
        b,
        "zig-stm32-blink.elf",
        "src/main.zig",
        microzig.Backing{ .board = microzig.boards.stm32f3discovery },
    );
    elf.setBuildMode(mode);
    elf.install();

    const bin = b.addInstallRaw(elf, "zig-stm32-blink.bin", .{});
    const bin_step = b.step("bin", "Generate binary file to be flashed");
    bin_step.dependOn(&bin.step);

    const flash_cmd = b.addSystemCommand(&[_][]const u8{
        "st-flash",
        "write",
        b.getInstallPath(bin.dest_dir, bin.dest_filename),
        "0x8000000",
    });
    flash_cmd.step.dependOn(&bin.step);
    const flash_step = b.step("flash", "Flash and run the app on your STM32F4Discovery");
    flash_step.dependOn(&flash_cmd.step);

    b.default_step.dependOn(&elf.step);
    b.installArtifact(elf);
}
