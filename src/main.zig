const std = @import("std");
const regs = @import("registers.zig");

pub const TIM6Timer = struct {
    pub fn init(_: @This()) void {
        // Enable TIM6.
        regs.RCC.APB1ENR.modify(.{ .TIM6EN = 1 });

        // Below we assume TIM6 is running on an 8 MHz clock,
        // which it is by default after system reset:
        // HSI = 8 MHz is the SYSCLK after reset
        //  (but we set it in systemInit() regardless),
        // default AHB prescaler = /1 (= values 0..7):
        regs.RCC.CFGR.modify(.{ .HPRE = 0 });
        // so also HCLK = 8 MHz,
        // default APB1 prescaler = /2:
        regs.RCC.CFGR.modify(.{ .PPRE1 = 4 });
        // which causes an implicit factor *2,
        // so the result is 8 MHz.

        regs.TIM6.CR1.modify(.{
            // Disable counting, toggle it on when we need to when in OPM.
            .CEN = 0,
            // Configure to one-pulse mode
            .OPM = 1,
        });

        // Set prescaler to roughly 1ms per count.
        regs.TIM6.PSC.modify(.{ .PSC = 7999 });
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
    _leds: [8]usize,

    pub fn init() @This() {
        var self = Leds{ ._leds = undefined };
        return self;
    }

    pub fn add(self: *@This(), nr: u3) void {
        self._leds[nr] += 1;
        switch (nr) {
            0 => regs.GPIOE.BSRR.write(.{ .BS8 = 1 }),
            1 => regs.GPIOE.BSRR.write(.{ .BS9 = 1 }),
            2 => regs.GPIOE.BSRR.write(.{ .BS10 = 1 }),
            3 => regs.GPIOE.BSRR.write(.{ .BS11 = 1 }),
            4 => regs.GPIOE.BSRR.write(.{ .BS12 = 1 }),
            5 => regs.GPIOE.BSRR.write(.{ .BS13 = 1 }),
            6 => regs.GPIOE.BSRR.write(.{ .BS14 = 1 }),
            7 => regs.GPIOE.BSRR.write(.{ .BS15 = 1 }),
        }
    }
    pub fn remove(self: *@This(), nr: u3) void {
        self._leds[nr] -= 1;
        if (self._leds[nr] == 0) {
            switch (nr) {
                0 => regs.GPIOE.BRR.write(.{ .BR8 = 1 }),
                1 => regs.GPIOE.BRR.write(.{ .BR9 = 1 }),
                2 => regs.GPIOE.BRR.write(.{ .BR10 = 1 }),
                3 => regs.GPIOE.BRR.write(.{ .BR11 = 1 }),
                4 => regs.GPIOE.BRR.write(.{ .BR12 = 1 }),
                5 => regs.GPIOE.BRR.write(.{ .BR13 = 1 }),
                6 => regs.GPIOE.BRR.write(.{ .BR14 = 1 }),
                7 => regs.GPIOE.BRR.write(.{ .BR15 = 1 }),
            }
        }
    }

    pub fn has(self: *@This(), nr: u3) bool {
        return self._leds[nr] > 0;
    }
};

pub fn main() void {
    systemInit();

    const timer = TIM6Timer{};
    timer.init();

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

    var leds = Leds.init();

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

        // Sleep for some time
        timer.delayMs(rng.uintLessThan(u16, 400));
    }
}

fn systemInit() void {
    // This init does these things:
    // - Enables the FPU coprocessor
    // - Sets the external oscillator to achieve a clock frequency of 168MHz
    // - Sets the correct PLL prescalers for that clock frequency
    // - Enables the flash data and instruction cache and sets the correct latency for 168MHz

    // Enable FPU coprocessor
    // WARN: currently not supported in qemu, comment if testing it there
    regs.FPU_CPACR.CPACR.modify(.{ .CP = 0b11 });

    // Enable HSI
    regs.RCC.CR.modify(.{ .HSION = 1 });

    // Wait for HSI ready
    while (regs.RCC.CR.read().HSIRDY != 1) {}

    // Select HSI as clock source
    regs.RCC.CFGR.modify(.{ .SW = 0 });
    if (false) {

        // Enable external high-speed oscillator (HSE)
        regs.RCC.CR.modify(.{ .HSEON = 1 });

        // Wait for HSE ready
        while (regs.RCC.CR.read().HSERDY != 1) {}

        // Set prescalers for 168 MHz: HPRE = 0, PPRE1 = DIV_2, PPRE2 = DIV_4
        regs.RCC.CFGR.modify(.{ .HPRE = 0, .PPRE1 = 0b101, .PPRE2 = 0b100 });

        // Disable PLL before changing its configuration
        regs.RCC.CR.modify(.{ .PLLON = 0 });

        // Set PLL prescalers and HSE clock source
        // TODO: change the svd to expose prescalers as packed numbers instead of single bits
        regs.RCC.PLLCFGR.modify(.{
            .PLLSRC = 1,
            // PLLM = 8 = 0b001000
            .PLLM0 = 0,
            .PLLM1 = 0,
            .PLLM2 = 0,
            .PLLM3 = 1,
            .PLLM4 = 0,
            .PLLM5 = 0,
            // PLLN = 336 = 0b101010000
            .PLLN0 = 0,
            .PLLN1 = 0,
            .PLLN2 = 0,
            .PLLN3 = 0,
            .PLLN4 = 1,
            .PLLN5 = 0,
            .PLLN6 = 1,
            .PLLN7 = 0,
            .PLLN8 = 1,
            // PLLP = 2 = 0b10
            .PLLP0 = 0,
            .PLLP1 = 1,
            // PLLQ = 7 = 0b111
            .PLLQ0 = 1,
            .PLLQ1 = 1,
            .PLLQ2 = 1,
        });

        // Enable PLL
        regs.RCC.CR.modify(.{ .PLLON = 1 });

        // Wait for PLL ready
        while (regs.RCC.CR.read().PLLRDY != 1) {}

        // Enable flash data and instruction cache and set flash latency to 5 wait states
        regs.FLASH.ACR.modify(.{ .DCEN = 1, .ICEN = 1, .LATENCY = 5 });

        // Select PLL as clock source
        regs.RCC.CFGR.modify(.{ .SW1 = 1, .SW0 = 0 });

        // Wait for PLL selected as clock source
        var cfgr = regs.RCC.CFGR.read();
        while (cfgr.SWS1 != 1 and cfgr.SWS0 != 0) : (cfgr = regs.RCC.CFGR.read()) {}

        // Disable HSI
        regs.RCC.CR.modify(.{ .HSION = 0 });
    }
}
