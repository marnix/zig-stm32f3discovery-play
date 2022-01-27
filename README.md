[![Build with Zig 0.9.0](https://github.com/marnix/zig-stm32f3discovery-play/workflows/Build%20with%20zig%200.9.x/badge.svg?branch=zig-0.9.x)](https://github.com/marnix/zig-stm32f3discovery-play/actions?query=branch%3Azig-0.9.x)

_This branch assumes you use Zig 0.9.0._

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

After flashing the board you should see two blinking lights running around in opposite directions.

# Ideas that I would like to explore

- Switch to an eventloop-like `async` based implementation,
  where there is for example
   * One 'process' for each led, or pattern of leds, going around the circle;
   * That process 'yields' and asks to be woken after a specific time;
   * A central data structure that stores, for each led,
     how many processes want it to be switched on.

- Explore how to have useful `test`s.
  This presumably requires some sort of HAL (hardware abstraction layer),
  which is what [microzig](https://github.com/ZigEmbeddedGroup/microzig) presumably provides.

- How to use std.debug or std.log or whatever
  to send information back to the host (Linux, Windows, ...)?

- How to use hardware timers and PWM (pulse width modulation)
  to set the leds '40% on', for example?

- How to let the STM32F3DISCOVERY board run at a faster speed,
  enabling the code that initially was in `systemInit()` in main.zig?

- (How) can std's event loop + `pub cons io_mode = .evented` be used?

- How can more of [microzig](https://github.com/ZigEmbeddedGroup/microzig) be used?

- Can I do my own panic handler, letting e.g. invert all leds at a regular interval?

- Try to do some more creative blinking.

- Try out the other hardware on the STM32F3DISCOVERY board.
