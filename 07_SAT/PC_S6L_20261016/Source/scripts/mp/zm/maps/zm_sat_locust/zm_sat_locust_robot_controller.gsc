// scripts\mp\zm\maps\zm_sat_locust\zm_sat_locust_robot_controller.gsc  (hash_67bb89fd60460e95.gscc) (size: 1299 Bytes / 0x513 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xedb2b2b6 (3987911350)
// size ...... 1299 (0x513)
// includes .. 3   (offset: 0x4cb)
// strings ... 4   (offset: 0x4e3)
// dev strs .. 0   (offset: 0x513)
// exports ... 4   (offset: 0x2db)
// cseg ...... 0xa6 + 0x235 (0x2db)
// imports ... 12  (offset: 0x37b)
// animtree1 . 0   (offset: 0x513)
// animtree2 . 0   (offset: 0x513)
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\zm\maps\zm_sat_locust\zm_sat_locust_util;

#namespace zm_sat_locust_robot_controller;

// Namespace zm_sat_locust_robot_controller
// Params 0, eflags: 0x5
// Checksum 0x9c64a608, Offset: 0xc4
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"robot_controllers", undefined, undefined, &post_main );
}

// Namespace zm_sat_locust_robot_controller
// Params 0, eflags: 0x4
// Checksum 0xcf25d9d7, Offset: 0xe5
// Size: 0xa
function private post_main()
{
    level thread init();
}

// Namespace zm_sat_locust_robot_controller
// Params 0, eflags: 0x4
// Checksum 0x41ad6e4a, Offset: 0xf7
// Size: 0x1e4
function private init()
{
    utility::flag_wait( "scriptables_ready" );
    level.robot_controllers = [];
    station_locs = utility::getstructarray( "robot_controller" );
    
    foreach ( loc in station_locs )
    {
        station = utility::spawn_model( %"sat_locust_zm_controller_holder", loc.origin, loc.angles );
        controller_loc = station.origin + anglestoleft( station.angles ) * 2.25;
        controller_loc += ( 0, 0, 8 );
        type = loc.script_noteworthy == "primary" ? %"zmloot_sat_locust_quest_bernard_primary" : %"zmloot_sat_locust_quest_bernard_secondary";
        params = { #spawntype:#"spawn_at_pos", #spawnangles:station.angles, #spawnorigin:controller_loc, #asset:type };
        controller = zm_sat_locust_util::spawn_quest_item( params );
        controller.origin = controller_loc;
        controller setscriptablepartstate( controller function_84ad2f70189ee7c3(), #"hidden" );
        station.controller = controller;
        level.robot_controllers[ loc.script_noteworthy ] = station;
    }
    
    utility::flag_set( "robot_controllers_init" );
}

