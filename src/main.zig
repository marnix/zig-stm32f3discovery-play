const std = @import("std");
const microzig = @import("microzig");
const abs = std.math.absCast;
const regs = microzig.chip.peripherals;
const uart = microzig.core.experimental.uart;
const spi = microzig.core.experimental.spi;

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

        return @This(){};
    }

    pub fn delayMs(_: @This(), n: u16) void {
        if (n == 0) return; // to avoid counting to 2**16

        // Set prescaler to roughly 1ms per count.
        // Here we assume TIM6 is running on an 8 MHz clock,
        // which it is by default after STM32F3DISCOVERY MCU reset.
        regs.TIM6.PSC.raw = 7999;
        regs.TIM6.EGR.modify(.{ .UG = 1 }); // so that PSC is picked up and CNT reset, sets UIF
        regs.TIM6.SR.modify(.{ .UIF = 0 }); // clear UIF

        // Set our value for TIM6 to count to.
        regs.TIM6.ARR.raw = n; // picked up directly as ARPE = 0 by default

        // Start the clock using CEN.
        regs.TIM6.CR1.modify(.{ .CEN = 1 });

        // Wait for TIM6 to set the status register.
        while (regs.TIM6.SR.read().UIF == 0) {}
    }

    pub fn click(_: @This()) void {
        regs.TIM6.PSC.raw = 1; // no scaling down, use clock frequency
        regs.TIM6.EGR.modify(.{ .UG = 1 }); // so that PSC is picked up and CNT reset, sets UIF
        regs.TIM6.SR.modify(.{ .UIF = 0 }); // clear UIF
        regs.TIM6.ARR.raw = 1; // picked up directly as ARPE = 0 by default
        regs.TIM6.CR1.modify(.{ .CEN = 1 });
        while (regs.TIM6.SR.read().UIF == 0) {}
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
        for (self._leds, 0..) |n, nr| {
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
    timer: TIM6Timer,
    debug_writer: uart.Uart(1, .{}).Writer = undefined,

    pub fn sleep(self: *@This(), ms: u16) void {
        self.timer.delayMs(ms);
    }

    pub fn debug(self: *@This(), comptime format: []const u8, args: anytype) !void {
        try self.debug_writer.print(format, args);
    }
};

pub fn main() !void {
    const timer = TIM6Timer.init();
    var leds = Leds.init();
    const uart1 = try uart.Uart(1, .{}).init(.{ .baud_rate = 460800 });
    var system = System{
        .leds = &leds,
        .timer = timer,
        .debug_writer = uart1.writer(),
    };
    try system.debug("\r\nMAIN START\r\n", .{});

    // try slowLed(&system);
    try heavyLed(&system);
    // try twoBumpingLeds(&system);
    // randomCompass(&system);
}

/// Auto-detect whether or not the gyro is in 3-wire / bidi / half-duplex mode.
///
/// Try to read the gyro's 0x0F register, with the SPI bus in both modes,
/// and choose the mode that gives the expected 0xD3 response.
///
/// This works because, if the device is in 4-wire = full-duplex mode,
/// it sends the response back on the MISO line;
/// while in 3-wire = bidi = half-duplex mode,
/// it sends the response back on the same SPI bus MOSI line
/// that the SPI bus used to send the 'read register 0x0F' request.
///
/// So reading a non-bidi response sent by a bidi device,
/// or reading a bidi response sent by a non-bidi device,
/// will both result in garbage that is very unlikely to be exactly 0xD3.
fn probeGyroBidiMode(gyro: anytype) !u1 {
    var who_am_is: [2]u8 = undefined;
    var spi1_bidi_mode = regs.SPI1.CR1.read().BIDIMODE;
    for ([_]u1{ 0, 1 }) |_| {
        who_am_is[spi1_bidi_mode] = try gyro.read_register(0x0F);
        spi1_bidi_mode = 1 - spi1_bidi_mode;
        regs.SPI1.CR1.modify(.{ .BIDIMODE = spi1_bidi_mode });
    }
    // TODO: check that exactly one of who_am_is is 0xD3.
    return @intFromBool(who_am_is[1] == 0xD3);
}

fn slowLed(system: *System) !void {
    const leds = system.leds;

    const spi1 = try spi.SpiBus(1).init(.{});
    var gyro = spi1.device(microzig.hal.parse_pin("PE3"), .{});

    try system.debug("--- switch SPI1 to the gyro's BIDI mode:\r\n", .{});
    const gyro_bidi_mode = try probeGyroBidiMode(gyro);
    try system.debug("setting SPI1 BIDIMODE={d} <= gyro SIM={d} <= gyro responses\r\n", .{ gyro_bidi_mode, gyro_bidi_mode });
    regs.SPI1.CR1.modify(.{ .BIDIMODE = gyro_bidi_mode });

    var gyro_id = try gyro.read_register(0x0F); // WHO_AM_I
    try system.debug("WHO_AM_I of gyroscope is {X:2}, should be D3.\r\n", .{gyro_id});

    if (gyro_id != 0xD3) return;

    // HERE WE MAKE THE ARBITRARY CHOICE TO TALK TO THE GYRO DEVICE IN BIDI MODE
    const use_bidi_mode = true;

    try system.debug("--- set SPI1 and gyro to BIDI mode? {}\r\n", .{use_bidi_mode});
    {
        const desired_mode = @intFromBool(use_bidi_mode);

        try system.debug("setting gyro SIM={d}\r\n", .{desired_mode});
        try gyro.write_register(0x23, (0x00 & 0xFE) | desired_mode);
        try system.debug("setting SPI1 BIDIMODE={d}\r\n", .{desired_mode});
        regs.SPI1.CR1.modify(.{ .BIDIMODE = desired_mode });

        try system.debug("BIDIMODE = {d}\r\n", .{regs.SPI1.CR1.read().BIDIMODE});
        try system.debug("gyro SIM mode = {d}\r\n", .{(try gyro.read_register(0x23)) & 0b1});
    }

    gyro_id = try gyro.read_register(0x0F); // WHO_AM_I
    try system.debug("WHO_AM_I of gyroscope is {X:2}, should be D3.\r\n", .{gyro_id});

    if (gyro_id != 0xD3) return;

    // set CTRL_REG1 (0x20) to 100 Hz with cutoff 12.5 (.DR==0b00, .BW=0b00),
    // power on (.PD==0b1),
    // Z/Y/X all enabled (.Zen==0, .Yen==.Xen==1)
    try gyro.write_register(0x20, 0b00_00_1_011);

    var current_led: ?u3 = null; // led initially off

    while (true) {
        // get gyroscope X / Y data:
        // read OUT_* registers: 4 registers starting with OUT_X_L (0x28)
        var out: [4]u8 = undefined;
        try gyro.read_registers(0x28, &out);
        const x: i16 = @as(i16, out[1]) << 8 | out[0];
        const y: i16 = @as(i16, out[3]) << 8 | out[2];
        if (false) {
            try system.debug("OUT_X = {:6}, OUT_Y = {:6}\r\n", .{ x, y });
            break;
        }

        // disable previous led
        if (current_led) |nr| leds.remove(nr);
        // enable the right led, here: the led opposite to the direction of rotation
        //
        // Note that for the I3G4250D gyroscope on the STM32F3DISCOVERY board,
        // the x-axis points east, y-axis north, and z-axis up;
        // counter-clockwise from the chip's POV is positive.
        //
        // Therefore enable
        // south if x > 0, north if x < 0,
        // east if y > 0, west if y < 0.
        const cutoff: i16 = 2000; // the max x/y/z value is +/- 2**15
        if (@as(i32, x) * x + @as(i32, y) * y < @as(i32, cutoff) * cutoff) {
            // (x,y) close to (0,0), so board is fairly stationary: all off
            current_led = null;
        } else {
            // find out which led on the compass rose to enable
            // Note that 70/169 is almost sqrt(2)-1 == tan(22.5 degrees).
            if (@as(u32, 169) * abs(x) < @as(u32, 70) * abs(y)) {
                // (x,y) within 22.5 degrees of y-axis
                current_led = if (y > 0) 3 else 7; // east or west
            } else if (@as(u32, 169) * abs(y) < @as(u32, 70) * abs(x)) {
                // (x,y) within 22.5 degrees of x-axis
                current_led = if (x > 0) 5 else 1; // south or north
            } else {
                if (y > 0) {
                    current_led = if (x > 0) 4 else 2; // south-east or north-east
                } else {
                    current_led = if (x > 0) 6 else 0; // south-west or north-west
                }
            }
        }
        if (current_led) |nr| leds.add(nr);
        leds.update();

        system.sleep(10);
    }
}

fn heavyLed(system: *System) !void {
    const leds = system.leds;

    leds.update(); //FIXME: This is needed to make things not block after the following I2C init() call?!?
    const i2c1 = try microzig.core.experimental.i2c.I2CController(1, .{}).init(.{ .target_speed = 100_000 });
    // STM32F3DISCOVERY board LSM303AGR accelerometer (I2C address 0b0011001)
    const xl = i2c1.device(0b0011001);

    // set CTRL_REG1 (0x20) to 100 Hz (.ODR==0b0101),
    // normal power mode (.LPen==1),
    // Y/X both enabled (.Zen==0, .Yen==.Xen==1)
    try xl.write_register(0x20, 0b01010011);

    var current_led: ?u3 = null; // led initially off

    while (true) {
        // get accelerometer X / Y data:
        // read OUT_* registers: 4 registers starting with OUT_X_L (0x28)
        var out: [4]u8 = undefined;
        try xl.read_registers(0x28, &out);

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
    var pqr = std.rand.DefaultPrng.init(42);
    var rng = pqr.random();

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
    return @min(b -% a, a -% b);
}

fn twoBumpingLeds(system: *System) !void {
    const leds = system.leds;

    var j: u3 = 0;
    var k: u3 = 0;
    leds.add(j);
    leds.add(k);

    leds.update(); //FIXME: This is needed to make things not block after the following I2C init() call?!?
    const i2c1 = try microzig.core.experimental.i2c.I2CController(1, .{}).init(.{ .target_speed = 100_000 });
    // STM32F3DISCOVERY board LSM303AGR accelerometer (I2C address 0b0011001)
    const xl = i2c1.device(0b0011001);
    // read device ID (0x33 == 51) from "register" WHO_AM_I_A (0x0F)
    const accelerometer_device_id = xl.read_register(0x0F);
    try system.debug("I2C1 device 0b0011001 device ID: {any} == 51 == 0x33\r\n", .{accelerometer_device_id});
    {
        // set CTRL_REG1 (0x20) to 100 Hz (.ODR==0b0101),
        // normal power mode (.LPen==1),
        // Z/Y/X all enabled (.Zen==.Yen==.Xen==1)
        var wt = try xl.start_transfer(.write);
        {
            defer wt.stop() catch {};
            try wt.writer().writeAll(&.{ 0x20, 0b01010111 });
        }
    }

    var pqr = std.rand.DefaultPrng.init(42);
    var rng = pqr.random();
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
        try xl.read_registers(0x28, &out);
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
