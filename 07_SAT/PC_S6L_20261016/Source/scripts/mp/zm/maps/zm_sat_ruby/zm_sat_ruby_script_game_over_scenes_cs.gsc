// scripts\mp\zm\maps\zm_sat_ruby\zm_sat_ruby_script_game_over_scenes_cs.gsc  (hash_4be5615c9312f4c6.gscc) (size: 8602 Bytes / 0x219a / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x8a6a72f2 (2322232050)
// size ...... 8602 (0x219a)
// includes .. 3   (offset: 0x1d12)
// strings ... 28  (offset: 0x1d2a)
// dev strs .. 0   (offset: 0x219a)
// exports ... 9   (offset: 0x197a)
// cseg ...... 0x268 + 0x1712 (0x197a)
// imports ... 20  (offset: 0x1ae2)
// animtree1 . 0   (offset: 0x219a)
// animtree2 . 0   (offset: 0x219a)
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace zm_sat_ruby_script_game_over_scenes_cs;

// Namespace zm_sat_ruby_script_game_over_scenes_cs
// Params 0, eflags: 0x5
// Checksum 0xe76c6db, Offset: 0x286
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"zm_sat_ruby_script_game_over_scenes_cs", undefined, &function_b39ecd3d51489472, undefined );
}

// Namespace zm_sat_ruby_script_game_over_scenes_cs
// Params 0, eflags: 0x4
// Checksum 0x891769fc, Offset: 0x2a7
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace zm_sat_ruby_script_game_over_scenes_cs
// Params 0, eflags: 0x4
// Checksum 0xc2cba10, Offset: 0x2b8
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace zm_sat_ruby_script_game_over_scenes_cs
// Params 2
// Checksum 0xbcc5ec59, Offset: 0x2c9
// Size: 0x80
function main( unused, unused2 )
{
    if ( utility::flag_exist( "zm_sat_ruby_script_game_over_scenes_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "zm_sat_ruby_script_game_over_scenes_cs" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "zm_sat_ruby_script_game_over_scenes_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "zm_sat_ruby_script_game_over_scenes_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace zm_sat_ruby_script_game_over_scenes_cs
// Params 3, eflags: 0x4
// Checksum 0x8fae0edf, Offset: 0x351
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "zm_sat_ruby_script_game_over_scenes_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "zm_sat_ruby_script_game_over_scenes_cs" );
}

// Namespace zm_sat_ruby_script_game_over_scenes_cs
// Params 3, eflags: 0x4
// Checksum 0x129d832, Offset: 0x3cb
// Size: 0x158f
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "zm_sat_ruby_script_game_over_scenes_cs";
    s.groupid = "Mimic";
    s.script_label = "sat_cin_zm_vig_plr_dth_mimic_01";
    fe [[ f ]]( s, us, cf, ( 4416.21, -12.72, -43.5 ), ( 0, 295.1, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_script_game_over_scenes_cs";
    s.groupid = "Base";
    fe [[ f ]]( s, us, cf, ( -1411.95, -302.92, 247.66 ), ( 0, 80.01, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_script_game_over_scenes_cs";
    s.groupid = "Base";
    fe [[ f ]]( s, us, cf, ( -1038.57, 958.92, 251.71 ), ( 0, 30.2, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_script_game_over_scenes_cs";
    s.groupid = "Ravager";
    s.script_parameters = "zombie_shade";
    fe [[ f ]]( s, us, cf, ( 331.14, -2078.76, 208.5 ), ( 354.51, 360, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_script_game_over_scenes_cs";
    s.groupid = "Mimic";
    s.script_label = "sat_cin_zm_vig_plr_dth_mimic_01";
    fe [[ f ]]( s, us, cf, ( -731.68, -575.72, 257.5 ), ( 0, 295.1, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_script_game_over_scenes_cs";
    s.groupid = "Base";
    fe [[ f ]]( s, us, cf, ( 4115.93, -41930.3, -12928.5 ), ( 359.55, 283.92, -0.07 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_script_game_over_scenes_cs";
    s.groupid = "Base";
    fe [[ f ]]( s, us, cf, ( -528.34, -638.06, 260 ), ( 0, 322.68, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_script_game_over_scenes_cs";
    s.groupid = "Ravager";
    s.script_parameters = "zombie_shade";
    fe [[ f ]]( s, us, cf, ( 3741.59, -1153.26, 23 ), ( 0, 286.8, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_script_game_over_scenes_cs";
    s.groupid = "Mimic";
    s.script_label = "sat_cin_zm_vig_plr_dth_mimic_01";
    fe [[ f ]]( s, us, cf, ( 899.77, 720.52, 240 ), ( 0, 351.39, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_script_game_over_scenes_cs";
    s.groupid = "Black_List";
    s.script_string = "mimic,shade,duo_04,duo_05";
    fe [[ f ]]( s, us, cf, ( -76.18, -1455.04, 192.5 ), ( 0, 171.67, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_script_game_over_scenes_cs";
    s.groupid = "Black_List";
    s.script_string = "mimic,duo05";
    fe [[ f ]]( s, us, cf, ( 317.35, -2103.12, 205.5 ), ( 0, 0, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_script_game_over_scenes_cs";
    s.groupid = "Base";
    fe [[ f ]]( s, us, cf, ( 331.65, -2071.11, 206 ), ( 0, 0, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_script_game_over_scenes_cs";
    s.groupid = "Mimic";
    s.script_label = "sat_cin_zm_vig_plr_dth_mimic_01";
    fe [[ f ]]( s, us, cf, ( 965.19, -3251.08, 206.5 ), ( 0, 79.67, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_script_game_over_scenes_cs";
    s.groupid = "Black_List";
    s.script_string = "duo_05";
    fe [[ f ]]( s, us, cf, ( 1379.34, -2708.32, 61.5 ), ( 0, 345.67, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_script_game_over_scenes_cs";
    s.groupid = "Ravager";
    s.script_parameters = "zombie_shade";
    fe [[ f ]]( s, us, cf, ( 864.89, 733.92, 238.5 ), ( 0, 286.8, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_script_game_over_scenes_cs";
    s.groupid = "Mimic";
    s.script_label = "sat_cin_zm_vig_plr_dth_mimic_01";
    fe [[ f ]]( s, us, cf, ( 1303.04, -327.54, 112.55 ), ( 0, 51.45, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_script_game_over_scenes_cs";
    s.groupid = "Base";
    fe [[ f ]]( s, us, cf, ( 1807.69, -2537.27, 58.5 ), ( 0, 321.67, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_script_game_over_scenes_cs";
    s.groupid = "Ravager";
    s.script_parameters = "zombie_shade";
    fe [[ f ]]( s, us, cf, ( 1331.18, -287.17, 108.03 ), ( 0, 286.8, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_script_game_over_scenes_cs";
    s.groupid = "Black_List";
    s.script_string = "duo_04,duo_05,mimic,shade";
    fe [[ f ]]( s, us, cf, ( 2597.23, -2870.34, -6 ), ( 0, 52.67, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_script_game_over_scenes_cs";
    s.groupid = "Ravager";
    s.script_parameters = "zombie_shade";
    fe [[ f ]]( s, us, cf, ( -494.16, -634.13, 255.5 ), ( 0, 230.69, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_script_game_over_scenes_cs";
    s.groupid = "Mimic";
    s.script_label = "sat_cin_zm_vig_plr_dth_mimic_01";
    fe [[ f ]]( s, us, cf, ( 3110.97, -2368.25, -106.5 ), ( 0, 348.75, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_script_game_over_scenes_cs";
    s.groupid = "Black_List";
    s.script_string = "duo_04,duo_05,mimic,shade";
    fe [[ f ]]( s, us, cf, ( 4237.66, -2016.82, 20.5 ), ( 0, 37.75, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_script_game_over_scenes_cs";
    s.groupid = "Black_List";
    s.script_string = "duo_05,mimic";
    fe [[ f ]]( s, us, cf, ( 4729.02, -1705.94, 16 ), ( 0, 119.75, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_script_game_over_scenes_cs";
    s.groupid = "Mimic";
    s.script_label = "sat_cin_zm_vig_plr_dth_mimic_01";
    fe [[ f ]]( s, us, cf, ( 4127.46, -41940, -12926.5 ), ( 0, 51.45, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_script_game_over_scenes_cs";
    s.groupid = "Base";
    fe [[ f ]]( s, us, cf, ( -2849.49, -391.94, -10.76 ), ( 359.55, 0, -0.07 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_script_game_over_scenes_cs";
    s.groupid = "Mimic";
    s.script_label = "sat_cin_zm_vig_plr_dth_mimic_01";
    fe [[ f ]]( s, us, cf, ( -1384.75, -345.77, 244.9 ), ( 0, 51.45, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_script_game_over_scenes_cs";
    s.groupid = "Mimic";
    s.script_label = "sat_cin_zm_vig_plr_dth_mimic_01";
    fe [[ f ]]( s, us, cf, ( 1810.96, -2542.28, 59 ), ( 0, 51.45, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_script_game_over_scenes_cs";
    s.groupid = "Base";
    fe [[ f ]]( s, us, cf, ( 4497.46, -11.01, -41.74 ), ( 0, 224.74, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_script_game_over_scenes_cs";
    s.groupid = "Mimic";
    s.script_label = "sat_cin_zm_vig_plr_dth_mimic_01";
    fe [[ f ]]( s, us, cf, ( 885.1, 31.82, 245.36 ), ( 0, 51.45, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_script_game_over_scenes_cs";
    s.groupid = "Base";
    fe [[ f ]]( s, us, cf, ( 3692.74, 593.11, -43.86 ), ( 0, 271, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_script_game_over_scenes_cs";
    s.groupid = "Ravager";
    s.script_parameters = "zombie_shade";
    fe [[ f ]]( s, us, cf, ( 895.41, 59.47, 243.21 ), ( 0, 230.69, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_script_game_over_scenes_cs";
    s.groupid = "Black_List";
    s.script_string = "mimic,shade,duo_04,duo_05";
    fe [[ f ]]( s, us, cf, ( 2273.98, 1170.19, 130.61 ), ( 0, 60.09, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_script_game_over_scenes_cs";
    s.groupid = "Oscar";
    s.script_parameters = "zombie_galileo";
    fe [[ f ]]( s, us, cf, ( -1384.75, -344.77, 244.4 ), ( 0, 51.45, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_script_game_over_scenes_cs";
    s.groupid = "Base";
    fe [[ f ]]( s, us, cf, ( 1518.02, 1759.59, 260.5 ), ( 0, 262.1, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_script_game_over_scenes_cs";
    s.groupid = "Base";
    fe [[ f ]]( s, us, cf, ( 1533.4, 974.34, 257.5 ), ( 0, 92.09, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_script_game_over_scenes_cs";
    s.groupid = "Oscar";
    s.script_parameters = "zombie_galileo";
    fe [[ f ]]( s, us, cf, ( -629.42, -605.46, 252 ), ( 0, 51.45, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_script_game_over_scenes_cs";
    s.groupid = "Base";
    fe [[ f ]]( s, us, cf, ( 883.19, 775.88, 243 ), ( 0, 301.1, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_script_game_over_scenes_cs";
    s.groupid = "Base";
    fe [[ f ]]( s, us, cf, ( 1182.2, 1464.3, 258.5 ), ( 0, 40.1, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_script_game_over_scenes_cs";
    s.groupid = "Black_List";
    s.script_string = "mimic,duo_05";
    fe [[ f ]]( s, us, cf, ( 795.56, 1768.8, 253 ), ( 0, 165.1, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_script_game_over_scenes_cs";
    s.groupid = "Oscar";
    s.script_parameters = "zombie_galileo";
    fe [[ f ]]( s, us, cf, ( 350.28, -2074.79, 200 ), ( 0, 51.45, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_script_game_over_scenes_cs";
    s.groupid = "Base";
    fe [[ f ]]( s, us, cf, ( 323.58, 1170.68, 255.5 ), ( 0, 165.1, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_script_game_over_scenes_cs";
    s.groupid = "Base";
    fe [[ f ]]( s, us, cf, ( -689.17, 1026.01, 250.07 ), ( 0, 60.03, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_script_game_over_scenes_cs";
    s.groupid = "Base";
    fe [[ f ]]( s, us, cf, ( 871.52, -28.15, 241.5 ), ( 0, 196.03, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_script_game_over_scenes_cs";
    s.groupid = "Black_List";
    s.script_string = "duo_04,duo_05";
    fe [[ f ]]( s, us, cf, ( 1311.47, -348.63, 119.5 ), ( 0, 97.03, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_script_game_over_scenes_cs";
    s.groupid = "Oscar";
    s.script_parameters = "zombie_galileo";
    fe [[ f ]]( s, us, cf, ( 3743.56, 692.52, -46.35 ), ( 0, 51.45, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_script_game_over_scenes_cs";
    s.groupid = "Black_List";
    s.script_string = "duo_04,duo_05,mimic,shade";
    fe [[ f ]]( s, us, cf, ( 2425.87, -271.49, 62 ), ( 0, 135.03, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_script_game_over_scenes_cs";
    s.groupid = "Black_List";
    s.script_string = "mimic,shade,duo_04,duo_05";
    fe [[ f ]]( s, us, cf, ( 1130.08, -1538.26, 207.5 ), ( 0, 306.03, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_script_game_over_scenes_cs";
    s.groupid = "Base";
    s.script_string = "shade";
    fe [[ f ]]( s, us, cf, ( 3243.36, -1134.81, 38.8 ), ( 1.43, 0.04, 0.59 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_script_game_over_scenes_cs";
    s.groupid = "Oscar";
    s.script_parameters = "zombie_galileo";
    fe [[ f ]]( s, us, cf, ( 880, 52.34, 239.81 ), ( 0, 51.45, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_script_game_over_scenes_cs";
    s.groupid = "Mimic";
    s.script_label = "sat_cin_zm_vig_plr_dth_mimic_01";
    fe [[ f ]]( s, us, cf, ( 4832.71, -849.22, 17.5 ), ( 0, 295.1, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_script_game_over_scenes_cs";
    s.groupid = "Base";
    s.script_string = "solo_04";
    fe [[ f ]]( s, us, cf, ( 3306, -2471.5, -115 ), ( 0, 281.1, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_script_game_over_scenes_cs";
    s.groupid = "Oscar";
    s.script_parameters = "zombie_galileo";
    fe [[ f ]]( s, us, cf, ( 3212.37, -1141.94, 36.23 ), ( 0, 51.45, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_script_game_over_scenes_cs";
    s.groupid = "Oscar";
    s.script_parameters = "zombie_galileo";
    fe [[ f ]]( s, us, cf, ( 4117.71, -41935.2, -12932 ), ( 0, 51.45, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_script_game_over_scenes_cs";
    s.groupid = "Neptune";
    fe [[ f ]]( s, us, cf, ( 4096, -41944, -12928 ), ( 0, 0, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_script_game_over_scenes_cs";
    s.groupid = "Uranus";
    fe [[ f ]]( s, us, cf, ( 4120, -41968, -12928 ), ( 0, 0, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_script_game_over_scenes_cs";
    s.name = "sat_cin_zm_vig_player_dth_neptune";
    s.script_label = "sat_cin_zm_vig_player_dth_neptune";
    s.script_scenescriptbundle = "sat_cin_zm_vig_player_dth_neptune";
    fe [[ f ]]( s, us, cf, ( 4113.76, -41952.2, -12932 ), ( 0, 89.96, 0 ), "sat_cin_zm_vig_player_dth_neptune", undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_script_game_over_scenes_cs";
    s.name = "sat_cin_zm_vig_player_dth_uranus";
    s.script_scenescriptbundle = "sat_cin_zm_vig_player_dth_uranus";
    fe [[ f ]]( s, us, cf, ( 4096, -41944, -12928 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_script_game_over_scenes_cs";
    s.groupid = "Oscar";
    s.script_parameters = "zombie_galileo";
    fe [[ f ]]( s, us, cf, ( 4773.09, -1774.04, 22 ), ( 0, 51.45, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_script_game_over_scenes_cs";
    s.is_cs_model = 1;
    s.model = "sat_zm_museum_building_top";
    s.var_8ef9cdfc2a34bab3 = "1";
    fe [[ f ]]( s, us, cf, ( -264.5, 36.5, 1018 ), ( 0, 321.11, 0 ), "broken_museum_building_top" );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace zm_sat_ruby_script_game_over_scenes_cs
// Params 0, eflags: 0x4
// Checksum 0xe5fb9e12, Offset: 0x1962
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace zm_sat_ruby_script_game_over_scenes_cs
// Params 0
// Checksum 0x4dfdd392, Offset: 0x196c
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "zm_sat_ruby_script_game_over_scenes_cs" );
}

