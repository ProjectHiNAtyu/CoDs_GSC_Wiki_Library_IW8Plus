// scripts\mp\zm\maps\zm_sat_mantis\zm_sat_mantis_lighting.gsc  (hash_1827b13df5e205b8.gscc) (size: 539 Bytes / 0x21b / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xb281ee3c (2994859580)
// size ...... 539 (0x21b)
// includes .. 1   (offset: 0x1eb)
// strings ... 3   (offset: 0x1f3)
// dev strs .. 0   (offset: 0x21b)
// exports ... 3   (offset: 0xff)
// cseg ...... 0x93 + 0x6c (0xff)
// imports ... 4   (offset: 0x177)
// animtree1 . 0   (offset: 0x21b)
// animtree2 . 0   (offset: 0x21b)
#using scripts\common\utility;

#namespace zm_sat_mantis_lighting;

// Namespace zm_sat_mantis_lighting
// Params 0
// Checksum 0xb268811f, Offset: 0xb1
// Size: 0xa
function main()
{
    level thread function_4d3bfa800f12e4d8();
}

// Namespace zm_sat_mantis_lighting
// Params 0
// Checksum 0x6ce3fcd0, Offset: 0xc3
// Size: 0x3c
function function_4d3bfa800f12e4d8()
{
    level endon( #"game_ended" );
    level utility::flag_wait( "door_house2_f" );
    activateworldevent( "we_lgt_garage_flicker" );
    wait 2;
    deactivateworldevent( "we_lgt_garage_flicker" );
    activateworldevent( "we_lgt_garage" );
}

