const std = @import("std");
const microzig = @import("microzig");
const regs = microzig.chip.registers;
const Queue = std.queue.DEQueue;

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
};

pub fn main() void {
    const timer = TIM6Timer.init();
    var leds = Leds.init();
    var system = System{ .leds = &leds, .timer = timer };

    _ = system;
    leds.add(0);
    leds.update();

    // 0a. set USART1 clock speed
    // elsewhere, we've left all board reset defaults
    // The default USART1 clock is PCLK2, which is 8 MHz after reset,
    // because APB2 prescaler is /1 after reset:
    regs.RCC.CFGR.modify(.{ .PPRE2 = 0 });
    // 0b. enable the USART1 clock
    regs.RCC.APB2ENR.modify(.{ .USART1EN = 1 });
    // 0c. enable GPIOC clock (why needed?!?)
    regs.RCC.AHBENR.modify(.{ .IOPCEN = 1 });
    // 0d. set PC4+PC5 to alternate function 7, USART1_TX + USART1_RX
    regs.GPIOC.MODER.modify(.{ .MODER4 = 0b10, .MODER5 = 0b10 });
    regs.GPIOC.AFRL.modify(.{ .AFRL4 = 7, .AFRL5 = 7 });
    // 2. set word length to 8 data bits (must be before setting UE=1) (probably the default?)
    regs.USART1.CR1.modify(.{ .padding4 = 0, .M = 0 }); // padding4 = bit 28 = .M1 (.svd bug)
    // 2b. number of stop bits = 1 (default)
    regs.USART1.CR2.modify(.{ .STOP = 0b00 });
    // set baud rate
    const usartdiv: u16 = @divTrunc(microzig.board.cpu_frequency, 9600); // frequency = 8 MHz
    comptime std.debug.assert(usartdiv == 0x0341);
    comptime std.debug.assert(usartdiv >> 4 == 0x034);
    comptime std.debug.assert(usartdiv & ((1 << 4) - 1) == 0x1);
    regs.USART1.BRR.modify(.{ .DIV_Mantissa = usartdiv >> 4, .DIV_Fraction = usartdiv & ((1 << 4) - 1) });

    // set regs.USART1.CR1 to @as(u32, 0), somewhere above?
    // 1. enable USART1
    regs.USART1.CR1.modify(.{ .UE = 1 });

    regs.USART1.CR1.modify(.{ .TE = 1 });

    _ = system;
    leds.add(1);
    leds.update();

    var b = false;
    while (true) {
        regs.USART1.TDR.modify(.{ .TDR = 'x' });
        //while (regs.USART1.ISR.read().TC == 0) {}
        b = !b;
        if (b) leds.add(2) else leds.remove(2);
        leds.update();
        timer.delayMs(500);
    }

    if (false) {
        var debug_port = microzig.Uart(1).init(.{
            .baud_rate = 9600,
            .stop_bits = .one,
            .parity = null,
            .data_bits = .eight,
        }) catch |err| {
            leds.add(switch (err) {
                error.UnsupportedBaudRate => 4,
                error.UnsupportedParity => 5,
                error.UnsupportedParity => 6,
                error.UnsupportedWordSize => 7,
            });
            leds.update();

            microzig.hang();
        };

        _ = debug_port;
    }
    microzig.hang();

    //_ = async twoBumpingLeds(&system);
    //_ = async randomCompass(&system);
    //system.run();
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

        system.sleep(rng.uintLessThan(u16, 400));
    }
}

test {
    try std.testing.expectEqual(@as(u8, 0), distance(77, 77));
    try std.testing.expectEqual(@as(u8, 3), distance(12, 15));
    try std.testing.expectEqual(@as(u8, 4), distance(254, 2));
}
