// scripts\mp\zm\maps\zm_sat_hornet\zm_sat_hornet_ee_pew_cs.gsc  (hash_1f85f092265ed2e2.gscc) (size: 3538 Bytes / 0xdd2 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x70f0c0d3 (1894826195)
// size ...... 3538 (0xdd2)
// includes .. 2   (offset: 0xc3a)
// strings ... 10  (offset: 0xc4a)
// dev strs .. 0   (offset: 0xdd2)
// exports ... 6   (offset: 0x98a)
// cseg ...... 0xd1 + 0x8b9 (0x98a)
// imports ... 16  (offset: 0xa7a)
// animtree1 . 0   (offset: 0xdd2)
// animtree2 . 0   (offset: 0xdd2)
#using scripts\common\create_script_utility;
#using scripts\common\utility;

#namespace zm_sat_hornet_ee_pew_cs;

// Namespace zm_sat_hornet_ee_pew_cs
// Params 2
// Checksum 0x621eff9e, Offset: 0xef
// Size: 0x80
function main( unused, unused2 )
{
    if ( utility::flag_exist( "zm_sat_hornet_ee_pew_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "zm_sat_hornet_ee_pew_cs" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "zm_sat_hornet_ee_pew_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "zm_sat_hornet_ee_pew_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace zm_sat_hornet_ee_pew_cs
// Params 3, eflags: 0x4
// Checksum 0x51751d18, Offset: 0x177
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "zm_sat_hornet_ee_pew_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "zm_sat_hornet_ee_pew_cs" );
}

// Namespace zm_sat_hornet_ee_pew_cs
// Params 3, eflags: 0x4
// Checksum 0x9673f7a0, Offset: 0x1f1
// Size: 0x779
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_pew_cs";
    s.groupid = "tg";
    fe [[ f ]]( s, us, cf, ( 197.32, -20638.2, 834.37 ), ( 329.58, 333.76, 30.24 ), "pew_tg" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_pew_cs";
    s.groupid = "tg";
    fe [[ f ]]( s, us, cf, ( -28.2, -20754, 760.44 ), ( 347.44, 286, -3.58 ), "pew_tg" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_pew_cs";
    s.groupid = "tg";
    fe [[ f ]]( s, us, cf, ( -264.6, -20583.5, 783.16 ), ( 20.8, 180, -18.3 ), "pew_tg" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_pew_cs";
    s.groupid = "tg";
    fe [[ f ]]( s, us, cf, ( -69.49, -20383.2, 859.31 ), ( 349.76, 99.21, -3.9 ), "pew_tg", undefined, "tg_star" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_pew_cs";
    s.groupid = "tg";
    fe [[ f ]]( s, us, cf, ( -1.75, -20735.6, 918.08 ), ( 339.35, 297.91, 1.93 ), "pew_tg" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_pew_cs";
    s.name = "rt";
    fe [[ f ]]( s, us, cf, ( 86, -20369.8, 765.15 ), ( 345.8, 73.8, 0 ), "pew_fir" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_pew_cs";
    s.groupid = "tg";
    fe [[ f ]]( s, us, cf, ( -280.49, -20731.9, 877.17 ), ( 21.07, 218.26, -26.53 ), "pew_tg" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_pew_cs";
    s.groupid = "tg";
    fe [[ f ]]( s, us, cf, ( -220.44, -20421.6, 938 ), ( 7.23, 125.56, 0.94 ), "pew_tg" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_pew_cs";
    s.groupid = "tg";
    fe [[ f ]]( s, us, cf, ( 102.53, -20455.7, 913.58 ), ( 335.71, 27.93, 5 ), "pew_tg", undefined, "tg_star" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_pew_cs";
    s.groupid = "tg";
    fe [[ f ]]( s, us, cf, ( 71.62, -20626.6, 973.96 ), ( 337.28, 327.21, 29.38 ), "pew_tg" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_pew_cs";
    s.groupid = "tg";
    fe [[ f ]]( s, us, cf, ( -169.9, -20791.4, 981.03 ), ( 346.92, 289.16, -0.57 ), "pew_tg" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_pew_cs";
    s.groupid = "tg";
    fe [[ f ]]( s, us, cf, ( -408.3, -20598.9, 1022.75 ), ( 35.66, 167.98, -22.64 ), "pew_tg" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_pew_cs";
    s.groupid = "tg";
    fe [[ f ]]( s, us, cf, ( -150.19, -20424.5, 1063.9 ), ( 353.27, 82.48, -4.93 ), "pew_tg" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_pew_cs";
    s.groupid = "tg";
    fe [[ f ]]( s, us, cf, ( -65.73, -20693.3, 1082.93 ), ( 340.99, 320.39, 36.36 ), "pew_tg" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_pew_cs";
    s.groupid = "tg";
    fe [[ f ]]( s, us, cf, ( -322.21, -20718.5, 998.02 ), ( 17.75, 228.1, -10.71 ), "pew_tg" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_pew_cs";
    s.groupid = "tg";
    fe [[ f ]]( s, us, cf, ( -280.41, -20427.9, 1149.85 ), ( 8.82, 102.12, 2.75 ), "pew_tg" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_pew_cs";
    s.groupid = "tg";
    fe [[ f ]]( s, us, cf, ( -4.19, -20502.7, 1059.43 ), ( 332.91, 47.56, 3.38 ), "pew_tg" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_pew_cs";
    s.groupid = "tg";
    fe [[ f ]]( s, us, cf, ( -35.02, -20606.9, 1171.65 ), ( 346.1, 334.81, 22.47 ), "pew_tg" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_pew_cs";
    s.groupid = "tg";
    fe [[ f ]]( s, us, cf, ( -261.99, -20745.8, 1181.51 ), ( 357.33, 271.57, 4.67 ), "pew_tg" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_pew_cs";
    s.groupid = "tg";
    fe [[ f ]]( s, us, cf, ( -468.02, -20457.5, 1238.61 ), ( 23.59, 128.03, -7.53 ), "pew_tg" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_pew_cs";
    s.groupid = "tg";
    fe [[ f ]]( s, us, cf, ( -239.91, -20414.3, 1279.76 ), ( 10.46, 91.59, -4.46 ), "pew_tg" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_pew_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s._size_max = ( 178, 32, 226 );
    s._size_min = ( 266, 162, 32 );
    s.height = 128;
    s.length = "128";
    s.width = "128";
    fe [[ f ]]( s, us, cf, ( 5, -19696, 643 ), ( 0, 11.2, 0 ), "pew_tgtvis" );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace zm_sat_hornet_ee_pew_cs
// Params 0, eflags: 0x4
// Checksum 0x80fe1254, Offset: 0x972
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace zm_sat_hornet_ee_pew_cs
// Params 0
// Checksum 0x9326c055, Offset: 0x97c
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "zm_sat_hornet_ee_pew_cs" );
}

