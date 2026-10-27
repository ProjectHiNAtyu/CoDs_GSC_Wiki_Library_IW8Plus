// script_18eb2c8b938e9035  (hash_18eb2c8b938e9035.gscc) (size: 24330 Bytes / 0x5f0a / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x68c574e7 (1757770983)
// size ...... 24330 (0x5f0a)
// includes .. 4   (offset: 0x51d2)
// strings ... 81  (offset: 0x51f2)
// dev strs .. 0   (offset: 0x5f0a)
// exports ... 17  (offset: 0x4bea)
// cseg ...... 0xbf7 + 0x3ff3 (0x4bea)
// imports ... 29  (offset: 0x4e92)
// animtree1 . 0   (offset: 0x5f0a)
// animtree2 . 0   (offset: 0x5f0a)
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace mp_sat_avalon_quad_03_ob_activity_roadside_assistance_cs;

// Namespace mp_sat_avalon_quad_03_ob_activity_roadside_assistance_cs
// Params 0, eflags: 0x5
// Checksum 0xab2c7d9, Offset: 0xc15
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"mp_sat_avalon_quad_03_ob_activity_roadside_assistance_cs", #"activity_common", &function_b39ecd3d51489472, undefined );
}

// Namespace mp_sat_avalon_quad_03_ob_activity_roadside_assistance_cs
// Params 0, eflags: 0x4
// Checksum 0xbde6cf2b, Offset: 0xc3e
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace mp_sat_avalon_quad_03_ob_activity_roadside_assistance_cs
// Params 0, eflags: 0x4
// Checksum 0xb32db7fa, Offset: 0xc4f
// Size: 0x15
function private structs_init()
{
    main();
    activity_common::function_e1df676808c1d1e3( &function_4cd78e661617f3 );
}

// Namespace mp_sat_avalon_quad_03_ob_activity_roadside_assistance_cs
// Params 2
// Checksum 0xb339314f, Offset: 0xc6c
// Size: 0x70
function main( unused, unused2 )
{
    if ( utility::flag_exist( "mp_sat_avalon_quad_03_ob_activity_roadside_assistance_cs" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "mp_sat_avalon_quad_03_ob_activity_roadside_assistance_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "mp_sat_avalon_quad_03_ob_activity_roadside_assistance_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace mp_sat_avalon_quad_03_ob_activity_roadside_assistance_cs
// Params 3, eflags: 0x4
// Checksum 0xbb5fa808, Offset: 0xce4
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "mp_sat_avalon_quad_03_ob_activity_roadside_assistance_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "mp_sat_avalon_quad_03_ob_activity_roadside_assistance_cs" );
}

// Namespace mp_sat_avalon_quad_03_ob_activity_roadside_assistance_cs
// Params 3, eflags: 0x4
// Checksum 0x4180bf93, Offset: 0xd5e
// Size: 0x3260
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_roadside_assistance_cs";
    s.info_act_ref = "ROADSIDE_ASSISTANCE_training_grounds_north_01_repair_3";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_training_grounds_north_01", cf, ( -21560, -13208, 760 ), ( 0, 214, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_roadside_assistance_cs";
    s._size_max = ( 400, 400, 200 );
    s._size_min = ( 400, 400, 200 );
    s.var_5afd49978f924648 = "1";
    s.var_a8568d8e0b0b6076 = "0";
    s.var_3f3960eb7318312d = "1";
    s.default_goal_radius = "-1";
    s.height = 128;
    s.is_ambient = "0";
    s.length = "128";
    s.name = "encounter_volume";
    s.script_stealthgroup = "-1";
    s.script_string = "enc_roadside_assistance_guards";
    s.var_95e2cee7aca5aaae = "1";
    s.width = "128";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_training_grounds_north_01", cf, ( -21790, -13312, 762 ), ( 0, 94.59, 0 ), "ROADSIDE_ASSISTANCE_training_grounds_north_01_enc_vol", undefined, "noent_volume_ai_encounter_cs", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_roadside_assistance_cs";
    s.activity_bundle = "sat_ob_activitydef_roadside_assistance";
    s.name = "ROADSIDE_ASSISTANCE_training_grounds_north_01";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_training_grounds_north_01", cf, ( -21790, -13312, 762 ), ( 0, 94.59, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_roadside_assistance_cs";
    s.info_act_ref = "ROADSIDE_ASSISTANCE_training_grounds_north_01_repair_2";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_training_grounds_north_01", cf, ( -21604, -13600, 722 ), ( 0, 259, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_roadside_assistance_cs";
    s.info_act_ref = "ROADSIDE_ASSISTANCE_training_grounds_north_01_repair_1";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_training_grounds_north_01", cf, ( -21918, -13036, 770 ), ( 0, 124, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_roadside_assistance_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_training_grounds_north_01", cf, ( -21898, -13678, 772 ), ( 0, 79, 0 ), undefined, "cspf_1_auto6765928612504745703", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_roadside_assistance_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.var_df8f7b8318d59fe5 = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_training_grounds_north_01", cf, ( -22088, -13116, 790 ), ( 0, 211.9, 0 ), "cspf_1_auto14916520072416908387", "cspf_1_auto3506096206900994066", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_roadside_assistance_cs";
    s.loop_route = "1";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.var_df8f7b8318d59fe5 = "1";
    s.start_point = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_training_grounds_north_01", cf, ( -21890, -13628, 788 ), ( 0, 207.34, 0 ), "cspf_1_auto6765928612504745703", "cspf_1_auto14916520072416908387", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_roadside_assistance_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.var_df8f7b8318d59fe5 = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_training_grounds_north_01", cf, ( -21708, -13002, 770 ), ( 0, 26.01, 0 ), "cspf_1_auto3506096206900994066", "cspf_1_auto8524075815580069845", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_roadside_assistance_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.var_df8f7b8318d59fe5 = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_training_grounds_north_01", cf, ( -21548, -13474, 758 ), ( 0, 27.13, 0 ), "cspf_1_auto8524075815580069845", "cspf_1_auto6765928612504745703", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_roadside_assistance_cs";
    s.ai_interaction = "idle_wreck_crouch_investigate";
    s.var_9a1a6bc9877cfff7 = "-1";
    s.repeat_interaction = "0";
    s.script_delay = "0";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_training_grounds_north_01", cf, ( -21714, -13336, 758 ), ( 0, 184.58, 0 ), "ROADSIDE_ASSISTANCE_training_grounds_north_01_repair_1", undefined, "info_act", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_roadside_assistance_cs";
    s.ai_interaction = "idle_wreck_crouch_investigate";
    s.var_9a1a6bc9877cfff7 = "-1";
    s.repeat_interaction = "0";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_training_grounds_north_01", cf, ( -21810, -13168, 766 ), ( 0, 289.58, 0 ), "ROADSIDE_ASSISTANCE_training_grounds_north_01_repair_3", undefined, "info_act", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_roadside_assistance_cs";
    s.ai_interaction = "idle_wreck_investigate";
    s.var_9a1a6bc9877cfff7 = "-1";
    s.repeat_interaction = "0";
    s.script_delay = "0";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_training_grounds_north_01", cf, ( -21834, -13468, 770 ), ( 0, 64.58, 0 ), "ROADSIDE_ASSISTANCE_training_grounds_north_01_repair_2", undefined, "info_act", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_roadside_assistance_cs";
    s.info_act_ref = "ROADSIDE_ASSISTANCE_training_grounds_west_01_repair_3";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_training_grounds_west_01", cf, ( -36346, -22660, 46.52 ), ( 0, 346, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_roadside_assistance_cs";
    s._size_max = ( 400, 400, 200 );
    s._size_min = ( 400, 400, 200 );
    s.var_5afd49978f924648 = "1";
    s.var_a8568d8e0b0b6076 = "0";
    s.var_3f3960eb7318312d = "1";
    s.default_goal_radius = "-1";
    s.height = 128;
    s.is_ambient = "0";
    s.length = "128";
    s.name = "encounter_volume";
    s.script_stealthgroup = "-1";
    s.script_string = "enc_roadside_assistance_guards";
    s.var_95e2cee7aca5aaae = "1";
    s.width = "128";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_training_grounds_west_01", cf, ( -36338, -22850, 47.89 ), ( 0, 226.59, 0 ), "ROADSIDE_ASSISTANCE_training_grounds_west_01_enc_vol", undefined, "noent_volume_ai_encounter_cs", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_roadside_assistance_cs";
    s.activity_bundle = "sat_ob_activitydef_roadside_assistance";
    s.name = "ROADSIDE_ASSISTANCE_training_grounds_west_01";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_training_grounds_west_01", cf, ( -36338, -22850, 47.89 ), ( 0, 226.59, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_roadside_assistance_cs";
    s.info_act_ref = "ROADSIDE_ASSISTANCE_training_grounds_west_01_repair_2";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_training_grounds_west_01", cf, ( -36670, -22864, 11.95 ), ( 0, 31, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_roadside_assistance_cs";
    s.info_act_ref = "ROADSIDE_ASSISTANCE_training_grounds_west_01_repair_1";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_training_grounds_west_01", cf, ( -36200, -23138, 89.94 ), ( 0, 256, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_roadside_assistance_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_training_grounds_west_01", cf, ( -35998, -22676, 88 ), ( 0, 211, 0 ), undefined, "cspf_2_auto6765928612504745703", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_roadside_assistance_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.var_df8f7b8318d59fe5 = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_training_grounds_west_01", cf, ( -36290, -23194, 66 ), ( 0, 343.9, 0 ), "cspf_2_auto14916520072416908387", "cspf_2_auto3506096206900994066", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_roadside_assistance_cs";
    s.loop_route = "1";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.var_df8f7b8318d59fe5 = "1";
    s.start_point = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_training_grounds_west_01", cf, ( -36042, -22704, 84 ), ( 0, 339.34, 0 ), "cspf_2_auto6765928612504745703", "cspf_2_auto14916520072416908387", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_roadside_assistance_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.var_df8f7b8318d59fe5 = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_training_grounds_west_01", cf, ( -36628, -22988, 18 ), ( 0, 158.01, 0 ), "cspf_2_auto3506096206900994066", "cspf_2_auto8524075815580069845", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_roadside_assistance_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.var_df8f7b8318d59fe5 = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_training_grounds_west_01", cf, ( -36384, -22554, 46 ), ( 0, 159.13, 0 ), "cspf_2_auto8524075815580069845", "cspf_2_auto6765928612504745703", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_roadside_assistance_cs";
    s.ai_interaction = "idle_wreck_crouch_investigate";
    s.var_9a1a6bc9877cfff7 = "-1";
    s.repeat_interaction = "0";
    s.script_delay = "0";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_training_grounds_west_01", cf, ( -36372, -22776, 40.35 ), ( 0, 316.58, 0 ), "ROADSIDE_ASSISTANCE_training_grounds_west_01_repair_1", undefined, "info_act", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_roadside_assistance_cs";
    s.ai_interaction = "idle_wreck_crouch_investigate";
    s.var_9a1a6bc9877cfff7 = "-1";
    s.repeat_interaction = "0";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_training_grounds_west_01", cf, ( -36432, -22960, 35.71 ), ( 0, 61.58, 0 ), "ROADSIDE_ASSISTANCE_training_grounds_west_01_repair_3", undefined, "info_act", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_roadside_assistance_cs";
    s.ai_interaction = "idle_wreck_investigate";
    s.var_9a1a6bc9877cfff7 = "-1";
    s.repeat_interaction = "0";
    s.script_delay = "0";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_training_grounds_west_01", cf, ( -36194, -22778, 64.58 ), ( 0, 196.57, 0 ), "ROADSIDE_ASSISTANCE_training_grounds_west_01_repair_2", undefined, "info_act", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_roadside_assistance_cs";
    s.info_act_ref = "ROADSIDE_ASSISTANCE_listening_post_north_01_repair_3";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_listening_post_north_01", cf, ( -15280, -40736, 286 ), ( 0, 45, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_roadside_assistance_cs";
    s._size_max = ( 400, 400, 200 );
    s._size_min = ( 400, 400, 200 );
    s.var_5afd49978f924648 = "1";
    s.var_a8568d8e0b0b6076 = "0";
    s.var_3f3960eb7318312d = "1";
    s.default_goal_radius = "-1";
    s.height = 128;
    s.is_ambient = "0";
    s.length = "128";
    s.name = "encounter_volume";
    s.script_stealthgroup = "-1";
    s.script_string = "enc_roadside_assistance_guards";
    s.var_95e2cee7aca5aaae = "1";
    s.width = "128";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_listening_post_north_01", cf, ( -14954, -40702, 284.24 ), ( 0, 166.59, 0 ), "ROADSIDE_ASSISTANCE_listening_post_north_01_enc_vol", undefined, "noent_volume_ai_encounter_cs", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_roadside_assistance_cs";
    s.activity_bundle = "sat_ob_activitydef_roadside_assistance";
    s.name = "ROADSIDE_ASSISTANCE_listening_post_north_01";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_listening_post_north_01", cf, ( -14954, -40702, 284.24 ), ( 0, 100.59, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_roadside_assistance_cs";
    s.info_act_ref = "ROADSIDE_ASSISTANCE_listening_post_north_01_repair_2";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_listening_post_north_01", cf, ( -14836, -40612, 280 ), ( 0, 360, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_roadside_assistance_cs";
    s.info_act_ref = "ROADSIDE_ASSISTANCE_listening_post_north_01_repair_1";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_listening_post_north_01", cf, ( -15056, -40654, 280 ), ( 0, 90, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_roadside_assistance_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_listening_post_north_01", cf, ( -14756, -41020, 292 ), ( 0, 90, 0 ), undefined, "cspf_3_auto6765928612504745703", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_roadside_assistance_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.var_df8f7b8318d59fe5 = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_listening_post_north_01", cf, ( -15244, -40836, 296.7 ), ( 0, 283.91, 0 ), "cspf_3_auto14916520072416908387", "cspf_3_auto3506096206900994066", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_roadside_assistance_cs";
    s.loop_route = "1";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.var_df8f7b8318d59fe5 = "1";
    s.start_point = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_listening_post_north_01", cf, ( -14634, -41012, 291.94 ), ( 0, 279.34, 0 ), "cspf_3_auto6765928612504745703", "cspf_3_auto14916520072416908387", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_roadside_assistance_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.var_df8f7b8318d59fe5 = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_listening_post_north_01", cf, ( -15144, -40420, 257.41 ), ( 0, 98.01, 0 ), "cspf_3_auto3506096206900994066", "cspf_3_auto8524075815580069845", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_roadside_assistance_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.var_df8f7b8318d59fe5 = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_listening_post_north_01", cf, ( -14544, -40608, 288.17 ), ( 0, 99.13, 0 ), "cspf_3_auto8524075815580069845", "cspf_3_auto6765928612504745703", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_roadside_assistance_cs";
    s.ai_interaction = "idle_wreck_crouch_investigate";
    s.var_9a1a6bc9877cfff7 = "-1";
    s.repeat_interaction = "0";
    s.script_delay = "0";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_listening_post_north_01", cf, ( -14880, -40722, 289.28 ), ( 0, 190.58, 0 ), "ROADSIDE_ASSISTANCE_listening_post_north_01_repair_1", undefined, "info_act", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_roadside_assistance_cs";
    s.ai_interaction = "idle_wreck_crouch_investigate";
    s.var_9a1a6bc9877cfff7 = "-1";
    s.repeat_interaction = "0";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_listening_post_north_01", cf, ( -15156, -40592, 278 ), ( 0, 1.58, 0 ), "ROADSIDE_ASSISTANCE_listening_post_north_01_repair_3", undefined, "info_act", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_roadside_assistance_cs";
    s.ai_interaction = "idle_wreck_investigate";
    s.var_9a1a6bc9877cfff7 = "-1";
    s.repeat_interaction = "0";
    s.script_delay = "0";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_listening_post_north_01", cf, ( -14982, -40864, 310.3 ), ( 0, 70.58, 0 ), "ROADSIDE_ASSISTANCE_listening_post_north_01_repair_2", undefined, "info_act", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_roadside_assistance_cs";
    s.info_act_ref = "ROADSIDE_ASSISTANCE_flats_west_01_repair_3";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_flats_west_01", cf, ( -3392, -26686, 196 ), ( 0, 48.25, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_roadside_assistance_cs";
    s._size_max = ( 400, 400, 200 );
    s._size_min = ( 400, 400, 200 );
    s.var_5afd49978f924648 = "1";
    s.var_a8568d8e0b0b6076 = "0";
    s.var_3f3960eb7318312d = "1";
    s.default_goal_radius = "-1";
    s.height = 128;
    s.is_ambient = "0";
    s.length = "128";
    s.name = "encounter_volume";
    s.script_stealthgroup = "-1";
    s.script_string = "enc_roadside_assistance_guards";
    s.var_95e2cee7aca5aaae = "1";
    s.width = "128";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_flats_west_01", cf, ( -3154, -26444, 203 ), ( 0, 284.59, 0 ), "ROADSIDE_ASSISTANCE_flats_west_01_enc_vol", undefined, "noent_volume_ai_encounter_cs", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_roadside_assistance_cs";
    s.activity_bundle = "sat_ob_activitydef_roadside_assistance";
    s.name = "ROADSIDE_ASSISTANCE_flats_west_01";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_flats_west_01", cf, ( -3154, -26444, 203 ), ( 0, 284.59, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_roadside_assistance_cs";
    s.info_act_ref = "ROADSIDE_ASSISTANCE_flats_west_01_repair_2";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_flats_west_01", cf, ( -2974, -26494, 192 ), ( 0, 315, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_roadside_assistance_cs";
    s.info_act_ref = "ROADSIDE_ASSISTANCE_flats_west_01_repair_1";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_flats_west_01", cf, ( -3526, -26234, 204 ), ( 0, 360, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_roadside_assistance_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_flats_west_01", cf, ( -3026, -26104, 170 ), ( 0, 224.58, 0 ), undefined, "cspf_4_auto6765928612504745703", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_roadside_assistance_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.var_df8f7b8318d59fe5 = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_flats_west_01", cf, ( -2766, -26516, 165 ), ( 0, 41.91, 0 ), "cspf_4_auto14916520072416908387", "cspf_4_auto3506096206900994066", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_roadside_assistance_cs";
    s.loop_route = "1";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.var_df8f7b8318d59fe5 = "1";
    s.start_point = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_flats_west_01", cf, ( -3066, -26150, 175 ), ( 0, 37.34, 0 ), "cspf_4_auto6765928612504745703", "cspf_4_auto14916520072416908387", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_roadside_assistance_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.var_df8f7b8318d59fe5 = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_flats_west_01", cf, ( -3208, -26804, 193 ), ( 0, 216.01, 0 ), "cspf_4_auto3506096206900994066", "cspf_4_auto8524075815580069845", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_roadside_assistance_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.var_df8f7b8318d59fe5 = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_flats_west_01", cf, ( -3434, -26340, 183 ), ( 0, 217.13, 0 ), "cspf_4_auto8524075815580069845", "cspf_4_auto6765928612504745703", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_roadside_assistance_cs";
    s.ai_interaction = "idle_wreck_crouch_investigate";
    s.var_9a1a6bc9877cfff7 = "-1";
    s.repeat_interaction = "0";
    s.script_delay = "0";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_flats_west_01", cf, ( -3232, -26430, 193 ), ( 0, 14.58, 0 ), "ROADSIDE_ASSISTANCE_flats_west_01_repair_1", undefined, "info_act", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_roadside_assistance_cs";
    s.ai_interaction = "idle_wreck_crouch_investigate";
    s.var_9a1a6bc9877cfff7 = "-1";
    s.repeat_interaction = "0";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_flats_west_01", cf, ( -3110, -26580, 209 ), ( 0, 119.58, 0 ), "ROADSIDE_ASSISTANCE_flats_west_01_repair_3", undefined, "info_act", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_roadside_assistance_cs";
    s.ai_interaction = "idle_wreck_investigate";
    s.var_9a1a6bc9877cfff7 = "-1";
    s.repeat_interaction = "0";
    s.script_delay = "0";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_flats_west_01", cf, ( -3138, -26282, 183 ), ( 0, 254.58, 0 ), "ROADSIDE_ASSISTANCE_flats_west_01_repair_2", undefined, "info_act", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_roadside_assistance_cs";
    s.info_act_ref = "ROADSIDE_ASSISTANCE_BRIDGE_SOUTH_01_repair_3";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_BRIDGE_SOUTH_01", cf, ( -6346.62, -40810.5, 916 ), ( 0, 208.25, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_roadside_assistance_cs";
    s._size_max = ( 400, 400, 200 );
    s._size_min = ( 400, 400, 200 );
    s.var_5afd49978f924648 = "1";
    s.var_a8568d8e0b0b6076 = "0";
    s.var_3f3960eb7318312d = "1";
    s.default_goal_radius = "-1";
    s.height = 128;
    s.is_ambient = "0";
    s.length = "128";
    s.name = "encounter_volume";
    s.script_stealthgroup = "-1";
    s.script_string = "enc_roadside_assistance_guards";
    s.var_95e2cee7aca5aaae = "1";
    s.width = "128";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_BRIDGE_SOUTH_01", cf, ( -6452.74, -40897.9, 916 ), ( 0, 84.59, 0 ), "ROADSIDE_ASSISTANCE_BRIDGE_SOUTH_01_enc_vol", undefined, "noent_volume_ai_encounter_cs", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_roadside_assistance_cs";
    s.activity_bundle = "sat_ob_activitydef_roadside_assistance";
    s.name = "ROADSIDE_ASSISTANCE_BRIDGE_SOUTH_01";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_BRIDGE_SOUTH_01", cf, ( -6452.74, -40897.9, 916 ), ( 0, 84.59, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_roadside_assistance_cs";
    s.info_act_ref = "ROADSIDE_ASSISTANCE_BRIDGE_SOUTH_01_repair_2";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_BRIDGE_SOUTH_01", cf, ( -6493.2, -41060.4, 920 ), ( 0, 18.85, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_roadside_assistance_cs";
    s.info_act_ref = "ROADSIDE_ASSISTANCE_BRIDGE_SOUTH_01_repair_1";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_BRIDGE_SOUTH_01", cf, ( -6386.31, -40960.5, 916 ), ( 0, 174.58, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_roadside_assistance_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_BRIDGE_SOUTH_01", cf, ( -6590.62, -41115.1, 916 ), ( 0, 204.58, 0 ), undefined, "cspf_5_auto6765928612504745703", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_roadside_assistance_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.var_df8f7b8318d59fe5 = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_BRIDGE_SOUTH_01", cf, ( -6791.35, -40696.9, 916 ), ( 0, 201.91, 0 ), "cspf_5_auto14916520072416908387", "cspf_5_auto3506096206900994066", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_roadside_assistance_cs";
    s.loop_route = "1";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.var_df8f7b8318d59fe5 = "1";
    s.start_point = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_BRIDGE_SOUTH_01", cf, ( -6635.7, -41143.1, 920 ), ( 0, 197.34, 0 ), "cspf_5_auto6765928612504745703", "cspf_5_auto14916520072416908387", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_roadside_assistance_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.var_df8f7b8318d59fe5 = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_BRIDGE_SOUTH_01", cf, ( -6361.83, -40571.7, 916 ), ( 0, 16.01, 0 ), "cspf_5_auto3506096206900994066", "cspf_5_auto8524075815580069845", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_roadside_assistance_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.var_df8f7b8318d59fe5 = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_BRIDGE_SOUTH_01", cf, ( -6251.18, -41021.3, 920 ), ( 0, 17.13, 0 ), "cspf_5_auto8524075815580069845", "cspf_5_auto6765928612504745703", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_roadside_assistance_cs";
    s.ai_interaction = "idle_wreck_crouch_investigate";
    s.var_9a1a6bc9877cfff7 = "-1";
    s.repeat_interaction = "0";
    s.script_delay = "0";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_BRIDGE_SOUTH_01", cf, ( -6384.02, -40936.6, 916 ), ( 0, 174.59, 0 ), "ROADSIDE_ASSISTANCE_BRIDGE_SOUTH_01_repair_1", undefined, "info_act", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_roadside_assistance_cs";
    s.ai_interaction = "idle_wreck_crouch_investigate";
    s.var_9a1a6bc9877cfff7 = "-1";
    s.repeat_interaction = "0";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_BRIDGE_SOUTH_01", cf, ( -6447.09, -40753.8, 916 ), ( 0, 279.58, 0 ), "ROADSIDE_ASSISTANCE_BRIDGE_SOUTH_01_repair_3", undefined, "info_act", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_roadside_assistance_cs";
    s.ai_interaction = "idle_wreck_investigate";
    s.var_9a1a6bc9877cfff7 = "-1";
    s.repeat_interaction = "0";
    s.script_delay = "0";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_BRIDGE_SOUTH_01", cf, ( -6522.85, -41043.9, 916 ), ( 0, 54.58, 0 ), "ROADSIDE_ASSISTANCE_BRIDGE_SOUTH_01_repair_2", undefined, "info_act", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace mp_sat_avalon_quad_03_ob_activity_roadside_assistance_cs
// Params 0, eflags: 0x4
// Checksum 0x144055fe, Offset: 0x3fc6
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace mp_sat_avalon_quad_03_ob_activity_roadside_assistance_cs
// Params 0
// Checksum 0x790c7545, Offset: 0x3fd0
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "mp_sat_avalon_quad_03_ob_activity_roadside_assistance_cs" );
}

// Namespace mp_sat_avalon_quad_03_ob_activity_roadside_assistance_cs
// Params 0
// Checksum 0x339612a2, Offset: 0x3fe6
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

// Namespace mp_sat_avalon_quad_03_ob_activity_roadside_assistance_cs
// Params 4
// Checksum 0xd10e0a9, Offset: 0x4055
// Size: 0xbf
function function_d4323822d7042e5a( var_4312b79c960726b6, fe, us, cf = "mp_sat_avalon_quad_03_ob_activity_roadside_assistance_cs" )
{
    switch ( var_4312b79c960726b6 )
    {
        case #"hash_6cc90eb9ec154ebf":
            function_9763b92f0db846e7( fe, us, cf );
            break;
        case #"hash_bfeb63be0f9b8f23":
            function_9a94f1ef60c8962b( fe, us, cf );
            break;
        case #"hash_b83fdea2a793380c":
            function_57442627dee02874( fe, us, cf );
            break;
        case #"hash_ffbb81654f7b4ba2":
            function_3c57dc2cb297d3a( fe, us, cf );
            break;
        case #"hash_c03389bd1b3af411":
            function_f322ba92b9e886c9( fe, us, cf );
            break;
    }
}

// Namespace mp_sat_avalon_quad_03_ob_activity_roadside_assistance_cs
// Params 3
// Checksum 0x104081b9, Offset: 0x411c
// Size: 0x187
function function_9763b92f0db846e7( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_roadside_assistance_cs";
    s.name = "teleport_location";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_training_grounds_north_01", cf, ( -19966, -13502, 424 ), ( 0, 84.59, 0 ), "`", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_roadside_assistance_cs";
    s.name = "cargo";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_training_grounds_north_01", cf, ( -21780, -13444, 764 ), ( 0, 94.59, 0 ), "ROADSIDE_ASSISTANCE_training_grounds_north_01_cargo", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_roadside_assistance_cs";
    s.name = "vehicle";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_training_grounds_north_01", cf, ( -21790, -13312, 762 ), ( 0, 94.59, 0 ), "ROADSIDE_ASSISTANCE_training_grounds_north_01_vehicle", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_sat_avalon_quad_03_ob_activity_roadside_assistance_cs
// Params 3
// Checksum 0x3b521c03, Offset: 0x42ab
// Size: 0x187
function function_9a94f1ef60c8962b( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_roadside_assistance_cs";
    s.name = "teleport_location";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_training_grounds_west_01", cf, ( -35798, -21862, 102 ), ( 0, 84.59, 0 ), "`", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_roadside_assistance_cs";
    s.name = "cargo";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_training_grounds_west_01", cf, ( -36248, -22754, 53.2 ), ( 0, 226.59, 0 ), "ROADSIDE_ASSISTANCE_training_grounds_west_01_cargo", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_roadside_assistance_cs";
    s.name = "vehicle";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_training_grounds_west_01", cf, ( -36338, -22850, 47.89 ), ( 0, 226.59, 0 ), "ROADSIDE_ASSISTANCE_training_grounds_west_01_vehicle", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_sat_avalon_quad_03_ob_activity_roadside_assistance_cs
// Params 3
// Checksum 0x93547801, Offset: 0x443a
// Size: 0x187
function function_57442627dee02874( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_roadside_assistance_cs";
    s.name = "teleport_location";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_listening_post_north_01", cf, ( -13262.3, -42030.6, 191.99 ), ( 0, 84.59, 0 ), "`", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_roadside_assistance_cs";
    s.name = "cargo";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_listening_post_north_01", cf, ( -14932, -40828, 298.52 ), ( 0, 100.59, 0 ), "ROADSIDE_ASSISTANCE_listening_post_north_01_cargo", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_roadside_assistance_cs";
    s.name = "vehicle";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_listening_post_north_01", cf, ( -14954, -40702, 292 ), ( 0, 100.59, 0 ), "ROADSIDE_ASSISTANCE_listening_post_north_01_vehicle", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_sat_avalon_quad_03_ob_activity_roadside_assistance_cs
// Params 3
// Checksum 0x8f7082f8, Offset: 0x45c9
// Size: 0x187
function function_3c57dc2cb297d3a( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_roadside_assistance_cs";
    s.name = "teleport_location";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_flats_west_01", cf, ( -1166.28, -27798.6, 191.99 ), ( 0, 84.59, 0 ), "`", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_roadside_assistance_cs";
    s.name = "cargo";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_flats_west_01", cf, ( -3186, -26320, 185 ), ( 0, 284.59, 0 ), "ROADSIDE_ASSISTANCE_flats_west_01_cargo", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_roadside_assistance_cs";
    s.name = "vehicle";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_flats_west_01", cf, ( -3154, -26444, 209 ), ( 0, 284.59, 0 ), "ROADSIDE_ASSISTANCE_flats_west_01_vehicle", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_sat_avalon_quad_03_ob_activity_roadside_assistance_cs
// Params 3
// Checksum 0xee8cc7b5, Offset: 0x4758
// Size: 0x187
function function_f322ba92b9e886c9( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_roadside_assistance_cs";
    s.name = "teleport_location";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_BRIDGE_SOUTH_01", cf, ( -4606.28, -42358.6, 191.99 ), ( 0, 84.59, 0 ), "`", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_roadside_assistance_cs";
    s.name = "cargo";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_BRIDGE_SOUTH_01", cf, ( -6464.82, -41025.3, 916 ), ( 0, 84.59, 0 ), "ROADSIDE_ASSISTANCE_BRIDGE_SOUTH_01_cargo", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_roadside_assistance_cs";
    s.name = "vehicle";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_BRIDGE_SOUTH_01", cf, ( -6452.74, -40897.9, 916 ), ( 0, 84.59, 0 ), "ROADSIDE_ASSISTANCE_BRIDGE_SOUTH_01_vehicle", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_sat_avalon_quad_03_ob_activity_roadside_assistance_cs
// Params 0
// Checksum 0xb982f85e, Offset: 0x48e7
// Size: 0x302
function function_d9dd7965c51c95d1()
{
    activityinstances = [];
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_ob_activitydef_roadside_assistance";
    var_881289d7987bc770.cf = "mp_sat_avalon_quad_03_ob_activity_roadside_assistance_cs";
    var_881289d7987bc770.scriptstructorigin = ( -21790, -13312, 762 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [];
    var_881289d7987bc770.var_31ce4477e3543d24 = [];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [];
    var_881289d7987bc770.locationradius = [];
    activityinstances[ "ROADSIDE_ASSISTANCE_training_grounds_north_01" ] = var_881289d7987bc770;
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_ob_activitydef_roadside_assistance";
    var_881289d7987bc770.cf = "mp_sat_avalon_quad_03_ob_activity_roadside_assistance_cs";
    var_881289d7987bc770.scriptstructorigin = ( -36338, -22850, 47.89 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [];
    var_881289d7987bc770.var_31ce4477e3543d24 = [];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [];
    var_881289d7987bc770.locationradius = [];
    activityinstances[ "ROADSIDE_ASSISTANCE_training_grounds_west_01" ] = var_881289d7987bc770;
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_ob_activitydef_roadside_assistance";
    var_881289d7987bc770.cf = "mp_sat_avalon_quad_03_ob_activity_roadside_assistance_cs";
    var_881289d7987bc770.scriptstructorigin = ( -14954, -40702, 284.24 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [];
    var_881289d7987bc770.var_31ce4477e3543d24 = [];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [];
    var_881289d7987bc770.locationradius = [];
    activityinstances[ "ROADSIDE_ASSISTANCE_listening_post_north_01" ] = var_881289d7987bc770;
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_ob_activitydef_roadside_assistance";
    var_881289d7987bc770.cf = "mp_sat_avalon_quad_03_ob_activity_roadside_assistance_cs";
    var_881289d7987bc770.scriptstructorigin = ( -3154, -26444, 203 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [];
    var_881289d7987bc770.var_31ce4477e3543d24 = [];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [];
    var_881289d7987bc770.locationradius = [];
    activityinstances[ "ROADSIDE_ASSISTANCE_flats_west_01" ] = var_881289d7987bc770;
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_ob_activitydef_roadside_assistance";
    var_881289d7987bc770.cf = "mp_sat_avalon_quad_03_ob_activity_roadside_assistance_cs";
    var_881289d7987bc770.scriptstructorigin = ( -6452.74, -40897.9, 916 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [];
    var_881289d7987bc770.var_31ce4477e3543d24 = [];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [];
    var_881289d7987bc770.locationradius = [];
    activityinstances[ "ROADSIDE_ASSISTANCE_BRIDGE_SOUTH_01" ] = var_881289d7987bc770;
    return activityinstances;
}

