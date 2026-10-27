// script_75c11344f43eb08f  (hash_75c11344f43eb08f.gscc) (size: 39139 Bytes / 0x98e3 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xfdc53b24 (4257561380)
// size ...... 39139 (0x98e3)
// includes .. 4   (offset: 0x842b)
// strings ... 79  (offset: 0x844b)
// dev strs .. 0   (offset: 0x98e3)
// exports ... 23  (offset: 0x7c77)
// cseg ...... 0x8b1 + 0x73c6 (0x7c77)
// imports ... 36  (offset: 0x800f)
// animtree1 . 0   (offset: 0x98e3)
// animtree2 . 0   (offset: 0x98e3)
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace mp_sat_avalon_q2_ob_activity_merc_camp_cs;

// Namespace mp_sat_avalon_q2_ob_activity_merc_camp_cs
// Params 0, eflags: 0x5
// Checksum 0x8a27d022, Offset: 0x8cf
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"mp_sat_avalon_q2_ob_activity_merc_camp_cs", #"activity_common", &function_b39ecd3d51489472, undefined );
}

// Namespace mp_sat_avalon_q2_ob_activity_merc_camp_cs
// Params 0, eflags: 0x4
// Checksum 0xab9c77d5, Offset: 0x8f8
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace mp_sat_avalon_q2_ob_activity_merc_camp_cs
// Params 0, eflags: 0x4
// Checksum 0x2ea7a439, Offset: 0x909
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace mp_sat_avalon_q2_ob_activity_merc_camp_cs
// Params 2
// Checksum 0x8549feec, Offset: 0x91a
// Size: 0x8c
function main( unused, unused2 )
{
    if ( utility::flag_exist( "mp_sat_avalon_q2_ob_activity_merc_camp_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "mp_sat_avalon_q2_ob_activity_merc_camp_cs" ) )
    {
        return;
    }
    
    activity_common::function_e1df676808c1d1e3( &function_4cd78e661617f3 );
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "mp_sat_avalon_q2_ob_activity_merc_camp_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "mp_sat_avalon_q2_ob_activity_merc_camp_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace mp_sat_avalon_q2_ob_activity_merc_camp_cs
// Params 3, eflags: 0x4
// Checksum 0xad2510f6, Offset: 0x9ae
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "mp_sat_avalon_q2_ob_activity_merc_camp_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "mp_sat_avalon_q2_ob_activity_merc_camp_cs" );
}

// Namespace mp_sat_avalon_q2_ob_activity_merc_camp_cs
// Params 3, eflags: 0x4
// Checksum 0x73a9b8e9, Offset: 0xa28
// Size: 0x309a
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_camp_cs";
    s.activity_bundle = "sat_activitydefinition_merccamp";
    s.name = "MERC_CAMP_Q2_TUNNEL_INTERSECTION";
    s.var_7a0840be22b9ebb = "SUPPLY_DROP_CITY_LOW_TOWN_POLICESTATION";
    fe [[ f ]]( s, "MERC_CAMP_Q2_TUNNEL_INTERSECTION", cf, ( 16374.9, 4233.67, 1097.32 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_camp_cs";
    fe [[ f ]]( s, "MERC_CAMP_Q2_TUNNEL_INTERSECTION", cf, ( 16428.9, 4307.25, 753.08 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Awareness_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 4000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_camp_cs";
    fe [[ f ]]( s, "MERC_CAMP_Q2_TUNNEL_INTERSECTION", cf, ( 16395.9, 4317.25, 745.08 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Ambient_AI_Exclusion_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 1700 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_camp_cs";
    s.groupid = "reinforcement_spawn_point";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "camp_reinforce_heli";
    s.variantname = "ai_encounter_spawnpoint";
    s.var_4501e0172e168ddf = "MERC_CAMP_Q2_TUNNEL_INTERSECTION_VTOL";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "MERC_CAMP_Q2_TUNNEL_INTERSECTION", cf, ( 15859.1, 4099.67, 733.26 ), ( 0, 0.02, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_camp_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "parachute_reinforce";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "MERC_CAMP_Q2_TUNNEL_INTERSECTION", cf, ( 16945.3, 4517.68, 768.07 ), ( 0, 180.79, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_camp_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "parachute_reinforce";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "MERC_CAMP_Q2_TUNNEL_INTERSECTION", cf, ( 16892.4, 4635.46, 768.54 ), ( 0, 232.39, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_camp_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "parachute_reinforce";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "MERC_CAMP_Q2_TUNNEL_INTERSECTION", cf, ( 16990.7, 4745.39, 771.73 ), ( 0, 237.91, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_camp_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "parachute_reinforce";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "MERC_CAMP_Q2_TUNNEL_INTERSECTION", cf, ( 17087.8, 4525.79, 771.21 ), ( 0, 168.07, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_camp_cs";
    fe [[ f ]]( s, "MERC_CAMP_Q2_TUNNEL_INTERSECTION", cf, ( 16428.9, 4307.25, 753.08 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Cleanup_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 5000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_camp_cs";
    s.activity_bundle = "sat_activitydefinition_merccamp";
    s.name = "MERC_CAMP_Q2_WINERY";
    s.var_7a0840be22b9ebb = "SUPPLY_DROP_WINERY_COURTYARD";
    fe [[ f ]]( s, "MERC_CAMP_Q2_WINERY", cf, ( 24965, 44109.1, 1530.36 ), ( 0, 333.36, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_camp_cs";
    fe [[ f ]]( s, "MERC_CAMP_Q2_WINERY", cf, ( 25117, 44344.9, 1256.3 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Awareness_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 4000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_camp_cs";
    fe [[ f ]]( s, "MERC_CAMP_Q2_WINERY", cf, ( 24948, 44083.9, 1248.3 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Ambient_AI_Exclusion_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 1500 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_camp_cs";
    fe [[ f ]]( s, "MERC_CAMP_Q2_WINERY", cf, ( 25117, 44344.9, 1256.3 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Cleanup_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 5000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_camp_cs";
    s.groupid = "reinforcement_spawn_point";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "camp_reinforce_heli";
    s.variantname = "ai_encounter_spawnpoint";
    s.var_4501e0172e168ddf = "MERC_CAMP_Q2_WINERY_VTOL";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "MERC_CAMP_Q2_WINERY", cf, ( 24870.6, 44784.5, 1196.42 ), ( 0, 0.02, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_camp_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "parachute_reinforce";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "MERC_CAMP_Q2_WINERY", cf, ( 25659.4, 44612.5, 1282.33 ), ( 0, 216.13, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_camp_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "parachute_reinforce";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "MERC_CAMP_Q2_WINERY", cf, ( 25533.9, 44511.9, 1270.27 ), ( 0, 207.54, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_camp_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "parachute_reinforce";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "MERC_CAMP_Q2_WINERY", cf, ( 25536.2, 44628, 1270.54 ), ( 0, 192.26, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_camp_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "parachute_reinforce";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "MERC_CAMP_Q2_WINERY", cf, ( 25628.8, 44471.3, 1272.91 ), ( 0, 151.83, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_camp_cs";
    s.activity_bundle = "sat_activitydefinition_merccamp";
    s.name = "MERC_CAMP_Q2_RURAL_VILLAGE";
    s.var_7a0840be22b9ebb = "SUPPLY_DROP_WINERY";
    fe [[ f ]]( s, "MERC_CAMP_Q2_RURAL_VILLAGE", cf, ( 14954, 30831.6, 2252.31 ), ( 0, 333.36, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_camp_cs";
    fe [[ f ]]( s, "MERC_CAMP_Q2_RURAL_VILLAGE", cf, ( 14708, 31045.6, 1925.7 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Awareness_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 4000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_camp_cs";
    fe [[ f ]]( s, "MERC_CAMP_Q2_RURAL_VILLAGE", cf, ( 14916, 30831.6, 1917.7 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Ambient_AI_Exclusion_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 1500 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_camp_cs";
    fe [[ f ]]( s, "MERC_CAMP_Q2_RURAL_VILLAGE", cf, ( 14708, 31045.6, 1925.7 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Cleanup_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 5000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_camp_cs";
    s.groupid = "reinforcement_spawn_point";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "camp_reinforce_heli";
    s.variantname = "ai_encounter_spawnpoint";
    s.var_4501e0172e168ddf = "MERC_CAMP_Q2_RURAL_VILLAGE_VTOL";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "MERC_CAMP_Q2_RURAL_VILLAGE", cf, ( 14056.8, 31119.6, 2011.04 ), ( 0, 279.33, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_camp_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "parachute_reinforce";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "MERC_CAMP_Q2_RURAL_VILLAGE", cf, ( 14457.3, 31159.7, 1923.17 ), ( 0, 265.22, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_camp_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "parachute_reinforce";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "MERC_CAMP_Q2_RURAL_VILLAGE", cf, ( 14350.7, 31222.6, 1947.76 ), ( 0, 297.67, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_camp_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "parachute_reinforce";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "MERC_CAMP_Q2_RURAL_VILLAGE", cf, ( 14242.6, 31163.5, 1961.83 ), ( 0, 304.84, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_camp_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "parachute_reinforce";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "MERC_CAMP_Q2_RURAL_VILLAGE", cf, ( 14235.3, 31035.1, 1931.88 ), ( 0, 312.29, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_camp_cs";
    s.activity_bundle = "sat_activitydefinition_merccamp";
    s.name = "MERC_CAMP_Q2_COLOSSEUM";
    s.var_7a0840be22b9ebb = "SUPPLY_DROP_PONY_CLUB";
    fe [[ f ]]( s, "MERC_CAMP_Q2_COLOSSEUM", cf, ( 47905.5, 28165.5, 1199.47 ), ( 0, 333.36, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_camp_cs";
    fe [[ f ]]( s, "MERC_CAMP_Q2_COLOSSEUM", cf, ( 47911, 28065.7, 901.54 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Awareness_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 4000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_camp_cs";
    fe [[ f ]]( s, "MERC_CAMP_Q2_COLOSSEUM", cf, ( 47935.5, 28224.7, 893.54 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Ambient_AI_Exclusion_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 1800 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_camp_cs";
    fe [[ f ]]( s, "MERC_CAMP_Q2_COLOSSEUM", cf, ( 47911, 28065.7, 901.54 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Cleanup_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 5000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_camp_cs";
    s.groupid = "reinforcement_spawn_point";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "camp_reinforce_heli";
    s.variantname = "ai_encounter_spawnpoint";
    s.var_4501e0172e168ddf = "MERC_CAMP_Q2_COLOSSEUM_VTOL";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "MERC_CAMP_Q2_COLOSSEUM", cf, ( 47806.5, 28944.2, 892.75 ), ( 0, 277.41, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_camp_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "parachute_reinforce";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "MERC_CAMP_Q2_COLOSSEUM", cf, ( 48198.3, 28176.9, 900.01 ), ( 0, 199.27, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_camp_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "parachute_reinforce";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "MERC_CAMP_Q2_COLOSSEUM", cf, ( 48290.4, 28274.9, 900.86 ), ( 0, 218.76, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_camp_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "parachute_reinforce";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "MERC_CAMP_Q2_COLOSSEUM", cf, ( 48314.6, 28140.2, 901.32 ), ( 0, 174.33, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_camp_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "parachute_reinforce";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "MERC_CAMP_Q2_COLOSSEUM", cf, ( 48099.1, 28165.4, 899.08 ), ( 0, 170.25, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_camp_cs";
    s.activity_bundle = "sat_activitydefinition_merccamp";
    s.name = "MERC_CAMP_Q2_ROMAN_CANALS";
    s.var_7a0840be22b9ebb = "SUPPLY_DROP_POLICE_STATION";
    fe [[ f ]]( s, "MERC_CAMP_Q2_ROMAN_CANALS", cf, ( 33254.9, 17454.8, 1543.45 ), ( 0, 333.36, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_camp_cs";
    fe [[ f ]]( s, "MERC_CAMP_Q2_ROMAN_CANALS", cf, ( 33594.9, 17478.7, 1210.6 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Awareness_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 4000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_camp_cs";
    fe [[ f ]]( s, "MERC_CAMP_Q2_ROMAN_CANALS", cf, ( 33500.8, 17460.8, 1211.96 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Ambient_AI_Exclusion_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 1800 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_camp_cs";
    fe [[ f ]]( s, "MERC_CAMP_Q2_ROMAN_CANALS", cf, ( 33619.4, 17520.8, 1213.28 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Cleanup_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 5000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_camp_cs";
    s.groupid = "reinforcement_spawn_point";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "camp_reinforce_heli";
    s.variantname = "ai_encounter_spawnpoint";
    s.var_4501e0172e168ddf = "MERC_CAMP_Q2_ROMAN_CANALS_VTOL";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "MERC_CAMP_Q2_ROMAN_CANALS", cf, ( 33944.9, 17865, 1245.75 ), ( 0, 201.83, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_camp_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "parachute_reinforce";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "MERC_CAMP_Q2_ROMAN_CANALS", cf, ( 32822.3, 17592.2, 1196.77 ), ( 0, 18.32, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_camp_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "parachute_reinforce";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "MERC_CAMP_Q2_ROMAN_CANALS", cf, ( 32910.1, 17533.2, 1196.52 ), ( 0, 36.21, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_camp_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "parachute_reinforce";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "MERC_CAMP_Q2_ROMAN_CANALS", cf, ( 32886.3, 17691.1, 1194.77 ), ( 0, 2.16, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_camp_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "parachute_reinforce";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "MERC_CAMP_Q2_ROMAN_CANALS", cf, ( 32705.6, 17541.3, 1195.2 ), ( 0, 26.31, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_camp_cs";
    s.activity_bundle = "sat_activitydefinition_merccamp";
    s.name = "MERC_CAMP_Q2_CLIFF_TOWN_01";
    s.var_7a0840be22b9ebb = "SUPPLY_DROP_Q4_SHIP_YARD";
    fe [[ f ]]( s, "MERC_CAMP_Q2_CLIFF_TOWN_01", cf, ( 49115.1, 7527.94, 1414.24 ), ( 0, 259.72, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_camp_cs";
    fe [[ f ]]( s, "MERC_CAMP_Q2_CLIFF_TOWN_01", cf, ( 49074.7, 7928, 1032.15 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Awareness_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 4000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_camp_cs";
    fe [[ f ]]( s, "MERC_CAMP_Q2_CLIFF_TOWN_01", cf, ( 49228, 7450.92, 1034.39 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Ambient_AI_Exclusion_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 1800 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_camp_cs";
    fe [[ f ]]( s, "MERC_CAMP_Q2_CLIFF_TOWN_01", cf, ( 48938.2, 7962.49, 1062.05 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Cleanup_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 5000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_camp_cs";
    s.groupid = "reinforcement_spawn_point";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "camp_reinforce_heli";
    s.variantname = "ai_encounter_spawnpoint";
    s.var_4501e0172e168ddf = "MERC_CAMP_Q2_CLIFF_TOWN_01_VTOL";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "MERC_CAMP_Q2_CLIFF_TOWN_01", cf, ( 49143.6, 7436.38, 994.74 ), ( 0, 277.41, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_camp_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "parachute_reinforce";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "MERC_CAMP_Q2_CLIFF_TOWN_01", cf, ( 49259.9, 7764, 1017.54 ), ( 0, 271.71, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_camp_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "parachute_reinforce";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "MERC_CAMP_Q2_CLIFF_TOWN_01", cf, ( 49405.3, 7685.7, 1015.1 ), ( 0, 218.76, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_camp_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "parachute_reinforce";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "MERC_CAMP_Q2_CLIFF_TOWN_01", cf, ( 49278, 7634.73, 1005.54 ), ( 0, 245.49, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_camp_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "parachute_reinforce";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "MERC_CAMP_Q2_CLIFF_TOWN_01", cf, ( 49224.7, 7503.24, 997.04 ), ( 0, 238.17, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_camp_cs";
    s.activity_bundle = "sat_activitydefinition_merccamp";
    s.name = "MERC_CAMP_Q2_CLIFFTOWN_SQUAD4";
    fe [[ f ]]( s, "MERC_CAMP_Q2_CLIFFTOWN_SQUAD4", cf, ( 45927.8, 3850.03, 1260 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_camp_cs";
    fe [[ f ]]( s, "MERC_CAMP_Q2_CLIFFTOWN_SQUAD4", cf, ( 46218.8, 3721.78, 910.97 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Awareness_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 2000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_camp_cs";
    fe [[ f ]]( s, "MERC_CAMP_Q2_CLIFFTOWN_SQUAD4", cf, ( 46185.6, 3721.94, 912.38 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Ambient_AI_Exclusion_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 1800 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_camp_cs";
    fe [[ f ]]( s, "MERC_CAMP_Q2_CLIFFTOWN_SQUAD4", cf, ( 46185.6, 3755.11, 911.98 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Cleanup_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 5000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_camp_cs";
    s.activity_bundle = "sat_activitydefinition_merccamp";
    s.name = "MERC_CAMP_Q2_CLIFFTOWN_SQUAD2";
    fe [[ f ]]( s, "MERC_CAMP_Q2_CLIFFTOWN_SQUAD2", cf, ( 39730.2, 3416.74, 1412.21 ), ( 0, 259.72, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_camp_cs";
    fe [[ f ]]( s, "MERC_CAMP_Q2_CLIFFTOWN_SQUAD2", cf, ( 39717, 3341.95, 1066.48 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Awareness_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 2000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_camp_cs";
    fe [[ f ]]( s, "MERC_CAMP_Q2_CLIFFTOWN_SQUAD2", cf, ( 39303.8, 2846.11, 1063.83 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Ambient_AI_Exclusion_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 1500 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_camp_cs";
    fe [[ f ]]( s, "MERC_CAMP_Q2_CLIFFTOWN_SQUAD2", cf, ( 39683.8, 3375.28, 1065.75 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Cleanup_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 5000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_camp_cs";
    s.activity_bundle = "sat_activitydefinition_merccamp";
    s.name = "MERC_CAMP_Q2_CLIFFTOWN_SQUAD3";
    fe [[ f ]]( s, "MERC_CAMP_Q2_CLIFFTOWN_SQUAD3", cf, ( 42056.2, 3083.05, 1450 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_camp_cs";
    fe [[ f ]]( s, "MERC_CAMP_Q2_CLIFFTOWN_SQUAD3", cf, ( 42077.7, 3054.69, 1083.32 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Awareness_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 2000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_camp_cs";
    fe [[ f ]]( s, "MERC_CAMP_Q2_CLIFFTOWN_SQUAD3", cf, ( 42044.5, 3054.85, 1084.74 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Ambient_AI_Exclusion_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 1800 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_camp_cs";
    fe [[ f ]]( s, "MERC_CAMP_Q2_CLIFFTOWN_SQUAD3", cf, ( 42044.5, 3088.02, 1084.34 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Cleanup_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 5000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_camp_cs";
    s.activity_bundle = "sat_activitydefinition_merccamp";
    s.name = "MERC_CAMP_Q2_CLIFFTOWN_SQUAD5";
    fe [[ f ]]( s, "MERC_CAMP_Q2_CLIFFTOWN_SQUAD5", cf, ( 47820.8, 11739.6, 936.31 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_camp_cs";
    fe [[ f ]]( s, "MERC_CAMP_Q2_CLIFFTOWN_SQUAD5", cf, ( 47851.2, 11725.7, 613.3 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Awareness_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 2000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_camp_cs";
    fe [[ f ]]( s, "MERC_CAMP_Q2_CLIFFTOWN_SQUAD5", cf, ( 47818, 11725.9, 614.72 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Ambient_AI_Exclusion_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 1800 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_camp_cs";
    fe [[ f ]]( s, "MERC_CAMP_Q2_CLIFFTOWN_SQUAD5", cf, ( 47818, 11759, 614.32 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Cleanup_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 5000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_camp_cs";
    s.activity_bundle = "sat_activitydefinition_merccamp";
    s.name = "MERC_CAMP_Q2_COLOSSEUM_INTERSECTION";
    fe [[ f ]]( s, "MERC_CAMP_Q2_COLOSSEUM_INTERSECTION", cf, ( 36515.2, 30035.4, 1234.09 ), ( 0, 333.36, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_camp_cs";
    s.groupid = "reinforcement_spawn_point";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "camp_reinforce_heli";
    s.variantname = "ai_encounter_spawnpoint";
    s.var_4501e0172e168ddf = "MERC_CAMP_Q2_COLOSSEUM_INTERSECTION_VTOL";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "MERC_CAMP_Q2_COLOSSEUM_INTERSECTION", cf, ( 36526.7, 30563.9, 1273.49 ), ( 0, 277.41, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_camp_cs";
    fe [[ f ]]( s, "MERC_CAMP_Q2_COLOSSEUM_INTERSECTION", cf, ( 36599.1, 30011.3, 1227.46 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Awareness_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 4000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_camp_cs";
    fe [[ f ]]( s, "MERC_CAMP_Q2_COLOSSEUM_INTERSECTION", cf, ( 36599.1, 30011.3, 1227.46 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Ambient_AI_Exclusion_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 1800 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_camp_cs";
    fe [[ f ]]( s, "MERC_CAMP_Q2_COLOSSEUM_INTERSECTION", cf, ( 36599.1, 30011.3, 1227.46 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Cleanup_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 5000 );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace mp_sat_avalon_q2_ob_activity_merc_camp_cs
// Params 0, eflags: 0x4
// Checksum 0x92cd4aa1, Offset: 0x3aca
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace mp_sat_avalon_q2_ob_activity_merc_camp_cs
// Params 0
// Checksum 0x6f76cdbb, Offset: 0x3ad4
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "mp_sat_avalon_q2_ob_activity_merc_camp_cs" );
}

// Namespace mp_sat_avalon_q2_ob_activity_merc_camp_cs
// Params 0
// Checksum 0x99ca6c03, Offset: 0x3aea
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

// Namespace mp_sat_avalon_q2_ob_activity_merc_camp_cs
// Params 4
// Checksum 0x82b5f90, Offset: 0x3b59
// Size: 0x15b
function function_d4323822d7042e5a( var_4312b79c960726b6, fe, us, cf = "mp_sat_avalon_q2_ob_activity_merc_camp_cs" )
{
    switch ( var_4312b79c960726b6 )
    {
        case #"hash_28428686cb2f7e37":
            function_5017cc1b5a3c9fcf( fe, us, cf );
            break;
        case #"hash_901959af6e4b90bf":
            function_478acc590f11f707( fe, us, cf );
            break;
        case #"hash_70513148db0839ce":
            function_5dd0fcadd66f6d66( fe, us, cf );
            break;
        case #"hash_76003bc9f182988b":
            function_92679359a6d2be93( fe, us, cf );
            break;
        case #"hash_c560ee0d9614174d":
            function_d5fd164c3606cba5( fe, us, cf );
            break;
        case #"hash_cc761c647c70c78a":
            function_1216002e5f77fd92( fe, us, cf );
            break;
        case #"hash_1664c92905d90c8a":
            function_9e7494c83b6695d2( fe, us, cf );
            break;
        case #"hash_1664c32905d90318":
            function_9e748ec83b6688a0( fe, us, cf );
            break;
        case #"hash_1664c42905d904ab":
            function_9e748fc83b668ad3( fe, us, cf );
            break;
        case #"hash_1664ca2905d90e1d":
            function_9e7495c83b669805( fe, us, cf );
            break;
        case #"hash_3135eb855f0e2819":
            function_31e53e2a4be52b31( fe, us, cf );
            break;
    }
}

// Namespace mp_sat_avalon_q2_ob_activity_merc_camp_cs
// Params 3
// Checksum 0x7457daae, Offset: 0x3cbc
// Size: 0x610
function function_5017cc1b5a3c9fcf( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_camp_cs";
    s.name = "loot_cache";
    fe [[ f ]]( s, "MERC_CAMP_Q2_TUNNEL_INTERSECTION", cf, ( 16334.8, 4327.45, 748.48 ), ( 0, 109.31, 0 ), "s_merc_camp_cache", undefined, undefined, undefined, "link_merc_camp", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_camp_cs";
    s.name = "vehicle";
    fe [[ f ]]( s, "MERC_CAMP_Q2_TUNNEL_INTERSECTION", cf, ( 16337.1, 3191.43, 936.96 ), ( 14.44, 88.08, 1.12 ), "s_merc_camp_vehicle", undefined, undefined, undefined, "link_merc_camp", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_camp_cs";
    s.name = "sentry";
    fe [[ f ]]( s, "MERC_CAMP_Q2_TUNNEL_INTERSECTION", cf, ( 16768.1, 4789.74, 764.63 ), ( 0, 344.83, 0 ), "s_merc_camp_sentry", undefined, undefined, undefined, "link_merc_camp", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_camp_cs";
    s.name = "sentry";
    fe [[ f ]]( s, "MERC_CAMP_Q2_TUNNEL_INTERSECTION", cf, ( 15918.1, 3666.24, 756.63 ), ( 0, 160.28, 0 ), "s_merc_camp_sentry", undefined, undefined, undefined, "link_merc_camp", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_camp_cs";
    s.name = "center_struct";
    fe [[ f ]]( s, "MERC_CAMP_Q2_TUNNEL_INTERSECTION", cf, ( 16397.8, 4253.51, 748.81 ), ( 0, 0, 0 ), "MERC_CAMP_Q2_TUNNEL_INTERSECTION", undefined, "MERC_CAMP_Q2_TUNNEL_INTERSECTION", "link_merc_camp", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 1500 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_camp_cs";
    s.name = "guard";
    fe [[ f ]]( s, "MERC_CAMP_Q2_TUNNEL_INTERSECTION", cf, ( 16384.2, 4227.74, 774.51 ), ( 0, 0, 0 ), "s_merc_camp_guard", undefined, undefined, undefined, "link_merc_camp", ( 0, 0, 0 ), ( 0, 0, 0 ), 250 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_camp_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    s.script_accel = "350";
    fe [[ f ]]( s, "MERC_CAMP_Q2_TUNNEL_INTERSECTION", cf, ( 15761.1, 4191.92, 1369.94 ), ( 0, 336.76, 0 ), "MERC_CAMP_Q2_TUNNEL_INTERSECTION_VTOL", "cspf_12_auto1348001414350091625", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_camp_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MERC_CAMP_Q2_TUNNEL_INTERSECTION", cf, ( 32454, -5019.91, 8516.02 ), ( 359.47, 5.01, 0.49 ), "cspf_12_auto14185502219864508682", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_camp_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MERC_CAMP_Q2_TUNNEL_INTERSECTION", cf, ( 5273.54, 14194.8, 7720.77 ), ( 0, 296.73, 0 ), undefined, "cspf_12_auto6309848722971406541", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150, 1 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_camp_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MERC_CAMP_Q2_TUNNEL_INTERSECTION", cf, ( 23086.2, 2067.98, 5621.02 ), ( 359.47, 5.01, 0.49 ), "cspf_12_auto1348001414350091625", "cspf_12_auto14185502219864508682", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_camp_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MERC_CAMP_Q2_TUNNEL_INTERSECTION", cf, ( 9397.77, 8598.92, 6643.27 ), ( 0, 337.25, 0 ), "cspf_12_auto6309848722971406541", "MERC_CAMP_Q2_TUNNEL_INTERSECTION_VTOL", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_camp_cs";
    s.name = "killstreak_support";
    fe [[ f ]]( s, "MERC_CAMP_Q2_TUNNEL_INTERSECTION", cf, ( 16967.7, 4417.24, 774.51 ), ( 0, 0, 0 ), undefined, undefined, "killstreak_support", undefined, "link_merc_camp", ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_sat_avalon_q2_ob_activity_merc_camp_cs
// Params 3
// Checksum 0x2b0ad432, Offset: 0x42d4
// Size: 0x610
function function_478acc590f11f707( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_camp_cs";
    s.name = "center_struct";
    fe [[ f ]]( s, "MERC_CAMP_Q2_WINERY", cf, ( 24977.5, 44390.6, 1253.62 ), ( 0, 0, 0 ), "MERC_CAMP_Q2_WINERY", undefined, "MERC_CAMP_Q2_WINERY", "link_merc_camp", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 1500 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_camp_cs";
    s.name = "guard";
    fe [[ f ]]( s, "MERC_CAMP_Q2_WINERY", cf, ( 24913.9, 44370.9, 1253.31 ), ( 0, 0, 0 ), "s_merc_camp_guard", undefined, undefined, undefined, "link_merc_camp", ( 0, 0, 0 ), ( 0, 0, 0 ), 250 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_camp_cs";
    s.name = "loot_cache";
    fe [[ f ]]( s, "MERC_CAMP_Q2_WINERY", cf, ( 24823, 44332.3, 1235.92 ), ( 359.38, 247.78, 7.09 ), "s_merc_camp_cache", undefined, undefined, undefined, "link_merc_camp", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_camp_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    s.script_accel = "350";
    fe [[ f ]]( s, "MERC_CAMP_Q2_WINERY", cf, ( 24859.6, 44898.9, 1939.44 ), ( 0, 336.76, 0 ), "MERC_CAMP_Q2_WINERY_VTOL", "cspf_13_auto18383355014983565459", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_camp_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MERC_CAMP_Q2_WINERY", cf, ( 41552.5, 35687.1, 9085.52 ), ( 359.47, 5.01, 0.49 ), "cspf_13_auto10034459182868780435", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_camp_cs";
    s.name = "vehicle";
    fe [[ f ]]( s, "MERC_CAMP_Q2_WINERY", cf, ( 24125, 44829.1, 1136.54 ), ( 358.98, 231.39, -0.76 ), "s_merc_camp_vehicle", undefined, undefined, undefined, "link_merc_camp", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_camp_cs";
    s.name = "sentry";
    fe [[ f ]]( s, "MERC_CAMP_Q2_WINERY", cf, ( 24204, 44108.6, 1161.22 ), ( 0, 125.82, 0 ), "s_merc_camp_sentry", undefined, undefined, undefined, "link_merc_camp", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_camp_cs";
    s.name = "sentry";
    fe [[ f ]]( s, "MERC_CAMP_Q2_WINERY", cf, ( 25568.4, 44185.1, 1279.77 ), ( 0, 344.27, 0 ), "s_merc_camp_sentry", undefined, undefined, undefined, "link_merc_camp", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_camp_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MERC_CAMP_Q2_WINERY", cf, ( 11014.3, 55045.3, 8290.27 ), ( 0, 292.46, 0 ), undefined, "cspf_13_auto13849803540042554483", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150, 1 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_camp_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MERC_CAMP_Q2_WINERY", cf, ( 32184.7, 42775, 6190.52 ), ( 359.47, 5.01, 0.49 ), "cspf_13_auto18383355014983565459", "cspf_13_auto10034459182868780435", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_camp_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MERC_CAMP_Q2_WINERY", cf, ( 17359.8, 50448.7, 7212.77 ), ( 0, 329.75, 0 ), "cspf_13_auto13849803540042554483", "MERC_CAMP_Q2_WINERY_VTOL", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_camp_cs";
    s.name = "killstreak_support";
    fe [[ f ]]( s, "MERC_CAMP_Q2_WINERY", cf, ( 24097.4, 44532.4, 1152.69 ), ( 0, 0, 0 ), undefined, undefined, "killstreak_support", undefined, "link_merc_camp", ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_sat_avalon_q2_ob_activity_merc_camp_cs
// Params 3
// Checksum 0xb91cdacb, Offset: 0x48ec
// Size: 0x610
function function_5dd0fcadd66f6d66( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_camp_cs";
    s.name = "center_struct";
    fe [[ f ]]( s, "MERC_CAMP_Q2_RURAL_VILLAGE", cf, ( 14654.9, 30961.7, 1924.37 ), ( 0, 0, 0 ), "MERC_CAMP_Q2_RURAL_VILLAGE", undefined, "MERC_CAMP_Q2_RURAL_VILLAGE", "link_merc_camp", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 1500 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_camp_cs";
    s.name = "guard";
    fe [[ f ]]( s, "MERC_CAMP_Q2_RURAL_VILLAGE", cf, ( 14591.3, 30942, 1924.06 ), ( 0, 0, 0 ), "s_merc_camp_guard", undefined, undefined, undefined, "link_merc_camp", ( 0, 0, 0 ), ( 0, 0, 0 ), 250 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_camp_cs";
    s.name = "loot_cache";
    fe [[ f ]]( s, "MERC_CAMP_Q2_RURAL_VILLAGE", cf, ( 14584.2, 30792.1, 1914.69 ), ( 0, 319.89, 0 ), "s_merc_camp_cache", undefined, undefined, undefined, "link_merc_camp", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_camp_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    s.script_accel = "350";
    fe [[ f ]]( s, "MERC_CAMP_Q2_RURAL_VILLAGE", cf, ( 14147.4, 31185.5, 2653.44 ), ( 0, 221.75, 0 ), "MERC_CAMP_Q2_RURAL_VILLAGE_VTOL", "cspf_14_auto8812174916234186829", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_camp_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MERC_CAMP_Q2_RURAL_VILLAGE", cf, ( -1258.1, 19952.4, 9799.52 ), ( 359.47, 250, 0.5 ), "cspf_14_auto18016548409378499654", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_camp_cs";
    s.name = "vehicle";
    fe [[ f ]]( s, "MERC_CAMP_Q2_RURAL_VILLAGE", cf, ( 13850, 30884.1, 1999.25 ), ( 351.15, 121.64, 7.1 ), "s_merc_camp_vehicle", undefined, undefined, undefined, "link_merc_camp", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_camp_cs";
    s.name = "sentry";
    fe [[ f ]]( s, "MERC_CAMP_Q2_RURAL_VILLAGE", cf, ( 14166, 30544.8, 1922.62 ), ( 0, 175.32, 0 ), "s_merc_camp_sentry", undefined, undefined, undefined, "link_merc_camp", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_camp_cs";
    s.name = "sentry";
    fe [[ f ]]( s, "MERC_CAMP_Q2_RURAL_VILLAGE", cf, ( 14988.9, 31279.5, 1951.78 ), ( 0, 344.27, 0 ), "s_merc_camp_sentry", undefined, undefined, undefined, "link_merc_camp", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_camp_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MERC_CAMP_Q2_RURAL_VILLAGE", cf, ( 29195.9, 39442.9, 9004.27 ), ( 0, 177.46, 0 ), undefined, "cspf_14_auto12556847106574300262", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150, 1 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_camp_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MERC_CAMP_Q2_RURAL_VILLAGE", cf, ( 9125.7, 25445.2, 6904.52 ), ( 359.47, 250, 0.5 ), "cspf_14_auto8812174916234186829", "cspf_14_auto18016548409378499654", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_camp_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MERC_CAMP_Q2_RURAL_VILLAGE", cf, ( 22347.5, 35635.7, 7926.77 ), ( 0, 214.74, 0 ), "cspf_14_auto12556847106574300262", "MERC_CAMP_Q2_RURAL_VILLAGE_VTOL", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_camp_cs";
    s.name = "killstreak_support";
    fe [[ f ]]( s, "MERC_CAMP_Q2_RURAL_VILLAGE", cf, ( 15112.3, 31330.5, 1967.67 ), ( 0, 0, 0 ), undefined, undefined, "killstreak_support", undefined, "link_merc_camp", ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_sat_avalon_q2_ob_activity_merc_camp_cs
// Params 3
// Checksum 0xe4f7163e, Offset: 0x4f04
// Size: 0x621
function function_92679359a6d2be93( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_camp_cs";
    s.name = "center_struct";
    s.script_parameters = "only_props";
    fe [[ f ]]( s, "MERC_CAMP_Q2_COLOSSEUM", cf, ( 48074.5, 28058.8, 909.41 ), ( 0, 0, 0 ), "MERC_CAMP_Q2_COLOSSEUM", undefined, "MERC_CAMP_Q2_COLOSSEUM", "link_merc_camp", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 1500 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_camp_cs";
    s.name = "guard";
    fe [[ f ]]( s, "MERC_CAMP_Q2_COLOSSEUM", cf, ( 48010.9, 28039.1, 909.1 ), ( 0, 0, 0 ), "s_merc_camp_guard", undefined, undefined, undefined, "link_merc_camp", ( 0, 0, 0 ), ( 0, 0, 0 ), 250 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_camp_cs";
    s.name = "loot_cache";
    fe [[ f ]]( s, "MERC_CAMP_Q2_COLOSSEUM", cf, ( 47811.8, 27946.5, 897.42 ), ( 0, 58.88, 0 ), "s_merc_camp_cache", undefined, undefined, undefined, "link_merc_camp", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_camp_cs";
    s.name = "vehicle";
    fe [[ f ]]( s, "MERC_CAMP_Q2_COLOSSEUM", cf, ( 47007, 28235.1, 886.42 ), ( 1.23, 138.31, 3.59 ), "s_merc_camp_vehicle", undefined, undefined, undefined, "link_merc_camp", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_camp_cs";
    s.name = "sentry";
    fe [[ f ]]( s, "MERC_CAMP_Q2_COLOSSEUM", cf, ( 47840.1, 28562.3, 894.85 ), ( 0, 172.4, 0 ), "s_merc_camp_sentry", undefined, undefined, undefined, "link_merc_camp", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_camp_cs";
    s.name = "sentry";
    fe [[ f ]]( s, "MERC_CAMP_Q2_COLOSSEUM", cf, ( 48382.1, 27444.9, 907.55 ), ( 0, 344.27, 0 ), "s_merc_camp_sentry", undefined, undefined, undefined, "link_merc_camp", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_camp_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    s.script_accel = "350";
    fe [[ f ]]( s, "MERC_CAMP_Q2_COLOSSEUM", cf, ( 47829.5, 29079.8, 1523.94 ), ( 0, 266.05, 0 ), "MERC_CAMP_Q2_COLOSSEUM_VTOL", "cspf_15_auto2757813688095963241", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_camp_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MERC_CAMP_Q2_COLOSSEUM", cf, ( 66586.6, 22942.8, 8747.52 ), ( 359.47, 325.57, 0.5 ), "cspf_15_auto3352253329661919716", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_camp_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MERC_CAMP_Q2_COLOSSEUM", cf, ( 52150.3, 43128.3, 7952.27 ), ( 0, 192.9, 0 ), undefined, "cspf_15_auto8251734904989672413", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150, 1 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_camp_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MERC_CAMP_Q2_COLOSSEUM", cf, ( 50534.4, 21959.8, 5852.52 ), ( 359.47, 325.57, 0.5 ), "cspf_15_auto2757813688095963241", "cspf_15_auto3352253329661919716", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_camp_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MERC_CAMP_Q2_COLOSSEUM", cf, ( 48674.5, 37279.3, 6874.77 ), ( 0, 290.32, 0 ), "cspf_15_auto8251734904989672413", "MERC_CAMP_Q2_COLOSSEUM_VTOL", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_camp_cs";
    s.name = "killstreak_support";
    fe [[ f ]]( s, "MERC_CAMP_Q2_COLOSSEUM", cf, ( 48388.9, 28244.1, 901.61 ), ( 0, 0, 0 ), undefined, undefined, "killstreak_support", undefined, "link_merc_camp", ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_sat_avalon_q2_ob_activity_merc_camp_cs
// Params 3
// Checksum 0xf29731f3, Offset: 0x552d
// Size: 0x621
function function_d5fd164c3606cba5( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_camp_cs";
    s.name = "center_struct";
    s.script_parameters = "only_props";
    fe [[ f ]]( s, "MERC_CAMP_Q2_ROMAN_CANALS", cf, ( 33232.2, 17196.4, 1197.43 ), ( 0, 0, 0 ), "MERC_CAMP_Q2_ROMAN_CANALS", undefined, "MERC_CAMP_Q2_ROMAN_CANALS", "link_merc_camp", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 1500 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_camp_cs";
    s.name = "guard";
    fe [[ f ]]( s, "MERC_CAMP_Q2_ROMAN_CANALS", cf, ( 33526.9, 17460.3, 1212.55 ), ( 0, 0, 0 ), "s_merc_camp_guard", undefined, undefined, undefined, "link_merc_camp", ( 0, 0, 0 ), ( 0, 0, 0 ), 250 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_camp_cs";
    s.name = "loot_cache";
    fe [[ f ]]( s, "MERC_CAMP_Q2_ROMAN_CANALS", cf, ( 33700.5, 17514.2, 1215.82 ), ( 359.71, 321.58, 3.22 ), "s_merc_camp_cache", undefined, undefined, undefined, "link_merc_camp", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_camp_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    s.script_accel = "350";
    fe [[ f ]]( s, "MERC_CAMP_Q2_ROMAN_CANALS", cf, ( 34085.4, 17828.5, 1876.94 ), ( 0, 221.75, 0 ), "MERC_CAMP_Q2_ROMAN_CANALS_VTOL", "cspf_16_auto9352307387138093830", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_camp_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MERC_CAMP_Q2_ROMAN_CANALS", cf, ( 17775.4, 6545.9, 9100.52 ), ( 359.47, 250, 0.5 ), "cspf_16_auto7791723373201614326", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_camp_cs";
    s.name = "vehicle";
    fe [[ f ]]( s, "MERC_CAMP_Q2_ROMAN_CANALS", cf, ( 32620.4, 16501.1, 1092.76 ), ( 351.8, 227.91, -2.69 ), "s_merc_camp_vehicle", undefined, undefined, undefined, "link_merc_camp", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_camp_cs";
    s.name = "sentry";
    fe [[ f ]]( s, "MERC_CAMP_Q2_ROMAN_CANALS", cf, ( 33787.5, 17754.6, 1230.7 ), ( 0, 47.36, 0 ), "s_merc_camp_sentry", undefined, undefined, undefined, "link_merc_camp", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_camp_cs";
    s.name = "sentry";
    fe [[ f ]]( s, "MERC_CAMP_Q2_ROMAN_CANALS", cf, ( 33228.2, 16957.7, 1189.37 ), ( 0, 251.97, 0 ), "s_merc_camp_sentry", undefined, undefined, undefined, "link_merc_camp", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_camp_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MERC_CAMP_Q2_ROMAN_CANALS", cf, ( 48229.4, 26036.4, 8305.27 ), ( 0, 177.46, 0 ), undefined, "cspf_16_auto13483103722186739755", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150, 1 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_camp_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MERC_CAMP_Q2_ROMAN_CANALS", cf, ( 28159.2, 12038.7, 6205.52 ), ( 359.47, 250, 0.5 ), "cspf_16_auto9352307387138093830", "cspf_16_auto7791723373201614326", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_camp_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MERC_CAMP_Q2_ROMAN_CANALS", cf, ( 41381, 22229.2, 7227.77 ), ( 0, 214.74, 0 ), "cspf_16_auto13483103722186739755", "MERC_CAMP_Q2_ROMAN_CANALS_VTOL", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_camp_cs";
    s.name = "killstreak_support";
    fe [[ f ]]( s, "MERC_CAMP_Q2_ROMAN_CANALS", cf, ( 32741.9, 17615.8, 1196.06 ), ( 0, 0, 0 ), undefined, undefined, "killstreak_support", undefined, "link_merc_camp", ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_sat_avalon_q2_ob_activity_merc_camp_cs
// Params 3
// Checksum 0xfc07cdbd, Offset: 0x5b56
// Size: 0x610
function function_1216002e5f77fd92( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_camp_cs";
    s.name = "center_struct";
    fe [[ f ]]( s, "MERC_CAMP_Q2_CLIFF_TOWN_01", cf, ( 49087.7, 8065.44, 1300.58 ), ( 0, 0, 0 ), "MERC_CAMP_Q2_CLIFF_TOWN_01", undefined, "MERC_CAMP_Q2_CLIFF_TOWN_01", "link_merc_camp", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 1500 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_camp_cs";
    s.name = "guard";
    fe [[ f ]]( s, "MERC_CAMP_Q2_CLIFF_TOWN_01", cf, ( 49569.8, 7341.74, 996.36 ), ( 0, 0, 0 ), "s_merc_camp_guard", undefined, undefined, undefined, "link_merc_camp", ( 0, 0, 0 ), ( 0, 0, 0 ), 250 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_camp_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    s.script_accel = "350";
    fe [[ f ]]( s, "MERC_CAMP_Q2_CLIFF_TOWN_01", cf, ( 49180, 7516.8, 1629.94 ), ( 0, 266.05, 0 ), "MERC_CAMP_Q2_CLIFF_TOWN_01_VTOL", "cspf_17_auto9023785895727161211", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_camp_cs";
    s.name = "loot_cache";
    fe [[ f ]]( s, "MERC_CAMP_Q2_CLIFF_TOWN_01", cf, ( 49516.5, 7518, 1004.36 ), ( 0.27, 162.31, -2.82 ), "s_merc_camp_cache", undefined, undefined, undefined, "link_merc_camp", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_camp_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MERC_CAMP_Q2_CLIFF_TOWN_01", cf, ( 67937.1, 1379.81, 8853.52 ), ( 359.47, 325.57, 0.5 ), "cspf_17_auto15571035527219842457", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_camp_cs";
    s.name = "vehicle";
    fe [[ f ]]( s, "MERC_CAMP_Q2_CLIFF_TOWN_01", cf, ( 49585.4, 8553.27, 1127.11 ), ( 351.8, 52.76, -2.69 ), "s_merc_camp_vehicle", undefined, undefined, undefined, "link_merc_camp", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_camp_cs";
    s.name = "sentry";
    fe [[ f ]]( s, "MERC_CAMP_Q2_CLIFF_TOWN_01", cf, ( 48816.5, 7882.12, 1059.68 ), ( 0, 290.74, 0 ), "s_merc_camp_cache", undefined, undefined, undefined, "link_merc_camp", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_camp_cs";
    s.name = "sentry";
    fe [[ f ]]( s, "MERC_CAMP_Q2_CLIFF_TOWN_01", cf, ( 49393.2, 6691.96, 966.28 ), ( 0, 251.97, 0 ), "s_merc_camp_sentry", undefined, undefined, undefined, "link_merc_camp", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_camp_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MERC_CAMP_Q2_CLIFF_TOWN_01", cf, ( 53500.8, 21565.3, 8058.27 ), ( 0, 251.83, 0 ), undefined, "cspf_17_auto7597733879554036493", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150, 1 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_camp_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MERC_CAMP_Q2_CLIFF_TOWN_01", cf, ( 53332.4, 3036.3, 5958.52 ), ( 359.47, 325.57, 0.5 ), "cspf_17_auto9023785895727161211", "cspf_17_auto15571035527219842457", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_camp_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MERC_CAMP_Q2_CLIFF_TOWN_01", cf, ( 52449.5, 15297.8, 6980.77 ), ( 0, 290.32, 0 ), "cspf_17_auto7597733879554036493", "MERC_CAMP_Q2_CLIFF_TOWN_01_VTOL", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_camp_cs";
    s.name = "killstreak_support";
    fe [[ f ]]( s, "MERC_CAMP_Q2_CLIFF_TOWN_01", cf, ( 49689.3, 7702.74, 1027.29 ), ( 0, 0, 0 ), undefined, undefined, "killstreak_support", undefined, "link_merc_camp", ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_sat_avalon_q2_ob_activity_merc_camp_cs
// Params 3
// Checksum 0x2ff1aee1, Offset: 0x616e
// Size: 0x2f8
function function_9e7494c83b6695d2( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_camp_cs";
    s.name = "loot_cache";
    fe [[ f ]]( s, "MERC_CAMP_Q2_CLIFFTOWN_SQUAD4", cf, ( 45797.8, 3920.11, 908.92 ), ( 3.94, 107.35, 4.27 ), "s_merc_camp_cache", undefined, undefined, undefined, "link_merc_camp", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_camp_cs";
    s.name = "killstreak_support";
    fe [[ f ]]( s, "MERC_CAMP_Q2_CLIFFTOWN_SQUAD4", cf, ( 45990.7, 4231.1, 870.8 ), ( 0, 0, 0 ), undefined, undefined, "killstreak_support", undefined, "link_merc_camp", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_camp_cs";
    s.name = "center_struct";
    fe [[ f ]]( s, "MERC_CAMP_Q2_CLIFFTOWN_SQUAD4", cf, ( 46018.2, 3731.41, 1250 ), ( 0, 0, 0 ), "MERC_CAMP_Q2_CLIFFTOWN_SQUAD4", undefined, "MERC_CAMP_Q2_CLIFFTOWN_SQUAD4", "link_merc_camp", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 1500 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_camp_cs";
    s.name = "guard";
    fe [[ f ]]( s, "MERC_CAMP_Q2_CLIFFTOWN_SQUAD4", cf, ( 45934.2, 3837.6, 908.68 ), ( 0, 0, 0 ), "s_merc_camp_guard", undefined, undefined, undefined, "link_merc_camp", ( 0, 0, 0 ), ( 0, 0, 0 ), 250 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_camp_cs";
    s.name = "vehicle";
    fe [[ f ]]( s, "MERC_CAMP_Q2_CLIFFTOWN_SQUAD4", cf, ( 45549.4, 3240.52, 931.4 ), ( 0, 193.77, 0 ), "s_merc_camp_vehicle", undefined, undefined, undefined, "link_merc_camp", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_camp_cs";
    s.name = "sentry";
    fe [[ f ]]( s, "MERC_CAMP_Q2_CLIFFTOWN_SQUAD4", cf, ( 46078.4, 3844.49, 915.08 ), ( 0, 15.34, 0 ), "s_merc_camp_sentry", undefined, undefined, undefined, "link_merc_camp", ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_sat_avalon_q2_ob_activity_merc_camp_cs
// Params 3
// Checksum 0xfbd0f215, Offset: 0x646e
// Size: 0x2f8
function function_9e748ec83b6688a0( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_camp_cs";
    s.name = "loot_cache";
    fe [[ f ]]( s, "MERC_CAMP_Q2_CLIFFTOWN_SQUAD2", cf, ( 39995.6, 3615, 1079.53 ), ( 0.36, 251.55, 3.34 ), "s_merc_camp_cache", undefined, undefined, undefined, "link_merc_camp", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_camp_cs";
    s.name = "killstreak_support";
    fe [[ f ]]( s, "MERC_CAMP_Q2_CLIFFTOWN_SQUAD2", cf, ( 40414.6, 3415.91, 1105.36 ), ( 0, 0, 0 ), undefined, undefined, "killstreak_support", undefined, "link_merc_camp", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_camp_cs";
    s.name = "center_struct";
    fe [[ f ]]( s, "MERC_CAMP_Q2_CLIFFTOWN_SQUAD2", cf, ( 39765.3, 3432.26, 1594.48 ), ( 0, 0, 0 ), "MERC_CAMP_Q2_CLIFFTOWN_SQUAD2", undefined, "MERC_CAMP_Q2_CLIFFTOWN_SQUAD2", "link_merc_camp", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 1500 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_camp_cs";
    s.name = "guard";
    fe [[ f ]]( s, "MERC_CAMP_Q2_CLIFFTOWN_SQUAD2", cf, ( 39901.6, 3746.91, 1072 ), ( 0, 0, 0 ), "s_merc_camp_guard", undefined, undefined, undefined, "link_merc_camp", ( 0, 0, 0 ), ( 0, 0, 0 ), 250 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_camp_cs";
    s.name = "vehicle";
    fe [[ f ]]( s, "MERC_CAMP_Q2_CLIFFTOWN_SQUAD2", cf, ( 39704.1, 2274.34, 988.54 ), ( 6.5, 263.05, 0 ), "s_merc_camp_vehicle", undefined, undefined, undefined, "link_merc_camp", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_camp_cs";
    s.name = "sentry";
    fe [[ f ]]( s, "MERC_CAMP_Q2_CLIFFTOWN_SQUAD2", cf, ( 40334.6, 3580.76, 1098.68 ), ( 0, 251.14, 0 ), "s_merc_camp_sentry", undefined, undefined, undefined, "link_merc_camp", ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_sat_avalon_q2_ob_activity_merc_camp_cs
// Params 3
// Checksum 0x31c00f7c, Offset: 0x676e
// Size: 0x2f8
function function_9e748fc83b668ad3( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_camp_cs";
    s.name = "loot_cache";
    fe [[ f ]]( s, "MERC_CAMP_Q2_CLIFFTOWN_SQUAD3", cf, ( 41854.3, 2919.31, 1113.9 ), ( 359.85, 83.86, 6.44 ), "s_merc_camp_cache", undefined, undefined, undefined, "link_merc_camp", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_camp_cs";
    s.name = "killstreak_support";
    fe [[ f ]]( s, "MERC_CAMP_Q2_CLIFFTOWN_SQUAD3", cf, ( 41465.4, 3152.97, 1132.5 ), ( 0, 0, 0 ), undefined, undefined, "killstreak_support", undefined, "link_merc_camp", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_camp_cs";
    s.name = "center_struct";
    fe [[ f ]]( s, "MERC_CAMP_Q2_CLIFFTOWN_SQUAD3", cf, ( 42177.7, 3091.33, 1450 ), ( 0, 0, 0 ), "MERC_CAMP_Q2_CLIFFTOWN_SQUAD3", undefined, "MERC_CAMP_Q2_CLIFFTOWN_SQUAD3", "link_merc_camp", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 1500 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_camp_cs";
    s.name = "guard";
    fe [[ f ]]( s, "MERC_CAMP_Q2_CLIFFTOWN_SQUAD3", cf, ( 41899.9, 2805.47, 1096.95 ), ( 0, 0, 0 ), "s_merc_camp_guard", undefined, undefined, undefined, "link_merc_camp", ( 0, 0, 0 ), ( 0, 0, 0 ), 250 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_camp_cs";
    s.name = "vehicle";
    fe [[ f ]]( s, "MERC_CAMP_Q2_CLIFFTOWN_SQUAD3", cf, ( 43120.5, 2834.65, 916.49 ), ( 3.67, 1.82, 0.92 ), "s_merc_camp_vehicle", undefined, undefined, undefined, "link_merc_camp", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_camp_cs";
    s.name = "sentry";
    fe [[ f ]]( s, "MERC_CAMP_Q2_CLIFFTOWN_SQUAD3", cf, ( 42652.5, 3264.89, 981.75 ), ( 358.47, 259.55, -8.26 ), "s_merc_camp_sentry", undefined, undefined, undefined, "link_merc_camp", ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_sat_avalon_q2_ob_activity_merc_camp_cs
// Params 3
// Checksum 0xda40e5b6, Offset: 0x6a6e
// Size: 0x2f8
function function_9e7495c83b669805( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_camp_cs";
    s.name = "loot_cache";
    fe [[ f ]]( s, "MERC_CAMP_Q2_CLIFFTOWN_SQUAD5", cf, ( 48086.3, 11833, 613.72 ), ( 0, 187.48, 0 ), "s_merc_camp_cache", undefined, undefined, undefined, "link_merc_camp", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_camp_cs";
    s.name = "killstreak_support";
    fe [[ f ]]( s, "MERC_CAMP_Q2_CLIFFTOWN_SQUAD5", cf, ( 47901.6, 11942.5, 613.88 ), ( 0, 0, 0 ), undefined, undefined, "killstreak_support", undefined, "link_merc_camp", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_camp_cs";
    s.name = "center_struct";
    fe [[ f ]]( s, "MERC_CAMP_Q2_CLIFFTOWN_SQUAD5", cf, ( 47896.5, 11764, 900.02 ), ( 0, 0, 0 ), "MERC_CAMP_Q2_CLIFFTOWN_SQUAD5", undefined, "MERC_CAMP_Q2_CLIFFTOWN_SQUAD5", "link_merc_camp", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 1500 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_camp_cs";
    s.name = "guard";
    fe [[ f ]]( s, "MERC_CAMP_Q2_CLIFFTOWN_SQUAD5", cf, ( 48193.1, 11780, 613.79 ), ( 0, 0, 0 ), "s_merc_camp_guard", undefined, undefined, undefined, "link_merc_camp", ( 0, 0, 0 ), ( 0, 0, 0 ), 250 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_camp_cs";
    s.name = "vehicle";
    fe [[ f ]]( s, "MERC_CAMP_Q2_CLIFFTOWN_SQUAD5", cf, ( 47666.4, 12619.7, 616.55 ), ( 1.08, 342.08, -0.18 ), "s_merc_camp_vehicle", undefined, undefined, undefined, "link_merc_camp", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_camp_cs";
    s.name = "sentry";
    fe [[ f ]]( s, "MERC_CAMP_Q2_CLIFFTOWN_SQUAD5", cf, ( 47602.1, 11900.8, 621 ), ( 0, 275.55, 0 ), "s_merc_camp_sentry", undefined, undefined, undefined, "link_merc_camp", ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_sat_avalon_q2_ob_activity_merc_camp_cs
// Params 3
// Checksum 0xa7904a8a, Offset: 0x6d6e
// Size: 0x59c
function function_31e53e2a4be52b31( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_camp_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    s.script_accel = "100";
    fe [[ f ]]( s, "MERC_CAMP_Q2_COLOSSEUM_INTERSECTION", cf, ( 36549.7, 30699.5, 1904.67 ), ( 0, 266.05, 0 ), "MERC_CAMP_Q2_COLOSSEUM_INTERSECTION_VTOL", "cspf_22_auto2757813688095963241", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_camp_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MERC_CAMP_Q2_COLOSSEUM_INTERSECTION", cf, ( 52513.6, 39852.8, 2449.65 ), ( 359.47, 325.57, 0.5 ), "cspf_22_auto3352253329661919716", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_camp_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MERC_CAMP_Q2_COLOSSEUM_INTERSECTION", cf, ( 46093.7, 52975, 8333.01 ), ( 0, 223.7, 0 ), undefined, "cspf_22_auto8251734904989672413", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150, 1 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_camp_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MERC_CAMP_Q2_COLOSSEUM_INTERSECTION", cf, ( 38624.9, 30687.2, 1971.27 ), ( 359.47, 325.57, 0.5 ), "cspf_22_auto2757813688095963241", "cspf_22_auto3352253329661919716", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_camp_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MERC_CAMP_Q2_COLOSSEUM_INTERSECTION", cf, ( 37394.7, 38899, 7255.51 ), ( 0, 290.32, 0 ), "cspf_22_auto8251734904989672413", "MERC_CAMP_Q2_COLOSSEUM_INTERSECTION_VTOL", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_camp_cs";
    s.name = "killstreak_support";
    fe [[ f ]]( s, "MERC_CAMP_Q2_COLOSSEUM_INTERSECTION", cf, ( 36324.4, 29341.3, 1222.22 ), ( 0, 0, 0 ), undefined, undefined, "killstreak_support", undefined, "link_merc_camp", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_camp_cs";
    s.name = "center_struct";
    fe [[ f ]]( s, "MERC_CAMP_Q2_COLOSSEUM_INTERSECTION", cf, ( 36599.1, 30011.3, 1227.46 ), ( 0, 0, 0 ), "MERC_CAMP_Q2_COLOSSEUM_INTERSECTION", undefined, "MERC_CAMP_Q2_COLOSSEUM_INTERSECTION", "link_merc_camp", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 1500 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_camp_cs";
    s.name = "guard";
    fe [[ f ]]( s, "MERC_CAMP_Q2_COLOSSEUM_INTERSECTION", cf, ( 36638.9, 29255.8, 1224.48 ), ( 0, 0, 0 ), "s_merc_camp_guard", undefined, undefined, undefined, "link_merc_camp", ( 0, 0, 0 ), ( 0, 0, 0 ), 250 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_camp_cs";
    s.name = "vehicle";
    fe [[ f ]]( s, "MERC_CAMP_Q2_COLOSSEUM_INTERSECTION", cf, ( 36678.9, 28754.5, 1210.38 ), ( 0.61, 147.99, 3.74 ), "s_merc_camp_vehicle", undefined, undefined, undefined, "link_merc_camp", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_camp_cs";
    s.name = "sentry";
    fe [[ f ]]( s, "MERC_CAMP_Q2_COLOSSEUM_INTERSECTION", cf, ( 36746.8, 30166.9, 1223.56 ), ( 0, 114.9, 0 ), "s_merc_camp_sentry", undefined, undefined, undefined, "link_merc_camp", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_camp_cs";
    s.name = "sentry";
    fe [[ f ]]( s, "MERC_CAMP_Q2_COLOSSEUM_INTERSECTION", cf, ( 36070.4, 29089.5, 1219.46 ), ( 0, 289.97, 0 ), "s_merc_camp_sentry", undefined, undefined, undefined, "link_merc_camp", ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_sat_avalon_q2_ob_activity_merc_camp_cs
// Params 0
// Checksum 0xfa0aaf34, Offset: 0x7312
// Size: 0x964
function function_d9dd7965c51c95d1()
{
    activityinstances = [];
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_activitydefinition_merccamp";
    var_881289d7987bc770.var_7a0840be22b9ebb = "SUPPLY_DROP_CITY_LOW_TOWN_POLICESTATION";
    var_881289d7987bc770.cf = "mp_sat_avalon_q2_ob_activity_merc_camp_cs";
    var_881289d7987bc770.scriptstructorigin = ( 16374.9, 4233.67, 1097.32 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [ ( 16400.5, 4349.89, 748.95 ) ];
    var_881289d7987bc770.var_31ce4477e3543d24 = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.locationradius = [ 1350 ];
    activityinstances[ "MERC_CAMP_Q2_TUNNEL_INTERSECTION" ] = var_881289d7987bc770;
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_activitydefinition_merccamp";
    var_881289d7987bc770.var_7a0840be22b9ebb = "SUPPLY_DROP_WINERY_COURTYARD";
    var_881289d7987bc770.cf = "mp_sat_avalon_q2_ob_activity_merc_camp_cs";
    var_881289d7987bc770.scriptstructorigin = ( 24965, 44109.1, 1530.36 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [ ( 25088.6, 44387.6, 1252.17 ) ];
    var_881289d7987bc770.var_31ce4477e3543d24 = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.locationradius = [ 1350 ];
    activityinstances[ "MERC_CAMP_Q2_WINERY" ] = var_881289d7987bc770;
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_activitydefinition_merccamp";
    var_881289d7987bc770.var_7a0840be22b9ebb = "SUPPLY_DROP_WINERY";
    var_881289d7987bc770.cf = "mp_sat_avalon_q2_ob_activity_merc_camp_cs";
    var_881289d7987bc770.scriptstructorigin = ( 14954, 30831.6, 2252.31 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [ ( 14657.3, 31093.3, 1936.07 ) ];
    var_881289d7987bc770.var_31ce4477e3543d24 = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.locationradius = [ 1350 ];
    activityinstances[ "MERC_CAMP_Q2_RURAL_VILLAGE" ] = var_881289d7987bc770;
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_activitydefinition_merccamp";
    var_881289d7987bc770.var_7a0840be22b9ebb = "SUPPLY_DROP_PONY_CLUB";
    var_881289d7987bc770.cf = "mp_sat_avalon_q2_ob_activity_merc_camp_cs";
    var_881289d7987bc770.scriptstructorigin = ( 47905.5, 28165.5, 1199.47 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [ ( 47860.3, 28113.4, 911.91 ) ];
    var_881289d7987bc770.var_31ce4477e3543d24 = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.locationradius = [ 1350 ];
    activityinstances[ "MERC_CAMP_Q2_COLOSSEUM" ] = var_881289d7987bc770;
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_activitydefinition_merccamp";
    var_881289d7987bc770.var_7a0840be22b9ebb = "SUPPLY_DROP_POLICE_STATION";
    var_881289d7987bc770.cf = "mp_sat_avalon_q2_ob_activity_merc_camp_cs";
    var_881289d7987bc770.scriptstructorigin = ( 33254.9, 17454.8, 1543.45 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [ ( 33589, 17531.9, 1212.72 ) ];
    var_881289d7987bc770.var_31ce4477e3543d24 = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.locationradius = [ 1350 ];
    activityinstances[ "MERC_CAMP_Q2_ROMAN_CANALS" ] = var_881289d7987bc770;
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_activitydefinition_merccamp";
    var_881289d7987bc770.var_7a0840be22b9ebb = "SUPPLY_DROP_Q4_SHIP_YARD";
    var_881289d7987bc770.cf = "mp_sat_avalon_q2_ob_activity_merc_camp_cs";
    var_881289d7987bc770.scriptstructorigin = ( 49115.1, 7527.94, 1414.24 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [ ( 49013.4, 7956.33, 1046.72 ) ];
    var_881289d7987bc770.var_31ce4477e3543d24 = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.locationradius = [ 1650 ];
    activityinstances[ "MERC_CAMP_Q2_CLIFF_TOWN_01" ] = var_881289d7987bc770;
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_activitydefinition_merccamp";
    var_881289d7987bc770.cf = "mp_sat_avalon_q2_ob_activity_merc_camp_cs";
    var_881289d7987bc770.scriptstructorigin = ( 45927.8, 3850.03, 1260 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [ ( 46218.8, 3755.15, 910.56 ) ];
    var_881289d7987bc770.var_31ce4477e3543d24 = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.locationradius = [ 1650 ];
    activityinstances[ "MERC_CAMP_Q2_CLIFFTOWN_SQUAD4" ] = var_881289d7987bc770;
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_activitydefinition_merccamp";
    var_881289d7987bc770.cf = "mp_sat_avalon_q2_ob_activity_merc_camp_cs";
    var_881289d7987bc770.scriptstructorigin = ( 39730.2, 3416.74, 1412.21 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [ ( 39716.9, 3375.32, 1067.81 ) ];
    var_881289d7987bc770.var_31ce4477e3543d24 = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.locationradius = [ 1500 ];
    activityinstances[ "MERC_CAMP_Q2_CLIFFTOWN_SQUAD2" ] = var_881289d7987bc770;
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_activitydefinition_merccamp";
    var_881289d7987bc770.cf = "mp_sat_avalon_q2_ob_activity_merc_camp_cs";
    var_881289d7987bc770.scriptstructorigin = ( 42056.2, 3083.05, 1450 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [ ( 42077.7, 3088.06, 1082.91 ) ];
    var_881289d7987bc770.var_31ce4477e3543d24 = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.locationradius = [ 1650 ];
    activityinstances[ "MERC_CAMP_Q2_CLIFFTOWN_SQUAD3" ] = var_881289d7987bc770;
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_activitydefinition_merccamp";
    var_881289d7987bc770.cf = "mp_sat_avalon_q2_ob_activity_merc_camp_cs";
    var_881289d7987bc770.scriptstructorigin = ( 47820.8, 11739.6, 936.31 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [ ( 47851.2, 11759.1, 612.89 ) ];
    var_881289d7987bc770.var_31ce4477e3543d24 = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.locationradius = [ 1650 ];
    activityinstances[ "MERC_CAMP_Q2_CLIFFTOWN_SQUAD5" ] = var_881289d7987bc770;
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_activitydefinition_merccamp";
    var_881289d7987bc770.cf = "mp_sat_avalon_q2_ob_activity_merc_camp_cs";
    var_881289d7987bc770.scriptstructorigin = ( 36515.2, 30035.4, 1234.09 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [ ( 36599.1, 30011.3, 1227.46 ) ];
    var_881289d7987bc770.var_31ce4477e3543d24 = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.locationradius = [ 1350 ];
    activityinstances[ "MERC_CAMP_Q2_COLOSSEUM_INTERSECTION" ] = var_881289d7987bc770;
    return activityinstances;
}

