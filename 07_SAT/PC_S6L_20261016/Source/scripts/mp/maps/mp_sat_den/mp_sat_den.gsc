// scripts\mp\maps\mp_sat_den\mp_sat_den.gsc  (hash_343777a7e7ab61ab.gscc) (size: 1123 Bytes / 0x463 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xe72c24a4 (3878429860)
// size ...... 1123 (0x463)
// includes .. 6   (offset: 0x397)
// strings ... 13  (offset: 0x3c7)
// dev strs .. 0   (offset: 0x463)
// exports ... 3   (offset: 0x233)
// cseg ...... 0x122 + 0x111 (0x233)
// imports ... 8   (offset: 0x2ab)
// animtree1 . 0   (offset: 0x463)
// animtree2 . 0   (offset: 0x463)
#using scripts\common\callbacks;
#using scripts\mp\compass;
#using scripts\mp\load;
#using scripts\mp\maps\mp_sat_den\gen\mp_sat_den_art;
#using scripts\mp\maps\mp_sat_den\mp_sat_den_fx;
#using scripts\mp\maps\mp_sat_den\mp_sat_den_lighting;

#namespace mp_sat_den;

// Namespace mp_sat_den
// Params 0
// Checksum 0x7949e0d7, Offset: 0x140
// Size: 0xdf
function main()
{
    mp_sat_den_art::main();
    mp_sat_den_fx::main();
    mp_sat_den_lighting::main();
    load::main();
    level.kill_border_triggers = getentarray( "kill_border_trigger", #targetname );
    level.outofboundstriggers = getentarray( "OutOfBounds", #targetname );
    level.var_750dbf45607817fd = getentarray( "Drone_OutOfBounds", #targetname );
    level.var_f11fa8013d4e241c = getentarray( "VTOL_OutOfBounds", #targetname );
    compass::setupminimap( "compass_map_mp_sat_den" );
    game[ "attackers" ] = "allies";
    game[ "defenders" ] = "axis";
    game[ "allies_outfit" ] = "urban";
    game[ "axis_outfit" ] = "woodland";
    callback::add( #"player_spawn_init", &on_spawn_init );
}

// Namespace mp_sat_den
// Params 1
// Checksum 0x3c2d6759, Offset: 0x227
// Size: 0xc
function on_spawn_init( params )
{
    
}

