// scripts\mp\zm\maps\zm_sat_locust\zm_sat_locust_ee_gnomes_cs.gsc  (hash_7fdd626f44af312d.gscc) (size: 2301 Bytes / 0x8fd / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x9ffab4f2 (2684007666)
// size ...... 2301 (0x8fd)
// includes .. 3   (offset: 0x849)
// strings ... 6   (offset: 0x861)
// dev strs .. 0   (offset: 0x8fd)
// exports ... 9   (offset: 0x4b1)
// cseg ...... 0xbd + 0x3f4 (0x4b1)
// imports ... 20  (offset: 0x619)
// animtree1 . 0   (offset: 0x8fd)
// animtree2 . 0   (offset: 0x8fd)
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace zm_sat_locust_ee_gnomes_cs;

// Namespace zm_sat_locust_ee_gnomes_cs
// Params 0, eflags: 0x5
// Checksum 0xadcdd920, Offset: 0xdb
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"zm_sat_locust_ee_gnomes_cs", undefined, &function_b39ecd3d51489472, undefined );
}

// Namespace zm_sat_locust_ee_gnomes_cs
// Params 0, eflags: 0x4
// Checksum 0xc67a4416, Offset: 0xfc
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace zm_sat_locust_ee_gnomes_cs
// Params 0, eflags: 0x4
// Checksum 0x434197fa, Offset: 0x10d
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace zm_sat_locust_ee_gnomes_cs
// Params 2
// Checksum 0xf3a8c1b3, Offset: 0x11e
// Size: 0x80
function main( unused, unused2 )
{
    if ( utility::flag_exist( "zm_sat_locust_ee_gnomes_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "zm_sat_locust_ee_gnomes_cs" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "zm_sat_locust_ee_gnomes_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "zm_sat_locust_ee_gnomes_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace zm_sat_locust_ee_gnomes_cs
// Params 3, eflags: 0x4
// Checksum 0xc0c32335, Offset: 0x1a6
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "zm_sat_locust_ee_gnomes_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "zm_sat_locust_ee_gnomes_cs" );
}

// Namespace zm_sat_locust_ee_gnomes_cs
// Params 3, eflags: 0x4
// Checksum 0xbe08e7d4, Offset: 0x220
// Size: 0x271
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_gnomes_cs";
    fe [[ f ]]( s, us, cf, ( 7445.22, 1365.82, 1420.7 ), ( 358.43, 25.6, 1.7 ), "eegn_gn_wo" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_gnomes_cs";
    fe [[ f ]]( s, us, cf, ( 985.91, 1227.42, 318.05 ), ( 357.87, 215.16, -2.21 ), "eegn_gn_wo" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_gnomes_cs";
    fe [[ f ]]( s, us, cf, ( -2420.96, 7045.59, 799.91 ), ( 0, 5.92, 0 ), "eegn_gn_wo" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_gnomes_cs";
    fe [[ f ]]( s, us, cf, ( 3020.5, 3827, 148 ), ( 0, 326.83, 0 ), "eegn_gn_as" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_gnomes_cs";
    fe [[ f ]]( s, us, cf, ( 3015.5, 3789, 139.5 ), ( 0, 9.19, 0 ), "eegn_gn_as" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_gnomes_cs";
    fe [[ f ]]( s, us, cf, ( 3005.5, 3799, 146 ), ( 0, 338.16, 0 ), "eegn_gn_as" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_gnomes_cs";
    fe [[ f ]]( s, us, cf, ( 3041.5, 3829, 139.5 ), ( 0, 306.6, 0 ), "eegn_gn_as" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_gnomes_cs";
    fe [[ f ]]( s, us, cf, ( 4959.72, 7429.48, 348.9 ), ( 0, 280, 0 ), "eegn_gn_wo" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_gnomes_cs";
    fe [[ f ]]( s, us, cf, ( 3024.25, 3808.75, 140 ), ( 0, 336.18, 0 ), "eegn_gn_in" );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace zm_sat_locust_ee_gnomes_cs
// Params 0, eflags: 0x4
// Checksum 0xd0afd43b, Offset: 0x499
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace zm_sat_locust_ee_gnomes_cs
// Params 0
// Checksum 0x290fe78, Offset: 0x4a3
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "zm_sat_locust_ee_gnomes_cs" );
}

