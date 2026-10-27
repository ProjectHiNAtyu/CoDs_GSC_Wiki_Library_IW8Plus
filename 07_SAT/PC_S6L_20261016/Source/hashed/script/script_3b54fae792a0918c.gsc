// script_3b54fae792a0918c  (hash_3b54fae792a0918c.gscc) (size: 18901 Bytes / 0x49d5 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xab65e226 (2875580966)
// size ...... 18901 (0x49d5)
// includes .. 4   (offset: 0x3fc9)
// strings ... 74  (offset: 0x3fe9)
// dev strs .. 0   (offset: 0x49d5)
// exports ... 14  (offset: 0x3a9d)
// cseg ...... 0x8a8 + 0x31f5 (0x3a9d)
// imports ... 27  (offset: 0x3ccd)
// animtree1 . 0   (offset: 0x49d5)
// animtree2 . 0   (offset: 0x49d5)
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace mp_sat_avalon_q2_ob_contract_heist_cs;

// Namespace mp_sat_avalon_q2_ob_contract_heist_cs
// Params 0, eflags: 0x5
// Checksum 0x6b7d6c87, Offset: 0x8c6
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"mp_sat_avalon_q2_ob_contract_heist_cs", #"activity_common", &function_b39ecd3d51489472, undefined );
}

// Namespace mp_sat_avalon_q2_ob_contract_heist_cs
// Params 0, eflags: 0x4
// Checksum 0xcba7abcb, Offset: 0x8ef
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace mp_sat_avalon_q2_ob_contract_heist_cs
// Params 0, eflags: 0x4
// Checksum 0x4e9c7827, Offset: 0x900
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace mp_sat_avalon_q2_ob_contract_heist_cs
// Params 2
// Checksum 0x7296c3e3, Offset: 0x911
// Size: 0x8c
function main( unused, unused2 )
{
    if ( utility::flag_exist( "mp_sat_avalon_q2_ob_contract_heist_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "mp_sat_avalon_q2_ob_contract_heist_cs" ) )
    {
        return;
    }
    
    activity_common::function_e1df676808c1d1e3( &function_4cd78e661617f3 );
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "mp_sat_avalon_q2_ob_contract_heist_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "mp_sat_avalon_q2_ob_contract_heist_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace mp_sat_avalon_q2_ob_contract_heist_cs
// Params 3, eflags: 0x4
// Checksum 0xcd1ecce8, Offset: 0x9a5
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "mp_sat_avalon_q2_ob_contract_heist_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "mp_sat_avalon_q2_ob_contract_heist_cs" );
}

// Namespace mp_sat_avalon_q2_ob_contract_heist_cs
// Params 3, eflags: 0x4
// Checksum 0xc9e90cfc, Offset: 0xa1f
// Size: 0x129e
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_heist_cs";
    s.name = "contract_heist_qzone_terminal";
    fe [[ f ]]( s, us, cf, ( 17947, 49844.2, 976 ), ( 0, 357.61, 0 ), undefined, undefined, "Qzone_terminal_for_Heist" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_heist_cs";
    s.name = "contract_heist_qzone_terminal";
    fe [[ f ]]( s, us, cf, ( 12392, 43336.2, 715 ), ( 0, 69.96, 0 ), undefined, undefined, "Qzone_terminal_for_Heist" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_heist_cs";
    s.activity_bundle = "sat_activitydefinition_heist";
    s.name = "CONTRACT_HEIST_Q2_WINERY";
    s.var_7a0840be22b9ebb = "CRASH_SITES_Q2_RESORT";
    fe [[ f ]]( s, "CONTRACT_HEIST_Q2_WINERY", cf, ( 10824.3, 30040, 2283.09 ), ( 0, 290, 0 ), "activity_nexus_variant", "cspf_1_auto8139828218522771350", undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_heist_cs";
    fe [[ f ]]( s, "CONTRACT_HEIST_Q2_WINERY", cf, ( 11832.7, 50650.2, 638 ), ( 0, 287.36, 0 ), "activity_nexus_instance_joiner", undefined, "CONTRACT_HEIST_Q2_WINERY", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_heist_cs";
    fe [[ f ]]( s, "CONTRACT_HEIST_Q2_WINERY", cf, ( 12200.9, 31454, 1982.37 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Awareness_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 7000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_heist_cs";
    s.groupid = "reinforcement_spawn_point_2";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "heist_vtol_reinforcement";
    s.variantname = "ai_encounter_spawnpoint";
    s.var_4501e0172e168ddf = "CONTRACT_HEIST_Q2_WINERY_crash_site_reinforce_2";
    fe [[ f ]]( s, "CONTRACT_HEIST_Q2_WINERY", cf, ( 12213.7, 31475.1, 2212.14 ), ( 0, 233.63, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_heist_cs";
    s.groupid = "reinforcement_spawn_point_1";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "heist_vtol_reinforcement";
    s.variantname = "ai_encounter_spawnpoint";
    s.var_4501e0172e168ddf = "CONTRACT_HEIST_Q2_WINERY_crash_site_reinforce_1";
    fe [[ f ]]( s, "CONTRACT_HEIST_Q2_WINERY", cf, ( 12166, 28140.6, 2021.65 ), ( 0, 125.45, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_heist_cs";
    s.groupid = "reinforcement_spawn_point_3";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "heist_vtol_reinforcement";
    s.variantname = "ai_encounter_spawnpoint";
    s.var_4501e0172e168ddf = "CONTRACT_HEIST_Q2_WINERY_crash_site_reinforce_3";
    fe [[ f ]]( s, "CONTRACT_HEIST_Q2_WINERY", cf, ( 9197.09, 30878.2, 2378.76 ), ( 0, 5.92, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_heist_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "CONTRACT_HEIST_Q2_WINERY", cf, ( 10577.9, 30007, 2311.5 ), ( 0, 191.42, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_heist_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "CONTRACT_HEIST_Q2_WINERY", cf, ( 10663.3, 30247.2, 2311.5 ), ( 0, 142.58, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_heist_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "CONTRACT_HEIST_Q2_WINERY", cf, ( 10688.9, 29776.8, 2311.5 ), ( 0, 254.76, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_heist_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "CONTRACT_HEIST_Q2_WINERY", cf, ( 11105.6, 29984.2, 2311.5 ), ( 0, 355.58, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_heist_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "CONTRACT_HEIST_Q2_WINERY", cf, ( 10916.3, 30335, 2294.25 ), ( 0, 84.96, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_heist_cs";
    fe [[ f ]]( s, "CONTRACT_HEIST_Q2_WINERY", cf, ( 10687.1, 30039.2, 2306.79 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "OB_Spacer_Spatial_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 2000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_heist_cs";
    fe [[ f ]]( s, "CONTRACT_HEIST_Q2_WINERY", cf, ( 10687.1, 30039.2, 1857.42 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Ambient_AI_Exclusion_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 4000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_heist_cs";
    s.name = "contract_heist_qzone_terminal";
    fe [[ f ]]( s, us, cf, ( 5235.55, 22319.8, 698 ), ( 0, 161.57, 0 ), undefined, undefined, "Qzone_terminal_for_Heist" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_heist_cs";
    s.name = "contract_heist_qzone_terminal";
    fe [[ f ]]( s, us, cf, ( 30389.6, 49501.5, 1528 ), ( 0, 99.48, 0 ), undefined, undefined, "Qzone_terminal_for_Heist" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_heist_cs";
    s.activity_bundle = "sat_activitydefinition_heist";
    s.name = "CONTRACT_HEIST_Q2_DIGSITE";
    s.var_7a0840be22b9ebb = "CRASH_SITES_Q2_WINERY_WINDMILL";
    fe [[ f ]]( s, "CONTRACT_HEIST_Q2_DIGSITE", cf, ( 28901.1, 31457.1, 3068.48 ), ( 0, 290, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_heist_cs";
    fe [[ f ]]( s, "CONTRACT_HEIST_Q2_DIGSITE", cf, ( 42663.2, 35716.3, 1484.43 ), ( 0, 45, 0 ), "activity_nexus_instance_joiner", undefined, "CONTRACT_HEIST_Q2_DIGSITE", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_heist_cs";
    fe [[ f ]]( s, "CONTRACT_HEIST_Q2_DIGSITE", cf, ( 28909.4, 31416.2, 3082.66 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Awareness_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 7000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_heist_cs";
    s.groupid = "reinforcement_spawn_point_2";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "heist_vtol_reinforcement";
    s.variantname = "ai_encounter_spawnpoint";
    s.var_4501e0172e168ddf = "CONTRACT_HEIST_Q2_DIGSITE_crash_site_reinforce_2";
    fe [[ f ]]( s, "CONTRACT_HEIST_Q2_DIGSITE", cf, ( 29616, 31935.4, 3458.02 ), ( 0, 233.63, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_heist_cs";
    s.groupid = "reinforcement_spawn_point_1";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "heist_vtol_reinforcement";
    s.variantname = "ai_encounter_spawnpoint";
    s.var_4501e0172e168ddf = "CONTRACT_HEIST_Q2_DIGSITE_crash_site_reinforce_1";
    fe [[ f ]]( s, "CONTRACT_HEIST_Q2_DIGSITE", cf, ( 29626.9, 30089, 3504.95 ), ( 0, 127.88, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_heist_cs";
    s.groupid = "reinforcement_spawn_point_3";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "heist_vtol_reinforcement";
    s.variantname = "ai_encounter_spawnpoint";
    s.var_4501e0172e168ddf = "CONTRACT_HEIST_Q2_DIGSITE_crash_site_reinforce_3";
    fe [[ f ]]( s, "CONTRACT_HEIST_Q2_DIGSITE", cf, ( 27789.3, 30962.1, 3595.55 ), ( 0, 0.92, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_heist_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "CONTRACT_HEIST_Q2_DIGSITE", cf, ( 10577.9, 30007, 2311.5 ), ( 0, 191.42, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_heist_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "CONTRACT_HEIST_Q2_DIGSITE", cf, ( 10663.3, 30247.2, 2311.5 ), ( 0, 142.58, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_heist_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "CONTRACT_HEIST_Q2_DIGSITE", cf, ( 10688.9, 29776.8, 2311.5 ), ( 0, 254.76, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_heist_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "CONTRACT_HEIST_Q2_DIGSITE", cf, ( 11105.6, 29984.2, 2311.5 ), ( 0, 355.58, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_heist_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "CONTRACT_HEIST_Q2_DIGSITE", cf, ( 10916.3, 30335, 2294.25 ), ( 0, 84.96, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_heist_cs";
    fe [[ f ]]( s, "CONTRACT_HEIST_Q2_DIGSITE", cf, ( 28913.1, 31421.8, 3082.52 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "OB_Spacer_Spatial_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 2000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_heist_cs";
    fe [[ f ]]( s, "CONTRACT_HEIST_Q2_DIGSITE", cf, ( 28924.1, 31426.2, 3082.79 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Ambient_AI_Exclusion_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 4000 );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace mp_sat_avalon_q2_ob_contract_heist_cs
// Params 0, eflags: 0x4
// Checksum 0x651277ae, Offset: 0x1cc5
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace mp_sat_avalon_q2_ob_contract_heist_cs
// Params 0
// Checksum 0xf4d11a5, Offset: 0x1ccf
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "mp_sat_avalon_q2_ob_contract_heist_cs" );
}

// Namespace mp_sat_avalon_q2_ob_contract_heist_cs
// Params 0
// Checksum 0x5662e655, Offset: 0x1ce5
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

// Namespace mp_sat_avalon_q2_ob_contract_heist_cs
// Params 4
// Checksum 0xe39d5626, Offset: 0x1d54
// Size: 0x71
function function_d4323822d7042e5a( var_4312b79c960726b6, fe, us, cf = "mp_sat_avalon_q2_ob_contract_heist_cs" )
{
    switch ( var_4312b79c960726b6 )
    {
        case #"hash_567e3ed134404906":
            function_160a46118ad7fc7e( fe, us, cf );
            break;
        case #"hash_f9255268378d6f09":
            function_47e346004f56bba1( fe, us, cf );
            break;
    }
}

// Namespace mp_sat_avalon_q2_ob_contract_heist_cs
// Params 3
// Checksum 0xa30da8e3, Offset: 0x1dcd
// Size: 0xdad
function function_160a46118ad7fc7e( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_heist_cs";
    s.groupid = "uav_path";
    s.name = "uav_stall_start";
    fe [[ f ]]( s, "CONTRACT_HEIST_Q2_WINERY", cf, ( 32657.1, -8469.73, 16000 ), ( 0, 119.47, 0 ), "cspf_3_auto532667915284450716", "cspf_3_auto12615583513476428558", "aircraft_crashing_start", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_heist_cs";
    s.groupid = "uav_path";
    s.name = "uav_path_start";
    fe [[ f ]]( s, "CONTRACT_HEIST_Q2_WINERY", cf, ( 64565, -64937.5, 16000 ), ( 0, 119.47, 0 ), "CONTRACT_HEIST_Q2_WINERY", "cspf_3_auto532667915284450716", "aircraft_spawn", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_heist_cs";
    s.groupid = "uav_path";
    s.name = "uav_crash";
    fe [[ f ]]( s, "CONTRACT_HEIST_Q2_WINERY", cf, ( 10924.1, 30144.7, 2292.31 ), ( 14.78, 120.64, -28.98 ), "cspf_3_auto12615583513476428558", "cspf_3_auto6791859846686303827", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_heist_cs";
    s.groupid = "uav_path";
    s.name = "uav_debris";
    fe [[ f ]]( s, "CONTRACT_HEIST_Q2_WINERY", cf, ( 10927.9, 30091.7, 2286.81 ), ( 0, 167.49, 0 ), "cspf_3_auto6791859846686303827", undefined, "uav_debris", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_heist_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s.groupid = "ground_defence";
    s.height = 400;
    s.name = "black_box_trigger";
    fe [[ f ]]( s, "CONTRACT_HEIST_Q2_WINERY", cf, ( 10821.4, 30043.1, 2189.85 ), ( 4.59, 358.47, 0.53 ), "cspf_3_auto9925487417756725785", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 500 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_heist_cs";
    s.groupid = "reinforcement_spawn_point_1";
    s.name = "agent_rally_point";
    fe [[ f ]]( s, "CONTRACT_HEIST_Q2_WINERY", cf, ( 12144.7, 28149.8, 2022.16 ), ( 0, 25.61, 0 ), "cspf_3_auto9925487417756725785", undefined, "agent_rally_point", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 512 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_heist_cs";
    s.groupid = "ground_defence";
    s.name = "blackbox";
    fe [[ f ]]( s, "CONTRACT_HEIST_Q2_WINERY", cf, ( 10821.4, 30043.1, 2283.51 ), ( 6.26, 2.09, 0.45 ), "cspf_3_auto6791859846686303827", "cspf_3_auto9925487417756725785", "black_box", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_heist_cs";
    s.groupid = "reinforcement_spawn_point_2";
    s.name = "agent_rally_point";
    fe [[ f ]]( s, "CONTRACT_HEIST_Q2_WINERY", cf, ( 12215, 31476.3, 2212.11 ), ( 0, 321.45, 0 ), "cspf_3_auto9925487417756725785", undefined, "agent_rally_point", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 512 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_heist_cs";
    s.groupid = "reinforcement_spawn_point_3";
    s.name = "agent_rally_point";
    fe [[ f ]]( s, "CONTRACT_HEIST_Q2_WINERY", cf, ( 9198.83, 30877.2, 2378.48 ), ( 0, 5, 0 ), "cspf_3_auto9925487417756725785", undefined, "agent_rally_point", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 512 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_heist_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s.height = 5000;
    s.name = "crash_approximity_trigger";
    fe [[ f ]]( s, "CONTRACT_HEIST_Q2_WINERY", cf, ( 10861, 30023.6, 1769.44 ), ( 357.92, 303.04, 2.45 ), "cspf_3_auto6791859846686303827", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 5000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_heist_cs";
    s.groupid = "reinforcement_spawn_point_2";
    s.ishelistruct = 1;
    s.script_accel = "350";
    fe [[ f ]]( s, "CONTRACT_HEIST_Q2_WINERY", cf, ( 12070.8, 31438.3, 2834.62 ), ( 0, 144.79, 0 ), "CONTRACT_HEIST_Q2_WINERY_crash_site_reinforce_2", "cspf_3_auto12969767731744201512", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_heist_cs";
    s.groupid = "reinforcement_spawn_point_2";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "CONTRACT_HEIST_Q2_WINERY", cf, ( 15213, 40600.1, 10177 ), ( 359.47, 54.72, 0.49 ), "cspf_3_auto2571006957860739162", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_heist_cs";
    s.groupid = "reinforcement_spawn_point_2";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "CONTRACT_HEIST_Q2_WINERY", cf, ( 24528.7, 27135.6, 9030.81 ), ( 0, 166.34, 0 ), undefined, "cspf_3_auto300186647103802371", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150, 1 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_heist_cs";
    s.groupid = "reinforcement_spawn_point_2";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "CONTRACT_HEIST_Q2_WINERY", cf, ( 12203.8, 36484, 7063.06 ), ( 359.47, 69.72, 0.5 ), "cspf_3_auto12969767731744201512", "cspf_3_auto2571006957860739162", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_heist_cs";
    s.groupid = "reinforcement_spawn_point_2";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "CONTRACT_HEIST_Q2_WINERY", cf, ( 19144, 28547.8, 7953.31 ), ( 0, 169.46, 0 ), "cspf_3_auto300186647103802371", "CONTRACT_HEIST_Q2_WINERY_crash_site_reinforce_2", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_heist_cs";
    s.groupid = "reinforcement_spawn_point_1";
    s.ishelistruct = 1;
    s.script_accel = "350";
    fe [[ f ]]( s, "CONTRACT_HEIST_Q2_WINERY", cf, ( 12044.4, 28068.7, 2658.62 ), ( 0, 144.79, 0 ), "CONTRACT_HEIST_Q2_WINERY_crash_site_reinforce_1", "cspf_3_auto14702287996722554019", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_heist_cs";
    s.groupid = "reinforcement_spawn_point_1";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "CONTRACT_HEIST_Q2_WINERY", cf, ( 5419.38, 23905.5, 10177 ), ( 359.47, 214.72, 0.5 ), "cspf_3_auto2595496216341312511", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_heist_cs";
    s.groupid = "reinforcement_spawn_point_1";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "CONTRACT_HEIST_Q2_WINERY", cf, ( 22061.3, 19675, 9030.81 ), ( 0, 141.34, 0 ), undefined, "cspf_3_auto4946474192699744393", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150, 1 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_heist_cs";
    s.groupid = "reinforcement_spawn_point_1";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "CONTRACT_HEIST_Q2_WINERY", cf, ( 9347.47, 26868.3, 7063.06 ), ( 359.47, 209.72, 0.5 ), "cspf_3_auto14702287996722554019", "cspf_3_auto2595496216341312511", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_heist_cs";
    s.groupid = "reinforcement_spawn_point_1";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "CONTRACT_HEIST_Q2_WINERY", cf, ( 17777.9, 23230.6, 7953.31 ), ( 0, 144.46, 0 ), "cspf_3_auto4946474192699744393", "CONTRACT_HEIST_Q2_WINERY_crash_site_reinforce_1", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_heist_cs";
    s.groupid = "reinforcement_spawn_point_3";
    s.ishelistruct = 1;
    s.script_accel = "350";
    fe [[ f ]]( s, "CONTRACT_HEIST_Q2_WINERY", cf, ( 9198.48, 30795.2, 2986.62 ), ( 0, 294.79, 0 ), "CONTRACT_HEIST_Q2_WINERY_crash_site_reinforce_3", "cspf_3_auto13162397884241098630", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_heist_cs";
    s.groupid = "reinforcement_spawn_point_3";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "CONTRACT_HEIST_Q2_WINERY", cf, ( 4529.83, 17798.7, 10177 ), ( 359.47, 254.72, 0.49 ), "cspf_3_auto9940559182575149040", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_heist_cs";
    s.groupid = "reinforcement_spawn_point_3";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "CONTRACT_HEIST_Q2_WINERY", cf, ( 4647.25, 42647.6, 9030.81 ), ( 0, 291.34, 0 ), undefined, "cspf_3_auto17336514702075182739", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150, 1 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_heist_cs";
    s.groupid = "reinforcement_spawn_point_3";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "CONTRACT_HEIST_Q2_WINERY", cf, ( 7068.75, 24326.4, 7239.06 ), ( 359.47, 264.72, 0.49 ), "cspf_3_auto13162397884241098630", "cspf_3_auto9940559182575149040", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_heist_cs";
    s.groupid = "reinforcement_spawn_point_3";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "CONTRACT_HEIST_Q2_WINERY", cf, ( 6578.99, 37426.6, 7953.31 ), ( 0, 294.46, 0 ), "cspf_3_auto17336514702075182739", "CONTRACT_HEIST_Q2_WINERY_crash_site_reinforce_3", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
}

// Namespace mp_sat_avalon_q2_ob_contract_heist_cs
// Params 3
// Checksum 0x845e37fb, Offset: 0x2b82
// Size: 0xdad
function function_47e346004f56bba1( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_heist_cs";
    s.groupid = "uav_path";
    s.name = "uav_stall_start";
    fe [[ f ]]( s, "CONTRACT_HEIST_Q2_DIGSITE", cf, ( 47963.4, 30914.8, 12240.1 ), ( 0, 178.53, 0 ), "cspf_4_auto532667915284450716", "cspf_4_auto12615583513476428558", "aircraft_crashing_start", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_heist_cs";
    s.groupid = "uav_path";
    s.name = "uav_path_start";
    fe [[ f ]]( s, "CONTRACT_HEIST_Q2_DIGSITE", cf, ( 82859, 29379.3, 14930.2 ), ( 0, 177.48, 0 ), "CONTRACT_HEIST_Q2_DIGSITE", "cspf_4_auto532667915284450716", "aircraft_spawn", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_heist_cs";
    s.groupid = "uav_path";
    s.name = "uav_crash";
    fe [[ f ]]( s, "CONTRACT_HEIST_Q2_DIGSITE", cf, ( 28921.5, 31408.5, 3069.71 ), ( 23.44, 178.01, 0 ), "cspf_4_auto12615583513476428558", "cspf_4_auto6791859846686303827", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_heist_cs";
    s.groupid = "uav_path";
    s.name = "uav_debris";
    fe [[ f ]]( s, "CONTRACT_HEIST_Q2_DIGSITE", cf, ( 28912.5, 31418.5, 3068.68 ), ( 0, 346.02, 0 ), "cspf_4_auto6791859846686303827", undefined, "uav_debris", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_heist_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s.groupid = "ground_defence";
    s.height = 300;
    s.name = "black_box_trigger";
    fe [[ f ]]( s, "CONTRACT_HEIST_Q2_DIGSITE", cf, ( 28902.1, 31457.9, 3084.51 ), ( 0, 0, 0 ), "cspf_4_auto9925487417756725785", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 500 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_heist_cs";
    s.groupid = "reinforcement_spawn_point_1";
    s.name = "agent_rally_point";
    fe [[ f ]]( s, "CONTRACT_HEIST_Q2_DIGSITE", cf, ( 29639.1, 30071.7, 3505.46 ), ( 0, 321.45, 0 ), "cspf_4_auto9925487417756725785", undefined, "agent_rally_point", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 512 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_heist_cs";
    s.groupid = "ground_defence";
    s.name = "blackbox";
    fe [[ f ]]( s, "CONTRACT_HEIST_Q2_DIGSITE", cf, ( 28905.4, 31459, 3069.22 ), ( 6.81, 357.94, 4.74 ), "cspf_4_auto6791859846686303827", "cspf_4_auto9925487417756725785", "black_box", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_heist_cs";
    s.groupid = "reinforcement_spawn_point_2";
    s.name = "agent_rally_point";
    fe [[ f ]]( s, "CONTRACT_HEIST_Q2_DIGSITE", cf, ( 29613.3, 31931.1, 3455.87 ), ( 0, 0, 0 ), "cspf_4_auto9925487417756725785", undefined, "agent_rally_point", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 512 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_heist_cs";
    s.groupid = "reinforcement_spawn_point_3";
    s.name = "agent_rally_point";
    fe [[ f ]]( s, "CONTRACT_HEIST_Q2_DIGSITE", cf, ( 27794.1, 30961.8, 3595.36 ), ( 0, 25.61, 0 ), "cspf_4_auto9925487417756725785", undefined, "agent_rally_point", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 512 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_heist_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s.height = 5000;
    s.name = "crash_approximity_trigger";
    fe [[ f ]]( s, "CONTRACT_HEIST_Q2_DIGSITE", cf, ( 28933, 31350.8, 3072 ), ( 357.92, 303.04, 2.45 ), "cspf_4_auto6791859846686303827", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 5000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_heist_cs";
    s.groupid = "reinforcement_spawn_point_2";
    s.ishelistruct = 1;
    s.script_accel = "350";
    fe [[ f ]]( s, "CONTRACT_HEIST_Q2_DIGSITE", cf, ( 29506.2, 31908, 4137.87 ), ( 0, 123.42, 0 ), "CONTRACT_HEIST_Q2_DIGSITE_crash_site_reinforce_2", "cspf_4_auto12969767731744201512", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_heist_cs";
    s.groupid = "reinforcement_spawn_point_2";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "CONTRACT_HEIST_Q2_DIGSITE", cf, ( 24743.7, 41778.1, 11804.8 ), ( 359.47, 109.72, 0.49 ), "cspf_4_auto2571006957860739162", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_heist_cs";
    s.groupid = "reinforcement_spawn_point_2";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "CONTRACT_HEIST_Q2_DIGSITE", cf, ( 38368.4, 19026.3, 10658.6 ), ( 0, 126.34, 0 ), undefined, "cspf_4_auto300186647103802371", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150, 1 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_heist_cs";
    s.groupid = "reinforcement_spawn_point_2";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "CONTRACT_HEIST_Q2_DIGSITE", cf, ( 26375.1, 37600.5, 8690.81 ), ( 359.47, 109.72, 0.49 ), "cspf_4_auto12969767731744201512", "cspf_4_auto2571006957860739162", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_heist_cs";
    s.groupid = "reinforcement_spawn_point_2";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "CONTRACT_HEIST_Q2_DIGSITE", cf, ( 35151.1, 23569.5, 9581.06 ), ( 0, 129.46, 0 ), "cspf_4_auto300186647103802371", "CONTRACT_HEIST_Q2_DIGSITE_crash_site_reinforce_2", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_heist_cs";
    s.groupid = "reinforcement_spawn_point_1";
    s.ishelistruct = 1;
    s.script_accel = "350";
    fe [[ f ]]( s, "CONTRACT_HEIST_Q2_DIGSITE", cf, ( 29702.7, 30092.5, 4082.37 ), ( 0, 24.79, 0 ), "CONTRACT_HEIST_Q2_DIGSITE_crash_site_reinforce_1", "cspf_4_auto14702287996722554019", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_heist_cs";
    s.groupid = "reinforcement_spawn_point_1";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "CONTRACT_HEIST_Q2_DIGSITE", cf, ( 39341.2, 33895, 11804.8 ), ( 359.47, 19.72, 0.49 ), "cspf_4_auto2595496216341312511", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_heist_cs";
    s.groupid = "reinforcement_spawn_point_1";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "CONTRACT_HEIST_Q2_DIGSITE", cf, ( 16765.5, 21624.7, 10658.6 ), ( 0, 36.34, 0 ), undefined, "cspf_4_auto4946474192699744393", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150, 1 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_heist_cs";
    s.groupid = "reinforcement_spawn_point_1";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "CONTRACT_HEIST_Q2_DIGSITE", cf, ( 35163.6, 32263.6, 8690.81 ), ( 359.47, 19.72, 0.49 ), "cspf_4_auto14702287996722554019", "cspf_4_auto2595496216341312511", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_heist_cs";
    s.groupid = "reinforcement_spawn_point_1";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "CONTRACT_HEIST_Q2_DIGSITE", cf, ( 21308.6, 24842, 9581.06 ), ( 0, 39.46, 0 ), "cspf_4_auto4946474192699744393", "CONTRACT_HEIST_Q2_DIGSITE_crash_site_reinforce_1", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_heist_cs";
    s.groupid = "reinforcement_spawn_point_3";
    s.ishelistruct = 1;
    s.script_accel = "350";
    fe [[ f ]]( s, "CONTRACT_HEIST_Q2_DIGSITE", cf, ( 27875.7, 30910.3, 4206.37 ), ( 0, 294.79, 0 ), "CONTRACT_HEIST_Q2_DIGSITE_crash_site_reinforce_3", "cspf_4_auto13162397884241098630", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_heist_cs";
    s.groupid = "reinforcement_spawn_point_3";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "CONTRACT_HEIST_Q2_DIGSITE", cf, ( 31790.2, 21363.8, 11860.8 ), ( 359.47, 289.72, 0.49 ), "cspf_4_auto9940559182575149040", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_heist_cs";
    s.groupid = "reinforcement_spawn_point_3";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "CONTRACT_HEIST_Q2_DIGSITE", cf, ( 19520, 43939.5, 10714.6 ), ( 0, 306.34, 0 ), undefined, "cspf_4_auto17336514702075182739", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150, 1 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_heist_cs";
    s.groupid = "reinforcement_spawn_point_3";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "CONTRACT_HEIST_Q2_DIGSITE", cf, ( 30158.8, 25541.4, 8746.81 ), ( 359.47, 289.72, 0.49 ), "cspf_4_auto13162397884241098630", "cspf_4_auto9940559182575149040", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_heist_cs";
    s.groupid = "reinforcement_spawn_point_3";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "CONTRACT_HEIST_Q2_DIGSITE", cf, ( 22737.2, 39396.4, 9637.06 ), ( 0, 309.46, 0 ), "cspf_4_auto17336514702075182739", "CONTRACT_HEIST_Q2_DIGSITE_crash_site_reinforce_3", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
}

// Namespace mp_sat_avalon_q2_ob_contract_heist_cs
// Params 0
// Checksum 0xc7dd2820, Offset: 0x3937
// Size: 0x165
function function_d9dd7965c51c95d1()
{
    activityinstances = [];
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_activitydefinition_heist";
    var_881289d7987bc770.var_7a0840be22b9ebb = "CRASH_SITES_Q2_RESORT";
    var_881289d7987bc770.cf = "mp_sat_avalon_q2_ob_contract_heist_cs";
    var_881289d7987bc770.scriptstructorigin = ( 10824.3, 30040, 2283.09 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [];
    var_881289d7987bc770.var_31ce4477e3543d24 = [];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [];
    var_881289d7987bc770.locationradius = [];
    activityinstances[ "CONTRACT_HEIST_Q2_WINERY" ] = var_881289d7987bc770;
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_activitydefinition_heist";
    var_881289d7987bc770.var_7a0840be22b9ebb = "CRASH_SITES_Q2_WINERY_WINDMILL";
    var_881289d7987bc770.cf = "mp_sat_avalon_q2_ob_contract_heist_cs";
    var_881289d7987bc770.scriptstructorigin = ( 28901.1, 31457.1, 3068.48 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [];
    var_881289d7987bc770.var_31ce4477e3543d24 = [];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [];
    var_881289d7987bc770.locationradius = [];
    activityinstances[ "CONTRACT_HEIST_Q2_DIGSITE" ] = var_881289d7987bc770;
    return activityinstances;
}

