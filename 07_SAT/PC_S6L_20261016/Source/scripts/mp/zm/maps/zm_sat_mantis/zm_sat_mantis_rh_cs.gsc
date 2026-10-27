// scripts\mp\zm\maps\zm_sat_mantis\zm_sat_mantis_rh_cs.gsc  (hash_64223754fd3b0447.gscc) (size: 4303 Bytes / 0x10cf / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x92f460da (2465489114)
// size ...... 4303 (0x10cf)
// includes .. 3   (offset: 0xe97)
// strings ... 23  (offset: 0xeaf)
// dev strs .. 0   (offset: 0x10cf)
// exports ... 9   (offset: 0xaff)
// cseg ...... 0x139 + 0x9c6 (0xaff)
// imports ... 20  (offset: 0xc67)
// animtree1 . 0   (offset: 0x10cf)
// animtree2 . 0   (offset: 0x10cf)
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace zm_sat_mantis_rh_cs;

// Namespace zm_sat_mantis_rh_cs
// Params 0, eflags: 0x5
// Checksum 0x13bc5994, Offset: 0x157
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"zm_sat_mantis_rh_cs", undefined, &function_b39ecd3d51489472, undefined );
}

// Namespace zm_sat_mantis_rh_cs
// Params 0, eflags: 0x4
// Checksum 0xa1700aa, Offset: 0x178
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace zm_sat_mantis_rh_cs
// Params 0, eflags: 0x4
// Checksum 0x8f2cd346, Offset: 0x189
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace zm_sat_mantis_rh_cs
// Params 2
// Checksum 0x3fc5850f, Offset: 0x19a
// Size: 0x80
function main( unused, unused2 )
{
    if ( utility::flag_exist( "zm_sat_mantis_rh_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "zm_sat_mantis_rh_cs" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "zm_sat_mantis_rh_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "zm_sat_mantis_rh_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace zm_sat_mantis_rh_cs
// Params 3, eflags: 0x4
// Checksum 0xcae6789, Offset: 0x222
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "zm_sat_mantis_rh_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "zm_sat_mantis_rh_cs" );
}

// Namespace zm_sat_mantis_rh_cs
// Params 3, eflags: 0x4
// Checksum 0x9a893d06, Offset: 0x29c
// Size: 0x843
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "zm_sat_mantis_rh_cs";
    fe [[ f ]]( s, us, cf, ( 78488.7, -31681.8, 42.25 ), ( 0, 150, 0 ), "phone" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_rh_cs";
    fe [[ f ]]( s, us, cf, ( 78606.2, -30267.3, -78 ), ( 0, 247.15, 0 ), "bb_gun_1" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_rh_cs";
    fe [[ f ]]( s, us, cf, ( 78583.2, -30321.1, -83.75 ), ( 0, 247.15, 0 ), "bb_gun_2" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_rh_cs";
    fe [[ f ]]( s, us, cf, ( 78583.2, -30321.4, -127.5 ), ( 0, 247.15, 0 ), "bb_gun_3" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_rh_cs";
    fe [[ f ]]( s, us, cf, ( 56106.4, -31365.8, 52 ), ( 19.54, 239.83, 80.35 ), "lion", undefined, "1" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_rh_cs";
    fe [[ f ]]( s, us, cf, ( 55328.1, -29517.6, -45.5 ), ( 25.57, 18.69, 108.33 ), "lion", undefined, "2" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_rh_cs";
    fe [[ f ]]( s, us, cf, ( 53717.1, -32222.6, 78 ), ( 358.49, 138.25, -89.57 ), "lion", undefined, "3" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_rh_cs";
    fe [[ f ]]( s, us, cf, ( 53676.6, -32751.2, -52.75 ), ( 20.1, 150.68, 79.84 ), "lion", undefined, "4" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_rh_cs";
    fe [[ f ]]( s, us, cf, ( 55015.1, -33267.1, -59.25 ), ( 349.89, 4.1, 9.93 ), "lion", undefined, "5" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_rh_cs";
    fe [[ f ]]( s, us, cf, ( 54449.9, -31418.1, 46 ), ( 46.64, 301.35, 89.6 ), "lion", undefined, "6" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_rh_cs";
    fe [[ f ]]( s, us, cf, ( 55323.1, -31343.3, -1.25 ), ( 331.59, 341.15, 109.52 ), "cat", undefined, "arm_r" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_rh_cs";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( 55310.1, -31350.6, -0.5 ), ( 12.91, 354.76, 107.55 ), "cat", undefined, "arm_l" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_rh_cs";
    fe [[ f ]]( s, us, cf, ( 55295.6, -31342.8, -0.75 ), ( 12.91, 354.76, 107.55 ), "cat", undefined, "leg_l" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_rh_cs";
    fe [[ f ]]( s, us, cf, ( 55312.6, -31335.6, 5.25 ), ( 272.99, 180, 180 ), "tiger_cub" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_rh_cs";
    s.groupid = "goat";
    fe [[ f ]]( s, us, cf, ( 55065.1, -31545.8, -97.25 ), ( 2.46, 49.15, 2.84 ), "goat", undefined, "1" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_rh_cs";
    s.groupid = "goat";
    fe [[ f ]]( s, us, cf, ( 53881.9, -32301.3, 31.75 ), ( 2.46, 49.15, 2.84 ), "goat", undefined, "2" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_rh_cs";
    s.groupid = "goat";
    fe [[ f ]]( s, us, cf, ( 55827.4, -31026.1, 68.5 ), ( 2.46, 49.15, 2.84 ), "goat" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_rh_cs";
    s.groupid = "goat";
    fe [[ f ]]( s, us, cf, ( 55387.6, -30667.6, 51.25 ), ( 2.46, 49.15, 2.84 ), "goat" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_rh_cs";
    s.groupid = "goat";
    fe [[ f ]]( s, us, cf, ( 56034.1, -30588.1, -40.75 ), ( 2.46, 49.15, 2.84 ), "goat" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_rh_cs";
    s.groupid = "goat";
    fe [[ f ]]( s, us, cf, ( 55910.4, -31587.1, 45.5 ), ( 356.26, 183.86, -0.25 ), "goat" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_rh_cs";
    s.groupid = "goat";
    fe [[ f ]]( s, us, cf, ( 55514.1, -30967.1, 24.25 ), ( 356.26, 183.86, -0.25 ), "goat" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_rh_cs";
    s.groupid = "goat";
    fe [[ f ]]( s, us, cf, ( 54668.6, -31800.3, -14.5 ), ( 356.26, 183.86, -0.25 ), "goat" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_rh_cs";
    s.groupid = "goat";
    fe [[ f ]]( s, us, cf, ( 54358.4, -32426.6, -25.5 ), ( 356.26, 183.86, -0.25 ), "goat" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_rh_cs";
    s.groupid = "goat";
    fe [[ f ]]( s, us, cf, ( 53423.6, -32776.9, -52.75 ), ( 356.26, 183.86, -0.25 ), "goat" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_rh_cs";
    s.groupid = "goat";
    fe [[ f ]]( s, us, cf, ( 55039.4, -30701.6, -43 ), ( 356.26, 183.86, -0.25 ), "goat" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_rh_cs";
    fe [[ f ]]( s, us, cf, ( 55297.4, -31327.3, -1 ), ( 12.91, 354.76, 107.55 ), "tiger" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_rh_cs";
    fe [[ f ]]( s, us, cf, ( 55310.4, -31322.3, 1.5 ), ( 12.91, 354.76, 107.55 ), "tiger" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_rh_cs";
    fe [[ f ]]( s, us, cf, ( 55321.1, -31328.3, -0.5 ), ( 12.91, 354.76, 107.55 ), "tiger" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_rh_cs";
    fe [[ f ]]( s, us, cf, ( 78593, -30310.6, -90.75 ), ( 0, 338, 0 ), "piano" );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace zm_sat_mantis_rh_cs
// Params 0, eflags: 0x4
// Checksum 0x37fdea05, Offset: 0xae7
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace zm_sat_mantis_rh_cs
// Params 0
// Checksum 0xcefdbac4, Offset: 0xaf1
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "zm_sat_mantis_rh_cs" );
}

