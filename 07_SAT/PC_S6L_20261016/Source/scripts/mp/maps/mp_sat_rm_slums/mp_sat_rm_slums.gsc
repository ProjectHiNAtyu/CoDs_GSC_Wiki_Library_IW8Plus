// scripts\mp\maps\mp_sat_rm_slums\mp_sat_rm_slums.gsc  (hash_23d6bb139ed8f75d.gscc) (size: 983 Bytes / 0x3d7 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xf298164a (4070053450)
// size ...... 983 (0x3d7)
// includes .. 5   (offset: 0x313)
// strings ... 13  (offset: 0x33b)
// dev strs .. 0   (offset: 0x3d7)
// exports ... 2   (offset: 0x20f)
// cseg ...... 0x127 + 0xe8 (0x20f)
// imports ... 6   (offset: 0x25f)
// animtree1 . 0   (offset: 0x3d7)
// animtree2 . 0   (offset: 0x3d7)
#using scripts\mp\compass;
#using scripts\mp\load;
#using scripts\mp\maps\mp_sat_rm_slums\gen\mp_sat_rm_slums_art;
#using scripts\mp\maps\mp_sat_rm_slums\mp_sat_rm_slums_fx;
#using scripts\mp\maps\mp_sat_rm_slums\mp_sat_rm_slums_lighting;

#namespace mp_sat_rm_slums;

// Namespace mp_sat_rm_slums
// Params 0
// Checksum 0xa33f599d, Offset: 0x145
// Size: 0xca
function main()
{
    mp_sat_rm_slums_art::main();
    mp_sat_rm_slums_fx::main();
    mp_sat_rm_slums_lighting::main();
    load::main();
    level.kill_border_triggers = getentarray( "kill_border_trigger", #targetname );
    level.outofboundstriggers = getentarray( "OutOfBounds", #targetname );
    level.var_750dbf45607817fd = getentarray( "Drone_OutOfBounds", #targetname );
    level.var_f11fa8013d4e241c = getentarray( "VTOL_OutOfBounds", #targetname );
    compass::setupminimap( "compass_map_mp_sat_rm_slums" );
    game[ "attackers" ] = "allies";
    game[ "defenders" ] = "axis";
    game[ "allies_outfit" ] = "urban";
    game[ "axis_outfit" ] = "woodland";
}

