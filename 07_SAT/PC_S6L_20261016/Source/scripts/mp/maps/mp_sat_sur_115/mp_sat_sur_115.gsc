// scripts\mp\maps\mp_sat_sur_115\mp_sat_sur_115.gsc  (hash_17fc19d5d0025735.gscc) (size: 811 Bytes / 0x32b / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x448090e8 (1149276392)
// size ...... 811 (0x32b)
// includes .. 5   (offset: 0x27f)
// strings ... 11  (offset: 0x2a7)
// dev strs .. 0   (offset: 0x32b)
// exports ... 2   (offset: 0x187)
// cseg ...... 0xf4 + 0x93 (0x187)
// imports ... 6   (offset: 0x1d7)
// animtree1 . 0   (offset: 0x32b)
// animtree2 . 0   (offset: 0x32b)
#using scripts\mp\compass;
#using scripts\mp\load;
#using scripts\mp\maps\mp_sat_sur_115\gen\mp_sat_sur_115_art;
#using scripts\mp\maps\mp_sat_sur_115\mp_sat_sur_115_fx;
#using scripts\mp\maps\mp_sat_sur_115\mp_sat_sur_115_lighting;

#namespace mp_sat_sur_115;

// Namespace mp_sat_sur_115
// Params 0
// Checksum 0xdc910975, Offset: 0x112
// Size: 0x75
function main()
{
    namespace_430714b231dd708d::main();
    namespace_38770ea9035da3e6::main();
    namespace_74cabe7c0b53fcc::main();
    load::main();
    level.outofboundstriggers = getentarray( "OutOfBounds", "targetname" );
    compass::setupminimap( "compass_map_mp_sat_sur_115" );
    game[ "attackers" ] = "allies";
    game[ "defenders" ] = "axis";
    game[ "allies_outfit" ] = "urban";
    game[ "axis_outfit" ] = "woodland";
}

