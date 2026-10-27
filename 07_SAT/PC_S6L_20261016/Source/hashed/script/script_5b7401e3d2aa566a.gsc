// script_5b7401e3d2aa566a  (hash_5b7401e3d2aa566a.gscc) (size: 6944 Bytes / 0x1b20 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x19bdf91e (431880478)
// size ...... 6944 (0x1b20)
// includes .. 3   (offset: 0x17c0)
// strings ... 17  (offset: 0x17d8)
// dev strs .. 0   (offset: 0x1b20)
// exports ... 9   (offset: 0x1428)
// cseg ...... 0x195 + 0x1293 (0x1428)
// imports ... 20  (offset: 0x1590)
// animtree1 . 0   (offset: 0x1b20)
// animtree2 . 0   (offset: 0x1b20)
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace mp_sat_avalon_quad_01_ob_infil_cs;

// Namespace mp_sat_avalon_quad_01_ob_infil_cs
// Params 0, eflags: 0x5
// Checksum 0x51bff0cc, Offset: 0x1b3
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"mp_sat_avalon_quad_01_ob_infil_cs", undefined, &function_b39ecd3d51489472, undefined );
}

// Namespace mp_sat_avalon_quad_01_ob_infil_cs
// Params 0, eflags: 0x4
// Checksum 0x5ea28b2f, Offset: 0x1d4
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace mp_sat_avalon_quad_01_ob_infil_cs
// Params 0, eflags: 0x4
// Checksum 0xdb9958c3, Offset: 0x1e5
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace mp_sat_avalon_quad_01_ob_infil_cs
// Params 2
// Checksum 0x6b700e8a, Offset: 0x1f6
// Size: 0x80
function main( unused, unused2 )
{
    if ( utility::flag_exist( "mp_sat_avalon_quad_01_ob_infil_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "mp_sat_avalon_quad_01_ob_infil_cs" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "mp_sat_avalon_quad_01_ob_infil_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "mp_sat_avalon_quad_01_ob_infil_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace mp_sat_avalon_quad_01_ob_infil_cs
// Params 3, eflags: 0x4
// Checksum 0x581bec0c, Offset: 0x27e
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "mp_sat_avalon_quad_01_ob_infil_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "mp_sat_avalon_quad_01_ob_infil_cs" );
}

// Namespace mp_sat_avalon_quad_01_ob_infil_cs
// Params 3, eflags: 0x4
// Checksum 0x6f379a6f, Offset: 0x2f8
// Size: 0x1110
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_01_ob_infil_cs";
    s.name = "infil_point_taurus";
    s.script_priority = "0";
    fe [[ f ]]( s, us, cf, ( -17478, 5984, 3884.42 ), ( 0, 135, 0 ), "ob_infil_point_taurus_intro", "cspf_0_auto6191598395827237319", undefined, undefined, undefined, undefined, undefined, 115 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_01_ob_infil_cs";
    s.name = "infil_point_taurus";
    s.script_priority = "1";
    fe [[ f ]]( s, us, cf, ( -17315.5, 5642, 3825.42 ), ( 0, 135, 0 ), "ob_infil_point_taurus_intro", undefined, undefined, undefined, undefined, undefined, undefined, 160 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_01_ob_infil_cs";
    s.name = "infil_point_taurus";
    s.script_priority = "2";
    fe [[ f ]]( s, us, cf, ( -16552, 5090, 3925.92 ), ( 0, 135, 0 ), "ob_infil_point_taurus_intro", undefined, undefined, undefined, undefined, undefined, undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_01_ob_infil_cs";
    s.name = "infil_point_libra";
    s.script_priority = "2";
    fe [[ f ]]( s, us, cf, ( -45880.5, 6047.89, 309.92 ), ( 0, 270, 0 ), "ob_infil_point_libra_launch", undefined, undefined, undefined, undefined, undefined, undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_01_ob_infil_cs";
    s.name = "infil_point_libra";
    s.script_priority = "1";
    fe [[ f ]]( s, us, cf, ( -46455.6, 6116.5, 309.92 ), ( 0, 270, 0 ), "ob_infil_point_libra_launch", undefined, undefined, undefined, undefined, undefined, undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_01_ob_infil_cs";
    s.name = "infil_point_libra";
    s.script_priority = "0";
    fe [[ f ]]( s, us, cf, ( -46920, 5925, 309.92 ), ( 0, 270, 0 ), "ob_infil_point_libra_launch", undefined, undefined, undefined, undefined, undefined, undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_01_ob_infil_cs";
    s.name = "infil_point";
    fe [[ f ]]( s, us, cf, ( -54344, 16506, 5000 ), ( 0, 0, 0 ), "ob_infil_point" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_01_ob_infil_cs";
    s.name = "infil_point_taurus";
    s.script_priority = "0";
    fe [[ f ]]( s, us, cf, ( -17531.5, 5909.5, 3884.42 ), ( 0, 135, 0 ), "cspf_0_auto6191598395827237319", undefined, undefined, undefined, undefined, undefined, undefined, 20 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_01_ob_infil_cs";
    s.name = "infil_point";
    s.tier = "4";
    fe [[ f ]]( s, us, cf, ( -58939, 350, 5000 ), ( 0, 0, 0 ), "ob_infil_point" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_01_ob_infil_cs";
    s.name = "infil_point_gemini";
    fe [[ f ]]( s, us, cf, ( -19808, 17632, 1645.68 ), ( 0, 259, 0 ), "ob_infil_point_gemini_launch", undefined, undefined, undefined, undefined, undefined, undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_01_ob_infil_cs";
    s.name = "infil_point_gemini";
    fe [[ f ]]( s, us, cf, ( -21546, 16236, 1381.28 ), ( 0, 263, 0 ), "ob_infil_point_gemini_launch", undefined, undefined, undefined, undefined, undefined, undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_01_ob_infil_cs";
    s.name = "infil_point_gemini";
    fe [[ f ]]( s, us, cf, ( -21972, 17582, 1603.58 ), ( 0, 277, 0 ), "ob_infil_point_gemini_launch", undefined, undefined, undefined, undefined, undefined, undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_01_ob_infil_cs";
    s.name = "infil_point";
    s.tier = "4";
    fe [[ f ]]( s, us, cf, ( -57185, 737, 5000 ), ( 0, 0, 0 ), "ob_infil_point" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_01_ob_infil_cs";
    s.name = "infil_point";
    s.tier = "4";
    fe [[ f ]]( s, us, cf, ( -55481, 95, 5000 ), ( 0, 0, 0 ), "ob_infil_point" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_01_ob_infil_cs";
    s.name = "infil_point";
    s.tier = "4";
    fe [[ f ]]( s, us, cf, ( -53976, 920, 5000 ), ( 0, 0, 0 ), "ob_infil_point" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_01_ob_infil_cs";
    s.name = "infil_point";
    s.tier = "4";
    fe [[ f ]]( s, us, cf, ( -52284, 2197, 5000 ), ( 0, 0, 0 ), "ob_infil_point" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_01_ob_infil_cs";
    s.name = "infil_point";
    s.tier = "4";
    fe [[ f ]]( s, us, cf, ( -50500, 3810, 5000 ), ( 0, 0, 0 ), "ob_infil_point" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_01_ob_infil_cs";
    s.name = "infil_point";
    s.tier = "4";
    fe [[ f ]]( s, us, cf, ( -49045, 5546, 5000 ), ( 0, 0, 0 ), "ob_infil_point" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_01_ob_infil_cs";
    s.name = "infil_point";
    s.tier = "4";
    fe [[ f ]]( s, us, cf, ( -46121, 6744, 5000 ), ( 0, 0, 0 ), "ob_infil_point" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_01_ob_infil_cs";
    s.name = "infil_point";
    fe [[ f ]]( s, us, cf, ( -57749, 4122, 5000 ), ( 0, 0, 0 ), "ob_infil_point" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_01_ob_infil_cs";
    s.name = "infil_point";
    fe [[ f ]]( s, us, cf, ( -57353, 7657, 5000 ), ( 0, 0, 0 ), "ob_infil_point" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_01_ob_infil_cs";
    s.name = "infil_point";
    fe [[ f ]]( s, us, cf, ( -56106, 10655, 5000 ), ( 0, 0, 0 ), "ob_infil_point" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_01_ob_infil_cs";
    s.name = "infil_point";
    fe [[ f ]]( s, us, cf, ( -55105, 14510.5, 5000 ), ( 0, 0, 0 ), "ob_infil_point" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_01_ob_infil_cs";
    s.name = "infil_point";
    fe [[ f ]]( s, us, cf, ( -54174.5, 17373, 5000 ), ( 0, 0, 0 ), "ob_infil_point" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_01_ob_infil_cs";
    s.name = "infil_point";
    fe [[ f ]]( s, us, cf, ( -53218, 20586, 5000 ), ( 0, 0, 0 ), "ob_infil_point" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_01_ob_infil_cs";
    s.name = "infil_point";
    fe [[ f ]]( s, us, cf, ( -52248, 22494, 5000 ), ( 0, 0, 0 ), "ob_infil_point" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_01_ob_infil_cs";
    s.name = "infil_point";
    fe [[ f ]]( s, us, cf, ( -51281, 24627, 5000 ), ( 0, 0, 0 ), "ob_infil_point" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_01_ob_infil_cs";
    s.name = "infil_point";
    fe [[ f ]]( s, us, cf, ( -50564, 26712, 5000 ), ( 0, 0, 0 ), "ob_infil_point" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_01_ob_infil_cs";
    s.name = "infil_point";
    fe [[ f ]]( s, us, cf, ( -48952, 30294, 5000 ), ( 0, 0, 0 ), "ob_infil_point" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_01_ob_infil_cs";
    s.name = "infil_point";
    fe [[ f ]]( s, us, cf, ( -46305, 33274, 5000 ), ( 0, 0, 0 ), "ob_infil_point" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_01_ob_infil_cs";
    s.name = "infil_point";
    fe [[ f ]]( s, us, cf, ( -44369, 36333, 5000 ), ( 0, 0, 0 ), "ob_infil_point" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_01_ob_infil_cs";
    s.name = "infil_point";
    fe [[ f ]]( s, us, cf, ( -41880, 38936, 5000 ), ( 0, 0, 0 ), "ob_infil_point" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_01_ob_infil_cs";
    s.name = "infil_point";
    fe [[ f ]]( s, us, cf, ( -40394, 41102, 5000 ), ( 0, 0, 0 ), "ob_infil_point" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_01_ob_infil_cs";
    s.name = "infil_point";
    fe [[ f ]]( s, us, cf, ( -38873, 42723, 5000 ), ( 0, 0, 0 ), "ob_infil_point" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_01_ob_infil_cs";
    s.name = "infil_point";
    fe [[ f ]]( s, us, cf, ( -35932, 46068, 5000 ), ( 0, 0, 0 ), "ob_infil_point" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_01_ob_infil_cs";
    fe [[ f ]]( s, us, cf, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_01_ob_infil_cs";
    s.name = "infil_point";
    fe [[ f ]]( s, us, cf, ( -35345, 49661, 5000 ), ( 0, 0, 0 ), "ob_infil_point" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_01_ob_infil_cs";
    s.name = "infil_point";
    fe [[ f ]]( s, us, cf, ( -33703, 53374, 5000 ), ( 0, 0, 0 ), "ob_infil_point" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_01_ob_infil_cs";
    s.name = "infil_point";
    fe [[ f ]]( s, us, cf, ( -30991, 55983, 5000 ), ( 0, 0, 0 ), "ob_infil_point" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_01_ob_infil_cs";
    s.name = "infil_point";
    fe [[ f ]]( s, us, cf, ( -27794, 57480, 5000 ), ( 0, 0, 0 ), "ob_infil_point" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_01_ob_infil_cs";
    s.name = "infil_point";
    fe [[ f ]]( s, us, cf, ( -24099, 58620, 5000 ), ( 0, 0, 0 ), "ob_infil_point" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_01_ob_infil_cs";
    s.name = "infil_point";
    fe [[ f ]]( s, us, cf, ( -20354, 58990, 5000 ), ( 0, 0, 0 ), "ob_infil_point" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_01_ob_infil_cs";
    s.name = "infil_point";
    fe [[ f ]]( s, us, cf, ( -18162, 59485, 5000 ), ( 0, 0, 0 ), "ob_infil_point" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_01_ob_infil_cs";
    s.name = "infil_point";
    fe [[ f ]]( s, us, cf, ( -14704, 59646, 5000 ), ( 0, 0, 0 ), "ob_infil_point" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_01_ob_infil_cs";
    s.name = "infil_point";
    fe [[ f ]]( s, us, cf, ( -11447, 59913, 5000 ), ( 0, 0, 0 ), "ob_infil_point" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_01_ob_infil_cs";
    s.name = "infil_point";
    fe [[ f ]]( s, us, cf, ( -7433, 60335, 5000 ), ( 0, 0, 0 ), "ob_infil_point" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_01_ob_infil_cs";
    s.name = "infil_point";
    fe [[ f ]]( s, us, cf, ( -3634, 60287, 5000 ), ( 0, 0, 0 ), "ob_infil_point" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_01_ob_infil_cs";
    s.name = "infil_point_taurus";
    s.script_priority = "1";
    fe [[ f ]]( s, us, cf, ( -17505.5, 5941, 3884.42 ), ( 0, 135, 0 ), "cspf_0_auto6191598395827237319", undefined, undefined, undefined, undefined, undefined, undefined, 20 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_01_ob_infil_cs";
    s.name = "infil_point_taurus";
    s.script_priority = "2";
    fe [[ f ]]( s, us, cf, ( -17480, 5973.5, 3884.42 ), ( 0, 135, 0 ), "cspf_0_auto6191598395827237319", undefined, undefined, undefined, undefined, undefined, undefined, 20 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_01_ob_infil_cs";
    s.name = "infil_point_taurus";
    s.script_priority = "3";
    fe [[ f ]]( s, us, cf, ( -17455.5, 6007, 3884.42 ), ( 0, 135, 0 ), "cspf_0_auto6191598395827237319", undefined, undefined, undefined, undefined, undefined, undefined, 20 );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace mp_sat_avalon_quad_01_ob_infil_cs
// Params 0, eflags: 0x4
// Checksum 0x8e5d5e8c, Offset: 0x1410
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace mp_sat_avalon_quad_01_ob_infil_cs
// Params 0
// Checksum 0x9a483141, Offset: 0x141a
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "mp_sat_avalon_quad_01_ob_infil_cs" );
}

