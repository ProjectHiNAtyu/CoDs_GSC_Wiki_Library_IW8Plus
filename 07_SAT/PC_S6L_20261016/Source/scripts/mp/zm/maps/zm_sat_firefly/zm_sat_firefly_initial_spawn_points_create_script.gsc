// scripts\mp\zm\maps\zm_sat_firefly\zm_sat_firefly_initial_spawn_points_create_script.gsc  (hash_450a0184f0fb3e09.gscc) (size: 2008 Bytes / 0x7d8 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x3ab6c94e (985057614)
// size ...... 2008 (0x7d8)
// includes .. 3   (offset: 0x760)
// strings ... 4   (offset: 0x778)
// dev strs .. 0   (offset: 0x7d8)
// exports ... 9   (offset: 0x3bc)
// cseg ...... 0xc2 + 0x2fa (0x3bc)
// imports ... 20  (offset: 0x524)
// animtree1 . 0   (offset: 0x7d8)
// animtree2 . 0   (offset: 0x7d8)
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace zm_sat_firefly_initial_spawn_points_create_script;

// Namespace zm_sat_firefly_initial_spawn_points_create_script
// Params 0, eflags: 0x5
// Checksum 0x293d3370, Offset: 0xe0
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"zm_sat_firefly_initial_spawn_points_create_script", undefined, &function_b39ecd3d51489472, undefined );
}

// Namespace zm_sat_firefly_initial_spawn_points_create_script
// Params 0, eflags: 0x4
// Checksum 0x4722ecf1, Offset: 0x101
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace zm_sat_firefly_initial_spawn_points_create_script
// Params 0, eflags: 0x4
// Checksum 0xc2193f1d, Offset: 0x112
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace zm_sat_firefly_initial_spawn_points_create_script
// Params 2
// Checksum 0x73883bff, Offset: 0x123
// Size: 0x70
function main( unused, unused2 )
{
    if ( utility::flag_exist( "zm_sat_firefly_initial_spawn_points_create_script" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "zm_sat_firefly_initial_spawn_points_create_script" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "zm_sat_firefly_initial_spawn_points_create_script" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace zm_sat_firefly_initial_spawn_points_create_script
// Params 3, eflags: 0x4
// Checksum 0x419b8bd2, Offset: 0x19b
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "zm_sat_firefly_initial_spawn_points_create_script" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "zm_sat_firefly_initial_spawn_points_create_script" );
}

// Namespace zm_sat_firefly_initial_spawn_points_create_script
// Params 3, eflags: 0x4
// Checksum 0x90dab3d1, Offset: 0x215
// Size: 0x187
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "zm_sat_firefly_initial_spawn_points_create_script";
    s.script_int = int( 1 );
    fe [[ f ]]( s, us, cf, ( 24934.4, 306.23, 414 ), ( 0, 181.35, 0 ), "initial_spawn_points" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_initial_spawn_points_create_script";
    s.script_int = int( 0 );
    fe [[ f ]]( s, us, cf, ( 24932.1, 384.43, 414 ), ( 0, 181.35, 0 ), "initial_spawn_points" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_initial_spawn_points_create_script";
    s.script_int = int( 2 );
    fe [[ f ]]( s, us, cf, ( 24936.6, 233.74, 414 ), ( 0, 181.35, 0 ), "initial_spawn_points" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_initial_spawn_points_create_script";
    s.script_int = int( 3 );
    fe [[ f ]]( s, us, cf, ( 24938.9, 158.1, 414 ), ( 0, 181.35, 0 ), "initial_spawn_points" );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace zm_sat_firefly_initial_spawn_points_create_script
// Params 0, eflags: 0x4
// Checksum 0xd4f15f4e, Offset: 0x3a4
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace zm_sat_firefly_initial_spawn_points_create_script
// Params 0
// Checksum 0x83c8569f, Offset: 0x3ae
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "zm_sat_firefly_initial_spawn_points_create_script" );
}

