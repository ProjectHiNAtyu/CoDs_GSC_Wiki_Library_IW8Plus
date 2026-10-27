// script_50d1fbe670b10c67  (hash_50d1fbe670b10c67.gscc) (size: 28703 Bytes / 0x701f / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x8471318c (2222010764)
// size ...... 28703 (0x701f)
// includes .. 4   (offset: 0x60bb)
// strings ... 68  (offset: 0x60db)
// dev strs .. 0   (offset: 0x701f)
// exports ... 18  (offset: 0x5a6f)
// cseg ...... 0x748 + 0x5327 (0x5a6f)
// imports ... 31  (offset: 0x5d3f)
// animtree1 . 0   (offset: 0x701f)
// animtree2 . 0   (offset: 0x701f)
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace mp_sat_avalon_q1_ob_activity_merc_camp_cs;

// Namespace mp_sat_avalon_q1_ob_activity_merc_camp_cs
// Params 0, eflags: 0x5
// Checksum 0xb4a7cf22, Offset: 0x766
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"mp_sat_avalon_q1_ob_activity_merc_camp_cs", #"activity_common", &function_b39ecd3d51489472, undefined );
}

// Namespace mp_sat_avalon_q1_ob_activity_merc_camp_cs
// Params 0, eflags: 0x4
// Checksum 0xeaaf4de6, Offset: 0x78f
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace mp_sat_avalon_q1_ob_activity_merc_camp_cs
// Params 0, eflags: 0x4
// Checksum 0x6f949e0a, Offset: 0x7a0
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace mp_sat_avalon_q1_ob_activity_merc_camp_cs
// Params 2
// Checksum 0x362d2927, Offset: 0x7b1
// Size: 0x8c
function main( unused, unused2 )
{
    if ( utility::flag_exist( "mp_sat_avalon_q1_ob_activity_merc_camp_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "mp_sat_avalon_q1_ob_activity_merc_camp_cs" ) )
    {
        return;
    }
    
    activity_common::function_e1df676808c1d1e3( &function_4cd78e661617f3 );
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "mp_sat_avalon_q1_ob_activity_merc_camp_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "mp_sat_avalon_q1_ob_activity_merc_camp_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace mp_sat_avalon_q1_ob_activity_merc_camp_cs
// Params 3, eflags: 0x4
// Checksum 0xec162ac5, Offset: 0x845
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "mp_sat_avalon_q1_ob_activity_merc_camp_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "mp_sat_avalon_q1_ob_activity_merc_camp_cs" );
}

// Namespace mp_sat_avalon_q1_ob_activity_merc_camp_cs
// Params 3, eflags: 0x4
// Checksum 0x181ac44d, Offset: 0x8bf
// Size: 0x26c2
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_merc_camp_cs";
    s.activity_bundle = "sat_activitydefinition_merccamp";
    s.name = "MERC_CAMP_Q1_GOLF_COURSE";
    s.var_7a0840be22b9ebb = "SUPPLY_DROP_Q1_MANSIONS_03";
    fe [[ f ]]( s, "MERC_CAMP_Q1_GOLF_COURSE", cf, ( -40579.1, 25654.8, 1833.75 ), ( 0, 333.36, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_merc_camp_cs";
    fe [[ f ]]( s, "MERC_CAMP_Q1_GOLF_COURSE", cf, ( -40798, 25958.4, 1502.4 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Awareness_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 4000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_merc_camp_cs";
    fe [[ f ]]( s, "MERC_CAMP_Q1_GOLF_COURSE", cf, ( -40798, 25958.4, 1494.4 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Ambient_AI_Exclusion_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 1800 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_merc_camp_cs";
    fe [[ f ]]( s, "MERC_CAMP_Q1_GOLF_COURSE", cf, ( -40798, 25958.4, 1502.4 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Cleanup_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 5000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_merc_camp_cs";
    s.groupid = "reinforcement_spawn_point";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "camp_reinforce_heli";
    s.variantname = "ai_encounter_spawnpoint";
    s.var_4501e0172e168ddf = "MERC_CAMP_Q1_GOLF_COURSE_VTOL";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "MERC_CAMP_Q1_GOLF_COURSE", cf, ( -40987.2, 25729.6, 1491.3 ), ( 0, 333.95, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_merc_camp_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "parachute_reinforce";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "MERC_CAMP_Q1_GOLF_COURSE", cf, ( -40480.7, 26142.2, 1497.99 ), ( 0, 247.85, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_merc_camp_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "parachute_reinforce";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "MERC_CAMP_Q1_GOLF_COURSE", cf, ( -40374, 26194.9, 1498.01 ), ( 0, 255.99, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_merc_camp_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "parachute_reinforce";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "MERC_CAMP_Q1_GOLF_COURSE", cf, ( -40319.6, 26075.4, 1498.03 ), ( 0, 253.74, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_merc_camp_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "parachute_reinforce";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "MERC_CAMP_Q1_GOLF_COURSE", cf, ( -40339.6, 26280.6, 1498.01 ), ( 0, 273.83, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_merc_camp_cs";
    s.activity_bundle = "sat_activitydefinition_merccamp";
    s.name = "MERC_CAMP_Q1_CASINO_01";
    s.var_7a0840be22b9ebb = "SUPPLY_DROP_Q1_POLICE_STATION";
    fe [[ f ]]( s, "MERC_CAMP_Q1_CASINO_01", cf, ( -3161.69, 24046.7, 825 ), ( 0, 333.36, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_merc_camp_cs";
    fe [[ f ]]( s, "MERC_CAMP_Q1_CASINO_01", cf, ( -3170.59, 24058, 481.75 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Awareness_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 4000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_merc_camp_cs";
    fe [[ f ]]( s, "MERC_CAMP_Q1_CASINO_01", cf, ( -3109.7, 23996.7, 464.16 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Ambient_AI_Exclusion_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 1800 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_merc_camp_cs";
    fe [[ f ]]( s, "MERC_CAMP_Q1_CASINO_01", cf, ( -3158.8, 23984.5, 475.49 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Cleanup_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 5000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_merc_camp_cs";
    s.groupid = "reinforcement_spawn_point";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "camp_reinforce_heli";
    s.variantname = "ai_encounter_spawnpoint";
    s.var_4501e0172e168ddf = "MERC_CAMP_Q1_CASINO_01_VTOL";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "MERC_CAMP_Q1_CASINO_01", cf, ( -3013.2, 24178.1, 439.3 ), ( 0, 200.38, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_merc_camp_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "parachute_reinforce";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "MERC_CAMP_Q1_CASINO_01", cf, ( -3703.88, 24798.6, 429.5 ), ( 0, 322.21, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_merc_camp_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "parachute_reinforce";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "MERC_CAMP_Q1_CASINO_01", cf, ( -3646.7, 24704.8, 433.62 ), ( 0, 322.21, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_merc_camp_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "parachute_reinforce";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "MERC_CAMP_Q1_CASINO_01", cf, ( -3510.14, 24655.2, 433.16 ), ( 0, 322.21, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_merc_camp_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "parachute_reinforce";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "MERC_CAMP_Q1_CASINO_01", cf, ( -3693.03, 24564.4, 444.83 ), ( 0, 322.21, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_merc_camp_cs";
    s.activity_bundle = "sat_activitydefinition_merccamp";
    s.name = "MERC_CAMP_Q1_SUBURBS_01";
    s.var_7a0840be22b9ebb = "SUPPLY_DROP_Q1_RIC_VILLA";
    fe [[ f ]]( s, "MERC_CAMP_Q1_SUBURBS_01", cf, ( -1363.65, 47304.5, 630.11 ), ( 0, 265.59, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_merc_camp_cs";
    fe [[ f ]]( s, "MERC_CAMP_Q1_SUBURBS_01", cf, ( -1400.82, 47608.1, 304 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Awareness_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 4000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_merc_camp_cs";
    fe [[ f ]]( s, "MERC_CAMP_Q1_SUBURBS_01", cf, ( -1420.95, 47290.5, 304 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Ambient_AI_Exclusion_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 1500 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_merc_camp_cs";
    fe [[ f ]]( s, "MERC_CAMP_Q1_SUBURBS_01", cf, ( -1376.16, 47575.1, 304 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Cleanup_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 5000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_merc_camp_cs";
    s.groupid = "reinforcement_spawn_point";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "camp_reinforce_heli";
    s.variantname = "ai_encounter_spawnpoint";
    s.var_4501e0172e168ddf = "MERC_CAMP_Q1_SUBURBS_01_VTOL";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "MERC_CAMP_Q1_SUBURBS_01", cf, ( -1185.6, 47180.7, 310.3 ), ( 0, 72.11, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_merc_camp_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "parachute_reinforce";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "MERC_CAMP_Q1_SUBURBS_01", cf, ( -1587.1, 47394.5, 311.96 ), ( 0, 355.01, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_merc_camp_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "parachute_reinforce";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "MERC_CAMP_Q1_SUBURBS_01", cf, ( -1602.71, 47238.4, 312.14 ), ( 0, 22.67, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_merc_camp_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "parachute_reinforce";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "MERC_CAMP_Q1_SUBURBS_01", cf, ( -1694.54, 47330.6, 312.7 ), ( 0, 1.66, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_merc_camp_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "parachute_reinforce";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "MERC_CAMP_Q1_SUBURBS_01", cf, ( -1833.36, 47355.5, 326.16 ), ( 0, 357.4, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_merc_camp_cs";
    s.activity_bundle = "sat_activitydefinition_merccamp";
    s.name = "MERC_CAMP_Q1_OVERLOOK_01";
    s.var_7a0840be22b9ebb = "SUPPLY_DROP_Q1_FIRE_STATION";
    fe [[ f ]]( s, "MERC_CAMP_Q1_OVERLOOK_01", cf, ( -19800.3, 33104.7, 2466.14 ), ( 0, 333.36, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_merc_camp_cs";
    fe [[ f ]]( s, "MERC_CAMP_Q1_OVERLOOK_01", cf, ( -19765.5, 33044, 2147.25 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Awareness_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 4000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_merc_camp_cs";
    fe [[ f ]]( s, "MERC_CAMP_Q1_OVERLOOK_01", cf, ( -19782.7, 33008.1, 2146.79 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Ambient_AI_Exclusion_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 1800 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_merc_camp_cs";
    fe [[ f ]]( s, "MERC_CAMP_Q1_OVERLOOK_01", cf, ( -19820.9, 33048.7, 2148.26 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Cleanup_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 5000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_merc_camp_cs";
    s.groupid = "reinforcement_spawn_point";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "camp_reinforce_heli";
    s.variantname = "ai_encounter_spawnpoint";
    s.var_4501e0172e168ddf = "MERC_CAMP_Q1_OVERLOOK_01_VTOL";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "MERC_CAMP_Q1_OVERLOOK_01", cf, ( -19120.2, 33410.9, 2138.45 ), ( 0, 227.51, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_merc_camp_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "parachute_reinforce";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "MERC_CAMP_Q1_OVERLOOK_01", cf, ( -19846.4, 33344.6, 2160.8 ), ( 0, 289.65, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_merc_camp_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "parachute_reinforce";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "MERC_CAMP_Q1_OVERLOOK_01", cf, ( -20001.5, 33205.6, 2160.6 ), ( 0, 353.01, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_merc_camp_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "parachute_reinforce";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "MERC_CAMP_Q1_OVERLOOK_01", cf, ( -19982.9, 33397.8, 2163.75 ), ( 0, 326.12, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_merc_camp_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "parachute_reinforce";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "MERC_CAMP_Q1_OVERLOOK_01", cf, ( -20080.1, 33325, 2169.41 ), ( 0, 317.1, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_merc_camp_cs";
    s.activity_bundle = "sat_activitydefinition_merccamp";
    s.name = "MERC_CAMP_Q1_STADIUM_01";
    s.var_7a0840be22b9ebb = "SUPPLY_DROP_Q1_GOLF_COURSE";
    fe [[ f ]]( s, "MERC_CAMP_Q1_STADIUM_01", cf, ( -47196.5, 8662.24, 594.93 ), ( 0, 333.36, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_merc_camp_cs";
    fe [[ f ]]( s, "MERC_CAMP_Q1_STADIUM_01", cf, ( -47224.4, 8745.17, 302.25 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Awareness_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 4000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_merc_camp_cs";
    fe [[ f ]]( s, "MERC_CAMP_Q1_STADIUM_01", cf, ( -47154.7, 8582.3, 302.25 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Ambient_AI_Exclusion_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 2000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_merc_camp_cs";
    fe [[ f ]]( s, "MERC_CAMP_Q1_STADIUM_01", cf, ( -47112.2, 8688.47, 302.25 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Cleanup_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 5000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_merc_camp_cs";
    s.groupid = "reinforcement_spawn_point";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "camp_reinforce_heli";
    s.variantname = "ai_encounter_spawnpoint";
    s.var_4501e0172e168ddf = "MERC_CAMP_Q1_STADIUM_01_VTOL";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "MERC_CAMP_Q1_STADIUM_01", cf, ( -47744, 8095.17, 264.15 ), ( 0, 72.11, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_merc_camp_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "parachute_reinforce";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "MERC_CAMP_Q1_STADIUM_01", cf, ( -46802.2, 8192.89, 262.94 ), ( 0, 159.01, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_merc_camp_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "parachute_reinforce";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "MERC_CAMP_Q1_STADIUM_01", cf, ( -46755.2, 8415.74, 263.42 ), ( 0, 205.41, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_merc_camp_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "parachute_reinforce";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "MERC_CAMP_Q1_STADIUM_01", cf, ( -46638.7, 8264.08, 263.45 ), ( 0, 161.99, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_merc_camp_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "parachute_reinforce";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "MERC_CAMP_Q1_STADIUM_01", cf, ( -46491.7, 8226, 263.65 ), ( 0, 174.96, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_merc_camp_cs";
    s.activity_bundle = "sat_activitydefinition_merccamp";
    s.name = "MERC_CAMP_Q1_HIGHTOWN_01";
    s.var_7a0840be22b9ebb = "SUPPLY_DROP_CITY_LOW_TOWN_TOWNHALL";
    fe [[ f ]]( s, "MERC_CAMP_Q1_HIGHTOWN_01", cf, ( -22320.1, 10346.6, 1613.39 ), ( 0, 333.36, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_merc_camp_cs";
    fe [[ f ]]( s, "MERC_CAMP_Q1_HIGHTOWN_01", cf, ( -22451, 9970.68, 1236.4 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Awareness_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 4000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_merc_camp_cs";
    fe [[ f ]]( s, "MERC_CAMP_Q1_HIGHTOWN_01", cf, ( -22354.9, 10266.1, 1237.18 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Ambient_AI_Exclusion_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 1200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_merc_camp_cs";
    fe [[ f ]]( s, "MERC_CAMP_Q1_HIGHTOWN_01", cf, ( -22493.5, 9949.44, 1237.41 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Cleanup_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 5000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_merc_camp_cs";
    s.groupid = "reinforcement_spawn_point";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "camp_reinforce_heli";
    s.variantname = "ai_encounter_spawnpoint";
    s.var_4501e0172e168ddf = "MERC_CAMP_Q1_HIGHTOWN_01_VTOL";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "MERC_CAMP_Q1_HIGHTOWN_01", cf, ( -22490.5, 10520.7, 1251.59 ), ( 0, 270.47, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_merc_camp_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "parachute_reinforce";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "MERC_CAMP_Q1_HIGHTOWN_01", cf, ( -22233.2, 10164.4, 1231.08 ), ( 0, 150.78, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_merc_camp_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "parachute_reinforce";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "MERC_CAMP_Q1_HIGHTOWN_01", cf, ( -22103.4, 10288.4, 1231.4 ), ( 0, 163.42, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_merc_camp_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "parachute_reinforce";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "MERC_CAMP_Q1_HIGHTOWN_01", cf, ( -22120, 10150.1, 1226.39 ), ( 0, 148, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_merc_camp_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "parachute_reinforce";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "MERC_CAMP_Q1_HIGHTOWN_01", cf, ( -22071.5, 10100.6, 1217.96 ), ( 0, 145.51, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace mp_sat_avalon_q1_ob_activity_merc_camp_cs
// Params 0, eflags: 0x4
// Checksum 0x21a99d6a, Offset: 0x2f89
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace mp_sat_avalon_q1_ob_activity_merc_camp_cs
// Params 0
// Checksum 0x2e45f788, Offset: 0x2f93
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "mp_sat_avalon_q1_ob_activity_merc_camp_cs" );
}

// Namespace mp_sat_avalon_q1_ob_activity_merc_camp_cs
// Params 0
// Checksum 0xd8f95630, Offset: 0x2fa9
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

// Namespace mp_sat_avalon_q1_ob_activity_merc_camp_cs
// Params 4
// Checksum 0x5972b921, Offset: 0x3018
// Size: 0xd9
function function_d4323822d7042e5a( var_4312b79c960726b6, fe, us, cf = "mp_sat_avalon_q1_ob_activity_merc_camp_cs" )
{
    switch ( var_4312b79c960726b6 )
    {
        case #"hash_536f4a47b71e7188":
            function_59290a9ea7678970( fe, us, cf );
            break;
        case #"hash_b06bd6b87fb2a833":
            function_b8a08df72f142cfb( fe, us, cf );
            break;
        case #"hash_ce8a9a0b8b3521b4":
            function_415ab44d1526823c( fe, us, cf );
            break;
        case #"hash_c16b79b419e408d":
            function_7653d2e8865d4395( fe, us, cf );
            break;
        case #"hash_904cc27ea8a899df":
            function_98f524c52c1605c7( fe, us, cf );
            break;
        case #"hash_be77746095d1ac12":
            function_6e07d383d029acba( fe, us, cf );
            break;
    }
}

// Namespace mp_sat_avalon_q1_ob_activity_merc_camp_cs
// Params 3
// Checksum 0x312f83b0, Offset: 0x30f9
// Size: 0x610
function function_59290a9ea7678970( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_merc_camp_cs";
    s.name = "center_struct";
    fe [[ f ]]( s, "MERC_CAMP_Q1_GOLF_COURSE", cf, ( -40900, 25920.1, 1498.48 ), ( 0, 0, 0 ), "MERC_CAMP_Q1_GOLF_COURSE", undefined, "MERC_CAMP_Q1_GOLF_COURSE", "link_merc_camp", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 1500 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_merc_camp_cs";
    s.name = "guard";
    fe [[ f ]]( s, "MERC_CAMP_Q1_GOLF_COURSE", cf, ( -40944.3, 25930.2, 1498.17 ), ( 0, 0, 0 ), "s_merc_camp_guard", undefined, undefined, undefined, "link_merc_camp", ( 0, 0, 0 ), ( 0, 0, 0 ), 250 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_merc_camp_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    s.script_accel = "350";
    fe [[ f ]]( s, "MERC_CAMP_Q1_GOLF_COURSE", cf, ( -40902.1, 25766.7, 2108.94 ), ( 0, 298.92, 0 ), "MERC_CAMP_Q1_GOLF_COURSE_VTOL", "cspf_7_auto10027684407556860459", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_merc_camp_cs";
    s.name = "sentry";
    fe [[ f ]]( s, "MERC_CAMP_Q1_GOLF_COURSE", cf, ( -40249.1, 25991.7, 1506.22 ), ( 0, 116.34, 0 ), "s_merc_camp_sentry", undefined, undefined, undefined, "link_merc_camp", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_merc_camp_cs";
    s.name = "sentry";
    fe [[ f ]]( s, "MERC_CAMP_Q1_GOLF_COURSE", cf, ( -41488.4, 25670.8, 1490.44 ), ( 0, 80.18, 0 ), "s_merc_camp_sentry", undefined, undefined, undefined, "link_merc_camp", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_merc_camp_cs";
    s.name = "vehicle";
    fe [[ f ]]( s, "MERC_CAMP_Q1_GOLF_COURSE", cf, ( -41986.6, 25865.2, 1486.89 ), ( 0.49, 160.26, 1.75 ), "s_merc_camp_vehicle", undefined, undefined, undefined, "link_merc_camp", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_merc_camp_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MERC_CAMP_Q1_GOLF_COURSE", cf, ( -30348.2, 9018.21, 10107.5 ), ( 359.47, 229.72, 0.5 ), "cspf_7_auto1569727771163766061", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_merc_camp_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MERC_CAMP_Q1_GOLF_COURSE", cf, ( -40408.4, 41482.1, 8537.27 ), ( 0, 281.34, 0 ), undefined, "cspf_7_auto7185240539170447266", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150, 1 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_merc_camp_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MERC_CAMP_Q1_GOLF_COURSE", cf, ( -37221.8, 21235.6, 6437.52 ), ( 359.47, 229.72, 0.5 ), "cspf_7_auto10027684407556860459", "cspf_7_auto1569727771163766061", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_merc_camp_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MERC_CAMP_Q1_GOLF_COURSE", cf, ( -40148.1, 35031.7, 7459.77 ), ( 0, 194.46, 0 ), "cspf_7_auto7185240539170447266", "MERC_CAMP_Q1_GOLF_COURSE_VTOL", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_merc_camp_cs";
    s.name = "loot_cache";
    fe [[ f ]]( s, "MERC_CAMP_Q1_GOLF_COURSE", cf, ( -40900.1, 25863.2, 1487.8 ), ( 0, 257.54, 0 ), "s_merc_camp_cache", undefined, undefined, undefined, "link_merc_camp", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_merc_camp_cs";
    s.name = "killstreak_support";
    fe [[ f ]]( s, "MERC_CAMP_Q1_GOLF_COURSE", cf, ( -40667.5, 25665.6, 1490.34 ), ( 0, 0, 0 ), undefined, undefined, "killstreak_support", undefined, "link_merc_camp", ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_sat_avalon_q1_ob_activity_merc_camp_cs
// Params 3
// Checksum 0xfa31bd60, Offset: 0x3711
// Size: 0x610
function function_b8a08df72f142cfb( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_merc_camp_cs";
    s.name = "center_struct";
    fe [[ f ]]( s, "MERC_CAMP_Q1_CASINO_01", cf, ( -3127.92, 24049.9, 462.32 ), ( 0, 0, 0 ), "MERC_CAMP_Q1_CASINO_01", undefined, "MERC_CAMP_Q1_CASINO_01", "link_merc_camp", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 1500 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_merc_camp_cs";
    s.name = "guard";
    fe [[ f ]]( s, "MERC_CAMP_Q1_CASINO_01", cf, ( -3245.22, 24641.9, 437.89 ), ( 0, 0, 0 ), "s_merc_camp_guard", undefined, undefined, undefined, "link_merc_camp", ( 0, 0, 0 ), ( 0, 0, 0 ), 250 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_merc_camp_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    s.script_accel = "350";
    fe [[ f ]]( s, "MERC_CAMP_Q1_CASINO_01", cf, ( -2928.15, 24215.2, 1056.94 ), ( 0, 298.92, 0 ), "MERC_CAMP_Q1_CASINO_01_VTOL", "cspf_8_auto17937178258591672635", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_merc_camp_cs";
    s.name = "sentry";
    fe [[ f ]]( s, "MERC_CAMP_Q1_CASINO_01", cf, ( -2966.58, 23764.8, 467.4 ), ( 0, 155.95, 0 ), "s_merc_camp_sentry", undefined, undefined, undefined, "link_merc_camp", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_merc_camp_cs";
    s.name = "sentry";
    fe [[ f ]]( s, "MERC_CAMP_Q1_CASINO_01", cf, ( -3012.73, 24356.9, 438 ), ( 0, 266.67, 0 ), "s_merc_camp_sentry", undefined, undefined, undefined, "link_merc_camp", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_merc_camp_cs";
    s.name = "vehicle";
    fe [[ f ]]( s, "MERC_CAMP_Q1_CASINO_01", cf, ( -3997.74, 23484.8, 545.94 ), ( 0.49, 207.28, 1.75 ), "s_merc_camp_vehicle", undefined, undefined, undefined, "link_merc_camp", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_merc_camp_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MERC_CAMP_Q1_CASINO_01", cf, ( 7637.77, 7533.21, 9055.5 ), ( 359.47, 229.72, 0.5 ), "cspf_8_auto16754152219778768845", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_merc_camp_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MERC_CAMP_Q1_CASINO_01", cf, ( -2422.4, 39997.1, 7485.27 ), ( 0, 281.34, 0 ), undefined, "cspf_8_auto5505422419371868505", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150, 1 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_merc_camp_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MERC_CAMP_Q1_CASINO_01", cf, ( 764.18, 19750.6, 5385.52 ), ( 359.47, 229.72, 0.5 ), "cspf_8_auto17937178258591672635", "cspf_8_auto16754152219778768845", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_merc_camp_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MERC_CAMP_Q1_CASINO_01", cf, ( -2162.06, 33546.7, 6407.77 ), ( 0, 194.46, 0 ), "cspf_8_auto5505422419371868505", "MERC_CAMP_Q1_CASINO_01_VTOL", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_merc_camp_cs";
    s.name = "loot_cache";
    fe [[ f ]]( s, "MERC_CAMP_Q1_CASINO_01", cf, ( -3404.27, 24696, 432.98 ), ( 356.23, 215.11, 1.53 ), "s_merc_camp_cache", undefined, undefined, undefined, "link_merc_camp", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_merc_camp_cs";
    s.name = "killstreak_support";
    fe [[ f ]]( s, "MERC_CAMP_Q1_CASINO_01", cf, ( -2723.79, 24223.8, 412.12 ), ( 0, 0, 0 ), undefined, undefined, "killstreak_support", undefined, "link_merc_camp", ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_sat_avalon_q1_ob_activity_merc_camp_cs
// Params 3
// Checksum 0x2468c1b1, Offset: 0x3d29
// Size: 0x610
function function_415ab44d1526823c( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_merc_camp_cs";
    s.name = "center_struct";
    fe [[ f ]]( s, "MERC_CAMP_Q1_SUBURBS_01", cf, ( -1368.62, 47600.1, 304 ), ( 0, 0, 0 ), "MERC_CAMP_Q1_SUBURBS_01", undefined, "MERC_CAMP_Q1_SUBURBS_01", "link_merc_camp", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 1500 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_merc_camp_cs";
    s.name = "guard";
    fe [[ f ]]( s, "MERC_CAMP_Q1_SUBURBS_01", cf, ( -1351.96, 47617.2, 307.29 ), ( 0, 0, 0 ), "s_merc_camp_guard", undefined, undefined, undefined, "link_merc_camp", ( 0, 0, 0 ), ( 0, 0, 0 ), 250 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_merc_camp_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    s.script_accel = "350";
    fe [[ f ]]( s, "MERC_CAMP_Q1_SUBURBS_01", cf, ( -1486.75, 47203.8, 946.94 ), ( 0, 28.52, 0 ), "MERC_CAMP_Q1_SUBURBS_01_VTOL", "cspf_9_auto14949701764543324893", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_merc_camp_cs";
    s.name = "sentry";
    fe [[ f ]]( s, "MERC_CAMP_Q1_SUBURBS_01", cf, ( -1614.87, 47095.7, 309.62 ), ( 0, 119.35, 0 ), "s_merc_camp_sentry", undefined, undefined, undefined, "link_merc_camp", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_merc_camp_cs";
    s.name = "sentry";
    fe [[ f ]]( s, "MERC_CAMP_Q1_SUBURBS_01", cf, ( -908.9, 47428.2, 303.55 ), ( 0, 304.64, 0 ), "s_merc_camp_sentry", undefined, undefined, undefined, "link_merc_camp", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_merc_camp_cs";
    s.name = "vehicle";
    fe [[ f ]]( s, "MERC_CAMP_Q1_SUBURBS_01", cf, ( -2249.75, 47145.4, 321.86 ), ( 0.49, 182.61, 1.75 ), "s_merc_camp_vehicle", undefined, undefined, undefined, "link_merc_camp", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_merc_camp_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MERC_CAMP_Q1_SUBURBS_01", cf, ( 14811.6, 45868.7, 8945.5 ), ( 359.47, 184.51, 0.49 ), "cspf_9_auto4940987069906933389", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_merc_camp_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MERC_CAMP_Q1_SUBURBS_01", cf, ( -16405.3, 35597.8, 11750.3 ), ( 0, 31.48, 0 ), undefined, "cspf_9_auto8600268606316819620", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150, 1 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_merc_camp_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MERC_CAMP_Q1_SUBURBS_01", cf, ( 5041.2, 50718.8, 5275.52 ), ( 359.47, 184.51, 0.49 ), "cspf_9_auto14949701764543324893", "cspf_9_auto4940987069906933389", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_merc_camp_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MERC_CAMP_Q1_SUBURBS_01", cf, ( -6141, 43376.2, 6297.77 ), ( 0, 14.64, 0 ), "cspf_9_auto8600268606316819620", "MERC_CAMP_Q1_SUBURBS_01_VTOL", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_merc_camp_cs";
    s.name = "loot_cache";
    fe [[ f ]]( s, "MERC_CAMP_Q1_SUBURBS_01", cf, ( -1499.47, 47521.5, 308.13 ), ( 0, 264.34, 0 ), "s_merc_camp_cache", undefined, undefined, undefined, "link_merc_camp", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_merc_camp_cs";
    s.name = "killstreak_support";
    fe [[ f ]]( s, "MERC_CAMP_Q1_SUBURBS_01", cf, ( -1673.83, 47357.7, 312.94 ), ( 0, 0, 0 ), undefined, undefined, "killstreak_support", undefined, "link_merc_camp", ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_sat_avalon_q1_ob_activity_merc_camp_cs
// Params 3
// Checksum 0xdccf2726, Offset: 0x4341
// Size: 0x610
function function_7653d2e8865d4395( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_merc_camp_cs";
    s.name = "center_struct";
    fe [[ f ]]( s, "MERC_CAMP_Q1_OVERLOOK_01", cf, ( -19752.2, 33087.6, 2149.59 ), ( 0, 0, 0 ), "MERC_CAMP_Q1_OVERLOOK_01", undefined, "MERC_CAMP_Q1_OVERLOOK_01", "link_merc_camp", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 1500 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_merc_camp_cs";
    s.name = "guard";
    fe [[ f ]]( s, "MERC_CAMP_Q1_OVERLOOK_01", cf, ( -19204.5, 32831.1, 2149.49 ), ( 0, 0, 0 ), "s_merc_camp_guard", undefined, undefined, undefined, "link_merc_camp", ( 0, 0, 0 ), ( 0, 0, 0 ), 250 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_merc_camp_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    s.script_accel = "350";
    fe [[ f ]]( s, "MERC_CAMP_Q1_OVERLOOK_01", cf, ( -19065, 33424.3, 2782.94 ), ( 0, 192.48, 0 ), "MERC_CAMP_Q1_OVERLOOK_01_VTOL", "cspf_10_auto16141937021915089952", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_merc_camp_cs";
    s.name = "sentry";
    fe [[ f ]]( s, "MERC_CAMP_Q1_OVERLOOK_01", cf, ( -19777.7, 32973, 2146.06 ), ( 0, 261.66, 0 ), "s_merc_camp_sentry", undefined, undefined, undefined, "link_merc_camp", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_merc_camp_cs";
    s.name = "sentry";
    fe [[ f ]]( s, "MERC_CAMP_Q1_OVERLOOK_01", cf, ( -19651.9, 33085.5, 2147.5 ), ( 0, 28.04, 0 ), "s_merc_camp_sentry", undefined, undefined, undefined, "link_merc_camp", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_merc_camp_cs";
    s.name = "vehicle";
    fe [[ f ]]( s, "MERC_CAMP_Q1_OVERLOOK_01", cf, ( -20597, 33590.4, 2181.79 ), ( 0.49, 124.77, 1.75 ), "s_merc_camp_vehicle", undefined, undefined, undefined, "link_merc_camp", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_merc_camp_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MERC_CAMP_Q1_OVERLOOK_01", cf, ( -33701.5, 39653.9, 10781.5 ), ( 359.47, 339.92, 0.49 ), "cspf_10_auto8628393994123888287", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_merc_camp_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MERC_CAMP_Q1_OVERLOOK_01", cf, ( -7349.2, 36289.5, 9211.27 ), ( 0, 218.38, 0 ), undefined, "cspf_10_auto9648719757930711672", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150, 1 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_merc_camp_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MERC_CAMP_Q1_OVERLOOK_01", cf, ( -26065.4, 30935.8, 7111.52 ), ( 359.47, 339.92, 0.49 ), "cspf_10_auto16141937021915089952", "cspf_10_auto8628393994123888287", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_merc_camp_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MERC_CAMP_Q1_OVERLOOK_01", cf, ( -12656.9, 35233.7, 8133.77 ), ( 0, 170.05, 0 ), "cspf_10_auto9648719757930711672", "MERC_CAMP_Q1_OVERLOOK_01_VTOL", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_merc_camp_cs";
    s.name = "loot_cache";
    fe [[ f ]]( s, "MERC_CAMP_Q1_OVERLOOK_01", cf, ( -19188.5, 32987, 2148.31 ), ( 0, 136.88, 0 ), "s_merc_camp_cache", undefined, undefined, undefined, "link_merc_camp", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_merc_camp_cs";
    s.name = "killstreak_support";
    fe [[ f ]]( s, "MERC_CAMP_Q1_OVERLOOK_01", cf, ( -19718.2, 32718.9, 2142.4 ), ( 0, 0, 0 ), undefined, undefined, "killstreak_support", undefined, "link_merc_camp", ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_sat_avalon_q1_ob_activity_merc_camp_cs
// Params 3
// Checksum 0x88835f2d, Offset: 0x4959
// Size: 0x610
function function_98f524c52c1605c7( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_merc_camp_cs";
    s.name = "center_struct";
    fe [[ f ]]( s, "MERC_CAMP_Q1_STADIUM_01", cf, ( -47174.7, 8668.73, 263.96 ), ( 0, 0, 0 ), "MERC_CAMP_Q1_STADIUM_01", undefined, "MERC_CAMP_Q1_STADIUM_01", "link_merc_camp", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 1700 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_merc_camp_cs";
    s.name = "guard";
    fe [[ f ]]( s, "MERC_CAMP_Q1_STADIUM_01", cf, ( -47612.9, 8829.35, 264.04 ), ( 0, 0, 0 ), "s_merc_camp_guard", undefined, undefined, undefined, "link_merc_camp", ( 0, 0, 0 ), ( 0, 0, 0 ), 250 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_merc_camp_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    s.script_accel = "350";
    fe [[ f ]]( s, "MERC_CAMP_Q1_STADIUM_01", cf, ( -47748.5, 8159.74, 926.44 ), ( 0, 67.06, 0 ), "MERC_CAMP_Q1_STADIUM_01_VTOL", "cspf_11_auto4469642826169550324", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_merc_camp_cs";
    s.name = "sentry";
    fe [[ f ]]( s, "MERC_CAMP_Q1_STADIUM_01", cf, ( -47008.5, 8420.35, 266.25 ), ( 355.6, 308.64, -0.39 ), "s_merc_camp_sentry", undefined, undefined, undefined, "link_merc_camp", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_merc_camp_cs";
    s.name = "sentry";
    fe [[ f ]]( s, "MERC_CAMP_Q1_STADIUM_01", cf, ( -47567.6, 9349.81, 263.2 ), ( 0, 353.61, 0 ), "s_merc_camp_sentry", undefined, undefined, undefined, "link_merc_camp", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_merc_camp_cs";
    s.name = "vehicle";
    fe [[ f ]]( s, "MERC_CAMP_Q1_STADIUM_01", cf, ( -47665.3, 10234.7, 262.81 ), ( 0.49, 90.37, 1.75 ), "s_merc_camp_vehicle", undefined, undefined, undefined, "link_merc_camp", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_merc_camp_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MERC_CAMP_Q1_STADIUM_01", cf, ( -31827.9, 6830.23, 8925 ), ( 359.47, 184.51, 0.49 ), "cspf_11_auto14586176102580249255", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_merc_camp_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MERC_CAMP_Q1_STADIUM_01", cf, ( -57120.8, 1059.75, 7354.77 ), ( 0, 73.45, 0 ), undefined, "cspf_11_auto12562869143608753952", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150, 1 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_merc_camp_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MERC_CAMP_Q1_STADIUM_01", cf, ( -41598.3, 11680.3, 5255.02 ), ( 359.47, 184.51, 0.49 ), "cspf_11_auto4469642826169550324", "cspf_11_auto14586176102580249255", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_merc_camp_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MERC_CAMP_Q1_STADIUM_01", cf, ( -52790.5, 3724.21, 6277.27 ), ( 0, 14.64, 0 ), "cspf_11_auto12562869143608753952", "MERC_CAMP_Q1_STADIUM_01_VTOL", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_merc_camp_cs";
    s.name = "loot_cache";
    fe [[ f ]]( s, "MERC_CAMP_Q1_STADIUM_01", cf, ( -47567.6, 8670.45, 264 ), ( 0, 344.42, 0 ), "s_merc_camp_cache", undefined, undefined, undefined, "link_merc_camp", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_merc_camp_cs";
    s.name = "killstreak_support";
    fe [[ f ]]( s, "MERC_CAMP_Q1_STADIUM_01", cf, ( -46681.7, 8816.51, 263.11 ), ( 0, 0, 0 ), undefined, undefined, "killstreak_support", undefined, "link_merc_camp", ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_sat_avalon_q1_ob_activity_merc_camp_cs
// Params 3
// Checksum 0x7e23d4e0, Offset: 0x4f71
// Size: 0x59c
function function_6e07d383d029acba( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_merc_camp_cs";
    s.name = "center_struct";
    fe [[ f ]]( s, "MERC_CAMP_Q1_HIGHTOWN_01", cf, ( -22497, 10005.2, 1237.15 ), ( 0, 0, 0 ), "MERC_CAMP_Q1_HIGHTOWN_01", undefined, "MERC_CAMP_Q1_HIGHTOWN_01", "link_merc_camp", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 1500 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_merc_camp_cs";
    s.name = "guard";
    fe [[ f ]]( s, "MERC_CAMP_Q1_HIGHTOWN_01", cf, ( -22457, 10058, 1237.23 ), ( 0, 0, 0 ), "s_merc_camp_guard", undefined, undefined, undefined, "link_merc_camp", ( 0, 0, 0 ), ( 0, 0, 0 ), 250 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_merc_camp_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    s.script_accel = "350";
    fe [[ f ]]( s, "MERC_CAMP_Q1_HIGHTOWN_01", cf, ( -22392.9, 10499.6, 1867.44 ), ( 0, 235.44, 0 ), "MERC_CAMP_Q1_HIGHTOWN_01_VTOL", "cspf_12_auto7991649110164775046", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_merc_camp_cs";
    s.name = "sentry";
    fe [[ f ]]( s, "MERC_CAMP_Q1_HIGHTOWN_01", cf, ( -22160.7, 10423.7, 1236.93 ), ( 0, 247.22, 0 ), "s_merc_camp_sentry", undefined, undefined, undefined, "link_merc_camp", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_merc_camp_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MERC_CAMP_Q1_HIGHTOWN_01", cf, ( -32683.6, -6486.13, 9866 ), ( 359.47, 166.24, 0.5 ), "cspf_12_auto6225427833171470542", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_merc_camp_cs";
    s.name = "vehicle";
    fe [[ f ]]( s, "MERC_CAMP_Q1_HIGHTOWN_01", cf, ( -22694.1, 11055.2, 1293.54 ), ( 0.49, 130.52, 1.75 ), "s_merc_camp_vehicle", undefined, undefined, undefined, "link_merc_camp", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_merc_camp_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MERC_CAMP_Q1_HIGHTOWN_01", cf, ( -8126.34, 17009.7, 8295.77 ), ( 0, 217.86, 0 ), undefined, "cspf_12_auto7851772217759543470", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150, 1 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_merc_camp_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MERC_CAMP_Q1_HIGHTOWN_01", cf, ( -24820.2, 5119, 6196.02 ), ( 359.47, 166.24, 0.5 ), "cspf_12_auto7991649110164775046", "cspf_12_auto6225427833171470542", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_merc_camp_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MERC_CAMP_Q1_HIGHTOWN_01", cf, ( -13782, 13896.9, 7218.27 ), ( 0, 130.98, 0 ), "cspf_12_auto7851772217759543470", "MERC_CAMP_Q1_HIGHTOWN_01_VTOL", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_merc_camp_cs";
    s.name = "loot_cache";
    fe [[ f ]]( s, "MERC_CAMP_Q1_HIGHTOWN_01", cf, ( -22294.1, 10044.6, 1231.8 ), ( 0, 44.27, 0 ), "s_merc_camp_cache", undefined, undefined, undefined, "link_merc_camp", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_merc_camp_cs";
    s.name = "killstreak_support";
    fe [[ f ]]( s, "MERC_CAMP_Q1_HIGHTOWN_01", cf, ( -22050.6, 10257.8, 1232.03 ), ( 0, 0, 0 ), undefined, undefined, "killstreak_support", undefined, "link_merc_camp", ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_sat_avalon_q1_ob_activity_merc_camp_cs
// Params 0
// Checksum 0x4eaf53ab, Offset: 0x5515
// Size: 0x559
function function_d9dd7965c51c95d1()
{
    activityinstances = [];
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_activitydefinition_merccamp";
    var_881289d7987bc770.var_7a0840be22b9ebb = "SUPPLY_DROP_Q1_MANSIONS_03";
    var_881289d7987bc770.cf = "mp_sat_avalon_q1_ob_activity_merc_camp_cs";
    var_881289d7987bc770.scriptstructorigin = ( -40579.1, 25654.8, 1833.75 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [ ( -40816.7, 25897.8, 1512.77 ) ];
    var_881289d7987bc770.var_31ce4477e3543d24 = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.locationradius = [ 1350 ];
    activityinstances[ "MERC_CAMP_Q1_GOLF_COURSE" ] = var_881289d7987bc770;
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_activitydefinition_merccamp";
    var_881289d7987bc770.var_7a0840be22b9ebb = "SUPPLY_DROP_Q1_POLICE_STATION";
    var_881289d7987bc770.cf = "mp_sat_avalon_q1_ob_activity_merc_camp_cs";
    var_881289d7987bc770.scriptstructorigin = ( -3161.69, 24046.7, 825 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [ ( -3137.66, 24026.1, 476.03 ) ];
    var_881289d7987bc770.var_31ce4477e3543d24 = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.locationradius = [ 1350 ];
    activityinstances[ "MERC_CAMP_Q1_CASINO_01" ] = var_881289d7987bc770;
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_activitydefinition_merccamp";
    var_881289d7987bc770.var_7a0840be22b9ebb = "SUPPLY_DROP_Q1_RIC_VILLA";
    var_881289d7987bc770.cf = "mp_sat_avalon_q1_ob_activity_merc_camp_cs";
    var_881289d7987bc770.scriptstructorigin = ( -1363.65, 47304.5, 630.11 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [ ( -1367.24, 47603.4, 310.25 ) ];
    var_881289d7987bc770.var_31ce4477e3543d24 = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.locationradius = [ 1350 ];
    activityinstances[ "MERC_CAMP_Q1_SUBURBS_01" ] = var_881289d7987bc770;
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_activitydefinition_merccamp";
    var_881289d7987bc770.var_7a0840be22b9ebb = "SUPPLY_DROP_Q1_FIRE_STATION";
    var_881289d7987bc770.cf = "mp_sat_avalon_q1_ob_activity_merc_camp_cs";
    var_881289d7987bc770.scriptstructorigin = ( -19800.3, 33104.7, 2466.14 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [ ( -19798.5, 33045.3, 2147.8 ) ];
    var_881289d7987bc770.var_31ce4477e3543d24 = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.locationradius = [ 1350 ];
    activityinstances[ "MERC_CAMP_Q1_OVERLOOK_01" ] = var_881289d7987bc770;
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_activitydefinition_merccamp";
    var_881289d7987bc770.var_7a0840be22b9ebb = "SUPPLY_DROP_Q1_GOLF_COURSE";
    var_881289d7987bc770.cf = "mp_sat_avalon_q1_ob_activity_merc_camp_cs";
    var_881289d7987bc770.scriptstructorigin = ( -47196.5, 8662.24, 594.93 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [ ( -47210, 8685.91, 263.96 ) ];
    var_881289d7987bc770.var_31ce4477e3543d24 = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.locationradius = [ 1350 ];
    activityinstances[ "MERC_CAMP_Q1_STADIUM_01" ] = var_881289d7987bc770;
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_activitydefinition_merccamp";
    var_881289d7987bc770.var_7a0840be22b9ebb = "SUPPLY_DROP_CITY_LOW_TOWN_TOWNHALL";
    var_881289d7987bc770.cf = "mp_sat_avalon_q1_ob_activity_merc_camp_cs";
    var_881289d7987bc770.scriptstructorigin = ( -22320.1, 10346.6, 1613.39 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [ ( -22473.2, 9984.9, 1236.74 ) ];
    var_881289d7987bc770.var_31ce4477e3543d24 = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.locationradius = [ 1350 ];
    activityinstances[ "MERC_CAMP_Q1_HIGHTOWN_01" ] = var_881289d7987bc770;
    return activityinstances;
}

