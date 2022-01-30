Here is some info collected about the STM32F3DISCOVERY board,
specifically about the MB1035-F303C-E02 version.

# eCompass

It has a LSM303AGR, which is an
"Ultra-compact high-performance eCompass module:
ultra-low power 3D accelerometer and 3D magnetometer".

This is connected to the MCU via I2C1,
MCU ports PB6 + PB7 = I2C1\_SCL + I2C1\_SDA.

This device can also generate mouse-like click events.

# Gyroscope

It has an I3G4250D, which is a
"3-axis gyroscope for industrial applications, digital output,
extended operating temperature range".

MCU port PE3 = CS\_I2C/SPI controls whether
the device is in I2C or SPI mode (SPI=0, I2C=1).

(And SPI mode can be kept on permanently by
setting bit 0x20 to 1 in register 0x05, it seems.)

In I2C mode, MCU ports PA5 + PA7 = SCL + SDA.

In SPI mode, the ports are

- either 3-wire: MCU port PA5 + PA7 = SPC + SDI/SDO,

- or 4-wire: MCU port PA5 + PA7 + PA6 = SPC + SDI + SDO,

and the last wire is MCU port PE3 = CS\_I2C/SPI set to 0.

Switching SPI from the default 4-wire mode to 3-wire mode is done by
setting bit SIM (0x01) to 1 in register CTRL\_REG4 (0x23).

Separately from the I2C or SPI connection,
MCU ports PE0 + PE1 = INT1 + INT2/DRDY generate interrupts,
the first if X/Y/Z goes outside of configurable bounds,
the second configurable if data is available.
