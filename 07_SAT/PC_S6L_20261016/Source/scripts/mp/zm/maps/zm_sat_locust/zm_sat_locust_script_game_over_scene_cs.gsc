// scripts\mp\zm\maps\zm_sat_locust\zm_sat_locust_script_game_over_scene_cs.gsc  (hash_56fe2a4a0f6da1a3.gscc) (size: 5500 Bytes / 0x157c / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xa3b17759 (2746316633)
// size ...... 5500 (0x157c)
// includes .. 3   (offset: 0x130c)
// strings ... 21  (offset: 0x1324)
// dev strs .. 0   (offset: 0x157c)
// exports ... 9   (offset: 0xf74)
// cseg ...... 0x362 + 0xc12 (0xf74)
// imports ... 20  (offset: 0x10dc)
// animtree1 . 0   (offset: 0x157c)
// animtree2 . 0   (offset: 0x157c)
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace zm_sat_locust_script_game_over_scene_cs;

// Namespace zm_sat_locust_script_game_over_scene_cs
// Params 0, eflags: 0x5
// Checksum 0xdcf5e76b, Offset: 0x380
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"zm_sat_locust_script_game_over_scene_cs", undefined, &function_b39ecd3d51489472, undefined );
}

// Namespace zm_sat_locust_script_game_over_scene_cs
// Params 0, eflags: 0x4
// Checksum 0x1ad9660b, Offset: 0x3a1
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace zm_sat_locust_script_game_over_scene_cs
// Params 0, eflags: 0x4
// Checksum 0x9fe2b5e7, Offset: 0x3b2
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace zm_sat_locust_script_game_over_scene_cs
// Params 2
// Checksum 0x2f0be3ae, Offset: 0x3c3
// Size: 0x80
function main( unused, unused2 )
{
    if ( utility::flag_exist( "zm_sat_locust_script_game_over_scene_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "zm_sat_locust_script_game_over_scene_cs" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "zm_sat_locust_script_game_over_scene_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "zm_sat_locust_script_game_over_scene_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace zm_sat_locust_script_game_over_scene_cs
// Params 3, eflags: 0x4
// Checksum 0x1c600128, Offset: 0x44b
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "zm_sat_locust_script_game_over_scene_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "zm_sat_locust_script_game_over_scene_cs" );
}

// Namespace zm_sat_locust_script_game_over_scene_cs
// Params 3, eflags: 0x4
// Checksum 0x77748470, Offset: 0x4c5
// Size: 0xa8f
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_game_over_scene_cs";
    s.script_string = "zmb_duo_04,zmb_duo_05,zmb_solo_01,shade_01,zmb_duo_03";
    fe [[ f ]]( s, us, cf, ( 3640, -504, 202.36 ), ( 0, 1, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_game_over_scene_cs";
    s.script_string = "zmb_duo_02,zmb_solo_01,zmb_duo_03";
    fe [[ f ]]( s, us, cf, ( 3808, 212, 156.49 ), ( 0, 96, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_game_over_scene_cs";
    s.script_string = "zmb_solo_01,zmb_solo_02,zmb_duo_03";
    fe [[ f ]]( s, us, cf, ( 3584, 1496, 220.89 ), ( 0, 141, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_game_over_scene_cs";
    s.script_string = "zmb_duo_03";
    fe [[ f ]]( s, us, cf, ( 1468, 1708, 160 ), ( 0, 61, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_game_over_scene_cs";
    s.script_string = "necropincer,zmb_duo_03";
    fe [[ f ]]( s, us, cf, ( 2352, 968, 219.11 ), ( 0, 1, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_game_over_scene_cs";
    s.script_string = "zmb_duo_03";
    fe [[ f ]]( s, us, cf, ( 660, 1860, 160 ), ( 0, 31, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_game_over_scene_cs";
    s.script_string = "zmb_duo_03";
    fe [[ f ]]( s, us, cf, ( 936, 3448, -152 ), ( 0, 211, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_game_over_scene_cs";
    s.script_string = "zmb_duo_05,zmb_duo_03";
    fe [[ f ]]( s, us, cf, ( -328, 4012, 160 ), ( 0, 261, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_game_over_scene_cs";
    s.script_string = "zmb_duo_03,zmb_duo_05,zmb_solo_01,zmb_solo_02,zmb_solo_03,shade_01,callisto_01,necropincer";
    fe [[ f ]]( s, us, cf, ( 1900, 7700, 506.3 ), ( 0, 26, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_game_over_scene_cs";
    s.script_string = "zmb_duo_05,zmb_duo_03";
    fe [[ f ]]( s, us, cf, ( -988, 4588, 160 ), ( 0, 31, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_game_over_scene_cs";
    fe [[ f ]]( s, us, cf, ( 9160, 25928, 4889 ), ( 0, 188.28, 0 ), "sat_cin_zm_vig_plr_dth_virgil_01", undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_game_over_scene_cs";
    s.script_string = "zmb_duo_03";
    fe [[ f ]]( s, us, cf, ( -420, 6528, 304 ), ( 0, 186, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_game_over_scene_cs";
    s.script_string = "zmb_duo_03";
    fe [[ f ]]( s, us, cf, ( -1360, 4996, 160 ), ( 0, 216, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_game_over_scene_cs";
    s.script_string = "zmb_duo_03";
    fe [[ f ]]( s, us, cf, ( -1140, 5940, 352 ), ( 0, 241, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_game_over_scene_cs";
    s.script_string = "zmb_solo_01,zmb_solo_02,shade_01,necropincer,zmb_duo_03";
    fe [[ f ]]( s, us, cf, ( -764, 7076, 258.35 ), ( 0, 26, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_game_over_scene_cs";
    s.script_string = "zmb_duo_03";
    fe [[ f ]]( s, us, cf, ( 3764, 7984, 257.88 ), ( 0, 176, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_game_over_scene_cs";
    s.script_string = "zmb_duo_03";
    fe [[ f ]]( s, us, cf, ( 1156, 5614, 256 ), ( 0, 91, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_game_over_scene_cs";
    s.script_string = "zmb_duo_03";
    fe [[ f ]]( s, us, cf, ( 4308, 6076, 222.15 ), ( 0, 51, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_game_over_scene_cs";
    s.script_string = "zmb_duo_05,zmb_duo_03";
    fe [[ f ]]( s, us, cf, ( 5136, 6080, 223.92 ), ( 0, 116, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_game_over_scene_cs";
    s.script_string = "zmb_duo_03";
    fe [[ f ]]( s, us, cf, ( 5720, 6728, 218.05 ), ( 0, 221, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_game_over_scene_cs";
    s.script_string = "zmb_solo_01,zmb_duo_03";
    fe [[ f ]]( s, us, cf, ( 4774, 5674, 223.97 ), ( 0, 91, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_game_over_scene_cs";
    s.script_string = "zmb_duo_02,shade_01,necropincer,zmb_duo_03";
    fe [[ f ]]( s, us, cf, ( 4584, 4488, 92.2 ), ( 0, 181, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_game_over_scene_cs";
    s.script_string = "shade_01,zmb_duo_03";
    fe [[ f ]]( s, us, cf, ( 5080, 3920, 149.45 ), ( 0, 181, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_game_over_scene_cs";
    s.script_string = "zmb_duo_05,shade_01,zmb_duo_03";
    fe [[ f ]]( s, us, cf, ( 4586, 2746, 176 ), ( 0, 83, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_game_over_scene_cs";
    s.script_string = "zmb_duo_05,zmb_duo_03";
    fe [[ f ]]( s, us, cf, ( 4102, 3578, 114.14 ), ( 0, 156, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_game_over_scene_cs";
    s.script_string = "zmb_duo_04,shade_01,zmb_duo_03,necropincer";
    fe [[ f ]]( s, us, cf, ( 3376, 1928, 222.32 ), ( 0, 91, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_game_over_scene_cs";
    s.script_string = "zmb_duo_05,shade_01,zmb_duo_03";
    fe [[ f ]]( s, us, cf, ( 2812, 3052, 160 ), ( 0, 101, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_game_over_scene_cs";
    s.script_string = "zmb_duo_03";
    fe [[ f ]]( s, us, cf, ( 2702, 3738, 66.64 ), ( 0, 275, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_game_over_scene_cs";
    s.script_string = "necropincer,zmb_duo_03";
    fe [[ f ]]( s, us, cf, ( 5920, 1484, 105.97 ), ( 0, 246, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_game_over_scene_cs";
    s.script_string = "zmb_duo_04,zmb_duo_05,zmb_duo_03";
    fe [[ f ]]( s, us, cf, ( 6972, 2612, 96.04 ), ( 0, 281, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_game_over_scene_cs";
    s.script_string = "zmb_duo_05,shade_01,necropincer,zmb_duo_03";
    fe [[ f ]]( s, us, cf, ( 6448, 1224, 191.5 ), ( 0, 11, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_game_over_scene_cs";
    s.script_string = "zmb_duo_05,necropincer,zmb_duo_03";
    fe [[ f ]]( s, us, cf, ( 1022, 6284, 64 ), ( 0, 271, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_game_over_scene_cs";
    s.script_string = "zmb_duo_03";
    fe [[ f ]]( s, us, cf, ( -428, 5952, 304 ), ( 0, 201, 0 ), undefined, undefined, "zombie_game_over_scene" );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace zm_sat_locust_script_game_over_scene_cs
// Params 0, eflags: 0x4
// Checksum 0x9b88c593, Offset: 0xf5c
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace zm_sat_locust_script_game_over_scene_cs
// Params 0
// Checksum 0xde33dc65, Offset: 0xf66
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "zm_sat_locust_script_game_over_scene_cs" );
}

