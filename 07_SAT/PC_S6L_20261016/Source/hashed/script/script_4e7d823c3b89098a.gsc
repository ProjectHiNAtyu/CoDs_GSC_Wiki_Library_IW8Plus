// script_4e7d823c3b89098a  (hash_4e7d823c3b89098a.gscc) (size: 23823 Bytes / 0x5d0f / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x306f99cb (812620235)
// size ...... 23823 (0x5d0f)
// includes .. 4   (offset: 0x4e07)
// strings ... 126 (offset: 0x4e27)
// dev strs .. 0   (offset: 0x5d0f)
// exports ... 13  (offset: 0x4923)
// cseg ...... 0x1127 + 0x37fc (0x4923)
// imports ... 26  (offset: 0x4b2b)
// animtree1 . 0   (offset: 0x5d0f)
// animtree2 . 0   (offset: 0x5d0f)
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace mp_sat_avalon_q1_ob_contract_taurus_intro_cs;

// Namespace mp_sat_avalon_q1_ob_contract_taurus_intro_cs
// Params 0, eflags: 0x5
// Checksum 0xf7331d76, Offset: 0x1145
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"mp_sat_avalon_q1_ob_contract_taurus_intro_cs", #"activity_common", &function_b39ecd3d51489472, undefined );
}

// Namespace mp_sat_avalon_q1_ob_contract_taurus_intro_cs
// Params 0, eflags: 0x4
// Checksum 0x86cf845d, Offset: 0x116e
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace mp_sat_avalon_q1_ob_contract_taurus_intro_cs
// Params 0, eflags: 0x4
// Checksum 0x3f457b1, Offset: 0x117f
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace mp_sat_avalon_q1_ob_contract_taurus_intro_cs
// Params 2
// Checksum 0xe6821e2a, Offset: 0x1190
// Size: 0x8c
function main( unused, unused2 )
{
    if ( utility::flag_exist( "mp_sat_avalon_q1_ob_contract_taurus_intro_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "mp_sat_avalon_q1_ob_contract_taurus_intro_cs" ) )
    {
        return;
    }
    
    activity_common::function_e1df676808c1d1e3( &function_4cd78e661617f3 );
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "mp_sat_avalon_q1_ob_contract_taurus_intro_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "mp_sat_avalon_q1_ob_contract_taurus_intro_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace mp_sat_avalon_q1_ob_contract_taurus_intro_cs
// Params 3, eflags: 0x4
// Checksum 0x8076e37e, Offset: 0x1224
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "mp_sat_avalon_q1_ob_contract_taurus_intro_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "mp_sat_avalon_q1_ob_contract_taurus_intro_cs" );
}

// Namespace mp_sat_avalon_q1_ob_contract_taurus_intro_cs
// Params 3, eflags: 0x4
// Checksum 0xb20af670, Offset: 0x129e
// Size: 0x1920
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_intro_cs";
    s.activity_bundle = "sat_activitydef_taurus_intro";
    s.name = "REV_OB_TAURUS_INTRO";
    fe [[ f ]]( s, "REV_OB_TAURUS_INTRO", cf, ( -25976, 15280, 1656 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_intro_cs";
    fe [[ f ]]( s, "REV_OB_TAURUS_INTRO", cf, ( -25976, 15232, 1656 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "test_radii", undefined, "activity_link", undefined, undefined, 1000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_intro_cs";
    fe [[ f ]]( s, "REV_OB_TAURUS_INTRO", cf, ( -21414, 15252, 1424 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Exclusion_Zone", undefined, "activity_link", undefined, undefined, 3000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_intro_cs";
    s.loop_route = "1";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.start_point = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "REV_OB_TAURUS_INTRO", cf, ( -25106.8, 15714.4, 1552 ), ( 0, 85, 0 ), "cspf_0_auto11504574555985547124", "cspf_0_auto4238784157016192862" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_intro_cs";
    fe [[ f ]]( s, "REV_OB_TAURUS_INTRO", cf, ( -25988, 14612, 1656 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Exclusion_Zone", undefined, "activity_link", undefined, undefined, 3000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_intro_cs";
    s._size_max = ( 1378, 1212, 732 );
    s._size_min = ( 984, 948, 200 );
    s.var_5afd49978f924648 = "1";
    s.var_a8568d8e0b0b6076 = "1";
    s.var_3f3960eb7318312d = "1";
    s.default_goal_radius = "-1";
    s.script_stealthgroup = "-1";
    s.script_string = "enc_taurus_intro_regroup";
    s.var_95e2cee7aca5aaae = "0";
    s.width = "128";
    fe [[ f ]]( s, "REV_OB_TAURUS_INTRO", cf, ( -26385.4, 14975.2, 1510.09 ), ( 0, 270, 0 ), "enc_taurus_intro_regroup_vol", "cspf_0_auto10168148151402903889", "noent_volume_ai_encounter_cs" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_intro_cs";
    fe [[ f ]]( s, "REV_OB_TAURUS_INTRO", cf, ( -17208, 5656, 3920 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Exclusion_Zone", undefined, "activity_link", undefined, undefined, 1280 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_intro_cs";
    s.var_433589829cadc877 = "1";
    s.goal_area_target = "taurus_intro_regroup_goal_04";
    s.groupid = "taurus_intro_regroup";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.reusecooldown = "5";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "taurus_intro_regroup_special";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "REV_OB_TAURUS_INTRO", cf, ( -25112.5, 15670.2, 1536 ), ( 0, 93.94, 0 ), "cspf_0_auto10168148151402903889", "cspf_0_auto11504574555985547124", "taurus_intro_regroup_special" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_intro_cs";
    s.var_433589829cadc877 = "1";
    s.goal_area_target = "taurus_intro_regroup_goal_02";
    s.groupid = "taurus_intro_regroup";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.reusecooldown = "5";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "taurus_intro_regroup_regular";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "REV_OB_TAURUS_INTRO", cf, ( -25964.5, 13941.5, 1476 ), ( 0, 218.94, 0 ), "cspf_0_auto10168148151402903889", "cspf_0_auto16494740902815082106", "taurus_intro_regroup_regular" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_intro_cs";
    s.loop_route = "1";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.start_point = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "REV_OB_TAURUS_INTRO", cf, ( -25990.4, 13920, 1484 ), ( 0, 240, 0 ), "cspf_0_auto16494740902815082106", "cspf_0_auto6071377576108022941" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_intro_cs";
    s.loop_route = "1";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.start_point = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "REV_OB_TAURUS_INTRO", cf, ( -26791.5, 15694.2, 1520 ), ( 0, 180, 0 ), "cspf_0_auto6765928612504745703", "cspf_0_auto2799237917806980479" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_intro_cs";
    s.var_433589829cadc877 = "1";
    s.goal_area_target = "taurus_intro_regroup_interior_south_mob_1_goal";
    s.groupid = "taurus_intro_regroup";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.reusecooldown = "5";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "taurus_intro_regroup_interior_special_mob";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "REV_OB_TAURUS_INTRO", cf, ( -26440.4, 15267.9, 1516 ), ( 0, 270, 0 ), "cspf_0_auto10168148151402903889", "taurus_intro_regroup_interior_south_mob_1_goal", "taurus_intro_regroup_interior_south_mob" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_intro_cs";
    s.var_433589829cadc877 = "1";
    s.goal_area_target = "taurus_intro_regroup_interior_south_mob_2_goal";
    s.groupid = "taurus_intro_regroup";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.reusecooldown = "5";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "taurus_intro_regroup_interior_special_mob";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "REV_OB_TAURUS_INTRO", cf, ( -26557, 15310.4, 1514 ), ( 0, 270, 0 ), "cspf_0_auto10168148151402903889", "taurus_intro_regroup_interior_south_mob_2_goal", "taurus_intro_regroup_interior_south_mob" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_intro_cs";
    s.var_433589829cadc877 = "1";
    s.goal_area_target = "taurus_intro_regroup_goal_03";
    s.groupid = "taurus_intro_regroup";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.reusecooldown = "5";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "taurus_intro_regroup_regular";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "REV_OB_TAURUS_INTRO", cf, ( -26751.5, 15694.2, 1504 ), ( 0, 203.94, 0 ), "cspf_0_auto10168148151402903889", "cspf_0_auto6765928612504745703", "taurus_intro_regroup_regular" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_intro_cs";
    s.var_433589829cadc877 = "1";
    s.goal_area_target = "taurus_intro_regroup_goal_04";
    s.groupid = "taurus_intro_regroup";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.reusecooldown = "5";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "taurus_intro_regroup_regular";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "REV_OB_TAURUS_INTRO", cf, ( -25122.1, 15823.7, 1536 ), ( 0, 293.94, 0 ), "cspf_0_auto10168148151402903889", "cspf_0_auto1620060917517008573", "taurus_intro_regroup_regular" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_intro_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "REV_OB_TAURUS_INTRO", cf, ( -26006.9, 13894.1, 1484 ), ( 0, 240, 0 ), "cspf_0_auto6071377576108022941" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_intro_cs";
    s.var_433589829cadc877 = "1";
    s.goal_area_target = "taurus_intro_regroup_goal_02";
    s.groupid = "taurus_intro_regroup";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.reusecooldown = "5";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "taurus_intro_regroup_regular";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "REV_OB_TAURUS_INTRO", cf, ( -26002.5, 13785.2, 1484 ), ( 0, 98.94, 0 ), "cspf_0_auto10168148151402903889", "cspf_0_auto7782340461047263353", "taurus_intro_regroup_regular" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_intro_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "REV_OB_TAURUS_INTRO", cf, ( -26815.5, 15694.2, 1520 ), ( 0, 180, 0 ), "cspf_0_auto2799237917806980479" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_intro_cs";
    s.var_433589829cadc877 = "1";
    s.goal_area_target = "taurus_intro_regroup_sniper_goal";
    s.groupid = "taurus_intro_regroup";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.reusecooldown = "5";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "taurus_intro_regroup_sniper";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "REV_OB_TAURUS_INTRO", cf, ( -26579, 15105.2, 1676 ), ( 0, 278.94, 0 ), "cspf_0_auto10168148151402903889", "taurus_intro_regroup_sniper_goal", "taurus_intro_regroup_sniper" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_intro_cs";
    s.var_433589829cadc877 = "1";
    s.goal_area_target = "taurus_intro_regroup_interior_special_goal";
    s.groupid = "taurus_intro_regroup";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.reusecooldown = "5";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "taurus_intro_regroup_interior_special";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "REV_OB_TAURUS_INTRO", cf, ( -26519, 15189.2, 1514 ), ( 0, 270, 0 ), "cspf_0_auto10168148151402903889", "taurus_intro_regroup_interior_special_goal", "taurus_intro_regroup_interior_south" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_intro_cs";
    s.var_433589829cadc877 = "1";
    s.goal_area_target = "taurus_intro_regroup_interior_stairs_postup_goal";
    s.groupid = "taurus_intro_regroup";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.reusecooldown = "5";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "taurus_intro_regroup_interior_special_upstairs";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "REV_OB_TAURUS_INTRO", cf, ( -25992, 15235.1, 1680 ), ( 0, 90, 0 ), "cspf_0_auto10168148151402903889", "taurus_intro_regroup_interior_stairs_postup_goal", "taurus_intro_regroup_interior_special_upstairs_postup" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_intro_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "REV_OB_TAURUS_INTRO", cf, ( -25104.7, 15738.3, 1552 ), ( 0, 85, 0 ), "cspf_0_auto4238784157016192862" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_intro_cs";
    s.loop_route = "1";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.start_point = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "REV_OB_TAURUS_INTRO", cf, ( -26008.2, 13825.6, 1484 ), ( 0, 95, 0 ), "cspf_0_auto7782340461047263353", "cspf_0_auto9667564035060819361" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_intro_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "REV_OB_TAURUS_INTRO", cf, ( -26014.6, 13852.2, 1484 ), ( 0, 95, 0 ), "cspf_0_auto9667564035060819361" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_intro_cs";
    s.loop_route = "1";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.start_point = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "REV_OB_TAURUS_INTRO", cf, ( -25118.3, 15796.4, 1536 ), ( 0, 285, 0 ), "cspf_0_auto1620060917517008573", "cspf_0_auto9062428249682970919" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_intro_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "REV_OB_TAURUS_INTRO", cf, ( -25111.3, 15768.6, 1536 ), ( 0, 285, 0 ), "cspf_0_auto9062428249682970919" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_intro_cs";
    s.loop_route = "1";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.start_point = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "REV_OB_TAURUS_INTRO", cf, ( -26063.2, 13894.5, 1492 ), ( 0, 340, 0 ), "cspf_0_auto172291544989550116", "cspf_0_auto4678876176040721495" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_intro_cs";
    s.var_433589829cadc877 = "1";
    s.goal_area_target = "taurus_intro_regroup_goal_02";
    s.groupid = "taurus_intro_regroup";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.reusecooldown = "5";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "taurus_intro_regroup_special";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "REV_OB_TAURUS_INTRO", cf, ( -26104.5, 13911.5, 1480 ), ( 0, 348.94, 0 ), "cspf_0_auto10168148151402903889", "cspf_0_auto172291544989550116", "taurus_intro_regroup_special" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_intro_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "REV_OB_TAURUS_INTRO", cf, ( -26040.7, 13886.3, 1492 ), ( 0, 340, 0 ), "cspf_0_auto4678876176040721495" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_intro_cs";
    s.var_433589829cadc877 = "1";
    s.goal_area_target = "taurus_intro_regroup_saferoom_guard_goal";
    s.groupid = "taurus_intro_regroup";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.reusecooldown = "5";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "taurus_intro_regroup_interior_saferoom_guard";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "REV_OB_TAURUS_INTRO", cf, ( -25946.1, 15066.2, 1680 ), ( 0, 83.94, 0 ), "cspf_0_auto10168148151402903889", "taurus_intro_regroup_saferoom_guard_goal", "taurus_intro_regroup_saferoom_guard" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_intro_cs";
    s.var_433589829cadc877 = "1";
    s.goal_area_target = "taurus_intro_regroup_interior_stairs_runner_goal";
    s.groupid = "taurus_intro_regroup";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.reusecooldown = "5";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "taurus_intro_regroup_interior_regular_upstairs";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "REV_OB_TAURUS_INTRO", cf, ( -25926.6, 15371.3, 1680 ), ( 0, 180, 0 ), "cspf_0_auto10168148151402903889", "taurus_intro_regroup_interior_stairs_runner_goal", "taurus_intro_regroup_interior_regular_upstairs_runner" );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace mp_sat_avalon_q1_ob_contract_taurus_intro_cs
// Params 0, eflags: 0x4
// Checksum 0xf106aa67, Offset: 0x2bc6
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace mp_sat_avalon_q1_ob_contract_taurus_intro_cs
// Params 0
// Checksum 0x42253e33, Offset: 0x2bd0
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "mp_sat_avalon_q1_ob_contract_taurus_intro_cs" );
}

// Namespace mp_sat_avalon_q1_ob_contract_taurus_intro_cs
// Params 0
// Checksum 0x96003492, Offset: 0x2be6
// Size: 0x44
function function_4cd78e661617f3()
{
    activityinfostruct = {};
    activityinfostruct.mainfunction = &main;
    activityinfostruct.var_934f068483ae4ddb = &function_d4323822d7042e5a;
    activityinfostruct.metadatafunction = &function_d9dd7965c51c95d1;
    return activityinfostruct;
}

// Namespace mp_sat_avalon_q1_ob_contract_taurus_intro_cs
// Params 4
// Checksum 0x528c2fa2, Offset: 0x2c33
// Size: 0x57
function function_d4323822d7042e5a( var_4312b79c960726b6, fe, us, cf = "mp_sat_avalon_q1_ob_contract_taurus_intro_cs" )
{
    switch ( var_4312b79c960726b6 )
    {
        case #"hash_52330abe28d767ce":
            function_64e3508c4fc98906( fe, us, cf );
            break;
    }
}

// Namespace mp_sat_avalon_q1_ob_contract_taurus_intro_cs
// Params 3
// Checksum 0xdd2cf29d, Offset: 0x2c92
// Size: 0x1bda
function function_64e3508c4fc98906( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_intro_cs";
    fe [[ f ]]( s, "REV_OB_TAURUS_INTRO", cf, ( 0, 0, 0 ), ( 0, 0, 0 ), "q1_taurus_intro" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_intro_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "REV_OB_TAURUS_INTRO", cf, ( -10311.5, 13685.3, 3767.77 ), ( 0, 202.86, 0 ), "taurus_intro_regroup_vehicle_air_2_start", "taurus_intro_regroup_vehicle_air_2_dropoff", undefined, undefined, undefined, undefined, undefined, undefined, 150, 1 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_intro_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "REV_OB_TAURUS_INTRO", cf, ( -38515.6, 5377.87, 882 ), ( 359.47, 166.24, 0.5 ), "taurus_intro_regroup_vehicle_air_2_dropoff", "taurus_intro_regroup_vehicle_air_2_delete", undefined, undefined, undefined, undefined, undefined, undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_intro_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "REV_OB_TAURUS_INTRO", cf, ( -61743.6, -1546.13, 8802 ), ( 359.47, 166.24, 0.5 ), "taurus_intro_regroup_vehicle_air_2_delete", undefined, undefined, undefined, undefined, undefined, undefined, undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_intro_cs";
    fe [[ f ]]( s, "REV_OB_TAURUS_INTRO", cf, ( -25898.4, 14992.4, 1675 ), ( 0, 90, 0 ), "taurus_ability_case", undefined, "taurus_intro_ability_case_1" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_intro_cs";
    fe [[ f ]]( s, "REV_OB_TAURUS_INTRO", cf, ( -25400, 15462, 1532 ), ( 0, 270, 0 ), "taurus_intro_regroup_goal_04", undefined, undefined, undefined, undefined, undefined, undefined, 500 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_intro_cs";
    s.height = 120;
    fe [[ f ]]( s, "REV_OB_TAURUS_INTRO", cf, ( -26080, 15156, 1686 ), ( 0, 0, 0 ), "taurus_intro_regroup_interior_upstairs_goal", undefined, undefined, undefined, undefined, undefined, undefined, 300 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_intro_cs";
    fe [[ f ]]( s, "REV_OB_TAURUS_INTRO", cf, ( -24554.6, 13390, 1456 ), ( 0, 145, 0 ), "taurus_intro_respawn_structs" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_intro_cs";
    fe [[ f ]]( s, "REV_OB_TAURUS_INTRO", cf, ( -24527.1, 13429.4, 1456 ), ( 0, 145, 0 ), "taurus_intro_respawn_structs" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_intro_cs";
    fe [[ f ]]( s, "REV_OB_TAURUS_INTRO", cf, ( -24499.5, 13468.7, 1456 ), ( 0, 145, 0 ), "taurus_intro_respawn_structs" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_intro_cs";
    fe [[ f ]]( s, "REV_OB_TAURUS_INTRO", cf, ( -25264, 15694, 1544 ), ( 0, 190, 0 ), "taurus_intro_vehicle_rider_path_1", "cspf_0_auto12517628227025988322", undefined, undefined, undefined, undefined, undefined, 64 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_intro_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "REV_OB_TAURUS_INTRO", cf, ( -11084.2, 19714.4, 5803.77 ), ( 0, 197.86, 0 ), "taurus_intro_regroup_vehicle_air_3_start", "taurus_intro_regroup_vehicle_air_3_dropoff", undefined, undefined, undefined, undefined, undefined, undefined, 140, 1 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_intro_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "REV_OB_TAURUS_INTRO", cf, ( -38831.6, 13877.9, 2862 ), ( 359.47, 166.24, 0.5 ), "taurus_intro_regroup_vehicle_air_3_dropoff", "taurus_intro_regroup_vehicle_air_3_land", undefined, undefined, undefined, undefined, undefined, undefined, 50 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_intro_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "REV_OB_TAURUS_INTRO", cf, ( -63407.6, 3845.87, 10038 ), ( 359.47, 166.24, 0.5 ), "taurus_intro_regroup_vehicle_air_3_delete", undefined, undefined, undefined, undefined, undefined, undefined, undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_intro_cs";
    fe [[ f ]]( s, "REV_OB_TAURUS_INTRO", cf, ( -26120, 14346, 1532 ), ( 0, 270, 0 ), "taurus_intro_regroup_goal_01", undefined, undefined, undefined, undefined, undefined, undefined, 500 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_intro_cs";
    fe [[ f ]]( s, "REV_OB_TAURUS_INTRO", cf, ( -26704, 14374, 1532 ), ( 0, 270, 0 ), "taurus_intro_regroup_goal_02_old", undefined, undefined, undefined, undefined, undefined, undefined, 500 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_intro_cs";
    fe [[ f ]]( s, "REV_OB_TAURUS_INTRO", cf, ( -24936, 16142, 1552 ), ( 0, 190, 0 ), "taurus_intro_vehicle_rider_path_2", "cspf_0_auto15655140868045171212", undefined, undefined, undefined, undefined, undefined, 64 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_intro_cs";
    fe [[ f ]]( s, "REV_OB_TAURUS_INTRO", cf, ( -25500, 15714, 1544 ), ( 0, 190, 0 ), "cspf_0_auto12517628227025988322", "cspf_0_auto14966947659576641923", undefined, undefined, undefined, undefined, undefined, 64 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_intro_cs";
    fe [[ f ]]( s, "REV_OB_TAURUS_INTRO", cf, ( -26976, 15486, 1516 ), ( 0, 270, 0 ), "taurus_intro_regroup_goal_03", undefined, undefined, undefined, undefined, undefined, undefined, 300 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_intro_cs";
    fe [[ f ]]( s, "REV_OB_TAURUS_INTRO", cf, ( -25808, 15810, 1544 ), ( 0, 190, 0 ), "cspf_0_auto14966947659576641923", "cspf_0_auto8805259158796551143", undefined, undefined, undefined, undefined, undefined, 64 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_intro_cs";
    fe [[ f ]]( s, "REV_OB_TAURUS_INTRO", cf, ( -26208, 15754, 1544 ), ( 0, 190, 0 ), "cspf_0_auto8805259158796551143", "cspf_0_auto4386669309199912852", undefined, undefined, undefined, undefined, undefined, 64 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_intro_cs";
    s.name = "cache";
    fe [[ f ]]( s, "REV_OB_TAURUS_INTRO", cf, ( -25980.1, 14891.3, 1675 ), ( 0, 270, 0 ), "s_taurus_caches", undefined, "ob_sat_item_select_equipment_loud" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_intro_cs";
    fe [[ f ]]( s, "REV_OB_TAURUS_INTRO", cf, ( -26170, 15160, 1711 ), ( 0, 270, 0 ), "taurus_intro_house_center_struct", undefined, undefined, undefined, undefined, undefined, undefined, 160 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_intro_cs";
    fe [[ f ]]( s, "REV_OB_TAURUS_INTRO", cf, ( -26060.2, 14893, 1675 ), ( 0, 360, 0 ), "taurus_ability_case", undefined, "taurus_intro_ability_case_2" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_intro_cs";
    s.height = 120;
    fe [[ f ]]( s, "REV_OB_TAURUS_INTRO", cf, ( -25986, 14984, 1711 ), ( 0, 270, 0 ), "taurus_intro_obj_marker", undefined, undefined, undefined, undefined, undefined, undefined, 100 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_intro_cs";
    s.name = "cache";
    fe [[ f ]]( s, "REV_OB_TAURUS_INTRO", cf, ( -42608.2, 27687.9, 1587 ), ( 0, 294.95, 0 ), "s_taurus_boss_caches", undefined, "ob_sat_item_select_equipment_loud" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_intro_cs";
    s.height = 90;
    fe [[ f ]]( s, "REV_OB_TAURUS_INTRO", cf, ( -26296, 15246, 1524 ), ( 0, 270, 0 ), "taurus_intro_regroup_interior_first_floor_goal", undefined, undefined, undefined, undefined, undefined, undefined, 450 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_intro_cs";
    fe [[ f ]]( s, "REV_OB_TAURUS_INTRO", cf, ( -26328, 14154, 1532 ), ( 0, 270, 0 ), "taurus_intro_regroup_goal_02", undefined, undefined, undefined, undefined, undefined, undefined, 700 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_intro_cs";
    s.name = "cache";
    fe [[ f ]]( s, "REV_OB_TAURUS_INTRO", cf, ( -39527.1, 5669.3, 96 ), ( 0, 270, 0 ), "s_taurus_caches", undefined, "ob_sat_item_select_equipment_loud" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_intro_cs";
    s.name = "cache";
    fe [[ f ]]( s, "REV_OB_TAURUS_INTRO", cf, ( -30745.8, 7478.23, 273.51 ), ( 0, 360, 2 ), "s_taurus_caches", undefined, "ob_sat_item_select_equipment" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_intro_cs";
    s.name = "cache";
    fe [[ f ]]( s, "REV_OB_TAURUS_INTRO", cf, ( -34463, 11421, 417 ), ( 0, 90, 0 ), "s_taurus_caches", undefined, "ob_sat_item_select_weapon_sm_tier_3" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_intro_cs";
    s.height = 120;
    fe [[ f ]]( s, "REV_OB_TAURUS_INTRO", cf, ( -26504, 15084, 1686 ), ( 0, 270, 0 ), "taurus_intro_regroup_sniper_goal", undefined, undefined, undefined, undefined, undefined, undefined, 80 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_intro_cs";
    fe [[ f ]]( s, "REV_OB_TAURUS_INTRO", cf, ( -26516, 14926, 1532 ), ( 0, 270, 0 ), "taurus_intro_regroup_interior_south", undefined, undefined, undefined, undefined, undefined, undefined, 64 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_intro_cs";
    fe [[ f ]]( s, "REV_OB_TAURUS_INTRO", cf, ( -39680.9, 5727.87, 96 ), ( 0, 270, 0 ), "taurus_ability_case", undefined, "taurus_destroy_supplies_ability_case_2" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_intro_cs";
    fe [[ f ]]( s, "REV_OB_TAURUS_INTRO", cf, ( -26476, 15126, 1527 ), ( 0, 270, 0 ), "taurus_intro_house_interior_struct", undefined, undefined, undefined, undefined, undefined, undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_intro_cs";
    fe [[ f ]]( s, "REV_OB_TAURUS_INTRO", cf, ( -26484, 15390, 1527 ), ( 0, 270, 0 ), "taurus_intro_house_interior_struct", undefined, undefined, undefined, undefined, undefined, undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_intro_cs";
    fe [[ f ]]( s, "REV_OB_TAURUS_INTRO", cf, ( -26148, 15140, 1527 ), ( 0, 270, 0 ), "taurus_intro_house_interior_struct", undefined, undefined, undefined, undefined, undefined, undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_intro_cs";
    fe [[ f ]]( s, "REV_OB_TAURUS_INTRO", cf, ( -26452, 15258, 1527 ), ( 0, 180, 0 ), "taurus_intro_house_interior_first_floor_goal", undefined, undefined, undefined, undefined, undefined, undefined, 100 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_intro_cs";
    s.height = 120;
    fe [[ f ]]( s, "REV_OB_TAURUS_INTRO", cf, ( -26344, 14910, 1532 ), ( 0, 270, 0 ), "taurus_intro_regroup_goal", undefined, undefined, undefined, undefined, undefined, undefined, 1800 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_intro_cs";
    fe [[ f ]]( s, "REV_OB_TAURUS_INTRO", cf, ( -42693.1, 27644, 1588 ), ( 0, 25, 0 ), "taurus_ability_case", undefined, "taurus_cradle_vents_ability_case_2_loc01" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_intro_cs";
    fe [[ f ]]( s, "REV_OB_TAURUS_INTRO", cf, ( -42886.1, 27904.8, 1573 ), ( 0, 225, 0 ), "taurus_ability_case", undefined, "taurus_cradle_vents_ability_case_1_loc01" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_intro_cs";
    fe [[ f ]]( s, "REV_OB_TAURUS_INTRO", cf, ( -29968.5, 14002.7, 736 ), ( 0, 225, 0 ), "taurus_destroy_supplies_ontheway_respawn_struct" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_intro_cs";
    fe [[ f ]]( s, "REV_OB_TAURUS_INTRO", cf, ( -39416.9, 5669.95, 96 ), ( 0, 35, 0 ), "taurus_ability_case", undefined, "taurus_destroy_supplies_ability_case_1" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_intro_cs";
    fe [[ f ]]( s, "REV_OB_TAURUS_INTRO", cf, ( -35832, 7508, 336 ), ( 0, 45, 0 ), "taurus_destroy_supplies_obj_breadcrumb_3", undefined, undefined, undefined, undefined, undefined, undefined, 1000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_intro_cs";
    fe [[ f ]]( s, "REV_OB_TAURUS_INTRO", cf, ( -28178.6, 14414.4, 1360 ), ( 0, 45, 0 ), "taurus_destroy_supplies_obj_breadcrumb_start", "taurus_destroy_supplies_obj_breadcrumb_2", undefined, undefined, undefined, undefined, undefined, 1000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_intro_cs";
    fe [[ f ]]( s, "REV_OB_TAURUS_INTRO", cf, ( -34120, 12188, 464 ), ( 0, 45, 0 ), "taurus_destroy_supplies_obj_breadcrumb_2", "taurus_destroy_supplies_obj_breadcrumb_3", undefined, undefined, undefined, undefined, undefined, 1500 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_intro_cs";
    fe [[ f ]]( s, "REV_OB_TAURUS_INTRO", cf, ( -38824, 5356, 400 ), ( 0, 45, 0 ), "taurus_destroy_supplies_obj", undefined, undefined, undefined, undefined, undefined, undefined, 3000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_intro_cs";
    s.var_a599ed8791c4f860 = "1";
    fe [[ f ]]( s, "REV_OB_TAURUS_INTRO", cf, ( -26512, 14900, 1552 ), ( 0, 0, 0 ), "taurus_intro_obj_marker_breadcrumb_2", "taurus_intro_obj_marker_breadcrumb_3", undefined, undefined, undefined, undefined, undefined, 300 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_intro_cs";
    fe [[ f ]]( s, "REV_OB_TAURUS_INTRO", cf, ( -24576, 13524, 1480 ), ( 0, 0, 0 ), "taurus_intro_obj_marker_breadcrumb_start", "taurus_intro_obj_marker_breadcrumb_2", undefined, undefined, undefined, undefined, undefined, 600 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_intro_cs";
    s.height = 120;
    fe [[ f ]]( s, "REV_OB_TAURUS_INTRO", cf, ( -25946, 15116, 1686 ), ( 0, 90, 0 ), "taurus_intro_regroup_saferoom_guard_goal", undefined, undefined, undefined, undefined, undefined, undefined, 32 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_intro_cs";
    fe [[ f ]]( s, "REV_OB_TAURUS_INTRO", cf, ( -24472, 13508, 1456 ), ( 0, 145, 0 ), "taurus_intro_respawn_structs" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_intro_cs";
    s.height = 120;
    fe [[ f ]]( s, "REV_OB_TAURUS_INTRO", cf, ( -25958.7, 15371.8, 1686 ), ( 0, 180, 0 ), "taurus_intro_regroup_interior_stairs_runner_goal", undefined, undefined, undefined, undefined, undefined, undefined, 32 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_intro_cs";
    s.height = 120;
    fe [[ f ]]( s, "REV_OB_TAURUS_INTRO", cf, ( -25998.7, 15307.7, 1686 ), ( 0, 90, 0 ), "taurus_intro_regroup_interior_stairs_postup_goal", undefined, undefined, undefined, undefined, undefined, undefined, 32 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_intro_cs";
    fe [[ f ]]( s, "REV_OB_TAURUS_INTRO", cf, ( -26114, 14905, 1755.75 ), ( 359.35, 90, -0 ), "s_taurus_intro_weapon", undefined, "ob_sat_item_weapon_ar_eagle,purple" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_intro_cs";
    fe [[ f ]]( s, "REV_OB_TAURUS_INTRO", cf, ( -26516, 15134, 1532 ), ( 0, 270, 0 ), "taurus_intro_regroup_interior_special_goal", undefined, undefined, undefined, undefined, undefined, undefined, 32 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_intro_cs";
    fe [[ f ]]( s, "REV_OB_TAURUS_INTRO", cf, ( -26444, 15230, 1532 ), ( 0, 270, 0 ), "taurus_intro_regroup_interior_south_mob_1_goal", undefined, undefined, undefined, undefined, undefined, undefined, 32 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_intro_cs";
    fe [[ f ]]( s, "REV_OB_TAURUS_INTRO", cf, ( -26556, 15254, 1532 ), ( 0, 270, 0 ), "taurus_intro_regroup_interior_south_mob_2_goal", undefined, undefined, undefined, undefined, undefined, undefined, 32 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_intro_cs";
    fe [[ f ]]( s, "REV_OB_TAURUS_INTRO", cf, ( -35780.5, 7263.44, 288 ), ( 0, 270, 0 ), "taurus_destroy_supplies_respawn_struct" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_intro_cs";
    fe [[ f ]]( s, "REV_OB_TAURUS_INTRO", cf, ( -26113.9, 14953.1, 1723.25 ), ( 0, 90, 0 ), "s_taurus_intro_weapon", undefined, "ob_sat_item_weapon_sm_otter,purple" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_intro_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "REV_OB_TAURUS_INTRO", cf, ( -13879.5, 15605.3, 4855.77 ), ( 0, 202.86, 0 ), "taurus_intro_regroup_vehicle_air_start", "taurus_intro_regroup_vehicle_air_dropoff", undefined, undefined, undefined, undefined, undefined, undefined, 150, 1 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_intro_cs";
    fe [[ f ]]( s, "REV_OB_TAURUS_INTRO", cf, ( -26114, 14947, 1755.75 ), ( 359.32, 90, -0 ), "s_taurus_intro_weapon", undefined, "ob_sat_item_weapon_sh_husky,purple" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_intro_cs";
    fe [[ f ]]( s, "REV_OB_TAURUS_INTRO", cf, ( -35828.5, 7263.42, 288 ), ( 0, 270, 0 ), "taurus_destroy_supplies_respawn_struct" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_intro_cs";
    fe [[ f ]]( s, "REV_OB_TAURUS_INTRO", cf, ( -35876.6, 7263.47, 288 ), ( 0, 270, 0 ), "taurus_destroy_supplies_respawn_struct" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_intro_cs";
    fe [[ f ]]( s, "REV_OB_TAURUS_INTRO", cf, ( -26113.9, 14992.1, 1725.25 ), ( 0, 90, 0 ), "s_taurus_intro_weapon", undefined, "ob_sat_item_weapon_pi_orion,purple" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_intro_cs";
    fe [[ f ]]( s, "REV_OB_TAURUS_INTRO", cf, ( -26114, 14989, 1755.5 ), ( 359.23, 90, 0.03 ), "s_taurus_intro_weapon", undefined, "ob_sat_item_weapon_dm_scotia,purple" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_intro_cs";
    fe [[ f ]]( s, "REV_OB_TAURUS_INTRO", cf, ( -35924.5, 7263.45, 288 ), ( 0, 270, 0 ), "taurus_destroy_supplies_respawn_struct" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_intro_cs";
    fe [[ f ]]( s, "REV_OB_TAURUS_INTRO", cf, ( -38188.5, 10359.5, -5856 ), ( 0, 180, 0 ), "taurus_destroy_supplies_void_docks_respawn_struct" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_intro_cs";
    fe [[ f ]]( s, "REV_OB_TAURUS_INTRO", cf, ( -39212.5, 10479.5, -5856 ), ( 0, 360, 0 ), "taurus_destroy_supplies_void_docks_respawn_struct" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_intro_cs";
    fe [[ f ]]( s, "REV_OB_TAURUS_INTRO", cf, ( -26005, 14978, 1675 ), ( 0, 0, 0 ), "taurus_intro_safehouse_smoke_vfx" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_intro_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "REV_OB_TAURUS_INTRO", cf, ( -62399.6, 597.87, 9090 ), ( 359.47, 166.24, 0.5 ), "taurus_intro_regroup_vehicle_air_delete", undefined, undefined, undefined, undefined, undefined, undefined, undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_intro_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s._size_max = ( 8682.25, 16073.1, 16384 );
    s._size_min = ( 16384, 16295.2, 16300 );
    fe [[ f ]]( s, "REV_OB_TAURUS_INTRO", cf, ( -39756.4, 17749.4, -655.75 ), ( 0, 0, 0 ), "taurus_oob_volume" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_intro_cs";
    fe [[ f ]]( s, "REV_OB_TAURUS_INTRO", cf, ( -38188.5, 10479.5, -5856 ), ( 0, 180, 0 ), "taurus_destroy_supplies_void_docks_respawn_struct" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_intro_cs";
    fe [[ f ]]( s, "REV_OB_TAURUS_INTRO", cf, ( -24972, 15906, 1540 ), ( 0, 190, 0 ), "cspf_0_auto15655140868045171212", "cspf_0_auto9256107633844951428", undefined, undefined, undefined, undefined, undefined, 64 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_intro_cs";
    fe [[ f ]]( s, "REV_OB_TAURUS_INTRO", cf, ( -25036, 15770, 1540 ), ( 0, 190, 0 ), "cspf_0_auto9256107633844951428", undefined, undefined, undefined, undefined, undefined, undefined, 32 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_intro_cs";
    fe [[ f ]]( s, "REV_OB_TAURUS_INTRO", cf, ( -26752, 15746, 1512 ), ( 0, 190, 0 ), "cspf_0_auto4386669309199912852", undefined, undefined, undefined, undefined, undefined, undefined, 32 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_intro_cs";
    fe [[ f ]]( s, "REV_OB_TAURUS_INTRO", cf, ( -25108, 16102, 1552 ), ( 0, 135, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_intro_cs";
    fe [[ f ]]( s, "REV_OB_TAURUS_INTRO", cf, ( -30002.5, 14036.7, 736 ), ( 0, 225, 0 ), "taurus_destroy_supplies_ontheway_respawn_struct" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_intro_cs";
    fe [[ f ]]( s, "REV_OB_TAURUS_INTRO", cf, ( -30036.4, 14070.7, 736 ), ( 0, 225, 0 ), "taurus_destroy_supplies_ontheway_respawn_struct" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_intro_cs";
    fe [[ f ]]( s, "REV_OB_TAURUS_INTRO", cf, ( -30070.3, 14104.6, 736 ), ( 0, 225, 0 ), "taurus_destroy_supplies_ontheway_respawn_struct" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_intro_cs";
    fe [[ f ]]( s, "REV_OB_TAURUS_INTRO", cf, ( -38693.2, 4638.3, 201.38 ), ( 0, 305, 0 ), "taurus_destroy_supplies_center_struct_1_REF", undefined, undefined, undefined, undefined, undefined, undefined, 13500 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_intro_cs";
    fe [[ f ]]( s, "REV_OB_TAURUS_INTRO", cf, ( -19360, 8144, 1054.87 ), ( 0, 15, 0 ), "taurus_intro_scripted_vehicle" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_intro_cs";
    fe [[ f ]]( s, "REV_OB_TAURUS_INTRO", cf, ( -39212.5, 10359.5, -5856 ), ( 0, 360, 0 ), "taurus_destroy_supplies_void_docks_respawn_struct" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_intro_cs";
    fe [[ f ]]( s, "REV_OB_TAURUS_INTRO", cf, ( -18768, 6968, 1032 ), ( 0, 300, 0 ), "taurus_intro_scripted_vehicle" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_intro_cs";
    fe [[ f ]]( s, "REV_OB_TAURUS_INTRO", cf, ( -18248, 7664, 1032 ), ( 0, 345, 0 ), "taurus_intro_scripted_vehicle" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_intro_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "REV_OB_TAURUS_INTRO", cf, ( -38967, 13657, 434 ), ( 0, 180, 0 ), "taurus_intro_regroup_vehicle_air_3_land", undefined, undefined, undefined, undefined, undefined, undefined, undefined, 70 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_intro_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "REV_OB_TAURUS_INTRO", cf, ( -38655.6, 12117.9, 2862 ), ( 359.47, 166.24, 0.5 ), "taurus_intro_regroup_vehicle_air_dropoff", "taurus_intro_regroup_vehicle_air_land", undefined, undefined, undefined, undefined, undefined, undefined, 50 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_intro_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "REV_OB_TAURUS_INTRO", cf, ( -38791, 11977, 434 ), ( 0, 180, 0 ), "taurus_intro_regroup_vehicle_air_land", undefined, undefined, undefined, undefined, undefined, undefined, undefined, 70 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_intro_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s._size_max = ( 8682.25, 3638.73, 16384 );
    s._size_min = ( 16384, 16295.2, 16300 );
    fe [[ f ]]( s, "REV_OB_TAURUS_INTRO", cf, ( -20261.1, 17749.4, -655.75 ), ( 0, 0, 0 ), "taurus_oob_volume" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_intro_cs";
    fe [[ f ]]( s, "REV_OB_TAURUS_INTRO", cf, ( -26488, 15348, 1520 ), ( 0, 0, 0 ), "taurus_intro_obj_marker_breadcrumb_3", undefined, undefined, undefined, undefined, undefined, undefined, 150 );
}

// Namespace mp_sat_avalon_q1_ob_contract_taurus_intro_cs
// Params 0
// Checksum 0xd0382d29, Offset: 0x4874
// Size: 0xae
function function_d9dd7965c51c95d1()
{
    activityinstances = [];
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_activitydef_taurus_intro";
    var_881289d7987bc770.cf = "mp_sat_avalon_q1_ob_contract_taurus_intro_cs";
    var_881289d7987bc770.scriptstructorigin = ( -25976, 15280, 1656 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [];
    var_881289d7987bc770.var_31ce4477e3543d24 = [];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [];
    var_881289d7987bc770.locationradius = [];
    activityinstances[ "REV_OB_TAURUS_INTRO" ] = var_881289d7987bc770;
    return activityinstances;
}

