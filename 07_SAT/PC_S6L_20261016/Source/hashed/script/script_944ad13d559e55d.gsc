// script_944ad13d559e55d  (hash_0944ad13d559e55d.gscc) (size: 17725 Bytes / 0x453d / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x9d47e77a (2638735226)
// size ...... 17725 (0x453d)
// includes .. 4   (offset: 0x3bdd)
// strings ... 69  (offset: 0x3bfd)
// dev strs .. 0   (offset: 0x453d)
// exports ... 14  (offset: 0x36b1)
// cseg ...... 0x840 + 0x2e71 (0x36b1)
// imports ... 27  (offset: 0x38e1)
// animtree1 . 0   (offset: 0x453d)
// animtree2 . 0   (offset: 0x453d)
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace mp_sat_avalon_q1_ob_activity_crash_sites;

// Namespace mp_sat_avalon_q1_ob_activity_crash_sites
// Params 0, eflags: 0x5
// Checksum 0x58921fa1, Offset: 0x85e
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"mp_sat_avalon_q1_ob_activity_crash_sites", #"activity_common", &function_b39ecd3d51489472, undefined );
}

// Namespace mp_sat_avalon_q1_ob_activity_crash_sites
// Params 0, eflags: 0x4
// Checksum 0xd7790229, Offset: 0x887
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace mp_sat_avalon_q1_ob_activity_crash_sites
// Params 0, eflags: 0x4
// Checksum 0x5242d1c5, Offset: 0x898
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace mp_sat_avalon_q1_ob_activity_crash_sites
// Params 2
// Checksum 0x35020fc1, Offset: 0x8a9
// Size: 0x8c
function main( unused, unused2 )
{
    if ( utility::flag_exist( "mp_sat_avalon_q1_ob_activity_crash_sites" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "mp_sat_avalon_q1_ob_activity_crash_sites" ) )
    {
        return;
    }
    
    activity_common::function_e1df676808c1d1e3( &function_4cd78e661617f3 );
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "mp_sat_avalon_q1_ob_activity_crash_sites" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "mp_sat_avalon_q1_ob_activity_crash_sites" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace mp_sat_avalon_q1_ob_activity_crash_sites
// Params 3, eflags: 0x4
// Checksum 0xd1c0650a, Offset: 0x93d
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "mp_sat_avalon_q1_ob_activity_crash_sites" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "mp_sat_avalon_q1_ob_activity_crash_sites" );
}

// Namespace mp_sat_avalon_q1_ob_activity_crash_sites
// Params 3, eflags: 0x4
// Checksum 0x5bb2adc9, Offset: 0x9b7
// Size: 0x106a
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_crash_sites";
    fe [[ f ]]( s, "CRASH_SITES_Q1_STADIUM_NORTH", cf, ( -36929.7, 25150.2, 1799.84 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Awareness_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 4000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_crash_sites";
    s.activity_bundle = "sat_activity_definition_crash_sites";
    s.name = "CRASH_SITES_Q1_STADIUM_NORTH";
    fe [[ f ]]( s, "CRASH_SITES_Q1_STADIUM_NORTH", cf, ( -36869.7, 24874.1, 1799.84 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_crash_sites";
    fe [[ f ]]( s, "CRASH_SITES_Q1_STADIUM_NORTH", cf, ( -36867.5, 25147.3, 1799.84 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Ambient_AI_Exclusion_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 2500 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_crash_sites";
    fe [[ f ]]( s, "CRASH_SITES_Q1_STADIUM_NORTH", cf, ( -36902.2, 25178.9, 1799.84 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "OB_Spacer_Spatial_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 1200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_crash_sites";
    s.groupid = "reinforcement_spawn_point_2";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "crash_site_vtol_reinforcement";
    s.variantname = "ai_encounter_spawnpoint";
    s.var_4501e0172e168ddf = "CRASH_SITES_Q1_STADIUM_NORTH_crash_site_reinforce_2";
    fe [[ f ]]( s, "CRASH_SITES_Q1_STADIUM_NORTH", cf, ( -36701.8, 26428.6, 1799.84 ), ( 0, 253.26, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_crash_sites";
    s.groupid = "reinforcement_spawn_point_1";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "crash_site_vtol_reinforcement";
    s.variantname = "ai_encounter_spawnpoint";
    s.var_4501e0172e168ddf = "CRASH_SITES_Q1_STADIUM_NORTH_crash_site_reinforce_1";
    fe [[ f ]]( s, "CRASH_SITES_Q1_STADIUM_NORTH", cf, ( -38322.2, 25367.9, 1800.5 ), ( 0, 337.3, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_crash_sites";
    s.groupid = "reinforcement_spawn_point_3";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "crash_site_vtol_reinforcement";
    s.variantname = "ai_encounter_spawnpoint";
    s.var_4501e0172e168ddf = "CRASH_SITES_Q1_STADIUM_NORTH_crash_site_reinforce_3";
    fe [[ f ]]( s, "CRASH_SITES_Q1_STADIUM_NORTH", cf, ( -35423.7, 24809.5, 1814.67 ), ( 0, 157.67, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_crash_sites";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "CRASH_SITES_Q1_STADIUM_NORTH", cf, ( -36869.3, 24612.9, 1809.43 ), ( 0, 277.8, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_crash_sites";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "CRASH_SITES_Q1_STADIUM_NORTH", cf, ( -37285.4, 24634.1, 1801.88 ), ( 0, 223.61, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_crash_sites";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "CRASH_SITES_Q1_STADIUM_NORTH", cf, ( -36388.9, 24813.5, 1800.1 ), ( 0, 344.25, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_crash_sites";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "CRASH_SITES_Q1_STADIUM_NORTH", cf, ( -37085.5, 25286.9, 1806 ), ( 0, 159.74, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_crash_sites";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "CRASH_SITES_Q1_STADIUM_NORTH", cf, ( -36661.9, 25308.6, 1799.84 ), ( 0, 88.45, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_crash_sites";
    fe [[ f ]]( s, "CRASH_SITES_Q1_CASINO_WEST", cf, ( -35903.2, 42908.6, 2264 ), ( 0, 68, 0 ), "activity_nexus_spatial_zone", undefined, "Awareness_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 6000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_crash_sites";
    s.activity_bundle = "sat_activity_definition_crash_sites";
    s.name = "CRASH_SITES_Q1_CASINO_WEST";
    fe [[ f ]]( s, "CRASH_SITES_Q1_CASINO_WEST", cf, ( -35835.1, 42869, 2264.21 ), ( 0, 68, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_crash_sites";
    fe [[ f ]]( s, "CRASH_SITES_Q1_CASINO_WEST", cf, ( -35872.3, 42880.2, 2264 ), ( 0, 68, 0 ), "activity_nexus_spatial_zone", undefined, "Ambient_AI_Exclusion_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 2500 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_crash_sites";
    fe [[ f ]]( s, "CRASH_SITES_Q1_CASINO_WEST", cf, ( -35914.4, 42872.7, 2264 ), ( 0, 68, 0 ), "activity_nexus_spatial_zone", undefined, "OB_Spacer_Spatial_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 2000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_crash_sites";
    s.groupid = "reinforcement_spawn_point_1";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "crash_site_vtol_reinforcement";
    s.variantname = "ai_encounter_spawnpoint";
    s.var_4501e0172e168ddf = "CRASH_SITES_Q1_CASINO_WEST_crash_site_reinforce_1";
    fe [[ f ]]( s, "CRASH_SITES_Q1_CASINO_WEST", cf, ( -36937.5, 41912.5, 2306.25 ), ( 0, 33.81, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_crash_sites";
    s.groupid = "reinforcement_spawn_point_2";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "crash_site_vtol_reinforcement";
    s.variantname = "ai_encounter_spawnpoint";
    s.var_4501e0172e168ddf = "CRASH_SITES_Q1_CASINO_WEST_crash_site_reinforce_2";
    fe [[ f ]]( s, "CRASH_SITES_Q1_CASINO_WEST", cf, ( -36149.3, 44638.8, 2456 ), ( 0, 280.34, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_crash_sites";
    s.groupid = "reinforcement_spawn_point_3";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "crash_site_vtol_reinforcement";
    s.variantname = "ai_encounter_spawnpoint";
    s.var_4501e0172e168ddf = "CRASH_SITES_Q1_CASINO_WEST_crash_site_reinforce_3";
    fe [[ f ]]( s, "CRASH_SITES_Q1_CASINO_WEST", cf, ( -34790.7, 42179.6, 2201.75 ), ( 0, 123.01, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_crash_sites";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "CRASH_SITES_Q1_CASINO_WEST", cf, ( -36151.3, 43145.4, 2319.29 ), ( 0, 261.24, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_crash_sites";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "CRASH_SITES_Q1_CASINO_WEST", cf, ( -35734.8, 43089.2, 2264 ), ( 0, 209.34, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_crash_sites";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "CRASH_SITES_Q1_CASINO_WEST", cf, ( -35545.5, 42591.9, 2264 ), ( 0, 142.47, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_crash_sites";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "CRASH_SITES_Q1_CASINO_WEST", cf, ( -36376.6, 42452.9, 2316.29 ), ( 0, 78.24, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_crash_sites";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "CRASH_SITES_Q1_CASINO_WEST", cf, ( -35978.1, 42082.9, 2264 ), ( 0, 358.48, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace mp_sat_avalon_q1_ob_activity_crash_sites
// Params 0, eflags: 0x4
// Checksum 0x2286bb8c, Offset: 0x1a29
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace mp_sat_avalon_q1_ob_activity_crash_sites
// Params 0
// Checksum 0x1393b847, Offset: 0x1a33
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "mp_sat_avalon_q1_ob_activity_crash_sites" );
}

// Namespace mp_sat_avalon_q1_ob_activity_crash_sites
// Params 0
// Checksum 0xe60f70f0, Offset: 0x1a49
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

// Namespace mp_sat_avalon_q1_ob_activity_crash_sites
// Params 4
// Checksum 0xb06d9ee2, Offset: 0x1ab8
// Size: 0x71
function function_d4323822d7042e5a( var_4312b79c960726b6, fe, us, cf = "mp_sat_avalon_q1_ob_activity_crash_sites" )
{
    switch ( var_4312b79c960726b6 )
    {
        case #"hash_b7c26cb7c71b8b3a":
            function_625a765c247009c2( fe, us, cf );
            break;
        case #"hash_4a6dfdd0f27119f6":
            function_7ccb5da24912005e( fe, us, cf );
            break;
    }
}

// Namespace mp_sat_avalon_q1_ob_activity_crash_sites
// Params 3
// Checksum 0xa7930e70, Offset: 0x1b31
// Size: 0xd16
function function_625a765c247009c2( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_crash_sites";
    s.groupid = "uav_path";
    s.name = "uav_stall_start";
    fe [[ f ]]( s, "CRASH_SITES_Q1_STADIUM_NORTH", cf, ( -51966.1, -1636.37, 20086.4 ), ( 0, 60.5, 0 ), "cspf_3_auto15189993556746022276", "cspf_3_auto9064631596335895924", "aircraft_crashing_start", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_crash_sites";
    s.groupid = "uav_path";
    s.name = "uav_path_start";
    fe [[ f ]]( s, "CRASH_SITES_Q1_STADIUM_NORTH", cf, ( -60855.2, -20913.1, 20086.4 ), ( 1.53, 65.04, 2.77 ), "CRASH_SITES_Q1_STADIUM_NORTH", "cspf_3_auto15189993556746022276", "aircraft_spawn", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_crash_sites";
    s.groupid = "uav_path";
    s.name = "uav_crash";
    fe [[ f ]]( s, "CRASH_SITES_Q1_STADIUM_NORTH", cf, ( -36862.4, 25055.8, 1798.75 ), ( 34.2, 60.49, 0 ), "cspf_3_auto9064631596335895924", "cspf_3_auto14961782035585675013", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 3000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_crash_sites";
    s.groupid = "uav_path";
    s.name = "uav_debris";
    fe [[ f ]]( s, "CRASH_SITES_Q1_STADIUM_NORTH", cf, ( -36887.7, 25080.5, 1799.75 ), ( 0, 167.49, 0 ), "cspf_3_auto14961782035585675013", "cspf_3_auto15113264669913142996", "uav_debris", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_crash_sites";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s.groupid = "ground_defence";
    s.height = 350;
    s.name = "black_box_trigger";
    fe [[ f ]]( s, "CRASH_SITES_Q1_STADIUM_NORTH", cf, ( -36868.8, 24877.4, 1799.78 ), ( 0, 0, 0 ), "cspf_3_auto8661027208615600838", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 500 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_crash_sites";
    s.groupid = "reinforcement_spawn_point_3";
    s.ishelistruct = 1;
    s.script_accel = "350";
    fe [[ f ]]( s, "CRASH_SITES_Q1_STADIUM_NORTH", cf, ( -35438.4, 24876.3, 2422.1 ), ( 0, 84.79, 0 ), "CRASH_SITES_Q1_STADIUM_NORTH_crash_site_reinforce_3", "cspf_3_auto178034062720265984", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_crash_sites";
    s.groupid = "reinforcement_spawn_point_3";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "CRASH_SITES_Q1_STADIUM_NORTH", cf, ( -28353.8, 32737.8, 9996.55 ), ( 359.47, 34.72, 0.49 ), "cspf_3_auto430050295470558535", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_crash_sites";
    s.groupid = "reinforcement_spawn_point_3";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "CRASH_SITES_Q1_STADIUM_NORTH", cf, ( -34678.7, 12045.3, 8850.33 ), ( 0, 96.34, 0 ), undefined, "cspf_3_auto11391291366725464300", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150, 1 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_crash_sites";
    s.groupid = "reinforcement_spawn_point_3";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "CRASH_SITES_Q1_STADIUM_NORTH", cf, ( -31765.4, 30419, 6882.54 ), ( 359.47, 49.72, 0.49 ), "cspf_3_auto178034062720265984", "cspf_3_auto430050295470558535", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_crash_sites";
    s.groupid = "reinforcement_spawn_point_3";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "CRASH_SITES_Q1_STADIUM_NORTH", cf, ( -35193.4, 17588.5, 7772.79 ), ( 0, 99.46, 0 ), "cspf_3_auto11391291366725464300", "CRASH_SITES_Q1_STADIUM_NORTH_crash_site_reinforce_3", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_crash_sites";
    s.groupid = "reinforcement_spawn_point_1";
    s.name = "agent_rally_point";
    fe [[ f ]]( s, "CRASH_SITES_Q1_STADIUM_NORTH", cf, ( -38308.7, 25353.6, 1800.5 ), ( 0, 25.61, 0 ), "cspf_3_auto8661027208615600838", undefined, "agent_rally_point", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 512 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_crash_sites";
    s.groupid = "ground_defence";
    s.name = "blackbox";
    fe [[ f ]]( s, "CRASH_SITES_Q1_STADIUM_NORTH", cf, ( -36868.3, 24873, 1799.61 ), ( 0, 0, 0 ), "cspf_3_auto14961782035585675013", "cspf_3_auto8661027208615600838", "black_box", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_crash_sites";
    s.groupid = "reinforcement_spawn_point_2";
    s.name = "agent_rally_point";
    fe [[ f ]]( s, "CRASH_SITES_Q1_STADIUM_NORTH", cf, ( -36704.5, 26434.2, 1799.84 ), ( 0, 291.45, 0 ), "cspf_3_auto8661027208615600838", undefined, "agent_rally_point", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 512 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_crash_sites";
    s.groupid = "reinforcement_spawn_point_3";
    s.name = "agent_rally_point";
    fe [[ f ]]( s, "CRASH_SITES_Q1_STADIUM_NORTH", cf, ( -35390.4, 24793.8, 1813.97 ), ( 0, 0, 0 ), "cspf_3_auto8661027208615600838", undefined, "agent_rally_point", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 512 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_crash_sites";
    s.groupid = "reinforcement_spawn_point_2";
    s.ishelistruct = 1;
    s.script_accel = "350";
    fe [[ f ]]( s, "CRASH_SITES_Q1_STADIUM_NORTH", cf, ( -36684.3, 26429.1, 2422.1 ), ( 0, 179.78, 0 ), "CRASH_SITES_Q1_STADIUM_NORTH_crash_site_reinforce_2", "cspf_3_auto16476435229748484067", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_crash_sites";
    s.groupid = "reinforcement_spawn_point_2";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "CRASH_SITES_Q1_STADIUM_NORTH", cf, ( -44764.8, 33056.9, 9996.55 ), ( 359.47, 129.72, 0.49 ), "cspf_3_auto15133233921356921399", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_crash_sites";
    s.groupid = "reinforcement_spawn_point_2";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "CRASH_SITES_Q1_STADIUM_NORTH", cf, ( -23599.8, 28559.5, 8850.33 ), ( 0, 191.34, 0 ), undefined, "cspf_3_auto3033464681896208648", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150, 1 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_crash_sites";
    s.groupid = "reinforcement_spawn_point_2";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "CRASH_SITES_Q1_STADIUM_NORTH", cf, ( -41837.5, 30360.4, 6882.54 ), ( 359.47, 144.72, 0.49 ), "cspf_3_auto16476435229748484067", "cspf_3_auto15133233921356921399", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_crash_sites";
    s.groupid = "reinforcement_spawn_point_2";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "CRASH_SITES_Q1_STADIUM_NORTH", cf, ( -29077.1, 27563.7, 7772.79 ), ( 0, 194.46, 0 ), "cspf_3_auto3033464681896208648", "CRASH_SITES_Q1_STADIUM_NORTH_crash_site_reinforce_2", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_crash_sites";
    s.groupid = "reinforcement_spawn_point_1";
    s.ishelistruct = 1;
    s.script_accel = "350";
    fe [[ f ]]( s, "CRASH_SITES_Q1_STADIUM_NORTH", cf, ( -38394.2, 25379.2, 2430.1 ), ( 0, 259.79, 0 ), "CRASH_SITES_Q1_STADIUM_NORTH_crash_site_reinforce_1", "cspf_3_auto11248929620292874554", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_crash_sites";
    s.groupid = "reinforcement_spawn_point_1";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "CRASH_SITES_Q1_STADIUM_NORTH", cf, ( -46274, 18678.6, 9996.55 ), ( 359.47, 209.72, 0.49 ), "cspf_3_auto8636807974739456789", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_crash_sites";
    s.groupid = "reinforcement_spawn_point_1";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "CRASH_SITES_Q1_STADIUM_NORTH", cf, ( -38169.7, 38741.1, 8850.33 ), ( 0, 271.34, 0 ), undefined, "cspf_3_auto4725294674241269596", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150, 1 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_crash_sites";
    s.groupid = "reinforcement_spawn_point_1";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "CRASH_SITES_Q1_STADIUM_NORTH", cf, ( -43110.2, 21093.2, 6882.54 ), ( 359.47, 224.72, 0.49 ), "cspf_3_auto11248929620292874554", "cspf_3_auto8636807974739456789", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_crash_sites";
    s.groupid = "reinforcement_spawn_point_1";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "CRASH_SITES_Q1_STADIUM_NORTH", cf, ( -38140.1, 33174.1, 7772.79 ), ( 0, 274.46, 0 ), "cspf_3_auto4725294674241269596", "CRASH_SITES_Q1_STADIUM_NORTH_crash_site_reinforce_1", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
}

// Namespace mp_sat_avalon_q1_ob_activity_crash_sites
// Params 3
// Checksum 0xba7c7a84, Offset: 0x284f
// Size: 0xd16
function function_7ccb5da24912005e( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_crash_sites";
    s.groupid = "uav_path";
    s.name = "uav_stall_start";
    fe [[ f ]]( s, "CRASH_SITES_Q1_CASINO_WEST", cf, ( -9506, 34869.4, 13914.3 ), ( 0, 163.59, 0 ), "cspf_4_auto15189993556746022276", "cspf_4_auto9064631596335895924", "aircraft_crashing_start", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_crash_sites";
    s.groupid = "uav_path";
    s.name = "uav_path_start";
    fe [[ f ]]( s, "CRASH_SITES_Q1_CASINO_WEST", cf, ( 9069.7, 29872.1, 17048.5 ), ( 1.53, 164.75, 2.77 ), "CRASH_SITES_Q1_CASINO_WEST", "cspf_4_auto15189993556746022276", "aircraft_spawn", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_crash_sites";
    s.groupid = "uav_path";
    s.name = "uav_crash";
    fe [[ f ]]( s, "CRASH_SITES_Q1_CASINO_WEST", cf, ( -35914.9, 42736.8, 2265.51 ), ( 22.98, 163.02, 0 ), "cspf_4_auto9064631596335895924", "cspf_4_auto14961782035585675013", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 4500 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_crash_sites";
    s.groupid = "uav_path";
    s.name = "uav_debris";
    fe [[ f ]]( s, "CRASH_SITES_Q1_CASINO_WEST", cf, ( -35924.5, 42725.6, 2265.52 ), ( 0, 235.48, 0 ), "cspf_4_auto14961782035585675013", "cspf_4_auto15113264669913142996", "uav_debris", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_crash_sites";
    s.groupid = "reinforcement_spawn_point_2";
    s.ishelistruct = 1;
    s.script_accel = "350";
    fe [[ f ]]( s, "CRASH_SITES_Q1_CASINO_WEST", cf, ( -36183.6, 44539.3, 3051.85 ), ( 0, 224.79, 0 ), "CRASH_SITES_Q1_CASINO_WEST_crash_site_reinforce_2", "cspf_4_auto14059806740265918601", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_crash_sites";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s.groupid = "ground_defence";
    s.height = 300;
    s.name = "black_box_trigger";
    fe [[ f ]]( s, "CRASH_SITES_Q1_CASINO_WEST", cf, ( -35909.3, 42730.5, 2229.45 ), ( 0, 0, 0 ), "cspf_4_auto8661027208615600838", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 500 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_crash_sites";
    s.groupid = "reinforcement_spawn_point_2";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "CRASH_SITES_Q1_CASINO_WEST", cf, ( -40798.5, 35167.3, 10626.3 ), ( 359.47, 244.72, 0.49 ), "cspf_4_auto12617976545171932046", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_crash_sites";
    s.groupid = "reinforcement_spawn_point_2";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "CRASH_SITES_Q1_CASINO_WEST", cf, ( -28435.4, 54790.9, 9480.08 ), ( 0, 236.34, 0 ), undefined, "cspf_4_auto12000072573179150406", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150, 1 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_crash_sites";
    s.groupid = "reinforcement_spawn_point_2";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "CRASH_SITES_Q1_CASINO_WEST", cf, ( -39159.3, 38941.8, 7512.29 ), ( 359.47, 239.72, 0.49 ), "cspf_4_auto14059806740265918601", "cspf_4_auto12617976545171932046", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_crash_sites";
    s.groupid = "reinforcement_spawn_point_2";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "CRASH_SITES_Q1_CASINO_WEST", cf, ( -31604.2, 50213.7, 8402.54 ), ( 0, 239.46, 0 ), "cspf_4_auto12000072573179150406", "CRASH_SITES_Q1_CASINO_WEST_crash_site_reinforce_2", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_crash_sites";
    s.groupid = "reinforcement_spawn_point_1";
    s.name = "agent_rally_point";
    fe [[ f ]]( s, "CRASH_SITES_Q1_CASINO_WEST", cf, ( -36946.2, 41924.2, 2306.25 ), ( 0, 93.61, 0 ), "cspf_4_auto8661027208615600838", undefined, "agent_rally_point", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 512 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_crash_sites";
    s.groupid = "ground_defence";
    s.name = "blackbox";
    fe [[ f ]]( s, "CRASH_SITES_Q1_CASINO_WEST", cf, ( -35908.9, 42734.5, 2265.43 ), ( 6.12, 55.42, -3.73 ), "cspf_4_auto14961782035585675013", "cspf_4_auto8661027208615600838", "black_box", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_crash_sites";
    s.groupid = "reinforcement_spawn_point_3";
    s.name = "agent_rally_point";
    fe [[ f ]]( s, "CRASH_SITES_Q1_CASINO_WEST", cf, ( -34803.7, 42188.2, 2201.75 ), ( 0, 29.45, 0 ), "cspf_4_auto8661027208615600838", undefined, "agent_rally_point", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 512 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_crash_sites";
    s.groupid = "reinforcement_spawn_point_2";
    s.name = "agent_rally_point";
    fe [[ f ]]( s, "CRASH_SITES_Q1_CASINO_WEST", cf, ( -36152.4, 44610.9, 2449.97 ), ( 0, 68, 0 ), "cspf_4_auto8661027208615600838", undefined, "agent_rally_point", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 512 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_crash_sites";
    s.groupid = "reinforcement_spawn_point_3";
    s.ishelistruct = 1;
    s.script_accel = "350";
    fe [[ f ]]( s, "CRASH_SITES_Q1_CASINO_WEST", cf, ( -34812.7, 42218.6, 2799.85 ), ( 0, 64.79, 0 ), "CRASH_SITES_Q1_CASINO_WEST_crash_site_reinforce_3", "cspf_4_auto178034062720265984", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_crash_sites";
    s.groupid = "reinforcement_spawn_point_3";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "CRASH_SITES_Q1_CASINO_WEST", cf, ( -25768.8, 46773.6, 10374.3 ), ( 359.47, 14.72, 0.49 ), "cspf_4_auto430050295470558535", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_crash_sites";
    s.groupid = "reinforcement_spawn_point_3";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "CRASH_SITES_Q1_CASINO_WEST", cf, ( -38621.5, 30035.6, 9228.08 ), ( 0, 76.34, 0 ), undefined, "cspf_4_auto11391291366725464300", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150, 1 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_crash_sites";
    s.groupid = "reinforcement_spawn_point_3";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "CRASH_SITES_Q1_CASINO_WEST", cf, ( -30523.6, 44772.4, 7260.29 ), ( 359.47, 29.72, 0.49 ), "cspf_4_auto178034062720265984", "cspf_4_auto430050295470558535", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_crash_sites";
    s.groupid = "reinforcement_spawn_point_3";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "CRASH_SITES_Q1_CASINO_WEST", cf, ( -37209.3, 35420.5, 8150.54 ), ( 0, 79.46, 0 ), "cspf_4_auto11391291366725464300", "CRASH_SITES_Q1_CASINO_WEST_crash_site_reinforce_3", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_crash_sites";
    s.groupid = "reinforcement_spawn_point_1";
    s.ishelistruct = 1;
    s.script_accel = "350";
    fe [[ f ]]( s, "CRASH_SITES_Q1_CASINO_WEST", cf, ( -37047.1, 41799.9, 2899.85 ), ( 0, 149.79, 0 ), "CRASH_SITES_Q1_CASINO_WEST_crash_site_reinforce_1", "cspf_4_auto3361718903813266581", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_crash_sites";
    s.groupid = "reinforcement_spawn_point_1";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "CRASH_SITES_Q1_CASINO_WEST", cf, ( -42703.5, 50769.5, 10474.3 ), ( 359.47, 114.72, 0.49 ), "cspf_4_auto2280495460338483591", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_crash_sites";
    s.groupid = "reinforcement_spawn_point_1";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "CRASH_SITES_Q1_CASINO_WEST", cf, ( -24556.9, 39161.4, 9328.08 ), ( 0, 171.34, 0 ), undefined, "cspf_4_auto4979583464332202275", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150, 1 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_crash_sites";
    s.groupid = "reinforcement_spawn_point_1";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "CRASH_SITES_Q1_CASINO_WEST", cf, ( -40865.8, 47087.6, 7360.29 ), ( 359.47, 109.72, 0.49 ), "cspf_4_auto3361718903813266581", "cspf_4_auto2280495460338483591", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_crash_sites";
    s.groupid = "reinforcement_spawn_point_1";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "CRASH_SITES_Q1_CASINO_WEST", cf, ( -30044.4, 40098.9, 8250.54 ), ( 0, 174.46, 0 ), "cspf_4_auto4979583464332202275", "CRASH_SITES_Q1_CASINO_WEST_crash_site_reinforce_1", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
}

// Namespace mp_sat_avalon_q1_ob_activity_crash_sites
// Params 0
// Checksum 0x210ae66c, Offset: 0x356d
// Size: 0x143
function function_d9dd7965c51c95d1()
{
    activityinstances = [];
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_activity_definition_crash_sites";
    var_881289d7987bc770.cf = "mp_sat_avalon_q1_ob_activity_crash_sites";
    var_881289d7987bc770.scriptstructorigin = ( -36869.7, 24874.1, 1799.84 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [];
    var_881289d7987bc770.var_31ce4477e3543d24 = [];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [];
    var_881289d7987bc770.locationradius = [];
    activityinstances[ "CRASH_SITES_Q1_STADIUM_NORTH" ] = var_881289d7987bc770;
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_activity_definition_crash_sites";
    var_881289d7987bc770.cf = "mp_sat_avalon_q1_ob_activity_crash_sites";
    var_881289d7987bc770.scriptstructorigin = ( -35835.1, 42869, 2264.21 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [];
    var_881289d7987bc770.var_31ce4477e3543d24 = [];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [];
    var_881289d7987bc770.locationradius = [];
    activityinstances[ "CRASH_SITES_Q1_CASINO_WEST" ] = var_881289d7987bc770;
    return activityinstances;
}

