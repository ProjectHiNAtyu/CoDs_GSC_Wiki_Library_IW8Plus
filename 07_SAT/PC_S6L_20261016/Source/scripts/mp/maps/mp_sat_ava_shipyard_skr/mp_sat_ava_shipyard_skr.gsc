// scripts\mp\maps\mp_sat_ava_shipyard_skr\mp_sat_ava_shipyard_skr.gsc  (hash_7c7153a4836048d9.gscc) (size: 820 Bytes / 0x334 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x4a7b4626 (1249592870)
// size ...... 820 (0x334)
// includes .. 5   (offset: 0x288)
// strings ... 11  (offset: 0x2b0)
// dev strs .. 0   (offset: 0x334)
// exports ... 2   (offset: 0x190)
// cseg ...... 0xfd + 0x93 (0x190)
// imports ... 6   (offset: 0x1e0)
// animtree1 . 0   (offset: 0x334)
// animtree2 . 0   (offset: 0x334)
#using scripts\mp\compass;
#using scripts\mp\load;
#using scripts\mp\maps\mp_sat_ava_shipyard_skr\gen\mp_sat_ava_shipyard_skr_art;
#using scripts\mp\maps\mp_sat_ava_shipyard_skr\mp_sat_ava_shipyard_skr_fx;
#using scripts\mp\maps\mp_sat_ava_shipyard_skr\mp_sat_ava_shipyard_skr_lighting;

#namespace mp_sat_ava_shipyard_skr;

// Namespace mp_sat_ava_shipyard_skr
// Params 0
// Checksum 0xd84e3c3d, Offset: 0x11b
// Size: 0x75
function main()
{
    mp_sat_ava_shipyard_skr_art::main();
    mp_sat_ava_shipyard_skr_fx::main();
    mp_sat_ava_shipyard_skr_lighting::main();
    load::main();
    level.outofboundstriggers = getentarray( "OutOfBounds", "targetname" );
    compass::setupminimap( "compass_map_mp_sat_ava_shipyard_skr" );
    game[ "attackers" ] = "allies";
    game[ "defenders" ] = "axis";
    game[ "allies_outfit" ] = "urban";
    game[ "axis_outfit" ] = "woodland";
}

