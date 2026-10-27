// scripts\mp\zm\maps\zm_sat_scarab\zm_sat_scarab_script_game_over_scenes_cs.gsc  (hash_2a2c8cea1d25d816.gscc) (size: 14541 Bytes / 0x38cd / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x9d073228 (2634494504)
// size ...... 14541 (0x38cd)
// includes .. 3   (offset: 0x30b5)
// strings ... 33  (offset: 0x30cd)
// dev strs .. 0   (offset: 0x38cd)
// exports ... 9   (offset: 0x2cf9)
// cseg ...... 0x4a6 + 0x2853 (0x2cf9)
// imports ... 21  (offset: 0x2e61)
// animtree1 . 0   (offset: 0x38cd)
// animtree2 . 0   (offset: 0x38cd)
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace zm_sat_scarab_script_game_over_scenes_cs;

// Namespace zm_sat_scarab_script_game_over_scenes_cs
// Params 0, eflags: 0x5
// Checksum 0x915a4e7e, Offset: 0x4c4
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"zm_sat_scarab_script_game_over_scenes_cs", undefined, &function_b39ecd3d51489472, undefined );
}

// Namespace zm_sat_scarab_script_game_over_scenes_cs
// Params 0, eflags: 0x4
// Checksum 0xfc39fa13, Offset: 0x4e5
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace zm_sat_scarab_script_game_over_scenes_cs
// Params 0, eflags: 0x4
// Checksum 0x790229ff, Offset: 0x4f6
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace zm_sat_scarab_script_game_over_scenes_cs
// Params 2
// Checksum 0xc9eb7fb6, Offset: 0x507
// Size: 0x80
function main( unused, unused2 )
{
    if ( utility::flag_exist( "zm_sat_scarab_script_game_over_scenes_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "zm_sat_scarab_script_game_over_scenes_cs" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "zm_sat_scarab_script_game_over_scenes_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "zm_sat_scarab_script_game_over_scenes_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace zm_sat_scarab_script_game_over_scenes_cs
// Params 3, eflags: 0x4
// Checksum 0xfa809d30, Offset: 0x58f
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "zm_sat_scarab_script_game_over_scenes_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "zm_sat_scarab_script_game_over_scenes_cs" );
}

// Namespace zm_sat_scarab_script_game_over_scenes_cs
// Params 3, eflags: 0x4
// Checksum 0xe2118b56, Offset: 0x609
// Size: 0x26d0
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_game_over_scenes_cs";
    s.name = "script_struct - game over scene origin";
    s.script_label = "t10_cin_zm_vig_plr_dth_zmb_duo_05_global";
    s.script_parameters = "zombie_base";
    s.script_scenescriptbundle = "t10_cin_zm_vig_plr_dth_zmb_duo_05_global";
    fe [[ f ]]( s, us, cf, ( 4352.77, -1735.24, 1403 ), ( 0, 180, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_game_over_scenes_cs";
    s.name = "script_struct - game over scene origin";
    fe [[ f ]]( s, us, cf, ( 2092.51, 1285.59, 1686 ), ( 0, 0, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_game_over_scenes_cs";
    s.name = "script_struct - game over scene origin";
    s.script_label = "t10_cin_zm_vig_plr_dth_zmb_solo_03_global";
    s.script_parameters = "zombie_base";
    s.script_scenescriptbundle = "t10_cin_zm_vig_plr_dth_zmb_solo_03_global";
    fe [[ f ]]( s, us, cf, ( 455.2, 3254.05, 1728 ), ( 0, 270, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_game_over_scenes_cs";
    s.name = "script_struct - game over scene origin";
    s.script_label = "t10_cin_zm_vig_plr_dth_zmb_solo_04_global";
    s.script_parameters = "zombie_base";
    s.script_scenescriptbundle = "t10_cin_zm_vig_plr_dth_zmb_solo_04_global";
    fe [[ f ]]( s, us, cf, ( 4072.31, 228.02, 1547.57 ), ( 0, 73.84, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_game_over_scenes_cs";
    s.name = "script_struct - game over scene origin";
    fe [[ f ]]( s, us, cf, ( 2350.15, -1570.38, 1451 ), ( 0, 0.19, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_game_over_scenes_cs";
    s.name = "script_struct - game over scene origin arachne";
    s.script_label = "sat_cin_zm_vig_plr_dth_loom_minion_02";
    s.script_parameters = "zombie_loom_minion";
    s.script_scenescriptbundle = "sat_cin_zm_vig_plr_dth_loom_minion_02";
    fe [[ f ]]( s, us, cf, ( 3148.27, -1711.24, 1499 ), ( 0, 359.94, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_game_over_scenes_cs";
    s.name = "script_struct - game over scene origin";
    s.script_label = "t10_cin_zm_vig_plr_dth_zmb_solo_02_global";
    s.script_parameters = "zombie_base";
    s.script_scenescriptbundle = "t10_cin_zm_vig_plr_dth_zmb_solo_02_global";
    fe [[ f ]]( s, us, cf, ( -5622.95, 221.11, 1694.71 ), ( 0, 0.19, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_game_over_scenes_cs";
    s.name = "script_struct - game over scene origin dreadspinner";
    s.script_label = "sat_cin_zm_vig_plr_dth_loom_minion_01";
    s.script_parameters = "zombie_loom_minion";
    s.script_scenescriptbundle = "sat_cin_zm_vig_plr_dth_loom_minion_01";
    fe [[ f ]]( s, us, cf, ( -3207.84, 2639.46, 1512 ), ( 0, 48.19, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_game_over_scenes_cs";
    s.name = "script_struct - game over scene origin arachne";
    s.script_parameters = "zombie_loom";
    fe [[ f ]]( s, us, cf, ( -1420.23, -2495.74, 1357.57 ), ( 0, 88, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_game_over_scenes_cs";
    s.name = "script_struct - game over scene origin";
    s.script_label = "t10_cin_zm_vig_plr_dth_zmb_solo_03_global";
    s.script_parameters = "zombie_base";
    s.script_scenescriptbundle = "t10_cin_zm_vig_plr_dth_zmb_solo_03_global";
    fe [[ f ]]( s, us, cf, ( 1237.16, 288.46, 1420.62 ), ( 0, 132.19, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_game_over_scenes_cs";
    s.name = "script_struct - game over scene origin arachne";
    s.script_parameters = "zombie_loom";
    fe [[ f ]]( s, us, cf, ( -4008.23, -3300.74, 1484.91 ), ( 0, 88, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_game_over_scenes_cs";
    s.name = "script_struct - game over scene origin arachne";
    s.script_parameters = "zombie_loom";
    fe [[ f ]]( s, us, cf, ( -5645.23, 249.76, 1693.83 ), ( 0, 226.96, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_game_over_scenes_cs";
    s.name = "script_struct - game over scene origin arachne";
    s.script_parameters = "zombie_loom";
    fe [[ f ]]( s, us, cf, ( -2840.23, 3010.26, 1512 ), ( 0, 226.96, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_game_over_scenes_cs";
    s.name = "script_struct - game over scene origin arachne";
    s.script_parameters = "zombie_loom";
    fe [[ f ]]( s, us, cf, ( 433.77, 3554.26, 1728 ), ( 0, 180.96, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_game_over_scenes_cs";
    s.name = "script_struct - game over scene origin arachne";
    s.script_parameters = "zombie_loom";
    fe [[ f ]]( s, us, cf, ( 768.77, 349.26, 1585 ), ( 0, 248.49, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_game_over_scenes_cs";
    s.name = "script_struct - game over scene origin arachne";
    s.script_parameters = "zombie_loom";
    fe [[ f ]]( s, us, cf, ( 2147.27, 1318.76, 1686 ), ( 0, 225.44, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_game_over_scenes_cs";
    s.name = "script_struct - game over scene origin arachne";
    s.script_parameters = "zombie_loom";
    fe [[ f ]]( s, us, cf, ( 4301.27, 600.26, 1568.5 ), ( 0, 241.24, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_game_over_scenes_cs";
    s.name = "script_struct - game over scene origin";
    s.script_label = "t10_cin_zm_vig_plr_dth_zmb_solo_01_global";
    s.script_parameters = "zombie_base";
    s.script_scenescriptbundle = "t10_cin_zm_vig_plr_dth_zmb_solo_01_global";
    fe [[ f ]]( s, us, cf, ( -4051.34, -3305.54, 1488 ), ( 0, 222.19, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_game_over_scenes_cs";
    s.name = "script_struct - game over scene origin";
    s.script_label = "t10_cin_zm_vig_plr_dth_zmb_solo_01_global";
    s.script_parameters = "zombie_base";
    s.script_scenescriptbundle = "t10_cin_zm_vig_plr_dth_zmb_solo_01_global";
    fe [[ f ]]( s, us, cf, ( -769.35, -1562.28, 1313 ), ( 0, 306.1, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_game_over_scenes_cs";
    s.name = "script_struct - game over scene origin arachne";
    s.script_label = "sat_cin_zm_vig_plr_dth_arachne";
    s.script_parameters = "zombie_loom";
    s.script_scenescriptbundle = "sat_cin_zm_vig_plr_dth_arachne";
    fe [[ f ]]( s, us, cf, ( 754.27, -925.24, 1296 ), ( 0, 89.94, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_game_over_scenes_cs";
    s.name = "script_struct - game over scene origin arachne";
    s.script_label = "sat_cin_zm_vig_plr_dth_arachne";
    s.script_parameters = "zombie_loom";
    s.script_scenescriptbundle = "sat_cin_zm_vig_plr_dth_arachne";
    fe [[ f ]]( s, us, cf, ( 3148.27, -1729.24, 1503 ), ( 0, 179.94, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_game_over_scenes_cs";
    s.name = "script_struct - game over scene origin arachne";
    s.script_parameters = "zombie_loom";
    fe [[ f ]]( s, us, cf, ( -77.23, -1583.74, 974 ), ( 0, 313.94, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_game_over_scenes_cs";
    s.name = "script_struct - game over scene origin arachne";
    s.script_parameters = "zombie_loom";
    fe [[ f ]]( s, us, cf, ( 30216.3, 31014.8, 1554 ), ( 0, 245.03, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_game_over_scenes_cs";
    s.name = "script_struct - game over scene origin";
    fe [[ f ]]( s, us, cf, ( 30720.8, 30619.8, 1520.5 ), ( 0, 0, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_game_over_scenes_cs";
    s.name = "script_struct - game over scene origin";
    s.script_label = "t10_cin_zm_vig_plr_dth_zmb_duo_05_global";
    s.script_parameters = "zombie_base";
    s.script_scenescriptbundle = "t10_cin_zm_vig_plr_dth_zmb_duo_05_global";
    fe [[ f ]]( s, us, cf, ( 3148.27, -1749.24, 1499 ), ( 0, 359.94, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_game_over_scenes_cs";
    s.name = "script_struct - game over scene origin dreadspinner";
    s.script_parameters = "zombie_loom_minion";
    fe [[ f ]]( s, us, cf, ( -1468.23, -2506.74, 1357.57 ), ( 0, 222, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_game_over_scenes_cs";
    s.name = "script_struct - game over scene origin";
    s.script_label = "t10_cin_zm_vig_plr_dth_zmb_solo_02_global";
    s.script_parameters = "zombie_base";
    s.script_scenescriptbundle = "t10_cin_zm_vig_plr_dth_zmb_solo_02_global";
    fe [[ f ]]( s, us, cf, ( -2280.84, -1935.54, 1266.08 ), ( 0, 0.19, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_game_over_scenes_cs";
    s.name = "script_struct - game over scene origin dreadspinner";
    s.script_parameters = "zombie_loom_minion";
    fe [[ f ]]( s, us, cf, ( 397.77, -1737.24, 1301.67 ), ( 0, 49.7, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_game_over_scenes_cs";
    s.name = "script_struct - game over scene origin dreadspinner";
    s.script_parameters = "zombie_loom_minion";
    fe [[ f ]]( s, us, cf, ( -2142.23, -1879.74, 1273.17 ), ( 0, 0, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_game_over_scenes_cs";
    s.name = "script_struct - game over scene origin dreadspinner";
    s.script_parameters = "zombie_loom_minion";
    fe [[ f ]]( s, us, cf, ( -4019.23, -1523.24, 1488 ), ( 0, 0, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_game_over_scenes_cs";
    s.name = "script_struct - game over scene origin dreadspinner";
    s.script_label = "sat_cin_zm_vig_plr_dth_loom_minion_01";
    s.script_parameters = "zombie_loom_minion";
    s.script_scenescriptbundle = "sat_cin_zm_vig_plr_dth_loom_minion_01";
    fe [[ f ]]( s, us, cf, ( -5069.23, -3694.24, 1272 ), ( 0, 270, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_game_over_scenes_cs";
    s.name = "script_struct - game over scene origin dreadspinner";
    s.script_label = "sat_cin_zm_vig_plr_dth_loom_minion_01";
    s.script_parameters = "zombie_loom_minion";
    s.script_scenescriptbundle = "sat_cin_zm_vig_plr_dth_loom_minion_01";
    fe [[ f ]]( s, us, cf, ( -5460.73, 775.26, 1689 ), ( 0, 316.64, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_game_over_scenes_cs";
    s.name = "script_struct - game over scene origin dreadspinner";
    s.script_label = "sat_cin_zm_vig_plr_dth_loom_minion_01";
    s.script_parameters = "zombie_loom_minion";
    s.script_scenescriptbundle = "sat_cin_zm_vig_plr_dth_loom_minion_01";
    fe [[ f ]]( s, us, cf, ( -1276.73, 1311.76, 1648.96 ), ( 0, 0, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_game_over_scenes_cs";
    s.name = "script_struct - game over scene origin dreadspinner";
    s.script_label = "sat_cin_zm_vig_plr_dth_loom_minion_02";
    s.script_parameters = "zombie_loom_minion";
    s.script_scenescriptbundle = "sat_cin_zm_vig_plr_dth_loom_minion_02";
    fe [[ f ]]( s, us, cf, ( -2740.23, 1414.26, 1584 ), ( 0, 270, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_game_over_scenes_cs";
    s.name = "script_struct - game over scene origin dreadspinner";
    s.script_parameters = "zombie_loom_minion";
    fe [[ f ]]( s, us, cf, ( 477.27, 3232.26, 1863.17 ), ( 0, 0, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_game_over_scenes_cs";
    s.name = "script_struct - game over scene origin dreadspinner";
    s.script_parameters = "zombie_loom_minion";
    fe [[ f ]]( s, us, cf, ( 1158.77, 276.76, 1418.08 ), ( 0, 0, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_game_over_scenes_cs";
    s.name = "script_struct - game over scene origin dreadspinner";
    s.script_parameters = "zombie_loom_minion";
    fe [[ f ]]( s, us, cf, ( 2662.27, 1477.26, 1696.67 ), ( 0, 0, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_game_over_scenes_cs";
    s.name = "script_struct - game over scene origin dreadspinner";
    s.script_parameters = "zombie_loom_minion";
    fe [[ f ]]( s, us, cf, ( 3809.77, 676.26, 1717.17 ), ( 0, 0, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_game_over_scenes_cs";
    s.name = "script_struct - game over scene origin";
    s.script_label = "t10_cin_zm_vig_plr_dth_zmb_duo_01_global";
    s.script_parameters = "zombie_base";
    s.script_scenescriptbundle = "t10_cin_zm_vig_plr_dth_zmb_duo_01_global";
    fe [[ f ]]( s, us, cf, ( 0.77, -1581.74, 974 ), ( 0, 179.94, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_game_over_scenes_cs";
    s.name = "script_struct - game over scene origin dreadspinner";
    s.script_label = "sat_cin_zm_vig_plr_dth_loom_minion_01";
    s.script_parameters = "zombie_loom_minion";
    s.script_scenescriptbundle = "sat_cin_zm_vig_plr_dth_loom_minion_01";
    fe [[ f ]]( s, us, cf, ( 4352.77, -1735.24, 1403 ), ( 0, 180, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_game_over_scenes_cs";
    s.name = "script_struct - game over scene origin arachne";
    s.script_label = "sat_cin_zm_vig_plr_dth_arachne";
    s.script_parameters = "zombie_loom_hvt";
    s.script_scenescriptbundle = "sat_cin_zm_vig_plr_dth_arachne";
    fe [[ f ]]( s, us, cf, ( 754.27, -891.24, 1296 ), ( 0, 89.94, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_game_over_scenes_cs";
    s.name = "script_struct - game over scene origin";
    s.script_label = "t10_cin_zm_vig_plr_dth_zmb_solo_01_global";
    s.script_parameters = "zombie_base";
    s.script_scenescriptbundle = "t10_cin_zm_vig_plr_dth_zmb_solo_01_global";
    fe [[ f ]]( s, us, cf, ( -3010.84, 1788.46, 1512 ), ( 0, 132.19, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_game_over_scenes_cs";
    s.name = "script_struct - game over scene origin";
    s.script_label = "t10_cin_zm_vig_plr_dth_zmb_solo_01_global";
    s.script_parameters = "zombie_base";
    s.script_scenescriptbundle = "t10_cin_zm_vig_plr_dth_zmb_solo_01_global";
    fe [[ f ]]( s, us, cf, ( -3611.34, 2232.46, 1512 ), ( 0, 222.19, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_game_over_scenes_cs";
    s.name = "script_struct - game over scene origin dreadspinner";
    s.script_label = "sat_cin_zm_vig_plr_dth_loom_minion_01";
    s.script_parameters = "zombie_loom_minion";
    s.script_scenescriptbundle = "sat_cin_zm_vig_plr_dth_loom_minion_01";
    fe [[ f ]]( s, us, cf, ( 120.77, -1615.74, 974 ), ( 0, 359.94, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_game_over_scenes_cs";
    s.name = "script_struct - game over scene origin";
    s.script_label = "t10_cin_zm_vig_plr_dth_zmb_solo_04_global";
    s.script_parameters = "zombie_base";
    s.script_scenescriptbundle = "t10_cin_zm_vig_plr_dth_zmb_solo_04_global";
    fe [[ f ]]( s, us, cf, ( -117.34, -3879.54, 1781.83 ), ( 2.06, 92.19, 5.64 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_game_over_scenes_cs";
    s.name = "script_struct - game over scene origin ravager";
    s.script_label = "sat_cin_zm_vig_plr_dth_shade_01";
    s.script_parameters = "zombie_shade";
    s.script_scenescriptbundle = "sat_cin_zm_vig_plr_dth_shade_01";
    fe [[ f ]]( s, us, cf, ( 709.16, -1871.54, 1317.67 ), ( 0, 87.19, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_game_over_scenes_cs";
    s.name = "script_struct - game over scene origin ravager";
    s.script_label = "sat_cin_zm_vig_plr_dth_shade_01";
    s.script_parameters = "zombie_shade";
    s.script_scenescriptbundle = "sat_cin_zm_vig_plr_dth_shade_01";
    fe [[ f ]]( s, us, cf, ( -946.84, -1517.54, 1313.05 ), ( 0, 31.19, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_game_over_scenes_cs";
    s.name = "script_struct - game over scene origin ravager";
    s.script_label = "sat_cin_zm_vig_plr_dth_shade_01";
    s.script_parameters = "zombie_shade";
    s.script_scenescriptbundle = "sat_cin_zm_vig_plr_dth_shade_01";
    fe [[ f ]]( s, us, cf, ( 2407.16, -1563.54, 1451 ), ( 0, 357.19, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_game_over_scenes_cs";
    s.name = "script_struct - game over scene origin ravager";
    s.script_label = "sat_cin_zm_vig_plr_dth_shade_01";
    s.script_parameters = "zombie_shade";
    s.script_scenescriptbundle = "sat_cin_zm_vig_plr_dth_shade_01";
    fe [[ f ]]( s, us, cf, ( 3237.16, -1163.54, 1499 ), ( 0, 87.19, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_game_over_scenes_cs";
    s.name = "script_struct - game over scene origin doppleghast";
    s.script_label = "t10_cin_zm_vig_plr_dth_ghoul_01";
    s.script_parameters = "zombie_ghoul";
    s.script_scenescriptbundle = "t10_cin_zm_vig_plr_dth_ghoul_01";
    fe [[ f ]]( s, us, cf, ( -2210.84, -2321.54, 1523.14 ), ( 0, 359.19, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_game_over_scenes_cs";
    s.name = "script_struct - game over scene origin ravager";
    s.script_label = "sat_cin_zm_vig_plr_dth_shade_01";
    s.script_parameters = "zombie_shade";
    s.script_scenescriptbundle = "sat_cin_zm_vig_plr_dth_shade_01";
    fe [[ f ]]( s, us, cf, ( 705.16, 342.46, 1580.27 ), ( 0, 141.19, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_game_over_scenes_cs";
    s.name = "script_struct - game over scene origin ravager";
    s.script_label = "sat_cin_zm_vig_plr_dth_shade_01";
    s.script_parameters = "zombie_shade";
    s.script_scenescriptbundle = "sat_cin_zm_vig_plr_dth_shade_01";
    fe [[ f ]]( s, us, cf, ( 2073.16, 1358.46, 1686 ), ( 0, 45.19, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_game_over_scenes_cs";
    s.name = "script_struct - game over scene origin ravager";
    s.script_label = "sat_cin_zm_vig_plr_dth_shade_01";
    s.script_parameters = "zombie_shade";
    s.script_scenescriptbundle = "sat_cin_zm_vig_plr_dth_shade_01";
    fe [[ f ]]( s, us, cf, ( 2991.16, 3002.46, 1814 ), ( 0, 225.19, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_game_over_scenes_cs";
    s.name = "script_struct - game over scene origin ravager";
    s.script_label = "sat_cin_zm_vig_plr_dth_shade_01";
    s.script_parameters = "zombie_shade";
    s.script_scenescriptbundle = "sat_cin_zm_vig_plr_dth_shade_01";
    fe [[ f ]]( s, us, cf, ( 3827.16, 894.46, 1742.44 ), ( 0, 135.19, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_game_over_scenes_cs";
    s.name = "script_struct - game over scene origin ravager";
    s.script_label = "sat_cin_zm_vig_plr_dth_shade_01";
    s.script_parameters = "zombie_shade";
    s.script_scenescriptbundle = "sat_cin_zm_vig_plr_dth_shade_01";
    fe [[ f ]]( s, us, cf, ( -360.84, 3742.46, 1728 ), ( 0, 349.19, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_game_over_scenes_cs";
    s.name = "script_struct - game over scene origin ravager";
    s.script_label = "sat_cin_zm_vig_plr_dth_shade_01";
    s.script_parameters = "zombie_shade";
    s.script_scenescriptbundle = "sat_cin_zm_vig_plr_dth_shade_01";
    fe [[ f ]]( s, us, cf, ( -1302.84, 1364.46, 1653.2 ), ( 0, 23.19, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_game_over_scenes_cs";
    s.name = "script_struct - game over scene origin ravager";
    s.script_label = "sat_cin_zm_vig_plr_dth_shade_01";
    s.script_parameters = "zombie_shade";
    s.script_scenescriptbundle = "sat_cin_zm_vig_plr_dth_shade_01";
    fe [[ f ]]( s, us, cf, ( -2986.84, 1924.46, 1512 ), ( 0, 45.19, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_game_over_scenes_cs";
    s.name = "script_struct - game over scene origin ravager";
    s.script_label = "sat_cin_zm_vig_plr_dth_shade_01";
    s.script_parameters = "zombie_shade";
    s.script_scenescriptbundle = "sat_cin_zm_vig_plr_dth_shade_01";
    fe [[ f ]]( s, us, cf, ( -3226.84, 2292.46, 1511.95 ), ( 0, 45.19, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_game_over_scenes_cs";
    s.name = "script_struct - game over scene origin ravager";
    s.script_label = "sat_cin_zm_vig_plr_dth_shade_01";
    s.script_parameters = "zombie_shade";
    s.script_scenescriptbundle = "sat_cin_zm_vig_plr_dth_shade_01";
    fe [[ f ]]( s, us, cf, ( -4564.84, 1172.46, 1633 ), ( 0, 225.19, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_game_over_scenes_cs";
    s.name = "script_struct - game over scene origin ravager";
    s.script_label = "sat_cin_zm_vig_plr_dth_shade_01";
    s.script_parameters = "zombie_shade";
    s.script_scenescriptbundle = "sat_cin_zm_vig_plr_dth_shade_01";
    fe [[ f ]]( s, us, cf, ( -2262.84, -2903.54, 1259.51 ), ( 0, 133.19, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_game_over_scenes_cs";
    s.name = "script_struct - game over scene origin ravager";
    s.script_label = "sat_cin_zm_vig_plr_dth_shade_01";
    s.script_parameters = "zombie_shade";
    s.script_scenescriptbundle = "sat_cin_zm_vig_plr_dth_shade_01";
    fe [[ f ]]( s, us, cf, ( -3264.84, -2395.54, 1424 ), ( 0, 185.19, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_game_over_scenes_cs";
    s.name = "script_struct - game over scene origin ravager";
    s.script_label = "sat_cin_zm_vig_plr_dth_shade_01";
    s.script_parameters = "zombie_shade";
    s.script_scenescriptbundle = "sat_cin_zm_vig_plr_dth_shade_01";
    fe [[ f ]]( s, us, cf, ( -6354.84, -2481.54, 1488 ), ( 0, 175.19, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_game_over_scenes_cs";
    s.script_float = float( 0.7 );
    fe [[ f ]]( s, us, cf, ( -2253, -1423, 1436 ), ( 2.87, 197.5, -177.82 ), "hotfix_rock", undefined, "sat_zm_rock_cliff_large_01_scriptable" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_game_over_scenes_cs";
    s.name = "script_struct - game over scene origin doppleghast";
    s.script_label = "t10_cin_zm_vig_plr_dth_ghoul_01";
    s.script_parameters = "zombie_ghoul";
    s.script_scenescriptbundle = "t10_cin_zm_vig_plr_dth_ghoul_01";
    fe [[ f ]]( s, us, cf, ( -938.84, -1807.54, 1326.48 ), ( 0, 325.19, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_game_over_scenes_cs";
    s.name = "script_struct - game over scene origin doppleghast";
    s.script_label = "t10_cin_zm_vig_plr_dth_ghoul_01";
    s.script_parameters = "zombie_ghoul";
    s.script_scenescriptbundle = "t10_cin_zm_vig_plr_dth_ghoul_01";
    fe [[ f ]]( s, us, cf, ( -4016.84, -2209.54, 1504 ), ( 0, 269.19, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_game_over_scenes_cs";
    s.name = "script_struct - game over scene origin doppleghast";
    s.script_label = "t10_cin_zm_vig_plr_dth_ghoul_01";
    s.script_parameters = "zombie_ghoul";
    s.script_scenescriptbundle = "t10_cin_zm_vig_plr_dth_ghoul_01";
    fe [[ f ]]( s, us, cf, ( -5720.84, -3967.54, 1376.52 ), ( 0, 359.19, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_game_over_scenes_cs";
    s.name = "script_struct - game over scene origin doppleghast";
    s.script_label = "t10_cin_zm_vig_plr_dth_ghoul_01";
    s.script_parameters = "zombie_ghoul";
    s.script_scenescriptbundle = "t10_cin_zm_vig_plr_dth_ghoul_01";
    fe [[ f ]]( s, us, cf, ( -5206.84, 724.46, 1682.03 ), ( 0, 267.19, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_game_over_scenes_cs";
    s.name = "script_struct - game over scene origin doppleghast";
    s.script_label = "t10_cin_zm_vig_plr_dth_ghoul_01";
    s.script_parameters = "zombie_ghoul";
    s.script_scenescriptbundle = "t10_cin_zm_vig_plr_dth_ghoul_01";
    fe [[ f ]]( s, us, cf, ( -1358.84, 1316.46, 1646.9 ), ( 0, 131.19, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_game_over_scenes_cs";
    s.name = "script_struct - game over scene origin doppleghast";
    s.script_label = "t10_cin_zm_vig_plr_dth_ghoul_01";
    s.script_parameters = "zombie_ghoul";
    s.script_scenescriptbundle = "t10_cin_zm_vig_plr_dth_ghoul_01";
    fe [[ f ]]( s, us, cf, ( -2438.84, 1708.46, 1584 ), ( 0, 317.19, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_game_over_scenes_cs";
    s.name = "script_struct - game over scene origin doppleghast";
    s.script_label = "t10_cin_zm_vig_plr_dth_ghoul_01";
    s.script_parameters = "zombie_ghoul";
    s.script_scenescriptbundle = "t10_cin_zm_vig_plr_dth_ghoul_01";
    fe [[ f ]]( s, us, cf, ( -3974.84, 1902.46, 1512 ), ( 0, 227.19, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_game_over_scenes_cs";
    s.name = "script_struct - game over scene origin doppleghast";
    s.script_label = "t10_cin_zm_vig_plr_dth_ghoul_01";
    s.script_parameters = "zombie_ghoul";
    s.script_scenescriptbundle = "t10_cin_zm_vig_plr_dth_ghoul_01";
    fe [[ f ]]( s, us, cf, ( 1257.16, 3218.46, 1856 ), ( 0, 93.19, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_game_over_scenes_cs";
    s.name = "script_struct - game over scene origin doppleghast";
    s.script_label = "t10_cin_zm_vig_plr_dth_ghoul_01";
    s.script_parameters = "zombie_ghoul";
    s.script_scenescriptbundle = "t10_cin_zm_vig_plr_dth_ghoul_01";
    fe [[ f ]]( s, us, cf, ( 1037.16, 122.46, 1398.07 ), ( 0, 93.19, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_game_over_scenes_cs";
    s.name = "script_struct - game over scene origin doppleghast";
    s.script_label = "t10_cin_zm_vig_plr_dth_ghoul_01";
    s.script_parameters = "zombie_ghoul";
    s.script_scenescriptbundle = "t10_cin_zm_vig_plr_dth_ghoul_01";
    fe [[ f ]]( s, us, cf, ( 1545.16, 694.46, 1540 ), ( 0, 45.19, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_game_over_scenes_cs";
    s.name = "script_struct - game over scene origin doppleghast";
    s.script_label = "t10_cin_zm_vig_plr_dth_ghoul_01";
    s.script_parameters = "zombie_ghoul";
    s.script_scenescriptbundle = "t10_cin_zm_vig_plr_dth_ghoul_01";
    fe [[ f ]]( s, us, cf, ( 3165.16, 2350.46, 1734 ), ( 0, 45.19, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_game_over_scenes_cs";
    s.name = "script_struct - game over scene origin doppleghast";
    s.script_label = "t10_cin_zm_vig_plr_dth_ghoul_01";
    s.script_parameters = "zombie_ghoul";
    s.script_scenescriptbundle = "t10_cin_zm_vig_plr_dth_ghoul_01";
    fe [[ f ]]( s, us, cf, ( 3653.16, 472.46, 1759.8 ), ( 0, 187.19, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_game_over_scenes_cs";
    s.name = "script_struct - game over scene origin doppleghast";
    s.script_label = "t10_cin_zm_vig_plr_dth_ghoul_01";
    s.script_parameters = "zombie_ghoul";
    s.script_scenescriptbundle = "t10_cin_zm_vig_plr_dth_ghoul_01";
    fe [[ f ]]( s, us, cf, ( 2337.16, -1651.54, 1451 ), ( 0, 73.19, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_game_over_scenes_cs";
    s.name = "script_struct - game over scene origin doppleghast";
    s.script_label = "t10_cin_zm_vig_plr_dth_ghoul_01";
    s.script_parameters = "zombie_ghoul";
    s.script_scenescriptbundle = "t10_cin_zm_vig_plr_dth_ghoul_01";
    fe [[ f ]]( s, us, cf, ( 3221.16, -1801.54, 1499 ), ( 0, 5.19, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_game_over_scenes_cs";
    s.name = "script_struct - game over scene origin doppleghast";
    s.script_label = "t10_cin_zm_vig_plr_dth_ghoul_01";
    s.script_parameters = "zombie_ghoul";
    s.script_scenescriptbundle = "t10_cin_zm_vig_plr_dth_ghoul_01";
    fe [[ f ]]( s, us, cf, ( 1.16, -1545.54, 974 ), ( 0, 89.19, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_game_over_scenes_cs";
    s.script_scenescriptbundle = "t10_cin_zm_vig_plr_dth_zmb_duo_05_global";
    fe [[ f ]]( s, us, cf, ( 4072.31, 228.02, 1547.57 ), ( 0, 73.84, 0 ) );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_game_over_scenes_cs";
    s.script_float = float( 0.65 );
    fe [[ f ]]( s, us, cf, ( -2375, -1529, 1476 ), ( 341.9, 272.1, 179.49 ), "hotfix_rock", undefined, "sat_zm_rock_cliff_large_03_scriptable" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_game_over_scenes_cs";
    s.script_float = float( 0.65 );
    fe [[ f ]]( s, us, cf, ( -2350, -1304, 1462 ), ( 342.08, 261.9, -175.05 ), "hotfix_rock", undefined, "sat_zm_rock_cliff_large_03_scriptable" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_game_over_scenes_cs";
    fe [[ f ]]( s, us, cf, ( -1205.11, -1830.66, 1321.09 ), ( 0, 223.01, 0 ), "hotfix_doorbuy_clip", undefined, "southwest_door_bought" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_game_over_scenes_cs";
    fe [[ f ]]( s, us, cf, ( 1023.5, -122, 1352 ), ( 0, 45, 0 ), "hotfix_doorbuy_clip", undefined, "northeast_door_bought" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_game_over_scenes_cs";
    fe [[ f ]]( s, us, cf, ( 1185.34, -1800.99, 1362.73 ), ( 0, 5.19, 0 ), "hotfix_doorbuy_clip", undefined, "southeast_door_bought" );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace zm_sat_scarab_script_game_over_scenes_cs
// Params 0, eflags: 0x4
// Checksum 0xa7c1fac, Offset: 0x2ce1
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace zm_sat_scarab_script_game_over_scenes_cs
// Params 0
// Checksum 0x38d3407d, Offset: 0x2ceb
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "zm_sat_scarab_script_game_over_scenes_cs" );
}

