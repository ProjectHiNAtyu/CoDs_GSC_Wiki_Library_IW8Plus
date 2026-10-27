// scripts\mp\maps\mp_sat_rm_nightclub\mp_sat_rm_nightclub.gsc  (hash_3d10274bc7d2c045.gscc) (size: 998 Bytes / 0x3e6 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x85235425 (2233685029)
// size ...... 998 (0x3e6)
// includes .. 5   (offset: 0x322)
// strings ... 13  (offset: 0x34a)
// dev strs .. 0   (offset: 0x3e6)
// exports ... 2   (offset: 0x21e)
// cseg ...... 0x12b + 0xf3 (0x21e)
// imports ... 6   (offset: 0x26e)
// animtree1 . 0   (offset: 0x3e6)
// animtree2 . 0   (offset: 0x3e6)
#using scripts\mp\compass;
#using scripts\mp\load;
#using scripts\mp\maps\mp_sat_rm_nightclub\gen\mp_sat_rm_nightclub_art;
#using scripts\mp\maps\mp_sat_rm_nightclub\mp_sat_rm_nightclub_fx;
#using scripts\mp\maps\mp_sat_rm_nightclub\mp_sat_rm_nightclub_lighting;

#namespace mp_sat_rm_nightclub;

// Namespace mp_sat_rm_nightclub
// Params 0
// Checksum 0xf697199e, Offset: 0x149
// Size: 0xd5
function main()
{
    mp_sat_rm_nightclub_art::main();
    mp_sat_rm_nightclub_fx::main();
    mp_sat_rm_nightclub_lighting::main();
    load::main();
    level.kill_border_triggers = getentarray( "kill_border_trigger", #targetname );
    level.outofboundstriggers = getentarray( "OutOfBounds", #targetname );
    level.var_750dbf45607817fd = getentarray( "Drone_OutOfBounds", #targetname );
    level.var_f11fa8013d4e241c = getentarray( "VTOL_OutOfBounds", #targetname );
    compass::setupminimap( "compass_map_mp_sat_rm_nightclub" );
    level.var_86587f097a6ea895 = 1;
    game[ "attackers" ] = "allies";
    game[ "defenders" ] = "axis";
    game[ "allies_outfit" ] = "urban";
    game[ "axis_outfit" ] = "woodland";
}

