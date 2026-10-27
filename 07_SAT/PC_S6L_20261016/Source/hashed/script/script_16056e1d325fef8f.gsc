// script_16056e1d325fef8f  (hash_16056e1d325fef8f.gscc) (size: 29095 Bytes / 0x71a7 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x772cccf2 (1999424754)
// size ...... 29095 (0x71a7)
// includes .. 4   (offset: 0x620b)
// strings ... 70  (offset: 0x622b)
// dev strs .. 0   (offset: 0x71a7)
// exports ... 18  (offset: 0x5bbf)
// cseg ...... 0x7b0 + 0x540f (0x5bbf)
// imports ... 31  (offset: 0x5e8f)
// animtree1 . 0   (offset: 0x71a7)
// animtree2 . 0   (offset: 0x71a7)
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace mp_sat_avalon_q4_ob_activity_merc_camp_cs;

// Namespace mp_sat_avalon_q4_ob_activity_merc_camp_cs
// Params 0, eflags: 0x5
// Checksum 0x522a3bb, Offset: 0x7ce
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"mp_sat_avalon_q4_ob_activity_merc_camp_cs", #"activity_common", &function_b39ecd3d51489472, undefined );
}

// Namespace mp_sat_avalon_q4_ob_activity_merc_camp_cs
// Params 0, eflags: 0x4
// Checksum 0x7f7aa46, Offset: 0x7f7
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace mp_sat_avalon_q4_ob_activity_merc_camp_cs
// Params 0, eflags: 0x4
// Checksum 0x82cc79aa, Offset: 0x808
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace mp_sat_avalon_q4_ob_activity_merc_camp_cs
// Params 2
// Checksum 0x16fcfece, Offset: 0x819
// Size: 0x8c
function main( unused, unused2 )
{
    if ( utility::flag_exist( "mp_sat_avalon_q4_ob_activity_merc_camp_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "mp_sat_avalon_q4_ob_activity_merc_camp_cs" ) )
    {
        return;
    }
    
    activity_common::function_e1df676808c1d1e3( &function_4cd78e661617f3 );
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "mp_sat_avalon_q4_ob_activity_merc_camp_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "mp_sat_avalon_q4_ob_activity_merc_camp_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace mp_sat_avalon_q4_ob_activity_merc_camp_cs
// Params 3, eflags: 0x4
// Checksum 0x14ecd65, Offset: 0x8ad
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "mp_sat_avalon_q4_ob_activity_merc_camp_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "mp_sat_avalon_q4_ob_activity_merc_camp_cs" );
}

// Namespace mp_sat_avalon_q4_ob_activity_merc_camp_cs
// Params 3, eflags: 0x4
// Checksum 0x710cc6c4, Offset: 0x927
// Size: 0x26c2
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_camp_cs";
    s.activity_bundle = "sat_activitydefinition_merccamp";
    s.name = "MERC_CAMP_Q4_HELIPORT_01";
    s.var_7a0840be22b9ebb = "SUPPLY_DROP_CITY_LOW_TOWN_FIRESTATION";
    fe [[ f ]]( s, "MERC_CAMP_Q4_HELIPORT_01", cf, ( 25683.4, -18716.6, 698.75 ), ( 0, 19.86, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_camp_cs";
    fe [[ f ]]( s, "MERC_CAMP_Q4_HELIPORT_01", cf, ( 25264.2, -19045.3, 273 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Awareness_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 4000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_camp_cs";
    fe [[ f ]]( s, "MERC_CAMP_Q4_HELIPORT_01", cf, ( 25736.3, -18775, 273 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Ambient_AI_Exclusion_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 1500 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_camp_cs";
    fe [[ f ]]( s, "MERC_CAMP_Q4_HELIPORT_01", cf, ( 25284.2, -19003.8, 273 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Cleanup_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 5000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_camp_cs";
    s.groupid = "reinforcement_spawn_point";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "camp_reinforce_heli";
    s.variantname = "ai_encounter_spawnpoint";
    s.var_4501e0172e168ddf = "MERC_CAMP_Q4_HELIPORT_01_VTOL";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "MERC_CAMP_Q4_HELIPORT_01", cf, ( 25630.8, -18837.7, 269.85 ), ( 0, 64.06, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_camp_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "parachute_reinforce";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "MERC_CAMP_Q4_HELIPORT_01", cf, ( 25898, -18712.8, 268 ), ( 0, 208.7, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_camp_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "parachute_reinforce";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "MERC_CAMP_Q4_HELIPORT_01", cf, ( 26016.4, -18792.6, 268 ), ( 0, 243.22, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_camp_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "parachute_reinforce";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "MERC_CAMP_Q4_HELIPORT_01", cf, ( 25918.7, -18582.6, 268 ), ( 0, 191.39, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_camp_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "parachute_reinforce";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "MERC_CAMP_Q4_HELIPORT_01", cf, ( 26033.2, -18650.7, 268 ), ( 0, 202.85, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_camp_cs";
    s.activity_bundle = "sat_activitydefinition_merccamp";
    s.name = "MERC_CAMP_Q4_FLATS_01";
    s.var_7a0840be22b9ebb = "SUPPLY_DROP_Q4_MOUNTAIN_RANGE_MAIN_OFFICE";
    fe [[ f ]]( s, "MERC_CAMP_Q4_FLATS_01", cf, ( 6108.54, -21583.6, 1379.86 ), ( 0, 259.45, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_camp_cs";
    fe [[ f ]]( s, "MERC_CAMP_Q4_FLATS_01", cf, ( 6231.52, -21477.7, 972.86 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Awareness_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 4000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_camp_cs";
    fe [[ f ]]( s, "MERC_CAMP_Q4_FLATS_01", cf, ( 6310.7, -21539.5, 972.86 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Ambient_AI_Exclusion_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 1800 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_camp_cs";
    fe [[ f ]]( s, "MERC_CAMP_Q4_FLATS_01", cf, ( 6256.48, -21515.7, 972.86 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Cleanup_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 5000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_camp_cs";
    s.groupid = "reinforcement_spawn_point";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "camp_reinforce_heli";
    s.variantname = "ai_encounter_spawnpoint";
    s.var_4501e0172e168ddf = "MERC_CAMP_Q4_FLATS_01_VTOL";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "MERC_CAMP_Q4_FLATS_01", cf, ( 5839.28, -21677.6, 961.35 ), ( 0, 308.7, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_camp_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "parachute_reinforce";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "MERC_CAMP_Q4_FLATS_01", cf, ( 5776.42, -21754.3, 961.49 ), ( 0, 33.92, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_camp_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "parachute_reinforce";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "MERC_CAMP_Q4_FLATS_01", cf, ( 5901.51, -21553.7, 960.83 ), ( 0, 14.1, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_camp_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "parachute_reinforce";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "MERC_CAMP_Q4_FLATS_01", cf, ( 5950.68, -21691.3, 961.61 ), ( 0, 7.58, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_camp_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "parachute_reinforce";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "MERC_CAMP_Q4_FLATS_01", cf, ( 5739.28, -21613.7, 961.17 ), ( 0, 63.18, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_camp_cs";
    s.activity_bundle = "sat_activitydefinition_merccamp";
    s.name = "MERC_CAMP_Q4_WATER_TREATMENT";
    s.var_7a0840be22b9ebb = "SUPPLY_DROP_Q4_CAR_FACTORY_CAFETERIA";
    fe [[ f ]]( s, "MERC_CAMP_Q4_WATER_TREATMENT", cf, ( 40980.7, -7620.66, 701.7 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_camp_cs";
    fe [[ f ]]( s, "MERC_CAMP_Q4_WATER_TREATMENT", cf, ( 41085.8, -7772.26, 336.12 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Awareness_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 4000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_camp_cs";
    fe [[ f ]]( s, "MERC_CAMP_Q4_WATER_TREATMENT", cf, ( 41085.8, -7772.26, 328.12 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Ambient_AI_Exclusion_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 1800 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_camp_cs";
    fe [[ f ]]( s, "MERC_CAMP_Q4_WATER_TREATMENT", cf, ( 41085.8, -7772.26, 336.12 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Cleanup_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 5000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_camp_cs";
    s.groupid = "reinforcement_spawn_point";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "camp_reinforce_heli";
    s.variantname = "ai_encounter_spawnpoint";
    s.var_4501e0172e168ddf = "MERC_CAMP_Q4_WATER_TREATMENT_VTOL";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "MERC_CAMP_Q4_WATER_TREATMENT", cf, ( 41134.2, -7234.36, 318.36 ), ( 0, 179.39, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_camp_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "parachute_reinforce";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "MERC_CAMP_Q4_WATER_TREATMENT", cf, ( 41045.5, -7910.59, 312 ), ( 0, 94.82, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_camp_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "parachute_reinforce";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "MERC_CAMP_Q4_WATER_TREATMENT", cf, ( 40973.3, -8037.53, 312 ), ( 0, 95.79, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_camp_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "parachute_reinforce";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "MERC_CAMP_Q4_WATER_TREATMENT", cf, ( 41156.8, -8028.47, 312 ), ( 0, 121.85, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_camp_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "parachute_reinforce";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "MERC_CAMP_Q4_WATER_TREATMENT", cf, ( 41071.8, -8137.18, 312 ), ( 0, 63.18, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_camp_cs";
    s.activity_bundle = "sat_activitydefinition_merccamp";
    s.name = "MERC_CAMP_Q4_INDUSTRIAL_CENTRE";
    s.var_7a0840be22b9ebb = "SUPPLY_DROP_Q4_FLATS_FIRE_STATION";
    fe [[ f ]]( s, "MERC_CAMP_Q4_INDUSTRIAL_CENTRE", cf, ( 57234.6, -21541.1, 2812.66 ), ( 0, 333.36, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_camp_cs";
    fe [[ f ]]( s, "MERC_CAMP_Q4_INDUSTRIAL_CENTRE", cf, ( 57490.5, -21323.5, 2465.27 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Awareness_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 4000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_camp_cs";
    fe [[ f ]]( s, "MERC_CAMP_Q4_INDUSTRIAL_CENTRE", cf, ( 57411, -21387, 2457.27 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Ambient_AI_Exclusion_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 1800 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_camp_cs";
    fe [[ f ]]( s, "MERC_CAMP_Q4_INDUSTRIAL_CENTRE", cf, ( 57490.5, -21323.5, 2465.27 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Cleanup_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 5000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_camp_cs";
    s.groupid = "reinforcement_spawn_point";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "camp_reinforce_heli";
    s.variantname = "ai_encounter_spawnpoint";
    s.var_4501e0172e168ddf = "MERC_CAMP_Q4_INDUSTRIAL_CENTRE_VTOL";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "MERC_CAMP_Q4_INDUSTRIAL_CENTRE", cf, ( 56983.4, -21631.2, 2448.86 ), ( 0, 342.96, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_camp_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "parachute_reinforce";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "MERC_CAMP_Q4_INDUSTRIAL_CENTRE", cf, ( 57060.2, -21573.3, 2449.19 ), ( 0, 42.92, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_camp_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "parachute_reinforce";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "MERC_CAMP_Q4_INDUSTRIAL_CENTRE", cf, ( 56919.9, -21520.4, 2447.6 ), ( 0, 21.95, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_camp_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "parachute_reinforce";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "MERC_CAMP_Q4_INDUSTRIAL_CENTRE", cf, ( 56908.1, -21705.6, 2447.83 ), ( 0, 25.7, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_camp_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "parachute_reinforce";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "MERC_CAMP_Q4_INDUSTRIAL_CENTRE", cf, ( 57100.2, -21753.5, 2457.46 ), ( 0, 63.18, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_camp_cs";
    s.activity_bundle = "sat_activitydefinition_merccamp";
    s.name = "MERC_CAMP_Q4_SHIPYARD";
    s.var_7a0840be22b9ebb = "SUPPLY_DROP_Q4_CAMP_FIRESTATION";
    fe [[ f ]]( s, "MERC_CAMP_Q4_SHIPYARD", cf, ( 38882.1, -48112.1, 835.25 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_camp_cs";
    fe [[ f ]]( s, "MERC_CAMP_Q4_SHIPYARD", cf, ( 38757.1, -48187.5, 411.78 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Awareness_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 4000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_camp_cs";
    fe [[ f ]]( s, "MERC_CAMP_Q4_SHIPYARD", cf, ( 38865.6, -48050, 403.78 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Ambient_AI_Exclusion_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 1800 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_camp_cs";
    fe [[ f ]]( s, "MERC_CAMP_Q4_SHIPYARD", cf, ( 38757.1, -48187.5, 411.78 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Cleanup_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 5000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_camp_cs";
    s.groupid = "reinforcement_spawn_point";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "camp_reinforce_heli";
    s.variantname = "ai_encounter_spawnpoint";
    s.var_4501e0172e168ddf = "MERC_CAMP_Q4_SHIPYARD_VTOL";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "MERC_CAMP_Q4_SHIPYARD", cf, ( 39206.4, -47937.2, 408.36 ), ( 0, 342.96, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_camp_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "parachute_reinforce";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "MERC_CAMP_Q4_SHIPYARD", cf, ( 39148.2, -47962.4, 401.51 ), ( 0, 189.84, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_camp_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "parachute_reinforce";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "MERC_CAMP_Q4_SHIPYARD", cf, ( 39220.9, -48117.8, 396.98 ), ( 0, 159.81, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_camp_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "parachute_reinforce";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "MERC_CAMP_Q4_SHIPYARD", cf, ( 39269.9, -47895.4, 407.63 ), ( 0, 232.88, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_camp_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "parachute_reinforce";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "MERC_CAMP_Q4_SHIPYARD", cf, ( 39313.9, -48065, 401.15 ), ( 0, 146.79, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_camp_cs";
    s.activity_bundle = "sat_activitydefinition_merccamp";
    s.name = "MERC_CAMP_Q4_EPIC_BRIDGE";
    s.var_7a0840be22b9ebb = "SUPPLY_DROP_Q4_HELIPORT_POLICE_STATION";
    fe [[ f ]]( s, "MERC_CAMP_Q4_EPIC_BRIDGE", cf, ( 16367.4, -39850.2, 1458.57 ), ( 0, 98.76, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_camp_cs";
    fe [[ f ]]( s, "MERC_CAMP_Q4_EPIC_BRIDGE", cf, ( 16132.5, -39459.6, 1104.95 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Awareness_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 4000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_camp_cs";
    fe [[ f ]]( s, "MERC_CAMP_Q4_EPIC_BRIDGE", cf, ( 16375, -39690.1, 1096.95 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Ambient_AI_Exclusion_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 1800 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_camp_cs";
    fe [[ f ]]( s, "MERC_CAMP_Q4_EPIC_BRIDGE", cf, ( 16132.5, -39459.6, 1104.95 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Cleanup_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 5000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_camp_cs";
    s.groupid = "reinforcement_spawn_point";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "camp_reinforce_heli";
    s.variantname = "ai_encounter_spawnpoint";
    s.var_4501e0172e168ddf = "MERC_CAMP_Q4_EPIC_BRIDGE_VTOL";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "MERC_CAMP_Q4_EPIC_BRIDGE", cf, ( 16192.7, -39505.8, 1111.94 ), ( 0, 270.77, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_camp_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "parachute_reinforce";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "MERC_CAMP_Q4_EPIC_BRIDGE", cf, ( 16412.4, -39515.5, 1086.98 ), ( 0, 261.29, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_camp_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "parachute_reinforce";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "MERC_CAMP_Q4_EPIC_BRIDGE", cf, ( 16571.5, -39470.5, 1086.29 ), ( 0, 269.35, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_camp_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "parachute_reinforce";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "MERC_CAMP_Q4_EPIC_BRIDGE", cf, ( 16351.2, -39340, 1087.02 ), ( 0, 270.52, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_camp_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "parachute_reinforce";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "MERC_CAMP_Q4_EPIC_BRIDGE", cf, ( 16563.2, -39296.3, 1086.24 ), ( 0, 266.65, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace mp_sat_avalon_q4_ob_activity_merc_camp_cs
// Params 0, eflags: 0x4
// Checksum 0x1784a83, Offset: 0x2ff1
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace mp_sat_avalon_q4_ob_activity_merc_camp_cs
// Params 0
// Checksum 0xc31d1028, Offset: 0x2ffb
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "mp_sat_avalon_q4_ob_activity_merc_camp_cs" );
}

// Namespace mp_sat_avalon_q4_ob_activity_merc_camp_cs
// Params 0
// Checksum 0x35a1b190, Offset: 0x3011
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

// Namespace mp_sat_avalon_q4_ob_activity_merc_camp_cs
// Params 4
// Checksum 0xe90cd4a3, Offset: 0x3080
// Size: 0xd9
function function_d4323822d7042e5a( var_4312b79c960726b6, fe, us, cf = "mp_sat_avalon_q4_ob_activity_merc_camp_cs" )
{
    switch ( var_4312b79c960726b6 )
    {
        case #"hash_7de5e780ffe167a0":
            function_2cd0ae88aa159a98( fe, us, cf );
            break;
        case #"hash_88390f954a3910ef":
            function_da6dbc871e1e8ce7( fe, us, cf );
            break;
        case #"hash_1f4f894dfcdfe3d3":
            function_4288b7f6f3be732b( fe, us, cf );
            break;
        case #"hash_1f1a6f2572b9b044":
            function_68d0bb7b7757e86c( fe, us, cf );
            break;
        case #"hash_773f367554b50ff":
            function_5e1744c001c28927( fe, us, cf );
            break;
        case #"hash_289ab7166c2583c0":
            function_3c96cb8f218904d8( fe, us, cf );
            break;
    }
}

// Namespace mp_sat_avalon_q4_ob_activity_merc_camp_cs
// Params 3
// Checksum 0x8197e3ae, Offset: 0x3161
// Size: 0x684
function function_2cd0ae88aa159a98( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_camp_cs";
    s.name = "center_struct";
    fe [[ f ]]( s, "MERC_CAMP_Q4_HELIPORT_01", cf, ( 25253.7, -19013.8, 273 ), ( 0, 0, 0 ), "MERC_CAMP_Q4_HELIPORT_01", undefined, "MERC_CAMP_Q4_HELIPORT_01", "link_merc_camp", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 1650 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_camp_cs";
    s.name = "guard";
    fe [[ f ]]( s, "MERC_CAMP_Q4_HELIPORT_01", cf, ( 25415.8, -18086.3, 281.07 ), ( 0, 0, 0 ), "s_merc_camp_guard", undefined, undefined, undefined, "link_merc_camp", ( 0, 0, 0 ), ( 0, 0, 0 ), 250 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_camp_cs";
    s.name = "loot_cache";
    fe [[ f ]]( s, "MERC_CAMP_Q4_HELIPORT_01", cf, ( 25254.2, -18125.1, 278.18 ), ( 0, 241.55, 0 ), "s_merc_camp_cache", undefined, undefined, undefined, "link_merc_camp", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_camp_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    s.script_accel = "350";
    fe [[ f ]]( s, "MERC_CAMP_Q4_HELIPORT_01", cf, ( 25546.3, -18749.9, 878.94 ), ( 0, 44.13, 0 ), "MERC_CAMP_Q4_HELIPORT_01_VTOL", "cspf_7_auto9112207195742261278", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_camp_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MERC_CAMP_Q4_HELIPORT_01", cf, ( 41691, -9614.18, 12982.5 ), ( 359.47, 356.81, 0.49 ), "cspf_7_auto8073552022771520989", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_camp_cs";
    s.name = "vehicle";
    fe [[ f ]]( s, "MERC_CAMP_Q4_HELIPORT_01", cf, ( 26023.7, -17724.6, 266.03 ), ( 0.01, 60.77, 0.61 ), "s_merc_camp_vehicle", undefined, undefined, undefined, "link_merc_camp", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_camp_cs";
    s.name = "sentry";
    fe [[ f ]]( s, "MERC_CAMP_Q4_HELIPORT_01", cf, ( 26142.8, -18584.6, 267.63 ), ( 356.11, 191.65, -0.73 ), "s_merc_camp_sentry", undefined, undefined, undefined, "link_merc_camp", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_camp_cs";
    s.name = "sentry";
    fe [[ f ]]( s, "MERC_CAMP_Q4_HELIPORT_01", cf, ( 25323, -18753.2, 266.35 ), ( 0, 17.58, 0 ), "s_merc_camp_sentry", undefined, undefined, undefined, "link_merc_camp", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_camp_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MERC_CAMP_Q4_HELIPORT_01", cf, ( 18307.5, -28565.7, 8695.3 ), ( 0, 72.86, 0 ), undefined, "cspf_7_auto13550869155443645891", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150, 1 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_camp_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MERC_CAMP_Q4_HELIPORT_01", cf, ( 32274, -12070.4, 6261 ), ( 359.47, 356.81, 0.49 ), "cspf_7_auto9112207195742261278", "cspf_7_auto8073552022771520989", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_camp_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MERC_CAMP_Q4_HELIPORT_01", cf, ( 21904.2, -24784.6, 7351.3 ), ( 0, 321.56, 0 ), "cspf_7_auto13550869155443645891", "MERC_CAMP_Q4_HELIPORT_01_VTOL", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_camp_cs";
    s.name = "killstreak_support";
    fe [[ f ]]( s, "MERC_CAMP_Q4_HELIPORT_01", cf, ( 25644.6, -18748, 268 ), ( 0, 0, 0 ), undefined, undefined, "killstreak_support", undefined, "link_merc_camp", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_camp_cs";
    s.name = "alarm_origin";
    fe [[ f ]]( s, "MERC_CAMP_Q4_HELIPORT_01", cf, ( 30418, -18837, 1323 ), ( 356.11, 191.65, -0.73 ), "s_merc_camp_alarm", undefined, undefined, undefined, "link_merc_camp", ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_sat_avalon_q4_ob_activity_merc_camp_cs
// Params 3
// Checksum 0x3b247276, Offset: 0x37ed
// Size: 0x610
function function_da6dbc871e1e8ce7( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_camp_cs";
    s.name = "center_struct";
    fe [[ f ]]( s, "MERC_CAMP_Q4_FLATS_01", cf, ( 6263.71, -21478.8, 972.86 ), ( 0, 0, 0 ), "MERC_CAMP_Q4_FLATS_01", undefined, "MERC_CAMP_Q4_FLATS_01", "link_merc_camp", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 1500 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_camp_cs";
    s.name = "guard";
    fe [[ f ]]( s, "MERC_CAMP_Q4_FLATS_01", cf, ( 5768.25, -21255.7, 969.96 ), ( 0, 0, 0 ), "s_merc_camp_guard", undefined, undefined, undefined, "link_merc_camp", ( 0, 0, 0 ), ( 0, 0, 0 ), 250 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_camp_cs";
    s.name = "loot_cache";
    fe [[ f ]]( s, "MERC_CAMP_Q4_FLATS_01", cf, ( 5722.09, -21400.5, 963.49 ), ( 0, 306.2, 0 ), "s_merc_camp_cache", undefined, undefined, undefined, "link_merc_camp", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_camp_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    s.script_accel = "350";
    fe [[ f ]]( s, "MERC_CAMP_Q4_FLATS_01", cf, ( 5954.8, -21638.9, 1570.44 ), ( 0, 288.78, 0 ), "MERC_CAMP_Q4_FLATS_01_VTOL", "cspf_8_auto8695070655702447512", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_camp_cs";
    s.name = "sentry";
    fe [[ f ]]( s, "MERC_CAMP_Q4_FLATS_01", cf, ( 6510.03, -21982.5, 964.99 ), ( 0, 132.84, 0 ), "s_merc_camp_sentry", undefined, undefined, undefined, "link_merc_camp", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_camp_cs";
    s.name = "sentry";
    fe [[ f ]]( s, "MERC_CAMP_Q4_FLATS_01", cf, ( 5252.35, -21624.3, 927.8 ), ( 0, 333.21, 0 ), "s_merc_camp_sentry", undefined, undefined, undefined, "link_merc_camp", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_camp_cs";
    s.name = "vehicle";
    fe [[ f ]]( s, "MERC_CAMP_Q4_FLATS_01", cf, ( 6551.61, -20400.6, 968.62 ), ( 359.25, 70.36, -3.48 ), "s_merc_camp_vehicle", undefined, undefined, undefined, "link_merc_camp", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_camp_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MERC_CAMP_Q4_FLATS_01", cf, ( 7581.04, -40141.1, 13439 ), ( 359.47, 241.45, 0.49 ), "cspf_8_auto7698406668648420053", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_camp_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MERC_CAMP_Q4_FLATS_01", cf, ( 469.4, -10894.4, 9151.8 ), ( 0, 317.5, 0 ), undefined, "cspf_8_auto6425783161430658458", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150, 1 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_camp_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MERC_CAMP_Q4_FLATS_01", cf, ( 9394.31, -30579.5, 6717.5 ), ( 359.47, 241.45, 0.49 ), "cspf_8_auto8695070655702447512", "cspf_8_auto7698406668648420053", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_camp_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MERC_CAMP_Q4_FLATS_01", cf, ( 2345.95, -15763.8, 7807.8 ), ( 0, 206.2, 0 ), "cspf_8_auto6425783161430658458", "MERC_CAMP_Q4_FLATS_01_VTOL", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_camp_cs";
    s.name = "killstreak_support";
    fe [[ f ]]( s, "MERC_CAMP_Q4_FLATS_01", cf, ( 6006.04, -21744.1, 960.69 ), ( 0, 0, 0 ), undefined, undefined, "killstreak_support", undefined, "link_merc_camp", ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_sat_avalon_q4_ob_activity_merc_camp_cs
// Params 3
// Checksum 0xcdca4957, Offset: 0x3e05
// Size: 0x610
function function_4288b7f6f3be732b( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_camp_cs";
    s.name = "center_struct";
    fe [[ f ]]( s, "MERC_CAMP_Q4_WATER_TREATMENT", cf, ( 41113.3, -7627.96, 319 ), ( 0, 0, 0 ), "MERC_CAMP_Q4_WATER_TREATMENT", undefined, "MERC_CAMP_Q4_WATER_TREATMENT", "link_merc_camp", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 1500 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_camp_cs";
    s.name = "guard";
    fe [[ f ]]( s, "MERC_CAMP_Q4_WATER_TREATMENT", cf, ( 40694.6, -7859.34, 320.59 ), ( 0, 0, 0 ), "s_merc_camp_guard", undefined, undefined, undefined, "link_merc_camp", ( 0, 0, 0 ), ( 0, 0, 0 ), 250 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_camp_cs";
    s.name = "loot_cache";
    fe [[ f ]]( s, "MERC_CAMP_Q4_WATER_TREATMENT", cf, ( 40758.4, -7963.95, 311.67 ), ( 0, 2.63, 0 ), "s_merc_camp_cache", undefined, undefined, undefined, "link_merc_camp", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_camp_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    s.script_accel = "350";
    fe [[ f ]]( s, "MERC_CAMP_Q4_WATER_TREATMENT", cf, ( 41140.3, -7321.93, 922.94 ), ( 0, 159.47, 0 ), "MERC_CAMP_Q4_WATER_TREATMENT_VTOL", "cspf_9_auto17147451519662871611", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_camp_cs";
    s.name = "sentry";
    fe [[ f ]]( s, "MERC_CAMP_Q4_WATER_TREATMENT", cf, ( 40697.2, -8932.97, 314.96 ), ( 358.8, 272.88, -0 ), "s_merc_camp_sentry", undefined, undefined, undefined, "link_merc_camp", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_camp_cs";
    s.name = "sentry";
    fe [[ f ]]( s, "MERC_CAMP_Q4_WATER_TREATMENT", cf, ( 40746.7, -7424.85, 315.29 ), ( 355.3, 3.54, 0 ), "s_merc_camp_sentry", undefined, undefined, undefined, "link_merc_camp", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_camp_cs";
    s.name = "vehicle";
    fe [[ f ]]( s, "MERC_CAMP_Q4_WATER_TREATMENT", cf, ( 41569.2, -8316.03, 312.81 ), ( 359.41, 51.57, -0.2 ), "s_merc_camp_vehicle", undefined, undefined, undefined, "link_merc_camp", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_camp_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MERC_CAMP_Q4_WATER_TREATMENT", cf, ( 25615.8, 3426.65, 13003.5 ), ( 359.47, 112.15, 0.49 ), "cspf_9_auto2230010322693426170", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_camp_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MERC_CAMP_Q4_WATER_TREATMENT", cf, ( 52750.8, -9598.03, 8716.3 ), ( 0, 188.19, 0 ), undefined, "cspf_9_auto2228786837107405468", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150, 1 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_camp_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MERC_CAMP_Q4_WATER_TREATMENT", cf, ( 31865.5, -4033.52, 6282 ), ( 359.47, 112.15, 0.49 ), "cspf_9_auto17147451519662871611", "cspf_9_auto2230010322693426170", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_camp_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MERC_CAMP_Q4_WATER_TREATMENT", cf, ( 47794.3, -7965.35, 7372.3 ), ( 0, 76.89, 0 ), "cspf_9_auto2228786837107405468", "MERC_CAMP_Q4_WATER_TREATMENT_VTOL", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_camp_cs";
    s.name = "killstreak_support";
    fe [[ f ]]( s, "MERC_CAMP_Q4_WATER_TREATMENT", cf, ( 40898.2, -7249.1, 313.64 ), ( 0, 0, 0 ), undefined, undefined, "killstreak_support", undefined, "link_merc_camp", ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_sat_avalon_q4_ob_activity_merc_camp_cs
// Params 3
// Checksum 0xfc514ff6, Offset: 0x441d
// Size: 0x610
function function_68d0bb7b7757e86c( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_camp_cs";
    s.name = "center_struct";
    fe [[ f ]]( s, "MERC_CAMP_Q4_INDUSTRIAL_CENTRE", cf, ( 57142.8, -21237.2, 2458.06 ), ( 0, 0, 0 ), "MERC_CAMP_Q4_INDUSTRIAL_CENTRE", undefined, "MERC_CAMP_Q4_INDUSTRIAL_CENTRE", "link_merc_camp", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 1500 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_camp_cs";
    s.name = "guard";
    fe [[ f ]]( s, "MERC_CAMP_Q4_INDUSTRIAL_CENTRE", cf, ( 57697.5, -21698.1, 2464.71 ), ( 0, 0, 0 ), "s_merc_camp_guard", undefined, undefined, undefined, "link_merc_camp", ( 0, 0, 0 ), ( 0, 0, 0 ), 250 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_camp_cs";
    s.name = "loot_cache";
    fe [[ f ]]( s, "MERC_CAMP_Q4_INDUSTRIAL_CENTRE", cf, ( 57616.1, -21624.9, 2456.94 ), ( 0, 114.73, 0 ), "s_merc_camp_cache", undefined, undefined, undefined, "link_merc_camp", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_camp_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    s.script_accel = "350";
    fe [[ f ]]( s, "MERC_CAMP_Q4_INDUSTRIAL_CENTRE", cf, ( 57020.9, -21514.4, 3053.44 ), ( 0, 336.09, 0 ), "MERC_CAMP_Q4_INDUSTRIAL_CENTRE_VTOL", "cspf_10_auto2732905090876616406", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_camp_cs";
    s.name = "sentry";
    fe [[ f ]]( s, "MERC_CAMP_Q4_INDUSTRIAL_CENTRE", cf, ( 57373.1, -21824.6, 2455.54 ), ( 0, 191.28, 0 ), "s_merc_camp_sentry", undefined, undefined, undefined, "link_merc_camp", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_camp_cs";
    s.name = "sentry";
    fe [[ f ]]( s, "MERC_CAMP_Q4_INDUSTRIAL_CENTRE", cf, ( 56885.8, -21340.1, 2446.9 ), ( 0, 289.71, 0 ), "s_merc_camp_sentry", undefined, undefined, undefined, "link_merc_camp", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_camp_cs";
    s.name = "vehicle";
    fe [[ f ]]( s, "MERC_CAMP_Q4_INDUSTRIAL_CENTRE", cf, ( 56930.3, -22176.1, 2464.41 ), ( 359.24, 260.56, 1.43 ), "s_merc_camp_vehicle", undefined, undefined, undefined, "link_merc_camp", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_camp_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MERC_CAMP_Q4_INDUSTRIAL_CENTRE", cf, ( 63584, -36922.2, 15360.7 ), ( 359.47, 275.72, 0.5 ), "cspf_10_auto11507977605126796575", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_camp_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MERC_CAMP_Q4_INDUSTRIAL_CENTRE", cf, ( 43600.7, -14706, 11580.3 ), ( 0, 331.2, 0 ), undefined, "cspf_10_auto11647458808093296610", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150, 1 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_camp_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MERC_CAMP_Q4_INDUSTRIAL_CENTRE", cf, ( 61757.6, -27806.5, 8762 ), ( 359.47, 275.72, 0.5 ), "cspf_10_auto2732905090876616406", "cspf_10_auto11507977605126796575", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_camp_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MERC_CAMP_Q4_INDUSTRIAL_CENTRE", cf, ( 50749.5, -18429.9, 9373.3 ), ( 0, 240.46, 0 ), "cspf_10_auto11647458808093296610", "MERC_CAMP_Q4_INDUSTRIAL_CENTRE_VTOL", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_camp_cs";
    s.name = "killstreak_support";
    fe [[ f ]]( s, "MERC_CAMP_Q4_INDUSTRIAL_CENTRE", cf, ( 57076.1, -21698.8, 2445.05 ), ( 0, 0, 0 ), undefined, undefined, "killstreak_support", undefined, "link_merc_camp", ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_sat_avalon_q4_ob_activity_merc_camp_cs
// Params 3
// Checksum 0xbb730810, Offset: 0x4a35
// Size: 0x610
function function_5e1744c001c28927( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_camp_cs";
    s.name = "center_struct";
    fe [[ f ]]( s, "MERC_CAMP_Q4_SHIPYARD", cf, ( 38841.9, -48028, 405.65 ), ( 0, 0, 0 ), "MERC_CAMP_Q4_SHIPYARD", undefined, "MERC_CAMP_Q4_SHIPYARD", "link_merc_camp", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 1500 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_camp_cs";
    s.name = "guard";
    fe [[ f ]]( s, "MERC_CAMP_Q4_SHIPYARD", cf, ( 38775.6, -47377.6, 402.34 ), ( 0, 0, 0 ), "s_merc_camp_guard", undefined, undefined, undefined, "link_merc_camp", ( 0, 0, 0 ), ( 0, 0, 0 ), 250 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_camp_cs";
    s.name = "loot_cache";
    fe [[ f ]]( s, "MERC_CAMP_Q4_SHIPYARD", cf, ( 38611.3, -47362.9, 394 ), ( 0, 222.71, 0 ), "s_merc_camp_cache", undefined, undefined, undefined, "link_merc_camp", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_camp_cs";
    s.name = "sentry";
    fe [[ f ]]( s, "MERC_CAMP_Q4_SHIPYARD", cf, ( 38953.4, -48286.9, 394 ), ( 0, 297.2, 0 ), "s_merc_camp_sentry", undefined, undefined, undefined, "link_merc_camp", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_camp_cs";
    s.name = "sentry";
    fe [[ f ]]( s, "MERC_CAMP_Q4_SHIPYARD", cf, ( 38929.2, -47659.4, 396.25 ), ( 356.12, 287.86, 0 ), "s_merc_camp_sentry", undefined, undefined, undefined, "link_merc_camp", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_camp_cs";
    s.name = "vehicle";
    fe [[ f ]]( s, "MERC_CAMP_Q4_SHIPYARD", cf, ( 39763, -48847.2, 390.73 ), ( 359.14, 324.54, 4.18 ), "s_merc_camp_vehicle", undefined, undefined, undefined, "link_merc_camp", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_camp_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    s.script_accel = "350";
    fe [[ f ]]( s, "MERC_CAMP_Q4_SHIPYARD", cf, ( 39243.9, -47820.4, 1012.94 ), ( 0, 336.09, 0 ), "MERC_CAMP_Q4_SHIPYARD_VTOL", "cspf_11_auto17020990069233032947", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_camp_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MERC_CAMP_Q4_SHIPYARD", cf, ( 50583.3, -62638.1, 13004 ), ( 359.47, 275.72, 0.5 ), "cspf_11_auto18408266028196091506", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_camp_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MERC_CAMP_Q4_SHIPYARD", cf, ( 28240.2, -42470.5, 8716.8 ), ( 0, 351.77, 0 ), undefined, "cspf_11_auto4656949175878856120", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150, 1 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_camp_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MERC_CAMP_Q4_SHIPYARD", cf, ( 47527.1, -50906, 6761.5 ), ( 359.47, 275.72, 0.5 ), "cspf_11_auto17020990069233032947", "cspf_11_auto18408266028196091506", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_camp_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MERC_CAMP_Q4_SHIPYARD", cf, ( 32532.5, -45438.4, 7372.8 ), ( 0, 240.46, 0 ), "cspf_11_auto4656949175878856120", "MERC_CAMP_Q4_SHIPYARD_VTOL", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_camp_cs";
    s.name = "killstreak_support";
    fe [[ f ]]( s, "MERC_CAMP_Q4_SHIPYARD", cf, ( 38444.7, -47650.5, 394 ), ( 0, 0, 0 ), undefined, undefined, "killstreak_support", undefined, "link_merc_camp", ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_sat_avalon_q4_ob_activity_merc_camp_cs
// Params 3
// Checksum 0x4173bdb6, Offset: 0x504d
// Size: 0x610
function function_3c96cb8f218904d8( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_camp_cs";
    s.name = "center_struct";
    fe [[ f ]]( s, "MERC_CAMP_Q4_EPIC_BRIDGE", cf, ( 16470.3, -39821.8, 1097.39 ), ( 0, 0, 0 ), "MERC_CAMP_Q4_EPIC_BRIDGE", undefined, "MERC_CAMP_Q4_EPIC_BRIDGE", "link_merc_camp", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 1500 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_camp_cs";
    s.name = "guard";
    fe [[ f ]]( s, "MERC_CAMP_Q4_EPIC_BRIDGE", cf, ( 16545.3, -40138.2, 1102.33 ), ( 0, 0, 0 ), "s_merc_camp_guard", undefined, undefined, undefined, "link_merc_camp", ( 0, 0, 0 ), ( 0, 0, 0 ), 250 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_camp_cs";
    s.name = "loot_cache";
    fe [[ f ]]( s, "MERC_CAMP_Q4_EPIC_BRIDGE", cf, ( 16726.7, -40269.7, 1094.04 ), ( 0, 30.93, 0 ), "s_merc_camp_cache", undefined, undefined, undefined, "link_merc_camp", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_camp_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    s.script_accel = "350";
    fe [[ f ]]( s, "MERC_CAMP_Q4_EPIC_BRIDGE", cf, ( 16297.6, -39514.6, 1718.94 ), ( 0, 263.9, 0 ), "MERC_CAMP_Q4_EPIC_BRIDGE_VTOL", "cspf_12_auto16793279625078731967", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_camp_cs";
    s.name = "sentry";
    fe [[ f ]]( s, "MERC_CAMP_Q4_EPIC_BRIDGE", cf, ( 16109.2, -39895.5, 1092.33 ), ( 358.74, 162.37, 0 ), "s_merc_camp_sentry", undefined, undefined, undefined, "link_merc_camp", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_camp_cs";
    s.name = "sentry";
    fe [[ f ]]( s, "MERC_CAMP_Q4_EPIC_BRIDGE", cf, ( 16455, -39739.8, 1091.4 ), ( 0, 119.51, 0 ), "s_merc_camp_sentry", undefined, undefined, undefined, "link_merc_camp", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_camp_cs";
    s.name = "vehicle";
    fe [[ f ]]( s, "MERC_CAMP_Q4_EPIC_BRIDGE", cf, ( 15084.3, -40402.2, 1093.99 ), ( 359.25, 178.48, -0.46 ), "s_merc_camp_vehicle", undefined, undefined, undefined, "link_merc_camp", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_camp_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MERC_CAMP_Q4_EPIC_BRIDGE", cf, ( 5635.84, -55579.1, 13794.5 ), ( 359.47, 203.53, 0.5 ), "cspf_12_auto6247439036573757052", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_camp_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MERC_CAMP_Q4_EPIC_BRIDGE", cf, ( 18004.4, -28138.9, 9507.3 ), ( 0, 279.57, 0 ), undefined, "cspf_12_auto17333177458267022964", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150, 1 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_camp_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MERC_CAMP_Q4_EPIC_BRIDGE", cf, ( 15871.3, -49081.5, 7552 ), ( 359.47, 203.53, 0.5 ), "cspf_12_auto16793279625078731967", "cspf_12_auto6247439036573757052", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_camp_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MERC_CAMP_Q4_EPIC_BRIDGE", cf, ( 16491.3, -33133.2, 8163.3 ), ( 0, 168.27, 0 ), "cspf_12_auto17333177458267022964", "MERC_CAMP_Q4_EPIC_BRIDGE_VTOL", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_camp_cs";
    s.name = "killstreak_support";
    fe [[ f ]]( s, "MERC_CAMP_Q4_EPIC_BRIDGE", cf, ( 16312.1, -39317.3, 1088.41 ), ( 0, 0, 0 ), undefined, undefined, "killstreak_support", undefined, "link_merc_camp", ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_sat_avalon_q4_ob_activity_merc_camp_cs
// Params 0
// Checksum 0x71c70e45, Offset: 0x5665
// Size: 0x559
function function_d9dd7965c51c95d1()
{
    activityinstances = [];
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_activitydefinition_merccamp";
    var_881289d7987bc770.var_7a0840be22b9ebb = "SUPPLY_DROP_CITY_LOW_TOWN_FIRESTATION";
    var_881289d7987bc770.cf = "mp_sat_avalon_q4_ob_activity_merc_camp_cs";
    var_881289d7987bc770.scriptstructorigin = ( 25683.4, -18716.6, 698.75 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [ ( 25255.2, -19017.5, 273 ) ];
    var_881289d7987bc770.var_31ce4477e3543d24 = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.locationradius = [ 1500 ];
    activityinstances[ "MERC_CAMP_Q4_HELIPORT_01" ] = var_881289d7987bc770;
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_activitydefinition_merccamp";
    var_881289d7987bc770.var_7a0840be22b9ebb = "SUPPLY_DROP_Q4_MOUNTAIN_RANGE_MAIN_OFFICE";
    var_881289d7987bc770.cf = "mp_sat_avalon_q4_ob_activity_merc_camp_cs";
    var_881289d7987bc770.scriptstructorigin = ( 6108.54, -21583.6, 1379.86 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [ ( 6264.96, -21481.8, 972.86 ) ];
    var_881289d7987bc770.var_31ce4477e3543d24 = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.locationradius = [ 1350 ];
    activityinstances[ "MERC_CAMP_Q4_FLATS_01" ] = var_881289d7987bc770;
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_activitydefinition_merccamp";
    var_881289d7987bc770.var_7a0840be22b9ebb = "SUPPLY_DROP_Q4_CAR_FACTORY_CAFETERIA";
    var_881289d7987bc770.cf = "mp_sat_avalon_q4_ob_activity_merc_camp_cs";
    var_881289d7987bc770.scriptstructorigin = ( 40980.7, -7620.66, 701.7 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [ ( 41052.9, -7684.06, 327.99 ) ];
    var_881289d7987bc770.var_31ce4477e3543d24 = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.locationradius = [ 1350 ];
    activityinstances[ "MERC_CAMP_Q4_WATER_TREATMENT" ] = var_881289d7987bc770;
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_activitydefinition_merccamp";
    var_881289d7987bc770.var_7a0840be22b9ebb = "SUPPLY_DROP_Q4_FLATS_FIRE_STATION";
    var_881289d7987bc770.cf = "mp_sat_avalon_q4_ob_activity_merc_camp_cs";
    var_881289d7987bc770.scriptstructorigin = ( 57234.6, -21541.1, 2812.66 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [ ( 57457.6, -21235.3, 2471.14 ) ];
    var_881289d7987bc770.var_31ce4477e3543d24 = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.locationradius = [ 1350 ];
    activityinstances[ "MERC_CAMP_Q4_INDUSTRIAL_CENTRE" ] = var_881289d7987bc770;
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_activitydefinition_merccamp";
    var_881289d7987bc770.var_7a0840be22b9ebb = "SUPPLY_DROP_Q4_CAMP_FIRESTATION";
    var_881289d7987bc770.cf = "mp_sat_avalon_q4_ob_activity_merc_camp_cs";
    var_881289d7987bc770.scriptstructorigin = ( 38882.1, -48112.1, 835.25 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [ ( 38738.4, -48248.1, 409.9 ) ];
    var_881289d7987bc770.var_31ce4477e3543d24 = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.locationradius = [ 1350 ];
    activityinstances[ "MERC_CAMP_Q4_SHIPYARD" ] = var_881289d7987bc770;
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_activitydefinition_merccamp";
    var_881289d7987bc770.var_7a0840be22b9ebb = "SUPPLY_DROP_Q4_HELIPORT_POLICE_STATION";
    var_881289d7987bc770.cf = "mp_sat_avalon_q4_ob_activity_merc_camp_cs";
    var_881289d7987bc770.scriptstructorigin = ( 16367.4, -39850.2, 1458.57 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [ ( 16113.8, -39520.2, 1100.82 ) ];
    var_881289d7987bc770.var_31ce4477e3543d24 = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.locationradius = [ 1350 ];
    activityinstances[ "MERC_CAMP_Q4_EPIC_BRIDGE" ] = var_881289d7987bc770;
    return activityinstances;
}

