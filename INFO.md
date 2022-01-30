Here is some info collected about the STM32F3DISCOVERY board,
specifically about the MB1035-F303C-E02 version.

# eCompass

It has a LSM303AGR, which is an
"Ultra-compact high-performance eCompass module:
ultra-low power 3D accelerometer and 3D magnetometer".

This is connected to the MCU via I2C1,
ports PB6 + PB7 = I2C1\_SCL + I2C1\_SDA.

This can generate mouse-like click events.

# Gyroscope

It has a I3G4250D, which is a
"3-axis gyroscope for industrial applications, digital output,
extended operating temperature range".

Port PE3 = CS\_I2C/SPI controls whether the device is in I2C or SPI mode
(SPI=0, I2C=1).

In I2C mode, ...

In SPI mode, This is connected to the MCU via SPI,
...,


Apparently separately from the I2C or SPI connection,
ports PE0 + PE01 = INT1 + INT2/DRDY.
