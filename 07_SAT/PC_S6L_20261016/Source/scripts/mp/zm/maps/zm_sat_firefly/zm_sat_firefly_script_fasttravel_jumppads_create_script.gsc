// scripts\mp\zm\maps\zm_sat_firefly\zm_sat_firefly_script_fasttravel_jumppads_create_script.gsc  (hash_1b9abc0e90f6896e.gscc) (size: 2170 Bytes / 0x87a / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x11c11341 (297866049)
// size ...... 2170 (0x87a)
// includes .. 3   (offset: 0x7ca)
// strings ... 10  (offset: 0x7e2)
// dev strs .. 0   (offset: 0x87a)
// exports ... 9   (offset: 0x412)
// cseg ...... 0x165 + 0x2ad (0x412)
// imports ... 21  (offset: 0x57a)
// animtree1 . 0   (offset: 0x87a)
// animtree2 . 0   (offset: 0x87a)
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace zm_sat_firefly_script_fasttravel_jumppads_create_script;

// Namespace zm_sat_firefly_script_fasttravel_jumppads_create_script
// Params 0, eflags: 0x5
// Checksum 0xc61c7572, Offset: 0x183
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"zm_sat_firefly_script_fasttravel_jumppads_create_script", undefined, &function_b39ecd3d51489472, undefined );
}

// Namespace zm_sat_firefly_script_fasttravel_jumppads_create_script
// Params 0, eflags: 0x4
// Checksum 0x7f48ce30, Offset: 0x1a4
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace zm_sat_firefly_script_fasttravel_jumppads_create_script
// Params 0, eflags: 0x4
// Checksum 0xfa731ddc, Offset: 0x1b5
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace zm_sat_firefly_script_fasttravel_jumppads_create_script
// Params 2
// Checksum 0x4a9a4b95, Offset: 0x1c6
// Size: 0x80
function main( unused, unused2 )
{
    if ( utility::flag_exist( "zm_sat_firefly_script_fasttravel_jumppads_create_script" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "zm_sat_firefly_script_fasttravel_jumppads_create_script" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "zm_sat_firefly_script_fasttravel_jumppads_create_script" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "zm_sat_firefly_script_fasttravel_jumppads_create_script" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace zm_sat_firefly_script_fasttravel_jumppads_create_script
// Params 3, eflags: 0x4
// Checksum 0x79f1a913, Offset: 0x24e
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "zm_sat_firefly_script_fasttravel_jumppads_create_script" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "zm_sat_firefly_script_fasttravel_jumppads_create_script" );
}

// Namespace zm_sat_firefly_script_fasttravel_jumppads_create_script
// Params 3, eflags: 0x4
// Checksum 0x2b4c7b49, Offset: 0x2c8
// Size: 0x12a
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_fasttravel_jumppads_create_script";
    s.name = "light_fixture";
    fe [[ f ]]( s, us, cf, ( 24737, 670.76, 733.58 ), ( 297.62, 176.48, -20.52 ), "zm_jumppad_light_fixture" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_fasttravel_jumppads_create_script";
    s.name = "janustowers_farm_handle";
    s.script_parameters = "pad_janustowers,pad_farm";
    s.script_wait_01_max = float( 8 );
    s.script_wait_01_min = float( 6.5 );
    fe [[ f ]]( s, us, cf, ( 18301.8, -2951.56, 5295.37 ), ( 0, 0, 4 ), "path_janustowers,path_farm", "fasttravel_jumppad_paths", "jumppad_path_handle" );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace zm_sat_firefly_script_fasttravel_jumppads_create_script
// Params 0, eflags: 0x4
// Checksum 0x3c8b6071, Offset: 0x3fa
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace zm_sat_firefly_script_fasttravel_jumppads_create_script
// Params 0
// Checksum 0xbba2745e, Offset: 0x404
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "zm_sat_firefly_script_fasttravel_jumppads_create_script" );
}

