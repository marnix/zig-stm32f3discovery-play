pub fn Register(comptime R: type) type {
    return RegisterRW(R, R);
}

pub fn RegisterRW(comptime Read: type, comptime Write: type) type {
    return struct {
        raw_ptr: *volatile u32,

        const Self = @This();

        pub fn init(address: usize) Self {
            return Self{ .raw_ptr = @intToPtr(*volatile u32, address) };
        }

        pub fn initRange(address: usize, comptime dim_increment: usize, comptime num_registers: usize) [num_registers]Self {
            var registers: [num_registers]Self = undefined;
            var i: usize = 0;
            while (i < num_registers) : (i += 1) {
                registers[i] = Self.init(address + (i * dim_increment));
            }
            return registers;
        }

        pub fn read(self: Self) Read {
            return @bitCast(Read, self.raw_ptr.*);
        }

        pub fn write(self: Self, value: Write) void {
            self.raw_ptr.* = @bitCast(u32, value);
        }

        pub fn modify(self: Self, new_value: anytype) void {
            if (Read != Write) {
                @compileError("Can't modify because read and write types for this register aren't the same.");
            }
            var old_value = self.read();
            const info = @typeInfo(@TypeOf(new_value));
            inline for (info.Struct.fields) |field| {
                @field(old_value, field.name) = @field(new_value, field.name);
            }
            self.write(old_value);
        }

        pub fn read_raw(self: Self) u32 {
            return self.raw_ptr.*;
        }

        pub fn write_raw(self: Self, value: u32) void {
            self.raw_ptr.* = value;
        }

        pub fn default_read_value(_: Self) Read {
            return Read{};
        }

        pub fn default_write_value(_: Self) Write {
            return Write{};
        }
    };
}

pub const device_name = "STM32F303";
pub const device_revision = "1.4";
pub const device_description = "STM32F303";

pub const cpu = struct {
    pub const name = "CM4";
    pub const revision = "r1p0";
    pub const endian = "little";
    pub const mpu_present = false;
    pub const fpu_present = false;
    pub const vendor_systick_config = false;
    pub const nvic_prio_bits = 3;
};

/// General-purpose I/Os
pub const GPIOA = struct {

const base_address = 0x48000000;
/// MODER
const MODER_val = packed struct {
/// MODER0 [0:1]
/// Port x configuration bits (y =
MODER0: u2 = 0,
/// MODER1 [2:3]
/// Port x configuration bits (y =
MODER1: u2 = 0,
/// MODER2 [4:5]
/// Port x configuration bits (y =
MODER2: u2 = 0,
/// MODER3 [6:7]
/// Port x configuration bits (y =
MODER3: u2 = 0,
/// MODER4 [8:9]
/// Port x configuration bits (y =
MODER4: u2 = 0,
/// MODER5 [10:11]
/// Port x configuration bits (y =
MODER5: u2 = 0,
/// MODER6 [12:13]
/// Port x configuration bits (y =
MODER6: u2 = 0,
/// MODER7 [14:15]
/// Port x configuration bits (y =
MODER7: u2 = 0,
/// MODER8 [16:17]
/// Port x configuration bits (y =
MODER8: u2 = 0,
/// MODER9 [18:19]
/// Port x configuration bits (y =
MODER9: u2 = 0,
/// MODER10 [20:21]
/// Port x configuration bits (y =
MODER10: u2 = 0,
/// MODER11 [22:23]
/// Port x configuration bits (y =
MODER11: u2 = 0,
/// MODER12 [24:25]
/// Port x configuration bits (y =
MODER12: u2 = 0,
/// MODER13 [26:27]
/// Port x configuration bits (y =
MODER13: u2 = 2,
/// MODER14 [28:29]
/// Port x configuration bits (y =
MODER14: u2 = 2,
/// MODER15 [30:31]
/// Port x configuration bits (y =
MODER15: u2 = 0,
};
/// GPIO port mode register
pub const MODER = Register(MODER_val).init(base_address + 0x0);

/// OTYPER
const OTYPER_val = packed struct {
/// OT0 [0:0]
/// Port x configuration bits (y =
OT0: u1 = 0,
/// OT1 [1:1]
/// Port x configuration bits (y =
OT1: u1 = 0,
/// OT2 [2:2]
/// Port x configuration bits (y =
OT2: u1 = 0,
/// OT3 [3:3]
/// Port x configuration bits (y =
OT3: u1 = 0,
/// OT4 [4:4]
/// Port x configuration bits (y =
OT4: u1 = 0,
/// OT5 [5:5]
/// Port x configuration bits (y =
OT5: u1 = 0,
/// OT6 [6:6]
/// Port x configuration bits (y =
OT6: u1 = 0,
/// OT7 [7:7]
/// Port x configuration bits (y =
OT7: u1 = 0,
/// OT8 [8:8]
/// Port x configuration bits (y =
OT8: u1 = 0,
/// OT9 [9:9]
/// Port x configuration bits (y =
OT9: u1 = 0,
/// OT10 [10:10]
/// Port x configuration bits (y =
OT10: u1 = 0,
/// OT11 [11:11]
/// Port x configuration bits (y =
OT11: u1 = 0,
/// OT12 [12:12]
/// Port x configuration bits (y =
OT12: u1 = 0,
/// OT13 [13:13]
/// Port x configuration bits (y =
OT13: u1 = 0,
/// OT14 [14:14]
/// Port x configuration bits (y =
OT14: u1 = 0,
/// OT15 [15:15]
/// Port x configuration bits (y =
OT15: u1 = 0,
/// unused [16:31]
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// GPIO port output type register
pub const OTYPER = Register(OTYPER_val).init(base_address + 0x4);

/// OSPEEDR
const OSPEEDR_val = packed struct {
/// OSPEEDR0 [0:1]
/// Port x configuration bits (y =
OSPEEDR0: u2 = 0,
/// OSPEEDR1 [2:3]
/// Port x configuration bits (y =
OSPEEDR1: u2 = 0,
/// OSPEEDR2 [4:5]
/// Port x configuration bits (y =
OSPEEDR2: u2 = 0,
/// OSPEEDR3 [6:7]
/// Port x configuration bits (y =
OSPEEDR3: u2 = 0,
/// OSPEEDR4 [8:9]
/// Port x configuration bits (y =
OSPEEDR4: u2 = 0,
/// OSPEEDR5 [10:11]
/// Port x configuration bits (y =
OSPEEDR5: u2 = 0,
/// OSPEEDR6 [12:13]
/// Port x configuration bits (y =
OSPEEDR6: u2 = 0,
/// OSPEEDR7 [14:15]
/// Port x configuration bits (y =
OSPEEDR7: u2 = 0,
/// OSPEEDR8 [16:17]
/// Port x configuration bits (y =
OSPEEDR8: u2 = 0,
/// OSPEEDR9 [18:19]
/// Port x configuration bits (y =
OSPEEDR9: u2 = 0,
/// OSPEEDR10 [20:21]
/// Port x configuration bits (y =
OSPEEDR10: u2 = 0,
/// OSPEEDR11 [22:23]
/// Port x configuration bits (y =
OSPEEDR11: u2 = 0,
/// OSPEEDR12 [24:25]
/// Port x configuration bits (y =
OSPEEDR12: u2 = 0,
/// OSPEEDR13 [26:27]
/// Port x configuration bits (y =
OSPEEDR13: u2 = 0,
/// OSPEEDR14 [28:29]
/// Port x configuration bits (y =
OSPEEDR14: u2 = 0,
/// OSPEEDR15 [30:31]
/// Port x configuration bits (y =
OSPEEDR15: u2 = 0,
};
/// GPIO port output speed
pub const OSPEEDR = Register(OSPEEDR_val).init(base_address + 0x8);

/// PUPDR
const PUPDR_val = packed struct {
/// PUPDR0 [0:1]
/// Port x configuration bits (y =
PUPDR0: u2 = 0,
/// PUPDR1 [2:3]
/// Port x configuration bits (y =
PUPDR1: u2 = 0,
/// PUPDR2 [4:5]
/// Port x configuration bits (y =
PUPDR2: u2 = 0,
/// PUPDR3 [6:7]
/// Port x configuration bits (y =
PUPDR3: u2 = 0,
/// PUPDR4 [8:9]
/// Port x configuration bits (y =
PUPDR4: u2 = 0,
/// PUPDR5 [10:11]
/// Port x configuration bits (y =
PUPDR5: u2 = 0,
/// PUPDR6 [12:13]
/// Port x configuration bits (y =
PUPDR6: u2 = 0,
/// PUPDR7 [14:15]
/// Port x configuration bits (y =
PUPDR7: u2 = 0,
/// PUPDR8 [16:17]
/// Port x configuration bits (y =
PUPDR8: u2 = 0,
/// PUPDR9 [18:19]
/// Port x configuration bits (y =
PUPDR9: u2 = 0,
/// PUPDR10 [20:21]
/// Port x configuration bits (y =
PUPDR10: u2 = 0,
/// PUPDR11 [22:23]
/// Port x configuration bits (y =
PUPDR11: u2 = 0,
/// PUPDR12 [24:25]
/// Port x configuration bits (y =
PUPDR12: u2 = 0,
/// PUPDR13 [26:27]
/// Port x configuration bits (y =
PUPDR13: u2 = 1,
/// PUPDR14 [28:29]
/// Port x configuration bits (y =
PUPDR14: u2 = 2,
/// PUPDR15 [30:31]
/// Port x configuration bits (y =
PUPDR15: u2 = 0,
};
/// GPIO port pull-up/pull-down
pub const PUPDR = Register(PUPDR_val).init(base_address + 0xc);

/// IDR
const IDR_val = packed struct {
/// IDR0 [0:0]
/// Port input data (y =
IDR0: u1 = 0,
/// IDR1 [1:1]
/// Port input data (y =
IDR1: u1 = 0,
/// IDR2 [2:2]
/// Port input data (y =
IDR2: u1 = 0,
/// IDR3 [3:3]
/// Port input data (y =
IDR3: u1 = 0,
/// IDR4 [4:4]
/// Port input data (y =
IDR4: u1 = 0,
/// IDR5 [5:5]
/// Port input data (y =
IDR5: u1 = 0,
/// IDR6 [6:6]
/// Port input data (y =
IDR6: u1 = 0,
/// IDR7 [7:7]
/// Port input data (y =
IDR7: u1 = 0,
/// IDR8 [8:8]
/// Port input data (y =
IDR8: u1 = 0,
/// IDR9 [9:9]
/// Port input data (y =
IDR9: u1 = 0,
/// IDR10 [10:10]
/// Port input data (y =
IDR10: u1 = 0,
/// IDR11 [11:11]
/// Port input data (y =
IDR11: u1 = 0,
/// IDR12 [12:12]
/// Port input data (y =
IDR12: u1 = 0,
/// IDR13 [13:13]
/// Port input data (y =
IDR13: u1 = 0,
/// IDR14 [14:14]
/// Port input data (y =
IDR14: u1 = 0,
/// IDR15 [15:15]
/// Port input data (y =
IDR15: u1 = 0,
/// unused [16:31]
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// GPIO port input data register
pub const IDR = Register(IDR_val).init(base_address + 0x10);

/// ODR
const ODR_val = packed struct {
/// ODR0 [0:0]
/// Port output data (y =
ODR0: u1 = 0,
/// ODR1 [1:1]
/// Port output data (y =
ODR1: u1 = 0,
/// ODR2 [2:2]
/// Port output data (y =
ODR2: u1 = 0,
/// ODR3 [3:3]
/// Port output data (y =
ODR3: u1 = 0,
/// ODR4 [4:4]
/// Port output data (y =
ODR4: u1 = 0,
/// ODR5 [5:5]
/// Port output data (y =
ODR5: u1 = 0,
/// ODR6 [6:6]
/// Port output data (y =
ODR6: u1 = 0,
/// ODR7 [7:7]
/// Port output data (y =
ODR7: u1 = 0,
/// ODR8 [8:8]
/// Port output data (y =
ODR8: u1 = 0,
/// ODR9 [9:9]
/// Port output data (y =
ODR9: u1 = 0,
/// ODR10 [10:10]
/// Port output data (y =
ODR10: u1 = 0,
/// ODR11 [11:11]
/// Port output data (y =
ODR11: u1 = 0,
/// ODR12 [12:12]
/// Port output data (y =
ODR12: u1 = 0,
/// ODR13 [13:13]
/// Port output data (y =
ODR13: u1 = 0,
/// ODR14 [14:14]
/// Port output data (y =
ODR14: u1 = 0,
/// ODR15 [15:15]
/// Port output data (y =
ODR15: u1 = 0,
/// unused [16:31]
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// GPIO port output data register
pub const ODR = Register(ODR_val).init(base_address + 0x14);

/// BSRR
const BSRR_val = packed struct {
/// BS0 [0:0]
/// Port x set bit y (y=
BS0: u1 = 0,
/// BS1 [1:1]
/// Port x set bit y (y=
BS1: u1 = 0,
/// BS2 [2:2]
/// Port x set bit y (y=
BS2: u1 = 0,
/// BS3 [3:3]
/// Port x set bit y (y=
BS3: u1 = 0,
/// BS4 [4:4]
/// Port x set bit y (y=
BS4: u1 = 0,
/// BS5 [5:5]
/// Port x set bit y (y=
BS5: u1 = 0,
/// BS6 [6:6]
/// Port x set bit y (y=
BS6: u1 = 0,
/// BS7 [7:7]
/// Port x set bit y (y=
BS7: u1 = 0,
/// BS8 [8:8]
/// Port x set bit y (y=
BS8: u1 = 0,
/// BS9 [9:9]
/// Port x set bit y (y=
BS9: u1 = 0,
/// BS10 [10:10]
/// Port x set bit y (y=
BS10: u1 = 0,
/// BS11 [11:11]
/// Port x set bit y (y=
BS11: u1 = 0,
/// BS12 [12:12]
/// Port x set bit y (y=
BS12: u1 = 0,
/// BS13 [13:13]
/// Port x set bit y (y=
BS13: u1 = 0,
/// BS14 [14:14]
/// Port x set bit y (y=
BS14: u1 = 0,
/// BS15 [15:15]
/// Port x set bit y (y=
BS15: u1 = 0,
/// BR0 [16:16]
/// Port x set bit y (y=
BR0: u1 = 0,
/// BR1 [17:17]
/// Port x reset bit y (y =
BR1: u1 = 0,
/// BR2 [18:18]
/// Port x reset bit y (y =
BR2: u1 = 0,
/// BR3 [19:19]
/// Port x reset bit y (y =
BR3: u1 = 0,
/// BR4 [20:20]
/// Port x reset bit y (y =
BR4: u1 = 0,
/// BR5 [21:21]
/// Port x reset bit y (y =
BR5: u1 = 0,
/// BR6 [22:22]
/// Port x reset bit y (y =
BR6: u1 = 0,
/// BR7 [23:23]
/// Port x reset bit y (y =
BR7: u1 = 0,
/// BR8 [24:24]
/// Port x reset bit y (y =
BR8: u1 = 0,
/// BR9 [25:25]
/// Port x reset bit y (y =
BR9: u1 = 0,
/// BR10 [26:26]
/// Port x reset bit y (y =
BR10: u1 = 0,
/// BR11 [27:27]
/// Port x reset bit y (y =
BR11: u1 = 0,
/// BR12 [28:28]
/// Port x reset bit y (y =
BR12: u1 = 0,
/// BR13 [29:29]
/// Port x reset bit y (y =
BR13: u1 = 0,
/// BR14 [30:30]
/// Port x reset bit y (y =
BR14: u1 = 0,
/// BR15 [31:31]
/// Port x reset bit y (y =
BR15: u1 = 0,
};
/// GPIO port bit set/reset
pub const BSRR = Register(BSRR_val).init(base_address + 0x18);

/// LCKR
const LCKR_val = packed struct {
/// LCK0 [0:0]
/// Port x lock bit y (y=
LCK0: u1 = 0,
/// LCK1 [1:1]
/// Port x lock bit y (y=
LCK1: u1 = 0,
/// LCK2 [2:2]
/// Port x lock bit y (y=
LCK2: u1 = 0,
/// LCK3 [3:3]
/// Port x lock bit y (y=
LCK3: u1 = 0,
/// LCK4 [4:4]
/// Port x lock bit y (y=
LCK4: u1 = 0,
/// LCK5 [5:5]
/// Port x lock bit y (y=
LCK5: u1 = 0,
/// LCK6 [6:6]
/// Port x lock bit y (y=
LCK6: u1 = 0,
/// LCK7 [7:7]
/// Port x lock bit y (y=
LCK7: u1 = 0,
/// LCK8 [8:8]
/// Port x lock bit y (y=
LCK8: u1 = 0,
/// LCK9 [9:9]
/// Port x lock bit y (y=
LCK9: u1 = 0,
/// LCK10 [10:10]
/// Port x lock bit y (y=
LCK10: u1 = 0,
/// LCK11 [11:11]
/// Port x lock bit y (y=
LCK11: u1 = 0,
/// LCK12 [12:12]
/// Port x lock bit y (y=
LCK12: u1 = 0,
/// LCK13 [13:13]
/// Port x lock bit y (y=
LCK13: u1 = 0,
/// LCK14 [14:14]
/// Port x lock bit y (y=
LCK14: u1 = 0,
/// LCK15 [15:15]
/// Port x lock bit y (y=
LCK15: u1 = 0,
/// LCKK [16:16]
/// Lok Key
LCKK: u1 = 0,
/// unused [17:31]
_unused17: u7 = 0,
_unused24: u8 = 0,
};
/// GPIO port configuration lock
pub const LCKR = Register(LCKR_val).init(base_address + 0x1c);

/// AFRL
const AFRL_val = packed struct {
/// AFRL0 [0:3]
/// Alternate function selection for port x
AFRL0: u4 = 0,
/// AFRL1 [4:7]
/// Alternate function selection for port x
AFRL1: u4 = 0,
/// AFRL2 [8:11]
/// Alternate function selection for port x
AFRL2: u4 = 0,
/// AFRL3 [12:15]
/// Alternate function selection for port x
AFRL3: u4 = 0,
/// AFRL4 [16:19]
/// Alternate function selection for port x
AFRL4: u4 = 0,
/// AFRL5 [20:23]
/// Alternate function selection for port x
AFRL5: u4 = 0,
/// AFRL6 [24:27]
/// Alternate function selection for port x
AFRL6: u4 = 0,
/// AFRL7 [28:31]
/// Alternate function selection for port x
AFRL7: u4 = 0,
};
/// GPIO alternate function low
pub const AFRL = Register(AFRL_val).init(base_address + 0x20);

/// AFRH
const AFRH_val = packed struct {
/// AFRH8 [0:3]
/// Alternate function selection for port x
AFRH8: u4 = 0,
/// AFRH9 [4:7]
/// Alternate function selection for port x
AFRH9: u4 = 0,
/// AFRH10 [8:11]
/// Alternate function selection for port x
AFRH10: u4 = 0,
/// AFRH11 [12:15]
/// Alternate function selection for port x
AFRH11: u4 = 0,
/// AFRH12 [16:19]
/// Alternate function selection for port x
AFRH12: u4 = 0,
/// AFRH13 [20:23]
/// Alternate function selection for port x
AFRH13: u4 = 0,
/// AFRH14 [24:27]
/// Alternate function selection for port x
AFRH14: u4 = 0,
/// AFRH15 [28:31]
/// Alternate function selection for port x
AFRH15: u4 = 0,
};
/// GPIO alternate function high
pub const AFRH = Register(AFRH_val).init(base_address + 0x24);

/// BRR
const BRR_val = packed struct {
/// BR0 [0:0]
/// Port x Reset bit y
BR0: u1 = 0,
/// BR1 [1:1]
/// Port x Reset bit y
BR1: u1 = 0,
/// BR2 [2:2]
/// Port x Reset bit y
BR2: u1 = 0,
/// BR3 [3:3]
/// Port x Reset bit y
BR3: u1 = 0,
/// BR4 [4:4]
/// Port x Reset bit y
BR4: u1 = 0,
/// BR5 [5:5]
/// Port x Reset bit y
BR5: u1 = 0,
/// BR6 [6:6]
/// Port x Reset bit y
BR6: u1 = 0,
/// BR7 [7:7]
/// Port x Reset bit y
BR7: u1 = 0,
/// BR8 [8:8]
/// Port x Reset bit y
BR8: u1 = 0,
/// BR9 [9:9]
/// Port x Reset bit y
BR9: u1 = 0,
/// BR10 [10:10]
/// Port x Reset bit y
BR10: u1 = 0,
/// BR11 [11:11]
/// Port x Reset bit y
BR11: u1 = 0,
/// BR12 [12:12]
/// Port x Reset bit y
BR12: u1 = 0,
/// BR13 [13:13]
/// Port x Reset bit y
BR13: u1 = 0,
/// BR14 [14:14]
/// Port x Reset bit y
BR14: u1 = 0,
/// BR15 [15:15]
/// Port x Reset bit y
BR15: u1 = 0,
/// unused [16:31]
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// Port bit reset register
pub const BRR = Register(BRR_val).init(base_address + 0x28);
};

/// General-purpose I/Os
pub const GPIOB = struct {

const base_address = 0x48000400;
/// MODER
const MODER_val = packed struct {
/// MODER0 [0:1]
/// Port x configuration bits (y =
MODER0: u2 = 0,
/// MODER1 [2:3]
/// Port x configuration bits (y =
MODER1: u2 = 0,
/// MODER2 [4:5]
/// Port x configuration bits (y =
MODER2: u2 = 0,
/// MODER3 [6:7]
/// Port x configuration bits (y =
MODER3: u2 = 0,
/// MODER4 [8:9]
/// Port x configuration bits (y =
MODER4: u2 = 0,
/// MODER5 [10:11]
/// Port x configuration bits (y =
MODER5: u2 = 0,
/// MODER6 [12:13]
/// Port x configuration bits (y =
MODER6: u2 = 0,
/// MODER7 [14:15]
/// Port x configuration bits (y =
MODER7: u2 = 0,
/// MODER8 [16:17]
/// Port x configuration bits (y =
MODER8: u2 = 0,
/// MODER9 [18:19]
/// Port x configuration bits (y =
MODER9: u2 = 0,
/// MODER10 [20:21]
/// Port x configuration bits (y =
MODER10: u2 = 0,
/// MODER11 [22:23]
/// Port x configuration bits (y =
MODER11: u2 = 0,
/// MODER12 [24:25]
/// Port x configuration bits (y =
MODER12: u2 = 0,
/// MODER13 [26:27]
/// Port x configuration bits (y =
MODER13: u2 = 0,
/// MODER14 [28:29]
/// Port x configuration bits (y =
MODER14: u2 = 0,
/// MODER15 [30:31]
/// Port x configuration bits (y =
MODER15: u2 = 0,
};
/// GPIO port mode register
pub const MODER = Register(MODER_val).init(base_address + 0x0);

/// OTYPER
const OTYPER_val = packed struct {
/// OT0 [0:0]
/// Port x configuration bit 0
OT0: u1 = 0,
/// OT1 [1:1]
/// Port x configuration bit 1
OT1: u1 = 0,
/// OT2 [2:2]
/// Port x configuration bit 2
OT2: u1 = 0,
/// OT3 [3:3]
/// Port x configuration bit 3
OT3: u1 = 0,
/// OT4 [4:4]
/// Port x configuration bit 4
OT4: u1 = 0,
/// OT5 [5:5]
/// Port x configuration bit 5
OT5: u1 = 0,
/// OT6 [6:6]
/// Port x configuration bit 6
OT6: u1 = 0,
/// OT7 [7:7]
/// Port x configuration bit 7
OT7: u1 = 0,
/// OT8 [8:8]
/// Port x configuration bit 8
OT8: u1 = 0,
/// OT9 [9:9]
/// Port x configuration bit 9
OT9: u1 = 0,
/// OT10 [10:10]
/// Port x configuration bit
OT10: u1 = 0,
/// OT11 [11:11]
/// Port x configuration bit
OT11: u1 = 0,
/// OT12 [12:12]
/// Port x configuration bit
OT12: u1 = 0,
/// OT13 [13:13]
/// Port x configuration bit
OT13: u1 = 0,
/// OT14 [14:14]
/// Port x configuration bit
OT14: u1 = 0,
/// OT15 [15:15]
/// Port x configuration bit
OT15: u1 = 0,
/// unused [16:31]
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// GPIO port output type register
pub const OTYPER = Register(OTYPER_val).init(base_address + 0x4);

/// OSPEEDR
const OSPEEDR_val = packed struct {
/// OSPEEDR0 [0:1]
/// Port x configuration bits (y =
OSPEEDR0: u2 = 0,
/// OSPEEDR1 [2:3]
/// Port x configuration bits (y =
OSPEEDR1: u2 = 0,
/// OSPEEDR2 [4:5]
/// Port x configuration bits (y =
OSPEEDR2: u2 = 0,
/// OSPEEDR3 [6:7]
/// Port x configuration bits (y =
OSPEEDR3: u2 = 0,
/// OSPEEDR4 [8:9]
/// Port x configuration bits (y =
OSPEEDR4: u2 = 0,
/// OSPEEDR5 [10:11]
/// Port x configuration bits (y =
OSPEEDR5: u2 = 0,
/// OSPEEDR6 [12:13]
/// Port x configuration bits (y =
OSPEEDR6: u2 = 0,
/// OSPEEDR7 [14:15]
/// Port x configuration bits (y =
OSPEEDR7: u2 = 0,
/// OSPEEDR8 [16:17]
/// Port x configuration bits (y =
OSPEEDR8: u2 = 0,
/// OSPEEDR9 [18:19]
/// Port x configuration bits (y =
OSPEEDR9: u2 = 0,
/// OSPEEDR10 [20:21]
/// Port x configuration bits (y =
OSPEEDR10: u2 = 0,
/// OSPEEDR11 [22:23]
/// Port x configuration bits (y =
OSPEEDR11: u2 = 0,
/// OSPEEDR12 [24:25]
/// Port x configuration bits (y =
OSPEEDR12: u2 = 0,
/// OSPEEDR13 [26:27]
/// Port x configuration bits (y =
OSPEEDR13: u2 = 0,
/// OSPEEDR14 [28:29]
/// Port x configuration bits (y =
OSPEEDR14: u2 = 0,
/// OSPEEDR15 [30:31]
/// Port x configuration bits (y =
OSPEEDR15: u2 = 0,
};
/// GPIO port output speed
pub const OSPEEDR = Register(OSPEEDR_val).init(base_address + 0x8);

/// PUPDR
const PUPDR_val = packed struct {
/// PUPDR0 [0:1]
/// Port x configuration bits (y =
PUPDR0: u2 = 0,
/// PUPDR1 [2:3]
/// Port x configuration bits (y =
PUPDR1: u2 = 0,
/// PUPDR2 [4:5]
/// Port x configuration bits (y =
PUPDR2: u2 = 0,
/// PUPDR3 [6:7]
/// Port x configuration bits (y =
PUPDR3: u2 = 0,
/// PUPDR4 [8:9]
/// Port x configuration bits (y =
PUPDR4: u2 = 0,
/// PUPDR5 [10:11]
/// Port x configuration bits (y =
PUPDR5: u2 = 0,
/// PUPDR6 [12:13]
/// Port x configuration bits (y =
PUPDR6: u2 = 0,
/// PUPDR7 [14:15]
/// Port x configuration bits (y =
PUPDR7: u2 = 0,
/// PUPDR8 [16:17]
/// Port x configuration bits (y =
PUPDR8: u2 = 0,
/// PUPDR9 [18:19]
/// Port x configuration bits (y =
PUPDR9: u2 = 0,
/// PUPDR10 [20:21]
/// Port x configuration bits (y =
PUPDR10: u2 = 0,
/// PUPDR11 [22:23]
/// Port x configuration bits (y =
PUPDR11: u2 = 0,
/// PUPDR12 [24:25]
/// Port x configuration bits (y =
PUPDR12: u2 = 0,
/// PUPDR13 [26:27]
/// Port x configuration bits (y =
PUPDR13: u2 = 0,
/// PUPDR14 [28:29]
/// Port x configuration bits (y =
PUPDR14: u2 = 0,
/// PUPDR15 [30:31]
/// Port x configuration bits (y =
PUPDR15: u2 = 0,
};
/// GPIO port pull-up/pull-down
pub const PUPDR = Register(PUPDR_val).init(base_address + 0xc);

/// IDR
const IDR_val = packed struct {
/// IDR0 [0:0]
/// Port input data (y =
IDR0: u1 = 0,
/// IDR1 [1:1]
/// Port input data (y =
IDR1: u1 = 0,
/// IDR2 [2:2]
/// Port input data (y =
IDR2: u1 = 0,
/// IDR3 [3:3]
/// Port input data (y =
IDR3: u1 = 0,
/// IDR4 [4:4]
/// Port input data (y =
IDR4: u1 = 0,
/// IDR5 [5:5]
/// Port input data (y =
IDR5: u1 = 0,
/// IDR6 [6:6]
/// Port input data (y =
IDR6: u1 = 0,
/// IDR7 [7:7]
/// Port input data (y =
IDR7: u1 = 0,
/// IDR8 [8:8]
/// Port input data (y =
IDR8: u1 = 0,
/// IDR9 [9:9]
/// Port input data (y =
IDR9: u1 = 0,
/// IDR10 [10:10]
/// Port input data (y =
IDR10: u1 = 0,
/// IDR11 [11:11]
/// Port input data (y =
IDR11: u1 = 0,
/// IDR12 [12:12]
/// Port input data (y =
IDR12: u1 = 0,
/// IDR13 [13:13]
/// Port input data (y =
IDR13: u1 = 0,
/// IDR14 [14:14]
/// Port input data (y =
IDR14: u1 = 0,
/// IDR15 [15:15]
/// Port input data (y =
IDR15: u1 = 0,
/// unused [16:31]
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// GPIO port input data register
pub const IDR = Register(IDR_val).init(base_address + 0x10);

/// ODR
const ODR_val = packed struct {
/// ODR0 [0:0]
/// Port output data (y =
ODR0: u1 = 0,
/// ODR1 [1:1]
/// Port output data (y =
ODR1: u1 = 0,
/// ODR2 [2:2]
/// Port output data (y =
ODR2: u1 = 0,
/// ODR3 [3:3]
/// Port output data (y =
ODR3: u1 = 0,
/// ODR4 [4:4]
/// Port output data (y =
ODR4: u1 = 0,
/// ODR5 [5:5]
/// Port output data (y =
ODR5: u1 = 0,
/// ODR6 [6:6]
/// Port output data (y =
ODR6: u1 = 0,
/// ODR7 [7:7]
/// Port output data (y =
ODR7: u1 = 0,
/// ODR8 [8:8]
/// Port output data (y =
ODR8: u1 = 0,
/// ODR9 [9:9]
/// Port output data (y =
ODR9: u1 = 0,
/// ODR10 [10:10]
/// Port output data (y =
ODR10: u1 = 0,
/// ODR11 [11:11]
/// Port output data (y =
ODR11: u1 = 0,
/// ODR12 [12:12]
/// Port output data (y =
ODR12: u1 = 0,
/// ODR13 [13:13]
/// Port output data (y =
ODR13: u1 = 0,
/// ODR14 [14:14]
/// Port output data (y =
ODR14: u1 = 0,
/// ODR15 [15:15]
/// Port output data (y =
ODR15: u1 = 0,
/// unused [16:31]
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// GPIO port output data register
pub const ODR = Register(ODR_val).init(base_address + 0x14);

/// BSRR
const BSRR_val = packed struct {
/// BS0 [0:0]
/// Port x set bit y (y=
BS0: u1 = 0,
/// BS1 [1:1]
/// Port x set bit y (y=
BS1: u1 = 0,
/// BS2 [2:2]
/// Port x set bit y (y=
BS2: u1 = 0,
/// BS3 [3:3]
/// Port x set bit y (y=
BS3: u1 = 0,
/// BS4 [4:4]
/// Port x set bit y (y=
BS4: u1 = 0,
/// BS5 [5:5]
/// Port x set bit y (y=
BS5: u1 = 0,
/// BS6 [6:6]
/// Port x set bit y (y=
BS6: u1 = 0,
/// BS7 [7:7]
/// Port x set bit y (y=
BS7: u1 = 0,
/// BS8 [8:8]
/// Port x set bit y (y=
BS8: u1 = 0,
/// BS9 [9:9]
/// Port x set bit y (y=
BS9: u1 = 0,
/// BS10 [10:10]
/// Port x set bit y (y=
BS10: u1 = 0,
/// BS11 [11:11]
/// Port x set bit y (y=
BS11: u1 = 0,
/// BS12 [12:12]
/// Port x set bit y (y=
BS12: u1 = 0,
/// BS13 [13:13]
/// Port x set bit y (y=
BS13: u1 = 0,
/// BS14 [14:14]
/// Port x set bit y (y=
BS14: u1 = 0,
/// BS15 [15:15]
/// Port x set bit y (y=
BS15: u1 = 0,
/// BR0 [16:16]
/// Port x set bit y (y=
BR0: u1 = 0,
/// BR1 [17:17]
/// Port x reset bit y (y =
BR1: u1 = 0,
/// BR2 [18:18]
/// Port x reset bit y (y =
BR2: u1 = 0,
/// BR3 [19:19]
/// Port x reset bit y (y =
BR3: u1 = 0,
/// BR4 [20:20]
/// Port x reset bit y (y =
BR4: u1 = 0,
/// BR5 [21:21]
/// Port x reset bit y (y =
BR5: u1 = 0,
/// BR6 [22:22]
/// Port x reset bit y (y =
BR6: u1 = 0,
/// BR7 [23:23]
/// Port x reset bit y (y =
BR7: u1 = 0,
/// BR8 [24:24]
/// Port x reset bit y (y =
BR8: u1 = 0,
/// BR9 [25:25]
/// Port x reset bit y (y =
BR9: u1 = 0,
/// BR10 [26:26]
/// Port x reset bit y (y =
BR10: u1 = 0,
/// BR11 [27:27]
/// Port x reset bit y (y =
BR11: u1 = 0,
/// BR12 [28:28]
/// Port x reset bit y (y =
BR12: u1 = 0,
/// BR13 [29:29]
/// Port x reset bit y (y =
BR13: u1 = 0,
/// BR14 [30:30]
/// Port x reset bit y (y =
BR14: u1 = 0,
/// BR15 [31:31]
/// Port x reset bit y (y =
BR15: u1 = 0,
};
/// GPIO port bit set/reset
pub const BSRR = Register(BSRR_val).init(base_address + 0x18);

/// LCKR
const LCKR_val = packed struct {
/// LCK0 [0:0]
/// Port x lock bit y (y=
LCK0: u1 = 0,
/// LCK1 [1:1]
/// Port x lock bit y (y=
LCK1: u1 = 0,
/// LCK2 [2:2]
/// Port x lock bit y (y=
LCK2: u1 = 0,
/// LCK3 [3:3]
/// Port x lock bit y (y=
LCK3: u1 = 0,
/// LCK4 [4:4]
/// Port x lock bit y (y=
LCK4: u1 = 0,
/// LCK5 [5:5]
/// Port x lock bit y (y=
LCK5: u1 = 0,
/// LCK6 [6:6]
/// Port x lock bit y (y=
LCK6: u1 = 0,
/// LCK7 [7:7]
/// Port x lock bit y (y=
LCK7: u1 = 0,
/// LCK8 [8:8]
/// Port x lock bit y (y=
LCK8: u1 = 0,
/// LCK9 [9:9]
/// Port x lock bit y (y=
LCK9: u1 = 0,
/// LCK10 [10:10]
/// Port x lock bit y (y=
LCK10: u1 = 0,
/// LCK11 [11:11]
/// Port x lock bit y (y=
LCK11: u1 = 0,
/// LCK12 [12:12]
/// Port x lock bit y (y=
LCK12: u1 = 0,
/// LCK13 [13:13]
/// Port x lock bit y (y=
LCK13: u1 = 0,
/// LCK14 [14:14]
/// Port x lock bit y (y=
LCK14: u1 = 0,
/// LCK15 [15:15]
/// Port x lock bit y (y=
LCK15: u1 = 0,
/// LCKK [16:16]
/// Lok Key
LCKK: u1 = 0,
/// unused [17:31]
_unused17: u7 = 0,
_unused24: u8 = 0,
};
/// GPIO port configuration lock
pub const LCKR = Register(LCKR_val).init(base_address + 0x1c);

/// AFRL
const AFRL_val = packed struct {
/// AFRL0 [0:3]
/// Alternate function selection for port x
AFRL0: u4 = 0,
/// AFRL1 [4:7]
/// Alternate function selection for port x
AFRL1: u4 = 0,
/// AFRL2 [8:11]
/// Alternate function selection for port x
AFRL2: u4 = 0,
/// AFRL3 [12:15]
/// Alternate function selection for port x
AFRL3: u4 = 0,
/// AFRL4 [16:19]
/// Alternate function selection for port x
AFRL4: u4 = 0,
/// AFRL5 [20:23]
/// Alternate function selection for port x
AFRL5: u4 = 0,
/// AFRL6 [24:27]
/// Alternate function selection for port x
AFRL6: u4 = 0,
/// AFRL7 [28:31]
/// Alternate function selection for port x
AFRL7: u4 = 0,
};
/// GPIO alternate function low
pub const AFRL = Register(AFRL_val).init(base_address + 0x20);

/// AFRH
const AFRH_val = packed struct {
/// AFRH8 [0:3]
/// Alternate function selection for port x
AFRH8: u4 = 0,
/// AFRH9 [4:7]
/// Alternate function selection for port x
AFRH9: u4 = 0,
/// AFRH10 [8:11]
/// Alternate function selection for port x
AFRH10: u4 = 0,
/// AFRH11 [12:15]
/// Alternate function selection for port x
AFRH11: u4 = 0,
/// AFRH12 [16:19]
/// Alternate function selection for port x
AFRH12: u4 = 0,
/// AFRH13 [20:23]
/// Alternate function selection for port x
AFRH13: u4 = 0,
/// AFRH14 [24:27]
/// Alternate function selection for port x
AFRH14: u4 = 0,
/// AFRH15 [28:31]
/// Alternate function selection for port x
AFRH15: u4 = 0,
};
/// GPIO alternate function high
pub const AFRH = Register(AFRH_val).init(base_address + 0x24);

/// BRR
const BRR_val = packed struct {
/// BR0 [0:0]
/// Port x Reset bit y
BR0: u1 = 0,
/// BR1 [1:1]
/// Port x Reset bit y
BR1: u1 = 0,
/// BR2 [2:2]
/// Port x Reset bit y
BR2: u1 = 0,
/// BR3 [3:3]
/// Port x Reset bit y
BR3: u1 = 0,
/// BR4 [4:4]
/// Port x Reset bit y
BR4: u1 = 0,
/// BR5 [5:5]
/// Port x Reset bit y
BR5: u1 = 0,
/// BR6 [6:6]
/// Port x Reset bit y
BR6: u1 = 0,
/// BR7 [7:7]
/// Port x Reset bit y
BR7: u1 = 0,
/// BR8 [8:8]
/// Port x Reset bit y
BR8: u1 = 0,
/// BR9 [9:9]
/// Port x Reset bit y
BR9: u1 = 0,
/// BR10 [10:10]
/// Port x Reset bit y
BR10: u1 = 0,
/// BR11 [11:11]
/// Port x Reset bit y
BR11: u1 = 0,
/// BR12 [12:12]
/// Port x Reset bit y
BR12: u1 = 0,
/// BR13 [13:13]
/// Port x Reset bit y
BR13: u1 = 0,
/// BR14 [14:14]
/// Port x Reset bit y
BR14: u1 = 0,
/// BR15 [15:15]
/// Port x Reset bit y
BR15: u1 = 0,
/// unused [16:31]
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// Port bit reset register
pub const BRR = Register(BRR_val).init(base_address + 0x28);
};

/// General-purpose I/Os
pub const GPIOC = struct {

const base_address = 0x48000800;
/// MODER
const MODER_val = packed struct {
/// MODER0 [0:1]
/// Port x configuration bits (y =
MODER0: u2 = 0,
/// MODER1 [2:3]
/// Port x configuration bits (y =
MODER1: u2 = 0,
/// MODER2 [4:5]
/// Port x configuration bits (y =
MODER2: u2 = 0,
/// MODER3 [6:7]
/// Port x configuration bits (y =
MODER3: u2 = 0,
/// MODER4 [8:9]
/// Port x configuration bits (y =
MODER4: u2 = 0,
/// MODER5 [10:11]
/// Port x configuration bits (y =
MODER5: u2 = 0,
/// MODER6 [12:13]
/// Port x configuration bits (y =
MODER6: u2 = 0,
/// MODER7 [14:15]
/// Port x configuration bits (y =
MODER7: u2 = 0,
/// MODER8 [16:17]
/// Port x configuration bits (y =
MODER8: u2 = 0,
/// MODER9 [18:19]
/// Port x configuration bits (y =
MODER9: u2 = 0,
/// MODER10 [20:21]
/// Port x configuration bits (y =
MODER10: u2 = 0,
/// MODER11 [22:23]
/// Port x configuration bits (y =
MODER11: u2 = 0,
/// MODER12 [24:25]
/// Port x configuration bits (y =
MODER12: u2 = 0,
/// MODER13 [26:27]
/// Port x configuration bits (y =
MODER13: u2 = 0,
/// MODER14 [28:29]
/// Port x configuration bits (y =
MODER14: u2 = 0,
/// MODER15 [30:31]
/// Port x configuration bits (y =
MODER15: u2 = 0,
};
/// GPIO port mode register
pub const MODER = Register(MODER_val).init(base_address + 0x0);

/// OTYPER
const OTYPER_val = packed struct {
/// OT0 [0:0]
/// Port x configuration bit 0
OT0: u1 = 0,
/// OT1 [1:1]
/// Port x configuration bit 1
OT1: u1 = 0,
/// OT2 [2:2]
/// Port x configuration bit 2
OT2: u1 = 0,
/// OT3 [3:3]
/// Port x configuration bit 3
OT3: u1 = 0,
/// OT4 [4:4]
/// Port x configuration bit 4
OT4: u1 = 0,
/// OT5 [5:5]
/// Port x configuration bit 5
OT5: u1 = 0,
/// OT6 [6:6]
/// Port x configuration bit 6
OT6: u1 = 0,
/// OT7 [7:7]
/// Port x configuration bit 7
OT7: u1 = 0,
/// OT8 [8:8]
/// Port x configuration bit 8
OT8: u1 = 0,
/// OT9 [9:9]
/// Port x configuration bit 9
OT9: u1 = 0,
/// OT10 [10:10]
/// Port x configuration bit
OT10: u1 = 0,
/// OT11 [11:11]
/// Port x configuration bit
OT11: u1 = 0,
/// OT12 [12:12]
/// Port x configuration bit
OT12: u1 = 0,
/// OT13 [13:13]
/// Port x configuration bit
OT13: u1 = 0,
/// OT14 [14:14]
/// Port x configuration bit
OT14: u1 = 0,
/// OT15 [15:15]
/// Port x configuration bit
OT15: u1 = 0,
/// unused [16:31]
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// GPIO port output type register
pub const OTYPER = Register(OTYPER_val).init(base_address + 0x4);

/// OSPEEDR
const OSPEEDR_val = packed struct {
/// OSPEEDR0 [0:1]
/// Port x configuration bits (y =
OSPEEDR0: u2 = 0,
/// OSPEEDR1 [2:3]
/// Port x configuration bits (y =
OSPEEDR1: u2 = 0,
/// OSPEEDR2 [4:5]
/// Port x configuration bits (y =
OSPEEDR2: u2 = 0,
/// OSPEEDR3 [6:7]
/// Port x configuration bits (y =
OSPEEDR3: u2 = 0,
/// OSPEEDR4 [8:9]
/// Port x configuration bits (y =
OSPEEDR4: u2 = 0,
/// OSPEEDR5 [10:11]
/// Port x configuration bits (y =
OSPEEDR5: u2 = 0,
/// OSPEEDR6 [12:13]
/// Port x configuration bits (y =
OSPEEDR6: u2 = 0,
/// OSPEEDR7 [14:15]
/// Port x configuration bits (y =
OSPEEDR7: u2 = 0,
/// OSPEEDR8 [16:17]
/// Port x configuration bits (y =
OSPEEDR8: u2 = 0,
/// OSPEEDR9 [18:19]
/// Port x configuration bits (y =
OSPEEDR9: u2 = 0,
/// OSPEEDR10 [20:21]
/// Port x configuration bits (y =
OSPEEDR10: u2 = 0,
/// OSPEEDR11 [22:23]
/// Port x configuration bits (y =
OSPEEDR11: u2 = 0,
/// OSPEEDR12 [24:25]
/// Port x configuration bits (y =
OSPEEDR12: u2 = 0,
/// OSPEEDR13 [26:27]
/// Port x configuration bits (y =
OSPEEDR13: u2 = 0,
/// OSPEEDR14 [28:29]
/// Port x configuration bits (y =
OSPEEDR14: u2 = 0,
/// OSPEEDR15 [30:31]
/// Port x configuration bits (y =
OSPEEDR15: u2 = 0,
};
/// GPIO port output speed
pub const OSPEEDR = Register(OSPEEDR_val).init(base_address + 0x8);

/// PUPDR
const PUPDR_val = packed struct {
/// PUPDR0 [0:1]
/// Port x configuration bits (y =
PUPDR0: u2 = 0,
/// PUPDR1 [2:3]
/// Port x configuration bits (y =
PUPDR1: u2 = 0,
/// PUPDR2 [4:5]
/// Port x configuration bits (y =
PUPDR2: u2 = 0,
/// PUPDR3 [6:7]
/// Port x configuration bits (y =
PUPDR3: u2 = 0,
/// PUPDR4 [8:9]
/// Port x configuration bits (y =
PUPDR4: u2 = 0,
/// PUPDR5 [10:11]
/// Port x configuration bits (y =
PUPDR5: u2 = 0,
/// PUPDR6 [12:13]
/// Port x configuration bits (y =
PUPDR6: u2 = 0,
/// PUPDR7 [14:15]
/// Port x configuration bits (y =
PUPDR7: u2 = 0,
/// PUPDR8 [16:17]
/// Port x configuration bits (y =
PUPDR8: u2 = 0,
/// PUPDR9 [18:19]
/// Port x configuration bits (y =
PUPDR9: u2 = 0,
/// PUPDR10 [20:21]
/// Port x configuration bits (y =
PUPDR10: u2 = 0,
/// PUPDR11 [22:23]
/// Port x configuration bits (y =
PUPDR11: u2 = 0,
/// PUPDR12 [24:25]
/// Port x configuration bits (y =
PUPDR12: u2 = 0,
/// PUPDR13 [26:27]
/// Port x configuration bits (y =
PUPDR13: u2 = 0,
/// PUPDR14 [28:29]
/// Port x configuration bits (y =
PUPDR14: u2 = 0,
/// PUPDR15 [30:31]
/// Port x configuration bits (y =
PUPDR15: u2 = 0,
};
/// GPIO port pull-up/pull-down
pub const PUPDR = Register(PUPDR_val).init(base_address + 0xc);

/// IDR
const IDR_val = packed struct {
/// IDR0 [0:0]
/// Port input data (y =
IDR0: u1 = 0,
/// IDR1 [1:1]
/// Port input data (y =
IDR1: u1 = 0,
/// IDR2 [2:2]
/// Port input data (y =
IDR2: u1 = 0,
/// IDR3 [3:3]
/// Port input data (y =
IDR3: u1 = 0,
/// IDR4 [4:4]
/// Port input data (y =
IDR4: u1 = 0,
/// IDR5 [5:5]
/// Port input data (y =
IDR5: u1 = 0,
/// IDR6 [6:6]
/// Port input data (y =
IDR6: u1 = 0,
/// IDR7 [7:7]
/// Port input data (y =
IDR7: u1 = 0,
/// IDR8 [8:8]
/// Port input data (y =
IDR8: u1 = 0,
/// IDR9 [9:9]
/// Port input data (y =
IDR9: u1 = 0,
/// IDR10 [10:10]
/// Port input data (y =
IDR10: u1 = 0,
/// IDR11 [11:11]
/// Port input data (y =
IDR11: u1 = 0,
/// IDR12 [12:12]
/// Port input data (y =
IDR12: u1 = 0,
/// IDR13 [13:13]
/// Port input data (y =
IDR13: u1 = 0,
/// IDR14 [14:14]
/// Port input data (y =
IDR14: u1 = 0,
/// IDR15 [15:15]
/// Port input data (y =
IDR15: u1 = 0,
/// unused [16:31]
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// GPIO port input data register
pub const IDR = Register(IDR_val).init(base_address + 0x10);

/// ODR
const ODR_val = packed struct {
/// ODR0 [0:0]
/// Port output data (y =
ODR0: u1 = 0,
/// ODR1 [1:1]
/// Port output data (y =
ODR1: u1 = 0,
/// ODR2 [2:2]
/// Port output data (y =
ODR2: u1 = 0,
/// ODR3 [3:3]
/// Port output data (y =
ODR3: u1 = 0,
/// ODR4 [4:4]
/// Port output data (y =
ODR4: u1 = 0,
/// ODR5 [5:5]
/// Port output data (y =
ODR5: u1 = 0,
/// ODR6 [6:6]
/// Port output data (y =
ODR6: u1 = 0,
/// ODR7 [7:7]
/// Port output data (y =
ODR7: u1 = 0,
/// ODR8 [8:8]
/// Port output data (y =
ODR8: u1 = 0,
/// ODR9 [9:9]
/// Port output data (y =
ODR9: u1 = 0,
/// ODR10 [10:10]
/// Port output data (y =
ODR10: u1 = 0,
/// ODR11 [11:11]
/// Port output data (y =
ODR11: u1 = 0,
/// ODR12 [12:12]
/// Port output data (y =
ODR12: u1 = 0,
/// ODR13 [13:13]
/// Port output data (y =
ODR13: u1 = 0,
/// ODR14 [14:14]
/// Port output data (y =
ODR14: u1 = 0,
/// ODR15 [15:15]
/// Port output data (y =
ODR15: u1 = 0,
/// unused [16:31]
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// GPIO port output data register
pub const ODR = Register(ODR_val).init(base_address + 0x14);

/// BSRR
const BSRR_val = packed struct {
/// BS0 [0:0]
/// Port x set bit y (y=
BS0: u1 = 0,
/// BS1 [1:1]
/// Port x set bit y (y=
BS1: u1 = 0,
/// BS2 [2:2]
/// Port x set bit y (y=
BS2: u1 = 0,
/// BS3 [3:3]
/// Port x set bit y (y=
BS3: u1 = 0,
/// BS4 [4:4]
/// Port x set bit y (y=
BS4: u1 = 0,
/// BS5 [5:5]
/// Port x set bit y (y=
BS5: u1 = 0,
/// BS6 [6:6]
/// Port x set bit y (y=
BS6: u1 = 0,
/// BS7 [7:7]
/// Port x set bit y (y=
BS7: u1 = 0,
/// BS8 [8:8]
/// Port x set bit y (y=
BS8: u1 = 0,
/// BS9 [9:9]
/// Port x set bit y (y=
BS9: u1 = 0,
/// BS10 [10:10]
/// Port x set bit y (y=
BS10: u1 = 0,
/// BS11 [11:11]
/// Port x set bit y (y=
BS11: u1 = 0,
/// BS12 [12:12]
/// Port x set bit y (y=
BS12: u1 = 0,
/// BS13 [13:13]
/// Port x set bit y (y=
BS13: u1 = 0,
/// BS14 [14:14]
/// Port x set bit y (y=
BS14: u1 = 0,
/// BS15 [15:15]
/// Port x set bit y (y=
BS15: u1 = 0,
/// BR0 [16:16]
/// Port x set bit y (y=
BR0: u1 = 0,
/// BR1 [17:17]
/// Port x reset bit y (y =
BR1: u1 = 0,
/// BR2 [18:18]
/// Port x reset bit y (y =
BR2: u1 = 0,
/// BR3 [19:19]
/// Port x reset bit y (y =
BR3: u1 = 0,
/// BR4 [20:20]
/// Port x reset bit y (y =
BR4: u1 = 0,
/// BR5 [21:21]
/// Port x reset bit y (y =
BR5: u1 = 0,
/// BR6 [22:22]
/// Port x reset bit y (y =
BR6: u1 = 0,
/// BR7 [23:23]
/// Port x reset bit y (y =
BR7: u1 = 0,
/// BR8 [24:24]
/// Port x reset bit y (y =
BR8: u1 = 0,
/// BR9 [25:25]
/// Port x reset bit y (y =
BR9: u1 = 0,
/// BR10 [26:26]
/// Port x reset bit y (y =
BR10: u1 = 0,
/// BR11 [27:27]
/// Port x reset bit y (y =
BR11: u1 = 0,
/// BR12 [28:28]
/// Port x reset bit y (y =
BR12: u1 = 0,
/// BR13 [29:29]
/// Port x reset bit y (y =
BR13: u1 = 0,
/// BR14 [30:30]
/// Port x reset bit y (y =
BR14: u1 = 0,
/// BR15 [31:31]
/// Port x reset bit y (y =
BR15: u1 = 0,
};
/// GPIO port bit set/reset
pub const BSRR = Register(BSRR_val).init(base_address + 0x18);

/// LCKR
const LCKR_val = packed struct {
/// LCK0 [0:0]
/// Port x lock bit y (y=
LCK0: u1 = 0,
/// LCK1 [1:1]
/// Port x lock bit y (y=
LCK1: u1 = 0,
/// LCK2 [2:2]
/// Port x lock bit y (y=
LCK2: u1 = 0,
/// LCK3 [3:3]
/// Port x lock bit y (y=
LCK3: u1 = 0,
/// LCK4 [4:4]
/// Port x lock bit y (y=
LCK4: u1 = 0,
/// LCK5 [5:5]
/// Port x lock bit y (y=
LCK5: u1 = 0,
/// LCK6 [6:6]
/// Port x lock bit y (y=
LCK6: u1 = 0,
/// LCK7 [7:7]
/// Port x lock bit y (y=
LCK7: u1 = 0,
/// LCK8 [8:8]
/// Port x lock bit y (y=
LCK8: u1 = 0,
/// LCK9 [9:9]
/// Port x lock bit y (y=
LCK9: u1 = 0,
/// LCK10 [10:10]
/// Port x lock bit y (y=
LCK10: u1 = 0,
/// LCK11 [11:11]
/// Port x lock bit y (y=
LCK11: u1 = 0,
/// LCK12 [12:12]
/// Port x lock bit y (y=
LCK12: u1 = 0,
/// LCK13 [13:13]
/// Port x lock bit y (y=
LCK13: u1 = 0,
/// LCK14 [14:14]
/// Port x lock bit y (y=
LCK14: u1 = 0,
/// LCK15 [15:15]
/// Port x lock bit y (y=
LCK15: u1 = 0,
/// LCKK [16:16]
/// Lok Key
LCKK: u1 = 0,
/// unused [17:31]
_unused17: u7 = 0,
_unused24: u8 = 0,
};
/// GPIO port configuration lock
pub const LCKR = Register(LCKR_val).init(base_address + 0x1c);

/// AFRL
const AFRL_val = packed struct {
/// AFRL0 [0:3]
/// Alternate function selection for port x
AFRL0: u4 = 0,
/// AFRL1 [4:7]
/// Alternate function selection for port x
AFRL1: u4 = 0,
/// AFRL2 [8:11]
/// Alternate function selection for port x
AFRL2: u4 = 0,
/// AFRL3 [12:15]
/// Alternate function selection for port x
AFRL3: u4 = 0,
/// AFRL4 [16:19]
/// Alternate function selection for port x
AFRL4: u4 = 0,
/// AFRL5 [20:23]
/// Alternate function selection for port x
AFRL5: u4 = 0,
/// AFRL6 [24:27]
/// Alternate function selection for port x
AFRL6: u4 = 0,
/// AFRL7 [28:31]
/// Alternate function selection for port x
AFRL7: u4 = 0,
};
/// GPIO alternate function low
pub const AFRL = Register(AFRL_val).init(base_address + 0x20);

/// AFRH
const AFRH_val = packed struct {
/// AFRH8 [0:3]
/// Alternate function selection for port x
AFRH8: u4 = 0,
/// AFRH9 [4:7]
/// Alternate function selection for port x
AFRH9: u4 = 0,
/// AFRH10 [8:11]
/// Alternate function selection for port x
AFRH10: u4 = 0,
/// AFRH11 [12:15]
/// Alternate function selection for port x
AFRH11: u4 = 0,
/// AFRH12 [16:19]
/// Alternate function selection for port x
AFRH12: u4 = 0,
/// AFRH13 [20:23]
/// Alternate function selection for port x
AFRH13: u4 = 0,
/// AFRH14 [24:27]
/// Alternate function selection for port x
AFRH14: u4 = 0,
/// AFRH15 [28:31]
/// Alternate function selection for port x
AFRH15: u4 = 0,
};
/// GPIO alternate function high
pub const AFRH = Register(AFRH_val).init(base_address + 0x24);

/// BRR
const BRR_val = packed struct {
/// BR0 [0:0]
/// Port x Reset bit y
BR0: u1 = 0,
/// BR1 [1:1]
/// Port x Reset bit y
BR1: u1 = 0,
/// BR2 [2:2]
/// Port x Reset bit y
BR2: u1 = 0,
/// BR3 [3:3]
/// Port x Reset bit y
BR3: u1 = 0,
/// BR4 [4:4]
/// Port x Reset bit y
BR4: u1 = 0,
/// BR5 [5:5]
/// Port x Reset bit y
BR5: u1 = 0,
/// BR6 [6:6]
/// Port x Reset bit y
BR6: u1 = 0,
/// BR7 [7:7]
/// Port x Reset bit y
BR7: u1 = 0,
/// BR8 [8:8]
/// Port x Reset bit y
BR8: u1 = 0,
/// BR9 [9:9]
/// Port x Reset bit y
BR9: u1 = 0,
/// BR10 [10:10]
/// Port x Reset bit y
BR10: u1 = 0,
/// BR11 [11:11]
/// Port x Reset bit y
BR11: u1 = 0,
/// BR12 [12:12]
/// Port x Reset bit y
BR12: u1 = 0,
/// BR13 [13:13]
/// Port x Reset bit y
BR13: u1 = 0,
/// BR14 [14:14]
/// Port x Reset bit y
BR14: u1 = 0,
/// BR15 [15:15]
/// Port x Reset bit y
BR15: u1 = 0,
/// unused [16:31]
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// Port bit reset register
pub const BRR = Register(BRR_val).init(base_address + 0x28);
};

/// General-purpose I/Os
pub const GPIOD = struct {

const base_address = 0x48000c00;
/// MODER
const MODER_val = packed struct {
/// MODER0 [0:1]
/// Port x configuration bits (y =
MODER0: u2 = 0,
/// MODER1 [2:3]
/// Port x configuration bits (y =
MODER1: u2 = 0,
/// MODER2 [4:5]
/// Port x configuration bits (y =
MODER2: u2 = 0,
/// MODER3 [6:7]
/// Port x configuration bits (y =
MODER3: u2 = 0,
/// MODER4 [8:9]
/// Port x configuration bits (y =
MODER4: u2 = 0,
/// MODER5 [10:11]
/// Port x configuration bits (y =
MODER5: u2 = 0,
/// MODER6 [12:13]
/// Port x configuration bits (y =
MODER6: u2 = 0,
/// MODER7 [14:15]
/// Port x configuration bits (y =
MODER7: u2 = 0,
/// MODER8 [16:17]
/// Port x configuration bits (y =
MODER8: u2 = 0,
/// MODER9 [18:19]
/// Port x configuration bits (y =
MODER9: u2 = 0,
/// MODER10 [20:21]
/// Port x configuration bits (y =
MODER10: u2 = 0,
/// MODER11 [22:23]
/// Port x configuration bits (y =
MODER11: u2 = 0,
/// MODER12 [24:25]
/// Port x configuration bits (y =
MODER12: u2 = 0,
/// MODER13 [26:27]
/// Port x configuration bits (y =
MODER13: u2 = 0,
/// MODER14 [28:29]
/// Port x configuration bits (y =
MODER14: u2 = 0,
/// MODER15 [30:31]
/// Port x configuration bits (y =
MODER15: u2 = 0,
};
/// GPIO port mode register
pub const MODER = Register(MODER_val).init(base_address + 0x0);

/// OTYPER
const OTYPER_val = packed struct {
/// OT0 [0:0]
/// Port x configuration bit 0
OT0: u1 = 0,
/// OT1 [1:1]
/// Port x configuration bit 1
OT1: u1 = 0,
/// OT2 [2:2]
/// Port x configuration bit 2
OT2: u1 = 0,
/// OT3 [3:3]
/// Port x configuration bit 3
OT3: u1 = 0,
/// OT4 [4:4]
/// Port x configuration bit 4
OT4: u1 = 0,
/// OT5 [5:5]
/// Port x configuration bit 5
OT5: u1 = 0,
/// OT6 [6:6]
/// Port x configuration bit 6
OT6: u1 = 0,
/// OT7 [7:7]
/// Port x configuration bit 7
OT7: u1 = 0,
/// OT8 [8:8]
/// Port x configuration bit 8
OT8: u1 = 0,
/// OT9 [9:9]
/// Port x configuration bit 9
OT9: u1 = 0,
/// OT10 [10:10]
/// Port x configuration bit
OT10: u1 = 0,
/// OT11 [11:11]
/// Port x configuration bit
OT11: u1 = 0,
/// OT12 [12:12]
/// Port x configuration bit
OT12: u1 = 0,
/// OT13 [13:13]
/// Port x configuration bit
OT13: u1 = 0,
/// OT14 [14:14]
/// Port x configuration bit
OT14: u1 = 0,
/// OT15 [15:15]
/// Port x configuration bit
OT15: u1 = 0,
/// unused [16:31]
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// GPIO port output type register
pub const OTYPER = Register(OTYPER_val).init(base_address + 0x4);

/// OSPEEDR
const OSPEEDR_val = packed struct {
/// OSPEEDR0 [0:1]
/// Port x configuration bits (y =
OSPEEDR0: u2 = 0,
/// OSPEEDR1 [2:3]
/// Port x configuration bits (y =
OSPEEDR1: u2 = 0,
/// OSPEEDR2 [4:5]
/// Port x configuration bits (y =
OSPEEDR2: u2 = 0,
/// OSPEEDR3 [6:7]
/// Port x configuration bits (y =
OSPEEDR3: u2 = 0,
/// OSPEEDR4 [8:9]
/// Port x configuration bits (y =
OSPEEDR4: u2 = 0,
/// OSPEEDR5 [10:11]
/// Port x configuration bits (y =
OSPEEDR5: u2 = 0,
/// OSPEEDR6 [12:13]
/// Port x configuration bits (y =
OSPEEDR6: u2 = 0,
/// OSPEEDR7 [14:15]
/// Port x configuration bits (y =
OSPEEDR7: u2 = 0,
/// OSPEEDR8 [16:17]
/// Port x configuration bits (y =
OSPEEDR8: u2 = 0,
/// OSPEEDR9 [18:19]
/// Port x configuration bits (y =
OSPEEDR9: u2 = 0,
/// OSPEEDR10 [20:21]
/// Port x configuration bits (y =
OSPEEDR10: u2 = 0,
/// OSPEEDR11 [22:23]
/// Port x configuration bits (y =
OSPEEDR11: u2 = 0,
/// OSPEEDR12 [24:25]
/// Port x configuration bits (y =
OSPEEDR12: u2 = 0,
/// OSPEEDR13 [26:27]
/// Port x configuration bits (y =
OSPEEDR13: u2 = 0,
/// OSPEEDR14 [28:29]
/// Port x configuration bits (y =
OSPEEDR14: u2 = 0,
/// OSPEEDR15 [30:31]
/// Port x configuration bits (y =
OSPEEDR15: u2 = 0,
};
/// GPIO port output speed
pub const OSPEEDR = Register(OSPEEDR_val).init(base_address + 0x8);

/// PUPDR
const PUPDR_val = packed struct {
/// PUPDR0 [0:1]
/// Port x configuration bits (y =
PUPDR0: u2 = 0,
/// PUPDR1 [2:3]
/// Port x configuration bits (y =
PUPDR1: u2 = 0,
/// PUPDR2 [4:5]
/// Port x configuration bits (y =
PUPDR2: u2 = 0,
/// PUPDR3 [6:7]
/// Port x configuration bits (y =
PUPDR3: u2 = 0,
/// PUPDR4 [8:9]
/// Port x configuration bits (y =
PUPDR4: u2 = 0,
/// PUPDR5 [10:11]
/// Port x configuration bits (y =
PUPDR5: u2 = 0,
/// PUPDR6 [12:13]
/// Port x configuration bits (y =
PUPDR6: u2 = 0,
/// PUPDR7 [14:15]
/// Port x configuration bits (y =
PUPDR7: u2 = 0,
/// PUPDR8 [16:17]
/// Port x configuration bits (y =
PUPDR8: u2 = 0,
/// PUPDR9 [18:19]
/// Port x configuration bits (y =
PUPDR9: u2 = 0,
/// PUPDR10 [20:21]
/// Port x configuration bits (y =
PUPDR10: u2 = 0,
/// PUPDR11 [22:23]
/// Port x configuration bits (y =
PUPDR11: u2 = 0,
/// PUPDR12 [24:25]
/// Port x configuration bits (y =
PUPDR12: u2 = 0,
/// PUPDR13 [26:27]
/// Port x configuration bits (y =
PUPDR13: u2 = 0,
/// PUPDR14 [28:29]
/// Port x configuration bits (y =
PUPDR14: u2 = 0,
/// PUPDR15 [30:31]
/// Port x configuration bits (y =
PUPDR15: u2 = 0,
};
/// GPIO port pull-up/pull-down
pub const PUPDR = Register(PUPDR_val).init(base_address + 0xc);

/// IDR
const IDR_val = packed struct {
/// IDR0 [0:0]
/// Port input data (y =
IDR0: u1 = 0,
/// IDR1 [1:1]
/// Port input data (y =
IDR1: u1 = 0,
/// IDR2 [2:2]
/// Port input data (y =
IDR2: u1 = 0,
/// IDR3 [3:3]
/// Port input data (y =
IDR3: u1 = 0,
/// IDR4 [4:4]
/// Port input data (y =
IDR4: u1 = 0,
/// IDR5 [5:5]
/// Port input data (y =
IDR5: u1 = 0,
/// IDR6 [6:6]
/// Port input data (y =
IDR6: u1 = 0,
/// IDR7 [7:7]
/// Port input data (y =
IDR7: u1 = 0,
/// IDR8 [8:8]
/// Port input data (y =
IDR8: u1 = 0,
/// IDR9 [9:9]
/// Port input data (y =
IDR9: u1 = 0,
/// IDR10 [10:10]
/// Port input data (y =
IDR10: u1 = 0,
/// IDR11 [11:11]
/// Port input data (y =
IDR11: u1 = 0,
/// IDR12 [12:12]
/// Port input data (y =
IDR12: u1 = 0,
/// IDR13 [13:13]
/// Port input data (y =
IDR13: u1 = 0,
/// IDR14 [14:14]
/// Port input data (y =
IDR14: u1 = 0,
/// IDR15 [15:15]
/// Port input data (y =
IDR15: u1 = 0,
/// unused [16:31]
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// GPIO port input data register
pub const IDR = Register(IDR_val).init(base_address + 0x10);

/// ODR
const ODR_val = packed struct {
/// ODR0 [0:0]
/// Port output data (y =
ODR0: u1 = 0,
/// ODR1 [1:1]
/// Port output data (y =
ODR1: u1 = 0,
/// ODR2 [2:2]
/// Port output data (y =
ODR2: u1 = 0,
/// ODR3 [3:3]
/// Port output data (y =
ODR3: u1 = 0,
/// ODR4 [4:4]
/// Port output data (y =
ODR4: u1 = 0,
/// ODR5 [5:5]
/// Port output data (y =
ODR5: u1 = 0,
/// ODR6 [6:6]
/// Port output data (y =
ODR6: u1 = 0,
/// ODR7 [7:7]
/// Port output data (y =
ODR7: u1 = 0,
/// ODR8 [8:8]
/// Port output data (y =
ODR8: u1 = 0,
/// ODR9 [9:9]
/// Port output data (y =
ODR9: u1 = 0,
/// ODR10 [10:10]
/// Port output data (y =
ODR10: u1 = 0,
/// ODR11 [11:11]
/// Port output data (y =
ODR11: u1 = 0,
/// ODR12 [12:12]
/// Port output data (y =
ODR12: u1 = 0,
/// ODR13 [13:13]
/// Port output data (y =
ODR13: u1 = 0,
/// ODR14 [14:14]
/// Port output data (y =
ODR14: u1 = 0,
/// ODR15 [15:15]
/// Port output data (y =
ODR15: u1 = 0,
/// unused [16:31]
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// GPIO port output data register
pub const ODR = Register(ODR_val).init(base_address + 0x14);

/// BSRR
const BSRR_val = packed struct {
/// BS0 [0:0]
/// Port x set bit y (y=
BS0: u1 = 0,
/// BS1 [1:1]
/// Port x set bit y (y=
BS1: u1 = 0,
/// BS2 [2:2]
/// Port x set bit y (y=
BS2: u1 = 0,
/// BS3 [3:3]
/// Port x set bit y (y=
BS3: u1 = 0,
/// BS4 [4:4]
/// Port x set bit y (y=
BS4: u1 = 0,
/// BS5 [5:5]
/// Port x set bit y (y=
BS5: u1 = 0,
/// BS6 [6:6]
/// Port x set bit y (y=
BS6: u1 = 0,
/// BS7 [7:7]
/// Port x set bit y (y=
BS7: u1 = 0,
/// BS8 [8:8]
/// Port x set bit y (y=
BS8: u1 = 0,
/// BS9 [9:9]
/// Port x set bit y (y=
BS9: u1 = 0,
/// BS10 [10:10]
/// Port x set bit y (y=
BS10: u1 = 0,
/// BS11 [11:11]
/// Port x set bit y (y=
BS11: u1 = 0,
/// BS12 [12:12]
/// Port x set bit y (y=
BS12: u1 = 0,
/// BS13 [13:13]
/// Port x set bit y (y=
BS13: u1 = 0,
/// BS14 [14:14]
/// Port x set bit y (y=
BS14: u1 = 0,
/// BS15 [15:15]
/// Port x set bit y (y=
BS15: u1 = 0,
/// BR0 [16:16]
/// Port x set bit y (y=
BR0: u1 = 0,
/// BR1 [17:17]
/// Port x reset bit y (y =
BR1: u1 = 0,
/// BR2 [18:18]
/// Port x reset bit y (y =
BR2: u1 = 0,
/// BR3 [19:19]
/// Port x reset bit y (y =
BR3: u1 = 0,
/// BR4 [20:20]
/// Port x reset bit y (y =
BR4: u1 = 0,
/// BR5 [21:21]
/// Port x reset bit y (y =
BR5: u1 = 0,
/// BR6 [22:22]
/// Port x reset bit y (y =
BR6: u1 = 0,
/// BR7 [23:23]
/// Port x reset bit y (y =
BR7: u1 = 0,
/// BR8 [24:24]
/// Port x reset bit y (y =
BR8: u1 = 0,
/// BR9 [25:25]
/// Port x reset bit y (y =
BR9: u1 = 0,
/// BR10 [26:26]
/// Port x reset bit y (y =
BR10: u1 = 0,
/// BR11 [27:27]
/// Port x reset bit y (y =
BR11: u1 = 0,
/// BR12 [28:28]
/// Port x reset bit y (y =
BR12: u1 = 0,
/// BR13 [29:29]
/// Port x reset bit y (y =
BR13: u1 = 0,
/// BR14 [30:30]
/// Port x reset bit y (y =
BR14: u1 = 0,
/// BR15 [31:31]
/// Port x reset bit y (y =
BR15: u1 = 0,
};
/// GPIO port bit set/reset
pub const BSRR = Register(BSRR_val).init(base_address + 0x18);

/// LCKR
const LCKR_val = packed struct {
/// LCK0 [0:0]
/// Port x lock bit y (y=
LCK0: u1 = 0,
/// LCK1 [1:1]
/// Port x lock bit y (y=
LCK1: u1 = 0,
/// LCK2 [2:2]
/// Port x lock bit y (y=
LCK2: u1 = 0,
/// LCK3 [3:3]
/// Port x lock bit y (y=
LCK3: u1 = 0,
/// LCK4 [4:4]
/// Port x lock bit y (y=
LCK4: u1 = 0,
/// LCK5 [5:5]
/// Port x lock bit y (y=
LCK5: u1 = 0,
/// LCK6 [6:6]
/// Port x lock bit y (y=
LCK6: u1 = 0,
/// LCK7 [7:7]
/// Port x lock bit y (y=
LCK7: u1 = 0,
/// LCK8 [8:8]
/// Port x lock bit y (y=
LCK8: u1 = 0,
/// LCK9 [9:9]
/// Port x lock bit y (y=
LCK9: u1 = 0,
/// LCK10 [10:10]
/// Port x lock bit y (y=
LCK10: u1 = 0,
/// LCK11 [11:11]
/// Port x lock bit y (y=
LCK11: u1 = 0,
/// LCK12 [12:12]
/// Port x lock bit y (y=
LCK12: u1 = 0,
/// LCK13 [13:13]
/// Port x lock bit y (y=
LCK13: u1 = 0,
/// LCK14 [14:14]
/// Port x lock bit y (y=
LCK14: u1 = 0,
/// LCK15 [15:15]
/// Port x lock bit y (y=
LCK15: u1 = 0,
/// LCKK [16:16]
/// Lok Key
LCKK: u1 = 0,
/// unused [17:31]
_unused17: u7 = 0,
_unused24: u8 = 0,
};
/// GPIO port configuration lock
pub const LCKR = Register(LCKR_val).init(base_address + 0x1c);

/// AFRL
const AFRL_val = packed struct {
/// AFRL0 [0:3]
/// Alternate function selection for port x
AFRL0: u4 = 0,
/// AFRL1 [4:7]
/// Alternate function selection for port x
AFRL1: u4 = 0,
/// AFRL2 [8:11]
/// Alternate function selection for port x
AFRL2: u4 = 0,
/// AFRL3 [12:15]
/// Alternate function selection for port x
AFRL3: u4 = 0,
/// AFRL4 [16:19]
/// Alternate function selection for port x
AFRL4: u4 = 0,
/// AFRL5 [20:23]
/// Alternate function selection for port x
AFRL5: u4 = 0,
/// AFRL6 [24:27]
/// Alternate function selection for port x
AFRL6: u4 = 0,
/// AFRL7 [28:31]
/// Alternate function selection for port x
AFRL7: u4 = 0,
};
/// GPIO alternate function low
pub const AFRL = Register(AFRL_val).init(base_address + 0x20);

/// AFRH
const AFRH_val = packed struct {
/// AFRH8 [0:3]
/// Alternate function selection for port x
AFRH8: u4 = 0,
/// AFRH9 [4:7]
/// Alternate function selection for port x
AFRH9: u4 = 0,
/// AFRH10 [8:11]
/// Alternate function selection for port x
AFRH10: u4 = 0,
/// AFRH11 [12:15]
/// Alternate function selection for port x
AFRH11: u4 = 0,
/// AFRH12 [16:19]
/// Alternate function selection for port x
AFRH12: u4 = 0,
/// AFRH13 [20:23]
/// Alternate function selection for port x
AFRH13: u4 = 0,
/// AFRH14 [24:27]
/// Alternate function selection for port x
AFRH14: u4 = 0,
/// AFRH15 [28:31]
/// Alternate function selection for port x
AFRH15: u4 = 0,
};
/// GPIO alternate function high
pub const AFRH = Register(AFRH_val).init(base_address + 0x24);

/// BRR
const BRR_val = packed struct {
/// BR0 [0:0]
/// Port x Reset bit y
BR0: u1 = 0,
/// BR1 [1:1]
/// Port x Reset bit y
BR1: u1 = 0,
/// BR2 [2:2]
/// Port x Reset bit y
BR2: u1 = 0,
/// BR3 [3:3]
/// Port x Reset bit y
BR3: u1 = 0,
/// BR4 [4:4]
/// Port x Reset bit y
BR4: u1 = 0,
/// BR5 [5:5]
/// Port x Reset bit y
BR5: u1 = 0,
/// BR6 [6:6]
/// Port x Reset bit y
BR6: u1 = 0,
/// BR7 [7:7]
/// Port x Reset bit y
BR7: u1 = 0,
/// BR8 [8:8]
/// Port x Reset bit y
BR8: u1 = 0,
/// BR9 [9:9]
/// Port x Reset bit y
BR9: u1 = 0,
/// BR10 [10:10]
/// Port x Reset bit y
BR10: u1 = 0,
/// BR11 [11:11]
/// Port x Reset bit y
BR11: u1 = 0,
/// BR12 [12:12]
/// Port x Reset bit y
BR12: u1 = 0,
/// BR13 [13:13]
/// Port x Reset bit y
BR13: u1 = 0,
/// BR14 [14:14]
/// Port x Reset bit y
BR14: u1 = 0,
/// BR15 [15:15]
/// Port x Reset bit y
BR15: u1 = 0,
/// unused [16:31]
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// Port bit reset register
pub const BRR = Register(BRR_val).init(base_address + 0x28);
};

/// General-purpose I/Os
pub const GPIOE = struct {

const base_address = 0x48001000;
/// MODER
const MODER_val = packed struct {
/// MODER0 [0:1]
/// Port x configuration bits (y =
MODER0: u2 = 0,
/// MODER1 [2:3]
/// Port x configuration bits (y =
MODER1: u2 = 0,
/// MODER2 [4:5]
/// Port x configuration bits (y =
MODER2: u2 = 0,
/// MODER3 [6:7]
/// Port x configuration bits (y =
MODER3: u2 = 0,
/// MODER4 [8:9]
/// Port x configuration bits (y =
MODER4: u2 = 0,
/// MODER5 [10:11]
/// Port x configuration bits (y =
MODER5: u2 = 0,
/// MODER6 [12:13]
/// Port x configuration bits (y =
MODER6: u2 = 0,
/// MODER7 [14:15]
/// Port x configuration bits (y =
MODER7: u2 = 0,
/// MODER8 [16:17]
/// Port x configuration bits (y =
MODER8: u2 = 0,
/// MODER9 [18:19]
/// Port x configuration bits (y =
MODER9: u2 = 0,
/// MODER10 [20:21]
/// Port x configuration bits (y =
MODER10: u2 = 0,
/// MODER11 [22:23]
/// Port x configuration bits (y =
MODER11: u2 = 0,
/// MODER12 [24:25]
/// Port x configuration bits (y =
MODER12: u2 = 0,
/// MODER13 [26:27]
/// Port x configuration bits (y =
MODER13: u2 = 0,
/// MODER14 [28:29]
/// Port x configuration bits (y =
MODER14: u2 = 0,
/// MODER15 [30:31]
/// Port x configuration bits (y =
MODER15: u2 = 0,
};
/// GPIO port mode register
pub const MODER = Register(MODER_val).init(base_address + 0x0);

/// OTYPER
const OTYPER_val = packed struct {
/// OT0 [0:0]
/// Port x configuration bit 0
OT0: u1 = 0,
/// OT1 [1:1]
/// Port x configuration bit 1
OT1: u1 = 0,
/// OT2 [2:2]
/// Port x configuration bit 2
OT2: u1 = 0,
/// OT3 [3:3]
/// Port x configuration bit 3
OT3: u1 = 0,
/// OT4 [4:4]
/// Port x configuration bit 4
OT4: u1 = 0,
/// OT5 [5:5]
/// Port x configuration bit 5
OT5: u1 = 0,
/// OT6 [6:6]
/// Port x configuration bit 6
OT6: u1 = 0,
/// OT7 [7:7]
/// Port x configuration bit 7
OT7: u1 = 0,
/// OT8 [8:8]
/// Port x configuration bit 8
OT8: u1 = 0,
/// OT9 [9:9]
/// Port x configuration bit 9
OT9: u1 = 0,
/// OT10 [10:10]
/// Port x configuration bit
OT10: u1 = 0,
/// OT11 [11:11]
/// Port x configuration bit
OT11: u1 = 0,
/// OT12 [12:12]
/// Port x configuration bit
OT12: u1 = 0,
/// OT13 [13:13]
/// Port x configuration bit
OT13: u1 = 0,
/// OT14 [14:14]
/// Port x configuration bit
OT14: u1 = 0,
/// OT15 [15:15]
/// Port x configuration bit
OT15: u1 = 0,
/// unused [16:31]
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// GPIO port output type register
pub const OTYPER = Register(OTYPER_val).init(base_address + 0x4);

/// OSPEEDR
const OSPEEDR_val = packed struct {
/// OSPEEDR0 [0:1]
/// Port x configuration bits (y =
OSPEEDR0: u2 = 0,
/// OSPEEDR1 [2:3]
/// Port x configuration bits (y =
OSPEEDR1: u2 = 0,
/// OSPEEDR2 [4:5]
/// Port x configuration bits (y =
OSPEEDR2: u2 = 0,
/// OSPEEDR3 [6:7]
/// Port x configuration bits (y =
OSPEEDR3: u2 = 0,
/// OSPEEDR4 [8:9]
/// Port x configuration bits (y =
OSPEEDR4: u2 = 0,
/// OSPEEDR5 [10:11]
/// Port x configuration bits (y =
OSPEEDR5: u2 = 0,
/// OSPEEDR6 [12:13]
/// Port x configuration bits (y =
OSPEEDR6: u2 = 0,
/// OSPEEDR7 [14:15]
/// Port x configuration bits (y =
OSPEEDR7: u2 = 0,
/// OSPEEDR8 [16:17]
/// Port x configuration bits (y =
OSPEEDR8: u2 = 0,
/// OSPEEDR9 [18:19]
/// Port x configuration bits (y =
OSPEEDR9: u2 = 0,
/// OSPEEDR10 [20:21]
/// Port x configuration bits (y =
OSPEEDR10: u2 = 0,
/// OSPEEDR11 [22:23]
/// Port x configuration bits (y =
OSPEEDR11: u2 = 0,
/// OSPEEDR12 [24:25]
/// Port x configuration bits (y =
OSPEEDR12: u2 = 0,
/// OSPEEDR13 [26:27]
/// Port x configuration bits (y =
OSPEEDR13: u2 = 0,
/// OSPEEDR14 [28:29]
/// Port x configuration bits (y =
OSPEEDR14: u2 = 0,
/// OSPEEDR15 [30:31]
/// Port x configuration bits (y =
OSPEEDR15: u2 = 0,
};
/// GPIO port output speed
pub const OSPEEDR = Register(OSPEEDR_val).init(base_address + 0x8);

/// PUPDR
const PUPDR_val = packed struct {
/// PUPDR0 [0:1]
/// Port x configuration bits (y =
PUPDR0: u2 = 0,
/// PUPDR1 [2:3]
/// Port x configuration bits (y =
PUPDR1: u2 = 0,
/// PUPDR2 [4:5]
/// Port x configuration bits (y =
PUPDR2: u2 = 0,
/// PUPDR3 [6:7]
/// Port x configuration bits (y =
PUPDR3: u2 = 0,
/// PUPDR4 [8:9]
/// Port x configuration bits (y =
PUPDR4: u2 = 0,
/// PUPDR5 [10:11]
/// Port x configuration bits (y =
PUPDR5: u2 = 0,
/// PUPDR6 [12:13]
/// Port x configuration bits (y =
PUPDR6: u2 = 0,
/// PUPDR7 [14:15]
/// Port x configuration bits (y =
PUPDR7: u2 = 0,
/// PUPDR8 [16:17]
/// Port x configuration bits (y =
PUPDR8: u2 = 0,
/// PUPDR9 [18:19]
/// Port x configuration bits (y =
PUPDR9: u2 = 0,
/// PUPDR10 [20:21]
/// Port x configuration bits (y =
PUPDR10: u2 = 0,
/// PUPDR11 [22:23]
/// Port x configuration bits (y =
PUPDR11: u2 = 0,
/// PUPDR12 [24:25]
/// Port x configuration bits (y =
PUPDR12: u2 = 0,
/// PUPDR13 [26:27]
/// Port x configuration bits (y =
PUPDR13: u2 = 0,
/// PUPDR14 [28:29]
/// Port x configuration bits (y =
PUPDR14: u2 = 0,
/// PUPDR15 [30:31]
/// Port x configuration bits (y =
PUPDR15: u2 = 0,
};
/// GPIO port pull-up/pull-down
pub const PUPDR = Register(PUPDR_val).init(base_address + 0xc);

/// IDR
const IDR_val = packed struct {
/// IDR0 [0:0]
/// Port input data (y =
IDR0: u1 = 0,
/// IDR1 [1:1]
/// Port input data (y =
IDR1: u1 = 0,
/// IDR2 [2:2]
/// Port input data (y =
IDR2: u1 = 0,
/// IDR3 [3:3]
/// Port input data (y =
IDR3: u1 = 0,
/// IDR4 [4:4]
/// Port input data (y =
IDR4: u1 = 0,
/// IDR5 [5:5]
/// Port input data (y =
IDR5: u1 = 0,
/// IDR6 [6:6]
/// Port input data (y =
IDR6: u1 = 0,
/// IDR7 [7:7]
/// Port input data (y =
IDR7: u1 = 0,
/// IDR8 [8:8]
/// Port input data (y =
IDR8: u1 = 0,
/// IDR9 [9:9]
/// Port input data (y =
IDR9: u1 = 0,
/// IDR10 [10:10]
/// Port input data (y =
IDR10: u1 = 0,
/// IDR11 [11:11]
/// Port input data (y =
IDR11: u1 = 0,
/// IDR12 [12:12]
/// Port input data (y =
IDR12: u1 = 0,
/// IDR13 [13:13]
/// Port input data (y =
IDR13: u1 = 0,
/// IDR14 [14:14]
/// Port input data (y =
IDR14: u1 = 0,
/// IDR15 [15:15]
/// Port input data (y =
IDR15: u1 = 0,
/// unused [16:31]
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// GPIO port input data register
pub const IDR = Register(IDR_val).init(base_address + 0x10);

/// ODR
const ODR_val = packed struct {
/// ODR0 [0:0]
/// Port output data (y =
ODR0: u1 = 0,
/// ODR1 [1:1]
/// Port output data (y =
ODR1: u1 = 0,
/// ODR2 [2:2]
/// Port output data (y =
ODR2: u1 = 0,
/// ODR3 [3:3]
/// Port output data (y =
ODR3: u1 = 0,
/// ODR4 [4:4]
/// Port output data (y =
ODR4: u1 = 0,
/// ODR5 [5:5]
/// Port output data (y =
ODR5: u1 = 0,
/// ODR6 [6:6]
/// Port output data (y =
ODR6: u1 = 0,
/// ODR7 [7:7]
/// Port output data (y =
ODR7: u1 = 0,
/// ODR8 [8:8]
/// Port output data (y =
ODR8: u1 = 0,
/// ODR9 [9:9]
/// Port output data (y =
ODR9: u1 = 0,
/// ODR10 [10:10]
/// Port output data (y =
ODR10: u1 = 0,
/// ODR11 [11:11]
/// Port output data (y =
ODR11: u1 = 0,
/// ODR12 [12:12]
/// Port output data (y =
ODR12: u1 = 0,
/// ODR13 [13:13]
/// Port output data (y =
ODR13: u1 = 0,
/// ODR14 [14:14]
/// Port output data (y =
ODR14: u1 = 0,
/// ODR15 [15:15]
/// Port output data (y =
ODR15: u1 = 0,
/// unused [16:31]
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// GPIO port output data register
pub const ODR = Register(ODR_val).init(base_address + 0x14);

/// BSRR
const BSRR_val = packed struct {
/// BS0 [0:0]
/// Port x set bit y (y=
BS0: u1 = 0,
/// BS1 [1:1]
/// Port x set bit y (y=
BS1: u1 = 0,
/// BS2 [2:2]
/// Port x set bit y (y=
BS2: u1 = 0,
/// BS3 [3:3]
/// Port x set bit y (y=
BS3: u1 = 0,
/// BS4 [4:4]
/// Port x set bit y (y=
BS4: u1 = 0,
/// BS5 [5:5]
/// Port x set bit y (y=
BS5: u1 = 0,
/// BS6 [6:6]
/// Port x set bit y (y=
BS6: u1 = 0,
/// BS7 [7:7]
/// Port x set bit y (y=
BS7: u1 = 0,
/// BS8 [8:8]
/// Port x set bit y (y=
BS8: u1 = 0,
/// BS9 [9:9]
/// Port x set bit y (y=
BS9: u1 = 0,
/// BS10 [10:10]
/// Port x set bit y (y=
BS10: u1 = 0,
/// BS11 [11:11]
/// Port x set bit y (y=
BS11: u1 = 0,
/// BS12 [12:12]
/// Port x set bit y (y=
BS12: u1 = 0,
/// BS13 [13:13]
/// Port x set bit y (y=
BS13: u1 = 0,
/// BS14 [14:14]
/// Port x set bit y (y=
BS14: u1 = 0,
/// BS15 [15:15]
/// Port x set bit y (y=
BS15: u1 = 0,
/// BR0 [16:16]
/// Port x set bit y (y=
BR0: u1 = 0,
/// BR1 [17:17]
/// Port x reset bit y (y =
BR1: u1 = 0,
/// BR2 [18:18]
/// Port x reset bit y (y =
BR2: u1 = 0,
/// BR3 [19:19]
/// Port x reset bit y (y =
BR3: u1 = 0,
/// BR4 [20:20]
/// Port x reset bit y (y =
BR4: u1 = 0,
/// BR5 [21:21]
/// Port x reset bit y (y =
BR5: u1 = 0,
/// BR6 [22:22]
/// Port x reset bit y (y =
BR6: u1 = 0,
/// BR7 [23:23]
/// Port x reset bit y (y =
BR7: u1 = 0,
/// BR8 [24:24]
/// Port x reset bit y (y =
BR8: u1 = 0,
/// BR9 [25:25]
/// Port x reset bit y (y =
BR9: u1 = 0,
/// BR10 [26:26]
/// Port x reset bit y (y =
BR10: u1 = 0,
/// BR11 [27:27]
/// Port x reset bit y (y =
BR11: u1 = 0,
/// BR12 [28:28]
/// Port x reset bit y (y =
BR12: u1 = 0,
/// BR13 [29:29]
/// Port x reset bit y (y =
BR13: u1 = 0,
/// BR14 [30:30]
/// Port x reset bit y (y =
BR14: u1 = 0,
/// BR15 [31:31]
/// Port x reset bit y (y =
BR15: u1 = 0,
};
/// GPIO port bit set/reset
pub const BSRR = Register(BSRR_val).init(base_address + 0x18);

/// LCKR
const LCKR_val = packed struct {
/// LCK0 [0:0]
/// Port x lock bit y (y=
LCK0: u1 = 0,
/// LCK1 [1:1]
/// Port x lock bit y (y=
LCK1: u1 = 0,
/// LCK2 [2:2]
/// Port x lock bit y (y=
LCK2: u1 = 0,
/// LCK3 [3:3]
/// Port x lock bit y (y=
LCK3: u1 = 0,
/// LCK4 [4:4]
/// Port x lock bit y (y=
LCK4: u1 = 0,
/// LCK5 [5:5]
/// Port x lock bit y (y=
LCK5: u1 = 0,
/// LCK6 [6:6]
/// Port x lock bit y (y=
LCK6: u1 = 0,
/// LCK7 [7:7]
/// Port x lock bit y (y=
LCK7: u1 = 0,
/// LCK8 [8:8]
/// Port x lock bit y (y=
LCK8: u1 = 0,
/// LCK9 [9:9]
/// Port x lock bit y (y=
LCK9: u1 = 0,
/// LCK10 [10:10]
/// Port x lock bit y (y=
LCK10: u1 = 0,
/// LCK11 [11:11]
/// Port x lock bit y (y=
LCK11: u1 = 0,
/// LCK12 [12:12]
/// Port x lock bit y (y=
LCK12: u1 = 0,
/// LCK13 [13:13]
/// Port x lock bit y (y=
LCK13: u1 = 0,
/// LCK14 [14:14]
/// Port x lock bit y (y=
LCK14: u1 = 0,
/// LCK15 [15:15]
/// Port x lock bit y (y=
LCK15: u1 = 0,
/// LCKK [16:16]
/// Lok Key
LCKK: u1 = 0,
/// unused [17:31]
_unused17: u7 = 0,
_unused24: u8 = 0,
};
/// GPIO port configuration lock
pub const LCKR = Register(LCKR_val).init(base_address + 0x1c);

/// AFRL
const AFRL_val = packed struct {
/// AFRL0 [0:3]
/// Alternate function selection for port x
AFRL0: u4 = 0,
/// AFRL1 [4:7]
/// Alternate function selection for port x
AFRL1: u4 = 0,
/// AFRL2 [8:11]
/// Alternate function selection for port x
AFRL2: u4 = 0,
/// AFRL3 [12:15]
/// Alternate function selection for port x
AFRL3: u4 = 0,
/// AFRL4 [16:19]
/// Alternate function selection for port x
AFRL4: u4 = 0,
/// AFRL5 [20:23]
/// Alternate function selection for port x
AFRL5: u4 = 0,
/// AFRL6 [24:27]
/// Alternate function selection for port x
AFRL6: u4 = 0,
/// AFRL7 [28:31]
/// Alternate function selection for port x
AFRL7: u4 = 0,
};
/// GPIO alternate function low
pub const AFRL = Register(AFRL_val).init(base_address + 0x20);

/// AFRH
const AFRH_val = packed struct {
/// AFRH8 [0:3]
/// Alternate function selection for port x
AFRH8: u4 = 0,
/// AFRH9 [4:7]
/// Alternate function selection for port x
AFRH9: u4 = 0,
/// AFRH10 [8:11]
/// Alternate function selection for port x
AFRH10: u4 = 0,
/// AFRH11 [12:15]
/// Alternate function selection for port x
AFRH11: u4 = 0,
/// AFRH12 [16:19]
/// Alternate function selection for port x
AFRH12: u4 = 0,
/// AFRH13 [20:23]
/// Alternate function selection for port x
AFRH13: u4 = 0,
/// AFRH14 [24:27]
/// Alternate function selection for port x
AFRH14: u4 = 0,
/// AFRH15 [28:31]
/// Alternate function selection for port x
AFRH15: u4 = 0,
};
/// GPIO alternate function high
pub const AFRH = Register(AFRH_val).init(base_address + 0x24);

/// BRR
const BRR_val = packed struct {
/// BR0 [0:0]
/// Port x Reset bit y
BR0: u1 = 0,
/// BR1 [1:1]
/// Port x Reset bit y
BR1: u1 = 0,
/// BR2 [2:2]
/// Port x Reset bit y
BR2: u1 = 0,
/// BR3 [3:3]
/// Port x Reset bit y
BR3: u1 = 0,
/// BR4 [4:4]
/// Port x Reset bit y
BR4: u1 = 0,
/// BR5 [5:5]
/// Port x Reset bit y
BR5: u1 = 0,
/// BR6 [6:6]
/// Port x Reset bit y
BR6: u1 = 0,
/// BR7 [7:7]
/// Port x Reset bit y
BR7: u1 = 0,
/// BR8 [8:8]
/// Port x Reset bit y
BR8: u1 = 0,
/// BR9 [9:9]
/// Port x Reset bit y
BR9: u1 = 0,
/// BR10 [10:10]
/// Port x Reset bit y
BR10: u1 = 0,
/// BR11 [11:11]
/// Port x Reset bit y
BR11: u1 = 0,
/// BR12 [12:12]
/// Port x Reset bit y
BR12: u1 = 0,
/// BR13 [13:13]
/// Port x Reset bit y
BR13: u1 = 0,
/// BR14 [14:14]
/// Port x Reset bit y
BR14: u1 = 0,
/// BR15 [15:15]
/// Port x Reset bit y
BR15: u1 = 0,
/// unused [16:31]
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// Port bit reset register
pub const BRR = Register(BRR_val).init(base_address + 0x28);
};

/// General-purpose I/Os
pub const GPIOF = struct {

const base_address = 0x48001400;
/// MODER
const MODER_val = packed struct {
/// MODER0 [0:1]
/// Port x configuration bits (y =
MODER0: u2 = 0,
/// MODER1 [2:3]
/// Port x configuration bits (y =
MODER1: u2 = 0,
/// MODER2 [4:5]
/// Port x configuration bits (y =
MODER2: u2 = 0,
/// MODER3 [6:7]
/// Port x configuration bits (y =
MODER3: u2 = 0,
/// MODER4 [8:9]
/// Port x configuration bits (y =
MODER4: u2 = 0,
/// MODER5 [10:11]
/// Port x configuration bits (y =
MODER5: u2 = 0,
/// MODER6 [12:13]
/// Port x configuration bits (y =
MODER6: u2 = 0,
/// MODER7 [14:15]
/// Port x configuration bits (y =
MODER7: u2 = 0,
/// MODER8 [16:17]
/// Port x configuration bits (y =
MODER8: u2 = 0,
/// MODER9 [18:19]
/// Port x configuration bits (y =
MODER9: u2 = 0,
/// MODER10 [20:21]
/// Port x configuration bits (y =
MODER10: u2 = 0,
/// MODER11 [22:23]
/// Port x configuration bits (y =
MODER11: u2 = 0,
/// MODER12 [24:25]
/// Port x configuration bits (y =
MODER12: u2 = 0,
/// MODER13 [26:27]
/// Port x configuration bits (y =
MODER13: u2 = 0,
/// MODER14 [28:29]
/// Port x configuration bits (y =
MODER14: u2 = 0,
/// MODER15 [30:31]
/// Port x configuration bits (y =
MODER15: u2 = 0,
};
/// GPIO port mode register
pub const MODER = Register(MODER_val).init(base_address + 0x0);

/// OTYPER
const OTYPER_val = packed struct {
/// OT0 [0:0]
/// Port x configuration bit 0
OT0: u1 = 0,
/// OT1 [1:1]
/// Port x configuration bit 1
OT1: u1 = 0,
/// OT2 [2:2]
/// Port x configuration bit 2
OT2: u1 = 0,
/// OT3 [3:3]
/// Port x configuration bit 3
OT3: u1 = 0,
/// OT4 [4:4]
/// Port x configuration bit 4
OT4: u1 = 0,
/// OT5 [5:5]
/// Port x configuration bit 5
OT5: u1 = 0,
/// OT6 [6:6]
/// Port x configuration bit 6
OT6: u1 = 0,
/// OT7 [7:7]
/// Port x configuration bit 7
OT7: u1 = 0,
/// OT8 [8:8]
/// Port x configuration bit 8
OT8: u1 = 0,
/// OT9 [9:9]
/// Port x configuration bit 9
OT9: u1 = 0,
/// OT10 [10:10]
/// Port x configuration bit
OT10: u1 = 0,
/// OT11 [11:11]
/// Port x configuration bit
OT11: u1 = 0,
/// OT12 [12:12]
/// Port x configuration bit
OT12: u1 = 0,
/// OT13 [13:13]
/// Port x configuration bit
OT13: u1 = 0,
/// OT14 [14:14]
/// Port x configuration bit
OT14: u1 = 0,
/// OT15 [15:15]
/// Port x configuration bit
OT15: u1 = 0,
/// unused [16:31]
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// GPIO port output type register
pub const OTYPER = Register(OTYPER_val).init(base_address + 0x4);

/// OSPEEDR
const OSPEEDR_val = packed struct {
/// OSPEEDR0 [0:1]
/// Port x configuration bits (y =
OSPEEDR0: u2 = 0,
/// OSPEEDR1 [2:3]
/// Port x configuration bits (y =
OSPEEDR1: u2 = 0,
/// OSPEEDR2 [4:5]
/// Port x configuration bits (y =
OSPEEDR2: u2 = 0,
/// OSPEEDR3 [6:7]
/// Port x configuration bits (y =
OSPEEDR3: u2 = 0,
/// OSPEEDR4 [8:9]
/// Port x configuration bits (y =
OSPEEDR4: u2 = 0,
/// OSPEEDR5 [10:11]
/// Port x configuration bits (y =
OSPEEDR5: u2 = 0,
/// OSPEEDR6 [12:13]
/// Port x configuration bits (y =
OSPEEDR6: u2 = 0,
/// OSPEEDR7 [14:15]
/// Port x configuration bits (y =
OSPEEDR7: u2 = 0,
/// OSPEEDR8 [16:17]
/// Port x configuration bits (y =
OSPEEDR8: u2 = 0,
/// OSPEEDR9 [18:19]
/// Port x configuration bits (y =
OSPEEDR9: u2 = 0,
/// OSPEEDR10 [20:21]
/// Port x configuration bits (y =
OSPEEDR10: u2 = 0,
/// OSPEEDR11 [22:23]
/// Port x configuration bits (y =
OSPEEDR11: u2 = 0,
/// OSPEEDR12 [24:25]
/// Port x configuration bits (y =
OSPEEDR12: u2 = 0,
/// OSPEEDR13 [26:27]
/// Port x configuration bits (y =
OSPEEDR13: u2 = 0,
/// OSPEEDR14 [28:29]
/// Port x configuration bits (y =
OSPEEDR14: u2 = 0,
/// OSPEEDR15 [30:31]
/// Port x configuration bits (y =
OSPEEDR15: u2 = 0,
};
/// GPIO port output speed
pub const OSPEEDR = Register(OSPEEDR_val).init(base_address + 0x8);

/// PUPDR
const PUPDR_val = packed struct {
/// PUPDR0 [0:1]
/// Port x configuration bits (y =
PUPDR0: u2 = 0,
/// PUPDR1 [2:3]
/// Port x configuration bits (y =
PUPDR1: u2 = 0,
/// PUPDR2 [4:5]
/// Port x configuration bits (y =
PUPDR2: u2 = 0,
/// PUPDR3 [6:7]
/// Port x configuration bits (y =
PUPDR3: u2 = 0,
/// PUPDR4 [8:9]
/// Port x configuration bits (y =
PUPDR4: u2 = 0,
/// PUPDR5 [10:11]
/// Port x configuration bits (y =
PUPDR5: u2 = 0,
/// PUPDR6 [12:13]
/// Port x configuration bits (y =
PUPDR6: u2 = 0,
/// PUPDR7 [14:15]
/// Port x configuration bits (y =
PUPDR7: u2 = 0,
/// PUPDR8 [16:17]
/// Port x configuration bits (y =
PUPDR8: u2 = 0,
/// PUPDR9 [18:19]
/// Port x configuration bits (y =
PUPDR9: u2 = 0,
/// PUPDR10 [20:21]
/// Port x configuration bits (y =
PUPDR10: u2 = 0,
/// PUPDR11 [22:23]
/// Port x configuration bits (y =
PUPDR11: u2 = 0,
/// PUPDR12 [24:25]
/// Port x configuration bits (y =
PUPDR12: u2 = 0,
/// PUPDR13 [26:27]
/// Port x configuration bits (y =
PUPDR13: u2 = 0,
/// PUPDR14 [28:29]
/// Port x configuration bits (y =
PUPDR14: u2 = 0,
/// PUPDR15 [30:31]
/// Port x configuration bits (y =
PUPDR15: u2 = 0,
};
/// GPIO port pull-up/pull-down
pub const PUPDR = Register(PUPDR_val).init(base_address + 0xc);

/// IDR
const IDR_val = packed struct {
/// IDR0 [0:0]
/// Port input data (y =
IDR0: u1 = 0,
/// IDR1 [1:1]
/// Port input data (y =
IDR1: u1 = 0,
/// IDR2 [2:2]
/// Port input data (y =
IDR2: u1 = 0,
/// IDR3 [3:3]
/// Port input data (y =
IDR3: u1 = 0,
/// IDR4 [4:4]
/// Port input data (y =
IDR4: u1 = 0,
/// IDR5 [5:5]
/// Port input data (y =
IDR5: u1 = 0,
/// IDR6 [6:6]
/// Port input data (y =
IDR6: u1 = 0,
/// IDR7 [7:7]
/// Port input data (y =
IDR7: u1 = 0,
/// IDR8 [8:8]
/// Port input data (y =
IDR8: u1 = 0,
/// IDR9 [9:9]
/// Port input data (y =
IDR9: u1 = 0,
/// IDR10 [10:10]
/// Port input data (y =
IDR10: u1 = 0,
/// IDR11 [11:11]
/// Port input data (y =
IDR11: u1 = 0,
/// IDR12 [12:12]
/// Port input data (y =
IDR12: u1 = 0,
/// IDR13 [13:13]
/// Port input data (y =
IDR13: u1 = 0,
/// IDR14 [14:14]
/// Port input data (y =
IDR14: u1 = 0,
/// IDR15 [15:15]
/// Port input data (y =
IDR15: u1 = 0,
/// unused [16:31]
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// GPIO port input data register
pub const IDR = Register(IDR_val).init(base_address + 0x10);

/// ODR
const ODR_val = packed struct {
/// ODR0 [0:0]
/// Port output data (y =
ODR0: u1 = 0,
/// ODR1 [1:1]
/// Port output data (y =
ODR1: u1 = 0,
/// ODR2 [2:2]
/// Port output data (y =
ODR2: u1 = 0,
/// ODR3 [3:3]
/// Port output data (y =
ODR3: u1 = 0,
/// ODR4 [4:4]
/// Port output data (y =
ODR4: u1 = 0,
/// ODR5 [5:5]
/// Port output data (y =
ODR5: u1 = 0,
/// ODR6 [6:6]
/// Port output data (y =
ODR6: u1 = 0,
/// ODR7 [7:7]
/// Port output data (y =
ODR7: u1 = 0,
/// ODR8 [8:8]
/// Port output data (y =
ODR8: u1 = 0,
/// ODR9 [9:9]
/// Port output data (y =
ODR9: u1 = 0,
/// ODR10 [10:10]
/// Port output data (y =
ODR10: u1 = 0,
/// ODR11 [11:11]
/// Port output data (y =
ODR11: u1 = 0,
/// ODR12 [12:12]
/// Port output data (y =
ODR12: u1 = 0,
/// ODR13 [13:13]
/// Port output data (y =
ODR13: u1 = 0,
/// ODR14 [14:14]
/// Port output data (y =
ODR14: u1 = 0,
/// ODR15 [15:15]
/// Port output data (y =
ODR15: u1 = 0,
/// unused [16:31]
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// GPIO port output data register
pub const ODR = Register(ODR_val).init(base_address + 0x14);

/// BSRR
const BSRR_val = packed struct {
/// BS0 [0:0]
/// Port x set bit y (y=
BS0: u1 = 0,
/// BS1 [1:1]
/// Port x set bit y (y=
BS1: u1 = 0,
/// BS2 [2:2]
/// Port x set bit y (y=
BS2: u1 = 0,
/// BS3 [3:3]
/// Port x set bit y (y=
BS3: u1 = 0,
/// BS4 [4:4]
/// Port x set bit y (y=
BS4: u1 = 0,
/// BS5 [5:5]
/// Port x set bit y (y=
BS5: u1 = 0,
/// BS6 [6:6]
/// Port x set bit y (y=
BS6: u1 = 0,
/// BS7 [7:7]
/// Port x set bit y (y=
BS7: u1 = 0,
/// BS8 [8:8]
/// Port x set bit y (y=
BS8: u1 = 0,
/// BS9 [9:9]
/// Port x set bit y (y=
BS9: u1 = 0,
/// BS10 [10:10]
/// Port x set bit y (y=
BS10: u1 = 0,
/// BS11 [11:11]
/// Port x set bit y (y=
BS11: u1 = 0,
/// BS12 [12:12]
/// Port x set bit y (y=
BS12: u1 = 0,
/// BS13 [13:13]
/// Port x set bit y (y=
BS13: u1 = 0,
/// BS14 [14:14]
/// Port x set bit y (y=
BS14: u1 = 0,
/// BS15 [15:15]
/// Port x set bit y (y=
BS15: u1 = 0,
/// BR0 [16:16]
/// Port x set bit y (y=
BR0: u1 = 0,
/// BR1 [17:17]
/// Port x reset bit y (y =
BR1: u1 = 0,
/// BR2 [18:18]
/// Port x reset bit y (y =
BR2: u1 = 0,
/// BR3 [19:19]
/// Port x reset bit y (y =
BR3: u1 = 0,
/// BR4 [20:20]
/// Port x reset bit y (y =
BR4: u1 = 0,
/// BR5 [21:21]
/// Port x reset bit y (y =
BR5: u1 = 0,
/// BR6 [22:22]
/// Port x reset bit y (y =
BR6: u1 = 0,
/// BR7 [23:23]
/// Port x reset bit y (y =
BR7: u1 = 0,
/// BR8 [24:24]
/// Port x reset bit y (y =
BR8: u1 = 0,
/// BR9 [25:25]
/// Port x reset bit y (y =
BR9: u1 = 0,
/// BR10 [26:26]
/// Port x reset bit y (y =
BR10: u1 = 0,
/// BR11 [27:27]
/// Port x reset bit y (y =
BR11: u1 = 0,
/// BR12 [28:28]
/// Port x reset bit y (y =
BR12: u1 = 0,
/// BR13 [29:29]
/// Port x reset bit y (y =
BR13: u1 = 0,
/// BR14 [30:30]
/// Port x reset bit y (y =
BR14: u1 = 0,
/// BR15 [31:31]
/// Port x reset bit y (y =
BR15: u1 = 0,
};
/// GPIO port bit set/reset
pub const BSRR = Register(BSRR_val).init(base_address + 0x18);

/// LCKR
const LCKR_val = packed struct {
/// LCK0 [0:0]
/// Port x lock bit y (y=
LCK0: u1 = 0,
/// LCK1 [1:1]
/// Port x lock bit y (y=
LCK1: u1 = 0,
/// LCK2 [2:2]
/// Port x lock bit y (y=
LCK2: u1 = 0,
/// LCK3 [3:3]
/// Port x lock bit y (y=
LCK3: u1 = 0,
/// LCK4 [4:4]
/// Port x lock bit y (y=
LCK4: u1 = 0,
/// LCK5 [5:5]
/// Port x lock bit y (y=
LCK5: u1 = 0,
/// LCK6 [6:6]
/// Port x lock bit y (y=
LCK6: u1 = 0,
/// LCK7 [7:7]
/// Port x lock bit y (y=
LCK7: u1 = 0,
/// LCK8 [8:8]
/// Port x lock bit y (y=
LCK8: u1 = 0,
/// LCK9 [9:9]
/// Port x lock bit y (y=
LCK9: u1 = 0,
/// LCK10 [10:10]
/// Port x lock bit y (y=
LCK10: u1 = 0,
/// LCK11 [11:11]
/// Port x lock bit y (y=
LCK11: u1 = 0,
/// LCK12 [12:12]
/// Port x lock bit y (y=
LCK12: u1 = 0,
/// LCK13 [13:13]
/// Port x lock bit y (y=
LCK13: u1 = 0,
/// LCK14 [14:14]
/// Port x lock bit y (y=
LCK14: u1 = 0,
/// LCK15 [15:15]
/// Port x lock bit y (y=
LCK15: u1 = 0,
/// LCKK [16:16]
/// Lok Key
LCKK: u1 = 0,
/// unused [17:31]
_unused17: u7 = 0,
_unused24: u8 = 0,
};
/// GPIO port configuration lock
pub const LCKR = Register(LCKR_val).init(base_address + 0x1c);

/// AFRL
const AFRL_val = packed struct {
/// AFRL0 [0:3]
/// Alternate function selection for port x
AFRL0: u4 = 0,
/// AFRL1 [4:7]
/// Alternate function selection for port x
AFRL1: u4 = 0,
/// AFRL2 [8:11]
/// Alternate function selection for port x
AFRL2: u4 = 0,
/// AFRL3 [12:15]
/// Alternate function selection for port x
AFRL3: u4 = 0,
/// AFRL4 [16:19]
/// Alternate function selection for port x
AFRL4: u4 = 0,
/// AFRL5 [20:23]
/// Alternate function selection for port x
AFRL5: u4 = 0,
/// AFRL6 [24:27]
/// Alternate function selection for port x
AFRL6: u4 = 0,
/// AFRL7 [28:31]
/// Alternate function selection for port x
AFRL7: u4 = 0,
};
/// GPIO alternate function low
pub const AFRL = Register(AFRL_val).init(base_address + 0x20);

/// AFRH
const AFRH_val = packed struct {
/// AFRH8 [0:3]
/// Alternate function selection for port x
AFRH8: u4 = 0,
/// AFRH9 [4:7]
/// Alternate function selection for port x
AFRH9: u4 = 0,
/// AFRH10 [8:11]
/// Alternate function selection for port x
AFRH10: u4 = 0,
/// AFRH11 [12:15]
/// Alternate function selection for port x
AFRH11: u4 = 0,
/// AFRH12 [16:19]
/// Alternate function selection for port x
AFRH12: u4 = 0,
/// AFRH13 [20:23]
/// Alternate function selection for port x
AFRH13: u4 = 0,
/// AFRH14 [24:27]
/// Alternate function selection for port x
AFRH14: u4 = 0,
/// AFRH15 [28:31]
/// Alternate function selection for port x
AFRH15: u4 = 0,
};
/// GPIO alternate function high
pub const AFRH = Register(AFRH_val).init(base_address + 0x24);

/// BRR
const BRR_val = packed struct {
/// BR0 [0:0]
/// Port x Reset bit y
BR0: u1 = 0,
/// BR1 [1:1]
/// Port x Reset bit y
BR1: u1 = 0,
/// BR2 [2:2]
/// Port x Reset bit y
BR2: u1 = 0,
/// BR3 [3:3]
/// Port x Reset bit y
BR3: u1 = 0,
/// BR4 [4:4]
/// Port x Reset bit y
BR4: u1 = 0,
/// BR5 [5:5]
/// Port x Reset bit y
BR5: u1 = 0,
/// BR6 [6:6]
/// Port x Reset bit y
BR6: u1 = 0,
/// BR7 [7:7]
/// Port x Reset bit y
BR7: u1 = 0,
/// BR8 [8:8]
/// Port x Reset bit y
BR8: u1 = 0,
/// BR9 [9:9]
/// Port x Reset bit y
BR9: u1 = 0,
/// BR10 [10:10]
/// Port x Reset bit y
BR10: u1 = 0,
/// BR11 [11:11]
/// Port x Reset bit y
BR11: u1 = 0,
/// BR12 [12:12]
/// Port x Reset bit y
BR12: u1 = 0,
/// BR13 [13:13]
/// Port x Reset bit y
BR13: u1 = 0,
/// BR14 [14:14]
/// Port x Reset bit y
BR14: u1 = 0,
/// BR15 [15:15]
/// Port x Reset bit y
BR15: u1 = 0,
/// unused [16:31]
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// Port bit reset register
pub const BRR = Register(BRR_val).init(base_address + 0x28);
};

/// General-purpose I/Os
pub const GPIOG = struct {

const base_address = 0x48001800;
/// MODER
const MODER_val = packed struct {
/// MODER0 [0:1]
/// Port x configuration bits (y =
MODER0: u2 = 0,
/// MODER1 [2:3]
/// Port x configuration bits (y =
MODER1: u2 = 0,
/// MODER2 [4:5]
/// Port x configuration bits (y =
MODER2: u2 = 0,
/// MODER3 [6:7]
/// Port x configuration bits (y =
MODER3: u2 = 0,
/// MODER4 [8:9]
/// Port x configuration bits (y =
MODER4: u2 = 0,
/// MODER5 [10:11]
/// Port x configuration bits (y =
MODER5: u2 = 0,
/// MODER6 [12:13]
/// Port x configuration bits (y =
MODER6: u2 = 0,
/// MODER7 [14:15]
/// Port x configuration bits (y =
MODER7: u2 = 0,
/// MODER8 [16:17]
/// Port x configuration bits (y =
MODER8: u2 = 0,
/// MODER9 [18:19]
/// Port x configuration bits (y =
MODER9: u2 = 0,
/// MODER10 [20:21]
/// Port x configuration bits (y =
MODER10: u2 = 0,
/// MODER11 [22:23]
/// Port x configuration bits (y =
MODER11: u2 = 0,
/// MODER12 [24:25]
/// Port x configuration bits (y =
MODER12: u2 = 0,
/// MODER13 [26:27]
/// Port x configuration bits (y =
MODER13: u2 = 0,
/// MODER14 [28:29]
/// Port x configuration bits (y =
MODER14: u2 = 0,
/// MODER15 [30:31]
/// Port x configuration bits (y =
MODER15: u2 = 0,
};
/// GPIO port mode register
pub const MODER = Register(MODER_val).init(base_address + 0x0);

/// OTYPER
const OTYPER_val = packed struct {
/// OT0 [0:0]
/// Port x configuration bit 0
OT0: u1 = 0,
/// OT1 [1:1]
/// Port x configuration bit 1
OT1: u1 = 0,
/// OT2 [2:2]
/// Port x configuration bit 2
OT2: u1 = 0,
/// OT3 [3:3]
/// Port x configuration bit 3
OT3: u1 = 0,
/// OT4 [4:4]
/// Port x configuration bit 4
OT4: u1 = 0,
/// OT5 [5:5]
/// Port x configuration bit 5
OT5: u1 = 0,
/// OT6 [6:6]
/// Port x configuration bit 6
OT6: u1 = 0,
/// OT7 [7:7]
/// Port x configuration bit 7
OT7: u1 = 0,
/// OT8 [8:8]
/// Port x configuration bit 8
OT8: u1 = 0,
/// OT9 [9:9]
/// Port x configuration bit 9
OT9: u1 = 0,
/// OT10 [10:10]
/// Port x configuration bit
OT10: u1 = 0,
/// OT11 [11:11]
/// Port x configuration bit
OT11: u1 = 0,
/// OT12 [12:12]
/// Port x configuration bit
OT12: u1 = 0,
/// OT13 [13:13]
/// Port x configuration bit
OT13: u1 = 0,
/// OT14 [14:14]
/// Port x configuration bit
OT14: u1 = 0,
/// OT15 [15:15]
/// Port x configuration bit
OT15: u1 = 0,
/// unused [16:31]
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// GPIO port output type register
pub const OTYPER = Register(OTYPER_val).init(base_address + 0x4);

/// OSPEEDR
const OSPEEDR_val = packed struct {
/// OSPEEDR0 [0:1]
/// Port x configuration bits (y =
OSPEEDR0: u2 = 0,
/// OSPEEDR1 [2:3]
/// Port x configuration bits (y =
OSPEEDR1: u2 = 0,
/// OSPEEDR2 [4:5]
/// Port x configuration bits (y =
OSPEEDR2: u2 = 0,
/// OSPEEDR3 [6:7]
/// Port x configuration bits (y =
OSPEEDR3: u2 = 0,
/// OSPEEDR4 [8:9]
/// Port x configuration bits (y =
OSPEEDR4: u2 = 0,
/// OSPEEDR5 [10:11]
/// Port x configuration bits (y =
OSPEEDR5: u2 = 0,
/// OSPEEDR6 [12:13]
/// Port x configuration bits (y =
OSPEEDR6: u2 = 0,
/// OSPEEDR7 [14:15]
/// Port x configuration bits (y =
OSPEEDR7: u2 = 0,
/// OSPEEDR8 [16:17]
/// Port x configuration bits (y =
OSPEEDR8: u2 = 0,
/// OSPEEDR9 [18:19]
/// Port x configuration bits (y =
OSPEEDR9: u2 = 0,
/// OSPEEDR10 [20:21]
/// Port x configuration bits (y =
OSPEEDR10: u2 = 0,
/// OSPEEDR11 [22:23]
/// Port x configuration bits (y =
OSPEEDR11: u2 = 0,
/// OSPEEDR12 [24:25]
/// Port x configuration bits (y =
OSPEEDR12: u2 = 0,
/// OSPEEDR13 [26:27]
/// Port x configuration bits (y =
OSPEEDR13: u2 = 0,
/// OSPEEDR14 [28:29]
/// Port x configuration bits (y =
OSPEEDR14: u2 = 0,
/// OSPEEDR15 [30:31]
/// Port x configuration bits (y =
OSPEEDR15: u2 = 0,
};
/// GPIO port output speed
pub const OSPEEDR = Register(OSPEEDR_val).init(base_address + 0x8);

/// PUPDR
const PUPDR_val = packed struct {
/// PUPDR0 [0:1]
/// Port x configuration bits (y =
PUPDR0: u2 = 0,
/// PUPDR1 [2:3]
/// Port x configuration bits (y =
PUPDR1: u2 = 0,
/// PUPDR2 [4:5]
/// Port x configuration bits (y =
PUPDR2: u2 = 0,
/// PUPDR3 [6:7]
/// Port x configuration bits (y =
PUPDR3: u2 = 0,
/// PUPDR4 [8:9]
/// Port x configuration bits (y =
PUPDR4: u2 = 0,
/// PUPDR5 [10:11]
/// Port x configuration bits (y =
PUPDR5: u2 = 0,
/// PUPDR6 [12:13]
/// Port x configuration bits (y =
PUPDR6: u2 = 0,
/// PUPDR7 [14:15]
/// Port x configuration bits (y =
PUPDR7: u2 = 0,
/// PUPDR8 [16:17]
/// Port x configuration bits (y =
PUPDR8: u2 = 0,
/// PUPDR9 [18:19]
/// Port x configuration bits (y =
PUPDR9: u2 = 0,
/// PUPDR10 [20:21]
/// Port x configuration bits (y =
PUPDR10: u2 = 0,
/// PUPDR11 [22:23]
/// Port x configuration bits (y =
PUPDR11: u2 = 0,
/// PUPDR12 [24:25]
/// Port x configuration bits (y =
PUPDR12: u2 = 0,
/// PUPDR13 [26:27]
/// Port x configuration bits (y =
PUPDR13: u2 = 0,
/// PUPDR14 [28:29]
/// Port x configuration bits (y =
PUPDR14: u2 = 0,
/// PUPDR15 [30:31]
/// Port x configuration bits (y =
PUPDR15: u2 = 0,
};
/// GPIO port pull-up/pull-down
pub const PUPDR = Register(PUPDR_val).init(base_address + 0xc);

/// IDR
const IDR_val = packed struct {
/// IDR0 [0:0]
/// Port input data (y =
IDR0: u1 = 0,
/// IDR1 [1:1]
/// Port input data (y =
IDR1: u1 = 0,
/// IDR2 [2:2]
/// Port input data (y =
IDR2: u1 = 0,
/// IDR3 [3:3]
/// Port input data (y =
IDR3: u1 = 0,
/// IDR4 [4:4]
/// Port input data (y =
IDR4: u1 = 0,
/// IDR5 [5:5]
/// Port input data (y =
IDR5: u1 = 0,
/// IDR6 [6:6]
/// Port input data (y =
IDR6: u1 = 0,
/// IDR7 [7:7]
/// Port input data (y =
IDR7: u1 = 0,
/// IDR8 [8:8]
/// Port input data (y =
IDR8: u1 = 0,
/// IDR9 [9:9]
/// Port input data (y =
IDR9: u1 = 0,
/// IDR10 [10:10]
/// Port input data (y =
IDR10: u1 = 0,
/// IDR11 [11:11]
/// Port input data (y =
IDR11: u1 = 0,
/// IDR12 [12:12]
/// Port input data (y =
IDR12: u1 = 0,
/// IDR13 [13:13]
/// Port input data (y =
IDR13: u1 = 0,
/// IDR14 [14:14]
/// Port input data (y =
IDR14: u1 = 0,
/// IDR15 [15:15]
/// Port input data (y =
IDR15: u1 = 0,
/// unused [16:31]
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// GPIO port input data register
pub const IDR = Register(IDR_val).init(base_address + 0x10);

/// ODR
const ODR_val = packed struct {
/// ODR0 [0:0]
/// Port output data (y =
ODR0: u1 = 0,
/// ODR1 [1:1]
/// Port output data (y =
ODR1: u1 = 0,
/// ODR2 [2:2]
/// Port output data (y =
ODR2: u1 = 0,
/// ODR3 [3:3]
/// Port output data (y =
ODR3: u1 = 0,
/// ODR4 [4:4]
/// Port output data (y =
ODR4: u1 = 0,
/// ODR5 [5:5]
/// Port output data (y =
ODR5: u1 = 0,
/// ODR6 [6:6]
/// Port output data (y =
ODR6: u1 = 0,
/// ODR7 [7:7]
/// Port output data (y =
ODR7: u1 = 0,
/// ODR8 [8:8]
/// Port output data (y =
ODR8: u1 = 0,
/// ODR9 [9:9]
/// Port output data (y =
ODR9: u1 = 0,
/// ODR10 [10:10]
/// Port output data (y =
ODR10: u1 = 0,
/// ODR11 [11:11]
/// Port output data (y =
ODR11: u1 = 0,
/// ODR12 [12:12]
/// Port output data (y =
ODR12: u1 = 0,
/// ODR13 [13:13]
/// Port output data (y =
ODR13: u1 = 0,
/// ODR14 [14:14]
/// Port output data (y =
ODR14: u1 = 0,
/// ODR15 [15:15]
/// Port output data (y =
ODR15: u1 = 0,
/// unused [16:31]
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// GPIO port output data register
pub const ODR = Register(ODR_val).init(base_address + 0x14);

/// BSRR
const BSRR_val = packed struct {
/// BS0 [0:0]
/// Port x set bit y (y=
BS0: u1 = 0,
/// BS1 [1:1]
/// Port x set bit y (y=
BS1: u1 = 0,
/// BS2 [2:2]
/// Port x set bit y (y=
BS2: u1 = 0,
/// BS3 [3:3]
/// Port x set bit y (y=
BS3: u1 = 0,
/// BS4 [4:4]
/// Port x set bit y (y=
BS4: u1 = 0,
/// BS5 [5:5]
/// Port x set bit y (y=
BS5: u1 = 0,
/// BS6 [6:6]
/// Port x set bit y (y=
BS6: u1 = 0,
/// BS7 [7:7]
/// Port x set bit y (y=
BS7: u1 = 0,
/// BS8 [8:8]
/// Port x set bit y (y=
BS8: u1 = 0,
/// BS9 [9:9]
/// Port x set bit y (y=
BS9: u1 = 0,
/// BS10 [10:10]
/// Port x set bit y (y=
BS10: u1 = 0,
/// BS11 [11:11]
/// Port x set bit y (y=
BS11: u1 = 0,
/// BS12 [12:12]
/// Port x set bit y (y=
BS12: u1 = 0,
/// BS13 [13:13]
/// Port x set bit y (y=
BS13: u1 = 0,
/// BS14 [14:14]
/// Port x set bit y (y=
BS14: u1 = 0,
/// BS15 [15:15]
/// Port x set bit y (y=
BS15: u1 = 0,
/// BR0 [16:16]
/// Port x set bit y (y=
BR0: u1 = 0,
/// BR1 [17:17]
/// Port x reset bit y (y =
BR1: u1 = 0,
/// BR2 [18:18]
/// Port x reset bit y (y =
BR2: u1 = 0,
/// BR3 [19:19]
/// Port x reset bit y (y =
BR3: u1 = 0,
/// BR4 [20:20]
/// Port x reset bit y (y =
BR4: u1 = 0,
/// BR5 [21:21]
/// Port x reset bit y (y =
BR5: u1 = 0,
/// BR6 [22:22]
/// Port x reset bit y (y =
BR6: u1 = 0,
/// BR7 [23:23]
/// Port x reset bit y (y =
BR7: u1 = 0,
/// BR8 [24:24]
/// Port x reset bit y (y =
BR8: u1 = 0,
/// BR9 [25:25]
/// Port x reset bit y (y =
BR9: u1 = 0,
/// BR10 [26:26]
/// Port x reset bit y (y =
BR10: u1 = 0,
/// BR11 [27:27]
/// Port x reset bit y (y =
BR11: u1 = 0,
/// BR12 [28:28]
/// Port x reset bit y (y =
BR12: u1 = 0,
/// BR13 [29:29]
/// Port x reset bit y (y =
BR13: u1 = 0,
/// BR14 [30:30]
/// Port x reset bit y (y =
BR14: u1 = 0,
/// BR15 [31:31]
/// Port x reset bit y (y =
BR15: u1 = 0,
};
/// GPIO port bit set/reset
pub const BSRR = Register(BSRR_val).init(base_address + 0x18);

/// LCKR
const LCKR_val = packed struct {
/// LCK0 [0:0]
/// Port x lock bit y (y=
LCK0: u1 = 0,
/// LCK1 [1:1]
/// Port x lock bit y (y=
LCK1: u1 = 0,
/// LCK2 [2:2]
/// Port x lock bit y (y=
LCK2: u1 = 0,
/// LCK3 [3:3]
/// Port x lock bit y (y=
LCK3: u1 = 0,
/// LCK4 [4:4]
/// Port x lock bit y (y=
LCK4: u1 = 0,
/// LCK5 [5:5]
/// Port x lock bit y (y=
LCK5: u1 = 0,
/// LCK6 [6:6]
/// Port x lock bit y (y=
LCK6: u1 = 0,
/// LCK7 [7:7]
/// Port x lock bit y (y=
LCK7: u1 = 0,
/// LCK8 [8:8]
/// Port x lock bit y (y=
LCK8: u1 = 0,
/// LCK9 [9:9]
/// Port x lock bit y (y=
LCK9: u1 = 0,
/// LCK10 [10:10]
/// Port x lock bit y (y=
LCK10: u1 = 0,
/// LCK11 [11:11]
/// Port x lock bit y (y=
LCK11: u1 = 0,
/// LCK12 [12:12]
/// Port x lock bit y (y=
LCK12: u1 = 0,
/// LCK13 [13:13]
/// Port x lock bit y (y=
LCK13: u1 = 0,
/// LCK14 [14:14]
/// Port x lock bit y (y=
LCK14: u1 = 0,
/// LCK15 [15:15]
/// Port x lock bit y (y=
LCK15: u1 = 0,
/// LCKK [16:16]
/// Lok Key
LCKK: u1 = 0,
/// unused [17:31]
_unused17: u7 = 0,
_unused24: u8 = 0,
};
/// GPIO port configuration lock
pub const LCKR = Register(LCKR_val).init(base_address + 0x1c);

/// AFRL
const AFRL_val = packed struct {
/// AFRL0 [0:3]
/// Alternate function selection for port x
AFRL0: u4 = 0,
/// AFRL1 [4:7]
/// Alternate function selection for port x
AFRL1: u4 = 0,
/// AFRL2 [8:11]
/// Alternate function selection for port x
AFRL2: u4 = 0,
/// AFRL3 [12:15]
/// Alternate function selection for port x
AFRL3: u4 = 0,
/// AFRL4 [16:19]
/// Alternate function selection for port x
AFRL4: u4 = 0,
/// AFRL5 [20:23]
/// Alternate function selection for port x
AFRL5: u4 = 0,
/// AFRL6 [24:27]
/// Alternate function selection for port x
AFRL6: u4 = 0,
/// AFRL7 [28:31]
/// Alternate function selection for port x
AFRL7: u4 = 0,
};
/// GPIO alternate function low
pub const AFRL = Register(AFRL_val).init(base_address + 0x20);

/// AFRH
const AFRH_val = packed struct {
/// AFRH8 [0:3]
/// Alternate function selection for port x
AFRH8: u4 = 0,
/// AFRH9 [4:7]
/// Alternate function selection for port x
AFRH9: u4 = 0,
/// AFRH10 [8:11]
/// Alternate function selection for port x
AFRH10: u4 = 0,
/// AFRH11 [12:15]
/// Alternate function selection for port x
AFRH11: u4 = 0,
/// AFRH12 [16:19]
/// Alternate function selection for port x
AFRH12: u4 = 0,
/// AFRH13 [20:23]
/// Alternate function selection for port x
AFRH13: u4 = 0,
/// AFRH14 [24:27]
/// Alternate function selection for port x
AFRH14: u4 = 0,
/// AFRH15 [28:31]
/// Alternate function selection for port x
AFRH15: u4 = 0,
};
/// GPIO alternate function high
pub const AFRH = Register(AFRH_val).init(base_address + 0x24);

/// BRR
const BRR_val = packed struct {
/// BR0 [0:0]
/// Port x Reset bit y
BR0: u1 = 0,
/// BR1 [1:1]
/// Port x Reset bit y
BR1: u1 = 0,
/// BR2 [2:2]
/// Port x Reset bit y
BR2: u1 = 0,
/// BR3 [3:3]
/// Port x Reset bit y
BR3: u1 = 0,
/// BR4 [4:4]
/// Port x Reset bit y
BR4: u1 = 0,
/// BR5 [5:5]
/// Port x Reset bit y
BR5: u1 = 0,
/// BR6 [6:6]
/// Port x Reset bit y
BR6: u1 = 0,
/// BR7 [7:7]
/// Port x Reset bit y
BR7: u1 = 0,
/// BR8 [8:8]
/// Port x Reset bit y
BR8: u1 = 0,
/// BR9 [9:9]
/// Port x Reset bit y
BR9: u1 = 0,
/// BR10 [10:10]
/// Port x Reset bit y
BR10: u1 = 0,
/// BR11 [11:11]
/// Port x Reset bit y
BR11: u1 = 0,
/// BR12 [12:12]
/// Port x Reset bit y
BR12: u1 = 0,
/// BR13 [13:13]
/// Port x Reset bit y
BR13: u1 = 0,
/// BR14 [14:14]
/// Port x Reset bit y
BR14: u1 = 0,
/// BR15 [15:15]
/// Port x Reset bit y
BR15: u1 = 0,
/// unused [16:31]
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// Port bit reset register
pub const BRR = Register(BRR_val).init(base_address + 0x28);
};

/// General-purpose I/Os
pub const GPIOH = struct {

const base_address = 0x48001c00;
/// MODER
const MODER_val = packed struct {
/// MODER0 [0:1]
/// Port x configuration bits (y =
MODER0: u2 = 0,
/// MODER1 [2:3]
/// Port x configuration bits (y =
MODER1: u2 = 0,
/// MODER2 [4:5]
/// Port x configuration bits (y =
MODER2: u2 = 0,
/// MODER3 [6:7]
/// Port x configuration bits (y =
MODER3: u2 = 0,
/// MODER4 [8:9]
/// Port x configuration bits (y =
MODER4: u2 = 0,
/// MODER5 [10:11]
/// Port x configuration bits (y =
MODER5: u2 = 0,
/// MODER6 [12:13]
/// Port x configuration bits (y =
MODER6: u2 = 0,
/// MODER7 [14:15]
/// Port x configuration bits (y =
MODER7: u2 = 0,
/// MODER8 [16:17]
/// Port x configuration bits (y =
MODER8: u2 = 0,
/// MODER9 [18:19]
/// Port x configuration bits (y =
MODER9: u2 = 0,
/// MODER10 [20:21]
/// Port x configuration bits (y =
MODER10: u2 = 0,
/// MODER11 [22:23]
/// Port x configuration bits (y =
MODER11: u2 = 0,
/// MODER12 [24:25]
/// Port x configuration bits (y =
MODER12: u2 = 0,
/// MODER13 [26:27]
/// Port x configuration bits (y =
MODER13: u2 = 0,
/// MODER14 [28:29]
/// Port x configuration bits (y =
MODER14: u2 = 0,
/// MODER15 [30:31]
/// Port x configuration bits (y =
MODER15: u2 = 0,
};
/// GPIO port mode register
pub const MODER = Register(MODER_val).init(base_address + 0x0);

/// OTYPER
const OTYPER_val = packed struct {
/// OT0 [0:0]
/// Port x configuration bit 0
OT0: u1 = 0,
/// OT1 [1:1]
/// Port x configuration bit 1
OT1: u1 = 0,
/// OT2 [2:2]
/// Port x configuration bit 2
OT2: u1 = 0,
/// OT3 [3:3]
/// Port x configuration bit 3
OT3: u1 = 0,
/// OT4 [4:4]
/// Port x configuration bit 4
OT4: u1 = 0,
/// OT5 [5:5]
/// Port x configuration bit 5
OT5: u1 = 0,
/// OT6 [6:6]
/// Port x configuration bit 6
OT6: u1 = 0,
/// OT7 [7:7]
/// Port x configuration bit 7
OT7: u1 = 0,
/// OT8 [8:8]
/// Port x configuration bit 8
OT8: u1 = 0,
/// OT9 [9:9]
/// Port x configuration bit 9
OT9: u1 = 0,
/// OT10 [10:10]
/// Port x configuration bit
OT10: u1 = 0,
/// OT11 [11:11]
/// Port x configuration bit
OT11: u1 = 0,
/// OT12 [12:12]
/// Port x configuration bit
OT12: u1 = 0,
/// OT13 [13:13]
/// Port x configuration bit
OT13: u1 = 0,
/// OT14 [14:14]
/// Port x configuration bit
OT14: u1 = 0,
/// OT15 [15:15]
/// Port x configuration bit
OT15: u1 = 0,
/// unused [16:31]
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// GPIO port output type register
pub const OTYPER = Register(OTYPER_val).init(base_address + 0x4);

/// OSPEEDR
const OSPEEDR_val = packed struct {
/// OSPEEDR0 [0:1]
/// Port x configuration bits (y =
OSPEEDR0: u2 = 0,
/// OSPEEDR1 [2:3]
/// Port x configuration bits (y =
OSPEEDR1: u2 = 0,
/// OSPEEDR2 [4:5]
/// Port x configuration bits (y =
OSPEEDR2: u2 = 0,
/// OSPEEDR3 [6:7]
/// Port x configuration bits (y =
OSPEEDR3: u2 = 0,
/// OSPEEDR4 [8:9]
/// Port x configuration bits (y =
OSPEEDR4: u2 = 0,
/// OSPEEDR5 [10:11]
/// Port x configuration bits (y =
OSPEEDR5: u2 = 0,
/// OSPEEDR6 [12:13]
/// Port x configuration bits (y =
OSPEEDR6: u2 = 0,
/// OSPEEDR7 [14:15]
/// Port x configuration bits (y =
OSPEEDR7: u2 = 0,
/// OSPEEDR8 [16:17]
/// Port x configuration bits (y =
OSPEEDR8: u2 = 0,
/// OSPEEDR9 [18:19]
/// Port x configuration bits (y =
OSPEEDR9: u2 = 0,
/// OSPEEDR10 [20:21]
/// Port x configuration bits (y =
OSPEEDR10: u2 = 0,
/// OSPEEDR11 [22:23]
/// Port x configuration bits (y =
OSPEEDR11: u2 = 0,
/// OSPEEDR12 [24:25]
/// Port x configuration bits (y =
OSPEEDR12: u2 = 0,
/// OSPEEDR13 [26:27]
/// Port x configuration bits (y =
OSPEEDR13: u2 = 0,
/// OSPEEDR14 [28:29]
/// Port x configuration bits (y =
OSPEEDR14: u2 = 0,
/// OSPEEDR15 [30:31]
/// Port x configuration bits (y =
OSPEEDR15: u2 = 0,
};
/// GPIO port output speed
pub const OSPEEDR = Register(OSPEEDR_val).init(base_address + 0x8);

/// PUPDR
const PUPDR_val = packed struct {
/// PUPDR0 [0:1]
/// Port x configuration bits (y =
PUPDR0: u2 = 0,
/// PUPDR1 [2:3]
/// Port x configuration bits (y =
PUPDR1: u2 = 0,
/// PUPDR2 [4:5]
/// Port x configuration bits (y =
PUPDR2: u2 = 0,
/// PUPDR3 [6:7]
/// Port x configuration bits (y =
PUPDR3: u2 = 0,
/// PUPDR4 [8:9]
/// Port x configuration bits (y =
PUPDR4: u2 = 0,
/// PUPDR5 [10:11]
/// Port x configuration bits (y =
PUPDR5: u2 = 0,
/// PUPDR6 [12:13]
/// Port x configuration bits (y =
PUPDR6: u2 = 0,
/// PUPDR7 [14:15]
/// Port x configuration bits (y =
PUPDR7: u2 = 0,
/// PUPDR8 [16:17]
/// Port x configuration bits (y =
PUPDR8: u2 = 0,
/// PUPDR9 [18:19]
/// Port x configuration bits (y =
PUPDR9: u2 = 0,
/// PUPDR10 [20:21]
/// Port x configuration bits (y =
PUPDR10: u2 = 0,
/// PUPDR11 [22:23]
/// Port x configuration bits (y =
PUPDR11: u2 = 0,
/// PUPDR12 [24:25]
/// Port x configuration bits (y =
PUPDR12: u2 = 0,
/// PUPDR13 [26:27]
/// Port x configuration bits (y =
PUPDR13: u2 = 0,
/// PUPDR14 [28:29]
/// Port x configuration bits (y =
PUPDR14: u2 = 0,
/// PUPDR15 [30:31]
/// Port x configuration bits (y =
PUPDR15: u2 = 0,
};
/// GPIO port pull-up/pull-down
pub const PUPDR = Register(PUPDR_val).init(base_address + 0xc);

/// IDR
const IDR_val = packed struct {
/// IDR0 [0:0]
/// Port input data (y =
IDR0: u1 = 0,
/// IDR1 [1:1]
/// Port input data (y =
IDR1: u1 = 0,
/// IDR2 [2:2]
/// Port input data (y =
IDR2: u1 = 0,
/// IDR3 [3:3]
/// Port input data (y =
IDR3: u1 = 0,
/// IDR4 [4:4]
/// Port input data (y =
IDR4: u1 = 0,
/// IDR5 [5:5]
/// Port input data (y =
IDR5: u1 = 0,
/// IDR6 [6:6]
/// Port input data (y =
IDR6: u1 = 0,
/// IDR7 [7:7]
/// Port input data (y =
IDR7: u1 = 0,
/// IDR8 [8:8]
/// Port input data (y =
IDR8: u1 = 0,
/// IDR9 [9:9]
/// Port input data (y =
IDR9: u1 = 0,
/// IDR10 [10:10]
/// Port input data (y =
IDR10: u1 = 0,
/// IDR11 [11:11]
/// Port input data (y =
IDR11: u1 = 0,
/// IDR12 [12:12]
/// Port input data (y =
IDR12: u1 = 0,
/// IDR13 [13:13]
/// Port input data (y =
IDR13: u1 = 0,
/// IDR14 [14:14]
/// Port input data (y =
IDR14: u1 = 0,
/// IDR15 [15:15]
/// Port input data (y =
IDR15: u1 = 0,
/// unused [16:31]
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// GPIO port input data register
pub const IDR = Register(IDR_val).init(base_address + 0x10);

/// ODR
const ODR_val = packed struct {
/// ODR0 [0:0]
/// Port output data (y =
ODR0: u1 = 0,
/// ODR1 [1:1]
/// Port output data (y =
ODR1: u1 = 0,
/// ODR2 [2:2]
/// Port output data (y =
ODR2: u1 = 0,
/// ODR3 [3:3]
/// Port output data (y =
ODR3: u1 = 0,
/// ODR4 [4:4]
/// Port output data (y =
ODR4: u1 = 0,
/// ODR5 [5:5]
/// Port output data (y =
ODR5: u1 = 0,
/// ODR6 [6:6]
/// Port output data (y =
ODR6: u1 = 0,
/// ODR7 [7:7]
/// Port output data (y =
ODR7: u1 = 0,
/// ODR8 [8:8]
/// Port output data (y =
ODR8: u1 = 0,
/// ODR9 [9:9]
/// Port output data (y =
ODR9: u1 = 0,
/// ODR10 [10:10]
/// Port output data (y =
ODR10: u1 = 0,
/// ODR11 [11:11]
/// Port output data (y =
ODR11: u1 = 0,
/// ODR12 [12:12]
/// Port output data (y =
ODR12: u1 = 0,
/// ODR13 [13:13]
/// Port output data (y =
ODR13: u1 = 0,
/// ODR14 [14:14]
/// Port output data (y =
ODR14: u1 = 0,
/// ODR15 [15:15]
/// Port output data (y =
ODR15: u1 = 0,
/// unused [16:31]
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// GPIO port output data register
pub const ODR = Register(ODR_val).init(base_address + 0x14);

/// BSRR
const BSRR_val = packed struct {
/// BS0 [0:0]
/// Port x set bit y (y=
BS0: u1 = 0,
/// BS1 [1:1]
/// Port x set bit y (y=
BS1: u1 = 0,
/// BS2 [2:2]
/// Port x set bit y (y=
BS2: u1 = 0,
/// BS3 [3:3]
/// Port x set bit y (y=
BS3: u1 = 0,
/// BS4 [4:4]
/// Port x set bit y (y=
BS4: u1 = 0,
/// BS5 [5:5]
/// Port x set bit y (y=
BS5: u1 = 0,
/// BS6 [6:6]
/// Port x set bit y (y=
BS6: u1 = 0,
/// BS7 [7:7]
/// Port x set bit y (y=
BS7: u1 = 0,
/// BS8 [8:8]
/// Port x set bit y (y=
BS8: u1 = 0,
/// BS9 [9:9]
/// Port x set bit y (y=
BS9: u1 = 0,
/// BS10 [10:10]
/// Port x set bit y (y=
BS10: u1 = 0,
/// BS11 [11:11]
/// Port x set bit y (y=
BS11: u1 = 0,
/// BS12 [12:12]
/// Port x set bit y (y=
BS12: u1 = 0,
/// BS13 [13:13]
/// Port x set bit y (y=
BS13: u1 = 0,
/// BS14 [14:14]
/// Port x set bit y (y=
BS14: u1 = 0,
/// BS15 [15:15]
/// Port x set bit y (y=
BS15: u1 = 0,
/// BR0 [16:16]
/// Port x set bit y (y=
BR0: u1 = 0,
/// BR1 [17:17]
/// Port x reset bit y (y =
BR1: u1 = 0,
/// BR2 [18:18]
/// Port x reset bit y (y =
BR2: u1 = 0,
/// BR3 [19:19]
/// Port x reset bit y (y =
BR3: u1 = 0,
/// BR4 [20:20]
/// Port x reset bit y (y =
BR4: u1 = 0,
/// BR5 [21:21]
/// Port x reset bit y (y =
BR5: u1 = 0,
/// BR6 [22:22]
/// Port x reset bit y (y =
BR6: u1 = 0,
/// BR7 [23:23]
/// Port x reset bit y (y =
BR7: u1 = 0,
/// BR8 [24:24]
/// Port x reset bit y (y =
BR8: u1 = 0,
/// BR9 [25:25]
/// Port x reset bit y (y =
BR9: u1 = 0,
/// BR10 [26:26]
/// Port x reset bit y (y =
BR10: u1 = 0,
/// BR11 [27:27]
/// Port x reset bit y (y =
BR11: u1 = 0,
/// BR12 [28:28]
/// Port x reset bit y (y =
BR12: u1 = 0,
/// BR13 [29:29]
/// Port x reset bit y (y =
BR13: u1 = 0,
/// BR14 [30:30]
/// Port x reset bit y (y =
BR14: u1 = 0,
/// BR15 [31:31]
/// Port x reset bit y (y =
BR15: u1 = 0,
};
/// GPIO port bit set/reset
pub const BSRR = Register(BSRR_val).init(base_address + 0x18);

/// LCKR
const LCKR_val = packed struct {
/// LCK0 [0:0]
/// Port x lock bit y (y=
LCK0: u1 = 0,
/// LCK1 [1:1]
/// Port x lock bit y (y=
LCK1: u1 = 0,
/// LCK2 [2:2]
/// Port x lock bit y (y=
LCK2: u1 = 0,
/// LCK3 [3:3]
/// Port x lock bit y (y=
LCK3: u1 = 0,
/// LCK4 [4:4]
/// Port x lock bit y (y=
LCK4: u1 = 0,
/// LCK5 [5:5]
/// Port x lock bit y (y=
LCK5: u1 = 0,
/// LCK6 [6:6]
/// Port x lock bit y (y=
LCK6: u1 = 0,
/// LCK7 [7:7]
/// Port x lock bit y (y=
LCK7: u1 = 0,
/// LCK8 [8:8]
/// Port x lock bit y (y=
LCK8: u1 = 0,
/// LCK9 [9:9]
/// Port x lock bit y (y=
LCK9: u1 = 0,
/// LCK10 [10:10]
/// Port x lock bit y (y=
LCK10: u1 = 0,
/// LCK11 [11:11]
/// Port x lock bit y (y=
LCK11: u1 = 0,
/// LCK12 [12:12]
/// Port x lock bit y (y=
LCK12: u1 = 0,
/// LCK13 [13:13]
/// Port x lock bit y (y=
LCK13: u1 = 0,
/// LCK14 [14:14]
/// Port x lock bit y (y=
LCK14: u1 = 0,
/// LCK15 [15:15]
/// Port x lock bit y (y=
LCK15: u1 = 0,
/// LCKK [16:16]
/// Lok Key
LCKK: u1 = 0,
/// unused [17:31]
_unused17: u7 = 0,
_unused24: u8 = 0,
};
/// GPIO port configuration lock
pub const LCKR = Register(LCKR_val).init(base_address + 0x1c);

/// AFRL
const AFRL_val = packed struct {
/// AFRL0 [0:3]
/// Alternate function selection for port x
AFRL0: u4 = 0,
/// AFRL1 [4:7]
/// Alternate function selection for port x
AFRL1: u4 = 0,
/// AFRL2 [8:11]
/// Alternate function selection for port x
AFRL2: u4 = 0,
/// AFRL3 [12:15]
/// Alternate function selection for port x
AFRL3: u4 = 0,
/// AFRL4 [16:19]
/// Alternate function selection for port x
AFRL4: u4 = 0,
/// AFRL5 [20:23]
/// Alternate function selection for port x
AFRL5: u4 = 0,
/// AFRL6 [24:27]
/// Alternate function selection for port x
AFRL6: u4 = 0,
/// AFRL7 [28:31]
/// Alternate function selection for port x
AFRL7: u4 = 0,
};
/// GPIO alternate function low
pub const AFRL = Register(AFRL_val).init(base_address + 0x20);

/// AFRH
const AFRH_val = packed struct {
/// AFRH8 [0:3]
/// Alternate function selection for port x
AFRH8: u4 = 0,
/// AFRH9 [4:7]
/// Alternate function selection for port x
AFRH9: u4 = 0,
/// AFRH10 [8:11]
/// Alternate function selection for port x
AFRH10: u4 = 0,
/// AFRH11 [12:15]
/// Alternate function selection for port x
AFRH11: u4 = 0,
/// AFRH12 [16:19]
/// Alternate function selection for port x
AFRH12: u4 = 0,
/// AFRH13 [20:23]
/// Alternate function selection for port x
AFRH13: u4 = 0,
/// AFRH14 [24:27]
/// Alternate function selection for port x
AFRH14: u4 = 0,
/// AFRH15 [28:31]
/// Alternate function selection for port x
AFRH15: u4 = 0,
};
/// GPIO alternate function high
pub const AFRH = Register(AFRH_val).init(base_address + 0x24);

/// BRR
const BRR_val = packed struct {
/// BR0 [0:0]
/// Port x Reset bit y
BR0: u1 = 0,
/// BR1 [1:1]
/// Port x Reset bit y
BR1: u1 = 0,
/// BR2 [2:2]
/// Port x Reset bit y
BR2: u1 = 0,
/// BR3 [3:3]
/// Port x Reset bit y
BR3: u1 = 0,
/// BR4 [4:4]
/// Port x Reset bit y
BR4: u1 = 0,
/// BR5 [5:5]
/// Port x Reset bit y
BR5: u1 = 0,
/// BR6 [6:6]
/// Port x Reset bit y
BR6: u1 = 0,
/// BR7 [7:7]
/// Port x Reset bit y
BR7: u1 = 0,
/// BR8 [8:8]
/// Port x Reset bit y
BR8: u1 = 0,
/// BR9 [9:9]
/// Port x Reset bit y
BR9: u1 = 0,
/// BR10 [10:10]
/// Port x Reset bit y
BR10: u1 = 0,
/// BR11 [11:11]
/// Port x Reset bit y
BR11: u1 = 0,
/// BR12 [12:12]
/// Port x Reset bit y
BR12: u1 = 0,
/// BR13 [13:13]
/// Port x Reset bit y
BR13: u1 = 0,
/// BR14 [14:14]
/// Port x Reset bit y
BR14: u1 = 0,
/// BR15 [15:15]
/// Port x Reset bit y
BR15: u1 = 0,
/// unused [16:31]
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// Port bit reset register
pub const BRR = Register(BRR_val).init(base_address + 0x28);
};

/// Touch sensing controller
pub const TSC = struct {

const base_address = 0x40024000;
/// CR
const CR_val = packed struct {
/// TSCE [0:0]
/// Touch sensing controller
TSCE: u1 = 0,
/// START [1:1]
/// Start a new acquisition
START: u1 = 0,
/// AM [2:2]
/// Acquisition mode
AM: u1 = 0,
/// SYNCPOL [3:3]
/// Synchronization pin
SYNCPOL: u1 = 0,
/// IODEF [4:4]
/// I/O Default mode
IODEF: u1 = 0,
/// MCV [5:7]
/// Max count value
MCV: u3 = 0,
/// unused [8:11]
_unused8: u4 = 0,
/// PGPSC [12:14]
/// pulse generator prescaler
PGPSC: u3 = 0,
/// SSPSC [15:15]
/// Spread spectrum prescaler
SSPSC: u1 = 0,
/// SSE [16:16]
/// Spread spectrum enable
SSE: u1 = 0,
/// SSD [17:23]
/// Spread spectrum deviation
SSD: u7 = 0,
/// CTPL [24:27]
/// Charge transfer pulse low
CTPL: u4 = 0,
/// CTPH [28:31]
/// Charge transfer pulse high
CTPH: u4 = 0,
};
/// control register
pub const CR = Register(CR_val).init(base_address + 0x0);

/// IER
const IER_val = packed struct {
/// EOAIE [0:0]
/// End of acquisition interrupt
EOAIE: u1 = 0,
/// MCEIE [1:1]
/// Max count error interrupt
MCEIE: u1 = 0,
/// unused [2:31]
_unused2: u6 = 0,
_unused8: u8 = 0,
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// interrupt enable register
pub const IER = Register(IER_val).init(base_address + 0x4);

/// ICR
const ICR_val = packed struct {
/// EOAIC [0:0]
/// End of acquisition interrupt
EOAIC: u1 = 0,
/// MCEIC [1:1]
/// Max count error interrupt
MCEIC: u1 = 0,
/// unused [2:31]
_unused2: u6 = 0,
_unused8: u8 = 0,
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// interrupt clear register
pub const ICR = Register(ICR_val).init(base_address + 0x8);

/// ISR
const ISR_val = packed struct {
/// EOAF [0:0]
/// End of acquisition flag
EOAF: u1 = 0,
/// MCEF [1:1]
/// Max count error flag
MCEF: u1 = 0,
/// unused [2:31]
_unused2: u6 = 0,
_unused8: u8 = 0,
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// interrupt status register
pub const ISR = Register(ISR_val).init(base_address + 0xc);

/// IOHCR
const IOHCR_val = packed struct {
/// G1_IO1 [0:0]
/// G1_IO1 Schmitt trigger hysteresis
G1_IO1: u1 = 1,
/// G1_IO2 [1:1]
/// G1_IO2 Schmitt trigger hysteresis
G1_IO2: u1 = 1,
/// G1_IO3 [2:2]
/// G1_IO3 Schmitt trigger hysteresis
G1_IO3: u1 = 1,
/// G1_IO4 [3:3]
/// G1_IO4 Schmitt trigger hysteresis
G1_IO4: u1 = 1,
/// G2_IO1 [4:4]
/// G2_IO1 Schmitt trigger hysteresis
G2_IO1: u1 = 1,
/// G2_IO2 [5:5]
/// G2_IO2 Schmitt trigger hysteresis
G2_IO2: u1 = 1,
/// G2_IO3 [6:6]
/// G2_IO3 Schmitt trigger hysteresis
G2_IO3: u1 = 1,
/// G2_IO4 [7:7]
/// G2_IO4 Schmitt trigger hysteresis
G2_IO4: u1 = 1,
/// G3_IO1 [8:8]
/// G3_IO1 Schmitt trigger hysteresis
G3_IO1: u1 = 1,
/// G3_IO2 [9:9]
/// G3_IO2 Schmitt trigger hysteresis
G3_IO2: u1 = 1,
/// G3_IO3 [10:10]
/// G3_IO3 Schmitt trigger hysteresis
G3_IO3: u1 = 1,
/// G3_IO4 [11:11]
/// G3_IO4 Schmitt trigger hysteresis
G3_IO4: u1 = 1,
/// G4_IO1 [12:12]
/// G4_IO1 Schmitt trigger hysteresis
G4_IO1: u1 = 1,
/// G4_IO2 [13:13]
/// G4_IO2 Schmitt trigger hysteresis
G4_IO2: u1 = 1,
/// G4_IO3 [14:14]
/// G4_IO3 Schmitt trigger hysteresis
G4_IO3: u1 = 1,
/// G4_IO4 [15:15]
/// G4_IO4 Schmitt trigger hysteresis
G4_IO4: u1 = 1,
/// G5_IO1 [16:16]
/// G5_IO1 Schmitt trigger hysteresis
G5_IO1: u1 = 1,
/// G5_IO2 [17:17]
/// G5_IO2 Schmitt trigger hysteresis
G5_IO2: u1 = 1,
/// G5_IO3 [18:18]
/// G5_IO3 Schmitt trigger hysteresis
G5_IO3: u1 = 1,
/// G5_IO4 [19:19]
/// G5_IO4 Schmitt trigger hysteresis
G5_IO4: u1 = 1,
/// G6_IO1 [20:20]
/// G6_IO1 Schmitt trigger hysteresis
G6_IO1: u1 = 1,
/// G6_IO2 [21:21]
/// G6_IO2 Schmitt trigger hysteresis
G6_IO2: u1 = 1,
/// G6_IO3 [22:22]
/// G6_IO3 Schmitt trigger hysteresis
G6_IO3: u1 = 1,
/// G6_IO4 [23:23]
/// G6_IO4 Schmitt trigger hysteresis
G6_IO4: u1 = 1,
/// G7_IO1 [24:24]
/// G7_IO1 Schmitt trigger hysteresis
G7_IO1: u1 = 1,
/// G7_IO2 [25:25]
/// G7_IO2 Schmitt trigger hysteresis
G7_IO2: u1 = 1,
/// G7_IO3 [26:26]
/// G7_IO3 Schmitt trigger hysteresis
G7_IO3: u1 = 1,
/// G7_IO4 [27:27]
/// G7_IO4 Schmitt trigger hysteresis
G7_IO4: u1 = 1,
/// G8_IO1 [28:28]
/// G8_IO1 Schmitt trigger hysteresis
G8_IO1: u1 = 1,
/// G8_IO2 [29:29]
/// G8_IO2 Schmitt trigger hysteresis
G8_IO2: u1 = 1,
/// G8_IO3 [30:30]
/// G8_IO3 Schmitt trigger hysteresis
G8_IO3: u1 = 1,
/// G8_IO4 [31:31]
/// G8_IO4 Schmitt trigger hysteresis
G8_IO4: u1 = 1,
};
/// I/O hysteresis control
pub const IOHCR = Register(IOHCR_val).init(base_address + 0x10);

/// IOASCR
const IOASCR_val = packed struct {
/// G1_IO1 [0:0]
/// G1_IO1 analog switch
G1_IO1: u1 = 0,
/// G1_IO2 [1:1]
/// G1_IO2 analog switch
G1_IO2: u1 = 0,
/// G1_IO3 [2:2]
/// G1_IO3 analog switch
G1_IO3: u1 = 0,
/// G1_IO4 [3:3]
/// G1_IO4 analog switch
G1_IO4: u1 = 0,
/// G2_IO1 [4:4]
/// G2_IO1 analog switch
G2_IO1: u1 = 0,
/// G2_IO2 [5:5]
/// G2_IO2 analog switch
G2_IO2: u1 = 0,
/// G2_IO3 [6:6]
/// G2_IO3 analog switch
G2_IO3: u1 = 0,
/// G2_IO4 [7:7]
/// G2_IO4 analog switch
G2_IO4: u1 = 0,
/// G3_IO1 [8:8]
/// G3_IO1 analog switch
G3_IO1: u1 = 0,
/// G3_IO2 [9:9]
/// G3_IO2 analog switch
G3_IO2: u1 = 0,
/// G3_IO3 [10:10]
/// G3_IO3 analog switch
G3_IO3: u1 = 0,
/// G3_IO4 [11:11]
/// G3_IO4 analog switch
G3_IO4: u1 = 0,
/// G4_IO1 [12:12]
/// G4_IO1 analog switch
G4_IO1: u1 = 0,
/// G4_IO2 [13:13]
/// G4_IO2 analog switch
G4_IO2: u1 = 0,
/// G4_IO3 [14:14]
/// G4_IO3 analog switch
G4_IO3: u1 = 0,
/// G4_IO4 [15:15]
/// G4_IO4 analog switch
G4_IO4: u1 = 0,
/// G5_IO1 [16:16]
/// G5_IO1 analog switch
G5_IO1: u1 = 0,
/// G5_IO2 [17:17]
/// G5_IO2 analog switch
G5_IO2: u1 = 0,
/// G5_IO3 [18:18]
/// G5_IO3 analog switch
G5_IO3: u1 = 0,
/// G5_IO4 [19:19]
/// G5_IO4 analog switch
G5_IO4: u1 = 0,
/// G6_IO1 [20:20]
/// G6_IO1 analog switch
G6_IO1: u1 = 0,
/// G6_IO2 [21:21]
/// G6_IO2 analog switch
G6_IO2: u1 = 0,
/// G6_IO3 [22:22]
/// G6_IO3 analog switch
G6_IO3: u1 = 0,
/// G6_IO4 [23:23]
/// G6_IO4 analog switch
G6_IO4: u1 = 0,
/// G7_IO1 [24:24]
/// G7_IO1 analog switch
G7_IO1: u1 = 0,
/// G7_IO2 [25:25]
/// G7_IO2 analog switch
G7_IO2: u1 = 0,
/// G7_IO3 [26:26]
/// G7_IO3 analog switch
G7_IO3: u1 = 0,
/// G7_IO4 [27:27]
/// G7_IO4 analog switch
G7_IO4: u1 = 0,
/// G8_IO1 [28:28]
/// G8_IO1 analog switch
G8_IO1: u1 = 0,
/// G8_IO2 [29:29]
/// G8_IO2 analog switch
G8_IO2: u1 = 0,
/// G8_IO3 [30:30]
/// G8_IO3 analog switch
G8_IO3: u1 = 0,
/// G8_IO4 [31:31]
/// G8_IO4 analog switch
G8_IO4: u1 = 0,
};
/// I/O analog switch control
pub const IOASCR = Register(IOASCR_val).init(base_address + 0x18);

/// IOSCR
const IOSCR_val = packed struct {
/// G1_IO1 [0:0]
/// G1_IO1 sampling mode
G1_IO1: u1 = 0,
/// G1_IO2 [1:1]
/// G1_IO2 sampling mode
G1_IO2: u1 = 0,
/// G1_IO3 [2:2]
/// G1_IO3 sampling mode
G1_IO3: u1 = 0,
/// G1_IO4 [3:3]
/// G1_IO4 sampling mode
G1_IO4: u1 = 0,
/// G2_IO1 [4:4]
/// G2_IO1 sampling mode
G2_IO1: u1 = 0,
/// G2_IO2 [5:5]
/// G2_IO2 sampling mode
G2_IO2: u1 = 0,
/// G2_IO3 [6:6]
/// G2_IO3 sampling mode
G2_IO3: u1 = 0,
/// G2_IO4 [7:7]
/// G2_IO4 sampling mode
G2_IO4: u1 = 0,
/// G3_IO1 [8:8]
/// G3_IO1 sampling mode
G3_IO1: u1 = 0,
/// G3_IO2 [9:9]
/// G3_IO2 sampling mode
G3_IO2: u1 = 0,
/// G3_IO3 [10:10]
/// G3_IO3 sampling mode
G3_IO3: u1 = 0,
/// G3_IO4 [11:11]
/// G3_IO4 sampling mode
G3_IO4: u1 = 0,
/// G4_IO1 [12:12]
/// G4_IO1 sampling mode
G4_IO1: u1 = 0,
/// G4_IO2 [13:13]
/// G4_IO2 sampling mode
G4_IO2: u1 = 0,
/// G4_IO3 [14:14]
/// G4_IO3 sampling mode
G4_IO3: u1 = 0,
/// G4_IO4 [15:15]
/// G4_IO4 sampling mode
G4_IO4: u1 = 0,
/// G5_IO1 [16:16]
/// G5_IO1 sampling mode
G5_IO1: u1 = 0,
/// G5_IO2 [17:17]
/// G5_IO2 sampling mode
G5_IO2: u1 = 0,
/// G5_IO3 [18:18]
/// G5_IO3 sampling mode
G5_IO3: u1 = 0,
/// G5_IO4 [19:19]
/// G5_IO4 sampling mode
G5_IO4: u1 = 0,
/// G6_IO1 [20:20]
/// G6_IO1 sampling mode
G6_IO1: u1 = 0,
/// G6_IO2 [21:21]
/// G6_IO2 sampling mode
G6_IO2: u1 = 0,
/// G6_IO3 [22:22]
/// G6_IO3 sampling mode
G6_IO3: u1 = 0,
/// G6_IO4 [23:23]
/// G6_IO4 sampling mode
G6_IO4: u1 = 0,
/// G7_IO1 [24:24]
/// G7_IO1 sampling mode
G7_IO1: u1 = 0,
/// G7_IO2 [25:25]
/// G7_IO2 sampling mode
G7_IO2: u1 = 0,
/// G7_IO3 [26:26]
/// G7_IO3 sampling mode
G7_IO3: u1 = 0,
/// G7_IO4 [27:27]
/// G7_IO4 sampling mode
G7_IO4: u1 = 0,
/// G8_IO1 [28:28]
/// G8_IO1 sampling mode
G8_IO1: u1 = 0,
/// G8_IO2 [29:29]
/// G8_IO2 sampling mode
G8_IO2: u1 = 0,
/// G8_IO3 [30:30]
/// G8_IO3 sampling mode
G8_IO3: u1 = 0,
/// G8_IO4 [31:31]
/// G8_IO4 sampling mode
G8_IO4: u1 = 0,
};
/// I/O sampling control register
pub const IOSCR = Register(IOSCR_val).init(base_address + 0x20);

/// IOCCR
const IOCCR_val = packed struct {
/// G1_IO1 [0:0]
/// G1_IO1 channel mode
G1_IO1: u1 = 0,
/// G1_IO2 [1:1]
/// G1_IO2 channel mode
G1_IO2: u1 = 0,
/// G1_IO3 [2:2]
/// G1_IO3 channel mode
G1_IO3: u1 = 0,
/// G1_IO4 [3:3]
/// G1_IO4 channel mode
G1_IO4: u1 = 0,
/// G2_IO1 [4:4]
/// G2_IO1 channel mode
G2_IO1: u1 = 0,
/// G2_IO2 [5:5]
/// G2_IO2 channel mode
G2_IO2: u1 = 0,
/// G2_IO3 [6:6]
/// G2_IO3 channel mode
G2_IO3: u1 = 0,
/// G2_IO4 [7:7]
/// G2_IO4 channel mode
G2_IO4: u1 = 0,
/// G3_IO1 [8:8]
/// G3_IO1 channel mode
G3_IO1: u1 = 0,
/// G3_IO2 [9:9]
/// G3_IO2 channel mode
G3_IO2: u1 = 0,
/// G3_IO3 [10:10]
/// G3_IO3 channel mode
G3_IO3: u1 = 0,
/// G3_IO4 [11:11]
/// G3_IO4 channel mode
G3_IO4: u1 = 0,
/// G4_IO1 [12:12]
/// G4_IO1 channel mode
G4_IO1: u1 = 0,
/// G4_IO2 [13:13]
/// G4_IO2 channel mode
G4_IO2: u1 = 0,
/// G4_IO3 [14:14]
/// G4_IO3 channel mode
G4_IO3: u1 = 0,
/// G4_IO4 [15:15]
/// G4_IO4 channel mode
G4_IO4: u1 = 0,
/// G5_IO1 [16:16]
/// G5_IO1 channel mode
G5_IO1: u1 = 0,
/// G5_IO2 [17:17]
/// G5_IO2 channel mode
G5_IO2: u1 = 0,
/// G5_IO3 [18:18]
/// G5_IO3 channel mode
G5_IO3: u1 = 0,
/// G5_IO4 [19:19]
/// G5_IO4 channel mode
G5_IO4: u1 = 0,
/// G6_IO1 [20:20]
/// G6_IO1 channel mode
G6_IO1: u1 = 0,
/// G6_IO2 [21:21]
/// G6_IO2 channel mode
G6_IO2: u1 = 0,
/// G6_IO3 [22:22]
/// G6_IO3 channel mode
G6_IO3: u1 = 0,
/// G6_IO4 [23:23]
/// G6_IO4 channel mode
G6_IO4: u1 = 0,
/// G7_IO1 [24:24]
/// G7_IO1 channel mode
G7_IO1: u1 = 0,
/// G7_IO2 [25:25]
/// G7_IO2 channel mode
G7_IO2: u1 = 0,
/// G7_IO3 [26:26]
/// G7_IO3 channel mode
G7_IO3: u1 = 0,
/// G7_IO4 [27:27]
/// G7_IO4 channel mode
G7_IO4: u1 = 0,
/// G8_IO1 [28:28]
/// G8_IO1 channel mode
G8_IO1: u1 = 0,
/// G8_IO2 [29:29]
/// G8_IO2 channel mode
G8_IO2: u1 = 0,
/// G8_IO3 [30:30]
/// G8_IO3 channel mode
G8_IO3: u1 = 0,
/// G8_IO4 [31:31]
/// G8_IO4 channel mode
G8_IO4: u1 = 0,
};
/// I/O channel control register
pub const IOCCR = Register(IOCCR_val).init(base_address + 0x28);

/// IOGCSR
const IOGCSR_val = packed struct {
/// G1E [0:0]
/// Analog I/O group x enable
G1E: u1 = 0,
/// G2E [1:1]
/// Analog I/O group x enable
G2E: u1 = 0,
/// G3E [2:2]
/// Analog I/O group x enable
G3E: u1 = 0,
/// G4E [3:3]
/// Analog I/O group x enable
G4E: u1 = 0,
/// G5E [4:4]
/// Analog I/O group x enable
G5E: u1 = 0,
/// G6E [5:5]
/// Analog I/O group x enable
G6E: u1 = 0,
/// G7E [6:6]
/// Analog I/O group x enable
G7E: u1 = 0,
/// G8E [7:7]
/// Analog I/O group x enable
G8E: u1 = 0,
/// unused [8:15]
_unused8: u8 = 0,
/// G1S [16:16]
/// Analog I/O group x status
G1S: u1 = 0,
/// G2S [17:17]
/// Analog I/O group x status
G2S: u1 = 0,
/// G3S [18:18]
/// Analog I/O group x status
G3S: u1 = 0,
/// G4S [19:19]
/// Analog I/O group x status
G4S: u1 = 0,
/// G5S [20:20]
/// Analog I/O group x status
G5S: u1 = 0,
/// G6S [21:21]
/// Analog I/O group x status
G6S: u1 = 0,
/// G7S [22:22]
/// Analog I/O group x status
G7S: u1 = 0,
/// G8S [23:23]
/// Analog I/O group x status
G8S: u1 = 0,
/// unused [24:31]
_unused24: u8 = 0,
};
/// I/O group control status
pub const IOGCSR = Register(IOGCSR_val).init(base_address + 0x30);

/// IOG1CR
const IOG1CR_val = packed struct {
/// CNT [0:13]
/// Counter value
CNT: u14 = 0,
/// unused [14:31]
_unused14: u2 = 0,
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// I/O group x counter register
pub const IOG1CR = Register(IOG1CR_val).init(base_address + 0x34);

/// IOG2CR
const IOG2CR_val = packed struct {
/// CNT [0:13]
/// Counter value
CNT: u14 = 0,
/// unused [14:31]
_unused14: u2 = 0,
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// I/O group x counter register
pub const IOG2CR = Register(IOG2CR_val).init(base_address + 0x38);

/// IOG3CR
const IOG3CR_val = packed struct {
/// CNT [0:13]
/// Counter value
CNT: u14 = 0,
/// unused [14:31]
_unused14: u2 = 0,
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// I/O group x counter register
pub const IOG3CR = Register(IOG3CR_val).init(base_address + 0x3c);

/// IOG4CR
const IOG4CR_val = packed struct {
/// CNT [0:13]
/// Counter value
CNT: u14 = 0,
/// unused [14:31]
_unused14: u2 = 0,
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// I/O group x counter register
pub const IOG4CR = Register(IOG4CR_val).init(base_address + 0x40);

/// IOG5CR
const IOG5CR_val = packed struct {
/// CNT [0:13]
/// Counter value
CNT: u14 = 0,
/// unused [14:31]
_unused14: u2 = 0,
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// I/O group x counter register
pub const IOG5CR = Register(IOG5CR_val).init(base_address + 0x44);

/// IOG6CR
const IOG6CR_val = packed struct {
/// CNT [0:13]
/// Counter value
CNT: u14 = 0,
/// unused [14:31]
_unused14: u2 = 0,
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// I/O group x counter register
pub const IOG6CR = Register(IOG6CR_val).init(base_address + 0x48);

/// IOG7CR
const IOG7CR_val = packed struct {
/// CNT [0:13]
/// Counter value
CNT: u14 = 0,
/// unused [14:31]
_unused14: u2 = 0,
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// I/O group x counter register
pub const IOG7CR = Register(IOG7CR_val).init(base_address + 0x4c);

/// IOG8CR
const IOG8CR_val = packed struct {
/// CNT [0:13]
/// Counter value
CNT: u14 = 0,
/// unused [14:31]
_unused14: u2 = 0,
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// I/O group x counter register
pub const IOG8CR = Register(IOG8CR_val).init(base_address + 0x50);
};

/// cyclic redundancy check calculation
pub const CRC = struct {

const base_address = 0x40023000;
/// DR
const DR_val = packed struct {
/// DR [0:31]
/// Data register bits
DR: u32 = 4294967295,
};
/// Data register
pub const DR = Register(DR_val).init(base_address + 0x0);

/// IDR
const IDR_val = packed struct {
/// IDR [0:7]
/// General-purpose 8-bit data register
IDR: u8 = 0,
/// unused [8:31]
_unused8: u8 = 0,
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// Independent data register
pub const IDR = Register(IDR_val).init(base_address + 0x4);

/// CR
const CR_val = packed struct {
/// RESET [0:0]
/// reset bit
RESET: u1 = 0,
/// unused [1:2]
_unused1: u2 = 0,
/// POLYSIZE [3:4]
/// Polynomial size
POLYSIZE: u2 = 0,
/// REV_IN [5:6]
/// Reverse input data
REV_IN: u2 = 0,
/// REV_OUT [7:7]
/// Reverse output data
REV_OUT: u1 = 0,
/// unused [8:31]
_unused8: u8 = 0,
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// Control register
pub const CR = Register(CR_val).init(base_address + 0x8);

/// INIT
const INIT_val = packed struct {
/// INIT [0:31]
/// Programmable initial CRC
INIT: u32 = 4294967295,
};
/// Initial CRC value
pub const INIT = Register(INIT_val).init(base_address + 0x10);

/// POL
const POL_val = packed struct {
/// POL [0:31]
/// Programmable polynomial
POL: u32 = 79764919,
};
/// CRC polynomial
pub const POL = Register(POL_val).init(base_address + 0x14);
};

/// Flash
pub const Flash = struct {

const base_address = 0x40022000;
/// ACR
const ACR_val = packed struct {
/// LATENCY [0:2]
/// LATENCY
LATENCY: u3 = 0,
/// unused [3:3]
_unused3: u1 = 0,
/// PRFTBE [4:4]
/// PRFTBE
PRFTBE: u1 = 1,
/// PRFTBS [5:5]
/// PRFTBS
PRFTBS: u1 = 1,
/// unused [6:31]
_unused6: u2 = 0,
_unused8: u8 = 0,
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// Flash access control register
pub const ACR = Register(ACR_val).init(base_address + 0x0);

/// KEYR
const KEYR_val = packed struct {
/// FKEYR [0:31]
/// Flash Key
FKEYR: u32 = 0,
};
/// Flash key register
pub const KEYR = Register(KEYR_val).init(base_address + 0x4);

/// OPTKEYR
const OPTKEYR_val = packed struct {
/// OPTKEYR [0:31]
/// Option byte key
OPTKEYR: u32 = 0,
};
/// Flash option key register
pub const OPTKEYR = Register(OPTKEYR_val).init(base_address + 0x8);

/// SR
const SR_val = packed struct {
/// BSY [0:0]
/// Busy
BSY: u1 = 0,
/// unused [1:1]
_unused1: u1 = 0,
/// PGERR [2:2]
/// Programming error
PGERR: u1 = 0,
/// unused [3:3]
_unused3: u1 = 0,
/// WRPRT [4:4]
/// Write protection error
WRPRT: u1 = 0,
/// EOP [5:5]
/// End of operation
EOP: u1 = 0,
/// unused [6:31]
_unused6: u2 = 0,
_unused8: u8 = 0,
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// Flash status register
pub const SR = Register(SR_val).init(base_address + 0xc);

/// CR
const CR_val = packed struct {
/// PG [0:0]
/// Programming
PG: u1 = 0,
/// PER [1:1]
/// Page erase
PER: u1 = 0,
/// MER [2:2]
/// Mass erase
MER: u1 = 0,
/// unused [3:3]
_unused3: u1 = 0,
/// OPTPG [4:4]
/// Option byte programming
OPTPG: u1 = 0,
/// OPTER [5:5]
/// Option byte erase
OPTER: u1 = 0,
/// STRT [6:6]
/// Start
STRT: u1 = 0,
/// LOCK [7:7]
/// Lock
LOCK: u1 = 1,
/// unused [8:8]
_unused8: u1 = 0,
/// OPTWRE [9:9]
/// Option bytes write enable
OPTWRE: u1 = 0,
/// ERRIE [10:10]
/// Error interrupt enable
ERRIE: u1 = 0,
/// unused [11:11]
_unused11: u1 = 0,
/// EOPIE [12:12]
/// End of operation interrupt
EOPIE: u1 = 0,
/// FORCE_OPTLOAD [13:13]
/// Force option byte loading
FORCE_OPTLOAD: u1 = 0,
/// unused [14:31]
_unused14: u2 = 0,
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// Flash control register
pub const CR = Register(CR_val).init(base_address + 0x10);

/// AR
const AR_val = packed struct {
/// FAR [0:31]
/// Flash address
FAR: u32 = 0,
};
/// Flash address register
pub const AR = Register(AR_val).init(base_address + 0x14);

/// OBR
const OBR_val = packed struct {
/// OPTERR [0:0]
/// Option byte error
OPTERR: u1 = 0,
/// LEVEL1_PROT [1:1]
/// Level 1 protection status
LEVEL1_PROT: u1 = 1,
/// LEVEL2_PROT [2:2]
/// Level 2 protection status
LEVEL2_PROT: u1 = 0,
/// unused [3:7]
_unused3: u5 = 0,
/// WDG_SW [8:8]
/// WDG_SW
WDG_SW: u1 = 1,
/// nRST_STOP [9:9]
/// nRST_STOP
nRST_STOP: u1 = 1,
/// nRST_STDBY [10:10]
/// nRST_STDBY
nRST_STDBY: u1 = 1,
/// unused [11:11]
_unused11: u1 = 1,
/// BOOT1 [12:12]
/// BOOT1
BOOT1: u1 = 1,
/// VDDA_MONITOR [13:13]
/// VDDA_MONITOR
VDDA_MONITOR: u1 = 1,
/// SRAM_PARITY_CHECK [14:14]
/// SRAM_PARITY_CHECK
SRAM_PARITY_CHECK: u1 = 1,
/// unused [15:15]
_unused15: u1 = 1,
/// Data0 [16:23]
/// Data0
Data0: u8 = 255,
/// Data1 [24:31]
/// Data1
Data1: u8 = 255,
};
/// Option byte register
pub const OBR = Register(OBR_val).init(base_address + 0x1c);

/// WRPR
const WRPR_val = packed struct {
/// WRP [0:31]
/// Write protect
WRP: u32 = 4294967295,
};
/// Write protection register
pub const WRPR = Register(WRPR_val).init(base_address + 0x20);
};

/// Reset and clock control
pub const RCC = struct {

const base_address = 0x40021000;
/// CR
const CR_val = packed struct {
/// HSION [0:0]
/// Internal High Speed clock
HSION: u1 = 1,
/// HSIRDY [1:1]
/// Internal High Speed clock ready
HSIRDY: u1 = 1,
/// unused [2:2]
_unused2: u1 = 0,
/// HSITRIM [3:7]
/// Internal High Speed clock
HSITRIM: u5 = 16,
/// HSICAL [8:15]
/// Internal High Speed clock
HSICAL: u8 = 0,
/// HSEON [16:16]
/// External High Speed clock
HSEON: u1 = 0,
/// HSERDY [17:17]
/// External High Speed clock ready
HSERDY: u1 = 0,
/// HSEBYP [18:18]
/// External High Speed clock
HSEBYP: u1 = 0,
/// CSSON [19:19]
/// Clock Security System
CSSON: u1 = 0,
/// unused [20:23]
_unused20: u4 = 0,
/// PLLON [24:24]
/// PLL enable
PLLON: u1 = 0,
/// PLLRDY [25:25]
/// PLL clock ready flag
PLLRDY: u1 = 0,
/// unused [26:31]
_unused26: u6 = 0,
};
/// Clock control register
pub const CR = Register(CR_val).init(base_address + 0x0);

/// CFGR
const CFGR_val = packed struct {
/// SW [0:1]
/// System clock Switch
SW: u2 = 0,
/// SWS [2:3]
/// System Clock Switch Status
SWS: u2 = 0,
/// HPRE [4:7]
/// AHB prescaler
HPRE: u4 = 0,
/// PPRE1 [8:10]
/// APB Low speed prescaler
PPRE1: u3 = 0,
/// PPRE2 [11:13]
/// APB high speed prescaler
PPRE2: u3 = 0,
/// unused [14:14]
_unused14: u1 = 0,
/// PLLSRC [15:16]
/// PLL entry clock source
PLLSRC: u2 = 0,
/// PLLXTPRE [17:17]
/// HSE divider for PLL entry
PLLXTPRE: u1 = 0,
/// PLLMUL [18:21]
/// PLL Multiplication Factor
PLLMUL: u4 = 0,
/// USBPRES [22:22]
/// USB prescaler
USBPRES: u1 = 0,
/// I2SSRC [23:23]
/// I2S external clock source
I2SSRC: u1 = 0,
/// MCO [24:26]
/// Microcontroller clock
MCO: u3 = 0,
/// unused [27:27]
_unused27: u1 = 0,
/// MCOF [28:28]
/// Microcontroller Clock Output
MCOF: u1 = 0,
/// unused [29:31]
_unused29: u3 = 0,
};
/// Clock configuration register
pub const CFGR = Register(CFGR_val).init(base_address + 0x4);

/// CIR
const CIR_val = packed struct {
/// LSIRDYF [0:0]
/// LSI Ready Interrupt flag
LSIRDYF: u1 = 0,
/// LSERDYF [1:1]
/// LSE Ready Interrupt flag
LSERDYF: u1 = 0,
/// HSIRDYF [2:2]
/// HSI Ready Interrupt flag
HSIRDYF: u1 = 0,
/// HSERDYF [3:3]
/// HSE Ready Interrupt flag
HSERDYF: u1 = 0,
/// PLLRDYF [4:4]
/// PLL Ready Interrupt flag
PLLRDYF: u1 = 0,
/// unused [5:6]
_unused5: u2 = 0,
/// CSSF [7:7]
/// Clock Security System Interrupt
CSSF: u1 = 0,
/// LSIRDYIE [8:8]
/// LSI Ready Interrupt Enable
LSIRDYIE: u1 = 0,
/// LSERDYIE [9:9]
/// LSE Ready Interrupt Enable
LSERDYIE: u1 = 0,
/// HSIRDYIE [10:10]
/// HSI Ready Interrupt Enable
HSIRDYIE: u1 = 0,
/// HSERDYIE [11:11]
/// HSE Ready Interrupt Enable
HSERDYIE: u1 = 0,
/// PLLRDYIE [12:12]
/// PLL Ready Interrupt Enable
PLLRDYIE: u1 = 0,
/// unused [13:15]
_unused13: u3 = 0,
/// LSIRDYC [16:16]
/// LSI Ready Interrupt Clear
LSIRDYC: u1 = 0,
/// LSERDYC [17:17]
/// LSE Ready Interrupt Clear
LSERDYC: u1 = 0,
/// HSIRDYC [18:18]
/// HSI Ready Interrupt Clear
HSIRDYC: u1 = 0,
/// HSERDYC [19:19]
/// HSE Ready Interrupt Clear
HSERDYC: u1 = 0,
/// PLLRDYC [20:20]
/// PLL Ready Interrupt Clear
PLLRDYC: u1 = 0,
/// unused [21:22]
_unused21: u2 = 0,
/// CSSC [23:23]
/// Clock security system interrupt
CSSC: u1 = 0,
/// unused [24:31]
_unused24: u8 = 0,
};
/// Clock interrupt register
pub const CIR = Register(CIR_val).init(base_address + 0x8);

/// APB2RSTR
const APB2RSTR_val = packed struct {
/// SYSCFGRST [0:0]
/// SYSCFG and COMP reset
SYSCFGRST: u1 = 0,
/// unused [1:10]
_unused1: u7 = 0,
_unused8: u3 = 0,
/// TIM1RST [11:11]
/// TIM1 timer reset
TIM1RST: u1 = 0,
/// SPI1RST [12:12]
/// SPI 1 reset
SPI1RST: u1 = 0,
/// TIM8RST [13:13]
/// TIM8 timer reset
TIM8RST: u1 = 0,
/// USART1RST [14:14]
/// USART1 reset
USART1RST: u1 = 0,
/// unused [15:15]
_unused15: u1 = 0,
/// TIM15RST [16:16]
/// TIM15 timer reset
TIM15RST: u1 = 0,
/// TIM16RST [17:17]
/// TIM16 timer reset
TIM16RST: u1 = 0,
/// TIM17RST [18:18]
/// TIM17 timer reset
TIM17RST: u1 = 0,
/// unused [19:31]
_unused19: u5 = 0,
_unused24: u8 = 0,
};
/// APB2 peripheral reset register
pub const APB2RSTR = Register(APB2RSTR_val).init(base_address + 0xc);

/// APB1RSTR
const APB1RSTR_val = packed struct {
/// TIM2RST [0:0]
/// Timer 2 reset
TIM2RST: u1 = 0,
/// TIM3RST [1:1]
/// Timer 3 reset
TIM3RST: u1 = 0,
/// TIM4RST [2:2]
/// Timer 14 reset
TIM4RST: u1 = 0,
/// unused [3:3]
_unused3: u1 = 0,
/// TIM6RST [4:4]
/// Timer 6 reset
TIM6RST: u1 = 0,
/// TIM7RST [5:5]
/// Timer 7 reset
TIM7RST: u1 = 0,
/// unused [6:10]
_unused6: u2 = 0,
_unused8: u3 = 0,
/// WWDGRST [11:11]
/// Window watchdog reset
WWDGRST: u1 = 0,
/// unused [12:13]
_unused12: u2 = 0,
/// SPI2RST [14:14]
/// SPI2 reset
SPI2RST: u1 = 0,
/// SPI3RST [15:15]
/// SPI3 reset
SPI3RST: u1 = 0,
/// unused [16:16]
_unused16: u1 = 0,
/// USART2RST [17:17]
/// USART 2 reset
USART2RST: u1 = 0,
/// USART3RST [18:18]
/// USART3 reset
USART3RST: u1 = 0,
/// UART4RST [19:19]
/// UART 4 reset
UART4RST: u1 = 0,
/// UART5RST [20:20]
/// UART 5 reset
UART5RST: u1 = 0,
/// I2C1RST [21:21]
/// I2C1 reset
I2C1RST: u1 = 0,
/// I2C2RST [22:22]
/// I2C2 reset
I2C2RST: u1 = 0,
/// USBRST [23:23]
/// USB reset
USBRST: u1 = 0,
/// unused [24:24]
_unused24: u1 = 0,
/// CANRST [25:25]
/// CAN reset
CANRST: u1 = 0,
/// unused [26:27]
_unused26: u2 = 0,
/// PWRRST [28:28]
/// Power interface reset
PWRRST: u1 = 0,
/// DACRST [29:29]
/// DAC interface reset
DACRST: u1 = 0,
/// I2C3RST [30:30]
/// I2C3 reset
I2C3RST: u1 = 0,
/// unused [31:31]
_unused31: u1 = 0,
};
/// APB1 peripheral reset register
pub const APB1RSTR = Register(APB1RSTR_val).init(base_address + 0x10);

/// AHBENR
const AHBENR_val = packed struct {
/// DMAEN [0:0]
/// DMA1 clock enable
DMAEN: u1 = 0,
/// DMA2EN [1:1]
/// DMA2 clock enable
DMA2EN: u1 = 0,
/// SRAMEN [2:2]
/// SRAM interface clock
SRAMEN: u1 = 1,
/// unused [3:3]
_unused3: u1 = 0,
/// FLITFEN [4:4]
/// FLITF clock enable
FLITFEN: u1 = 1,
/// FMCEN [5:5]
/// FMC clock enable
FMCEN: u1 = 0,
/// CRCEN [6:6]
/// CRC clock enable
CRCEN: u1 = 0,
/// unused [7:15]
_unused7: u1 = 0,
_unused8: u8 = 0,
/// IOPHEN [16:16]
/// IO port H clock enable
IOPHEN: u1 = 0,
/// IOPAEN [17:17]
/// I/O port A clock enable
IOPAEN: u1 = 0,
/// IOPBEN [18:18]
/// I/O port B clock enable
IOPBEN: u1 = 0,
/// IOPCEN [19:19]
/// I/O port C clock enable
IOPCEN: u1 = 0,
/// IOPDEN [20:20]
/// I/O port D clock enable
IOPDEN: u1 = 0,
/// IOPEEN [21:21]
/// I/O port E clock enable
IOPEEN: u1 = 0,
/// IOPFEN [22:22]
/// I/O port F clock enable
IOPFEN: u1 = 0,
/// IOPGEN [23:23]
/// I/O port G clock enable
IOPGEN: u1 = 0,
/// TSCEN [24:24]
/// Touch sensing controller clock
TSCEN: u1 = 0,
/// unused [25:27]
_unused25: u3 = 0,
/// ADC12EN [28:28]
/// ADC1 and ADC2 clock enable
ADC12EN: u1 = 0,
/// ADC34EN [29:29]
/// ADC3 and ADC4 clock enable
ADC34EN: u1 = 0,
/// unused [30:31]
_unused30: u2 = 0,
};
/// AHB Peripheral Clock enable register
pub const AHBENR = Register(AHBENR_val).init(base_address + 0x14);

/// APB2ENR
const APB2ENR_val = packed struct {
/// SYSCFGEN [0:0]
/// SYSCFG clock enable
SYSCFGEN: u1 = 0,
/// unused [1:10]
_unused1: u7 = 0,
_unused8: u3 = 0,
/// TIM1EN [11:11]
/// TIM1 Timer clock enable
TIM1EN: u1 = 0,
/// SPI1EN [12:12]
/// SPI 1 clock enable
SPI1EN: u1 = 0,
/// TIM8EN [13:13]
/// TIM8 Timer clock enable
TIM8EN: u1 = 0,
/// USART1EN [14:14]
/// USART1 clock enable
USART1EN: u1 = 0,
/// unused [15:15]
_unused15: u1 = 0,
/// TIM15EN [16:16]
/// TIM15 timer clock enable
TIM15EN: u1 = 0,
/// TIM16EN [17:17]
/// TIM16 timer clock enable
TIM16EN: u1 = 0,
/// TIM17EN [18:18]
/// TIM17 timer clock enable
TIM17EN: u1 = 0,
/// unused [19:31]
_unused19: u5 = 0,
_unused24: u8 = 0,
};
/// APB2 peripheral clock enable register
pub const APB2ENR = Register(APB2ENR_val).init(base_address + 0x18);

/// APB1ENR
const APB1ENR_val = packed struct {
/// TIM2EN [0:0]
/// Timer 2 clock enable
TIM2EN: u1 = 0,
/// TIM3EN [1:1]
/// Timer 3 clock enable
TIM3EN: u1 = 0,
/// TIM4EN [2:2]
/// Timer 4 clock enable
TIM4EN: u1 = 0,
/// unused [3:3]
_unused3: u1 = 0,
/// TIM6EN [4:4]
/// Timer 6 clock enable
TIM6EN: u1 = 0,
/// TIM7EN [5:5]
/// Timer 7 clock enable
TIM7EN: u1 = 0,
/// unused [6:10]
_unused6: u2 = 0,
_unused8: u3 = 0,
/// WWDGEN [11:11]
/// Window watchdog clock
WWDGEN: u1 = 0,
/// unused [12:13]
_unused12: u2 = 0,
/// SPI2EN [14:14]
/// SPI 2 clock enable
SPI2EN: u1 = 0,
/// SPI3EN [15:15]
/// SPI 3 clock enable
SPI3EN: u1 = 0,
/// unused [16:16]
_unused16: u1 = 0,
/// USART2EN [17:17]
/// USART 2 clock enable
USART2EN: u1 = 0,
/// USART3EN [18:18]
/// USART 3 clock enable
USART3EN: u1 = 0,
/// USART4EN [19:19]
/// USART 4 clock enable
USART4EN: u1 = 0,
/// USART5EN [20:20]
/// USART 5 clock enable
USART5EN: u1 = 0,
/// I2C1EN [21:21]
/// I2C 1 clock enable
I2C1EN: u1 = 0,
/// I2C2EN [22:22]
/// I2C 2 clock enable
I2C2EN: u1 = 0,
/// USBEN [23:23]
/// USB clock enable
USBEN: u1 = 0,
/// unused [24:24]
_unused24: u1 = 0,
/// CANEN [25:25]
/// CAN clock enable
CANEN: u1 = 0,
/// DAC2EN [26:26]
/// DAC2 interface clock
DAC2EN: u1 = 0,
/// unused [27:27]
_unused27: u1 = 0,
/// PWREN [28:28]
/// Power interface clock
PWREN: u1 = 0,
/// DACEN [29:29]
/// DAC interface clock enable
DACEN: u1 = 0,
/// I2C3EN [30:30]
/// I2C3 clock enable
I2C3EN: u1 = 0,
/// unused [31:31]
_unused31: u1 = 0,
};
/// APB1 peripheral clock enable register
pub const APB1ENR = Register(APB1ENR_val).init(base_address + 0x1c);

/// BDCR
const BDCR_val = packed struct {
/// LSEON [0:0]
/// External Low Speed oscillator
LSEON: u1 = 0,
/// LSERDY [1:1]
/// External Low Speed oscillator
LSERDY: u1 = 0,
/// LSEBYP [2:2]
/// External Low Speed oscillator
LSEBYP: u1 = 0,
/// LSEDRV [3:4]
/// LSE oscillator drive
LSEDRV: u2 = 0,
/// unused [5:7]
_unused5: u3 = 0,
/// RTCSEL [8:9]
/// RTC clock source selection
RTCSEL: u2 = 0,
/// unused [10:14]
_unused10: u5 = 0,
/// RTCEN [15:15]
/// RTC clock enable
RTCEN: u1 = 0,
/// BDRST [16:16]
/// Backup domain software
BDRST: u1 = 0,
/// unused [17:31]
_unused17: u7 = 0,
_unused24: u8 = 0,
};
/// Backup domain control register
pub const BDCR = Register(BDCR_val).init(base_address + 0x20);

/// CSR
const CSR_val = packed struct {
/// LSION [0:0]
/// Internal low speed oscillator
LSION: u1 = 0,
/// LSIRDY [1:1]
/// Internal low speed oscillator
LSIRDY: u1 = 0,
/// unused [2:23]
_unused2: u6 = 0,
_unused8: u8 = 0,
_unused16: u8 = 0,
/// RMVF [24:24]
/// Remove reset flag
RMVF: u1 = 0,
/// OBLRSTF [25:25]
/// Option byte loader reset
OBLRSTF: u1 = 0,
/// PINRSTF [26:26]
/// PIN reset flag
PINRSTF: u1 = 1,
/// PORRSTF [27:27]
/// POR/PDR reset flag
PORRSTF: u1 = 1,
/// SFTRSTF [28:28]
/// Software reset flag
SFTRSTF: u1 = 0,
/// IWDGRSTF [29:29]
/// Independent watchdog reset
IWDGRSTF: u1 = 0,
/// WWDGRSTF [30:30]
/// Window watchdog reset flag
WWDGRSTF: u1 = 0,
/// LPWRRSTF [31:31]
/// Low-power reset flag
LPWRRSTF: u1 = 0,
};
/// Control/status register
pub const CSR = Register(CSR_val).init(base_address + 0x24);

/// AHBRSTR
const AHBRSTR_val = packed struct {
/// unused [0:4]
_unused0: u5 = 0,
/// FMCRST [5:5]
/// FMC reset
FMCRST: u1 = 0,
/// unused [6:15]
_unused6: u2 = 0,
_unused8: u8 = 0,
/// IOPHRST [16:16]
/// I/O port H reset
IOPHRST: u1 = 0,
/// IOPARST [17:17]
/// I/O port A reset
IOPARST: u1 = 0,
/// IOPBRST [18:18]
/// I/O port B reset
IOPBRST: u1 = 0,
/// IOPCRST [19:19]
/// I/O port C reset
IOPCRST: u1 = 0,
/// IOPDRST [20:20]
/// I/O port D reset
IOPDRST: u1 = 0,
/// IOPERST [21:21]
/// I/O port E reset
IOPERST: u1 = 0,
/// IOPFRST [22:22]
/// I/O port F reset
IOPFRST: u1 = 0,
/// IOPGRST [23:23]
/// Touch sensing controller
IOPGRST: u1 = 0,
/// TSCRST [24:24]
/// Touch sensing controller
TSCRST: u1 = 0,
/// unused [25:27]
_unused25: u3 = 0,
/// ADC12RST [28:28]
/// ADC1 and ADC2 reset
ADC12RST: u1 = 0,
/// ADC34RST [29:29]
/// ADC3 and ADC4 reset
ADC34RST: u1 = 0,
/// unused [30:31]
_unused30: u2 = 0,
};
/// AHB peripheral reset register
pub const AHBRSTR = Register(AHBRSTR_val).init(base_address + 0x28);

/// CFGR2
const CFGR2_val = packed struct {
/// PREDIV [0:3]
/// PREDIV division factor
PREDIV: u4 = 0,
/// ADC12PRES [4:8]
/// ADC1 and ADC2 prescaler
ADC12PRES: u5 = 0,
/// ADC34PRES [9:13]
/// ADC3 and ADC4 prescaler
ADC34PRES: u5 = 0,
/// unused [14:31]
_unused14: u2 = 0,
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// Clock configuration register 2
pub const CFGR2 = Register(CFGR2_val).init(base_address + 0x2c);

/// CFGR3
const CFGR3_val = packed struct {
/// USART1SW [0:1]
/// USART1 clock source
USART1SW: u2 = 0,
/// unused [2:3]
_unused2: u2 = 0,
/// I2C1SW [4:4]
/// I2C1 clock source
I2C1SW: u1 = 0,
/// I2C2SW [5:5]
/// I2C2 clock source
I2C2SW: u1 = 0,
/// I2C3SW [6:6]
/// I2C3 clock source
I2C3SW: u1 = 0,
/// unused [7:7]
_unused7: u1 = 0,
/// TIM1SW [8:8]
/// Timer1 clock source
TIM1SW: u1 = 0,
/// TIM8SW [9:9]
/// Timer8 clock source
TIM8SW: u1 = 0,
/// unused [10:15]
_unused10: u6 = 0,
/// USART2SW [16:17]
/// USART2 clock source
USART2SW: u2 = 0,
/// USART3SW [18:19]
/// USART3 clock source
USART3SW: u2 = 0,
/// UART4SW [20:21]
/// UART4 clock source
UART4SW: u2 = 0,
/// UART5SW [22:23]
/// UART5 clock source
UART5SW: u2 = 0,
/// unused [24:31]
_unused24: u8 = 0,
};
/// Clock configuration register 3
pub const CFGR3 = Register(CFGR3_val).init(base_address + 0x30);
};

/// DMA controller 1
pub const DMA1 = struct {

const base_address = 0x40020000;
/// ISR
const ISR_val = packed struct {
/// GIF1 [0:0]
/// Channel 1 Global interrupt
GIF1: u1 = 0,
/// TCIF1 [1:1]
/// Channel 1 Transfer Complete
TCIF1: u1 = 0,
/// HTIF1 [2:2]
/// Channel 1 Half Transfer Complete
HTIF1: u1 = 0,
/// TEIF1 [3:3]
/// Channel 1 Transfer Error
TEIF1: u1 = 0,
/// GIF2 [4:4]
/// Channel 2 Global interrupt
GIF2: u1 = 0,
/// TCIF2 [5:5]
/// Channel 2 Transfer Complete
TCIF2: u1 = 0,
/// HTIF2 [6:6]
/// Channel 2 Half Transfer Complete
HTIF2: u1 = 0,
/// TEIF2 [7:7]
/// Channel 2 Transfer Error
TEIF2: u1 = 0,
/// GIF3 [8:8]
/// Channel 3 Global interrupt
GIF3: u1 = 0,
/// TCIF3 [9:9]
/// Channel 3 Transfer Complete
TCIF3: u1 = 0,
/// HTIF3 [10:10]
/// Channel 3 Half Transfer Complete
HTIF3: u1 = 0,
/// TEIF3 [11:11]
/// Channel 3 Transfer Error
TEIF3: u1 = 0,
/// GIF4 [12:12]
/// Channel 4 Global interrupt
GIF4: u1 = 0,
/// TCIF4 [13:13]
/// Channel 4 Transfer Complete
TCIF4: u1 = 0,
/// HTIF4 [14:14]
/// Channel 4 Half Transfer Complete
HTIF4: u1 = 0,
/// TEIF4 [15:15]
/// Channel 4 Transfer Error
TEIF4: u1 = 0,
/// GIF5 [16:16]
/// Channel 5 Global interrupt
GIF5: u1 = 0,
/// TCIF5 [17:17]
/// Channel 5 Transfer Complete
TCIF5: u1 = 0,
/// HTIF5 [18:18]
/// Channel 5 Half Transfer Complete
HTIF5: u1 = 0,
/// TEIF5 [19:19]
/// Channel 5 Transfer Error
TEIF5: u1 = 0,
/// GIF6 [20:20]
/// Channel 6 Global interrupt
GIF6: u1 = 0,
/// TCIF6 [21:21]
/// Channel 6 Transfer Complete
TCIF6: u1 = 0,
/// HTIF6 [22:22]
/// Channel 6 Half Transfer Complete
HTIF6: u1 = 0,
/// TEIF6 [23:23]
/// Channel 6 Transfer Error
TEIF6: u1 = 0,
/// GIF7 [24:24]
/// Channel 7 Global interrupt
GIF7: u1 = 0,
/// TCIF7 [25:25]
/// Channel 7 Transfer Complete
TCIF7: u1 = 0,
/// HTIF7 [26:26]
/// Channel 7 Half Transfer Complete
HTIF7: u1 = 0,
/// TEIF7 [27:27]
/// Channel 7 Transfer Error
TEIF7: u1 = 0,
/// unused [28:31]
_unused28: u4 = 0,
};
/// DMA interrupt status register
pub const ISR = Register(ISR_val).init(base_address + 0x0);

/// IFCR
const IFCR_val = packed struct {
/// CGIF1 [0:0]
/// Channel 1 Global interrupt
CGIF1: u1 = 0,
/// CTCIF1 [1:1]
/// Channel 1 Transfer Complete
CTCIF1: u1 = 0,
/// CHTIF1 [2:2]
/// Channel 1 Half Transfer
CHTIF1: u1 = 0,
/// CTEIF1 [3:3]
/// Channel 1 Transfer Error
CTEIF1: u1 = 0,
/// CGIF2 [4:4]
/// Channel 2 Global interrupt
CGIF2: u1 = 0,
/// CTCIF2 [5:5]
/// Channel 2 Transfer Complete
CTCIF2: u1 = 0,
/// CHTIF2 [6:6]
/// Channel 2 Half Transfer
CHTIF2: u1 = 0,
/// CTEIF2 [7:7]
/// Channel 2 Transfer Error
CTEIF2: u1 = 0,
/// CGIF3 [8:8]
/// Channel 3 Global interrupt
CGIF3: u1 = 0,
/// CTCIF3 [9:9]
/// Channel 3 Transfer Complete
CTCIF3: u1 = 0,
/// CHTIF3 [10:10]
/// Channel 3 Half Transfer
CHTIF3: u1 = 0,
/// CTEIF3 [11:11]
/// Channel 3 Transfer Error
CTEIF3: u1 = 0,
/// CGIF4 [12:12]
/// Channel 4 Global interrupt
CGIF4: u1 = 0,
/// CTCIF4 [13:13]
/// Channel 4 Transfer Complete
CTCIF4: u1 = 0,
/// CHTIF4 [14:14]
/// Channel 4 Half Transfer
CHTIF4: u1 = 0,
/// CTEIF4 [15:15]
/// Channel 4 Transfer Error
CTEIF4: u1 = 0,
/// CGIF5 [16:16]
/// Channel 5 Global interrupt
CGIF5: u1 = 0,
/// CTCIF5 [17:17]
/// Channel 5 Transfer Complete
CTCIF5: u1 = 0,
/// CHTIF5 [18:18]
/// Channel 5 Half Transfer
CHTIF5: u1 = 0,
/// CTEIF5 [19:19]
/// Channel 5 Transfer Error
CTEIF5: u1 = 0,
/// CGIF6 [20:20]
/// Channel 6 Global interrupt
CGIF6: u1 = 0,
/// CTCIF6 [21:21]
/// Channel 6 Transfer Complete
CTCIF6: u1 = 0,
/// CHTIF6 [22:22]
/// Channel 6 Half Transfer
CHTIF6: u1 = 0,
/// CTEIF6 [23:23]
/// Channel 6 Transfer Error
CTEIF6: u1 = 0,
/// CGIF7 [24:24]
/// Channel 7 Global interrupt
CGIF7: u1 = 0,
/// CTCIF7 [25:25]
/// Channel 7 Transfer Complete
CTCIF7: u1 = 0,
/// CHTIF7 [26:26]
/// Channel 7 Half Transfer
CHTIF7: u1 = 0,
/// CTEIF7 [27:27]
/// Channel 7 Transfer Error
CTEIF7: u1 = 0,
/// unused [28:31]
_unused28: u4 = 0,
};
/// DMA interrupt flag clear register
pub const IFCR = Register(IFCR_val).init(base_address + 0x4);

/// CCR1
const CCR1_val = packed struct {
/// EN [0:0]
/// Channel enable
EN: u1 = 0,
/// TCIE [1:1]
/// Transfer complete interrupt
TCIE: u1 = 0,
/// HTIE [2:2]
/// Half Transfer interrupt
HTIE: u1 = 0,
/// TEIE [3:3]
/// Transfer error interrupt
TEIE: u1 = 0,
/// DIR [4:4]
/// Data transfer direction
DIR: u1 = 0,
/// CIRC [5:5]
/// Circular mode
CIRC: u1 = 0,
/// PINC [6:6]
/// Peripheral increment mode
PINC: u1 = 0,
/// MINC [7:7]
/// Memory increment mode
MINC: u1 = 0,
/// PSIZE [8:9]
/// Peripheral size
PSIZE: u2 = 0,
/// MSIZE [10:11]
/// Memory size
MSIZE: u2 = 0,
/// PL [12:13]
/// Channel Priority level
PL: u2 = 0,
/// MEM2MEM [14:14]
/// Memory to memory mode
MEM2MEM: u1 = 0,
/// unused [15:31]
_unused15: u1 = 0,
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// DMA channel configuration register
pub const CCR1 = Register(CCR1_val).init(base_address + 0x8);

/// CNDTR1
const CNDTR1_val = packed struct {
/// NDT [0:15]
/// Number of data to transfer
NDT: u16 = 0,
/// unused [16:31]
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// DMA channel 1 number of data
pub const CNDTR1 = Register(CNDTR1_val).init(base_address + 0xc);

/// CPAR1
const CPAR1_val = packed struct {
/// PA [0:31]
/// Peripheral address
PA: u32 = 0,
};
/// DMA channel 1 peripheral address
pub const CPAR1 = Register(CPAR1_val).init(base_address + 0x10);

/// CMAR1
const CMAR1_val = packed struct {
/// MA [0:31]
/// Memory address
MA: u32 = 0,
};
/// DMA channel 1 memory address
pub const CMAR1 = Register(CMAR1_val).init(base_address + 0x14);

/// CCR2
const CCR2_val = packed struct {
/// EN [0:0]
/// Channel enable
EN: u1 = 0,
/// TCIE [1:1]
/// Transfer complete interrupt
TCIE: u1 = 0,
/// HTIE [2:2]
/// Half Transfer interrupt
HTIE: u1 = 0,
/// TEIE [3:3]
/// Transfer error interrupt
TEIE: u1 = 0,
/// DIR [4:4]
/// Data transfer direction
DIR: u1 = 0,
/// CIRC [5:5]
/// Circular mode
CIRC: u1 = 0,
/// PINC [6:6]
/// Peripheral increment mode
PINC: u1 = 0,
/// MINC [7:7]
/// Memory increment mode
MINC: u1 = 0,
/// PSIZE [8:9]
/// Peripheral size
PSIZE: u2 = 0,
/// MSIZE [10:11]
/// Memory size
MSIZE: u2 = 0,
/// PL [12:13]
/// Channel Priority level
PL: u2 = 0,
/// MEM2MEM [14:14]
/// Memory to memory mode
MEM2MEM: u1 = 0,
/// unused [15:31]
_unused15: u1 = 0,
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// DMA channel configuration register
pub const CCR2 = Register(CCR2_val).init(base_address + 0x1c);

/// CNDTR2
const CNDTR2_val = packed struct {
/// NDT [0:15]
/// Number of data to transfer
NDT: u16 = 0,
/// unused [16:31]
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// DMA channel 2 number of data
pub const CNDTR2 = Register(CNDTR2_val).init(base_address + 0x20);

/// CPAR2
const CPAR2_val = packed struct {
/// PA [0:31]
/// Peripheral address
PA: u32 = 0,
};
/// DMA channel 2 peripheral address
pub const CPAR2 = Register(CPAR2_val).init(base_address + 0x24);

/// CMAR2
const CMAR2_val = packed struct {
/// MA [0:31]
/// Memory address
MA: u32 = 0,
};
/// DMA channel 2 memory address
pub const CMAR2 = Register(CMAR2_val).init(base_address + 0x28);

/// CCR3
const CCR3_val = packed struct {
/// EN [0:0]
/// Channel enable
EN: u1 = 0,
/// TCIE [1:1]
/// Transfer complete interrupt
TCIE: u1 = 0,
/// HTIE [2:2]
/// Half Transfer interrupt
HTIE: u1 = 0,
/// TEIE [3:3]
/// Transfer error interrupt
TEIE: u1 = 0,
/// DIR [4:4]
/// Data transfer direction
DIR: u1 = 0,
/// CIRC [5:5]
/// Circular mode
CIRC: u1 = 0,
/// PINC [6:6]
/// Peripheral increment mode
PINC: u1 = 0,
/// MINC [7:7]
/// Memory increment mode
MINC: u1 = 0,
/// PSIZE [8:9]
/// Peripheral size
PSIZE: u2 = 0,
/// MSIZE [10:11]
/// Memory size
MSIZE: u2 = 0,
/// PL [12:13]
/// Channel Priority level
PL: u2 = 0,
/// MEM2MEM [14:14]
/// Memory to memory mode
MEM2MEM: u1 = 0,
/// unused [15:31]
_unused15: u1 = 0,
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// DMA channel configuration register
pub const CCR3 = Register(CCR3_val).init(base_address + 0x30);

/// CNDTR3
const CNDTR3_val = packed struct {
/// NDT [0:15]
/// Number of data to transfer
NDT: u16 = 0,
/// unused [16:31]
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// DMA channel 3 number of data
pub const CNDTR3 = Register(CNDTR3_val).init(base_address + 0x34);

/// CPAR3
const CPAR3_val = packed struct {
/// PA [0:31]
/// Peripheral address
PA: u32 = 0,
};
/// DMA channel 3 peripheral address
pub const CPAR3 = Register(CPAR3_val).init(base_address + 0x38);

/// CMAR3
const CMAR3_val = packed struct {
/// MA [0:31]
/// Memory address
MA: u32 = 0,
};
/// DMA channel 3 memory address
pub const CMAR3 = Register(CMAR3_val).init(base_address + 0x3c);

/// CCR4
const CCR4_val = packed struct {
/// EN [0:0]
/// Channel enable
EN: u1 = 0,
/// TCIE [1:1]
/// Transfer complete interrupt
TCIE: u1 = 0,
/// HTIE [2:2]
/// Half Transfer interrupt
HTIE: u1 = 0,
/// TEIE [3:3]
/// Transfer error interrupt
TEIE: u1 = 0,
/// DIR [4:4]
/// Data transfer direction
DIR: u1 = 0,
/// CIRC [5:5]
/// Circular mode
CIRC: u1 = 0,
/// PINC [6:6]
/// Peripheral increment mode
PINC: u1 = 0,
/// MINC [7:7]
/// Memory increment mode
MINC: u1 = 0,
/// PSIZE [8:9]
/// Peripheral size
PSIZE: u2 = 0,
/// MSIZE [10:11]
/// Memory size
MSIZE: u2 = 0,
/// PL [12:13]
/// Channel Priority level
PL: u2 = 0,
/// MEM2MEM [14:14]
/// Memory to memory mode
MEM2MEM: u1 = 0,
/// unused [15:31]
_unused15: u1 = 0,
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// DMA channel configuration register
pub const CCR4 = Register(CCR4_val).init(base_address + 0x44);

/// CNDTR4
const CNDTR4_val = packed struct {
/// NDT [0:15]
/// Number of data to transfer
NDT: u16 = 0,
/// unused [16:31]
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// DMA channel 4 number of data
pub const CNDTR4 = Register(CNDTR4_val).init(base_address + 0x48);

/// CPAR4
const CPAR4_val = packed struct {
/// PA [0:31]
/// Peripheral address
PA: u32 = 0,
};
/// DMA channel 4 peripheral address
pub const CPAR4 = Register(CPAR4_val).init(base_address + 0x4c);

/// CMAR4
const CMAR4_val = packed struct {
/// MA [0:31]
/// Memory address
MA: u32 = 0,
};
/// DMA channel 4 memory address
pub const CMAR4 = Register(CMAR4_val).init(base_address + 0x50);

/// CCR5
const CCR5_val = packed struct {
/// EN [0:0]
/// Channel enable
EN: u1 = 0,
/// TCIE [1:1]
/// Transfer complete interrupt
TCIE: u1 = 0,
/// HTIE [2:2]
/// Half Transfer interrupt
HTIE: u1 = 0,
/// TEIE [3:3]
/// Transfer error interrupt
TEIE: u1 = 0,
/// DIR [4:4]
/// Data transfer direction
DIR: u1 = 0,
/// CIRC [5:5]
/// Circular mode
CIRC: u1 = 0,
/// PINC [6:6]
/// Peripheral increment mode
PINC: u1 = 0,
/// MINC [7:7]
/// Memory increment mode
MINC: u1 = 0,
/// PSIZE [8:9]
/// Peripheral size
PSIZE: u2 = 0,
/// MSIZE [10:11]
/// Memory size
MSIZE: u2 = 0,
/// PL [12:13]
/// Channel Priority level
PL: u2 = 0,
/// MEM2MEM [14:14]
/// Memory to memory mode
MEM2MEM: u1 = 0,
/// unused [15:31]
_unused15: u1 = 0,
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// DMA channel configuration register
pub const CCR5 = Register(CCR5_val).init(base_address + 0x58);

/// CNDTR5
const CNDTR5_val = packed struct {
/// NDT [0:15]
/// Number of data to transfer
NDT: u16 = 0,
/// unused [16:31]
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// DMA channel 5 number of data
pub const CNDTR5 = Register(CNDTR5_val).init(base_address + 0x5c);

/// CPAR5
const CPAR5_val = packed struct {
/// PA [0:31]
/// Peripheral address
PA: u32 = 0,
};
/// DMA channel 5 peripheral address
pub const CPAR5 = Register(CPAR5_val).init(base_address + 0x60);

/// CMAR5
const CMAR5_val = packed struct {
/// MA [0:31]
/// Memory address
MA: u32 = 0,
};
/// DMA channel 5 memory address
pub const CMAR5 = Register(CMAR5_val).init(base_address + 0x64);

/// CCR6
const CCR6_val = packed struct {
/// EN [0:0]
/// Channel enable
EN: u1 = 0,
/// TCIE [1:1]
/// Transfer complete interrupt
TCIE: u1 = 0,
/// HTIE [2:2]
/// Half Transfer interrupt
HTIE: u1 = 0,
/// TEIE [3:3]
/// Transfer error interrupt
TEIE: u1 = 0,
/// DIR [4:4]
/// Data transfer direction
DIR: u1 = 0,
/// CIRC [5:5]
/// Circular mode
CIRC: u1 = 0,
/// PINC [6:6]
/// Peripheral increment mode
PINC: u1 = 0,
/// MINC [7:7]
/// Memory increment mode
MINC: u1 = 0,
/// PSIZE [8:9]
/// Peripheral size
PSIZE: u2 = 0,
/// MSIZE [10:11]
/// Memory size
MSIZE: u2 = 0,
/// PL [12:13]
/// Channel Priority level
PL: u2 = 0,
/// MEM2MEM [14:14]
/// Memory to memory mode
MEM2MEM: u1 = 0,
/// unused [15:31]
_unused15: u1 = 0,
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// DMA channel configuration register
pub const CCR6 = Register(CCR6_val).init(base_address + 0x6c);

/// CNDTR6
const CNDTR6_val = packed struct {
/// NDT [0:15]
/// Number of data to transfer
NDT: u16 = 0,
/// unused [16:31]
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// DMA channel 6 number of data
pub const CNDTR6 = Register(CNDTR6_val).init(base_address + 0x70);

/// CPAR6
const CPAR6_val = packed struct {
/// PA [0:31]
/// Peripheral address
PA: u32 = 0,
};
/// DMA channel 6 peripheral address
pub const CPAR6 = Register(CPAR6_val).init(base_address + 0x74);

/// CMAR6
const CMAR6_val = packed struct {
/// MA [0:31]
/// Memory address
MA: u32 = 0,
};
/// DMA channel 6 memory address
pub const CMAR6 = Register(CMAR6_val).init(base_address + 0x78);

/// CCR7
const CCR7_val = packed struct {
/// EN [0:0]
/// Channel enable
EN: u1 = 0,
/// TCIE [1:1]
/// Transfer complete interrupt
TCIE: u1 = 0,
/// HTIE [2:2]
/// Half Transfer interrupt
HTIE: u1 = 0,
/// TEIE [3:3]
/// Transfer error interrupt
TEIE: u1 = 0,
/// DIR [4:4]
/// Data transfer direction
DIR: u1 = 0,
/// CIRC [5:5]
/// Circular mode
CIRC: u1 = 0,
/// PINC [6:6]
/// Peripheral increment mode
PINC: u1 = 0,
/// MINC [7:7]
/// Memory increment mode
MINC: u1 = 0,
/// PSIZE [8:9]
/// Peripheral size
PSIZE: u2 = 0,
/// MSIZE [10:11]
/// Memory size
MSIZE: u2 = 0,
/// PL [12:13]
/// Channel Priority level
PL: u2 = 0,
/// MEM2MEM [14:14]
/// Memory to memory mode
MEM2MEM: u1 = 0,
/// unused [15:31]
_unused15: u1 = 0,
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// DMA channel configuration register
pub const CCR7 = Register(CCR7_val).init(base_address + 0x80);

/// CNDTR7
const CNDTR7_val = packed struct {
/// NDT [0:15]
/// Number of data to transfer
NDT: u16 = 0,
/// unused [16:31]
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// DMA channel 7 number of data
pub const CNDTR7 = Register(CNDTR7_val).init(base_address + 0x84);

/// CPAR7
const CPAR7_val = packed struct {
/// PA [0:31]
/// Peripheral address
PA: u32 = 0,
};
/// DMA channel 7 peripheral address
pub const CPAR7 = Register(CPAR7_val).init(base_address + 0x88);

/// CMAR7
const CMAR7_val = packed struct {
/// MA [0:31]
/// Memory address
MA: u32 = 0,
};
/// DMA channel 7 memory address
pub const CMAR7 = Register(CMAR7_val).init(base_address + 0x8c);
};

/// DMA controller 1
pub const DMA2 = struct {

const base_address = 0x40020400;
/// ISR
const ISR_val = packed struct {
/// GIF1 [0:0]
/// Channel 1 Global interrupt
GIF1: u1 = 0,
/// TCIF1 [1:1]
/// Channel 1 Transfer Complete
TCIF1: u1 = 0,
/// HTIF1 [2:2]
/// Channel 1 Half Transfer Complete
HTIF1: u1 = 0,
/// TEIF1 [3:3]
/// Channel 1 Transfer Error
TEIF1: u1 = 0,
/// GIF2 [4:4]
/// Channel 2 Global interrupt
GIF2: u1 = 0,
/// TCIF2 [5:5]
/// Channel 2 Transfer Complete
TCIF2: u1 = 0,
/// HTIF2 [6:6]
/// Channel 2 Half Transfer Complete
HTIF2: u1 = 0,
/// TEIF2 [7:7]
/// Channel 2 Transfer Error
TEIF2: u1 = 0,
/// GIF3 [8:8]
/// Channel 3 Global interrupt
GIF3: u1 = 0,
/// TCIF3 [9:9]
/// Channel 3 Transfer Complete
TCIF3: u1 = 0,
/// HTIF3 [10:10]
/// Channel 3 Half Transfer Complete
HTIF3: u1 = 0,
/// TEIF3 [11:11]
/// Channel 3 Transfer Error
TEIF3: u1 = 0,
/// GIF4 [12:12]
/// Channel 4 Global interrupt
GIF4: u1 = 0,
/// TCIF4 [13:13]
/// Channel 4 Transfer Complete
TCIF4: u1 = 0,
/// HTIF4 [14:14]
/// Channel 4 Half Transfer Complete
HTIF4: u1 = 0,
/// TEIF4 [15:15]
/// Channel 4 Transfer Error
TEIF4: u1 = 0,
/// GIF5 [16:16]
/// Channel 5 Global interrupt
GIF5: u1 = 0,
/// TCIF5 [17:17]
/// Channel 5 Transfer Complete
TCIF5: u1 = 0,
/// HTIF5 [18:18]
/// Channel 5 Half Transfer Complete
HTIF5: u1 = 0,
/// TEIF5 [19:19]
/// Channel 5 Transfer Error
TEIF5: u1 = 0,
/// GIF6 [20:20]
/// Channel 6 Global interrupt
GIF6: u1 = 0,
/// TCIF6 [21:21]
/// Channel 6 Transfer Complete
TCIF6: u1 = 0,
/// HTIF6 [22:22]
/// Channel 6 Half Transfer Complete
HTIF6: u1 = 0,
/// TEIF6 [23:23]
/// Channel 6 Transfer Error
TEIF6: u1 = 0,
/// GIF7 [24:24]
/// Channel 7 Global interrupt
GIF7: u1 = 0,
/// TCIF7 [25:25]
/// Channel 7 Transfer Complete
TCIF7: u1 = 0,
/// HTIF7 [26:26]
/// Channel 7 Half Transfer Complete
HTIF7: u1 = 0,
/// TEIF7 [27:27]
/// Channel 7 Transfer Error
TEIF7: u1 = 0,
/// unused [28:31]
_unused28: u4 = 0,
};
/// DMA interrupt status register
pub const ISR = Register(ISR_val).init(base_address + 0x0);

/// IFCR
const IFCR_val = packed struct {
/// CGIF1 [0:0]
/// Channel 1 Global interrupt
CGIF1: u1 = 0,
/// CTCIF1 [1:1]
/// Channel 1 Transfer Complete
CTCIF1: u1 = 0,
/// CHTIF1 [2:2]
/// Channel 1 Half Transfer
CHTIF1: u1 = 0,
/// CTEIF1 [3:3]
/// Channel 1 Transfer Error
CTEIF1: u1 = 0,
/// CGIF2 [4:4]
/// Channel 2 Global interrupt
CGIF2: u1 = 0,
/// CTCIF2 [5:5]
/// Channel 2 Transfer Complete
CTCIF2: u1 = 0,
/// CHTIF2 [6:6]
/// Channel 2 Half Transfer
CHTIF2: u1 = 0,
/// CTEIF2 [7:7]
/// Channel 2 Transfer Error
CTEIF2: u1 = 0,
/// CGIF3 [8:8]
/// Channel 3 Global interrupt
CGIF3: u1 = 0,
/// CTCIF3 [9:9]
/// Channel 3 Transfer Complete
CTCIF3: u1 = 0,
/// CHTIF3 [10:10]
/// Channel 3 Half Transfer
CHTIF3: u1 = 0,
/// CTEIF3 [11:11]
/// Channel 3 Transfer Error
CTEIF3: u1 = 0,
/// CGIF4 [12:12]
/// Channel 4 Global interrupt
CGIF4: u1 = 0,
/// CTCIF4 [13:13]
/// Channel 4 Transfer Complete
CTCIF4: u1 = 0,
/// CHTIF4 [14:14]
/// Channel 4 Half Transfer
CHTIF4: u1 = 0,
/// CTEIF4 [15:15]
/// Channel 4 Transfer Error
CTEIF4: u1 = 0,
/// CGIF5 [16:16]
/// Channel 5 Global interrupt
CGIF5: u1 = 0,
/// CTCIF5 [17:17]
/// Channel 5 Transfer Complete
CTCIF5: u1 = 0,
/// CHTIF5 [18:18]
/// Channel 5 Half Transfer
CHTIF5: u1 = 0,
/// CTEIF5 [19:19]
/// Channel 5 Transfer Error
CTEIF5: u1 = 0,
/// CGIF6 [20:20]
/// Channel 6 Global interrupt
CGIF6: u1 = 0,
/// CTCIF6 [21:21]
/// Channel 6 Transfer Complete
CTCIF6: u1 = 0,
/// CHTIF6 [22:22]
/// Channel 6 Half Transfer
CHTIF6: u1 = 0,
/// CTEIF6 [23:23]
/// Channel 6 Transfer Error
CTEIF6: u1 = 0,
/// CGIF7 [24:24]
/// Channel 7 Global interrupt
CGIF7: u1 = 0,
/// CTCIF7 [25:25]
/// Channel 7 Transfer Complete
CTCIF7: u1 = 0,
/// CHTIF7 [26:26]
/// Channel 7 Half Transfer
CHTIF7: u1 = 0,
/// CTEIF7 [27:27]
/// Channel 7 Transfer Error
CTEIF7: u1 = 0,
/// unused [28:31]
_unused28: u4 = 0,
};
/// DMA interrupt flag clear register
pub const IFCR = Register(IFCR_val).init(base_address + 0x4);

/// CCR1
const CCR1_val = packed struct {
/// EN [0:0]
/// Channel enable
EN: u1 = 0,
/// TCIE [1:1]
/// Transfer complete interrupt
TCIE: u1 = 0,
/// HTIE [2:2]
/// Half Transfer interrupt
HTIE: u1 = 0,
/// TEIE [3:3]
/// Transfer error interrupt
TEIE: u1 = 0,
/// DIR [4:4]
/// Data transfer direction
DIR: u1 = 0,
/// CIRC [5:5]
/// Circular mode
CIRC: u1 = 0,
/// PINC [6:6]
/// Peripheral increment mode
PINC: u1 = 0,
/// MINC [7:7]
/// Memory increment mode
MINC: u1 = 0,
/// PSIZE [8:9]
/// Peripheral size
PSIZE: u2 = 0,
/// MSIZE [10:11]
/// Memory size
MSIZE: u2 = 0,
/// PL [12:13]
/// Channel Priority level
PL: u2 = 0,
/// MEM2MEM [14:14]
/// Memory to memory mode
MEM2MEM: u1 = 0,
/// unused [15:31]
_unused15: u1 = 0,
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// DMA channel configuration register
pub const CCR1 = Register(CCR1_val).init(base_address + 0x8);

/// CNDTR1
const CNDTR1_val = packed struct {
/// NDT [0:15]
/// Number of data to transfer
NDT: u16 = 0,
/// unused [16:31]
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// DMA channel 1 number of data
pub const CNDTR1 = Register(CNDTR1_val).init(base_address + 0xc);

/// CPAR1
const CPAR1_val = packed struct {
/// PA [0:31]
/// Peripheral address
PA: u32 = 0,
};
/// DMA channel 1 peripheral address
pub const CPAR1 = Register(CPAR1_val).init(base_address + 0x10);

/// CMAR1
const CMAR1_val = packed struct {
/// MA [0:31]
/// Memory address
MA: u32 = 0,
};
/// DMA channel 1 memory address
pub const CMAR1 = Register(CMAR1_val).init(base_address + 0x14);

/// CCR2
const CCR2_val = packed struct {
/// EN [0:0]
/// Channel enable
EN: u1 = 0,
/// TCIE [1:1]
/// Transfer complete interrupt
TCIE: u1 = 0,
/// HTIE [2:2]
/// Half Transfer interrupt
HTIE: u1 = 0,
/// TEIE [3:3]
/// Transfer error interrupt
TEIE: u1 = 0,
/// DIR [4:4]
/// Data transfer direction
DIR: u1 = 0,
/// CIRC [5:5]
/// Circular mode
CIRC: u1 = 0,
/// PINC [6:6]
/// Peripheral increment mode
PINC: u1 = 0,
/// MINC [7:7]
/// Memory increment mode
MINC: u1 = 0,
/// PSIZE [8:9]
/// Peripheral size
PSIZE: u2 = 0,
/// MSIZE [10:11]
/// Memory size
MSIZE: u2 = 0,
/// PL [12:13]
/// Channel Priority level
PL: u2 = 0,
/// MEM2MEM [14:14]
/// Memory to memory mode
MEM2MEM: u1 = 0,
/// unused [15:31]
_unused15: u1 = 0,
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// DMA channel configuration register
pub const CCR2 = Register(CCR2_val).init(base_address + 0x1c);

/// CNDTR2
const CNDTR2_val = packed struct {
/// NDT [0:15]
/// Number of data to transfer
NDT: u16 = 0,
/// unused [16:31]
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// DMA channel 2 number of data
pub const CNDTR2 = Register(CNDTR2_val).init(base_address + 0x20);

/// CPAR2
const CPAR2_val = packed struct {
/// PA [0:31]
/// Peripheral address
PA: u32 = 0,
};
/// DMA channel 2 peripheral address
pub const CPAR2 = Register(CPAR2_val).init(base_address + 0x24);

/// CMAR2
const CMAR2_val = packed struct {
/// MA [0:31]
/// Memory address
MA: u32 = 0,
};
/// DMA channel 2 memory address
pub const CMAR2 = Register(CMAR2_val).init(base_address + 0x28);

/// CCR3
const CCR3_val = packed struct {
/// EN [0:0]
/// Channel enable
EN: u1 = 0,
/// TCIE [1:1]
/// Transfer complete interrupt
TCIE: u1 = 0,
/// HTIE [2:2]
/// Half Transfer interrupt
HTIE: u1 = 0,
/// TEIE [3:3]
/// Transfer error interrupt
TEIE: u1 = 0,
/// DIR [4:4]
/// Data transfer direction
DIR: u1 = 0,
/// CIRC [5:5]
/// Circular mode
CIRC: u1 = 0,
/// PINC [6:6]
/// Peripheral increment mode
PINC: u1 = 0,
/// MINC [7:7]
/// Memory increment mode
MINC: u1 = 0,
/// PSIZE [8:9]
/// Peripheral size
PSIZE: u2 = 0,
/// MSIZE [10:11]
/// Memory size
MSIZE: u2 = 0,
/// PL [12:13]
/// Channel Priority level
PL: u2 = 0,
/// MEM2MEM [14:14]
/// Memory to memory mode
MEM2MEM: u1 = 0,
/// unused [15:31]
_unused15: u1 = 0,
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// DMA channel configuration register
pub const CCR3 = Register(CCR3_val).init(base_address + 0x30);

/// CNDTR3
const CNDTR3_val = packed struct {
/// NDT [0:15]
/// Number of data to transfer
NDT: u16 = 0,
/// unused [16:31]
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// DMA channel 3 number of data
pub const CNDTR3 = Register(CNDTR3_val).init(base_address + 0x34);

/// CPAR3
const CPAR3_val = packed struct {
/// PA [0:31]
/// Peripheral address
PA: u32 = 0,
};
/// DMA channel 3 peripheral address
pub const CPAR3 = Register(CPAR3_val).init(base_address + 0x38);

/// CMAR3
const CMAR3_val = packed struct {
/// MA [0:31]
/// Memory address
MA: u32 = 0,
};
/// DMA channel 3 memory address
pub const CMAR3 = Register(CMAR3_val).init(base_address + 0x3c);

/// CCR4
const CCR4_val = packed struct {
/// EN [0:0]
/// Channel enable
EN: u1 = 0,
/// TCIE [1:1]
/// Transfer complete interrupt
TCIE: u1 = 0,
/// HTIE [2:2]
/// Half Transfer interrupt
HTIE: u1 = 0,
/// TEIE [3:3]
/// Transfer error interrupt
TEIE: u1 = 0,
/// DIR [4:4]
/// Data transfer direction
DIR: u1 = 0,
/// CIRC [5:5]
/// Circular mode
CIRC: u1 = 0,
/// PINC [6:6]
/// Peripheral increment mode
PINC: u1 = 0,
/// MINC [7:7]
/// Memory increment mode
MINC: u1 = 0,
/// PSIZE [8:9]
/// Peripheral size
PSIZE: u2 = 0,
/// MSIZE [10:11]
/// Memory size
MSIZE: u2 = 0,
/// PL [12:13]
/// Channel Priority level
PL: u2 = 0,
/// MEM2MEM [14:14]
/// Memory to memory mode
MEM2MEM: u1 = 0,
/// unused [15:31]
_unused15: u1 = 0,
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// DMA channel configuration register
pub const CCR4 = Register(CCR4_val).init(base_address + 0x44);

/// CNDTR4
const CNDTR4_val = packed struct {
/// NDT [0:15]
/// Number of data to transfer
NDT: u16 = 0,
/// unused [16:31]
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// DMA channel 4 number of data
pub const CNDTR4 = Register(CNDTR4_val).init(base_address + 0x48);

/// CPAR4
const CPAR4_val = packed struct {
/// PA [0:31]
/// Peripheral address
PA: u32 = 0,
};
/// DMA channel 4 peripheral address
pub const CPAR4 = Register(CPAR4_val).init(base_address + 0x4c);

/// CMAR4
const CMAR4_val = packed struct {
/// MA [0:31]
/// Memory address
MA: u32 = 0,
};
/// DMA channel 4 memory address
pub const CMAR4 = Register(CMAR4_val).init(base_address + 0x50);

/// CCR5
const CCR5_val = packed struct {
/// EN [0:0]
/// Channel enable
EN: u1 = 0,
/// TCIE [1:1]
/// Transfer complete interrupt
TCIE: u1 = 0,
/// HTIE [2:2]
/// Half Transfer interrupt
HTIE: u1 = 0,
/// TEIE [3:3]
/// Transfer error interrupt
TEIE: u1 = 0,
/// DIR [4:4]
/// Data transfer direction
DIR: u1 = 0,
/// CIRC [5:5]
/// Circular mode
CIRC: u1 = 0,
/// PINC [6:6]
/// Peripheral increment mode
PINC: u1 = 0,
/// MINC [7:7]
/// Memory increment mode
MINC: u1 = 0,
/// PSIZE [8:9]
/// Peripheral size
PSIZE: u2 = 0,
/// MSIZE [10:11]
/// Memory size
MSIZE: u2 = 0,
/// PL [12:13]
/// Channel Priority level
PL: u2 = 0,
/// MEM2MEM [14:14]
/// Memory to memory mode
MEM2MEM: u1 = 0,
/// unused [15:31]
_unused15: u1 = 0,
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// DMA channel configuration register
pub const CCR5 = Register(CCR5_val).init(base_address + 0x58);

/// CNDTR5
const CNDTR5_val = packed struct {
/// NDT [0:15]
/// Number of data to transfer
NDT: u16 = 0,
/// unused [16:31]
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// DMA channel 5 number of data
pub const CNDTR5 = Register(CNDTR5_val).init(base_address + 0x5c);

/// CPAR5
const CPAR5_val = packed struct {
/// PA [0:31]
/// Peripheral address
PA: u32 = 0,
};
/// DMA channel 5 peripheral address
pub const CPAR5 = Register(CPAR5_val).init(base_address + 0x60);

/// CMAR5
const CMAR5_val = packed struct {
/// MA [0:31]
/// Memory address
MA: u32 = 0,
};
/// DMA channel 5 memory address
pub const CMAR5 = Register(CMAR5_val).init(base_address + 0x64);

/// CCR6
const CCR6_val = packed struct {
/// EN [0:0]
/// Channel enable
EN: u1 = 0,
/// TCIE [1:1]
/// Transfer complete interrupt
TCIE: u1 = 0,
/// HTIE [2:2]
/// Half Transfer interrupt
HTIE: u1 = 0,
/// TEIE [3:3]
/// Transfer error interrupt
TEIE: u1 = 0,
/// DIR [4:4]
/// Data transfer direction
DIR: u1 = 0,
/// CIRC [5:5]
/// Circular mode
CIRC: u1 = 0,
/// PINC [6:6]
/// Peripheral increment mode
PINC: u1 = 0,
/// MINC [7:7]
/// Memory increment mode
MINC: u1 = 0,
/// PSIZE [8:9]
/// Peripheral size
PSIZE: u2 = 0,
/// MSIZE [10:11]
/// Memory size
MSIZE: u2 = 0,
/// PL [12:13]
/// Channel Priority level
PL: u2 = 0,
/// MEM2MEM [14:14]
/// Memory to memory mode
MEM2MEM: u1 = 0,
/// unused [15:31]
_unused15: u1 = 0,
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// DMA channel configuration register
pub const CCR6 = Register(CCR6_val).init(base_address + 0x6c);

/// CNDTR6
const CNDTR6_val = packed struct {
/// NDT [0:15]
/// Number of data to transfer
NDT: u16 = 0,
/// unused [16:31]
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// DMA channel 6 number of data
pub const CNDTR6 = Register(CNDTR6_val).init(base_address + 0x70);

/// CPAR6
const CPAR6_val = packed struct {
/// PA [0:31]
/// Peripheral address
PA: u32 = 0,
};
/// DMA channel 6 peripheral address
pub const CPAR6 = Register(CPAR6_val).init(base_address + 0x74);

/// CMAR6
const CMAR6_val = packed struct {
/// MA [0:31]
/// Memory address
MA: u32 = 0,
};
/// DMA channel 6 memory address
pub const CMAR6 = Register(CMAR6_val).init(base_address + 0x78);

/// CCR7
const CCR7_val = packed struct {
/// EN [0:0]
/// Channel enable
EN: u1 = 0,
/// TCIE [1:1]
/// Transfer complete interrupt
TCIE: u1 = 0,
/// HTIE [2:2]
/// Half Transfer interrupt
HTIE: u1 = 0,
/// TEIE [3:3]
/// Transfer error interrupt
TEIE: u1 = 0,
/// DIR [4:4]
/// Data transfer direction
DIR: u1 = 0,
/// CIRC [5:5]
/// Circular mode
CIRC: u1 = 0,
/// PINC [6:6]
/// Peripheral increment mode
PINC: u1 = 0,
/// MINC [7:7]
/// Memory increment mode
MINC: u1 = 0,
/// PSIZE [8:9]
/// Peripheral size
PSIZE: u2 = 0,
/// MSIZE [10:11]
/// Memory size
MSIZE: u2 = 0,
/// PL [12:13]
/// Channel Priority level
PL: u2 = 0,
/// MEM2MEM [14:14]
/// Memory to memory mode
MEM2MEM: u1 = 0,
/// unused [15:31]
_unused15: u1 = 0,
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// DMA channel configuration register
pub const CCR7 = Register(CCR7_val).init(base_address + 0x80);

/// CNDTR7
const CNDTR7_val = packed struct {
/// NDT [0:15]
/// Number of data to transfer
NDT: u16 = 0,
/// unused [16:31]
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// DMA channel 7 number of data
pub const CNDTR7 = Register(CNDTR7_val).init(base_address + 0x84);

/// CPAR7
const CPAR7_val = packed struct {
/// PA [0:31]
/// Peripheral address
PA: u32 = 0,
};
/// DMA channel 7 peripheral address
pub const CPAR7 = Register(CPAR7_val).init(base_address + 0x88);

/// CMAR7
const CMAR7_val = packed struct {
/// MA [0:31]
/// Memory address
MA: u32 = 0,
};
/// DMA channel 7 memory address
pub const CMAR7 = Register(CMAR7_val).init(base_address + 0x8c);
};

/// General purpose timer
pub const TIM2 = struct {

const base_address = 0x40000000;
/// CR1
const CR1_val = packed struct {
/// CEN [0:0]
/// Counter enable
CEN: u1 = 0,
/// UDIS [1:1]
/// Update disable
UDIS: u1 = 0,
/// URS [2:2]
/// Update request source
URS: u1 = 0,
/// OPM [3:3]
/// One-pulse mode
OPM: u1 = 0,
/// DIR [4:4]
/// Direction
DIR: u1 = 0,
/// CMS [5:6]
/// Center-aligned mode
CMS: u2 = 0,
/// ARPE [7:7]
/// Auto-reload preload enable
ARPE: u1 = 0,
/// CKD [8:9]
/// Clock division
CKD: u2 = 0,
/// unused [10:10]
_unused10: u1 = 0,
/// UIFREMAP [11:11]
/// UIF status bit remapping
UIFREMAP: u1 = 0,
/// unused [12:31]
_unused12: u4 = 0,
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// control register 1
pub const CR1 = Register(CR1_val).init(base_address + 0x0);

/// CR2
const CR2_val = packed struct {
/// unused [0:2]
_unused0: u3 = 0,
/// CCDS [3:3]
/// Capture/compare DMA
CCDS: u1 = 0,
/// MMS [4:6]
/// Master mode selection
MMS: u3 = 0,
/// TI1S [7:7]
/// TI1 selection
TI1S: u1 = 0,
/// unused [8:31]
_unused8: u8 = 0,
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// control register 2
pub const CR2 = Register(CR2_val).init(base_address + 0x4);

/// SMCR
const SMCR_val = packed struct {
/// SMS [0:2]
/// Slave mode selection
SMS: u3 = 0,
/// OCCS [3:3]
/// OCREF clear selection
OCCS: u1 = 0,
/// TS [4:6]
/// Trigger selection
TS: u3 = 0,
/// MSM [7:7]
/// Master/Slave mode
MSM: u1 = 0,
/// ETF [8:11]
/// External trigger filter
ETF: u4 = 0,
/// ETPS [12:13]
/// External trigger prescaler
ETPS: u2 = 0,
/// ECE [14:14]
/// External clock enable
ECE: u1 = 0,
/// ETP [15:15]
/// External trigger polarity
ETP: u1 = 0,
/// SMS_3 [16:16]
/// Slave mode selection bit3
SMS_3: u1 = 0,
/// unused [17:31]
_unused17: u7 = 0,
_unused24: u8 = 0,
};
/// slave mode control register
pub const SMCR = Register(SMCR_val).init(base_address + 0x8);

/// DIER
const DIER_val = packed struct {
/// UIE [0:0]
/// Update interrupt enable
UIE: u1 = 0,
/// CC1IE [1:1]
/// Capture/Compare 1 interrupt
CC1IE: u1 = 0,
/// CC2IE [2:2]
/// Capture/Compare 2 interrupt
CC2IE: u1 = 0,
/// CC3IE [3:3]
/// Capture/Compare 3 interrupt
CC3IE: u1 = 0,
/// CC4IE [4:4]
/// Capture/Compare 4 interrupt
CC4IE: u1 = 0,
/// unused [5:5]
_unused5: u1 = 0,
/// TIE [6:6]
/// Trigger interrupt enable
TIE: u1 = 0,
/// unused [7:7]
_unused7: u1 = 0,
/// UDE [8:8]
/// Update DMA request enable
UDE: u1 = 0,
/// CC1DE [9:9]
/// Capture/Compare 1 DMA request
CC1DE: u1 = 0,
/// CC2DE [10:10]
/// Capture/Compare 2 DMA request
CC2DE: u1 = 0,
/// CC3DE [11:11]
/// Capture/Compare 3 DMA request
CC3DE: u1 = 0,
/// CC4DE [12:12]
/// Capture/Compare 4 DMA request
CC4DE: u1 = 0,
/// unused [13:13]
_unused13: u1 = 0,
/// TDE [14:14]
/// Trigger DMA request enable
TDE: u1 = 0,
/// unused [15:31]
_unused15: u1 = 0,
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// DMA/Interrupt enable register
pub const DIER = Register(DIER_val).init(base_address + 0xc);

/// SR
const SR_val = packed struct {
/// UIF [0:0]
/// Update interrupt flag
UIF: u1 = 0,
/// CC1IF [1:1]
/// Capture/compare 1 interrupt
CC1IF: u1 = 0,
/// CC2IF [2:2]
/// Capture/Compare 2 interrupt
CC2IF: u1 = 0,
/// CC3IF [3:3]
/// Capture/Compare 3 interrupt
CC3IF: u1 = 0,
/// CC4IF [4:4]
/// Capture/Compare 4 interrupt
CC4IF: u1 = 0,
/// unused [5:5]
_unused5: u1 = 0,
/// TIF [6:6]
/// Trigger interrupt flag
TIF: u1 = 0,
/// unused [7:8]
_unused7: u1 = 0,
_unused8: u1 = 0,
/// CC1OF [9:9]
/// Capture/Compare 1 overcapture
CC1OF: u1 = 0,
/// CC2OF [10:10]
/// Capture/compare 2 overcapture
CC2OF: u1 = 0,
/// CC3OF [11:11]
/// Capture/Compare 3 overcapture
CC3OF: u1 = 0,
/// CC4OF [12:12]
/// Capture/Compare 4 overcapture
CC4OF: u1 = 0,
/// unused [13:31]
_unused13: u3 = 0,
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// status register
pub const SR = Register(SR_val).init(base_address + 0x10);

/// EGR
const EGR_val = packed struct {
/// UG [0:0]
/// Update generation
UG: u1 = 0,
/// CC1G [1:1]
/// Capture/compare 1
CC1G: u1 = 0,
/// CC2G [2:2]
/// Capture/compare 2
CC2G: u1 = 0,
/// CC3G [3:3]
/// Capture/compare 3
CC3G: u1 = 0,
/// CC4G [4:4]
/// Capture/compare 4
CC4G: u1 = 0,
/// unused [5:5]
_unused5: u1 = 0,
/// TG [6:6]
/// Trigger generation
TG: u1 = 0,
/// unused [7:31]
_unused7: u1 = 0,
_unused8: u8 = 0,
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// event generation register
pub const EGR = Register(EGR_val).init(base_address + 0x14);

/// CCMR1_Output
const CCMR1_Output_val = packed struct {
/// CC1S [0:1]
/// Capture/Compare 1
CC1S: u2 = 0,
/// OC1FE [2:2]
/// Output compare 1 fast
OC1FE: u1 = 0,
/// OC1PE [3:3]
/// Output compare 1 preload
OC1PE: u1 = 0,
/// OC1M [4:6]
/// Output compare 1 mode
OC1M: u3 = 0,
/// OC1CE [7:7]
/// Output compare 1 clear
OC1CE: u1 = 0,
/// CC2S [8:9]
/// Capture/Compare 2
CC2S: u2 = 0,
/// OC2FE [10:10]
/// Output compare 2 fast
OC2FE: u1 = 0,
/// OC2PE [11:11]
/// Output compare 2 preload
OC2PE: u1 = 0,
/// OC2M [12:14]
/// Output compare 2 mode
OC2M: u3 = 0,
/// OC2CE [15:15]
/// Output compare 2 clear
OC2CE: u1 = 0,
/// OC1M_3 [16:16]
/// Output compare 1 mode bit
OC1M_3: u1 = 0,
/// unused [17:23]
_unused17: u7 = 0,
/// OC2M_3 [24:24]
/// Output compare 2 mode bit
OC2M_3: u1 = 0,
/// unused [25:31]
_unused25: u7 = 0,
};
/// capture/compare mode register 1 (output
pub const CCMR1_Output = Register(CCMR1_Output_val).init(base_address + 0x18);

/// CCMR1_Input
const CCMR1_Input_val = packed struct {
/// CC1S [0:1]
/// Capture/Compare 1
CC1S: u2 = 0,
/// IC1PSC [2:3]
/// Input capture 1 prescaler
IC1PSC: u2 = 0,
/// IC1F [4:7]
/// Input capture 1 filter
IC1F: u4 = 0,
/// CC2S [8:9]
/// Capture/compare 2
CC2S: u2 = 0,
/// IC2PSC [10:11]
/// Input capture 2 prescaler
IC2PSC: u2 = 0,
/// IC2F [12:15]
/// Input capture 2 filter
IC2F: u4 = 0,
/// unused [16:31]
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// capture/compare mode register 1 (input
pub const CCMR1_Input = Register(CCMR1_Input_val).init(base_address + 0x18);

/// CCMR2_Output
const CCMR2_Output_val = packed struct {
/// CC3S [0:1]
/// Capture/Compare 3
CC3S: u2 = 0,
/// OC3FE [2:2]
/// Output compare 3 fast
OC3FE: u1 = 0,
/// OC3PE [3:3]
/// Output compare 3 preload
OC3PE: u1 = 0,
/// OC3M [4:6]
/// Output compare 3 mode
OC3M: u3 = 0,
/// OC3CE [7:7]
/// Output compare 3 clear
OC3CE: u1 = 0,
/// CC4S [8:9]
/// Capture/Compare 4
CC4S: u2 = 0,
/// OC4FE [10:10]
/// Output compare 4 fast
OC4FE: u1 = 0,
/// OC4PE [11:11]
/// Output compare 4 preload
OC4PE: u1 = 0,
/// OC4M [12:14]
/// Output compare 4 mode
OC4M: u3 = 0,
/// O24CE [15:15]
/// Output compare 4 clear
O24CE: u1 = 0,
/// OC3M_3 [16:16]
/// Output compare 3 mode bit3
OC3M_3: u1 = 0,
/// unused [17:23]
_unused17: u7 = 0,
/// OC4M_3 [24:24]
/// Output compare 4 mode bit3
OC4M_3: u1 = 0,
/// unused [25:31]
_unused25: u7 = 0,
};
/// capture/compare mode register 2 (output
pub const CCMR2_Output = Register(CCMR2_Output_val).init(base_address + 0x1c);

/// CCMR2_Input
const CCMR2_Input_val = packed struct {
/// CC3S [0:1]
/// Capture/Compare 3
CC3S: u2 = 0,
/// IC3PSC [2:3]
/// Input capture 3 prescaler
IC3PSC: u2 = 0,
/// IC3F [4:7]
/// Input capture 3 filter
IC3F: u4 = 0,
/// CC4S [8:9]
/// Capture/Compare 4
CC4S: u2 = 0,
/// IC4PSC [10:11]
/// Input capture 4 prescaler
IC4PSC: u2 = 0,
/// IC4F [12:15]
/// Input capture 4 filter
IC4F: u4 = 0,
/// unused [16:31]
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// capture/compare mode register 2 (input
pub const CCMR2_Input = Register(CCMR2_Input_val).init(base_address + 0x1c);

/// CCER
const CCER_val = packed struct {
/// CC1E [0:0]
/// Capture/Compare 1 output
CC1E: u1 = 0,
/// CC1P [1:1]
/// Capture/Compare 1 output
CC1P: u1 = 0,
/// unused [2:2]
_unused2: u1 = 0,
/// CC1NP [3:3]
/// Capture/Compare 1 output
CC1NP: u1 = 0,
/// CC2E [4:4]
/// Capture/Compare 2 output
CC2E: u1 = 0,
/// CC2P [5:5]
/// Capture/Compare 2 output
CC2P: u1 = 0,
/// unused [6:6]
_unused6: u1 = 0,
/// CC2NP [7:7]
/// Capture/Compare 2 output
CC2NP: u1 = 0,
/// CC3E [8:8]
/// Capture/Compare 3 output
CC3E: u1 = 0,
/// CC3P [9:9]
/// Capture/Compare 3 output
CC3P: u1 = 0,
/// unused [10:10]
_unused10: u1 = 0,
/// CC3NP [11:11]
/// Capture/Compare 3 output
CC3NP: u1 = 0,
/// CC4E [12:12]
/// Capture/Compare 4 output
CC4E: u1 = 0,
/// CC4P [13:13]
/// Capture/Compare 3 output
CC4P: u1 = 0,
/// unused [14:14]
_unused14: u1 = 0,
/// CC4NP [15:15]
/// Capture/Compare 3 output
CC4NP: u1 = 0,
/// unused [16:31]
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// capture/compare enable
pub const CCER = Register(CCER_val).init(base_address + 0x20);

/// CNT
const CNT_val = packed struct {
/// CNTL [0:15]
/// Low counter value
CNTL: u16 = 0,
/// CNTH [16:30]
/// High counter value
CNTH: u15 = 0,
/// CNT_or_UIFCPY [31:31]
/// if IUFREMAP=0 than CNT with read write
CNT_or_UIFCPY: u1 = 0,
};
/// counter
pub const CNT = Register(CNT_val).init(base_address + 0x24);

/// PSC
const PSC_val = packed struct {
/// PSC [0:15]
/// Prescaler value
PSC: u16 = 0,
/// unused [16:31]
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// prescaler
pub const PSC = Register(PSC_val).init(base_address + 0x28);

/// ARR
const ARR_val = packed struct {
/// ARRL [0:15]
/// Low Auto-reload value
ARRL: u16 = 0,
/// ARRH [16:31]
/// High Auto-reload value
ARRH: u16 = 0,
};
/// auto-reload register
pub const ARR = Register(ARR_val).init(base_address + 0x2c);

/// CCR1
const CCR1_val = packed struct {
/// CCR1L [0:15]
/// Low Capture/Compare 1
CCR1L: u16 = 0,
/// CCR1H [16:31]
/// High Capture/Compare 1 value (on
CCR1H: u16 = 0,
};
/// capture/compare register 1
pub const CCR1 = Register(CCR1_val).init(base_address + 0x34);

/// CCR2
const CCR2_val = packed struct {
/// CCR2L [0:15]
/// Low Capture/Compare 2
CCR2L: u16 = 0,
/// CCR2H [16:31]
/// High Capture/Compare 2 value (on
CCR2H: u16 = 0,
};
/// capture/compare register 2
pub const CCR2 = Register(CCR2_val).init(base_address + 0x38);

/// CCR3
const CCR3_val = packed struct {
/// CCR3L [0:15]
/// Low Capture/Compare value
CCR3L: u16 = 0,
/// CCR3H [16:31]
/// High Capture/Compare value (on
CCR3H: u16 = 0,
};
/// capture/compare register 3
pub const CCR3 = Register(CCR3_val).init(base_address + 0x3c);

/// CCR4
const CCR4_val = packed struct {
/// CCR4L [0:15]
/// Low Capture/Compare value
CCR4L: u16 = 0,
/// CCR4H [16:31]
/// High Capture/Compare value (on
CCR4H: u16 = 0,
};
/// capture/compare register 4
pub const CCR4 = Register(CCR4_val).init(base_address + 0x40);

/// DCR
const DCR_val = packed struct {
/// DBA [0:4]
/// DMA base address
DBA: u5 = 0,
/// unused [5:7]
_unused5: u3 = 0,
/// DBL [8:12]
/// DMA burst length
DBL: u5 = 0,
/// unused [13:31]
_unused13: u3 = 0,
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// DMA control register
pub const DCR = Register(DCR_val).init(base_address + 0x48);

/// DMAR
const DMAR_val = packed struct {
/// DMAB [0:15]
/// DMA register for burst
DMAB: u16 = 0,
/// unused [16:31]
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// DMA address for full transfer
pub const DMAR = Register(DMAR_val).init(base_address + 0x4c);
};

/// General purpose timer
pub const TIM3 = struct {

const base_address = 0x40000400;
/// CR1
const CR1_val = packed struct {
/// CEN [0:0]
/// Counter enable
CEN: u1 = 0,
/// UDIS [1:1]
/// Update disable
UDIS: u1 = 0,
/// URS [2:2]
/// Update request source
URS: u1 = 0,
/// OPM [3:3]
/// One-pulse mode
OPM: u1 = 0,
/// DIR [4:4]
/// Direction
DIR: u1 = 0,
/// CMS [5:6]
/// Center-aligned mode
CMS: u2 = 0,
/// ARPE [7:7]
/// Auto-reload preload enable
ARPE: u1 = 0,
/// CKD [8:9]
/// Clock division
CKD: u2 = 0,
/// unused [10:10]
_unused10: u1 = 0,
/// UIFREMAP [11:11]
/// UIF status bit remapping
UIFREMAP: u1 = 0,
/// unused [12:31]
_unused12: u4 = 0,
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// control register 1
pub const CR1 = Register(CR1_val).init(base_address + 0x0);

/// CR2
const CR2_val = packed struct {
/// unused [0:2]
_unused0: u3 = 0,
/// CCDS [3:3]
/// Capture/compare DMA
CCDS: u1 = 0,
/// MMS [4:6]
/// Master mode selection
MMS: u3 = 0,
/// TI1S [7:7]
/// TI1 selection
TI1S: u1 = 0,
/// unused [8:31]
_unused8: u8 = 0,
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// control register 2
pub const CR2 = Register(CR2_val).init(base_address + 0x4);

/// SMCR
const SMCR_val = packed struct {
/// SMS [0:2]
/// Slave mode selection
SMS: u3 = 0,
/// OCCS [3:3]
/// OCREF clear selection
OCCS: u1 = 0,
/// TS [4:6]
/// Trigger selection
TS: u3 = 0,
/// MSM [7:7]
/// Master/Slave mode
MSM: u1 = 0,
/// ETF [8:11]
/// External trigger filter
ETF: u4 = 0,
/// ETPS [12:13]
/// External trigger prescaler
ETPS: u2 = 0,
/// ECE [14:14]
/// External clock enable
ECE: u1 = 0,
/// ETP [15:15]
/// External trigger polarity
ETP: u1 = 0,
/// SMS_3 [16:16]
/// Slave mode selection bit3
SMS_3: u1 = 0,
/// unused [17:31]
_unused17: u7 = 0,
_unused24: u8 = 0,
};
/// slave mode control register
pub const SMCR = Register(SMCR_val).init(base_address + 0x8);

/// DIER
const DIER_val = packed struct {
/// UIE [0:0]
/// Update interrupt enable
UIE: u1 = 0,
/// CC1IE [1:1]
/// Capture/Compare 1 interrupt
CC1IE: u1 = 0,
/// CC2IE [2:2]
/// Capture/Compare 2 interrupt
CC2IE: u1 = 0,
/// CC3IE [3:3]
/// Capture/Compare 3 interrupt
CC3IE: u1 = 0,
/// CC4IE [4:4]
/// Capture/Compare 4 interrupt
CC4IE: u1 = 0,
/// unused [5:5]
_unused5: u1 = 0,
/// TIE [6:6]
/// Trigger interrupt enable
TIE: u1 = 0,
/// unused [7:7]
_unused7: u1 = 0,
/// UDE [8:8]
/// Update DMA request enable
UDE: u1 = 0,
/// CC1DE [9:9]
/// Capture/Compare 1 DMA request
CC1DE: u1 = 0,
/// CC2DE [10:10]
/// Capture/Compare 2 DMA request
CC2DE: u1 = 0,
/// CC3DE [11:11]
/// Capture/Compare 3 DMA request
CC3DE: u1 = 0,
/// CC4DE [12:12]
/// Capture/Compare 4 DMA request
CC4DE: u1 = 0,
/// unused [13:13]
_unused13: u1 = 0,
/// TDE [14:14]
/// Trigger DMA request enable
TDE: u1 = 0,
/// unused [15:31]
_unused15: u1 = 0,
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// DMA/Interrupt enable register
pub const DIER = Register(DIER_val).init(base_address + 0xc);

/// SR
const SR_val = packed struct {
/// UIF [0:0]
/// Update interrupt flag
UIF: u1 = 0,
/// CC1IF [1:1]
/// Capture/compare 1 interrupt
CC1IF: u1 = 0,
/// CC2IF [2:2]
/// Capture/Compare 2 interrupt
CC2IF: u1 = 0,
/// CC3IF [3:3]
/// Capture/Compare 3 interrupt
CC3IF: u1 = 0,
/// CC4IF [4:4]
/// Capture/Compare 4 interrupt
CC4IF: u1 = 0,
/// unused [5:5]
_unused5: u1 = 0,
/// TIF [6:6]
/// Trigger interrupt flag
TIF: u1 = 0,
/// unused [7:8]
_unused7: u1 = 0,
_unused8: u1 = 0,
/// CC1OF [9:9]
/// Capture/Compare 1 overcapture
CC1OF: u1 = 0,
/// CC2OF [10:10]
/// Capture/compare 2 overcapture
CC2OF: u1 = 0,
/// CC3OF [11:11]
/// Capture/Compare 3 overcapture
CC3OF: u1 = 0,
/// CC4OF [12:12]
/// Capture/Compare 4 overcapture
CC4OF: u1 = 0,
/// unused [13:31]
_unused13: u3 = 0,
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// status register
pub const SR = Register(SR_val).init(base_address + 0x10);

/// EGR
const EGR_val = packed struct {
/// UG [0:0]
/// Update generation
UG: u1 = 0,
/// CC1G [1:1]
/// Capture/compare 1
CC1G: u1 = 0,
/// CC2G [2:2]
/// Capture/compare 2
CC2G: u1 = 0,
/// CC3G [3:3]
/// Capture/compare 3
CC3G: u1 = 0,
/// CC4G [4:4]
/// Capture/compare 4
CC4G: u1 = 0,
/// unused [5:5]
_unused5: u1 = 0,
/// TG [6:6]
/// Trigger generation
TG: u1 = 0,
/// unused [7:31]
_unused7: u1 = 0,
_unused8: u8 = 0,
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// event generation register
pub const EGR = Register(EGR_val).init(base_address + 0x14);

/// CCMR1_Output
const CCMR1_Output_val = packed struct {
/// CC1S [0:1]
/// Capture/Compare 1
CC1S: u2 = 0,
/// OC1FE [2:2]
/// Output compare 1 fast
OC1FE: u1 = 0,
/// OC1PE [3:3]
/// Output compare 1 preload
OC1PE: u1 = 0,
/// OC1M [4:6]
/// Output compare 1 mode
OC1M: u3 = 0,
/// OC1CE [7:7]
/// Output compare 1 clear
OC1CE: u1 = 0,
/// CC2S [8:9]
/// Capture/Compare 2
CC2S: u2 = 0,
/// OC2FE [10:10]
/// Output compare 2 fast
OC2FE: u1 = 0,
/// OC2PE [11:11]
/// Output compare 2 preload
OC2PE: u1 = 0,
/// OC2M [12:14]
/// Output compare 2 mode
OC2M: u3 = 0,
/// OC2CE [15:15]
/// Output compare 2 clear
OC2CE: u1 = 0,
/// OC1M_3 [16:16]
/// Output compare 1 mode bit
OC1M_3: u1 = 0,
/// unused [17:23]
_unused17: u7 = 0,
/// OC2M_3 [24:24]
/// Output compare 2 mode bit
OC2M_3: u1 = 0,
/// unused [25:31]
_unused25: u7 = 0,
};
/// capture/compare mode register 1 (output
pub const CCMR1_Output = Register(CCMR1_Output_val).init(base_address + 0x18);

/// CCMR1_Input
const CCMR1_Input_val = packed struct {
/// CC1S [0:1]
/// Capture/Compare 1
CC1S: u2 = 0,
/// IC1PSC [2:3]
/// Input capture 1 prescaler
IC1PSC: u2 = 0,
/// IC1F [4:7]
/// Input capture 1 filter
IC1F: u4 = 0,
/// CC2S [8:9]
/// Capture/compare 2
CC2S: u2 = 0,
/// IC2PSC [10:11]
/// Input capture 2 prescaler
IC2PSC: u2 = 0,
/// IC2F [12:15]
/// Input capture 2 filter
IC2F: u4 = 0,
/// unused [16:31]
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// capture/compare mode register 1 (input
pub const CCMR1_Input = Register(CCMR1_Input_val).init(base_address + 0x18);

/// CCMR2_Output
const CCMR2_Output_val = packed struct {
/// CC3S [0:1]
/// Capture/Compare 3
CC3S: u2 = 0,
/// OC3FE [2:2]
/// Output compare 3 fast
OC3FE: u1 = 0,
/// OC3PE [3:3]
/// Output compare 3 preload
OC3PE: u1 = 0,
/// OC3M [4:6]
/// Output compare 3 mode
OC3M: u3 = 0,
/// OC3CE [7:7]
/// Output compare 3 clear
OC3CE: u1 = 0,
/// CC4S [8:9]
/// Capture/Compare 4
CC4S: u2 = 0,
/// OC4FE [10:10]
/// Output compare 4 fast
OC4FE: u1 = 0,
/// OC4PE [11:11]
/// Output compare 4 preload
OC4PE: u1 = 0,
/// OC4M [12:14]
/// Output compare 4 mode
OC4M: u3 = 0,
/// O24CE [15:15]
/// Output compare 4 clear
O24CE: u1 = 0,
/// OC3M_3 [16:16]
/// Output compare 3 mode bit3
OC3M_3: u1 = 0,
/// unused [17:23]
_unused17: u7 = 0,
/// OC4M_3 [24:24]
/// Output compare 4 mode bit3
OC4M_3: u1 = 0,
/// unused [25:31]
_unused25: u7 = 0,
};
/// capture/compare mode register 2 (output
pub const CCMR2_Output = Register(CCMR2_Output_val).init(base_address + 0x1c);

/// CCMR2_Input
const CCMR2_Input_val = packed struct {
/// CC3S [0:1]
/// Capture/Compare 3
CC3S: u2 = 0,
/// IC3PSC [2:3]
/// Input capture 3 prescaler
IC3PSC: u2 = 0,
/// IC3F [4:7]
/// Input capture 3 filter
IC3F: u4 = 0,
/// CC4S [8:9]
/// Capture/Compare 4
CC4S: u2 = 0,
/// IC4PSC [10:11]
/// Input capture 4 prescaler
IC4PSC: u2 = 0,
/// IC4F [12:15]
/// Input capture 4 filter
IC4F: u4 = 0,
/// unused [16:31]
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// capture/compare mode register 2 (input
pub const CCMR2_Input = Register(CCMR2_Input_val).init(base_address + 0x1c);

/// CCER
const CCER_val = packed struct {
/// CC1E [0:0]
/// Capture/Compare 1 output
CC1E: u1 = 0,
/// CC1P [1:1]
/// Capture/Compare 1 output
CC1P: u1 = 0,
/// unused [2:2]
_unused2: u1 = 0,
/// CC1NP [3:3]
/// Capture/Compare 1 output
CC1NP: u1 = 0,
/// CC2E [4:4]
/// Capture/Compare 2 output
CC2E: u1 = 0,
/// CC2P [5:5]
/// Capture/Compare 2 output
CC2P: u1 = 0,
/// unused [6:6]
_unused6: u1 = 0,
/// CC2NP [7:7]
/// Capture/Compare 2 output
CC2NP: u1 = 0,
/// CC3E [8:8]
/// Capture/Compare 3 output
CC3E: u1 = 0,
/// CC3P [9:9]
/// Capture/Compare 3 output
CC3P: u1 = 0,
/// unused [10:10]
_unused10: u1 = 0,
/// CC3NP [11:11]
/// Capture/Compare 3 output
CC3NP: u1 = 0,
/// CC4E [12:12]
/// Capture/Compare 4 output
CC4E: u1 = 0,
/// CC4P [13:13]
/// Capture/Compare 3 output
CC4P: u1 = 0,
/// unused [14:14]
_unused14: u1 = 0,
/// CC4NP [15:15]
/// Capture/Compare 3 output
CC4NP: u1 = 0,
/// unused [16:31]
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// capture/compare enable
pub const CCER = Register(CCER_val).init(base_address + 0x20);

/// CNT
const CNT_val = packed struct {
/// CNTL [0:15]
/// Low counter value
CNTL: u16 = 0,
/// CNTH [16:30]
/// High counter value
CNTH: u15 = 0,
/// CNT_or_UIFCPY [31:31]
/// if IUFREMAP=0 than CNT with read write
CNT_or_UIFCPY: u1 = 0,
};
/// counter
pub const CNT = Register(CNT_val).init(base_address + 0x24);

/// PSC
const PSC_val = packed struct {
/// PSC [0:15]
/// Prescaler value
PSC: u16 = 0,
/// unused [16:31]
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// prescaler
pub const PSC = Register(PSC_val).init(base_address + 0x28);

/// ARR
const ARR_val = packed struct {
/// ARRL [0:15]
/// Low Auto-reload value
ARRL: u16 = 0,
/// ARRH [16:31]
/// High Auto-reload value
ARRH: u16 = 0,
};
/// auto-reload register
pub const ARR = Register(ARR_val).init(base_address + 0x2c);

/// CCR1
const CCR1_val = packed struct {
/// CCR1L [0:15]
/// Low Capture/Compare 1
CCR1L: u16 = 0,
/// CCR1H [16:31]
/// High Capture/Compare 1 value (on
CCR1H: u16 = 0,
};
/// capture/compare register 1
pub const CCR1 = Register(CCR1_val).init(base_address + 0x34);

/// CCR2
const CCR2_val = packed struct {
/// CCR2L [0:15]
/// Low Capture/Compare 2
CCR2L: u16 = 0,
/// CCR2H [16:31]
/// High Capture/Compare 2 value (on
CCR2H: u16 = 0,
};
/// capture/compare register 2
pub const CCR2 = Register(CCR2_val).init(base_address + 0x38);

/// CCR3
const CCR3_val = packed struct {
/// CCR3L [0:15]
/// Low Capture/Compare value
CCR3L: u16 = 0,
/// CCR3H [16:31]
/// High Capture/Compare value (on
CCR3H: u16 = 0,
};
/// capture/compare register 3
pub const CCR3 = Register(CCR3_val).init(base_address + 0x3c);

/// CCR4
const CCR4_val = packed struct {
/// CCR4L [0:15]
/// Low Capture/Compare value
CCR4L: u16 = 0,
/// CCR4H [16:31]
/// High Capture/Compare value (on
CCR4H: u16 = 0,
};
/// capture/compare register 4
pub const CCR4 = Register(CCR4_val).init(base_address + 0x40);

/// DCR
const DCR_val = packed struct {
/// DBA [0:4]
/// DMA base address
DBA: u5 = 0,
/// unused [5:7]
_unused5: u3 = 0,
/// DBL [8:12]
/// DMA burst length
DBL: u5 = 0,
/// unused [13:31]
_unused13: u3 = 0,
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// DMA control register
pub const DCR = Register(DCR_val).init(base_address + 0x48);

/// DMAR
const DMAR_val = packed struct {
/// DMAB [0:15]
/// DMA register for burst
DMAB: u16 = 0,
/// unused [16:31]
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// DMA address for full transfer
pub const DMAR = Register(DMAR_val).init(base_address + 0x4c);
};

/// General purpose timer
pub const TIM4 = struct {

const base_address = 0x40000800;
/// CR1
const CR1_val = packed struct {
/// CEN [0:0]
/// Counter enable
CEN: u1 = 0,
/// UDIS [1:1]
/// Update disable
UDIS: u1 = 0,
/// URS [2:2]
/// Update request source
URS: u1 = 0,
/// OPM [3:3]
/// One-pulse mode
OPM: u1 = 0,
/// DIR [4:4]
/// Direction
DIR: u1 = 0,
/// CMS [5:6]
/// Center-aligned mode
CMS: u2 = 0,
/// ARPE [7:7]
/// Auto-reload preload enable
ARPE: u1 = 0,
/// CKD [8:9]
/// Clock division
CKD: u2 = 0,
/// unused [10:10]
_unused10: u1 = 0,
/// UIFREMAP [11:11]
/// UIF status bit remapping
UIFREMAP: u1 = 0,
/// unused [12:31]
_unused12: u4 = 0,
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// control register 1
pub const CR1 = Register(CR1_val).init(base_address + 0x0);

/// CR2
const CR2_val = packed struct {
/// unused [0:2]
_unused0: u3 = 0,
/// CCDS [3:3]
/// Capture/compare DMA
CCDS: u1 = 0,
/// MMS [4:6]
/// Master mode selection
MMS: u3 = 0,
/// TI1S [7:7]
/// TI1 selection
TI1S: u1 = 0,
/// unused [8:31]
_unused8: u8 = 0,
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// control register 2
pub const CR2 = Register(CR2_val).init(base_address + 0x4);

/// SMCR
const SMCR_val = packed struct {
/// SMS [0:2]
/// Slave mode selection
SMS: u3 = 0,
/// OCCS [3:3]
/// OCREF clear selection
OCCS: u1 = 0,
/// TS [4:6]
/// Trigger selection
TS: u3 = 0,
/// MSM [7:7]
/// Master/Slave mode
MSM: u1 = 0,
/// ETF [8:11]
/// External trigger filter
ETF: u4 = 0,
/// ETPS [12:13]
/// External trigger prescaler
ETPS: u2 = 0,
/// ECE [14:14]
/// External clock enable
ECE: u1 = 0,
/// ETP [15:15]
/// External trigger polarity
ETP: u1 = 0,
/// SMS_3 [16:16]
/// Slave mode selection bit3
SMS_3: u1 = 0,
/// unused [17:31]
_unused17: u7 = 0,
_unused24: u8 = 0,
};
/// slave mode control register
pub const SMCR = Register(SMCR_val).init(base_address + 0x8);

/// DIER
const DIER_val = packed struct {
/// UIE [0:0]
/// Update interrupt enable
UIE: u1 = 0,
/// CC1IE [1:1]
/// Capture/Compare 1 interrupt
CC1IE: u1 = 0,
/// CC2IE [2:2]
/// Capture/Compare 2 interrupt
CC2IE: u1 = 0,
/// CC3IE [3:3]
/// Capture/Compare 3 interrupt
CC3IE: u1 = 0,
/// CC4IE [4:4]
/// Capture/Compare 4 interrupt
CC4IE: u1 = 0,
/// unused [5:5]
_unused5: u1 = 0,
/// TIE [6:6]
/// Trigger interrupt enable
TIE: u1 = 0,
/// unused [7:7]
_unused7: u1 = 0,
/// UDE [8:8]
/// Update DMA request enable
UDE: u1 = 0,
/// CC1DE [9:9]
/// Capture/Compare 1 DMA request
CC1DE: u1 = 0,
/// CC2DE [10:10]
/// Capture/Compare 2 DMA request
CC2DE: u1 = 0,
/// CC3DE [11:11]
/// Capture/Compare 3 DMA request
CC3DE: u1 = 0,
/// CC4DE [12:12]
/// Capture/Compare 4 DMA request
CC4DE: u1 = 0,
/// unused [13:13]
_unused13: u1 = 0,
/// TDE [14:14]
/// Trigger DMA request enable
TDE: u1 = 0,
/// unused [15:31]
_unused15: u1 = 0,
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// DMA/Interrupt enable register
pub const DIER = Register(DIER_val).init(base_address + 0xc);

/// SR
const SR_val = packed struct {
/// UIF [0:0]
/// Update interrupt flag
UIF: u1 = 0,
/// CC1IF [1:1]
/// Capture/compare 1 interrupt
CC1IF: u1 = 0,
/// CC2IF [2:2]
/// Capture/Compare 2 interrupt
CC2IF: u1 = 0,
/// CC3IF [3:3]
/// Capture/Compare 3 interrupt
CC3IF: u1 = 0,
/// CC4IF [4:4]
/// Capture/Compare 4 interrupt
CC4IF: u1 = 0,
/// unused [5:5]
_unused5: u1 = 0,
/// TIF [6:6]
/// Trigger interrupt flag
TIF: u1 = 0,
/// unused [7:8]
_unused7: u1 = 0,
_unused8: u1 = 0,
/// CC1OF [9:9]
/// Capture/Compare 1 overcapture
CC1OF: u1 = 0,
/// CC2OF [10:10]
/// Capture/compare 2 overcapture
CC2OF: u1 = 0,
/// CC3OF [11:11]
/// Capture/Compare 3 overcapture
CC3OF: u1 = 0,
/// CC4OF [12:12]
/// Capture/Compare 4 overcapture
CC4OF: u1 = 0,
/// unused [13:31]
_unused13: u3 = 0,
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// status register
pub const SR = Register(SR_val).init(base_address + 0x10);

/// EGR
const EGR_val = packed struct {
/// UG [0:0]
/// Update generation
UG: u1 = 0,
/// CC1G [1:1]
/// Capture/compare 1
CC1G: u1 = 0,
/// CC2G [2:2]
/// Capture/compare 2
CC2G: u1 = 0,
/// CC3G [3:3]
/// Capture/compare 3
CC3G: u1 = 0,
/// CC4G [4:4]
/// Capture/compare 4
CC4G: u1 = 0,
/// unused [5:5]
_unused5: u1 = 0,
/// TG [6:6]
/// Trigger generation
TG: u1 = 0,
/// unused [7:31]
_unused7: u1 = 0,
_unused8: u8 = 0,
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// event generation register
pub const EGR = Register(EGR_val).init(base_address + 0x14);

/// CCMR1_Output
const CCMR1_Output_val = packed struct {
/// CC1S [0:1]
/// Capture/Compare 1
CC1S: u2 = 0,
/// OC1FE [2:2]
/// Output compare 1 fast
OC1FE: u1 = 0,
/// OC1PE [3:3]
/// Output compare 1 preload
OC1PE: u1 = 0,
/// OC1M [4:6]
/// Output compare 1 mode
OC1M: u3 = 0,
/// OC1CE [7:7]
/// Output compare 1 clear
OC1CE: u1 = 0,
/// CC2S [8:9]
/// Capture/Compare 2
CC2S: u2 = 0,
/// OC2FE [10:10]
/// Output compare 2 fast
OC2FE: u1 = 0,
/// OC2PE [11:11]
/// Output compare 2 preload
OC2PE: u1 = 0,
/// OC2M [12:14]
/// Output compare 2 mode
OC2M: u3 = 0,
/// OC2CE [15:15]
/// Output compare 2 clear
OC2CE: u1 = 0,
/// OC1M_3 [16:16]
/// Output compare 1 mode bit
OC1M_3: u1 = 0,
/// unused [17:23]
_unused17: u7 = 0,
/// OC2M_3 [24:24]
/// Output compare 2 mode bit
OC2M_3: u1 = 0,
/// unused [25:31]
_unused25: u7 = 0,
};
/// capture/compare mode register 1 (output
pub const CCMR1_Output = Register(CCMR1_Output_val).init(base_address + 0x18);

/// CCMR1_Input
const CCMR1_Input_val = packed struct {
/// CC1S [0:1]
/// Capture/Compare 1
CC1S: u2 = 0,
/// IC1PSC [2:3]
/// Input capture 1 prescaler
IC1PSC: u2 = 0,
/// IC1F [4:7]
/// Input capture 1 filter
IC1F: u4 = 0,
/// CC2S [8:9]
/// Capture/compare 2
CC2S: u2 = 0,
/// IC2PSC [10:11]
/// Input capture 2 prescaler
IC2PSC: u2 = 0,
/// IC2F [12:15]
/// Input capture 2 filter
IC2F: u4 = 0,
/// unused [16:31]
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// capture/compare mode register 1 (input
pub const CCMR1_Input = Register(CCMR1_Input_val).init(base_address + 0x18);

/// CCMR2_Output
const CCMR2_Output_val = packed struct {
/// CC3S [0:1]
/// Capture/Compare 3
CC3S: u2 = 0,
/// OC3FE [2:2]
/// Output compare 3 fast
OC3FE: u1 = 0,
/// OC3PE [3:3]
/// Output compare 3 preload
OC3PE: u1 = 0,
/// OC3M [4:6]
/// Output compare 3 mode
OC3M: u3 = 0,
/// OC3CE [7:7]
/// Output compare 3 clear
OC3CE: u1 = 0,
/// CC4S [8:9]
/// Capture/Compare 4
CC4S: u2 = 0,
/// OC4FE [10:10]
/// Output compare 4 fast
OC4FE: u1 = 0,
/// OC4PE [11:11]
/// Output compare 4 preload
OC4PE: u1 = 0,
/// OC4M [12:14]
/// Output compare 4 mode
OC4M: u3 = 0,
/// O24CE [15:15]
/// Output compare 4 clear
O24CE: u1 = 0,
/// OC3M_3 [16:16]
/// Output compare 3 mode bit3
OC3M_3: u1 = 0,
/// unused [17:23]
_unused17: u7 = 0,
/// OC4M_3 [24:24]
/// Output compare 4 mode bit3
OC4M_3: u1 = 0,
/// unused [25:31]
_unused25: u7 = 0,
};
/// capture/compare mode register 2 (output
pub const CCMR2_Output = Register(CCMR2_Output_val).init(base_address + 0x1c);

/// CCMR2_Input
const CCMR2_Input_val = packed struct {
/// CC3S [0:1]
/// Capture/Compare 3
CC3S: u2 = 0,
/// IC3PSC [2:3]
/// Input capture 3 prescaler
IC3PSC: u2 = 0,
/// IC3F [4:7]
/// Input capture 3 filter
IC3F: u4 = 0,
/// CC4S [8:9]
/// Capture/Compare 4
CC4S: u2 = 0,
/// IC4PSC [10:11]
/// Input capture 4 prescaler
IC4PSC: u2 = 0,
/// IC4F [12:15]
/// Input capture 4 filter
IC4F: u4 = 0,
/// unused [16:31]
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// capture/compare mode register 2 (input
pub const CCMR2_Input = Register(CCMR2_Input_val).init(base_address + 0x1c);

/// CCER
const CCER_val = packed struct {
/// CC1E [0:0]
/// Capture/Compare 1 output
CC1E: u1 = 0,
/// CC1P [1:1]
/// Capture/Compare 1 output
CC1P: u1 = 0,
/// unused [2:2]
_unused2: u1 = 0,
/// CC1NP [3:3]
/// Capture/Compare 1 output
CC1NP: u1 = 0,
/// CC2E [4:4]
/// Capture/Compare 2 output
CC2E: u1 = 0,
/// CC2P [5:5]
/// Capture/Compare 2 output
CC2P: u1 = 0,
/// unused [6:6]
_unused6: u1 = 0,
/// CC2NP [7:7]
/// Capture/Compare 2 output
CC2NP: u1 = 0,
/// CC3E [8:8]
/// Capture/Compare 3 output
CC3E: u1 = 0,
/// CC3P [9:9]
/// Capture/Compare 3 output
CC3P: u1 = 0,
/// unused [10:10]
_unused10: u1 = 0,
/// CC3NP [11:11]
/// Capture/Compare 3 output
CC3NP: u1 = 0,
/// CC4E [12:12]
/// Capture/Compare 4 output
CC4E: u1 = 0,
/// CC4P [13:13]
/// Capture/Compare 3 output
CC4P: u1 = 0,
/// unused [14:14]
_unused14: u1 = 0,
/// CC4NP [15:15]
/// Capture/Compare 3 output
CC4NP: u1 = 0,
/// unused [16:31]
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// capture/compare enable
pub const CCER = Register(CCER_val).init(base_address + 0x20);

/// CNT
const CNT_val = packed struct {
/// CNTL [0:15]
/// Low counter value
CNTL: u16 = 0,
/// CNTH [16:30]
/// High counter value
CNTH: u15 = 0,
/// CNT_or_UIFCPY [31:31]
/// if IUFREMAP=0 than CNT with read write
CNT_or_UIFCPY: u1 = 0,
};
/// counter
pub const CNT = Register(CNT_val).init(base_address + 0x24);

/// PSC
const PSC_val = packed struct {
/// PSC [0:15]
/// Prescaler value
PSC: u16 = 0,
/// unused [16:31]
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// prescaler
pub const PSC = Register(PSC_val).init(base_address + 0x28);

/// ARR
const ARR_val = packed struct {
/// ARRL [0:15]
/// Low Auto-reload value
ARRL: u16 = 0,
/// ARRH [16:31]
/// High Auto-reload value
ARRH: u16 = 0,
};
/// auto-reload register
pub const ARR = Register(ARR_val).init(base_address + 0x2c);

/// CCR1
const CCR1_val = packed struct {
/// CCR1L [0:15]
/// Low Capture/Compare 1
CCR1L: u16 = 0,
/// CCR1H [16:31]
/// High Capture/Compare 1 value (on
CCR1H: u16 = 0,
};
/// capture/compare register 1
pub const CCR1 = Register(CCR1_val).init(base_address + 0x34);

/// CCR2
const CCR2_val = packed struct {
/// CCR2L [0:15]
/// Low Capture/Compare 2
CCR2L: u16 = 0,
/// CCR2H [16:31]
/// High Capture/Compare 2 value (on
CCR2H: u16 = 0,
};
/// capture/compare register 2
pub const CCR2 = Register(CCR2_val).init(base_address + 0x38);

/// CCR3
const CCR3_val = packed struct {
/// CCR3L [0:15]
/// Low Capture/Compare value
CCR3L: u16 = 0,
/// CCR3H [16:31]
/// High Capture/Compare value (on
CCR3H: u16 = 0,
};
/// capture/compare register 3
pub const CCR3 = Register(CCR3_val).init(base_address + 0x3c);

/// CCR4
const CCR4_val = packed struct {
/// CCR4L [0:15]
/// Low Capture/Compare value
CCR4L: u16 = 0,
/// CCR4H [16:31]
/// High Capture/Compare value (on
CCR4H: u16 = 0,
};
/// capture/compare register 4
pub const CCR4 = Register(CCR4_val).init(base_address + 0x40);

/// DCR
const DCR_val = packed struct {
/// DBA [0:4]
/// DMA base address
DBA: u5 = 0,
/// unused [5:7]
_unused5: u3 = 0,
/// DBL [8:12]
/// DMA burst length
DBL: u5 = 0,
/// unused [13:31]
_unused13: u3 = 0,
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// DMA control register
pub const DCR = Register(DCR_val).init(base_address + 0x48);

/// DMAR
const DMAR_val = packed struct {
/// DMAB [0:15]
/// DMA register for burst
DMAB: u16 = 0,
/// unused [16:31]
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// DMA address for full transfer
pub const DMAR = Register(DMAR_val).init(base_address + 0x4c);
};

/// General purpose timers
pub const TIM15 = struct {

const base_address = 0x40014000;
/// CR1
const CR1_val = packed struct {
/// CEN [0:0]
/// Counter enable
CEN: u1 = 0,
/// UDIS [1:1]
/// Update disable
UDIS: u1 = 0,
/// URS [2:2]
/// Update request source
URS: u1 = 0,
/// OPM [3:3]
/// One-pulse mode
OPM: u1 = 0,
/// unused [4:6]
_unused4: u3 = 0,
/// ARPE [7:7]
/// Auto-reload preload enable
ARPE: u1 = 0,
/// CKD [8:9]
/// Clock division
CKD: u2 = 0,
/// unused [10:10]
_unused10: u1 = 0,
/// UIFREMAP [11:11]
/// UIF status bit remapping
UIFREMAP: u1 = 0,
/// unused [12:31]
_unused12: u4 = 0,
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// control register 1
pub const CR1 = Register(CR1_val).init(base_address + 0x0);

/// CR2
const CR2_val = packed struct {
/// CCPC [0:0]
/// Capture/compare preloaded
CCPC: u1 = 0,
/// unused [1:1]
_unused1: u1 = 0,
/// CCUS [2:2]
/// Capture/compare control update
CCUS: u1 = 0,
/// CCDS [3:3]
/// Capture/compare DMA
CCDS: u1 = 0,
/// MMS [4:6]
/// Master mode selection
MMS: u3 = 0,
/// TI1S [7:7]
/// TI1 selection
TI1S: u1 = 0,
/// OIS1 [8:8]
/// Output Idle state 1
OIS1: u1 = 0,
/// OIS1N [9:9]
/// Output Idle state 1
OIS1N: u1 = 0,
/// OIS2 [10:10]
/// Output Idle state 2
OIS2: u1 = 0,
/// unused [11:31]
_unused11: u5 = 0,
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// control register 2
pub const CR2 = Register(CR2_val).init(base_address + 0x4);

/// SMCR
const SMCR_val = packed struct {
/// SMS [0:2]
/// Slave mode selection
SMS: u3 = 0,
/// unused [3:3]
_unused3: u1 = 0,
/// TS [4:6]
/// Trigger selection
TS: u3 = 0,
/// MSM [7:7]
/// Master/Slave mode
MSM: u1 = 0,
/// unused [8:15]
_unused8: u8 = 0,
/// SMS_3 [16:16]
/// Slave mode selection bit 3
SMS_3: u1 = 0,
/// unused [17:31]
_unused17: u7 = 0,
_unused24: u8 = 0,
};
/// slave mode control register
pub const SMCR = Register(SMCR_val).init(base_address + 0x8);

/// DIER
const DIER_val = packed struct {
/// UIE [0:0]
/// Update interrupt enable
UIE: u1 = 0,
/// CC1IE [1:1]
/// Capture/Compare 1 interrupt
CC1IE: u1 = 0,
/// CC2IE [2:2]
/// Capture/Compare 2 interrupt
CC2IE: u1 = 0,
/// unused [3:4]
_unused3: u2 = 0,
/// COMIE [5:5]
/// COM interrupt enable
COMIE: u1 = 0,
/// TIE [6:6]
/// Trigger interrupt enable
TIE: u1 = 0,
/// BIE [7:7]
/// Break interrupt enable
BIE: u1 = 0,
/// UDE [8:8]
/// Update DMA request enable
UDE: u1 = 0,
/// CC1DE [9:9]
/// Capture/Compare 1 DMA request
CC1DE: u1 = 0,
/// CC2DE [10:10]
/// Capture/Compare 2 DMA request
CC2DE: u1 = 0,
/// unused [11:12]
_unused11: u2 = 0,
/// COMDE [13:13]
/// COM DMA request enable
COMDE: u1 = 0,
/// TDE [14:14]
/// Trigger DMA request enable
TDE: u1 = 0,
/// unused [15:31]
_unused15: u1 = 0,
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// DMA/Interrupt enable register
pub const DIER = Register(DIER_val).init(base_address + 0xc);

/// SR
const SR_val = packed struct {
/// UIF [0:0]
/// Update interrupt flag
UIF: u1 = 0,
/// CC1IF [1:1]
/// Capture/compare 1 interrupt
CC1IF: u1 = 0,
/// CC2IF [2:2]
/// Capture/Compare 2 interrupt
CC2IF: u1 = 0,
/// unused [3:4]
_unused3: u2 = 0,
/// COMIF [5:5]
/// COM interrupt flag
COMIF: u1 = 0,
/// TIF [6:6]
/// Trigger interrupt flag
TIF: u1 = 0,
/// BIF [7:7]
/// Break interrupt flag
BIF: u1 = 0,
/// unused [8:8]
_unused8: u1 = 0,
/// CC1OF [9:9]
/// Capture/Compare 1 overcapture
CC1OF: u1 = 0,
/// CC2OF [10:10]
/// Capture/compare 2 overcapture
CC2OF: u1 = 0,
/// unused [11:31]
_unused11: u5 = 0,
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// status register
pub const SR = Register(SR_val).init(base_address + 0x10);

/// EGR
const EGR_val = packed struct {
/// UG [0:0]
/// Update generation
UG: u1 = 0,
/// CC1G [1:1]
/// Capture/compare 1
CC1G: u1 = 0,
/// CC2G [2:2]
/// Capture/compare 2
CC2G: u1 = 0,
/// unused [3:4]
_unused3: u2 = 0,
/// COMG [5:5]
/// Capture/Compare control update
COMG: u1 = 0,
/// TG [6:6]
/// Trigger generation
TG: u1 = 0,
/// BG [7:7]
/// Break generation
BG: u1 = 0,
/// unused [8:31]
_unused8: u8 = 0,
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// event generation register
pub const EGR = Register(EGR_val).init(base_address + 0x14);

/// CCMR1_Output
const CCMR1_Output_val = packed struct {
/// CC1S [0:1]
/// Capture/Compare 1
CC1S: u2 = 0,
/// OC1FE [2:2]
/// Output Compare 1 fast
OC1FE: u1 = 0,
/// OC1PE [3:3]
/// Output Compare 1 preload
OC1PE: u1 = 0,
/// OC1M [4:6]
/// Output Compare 1 mode
OC1M: u3 = 0,
/// unused [7:7]
_unused7: u1 = 0,
/// CC2S [8:9]
/// Capture/Compare 2
CC2S: u2 = 0,
/// OC2FE [10:10]
/// Output Compare 2 fast
OC2FE: u1 = 0,
/// OC2PE [11:11]
/// Output Compare 2 preload
OC2PE: u1 = 0,
/// OC2M [12:14]
/// Output Compare 2 mode
OC2M: u3 = 0,
/// unused [15:15]
_unused15: u1 = 0,
/// OC1M_3 [16:16]
/// Output Compare 1 mode bit
OC1M_3: u1 = 0,
/// unused [17:23]
_unused17: u7 = 0,
/// OC2M_3 [24:24]
/// Output Compare 2 mode bit
OC2M_3: u1 = 0,
/// unused [25:31]
_unused25: u7 = 0,
};
/// capture/compare mode register (output
pub const CCMR1_Output = Register(CCMR1_Output_val).init(base_address + 0x18);

/// CCMR1_Input
const CCMR1_Input_val = packed struct {
/// CC1S [0:1]
/// Capture/Compare 1
CC1S: u2 = 0,
/// IC1PSC [2:3]
/// Input capture 1 prescaler
IC1PSC: u2 = 0,
/// IC1F [4:7]
/// Input capture 1 filter
IC1F: u4 = 0,
/// CC2S [8:9]
/// Capture/Compare 2
CC2S: u2 = 0,
/// IC2PSC [10:11]
/// Input capture 2 prescaler
IC2PSC: u2 = 0,
/// IC2F [12:15]
/// Input capture 2 filter
IC2F: u4 = 0,
/// unused [16:31]
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// capture/compare mode register 1 (input
pub const CCMR1_Input = Register(CCMR1_Input_val).init(base_address + 0x18);

/// CCER
const CCER_val = packed struct {
/// CC1E [0:0]
/// Capture/Compare 1 output
CC1E: u1 = 0,
/// CC1P [1:1]
/// Capture/Compare 1 output
CC1P: u1 = 0,
/// CC1NE [2:2]
/// Capture/Compare 1 complementary output
CC1NE: u1 = 0,
/// CC1NP [3:3]
/// Capture/Compare 1 output
CC1NP: u1 = 0,
/// CC2E [4:4]
/// Capture/Compare 2 output
CC2E: u1 = 0,
/// CC2P [5:5]
/// Capture/Compare 2 output
CC2P: u1 = 0,
/// unused [6:6]
_unused6: u1 = 0,
/// CC2NP [7:7]
/// Capture/Compare 2 output
CC2NP: u1 = 0,
/// unused [8:31]
_unused8: u8 = 0,
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// capture/compare enable
pub const CCER = Register(CCER_val).init(base_address + 0x20);

/// CNT
const CNT_val = packed struct {
/// CNT [0:15]
/// counter value
CNT: u16 = 0,
/// unused [16:30]
_unused16: u8 = 0,
_unused24: u7 = 0,
/// UIFCPY [31:31]
/// UIF copy
UIFCPY: u1 = 0,
};
/// counter
pub const CNT = Register(CNT_val).init(base_address + 0x24);

/// PSC
const PSC_val = packed struct {
/// PSC [0:15]
/// Prescaler value
PSC: u16 = 0,
/// unused [16:31]
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// prescaler
pub const PSC = Register(PSC_val).init(base_address + 0x28);

/// ARR
const ARR_val = packed struct {
/// ARR [0:15]
/// Auto-reload value
ARR: u16 = 0,
/// unused [16:31]
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// auto-reload register
pub const ARR = Register(ARR_val).init(base_address + 0x2c);

/// RCR
const RCR_val = packed struct {
/// REP [0:7]
/// Repetition counter value
REP: u8 = 0,
/// unused [8:31]
_unused8: u8 = 0,
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// repetition counter register
pub const RCR = Register(RCR_val).init(base_address + 0x30);

/// CCR1
const CCR1_val = packed struct {
/// CCR1 [0:15]
/// Capture/Compare 1 value
CCR1: u16 = 0,
/// unused [16:31]
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// capture/compare register 1
pub const CCR1 = Register(CCR1_val).init(base_address + 0x34);

/// CCR2
const CCR2_val = packed struct {
/// CCR2 [0:15]
/// Capture/Compare 2 value
CCR2: u16 = 0,
/// unused [16:31]
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// capture/compare register 2
pub const CCR2 = Register(CCR2_val).init(base_address + 0x38);

/// BDTR
const BDTR_val = packed struct {
/// DTG [0:7]
/// Dead-time generator setup
DTG: u8 = 0,
/// LOCK [8:9]
/// Lock configuration
LOCK: u2 = 0,
/// OSSI [10:10]
/// Off-state selection for Idle
OSSI: u1 = 0,
/// OSSR [11:11]
/// Off-state selection for Run
OSSR: u1 = 0,
/// BKE [12:12]
/// Break enable
BKE: u1 = 0,
/// BKP [13:13]
/// Break polarity
BKP: u1 = 0,
/// AOE [14:14]
/// Automatic output enable
AOE: u1 = 0,
/// MOE [15:15]
/// Main output enable
MOE: u1 = 0,
/// BKF [16:19]
/// Break filter
BKF: u4 = 0,
/// unused [20:31]
_unused20: u4 = 0,
_unused24: u8 = 0,
};
/// break and dead-time register
pub const BDTR = Register(BDTR_val).init(base_address + 0x44);

/// DCR
const DCR_val = packed struct {
/// DBA [0:4]
/// DMA base address
DBA: u5 = 0,
/// unused [5:7]
_unused5: u3 = 0,
/// DBL [8:12]
/// DMA burst length
DBL: u5 = 0,
/// unused [13:31]
_unused13: u3 = 0,
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// DMA control register
pub const DCR = Register(DCR_val).init(base_address + 0x48);

/// DMAR
const DMAR_val = packed struct {
/// DMAB [0:15]
/// DMA register for burst
DMAB: u16 = 0,
/// unused [16:31]
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// DMA address for full transfer
pub const DMAR = Register(DMAR_val).init(base_address + 0x4c);
};

/// General-purpose-timers
pub const TIM16 = struct {

const base_address = 0x40014400;
/// CR1
const CR1_val = packed struct {
/// CEN [0:0]
/// Counter enable
CEN: u1 = 0,
/// UDIS [1:1]
/// Update disable
UDIS: u1 = 0,
/// URS [2:2]
/// Update request source
URS: u1 = 0,
/// OPM [3:3]
/// One-pulse mode
OPM: u1 = 0,
/// unused [4:6]
_unused4: u3 = 0,
/// ARPE [7:7]
/// Auto-reload preload enable
ARPE: u1 = 0,
/// CKD [8:9]
/// Clock division
CKD: u2 = 0,
/// unused [10:10]
_unused10: u1 = 0,
/// UIFREMAP [11:11]
/// UIF status bit remapping
UIFREMAP: u1 = 0,
/// unused [12:31]
_unused12: u4 = 0,
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// control register 1
pub const CR1 = Register(CR1_val).init(base_address + 0x0);

/// CR2
const CR2_val = packed struct {
/// CCPC [0:0]
/// Capture/compare preloaded
CCPC: u1 = 0,
/// unused [1:1]
_unused1: u1 = 0,
/// CCUS [2:2]
/// Capture/compare control update
CCUS: u1 = 0,
/// CCDS [3:3]
/// Capture/compare DMA
CCDS: u1 = 0,
/// unused [4:7]
_unused4: u4 = 0,
/// OIS1 [8:8]
/// Output Idle state 1
OIS1: u1 = 0,
/// OIS1N [9:9]
/// Output Idle state 1
OIS1N: u1 = 0,
/// unused [10:31]
_unused10: u6 = 0,
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// control register 2
pub const CR2 = Register(CR2_val).init(base_address + 0x4);

/// DIER
const DIER_val = packed struct {
/// UIE [0:0]
/// Update interrupt enable
UIE: u1 = 0,
/// CC1IE [1:1]
/// Capture/Compare 1 interrupt
CC1IE: u1 = 0,
/// unused [2:4]
_unused2: u3 = 0,
/// COMIE [5:5]
/// COM interrupt enable
COMIE: u1 = 0,
/// TIE [6:6]
/// Trigger interrupt enable
TIE: u1 = 0,
/// BIE [7:7]
/// Break interrupt enable
BIE: u1 = 0,
/// UDE [8:8]
/// Update DMA request enable
UDE: u1 = 0,
/// CC1DE [9:9]
/// Capture/Compare 1 DMA request
CC1DE: u1 = 0,
/// unused [10:12]
_unused10: u3 = 0,
/// COMDE [13:13]
/// COM DMA request enable
COMDE: u1 = 0,
/// TDE [14:14]
/// Trigger DMA request enable
TDE: u1 = 0,
/// unused [15:31]
_unused15: u1 = 0,
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// DMA/Interrupt enable register
pub const DIER = Register(DIER_val).init(base_address + 0xc);

/// SR
const SR_val = packed struct {
/// UIF [0:0]
/// Update interrupt flag
UIF: u1 = 0,
/// CC1IF [1:1]
/// Capture/compare 1 interrupt
CC1IF: u1 = 0,
/// unused [2:4]
_unused2: u3 = 0,
/// COMIF [5:5]
/// COM interrupt flag
COMIF: u1 = 0,
/// TIF [6:6]
/// Trigger interrupt flag
TIF: u1 = 0,
/// BIF [7:7]
/// Break interrupt flag
BIF: u1 = 0,
/// unused [8:8]
_unused8: u1 = 0,
/// CC1OF [9:9]
/// Capture/Compare 1 overcapture
CC1OF: u1 = 0,
/// unused [10:31]
_unused10: u6 = 0,
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// status register
pub const SR = Register(SR_val).init(base_address + 0x10);

/// EGR
const EGR_val = packed struct {
/// UG [0:0]
/// Update generation
UG: u1 = 0,
/// CC1G [1:1]
/// Capture/compare 1
CC1G: u1 = 0,
/// unused [2:4]
_unused2: u3 = 0,
/// COMG [5:5]
/// Capture/Compare control update
COMG: u1 = 0,
/// TG [6:6]
/// Trigger generation
TG: u1 = 0,
/// BG [7:7]
/// Break generation
BG: u1 = 0,
/// unused [8:31]
_unused8: u8 = 0,
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// event generation register
pub const EGR = Register(EGR_val).init(base_address + 0x14);

/// CCMR1_Output
const CCMR1_Output_val = packed struct {
/// CC1S [0:1]
/// Capture/Compare 1
CC1S: u2 = 0,
/// OC1FE [2:2]
/// Output Compare 1 fast
OC1FE: u1 = 0,
/// OC1PE [3:3]
/// Output Compare 1 preload
OC1PE: u1 = 0,
/// OC1M [4:6]
/// Output Compare 1 mode
OC1M: u3 = 0,
/// unused [7:15]
_unused7: u1 = 0,
_unused8: u8 = 0,
/// OC1M_3 [16:16]
/// Output Compare 1 mode
OC1M_3: u1 = 0,
/// unused [17:31]
_unused17: u7 = 0,
_unused24: u8 = 0,
};
/// capture/compare mode register (output
pub const CCMR1_Output = Register(CCMR1_Output_val).init(base_address + 0x18);

/// CCMR1_Input
const CCMR1_Input_val = packed struct {
/// CC1S [0:1]
/// Capture/Compare 1
CC1S: u2 = 0,
/// IC1PSC [2:3]
/// Input capture 1 prescaler
IC1PSC: u2 = 0,
/// IC1F [4:7]
/// Input capture 1 filter
IC1F: u4 = 0,
/// unused [8:31]
_unused8: u8 = 0,
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// capture/compare mode register 1 (input
pub const CCMR1_Input = Register(CCMR1_Input_val).init(base_address + 0x18);

/// CCER
const CCER_val = packed struct {
/// CC1E [0:0]
/// Capture/Compare 1 output
CC1E: u1 = 0,
/// CC1P [1:1]
/// Capture/Compare 1 output
CC1P: u1 = 0,
/// CC1NE [2:2]
/// Capture/Compare 1 complementary output
CC1NE: u1 = 0,
/// CC1NP [3:3]
/// Capture/Compare 1 output
CC1NP: u1 = 0,
/// unused [4:31]
_unused4: u4 = 0,
_unused8: u8 = 0,
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// capture/compare enable
pub const CCER = Register(CCER_val).init(base_address + 0x20);

/// CNT
const CNT_val = packed struct {
/// CNT [0:15]
/// counter value
CNT: u16 = 0,
/// unused [16:30]
_unused16: u8 = 0,
_unused24: u7 = 0,
/// UIFCPY [31:31]
/// UIF Copy
UIFCPY: u1 = 0,
};
/// counter
pub const CNT = Register(CNT_val).init(base_address + 0x24);

/// PSC
const PSC_val = packed struct {
/// PSC [0:15]
/// Prescaler value
PSC: u16 = 0,
/// unused [16:31]
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// prescaler
pub const PSC = Register(PSC_val).init(base_address + 0x28);

/// ARR
const ARR_val = packed struct {
/// ARR [0:15]
/// Auto-reload value
ARR: u16 = 0,
/// unused [16:31]
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// auto-reload register
pub const ARR = Register(ARR_val).init(base_address + 0x2c);

/// RCR
const RCR_val = packed struct {
/// REP [0:7]
/// Repetition counter value
REP: u8 = 0,
/// unused [8:31]
_unused8: u8 = 0,
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// repetition counter register
pub const RCR = Register(RCR_val).init(base_address + 0x30);

/// CCR1
const CCR1_val = packed struct {
/// CCR1 [0:15]
/// Capture/Compare 1 value
CCR1: u16 = 0,
/// unused [16:31]
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// capture/compare register 1
pub const CCR1 = Register(CCR1_val).init(base_address + 0x34);

/// BDTR
const BDTR_val = packed struct {
/// DTG [0:7]
/// Dead-time generator setup
DTG: u8 = 0,
/// LOCK [8:9]
/// Lock configuration
LOCK: u2 = 0,
/// OSSI [10:10]
/// Off-state selection for Idle
OSSI: u1 = 0,
/// OSSR [11:11]
/// Off-state selection for Run
OSSR: u1 = 0,
/// BKE [12:12]
/// Break enable
BKE: u1 = 0,
/// BKP [13:13]
/// Break polarity
BKP: u1 = 0,
/// AOE [14:14]
/// Automatic output enable
AOE: u1 = 0,
/// MOE [15:15]
/// Main output enable
MOE: u1 = 0,
/// BKF [16:19]
/// Break filter
BKF: u4 = 0,
/// unused [20:31]
_unused20: u4 = 0,
_unused24: u8 = 0,
};
/// break and dead-time register
pub const BDTR = Register(BDTR_val).init(base_address + 0x44);

/// DCR
const DCR_val = packed struct {
/// DBA [0:4]
/// DMA base address
DBA: u5 = 0,
/// unused [5:7]
_unused5: u3 = 0,
/// DBL [8:12]
/// DMA burst length
DBL: u5 = 0,
/// unused [13:31]
_unused13: u3 = 0,
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// DMA control register
pub const DCR = Register(DCR_val).init(base_address + 0x48);

/// DMAR
const DMAR_val = packed struct {
/// DMAB [0:15]
/// DMA register for burst
DMAB: u16 = 0,
/// unused [16:31]
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// DMA address for full transfer
pub const DMAR = Register(DMAR_val).init(base_address + 0x4c);

/// OR
const OR_val = packed struct {
/// unused [0:31]
_unused0: u8 = 0,
_unused8: u8 = 0,
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// option register
pub const OR = Register(OR_val).init(base_address + 0x50);
};

/// General purpose timer
pub const TIM17 = struct {

const base_address = 0x40014800;
/// CR1
const CR1_val = packed struct {
/// CEN [0:0]
/// Counter enable
CEN: u1 = 0,
/// UDIS [1:1]
/// Update disable
UDIS: u1 = 0,
/// URS [2:2]
/// Update request source
URS: u1 = 0,
/// OPM [3:3]
/// One-pulse mode
OPM: u1 = 0,
/// unused [4:6]
_unused4: u3 = 0,
/// ARPE [7:7]
/// Auto-reload preload enable
ARPE: u1 = 0,
/// CKD [8:9]
/// Clock division
CKD: u2 = 0,
/// unused [10:10]
_unused10: u1 = 0,
/// UIFREMAP [11:11]
/// UIF status bit remapping
UIFREMAP: u1 = 0,
/// unused [12:31]
_unused12: u4 = 0,
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// control register 1
pub const CR1 = Register(CR1_val).init(base_address + 0x0);

/// CR2
const CR2_val = packed struct {
/// CCPC [0:0]
/// Capture/compare preloaded
CCPC: u1 = 0,
/// unused [1:1]
_unused1: u1 = 0,
/// CCUS [2:2]
/// Capture/compare control update
CCUS: u1 = 0,
/// CCDS [3:3]
/// Capture/compare DMA
CCDS: u1 = 0,
/// unused [4:7]
_unused4: u4 = 0,
/// OIS1 [8:8]
/// Output Idle state 1
OIS1: u1 = 0,
/// OIS1N [9:9]
/// Output Idle state 1
OIS1N: u1 = 0,
/// unused [10:31]
_unused10: u6 = 0,
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// control register 2
pub const CR2 = Register(CR2_val).init(base_address + 0x4);

/// DIER
const DIER_val = packed struct {
/// UIE [0:0]
/// Update interrupt enable
UIE: u1 = 0,
/// CC1IE [1:1]
/// Capture/Compare 1 interrupt
CC1IE: u1 = 0,
/// unused [2:4]
_unused2: u3 = 0,
/// COMIE [5:5]
/// COM interrupt enable
COMIE: u1 = 0,
/// TIE [6:6]
/// Trigger interrupt enable
TIE: u1 = 0,
/// BIE [7:7]
/// Break interrupt enable
BIE: u1 = 0,
/// UDE [8:8]
/// Update DMA request enable
UDE: u1 = 0,
/// CC1DE [9:9]
/// Capture/Compare 1 DMA request
CC1DE: u1 = 0,
/// unused [10:12]
_unused10: u3 = 0,
/// COMDE [13:13]
/// COM DMA request enable
COMDE: u1 = 0,
/// TDE [14:14]
/// Trigger DMA request enable
TDE: u1 = 0,
/// unused [15:31]
_unused15: u1 = 0,
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// DMA/Interrupt enable register
pub const DIER = Register(DIER_val).init(base_address + 0xc);

/// SR
const SR_val = packed struct {
/// UIF [0:0]
/// Update interrupt flag
UIF: u1 = 0,
/// CC1IF [1:1]
/// Capture/compare 1 interrupt
CC1IF: u1 = 0,
/// unused [2:4]
_unused2: u3 = 0,
/// COMIF [5:5]
/// COM interrupt flag
COMIF: u1 = 0,
/// TIF [6:6]
/// Trigger interrupt flag
TIF: u1 = 0,
/// BIF [7:7]
/// Break interrupt flag
BIF: u1 = 0,
/// unused [8:8]
_unused8: u1 = 0,
/// CC1OF [9:9]
/// Capture/Compare 1 overcapture
CC1OF: u1 = 0,
/// unused [10:31]
_unused10: u6 = 0,
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// status register
pub const SR = Register(SR_val).init(base_address + 0x10);

/// EGR
const EGR_val = packed struct {
/// UG [0:0]
/// Update generation
UG: u1 = 0,
/// CC1G [1:1]
/// Capture/compare 1
CC1G: u1 = 0,
/// unused [2:4]
_unused2: u3 = 0,
/// COMG [5:5]
/// Capture/Compare control update
COMG: u1 = 0,
/// TG [6:6]
/// Trigger generation
TG: u1 = 0,
/// BG [7:7]
/// Break generation
BG: u1 = 0,
/// unused [8:31]
_unused8: u8 = 0,
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// event generation register
pub const EGR = Register(EGR_val).init(base_address + 0x14);

/// CCMR1_Output
const CCMR1_Output_val = packed struct {
/// CC1S [0:1]
/// Capture/Compare 1
CC1S: u2 = 0,
/// OC1FE [2:2]
/// Output Compare 1 fast
OC1FE: u1 = 0,
/// OC1PE [3:3]
/// Output Compare 1 preload
OC1PE: u1 = 0,
/// OC1M [4:6]
/// Output Compare 1 mode
OC1M: u3 = 0,
/// unused [7:15]
_unused7: u1 = 0,
_unused8: u8 = 0,
/// OC1M_3 [16:16]
/// Output Compare 1 mode
OC1M_3: u1 = 0,
/// unused [17:31]
_unused17: u7 = 0,
_unused24: u8 = 0,
};
/// capture/compare mode register (output
pub const CCMR1_Output = Register(CCMR1_Output_val).init(base_address + 0x18);

/// CCMR1_Input
const CCMR1_Input_val = packed struct {
/// CC1S [0:1]
/// Capture/Compare 1
CC1S: u2 = 0,
/// IC1PSC [2:3]
/// Input capture 1 prescaler
IC1PSC: u2 = 0,
/// IC1F [4:7]
/// Input capture 1 filter
IC1F: u4 = 0,
/// unused [8:31]
_unused8: u8 = 0,
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// capture/compare mode register 1 (input
pub const CCMR1_Input = Register(CCMR1_Input_val).init(base_address + 0x18);

/// CCER
const CCER_val = packed struct {
/// CC1E [0:0]
/// Capture/Compare 1 output
CC1E: u1 = 0,
/// CC1P [1:1]
/// Capture/Compare 1 output
CC1P: u1 = 0,
/// CC1NE [2:2]
/// Capture/Compare 1 complementary output
CC1NE: u1 = 0,
/// CC1NP [3:3]
/// Capture/Compare 1 output
CC1NP: u1 = 0,
/// unused [4:31]
_unused4: u4 = 0,
_unused8: u8 = 0,
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// capture/compare enable
pub const CCER = Register(CCER_val).init(base_address + 0x20);

/// CNT
const CNT_val = packed struct {
/// CNT [0:15]
/// counter value
CNT: u16 = 0,
/// unused [16:30]
_unused16: u8 = 0,
_unused24: u7 = 0,
/// UIFCPY [31:31]
/// UIF Copy
UIFCPY: u1 = 0,
};
/// counter
pub const CNT = Register(CNT_val).init(base_address + 0x24);

/// PSC
const PSC_val = packed struct {
/// PSC [0:15]
/// Prescaler value
PSC: u16 = 0,
/// unused [16:31]
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// prescaler
pub const PSC = Register(PSC_val).init(base_address + 0x28);

/// ARR
const ARR_val = packed struct {
/// ARR [0:15]
/// Auto-reload value
ARR: u16 = 0,
/// unused [16:31]
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// auto-reload register
pub const ARR = Register(ARR_val).init(base_address + 0x2c);

/// RCR
const RCR_val = packed struct {
/// REP [0:7]
/// Repetition counter value
REP: u8 = 0,
/// unused [8:31]
_unused8: u8 = 0,
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// repetition counter register
pub const RCR = Register(RCR_val).init(base_address + 0x30);

/// CCR1
const CCR1_val = packed struct {
/// CCR1 [0:15]
/// Capture/Compare 1 value
CCR1: u16 = 0,
/// unused [16:31]
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// capture/compare register 1
pub const CCR1 = Register(CCR1_val).init(base_address + 0x34);

/// BDTR
const BDTR_val = packed struct {
/// DTG [0:7]
/// Dead-time generator setup
DTG: u8 = 0,
/// LOCK [8:9]
/// Lock configuration
LOCK: u2 = 0,
/// OSSI [10:10]
/// Off-state selection for Idle
OSSI: u1 = 0,
/// OSSR [11:11]
/// Off-state selection for Run
OSSR: u1 = 0,
/// BKE [12:12]
/// Break enable
BKE: u1 = 0,
/// BKP [13:13]
/// Break polarity
BKP: u1 = 0,
/// AOE [14:14]
/// Automatic output enable
AOE: u1 = 0,
/// MOE [15:15]
/// Main output enable
MOE: u1 = 0,
/// BKF [16:19]
/// Break filter
BKF: u4 = 0,
/// unused [20:31]
_unused20: u4 = 0,
_unused24: u8 = 0,
};
/// break and dead-time register
pub const BDTR = Register(BDTR_val).init(base_address + 0x44);

/// DCR
const DCR_val = packed struct {
/// DBA [0:4]
/// DMA base address
DBA: u5 = 0,
/// unused [5:7]
_unused5: u3 = 0,
/// DBL [8:12]
/// DMA burst length
DBL: u5 = 0,
/// unused [13:31]
_unused13: u3 = 0,
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// DMA control register
pub const DCR = Register(DCR_val).init(base_address + 0x48);

/// DMAR
const DMAR_val = packed struct {
/// DMAB [0:15]
/// DMA register for burst
DMAB: u16 = 0,
/// unused [16:31]
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// DMA address for full transfer
pub const DMAR = Register(DMAR_val).init(base_address + 0x4c);
};

/// Universal synchronous asynchronous receiver
pub const USART1 = struct {

const base_address = 0x40013800;
/// CR1
const CR1_val = packed struct {
/// UE [0:0]
/// USART enable
UE: u1 = 0,
/// UESM [1:1]
/// USART enable in Stop mode
UESM: u1 = 0,
/// RE [2:2]
/// Receiver enable
RE: u1 = 0,
/// TE [3:3]
/// Transmitter enable
TE: u1 = 0,
/// IDLEIE [4:4]
/// IDLE interrupt enable
IDLEIE: u1 = 0,
/// RXNEIE [5:5]
/// RXNE interrupt enable
RXNEIE: u1 = 0,
/// TCIE [6:6]
/// Transmission complete interrupt
TCIE: u1 = 0,
/// TXEIE [7:7]
/// interrupt enable
TXEIE: u1 = 0,
/// PEIE [8:8]
/// PE interrupt enable
PEIE: u1 = 0,
/// PS [9:9]
/// Parity selection
PS: u1 = 0,
/// PCE [10:10]
/// Parity control enable
PCE: u1 = 0,
/// WAKE [11:11]
/// Receiver wakeup method
WAKE: u1 = 0,
/// M [12:12]
/// Word length
M: u1 = 0,
/// MME [13:13]
/// Mute mode enable
MME: u1 = 0,
/// CMIE [14:14]
/// Character match interrupt
CMIE: u1 = 0,
/// OVER8 [15:15]
/// Oversampling mode
OVER8: u1 = 0,
/// DEDT [16:20]
/// Driver Enable deassertion
DEDT: u5 = 0,
/// DEAT [21:25]
/// Driver Enable assertion
DEAT: u5 = 0,
/// RTOIE [26:26]
/// Receiver timeout interrupt
RTOIE: u1 = 0,
/// EOBIE [27:27]
/// End of Block interrupt
EOBIE: u1 = 0,
/// unused [28:31]
_unused28: u4 = 0,
};
/// Control register 1
pub const CR1 = Register(CR1_val).init(base_address + 0x0);

/// CR2
const CR2_val = packed struct {
/// unused [0:3]
_unused0: u4 = 0,
/// ADDM7 [4:4]
/// 7-bit Address Detection/4-bit Address
ADDM7: u1 = 0,
/// LBDL [5:5]
/// LIN break detection length
LBDL: u1 = 0,
/// LBDIE [6:6]
/// LIN break detection interrupt
LBDIE: u1 = 0,
/// unused [7:7]
_unused7: u1 = 0,
/// LBCL [8:8]
/// Last bit clock pulse
LBCL: u1 = 0,
/// CPHA [9:9]
/// Clock phase
CPHA: u1 = 0,
/// CPOL [10:10]
/// Clock polarity
CPOL: u1 = 0,
/// CLKEN [11:11]
/// Clock enable
CLKEN: u1 = 0,
/// STOP [12:13]
/// STOP bits
STOP: u2 = 0,
/// LINEN [14:14]
/// LIN mode enable
LINEN: u1 = 0,
/// SWAP [15:15]
/// Swap TX/RX pins
SWAP: u1 = 0,
/// RXINV [16:16]
/// RX pin active level
RXINV: u1 = 0,
/// TXINV [17:17]
/// TX pin active level
TXINV: u1 = 0,
/// DATAINV [18:18]
/// Binary data inversion
DATAINV: u1 = 0,
/// MSBFIRST [19:19]
/// Most significant bit first
MSBFIRST: u1 = 0,
/// ABREN [20:20]
/// Auto baud rate enable
ABREN: u1 = 0,
/// ABRMOD [21:22]
/// Auto baud rate mode
ABRMOD: u2 = 0,
/// RTOEN [23:23]
/// Receiver timeout enable
RTOEN: u1 = 0,
/// ADD0 [24:27]
/// Address of the USART node
ADD0: u4 = 0,
/// ADD4 [28:31]
/// Address of the USART node
ADD4: u4 = 0,
};
/// Control register 2
pub const CR2 = Register(CR2_val).init(base_address + 0x4);

/// CR3
const CR3_val = packed struct {
/// EIE [0:0]
/// Error interrupt enable
EIE: u1 = 0,
/// IREN [1:1]
/// IrDA mode enable
IREN: u1 = 0,
/// IRLP [2:2]
/// IrDA low-power
IRLP: u1 = 0,
/// HDSEL [3:3]
/// Half-duplex selection
HDSEL: u1 = 0,
/// NACK [4:4]
/// Smartcard NACK enable
NACK: u1 = 0,
/// SCEN [5:5]
/// Smartcard mode enable
SCEN: u1 = 0,
/// DMAR [6:6]
/// DMA enable receiver
DMAR: u1 = 0,
/// DMAT [7:7]
/// DMA enable transmitter
DMAT: u1 = 0,
/// RTSE [8:8]
/// RTS enable
RTSE: u1 = 0,
/// CTSE [9:9]
/// CTS enable
CTSE: u1 = 0,
/// CTSIE [10:10]
/// CTS interrupt enable
CTSIE: u1 = 0,
/// ONEBIT [11:11]
/// One sample bit method
ONEBIT: u1 = 0,
/// OVRDIS [12:12]
/// Overrun Disable
OVRDIS: u1 = 0,
/// DDRE [13:13]
/// DMA Disable on Reception
DDRE: u1 = 0,
/// DEM [14:14]
/// Driver enable mode
DEM: u1 = 0,
/// DEP [15:15]
/// Driver enable polarity
DEP: u1 = 0,
/// unused [16:16]
_unused16: u1 = 0,
/// SCARCNT [17:19]
/// Smartcard auto-retry count
SCARCNT: u3 = 0,
/// WUS [20:21]
/// Wakeup from Stop mode interrupt flag
WUS: u2 = 0,
/// WUFIE [22:22]
/// Wakeup from Stop mode interrupt
WUFIE: u1 = 0,
/// unused [23:31]
_unused23: u1 = 0,
_unused24: u8 = 0,
};
/// Control register 3
pub const CR3 = Register(CR3_val).init(base_address + 0x8);

/// BRR
const BRR_val = packed struct {
/// DIV_Fraction [0:3]
/// fraction of USARTDIV
DIV_Fraction: u4 = 0,
/// DIV_Mantissa [4:15]
/// mantissa of USARTDIV
DIV_Mantissa: u12 = 0,
/// unused [16:31]
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// Baud rate register
pub const BRR = Register(BRR_val).init(base_address + 0xc);

/// GTPR
const GTPR_val = packed struct {
/// PSC [0:7]
/// Prescaler value
PSC: u8 = 0,
/// GT [8:15]
/// Guard time value
GT: u8 = 0,
/// unused [16:31]
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// Guard time and prescaler
pub const GTPR = Register(GTPR_val).init(base_address + 0x10);

/// RTOR
const RTOR_val = packed struct {
/// RTO [0:23]
/// Receiver timeout value
RTO: u24 = 0,
/// BLEN [24:31]
/// Block Length
BLEN: u8 = 0,
};
/// Receiver timeout register
pub const RTOR = Register(RTOR_val).init(base_address + 0x14);

/// RQR
const RQR_val = packed struct {
/// ABRRQ [0:0]
/// Auto baud rate request
ABRRQ: u1 = 0,
/// SBKRQ [1:1]
/// Send break request
SBKRQ: u1 = 0,
/// MMRQ [2:2]
/// Mute mode request
MMRQ: u1 = 0,
/// RXFRQ [3:3]
/// Receive data flush request
RXFRQ: u1 = 0,
/// TXFRQ [4:4]
/// Transmit data flush
TXFRQ: u1 = 0,
/// unused [5:31]
_unused5: u3 = 0,
_unused8: u8 = 0,
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// Request register
pub const RQR = Register(RQR_val).init(base_address + 0x18);

/// ISR
const ISR_val = packed struct {
/// PE [0:0]
/// Parity error
PE: u1 = 0,
/// FE [1:1]
/// Framing error
FE: u1 = 0,
/// NF [2:2]
/// Noise detected flag
NF: u1 = 0,
/// ORE [3:3]
/// Overrun error
ORE: u1 = 0,
/// IDLE [4:4]
/// Idle line detected
IDLE: u1 = 0,
/// RXNE [5:5]
/// Read data register not
RXNE: u1 = 0,
/// TC [6:6]
/// Transmission complete
TC: u1 = 1,
/// TXE [7:7]
/// Transmit data register
TXE: u1 = 1,
/// LBDF [8:8]
/// LIN break detection flag
LBDF: u1 = 0,
/// CTSIF [9:9]
/// CTS interrupt flag
CTSIF: u1 = 0,
/// CTS [10:10]
/// CTS flag
CTS: u1 = 0,
/// RTOF [11:11]
/// Receiver timeout
RTOF: u1 = 0,
/// EOBF [12:12]
/// End of block flag
EOBF: u1 = 0,
/// unused [13:13]
_unused13: u1 = 0,
/// ABRE [14:14]
/// Auto baud rate error
ABRE: u1 = 0,
/// ABRF [15:15]
/// Auto baud rate flag
ABRF: u1 = 0,
/// BUSY [16:16]
/// Busy flag
BUSY: u1 = 0,
/// CMF [17:17]
/// character match flag
CMF: u1 = 0,
/// SBKF [18:18]
/// Send break flag
SBKF: u1 = 0,
/// RWU [19:19]
/// Receiver wakeup from Mute
RWU: u1 = 0,
/// WUF [20:20]
/// Wakeup from Stop mode flag
WUF: u1 = 0,
/// TEACK [21:21]
/// Transmit enable acknowledge
TEACK: u1 = 0,
/// REACK [22:22]
/// Receive enable acknowledge
REACK: u1 = 0,
/// unused [23:31]
_unused23: u1 = 0,
_unused24: u8 = 0,
};
/// Interrupt &amp; status
pub const ISR = Register(ISR_val).init(base_address + 0x1c);

/// ICR
const ICR_val = packed struct {
/// PECF [0:0]
/// Parity error clear flag
PECF: u1 = 0,
/// FECF [1:1]
/// Framing error clear flag
FECF: u1 = 0,
/// NCF [2:2]
/// Noise detected clear flag
NCF: u1 = 0,
/// ORECF [3:3]
/// Overrun error clear flag
ORECF: u1 = 0,
/// IDLECF [4:4]
/// Idle line detected clear
IDLECF: u1 = 0,
/// unused [5:5]
_unused5: u1 = 0,
/// TCCF [6:6]
/// Transmission complete clear
TCCF: u1 = 0,
/// unused [7:7]
_unused7: u1 = 0,
/// LBDCF [8:8]
/// LIN break detection clear
LBDCF: u1 = 0,
/// CTSCF [9:9]
/// CTS clear flag
CTSCF: u1 = 0,
/// unused [10:10]
_unused10: u1 = 0,
/// RTOCF [11:11]
/// Receiver timeout clear
RTOCF: u1 = 0,
/// EOBCF [12:12]
/// End of timeout clear flag
EOBCF: u1 = 0,
/// unused [13:16]
_unused13: u3 = 0,
_unused16: u1 = 0,
/// CMCF [17:17]
/// Character match clear flag
CMCF: u1 = 0,
/// unused [18:19]
_unused18: u2 = 0,
/// WUCF [20:20]
/// Wakeup from Stop mode clear
WUCF: u1 = 0,
/// unused [21:31]
_unused21: u3 = 0,
_unused24: u8 = 0,
};
/// Interrupt flag clear register
pub const ICR = Register(ICR_val).init(base_address + 0x20);

/// RDR
const RDR_val = packed struct {
/// RDR [0:8]
/// Receive data value
RDR: u9 = 0,
/// unused [9:31]
_unused9: u7 = 0,
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// Receive data register
pub const RDR = Register(RDR_val).init(base_address + 0x24);

/// TDR
const TDR_val = packed struct {
/// TDR [0:8]
/// Transmit data value
TDR: u9 = 0,
/// unused [9:31]
_unused9: u7 = 0,
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// Transmit data register
pub const TDR = Register(TDR_val).init(base_address + 0x28);
};

/// Universal synchronous asynchronous receiver
pub const USART2 = struct {

const base_address = 0x40004400;
/// CR1
const CR1_val = packed struct {
/// UE [0:0]
/// USART enable
UE: u1 = 0,
/// UESM [1:1]
/// USART enable in Stop mode
UESM: u1 = 0,
/// RE [2:2]
/// Receiver enable
RE: u1 = 0,
/// TE [3:3]
/// Transmitter enable
TE: u1 = 0,
/// IDLEIE [4:4]
/// IDLE interrupt enable
IDLEIE: u1 = 0,
/// RXNEIE [5:5]
/// RXNE interrupt enable
RXNEIE: u1 = 0,
/// TCIE [6:6]
/// Transmission complete interrupt
TCIE: u1 = 0,
/// TXEIE [7:7]
/// interrupt enable
TXEIE: u1 = 0,
/// PEIE [8:8]
/// PE interrupt enable
PEIE: u1 = 0,
/// PS [9:9]
/// Parity selection
PS: u1 = 0,
/// PCE [10:10]
/// Parity control enable
PCE: u1 = 0,
/// WAKE [11:11]
/// Receiver wakeup method
WAKE: u1 = 0,
/// M [12:12]
/// Word length
M: u1 = 0,
/// MME [13:13]
/// Mute mode enable
MME: u1 = 0,
/// CMIE [14:14]
/// Character match interrupt
CMIE: u1 = 0,
/// OVER8 [15:15]
/// Oversampling mode
OVER8: u1 = 0,
/// DEDT [16:20]
/// Driver Enable deassertion
DEDT: u5 = 0,
/// DEAT [21:25]
/// Driver Enable assertion
DEAT: u5 = 0,
/// RTOIE [26:26]
/// Receiver timeout interrupt
RTOIE: u1 = 0,
/// EOBIE [27:27]
/// End of Block interrupt
EOBIE: u1 = 0,
/// unused [28:31]
_unused28: u4 = 0,
};
/// Control register 1
pub const CR1 = Register(CR1_val).init(base_address + 0x0);

/// CR2
const CR2_val = packed struct {
/// unused [0:3]
_unused0: u4 = 0,
/// ADDM7 [4:4]
/// 7-bit Address Detection/4-bit Address
ADDM7: u1 = 0,
/// LBDL [5:5]
/// LIN break detection length
LBDL: u1 = 0,
/// LBDIE [6:6]
/// LIN break detection interrupt
LBDIE: u1 = 0,
/// unused [7:7]
_unused7: u1 = 0,
/// LBCL [8:8]
/// Last bit clock pulse
LBCL: u1 = 0,
/// CPHA [9:9]
/// Clock phase
CPHA: u1 = 0,
/// CPOL [10:10]
/// Clock polarity
CPOL: u1 = 0,
/// CLKEN [11:11]
/// Clock enable
CLKEN: u1 = 0,
/// STOP [12:13]
/// STOP bits
STOP: u2 = 0,
/// LINEN [14:14]
/// LIN mode enable
LINEN: u1 = 0,
/// SWAP [15:15]
/// Swap TX/RX pins
SWAP: u1 = 0,
/// RXINV [16:16]
/// RX pin active level
RXINV: u1 = 0,
/// TXINV [17:17]
/// TX pin active level
TXINV: u1 = 0,
/// DATAINV [18:18]
/// Binary data inversion
DATAINV: u1 = 0,
/// MSBFIRST [19:19]
/// Most significant bit first
MSBFIRST: u1 = 0,
/// ABREN [20:20]
/// Auto baud rate enable
ABREN: u1 = 0,
/// ABRMOD [21:22]
/// Auto baud rate mode
ABRMOD: u2 = 0,
/// RTOEN [23:23]
/// Receiver timeout enable
RTOEN: u1 = 0,
/// ADD0 [24:27]
/// Address of the USART node
ADD0: u4 = 0,
/// ADD4 [28:31]
/// Address of the USART node
ADD4: u4 = 0,
};
/// Control register 2
pub const CR2 = Register(CR2_val).init(base_address + 0x4);

/// CR3
const CR3_val = packed struct {
/// EIE [0:0]
/// Error interrupt enable
EIE: u1 = 0,
/// IREN [1:1]
/// IrDA mode enable
IREN: u1 = 0,
/// IRLP [2:2]
/// IrDA low-power
IRLP: u1 = 0,
/// HDSEL [3:3]
/// Half-duplex selection
HDSEL: u1 = 0,
/// NACK [4:4]
/// Smartcard NACK enable
NACK: u1 = 0,
/// SCEN [5:5]
/// Smartcard mode enable
SCEN: u1 = 0,
/// DMAR [6:6]
/// DMA enable receiver
DMAR: u1 = 0,
/// DMAT [7:7]
/// DMA enable transmitter
DMAT: u1 = 0,
/// RTSE [8:8]
/// RTS enable
RTSE: u1 = 0,
/// CTSE [9:9]
/// CTS enable
CTSE: u1 = 0,
/// CTSIE [10:10]
/// CTS interrupt enable
CTSIE: u1 = 0,
/// ONEBIT [11:11]
/// One sample bit method
ONEBIT: u1 = 0,
/// OVRDIS [12:12]
/// Overrun Disable
OVRDIS: u1 = 0,
/// DDRE [13:13]
/// DMA Disable on Reception
DDRE: u1 = 0,
/// DEM [14:14]
/// Driver enable mode
DEM: u1 = 0,
/// DEP [15:15]
/// Driver enable polarity
DEP: u1 = 0,
/// unused [16:16]
_unused16: u1 = 0,
/// SCARCNT [17:19]
/// Smartcard auto-retry count
SCARCNT: u3 = 0,
/// WUS [20:21]
/// Wakeup from Stop mode interrupt flag
WUS: u2 = 0,
/// WUFIE [22:22]
/// Wakeup from Stop mode interrupt
WUFIE: u1 = 0,
/// unused [23:31]
_unused23: u1 = 0,
_unused24: u8 = 0,
};
/// Control register 3
pub const CR3 = Register(CR3_val).init(base_address + 0x8);

/// BRR
const BRR_val = packed struct {
/// DIV_Fraction [0:3]
/// fraction of USARTDIV
DIV_Fraction: u4 = 0,
/// DIV_Mantissa [4:15]
/// mantissa of USARTDIV
DIV_Mantissa: u12 = 0,
/// unused [16:31]
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// Baud rate register
pub const BRR = Register(BRR_val).init(base_address + 0xc);

/// GTPR
const GTPR_val = packed struct {
/// PSC [0:7]
/// Prescaler value
PSC: u8 = 0,
/// GT [8:15]
/// Guard time value
GT: u8 = 0,
/// unused [16:31]
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// Guard time and prescaler
pub const GTPR = Register(GTPR_val).init(base_address + 0x10);

/// RTOR
const RTOR_val = packed struct {
/// RTO [0:23]
/// Receiver timeout value
RTO: u24 = 0,
/// BLEN [24:31]
/// Block Length
BLEN: u8 = 0,
};
/// Receiver timeout register
pub const RTOR = Register(RTOR_val).init(base_address + 0x14);

/// RQR
const RQR_val = packed struct {
/// ABRRQ [0:0]
/// Auto baud rate request
ABRRQ: u1 = 0,
/// SBKRQ [1:1]
/// Send break request
SBKRQ: u1 = 0,
/// MMRQ [2:2]
/// Mute mode request
MMRQ: u1 = 0,
/// RXFRQ [3:3]
/// Receive data flush request
RXFRQ: u1 = 0,
/// TXFRQ [4:4]
/// Transmit data flush
TXFRQ: u1 = 0,
/// unused [5:31]
_unused5: u3 = 0,
_unused8: u8 = 0,
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// Request register
pub const RQR = Register(RQR_val).init(base_address + 0x18);

/// ISR
const ISR_val = packed struct {
/// PE [0:0]
/// Parity error
PE: u1 = 0,
/// FE [1:1]
/// Framing error
FE: u1 = 0,
/// NF [2:2]
/// Noise detected flag
NF: u1 = 0,
/// ORE [3:3]
/// Overrun error
ORE: u1 = 0,
/// IDLE [4:4]
/// Idle line detected
IDLE: u1 = 0,
/// RXNE [5:5]
/// Read data register not
RXNE: u1 = 0,
/// TC [6:6]
/// Transmission complete
TC: u1 = 1,
/// TXE [7:7]
/// Transmit data register
TXE: u1 = 1,
/// LBDF [8:8]
/// LIN break detection flag
LBDF: u1 = 0,
/// CTSIF [9:9]
/// CTS interrupt flag
CTSIF: u1 = 0,
/// CTS [10:10]
/// CTS flag
CTS: u1 = 0,
/// RTOF [11:11]
/// Receiver timeout
RTOF: u1 = 0,
/// EOBF [12:12]
/// End of block flag
EOBF: u1 = 0,
/// unused [13:13]
_unused13: u1 = 0,
/// ABRE [14:14]
/// Auto baud rate error
ABRE: u1 = 0,
/// ABRF [15:15]
/// Auto baud rate flag
ABRF: u1 = 0,
/// BUSY [16:16]
/// Busy flag
BUSY: u1 = 0,
/// CMF [17:17]
/// character match flag
CMF: u1 = 0,
/// SBKF [18:18]
/// Send break flag
SBKF: u1 = 0,
/// RWU [19:19]
/// Receiver wakeup from Mute
RWU: u1 = 0,
/// WUF [20:20]
/// Wakeup from Stop mode flag
WUF: u1 = 0,
/// TEACK [21:21]
/// Transmit enable acknowledge
TEACK: u1 = 0,
/// REACK [22:22]
/// Receive enable acknowledge
REACK: u1 = 0,
/// unused [23:31]
_unused23: u1 = 0,
_unused24: u8 = 0,
};
/// Interrupt &amp; status
pub const ISR = Register(ISR_val).init(base_address + 0x1c);

/// ICR
const ICR_val = packed struct {
/// PECF [0:0]
/// Parity error clear flag
PECF: u1 = 0,
/// FECF [1:1]
/// Framing error clear flag
FECF: u1 = 0,
/// NCF [2:2]
/// Noise detected clear flag
NCF: u1 = 0,
/// ORECF [3:3]
/// Overrun error clear flag
ORECF: u1 = 0,
/// IDLECF [4:4]
/// Idle line detected clear
IDLECF: u1 = 0,
/// unused [5:5]
_unused5: u1 = 0,
/// TCCF [6:6]
/// Transmission complete clear
TCCF: u1 = 0,
/// unused [7:7]
_unused7: u1 = 0,
/// LBDCF [8:8]
/// LIN break detection clear
LBDCF: u1 = 0,
/// CTSCF [9:9]
/// CTS clear flag
CTSCF: u1 = 0,
/// unused [10:10]
_unused10: u1 = 0,
/// RTOCF [11:11]
/// Receiver timeout clear
RTOCF: u1 = 0,
/// EOBCF [12:12]
/// End of timeout clear flag
EOBCF: u1 = 0,
/// unused [13:16]
_unused13: u3 = 0,
_unused16: u1 = 0,
/// CMCF [17:17]
/// Character match clear flag
CMCF: u1 = 0,
/// unused [18:19]
_unused18: u2 = 0,
/// WUCF [20:20]
/// Wakeup from Stop mode clear
WUCF: u1 = 0,
/// unused [21:31]
_unused21: u3 = 0,
_unused24: u8 = 0,
};
/// Interrupt flag clear register
pub const ICR = Register(ICR_val).init(base_address + 0x20);

/// RDR
const RDR_val = packed struct {
/// RDR [0:8]
/// Receive data value
RDR: u9 = 0,
/// unused [9:31]
_unused9: u7 = 0,
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// Receive data register
pub const RDR = Register(RDR_val).init(base_address + 0x24);

/// TDR
const TDR_val = packed struct {
/// TDR [0:8]
/// Transmit data value
TDR: u9 = 0,
/// unused [9:31]
_unused9: u7 = 0,
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// Transmit data register
pub const TDR = Register(TDR_val).init(base_address + 0x28);
};

/// Universal synchronous asynchronous receiver
pub const USART3 = struct {

const base_address = 0x40004800;
/// CR1
const CR1_val = packed struct {
/// UE [0:0]
/// USART enable
UE: u1 = 0,
/// UESM [1:1]
/// USART enable in Stop mode
UESM: u1 = 0,
/// RE [2:2]
/// Receiver enable
RE: u1 = 0,
/// TE [3:3]
/// Transmitter enable
TE: u1 = 0,
/// IDLEIE [4:4]
/// IDLE interrupt enable
IDLEIE: u1 = 0,
/// RXNEIE [5:5]
/// RXNE interrupt enable
RXNEIE: u1 = 0,
/// TCIE [6:6]
/// Transmission complete interrupt
TCIE: u1 = 0,
/// TXEIE [7:7]
/// interrupt enable
TXEIE: u1 = 0,
/// PEIE [8:8]
/// PE interrupt enable
PEIE: u1 = 0,
/// PS [9:9]
/// Parity selection
PS: u1 = 0,
/// PCE [10:10]
/// Parity control enable
PCE: u1 = 0,
/// WAKE [11:11]
/// Receiver wakeup method
WAKE: u1 = 0,
/// M [12:12]
/// Word length
M: u1 = 0,
/// MME [13:13]
/// Mute mode enable
MME: u1 = 0,
/// CMIE [14:14]
/// Character match interrupt
CMIE: u1 = 0,
/// OVER8 [15:15]
/// Oversampling mode
OVER8: u1 = 0,
/// DEDT [16:20]
/// Driver Enable deassertion
DEDT: u5 = 0,
/// DEAT [21:25]
/// Driver Enable assertion
DEAT: u5 = 0,
/// RTOIE [26:26]
/// Receiver timeout interrupt
RTOIE: u1 = 0,
/// EOBIE [27:27]
/// End of Block interrupt
EOBIE: u1 = 0,
/// unused [28:31]
_unused28: u4 = 0,
};
/// Control register 1
pub const CR1 = Register(CR1_val).init(base_address + 0x0);

/// CR2
const CR2_val = packed struct {
/// unused [0:3]
_unused0: u4 = 0,
/// ADDM7 [4:4]
/// 7-bit Address Detection/4-bit Address
ADDM7: u1 = 0,
/// LBDL [5:5]
/// LIN break detection length
LBDL: u1 = 0,
/// LBDIE [6:6]
/// LIN break detection interrupt
LBDIE: u1 = 0,
/// unused [7:7]
_unused7: u1 = 0,
/// LBCL [8:8]
/// Last bit clock pulse
LBCL: u1 = 0,
/// CPHA [9:9]
/// Clock phase
CPHA: u1 = 0,
/// CPOL [10:10]
/// Clock polarity
CPOL: u1 = 0,
/// CLKEN [11:11]
/// Clock enable
CLKEN: u1 = 0,
/// STOP [12:13]
/// STOP bits
STOP: u2 = 0,
/// LINEN [14:14]
/// LIN mode enable
LINEN: u1 = 0,
/// SWAP [15:15]
/// Swap TX/RX pins
SWAP: u1 = 0,
/// RXINV [16:16]
/// RX pin active level
RXINV: u1 = 0,
/// TXINV [17:17]
/// TX pin active level
TXINV: u1 = 0,
/// DATAINV [18:18]
/// Binary data inversion
DATAINV: u1 = 0,
/// MSBFIRST [19:19]
/// Most significant bit first
MSBFIRST: u1 = 0,
/// ABREN [20:20]
/// Auto baud rate enable
ABREN: u1 = 0,
/// ABRMOD [21:22]
/// Auto baud rate mode
ABRMOD: u2 = 0,
/// RTOEN [23:23]
/// Receiver timeout enable
RTOEN: u1 = 0,
/// ADD0 [24:27]
/// Address of the USART node
ADD0: u4 = 0,
/// ADD4 [28:31]
/// Address of the USART node
ADD4: u4 = 0,
};
/// Control register 2
pub const CR2 = Register(CR2_val).init(base_address + 0x4);

/// CR3
const CR3_val = packed struct {
/// EIE [0:0]
/// Error interrupt enable
EIE: u1 = 0,
/// IREN [1:1]
/// IrDA mode enable
IREN: u1 = 0,
/// IRLP [2:2]
/// IrDA low-power
IRLP: u1 = 0,
/// HDSEL [3:3]
/// Half-duplex selection
HDSEL: u1 = 0,
/// NACK [4:4]
/// Smartcard NACK enable
NACK: u1 = 0,
/// SCEN [5:5]
/// Smartcard mode enable
SCEN: u1 = 0,
/// DMAR [6:6]
/// DMA enable receiver
DMAR: u1 = 0,
/// DMAT [7:7]
/// DMA enable transmitter
DMAT: u1 = 0,
/// RTSE [8:8]
/// RTS enable
RTSE: u1 = 0,
/// CTSE [9:9]
/// CTS enable
CTSE: u1 = 0,
/// CTSIE [10:10]
/// CTS interrupt enable
CTSIE: u1 = 0,
/// ONEBIT [11:11]
/// One sample bit method
ONEBIT: u1 = 0,
/// OVRDIS [12:12]
/// Overrun Disable
OVRDIS: u1 = 0,
/// DDRE [13:13]
/// DMA Disable on Reception
DDRE: u1 = 0,
/// DEM [14:14]
/// Driver enable mode
DEM: u1 = 0,
/// DEP [15:15]
/// Driver enable polarity
DEP: u1 = 0,
/// unused [16:16]
_unused16: u1 = 0,
/// SCARCNT [17:19]
/// Smartcard auto-retry count
SCARCNT: u3 = 0,
/// WUS [20:21]
/// Wakeup from Stop mode interrupt flag
WUS: u2 = 0,
/// WUFIE [22:22]
/// Wakeup from Stop mode interrupt
WUFIE: u1 = 0,
/// unused [23:31]
_unused23: u1 = 0,
_unused24: u8 = 0,
};
/// Control register 3
pub const CR3 = Register(CR3_val).init(base_address + 0x8);

/// BRR
const BRR_val = packed struct {
/// DIV_Fraction [0:3]
/// fraction of USARTDIV
DIV_Fraction: u4 = 0,
/// DIV_Mantissa [4:15]
/// mantissa of USARTDIV
DIV_Mantissa: u12 = 0,
/// unused [16:31]
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// Baud rate register
pub const BRR = Register(BRR_val).init(base_address + 0xc);

/// GTPR
const GTPR_val = packed struct {
/// PSC [0:7]
/// Prescaler value
PSC: u8 = 0,
/// GT [8:15]
/// Guard time value
GT: u8 = 0,
/// unused [16:31]
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// Guard time and prescaler
pub const GTPR = Register(GTPR_val).init(base_address + 0x10);

/// RTOR
const RTOR_val = packed struct {
/// RTO [0:23]
/// Receiver timeout value
RTO: u24 = 0,
/// BLEN [24:31]
/// Block Length
BLEN: u8 = 0,
};
/// Receiver timeout register
pub const RTOR = Register(RTOR_val).init(base_address + 0x14);

/// RQR
const RQR_val = packed struct {
/// ABRRQ [0:0]
/// Auto baud rate request
ABRRQ: u1 = 0,
/// SBKRQ [1:1]
/// Send break request
SBKRQ: u1 = 0,
/// MMRQ [2:2]
/// Mute mode request
MMRQ: u1 = 0,
/// RXFRQ [3:3]
/// Receive data flush request
RXFRQ: u1 = 0,
/// TXFRQ [4:4]
/// Transmit data flush
TXFRQ: u1 = 0,
/// unused [5:31]
_unused5: u3 = 0,
_unused8: u8 = 0,
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// Request register
pub const RQR = Register(RQR_val).init(base_address + 0x18);

/// ISR
const ISR_val = packed struct {
/// PE [0:0]
/// Parity error
PE: u1 = 0,
/// FE [1:1]
/// Framing error
FE: u1 = 0,
/// NF [2:2]
/// Noise detected flag
NF: u1 = 0,
/// ORE [3:3]
/// Overrun error
ORE: u1 = 0,
/// IDLE [4:4]
/// Idle line detected
IDLE: u1 = 0,
/// RXNE [5:5]
/// Read data register not
RXNE: u1 = 0,
/// TC [6:6]
/// Transmission complete
TC: u1 = 1,
/// TXE [7:7]
/// Transmit data register
TXE: u1 = 1,
/// LBDF [8:8]
/// LIN break detection flag
LBDF: u1 = 0,
/// CTSIF [9:9]
/// CTS interrupt flag
CTSIF: u1 = 0,
/// CTS [10:10]
/// CTS flag
CTS: u1 = 0,
/// RTOF [11:11]
/// Receiver timeout
RTOF: u1 = 0,
/// EOBF [12:12]
/// End of block flag
EOBF: u1 = 0,
/// unused [13:13]
_unused13: u1 = 0,
/// ABRE [14:14]
/// Auto baud rate error
ABRE: u1 = 0,
/// ABRF [15:15]
/// Auto baud rate flag
ABRF: u1 = 0,
/// BUSY [16:16]
/// Busy flag
BUSY: u1 = 0,
/// CMF [17:17]
/// character match flag
CMF: u1 = 0,
/// SBKF [18:18]
/// Send break flag
SBKF: u1 = 0,
/// RWU [19:19]
/// Receiver wakeup from Mute
RWU: u1 = 0,
/// WUF [20:20]
/// Wakeup from Stop mode flag
WUF: u1 = 0,
/// TEACK [21:21]
/// Transmit enable acknowledge
TEACK: u1 = 0,
/// REACK [22:22]
/// Receive enable acknowledge
REACK: u1 = 0,
/// unused [23:31]
_unused23: u1 = 0,
_unused24: u8 = 0,
};
/// Interrupt &amp; status
pub const ISR = Register(ISR_val).init(base_address + 0x1c);

/// ICR
const ICR_val = packed struct {
/// PECF [0:0]
/// Parity error clear flag
PECF: u1 = 0,
/// FECF [1:1]
/// Framing error clear flag
FECF: u1 = 0,
/// NCF [2:2]
/// Noise detected clear flag
NCF: u1 = 0,
/// ORECF [3:3]
/// Overrun error clear flag
ORECF: u1 = 0,
/// IDLECF [4:4]
/// Idle line detected clear
IDLECF: u1 = 0,
/// unused [5:5]
_unused5: u1 = 0,
/// TCCF [6:6]
/// Transmission complete clear
TCCF: u1 = 0,
/// unused [7:7]
_unused7: u1 = 0,
/// LBDCF [8:8]
/// LIN break detection clear
LBDCF: u1 = 0,
/// CTSCF [9:9]
/// CTS clear flag
CTSCF: u1 = 0,
/// unused [10:10]
_unused10: u1 = 0,
/// RTOCF [11:11]
/// Receiver timeout clear
RTOCF: u1 = 0,
/// EOBCF [12:12]
/// End of timeout clear flag
EOBCF: u1 = 0,
/// unused [13:16]
_unused13: u3 = 0,
_unused16: u1 = 0,
/// CMCF [17:17]
/// Character match clear flag
CMCF: u1 = 0,
/// unused [18:19]
_unused18: u2 = 0,
/// WUCF [20:20]
/// Wakeup from Stop mode clear
WUCF: u1 = 0,
/// unused [21:31]
_unused21: u3 = 0,
_unused24: u8 = 0,
};
/// Interrupt flag clear register
pub const ICR = Register(ICR_val).init(base_address + 0x20);

/// RDR
const RDR_val = packed struct {
/// RDR [0:8]
/// Receive data value
RDR: u9 = 0,
/// unused [9:31]
_unused9: u7 = 0,
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// Receive data register
pub const RDR = Register(RDR_val).init(base_address + 0x24);

/// TDR
const TDR_val = packed struct {
/// TDR [0:8]
/// Transmit data value
TDR: u9 = 0,
/// unused [9:31]
_unused9: u7 = 0,
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// Transmit data register
pub const TDR = Register(TDR_val).init(base_address + 0x28);
};

/// Universal synchronous asynchronous receiver
pub const UART4 = struct {

const base_address = 0x40004c00;
/// CR1
const CR1_val = packed struct {
/// UE [0:0]
/// USART enable
UE: u1 = 0,
/// UESM [1:1]
/// USART enable in Stop mode
UESM: u1 = 0,
/// RE [2:2]
/// Receiver enable
RE: u1 = 0,
/// TE [3:3]
/// Transmitter enable
TE: u1 = 0,
/// IDLEIE [4:4]
/// IDLE interrupt enable
IDLEIE: u1 = 0,
/// RXNEIE [5:5]
/// RXNE interrupt enable
RXNEIE: u1 = 0,
/// TCIE [6:6]
/// Transmission complete interrupt
TCIE: u1 = 0,
/// TXEIE [7:7]
/// interrupt enable
TXEIE: u1 = 0,
/// PEIE [8:8]
/// PE interrupt enable
PEIE: u1 = 0,
/// PS [9:9]
/// Parity selection
PS: u1 = 0,
/// PCE [10:10]
/// Parity control enable
PCE: u1 = 0,
/// WAKE [11:11]
/// Receiver wakeup method
WAKE: u1 = 0,
/// M [12:12]
/// Word length
M: u1 = 0,
/// MME [13:13]
/// Mute mode enable
MME: u1 = 0,
/// CMIE [14:14]
/// Character match interrupt
CMIE: u1 = 0,
/// OVER8 [15:15]
/// Oversampling mode
OVER8: u1 = 0,
/// DEDT [16:20]
/// Driver Enable deassertion
DEDT: u5 = 0,
/// DEAT [21:25]
/// Driver Enable assertion
DEAT: u5 = 0,
/// RTOIE [26:26]
/// Receiver timeout interrupt
RTOIE: u1 = 0,
/// EOBIE [27:27]
/// End of Block interrupt
EOBIE: u1 = 0,
/// unused [28:31]
_unused28: u4 = 0,
};
/// Control register 1
pub const CR1 = Register(CR1_val).init(base_address + 0x0);

/// CR2
const CR2_val = packed struct {
/// unused [0:3]
_unused0: u4 = 0,
/// ADDM7 [4:4]
/// 7-bit Address Detection/4-bit Address
ADDM7: u1 = 0,
/// LBDL [5:5]
/// LIN break detection length
LBDL: u1 = 0,
/// LBDIE [6:6]
/// LIN break detection interrupt
LBDIE: u1 = 0,
/// unused [7:7]
_unused7: u1 = 0,
/// LBCL [8:8]
/// Last bit clock pulse
LBCL: u1 = 0,
/// CPHA [9:9]
/// Clock phase
CPHA: u1 = 0,
/// CPOL [10:10]
/// Clock polarity
CPOL: u1 = 0,
/// CLKEN [11:11]
/// Clock enable
CLKEN: u1 = 0,
/// STOP [12:13]
/// STOP bits
STOP: u2 = 0,
/// LINEN [14:14]
/// LIN mode enable
LINEN: u1 = 0,
/// SWAP [15:15]
/// Swap TX/RX pins
SWAP: u1 = 0,
/// RXINV [16:16]
/// RX pin active level
RXINV: u1 = 0,
/// TXINV [17:17]
/// TX pin active level
TXINV: u1 = 0,
/// DATAINV [18:18]
/// Binary data inversion
DATAINV: u1 = 0,
/// MSBFIRST [19:19]
/// Most significant bit first
MSBFIRST: u1 = 0,
/// ABREN [20:20]
/// Auto baud rate enable
ABREN: u1 = 0,
/// ABRMOD [21:22]
/// Auto baud rate mode
ABRMOD: u2 = 0,
/// RTOEN [23:23]
/// Receiver timeout enable
RTOEN: u1 = 0,
/// ADD0 [24:27]
/// Address of the USART node
ADD0: u4 = 0,
/// ADD4 [28:31]
/// Address of the USART node
ADD4: u4 = 0,
};
/// Control register 2
pub const CR2 = Register(CR2_val).init(base_address + 0x4);

/// CR3
const CR3_val = packed struct {
/// EIE [0:0]
/// Error interrupt enable
EIE: u1 = 0,
/// IREN [1:1]
/// IrDA mode enable
IREN: u1 = 0,
/// IRLP [2:2]
/// IrDA low-power
IRLP: u1 = 0,
/// HDSEL [3:3]
/// Half-duplex selection
HDSEL: u1 = 0,
/// NACK [4:4]
/// Smartcard NACK enable
NACK: u1 = 0,
/// SCEN [5:5]
/// Smartcard mode enable
SCEN: u1 = 0,
/// DMAR [6:6]
/// DMA enable receiver
DMAR: u1 = 0,
/// DMAT [7:7]
/// DMA enable transmitter
DMAT: u1 = 0,
/// RTSE [8:8]
/// RTS enable
RTSE: u1 = 0,
/// CTSE [9:9]
/// CTS enable
CTSE: u1 = 0,
/// CTSIE [10:10]
/// CTS interrupt enable
CTSIE: u1 = 0,
/// ONEBIT [11:11]
/// One sample bit method
ONEBIT: u1 = 0,
/// OVRDIS [12:12]
/// Overrun Disable
OVRDIS: u1 = 0,
/// DDRE [13:13]
/// DMA Disable on Reception
DDRE: u1 = 0,
/// DEM [14:14]
/// Driver enable mode
DEM: u1 = 0,
/// DEP [15:15]
/// Driver enable polarity
DEP: u1 = 0,
/// unused [16:16]
_unused16: u1 = 0,
/// SCARCNT [17:19]
/// Smartcard auto-retry count
SCARCNT: u3 = 0,
/// WUS [20:21]
/// Wakeup from Stop mode interrupt flag
WUS: u2 = 0,
/// WUFIE [22:22]
/// Wakeup from Stop mode interrupt
WUFIE: u1 = 0,
/// unused [23:31]
_unused23: u1 = 0,
_unused24: u8 = 0,
};
/// Control register 3
pub const CR3 = Register(CR3_val).init(base_address + 0x8);

/// BRR
const BRR_val = packed struct {
/// DIV_Fraction [0:3]
/// fraction of USARTDIV
DIV_Fraction: u4 = 0,
/// DIV_Mantissa [4:15]
/// mantissa of USARTDIV
DIV_Mantissa: u12 = 0,
/// unused [16:31]
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// Baud rate register
pub const BRR = Register(BRR_val).init(base_address + 0xc);

/// GTPR
const GTPR_val = packed struct {
/// PSC [0:7]
/// Prescaler value
PSC: u8 = 0,
/// GT [8:15]
/// Guard time value
GT: u8 = 0,
/// unused [16:31]
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// Guard time and prescaler
pub const GTPR = Register(GTPR_val).init(base_address + 0x10);

/// RTOR
const RTOR_val = packed struct {
/// RTO [0:23]
/// Receiver timeout value
RTO: u24 = 0,
/// BLEN [24:31]
/// Block Length
BLEN: u8 = 0,
};
/// Receiver timeout register
pub const RTOR = Register(RTOR_val).init(base_address + 0x14);

/// RQR
const RQR_val = packed struct {
/// ABRRQ [0:0]
/// Auto baud rate request
ABRRQ: u1 = 0,
/// SBKRQ [1:1]
/// Send break request
SBKRQ: u1 = 0,
/// MMRQ [2:2]
/// Mute mode request
MMRQ: u1 = 0,
/// RXFRQ [3:3]
/// Receive data flush request
RXFRQ: u1 = 0,
/// TXFRQ [4:4]
/// Transmit data flush
TXFRQ: u1 = 0,
/// unused [5:31]
_unused5: u3 = 0,
_unused8: u8 = 0,
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// Request register
pub const RQR = Register(RQR_val).init(base_address + 0x18);

/// ISR
const ISR_val = packed struct {
/// PE [0:0]
/// Parity error
PE: u1 = 0,
/// FE [1:1]
/// Framing error
FE: u1 = 0,
/// NF [2:2]
/// Noise detected flag
NF: u1 = 0,
/// ORE [3:3]
/// Overrun error
ORE: u1 = 0,
/// IDLE [4:4]
/// Idle line detected
IDLE: u1 = 0,
/// RXNE [5:5]
/// Read data register not
RXNE: u1 = 0,
/// TC [6:6]
/// Transmission complete
TC: u1 = 1,
/// TXE [7:7]
/// Transmit data register
TXE: u1 = 1,
/// LBDF [8:8]
/// LIN break detection flag
LBDF: u1 = 0,
/// CTSIF [9:9]
/// CTS interrupt flag
CTSIF: u1 = 0,
/// CTS [10:10]
/// CTS flag
CTS: u1 = 0,
/// RTOF [11:11]
/// Receiver timeout
RTOF: u1 = 0,
/// EOBF [12:12]
/// End of block flag
EOBF: u1 = 0,
/// unused [13:13]
_unused13: u1 = 0,
/// ABRE [14:14]
/// Auto baud rate error
ABRE: u1 = 0,
/// ABRF [15:15]
/// Auto baud rate flag
ABRF: u1 = 0,
/// BUSY [16:16]
/// Busy flag
BUSY: u1 = 0,
/// CMF [17:17]
/// character match flag
CMF: u1 = 0,
/// SBKF [18:18]
/// Send break flag
SBKF: u1 = 0,
/// RWU [19:19]
/// Receiver wakeup from Mute
RWU: u1 = 0,
/// WUF [20:20]
/// Wakeup from Stop mode flag
WUF: u1 = 0,
/// TEACK [21:21]
/// Transmit enable acknowledge
TEACK: u1 = 0,
/// REACK [22:22]
/// Receive enable acknowledge
REACK: u1 = 0,
/// unused [23:31]
_unused23: u1 = 0,
_unused24: u8 = 0,
};
/// Interrupt &amp; status
pub const ISR = Register(ISR_val).init(base_address + 0x1c);

/// ICR
const ICR_val = packed struct {
/// PECF [0:0]
/// Parity error clear flag
PECF: u1 = 0,
/// FECF [1:1]
/// Framing error clear flag
FECF: u1 = 0,
/// NCF [2:2]
/// Noise detected clear flag
NCF: u1 = 0,
/// ORECF [3:3]
/// Overrun error clear flag
ORECF: u1 = 0,
/// IDLECF [4:4]
/// Idle line detected clear
IDLECF: u1 = 0,
/// unused [5:5]
_unused5: u1 = 0,
/// TCCF [6:6]
/// Transmission complete clear
TCCF: u1 = 0,
/// unused [7:7]
_unused7: u1 = 0,
/// LBDCF [8:8]
/// LIN break detection clear
LBDCF: u1 = 0,
/// CTSCF [9:9]
/// CTS clear flag
CTSCF: u1 = 0,
/// unused [10:10]
_unused10: u1 = 0,
/// RTOCF [11:11]
/// Receiver timeout clear
RTOCF: u1 = 0,
/// EOBCF [12:12]
/// End of timeout clear flag
EOBCF: u1 = 0,
/// unused [13:16]
_unused13: u3 = 0,
_unused16: u1 = 0,
/// CMCF [17:17]
/// Character match clear flag
CMCF: u1 = 0,
/// unused [18:19]
_unused18: u2 = 0,
/// WUCF [20:20]
/// Wakeup from Stop mode clear
WUCF: u1 = 0,
/// unused [21:31]
_unused21: u3 = 0,
_unused24: u8 = 0,
};
/// Interrupt flag clear register
pub const ICR = Register(ICR_val).init(base_address + 0x20);

/// RDR
const RDR_val = packed struct {
/// RDR [0:8]
/// Receive data value
RDR: u9 = 0,
/// unused [9:31]
_unused9: u7 = 0,
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// Receive data register
pub const RDR = Register(RDR_val).init(base_address + 0x24);

/// TDR
const TDR_val = packed struct {
/// TDR [0:8]
/// Transmit data value
TDR: u9 = 0,
/// unused [9:31]
_unused9: u7 = 0,
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// Transmit data register
pub const TDR = Register(TDR_val).init(base_address + 0x28);
};

/// Universal synchronous asynchronous receiver
pub const UART5 = struct {

const base_address = 0x40005000;
/// CR1
const CR1_val = packed struct {
/// UE [0:0]
/// USART enable
UE: u1 = 0,
/// UESM [1:1]
/// USART enable in Stop mode
UESM: u1 = 0,
/// RE [2:2]
/// Receiver enable
RE: u1 = 0,
/// TE [3:3]
/// Transmitter enable
TE: u1 = 0,
/// IDLEIE [4:4]
/// IDLE interrupt enable
IDLEIE: u1 = 0,
/// RXNEIE [5:5]
/// RXNE interrupt enable
RXNEIE: u1 = 0,
/// TCIE [6:6]
/// Transmission complete interrupt
TCIE: u1 = 0,
/// TXEIE [7:7]
/// interrupt enable
TXEIE: u1 = 0,
/// PEIE [8:8]
/// PE interrupt enable
PEIE: u1 = 0,
/// PS [9:9]
/// Parity selection
PS: u1 = 0,
/// PCE [10:10]
/// Parity control enable
PCE: u1 = 0,
/// WAKE [11:11]
/// Receiver wakeup method
WAKE: u1 = 0,
/// M [12:12]
/// Word length
M: u1 = 0,
/// MME [13:13]
/// Mute mode enable
MME: u1 = 0,
/// CMIE [14:14]
/// Character match interrupt
CMIE: u1 = 0,
/// OVER8 [15:15]
/// Oversampling mode
OVER8: u1 = 0,
/// DEDT [16:20]
/// Driver Enable deassertion
DEDT: u5 = 0,
/// DEAT [21:25]
/// Driver Enable assertion
DEAT: u5 = 0,
/// RTOIE [26:26]
/// Receiver timeout interrupt
RTOIE: u1 = 0,
/// EOBIE [27:27]
/// End of Block interrupt
EOBIE: u1 = 0,
/// unused [28:31]
_unused28: u4 = 0,
};
/// Control register 1
pub const CR1 = Register(CR1_val).init(base_address + 0x0);

/// CR2
const CR2_val = packed struct {
/// unused [0:3]
_unused0: u4 = 0,
/// ADDM7 [4:4]
/// 7-bit Address Detection/4-bit Address
ADDM7: u1 = 0,
/// LBDL [5:5]
/// LIN break detection length
LBDL: u1 = 0,
/// LBDIE [6:6]
/// LIN break detection interrupt
LBDIE: u1 = 0,
/// unused [7:7]
_unused7: u1 = 0,
/// LBCL [8:8]
/// Last bit clock pulse
LBCL: u1 = 0,
/// CPHA [9:9]
/// Clock phase
CPHA: u1 = 0,
/// CPOL [10:10]
/// Clock polarity
CPOL: u1 = 0,
/// CLKEN [11:11]
/// Clock enable
CLKEN: u1 = 0,
/// STOP [12:13]
/// STOP bits
STOP: u2 = 0,
/// LINEN [14:14]
/// LIN mode enable
LINEN: u1 = 0,
/// SWAP [15:15]
/// Swap TX/RX pins
SWAP: u1 = 0,
/// RXINV [16:16]
/// RX pin active level
RXINV: u1 = 0,
/// TXINV [17:17]
/// TX pin active level
TXINV: u1 = 0,
/// DATAINV [18:18]
/// Binary data inversion
DATAINV: u1 = 0,
/// MSBFIRST [19:19]
/// Most significant bit first
MSBFIRST: u1 = 0,
/// ABREN [20:20]
/// Auto baud rate enable
ABREN: u1 = 0,
/// ABRMOD [21:22]
/// Auto baud rate mode
ABRMOD: u2 = 0,
/// RTOEN [23:23]
/// Receiver timeout enable
RTOEN: u1 = 0,
/// ADD0 [24:27]
/// Address of the USART node
ADD0: u4 = 0,
/// ADD4 [28:31]
/// Address of the USART node
ADD4: u4 = 0,
};
/// Control register 2
pub const CR2 = Register(CR2_val).init(base_address + 0x4);

/// CR3
const CR3_val = packed struct {
/// EIE [0:0]
/// Error interrupt enable
EIE: u1 = 0,
/// IREN [1:1]
/// IrDA mode enable
IREN: u1 = 0,
/// IRLP [2:2]
/// IrDA low-power
IRLP: u1 = 0,
/// HDSEL [3:3]
/// Half-duplex selection
HDSEL: u1 = 0,
/// NACK [4:4]
/// Smartcard NACK enable
NACK: u1 = 0,
/// SCEN [5:5]
/// Smartcard mode enable
SCEN: u1 = 0,
/// DMAR [6:6]
/// DMA enable receiver
DMAR: u1 = 0,
/// DMAT [7:7]
/// DMA enable transmitter
DMAT: u1 = 0,
/// RTSE [8:8]
/// RTS enable
RTSE: u1 = 0,
/// CTSE [9:9]
/// CTS enable
CTSE: u1 = 0,
/// CTSIE [10:10]
/// CTS interrupt enable
CTSIE: u1 = 0,
/// ONEBIT [11:11]
/// One sample bit method
ONEBIT: u1 = 0,
/// OVRDIS [12:12]
/// Overrun Disable
OVRDIS: u1 = 0,
/// DDRE [13:13]
/// DMA Disable on Reception
DDRE: u1 = 0,
/// DEM [14:14]
/// Driver enable mode
DEM: u1 = 0,
/// DEP [15:15]
/// Driver enable polarity
DEP: u1 = 0,
/// unused [16:16]
_unused16: u1 = 0,
/// SCARCNT [17:19]
/// Smartcard auto-retry count
SCARCNT: u3 = 0,
/// WUS [20:21]
/// Wakeup from Stop mode interrupt flag
WUS: u2 = 0,
/// WUFIE [22:22]
/// Wakeup from Stop mode interrupt
WUFIE: u1 = 0,
/// unused [23:31]
_unused23: u1 = 0,
_unused24: u8 = 0,
};
/// Control register 3
pub const CR3 = Register(CR3_val).init(base_address + 0x8);

/// BRR
const BRR_val = packed struct {
/// DIV_Fraction [0:3]
/// fraction of USARTDIV
DIV_Fraction: u4 = 0,
/// DIV_Mantissa [4:15]
/// mantissa of USARTDIV
DIV_Mantissa: u12 = 0,
/// unused [16:31]
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// Baud rate register
pub const BRR = Register(BRR_val).init(base_address + 0xc);

/// GTPR
const GTPR_val = packed struct {
/// PSC [0:7]
/// Prescaler value
PSC: u8 = 0,
/// GT [8:15]
/// Guard time value
GT: u8 = 0,
/// unused [16:31]
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// Guard time and prescaler
pub const GTPR = Register(GTPR_val).init(base_address + 0x10);

/// RTOR
const RTOR_val = packed struct {
/// RTO [0:23]
/// Receiver timeout value
RTO: u24 = 0,
/// BLEN [24:31]
/// Block Length
BLEN: u8 = 0,
};
/// Receiver timeout register
pub const RTOR = Register(RTOR_val).init(base_address + 0x14);

/// RQR
const RQR_val = packed struct {
/// ABRRQ [0:0]
/// Auto baud rate request
ABRRQ: u1 = 0,
/// SBKRQ [1:1]
/// Send break request
SBKRQ: u1 = 0,
/// MMRQ [2:2]
/// Mute mode request
MMRQ: u1 = 0,
/// RXFRQ [3:3]
/// Receive data flush request
RXFRQ: u1 = 0,
/// TXFRQ [4:4]
/// Transmit data flush
TXFRQ: u1 = 0,
/// unused [5:31]
_unused5: u3 = 0,
_unused8: u8 = 0,
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// Request register
pub const RQR = Register(RQR_val).init(base_address + 0x18);

/// ISR
const ISR_val = packed struct {
/// PE [0:0]
/// Parity error
PE: u1 = 0,
/// FE [1:1]
/// Framing error
FE: u1 = 0,
/// NF [2:2]
/// Noise detected flag
NF: u1 = 0,
/// ORE [3:3]
/// Overrun error
ORE: u1 = 0,
/// IDLE [4:4]
/// Idle line detected
IDLE: u1 = 0,
/// RXNE [5:5]
/// Read data register not
RXNE: u1 = 0,
/// TC [6:6]
/// Transmission complete
TC: u1 = 1,
/// TXE [7:7]
/// Transmit data register
TXE: u1 = 1,
/// LBDF [8:8]
/// LIN break detection flag
LBDF: u1 = 0,
/// CTSIF [9:9]
/// CTS interrupt flag
CTSIF: u1 = 0,
/// CTS [10:10]
/// CTS flag
CTS: u1 = 0,
/// RTOF [11:11]
/// Receiver timeout
RTOF: u1 = 0,
/// EOBF [12:12]
/// End of block flag
EOBF: u1 = 0,
/// unused [13:13]
_unused13: u1 = 0,
/// ABRE [14:14]
/// Auto baud rate error
ABRE: u1 = 0,
/// ABRF [15:15]
/// Auto baud rate flag
ABRF: u1 = 0,
/// BUSY [16:16]
/// Busy flag
BUSY: u1 = 0,
/// CMF [17:17]
/// character match flag
CMF: u1 = 0,
/// SBKF [18:18]
/// Send break flag
SBKF: u1 = 0,
/// RWU [19:19]
/// Receiver wakeup from Mute
RWU: u1 = 0,
/// WUF [20:20]
/// Wakeup from Stop mode flag
WUF: u1 = 0,
/// TEACK [21:21]
/// Transmit enable acknowledge
TEACK: u1 = 0,
/// REACK [22:22]
/// Receive enable acknowledge
REACK: u1 = 0,
/// unused [23:31]
_unused23: u1 = 0,
_unused24: u8 = 0,
};
/// Interrupt &amp; status
pub const ISR = Register(ISR_val).init(base_address + 0x1c);

/// ICR
const ICR_val = packed struct {
/// PECF [0:0]
/// Parity error clear flag
PECF: u1 = 0,
/// FECF [1:1]
/// Framing error clear flag
FECF: u1 = 0,
/// NCF [2:2]
/// Noise detected clear flag
NCF: u1 = 0,
/// ORECF [3:3]
/// Overrun error clear flag
ORECF: u1 = 0,
/// IDLECF [4:4]
/// Idle line detected clear
IDLECF: u1 = 0,
/// unused [5:5]
_unused5: u1 = 0,
/// TCCF [6:6]
/// Transmission complete clear
TCCF: u1 = 0,
/// unused [7:7]
_unused7: u1 = 0,
/// LBDCF [8:8]
/// LIN break detection clear
LBDCF: u1 = 0,
/// CTSCF [9:9]
/// CTS clear flag
CTSCF: u1 = 0,
/// unused [10:10]
_unused10: u1 = 0,
/// RTOCF [11:11]
/// Receiver timeout clear
RTOCF: u1 = 0,
/// EOBCF [12:12]
/// End of timeout clear flag
EOBCF: u1 = 0,
/// unused [13:16]
_unused13: u3 = 0,
_unused16: u1 = 0,
/// CMCF [17:17]
/// Character match clear flag
CMCF: u1 = 0,
/// unused [18:19]
_unused18: u2 = 0,
/// WUCF [20:20]
/// Wakeup from Stop mode clear
WUCF: u1 = 0,
/// unused [21:31]
_unused21: u3 = 0,
_unused24: u8 = 0,
};
/// Interrupt flag clear register
pub const ICR = Register(ICR_val).init(base_address + 0x20);

/// RDR
const RDR_val = packed struct {
/// RDR [0:8]
/// Receive data value
RDR: u9 = 0,
/// unused [9:31]
_unused9: u7 = 0,
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// Receive data register
pub const RDR = Register(RDR_val).init(base_address + 0x24);

/// TDR
const TDR_val = packed struct {
/// TDR [0:8]
/// Transmit data value
TDR: u9 = 0,
/// unused [9:31]
_unused9: u7 = 0,
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// Transmit data register
pub const TDR = Register(TDR_val).init(base_address + 0x28);
};

/// Serial peripheral interface/Inter-IC
pub const SPI1 = struct {

const base_address = 0x40013000;
/// CR1
const CR1_val = packed struct {
/// CPHA [0:0]
/// Clock phase
CPHA: u1 = 0,
/// CPOL [1:1]
/// Clock polarity
CPOL: u1 = 0,
/// MSTR [2:2]
/// Master selection
MSTR: u1 = 0,
/// BR [3:5]
/// Baud rate control
BR: u3 = 0,
/// SPE [6:6]
/// SPI enable
SPE: u1 = 0,
/// LSBFIRST [7:7]
/// Frame format
LSBFIRST: u1 = 0,
/// SSI [8:8]
/// Internal slave select
SSI: u1 = 0,
/// SSM [9:9]
/// Software slave management
SSM: u1 = 0,
/// RXONLY [10:10]
/// Receive only
RXONLY: u1 = 0,
/// CRCL [11:11]
/// CRC length
CRCL: u1 = 0,
/// CRCNEXT [12:12]
/// CRC transfer next
CRCNEXT: u1 = 0,
/// CRCEN [13:13]
/// Hardware CRC calculation
CRCEN: u1 = 0,
/// BIDIOE [14:14]
/// Output enable in bidirectional
BIDIOE: u1 = 0,
/// BIDIMODE [15:15]
/// Bidirectional data mode
BIDIMODE: u1 = 0,
/// unused [16:31]
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// control register 1
pub const CR1 = Register(CR1_val).init(base_address + 0x0);

/// CR2
const CR2_val = packed struct {
/// RXDMAEN [0:0]
/// Rx buffer DMA enable
RXDMAEN: u1 = 0,
/// TXDMAEN [1:1]
/// Tx buffer DMA enable
TXDMAEN: u1 = 0,
/// SSOE [2:2]
/// SS output enable
SSOE: u1 = 0,
/// NSSP [3:3]
/// NSS pulse management
NSSP: u1 = 0,
/// FRF [4:4]
/// Frame format
FRF: u1 = 0,
/// ERRIE [5:5]
/// Error interrupt enable
ERRIE: u1 = 0,
/// RXNEIE [6:6]
/// RX buffer not empty interrupt
RXNEIE: u1 = 0,
/// TXEIE [7:7]
/// Tx buffer empty interrupt
TXEIE: u1 = 0,
/// DS [8:11]
/// Data size
DS: u4 = 0,
/// FRXTH [12:12]
/// FIFO reception threshold
FRXTH: u1 = 0,
/// LDMA_RX [13:13]
/// Last DMA transfer for
LDMA_RX: u1 = 0,
/// LDMA_TX [14:14]
/// Last DMA transfer for
LDMA_TX: u1 = 0,
/// unused [15:31]
_unused15: u1 = 0,
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// control register 2
pub const CR2 = Register(CR2_val).init(base_address + 0x4);

/// SR
const SR_val = packed struct {
/// RXNE [0:0]
/// Receive buffer not empty
RXNE: u1 = 0,
/// TXE [1:1]
/// Transmit buffer empty
TXE: u1 = 1,
/// CHSIDE [2:2]
/// Channel side
CHSIDE: u1 = 0,
/// UDR [3:3]
/// Underrun flag
UDR: u1 = 0,
/// CRCERR [4:4]
/// CRC error flag
CRCERR: u1 = 0,
/// MODF [5:5]
/// Mode fault
MODF: u1 = 0,
/// OVR [6:6]
/// Overrun flag
OVR: u1 = 0,
/// BSY [7:7]
/// Busy flag
BSY: u1 = 0,
/// TIFRFE [8:8]
/// TI frame format error
TIFRFE: u1 = 0,
/// FRLVL [9:10]
/// FIFO reception level
FRLVL: u2 = 0,
/// FTLVL [11:12]
/// FIFO transmission level
FTLVL: u2 = 0,
/// unused [13:31]
_unused13: u3 = 0,
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// status register
pub const SR = Register(SR_val).init(base_address + 0x8);

/// DR
const DR_val = packed struct {
/// DR [0:15]
/// Data register
DR: u16 = 0,
/// unused [16:31]
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// data register
pub const DR = Register(DR_val).init(base_address + 0xc);

/// CRCPR
const CRCPR_val = packed struct {
/// CRCPOLY [0:15]
/// CRC polynomial register
CRCPOLY: u16 = 7,
/// unused [16:31]
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// CRC polynomial register
pub const CRCPR = Register(CRCPR_val).init(base_address + 0x10);

/// RXCRCR
const RXCRCR_val = packed struct {
/// RxCRC [0:15]
/// Rx CRC register
RxCRC: u16 = 0,
/// unused [16:31]
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// RX CRC register
pub const RXCRCR = Register(RXCRCR_val).init(base_address + 0x14);

/// TXCRCR
const TXCRCR_val = packed struct {
/// TxCRC [0:15]
/// Tx CRC register
TxCRC: u16 = 0,
/// unused [16:31]
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// TX CRC register
pub const TXCRCR = Register(TXCRCR_val).init(base_address + 0x18);

/// I2SCFGR
const I2SCFGR_val = packed struct {
/// CHLEN [0:0]
/// Channel length (number of bits per audio
CHLEN: u1 = 0,
/// DATLEN [1:2]
/// Data length to be
DATLEN: u2 = 0,
/// CKPOL [3:3]
/// Steady state clock
CKPOL: u1 = 0,
/// I2SSTD [4:5]
/// I2S standard selection
I2SSTD: u2 = 0,
/// unused [6:6]
_unused6: u1 = 0,
/// PCMSYNC [7:7]
/// PCM frame synchronization
PCMSYNC: u1 = 0,
/// I2SCFG [8:9]
/// I2S configuration mode
I2SCFG: u2 = 0,
/// I2SE [10:10]
/// I2S Enable
I2SE: u1 = 0,
/// I2SMOD [11:11]
/// I2S mode selection
I2SMOD: u1 = 0,
/// unused [12:31]
_unused12: u4 = 0,
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// I2S configuration register
pub const I2SCFGR = Register(I2SCFGR_val).init(base_address + 0x1c);

/// I2SPR
const I2SPR_val = packed struct {
/// I2SDIV [0:7]
/// I2S Linear prescaler
I2SDIV: u8 = 16,
/// ODD [8:8]
/// Odd factor for the
ODD: u1 = 0,
/// MCKOE [9:9]
/// Master clock output enable
MCKOE: u1 = 0,
/// unused [10:31]
_unused10: u6 = 0,
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// I2S prescaler register
pub const I2SPR = Register(I2SPR_val).init(base_address + 0x20);
};

/// Serial peripheral interface/Inter-IC
pub const SPI2 = struct {

const base_address = 0x40003800;
/// CR1
const CR1_val = packed struct {
/// CPHA [0:0]
/// Clock phase
CPHA: u1 = 0,
/// CPOL [1:1]
/// Clock polarity
CPOL: u1 = 0,
/// MSTR [2:2]
/// Master selection
MSTR: u1 = 0,
/// BR [3:5]
/// Baud rate control
BR: u3 = 0,
/// SPE [6:6]
/// SPI enable
SPE: u1 = 0,
/// LSBFIRST [7:7]
/// Frame format
LSBFIRST: u1 = 0,
/// SSI [8:8]
/// Internal slave select
SSI: u1 = 0,
/// SSM [9:9]
/// Software slave management
SSM: u1 = 0,
/// RXONLY [10:10]
/// Receive only
RXONLY: u1 = 0,
/// CRCL [11:11]
/// CRC length
CRCL: u1 = 0,
/// CRCNEXT [12:12]
/// CRC transfer next
CRCNEXT: u1 = 0,
/// CRCEN [13:13]
/// Hardware CRC calculation
CRCEN: u1 = 0,
/// BIDIOE [14:14]
/// Output enable in bidirectional
BIDIOE: u1 = 0,
/// BIDIMODE [15:15]
/// Bidirectional data mode
BIDIMODE: u1 = 0,
/// unused [16:31]
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// control register 1
pub const CR1 = Register(CR1_val).init(base_address + 0x0);

/// CR2
const CR2_val = packed struct {
/// RXDMAEN [0:0]
/// Rx buffer DMA enable
RXDMAEN: u1 = 0,
/// TXDMAEN [1:1]
/// Tx buffer DMA enable
TXDMAEN: u1 = 0,
/// SSOE [2:2]
/// SS output enable
SSOE: u1 = 0,
/// NSSP [3:3]
/// NSS pulse management
NSSP: u1 = 0,
/// FRF [4:4]
/// Frame format
FRF: u1 = 0,
/// ERRIE [5:5]
/// Error interrupt enable
ERRIE: u1 = 0,
/// RXNEIE [6:6]
/// RX buffer not empty interrupt
RXNEIE: u1 = 0,
/// TXEIE [7:7]
/// Tx buffer empty interrupt
TXEIE: u1 = 0,
/// DS [8:11]
/// Data size
DS: u4 = 0,
/// FRXTH [12:12]
/// FIFO reception threshold
FRXTH: u1 = 0,
/// LDMA_RX [13:13]
/// Last DMA transfer for
LDMA_RX: u1 = 0,
/// LDMA_TX [14:14]
/// Last DMA transfer for
LDMA_TX: u1 = 0,
/// unused [15:31]
_unused15: u1 = 0,
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// control register 2
pub const CR2 = Register(CR2_val).init(base_address + 0x4);

/// SR
const SR_val = packed struct {
/// RXNE [0:0]
/// Receive buffer not empty
RXNE: u1 = 0,
/// TXE [1:1]
/// Transmit buffer empty
TXE: u1 = 1,
/// CHSIDE [2:2]
/// Channel side
CHSIDE: u1 = 0,
/// UDR [3:3]
/// Underrun flag
UDR: u1 = 0,
/// CRCERR [4:4]
/// CRC error flag
CRCERR: u1 = 0,
/// MODF [5:5]
/// Mode fault
MODF: u1 = 0,
/// OVR [6:6]
/// Overrun flag
OVR: u1 = 0,
/// BSY [7:7]
/// Busy flag
BSY: u1 = 0,
/// TIFRFE [8:8]
/// TI frame format error
TIFRFE: u1 = 0,
/// FRLVL [9:10]
/// FIFO reception level
FRLVL: u2 = 0,
/// FTLVL [11:12]
/// FIFO transmission level
FTLVL: u2 = 0,
/// unused [13:31]
_unused13: u3 = 0,
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// status register
pub const SR = Register(SR_val).init(base_address + 0x8);

/// DR
const DR_val = packed struct {
/// DR [0:15]
/// Data register
DR: u16 = 0,
/// unused [16:31]
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// data register
pub const DR = Register(DR_val).init(base_address + 0xc);

/// CRCPR
const CRCPR_val = packed struct {
/// CRCPOLY [0:15]
/// CRC polynomial register
CRCPOLY: u16 = 7,
/// unused [16:31]
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// CRC polynomial register
pub const CRCPR = Register(CRCPR_val).init(base_address + 0x10);

/// RXCRCR
const RXCRCR_val = packed struct {
/// RxCRC [0:15]
/// Rx CRC register
RxCRC: u16 = 0,
/// unused [16:31]
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// RX CRC register
pub const RXCRCR = Register(RXCRCR_val).init(base_address + 0x14);

/// TXCRCR
const TXCRCR_val = packed struct {
/// TxCRC [0:15]
/// Tx CRC register
TxCRC: u16 = 0,
/// unused [16:31]
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// TX CRC register
pub const TXCRCR = Register(TXCRCR_val).init(base_address + 0x18);

/// I2SCFGR
const I2SCFGR_val = packed struct {
/// CHLEN [0:0]
/// Channel length (number of bits per audio
CHLEN: u1 = 0,
/// DATLEN [1:2]
/// Data length to be
DATLEN: u2 = 0,
/// CKPOL [3:3]
/// Steady state clock
CKPOL: u1 = 0,
/// I2SSTD [4:5]
/// I2S standard selection
I2SSTD: u2 = 0,
/// unused [6:6]
_unused6: u1 = 0,
/// PCMSYNC [7:7]
/// PCM frame synchronization
PCMSYNC: u1 = 0,
/// I2SCFG [8:9]
/// I2S configuration mode
I2SCFG: u2 = 0,
/// I2SE [10:10]
/// I2S Enable
I2SE: u1 = 0,
/// I2SMOD [11:11]
/// I2S mode selection
I2SMOD: u1 = 0,
/// unused [12:31]
_unused12: u4 = 0,
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// I2S configuration register
pub const I2SCFGR = Register(I2SCFGR_val).init(base_address + 0x1c);

/// I2SPR
const I2SPR_val = packed struct {
/// I2SDIV [0:7]
/// I2S Linear prescaler
I2SDIV: u8 = 16,
/// ODD [8:8]
/// Odd factor for the
ODD: u1 = 0,
/// MCKOE [9:9]
/// Master clock output enable
MCKOE: u1 = 0,
/// unused [10:31]
_unused10: u6 = 0,
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// I2S prescaler register
pub const I2SPR = Register(I2SPR_val).init(base_address + 0x20);
};

/// Serial peripheral interface/Inter-IC
pub const SPI3 = struct {

const base_address = 0x40003c00;
/// CR1
const CR1_val = packed struct {
/// CPHA [0:0]
/// Clock phase
CPHA: u1 = 0,
/// CPOL [1:1]
/// Clock polarity
CPOL: u1 = 0,
/// MSTR [2:2]
/// Master selection
MSTR: u1 = 0,
/// BR [3:5]
/// Baud rate control
BR: u3 = 0,
/// SPE [6:6]
/// SPI enable
SPE: u1 = 0,
/// LSBFIRST [7:7]
/// Frame format
LSBFIRST: u1 = 0,
/// SSI [8:8]
/// Internal slave select
SSI: u1 = 0,
/// SSM [9:9]
/// Software slave management
SSM: u1 = 0,
/// RXONLY [10:10]
/// Receive only
RXONLY: u1 = 0,
/// CRCL [11:11]
/// CRC length
CRCL: u1 = 0,
/// CRCNEXT [12:12]
/// CRC transfer next
CRCNEXT: u1 = 0,
/// CRCEN [13:13]
/// Hardware CRC calculation
CRCEN: u1 = 0,
/// BIDIOE [14:14]
/// Output enable in bidirectional
BIDIOE: u1 = 0,
/// BIDIMODE [15:15]
/// Bidirectional data mode
BIDIMODE: u1 = 0,
/// unused [16:31]
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// control register 1
pub const CR1 = Register(CR1_val).init(base_address + 0x0);

/// CR2
const CR2_val = packed struct {
/// RXDMAEN [0:0]
/// Rx buffer DMA enable
RXDMAEN: u1 = 0,
/// TXDMAEN [1:1]
/// Tx buffer DMA enable
TXDMAEN: u1 = 0,
/// SSOE [2:2]
/// SS output enable
SSOE: u1 = 0,
/// NSSP [3:3]
/// NSS pulse management
NSSP: u1 = 0,
/// FRF [4:4]
/// Frame format
FRF: u1 = 0,
/// ERRIE [5:5]
/// Error interrupt enable
ERRIE: u1 = 0,
/// RXNEIE [6:6]
/// RX buffer not empty interrupt
RXNEIE: u1 = 0,
/// TXEIE [7:7]
/// Tx buffer empty interrupt
TXEIE: u1 = 0,
/// DS [8:11]
/// Data size
DS: u4 = 0,
/// FRXTH [12:12]
/// FIFO reception threshold
FRXTH: u1 = 0,
/// LDMA_RX [13:13]
/// Last DMA transfer for
LDMA_RX: u1 = 0,
/// LDMA_TX [14:14]
/// Last DMA transfer for
LDMA_TX: u1 = 0,
/// unused [15:31]
_unused15: u1 = 0,
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// control register 2
pub const CR2 = Register(CR2_val).init(base_address + 0x4);

/// SR
const SR_val = packed struct {
/// RXNE [0:0]
/// Receive buffer not empty
RXNE: u1 = 0,
/// TXE [1:1]
/// Transmit buffer empty
TXE: u1 = 1,
/// CHSIDE [2:2]
/// Channel side
CHSIDE: u1 = 0,
/// UDR [3:3]
/// Underrun flag
UDR: u1 = 0,
/// CRCERR [4:4]
/// CRC error flag
CRCERR: u1 = 0,
/// MODF [5:5]
/// Mode fault
MODF: u1 = 0,
/// OVR [6:6]
/// Overrun flag
OVR: u1 = 0,
/// BSY [7:7]
/// Busy flag
BSY: u1 = 0,
/// TIFRFE [8:8]
/// TI frame format error
TIFRFE: u1 = 0,
/// FRLVL [9:10]
/// FIFO reception level
FRLVL: u2 = 0,
/// FTLVL [11:12]
/// FIFO transmission level
FTLVL: u2 = 0,
/// unused [13:31]
_unused13: u3 = 0,
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// status register
pub const SR = Register(SR_val).init(base_address + 0x8);

/// DR
const DR_val = packed struct {
/// DR [0:15]
/// Data register
DR: u16 = 0,
/// unused [16:31]
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// data register
pub const DR = Register(DR_val).init(base_address + 0xc);

/// CRCPR
const CRCPR_val = packed struct {
/// CRCPOLY [0:15]
/// CRC polynomial register
CRCPOLY: u16 = 7,
/// unused [16:31]
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// CRC polynomial register
pub const CRCPR = Register(CRCPR_val).init(base_address + 0x10);

/// RXCRCR
const RXCRCR_val = packed struct {
/// RxCRC [0:15]
/// Rx CRC register
RxCRC: u16 = 0,
/// unused [16:31]
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// RX CRC register
pub const RXCRCR = Register(RXCRCR_val).init(base_address + 0x14);

/// TXCRCR
const TXCRCR_val = packed struct {
/// TxCRC [0:15]
/// Tx CRC register
TxCRC: u16 = 0,
/// unused [16:31]
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// TX CRC register
pub const TXCRCR = Register(TXCRCR_val).init(base_address + 0x18);

/// I2SCFGR
const I2SCFGR_val = packed struct {
/// CHLEN [0:0]
/// Channel length (number of bits per audio
CHLEN: u1 = 0,
/// DATLEN [1:2]
/// Data length to be
DATLEN: u2 = 0,
/// CKPOL [3:3]
/// Steady state clock
CKPOL: u1 = 0,
/// I2SSTD [4:5]
/// I2S standard selection
I2SSTD: u2 = 0,
/// unused [6:6]
_unused6: u1 = 0,
/// PCMSYNC [7:7]
/// PCM frame synchronization
PCMSYNC: u1 = 0,
/// I2SCFG [8:9]
/// I2S configuration mode
I2SCFG: u2 = 0,
/// I2SE [10:10]
/// I2S Enable
I2SE: u1 = 0,
/// I2SMOD [11:11]
/// I2S mode selection
I2SMOD: u1 = 0,
/// unused [12:31]
_unused12: u4 = 0,
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// I2S configuration register
pub const I2SCFGR = Register(I2SCFGR_val).init(base_address + 0x1c);

/// I2SPR
const I2SPR_val = packed struct {
/// I2SDIV [0:7]
/// I2S Linear prescaler
I2SDIV: u8 = 16,
/// ODD [8:8]
/// Odd factor for the
ODD: u1 = 0,
/// MCKOE [9:9]
/// Master clock output enable
MCKOE: u1 = 0,
/// unused [10:31]
_unused10: u6 = 0,
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// I2S prescaler register
pub const I2SPR = Register(I2SPR_val).init(base_address + 0x20);
};

/// Serial peripheral interface/Inter-IC
pub const I2S2ext = struct {

const base_address = 0x40003400;
/// CR1
const CR1_val = packed struct {
/// CPHA [0:0]
/// Clock phase
CPHA: u1 = 0,
/// CPOL [1:1]
/// Clock polarity
CPOL: u1 = 0,
/// MSTR [2:2]
/// Master selection
MSTR: u1 = 0,
/// BR [3:5]
/// Baud rate control
BR: u3 = 0,
/// SPE [6:6]
/// SPI enable
SPE: u1 = 0,
/// LSBFIRST [7:7]
/// Frame format
LSBFIRST: u1 = 0,
/// SSI [8:8]
/// Internal slave select
SSI: u1 = 0,
/// SSM [9:9]
/// Software slave management
SSM: u1 = 0,
/// RXONLY [10:10]
/// Receive only
RXONLY: u1 = 0,
/// CRCL [11:11]
/// CRC length
CRCL: u1 = 0,
/// CRCNEXT [12:12]
/// CRC transfer next
CRCNEXT: u1 = 0,
/// CRCEN [13:13]
/// Hardware CRC calculation
CRCEN: u1 = 0,
/// BIDIOE [14:14]
/// Output enable in bidirectional
BIDIOE: u1 = 0,
/// BIDIMODE [15:15]
/// Bidirectional data mode
BIDIMODE: u1 = 0,
/// unused [16:31]
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// control register 1
pub const CR1 = Register(CR1_val).init(base_address + 0x0);

/// CR2
const CR2_val = packed struct {
/// RXDMAEN [0:0]
/// Rx buffer DMA enable
RXDMAEN: u1 = 0,
/// TXDMAEN [1:1]
/// Tx buffer DMA enable
TXDMAEN: u1 = 0,
/// SSOE [2:2]
/// SS output enable
SSOE: u1 = 0,
/// NSSP [3:3]
/// NSS pulse management
NSSP: u1 = 0,
/// FRF [4:4]
/// Frame format
FRF: u1 = 0,
/// ERRIE [5:5]
/// Error interrupt enable
ERRIE: u1 = 0,
/// RXNEIE [6:6]
/// RX buffer not empty interrupt
RXNEIE: u1 = 0,
/// TXEIE [7:7]
/// Tx buffer empty interrupt
TXEIE: u1 = 0,
/// DS [8:11]
/// Data size
DS: u4 = 0,
/// FRXTH [12:12]
/// FIFO reception threshold
FRXTH: u1 = 0,
/// LDMA_RX [13:13]
/// Last DMA transfer for
LDMA_RX: u1 = 0,
/// LDMA_TX [14:14]
/// Last DMA transfer for
LDMA_TX: u1 = 0,
/// unused [15:31]
_unused15: u1 = 0,
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// control register 2
pub const CR2 = Register(CR2_val).init(base_address + 0x4);

/// SR
const SR_val = packed struct {
/// RXNE [0:0]
/// Receive buffer not empty
RXNE: u1 = 0,
/// TXE [1:1]
/// Transmit buffer empty
TXE: u1 = 1,
/// CHSIDE [2:2]
/// Channel side
CHSIDE: u1 = 0,
/// UDR [3:3]
/// Underrun flag
UDR: u1 = 0,
/// CRCERR [4:4]
/// CRC error flag
CRCERR: u1 = 0,
/// MODF [5:5]
/// Mode fault
MODF: u1 = 0,
/// OVR [6:6]
/// Overrun flag
OVR: u1 = 0,
/// BSY [7:7]
/// Busy flag
BSY: u1 = 0,
/// TIFRFE [8:8]
/// TI frame format error
TIFRFE: u1 = 0,
/// FRLVL [9:10]
/// FIFO reception level
FRLVL: u2 = 0,
/// FTLVL [11:12]
/// FIFO transmission level
FTLVL: u2 = 0,
/// unused [13:31]
_unused13: u3 = 0,
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// status register
pub const SR = Register(SR_val).init(base_address + 0x8);

/// DR
const DR_val = packed struct {
/// DR [0:15]
/// Data register
DR: u16 = 0,
/// unused [16:31]
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// data register
pub const DR = Register(DR_val).init(base_address + 0xc);

/// CRCPR
const CRCPR_val = packed struct {
/// CRCPOLY [0:15]
/// CRC polynomial register
CRCPOLY: u16 = 7,
/// unused [16:31]
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// CRC polynomial register
pub const CRCPR = Register(CRCPR_val).init(base_address + 0x10);

/// RXCRCR
const RXCRCR_val = packed struct {
/// RxCRC [0:15]
/// Rx CRC register
RxCRC: u16 = 0,
/// unused [16:31]
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// RX CRC register
pub const RXCRCR = Register(RXCRCR_val).init(base_address + 0x14);

/// TXCRCR
const TXCRCR_val = packed struct {
/// TxCRC [0:15]
/// Tx CRC register
TxCRC: u16 = 0,
/// unused [16:31]
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// TX CRC register
pub const TXCRCR = Register(TXCRCR_val).init(base_address + 0x18);

/// I2SCFGR
const I2SCFGR_val = packed struct {
/// CHLEN [0:0]
/// Channel length (number of bits per audio
CHLEN: u1 = 0,
/// DATLEN [1:2]
/// Data length to be
DATLEN: u2 = 0,
/// CKPOL [3:3]
/// Steady state clock
CKPOL: u1 = 0,
/// I2SSTD [4:5]
/// I2S standard selection
I2SSTD: u2 = 0,
/// unused [6:6]
_unused6: u1 = 0,
/// PCMSYNC [7:7]
/// PCM frame synchronization
PCMSYNC: u1 = 0,
/// I2SCFG [8:9]
/// I2S configuration mode
I2SCFG: u2 = 0,
/// I2SE [10:10]
/// I2S Enable
I2SE: u1 = 0,
/// I2SMOD [11:11]
/// I2S mode selection
I2SMOD: u1 = 0,
/// unused [12:31]
_unused12: u4 = 0,
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// I2S configuration register
pub const I2SCFGR = Register(I2SCFGR_val).init(base_address + 0x1c);

/// I2SPR
const I2SPR_val = packed struct {
/// I2SDIV [0:7]
/// I2S Linear prescaler
I2SDIV: u8 = 16,
/// ODD [8:8]
/// Odd factor for the
ODD: u1 = 0,
/// MCKOE [9:9]
/// Master clock output enable
MCKOE: u1 = 0,
/// unused [10:31]
_unused10: u6 = 0,
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// I2S prescaler register
pub const I2SPR = Register(I2SPR_val).init(base_address + 0x20);
};

/// Serial peripheral interface/Inter-IC
pub const I2S3ext = struct {

const base_address = 0x40004000;
/// CR1
const CR1_val = packed struct {
/// CPHA [0:0]
/// Clock phase
CPHA: u1 = 0,
/// CPOL [1:1]
/// Clock polarity
CPOL: u1 = 0,
/// MSTR [2:2]
/// Master selection
MSTR: u1 = 0,
/// BR [3:5]
/// Baud rate control
BR: u3 = 0,
/// SPE [6:6]
/// SPI enable
SPE: u1 = 0,
/// LSBFIRST [7:7]
/// Frame format
LSBFIRST: u1 = 0,
/// SSI [8:8]
/// Internal slave select
SSI: u1 = 0,
/// SSM [9:9]
/// Software slave management
SSM: u1 = 0,
/// RXONLY [10:10]
/// Receive only
RXONLY: u1 = 0,
/// CRCL [11:11]
/// CRC length
CRCL: u1 = 0,
/// CRCNEXT [12:12]
/// CRC transfer next
CRCNEXT: u1 = 0,
/// CRCEN [13:13]
/// Hardware CRC calculation
CRCEN: u1 = 0,
/// BIDIOE [14:14]
/// Output enable in bidirectional
BIDIOE: u1 = 0,
/// BIDIMODE [15:15]
/// Bidirectional data mode
BIDIMODE: u1 = 0,
/// unused [16:31]
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// control register 1
pub const CR1 = Register(CR1_val).init(base_address + 0x0);

/// CR2
const CR2_val = packed struct {
/// RXDMAEN [0:0]
/// Rx buffer DMA enable
RXDMAEN: u1 = 0,
/// TXDMAEN [1:1]
/// Tx buffer DMA enable
TXDMAEN: u1 = 0,
/// SSOE [2:2]
/// SS output enable
SSOE: u1 = 0,
/// NSSP [3:3]
/// NSS pulse management
NSSP: u1 = 0,
/// FRF [4:4]
/// Frame format
FRF: u1 = 0,
/// ERRIE [5:5]
/// Error interrupt enable
ERRIE: u1 = 0,
/// RXNEIE [6:6]
/// RX buffer not empty interrupt
RXNEIE: u1 = 0,
/// TXEIE [7:7]
/// Tx buffer empty interrupt
TXEIE: u1 = 0,
/// DS [8:11]
/// Data size
DS: u4 = 0,
/// FRXTH [12:12]
/// FIFO reception threshold
FRXTH: u1 = 0,
/// LDMA_RX [13:13]
/// Last DMA transfer for
LDMA_RX: u1 = 0,
/// LDMA_TX [14:14]
/// Last DMA transfer for
LDMA_TX: u1 = 0,
/// unused [15:31]
_unused15: u1 = 0,
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// control register 2
pub const CR2 = Register(CR2_val).init(base_address + 0x4);

/// SR
const SR_val = packed struct {
/// RXNE [0:0]
/// Receive buffer not empty
RXNE: u1 = 0,
/// TXE [1:1]
/// Transmit buffer empty
TXE: u1 = 1,
/// CHSIDE [2:2]
/// Channel side
CHSIDE: u1 = 0,
/// UDR [3:3]
/// Underrun flag
UDR: u1 = 0,
/// CRCERR [4:4]
/// CRC error flag
CRCERR: u1 = 0,
/// MODF [5:5]
/// Mode fault
MODF: u1 = 0,
/// OVR [6:6]
/// Overrun flag
OVR: u1 = 0,
/// BSY [7:7]
/// Busy flag
BSY: u1 = 0,
/// TIFRFE [8:8]
/// TI frame format error
TIFRFE: u1 = 0,
/// FRLVL [9:10]
/// FIFO reception level
FRLVL: u2 = 0,
/// FTLVL [11:12]
/// FIFO transmission level
FTLVL: u2 = 0,
/// unused [13:31]
_unused13: u3 = 0,
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// status register
pub const SR = Register(SR_val).init(base_address + 0x8);

/// DR
const DR_val = packed struct {
/// DR [0:15]
/// Data register
DR: u16 = 0,
/// unused [16:31]
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// data register
pub const DR = Register(DR_val).init(base_address + 0xc);

/// CRCPR
const CRCPR_val = packed struct {
/// CRCPOLY [0:15]
/// CRC polynomial register
CRCPOLY: u16 = 7,
/// unused [16:31]
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// CRC polynomial register
pub const CRCPR = Register(CRCPR_val).init(base_address + 0x10);

/// RXCRCR
const RXCRCR_val = packed struct {
/// RxCRC [0:15]
/// Rx CRC register
RxCRC: u16 = 0,
/// unused [16:31]
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// RX CRC register
pub const RXCRCR = Register(RXCRCR_val).init(base_address + 0x14);

/// TXCRCR
const TXCRCR_val = packed struct {
/// TxCRC [0:15]
/// Tx CRC register
TxCRC: u16 = 0,
/// unused [16:31]
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// TX CRC register
pub const TXCRCR = Register(TXCRCR_val).init(base_address + 0x18);

/// I2SCFGR
const I2SCFGR_val = packed struct {
/// CHLEN [0:0]
/// Channel length (number of bits per audio
CHLEN: u1 = 0,
/// DATLEN [1:2]
/// Data length to be
DATLEN: u2 = 0,
/// CKPOL [3:3]
/// Steady state clock
CKPOL: u1 = 0,
/// I2SSTD [4:5]
/// I2S standard selection
I2SSTD: u2 = 0,
/// unused [6:6]
_unused6: u1 = 0,
/// PCMSYNC [7:7]
/// PCM frame synchronization
PCMSYNC: u1 = 0,
/// I2SCFG [8:9]
/// I2S configuration mode
I2SCFG: u2 = 0,
/// I2SE [10:10]
/// I2S Enable
I2SE: u1 = 0,
/// I2SMOD [11:11]
/// I2S mode selection
I2SMOD: u1 = 0,
/// unused [12:31]
_unused12: u4 = 0,
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// I2S configuration register
pub const I2SCFGR = Register(I2SCFGR_val).init(base_address + 0x1c);

/// I2SPR
const I2SPR_val = packed struct {
/// I2SDIV [0:7]
/// I2S Linear prescaler
I2SDIV: u8 = 16,
/// ODD [8:8]
/// Odd factor for the
ODD: u1 = 0,
/// MCKOE [9:9]
/// Master clock output enable
MCKOE: u1 = 0,
/// unused [10:31]
_unused10: u6 = 0,
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// I2S prescaler register
pub const I2SPR = Register(I2SPR_val).init(base_address + 0x20);
};

/// Serial peripheral interface/Inter-IC
pub const SPI4 = struct {

const base_address = 0x40013c00;
/// CR1
const CR1_val = packed struct {
/// CPHA [0:0]
/// Clock phase
CPHA: u1 = 0,
/// CPOL [1:1]
/// Clock polarity
CPOL: u1 = 0,
/// MSTR [2:2]
/// Master selection
MSTR: u1 = 0,
/// BR [3:5]
/// Baud rate control
BR: u3 = 0,
/// SPE [6:6]
/// SPI enable
SPE: u1 = 0,
/// LSBFIRST [7:7]
/// Frame format
LSBFIRST: u1 = 0,
/// SSI [8:8]
/// Internal slave select
SSI: u1 = 0,
/// SSM [9:9]
/// Software slave management
SSM: u1 = 0,
/// RXONLY [10:10]
/// Receive only
RXONLY: u1 = 0,
/// CRCL [11:11]
/// CRC length
CRCL: u1 = 0,
/// CRCNEXT [12:12]
/// CRC transfer next
CRCNEXT: u1 = 0,
/// CRCEN [13:13]
/// Hardware CRC calculation
CRCEN: u1 = 0,
/// BIDIOE [14:14]
/// Output enable in bidirectional
BIDIOE: u1 = 0,
/// BIDIMODE [15:15]
/// Bidirectional data mode
BIDIMODE: u1 = 0,
/// unused [16:31]
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// control register 1
pub const CR1 = Register(CR1_val).init(base_address + 0x0);

/// CR2
const CR2_val = packed struct {
/// RXDMAEN [0:0]
/// Rx buffer DMA enable
RXDMAEN: u1 = 0,
/// TXDMAEN [1:1]
/// Tx buffer DMA enable
TXDMAEN: u1 = 0,
/// SSOE [2:2]
/// SS output enable
SSOE: u1 = 0,
/// NSSP [3:3]
/// NSS pulse management
NSSP: u1 = 0,
/// FRF [4:4]
/// Frame format
FRF: u1 = 0,
/// ERRIE [5:5]
/// Error interrupt enable
ERRIE: u1 = 0,
/// RXNEIE [6:6]
/// RX buffer not empty interrupt
RXNEIE: u1 = 0,
/// TXEIE [7:7]
/// Tx buffer empty interrupt
TXEIE: u1 = 0,
/// DS [8:11]
/// Data size
DS: u4 = 0,
/// FRXTH [12:12]
/// FIFO reception threshold
FRXTH: u1 = 0,
/// LDMA_RX [13:13]
/// Last DMA transfer for
LDMA_RX: u1 = 0,
/// LDMA_TX [14:14]
/// Last DMA transfer for
LDMA_TX: u1 = 0,
/// unused [15:31]
_unused15: u1 = 0,
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// control register 2
pub const CR2 = Register(CR2_val).init(base_address + 0x4);

/// SR
const SR_val = packed struct {
/// RXNE [0:0]
/// Receive buffer not empty
RXNE: u1 = 0,
/// TXE [1:1]
/// Transmit buffer empty
TXE: u1 = 1,
/// CHSIDE [2:2]
/// Channel side
CHSIDE: u1 = 0,
/// UDR [3:3]
/// Underrun flag
UDR: u1 = 0,
/// CRCERR [4:4]
/// CRC error flag
CRCERR: u1 = 0,
/// MODF [5:5]
/// Mode fault
MODF: u1 = 0,
/// OVR [6:6]
/// Overrun flag
OVR: u1 = 0,
/// BSY [7:7]
/// Busy flag
BSY: u1 = 0,
/// TIFRFE [8:8]
/// TI frame format error
TIFRFE: u1 = 0,
/// FRLVL [9:10]
/// FIFO reception level
FRLVL: u2 = 0,
/// FTLVL [11:12]
/// FIFO transmission level
FTLVL: u2 = 0,
/// unused [13:31]
_unused13: u3 = 0,
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// status register
pub const SR = Register(SR_val).init(base_address + 0x8);

/// DR
const DR_val = packed struct {
/// DR [0:15]
/// Data register
DR: u16 = 0,
/// unused [16:31]
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// data register
pub const DR = Register(DR_val).init(base_address + 0xc);

/// CRCPR
const CRCPR_val = packed struct {
/// CRCPOLY [0:15]
/// CRC polynomial register
CRCPOLY: u16 = 7,
/// unused [16:31]
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// CRC polynomial register
pub const CRCPR = Register(CRCPR_val).init(base_address + 0x10);

/// RXCRCR
const RXCRCR_val = packed struct {
/// RxCRC [0:15]
/// Rx CRC register
RxCRC: u16 = 0,
/// unused [16:31]
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// RX CRC register
pub const RXCRCR = Register(RXCRCR_val).init(base_address + 0x14);

/// TXCRCR
const TXCRCR_val = packed struct {
/// TxCRC [0:15]
/// Tx CRC register
TxCRC: u16 = 0,
/// unused [16:31]
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// TX CRC register
pub const TXCRCR = Register(TXCRCR_val).init(base_address + 0x18);

/// I2SCFGR
const I2SCFGR_val = packed struct {
/// CHLEN [0:0]
/// Channel length (number of bits per audio
CHLEN: u1 = 0,
/// DATLEN [1:2]
/// Data length to be
DATLEN: u2 = 0,
/// CKPOL [3:3]
/// Steady state clock
CKPOL: u1 = 0,
/// I2SSTD [4:5]
/// I2S standard selection
I2SSTD: u2 = 0,
/// unused [6:6]
_unused6: u1 = 0,
/// PCMSYNC [7:7]
/// PCM frame synchronization
PCMSYNC: u1 = 0,
/// I2SCFG [8:9]
/// I2S configuration mode
I2SCFG: u2 = 0,
/// I2SE [10:10]
/// I2S Enable
I2SE: u1 = 0,
/// I2SMOD [11:11]
/// I2S mode selection
I2SMOD: u1 = 0,
/// unused [12:31]
_unused12: u4 = 0,
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// I2S configuration register
pub const I2SCFGR = Register(I2SCFGR_val).init(base_address + 0x1c);

/// I2SPR
const I2SPR_val = packed struct {
/// I2SDIV [0:7]
/// I2S Linear prescaler
I2SDIV: u8 = 16,
/// ODD [8:8]
/// Odd factor for the
ODD: u1 = 0,
/// MCKOE [9:9]
/// Master clock output enable
MCKOE: u1 = 0,
/// unused [10:31]
_unused10: u6 = 0,
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// I2S prescaler register
pub const I2SPR = Register(I2SPR_val).init(base_address + 0x20);
};

/// External interrupt/event
pub const EXTI = struct {

const base_address = 0x40010400;
/// IMR1
const IMR1_val = packed struct {
/// MR0 [0:0]
/// Interrupt Mask on line 0
MR0: u1 = 0,
/// MR1 [1:1]
/// Interrupt Mask on line 1
MR1: u1 = 0,
/// MR2 [2:2]
/// Interrupt Mask on line 2
MR2: u1 = 0,
/// MR3 [3:3]
/// Interrupt Mask on line 3
MR3: u1 = 0,
/// MR4 [4:4]
/// Interrupt Mask on line 4
MR4: u1 = 0,
/// MR5 [5:5]
/// Interrupt Mask on line 5
MR5: u1 = 0,
/// MR6 [6:6]
/// Interrupt Mask on line 6
MR6: u1 = 0,
/// MR7 [7:7]
/// Interrupt Mask on line 7
MR7: u1 = 0,
/// MR8 [8:8]
/// Interrupt Mask on line 8
MR8: u1 = 0,
/// MR9 [9:9]
/// Interrupt Mask on line 9
MR9: u1 = 0,
/// MR10 [10:10]
/// Interrupt Mask on line 10
MR10: u1 = 0,
/// MR11 [11:11]
/// Interrupt Mask on line 11
MR11: u1 = 0,
/// MR12 [12:12]
/// Interrupt Mask on line 12
MR12: u1 = 0,
/// MR13 [13:13]
/// Interrupt Mask on line 13
MR13: u1 = 0,
/// MR14 [14:14]
/// Interrupt Mask on line 14
MR14: u1 = 0,
/// MR15 [15:15]
/// Interrupt Mask on line 15
MR15: u1 = 0,
/// MR16 [16:16]
/// Interrupt Mask on line 16
MR16: u1 = 0,
/// MR17 [17:17]
/// Interrupt Mask on line 17
MR17: u1 = 0,
/// MR18 [18:18]
/// Interrupt Mask on line 18
MR18: u1 = 0,
/// MR19 [19:19]
/// Interrupt Mask on line 19
MR19: u1 = 0,
/// MR20 [20:20]
/// Interrupt Mask on line 20
MR20: u1 = 0,
/// MR21 [21:21]
/// Interrupt Mask on line 21
MR21: u1 = 0,
/// MR22 [22:22]
/// Interrupt Mask on line 22
MR22: u1 = 0,
/// MR23 [23:23]
/// Interrupt Mask on line 23
MR23: u1 = 1,
/// MR24 [24:24]
/// Interrupt Mask on line 24
MR24: u1 = 1,
/// MR25 [25:25]
/// Interrupt Mask on line 25
MR25: u1 = 1,
/// MR26 [26:26]
/// Interrupt Mask on line 26
MR26: u1 = 1,
/// MR27 [27:27]
/// Interrupt Mask on line 27
MR27: u1 = 1,
/// MR28 [28:28]
/// Interrupt Mask on line 28
MR28: u1 = 1,
/// MR29 [29:29]
/// Interrupt Mask on line 29
MR29: u1 = 0,
/// MR30 [30:30]
/// Interrupt Mask on line 30
MR30: u1 = 0,
/// MR31 [31:31]
/// Interrupt Mask on line 31
MR31: u1 = 0,
};
/// Interrupt mask register
pub const IMR1 = Register(IMR1_val).init(base_address + 0x0);

/// EMR1
const EMR1_val = packed struct {
/// MR0 [0:0]
/// Event Mask on line 0
MR0: u1 = 0,
/// MR1 [1:1]
/// Event Mask on line 1
MR1: u1 = 0,
/// MR2 [2:2]
/// Event Mask on line 2
MR2: u1 = 0,
/// MR3 [3:3]
/// Event Mask on line 3
MR3: u1 = 0,
/// MR4 [4:4]
/// Event Mask on line 4
MR4: u1 = 0,
/// MR5 [5:5]
/// Event Mask on line 5
MR5: u1 = 0,
/// MR6 [6:6]
/// Event Mask on line 6
MR6: u1 = 0,
/// MR7 [7:7]
/// Event Mask on line 7
MR7: u1 = 0,
/// MR8 [8:8]
/// Event Mask on line 8
MR8: u1 = 0,
/// MR9 [9:9]
/// Event Mask on line 9
MR9: u1 = 0,
/// MR10 [10:10]
/// Event Mask on line 10
MR10: u1 = 0,
/// MR11 [11:11]
/// Event Mask on line 11
MR11: u1 = 0,
/// MR12 [12:12]
/// Event Mask on line 12
MR12: u1 = 0,
/// MR13 [13:13]
/// Event Mask on line 13
MR13: u1 = 0,
/// MR14 [14:14]
/// Event Mask on line 14
MR14: u1 = 0,
/// MR15 [15:15]
/// Event Mask on line 15
MR15: u1 = 0,
/// MR16 [16:16]
/// Event Mask on line 16
MR16: u1 = 0,
/// MR17 [17:17]
/// Event Mask on line 17
MR17: u1 = 0,
/// MR18 [18:18]
/// Event Mask on line 18
MR18: u1 = 0,
/// MR19 [19:19]
/// Event Mask on line 19
MR19: u1 = 0,
/// MR20 [20:20]
/// Event Mask on line 20
MR20: u1 = 0,
/// MR21 [21:21]
/// Event Mask on line 21
MR21: u1 = 0,
/// MR22 [22:22]
/// Event Mask on line 22
MR22: u1 = 0,
/// MR23 [23:23]
/// Event Mask on line 23
MR23: u1 = 0,
/// MR24 [24:24]
/// Event Mask on line 24
MR24: u1 = 0,
/// MR25 [25:25]
/// Event Mask on line 25
MR25: u1 = 0,
/// MR26 [26:26]
/// Event Mask on line 26
MR26: u1 = 0,
/// MR27 [27:27]
/// Event Mask on line 27
MR27: u1 = 0,
/// MR28 [28:28]
/// Event Mask on line 28
MR28: u1 = 0,
/// MR29 [29:29]
/// Event Mask on line 29
MR29: u1 = 0,
/// MR30 [30:30]
/// Event Mask on line 30
MR30: u1 = 0,
/// MR31 [31:31]
/// Event Mask on line 31
MR31: u1 = 0,
};
/// Event mask register
pub const EMR1 = Register(EMR1_val).init(base_address + 0x4);

/// RTSR1
const RTSR1_val = packed struct {
/// TR0 [0:0]
/// Rising trigger event configuration of
TR0: u1 = 0,
/// TR1 [1:1]
/// Rising trigger event configuration of
TR1: u1 = 0,
/// TR2 [2:2]
/// Rising trigger event configuration of
TR2: u1 = 0,
/// TR3 [3:3]
/// Rising trigger event configuration of
TR3: u1 = 0,
/// TR4 [4:4]
/// Rising trigger event configuration of
TR4: u1 = 0,
/// TR5 [5:5]
/// Rising trigger event configuration of
TR5: u1 = 0,
/// TR6 [6:6]
/// Rising trigger event configuration of
TR6: u1 = 0,
/// TR7 [7:7]
/// Rising trigger event configuration of
TR7: u1 = 0,
/// TR8 [8:8]
/// Rising trigger event configuration of
TR8: u1 = 0,
/// TR9 [9:9]
/// Rising trigger event configuration of
TR9: u1 = 0,
/// TR10 [10:10]
/// Rising trigger event configuration of
TR10: u1 = 0,
/// TR11 [11:11]
/// Rising trigger event configuration of
TR11: u1 = 0,
/// TR12 [12:12]
/// Rising trigger event configuration of
TR12: u1 = 0,
/// TR13 [13:13]
/// Rising trigger event configuration of
TR13: u1 = 0,
/// TR14 [14:14]
/// Rising trigger event configuration of
TR14: u1 = 0,
/// TR15 [15:15]
/// Rising trigger event configuration of
TR15: u1 = 0,
/// TR16 [16:16]
/// Rising trigger event configuration of
TR16: u1 = 0,
/// TR17 [17:17]
/// Rising trigger event configuration of
TR17: u1 = 0,
/// TR18 [18:18]
/// Rising trigger event configuration of
TR18: u1 = 0,
/// TR19 [19:19]
/// Rising trigger event configuration of
TR19: u1 = 0,
/// TR20 [20:20]
/// Rising trigger event configuration of
TR20: u1 = 0,
/// TR21 [21:21]
/// Rising trigger event configuration of
TR21: u1 = 0,
/// TR22 [22:22]
/// Rising trigger event configuration of
TR22: u1 = 0,
/// unused [23:28]
_unused23: u1 = 0,
_unused24: u5 = 0,
/// TR29 [29:29]
/// Rising trigger event configuration of
TR29: u1 = 0,
/// TR30 [30:30]
/// Rising trigger event configuration of
TR30: u1 = 0,
/// TR31 [31:31]
/// Rising trigger event configuration of
TR31: u1 = 0,
};
/// Rising Trigger selection
pub const RTSR1 = Register(RTSR1_val).init(base_address + 0x8);

/// FTSR1
const FTSR1_val = packed struct {
/// TR0 [0:0]
/// Falling trigger event configuration of
TR0: u1 = 0,
/// TR1 [1:1]
/// Falling trigger event configuration of
TR1: u1 = 0,
/// TR2 [2:2]
/// Falling trigger event configuration of
TR2: u1 = 0,
/// TR3 [3:3]
/// Falling trigger event configuration of
TR3: u1 = 0,
/// TR4 [4:4]
/// Falling trigger event configuration of
TR4: u1 = 0,
/// TR5 [5:5]
/// Falling trigger event configuration of
TR5: u1 = 0,
/// TR6 [6:6]
/// Falling trigger event configuration of
TR6: u1 = 0,
/// TR7 [7:7]
/// Falling trigger event configuration of
TR7: u1 = 0,
/// TR8 [8:8]
/// Falling trigger event configuration of
TR8: u1 = 0,
/// TR9 [9:9]
/// Falling trigger event configuration of
TR9: u1 = 0,
/// TR10 [10:10]
/// Falling trigger event configuration of
TR10: u1 = 0,
/// TR11 [11:11]
/// Falling trigger event configuration of
TR11: u1 = 0,
/// TR12 [12:12]
/// Falling trigger event configuration of
TR12: u1 = 0,
/// TR13 [13:13]
/// Falling trigger event configuration of
TR13: u1 = 0,
/// TR14 [14:14]
/// Falling trigger event configuration of
TR14: u1 = 0,
/// TR15 [15:15]
/// Falling trigger event configuration of
TR15: u1 = 0,
/// TR16 [16:16]
/// Falling trigger event configuration of
TR16: u1 = 0,
/// TR17 [17:17]
/// Falling trigger event configuration of
TR17: u1 = 0,
/// TR18 [18:18]
/// Falling trigger event configuration of
TR18: u1 = 0,
/// TR19 [19:19]
/// Falling trigger event configuration of
TR19: u1 = 0,
/// TR20 [20:20]
/// Falling trigger event configuration of
TR20: u1 = 0,
/// TR21 [21:21]
/// Falling trigger event configuration of
TR21: u1 = 0,
/// TR22 [22:22]
/// Falling trigger event configuration of
TR22: u1 = 0,
/// unused [23:28]
_unused23: u1 = 0,
_unused24: u5 = 0,
/// TR29 [29:29]
/// Falling trigger event configuration of
TR29: u1 = 0,
/// TR30 [30:30]
/// Falling trigger event configuration of
TR30: u1 = 0,
/// TR31 [31:31]
/// Falling trigger event configuration of
TR31: u1 = 0,
};
/// Falling Trigger selection
pub const FTSR1 = Register(FTSR1_val).init(base_address + 0xc);

/// SWIER1
const SWIER1_val = packed struct {
/// SWIER0 [0:0]
/// Software Interrupt on line
SWIER0: u1 = 0,
/// SWIER1 [1:1]
/// Software Interrupt on line
SWIER1: u1 = 0,
/// SWIER2 [2:2]
/// Software Interrupt on line
SWIER2: u1 = 0,
/// SWIER3 [3:3]
/// Software Interrupt on line
SWIER3: u1 = 0,
/// SWIER4 [4:4]
/// Software Interrupt on line
SWIER4: u1 = 0,
/// SWIER5 [5:5]
/// Software Interrupt on line
SWIER5: u1 = 0,
/// SWIER6 [6:6]
/// Software Interrupt on line
SWIER6: u1 = 0,
/// SWIER7 [7:7]
/// Software Interrupt on line
SWIER7: u1 = 0,
/// SWIER8 [8:8]
/// Software Interrupt on line
SWIER8: u1 = 0,
/// SWIER9 [9:9]
/// Software Interrupt on line
SWIER9: u1 = 0,
/// SWIER10 [10:10]
/// Software Interrupt on line
SWIER10: u1 = 0,
/// SWIER11 [11:11]
/// Software Interrupt on line
SWIER11: u1 = 0,
/// SWIER12 [12:12]
/// Software Interrupt on line
SWIER12: u1 = 0,
/// SWIER13 [13:13]
/// Software Interrupt on line
SWIER13: u1 = 0,
/// SWIER14 [14:14]
/// Software Interrupt on line
SWIER14: u1 = 0,
/// SWIER15 [15:15]
/// Software Interrupt on line
SWIER15: u1 = 0,
/// SWIER16 [16:16]
/// Software Interrupt on line
SWIER16: u1 = 0,
/// SWIER17 [17:17]
/// Software Interrupt on line
SWIER17: u1 = 0,
/// SWIER18 [18:18]
/// Software Interrupt on line
SWIER18: u1 = 0,
/// SWIER19 [19:19]
/// Software Interrupt on line
SWIER19: u1 = 0,
/// SWIER20 [20:20]
/// Software Interrupt on line
SWIER20: u1 = 0,
/// SWIER21 [21:21]
/// Software Interrupt on line
SWIER21: u1 = 0,
/// SWIER22 [22:22]
/// Software Interrupt on line
SWIER22: u1 = 0,
/// unused [23:28]
_unused23: u1 = 0,
_unused24: u5 = 0,
/// SWIER29 [29:29]
/// Software Interrupt on line
SWIER29: u1 = 0,
/// SWIER30 [30:30]
/// Software Interrupt on line
SWIER30: u1 = 0,
/// SWIER31 [31:31]
/// Software Interrupt on line
SWIER31: u1 = 0,
};
/// Software interrupt event
pub const SWIER1 = Register(SWIER1_val).init(base_address + 0x10);

/// PR1
const PR1_val = packed struct {
/// PR0 [0:0]
/// Pending bit 0
PR0: u1 = 0,
/// PR1 [1:1]
/// Pending bit 1
PR1: u1 = 0,
/// PR2 [2:2]
/// Pending bit 2
PR2: u1 = 0,
/// PR3 [3:3]
/// Pending bit 3
PR3: u1 = 0,
/// PR4 [4:4]
/// Pending bit 4
PR4: u1 = 0,
/// PR5 [5:5]
/// Pending bit 5
PR5: u1 = 0,
/// PR6 [6:6]
/// Pending bit 6
PR6: u1 = 0,
/// PR7 [7:7]
/// Pending bit 7
PR7: u1 = 0,
/// PR8 [8:8]
/// Pending bit 8
PR8: u1 = 0,
/// PR9 [9:9]
/// Pending bit 9
PR9: u1 = 0,
/// PR10 [10:10]
/// Pending bit 10
PR10: u1 = 0,
/// PR11 [11:11]
/// Pending bit 11
PR11: u1 = 0,
/// PR12 [12:12]
/// Pending bit 12
PR12: u1 = 0,
/// PR13 [13:13]
/// Pending bit 13
PR13: u1 = 0,
/// PR14 [14:14]
/// Pending bit 14
PR14: u1 = 0,
/// PR15 [15:15]
/// Pending bit 15
PR15: u1 = 0,
/// PR16 [16:16]
/// Pending bit 16
PR16: u1 = 0,
/// PR17 [17:17]
/// Pending bit 17
PR17: u1 = 0,
/// PR18 [18:18]
/// Pending bit 18
PR18: u1 = 0,
/// PR19 [19:19]
/// Pending bit 19
PR19: u1 = 0,
/// PR20 [20:20]
/// Pending bit 20
PR20: u1 = 0,
/// PR21 [21:21]
/// Pending bit 21
PR21: u1 = 0,
/// PR22 [22:22]
/// Pending bit 22
PR22: u1 = 0,
/// unused [23:28]
_unused23: u1 = 0,
_unused24: u5 = 0,
/// PR29 [29:29]
/// Pending bit 29
PR29: u1 = 0,
/// PR30 [30:30]
/// Pending bit 30
PR30: u1 = 0,
/// PR31 [31:31]
/// Pending bit 31
PR31: u1 = 0,
};
/// Pending register
pub const PR1 = Register(PR1_val).init(base_address + 0x14);

/// IMR2
const IMR2_val = packed struct {
/// MR32 [0:0]
/// Interrupt Mask on external/internal line
MR32: u1 = 0,
/// MR33 [1:1]
/// Interrupt Mask on external/internal line
MR33: u1 = 0,
/// MR34 [2:2]
/// Interrupt Mask on external/internal line
MR34: u1 = 1,
/// MR35 [3:3]
/// Interrupt Mask on external/internal line
MR35: u1 = 1,
/// unused [4:31]
_unused4: u4 = 15,
_unused8: u8 = 255,
_unused16: u8 = 255,
_unused24: u8 = 255,
};
/// Interrupt mask register
pub const IMR2 = Register(IMR2_val).init(base_address + 0x18);

/// EMR2
const EMR2_val = packed struct {
/// MR32 [0:0]
/// Event mask on external/internal line
MR32: u1 = 0,
/// MR33 [1:1]
/// Event mask on external/internal line
MR33: u1 = 0,
/// MR34 [2:2]
/// Event mask on external/internal line
MR34: u1 = 0,
/// MR35 [3:3]
/// Event mask on external/internal line
MR35: u1 = 0,
/// unused [4:31]
_unused4: u4 = 0,
_unused8: u8 = 0,
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// Event mask register
pub const EMR2 = Register(EMR2_val).init(base_address + 0x1c);

/// RTSR2
const RTSR2_val = packed struct {
/// TR32 [0:0]
/// Rising trigger event configuration bit
TR32: u1 = 0,
/// TR33 [1:1]
/// Rising trigger event configuration bit
TR33: u1 = 0,
/// unused [2:31]
_unused2: u6 = 0,
_unused8: u8 = 0,
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// Rising Trigger selection
pub const RTSR2 = Register(RTSR2_val).init(base_address + 0x20);

/// FTSR2
const FTSR2_val = packed struct {
/// TR32 [0:0]
/// Falling trigger event configuration bit
TR32: u1 = 0,
/// TR33 [1:1]
/// Falling trigger event configuration bit
TR33: u1 = 0,
/// unused [2:31]
_unused2: u6 = 0,
_unused8: u8 = 0,
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// Falling Trigger selection
pub const FTSR2 = Register(FTSR2_val).init(base_address + 0x24);

/// SWIER2
const SWIER2_val = packed struct {
/// SWIER32 [0:0]
/// Software interrupt on line
SWIER32: u1 = 0,
/// SWIER33 [1:1]
/// Software interrupt on line
SWIER33: u1 = 0,
/// unused [2:31]
_unused2: u6 = 0,
_unused8: u8 = 0,
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// Software interrupt event
pub const SWIER2 = Register(SWIER2_val).init(base_address + 0x28);

/// PR2
const PR2_val = packed struct {
/// PR32 [0:0]
/// Pending bit on line 32
PR32: u1 = 0,
/// PR33 [1:1]
/// Pending bit on line 33
PR33: u1 = 0,
/// unused [2:31]
_unused2: u6 = 0,
_unused8: u8 = 0,
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// Pending register
pub const PR2 = Register(PR2_val).init(base_address + 0x2c);
};

/// Power control
pub const PWR = struct {

const base_address = 0x40007000;
/// CR
const CR_val = packed struct {
/// LPDS [0:0]
/// Low-power deep sleep
LPDS: u1 = 0,
/// PDDS [1:1]
/// Power down deepsleep
PDDS: u1 = 0,
/// CWUF [2:2]
/// Clear wakeup flag
CWUF: u1 = 0,
/// CSBF [3:3]
/// Clear standby flag
CSBF: u1 = 0,
/// PVDE [4:4]
/// Power voltage detector
PVDE: u1 = 0,
/// PLS [5:7]
/// PVD level selection
PLS: u3 = 0,
/// DBP [8:8]
/// Disable backup domain write
DBP: u1 = 0,
/// unused [9:31]
_unused9: u7 = 0,
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// power control register
pub const CR = Register(CR_val).init(base_address + 0x0);

/// CSR
const CSR_val = packed struct {
/// WUF [0:0]
/// Wakeup flag
WUF: u1 = 0,
/// SBF [1:1]
/// Standby flag
SBF: u1 = 0,
/// PVDO [2:2]
/// PVD output
PVDO: u1 = 0,
/// unused [3:7]
_unused3: u5 = 0,
/// EWUP1 [8:8]
/// Enable WKUP1 pin
EWUP1: u1 = 0,
/// EWUP2 [9:9]
/// Enable WKUP2 pin
EWUP2: u1 = 0,
/// unused [10:31]
_unused10: u6 = 0,
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// power control/status register
pub const CSR = Register(CSR_val).init(base_address + 0x4);
};

/// Controller area network
pub const CAN = struct {

const base_address = 0x40006400;
/// MCR
const MCR_val = packed struct {
/// INRQ [0:0]
/// INRQ
INRQ: u1 = 0,
/// SLEEP [1:1]
/// SLEEP
SLEEP: u1 = 1,
/// TXFP [2:2]
/// TXFP
TXFP: u1 = 0,
/// RFLM [3:3]
/// RFLM
RFLM: u1 = 0,
/// NART [4:4]
/// NART
NART: u1 = 0,
/// AWUM [5:5]
/// AWUM
AWUM: u1 = 0,
/// ABOM [6:6]
/// ABOM
ABOM: u1 = 0,
/// TTCM [7:7]
/// TTCM
TTCM: u1 = 0,
/// unused [8:14]
_unused8: u7 = 0,
/// RESET [15:15]
/// RESET
RESET: u1 = 0,
/// DBF [16:16]
/// DBF
DBF: u1 = 1,
/// unused [17:31]
_unused17: u7 = 0,
_unused24: u8 = 0,
};
/// master control register
pub const MCR = Register(MCR_val).init(base_address + 0x0);

/// MSR
const MSR_val = packed struct {
/// INAK [0:0]
/// INAK
INAK: u1 = 0,
/// SLAK [1:1]
/// SLAK
SLAK: u1 = 1,
/// ERRI [2:2]
/// ERRI
ERRI: u1 = 0,
/// WKUI [3:3]
/// WKUI
WKUI: u1 = 0,
/// SLAKI [4:4]
/// SLAKI
SLAKI: u1 = 0,
/// unused [5:7]
_unused5: u3 = 0,
/// TXM [8:8]
/// TXM
TXM: u1 = 0,
/// RXM [9:9]
/// RXM
RXM: u1 = 0,
/// SAMP [10:10]
/// SAMP
SAMP: u1 = 1,
/// RX [11:11]
/// RX
RX: u1 = 1,
/// unused [12:31]
_unused12: u4 = 0,
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// master status register
pub const MSR = Register(MSR_val).init(base_address + 0x4);

/// TSR
const TSR_val = packed struct {
/// RQCP0 [0:0]
/// RQCP0
RQCP0: u1 = 0,
/// TXOK0 [1:1]
/// TXOK0
TXOK0: u1 = 0,
/// ALST0 [2:2]
/// ALST0
ALST0: u1 = 0,
/// TERR0 [3:3]
/// TERR0
TERR0: u1 = 0,
/// unused [4:6]
_unused4: u3 = 0,
/// ABRQ0 [7:7]
/// ABRQ0
ABRQ0: u1 = 0,
/// RQCP1 [8:8]
/// RQCP1
RQCP1: u1 = 0,
/// TXOK1 [9:9]
/// TXOK1
TXOK1: u1 = 0,
/// ALST1 [10:10]
/// ALST1
ALST1: u1 = 0,
/// TERR1 [11:11]
/// TERR1
TERR1: u1 = 0,
/// unused [12:14]
_unused12: u3 = 0,
/// ABRQ1 [15:15]
/// ABRQ1
ABRQ1: u1 = 0,
/// RQCP2 [16:16]
/// RQCP2
RQCP2: u1 = 0,
/// TXOK2 [17:17]
/// TXOK2
TXOK2: u1 = 0,
/// ALST2 [18:18]
/// ALST2
ALST2: u1 = 0,
/// TERR2 [19:19]
/// TERR2
TERR2: u1 = 0,
/// unused [20:22]
_unused20: u3 = 0,
/// ABRQ2 [23:23]
/// ABRQ2
ABRQ2: u1 = 0,
/// CODE [24:25]
/// CODE
CODE: u2 = 0,
/// TME0 [26:26]
/// Lowest priority flag for mailbox
TME0: u1 = 1,
/// TME1 [27:27]
/// Lowest priority flag for mailbox
TME1: u1 = 1,
/// TME2 [28:28]
/// Lowest priority flag for mailbox
TME2: u1 = 1,
/// LOW0 [29:29]
/// Lowest priority flag for mailbox
LOW0: u1 = 0,
/// LOW1 [30:30]
/// Lowest priority flag for mailbox
LOW1: u1 = 0,
/// LOW2 [31:31]
/// Lowest priority flag for mailbox
LOW2: u1 = 0,
};
/// transmit status register
pub const TSR = Register(TSR_val).init(base_address + 0x8);

/// RF0R
const RF0R_val = packed struct {
/// FMP0 [0:1]
/// FMP0
FMP0: u2 = 0,
/// unused [2:2]
_unused2: u1 = 0,
/// FULL0 [3:3]
/// FULL0
FULL0: u1 = 0,
/// FOVR0 [4:4]
/// FOVR0
FOVR0: u1 = 0,
/// RFOM0 [5:5]
/// RFOM0
RFOM0: u1 = 0,
/// unused [6:31]
_unused6: u2 = 0,
_unused8: u8 = 0,
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// receive FIFO 0 register
pub const RF0R = Register(RF0R_val).init(base_address + 0xc);

/// RF1R
const RF1R_val = packed struct {
/// FMP1 [0:1]
/// FMP1
FMP1: u2 = 0,
/// unused [2:2]
_unused2: u1 = 0,
/// FULL1 [3:3]
/// FULL1
FULL1: u1 = 0,
/// FOVR1 [4:4]
/// FOVR1
FOVR1: u1 = 0,
/// RFOM1 [5:5]
/// RFOM1
RFOM1: u1 = 0,
/// unused [6:31]
_unused6: u2 = 0,
_unused8: u8 = 0,
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// receive FIFO 1 register
pub const RF1R = Register(RF1R_val).init(base_address + 0x10);

/// IER
const IER_val = packed struct {
/// TMEIE [0:0]
/// TMEIE
TMEIE: u1 = 0,
/// FMPIE0 [1:1]
/// FMPIE0
FMPIE0: u1 = 0,
/// FFIE0 [2:2]
/// FFIE0
FFIE0: u1 = 0,
/// FOVIE0 [3:3]
/// FOVIE0
FOVIE0: u1 = 0,
/// FMPIE1 [4:4]
/// FMPIE1
FMPIE1: u1 = 0,
/// FFIE1 [5:5]
/// FFIE1
FFIE1: u1 = 0,
/// FOVIE1 [6:6]
/// FOVIE1
FOVIE1: u1 = 0,
/// unused [7:7]
_unused7: u1 = 0,
/// EWGIE [8:8]
/// EWGIE
EWGIE: u1 = 0,
/// EPVIE [9:9]
/// EPVIE
EPVIE: u1 = 0,
/// BOFIE [10:10]
/// BOFIE
BOFIE: u1 = 0,
/// LECIE [11:11]
/// LECIE
LECIE: u1 = 0,
/// unused [12:14]
_unused12: u3 = 0,
/// ERRIE [15:15]
/// ERRIE
ERRIE: u1 = 0,
/// WKUIE [16:16]
/// WKUIE
WKUIE: u1 = 0,
/// SLKIE [17:17]
/// SLKIE
SLKIE: u1 = 0,
/// unused [18:31]
_unused18: u6 = 0,
_unused24: u8 = 0,
};
/// interrupt enable register
pub const IER = Register(IER_val).init(base_address + 0x14);

/// ESR
const ESR_val = packed struct {
/// EWGF [0:0]
/// EWGF
EWGF: u1 = 0,
/// EPVF [1:1]
/// EPVF
EPVF: u1 = 0,
/// BOFF [2:2]
/// BOFF
BOFF: u1 = 0,
/// unused [3:3]
_unused3: u1 = 0,
/// LEC [4:6]
/// LEC
LEC: u3 = 0,
/// unused [7:15]
_unused7: u1 = 0,
_unused8: u8 = 0,
/// TEC [16:23]
/// TEC
TEC: u8 = 0,
/// REC [24:31]
/// REC
REC: u8 = 0,
};
/// error status register
pub const ESR = Register(ESR_val).init(base_address + 0x18);

/// BTR
const BTR_val = packed struct {
/// BRP [0:9]
/// BRP
BRP: u10 = 0,
/// unused [10:15]
_unused10: u6 = 0,
/// TS1 [16:19]
/// TS1
TS1: u4 = 3,
/// TS2 [20:22]
/// TS2
TS2: u3 = 2,
/// unused [23:23]
_unused23: u1 = 0,
/// SJW [24:25]
/// SJW
SJW: u2 = 1,
/// unused [26:29]
_unused26: u4 = 0,
/// LBKM [30:30]
/// LBKM
LBKM: u1 = 0,
/// SILM [31:31]
/// SILM
SILM: u1 = 0,
};
/// bit timing register
pub const BTR = Register(BTR_val).init(base_address + 0x1c);

/// TI0R
const TI0R_val = packed struct {
/// TXRQ [0:0]
/// TXRQ
TXRQ: u1 = 0,
/// RTR [1:1]
/// RTR
RTR: u1 = 0,
/// IDE [2:2]
/// IDE
IDE: u1 = 0,
/// EXID [3:20]
/// EXID
EXID: u18 = 0,
/// STID [21:31]
/// STID
STID: u11 = 0,
};
/// TX mailbox identifier register
pub const TI0R = Register(TI0R_val).init(base_address + 0x180);

/// TDT0R
const TDT0R_val = packed struct {
/// DLC [0:3]
/// DLC
DLC: u4 = 0,
/// unused [4:7]
_unused4: u4 = 0,
/// TGT [8:8]
/// TGT
TGT: u1 = 0,
/// unused [9:15]
_unused9: u7 = 0,
/// TIME [16:31]
/// TIME
TIME: u16 = 0,
};
/// mailbox data length control and time stamp
pub const TDT0R = Register(TDT0R_val).init(base_address + 0x184);

/// TDL0R
const TDL0R_val = packed struct {
/// DATA0 [0:7]
/// DATA0
DATA0: u8 = 0,
/// DATA1 [8:15]
/// DATA1
DATA1: u8 = 0,
/// DATA2 [16:23]
/// DATA2
DATA2: u8 = 0,
/// DATA3 [24:31]
/// DATA3
DATA3: u8 = 0,
};
/// mailbox data low register
pub const TDL0R = Register(TDL0R_val).init(base_address + 0x188);

/// TDH0R
const TDH0R_val = packed struct {
/// DATA4 [0:7]
/// DATA4
DATA4: u8 = 0,
/// DATA5 [8:15]
/// DATA5
DATA5: u8 = 0,
/// DATA6 [16:23]
/// DATA6
DATA6: u8 = 0,
/// DATA7 [24:31]
/// DATA7
DATA7: u8 = 0,
};
/// mailbox data high register
pub const TDH0R = Register(TDH0R_val).init(base_address + 0x18c);

/// TI1R
const TI1R_val = packed struct {
/// TXRQ [0:0]
/// TXRQ
TXRQ: u1 = 0,
/// RTR [1:1]
/// RTR
RTR: u1 = 0,
/// IDE [2:2]
/// IDE
IDE: u1 = 0,
/// EXID [3:20]
/// EXID
EXID: u18 = 0,
/// STID [21:31]
/// STID
STID: u11 = 0,
};
/// TX mailbox identifier register
pub const TI1R = Register(TI1R_val).init(base_address + 0x190);

/// TDT1R
const TDT1R_val = packed struct {
/// DLC [0:3]
/// DLC
DLC: u4 = 0,
/// unused [4:7]
_unused4: u4 = 0,
/// TGT [8:8]
/// TGT
TGT: u1 = 0,
/// unused [9:15]
_unused9: u7 = 0,
/// TIME [16:31]
/// TIME
TIME: u16 = 0,
};
/// mailbox data length control and time stamp
pub const TDT1R = Register(TDT1R_val).init(base_address + 0x194);

/// TDL1R
const TDL1R_val = packed struct {
/// DATA0 [0:7]
/// DATA0
DATA0: u8 = 0,
/// DATA1 [8:15]
/// DATA1
DATA1: u8 = 0,
/// DATA2 [16:23]
/// DATA2
DATA2: u8 = 0,
/// DATA3 [24:31]
/// DATA3
DATA3: u8 = 0,
};
/// mailbox data low register
pub const TDL1R = Register(TDL1R_val).init(base_address + 0x198);

/// TDH1R
const TDH1R_val = packed struct {
/// DATA4 [0:7]
/// DATA4
DATA4: u8 = 0,
/// DATA5 [8:15]
/// DATA5
DATA5: u8 = 0,
/// DATA6 [16:23]
/// DATA6
DATA6: u8 = 0,
/// DATA7 [24:31]
/// DATA7
DATA7: u8 = 0,
};
/// mailbox data high register
pub const TDH1R = Register(TDH1R_val).init(base_address + 0x19c);

/// TI2R
const TI2R_val = packed struct {
/// TXRQ [0:0]
/// TXRQ
TXRQ: u1 = 0,
/// RTR [1:1]
/// RTR
RTR: u1 = 0,
/// IDE [2:2]
/// IDE
IDE: u1 = 0,
/// EXID [3:20]
/// EXID
EXID: u18 = 0,
/// STID [21:31]
/// STID
STID: u11 = 0,
};
/// TX mailbox identifier register
pub const TI2R = Register(TI2R_val).init(base_address + 0x1a0);

/// TDT2R
const TDT2R_val = packed struct {
/// DLC [0:3]
/// DLC
DLC: u4 = 0,
/// unused [4:7]
_unused4: u4 = 0,
/// TGT [8:8]
/// TGT
TGT: u1 = 0,
/// unused [9:15]
_unused9: u7 = 0,
/// TIME [16:31]
/// TIME
TIME: u16 = 0,
};
/// mailbox data length control and time stamp
pub const TDT2R = Register(TDT2R_val).init(base_address + 0x1a4);

/// TDL2R
const TDL2R_val = packed struct {
/// DATA0 [0:7]
/// DATA0
DATA0: u8 = 0,
/// DATA1 [8:15]
/// DATA1
DATA1: u8 = 0,
/// DATA2 [16:23]
/// DATA2
DATA2: u8 = 0,
/// DATA3 [24:31]
/// DATA3
DATA3: u8 = 0,
};
/// mailbox data low register
pub const TDL2R = Register(TDL2R_val).init(base_address + 0x1a8);

/// TDH2R
const TDH2R_val = packed struct {
/// DATA4 [0:7]
/// DATA4
DATA4: u8 = 0,
/// DATA5 [8:15]
/// DATA5
DATA5: u8 = 0,
/// DATA6 [16:23]
/// DATA6
DATA6: u8 = 0,
/// DATA7 [24:31]
/// DATA7
DATA7: u8 = 0,
};
/// mailbox data high register
pub const TDH2R = Register(TDH2R_val).init(base_address + 0x1ac);

/// RI0R
const RI0R_val = packed struct {
/// unused [0:0]
_unused0: u1 = 0,
/// RTR [1:1]
/// RTR
RTR: u1 = 0,
/// IDE [2:2]
/// IDE
IDE: u1 = 0,
/// EXID [3:20]
/// EXID
EXID: u18 = 0,
/// STID [21:31]
/// STID
STID: u11 = 0,
};
/// receive FIFO mailbox identifier
pub const RI0R = Register(RI0R_val).init(base_address + 0x1b0);

/// RDT0R
const RDT0R_val = packed struct {
/// DLC [0:3]
/// DLC
DLC: u4 = 0,
/// unused [4:7]
_unused4: u4 = 0,
/// FMI [8:15]
/// FMI
FMI: u8 = 0,
/// TIME [16:31]
/// TIME
TIME: u16 = 0,
};
/// receive FIFO mailbox data length control and
pub const RDT0R = Register(RDT0R_val).init(base_address + 0x1b4);

/// RDL0R
const RDL0R_val = packed struct {
/// DATA0 [0:7]
/// DATA0
DATA0: u8 = 0,
/// DATA1 [8:15]
/// DATA1
DATA1: u8 = 0,
/// DATA2 [16:23]
/// DATA2
DATA2: u8 = 0,
/// DATA3 [24:31]
/// DATA3
DATA3: u8 = 0,
};
/// receive FIFO mailbox data low
pub const RDL0R = Register(RDL0R_val).init(base_address + 0x1b8);

/// RDH0R
const RDH0R_val = packed struct {
/// DATA4 [0:7]
/// DATA4
DATA4: u8 = 0,
/// DATA5 [8:15]
/// DATA5
DATA5: u8 = 0,
/// DATA6 [16:23]
/// DATA6
DATA6: u8 = 0,
/// DATA7 [24:31]
/// DATA7
DATA7: u8 = 0,
};
/// receive FIFO mailbox data high
pub const RDH0R = Register(RDH0R_val).init(base_address + 0x1bc);

/// RI1R
const RI1R_val = packed struct {
/// unused [0:0]
_unused0: u1 = 0,
/// RTR [1:1]
/// RTR
RTR: u1 = 0,
/// IDE [2:2]
/// IDE
IDE: u1 = 0,
/// EXID [3:20]
/// EXID
EXID: u18 = 0,
/// STID [21:31]
/// STID
STID: u11 = 0,
};
/// receive FIFO mailbox identifier
pub const RI1R = Register(RI1R_val).init(base_address + 0x1c0);

/// RDT1R
const RDT1R_val = packed struct {
/// DLC [0:3]
/// DLC
DLC: u4 = 0,
/// unused [4:7]
_unused4: u4 = 0,
/// FMI [8:15]
/// FMI
FMI: u8 = 0,
/// TIME [16:31]
/// TIME
TIME: u16 = 0,
};
/// receive FIFO mailbox data length control and
pub const RDT1R = Register(RDT1R_val).init(base_address + 0x1c4);

/// RDL1R
const RDL1R_val = packed struct {
/// DATA0 [0:7]
/// DATA0
DATA0: u8 = 0,
/// DATA1 [8:15]
/// DATA1
DATA1: u8 = 0,
/// DATA2 [16:23]
/// DATA2
DATA2: u8 = 0,
/// DATA3 [24:31]
/// DATA3
DATA3: u8 = 0,
};
/// receive FIFO mailbox data low
pub const RDL1R = Register(RDL1R_val).init(base_address + 0x1c8);

/// RDH1R
const RDH1R_val = packed struct {
/// DATA4 [0:7]
/// DATA4
DATA4: u8 = 0,
/// DATA5 [8:15]
/// DATA5
DATA5: u8 = 0,
/// DATA6 [16:23]
/// DATA6
DATA6: u8 = 0,
/// DATA7 [24:31]
/// DATA7
DATA7: u8 = 0,
};
/// receive FIFO mailbox data high
pub const RDH1R = Register(RDH1R_val).init(base_address + 0x1cc);

/// FMR
const FMR_val = packed struct {
/// FINIT [0:0]
/// Filter init mode
FINIT: u1 = 1,
/// unused [1:7]
_unused1: u7 = 0,
/// CAN2SB [8:13]
/// CAN2 start bank
CAN2SB: u6 = 14,
/// unused [14:31]
_unused14: u2 = 0,
_unused16: u8 = 28,
_unused24: u8 = 42,
};
/// filter master register
pub const FMR = Register(FMR_val).init(base_address + 0x200);

/// FM1R
const FM1R_val = packed struct {
/// FBM0 [0:0]
/// Filter mode
FBM0: u1 = 0,
/// FBM1 [1:1]
/// Filter mode
FBM1: u1 = 0,
/// FBM2 [2:2]
/// Filter mode
FBM2: u1 = 0,
/// FBM3 [3:3]
/// Filter mode
FBM3: u1 = 0,
/// FBM4 [4:4]
/// Filter mode
FBM4: u1 = 0,
/// FBM5 [5:5]
/// Filter mode
FBM5: u1 = 0,
/// FBM6 [6:6]
/// Filter mode
FBM6: u1 = 0,
/// FBM7 [7:7]
/// Filter mode
FBM7: u1 = 0,
/// FBM8 [8:8]
/// Filter mode
FBM8: u1 = 0,
/// FBM9 [9:9]
/// Filter mode
FBM9: u1 = 0,
/// FBM10 [10:10]
/// Filter mode
FBM10: u1 = 0,
/// FBM11 [11:11]
/// Filter mode
FBM11: u1 = 0,
/// FBM12 [12:12]
/// Filter mode
FBM12: u1 = 0,
/// FBM13 [13:13]
/// Filter mode
FBM13: u1 = 0,
/// FBM14 [14:14]
/// Filter mode
FBM14: u1 = 0,
/// FBM15 [15:15]
/// Filter mode
FBM15: u1 = 0,
/// FBM16 [16:16]
/// Filter mode
FBM16: u1 = 0,
/// FBM17 [17:17]
/// Filter mode
FBM17: u1 = 0,
/// FBM18 [18:18]
/// Filter mode
FBM18: u1 = 0,
/// FBM19 [19:19]
/// Filter mode
FBM19: u1 = 0,
/// FBM20 [20:20]
/// Filter mode
FBM20: u1 = 0,
/// FBM21 [21:21]
/// Filter mode
FBM21: u1 = 0,
/// FBM22 [22:22]
/// Filter mode
FBM22: u1 = 0,
/// FBM23 [23:23]
/// Filter mode
FBM23: u1 = 0,
/// FBM24 [24:24]
/// Filter mode
FBM24: u1 = 0,
/// FBM25 [25:25]
/// Filter mode
FBM25: u1 = 0,
/// FBM26 [26:26]
/// Filter mode
FBM26: u1 = 0,
/// FBM27 [27:27]
/// Filter mode
FBM27: u1 = 0,
/// unused [28:31]
_unused28: u4 = 0,
};
/// filter mode register
pub const FM1R = Register(FM1R_val).init(base_address + 0x204);

/// FS1R
const FS1R_val = packed struct {
/// FSC0 [0:0]
/// Filter scale configuration
FSC0: u1 = 0,
/// FSC1 [1:1]
/// Filter scale configuration
FSC1: u1 = 0,
/// FSC2 [2:2]
/// Filter scale configuration
FSC2: u1 = 0,
/// FSC3 [3:3]
/// Filter scale configuration
FSC3: u1 = 0,
/// FSC4 [4:4]
/// Filter scale configuration
FSC4: u1 = 0,
/// FSC5 [5:5]
/// Filter scale configuration
FSC5: u1 = 0,
/// FSC6 [6:6]
/// Filter scale configuration
FSC6: u1 = 0,
/// FSC7 [7:7]
/// Filter scale configuration
FSC7: u1 = 0,
/// FSC8 [8:8]
/// Filter scale configuration
FSC8: u1 = 0,
/// FSC9 [9:9]
/// Filter scale configuration
FSC9: u1 = 0,
/// FSC10 [10:10]
/// Filter scale configuration
FSC10: u1 = 0,
/// FSC11 [11:11]
/// Filter scale configuration
FSC11: u1 = 0,
/// FSC12 [12:12]
/// Filter scale configuration
FSC12: u1 = 0,
/// FSC13 [13:13]
/// Filter scale configuration
FSC13: u1 = 0,
/// FSC14 [14:14]
/// Filter scale configuration
FSC14: u1 = 0,
/// FSC15 [15:15]
/// Filter scale configuration
FSC15: u1 = 0,
/// FSC16 [16:16]
/// Filter scale configuration
FSC16: u1 = 0,
/// FSC17 [17:17]
/// Filter scale configuration
FSC17: u1 = 0,
/// FSC18 [18:18]
/// Filter scale configuration
FSC18: u1 = 0,
/// FSC19 [19:19]
/// Filter scale configuration
FSC19: u1 = 0,
/// FSC20 [20:20]
/// Filter scale configuration
FSC20: u1 = 0,
/// FSC21 [21:21]
/// Filter scale configuration
FSC21: u1 = 0,
/// FSC22 [22:22]
/// Filter scale configuration
FSC22: u1 = 0,
/// FSC23 [23:23]
/// Filter scale configuration
FSC23: u1 = 0,
/// FSC24 [24:24]
/// Filter scale configuration
FSC24: u1 = 0,
/// FSC25 [25:25]
/// Filter scale configuration
FSC25: u1 = 0,
/// FSC26 [26:26]
/// Filter scale configuration
FSC26: u1 = 0,
/// FSC27 [27:27]
/// Filter scale configuration
FSC27: u1 = 0,
/// unused [28:31]
_unused28: u4 = 0,
};
/// filter scale register
pub const FS1R = Register(FS1R_val).init(base_address + 0x20c);

/// FFA1R
const FFA1R_val = packed struct {
/// FFA0 [0:0]
/// Filter FIFO assignment for filter
FFA0: u1 = 0,
/// FFA1 [1:1]
/// Filter FIFO assignment for filter
FFA1: u1 = 0,
/// FFA2 [2:2]
/// Filter FIFO assignment for filter
FFA2: u1 = 0,
/// FFA3 [3:3]
/// Filter FIFO assignment for filter
FFA3: u1 = 0,
/// FFA4 [4:4]
/// Filter FIFO assignment for filter
FFA4: u1 = 0,
/// FFA5 [5:5]
/// Filter FIFO assignment for filter
FFA5: u1 = 0,
/// FFA6 [6:6]
/// Filter FIFO assignment for filter
FFA6: u1 = 0,
/// FFA7 [7:7]
/// Filter FIFO assignment for filter
FFA7: u1 = 0,
/// FFA8 [8:8]
/// Filter FIFO assignment for filter
FFA8: u1 = 0,
/// FFA9 [9:9]
/// Filter FIFO assignment for filter
FFA9: u1 = 0,
/// FFA10 [10:10]
/// Filter FIFO assignment for filter
FFA10: u1 = 0,
/// FFA11 [11:11]
/// Filter FIFO assignment for filter
FFA11: u1 = 0,
/// FFA12 [12:12]
/// Filter FIFO assignment for filter
FFA12: u1 = 0,
/// FFA13 [13:13]
/// Filter FIFO assignment for filter
FFA13: u1 = 0,
/// FFA14 [14:14]
/// Filter FIFO assignment for filter
FFA14: u1 = 0,
/// FFA15 [15:15]
/// Filter FIFO assignment for filter
FFA15: u1 = 0,
/// FFA16 [16:16]
/// Filter FIFO assignment for filter
FFA16: u1 = 0,
/// FFA17 [17:17]
/// Filter FIFO assignment for filter
FFA17: u1 = 0,
/// FFA18 [18:18]
/// Filter FIFO assignment for filter
FFA18: u1 = 0,
/// FFA19 [19:19]
/// Filter FIFO assignment for filter
FFA19: u1 = 0,
/// FFA20 [20:20]
/// Filter FIFO assignment for filter
FFA20: u1 = 0,
/// FFA21 [21:21]
/// Filter FIFO assignment for filter
FFA21: u1 = 0,
/// FFA22 [22:22]
/// Filter FIFO assignment for filter
FFA22: u1 = 0,
/// FFA23 [23:23]
/// Filter FIFO assignment for filter
FFA23: u1 = 0,
/// FFA24 [24:24]
/// Filter FIFO assignment for filter
FFA24: u1 = 0,
/// FFA25 [25:25]
/// Filter FIFO assignment for filter
FFA25: u1 = 0,
/// FFA26 [26:26]
/// Filter FIFO assignment for filter
FFA26: u1 = 0,
/// FFA27 [27:27]
/// Filter FIFO assignment for filter
FFA27: u1 = 0,
/// unused [28:31]
_unused28: u4 = 0,
};
/// filter FIFO assignment
pub const FFA1R = Register(FFA1R_val).init(base_address + 0x214);

/// FA1R
const FA1R_val = packed struct {
/// FACT0 [0:0]
/// Filter active
FACT0: u1 = 0,
/// FACT1 [1:1]
/// Filter active
FACT1: u1 = 0,
/// FACT2 [2:2]
/// Filter active
FACT2: u1 = 0,
/// FACT3 [3:3]
/// Filter active
FACT3: u1 = 0,
/// FACT4 [4:4]
/// Filter active
FACT4: u1 = 0,
/// FACT5 [5:5]
/// Filter active
FACT5: u1 = 0,
/// FACT6 [6:6]
/// Filter active
FACT6: u1 = 0,
/// FACT7 [7:7]
/// Filter active
FACT7: u1 = 0,
/// FACT8 [8:8]
/// Filter active
FACT8: u1 = 0,
/// FACT9 [9:9]
/// Filter active
FACT9: u1 = 0,
/// FACT10 [10:10]
/// Filter active
FACT10: u1 = 0,
/// FACT11 [11:11]
/// Filter active
FACT11: u1 = 0,
/// FACT12 [12:12]
/// Filter active
FACT12: u1 = 0,
/// FACT13 [13:13]
/// Filter active
FACT13: u1 = 0,
/// FACT14 [14:14]
/// Filter active
FACT14: u1 = 0,
/// FACT15 [15:15]
/// Filter active
FACT15: u1 = 0,
/// FACT16 [16:16]
/// Filter active
FACT16: u1 = 0,
/// FACT17 [17:17]
/// Filter active
FACT17: u1 = 0,
/// FACT18 [18:18]
/// Filter active
FACT18: u1 = 0,
/// FACT19 [19:19]
/// Filter active
FACT19: u1 = 0,
/// FACT20 [20:20]
/// Filter active
FACT20: u1 = 0,
/// FACT21 [21:21]
/// Filter active
FACT21: u1 = 0,
/// FACT22 [22:22]
/// Filter active
FACT22: u1 = 0,
/// FACT23 [23:23]
/// Filter active
FACT23: u1 = 0,
/// FACT24 [24:24]
/// Filter active
FACT24: u1 = 0,
/// FACT25 [25:25]
/// Filter active
FACT25: u1 = 0,
/// FACT26 [26:26]
/// Filter active
FACT26: u1 = 0,
/// FACT27 [27:27]
/// Filter active
FACT27: u1 = 0,
/// unused [28:31]
_unused28: u4 = 0,
};
/// CAN filter activation register
pub const FA1R = Register(FA1R_val).init(base_address + 0x21c);

/// F0R1
const F0R1_val = packed struct {
/// FB0 [0:0]
/// Filter bits
FB0: u1 = 0,
/// FB1 [1:1]
/// Filter bits
FB1: u1 = 0,
/// FB2 [2:2]
/// Filter bits
FB2: u1 = 0,
/// FB3 [3:3]
/// Filter bits
FB3: u1 = 0,
/// FB4 [4:4]
/// Filter bits
FB4: u1 = 0,
/// FB5 [5:5]
/// Filter bits
FB5: u1 = 0,
/// FB6 [6:6]
/// Filter bits
FB6: u1 = 0,
/// FB7 [7:7]
/// Filter bits
FB7: u1 = 0,
/// FB8 [8:8]
/// Filter bits
FB8: u1 = 0,
/// FB9 [9:9]
/// Filter bits
FB9: u1 = 0,
/// FB10 [10:10]
/// Filter bits
FB10: u1 = 0,
/// FB11 [11:11]
/// Filter bits
FB11: u1 = 0,
/// FB12 [12:12]
/// Filter bits
FB12: u1 = 0,
/// FB13 [13:13]
/// Filter bits
FB13: u1 = 0,
/// FB14 [14:14]
/// Filter bits
FB14: u1 = 0,
/// FB15 [15:15]
/// Filter bits
FB15: u1 = 0,
/// FB16 [16:16]
/// Filter bits
FB16: u1 = 0,
/// FB17 [17:17]
/// Filter bits
FB17: u1 = 0,
/// FB18 [18:18]
/// Filter bits
FB18: u1 = 0,
/// FB19 [19:19]
/// Filter bits
FB19: u1 = 0,
/// FB20 [20:20]
/// Filter bits
FB20: u1 = 0,
/// FB21 [21:21]
/// Filter bits
FB21: u1 = 0,
/// FB22 [22:22]
/// Filter bits
FB22: u1 = 0,
/// FB23 [23:23]
/// Filter bits
FB23: u1 = 0,
/// FB24 [24:24]
/// Filter bits
FB24: u1 = 0,
/// FB25 [25:25]
/// Filter bits
FB25: u1 = 0,
/// FB26 [26:26]
/// Filter bits
FB26: u1 = 0,
/// FB27 [27:27]
/// Filter bits
FB27: u1 = 0,
/// FB28 [28:28]
/// Filter bits
FB28: u1 = 0,
/// FB29 [29:29]
/// Filter bits
FB29: u1 = 0,
/// FB30 [30:30]
/// Filter bits
FB30: u1 = 0,
/// FB31 [31:31]
/// Filter bits
FB31: u1 = 0,
};
/// Filter bank 0 register 1
pub const F0R1 = Register(F0R1_val).init(base_address + 0x240);

/// F0R2
const F0R2_val = packed struct {
/// FB0 [0:0]
/// Filter bits
FB0: u1 = 0,
/// FB1 [1:1]
/// Filter bits
FB1: u1 = 0,
/// FB2 [2:2]
/// Filter bits
FB2: u1 = 0,
/// FB3 [3:3]
/// Filter bits
FB3: u1 = 0,
/// FB4 [4:4]
/// Filter bits
FB4: u1 = 0,
/// FB5 [5:5]
/// Filter bits
FB5: u1 = 0,
/// FB6 [6:6]
/// Filter bits
FB6: u1 = 0,
/// FB7 [7:7]
/// Filter bits
FB7: u1 = 0,
/// FB8 [8:8]
/// Filter bits
FB8: u1 = 0,
/// FB9 [9:9]
/// Filter bits
FB9: u1 = 0,
/// FB10 [10:10]
/// Filter bits
FB10: u1 = 0,
/// FB11 [11:11]
/// Filter bits
FB11: u1 = 0,
/// FB12 [12:12]
/// Filter bits
FB12: u1 = 0,
/// FB13 [13:13]
/// Filter bits
FB13: u1 = 0,
/// FB14 [14:14]
/// Filter bits
FB14: u1 = 0,
/// FB15 [15:15]
/// Filter bits
FB15: u1 = 0,
/// FB16 [16:16]
/// Filter bits
FB16: u1 = 0,
/// FB17 [17:17]
/// Filter bits
FB17: u1 = 0,
/// FB18 [18:18]
/// Filter bits
FB18: u1 = 0,
/// FB19 [19:19]
/// Filter bits
FB19: u1 = 0,
/// FB20 [20:20]
/// Filter bits
FB20: u1 = 0,
/// FB21 [21:21]
/// Filter bits
FB21: u1 = 0,
/// FB22 [22:22]
/// Filter bits
FB22: u1 = 0,
/// FB23 [23:23]
/// Filter bits
FB23: u1 = 0,
/// FB24 [24:24]
/// Filter bits
FB24: u1 = 0,
/// FB25 [25:25]
/// Filter bits
FB25: u1 = 0,
/// FB26 [26:26]
/// Filter bits
FB26: u1 = 0,
/// FB27 [27:27]
/// Filter bits
FB27: u1 = 0,
/// FB28 [28:28]
/// Filter bits
FB28: u1 = 0,
/// FB29 [29:29]
/// Filter bits
FB29: u1 = 0,
/// FB30 [30:30]
/// Filter bits
FB30: u1 = 0,
/// FB31 [31:31]
/// Filter bits
FB31: u1 = 0,
};
/// Filter bank 0 register 2
pub const F0R2 = Register(F0R2_val).init(base_address + 0x244);

/// F1R1
const F1R1_val = packed struct {
/// FB0 [0:0]
/// Filter bits
FB0: u1 = 0,
/// FB1 [1:1]
/// Filter bits
FB1: u1 = 0,
/// FB2 [2:2]
/// Filter bits
FB2: u1 = 0,
/// FB3 [3:3]
/// Filter bits
FB3: u1 = 0,
/// FB4 [4:4]
/// Filter bits
FB4: u1 = 0,
/// FB5 [5:5]
/// Filter bits
FB5: u1 = 0,
/// FB6 [6:6]
/// Filter bits
FB6: u1 = 0,
/// FB7 [7:7]
/// Filter bits
FB7: u1 = 0,
/// FB8 [8:8]
/// Filter bits
FB8: u1 = 0,
/// FB9 [9:9]
/// Filter bits
FB9: u1 = 0,
/// FB10 [10:10]
/// Filter bits
FB10: u1 = 0,
/// FB11 [11:11]
/// Filter bits
FB11: u1 = 0,
/// FB12 [12:12]
/// Filter bits
FB12: u1 = 0,
/// FB13 [13:13]
/// Filter bits
FB13: u1 = 0,
/// FB14 [14:14]
/// Filter bits
FB14: u1 = 0,
/// FB15 [15:15]
/// Filter bits
FB15: u1 = 0,
/// FB16 [16:16]
/// Filter bits
FB16: u1 = 0,
/// FB17 [17:17]
/// Filter bits
FB17: u1 = 0,
/// FB18 [18:18]
/// Filter bits
FB18: u1 = 0,
/// FB19 [19:19]
/// Filter bits
FB19: u1 = 0,
/// FB20 [20:20]
/// Filter bits
FB20: u1 = 0,
/// FB21 [21:21]
/// Filter bits
FB21: u1 = 0,
/// FB22 [22:22]
/// Filter bits
FB22: u1 = 0,
/// FB23 [23:23]
/// Filter bits
FB23: u1 = 0,
/// FB24 [24:24]
/// Filter bits
FB24: u1 = 0,
/// FB25 [25:25]
/// Filter bits
FB25: u1 = 0,
/// FB26 [26:26]
/// Filter bits
FB26: u1 = 0,
/// FB27 [27:27]
/// Filter bits
FB27: u1 = 0,
/// FB28 [28:28]
/// Filter bits
FB28: u1 = 0,
/// FB29 [29:29]
/// Filter bits
FB29: u1 = 0,
/// FB30 [30:30]
/// Filter bits
FB30: u1 = 0,
/// FB31 [31:31]
/// Filter bits
FB31: u1 = 0,
};
/// Filter bank 1 register 1
pub const F1R1 = Register(F1R1_val).init(base_address + 0x248);

/// F1R2
const F1R2_val = packed struct {
/// FB0 [0:0]
/// Filter bits
FB0: u1 = 0,
/// FB1 [1:1]
/// Filter bits
FB1: u1 = 0,
/// FB2 [2:2]
/// Filter bits
FB2: u1 = 0,
/// FB3 [3:3]
/// Filter bits
FB3: u1 = 0,
/// FB4 [4:4]
/// Filter bits
FB4: u1 = 0,
/// FB5 [5:5]
/// Filter bits
FB5: u1 = 0,
/// FB6 [6:6]
/// Filter bits
FB6: u1 = 0,
/// FB7 [7:7]
/// Filter bits
FB7: u1 = 0,
/// FB8 [8:8]
/// Filter bits
FB8: u1 = 0,
/// FB9 [9:9]
/// Filter bits
FB9: u1 = 0,
/// FB10 [10:10]
/// Filter bits
FB10: u1 = 0,
/// FB11 [11:11]
/// Filter bits
FB11: u1 = 0,
/// FB12 [12:12]
/// Filter bits
FB12: u1 = 0,
/// FB13 [13:13]
/// Filter bits
FB13: u1 = 0,
/// FB14 [14:14]
/// Filter bits
FB14: u1 = 0,
/// FB15 [15:15]
/// Filter bits
FB15: u1 = 0,
/// FB16 [16:16]
/// Filter bits
FB16: u1 = 0,
/// FB17 [17:17]
/// Filter bits
FB17: u1 = 0,
/// FB18 [18:18]
/// Filter bits
FB18: u1 = 0,
/// FB19 [19:19]
/// Filter bits
FB19: u1 = 0,
/// FB20 [20:20]
/// Filter bits
FB20: u1 = 0,
/// FB21 [21:21]
/// Filter bits
FB21: u1 = 0,
/// FB22 [22:22]
/// Filter bits
FB22: u1 = 0,
/// FB23 [23:23]
/// Filter bits
FB23: u1 = 0,
/// FB24 [24:24]
/// Filter bits
FB24: u1 = 0,
/// FB25 [25:25]
/// Filter bits
FB25: u1 = 0,
/// FB26 [26:26]
/// Filter bits
FB26: u1 = 0,
/// FB27 [27:27]
/// Filter bits
FB27: u1 = 0,
/// FB28 [28:28]
/// Filter bits
FB28: u1 = 0,
/// FB29 [29:29]
/// Filter bits
FB29: u1 = 0,
/// FB30 [30:30]
/// Filter bits
FB30: u1 = 0,
/// FB31 [31:31]
/// Filter bits
FB31: u1 = 0,
};
/// Filter bank 1 register 2
pub const F1R2 = Register(F1R2_val).init(base_address + 0x24c);

/// F2R1
const F2R1_val = packed struct {
/// FB0 [0:0]
/// Filter bits
FB0: u1 = 0,
/// FB1 [1:1]
/// Filter bits
FB1: u1 = 0,
/// FB2 [2:2]
/// Filter bits
FB2: u1 = 0,
/// FB3 [3:3]
/// Filter bits
FB3: u1 = 0,
/// FB4 [4:4]
/// Filter bits
FB4: u1 = 0,
/// FB5 [5:5]
/// Filter bits
FB5: u1 = 0,
/// FB6 [6:6]
/// Filter bits
FB6: u1 = 0,
/// FB7 [7:7]
/// Filter bits
FB7: u1 = 0,
/// FB8 [8:8]
/// Filter bits
FB8: u1 = 0,
/// FB9 [9:9]
/// Filter bits
FB9: u1 = 0,
/// FB10 [10:10]
/// Filter bits
FB10: u1 = 0,
/// FB11 [11:11]
/// Filter bits
FB11: u1 = 0,
/// FB12 [12:12]
/// Filter bits
FB12: u1 = 0,
/// FB13 [13:13]
/// Filter bits
FB13: u1 = 0,
/// FB14 [14:14]
/// Filter bits
FB14: u1 = 0,
/// FB15 [15:15]
/// Filter bits
FB15: u1 = 0,
/// FB16 [16:16]
/// Filter bits
FB16: u1 = 0,
/// FB17 [17:17]
/// Filter bits
FB17: u1 = 0,
/// FB18 [18:18]
/// Filter bits
FB18: u1 = 0,
/// FB19 [19:19]
/// Filter bits
FB19: u1 = 0,
/// FB20 [20:20]
/// Filter bits
FB20: u1 = 0,
/// FB21 [21:21]
/// Filter bits
FB21: u1 = 0,
/// FB22 [22:22]
/// Filter bits
FB22: u1 = 0,
/// FB23 [23:23]
/// Filter bits
FB23: u1 = 0,
/// FB24 [24:24]
/// Filter bits
FB24: u1 = 0,
/// FB25 [25:25]
/// Filter bits
FB25: u1 = 0,
/// FB26 [26:26]
/// Filter bits
FB26: u1 = 0,
/// FB27 [27:27]
/// Filter bits
FB27: u1 = 0,
/// FB28 [28:28]
/// Filter bits
FB28: u1 = 0,
/// FB29 [29:29]
/// Filter bits
FB29: u1 = 0,
/// FB30 [30:30]
/// Filter bits
FB30: u1 = 0,
/// FB31 [31:31]
/// Filter bits
FB31: u1 = 0,
};
/// Filter bank 2 register 1
pub const F2R1 = Register(F2R1_val).init(base_address + 0x250);

/// F2R2
const F2R2_val = packed struct {
/// FB0 [0:0]
/// Filter bits
FB0: u1 = 0,
/// FB1 [1:1]
/// Filter bits
FB1: u1 = 0,
/// FB2 [2:2]
/// Filter bits
FB2: u1 = 0,
/// FB3 [3:3]
/// Filter bits
FB3: u1 = 0,
/// FB4 [4:4]
/// Filter bits
FB4: u1 = 0,
/// FB5 [5:5]
/// Filter bits
FB5: u1 = 0,
/// FB6 [6:6]
/// Filter bits
FB6: u1 = 0,
/// FB7 [7:7]
/// Filter bits
FB7: u1 = 0,
/// FB8 [8:8]
/// Filter bits
FB8: u1 = 0,
/// FB9 [9:9]
/// Filter bits
FB9: u1 = 0,
/// FB10 [10:10]
/// Filter bits
FB10: u1 = 0,
/// FB11 [11:11]
/// Filter bits
FB11: u1 = 0,
/// FB12 [12:12]
/// Filter bits
FB12: u1 = 0,
/// FB13 [13:13]
/// Filter bits
FB13: u1 = 0,
/// FB14 [14:14]
/// Filter bits
FB14: u1 = 0,
/// FB15 [15:15]
/// Filter bits
FB15: u1 = 0,
/// FB16 [16:16]
/// Filter bits
FB16: u1 = 0,
/// FB17 [17:17]
/// Filter bits
FB17: u1 = 0,
/// FB18 [18:18]
/// Filter bits
FB18: u1 = 0,
/// FB19 [19:19]
/// Filter bits
FB19: u1 = 0,
/// FB20 [20:20]
/// Filter bits
FB20: u1 = 0,
/// FB21 [21:21]
/// Filter bits
FB21: u1 = 0,
/// FB22 [22:22]
/// Filter bits
FB22: u1 = 0,
/// FB23 [23:23]
/// Filter bits
FB23: u1 = 0,
/// FB24 [24:24]
/// Filter bits
FB24: u1 = 0,
/// FB25 [25:25]
/// Filter bits
FB25: u1 = 0,
/// FB26 [26:26]
/// Filter bits
FB26: u1 = 0,
/// FB27 [27:27]
/// Filter bits
FB27: u1 = 0,
/// FB28 [28:28]
/// Filter bits
FB28: u1 = 0,
/// FB29 [29:29]
/// Filter bits
FB29: u1 = 0,
/// FB30 [30:30]
/// Filter bits
FB30: u1 = 0,
/// FB31 [31:31]
/// Filter bits
FB31: u1 = 0,
};
/// Filter bank 2 register 2
pub const F2R2 = Register(F2R2_val).init(base_address + 0x254);

/// F3R1
const F3R1_val = packed struct {
/// FB0 [0:0]
/// Filter bits
FB0: u1 = 0,
/// FB1 [1:1]
/// Filter bits
FB1: u1 = 0,
/// FB2 [2:2]
/// Filter bits
FB2: u1 = 0,
/// FB3 [3:3]
/// Filter bits
FB3: u1 = 0,
/// FB4 [4:4]
/// Filter bits
FB4: u1 = 0,
/// FB5 [5:5]
/// Filter bits
FB5: u1 = 0,
/// FB6 [6:6]
/// Filter bits
FB6: u1 = 0,
/// FB7 [7:7]
/// Filter bits
FB7: u1 = 0,
/// FB8 [8:8]
/// Filter bits
FB8: u1 = 0,
/// FB9 [9:9]
/// Filter bits
FB9: u1 = 0,
/// FB10 [10:10]
/// Filter bits
FB10: u1 = 0,
/// FB11 [11:11]
/// Filter bits
FB11: u1 = 0,
/// FB12 [12:12]
/// Filter bits
FB12: u1 = 0,
/// FB13 [13:13]
/// Filter bits
FB13: u1 = 0,
/// FB14 [14:14]
/// Filter bits
FB14: u1 = 0,
/// FB15 [15:15]
/// Filter bits
FB15: u1 = 0,
/// FB16 [16:16]
/// Filter bits
FB16: u1 = 0,
/// FB17 [17:17]
/// Filter bits
FB17: u1 = 0,
/// FB18 [18:18]
/// Filter bits
FB18: u1 = 0,
/// FB19 [19:19]
/// Filter bits
FB19: u1 = 0,
/// FB20 [20:20]
/// Filter bits
FB20: u1 = 0,
/// FB21 [21:21]
/// Filter bits
FB21: u1 = 0,
/// FB22 [22:22]
/// Filter bits
FB22: u1 = 0,
/// FB23 [23:23]
/// Filter bits
FB23: u1 = 0,
/// FB24 [24:24]
/// Filter bits
FB24: u1 = 0,
/// FB25 [25:25]
/// Filter bits
FB25: u1 = 0,
/// FB26 [26:26]
/// Filter bits
FB26: u1 = 0,
/// FB27 [27:27]
/// Filter bits
FB27: u1 = 0,
/// FB28 [28:28]
/// Filter bits
FB28: u1 = 0,
/// FB29 [29:29]
/// Filter bits
FB29: u1 = 0,
/// FB30 [30:30]
/// Filter bits
FB30: u1 = 0,
/// FB31 [31:31]
/// Filter bits
FB31: u1 = 0,
};
/// Filter bank 3 register 1
pub const F3R1 = Register(F3R1_val).init(base_address + 0x258);

/// F3R2
const F3R2_val = packed struct {
/// FB0 [0:0]
/// Filter bits
FB0: u1 = 0,
/// FB1 [1:1]
/// Filter bits
FB1: u1 = 0,
/// FB2 [2:2]
/// Filter bits
FB2: u1 = 0,
/// FB3 [3:3]
/// Filter bits
FB3: u1 = 0,
/// FB4 [4:4]
/// Filter bits
FB4: u1 = 0,
/// FB5 [5:5]
/// Filter bits
FB5: u1 = 0,
/// FB6 [6:6]
/// Filter bits
FB6: u1 = 0,
/// FB7 [7:7]
/// Filter bits
FB7: u1 = 0,
/// FB8 [8:8]
/// Filter bits
FB8: u1 = 0,
/// FB9 [9:9]
/// Filter bits
FB9: u1 = 0,
/// FB10 [10:10]
/// Filter bits
FB10: u1 = 0,
/// FB11 [11:11]
/// Filter bits
FB11: u1 = 0,
/// FB12 [12:12]
/// Filter bits
FB12: u1 = 0,
/// FB13 [13:13]
/// Filter bits
FB13: u1 = 0,
/// FB14 [14:14]
/// Filter bits
FB14: u1 = 0,
/// FB15 [15:15]
/// Filter bits
FB15: u1 = 0,
/// FB16 [16:16]
/// Filter bits
FB16: u1 = 0,
/// FB17 [17:17]
/// Filter bits
FB17: u1 = 0,
/// FB18 [18:18]
/// Filter bits
FB18: u1 = 0,
/// FB19 [19:19]
/// Filter bits
FB19: u1 = 0,
/// FB20 [20:20]
/// Filter bits
FB20: u1 = 0,
/// FB21 [21:21]
/// Filter bits
FB21: u1 = 0,
/// FB22 [22:22]
/// Filter bits
FB22: u1 = 0,
/// FB23 [23:23]
/// Filter bits
FB23: u1 = 0,
/// FB24 [24:24]
/// Filter bits
FB24: u1 = 0,
/// FB25 [25:25]
/// Filter bits
FB25: u1 = 0,
/// FB26 [26:26]
/// Filter bits
FB26: u1 = 0,
/// FB27 [27:27]
/// Filter bits
FB27: u1 = 0,
/// FB28 [28:28]
/// Filter bits
FB28: u1 = 0,
/// FB29 [29:29]
/// Filter bits
FB29: u1 = 0,
/// FB30 [30:30]
/// Filter bits
FB30: u1 = 0,
/// FB31 [31:31]
/// Filter bits
FB31: u1 = 0,
};
/// Filter bank 3 register 2
pub const F3R2 = Register(F3R2_val).init(base_address + 0x25c);

/// F4R1
const F4R1_val = packed struct {
/// FB0 [0:0]
/// Filter bits
FB0: u1 = 0,
/// FB1 [1:1]
/// Filter bits
FB1: u1 = 0,
/// FB2 [2:2]
/// Filter bits
FB2: u1 = 0,
/// FB3 [3:3]
/// Filter bits
FB3: u1 = 0,
/// FB4 [4:4]
/// Filter bits
FB4: u1 = 0,
/// FB5 [5:5]
/// Filter bits
FB5: u1 = 0,
/// FB6 [6:6]
/// Filter bits
FB6: u1 = 0,
/// FB7 [7:7]
/// Filter bits
FB7: u1 = 0,
/// FB8 [8:8]
/// Filter bits
FB8: u1 = 0,
/// FB9 [9:9]
/// Filter bits
FB9: u1 = 0,
/// FB10 [10:10]
/// Filter bits
FB10: u1 = 0,
/// FB11 [11:11]
/// Filter bits
FB11: u1 = 0,
/// FB12 [12:12]
/// Filter bits
FB12: u1 = 0,
/// FB13 [13:13]
/// Filter bits
FB13: u1 = 0,
/// FB14 [14:14]
/// Filter bits
FB14: u1 = 0,
/// FB15 [15:15]
/// Filter bits
FB15: u1 = 0,
/// FB16 [16:16]
/// Filter bits
FB16: u1 = 0,
/// FB17 [17:17]
/// Filter bits
FB17: u1 = 0,
/// FB18 [18:18]
/// Filter bits
FB18: u1 = 0,
/// FB19 [19:19]
/// Filter bits
FB19: u1 = 0,
/// FB20 [20:20]
/// Filter bits
FB20: u1 = 0,
/// FB21 [21:21]
/// Filter bits
FB21: u1 = 0,
/// FB22 [22:22]
/// Filter bits
FB22: u1 = 0,
/// FB23 [23:23]
/// Filter bits
FB23: u1 = 0,
/// FB24 [24:24]
/// Filter bits
FB24: u1 = 0,
/// FB25 [25:25]
/// Filter bits
FB25: u1 = 0,
/// FB26 [26:26]
/// Filter bits
FB26: u1 = 0,
/// FB27 [27:27]
/// Filter bits
FB27: u1 = 0,
/// FB28 [28:28]
/// Filter bits
FB28: u1 = 0,
/// FB29 [29:29]
/// Filter bits
FB29: u1 = 0,
/// FB30 [30:30]
/// Filter bits
FB30: u1 = 0,
/// FB31 [31:31]
/// Filter bits
FB31: u1 = 0,
};
/// Filter bank 4 register 1
pub const F4R1 = Register(F4R1_val).init(base_address + 0x260);

/// F4R2
const F4R2_val = packed struct {
/// FB0 [0:0]
/// Filter bits
FB0: u1 = 0,
/// FB1 [1:1]
/// Filter bits
FB1: u1 = 0,
/// FB2 [2:2]
/// Filter bits
FB2: u1 = 0,
/// FB3 [3:3]
/// Filter bits
FB3: u1 = 0,
/// FB4 [4:4]
/// Filter bits
FB4: u1 = 0,
/// FB5 [5:5]
/// Filter bits
FB5: u1 = 0,
/// FB6 [6:6]
/// Filter bits
FB6: u1 = 0,
/// FB7 [7:7]
/// Filter bits
FB7: u1 = 0,
/// FB8 [8:8]
/// Filter bits
FB8: u1 = 0,
/// FB9 [9:9]
/// Filter bits
FB9: u1 = 0,
/// FB10 [10:10]
/// Filter bits
FB10: u1 = 0,
/// FB11 [11:11]
/// Filter bits
FB11: u1 = 0,
/// FB12 [12:12]
/// Filter bits
FB12: u1 = 0,
/// FB13 [13:13]
/// Filter bits
FB13: u1 = 0,
/// FB14 [14:14]
/// Filter bits
FB14: u1 = 0,
/// FB15 [15:15]
/// Filter bits
FB15: u1 = 0,
/// FB16 [16:16]
/// Filter bits
FB16: u1 = 0,
/// FB17 [17:17]
/// Filter bits
FB17: u1 = 0,
/// FB18 [18:18]
/// Filter bits
FB18: u1 = 0,
/// FB19 [19:19]
/// Filter bits
FB19: u1 = 0,
/// FB20 [20:20]
/// Filter bits
FB20: u1 = 0,
/// FB21 [21:21]
/// Filter bits
FB21: u1 = 0,
/// FB22 [22:22]
/// Filter bits
FB22: u1 = 0,
/// FB23 [23:23]
/// Filter bits
FB23: u1 = 0,
/// FB24 [24:24]
/// Filter bits
FB24: u1 = 0,
/// FB25 [25:25]
/// Filter bits
FB25: u1 = 0,
/// FB26 [26:26]
/// Filter bits
FB26: u1 = 0,
/// FB27 [27:27]
/// Filter bits
FB27: u1 = 0,
/// FB28 [28:28]
/// Filter bits
FB28: u1 = 0,
/// FB29 [29:29]
/// Filter bits
FB29: u1 = 0,
/// FB30 [30:30]
/// Filter bits
FB30: u1 = 0,
/// FB31 [31:31]
/// Filter bits
FB31: u1 = 0,
};
/// Filter bank 4 register 2
pub const F4R2 = Register(F4R2_val).init(base_address + 0x264);

/// F5R1
const F5R1_val = packed struct {
/// FB0 [0:0]
/// Filter bits
FB0: u1 = 0,
/// FB1 [1:1]
/// Filter bits
FB1: u1 = 0,
/// FB2 [2:2]
/// Filter bits
FB2: u1 = 0,
/// FB3 [3:3]
/// Filter bits
FB3: u1 = 0,
/// FB4 [4:4]
/// Filter bits
FB4: u1 = 0,
/// FB5 [5:5]
/// Filter bits
FB5: u1 = 0,
/// FB6 [6:6]
/// Filter bits
FB6: u1 = 0,
/// FB7 [7:7]
/// Filter bits
FB7: u1 = 0,
/// FB8 [8:8]
/// Filter bits
FB8: u1 = 0,
/// FB9 [9:9]
/// Filter bits
FB9: u1 = 0,
/// FB10 [10:10]
/// Filter bits
FB10: u1 = 0,
/// FB11 [11:11]
/// Filter bits
FB11: u1 = 0,
/// FB12 [12:12]
/// Filter bits
FB12: u1 = 0,
/// FB13 [13:13]
/// Filter bits
FB13: u1 = 0,
/// FB14 [14:14]
/// Filter bits
FB14: u1 = 0,
/// FB15 [15:15]
/// Filter bits
FB15: u1 = 0,
/// FB16 [16:16]
/// Filter bits
FB16: u1 = 0,
/// FB17 [17:17]
/// Filter bits
FB17: u1 = 0,
/// FB18 [18:18]
/// Filter bits
FB18: u1 = 0,
/// FB19 [19:19]
/// Filter bits
FB19: u1 = 0,
/// FB20 [20:20]
/// Filter bits
FB20: u1 = 0,
/// FB21 [21:21]
/// Filter bits
FB21: u1 = 0,
/// FB22 [22:22]
/// Filter bits
FB22: u1 = 0,
/// FB23 [23:23]
/// Filter bits
FB23: u1 = 0,
/// FB24 [24:24]
/// Filter bits
FB24: u1 = 0,
/// FB25 [25:25]
/// Filter bits
FB25: u1 = 0,
/// FB26 [26:26]
/// Filter bits
FB26: u1 = 0,
/// FB27 [27:27]
/// Filter bits
FB27: u1 = 0,
/// FB28 [28:28]
/// Filter bits
FB28: u1 = 0,
/// FB29 [29:29]
/// Filter bits
FB29: u1 = 0,
/// FB30 [30:30]
/// Filter bits
FB30: u1 = 0,
/// FB31 [31:31]
/// Filter bits
FB31: u1 = 0,
};
/// Filter bank 5 register 1
pub const F5R1 = Register(F5R1_val).init(base_address + 0x268);

/// F5R2
const F5R2_val = packed struct {
/// FB0 [0:0]
/// Filter bits
FB0: u1 = 0,
/// FB1 [1:1]
/// Filter bits
FB1: u1 = 0,
/// FB2 [2:2]
/// Filter bits
FB2: u1 = 0,
/// FB3 [3:3]
/// Filter bits
FB3: u1 = 0,
/// FB4 [4:4]
/// Filter bits
FB4: u1 = 0,
/// FB5 [5:5]
/// Filter bits
FB5: u1 = 0,
/// FB6 [6:6]
/// Filter bits
FB6: u1 = 0,
/// FB7 [7:7]
/// Filter bits
FB7: u1 = 0,
/// FB8 [8:8]
/// Filter bits
FB8: u1 = 0,
/// FB9 [9:9]
/// Filter bits
FB9: u1 = 0,
/// FB10 [10:10]
/// Filter bits
FB10: u1 = 0,
/// FB11 [11:11]
/// Filter bits
FB11: u1 = 0,
/// FB12 [12:12]
/// Filter bits
FB12: u1 = 0,
/// FB13 [13:13]
/// Filter bits
FB13: u1 = 0,
/// FB14 [14:14]
/// Filter bits
FB14: u1 = 0,
/// FB15 [15:15]
/// Filter bits
FB15: u1 = 0,
/// FB16 [16:16]
/// Filter bits
FB16: u1 = 0,
/// FB17 [17:17]
/// Filter bits
FB17: u1 = 0,
/// FB18 [18:18]
/// Filter bits
FB18: u1 = 0,
/// FB19 [19:19]
/// Filter bits
FB19: u1 = 0,
/// FB20 [20:20]
/// Filter bits
FB20: u1 = 0,
/// FB21 [21:21]
/// Filter bits
FB21: u1 = 0,
/// FB22 [22:22]
/// Filter bits
FB22: u1 = 0,
/// FB23 [23:23]
/// Filter bits
FB23: u1 = 0,
/// FB24 [24:24]
/// Filter bits
FB24: u1 = 0,
/// FB25 [25:25]
/// Filter bits
FB25: u1 = 0,
/// FB26 [26:26]
/// Filter bits
FB26: u1 = 0,
/// FB27 [27:27]
/// Filter bits
FB27: u1 = 0,
/// FB28 [28:28]
/// Filter bits
FB28: u1 = 0,
/// FB29 [29:29]
/// Filter bits
FB29: u1 = 0,
/// FB30 [30:30]
/// Filter bits
FB30: u1 = 0,
/// FB31 [31:31]
/// Filter bits
FB31: u1 = 0,
};
/// Filter bank 5 register 2
pub const F5R2 = Register(F5R2_val).init(base_address + 0x26c);

/// F6R1
const F6R1_val = packed struct {
/// FB0 [0:0]
/// Filter bits
FB0: u1 = 0,
/// FB1 [1:1]
/// Filter bits
FB1: u1 = 0,
/// FB2 [2:2]
/// Filter bits
FB2: u1 = 0,
/// FB3 [3:3]
/// Filter bits
FB3: u1 = 0,
/// FB4 [4:4]
/// Filter bits
FB4: u1 = 0,
/// FB5 [5:5]
/// Filter bits
FB5: u1 = 0,
/// FB6 [6:6]
/// Filter bits
FB6: u1 = 0,
/// FB7 [7:7]
/// Filter bits
FB7: u1 = 0,
/// FB8 [8:8]
/// Filter bits
FB8: u1 = 0,
/// FB9 [9:9]
/// Filter bits
FB9: u1 = 0,
/// FB10 [10:10]
/// Filter bits
FB10: u1 = 0,
/// FB11 [11:11]
/// Filter bits
FB11: u1 = 0,
/// FB12 [12:12]
/// Filter bits
FB12: u1 = 0,
/// FB13 [13:13]
/// Filter bits
FB13: u1 = 0,
/// FB14 [14:14]
/// Filter bits
FB14: u1 = 0,
/// FB15 [15:15]
/// Filter bits
FB15: u1 = 0,
/// FB16 [16:16]
/// Filter bits
FB16: u1 = 0,
/// FB17 [17:17]
/// Filter bits
FB17: u1 = 0,
/// FB18 [18:18]
/// Filter bits
FB18: u1 = 0,
/// FB19 [19:19]
/// Filter bits
FB19: u1 = 0,
/// FB20 [20:20]
/// Filter bits
FB20: u1 = 0,
/// FB21 [21:21]
/// Filter bits
FB21: u1 = 0,
/// FB22 [22:22]
/// Filter bits
FB22: u1 = 0,
/// FB23 [23:23]
/// Filter bits
FB23: u1 = 0,
/// FB24 [24:24]
/// Filter bits
FB24: u1 = 0,
/// FB25 [25:25]
/// Filter bits
FB25: u1 = 0,
/// FB26 [26:26]
/// Filter bits
FB26: u1 = 0,
/// FB27 [27:27]
/// Filter bits
FB27: u1 = 0,
/// FB28 [28:28]
/// Filter bits
FB28: u1 = 0,
/// FB29 [29:29]
/// Filter bits
FB29: u1 = 0,
/// FB30 [30:30]
/// Filter bits
FB30: u1 = 0,
/// FB31 [31:31]
/// Filter bits
FB31: u1 = 0,
};
/// Filter bank 6 register 1
pub const F6R1 = Register(F6R1_val).init(base_address + 0x270);

/// F6R2
const F6R2_val = packed struct {
/// FB0 [0:0]
/// Filter bits
FB0: u1 = 0,
/// FB1 [1:1]
/// Filter bits
FB1: u1 = 0,
/// FB2 [2:2]
/// Filter bits
FB2: u1 = 0,
/// FB3 [3:3]
/// Filter bits
FB3: u1 = 0,
/// FB4 [4:4]
/// Filter bits
FB4: u1 = 0,
/// FB5 [5:5]
/// Filter bits
FB5: u1 = 0,
/// FB6 [6:6]
/// Filter bits
FB6: u1 = 0,
/// FB7 [7:7]
/// Filter bits
FB7: u1 = 0,
/// FB8 [8:8]
/// Filter bits
FB8: u1 = 0,
/// FB9 [9:9]
/// Filter bits
FB9: u1 = 0,
/// FB10 [10:10]
/// Filter bits
FB10: u1 = 0,
/// FB11 [11:11]
/// Filter bits
FB11: u1 = 0,
/// FB12 [12:12]
/// Filter bits
FB12: u1 = 0,
/// FB13 [13:13]
/// Filter bits
FB13: u1 = 0,
/// FB14 [14:14]
/// Filter bits
FB14: u1 = 0,
/// FB15 [15:15]
/// Filter bits
FB15: u1 = 0,
/// FB16 [16:16]
/// Filter bits
FB16: u1 = 0,
/// FB17 [17:17]
/// Filter bits
FB17: u1 = 0,
/// FB18 [18:18]
/// Filter bits
FB18: u1 = 0,
/// FB19 [19:19]
/// Filter bits
FB19: u1 = 0,
/// FB20 [20:20]
/// Filter bits
FB20: u1 = 0,
/// FB21 [21:21]
/// Filter bits
FB21: u1 = 0,
/// FB22 [22:22]
/// Filter bits
FB22: u1 = 0,
/// FB23 [23:23]
/// Filter bits
FB23: u1 = 0,
/// FB24 [24:24]
/// Filter bits
FB24: u1 = 0,
/// FB25 [25:25]
/// Filter bits
FB25: u1 = 0,
/// FB26 [26:26]
/// Filter bits
FB26: u1 = 0,
/// FB27 [27:27]
/// Filter bits
FB27: u1 = 0,
/// FB28 [28:28]
/// Filter bits
FB28: u1 = 0,
/// FB29 [29:29]
/// Filter bits
FB29: u1 = 0,
/// FB30 [30:30]
/// Filter bits
FB30: u1 = 0,
/// FB31 [31:31]
/// Filter bits
FB31: u1 = 0,
};
/// Filter bank 6 register 2
pub const F6R2 = Register(F6R2_val).init(base_address + 0x274);

/// F7R1
const F7R1_val = packed struct {
/// FB0 [0:0]
/// Filter bits
FB0: u1 = 0,
/// FB1 [1:1]
/// Filter bits
FB1: u1 = 0,
/// FB2 [2:2]
/// Filter bits
FB2: u1 = 0,
/// FB3 [3:3]
/// Filter bits
FB3: u1 = 0,
/// FB4 [4:4]
/// Filter bits
FB4: u1 = 0,
/// FB5 [5:5]
/// Filter bits
FB5: u1 = 0,
/// FB6 [6:6]
/// Filter bits
FB6: u1 = 0,
/// FB7 [7:7]
/// Filter bits
FB7: u1 = 0,
/// FB8 [8:8]
/// Filter bits
FB8: u1 = 0,
/// FB9 [9:9]
/// Filter bits
FB9: u1 = 0,
/// FB10 [10:10]
/// Filter bits
FB10: u1 = 0,
/// FB11 [11:11]
/// Filter bits
FB11: u1 = 0,
/// FB12 [12:12]
/// Filter bits
FB12: u1 = 0,
/// FB13 [13:13]
/// Filter bits
FB13: u1 = 0,
/// FB14 [14:14]
/// Filter bits
FB14: u1 = 0,
/// FB15 [15:15]
/// Filter bits
FB15: u1 = 0,
/// FB16 [16:16]
/// Filter bits
FB16: u1 = 0,
/// FB17 [17:17]
/// Filter bits
FB17: u1 = 0,
/// FB18 [18:18]
/// Filter bits
FB18: u1 = 0,
/// FB19 [19:19]
/// Filter bits
FB19: u1 = 0,
/// FB20 [20:20]
/// Filter bits
FB20: u1 = 0,
/// FB21 [21:21]
/// Filter bits
FB21: u1 = 0,
/// FB22 [22:22]
/// Filter bits
FB22: u1 = 0,
/// FB23 [23:23]
/// Filter bits
FB23: u1 = 0,
/// FB24 [24:24]
/// Filter bits
FB24: u1 = 0,
/// FB25 [25:25]
/// Filter bits
FB25: u1 = 0,
/// FB26 [26:26]
/// Filter bits
FB26: u1 = 0,
/// FB27 [27:27]
/// Filter bits
FB27: u1 = 0,
/// FB28 [28:28]
/// Filter bits
FB28: u1 = 0,
/// FB29 [29:29]
/// Filter bits
FB29: u1 = 0,
/// FB30 [30:30]
/// Filter bits
FB30: u1 = 0,
/// FB31 [31:31]
/// Filter bits
FB31: u1 = 0,
};
/// Filter bank 7 register 1
pub const F7R1 = Register(F7R1_val).init(base_address + 0x278);

/// F7R2
const F7R2_val = packed struct {
/// FB0 [0:0]
/// Filter bits
FB0: u1 = 0,
/// FB1 [1:1]
/// Filter bits
FB1: u1 = 0,
/// FB2 [2:2]
/// Filter bits
FB2: u1 = 0,
/// FB3 [3:3]
/// Filter bits
FB3: u1 = 0,
/// FB4 [4:4]
/// Filter bits
FB4: u1 = 0,
/// FB5 [5:5]
/// Filter bits
FB5: u1 = 0,
/// FB6 [6:6]
/// Filter bits
FB6: u1 = 0,
/// FB7 [7:7]
/// Filter bits
FB7: u1 = 0,
/// FB8 [8:8]
/// Filter bits
FB8: u1 = 0,
/// FB9 [9:9]
/// Filter bits
FB9: u1 = 0,
/// FB10 [10:10]
/// Filter bits
FB10: u1 = 0,
/// FB11 [11:11]
/// Filter bits
FB11: u1 = 0,
/// FB12 [12:12]
/// Filter bits
FB12: u1 = 0,
/// FB13 [13:13]
/// Filter bits
FB13: u1 = 0,
/// FB14 [14:14]
/// Filter bits
FB14: u1 = 0,
/// FB15 [15:15]
/// Filter bits
FB15: u1 = 0,
/// FB16 [16:16]
/// Filter bits
FB16: u1 = 0,
/// FB17 [17:17]
/// Filter bits
FB17: u1 = 0,
/// FB18 [18:18]
/// Filter bits
FB18: u1 = 0,
/// FB19 [19:19]
/// Filter bits
FB19: u1 = 0,
/// FB20 [20:20]
/// Filter bits
FB20: u1 = 0,
/// FB21 [21:21]
/// Filter bits
FB21: u1 = 0,
/// FB22 [22:22]
/// Filter bits
FB22: u1 = 0,
/// FB23 [23:23]
/// Filter bits
FB23: u1 = 0,
/// FB24 [24:24]
/// Filter bits
FB24: u1 = 0,
/// FB25 [25:25]
/// Filter bits
FB25: u1 = 0,
/// FB26 [26:26]
/// Filter bits
FB26: u1 = 0,
/// FB27 [27:27]
/// Filter bits
FB27: u1 = 0,
/// FB28 [28:28]
/// Filter bits
FB28: u1 = 0,
/// FB29 [29:29]
/// Filter bits
FB29: u1 = 0,
/// FB30 [30:30]
/// Filter bits
FB30: u1 = 0,
/// FB31 [31:31]
/// Filter bits
FB31: u1 = 0,
};
/// Filter bank 7 register 2
pub const F7R2 = Register(F7R2_val).init(base_address + 0x27c);

/// F8R1
const F8R1_val = packed struct {
/// FB0 [0:0]
/// Filter bits
FB0: u1 = 0,
/// FB1 [1:1]
/// Filter bits
FB1: u1 = 0,
/// FB2 [2:2]
/// Filter bits
FB2: u1 = 0,
/// FB3 [3:3]
/// Filter bits
FB3: u1 = 0,
/// FB4 [4:4]
/// Filter bits
FB4: u1 = 0,
/// FB5 [5:5]
/// Filter bits
FB5: u1 = 0,
/// FB6 [6:6]
/// Filter bits
FB6: u1 = 0,
/// FB7 [7:7]
/// Filter bits
FB7: u1 = 0,
/// FB8 [8:8]
/// Filter bits
FB8: u1 = 0,
/// FB9 [9:9]
/// Filter bits
FB9: u1 = 0,
/// FB10 [10:10]
/// Filter bits
FB10: u1 = 0,
/// FB11 [11:11]
/// Filter bits
FB11: u1 = 0,
/// FB12 [12:12]
/// Filter bits
FB12: u1 = 0,
/// FB13 [13:13]
/// Filter bits
FB13: u1 = 0,
/// FB14 [14:14]
/// Filter bits
FB14: u1 = 0,
/// FB15 [15:15]
/// Filter bits
FB15: u1 = 0,
/// FB16 [16:16]
/// Filter bits
FB16: u1 = 0,
/// FB17 [17:17]
/// Filter bits
FB17: u1 = 0,
/// FB18 [18:18]
/// Filter bits
FB18: u1 = 0,
/// FB19 [19:19]
/// Filter bits
FB19: u1 = 0,
/// FB20 [20:20]
/// Filter bits
FB20: u1 = 0,
/// FB21 [21:21]
/// Filter bits
FB21: u1 = 0,
/// FB22 [22:22]
/// Filter bits
FB22: u1 = 0,
/// FB23 [23:23]
/// Filter bits
FB23: u1 = 0,
/// FB24 [24:24]
/// Filter bits
FB24: u1 = 0,
/// FB25 [25:25]
/// Filter bits
FB25: u1 = 0,
/// FB26 [26:26]
/// Filter bits
FB26: u1 = 0,
/// FB27 [27:27]
/// Filter bits
FB27: u1 = 0,
/// FB28 [28:28]
/// Filter bits
FB28: u1 = 0,
/// FB29 [29:29]
/// Filter bits
FB29: u1 = 0,
/// FB30 [30:30]
/// Filter bits
FB30: u1 = 0,
/// FB31 [31:31]
/// Filter bits
FB31: u1 = 0,
};
/// Filter bank 8 register 1
pub const F8R1 = Register(F8R1_val).init(base_address + 0x280);

/// F8R2
const F8R2_val = packed struct {
/// FB0 [0:0]
/// Filter bits
FB0: u1 = 0,
/// FB1 [1:1]
/// Filter bits
FB1: u1 = 0,
/// FB2 [2:2]
/// Filter bits
FB2: u1 = 0,
/// FB3 [3:3]
/// Filter bits
FB3: u1 = 0,
/// FB4 [4:4]
/// Filter bits
FB4: u1 = 0,
/// FB5 [5:5]
/// Filter bits
FB5: u1 = 0,
/// FB6 [6:6]
/// Filter bits
FB6: u1 = 0,
/// FB7 [7:7]
/// Filter bits
FB7: u1 = 0,
/// FB8 [8:8]
/// Filter bits
FB8: u1 = 0,
/// FB9 [9:9]
/// Filter bits
FB9: u1 = 0,
/// FB10 [10:10]
/// Filter bits
FB10: u1 = 0,
/// FB11 [11:11]
/// Filter bits
FB11: u1 = 0,
/// FB12 [12:12]
/// Filter bits
FB12: u1 = 0,
/// FB13 [13:13]
/// Filter bits
FB13: u1 = 0,
/// FB14 [14:14]
/// Filter bits
FB14: u1 = 0,
/// FB15 [15:15]
/// Filter bits
FB15: u1 = 0,
/// FB16 [16:16]
/// Filter bits
FB16: u1 = 0,
/// FB17 [17:17]
/// Filter bits
FB17: u1 = 0,
/// FB18 [18:18]
/// Filter bits
FB18: u1 = 0,
/// FB19 [19:19]
/// Filter bits
FB19: u1 = 0,
/// FB20 [20:20]
/// Filter bits
FB20: u1 = 0,
/// FB21 [21:21]
/// Filter bits
FB21: u1 = 0,
/// FB22 [22:22]
/// Filter bits
FB22: u1 = 0,
/// FB23 [23:23]
/// Filter bits
FB23: u1 = 0,
/// FB24 [24:24]
/// Filter bits
FB24: u1 = 0,
/// FB25 [25:25]
/// Filter bits
FB25: u1 = 0,
/// FB26 [26:26]
/// Filter bits
FB26: u1 = 0,
/// FB27 [27:27]
/// Filter bits
FB27: u1 = 0,
/// FB28 [28:28]
/// Filter bits
FB28: u1 = 0,
/// FB29 [29:29]
/// Filter bits
FB29: u1 = 0,
/// FB30 [30:30]
/// Filter bits
FB30: u1 = 0,
/// FB31 [31:31]
/// Filter bits
FB31: u1 = 0,
};
/// Filter bank 8 register 2
pub const F8R2 = Register(F8R2_val).init(base_address + 0x284);

/// F9R1
const F9R1_val = packed struct {
/// FB0 [0:0]
/// Filter bits
FB0: u1 = 0,
/// FB1 [1:1]
/// Filter bits
FB1: u1 = 0,
/// FB2 [2:2]
/// Filter bits
FB2: u1 = 0,
/// FB3 [3:3]
/// Filter bits
FB3: u1 = 0,
/// FB4 [4:4]
/// Filter bits
FB4: u1 = 0,
/// FB5 [5:5]
/// Filter bits
FB5: u1 = 0,
/// FB6 [6:6]
/// Filter bits
FB6: u1 = 0,
/// FB7 [7:7]
/// Filter bits
FB7: u1 = 0,
/// FB8 [8:8]
/// Filter bits
FB8: u1 = 0,
/// FB9 [9:9]
/// Filter bits
FB9: u1 = 0,
/// FB10 [10:10]
/// Filter bits
FB10: u1 = 0,
/// FB11 [11:11]
/// Filter bits
FB11: u1 = 0,
/// FB12 [12:12]
/// Filter bits
FB12: u1 = 0,
/// FB13 [13:13]
/// Filter bits
FB13: u1 = 0,
/// FB14 [14:14]
/// Filter bits
FB14: u1 = 0,
/// FB15 [15:15]
/// Filter bits
FB15: u1 = 0,
/// FB16 [16:16]
/// Filter bits
FB16: u1 = 0,
/// FB17 [17:17]
/// Filter bits
FB17: u1 = 0,
/// FB18 [18:18]
/// Filter bits
FB18: u1 = 0,
/// FB19 [19:19]
/// Filter bits
FB19: u1 = 0,
/// FB20 [20:20]
/// Filter bits
FB20: u1 = 0,
/// FB21 [21:21]
/// Filter bits
FB21: u1 = 0,
/// FB22 [22:22]
/// Filter bits
FB22: u1 = 0,
/// FB23 [23:23]
/// Filter bits
FB23: u1 = 0,
/// FB24 [24:24]
/// Filter bits
FB24: u1 = 0,
/// FB25 [25:25]
/// Filter bits
FB25: u1 = 0,
/// FB26 [26:26]
/// Filter bits
FB26: u1 = 0,
/// FB27 [27:27]
/// Filter bits
FB27: u1 = 0,
/// FB28 [28:28]
/// Filter bits
FB28: u1 = 0,
/// FB29 [29:29]
/// Filter bits
FB29: u1 = 0,
/// FB30 [30:30]
/// Filter bits
FB30: u1 = 0,
/// FB31 [31:31]
/// Filter bits
FB31: u1 = 0,
};
/// Filter bank 9 register 1
pub const F9R1 = Register(F9R1_val).init(base_address + 0x288);

/// F9R2
const F9R2_val = packed struct {
/// FB0 [0:0]
/// Filter bits
FB0: u1 = 0,
/// FB1 [1:1]
/// Filter bits
FB1: u1 = 0,
/// FB2 [2:2]
/// Filter bits
FB2: u1 = 0,
/// FB3 [3:3]
/// Filter bits
FB3: u1 = 0,
/// FB4 [4:4]
/// Filter bits
FB4: u1 = 0,
/// FB5 [5:5]
/// Filter bits
FB5: u1 = 0,
/// FB6 [6:6]
/// Filter bits
FB6: u1 = 0,
/// FB7 [7:7]
/// Filter bits
FB7: u1 = 0,
/// FB8 [8:8]
/// Filter bits
FB8: u1 = 0,
/// FB9 [9:9]
/// Filter bits
FB9: u1 = 0,
/// FB10 [10:10]
/// Filter bits
FB10: u1 = 0,
/// FB11 [11:11]
/// Filter bits
FB11: u1 = 0,
/// FB12 [12:12]
/// Filter bits
FB12: u1 = 0,
/// FB13 [13:13]
/// Filter bits
FB13: u1 = 0,
/// FB14 [14:14]
/// Filter bits
FB14: u1 = 0,
/// FB15 [15:15]
/// Filter bits
FB15: u1 = 0,
/// FB16 [16:16]
/// Filter bits
FB16: u1 = 0,
/// FB17 [17:17]
/// Filter bits
FB17: u1 = 0,
/// FB18 [18:18]
/// Filter bits
FB18: u1 = 0,
/// FB19 [19:19]
/// Filter bits
FB19: u1 = 0,
/// FB20 [20:20]
/// Filter bits
FB20: u1 = 0,
/// FB21 [21:21]
/// Filter bits
FB21: u1 = 0,
/// FB22 [22:22]
/// Filter bits
FB22: u1 = 0,
/// FB23 [23:23]
/// Filter bits
FB23: u1 = 0,
/// FB24 [24:24]
/// Filter bits
FB24: u1 = 0,
/// FB25 [25:25]
/// Filter bits
FB25: u1 = 0,
/// FB26 [26:26]
/// Filter bits
FB26: u1 = 0,
/// FB27 [27:27]
/// Filter bits
FB27: u1 = 0,
/// FB28 [28:28]
/// Filter bits
FB28: u1 = 0,
/// FB29 [29:29]
/// Filter bits
FB29: u1 = 0,
/// FB30 [30:30]
/// Filter bits
FB30: u1 = 0,
/// FB31 [31:31]
/// Filter bits
FB31: u1 = 0,
};
/// Filter bank 9 register 2
pub const F9R2 = Register(F9R2_val).init(base_address + 0x28c);

/// F10R1
const F10R1_val = packed struct {
/// FB0 [0:0]
/// Filter bits
FB0: u1 = 0,
/// FB1 [1:1]
/// Filter bits
FB1: u1 = 0,
/// FB2 [2:2]
/// Filter bits
FB2: u1 = 0,
/// FB3 [3:3]
/// Filter bits
FB3: u1 = 0,
/// FB4 [4:4]
/// Filter bits
FB4: u1 = 0,
/// FB5 [5:5]
/// Filter bits
FB5: u1 = 0,
/// FB6 [6:6]
/// Filter bits
FB6: u1 = 0,
/// FB7 [7:7]
/// Filter bits
FB7: u1 = 0,
/// FB8 [8:8]
/// Filter bits
FB8: u1 = 0,
/// FB9 [9:9]
/// Filter bits
FB9: u1 = 0,
/// FB10 [10:10]
/// Filter bits
FB10: u1 = 0,
/// FB11 [11:11]
/// Filter bits
FB11: u1 = 0,
/// FB12 [12:12]
/// Filter bits
FB12: u1 = 0,
/// FB13 [13:13]
/// Filter bits
FB13: u1 = 0,
/// FB14 [14:14]
/// Filter bits
FB14: u1 = 0,
/// FB15 [15:15]
/// Filter bits
FB15: u1 = 0,
/// FB16 [16:16]
/// Filter bits
FB16: u1 = 0,
/// FB17 [17:17]
/// Filter bits
FB17: u1 = 0,
/// FB18 [18:18]
/// Filter bits
FB18: u1 = 0,
/// FB19 [19:19]
/// Filter bits
FB19: u1 = 0,
/// FB20 [20:20]
/// Filter bits
FB20: u1 = 0,
/// FB21 [21:21]
/// Filter bits
FB21: u1 = 0,
/// FB22 [22:22]
/// Filter bits
FB22: u1 = 0,
/// FB23 [23:23]
/// Filter bits
FB23: u1 = 0,
/// FB24 [24:24]
/// Filter bits
FB24: u1 = 0,
/// FB25 [25:25]
/// Filter bits
FB25: u1 = 0,
/// FB26 [26:26]
/// Filter bits
FB26: u1 = 0,
/// FB27 [27:27]
/// Filter bits
FB27: u1 = 0,
/// FB28 [28:28]
/// Filter bits
FB28: u1 = 0,
/// FB29 [29:29]
/// Filter bits
FB29: u1 = 0,
/// FB30 [30:30]
/// Filter bits
FB30: u1 = 0,
/// FB31 [31:31]
/// Filter bits
FB31: u1 = 0,
};
/// Filter bank 10 register 1
pub const F10R1 = Register(F10R1_val).init(base_address + 0x290);

/// F10R2
const F10R2_val = packed struct {
/// FB0 [0:0]
/// Filter bits
FB0: u1 = 0,
/// FB1 [1:1]
/// Filter bits
FB1: u1 = 0,
/// FB2 [2:2]
/// Filter bits
FB2: u1 = 0,
/// FB3 [3:3]
/// Filter bits
FB3: u1 = 0,
/// FB4 [4:4]
/// Filter bits
FB4: u1 = 0,
/// FB5 [5:5]
/// Filter bits
FB5: u1 = 0,
/// FB6 [6:6]
/// Filter bits
FB6: u1 = 0,
/// FB7 [7:7]
/// Filter bits
FB7: u1 = 0,
/// FB8 [8:8]
/// Filter bits
FB8: u1 = 0,
/// FB9 [9:9]
/// Filter bits
FB9: u1 = 0,
/// FB10 [10:10]
/// Filter bits
FB10: u1 = 0,
/// FB11 [11:11]
/// Filter bits
FB11: u1 = 0,
/// FB12 [12:12]
/// Filter bits
FB12: u1 = 0,
/// FB13 [13:13]
/// Filter bits
FB13: u1 = 0,
/// FB14 [14:14]
/// Filter bits
FB14: u1 = 0,
/// FB15 [15:15]
/// Filter bits
FB15: u1 = 0,
/// FB16 [16:16]
/// Filter bits
FB16: u1 = 0,
/// FB17 [17:17]
/// Filter bits
FB17: u1 = 0,
/// FB18 [18:18]
/// Filter bits
FB18: u1 = 0,
/// FB19 [19:19]
/// Filter bits
FB19: u1 = 0,
/// FB20 [20:20]
/// Filter bits
FB20: u1 = 0,
/// FB21 [21:21]
/// Filter bits
FB21: u1 = 0,
/// FB22 [22:22]
/// Filter bits
FB22: u1 = 0,
/// FB23 [23:23]
/// Filter bits
FB23: u1 = 0,
/// FB24 [24:24]
/// Filter bits
FB24: u1 = 0,
/// FB25 [25:25]
/// Filter bits
FB25: u1 = 0,
/// FB26 [26:26]
/// Filter bits
FB26: u1 = 0,
/// FB27 [27:27]
/// Filter bits
FB27: u1 = 0,
/// FB28 [28:28]
/// Filter bits
FB28: u1 = 0,
/// FB29 [29:29]
/// Filter bits
FB29: u1 = 0,
/// FB30 [30:30]
/// Filter bits
FB30: u1 = 0,
/// FB31 [31:31]
/// Filter bits
FB31: u1 = 0,
};
/// Filter bank 10 register 2
pub const F10R2 = Register(F10R2_val).init(base_address + 0x294);

/// F11R1
const F11R1_val = packed struct {
/// FB0 [0:0]
/// Filter bits
FB0: u1 = 0,
/// FB1 [1:1]
/// Filter bits
FB1: u1 = 0,
/// FB2 [2:2]
/// Filter bits
FB2: u1 = 0,
/// FB3 [3:3]
/// Filter bits
FB3: u1 = 0,
/// FB4 [4:4]
/// Filter bits
FB4: u1 = 0,
/// FB5 [5:5]
/// Filter bits
FB5: u1 = 0,
/// FB6 [6:6]
/// Filter bits
FB6: u1 = 0,
/// FB7 [7:7]
/// Filter bits
FB7: u1 = 0,
/// FB8 [8:8]
/// Filter bits
FB8: u1 = 0,
/// FB9 [9:9]
/// Filter bits
FB9: u1 = 0,
/// FB10 [10:10]
/// Filter bits
FB10: u1 = 0,
/// FB11 [11:11]
/// Filter bits
FB11: u1 = 0,
/// FB12 [12:12]
/// Filter bits
FB12: u1 = 0,
/// FB13 [13:13]
/// Filter bits
FB13: u1 = 0,
/// FB14 [14:14]
/// Filter bits
FB14: u1 = 0,
/// FB15 [15:15]
/// Filter bits
FB15: u1 = 0,
/// FB16 [16:16]
/// Filter bits
FB16: u1 = 0,
/// FB17 [17:17]
/// Filter bits
FB17: u1 = 0,
/// FB18 [18:18]
/// Filter bits
FB18: u1 = 0,
/// FB19 [19:19]
/// Filter bits
FB19: u1 = 0,
/// FB20 [20:20]
/// Filter bits
FB20: u1 = 0,
/// FB21 [21:21]
/// Filter bits
FB21: u1 = 0,
/// FB22 [22:22]
/// Filter bits
FB22: u1 = 0,
/// FB23 [23:23]
/// Filter bits
FB23: u1 = 0,
/// FB24 [24:24]
/// Filter bits
FB24: u1 = 0,
/// FB25 [25:25]
/// Filter bits
FB25: u1 = 0,
/// FB26 [26:26]
/// Filter bits
FB26: u1 = 0,
/// FB27 [27:27]
/// Filter bits
FB27: u1 = 0,
/// FB28 [28:28]
/// Filter bits
FB28: u1 = 0,
/// FB29 [29:29]
/// Filter bits
FB29: u1 = 0,
/// FB30 [30:30]
/// Filter bits
FB30: u1 = 0,
/// FB31 [31:31]
/// Filter bits
FB31: u1 = 0,
};
/// Filter bank 11 register 1
pub const F11R1 = Register(F11R1_val).init(base_address + 0x298);

/// F11R2
const F11R2_val = packed struct {
/// FB0 [0:0]
/// Filter bits
FB0: u1 = 0,
/// FB1 [1:1]
/// Filter bits
FB1: u1 = 0,
/// FB2 [2:2]
/// Filter bits
FB2: u1 = 0,
/// FB3 [3:3]
/// Filter bits
FB3: u1 = 0,
/// FB4 [4:4]
/// Filter bits
FB4: u1 = 0,
/// FB5 [5:5]
/// Filter bits
FB5: u1 = 0,
/// FB6 [6:6]
/// Filter bits
FB6: u1 = 0,
/// FB7 [7:7]
/// Filter bits
FB7: u1 = 0,
/// FB8 [8:8]
/// Filter bits
FB8: u1 = 0,
/// FB9 [9:9]
/// Filter bits
FB9: u1 = 0,
/// FB10 [10:10]
/// Filter bits
FB10: u1 = 0,
/// FB11 [11:11]
/// Filter bits
FB11: u1 = 0,
/// FB12 [12:12]
/// Filter bits
FB12: u1 = 0,
/// FB13 [13:13]
/// Filter bits
FB13: u1 = 0,
/// FB14 [14:14]
/// Filter bits
FB14: u1 = 0,
/// FB15 [15:15]
/// Filter bits
FB15: u1 = 0,
/// FB16 [16:16]
/// Filter bits
FB16: u1 = 0,
/// FB17 [17:17]
/// Filter bits
FB17: u1 = 0,
/// FB18 [18:18]
/// Filter bits
FB18: u1 = 0,
/// FB19 [19:19]
/// Filter bits
FB19: u1 = 0,
/// FB20 [20:20]
/// Filter bits
FB20: u1 = 0,
/// FB21 [21:21]
/// Filter bits
FB21: u1 = 0,
/// FB22 [22:22]
/// Filter bits
FB22: u1 = 0,
/// FB23 [23:23]
/// Filter bits
FB23: u1 = 0,
/// FB24 [24:24]
/// Filter bits
FB24: u1 = 0,
/// FB25 [25:25]
/// Filter bits
FB25: u1 = 0,
/// FB26 [26:26]
/// Filter bits
FB26: u1 = 0,
/// FB27 [27:27]
/// Filter bits
FB27: u1 = 0,
/// FB28 [28:28]
/// Filter bits
FB28: u1 = 0,
/// FB29 [29:29]
/// Filter bits
FB29: u1 = 0,
/// FB30 [30:30]
/// Filter bits
FB30: u1 = 0,
/// FB31 [31:31]
/// Filter bits
FB31: u1 = 0,
};
/// Filter bank 11 register 2
pub const F11R2 = Register(F11R2_val).init(base_address + 0x29c);

/// F12R1
const F12R1_val = packed struct {
/// FB0 [0:0]
/// Filter bits
FB0: u1 = 0,
/// FB1 [1:1]
/// Filter bits
FB1: u1 = 0,
/// FB2 [2:2]
/// Filter bits
FB2: u1 = 0,
/// FB3 [3:3]
/// Filter bits
FB3: u1 = 0,
/// FB4 [4:4]
/// Filter bits
FB4: u1 = 0,
/// FB5 [5:5]
/// Filter bits
FB5: u1 = 0,
/// FB6 [6:6]
/// Filter bits
FB6: u1 = 0,
/// FB7 [7:7]
/// Filter bits
FB7: u1 = 0,
/// FB8 [8:8]
/// Filter bits
FB8: u1 = 0,
/// FB9 [9:9]
/// Filter bits
FB9: u1 = 0,
/// FB10 [10:10]
/// Filter bits
FB10: u1 = 0,
/// FB11 [11:11]
/// Filter bits
FB11: u1 = 0,
/// FB12 [12:12]
/// Filter bits
FB12: u1 = 0,
/// FB13 [13:13]
/// Filter bits
FB13: u1 = 0,
/// FB14 [14:14]
/// Filter bits
FB14: u1 = 0,
/// FB15 [15:15]
/// Filter bits
FB15: u1 = 0,
/// FB16 [16:16]
/// Filter bits
FB16: u1 = 0,
/// FB17 [17:17]
/// Filter bits
FB17: u1 = 0,
/// FB18 [18:18]
/// Filter bits
FB18: u1 = 0,
/// FB19 [19:19]
/// Filter bits
FB19: u1 = 0,
/// FB20 [20:20]
/// Filter bits
FB20: u1 = 0,
/// FB21 [21:21]
/// Filter bits
FB21: u1 = 0,
/// FB22 [22:22]
/// Filter bits
FB22: u1 = 0,
/// FB23 [23:23]
/// Filter bits
FB23: u1 = 0,
/// FB24 [24:24]
/// Filter bits
FB24: u1 = 0,
/// FB25 [25:25]
/// Filter bits
FB25: u1 = 0,
/// FB26 [26:26]
/// Filter bits
FB26: u1 = 0,
/// FB27 [27:27]
/// Filter bits
FB27: u1 = 0,
/// FB28 [28:28]
/// Filter bits
FB28: u1 = 0,
/// FB29 [29:29]
/// Filter bits
FB29: u1 = 0,
/// FB30 [30:30]
/// Filter bits
FB30: u1 = 0,
/// FB31 [31:31]
/// Filter bits
FB31: u1 = 0,
};
/// Filter bank 4 register 1
pub const F12R1 = Register(F12R1_val).init(base_address + 0x2a0);

/// F12R2
const F12R2_val = packed struct {
/// FB0 [0:0]
/// Filter bits
FB0: u1 = 0,
/// FB1 [1:1]
/// Filter bits
FB1: u1 = 0,
/// FB2 [2:2]
/// Filter bits
FB2: u1 = 0,
/// FB3 [3:3]
/// Filter bits
FB3: u1 = 0,
/// FB4 [4:4]
/// Filter bits
FB4: u1 = 0,
/// FB5 [5:5]
/// Filter bits
FB5: u1 = 0,
/// FB6 [6:6]
/// Filter bits
FB6: u1 = 0,
/// FB7 [7:7]
/// Filter bits
FB7: u1 = 0,
/// FB8 [8:8]
/// Filter bits
FB8: u1 = 0,
/// FB9 [9:9]
/// Filter bits
FB9: u1 = 0,
/// FB10 [10:10]
/// Filter bits
FB10: u1 = 0,
/// FB11 [11:11]
/// Filter bits
FB11: u1 = 0,
/// FB12 [12:12]
/// Filter bits
FB12: u1 = 0,
/// FB13 [13:13]
/// Filter bits
FB13: u1 = 0,
/// FB14 [14:14]
/// Filter bits
FB14: u1 = 0,
/// FB15 [15:15]
/// Filter bits
FB15: u1 = 0,
/// FB16 [16:16]
/// Filter bits
FB16: u1 = 0,
/// FB17 [17:17]
/// Filter bits
FB17: u1 = 0,
/// FB18 [18:18]
/// Filter bits
FB18: u1 = 0,
/// FB19 [19:19]
/// Filter bits
FB19: u1 = 0,
/// FB20 [20:20]
/// Filter bits
FB20: u1 = 0,
/// FB21 [21:21]
/// Filter bits
FB21: u1 = 0,
/// FB22 [22:22]
/// Filter bits
FB22: u1 = 0,
/// FB23 [23:23]
/// Filter bits
FB23: u1 = 0,
/// FB24 [24:24]
/// Filter bits
FB24: u1 = 0,
/// FB25 [25:25]
/// Filter bits
FB25: u1 = 0,
/// FB26 [26:26]
/// Filter bits
FB26: u1 = 0,
/// FB27 [27:27]
/// Filter bits
FB27: u1 = 0,
/// FB28 [28:28]
/// Filter bits
FB28: u1 = 0,
/// FB29 [29:29]
/// Filter bits
FB29: u1 = 0,
/// FB30 [30:30]
/// Filter bits
FB30: u1 = 0,
/// FB31 [31:31]
/// Filter bits
FB31: u1 = 0,
};
/// Filter bank 12 register 2
pub const F12R2 = Register(F12R2_val).init(base_address + 0x2a4);

/// F13R1
const F13R1_val = packed struct {
/// FB0 [0:0]
/// Filter bits
FB0: u1 = 0,
/// FB1 [1:1]
/// Filter bits
FB1: u1 = 0,
/// FB2 [2:2]
/// Filter bits
FB2: u1 = 0,
/// FB3 [3:3]
/// Filter bits
FB3: u1 = 0,
/// FB4 [4:4]
/// Filter bits
FB4: u1 = 0,
/// FB5 [5:5]
/// Filter bits
FB5: u1 = 0,
/// FB6 [6:6]
/// Filter bits
FB6: u1 = 0,
/// FB7 [7:7]
/// Filter bits
FB7: u1 = 0,
/// FB8 [8:8]
/// Filter bits
FB8: u1 = 0,
/// FB9 [9:9]
/// Filter bits
FB9: u1 = 0,
/// FB10 [10:10]
/// Filter bits
FB10: u1 = 0,
/// FB11 [11:11]
/// Filter bits
FB11: u1 = 0,
/// FB12 [12:12]
/// Filter bits
FB12: u1 = 0,
/// FB13 [13:13]
/// Filter bits
FB13: u1 = 0,
/// FB14 [14:14]
/// Filter bits
FB14: u1 = 0,
/// FB15 [15:15]
/// Filter bits
FB15: u1 = 0,
/// FB16 [16:16]
/// Filter bits
FB16: u1 = 0,
/// FB17 [17:17]
/// Filter bits
FB17: u1 = 0,
/// FB18 [18:18]
/// Filter bits
FB18: u1 = 0,
/// FB19 [19:19]
/// Filter bits
FB19: u1 = 0,
/// FB20 [20:20]
/// Filter bits
FB20: u1 = 0,
/// FB21 [21:21]
/// Filter bits
FB21: u1 = 0,
/// FB22 [22:22]
/// Filter bits
FB22: u1 = 0,
/// FB23 [23:23]
/// Filter bits
FB23: u1 = 0,
/// FB24 [24:24]
/// Filter bits
FB24: u1 = 0,
/// FB25 [25:25]
/// Filter bits
FB25: u1 = 0,
/// FB26 [26:26]
/// Filter bits
FB26: u1 = 0,
/// FB27 [27:27]
/// Filter bits
FB27: u1 = 0,
/// FB28 [28:28]
/// Filter bits
FB28: u1 = 0,
/// FB29 [29:29]
/// Filter bits
FB29: u1 = 0,
/// FB30 [30:30]
/// Filter bits
FB30: u1 = 0,
/// FB31 [31:31]
/// Filter bits
FB31: u1 = 0,
};
/// Filter bank 13 register 1
pub const F13R1 = Register(F13R1_val).init(base_address + 0x2a8);

/// F13R2
const F13R2_val = packed struct {
/// FB0 [0:0]
/// Filter bits
FB0: u1 = 0,
/// FB1 [1:1]
/// Filter bits
FB1: u1 = 0,
/// FB2 [2:2]
/// Filter bits
FB2: u1 = 0,
/// FB3 [3:3]
/// Filter bits
FB3: u1 = 0,
/// FB4 [4:4]
/// Filter bits
FB4: u1 = 0,
/// FB5 [5:5]
/// Filter bits
FB5: u1 = 0,
/// FB6 [6:6]
/// Filter bits
FB6: u1 = 0,
/// FB7 [7:7]
/// Filter bits
FB7: u1 = 0,
/// FB8 [8:8]
/// Filter bits
FB8: u1 = 0,
/// FB9 [9:9]
/// Filter bits
FB9: u1 = 0,
/// FB10 [10:10]
/// Filter bits
FB10: u1 = 0,
/// FB11 [11:11]
/// Filter bits
FB11: u1 = 0,
/// FB12 [12:12]
/// Filter bits
FB12: u1 = 0,
/// FB13 [13:13]
/// Filter bits
FB13: u1 = 0,
/// FB14 [14:14]
/// Filter bits
FB14: u1 = 0,
/// FB15 [15:15]
/// Filter bits
FB15: u1 = 0,
/// FB16 [16:16]
/// Filter bits
FB16: u1 = 0,
/// FB17 [17:17]
/// Filter bits
FB17: u1 = 0,
/// FB18 [18:18]
/// Filter bits
FB18: u1 = 0,
/// FB19 [19:19]
/// Filter bits
FB19: u1 = 0,
/// FB20 [20:20]
/// Filter bits
FB20: u1 = 0,
/// FB21 [21:21]
/// Filter bits
FB21: u1 = 0,
/// FB22 [22:22]
/// Filter bits
FB22: u1 = 0,
/// FB23 [23:23]
/// Filter bits
FB23: u1 = 0,
/// FB24 [24:24]
/// Filter bits
FB24: u1 = 0,
/// FB25 [25:25]
/// Filter bits
FB25: u1 = 0,
/// FB26 [26:26]
/// Filter bits
FB26: u1 = 0,
/// FB27 [27:27]
/// Filter bits
FB27: u1 = 0,
/// FB28 [28:28]
/// Filter bits
FB28: u1 = 0,
/// FB29 [29:29]
/// Filter bits
FB29: u1 = 0,
/// FB30 [30:30]
/// Filter bits
FB30: u1 = 0,
/// FB31 [31:31]
/// Filter bits
FB31: u1 = 0,
};
/// Filter bank 13 register 2
pub const F13R2 = Register(F13R2_val).init(base_address + 0x2ac);

/// F14R1
const F14R1_val = packed struct {
/// FB0 [0:0]
/// Filter bits
FB0: u1 = 0,
/// FB1 [1:1]
/// Filter bits
FB1: u1 = 0,
/// FB2 [2:2]
/// Filter bits
FB2: u1 = 0,
/// FB3 [3:3]
/// Filter bits
FB3: u1 = 0,
/// FB4 [4:4]
/// Filter bits
FB4: u1 = 0,
/// FB5 [5:5]
/// Filter bits
FB5: u1 = 0,
/// FB6 [6:6]
/// Filter bits
FB6: u1 = 0,
/// FB7 [7:7]
/// Filter bits
FB7: u1 = 0,
/// FB8 [8:8]
/// Filter bits
FB8: u1 = 0,
/// FB9 [9:9]
/// Filter bits
FB9: u1 = 0,
/// FB10 [10:10]
/// Filter bits
FB10: u1 = 0,
/// FB11 [11:11]
/// Filter bits
FB11: u1 = 0,
/// FB12 [12:12]
/// Filter bits
FB12: u1 = 0,
/// FB13 [13:13]
/// Filter bits
FB13: u1 = 0,
/// FB14 [14:14]
/// Filter bits
FB14: u1 = 0,
/// FB15 [15:15]
/// Filter bits
FB15: u1 = 0,
/// FB16 [16:16]
/// Filter bits
FB16: u1 = 0,
/// FB17 [17:17]
/// Filter bits
FB17: u1 = 0,
/// FB18 [18:18]
/// Filter bits
FB18: u1 = 0,
/// FB19 [19:19]
/// Filter bits
FB19: u1 = 0,
/// FB20 [20:20]
/// Filter bits
FB20: u1 = 0,
/// FB21 [21:21]
/// Filter bits
FB21: u1 = 0,
/// FB22 [22:22]
/// Filter bits
FB22: u1 = 0,
/// FB23 [23:23]
/// Filter bits
FB23: u1 = 0,
/// FB24 [24:24]
/// Filter bits
FB24: u1 = 0,
/// FB25 [25:25]
/// Filter bits
FB25: u1 = 0,
/// FB26 [26:26]
/// Filter bits
FB26: u1 = 0,
/// FB27 [27:27]
/// Filter bits
FB27: u1 = 0,
/// FB28 [28:28]
/// Filter bits
FB28: u1 = 0,
/// FB29 [29:29]
/// Filter bits
FB29: u1 = 0,
/// FB30 [30:30]
/// Filter bits
FB30: u1 = 0,
/// FB31 [31:31]
/// Filter bits
FB31: u1 = 0,
};
/// Filter bank 14 register 1
pub const F14R1 = Register(F14R1_val).init(base_address + 0x2b0);

/// F14R2
const F14R2_val = packed struct {
/// FB0 [0:0]
/// Filter bits
FB0: u1 = 0,
/// FB1 [1:1]
/// Filter bits
FB1: u1 = 0,
/// FB2 [2:2]
/// Filter bits
FB2: u1 = 0,
/// FB3 [3:3]
/// Filter bits
FB3: u1 = 0,
/// FB4 [4:4]
/// Filter bits
FB4: u1 = 0,
/// FB5 [5:5]
/// Filter bits
FB5: u1 = 0,
/// FB6 [6:6]
/// Filter bits
FB6: u1 = 0,
/// FB7 [7:7]
/// Filter bits
FB7: u1 = 0,
/// FB8 [8:8]
/// Filter bits
FB8: u1 = 0,
/// FB9 [9:9]
/// Filter bits
FB9: u1 = 0,
/// FB10 [10:10]
/// Filter bits
FB10: u1 = 0,
/// FB11 [11:11]
/// Filter bits
FB11: u1 = 0,
/// FB12 [12:12]
/// Filter bits
FB12: u1 = 0,
/// FB13 [13:13]
/// Filter bits
FB13: u1 = 0,
/// FB14 [14:14]
/// Filter bits
FB14: u1 = 0,
/// FB15 [15:15]
/// Filter bits
FB15: u1 = 0,
/// FB16 [16:16]
/// Filter bits
FB16: u1 = 0,
/// FB17 [17:17]
/// Filter bits
FB17: u1 = 0,
/// FB18 [18:18]
/// Filter bits
FB18: u1 = 0,
/// FB19 [19:19]
/// Filter bits
FB19: u1 = 0,
/// FB20 [20:20]
/// Filter bits
FB20: u1 = 0,
/// FB21 [21:21]
/// Filter bits
FB21: u1 = 0,
/// FB22 [22:22]
/// Filter bits
FB22: u1 = 0,
/// FB23 [23:23]
/// Filter bits
FB23: u1 = 0,
/// FB24 [24:24]
/// Filter bits
FB24: u1 = 0,
/// FB25 [25:25]
/// Filter bits
FB25: u1 = 0,
/// FB26 [26:26]
/// Filter bits
FB26: u1 = 0,
/// FB27 [27:27]
/// Filter bits
FB27: u1 = 0,
/// FB28 [28:28]
/// Filter bits
FB28: u1 = 0,
/// FB29 [29:29]
/// Filter bits
FB29: u1 = 0,
/// FB30 [30:30]
/// Filter bits
FB30: u1 = 0,
/// FB31 [31:31]
/// Filter bits
FB31: u1 = 0,
};
/// Filter bank 14 register 2
pub const F14R2 = Register(F14R2_val).init(base_address + 0x2b4);

/// F15R1
const F15R1_val = packed struct {
/// FB0 [0:0]
/// Filter bits
FB0: u1 = 0,
/// FB1 [1:1]
/// Filter bits
FB1: u1 = 0,
/// FB2 [2:2]
/// Filter bits
FB2: u1 = 0,
/// FB3 [3:3]
/// Filter bits
FB3: u1 = 0,
/// FB4 [4:4]
/// Filter bits
FB4: u1 = 0,
/// FB5 [5:5]
/// Filter bits
FB5: u1 = 0,
/// FB6 [6:6]
/// Filter bits
FB6: u1 = 0,
/// FB7 [7:7]
/// Filter bits
FB7: u1 = 0,
/// FB8 [8:8]
/// Filter bits
FB8: u1 = 0,
/// FB9 [9:9]
/// Filter bits
FB9: u1 = 0,
/// FB10 [10:10]
/// Filter bits
FB10: u1 = 0,
/// FB11 [11:11]
/// Filter bits
FB11: u1 = 0,
/// FB12 [12:12]
/// Filter bits
FB12: u1 = 0,
/// FB13 [13:13]
/// Filter bits
FB13: u1 = 0,
/// FB14 [14:14]
/// Filter bits
FB14: u1 = 0,
/// FB15 [15:15]
/// Filter bits
FB15: u1 = 0,
/// FB16 [16:16]
/// Filter bits
FB16: u1 = 0,
/// FB17 [17:17]
/// Filter bits
FB17: u1 = 0,
/// FB18 [18:18]
/// Filter bits
FB18: u1 = 0,
/// FB19 [19:19]
/// Filter bits
FB19: u1 = 0,
/// FB20 [20:20]
/// Filter bits
FB20: u1 = 0,
/// FB21 [21:21]
/// Filter bits
FB21: u1 = 0,
/// FB22 [22:22]
/// Filter bits
FB22: u1 = 0,
/// FB23 [23:23]
/// Filter bits
FB23: u1 = 0,
/// FB24 [24:24]
/// Filter bits
FB24: u1 = 0,
/// FB25 [25:25]
/// Filter bits
FB25: u1 = 0,
/// FB26 [26:26]
/// Filter bits
FB26: u1 = 0,
/// FB27 [27:27]
/// Filter bits
FB27: u1 = 0,
/// FB28 [28:28]
/// Filter bits
FB28: u1 = 0,
/// FB29 [29:29]
/// Filter bits
FB29: u1 = 0,
/// FB30 [30:30]
/// Filter bits
FB30: u1 = 0,
/// FB31 [31:31]
/// Filter bits
FB31: u1 = 0,
};
/// Filter bank 15 register 1
pub const F15R1 = Register(F15R1_val).init(base_address + 0x2b8);

/// F15R2
const F15R2_val = packed struct {
/// FB0 [0:0]
/// Filter bits
FB0: u1 = 0,
/// FB1 [1:1]
/// Filter bits
FB1: u1 = 0,
/// FB2 [2:2]
/// Filter bits
FB2: u1 = 0,
/// FB3 [3:3]
/// Filter bits
FB3: u1 = 0,
/// FB4 [4:4]
/// Filter bits
FB4: u1 = 0,
/// FB5 [5:5]
/// Filter bits
FB5: u1 = 0,
/// FB6 [6:6]
/// Filter bits
FB6: u1 = 0,
/// FB7 [7:7]
/// Filter bits
FB7: u1 = 0,
/// FB8 [8:8]
/// Filter bits
FB8: u1 = 0,
/// FB9 [9:9]
/// Filter bits
FB9: u1 = 0,
/// FB10 [10:10]
/// Filter bits
FB10: u1 = 0,
/// FB11 [11:11]
/// Filter bits
FB11: u1 = 0,
/// FB12 [12:12]
/// Filter bits
FB12: u1 = 0,
/// FB13 [13:13]
/// Filter bits
FB13: u1 = 0,
/// FB14 [14:14]
/// Filter bits
FB14: u1 = 0,
/// FB15 [15:15]
/// Filter bits
FB15: u1 = 0,
/// FB16 [16:16]
/// Filter bits
FB16: u1 = 0,
/// FB17 [17:17]
/// Filter bits
FB17: u1 = 0,
/// FB18 [18:18]
/// Filter bits
FB18: u1 = 0,
/// FB19 [19:19]
/// Filter bits
FB19: u1 = 0,
/// FB20 [20:20]
/// Filter bits
FB20: u1 = 0,
/// FB21 [21:21]
/// Filter bits
FB21: u1 = 0,
/// FB22 [22:22]
/// Filter bits
FB22: u1 = 0,
/// FB23 [23:23]
/// Filter bits
FB23: u1 = 0,
/// FB24 [24:24]
/// Filter bits
FB24: u1 = 0,
/// FB25 [25:25]
/// Filter bits
FB25: u1 = 0,
/// FB26 [26:26]
/// Filter bits
FB26: u1 = 0,
/// FB27 [27:27]
/// Filter bits
FB27: u1 = 0,
/// FB28 [28:28]
/// Filter bits
FB28: u1 = 0,
/// FB29 [29:29]
/// Filter bits
FB29: u1 = 0,
/// FB30 [30:30]
/// Filter bits
FB30: u1 = 0,
/// FB31 [31:31]
/// Filter bits
FB31: u1 = 0,
};
/// Filter bank 15 register 2
pub const F15R2 = Register(F15R2_val).init(base_address + 0x2bc);

/// F16R1
const F16R1_val = packed struct {
/// FB0 [0:0]
/// Filter bits
FB0: u1 = 0,
/// FB1 [1:1]
/// Filter bits
FB1: u1 = 0,
/// FB2 [2:2]
/// Filter bits
FB2: u1 = 0,
/// FB3 [3:3]
/// Filter bits
FB3: u1 = 0,
/// FB4 [4:4]
/// Filter bits
FB4: u1 = 0,
/// FB5 [5:5]
/// Filter bits
FB5: u1 = 0,
/// FB6 [6:6]
/// Filter bits
FB6: u1 = 0,
/// FB7 [7:7]
/// Filter bits
FB7: u1 = 0,
/// FB8 [8:8]
/// Filter bits
FB8: u1 = 0,
/// FB9 [9:9]
/// Filter bits
FB9: u1 = 0,
/// FB10 [10:10]
/// Filter bits
FB10: u1 = 0,
/// FB11 [11:11]
/// Filter bits
FB11: u1 = 0,
/// FB12 [12:12]
/// Filter bits
FB12: u1 = 0,
/// FB13 [13:13]
/// Filter bits
FB13: u1 = 0,
/// FB14 [14:14]
/// Filter bits
FB14: u1 = 0,
/// FB15 [15:15]
/// Filter bits
FB15: u1 = 0,
/// FB16 [16:16]
/// Filter bits
FB16: u1 = 0,
/// FB17 [17:17]
/// Filter bits
FB17: u1 = 0,
/// FB18 [18:18]
/// Filter bits
FB18: u1 = 0,
/// FB19 [19:19]
/// Filter bits
FB19: u1 = 0,
/// FB20 [20:20]
/// Filter bits
FB20: u1 = 0,
/// FB21 [21:21]
/// Filter bits
FB21: u1 = 0,
/// FB22 [22:22]
/// Filter bits
FB22: u1 = 0,
/// FB23 [23:23]
/// Filter bits
FB23: u1 = 0,
/// FB24 [24:24]
/// Filter bits
FB24: u1 = 0,
/// FB25 [25:25]
/// Filter bits
FB25: u1 = 0,
/// FB26 [26:26]
/// Filter bits
FB26: u1 = 0,
/// FB27 [27:27]
/// Filter bits
FB27: u1 = 0,
/// FB28 [28:28]
/// Filter bits
FB28: u1 = 0,
/// FB29 [29:29]
/// Filter bits
FB29: u1 = 0,
/// FB30 [30:30]
/// Filter bits
FB30: u1 = 0,
/// FB31 [31:31]
/// Filter bits
FB31: u1 = 0,
};
/// Filter bank 16 register 1
pub const F16R1 = Register(F16R1_val).init(base_address + 0x2c0);

/// F16R2
const F16R2_val = packed struct {
/// FB0 [0:0]
/// Filter bits
FB0: u1 = 0,
/// FB1 [1:1]
/// Filter bits
FB1: u1 = 0,
/// FB2 [2:2]
/// Filter bits
FB2: u1 = 0,
/// FB3 [3:3]
/// Filter bits
FB3: u1 = 0,
/// FB4 [4:4]
/// Filter bits
FB4: u1 = 0,
/// FB5 [5:5]
/// Filter bits
FB5: u1 = 0,
/// FB6 [6:6]
/// Filter bits
FB6: u1 = 0,
/// FB7 [7:7]
/// Filter bits
FB7: u1 = 0,
/// FB8 [8:8]
/// Filter bits
FB8: u1 = 0,
/// FB9 [9:9]
/// Filter bits
FB9: u1 = 0,
/// FB10 [10:10]
/// Filter bits
FB10: u1 = 0,
/// FB11 [11:11]
/// Filter bits
FB11: u1 = 0,
/// FB12 [12:12]
/// Filter bits
FB12: u1 = 0,
/// FB13 [13:13]
/// Filter bits
FB13: u1 = 0,
/// FB14 [14:14]
/// Filter bits
FB14: u1 = 0,
/// FB15 [15:15]
/// Filter bits
FB15: u1 = 0,
/// FB16 [16:16]
/// Filter bits
FB16: u1 = 0,
/// FB17 [17:17]
/// Filter bits
FB17: u1 = 0,
/// FB18 [18:18]
/// Filter bits
FB18: u1 = 0,
/// FB19 [19:19]
/// Filter bits
FB19: u1 = 0,
/// FB20 [20:20]
/// Filter bits
FB20: u1 = 0,
/// FB21 [21:21]
/// Filter bits
FB21: u1 = 0,
/// FB22 [22:22]
/// Filter bits
FB22: u1 = 0,
/// FB23 [23:23]
/// Filter bits
FB23: u1 = 0,
/// FB24 [24:24]
/// Filter bits
FB24: u1 = 0,
/// FB25 [25:25]
/// Filter bits
FB25: u1 = 0,
/// FB26 [26:26]
/// Filter bits
FB26: u1 = 0,
/// FB27 [27:27]
/// Filter bits
FB27: u1 = 0,
/// FB28 [28:28]
/// Filter bits
FB28: u1 = 0,
/// FB29 [29:29]
/// Filter bits
FB29: u1 = 0,
/// FB30 [30:30]
/// Filter bits
FB30: u1 = 0,
/// FB31 [31:31]
/// Filter bits
FB31: u1 = 0,
};
/// Filter bank 16 register 2
pub const F16R2 = Register(F16R2_val).init(base_address + 0x2c4);

/// F17R1
const F17R1_val = packed struct {
/// FB0 [0:0]
/// Filter bits
FB0: u1 = 0,
/// FB1 [1:1]
/// Filter bits
FB1: u1 = 0,
/// FB2 [2:2]
/// Filter bits
FB2: u1 = 0,
/// FB3 [3:3]
/// Filter bits
FB3: u1 = 0,
/// FB4 [4:4]
/// Filter bits
FB4: u1 = 0,
/// FB5 [5:5]
/// Filter bits
FB5: u1 = 0,
/// FB6 [6:6]
/// Filter bits
FB6: u1 = 0,
/// FB7 [7:7]
/// Filter bits
FB7: u1 = 0,
/// FB8 [8:8]
/// Filter bits
FB8: u1 = 0,
/// FB9 [9:9]
/// Filter bits
FB9: u1 = 0,
/// FB10 [10:10]
/// Filter bits
FB10: u1 = 0,
/// FB11 [11:11]
/// Filter bits
FB11: u1 = 0,
/// FB12 [12:12]
/// Filter bits
FB12: u1 = 0,
/// FB13 [13:13]
/// Filter bits
FB13: u1 = 0,
/// FB14 [14:14]
/// Filter bits
FB14: u1 = 0,
/// FB15 [15:15]
/// Filter bits
FB15: u1 = 0,
/// FB16 [16:16]
/// Filter bits
FB16: u1 = 0,
/// FB17 [17:17]
/// Filter bits
FB17: u1 = 0,
/// FB18 [18:18]
/// Filter bits
FB18: u1 = 0,
/// FB19 [19:19]
/// Filter bits
FB19: u1 = 0,
/// FB20 [20:20]
/// Filter bits
FB20: u1 = 0,
/// FB21 [21:21]
/// Filter bits
FB21: u1 = 0,
/// FB22 [22:22]
/// Filter bits
FB22: u1 = 0,
/// FB23 [23:23]
/// Filter bits
FB23: u1 = 0,
/// FB24 [24:24]
/// Filter bits
FB24: u1 = 0,
/// FB25 [25:25]
/// Filter bits
FB25: u1 = 0,
/// FB26 [26:26]
/// Filter bits
FB26: u1 = 0,
/// FB27 [27:27]
/// Filter bits
FB27: u1 = 0,
/// FB28 [28:28]
/// Filter bits
FB28: u1 = 0,
/// FB29 [29:29]
/// Filter bits
FB29: u1 = 0,
/// FB30 [30:30]
/// Filter bits
FB30: u1 = 0,
/// FB31 [31:31]
/// Filter bits
FB31: u1 = 0,
};
/// Filter bank 17 register 1
pub const F17R1 = Register(F17R1_val).init(base_address + 0x2c8);

/// F17R2
const F17R2_val = packed struct {
/// FB0 [0:0]
/// Filter bits
FB0: u1 = 0,
/// FB1 [1:1]
/// Filter bits
FB1: u1 = 0,
/// FB2 [2:2]
/// Filter bits
FB2: u1 = 0,
/// FB3 [3:3]
/// Filter bits
FB3: u1 = 0,
/// FB4 [4:4]
/// Filter bits
FB4: u1 = 0,
/// FB5 [5:5]
/// Filter bits
FB5: u1 = 0,
/// FB6 [6:6]
/// Filter bits
FB6: u1 = 0,
/// FB7 [7:7]
/// Filter bits
FB7: u1 = 0,
/// FB8 [8:8]
/// Filter bits
FB8: u1 = 0,
/// FB9 [9:9]
/// Filter bits
FB9: u1 = 0,
/// FB10 [10:10]
/// Filter bits
FB10: u1 = 0,
/// FB11 [11:11]
/// Filter bits
FB11: u1 = 0,
/// FB12 [12:12]
/// Filter bits
FB12: u1 = 0,
/// FB13 [13:13]
/// Filter bits
FB13: u1 = 0,
/// FB14 [14:14]
/// Filter bits
FB14: u1 = 0,
/// FB15 [15:15]
/// Filter bits
FB15: u1 = 0,
/// FB16 [16:16]
/// Filter bits
FB16: u1 = 0,
/// FB17 [17:17]
/// Filter bits
FB17: u1 = 0,
/// FB18 [18:18]
/// Filter bits
FB18: u1 = 0,
/// FB19 [19:19]
/// Filter bits
FB19: u1 = 0,
/// FB20 [20:20]
/// Filter bits
FB20: u1 = 0,
/// FB21 [21:21]
/// Filter bits
FB21: u1 = 0,
/// FB22 [22:22]
/// Filter bits
FB22: u1 = 0,
/// FB23 [23:23]
/// Filter bits
FB23: u1 = 0,
/// FB24 [24:24]
/// Filter bits
FB24: u1 = 0,
/// FB25 [25:25]
/// Filter bits
FB25: u1 = 0,
/// FB26 [26:26]
/// Filter bits
FB26: u1 = 0,
/// FB27 [27:27]
/// Filter bits
FB27: u1 = 0,
/// FB28 [28:28]
/// Filter bits
FB28: u1 = 0,
/// FB29 [29:29]
/// Filter bits
FB29: u1 = 0,
/// FB30 [30:30]
/// Filter bits
FB30: u1 = 0,
/// FB31 [31:31]
/// Filter bits
FB31: u1 = 0,
};
/// Filter bank 17 register 2
pub const F17R2 = Register(F17R2_val).init(base_address + 0x2cc);

/// F18R1
const F18R1_val = packed struct {
/// FB0 [0:0]
/// Filter bits
FB0: u1 = 0,
/// FB1 [1:1]
/// Filter bits
FB1: u1 = 0,
/// FB2 [2:2]
/// Filter bits
FB2: u1 = 0,
/// FB3 [3:3]
/// Filter bits
FB3: u1 = 0,
/// FB4 [4:4]
/// Filter bits
FB4: u1 = 0,
/// FB5 [5:5]
/// Filter bits
FB5: u1 = 0,
/// FB6 [6:6]
/// Filter bits
FB6: u1 = 0,
/// FB7 [7:7]
/// Filter bits
FB7: u1 = 0,
/// FB8 [8:8]
/// Filter bits
FB8: u1 = 0,
/// FB9 [9:9]
/// Filter bits
FB9: u1 = 0,
/// FB10 [10:10]
/// Filter bits
FB10: u1 = 0,
/// FB11 [11:11]
/// Filter bits
FB11: u1 = 0,
/// FB12 [12:12]
/// Filter bits
FB12: u1 = 0,
/// FB13 [13:13]
/// Filter bits
FB13: u1 = 0,
/// FB14 [14:14]
/// Filter bits
FB14: u1 = 0,
/// FB15 [15:15]
/// Filter bits
FB15: u1 = 0,
/// FB16 [16:16]
/// Filter bits
FB16: u1 = 0,
/// FB17 [17:17]
/// Filter bits
FB17: u1 = 0,
/// FB18 [18:18]
/// Filter bits
FB18: u1 = 0,
/// FB19 [19:19]
/// Filter bits
FB19: u1 = 0,
/// FB20 [20:20]
/// Filter bits
FB20: u1 = 0,
/// FB21 [21:21]
/// Filter bits
FB21: u1 = 0,
/// FB22 [22:22]
/// Filter bits
FB22: u1 = 0,
/// FB23 [23:23]
/// Filter bits
FB23: u1 = 0,
/// FB24 [24:24]
/// Filter bits
FB24: u1 = 0,
/// FB25 [25:25]
/// Filter bits
FB25: u1 = 0,
/// FB26 [26:26]
/// Filter bits
FB26: u1 = 0,
/// FB27 [27:27]
/// Filter bits
FB27: u1 = 0,
/// FB28 [28:28]
/// Filter bits
FB28: u1 = 0,
/// FB29 [29:29]
/// Filter bits
FB29: u1 = 0,
/// FB30 [30:30]
/// Filter bits
FB30: u1 = 0,
/// FB31 [31:31]
/// Filter bits
FB31: u1 = 0,
};
/// Filter bank 18 register 1
pub const F18R1 = Register(F18R1_val).init(base_address + 0x2d0);

/// F18R2
const F18R2_val = packed struct {
/// FB0 [0:0]
/// Filter bits
FB0: u1 = 0,
/// FB1 [1:1]
/// Filter bits
FB1: u1 = 0,
/// FB2 [2:2]
/// Filter bits
FB2: u1 = 0,
/// FB3 [3:3]
/// Filter bits
FB3: u1 = 0,
/// FB4 [4:4]
/// Filter bits
FB4: u1 = 0,
/// FB5 [5:5]
/// Filter bits
FB5: u1 = 0,
/// FB6 [6:6]
/// Filter bits
FB6: u1 = 0,
/// FB7 [7:7]
/// Filter bits
FB7: u1 = 0,
/// FB8 [8:8]
/// Filter bits
FB8: u1 = 0,
/// FB9 [9:9]
/// Filter bits
FB9: u1 = 0,
/// FB10 [10:10]
/// Filter bits
FB10: u1 = 0,
/// FB11 [11:11]
/// Filter bits
FB11: u1 = 0,
/// FB12 [12:12]
/// Filter bits
FB12: u1 = 0,
/// FB13 [13:13]
/// Filter bits
FB13: u1 = 0,
/// FB14 [14:14]
/// Filter bits
FB14: u1 = 0,
/// FB15 [15:15]
/// Filter bits
FB15: u1 = 0,
/// FB16 [16:16]
/// Filter bits
FB16: u1 = 0,
/// FB17 [17:17]
/// Filter bits
FB17: u1 = 0,
/// FB18 [18:18]
/// Filter bits
FB18: u1 = 0,
/// FB19 [19:19]
/// Filter bits
FB19: u1 = 0,
/// FB20 [20:20]
/// Filter bits
FB20: u1 = 0,
/// FB21 [21:21]
/// Filter bits
FB21: u1 = 0,
/// FB22 [22:22]
/// Filter bits
FB22: u1 = 0,
/// FB23 [23:23]
/// Filter bits
FB23: u1 = 0,
/// FB24 [24:24]
/// Filter bits
FB24: u1 = 0,
/// FB25 [25:25]
/// Filter bits
FB25: u1 = 0,
/// FB26 [26:26]
/// Filter bits
FB26: u1 = 0,
/// FB27 [27:27]
/// Filter bits
FB27: u1 = 0,
/// FB28 [28:28]
/// Filter bits
FB28: u1 = 0,
/// FB29 [29:29]
/// Filter bits
FB29: u1 = 0,
/// FB30 [30:30]
/// Filter bits
FB30: u1 = 0,
/// FB31 [31:31]
/// Filter bits
FB31: u1 = 0,
};
/// Filter bank 18 register 2
pub const F18R2 = Register(F18R2_val).init(base_address + 0x2d4);

/// F19R1
const F19R1_val = packed struct {
/// FB0 [0:0]
/// Filter bits
FB0: u1 = 0,
/// FB1 [1:1]
/// Filter bits
FB1: u1 = 0,
/// FB2 [2:2]
/// Filter bits
FB2: u1 = 0,
/// FB3 [3:3]
/// Filter bits
FB3: u1 = 0,
/// FB4 [4:4]
/// Filter bits
FB4: u1 = 0,
/// FB5 [5:5]
/// Filter bits
FB5: u1 = 0,
/// FB6 [6:6]
/// Filter bits
FB6: u1 = 0,
/// FB7 [7:7]
/// Filter bits
FB7: u1 = 0,
/// FB8 [8:8]
/// Filter bits
FB8: u1 = 0,
/// FB9 [9:9]
/// Filter bits
FB9: u1 = 0,
/// FB10 [10:10]
/// Filter bits
FB10: u1 = 0,
/// FB11 [11:11]
/// Filter bits
FB11: u1 = 0,
/// FB12 [12:12]
/// Filter bits
FB12: u1 = 0,
/// FB13 [13:13]
/// Filter bits
FB13: u1 = 0,
/// FB14 [14:14]
/// Filter bits
FB14: u1 = 0,
/// FB15 [15:15]
/// Filter bits
FB15: u1 = 0,
/// FB16 [16:16]
/// Filter bits
FB16: u1 = 0,
/// FB17 [17:17]
/// Filter bits
FB17: u1 = 0,
/// FB18 [18:18]
/// Filter bits
FB18: u1 = 0,
/// FB19 [19:19]
/// Filter bits
FB19: u1 = 0,
/// FB20 [20:20]
/// Filter bits
FB20: u1 = 0,
/// FB21 [21:21]
/// Filter bits
FB21: u1 = 0,
/// FB22 [22:22]
/// Filter bits
FB22: u1 = 0,
/// FB23 [23:23]
/// Filter bits
FB23: u1 = 0,
/// FB24 [24:24]
/// Filter bits
FB24: u1 = 0,
/// FB25 [25:25]
/// Filter bits
FB25: u1 = 0,
/// FB26 [26:26]
/// Filter bits
FB26: u1 = 0,
/// FB27 [27:27]
/// Filter bits
FB27: u1 = 0,
/// FB28 [28:28]
/// Filter bits
FB28: u1 = 0,
/// FB29 [29:29]
/// Filter bits
FB29: u1 = 0,
/// FB30 [30:30]
/// Filter bits
FB30: u1 = 0,
/// FB31 [31:31]
/// Filter bits
FB31: u1 = 0,
};
/// Filter bank 19 register 1
pub const F19R1 = Register(F19R1_val).init(base_address + 0x2d8);

/// F19R2
const F19R2_val = packed struct {
/// FB0 [0:0]
/// Filter bits
FB0: u1 = 0,
/// FB1 [1:1]
/// Filter bits
FB1: u1 = 0,
/// FB2 [2:2]
/// Filter bits
FB2: u1 = 0,
/// FB3 [3:3]
/// Filter bits
FB3: u1 = 0,
/// FB4 [4:4]
/// Filter bits
FB4: u1 = 0,
/// FB5 [5:5]
/// Filter bits
FB5: u1 = 0,
/// FB6 [6:6]
/// Filter bits
FB6: u1 = 0,
/// FB7 [7:7]
/// Filter bits
FB7: u1 = 0,
/// FB8 [8:8]
/// Filter bits
FB8: u1 = 0,
/// FB9 [9:9]
/// Filter bits
FB9: u1 = 0,
/// FB10 [10:10]
/// Filter bits
FB10: u1 = 0,
/// FB11 [11:11]
/// Filter bits
FB11: u1 = 0,
/// FB12 [12:12]
/// Filter bits
FB12: u1 = 0,
/// FB13 [13:13]
/// Filter bits
FB13: u1 = 0,
/// FB14 [14:14]
/// Filter bits
FB14: u1 = 0,
/// FB15 [15:15]
/// Filter bits
FB15: u1 = 0,
/// FB16 [16:16]
/// Filter bits
FB16: u1 = 0,
/// FB17 [17:17]
/// Filter bits
FB17: u1 = 0,
/// FB18 [18:18]
/// Filter bits
FB18: u1 = 0,
/// FB19 [19:19]
/// Filter bits
FB19: u1 = 0,
/// FB20 [20:20]
/// Filter bits
FB20: u1 = 0,
/// FB21 [21:21]
/// Filter bits
FB21: u1 = 0,
/// FB22 [22:22]
/// Filter bits
FB22: u1 = 0,
/// FB23 [23:23]
/// Filter bits
FB23: u1 = 0,
/// FB24 [24:24]
/// Filter bits
FB24: u1 = 0,
/// FB25 [25:25]
/// Filter bits
FB25: u1 = 0,
/// FB26 [26:26]
/// Filter bits
FB26: u1 = 0,
/// FB27 [27:27]
/// Filter bits
FB27: u1 = 0,
/// FB28 [28:28]
/// Filter bits
FB28: u1 = 0,
/// FB29 [29:29]
/// Filter bits
FB29: u1 = 0,
/// FB30 [30:30]
/// Filter bits
FB30: u1 = 0,
/// FB31 [31:31]
/// Filter bits
FB31: u1 = 0,
};
/// Filter bank 19 register 2
pub const F19R2 = Register(F19R2_val).init(base_address + 0x2dc);

/// F20R1
const F20R1_val = packed struct {
/// FB0 [0:0]
/// Filter bits
FB0: u1 = 0,
/// FB1 [1:1]
/// Filter bits
FB1: u1 = 0,
/// FB2 [2:2]
/// Filter bits
FB2: u1 = 0,
/// FB3 [3:3]
/// Filter bits
FB3: u1 = 0,
/// FB4 [4:4]
/// Filter bits
FB4: u1 = 0,
/// FB5 [5:5]
/// Filter bits
FB5: u1 = 0,
/// FB6 [6:6]
/// Filter bits
FB6: u1 = 0,
/// FB7 [7:7]
/// Filter bits
FB7: u1 = 0,
/// FB8 [8:8]
/// Filter bits
FB8: u1 = 0,
/// FB9 [9:9]
/// Filter bits
FB9: u1 = 0,
/// FB10 [10:10]
/// Filter bits
FB10: u1 = 0,
/// FB11 [11:11]
/// Filter bits
FB11: u1 = 0,
/// FB12 [12:12]
/// Filter bits
FB12: u1 = 0,
/// FB13 [13:13]
/// Filter bits
FB13: u1 = 0,
/// FB14 [14:14]
/// Filter bits
FB14: u1 = 0,
/// FB15 [15:15]
/// Filter bits
FB15: u1 = 0,
/// FB16 [16:16]
/// Filter bits
FB16: u1 = 0,
/// FB17 [17:17]
/// Filter bits
FB17: u1 = 0,
/// FB18 [18:18]
/// Filter bits
FB18: u1 = 0,
/// FB19 [19:19]
/// Filter bits
FB19: u1 = 0,
/// FB20 [20:20]
/// Filter bits
FB20: u1 = 0,
/// FB21 [21:21]
/// Filter bits
FB21: u1 = 0,
/// FB22 [22:22]
/// Filter bits
FB22: u1 = 0,
/// FB23 [23:23]
/// Filter bits
FB23: u1 = 0,
/// FB24 [24:24]
/// Filter bits
FB24: u1 = 0,
/// FB25 [25:25]
/// Filter bits
FB25: u1 = 0,
/// FB26 [26:26]
/// Filter bits
FB26: u1 = 0,
/// FB27 [27:27]
/// Filter bits
FB27: u1 = 0,
/// FB28 [28:28]
/// Filter bits
FB28: u1 = 0,
/// FB29 [29:29]
/// Filter bits
FB29: u1 = 0,
/// FB30 [30:30]
/// Filter bits
FB30: u1 = 0,
/// FB31 [31:31]
/// Filter bits
FB31: u1 = 0,
};
/// Filter bank 20 register 1
pub const F20R1 = Register(F20R1_val).init(base_address + 0x2e0);

/// F20R2
const F20R2_val = packed struct {
/// FB0 [0:0]
/// Filter bits
FB0: u1 = 0,
/// FB1 [1:1]
/// Filter bits
FB1: u1 = 0,
/// FB2 [2:2]
/// Filter bits
FB2: u1 = 0,
/// FB3 [3:3]
/// Filter bits
FB3: u1 = 0,
/// FB4 [4:4]
/// Filter bits
FB4: u1 = 0,
/// FB5 [5:5]
/// Filter bits
FB5: u1 = 0,
/// FB6 [6:6]
/// Filter bits
FB6: u1 = 0,
/// FB7 [7:7]
/// Filter bits
FB7: u1 = 0,
/// FB8 [8:8]
/// Filter bits
FB8: u1 = 0,
/// FB9 [9:9]
/// Filter bits
FB9: u1 = 0,
/// FB10 [10:10]
/// Filter bits
FB10: u1 = 0,
/// FB11 [11:11]
/// Filter bits
FB11: u1 = 0,
/// FB12 [12:12]
/// Filter bits
FB12: u1 = 0,
/// FB13 [13:13]
/// Filter bits
FB13: u1 = 0,
/// FB14 [14:14]
/// Filter bits
FB14: u1 = 0,
/// FB15 [15:15]
/// Filter bits
FB15: u1 = 0,
/// FB16 [16:16]
/// Filter bits
FB16: u1 = 0,
/// FB17 [17:17]
/// Filter bits
FB17: u1 = 0,
/// FB18 [18:18]
/// Filter bits
FB18: u1 = 0,
/// FB19 [19:19]
/// Filter bits
FB19: u1 = 0,
/// FB20 [20:20]
/// Filter bits
FB20: u1 = 0,
/// FB21 [21:21]
/// Filter bits
FB21: u1 = 0,
/// FB22 [22:22]
/// Filter bits
FB22: u1 = 0,
/// FB23 [23:23]
/// Filter bits
FB23: u1 = 0,
/// FB24 [24:24]
/// Filter bits
FB24: u1 = 0,
/// FB25 [25:25]
/// Filter bits
FB25: u1 = 0,
/// FB26 [26:26]
/// Filter bits
FB26: u1 = 0,
/// FB27 [27:27]
/// Filter bits
FB27: u1 = 0,
/// FB28 [28:28]
/// Filter bits
FB28: u1 = 0,
/// FB29 [29:29]
/// Filter bits
FB29: u1 = 0,
/// FB30 [30:30]
/// Filter bits
FB30: u1 = 0,
/// FB31 [31:31]
/// Filter bits
FB31: u1 = 0,
};
/// Filter bank 20 register 2
pub const F20R2 = Register(F20R2_val).init(base_address + 0x2e4);

/// F21R1
const F21R1_val = packed struct {
/// FB0 [0:0]
/// Filter bits
FB0: u1 = 0,
/// FB1 [1:1]
/// Filter bits
FB1: u1 = 0,
/// FB2 [2:2]
/// Filter bits
FB2: u1 = 0,
/// FB3 [3:3]
/// Filter bits
FB3: u1 = 0,
/// FB4 [4:4]
/// Filter bits
FB4: u1 = 0,
/// FB5 [5:5]
/// Filter bits
FB5: u1 = 0,
/// FB6 [6:6]
/// Filter bits
FB6: u1 = 0,
/// FB7 [7:7]
/// Filter bits
FB7: u1 = 0,
/// FB8 [8:8]
/// Filter bits
FB8: u1 = 0,
/// FB9 [9:9]
/// Filter bits
FB9: u1 = 0,
/// FB10 [10:10]
/// Filter bits
FB10: u1 = 0,
/// FB11 [11:11]
/// Filter bits
FB11: u1 = 0,
/// FB12 [12:12]
/// Filter bits
FB12: u1 = 0,
/// FB13 [13:13]
/// Filter bits
FB13: u1 = 0,
/// FB14 [14:14]
/// Filter bits
FB14: u1 = 0,
/// FB15 [15:15]
/// Filter bits
FB15: u1 = 0,
/// FB16 [16:16]
/// Filter bits
FB16: u1 = 0,
/// FB17 [17:17]
/// Filter bits
FB17: u1 = 0,
/// FB18 [18:18]
/// Filter bits
FB18: u1 = 0,
/// FB19 [19:19]
/// Filter bits
FB19: u1 = 0,
/// FB20 [20:20]
/// Filter bits
FB20: u1 = 0,
/// FB21 [21:21]
/// Filter bits
FB21: u1 = 0,
/// FB22 [22:22]
/// Filter bits
FB22: u1 = 0,
/// FB23 [23:23]
/// Filter bits
FB23: u1 = 0,
/// FB24 [24:24]
/// Filter bits
FB24: u1 = 0,
/// FB25 [25:25]
/// Filter bits
FB25: u1 = 0,
/// FB26 [26:26]
/// Filter bits
FB26: u1 = 0,
/// FB27 [27:27]
/// Filter bits
FB27: u1 = 0,
/// FB28 [28:28]
/// Filter bits
FB28: u1 = 0,
/// FB29 [29:29]
/// Filter bits
FB29: u1 = 0,
/// FB30 [30:30]
/// Filter bits
FB30: u1 = 0,
/// FB31 [31:31]
/// Filter bits
FB31: u1 = 0,
};
/// Filter bank 21 register 1
pub const F21R1 = Register(F21R1_val).init(base_address + 0x2e8);

/// F21R2
const F21R2_val = packed struct {
/// FB0 [0:0]
/// Filter bits
FB0: u1 = 0,
/// FB1 [1:1]
/// Filter bits
FB1: u1 = 0,
/// FB2 [2:2]
/// Filter bits
FB2: u1 = 0,
/// FB3 [3:3]
/// Filter bits
FB3: u1 = 0,
/// FB4 [4:4]
/// Filter bits
FB4: u1 = 0,
/// FB5 [5:5]
/// Filter bits
FB5: u1 = 0,
/// FB6 [6:6]
/// Filter bits
FB6: u1 = 0,
/// FB7 [7:7]
/// Filter bits
FB7: u1 = 0,
/// FB8 [8:8]
/// Filter bits
FB8: u1 = 0,
/// FB9 [9:9]
/// Filter bits
FB9: u1 = 0,
/// FB10 [10:10]
/// Filter bits
FB10: u1 = 0,
/// FB11 [11:11]
/// Filter bits
FB11: u1 = 0,
/// FB12 [12:12]
/// Filter bits
FB12: u1 = 0,
/// FB13 [13:13]
/// Filter bits
FB13: u1 = 0,
/// FB14 [14:14]
/// Filter bits
FB14: u1 = 0,
/// FB15 [15:15]
/// Filter bits
FB15: u1 = 0,
/// FB16 [16:16]
/// Filter bits
FB16: u1 = 0,
/// FB17 [17:17]
/// Filter bits
FB17: u1 = 0,
/// FB18 [18:18]
/// Filter bits
FB18: u1 = 0,
/// FB19 [19:19]
/// Filter bits
FB19: u1 = 0,
/// FB20 [20:20]
/// Filter bits
FB20: u1 = 0,
/// FB21 [21:21]
/// Filter bits
FB21: u1 = 0,
/// FB22 [22:22]
/// Filter bits
FB22: u1 = 0,
/// FB23 [23:23]
/// Filter bits
FB23: u1 = 0,
/// FB24 [24:24]
/// Filter bits
FB24: u1 = 0,
/// FB25 [25:25]
/// Filter bits
FB25: u1 = 0,
/// FB26 [26:26]
/// Filter bits
FB26: u1 = 0,
/// FB27 [27:27]
/// Filter bits
FB27: u1 = 0,
/// FB28 [28:28]
/// Filter bits
FB28: u1 = 0,
/// FB29 [29:29]
/// Filter bits
FB29: u1 = 0,
/// FB30 [30:30]
/// Filter bits
FB30: u1 = 0,
/// FB31 [31:31]
/// Filter bits
FB31: u1 = 0,
};
/// Filter bank 21 register 2
pub const F21R2 = Register(F21R2_val).init(base_address + 0x2ec);

/// F22R1
const F22R1_val = packed struct {
/// FB0 [0:0]
/// Filter bits
FB0: u1 = 0,
/// FB1 [1:1]
/// Filter bits
FB1: u1 = 0,
/// FB2 [2:2]
/// Filter bits
FB2: u1 = 0,
/// FB3 [3:3]
/// Filter bits
FB3: u1 = 0,
/// FB4 [4:4]
/// Filter bits
FB4: u1 = 0,
/// FB5 [5:5]
/// Filter bits
FB5: u1 = 0,
/// FB6 [6:6]
/// Filter bits
FB6: u1 = 0,
/// FB7 [7:7]
/// Filter bits
FB7: u1 = 0,
/// FB8 [8:8]
/// Filter bits
FB8: u1 = 0,
/// FB9 [9:9]
/// Filter bits
FB9: u1 = 0,
/// FB10 [10:10]
/// Filter bits
FB10: u1 = 0,
/// FB11 [11:11]
/// Filter bits
FB11: u1 = 0,
/// FB12 [12:12]
/// Filter bits
FB12: u1 = 0,
/// FB13 [13:13]
/// Filter bits
FB13: u1 = 0,
/// FB14 [14:14]
/// Filter bits
FB14: u1 = 0,
/// FB15 [15:15]
/// Filter bits
FB15: u1 = 0,
/// FB16 [16:16]
/// Filter bits
FB16: u1 = 0,
/// FB17 [17:17]
/// Filter bits
FB17: u1 = 0,
/// FB18 [18:18]
/// Filter bits
FB18: u1 = 0,
/// FB19 [19:19]
/// Filter bits
FB19: u1 = 0,
/// FB20 [20:20]
/// Filter bits
FB20: u1 = 0,
/// FB21 [21:21]
/// Filter bits
FB21: u1 = 0,
/// FB22 [22:22]
/// Filter bits
FB22: u1 = 0,
/// FB23 [23:23]
/// Filter bits
FB23: u1 = 0,
/// FB24 [24:24]
/// Filter bits
FB24: u1 = 0,
/// FB25 [25:25]
/// Filter bits
FB25: u1 = 0,
/// FB26 [26:26]
/// Filter bits
FB26: u1 = 0,
/// FB27 [27:27]
/// Filter bits
FB27: u1 = 0,
/// FB28 [28:28]
/// Filter bits
FB28: u1 = 0,
/// FB29 [29:29]
/// Filter bits
FB29: u1 = 0,
/// FB30 [30:30]
/// Filter bits
FB30: u1 = 0,
/// FB31 [31:31]
/// Filter bits
FB31: u1 = 0,
};
/// Filter bank 22 register 1
pub const F22R1 = Register(F22R1_val).init(base_address + 0x2f0);

/// F22R2
const F22R2_val = packed struct {
/// FB0 [0:0]
/// Filter bits
FB0: u1 = 0,
/// FB1 [1:1]
/// Filter bits
FB1: u1 = 0,
/// FB2 [2:2]
/// Filter bits
FB2: u1 = 0,
/// FB3 [3:3]
/// Filter bits
FB3: u1 = 0,
/// FB4 [4:4]
/// Filter bits
FB4: u1 = 0,
/// FB5 [5:5]
/// Filter bits
FB5: u1 = 0,
/// FB6 [6:6]
/// Filter bits
FB6: u1 = 0,
/// FB7 [7:7]
/// Filter bits
FB7: u1 = 0,
/// FB8 [8:8]
/// Filter bits
FB8: u1 = 0,
/// FB9 [9:9]
/// Filter bits
FB9: u1 = 0,
/// FB10 [10:10]
/// Filter bits
FB10: u1 = 0,
/// FB11 [11:11]
/// Filter bits
FB11: u1 = 0,
/// FB12 [12:12]
/// Filter bits
FB12: u1 = 0,
/// FB13 [13:13]
/// Filter bits
FB13: u1 = 0,
/// FB14 [14:14]
/// Filter bits
FB14: u1 = 0,
/// FB15 [15:15]
/// Filter bits
FB15: u1 = 0,
/// FB16 [16:16]
/// Filter bits
FB16: u1 = 0,
/// FB17 [17:17]
/// Filter bits
FB17: u1 = 0,
/// FB18 [18:18]
/// Filter bits
FB18: u1 = 0,
/// FB19 [19:19]
/// Filter bits
FB19: u1 = 0,
/// FB20 [20:20]
/// Filter bits
FB20: u1 = 0,
/// FB21 [21:21]
/// Filter bits
FB21: u1 = 0,
/// FB22 [22:22]
/// Filter bits
FB22: u1 = 0,
/// FB23 [23:23]
/// Filter bits
FB23: u1 = 0,
/// FB24 [24:24]
/// Filter bits
FB24: u1 = 0,
/// FB25 [25:25]
/// Filter bits
FB25: u1 = 0,
/// FB26 [26:26]
/// Filter bits
FB26: u1 = 0,
/// FB27 [27:27]
/// Filter bits
FB27: u1 = 0,
/// FB28 [28:28]
/// Filter bits
FB28: u1 = 0,
/// FB29 [29:29]
/// Filter bits
FB29: u1 = 0,
/// FB30 [30:30]
/// Filter bits
FB30: u1 = 0,
/// FB31 [31:31]
/// Filter bits
FB31: u1 = 0,
};
/// Filter bank 22 register 2
pub const F22R2 = Register(F22R2_val).init(base_address + 0x2f4);

/// F23R1
const F23R1_val = packed struct {
/// FB0 [0:0]
/// Filter bits
FB0: u1 = 0,
/// FB1 [1:1]
/// Filter bits
FB1: u1 = 0,
/// FB2 [2:2]
/// Filter bits
FB2: u1 = 0,
/// FB3 [3:3]
/// Filter bits
FB3: u1 = 0,
/// FB4 [4:4]
/// Filter bits
FB4: u1 = 0,
/// FB5 [5:5]
/// Filter bits
FB5: u1 = 0,
/// FB6 [6:6]
/// Filter bits
FB6: u1 = 0,
/// FB7 [7:7]
/// Filter bits
FB7: u1 = 0,
/// FB8 [8:8]
/// Filter bits
FB8: u1 = 0,
/// FB9 [9:9]
/// Filter bits
FB9: u1 = 0,
/// FB10 [10:10]
/// Filter bits
FB10: u1 = 0,
/// FB11 [11:11]
/// Filter bits
FB11: u1 = 0,
/// FB12 [12:12]
/// Filter bits
FB12: u1 = 0,
/// FB13 [13:13]
/// Filter bits
FB13: u1 = 0,
/// FB14 [14:14]
/// Filter bits
FB14: u1 = 0,
/// FB15 [15:15]
/// Filter bits
FB15: u1 = 0,
/// FB16 [16:16]
/// Filter bits
FB16: u1 = 0,
/// FB17 [17:17]
/// Filter bits
FB17: u1 = 0,
/// FB18 [18:18]
/// Filter bits
FB18: u1 = 0,
/// FB19 [19:19]
/// Filter bits
FB19: u1 = 0,
/// FB20 [20:20]
/// Filter bits
FB20: u1 = 0,
/// FB21 [21:21]
/// Filter bits
FB21: u1 = 0,
/// FB22 [22:22]
/// Filter bits
FB22: u1 = 0,
/// FB23 [23:23]
/// Filter bits
FB23: u1 = 0,
/// FB24 [24:24]
/// Filter bits
FB24: u1 = 0,
/// FB25 [25:25]
/// Filter bits
FB25: u1 = 0,
/// FB26 [26:26]
/// Filter bits
FB26: u1 = 0,
/// FB27 [27:27]
/// Filter bits
FB27: u1 = 0,
/// FB28 [28:28]
/// Filter bits
FB28: u1 = 0,
/// FB29 [29:29]
/// Filter bits
FB29: u1 = 0,
/// FB30 [30:30]
/// Filter bits
FB30: u1 = 0,
/// FB31 [31:31]
/// Filter bits
FB31: u1 = 0,
};
/// Filter bank 23 register 1
pub const F23R1 = Register(F23R1_val).init(base_address + 0x2f8);

/// F23R2
const F23R2_val = packed struct {
/// FB0 [0:0]
/// Filter bits
FB0: u1 = 0,
/// FB1 [1:1]
/// Filter bits
FB1: u1 = 0,
/// FB2 [2:2]
/// Filter bits
FB2: u1 = 0,
/// FB3 [3:3]
/// Filter bits
FB3: u1 = 0,
/// FB4 [4:4]
/// Filter bits
FB4: u1 = 0,
/// FB5 [5:5]
/// Filter bits
FB5: u1 = 0,
/// FB6 [6:6]
/// Filter bits
FB6: u1 = 0,
/// FB7 [7:7]
/// Filter bits
FB7: u1 = 0,
/// FB8 [8:8]
/// Filter bits
FB8: u1 = 0,
/// FB9 [9:9]
/// Filter bits
FB9: u1 = 0,
/// FB10 [10:10]
/// Filter bits
FB10: u1 = 0,
/// FB11 [11:11]
/// Filter bits
FB11: u1 = 0,
/// FB12 [12:12]
/// Filter bits
FB12: u1 = 0,
/// FB13 [13:13]
/// Filter bits
FB13: u1 = 0,
/// FB14 [14:14]
/// Filter bits
FB14: u1 = 0,
/// FB15 [15:15]
/// Filter bits
FB15: u1 = 0,
/// FB16 [16:16]
/// Filter bits
FB16: u1 = 0,
/// FB17 [17:17]
/// Filter bits
FB17: u1 = 0,
/// FB18 [18:18]
/// Filter bits
FB18: u1 = 0,
/// FB19 [19:19]
/// Filter bits
FB19: u1 = 0,
/// FB20 [20:20]
/// Filter bits
FB20: u1 = 0,
/// FB21 [21:21]
/// Filter bits
FB21: u1 = 0,
/// FB22 [22:22]
/// Filter bits
FB22: u1 = 0,
/// FB23 [23:23]
/// Filter bits
FB23: u1 = 0,
/// FB24 [24:24]
/// Filter bits
FB24: u1 = 0,
/// FB25 [25:25]
/// Filter bits
FB25: u1 = 0,
/// FB26 [26:26]
/// Filter bits
FB26: u1 = 0,
/// FB27 [27:27]
/// Filter bits
FB27: u1 = 0,
/// FB28 [28:28]
/// Filter bits
FB28: u1 = 0,
/// FB29 [29:29]
/// Filter bits
FB29: u1 = 0,
/// FB30 [30:30]
/// Filter bits
FB30: u1 = 0,
/// FB31 [31:31]
/// Filter bits
FB31: u1 = 0,
};
/// Filter bank 23 register 2
pub const F23R2 = Register(F23R2_val).init(base_address + 0x2fc);

/// F24R1
const F24R1_val = packed struct {
/// FB0 [0:0]
/// Filter bits
FB0: u1 = 0,
/// FB1 [1:1]
/// Filter bits
FB1: u1 = 0,
/// FB2 [2:2]
/// Filter bits
FB2: u1 = 0,
/// FB3 [3:3]
/// Filter bits
FB3: u1 = 0,
/// FB4 [4:4]
/// Filter bits
FB4: u1 = 0,
/// FB5 [5:5]
/// Filter bits
FB5: u1 = 0,
/// FB6 [6:6]
/// Filter bits
FB6: u1 = 0,
/// FB7 [7:7]
/// Filter bits
FB7: u1 = 0,
/// FB8 [8:8]
/// Filter bits
FB8: u1 = 0,
/// FB9 [9:9]
/// Filter bits
FB9: u1 = 0,
/// FB10 [10:10]
/// Filter bits
FB10: u1 = 0,
/// FB11 [11:11]
/// Filter bits
FB11: u1 = 0,
/// FB12 [12:12]
/// Filter bits
FB12: u1 = 0,
/// FB13 [13:13]
/// Filter bits
FB13: u1 = 0,
/// FB14 [14:14]
/// Filter bits
FB14: u1 = 0,
/// FB15 [15:15]
/// Filter bits
FB15: u1 = 0,
/// FB16 [16:16]
/// Filter bits
FB16: u1 = 0,
/// FB17 [17:17]
/// Filter bits
FB17: u1 = 0,
/// FB18 [18:18]
/// Filter bits
FB18: u1 = 0,
/// FB19 [19:19]
/// Filter bits
FB19: u1 = 0,
/// FB20 [20:20]
/// Filter bits
FB20: u1 = 0,
/// FB21 [21:21]
/// Filter bits
FB21: u1 = 0,
/// FB22 [22:22]
/// Filter bits
FB22: u1 = 0,
/// FB23 [23:23]
/// Filter bits
FB23: u1 = 0,
/// FB24 [24:24]
/// Filter bits
FB24: u1 = 0,
/// FB25 [25:25]
/// Filter bits
FB25: u1 = 0,
/// FB26 [26:26]
/// Filter bits
FB26: u1 = 0,
/// FB27 [27:27]
/// Filter bits
FB27: u1 = 0,
/// FB28 [28:28]
/// Filter bits
FB28: u1 = 0,
/// FB29 [29:29]
/// Filter bits
FB29: u1 = 0,
/// FB30 [30:30]
/// Filter bits
FB30: u1 = 0,
/// FB31 [31:31]
/// Filter bits
FB31: u1 = 0,
};
/// Filter bank 24 register 1
pub const F24R1 = Register(F24R1_val).init(base_address + 0x300);

/// F24R2
const F24R2_val = packed struct {
/// FB0 [0:0]
/// Filter bits
FB0: u1 = 0,
/// FB1 [1:1]
/// Filter bits
FB1: u1 = 0,
/// FB2 [2:2]
/// Filter bits
FB2: u1 = 0,
/// FB3 [3:3]
/// Filter bits
FB3: u1 = 0,
/// FB4 [4:4]
/// Filter bits
FB4: u1 = 0,
/// FB5 [5:5]
/// Filter bits
FB5: u1 = 0,
/// FB6 [6:6]
/// Filter bits
FB6: u1 = 0,
/// FB7 [7:7]
/// Filter bits
FB7: u1 = 0,
/// FB8 [8:8]
/// Filter bits
FB8: u1 = 0,
/// FB9 [9:9]
/// Filter bits
FB9: u1 = 0,
/// FB10 [10:10]
/// Filter bits
FB10: u1 = 0,
/// FB11 [11:11]
/// Filter bits
FB11: u1 = 0,
/// FB12 [12:12]
/// Filter bits
FB12: u1 = 0,
/// FB13 [13:13]
/// Filter bits
FB13: u1 = 0,
/// FB14 [14:14]
/// Filter bits
FB14: u1 = 0,
/// FB15 [15:15]
/// Filter bits
FB15: u1 = 0,
/// FB16 [16:16]
/// Filter bits
FB16: u1 = 0,
/// FB17 [17:17]
/// Filter bits
FB17: u1 = 0,
/// FB18 [18:18]
/// Filter bits
FB18: u1 = 0,
/// FB19 [19:19]
/// Filter bits
FB19: u1 = 0,
/// FB20 [20:20]
/// Filter bits
FB20: u1 = 0,
/// FB21 [21:21]
/// Filter bits
FB21: u1 = 0,
/// FB22 [22:22]
/// Filter bits
FB22: u1 = 0,
/// FB23 [23:23]
/// Filter bits
FB23: u1 = 0,
/// FB24 [24:24]
/// Filter bits
FB24: u1 = 0,
/// FB25 [25:25]
/// Filter bits
FB25: u1 = 0,
/// FB26 [26:26]
/// Filter bits
FB26: u1 = 0,
/// FB27 [27:27]
/// Filter bits
FB27: u1 = 0,
/// FB28 [28:28]
/// Filter bits
FB28: u1 = 0,
/// FB29 [29:29]
/// Filter bits
FB29: u1 = 0,
/// FB30 [30:30]
/// Filter bits
FB30: u1 = 0,
/// FB31 [31:31]
/// Filter bits
FB31: u1 = 0,
};
/// Filter bank 24 register 2
pub const F24R2 = Register(F24R2_val).init(base_address + 0x304);

/// F25R1
const F25R1_val = packed struct {
/// FB0 [0:0]
/// Filter bits
FB0: u1 = 0,
/// FB1 [1:1]
/// Filter bits
FB1: u1 = 0,
/// FB2 [2:2]
/// Filter bits
FB2: u1 = 0,
/// FB3 [3:3]
/// Filter bits
FB3: u1 = 0,
/// FB4 [4:4]
/// Filter bits
FB4: u1 = 0,
/// FB5 [5:5]
/// Filter bits
FB5: u1 = 0,
/// FB6 [6:6]
/// Filter bits
FB6: u1 = 0,
/// FB7 [7:7]
/// Filter bits
FB7: u1 = 0,
/// FB8 [8:8]
/// Filter bits
FB8: u1 = 0,
/// FB9 [9:9]
/// Filter bits
FB9: u1 = 0,
/// FB10 [10:10]
/// Filter bits
FB10: u1 = 0,
/// FB11 [11:11]
/// Filter bits
FB11: u1 = 0,
/// FB12 [12:12]
/// Filter bits
FB12: u1 = 0,
/// FB13 [13:13]
/// Filter bits
FB13: u1 = 0,
/// FB14 [14:14]
/// Filter bits
FB14: u1 = 0,
/// FB15 [15:15]
/// Filter bits
FB15: u1 = 0,
/// FB16 [16:16]
/// Filter bits
FB16: u1 = 0,
/// FB17 [17:17]
/// Filter bits
FB17: u1 = 0,
/// FB18 [18:18]
/// Filter bits
FB18: u1 = 0,
/// FB19 [19:19]
/// Filter bits
FB19: u1 = 0,
/// FB20 [20:20]
/// Filter bits
FB20: u1 = 0,
/// FB21 [21:21]
/// Filter bits
FB21: u1 = 0,
/// FB22 [22:22]
/// Filter bits
FB22: u1 = 0,
/// FB23 [23:23]
/// Filter bits
FB23: u1 = 0,
/// FB24 [24:24]
/// Filter bits
FB24: u1 = 0,
/// FB25 [25:25]
/// Filter bits
FB25: u1 = 0,
/// FB26 [26:26]
/// Filter bits
FB26: u1 = 0,
/// FB27 [27:27]
/// Filter bits
FB27: u1 = 0,
/// FB28 [28:28]
/// Filter bits
FB28: u1 = 0,
/// FB29 [29:29]
/// Filter bits
FB29: u1 = 0,
/// FB30 [30:30]
/// Filter bits
FB30: u1 = 0,
/// FB31 [31:31]
/// Filter bits
FB31: u1 = 0,
};
/// Filter bank 25 register 1
pub const F25R1 = Register(F25R1_val).init(base_address + 0x308);

/// F25R2
const F25R2_val = packed struct {
/// FB0 [0:0]
/// Filter bits
FB0: u1 = 0,
/// FB1 [1:1]
/// Filter bits
FB1: u1 = 0,
/// FB2 [2:2]
/// Filter bits
FB2: u1 = 0,
/// FB3 [3:3]
/// Filter bits
FB3: u1 = 0,
/// FB4 [4:4]
/// Filter bits
FB4: u1 = 0,
/// FB5 [5:5]
/// Filter bits
FB5: u1 = 0,
/// FB6 [6:6]
/// Filter bits
FB6: u1 = 0,
/// FB7 [7:7]
/// Filter bits
FB7: u1 = 0,
/// FB8 [8:8]
/// Filter bits
FB8: u1 = 0,
/// FB9 [9:9]
/// Filter bits
FB9: u1 = 0,
/// FB10 [10:10]
/// Filter bits
FB10: u1 = 0,
/// FB11 [11:11]
/// Filter bits
FB11: u1 = 0,
/// FB12 [12:12]
/// Filter bits
FB12: u1 = 0,
/// FB13 [13:13]
/// Filter bits
FB13: u1 = 0,
/// FB14 [14:14]
/// Filter bits
FB14: u1 = 0,
/// FB15 [15:15]
/// Filter bits
FB15: u1 = 0,
/// FB16 [16:16]
/// Filter bits
FB16: u1 = 0,
/// FB17 [17:17]
/// Filter bits
FB17: u1 = 0,
/// FB18 [18:18]
/// Filter bits
FB18: u1 = 0,
/// FB19 [19:19]
/// Filter bits
FB19: u1 = 0,
/// FB20 [20:20]
/// Filter bits
FB20: u1 = 0,
/// FB21 [21:21]
/// Filter bits
FB21: u1 = 0,
/// FB22 [22:22]
/// Filter bits
FB22: u1 = 0,
/// FB23 [23:23]
/// Filter bits
FB23: u1 = 0,
/// FB24 [24:24]
/// Filter bits
FB24: u1 = 0,
/// FB25 [25:25]
/// Filter bits
FB25: u1 = 0,
/// FB26 [26:26]
/// Filter bits
FB26: u1 = 0,
/// FB27 [27:27]
/// Filter bits
FB27: u1 = 0,
/// FB28 [28:28]
/// Filter bits
FB28: u1 = 0,
/// FB29 [29:29]
/// Filter bits
FB29: u1 = 0,
/// FB30 [30:30]
/// Filter bits
FB30: u1 = 0,
/// FB31 [31:31]
/// Filter bits
FB31: u1 = 0,
};
/// Filter bank 25 register 2
pub const F25R2 = Register(F25R2_val).init(base_address + 0x30c);

/// F26R1
const F26R1_val = packed struct {
/// FB0 [0:0]
/// Filter bits
FB0: u1 = 0,
/// FB1 [1:1]
/// Filter bits
FB1: u1 = 0,
/// FB2 [2:2]
/// Filter bits
FB2: u1 = 0,
/// FB3 [3:3]
/// Filter bits
FB3: u1 = 0,
/// FB4 [4:4]
/// Filter bits
FB4: u1 = 0,
/// FB5 [5:5]
/// Filter bits
FB5: u1 = 0,
/// FB6 [6:6]
/// Filter bits
FB6: u1 = 0,
/// FB7 [7:7]
/// Filter bits
FB7: u1 = 0,
/// FB8 [8:8]
/// Filter bits
FB8: u1 = 0,
/// FB9 [9:9]
/// Filter bits
FB9: u1 = 0,
/// FB10 [10:10]
/// Filter bits
FB10: u1 = 0,
/// FB11 [11:11]
/// Filter bits
FB11: u1 = 0,
/// FB12 [12:12]
/// Filter bits
FB12: u1 = 0,
/// FB13 [13:13]
/// Filter bits
FB13: u1 = 0,
/// FB14 [14:14]
/// Filter bits
FB14: u1 = 0,
/// FB15 [15:15]
/// Filter bits
FB15: u1 = 0,
/// FB16 [16:16]
/// Filter bits
FB16: u1 = 0,
/// FB17 [17:17]
/// Filter bits
FB17: u1 = 0,
/// FB18 [18:18]
/// Filter bits
FB18: u1 = 0,
/// FB19 [19:19]
/// Filter bits
FB19: u1 = 0,
/// FB20 [20:20]
/// Filter bits
FB20: u1 = 0,
/// FB21 [21:21]
/// Filter bits
FB21: u1 = 0,
/// FB22 [22:22]
/// Filter bits
FB22: u1 = 0,
/// FB23 [23:23]
/// Filter bits
FB23: u1 = 0,
/// FB24 [24:24]
/// Filter bits
FB24: u1 = 0,
/// FB25 [25:25]
/// Filter bits
FB25: u1 = 0,
/// FB26 [26:26]
/// Filter bits
FB26: u1 = 0,
/// FB27 [27:27]
/// Filter bits
FB27: u1 = 0,
/// FB28 [28:28]
/// Filter bits
FB28: u1 = 0,
/// FB29 [29:29]
/// Filter bits
FB29: u1 = 0,
/// FB30 [30:30]
/// Filter bits
FB30: u1 = 0,
/// FB31 [31:31]
/// Filter bits
FB31: u1 = 0,
};
/// Filter bank 26 register 1
pub const F26R1 = Register(F26R1_val).init(base_address + 0x310);

/// F26R2
const F26R2_val = packed struct {
/// FB0 [0:0]
/// Filter bits
FB0: u1 = 0,
/// FB1 [1:1]
/// Filter bits
FB1: u1 = 0,
/// FB2 [2:2]
/// Filter bits
FB2: u1 = 0,
/// FB3 [3:3]
/// Filter bits
FB3: u1 = 0,
/// FB4 [4:4]
/// Filter bits
FB4: u1 = 0,
/// FB5 [5:5]
/// Filter bits
FB5: u1 = 0,
/// FB6 [6:6]
/// Filter bits
FB6: u1 = 0,
/// FB7 [7:7]
/// Filter bits
FB7: u1 = 0,
/// FB8 [8:8]
/// Filter bits
FB8: u1 = 0,
/// FB9 [9:9]
/// Filter bits
FB9: u1 = 0,
/// FB10 [10:10]
/// Filter bits
FB10: u1 = 0,
/// FB11 [11:11]
/// Filter bits
FB11: u1 = 0,
/// FB12 [12:12]
/// Filter bits
FB12: u1 = 0,
/// FB13 [13:13]
/// Filter bits
FB13: u1 = 0,
/// FB14 [14:14]
/// Filter bits
FB14: u1 = 0,
/// FB15 [15:15]
/// Filter bits
FB15: u1 = 0,
/// FB16 [16:16]
/// Filter bits
FB16: u1 = 0,
/// FB17 [17:17]
/// Filter bits
FB17: u1 = 0,
/// FB18 [18:18]
/// Filter bits
FB18: u1 = 0,
/// FB19 [19:19]
/// Filter bits
FB19: u1 = 0,
/// FB20 [20:20]
/// Filter bits
FB20: u1 = 0,
/// FB21 [21:21]
/// Filter bits
FB21: u1 = 0,
/// FB22 [22:22]
/// Filter bits
FB22: u1 = 0,
/// FB23 [23:23]
/// Filter bits
FB23: u1 = 0,
/// FB24 [24:24]
/// Filter bits
FB24: u1 = 0,
/// FB25 [25:25]
/// Filter bits
FB25: u1 = 0,
/// FB26 [26:26]
/// Filter bits
FB26: u1 = 0,
/// FB27 [27:27]
/// Filter bits
FB27: u1 = 0,
/// FB28 [28:28]
/// Filter bits
FB28: u1 = 0,
/// FB29 [29:29]
/// Filter bits
FB29: u1 = 0,
/// FB30 [30:30]
/// Filter bits
FB30: u1 = 0,
/// FB31 [31:31]
/// Filter bits
FB31: u1 = 0,
};
/// Filter bank 26 register 2
pub const F26R2 = Register(F26R2_val).init(base_address + 0x314);

/// F27R1
const F27R1_val = packed struct {
/// FB0 [0:0]
/// Filter bits
FB0: u1 = 0,
/// FB1 [1:1]
/// Filter bits
FB1: u1 = 0,
/// FB2 [2:2]
/// Filter bits
FB2: u1 = 0,
/// FB3 [3:3]
/// Filter bits
FB3: u1 = 0,
/// FB4 [4:4]
/// Filter bits
FB4: u1 = 0,
/// FB5 [5:5]
/// Filter bits
FB5: u1 = 0,
/// FB6 [6:6]
/// Filter bits
FB6: u1 = 0,
/// FB7 [7:7]
/// Filter bits
FB7: u1 = 0,
/// FB8 [8:8]
/// Filter bits
FB8: u1 = 0,
/// FB9 [9:9]
/// Filter bits
FB9: u1 = 0,
/// FB10 [10:10]
/// Filter bits
FB10: u1 = 0,
/// FB11 [11:11]
/// Filter bits
FB11: u1 = 0,
/// FB12 [12:12]
/// Filter bits
FB12: u1 = 0,
/// FB13 [13:13]
/// Filter bits
FB13: u1 = 0,
/// FB14 [14:14]
/// Filter bits
FB14: u1 = 0,
/// FB15 [15:15]
/// Filter bits
FB15: u1 = 0,
/// FB16 [16:16]
/// Filter bits
FB16: u1 = 0,
/// FB17 [17:17]
/// Filter bits
FB17: u1 = 0,
/// FB18 [18:18]
/// Filter bits
FB18: u1 = 0,
/// FB19 [19:19]
/// Filter bits
FB19: u1 = 0,
/// FB20 [20:20]
/// Filter bits
FB20: u1 = 0,
/// FB21 [21:21]
/// Filter bits
FB21: u1 = 0,
/// FB22 [22:22]
/// Filter bits
FB22: u1 = 0,
/// FB23 [23:23]
/// Filter bits
FB23: u1 = 0,
/// FB24 [24:24]
/// Filter bits
FB24: u1 = 0,
/// FB25 [25:25]
/// Filter bits
FB25: u1 = 0,
/// FB26 [26:26]
/// Filter bits
FB26: u1 = 0,
/// FB27 [27:27]
/// Filter bits
FB27: u1 = 0,
/// FB28 [28:28]
/// Filter bits
FB28: u1 = 0,
/// FB29 [29:29]
/// Filter bits
FB29: u1 = 0,
/// FB30 [30:30]
/// Filter bits
FB30: u1 = 0,
/// FB31 [31:31]
/// Filter bits
FB31: u1 = 0,
};
/// Filter bank 27 register 1
pub const F27R1 = Register(F27R1_val).init(base_address + 0x318);

/// F27R2
const F27R2_val = packed struct {
/// FB0 [0:0]
/// Filter bits
FB0: u1 = 0,
/// FB1 [1:1]
/// Filter bits
FB1: u1 = 0,
/// FB2 [2:2]
/// Filter bits
FB2: u1 = 0,
/// FB3 [3:3]
/// Filter bits
FB3: u1 = 0,
/// FB4 [4:4]
/// Filter bits
FB4: u1 = 0,
/// FB5 [5:5]
/// Filter bits
FB5: u1 = 0,
/// FB6 [6:6]
/// Filter bits
FB6: u1 = 0,
/// FB7 [7:7]
/// Filter bits
FB7: u1 = 0,
/// FB8 [8:8]
/// Filter bits
FB8: u1 = 0,
/// FB9 [9:9]
/// Filter bits
FB9: u1 = 0,
/// FB10 [10:10]
/// Filter bits
FB10: u1 = 0,
/// FB11 [11:11]
/// Filter bits
FB11: u1 = 0,
/// FB12 [12:12]
/// Filter bits
FB12: u1 = 0,
/// FB13 [13:13]
/// Filter bits
FB13: u1 = 0,
/// FB14 [14:14]
/// Filter bits
FB14: u1 = 0,
/// FB15 [15:15]
/// Filter bits
FB15: u1 = 0,
/// FB16 [16:16]
/// Filter bits
FB16: u1 = 0,
/// FB17 [17:17]
/// Filter bits
FB17: u1 = 0,
/// FB18 [18:18]
/// Filter bits
FB18: u1 = 0,
/// FB19 [19:19]
/// Filter bits
FB19: u1 = 0,
/// FB20 [20:20]
/// Filter bits
FB20: u1 = 0,
/// FB21 [21:21]
/// Filter bits
FB21: u1 = 0,
/// FB22 [22:22]
/// Filter bits
FB22: u1 = 0,
/// FB23 [23:23]
/// Filter bits
FB23: u1 = 0,
/// FB24 [24:24]
/// Filter bits
FB24: u1 = 0,
/// FB25 [25:25]
/// Filter bits
FB25: u1 = 0,
/// FB26 [26:26]
/// Filter bits
FB26: u1 = 0,
/// FB27 [27:27]
/// Filter bits
FB27: u1 = 0,
/// FB28 [28:28]
/// Filter bits
FB28: u1 = 0,
/// FB29 [29:29]
/// Filter bits
FB29: u1 = 0,
/// FB30 [30:30]
/// Filter bits
FB30: u1 = 0,
/// FB31 [31:31]
/// Filter bits
FB31: u1 = 0,
};
/// Filter bank 27 register 2
pub const F27R2 = Register(F27R2_val).init(base_address + 0x31c);
};

/// Universal serial bus full-speed device
pub const USB_FS = struct {

const base_address = 0x40005c00;
/// USB_EP0R
const USB_EP0R_val = packed struct {
/// EA [0:3]
/// Endpoint address
EA: u4 = 0,
/// STAT_TX [4:5]
/// Status bits, for transmission
STAT_TX: u2 = 0,
/// DTOG_TX [6:6]
/// Data Toggle, for transmission
DTOG_TX: u1 = 0,
/// CTR_TX [7:7]
/// Correct Transfer for
CTR_TX: u1 = 0,
/// EP_KIND [8:8]
/// Endpoint kind
EP_KIND: u1 = 0,
/// EP_TYPE [9:10]
/// Endpoint type
EP_TYPE: u2 = 0,
/// SETUP [11:11]
/// Setup transaction
SETUP: u1 = 0,
/// STAT_RX [12:13]
/// Status bits, for reception
STAT_RX: u2 = 0,
/// DTOG_RX [14:14]
/// Data Toggle, for reception
DTOG_RX: u1 = 0,
/// CTR_RX [15:15]
/// Correct transfer for
CTR_RX: u1 = 0,
/// unused [16:31]
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// endpoint 0 register
pub const USB_EP0R = Register(USB_EP0R_val).init(base_address + 0x0);

/// USB_EP1R
const USB_EP1R_val = packed struct {
/// EA [0:3]
/// Endpoint address
EA: u4 = 0,
/// STAT_TX [4:5]
/// Status bits, for transmission
STAT_TX: u2 = 0,
/// DTOG_TX [6:6]
/// Data Toggle, for transmission
DTOG_TX: u1 = 0,
/// CTR_TX [7:7]
/// Correct Transfer for
CTR_TX: u1 = 0,
/// EP_KIND [8:8]
/// Endpoint kind
EP_KIND: u1 = 0,
/// EP_TYPE [9:10]
/// Endpoint type
EP_TYPE: u2 = 0,
/// SETUP [11:11]
/// Setup transaction
SETUP: u1 = 0,
/// STAT_RX [12:13]
/// Status bits, for reception
STAT_RX: u2 = 0,
/// DTOG_RX [14:14]
/// Data Toggle, for reception
DTOG_RX: u1 = 0,
/// CTR_RX [15:15]
/// Correct transfer for
CTR_RX: u1 = 0,
/// unused [16:31]
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// endpoint 1 register
pub const USB_EP1R = Register(USB_EP1R_val).init(base_address + 0x4);

/// USB_EP2R
const USB_EP2R_val = packed struct {
/// EA [0:3]
/// Endpoint address
EA: u4 = 0,
/// STAT_TX [4:5]
/// Status bits, for transmission
STAT_TX: u2 = 0,
/// DTOG_TX [6:6]
/// Data Toggle, for transmission
DTOG_TX: u1 = 0,
/// CTR_TX [7:7]
/// Correct Transfer for
CTR_TX: u1 = 0,
/// EP_KIND [8:8]
/// Endpoint kind
EP_KIND: u1 = 0,
/// EP_TYPE [9:10]
/// Endpoint type
EP_TYPE: u2 = 0,
/// SETUP [11:11]
/// Setup transaction
SETUP: u1 = 0,
/// STAT_RX [12:13]
/// Status bits, for reception
STAT_RX: u2 = 0,
/// DTOG_RX [14:14]
/// Data Toggle, for reception
DTOG_RX: u1 = 0,
/// CTR_RX [15:15]
/// Correct transfer for
CTR_RX: u1 = 0,
/// unused [16:31]
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// endpoint 2 register
pub const USB_EP2R = Register(USB_EP2R_val).init(base_address + 0x8);

/// USB_EP3R
const USB_EP3R_val = packed struct {
/// EA [0:3]
/// Endpoint address
EA: u4 = 0,
/// STAT_TX [4:5]
/// Status bits, for transmission
STAT_TX: u2 = 0,
/// DTOG_TX [6:6]
/// Data Toggle, for transmission
DTOG_TX: u1 = 0,
/// CTR_TX [7:7]
/// Correct Transfer for
CTR_TX: u1 = 0,
/// EP_KIND [8:8]
/// Endpoint kind
EP_KIND: u1 = 0,
/// EP_TYPE [9:10]
/// Endpoint type
EP_TYPE: u2 = 0,
/// SETUP [11:11]
/// Setup transaction
SETUP: u1 = 0,
/// STAT_RX [12:13]
/// Status bits, for reception
STAT_RX: u2 = 0,
/// DTOG_RX [14:14]
/// Data Toggle, for reception
DTOG_RX: u1 = 0,
/// CTR_RX [15:15]
/// Correct transfer for
CTR_RX: u1 = 0,
/// unused [16:31]
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// endpoint 3 register
pub const USB_EP3R = Register(USB_EP3R_val).init(base_address + 0xc);

/// USB_EP4R
const USB_EP4R_val = packed struct {
/// EA [0:3]
/// Endpoint address
EA: u4 = 0,
/// STAT_TX [4:5]
/// Status bits, for transmission
STAT_TX: u2 = 0,
/// DTOG_TX [6:6]
/// Data Toggle, for transmission
DTOG_TX: u1 = 0,
/// CTR_TX [7:7]
/// Correct Transfer for
CTR_TX: u1 = 0,
/// EP_KIND [8:8]
/// Endpoint kind
EP_KIND: u1 = 0,
/// EP_TYPE [9:10]
/// Endpoint type
EP_TYPE: u2 = 0,
/// SETUP [11:11]
/// Setup transaction
SETUP: u1 = 0,
/// STAT_RX [12:13]
/// Status bits, for reception
STAT_RX: u2 = 0,
/// DTOG_RX [14:14]
/// Data Toggle, for reception
DTOG_RX: u1 = 0,
/// CTR_RX [15:15]
/// Correct transfer for
CTR_RX: u1 = 0,
/// unused [16:31]
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// endpoint 4 register
pub const USB_EP4R = Register(USB_EP4R_val).init(base_address + 0x10);

/// USB_EP5R
const USB_EP5R_val = packed struct {
/// EA [0:3]
/// Endpoint address
EA: u4 = 0,
/// STAT_TX [4:5]
/// Status bits, for transmission
STAT_TX: u2 = 0,
/// DTOG_TX [6:6]
/// Data Toggle, for transmission
DTOG_TX: u1 = 0,
/// CTR_TX [7:7]
/// Correct Transfer for
CTR_TX: u1 = 0,
/// EP_KIND [8:8]
/// Endpoint kind
EP_KIND: u1 = 0,
/// EP_TYPE [9:10]
/// Endpoint type
EP_TYPE: u2 = 0,
/// SETUP [11:11]
/// Setup transaction
SETUP: u1 = 0,
/// STAT_RX [12:13]
/// Status bits, for reception
STAT_RX: u2 = 0,
/// DTOG_RX [14:14]
/// Data Toggle, for reception
DTOG_RX: u1 = 0,
/// CTR_RX [15:15]
/// Correct transfer for
CTR_RX: u1 = 0,
/// unused [16:31]
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// endpoint 5 register
pub const USB_EP5R = Register(USB_EP5R_val).init(base_address + 0x14);

/// USB_EP6R
const USB_EP6R_val = packed struct {
/// EA [0:3]
/// Endpoint address
EA: u4 = 0,
/// STAT_TX [4:5]
/// Status bits, for transmission
STAT_TX: u2 = 0,
/// DTOG_TX [6:6]
/// Data Toggle, for transmission
DTOG_TX: u1 = 0,
/// CTR_TX [7:7]
/// Correct Transfer for
CTR_TX: u1 = 0,
/// EP_KIND [8:8]
/// Endpoint kind
EP_KIND: u1 = 0,
/// EP_TYPE [9:10]
/// Endpoint type
EP_TYPE: u2 = 0,
/// SETUP [11:11]
/// Setup transaction
SETUP: u1 = 0,
/// STAT_RX [12:13]
/// Status bits, for reception
STAT_RX: u2 = 0,
/// DTOG_RX [14:14]
/// Data Toggle, for reception
DTOG_RX: u1 = 0,
/// CTR_RX [15:15]
/// Correct transfer for
CTR_RX: u1 = 0,
/// unused [16:31]
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// endpoint 6 register
pub const USB_EP6R = Register(USB_EP6R_val).init(base_address + 0x18);

/// USB_EP7R
const USB_EP7R_val = packed struct {
/// EA [0:3]
/// Endpoint address
EA: u4 = 0,
/// STAT_TX [4:5]
/// Status bits, for transmission
STAT_TX: u2 = 0,
/// DTOG_TX [6:6]
/// Data Toggle, for transmission
DTOG_TX: u1 = 0,
/// CTR_TX [7:7]
/// Correct Transfer for
CTR_TX: u1 = 0,
/// EP_KIND [8:8]
/// Endpoint kind
EP_KIND: u1 = 0,
/// EP_TYPE [9:10]
/// Endpoint type
EP_TYPE: u2 = 0,
/// SETUP [11:11]
/// Setup transaction
SETUP: u1 = 0,
/// STAT_RX [12:13]
/// Status bits, for reception
STAT_RX: u2 = 0,
/// DTOG_RX [14:14]
/// Data Toggle, for reception
DTOG_RX: u1 = 0,
/// CTR_RX [15:15]
/// Correct transfer for
CTR_RX: u1 = 0,
/// unused [16:31]
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// endpoint 7 register
pub const USB_EP7R = Register(USB_EP7R_val).init(base_address + 0x1c);

/// USB_CNTR
const USB_CNTR_val = packed struct {
/// FRES [0:0]
/// Force USB Reset
FRES: u1 = 1,
/// PDWN [1:1]
/// Power down
PDWN: u1 = 1,
/// LPMODE [2:2]
/// Low-power mode
LPMODE: u1 = 0,
/// FSUSP [3:3]
/// Force suspend
FSUSP: u1 = 0,
/// RESUME [4:4]
/// Resume request
RESUME: u1 = 0,
/// unused [5:7]
_unused5: u3 = 0,
/// ESOFM [8:8]
/// Expected start of frame interrupt
ESOFM: u1 = 0,
/// SOFM [9:9]
/// Start of frame interrupt
SOFM: u1 = 0,
/// RESETM [10:10]
/// USB reset interrupt mask
RESETM: u1 = 0,
/// SUSPM [11:11]
/// Suspend mode interrupt
SUSPM: u1 = 0,
/// WKUPM [12:12]
/// Wakeup interrupt mask
WKUPM: u1 = 0,
/// ERRM [13:13]
/// Error interrupt mask
ERRM: u1 = 0,
/// PMAOVRM [14:14]
/// Packet memory area over / underrun
PMAOVRM: u1 = 0,
/// CTRM [15:15]
/// Correct transfer interrupt
CTRM: u1 = 0,
/// unused [16:31]
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// control register
pub const USB_CNTR = Register(USB_CNTR_val).init(base_address + 0x40);

/// ISTR
const ISTR_val = packed struct {
/// EP_ID [0:3]
/// Endpoint Identifier
EP_ID: u4 = 0,
/// DIR [4:4]
/// Direction of transaction
DIR: u1 = 0,
/// unused [5:7]
_unused5: u3 = 0,
/// ESOF [8:8]
/// Expected start frame
ESOF: u1 = 0,
/// SOF [9:9]
/// start of frame
SOF: u1 = 0,
/// RESET [10:10]
/// reset request
RESET: u1 = 0,
/// SUSP [11:11]
/// Suspend mode request
SUSP: u1 = 0,
/// WKUP [12:12]
/// Wakeup
WKUP: u1 = 0,
/// ERR [13:13]
/// Error
ERR: u1 = 0,
/// PMAOVR [14:14]
/// Packet memory area over /
PMAOVR: u1 = 0,
/// CTR [15:15]
/// Correct transfer
CTR: u1 = 0,
/// unused [16:31]
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// interrupt status register
pub const ISTR = Register(ISTR_val).init(base_address + 0x44);

/// FNR
const FNR_val = packed struct {
/// FN [0:10]
/// Frame number
FN: u11 = 0,
/// LSOF [11:12]
/// Lost SOF
LSOF: u2 = 0,
/// LCK [13:13]
/// Locked
LCK: u1 = 0,
/// RXDM [14:14]
/// Receive data - line status
RXDM: u1 = 0,
/// RXDP [15:15]
/// Receive data + line status
RXDP: u1 = 0,
/// unused [16:31]
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// frame number register
pub const FNR = Register(FNR_val).init(base_address + 0x48);

/// DADDR
const DADDR_val = packed struct {
/// ADD [0:0]
/// Device address
ADD: u1 = 0,
/// ADD1 [1:1]
/// Device address
ADD1: u1 = 0,
/// ADD2 [2:2]
/// Device address
ADD2: u1 = 0,
/// ADD3 [3:3]
/// Device address
ADD3: u1 = 0,
/// ADD4 [4:4]
/// Device address
ADD4: u1 = 0,
/// ADD5 [5:5]
/// Device address
ADD5: u1 = 0,
/// ADD6 [6:6]
/// Device address
ADD6: u1 = 0,
/// EF [7:7]
/// Enable function
EF: u1 = 0,
/// unused [8:31]
_unused8: u8 = 0,
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// device address
pub const DADDR = Register(DADDR_val).init(base_address + 0x4c);

/// BTABLE
const BTABLE_val = packed struct {
/// unused [0:2]
_unused0: u3 = 0,
/// BTABLE [3:15]
/// Buffer table
BTABLE: u13 = 0,
/// unused [16:31]
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// Buffer table address
pub const BTABLE = Register(BTABLE_val).init(base_address + 0x50);
};

/// Inter-integrated circuit
pub const I2C1 = struct {

const base_address = 0x40005400;
/// CR1
const CR1_val = packed struct {
/// PE [0:0]
/// Peripheral enable
PE: u1 = 0,
/// TXIE [1:1]
/// TX Interrupt enable
TXIE: u1 = 0,
/// RXIE [2:2]
/// RX Interrupt enable
RXIE: u1 = 0,
/// ADDRIE [3:3]
/// Address match interrupt enable (slave
ADDRIE: u1 = 0,
/// NACKIE [4:4]
/// Not acknowledge received interrupt
NACKIE: u1 = 0,
/// STOPIE [5:5]
/// STOP detection Interrupt
STOPIE: u1 = 0,
/// TCIE [6:6]
/// Transfer Complete interrupt
TCIE: u1 = 0,
/// ERRIE [7:7]
/// Error interrupts enable
ERRIE: u1 = 0,
/// DNF [8:11]
/// Digital noise filter
DNF: u4 = 0,
/// ANFOFF [12:12]
/// Analog noise filter OFF
ANFOFF: u1 = 0,
/// SWRST [13:13]
/// Software reset
SWRST: u1 = 0,
/// TXDMAEN [14:14]
/// DMA transmission requests
TXDMAEN: u1 = 0,
/// RXDMAEN [15:15]
/// DMA reception requests
RXDMAEN: u1 = 0,
/// SBC [16:16]
/// Slave byte control
SBC: u1 = 0,
/// NOSTRETCH [17:17]
/// Clock stretching disable
NOSTRETCH: u1 = 0,
/// WUPEN [18:18]
/// Wakeup from STOP enable
WUPEN: u1 = 0,
/// GCEN [19:19]
/// General call enable
GCEN: u1 = 0,
/// SMBHEN [20:20]
/// SMBus Host address enable
SMBHEN: u1 = 0,
/// SMBDEN [21:21]
/// SMBus Device Default address
SMBDEN: u1 = 0,
/// ALERTEN [22:22]
/// SMBUS alert enable
ALERTEN: u1 = 0,
/// PECEN [23:23]
/// PEC enable
PECEN: u1 = 0,
/// unused [24:31]
_unused24: u8 = 0,
};
/// Control register 1
pub const CR1 = Register(CR1_val).init(base_address + 0x0);

/// CR2
const CR2_val = packed struct {
/// SADD0 [0:0]
/// Slave address bit 0 (master
SADD0: u1 = 0,
/// SADD1 [1:7]
/// Slave address bit 7:1 (master
SADD1: u7 = 0,
/// SADD8 [8:9]
/// Slave address bit 9:8 (master
SADD8: u2 = 0,
/// RD_WRN [10:10]
/// Transfer direction (master
RD_WRN: u1 = 0,
/// ADD10 [11:11]
/// 10-bit addressing mode (master
ADD10: u1 = 0,
/// HEAD10R [12:12]
/// 10-bit address header only read
HEAD10R: u1 = 0,
/// START [13:13]
/// Start generation
START: u1 = 0,
/// STOP [14:14]
/// Stop generation (master
STOP: u1 = 0,
/// NACK [15:15]
/// NACK generation (slave
NACK: u1 = 0,
/// NBYTES [16:23]
/// Number of bytes
NBYTES: u8 = 0,
/// RELOAD [24:24]
/// NBYTES reload mode
RELOAD: u1 = 0,
/// AUTOEND [25:25]
/// Automatic end mode (master
AUTOEND: u1 = 0,
/// PECBYTE [26:26]
/// Packet error checking byte
PECBYTE: u1 = 0,
/// unused [27:31]
_unused27: u5 = 0,
};
/// Control register 2
pub const CR2 = Register(CR2_val).init(base_address + 0x4);

/// OAR1
const OAR1_val = packed struct {
/// OA1_0 [0:0]
/// Interface address
OA1_0: u1 = 0,
/// OA1_1 [1:7]
/// Interface address
OA1_1: u7 = 0,
/// OA1_8 [8:9]
/// Interface address
OA1_8: u2 = 0,
/// OA1MODE [10:10]
/// Own Address 1 10-bit mode
OA1MODE: u1 = 0,
/// unused [11:14]
_unused11: u4 = 0,
/// OA1EN [15:15]
/// Own Address 1 enable
OA1EN: u1 = 0,
/// unused [16:31]
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// Own address register 1
pub const OAR1 = Register(OAR1_val).init(base_address + 0x8);

/// OAR2
const OAR2_val = packed struct {
/// unused [0:0]
_unused0: u1 = 0,
/// OA2 [1:7]
/// Interface address
OA2: u7 = 0,
/// OA2MSK [8:10]
/// Own Address 2 masks
OA2MSK: u3 = 0,
/// unused [11:14]
_unused11: u4 = 0,
/// OA2EN [15:15]
/// Own Address 2 enable
OA2EN: u1 = 0,
/// unused [16:31]
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// Own address register 2
pub const OAR2 = Register(OAR2_val).init(base_address + 0xc);

/// TIMINGR
const TIMINGR_val = packed struct {
/// SCLL [0:7]
/// SCL low period (master
SCLL: u8 = 0,
/// SCLH [8:15]
/// SCL high period (master
SCLH: u8 = 0,
/// SDADEL [16:19]
/// Data hold time
SDADEL: u4 = 0,
/// SCLDEL [20:23]
/// Data setup time
SCLDEL: u4 = 0,
/// unused [24:27]
_unused24: u4 = 0,
/// PRESC [28:31]
/// Timing prescaler
PRESC: u4 = 0,
};
/// Timing register
pub const TIMINGR = Register(TIMINGR_val).init(base_address + 0x10);

/// TIMEOUTR
const TIMEOUTR_val = packed struct {
/// TIMEOUTA [0:11]
/// Bus timeout A
TIMEOUTA: u12 = 0,
/// TIDLE [12:12]
/// Idle clock timeout
TIDLE: u1 = 0,
/// unused [13:14]
_unused13: u2 = 0,
/// TIMOUTEN [15:15]
/// Clock timeout enable
TIMOUTEN: u1 = 0,
/// TIMEOUTB [16:27]
/// Bus timeout B
TIMEOUTB: u12 = 0,
/// unused [28:30]
_unused28: u3 = 0,
/// TEXTEN [31:31]
/// Extended clock timeout
TEXTEN: u1 = 0,
};
/// Status register 1
pub const TIMEOUTR = Register(TIMEOUTR_val).init(base_address + 0x14);

/// ISR
const ISR_val = packed struct {
/// TXE [0:0]
/// Transmit data register empty
TXE: u1 = 1,
/// TXIS [1:1]
/// Transmit interrupt status
TXIS: u1 = 0,
/// RXNE [2:2]
/// Receive data register not empty
RXNE: u1 = 0,
/// ADDR [3:3]
/// Address matched (slave
ADDR: u1 = 0,
/// NACKF [4:4]
/// Not acknowledge received
NACKF: u1 = 0,
/// STOPF [5:5]
/// Stop detection flag
STOPF: u1 = 0,
/// TC [6:6]
/// Transfer Complete (master
TC: u1 = 0,
/// TCR [7:7]
/// Transfer Complete Reload
TCR: u1 = 0,
/// BERR [8:8]
/// Bus error
BERR: u1 = 0,
/// ARLO [9:9]
/// Arbitration lost
ARLO: u1 = 0,
/// OVR [10:10]
/// Overrun/Underrun (slave
OVR: u1 = 0,
/// PECERR [11:11]
/// PEC Error in reception
PECERR: u1 = 0,
/// TIMEOUT [12:12]
/// Timeout or t_low detection
TIMEOUT: u1 = 0,
/// ALERT [13:13]
/// SMBus alert
ALERT: u1 = 0,
/// unused [14:14]
_unused14: u1 = 0,
/// BUSY [15:15]
/// Bus busy
BUSY: u1 = 0,
/// DIR [16:16]
/// Transfer direction (Slave
DIR: u1 = 0,
/// ADDCODE [17:23]
/// Address match code (Slave
ADDCODE: u7 = 0,
/// unused [24:31]
_unused24: u8 = 0,
};
/// Interrupt and Status register
pub const ISR = Register(ISR_val).init(base_address + 0x18);

/// ICR
const ICR_val = packed struct {
/// unused [0:2]
_unused0: u3 = 0,
/// ADDRCF [3:3]
/// Address Matched flag clear
ADDRCF: u1 = 0,
/// NACKCF [4:4]
/// Not Acknowledge flag clear
NACKCF: u1 = 0,
/// STOPCF [5:5]
/// Stop detection flag clear
STOPCF: u1 = 0,
/// unused [6:7]
_unused6: u2 = 0,
/// BERRCF [8:8]
/// Bus error flag clear
BERRCF: u1 = 0,
/// ARLOCF [9:9]
/// Arbitration lost flag
ARLOCF: u1 = 0,
/// OVRCF [10:10]
/// Overrun/Underrun flag
OVRCF: u1 = 0,
/// PECCF [11:11]
/// PEC Error flag clear
PECCF: u1 = 0,
/// TIMOUTCF [12:12]
/// Timeout detection flag
TIMOUTCF: u1 = 0,
/// ALERTCF [13:13]
/// Alert flag clear
ALERTCF: u1 = 0,
/// unused [14:31]
_unused14: u2 = 0,
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// Interrupt clear register
pub const ICR = Register(ICR_val).init(base_address + 0x1c);

/// PECR
const PECR_val = packed struct {
/// PEC [0:7]
/// Packet error checking
PEC: u8 = 0,
/// unused [8:31]
_unused8: u8 = 0,
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// PEC register
pub const PECR = Register(PECR_val).init(base_address + 0x20);

/// RXDR
const RXDR_val = packed struct {
/// RXDATA [0:7]
/// 8-bit receive data
RXDATA: u8 = 0,
/// unused [8:31]
_unused8: u8 = 0,
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// Receive data register
pub const RXDR = Register(RXDR_val).init(base_address + 0x24);

/// TXDR
const TXDR_val = packed struct {
/// TXDATA [0:7]
/// 8-bit transmit data
TXDATA: u8 = 0,
/// unused [8:31]
_unused8: u8 = 0,
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// Transmit data register
pub const TXDR = Register(TXDR_val).init(base_address + 0x28);
};

/// Inter-integrated circuit
pub const I2C2 = struct {

const base_address = 0x40005800;
/// CR1
const CR1_val = packed struct {
/// PE [0:0]
/// Peripheral enable
PE: u1 = 0,
/// TXIE [1:1]
/// TX Interrupt enable
TXIE: u1 = 0,
/// RXIE [2:2]
/// RX Interrupt enable
RXIE: u1 = 0,
/// ADDRIE [3:3]
/// Address match interrupt enable (slave
ADDRIE: u1 = 0,
/// NACKIE [4:4]
/// Not acknowledge received interrupt
NACKIE: u1 = 0,
/// STOPIE [5:5]
/// STOP detection Interrupt
STOPIE: u1 = 0,
/// TCIE [6:6]
/// Transfer Complete interrupt
TCIE: u1 = 0,
/// ERRIE [7:7]
/// Error interrupts enable
ERRIE: u1 = 0,
/// DNF [8:11]
/// Digital noise filter
DNF: u4 = 0,
/// ANFOFF [12:12]
/// Analog noise filter OFF
ANFOFF: u1 = 0,
/// SWRST [13:13]
/// Software reset
SWRST: u1 = 0,
/// TXDMAEN [14:14]
/// DMA transmission requests
TXDMAEN: u1 = 0,
/// RXDMAEN [15:15]
/// DMA reception requests
RXDMAEN: u1 = 0,
/// SBC [16:16]
/// Slave byte control
SBC: u1 = 0,
/// NOSTRETCH [17:17]
/// Clock stretching disable
NOSTRETCH: u1 = 0,
/// WUPEN [18:18]
/// Wakeup from STOP enable
WUPEN: u1 = 0,
/// GCEN [19:19]
/// General call enable
GCEN: u1 = 0,
/// SMBHEN [20:20]
/// SMBus Host address enable
SMBHEN: u1 = 0,
/// SMBDEN [21:21]
/// SMBus Device Default address
SMBDEN: u1 = 0,
/// ALERTEN [22:22]
/// SMBUS alert enable
ALERTEN: u1 = 0,
/// PECEN [23:23]
/// PEC enable
PECEN: u1 = 0,
/// unused [24:31]
_unused24: u8 = 0,
};
/// Control register 1
pub const CR1 = Register(CR1_val).init(base_address + 0x0);

/// CR2
const CR2_val = packed struct {
/// SADD0 [0:0]
/// Slave address bit 0 (master
SADD0: u1 = 0,
/// SADD1 [1:7]
/// Slave address bit 7:1 (master
SADD1: u7 = 0,
/// SADD8 [8:9]
/// Slave address bit 9:8 (master
SADD8: u2 = 0,
/// RD_WRN [10:10]
/// Transfer direction (master
RD_WRN: u1 = 0,
/// ADD10 [11:11]
/// 10-bit addressing mode (master
ADD10: u1 = 0,
/// HEAD10R [12:12]
/// 10-bit address header only read
HEAD10R: u1 = 0,
/// START [13:13]
/// Start generation
START: u1 = 0,
/// STOP [14:14]
/// Stop generation (master
STOP: u1 = 0,
/// NACK [15:15]
/// NACK generation (slave
NACK: u1 = 0,
/// NBYTES [16:23]
/// Number of bytes
NBYTES: u8 = 0,
/// RELOAD [24:24]
/// NBYTES reload mode
RELOAD: u1 = 0,
/// AUTOEND [25:25]
/// Automatic end mode (master
AUTOEND: u1 = 0,
/// PECBYTE [26:26]
/// Packet error checking byte
PECBYTE: u1 = 0,
/// unused [27:31]
_unused27: u5 = 0,
};
/// Control register 2
pub const CR2 = Register(CR2_val).init(base_address + 0x4);

/// OAR1
const OAR1_val = packed struct {
/// OA1_0 [0:0]
/// Interface address
OA1_0: u1 = 0,
/// OA1_1 [1:7]
/// Interface address
OA1_1: u7 = 0,
/// OA1_8 [8:9]
/// Interface address
OA1_8: u2 = 0,
/// OA1MODE [10:10]
/// Own Address 1 10-bit mode
OA1MODE: u1 = 0,
/// unused [11:14]
_unused11: u4 = 0,
/// OA1EN [15:15]
/// Own Address 1 enable
OA1EN: u1 = 0,
/// unused [16:31]
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// Own address register 1
pub const OAR1 = Register(OAR1_val).init(base_address + 0x8);

/// OAR2
const OAR2_val = packed struct {
/// unused [0:0]
_unused0: u1 = 0,
/// OA2 [1:7]
/// Interface address
OA2: u7 = 0,
/// OA2MSK [8:10]
/// Own Address 2 masks
OA2MSK: u3 = 0,
/// unused [11:14]
_unused11: u4 = 0,
/// OA2EN [15:15]
/// Own Address 2 enable
OA2EN: u1 = 0,
/// unused [16:31]
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// Own address register 2
pub const OAR2 = Register(OAR2_val).init(base_address + 0xc);

/// TIMINGR
const TIMINGR_val = packed struct {
/// SCLL [0:7]
/// SCL low period (master
SCLL: u8 = 0,
/// SCLH [8:15]
/// SCL high period (master
SCLH: u8 = 0,
/// SDADEL [16:19]
/// Data hold time
SDADEL: u4 = 0,
/// SCLDEL [20:23]
/// Data setup time
SCLDEL: u4 = 0,
/// unused [24:27]
_unused24: u4 = 0,
/// PRESC [28:31]
/// Timing prescaler
PRESC: u4 = 0,
};
/// Timing register
pub const TIMINGR = Register(TIMINGR_val).init(base_address + 0x10);

/// TIMEOUTR
const TIMEOUTR_val = packed struct {
/// TIMEOUTA [0:11]
/// Bus timeout A
TIMEOUTA: u12 = 0,
/// TIDLE [12:12]
/// Idle clock timeout
TIDLE: u1 = 0,
/// unused [13:14]
_unused13: u2 = 0,
/// TIMOUTEN [15:15]
/// Clock timeout enable
TIMOUTEN: u1 = 0,
/// TIMEOUTB [16:27]
/// Bus timeout B
TIMEOUTB: u12 = 0,
/// unused [28:30]
_unused28: u3 = 0,
/// TEXTEN [31:31]
/// Extended clock timeout
TEXTEN: u1 = 0,
};
/// Status register 1
pub const TIMEOUTR = Register(TIMEOUTR_val).init(base_address + 0x14);

/// ISR
const ISR_val = packed struct {
/// TXE [0:0]
/// Transmit data register empty
TXE: u1 = 1,
/// TXIS [1:1]
/// Transmit interrupt status
TXIS: u1 = 0,
/// RXNE [2:2]
/// Receive data register not empty
RXNE: u1 = 0,
/// ADDR [3:3]
/// Address matched (slave
ADDR: u1 = 0,
/// NACKF [4:4]
/// Not acknowledge received
NACKF: u1 = 0,
/// STOPF [5:5]
/// Stop detection flag
STOPF: u1 = 0,
/// TC [6:6]
/// Transfer Complete (master
TC: u1 = 0,
/// TCR [7:7]
/// Transfer Complete Reload
TCR: u1 = 0,
/// BERR [8:8]
/// Bus error
BERR: u1 = 0,
/// ARLO [9:9]
/// Arbitration lost
ARLO: u1 = 0,
/// OVR [10:10]
/// Overrun/Underrun (slave
OVR: u1 = 0,
/// PECERR [11:11]
/// PEC Error in reception
PECERR: u1 = 0,
/// TIMEOUT [12:12]
/// Timeout or t_low detection
TIMEOUT: u1 = 0,
/// ALERT [13:13]
/// SMBus alert
ALERT: u1 = 0,
/// unused [14:14]
_unused14: u1 = 0,
/// BUSY [15:15]
/// Bus busy
BUSY: u1 = 0,
/// DIR [16:16]
/// Transfer direction (Slave
DIR: u1 = 0,
/// ADDCODE [17:23]
/// Address match code (Slave
ADDCODE: u7 = 0,
/// unused [24:31]
_unused24: u8 = 0,
};
/// Interrupt and Status register
pub const ISR = Register(ISR_val).init(base_address + 0x18);

/// ICR
const ICR_val = packed struct {
/// unused [0:2]
_unused0: u3 = 0,
/// ADDRCF [3:3]
/// Address Matched flag clear
ADDRCF: u1 = 0,
/// NACKCF [4:4]
/// Not Acknowledge flag clear
NACKCF: u1 = 0,
/// STOPCF [5:5]
/// Stop detection flag clear
STOPCF: u1 = 0,
/// unused [6:7]
_unused6: u2 = 0,
/// BERRCF [8:8]
/// Bus error flag clear
BERRCF: u1 = 0,
/// ARLOCF [9:9]
/// Arbitration lost flag
ARLOCF: u1 = 0,
/// OVRCF [10:10]
/// Overrun/Underrun flag
OVRCF: u1 = 0,
/// PECCF [11:11]
/// PEC Error flag clear
PECCF: u1 = 0,
/// TIMOUTCF [12:12]
/// Timeout detection flag
TIMOUTCF: u1 = 0,
/// ALERTCF [13:13]
/// Alert flag clear
ALERTCF: u1 = 0,
/// unused [14:31]
_unused14: u2 = 0,
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// Interrupt clear register
pub const ICR = Register(ICR_val).init(base_address + 0x1c);

/// PECR
const PECR_val = packed struct {
/// PEC [0:7]
/// Packet error checking
PEC: u8 = 0,
/// unused [8:31]
_unused8: u8 = 0,
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// PEC register
pub const PECR = Register(PECR_val).init(base_address + 0x20);

/// RXDR
const RXDR_val = packed struct {
/// RXDATA [0:7]
/// 8-bit receive data
RXDATA: u8 = 0,
/// unused [8:31]
_unused8: u8 = 0,
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// Receive data register
pub const RXDR = Register(RXDR_val).init(base_address + 0x24);

/// TXDR
const TXDR_val = packed struct {
/// TXDATA [0:7]
/// 8-bit transmit data
TXDATA: u8 = 0,
/// unused [8:31]
_unused8: u8 = 0,
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// Transmit data register
pub const TXDR = Register(TXDR_val).init(base_address + 0x28);
};

/// Inter-integrated circuit
pub const I2C3 = struct {

const base_address = 0x40007800;
/// CR1
const CR1_val = packed struct {
/// PE [0:0]
/// Peripheral enable
PE: u1 = 0,
/// TXIE [1:1]
/// TX Interrupt enable
TXIE: u1 = 0,
/// RXIE [2:2]
/// RX Interrupt enable
RXIE: u1 = 0,
/// ADDRIE [3:3]
/// Address match interrupt enable (slave
ADDRIE: u1 = 0,
/// NACKIE [4:4]
/// Not acknowledge received interrupt
NACKIE: u1 = 0,
/// STOPIE [5:5]
/// STOP detection Interrupt
STOPIE: u1 = 0,
/// TCIE [6:6]
/// Transfer Complete interrupt
TCIE: u1 = 0,
/// ERRIE [7:7]
/// Error interrupts enable
ERRIE: u1 = 0,
/// DNF [8:11]
/// Digital noise filter
DNF: u4 = 0,
/// ANFOFF [12:12]
/// Analog noise filter OFF
ANFOFF: u1 = 0,
/// SWRST [13:13]
/// Software reset
SWRST: u1 = 0,
/// TXDMAEN [14:14]
/// DMA transmission requests
TXDMAEN: u1 = 0,
/// RXDMAEN [15:15]
/// DMA reception requests
RXDMAEN: u1 = 0,
/// SBC [16:16]
/// Slave byte control
SBC: u1 = 0,
/// NOSTRETCH [17:17]
/// Clock stretching disable
NOSTRETCH: u1 = 0,
/// WUPEN [18:18]
/// Wakeup from STOP enable
WUPEN: u1 = 0,
/// GCEN [19:19]
/// General call enable
GCEN: u1 = 0,
/// SMBHEN [20:20]
/// SMBus Host address enable
SMBHEN: u1 = 0,
/// SMBDEN [21:21]
/// SMBus Device Default address
SMBDEN: u1 = 0,
/// ALERTEN [22:22]
/// SMBUS alert enable
ALERTEN: u1 = 0,
/// PECEN [23:23]
/// PEC enable
PECEN: u1 = 0,
/// unused [24:31]
_unused24: u8 = 0,
};
/// Control register 1
pub const CR1 = Register(CR1_val).init(base_address + 0x0);

/// CR2
const CR2_val = packed struct {
/// SADD0 [0:0]
/// Slave address bit 0 (master
SADD0: u1 = 0,
/// SADD1 [1:7]
/// Slave address bit 7:1 (master
SADD1: u7 = 0,
/// SADD8 [8:9]
/// Slave address bit 9:8 (master
SADD8: u2 = 0,
/// RD_WRN [10:10]
/// Transfer direction (master
RD_WRN: u1 = 0,
/// ADD10 [11:11]
/// 10-bit addressing mode (master
ADD10: u1 = 0,
/// HEAD10R [12:12]
/// 10-bit address header only read
HEAD10R: u1 = 0,
/// START [13:13]
/// Start generation
START: u1 = 0,
/// STOP [14:14]
/// Stop generation (master
STOP: u1 = 0,
/// NACK [15:15]
/// NACK generation (slave
NACK: u1 = 0,
/// NBYTES [16:23]
/// Number of bytes
NBYTES: u8 = 0,
/// RELOAD [24:24]
/// NBYTES reload mode
RELOAD: u1 = 0,
/// AUTOEND [25:25]
/// Automatic end mode (master
AUTOEND: u1 = 0,
/// PECBYTE [26:26]
/// Packet error checking byte
PECBYTE: u1 = 0,
/// unused [27:31]
_unused27: u5 = 0,
};
/// Control register 2
pub const CR2 = Register(CR2_val).init(base_address + 0x4);

/// OAR1
const OAR1_val = packed struct {
/// OA1_0 [0:0]
/// Interface address
OA1_0: u1 = 0,
/// OA1_1 [1:7]
/// Interface address
OA1_1: u7 = 0,
/// OA1_8 [8:9]
/// Interface address
OA1_8: u2 = 0,
/// OA1MODE [10:10]
/// Own Address 1 10-bit mode
OA1MODE: u1 = 0,
/// unused [11:14]
_unused11: u4 = 0,
/// OA1EN [15:15]
/// Own Address 1 enable
OA1EN: u1 = 0,
/// unused [16:31]
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// Own address register 1
pub const OAR1 = Register(OAR1_val).init(base_address + 0x8);

/// OAR2
const OAR2_val = packed struct {
/// unused [0:0]
_unused0: u1 = 0,
/// OA2 [1:7]
/// Interface address
OA2: u7 = 0,
/// OA2MSK [8:10]
/// Own Address 2 masks
OA2MSK: u3 = 0,
/// unused [11:14]
_unused11: u4 = 0,
/// OA2EN [15:15]
/// Own Address 2 enable
OA2EN: u1 = 0,
/// unused [16:31]
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// Own address register 2
pub const OAR2 = Register(OAR2_val).init(base_address + 0xc);

/// TIMINGR
const TIMINGR_val = packed struct {
/// SCLL [0:7]
/// SCL low period (master
SCLL: u8 = 0,
/// SCLH [8:15]
/// SCL high period (master
SCLH: u8 = 0,
/// SDADEL [16:19]
/// Data hold time
SDADEL: u4 = 0,
/// SCLDEL [20:23]
/// Data setup time
SCLDEL: u4 = 0,
/// unused [24:27]
_unused24: u4 = 0,
/// PRESC [28:31]
/// Timing prescaler
PRESC: u4 = 0,
};
/// Timing register
pub const TIMINGR = Register(TIMINGR_val).init(base_address + 0x10);

/// TIMEOUTR
const TIMEOUTR_val = packed struct {
/// TIMEOUTA [0:11]
/// Bus timeout A
TIMEOUTA: u12 = 0,
/// TIDLE [12:12]
/// Idle clock timeout
TIDLE: u1 = 0,
/// unused [13:14]
_unused13: u2 = 0,
/// TIMOUTEN [15:15]
/// Clock timeout enable
TIMOUTEN: u1 = 0,
/// TIMEOUTB [16:27]
/// Bus timeout B
TIMEOUTB: u12 = 0,
/// unused [28:30]
_unused28: u3 = 0,
/// TEXTEN [31:31]
/// Extended clock timeout
TEXTEN: u1 = 0,
};
/// Status register 1
pub const TIMEOUTR = Register(TIMEOUTR_val).init(base_address + 0x14);

/// ISR
const ISR_val = packed struct {
/// TXE [0:0]
/// Transmit data register empty
TXE: u1 = 1,
/// TXIS [1:1]
/// Transmit interrupt status
TXIS: u1 = 0,
/// RXNE [2:2]
/// Receive data register not empty
RXNE: u1 = 0,
/// ADDR [3:3]
/// Address matched (slave
ADDR: u1 = 0,
/// NACKF [4:4]
/// Not acknowledge received
NACKF: u1 = 0,
/// STOPF [5:5]
/// Stop detection flag
STOPF: u1 = 0,
/// TC [6:6]
/// Transfer Complete (master
TC: u1 = 0,
/// TCR [7:7]
/// Transfer Complete Reload
TCR: u1 = 0,
/// BERR [8:8]
/// Bus error
BERR: u1 = 0,
/// ARLO [9:9]
/// Arbitration lost
ARLO: u1 = 0,
/// OVR [10:10]
/// Overrun/Underrun (slave
OVR: u1 = 0,
/// PECERR [11:11]
/// PEC Error in reception
PECERR: u1 = 0,
/// TIMEOUT [12:12]
/// Timeout or t_low detection
TIMEOUT: u1 = 0,
/// ALERT [13:13]
/// SMBus alert
ALERT: u1 = 0,
/// unused [14:14]
_unused14: u1 = 0,
/// BUSY [15:15]
/// Bus busy
BUSY: u1 = 0,
/// DIR [16:16]
/// Transfer direction (Slave
DIR: u1 = 0,
/// ADDCODE [17:23]
/// Address match code (Slave
ADDCODE: u7 = 0,
/// unused [24:31]
_unused24: u8 = 0,
};
/// Interrupt and Status register
pub const ISR = Register(ISR_val).init(base_address + 0x18);

/// ICR
const ICR_val = packed struct {
/// unused [0:2]
_unused0: u3 = 0,
/// ADDRCF [3:3]
/// Address Matched flag clear
ADDRCF: u1 = 0,
/// NACKCF [4:4]
/// Not Acknowledge flag clear
NACKCF: u1 = 0,
/// STOPCF [5:5]
/// Stop detection flag clear
STOPCF: u1 = 0,
/// unused [6:7]
_unused6: u2 = 0,
/// BERRCF [8:8]
/// Bus error flag clear
BERRCF: u1 = 0,
/// ARLOCF [9:9]
/// Arbitration lost flag
ARLOCF: u1 = 0,
/// OVRCF [10:10]
/// Overrun/Underrun flag
OVRCF: u1 = 0,
/// PECCF [11:11]
/// PEC Error flag clear
PECCF: u1 = 0,
/// TIMOUTCF [12:12]
/// Timeout detection flag
TIMOUTCF: u1 = 0,
/// ALERTCF [13:13]
/// Alert flag clear
ALERTCF: u1 = 0,
/// unused [14:31]
_unused14: u2 = 0,
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// Interrupt clear register
pub const ICR = Register(ICR_val).init(base_address + 0x1c);

/// PECR
const PECR_val = packed struct {
/// PEC [0:7]
/// Packet error checking
PEC: u8 = 0,
/// unused [8:31]
_unused8: u8 = 0,
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// PEC register
pub const PECR = Register(PECR_val).init(base_address + 0x20);

/// RXDR
const RXDR_val = packed struct {
/// RXDATA [0:7]
/// 8-bit receive data
RXDATA: u8 = 0,
/// unused [8:31]
_unused8: u8 = 0,
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// Receive data register
pub const RXDR = Register(RXDR_val).init(base_address + 0x24);

/// TXDR
const TXDR_val = packed struct {
/// TXDATA [0:7]
/// 8-bit transmit data
TXDATA: u8 = 0,
/// unused [8:31]
_unused8: u8 = 0,
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// Transmit data register
pub const TXDR = Register(TXDR_val).init(base_address + 0x28);
};

/// Independent watchdog
pub const IWDG = struct {

const base_address = 0x40003000;
/// KR
const KR_val = packed struct {
/// KEY [0:15]
/// Key value
KEY: u16 = 0,
/// unused [16:31]
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// Key register
pub const KR = Register(KR_val).init(base_address + 0x0);

/// PR
const PR_val = packed struct {
/// PR [0:2]
/// Prescaler divider
PR: u3 = 0,
/// unused [3:31]
_unused3: u5 = 0,
_unused8: u8 = 0,
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// Prescaler register
pub const PR = Register(PR_val).init(base_address + 0x4);

/// RLR
const RLR_val = packed struct {
/// RL [0:11]
/// Watchdog counter reload
RL: u12 = 4095,
/// unused [12:31]
_unused12: u4 = 0,
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// Reload register
pub const RLR = Register(RLR_val).init(base_address + 0x8);

/// SR
const SR_val = packed struct {
/// PVU [0:0]
/// Watchdog prescaler value
PVU: u1 = 0,
/// RVU [1:1]
/// Watchdog counter reload value
RVU: u1 = 0,
/// WVU [2:2]
/// Watchdog counter window value
WVU: u1 = 0,
/// unused [3:31]
_unused3: u5 = 0,
_unused8: u8 = 0,
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// Status register
pub const SR = Register(SR_val).init(base_address + 0xc);

/// WINR
const WINR_val = packed struct {
/// WIN [0:11]
/// Watchdog counter window
WIN: u12 = 4095,
/// unused [12:31]
_unused12: u4 = 0,
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// Window register
pub const WINR = Register(WINR_val).init(base_address + 0x10);
};

/// Window watchdog
pub const WWDG = struct {

const base_address = 0x40002c00;
/// CR
const CR_val = packed struct {
/// T [0:6]
/// 7-bit counter
T: u7 = 127,
/// WDGA [7:7]
/// Activation bit
WDGA: u1 = 0,
/// unused [8:31]
_unused8: u8 = 0,
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// Control register
pub const CR = Register(CR_val).init(base_address + 0x0);

/// CFR
const CFR_val = packed struct {
/// W [0:6]
/// 7-bit window value
W: u7 = 127,
/// WDGTB [7:8]
/// Timer base
WDGTB: u2 = 0,
/// EWI [9:9]
/// Early wakeup interrupt
EWI: u1 = 0,
/// unused [10:31]
_unused10: u6 = 0,
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// Configuration register
pub const CFR = Register(CFR_val).init(base_address + 0x4);

/// SR
const SR_val = packed struct {
/// EWIF [0:0]
/// Early wakeup interrupt
EWIF: u1 = 0,
/// unused [1:31]
_unused1: u7 = 0,
_unused8: u8 = 0,
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// Status register
pub const SR = Register(SR_val).init(base_address + 0x8);
};

/// Real-time clock
pub const RTC = struct {

const base_address = 0x40002800;
/// TR
const TR_val = packed struct {
/// SU [0:3]
/// Second units in BCD format
SU: u4 = 0,
/// ST [4:6]
/// Second tens in BCD format
ST: u3 = 0,
/// unused [7:7]
_unused7: u1 = 0,
/// MNU [8:11]
/// Minute units in BCD format
MNU: u4 = 0,
/// MNT [12:14]
/// Minute tens in BCD format
MNT: u3 = 0,
/// unused [15:15]
_unused15: u1 = 0,
/// HU [16:19]
/// Hour units in BCD format
HU: u4 = 0,
/// HT [20:21]
/// Hour tens in BCD format
HT: u2 = 0,
/// PM [22:22]
/// AM/PM notation
PM: u1 = 0,
/// unused [23:31]
_unused23: u1 = 0,
_unused24: u8 = 0,
};
/// time register
pub const TR = Register(TR_val).init(base_address + 0x0);

/// DR
const DR_val = packed struct {
/// DU [0:3]
/// Date units in BCD format
DU: u4 = 1,
/// DT [4:5]
/// Date tens in BCD format
DT: u2 = 0,
/// unused [6:7]
_unused6: u2 = 0,
/// MU [8:11]
/// Month units in BCD format
MU: u4 = 1,
/// MT [12:12]
/// Month tens in BCD format
MT: u1 = 0,
/// WDU [13:15]
/// Week day units
WDU: u3 = 1,
/// YU [16:19]
/// Year units in BCD format
YU: u4 = 0,
/// YT [20:23]
/// Year tens in BCD format
YT: u4 = 0,
/// unused [24:31]
_unused24: u8 = 0,
};
/// date register
pub const DR = Register(DR_val).init(base_address + 0x4);

/// CR
const CR_val = packed struct {
/// WCKSEL [0:2]
/// Wakeup clock selection
WCKSEL: u3 = 0,
/// TSEDGE [3:3]
/// Time-stamp event active
TSEDGE: u1 = 0,
/// REFCKON [4:4]
/// Reference clock detection enable (50 or
REFCKON: u1 = 0,
/// BYPSHAD [5:5]
/// Bypass the shadow
BYPSHAD: u1 = 0,
/// FMT [6:6]
/// Hour format
FMT: u1 = 0,
/// unused [7:7]
_unused7: u1 = 0,
/// ALRAE [8:8]
/// Alarm A enable
ALRAE: u1 = 0,
/// ALRBE [9:9]
/// Alarm B enable
ALRBE: u1 = 0,
/// WUTE [10:10]
/// Wakeup timer enable
WUTE: u1 = 0,
/// TSE [11:11]
/// Time stamp enable
TSE: u1 = 0,
/// ALRAIE [12:12]
/// Alarm A interrupt enable
ALRAIE: u1 = 0,
/// ALRBIE [13:13]
/// Alarm B interrupt enable
ALRBIE: u1 = 0,
/// WUTIE [14:14]
/// Wakeup timer interrupt
WUTIE: u1 = 0,
/// TSIE [15:15]
/// Time-stamp interrupt
TSIE: u1 = 0,
/// ADD1H [16:16]
/// Add 1 hour (summer time
ADD1H: u1 = 0,
/// SUB1H [17:17]
/// Subtract 1 hour (winter time
SUB1H: u1 = 0,
/// BKP [18:18]
/// Backup
BKP: u1 = 0,
/// COSEL [19:19]
/// Calibration output
COSEL: u1 = 0,
/// POL [20:20]
/// Output polarity
POL: u1 = 0,
/// OSEL [21:22]
/// Output selection
OSEL: u2 = 0,
/// COE [23:23]
/// Calibration output enable
COE: u1 = 0,
/// unused [24:31]
_unused24: u8 = 0,
};
/// control register
pub const CR = Register(CR_val).init(base_address + 0x8);

/// ISR
const ISR_val = packed struct {
/// ALRAWF [0:0]
/// Alarm A write flag
ALRAWF: u1 = 1,
/// ALRBWF [1:1]
/// Alarm B write flag
ALRBWF: u1 = 1,
/// WUTWF [2:2]
/// Wakeup timer write flag
WUTWF: u1 = 1,
/// SHPF [3:3]
/// Shift operation pending
SHPF: u1 = 0,
/// INITS [4:4]
/// Initialization status flag
INITS: u1 = 0,
/// RSF [5:5]
/// Registers synchronization
RSF: u1 = 0,
/// INITF [6:6]
/// Initialization flag
INITF: u1 = 0,
/// INIT [7:7]
/// Initialization mode
INIT: u1 = 0,
/// ALRAF [8:8]
/// Alarm A flag
ALRAF: u1 = 0,
/// ALRBF [9:9]
/// Alarm B flag
ALRBF: u1 = 0,
/// WUTF [10:10]
/// Wakeup timer flag
WUTF: u1 = 0,
/// TSF [11:11]
/// Time-stamp flag
TSF: u1 = 0,
/// TSOVF [12:12]
/// Time-stamp overflow flag
TSOVF: u1 = 0,
/// TAMP1F [13:13]
/// Tamper detection flag
TAMP1F: u1 = 0,
/// TAMP2F [14:14]
/// RTC_TAMP2 detection flag
TAMP2F: u1 = 0,
/// TAMP3F [15:15]
/// RTC_TAMP3 detection flag
TAMP3F: u1 = 0,
/// RECALPF [16:16]
/// Recalibration pending Flag
RECALPF: u1 = 0,
/// unused [17:31]
_unused17: u7 = 0,
_unused24: u8 = 0,
};
/// initialization and status
pub const ISR = Register(ISR_val).init(base_address + 0xc);

/// PRER
const PRER_val = packed struct {
/// PREDIV_S [0:14]
/// Synchronous prescaler
PREDIV_S: u15 = 255,
/// unused [15:15]
_unused15: u1 = 0,
/// PREDIV_A [16:22]
/// Asynchronous prescaler
PREDIV_A: u7 = 127,
/// unused [23:31]
_unused23: u1 = 0,
_unused24: u8 = 0,
};
/// prescaler register
pub const PRER = Register(PRER_val).init(base_address + 0x10);

/// WUTR
const WUTR_val = packed struct {
/// WUT [0:15]
/// Wakeup auto-reload value
WUT: u16 = 65535,
/// unused [16:31]
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// wakeup timer register
pub const WUTR = Register(WUTR_val).init(base_address + 0x14);

/// ALRMAR
const ALRMAR_val = packed struct {
/// SU [0:3]
/// Second units in BCD format
SU: u4 = 0,
/// ST [4:6]
/// Second tens in BCD format
ST: u3 = 0,
/// MSK1 [7:7]
/// Alarm A seconds mask
MSK1: u1 = 0,
/// MNU [8:11]
/// Minute units in BCD format
MNU: u4 = 0,
/// MNT [12:14]
/// Minute tens in BCD format
MNT: u3 = 0,
/// MSK2 [15:15]
/// Alarm A minutes mask
MSK2: u1 = 0,
/// HU [16:19]
/// Hour units in BCD format
HU: u4 = 0,
/// HT [20:21]
/// Hour tens in BCD format
HT: u2 = 0,
/// PM [22:22]
/// AM/PM notation
PM: u1 = 0,
/// MSK3 [23:23]
/// Alarm A hours mask
MSK3: u1 = 0,
/// DU [24:27]
/// Date units or day in BCD
DU: u4 = 0,
/// DT [28:29]
/// Date tens in BCD format
DT: u2 = 0,
/// WDSEL [30:30]
/// Week day selection
WDSEL: u1 = 0,
/// MSK4 [31:31]
/// Alarm A date mask
MSK4: u1 = 0,
};
/// alarm A register
pub const ALRMAR = Register(ALRMAR_val).init(base_address + 0x1c);

/// ALRMBR
const ALRMBR_val = packed struct {
/// SU [0:3]
/// Second units in BCD format
SU: u4 = 0,
/// ST [4:6]
/// Second tens in BCD format
ST: u3 = 0,
/// MSK1 [7:7]
/// Alarm B seconds mask
MSK1: u1 = 0,
/// MNU [8:11]
/// Minute units in BCD format
MNU: u4 = 0,
/// MNT [12:14]
/// Minute tens in BCD format
MNT: u3 = 0,
/// MSK2 [15:15]
/// Alarm B minutes mask
MSK2: u1 = 0,
/// HU [16:19]
/// Hour units in BCD format
HU: u4 = 0,
/// HT [20:21]
/// Hour tens in BCD format
HT: u2 = 0,
/// PM [22:22]
/// AM/PM notation
PM: u1 = 0,
/// MSK3 [23:23]
/// Alarm B hours mask
MSK3: u1 = 0,
/// DU [24:27]
/// Date units or day in BCD
DU: u4 = 0,
/// DT [28:29]
/// Date tens in BCD format
DT: u2 = 0,
/// WDSEL [30:30]
/// Week day selection
WDSEL: u1 = 0,
/// MSK4 [31:31]
/// Alarm B date mask
MSK4: u1 = 0,
};
/// alarm B register
pub const ALRMBR = Register(ALRMBR_val).init(base_address + 0x20);

/// WPR
const WPR_val = packed struct {
/// KEY [0:7]
/// Write protection key
KEY: u8 = 0,
/// unused [8:31]
_unused8: u8 = 0,
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// write protection register
pub const WPR = Register(WPR_val).init(base_address + 0x24);

/// SSR
const SSR_val = packed struct {
/// SS [0:15]
/// Sub second value
SS: u16 = 0,
/// unused [16:31]
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// sub second register
pub const SSR = Register(SSR_val).init(base_address + 0x28);

/// SHIFTR
const SHIFTR_val = packed struct {
/// SUBFS [0:14]
/// Subtract a fraction of a
SUBFS: u15 = 0,
/// unused [15:30]
_unused15: u1 = 0,
_unused16: u8 = 0,
_unused24: u7 = 0,
/// ADD1S [31:31]
/// Add one second
ADD1S: u1 = 0,
};
/// shift control register
pub const SHIFTR = Register(SHIFTR_val).init(base_address + 0x2c);

/// TSTR
const TSTR_val = packed struct {
/// SU [0:3]
/// Second units in BCD format
SU: u4 = 0,
/// ST [4:6]
/// Second tens in BCD format
ST: u3 = 0,
/// unused [7:7]
_unused7: u1 = 0,
/// MNU [8:11]
/// Minute units in BCD format
MNU: u4 = 0,
/// MNT [12:14]
/// Minute tens in BCD format
MNT: u3 = 0,
/// unused [15:15]
_unused15: u1 = 0,
/// HU [16:19]
/// Hour units in BCD format
HU: u4 = 0,
/// HT [20:21]
/// Hour tens in BCD format
HT: u2 = 0,
/// PM [22:22]
/// AM/PM notation
PM: u1 = 0,
/// unused [23:31]
_unused23: u1 = 0,
_unused24: u8 = 0,
};
/// time stamp time register
pub const TSTR = Register(TSTR_val).init(base_address + 0x30);

/// TSDR
const TSDR_val = packed struct {
/// DU [0:3]
/// Date units in BCD format
DU: u4 = 0,
/// DT [4:5]
/// Date tens in BCD format
DT: u2 = 0,
/// unused [6:7]
_unused6: u2 = 0,
/// MU [8:11]
/// Month units in BCD format
MU: u4 = 0,
/// MT [12:12]
/// Month tens in BCD format
MT: u1 = 0,
/// WDU [13:15]
/// Week day units
WDU: u3 = 0,
/// unused [16:31]
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// time stamp date register
pub const TSDR = Register(TSDR_val).init(base_address + 0x34);

/// TSSSR
const TSSSR_val = packed struct {
/// SS [0:15]
/// Sub second value
SS: u16 = 0,
/// unused [16:31]
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// timestamp sub second register
pub const TSSSR = Register(TSSSR_val).init(base_address + 0x38);

/// CALR
const CALR_val = packed struct {
/// CALM [0:8]
/// Calibration minus
CALM: u9 = 0,
/// unused [9:12]
_unused9: u4 = 0,
/// CALW16 [13:13]
/// Use a 16-second calibration cycle
CALW16: u1 = 0,
/// CALW8 [14:14]
/// Use an 8-second calibration cycle
CALW8: u1 = 0,
/// CALP [15:15]
/// Increase frequency of RTC by 488.5
CALP: u1 = 0,
/// unused [16:31]
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// calibration register
pub const CALR = Register(CALR_val).init(base_address + 0x3c);

/// TAFCR
const TAFCR_val = packed struct {
/// TAMP1E [0:0]
/// Tamper 1 detection enable
TAMP1E: u1 = 0,
/// TAMP1TRG [1:1]
/// Active level for tamper 1
TAMP1TRG: u1 = 0,
/// TAMPIE [2:2]
/// Tamper interrupt enable
TAMPIE: u1 = 0,
/// TAMP2E [3:3]
/// Tamper 2 detection enable
TAMP2E: u1 = 0,
/// TAMP2TRG [4:4]
/// Active level for tamper 2
TAMP2TRG: u1 = 0,
/// TAMP3E [5:5]
/// Tamper 3 detection enable
TAMP3E: u1 = 0,
/// TAMP3TRG [6:6]
/// Active level for tamper 3
TAMP3TRG: u1 = 0,
/// TAMPTS [7:7]
/// Activate timestamp on tamper detection
TAMPTS: u1 = 0,
/// TAMPFREQ [8:10]
/// Tamper sampling frequency
TAMPFREQ: u3 = 0,
/// TAMPFLT [11:12]
/// Tamper filter count
TAMPFLT: u2 = 0,
/// TAMPPRCH [13:14]
/// Tamper precharge duration
TAMPPRCH: u2 = 0,
/// TAMPPUDIS [15:15]
/// TAMPER pull-up disable
TAMPPUDIS: u1 = 0,
/// unused [16:17]
_unused16: u2 = 0,
/// PC13VALUE [18:18]
/// PC13 value
PC13VALUE: u1 = 0,
/// PC13MODE [19:19]
/// PC13 mode
PC13MODE: u1 = 0,
/// PC14VALUE [20:20]
/// PC14 value
PC14VALUE: u1 = 0,
/// PC14MODE [21:21]
/// PC 14 mode
PC14MODE: u1 = 0,
/// PC15VALUE [22:22]
/// PC15 value
PC15VALUE: u1 = 0,
/// PC15MODE [23:23]
/// PC15 mode
PC15MODE: u1 = 0,
/// unused [24:31]
_unused24: u8 = 0,
};
/// tamper and alternate function configuration
pub const TAFCR = Register(TAFCR_val).init(base_address + 0x40);

/// ALRMASSR
const ALRMASSR_val = packed struct {
/// SS [0:14]
/// Sub seconds value
SS: u15 = 0,
/// unused [15:23]
_unused15: u1 = 0,
_unused16: u8 = 0,
/// MASKSS [24:27]
/// Mask the most-significant bits starting
MASKSS: u4 = 0,
/// unused [28:31]
_unused28: u4 = 0,
};
/// alarm A sub second register
pub const ALRMASSR = Register(ALRMASSR_val).init(base_address + 0x44);

/// ALRMBSSR
const ALRMBSSR_val = packed struct {
/// SS [0:14]
/// Sub seconds value
SS: u15 = 0,
/// unused [15:23]
_unused15: u1 = 0,
_unused16: u8 = 0,
/// MASKSS [24:27]
/// Mask the most-significant bits starting
MASKSS: u4 = 0,
/// unused [28:31]
_unused28: u4 = 0,
};
/// alarm B sub second register
pub const ALRMBSSR = Register(ALRMBSSR_val).init(base_address + 0x48);

/// BKP0R
const BKP0R_val = packed struct {
/// BKP [0:31]
/// BKP
BKP: u32 = 0,
};
/// backup register
pub const BKP0R = Register(BKP0R_val).init(base_address + 0x50);

/// BKP1R
const BKP1R_val = packed struct {
/// BKP [0:31]
/// BKP
BKP: u32 = 0,
};
/// backup register
pub const BKP1R = Register(BKP1R_val).init(base_address + 0x54);

/// BKP2R
const BKP2R_val = packed struct {
/// BKP [0:31]
/// BKP
BKP: u32 = 0,
};
/// backup register
pub const BKP2R = Register(BKP2R_val).init(base_address + 0x58);

/// BKP3R
const BKP3R_val = packed struct {
/// BKP [0:31]
/// BKP
BKP: u32 = 0,
};
/// backup register
pub const BKP3R = Register(BKP3R_val).init(base_address + 0x5c);

/// BKP4R
const BKP4R_val = packed struct {
/// BKP [0:31]
/// BKP
BKP: u32 = 0,
};
/// backup register
pub const BKP4R = Register(BKP4R_val).init(base_address + 0x60);

/// BKP5R
const BKP5R_val = packed struct {
/// BKP [0:31]
/// BKP
BKP: u32 = 0,
};
/// backup register
pub const BKP5R = Register(BKP5R_val).init(base_address + 0x64);

/// BKP6R
const BKP6R_val = packed struct {
/// BKP [0:31]
/// BKP
BKP: u32 = 0,
};
/// backup register
pub const BKP6R = Register(BKP6R_val).init(base_address + 0x68);

/// BKP7R
const BKP7R_val = packed struct {
/// BKP [0:31]
/// BKP
BKP: u32 = 0,
};
/// backup register
pub const BKP7R = Register(BKP7R_val).init(base_address + 0x6c);

/// BKP8R
const BKP8R_val = packed struct {
/// BKP [0:31]
/// BKP
BKP: u32 = 0,
};
/// backup register
pub const BKP8R = Register(BKP8R_val).init(base_address + 0x70);

/// BKP9R
const BKP9R_val = packed struct {
/// BKP [0:31]
/// BKP
BKP: u32 = 0,
};
/// backup register
pub const BKP9R = Register(BKP9R_val).init(base_address + 0x74);

/// BKP10R
const BKP10R_val = packed struct {
/// BKP [0:31]
/// BKP
BKP: u32 = 0,
};
/// backup register
pub const BKP10R = Register(BKP10R_val).init(base_address + 0x78);

/// BKP11R
const BKP11R_val = packed struct {
/// BKP [0:31]
/// BKP
BKP: u32 = 0,
};
/// backup register
pub const BKP11R = Register(BKP11R_val).init(base_address + 0x7c);

/// BKP12R
const BKP12R_val = packed struct {
/// BKP [0:31]
/// BKP
BKP: u32 = 0,
};
/// backup register
pub const BKP12R = Register(BKP12R_val).init(base_address + 0x80);

/// BKP13R
const BKP13R_val = packed struct {
/// BKP [0:31]
/// BKP
BKP: u32 = 0,
};
/// backup register
pub const BKP13R = Register(BKP13R_val).init(base_address + 0x84);

/// BKP14R
const BKP14R_val = packed struct {
/// BKP [0:31]
/// BKP
BKP: u32 = 0,
};
/// backup register
pub const BKP14R = Register(BKP14R_val).init(base_address + 0x88);

/// BKP15R
const BKP15R_val = packed struct {
/// BKP [0:31]
/// BKP
BKP: u32 = 0,
};
/// backup register
pub const BKP15R = Register(BKP15R_val).init(base_address + 0x8c);

/// BKP16R
const BKP16R_val = packed struct {
/// BKP [0:31]
/// BKP
BKP: u32 = 0,
};
/// backup register
pub const BKP16R = Register(BKP16R_val).init(base_address + 0x90);

/// BKP17R
const BKP17R_val = packed struct {
/// BKP [0:31]
/// BKP
BKP: u32 = 0,
};
/// backup register
pub const BKP17R = Register(BKP17R_val).init(base_address + 0x94);

/// BKP18R
const BKP18R_val = packed struct {
/// BKP [0:31]
/// BKP
BKP: u32 = 0,
};
/// backup register
pub const BKP18R = Register(BKP18R_val).init(base_address + 0x98);

/// BKP19R
const BKP19R_val = packed struct {
/// BKP [0:31]
/// BKP
BKP: u32 = 0,
};
/// backup register
pub const BKP19R = Register(BKP19R_val).init(base_address + 0x9c);

/// BKP20R
const BKP20R_val = packed struct {
/// BKP [0:31]
/// BKP
BKP: u32 = 0,
};
/// backup register
pub const BKP20R = Register(BKP20R_val).init(base_address + 0xa0);

/// BKP21R
const BKP21R_val = packed struct {
/// BKP [0:31]
/// BKP
BKP: u32 = 0,
};
/// backup register
pub const BKP21R = Register(BKP21R_val).init(base_address + 0xa4);

/// BKP22R
const BKP22R_val = packed struct {
/// BKP [0:31]
/// BKP
BKP: u32 = 0,
};
/// backup register
pub const BKP22R = Register(BKP22R_val).init(base_address + 0xa8);

/// BKP23R
const BKP23R_val = packed struct {
/// BKP [0:31]
/// BKP
BKP: u32 = 0,
};
/// backup register
pub const BKP23R = Register(BKP23R_val).init(base_address + 0xac);

/// BKP24R
const BKP24R_val = packed struct {
/// BKP [0:31]
/// BKP
BKP: u32 = 0,
};
/// backup register
pub const BKP24R = Register(BKP24R_val).init(base_address + 0xb0);

/// BKP25R
const BKP25R_val = packed struct {
/// BKP [0:31]
/// BKP
BKP: u32 = 0,
};
/// backup register
pub const BKP25R = Register(BKP25R_val).init(base_address + 0xb4);

/// BKP26R
const BKP26R_val = packed struct {
/// BKP [0:31]
/// BKP
BKP: u32 = 0,
};
/// backup register
pub const BKP26R = Register(BKP26R_val).init(base_address + 0xb8);

/// BKP27R
const BKP27R_val = packed struct {
/// BKP [0:31]
/// BKP
BKP: u32 = 0,
};
/// backup register
pub const BKP27R = Register(BKP27R_val).init(base_address + 0xbc);

/// BKP28R
const BKP28R_val = packed struct {
/// BKP [0:31]
/// BKP
BKP: u32 = 0,
};
/// backup register
pub const BKP28R = Register(BKP28R_val).init(base_address + 0xc0);

/// BKP29R
const BKP29R_val = packed struct {
/// BKP [0:31]
/// BKP
BKP: u32 = 0,
};
/// backup register
pub const BKP29R = Register(BKP29R_val).init(base_address + 0xc4);

/// BKP30R
const BKP30R_val = packed struct {
/// BKP [0:31]
/// BKP
BKP: u32 = 0,
};
/// backup register
pub const BKP30R = Register(BKP30R_val).init(base_address + 0xc8);

/// BKP31R
const BKP31R_val = packed struct {
/// BKP [0:31]
/// BKP
BKP: u32 = 0,
};
/// backup register
pub const BKP31R = Register(BKP31R_val).init(base_address + 0xcc);
};

/// Basic timers
pub const TIM6 = struct {

const base_address = 0x40001000;
/// CR1
const CR1_val = packed struct {
/// CEN [0:0]
/// Counter enable
CEN: u1 = 0,
/// UDIS [1:1]
/// Update disable
UDIS: u1 = 0,
/// URS [2:2]
/// Update request source
URS: u1 = 0,
/// OPM [3:3]
/// One-pulse mode
OPM: u1 = 0,
/// unused [4:6]
_unused4: u3 = 0,
/// ARPE [7:7]
/// Auto-reload preload enable
ARPE: u1 = 0,
/// unused [8:10]
_unused8: u3 = 0,
/// UIFREMAP [11:11]
/// UIF status bit remapping
UIFREMAP: u1 = 0,
/// unused [12:31]
_unused12: u4 = 0,
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// control register 1
pub const CR1 = Register(CR1_val).init(base_address + 0x0);

/// CR2
const CR2_val = packed struct {
/// unused [0:3]
_unused0: u4 = 0,
/// MMS [4:6]
/// Master mode selection
MMS: u3 = 0,
/// unused [7:31]
_unused7: u1 = 0,
_unused8: u8 = 0,
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// control register 2
pub const CR2 = Register(CR2_val).init(base_address + 0x4);

/// DIER
const DIER_val = packed struct {
/// UIE [0:0]
/// Update interrupt enable
UIE: u1 = 0,
/// unused [1:7]
_unused1: u7 = 0,
/// UDE [8:8]
/// Update DMA request enable
UDE: u1 = 0,
/// unused [9:31]
_unused9: u7 = 0,
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// DMA/Interrupt enable register
pub const DIER = Register(DIER_val).init(base_address + 0xc);

/// SR
const SR_val = packed struct {
/// UIF [0:0]
/// Update interrupt flag
UIF: u1 = 0,
/// unused [1:31]
_unused1: u7 = 0,
_unused8: u8 = 0,
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// status register
pub const SR = Register(SR_val).init(base_address + 0x10);

/// EGR
const EGR_val = packed struct {
/// UG [0:0]
/// Update generation
UG: u1 = 0,
/// unused [1:31]
_unused1: u7 = 0,
_unused8: u8 = 0,
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// event generation register
pub const EGR = Register(EGR_val).init(base_address + 0x14);

/// CNT
const CNT_val = packed struct {
/// CNT [0:15]
/// Low counter value
CNT: u16 = 0,
/// unused [16:30]
_unused16: u8 = 0,
_unused24: u7 = 0,
/// UIFCPY [31:31]
/// UIF Copy
UIFCPY: u1 = 0,
};
/// counter
pub const CNT = Register(CNT_val).init(base_address + 0x24);

/// PSC
const PSC_val = packed struct {
/// PSC [0:15]
/// Prescaler value
PSC: u16 = 0,
/// unused [16:31]
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// prescaler
pub const PSC = Register(PSC_val).init(base_address + 0x28);

/// ARR
const ARR_val = packed struct {
/// ARR [0:15]
/// Low Auto-reload value
ARR: u16 = 0,
/// unused [16:31]
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// auto-reload register
pub const ARR = Register(ARR_val).init(base_address + 0x2c);
};

/// Basic timers
pub const TIM7 = struct {

const base_address = 0x40001400;
/// CR1
const CR1_val = packed struct {
/// CEN [0:0]
/// Counter enable
CEN: u1 = 0,
/// UDIS [1:1]
/// Update disable
UDIS: u1 = 0,
/// URS [2:2]
/// Update request source
URS: u1 = 0,
/// OPM [3:3]
/// One-pulse mode
OPM: u1 = 0,
/// unused [4:6]
_unused4: u3 = 0,
/// ARPE [7:7]
/// Auto-reload preload enable
ARPE: u1 = 0,
/// unused [8:10]
_unused8: u3 = 0,
/// UIFREMAP [11:11]
/// UIF status bit remapping
UIFREMAP: u1 = 0,
/// unused [12:31]
_unused12: u4 = 0,
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// control register 1
pub const CR1 = Register(CR1_val).init(base_address + 0x0);

/// CR2
const CR2_val = packed struct {
/// unused [0:3]
_unused0: u4 = 0,
/// MMS [4:6]
/// Master mode selection
MMS: u3 = 0,
/// unused [7:31]
_unused7: u1 = 0,
_unused8: u8 = 0,
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// control register 2
pub const CR2 = Register(CR2_val).init(base_address + 0x4);

/// DIER
const DIER_val = packed struct {
/// UIE [0:0]
/// Update interrupt enable
UIE: u1 = 0,
/// unused [1:7]
_unused1: u7 = 0,
/// UDE [8:8]
/// Update DMA request enable
UDE: u1 = 0,
/// unused [9:31]
_unused9: u7 = 0,
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// DMA/Interrupt enable register
pub const DIER = Register(DIER_val).init(base_address + 0xc);

/// SR
const SR_val = packed struct {
/// UIF [0:0]
/// Update interrupt flag
UIF: u1 = 0,
/// unused [1:31]
_unused1: u7 = 0,
_unused8: u8 = 0,
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// status register
pub const SR = Register(SR_val).init(base_address + 0x10);

/// EGR
const EGR_val = packed struct {
/// UG [0:0]
/// Update generation
UG: u1 = 0,
/// unused [1:31]
_unused1: u7 = 0,
_unused8: u8 = 0,
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// event generation register
pub const EGR = Register(EGR_val).init(base_address + 0x14);

/// CNT
const CNT_val = packed struct {
/// CNT [0:15]
/// Low counter value
CNT: u16 = 0,
/// unused [16:30]
_unused16: u8 = 0,
_unused24: u7 = 0,
/// UIFCPY [31:31]
/// UIF Copy
UIFCPY: u1 = 0,
};
/// counter
pub const CNT = Register(CNT_val).init(base_address + 0x24);

/// PSC
const PSC_val = packed struct {
/// PSC [0:15]
/// Prescaler value
PSC: u16 = 0,
/// unused [16:31]
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// prescaler
pub const PSC = Register(PSC_val).init(base_address + 0x28);

/// ARR
const ARR_val = packed struct {
/// ARR [0:15]
/// Low Auto-reload value
ARR: u16 = 0,
/// unused [16:31]
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// auto-reload register
pub const ARR = Register(ARR_val).init(base_address + 0x2c);
};

/// Digital-to-analog converter
pub const DAC = struct {

const base_address = 0x40007400;
/// CR
const CR_val = packed struct {
/// EN1 [0:0]
/// DAC channel1 enable
EN1: u1 = 0,
/// BOFF1 [1:1]
/// DAC channel1 output buffer
BOFF1: u1 = 0,
/// TEN1 [2:2]
/// DAC channel1 trigger
TEN1: u1 = 0,
/// TSEL1 [3:5]
/// DAC channel1 trigger
TSEL1: u3 = 0,
/// WAVE1 [6:7]
/// DAC channel1 noise/triangle wave
WAVE1: u2 = 0,
/// MAMP1 [8:11]
/// DAC channel1 mask/amplitude
MAMP1: u4 = 0,
/// DMAEN1 [12:12]
/// DAC channel1 DMA enable
DMAEN1: u1 = 0,
/// DMAUDRIE1 [13:13]
/// DAC channel1 DMA Underrun Interrupt
DMAUDRIE1: u1 = 0,
/// unused [14:15]
_unused14: u2 = 0,
/// EN2 [16:16]
/// DAC channel2 enable
EN2: u1 = 0,
/// BOFF2 [17:17]
/// DAC channel2 output buffer
BOFF2: u1 = 0,
/// TEN2 [18:18]
/// DAC channel2 trigger
TEN2: u1 = 0,
/// TSEL2 [19:21]
/// DAC channel2 trigger
TSEL2: u3 = 0,
/// WAVE2 [22:23]
/// DAC channel2 noise/triangle wave
WAVE2: u2 = 0,
/// MAMP2 [24:27]
/// DAC channel2 mask/amplitude
MAMP2: u4 = 0,
/// DMAEN2 [28:28]
/// DAC channel2 DMA enable
DMAEN2: u1 = 0,
/// DMAUDRIE2 [29:29]
/// DAC channel2 DMA underrun interrupt
DMAUDRIE2: u1 = 0,
/// unused [30:31]
_unused30: u2 = 0,
};
/// control register
pub const CR = Register(CR_val).init(base_address + 0x0);

/// SWTRIGR
const SWTRIGR_val = packed struct {
/// SWTRIG1 [0:0]
/// DAC channel1 software
SWTRIG1: u1 = 0,
/// SWTRIG2 [1:1]
/// DAC channel2 software
SWTRIG2: u1 = 0,
/// unused [2:31]
_unused2: u6 = 0,
_unused8: u8 = 0,
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// software trigger register
pub const SWTRIGR = Register(SWTRIGR_val).init(base_address + 0x4);

/// DHR12R1
const DHR12R1_val = packed struct {
/// DACC1DHR [0:11]
/// DAC channel1 12-bit right-aligned
DACC1DHR: u12 = 0,
/// unused [12:31]
_unused12: u4 = 0,
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// channel1 12-bit right-aligned data holding
pub const DHR12R1 = Register(DHR12R1_val).init(base_address + 0x8);

/// DHR12L1
const DHR12L1_val = packed struct {
/// unused [0:3]
_unused0: u4 = 0,
/// DACC1DHR [4:15]
/// DAC channel1 12-bit left-aligned
DACC1DHR: u12 = 0,
/// unused [16:31]
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// channel1 12-bit left aligned data holding
pub const DHR12L1 = Register(DHR12L1_val).init(base_address + 0xc);

/// DHR8R1
const DHR8R1_val = packed struct {
/// DACC1DHR [0:7]
/// DAC channel1 8-bit right-aligned
DACC1DHR: u8 = 0,
/// unused [8:31]
_unused8: u8 = 0,
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// channel1 8-bit right aligned data holding
pub const DHR8R1 = Register(DHR8R1_val).init(base_address + 0x10);

/// DHR12R2
const DHR12R2_val = packed struct {
/// DACC2DHR [0:11]
/// DAC channel2 12-bit right-aligned
DACC2DHR: u12 = 0,
/// unused [12:31]
_unused12: u4 = 0,
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// channel2 12-bit right aligned data holding
pub const DHR12R2 = Register(DHR12R2_val).init(base_address + 0x14);

/// DHR12L2
const DHR12L2_val = packed struct {
/// unused [0:3]
_unused0: u4 = 0,
/// DACC2DHR [4:15]
/// DAC channel2 12-bit left-aligned
DACC2DHR: u12 = 0,
/// unused [16:31]
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// channel2 12-bit left aligned data holding
pub const DHR12L2 = Register(DHR12L2_val).init(base_address + 0x18);

/// DHR8R2
const DHR8R2_val = packed struct {
/// DACC2DHR [0:7]
/// DAC channel2 8-bit right-aligned
DACC2DHR: u8 = 0,
/// unused [8:31]
_unused8: u8 = 0,
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// channel2 8-bit right-aligned data holding
pub const DHR8R2 = Register(DHR8R2_val).init(base_address + 0x1c);

/// DHR12RD
const DHR12RD_val = packed struct {
/// DACC1DHR [0:11]
/// DAC channel1 12-bit right-aligned
DACC1DHR: u12 = 0,
/// unused [12:15]
_unused12: u4 = 0,
/// DACC2DHR [16:27]
/// DAC channel2 12-bit right-aligned
DACC2DHR: u12 = 0,
/// unused [28:31]
_unused28: u4 = 0,
};
/// Dual DAC 12-bit right-aligned data holding
pub const DHR12RD = Register(DHR12RD_val).init(base_address + 0x20);

/// DHR12LD
const DHR12LD_val = packed struct {
/// unused [0:3]
_unused0: u4 = 0,
/// DACC1DHR [4:15]
/// DAC channel1 12-bit left-aligned
DACC1DHR: u12 = 0,
/// unused [16:19]
_unused16: u4 = 0,
/// DACC2DHR [20:31]
/// DAC channel2 12-bit left-aligned
DACC2DHR: u12 = 0,
};
/// DUAL DAC 12-bit left aligned data holding
pub const DHR12LD = Register(DHR12LD_val).init(base_address + 0x24);

/// DHR8RD
const DHR8RD_val = packed struct {
/// DACC1DHR [0:7]
/// DAC channel1 8-bit right-aligned
DACC1DHR: u8 = 0,
/// DACC2DHR [8:15]
/// DAC channel2 8-bit right-aligned
DACC2DHR: u8 = 0,
/// unused [16:31]
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// DUAL DAC 8-bit right aligned data holding
pub const DHR8RD = Register(DHR8RD_val).init(base_address + 0x28);

/// DOR1
const DOR1_val = packed struct {
/// DACC1DOR [0:11]
/// DAC channel1 data output
DACC1DOR: u12 = 0,
/// unused [12:31]
_unused12: u4 = 0,
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// channel1 data output register
pub const DOR1 = Register(DOR1_val).init(base_address + 0x2c);

/// DOR2
const DOR2_val = packed struct {
/// DACC2DOR [0:11]
/// DAC channel2 data output
DACC2DOR: u12 = 0,
/// unused [12:31]
_unused12: u4 = 0,
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// channel2 data output register
pub const DOR2 = Register(DOR2_val).init(base_address + 0x30);

/// SR
const SR_val = packed struct {
/// unused [0:12]
_unused0: u8 = 0,
_unused8: u5 = 0,
/// DMAUDR1 [13:13]
/// DAC channel1 DMA underrun
DMAUDR1: u1 = 0,
/// unused [14:28]
_unused14: u2 = 0,
_unused16: u8 = 0,
_unused24: u5 = 0,
/// DMAUDR2 [29:29]
/// DAC channel2 DMA underrun
DMAUDR2: u1 = 0,
/// unused [30:31]
_unused30: u2 = 0,
};
/// status register
pub const SR = Register(SR_val).init(base_address + 0x34);
};

/// Debug support
pub const DBGMCU = struct {

const base_address = 0xe0042000;
/// IDCODE
const IDCODE_val = packed struct {
/// DEV_ID [0:11]
/// Device Identifier
DEV_ID: u12 = 0,
/// unused [12:15]
_unused12: u4 = 0,
/// REV_ID [16:31]
/// Revision Identifier
REV_ID: u16 = 0,
};
/// MCU Device ID Code Register
pub const IDCODE = Register(IDCODE_val).init(base_address + 0x0);

/// CR
const CR_val = packed struct {
/// DBG_SLEEP [0:0]
/// Debug Sleep mode
DBG_SLEEP: u1 = 0,
/// DBG_STOP [1:1]
/// Debug Stop Mode
DBG_STOP: u1 = 0,
/// DBG_STANDBY [2:2]
/// Debug Standby Mode
DBG_STANDBY: u1 = 0,
/// unused [3:4]
_unused3: u2 = 0,
/// TRACE_IOEN [5:5]
/// Trace pin assignment
TRACE_IOEN: u1 = 0,
/// TRACE_MODE [6:7]
/// Trace pin assignment
TRACE_MODE: u2 = 0,
/// unused [8:31]
_unused8: u8 = 0,
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// Debug MCU Configuration
pub const CR = Register(CR_val).init(base_address + 0x4);

/// APB1FZ
const APB1FZ_val = packed struct {
/// DBG_TIM2_STOP [0:0]
/// Debug Timer 2 stopped when Core is
DBG_TIM2_STOP: u1 = 0,
/// DBG_TIM3_STOP [1:1]
/// Debug Timer 3 stopped when Core is
DBG_TIM3_STOP: u1 = 0,
/// DBG_TIM4_STOP [2:2]
/// Debug Timer 4 stopped when Core is
DBG_TIM4_STOP: u1 = 0,
/// DBG_TIM5_STOP [3:3]
/// Debug Timer 5 stopped when Core is
DBG_TIM5_STOP: u1 = 0,
/// DBG_TIM6_STOP [4:4]
/// Debug Timer 6 stopped when Core is
DBG_TIM6_STOP: u1 = 0,
/// DBG_TIM7_STOP [5:5]
/// Debug Timer 7 stopped when Core is
DBG_TIM7_STOP: u1 = 0,
/// DBG_TIM12_STOP [6:6]
/// Debug Timer 12 stopped when Core is
DBG_TIM12_STOP: u1 = 0,
/// DBG_TIM13_STOP [7:7]
/// Debug Timer 13 stopped when Core is
DBG_TIM13_STOP: u1 = 0,
/// DBG_TIMER14_STOP [8:8]
/// Debug Timer 14 stopped when Core is
DBG_TIMER14_STOP: u1 = 0,
/// DBG_TIM18_STOP [9:9]
/// Debug Timer 18 stopped when Core is
DBG_TIM18_STOP: u1 = 0,
/// DBG_RTC_STOP [10:10]
/// Debug RTC stopped when Core is
DBG_RTC_STOP: u1 = 0,
/// DBG_WWDG_STOP [11:11]
/// Debug Window Wachdog stopped when Core
DBG_WWDG_STOP: u1 = 0,
/// DBG_IWDG_STOP [12:12]
/// Debug Independent Wachdog stopped when
DBG_IWDG_STOP: u1 = 0,
/// unused [13:20]
_unused13: u3 = 0,
_unused16: u5 = 0,
/// I2C1_SMBUS_TIMEOUT [21:21]
/// SMBUS timeout mode stopped when Core is
I2C1_SMBUS_TIMEOUT: u1 = 0,
/// I2C2_SMBUS_TIMEOUT [22:22]
/// SMBUS timeout mode stopped when Core is
I2C2_SMBUS_TIMEOUT: u1 = 0,
/// unused [23:24]
_unused23: u1 = 0,
_unused24: u1 = 0,
/// DBG_CAN_STOP [25:25]
/// Debug CAN stopped when core is
DBG_CAN_STOP: u1 = 0,
/// unused [26:31]
_unused26: u6 = 0,
};
/// APB Low Freeze Register
pub const APB1FZ = Register(APB1FZ_val).init(base_address + 0x8);

/// APB2FZ
const APB2FZ_val = packed struct {
/// unused [0:1]
_unused0: u2 = 0,
/// DBG_TIM15_STOP [2:2]
/// Debug Timer 15 stopped when Core is
DBG_TIM15_STOP: u1 = 0,
/// DBG_TIM16_STOP [3:3]
/// Debug Timer 16 stopped when Core is
DBG_TIM16_STOP: u1 = 0,
/// DBG_TIM17_STO [4:4]
/// Debug Timer 17 stopped when Core is
DBG_TIM17_STO: u1 = 0,
/// DBG_TIM19_STOP [5:5]
/// Debug Timer 19 stopped when Core is
DBG_TIM19_STOP: u1 = 0,
/// unused [6:31]
_unused6: u2 = 0,
_unused8: u8 = 0,
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// APB High Freeze Register
pub const APB2FZ = Register(APB2FZ_val).init(base_address + 0xc);
};

/// Advanced timer
pub const TIM1 = struct {

const base_address = 0x40012c00;
/// CR1
const CR1_val = packed struct {
/// CEN [0:0]
/// Counter enable
CEN: u1 = 0,
/// UDIS [1:1]
/// Update disable
UDIS: u1 = 0,
/// URS [2:2]
/// Update request source
URS: u1 = 0,
/// OPM [3:3]
/// One-pulse mode
OPM: u1 = 0,
/// DIR [4:4]
/// Direction
DIR: u1 = 0,
/// CMS [5:6]
/// Center-aligned mode
CMS: u2 = 0,
/// ARPE [7:7]
/// Auto-reload preload enable
ARPE: u1 = 0,
/// CKD [8:9]
/// Clock division
CKD: u2 = 0,
/// unused [10:10]
_unused10: u1 = 0,
/// UIFREMAP [11:11]
/// UIF status bit remapping
UIFREMAP: u1 = 0,
/// unused [12:31]
_unused12: u4 = 0,
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// control register 1
pub const CR1 = Register(CR1_val).init(base_address + 0x0);

/// CR2
const CR2_val = packed struct {
/// CCPC [0:0]
/// Capture/compare preloaded
CCPC: u1 = 0,
/// unused [1:1]
_unused1: u1 = 0,
/// CCUS [2:2]
/// Capture/compare control update
CCUS: u1 = 0,
/// CCDS [3:3]
/// Capture/compare DMA
CCDS: u1 = 0,
/// MMS [4:6]
/// Master mode selection
MMS: u3 = 0,
/// TI1S [7:7]
/// TI1 selection
TI1S: u1 = 0,
/// OIS1 [8:8]
/// Output Idle state 1
OIS1: u1 = 0,
/// OIS1N [9:9]
/// Output Idle state 1
OIS1N: u1 = 0,
/// OIS2 [10:10]
/// Output Idle state 2
OIS2: u1 = 0,
/// OIS2N [11:11]
/// Output Idle state 2
OIS2N: u1 = 0,
/// OIS3 [12:12]
/// Output Idle state 3
OIS3: u1 = 0,
/// OIS3N [13:13]
/// Output Idle state 3
OIS3N: u1 = 0,
/// OIS4 [14:14]
/// Output Idle state 4
OIS4: u1 = 0,
/// unused [15:15]
_unused15: u1 = 0,
/// OIS5 [16:16]
/// Output Idle state 5
OIS5: u1 = 0,
/// unused [17:17]
_unused17: u1 = 0,
/// OIS6 [18:18]
/// Output Idle state 6
OIS6: u1 = 0,
/// unused [19:19]
_unused19: u1 = 0,
/// MMS2 [20:23]
/// Master mode selection 2
MMS2: u4 = 0,
/// unused [24:31]
_unused24: u8 = 0,
};
/// control register 2
pub const CR2 = Register(CR2_val).init(base_address + 0x4);

/// SMCR
const SMCR_val = packed struct {
/// SMS [0:2]
/// Slave mode selection
SMS: u3 = 0,
/// OCCS [3:3]
/// OCREF clear selection
OCCS: u1 = 0,
/// TS [4:6]
/// Trigger selection
TS: u3 = 0,
/// MSM [7:7]
/// Master/Slave mode
MSM: u1 = 0,
/// ETF [8:11]
/// External trigger filter
ETF: u4 = 0,
/// ETPS [12:13]
/// External trigger prescaler
ETPS: u2 = 0,
/// ECE [14:14]
/// External clock enable
ECE: u1 = 0,
/// ETP [15:15]
/// External trigger polarity
ETP: u1 = 0,
/// SMS3 [16:16]
/// Slave mode selection bit 3
SMS3: u1 = 0,
/// unused [17:31]
_unused17: u7 = 0,
_unused24: u8 = 0,
};
/// slave mode control register
pub const SMCR = Register(SMCR_val).init(base_address + 0x8);

/// DIER
const DIER_val = packed struct {
/// UIE [0:0]
/// Update interrupt enable
UIE: u1 = 0,
/// CC1IE [1:1]
/// Capture/Compare 1 interrupt
CC1IE: u1 = 0,
/// CC2IE [2:2]
/// Capture/Compare 2 interrupt
CC2IE: u1 = 0,
/// CC3IE [3:3]
/// Capture/Compare 3 interrupt
CC3IE: u1 = 0,
/// CC4IE [4:4]
/// Capture/Compare 4 interrupt
CC4IE: u1 = 0,
/// COMIE [5:5]
/// COM interrupt enable
COMIE: u1 = 0,
/// TIE [6:6]
/// Trigger interrupt enable
TIE: u1 = 0,
/// BIE [7:7]
/// Break interrupt enable
BIE: u1 = 0,
/// UDE [8:8]
/// Update DMA request enable
UDE: u1 = 0,
/// CC1DE [9:9]
/// Capture/Compare 1 DMA request
CC1DE: u1 = 0,
/// CC2DE [10:10]
/// Capture/Compare 2 DMA request
CC2DE: u1 = 0,
/// CC3DE [11:11]
/// Capture/Compare 3 DMA request
CC3DE: u1 = 0,
/// CC4DE [12:12]
/// Capture/Compare 4 DMA request
CC4DE: u1 = 0,
/// COMDE [13:13]
/// COM DMA request enable
COMDE: u1 = 0,
/// TDE [14:14]
/// Trigger DMA request enable
TDE: u1 = 0,
/// unused [15:31]
_unused15: u1 = 0,
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// DMA/Interrupt enable register
pub const DIER = Register(DIER_val).init(base_address + 0xc);

/// SR
const SR_val = packed struct {
/// UIF [0:0]
/// Update interrupt flag
UIF: u1 = 0,
/// CC1IF [1:1]
/// Capture/compare 1 interrupt
CC1IF: u1 = 0,
/// CC2IF [2:2]
/// Capture/Compare 2 interrupt
CC2IF: u1 = 0,
/// CC3IF [3:3]
/// Capture/Compare 3 interrupt
CC3IF: u1 = 0,
/// CC4IF [4:4]
/// Capture/Compare 4 interrupt
CC4IF: u1 = 0,
/// COMIF [5:5]
/// COM interrupt flag
COMIF: u1 = 0,
/// TIF [6:6]
/// Trigger interrupt flag
TIF: u1 = 0,
/// BIF [7:7]
/// Break interrupt flag
BIF: u1 = 0,
/// B2IF [8:8]
/// Break 2 interrupt flag
B2IF: u1 = 0,
/// CC1OF [9:9]
/// Capture/Compare 1 overcapture
CC1OF: u1 = 0,
/// CC2OF [10:10]
/// Capture/compare 2 overcapture
CC2OF: u1 = 0,
/// CC3OF [11:11]
/// Capture/Compare 3 overcapture
CC3OF: u1 = 0,
/// CC4OF [12:12]
/// Capture/Compare 4 overcapture
CC4OF: u1 = 0,
/// unused [13:15]
_unused13: u3 = 0,
/// C5IF [16:16]
/// Capture/Compare 5 interrupt
C5IF: u1 = 0,
/// C6IF [17:17]
/// Capture/Compare 6 interrupt
C6IF: u1 = 0,
/// unused [18:31]
_unused18: u6 = 0,
_unused24: u8 = 0,
};
/// status register
pub const SR = Register(SR_val).init(base_address + 0x10);

/// EGR
const EGR_val = packed struct {
/// UG [0:0]
/// Update generation
UG: u1 = 0,
/// CC1G [1:1]
/// Capture/compare 1
CC1G: u1 = 0,
/// CC2G [2:2]
/// Capture/compare 2
CC2G: u1 = 0,
/// CC3G [3:3]
/// Capture/compare 3
CC3G: u1 = 0,
/// CC4G [4:4]
/// Capture/compare 4
CC4G: u1 = 0,
/// COMG [5:5]
/// Capture/Compare control update
COMG: u1 = 0,
/// TG [6:6]
/// Trigger generation
TG: u1 = 0,
/// BG [7:7]
/// Break generation
BG: u1 = 0,
/// B2G [8:8]
/// Break 2 generation
B2G: u1 = 0,
/// unused [9:31]
_unused9: u7 = 0,
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// event generation register
pub const EGR = Register(EGR_val).init(base_address + 0x14);

/// CCMR1_Output
const CCMR1_Output_val = packed struct {
/// CC1S [0:1]
/// Capture/Compare 1
CC1S: u2 = 0,
/// OC1FE [2:2]
/// Output Compare 1 fast
OC1FE: u1 = 0,
/// OC1PE [3:3]
/// Output Compare 1 preload
OC1PE: u1 = 0,
/// OC1M [4:6]
/// Output Compare 1 mode
OC1M: u3 = 0,
/// OC1CE [7:7]
/// Output Compare 1 clear
OC1CE: u1 = 0,
/// CC2S [8:9]
/// Capture/Compare 2
CC2S: u2 = 0,
/// OC2FE [10:10]
/// Output Compare 2 fast
OC2FE: u1 = 0,
/// OC2PE [11:11]
/// Output Compare 2 preload
OC2PE: u1 = 0,
/// OC2M [12:14]
/// Output Compare 2 mode
OC2M: u3 = 0,
/// OC2CE [15:15]
/// Output Compare 2 clear
OC2CE: u1 = 0,
/// OC1M_3 [16:16]
/// Output Compare 1 mode bit
OC1M_3: u1 = 0,
/// unused [17:23]
_unused17: u7 = 0,
/// OC2M_3 [24:24]
/// Output Compare 2 mode bit
OC2M_3: u1 = 0,
/// unused [25:31]
_unused25: u7 = 0,
};
/// capture/compare mode register (output
pub const CCMR1_Output = Register(CCMR1_Output_val).init(base_address + 0x18);

/// CCMR1_Input
const CCMR1_Input_val = packed struct {
/// CC1S [0:1]
/// Capture/Compare 1
CC1S: u2 = 0,
/// IC1PCS [2:3]
/// Input capture 1 prescaler
IC1PCS: u2 = 0,
/// IC1F [4:7]
/// Input capture 1 filter
IC1F: u4 = 0,
/// CC2S [8:9]
/// Capture/Compare 2
CC2S: u2 = 0,
/// IC2PCS [10:11]
/// Input capture 2 prescaler
IC2PCS: u2 = 0,
/// IC2F [12:15]
/// Input capture 2 filter
IC2F: u4 = 0,
/// unused [16:31]
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// capture/compare mode register 1 (input
pub const CCMR1_Input = Register(CCMR1_Input_val).init(base_address + 0x18);

/// CCMR2_Output
const CCMR2_Output_val = packed struct {
/// CC3S [0:1]
/// Capture/Compare 3
CC3S: u2 = 0,
/// OC3FE [2:2]
/// Output compare 3 fast
OC3FE: u1 = 0,
/// OC3PE [3:3]
/// Output compare 3 preload
OC3PE: u1 = 0,
/// OC3M [4:6]
/// Output compare 3 mode
OC3M: u3 = 0,
/// OC3CE [7:7]
/// Output compare 3 clear
OC3CE: u1 = 0,
/// CC4S [8:9]
/// Capture/Compare 4
CC4S: u2 = 0,
/// OC4FE [10:10]
/// Output compare 4 fast
OC4FE: u1 = 0,
/// OC4PE [11:11]
/// Output compare 4 preload
OC4PE: u1 = 0,
/// OC4M [12:14]
/// Output compare 4 mode
OC4M: u3 = 0,
/// OC4CE [15:15]
/// Output compare 4 clear
OC4CE: u1 = 0,
/// OC3M_3 [16:16]
/// Output Compare 3 mode bit
OC3M_3: u1 = 0,
/// unused [17:23]
_unused17: u7 = 0,
/// OC4M_3 [24:24]
/// Output Compare 4 mode bit
OC4M_3: u1 = 0,
/// unused [25:31]
_unused25: u7 = 0,
};
/// capture/compare mode register (output
pub const CCMR2_Output = Register(CCMR2_Output_val).init(base_address + 0x1c);

/// CCMR2_Input
const CCMR2_Input_val = packed struct {
/// CC3S [0:1]
/// Capture/compare 3
CC3S: u2 = 0,
/// IC3PSC [2:3]
/// Input capture 3 prescaler
IC3PSC: u2 = 0,
/// IC3F [4:7]
/// Input capture 3 filter
IC3F: u4 = 0,
/// CC4S [8:9]
/// Capture/Compare 4
CC4S: u2 = 0,
/// IC4PSC [10:11]
/// Input capture 4 prescaler
IC4PSC: u2 = 0,
/// IC4F [12:15]
/// Input capture 4 filter
IC4F: u4 = 0,
/// unused [16:31]
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// capture/compare mode register 2 (input
pub const CCMR2_Input = Register(CCMR2_Input_val).init(base_address + 0x1c);

/// CCER
const CCER_val = packed struct {
/// CC1E [0:0]
/// Capture/Compare 1 output
CC1E: u1 = 0,
/// CC1P [1:1]
/// Capture/Compare 1 output
CC1P: u1 = 0,
/// CC1NE [2:2]
/// Capture/Compare 1 complementary output
CC1NE: u1 = 0,
/// CC1NP [3:3]
/// Capture/Compare 1 output
CC1NP: u1 = 0,
/// CC2E [4:4]
/// Capture/Compare 2 output
CC2E: u1 = 0,
/// CC2P [5:5]
/// Capture/Compare 2 output
CC2P: u1 = 0,
/// CC2NE [6:6]
/// Capture/Compare 2 complementary output
CC2NE: u1 = 0,
/// CC2NP [7:7]
/// Capture/Compare 2 output
CC2NP: u1 = 0,
/// CC3E [8:8]
/// Capture/Compare 3 output
CC3E: u1 = 0,
/// CC3P [9:9]
/// Capture/Compare 3 output
CC3P: u1 = 0,
/// CC3NE [10:10]
/// Capture/Compare 3 complementary output
CC3NE: u1 = 0,
/// CC3NP [11:11]
/// Capture/Compare 3 output
CC3NP: u1 = 0,
/// CC4E [12:12]
/// Capture/Compare 4 output
CC4E: u1 = 0,
/// CC4P [13:13]
/// Capture/Compare 3 output
CC4P: u1 = 0,
/// unused [14:14]
_unused14: u1 = 0,
/// CC4NP [15:15]
/// Capture/Compare 4 output
CC4NP: u1 = 0,
/// CC5E [16:16]
/// Capture/Compare 5 output
CC5E: u1 = 0,
/// CC5P [17:17]
/// Capture/Compare 5 output
CC5P: u1 = 0,
/// unused [18:19]
_unused18: u2 = 0,
/// CC6E [20:20]
/// Capture/Compare 6 output
CC6E: u1 = 0,
/// CC6P [21:21]
/// Capture/Compare 6 output
CC6P: u1 = 0,
/// unused [22:31]
_unused22: u2 = 0,
_unused24: u8 = 0,
};
/// capture/compare enable
pub const CCER = Register(CCER_val).init(base_address + 0x20);

/// CNT
const CNT_val = packed struct {
/// CNT [0:15]
/// counter value
CNT: u16 = 0,
/// unused [16:30]
_unused16: u8 = 0,
_unused24: u7 = 0,
/// UIFCPY [31:31]
/// UIF copy
UIFCPY: u1 = 0,
};
/// counter
pub const CNT = Register(CNT_val).init(base_address + 0x24);

/// PSC
const PSC_val = packed struct {
/// PSC [0:15]
/// Prescaler value
PSC: u16 = 0,
/// unused [16:31]
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// prescaler
pub const PSC = Register(PSC_val).init(base_address + 0x28);

/// ARR
const ARR_val = packed struct {
/// ARR [0:15]
/// Auto-reload value
ARR: u16 = 0,
/// unused [16:31]
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// auto-reload register
pub const ARR = Register(ARR_val).init(base_address + 0x2c);

/// RCR
const RCR_val = packed struct {
/// REP [0:15]
/// Repetition counter value
REP: u16 = 0,
/// unused [16:31]
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// repetition counter register
pub const RCR = Register(RCR_val).init(base_address + 0x30);

/// CCR1
const CCR1_val = packed struct {
/// CCR1 [0:15]
/// Capture/Compare 1 value
CCR1: u16 = 0,
/// unused [16:31]
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// capture/compare register 1
pub const CCR1 = Register(CCR1_val).init(base_address + 0x34);

/// CCR2
const CCR2_val = packed struct {
/// CCR2 [0:15]
/// Capture/Compare 2 value
CCR2: u16 = 0,
/// unused [16:31]
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// capture/compare register 2
pub const CCR2 = Register(CCR2_val).init(base_address + 0x38);

/// CCR3
const CCR3_val = packed struct {
/// CCR3 [0:15]
/// Capture/Compare 3 value
CCR3: u16 = 0,
/// unused [16:31]
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// capture/compare register 3
pub const CCR3 = Register(CCR3_val).init(base_address + 0x3c);

/// CCR4
const CCR4_val = packed struct {
/// CCR4 [0:15]
/// Capture/Compare 3 value
CCR4: u16 = 0,
/// unused [16:31]
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// capture/compare register 4
pub const CCR4 = Register(CCR4_val).init(base_address + 0x40);

/// BDTR
const BDTR_val = packed struct {
/// DTG [0:7]
/// Dead-time generator setup
DTG: u8 = 0,
/// LOCK [8:9]
/// Lock configuration
LOCK: u2 = 0,
/// OSSI [10:10]
/// Off-state selection for Idle
OSSI: u1 = 0,
/// OSSR [11:11]
/// Off-state selection for Run
OSSR: u1 = 0,
/// BKE [12:12]
/// Break enable
BKE: u1 = 0,
/// BKP [13:13]
/// Break polarity
BKP: u1 = 0,
/// AOE [14:14]
/// Automatic output enable
AOE: u1 = 0,
/// MOE [15:15]
/// Main output enable
MOE: u1 = 0,
/// BKF [16:19]
/// Break filter
BKF: u4 = 0,
/// BK2F [20:23]
/// Break 2 filter
BK2F: u4 = 0,
/// BK2E [24:24]
/// Break 2 enable
BK2E: u1 = 0,
/// BK2P [25:25]
/// Break 2 polarity
BK2P: u1 = 0,
/// unused [26:31]
_unused26: u6 = 0,
};
/// break and dead-time register
pub const BDTR = Register(BDTR_val).init(base_address + 0x44);

/// DCR
const DCR_val = packed struct {
/// DBA [0:4]
/// DMA base address
DBA: u5 = 0,
/// unused [5:7]
_unused5: u3 = 0,
/// DBL [8:12]
/// DMA burst length
DBL: u5 = 0,
/// unused [13:31]
_unused13: u3 = 0,
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// DMA control register
pub const DCR = Register(DCR_val).init(base_address + 0x48);

/// DMAR
const DMAR_val = packed struct {
/// DMAB [0:15]
/// DMA register for burst
DMAB: u16 = 0,
/// unused [16:31]
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// DMA address for full transfer
pub const DMAR = Register(DMAR_val).init(base_address + 0x4c);

/// CCMR3_Output
const CCMR3_Output_val = packed struct {
/// unused [0:1]
_unused0: u2 = 0,
/// OC5FE [2:2]
/// Output compare 5 fast
OC5FE: u1 = 0,
/// OC5PE [3:3]
/// Output compare 5 preload
OC5PE: u1 = 0,
/// OC5M [4:6]
/// Output compare 5 mode
OC5M: u3 = 0,
/// OC5CE [7:7]
/// Output compare 5 clear
OC5CE: u1 = 0,
/// unused [8:9]
_unused8: u2 = 0,
/// OC6FE [10:10]
/// Output compare 6 fast
OC6FE: u1 = 0,
/// OC6PE [11:11]
/// Output compare 6 preload
OC6PE: u1 = 0,
/// OC6M [12:14]
/// Output compare 6 mode
OC6M: u3 = 0,
/// OC6CE [15:15]
/// Output compare 6 clear
OC6CE: u1 = 0,
/// OC5M_3 [16:16]
/// Outout Compare 5 mode bit
OC5M_3: u1 = 0,
/// unused [17:23]
_unused17: u7 = 0,
/// OC6M_3 [24:24]
/// Outout Compare 6 mode bit
OC6M_3: u1 = 0,
/// unused [25:31]
_unused25: u7 = 0,
};
/// capture/compare mode register 3 (output
pub const CCMR3_Output = Register(CCMR3_Output_val).init(base_address + 0x54);

/// CCR5
const CCR5_val = packed struct {
/// CCR5 [0:15]
/// Capture/Compare 5 value
CCR5: u16 = 0,
/// unused [16:28]
_unused16: u8 = 0,
_unused24: u5 = 0,
/// GC5C1 [29:29]
/// Group Channel 5 and Channel
GC5C1: u1 = 0,
/// GC5C2 [30:30]
/// Group Channel 5 and Channel
GC5C2: u1 = 0,
/// GC5C3 [31:31]
/// Group Channel 5 and Channel
GC5C3: u1 = 0,
};
/// capture/compare register 5
pub const CCR5 = Register(CCR5_val).init(base_address + 0x58);

/// CCR6
const CCR6_val = packed struct {
/// CCR6 [0:15]
/// Capture/Compare 6 value
CCR6: u16 = 0,
/// unused [16:31]
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// capture/compare register 6
pub const CCR6 = Register(CCR6_val).init(base_address + 0x5c);

/// OR
const OR_val = packed struct {
/// TIM1_ETR_ADC1_RMP [0:1]
/// TIM1_ETR_ADC1 remapping
TIM1_ETR_ADC1_RMP: u2 = 0,
/// TIM1_ETR_ADC4_RMP [2:3]
/// TIM1_ETR_ADC4 remapping
TIM1_ETR_ADC4_RMP: u2 = 0,
/// unused [4:31]
_unused4: u4 = 0,
_unused8: u8 = 0,
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// option registers
pub const OR = Register(OR_val).init(base_address + 0x60);
};

/// Advanced timer
pub const TIM20 = struct {

const base_address = 0x40015000;
/// CR1
const CR1_val = packed struct {
/// CEN [0:0]
/// Counter enable
CEN: u1 = 0,
/// UDIS [1:1]
/// Update disable
UDIS: u1 = 0,
/// URS [2:2]
/// Update request source
URS: u1 = 0,
/// OPM [3:3]
/// One-pulse mode
OPM: u1 = 0,
/// DIR [4:4]
/// Direction
DIR: u1 = 0,
/// CMS [5:6]
/// Center-aligned mode
CMS: u2 = 0,
/// ARPE [7:7]
/// Auto-reload preload enable
ARPE: u1 = 0,
/// CKD [8:9]
/// Clock division
CKD: u2 = 0,
/// unused [10:10]
_unused10: u1 = 0,
/// UIFREMAP [11:11]
/// UIF status bit remapping
UIFREMAP: u1 = 0,
/// unused [12:31]
_unused12: u4 = 0,
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// control register 1
pub const CR1 = Register(CR1_val).init(base_address + 0x0);

/// CR2
const CR2_val = packed struct {
/// CCPC [0:0]
/// Capture/compare preloaded
CCPC: u1 = 0,
/// unused [1:1]
_unused1: u1 = 0,
/// CCUS [2:2]
/// Capture/compare control update
CCUS: u1 = 0,
/// CCDS [3:3]
/// Capture/compare DMA
CCDS: u1 = 0,
/// MMS [4:6]
/// Master mode selection
MMS: u3 = 0,
/// TI1S [7:7]
/// TI1 selection
TI1S: u1 = 0,
/// OIS1 [8:8]
/// Output Idle state 1
OIS1: u1 = 0,
/// OIS1N [9:9]
/// Output Idle state 1
OIS1N: u1 = 0,
/// OIS2 [10:10]
/// Output Idle state 2
OIS2: u1 = 0,
/// OIS2N [11:11]
/// Output Idle state 2
OIS2N: u1 = 0,
/// OIS3 [12:12]
/// Output Idle state 3
OIS3: u1 = 0,
/// OIS3N [13:13]
/// Output Idle state 3
OIS3N: u1 = 0,
/// OIS4 [14:14]
/// Output Idle state 4
OIS4: u1 = 0,
/// unused [15:15]
_unused15: u1 = 0,
/// OIS5 [16:16]
/// Output Idle state 5
OIS5: u1 = 0,
/// unused [17:17]
_unused17: u1 = 0,
/// OIS6 [18:18]
/// Output Idle state 6
OIS6: u1 = 0,
/// unused [19:19]
_unused19: u1 = 0,
/// MMS2 [20:23]
/// Master mode selection 2
MMS2: u4 = 0,
/// unused [24:31]
_unused24: u8 = 0,
};
/// control register 2
pub const CR2 = Register(CR2_val).init(base_address + 0x4);

/// SMCR
const SMCR_val = packed struct {
/// SMS [0:2]
/// Slave mode selection
SMS: u3 = 0,
/// OCCS [3:3]
/// OCREF clear selection
OCCS: u1 = 0,
/// TS [4:6]
/// Trigger selection
TS: u3 = 0,
/// MSM [7:7]
/// Master/Slave mode
MSM: u1 = 0,
/// ETF [8:11]
/// External trigger filter
ETF: u4 = 0,
/// ETPS [12:13]
/// External trigger prescaler
ETPS: u2 = 0,
/// ECE [14:14]
/// External clock enable
ECE: u1 = 0,
/// ETP [15:15]
/// External trigger polarity
ETP: u1 = 0,
/// SMS3 [16:16]
/// Slave mode selection bit 3
SMS3: u1 = 0,
/// unused [17:31]
_unused17: u7 = 0,
_unused24: u8 = 0,
};
/// slave mode control register
pub const SMCR = Register(SMCR_val).init(base_address + 0x8);

/// DIER
const DIER_val = packed struct {
/// UIE [0:0]
/// Update interrupt enable
UIE: u1 = 0,
/// CC1IE [1:1]
/// Capture/Compare 1 interrupt
CC1IE: u1 = 0,
/// CC2IE [2:2]
/// Capture/Compare 2 interrupt
CC2IE: u1 = 0,
/// CC3IE [3:3]
/// Capture/Compare 3 interrupt
CC3IE: u1 = 0,
/// CC4IE [4:4]
/// Capture/Compare 4 interrupt
CC4IE: u1 = 0,
/// COMIE [5:5]
/// COM interrupt enable
COMIE: u1 = 0,
/// TIE [6:6]
/// Trigger interrupt enable
TIE: u1 = 0,
/// BIE [7:7]
/// Break interrupt enable
BIE: u1 = 0,
/// UDE [8:8]
/// Update DMA request enable
UDE: u1 = 0,
/// CC1DE [9:9]
/// Capture/Compare 1 DMA request
CC1DE: u1 = 0,
/// CC2DE [10:10]
/// Capture/Compare 2 DMA request
CC2DE: u1 = 0,
/// CC3DE [11:11]
/// Capture/Compare 3 DMA request
CC3DE: u1 = 0,
/// CC4DE [12:12]
/// Capture/Compare 4 DMA request
CC4DE: u1 = 0,
/// COMDE [13:13]
/// COM DMA request enable
COMDE: u1 = 0,
/// TDE [14:14]
/// Trigger DMA request enable
TDE: u1 = 0,
/// unused [15:31]
_unused15: u1 = 0,
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// DMA/Interrupt enable register
pub const DIER = Register(DIER_val).init(base_address + 0xc);

/// SR
const SR_val = packed struct {
/// UIF [0:0]
/// Update interrupt flag
UIF: u1 = 0,
/// CC1IF [1:1]
/// Capture/compare 1 interrupt
CC1IF: u1 = 0,
/// CC2IF [2:2]
/// Capture/Compare 2 interrupt
CC2IF: u1 = 0,
/// CC3IF [3:3]
/// Capture/Compare 3 interrupt
CC3IF: u1 = 0,
/// CC4IF [4:4]
/// Capture/Compare 4 interrupt
CC4IF: u1 = 0,
/// COMIF [5:5]
/// COM interrupt flag
COMIF: u1 = 0,
/// TIF [6:6]
/// Trigger interrupt flag
TIF: u1 = 0,
/// BIF [7:7]
/// Break interrupt flag
BIF: u1 = 0,
/// B2IF [8:8]
/// Break 2 interrupt flag
B2IF: u1 = 0,
/// CC1OF [9:9]
/// Capture/Compare 1 overcapture
CC1OF: u1 = 0,
/// CC2OF [10:10]
/// Capture/compare 2 overcapture
CC2OF: u1 = 0,
/// CC3OF [11:11]
/// Capture/Compare 3 overcapture
CC3OF: u1 = 0,
/// CC4OF [12:12]
/// Capture/Compare 4 overcapture
CC4OF: u1 = 0,
/// unused [13:15]
_unused13: u3 = 0,
/// C5IF [16:16]
/// Capture/Compare 5 interrupt
C5IF: u1 = 0,
/// C6IF [17:17]
/// Capture/Compare 6 interrupt
C6IF: u1 = 0,
/// unused [18:31]
_unused18: u6 = 0,
_unused24: u8 = 0,
};
/// status register
pub const SR = Register(SR_val).init(base_address + 0x10);

/// EGR
const EGR_val = packed struct {
/// UG [0:0]
/// Update generation
UG: u1 = 0,
/// CC1G [1:1]
/// Capture/compare 1
CC1G: u1 = 0,
/// CC2G [2:2]
/// Capture/compare 2
CC2G: u1 = 0,
/// CC3G [3:3]
/// Capture/compare 3
CC3G: u1 = 0,
/// CC4G [4:4]
/// Capture/compare 4
CC4G: u1 = 0,
/// COMG [5:5]
/// Capture/Compare control update
COMG: u1 = 0,
/// TG [6:6]
/// Trigger generation
TG: u1 = 0,
/// BG [7:7]
/// Break generation
BG: u1 = 0,
/// B2G [8:8]
/// Break 2 generation
B2G: u1 = 0,
/// unused [9:31]
_unused9: u7 = 0,
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// event generation register
pub const EGR = Register(EGR_val).init(base_address + 0x14);

/// CCMR1_Output
const CCMR1_Output_val = packed struct {
/// CC1S [0:1]
/// Capture/Compare 1
CC1S: u2 = 0,
/// OC1FE [2:2]
/// Output Compare 1 fast
OC1FE: u1 = 0,
/// OC1PE [3:3]
/// Output Compare 1 preload
OC1PE: u1 = 0,
/// OC1M [4:6]
/// Output Compare 1 mode
OC1M: u3 = 0,
/// OC1CE [7:7]
/// Output Compare 1 clear
OC1CE: u1 = 0,
/// CC2S [8:9]
/// Capture/Compare 2
CC2S: u2 = 0,
/// OC2FE [10:10]
/// Output Compare 2 fast
OC2FE: u1 = 0,
/// OC2PE [11:11]
/// Output Compare 2 preload
OC2PE: u1 = 0,
/// OC2M [12:14]
/// Output Compare 2 mode
OC2M: u3 = 0,
/// OC2CE [15:15]
/// Output Compare 2 clear
OC2CE: u1 = 0,
/// OC1M_3 [16:16]
/// Output Compare 1 mode bit
OC1M_3: u1 = 0,
/// unused [17:23]
_unused17: u7 = 0,
/// OC2M_3 [24:24]
/// Output Compare 2 mode bit
OC2M_3: u1 = 0,
/// unused [25:31]
_unused25: u7 = 0,
};
/// capture/compare mode register (output
pub const CCMR1_Output = Register(CCMR1_Output_val).init(base_address + 0x18);

/// CCMR1_Input
const CCMR1_Input_val = packed struct {
/// CC1S [0:1]
/// Capture/Compare 1
CC1S: u2 = 0,
/// IC1PCS [2:3]
/// Input capture 1 prescaler
IC1PCS: u2 = 0,
/// IC1F [4:7]
/// Input capture 1 filter
IC1F: u4 = 0,
/// CC2S [8:9]
/// Capture/Compare 2
CC2S: u2 = 0,
/// IC2PCS [10:11]
/// Input capture 2 prescaler
IC2PCS: u2 = 0,
/// IC2F [12:15]
/// Input capture 2 filter
IC2F: u4 = 0,
/// unused [16:31]
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// capture/compare mode register 1 (input
pub const CCMR1_Input = Register(CCMR1_Input_val).init(base_address + 0x18);

/// CCMR2_Output
const CCMR2_Output_val = packed struct {
/// CC3S [0:1]
/// Capture/Compare 3
CC3S: u2 = 0,
/// OC3FE [2:2]
/// Output compare 3 fast
OC3FE: u1 = 0,
/// OC3PE [3:3]
/// Output compare 3 preload
OC3PE: u1 = 0,
/// OC3M [4:6]
/// Output compare 3 mode
OC3M: u3 = 0,
/// OC3CE [7:7]
/// Output compare 3 clear
OC3CE: u1 = 0,
/// CC4S [8:9]
/// Capture/Compare 4
CC4S: u2 = 0,
/// OC4FE [10:10]
/// Output compare 4 fast
OC4FE: u1 = 0,
/// OC4PE [11:11]
/// Output compare 4 preload
OC4PE: u1 = 0,
/// OC4M [12:14]
/// Output compare 4 mode
OC4M: u3 = 0,
/// OC4CE [15:15]
/// Output compare 4 clear
OC4CE: u1 = 0,
/// OC3M_3 [16:16]
/// Output Compare 3 mode bit
OC3M_3: u1 = 0,
/// unused [17:23]
_unused17: u7 = 0,
/// OC4M_3 [24:24]
/// Output Compare 4 mode bit
OC4M_3: u1 = 0,
/// unused [25:31]
_unused25: u7 = 0,
};
/// capture/compare mode register (output
pub const CCMR2_Output = Register(CCMR2_Output_val).init(base_address + 0x1c);

/// CCMR2_Input
const CCMR2_Input_val = packed struct {
/// CC3S [0:1]
/// Capture/compare 3
CC3S: u2 = 0,
/// IC3PSC [2:3]
/// Input capture 3 prescaler
IC3PSC: u2 = 0,
/// IC3F [4:7]
/// Input capture 3 filter
IC3F: u4 = 0,
/// CC4S [8:9]
/// Capture/Compare 4
CC4S: u2 = 0,
/// IC4PSC [10:11]
/// Input capture 4 prescaler
IC4PSC: u2 = 0,
/// IC4F [12:15]
/// Input capture 4 filter
IC4F: u4 = 0,
/// unused [16:31]
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// capture/compare mode register 2 (input
pub const CCMR2_Input = Register(CCMR2_Input_val).init(base_address + 0x1c);

/// CCER
const CCER_val = packed struct {
/// CC1E [0:0]
/// Capture/Compare 1 output
CC1E: u1 = 0,
/// CC1P [1:1]
/// Capture/Compare 1 output
CC1P: u1 = 0,
/// CC1NE [2:2]
/// Capture/Compare 1 complementary output
CC1NE: u1 = 0,
/// CC1NP [3:3]
/// Capture/Compare 1 output
CC1NP: u1 = 0,
/// CC2E [4:4]
/// Capture/Compare 2 output
CC2E: u1 = 0,
/// CC2P [5:5]
/// Capture/Compare 2 output
CC2P: u1 = 0,
/// CC2NE [6:6]
/// Capture/Compare 2 complementary output
CC2NE: u1 = 0,
/// CC2NP [7:7]
/// Capture/Compare 2 output
CC2NP: u1 = 0,
/// CC3E [8:8]
/// Capture/Compare 3 output
CC3E: u1 = 0,
/// CC3P [9:9]
/// Capture/Compare 3 output
CC3P: u1 = 0,
/// CC3NE [10:10]
/// Capture/Compare 3 complementary output
CC3NE: u1 = 0,
/// CC3NP [11:11]
/// Capture/Compare 3 output
CC3NP: u1 = 0,
/// CC4E [12:12]
/// Capture/Compare 4 output
CC4E: u1 = 0,
/// CC4P [13:13]
/// Capture/Compare 3 output
CC4P: u1 = 0,
/// unused [14:14]
_unused14: u1 = 0,
/// CC4NP [15:15]
/// Capture/Compare 4 output
CC4NP: u1 = 0,
/// CC5E [16:16]
/// Capture/Compare 5 output
CC5E: u1 = 0,
/// CC5P [17:17]
/// Capture/Compare 5 output
CC5P: u1 = 0,
/// unused [18:19]
_unused18: u2 = 0,
/// CC6E [20:20]
/// Capture/Compare 6 output
CC6E: u1 = 0,
/// CC6P [21:21]
/// Capture/Compare 6 output
CC6P: u1 = 0,
/// unused [22:31]
_unused22: u2 = 0,
_unused24: u8 = 0,
};
/// capture/compare enable
pub const CCER = Register(CCER_val).init(base_address + 0x20);

/// CNT
const CNT_val = packed struct {
/// CNT [0:15]
/// counter value
CNT: u16 = 0,
/// unused [16:30]
_unused16: u8 = 0,
_unused24: u7 = 0,
/// UIFCPY [31:31]
/// UIF copy
UIFCPY: u1 = 0,
};
/// counter
pub const CNT = Register(CNT_val).init(base_address + 0x24);

/// PSC
const PSC_val = packed struct {
/// PSC [0:15]
/// Prescaler value
PSC: u16 = 0,
/// unused [16:31]
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// prescaler
pub const PSC = Register(PSC_val).init(base_address + 0x28);

/// ARR
const ARR_val = packed struct {
/// ARR [0:15]
/// Auto-reload value
ARR: u16 = 0,
/// unused [16:31]
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// auto-reload register
pub const ARR = Register(ARR_val).init(base_address + 0x2c);

/// RCR
const RCR_val = packed struct {
/// REP [0:15]
/// Repetition counter value
REP: u16 = 0,
/// unused [16:31]
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// repetition counter register
pub const RCR = Register(RCR_val).init(base_address + 0x30);

/// CCR1
const CCR1_val = packed struct {
/// CCR1 [0:15]
/// Capture/Compare 1 value
CCR1: u16 = 0,
/// unused [16:31]
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// capture/compare register 1
pub const CCR1 = Register(CCR1_val).init(base_address + 0x34);

/// CCR2
const CCR2_val = packed struct {
/// CCR2 [0:15]
/// Capture/Compare 2 value
CCR2: u16 = 0,
/// unused [16:31]
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// capture/compare register 2
pub const CCR2 = Register(CCR2_val).init(base_address + 0x38);

/// CCR3
const CCR3_val = packed struct {
/// CCR3 [0:15]
/// Capture/Compare 3 value
CCR3: u16 = 0,
/// unused [16:31]
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// capture/compare register 3
pub const CCR3 = Register(CCR3_val).init(base_address + 0x3c);

/// CCR4
const CCR4_val = packed struct {
/// CCR4 [0:15]
/// Capture/Compare 3 value
CCR4: u16 = 0,
/// unused [16:31]
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// capture/compare register 4
pub const CCR4 = Register(CCR4_val).init(base_address + 0x40);

/// BDTR
const BDTR_val = packed struct {
/// DTG [0:7]
/// Dead-time generator setup
DTG: u8 = 0,
/// LOCK [8:9]
/// Lock configuration
LOCK: u2 = 0,
/// OSSI [10:10]
/// Off-state selection for Idle
OSSI: u1 = 0,
/// OSSR [11:11]
/// Off-state selection for Run
OSSR: u1 = 0,
/// BKE [12:12]
/// Break enable
BKE: u1 = 0,
/// BKP [13:13]
/// Break polarity
BKP: u1 = 0,
/// AOE [14:14]
/// Automatic output enable
AOE: u1 = 0,
/// MOE [15:15]
/// Main output enable
MOE: u1 = 0,
/// BKF [16:19]
/// Break filter
BKF: u4 = 0,
/// BK2F [20:23]
/// Break 2 filter
BK2F: u4 = 0,
/// BK2E [24:24]
/// Break 2 enable
BK2E: u1 = 0,
/// BK2P [25:25]
/// Break 2 polarity
BK2P: u1 = 0,
/// unused [26:31]
_unused26: u6 = 0,
};
/// break and dead-time register
pub const BDTR = Register(BDTR_val).init(base_address + 0x44);

/// DCR
const DCR_val = packed struct {
/// DBA [0:4]
/// DMA base address
DBA: u5 = 0,
/// unused [5:7]
_unused5: u3 = 0,
/// DBL [8:12]
/// DMA burst length
DBL: u5 = 0,
/// unused [13:31]
_unused13: u3 = 0,
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// DMA control register
pub const DCR = Register(DCR_val).init(base_address + 0x48);

/// DMAR
const DMAR_val = packed struct {
/// DMAB [0:15]
/// DMA register for burst
DMAB: u16 = 0,
/// unused [16:31]
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// DMA address for full transfer
pub const DMAR = Register(DMAR_val).init(base_address + 0x4c);

/// CCMR3_Output
const CCMR3_Output_val = packed struct {
/// unused [0:1]
_unused0: u2 = 0,
/// OC5FE [2:2]
/// Output compare 5 fast
OC5FE: u1 = 0,
/// OC5PE [3:3]
/// Output compare 5 preload
OC5PE: u1 = 0,
/// OC5M [4:6]
/// Output compare 5 mode
OC5M: u3 = 0,
/// OC5CE [7:7]
/// Output compare 5 clear
OC5CE: u1 = 0,
/// unused [8:9]
_unused8: u2 = 0,
/// OC6FE [10:10]
/// Output compare 6 fast
OC6FE: u1 = 0,
/// OC6PE [11:11]
/// Output compare 6 preload
OC6PE: u1 = 0,
/// OC6M [12:14]
/// Output compare 6 mode
OC6M: u3 = 0,
/// OC6CE [15:15]
/// Output compare 6 clear
OC6CE: u1 = 0,
/// OC5M_3 [16:16]
/// Outout Compare 5 mode bit
OC5M_3: u1 = 0,
/// unused [17:23]
_unused17: u7 = 0,
/// OC6M_3 [24:24]
/// Outout Compare 6 mode bit
OC6M_3: u1 = 0,
/// unused [25:31]
_unused25: u7 = 0,
};
/// capture/compare mode register 3 (output
pub const CCMR3_Output = Register(CCMR3_Output_val).init(base_address + 0x54);

/// CCR5
const CCR5_val = packed struct {
/// CCR5 [0:15]
/// Capture/Compare 5 value
CCR5: u16 = 0,
/// unused [16:28]
_unused16: u8 = 0,
_unused24: u5 = 0,
/// GC5C1 [29:29]
/// Group Channel 5 and Channel
GC5C1: u1 = 0,
/// GC5C2 [30:30]
/// Group Channel 5 and Channel
GC5C2: u1 = 0,
/// GC5C3 [31:31]
/// Group Channel 5 and Channel
GC5C3: u1 = 0,
};
/// capture/compare register 5
pub const CCR5 = Register(CCR5_val).init(base_address + 0x58);

/// CCR6
const CCR6_val = packed struct {
/// CCR6 [0:15]
/// Capture/Compare 6 value
CCR6: u16 = 0,
/// unused [16:31]
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// capture/compare register 6
pub const CCR6 = Register(CCR6_val).init(base_address + 0x5c);

/// OR
const OR_val = packed struct {
/// TIM1_ETR_ADC1_RMP [0:1]
/// TIM1_ETR_ADC1 remapping
TIM1_ETR_ADC1_RMP: u2 = 0,
/// TIM1_ETR_ADC4_RMP [2:3]
/// TIM1_ETR_ADC4 remapping
TIM1_ETR_ADC4_RMP: u2 = 0,
/// unused [4:31]
_unused4: u4 = 0,
_unused8: u8 = 0,
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// option registers
pub const OR = Register(OR_val).init(base_address + 0x60);
};

/// Advanced-timers
pub const TIM8 = struct {

const base_address = 0x40013400;
/// CR1
const CR1_val = packed struct {
/// CEN [0:0]
/// Counter enable
CEN: u1 = 0,
/// UDIS [1:1]
/// Update disable
UDIS: u1 = 0,
/// URS [2:2]
/// Update request source
URS: u1 = 0,
/// OPM [3:3]
/// One-pulse mode
OPM: u1 = 0,
/// DIR [4:4]
/// Direction
DIR: u1 = 0,
/// CMS [5:6]
/// Center-aligned mode
CMS: u2 = 0,
/// ARPE [7:7]
/// Auto-reload preload enable
ARPE: u1 = 0,
/// CKD [8:9]
/// Clock division
CKD: u2 = 0,
/// unused [10:10]
_unused10: u1 = 0,
/// UIFREMAP [11:11]
/// UIF status bit remapping
UIFREMAP: u1 = 0,
/// unused [12:31]
_unused12: u4 = 0,
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// control register 1
pub const CR1 = Register(CR1_val).init(base_address + 0x0);

/// CR2
const CR2_val = packed struct {
/// CCPC [0:0]
/// Capture/compare preloaded
CCPC: u1 = 0,
/// unused [1:1]
_unused1: u1 = 0,
/// CCUS [2:2]
/// Capture/compare control update
CCUS: u1 = 0,
/// CCDS [3:3]
/// Capture/compare DMA
CCDS: u1 = 0,
/// MMS [4:6]
/// Master mode selection
MMS: u3 = 0,
/// TI1S [7:7]
/// TI1 selection
TI1S: u1 = 0,
/// OIS1 [8:8]
/// Output Idle state 1
OIS1: u1 = 0,
/// OIS1N [9:9]
/// Output Idle state 1
OIS1N: u1 = 0,
/// OIS2 [10:10]
/// Output Idle state 2
OIS2: u1 = 0,
/// OIS2N [11:11]
/// Output Idle state 2
OIS2N: u1 = 0,
/// OIS3 [12:12]
/// Output Idle state 3
OIS3: u1 = 0,
/// OIS3N [13:13]
/// Output Idle state 3
OIS3N: u1 = 0,
/// OIS4 [14:14]
/// Output Idle state 4
OIS4: u1 = 0,
/// unused [15:15]
_unused15: u1 = 0,
/// OIS5 [16:16]
/// Output Idle state 5
OIS5: u1 = 0,
/// unused [17:17]
_unused17: u1 = 0,
/// OIS6 [18:18]
/// Output Idle state 6
OIS6: u1 = 0,
/// unused [19:19]
_unused19: u1 = 0,
/// MMS2 [20:23]
/// Master mode selection 2
MMS2: u4 = 0,
/// unused [24:31]
_unused24: u8 = 0,
};
/// control register 2
pub const CR2 = Register(CR2_val).init(base_address + 0x4);

/// SMCR
const SMCR_val = packed struct {
/// SMS [0:2]
/// Slave mode selection
SMS: u3 = 0,
/// OCCS [3:3]
/// OCREF clear selection
OCCS: u1 = 0,
/// TS [4:6]
/// Trigger selection
TS: u3 = 0,
/// MSM [7:7]
/// Master/Slave mode
MSM: u1 = 0,
/// ETF [8:11]
/// External trigger filter
ETF: u4 = 0,
/// ETPS [12:13]
/// External trigger prescaler
ETPS: u2 = 0,
/// ECE [14:14]
/// External clock enable
ECE: u1 = 0,
/// ETP [15:15]
/// External trigger polarity
ETP: u1 = 0,
/// SMS3 [16:16]
/// Slave mode selection bit 3
SMS3: u1 = 0,
/// unused [17:31]
_unused17: u7 = 0,
_unused24: u8 = 0,
};
/// slave mode control register
pub const SMCR = Register(SMCR_val).init(base_address + 0x8);

/// DIER
const DIER_val = packed struct {
/// UIE [0:0]
/// Update interrupt enable
UIE: u1 = 0,
/// CC1IE [1:1]
/// Capture/Compare 1 interrupt
CC1IE: u1 = 0,
/// CC2IE [2:2]
/// Capture/Compare 2 interrupt
CC2IE: u1 = 0,
/// CC3IE [3:3]
/// Capture/Compare 3 interrupt
CC3IE: u1 = 0,
/// CC4IE [4:4]
/// Capture/Compare 4 interrupt
CC4IE: u1 = 0,
/// COMIE [5:5]
/// COM interrupt enable
COMIE: u1 = 0,
/// TIE [6:6]
/// Trigger interrupt enable
TIE: u1 = 0,
/// BIE [7:7]
/// Break interrupt enable
BIE: u1 = 0,
/// UDE [8:8]
/// Update DMA request enable
UDE: u1 = 0,
/// CC1DE [9:9]
/// Capture/Compare 1 DMA request
CC1DE: u1 = 0,
/// CC2DE [10:10]
/// Capture/Compare 2 DMA request
CC2DE: u1 = 0,
/// CC3DE [11:11]
/// Capture/Compare 3 DMA request
CC3DE: u1 = 0,
/// CC4DE [12:12]
/// Capture/Compare 4 DMA request
CC4DE: u1 = 0,
/// COMDE [13:13]
/// COM DMA request enable
COMDE: u1 = 0,
/// TDE [14:14]
/// Trigger DMA request enable
TDE: u1 = 0,
/// unused [15:31]
_unused15: u1 = 0,
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// DMA/Interrupt enable register
pub const DIER = Register(DIER_val).init(base_address + 0xc);

/// SR
const SR_val = packed struct {
/// UIF [0:0]
/// Update interrupt flag
UIF: u1 = 0,
/// CC1IF [1:1]
/// Capture/compare 1 interrupt
CC1IF: u1 = 0,
/// CC2IF [2:2]
/// Capture/Compare 2 interrupt
CC2IF: u1 = 0,
/// CC3IF [3:3]
/// Capture/Compare 3 interrupt
CC3IF: u1 = 0,
/// CC4IF [4:4]
/// Capture/Compare 4 interrupt
CC4IF: u1 = 0,
/// COMIF [5:5]
/// COM interrupt flag
COMIF: u1 = 0,
/// TIF [6:6]
/// Trigger interrupt flag
TIF: u1 = 0,
/// BIF [7:7]
/// Break interrupt flag
BIF: u1 = 0,
/// B2IF [8:8]
/// Break 2 interrupt flag
B2IF: u1 = 0,
/// CC1OF [9:9]
/// Capture/Compare 1 overcapture
CC1OF: u1 = 0,
/// CC2OF [10:10]
/// Capture/compare 2 overcapture
CC2OF: u1 = 0,
/// CC3OF [11:11]
/// Capture/Compare 3 overcapture
CC3OF: u1 = 0,
/// CC4OF [12:12]
/// Capture/Compare 4 overcapture
CC4OF: u1 = 0,
/// unused [13:15]
_unused13: u3 = 0,
/// C5IF [16:16]
/// Capture/Compare 5 interrupt
C5IF: u1 = 0,
/// C6IF [17:17]
/// Capture/Compare 6 interrupt
C6IF: u1 = 0,
/// unused [18:31]
_unused18: u6 = 0,
_unused24: u8 = 0,
};
/// status register
pub const SR = Register(SR_val).init(base_address + 0x10);

/// EGR
const EGR_val = packed struct {
/// UG [0:0]
/// Update generation
UG: u1 = 0,
/// CC1G [1:1]
/// Capture/compare 1
CC1G: u1 = 0,
/// CC2G [2:2]
/// Capture/compare 2
CC2G: u1 = 0,
/// CC3G [3:3]
/// Capture/compare 3
CC3G: u1 = 0,
/// CC4G [4:4]
/// Capture/compare 4
CC4G: u1 = 0,
/// COMG [5:5]
/// Capture/Compare control update
COMG: u1 = 0,
/// TG [6:6]
/// Trigger generation
TG: u1 = 0,
/// BG [7:7]
/// Break generation
BG: u1 = 0,
/// B2G [8:8]
/// Break 2 generation
B2G: u1 = 0,
/// unused [9:31]
_unused9: u7 = 0,
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// event generation register
pub const EGR = Register(EGR_val).init(base_address + 0x14);

/// CCMR1_Output
const CCMR1_Output_val = packed struct {
/// CC1S [0:1]
/// Capture/Compare 1
CC1S: u2 = 0,
/// OC1FE [2:2]
/// Output Compare 1 fast
OC1FE: u1 = 0,
/// OC1PE [3:3]
/// Output Compare 1 preload
OC1PE: u1 = 0,
/// OC1M [4:6]
/// Output Compare 1 mode
OC1M: u3 = 0,
/// OC1CE [7:7]
/// Output Compare 1 clear
OC1CE: u1 = 0,
/// CC2S [8:9]
/// Capture/Compare 2
CC2S: u2 = 0,
/// OC2FE [10:10]
/// Output Compare 2 fast
OC2FE: u1 = 0,
/// OC2PE [11:11]
/// Output Compare 2 preload
OC2PE: u1 = 0,
/// OC2M [12:14]
/// Output Compare 2 mode
OC2M: u3 = 0,
/// OC2CE [15:15]
/// Output Compare 2 clear
OC2CE: u1 = 0,
/// OC1M_3 [16:16]
/// Output Compare 1 mode bit
OC1M_3: u1 = 0,
/// unused [17:23]
_unused17: u7 = 0,
/// OC2M_3 [24:24]
/// Output Compare 2 mode bit
OC2M_3: u1 = 0,
/// unused [25:31]
_unused25: u7 = 0,
};
/// capture/compare mode register (output
pub const CCMR1_Output = Register(CCMR1_Output_val).init(base_address + 0x18);

/// CCMR1_Input
const CCMR1_Input_val = packed struct {
/// CC1S [0:1]
/// Capture/Compare 1
CC1S: u2 = 0,
/// IC1PCS [2:3]
/// Input capture 1 prescaler
IC1PCS: u2 = 0,
/// IC1F [4:7]
/// Input capture 1 filter
IC1F: u4 = 0,
/// CC2S [8:9]
/// Capture/Compare 2
CC2S: u2 = 0,
/// IC2PCS [10:11]
/// Input capture 2 prescaler
IC2PCS: u2 = 0,
/// IC2F [12:15]
/// Input capture 2 filter
IC2F: u4 = 0,
/// unused [16:31]
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// capture/compare mode register 1 (input
pub const CCMR1_Input = Register(CCMR1_Input_val).init(base_address + 0x18);

/// CCMR2_Output
const CCMR2_Output_val = packed struct {
/// CC3S [0:1]
/// Capture/Compare 3
CC3S: u2 = 0,
/// OC3FE [2:2]
/// Output compare 3 fast
OC3FE: u1 = 0,
/// OC3PE [3:3]
/// Output compare 3 preload
OC3PE: u1 = 0,
/// OC3M [4:6]
/// Output compare 3 mode
OC3M: u3 = 0,
/// OC3CE [7:7]
/// Output compare 3 clear
OC3CE: u1 = 0,
/// CC4S [8:9]
/// Capture/Compare 4
CC4S: u2 = 0,
/// OC4FE [10:10]
/// Output compare 4 fast
OC4FE: u1 = 0,
/// OC4PE [11:11]
/// Output compare 4 preload
OC4PE: u1 = 0,
/// OC4M [12:14]
/// Output compare 4 mode
OC4M: u3 = 0,
/// OC4CE [15:15]
/// Output compare 4 clear
OC4CE: u1 = 0,
/// OC3M_3 [16:16]
/// Output Compare 3 mode bit
OC3M_3: u1 = 0,
/// unused [17:23]
_unused17: u7 = 0,
/// OC4M_3 [24:24]
/// Output Compare 4 mode bit
OC4M_3: u1 = 0,
/// unused [25:31]
_unused25: u7 = 0,
};
/// capture/compare mode register (output
pub const CCMR2_Output = Register(CCMR2_Output_val).init(base_address + 0x1c);

/// CCMR2_Input
const CCMR2_Input_val = packed struct {
/// CC3S [0:1]
/// Capture/compare 3
CC3S: u2 = 0,
/// IC3PSC [2:3]
/// Input capture 3 prescaler
IC3PSC: u2 = 0,
/// IC3F [4:7]
/// Input capture 3 filter
IC3F: u4 = 0,
/// CC4S [8:9]
/// Capture/Compare 4
CC4S: u2 = 0,
/// IC4PSC [10:11]
/// Input capture 4 prescaler
IC4PSC: u2 = 0,
/// IC4F [12:15]
/// Input capture 4 filter
IC4F: u4 = 0,
/// unused [16:31]
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// capture/compare mode register 2 (input
pub const CCMR2_Input = Register(CCMR2_Input_val).init(base_address + 0x1c);

/// CCER
const CCER_val = packed struct {
/// CC1E [0:0]
/// Capture/Compare 1 output
CC1E: u1 = 0,
/// CC1P [1:1]
/// Capture/Compare 1 output
CC1P: u1 = 0,
/// CC1NE [2:2]
/// Capture/Compare 1 complementary output
CC1NE: u1 = 0,
/// CC1NP [3:3]
/// Capture/Compare 1 output
CC1NP: u1 = 0,
/// CC2E [4:4]
/// Capture/Compare 2 output
CC2E: u1 = 0,
/// CC2P [5:5]
/// Capture/Compare 2 output
CC2P: u1 = 0,
/// CC2NE [6:6]
/// Capture/Compare 2 complementary output
CC2NE: u1 = 0,
/// CC2NP [7:7]
/// Capture/Compare 2 output
CC2NP: u1 = 0,
/// CC3E [8:8]
/// Capture/Compare 3 output
CC3E: u1 = 0,
/// CC3P [9:9]
/// Capture/Compare 3 output
CC3P: u1 = 0,
/// CC3NE [10:10]
/// Capture/Compare 3 complementary output
CC3NE: u1 = 0,
/// CC3NP [11:11]
/// Capture/Compare 3 output
CC3NP: u1 = 0,
/// CC4E [12:12]
/// Capture/Compare 4 output
CC4E: u1 = 0,
/// CC4P [13:13]
/// Capture/Compare 3 output
CC4P: u1 = 0,
/// unused [14:14]
_unused14: u1 = 0,
/// CC4NP [15:15]
/// Capture/Compare 4 output
CC4NP: u1 = 0,
/// CC5E [16:16]
/// Capture/Compare 5 output
CC5E: u1 = 0,
/// CC5P [17:17]
/// Capture/Compare 5 output
CC5P: u1 = 0,
/// unused [18:19]
_unused18: u2 = 0,
/// CC6E [20:20]
/// Capture/Compare 6 output
CC6E: u1 = 0,
/// CC6P [21:21]
/// Capture/Compare 6 output
CC6P: u1 = 0,
/// unused [22:31]
_unused22: u2 = 0,
_unused24: u8 = 0,
};
/// capture/compare enable
pub const CCER = Register(CCER_val).init(base_address + 0x20);

/// CNT
const CNT_val = packed struct {
/// CNT [0:15]
/// counter value
CNT: u16 = 0,
/// unused [16:30]
_unused16: u8 = 0,
_unused24: u7 = 0,
/// UIFCPY [31:31]
/// UIF copy
UIFCPY: u1 = 0,
};
/// counter
pub const CNT = Register(CNT_val).init(base_address + 0x24);

/// PSC
const PSC_val = packed struct {
/// PSC [0:15]
/// Prescaler value
PSC: u16 = 0,
/// unused [16:31]
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// prescaler
pub const PSC = Register(PSC_val).init(base_address + 0x28);

/// ARR
const ARR_val = packed struct {
/// ARR [0:15]
/// Auto-reload value
ARR: u16 = 0,
/// unused [16:31]
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// auto-reload register
pub const ARR = Register(ARR_val).init(base_address + 0x2c);

/// RCR
const RCR_val = packed struct {
/// REP [0:15]
/// Repetition counter value
REP: u16 = 0,
/// unused [16:31]
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// repetition counter register
pub const RCR = Register(RCR_val).init(base_address + 0x30);

/// CCR1
const CCR1_val = packed struct {
/// CCR1 [0:15]
/// Capture/Compare 1 value
CCR1: u16 = 0,
/// unused [16:31]
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// capture/compare register 1
pub const CCR1 = Register(CCR1_val).init(base_address + 0x34);

/// CCR2
const CCR2_val = packed struct {
/// CCR2 [0:15]
/// Capture/Compare 2 value
CCR2: u16 = 0,
/// unused [16:31]
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// capture/compare register 2
pub const CCR2 = Register(CCR2_val).init(base_address + 0x38);

/// CCR3
const CCR3_val = packed struct {
/// CCR3 [0:15]
/// Capture/Compare 3 value
CCR3: u16 = 0,
/// unused [16:31]
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// capture/compare register 3
pub const CCR3 = Register(CCR3_val).init(base_address + 0x3c);

/// CCR4
const CCR4_val = packed struct {
/// CCR4 [0:15]
/// Capture/Compare 3 value
CCR4: u16 = 0,
/// unused [16:31]
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// capture/compare register 4
pub const CCR4 = Register(CCR4_val).init(base_address + 0x40);

/// BDTR
const BDTR_val = packed struct {
/// DTG [0:7]
/// Dead-time generator setup
DTG: u8 = 0,
/// LOCK [8:9]
/// Lock configuration
LOCK: u2 = 0,
/// OSSI [10:10]
/// Off-state selection for Idle
OSSI: u1 = 0,
/// OSSR [11:11]
/// Off-state selection for Run
OSSR: u1 = 0,
/// BKE [12:12]
/// Break enable
BKE: u1 = 0,
/// BKP [13:13]
/// Break polarity
BKP: u1 = 0,
/// AOE [14:14]
/// Automatic output enable
AOE: u1 = 0,
/// MOE [15:15]
/// Main output enable
MOE: u1 = 0,
/// BKF [16:19]
/// Break filter
BKF: u4 = 0,
/// BK2F [20:23]
/// Break 2 filter
BK2F: u4 = 0,
/// BK2E [24:24]
/// Break 2 enable
BK2E: u1 = 0,
/// BK2P [25:25]
/// Break 2 polarity
BK2P: u1 = 0,
/// unused [26:31]
_unused26: u6 = 0,
};
/// break and dead-time register
pub const BDTR = Register(BDTR_val).init(base_address + 0x44);

/// DCR
const DCR_val = packed struct {
/// DBA [0:4]
/// DMA base address
DBA: u5 = 0,
/// unused [5:7]
_unused5: u3 = 0,
/// DBL [8:12]
/// DMA burst length
DBL: u5 = 0,
/// unused [13:31]
_unused13: u3 = 0,
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// DMA control register
pub const DCR = Register(DCR_val).init(base_address + 0x48);

/// DMAR
const DMAR_val = packed struct {
/// DMAB [0:15]
/// DMA register for burst
DMAB: u16 = 0,
/// unused [16:31]
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// DMA address for full transfer
pub const DMAR = Register(DMAR_val).init(base_address + 0x4c);

/// CCMR3_Output
const CCMR3_Output_val = packed struct {
/// unused [0:1]
_unused0: u2 = 0,
/// OC5FE [2:2]
/// Output compare 5 fast
OC5FE: u1 = 0,
/// OC5PE [3:3]
/// Output compare 5 preload
OC5PE: u1 = 0,
/// OC5M [4:6]
/// Output compare 5 mode
OC5M: u3 = 0,
/// OC5CE [7:7]
/// Output compare 5 clear
OC5CE: u1 = 0,
/// unused [8:9]
_unused8: u2 = 0,
/// OC6FE [10:10]
/// Output compare 6 fast
OC6FE: u1 = 0,
/// OC6PE [11:11]
/// Output compare 6 preload
OC6PE: u1 = 0,
/// OC6M [12:14]
/// Output compare 6 mode
OC6M: u3 = 0,
/// OC6CE [15:15]
/// Output compare 6 clear
OC6CE: u1 = 0,
/// OC5M_3 [16:16]
/// Outout Compare 5 mode bit
OC5M_3: u1 = 0,
/// unused [17:23]
_unused17: u7 = 0,
/// OC6M_3 [24:24]
/// Outout Compare 6 mode bit
OC6M_3: u1 = 0,
/// unused [25:31]
_unused25: u7 = 0,
};
/// capture/compare mode register 3 (output
pub const CCMR3_Output = Register(CCMR3_Output_val).init(base_address + 0x54);

/// CCR5
const CCR5_val = packed struct {
/// CCR5 [0:15]
/// Capture/Compare 5 value
CCR5: u16 = 0,
/// unused [16:28]
_unused16: u8 = 0,
_unused24: u5 = 0,
/// GC5C1 [29:29]
/// Group Channel 5 and Channel
GC5C1: u1 = 0,
/// GC5C2 [30:30]
/// Group Channel 5 and Channel
GC5C2: u1 = 0,
/// GC5C3 [31:31]
/// Group Channel 5 and Channel
GC5C3: u1 = 0,
};
/// capture/compare register 5
pub const CCR5 = Register(CCR5_val).init(base_address + 0x58);

/// CCR6
const CCR6_val = packed struct {
/// CCR6 [0:15]
/// Capture/Compare 6 value
CCR6: u16 = 0,
/// unused [16:31]
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// capture/compare register 6
pub const CCR6 = Register(CCR6_val).init(base_address + 0x5c);

/// OR
const OR_val = packed struct {
/// TIM8_ETR_ADC2_RMP [0:1]
/// TIM8_ETR_ADC2 remapping
TIM8_ETR_ADC2_RMP: u2 = 0,
/// TIM8_ETR_ADC3_RMP [2:3]
/// TIM8_ETR_ADC3 remapping
TIM8_ETR_ADC3_RMP: u2 = 0,
/// unused [4:31]
_unused4: u4 = 0,
_unused8: u8 = 0,
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// option registers
pub const OR = Register(OR_val).init(base_address + 0x60);
};

/// Analog-to-Digital Converter
pub const ADC1 = struct {

const base_address = 0x50000000;
/// ISR
const ISR_val = packed struct {
/// ADRDY [0:0]
/// ADRDY
ADRDY: u1 = 0,
/// EOSMP [1:1]
/// EOSMP
EOSMP: u1 = 0,
/// EOC [2:2]
/// EOC
EOC: u1 = 0,
/// EOS [3:3]
/// EOS
EOS: u1 = 0,
/// OVR [4:4]
/// OVR
OVR: u1 = 0,
/// JEOC [5:5]
/// JEOC
JEOC: u1 = 0,
/// JEOS [6:6]
/// JEOS
JEOS: u1 = 0,
/// AWD1 [7:7]
/// AWD1
AWD1: u1 = 0,
/// AWD2 [8:8]
/// AWD2
AWD2: u1 = 0,
/// AWD3 [9:9]
/// AWD3
AWD3: u1 = 0,
/// JQOVF [10:10]
/// JQOVF
JQOVF: u1 = 0,
/// unused [11:31]
_unused11: u5 = 0,
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// interrupt and status register
pub const ISR = Register(ISR_val).init(base_address + 0x0);

/// IER
const IER_val = packed struct {
/// ADRDYIE [0:0]
/// ADRDYIE
ADRDYIE: u1 = 0,
/// EOSMPIE [1:1]
/// EOSMPIE
EOSMPIE: u1 = 0,
/// EOCIE [2:2]
/// EOCIE
EOCIE: u1 = 0,
/// EOSIE [3:3]
/// EOSIE
EOSIE: u1 = 0,
/// OVRIE [4:4]
/// OVRIE
OVRIE: u1 = 0,
/// JEOCIE [5:5]
/// JEOCIE
JEOCIE: u1 = 0,
/// JEOSIE [6:6]
/// JEOSIE
JEOSIE: u1 = 0,
/// AWD1IE [7:7]
/// AWD1IE
AWD1IE: u1 = 0,
/// AWD2IE [8:8]
/// AWD2IE
AWD2IE: u1 = 0,
/// AWD3IE [9:9]
/// AWD3IE
AWD3IE: u1 = 0,
/// JQOVFIE [10:10]
/// JQOVFIE
JQOVFIE: u1 = 0,
/// unused [11:31]
_unused11: u5 = 0,
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// interrupt enable register
pub const IER = Register(IER_val).init(base_address + 0x4);

/// CR
const CR_val = packed struct {
/// ADEN [0:0]
/// ADEN
ADEN: u1 = 0,
/// ADDIS [1:1]
/// ADDIS
ADDIS: u1 = 0,
/// ADSTART [2:2]
/// ADSTART
ADSTART: u1 = 0,
/// JADSTART [3:3]
/// JADSTART
JADSTART: u1 = 0,
/// ADSTP [4:4]
/// ADSTP
ADSTP: u1 = 0,
/// JADSTP [5:5]
/// JADSTP
JADSTP: u1 = 0,
/// unused [6:27]
_unused6: u2 = 0,
_unused8: u8 = 0,
_unused16: u8 = 0,
_unused24: u4 = 0,
/// ADVREGEN [28:28]
/// ADVREGEN
ADVREGEN: u1 = 0,
/// DEEPPWD [29:29]
/// DEEPPWD
DEEPPWD: u1 = 0,
/// ADCALDIF [30:30]
/// ADCALDIF
ADCALDIF: u1 = 0,
/// ADCAL [31:31]
/// ADCAL
ADCAL: u1 = 0,
};
/// control register
pub const CR = Register(CR_val).init(base_address + 0x8);

/// CFGR
const CFGR_val = packed struct {
/// DMAEN [0:0]
/// DMAEN
DMAEN: u1 = 0,
/// DMACFG [1:1]
/// DMACFG
DMACFG: u1 = 0,
/// unused [2:2]
_unused2: u1 = 0,
/// RES [3:4]
/// RES
RES: u2 = 0,
/// ALIGN [5:5]
/// ALIGN
ALIGN: u1 = 0,
/// EXTSEL [6:9]
/// EXTSEL
EXTSEL: u4 = 0,
/// EXTEN [10:11]
/// EXTEN
EXTEN: u2 = 0,
/// OVRMOD [12:12]
/// OVRMOD
OVRMOD: u1 = 0,
/// CONT [13:13]
/// CONT
CONT: u1 = 0,
/// AUTDLY [14:14]
/// AUTDLY
AUTDLY: u1 = 0,
/// AUTOFF [15:15]
/// AUTOFF
AUTOFF: u1 = 0,
/// DISCEN [16:16]
/// DISCEN
DISCEN: u1 = 0,
/// DISCNUM [17:19]
/// DISCNUM
DISCNUM: u3 = 0,
/// JDISCEN [20:20]
/// JDISCEN
JDISCEN: u1 = 0,
/// JQM [21:21]
/// JQM
JQM: u1 = 0,
/// AWD1SGL [22:22]
/// AWD1SGL
AWD1SGL: u1 = 0,
/// AWD1EN [23:23]
/// AWD1EN
AWD1EN: u1 = 0,
/// JAWD1EN [24:24]
/// JAWD1EN
JAWD1EN: u1 = 0,
/// JAUTO [25:25]
/// JAUTO
JAUTO: u1 = 0,
/// AWDCH1CH [26:30]
/// AWDCH1CH
AWDCH1CH: u5 = 0,
/// unused [31:31]
_unused31: u1 = 0,
};
/// configuration register
pub const CFGR = Register(CFGR_val).init(base_address + 0xc);

/// SMPR1
const SMPR1_val = packed struct {
/// unused [0:2]
_unused0: u3 = 0,
/// SMP1 [3:5]
/// SMP1
SMP1: u3 = 0,
/// SMP2 [6:8]
/// SMP2
SMP2: u3 = 0,
/// SMP3 [9:11]
/// SMP3
SMP3: u3 = 0,
/// SMP4 [12:14]
/// SMP4
SMP4: u3 = 0,
/// SMP5 [15:17]
/// SMP5
SMP5: u3 = 0,
/// SMP6 [18:20]
/// SMP6
SMP6: u3 = 0,
/// SMP7 [21:23]
/// SMP7
SMP7: u3 = 0,
/// SMP8 [24:26]
/// SMP8
SMP8: u3 = 0,
/// SMP9 [27:29]
/// SMP9
SMP9: u3 = 0,
/// unused [30:31]
_unused30: u2 = 0,
};
/// sample time register 1
pub const SMPR1 = Register(SMPR1_val).init(base_address + 0x14);

/// SMPR2
const SMPR2_val = packed struct {
/// SMP10 [0:2]
/// SMP10
SMP10: u3 = 0,
/// SMP11 [3:5]
/// SMP11
SMP11: u3 = 0,
/// SMP12 [6:8]
/// SMP12
SMP12: u3 = 0,
/// SMP13 [9:11]
/// SMP13
SMP13: u3 = 0,
/// SMP14 [12:14]
/// SMP14
SMP14: u3 = 0,
/// SMP15 [15:17]
/// SMP15
SMP15: u3 = 0,
/// SMP16 [18:20]
/// SMP16
SMP16: u3 = 0,
/// SMP17 [21:23]
/// SMP17
SMP17: u3 = 0,
/// SMP18 [24:26]
/// SMP18
SMP18: u3 = 0,
/// unused [27:31]
_unused27: u5 = 0,
};
/// sample time register 2
pub const SMPR2 = Register(SMPR2_val).init(base_address + 0x18);

/// TR1
const TR1_val = packed struct {
/// LT1 [0:11]
/// LT1
LT1: u12 = 0,
/// unused [12:15]
_unused12: u4 = 0,
/// HT1 [16:27]
/// HT1
HT1: u12 = 4095,
/// unused [28:31]
_unused28: u4 = 0,
};
/// watchdog threshold register 1
pub const TR1 = Register(TR1_val).init(base_address + 0x20);

/// TR2
const TR2_val = packed struct {
/// LT2 [0:7]
/// LT2
LT2: u8 = 0,
/// unused [8:15]
_unused8: u8 = 0,
/// HT2 [16:23]
/// HT2
HT2: u8 = 255,
/// unused [24:31]
_unused24: u8 = 15,
};
/// watchdog threshold register
pub const TR2 = Register(TR2_val).init(base_address + 0x24);

/// TR3
const TR3_val = packed struct {
/// LT3 [0:7]
/// LT3
LT3: u8 = 0,
/// unused [8:15]
_unused8: u8 = 0,
/// HT3 [16:23]
/// HT3
HT3: u8 = 255,
/// unused [24:31]
_unused24: u8 = 15,
};
/// watchdog threshold register 3
pub const TR3 = Register(TR3_val).init(base_address + 0x28);

/// SQR1
const SQR1_val = packed struct {
/// L3 [0:3]
/// L3
L3: u4 = 0,
/// unused [4:5]
_unused4: u2 = 0,
/// SQ1 [6:10]
/// SQ1
SQ1: u5 = 0,
/// unused [11:11]
_unused11: u1 = 0,
/// SQ2 [12:16]
/// SQ2
SQ2: u5 = 0,
/// unused [17:17]
_unused17: u1 = 0,
/// SQ3 [18:22]
/// SQ3
SQ3: u5 = 0,
/// unused [23:23]
_unused23: u1 = 0,
/// SQ4 [24:28]
/// SQ4
SQ4: u5 = 0,
/// unused [29:31]
_unused29: u3 = 0,
};
/// regular sequence register 1
pub const SQR1 = Register(SQR1_val).init(base_address + 0x30);

/// SQR2
const SQR2_val = packed struct {
/// SQ5 [0:4]
/// SQ5
SQ5: u5 = 0,
/// unused [5:5]
_unused5: u1 = 0,
/// SQ6 [6:10]
/// SQ6
SQ6: u5 = 0,
/// unused [11:11]
_unused11: u1 = 0,
/// SQ7 [12:16]
/// SQ7
SQ7: u5 = 0,
/// unused [17:17]
_unused17: u1 = 0,
/// SQ8 [18:22]
/// SQ8
SQ8: u5 = 0,
/// unused [23:23]
_unused23: u1 = 0,
/// SQ9 [24:28]
/// SQ9
SQ9: u5 = 0,
/// unused [29:31]
_unused29: u3 = 0,
};
/// regular sequence register 2
pub const SQR2 = Register(SQR2_val).init(base_address + 0x34);

/// SQR3
const SQR3_val = packed struct {
/// SQ10 [0:4]
/// SQ10
SQ10: u5 = 0,
/// unused [5:5]
_unused5: u1 = 0,
/// SQ11 [6:10]
/// SQ11
SQ11: u5 = 0,
/// unused [11:11]
_unused11: u1 = 0,
/// SQ12 [12:16]
/// SQ12
SQ12: u5 = 0,
/// unused [17:17]
_unused17: u1 = 0,
/// SQ13 [18:22]
/// SQ13
SQ13: u5 = 0,
/// unused [23:23]
_unused23: u1 = 0,
/// SQ14 [24:28]
/// SQ14
SQ14: u5 = 0,
/// unused [29:31]
_unused29: u3 = 0,
};
/// regular sequence register 3
pub const SQR3 = Register(SQR3_val).init(base_address + 0x38);

/// SQR4
const SQR4_val = packed struct {
/// SQ15 [0:4]
/// SQ15
SQ15: u5 = 0,
/// unused [5:5]
_unused5: u1 = 0,
/// SQ16 [6:10]
/// SQ16
SQ16: u5 = 0,
/// unused [11:31]
_unused11: u5 = 0,
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// regular sequence register 4
pub const SQR4 = Register(SQR4_val).init(base_address + 0x3c);

/// DR
const DR_val = packed struct {
/// regularDATA [0:15]
/// regularDATA
regularDATA: u16 = 0,
/// unused [16:31]
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// regular Data Register
pub const DR = Register(DR_val).init(base_address + 0x40);

/// JSQR
const JSQR_val = packed struct {
/// JL [0:1]
/// JL
JL: u2 = 0,
/// JEXTSEL [2:5]
/// JEXTSEL
JEXTSEL: u4 = 0,
/// JEXTEN [6:7]
/// JEXTEN
JEXTEN: u2 = 0,
/// JSQ1 [8:12]
/// JSQ1
JSQ1: u5 = 0,
/// unused [13:13]
_unused13: u1 = 0,
/// JSQ2 [14:18]
/// JSQ2
JSQ2: u5 = 0,
/// unused [19:19]
_unused19: u1 = 0,
/// JSQ3 [20:24]
/// JSQ3
JSQ3: u5 = 0,
/// unused [25:25]
_unused25: u1 = 0,
/// JSQ4 [26:30]
/// JSQ4
JSQ4: u5 = 0,
/// unused [31:31]
_unused31: u1 = 0,
};
/// injected sequence register
pub const JSQR = Register(JSQR_val).init(base_address + 0x4c);

/// OFR1
const OFR1_val = packed struct {
/// OFFSET1 [0:11]
/// OFFSET1
OFFSET1: u12 = 0,
/// unused [12:25]
_unused12: u4 = 0,
_unused16: u8 = 0,
_unused24: u2 = 0,
/// OFFSET1_CH [26:30]
/// OFFSET1_CH
OFFSET1_CH: u5 = 0,
/// OFFSET1_EN [31:31]
/// OFFSET1_EN
OFFSET1_EN: u1 = 0,
};
/// offset register 1
pub const OFR1 = Register(OFR1_val).init(base_address + 0x60);

/// OFR2
const OFR2_val = packed struct {
/// OFFSET2 [0:11]
/// OFFSET2
OFFSET2: u12 = 0,
/// unused [12:25]
_unused12: u4 = 0,
_unused16: u8 = 0,
_unused24: u2 = 0,
/// OFFSET2_CH [26:30]
/// OFFSET2_CH
OFFSET2_CH: u5 = 0,
/// OFFSET2_EN [31:31]
/// OFFSET2_EN
OFFSET2_EN: u1 = 0,
};
/// offset register 2
pub const OFR2 = Register(OFR2_val).init(base_address + 0x64);

/// OFR3
const OFR3_val = packed struct {
/// OFFSET3 [0:11]
/// OFFSET3
OFFSET3: u12 = 0,
/// unused [12:25]
_unused12: u4 = 0,
_unused16: u8 = 0,
_unused24: u2 = 0,
/// OFFSET3_CH [26:30]
/// OFFSET3_CH
OFFSET3_CH: u5 = 0,
/// OFFSET3_EN [31:31]
/// OFFSET3_EN
OFFSET3_EN: u1 = 0,
};
/// offset register 3
pub const OFR3 = Register(OFR3_val).init(base_address + 0x68);

/// OFR4
const OFR4_val = packed struct {
/// OFFSET4 [0:11]
/// OFFSET4
OFFSET4: u12 = 0,
/// unused [12:25]
_unused12: u4 = 0,
_unused16: u8 = 0,
_unused24: u2 = 0,
/// OFFSET4_CH [26:30]
/// OFFSET4_CH
OFFSET4_CH: u5 = 0,
/// OFFSET4_EN [31:31]
/// OFFSET4_EN
OFFSET4_EN: u1 = 0,
};
/// offset register 4
pub const OFR4 = Register(OFR4_val).init(base_address + 0x6c);

/// JDR1
const JDR1_val = packed struct {
/// JDATA1 [0:15]
/// JDATA1
JDATA1: u16 = 0,
/// unused [16:31]
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// injected data register 1
pub const JDR1 = Register(JDR1_val).init(base_address + 0x80);

/// JDR2
const JDR2_val = packed struct {
/// JDATA2 [0:15]
/// JDATA2
JDATA2: u16 = 0,
/// unused [16:31]
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// injected data register 2
pub const JDR2 = Register(JDR2_val).init(base_address + 0x84);

/// JDR3
const JDR3_val = packed struct {
/// JDATA3 [0:15]
/// JDATA3
JDATA3: u16 = 0,
/// unused [16:31]
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// injected data register 3
pub const JDR3 = Register(JDR3_val).init(base_address + 0x88);

/// JDR4
const JDR4_val = packed struct {
/// JDATA4 [0:15]
/// JDATA4
JDATA4: u16 = 0,
/// unused [16:31]
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// injected data register 4
pub const JDR4 = Register(JDR4_val).init(base_address + 0x8c);

/// AWD2CR
const AWD2CR_val = packed struct {
/// unused [0:0]
_unused0: u1 = 0,
/// AWD2CH [1:18]
/// AWD2CH
AWD2CH: u18 = 0,
/// unused [19:31]
_unused19: u5 = 0,
_unused24: u8 = 0,
};
/// Analog Watchdog 2 Configuration
pub const AWD2CR = Register(AWD2CR_val).init(base_address + 0xa0);

/// AWD3CR
const AWD3CR_val = packed struct {
/// unused [0:0]
_unused0: u1 = 0,
/// AWD3CH [1:18]
/// AWD3CH
AWD3CH: u18 = 0,
/// unused [19:31]
_unused19: u5 = 0,
_unused24: u8 = 0,
};
/// Analog Watchdog 3 Configuration
pub const AWD3CR = Register(AWD3CR_val).init(base_address + 0xa4);

/// DIFSEL
const DIFSEL_val = packed struct {
/// unused [0:0]
_unused0: u1 = 0,
/// DIFSEL_1_15 [1:15]
/// Differential mode for channels 15 to
DIFSEL_1_15: u15 = 0,
/// DIFSEL_16_18 [16:18]
/// Differential mode for channels 18 to
DIFSEL_16_18: u3 = 0,
/// unused [19:31]
_unused19: u5 = 0,
_unused24: u8 = 0,
};
/// Differential Mode Selection Register
pub const DIFSEL = Register(DIFSEL_val).init(base_address + 0xb0);

/// CALFACT
const CALFACT_val = packed struct {
/// CALFACT_S [0:6]
/// CALFACT_S
CALFACT_S: u7 = 0,
/// unused [7:15]
_unused7: u1 = 0,
_unused8: u8 = 0,
/// CALFACT_D [16:22]
/// CALFACT_D
CALFACT_D: u7 = 0,
/// unused [23:31]
_unused23: u1 = 0,
_unused24: u8 = 0,
};
/// Calibration Factors
pub const CALFACT = Register(CALFACT_val).init(base_address + 0xb4);
};

/// Analog-to-Digital Converter
pub const ADC2 = struct {

const base_address = 0x50000100;
/// ISR
const ISR_val = packed struct {
/// ADRDY [0:0]
/// ADRDY
ADRDY: u1 = 0,
/// EOSMP [1:1]
/// EOSMP
EOSMP: u1 = 0,
/// EOC [2:2]
/// EOC
EOC: u1 = 0,
/// EOS [3:3]
/// EOS
EOS: u1 = 0,
/// OVR [4:4]
/// OVR
OVR: u1 = 0,
/// JEOC [5:5]
/// JEOC
JEOC: u1 = 0,
/// JEOS [6:6]
/// JEOS
JEOS: u1 = 0,
/// AWD1 [7:7]
/// AWD1
AWD1: u1 = 0,
/// AWD2 [8:8]
/// AWD2
AWD2: u1 = 0,
/// AWD3 [9:9]
/// AWD3
AWD3: u1 = 0,
/// JQOVF [10:10]
/// JQOVF
JQOVF: u1 = 0,
/// unused [11:31]
_unused11: u5 = 0,
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// interrupt and status register
pub const ISR = Register(ISR_val).init(base_address + 0x0);

/// IER
const IER_val = packed struct {
/// ADRDYIE [0:0]
/// ADRDYIE
ADRDYIE: u1 = 0,
/// EOSMPIE [1:1]
/// EOSMPIE
EOSMPIE: u1 = 0,
/// EOCIE [2:2]
/// EOCIE
EOCIE: u1 = 0,
/// EOSIE [3:3]
/// EOSIE
EOSIE: u1 = 0,
/// OVRIE [4:4]
/// OVRIE
OVRIE: u1 = 0,
/// JEOCIE [5:5]
/// JEOCIE
JEOCIE: u1 = 0,
/// JEOSIE [6:6]
/// JEOSIE
JEOSIE: u1 = 0,
/// AWD1IE [7:7]
/// AWD1IE
AWD1IE: u1 = 0,
/// AWD2IE [8:8]
/// AWD2IE
AWD2IE: u1 = 0,
/// AWD3IE [9:9]
/// AWD3IE
AWD3IE: u1 = 0,
/// JQOVFIE [10:10]
/// JQOVFIE
JQOVFIE: u1 = 0,
/// unused [11:31]
_unused11: u5 = 0,
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// interrupt enable register
pub const IER = Register(IER_val).init(base_address + 0x4);

/// CR
const CR_val = packed struct {
/// ADEN [0:0]
/// ADEN
ADEN: u1 = 0,
/// ADDIS [1:1]
/// ADDIS
ADDIS: u1 = 0,
/// ADSTART [2:2]
/// ADSTART
ADSTART: u1 = 0,
/// JADSTART [3:3]
/// JADSTART
JADSTART: u1 = 0,
/// ADSTP [4:4]
/// ADSTP
ADSTP: u1 = 0,
/// JADSTP [5:5]
/// JADSTP
JADSTP: u1 = 0,
/// unused [6:27]
_unused6: u2 = 0,
_unused8: u8 = 0,
_unused16: u8 = 0,
_unused24: u4 = 0,
/// ADVREGEN [28:28]
/// ADVREGEN
ADVREGEN: u1 = 0,
/// DEEPPWD [29:29]
/// DEEPPWD
DEEPPWD: u1 = 0,
/// ADCALDIF [30:30]
/// ADCALDIF
ADCALDIF: u1 = 0,
/// ADCAL [31:31]
/// ADCAL
ADCAL: u1 = 0,
};
/// control register
pub const CR = Register(CR_val).init(base_address + 0x8);

/// CFGR
const CFGR_val = packed struct {
/// DMAEN [0:0]
/// DMAEN
DMAEN: u1 = 0,
/// DMACFG [1:1]
/// DMACFG
DMACFG: u1 = 0,
/// unused [2:2]
_unused2: u1 = 0,
/// RES [3:4]
/// RES
RES: u2 = 0,
/// ALIGN [5:5]
/// ALIGN
ALIGN: u1 = 0,
/// EXTSEL [6:9]
/// EXTSEL
EXTSEL: u4 = 0,
/// EXTEN [10:11]
/// EXTEN
EXTEN: u2 = 0,
/// OVRMOD [12:12]
/// OVRMOD
OVRMOD: u1 = 0,
/// CONT [13:13]
/// CONT
CONT: u1 = 0,
/// AUTDLY [14:14]
/// AUTDLY
AUTDLY: u1 = 0,
/// AUTOFF [15:15]
/// AUTOFF
AUTOFF: u1 = 0,
/// DISCEN [16:16]
/// DISCEN
DISCEN: u1 = 0,
/// DISCNUM [17:19]
/// DISCNUM
DISCNUM: u3 = 0,
/// JDISCEN [20:20]
/// JDISCEN
JDISCEN: u1 = 0,
/// JQM [21:21]
/// JQM
JQM: u1 = 0,
/// AWD1SGL [22:22]
/// AWD1SGL
AWD1SGL: u1 = 0,
/// AWD1EN [23:23]
/// AWD1EN
AWD1EN: u1 = 0,
/// JAWD1EN [24:24]
/// JAWD1EN
JAWD1EN: u1 = 0,
/// JAUTO [25:25]
/// JAUTO
JAUTO: u1 = 0,
/// AWDCH1CH [26:30]
/// AWDCH1CH
AWDCH1CH: u5 = 0,
/// unused [31:31]
_unused31: u1 = 0,
};
/// configuration register
pub const CFGR = Register(CFGR_val).init(base_address + 0xc);

/// SMPR1
const SMPR1_val = packed struct {
/// unused [0:2]
_unused0: u3 = 0,
/// SMP1 [3:5]
/// SMP1
SMP1: u3 = 0,
/// SMP2 [6:8]
/// SMP2
SMP2: u3 = 0,
/// SMP3 [9:11]
/// SMP3
SMP3: u3 = 0,
/// SMP4 [12:14]
/// SMP4
SMP4: u3 = 0,
/// SMP5 [15:17]
/// SMP5
SMP5: u3 = 0,
/// SMP6 [18:20]
/// SMP6
SMP6: u3 = 0,
/// SMP7 [21:23]
/// SMP7
SMP7: u3 = 0,
/// SMP8 [24:26]
/// SMP8
SMP8: u3 = 0,
/// SMP9 [27:29]
/// SMP9
SMP9: u3 = 0,
/// unused [30:31]
_unused30: u2 = 0,
};
/// sample time register 1
pub const SMPR1 = Register(SMPR1_val).init(base_address + 0x14);

/// SMPR2
const SMPR2_val = packed struct {
/// SMP10 [0:2]
/// SMP10
SMP10: u3 = 0,
/// SMP11 [3:5]
/// SMP11
SMP11: u3 = 0,
/// SMP12 [6:8]
/// SMP12
SMP12: u3 = 0,
/// SMP13 [9:11]
/// SMP13
SMP13: u3 = 0,
/// SMP14 [12:14]
/// SMP14
SMP14: u3 = 0,
/// SMP15 [15:17]
/// SMP15
SMP15: u3 = 0,
/// SMP16 [18:20]
/// SMP16
SMP16: u3 = 0,
/// SMP17 [21:23]
/// SMP17
SMP17: u3 = 0,
/// SMP18 [24:26]
/// SMP18
SMP18: u3 = 0,
/// unused [27:31]
_unused27: u5 = 0,
};
/// sample time register 2
pub const SMPR2 = Register(SMPR2_val).init(base_address + 0x18);

/// TR1
const TR1_val = packed struct {
/// LT1 [0:11]
/// LT1
LT1: u12 = 0,
/// unused [12:15]
_unused12: u4 = 0,
/// HT1 [16:27]
/// HT1
HT1: u12 = 4095,
/// unused [28:31]
_unused28: u4 = 0,
};
/// watchdog threshold register 1
pub const TR1 = Register(TR1_val).init(base_address + 0x20);

/// TR2
const TR2_val = packed struct {
/// LT2 [0:7]
/// LT2
LT2: u8 = 0,
/// unused [8:15]
_unused8: u8 = 0,
/// HT2 [16:23]
/// HT2
HT2: u8 = 255,
/// unused [24:31]
_unused24: u8 = 15,
};
/// watchdog threshold register
pub const TR2 = Register(TR2_val).init(base_address + 0x24);

/// TR3
const TR3_val = packed struct {
/// LT3 [0:7]
/// LT3
LT3: u8 = 0,
/// unused [8:15]
_unused8: u8 = 0,
/// HT3 [16:23]
/// HT3
HT3: u8 = 255,
/// unused [24:31]
_unused24: u8 = 15,
};
/// watchdog threshold register 3
pub const TR3 = Register(TR3_val).init(base_address + 0x28);

/// SQR1
const SQR1_val = packed struct {
/// L3 [0:3]
/// L3
L3: u4 = 0,
/// unused [4:5]
_unused4: u2 = 0,
/// SQ1 [6:10]
/// SQ1
SQ1: u5 = 0,
/// unused [11:11]
_unused11: u1 = 0,
/// SQ2 [12:16]
/// SQ2
SQ2: u5 = 0,
/// unused [17:17]
_unused17: u1 = 0,
/// SQ3 [18:22]
/// SQ3
SQ3: u5 = 0,
/// unused [23:23]
_unused23: u1 = 0,
/// SQ4 [24:28]
/// SQ4
SQ4: u5 = 0,
/// unused [29:31]
_unused29: u3 = 0,
};
/// regular sequence register 1
pub const SQR1 = Register(SQR1_val).init(base_address + 0x30);

/// SQR2
const SQR2_val = packed struct {
/// SQ5 [0:4]
/// SQ5
SQ5: u5 = 0,
/// unused [5:5]
_unused5: u1 = 0,
/// SQ6 [6:10]
/// SQ6
SQ6: u5 = 0,
/// unused [11:11]
_unused11: u1 = 0,
/// SQ7 [12:16]
/// SQ7
SQ7: u5 = 0,
/// unused [17:17]
_unused17: u1 = 0,
/// SQ8 [18:22]
/// SQ8
SQ8: u5 = 0,
/// unused [23:23]
_unused23: u1 = 0,
/// SQ9 [24:28]
/// SQ9
SQ9: u5 = 0,
/// unused [29:31]
_unused29: u3 = 0,
};
/// regular sequence register 2
pub const SQR2 = Register(SQR2_val).init(base_address + 0x34);

/// SQR3
const SQR3_val = packed struct {
/// SQ10 [0:4]
/// SQ10
SQ10: u5 = 0,
/// unused [5:5]
_unused5: u1 = 0,
/// SQ11 [6:10]
/// SQ11
SQ11: u5 = 0,
/// unused [11:11]
_unused11: u1 = 0,
/// SQ12 [12:16]
/// SQ12
SQ12: u5 = 0,
/// unused [17:17]
_unused17: u1 = 0,
/// SQ13 [18:22]
/// SQ13
SQ13: u5 = 0,
/// unused [23:23]
_unused23: u1 = 0,
/// SQ14 [24:28]
/// SQ14
SQ14: u5 = 0,
/// unused [29:31]
_unused29: u3 = 0,
};
/// regular sequence register 3
pub const SQR3 = Register(SQR3_val).init(base_address + 0x38);

/// SQR4
const SQR4_val = packed struct {
/// SQ15 [0:4]
/// SQ15
SQ15: u5 = 0,
/// unused [5:5]
_unused5: u1 = 0,
/// SQ16 [6:10]
/// SQ16
SQ16: u5 = 0,
/// unused [11:31]
_unused11: u5 = 0,
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// regular sequence register 4
pub const SQR4 = Register(SQR4_val).init(base_address + 0x3c);

/// DR
const DR_val = packed struct {
/// regularDATA [0:15]
/// regularDATA
regularDATA: u16 = 0,
/// unused [16:31]
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// regular Data Register
pub const DR = Register(DR_val).init(base_address + 0x40);

/// JSQR
const JSQR_val = packed struct {
/// JL [0:1]
/// JL
JL: u2 = 0,
/// JEXTSEL [2:5]
/// JEXTSEL
JEXTSEL: u4 = 0,
/// JEXTEN [6:7]
/// JEXTEN
JEXTEN: u2 = 0,
/// JSQ1 [8:12]
/// JSQ1
JSQ1: u5 = 0,
/// unused [13:13]
_unused13: u1 = 0,
/// JSQ2 [14:18]
/// JSQ2
JSQ2: u5 = 0,
/// unused [19:19]
_unused19: u1 = 0,
/// JSQ3 [20:24]
/// JSQ3
JSQ3: u5 = 0,
/// unused [25:25]
_unused25: u1 = 0,
/// JSQ4 [26:30]
/// JSQ4
JSQ4: u5 = 0,
/// unused [31:31]
_unused31: u1 = 0,
};
/// injected sequence register
pub const JSQR = Register(JSQR_val).init(base_address + 0x4c);

/// OFR1
const OFR1_val = packed struct {
/// OFFSET1 [0:11]
/// OFFSET1
OFFSET1: u12 = 0,
/// unused [12:25]
_unused12: u4 = 0,
_unused16: u8 = 0,
_unused24: u2 = 0,
/// OFFSET1_CH [26:30]
/// OFFSET1_CH
OFFSET1_CH: u5 = 0,
/// OFFSET1_EN [31:31]
/// OFFSET1_EN
OFFSET1_EN: u1 = 0,
};
/// offset register 1
pub const OFR1 = Register(OFR1_val).init(base_address + 0x60);

/// OFR2
const OFR2_val = packed struct {
/// OFFSET2 [0:11]
/// OFFSET2
OFFSET2: u12 = 0,
/// unused [12:25]
_unused12: u4 = 0,
_unused16: u8 = 0,
_unused24: u2 = 0,
/// OFFSET2_CH [26:30]
/// OFFSET2_CH
OFFSET2_CH: u5 = 0,
/// OFFSET2_EN [31:31]
/// OFFSET2_EN
OFFSET2_EN: u1 = 0,
};
/// offset register 2
pub const OFR2 = Register(OFR2_val).init(base_address + 0x64);

/// OFR3
const OFR3_val = packed struct {
/// OFFSET3 [0:11]
/// OFFSET3
OFFSET3: u12 = 0,
/// unused [12:25]
_unused12: u4 = 0,
_unused16: u8 = 0,
_unused24: u2 = 0,
/// OFFSET3_CH [26:30]
/// OFFSET3_CH
OFFSET3_CH: u5 = 0,
/// OFFSET3_EN [31:31]
/// OFFSET3_EN
OFFSET3_EN: u1 = 0,
};
/// offset register 3
pub const OFR3 = Register(OFR3_val).init(base_address + 0x68);

/// OFR4
const OFR4_val = packed struct {
/// OFFSET4 [0:11]
/// OFFSET4
OFFSET4: u12 = 0,
/// unused [12:25]
_unused12: u4 = 0,
_unused16: u8 = 0,
_unused24: u2 = 0,
/// OFFSET4_CH [26:30]
/// OFFSET4_CH
OFFSET4_CH: u5 = 0,
/// OFFSET4_EN [31:31]
/// OFFSET4_EN
OFFSET4_EN: u1 = 0,
};
/// offset register 4
pub const OFR4 = Register(OFR4_val).init(base_address + 0x6c);

/// JDR1
const JDR1_val = packed struct {
/// JDATA1 [0:15]
/// JDATA1
JDATA1: u16 = 0,
/// unused [16:31]
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// injected data register 1
pub const JDR1 = Register(JDR1_val).init(base_address + 0x80);

/// JDR2
const JDR2_val = packed struct {
/// JDATA2 [0:15]
/// JDATA2
JDATA2: u16 = 0,
/// unused [16:31]
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// injected data register 2
pub const JDR2 = Register(JDR2_val).init(base_address + 0x84);

/// JDR3
const JDR3_val = packed struct {
/// JDATA3 [0:15]
/// JDATA3
JDATA3: u16 = 0,
/// unused [16:31]
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// injected data register 3
pub const JDR3 = Register(JDR3_val).init(base_address + 0x88);

/// JDR4
const JDR4_val = packed struct {
/// JDATA4 [0:15]
/// JDATA4
JDATA4: u16 = 0,
/// unused [16:31]
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// injected data register 4
pub const JDR4 = Register(JDR4_val).init(base_address + 0x8c);

/// AWD2CR
const AWD2CR_val = packed struct {
/// unused [0:0]
_unused0: u1 = 0,
/// AWD2CH [1:18]
/// AWD2CH
AWD2CH: u18 = 0,
/// unused [19:31]
_unused19: u5 = 0,
_unused24: u8 = 0,
};
/// Analog Watchdog 2 Configuration
pub const AWD2CR = Register(AWD2CR_val).init(base_address + 0xa0);

/// AWD3CR
const AWD3CR_val = packed struct {
/// unused [0:0]
_unused0: u1 = 0,
/// AWD3CH [1:18]
/// AWD3CH
AWD3CH: u18 = 0,
/// unused [19:31]
_unused19: u5 = 0,
_unused24: u8 = 0,
};
/// Analog Watchdog 3 Configuration
pub const AWD3CR = Register(AWD3CR_val).init(base_address + 0xa4);

/// DIFSEL
const DIFSEL_val = packed struct {
/// unused [0:0]
_unused0: u1 = 0,
/// DIFSEL_1_15 [1:15]
/// Differential mode for channels 15 to
DIFSEL_1_15: u15 = 0,
/// DIFSEL_16_18 [16:18]
/// Differential mode for channels 18 to
DIFSEL_16_18: u3 = 0,
/// unused [19:31]
_unused19: u5 = 0,
_unused24: u8 = 0,
};
/// Differential Mode Selection Register
pub const DIFSEL = Register(DIFSEL_val).init(base_address + 0xb0);

/// CALFACT
const CALFACT_val = packed struct {
/// CALFACT_S [0:6]
/// CALFACT_S
CALFACT_S: u7 = 0,
/// unused [7:15]
_unused7: u1 = 0,
_unused8: u8 = 0,
/// CALFACT_D [16:22]
/// CALFACT_D
CALFACT_D: u7 = 0,
/// unused [23:31]
_unused23: u1 = 0,
_unused24: u8 = 0,
};
/// Calibration Factors
pub const CALFACT = Register(CALFACT_val).init(base_address + 0xb4);
};

/// Analog-to-Digital Converter
pub const ADC3 = struct {

const base_address = 0x50000400;
/// ISR
const ISR_val = packed struct {
/// ADRDY [0:0]
/// ADRDY
ADRDY: u1 = 0,
/// EOSMP [1:1]
/// EOSMP
EOSMP: u1 = 0,
/// EOC [2:2]
/// EOC
EOC: u1 = 0,
/// EOS [3:3]
/// EOS
EOS: u1 = 0,
/// OVR [4:4]
/// OVR
OVR: u1 = 0,
/// JEOC [5:5]
/// JEOC
JEOC: u1 = 0,
/// JEOS [6:6]
/// JEOS
JEOS: u1 = 0,
/// AWD1 [7:7]
/// AWD1
AWD1: u1 = 0,
/// AWD2 [8:8]
/// AWD2
AWD2: u1 = 0,
/// AWD3 [9:9]
/// AWD3
AWD3: u1 = 0,
/// JQOVF [10:10]
/// JQOVF
JQOVF: u1 = 0,
/// unused [11:31]
_unused11: u5 = 0,
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// interrupt and status register
pub const ISR = Register(ISR_val).init(base_address + 0x0);

/// IER
const IER_val = packed struct {
/// ADRDYIE [0:0]
/// ADRDYIE
ADRDYIE: u1 = 0,
/// EOSMPIE [1:1]
/// EOSMPIE
EOSMPIE: u1 = 0,
/// EOCIE [2:2]
/// EOCIE
EOCIE: u1 = 0,
/// EOSIE [3:3]
/// EOSIE
EOSIE: u1 = 0,
/// OVRIE [4:4]
/// OVRIE
OVRIE: u1 = 0,
/// JEOCIE [5:5]
/// JEOCIE
JEOCIE: u1 = 0,
/// JEOSIE [6:6]
/// JEOSIE
JEOSIE: u1 = 0,
/// AWD1IE [7:7]
/// AWD1IE
AWD1IE: u1 = 0,
/// AWD2IE [8:8]
/// AWD2IE
AWD2IE: u1 = 0,
/// AWD3IE [9:9]
/// AWD3IE
AWD3IE: u1 = 0,
/// JQOVFIE [10:10]
/// JQOVFIE
JQOVFIE: u1 = 0,
/// unused [11:31]
_unused11: u5 = 0,
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// interrupt enable register
pub const IER = Register(IER_val).init(base_address + 0x4);

/// CR
const CR_val = packed struct {
/// ADEN [0:0]
/// ADEN
ADEN: u1 = 0,
/// ADDIS [1:1]
/// ADDIS
ADDIS: u1 = 0,
/// ADSTART [2:2]
/// ADSTART
ADSTART: u1 = 0,
/// JADSTART [3:3]
/// JADSTART
JADSTART: u1 = 0,
/// ADSTP [4:4]
/// ADSTP
ADSTP: u1 = 0,
/// JADSTP [5:5]
/// JADSTP
JADSTP: u1 = 0,
/// unused [6:27]
_unused6: u2 = 0,
_unused8: u8 = 0,
_unused16: u8 = 0,
_unused24: u4 = 0,
/// ADVREGEN [28:28]
/// ADVREGEN
ADVREGEN: u1 = 0,
/// DEEPPWD [29:29]
/// DEEPPWD
DEEPPWD: u1 = 0,
/// ADCALDIF [30:30]
/// ADCALDIF
ADCALDIF: u1 = 0,
/// ADCAL [31:31]
/// ADCAL
ADCAL: u1 = 0,
};
/// control register
pub const CR = Register(CR_val).init(base_address + 0x8);

/// CFGR
const CFGR_val = packed struct {
/// DMAEN [0:0]
/// DMAEN
DMAEN: u1 = 0,
/// DMACFG [1:1]
/// DMACFG
DMACFG: u1 = 0,
/// unused [2:2]
_unused2: u1 = 0,
/// RES [3:4]
/// RES
RES: u2 = 0,
/// ALIGN [5:5]
/// ALIGN
ALIGN: u1 = 0,
/// EXTSEL [6:9]
/// EXTSEL
EXTSEL: u4 = 0,
/// EXTEN [10:11]
/// EXTEN
EXTEN: u2 = 0,
/// OVRMOD [12:12]
/// OVRMOD
OVRMOD: u1 = 0,
/// CONT [13:13]
/// CONT
CONT: u1 = 0,
/// AUTDLY [14:14]
/// AUTDLY
AUTDLY: u1 = 0,
/// AUTOFF [15:15]
/// AUTOFF
AUTOFF: u1 = 0,
/// DISCEN [16:16]
/// DISCEN
DISCEN: u1 = 0,
/// DISCNUM [17:19]
/// DISCNUM
DISCNUM: u3 = 0,
/// JDISCEN [20:20]
/// JDISCEN
JDISCEN: u1 = 0,
/// JQM [21:21]
/// JQM
JQM: u1 = 0,
/// AWD1SGL [22:22]
/// AWD1SGL
AWD1SGL: u1 = 0,
/// AWD1EN [23:23]
/// AWD1EN
AWD1EN: u1 = 0,
/// JAWD1EN [24:24]
/// JAWD1EN
JAWD1EN: u1 = 0,
/// JAUTO [25:25]
/// JAUTO
JAUTO: u1 = 0,
/// AWDCH1CH [26:30]
/// AWDCH1CH
AWDCH1CH: u5 = 0,
/// unused [31:31]
_unused31: u1 = 0,
};
/// configuration register
pub const CFGR = Register(CFGR_val).init(base_address + 0xc);

/// SMPR1
const SMPR1_val = packed struct {
/// unused [0:2]
_unused0: u3 = 0,
/// SMP1 [3:5]
/// SMP1
SMP1: u3 = 0,
/// SMP2 [6:8]
/// SMP2
SMP2: u3 = 0,
/// SMP3 [9:11]
/// SMP3
SMP3: u3 = 0,
/// SMP4 [12:14]
/// SMP4
SMP4: u3 = 0,
/// SMP5 [15:17]
/// SMP5
SMP5: u3 = 0,
/// SMP6 [18:20]
/// SMP6
SMP6: u3 = 0,
/// SMP7 [21:23]
/// SMP7
SMP7: u3 = 0,
/// SMP8 [24:26]
/// SMP8
SMP8: u3 = 0,
/// SMP9 [27:29]
/// SMP9
SMP9: u3 = 0,
/// unused [30:31]
_unused30: u2 = 0,
};
/// sample time register 1
pub const SMPR1 = Register(SMPR1_val).init(base_address + 0x14);

/// SMPR2
const SMPR2_val = packed struct {
/// SMP10 [0:2]
/// SMP10
SMP10: u3 = 0,
/// SMP11 [3:5]
/// SMP11
SMP11: u3 = 0,
/// SMP12 [6:8]
/// SMP12
SMP12: u3 = 0,
/// SMP13 [9:11]
/// SMP13
SMP13: u3 = 0,
/// SMP14 [12:14]
/// SMP14
SMP14: u3 = 0,
/// SMP15 [15:17]
/// SMP15
SMP15: u3 = 0,
/// SMP16 [18:20]
/// SMP16
SMP16: u3 = 0,
/// SMP17 [21:23]
/// SMP17
SMP17: u3 = 0,
/// SMP18 [24:26]
/// SMP18
SMP18: u3 = 0,
/// unused [27:31]
_unused27: u5 = 0,
};
/// sample time register 2
pub const SMPR2 = Register(SMPR2_val).init(base_address + 0x18);

/// TR1
const TR1_val = packed struct {
/// LT1 [0:11]
/// LT1
LT1: u12 = 0,
/// unused [12:15]
_unused12: u4 = 0,
/// HT1 [16:27]
/// HT1
HT1: u12 = 4095,
/// unused [28:31]
_unused28: u4 = 0,
};
/// watchdog threshold register 1
pub const TR1 = Register(TR1_val).init(base_address + 0x20);

/// TR2
const TR2_val = packed struct {
/// LT2 [0:7]
/// LT2
LT2: u8 = 0,
/// unused [8:15]
_unused8: u8 = 0,
/// HT2 [16:23]
/// HT2
HT2: u8 = 255,
/// unused [24:31]
_unused24: u8 = 15,
};
/// watchdog threshold register
pub const TR2 = Register(TR2_val).init(base_address + 0x24);

/// TR3
const TR3_val = packed struct {
/// LT3 [0:7]
/// LT3
LT3: u8 = 0,
/// unused [8:15]
_unused8: u8 = 0,
/// HT3 [16:23]
/// HT3
HT3: u8 = 255,
/// unused [24:31]
_unused24: u8 = 15,
};
/// watchdog threshold register 3
pub const TR3 = Register(TR3_val).init(base_address + 0x28);

/// SQR1
const SQR1_val = packed struct {
/// L3 [0:3]
/// L3
L3: u4 = 0,
/// unused [4:5]
_unused4: u2 = 0,
/// SQ1 [6:10]
/// SQ1
SQ1: u5 = 0,
/// unused [11:11]
_unused11: u1 = 0,
/// SQ2 [12:16]
/// SQ2
SQ2: u5 = 0,
/// unused [17:17]
_unused17: u1 = 0,
/// SQ3 [18:22]
/// SQ3
SQ3: u5 = 0,
/// unused [23:23]
_unused23: u1 = 0,
/// SQ4 [24:28]
/// SQ4
SQ4: u5 = 0,
/// unused [29:31]
_unused29: u3 = 0,
};
/// regular sequence register 1
pub const SQR1 = Register(SQR1_val).init(base_address + 0x30);

/// SQR2
const SQR2_val = packed struct {
/// SQ5 [0:4]
/// SQ5
SQ5: u5 = 0,
/// unused [5:5]
_unused5: u1 = 0,
/// SQ6 [6:10]
/// SQ6
SQ6: u5 = 0,
/// unused [11:11]
_unused11: u1 = 0,
/// SQ7 [12:16]
/// SQ7
SQ7: u5 = 0,
/// unused [17:17]
_unused17: u1 = 0,
/// SQ8 [18:22]
/// SQ8
SQ8: u5 = 0,
/// unused [23:23]
_unused23: u1 = 0,
/// SQ9 [24:28]
/// SQ9
SQ9: u5 = 0,
/// unused [29:31]
_unused29: u3 = 0,
};
/// regular sequence register 2
pub const SQR2 = Register(SQR2_val).init(base_address + 0x34);

/// SQR3
const SQR3_val = packed struct {
/// SQ10 [0:4]
/// SQ10
SQ10: u5 = 0,
/// unused [5:5]
_unused5: u1 = 0,
/// SQ11 [6:10]
/// SQ11
SQ11: u5 = 0,
/// unused [11:11]
_unused11: u1 = 0,
/// SQ12 [12:16]
/// SQ12
SQ12: u5 = 0,
/// unused [17:17]
_unused17: u1 = 0,
/// SQ13 [18:22]
/// SQ13
SQ13: u5 = 0,
/// unused [23:23]
_unused23: u1 = 0,
/// SQ14 [24:28]
/// SQ14
SQ14: u5 = 0,
/// unused [29:31]
_unused29: u3 = 0,
};
/// regular sequence register 3
pub const SQR3 = Register(SQR3_val).init(base_address + 0x38);

/// SQR4
const SQR4_val = packed struct {
/// SQ15 [0:4]
/// SQ15
SQ15: u5 = 0,
/// unused [5:5]
_unused5: u1 = 0,
/// SQ16 [6:10]
/// SQ16
SQ16: u5 = 0,
/// unused [11:31]
_unused11: u5 = 0,
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// regular sequence register 4
pub const SQR4 = Register(SQR4_val).init(base_address + 0x3c);

/// DR
const DR_val = packed struct {
/// regularDATA [0:15]
/// regularDATA
regularDATA: u16 = 0,
/// unused [16:31]
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// regular Data Register
pub const DR = Register(DR_val).init(base_address + 0x40);

/// JSQR
const JSQR_val = packed struct {
/// JL [0:1]
/// JL
JL: u2 = 0,
/// JEXTSEL [2:5]
/// JEXTSEL
JEXTSEL: u4 = 0,
/// JEXTEN [6:7]
/// JEXTEN
JEXTEN: u2 = 0,
/// JSQ1 [8:12]
/// JSQ1
JSQ1: u5 = 0,
/// unused [13:13]
_unused13: u1 = 0,
/// JSQ2 [14:18]
/// JSQ2
JSQ2: u5 = 0,
/// unused [19:19]
_unused19: u1 = 0,
/// JSQ3 [20:24]
/// JSQ3
JSQ3: u5 = 0,
/// unused [25:25]
_unused25: u1 = 0,
/// JSQ4 [26:30]
/// JSQ4
JSQ4: u5 = 0,
/// unused [31:31]
_unused31: u1 = 0,
};
/// injected sequence register
pub const JSQR = Register(JSQR_val).init(base_address + 0x4c);

/// OFR1
const OFR1_val = packed struct {
/// OFFSET1 [0:11]
/// OFFSET1
OFFSET1: u12 = 0,
/// unused [12:25]
_unused12: u4 = 0,
_unused16: u8 = 0,
_unused24: u2 = 0,
/// OFFSET1_CH [26:30]
/// OFFSET1_CH
OFFSET1_CH: u5 = 0,
/// OFFSET1_EN [31:31]
/// OFFSET1_EN
OFFSET1_EN: u1 = 0,
};
/// offset register 1
pub const OFR1 = Register(OFR1_val).init(base_address + 0x60);

/// OFR2
const OFR2_val = packed struct {
/// OFFSET2 [0:11]
/// OFFSET2
OFFSET2: u12 = 0,
/// unused [12:25]
_unused12: u4 = 0,
_unused16: u8 = 0,
_unused24: u2 = 0,
/// OFFSET2_CH [26:30]
/// OFFSET2_CH
OFFSET2_CH: u5 = 0,
/// OFFSET2_EN [31:31]
/// OFFSET2_EN
OFFSET2_EN: u1 = 0,
};
/// offset register 2
pub const OFR2 = Register(OFR2_val).init(base_address + 0x64);

/// OFR3
const OFR3_val = packed struct {
/// OFFSET3 [0:11]
/// OFFSET3
OFFSET3: u12 = 0,
/// unused [12:25]
_unused12: u4 = 0,
_unused16: u8 = 0,
_unused24: u2 = 0,
/// OFFSET3_CH [26:30]
/// OFFSET3_CH
OFFSET3_CH: u5 = 0,
/// OFFSET3_EN [31:31]
/// OFFSET3_EN
OFFSET3_EN: u1 = 0,
};
/// offset register 3
pub const OFR3 = Register(OFR3_val).init(base_address + 0x68);

/// OFR4
const OFR4_val = packed struct {
/// OFFSET4 [0:11]
/// OFFSET4
OFFSET4: u12 = 0,
/// unused [12:25]
_unused12: u4 = 0,
_unused16: u8 = 0,
_unused24: u2 = 0,
/// OFFSET4_CH [26:30]
/// OFFSET4_CH
OFFSET4_CH: u5 = 0,
/// OFFSET4_EN [31:31]
/// OFFSET4_EN
OFFSET4_EN: u1 = 0,
};
/// offset register 4
pub const OFR4 = Register(OFR4_val).init(base_address + 0x6c);

/// JDR1
const JDR1_val = packed struct {
/// JDATA1 [0:15]
/// JDATA1
JDATA1: u16 = 0,
/// unused [16:31]
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// injected data register 1
pub const JDR1 = Register(JDR1_val).init(base_address + 0x80);

/// JDR2
const JDR2_val = packed struct {
/// JDATA2 [0:15]
/// JDATA2
JDATA2: u16 = 0,
/// unused [16:31]
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// injected data register 2
pub const JDR2 = Register(JDR2_val).init(base_address + 0x84);

/// JDR3
const JDR3_val = packed struct {
/// JDATA3 [0:15]
/// JDATA3
JDATA3: u16 = 0,
/// unused [16:31]
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// injected data register 3
pub const JDR3 = Register(JDR3_val).init(base_address + 0x88);

/// JDR4
const JDR4_val = packed struct {
/// JDATA4 [0:15]
/// JDATA4
JDATA4: u16 = 0,
/// unused [16:31]
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// injected data register 4
pub const JDR4 = Register(JDR4_val).init(base_address + 0x8c);

/// AWD2CR
const AWD2CR_val = packed struct {
/// unused [0:0]
_unused0: u1 = 0,
/// AWD2CH [1:18]
/// AWD2CH
AWD2CH: u18 = 0,
/// unused [19:31]
_unused19: u5 = 0,
_unused24: u8 = 0,
};
/// Analog Watchdog 2 Configuration
pub const AWD2CR = Register(AWD2CR_val).init(base_address + 0xa0);

/// AWD3CR
const AWD3CR_val = packed struct {
/// unused [0:0]
_unused0: u1 = 0,
/// AWD3CH [1:18]
/// AWD3CH
AWD3CH: u18 = 0,
/// unused [19:31]
_unused19: u5 = 0,
_unused24: u8 = 0,
};
/// Analog Watchdog 3 Configuration
pub const AWD3CR = Register(AWD3CR_val).init(base_address + 0xa4);

/// DIFSEL
const DIFSEL_val = packed struct {
/// unused [0:0]
_unused0: u1 = 0,
/// DIFSEL_1_15 [1:15]
/// Differential mode for channels 15 to
DIFSEL_1_15: u15 = 0,
/// DIFSEL_16_18 [16:18]
/// Differential mode for channels 18 to
DIFSEL_16_18: u3 = 0,
/// unused [19:31]
_unused19: u5 = 0,
_unused24: u8 = 0,
};
/// Differential Mode Selection Register
pub const DIFSEL = Register(DIFSEL_val).init(base_address + 0xb0);

/// CALFACT
const CALFACT_val = packed struct {
/// CALFACT_S [0:6]
/// CALFACT_S
CALFACT_S: u7 = 0,
/// unused [7:15]
_unused7: u1 = 0,
_unused8: u8 = 0,
/// CALFACT_D [16:22]
/// CALFACT_D
CALFACT_D: u7 = 0,
/// unused [23:31]
_unused23: u1 = 0,
_unused24: u8 = 0,
};
/// Calibration Factors
pub const CALFACT = Register(CALFACT_val).init(base_address + 0xb4);
};

/// Analog-to-Digital Converter
pub const ADC4 = struct {

const base_address = 0x50000500;
/// ISR
const ISR_val = packed struct {
/// ADRDY [0:0]
/// ADRDY
ADRDY: u1 = 0,
/// EOSMP [1:1]
/// EOSMP
EOSMP: u1 = 0,
/// EOC [2:2]
/// EOC
EOC: u1 = 0,
/// EOS [3:3]
/// EOS
EOS: u1 = 0,
/// OVR [4:4]
/// OVR
OVR: u1 = 0,
/// JEOC [5:5]
/// JEOC
JEOC: u1 = 0,
/// JEOS [6:6]
/// JEOS
JEOS: u1 = 0,
/// AWD1 [7:7]
/// AWD1
AWD1: u1 = 0,
/// AWD2 [8:8]
/// AWD2
AWD2: u1 = 0,
/// AWD3 [9:9]
/// AWD3
AWD3: u1 = 0,
/// JQOVF [10:10]
/// JQOVF
JQOVF: u1 = 0,
/// unused [11:31]
_unused11: u5 = 0,
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// interrupt and status register
pub const ISR = Register(ISR_val).init(base_address + 0x0);

/// IER
const IER_val = packed struct {
/// ADRDYIE [0:0]
/// ADRDYIE
ADRDYIE: u1 = 0,
/// EOSMPIE [1:1]
/// EOSMPIE
EOSMPIE: u1 = 0,
/// EOCIE [2:2]
/// EOCIE
EOCIE: u1 = 0,
/// EOSIE [3:3]
/// EOSIE
EOSIE: u1 = 0,
/// OVRIE [4:4]
/// OVRIE
OVRIE: u1 = 0,
/// JEOCIE [5:5]
/// JEOCIE
JEOCIE: u1 = 0,
/// JEOSIE [6:6]
/// JEOSIE
JEOSIE: u1 = 0,
/// AWD1IE [7:7]
/// AWD1IE
AWD1IE: u1 = 0,
/// AWD2IE [8:8]
/// AWD2IE
AWD2IE: u1 = 0,
/// AWD3IE [9:9]
/// AWD3IE
AWD3IE: u1 = 0,
/// JQOVFIE [10:10]
/// JQOVFIE
JQOVFIE: u1 = 0,
/// unused [11:31]
_unused11: u5 = 0,
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// interrupt enable register
pub const IER = Register(IER_val).init(base_address + 0x4);

/// CR
const CR_val = packed struct {
/// ADEN [0:0]
/// ADEN
ADEN: u1 = 0,
/// ADDIS [1:1]
/// ADDIS
ADDIS: u1 = 0,
/// ADSTART [2:2]
/// ADSTART
ADSTART: u1 = 0,
/// JADSTART [3:3]
/// JADSTART
JADSTART: u1 = 0,
/// ADSTP [4:4]
/// ADSTP
ADSTP: u1 = 0,
/// JADSTP [5:5]
/// JADSTP
JADSTP: u1 = 0,
/// unused [6:27]
_unused6: u2 = 0,
_unused8: u8 = 0,
_unused16: u8 = 0,
_unused24: u4 = 0,
/// ADVREGEN [28:28]
/// ADVREGEN
ADVREGEN: u1 = 0,
/// DEEPPWD [29:29]
/// DEEPPWD
DEEPPWD: u1 = 0,
/// ADCALDIF [30:30]
/// ADCALDIF
ADCALDIF: u1 = 0,
/// ADCAL [31:31]
/// ADCAL
ADCAL: u1 = 0,
};
/// control register
pub const CR = Register(CR_val).init(base_address + 0x8);

/// CFGR
const CFGR_val = packed struct {
/// DMAEN [0:0]
/// DMAEN
DMAEN: u1 = 0,
/// DMACFG [1:1]
/// DMACFG
DMACFG: u1 = 0,
/// unused [2:2]
_unused2: u1 = 0,
/// RES [3:4]
/// RES
RES: u2 = 0,
/// ALIGN [5:5]
/// ALIGN
ALIGN: u1 = 0,
/// EXTSEL [6:9]
/// EXTSEL
EXTSEL: u4 = 0,
/// EXTEN [10:11]
/// EXTEN
EXTEN: u2 = 0,
/// OVRMOD [12:12]
/// OVRMOD
OVRMOD: u1 = 0,
/// CONT [13:13]
/// CONT
CONT: u1 = 0,
/// AUTDLY [14:14]
/// AUTDLY
AUTDLY: u1 = 0,
/// AUTOFF [15:15]
/// AUTOFF
AUTOFF: u1 = 0,
/// DISCEN [16:16]
/// DISCEN
DISCEN: u1 = 0,
/// DISCNUM [17:19]
/// DISCNUM
DISCNUM: u3 = 0,
/// JDISCEN [20:20]
/// JDISCEN
JDISCEN: u1 = 0,
/// JQM [21:21]
/// JQM
JQM: u1 = 0,
/// AWD1SGL [22:22]
/// AWD1SGL
AWD1SGL: u1 = 0,
/// AWD1EN [23:23]
/// AWD1EN
AWD1EN: u1 = 0,
/// JAWD1EN [24:24]
/// JAWD1EN
JAWD1EN: u1 = 0,
/// JAUTO [25:25]
/// JAUTO
JAUTO: u1 = 0,
/// AWDCH1CH [26:30]
/// AWDCH1CH
AWDCH1CH: u5 = 0,
/// unused [31:31]
_unused31: u1 = 0,
};
/// configuration register
pub const CFGR = Register(CFGR_val).init(base_address + 0xc);

/// SMPR1
const SMPR1_val = packed struct {
/// unused [0:2]
_unused0: u3 = 0,
/// SMP1 [3:5]
/// SMP1
SMP1: u3 = 0,
/// SMP2 [6:8]
/// SMP2
SMP2: u3 = 0,
/// SMP3 [9:11]
/// SMP3
SMP3: u3 = 0,
/// SMP4 [12:14]
/// SMP4
SMP4: u3 = 0,
/// SMP5 [15:17]
/// SMP5
SMP5: u3 = 0,
/// SMP6 [18:20]
/// SMP6
SMP6: u3 = 0,
/// SMP7 [21:23]
/// SMP7
SMP7: u3 = 0,
/// SMP8 [24:26]
/// SMP8
SMP8: u3 = 0,
/// SMP9 [27:29]
/// SMP9
SMP9: u3 = 0,
/// unused [30:31]
_unused30: u2 = 0,
};
/// sample time register 1
pub const SMPR1 = Register(SMPR1_val).init(base_address + 0x14);

/// SMPR2
const SMPR2_val = packed struct {
/// SMP10 [0:2]
/// SMP10
SMP10: u3 = 0,
/// SMP11 [3:5]
/// SMP11
SMP11: u3 = 0,
/// SMP12 [6:8]
/// SMP12
SMP12: u3 = 0,
/// SMP13 [9:11]
/// SMP13
SMP13: u3 = 0,
/// SMP14 [12:14]
/// SMP14
SMP14: u3 = 0,
/// SMP15 [15:17]
/// SMP15
SMP15: u3 = 0,
/// SMP16 [18:20]
/// SMP16
SMP16: u3 = 0,
/// SMP17 [21:23]
/// SMP17
SMP17: u3 = 0,
/// SMP18 [24:26]
/// SMP18
SMP18: u3 = 0,
/// unused [27:31]
_unused27: u5 = 0,
};
/// sample time register 2
pub const SMPR2 = Register(SMPR2_val).init(base_address + 0x18);

/// TR1
const TR1_val = packed struct {
/// LT1 [0:11]
/// LT1
LT1: u12 = 0,
/// unused [12:15]
_unused12: u4 = 0,
/// HT1 [16:27]
/// HT1
HT1: u12 = 4095,
/// unused [28:31]
_unused28: u4 = 0,
};
/// watchdog threshold register 1
pub const TR1 = Register(TR1_val).init(base_address + 0x20);

/// TR2
const TR2_val = packed struct {
/// LT2 [0:7]
/// LT2
LT2: u8 = 0,
/// unused [8:15]
_unused8: u8 = 0,
/// HT2 [16:23]
/// HT2
HT2: u8 = 255,
/// unused [24:31]
_unused24: u8 = 15,
};
/// watchdog threshold register
pub const TR2 = Register(TR2_val).init(base_address + 0x24);

/// TR3
const TR3_val = packed struct {
/// LT3 [0:7]
/// LT3
LT3: u8 = 0,
/// unused [8:15]
_unused8: u8 = 0,
/// HT3 [16:23]
/// HT3
HT3: u8 = 255,
/// unused [24:31]
_unused24: u8 = 15,
};
/// watchdog threshold register 3
pub const TR3 = Register(TR3_val).init(base_address + 0x28);

/// SQR1
const SQR1_val = packed struct {
/// L3 [0:3]
/// L3
L3: u4 = 0,
/// unused [4:5]
_unused4: u2 = 0,
/// SQ1 [6:10]
/// SQ1
SQ1: u5 = 0,
/// unused [11:11]
_unused11: u1 = 0,
/// SQ2 [12:16]
/// SQ2
SQ2: u5 = 0,
/// unused [17:17]
_unused17: u1 = 0,
/// SQ3 [18:22]
/// SQ3
SQ3: u5 = 0,
/// unused [23:23]
_unused23: u1 = 0,
/// SQ4 [24:28]
/// SQ4
SQ4: u5 = 0,
/// unused [29:31]
_unused29: u3 = 0,
};
/// regular sequence register 1
pub const SQR1 = Register(SQR1_val).init(base_address + 0x30);

/// SQR2
const SQR2_val = packed struct {
/// SQ5 [0:4]
/// SQ5
SQ5: u5 = 0,
/// unused [5:5]
_unused5: u1 = 0,
/// SQ6 [6:10]
/// SQ6
SQ6: u5 = 0,
/// unused [11:11]
_unused11: u1 = 0,
/// SQ7 [12:16]
/// SQ7
SQ7: u5 = 0,
/// unused [17:17]
_unused17: u1 = 0,
/// SQ8 [18:22]
/// SQ8
SQ8: u5 = 0,
/// unused [23:23]
_unused23: u1 = 0,
/// SQ9 [24:28]
/// SQ9
SQ9: u5 = 0,
/// unused [29:31]
_unused29: u3 = 0,
};
/// regular sequence register 2
pub const SQR2 = Register(SQR2_val).init(base_address + 0x34);

/// SQR3
const SQR3_val = packed struct {
/// SQ10 [0:4]
/// SQ10
SQ10: u5 = 0,
/// unused [5:5]
_unused5: u1 = 0,
/// SQ11 [6:10]
/// SQ11
SQ11: u5 = 0,
/// unused [11:11]
_unused11: u1 = 0,
/// SQ12 [12:16]
/// SQ12
SQ12: u5 = 0,
/// unused [17:17]
_unused17: u1 = 0,
/// SQ13 [18:22]
/// SQ13
SQ13: u5 = 0,
/// unused [23:23]
_unused23: u1 = 0,
/// SQ14 [24:28]
/// SQ14
SQ14: u5 = 0,
/// unused [29:31]
_unused29: u3 = 0,
};
/// regular sequence register 3
pub const SQR3 = Register(SQR3_val).init(base_address + 0x38);

/// SQR4
const SQR4_val = packed struct {
/// SQ15 [0:4]
/// SQ15
SQ15: u5 = 0,
/// unused [5:5]
_unused5: u1 = 0,
/// SQ16 [6:10]
/// SQ16
SQ16: u5 = 0,
/// unused [11:31]
_unused11: u5 = 0,
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// regular sequence register 4
pub const SQR4 = Register(SQR4_val).init(base_address + 0x3c);

/// DR
const DR_val = packed struct {
/// regularDATA [0:15]
/// regularDATA
regularDATA: u16 = 0,
/// unused [16:31]
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// regular Data Register
pub const DR = Register(DR_val).init(base_address + 0x40);

/// JSQR
const JSQR_val = packed struct {
/// JL [0:1]
/// JL
JL: u2 = 0,
/// JEXTSEL [2:5]
/// JEXTSEL
JEXTSEL: u4 = 0,
/// JEXTEN [6:7]
/// JEXTEN
JEXTEN: u2 = 0,
/// JSQ1 [8:12]
/// JSQ1
JSQ1: u5 = 0,
/// unused [13:13]
_unused13: u1 = 0,
/// JSQ2 [14:18]
/// JSQ2
JSQ2: u5 = 0,
/// unused [19:19]
_unused19: u1 = 0,
/// JSQ3 [20:24]
/// JSQ3
JSQ3: u5 = 0,
/// unused [25:25]
_unused25: u1 = 0,
/// JSQ4 [26:30]
/// JSQ4
JSQ4: u5 = 0,
/// unused [31:31]
_unused31: u1 = 0,
};
/// injected sequence register
pub const JSQR = Register(JSQR_val).init(base_address + 0x4c);

/// OFR1
const OFR1_val = packed struct {
/// OFFSET1 [0:11]
/// OFFSET1
OFFSET1: u12 = 0,
/// unused [12:25]
_unused12: u4 = 0,
_unused16: u8 = 0,
_unused24: u2 = 0,
/// OFFSET1_CH [26:30]
/// OFFSET1_CH
OFFSET1_CH: u5 = 0,
/// OFFSET1_EN [31:31]
/// OFFSET1_EN
OFFSET1_EN: u1 = 0,
};
/// offset register 1
pub const OFR1 = Register(OFR1_val).init(base_address + 0x60);

/// OFR2
const OFR2_val = packed struct {
/// OFFSET2 [0:11]
/// OFFSET2
OFFSET2: u12 = 0,
/// unused [12:25]
_unused12: u4 = 0,
_unused16: u8 = 0,
_unused24: u2 = 0,
/// OFFSET2_CH [26:30]
/// OFFSET2_CH
OFFSET2_CH: u5 = 0,
/// OFFSET2_EN [31:31]
/// OFFSET2_EN
OFFSET2_EN: u1 = 0,
};
/// offset register 2
pub const OFR2 = Register(OFR2_val).init(base_address + 0x64);

/// OFR3
const OFR3_val = packed struct {
/// OFFSET3 [0:11]
/// OFFSET3
OFFSET3: u12 = 0,
/// unused [12:25]
_unused12: u4 = 0,
_unused16: u8 = 0,
_unused24: u2 = 0,
/// OFFSET3_CH [26:30]
/// OFFSET3_CH
OFFSET3_CH: u5 = 0,
/// OFFSET3_EN [31:31]
/// OFFSET3_EN
OFFSET3_EN: u1 = 0,
};
/// offset register 3
pub const OFR3 = Register(OFR3_val).init(base_address + 0x68);

/// OFR4
const OFR4_val = packed struct {
/// OFFSET4 [0:11]
/// OFFSET4
OFFSET4: u12 = 0,
/// unused [12:25]
_unused12: u4 = 0,
_unused16: u8 = 0,
_unused24: u2 = 0,
/// OFFSET4_CH [26:30]
/// OFFSET4_CH
OFFSET4_CH: u5 = 0,
/// OFFSET4_EN [31:31]
/// OFFSET4_EN
OFFSET4_EN: u1 = 0,
};
/// offset register 4
pub const OFR4 = Register(OFR4_val).init(base_address + 0x6c);

/// JDR1
const JDR1_val = packed struct {
/// JDATA1 [0:15]
/// JDATA1
JDATA1: u16 = 0,
/// unused [16:31]
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// injected data register 1
pub const JDR1 = Register(JDR1_val).init(base_address + 0x80);

/// JDR2
const JDR2_val = packed struct {
/// JDATA2 [0:15]
/// JDATA2
JDATA2: u16 = 0,
/// unused [16:31]
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// injected data register 2
pub const JDR2 = Register(JDR2_val).init(base_address + 0x84);

/// JDR3
const JDR3_val = packed struct {
/// JDATA3 [0:15]
/// JDATA3
JDATA3: u16 = 0,
/// unused [16:31]
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// injected data register 3
pub const JDR3 = Register(JDR3_val).init(base_address + 0x88);

/// JDR4
const JDR4_val = packed struct {
/// JDATA4 [0:15]
/// JDATA4
JDATA4: u16 = 0,
/// unused [16:31]
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// injected data register 4
pub const JDR4 = Register(JDR4_val).init(base_address + 0x8c);

/// AWD2CR
const AWD2CR_val = packed struct {
/// unused [0:0]
_unused0: u1 = 0,
/// AWD2CH [1:18]
/// AWD2CH
AWD2CH: u18 = 0,
/// unused [19:31]
_unused19: u5 = 0,
_unused24: u8 = 0,
};
/// Analog Watchdog 2 Configuration
pub const AWD2CR = Register(AWD2CR_val).init(base_address + 0xa0);

/// AWD3CR
const AWD3CR_val = packed struct {
/// unused [0:0]
_unused0: u1 = 0,
/// AWD3CH [1:18]
/// AWD3CH
AWD3CH: u18 = 0,
/// unused [19:31]
_unused19: u5 = 0,
_unused24: u8 = 0,
};
/// Analog Watchdog 3 Configuration
pub const AWD3CR = Register(AWD3CR_val).init(base_address + 0xa4);

/// DIFSEL
const DIFSEL_val = packed struct {
/// unused [0:0]
_unused0: u1 = 0,
/// DIFSEL_1_15 [1:15]
/// Differential mode for channels 15 to
DIFSEL_1_15: u15 = 0,
/// DIFSEL_16_18 [16:18]
/// Differential mode for channels 18 to
DIFSEL_16_18: u3 = 0,
/// unused [19:31]
_unused19: u5 = 0,
_unused24: u8 = 0,
};
/// Differential Mode Selection Register
pub const DIFSEL = Register(DIFSEL_val).init(base_address + 0xb0);

/// CALFACT
const CALFACT_val = packed struct {
/// CALFACT_S [0:6]
/// CALFACT_S
CALFACT_S: u7 = 0,
/// unused [7:15]
_unused7: u1 = 0,
_unused8: u8 = 0,
/// CALFACT_D [16:22]
/// CALFACT_D
CALFACT_D: u7 = 0,
/// unused [23:31]
_unused23: u1 = 0,
_unused24: u8 = 0,
};
/// Calibration Factors
pub const CALFACT = Register(CALFACT_val).init(base_address + 0xb4);
};

/// Analog-to-Digital Converter
pub const ADC1_2 = struct {

const base_address = 0x50000300;
/// CSR
const CSR_val = packed struct {
/// ADDRDY_MST [0:0]
/// ADDRDY_MST
ADDRDY_MST: u1 = 0,
/// EOSMP_MST [1:1]
/// EOSMP_MST
EOSMP_MST: u1 = 0,
/// EOC_MST [2:2]
/// EOC_MST
EOC_MST: u1 = 0,
/// EOS_MST [3:3]
/// EOS_MST
EOS_MST: u1 = 0,
/// OVR_MST [4:4]
/// OVR_MST
OVR_MST: u1 = 0,
/// JEOC_MST [5:5]
/// JEOC_MST
JEOC_MST: u1 = 0,
/// JEOS_MST [6:6]
/// JEOS_MST
JEOS_MST: u1 = 0,
/// AWD1_MST [7:7]
/// AWD1_MST
AWD1_MST: u1 = 0,
/// AWD2_MST [8:8]
/// AWD2_MST
AWD2_MST: u1 = 0,
/// AWD3_MST [9:9]
/// AWD3_MST
AWD3_MST: u1 = 0,
/// JQOVF_MST [10:10]
/// JQOVF_MST
JQOVF_MST: u1 = 0,
/// unused [11:15]
_unused11: u5 = 0,
/// ADRDY_SLV [16:16]
/// ADRDY_SLV
ADRDY_SLV: u1 = 0,
/// EOSMP_SLV [17:17]
/// EOSMP_SLV
EOSMP_SLV: u1 = 0,
/// EOC_SLV [18:18]
/// End of regular conversion of the slave
EOC_SLV: u1 = 0,
/// EOS_SLV [19:19]
/// End of regular sequence flag of the
EOS_SLV: u1 = 0,
/// OVR_SLV [20:20]
/// Overrun flag of the slave
OVR_SLV: u1 = 0,
/// JEOC_SLV [21:21]
/// End of injected conversion flag of the
JEOC_SLV: u1 = 0,
/// JEOS_SLV [22:22]
/// End of injected sequence flag of the
JEOS_SLV: u1 = 0,
/// AWD1_SLV [23:23]
/// Analog watchdog 1 flag of the slave
AWD1_SLV: u1 = 0,
/// AWD2_SLV [24:24]
/// Analog watchdog 2 flag of the slave
AWD2_SLV: u1 = 0,
/// AWD3_SLV [25:25]
/// Analog watchdog 3 flag of the slave
AWD3_SLV: u1 = 0,
/// JQOVF_SLV [26:26]
/// Injected Context Queue Overflow flag of
JQOVF_SLV: u1 = 0,
/// unused [27:31]
_unused27: u5 = 0,
};
/// ADC Common status register
pub const CSR = Register(CSR_val).init(base_address + 0x0);

/// CCR
const CCR_val = packed struct {
/// MULT [0:4]
/// Multi ADC mode selection
MULT: u5 = 0,
/// unused [5:7]
_unused5: u3 = 0,
/// DELAY [8:11]
/// Delay between 2 sampling
DELAY: u4 = 0,
/// unused [12:12]
_unused12: u1 = 0,
/// DMACFG [13:13]
/// DMA configuration (for multi-ADC
DMACFG: u1 = 0,
/// MDMA [14:15]
/// Direct memory access mode for multi ADC
MDMA: u2 = 0,
/// CKMODE [16:17]
/// ADC clock mode
CKMODE: u2 = 0,
/// unused [18:21]
_unused18: u4 = 0,
/// VREFEN [22:22]
/// VREFINT enable
VREFEN: u1 = 0,
/// TSEN [23:23]
/// Temperature sensor enable
TSEN: u1 = 0,
/// VBATEN [24:24]
/// VBAT enable
VBATEN: u1 = 0,
/// unused [25:31]
_unused25: u7 = 0,
};
/// ADC common control register
pub const CCR = Register(CCR_val).init(base_address + 0x8);

/// CDR
const CDR_val = packed struct {
/// RDATA_MST [0:15]
/// Regular data of the master
RDATA_MST: u16 = 0,
/// RDATA_SLV [16:31]
/// Regular data of the slave
RDATA_SLV: u16 = 0,
};
/// ADC common regular data register for dual
pub const CDR = Register(CDR_val).init(base_address + 0xc);
};

/// Analog-to-Digital Converter
pub const ADC3_4 = struct {

const base_address = 0x50000700;
/// CSR
const CSR_val = packed struct {
/// ADDRDY_MST [0:0]
/// ADDRDY_MST
ADDRDY_MST: u1 = 0,
/// EOSMP_MST [1:1]
/// EOSMP_MST
EOSMP_MST: u1 = 0,
/// EOC_MST [2:2]
/// EOC_MST
EOC_MST: u1 = 0,
/// EOS_MST [3:3]
/// EOS_MST
EOS_MST: u1 = 0,
/// OVR_MST [4:4]
/// OVR_MST
OVR_MST: u1 = 0,
/// JEOC_MST [5:5]
/// JEOC_MST
JEOC_MST: u1 = 0,
/// JEOS_MST [6:6]
/// JEOS_MST
JEOS_MST: u1 = 0,
/// AWD1_MST [7:7]
/// AWD1_MST
AWD1_MST: u1 = 0,
/// AWD2_MST [8:8]
/// AWD2_MST
AWD2_MST: u1 = 0,
/// AWD3_MST [9:9]
/// AWD3_MST
AWD3_MST: u1 = 0,
/// JQOVF_MST [10:10]
/// JQOVF_MST
JQOVF_MST: u1 = 0,
/// unused [11:15]
_unused11: u5 = 0,
/// ADRDY_SLV [16:16]
/// ADRDY_SLV
ADRDY_SLV: u1 = 0,
/// EOSMP_SLV [17:17]
/// EOSMP_SLV
EOSMP_SLV: u1 = 0,
/// EOC_SLV [18:18]
/// End of regular conversion of the slave
EOC_SLV: u1 = 0,
/// EOS_SLV [19:19]
/// End of regular sequence flag of the
EOS_SLV: u1 = 0,
/// OVR_SLV [20:20]
/// Overrun flag of the slave
OVR_SLV: u1 = 0,
/// JEOC_SLV [21:21]
/// End of injected conversion flag of the
JEOC_SLV: u1 = 0,
/// JEOS_SLV [22:22]
/// End of injected sequence flag of the
JEOS_SLV: u1 = 0,
/// AWD1_SLV [23:23]
/// Analog watchdog 1 flag of the slave
AWD1_SLV: u1 = 0,
/// AWD2_SLV [24:24]
/// Analog watchdog 2 flag of the slave
AWD2_SLV: u1 = 0,
/// AWD3_SLV [25:25]
/// Analog watchdog 3 flag of the slave
AWD3_SLV: u1 = 0,
/// JQOVF_SLV [26:26]
/// Injected Context Queue Overflow flag of
JQOVF_SLV: u1 = 0,
/// unused [27:31]
_unused27: u5 = 0,
};
/// ADC Common status register
pub const CSR = Register(CSR_val).init(base_address + 0x0);

/// CCR
const CCR_val = packed struct {
/// MULT [0:4]
/// Multi ADC mode selection
MULT: u5 = 0,
/// unused [5:7]
_unused5: u3 = 0,
/// DELAY [8:11]
/// Delay between 2 sampling
DELAY: u4 = 0,
/// unused [12:12]
_unused12: u1 = 0,
/// DMACFG [13:13]
/// DMA configuration (for multi-ADC
DMACFG: u1 = 0,
/// MDMA [14:15]
/// Direct memory access mode for multi ADC
MDMA: u2 = 0,
/// CKMODE [16:17]
/// ADC clock mode
CKMODE: u2 = 0,
/// unused [18:21]
_unused18: u4 = 0,
/// VREFEN [22:22]
/// VREFINT enable
VREFEN: u1 = 0,
/// TSEN [23:23]
/// Temperature sensor enable
TSEN: u1 = 0,
/// VBATEN [24:24]
/// VBAT enable
VBATEN: u1 = 0,
/// unused [25:31]
_unused25: u7 = 0,
};
/// ADC common control register
pub const CCR = Register(CCR_val).init(base_address + 0x8);

/// CDR
const CDR_val = packed struct {
/// RDATA_MST [0:15]
/// Regular data of the master
RDATA_MST: u16 = 0,
/// RDATA_SLV [16:31]
/// Regular data of the slave
RDATA_SLV: u16 = 0,
};
/// ADC common regular data register for dual
pub const CDR = Register(CDR_val).init(base_address + 0xc);
};

/// System configuration controller _Comparator and
pub const SYSCFG_COMP_OPAMP = struct {

const base_address = 0x40010000;
/// SYSCFG_CFGR1
const SYSCFG_CFGR1_val = packed struct {
/// MEM_MODE [0:1]
/// Memory mapping selection
MEM_MODE: u2 = 0,
/// unused [2:4]
_unused2: u3 = 0,
/// USB_IT_RMP [5:5]
/// USB interrupt remap
USB_IT_RMP: u1 = 0,
/// TIM1_ITR_RMP [6:6]
/// Timer 1 ITR3 selection
TIM1_ITR_RMP: u1 = 0,
/// DAC_TRIG_RMP [7:7]
/// DAC trigger remap (when TSEL =
DAC_TRIG_RMP: u1 = 0,
/// ADC24_DMA_RMP [8:8]
/// ADC24 DMA remapping bit
ADC24_DMA_RMP: u1 = 0,
/// unused [9:10]
_unused9: u2 = 0,
/// TIM16_DMA_RMP [11:11]
/// TIM16 DMA request remapping
TIM16_DMA_RMP: u1 = 0,
/// TIM17_DMA_RMP [12:12]
/// TIM17 DMA request remapping
TIM17_DMA_RMP: u1 = 0,
/// TIM6_DAC1_DMA_RMP [13:13]
/// TIM6 and DAC1 DMA request remapping
TIM6_DAC1_DMA_RMP: u1 = 0,
/// TIM7_DAC2_DMA_RMP [14:14]
/// TIM7 and DAC2 DMA request remapping
TIM7_DAC2_DMA_RMP: u1 = 0,
/// unused [15:15]
_unused15: u1 = 0,
/// I2C_PB6_FM [16:16]
/// Fast Mode Plus (FM+) driving capability
I2C_PB6_FM: u1 = 0,
/// I2C_PB7_FM [17:17]
/// Fast Mode Plus (FM+) driving capability
I2C_PB7_FM: u1 = 0,
/// I2C_PB8_FM [18:18]
/// Fast Mode Plus (FM+) driving capability
I2C_PB8_FM: u1 = 0,
/// I2C_PB9_FM [19:19]
/// Fast Mode Plus (FM+) driving capability
I2C_PB9_FM: u1 = 0,
/// I2C1_FM [20:20]
/// I2C1 Fast Mode Plus
I2C1_FM: u1 = 0,
/// I2C2_FM [21:21]
/// I2C2 Fast Mode Plus
I2C2_FM: u1 = 0,
/// ENCODER_MODE [22:23]
/// Encoder mode
ENCODER_MODE: u2 = 0,
/// unused [24:25]
_unused24: u2 = 0,
/// FPU_IT [26:31]
/// Interrupt enable bits from
FPU_IT: u6 = 0,
};
/// configuration register 1
pub const SYSCFG_CFGR1 = Register(SYSCFG_CFGR1_val).init(base_address + 0x0);

/// SYSCFG_EXTICR1
const SYSCFG_EXTICR1_val = packed struct {
/// EXTI0 [0:3]
/// EXTI 0 configuration bits
EXTI0: u4 = 0,
/// EXTI1 [4:7]
/// EXTI 1 configuration bits
EXTI1: u4 = 0,
/// EXTI2 [8:11]
/// EXTI 2 configuration bits
EXTI2: u4 = 0,
/// EXTI3 [12:15]
/// EXTI 3 configuration bits
EXTI3: u4 = 0,
/// unused [16:31]
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// external interrupt configuration register
pub const SYSCFG_EXTICR1 = Register(SYSCFG_EXTICR1_val).init(base_address + 0x8);

/// SYSCFG_EXTICR2
const SYSCFG_EXTICR2_val = packed struct {
/// EXTI4 [0:3]
/// EXTI 4 configuration bits
EXTI4: u4 = 0,
/// EXTI5 [4:7]
/// EXTI 5 configuration bits
EXTI5: u4 = 0,
/// EXTI6 [8:11]
/// EXTI 6 configuration bits
EXTI6: u4 = 0,
/// EXTI7 [12:15]
/// EXTI 7 configuration bits
EXTI7: u4 = 0,
/// unused [16:31]
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// external interrupt configuration register
pub const SYSCFG_EXTICR2 = Register(SYSCFG_EXTICR2_val).init(base_address + 0xc);

/// SYSCFG_EXTICR3
const SYSCFG_EXTICR3_val = packed struct {
/// EXTI8 [0:3]
/// EXTI 8 configuration bits
EXTI8: u4 = 0,
/// EXTI9 [4:7]
/// EXTI 9 configuration bits
EXTI9: u4 = 0,
/// EXTI10 [8:11]
/// EXTI 10 configuration bits
EXTI10: u4 = 0,
/// EXTI11 [12:15]
/// EXTI 11 configuration bits
EXTI11: u4 = 0,
/// unused [16:31]
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// external interrupt configuration register
pub const SYSCFG_EXTICR3 = Register(SYSCFG_EXTICR3_val).init(base_address + 0x10);

/// SYSCFG_EXTICR4
const SYSCFG_EXTICR4_val = packed struct {
/// EXTI12 [0:3]
/// EXTI 12 configuration bits
EXTI12: u4 = 0,
/// EXTI13 [4:7]
/// EXTI 13 configuration bits
EXTI13: u4 = 0,
/// EXTI14 [8:11]
/// EXTI 14 configuration bits
EXTI14: u4 = 0,
/// EXTI15 [12:15]
/// EXTI 15 configuration bits
EXTI15: u4 = 0,
/// unused [16:31]
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// external interrupt configuration register
pub const SYSCFG_EXTICR4 = Register(SYSCFG_EXTICR4_val).init(base_address + 0x14);

/// SYSCFG_CFGR2
const SYSCFG_CFGR2_val = packed struct {
/// LOCUP_LOCK [0:0]
/// Cortex-M0 LOCKUP bit enable
LOCUP_LOCK: u1 = 0,
/// SRAM_PARITY_LOCK [1:1]
/// SRAM parity lock bit
SRAM_PARITY_LOCK: u1 = 0,
/// PVD_LOCK [2:2]
/// PVD lock enable bit
PVD_LOCK: u1 = 0,
/// unused [3:3]
_unused3: u1 = 0,
/// BYP_ADD_PAR [4:4]
/// Bypass address bit 29 in parity
BYP_ADD_PAR: u1 = 0,
/// unused [5:7]
_unused5: u3 = 0,
/// SRAM_PEF [8:8]
/// SRAM parity flag
SRAM_PEF: u1 = 0,
/// unused [9:31]
_unused9: u7 = 0,
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// configuration register 2
pub const SYSCFG_CFGR2 = Register(SYSCFG_CFGR2_val).init(base_address + 0x18);

/// SYSCFG_RCR
const SYSCFG_RCR_val = packed struct {
/// PAGE0_WP [0:0]
/// CCM SRAM page write protection
PAGE0_WP: u1 = 0,
/// PAGE1_WP [1:1]
/// CCM SRAM page write protection
PAGE1_WP: u1 = 0,
/// PAGE2_WP [2:2]
/// CCM SRAM page write protection
PAGE2_WP: u1 = 0,
/// PAGE3_WP [3:3]
/// CCM SRAM page write protection
PAGE3_WP: u1 = 0,
/// PAGE4_WP [4:4]
/// CCM SRAM page write protection
PAGE4_WP: u1 = 0,
/// PAGE5_WP [5:5]
/// CCM SRAM page write protection
PAGE5_WP: u1 = 0,
/// PAGE6_WP [6:6]
/// CCM SRAM page write protection
PAGE6_WP: u1 = 0,
/// PAGE7_WP [7:7]
/// CCM SRAM page write protection
PAGE7_WP: u1 = 0,
/// unused [8:31]
_unused8: u8 = 0,
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// CCM SRAM protection register
pub const SYSCFG_RCR = Register(SYSCFG_RCR_val).init(base_address + 0x4);

/// COMP1_CSR
const COMP1_CSR_val = packed struct {
/// COMP1EN [0:0]
/// Comparator 1 enable
COMP1EN: u1 = 0,
/// COMP1_INP_DAC [1:1]
/// COMP1_INP_DAC
COMP1_INP_DAC: u1 = 0,
/// COMP1MODE [2:3]
/// Comparator 1 mode
COMP1MODE: u2 = 0,
/// COMP1INSEL [4:6]
/// Comparator 1 inverting input
COMP1INSEL: u3 = 0,
/// unused [7:9]
_unused7: u1 = 0,
_unused8: u2 = 0,
/// COMP1_OUT_SEL [10:13]
/// Comparator 1 output
COMP1_OUT_SEL: u4 = 0,
/// unused [14:14]
_unused14: u1 = 0,
/// COMP1POL [15:15]
/// Comparator 1 output
COMP1POL: u1 = 0,
/// COMP1HYST [16:17]
/// Comparator 1 hysteresis
COMP1HYST: u2 = 0,
/// COMP1_BLANKING [18:20]
/// Comparator 1 blanking
COMP1_BLANKING: u3 = 0,
/// unused [21:29]
_unused21: u3 = 0,
_unused24: u6 = 0,
/// COMP1OUT [30:30]
/// Comparator 1 output
COMP1OUT: u1 = 0,
/// COMP1LOCK [31:31]
/// Comparator 1 lock
COMP1LOCK: u1 = 0,
};
/// control and status register
pub const COMP1_CSR = Register(COMP1_CSR_val).init(base_address + 0x1c);

/// COMP2_CSR
const COMP2_CSR_val = packed struct {
/// COMP2EN [0:0]
/// Comparator 2 enable
COMP2EN: u1 = 0,
/// unused [1:1]
_unused1: u1 = 0,
/// COMP2MODE [2:3]
/// Comparator 2 mode
COMP2MODE: u2 = 0,
/// COMP2INSEL [4:6]
/// Comparator 2 inverting input
COMP2INSEL: u3 = 0,
/// COMP2INPSEL [7:7]
/// Comparator 2 non inverted input
COMP2INPSEL: u1 = 0,
/// unused [8:8]
_unused8: u1 = 0,
/// COMP2INMSEL [9:9]
/// Comparator 1inverting input
COMP2INMSEL: u1 = 0,
/// COMP2_OUT_SEL [10:13]
/// Comparator 2 output
COMP2_OUT_SEL: u4 = 0,
/// unused [14:14]
_unused14: u1 = 0,
/// COMP2POL [15:15]
/// Comparator 2 output
COMP2POL: u1 = 0,
/// COMP2HYST [16:17]
/// Comparator 2 hysteresis
COMP2HYST: u2 = 0,
/// COMP2_BLANKING [18:20]
/// Comparator 2 blanking
COMP2_BLANKING: u3 = 0,
/// unused [21:30]
_unused21: u3 = 0,
_unused24: u7 = 0,
/// COMP2LOCK [31:31]
/// Comparator 2 lock
COMP2LOCK: u1 = 0,
};
/// control and status register
pub const COMP2_CSR = Register(COMP2_CSR_val).init(base_address + 0x20);

/// COMP3_CSR
const COMP3_CSR_val = packed struct {
/// COMP3EN [0:0]
/// Comparator 3 enable
COMP3EN: u1 = 0,
/// unused [1:1]
_unused1: u1 = 0,
/// COMP3MODE [2:3]
/// Comparator 3 mode
COMP3MODE: u2 = 0,
/// COMP3INSEL [4:6]
/// Comparator 3 inverting input
COMP3INSEL: u3 = 0,
/// COMP3INPSEL [7:7]
/// Comparator 3 non inverted input
COMP3INPSEL: u1 = 0,
/// unused [8:9]
_unused8: u2 = 0,
/// COMP3_OUT_SEL [10:13]
/// Comparator 3 output
COMP3_OUT_SEL: u4 = 0,
/// unused [14:14]
_unused14: u1 = 0,
/// COMP3POL [15:15]
/// Comparator 3 output
COMP3POL: u1 = 0,
/// COMP3HYST [16:17]
/// Comparator 3 hysteresis
COMP3HYST: u2 = 0,
/// COMP3_BLANKING [18:20]
/// Comparator 3 blanking
COMP3_BLANKING: u3 = 0,
/// unused [21:29]
_unused21: u3 = 0,
_unused24: u6 = 0,
/// COMP3OUT [30:30]
/// Comparator 3 output
COMP3OUT: u1 = 0,
/// COMP3LOCK [31:31]
/// Comparator 3 lock
COMP3LOCK: u1 = 0,
};
/// control and status register
pub const COMP3_CSR = Register(COMP3_CSR_val).init(base_address + 0x24);

/// COMP4_CSR
const COMP4_CSR_val = packed struct {
/// COMP4EN [0:0]
/// Comparator 4 enable
COMP4EN: u1 = 0,
/// unused [1:1]
_unused1: u1 = 0,
/// COMP4MODE [2:3]
/// Comparator 4 mode
COMP4MODE: u2 = 0,
/// COMP4INSEL [4:6]
/// Comparator 4 inverting input
COMP4INSEL: u3 = 0,
/// COMP4INPSEL [7:7]
/// Comparator 4 non inverted input
COMP4INPSEL: u1 = 0,
/// unused [8:8]
_unused8: u1 = 0,
/// COM4WINMODE [9:9]
/// Comparator 4 window mode
COM4WINMODE: u1 = 0,
/// COMP4_OUT_SEL [10:13]
/// Comparator 4 output
COMP4_OUT_SEL: u4 = 0,
/// unused [14:14]
_unused14: u1 = 0,
/// COMP4POL [15:15]
/// Comparator 4 output
COMP4POL: u1 = 0,
/// COMP4HYST [16:17]
/// Comparator 4 hysteresis
COMP4HYST: u2 = 0,
/// COMP4_BLANKING [18:20]
/// Comparator 4 blanking
COMP4_BLANKING: u3 = 0,
/// unused [21:29]
_unused21: u3 = 0,
_unused24: u6 = 0,
/// COMP4OUT [30:30]
/// Comparator 4 output
COMP4OUT: u1 = 0,
/// COMP4LOCK [31:31]
/// Comparator 4 lock
COMP4LOCK: u1 = 0,
};
/// control and status register
pub const COMP4_CSR = Register(COMP4_CSR_val).init(base_address + 0x28);

/// COMP5_CSR
const COMP5_CSR_val = packed struct {
/// COMP5EN [0:0]
/// Comparator 5 enable
COMP5EN: u1 = 0,
/// unused [1:1]
_unused1: u1 = 0,
/// COMP5MODE [2:3]
/// Comparator 5 mode
COMP5MODE: u2 = 0,
/// COMP5INSEL [4:6]
/// Comparator 5 inverting input
COMP5INSEL: u3 = 0,
/// COMP5INPSEL [7:7]
/// Comparator 5 non inverted input
COMP5INPSEL: u1 = 0,
/// unused [8:9]
_unused8: u2 = 0,
/// COMP5_OUT_SEL [10:13]
/// Comparator 5 output
COMP5_OUT_SEL: u4 = 0,
/// unused [14:14]
_unused14: u1 = 0,
/// COMP5POL [15:15]
/// Comparator 5 output
COMP5POL: u1 = 0,
/// COMP5HYST [16:17]
/// Comparator 5 hysteresis
COMP5HYST: u2 = 0,
/// COMP5_BLANKING [18:20]
/// Comparator 5 blanking
COMP5_BLANKING: u3 = 0,
/// unused [21:29]
_unused21: u3 = 0,
_unused24: u6 = 0,
/// COMP5OUT [30:30]
/// Comparator51 output
COMP5OUT: u1 = 0,
/// COMP5LOCK [31:31]
/// Comparator 5 lock
COMP5LOCK: u1 = 0,
};
/// control and status register
pub const COMP5_CSR = Register(COMP5_CSR_val).init(base_address + 0x2c);

/// COMP6_CSR
const COMP6_CSR_val = packed struct {
/// COMP6EN [0:0]
/// Comparator 6 enable
COMP6EN: u1 = 0,
/// unused [1:1]
_unused1: u1 = 0,
/// COMP6MODE [2:3]
/// Comparator 6 mode
COMP6MODE: u2 = 0,
/// COMP6INSEL [4:6]
/// Comparator 6 inverting input
COMP6INSEL: u3 = 0,
/// COMP6INPSEL [7:7]
/// Comparator 6 non inverted input
COMP6INPSEL: u1 = 0,
/// unused [8:8]
_unused8: u1 = 0,
/// COM6WINMODE [9:9]
/// Comparator 6 window mode
COM6WINMODE: u1 = 0,
/// COMP6_OUT_SEL [10:13]
/// Comparator 6 output
COMP6_OUT_SEL: u4 = 0,
/// unused [14:14]
_unused14: u1 = 0,
/// COMP6POL [15:15]
/// Comparator 6 output
COMP6POL: u1 = 0,
/// COMP6HYST [16:17]
/// Comparator 6 hysteresis
COMP6HYST: u2 = 0,
/// COMP6_BLANKING [18:20]
/// Comparator 6 blanking
COMP6_BLANKING: u3 = 0,
/// unused [21:29]
_unused21: u3 = 0,
_unused24: u6 = 0,
/// COMP6OUT [30:30]
/// Comparator 6 output
COMP6OUT: u1 = 0,
/// COMP6LOCK [31:31]
/// Comparator 6 lock
COMP6LOCK: u1 = 0,
};
/// control and status register
pub const COMP6_CSR = Register(COMP6_CSR_val).init(base_address + 0x30);

/// COMP7_CSR
const COMP7_CSR_val = packed struct {
/// COMP7EN [0:0]
/// Comparator 7 enable
COMP7EN: u1 = 0,
/// unused [1:1]
_unused1: u1 = 0,
/// COMP7MODE [2:3]
/// Comparator 7 mode
COMP7MODE: u2 = 0,
/// COMP7INSEL [4:6]
/// Comparator 7 inverting input
COMP7INSEL: u3 = 0,
/// COMP7INPSEL [7:7]
/// Comparator 7 non inverted input
COMP7INPSEL: u1 = 0,
/// unused [8:9]
_unused8: u2 = 0,
/// COMP7_OUT_SEL [10:13]
/// Comparator 7 output
COMP7_OUT_SEL: u4 = 0,
/// unused [14:14]
_unused14: u1 = 0,
/// COMP7POL [15:15]
/// Comparator 7 output
COMP7POL: u1 = 0,
/// COMP7HYST [16:17]
/// Comparator 7 hysteresis
COMP7HYST: u2 = 0,
/// COMP7_BLANKING [18:20]
/// Comparator 7 blanking
COMP7_BLANKING: u3 = 0,
/// unused [21:29]
_unused21: u3 = 0,
_unused24: u6 = 0,
/// COMP7OUT [30:30]
/// Comparator 7 output
COMP7OUT: u1 = 0,
/// COMP7LOCK [31:31]
/// Comparator 7 lock
COMP7LOCK: u1 = 0,
};
/// control and status register
pub const COMP7_CSR = Register(COMP7_CSR_val).init(base_address + 0x34);

/// OPAMP1_CSR
const OPAMP1_CSR_val = packed struct {
/// OPAMP1_EN [0:0]
/// OPAMP1 enable
OPAMP1_EN: u1 = 0,
/// FORCE_VP [1:1]
/// FORCE_VP
FORCE_VP: u1 = 0,
/// VP_SEL [2:3]
/// OPAMP1 Non inverting input
VP_SEL: u2 = 0,
/// unused [4:4]
_unused4: u1 = 0,
/// VM_SEL [5:6]
/// OPAMP1 inverting input
VM_SEL: u2 = 0,
/// TCM_EN [7:7]
/// Timer controlled Mux mode
TCM_EN: u1 = 0,
/// VMS_SEL [8:8]
/// OPAMP1 inverting input secondary
VMS_SEL: u1 = 0,
/// VPS_SEL [9:10]
/// OPAMP1 Non inverting input secondary
VPS_SEL: u2 = 0,
/// CALON [11:11]
/// Calibration mode enable
CALON: u1 = 0,
/// CALSEL [12:13]
/// Calibration selection
CALSEL: u2 = 0,
/// PGA_GAIN [14:17]
/// Gain in PGA mode
PGA_GAIN: u4 = 0,
/// USER_TRIM [18:18]
/// User trimming enable
USER_TRIM: u1 = 0,
/// TRIMOFFSETP [19:23]
/// Offset trimming value
TRIMOFFSETP: u5 = 0,
/// TRIMOFFSETN [24:28]
/// Offset trimming value
TRIMOFFSETN: u5 = 0,
/// TSTREF [29:29]
/// TSTREF
TSTREF: u1 = 0,
/// OUTCAL [30:30]
/// OPAMP 1 ouput status flag
OUTCAL: u1 = 0,
/// LOCK [31:31]
/// OPAMP 1 lock
LOCK: u1 = 0,
};
/// control register
pub const OPAMP1_CSR = Register(OPAMP1_CSR_val).init(base_address + 0x38);

/// OPAMP2_CSR
const OPAMP2_CSR_val = packed struct {
/// OPAMP2EN [0:0]
/// OPAMP2 enable
OPAMP2EN: u1 = 0,
/// FORCE_VP [1:1]
/// FORCE_VP
FORCE_VP: u1 = 0,
/// VP_SEL [2:3]
/// OPAMP2 Non inverting input
VP_SEL: u2 = 0,
/// unused [4:4]
_unused4: u1 = 0,
/// VM_SEL [5:6]
/// OPAMP2 inverting input
VM_SEL: u2 = 0,
/// TCM_EN [7:7]
/// Timer controlled Mux mode
TCM_EN: u1 = 0,
/// VMS_SEL [8:8]
/// OPAMP2 inverting input secondary
VMS_SEL: u1 = 0,
/// VPS_SEL [9:10]
/// OPAMP2 Non inverting input secondary
VPS_SEL: u2 = 0,
/// CALON [11:11]
/// Calibration mode enable
CALON: u1 = 0,
/// CAL_SEL [12:13]
/// Calibration selection
CAL_SEL: u2 = 0,
/// PGA_GAIN [14:17]
/// Gain in PGA mode
PGA_GAIN: u4 = 0,
/// USER_TRIM [18:18]
/// User trimming enable
USER_TRIM: u1 = 0,
/// TRIMOFFSETP [19:23]
/// Offset trimming value
TRIMOFFSETP: u5 = 0,
/// TRIMOFFSETN [24:28]
/// Offset trimming value
TRIMOFFSETN: u5 = 0,
/// TSTREF [29:29]
/// TSTREF
TSTREF: u1 = 0,
/// OUTCAL [30:30]
/// OPAMP 2 ouput status flag
OUTCAL: u1 = 0,
/// LOCK [31:31]
/// OPAMP 2 lock
LOCK: u1 = 0,
};
/// control register
pub const OPAMP2_CSR = Register(OPAMP2_CSR_val).init(base_address + 0x3c);

/// OPAMP3_CSR
const OPAMP3_CSR_val = packed struct {
/// OPAMP3EN [0:0]
/// OPAMP3 enable
OPAMP3EN: u1 = 0,
/// FORCE_VP [1:1]
/// FORCE_VP
FORCE_VP: u1 = 0,
/// VP_SEL [2:3]
/// OPAMP3 Non inverting input
VP_SEL: u2 = 0,
/// unused [4:4]
_unused4: u1 = 0,
/// VM_SEL [5:6]
/// OPAMP3 inverting input
VM_SEL: u2 = 0,
/// TCM_EN [7:7]
/// Timer controlled Mux mode
TCM_EN: u1 = 0,
/// VMS_SEL [8:8]
/// OPAMP3 inverting input secondary
VMS_SEL: u1 = 0,
/// VPS_SEL [9:10]
/// OPAMP3 Non inverting input secondary
VPS_SEL: u2 = 0,
/// CALON [11:11]
/// Calibration mode enable
CALON: u1 = 0,
/// CALSEL [12:13]
/// Calibration selection
CALSEL: u2 = 0,
/// PGA_GAIN [14:17]
/// Gain in PGA mode
PGA_GAIN: u4 = 0,
/// USER_TRIM [18:18]
/// User trimming enable
USER_TRIM: u1 = 0,
/// TRIMOFFSETP [19:23]
/// Offset trimming value
TRIMOFFSETP: u5 = 0,
/// TRIMOFFSETN [24:28]
/// Offset trimming value
TRIMOFFSETN: u5 = 0,
/// TSTREF [29:29]
/// TSTREF
TSTREF: u1 = 0,
/// OUTCAL [30:30]
/// OPAMP 3 ouput status flag
OUTCAL: u1 = 0,
/// LOCK [31:31]
/// OPAMP 3 lock
LOCK: u1 = 0,
};
/// control register
pub const OPAMP3_CSR = Register(OPAMP3_CSR_val).init(base_address + 0x40);

/// OPAMP4_CSR
const OPAMP4_CSR_val = packed struct {
/// OPAMP4EN [0:0]
/// OPAMP4 enable
OPAMP4EN: u1 = 0,
/// FORCE_VP [1:1]
/// FORCE_VP
FORCE_VP: u1 = 0,
/// VP_SEL [2:3]
/// OPAMP4 Non inverting input
VP_SEL: u2 = 0,
/// unused [4:4]
_unused4: u1 = 0,
/// VM_SEL [5:6]
/// OPAMP4 inverting input
VM_SEL: u2 = 0,
/// TCM_EN [7:7]
/// Timer controlled Mux mode
TCM_EN: u1 = 0,
/// VMS_SEL [8:8]
/// OPAMP4 inverting input secondary
VMS_SEL: u1 = 0,
/// VPS_SEL [9:10]
/// OPAMP4 Non inverting input secondary
VPS_SEL: u2 = 0,
/// CALON [11:11]
/// Calibration mode enable
CALON: u1 = 0,
/// CALSEL [12:13]
/// Calibration selection
CALSEL: u2 = 0,
/// PGA_GAIN [14:17]
/// Gain in PGA mode
PGA_GAIN: u4 = 0,
/// USER_TRIM [18:18]
/// User trimming enable
USER_TRIM: u1 = 0,
/// TRIMOFFSETP [19:23]
/// Offset trimming value
TRIMOFFSETP: u5 = 0,
/// TRIMOFFSETN [24:28]
/// Offset trimming value
TRIMOFFSETN: u5 = 0,
/// TSTREF [29:29]
/// TSTREF
TSTREF: u1 = 0,
/// OUTCAL [30:30]
/// OPAMP 4 ouput status flag
OUTCAL: u1 = 0,
/// LOCK [31:31]
/// OPAMP 4 lock
LOCK: u1 = 0,
};
/// control register
pub const OPAMP4_CSR = Register(OPAMP4_CSR_val).init(base_address + 0x44);
};

/// Flexible memory controller
pub const FMC = struct {

const base_address = 0xa0000400;
/// BCR1
const BCR1_val = packed struct {
/// MBKEN [0:0]
/// MBKEN
MBKEN: u1 = 0,
/// MUXEN [1:1]
/// MUXEN
MUXEN: u1 = 0,
/// MTYP [2:3]
/// MTYP
MTYP: u2 = 0,
/// MWID [4:5]
/// MWID
MWID: u2 = 1,
/// FACCEN [6:6]
/// FACCEN
FACCEN: u1 = 1,
/// unused [7:7]
_unused7: u1 = 1,
/// BURSTEN [8:8]
/// BURSTEN
BURSTEN: u1 = 0,
/// WAITPOL [9:9]
/// WAITPOL
WAITPOL: u1 = 0,
/// unused [10:10]
_unused10: u1 = 0,
/// WAITCFG [11:11]
/// WAITCFG
WAITCFG: u1 = 0,
/// WREN [12:12]
/// WREN
WREN: u1 = 1,
/// WAITEN [13:13]
/// WAITEN
WAITEN: u1 = 1,
/// EXTMOD [14:14]
/// EXTMOD
EXTMOD: u1 = 0,
/// ASYNCWAIT [15:15]
/// ASYNCWAIT
ASYNCWAIT: u1 = 0,
/// unused [16:18]
_unused16: u3 = 0,
/// CBURSTRW [19:19]
/// CBURSTRW
CBURSTRW: u1 = 0,
/// CCLKEN [20:20]
/// CCLKEN
CCLKEN: u1 = 0,
/// unused [21:31]
_unused21: u3 = 0,
_unused24: u8 = 0,
};
/// SRAM/NOR-Flash chip-select control register
pub const BCR1 = Register(BCR1_val).init(base_address + 0x0);

/// BTR1
const BTR1_val = packed struct {
/// ADDSET [0:3]
/// ADDSET
ADDSET: u4 = 15,
/// ADDHLD [4:7]
/// ADDHLD
ADDHLD: u4 = 15,
/// DATAST [8:15]
/// DATAST
DATAST: u8 = 255,
/// BUSTURN [16:19]
/// BUSTURN
BUSTURN: u4 = 15,
/// CLKDIV [20:23]
/// CLKDIV
CLKDIV: u4 = 15,
/// DATLAT [24:27]
/// DATLAT
DATLAT: u4 = 15,
/// ACCMOD [28:29]
/// ACCMOD
ACCMOD: u2 = 3,
/// unused [30:31]
_unused30: u2 = 3,
};
/// SRAM/NOR-Flash chip-select timing register
pub const BTR1 = Register(BTR1_val).init(base_address + 0x4);

/// BCR2
const BCR2_val = packed struct {
/// MBKEN [0:0]
/// MBKEN
MBKEN: u1 = 0,
/// MUXEN [1:1]
/// MUXEN
MUXEN: u1 = 0,
/// MTYP [2:3]
/// MTYP
MTYP: u2 = 0,
/// MWID [4:5]
/// MWID
MWID: u2 = 1,
/// FACCEN [6:6]
/// FACCEN
FACCEN: u1 = 1,
/// unused [7:7]
_unused7: u1 = 1,
/// BURSTEN [8:8]
/// BURSTEN
BURSTEN: u1 = 0,
/// WAITPOL [9:9]
/// WAITPOL
WAITPOL: u1 = 0,
/// WRAPMOD [10:10]
/// WRAPMOD
WRAPMOD: u1 = 0,
/// WAITCFG [11:11]
/// WAITCFG
WAITCFG: u1 = 0,
/// WREN [12:12]
/// WREN
WREN: u1 = 1,
/// WAITEN [13:13]
/// WAITEN
WAITEN: u1 = 1,
/// EXTMOD [14:14]
/// EXTMOD
EXTMOD: u1 = 0,
/// ASYNCWAIT [15:15]
/// ASYNCWAIT
ASYNCWAIT: u1 = 0,
/// unused [16:18]
_unused16: u3 = 0,
/// CBURSTRW [19:19]
/// CBURSTRW
CBURSTRW: u1 = 0,
/// unused [20:31]
_unused20: u4 = 0,
_unused24: u8 = 0,
};
/// SRAM/NOR-Flash chip-select control register
pub const BCR2 = Register(BCR2_val).init(base_address + 0x8);

/// BTR2
const BTR2_val = packed struct {
/// ADDSET [0:3]
/// ADDSET
ADDSET: u4 = 15,
/// ADDHLD [4:7]
/// ADDHLD
ADDHLD: u4 = 15,
/// DATAST [8:15]
/// DATAST
DATAST: u8 = 255,
/// BUSTURN [16:19]
/// BUSTURN
BUSTURN: u4 = 15,
/// CLKDIV [20:23]
/// CLKDIV
CLKDIV: u4 = 15,
/// DATLAT [24:27]
/// DATLAT
DATLAT: u4 = 15,
/// ACCMOD [28:29]
/// ACCMOD
ACCMOD: u2 = 3,
/// unused [30:31]
_unused30: u2 = 3,
};
/// SRAM/NOR-Flash chip-select timing register
pub const BTR2 = Register(BTR2_val).init(base_address + 0xc);

/// BCR3
const BCR3_val = packed struct {
/// MBKEN [0:0]
/// MBKEN
MBKEN: u1 = 0,
/// MUXEN [1:1]
/// MUXEN
MUXEN: u1 = 0,
/// MTYP [2:3]
/// MTYP
MTYP: u2 = 0,
/// MWID [4:5]
/// MWID
MWID: u2 = 1,
/// FACCEN [6:6]
/// FACCEN
FACCEN: u1 = 1,
/// unused [7:7]
_unused7: u1 = 1,
/// BURSTEN [8:8]
/// BURSTEN
BURSTEN: u1 = 0,
/// WAITPOL [9:9]
/// WAITPOL
WAITPOL: u1 = 0,
/// WRAPMOD [10:10]
/// WRAPMOD
WRAPMOD: u1 = 0,
/// WAITCFG [11:11]
/// WAITCFG
WAITCFG: u1 = 0,
/// WREN [12:12]
/// WREN
WREN: u1 = 1,
/// WAITEN [13:13]
/// WAITEN
WAITEN: u1 = 1,
/// EXTMOD [14:14]
/// EXTMOD
EXTMOD: u1 = 0,
/// ASYNCWAIT [15:15]
/// ASYNCWAIT
ASYNCWAIT: u1 = 0,
/// unused [16:18]
_unused16: u3 = 0,
/// CBURSTRW [19:19]
/// CBURSTRW
CBURSTRW: u1 = 0,
/// unused [20:31]
_unused20: u4 = 0,
_unused24: u8 = 0,
};
/// SRAM/NOR-Flash chip-select control register
pub const BCR3 = Register(BCR3_val).init(base_address + 0x10);

/// BTR3
const BTR3_val = packed struct {
/// ADDSET [0:3]
/// ADDSET
ADDSET: u4 = 15,
/// ADDHLD [4:7]
/// ADDHLD
ADDHLD: u4 = 15,
/// DATAST [8:15]
/// DATAST
DATAST: u8 = 255,
/// BUSTURN [16:19]
/// BUSTURN
BUSTURN: u4 = 15,
/// CLKDIV [20:23]
/// CLKDIV
CLKDIV: u4 = 15,
/// DATLAT [24:27]
/// DATLAT
DATLAT: u4 = 15,
/// ACCMOD [28:29]
/// ACCMOD
ACCMOD: u2 = 3,
/// unused [30:31]
_unused30: u2 = 3,
};
/// SRAM/NOR-Flash chip-select timing register
pub const BTR3 = Register(BTR3_val).init(base_address + 0x14);

/// BCR4
const BCR4_val = packed struct {
/// MBKEN [0:0]
/// MBKEN
MBKEN: u1 = 0,
/// MUXEN [1:1]
/// MUXEN
MUXEN: u1 = 0,
/// MTYP [2:3]
/// MTYP
MTYP: u2 = 0,
/// MWID [4:5]
/// MWID
MWID: u2 = 1,
/// FACCEN [6:6]
/// FACCEN
FACCEN: u1 = 1,
/// unused [7:7]
_unused7: u1 = 1,
/// BURSTEN [8:8]
/// BURSTEN
BURSTEN: u1 = 0,
/// WAITPOL [9:9]
/// WAITPOL
WAITPOL: u1 = 0,
/// WRAPMOD [10:10]
/// WRAPMOD
WRAPMOD: u1 = 0,
/// WAITCFG [11:11]
/// WAITCFG
WAITCFG: u1 = 0,
/// WREN [12:12]
/// WREN
WREN: u1 = 1,
/// WAITEN [13:13]
/// WAITEN
WAITEN: u1 = 1,
/// EXTMOD [14:14]
/// EXTMOD
EXTMOD: u1 = 0,
/// ASYNCWAIT [15:15]
/// ASYNCWAIT
ASYNCWAIT: u1 = 0,
/// unused [16:18]
_unused16: u3 = 0,
/// CBURSTRW [19:19]
/// CBURSTRW
CBURSTRW: u1 = 0,
/// unused [20:31]
_unused20: u4 = 0,
_unused24: u8 = 0,
};
/// SRAM/NOR-Flash chip-select control register
pub const BCR4 = Register(BCR4_val).init(base_address + 0x18);

/// BTR4
const BTR4_val = packed struct {
/// ADDSET [0:3]
/// ADDSET
ADDSET: u4 = 15,
/// ADDHLD [4:7]
/// ADDHLD
ADDHLD: u4 = 15,
/// DATAST [8:15]
/// DATAST
DATAST: u8 = 255,
/// BUSTURN [16:19]
/// BUSTURN
BUSTURN: u4 = 15,
/// CLKDIV [20:23]
/// CLKDIV
CLKDIV: u4 = 15,
/// DATLAT [24:27]
/// DATLAT
DATLAT: u4 = 15,
/// ACCMOD [28:29]
/// ACCMOD
ACCMOD: u2 = 3,
/// unused [30:31]
_unused30: u2 = 3,
};
/// SRAM/NOR-Flash chip-select timing register
pub const BTR4 = Register(BTR4_val).init(base_address + 0x1c);

/// PCR2
const PCR2_val = packed struct {
/// unused [0:0]
_unused0: u1 = 0,
/// PWAITEN [1:1]
/// PWAITEN
PWAITEN: u1 = 0,
/// PBKEN [2:2]
/// PBKEN
PBKEN: u1 = 0,
/// PTYP [3:3]
/// PTYP
PTYP: u1 = 1,
/// PWID [4:5]
/// PWID
PWID: u2 = 1,
/// ECCEN [6:6]
/// ECCEN
ECCEN: u1 = 0,
/// unused [7:8]
_unused7: u1 = 0,
_unused8: u1 = 0,
/// TCLR [9:12]
/// TCLR
TCLR: u4 = 0,
/// TAR [13:16]
/// TAR
TAR: u4 = 0,
/// ECCPS [17:19]
/// ECCPS
ECCPS: u3 = 0,
/// unused [20:31]
_unused20: u4 = 0,
_unused24: u8 = 0,
};
/// PC Card/NAND Flash control register
pub const PCR2 = Register(PCR2_val).init(base_address + 0x60);

/// SR2
const SR2_val = packed struct {
/// IRS [0:0]
/// IRS
IRS: u1 = 0,
/// ILS [1:1]
/// ILS
ILS: u1 = 0,
/// IFS [2:2]
/// IFS
IFS: u1 = 0,
/// IREN [3:3]
/// IREN
IREN: u1 = 0,
/// ILEN [4:4]
/// ILEN
ILEN: u1 = 0,
/// IFEN [5:5]
/// IFEN
IFEN: u1 = 0,
/// FEMPT [6:6]
/// FEMPT
FEMPT: u1 = 1,
/// unused [7:31]
_unused7: u1 = 0,
_unused8: u8 = 0,
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// FIFO status and interrupt register
pub const SR2 = Register(SR2_val).init(base_address + 0x64);

/// PMEM2
const PMEM2_val = packed struct {
/// MEMSETx [0:7]
/// MEMSETx
MEMSETx: u8 = 252,
/// MEMWAITx [8:15]
/// MEMWAITx
MEMWAITx: u8 = 252,
/// MEMHOLDx [16:23]
/// MEMHOLDx
MEMHOLDx: u8 = 252,
/// MEMHIZx [24:31]
/// MEMHIZx
MEMHIZx: u8 = 252,
};
/// Common memory space timing register
pub const PMEM2 = Register(PMEM2_val).init(base_address + 0x68);

/// PATT2
const PATT2_val = packed struct {
/// ATTSETx [0:7]
/// ATTSETx
ATTSETx: u8 = 252,
/// ATTWAITx [8:15]
/// ATTWAITx
ATTWAITx: u8 = 252,
/// ATTHOLDx [16:23]
/// ATTHOLDx
ATTHOLDx: u8 = 252,
/// ATTHIZx [24:31]
/// ATTHIZx
ATTHIZx: u8 = 252,
};
/// Attribute memory space timing register
pub const PATT2 = Register(PATT2_val).init(base_address + 0x6c);

/// ECCR2
const ECCR2_val = packed struct {
/// ECCx [0:31]
/// ECCx
ECCx: u32 = 0,
};
/// ECC result register 2
pub const ECCR2 = Register(ECCR2_val).init(base_address + 0x74);

/// PCR3
const PCR3_val = packed struct {
/// unused [0:0]
_unused0: u1 = 0,
/// PWAITEN [1:1]
/// PWAITEN
PWAITEN: u1 = 0,
/// PBKEN [2:2]
/// PBKEN
PBKEN: u1 = 0,
/// PTYP [3:3]
/// PTYP
PTYP: u1 = 1,
/// PWID [4:5]
/// PWID
PWID: u2 = 1,
/// ECCEN [6:6]
/// ECCEN
ECCEN: u1 = 0,
/// unused [7:8]
_unused7: u1 = 0,
_unused8: u1 = 0,
/// TCLR [9:12]
/// TCLR
TCLR: u4 = 0,
/// TAR [13:16]
/// TAR
TAR: u4 = 0,
/// ECCPS [17:19]
/// ECCPS
ECCPS: u3 = 0,
/// unused [20:31]
_unused20: u4 = 0,
_unused24: u8 = 0,
};
/// PC Card/NAND Flash control register
pub const PCR3 = Register(PCR3_val).init(base_address + 0x80);

/// SR3
const SR3_val = packed struct {
/// IRS [0:0]
/// IRS
IRS: u1 = 0,
/// ILS [1:1]
/// ILS
ILS: u1 = 0,
/// IFS [2:2]
/// IFS
IFS: u1 = 0,
/// IREN [3:3]
/// IREN
IREN: u1 = 0,
/// ILEN [4:4]
/// ILEN
ILEN: u1 = 0,
/// IFEN [5:5]
/// IFEN
IFEN: u1 = 0,
/// FEMPT [6:6]
/// FEMPT
FEMPT: u1 = 1,
/// unused [7:31]
_unused7: u1 = 0,
_unused8: u8 = 0,
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// FIFO status and interrupt register
pub const SR3 = Register(SR3_val).init(base_address + 0x84);

/// PMEM3
const PMEM3_val = packed struct {
/// MEMSETx [0:7]
/// MEMSETx
MEMSETx: u8 = 252,
/// MEMWAITx [8:15]
/// MEMWAITx
MEMWAITx: u8 = 252,
/// MEMHOLDx [16:23]
/// MEMHOLDx
MEMHOLDx: u8 = 252,
/// MEMHIZx [24:31]
/// MEMHIZx
MEMHIZx: u8 = 252,
};
/// Common memory space timing register
pub const PMEM3 = Register(PMEM3_val).init(base_address + 0x88);

/// PATT3
const PATT3_val = packed struct {
/// ATTSETx [0:7]
/// ATTSETx
ATTSETx: u8 = 252,
/// ATTWAITx [8:15]
/// ATTWAITx
ATTWAITx: u8 = 252,
/// ATTHOLDx [16:23]
/// ATTHOLDx
ATTHOLDx: u8 = 252,
/// ATTHIZx [24:31]
/// ATTHIZx
ATTHIZx: u8 = 252,
};
/// Attribute memory space timing register
pub const PATT3 = Register(PATT3_val).init(base_address + 0x8c);

/// ECCR3
const ECCR3_val = packed struct {
/// ECCx [0:31]
/// ECCx
ECCx: u32 = 0,
};
/// ECC result register 3
pub const ECCR3 = Register(ECCR3_val).init(base_address + 0x94);

/// PCR4
const PCR4_val = packed struct {
/// unused [0:0]
_unused0: u1 = 0,
/// PWAITEN [1:1]
/// PWAITEN
PWAITEN: u1 = 0,
/// PBKEN [2:2]
/// PBKEN
PBKEN: u1 = 0,
/// PTYP [3:3]
/// PTYP
PTYP: u1 = 1,
/// PWID [4:5]
/// PWID
PWID: u2 = 1,
/// ECCEN [6:6]
/// ECCEN
ECCEN: u1 = 0,
/// unused [7:8]
_unused7: u1 = 0,
_unused8: u1 = 0,
/// TCLR [9:12]
/// TCLR
TCLR: u4 = 0,
/// TAR [13:16]
/// TAR
TAR: u4 = 0,
/// ECCPS [17:19]
/// ECCPS
ECCPS: u3 = 0,
/// unused [20:31]
_unused20: u4 = 0,
_unused24: u8 = 0,
};
/// PC Card/NAND Flash control register
pub const PCR4 = Register(PCR4_val).init(base_address + 0xa0);

/// SR4
const SR4_val = packed struct {
/// IRS [0:0]
/// IRS
IRS: u1 = 0,
/// ILS [1:1]
/// ILS
ILS: u1 = 0,
/// IFS [2:2]
/// IFS
IFS: u1 = 0,
/// IREN [3:3]
/// IREN
IREN: u1 = 0,
/// ILEN [4:4]
/// ILEN
ILEN: u1 = 0,
/// IFEN [5:5]
/// IFEN
IFEN: u1 = 0,
/// FEMPT [6:6]
/// FEMPT
FEMPT: u1 = 1,
/// unused [7:31]
_unused7: u1 = 0,
_unused8: u8 = 0,
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// FIFO status and interrupt register
pub const SR4 = Register(SR4_val).init(base_address + 0xa4);

/// PMEM4
const PMEM4_val = packed struct {
/// MEMSETx [0:7]
/// MEMSETx
MEMSETx: u8 = 252,
/// MEMWAITx [8:15]
/// MEMWAITx
MEMWAITx: u8 = 252,
/// MEMHOLDx [16:23]
/// MEMHOLDx
MEMHOLDx: u8 = 252,
/// MEMHIZx [24:31]
/// MEMHIZx
MEMHIZx: u8 = 252,
};
/// Common memory space timing register
pub const PMEM4 = Register(PMEM4_val).init(base_address + 0xa8);

/// PATT4
const PATT4_val = packed struct {
/// ATTSETx [0:7]
/// ATTSETx
ATTSETx: u8 = 252,
/// ATTWAITx [8:15]
/// ATTWAITx
ATTWAITx: u8 = 252,
/// ATTHOLDx [16:23]
/// ATTHOLDx
ATTHOLDx: u8 = 252,
/// ATTHIZx [24:31]
/// ATTHIZx
ATTHIZx: u8 = 252,
};
/// Attribute memory space timing register
pub const PATT4 = Register(PATT4_val).init(base_address + 0xac);

/// PIO4
const PIO4_val = packed struct {
/// IOSETx [0:7]
/// IOSETx
IOSETx: u8 = 252,
/// IOWAITx [8:15]
/// IOWAITx
IOWAITx: u8 = 252,
/// IOHOLDx [16:23]
/// IOHOLDx
IOHOLDx: u8 = 252,
/// IOHIZx [24:31]
/// IOHIZx
IOHIZx: u8 = 252,
};
/// I/O space timing register 4
pub const PIO4 = Register(PIO4_val).init(base_address + 0xb0);

/// BWTR1
const BWTR1_val = packed struct {
/// ADDSET [0:3]
/// ADDSET
ADDSET: u4 = 15,
/// ADDHLD [4:7]
/// ADDHLD
ADDHLD: u4 = 15,
/// DATAST [8:15]
/// DATAST
DATAST: u8 = 255,
/// BUSTURN [16:19]
/// Bus turnaround phase
BUSTURN: u4 = 15,
/// CLKDIV [20:23]
/// CLKDIV
CLKDIV: u4 = 15,
/// DATLAT [24:27]
/// DATLAT
DATLAT: u4 = 15,
/// ACCMOD [28:29]
/// ACCMOD
ACCMOD: u2 = 0,
/// unused [30:31]
_unused30: u2 = 0,
};
/// SRAM/NOR-Flash write timing registers
pub const BWTR1 = Register(BWTR1_val).init(base_address + 0x104);

/// BWTR2
const BWTR2_val = packed struct {
/// ADDSET [0:3]
/// ADDSET
ADDSET: u4 = 15,
/// ADDHLD [4:7]
/// ADDHLD
ADDHLD: u4 = 15,
/// DATAST [8:15]
/// DATAST
DATAST: u8 = 255,
/// BUSTURN [16:19]
/// Bus turnaround phase
BUSTURN: u4 = 15,
/// CLKDIV [20:23]
/// CLKDIV
CLKDIV: u4 = 15,
/// DATLAT [24:27]
/// DATLAT
DATLAT: u4 = 15,
/// ACCMOD [28:29]
/// ACCMOD
ACCMOD: u2 = 0,
/// unused [30:31]
_unused30: u2 = 0,
};
/// SRAM/NOR-Flash write timing registers
pub const BWTR2 = Register(BWTR2_val).init(base_address + 0x10c);

/// BWTR3
const BWTR3_val = packed struct {
/// ADDSET [0:3]
/// ADDSET
ADDSET: u4 = 15,
/// ADDHLD [4:7]
/// ADDHLD
ADDHLD: u4 = 15,
/// DATAST [8:15]
/// DATAST
DATAST: u8 = 255,
/// BUSTURN [16:19]
/// Bus turnaround phase
BUSTURN: u4 = 15,
/// CLKDIV [20:23]
/// CLKDIV
CLKDIV: u4 = 15,
/// DATLAT [24:27]
/// DATLAT
DATLAT: u4 = 15,
/// ACCMOD [28:29]
/// ACCMOD
ACCMOD: u2 = 0,
/// unused [30:31]
_unused30: u2 = 0,
};
/// SRAM/NOR-Flash write timing registers
pub const BWTR3 = Register(BWTR3_val).init(base_address + 0x114);

/// BWTR4
const BWTR4_val = packed struct {
/// ADDSET [0:3]
/// ADDSET
ADDSET: u4 = 15,
/// ADDHLD [4:7]
/// ADDHLD
ADDHLD: u4 = 15,
/// DATAST [8:15]
/// DATAST
DATAST: u8 = 255,
/// BUSTURN [16:19]
/// Bus turnaround phase
BUSTURN: u4 = 15,
/// CLKDIV [20:23]
/// CLKDIV
CLKDIV: u4 = 15,
/// DATLAT [24:27]
/// DATLAT
DATLAT: u4 = 15,
/// ACCMOD [28:29]
/// ACCMOD
ACCMOD: u2 = 0,
/// unused [30:31]
_unused30: u2 = 0,
};
/// SRAM/NOR-Flash write timing registers
pub const BWTR4 = Register(BWTR4_val).init(base_address + 0x11c);
};

/// Nested Vectored Interrupt
pub const NVIC = struct {

const base_address = 0xe000e100;
/// ISER0
const ISER0_val = packed struct {
/// SETENA [0:31]
/// SETENA
SETENA: u32 = 0,
};
/// Interrupt Set-Enable Register
pub const ISER0 = Register(ISER0_val).init(base_address + 0x0);

/// ISER1
const ISER1_val = packed struct {
/// SETENA [0:31]
/// SETENA
SETENA: u32 = 0,
};
/// Interrupt Set-Enable Register
pub const ISER1 = Register(ISER1_val).init(base_address + 0x4);

/// ISER2
const ISER2_val = packed struct {
/// SETENA [0:31]
/// SETENA
SETENA: u32 = 0,
};
/// Interrupt Set-Enable Register
pub const ISER2 = Register(ISER2_val).init(base_address + 0x8);

/// ICER0
const ICER0_val = packed struct {
/// CLRENA [0:31]
/// CLRENA
CLRENA: u32 = 0,
};
/// Interrupt Clear-Enable
pub const ICER0 = Register(ICER0_val).init(base_address + 0x80);

/// ICER1
const ICER1_val = packed struct {
/// CLRENA [0:31]
/// CLRENA
CLRENA: u32 = 0,
};
/// Interrupt Clear-Enable
pub const ICER1 = Register(ICER1_val).init(base_address + 0x84);

/// ICER2
const ICER2_val = packed struct {
/// CLRENA [0:31]
/// CLRENA
CLRENA: u32 = 0,
};
/// Interrupt Clear-Enable
pub const ICER2 = Register(ICER2_val).init(base_address + 0x88);

/// ISPR0
const ISPR0_val = packed struct {
/// SETPEND [0:31]
/// SETPEND
SETPEND: u32 = 0,
};
/// Interrupt Set-Pending Register
pub const ISPR0 = Register(ISPR0_val).init(base_address + 0x100);

/// ISPR1
const ISPR1_val = packed struct {
/// SETPEND [0:31]
/// SETPEND
SETPEND: u32 = 0,
};
/// Interrupt Set-Pending Register
pub const ISPR1 = Register(ISPR1_val).init(base_address + 0x104);

/// ISPR2
const ISPR2_val = packed struct {
/// SETPEND [0:31]
/// SETPEND
SETPEND: u32 = 0,
};
/// Interrupt Set-Pending Register
pub const ISPR2 = Register(ISPR2_val).init(base_address + 0x108);

/// ICPR0
const ICPR0_val = packed struct {
/// CLRPEND [0:31]
/// CLRPEND
CLRPEND: u32 = 0,
};
/// Interrupt Clear-Pending
pub const ICPR0 = Register(ICPR0_val).init(base_address + 0x180);

/// ICPR1
const ICPR1_val = packed struct {
/// CLRPEND [0:31]
/// CLRPEND
CLRPEND: u32 = 0,
};
/// Interrupt Clear-Pending
pub const ICPR1 = Register(ICPR1_val).init(base_address + 0x184);

/// ICPR2
const ICPR2_val = packed struct {
/// CLRPEND [0:31]
/// CLRPEND
CLRPEND: u32 = 0,
};
/// Interrupt Clear-Pending
pub const ICPR2 = Register(ICPR2_val).init(base_address + 0x188);

/// IABR0
const IABR0_val = packed struct {
/// ACTIVE [0:31]
/// ACTIVE
ACTIVE: u32 = 0,
};
/// Interrupt Active Bit Register
pub const IABR0 = Register(IABR0_val).init(base_address + 0x200);

/// IABR1
const IABR1_val = packed struct {
/// ACTIVE [0:31]
/// ACTIVE
ACTIVE: u32 = 0,
};
/// Interrupt Active Bit Register
pub const IABR1 = Register(IABR1_val).init(base_address + 0x204);

/// IABR2
const IABR2_val = packed struct {
/// ACTIVE [0:31]
/// ACTIVE
ACTIVE: u32 = 0,
};
/// Interrupt Active Bit Register
pub const IABR2 = Register(IABR2_val).init(base_address + 0x208);

/// IPR0
const IPR0_val = packed struct {
/// IPR_N0 [0:7]
/// IPR_N0
IPR_N0: u8 = 0,
/// IPR_N1 [8:15]
/// IPR_N1
IPR_N1: u8 = 0,
/// IPR_N2 [16:23]
/// IPR_N2
IPR_N2: u8 = 0,
/// IPR_N3 [24:31]
/// IPR_N3
IPR_N3: u8 = 0,
};
/// Interrupt Priority Register
pub const IPR0 = Register(IPR0_val).init(base_address + 0x300);

/// IPR1
const IPR1_val = packed struct {
/// IPR_N0 [0:7]
/// IPR_N0
IPR_N0: u8 = 0,
/// IPR_N1 [8:15]
/// IPR_N1
IPR_N1: u8 = 0,
/// IPR_N2 [16:23]
/// IPR_N2
IPR_N2: u8 = 0,
/// IPR_N3 [24:31]
/// IPR_N3
IPR_N3: u8 = 0,
};
/// Interrupt Priority Register
pub const IPR1 = Register(IPR1_val).init(base_address + 0x304);

/// IPR2
const IPR2_val = packed struct {
/// IPR_N0 [0:7]
/// IPR_N0
IPR_N0: u8 = 0,
/// IPR_N1 [8:15]
/// IPR_N1
IPR_N1: u8 = 0,
/// IPR_N2 [16:23]
/// IPR_N2
IPR_N2: u8 = 0,
/// IPR_N3 [24:31]
/// IPR_N3
IPR_N3: u8 = 0,
};
/// Interrupt Priority Register
pub const IPR2 = Register(IPR2_val).init(base_address + 0x308);

/// IPR3
const IPR3_val = packed struct {
/// IPR_N0 [0:7]
/// IPR_N0
IPR_N0: u8 = 0,
/// IPR_N1 [8:15]
/// IPR_N1
IPR_N1: u8 = 0,
/// IPR_N2 [16:23]
/// IPR_N2
IPR_N2: u8 = 0,
/// IPR_N3 [24:31]
/// IPR_N3
IPR_N3: u8 = 0,
};
/// Interrupt Priority Register
pub const IPR3 = Register(IPR3_val).init(base_address + 0x30c);

/// IPR4
const IPR4_val = packed struct {
/// IPR_N0 [0:7]
/// IPR_N0
IPR_N0: u8 = 0,
/// IPR_N1 [8:15]
/// IPR_N1
IPR_N1: u8 = 0,
/// IPR_N2 [16:23]
/// IPR_N2
IPR_N2: u8 = 0,
/// IPR_N3 [24:31]
/// IPR_N3
IPR_N3: u8 = 0,
};
/// Interrupt Priority Register
pub const IPR4 = Register(IPR4_val).init(base_address + 0x310);

/// IPR5
const IPR5_val = packed struct {
/// IPR_N0 [0:7]
/// IPR_N0
IPR_N0: u8 = 0,
/// IPR_N1 [8:15]
/// IPR_N1
IPR_N1: u8 = 0,
/// IPR_N2 [16:23]
/// IPR_N2
IPR_N2: u8 = 0,
/// IPR_N3 [24:31]
/// IPR_N3
IPR_N3: u8 = 0,
};
/// Interrupt Priority Register
pub const IPR5 = Register(IPR5_val).init(base_address + 0x314);

/// IPR6
const IPR6_val = packed struct {
/// IPR_N0 [0:7]
/// IPR_N0
IPR_N0: u8 = 0,
/// IPR_N1 [8:15]
/// IPR_N1
IPR_N1: u8 = 0,
/// IPR_N2 [16:23]
/// IPR_N2
IPR_N2: u8 = 0,
/// IPR_N3 [24:31]
/// IPR_N3
IPR_N3: u8 = 0,
};
/// Interrupt Priority Register
pub const IPR6 = Register(IPR6_val).init(base_address + 0x318);

/// IPR7
const IPR7_val = packed struct {
/// IPR_N0 [0:7]
/// IPR_N0
IPR_N0: u8 = 0,
/// IPR_N1 [8:15]
/// IPR_N1
IPR_N1: u8 = 0,
/// IPR_N2 [16:23]
/// IPR_N2
IPR_N2: u8 = 0,
/// IPR_N3 [24:31]
/// IPR_N3
IPR_N3: u8 = 0,
};
/// Interrupt Priority Register
pub const IPR7 = Register(IPR7_val).init(base_address + 0x31c);

/// IPR8
const IPR8_val = packed struct {
/// IPR_N0 [0:7]
/// IPR_N0
IPR_N0: u8 = 0,
/// IPR_N1 [8:15]
/// IPR_N1
IPR_N1: u8 = 0,
/// IPR_N2 [16:23]
/// IPR_N2
IPR_N2: u8 = 0,
/// IPR_N3 [24:31]
/// IPR_N3
IPR_N3: u8 = 0,
};
/// Interrupt Priority Register
pub const IPR8 = Register(IPR8_val).init(base_address + 0x320);

/// IPR9
const IPR9_val = packed struct {
/// IPR_N0 [0:7]
/// IPR_N0
IPR_N0: u8 = 0,
/// IPR_N1 [8:15]
/// IPR_N1
IPR_N1: u8 = 0,
/// IPR_N2 [16:23]
/// IPR_N2
IPR_N2: u8 = 0,
/// IPR_N3 [24:31]
/// IPR_N3
IPR_N3: u8 = 0,
};
/// Interrupt Priority Register
pub const IPR9 = Register(IPR9_val).init(base_address + 0x324);

/// IPR10
const IPR10_val = packed struct {
/// IPR_N0 [0:7]
/// IPR_N0
IPR_N0: u8 = 0,
/// IPR_N1 [8:15]
/// IPR_N1
IPR_N1: u8 = 0,
/// IPR_N2 [16:23]
/// IPR_N2
IPR_N2: u8 = 0,
/// IPR_N3 [24:31]
/// IPR_N3
IPR_N3: u8 = 0,
};
/// Interrupt Priority Register
pub const IPR10 = Register(IPR10_val).init(base_address + 0x328);

/// IPR11
const IPR11_val = packed struct {
/// IPR_N0 [0:7]
/// IPR_N0
IPR_N0: u8 = 0,
/// IPR_N1 [8:15]
/// IPR_N1
IPR_N1: u8 = 0,
/// IPR_N2 [16:23]
/// IPR_N2
IPR_N2: u8 = 0,
/// IPR_N3 [24:31]
/// IPR_N3
IPR_N3: u8 = 0,
};
/// Interrupt Priority Register
pub const IPR11 = Register(IPR11_val).init(base_address + 0x32c);

/// IPR12
const IPR12_val = packed struct {
/// IPR_N0 [0:7]
/// IPR_N0
IPR_N0: u8 = 0,
/// IPR_N1 [8:15]
/// IPR_N1
IPR_N1: u8 = 0,
/// IPR_N2 [16:23]
/// IPR_N2
IPR_N2: u8 = 0,
/// IPR_N3 [24:31]
/// IPR_N3
IPR_N3: u8 = 0,
};
/// Interrupt Priority Register
pub const IPR12 = Register(IPR12_val).init(base_address + 0x330);

/// IPR13
const IPR13_val = packed struct {
/// IPR_N0 [0:7]
/// IPR_N0
IPR_N0: u8 = 0,
/// IPR_N1 [8:15]
/// IPR_N1
IPR_N1: u8 = 0,
/// IPR_N2 [16:23]
/// IPR_N2
IPR_N2: u8 = 0,
/// IPR_N3 [24:31]
/// IPR_N3
IPR_N3: u8 = 0,
};
/// Interrupt Priority Register
pub const IPR13 = Register(IPR13_val).init(base_address + 0x334);

/// IPR14
const IPR14_val = packed struct {
/// IPR_N0 [0:7]
/// IPR_N0
IPR_N0: u8 = 0,
/// IPR_N1 [8:15]
/// IPR_N1
IPR_N1: u8 = 0,
/// IPR_N2 [16:23]
/// IPR_N2
IPR_N2: u8 = 0,
/// IPR_N3 [24:31]
/// IPR_N3
IPR_N3: u8 = 0,
};
/// Interrupt Priority Register
pub const IPR14 = Register(IPR14_val).init(base_address + 0x338);

/// IPR15
const IPR15_val = packed struct {
/// IPR_N0 [0:7]
/// IPR_N0
IPR_N0: u8 = 0,
/// IPR_N1 [8:15]
/// IPR_N1
IPR_N1: u8 = 0,
/// IPR_N2 [16:23]
/// IPR_N2
IPR_N2: u8 = 0,
/// IPR_N3 [24:31]
/// IPR_N3
IPR_N3: u8 = 0,
};
/// Interrupt Priority Register
pub const IPR15 = Register(IPR15_val).init(base_address + 0x33c);

/// IPR16
const IPR16_val = packed struct {
/// IPR_N0 [0:7]
/// IPR_N0
IPR_N0: u8 = 0,
/// IPR_N1 [8:15]
/// IPR_N1
IPR_N1: u8 = 0,
/// IPR_N2 [16:23]
/// IPR_N2
IPR_N2: u8 = 0,
/// IPR_N3 [24:31]
/// IPR_N3
IPR_N3: u8 = 0,
};
/// Interrupt Priority Register
pub const IPR16 = Register(IPR16_val).init(base_address + 0x340);

/// IPR17
const IPR17_val = packed struct {
/// IPR_N0 [0:7]
/// IPR_N0
IPR_N0: u8 = 0,
/// IPR_N1 [8:15]
/// IPR_N1
IPR_N1: u8 = 0,
/// IPR_N2 [16:23]
/// IPR_N2
IPR_N2: u8 = 0,
/// IPR_N3 [24:31]
/// IPR_N3
IPR_N3: u8 = 0,
};
/// Interrupt Priority Register
pub const IPR17 = Register(IPR17_val).init(base_address + 0x344);

/// IPR18
const IPR18_val = packed struct {
/// IPR_N0 [0:7]
/// IPR_N0
IPR_N0: u8 = 0,
/// IPR_N1 [8:15]
/// IPR_N1
IPR_N1: u8 = 0,
/// IPR_N2 [16:23]
/// IPR_N2
IPR_N2: u8 = 0,
/// IPR_N3 [24:31]
/// IPR_N3
IPR_N3: u8 = 0,
};
/// Interrupt Priority Register
pub const IPR18 = Register(IPR18_val).init(base_address + 0x348);

/// IPR19
const IPR19_val = packed struct {
/// IPR_N0 [0:7]
/// IPR_N0
IPR_N0: u8 = 0,
/// IPR_N1 [8:15]
/// IPR_N1
IPR_N1: u8 = 0,
/// IPR_N2 [16:23]
/// IPR_N2
IPR_N2: u8 = 0,
/// IPR_N3 [24:31]
/// IPR_N3
IPR_N3: u8 = 0,
};
/// Interrupt Priority Register
pub const IPR19 = Register(IPR19_val).init(base_address + 0x34c);

/// IPR20
const IPR20_val = packed struct {
/// IPR_N0 [0:7]
/// IPR_N0
IPR_N0: u8 = 0,
/// IPR_N1 [8:15]
/// IPR_N1
IPR_N1: u8 = 0,
/// IPR_N2 [16:23]
/// IPR_N2
IPR_N2: u8 = 0,
/// IPR_N3 [24:31]
/// IPR_N3
IPR_N3: u8 = 0,
};
/// Interrupt Priority Register
pub const IPR20 = Register(IPR20_val).init(base_address + 0x350);
};

/// Floting point unit
pub const FPU = struct {

const base_address = 0xe000ef34;
/// FPCCR
const FPCCR_val = packed struct {
/// LSPACT [0:0]
/// LSPACT
LSPACT: u1 = 0,
/// USER [1:1]
/// USER
USER: u1 = 0,
/// unused [2:2]
_unused2: u1 = 0,
/// THREAD [3:3]
/// THREAD
THREAD: u1 = 0,
/// HFRDY [4:4]
/// HFRDY
HFRDY: u1 = 0,
/// MMRDY [5:5]
/// MMRDY
MMRDY: u1 = 0,
/// BFRDY [6:6]
/// BFRDY
BFRDY: u1 = 0,
/// unused [7:7]
_unused7: u1 = 0,
/// MONRDY [8:8]
/// MONRDY
MONRDY: u1 = 0,
/// unused [9:29]
_unused9: u7 = 0,
_unused16: u8 = 0,
_unused24: u6 = 0,
/// LSPEN [30:30]
/// LSPEN
LSPEN: u1 = 0,
/// ASPEN [31:31]
/// ASPEN
ASPEN: u1 = 0,
};
/// Floating-point context control
pub const FPCCR = Register(FPCCR_val).init(base_address + 0x0);

/// FPCAR
const FPCAR_val = packed struct {
/// unused [0:2]
_unused0: u3 = 0,
/// ADDRESS [3:31]
/// Location of unpopulated
ADDRESS: u29 = 0,
};
/// Floating-point context address
pub const FPCAR = Register(FPCAR_val).init(base_address + 0x4);

/// FPSCR
const FPSCR_val = packed struct {
/// IOC [0:0]
/// Invalid operation cumulative exception
IOC: u1 = 0,
/// DZC [1:1]
/// Division by zero cumulative exception
DZC: u1 = 0,
/// OFC [2:2]
/// Overflow cumulative exception
OFC: u1 = 0,
/// UFC [3:3]
/// Underflow cumulative exception
UFC: u1 = 0,
/// IXC [4:4]
/// Inexact cumulative exception
IXC: u1 = 0,
/// unused [5:6]
_unused5: u2 = 0,
/// IDC [7:7]
/// Input denormal cumulative exception
IDC: u1 = 0,
/// unused [8:21]
_unused8: u8 = 0,
_unused16: u6 = 0,
/// RMode [22:23]
/// Rounding Mode control
RMode: u2 = 0,
/// FZ [24:24]
/// Flush-to-zero mode control
FZ: u1 = 0,
/// DN [25:25]
/// Default NaN mode control
DN: u1 = 0,
/// AHP [26:26]
/// Alternative half-precision control
AHP: u1 = 0,
/// unused [27:27]
_unused27: u1 = 0,
/// V [28:28]
/// Overflow condition code
V: u1 = 0,
/// C [29:29]
/// Carry condition code flag
C: u1 = 0,
/// Z [30:30]
/// Zero condition code flag
Z: u1 = 0,
/// N [31:31]
/// Negative condition code
N: u1 = 0,
};
/// Floating-point status control
pub const FPSCR = Register(FPSCR_val).init(base_address + 0x8);
};

/// Memory protection unit
pub const MPU = struct {

const base_address = 0xe000ed90;
/// MPU_TYPER
const MPU_TYPER_val = packed struct {
/// SEPARATE [0:0]
/// Separate flag
SEPARATE: u1 = 0,
/// unused [1:7]
_unused1: u7 = 0,
/// DREGION [8:15]
/// Number of MPU data regions
DREGION: u8 = 8,
/// IREGION [16:23]
/// Number of MPU instruction
IREGION: u8 = 0,
/// unused [24:31]
_unused24: u8 = 0,
};
/// MPU type register
pub const MPU_TYPER = Register(MPU_TYPER_val).init(base_address + 0x0);

/// MPU_CTRL
const MPU_CTRL_val = packed struct {
/// ENABLE [0:0]
/// Enables the MPU
ENABLE: u1 = 0,
/// HFNMIENA [1:1]
/// Enables the operation of MPU during hard
HFNMIENA: u1 = 0,
/// PRIVDEFENA [2:2]
/// Enable priviliged software access to
PRIVDEFENA: u1 = 0,
/// unused [3:31]
_unused3: u5 = 0,
_unused8: u8 = 0,
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// MPU control register
pub const MPU_CTRL = Register(MPU_CTRL_val).init(base_address + 0x4);

/// MPU_RNR
const MPU_RNR_val = packed struct {
/// REGION [0:7]
/// MPU region
REGION: u8 = 0,
/// unused [8:31]
_unused8: u8 = 0,
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// MPU region number register
pub const MPU_RNR = Register(MPU_RNR_val).init(base_address + 0x8);

/// MPU_RBAR
const MPU_RBAR_val = packed struct {
/// REGION [0:3]
/// MPU region field
REGION: u4 = 0,
/// VALID [4:4]
/// MPU region number valid
VALID: u1 = 0,
/// ADDR [5:31]
/// Region base address field
ADDR: u27 = 0,
};
/// MPU region base address
pub const MPU_RBAR = Register(MPU_RBAR_val).init(base_address + 0xc);

/// MPU_RASR
const MPU_RASR_val = packed struct {
/// ENABLE [0:0]
/// Region enable bit.
ENABLE: u1 = 0,
/// SIZE [1:5]
/// Size of the MPU protection
SIZE: u5 = 0,
/// unused [6:7]
_unused6: u2 = 0,
/// SRD [8:15]
/// Subregion disable bits
SRD: u8 = 0,
/// B [16:16]
/// memory attribute
B: u1 = 0,
/// C [17:17]
/// memory attribute
C: u1 = 0,
/// S [18:18]
/// Shareable memory attribute
S: u1 = 0,
/// TEX [19:21]
/// memory attribute
TEX: u3 = 0,
/// unused [22:23]
_unused22: u2 = 0,
/// AP [24:26]
/// Access permission
AP: u3 = 0,
/// unused [27:27]
_unused27: u1 = 0,
/// XN [28:28]
/// Instruction access disable
XN: u1 = 0,
/// unused [29:31]
_unused29: u3 = 0,
};
/// MPU region attribute and size
pub const MPU_RASR = Register(MPU_RASR_val).init(base_address + 0x10);
};

/// SysTick timer
pub const STK = struct {

const base_address = 0xe000e010;
/// CTRL
const CTRL_val = packed struct {
/// ENABLE [0:0]
/// Counter enable
ENABLE: u1 = 0,
/// TICKINT [1:1]
/// SysTick exception request
TICKINT: u1 = 0,
/// CLKSOURCE [2:2]
/// Clock source selection
CLKSOURCE: u1 = 0,
/// unused [3:15]
_unused3: u5 = 0,
_unused8: u8 = 0,
/// COUNTFLAG [16:16]
/// COUNTFLAG
COUNTFLAG: u1 = 0,
/// unused [17:31]
_unused17: u7 = 0,
_unused24: u8 = 0,
};
/// SysTick control and status
pub const CTRL = Register(CTRL_val).init(base_address + 0x0);

/// LOAD
const LOAD_val = packed struct {
/// RELOAD [0:23]
/// RELOAD value
RELOAD: u24 = 0,
/// unused [24:31]
_unused24: u8 = 0,
};
/// SysTick reload value register
pub const LOAD = Register(LOAD_val).init(base_address + 0x4);

/// VAL
const VAL_val = packed struct {
/// CURRENT [0:23]
/// Current counter value
CURRENT: u24 = 0,
/// unused [24:31]
_unused24: u8 = 0,
};
/// SysTick current value register
pub const VAL = Register(VAL_val).init(base_address + 0x8);

/// CALIB
const CALIB_val = packed struct {
/// TENMS [0:23]
/// Calibration value
TENMS: u24 = 0,
/// unused [24:29]
_unused24: u6 = 0,
/// SKEW [30:30]
/// SKEW flag: Indicates whether the TENMS
SKEW: u1 = 0,
/// NOREF [31:31]
/// NOREF flag. Reads as zero
NOREF: u1 = 0,
};
/// SysTick calibration value
pub const CALIB = Register(CALIB_val).init(base_address + 0xc);
};

/// System control block
pub const SCB = struct {

const base_address = 0xe000ed00;
/// CPUID
const CPUID_val = packed struct {
/// Revision [0:3]
/// Revision number
Revision: u4 = 1,
/// PartNo [4:15]
/// Part number of the
PartNo: u12 = 3108,
/// Constant [16:19]
/// Reads as 0xF
Constant: u4 = 15,
/// Variant [20:23]
/// Variant number
Variant: u4 = 0,
/// Implementer [24:31]
/// Implementer code
Implementer: u8 = 65,
};
/// CPUID base register
pub const CPUID = Register(CPUID_val).init(base_address + 0x0);

/// ICSR
const ICSR_val = packed struct {
/// VECTACTIVE [0:8]
/// Active vector
VECTACTIVE: u9 = 0,
/// unused [9:10]
_unused9: u2 = 0,
/// RETTOBASE [11:11]
/// Return to base level
RETTOBASE: u1 = 0,
/// VECTPENDING [12:18]
/// Pending vector
VECTPENDING: u7 = 0,
/// unused [19:21]
_unused19: u3 = 0,
/// ISRPENDING [22:22]
/// Interrupt pending flag
ISRPENDING: u1 = 0,
/// unused [23:24]
_unused23: u1 = 0,
_unused24: u1 = 0,
/// PENDSTCLR [25:25]
/// SysTick exception clear-pending
PENDSTCLR: u1 = 0,
/// PENDSTSET [26:26]
/// SysTick exception set-pending
PENDSTSET: u1 = 0,
/// PENDSVCLR [27:27]
/// PendSV clear-pending bit
PENDSVCLR: u1 = 0,
/// PENDSVSET [28:28]
/// PendSV set-pending bit
PENDSVSET: u1 = 0,
/// unused [29:30]
_unused29: u2 = 0,
/// NMIPENDSET [31:31]
/// NMI set-pending bit.
NMIPENDSET: u1 = 0,
};
/// Interrupt control and state
pub const ICSR = Register(ICSR_val).init(base_address + 0x4);

/// VTOR
const VTOR_val = packed struct {
/// unused [0:8]
_unused0: u8 = 0,
_unused8: u1 = 0,
/// TBLOFF [9:29]
/// Vector table base offset
TBLOFF: u21 = 0,
/// unused [30:31]
_unused30: u2 = 0,
};
/// Vector table offset register
pub const VTOR = Register(VTOR_val).init(base_address + 0x8);

/// AIRCR
const AIRCR_val = packed struct {
/// VECTRESET [0:0]
/// VECTRESET
VECTRESET: u1 = 0,
/// VECTCLRACTIVE [1:1]
/// VECTCLRACTIVE
VECTCLRACTIVE: u1 = 0,
/// SYSRESETREQ [2:2]
/// SYSRESETREQ
SYSRESETREQ: u1 = 0,
/// unused [3:7]
_unused3: u5 = 0,
/// PRIGROUP [8:10]
/// PRIGROUP
PRIGROUP: u3 = 0,
/// unused [11:14]
_unused11: u4 = 0,
/// ENDIANESS [15:15]
/// ENDIANESS
ENDIANESS: u1 = 0,
/// VECTKEYSTAT [16:31]
/// Register key
VECTKEYSTAT: u16 = 0,
};
/// Application interrupt and reset control
pub const AIRCR = Register(AIRCR_val).init(base_address + 0xc);

/// SCR
const SCR_val = packed struct {
/// unused [0:0]
_unused0: u1 = 0,
/// SLEEPONEXIT [1:1]
/// SLEEPONEXIT
SLEEPONEXIT: u1 = 0,
/// SLEEPDEEP [2:2]
/// SLEEPDEEP
SLEEPDEEP: u1 = 0,
/// unused [3:3]
_unused3: u1 = 0,
/// SEVEONPEND [4:4]
/// Send Event on Pending bit
SEVEONPEND: u1 = 0,
/// unused [5:31]
_unused5: u3 = 0,
_unused8: u8 = 0,
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// System control register
pub const SCR = Register(SCR_val).init(base_address + 0x10);

/// CCR
const CCR_val = packed struct {
/// NONBASETHRDENA [0:0]
/// Configures how the processor enters
NONBASETHRDENA: u1 = 0,
/// USERSETMPEND [1:1]
/// USERSETMPEND
USERSETMPEND: u1 = 0,
/// unused [2:2]
_unused2: u1 = 0,
/// UNALIGN__TRP [3:3]
/// UNALIGN_ TRP
UNALIGN__TRP: u1 = 0,
/// DIV_0_TRP [4:4]
/// DIV_0_TRP
DIV_0_TRP: u1 = 0,
/// unused [5:7]
_unused5: u3 = 0,
/// BFHFNMIGN [8:8]
/// BFHFNMIGN
BFHFNMIGN: u1 = 0,
/// STKALIGN [9:9]
/// STKALIGN
STKALIGN: u1 = 0,
/// unused [10:31]
_unused10: u6 = 0,
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// Configuration and control
pub const CCR = Register(CCR_val).init(base_address + 0x14);

/// SHPR1
const SHPR1_val = packed struct {
/// PRI_4 [0:7]
/// Priority of system handler
PRI_4: u8 = 0,
/// PRI_5 [8:15]
/// Priority of system handler
PRI_5: u8 = 0,
/// PRI_6 [16:23]
/// Priority of system handler
PRI_6: u8 = 0,
/// unused [24:31]
_unused24: u8 = 0,
};
/// System handler priority
pub const SHPR1 = Register(SHPR1_val).init(base_address + 0x18);

/// SHPR2
const SHPR2_val = packed struct {
/// unused [0:23]
_unused0: u8 = 0,
_unused8: u8 = 0,
_unused16: u8 = 0,
/// PRI_11 [24:31]
/// Priority of system handler
PRI_11: u8 = 0,
};
/// System handler priority
pub const SHPR2 = Register(SHPR2_val).init(base_address + 0x1c);

/// SHPR3
const SHPR3_val = packed struct {
/// unused [0:15]
_unused0: u8 = 0,
_unused8: u8 = 0,
/// PRI_14 [16:23]
/// Priority of system handler
PRI_14: u8 = 0,
/// PRI_15 [24:31]
/// Priority of system handler
PRI_15: u8 = 0,
};
/// System handler priority
pub const SHPR3 = Register(SHPR3_val).init(base_address + 0x20);

/// SHCRS
const SHCRS_val = packed struct {
/// MEMFAULTACT [0:0]
/// Memory management fault exception active
MEMFAULTACT: u1 = 0,
/// BUSFAULTACT [1:1]
/// Bus fault exception active
BUSFAULTACT: u1 = 0,
/// unused [2:2]
_unused2: u1 = 0,
/// USGFAULTACT [3:3]
/// Usage fault exception active
USGFAULTACT: u1 = 0,
/// unused [4:6]
_unused4: u3 = 0,
/// SVCALLACT [7:7]
/// SVC call active bit
SVCALLACT: u1 = 0,
/// MONITORACT [8:8]
/// Debug monitor active bit
MONITORACT: u1 = 0,
/// unused [9:9]
_unused9: u1 = 0,
/// PENDSVACT [10:10]
/// PendSV exception active
PENDSVACT: u1 = 0,
/// SYSTICKACT [11:11]
/// SysTick exception active
SYSTICKACT: u1 = 0,
/// USGFAULTPENDED [12:12]
/// Usage fault exception pending
USGFAULTPENDED: u1 = 0,
/// MEMFAULTPENDED [13:13]
/// Memory management fault exception
MEMFAULTPENDED: u1 = 0,
/// BUSFAULTPENDED [14:14]
/// Bus fault exception pending
BUSFAULTPENDED: u1 = 0,
/// SVCALLPENDED [15:15]
/// SVC call pending bit
SVCALLPENDED: u1 = 0,
/// MEMFAULTENA [16:16]
/// Memory management fault enable
MEMFAULTENA: u1 = 0,
/// BUSFAULTENA [17:17]
/// Bus fault enable bit
BUSFAULTENA: u1 = 0,
/// USGFAULTENA [18:18]
/// Usage fault enable bit
USGFAULTENA: u1 = 0,
/// unused [19:31]
_unused19: u5 = 0,
_unused24: u8 = 0,
};
/// System handler control and state
pub const SHCRS = Register(SHCRS_val).init(base_address + 0x24);

/// CFSR_UFSR_BFSR_MMFSR
const CFSR_UFSR_BFSR_MMFSR_val = packed struct {
/// unused [0:0]
_unused0: u1 = 0,
/// IACCVIOL [1:1]
/// Instruction access violation
IACCVIOL: u1 = 0,
/// unused [2:2]
_unused2: u1 = 0,
/// MUNSTKERR [3:3]
/// Memory manager fault on unstacking for a
MUNSTKERR: u1 = 0,
/// MSTKERR [4:4]
/// Memory manager fault on stacking for
MSTKERR: u1 = 0,
/// MLSPERR [5:5]
/// MLSPERR
MLSPERR: u1 = 0,
/// unused [6:6]
_unused6: u1 = 0,
/// MMARVALID [7:7]
/// Memory Management Fault Address Register
MMARVALID: u1 = 0,
/// IBUSERR [8:8]
/// Instruction bus error
IBUSERR: u1 = 0,
/// PRECISERR [9:9]
/// Precise data bus error
PRECISERR: u1 = 0,
/// IMPRECISERR [10:10]
/// Imprecise data bus error
IMPRECISERR: u1 = 0,
/// UNSTKERR [11:11]
/// Bus fault on unstacking for a return
UNSTKERR: u1 = 0,
/// STKERR [12:12]
/// Bus fault on stacking for exception
STKERR: u1 = 0,
/// LSPERR [13:13]
/// Bus fault on floating-point lazy state
LSPERR: u1 = 0,
/// unused [14:14]
_unused14: u1 = 0,
/// BFARVALID [15:15]
/// Bus Fault Address Register (BFAR) valid
BFARVALID: u1 = 0,
/// UNDEFINSTR [16:16]
/// Undefined instruction usage
UNDEFINSTR: u1 = 0,
/// INVSTATE [17:17]
/// Invalid state usage fault
INVSTATE: u1 = 0,
/// INVPC [18:18]
/// Invalid PC load usage
INVPC: u1 = 0,
/// NOCP [19:19]
/// No coprocessor usage
NOCP: u1 = 0,
/// unused [20:23]
_unused20: u4 = 0,
/// UNALIGNED [24:24]
/// Unaligned access usage
UNALIGNED: u1 = 0,
/// DIVBYZERO [25:25]
/// Divide by zero usage fault
DIVBYZERO: u1 = 0,
/// unused [26:31]
_unused26: u6 = 0,
};
/// Configurable fault status
pub const CFSR_UFSR_BFSR_MMFSR = Register(CFSR_UFSR_BFSR_MMFSR_val).init(base_address + 0x28);

/// HFSR
const HFSR_val = packed struct {
/// unused [0:0]
_unused0: u1 = 0,
/// VECTTBL [1:1]
/// Vector table hard fault
VECTTBL: u1 = 0,
/// unused [2:29]
_unused2: u6 = 0,
_unused8: u8 = 0,
_unused16: u8 = 0,
_unused24: u6 = 0,
/// FORCED [30:30]
/// Forced hard fault
FORCED: u1 = 0,
/// DEBUG_VT [31:31]
/// Reserved for Debug use
DEBUG_VT: u1 = 0,
};
/// Hard fault status register
pub const HFSR = Register(HFSR_val).init(base_address + 0x2c);

/// MMFAR
const MMFAR_val = packed struct {
/// MMFAR [0:31]
/// Memory management fault
MMFAR: u32 = 0,
};
/// Memory management fault address
pub const MMFAR = Register(MMFAR_val).init(base_address + 0x34);

/// BFAR
const BFAR_val = packed struct {
/// BFAR [0:31]
/// Bus fault address
BFAR: u32 = 0,
};
/// Bus fault address register
pub const BFAR = Register(BFAR_val).init(base_address + 0x38);

/// AFSR
const AFSR_val = packed struct {
/// IMPDEF [0:31]
/// Implementation defined
IMPDEF: u32 = 0,
};
/// Auxiliary fault status
pub const AFSR = Register(AFSR_val).init(base_address + 0x3c);
};

/// Nested vectored interrupt
pub const NVIC_STIR = struct {

const base_address = 0xe000ef00;
/// STIR
const STIR_val = packed struct {
/// INTID [0:8]
/// Software generated interrupt
INTID: u9 = 0,
/// unused [9:31]
_unused9: u7 = 0,
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// Software trigger interrupt
pub const STIR = Register(STIR_val).init(base_address + 0x0);
};

/// Floating point unit CPACR
pub const FPU_CPACR = struct {

const base_address = 0xe000ed88;
/// CPACR
const CPACR_val = packed struct {
/// unused [0:19]
_unused0: u8 = 0,
_unused8: u8 = 0,
_unused16: u4 = 0,
/// CP [20:23]
/// CP
CP: u4 = 0,
/// unused [24:31]
_unused24: u8 = 0,
};
/// Coprocessor access control
pub const CPACR = Register(CPACR_val).init(base_address + 0x0);
};

/// System control block ACTLR
pub const SCB_ACTRL = struct {

const base_address = 0xe000e008;
/// ACTRL
const ACTRL_val = packed struct {
/// DISMCYCINT [0:0]
/// DISMCYCINT
DISMCYCINT: u1 = 0,
/// DISDEFWBUF [1:1]
/// DISDEFWBUF
DISDEFWBUF: u1 = 0,
/// DISFOLD [2:2]
/// DISFOLD
DISFOLD: u1 = 0,
/// unused [3:7]
_unused3: u5 = 0,
/// DISFPCA [8:8]
/// DISFPCA
DISFPCA: u1 = 0,
/// DISOOFP [9:9]
/// DISOOFP
DISOOFP: u1 = 0,
/// unused [10:31]
_unused10: u6 = 0,
_unused16: u8 = 0,
_unused24: u8 = 0,
};
/// Auxiliary control register
pub const ACTRL = Register(ACTRL_val).init(base_address + 0x0);
};
pub const interrupts = struct {
pub const TIM1_TRG_COM_TIM17 = 26;
pub const TIM6_DACUNDER = 54;
pub const DMA2_CH5 = 60;
pub const USB_WKUP_EXTI = 76;
pub const CAN_SCE = 22;
pub const I2C3_ER = 73;
pub const ADC4 = 61;
pub const I2C2_ER = 34;
pub const DMA2_CH1 = 56;
pub const SPI2 = 36;
pub const EXTI3 = 9;
pub const RTCAlarm = 41;
pub const COMP123 = 64;
pub const USART2_EXTI26 = 38;
pub const EXTI0 = 6;
pub const I2C2_EV_EXTI24 = 33;
pub const TAMP_STAMP = 2;
pub const CAN_RX1 = 21;
pub const EXTI1 = 7;
pub const TIM20_CC = 80;
pub const TIM8_BRK = 43;
pub const COMP456 = 65;
pub const COMP7 = 66;
pub const TIM2 = 28;
pub const EXTI15_10 = 40;
pub const RCC = 5;
pub const USART1_EXTI25 = 37;
pub const DMA1_CH6 = 16;
pub const DMA2_CH3 = 58;
pub const I2C3_EV = 72;
pub const USB_LP_CAN_RX0 = 20;
pub const USB_HP = 74;
pub const TIM7 = 55;
pub const DMA1_CH3 = 13;
pub const TIM1_BRK_TIM15 = 24;
pub const DMA1_CH1 = 11;
pub const USB_LP = 75;
pub const TIM20_BRK = 77;
pub const TIM20_UP = 78;
pub const ADC3 = 47;
pub const DMA2_CH4 = 59;
pub const RTC_WKUP = 3;
pub const DMA1_CH7 = 17;
pub const TIM8_TRG_COM = 45;
pub const SPI3 = 51;
pub const EXTI9_5 = 23;
pub const TIM1_CC = 27;
pub const I2C1_EV_EXTI23 = 31;
pub const TIM4 = 30;
pub const SPI4 = 84;
pub const DMA1_CH2 = 12;
pub const WWDG = 0;
pub const DMA1_CH4 = 14;
pub const EXTI2_TSC = 8;
pub const UART4_EXTI34 = 52;
pub const USB_WKUP = 42;
pub const TIM8_UP = 44;
pub const TIM1_UP_TIM16 = 25;
pub const USART3_EXTI28 = 39;
pub const TIM8_CC = 46;
pub const ADC1_2 = 18;
pub const DMA2_CH2 = 57;
pub const I2C1_ER = 32;
pub const USB_HP_CAN_TX = 19;
pub const FLASH = 4;
pub const TIM3 = 29;
pub const PVD = 1;
pub const TIM20_TRG_COM = 79;
pub const UART5_EXTI35 = 53;
pub const DMA1_CH5 = 15;
pub const SPI1 = 35;
pub const EXTI4 = 10;
pub const FMC = 48;
pub const FPU = 81;
};
