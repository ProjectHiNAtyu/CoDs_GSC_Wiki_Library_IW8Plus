// scripts\mp\zm\maps\zm_sat_mantis\zm_sat_mantis_script_game_over_scenes_create_script.gsc  (hash_3063302fdc3cc018.gscc) (size: 7767 Bytes / 0x1e57 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x2215ea36 (571861558)
// size ...... 7767 (0x1e57)
// includes .. 3   (offset: 0x1a8b)
// strings ... 20  (offset: 0x1aa3)
// dev strs .. 0   (offset: 0x1e57)
// exports ... 9   (offset: 0x16f3)
// cseg ...... 0x233 + 0x14c0 (0x16f3)
// imports ... 20  (offset: 0x185b)
// animtree1 . 0   (offset: 0x1e57)
// animtree2 . 0   (offset: 0x1e57)
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace zm_sat_mantis_script_game_over_scenes_create_script;

// Namespace zm_sat_mantis_script_game_over_scenes_create_script
// Params 0, eflags: 0x5
// Checksum 0x235f3d5f, Offset: 0x251
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"zm_sat_mantis_script_game_over_scenes_create_script", undefined, &function_b39ecd3d51489472, undefined );
}

// Namespace zm_sat_mantis_script_game_over_scenes_create_script
// Params 0, eflags: 0x4
// Checksum 0xf7314346, Offset: 0x272
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace zm_sat_mantis_script_game_over_scenes_create_script
// Params 0, eflags: 0x4
// Checksum 0x720a90aa, Offset: 0x283
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace zm_sat_mantis_script_game_over_scenes_create_script
// Params 2
// Checksum 0xc2e3c6e3, Offset: 0x294
// Size: 0x80
function main( unused, unused2 )
{
    if ( utility::flag_exist( "zm_sat_mantis_script_game_over_scenes_create_script" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "zm_sat_mantis_script_game_over_scenes_create_script" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "zm_sat_mantis_script_game_over_scenes_create_script" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "zm_sat_mantis_script_game_over_scenes_create_script" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace zm_sat_mantis_script_game_over_scenes_create_script
// Params 3, eflags: 0x4
// Checksum 0xf1882465, Offset: 0x31c
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "zm_sat_mantis_script_game_over_scenes_create_script" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "zm_sat_mantis_script_game_over_scenes_create_script" );
}

// Namespace zm_sat_mantis_script_game_over_scenes_create_script
// Params 3, eflags: 0x4
// Checksum 0xf1526cf5, Offset: 0x396
// Size: 0x133d
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_game_over_scenes_create_script";
    s.groupid = "methone";
    s.script_label = "sat_cin_zm_vig_plr_dth_methone_01";
    fe [[ f ]]( s, us, cf, ( 77433.3, -31748, -134.68 ), ( 0.16, 222.4, 0.51 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_game_over_scenes_create_script";
    s.groupid = "methone";
    s.script_label = "sat_cin_zm_vig_plr_dth_methone_01";
    fe [[ f ]]( s, us, cf, ( 56801.8, -31995.9, -121.25 ), ( 0, 323.1, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_game_over_scenes_create_script";
    s.groupid = "methone";
    s.script_label = "sat_cin_zm_vig_plr_dth_methone_01";
    fe [[ f ]]( s, us, cf, ( 76605.5, -31912.5, -124 ), ( 1.45, 279.62, 0.63 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_game_over_scenes_create_script";
    s.groupid = "methone";
    s.script_label = "sat_cin_zm_vig_plr_dth_methone_01";
    fe [[ f ]]( s, us, cf, ( 78383, -30567.8, -125.96 ), ( 0.28, 91.98, -0.46 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_game_over_scenes_create_script";
    s.groupid = "mimic";
    s.script_label = "sat_cin_zm_vig_plr_dth_mimic_01";
    fe [[ f ]]( s, us, cf, ( 54854, -31820.4, -133.09 ), ( 1.3, 221.6, -0.9 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_game_over_scenes_create_script";
    s.script_label = "sat_cin_zm_vig_plr_dth_methone_01";
    s.script_scenescriptbundle = "sat_cin_zm_vig_plr_dth_methone_01";
    fe [[ f ]]( s, us, cf, ( 53982, -32830, -132 ), ( 0, 48.6, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_game_over_scenes_create_script";
    s.groupid = "BlackList";
    s.script_string = "mimic,methone";
    fe [[ f ]]( s, us, cf, ( 53819.4, -31646.2, -122.5 ), ( 0, 298.68, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_game_over_scenes_create_script";
    fe [[ f ]]( s, us, cf, ( 54121.7, -32020.9, -123 ), ( 359.43, 282.69, -0.12 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_game_over_scenes_create_script";
    s.script_label = "sat_cin_zm_vig_plr_dth_mimic_01";
    s.script_scenescriptbundle = "sat_cin_zm_vig_plr_dth_mimic_01";
    fe [[ f ]]( s, us, cf, ( 53891, -32915, -131 ), ( 0, 30, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_game_over_scenes_create_script";
    s.groupid = "mimic";
    s.script_label = "sat_cin_zm_vig_plr_dth_mimic_01";
    fe [[ f ]]( s, us, cf, ( 54160.6, -32084.7, -120.03 ), ( 358.53, 97.62, -0.58 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_game_over_scenes_create_script";
    s.script_string = "mimic,methone";
    fe [[ f ]]( s, us, cf, ( 53906, -32838.8, -124.87 ), ( 0.09, 220.68, -0.37 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_game_over_scenes_create_script";
    s.groupid = "BlackList";
    s.script_string = "mimic,methone";
    fe [[ f ]]( s, us, cf, ( 54106, -33306.2, -120.25 ), ( 0, 32.68, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_game_over_scenes_create_script";
    fe [[ f ]]( s, us, cf, ( 54683, -32790.1, -123 ), ( 0, 118.68, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_game_over_scenes_create_script";
    s.groupid = "BlackList";
    s.script_string = "methone,mimic";
    fe [[ f ]]( s, us, cf, ( 55016.3, -32271.2, -122.19 ), ( 0.23, 127.34, -0.03 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_game_over_scenes_create_script";
    fe [[ f ]]( s, us, cf, ( 55204.4, -30790.7, -122.14 ), ( 1.05, 290.4, 0.44 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_game_over_scenes_create_script";
    s.script_string = "methone";
    fe [[ f ]]( s, us, cf, ( 55800.9, -30391.9, -125.24 ), ( 1.39, 316.69, 0.49 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_game_over_scenes_create_script";
    s.groupid = "BlackList";
    s.script_string = "mimic,methone";
    fe [[ f ]]( s, us, cf, ( 56245.4, -30953.6, -123.56 ), ( 6.88, 118.53, -1.21 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_game_over_scenes_create_script";
    s.script_string = "mimic,methone";
    fe [[ f ]]( s, us, cf, ( 55849.3, -31451.5, -119.41 ), ( 0, 202.68, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_game_over_scenes_create_script";
    fe [[ f ]]( s, us, cf, ( 56899.6, -32263.5, -128.51 ), ( 0.03, 202.67, -3.65 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_game_over_scenes_create_script";
    fe [[ f ]]( s, us, cf, ( 56897.7, -31620.8, -120.29 ), ( 359.46, 330.57, -0.01 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_game_over_scenes_create_script";
    s.groupid = "BlackList";
    s.script_string = "mimic,methone,duo_05,ghoul";
    fe [[ f ]]( s, us, cf, ( 56518.9, -31373.5, -119.5 ), ( 0, 142.68, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_game_over_scenes_create_script";
    s.script_string = "mimic,methone,duo_05,duo_04,ghoul";
    fe [[ f ]]( s, us, cf, ( 56167, -31597.6, -120 ), ( 0, 142.68, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_game_over_scenes_create_script";
    s.script_string = "mimic,methone";
    fe [[ f ]]( s, us, cf, ( 56443.1, -31750.1, 16 ), ( 0, 122.68, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_game_over_scenes_create_script";
    fe [[ f ]]( s, us, cf, ( 54847, -31868.3, -131.98 ), ( 359.43, 244.69, -0.23 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_game_over_scenes_create_script";
    s.groupid = "mimic";
    s.script_label = "sat_cin_zm_vig_plr_dth_mimic_01";
    fe [[ f ]]( s, us, cf, ( 77441.1, -31834.3, -133.41 ), ( 1.3, 221.6, -0.9 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_game_over_scenes_create_script";
    s.groupid = "BlackList";
    s.script_string = "mimic,methone";
    fe [[ f ]]( s, us, cf, ( 55245, -30208.5, 23.5 ), ( 0, 86.68, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_game_over_scenes_create_script";
    s.groupid = "methone";
    s.script_label = "sat_cin_zm_vig_plr_dth_methone_01";
    fe [[ f ]]( s, us, cf, ( 55822.2, -30571.9, -125.96 ), ( 0, 74.68, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_game_over_scenes_create_script";
    s.groupid = "BlackList";
    s.script_string = "mimic,methone,ghoul";
    fe [[ f ]]( s, us, cf, ( 55335.7, -30454.3, -120 ), ( 0, 120.68, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_game_over_scenes_create_script";
    fe [[ f ]]( s, us, cf, ( 54841.2, -30202.3, -120 ), ( 0, 24.68, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_game_over_scenes_create_script";
    s.groupid = "methone";
    s.script_label = "sat_cin_zm_vig_plr_dth_methone_01";
    fe [[ f ]]( s, us, cf, ( 54931.4, -30249.1, -116.5 ), ( 0, 98.31, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_game_over_scenes_create_script";
    fe [[ f ]]( s, us, cf, ( 55091.7, -29543, -127.51 ), ( 359.94, 204.68, 0.14 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_game_over_scenes_create_script";
    s.groupid = "methone";
    s.script_label = "sat_cin_zm_vig_plr_dth_methone_01";
    fe [[ f ]]( s, us, cf, ( 56767.3, -31592.5, -119.64 ), ( 0, 312.61, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_game_over_scenes_create_script";
    s.groupid = "mimic";
    s.script_label = "sat_cin_zm_vig_plr_dth_mimic_01";
    fe [[ f ]]( s, us, cf, ( 76747.7, -32098.6, -120.34 ), ( 358.53, 97.62, -0.58 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_game_over_scenes_create_script";
    s.groupid = "methone";
    s.script_label = "sat_cin_zm_vig_plr_dth_methone_01";
    fe [[ f ]]( s, us, cf, ( 77449.8, -30204.3, -120.5 ), ( 0, 95, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_game_over_scenes_create_script";
    s.groupid = "methone";
    s.script_label = "sat_cin_zm_vig_plr_dth_methone_01";
    fe [[ f ]]( s, us, cf, ( 54725.6, -32748.8, -118 ), ( 0.38, 136.48, -0.38 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_game_over_scenes_create_script";
    fe [[ f ]]( s, us, cf, ( 79478, -31621.6, -116 ), ( 0, 63.2, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_game_over_scenes_create_script";
    fe [[ f ]]( s, us, cf, ( 76773.3, -32095.5, -122 ), ( 359.08, 130.71, -1.29 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_game_over_scenes_create_script";
    s.groupid = "BlackList";
    s.script_string = "mimic,methone";
    fe [[ f ]]( s, us, cf, ( 76291, -31591.9, -122 ), ( 0, 314.68, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_game_over_scenes_create_script";
    s.groupid = "BlackList";
    s.script_string = "duo_05";
    fe [[ f ]]( s, us, cf, ( 78005.6, -31473.8, -134.25 ), ( 0, 11.2, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_game_over_scenes_create_script";
    s.groupid = "BlackList";
    s.script_string = "mimic,methone";
    fe [[ f ]]( s, us, cf, ( 76143.1, -32550, -120.88 ), ( 0, 226.68, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_game_over_scenes_create_script";
    s.script_string = "mimic,methone,duo_04";
    fe [[ f ]]( s, us, cf, ( 76452, -32803.1, -130.58 ), ( 0, 218.68, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_game_over_scenes_create_script";
    s.script_string = "mimic,methone";
    fe [[ f ]]( s, us, cf, ( 76739.1, -33224, -124.75 ), ( 0, 212.68, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_game_over_scenes_create_script";
    s.script_string = "duo_04";
    fe [[ f ]]( s, us, cf, ( 77207, -32794.1, -123 ), ( 0, 128.68, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_game_over_scenes_create_script";
    s.script_string = "mimic,methone";
    fe [[ f ]]( s, us, cf, ( 77628, -32323.9, -121.8 ), ( 359.8, 312.68, 0.11 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_game_over_scenes_create_script";
    s.groupid = "BlackList";
    s.script_string = "duo_05";
    fe [[ f ]]( s, us, cf, ( 77744.6, -30863.5, -121.93 ), ( 0.75, 316.69, 0.86 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_game_over_scenes_create_script";
    fe [[ f ]]( s, us, cf, ( 78328.9, -30391.9, -125.24 ), ( 1.39, 316.69, 0.49 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_game_over_scenes_create_script";
    s.script_string = "mimic,methone";
    fe [[ f ]]( s, us, cf, ( 78754.8, -30877.5, -126.05 ), ( 0, 180, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_game_over_scenes_create_script";
    fe [[ f ]]( s, us, cf, ( 79425.3, -32240.5, -125.08 ), ( 0.03, 58.67, -3.65 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_game_over_scenes_create_script";
    s.groupid = "methone";
    s.script_label = "sat_cin_zm_vig_plr_dth_methone_01";
    fe [[ f ]]( s, us, cf, ( 79244.2, -31590.2, -119.42 ), ( 359.46, 329.65, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_game_over_scenes_create_script";
    s.groupid = "BlackList";
    s.script_string = "mimic,methone,duo_05,ghoul,duo_04";
    fe [[ f ]]( s, us, cf, ( 79049.1, -31422, -117.5 ), ( 0, 142.68, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_game_over_scenes_create_script";
    s.groupid = "BlackList";
    s.script_string = "mimic,methone,duo_05,duo_04,ghoul";
    fe [[ f ]]( s, us, cf, ( 78920.2, -31712.8, -119.5 ), ( 0, 142.68, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_game_over_scenes_create_script";
    s.groupid = "BlackList";
    s.script_string = "mimic,methone,duo_05";
    fe [[ f ]]( s, us, cf, ( 78904.5, -31631.1, 16.5 ), ( 0, 236.96, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_game_over_scenes_create_script";
    fe [[ f ]]( s, us, cf, ( 77409.3, -31850.3, -133.6 ), ( 359.43, 244.69, -0.23 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_game_over_scenes_create_script";
    s.groupid = "BlackList";
    s.script_string = "mimic,methone,duo_05,duo_04";
    fe [[ f ]]( s, us, cf, ( 77770.6, -30262.3, 16.5 ), ( 0, 148.68, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_game_over_scenes_create_script";
    s.groupid = "BlackList";
    s.script_string = "mimic,methone,duo_05,duo_04,ghoul";
    fe [[ f ]]( s, us, cf, ( 77861.3, -30493.7, -119.5 ), ( 0, 120.68, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_game_over_scenes_create_script";
    fe [[ f ]]( s, us, cf, ( 77109.7, -29824.2, -129.29 ), ( 1.64, 24.67, -0.26 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_game_over_scenes_create_script";
    fe [[ f ]]( s, us, cf, ( 77603.6, -29578.4, -128.2 ), ( 359.94, 204.68, 0.14 ), undefined, undefined, "zombie_game_over_scene" );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace zm_sat_mantis_script_game_over_scenes_create_script
// Params 0, eflags: 0x4
// Checksum 0x72b96cd2, Offset: 0x16db
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace zm_sat_mantis_script_game_over_scenes_create_script
// Params 0
// Checksum 0x33dbf928, Offset: 0x16e5
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "zm_sat_mantis_script_game_over_scenes_create_script" );
}

