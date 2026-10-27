// scripts\mp\maps\mp_sat_beacon\mp_sat_beacon.gsc  (hash_3a3282b7a12ffd4d.gscc) (size: 2059 Bytes / 0x80b / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x54c58c10 (1422232592)
// size ...... 2059 (0x80b)
// includes .. 8   (offset: 0x717)
// strings ... 15  (offset: 0x757)
// dev strs .. 0   (offset: 0x80b)
// exports ... 5   (offset: 0x477)
// cseg ...... 0x144 + 0x333 (0x477)
// imports ... 16  (offset: 0x53f)
// animtree1 . 0   (offset: 0x80b)
// animtree2 . 0   (offset: 0x80b)
#using script_16ea1b94f0f381b3;
#using scripts\common\active_env\moving_platforms;
#using scripts\common\callbacks;
#using scripts\mp\compass;
#using scripts\mp\load;
#using scripts\mp\maps\mp_sat_beacon\gen\mp_sat_beacon_art;
#using scripts\mp\maps\mp_sat_beacon\mp_sat_beacon_fx;
#using scripts\mp\maps\mp_sat_beacon\mp_sat_beacon_lighting;

#namespace mp_sat_beacon;

// Namespace mp_sat_beacon
// Params 0
// Checksum 0x7491d40a, Offset: 0x162
// Size: 0x15e
function main()
{
    mp_sat_beacon_art::main();
    mp_sat_beacon_fx::main();
    mp_sat_beacon_lighting::main();
    load::main();
    level.outofboundstriggers = getentarray( "OutOfBounds", "targetname" );
    level.var_f11fa8013d4e241c = getentarray( "VTOL_OutOfBounds", #targetname );
    level.var_750dbf45607817fd = getentarray( "Drone_OutOfBounds", #targetname );
    compass::setupminimap( "compass_map_mp_sat_beacon" );
    barrier = { #radiussquared:squared( 575 ), #origin:( -325, -400, 1000 ) };
    var_bad5a1a0cfe82479 = { #radiussquared:squared( 575 ), #origin:( 225, 2300, 800 ) };
    level.var_3d1af6b4fa55bd37 = [ barrier, var_bad5a1a0cfe82479 ];
    game[ "attackers" ] = "allies";
    game[ "defenders" ] = "axis";
    game[ "allies_outfit" ] = "urban";
    game[ "axis_outfit" ] = "woodland";
    level thread moving_platforms::moving_platforms_init();
    level.var_ef03fedcd5fe1a80 = 0;
    level thread function_beeef8088df41d84();
    
    /#
        namespace_9d8e359c3b1041e5::function_95538e4344ab0bfb( #"spin_activate", &spin_activate );
    #/
    
    setup_no_deploy_zones();
}

// Namespace mp_sat_beacon
// Params 0, eflags: 0x4
// Checksum 0xa105bd85, Offset: 0x2c8
// Size: 0x18
function private function_beeef8088df41d84()
{
    level endon( #"game_ended" );
    wait 60;
    spin_activate();
}

// Namespace mp_sat_beacon
// Params 1, eflags: 0x4
// Checksum 0xfd4b8c9e, Offset: 0x2e8
// Size: 0xb3
function private spin_activate( params )
{
    if ( level.var_ef03fedcd5fe1a80 == 0 )
    {
        level.var_ef03fedcd5fe1a80 = 1;
        var_3fbbd2b5f710828e = getentarray( "moving_platform", #script_noteworthy );
        
        foreach ( e_dish in var_3fbbd2b5f710828e )
        {
            moving_platforms::moving_platform_activate( e_dish );
        }
    }
}

// Namespace mp_sat_beacon
// Params 0, eflags: 0x4
// Checksum 0x60cdee7c, Offset: 0x3a3
// Size: 0xd4
function private setup_no_deploy_zones()
{
    var_619d6a48f5a56867 = getentarray( "no_equipment_zone", #script_noteworthy );
    weaponfilter = [ #"dart_mark_zero":1, #"drone_launcher":1 ];
    
    foreach ( var_4f16c60769e4f39a in var_619d6a48f5a56867 )
    {
        var_4f16c60769e4f39a.weaponfilter = weaponfilter;
    }
    
    callback::callback( #"hash_500e33f5505ca842", { #var_619d6a48f5a56867:var_619d6a48f5a56867 } );
}

