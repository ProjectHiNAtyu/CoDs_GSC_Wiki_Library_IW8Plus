// scripts\mp\maps\mp_sat_sm_chamber\mp_sat_sm_chamber.gsc  (hash_18758113706b0385.gscc) (size: 814 Bytes / 0x32e / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x95e531bb (2514825659)
// size ...... 814 (0x32e)
// includes .. 5   (offset: 0x282)
// strings ... 11  (offset: 0x2aa)
// dev strs .. 0   (offset: 0x32e)
// exports ... 2   (offset: 0x18a)
// cseg ...... 0xf7 + 0x93 (0x18a)
// imports ... 6   (offset: 0x1da)
// animtree1 . 0   (offset: 0x32e)
// animtree2 . 0   (offset: 0x32e)
#using scripts\mp\compass;
#using scripts\mp\load;
#using scripts\mp\maps\mp_sat_sm_chamber\gen\mp_sat_sm_chamber_art;
#using scripts\mp\maps\mp_sat_sm_chamber\mp_sat_sm_chamber_fx;
#using scripts\mp\maps\mp_sat_sm_chamber\mp_sat_sm_chamber_lighting;

#namespace mp_sat_sm_chamber;

// Namespace mp_sat_sm_chamber
// Params 0
// Checksum 0xb6b5182f, Offset: 0x115
// Size: 0x75
function main()
{
    mp_sat_sm_chamber_art::main();
    mp_sat_sm_chamber_fx::main();
    mp_sat_sm_chamber_lighting::main();
    load::main();
    level.outofboundstriggers = getentarray( "OutOfBounds", "targetname" );
    compass::setupminimap( "compass_map_mp_sat_sm_chamber" );
    game[ "attackers" ] = "allies";
    game[ "defenders" ] = "axis";
    game[ "allies_outfit" ] = "urban";
    game[ "axis_outfit" ] = "woodland";
}

