// scripts\mp\maps\mp_sat_freerun_2\mp_sat_freerun_2.gsc  (hash_54c4a47dcd1d3465.gscc) (size: 901 Bytes / 0x385 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x802b3d8f (2150317455)
// size ...... 901 (0x385)
// includes .. 7   (offset: 0x2c9)
// strings ... 11  (offset: 0x301)
// dev strs .. 0   (offset: 0x385)
// exports ... 2   (offset: 0x199)
// cseg ...... 0xf6 + 0xa3 (0x199)
// imports ... 8   (offset: 0x1e9)
// animtree1 . 0   (offset: 0x385)
// animtree2 . 0   (offset: 0x385)
#using scripts\common\active_env\moving_platforms;
#using scripts\common\active_env\portals;
#using scripts\mp\compass;
#using scripts\mp\load;
#using scripts\mp\maps\mp_sat_freerun_2\gen\mp_sat_freerun_2_art;
#using scripts\mp\maps\mp_sat_freerun_2\mp_sat_freerun_2_fx;
#using scripts\mp\maps\mp_sat_freerun_2\mp_sat_freerun_2_lighting;

#namespace mp_sat_freerun_2;

// Namespace mp_sat_freerun_2
// Params 0
// Checksum 0xec949ed1, Offset: 0x114
// Size: 0x85
function main()
{
    mp_sat_freerun_2_art::main();
    namespace_4dcde0bad4940e38::main();
    mp_sat_freerun_2_lighting::main();
    load::main();
    level.outofboundstriggers = getentarray( "OutOfBounds", "targetname" );
    compass::setupminimap( "compass_map_mp_sat_freerun_2" );
    game[ "attackers" ] = "allies";
    game[ "defenders" ] = "axis";
    game[ "allies_outfit" ] = "urban";
    game[ "axis_outfit" ] = "woodland";
    level thread moving_platforms::moving_platforms_init();
    level thread portals::portals_init();
}

