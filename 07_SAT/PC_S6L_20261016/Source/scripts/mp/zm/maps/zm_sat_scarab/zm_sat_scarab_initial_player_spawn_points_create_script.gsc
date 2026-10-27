// scripts\mp\zm\maps\zm_sat_scarab\zm_sat_scarab_initial_player_spawn_points_create_script.gsc  (hash_3edb54a989eaa411.gscc) (size: 2194 Bytes / 0x892 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x95061a35 (2500205109)
// size ...... 2194 (0x892)
// includes .. 3   (offset: 0x7f6)
// strings ... 6   (offset: 0x80e)
// dev strs .. 0   (offset: 0x892)
// exports ... 9   (offset: 0x436)
// cseg ...... 0xe8 + 0x34e (0x436)
// imports ... 21  (offset: 0x59e)
// animtree1 . 0   (offset: 0x892)
// animtree2 . 0   (offset: 0x892)
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace zm_sat_scarab_initial_player_spawn_points_create_script;

// Namespace zm_sat_scarab_initial_player_spawn_points_create_script
// Params 0, eflags: 0x5
// Checksum 0x72c184da, Offset: 0x106
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"zm_sat_scarab_initial_player_spawn_points_create_script", undefined, &function_b39ecd3d51489472, undefined );
}

// Namespace zm_sat_scarab_initial_player_spawn_points_create_script
// Params 0, eflags: 0x4
// Checksum 0x2281a924, Offset: 0x127
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace zm_sat_scarab_initial_player_spawn_points_create_script
// Params 0, eflags: 0x4
// Checksum 0xa7ba7ac8, Offset: 0x138
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace zm_sat_scarab_initial_player_spawn_points_create_script
// Params 2
// Checksum 0x17532c81, Offset: 0x149
// Size: 0x80
function main( unused, unused2 )
{
    if ( utility::flag_exist( "zm_sat_scarab_initial_player_spawn_points_create_script" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "zm_sat_scarab_initial_player_spawn_points_create_script" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "zm_sat_scarab_initial_player_spawn_points_create_script" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "zm_sat_scarab_initial_player_spawn_points_create_script" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace zm_sat_scarab_initial_player_spawn_points_create_script
// Params 3, eflags: 0x4
// Checksum 0x2438ce07, Offset: 0x1d1
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "zm_sat_scarab_initial_player_spawn_points_create_script" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "zm_sat_scarab_initial_player_spawn_points_create_script" );
}

// Namespace zm_sat_scarab_initial_player_spawn_points_create_script
// Params 3, eflags: 0x4
// Checksum 0x346df938, Offset: 0x24b
// Size: 0x1cb
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "zm_sat_scarab_initial_player_spawn_points_create_script";
    s.script_int = int( 1 );
    s.script_label = "spawn_room_1";
    fe [[ f ]]( s, us, cf, ( 409.4, -3852.97, 1890.5 ), ( 0, 155.95, 0 ), "initial_spawn_points" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_initial_player_spawn_points_create_script";
    s.script_int = int( 3 );
    s.script_label = "spawn_room_1";
    fe [[ f ]]( s, us, cf, ( 277, -3938, 1907 ), ( 6.1, 66, -0 ), "initial_spawn_points" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_initial_player_spawn_points_create_script";
    s.script_int = int( 2 );
    s.script_label = "spawn_room_2";
    fe [[ f ]]( s, us, cf, ( -310.41, -4115.56, 1965.5 ), ( 0, 53.07, 0 ), "initial_spawn_points" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_initial_player_spawn_points_create_script";
    s.script_int = int( 0 );
    s.script_label = "spawn_room_2";
    fe [[ f ]]( s, us, cf, ( -302.2, -4273.3, 1980 ), ( 0, 62.97, 0 ), "initial_spawn_points" );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace zm_sat_scarab_initial_player_spawn_points_create_script
// Params 0, eflags: 0x4
// Checksum 0x17fdd4fd, Offset: 0x41e
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace zm_sat_scarab_initial_player_spawn_points_create_script
// Params 0
// Checksum 0xe66b134a, Offset: 0x428
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "zm_sat_scarab_initial_player_spawn_points_create_script" );
}

