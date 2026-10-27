// scripts\mp\maps\mp_sat_ava_hightown_skr\mp_sat_ava_hightown_skr.gsc  (hash_0d0b4587c86e0e65.gscc) (size: 820 Bytes / 0x334 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x33a14478 (866206840)
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
#using scripts\mp\maps\mp_sat_ava_hightown_skr\gen\mp_sat_ava_hightown_skr_art;
#using scripts\mp\maps\mp_sat_ava_hightown_skr\mp_sat_ava_hightown_skr_fx;
#using scripts\mp\maps\mp_sat_ava_hightown_skr\mp_sat_ava_hightown_skr_lighting;

#namespace mp_sat_ava_hightown_skr;

// Namespace mp_sat_ava_hightown_skr
// Params 0
// Checksum 0x69f5413f, Offset: 0x11b
// Size: 0x75
function main()
{
    namespace_ce20f4b858032863::main();
    namespace_5a99c5628b2bc9b8::main();
    namespace_95bfb9691d9596c6::main();
    load::main();
    level.outofboundstriggers = getentarray( "OutOfBounds", "targetname" );
    compass::setupminimap( "compass_map_mp_sat_ava_hightown_skr" );
    game[ "attackers" ] = "allies";
    game[ "defenders" ] = "axis";
    game[ "allies_outfit" ] = "urban";
    game[ "axis_outfit" ] = "woodland";
}

