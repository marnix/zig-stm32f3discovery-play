[![Build with Zig master](https://github.com/marnix/zig-stm32f3discovery-play/workflows/Build%20with%20zig%20master/badge.svg?branch=zig-master)](https://github.com/marnix/zig-stm32f3discovery-play/actions?query=branch%3Azig-master)

_This branch assumes you use Zig master._

# Playing around with pure-Zig STM32F3DISCOVERY

Make LEDs blink, and hopefully more, on an STM32F3DISCOVERY board using only Zig (and a linker script).

The starting point was [rbino](https://github.com/rbino)'s
[zig-stm32-blink](https://github.com/rbino/zig-stm32-blink) written for the STM32F4DISCOVERY board.
See [rbino's blogpost](https://rbino.com/posts/zig-stm32-blink/) for a more thorough explanation of
what's going on.

Since then, this project has been updated to build on top of
[microzig](https://github.com/ZigEmbeddedGroup/microzig).

## Build

To build the ELF file just run:

```
zig build
```

## Flashing

The easiest way to flash the board is to install [`stlink`
tools](https://github.com/stlink-org/stlink). Most Linux distributions should have them in their
repos, the build system will try to use the `st-flash` program.

The command to flash the board is:

```
zig build flash
```

After flashing the board, as you tilt it,
you should see the LEDs following gravity.

# Ideas that I would like to explore

- Switch to an eventloop-like `async` based implementation,
  where there is for example
   * One 'process' for each led, or pattern of leds, going around the circle;
   * That process 'yields' and asks to be woken after a specific time;
   * A central data structure that stores, for each led,
     how many processes want it to be switched on.

- Explore how to have useful `test`s.
  Presumably the HAL layer of [microzig](https://github.com/ZigEmbeddedGroup/microzig)
  can help with this.

- How to use hardware timers and PWM (pulse width modulation)
  to set the leds '40% on', for example?

- How to let the STM32F3DISCOVERY board run at a faster speed,
  enabling the code that initially was in `systemInit()` in main.zig?

- (How) can std's event loop + `pub cons io_mode = .evented` be used?

- How can more of [microzig](https://github.com/ZigEmbeddedGroup/microzig) be used?

- Can I do my own panic handler, letting e.g. invert all leds at a regular interval?

- Try to do some more creative blinking.

- Try out the other hardware on the STM32F3DISCOVERY board,
  by using I2C and then SPI.
