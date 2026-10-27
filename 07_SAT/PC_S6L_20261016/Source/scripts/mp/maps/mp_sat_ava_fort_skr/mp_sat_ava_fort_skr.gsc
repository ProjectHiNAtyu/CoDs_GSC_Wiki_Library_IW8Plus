// scripts\mp\maps\mp_sat_ava_fort_skr\mp_sat_ava_fort_skr.gsc  (hash_51fac1d5c0d07455.gscc) (size: 816 Bytes / 0x330 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xd7c908ae (3620276398)
// size ...... 816 (0x330)
// includes .. 5   (offset: 0x284)
// strings ... 11  (offset: 0x2ac)
// dev strs .. 0   (offset: 0x330)
// exports ... 2   (offset: 0x18c)
// cseg ...... 0xf9 + 0x93 (0x18c)
// imports ... 6   (offset: 0x1dc)
// animtree1 . 0   (offset: 0x330)
// animtree2 . 0   (offset: 0x330)
#using scripts\mp\compass;
#using scripts\mp\load;
#using scripts\mp\maps\mp_sat_ava_fort_skr\gen\mp_sat_ava_fort_skr_art;
#using scripts\mp\maps\mp_sat_ava_fort_skr\mp_sat_ava_fort_skr_fx;
#using scripts\mp\maps\mp_sat_ava_fort_skr\mp_sat_ava_fort_skr_lighting;

#namespace mp_sat_ava_fort_skr;

// Namespace mp_sat_ava_fort_skr
// Params 0
// Checksum 0x18dd9079, Offset: 0x117
// Size: 0x75
function main()
{
    mp_sat_ava_fort_skr_art::main();
    mp_sat_ava_fort_skr_fx::main();
    mp_sat_ava_fort_skr_lighting::main();
    load::main();
    level.outofboundstriggers = getentarray( "OutOfBounds", "targetname" );
    compass::setupminimap( "compass_map_mp_sat_ava_fort_skr" );
    game[ "attackers" ] = "allies";
    game[ "defenders" ] = "axis";
    game[ "allies_outfit" ] = "urban";
    game[ "axis_outfit" ] = "woodland";
}

