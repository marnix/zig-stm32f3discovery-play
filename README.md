[![Build with Zig 0.9.0](https://github.com/marnix/zig-stm32f3discovery-play/workflows/Build%20with%20zig%200.9.x/badge.svg?branch=zig-0.9.x)](https://github.com/marnix/zig-stm32f3discovery-play/actions?query=branch%3Azig-0.9.x)

_This branch assumes you use Zig 0.9.0._

# Playing around with pure-Zig STM32F3DISCOVERY

Make LEDs blink, and hopefully more, on an STM32F3DISCOVERY board using only Zig (and a linker script).

The starting point was [rbino](https://github.com/rbino)'s
[zig-stm32-blink](https://github.com/rbino/zig-stm32-blink) written for the STM32F4DISCOVERY board.
See [rbino's blogpost](https://rbino.com/posts/zig-stm32-blink/) for a more thorough explanation of
what's going on.

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

## Notes

File `src/registers.zig` was generated using [rbino/svd4zig](https://github.com/rbino/svd4zig),
see the Git submodule, using
```bash
./svd2zig STM32F303.svd > src/registers.zig
```

File STM32F303.svd is from STMicroelectronics 'STM32F3 System View Description',
file STM32F3_svd_V1.2/STM32F303.svd from zip-file en.stm32f3_svd.zip
(current link:
https://www.st.com/content/ccc/resource/technical/ecad_models_and_symbols/svd/group0/3a/19/5a/05/37/a3/49/72/stm32f3_svd.zip/files/stm32f3_svd.zip/jcr:content/translations/en.stm32f3_svd.zip
).

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
  enabling the code in `systemInit()` again?

- (How) can std's event loop + `pub cons io_mode = .evented` be used?

- How can [microzig](https://github.com/ZigEmbeddedGroup/microzig) be used?

- Can I do my own panic handler, letting e.g. invert all leds at a regular interval?

- Try to do some more creative blinking.

- Generate `registers.zig` using `./svd2zig STM32F303.svd > src/registers.zig`
  using the svd4zig tool from the Git submodule,
  as part of `zig build`.

- Generate linker.ld based on https://github.com/libopencm3/libopencm3/tree/master/ld.
  (Perhaps as part of `zig build`? make libopencm3 a submodule probably.)

- Try out the other hardware on the STM32F3DISCOVERY board.
