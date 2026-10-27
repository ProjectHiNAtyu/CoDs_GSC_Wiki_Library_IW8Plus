// scripts\mp\zm\maps\zm_sat_locust\zm_sat_locust_oob_cs.gsc  (hash_6af0a2034c151aa7.gscc) (size: 2353 Bytes / 0x931 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xb06d6a19 (2959960601)
// size ...... 2353 (0x931)
// includes .. 3   (offset: 0x881)
// strings ... 8   (offset: 0x899)
// dev strs .. 0   (offset: 0x931)
// exports ... 9   (offset: 0x4e9)
// cseg ...... 0xd8 + 0x411 (0x4e9)
// imports ... 20  (offset: 0x651)
// animtree1 . 0   (offset: 0x931)
// animtree2 . 0   (offset: 0x931)
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace zm_sat_locust_oob_cs;

// Namespace zm_sat_locust_oob_cs
// Params 0, eflags: 0x5
// Checksum 0x8c4a24be, Offset: 0xf6
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"zm_sat_locust_oob_cs", undefined, &function_b39ecd3d51489472, undefined );
}

// Namespace zm_sat_locust_oob_cs
// Params 0, eflags: 0x4
// Checksum 0x15653476, Offset: 0x117
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace zm_sat_locust_oob_cs
// Params 0, eflags: 0x4
// Checksum 0x905ee79a, Offset: 0x128
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace zm_sat_locust_oob_cs
// Params 2
// Checksum 0x20b7b1d3, Offset: 0x139
// Size: 0x80
function main( unused, unused2 )
{
    if ( utility::flag_exist( "zm_sat_locust_oob_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "zm_sat_locust_oob_cs" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "zm_sat_locust_oob_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "zm_sat_locust_oob_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace zm_sat_locust_oob_cs
// Params 3, eflags: 0x4
// Checksum 0x13dc5355, Offset: 0x1c1
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "zm_sat_locust_oob_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "zm_sat_locust_oob_cs" );
}

// Namespace zm_sat_locust_oob_cs
// Params 3, eflags: 0x4
// Checksum 0xfc46c2cb, Offset: 0x23b
// Size: 0x28e
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "zm_sat_locust_oob_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s._size_max = ( 1020, 3452, 44 );
    s._size_min = ( 1356, 2424, 576 );
    s.height = 128;
    s.length = "128";
    s.width = "128";
    fe [[ f ]]( s, us, cf, ( 8444, 25612, 4556 ), ( 0, 5, 0 ), "OutOfBounds" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_oob_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s._size_max = ( 40, 99, 54 );
    s._size_min = ( 32, 32, 32 );
    s.groupid = "Life Brush Wall Jump";
    s.height = 32;
    s.length = "32";
    s.width = "32";
    fe [[ f ]]( s, us, cf, ( 1864, 6234, 206 ), ( 0, 357.4, 0 ), "fishery_island_life" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_oob_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s._size_max = ( 448, 1472, 40 );
    s._size_min = ( 1056, 1280, 576 );
    s.height = 128;
    s.length = "128";
    s.width = "128";
    fe [[ f ]]( s, us, cf, ( -2144, 4640, -160 ), ( 0, 30, 0 ), "OutOfBounds" );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace zm_sat_locust_oob_cs
// Params 0, eflags: 0x4
// Checksum 0xcc9219f1, Offset: 0x4d1
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace zm_sat_locust_oob_cs
// Params 0
// Checksum 0xd18f8e18, Offset: 0x4db
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "zm_sat_locust_oob_cs" );
}

