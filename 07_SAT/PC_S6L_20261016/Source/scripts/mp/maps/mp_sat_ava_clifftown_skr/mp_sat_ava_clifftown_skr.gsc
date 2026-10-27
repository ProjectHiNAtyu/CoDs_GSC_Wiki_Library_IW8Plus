// scripts\mp\maps\mp_sat_ava_clifftown_skr\mp_sat_ava_clifftown_skr.gsc  (hash_467b7baf45de5edd.gscc) (size: 821 Bytes / 0x335 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x28694da8 (677989800)
// size ...... 821 (0x335)
// includes .. 5   (offset: 0x289)
// strings ... 11  (offset: 0x2b1)
// dev strs .. 0   (offset: 0x335)
// exports ... 2   (offset: 0x191)
// cseg ...... 0xfe + 0x93 (0x191)
// imports ... 6   (offset: 0x1e1)
// animtree1 . 0   (offset: 0x335)
// animtree2 . 0   (offset: 0x335)
#using scripts\mp\compass;
#using scripts\mp\load;
#using scripts\mp\maps\mp_sat_ava_clifftown_skr\gen\mp_sat_ava_clifftown_skr_art;
#using scripts\mp\maps\mp_sat_ava_clifftown_skr\mp_sat_ava_clifftown_skr_fx;
#using scripts\mp\maps\mp_sat_ava_clifftown_skr\mp_sat_ava_clifftown_skr_lighting;

#namespace mp_sat_ava_clifftown_skr;

// Namespace mp_sat_ava_clifftown_skr
// Params 0
// Checksum 0xfa93126, Offset: 0x11c
// Size: 0x75
function main()
{
    mp_sat_ava_clifftown_skr_art::main();
    namespace_4128313564175cc6::main();
    namespace_8daca53823b8c5ac::main();
    load::main();
    level.outofboundstriggers = getentarray( "OutOfBounds", "targetname" );
    compass::setupminimap( "compass_map_mp_sat_ava_clifftown_skr" );
    game[ "attackers" ] = "allies";
    game[ "defenders" ] = "axis";
    game[ "allies_outfit" ] = "urban";
    game[ "axis_outfit" ] = "woodland";
}

