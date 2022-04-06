Here is some info collected about the STM32F3DISCOVERY board,
specifically about the MB1035-F303C-E02 version.

# MCU: STM32F303VCT6

# eCompass

This MCU has an LSM303AGR, which is an
"Ultra-compact high-performance eCompass module:
ultra-low power 3D accelerometer and 3D magnetometer".
It also detects mouse click like movements.

(Note that STM32F3DISCOVERY board versions D01 and older
have an LSM303DLHC instead.
At least the I2C and interrupt pin wiring is identical.)

This is connected to the MCU via I2C,
MCU pins PB6 + PB7 = I2C1\_SCL + I2C1\_SDA so bus I2C1,
if GPIO port B is configured for alternate function 4 for these PB pins.

(The chip supports SPI, but the board disables that
by setting the CS\_XL and CS\_MAG pins to I2C=1 mode.)

The chip has 2 separate I2C devices:

- the accelerometer (XL, I2C address 0b0011001, device ID 0x33);

- the magnetometer (MAG, I2C address 0b0011110, device ID 0x40).

See below about what information is exchanged with these devices via I2C or SPI,
using a concept of "registers".

Note that each of the two devices has its own set of registers,
but these do not share any register addresses,
and (slightly confusingly) these are documented in the same table in the datasheet:
0x00-0x3F (...\_A) are for the accelerometer, and
0x40-0x6F (...\_M) are for the magnetometer.

Separately from the I2C connection,
MCU pins PE4 + PE5 = INT1 + INT2 generate various configurable interrupts,
the first if data is available,
and both if click events occurred.
Assumption: No alternate function needed (AF0) for these PE pins.

# Gyroscope

This MCU has an I3G4250D, which is a
"3-axis gyroscope for industrial applications, digital output,
extended operating temperature range".

(Note that STM32F3DISCOVERY board versions D01 and older
have an L3GD20 instead.
At least the I2C, SPI, and interrupt pin wiring is identical.)

MCU pin PE3 = CS\_I2C/SPI controls whether
the device is in I2C or SPI mode (SPI=0, I2C=1).
Assumption: No alternate function needed (AF0) for this PE pin.

(And SPI mode can be kept on permanently by
setting bit 0x20 to 1 in SPI register 0x05, it seems.)

Both modes require GPIO port A alternate function 5, for the PA pins below.

In I2C mode, the device is driven via MCU pins PA5 + PA7 = SCL + SDA
(I2C address 0b110100x, where x = MCU pin PA6 = SDO, device ID 0xD3).

(So this is a separate I2C bus from I2C1
which is used for the eCompass chip's devices.)

In SPI mode, the SPI1 bus is used, and the ports are

- either 4-wire: MCU pin PA5 + PA7 + PA6 = SPC + SDI + SDO,

- or 3-wire: MCU pin PA5 + PA7 = SPC + SDI/SDO,

and the last wire is MCU pin PE3 = CS\_I2C/SPI set to 0
(already mentioned above).

Switching SPI from the default 4-wire mode to 3-wire mode is done by
setting bit SIM (0x01) to 1 in SPI register CTRL\_REG4 (0x23).

See below about what information is exchanged with this device via I2C or SPI,
using a concept of "registers".

Separately from the I2C or SPI connection,
MCU pins PE0 + PE1 = INT1 + INT2/DRDY generate various configurable interrupts,
the first if X/Y/Z goes outside of configurable bounds,
the second if data is available.
Assumption: No alternate function needed (AF0) for these PE pins.

# Notes

## Structure of the I2C and SPI communication

In I2C mode, these devices are accessed by writing a 7-bit "register" address
(with the high bit indicating 'auto-increment to next register'
allowing to write or read multiple registers in one stream),
and then

* either writing 1 or more bytes, one per register,

* or reading 1 or more bytes, one per register,
  then sending an I2C NMAK = NACK once sufficient bytes have been received,

and then an I2C STOP (or RESTART).

Something very similar is done in SPI mode.