// scripts\mp\maps\mp_sat_rm_hijacked\mp_sat_rm_hijacked.gsc  (hash_3742356905e69433.gscc) (size: 1081 Bytes / 0x439 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x2361c45d (593609821)
// size ...... 1081 (0x439)
// includes .. 5   (offset: 0x375)
// strings ... 13  (offset: 0x39d)
// dev strs .. 0   (offset: 0x439)
// exports ... 2   (offset: 0x255)
// cseg ...... 0x12a + 0x12b (0x255)
// imports ... 7   (offset: 0x2a5)
// animtree1 . 0   (offset: 0x439)
// animtree2 . 0   (offset: 0x439)
#using scripts\mp\compass;
#using scripts\mp\load;
#using scripts\mp\maps\mp_sat_rm_hijacked\gen\mp_sat_rm_hijacked_art;
#using scripts\mp\maps\mp_sat_rm_hijacked\mp_sat_rm_hijacked_fx;
#using scripts\mp\maps\mp_sat_rm_hijacked\mp_sat_rm_hijacked_lighting;

#namespace mp_sat_rm_hijacked;

// Namespace mp_sat_rm_hijacked
// Params 0
// Checksum 0xb76eebd1, Offset: 0x148
// Size: 0x10d
function main()
{
    mp_sat_rm_hijacked_art::main();
    mp_sat_rm_hijacked_fx::main();
    mp_sat_rm_hijacked_lighting::main();
    load::main();
    level.kill_border_triggers = getentarray( "kill_border_trigger", #targetname );
    level.outofboundstriggers = getentarray( "OutOfBounds", #targetname );
    level.var_750dbf45607817fd = getentarray( "Drone_OutOfBounds", #targetname );
    level.var_f11fa8013d4e241c = getentarray( "VTOL_OutOfBounds", #targetname );
    compass::setupminimap( "compass_map_mp_sat_rm_hijacked" );
    barrier = { #radiussquared:squared( 600 ), #origin:( -3000, 0, 0 ) };
    level.var_3d1af6b4fa55bd37 = [ barrier ];
    game[ "attackers" ] = "allies";
    game[ "defenders" ] = "axis";
    game[ "allies_outfit" ] = "urban";
    game[ "axis_outfit" ] = "woodland";
}

