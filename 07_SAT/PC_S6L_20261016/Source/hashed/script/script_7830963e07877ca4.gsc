// script_7830963e07877ca4  (hash_7830963e07877ca4.gscc) (size: 40961 Bytes / 0xa001 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x8d27af8d (2368188301)
// size ...... 40961 (0xa001)
// includes .. 4   (offset: 0x8949)
// strings ... 127 (offset: 0x8969)
// dev strs .. 0   (offset: 0xa001)
// exports ... 21  (offset: 0x8225)
// cseg ...... 0x125a + 0x6fcb (0x8225)
// imports ... 34  (offset: 0x856d)
// animtree1 . 0   (offset: 0xa001)
// animtree2 . 0   (offset: 0xa001)
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace mp_sat_avalon_q4_ob_activity_roadside_assistance_cs;

// Namespace mp_sat_avalon_q4_ob_activity_roadside_assistance_cs
// Params 0, eflags: 0x5
// Checksum 0x2905fd81, Offset: 0x1278
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"mp_sat_avalon_q4_ob_activity_roadside_assistance_cs", #"activity_common", &function_b39ecd3d51489472, undefined );
}

// Namespace mp_sat_avalon_q4_ob_activity_roadside_assistance_cs
// Params 0, eflags: 0x4
// Checksum 0xb3bf0eef, Offset: 0x12a1
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace mp_sat_avalon_q4_ob_activity_roadside_assistance_cs
// Params 0, eflags: 0x4
// Checksum 0x3684dd03, Offset: 0x12b2
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace mp_sat_avalon_q4_ob_activity_roadside_assistance_cs
// Params 2
// Checksum 0xdfb7b595, Offset: 0x12c3
// Size: 0x8c
function main( unused, unused2 )
{
    if ( utility::flag_exist( "mp_sat_avalon_q4_ob_activity_roadside_assistance_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "mp_sat_avalon_q4_ob_activity_roadside_assistance_cs" ) )
    {
        return;
    }
    
    activity_common::function_e1df676808c1d1e3( &function_4cd78e661617f3 );
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "mp_sat_avalon_q4_ob_activity_roadside_assistance_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "mp_sat_avalon_q4_ob_activity_roadside_assistance_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace mp_sat_avalon_q4_ob_activity_roadside_assistance_cs
// Params 3, eflags: 0x4
// Checksum 0xb50669cc, Offset: 0x1357
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "mp_sat_avalon_q4_ob_activity_roadside_assistance_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "mp_sat_avalon_q4_ob_activity_roadside_assistance_cs" );
}

// Namespace mp_sat_avalon_q4_ob_activity_roadside_assistance_cs
// Params 3, eflags: 0x4
// Checksum 0xb62efe4c, Offset: 0x13d1
// Size: 0x5930
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_roadside_assistance_cs";
    s.info_act_ref = "ROADSIDE_ASSISTANCE_warehouses_01_repair_3";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_warehouses_01", cf, ( 28761, -7436, 170 ), ( 0, 194.2, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_roadside_assistance_cs";
    s._size_max = ( 400, 400, 200 );
    s._size_min = ( 400, 400, 200 );
    s.var_5afd49978f924648 = "1";
    s.var_a8568d8e0b0b6076 = "0";
    s.var_3f3960eb7318312d = "1";
    s.default_goal_radius = "-1";
    s.height = 128;
    s.length = "128";
    s.name = "encounter_volume";
    s.script_stealthgroup = "-1";
    s.script_string = "enc_roadside_assistance_guards";
    s.var_95e2cee7aca5aaae = "1";
    s.width = "128";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_warehouses_01", cf, ( 29164, -7262, 177 ), ( 0, 247.89, 0 ), "ROADSIDE_ASSISTANCE_warehouses_01_enc_vol", undefined, "noent_volume_ai_encounter_cs", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_roadside_assistance_cs";
    s.activity_bundle = "sat_ob_activitydef_roadside_assistance";
    s.name = "ROADSIDE_ASSISTANCE_warehouses_01";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_warehouses_01", cf, ( 29164, -7262, 177 ), ( 0, 247.89, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_roadside_assistance_cs";
    s.info_act_ref = "ROADSIDE_ASSISTANCE_warehouses_01_repair_2";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_warehouses_01", cf, ( 29284, -7490, 172 ), ( 0, 293.6, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_roadside_assistance_cs";
    s.info_act_ref = "ROADSIDE_ASSISTANCE_warehouses_01_repair_1";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_warehouses_01", cf, ( 29176, -6868, 171 ), ( 0, 90, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_roadside_assistance_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_warehouses_01", cf, ( 29289, -6900, 170.22 ), ( 0, 249.3, 0 ), undefined, "cspf_1_auto6765928612504745703", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_roadside_assistance_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.var_df8f7b8318d59fe5 = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_warehouses_01", cf, ( 29481, -7376, 180 ), ( 0, 53.21, 0 ), "cspf_1_auto14916520072416908387", "cspf_1_auto3506096206900994066", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_roadside_assistance_cs";
    s.loop_route = "1";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.var_df8f7b8318d59fe5 = "1";
    s.start_point = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_warehouses_01", cf, ( 29248, -6931, 169.17 ), ( 0, 48.64, 0 ), "cspf_1_auto6765928612504745703", "cspf_1_auto14916520072416908387", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_roadside_assistance_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.var_df8f7b8318d59fe5 = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_warehouses_01", cf, ( 29220, -7087, 171 ), ( 0, 227.31, 0 ), "cspf_1_auto3506096206900994066", "cspf_1_auto8524075815580069845", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_roadside_assistance_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.var_df8f7b8318d59fe5 = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_warehouses_01", cf, ( 28779, -7284, 173 ), ( 0, 228.43, 0 ), "cspf_1_auto8524075815580069845", "cspf_1_auto6765928612504745703", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_roadside_assistance_cs";
    s.ai_interaction = "idle_wreck_crouch_investigate";
    s.var_9a1a6bc9877cfff7 = "-1";
    s.repeat_interaction = "0";
    s.script_delay = "0";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_warehouses_01", cf, ( 29049, -7304, 168 ), ( 0, 337.88, 0 ), "ROADSIDE_ASSISTANCE_warehouses_01_repair_1", undefined, "info_act", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_roadside_assistance_cs";
    s.ai_interaction = "idle_wreck_crouch_investigate";
    s.var_9a1a6bc9877cfff7 = "-1";
    s.repeat_interaction = "0";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_warehouses_01", cf, ( 29226, -7341, 176 ), ( 0, 193.3, 0 ), "ROADSIDE_ASSISTANCE_warehouses_01_repair_3", undefined, "info_act", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_roadside_assistance_cs";
    s.ai_interaction = "idle_wreck_investigate";
    s.var_9a1a6bc9877cfff7 = "-1";
    s.repeat_interaction = "0";
    s.script_delay = "0";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_warehouses_01", cf, ( 29261, -7244, 176 ), ( 0, 159.3, 0 ), "ROADSIDE_ASSISTANCE_warehouses_01_repair_2", undefined, "info_act", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_roadside_assistance_cs";
    s.info_act_ref = "ROADSIDE_ASSISTANCE_lowtown_east_01_repair_3";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_lowtown_east_01", cf, ( 14656, -790, 1692 ), ( 0, 225, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_roadside_assistance_cs";
    s._size_max = ( 400, 400, 200 );
    s._size_min = ( 400, 400, 200 );
    s.var_5afd49978f924648 = "1";
    s.var_a8568d8e0b0b6076 = "0";
    s.var_3f3960eb7318312d = "1";
    s.default_goal_radius = "-1";
    s.height = 128;
    s.length = "128";
    s.name = "encounter_volume";
    s.script_stealthgroup = "-1";
    s.script_string = "enc_roadside_assistance_guards";
    s.var_95e2cee7aca5aaae = "1";
    s.width = "128";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_lowtown_east_01", cf, ( 15102, -806, 1778 ), ( 0, 222.59, 0 ), "ROADSIDE_ASSISTANCE_lowtown_east_01_enc_vol", undefined, "noent_volume_ai_encounter_cs", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_roadside_assistance_cs";
    s.activity_bundle = "sat_ob_activitydef_roadside_assistance";
    s.name = "ROADSIDE_ASSISTANCE_lowtown_east_01";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_lowtown_east_01", cf, ( 15102, -806, 1778 ), ( 0, 222.59, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_roadside_assistance_cs";
    s.info_act_ref = "ROADSIDE_ASSISTANCE_lowtown_east_01_repair_2";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_lowtown_east_01", cf, ( 15082, -1016, 1786 ), ( 0, 270, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_roadside_assistance_cs";
    s.info_act_ref = "ROADSIDE_ASSISTANCE_lowtown_east_01_repair_1";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_lowtown_east_01", cf, ( 15324, -1190, 1860 ), ( 0, 45, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_roadside_assistance_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_lowtown_east_01", cf, ( 15138, -474, 1762 ), ( 0, 224, 0 ), undefined, "cspf_2_auto6765928612504745703", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_roadside_assistance_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.var_df8f7b8318d59fe5 = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_lowtown_east_01", cf, ( 15438, -710, 1854 ), ( 0, 27.9, 0 ), "cspf_2_auto14916520072416908387", "cspf_2_auto3506096206900994066", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_roadside_assistance_cs";
    s.loop_route = "1";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.var_df8f7b8318d59fe5 = "1";
    s.start_point = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_lowtown_east_01", cf, ( 15120, -508, 1768 ), ( 0, 23.34, 0 ), "cspf_2_auto6765928612504745703", "cspf_2_auto14916520072416908387", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_roadside_assistance_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.var_df8f7b8318d59fe5 = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_lowtown_east_01", cf, ( 15086, -1196, 1820 ), ( 0, 202.01, 0 ), "cspf_2_auto3506096206900994066", "cspf_2_auto8524075815580069845", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_roadside_assistance_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.var_df8f7b8318d59fe5 = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_lowtown_east_01", cf, ( 14776, -836, 1696 ), ( 0, 203.13, 0 ), "cspf_2_auto8524075815580069845", "cspf_2_auto6765928612504745703", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_roadside_assistance_cs";
    s.ai_interaction = "idle_wreck_crouch_investigate";
    s.var_9a1a6bc9877cfff7 = "-1";
    s.repeat_interaction = "0";
    s.script_delay = "0";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_lowtown_east_01", cf, ( 15072, -730, 1774 ), ( 0, 312.58, 0 ), "ROADSIDE_ASSISTANCE_lowtown_east_01_repair_1", undefined, "info_act", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_roadside_assistance_cs";
    s.ai_interaction = "idle_wreck_crouch_investigate";
    s.var_9a1a6bc9877cfff7 = "-1";
    s.repeat_interaction = "0";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_lowtown_east_01", cf, ( 14998, -908, 1752 ), ( 0, 57.58, 0 ), "ROADSIDE_ASSISTANCE_lowtown_east_01_repair_3", undefined, "info_act", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_roadside_assistance_cs";
    s.ai_interaction = "idle_wreck_investigate";
    s.var_9a1a6bc9877cfff7 = "-1";
    s.repeat_interaction = "0";
    s.script_delay = "0";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_lowtown_east_01", cf, ( 15250, -742, 1818 ), ( 0, 192.57, 0 ), "ROADSIDE_ASSISTANCE_lowtown_east_01_repair_2", undefined, "info_act", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_roadside_assistance_cs";
    s.info_act_ref = "ROADSIDE_ASSISTANCE_water_treatment_01_repair_3";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_water_treatment_01", cf, ( 45106, -6872, 312 ), ( 0.04, 178.6, 0.08 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_roadside_assistance_cs";
    s._size_max = ( 400, 400, 200 );
    s._size_min = ( 400, 400, 200 );
    s.var_5afd49978f924648 = "1";
    s.var_a8568d8e0b0b6076 = "0";
    s.var_3f3960eb7318312d = "1";
    s.default_goal_radius = "-1";
    s.height = 128;
    s.length = "128";
    s.name = "encounter_volume";
    s.script_stealthgroup = "-1";
    s.script_string = "enc_roadside_assistance_guards";
    s.var_95e2cee7aca5aaae = "1";
    s.width = "128";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_water_treatment_01", cf, ( 45548, -7042, 288 ), ( 0.01, 201.19, 0 ), "ROADSIDE_ASSISTANCE_water_treatment_01_enc_vol", undefined, "noent_volume_ai_encounter_cs", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_roadside_assistance_cs";
    s.activity_bundle = "sat_ob_activitydef_roadside_assistance";
    s.name = "ROADSIDE_ASSISTANCE_water_treatment_01";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_water_treatment_01", cf, ( 45548, -7042, 288 ), ( 0.01, 201.19, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_roadside_assistance_cs";
    s.info_act_ref = "ROADSIDE_ASSISTANCE_water_treatment_01_repair_2";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_water_treatment_01", cf, ( 45625, -6681, 313 ), ( 359.96, 358.6, -0.08 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_roadside_assistance_cs";
    s.info_act_ref = "ROADSIDE_ASSISTANCE_water_treatment_01_repair_1";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_water_treatment_01", cf, ( 45313, -7169, 303 ), ( 359.98, 223.6, 0.08 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_roadside_assistance_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_water_treatment_01", cf, ( 45936, -7058, 269 ), ( 0.01, 202.6, 0.09 ), undefined, "cspf_3_auto6765928612504745703", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_roadside_assistance_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.var_df8f7b8318d59fe5 = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_water_treatment_01", cf, ( 45517, -7236, 293 ), ( 359.97, 6.51, -0.08 ), "cspf_3_auto14916520072416908387", "cspf_3_auto3506096206900994066", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_roadside_assistance_cs";
    s.loop_route = "1";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.var_df8f7b8318d59fe5 = "1";
    s.start_point = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_water_treatment_01", cf, ( 45907, -7084, 269 ), ( 359.96, 1.94, -0.08 ), "cspf_3_auto6765928612504745703", "cspf_3_auto14916520072416908387", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_roadside_assistance_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.var_df8f7b8318d59fe5 = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_water_treatment_01", cf, ( 45728, -7033, 279 ), ( 0.04, 180.61, 0.08 ), "cspf_3_auto3506096206900994066", "cspf_3_auto8524075815580069845", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_roadside_assistance_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.var_df8f7b8318d59fe5 = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_water_treatment_01", cf, ( 45726, -6625, 313 ), ( 0.04, 181.73, 0.08 ), "cspf_3_auto8524075815580069845", "cspf_3_auto6765928612504745703", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_roadside_assistance_cs";
    s.ai_interaction = "idle_wreck_crouch_investigate";
    s.var_9a1a6bc9877cfff7 = "-1";
    s.repeat_interaction = "0";
    s.script_delay = "0";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_water_treatment_01", cf, ( 45603, -6922, 289 ), ( 359.98, 223.6, 0.08 ), "ROADSIDE_ASSISTANCE_water_treatment_01_repair_1", undefined, "info_act", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_roadside_assistance_cs";
    s.ai_interaction = "idle_wreck_crouch_investigate";
    s.var_9a1a6bc9877cfff7 = "-1";
    s.repeat_interaction = "0";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_water_treatment_01", cf, ( 45400, -7117, 295 ), ( 0.01, 36.18, -0.09 ), "ROADSIDE_ASSISTANCE_water_treatment_01_repair_3", undefined, "info_act", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_roadside_assistance_cs";
    s.ai_interaction = "idle_wreck_investigate";
    s.var_9a1a6bc9877cfff7 = "-1";
    s.repeat_interaction = "0";
    s.script_delay = "0";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_water_treatment_01", cf, ( 45558, -7137, 291 ), ( 0.08, 88.6, -0.04 ), "ROADSIDE_ASSISTANCE_water_treatment_01_repair_2", undefined, "info_act", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_roadside_assistance_cs";
    s.info_act_ref = "ROADSIDE_ASSISTANCE_heliport_west_01_repair_3";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_heliport_west_01", cf, ( 16687.4, -16608.6, 1524.06 ), ( 358.83, 225, -0.57 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_roadside_assistance_cs";
    s._size_max = ( 400, 400, 200 );
    s._size_min = ( 400, 400, 200 );
    s.var_5afd49978f924648 = "1";
    s.var_a8568d8e0b0b6076 = "0";
    s.var_3f3960eb7318312d = "1";
    s.default_goal_radius = "-1";
    s.height = 128;
    s.length = "128";
    s.name = "encounter_volume";
    s.script_stealthgroup = "-1";
    s.script_string = "enc_roadside_assistance_guards";
    s.var_95e2cee7aca5aaae = "1";
    s.width = "128";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_heliport_west_01", cf, ( 17102, -16844.4, 1459.88 ), ( 0, 197.65, 0 ), "ROADSIDE_ASSISTANCE_heliport_west_01_enc_vol", undefined, "noent_volume_ai_encounter_cs", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_roadside_assistance_cs";
    s.activity_bundle = "sat_ob_activitydef_roadside_assistance";
    s.name = "ROADSIDE_ASSISTANCE_heliport_west_01";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_heliport_west_01", cf, ( 17102, -16844.4, 1459.88 ), ( 359.02, 197.65, 0.86 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_roadside_assistance_cs";
    s.info_act_ref = "ROADSIDE_ASSISTANCE_heliport_west_01_repair_2";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_heliport_west_01", cf, ( 17175, -17047, 1449.18 ), ( 0.57, 360, -1.17 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_roadside_assistance_cs";
    s.info_act_ref = "ROADSIDE_ASSISTANCE_heliport_west_01_repair_1";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_heliport_west_01", cf, ( 16918.2, -17153.2, 1505.32 ), ( 359.58, 270, -1.23 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_roadside_assistance_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_heliport_west_01", cf, ( 17358.2, -16413.3, 1412.47 ), ( 359, 135, 0.84 ), undefined, "cspf_4_auto6765928612504745703", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_roadside_assistance_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.var_df8f7b8318d59fe5 = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_heliport_west_01", cf, ( 17219, -16883, 1440.42 ), ( 0, 26.06, 0 ), "cspf_4_auto14916520072416908387", "cspf_4_auto3506096206900994066", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_roadside_assistance_cs";
    s.loop_route = "1";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.var_df8f7b8318d59fe5 = "1";
    s.start_point = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_heliport_west_01", cf, ( 17327, -16355, 1431.66 ), ( 0, 21.5, 0 ), "cspf_4_auto6765928612504745703", "cspf_4_auto14916520072416908387", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_roadside_assistance_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.var_df8f7b8318d59fe5 = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_heliport_west_01", cf, ( 16959, -16994, 1486.3 ), ( 0, 200.17, 0 ), "cspf_4_auto3506096206900994066", "cspf_4_auto8524075815580069845", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_roadside_assistance_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.var_df8f7b8318d59fe5 = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_heliport_west_01", cf, ( 16821, -16518, 1501.41 ), ( 0, 201.29, 0 ), "cspf_4_auto8524075815580069845", "cspf_4_auto6765928612504745703", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_roadside_assistance_cs";
    s.ai_interaction = "idle_wreck_crouch_investigate";
    s.var_9a1a6bc9877cfff7 = "-1";
    s.repeat_interaction = "0";
    s.script_delay = "0";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_heliport_west_01", cf, ( 17152.9, -16917.1, 1455.74 ), ( 0, 107.66, 0 ), "ROADSIDE_ASSISTANCE_heliport_west_01_repair_1", undefined, "info_act", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_roadside_assistance_cs";
    s.ai_interaction = "idle_wreck_crouch_investigate";
    s.var_9a1a6bc9877cfff7 = "-1";
    s.repeat_interaction = "0";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_heliport_west_01", cf, ( 16965.4, -16894.5, 1475.02 ), ( 0, 32.64, 0 ), "ROADSIDE_ASSISTANCE_heliport_west_01_repair_3", undefined, "info_act", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_roadside_assistance_cs";
    s.ai_interaction = "idle_wreck_investigate";
    s.var_9a1a6bc9877cfff7 = "-1";
    s.repeat_interaction = "0";
    s.script_delay = "0";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_heliport_west_01", cf, ( 17245, -16847.2, 1434.2 ), ( 0, 167.64, 0 ), "ROADSIDE_ASSISTANCE_heliport_west_01_repair_2", undefined, "info_act", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_roadside_assistance_cs";
    s.info_act_ref = "ROADSIDE_ASSISTANCE_truckstop_01_repair_3";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_truckstop_01", cf, ( 40487.4, -21959.3, 190.5 ), ( 0, 270, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_roadside_assistance_cs";
    s._size_max = ( 400, 400, 200 );
    s._size_min = ( 400, 400, 200 );
    s.var_5afd49978f924648 = "1";
    s.var_a8568d8e0b0b6076 = "0";
    s.var_3f3960eb7318312d = "1";
    s.default_goal_radius = "-1";
    s.height = 128;
    s.length = "128";
    s.name = "encounter_volume";
    s.script_stealthgroup = "-1";
    s.script_string = "enc_roadside_assistance_guards";
    s.var_95e2cee7aca5aaae = "1";
    s.width = "128";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_truckstop_01", cf, ( 40508, -22150, 191 ), ( 0, 142.59, 0 ), "ROADSIDE_ASSISTANCE_truckstop_01_enc_vol", undefined, "noent_volume_ai_encounter_cs", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_roadside_assistance_cs";
    s.activity_bundle = "sat_ob_activitydef_roadside_assistance";
    s.name = "ROADSIDE_ASSISTANCE_truckstop_01";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_truckstop_01", cf, ( 40508, -22150, 191 ), ( 0, 142.59, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_roadside_assistance_cs";
    s.info_act_ref = "ROADSIDE_ASSISTANCE_truckstop_01_repair_2";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_truckstop_01", cf, ( 40656, -22104, 242 ), ( 0, 90, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_roadside_assistance_cs";
    s.info_act_ref = "ROADSIDE_ASSISTANCE_truckstop_01_repair_1";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_truckstop_01", cf, ( 40366, -22226, 178.49 ), ( 0, 360, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_roadside_assistance_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_truckstop_01", cf, ( 40558, -21828, 206 ), ( 0, 144, 0 ), undefined, "cspf_5_auto6765928612504745703", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_roadside_assistance_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.var_df8f7b8318d59fe5 = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_truckstop_01", cf, ( 40312, -22062, 156 ), ( 0, 307.9, 0 ), "cspf_5_auto14916520072416908387", "cspf_5_auto3506096206900994066", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_roadside_assistance_cs";
    s.loop_route = "1";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.var_df8f7b8318d59fe5 = "1";
    s.start_point = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_truckstop_01", cf, ( 40520, -21816, 200 ), ( 0, 303.34, 0 ), "cspf_5_auto6765928612504745703", "cspf_5_auto14916520072416908387", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_roadside_assistance_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.var_df8f7b8318d59fe5 = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_truckstop_01", cf, ( 40306, -22380, 176 ), ( 0, 122.01, 0 ), "cspf_5_auto3506096206900994066", "cspf_5_auto8524075815580069845", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_roadside_assistance_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.var_df8f7b8318d59fe5 = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_truckstop_01", cf, ( 40126, -22016, 138 ), ( 0, 123.13, 0 ), "cspf_5_auto8524075815580069845", "cspf_5_auto6765928612504745703", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_roadside_assistance_cs";
    s.ai_interaction = "idle_wreck_crouch_investigate";
    s.var_9a1a6bc9877cfff7 = "-1";
    s.repeat_interaction = "0";
    s.script_delay = "0";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_truckstop_01", cf, ( 40374, -22184, 178 ), ( 0, 52.58, 0 ), "ROADSIDE_ASSISTANCE_truckstop_01_repair_1", undefined, "info_act", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_roadside_assistance_cs";
    s.ai_interaction = "idle_wreck_crouch_investigate";
    s.var_9a1a6bc9877cfff7 = "-1";
    s.repeat_interaction = "0";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_truckstop_01", cf, ( 40488, -22024, 190 ), ( 0, 225, 0 ), "ROADSIDE_ASSISTANCE_truckstop_01_repair_3", undefined, "info_act", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_roadside_assistance_cs";
    s.ai_interaction = "idle_wreck_investigate";
    s.var_9a1a6bc9877cfff7 = "-1";
    s.repeat_interaction = "0";
    s.script_delay = "0";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_truckstop_01", cf, ( 40630, -22158, 244 ), ( 0, 180, 0 ), "ROADSIDE_ASSISTANCE_truckstop_01_repair_2", undefined, "info_act", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_roadside_assistance_cs";
    s.info_act_ref = "ROADSIDE_ASSISTANCE_car_factory_01_repair_3";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_car_factory_01", cf, ( 44320, -39256, 1626 ), ( 0, 45, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_roadside_assistance_cs";
    s._size_max = ( 400, 400, 200 );
    s._size_min = ( 400, 400, 200 );
    s.var_5afd49978f924648 = "1";
    s.var_a8568d8e0b0b6076 = "0";
    s.var_3f3960eb7318312d = "1";
    s.default_goal_radius = "-1";
    s.height = 128;
    s.length = "128";
    s.name = "encounter_volume";
    s.script_stealthgroup = "-1";
    s.script_string = "enc_roadside_assistance_guards";
    s.var_95e2cee7aca5aaae = "1";
    s.width = "128";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_car_factory_01", cf, ( 44142, -39570, 1577.4 ), ( 0, 97.54, 0 ), "ROADSIDE_ASSISTANCE_car_factory_01_enc_vol", undefined, "noent_volume_ai_encounter_cs", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_roadside_assistance_cs";
    s.activity_bundle = "sat_ob_activitydef_roadside_assistance";
    s.name = "ROADSIDE_ASSISTANCE_car_factory_01";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_car_factory_01", cf, ( 44142, -39570, 1577.4 ), ( 0, 97.54, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_roadside_assistance_cs";
    s.info_act_ref = "ROADSIDE_ASSISTANCE_car_factory_01_repair_2";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_car_factory_01", cf, ( 43926, -39920, 1558 ), ( 0, 270, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_roadside_assistance_cs";
    s.info_act_ref = "ROADSIDE_ASSISTANCE_car_factory_01_repair_1";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_car_factory_01", cf, ( 43978, -39542, 1548 ), ( 0, 180, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_roadside_assistance_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_car_factory_01", cf, ( 44184, -39896, 1602 ), ( 0, 90, 0 ), undefined, "cspf_6_auto6765928612504745703", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_roadside_assistance_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.var_df8f7b8318d59fe5 = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_car_factory_01", cf, ( 43892, -39762, 1538 ), ( 0, 264.11, 0 ), "cspf_6_auto14916520072416908387", "cspf_6_auto3506096206900994066", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_roadside_assistance_cs";
    s.loop_route = "1";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.var_df8f7b8318d59fe5 = "1";
    s.start_point = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_car_factory_01", cf, ( 44202, -39846, 1604 ), ( 0, 259.38, 0 ), "cspf_6_auto6765928612504745703", "cspf_6_auto14916520072416908387", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_roadside_assistance_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.var_df8f7b8318d59fe5 = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_car_factory_01", cf, ( 43908, -39276, 1612 ), ( 0, 77.76, 0 ), "cspf_6_auto3506096206900994066", "cspf_6_auto8524075815580069845", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_roadside_assistance_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.var_df8f7b8318d59fe5 = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_car_factory_01", cf, ( 44404, -39354, 1634 ), ( 0, 80.03, 0 ), "cspf_6_auto8524075815580069845", "cspf_6_auto6765928612504745703", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_roadside_assistance_cs";
    s.ai_interaction = "idle_wreck_crouch_investigate";
    s.var_9a1a6bc9877cfff7 = "-1";
    s.repeat_interaction = "0";
    s.script_delay = "0";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_car_factory_01", cf, ( 44224, -39406, 1602 ), ( 0, 225, 0 ), "ROADSIDE_ASSISTANCE_car_factory_01_repair_1", undefined, "info_act", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_roadside_assistance_cs";
    s.ai_interaction = "idle_wreck_crouch_investigate";
    s.var_9a1a6bc9877cfff7 = "-1";
    s.repeat_interaction = "0";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_car_factory_01", cf, ( 44024, -39488, 1552 ), ( 0, 360, 0 ), "ROADSIDE_ASSISTANCE_car_factory_01_repair_3", undefined, "info_act", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_roadside_assistance_cs";
    s.ai_interaction = "idle_wreck_investigate";
    s.var_9a1a6bc9877cfff7 = "-1";
    s.repeat_interaction = "0";
    s.script_delay = "0";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_car_factory_01", cf, ( 44048, -39700, 1562 ), ( 0, 45, 0 ), "ROADSIDE_ASSISTANCE_car_factory_01_repair_2", undefined, "info_act", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_roadside_assistance_cs";
    s.info_act_ref = "ROADSIDE_ASSISTANCE_epic_bridge_01_repair_3";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_epic_bridge_01", cf, ( 24230, -40428, 1442 ), ( 0, 360, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_roadside_assistance_cs";
    s._size_max = ( 400, 400, 200 );
    s._size_min = ( 400, 400, 200 );
    s.var_5afd49978f924648 = "1";
    s.var_a8568d8e0b0b6076 = "0";
    s.var_3f3960eb7318312d = "1";
    s.default_goal_radius = "-1";
    s.height = 128;
    s.length = "128";
    s.name = "encounter_volume";
    s.script_stealthgroup = "-1";
    s.script_string = "enc_roadside_assistance_guards";
    s.var_95e2cee7aca5aaae = "1";
    s.width = "128";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_epic_bridge_01", cf, ( 24156, -40566, 1444 ), ( 0, 8.59, 0 ), "ROADSIDE_ASSISTANCE_epic_bridge_01_enc_vol", undefined, "noent_volume_ai_encounter_cs", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_roadside_assistance_cs";
    s.activity_bundle = "sat_ob_activitydef_roadside_assistance";
    s.name = "ROADSIDE_ASSISTANCE_epic_bridge_01";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_epic_bridge_01", cf, ( 24156, -40566, 1444 ), ( 0, 8.59, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_roadside_assistance_cs";
    s.info_act_ref = "ROADSIDE_ASSISTANCE_epic_bridge_01_repair_2";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_epic_bridge_01", cf, ( 23912, -40604, 1447 ), ( 0, 216, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_roadside_assistance_cs";
    s.info_act_ref = "ROADSIDE_ASSISTANCE_epic_bridge_01_repair_1";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_epic_bridge_01", cf, ( 23871, -40382, 1449 ), ( 0, 180, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_roadside_assistance_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_epic_bridge_01", cf, ( 24093, -40476, 1446 ), ( 0, 10, 0 ), undefined, "cspf_7_auto6765928612504745703", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_roadside_assistance_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.var_df8f7b8318d59fe5 = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_epic_bridge_01", cf, ( 23801, -40568.4, 1451 ), ( 0, 173.9, 0 ), "cspf_7_auto14916520072416908387", "cspf_7_auto3506096206900994066", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_roadside_assistance_cs";
    s.loop_route = "1";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.var_df8f7b8318d59fe5 = "1";
    s.start_point = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_epic_bridge_01", cf, ( 24154, -40482, 1446 ), ( 359, 169.34, 0.01 ), "cspf_7_auto6765928612504745703", "cspf_7_auto14916520072416908387", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_roadside_assistance_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.var_df8f7b8318d59fe5 = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_epic_bridge_01", cf, ( 23774, -40307, 1448 ), ( 0, 348.01, 0 ), "cspf_7_auto3506096206900994066", "cspf_7_auto8524075815580069845", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_roadside_assistance_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.var_df8f7b8318d59fe5 = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_epic_bridge_01", cf, ( 24130.4, -40265.3, 1443 ), ( 0, 349.13, 0 ), "cspf_7_auto8524075815580069845", "cspf_7_auto6765928612504745703", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_roadside_assistance_cs";
    s.ai_interaction = "idle_wreck_crouch_investigate";
    s.var_9a1a6bc9877cfff7 = "-1";
    s.repeat_interaction = "0";
    s.script_delay = "0";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_epic_bridge_01", cf, ( 24261.9, -40647.7, 1443.5 ), ( 0, 98.58, 0 ), "ROADSIDE_ASSISTANCE_epic_bridge_01_repair_1", undefined, "info_act", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_roadside_assistance_cs";
    s.ai_interaction = "idle_wreck_crouch_investigate";
    s.var_9a1a6bc9877cfff7 = "-1";
    s.repeat_interaction = "0";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_epic_bridge_01", cf, ( 24209, -40457, 1443 ), ( 0, 293.57, 0 ), "ROADSIDE_ASSISTANCE_epic_bridge_01_repair_3", undefined, "info_act", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_roadside_assistance_cs";
    s.ai_interaction = "idle_wreck_investigate";
    s.var_9a1a6bc9877cfff7 = "-1";
    s.repeat_interaction = "0";
    s.script_delay = "0";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_epic_bridge_01", cf, ( 24022, -40573, 1447 ), ( 0, 360, 0 ), "ROADSIDE_ASSISTANCE_epic_bridge_01_repair_2", undefined, "info_act", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_roadside_assistance_cs";
    s.info_act_ref = "ROADSIDE_ASSISTANCE_chop_shop_01_repair_3";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_chop_shop_01", cf, ( 7416, -43492, 1606.38 ), ( 0, 315, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_roadside_assistance_cs";
    s._size_max = ( 400, 400, 200 );
    s._size_min = ( 400, 400, 200 );
    s.var_5afd49978f924648 = "1";
    s.var_a8568d8e0b0b6076 = "0";
    s.var_3f3960eb7318312d = "1";
    s.default_goal_radius = "-1";
    s.height = 128;
    s.length = "128";
    s.name = "encounter_volume";
    s.script_stealthgroup = "-1";
    s.script_string = "enc_roadside_assistance_guards";
    s.var_95e2cee7aca5aaae = "1";
    s.width = "128";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_chop_shop_01", cf, ( 7512, -43292, 1676.16 ), ( 0, 198.59, 0 ), "ROADSIDE_ASSISTANCE_chop_shop_01_enc_vol", undefined, "noent_volume_ai_encounter_cs", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_roadside_assistance_cs";
    s.activity_bundle = "sat_ob_activitydef_roadside_assistance";
    s.name = "ROADSIDE_ASSISTANCE_chop_shop_01";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_chop_shop_01", cf, ( 7512, -43292, 1676.16 ), ( 0, 198.59, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_roadside_assistance_cs";
    s.info_act_ref = "ROADSIDE_ASSISTANCE_chop_shop_01_repair_2";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_chop_shop_01", cf, ( 7392, -43206, 1685.05 ), ( 0, 180, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_roadside_assistance_cs";
    s.info_act_ref = "ROADSIDE_ASSISTANCE_chop_shop_01_repair_1";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_chop_shop_01", cf, ( 7898, -43414, 1667.91 ), ( 0, 45, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_roadside_assistance_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_chop_shop_01", cf, ( 7862, -43134, 1712.02 ), ( 0, 200, 0 ), undefined, "cspf_8_auto6765928612504745703", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_roadside_assistance_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.var_df8f7b8318d59fe5 = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_chop_shop_01", cf, ( 7774, -43462, 1645.65 ), ( 0, 3.9, 0 ), "cspf_8_auto14916520072416908387", "cspf_8_auto3506096206900994066", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_roadside_assistance_cs";
    s.loop_route = "1";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.var_df8f7b8318d59fe5 = "1";
    s.start_point = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_chop_shop_01", cf, ( 7802, -43140, 1709.8 ), ( 0, 359.34, 0 ), "cspf_8_auto6765928612504745703", "cspf_8_auto14916520072416908387", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_roadside_assistance_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.var_df8f7b8318d59fe5 = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_chop_shop_01", cf, ( 7376, -43654, 1564.42 ), ( 0, 178.01, 0 ), "cspf_8_auto3506096206900994066", "cspf_8_auto8524075815580069845", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_roadside_assistance_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.var_df8f7b8318d59fe5 = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_chop_shop_01", cf, ( 7162, -43128, 1671.17 ), ( 0, 179.13, 0 ), "cspf_8_auto8524075815580069845", "cspf_8_auto6765928612504745703", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_roadside_assistance_cs";
    s.ai_interaction = "idle_wreck_crouch_investigate";
    s.var_9a1a6bc9877cfff7 = "-1";
    s.repeat_interaction = "0";
    s.script_delay = "0";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_chop_shop_01", cf, ( 7514, -43214, 1687.75 ), ( 0, 288.58, 0 ), "ROADSIDE_ASSISTANCE_chop_shop_01_repair_1", undefined, "info_act", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_roadside_assistance_cs";
    s.ai_interaction = "idle_wreck_crouch_investigate";
    s.var_9a1a6bc9877cfff7 = "-1";
    s.repeat_interaction = "0";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_chop_shop_01", cf, ( 7378, -43344, 1642.68 ), ( 0, 33.57, 0 ), "ROADSIDE_ASSISTANCE_chop_shop_01_repair_3", undefined, "info_act", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_roadside_assistance_cs";
    s.ai_interaction = "idle_wreck_investigate";
    s.var_9a1a6bc9877cfff7 = "-1";
    s.repeat_interaction = "0";
    s.script_delay = "0";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_chop_shop_01", cf, ( 7672, -43296, 1683.83 ), ( 0, 168.57, 0 ), "ROADSIDE_ASSISTANCE_chop_shop_01_repair_2", undefined, "info_act", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_roadside_assistance_cs";
    s.info_act_ref = "ROADSIDE_ASSISTANCE_antenna_north_01_repair_2";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "ROADSIDE_ASSISTANCE_antenna_north_01_stealthgroup";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_antenna_north_01", cf, ( 15498.5, -27216.7, 2672.73 ), ( 359.9, 201.59, 0.94 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_roadside_assistance_cs";
    s._size_max = ( 878, 618, 482 );
    s._size_min = ( 444, 460, 380 );
    s.var_5afd49978f924648 = "1";
    s.var_a8568d8e0b0b6076 = "0";
    s.var_3f3960eb7318312d = "1";
    s.default_goal_radius = "-1";
    s.height = 128;
    s.length = "128";
    s.name = "encounter_volume";
    s.script_stealthgroup = "ROADSIDE_ASSISTANCE_antenna_north_01_stealthgroup";
    s.script_string = "enc_roadside_assistance_guards";
    s.var_95e2cee7aca5aaae = "1";
    s.width = "128";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_antenna_north_01", cf, ( 15784, -27071.6, 2533.75 ), ( 0.42, 264.25, 0.32 ), "ROADSIDE_ASSISTANCE_antenna_north_01_enc_vol", undefined, "noent_volume_ai_encounter_cs", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_roadside_assistance_cs";
    s.activity_bundle = "sat_ob_activitydef_roadside_assistance";
    s.name = "ROADSIDE_ASSISTANCE_antenna_north_01";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_antenna_north_01", cf, ( 15893.6, -27223.2, 2552.18 ), ( 359.44, 264.25, 1.18 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_roadside_assistance_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "ROADSIDE_ASSISTANCE_antenna_north_01_stealthgroup";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_antenna_north_01", cf, ( 15623.8, -26765.9, 2557.5 ), ( 0.07, 66.6, -1.35 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_roadside_assistance_cs";
    s.info_act_ref = "ROADSIDE_ASSISTANCE_antenna_north_01_repair_1";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "ROADSIDE_ASSISTANCE_antenna_north_01_stealthgroup";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_antenna_north_01", cf, ( 15833.4, -27271, 2556.41 ), ( 359.4, 336.6, -0.73 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_roadside_assistance_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "ROADSIDE_ASSISTANCE_antenna_north_01_stealthgroup";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_antenna_north_01", cf, ( 15972.9, -26744.4, 2465.77 ), ( 0.79, 79.61, 0.12 ), undefined, "cspf_9_auto6765928612504745703", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_roadside_assistance_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "7";
    s.min_wait_time = "5";
    s.move_speed = "1";
    s.var_df8f7b8318d59fe5 = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_antenna_north_01", cf, ( 15934.8, -27116.9, 2543.8 ), ( 0.37, 272.67, 0.38 ), "cspf_9_auto14916520072416908387", "cspf_9_auto3506096206900994066", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_roadside_assistance_cs";
    s.loop_route = "1";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "7";
    s.move_speed = "1";
    s.var_df8f7b8318d59fe5 = "1";
    s.start_point = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_antenna_north_01", cf, ( 15968.4, -26746.9, 2466.83 ), ( 359.6, 88.1, -0.35 ), "cspf_9_auto6765928612504745703", "cspf_9_auto14916520072416908387", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_roadside_assistance_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "7";
    s.min_wait_time = "5";
    s.move_speed = "1";
    s.var_df8f7b8318d59fe5 = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_antenna_north_01", cf, ( 15731.6, -27315.6, 2574.61 ), ( 0.41, 266.78, 0.34 ), "cspf_9_auto3506096206900994066", "cspf_9_auto8524075815580069845", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_roadside_assistance_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "0";
    s.min_wait_time = "0";
    s.move_speed = "1";
    s.var_df8f7b8318d59fe5 = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_antenna_north_01", cf, ( 15777.5, -26976.5, 2526.26 ), ( 359.6, 87.89, -0.34 ), "cspf_9_auto8524075815580069845", "cspf_9_auto6765928612504745703", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_roadside_assistance_cs";
    s.ai_interaction = "idle_wreck_crouch_investigate";
    s.var_9a1a6bc9877cfff7 = "-1";
    s.repeat_interaction = "0";
    s.script_delay = "0";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_antenna_north_01", cf, ( 15851.2, -27278.6, 2556.99 ), ( 359.83, 335.76, 0.5 ), "ROADSIDE_ASSISTANCE_antenna_north_01_repair_1", undefined, "info_act", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_roadside_assistance_cs";
    s.ai_interaction = "idle_wreck_investigate";
    s.var_9a1a6bc9877cfff7 = "-1";
    s.repeat_interaction = "0";
    s.script_delay = "0";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_antenna_north_01", cf, ( 15477.4, -27231.2, 2672 ), ( 0.53, 234.24, 0.06 ), "ROADSIDE_ASSISTANCE_antenna_north_01_repair_2", undefined, "info_act", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace mp_sat_avalon_q4_ob_activity_roadside_assistance_cs
// Params 0, eflags: 0x4
// Checksum 0xc83301d8, Offset: 0x6d09
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace mp_sat_avalon_q4_ob_activity_roadside_assistance_cs
// Params 0
// Checksum 0x7755b481, Offset: 0x6d13
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "mp_sat_avalon_q4_ob_activity_roadside_assistance_cs" );
}

// Namespace mp_sat_avalon_q4_ob_activity_roadside_assistance_cs
// Params 0
// Checksum 0x3dcfd366, Offset: 0x6d29
// Size: 0x66
function function_4cd78e661617f3()
{
    activityinfostruct = {};
    activityinfostruct.name = "REV_OB_ROADSIDE_ASSISTANCE";
    activityinfostruct.scriptbundle = "sat_ob_activitydef_roadside_assistance";
    activityinfostruct.mainfunction = &main;
    activityinfostruct.var_934f068483ae4ddb = &function_d4323822d7042e5a;
    activityinfostruct.metadatafunction = &function_d9dd7965c51c95d1;
    return activityinfostruct;
}

// Namespace mp_sat_avalon_q4_ob_activity_roadside_assistance_cs
// Params 4
// Checksum 0x1d2b6f97, Offset: 0x6d98
// Size: 0x127
function function_d4323822d7042e5a( var_4312b79c960726b6, fe, us, cf = "mp_sat_avalon_q4_ob_activity_roadside_assistance_cs" )
{
    switch ( var_4312b79c960726b6 )
    {
        case #"hash_6665b29905c0d80":
            function_63e7eb2901d2ced8( fe, us, cf );
            break;
        case #"hash_1ffd14be63a3ed1a":
            function_a7d7109aa4972ce2( fe, us, cf );
            break;
        case #"hash_6df5e0d8501176c8":
            function_637a361a2b687740( fe, us, cf );
            break;
        case #"hash_ef12ee3e72defb69":
            function_8e6ac90fb9e50a81( fe, us, cf );
            break;
        case #"hash_54566007c96d9949":
            function_c02b987c2e74ab1( fe, us, cf );
            break;
        case #"hash_c5fd83f5c9b7f46d":
            function_adcf009fb929a985( fe, us, cf );
            break;
        case #"hash_9237cce54feaf4bd":
            function_58e2fd359c25e575( fe, us, cf );
            break;
        case #"hash_e1b810d10677b403":
            function_f984f7b6ca53f35b( fe, us, cf );
            break;
        case #"hash_c41cfaa7cb0a1c7d":
            function_fedcb9253fb91815( fe, us, cf );
            break;
    }
}

// Namespace mp_sat_avalon_q4_ob_activity_roadside_assistance_cs
// Params 3
// Checksum 0x39f4e42b, Offset: 0x6ec7
// Size: 0x187
function function_63e7eb2901d2ced8( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_roadside_assistance_cs";
    s.name = "teleport_location";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_warehouses_01", cf, ( 28472, -6525, 217 ), ( 0, 174.59, 0 ), "`", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_roadside_assistance_cs";
    s.name = "cargo";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_warehouses_01", cf, ( 29211, -7141, 173 ), ( 0, 247.89, 0 ), "ROADSIDE_ASSISTANCE_warehouses_01_cargo", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_roadside_assistance_cs";
    s.name = "vehicle";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_warehouses_01", cf, ( 29164, -7261, 180 ), ( 356.93, 248.95, 3.91 ), "ROADSIDE_ASSISTANCE_warehouses_01_vehicle", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_sat_avalon_q4_ob_activity_roadside_assistance_cs
// Params 3
// Checksum 0x662f2839, Offset: 0x7056
// Size: 0x187
function function_a7d7109aa4972ce2( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_roadside_assistance_cs";
    s.name = "teleport_location";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_lowtown_east_01", cf, ( 15738, -22, 1807.98 ), ( 0, 84.59, 0 ), "`", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_roadside_assistance_cs";
    s.name = "cargo";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_lowtown_east_01", cf, ( 15196, -716, 1802 ), ( 0, 222.59, 0 ), "ROADSIDE_ASSISTANCE_lowtown_east_01_cargo", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_roadside_assistance_cs";
    s.name = "vehicle";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_lowtown_east_01", cf, ( 15102, -806, 1776.6 ), ( 9.72, 224.91, 12.82 ), "ROADSIDE_ASSISTANCE_lowtown_east_01_vehicle", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_sat_avalon_q4_ob_activity_roadside_assistance_cs
// Params 3
// Checksum 0x8de29002, Offset: 0x71e5
// Size: 0x187
function function_637a361a2b687740( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_roadside_assistance_cs";
    s.name = "teleport_location";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_water_treatment_01", cf, ( 45437, -5502, 484 ), ( 0.05, 173.19, 0.07 ), "`", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_roadside_assistance_cs";
    s.name = "cargo";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_water_treatment_01", cf, ( 45671, -7002, 281 ), ( 0.01, 201.19, 0.09 ), "ROADSIDE_ASSISTANCE_water_treatment_01_cargo", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_roadside_assistance_cs";
    s.name = "vehicle";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_water_treatment_01", cf, ( 45548, -7042, 288 ), ( 356.47, 202.13, 0.37 ), "ROADSIDE_ASSISTANCE_water_treatment_01_vehicle", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_sat_avalon_q4_ob_activity_roadside_assistance_cs
// Params 3
// Checksum 0x1c3bafc2, Offset: 0x7374
// Size: 0x187
function function_8e6ac90fb9e50a81( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_roadside_assistance_cs";
    s.name = "teleport_location";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_heliport_west_01", cf, ( 16632, -16060, 1885.5 ), ( 0, 174.59, 0 ), "`", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_roadside_assistance_cs";
    s.name = "cargo";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_heliport_west_01", cf, ( 17223.6, -16805.1, 1438.75 ), ( 359.02, 197.65, 0.86 ), "ROADSIDE_ASSISTANCE_heliport_west_01_cargo", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_roadside_assistance_cs";
    s.name = "vehicle";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_heliport_west_01", cf, ( 17099, -16833, 1462.85 ), ( 349.21, 195.42, -10.23 ), "ROADSIDE_ASSISTANCE_heliport_west_01_vehicle", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_sat_avalon_q4_ob_activity_roadside_assistance_cs
// Params 3
// Checksum 0x59f3c7e9, Offset: 0x7503
// Size: 0x187
function function_c02b987c2e74ab1( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_roadside_assistance_cs";
    s.name = "teleport_location";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_truckstop_01", cf, ( 39938, -19782, 108 ), ( 0, 174.59, 0 ), "`", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_roadside_assistance_cs";
    s.name = "cargo";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_truckstop_01", cf, ( 40580, -22270, 246 ), ( 0.62, 90, 0.13 ), "ROADSIDE_ASSISTANCE_truckstop_01_cargo", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_roadside_assistance_cs";
    s.name = "vehicle";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_truckstop_01", cf, ( 40508, -22150, 213 ), ( 14.7, 145.36, -16.14 ), "ROADSIDE_ASSISTANCE_truckstop_01_vehicle", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_sat_avalon_q4_ob_activity_roadside_assistance_cs
// Params 3
// Checksum 0x358280b4, Offset: 0x7692
// Size: 0x187
function function_adcf009fb929a985( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_roadside_assistance_cs";
    s.name = "teleport_location";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_car_factory_01", cf, ( 44032, -40502, 1525.05 ), ( 0, 174.59, 0 ), "`", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_roadside_assistance_cs";
    s.name = "cargo";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_car_factory_01", cf, ( 44158, -39708, 1588.04 ), ( 0, 7.24, 0 ), "ROADSIDE_ASSISTANCE_car_factory_01_cargo", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_roadside_assistance_cs";
    s.name = "vehicle";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_car_factory_01", cf, ( 44142, -39570, 1576 ), ( 3.14, 98.61, -14.1 ), "ROADSIDE_ASSISTANCE_car_factory_01_vehicle", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_sat_avalon_q4_ob_activity_roadside_assistance_cs
// Params 3
// Checksum 0x4b525181, Offset: 0x7821
// Size: 0x187
function function_58e2fd359c25e575( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_roadside_assistance_cs";
    s.name = "teleport_location";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_epic_bridge_01", cf, ( 22146, -39790, 1450 ), ( 0, 174.59, 0 ), "`", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_roadside_assistance_cs";
    s.name = "cargo";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_epic_bridge_01", cf, ( 24021, -40611, 1448 ), ( 0, 278.58, 0 ), "ROADSIDE_ASSISTANCE_epic_bridge_01_cargo", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_roadside_assistance_cs";
    s.name = "vehicle";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_epic_bridge_01", cf, ( 24156, -40566, 1444 ), ( 0.94, 9.54, 0.34 ), "ROADSIDE_ASSISTANCE_epic_bridge_01_vehicle", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_sat_avalon_q4_ob_activity_roadside_assistance_cs
// Params 3
// Checksum 0x3562cccf, Offset: 0x79b0
// Size: 0x187
function function_f984f7b6ca53f35b( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_roadside_assistance_cs";
    s.name = "teleport_location";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_chop_shop_01", cf, ( 5742, -42888, 1574 ), ( 0, 174.59, 0 ), "`", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_roadside_assistance_cs";
    s.name = "cargo";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_chop_shop_01", cf, ( 7634, -43252, 1686.53 ), ( 0, 198.59, 0 ), "ROADSIDE_ASSISTANCE_chop_shop_01_cargo", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_roadside_assistance_cs";
    s.name = "vehicle";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_chop_shop_01", cf, ( 7512, -43292, 1668.16 ), ( 6.25, 198.58, -14.13 ), "ROADSIDE_ASSISTANCE_chop_shop_01_vehicle", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_sat_avalon_q4_ob_activity_roadside_assistance_cs
// Params 3
// Checksum 0xc25fed3e, Offset: 0x7b3f
// Size: 0x187
function function_fedcb9253fb91815( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_roadside_assistance_cs";
    s.name = "teleport_location";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_antenna_north_01", cf, ( 15853.8, -26715.7, 2464.28 ), ( 0.39, 269, 0.35 ), "`", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_roadside_assistance_cs";
    s.name = "cargo";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_antenna_north_01", cf, ( 15891.3, -27396, 2564.09 ), ( 359.98, 73.38, -5.07 ), "ROADSIDE_ASSISTANCE_antenna_north_01_cargo", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_roadside_assistance_cs";
    s.name = "vehicle";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_antenna_north_01", cf, ( 15946.3, -27264.7, 2561.07 ), ( 349.92, 69.45, -9.84 ), "ROADSIDE_ASSISTANCE_antenna_north_01_vehicle", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_sat_avalon_q4_ob_activity_roadside_assistance_cs
// Params 0
// Checksum 0x4bf124d7, Offset: 0x7cce
// Size: 0x556
function function_d9dd7965c51c95d1()
{
    activityinstances = [];
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_ob_activitydef_roadside_assistance";
    var_881289d7987bc770.cf = "mp_sat_avalon_q4_ob_activity_roadside_assistance_cs";
    var_881289d7987bc770.scriptstructorigin = ( 29164, -7262, 177 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [];
    var_881289d7987bc770.var_31ce4477e3543d24 = [];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [];
    var_881289d7987bc770.locationradius = [];
    activityinstances[ "ROADSIDE_ASSISTANCE_warehouses_01" ] = var_881289d7987bc770;
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_ob_activitydef_roadside_assistance";
    var_881289d7987bc770.cf = "mp_sat_avalon_q4_ob_activity_roadside_assistance_cs";
    var_881289d7987bc770.scriptstructorigin = ( 15102, -806, 1778 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [];
    var_881289d7987bc770.var_31ce4477e3543d24 = [];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [];
    var_881289d7987bc770.locationradius = [];
    activityinstances[ "ROADSIDE_ASSISTANCE_lowtown_east_01" ] = var_881289d7987bc770;
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_ob_activitydef_roadside_assistance";
    var_881289d7987bc770.cf = "mp_sat_avalon_q4_ob_activity_roadside_assistance_cs";
    var_881289d7987bc770.scriptstructorigin = ( 45548, -7042, 288 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [];
    var_881289d7987bc770.var_31ce4477e3543d24 = [];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [];
    var_881289d7987bc770.locationradius = [];
    activityinstances[ "ROADSIDE_ASSISTANCE_water_treatment_01" ] = var_881289d7987bc770;
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_ob_activitydef_roadside_assistance";
    var_881289d7987bc770.cf = "mp_sat_avalon_q4_ob_activity_roadside_assistance_cs";
    var_881289d7987bc770.scriptstructorigin = ( 17102, -16844.4, 1459.88 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [];
    var_881289d7987bc770.var_31ce4477e3543d24 = [];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [];
    var_881289d7987bc770.locationradius = [];
    activityinstances[ "ROADSIDE_ASSISTANCE_heliport_west_01" ] = var_881289d7987bc770;
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_ob_activitydef_roadside_assistance";
    var_881289d7987bc770.cf = "mp_sat_avalon_q4_ob_activity_roadside_assistance_cs";
    var_881289d7987bc770.scriptstructorigin = ( 40508, -22150, 191 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [];
    var_881289d7987bc770.var_31ce4477e3543d24 = [];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [];
    var_881289d7987bc770.locationradius = [];
    activityinstances[ "ROADSIDE_ASSISTANCE_truckstop_01" ] = var_881289d7987bc770;
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_ob_activitydef_roadside_assistance";
    var_881289d7987bc770.cf = "mp_sat_avalon_q4_ob_activity_roadside_assistance_cs";
    var_881289d7987bc770.scriptstructorigin = ( 44142, -39570, 1577.4 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [];
    var_881289d7987bc770.var_31ce4477e3543d24 = [];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [];
    var_881289d7987bc770.locationradius = [];
    activityinstances[ "ROADSIDE_ASSISTANCE_car_factory_01" ] = var_881289d7987bc770;
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_ob_activitydef_roadside_assistance";
    var_881289d7987bc770.cf = "mp_sat_avalon_q4_ob_activity_roadside_assistance_cs";
    var_881289d7987bc770.scriptstructorigin = ( 24156, -40566, 1444 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [];
    var_881289d7987bc770.var_31ce4477e3543d24 = [];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [];
    var_881289d7987bc770.locationradius = [];
    activityinstances[ "ROADSIDE_ASSISTANCE_epic_bridge_01" ] = var_881289d7987bc770;
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_ob_activitydef_roadside_assistance";
    var_881289d7987bc770.cf = "mp_sat_avalon_q4_ob_activity_roadside_assistance_cs";
    var_881289d7987bc770.scriptstructorigin = ( 7512, -43292, 1676.16 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [];
    var_881289d7987bc770.var_31ce4477e3543d24 = [];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [];
    var_881289d7987bc770.locationradius = [];
    activityinstances[ "ROADSIDE_ASSISTANCE_chop_shop_01" ] = var_881289d7987bc770;
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_ob_activitydef_roadside_assistance";
    var_881289d7987bc770.cf = "mp_sat_avalon_q4_ob_activity_roadside_assistance_cs";
    var_881289d7987bc770.scriptstructorigin = ( 15893.6, -27223.2, 2552.18 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [];
    var_881289d7987bc770.var_31ce4477e3543d24 = [];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [];
    var_881289d7987bc770.locationradius = [];
    activityinstances[ "ROADSIDE_ASSISTANCE_antenna_north_01" ] = var_881289d7987bc770;
    return activityinstances;
}

