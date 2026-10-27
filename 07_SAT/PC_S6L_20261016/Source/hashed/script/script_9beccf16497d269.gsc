// script_9beccf16497d269  (hash_09beccf16497d269.gscc) (size: 803 Bytes / 0x323 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x3c16e2a9 (1008132777)
// size ...... 803 (0x323)
// includes .. 6   (offset: 0x27b)
// strings ... 10  (offset: 0x2ab)
// dev strs .. 0   (offset: 0x323)
// exports ... 2   (offset: 0x183)
// cseg ...... 0xf0 + 0x93 (0x183)
// imports ... 6   (offset: 0x1d3)
// animtree1 . 0   (offset: 0x323)
// animtree2 . 0   (offset: 0x323)
#using script_2665134cf0e60190;
#using script_4a91b610b937b552;
#using script_584c09754585d57a;
#using scripts\common\utility;
#using scripts\mp\compass;
#using scripts\mp\load;

#namespace namespace_22b97ae89020060a;

// Namespace namespace_22b97ae89020060a
// Params 0
// Checksum 0xcab9a3ad, Offset: 0x10e
// Size: 0x75
function main()
{
    namespace_1f44eb06d6d7e754::main();
    namespace_856522730d793329::main();
    namespace_d2d9b85288057bd7::main();
    load::main();
    compass::setupminimap( "compass_map_zm_sat_ztron4" );
    game[ "attackers" ] = "allies";
    game[ "defenders" ] = "axis";
    game[ "allies_outfit" ] = "urban";
    game[ "axis_outfit" ] = "woodland";
    level.ttlos_suppressasserts = 1;
    utility::flag_wait( "ztron_game_initialized" );
}

