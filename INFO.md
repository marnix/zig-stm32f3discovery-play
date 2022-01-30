Here is some info collected about the STM32F3DISCOVERY board,
specifically about the MB1035-F303C-E02 version.

# eCompass

It has an LSM303AGR, which is an
"Ultra-compact high-performance eCompass module:
ultra-low power 3D accelerometer and 3D magnetometer".
It also detects mouse click like movements.

(Note that STM32F3DISCOVERY board versions D01 and older
have an LSM303DLHC instead.
At least the I2C and interrupt pin wiring is identical.)

This is connected to the MCU via I2C,
MCU ports PB6 + PB7 = I2C1\_SCL + I2C1\_SDA.

(The chip supports SPI, but the board disables that
by setting the CS\_XL and CS\_MAG pins to I2C=1 mode.)

The chip has 2 separate I2C devices:

- the accelerometer (XL, I2C address 0b0011001, ID 0x33);

- the magnetometer (MAG, I2C address 0b0011110, ID 0x40).

Separately from the I2C connection,
MCU ports PE4 + PE5 = INT1 + INT2 generate various configurable interrupts,
the first if data is available,
and both if click events occurred.

# Gyroscope

It has an I3G4250D, which is a
"3-axis gyroscope for industrial applications, digital output,
extended operating temperature range".

(Note that STM32F3DISCOVERY board versions D01 and older
have an L3GD20 instead.
At least the I2C, SPI, and interrupt pin wiring is identical.)

MCU port PE3 = CS\_I2C/SPI controls whether
the device is in I2C or SPI mode (SPI=0, I2C=1).

(And SPI mode can be kept on permanently by
setting bit 0x20 to 1 in SPI register 0x05, it seems.)

In I2C mode, MCU ports PA5 + PA7 = SCL + SDA.

(So this is a separate I2C connection from I2C1
which is used for the eCompass.)

In SPI mode, the ports are

- either 4-wire: MCU port PA5 + PA7 + PA6 = SPC + SDI + SDO,

- or 3-wire: MCU port PA5 + PA7 = SPC + SDI/SDO,

and the last wire is MCU port PE3 = CS\_I2C/SPI set to 0.

Switching SPI from the default 4-wire mode to 3-wire mode is done by
setting bit SIM (0x01) to 1 in SPI register CTRL\_REG4 (0x23).

Separately from the I2C or SPI connection,
MCU ports PE0 + PE1 = INT1 + INT2/DRDY generate various configurable interrupts,
the first if X/Y/Z goes outside of configurable bounds,
the second if data is available.
