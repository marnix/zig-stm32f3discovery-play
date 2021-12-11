const std = @import("std");
const regs = @import("registers.zig");

pub const TIM6Timer = struct {
    pub fn init(_: @This()) void {
        // Enable TIM6.
        regs.RCC.APB1ENR.modify(.{ .TIM6EN = 1 });

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

    // Set initial state: only top-left blue LED 4 = pin 8
    regs.GPIOE.BSRR.modify(.{
        .BS8 = 0,
        .BS9 = 0,
        .BS10 = 0,
        .BS11 = 0,
        .BS12 = 0,
        .BS13 = 0,
        .BS14 = 0,
        .BS15 = 0,
    });

    var j: u3 = 0;
    var k: u3 = 0;

    var rng = std.rand.DefaultPrng.init(42).random;
    while (true) {
        while (true) {
            if (rng.boolean()) {
                j = if (j == 7) 0 else j + 1;
            } else {
                k = if (k == 0) 7 else k - 1;
            }
            if (j != k) break;
        }
        var leds: [8]u1 = .{ 0, 0, 0, 0, 0, 0, 0, 0 };
        leds[j] = 1;
        leds[k] = 1;
        // update the leds
        regs.GPIOE.ODR.modify(.{
            .ODR8 = leds[0],
            .ODR9 = leds[1],
            .ODR10 = leds[2],
            .ODR11 = leds[3],
            .ODR12 = leds[4],
            .ODR13 = leds[5],
            .ODR14 = leds[6],
            .ODR15 = leds[7],
        });

        // Sleep for some time
        timer.delayMs(1 + rng.uintLessThan(u16, 400));
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

    if (false) {
        // Enable HSI
        regs.RCC.CR.modify(.{ .HSION = 1 });

        // Wait for HSI ready
        while (regs.RCC.CR.read().HSIRDY != 1) {}

        // Select HSI as clock source
        regs.RCC.CFGR.modify(.{ .SW0 = 0, .SW1 = 0 });

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
