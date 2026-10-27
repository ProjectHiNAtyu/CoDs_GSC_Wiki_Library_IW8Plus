// script_5f04885d50eed9ac  (hash_5f04885d50eed9ac.gscc) (size: 8704 Bytes / 0x2200 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x9b021216 (2600604182)
// size ...... 8704 (0x2200)
// includes .. 4   (offset: 0x1d88)
// strings ... 50  (offset: 0x1da8)
// dev strs .. 0   (offset: 0x2200)
// exports ... 13  (offset: 0x18a4)
// cseg ...... 0x54d + 0x1357 (0x18a4)
// imports ... 26  (offset: 0x1aac)
// animtree1 . 0   (offset: 0x2200)
// animtree2 . 0   (offset: 0x2200)
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace mp_sat_avalon_q3_ob_contract_heist_cs;

// Namespace mp_sat_avalon_q3_ob_contract_heist_cs
// Params 0, eflags: 0x5
// Checksum 0xd1aadc17, Offset: 0x56b
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"mp_sat_avalon_q3_ob_contract_heist_cs", #"activity_common", &function_b39ecd3d51489472, undefined );
}

// Namespace mp_sat_avalon_q3_ob_contract_heist_cs
// Params 0, eflags: 0x4
// Checksum 0xc9adfe4a, Offset: 0x594
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace mp_sat_avalon_q3_ob_contract_heist_cs
// Params 0, eflags: 0x4
// Checksum 0x4c962da6, Offset: 0x5a5
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace mp_sat_avalon_q3_ob_contract_heist_cs
// Params 2
// Checksum 0x67b4f2a2, Offset: 0x5b6
// Size: 0x8c
function main( unused, unused2 )
{
    if ( utility::flag_exist( "mp_sat_avalon_q3_ob_contract_heist_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "mp_sat_avalon_q3_ob_contract_heist_cs" ) )
    {
        return;
    }
    
    activity_common::function_e1df676808c1d1e3( &function_4cd78e661617f3 );
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "mp_sat_avalon_q3_ob_contract_heist_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "mp_sat_avalon_q3_ob_contract_heist_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace mp_sat_avalon_q3_ob_contract_heist_cs
// Params 3, eflags: 0x4
// Checksum 0xcf149969, Offset: 0x64a
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "mp_sat_avalon_q3_ob_contract_heist_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "mp_sat_avalon_q3_ob_contract_heist_cs" );
}

// Namespace mp_sat_avalon_q3_ob_contract_heist_cs
// Params 3, eflags: 0x4
// Checksum 0xc88970eb, Offset: 0x6c4
// Size: 0x59e
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_contract_heist_cs";
    s.name = "contract_heist_qzone_terminal";
    fe [[ f ]]( s, us, cf, ( -4578.52, -30315.3, 468 ), ( 0, 85, 0 ), undefined, undefined, "Qzone_terminal_for_Heist" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_contract_heist_cs";
    s.name = "contract_heist_qzone_terminal";
    fe [[ f ]]( s, us, cf, ( -29339.4, -30643.4, 918.5 ), ( 0, 61, 0 ), undefined, undefined, "Qzone_terminal_for_Heist" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_contract_heist_cs";
    s.name = "contract_heist_qzone_terminal";
    fe [[ f ]]( s, us, cf, ( 1043.47, -675.59, 744 ), ( 0, 32.87, 0 ), undefined, undefined, "Qzone_terminal_for_Heist" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_contract_heist_cs";
    s.name = "contract_heist_qzone_terminal";
    fe [[ f ]]( s, us, cf, ( 9190.72, 237.58, 920 ), ( 0, 313.8, 0 ), undefined, undefined, "Qzone_terminal_for_Heist" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_contract_heist_cs";
    s.activity_bundle = "sat_activitydefinition_heist";
    s.name = "CONTRACT_HEIST_Q3_FIRING_RANGE";
    s.var_7a0840be22b9ebb = "CRASH_SITES_Q3_FRINGE_RANGE";
    fe [[ f ]]( s, "CONTRACT_HEIST_Q3_FIRING_RANGE", cf, ( -15342.6, -18376.9, 107.57 ), ( 0, 290, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_contract_heist_cs";
    fe [[ f ]]( s, "CONTRACT_HEIST_Q3_FIRING_RANGE", cf, ( -16048.3, -33469.2, 14.2 ), ( 0, 39.44, 0 ), "activity_nexus_instance_joiner", undefined, "CONTRACT_HEIST_Q3_FIRING_RANGE", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_contract_heist_cs";
    fe [[ f ]]( s, "CONTRACT_HEIST_Q3_FIRING_RANGE", cf, ( -15433.9, -18463, 115.75 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Ambient_AI_Exclusion_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 4000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_contract_heist_cs";
    s.groupid = "reinforcement_spawn_point_1";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "heist_vtol_reinforcement";
    s.variantname = "ai_encounter_spawnpoint";
    s.var_4501e0172e168ddf = "CONTRACT_HEIST_Q3_FIRING_RANGE_crash_site_reinforce_1";
    fe [[ f ]]( s, "CONTRACT_HEIST_Q3_FIRING_RANGE", cf, ( -15463.8, -19994.4, 82.43 ), ( 0, 105.17, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_contract_heist_cs";
    fe [[ f ]]( s, "CONTRACT_HEIST_Q3_FIRING_RANGE", cf, ( -15434, -18497.8, 117.46 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Awareness_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 7000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_contract_heist_cs";
    fe [[ f ]]( s, "CONTRACT_HEIST_Q3_FIRING_RANGE", cf, ( -15434.4, -18531.8, 119.35 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "OB_Spacer_Spatial_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 3000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_contract_heist_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "heist_vtol_reinforcement";
    s.variantname = "ai_encounter_spawnpoint";
    s.var_4501e0172e168ddf = "CONTRACT_HEIST_Q3_FIRING_RANGE_crash_site_reinforce_3";
    fe [[ f ]]( s, "CONTRACT_HEIST_Q3_FIRING_RANGE", cf, ( -15593.8, -17762.8, 56.11 ), ( 0, 285.17, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace mp_sat_avalon_q3_ob_contract_heist_cs
// Params 0, eflags: 0x4
// Checksum 0x703046ef, Offset: 0xc6a
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace mp_sat_avalon_q3_ob_contract_heist_cs
// Params 0
// Checksum 0xd474424, Offset: 0xc74
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "mp_sat_avalon_q3_ob_contract_heist_cs" );
}

// Namespace mp_sat_avalon_q3_ob_contract_heist_cs
// Params 0
// Checksum 0x5468b3d4, Offset: 0xc8a
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

// Namespace mp_sat_avalon_q3_ob_contract_heist_cs
// Params 4
// Checksum 0xedc73d6f, Offset: 0xcf9
// Size: 0x57
function function_d4323822d7042e5a( var_4312b79c960726b6, fe, us, cf = "mp_sat_avalon_q3_ob_contract_heist_cs" )
{
    switch ( var_4312b79c960726b6 )
    {
        case #"hash_b6c6e1be403dc9e2":
            function_42a62a24e7eac21a( fe, us, cf );
            break;
    }
}

// Namespace mp_sat_avalon_q3_ob_contract_heist_cs
// Params 3
// Checksum 0x350f5f02, Offset: 0xd58
// Size: 0xa84
function function_42a62a24e7eac21a( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_contract_heist_cs";
    s.groupid = "uav_path";
    s.name = "uav_stall_start";
    fe [[ f ]]( s, "CONTRACT_HEIST_Q3_FIRING_RANGE", cf, ( -9682.5, -32940.3, 24820.8 ), ( 0, 111.15, 0 ), "cspf_2_auto2761054103035727751", "cspf_2_auto10802568113865877285", "aircraft_crashing_start", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_contract_heist_cs";
    s.groupid = "uav_path";
    s.name = "uav_crash";
    fe [[ f ]]( s, "CONTRACT_HEIST_Q3_FIRING_RANGE", cf, ( -15283.3, -18452.2, 104.48 ), ( 57.61, 111.31, 0 ), "cspf_2_auto10802568113865877285", "cspf_2_auto869477739016309505", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 4500 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_contract_heist_cs";
    s.groupid = "uav_path";
    s.name = "uav_debris";
    fe [[ f ]]( s, "CONTRACT_HEIST_Q3_FIRING_RANGE", cf, ( -15265.7, -18518.4, 109.94 ), ( 0, 130, 0 ), "cspf_2_auto869477739016309505", undefined, "uav_debris", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_contract_heist_cs";
    s.groupid = "uav_path";
    s.name = "uav_path_start";
    fe [[ f ]]( s, "CONTRACT_HEIST_Q3_FIRING_RANGE", cf, ( -6329.76, -41194.6, 25809.5 ), ( 0, 112.07, 0 ), "CONTRACT_HEIST_Q3_FIRING_RANGE", "cspf_2_auto2761054103035727751", "aircraft_spawn", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_contract_heist_cs";
    s.groupid = "reinforcement_spawn_point_1";
    s.ishelistruct = 1;
    s.script_accel = "350";
    fe [[ f ]]( s, "CONTRACT_HEIST_Q3_FIRING_RANGE", cf, ( -15601.7, -20289.6, 863.1 ), ( 0, 181.79, 0 ), "CONTRACT_HEIST_Q3_FIRING_RANGE_crash_site_reinforce_1", "cspf_2_auto16318600960476455527", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_contract_heist_cs";
    s.groupid = "ground_defence";
    s.name = "blackbox";
    fe [[ f ]]( s, "CONTRACT_HEIST_Q3_FIRING_RANGE", cf, ( -15343.6, -18380.5, 98.21 ), ( 4.18, 94.5, 2 ), "cspf_2_auto869477739016309505", "cspf_2_auto9925487417756725785", "black_box", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_contract_heist_cs";
    s.groupid = "reinforcement_spawn_point_1";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "CONTRACT_HEIST_Q3_FIRING_RANGE", cf, ( -19854.6, -31100.9, 8165.5 ), ( 359.47, 271.72, 0.49 ), "cspf_2_auto4454050490160243003", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_contract_heist_cs";
    s.groupid = "reinforcement_spawn_point_1";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "CONTRACT_HEIST_Q3_FIRING_RANGE", cf, ( -2635.73, -17423.5, 7019.34 ), ( 0, 193.34, 0 ), undefined, "cspf_2_auto17077661411820832582", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150, 1 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_contract_heist_cs";
    s.groupid = "reinforcement_spawn_point_1";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "CONTRACT_HEIST_Q3_FIRING_RANGE", cf, ( -18758.8, -25109.8, 5051.55 ), ( 359.47, 266.72, 0.49 ), "cspf_2_auto16318600960476455527", "cspf_2_auto4454050490160243003", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_contract_heist_cs";
    s.groupid = "reinforcement_spawn_point_1";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "CONTRACT_HEIST_Q3_FIRING_RANGE", cf, ( -8074.85, -18609.8, 5941.8 ), ( 0, 196.46, 0 ), "cspf_2_auto17077661411820832582", "CONTRACT_HEIST_Q3_FIRING_RANGE_crash_site_reinforce_1", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_contract_heist_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s.groupid = "ground_defence";
    s.height = 450;
    s.name = "black_box_trigger";
    fe [[ f ]]( s, "CONTRACT_HEIST_Q3_FIRING_RANGE", cf, ( -15342.4, -18380, 51.2 ), ( 0, 0, 0 ), "cspf_2_auto9925487417756725785", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 500 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_contract_heist_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s.height = 5000;
    s.name = "crash_approximity_trigger";
    fe [[ f ]]( s, "CONTRACT_HEIST_Q3_FIRING_RANGE", cf, ( -15503, -18489.3, 116.89 ), ( 0.93, 197.19, 1.1 ), "cspf_2_auto869477739016309505", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 4500 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_contract_heist_cs";
    s.groupid = "reinforcement_spawn_point_1";
    s.name = "agent_rally_point";
    fe [[ f ]]( s, "CONTRACT_HEIST_Q3_FIRING_RANGE", cf, ( -15467.4, -19951.6, 80.63 ), ( 0, 0, 0 ), "cspf_2_auto9925487417756725785", undefined, "agent_rally_point", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 512 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_contract_heist_cs";
    s.groupid = "reinforcement_spawn_point_3";
    s.name = "agent_rally_point";
    fe [[ f ]]( s, "CONTRACT_HEIST_Q3_FIRING_RANGE", cf, ( -15589.5, -17803.9, 59.99 ), ( 0, 0, 0 ), "cspf_2_auto9925487417756725785", undefined, "agent_rally_point", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 256 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_contract_heist_cs";
    s.groupid = "reinforcement_spawn_point_3";
    s.ishelistruct = 1;
    s.script_accel = "350";
    fe [[ f ]]( s, "CONTRACT_HEIST_Q3_FIRING_RANGE", cf, ( -15622.6, -17676.4, 767.1 ), ( 0, 3.79, 0 ), "CONTRACT_HEIST_Q3_FIRING_RANGE_crash_site_reinforce_3", "cspf_2_auto4885753046802908157", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_contract_heist_cs";
    s.groupid = "reinforcement_spawn_point_3";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "CONTRACT_HEIST_Q3_FIRING_RANGE", cf, ( -9216.9, -8022.34, 8165.5 ), ( 359.47, 79.72, 0.49 ), "cspf_2_auto6094233747662669433", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_contract_heist_cs";
    s.groupid = "reinforcement_spawn_point_3";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "CONTRACT_HEIST_Q3_FIRING_RANGE", cf, ( -28949, -19511.7, 7019.34 ), ( 0, 11.34, 0 ), undefined, "cspf_2_auto4912086630663028137", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150, 1 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_contract_heist_cs";
    s.groupid = "reinforcement_spawn_point_3";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "CONTRACT_HEIST_Q3_FIRING_RANGE", cf, ( -11534.4, -13654.7, 5051.55 ), ( 359.47, 74.72, 0.49 ), "cspf_2_auto4885753046802908157", "cspf_2_auto6094233747662669433", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_contract_heist_cs";
    s.groupid = "reinforcement_spawn_point_3";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "CONTRACT_HEIST_Q3_FIRING_RANGE", cf, ( -23471.8, -18515.9, 5941.8 ), ( 0, 14.46, 0 ), "cspf_2_auto4912086630663028137", "CONTRACT_HEIST_Q3_FIRING_RANGE_crash_site_reinforce_3", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
}

// Namespace mp_sat_avalon_q3_ob_contract_heist_cs
// Params 0
// Checksum 0xda3ed12, Offset: 0x17e4
// Size: 0xbf
function function_d9dd7965c51c95d1()
{
    activityinstances = [];
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_activitydefinition_heist";
    var_881289d7987bc770.var_7a0840be22b9ebb = "CRASH_SITES_Q3_FRINGE_RANGE";
    var_881289d7987bc770.cf = "mp_sat_avalon_q3_ob_contract_heist_cs";
    var_881289d7987bc770.scriptstructorigin = ( -15342.6, -18376.9, 107.57 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [];
    var_881289d7987bc770.var_31ce4477e3543d24 = [];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [];
    var_881289d7987bc770.locationradius = [];
    activityinstances[ "CONTRACT_HEIST_Q3_FIRING_RANGE" ] = var_881289d7987bc770;
    return activityinstances;
}

