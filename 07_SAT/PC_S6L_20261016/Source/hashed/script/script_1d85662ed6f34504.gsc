// script_1d85662ed6f34504  (hash_1d85662ed6f34504.gscc) (size: 11189 Bytes / 0x2bb5 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x1b52cfce (458411982)
// size ...... 11189 (0x2bb5)
// includes .. 4   (offset: 0x25e1)
// strings ... 55  (offset: 0x2601)
// dev strs .. 0   (offset: 0x2bb5)
// exports ... 13  (offset: 0x20fd)
// cseg ...... 0x608 + 0x1af5 (0x20fd)
// imports ... 26  (offset: 0x2305)
// animtree1 . 0   (offset: 0x2bb5)
// animtree2 . 0   (offset: 0x2bb5)
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace mp_sat_avalon_q1_ob_contract_heist_cs;

// Namespace mp_sat_avalon_q1_ob_contract_heist_cs
// Params 0, eflags: 0x5
// Checksum 0x7f436adf, Offset: 0x626
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"mp_sat_avalon_q1_ob_contract_heist_cs", #"activity_common", &function_b39ecd3d51489472, undefined );
}

// Namespace mp_sat_avalon_q1_ob_contract_heist_cs
// Params 0, eflags: 0x4
// Checksum 0xfd2fe240, Offset: 0x64f
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace mp_sat_avalon_q1_ob_contract_heist_cs
// Params 0, eflags: 0x4
// Checksum 0x781431ac, Offset: 0x660
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace mp_sat_avalon_q1_ob_contract_heist_cs
// Params 2
// Checksum 0x7d662728, Offset: 0x671
// Size: 0x8c
function main( unused, unused2 )
{
    if ( utility::flag_exist( "mp_sat_avalon_q1_ob_contract_heist_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "mp_sat_avalon_q1_ob_contract_heist_cs" ) )
    {
        return;
    }
    
    activity_common::function_e1df676808c1d1e3( &function_4cd78e661617f3 );
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "mp_sat_avalon_q1_ob_contract_heist_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "mp_sat_avalon_q1_ob_contract_heist_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace mp_sat_avalon_q1_ob_contract_heist_cs
// Params 3, eflags: 0x4
// Checksum 0xfb968563, Offset: 0x705
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "mp_sat_avalon_q1_ob_contract_heist_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "mp_sat_avalon_q1_ob_contract_heist_cs" );
}

// Namespace mp_sat_avalon_q1_ob_contract_heist_cs
// Params 3, eflags: 0x4
// Checksum 0xea54c6f8, Offset: 0x77f
// Size: 0xa13
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_heist_cs";
    s.name = "contract_heist_qzone_terminal";
    fe [[ f ]]( s, us, cf, ( -14184.3, 13878.7, 1292 ), ( 0, 292, 0 ), undefined, undefined, "Qzone_terminal_for_Heist" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_heist_cs";
    s.name = "contract_heist_qzone_terminal";
    fe [[ f ]]( s, us, cf, ( -14693.4, 51718.9, 744 ), ( 0, 184, 0 ), undefined, undefined, "Qzone_terminal_for_Heist" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_heist_cs";
    s.name = "contract_heist_qzone_terminal";
    fe [[ f ]]( s, us, cf, ( -33396, 36552.5, 2172 ), ( 0, 321, 0 ), undefined, undefined, "Qzone_terminal_for_Heist" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_heist_cs";
    s.name = "contract_heist_qzone_terminal";
    fe [[ f ]]( s, us, cf, ( -51926.1, 6529.76, 528 ), ( 0, 0, 0 ), undefined, undefined, "Qzone_terminal_for_Heist" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_heist_cs";
    s.activity_bundle = "sat_activitydefinition_heist";
    s.name = "CONTRACT_HEIST_Q1_GOLF_COURSE";
    s.var_7a0840be22b9ebb = "CRASH_SITES_Q1_CASINO_WEST";
    fe [[ f ]]( s, "CONTRACT_HEIST_Q1_GOLF_COURSE", cf, ( -35911.6, 42735.5, 2265.44 ), ( 0, 290, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_heist_cs";
    fe [[ f ]]( s, "CONTRACT_HEIST_Q1_GOLF_COURSE", cf, ( -28042.7, 35429.9, 1672.69 ), ( 0, 21.36, 0 ), "activity_nexus_instance_joiner", undefined, "CONTRACT_HEIST_Q1_GOLF_COURSE", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_heist_cs";
    s.groupid = "reinforcement_spawn_point_1";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "heist_vtol_reinforcement";
    s.variantname = "ai_encounter_spawnpoint";
    s.var_4501e0172e168ddf = "CONTRACT_HEIST_Q1_GOLF_COURSE_crash_site_reinforce_1";
    fe [[ f ]]( s, "CONTRACT_HEIST_Q1_GOLF_COURSE", cf, ( -36937.5, 41912.5, 2306.25 ), ( 0, 33.81, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_heist_cs";
    s.groupid = "reinforcement_spawn_point_2";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "heist_vtol_reinforcement";
    s.variantname = "ai_encounter_spawnpoint";
    s.var_4501e0172e168ddf = "CONTRACT_HEIST_Q1_GOLF_COURSE_crash_site_reinforce_2";
    fe [[ f ]]( s, "CONTRACT_HEIST_Q1_GOLF_COURSE", cf, ( -36149.3, 44638.8, 2456 ), ( 0, 280.34, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_heist_cs";
    s.groupid = "reinforcement_spawn_point_3";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "heist_vtol_reinforcement";
    s.variantname = "ai_encounter_spawnpoint";
    s.var_4501e0172e168ddf = "CONTRACT_HEIST_Q1_GOLF_COURSE_crash_site_reinforce_3";
    fe [[ f ]]( s, "CONTRACT_HEIST_Q1_GOLF_COURSE", cf, ( -34790.7, 42179.6, 2201.75 ), ( 0, 123.01, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_heist_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "CONTRACT_HEIST_Q1_GOLF_COURSE", cf, ( -36151.3, 43145.4, 2319.29 ), ( 0, 261.24, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_heist_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "CONTRACT_HEIST_Q1_GOLF_COURSE", cf, ( -35734.8, 43089.2, 2264 ), ( 0, 209.34, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_heist_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "CONTRACT_HEIST_Q1_GOLF_COURSE", cf, ( -35545.5, 42591.9, 2264 ), ( 0, 142.47, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_heist_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "CONTRACT_HEIST_Q1_GOLF_COURSE", cf, ( -36376.6, 42452.9, 2316.29 ), ( 0, 78.24, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_heist_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "CONTRACT_HEIST_Q1_GOLF_COURSE", cf, ( -35978.1, 42082.9, 2264 ), ( 0, 358.48, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_heist_cs";
    fe [[ f ]]( s, "CONTRACT_HEIST_Q1_GOLF_COURSE", cf, ( -35903.2, 42908.6, 2264 ), ( 0, 68, 0 ), "activity_nexus_spatial_zone", undefined, "Awareness_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 6000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_heist_cs";
    fe [[ f ]]( s, "CONTRACT_HEIST_Q1_GOLF_COURSE", cf, ( -35872.3, 42880.2, 2264 ), ( 0, 68, 0 ), "activity_nexus_spatial_zone", undefined, "Ambient_AI_Exclusion_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 4000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_heist_cs";
    fe [[ f ]]( s, "CONTRACT_HEIST_Q1_GOLF_COURSE", cf, ( -35914.4, 42872.7, 2264 ), ( 0, 68, 0 ), "activity_nexus_spatial_zone", undefined, "OB_Spacer_Spatial_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 2000 );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace mp_sat_avalon_q1_ob_contract_heist_cs
// Params 0, eflags: 0x4
// Checksum 0x6ae29365, Offset: 0x119a
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace mp_sat_avalon_q1_ob_contract_heist_cs
// Params 0
// Checksum 0x39c5582e, Offset: 0x11a4
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "mp_sat_avalon_q1_ob_contract_heist_cs" );
}

// Namespace mp_sat_avalon_q1_ob_contract_heist_cs
// Params 0
// Checksum 0x60eaafde, Offset: 0x11ba
// Size: 0x66
function function_4cd78e661617f3()
{
    activityinfostruct = {};
    activityinfostruct.name = "REV_OB_HEIST";
    activityinfostruct.scriptbundle = "sat_activitydefinition_heist";
    activityinfostruct.mainfunction = &main;
    activityinfostruct.var_934f068483ae4ddb = &function_d4323822d7042e5a;
    activityinfostruct.metadatafunction = &function_d9dd7965c51c95d1;
    return activityinfostruct;
}

// Namespace mp_sat_avalon_q1_ob_contract_heist_cs
// Params 4
// Checksum 0xf34330fa, Offset: 0x1229
// Size: 0x57
function function_d4323822d7042e5a( var_4312b79c960726b6, fe, us, cf = "mp_sat_avalon_q1_ob_contract_heist_cs" )
{
    switch ( var_4312b79c960726b6 )
    {
        case #"hash_4c7216b185226eef":
            function_ef432f5c195491a7( fe, us, cf );
            break;
    }
}

// Namespace mp_sat_avalon_q1_ob_contract_heist_cs
// Params 3
// Checksum 0x97e276a5, Offset: 0x1288
// Size: 0xdad
function function_ef432f5c195491a7( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_heist_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s.groupid = "ground_defence";
    s.height = 300;
    s.name = "black_box_trigger";
    fe [[ f ]]( s, "CONTRACT_HEIST_Q1_GOLF_COURSE", cf, ( -35909.3, 42730.5, 2229.45 ), ( 0, 0, 0 ), "cspf_2_auto8661027208615600838", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 500 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_heist_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s.height = 5000;
    s.name = "crash_approximity_trigger";
    fe [[ f ]]( s, "CONTRACT_HEIST_Q1_GOLF_COURSE", cf, ( -35775.7, 43277.3, 1616.37 ), ( 359.6, 219.57, 1.53 ), "cspf_2_auto14961782035585675013", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 5000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_heist_cs";
    s.groupid = "uav_path";
    s.name = "uav_stall_start";
    fe [[ f ]]( s, "CONTRACT_HEIST_Q1_GOLF_COURSE", cf, ( -9506, 34869.4, 13914.3 ), ( 0, 163.59, 0 ), "cspf_2_auto15189993556746022276", "cspf_2_auto9064631596335895924", "aircraft_crashing_start", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_heist_cs";
    s.groupid = "uav_path";
    s.name = "uav_path_start";
    fe [[ f ]]( s, "CONTRACT_HEIST_Q1_GOLF_COURSE", cf, ( 9069.7, 29872.1, 17048.5 ), ( 1.53, 164.75, 2.77 ), "CONTRACT_HEIST_Q1_GOLF_COURSE", "cspf_2_auto15189993556746022276", "aircraft_spawn", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_heist_cs";
    s.groupid = "uav_path";
    s.name = "uav_crash";
    fe [[ f ]]( s, "CONTRACT_HEIST_Q1_GOLF_COURSE", cf, ( -35914.9, 42736.8, 2265.51 ), ( 22.98, 163.02, 0 ), "cspf_2_auto9064631596335895924", "cspf_2_auto14961782035585675013", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_heist_cs";
    s.groupid = "uav_path";
    s.name = "uav_debris";
    fe [[ f ]]( s, "CONTRACT_HEIST_Q1_GOLF_COURSE", cf, ( -35924.5, 42725.6, 2265.52 ), ( 0, 235.48, 0 ), "cspf_2_auto14961782035585675013", undefined, "uav_debris", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_heist_cs";
    s.groupid = "reinforcement_spawn_point_1";
    s.name = "agent_rally_point";
    fe [[ f ]]( s, "CONTRACT_HEIST_Q1_GOLF_COURSE", cf, ( -36946.2, 41924.2, 2306.25 ), ( 0, 93.61, 0 ), "cspf_2_auto8661027208615600838", undefined, "agent_rally_point", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 512 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_heist_cs";
    s.groupid = "ground_defence";
    s.name = "blackbox";
    fe [[ f ]]( s, "CONTRACT_HEIST_Q1_GOLF_COURSE", cf, ( -35908.9, 42734.5, 2265.43 ), ( 6.12, 55.42, -3.73 ), "cspf_2_auto14961782035585675013", "cspf_2_auto8661027208615600838", "black_box", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_heist_cs";
    s.groupid = "reinforcement_spawn_point_3";
    s.name = "agent_rally_point";
    fe [[ f ]]( s, "CONTRACT_HEIST_Q1_GOLF_COURSE", cf, ( -34803.7, 42188.2, 2201.75 ), ( 0, 29.45, 0 ), "cspf_2_auto8661027208615600838", undefined, "agent_rally_point", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 512 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_heist_cs";
    s.groupid = "reinforcement_spawn_point_2";
    s.name = "agent_rally_point";
    fe [[ f ]]( s, "CONTRACT_HEIST_Q1_GOLF_COURSE", cf, ( -36152.4, 44610.9, 2449.97 ), ( 0, 68, 0 ), "cspf_2_auto8661027208615600838", undefined, "agent_rally_point", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 512 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_heist_cs";
    s.groupid = "reinforcement_spawn_point_1";
    s.ishelistruct = 1;
    s.script_accel = "350";
    fe [[ f ]]( s, "CONTRACT_HEIST_Q1_GOLF_COURSE", cf, ( -37047.1, 41799.9, 2899.85 ), ( 0, 149.79, 0 ), "CONTRACT_HEIST_Q1_GOLF_COURSE_crash_site_reinforce_1", "cspf_2_auto3361718903813266581", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_heist_cs";
    s.groupid = "reinforcement_spawn_point_1";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "CONTRACT_HEIST_Q1_GOLF_COURSE", cf, ( -42703.5, 50769.5, 10474.3 ), ( 359.47, 114.72, 0.49 ), "cspf_2_auto2280495460338483591", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_heist_cs";
    s.groupid = "reinforcement_spawn_point_1";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "CONTRACT_HEIST_Q1_GOLF_COURSE", cf, ( -24556.9, 39161.4, 9328.08 ), ( 0, 171.34, 0 ), undefined, "cspf_2_auto4979583464332202275", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150, 1 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_heist_cs";
    s.groupid = "reinforcement_spawn_point_1";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "CONTRACT_HEIST_Q1_GOLF_COURSE", cf, ( -40865.8, 47087.6, 7360.29 ), ( 359.47, 109.72, 0.49 ), "cspf_2_auto3361718903813266581", "cspf_2_auto2280495460338483591", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_heist_cs";
    s.groupid = "reinforcement_spawn_point_1";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "CONTRACT_HEIST_Q1_GOLF_COURSE", cf, ( -30044.4, 40098.9, 8250.54 ), ( 0, 174.46, 0 ), "cspf_2_auto4979583464332202275", "CONTRACT_HEIST_Q1_GOLF_COURSE_crash_site_reinforce_1", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_heist_cs";
    s.groupid = "reinforcement_spawn_point_2";
    s.ishelistruct = 1;
    s.script_accel = "350";
    fe [[ f ]]( s, "CONTRACT_HEIST_Q1_GOLF_COURSE", cf, ( -36183.6, 44539.3, 3051.85 ), ( 0, 224.79, 0 ), "CONTRACT_HEIST_Q1_GOLF_COURSE_crash_site_reinforce_2", "cspf_2_auto14059806740265918601", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_heist_cs";
    s.groupid = "reinforcement_spawn_point_2";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "CONTRACT_HEIST_Q1_GOLF_COURSE", cf, ( -40798.5, 35167.3, 10626.3 ), ( 359.47, 244.72, 0.49 ), "cspf_2_auto12617976545171932046", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_heist_cs";
    s.groupid = "reinforcement_spawn_point_2";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "CONTRACT_HEIST_Q1_GOLF_COURSE", cf, ( -28435.4, 54790.9, 9480.08 ), ( 0, 236.34, 0 ), undefined, "cspf_2_auto12000072573179150406", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150, 1 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_heist_cs";
    s.groupid = "reinforcement_spawn_point_2";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "CONTRACT_HEIST_Q1_GOLF_COURSE", cf, ( -39159.3, 38941.8, 7512.29 ), ( 359.47, 239.72, 0.49 ), "cspf_2_auto14059806740265918601", "cspf_2_auto12617976545171932046", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_heist_cs";
    s.groupid = "reinforcement_spawn_point_2";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "CONTRACT_HEIST_Q1_GOLF_COURSE", cf, ( -31604.2, 50213.7, 8402.54 ), ( 0, 239.46, 0 ), "cspf_2_auto12000072573179150406", "CONTRACT_HEIST_Q1_GOLF_COURSE_crash_site_reinforce_2", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_heist_cs";
    s.groupid = "reinforcement_spawn_point_3";
    s.ishelistruct = 1;
    s.script_accel = "350";
    fe [[ f ]]( s, "CONTRACT_HEIST_Q1_GOLF_COURSE", cf, ( -34812.7, 42218.6, 2799.85 ), ( 0, 64.79, 0 ), "CONTRACT_HEIST_Q1_GOLF_COURSE_crash_site_reinforce_3", "cspf_2_auto178034062720265984", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_heist_cs";
    s.groupid = "reinforcement_spawn_point_3";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "CONTRACT_HEIST_Q1_GOLF_COURSE", cf, ( -25768.8, 46773.6, 10374.3 ), ( 359.47, 14.72, 0.49 ), "cspf_2_auto430050295470558535", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_heist_cs";
    s.groupid = "reinforcement_spawn_point_3";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "CONTRACT_HEIST_Q1_GOLF_COURSE", cf, ( -38621.5, 30035.6, 9228.08 ), ( 0, 76.34, 0 ), undefined, "cspf_2_auto11391291366725464300", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150, 1 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_heist_cs";
    s.groupid = "reinforcement_spawn_point_3";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "CONTRACT_HEIST_Q1_GOLF_COURSE", cf, ( -30523.6, 44772.4, 7260.29 ), ( 359.47, 29.72, 0.49 ), "cspf_2_auto178034062720265984", "cspf_2_auto430050295470558535", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_heist_cs";
    s.groupid = "reinforcement_spawn_point_3";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "CONTRACT_HEIST_Q1_GOLF_COURSE", cf, ( -37209.3, 35420.5, 8150.54 ), ( 0, 79.46, 0 ), "cspf_2_auto11391291366725464300", "CONTRACT_HEIST_Q1_GOLF_COURSE_crash_site_reinforce_3", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
}

// Namespace mp_sat_avalon_q1_ob_contract_heist_cs
// Params 0
// Checksum 0x408a3e94, Offset: 0x203d
// Size: 0xbf
function function_d9dd7965c51c95d1()
{
    activityinstances = [];
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_activitydefinition_heist";
    var_881289d7987bc770.var_7a0840be22b9ebb = "CRASH_SITES_Q1_CASINO_WEST";
    var_881289d7987bc770.cf = "mp_sat_avalon_q1_ob_contract_heist_cs";
    var_881289d7987bc770.scriptstructorigin = ( -35911.6, 42735.5, 2265.44 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [];
    var_881289d7987bc770.var_31ce4477e3543d24 = [];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [];
    var_881289d7987bc770.locationradius = [];
    activityinstances[ "CONTRACT_HEIST_Q1_GOLF_COURSE" ] = var_881289d7987bc770;
    return activityinstances;
}

