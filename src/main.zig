const std = @import("std");
const microzig = @import("microzig");
const regs = microzig.chip.registers;

// this will instantiate microzig and pull in all dependencies
pub const panic = microzig.panic;

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
        regs.TIM6.PSC.modify(.{ .PSC = 7999 });

        return @This(){};
    }

    pub fn delayMs(_: @This(), n: u16) void {
        if (n == 0) return; // to avoid counting to 2**16

        // Set our value for TIM6 to count to.
        regs.TIM6.ARR.modify(.{ .ARR = n });

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
    debug_writer: microzig.Uart(1).Writer = undefined,

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
    const uart1 = try microzig.Uart(1).init(.{
        .baud_rate = 9600,
        .data_bits = .eight,
        .parity = null,
        .stop_bits = .one,
    });
    var system = System{
        .leds = &leds,
        .timer = timer,
        .debug_writer = uart1.writer(),
    };
    try system.debug("\r\nMAIN START\r\n", .{});

    if (true) {
        const registers = regs; // TODO inline

        // CONFIGURE I2C1
        // connected to APB1, MCU pins PB6 + PB7 = I2C1_SCL + I2C1_SDA,
        // if GPIO port B is configured for alternate function 4 for these PB pins.

        // 1. Enable the I2C CLOCK and GPIO CLOCK
        registers.RCC.APB1ENR.modify(.{ .I2C1EN = 1 });
        registers.RCC.AHBENR.modify(.{ .IOPBEN = 1 });
        try system.debug("I2C1 configuration step 1 complete\r\n", .{});

        // 2. Configure the I2C PINs for ALternate Functions
        // 	a) Select Alternate Function in MODER Register
        registers.GPIOB.MODER.modify(.{ .MODER6 = 0b10, .MODER7 = 0b10 });
        // 	b) Select Open Drain Output
        registers.GPIOB.OTYPER.modify(.{ .OT6 = 1, .OT7 = 1 });
        // 	c) Select High SPEED for the PINs
        registers.GPIOB.OSPEEDR.modify(.{ .OSPEEDR6 = 0b11, .OSPEEDR7 = 0b11 });
        // 	d) Select Pull-up for both the Pins
        registers.GPIOB.PUPDR.modify(.{ .PUPDR6 = 0b01, .PUPDR7 = 0b01 });
        // 	e) Configure the Alternate Function in AFR Register
        registers.GPIOB.AFRL.modify(.{ .AFRL6 = 4, .AFRL7 = 4 });
        try system.debug("I2C1 configuration step 2 complete\r\n", .{});

        // 3. Reset the I2C
        registers.I2C1.CR1.modify(.{ .PE = 0 });
        while (registers.I2C1.CR1.read().PE == 1) {}
        // DO NOT registers.RCC.APB1RSTR.modify(.{ .I2C1RST = 1 });
        try system.debug("I2C1 configuration step 3 complete\r\n", .{});

        // 4-6. Configure I2C1 timing, based on 8 MHz I2C clock, run at 100 kHz
        // (Not using https://controllerstech.com/stm32-i2c-configuration-using-registers/
        // but copying an example from the reference manual, RM0316 section 28.4.9.)
        registers.I2C1.TIMINGR.modify(.{
            .PRESC = 1,
            .SCLL = 0x13,
            .SCLH = 0xF,
            .SDADEL = 0x2,
            .SCLDEL = 0x4,
        });
        try system.debug("I2C1 configuration steps 4-6 complete\r\n", .{});

        // 7. Program the I2C_CR1 register to enable the peripheral
        registers.I2C1.CR1.modify(.{ .PE = 1 });
        try system.debug("I2C1 configuration step 7 complete\r\n", .{});

        // READ ACCELEROMETER (I2C address 0b0011001, device ID 0x33) WHO_AM_I_A (0x0F)

        // 1. Write 0x0F

        // As master, initiate write from accelerometer, 7 bit address, 1 byte
        registers.I2C1.CR2.modify(.{
            .ADD10 = 0,
            .SADD1 = 0b0011001,
            .RD_WRN = 0, // write
            .NBYTES = 1,
        });
        try system.debug("I2C1 prepared for write of 1 byte to 0b0011001\r\n", .{});

        // Communication START
        registers.I2C1.CR2.modify(.{ .START = 1 });
        try system.debug("I2C1 TXIS={}\r\n", .{registers.I2C1.ISR.read().TXIS});
        try system.debug("I2C1 STARTed\r\n", .{});
        try system.debug("I2C1 TXIS={}\r\n", .{registers.I2C1.ISR.read().TXIS});

        // Wait for data to be acknowledged
        while (registers.I2C1.ISR.read().TXIS == 0) {
            try system.debug("I2C1 waiting for ready to send (TXIS=0)\r\n", .{});
        }
        try system.debug("I2C1 ready to send (TXIS=1)\r\n", .{});

        // Write data byte 0x0F
        registers.I2C1.TXDR.modify(.{ .TXDATA = 0x0F });
        try system.debug("I2C1 TC={}\r\n", .{registers.I2C1.ISR.read().TC});
        try system.debug("I2C1 data written\r\n", .{});
        try system.debug("I2C1 TC={}\r\n", .{registers.I2C1.ISR.read().TC});
        while (registers.I2C1.ISR.read().TC == 0) {
            try system.debug("I2C1 waiting for data (TC=0)\r\n", .{});
        }

        // Communication STOP
        registers.I2C1.CR2.modify(.{ .STOP = 1 });

        // 2. Read byte

        // As master, initiate read from accelerometer, 7 bit address, 1 byte
        registers.I2C1.CR2.modify(.{
            .ADD10 = 0,
            .SADD1 = 0b0011001,
            .RD_WRN = 1, // read
            .NBYTES = 1,
        });
        try system.debug("I2C1 prepared for read of 1 byte from 0b0011001\r\n", .{});

        // Communication START
        registers.I2C1.CR2.modify(.{ .START = 1 });
        try system.debug("I2C1 RXNE={}\r\n", .{registers.I2C1.ISR.read().RXNE});
        try system.debug("I2C1 STARTed\r\n", .{});
        try system.debug("I2C1 RXNE={}\r\n", .{registers.I2C1.ISR.read().RXNE});

        // Wait for data to be received
        while (registers.I2C1.ISR.read().RXNE == 0) {
            try system.debug("I2C1 waiting for data (RXNE=0)\r\n", .{});
        }
        try system.debug("I2C1 data ready (RXNE=1)\r\n", .{});

        // Read data byte
        const accelerometer_device_id = registers.I2C1.RXDR.read().RXDATA;
        try system.debug("I2C1 data: {}\r\n", .{accelerometer_device_id}); // 51 == 0x33

        // Communication STOP
        registers.I2C1.CR2.modify(.{ .STOP = 1 });
    }

    _ = async twoBumpingLeds(&system);
    //_ = async randomCompass(&system);
    system.run();
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

fn twoBumpingLeds(system: *System) void {
    const leds = system.leds;

    var j: u3 = 0;
    var k: u3 = 0;
    leds.add(j);
    leds.add(k);

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

        const ms = rng.uintLessThan(u16, 400);
        try system.debug("sleeping for {} ms\r\n", .{ms});
        system.sleep(ms);
    }
}

test {
    try std.testing.expectEqual(@as(u8, 0), distance(77, 77));
    try std.testing.expectEqual(@as(u8, 3), distance(12, 15));
    try std.testing.expectEqual(@as(u8, 4), distance(254, 2));
}
