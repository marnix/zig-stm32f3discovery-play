Ideas:

- Use STM32F303.svd from Git submodule.

- Publish on GitHub.
  (Update README.md to match the actual content,
  referring to the starting point GitHub repository.)

- Build using GitHub actions.

- Switch to an eventloop-like `async` based implementation,
  where there is for example
   * One 'process' for each led, or pattern of leds, going around the circle;
   * That process 'yields' and asks to be woken after a specific time;
   * A central data structure that stores, for each led,
     how many processes want it to be switched on.

- How to use hardware timers and PWM (pulse width modulation)
  to set the leds '40% on', for example?

- How to let the STM32F3DISCOVERY board run at a faster speed,
  enabling the code in `systemInit()` again?

- (How) can std's event loop + `pub cons io_mode = .evented` be used?

- How can [microzig](https://github.com/ZigEmbeddedGroup/microzig) be used?

- Try to do some more creative blinking.

- Generate linker.ld based on https://github.com/libopencm3/libopencm3/tree/master/ld.
  (Perhaps as part of `zig build`? make libopencm3 a submodule probably.)

- What is the difference between the following registers on a GPIO port?
   * BSRR "GPIO port bit set/reset"
   * ODR "GPIO port output data register"

- Try out the other hardware on the STM32F3DISCOVERY board.
