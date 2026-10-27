// scripts\mp\zm\maps\zm_sat_locust\zm_sat_locust_quest_pap_cs.gsc  (hash_01bd1e1a3c000c2f.gscc) (size: 2675 Bytes / 0xa73 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x9affd1af (2600456623)
// size ...... 2675 (0xa73)
// includes .. 3   (offset: 0x96b)
// strings ... 14  (offset: 0x983)
// dev strs .. 0   (offset: 0xa73)
// exports ... 9   (offset: 0x5d3)
// cseg ...... 0x177 + 0x45c (0x5d3)
// imports ... 20  (offset: 0x73b)
// animtree1 . 0   (offset: 0xa73)
// animtree2 . 0   (offset: 0xa73)
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace zm_sat_locust_quest_pap_cs;

// Namespace zm_sat_locust_quest_pap_cs
// Params 0, eflags: 0x5
// Checksum 0xee9d824e, Offset: 0x195
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"zm_sat_locust_quest_pap_cs", undefined, &function_b39ecd3d51489472, undefined );
}

// Namespace zm_sat_locust_quest_pap_cs
// Params 0, eflags: 0x4
// Checksum 0xc742aeea, Offset: 0x1b6
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace zm_sat_locust_quest_pap_cs
// Params 0, eflags: 0x4
// Checksum 0x42797d06, Offset: 0x1c7
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace zm_sat_locust_quest_pap_cs
// Params 2
// Checksum 0xf2902b4f, Offset: 0x1d8
// Size: 0x80
function main( unused, unused2 )
{
    if ( utility::flag_exist( "zm_sat_locust_quest_pap_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "zm_sat_locust_quest_pap_cs" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "zm_sat_locust_quest_pap_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "zm_sat_locust_quest_pap_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace zm_sat_locust_quest_pap_cs
// Params 3, eflags: 0x4
// Checksum 0xc1fbc9c9, Offset: 0x260
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "zm_sat_locust_quest_pap_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "zm_sat_locust_quest_pap_cs" );
}

// Namespace zm_sat_locust_quest_pap_cs
// Params 3, eflags: 0x4
// Checksum 0xb1de0bdc, Offset: 0x2da
// Size: 0x2d9
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "zm_sat_locust_quest_pap_cs";
    fe [[ f ]]( s, us, cf, ( 4496, 5662, 272 ), ( 0, 214.3, 0 ), "quest_pap_ambrose", undefined, "shoulder_power" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_quest_pap_cs";
    fe [[ f ]]( s, us, cf, ( 37.5, 6314, 352 ), ( 0, 211, 0 ), "quest_pap_ambrose", undefined, "foot_power" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_quest_pap_cs";
    fe [[ f ]]( s, us, cf, ( 3038, 9558, 1650 ), ( 0, 62, 0 ), "quest_pap_terminal" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_quest_pap_cs";
    fe [[ f ]]( s, us, cf, ( 890, 3733, 42 ), ( 0, 0, -90 ), "locust_pap_zm_tube_loot_0" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_quest_pap_cs";
    fe [[ f ]]( s, us, cf, ( 3912, 3546, 99.66 ), ( 0, 0, -90 ), "locust_pap_zm_tube_loot_1" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_quest_pap_cs";
    fe [[ f ]]( s, us, cf, ( -2121, 5533, 383 ), ( 0, 30, 0 ), "robot_controller", undefined, "primary" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_quest_pap_cs";
    fe [[ f ]]( s, us, cf, ( 1704, 5844, 234 ), ( 0, 0, 0 ), "quest_pap_circle", undefined, undefined, undefined, undefined, undefined, undefined, 1440 );
    s = {};
    s.script_cs_flag = "zm_sat_locust_quest_pap_cs";
    fe [[ f ]]( s, us, cf, ( -1964, 5394, 352 ), ( 0, 30, 0 ), "quest_pap_spawn_area", undefined, undefined, undefined, undefined, undefined, undefined, 96 );
    s = {};
    s.script_cs_flag = "zm_sat_locust_quest_pap_cs";
    fe [[ f ]]( s, us, cf, ( -2082, 5598, 352 ), ( 0, 30, 0 ), "quest_pap_spawn_area", undefined, undefined, undefined, undefined, undefined, undefined, 96 );
    s = {};
    s.script_cs_flag = "zm_sat_locust_quest_pap_cs";
    fe [[ f ]]( s, us, cf, ( -2004, 5718.5, 396 ), ( 0, 119, 0 ), "quest_pap_reader" );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace zm_sat_locust_quest_pap_cs
// Params 0, eflags: 0x4
// Checksum 0xe3e7bdd9, Offset: 0x5bb
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace zm_sat_locust_quest_pap_cs
// Params 0
// Checksum 0x3a81484, Offset: 0x5c5
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "zm_sat_locust_quest_pap_cs" );
}

