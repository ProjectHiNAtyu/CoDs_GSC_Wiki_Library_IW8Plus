// scripts\mp\zm\maps\zm_sat_hornet\zm_sat_hornet_rb.gsc  (hash_043ea3a063ebcdcc.gscc) (size: 297 Bytes / 0x129 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xa68e5fa9 (2794348457)
// size ...... 297 (0x129)
// includes .. 2   (offset: 0x119)
// strings ... 0   (offset: 0x129)
// dev strs .. 0   (offset: 0x129)
// exports ... 2   (offset: 0x91)
// cseg ...... 0x58 + 0x39 (0x91)
// imports ... 2   (offset: 0xe1)
// animtree1 . 0   (offset: 0x129)
// animtree2 . 0   (offset: 0x129)
#using scripts\mp\zm\systems\zm_round_accelerant;
#using scripts\mp\zm\systems\zm_round_spawning;

#namespace zm_sat_hornet_rb;

// Namespace zm_sat_hornet_rb
// Params 0
// Checksum 0x2fc9929f, Offset: 0x76
// Size: 0x1b
function init()
{
    level thread zm_round_accelerant::init_round_accelerant();
    level thread zm_round_spawning::function_c134fd55f45903e6( %"hash_4a3641b8b2c08c26" );
}

