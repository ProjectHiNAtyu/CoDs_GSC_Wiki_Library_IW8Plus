// script_7fe01263a2adb813  (hash_7fe01263a2adb813.gscc) (size: 14238 Bytes / 0x379e / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x657b277d (1702569853)
// size ...... 14238 (0x379e)
// includes .. 4   (offset: 0x3022)
// strings ... 65  (offset: 0x3042)
// dev strs .. 0   (offset: 0x379e)
// exports ... 14  (offset: 0x2af6)
// cseg ...... 0x79a + 0x235c (0x2af6)
// imports ... 27  (offset: 0x2d26)
// animtree1 . 0   (offset: 0x379e)
// animtree2 . 0   (offset: 0x379e)
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace mp_sat_avalon_quad_03_ob_activity_crash_sites_cs;

// Namespace mp_sat_avalon_quad_03_ob_activity_crash_sites_cs
// Params 0, eflags: 0x5
// Checksum 0xca672b8, Offset: 0x7b8
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"mp_sat_avalon_quad_03_ob_activity_crash_sites_cs", #"activity_common", &function_b39ecd3d51489472, undefined );
}

// Namespace mp_sat_avalon_quad_03_ob_activity_crash_sites_cs
// Params 0, eflags: 0x4
// Checksum 0x3f122d10, Offset: 0x7e1
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace mp_sat_avalon_quad_03_ob_activity_crash_sites_cs
// Params 0, eflags: 0x4
// Checksum 0xba29fefc, Offset: 0x7f2
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace mp_sat_avalon_quad_03_ob_activity_crash_sites_cs
// Params 2
// Checksum 0x7a5ce115, Offset: 0x803
// Size: 0x8c
function main( unused, unused2 )
{
    if ( utility::flag_exist( "mp_sat_avalon_quad_03_ob_activity_crash_sites_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "mp_sat_avalon_quad_03_ob_activity_crash_sites_cs" ) )
    {
        return;
    }
    
    activity_common::function_e1df676808c1d1e3( &function_4cd78e661617f3 );
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "mp_sat_avalon_quad_03_ob_activity_crash_sites_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "mp_sat_avalon_quad_03_ob_activity_crash_sites_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace mp_sat_avalon_quad_03_ob_activity_crash_sites_cs
// Params 3, eflags: 0x4
// Checksum 0x39ab4a33, Offset: 0x897
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "mp_sat_avalon_quad_03_ob_activity_crash_sites_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "mp_sat_avalon_quad_03_ob_activity_crash_sites_cs" );
}

// Namespace mp_sat_avalon_quad_03_ob_activity_crash_sites_cs
// Params 3, eflags: 0x4
// Checksum 0xbf908c78, Offset: 0x911
// Size: 0x885
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_crash_sites_cs";
    s.activity_bundle = "sat_activity_definition_crash_sites";
    s.name = "CRASH_SITES_Q3_COAST_GUARD";
    fe [[ f ]]( s, "CRASH_SITES_Q3_COAST_GUARD", cf, ( -43232.9, -14524.3, 532.66 ), ( 0, 5, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_crash_sites_cs";
    fe [[ f ]]( s, "CRASH_SITES_Q3_COAST_GUARD", cf, ( -43170.5, -14488.2, 520.34 ), ( 0, 5, 0 ), "activity_nexus_spatial_zone", undefined, "Awareness_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 7000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_crash_sites_cs";
    s.groupid = "reinforcement_spawn_point_2";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "crash_site_vtol_reinforcement";
    s.variantname = "ai_encounter_spawnpoint";
    s.var_4501e0172e168ddf = "CRASH_SITES_Q3_COAST_GUARD_crash_site_reinforce_2";
    fe [[ f ]]( s, "CRASH_SITES_Q3_COAST_GUARD", cf, ( -41359.9, -13823.8, 329.66 ), ( 0, 203.63, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_crash_sites_cs";
    s.groupid = "reinforcement_spawn_point_1";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "crash_site_vtol_reinforcement";
    s.variantname = "ai_encounter_spawnpoint";
    s.var_4501e0172e168ddf = "CRASH_SITES_Q3_COAST_GUARD_crash_site_reinforce_1";
    fe [[ f ]]( s, "CRASH_SITES_Q3_COAST_GUARD", cf, ( -42314.6, -15880.9, 202.31 ), ( 0, 130.45, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_crash_sites_cs";
    s.groupid = "reinforcement_spawn_point_3";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "crash_site_vtol_reinforcement";
    s.variantname = "ai_encounter_spawnpoint";
    s.var_4501e0172e168ddf = "CRASH_SITES_Q3_COAST_GUARD_crash_site_reinforce_3";
    fe [[ f ]]( s, "CRASH_SITES_Q3_COAST_GUARD", cf, ( -44408.2, -15419.6, 120.77 ), ( 0, 5.92, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_crash_sites_cs";
    fe [[ f ]]( s, "CRASH_SITES_Q3_COAST_GUARD", cf, ( -43168.8, -14485, 520.65 ), ( 0, 5, 0 ), "activity_nexus_spatial_zone", undefined, "OB_Spacer_Spatial_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 2000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_crash_sites_cs";
    fe [[ f ]]( s, "CRASH_SITES_Q3_COAST_GUARD", cf, ( -43174.4, -14477.6, 522.05 ), ( 0, 5, 0 ), "activity_nexus_spatial_zone", undefined, "Ambient_AI_Exclusion_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 2500 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_crash_sites_cs";
    fe [[ f ]]( s, "CRASH_SITES_Q3_FRINGE_RANGE", cf, ( -15433.9, -18463, 115.75 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Ambient_AI_Exclusion_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 2500 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_crash_sites_cs";
    s.groupid = "reinforcement_spawn_point_1";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "crash_site_vtol_reinforcement";
    s.variantname = "ai_encounter_spawnpoint";
    s.var_4501e0172e168ddf = "CRASH_SITES_Q3_FRINGE_RANGE_crash_site_reinforce_1";
    fe [[ f ]]( s, "CRASH_SITES_Q3_FRINGE_RANGE", cf, ( -15463.8, -19994.4, 82.43 ), ( 0, 105.17, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_crash_sites_cs";
    s.activity_bundle = "sat_activity_definition_crash_sites";
    s.name = "CRASH_SITES_Q3_FRINGE_RANGE";
    fe [[ f ]]( s, "CRASH_SITES_Q3_FRINGE_RANGE", cf, ( -15342.6, -18378.7, 98.1 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_crash_sites_cs";
    fe [[ f ]]( s, "CRASH_SITES_Q3_FRINGE_RANGE", cf, ( -15434, -18497.8, 117.46 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Awareness_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 7000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_crash_sites_cs";
    fe [[ f ]]( s, "CRASH_SITES_Q3_FRINGE_RANGE", cf, ( -15434.4, -18531.8, 119.35 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "OB_Spacer_Spatial_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 3000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_crash_sites_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "crash_site_vtol_reinforcement";
    s.variantname = "ai_encounter_spawnpoint";
    s.var_4501e0172e168ddf = "CRASH_SITES_Q3_FRINGE_RANGE_crash_site_reinforce_3";
    fe [[ f ]]( s, "CRASH_SITES_Q3_FRINGE_RANGE", cf, ( -15593.8, -17762.8, 56.11 ), ( 0, 285.17, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace mp_sat_avalon_quad_03_ob_activity_crash_sites_cs
// Params 0, eflags: 0x4
// Checksum 0x6dd85558, Offset: 0x119e
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace mp_sat_avalon_quad_03_ob_activity_crash_sites_cs
// Params 0
// Checksum 0xfbf8977e, Offset: 0x11a8
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "mp_sat_avalon_quad_03_ob_activity_crash_sites_cs" );
}

// Namespace mp_sat_avalon_quad_03_ob_activity_crash_sites_cs
// Params 0
// Checksum 0xe645fc9, Offset: 0x11be
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

// Namespace mp_sat_avalon_quad_03_ob_activity_crash_sites_cs
// Params 4
// Checksum 0x94cc0761, Offset: 0x122d
// Size: 0x71
function function_d4323822d7042e5a( var_4312b79c960726b6, fe, us, cf = "mp_sat_avalon_quad_03_ob_activity_crash_sites_cs" )
{
    switch ( var_4312b79c960726b6 )
    {
        case #"hash_27d0f91f54bd7d17":
            function_4a362ac22aeb0f9f( fe, us, cf );
            break;
        case #"hash_bbc30705723eca8":
            function_2e2b07758b883280( fe, us, cf );
            break;
    }
}

// Namespace mp_sat_avalon_quad_03_ob_activity_crash_sites_cs
// Params 3
// Checksum 0x13b93a9e, Offset: 0x12a6
// Size: 0xd16
function function_4a362ac22aeb0f9f( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_crash_sites_cs";
    s.groupid = "uav_path";
    s.name = "uav_stall_start";
    fe [[ f ]]( s, "CRASH_SITES_Q3_COAST_GUARD", cf, ( -16340.4, -51005.9, 14084.9 ), ( 0, 126.57, 0 ), "cspf_3_auto532667915284450716", "cspf_3_auto12615583513476428558", "aircraft_crashing_start", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_crash_sites_cs";
    s.groupid = "uav_path";
    s.name = "uav_path_start";
    fe [[ f ]]( s, "CRASH_SITES_Q3_COAST_GUARD", cf, ( 20367.5, -104478, 14084.9 ), ( 0, 124.47, 0 ), "CRASH_SITES_Q3_COAST_GUARD", "cspf_3_auto532667915284450716", "aircraft_spawn", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_crash_sites_cs";
    s.groupid = "uav_path";
    s.name = "uav_crash";
    fe [[ f ]]( s, "CRASH_SITES_Q3_COAST_GUARD", cf, ( -43179.5, -14487.2, 521.86 ), ( 14.78, 125.64, 0 ), "cspf_3_auto12615583513476428558", "cspf_3_auto6791859846686303827", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 2500 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_crash_sites_cs";
    s.groupid = "uav_path";
    s.name = "uav_debris";
    fe [[ f ]]( s, "CRASH_SITES_Q3_COAST_GUARD", cf, ( -43180.1, -14497.7, 519.78 ), ( 0, 172.48, 0 ), "cspf_3_auto6791859846686303827", "cspf_3_auto4570513562618103726", "uav_debris", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_crash_sites_cs";
    s.groupid = "reinforcement_spawn_point_3";
    s.ishelistruct = 1;
    s.script_accel = "350";
    fe [[ f ]]( s, "CRASH_SITES_Q3_COAST_GUARD", cf, ( -44570.3, -15482.3, 733.19 ), ( 0, 124.79, 0 ), "CRASH_SITES_Q3_COAST_GUARD_crash_site_reinforce_3", "cspf_3_auto15365080973553683403", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_crash_sites_cs";
    s.groupid = "reinforcement_spawn_point_3";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "CRASH_SITES_Q3_COAST_GUARD", cf, ( -54404.4, -8684.97, 8447.62 ), ( 359.47, 149.72, 0.49 ), "cspf_3_auto10618739827128621970", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_crash_sites_cs";
    s.groupid = "reinforcement_spawn_point_3";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "CRASH_SITES_Q3_COAST_GUARD", cf, ( -37483.2, -28846.3, 7301.42 ), ( 0, 121.34, 0 ), undefined, "cspf_3_auto5658455220972837871", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150, 1 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_crash_sites_cs";
    s.groupid = "reinforcement_spawn_point_3";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "CRASH_SITES_Q3_COAST_GUARD", cf, ( -50469.3, -10836.6, 5333.63 ), ( 359.47, 149.72, 0.49 ), "cspf_3_auto15365080973553683403", "cspf_3_auto10618739827128621970", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_crash_sites_cs";
    s.groupid = "reinforcement_spawn_point_3";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "CRASH_SITES_Q3_COAST_GUARD", cf, ( -40292.3, -24040, 6223.88 ), ( 0, 124.46, 0 ), "cspf_3_auto5658455220972837871", "CRASH_SITES_Q3_COAST_GUARD_crash_site_reinforce_3", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_crash_sites_cs";
    s.groupid = "reinforcement_spawn_point_1";
    s.name = "agent_rally_point";
    fe [[ f ]]( s, "CRASH_SITES_Q3_COAST_GUARD", cf, ( -42331.6, -15850.2, 206.61 ), ( 0, 30.61, 0 ), "cspf_3_auto9925487417756725785", undefined, "agent_rally_point", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 512 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_crash_sites_cs";
    s.groupid = "ground_defence";
    s.name = "blackbox";
    fe [[ f ]]( s, "CRASH_SITES_Q3_COAST_GUARD", cf, ( -43229.5, -14525.3, 530.5 ), ( 0, 24.5, 0 ), "cspf_3_auto6791859846686303827", "cspf_3_auto9925487417756725785", "black_box", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_crash_sites_cs";
    s.groupid = "reinforcement_spawn_point_2";
    s.name = "agent_rally_point";
    fe [[ f ]]( s, "CRASH_SITES_Q3_COAST_GUARD", cf, ( -41328, -13824.9, 328.02 ), ( 0, 326.45, 0 ), "cspf_3_auto9925487417756725785", undefined, "agent_rally_point", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 512 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_crash_sites_cs";
    s.groupid = "reinforcement_spawn_point_3";
    s.name = "agent_rally_point";
    fe [[ f ]]( s, "CRASH_SITES_Q3_COAST_GUARD", cf, ( -44441.4, -15416.7, 113.69 ), ( 0, 5, 0 ), "cspf_3_auto9925487417756725785", undefined, "agent_rally_point", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 512 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_crash_sites_cs";
    s.groupid = "reinforcement_spawn_point_2";
    s.ishelistruct = 1;
    s.script_accel = "350";
    fe [[ f ]]( s, "CRASH_SITES_Q3_COAST_GUARD", cf, ( -41162, -13864.7, 977.19 ), ( 0, 304.79, 0 ), "CRASH_SITES_Q3_COAST_GUARD_crash_site_reinforce_2", "cspf_3_auto771468392135515929", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_crash_sites_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s.groupid = "ground_defence";
    s.height = 300;
    s.name = "black_box_trigger";
    fe [[ f ]]( s, "CRASH_SITES_Q3_COAST_GUARD", cf, ( -43229.5, -14527, 402.27 ), ( 0, 0, 0 ), "cspf_3_auto9925487417756725785", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 500 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_crash_sites_cs";
    s.groupid = "reinforcement_spawn_point_2";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "CRASH_SITES_Q3_COAST_GUARD", cf, ( -33081.6, -22173.7, 8819.62 ), ( 359.47, 314.72, 0.49 ), "cspf_3_auto215167440953921559", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_crash_sites_cs";
    s.groupid = "reinforcement_spawn_point_2";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "CRASH_SITES_Q3_COAST_GUARD", cf, ( -38137.5, -1314.09, 7673.42 ), ( 0, 246.34, 0 ), undefined, "cspf_3_auto885071094058641402", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150, 1 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_crash_sites_cs";
    s.groupid = "reinforcement_spawn_point_2";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "CRASH_SITES_Q3_COAST_GUARD", cf, ( -36325.6, -19077, 5705.63 ), ( 359.47, 314.72, 0.49 ), "cspf_3_auto771468392135515929", "cspf_3_auto215167440953921559", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_crash_sites_cs";
    s.groupid = "reinforcement_spawn_point_2";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "CRASH_SITES_Q3_COAST_GUARD", cf, ( -40463.5, -6371.91, 6595.88 ), ( 0, 249.46, 0 ), "cspf_3_auto885071094058641402", "CRASH_SITES_Q3_COAST_GUARD_crash_site_reinforce_2", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_crash_sites_cs";
    s.groupid = "reinforcement_spawn_point_1";
    s.ishelistruct = 1;
    s.script_accel = "350";
    fe [[ f ]]( s, "CRASH_SITES_Q3_COAST_GUARD", cf, ( -42373.4, -16068.4, 837.19 ), ( 0, 179.79, 0 ), "CRASH_SITES_Q3_COAST_GUARD_crash_site_reinforce_1", "cspf_3_auto14059806740265918601", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_crash_sites_cs";
    s.groupid = "reinforcement_spawn_point_1";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "CRASH_SITES_Q3_COAST_GUARD", cf, ( -52370.6, -19340.9, 8447.62 ), ( 359.47, 199.72, 0.49 ), "cspf_3_auto12617976545171932046", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_crash_sites_cs";
    s.groupid = "reinforcement_spawn_point_1";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "CRASH_SITES_Q3_COAST_GUARD", cf, ( -29737.8, -17599, 7301.42 ), ( 0, 171.34, 0 ), undefined, "cspf_3_auto12000072573179150406", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150, 1 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_crash_sites_cs";
    s.groupid = "reinforcement_spawn_point_1";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "CRASH_SITES_Q3_COAST_GUARD", cf, ( -48542.6, -17831, 5333.63 ), ( 359.47, 194.72, 0.49 ), "cspf_3_auto14059806740265918601", "cspf_3_auto12617976545171932046", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_crash_sites_cs";
    s.groupid = "reinforcement_spawn_point_1";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "CRASH_SITES_Q3_COAST_GUARD", cf, ( -35225.3, -16661.5, 6223.88 ), ( 0, 174.46, 0 ), "cspf_3_auto12000072573179150406", "CRASH_SITES_Q3_COAST_GUARD_crash_site_reinforce_1", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
}

// Namespace mp_sat_avalon_quad_03_ob_activity_crash_sites_cs
// Params 3
// Checksum 0x88f3a86c, Offset: 0x1fc4
// Size: 0x9e6
function function_2e2b07758b883280( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_crash_sites_cs";
    s.groupid = "reinforcement_spawn_point_1";
    s.ishelistruct = 1;
    s.script_accel = "350";
    fe [[ f ]]( s, "CRASH_SITES_Q3_FRINGE_RANGE", cf, ( -15601.7, -20289.6, 863.1 ), ( 0, 181.79, 0 ), "CRASH_SITES_Q3_FRINGE_RANGE_crash_site_reinforce_1", "cspf_4_auto16318600960476455527", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_crash_sites_cs";
    s.groupid = "ground_defence";
    s.name = "black_box";
    fe [[ f ]]( s, "CRASH_SITES_Q3_FRINGE_RANGE", cf, ( -15343.6, -18380.5, 98.21 ), ( 4.18, 94.5, 2 ), "cspf_4_auto869477739016309505", "cspf_4_auto8195893214295031350", "black_box", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_crash_sites_cs";
    s.groupid = "reinforcement_spawn_point_1";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "CRASH_SITES_Q3_FRINGE_RANGE", cf, ( -19854.6, -31100.9, 8165.5 ), ( 359.47, 271.72, 0.49 ), "cspf_4_auto4454050490160243003", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_crash_sites_cs";
    s.groupid = "reinforcement_spawn_point_1";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "CRASH_SITES_Q3_FRINGE_RANGE", cf, ( -2635.73, -17423.5, 7019.34 ), ( 0, 193.34, 0 ), undefined, "cspf_4_auto17077661411820832582", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150, 1 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_crash_sites_cs";
    s.groupid = "reinforcement_spawn_point_1";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "CRASH_SITES_Q3_FRINGE_RANGE", cf, ( -18758.8, -25109.8, 5051.55 ), ( 359.47, 266.72, 0.49 ), "cspf_4_auto16318600960476455527", "cspf_4_auto4454050490160243003", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_crash_sites_cs";
    s.groupid = "reinforcement_spawn_point_1";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "CRASH_SITES_Q3_FRINGE_RANGE", cf, ( -8074.85, -18609.8, 5941.8 ), ( 0, 196.46, 0 ), "cspf_4_auto17077661411820832582", "CRASH_SITES_Q3_FRINGE_RANGE_crash_site_reinforce_1", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_crash_sites_cs";
    s.groupid = "reinforcement_spawn_point_1";
    s.name = "agent_rally_point";
    fe [[ f ]]( s, "CRASH_SITES_Q3_FRINGE_RANGE", cf, ( -15467.4, -19951.6, 80.63 ), ( 0, 0, 0 ), "cspf_4_auto8195893214295031350", undefined, "agent_rally_point", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 512 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_crash_sites_cs";
    s.groupid = "uav_path";
    s.name = "uav_stall_start";
    fe [[ f ]]( s, "CRASH_SITES_Q3_FRINGE_RANGE", cf, ( -9682.5, -32940.3, 24820.8 ), ( 0, 111.15, 0 ), "cspf_4_auto2761054103035727751", "cspf_4_auto10802568113865877285", "aircraft_crashing_start", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_crash_sites_cs";
    s.groupid = "uav_path";
    s.name = "uav_crash";
    fe [[ f ]]( s, "CRASH_SITES_Q3_FRINGE_RANGE", cf, ( -15283.3, -18452.2, 108.62 ), ( 57.61, 111.31, 0 ), "cspf_4_auto10802568113865877285", "cspf_4_auto869477739016309505", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 5000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_crash_sites_cs";
    s.groupid = "uav_path";
    s.name = "uav_debris";
    fe [[ f ]]( s, "CRASH_SITES_Q3_FRINGE_RANGE", cf, ( -15265.7, -18518.4, 109.94 ), ( 0, 130, 0 ), "cspf_4_auto869477739016309505", undefined, "uav_debris", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_crash_sites_cs";
    s.groupid = "uav_path";
    s.name = "uav_path_start";
    fe [[ f ]]( s, "CRASH_SITES_Q3_FRINGE_RANGE", cf, ( -6329.76, -41194.6, 25809.5 ), ( 0, 112.07, 0 ), "CRASH_SITES_Q3_FRINGE_RANGE", "cspf_4_auto2761054103035727751", "aircraft_spawn", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_crash_sites_cs";
    s.groupid = "reinforcement_spawn_point_3";
    s.name = "agent_rally_point";
    fe [[ f ]]( s, "CRASH_SITES_Q3_FRINGE_RANGE", cf, ( -15589.5, -17803.9, 59.99 ), ( 0, 0, 0 ), "cspf_4_auto8195893214295031350", undefined, "agent_rally_point", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 256 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_crash_sites_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s.groupid = "ground_defence";
    s.height = 450;
    s.name = "black_box_hack_trigger";
    fe [[ f ]]( s, "CRASH_SITES_Q3_FRINGE_RANGE", cf, ( -15342.5, -18380, 43.2 ), ( 0, 0, 0 ), "cspf_4_auto8195893214295031350", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 500 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_crash_sites_cs";
    s.groupid = "reinforcement_spawn_point_3";
    s.ishelistruct = 1;
    s.script_accel = "350";
    fe [[ f ]]( s, "CRASH_SITES_Q3_FRINGE_RANGE", cf, ( -15622.6, -17676.4, 767.1 ), ( 0, 3.79, 0 ), "CRASH_SITES_Q3_FRINGE_RANGE_crash_site_reinforce_3", "cspf_4_auto4885753046802908157", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_crash_sites_cs";
    s.groupid = "reinforcement_spawn_point_3";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "CRASH_SITES_Q3_FRINGE_RANGE", cf, ( -9216.9, -8022.34, 8165.5 ), ( 359.47, 79.72, 0.49 ), "cspf_4_auto6094233747662669433", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_crash_sites_cs";
    s.groupid = "reinforcement_spawn_point_3";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "CRASH_SITES_Q3_FRINGE_RANGE", cf, ( -28949, -19511.7, 7019.34 ), ( 0, 11.34, 0 ), undefined, "cspf_4_auto4912086630663028137", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150, 1 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_crash_sites_cs";
    s.groupid = "reinforcement_spawn_point_3";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "CRASH_SITES_Q3_FRINGE_RANGE", cf, ( -11534.4, -13654.7, 5051.55 ), ( 359.47, 74.72, 0.49 ), "cspf_4_auto4885753046802908157", "cspf_4_auto6094233747662669433", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_crash_sites_cs";
    s.groupid = "reinforcement_spawn_point_3";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "CRASH_SITES_Q3_FRINGE_RANGE", cf, ( -23471.8, -18515.9, 5941.8 ), ( 0, 14.46, 0 ), "cspf_4_auto4912086630663028137", "CRASH_SITES_Q3_FRINGE_RANGE_crash_site_reinforce_3", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
}

// Namespace mp_sat_avalon_quad_03_ob_activity_crash_sites_cs
// Params 0
// Checksum 0x84be817d, Offset: 0x29b2
// Size: 0x143
function function_d9dd7965c51c95d1()
{
    activityinstances = [];
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_activity_definition_crash_sites";
    var_881289d7987bc770.cf = "mp_sat_avalon_quad_03_ob_activity_crash_sites_cs";
    var_881289d7987bc770.scriptstructorigin = ( -43232.9, -14524.3, 532.66 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [];
    var_881289d7987bc770.var_31ce4477e3543d24 = [];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [];
    var_881289d7987bc770.locationradius = [];
    activityinstances[ "CRASH_SITES_Q3_COAST_GUARD" ] = var_881289d7987bc770;
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_activity_definition_crash_sites";
    var_881289d7987bc770.cf = "mp_sat_avalon_quad_03_ob_activity_crash_sites_cs";
    var_881289d7987bc770.scriptstructorigin = ( -15342.6, -18378.7, 98.1 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [];
    var_881289d7987bc770.var_31ce4477e3543d24 = [];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [];
    var_881289d7987bc770.locationradius = [];
    activityinstances[ "CRASH_SITES_Q3_FRINGE_RANGE" ] = var_881289d7987bc770;
    return activityinstances;
}

