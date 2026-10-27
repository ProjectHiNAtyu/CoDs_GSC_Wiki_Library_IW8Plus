// script_2bee3545d5270dd6  (hash_2bee3545d5270dd6.gscc) (size: 33245 Bytes / 0x81dd / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x123c41f1 (305938929)
// size ...... 33245 (0x81dd)
// includes .. 4   (offset: 0x7009)
// strings ... 74  (offset: 0x7029)
// dev strs .. 0   (offset: 0x81dd)
// exports ... 19  (offset: 0x6975)
// cseg ...... 0x85f + 0x6116 (0x6975)
// imports ... 32  (offset: 0x6c6d)
// animtree1 . 0   (offset: 0x81dd)
// animtree2 . 0   (offset: 0x81dd)
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace mp_sat_avalon_quad_03_ob_activity_merc_camp_cs;

// Namespace mp_sat_avalon_quad_03_ob_activity_merc_camp_cs
// Params 0, eflags: 0x5
// Checksum 0xfb7888ec, Offset: 0x87d
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"mp_sat_avalon_quad_03_ob_activity_merc_camp_cs", #"activity_common", &function_b39ecd3d51489472, undefined );
}

// Namespace mp_sat_avalon_quad_03_ob_activity_merc_camp_cs
// Params 0, eflags: 0x4
// Checksum 0x472a9f3d, Offset: 0x8a6
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace mp_sat_avalon_quad_03_ob_activity_merc_camp_cs
// Params 0, eflags: 0x4
// Checksum 0xc2114cd1, Offset: 0x8b7
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace mp_sat_avalon_quad_03_ob_activity_merc_camp_cs
// Params 2
// Checksum 0x51f0d560, Offset: 0x8c8
// Size: 0x8c
function main( unused, unused2 )
{
    if ( utility::flag_exist( "mp_sat_avalon_quad_03_ob_activity_merc_camp_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "mp_sat_avalon_quad_03_ob_activity_merc_camp_cs" ) )
    {
        return;
    }
    
    activity_common::function_e1df676808c1d1e3( &function_4cd78e661617f3 );
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "mp_sat_avalon_quad_03_ob_activity_merc_camp_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "mp_sat_avalon_quad_03_ob_activity_merc_camp_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace mp_sat_avalon_quad_03_ob_activity_merc_camp_cs
// Params 3, eflags: 0x4
// Checksum 0x4193f81e, Offset: 0x95c
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "mp_sat_avalon_quad_03_ob_activity_merc_camp_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "mp_sat_avalon_quad_03_ob_activity_merc_camp_cs" );
}

// Namespace mp_sat_avalon_quad_03_ob_activity_merc_camp_cs
// Params 3, eflags: 0x4
// Checksum 0xff267639, Offset: 0x9d6
// Size: 0x2d2b
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_camp_cs";
    s.activity_bundle = "sat_activitydefinition_merccamp";
    s.name = "MERC_CAMP_Q3_BRIDGE_NORTH";
    s.var_7a0840be22b9ebb = "SUPPLY_DROP_Q3_FIRINGRANGE_MIL_MESS_HALL";
    fe [[ f ]]( s, "MERC_CAMP_Q3_BRIDGE_NORTH", cf, ( -23392.9, -11333.5, 1148.71 ), ( 0, 333.36, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_camp_cs";
    fe [[ f ]]( s, "MERC_CAMP_Q3_BRIDGE_NORTH", cf, ( -23276.3, -11287.7, 845.49 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Awareness_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 4000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_camp_cs";
    fe [[ f ]]( s, "MERC_CAMP_Q3_BRIDGE_NORTH", cf, ( -23508.3, -11339.7, 837.49 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Ambient_AI_Exclusion_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 2000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_camp_cs";
    fe [[ f ]]( s, "MERC_CAMP_Q3_BRIDGE_NORTH", cf, ( -23276.3, -11287.7, 845.49 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Cleanup_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 5000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_camp_cs";
    s.groupid = "reinforcement_spawn_point";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "camp_reinforce_heli";
    s.variantname = "ai_encounter_spawnpoint";
    s.var_4501e0172e168ddf = "MERC_CAMP_Q3_BRIDGE_NORTH_VTOL";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "MERC_CAMP_Q3_BRIDGE_NORTH", cf, ( -23343.8, -11471.2, 820.91 ), ( 0, 162.58, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_camp_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "parachute_reinforce";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "MERC_CAMP_Q3_BRIDGE_NORTH", cf, ( -23305.6, -11607.1, 813.36 ), ( 0, 105.12, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_camp_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "parachute_reinforce";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "MERC_CAMP_Q3_BRIDGE_NORTH", cf, ( -23190.8, -11681.4, 809.15 ), ( 0, 125.84, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_camp_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "parachute_reinforce";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "MERC_CAMP_Q3_BRIDGE_NORTH", cf, ( -23368, -11723.5, 809.33 ), ( 0, 109.22, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_camp_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "parachute_reinforce";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "MERC_CAMP_Q3_BRIDGE_NORTH", cf, ( -23244.2, -11776.8, 806.02 ), ( 0, 99.91, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_camp_cs";
    s.activity_bundle = "sat_activitydefinition_merccamp";
    s.name = "MERC_CAMP_Q3_COAST_GUARD";
    s.var_7a0840be22b9ebb = "SUPPLY_DROP_Q1_CAPE_MANSION";
    fe [[ f ]]( s, "MERC_CAMP_Q3_COAST_GUARD", cf, ( -36654.1, -16298.5, 658.98 ), ( 0, 333.36, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_camp_cs";
    fe [[ f ]]( s, "MERC_CAMP_Q3_COAST_GUARD", cf, ( -36592.7, -16079.3, 319.95 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Awareness_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 4000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_camp_cs";
    fe [[ f ]]( s, "MERC_CAMP_Q3_COAST_GUARD", cf, ( -36675.2, -16370.8, 311.95 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Ambient_AI_Exclusion_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 2000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_camp_cs";
    fe [[ f ]]( s, "MERC_CAMP_Q3_COAST_GUARD", cf, ( -36592.7, -16079.3, 319.95 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Cleanup_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 5000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_camp_cs";
    s.groupid = "reinforcement_spawn_point";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "camp_reinforce_heli";
    s.variantname = "ai_encounter_spawnpoint";
    s.var_4501e0172e168ddf = "MERC_CAMP_Q3_COAST_GUARD_VTOL";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "MERC_CAMP_Q3_COAST_GUARD", cf, ( -36851.3, -16556.1, 319.2 ), ( 0, 55.23, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_camp_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "parachute_reinforce";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "MERC_CAMP_Q3_COAST_GUARD", cf, ( -36832.6, -16217.4, 319 ), ( 0, 276.98, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_camp_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "parachute_reinforce";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "MERC_CAMP_Q3_COAST_GUARD", cf, ( -36713.2, -16193.4, 319 ), ( 0, 261.72, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_camp_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "parachute_reinforce";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "MERC_CAMP_Q3_COAST_GUARD", cf, ( -36890.2, -16091.8, 319 ), ( 0, 279.72, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_camp_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "parachute_reinforce";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "MERC_CAMP_Q3_COAST_GUARD", cf, ( -36759.4, -16034.4, 319 ), ( 0, 254.27, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_camp_cs";
    s.activity_bundle = "sat_activitydefinition_merccamp";
    s.name = "MERC_CAMP_Q3_LISTENING_POST";
    s.var_7a0840be22b9ebb = "SUPPLY_DROP_Q3_FORT_MIFORT";
    fe [[ f ]]( s, "MERC_CAMP_Q3_LISTENING_POST", cf, ( -16916.2, -42876.2, 584.65 ), ( 0, 333.36, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_camp_cs";
    fe [[ f ]]( s, "MERC_CAMP_Q3_LISTENING_POST", cf, ( -16693.9, -42826, 306.95 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Awareness_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 4000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_camp_cs";
    fe [[ f ]]( s, "MERC_CAMP_Q3_LISTENING_POST", cf, ( -16788.9, -42909.5, 298.95 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Ambient_AI_Exclusion_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 2000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_camp_cs";
    fe [[ f ]]( s, "MERC_CAMP_Q3_LISTENING_POST", cf, ( -16693.9, -42826, 306.95 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Cleanup_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 5000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_camp_cs";
    s.groupid = "reinforcement_spawn_point";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "camp_reinforce_heli";
    s.variantname = "ai_encounter_spawnpoint";
    s.var_4501e0172e168ddf = "MERC_CAMP_Q3_LISTENING_POST_VTOL";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "MERC_CAMP_Q3_LISTENING_POST", cf, ( -16405.6, -42832.4, 266.22 ), ( 0, 216.81, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_camp_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "parachute_reinforce";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "MERC_CAMP_Q3_LISTENING_POST", cf, ( -17225.9, -42984.5, 215.17 ), ( 0, 65.88, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_camp_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "parachute_reinforce";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "MERC_CAMP_Q3_LISTENING_POST", cf, ( -17039.5, -43069.4, 220.97 ), ( 0, 33.52, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_camp_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "parachute_reinforce";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "MERC_CAMP_Q3_LISTENING_POST", cf, ( -17220.3, -43124.6, 220.25 ), ( 0, 76.35, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_camp_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "parachute_reinforce";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "MERC_CAMP_Q3_LISTENING_POST", cf, ( -17142.7, -43156.7, 223.14 ), ( 0, 48.04, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_camp_cs";
    s.activity_bundle = "sat_activitydefinition_merccamp";
    s.name = "MERC_CAMP_Q3_FORT_01";
    s.var_7a0840be22b9ebb = "SUPPLY_DROP_Q3_ISLAND_ARMORY";
    fe [[ f ]]( s, "MERC_CAMP_Q3_FORT_01", cf, ( -32757.8, -31275.3, 1062.81 ), ( 0, 333.36, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_camp_cs";
    fe [[ f ]]( s, "MERC_CAMP_Q3_FORT_01", cf, ( -32407.9, -31354.7, 712.33 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Awareness_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 4000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_camp_cs";
    fe [[ f ]]( s, "MERC_CAMP_Q3_FORT_01", cf, ( -32357.6, -31302.3, 712.33 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Ambient_AI_Exclusion_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 2000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_camp_cs";
    fe [[ f ]]( s, "MERC_CAMP_Q3_FORT_01", cf, ( -32363.8, -31354.5, 712.33 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Cleanup_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 5000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_camp_cs";
    s.groupid = "reinforcement_spawn_point";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "camp_reinforce_heli";
    s.variantname = "ai_encounter_spawnpoint";
    s.var_4501e0172e168ddf = "MERC_CAMP_Q3_FORT_01_VTOL";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "MERC_CAMP_Q3_FORT_01", cf, ( -32501.6, -31776.1, 674.72 ), ( 0, 292.95, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_camp_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "parachute_reinforce";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "MERC_CAMP_Q3_FORT_01", cf, ( -32766.2, -31054.3, 677.97 ), ( 0, 318.14, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_camp_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "parachute_reinforce";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "MERC_CAMP_Q3_FORT_01", cf, ( -32770.6, -30904.7, 680.55 ), ( 0, 295.26, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_camp_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "parachute_reinforce";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "MERC_CAMP_Q3_FORT_01", cf, ( -32924.5, -31024.9, 672.85 ), ( 0, 323.29, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_camp_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "parachute_reinforce";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "MERC_CAMP_Q3_FORT_01", cf, ( -32924.7, -30868.7, 674.84 ), ( 0, 313.75, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_camp_cs";
    s.activity_bundle = "sat_activitydefinition_merccamp";
    s.name = "MERC_CAMP_Q3_FIRINGRANGE_GAS_STATION_01";
    s.var_7a0840be22b9ebb = "SUPPLY_DROP_Q3_FLATS_FIRE_STATION";
    fe [[ f ]]( s, "MERC_CAMP_Q3_FIRINGRANGE_GAS_STATION_01", cf, ( -24379.4, -22863.2, 1305.73 ), ( 0, 285.32, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_camp_cs";
    fe [[ f ]]( s, "MERC_CAMP_Q3_FIRINGRANGE_GAS_STATION_01", cf, ( -24291.7, -23072.3, 954.86 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Awareness_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 4000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_camp_cs";
    fe [[ f ]]( s, "MERC_CAMP_Q3_FIRINGRANGE_GAS_STATION_01", cf, ( -24340.3, -23053.3, 954.86 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Ambient_AI_Exclusion_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 1800 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_camp_cs";
    fe [[ f ]]( s, "MERC_CAMP_Q3_FIRINGRANGE_GAS_STATION_01", cf, ( -24270.9, -23032.5, 954.86 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Cleanup_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 5000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_camp_cs";
    s.groupid = "reinforcement_spawn_point";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "camp_reinforce_heli";
    s.variantname = "ai_encounter_spawnpoint";
    s.var_4501e0172e168ddf = "MERC_CAMP_Q3_FIRINGRANGE_GAS_STATION_01_VTOL";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "MERC_CAMP_Q3_FIRINGRANGE_GAS_STATION_01", cf, ( -23705.5, -22921.6, 933.72 ), ( 0, 214.52, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_camp_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "parachute_reinforce";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "MERC_CAMP_Q3_FIRINGRANGE_GAS_STATION_01", cf, ( -24039.6, -23260.9, 917.19 ), ( 0, 105.95, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_camp_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "parachute_reinforce";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "MERC_CAMP_Q3_FIRINGRANGE_GAS_STATION_01", cf, ( -24119.3, -23416.6, 897.48 ), ( 0, 95.35, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_camp_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "parachute_reinforce";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "MERC_CAMP_Q3_FIRINGRANGE_GAS_STATION_01", cf, ( -23920, -23379.7, 897.47 ), ( 0, 112.27, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_camp_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "parachute_reinforce";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "MERC_CAMP_Q3_FIRINGRANGE_GAS_STATION_01", cf, ( -23996.8, -23522.6, 881.85 ), ( 0, 105.14, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_camp_cs";
    s.activity_bundle = "sat_activitydefinition_merccamp";
    s.name = "MERC_CAMP_Q3_BRIDGE_SOUTH_01";
    s.var_7a0840be22b9ebb = "SUPPLY_DROP_Q3_LISTENING_POST_RADAR";
    fe [[ f ]]( s, "MERC_CAMP_Q3_BRIDGE_SOUTH_01", cf, ( 144.46, -38675, 1082.33 ), ( 0, 315.64, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_camp_cs";
    fe [[ f ]]( s, "MERC_CAMP_Q3_BRIDGE_SOUTH_01", cf, ( -98.71, -38873.4, 759.11 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Awareness_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 4000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_camp_cs";
    fe [[ f ]]( s, "MERC_CAMP_Q3_BRIDGE_SOUTH_01", cf, ( -55.48, -38918.1, 759.59 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Ambient_AI_Exclusion_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 1800 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_camp_cs";
    fe [[ f ]]( s, "MERC_CAMP_Q3_BRIDGE_SOUTH_01", cf, ( -98.7, -38916.2, 763.28 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Cleanup_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 5000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_camp_cs";
    s.groupid = "reinforcement_spawn_point";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "camp_reinforce_heli";
    s.variantname = "ai_encounter_spawnpoint";
    s.var_4501e0172e168ddf = "MERC_CAMP_Q3_BRIDGE_SOUTH_01_VTOL";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "MERC_CAMP_Q3_BRIDGE_SOUTH_01", cf, ( -660.14, -38674.1, 804.38 ), ( 0, 332.09, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_camp_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "parachute_reinforce";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "MERC_CAMP_Q3_BRIDGE_SOUTH_01", cf, ( -482.94, -39103.1, 819.71 ), ( 359.73, 21.11, 4.76 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_camp_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "parachute_reinforce";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "MERC_CAMP_Q3_BRIDGE_SOUTH_01", cf, ( -525.17, -38963.3, 820.11 ), ( 0.44, 35.17, 4.75 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_camp_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "parachute_reinforce";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "MERC_CAMP_Q3_BRIDGE_SOUTH_01", cf, ( -651.22, -38978.6, 839.08 ), ( 1.67, 17.35, 4.46 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_camp_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "parachute_reinforce";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "MERC_CAMP_Q3_BRIDGE_SOUTH_01", cf, ( -611.16, -39109.2, 838.48 ), ( 4.17, 24.17, 2.31 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_camp_cs";
    s.activity_bundle = "sat_activitydefinition_merccamp";
    s.name = "MERC_CAMP_Q3_LOW_TOWN_01";
    s.var_7a0840be22b9ebb = "SUPPLY_DROP_Q1_HIGHTOWN_MANSIONS_01";
    fe [[ f ]]( s, "MERC_CAMP_Q3_LOW_TOWN_01", cf, ( -3241.07, -7850.48, 1188.94 ), ( 0, 333.36, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_camp_cs";
    fe [[ f ]]( s, "MERC_CAMP_Q3_LOW_TOWN_01", cf, ( -3214.87, -7873.12, 803.97 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Awareness_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 4000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_camp_cs";
    fe [[ f ]]( s, "MERC_CAMP_Q3_LOW_TOWN_01", cf, ( -3196.23, -7900.43, 804.8 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Ambient_AI_Exclusion_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 1800 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_camp_cs";
    fe [[ f ]]( s, "MERC_CAMP_Q3_LOW_TOWN_01", cf, ( -3222.83, -7829.36, 805.34 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Cleanup_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 5000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_camp_cs";
    s.groupid = "reinforcement_spawn_point";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "camp_reinforce_heli";
    s.variantname = "ai_encounter_spawnpoint";
    s.var_4501e0172e168ddf = "MERC_CAMP_Q3_LOW_TOWN_01_VTOL";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "MERC_CAMP_Q3_LOW_TOWN_01", cf, ( -3455.2, -7541.82, 805.41 ), ( 0, 299.93, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_camp_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "parachute_reinforce";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "MERC_CAMP_Q3_LOW_TOWN_01", cf, ( -3213.5, -7500.95, 804.67 ), ( 0, 267.73, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_camp_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "parachute_reinforce";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "MERC_CAMP_Q3_LOW_TOWN_01", cf, ( -3090.59, -7430.83, 804.34 ), ( 0, 248.62, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_camp_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "parachute_reinforce";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "MERC_CAMP_Q3_LOW_TOWN_01", cf, ( -3273.45, -7382.79, 804.72 ), ( 0, 267.02, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_camp_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "parachute_reinforce";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "MERC_CAMP_Q3_LOW_TOWN_01", cf, ( -3145.29, -7315.86, 803.9 ), ( 0, 254.25, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace mp_sat_avalon_quad_03_ob_activity_merc_camp_cs
// Params 0, eflags: 0x4
// Checksum 0x4674612d, Offset: 0x3709
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace mp_sat_avalon_quad_03_ob_activity_merc_camp_cs
// Params 0
// Checksum 0x83c02553, Offset: 0x3713
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "mp_sat_avalon_quad_03_ob_activity_merc_camp_cs" );
}

// Namespace mp_sat_avalon_quad_03_ob_activity_merc_camp_cs
// Params 0
// Checksum 0x757c84eb, Offset: 0x3729
// Size: 0x66
function function_4cd78e661617f3()
{
    activityinfostruct = {};
    activityinfostruct.name = "REV_OB_MERC_CAMP";
    activityinfostruct.scriptbundle = "sat_activitydefinition_merccamp";
    activityinfostruct.mainfunction = &main;
    activityinfostruct.var_934f068483ae4ddb = &function_d4323822d7042e5a;
    activityinfostruct.metadatafunction = &function_d9dd7965c51c95d1;
    return activityinfostruct;
}

// Namespace mp_sat_avalon_quad_03_ob_activity_merc_camp_cs
// Params 4
// Checksum 0x65eace10, Offset: 0x3798
// Size: 0xf3
function function_d4323822d7042e5a( var_4312b79c960726b6, fe, us, cf = "mp_sat_avalon_quad_03_ob_activity_merc_camp_cs" )
{
    switch ( var_4312b79c960726b6 )
    {
        case #"hash_bdca0f6481c0e633":
            function_d65e537c3c30b43b( fe, us, cf );
            break;
        case #"hash_9e97c2e414332832":
            function_2b3539f2e183239a( fe, us, cf );
            break;
        case #"hash_bbacd36d8568186a":
            function_afad2fd077d21132( fe, us, cf );
            break;
        case #"hash_a1a90a18fa68de8f":
            function_3f83b685abd60a77( fe, us, cf );
            break;
        case #"hash_740fffa0ee6e6797":
            function_29b7cdced2f83d8f( fe, us, cf );
            break;
        case #"hash_682cc0d6b7bb5c7d":
            function_7ddfe8833136e195( fe, us, cf );
            break;
        case #"hash_fffd4b1840eee75":
            function_95fbe3e32265c7dd( fe, us, cf );
            break;
    }
}

// Namespace mp_sat_avalon_quad_03_ob_activity_merc_camp_cs
// Params 3
// Checksum 0xbc1e389a, Offset: 0x3893
// Size: 0x610
function function_d65e537c3c30b43b( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_camp_cs";
    s.name = "center_struct";
    fe [[ f ]]( s, "MERC_CAMP_Q3_BRIDGE_NORTH", cf, ( -23595.2, -11266.7, 842.94 ), ( 0, 0, 0 ), "MERC_CAMP_Q3_BRIDGE_NORTH", undefined, "MERC_CAMP_Q3_BRIDGE_NORTH", "link_merc_camp", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 1500 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_camp_cs";
    s.name = "guard";
    fe [[ f ]]( s, "MERC_CAMP_Q3_BRIDGE_NORTH", cf, ( -23045.8, -11221.4, 842.63 ), ( 0, 0, 0 ), "s_merc_camp_guard", undefined, undefined, undefined, "link_merc_camp", ( 0, 0, 0 ), ( 0, 0, 0 ), 250 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_camp_cs";
    s.name = "loot_cache";
    fe [[ f ]]( s, "MERC_CAMP_Q3_BRIDGE_NORTH", cf, ( -23138.2, -11056.8, 841.1 ), ( 0.27, 182.09, -2.82 ), "s_merc_camp_cache", undefined, undefined, undefined, "link_merc_camp", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_camp_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    s.script_accel = "350";
    fe [[ f ]]( s, "MERC_CAMP_Q3_BRIDGE_NORTH", cf, ( -23281.6, -11399.2, 1420.07 ), ( 0, 194.22, 0 ), "MERC_CAMP_Q3_BRIDGE_NORTH_VTOL", "cspf_8_auto18030718683867637715", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_camp_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MERC_CAMP_Q3_BRIDGE_NORTH", cf, ( -35426, -7660.43, 8639.66 ), ( 359.47, 313.06, 0.49 ), "cspf_8_auto179959079453396553", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_camp_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MERC_CAMP_Q3_BRIDGE_NORTH", cf, ( -10108.6, -16221, 7844.41 ), ( 0, 169.31, 0 ), undefined, "cspf_8_auto12597151576920466004", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150, 1 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_camp_cs";
    s.name = "sentry";
    fe [[ f ]]( s, "MERC_CAMP_Q3_BRIDGE_NORTH", cf, ( -23149.1, -11494.9, 817.18 ), ( 0, 272.88, 0 ), "s_merc_camp_sentry", undefined, undefined, undefined, "link_merc_camp", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_camp_cs";
    s.name = "sentry";
    fe [[ f ]]( s, "MERC_CAMP_Q3_BRIDGE_NORTH", cf, ( -23894, -11339.2, 827.99 ), ( 0, 158.54, 0 ), "s_merc_camp_sentry", undefined, undefined, undefined, "link_merc_camp", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_camp_cs";
    s.name = "vehicle";
    fe [[ f ]]( s, "MERC_CAMP_Q3_BRIDGE_NORTH", cf, ( -22977.7, -10756.5, 862.35 ), ( 355.67, 130.68, 0.23 ), "s_merc_camp_vehicle", undefined, undefined, undefined, "link_merc_camp", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_camp_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MERC_CAMP_Q3_BRIDGE_NORTH", cf, ( -28716.7, -11044.9, 5744.66 ), ( 359.47, 313.06, 0.49 ), "cspf_8_auto18030718683867637715", "cspf_8_auto179959079453396553", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_camp_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MERC_CAMP_Q3_BRIDGE_NORTH", cf, ( -16454.6, -13851.5, 6766.91 ), ( 0, 277.81, 0 ), "cspf_8_auto12597151576920466004", "MERC_CAMP_Q3_BRIDGE_NORTH_VTOL", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_camp_cs";
    s.name = "killstreak_support";
    fe [[ f ]]( s, "MERC_CAMP_Q3_BRIDGE_NORTH", cf, ( -23341.8, -11725.7, 810.01 ), ( 0, 94.37, 0 ), undefined, undefined, "killstreak_support", undefined, "link_merc_camp", ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_sat_avalon_quad_03_ob_activity_merc_camp_cs
// Params 3
// Checksum 0x44060c42, Offset: 0x3eab
// Size: 0x610
function function_2b3539f2e183239a( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_camp_cs";
    s.name = "center_struct";
    fe [[ f ]]( s, "MERC_CAMP_Q3_COAST_GUARD", cf, ( -36741.2, -16333.3, 326.47 ), ( 0, 0, 0 ), "MERC_CAMP_Q3_COAST_GUARD", undefined, "MERC_CAMP_Q3_COAST_GUARD", "link_merc_camp", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 1500 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_camp_cs";
    s.name = "guard";
    fe [[ f ]]( s, "MERC_CAMP_Q3_COAST_GUARD", cf, ( -36409.2, -16329.7, 326.16 ), ( 0, 0, 0 ), "s_merc_camp_guard", undefined, undefined, undefined, "link_merc_camp", ( 0, 0, 0 ), ( 0, 0, 0 ), 250 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_camp_cs";
    s.name = "loot_cache";
    fe [[ f ]]( s, "MERC_CAMP_Q3_COAST_GUARD", cf, ( -36214.4, -16246.9, 319.84 ), ( 353.16, 308.51, -0.6 ), "s_merc_camp_cache", undefined, undefined, undefined, "link_merc_camp", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_camp_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    s.script_accel = "350";
    fe [[ f ]]( s, "MERC_CAMP_Q3_COAST_GUARD", cf, ( -36917.6, -16658.9, 924.57 ), ( 0, 27.35, 0 ), "MERC_CAMP_Q3_COAST_GUARD_VTOL", "cspf_9_auto107362103839475909", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_camp_cs";
    s.name = "sentry";
    fe [[ f ]]( s, "MERC_CAMP_Q3_COAST_GUARD", cf, ( -36149.9, -16717.6, 316.07 ), ( 0, 219.08, 0 ), "s_merc_camp_sentry", undefined, undefined, undefined, "link_merc_camp", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_camp_cs";
    s.name = "sentry";
    fe [[ f ]]( s, "MERC_CAMP_Q3_COAST_GUARD", cf, ( -37107.1, -16130, 319.47 ), ( 0, 80.18, 0 ), "s_merc_camp_sentry", undefined, undefined, undefined, "link_merc_camp", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_camp_cs";
    s.name = "vehicle";
    fe [[ f ]]( s, "MERC_CAMP_Q3_COAST_GUARD", cf, ( -35854.5, -17623.7, 320 ), ( 0, 309.03, 0 ), "s_merc_camp_vehicle", undefined, undefined, undefined, "link_merc_camp", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_camp_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MERC_CAMP_Q3_COAST_GUARD", cf, ( -24392, -17757.2, 8152.16 ), ( 359.47, 146.19, 0.49 ), "cspf_9_auto14203607994286283110", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_camp_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MERC_CAMP_Q3_COAST_GUARD", cf, ( -40478.7, -30998.8, 7356.91 ), ( 0, 72.44, 0 ), undefined, "cspf_9_auto729797207751503425", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150, 1 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_camp_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MERC_CAMP_Q3_COAST_GUARD", cf, ( -31694.5, -15984.4, 5257.16 ), ( 359.47, 146.19, 0.49 ), "cspf_9_auto107362103839475909", "cspf_9_auto14203607994286283110", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_camp_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MERC_CAMP_Q3_COAST_GUARD", cf, ( -39494.3, -24720.4, 6279.41 ), ( 0, 110.93, 0 ), "cspf_9_auto729797207751503425", "MERC_CAMP_Q3_COAST_GUARD_VTOL", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_camp_cs";
    s.name = "killstreak_support";
    fe [[ f ]]( s, "MERC_CAMP_Q3_COAST_GUARD", cf, ( -36543.5, -15903.1, 331.78 ), ( 0, 0, 0 ), undefined, undefined, "killstreak_support", undefined, "link_merc_camp", ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_sat_avalon_quad_03_ob_activity_merc_camp_cs
// Params 3
// Checksum 0xf108b43a, Offset: 0x44c3
// Size: 0x610
function function_afad2fd077d21132( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_camp_cs";
    s.name = "center_struct";
    fe [[ f ]]( s, "MERC_CAMP_Q3_LISTENING_POST", cf, ( -16885.2, -42913.2, 238.26 ), ( 0, 0, 0 ), "MERC_CAMP_Q3_LISTENING_POST", undefined, "MERC_CAMP_Q3_LISTENING_POST", "link_merc_camp", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 1500 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_camp_cs";
    s.name = "guard";
    fe [[ f ]]( s, "MERC_CAMP_Q3_LISTENING_POST", cf, ( -16810, -42937.6, 230.7 ), ( 0, 0, 0 ), "s_merc_camp_guard", undefined, undefined, undefined, "link_merc_camp", ( 0, 0, 0 ), ( 0, 0, 0 ), 250 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_camp_cs";
    s.name = "loot_cache";
    fe [[ f ]]( s, "MERC_CAMP_Q3_LISTENING_POST", cf, ( -17359.6, -42823.5, 207.5 ), ( 0.35, 355.01, -0.25 ), "s_merc_camp_cache", undefined, undefined, undefined, "link_merc_camp", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_camp_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    s.script_accel = "350";
    fe [[ f ]]( s, "MERC_CAMP_Q3_LISTENING_POST", cf, ( -16314.7, -42777.7, 874.57 ), ( 0, 199.08, 0 ), "MERC_CAMP_Q3_LISTENING_POST_VTOL", "cspf_10_auto1371108184312624964", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_camp_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MERC_CAMP_Q3_LISTENING_POST", cf, ( -28715.5, -41436.2, 8441.16 ), ( 359.47, 323.61, 0.49 ), "cspf_10_auto18335863533469815961", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_camp_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MERC_CAMP_Q3_LISTENING_POST", cf, ( -12050.6, -28930.3, 7645.91 ), ( 0, 249.87, 0 ), undefined, "cspf_10_auto11612119611942230333", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150, 1 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_camp_cs";
    s.name = "sentry";
    fe [[ f ]]( s, "MERC_CAMP_Q3_LISTENING_POST", cf, ( -16874, -43158.1, 246.04 ), ( 5.68, 143.3, 0.6 ), "s_merc_camp_sentry", undefined, undefined, undefined, "link_merc_camp", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_camp_cs";
    s.name = "sentry";
    fe [[ f ]]( s, "MERC_CAMP_Q3_LISTENING_POST", cf, ( -16946.2, -42460.5, 214.21 ), ( 0, 112.63, 0 ), "s_merc_camp_sentry", undefined, undefined, undefined, "link_merc_camp", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_camp_cs";
    s.name = "vehicle";
    fe [[ f ]]( s, "MERC_CAMP_Q3_LISTENING_POST", cf, ( -16440.9, -43464.2, 277.43 ), ( 357.83, 358.69, -0.9 ), "s_merc_camp_vehicle", undefined, undefined, undefined, "link_merc_camp", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_camp_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MERC_CAMP_Q3_LISTENING_POST", cf, ( -21500, -43535.1, 5546.16 ), ( 359.47, 323.61, 0.49 ), "cspf_10_auto1371108184312624964", "cspf_10_auto18335863533469815961", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_camp_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MERC_CAMP_Q3_LISTENING_POST", cf, ( -13315.8, -35158.1, 6568.41 ), ( 0, 288.35, 0 ), "cspf_10_auto11612119611942230333", "MERC_CAMP_Q3_LISTENING_POST_VTOL", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_camp_cs";
    s.name = "killstreak_support";
    fe [[ f ]]( s, "MERC_CAMP_Q3_LISTENING_POST", cf, ( -17192.1, -42239.7, 211.91 ), ( 0, 0, 0 ), undefined, undefined, "killstreak_support", undefined, "link_merc_camp", ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_sat_avalon_quad_03_ob_activity_merc_camp_cs
// Params 3
// Checksum 0xda65442d, Offset: 0x4adb
// Size: 0x610
function function_3f83b685abd60a77( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_camp_cs";
    s.name = "center_struct";
    fe [[ f ]]( s, "MERC_CAMP_Q3_FORT_01", cf, ( -32383, -31331.9, 712.33 ), ( 0, 0, 0 ), "MERC_CAMP_Q3_FORT_01", undefined, "MERC_CAMP_Q3_FORT_01", "link_merc_camp", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 1500 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_camp_cs";
    s.name = "guard";
    fe [[ f ]]( s, "MERC_CAMP_Q3_FORT_01", cf, ( -33160.8, -31263.2, 658.62 ), ( 0, 0, 0 ), "s_merc_camp_guard", undefined, undefined, undefined, "link_merc_camp", ( 0, 0, 0 ), ( 0, 0, 0 ), 250 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_camp_cs";
    s.name = "loot_cache";
    fe [[ f ]]( s, "MERC_CAMP_Q3_FORT_01", cf, ( -33033.5, -31314.4, 651.79 ), ( 356.24, 23.88, -0.52 ), "s_merc_camp_cache", undefined, undefined, undefined, "link_merc_camp", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_camp_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    s.script_accel = "350";
    fe [[ f ]]( s, "MERC_CAMP_Q3_FORT_01", cf, ( -32514.6, -31670.8, 1283.07 ), ( 0, 265.07, 0 ), "MERC_CAMP_Q3_FORT_01_VTOL", "cspf_11_auto1004879700013364833", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_camp_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MERC_CAMP_Q3_FORT_01", cf, ( -39930.1, -41533.4, 8441.66 ), ( 359.47, 23.91, 0.49 ), "cspf_11_auto15465185827960989044", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_camp_cs";
    s.name = "vehicle";
    fe [[ f ]]( s, "MERC_CAMP_Q3_FORT_01", cf, ( -32976.3, -30241.5, 640.42 ), ( 6.65, 122.52, 0.96 ), "s_merc_camp_vehicle", undefined, undefined, undefined, "link_merc_camp", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_camp_cs";
    s.name = "sentry";
    fe [[ f ]]( s, "MERC_CAMP_Q3_FORT_01", cf, ( -32584.1, -30793.5, 690.45 ), ( 0, 235.79, 0 ), "s_merc_camp_sentry", undefined, undefined, undefined, "link_merc_camp", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_camp_cs";
    s.name = "sentry";
    fe [[ f ]]( s, "MERC_CAMP_Q3_FORT_01", cf, ( -32411.8, -31466.2, 695.34 ), ( 0, 260.42, 0 ), "s_merc_camp_sentry", undefined, undefined, undefined, "link_merc_camp", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_camp_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MERC_CAMP_Q3_FORT_01", cf, ( -38218.2, -23711.9, 7646.41 ), ( 0, 333.82, 0 ), undefined, "cspf_11_auto854626965239235254", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150, 1 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_camp_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MERC_CAMP_Q3_FORT_01", cf, ( -34531.8, -36306, 5546.66 ), ( 359.47, 23.91, 0.49 ), "cspf_11_auto1004879700013364833", "cspf_11_auto15465185827960989044", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_camp_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MERC_CAMP_Q3_FORT_01", cf, ( -35891.6, -27321.8, 6568.91 ), ( 0, 348.65, 0 ), "cspf_11_auto854626965239235254", "MERC_CAMP_Q3_FORT_01_VTOL", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_camp_cs";
    s.name = "killstreak_support";
    fe [[ f ]]( s, "MERC_CAMP_Q3_FORT_01", cf, ( -32034.1, -31785.6, 691.83 ), ( 0, 0, 0 ), undefined, undefined, "killstreak_support", undefined, "link_merc_camp", ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_sat_avalon_quad_03_ob_activity_merc_camp_cs
// Params 3
// Checksum 0xd9f58a78, Offset: 0x50f3
// Size: 0x610
function function_29b7cdced2f83d8f( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_camp_cs";
    s.name = "guard";
    fe [[ f ]]( s, "MERC_CAMP_Q3_FIRINGRANGE_GAS_STATION_01", cf, ( -23868.4, -22588.1, 964.75 ), ( 0, 0, 0 ), "s_merc_camp_guard", undefined, undefined, undefined, "link_merc_camp", ( 0, 0, 0 ), ( 0, 0, 0 ), 250 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_camp_cs";
    s.name = "loot_cache";
    fe [[ f ]]( s, "MERC_CAMP_Q3_FIRINGRANGE_GAS_STATION_01", cf, ( -24001.4, -22482.8, 963.88 ), ( 0.38, 190.38, -1.97 ), "s_merc_camp_cache", undefined, undefined, undefined, "link_merc_camp", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_camp_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    s.script_accel = "350";
    fe [[ f ]]( s, "MERC_CAMP_Q3_FIRINGRANGE_GAS_STATION_01", cf, ( -23610.3, -22881.3, 1542.07 ), ( 0, 186.63, 0 ), "MERC_CAMP_Q3_FIRINGRANGE_GAS_STATION_01_VTOL", "cspf_12_auto12383316138231953243", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_camp_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MERC_CAMP_Q3_FIRINGRANGE_GAS_STATION_01", cf, ( -35042.5, -17467.2, 8761.66 ), ( 359.47, 305.47, 0.49 ), "cspf_12_auto2508663440764463816", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_camp_cs";
    s.name = "vehicle";
    fe [[ f ]]( s, "MERC_CAMP_Q3_FIRINGRANGE_GAS_STATION_01", cf, ( -23640.7, -23929.7, 809.91 ), ( 5.02, 291.12, -2.17 ), "s_merc_camp_vehicle", undefined, undefined, undefined, "link_merc_camp", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_camp_cs";
    s.name = "sentry";
    fe [[ f ]]( s, "MERC_CAMP_Q3_FIRINGRANGE_GAS_STATION_01", cf, ( -23784.6, -23253, 900.56 ), ( 0, 190.61, 0 ), "s_merc_camp_sentry", undefined, undefined, undefined, "link_merc_camp", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_camp_cs";
    s.name = "sentry";
    fe [[ f ]]( s, "MERC_CAMP_Q3_FIRINGRANGE_GAS_STATION_01", cf, ( -24510.4, -23088, 953.45 ), ( 0, 189.33, 0 ), "s_merc_camp_sentry", undefined, undefined, undefined, "link_merc_camp", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_camp_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MERC_CAMP_Q3_FIRINGRANGE_GAS_STATION_01", cf, ( -15312.4, -10770.6, 7966.41 ), ( 0, 231.73, 0 ), undefined, "cspf_12_auto7050754895325068421", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150, 1 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_camp_cs";
    s.name = "center_struct";
    fe [[ f ]]( s, "MERC_CAMP_Q3_FIRINGRANGE_GAS_STATION_01", cf, ( -24297.7, -23039, 954.86 ), ( 0, 0, 0 ), "MERC_CAMP_Q3_FIRINGRANGE_GAS_STATION_01", undefined, "MERC_CAMP_Q3_FIRINGRANGE_GAS_STATION_01", "link_merc_camp", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 1500 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_camp_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MERC_CAMP_Q3_FIRINGRANGE_GAS_STATION_01", cf, ( -28838.9, -21708, 5866.66 ), ( 359.47, 305.47, 0.49 ), "cspf_12_auto12383316138231953243", "cspf_12_auto2508663440764463816", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_camp_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MERC_CAMP_Q3_FIRINGRANGE_GAS_STATION_01", cf, ( -18453.6, -16295.1, 6888.91 ), ( 0, 270.21, 0 ), "cspf_12_auto7050754895325068421", "MERC_CAMP_Q3_FIRINGRANGE_GAS_STATION_01_VTOL", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_camp_cs";
    s.name = "killstreak_support";
    fe [[ f ]]( s, "MERC_CAMP_Q3_FIRINGRANGE_GAS_STATION_01", cf, ( -24213.4, -23583.2, 880.77 ), ( 0, 0, 0 ), undefined, undefined, "killstreak_support", undefined, "link_merc_camp", ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_sat_avalon_quad_03_ob_activity_merc_camp_cs
// Params 3
// Checksum 0x3d568131, Offset: 0x570b
// Size: 0x610
function function_7ddfe8833136e195( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_camp_cs";
    s.name = "center_struct";
    fe [[ f ]]( s, "MERC_CAMP_Q3_BRIDGE_SOUTH_01", cf, ( -78.63, -38893.8, 758.97 ), ( 0, 0, 0 ), "MERC_CAMP_Q3_BRIDGE_SOUTH_01", undefined, "MERC_CAMP_Q3_BRIDGE_SOUTH_01", "link_merc_camp", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 1500 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_camp_cs";
    s.name = "guard";
    fe [[ f ]]( s, "MERC_CAMP_Q3_BRIDGE_SOUTH_01", cf, ( 157.8, -38294.8, 746.74 ), ( 0, 0, 0 ), "s_merc_camp_guard", undefined, undefined, undefined, "link_merc_camp", ( 0, 0, 0 ), ( 0, 0, 0 ), 250 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_camp_cs";
    s.name = "loot_cache";
    fe [[ f ]]( s, "MERC_CAMP_Q3_BRIDGE_SOUTH_01", cf, ( -1.09, -38273.5, 732.74 ), ( 1.68, 224.26, 2.53 ), "s_merc_camp_cache", undefined, undefined, undefined, "link_merc_camp", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_camp_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    s.script_accel = "350";
    fe [[ f ]]( s, "MERC_CAMP_Q3_BRIDGE_SOUTH_01", cf, ( -740.6, -38600.1, 1419.57 ), ( 0, 288.01, 0 ), "MERC_CAMP_Q3_BRIDGE_SOUTH_01_VTOL", "cspf_13_auto6611240502677447062", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_camp_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MERC_CAMP_Q3_BRIDGE_SOUTH_01", cf, ( -3748.7, -50891, 8639.16 ), ( 359.47, 46.85, 0.49 ), "cspf_13_auto16650121467741148579", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_camp_cs";
    s.name = "vehicle";
    fe [[ f ]]( s, "MERC_CAMP_Q3_BRIDGE_SOUTH_01", cf, ( -982.37, -37873.2, 667.4 ), ( 8.47, 129.29, 2.14 ), "s_merc_camp_vehicle", undefined, undefined, undefined, "link_merc_camp", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_camp_cs";
    s.name = "sentry";
    fe [[ f ]]( s, "MERC_CAMP_Q3_BRIDGE_SOUTH_01", cf, ( -226.86, -38686.1, 758.02 ), ( 0, 109.78, 0 ), "s_merc_camp_sentry", undefined, undefined, undefined, "link_merc_camp", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_camp_cs";
    s.name = "sentry";
    fe [[ f ]]( s, "MERC_CAMP_Q3_BRIDGE_SOUTH_01", cf, ( 110.77, -39000.5, 761.57 ), ( 0, 336.45, 0 ), "s_merc_camp_sentry", undefined, undefined, undefined, "link_merc_camp", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_camp_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MERC_CAMP_Q3_BRIDGE_SOUTH_01", cf, ( -14205.8, -32869.7, 7843.91 ), ( 0, 333.11, 0 ), undefined, "cspf_13_auto3810425273479801127", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150, 1 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_camp_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MERC_CAMP_Q3_BRIDGE_SOUTH_01", cf, ( -815, -43972.7, 5744.16 ), ( 359.47, 46.85, 0.49 ), "cspf_13_auto6611240502677447062", "cspf_13_auto16650121467741148579", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_camp_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MERC_CAMP_Q3_BRIDGE_SOUTH_01", cf, ( -8170.2, -34859.3, 6766.41 ), ( 0, 11.59, 0 ), "cspf_13_auto3810425273479801127", "MERC_CAMP_Q3_BRIDGE_SOUTH_01_VTOL", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_camp_cs";
    s.name = "killstreak_support";
    fe [[ f ]]( s, "MERC_CAMP_Q3_BRIDGE_SOUTH_01", cf, ( -545.55, -39050.1, 826.77 ), ( 0, 0, 0 ), undefined, undefined, "killstreak_support", undefined, "link_merc_camp", ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_sat_avalon_quad_03_ob_activity_merc_camp_cs
// Params 3
// Checksum 0x32f58f46, Offset: 0x5d23
// Size: 0x610
function function_95fbe3e32265c7dd( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_camp_cs";
    s.name = "center_struct";
    fe [[ f ]]( s, "MERC_CAMP_Q3_LOW_TOWN_01", cf, ( -3244.4, -7852.45, 804.11 ), ( 0, 0, 0 ), "MERC_CAMP_Q3_LOW_TOWN_01", undefined, "MERC_CAMP_Q3_LOW_TOWN_01", "link_merc_camp", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 1500 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_camp_cs";
    s.name = "guard";
    fe [[ f ]]( s, "MERC_CAMP_Q3_LOW_TOWN_01", cf, ( -2970.76, -8500.62, 806.75 ), ( 0, 0, 0 ), "s_merc_camp_guard", undefined, undefined, undefined, "link_merc_camp", ( 0, 0, 0 ), ( 0, 0, 0 ), 250 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_camp_cs";
    s.name = "loot_cache";
    fe [[ f ]]( s, "MERC_CAMP_Q3_LOW_TOWN_01", cf, ( -3068.81, -8383.49, 800 ), ( 0, 181.52, 0 ), "s_merc_camp_cache", undefined, undefined, undefined, "link_merc_camp", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_camp_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    s.script_accel = "350";
    fe [[ f ]]( s, "MERC_CAMP_Q3_LOW_TOWN_01", cf, ( -3538.96, -7548.09, 1411.57 ), ( 0, 323.26, 0 ), "MERC_CAMP_Q3_LOW_TOWN_01_VTOL", "cspf_14_auto5523270274628837011", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_camp_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MERC_CAMP_Q3_LOW_TOWN_01", cf, ( 2442.21, -18800.5, 9063.66 ), ( 359.47, 87.79, 0.49 ), "cspf_14_auto1609628690652295653", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_camp_cs";
    s.name = "vehicle";
    fe [[ f ]]( s, "MERC_CAMP_Q3_LOW_TOWN_01", cf, ( -2420.12, -7772.4, 802.19 ), ( 358, 359.58, 0.79 ), "s_merc_camp_vehicle", undefined, undefined, undefined, "link_merc_camp", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_camp_cs";
    s.name = "sentry";
    fe [[ f ]]( s, "MERC_CAMP_Q3_LOW_TOWN_01", cf, ( -3529.28, -8500.67, 800 ), ( 0, 20.99, 0 ), "s_merc_camp_sentry", undefined, undefined, undefined, "link_merc_camp", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_camp_cs";
    s.name = "sentry";
    fe [[ f ]]( s, "MERC_CAMP_Q3_LOW_TOWN_01", cf, ( -3204.27, -7758.65, 806.8 ), ( 0, 69.17, 0 ), "s_merc_camp_sentry", undefined, undefined, undefined, "link_merc_camp", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_camp_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MERC_CAMP_Q3_LOW_TOWN_01", cf, ( -17266, -12040.2, 8268.41 ), ( 0, 14.05, 0 ), undefined, "cspf_14_auto2967279243975089723", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150, 1 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_camp_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MERC_CAMP_Q3_LOW_TOWN_01", cf, ( 124.8, -11652.2, 6168.66 ), ( 359.47, 87.79, 0.49 ), "cspf_14_auto5523270274628837011", "cspf_14_auto1609628690652295653", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_camp_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MERC_CAMP_Q3_LOW_TOWN_01", cf, ( -11403.2, -9588.01, 7190.91 ), ( 0, 52.53, 0 ), "cspf_14_auto2967279243975089723", "MERC_CAMP_Q3_LOW_TOWN_01_VTOL", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_camp_cs";
    s.name = "killstreak_support";
    fe [[ f ]]( s, "MERC_CAMP_Q3_LOW_TOWN_01", cf, ( -2881.86, -8037.4, 800 ), ( 0, 0, 0 ), undefined, undefined, "killstreak_support", undefined, "link_merc_camp", ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_sat_avalon_quad_03_ob_activity_merc_camp_cs
// Params 0
// Checksum 0xdbed0600, Offset: 0x633b
// Size: 0x639
function function_d9dd7965c51c95d1()
{
    activityinstances = [];
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_activitydefinition_merccamp";
    var_881289d7987bc770.var_7a0840be22b9ebb = "SUPPLY_DROP_Q3_FIRINGRANGE_MIL_MESS_HALL";
    var_881289d7987bc770.cf = "mp_sat_avalon_quad_03_ob_activity_merc_camp_cs";
    var_881289d7987bc770.scriptstructorigin = ( -23392.9, -11333.5, 1148.71 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [ ( -23309.2, -11199.5, 851.36 ) ];
    var_881289d7987bc770.var_31ce4477e3543d24 = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.locationradius = [ 1350 ];
    activityinstances[ "MERC_CAMP_Q3_BRIDGE_NORTH" ] = var_881289d7987bc770;
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_activitydefinition_merccamp";
    var_881289d7987bc770.var_7a0840be22b9ebb = "SUPPLY_DROP_Q1_CAPE_MANSION";
    var_881289d7987bc770.cf = "mp_sat_avalon_quad_03_ob_activity_merc_camp_cs";
    var_881289d7987bc770.scriptstructorigin = ( -36654.1, -16298.5, 658.98 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [ ( -36611.4, -16139.9, 330.32 ) ];
    var_881289d7987bc770.var_31ce4477e3543d24 = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.locationradius = [ 1350 ];
    activityinstances[ "MERC_CAMP_Q3_COAST_GUARD" ] = var_881289d7987bc770;
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_activitydefinition_merccamp";
    var_881289d7987bc770.var_7a0840be22b9ebb = "SUPPLY_DROP_Q3_FORT_MIFORT";
    var_881289d7987bc770.cf = "mp_sat_avalon_quad_03_ob_activity_merc_camp_cs";
    var_881289d7987bc770.scriptstructorigin = ( -16916.2, -42876.2, 584.65 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [ ( -16712.6, -42886.6, 317.32 ) ];
    var_881289d7987bc770.var_31ce4477e3543d24 = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.locationradius = [ 1350 ];
    activityinstances[ "MERC_CAMP_Q3_LISTENING_POST" ] = var_881289d7987bc770;
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_activitydefinition_merccamp";
    var_881289d7987bc770.var_7a0840be22b9ebb = "SUPPLY_DROP_Q3_ISLAND_ARMORY";
    var_881289d7987bc770.cf = "mp_sat_avalon_quad_03_ob_activity_merc_camp_cs";
    var_881289d7987bc770.scriptstructorigin = ( -32757.8, -31275.3, 1062.81 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [ ( -32390.4, -31325.9, 712.33 ) ];
    var_881289d7987bc770.var_31ce4477e3543d24 = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.locationradius = [ 1350 ];
    activityinstances[ "MERC_CAMP_Q3_FORT_01" ] = var_881289d7987bc770;
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_activitydefinition_merccamp";
    var_881289d7987bc770.var_7a0840be22b9ebb = "SUPPLY_DROP_Q3_FLATS_FIRE_STATION";
    var_881289d7987bc770.cf = "mp_sat_avalon_quad_03_ob_activity_merc_camp_cs";
    var_881289d7987bc770.scriptstructorigin = ( -24379.4, -22863.2, 1305.73 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [ ( -24305.4, -23039.9, 954.86 ) ];
    var_881289d7987bc770.var_31ce4477e3543d24 = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.locationradius = [ 1350 ];
    activityinstances[ "MERC_CAMP_Q3_FIRINGRANGE_GAS_STATION_01" ] = var_881289d7987bc770;
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_activitydefinition_merccamp";
    var_881289d7987bc770.var_7a0840be22b9ebb = "SUPPLY_DROP_Q3_LISTENING_POST_RADAR";
    var_881289d7987bc770.cf = "mp_sat_avalon_quad_03_ob_activity_merc_camp_cs";
    var_881289d7987bc770.scriptstructorigin = ( 144.46, -38675, 1082.33 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [ ( -79.02, -38893.4, 758.97 ) ];
    var_881289d7987bc770.var_31ce4477e3543d24 = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.locationradius = [ 1350 ];
    activityinstances[ "MERC_CAMP_Q3_BRIDGE_SOUTH_01" ] = var_881289d7987bc770;
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_activitydefinition_merccamp";
    var_881289d7987bc770.var_7a0840be22b9ebb = "SUPPLY_DROP_Q1_HIGHTOWN_MANSIONS_01";
    var_881289d7987bc770.cf = "mp_sat_avalon_quad_03_ob_activity_merc_camp_cs";
    var_881289d7987bc770.scriptstructorigin = ( -3241.07, -7850.48, 1188.94 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [ ( -3244.59, -7856, 803.99 ) ];
    var_881289d7987bc770.var_31ce4477e3543d24 = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.locationradius = [ 1350 ];
    activityinstances[ "MERC_CAMP_Q3_LOW_TOWN_01" ] = var_881289d7987bc770;
    return activityinstances;
}

