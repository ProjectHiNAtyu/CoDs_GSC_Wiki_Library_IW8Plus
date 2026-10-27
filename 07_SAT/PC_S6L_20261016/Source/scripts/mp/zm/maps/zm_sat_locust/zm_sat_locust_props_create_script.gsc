// scripts\mp\zm\maps\zm_sat_locust\zm_sat_locust_props_create_script.gsc  (hash_0631987ad084b1d1.gscc) (size: 3611 Bytes / 0xe1b / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x330deb6c (856550252)
// size ...... 3611 (0xe1b)
// includes .. 3   (offset: 0xc97)
// strings ... 16  (offset: 0xcaf)
// dev strs .. 0   (offset: 0xe1b)
// exports ... 9   (offset: 0x8ff)
// cseg ...... 0x13b + 0x7c4 (0x8ff)
// imports ... 20  (offset: 0xa67)
// animtree1 . 0   (offset: 0xe1b)
// animtree2 . 0   (offset: 0xe1b)
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace zm_sat_locust_props_create_script;

// Namespace zm_sat_locust_props_create_script
// Params 0, eflags: 0x5
// Checksum 0x2a161b0b, Offset: 0x159
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"zm_sat_locust_props_create_script", undefined, &function_b39ecd3d51489472, undefined );
}

// Namespace zm_sat_locust_props_create_script
// Params 0, eflags: 0x4
// Checksum 0xd7251865, Offset: 0x17a
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace zm_sat_locust_props_create_script
// Params 0, eflags: 0x4
// Checksum 0x521ecb89, Offset: 0x18b
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace zm_sat_locust_props_create_script
// Params 2
// Checksum 0xe2f79dc0, Offset: 0x19c
// Size: 0x80
function main( unused, unused2 )
{
    if ( utility::flag_exist( "zm_sat_locust_props_create_script" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "zm_sat_locust_props_create_script" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "zm_sat_locust_props_create_script" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "zm_sat_locust_props_create_script" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace zm_sat_locust_props_create_script
// Params 3, eflags: 0x4
// Checksum 0xd19c7f46, Offset: 0x224
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "zm_sat_locust_props_create_script" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "zm_sat_locust_props_create_script" );
}

// Namespace zm_sat_locust_props_create_script
// Params 3, eflags: 0x4
// Checksum 0x4119f498, Offset: 0x29e
// Size: 0x641
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "zm_sat_locust_props_create_script";
    fe [[ f ]]( s, us, cf, ( -3894.94, 9402, 659.07 ), ( 27.92, 209.26, 2.44 ), "dh_1" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_props_create_script";
    fe [[ f ]]( s, us, cf, ( -3872.48, 9412.03, 661.44 ), ( 34.8, 4.99, -2.63 ), "dh_1" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_props_create_script";
    fe [[ f ]]( s, us, cf, ( 7811.17, 8267.6, 1240.68 ), ( 24.19, 142.09, -0.75 ), "dh_2" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_props_create_script";
    fe [[ f ]]( s, us, cf, ( -3876.3, 9395.83, 659.54 ), ( 16.1, 218.56, 1.09 ), "dh_1" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_props_create_script";
    fe [[ f ]]( s, us, cf, ( -3880.16, 9420.85, 660.68 ), ( 5.44, 96.8, -4.46 ), "dh_1" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_props_create_script";
    fe [[ f ]]( s, us, cf, ( 7829.56, 8251.12, 1241.35 ), ( 39.35, 300.11, -1.17 ), "dh_2" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_props_create_script";
    fe [[ f ]]( s, us, cf, ( 3439.99, -4150.21, 149.23 ), ( 9.6, 109.82, 0.9 ), "dh_3" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_props_create_script";
    fe [[ f ]]( s, us, cf, ( 7810.21, 8248.5, 1240.73 ), ( 20.51, 262.7, 30.38 ), "dh_2" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_props_create_script";
    fe [[ f ]]( s, us, cf, ( 7834.02, 8262.47, 1241.33 ), ( 4.15, 31.41, 0.07 ), "dh_2" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_props_create_script";
    fe [[ f ]]( s, us, cf, ( 3446.67, -4168.62, 151.43 ), ( 43.45, 261.77, -10.54 ), "dh_3" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_props_create_script";
    fe [[ f ]]( s, us, cf, ( -2292.43, 3733.01, 1903.52 ), ( 25.66, 141.76, 0.27 ), "dh_4" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_props_create_script";
    fe [[ f ]]( s, us, cf, ( 3430.37, -4163.91, 150.39 ), ( 25.85, 224.06, 15.51 ), "dh_3" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_props_create_script";
    fe [[ f ]]( s, us, cf, ( 3457.39, -4163.58, 151.09 ), ( 10.66, 0.37, 0.73 ), "dh_3" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_props_create_script";
    fe [[ f ]]( s, us, cf, ( -2275.14, 3715.82, 1904.88 ), ( 37.64, 299.11, -1.54 ), "dh_4" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_props_create_script";
    fe [[ f ]]( s, us, cf, ( -2293.65, 3713.93, 1904.11 ), ( 18.96, 262.23, 31.24 ), "dh_4" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_props_create_script";
    fe [[ f ]]( s, us, cf, ( -2269.66, 3727.6, 1904.56 ), ( 4.48, 30.51, -1.64 ), "dh_4" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_props_create_script";
    fe [[ f ]]( s, us, cf, ( 5182.81, 4215.5, 244.74 ), ( 359.64, 270.2, 91.58 ), "dh_gh_1" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_props_create_script";
    fe [[ f ]]( s, us, cf, ( 5352.42, 3640.95, 234.92 ), ( 0.39, 90.2, 90.72 ), "dh_gh_3" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_props_create_script";
    fe [[ f ]]( s, us, cf, ( 5012.5, 4214.9, 242.82 ), ( 359.64, 270.2, 91.58 ), "dh_gh_2" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_props_create_script";
    fe [[ f ]]( s, us, cf, ( 4838.51, 3641.25, 241.39 ), ( 0.39, 90.2, 90.72 ), "dh_gh_4" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_props_create_script";
    fe [[ f ]]( s, us, cf, ( 1797.8, 4984.97, 57 ), ( 0, 0, 0 ), "bridge_trigger" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_props_create_script";
    fe [[ f ]]( s, us, cf, ( 2517.38, 4137.93, 57 ), ( 0, 0, 0 ), "water_trigger" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_props_create_script";
    fe [[ f ]]( s, us, cf, ( 1025.57, 3495.04, -8.98 ), ( 0, 0, 0 ), "cannon_trigger" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_props_create_script";
    fe [[ f ]]( s, us, cf, ( 6631.9, 2682.2, 120.9 ), ( 0, 0, 0 ), "ion_trigger" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_props_create_script";
    fe [[ f ]]( s, us, cf, ( 4654.31, 3160.64, 211.32 ), ( 0, 0, 0 ), "fruit_trigger" );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace zm_sat_locust_props_create_script
// Params 0, eflags: 0x4
// Checksum 0x77ea10f9, Offset: 0x8e7
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace zm_sat_locust_props_create_script
// Params 0
// Checksum 0x13cfa20b, Offset: 0x8f1
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "zm_sat_locust_props_create_script" );
}

