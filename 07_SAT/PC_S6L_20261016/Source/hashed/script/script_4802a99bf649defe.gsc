// script_4802a99bf649defe  (hash_4802a99bf649defe.gscc) (size: 32391 Bytes / 0x7e87 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xb5b689a4 (3048638884)
// size ...... 32391 (0x7e87)
// includes .. 4   (offset: 0x6d2b)
// strings ... 104 (offset: 0x6d4b)
// dev strs .. 0   (offset: 0x7e87)
// exports ... 16  (offset: 0x676f)
// cseg ...... 0xd53 + 0x5a1c (0x676f)
// imports ... 29  (offset: 0x69ef)
// animtree1 . 0   (offset: 0x7e87)
// animtree2 . 0   (offset: 0x7e87)
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace mp_sat_avalon_q2_ob_activity_crash_sites_cs;

// Namespace mp_sat_avalon_q2_ob_activity_crash_sites_cs
// Params 0, eflags: 0x5
// Checksum 0xd12648a4, Offset: 0xd71
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"mp_sat_avalon_q2_ob_activity_crash_sites_cs", #"activity_common", &function_b39ecd3d51489472, undefined );
}

// Namespace mp_sat_avalon_q2_ob_activity_crash_sites_cs
// Params 0, eflags: 0x4
// Checksum 0x77bcc5fa, Offset: 0xd9a
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace mp_sat_avalon_q2_ob_activity_crash_sites_cs
// Params 0, eflags: 0x4
// Checksum 0xf2871616, Offset: 0xdab
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace mp_sat_avalon_q2_ob_activity_crash_sites_cs
// Params 2
// Checksum 0x310e0c59, Offset: 0xdbc
// Size: 0x8c
function main( unused, unused2 )
{
    if ( utility::flag_exist( "mp_sat_avalon_q2_ob_activity_crash_sites_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "mp_sat_avalon_q2_ob_activity_crash_sites_cs" ) )
    {
        return;
    }
    
    activity_common::function_e1df676808c1d1e3( &function_4cd78e661617f3 );
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "mp_sat_avalon_q2_ob_activity_crash_sites_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "mp_sat_avalon_q2_ob_activity_crash_sites_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace mp_sat_avalon_q2_ob_activity_crash_sites_cs
// Params 3, eflags: 0x4
// Checksum 0x7105a2d9, Offset: 0xe50
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "mp_sat_avalon_q2_ob_activity_crash_sites_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "mp_sat_avalon_q2_ob_activity_crash_sites_cs" );
}

// Namespace mp_sat_avalon_q2_ob_activity_crash_sites_cs
// Params 3, eflags: 0x4
// Checksum 0x3ccc8412, Offset: 0xeca
// Size: 0x2088
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_crash_sites_cs";
    s.activity_bundle = "sat_activity_definition_crash_sites";
    s.name = "CRASH_SITES_Q2_RESORT";
    fe [[ f ]]( s, "CRASH_SITES_Q2_RESORT", cf, ( 10632.7, 30137, 2308.11 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_crash_sites_cs";
    fe [[ f ]]( s, "CRASH_SITES_Q2_RESORT", cf, ( 12200.9, 31454, 1982.37 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Awareness_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 7000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_crash_sites_cs";
    s.groupid = "reinforcement_spawn_point_2";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "crash_site_vtol_reinforcement";
    s.variantname = "ai_encounter_spawnpoint";
    s.var_4501e0172e168ddf = "CRASH_SITES_Q2_RESORT_crash_site_reinforce_2";
    fe [[ f ]]( s, "CRASH_SITES_Q2_RESORT", cf, ( 12213.7, 31475.1, 2212.14 ), ( 0, 233.63, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_crash_sites_cs";
    s.groupid = "reinforcement_spawn_point_1";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "crash_site_vtol_reinforcement";
    s.variantname = "ai_encounter_spawnpoint";
    s.var_4501e0172e168ddf = "CRASH_SITES_Q2_RESORT_crash_site_reinforce_1";
    fe [[ f ]]( s, "CRASH_SITES_Q2_RESORT", cf, ( 12166, 28140.6, 2021.65 ), ( 0, 125.45, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_crash_sites_cs";
    s.groupid = "reinforcement_spawn_point_3";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "crash_site_vtol_reinforcement";
    s.variantname = "ai_encounter_spawnpoint";
    s.var_4501e0172e168ddf = "CRASH_SITES_Q2_RESORT_crash_site_reinforce_3";
    fe [[ f ]]( s, "CRASH_SITES_Q2_RESORT", cf, ( 9197.09, 30878.2, 2378.76 ), ( 0, 5.92, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_crash_sites_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "CRASH_SITES_Q2_RESORT", cf, ( 10577.9, 30007, 2311.5 ), ( 0, 191.42, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_crash_sites_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "CRASH_SITES_Q2_RESORT", cf, ( 10663.3, 30247.2, 2311.5 ), ( 0, 142.58, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_crash_sites_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "CRASH_SITES_Q2_RESORT", cf, ( 10688.9, 29776.8, 2311.5 ), ( 0, 254.76, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_crash_sites_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "CRASH_SITES_Q2_RESORT", cf, ( 11105.6, 29984.2, 2311.5 ), ( 0, 355.58, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_crash_sites_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "CRASH_SITES_Q2_RESORT", cf, ( 10916.3, 30335, 2294.25 ), ( 0, 84.96, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_crash_sites_cs";
    fe [[ f ]]( s, "CRASH_SITES_Q2_RESORT", cf, ( 10687.1, 30039.2, 2306.79 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "OB_Spacer_Spatial_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 2000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_crash_sites_cs";
    fe [[ f ]]( s, "CRASH_SITES_Q2_RESORT", cf, ( 10687.1, 30039.2, 2306.79 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Ambient_AI_Exclusion_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 2500 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_crash_sites_cs";
    fe [[ f ]]( s, "CRASH_SITES_Q2_VILLAGE_RUINS", cf, ( 55134.1, 18214.3, 495 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "OB_Spacer_Spatial_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 2000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_crash_sites_cs";
    s.activity_bundle = "sat_activity_definition_crash_sites";
    s.name = "CRASH_SITES_Q2_VILLAGE_RUINS";
    fe [[ f ]]( s, "CRASH_SITES_Q2_VILLAGE_RUINS", cf, ( 55154.6, 18202.4, 495 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_crash_sites_cs";
    fe [[ f ]]( s, "CRASH_SITES_Q2_VILLAGE_RUINS", cf, ( 55149.3, 18207.1, 495 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Ambient_AI_Exclusion_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 2500 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_crash_sites_cs";
    fe [[ f ]]( s, "CRASH_SITES_Q2_VILLAGE_RUINS", cf, ( 55132.1, 18201.6, 495 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Awareness_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 7000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_crash_sites_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "CRASH_SITES_Q2_VILLAGE_RUINS", cf, ( 54986.5, 18361.6, 495 ), ( 0, 130.73, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_crash_sites_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "CRASH_SITES_Q2_VILLAGE_RUINS", cf, ( 54796.2, 17899.7, 440 ), ( 0, 198.1, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_crash_sites_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "CRASH_SITES_Q2_VILLAGE_RUINS", cf, ( 55121.5, 17688.4, 488 ), ( 0, 265.55, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_crash_sites_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "CRASH_SITES_Q2_VILLAGE_RUINS", cf, ( 55444.7, 17900.6, 482 ), ( 0, 321.06, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_crash_sites_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "CRASH_SITES_Q2_VILLAGE_RUINS", cf, ( 55405.5, 18283.4, 489 ), ( 0, 62.73, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_crash_sites_cs";
    s.groupid = "reinforcement_spawn_point_1";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "crash_site_vtol_reinforcement";
    s.variantname = "ai_encounter_spawnpoint";
    s.var_4501e0172e168ddf = "CRASH_SITES_Q2_VILLAGE_RUINS_crash_site_reinforce_1";
    fe [[ f ]]( s, "CRASH_SITES_Q2_VILLAGE_RUINS", cf, ( 54149, 17623.5, 361.05 ), ( 0, 39.17, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_crash_sites_cs";
    s.groupid = "reinforcement_spawn_point_2";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "crash_site_vtol_reinforcement";
    s.variantname = "ai_encounter_spawnpoint";
    s.var_4501e0172e168ddf = "CRASH_SITES_Q2_VILLAGE_RUINS_crash_site_reinforce_2";
    fe [[ f ]]( s, "CRASH_SITES_Q2_VILLAGE_RUINS", cf, ( 55237.3, 17074.3, 426.36 ), ( 0, 86.36, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_crash_sites_cs";
    s.groupid = "reinforcement_spawn_point_3";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "crash_site_vtol_reinforcement";
    s.variantname = "ai_encounter_spawnpoint";
    s.var_4501e0172e168ddf = "CRASH_SITES_Q2_VILLAGE_RUINS_crash_site_reinforce_3";
    fe [[ f ]]( s, "CRASH_SITES_Q2_VILLAGE_RUINS", cf, ( 56245.4, 18622.2, 458.68 ), ( 0, 180.03, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_crash_sites_cs";
    s.activity_bundle = "sat_activity_definition_crash_sites";
    s.name = "CRASH_SITES_Q2_WINERY_WINDMILL";
    fe [[ f ]]( s, "CRASH_SITES_Q2_WINERY_WINDMILL", cf, ( 28910.5, 31420.9, 3068.44 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_crash_sites_cs";
    fe [[ f ]]( s, "CRASH_SITES_Q2_WINERY_WINDMILL", cf, ( 28909.4, 31416.2, 3068.66 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Awareness_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 7000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_crash_sites_cs";
    s.groupid = "reinforcement_spawn_point_2";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "crash_site_vtol_reinforcement";
    s.variantname = "ai_encounter_spawnpoint";
    s.var_4501e0172e168ddf = "CRASH_SITES_Q2_WINERY_WINDMILL_crash_site_reinforce_2";
    fe [[ f ]]( s, "CRASH_SITES_Q2_WINERY_WINDMILL", cf, ( 29616, 31935.4, 3458.02 ), ( 0, 233.63, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_crash_sites_cs";
    s.groupid = "reinforcement_spawn_point_1";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "crash_site_vtol_reinforcement";
    s.variantname = "ai_encounter_spawnpoint";
    s.var_4501e0172e168ddf = "CRASH_SITES_Q2_WINERY_WINDMILL_crash_site_reinforce_1";
    fe [[ f ]]( s, "CRASH_SITES_Q2_WINERY_WINDMILL", cf, ( 29626.9, 30089, 3504.95 ), ( 0, 127.88, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_crash_sites_cs";
    s.groupid = "reinforcement_spawn_point_3";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "crash_site_vtol_reinforcement";
    s.variantname = "ai_encounter_spawnpoint";
    s.var_4501e0172e168ddf = "CRASH_SITES_Q2_WINERY_WINDMILL_crash_site_reinforce_3";
    fe [[ f ]]( s, "CRASH_SITES_Q2_WINERY_WINDMILL", cf, ( 27789.3, 30962.1, 3595.55 ), ( 0, 0.92, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_crash_sites_cs";
    fe [[ f ]]( s, "CRASH_SITES_Q2_WINERY_WINDMILL", cf, ( 28913.1, 31421.8, 3068.52 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "OB_Spacer_Spatial_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 2000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_crash_sites_cs";
    fe [[ f ]]( s, "CRASH_SITES_Q2_WINERY_WINDMILL", cf, ( 28924.1, 31426.2, 3068.79 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Ambient_AI_Exclusion_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 2500 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_crash_sites_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "CRASH_SITES_Q2_WINERY_WINDMILL", cf, ( 28880, 32131.2, 3360 ), ( 0, 31.81, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_crash_sites_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "CRASH_SITES_Q2_WINERY_WINDMILL", cf, ( 28534.4, 31995.1, 3360 ), ( 0, 103.04, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_crash_sites_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "CRASH_SITES_Q2_WINERY_WINDMILL", cf, ( 28865.9, 31461.6, 3072 ), ( 0, 322.87, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_crash_sites_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "CRASH_SITES_Q2_WINERY_WINDMILL", cf, ( 29186.2, 31679.6, 3167.51 ), ( 0, 230.88, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_crash_sites_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "CRASH_SITES_Q2_WINERY_WINDMILL", cf, ( 28543, 31420.2, 3164.08 ), ( 0, 174.97, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_crash_sites_cs";
    fe [[ f ]]( s, "CRASH_SITES_Q2_CANAL_RUINS", cf, ( 27831.1, 9852.61, 1236.97 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "OB_Spacer_Spatial_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 2000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_crash_sites_cs";
    s.activity_bundle = "sat_activity_definition_crash_sites";
    s.name = "CRASH_SITES_Q2_CANAL_RUINS";
    fe [[ f ]]( s, "CRASH_SITES_Q2_CANAL_RUINS", cf, ( 27831.9, 9930.54, 1236.97 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_crash_sites_cs";
    fe [[ f ]]( s, "CRASH_SITES_Q2_CANAL_RUINS", cf, ( 27823.3, 9865.54, 1236.97 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Ambient_AI_Exclusion_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 2500 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_crash_sites_cs";
    fe [[ f ]]( s, "CRASH_SITES_Q2_CANAL_RUINS", cf, ( 27807.8, 9861.67, 1236.97 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Awareness_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 7000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_crash_sites_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "CRASH_SITES_Q2_CANAL_RUINS", cf, ( 27475.5, 9874.08, 1241.7 ), ( 0, 183.29, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_crash_sites_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "CRASH_SITES_Q2_CANAL_RUINS", cf, ( 27487.6, 10167.7, 1236.97 ), ( 0, 111.53, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_crash_sites_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "CRASH_SITES_Q2_CANAL_RUINS", cf, ( 28126.9, 10110, 1236.97 ), ( 0, 62.66, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_crash_sites_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "CRASH_SITES_Q2_CANAL_RUINS", cf, ( 27439.1, 9574.52, 1294.38 ), ( 0, 221.37, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_crash_sites_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "CRASH_SITES_Q2_CANAL_RUINS", cf, ( 28036.2, 9441.29, 1238.1 ), ( 0, 295.39, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_crash_sites_cs";
    s.groupid = "reinforcement_spawn_point_1";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "crash_site_vtol_reinforcement";
    s.variantname = "ai_encounter_spawnpoint";
    s.var_4501e0172e168ddf = "CRASH_SITES_Q2_CANAL_RUINS_crash_site_reinforce_1";
    fe [[ f ]]( s, "CRASH_SITES_Q2_CANAL_RUINS", cf, ( 27339.2, 8686.5, 1340.62 ), ( 0, 9.17, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_crash_sites_cs";
    s.groupid = "reinforcement_spawn_point_2";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "crash_site_vtol_reinforcement";
    s.variantname = "ai_encounter_spawnpoint";
    s.var_4501e0172e168ddf = "CRASH_SITES_Q2_CANAL_RUINS_crash_site_reinforce_2";
    fe [[ f ]]( s, "CRASH_SITES_Q2_CANAL_RUINS", cf, ( 28906, 9429.78, 1239.28 ), ( 0, 86.36, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_crash_sites_cs";
    s.groupid = "reinforcement_spawn_point_3";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "crash_site_vtol_reinforcement";
    s.variantname = "ai_encounter_spawnpoint";
    s.var_4501e0172e168ddf = "CRASH_SITES_Q2_CANAL_RUINS_crash_site_reinforce_3";
    fe [[ f ]]( s, "CRASH_SITES_Q2_CANAL_RUINS", cf, ( 26530.6, 9523.11, 1294.38 ), ( 0, 346.1, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace mp_sat_avalon_q2_ob_activity_crash_sites_cs
// Params 0, eflags: 0x4
// Checksum 0x268ab814, Offset: 0x2f5a
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace mp_sat_avalon_q2_ob_activity_crash_sites_cs
// Params 0
// Checksum 0xb3567f94, Offset: 0x2f64
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "mp_sat_avalon_q2_ob_activity_crash_sites_cs" );
}

// Namespace mp_sat_avalon_q2_ob_activity_crash_sites_cs
// Params 0
// Checksum 0x46cab723, Offset: 0x2f7a
// Size: 0x66
function function_4cd78e661617f3()
{
    activityinfostruct = {};
    activityinfostruct.name = "REV_OB_CRASH_SITES";
    activityinfostruct.scriptbundle = "sat_activity_definition_crash_sites";
    activityinfostruct.mainfunction = &main;
    activityinfostruct.var_934f068483ae4ddb = &function_d4323822d7042e5a;
    activityinfostruct.metadatafunction = &function_d9dd7965c51c95d1;
    return activityinfostruct;
}

// Namespace mp_sat_avalon_q2_ob_activity_crash_sites_cs
// Params 4
// Checksum 0xf38b15af, Offset: 0x2fe9
// Size: 0xa5
function function_d4323822d7042e5a( var_4312b79c960726b6, fe, us, cf = "mp_sat_avalon_q2_ob_activity_crash_sites_cs" )
{
    switch ( var_4312b79c960726b6 )
    {
        case #"hash_f8c05dbf42064dd9":
            function_f07e0c6a2c964301( fe, us, cf );
            break;
        case #"hash_53ec610064553500":
            function_f7b0489509dae188( fe, us, cf );
            break;
        case #"hash_a1f7cb0a90e8dab1":
            function_cd5a0e0f893eab39( fe, us, cf );
            break;
        case #"hash_99bb3f66c8fbbaa7":
            function_546820159358191f( fe, us, cf );
            break;
    }
}

// Namespace mp_sat_avalon_q2_ob_activity_crash_sites_cs
// Params 3
// Checksum 0xefe0c80, Offset: 0x3096
// Size: 0xd16
function function_f07e0c6a2c964301( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_crash_sites_cs";
    s.groupid = "uav_path";
    s.name = "uav_stall_start";
    fe [[ f ]]( s, "CRASH_SITES_Q2_RESORT", cf, ( 32657.1, -8469.73, 16000 ), ( 0, 119.47, 0 ), "cspf_5_auto532667915284450716", "cspf_5_auto12615583513476428558", "aircraft_crashing_start", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_crash_sites_cs";
    s.groupid = "uav_path";
    s.name = "uav_path_start";
    fe [[ f ]]( s, "CRASH_SITES_Q2_RESORT", cf, ( 64565, -64937.5, 16000 ), ( 0, 119.47, 0 ), "CRASH_SITES_Q2_RESORT", "cspf_5_auto532667915284450716", "aircraft_spawn", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_crash_sites_cs";
    s.groupid = "uav_path";
    s.name = "uav_crash";
    fe [[ f ]]( s, "CRASH_SITES_Q2_RESORT", cf, ( 10924.1, 30144.7, 2278.2 ), ( 21.23, 119.59, 0 ), "cspf_5_auto12615583513476428558", "cspf_5_auto6791859846686303827", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 3000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_crash_sites_cs";
    s.groupid = "uav_path";
    s.name = "uav_debris";
    fe [[ f ]]( s, "CRASH_SITES_Q2_RESORT", cf, ( 10927.9, 30091.7, 2286.81 ), ( 0, 167.49, 0 ), "cspf_5_auto6791859846686303827", "cspf_5_auto4570513562618103726", "uav_debris", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_crash_sites_cs";
    s.groupid = "reinforcement_spawn_point_1";
    s.ishelistruct = 1;
    s.script_accel = "350";
    fe [[ f ]]( s, "CRASH_SITES_Q2_RESORT", cf, ( 12044.4, 28068.7, 2658.62 ), ( 0, 144.79, 0 ), "CRASH_SITES_Q2_RESORT_crash_site_reinforce_1", "cspf_5_auto14702287996722554019", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_crash_sites_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s.groupid = "ground_defence";
    s.height = 400;
    s.name = "black_box_trigger";
    fe [[ f ]]( s, "CRASH_SITES_Q2_RESORT", cf, ( 10821.4, 30043.1, 2189.85 ), ( 4.59, 358.47, 0.53 ), "cspf_5_auto9925487417756725785", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 500 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_crash_sites_cs";
    s.groupid = "reinforcement_spawn_point_1";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "CRASH_SITES_Q2_RESORT", cf, ( 5419.38, 23905.5, 10177 ), ( 359.47, 214.72, 0.5 ), "cspf_5_auto2595496216341312511", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_crash_sites_cs";
    s.groupid = "reinforcement_spawn_point_1";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "CRASH_SITES_Q2_RESORT", cf, ( 22061.3, 19675, 9030.81 ), ( 0, 141.34, 0 ), undefined, "cspf_5_auto4946474192699744393", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150, 1 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_crash_sites_cs";
    s.groupid = "reinforcement_spawn_point_1";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "CRASH_SITES_Q2_RESORT", cf, ( 9347.47, 26868.3, 7063.06 ), ( 359.47, 209.72, 0.5 ), "cspf_5_auto14702287996722554019", "cspf_5_auto2595496216341312511", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_crash_sites_cs";
    s.groupid = "reinforcement_spawn_point_1";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "CRASH_SITES_Q2_RESORT", cf, ( 17777.9, 23230.6, 7953.31 ), ( 0, 144.46, 0 ), "cspf_5_auto4946474192699744393", "CRASH_SITES_Q2_RESORT_crash_site_reinforce_1", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_crash_sites_cs";
    s.groupid = "reinforcement_spawn_point_1";
    s.name = "agent_rally_point";
    fe [[ f ]]( s, "CRASH_SITES_Q2_RESORT", cf, ( 12144.7, 28149.8, 2022.16 ), ( 0, 25.61, 0 ), "cspf_5_auto9925487417756725785", undefined, "agent_rally_point", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 512 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_crash_sites_cs";
    s.groupid = "ground_defence";
    s.name = "blackbox";
    fe [[ f ]]( s, "CRASH_SITES_Q2_RESORT", cf, ( 10821.4, 30043.1, 2283.51 ), ( 6.26, 2.09, 0.45 ), "cspf_5_auto6791859846686303827", "cspf_5_auto9925487417756725785", "black_box", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_crash_sites_cs";
    s.groupid = "reinforcement_spawn_point_2";
    s.name = "agent_rally_point";
    fe [[ f ]]( s, "CRASH_SITES_Q2_RESORT", cf, ( 12215, 31476.3, 2212.11 ), ( 0, 321.45, 0 ), "cspf_5_auto9925487417756725785", undefined, "agent_rally_point", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 512 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_crash_sites_cs";
    s.groupid = "reinforcement_spawn_point_3";
    s.name = "agent_rally_point";
    fe [[ f ]]( s, "CRASH_SITES_Q2_RESORT", cf, ( 9198.83, 30877.2, 2378.48 ), ( 0, 5, 0 ), "cspf_5_auto9925487417756725785", undefined, "agent_rally_point", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 512 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_crash_sites_cs";
    s.groupid = "reinforcement_spawn_point_2";
    s.ishelistruct = 1;
    s.script_accel = "350";
    fe [[ f ]]( s, "CRASH_SITES_Q2_RESORT", cf, ( 12070.8, 31438.3, 2834.62 ), ( 0, 144.79, 0 ), "CRASH_SITES_Q2_RESORT_crash_site_reinforce_2", "cspf_5_auto12969767731744201512", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_crash_sites_cs";
    s.groupid = "reinforcement_spawn_point_2";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "CRASH_SITES_Q2_RESORT", cf, ( 15213, 40600.1, 10177 ), ( 359.47, 54.72, 0.49 ), "cspf_5_auto2571006957860739162", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_crash_sites_cs";
    s.groupid = "reinforcement_spawn_point_2";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "CRASH_SITES_Q2_RESORT", cf, ( 24528.7, 27135.6, 9030.81 ), ( 0, 166.34, 0 ), undefined, "cspf_5_auto300186647103802371", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150, 1 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_crash_sites_cs";
    s.groupid = "reinforcement_spawn_point_2";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "CRASH_SITES_Q2_RESORT", cf, ( 12203.8, 36484, 7063.06 ), ( 359.47, 69.72, 0.5 ), "cspf_5_auto12969767731744201512", "cspf_5_auto2571006957860739162", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_crash_sites_cs";
    s.groupid = "reinforcement_spawn_point_2";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "CRASH_SITES_Q2_RESORT", cf, ( 19144, 28547.8, 7953.31 ), ( 0, 169.46, 0 ), "cspf_5_auto300186647103802371", "CRASH_SITES_Q2_RESORT_crash_site_reinforce_2", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_crash_sites_cs";
    s.groupid = "reinforcement_spawn_point_3";
    s.ishelistruct = 1;
    s.script_accel = "350";
    fe [[ f ]]( s, "CRASH_SITES_Q2_RESORT", cf, ( 9202.27, 30742.2, 2986.62 ), ( 0, 289.79, 0 ), "CRASH_SITES_Q2_RESORT_crash_site_reinforce_3", "cspf_5_auto13162397884241098630", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_crash_sites_cs";
    s.groupid = "reinforcement_spawn_point_3";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "CRASH_SITES_Q2_RESORT", cf, ( 4529.83, 17798.7, 10177 ), ( 359.47, 254.72, 0.49 ), "cspf_5_auto9940559182575149040", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_crash_sites_cs";
    s.groupid = "reinforcement_spawn_point_3";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "CRASH_SITES_Q2_RESORT", cf, ( 4647.25, 42647.6, 9030.81 ), ( 0, 291.34, 0 ), undefined, "cspf_5_auto17336514702075182739", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150, 1 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_crash_sites_cs";
    s.groupid = "reinforcement_spawn_point_3";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "CRASH_SITES_Q2_RESORT", cf, ( 7068.75, 24326.4, 7239.06 ), ( 359.47, 264.72, 0.49 ), "cspf_5_auto13162397884241098630", "cspf_5_auto9940559182575149040", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_crash_sites_cs";
    s.groupid = "reinforcement_spawn_point_3";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "CRASH_SITES_Q2_RESORT", cf, ( 9198.48, 30795.2, 2986.62 ), ( 0, 294.79, 0 ), "cspf_5_auto17336514702075182739", "CRASH_SITES_Q2_RESORT_crash_site_reinforce_3", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
}

// Namespace mp_sat_avalon_q2_ob_activity_crash_sites_cs
// Params 3
// Checksum 0x3550178b, Offset: 0x3db4
// Size: 0xd13
function function_f7b0489509dae188( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_crash_sites_cs";
    s.groupid = "uav_path";
    s.name = "uav_stall_start";
    fe [[ f ]]( s, "CRASH_SITES_Q2_VILLAGE_RUINS", cf, ( 57792.3, -140.89, 16237.5 ), ( 0, 98.56, 0 ), "cspf_6_auto7059409811788751035", "cspf_6_auto10802568113865877285", "aircraft_crashing_start", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_crash_sites_cs";
    s.groupid = "uav_path";
    s.name = "uav_crash";
    fe [[ f ]]( s, "CRASH_SITES_Q2_VILLAGE_RUINS", cf, ( 55064.9, 18200.5, 495 ), ( 38.06, 99.75, 0 ), "cspf_6_auto10802568113865877285", "cspf_6_auto869477739016309505", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_crash_sites_cs";
    s.groupid = "uav_path";
    s.name = "uav_debris";
    fe [[ f ]]( s, "CRASH_SITES_Q2_VILLAGE_RUINS", cf, ( 55058.1, 18185.3, 495 ), ( 0, 0, 0 ), "cspf_6_auto869477739016309505", "cspf_6_auto7563931249015809616", "uav_debris", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_crash_sites_cs";
    s.groupid = "uav_path";
    s.name = "uav_path_start";
    fe [[ f ]]( s, "CRASH_SITES_Q2_VILLAGE_RUINS", cf, ( 63707.2, -45052, 18922 ), ( 0, 97.37, 0 ), "CRASH_SITES_Q2_VILLAGE_RUINS", "cspf_6_auto7059409811788751035", "aircraft_spawn", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_crash_sites_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s.groupid = "ground_defence";
    s.height = 350;
    s.name = "black_box_trigger";
    fe [[ f ]]( s, "CRASH_SITES_Q2_VILLAGE_RUINS", cf, ( 55025.4, 18193.3, 350.5 ), ( 352.15, 1.03, -0.85 ), "cspf_6_auto547184076047906228", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 500 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_crash_sites_cs";
    s.groupid = "reinforcement_spawn_point_1";
    s.ishelistruct = 1;
    s.script_accel = "350";
    fe [[ f ]]( s, "CRASH_SITES_Q2_VILLAGE_RUINS", cf, ( 54082.4, 17621.6, 995.14 ), ( 0, 84.79, 0 ), "CRASH_SITES_Q2_VILLAGE_RUINS_crash_site_reinforce_1", "cspf_6_auto14702287996722554019", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_crash_sites_cs";
    s.groupid = "reinforcement_spawn_point_1";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "CRASH_SITES_Q2_VILLAGE_RUINS", cf, ( 46336, 22340.9, 9089.52 ), ( 359.47, 154.72, 0.5 ), "cspf_6_auto2595496216341312511", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_crash_sites_cs";
    s.groupid = "reinforcement_spawn_point_1";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "CRASH_SITES_Q2_VILLAGE_RUINS", cf, ( 49868.4, 4921.16, 7943.33 ), ( 0, 71.34, 0 ), undefined, "cspf_6_auto4946474192699744393", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150, 1 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_crash_sites_cs";
    s.groupid = "reinforcement_spawn_point_1";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "CRASH_SITES_Q2_VILLAGE_RUINS", cf, ( 49784.1, 20983.7, 5975.58 ), ( 359.47, 144.72, 0.5 ), "cspf_6_auto14702287996722554019", "cspf_6_auto2595496216341312511", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_crash_sites_cs";
    s.groupid = "reinforcement_spawn_point_1";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "CRASH_SITES_Q2_VILLAGE_RUINS", cf, ( 51744.6, 10162.3, 6865.83 ), ( 0, 74.46, 0 ), "cspf_6_auto4946474192699744393", "CRASH_SITES_Q2_VILLAGE_RUINS_crash_site_reinforce_1", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_crash_sites_cs";
    s.groupid = "reinforcement_spawn_point_1";
    s.name = "agent_rally_point";
    fe [[ f ]]( s, "CRASH_SITES_Q2_VILLAGE_RUINS", cf, ( 54153.4, 17608.4, 361.36 ), ( 0, 68.11, 0 ), "cspf_6_auto547184076047906228", undefined, "agent_rally_point", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 512 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_crash_sites_cs";
    s.groupid = "ground_defence";
    s.name = "blackbox";
    fe [[ f ]]( s, "CRASH_SITES_Q2_VILLAGE_RUINS", cf, ( 55024.4, 18189.3, 495 ), ( 359.72, 1.69, 1.08 ), "cspf_6_auto869477739016309505", "cspf_6_auto547184076047906228", "black_box", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_crash_sites_cs";
    s.groupid = "reinforcement_spawn_point_2";
    s.name = "agent_rally_point";
    fe [[ f ]]( s, "CRASH_SITES_Q2_VILLAGE_RUINS", cf, ( 55069.3, 17508.9, 421.5 ), ( 0, 68.11, 0 ), "cspf_6_auto547184076047906228", undefined, "agent_rally_point", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 512 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_crash_sites_cs";
    s.groupid = "reinforcement_spawn_point_3";
    s.name = "agent_rally_point";
    fe [[ f ]]( s, "CRASH_SITES_Q2_VILLAGE_RUINS", cf, ( 56246.8, 18621.3, 458.68 ), ( 0, 68.11, 0 ), "cspf_6_auto547184076047906228", undefined, "agent_rally_point", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 512 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_crash_sites_cs";
    s.groupid = "reinforcement_spawn_point_3";
    s.ishelistruct = 1;
    s.script_accel = "350";
    fe [[ f ]]( s, "CRASH_SITES_Q2_VILLAGE_RUINS", cf, ( 56168.2, 18630.6, 1115.14 ), ( 0, 119.79, 0 ), "CRASH_SITES_Q2_VILLAGE_RUINS_crash_site_reinforce_3", "cspf_6_auto2265373269156806721", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_crash_sites_cs";
    s.groupid = "reinforcement_spawn_point_3";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "CRASH_SITES_Q2_VILLAGE_RUINS", cf, ( 60123.6, 25900.9, 9089.52 ), ( 359.47, 54.72, 0.49 ), "cspf_6_auto11296048236063190921", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_crash_sites_cs";
    s.groupid = "reinforcement_spawn_point_3";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "CRASH_SITES_Q2_VILLAGE_RUINS", cf, ( 64519.4, 7028.55, 7943.33 ), ( 0, 131.34, 0 ), undefined, "cspf_6_auto6783762623205061026", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150, 1 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_crash_sites_cs";
    s.groupid = "reinforcement_spawn_point_3";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "CRASH_SITES_Q2_VILLAGE_RUINS", cf, ( 57792.1, 22619.6, 5975.58 ), ( 359.47, 79.72, 0.49 ), "cspf_6_auto2265373269156806721", "cspf_6_auto11296048236063190921", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_crash_sites_cs";
    s.groupid = "reinforcement_spawn_point_3";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "CRASH_SITES_Q2_VILLAGE_RUINS", cf, ( 60918.5, 11274, 6865.83 ), ( 0, 134.46, 0 ), "cspf_6_auto6783762623205061026", "CRASH_SITES_Q2_VILLAGE_RUINS_crash_site_reinforce_3", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_crash_sites_cs";
    s.groupid = "reinforcement_spawn_point_2";
    s.ishelistruct = 1;
    s.script_accel = "350";
    fe [[ f ]]( s, "CRASH_SITES_Q2_VILLAGE_RUINS", cf, ( 55305.9, 16975.3, 1063.14 ), ( 0, 334.79, 0 ), "CRASH_SITES_Q2_VILLAGE_RUINS_crash_site_reinforce_2", "cspf_6_auto13411636090605677493", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_crash_sites_cs";
    s.groupid = "reinforcement_spawn_point_2";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "CRASH_SITES_Q2_VILLAGE_RUINS", cf, ( 59550.9, 7931.84, 9089.52 ), ( 359.47, 289.72, 0.49 ), "cspf_6_auto16145523147816312949", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_crash_sites_cs";
    s.groupid = "reinforcement_spawn_point_2";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "CRASH_SITES_Q2_VILLAGE_RUINS", cf, ( 47280.7, 30507.5, 7943.33 ), ( 0, 306.34, 0 ), undefined, "cspf_6_auto470580290414513396", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150, 1 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_crash_sites_cs";
    s.groupid = "reinforcement_spawn_point_2";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "CRASH_SITES_Q2_VILLAGE_RUINS", cf, ( 57919.5, 12109.4, 5975.58 ), ( 359.47, 289.72, 0.49 ), "cspf_6_auto13411636090605677493", "cspf_6_auto16145523147816312949", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_crash_sites_cs";
    s.groupid = "reinforcement_spawn_point_2";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "CRASH_SITES_Q2_VILLAGE_RUINS", cf, ( 50497.9, 25964.4, 6865.83 ), ( 0, 309.46, 0 ), "cspf_6_auto470580290414513396", "CRASH_SITES_Q2_VILLAGE_RUINS_crash_site_reinforce_2", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
}

// Namespace mp_sat_avalon_q2_ob_activity_crash_sites_cs
// Params 3
// Checksum 0x3009d082, Offset: 0x4acf
// Size: 0xd13
function function_cd5a0e0f893eab39( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_crash_sites_cs";
    s.groupid = "uav_path";
    s.name = "uav_stall_start";
    fe [[ f ]]( s, "CRASH_SITES_Q2_WINERY_WINDMILL", cf, ( 47963.4, 30914.8, 12240.1 ), ( 0, 178.53, 0 ), "cspf_7_auto532667915284450716", "cspf_7_auto12615583513476428558", "aircraft_crashing_start", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_crash_sites_cs";
    s.groupid = "uav_path";
    s.name = "uav_path_start";
    fe [[ f ]]( s, "CRASH_SITES_Q2_WINERY_WINDMILL", cf, ( 82859, 29379.3, 14930.2 ), ( 0, 177.48, 0 ), "CRASH_SITES_Q2_WINERY_WINDMILL", "cspf_7_auto532667915284450716", "aircraft_spawn", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_crash_sites_cs";
    s.groupid = "uav_path";
    s.name = "uav_crash";
    fe [[ f ]]( s, "CRASH_SITES_Q2_WINERY_WINDMILL", cf, ( 28921.5, 31408.5, 3069.71 ), ( 23.44, 178.01, 0 ), "cspf_7_auto12615583513476428558", "cspf_7_auto6791859846686303827", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_crash_sites_cs";
    s.groupid = "uav_path";
    s.name = "uav_debris";
    fe [[ f ]]( s, "CRASH_SITES_Q2_WINERY_WINDMILL", cf, ( 28912.5, 31418.5, 3068.68 ), ( 0, 346.02, 0 ), "cspf_7_auto6791859846686303827", "cspf_7_auto4570513562618103726", "uav_debris", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_crash_sites_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s.groupid = "ground_defence";
    s.height = 300;
    s.name = "black_box_trigger";
    fe [[ f ]]( s, "CRASH_SITES_Q2_WINERY_WINDMILL", cf, ( 28902.1, 31457.9, 2889.88 ), ( 0, 0, 0 ), "cspf_7_auto9925487417756725785", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 500 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_crash_sites_cs";
    s.groupid = "reinforcement_spawn_point_3";
    s.ishelistruct = 1;
    s.script_accel = "350";
    fe [[ f ]]( s, "CRASH_SITES_Q2_WINERY_WINDMILL", cf, ( 27875.7, 30910.3, 4206.37 ), ( 0, 294.79, 0 ), "CRASH_SITES_Q2_WINERY_WINDMILL_crash_site_reinforce_3", "cspf_7_auto13411636090605677493", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_crash_sites_cs";
    s.groupid = "reinforcement_spawn_point_3";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "CRASH_SITES_Q2_WINERY_WINDMILL", cf, ( 31790.2, 21363.8, 11860.8 ), ( 359.47, 289.72, 0.49 ), "cspf_7_auto16145523147816312949", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_crash_sites_cs";
    s.groupid = "reinforcement_spawn_point_3";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "CRASH_SITES_Q2_WINERY_WINDMILL", cf, ( 19520, 43939.5, 10714.6 ), ( 0, 306.34, 0 ), undefined, "cspf_7_auto470580290414513396", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150, 1 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_crash_sites_cs";
    s.groupid = "reinforcement_spawn_point_3";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "CRASH_SITES_Q2_WINERY_WINDMILL", cf, ( 30158.8, 25541.4, 8746.81 ), ( 359.47, 289.72, 0.49 ), "cspf_7_auto13411636090605677493", "cspf_7_auto16145523147816312949", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_crash_sites_cs";
    s.groupid = "reinforcement_spawn_point_3";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "CRASH_SITES_Q2_WINERY_WINDMILL", cf, ( 22737.2, 39396.4, 9637.06 ), ( 0, 309.46, 0 ), "cspf_7_auto470580290414513396", "CRASH_SITES_Q2_WINERY_WINDMILL_crash_site_reinforce_3", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_crash_sites_cs";
    s.groupid = "reinforcement_spawn_point_3";
    s.name = "agent_rally_point";
    fe [[ f ]]( s, "CRASH_SITES_Q2_WINERY_WINDMILL", cf, ( 27794.1, 30961.8, 3595.36 ), ( 0, 25.61, 0 ), "cspf_7_auto9925487417756725785", undefined, "agent_rally_point", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 512 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_crash_sites_cs";
    s.groupid = "ground_defence";
    s.name = "blackbox";
    fe [[ f ]]( s, "CRASH_SITES_Q2_WINERY_WINDMILL", cf, ( 28905.4, 31459, 3068.94 ), ( 3.84, 357.3, -1 ), "cspf_7_auto6791859846686303827", "cspf_7_auto9925487417756725785", "black_box", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_crash_sites_cs";
    s.groupid = "reinforcement_spawn_point_1";
    s.name = "agent_rally_point";
    fe [[ f ]]( s, "CRASH_SITES_Q2_WINERY_WINDMILL", cf, ( 29639.1, 30071.7, 3505.46 ), ( 0, 321.45, 0 ), "cspf_7_auto9925487417756725785", undefined, "agent_rally_point", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 512 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_crash_sites_cs";
    s.groupid = "reinforcement_spawn_point_2";
    s.name = "agent_rally_point";
    fe [[ f ]]( s, "CRASH_SITES_Q2_WINERY_WINDMILL", cf, ( 29613.3, 31931.1, 3455.87 ), ( 0, 0, 0 ), "cspf_7_auto9925487417756725785", undefined, "agent_rally_point", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 512 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_crash_sites_cs";
    s.groupid = "reinforcement_spawn_point_1";
    s.ishelistruct = 1;
    s.script_accel = "350";
    fe [[ f ]]( s, "CRASH_SITES_Q2_WINERY_WINDMILL", cf, ( 29702.7, 30092.5, 4082.37 ), ( 0, 24.79, 0 ), "CRASH_SITES_Q2_WINERY_WINDMILL_crash_site_reinforce_1", "cspf_7_auto15365080973553683403", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_crash_sites_cs";
    s.groupid = "reinforcement_spawn_point_1";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "CRASH_SITES_Q2_WINERY_WINDMILL", cf, ( 39341.2, 33895, 11804.8 ), ( 359.47, 19.72, 0.49 ), "cspf_7_auto10618739827128621970", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_crash_sites_cs";
    s.groupid = "reinforcement_spawn_point_1";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "CRASH_SITES_Q2_WINERY_WINDMILL", cf, ( 16765.5, 21624.7, 10658.6 ), ( 0, 36.34, 0 ), undefined, "cspf_7_auto5658455220972837871", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150, 1 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_crash_sites_cs";
    s.groupid = "reinforcement_spawn_point_1";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "CRASH_SITES_Q2_WINERY_WINDMILL", cf, ( 35163.6, 32263.6, 8690.81 ), ( 359.47, 19.72, 0.49 ), "cspf_7_auto15365080973553683403", "cspf_7_auto10618739827128621970", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_crash_sites_cs";
    s.groupid = "reinforcement_spawn_point_1";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "CRASH_SITES_Q2_WINERY_WINDMILL", cf, ( 21308.6, 24842, 9581.06 ), ( 0, 39.46, 0 ), "cspf_7_auto5658455220972837871", "CRASH_SITES_Q2_WINERY_WINDMILL_crash_site_reinforce_1", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_crash_sites_cs";
    s.groupid = "reinforcement_spawn_point_2";
    s.ishelistruct = 1;
    s.script_accel = "350";
    fe [[ f ]]( s, "CRASH_SITES_Q2_WINERY_WINDMILL", cf, ( 29506.2, 31908, 4137.87 ), ( 0, 123.42, 0 ), "CRASH_SITES_Q2_WINERY_WINDMILL_crash_site_reinforce_2", "cspf_7_auto5059232321379286954", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_crash_sites_cs";
    s.groupid = "reinforcement_spawn_point_2";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "CRASH_SITES_Q2_WINERY_WINDMILL", cf, ( 24743.7, 41778.1, 11804.8 ), ( 359.47, 109.72, 0.49 ), "cspf_7_auto11380418667361553620", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_crash_sites_cs";
    s.groupid = "reinforcement_spawn_point_2";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "CRASH_SITES_Q2_WINERY_WINDMILL", cf, ( 38368.4, 19026.3, 10658.6 ), ( 0, 126.34, 0 ), undefined, "cspf_7_auto8067981526303549572", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150, 1 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_crash_sites_cs";
    s.groupid = "reinforcement_spawn_point_2";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "CRASH_SITES_Q2_WINERY_WINDMILL", cf, ( 26375.1, 37600.5, 8690.81 ), ( 359.47, 109.72, 0.49 ), "cspf_7_auto5059232321379286954", "cspf_7_auto11380418667361553620", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_crash_sites_cs";
    s.groupid = "reinforcement_spawn_point_2";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "CRASH_SITES_Q2_WINERY_WINDMILL", cf, ( 35151.1, 23569.5, 9581.06 ), ( 0, 129.46, 0 ), "cspf_7_auto8067981526303549572", "CRASH_SITES_Q2_WINERY_WINDMILL_crash_site_reinforce_2", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
}

// Namespace mp_sat_avalon_q2_ob_activity_crash_sites_cs
// Params 3
// Checksum 0xba60acb3, Offset: 0x57ea
// Size: 0xd0f
function function_546820159358191f( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_crash_sites_cs";
    s.groupid = "uav_path";
    s.name = "uav_stall_start";
    fe [[ f ]]( s, "CRASH_SITES_Q2_CANAL_RUINS", cf, ( 16876.2, 30281.2, 16237.5 ), ( 0, 298.2, 0 ), "cspf_8_auto14789262142566746859", "cspf_8_auto13274279407884982108", "aircraft_crashing_start", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_crash_sites_cs";
    s.groupid = "uav_path";
    s.name = "uav_crash";
    fe [[ f ]]( s, "CRASH_SITES_Q2_CANAL_RUINS", cf, ( 27780.3, 9844.01, 1236.97 ), ( 34.85, 298.84, 0 ), "cspf_8_auto13274279407884982108", "cspf_8_auto4474292346831930077", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_crash_sites_cs";
    s.groupid = "uav_path";
    s.name = "uav_debris";
    fe [[ f ]]( s, "CRASH_SITES_Q2_CANAL_RUINS", cf, ( 27841, 9858.61, 1236.97 ), ( 0, 201.64, 0 ), "cspf_8_auto4474292346831930077", undefined, "uav_debris", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_crash_sites_cs";
    s.groupid = "uav_path";
    s.name = "uav_path_start";
    fe [[ f ]]( s, "CRASH_SITES_Q2_CANAL_RUINS", cf, ( -3456.04, 65140.6, 18922 ), ( 0, 300.21, 0 ), "CRASH_SITES_Q2_CANAL_RUINS", "cspf_8_auto14789262142566746859", "aircraft_spawn", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_crash_sites_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s.groupid = "ground_defence";
    s.height = 350;
    s.name = "black_box_trigger";
    fe [[ f ]]( s, "CRASH_SITES_Q2_CANAL_RUINS", cf, ( 27817.2, 9818.36, 1236.97 ), ( 352.15, 1.03, -0.85 ), "cspf_8_auto7975665300624344468", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 500 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_crash_sites_cs";
    s.groupid = "reinforcement_spawn_point_1";
    s.name = "agent_rally_point";
    fe [[ f ]]( s, "CRASH_SITES_Q2_CANAL_RUINS", cf, ( 27338.7, 8671.96, 1339.77 ), ( 0, 38.11, 0 ), "cspf_8_auto7975665300624344468", undefined, "agent_rally_point", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 512 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_crash_sites_cs";
    s.groupid = "ground_defence";
    s.name = "blackbox";
    fe [[ f ]]( s, "CRASH_SITES_Q2_CANAL_RUINS", cf, ( 27817.5, 9822.4, 1236.97 ), ( 359.72, 1.69, 1.08 ), "cspf_8_auto4474292346831930077", "cspf_8_auto7975665300624344468", "black_box", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_crash_sites_cs";
    s.groupid = "reinforcement_spawn_point_2";
    s.name = "agent_rally_point";
    fe [[ f ]]( s, "CRASH_SITES_Q2_CANAL_RUINS", cf, ( 28923.8, 9438.57, 1239.32 ), ( 0, 68.11, 0 ), "cspf_8_auto7975665300624344468", undefined, "agent_rally_point", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 512 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_crash_sites_cs";
    s.groupid = "reinforcement_spawn_point_3";
    s.name = "agent_rally_point";
    fe [[ f ]]( s, "CRASH_SITES_Q2_CANAL_RUINS", cf, ( 26519.5, 9540.33, 1294.38 ), ( 0, 68.11, 0 ), "cspf_8_auto7975665300624344468", undefined, "agent_rally_point", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 512 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_crash_sites_cs";
    s.groupid = "reinforcement_spawn_point_3";
    s.ishelistruct = 1;
    s.script_accel = "350";
    fe [[ f ]]( s, "CRASH_SITES_Q2_CANAL_RUINS", cf, ( 26609.9, 9539.23, 1914.62 ), ( 0, 269.79, 0 ), "CRASH_SITES_Q2_CANAL_RUINS_crash_site_reinforce_3", "cspf_8_auto17937178258591672635", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_crash_sites_cs";
    s.groupid = "reinforcement_spawn_point_3";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "CRASH_SITES_Q2_CANAL_RUINS", cf, ( 13883.2, 5948.08, 9129.04 ), ( 359.47, 184.72, 0.5 ), "cspf_8_auto16754152219778768845", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_crash_sites_cs";
    s.groupid = "reinforcement_spawn_point_3";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "CRASH_SITES_Q2_CANAL_RUINS", cf, ( 18551.8, 18398.9, 7982.81 ), ( 0, 321.34, 0 ), undefined, "cspf_8_auto5505422419371868505", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150, 1 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_crash_sites_cs";
    s.groupid = "reinforcement_spawn_point_3";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "CRASH_SITES_Q2_CANAL_RUINS", cf, ( 20273.7, 7193.47, 6015.06 ), ( 359.47, 229.72, 0.5 ), "cspf_8_auto17937178258591672635", "cspf_8_auto16754152219778768845", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_crash_sites_cs";
    s.groupid = "reinforcement_spawn_point_3";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "CRASH_SITES_Q2_CANAL_RUINS", cf, ( 22840.4, 14912.1, 6905.31 ), ( 0, 319.46, 0 ), "cspf_8_auto5505422419371868505", "CRASH_SITES_Q2_CANAL_RUINS_crash_site_reinforce_3", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_crash_sites_cs";
    s.groupid = "reinforcement_spawn_point_1";
    s.ishelistruct = 1;
    s.script_accel = "350";
    fe [[ f ]]( s, "CRASH_SITES_Q2_CANAL_RUINS", cf, ( 27303.3, 8771.02, 1962.62 ), ( 0, 54.79, 0 ), "CRASH_SITES_Q2_CANAL_RUINS_crash_site_reinforce_1", "cspf_8_auto14702287996722554019", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_crash_sites_cs";
    s.groupid = "reinforcement_spawn_point_1";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "CRASH_SITES_Q2_CANAL_RUINS", cf, ( 27747.6, 21862.5, 9129.04 ), ( 359.47, 89.72, 0.5 ), "cspf_8_auto2595496216341312511", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_crash_sites_cs";
    s.groupid = "reinforcement_spawn_point_2";
    s.ishelistruct = 1;
    s.script_accel = "350";
    fe [[ f ]]( s, "CRASH_SITES_Q2_CANAL_RUINS", cf, ( 29053.9, 9439.54, 1850.62 ), ( 0, 299.79, 0 ), "CRASH_SITES_Q2_CANAL_RUINS_crash_site_reinforce_2", "cspf_8_auto4127009719145986499", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_crash_sites_cs";
    s.groupid = "reinforcement_spawn_point_2";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "CRASH_SITES_Q2_CANAL_RUINS", cf, ( 40703.2, -2259.92, 9133.04 ), ( 359.47, 304.72, 0.5 ), "cspf_8_auto4255067007087623801", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_crash_sites_cs";
    s.groupid = "reinforcement_spawn_point_2";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "CRASH_SITES_Q2_CANAL_RUINS", cf, ( 30367.8, 22014.9, 7982.81 ), ( 0, 246.34, 0 ), undefined, "cspf_8_auto2531467404335541192", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150, 1 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_crash_sites_cs";
    s.groupid = "reinforcement_spawn_point_2";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "CRASH_SITES_Q2_CANAL_RUINS", cf, ( 35173.7, 3517.47, 6191.06 ), ( 359.47, 319.72, 0.5 ), "cspf_8_auto4127009719145986499", "cspf_8_auto4255067007087623801", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_crash_sites_cs";
    s.groupid = "reinforcement_spawn_point_2";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "CRASH_SITES_Q2_CANAL_RUINS", cf, ( 28648.4, 16392.1, 6905.31 ), ( 0, 244.46, 0 ), "cspf_8_auto2531467404335541192", "CRASH_SITES_Q2_CANAL_RUINS_crash_site_reinforce_2", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_crash_sites_cs";
    s.groupid = "reinforcement_spawn_point_1";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "CRASH_SITES_Q2_CANAL_RUINS", cf, ( 18364, 426.16, 7982.81 ), ( 0, 36.34, 0 ), undefined, "cspf_8_auto4946474192699744393", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150, 1 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_crash_sites_cs";
    s.groupid = "reinforcement_spawn_point_1";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "CRASH_SITES_Q2_CANAL_RUINS", cf, ( 27738.4, 14014.4, 6015.06 ), ( 359.47, 84.72, 0.5 ), "cspf_8_auto14702287996722554019", "cspf_8_auto2595496216341312511", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_crash_sites_cs";
    s.groupid = "reinforcement_spawn_point_1";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "CRASH_SITES_Q2_CANAL_RUINS", cf, ( 22907.1, 3643.29, 6905.31 ), ( 0, 39.46, 0 ), "cspf_8_auto4946474192699744393", "CRASH_SITES_Q2_CANAL_RUINS_crash_site_reinforce_1", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
}

// Namespace mp_sat_avalon_q2_ob_activity_crash_sites_cs
// Params 0
// Checksum 0x27835eda, Offset: 0x6501
// Size: 0x26d
function function_d9dd7965c51c95d1()
{
    activityinstances = [];
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_activity_definition_crash_sites";
    var_881289d7987bc770.cf = "mp_sat_avalon_q2_ob_activity_crash_sites_cs";
    var_881289d7987bc770.scriptstructorigin = ( 10632.7, 30137, 2308.11 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [];
    var_881289d7987bc770.var_31ce4477e3543d24 = [];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [];
    var_881289d7987bc770.locationradius = [];
    activityinstances[ "CRASH_SITES_Q2_RESORT" ] = var_881289d7987bc770;
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_activity_definition_crash_sites";
    var_881289d7987bc770.cf = "mp_sat_avalon_q2_ob_activity_crash_sites_cs";
    var_881289d7987bc770.scriptstructorigin = ( 55154.6, 18202.4, 495 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [];
    var_881289d7987bc770.var_31ce4477e3543d24 = [];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [];
    var_881289d7987bc770.locationradius = [];
    activityinstances[ "CRASH_SITES_Q2_VILLAGE_RUINS" ] = var_881289d7987bc770;
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_activity_definition_crash_sites";
    var_881289d7987bc770.cf = "mp_sat_avalon_q2_ob_activity_crash_sites_cs";
    var_881289d7987bc770.scriptstructorigin = ( 28910.5, 31420.9, 3068.44 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [];
    var_881289d7987bc770.var_31ce4477e3543d24 = [];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [];
    var_881289d7987bc770.locationradius = [];
    activityinstances[ "CRASH_SITES_Q2_WINERY_WINDMILL" ] = var_881289d7987bc770;
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_activity_definition_crash_sites";
    var_881289d7987bc770.cf = "mp_sat_avalon_q2_ob_activity_crash_sites_cs";
    var_881289d7987bc770.scriptstructorigin = ( 27831.9, 9930.54, 1236.97 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [];
    var_881289d7987bc770.var_31ce4477e3543d24 = [];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [];
    var_881289d7987bc770.locationradius = [];
    activityinstances[ "CRASH_SITES_Q2_CANAL_RUINS" ] = var_881289d7987bc770;
    return activityinstances;
}

