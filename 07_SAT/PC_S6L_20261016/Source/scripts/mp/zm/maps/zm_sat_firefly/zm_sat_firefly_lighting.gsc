// scripts\mp\zm\maps\zm_sat_firefly\zm_sat_firefly_lighting.gsc  (hash_4fd7d4caba4c6702.gscc) (size: 463 Bytes / 0x1cf / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x352b2a3a (892021306)
// size ...... 463 (0x1cf)
// includes .. 1   (offset: 0x1af)
// strings ... 2   (offset: 0x1b7)
// dev strs .. 0   (offset: 0x1cf)
// exports ... 3   (offset: 0xe3)
// cseg ...... 0x8f + 0x54 (0xe3)
// imports ... 3   (offset: 0x15b)
// animtree1 . 0   (offset: 0x1cf)
// animtree2 . 0   (offset: 0x1cf)
#using scripts\common\utility;

#namespace zm_sat_firefly_lighting;

// Namespace zm_sat_firefly_lighting
// Params 0
// Checksum 0xee14e37d, Offset: 0xad
// Size: 0xa
function main()
{
    level thread function_3f31de061733d510();
}

// Namespace zm_sat_firefly_lighting
// Params 0
// Checksum 0xf8165fe1, Offset: 0xbf
// Size: 0x24
function function_3f31de061733d510()
{
    level endon( #"game_ended" );
    utility::flag_wait( "doorbuy_sunken_brothel_bought" );
    activateworldevent( "we_lgt_ruby_rabbit" );
}

