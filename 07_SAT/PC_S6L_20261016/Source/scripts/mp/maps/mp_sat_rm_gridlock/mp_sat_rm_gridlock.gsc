// scripts\mp\maps\mp_sat_rm_gridlock\mp_sat_rm_gridlock.gsc  (hash_74ca7acae51085cb.gscc) (size: 1051 Bytes / 0x41b / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xfa904519 (4203758873)
// size ...... 1051 (0x41b)
// includes .. 5   (offset: 0x357)
// strings ... 13  (offset: 0x37f)
// dev strs .. 0   (offset: 0x41b)
// exports ... 2   (offset: 0x233)
// cseg ...... 0x12a + 0x109 (0x233)
// imports ... 7   (offset: 0x283)
// animtree1 . 0   (offset: 0x41b)
// animtree2 . 0   (offset: 0x41b)
#using scripts\mp\compass;
#using scripts\mp\load;
#using scripts\mp\maps\mp_sat_rm_gridlock\gen\mp_sat_rm_gridlock_art;
#using scripts\mp\maps\mp_sat_rm_gridlock\mp_sat_rm_gridlock_fx;
#using scripts\mp\maps\mp_sat_rm_gridlock\mp_sat_rm_gridlock_lighting;

#namespace mp_sat_rm_gridlock;

// Namespace mp_sat_rm_gridlock
// Params 0
// Checksum 0xb2c9a640, Offset: 0x148
// Size: 0xeb
function main()
{
    mp_sat_rm_gridlock_art::main();
    mp_sat_rm_gridlock_fx::main();
    mp_sat_rm_gridlock_lighting::main();
    load::main();
    level.kill_border_triggers = getentarray( "kill_border_trigger", #targetname );
    level.outofboundstriggers = getentarray( "OutOfBounds", #targetname );
    level.var_750dbf45607817fd = getentarray( "Drone_OutOfBounds", #targetname );
    level.var_f11fa8013d4e241c = getentarray( "VTOL_OutOfBounds", #targetname );
    compass::setupminimap( "compass_map_mp_sat_rm_gridlock" );
    setdvar( @"r_umbraminobjectcontribution", 8 );
    setdvar( @"hash_a09cd65f2dcf772d", 3500 );
    game[ "attackers" ] = "allies";
    game[ "defenders" ] = "axis";
    game[ "allies_outfit" ] = "urban";
    game[ "axis_outfit" ] = "woodland";
}

