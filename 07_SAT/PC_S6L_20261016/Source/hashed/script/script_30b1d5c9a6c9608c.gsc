// script_30b1d5c9a6c9608c  (hash_30b1d5c9a6c9608c.gscc) (size: 9916 Bytes / 0x26bc / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x53993adc (1402551004)
// size ...... 9916 (0x26bc)
// includes .. 4   (offset: 0x2194)
// strings ... 55  (offset: 0x21b4)
// dev strs .. 0   (offset: 0x26bc)
// exports ... 13  (offset: 0x1cb0)
// cseg ...... 0x617 + 0x1699 (0x1cb0)
// imports ... 26  (offset: 0x1eb8)
// animtree1 . 0   (offset: 0x26bc)
// animtree2 . 0   (offset: 0x26bc)
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace mp_sat_avalon_q4_ob_contract_heist_cs;

// Namespace mp_sat_avalon_q4_ob_contract_heist_cs
// Params 0, eflags: 0x5
// Checksum 0x8451378f, Offset: 0x635
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"mp_sat_avalon_q4_ob_contract_heist_cs", #"activity_common", &function_b39ecd3d51489472, undefined );
}

// Namespace mp_sat_avalon_q4_ob_contract_heist_cs
// Params 0, eflags: 0x4
// Checksum 0xf6e706d, Offset: 0x65e
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace mp_sat_avalon_q4_ob_contract_heist_cs
// Params 0, eflags: 0x4
// Checksum 0x8a55a381, Offset: 0x66f
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace mp_sat_avalon_q4_ob_contract_heist_cs
// Params 2
// Checksum 0xc4ae42c5, Offset: 0x680
// Size: 0x8c
function main( unused, unused2 )
{
    if ( utility::flag_exist( "mp_sat_avalon_q4_ob_contract_heist_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "mp_sat_avalon_q4_ob_contract_heist_cs" ) )
    {
        return;
    }
    
    activity_common::function_e1df676808c1d1e3( &function_4cd78e661617f3 );
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "mp_sat_avalon_q4_ob_contract_heist_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "mp_sat_avalon_q4_ob_contract_heist_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace mp_sat_avalon_q4_ob_contract_heist_cs
// Params 3, eflags: 0x4
// Checksum 0x9d7174e, Offset: 0x714
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "mp_sat_avalon_q4_ob_contract_heist_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "mp_sat_avalon_q4_ob_contract_heist_cs" );
}

// Namespace mp_sat_avalon_q4_ob_contract_heist_cs
// Params 3, eflags: 0x4
// Checksum 0xaf9c8e65, Offset: 0x78e
// Size: 0x5b3
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_heist_cs";
    s.name = "contract_heist_qzone_terminal";
    fe [[ f ]]( s, us, cf, ( 34234.5, -37387.3, 1266.5 ), ( 0, 172, 0 ), undefined, undefined, "Qzone_terminal_for_Heist" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_heist_cs";
    s.activity_bundle = "sat_activitydefinition_heist";
    s.name = "CONTRACT_HEIST_Q4_EPIC_BRIDGE";
    s.var_7a0840be22b9ebb = "CRASH_SITES_Q4_ABANDONED_VILLAGE_RUINS";
    fe [[ f ]]( s, "CONTRACT_HEIST_Q4_EPIC_BRIDGE", cf, ( 58884, -16048.6, 2301.6 ), ( 0, 290, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_heist_cs";
    fe [[ f ]]( s, "CONTRACT_HEIST_Q4_EPIC_BRIDGE", cf, ( 37532, -32249.1, 655 ), ( 0, 129.36, 0 ), "activity_nexus_instance_joiner", undefined, "CONTRACT_HEIST_Q4_EPIC_BRIDGE", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_heist_cs";
    fe [[ f ]]( s, "CONTRACT_HEIST_Q4_EPIC_BRIDGE", cf, ( 58960.5, -16211, 2387.06 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Ambient_AI_Exclusion_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 4000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_heist_cs";
    fe [[ f ]]( s, "CONTRACT_HEIST_Q4_EPIC_BRIDGE", cf, ( 59329, -15167.5, 2387.06 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Awareness_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 7000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_heist_cs";
    fe [[ f ]]( s, "CONTRACT_HEIST_Q4_EPIC_BRIDGE", cf, ( 59342.5, -15139, 2387.06 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "OB_Spacer_Spatial_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 3000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_heist_cs";
    s.groupid = "reinforcement_spawn_point_2";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "heist_vtol_reinforcement";
    s.variantname = "ai_encounter_spawnpoint";
    s.var_4501e0172e168ddf = "CONTRACT_HEIST_Q4_EPIC_BRIDGE_crash_site_reinforce_2";
    fe [[ f ]]( s, "CONTRACT_HEIST_Q4_EPIC_BRIDGE", cf, ( 59416.8, -17010.1, 2340.99 ), ( 0, 105.17, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_heist_cs";
    s.groupid = "reinforcement_spawn_point_1";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "heist_vtol_reinforcement";
    s.variantname = "ai_encounter_spawnpoint";
    s.var_4501e0172e168ddf = "CONTRACT_HEIST_Q4_EPIC_BRIDGE_crash_site_reinforce_1";
    fe [[ f ]]( s, "CONTRACT_HEIST_Q4_EPIC_BRIDGE", cf, ( 57939.7, -16334.8, 2159.97 ), ( 0, 20.17, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_heist_cs";
    s.groupid = "reinforcement_spawn_point_3";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "heist_vtol_reinforcement";
    s.variantname = "ai_encounter_spawnpoint";
    s.var_4501e0172e168ddf = "CONTRACT_HEIST_Q4_EPIC_BRIDGE_crash_site_reinforce_3";
    fe [[ f ]]( s, "CONTRACT_HEIST_Q4_EPIC_BRIDGE", cf, ( 59832.3, -14735.6, 2417.73 ), ( 0, 245.17, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace mp_sat_avalon_q4_ob_contract_heist_cs
// Params 0, eflags: 0x4
// Checksum 0xd32af688, Offset: 0xd49
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace mp_sat_avalon_q4_ob_contract_heist_cs
// Params 0
// Checksum 0xcb84ca03, Offset: 0xd53
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "mp_sat_avalon_q4_ob_contract_heist_cs" );
}

// Namespace mp_sat_avalon_q4_ob_contract_heist_cs
// Params 0
// Checksum 0x92ab3df3, Offset: 0xd69
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

// Namespace mp_sat_avalon_q4_ob_contract_heist_cs
// Params 4
// Checksum 0x4a8b5517, Offset: 0xdd8
// Size: 0x57
function function_d4323822d7042e5a( var_4312b79c960726b6, fe, us, cf = "mp_sat_avalon_q4_ob_contract_heist_cs" )
{
    switch ( var_4312b79c960726b6 )
    {
        case #"hash_1c36e03f2a6293d7":
            function_91103aad1065d4bf( fe, us, cf );
            break;
    }
}

// Namespace mp_sat_avalon_q4_ob_contract_heist_cs
// Params 3
// Checksum 0x39e49d60, Offset: 0xe37
// Size: 0xdb1
function function_91103aad1065d4bf( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_heist_cs";
    s.groupid = "ground_defence";
    s.name = "blackbox";
    fe [[ f ]]( s, "CONTRACT_HEIST_Q4_EPIC_BRIDGE", cf, ( 58884.5, -16051, 2301.72 ), ( 353, 359.73, 3.8 ), "cspf_2_auto13312210101989124962", "cspf_2_auto15075622858678509370", "black_box", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_heist_cs";
    s.groupid = "uav_path";
    s.name = "uav_stall_start";
    fe [[ f ]]( s, "CONTRACT_HEIST_Q4_EPIC_BRIDGE", cf, ( 38704.6, -5629.13, 27136.8 ), ( 0, 332.64, 0 ), "cspf_2_auto17120053602806599362", "cspf_2_auto14400503375105410843", "aircraft_crashing_start", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_heist_cs";
    s.groupid = "uav_path";
    s.name = "uav_crash";
    fe [[ f ]]( s, "CONTRACT_HEIST_Q4_EPIC_BRIDGE", cf, ( 59130, -16189.5, 2341.07 ), ( 43.93, 334.54, 0 ), "cspf_2_auto14400503375105410843", "cspf_2_auto13312210101989124962", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_heist_cs";
    s.groupid = "uav_path";
    s.name = "uav_debris";
    fe [[ f ]]( s, "CONTRACT_HEIST_Q4_EPIC_BRIDGE", cf, ( 59068, -16160.5, 2336.78 ), ( 0, 0, 0 ), "cspf_2_auto13312210101989124962", undefined, "uav_debris", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_heist_cs";
    s.groupid = "uav_path";
    s.name = "uav_path_start";
    fe [[ f ]]( s, "CONTRACT_HEIST_Q4_EPIC_BRIDGE", cf, ( 32142.4, -2383.79, 28125.5 ), ( 0, 333.77, 0 ), "CONTRACT_HEIST_Q4_EPIC_BRIDGE", "cspf_2_auto17120053602806599362", "aircraft_spawn", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_heist_cs";
    s.groupid = "reinforcement_spawn_point_2";
    s.name = "agent_rally_point";
    fe [[ f ]]( s, "CONTRACT_HEIST_Q4_EPIC_BRIDGE", cf, ( 59269.5, -17029, 2341.26 ), ( 0, 0, 0 ), "cspf_2_auto15075622858678509370", undefined, "agent_rally_point", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 512 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_heist_cs";
    s.groupid = "reinforcement_spawn_point_1";
    s.name = "agent_rally_point";
    fe [[ f ]]( s, "CONTRACT_HEIST_Q4_EPIC_BRIDGE", cf, ( 57952.5, -16310.6, 2161.03 ), ( 0, 0, 0 ), "cspf_2_auto15075622858678509370", undefined, "agent_rally_point", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 512 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_heist_cs";
    s.groupid = "reinforcement_spawn_point_3";
    s.name = "agent_rally_point";
    fe [[ f ]]( s, "CONTRACT_HEIST_Q4_EPIC_BRIDGE", cf, ( 59856.1, -15063.8, 2323.94 ), ( 0, 0, 0 ), "cspf_2_auto15075622858678509370", undefined, "agent_rally_point", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 512 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_heist_cs";
    s.groupid = "reinforcement_spawn_point_1";
    s.ishelistruct = 1;
    s.script_accel = "350";
    fe [[ f ]]( s, "CONTRACT_HEIST_Q4_EPIC_BRIDGE", cf, ( 57682.6, -16326.1, 2723.1 ), ( 0, 94.79, 0 ), "CONTRACT_HEIST_Q4_EPIC_BRIDGE_crash_site_reinforce_1", "cspf_2_auto14059806740265918601", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_heist_cs";
    s.groupid = "reinforcement_spawn_point_1";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "CONTRACT_HEIST_Q4_EPIC_BRIDGE", cf, ( 53578.3, -6633.63, 10569.5 ), ( 359.47, 119.72, 0.49 ), "cspf_2_auto12617976545171932046", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_heist_cs";
    s.groupid = "reinforcement_spawn_point_1";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "CONTRACT_HEIST_Q4_EPIC_BRIDGE", cf, ( 58010.4, -30201.8, 9423.34 ), ( 0, 86.34, 0 ), undefined, "cspf_2_auto12000072573179150406", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150, 1 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_heist_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s.groupid = "ground_defence";
    s.height = 450;
    s.name = "black_box_trigger";
    fe [[ f ]]( s, "CONTRACT_HEIST_Q4_EPIC_BRIDGE", cf, ( 58884.5, -16051, 2151.49 ), ( 0, 0, 0 ), "cspf_2_auto15075622858678509370", undefined, "black_box_trigger", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 500 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_heist_cs";
    s.groupid = "reinforcement_spawn_point_1";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "CONTRACT_HEIST_Q4_EPIC_BRIDGE", cf, ( 55441, -10234.8, 7455.55 ), ( 359.47, 119.72, 0.49 ), "cspf_2_auto14059806740265918601", "cspf_2_auto12617976545171932046", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_heist_cs";
    s.groupid = "reinforcement_spawn_point_1";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "CONTRACT_HEIST_Q4_EPIC_BRIDGE", cf, ( 58466.1, -24653.5, 8345.8 ), ( 0, 89.46, 0 ), "cspf_2_auto12000072573179150406", "CONTRACT_HEIST_Q4_EPIC_BRIDGE_crash_site_reinforce_1", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_heist_cs";
    s.groupid = "reinforcement_spawn_point_2";
    s.ishelistruct = 1;
    s.script_accel = "350";
    fe [[ f ]]( s, "CONTRACT_HEIST_Q4_EPIC_BRIDGE", cf, ( 59428.3, -17075.7, 2995.1 ), ( 0, 179.79, 0 ), "CONTRACT_HEIST_Q4_EPIC_BRIDGE_crash_site_reinforce_2", "cspf_2_auto8646499290226779332", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_heist_cs";
    s.groupid = "reinforcement_spawn_point_2";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "CONTRACT_HEIST_Q4_EPIC_BRIDGE", cf, ( 49631.1, -20603.6, 10569.5 ), ( 359.47, 204.72, 0.49 ), "cspf_2_auto2406064689693020683", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_heist_cs";
    s.groupid = "reinforcement_spawn_point_2";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "CONTRACT_HEIST_Q4_EPIC_BRIDGE", cf, ( 62745.6, -29046.1, 9423.34 ), ( 0, 96.34, 0 ), undefined, "cspf_2_auto3008426111943817833", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150, 1 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_heist_cs";
    s.groupid = "reinforcement_spawn_point_2";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "CONTRACT_HEIST_Q4_EPIC_BRIDGE", cf, ( 53380.9, -19061.8, 7455.55 ), ( 359.47, 204.72, 0.49 ), "cspf_2_auto8646499290226779332", "cspf_2_auto2406064689693020683", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_heist_cs";
    s.groupid = "reinforcement_spawn_point_2";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "CONTRACT_HEIST_Q4_EPIC_BRIDGE", cf, ( 62230.9, -23502.9, 8345.8 ), ( 0, 99.46, 0 ), "cspf_2_auto3008426111943817833", "CONTRACT_HEIST_Q4_EPIC_BRIDGE_crash_site_reinforce_2", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_heist_cs";
    s.groupid = "reinforcement_spawn_point_3";
    s.ishelistruct = 1;
    s.script_accel = "350";
    fe [[ f ]]( s, "CONTRACT_HEIST_Q4_EPIC_BRIDGE", cf, ( 59931.3, -14681.2, 3075.1 ), ( 0, 349.79, 0 ), "CONTRACT_HEIST_Q4_EPIC_BRIDGE_crash_site_reinforce_3", "cspf_2_auto4313173298291022033", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_heist_cs";
    s.groupid = "reinforcement_spawn_point_3";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "CONTRACT_HEIST_Q4_EPIC_BRIDGE", cf, ( 62547.1, -5418.34, 10497.5 ), ( 359.47, 79.72, 0.49 ), "cspf_2_auto11534275408105821906", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_heist_cs";
    s.groupid = "reinforcement_spawn_point_3";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "CONTRACT_HEIST_Q4_EPIC_BRIDGE", cf, ( 46439, -16671.7, 9351.34 ), ( 0, 11.34, 0 ), undefined, "cspf_2_auto920453900958799151", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150, 1 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_heist_cs";
    s.groupid = "reinforcement_spawn_point_3";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "CONTRACT_HEIST_Q4_EPIC_BRIDGE", cf, ( 61565.6, -9374.7, 7383.55 ), ( 359.47, 74.72, 0.49 ), "cspf_2_auto4313173298291022033", "cspf_2_auto11534275408105821906", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_heist_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s.height = 5000;
    s.name = "crash_approximity_trigger";
    fe [[ f ]]( s, "CONTRACT_HEIST_Q4_EPIC_BRIDGE", cf, ( 59062.7, -16103.4, 2332.22 ), ( 0.18, 284.53, 1.19 ), "cspf_2_auto13312210101989124962", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 7000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_heist_cs";
    s.groupid = "reinforcement_spawn_point_3";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "CONTRACT_HEIST_Q4_EPIC_BRIDGE", cf, ( 51916.2, -15675.9, 8273.8 ), ( 0, 14.46, 0 ), "cspf_2_auto920453900958799151", "CONTRACT_HEIST_Q4_EPIC_BRIDGE_crash_site_reinforce_3", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
}

// Namespace mp_sat_avalon_q4_ob_contract_heist_cs
// Params 0
// Checksum 0x70b05388, Offset: 0x1bf0
// Size: 0xbf
function function_d9dd7965c51c95d1()
{
    activityinstances = [];
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_activitydefinition_heist";
    var_881289d7987bc770.var_7a0840be22b9ebb = "CRASH_SITES_Q4_ABANDONED_VILLAGE_RUINS";
    var_881289d7987bc770.cf = "mp_sat_avalon_q4_ob_contract_heist_cs";
    var_881289d7987bc770.scriptstructorigin = ( 58884, -16048.6, 2301.6 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [];
    var_881289d7987bc770.var_31ce4477e3543d24 = [];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [];
    var_881289d7987bc770.locationradius = [];
    activityinstances[ "CONTRACT_HEIST_Q4_EPIC_BRIDGE" ] = var_881289d7987bc770;
    return activityinstances;
}

