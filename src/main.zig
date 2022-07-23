const std = @import("std");
const microzig = @import("microzig");
const regs = microzig.chip.registers;

const abs = std.math.absCast;

pub const TIM6Timer = struct {
    pub fn init() @This() {
        // Enable TIM6.
        regs.RCC.APB1ENR.modify(.{ .TIM6EN = 1 });

        regs.TIM6.CR1.modify(.{
            // Disable counting, toggle it on when we need to when in OPM.
            .CEN = 0,
            // Configure to one-pulse mode
            .OPM = 1,
        });

        // Set prescaler to roughly 1ms per count.
        // Here we assume TIM6 is running on an 8 MHz clock,
        // which it is by default after STM32F3DISCOVERY MCU reset.
        regs.TIM6.PSC.raw = 7999;

        return @This(){};
    }

    pub fn delayMs(_: @This(), n: u16) void {
        if (n == 0) return; // to avoid counting to 2**16

        // Set our value for TIM6 to count to.
        regs.TIM6.ARR.raw = n;

        // Start the clock using CEN.
        regs.TIM6.CR1.modify(.{ .CEN = 1 });

        // Wait for TIM6 to set the status register.
        while (regs.TIM6.SR.read().UIF == 0) {}

        // Clear the status register.
        regs.TIM6.SR.modify(.{ .UIF = 0 });
    }
};

const Leds = struct {
    /// for each led, the 'number of times' it is switched on
    _leds: [8]usize,

    pub fn init() @This() {
        // Enable GPIOE port
        regs.RCC.AHBENR.modify(.{ .IOPEEN = 1 });

        // Set all 8 LEDs to general purpose output
        regs.GPIOE.MODER.modify(.{
            .MODER8 = 0b01, // top left, blue, LED 4
            .MODER9 = 0b01, // top, red, LED 3
            .MODER10 = 0b01, // top right, orange, LED 5
            .MODER11 = 0b01, // right, green, LED 7
            .MODER12 = 0b01, // bottom right, blue, LED 9
            .MODER13 = 0b01, // bottom, red, LED 10
            .MODER14 = 0b01, // bottom left, orange, LED 8
            .MODER15 = 0b01, // left, green, LED 6
        });

        var self = Leds{ ._leds = undefined };
        self.reset();
        return self;
    }

    pub fn reset(self: *@This()) void {
        self._leds = .{ 0, 0, 0, 0, 0, 0, 0, 0 };
        regs.GPIOE.BRR.modify(.{
            .BR8 = 1,
            .BR9 = 1,
            .BR10 = 1,
            .BR11 = 1,
            .BR12 = 1,
            .BR13 = 1,
            .BR14 = 1,
            .BR15 = 1,
        });
    }

    pub fn add(self: *@This(), nr: u3) void {
        self._leds[nr] += 1;
    }
    pub fn remove(self: *@This(), nr: u3) void {
        self._leds[nr] -= 1;
    }

    pub fn update(self: *@This()) void {
        for (self._leds) |n, nr| {
            if (n > 0) {
                switch (nr) {
                    0 => regs.GPIOE.BSRR.modify(.{ .BS8 = 1 }),
                    1 => regs.GPIOE.BSRR.modify(.{ .BS9 = 1 }),
                    2 => regs.GPIOE.BSRR.modify(.{ .BS10 = 1 }),
                    3 => regs.GPIOE.BSRR.modify(.{ .BS11 = 1 }),
                    4 => regs.GPIOE.BSRR.modify(.{ .BS12 = 1 }),
                    5 => regs.GPIOE.BSRR.modify(.{ .BS13 = 1 }),
                    6 => regs.GPIOE.BSRR.modify(.{ .BS14 = 1 }),
                    7 => regs.GPIOE.BSRR.modify(.{ .BS15 = 1 }),
                    else => unreachable,
                }
            } else {
                switch (nr) {
                    0 => regs.GPIOE.BRR.modify(.{ .BR8 = 1 }),
                    1 => regs.GPIOE.BRR.modify(.{ .BR9 = 1 }),
                    2 => regs.GPIOE.BRR.modify(.{ .BR10 = 1 }),
                    3 => regs.GPIOE.BRR.modify(.{ .BR11 = 1 }),
                    4 => regs.GPIOE.BRR.modify(.{ .BR12 = 1 }),
                    5 => regs.GPIOE.BRR.modify(.{ .BR13 = 1 }),
                    6 => regs.GPIOE.BRR.modify(.{ .BR14 = 1 }),
                    7 => regs.GPIOE.BRR.modify(.{ .BR15 = 1 }),
                    else => unreachable,
                }
            }
        }
    }

    pub fn has(self: *@This(), nr: u3) bool {
        return self._leds[nr] > 0;
    }
};

const System = struct {
    leds: *Leds,
    timer: *TIM6Timer,
    wait_time_ms: u16 = undefined,
    fp: anyframe = undefined,
    debug_writer: microzig.Uart(1, .{}).Writer = undefined,

    pub fn run(self: *@This()) noreturn {
        while (true) {
            self.timer.delayMs(self.wait_time_ms);
            resume self.fp;
        }
    }

    pub fn sleep(self: *@This(), ms: u16) void {
        self.wait_time_ms = ms;
        self.fp = @frame();
        suspend {}
    }

    pub fn debug(self: *@This(), comptime format: []const u8, args: anytype) !void {
        try self.debug_writer.print(format, args);
    }
};

pub fn main() !void {
    const timer = TIM6Timer.init();
    var leds = Leds.init();
    const uart1 = try microzig.Uart(1, .{}).init(.{ .baud_rate = 460800 });
    var system = System{
        .leds = &leds,
        .timer = timer,
        .debug_writer = uart1.writer(),
    };
    try system.debug("\r\nMAIN START\r\n", .{});

    _ = async heavyLed(&system);
    //_ = async twoBumpingLeds(&system);
    //_ = async randomCompass(&system);
    system.run();
}

fn heavyLed(system: *System) !void {
    const leds = system.leds;

    const i2c1 = try microzig.I2CController(1, .{}).init(.{ .target_speed = 100_000 });
    // STM32F3DISCOVERY board LSM303AGR accelerometer (I2C address 0b0011001)
    const xl = i2c1.device(0b0011001);

    // set CTRL_REG1 (0x20) to 100 Hz (.ODR==0b0101),
    // normal power mode (.LPen==1),
    // Y/X both enabled (.Zen==0, .Yen==.Xen==1)
    try xl.writeRegister(0x20, 0b01010011);

    var current_led: ?u3 = null; // led initially off

    while (true) {
        // get accelerometer X / Y data:
        // read OUT_* registers: 4 registers starting with OUT_X_L (0x28)
        var out: [4]u8 = undefined;
        try xl.readRegisters(0x28, &out);

        const x: i16 = @as(i16, out[1]) << 8 | out[0];
        const y: i16 = @as(i16, out[3]) << 8 | out[2];

        // disable previous led
        if (current_led) |nr| leds.remove(nr);
        // enable the right led
        // Note that for the LSM303AGR accelerometer on the STM32F3DISCOVERY board,
        // the x-axis points east, y-axis south, and z-axis down.
        const cutoff: i16 = 1000; // the max x/y/z value is around 18000 in practice
        if (@as(i32, x) * x + @as(i32, y) * y < @as(i32, cutoff) * cutoff) {
            // (x,y) close to (0,0), so board is close to horizontal: all off
            current_led = null;
        } else {
            // find out which led on the compass rose points down
            // Note that 70/169 is almost sqrt(2)-1 == tan(22.5 degrees).
            if (@as(u32, 169) * abs(y) < @as(u32, 70) * abs(x)) {
                // (x,y) within 22.5 degrees of x-axis
                current_led = if (x > 0) 3 else 7; // east or west
            } else if (@as(u32, 169) * abs(x) < @as(u32, 70) * abs(y)) {
                // (x,y) within 22.5 degrees of y-axis
                current_led = if (y > 0) 5 else 1; // south or north
            } else {
                if (x > 0) {
                    current_led = if (y > 0) 4 else 2; // south-east or north-east
                } else {
                    current_led = if (y > 0) 6 else 0; // south-west or north-west
                }
            }
        }
        if (current_led) |nr| leds.add(nr);
        leds.update();

        system.sleep(10);
    }
}

fn randomCompass(system: *System) void {
    const leds = system.leds;
    var rng = std.rand.DefaultPrng.init(42).random();

    const D = 24 + 1 * 16;

    var direction: u8 = 0;
    while (true) {
        var nr: u3 = 0;
        while (true) {
            if (distance(32 * @as(u8, nr), direction) <= D) {
                leds.add(nr);
            }
            nr +%= 1;
            if (nr == 0) break;
        }
        leds.update();
        system.sleep(150);
        nr = 0;
        while (true) {
            if (distance(32 * @as(u8, nr), direction) <= D) {
                leds.remove(nr);
            }
            nr +%= 1;
            if (nr == 0) break;
        }
        direction +%= rng.uintLessThan(u8, 60) -% 30;
    }
}

fn distance(a: anytype, b: @TypeOf(a)) @TypeOf(a) {
    return std.math.min(b -% a, a -% b);
}

fn twoBumpingLeds(system: *System) !void {
    const leds = system.leds;

    var j: u3 = 0;
    var k: u3 = 0;
    leds.add(j);
    leds.add(k);

    const i2c1 = try microzig.I2CController(1, .{}).init(.{ .target_speed = 100_000 });
    // STM32F3DISCOVERY board LSM303AGR accelerometer (I2C address 0b0011001)
    const xl = i2c1.device(0b0011001);
    // read device ID (0x33 == 51) from "register" WHO_AM_I_A (0x0F)
    const accelerometer_device_id = xl.readRegister(0x0F);
    try system.debug("I2C1 device 0b0011001 device ID: {} == 51 == 0x33\r\n", .{accelerometer_device_id});
    {
        // set CTRL_REG1 (0x20) to 100 Hz (.ODR==0b0101),
        // normal power mode (.LPen==1),
        // Z/Y/X all enabled (.Zen==.Yen==.Xen==1)
        var wt = try xl.startTransfer(.write);
        {
            defer wt.stop() catch {};
            try wt.writer().writeAll(&.{ 0x20, 0b01010111 });
        }
    }

    var rng = std.rand.DefaultPrng.init(42).random();
    while (true) {
        if (rng.boolean()) {
            leds.remove(j);
            while (true) {
                j = if (j == 7) 0 else j + 1;
                if (!leds.has(j)) break;
            }
            leds.add(j);
        } else {
            leds.remove(k);
            while (true) {
                k = if (k == 0) 7 else k - 1;
                if (!leds.has(k)) break;
            }
            leds.add(k);
        }
        leds.update();

        // get accelerometer X / Y / Z data:
        // read OUT_* registers: 6 registers starting with OUT_X_L (0x28)
        var out: [6]u8 = undefined;
        try xl.readRegisters(0x28, &out);
        try system.debug("I2C1 device 0b0011001 output: {any}\r\n", .{out});

        const ms = rng.uintLessThan(u16, 400);
        const x: i16 = @as(i16, out[1]) << 8 | out[0];
        const y: i16 = @as(i16, out[3]) << 8 | out[2];
        const z: i16 = @as(i16, out[5]) << 8 | out[4];
        try system.debug("I2C1 x={d:>6} y={d:>6} z={d:>6}\r\n", .{ x, y, z });

        try system.debug("sleeping for {} ms\r\n", .{ms});
        system.sleep(ms);
    }
}

test {
    try std.testing.expectEqual(@as(u8, 0), distance(77, 77));
    try std.testing.expectEqual(@as(u8, 3), distance(12, 15));
    try std.testing.expectEqual(@as(u8, 4), distance(254, 2));
}
