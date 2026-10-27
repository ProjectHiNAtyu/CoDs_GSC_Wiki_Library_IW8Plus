// scripts\mp\zm\maps\zm_sat_firefly\zm_sat_firefly_script_dmps_ee_cs.gsc  (hash_543a627651466bbc.gscc) (size: 9781 Bytes / 0x2635 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x7b100d79 (2064649593)
// size ...... 9781 (0x2635)
// includes .. 3   (offset: 0x2079)
// strings ... 48  (offset: 0x2091)
// dev strs .. 0   (offset: 0x2635)
// exports ... 9   (offset: 0x1ce1)
// cseg ...... 0x54f + 0x1792 (0x1ce1)
// imports ... 20  (offset: 0x1e49)
// animtree1 . 0   (offset: 0x2635)
// animtree2 . 0   (offset: 0x2635)
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace zm_sat_firefly_script_dmps_ee_cs;

// Namespace zm_sat_firefly_script_dmps_ee_cs
// Params 0, eflags: 0x5
// Checksum 0x22a9e7ac, Offset: 0x56d
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"zm_sat_firefly_script_dmps_ee_cs", undefined, &function_b39ecd3d51489472, undefined );
}

// Namespace zm_sat_firefly_script_dmps_ee_cs
// Params 0, eflags: 0x4
// Checksum 0xecced132, Offset: 0x58e
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace zm_sat_firefly_script_dmps_ee_cs
// Params 0, eflags: 0x4
// Checksum 0x69f502de, Offset: 0x59f
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace zm_sat_firefly_script_dmps_ee_cs
// Params 2
// Checksum 0xd91c5497, Offset: 0x5b0
// Size: 0x80
function main( unused, unused2 )
{
    if ( utility::flag_exist( "zm_sat_firefly_script_dmps_ee_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "zm_sat_firefly_script_dmps_ee_cs" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "zm_sat_firefly_script_dmps_ee_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "zm_sat_firefly_script_dmps_ee_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace zm_sat_firefly_script_dmps_ee_cs
// Params 3, eflags: 0x4
// Checksum 0xea77b611, Offset: 0x638
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "zm_sat_firefly_script_dmps_ee_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "zm_sat_firefly_script_dmps_ee_cs" );
}

// Namespace zm_sat_firefly_script_dmps_ee_cs
// Params 3, eflags: 0x4
// Checksum 0xf31a2843, Offset: 0x6b2
// Size: 0x160f
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_dmps_ee_cs";
    s.groupid = "path";
    s.name = "ee_dempsey_path_1_2";
    fe [[ f ]]( s, us, cf, ( -1564, 8559, 350 ), ( 0, 0, 0 ), "cspf_0_auto1153733783224267061", "cspf_0_auto7957366948496700234", "ee_dempsey_path_1_2" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_dmps_ee_cs";
    s.groupid = "path";
    s.name = "ee_dempsey_path_2_2";
    fe [[ f ]]( s, us, cf, ( -728, 8661, 350 ), ( 0, 0, 0 ), "cspf_0_auto18243013150840064485", "cspf_0_auto190683951124205464", "ee_dempsey_path_2_2" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_dmps_ee_cs";
    fe [[ f ]]( s, us, cf, ( -3316, -5820, 824 ), ( 0, 60, 0 ), undefined, undefined, "dempsey_portal" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_dmps_ee_cs";
    s.groupid = "path";
    s.name = "ee_dempsey_path_1_1";
    fe [[ f ]]( s, us, cf, ( -1426, 7398, 350 ), ( 0, 0, 0 ), undefined, "cspf_0_auto1153733783224267061", "ee_dempsey_path_1_1" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_dmps_ee_cs";
    s.script_animation = "spawn";
    s.script_int = "1";
    s.script_label = "zombie_base_armored_light";
    fe [[ f ]]( s, us, cf, ( -1673, 8714, 306 ), ( 0, 155, 0 ), "cspf_0_auto6425581372551955801" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_dmps_ee_cs";
    s.animation = "p_cin_zm_vig_fly_dempsey_sq_dogtag_intro";
    s.name = "dogtag";
    fe [[ f ]]( s, us, cf, ( -3293, -5807, 813 ), ( 0, 30.9, 0 ), undefined, "cspf_0_auto1061693881315018132", "ee_dempsey_corpse_interact" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_dmps_ee_cs";
    s.groupid = "path";
    s.name = "ee_dempsey_path_3_4";
    fe [[ f ]]( s, us, cf, ( -1391, 10182, 350 ), ( 0, 0, 0 ), "cspf_0_auto7653435013800754114", "cspf_0_auto1369138184305859179", "ee_dempsey_path_3_4" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_dmps_ee_cs";
    s.groupid = "path";
    s.name = "ee_dempsey_path_1_3";
    fe [[ f ]]( s, us, cf, ( -2233, 8910, 350 ), ( 0, 0, 0 ), "cspf_0_auto7957366948496700234", "cspf_0_auto6425581372551955801", "ee_dempsey_path_1_3" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_dmps_ee_cs";
    fe [[ f ]]( s, us, cf, ( -1410.23, 7270.43, 286.53 ), ( 0, 90.48, 0 ), "cspf_0_auto1061693881315018132" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_dmps_ee_cs";
    s.script_animation = "spawn";
    s.script_int = "1";
    s.script_label = "zombie_base_armored_light";
    fe [[ f ]]( s, us, cf, ( -1782, 8929, 309 ), ( 0, 185, 0 ), "cspf_0_auto6425581372551955801" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_dmps_ee_cs";
    s.script_animation = "spawn";
    s.script_int = "1";
    s.script_label = "zombie_base_armored_light";
    fe [[ f ]]( s, us, cf, ( -1813, 9343, 301 ), ( 0, 240, 0 ), "cspf_0_auto6425581372551955801" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_dmps_ee_cs";
    s.script_animation = "spawn";
    s.script_int = "1";
    s.script_label = "zombie_base_armored_light";
    fe [[ f ]]( s, us, cf, ( -1916, 8634, 309 ), ( 0, 140, 0 ), "cspf_0_auto6425581372551955801" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_dmps_ee_cs";
    s.script_animation = "spawn";
    s.script_int = "1";
    s.script_label = "zombie_base_armored_light";
    fe [[ f ]]( s, us, cf, ( -1164, 9203, 308 ), ( 0, 195, 0 ), "cspf_0_auto6425581372551955801" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_dmps_ee_cs";
    s.script_animation = "spawn";
    s.script_int = "1";
    s.script_label = "zombie_base_armored_light";
    fe [[ f ]]( s, us, cf, ( -1470, 8805, 327 ), ( 0, -10, 0 ), "cspf_0_auto190683951124205464" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_dmps_ee_cs";
    s.script_animation = "spawn";
    s.script_int = "2";
    s.script_label = "zombie_shade";
    fe [[ f ]]( s, us, cf, ( -1746, 8247, 307 ), ( 0, 22, 0 ), "cspf_0_auto190683951124205464" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_dmps_ee_cs";
    s.script_animation = "spawn";
    s.script_int = "1";
    s.script_label = "zombie_base_armored_light";
    fe [[ f ]]( s, us, cf, ( -836, 9088, 307 ), ( 0, 280, 0 ), "cspf_0_auto190683951124205464" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_dmps_ee_cs";
    s.script_animation = "spawn";
    s.script_int = "2";
    s.script_label = "zombie_base_armored_light";
    fe [[ f ]]( s, us, cf, ( -1441, 8928, 330 ), ( 0, 340, 0 ), "cspf_0_auto190683951124205464" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_dmps_ee_cs";
    s.script_animation = "spawn";
    s.script_int = "1";
    s.script_label = "zombie_shade";
    fe [[ f ]]( s, us, cf, ( -1461, 9501, 307 ), ( 0, 311, 0 ), "cspf_0_auto190683951124205464" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_dmps_ee_cs";
    s.script_animation = "spawn";
    s.script_int = "2";
    s.script_label = "zombie_shade";
    fe [[ f ]]( s, us, cf, ( -1572, 9151, 308 ), ( 0, -25, 0 ), "cspf_0_auto190683951124205464" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_dmps_ee_cs";
    s.script_animation = "spawn";
    s.script_int = "1";
    s.script_label = "zombie_base_armored_light";
    fe [[ f ]]( s, us, cf, ( -1403.64, 9629.19, 304.23 ), ( 0, 101.31, 0 ), "cspf_0_auto1369138184305859179" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_dmps_ee_cs";
    s.script_animation = "spawn";
    s.script_int = "1";
    s.script_label = "zombie_base_armored_light";
    fe [[ f ]]( s, us, cf, ( -1608.26, 9727.63, 310.13 ), ( 0, 49.55, 0 ), "cspf_0_auto1369138184305859179" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_dmps_ee_cs";
    s.script_animation = "spawn";
    s.script_int = "1";
    s.script_label = "zombie_base_armored_heavy";
    fe [[ f ]]( s, us, cf, ( -1637.77, 10374.5, 307.62 ), ( 0, 329.8, 0 ), "cspf_0_auto1369138184305859179" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_dmps_ee_cs";
    s.script_animation = "spawn";
    s.script_int = "1";
    s.script_label = "zombie_base_armored_light";
    fe [[ f ]]( s, us, cf, ( -1301.37, 10418.3, 308.29 ), ( 0, 244.46, 0 ), "cspf_0_auto1369138184305859179" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_dmps_ee_cs";
    s.script_animation = "spawn";
    s.script_int = "1";
    s.script_label = "zombie_base_armored_heavy";
    fe [[ f ]]( s, us, cf, ( -1315.38, 9788.25, 311.99 ), ( 0, 112.16, 0 ), "cspf_0_auto1369138184305859179" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_dmps_ee_cs";
    s.script_animation = "spawn";
    s.script_int = "2";
    s.script_label = "zombie_base_armored_heavy";
    fe [[ f ]]( s, us, cf, ( -1577, 9581, 314 ), ( 0, 75, 0 ), "cspf_0_auto1369138184305859179" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_dmps_ee_cs";
    s.script_animation = "spawn";
    s.script_int = "2";
    s.script_label = "zombie_base_armored_light";
    fe [[ f ]]( s, us, cf, ( -1302, 9406, 313 ), ( 0, 110, 0 ), "cspf_0_auto1369138184305859179" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_dmps_ee_cs";
    s.script_animation = "spawn";
    s.script_int = "2";
    s.script_label = "zombie_base_armored_light";
    fe [[ f ]]( s, us, cf, ( -1348.27, 9774.96, 311.31 ), ( 0, 106.38, 0 ), "cspf_0_auto1369138184305859179" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_dmps_ee_cs";
    s.script_animation = "spawn";
    s.script_int = "2";
    s.script_label = "zombie_base_armored_heavy";
    fe [[ f ]]( s, us, cf, ( -1430.83, 9631.64, 304 ), ( 0, 89.45, 0 ), "cspf_0_auto1369138184305859179" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_dmps_ee_cs";
    s.script_animation = "spawn";
    s.script_int = "2";
    s.script_label = "zombie_base_armored_heavy";
    fe [[ f ]]( s, us, cf, ( -1628.73, 9762.38, 310.9 ), ( 0, 61.96, 0 ), "cspf_0_auto1369138184305859179" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_dmps_ee_cs";
    s.script_animation = "spawn";
    s.script_int = "3";
    s.script_label = "zombie_base_armored_heavy";
    fe [[ f ]]( s, us, cf, ( -1307, 9172, 317 ), ( 0, 90, 0 ), "cspf_0_auto1369138184305859179" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_dmps_ee_cs";
    s.script_animation = "spawn";
    s.script_int = "3";
    s.script_label = "zombie_base_armored_light";
    fe [[ f ]]( s, us, cf, ( -1542, 9793, 321 ), ( 0, 60, 0 ), "cspf_0_auto1369138184305859179" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_dmps_ee_cs";
    s.script_animation = "spawn";
    s.script_int = "3";
    s.script_label = "zombie_base_armored_heavy";
    fe [[ f ]]( s, us, cf, ( -1456.99, 9629.35, 304.31 ), ( 0, 89.94, 0 ), "cspf_0_auto1369138184305859179" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_dmps_ee_cs";
    s.script_animation = "spawn";
    s.script_int = "3";
    s.script_label = "zombie_base_armored_heavy";
    fe [[ f ]]( s, us, cf, ( -1113, 9174, 308 ), ( 0, 105, 0 ), "cspf_0_auto1369138184305859179" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_dmps_ee_cs";
    s.script_animation = "spawn";
    s.script_int = "3";
    s.script_label = "zombie_base_armored_heavy";
    fe [[ f ]]( s, us, cf, ( -1932, 9086, 308 ), ( 0, 50, 0 ), "cspf_0_auto1369138184305859179" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_dmps_ee_cs";
    s.name = "ee_dempsey_scene_node_1st";
    s.script_scenescriptbundle = "sat_cin_zm_firefly_dempsey_ee_weaver";
    fe [[ f ]]( s, us, cf, ( -2256, 8981, 259 ), ( 0, 404, 0 ), "ee_dempsey_scene_node_1st" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_dmps_ee_cs";
    s.name = "ee_dempsey_scene_node_2nd";
    s.script_scenescriptbundle = "sat_cin_zm_firefly_dempsey_sq_weaver";
    fe [[ f ]]( s, us, cf, ( -691, 8541, 301.71 ), ( 0, 196.81, 0 ), "ee_dempsey_scene_node_2nd" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_dmps_ee_cs";
    s.name = "ee_dempsey_scene_node_3rd";
    s.script_scenescriptbundle = "sat_cin_zm_living_world_multi_eating_corpse_zmb";
    fe [[ f ]]( s, us, cf, ( -1416, 10261, 317.42 ), ( 0, 15, 0 ), "ee_dempsey_scene_node_3rd" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_dmps_ee_cs";
    fe [[ f ]]( s, us, cf, ( -1457, 10496, 301 ), ( 0, 270, 0 ), undefined, undefined, "dempsey_ee_ammo_cache" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_dmps_ee_cs";
    s.script_animation = "spawn";
    s.script_int = "1";
    s.script_label = "zombie_base_armored_light";
    fe [[ f ]]( s, us, cf, ( -1457, 9462, 331 ), ( 0, 215, 0 ), "cspf_0_auto6425581372551955801" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_dmps_ee_cs";
    s.groupid = "path";
    s.name = "ee_dempsey_path_3_2";
    fe [[ f ]]( s, us, cf, ( -1123, 9259, 350 ), ( 0, 0, 0 ), "cspf_0_auto8678428014585328220", "cspf_0_auto9373801568662855405", "ee_dempsey_path_3_2" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_dmps_ee_cs";
    s.groupid = "path";
    s.name = "ee_dempsey_path_3_1";
    fe [[ f ]]( s, us, cf, ( -928, 8938, 350 ), ( 0, 0, 0 ), "cspf_0_auto190683951124205464", "cspf_0_auto8678428014585328220", "ee_dempsey_path_3_1" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_dmps_ee_cs";
    fe [[ f ]]( s, us, cf, ( -392, 8656, 520 ), ( 0, 15, 0 ), "cspf_0_auto12958461200876931293", undefined, "ee_transition_end_loc" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_dmps_ee_cs";
    fe [[ f ]]( s, us, cf, ( -2616, 8832, 344 ), ( 0, 360, 0 ), undefined, "cspf_0_auto12958461200876931293", "ee_transition_start_loc" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_dmps_ee_cs";
    s.groupid = "path";
    s.name = "ee_dempsey_path_2_1";
    fe [[ f ]]( s, us, cf, ( -1836, 8811, 350 ), ( 0, 0, 0 ), "cspf_0_auto6425581372551955801", "cspf_0_auto18243013150840064485", "ee_dempsey_path_2_1" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_dmps_ee_cs";
    s.name = "ee_dempsey_scene_node_start";
    s.script_scenescriptbundle = "sat_cin_zm_fly_dempsey_sq";
    fe [[ f ]]( s, us, cf, ( 0, 0, 0 ), ( 0, 0, 0 ), "ee_dempsey_scene_node_start", undefined, "Align_Node_tag_align_dempsey_sq_Node" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_dmps_ee_cs";
    s.groupid = "path";
    s.name = "ee_dempsey_path_3_3";
    fe [[ f ]]( s, us, cf, ( -1422, 9472, 350 ), ( 0, 0, 0 ), "cspf_0_auto9373801568662855405", "cspf_0_auto7653435013800754114", "ee_dempsey_path_3_3" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_dmps_ee_cs";
    s.script_animation = "spawn";
    s.script_int = "1";
    s.script_label = "zombie_base_armored_light";
    fe [[ f ]]( s, us, cf, ( -1902.14, 8412.97, 304 ), ( 0, 135, 0 ), "cspf_0_auto6425581372551955801" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_dmps_ee_cs";
    fe [[ f ]]( s, us, cf, ( -1583, 8831, 318 ), ( 0, 315, 0 ), undefined, undefined, "dempsey_ee_ammo_cache" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_dmps_ee_cs";
    fe [[ f ]]( s, us, cf, ( -3288, -5968, 851.98 ), ( 0, 0, 0 ), undefined, undefined, "ee_dempsey_reward" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_dmps_ee_cs";
    s.script_animation = "spawn";
    s.script_int = "1";
    s.script_label = "zombie_base_armored_light";
    fe [[ f ]]( s, us, cf, ( -1251, 8401, 306 ), ( 0, 35, 0 ), "cspf_0_auto190683951124205464" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_dmps_ee_cs";
    s.script_animation = "spawn";
    s.script_int = "2";
    s.script_label = "zombie_shade";
    fe [[ f ]]( s, us, cf, ( -1736, 8750, 316 ), ( 0, -5, 0 ), "cspf_0_auto190683951124205464" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_dmps_ee_cs";
    s.script_animation = "spawn";
    s.script_int = "2";
    s.script_label = "zombie_base_armored_light";
    fe [[ f ]]( s, us, cf, ( -1343, 9120, 300.08 ), ( 0, 320, 0 ), "cspf_0_auto190683951124205464" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_dmps_ee_cs";
    s.script_animation = "spawn";
    s.script_int = "3";
    s.script_label = "zombie_base_armored_light";
    fe [[ f ]]( s, us, cf, ( -1628, 10445, 321 ), ( 0, 310, 0 ), "cspf_0_auto1369138184305859179" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_dmps_ee_cs";
    s.script_animation = "spawn";
    s.script_int = "3";
    s.script_label = "zombie_base_armored_light";
    fe [[ f ]]( s, us, cf, ( -1647, 10177, 325 ), ( 0, 0, 0 ), "cspf_0_auto1369138184305859179" );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace zm_sat_firefly_script_dmps_ee_cs
// Params 0, eflags: 0x4
// Checksum 0x68752a03, Offset: 0x1cc9
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace zm_sat_firefly_script_dmps_ee_cs
// Params 0
// Checksum 0x28246b5c, Offset: 0x1cd3
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "zm_sat_firefly_script_dmps_ee_cs" );
}

