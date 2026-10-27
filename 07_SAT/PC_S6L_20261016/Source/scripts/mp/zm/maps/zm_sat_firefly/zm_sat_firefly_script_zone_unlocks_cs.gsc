// scripts\mp\zm\maps\zm_sat_firefly\zm_sat_firefly_script_zone_unlocks_cs.gsc  (hash_7103f5fe5fa999b9.gscc) (size: 2612 Bytes / 0xa34 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x3193ca5c (831769180)
// size ...... 2612 (0xa34)
// includes .. 3   (offset: 0x93c)
// strings ... 12  (offset: 0x954)
// dev strs .. 0   (offset: 0xa34)
// exports ... 9   (offset: 0x5c0)
// cseg ...... 0x175 + 0x44b (0x5c0)
// imports ... 19  (offset: 0x728)
// animtree1 . 0   (offset: 0xa34)
// animtree2 . 0   (offset: 0xa34)
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace zm_sat_firefly_script_zone_unlocks_cs;

// Namespace zm_sat_firefly_script_zone_unlocks_cs
// Params 0, eflags: 0x5
// Checksum 0xc1bb08c2, Offset: 0x193
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"zm_sat_firefly_script_zone_unlocks_cs", undefined, &function_b39ecd3d51489472, undefined );
}

// Namespace zm_sat_firefly_script_zone_unlocks_cs
// Params 0, eflags: 0x4
// Checksum 0x711405b7, Offset: 0x1b4
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace zm_sat_firefly_script_zone_unlocks_cs
// Params 0, eflags: 0x4
// Checksum 0xf42fd65b, Offset: 0x1c5
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace zm_sat_firefly_script_zone_unlocks_cs
// Params 2
// Checksum 0x9e15c68f, Offset: 0x1d6
// Size: 0x70
function main( unused, unused2 )
{
    if ( utility::flag_exist( "zm_sat_firefly_script_zone_unlocks_cs" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "zm_sat_firefly_script_zone_unlocks_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "zm_sat_firefly_script_zone_unlocks_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace zm_sat_firefly_script_zone_unlocks_cs
// Params 3, eflags: 0x4
// Checksum 0x77ad6294, Offset: 0x24e
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "zm_sat_firefly_script_zone_unlocks_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "zm_sat_firefly_script_zone_unlocks_cs" );
}

// Namespace zm_sat_firefly_script_zone_unlocks_cs
// Params 3, eflags: 0x4
// Checksum 0x9451813a, Offset: 0x2c8
// Size: 0x2d8
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_zone_unlocks_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s._size_max = ( 124, 129.436, 127.5 );
    s._size_min = ( 124, 98.5, 108 );
    s.var_987019073a9ea125 = "22740.7";
    s.groupid = "Wood";
    s.height = 128;
    s.length = "128";
    s.name = "noent_volume_trigger_box - launchpad_to_115";
    s.width = "128";
    fe [[ f ]]( s, us, cf, ( -9550.9, -5056.25, 1546 ), ( 0, 308.38, 0 ), "zone_unlock_trig", "launchpad_to_115_ts_db" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_zone_unlocks_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s._size_max = ( 124, 129.436, 127.5 );
    s._size_min = ( 124, 90.5, 108 );
    s.var_987019073a9ea125 = "22740.7";
    s.groupid = "Wood";
    s.height = 128;
    s.length = "128";
    s.name = "noent_volume_trigger_box - 115_to_launchpad";
    s.width = "128";
    fe [[ f ]]( s, us, cf, ( -13638.3, 2241.01, 512 ), ( 0, 286.38, 0 ), "zone_unlock_trig", "115_to_launchpad_ts_db" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_zone_unlocks_cs";
    s.groupid = "Wood";
    fe [[ f ]]( s, us, cf, ( -13628.4, 2244.7, 413 ), ( 0, 105.95, 0 ), "zone_unlock_barrier", "115_to_launchpad_ts_db" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_zone_unlocks_cs";
    s.groupid = "Wood";
    fe [[ f ]]( s, us, cf, ( -9541.91, -5049.95, 1447 ), ( 0, 129.49, 0 ), "zone_unlock_barrier", "launchpad_to_115_ts_db" );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace zm_sat_firefly_script_zone_unlocks_cs
// Params 0, eflags: 0x4
// Checksum 0x396ca23e, Offset: 0x5a8
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace zm_sat_firefly_script_zone_unlocks_cs
// Params 0
// Checksum 0xb5febfd9, Offset: 0x5b2
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "zm_sat_firefly_script_zone_unlocks_cs" );
}

