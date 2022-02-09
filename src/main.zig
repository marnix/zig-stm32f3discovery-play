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
        switch (nr) {
            0 => regs.GPIOE.BSRR.modify(.{ .BS8 = 1 }),
            1 => regs.GPIOE.BSRR.modify(.{ .BS9 = 1 }),
            2 => regs.GPIOE.BSRR.modify(.{ .BS10 = 1 }),
            3 => regs.GPIOE.BSRR.modify(.{ .BS11 = 1 }),
            4 => regs.GPIOE.BSRR.modify(.{ .BS12 = 1 }),
            5 => regs.GPIOE.BSRR.modify(.{ .BS13 = 1 }),
            6 => regs.GPIOE.BSRR.modify(.{ .BS14 = 1 }),
            7 => regs.GPIOE.BSRR.modify(.{ .BS15 = 1 }),
        }
    }
    pub fn remove(self: *@This(), nr: u3) void {
        self._leds[nr] -= 1;
        if (self._leds[nr] == 0) {
            switch (nr) {
                0 => regs.GPIOE.BRR.modify(.{ .BR8 = 1 }),
                1 => regs.GPIOE.BRR.modify(.{ .BR9 = 1 }),
                2 => regs.GPIOE.BRR.modify(.{ .BR10 = 1 }),
                3 => regs.GPIOE.BRR.modify(.{ .BR11 = 1 }),
                4 => regs.GPIOE.BRR.modify(.{ .BR12 = 1 }),
                5 => regs.GPIOE.BRR.modify(.{ .BR13 = 1 }),
                6 => regs.GPIOE.BRR.modify(.{ .BR14 = 1 }),
                7 => regs.GPIOE.BRR.modify(.{ .BR15 = 1 }),
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

    _ = async twoBumpingLeds(&system);
    system.run();
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

        const ms = rng.uintLessThan(u16, 400);
        try system.debug("sleeping for {} ms\r\n", .{ms});
        system.sleep(ms);
    }
}
