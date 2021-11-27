const regs = @import("registers.zig");

pub fn main() void {
    systemInit();

    // Enable GPIOE port
    regs.RCC.AHBENR.modify(.{ .IOPEEN = 1 });

    // Set all 8 LEDs to general purpose output
    regs.GPIOE.MODER.modify(.{ .MODER8 = 0b01 }); // top left, blue, LED 4
    regs.GPIOE.MODER.modify(.{ .MODER9 = 0b01 }); // top, red, LED 3
    regs.GPIOE.MODER.modify(.{ .MODER10 = 0b01 }); // top right, orange, LED 5
    regs.GPIOE.MODER.modify(.{ .MODER11 = 0b01 }); // right, green, LED 7
    regs.GPIOE.MODER.modify(.{ .MODER12 = 0b01 }); // bottom right, blue, LED 9
    regs.GPIOE.MODER.modify(.{ .MODER13 = 0b01 }); // bottom, red, LED 10
    regs.GPIOE.MODER.modify(.{ .MODER14 = 0b01 }); // bottom left, orange, LED 8
    regs.GPIOE.MODER.modify(.{ .MODER15 = 0b01 }); // left, green, LED 6

    // Set initial state: only top-left blue LED 4 = pin 8
    regs.GPIOE.BSRR.modify(.{ .BS8 = 1 });
    regs.GPIOE.BSRR.modify(.{ .BS9 = 0 });
    regs.GPIOE.BSRR.modify(.{ .BS10 = 0 });
    regs.GPIOE.BSRR.modify(.{ .BS11 = 0 });
    regs.GPIOE.BSRR.modify(.{ .BS12 = 0 });
    regs.GPIOE.BSRR.modify(.{ .BS13 = 0 });
    regs.GPIOE.BSRR.modify(.{ .BS14 = 0 });
    regs.GPIOE.BSRR.modify(.{ .BS15 = 0 });

    while (true) {
        // Read the LEDs state
        var leds_state = regs.GPIOE.ODR.read();
        // Set each LED output to its neighbor's state
        regs.GPIOE.ODR.modify(.{
            .ODR8 = leds_state.ODR15,
            .ODR9 = leds_state.ODR8,
            .ODR10 = leds_state.ODR9,
            .ODR11 = leds_state.ODR10,
            .ODR12 = leds_state.ODR11,
            .ODR13 = leds_state.ODR12,
            .ODR14 = leds_state.ODR13,
            .ODR15 = leds_state.ODR14,
        });

        // Sleep for some time
        var i: u32 = 0;
        while (i < 50000) {
            asm volatile ("nop");
            i += 1;
        }
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
