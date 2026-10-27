// scripts\mp\common\equipment\health_consumable_util.gsc  (hash_006fb3dccb921846.gscc) (size: 489 Bytes / 0x1e9 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x2f040556 (788792662)
// size ...... 489 (0x1e9)
// includes .. 0   (offset: 0x1e9)
// strings ... 0   (offset: 0x1e9)
// dev strs .. 0   (offset: 0x1e9)
// exports ... 2   (offset: 0x179)
// cseg ...... 0x58 + 0x121 (0x179)
// imports ... 1   (offset: 0x1c9)
// animtree1 . 0   (offset: 0x1e9)
// animtree2 . 0   (offset: 0x1e9)
#namespace health_consumable_util;

// Namespace health_consumable_util
// Params 1
// Checksum 0xe5bdf0f7, Offset: 0x76
// Size: 0x102
function function_a6fa5d7a39a3abb2( bundle = spawnstruct() )
{
    struct = spawnstruct();
    struct.timeduration = bundle.var_f4bae82293e03129 ?? 0;
    struct.mintimeduration = bundle.var_492c201ab4bdc3c5 ?? 0;
    struct.var_243df52d50f750e8 = bundle.var_d6fcb84a1154dde6 ?? 0;
    struct.healthduration = bundle.var_2c7959336e9d32da ?? 0;
    struct.starttimedelay = bundle.var_54c6770b0a648670 ?? 0;
    struct.var_fb94b0080692bb84 = bundle.var_15a3e2154fbf8b63 ?? 0;
    struct.healthregenmod = bundle.var_b418e35e39328d06 ?? 0;
    return struct;
}

