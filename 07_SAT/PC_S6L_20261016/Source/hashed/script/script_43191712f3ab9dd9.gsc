// script_43191712f3ab9dd9  (hash_43191712f3ab9dd9.gscc) (size: 32688 Bytes / 0x7fb0 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x2c13f376 (739505014)
// size ...... 32688 (0x7fb0)
// includes .. 4   (offset: 0x6db8)
// strings ... 103 (offset: 0x6dd8)
// dev strs .. 0   (offset: 0x7fb0)
// exports ... 19  (offset: 0x6724)
// cseg ...... 0xf14 + 0x5810 (0x6724)
// imports ... 32  (offset: 0x6a1c)
// animtree1 . 0   (offset: 0x7fb0)
// animtree2 . 0   (offset: 0x7fb0)
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace mp_sat_avalon_quad_01_ob_roadside_assistance_cs;

// Namespace mp_sat_avalon_quad_01_ob_roadside_assistance_cs
// Params 0, eflags: 0x5
// Checksum 0xc37bebb2, Offset: 0xf32
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"mp_sat_avalon_quad_01_ob_roadside_assistance_cs", #"activity_common", &function_b39ecd3d51489472, undefined );
}

// Namespace mp_sat_avalon_quad_01_ob_roadside_assistance_cs
// Params 0, eflags: 0x4
// Checksum 0xb10c4cd4, Offset: 0xf5b
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace mp_sat_avalon_quad_01_ob_roadside_assistance_cs
// Params 0, eflags: 0x4
// Checksum 0x34379f38, Offset: 0xf6c
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace mp_sat_avalon_quad_01_ob_roadside_assistance_cs
// Params 2
// Checksum 0xe15e1a1, Offset: 0xf7d
// Size: 0x8c
function main( unused, unused2 )
{
    if ( utility::flag_exist( "mp_sat_avalon_quad_01_ob_roadside_assistance_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "mp_sat_avalon_quad_01_ob_roadside_assistance_cs" ) )
    {
        return;
    }
    
    activity_common::function_e1df676808c1d1e3( &function_4cd78e661617f3 );
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "mp_sat_avalon_quad_01_ob_roadside_assistance_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "mp_sat_avalon_quad_01_ob_roadside_assistance_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace mp_sat_avalon_quad_01_ob_roadside_assistance_cs
// Params 3, eflags: 0x4
// Checksum 0xb7b52bf7, Offset: 0x1011
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "mp_sat_avalon_quad_01_ob_roadside_assistance_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "mp_sat_avalon_quad_01_ob_roadside_assistance_cs" );
}

// Namespace mp_sat_avalon_quad_01_ob_roadside_assistance_cs
// Params 3, eflags: 0x4
// Checksum 0x652dc9d0, Offset: 0x108b
// Size: 0x45f1
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_01_ob_roadside_assistance_cs";
    s.info_act_ref = "ROADSIDE_ASSISTANCE_suburbs_west_01_repair_3";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_suburbs_west_01", cf, ( -20992, 48512, 1272 ), ( 0, 360, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_01_ob_roadside_assistance_cs";
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
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_suburbs_west_01", cf, ( -21312, 48394, 1300 ), ( 0, 358.59, 0 ), "ROADSIDE_ASSISTANCE_suburbs_west_01_enc_vol", undefined, "noent_volume_ai_encounter_cs", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_01_ob_roadside_assistance_cs";
    s.activity_bundle = "sat_ob_activitydef_roadside_assistance";
    s.name = "ROADSIDE_ASSISTANCE_suburbs_west_01";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_suburbs_west_01", cf, ( -21312, 48394, 1300 ), ( 0, 358.59, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_01_ob_roadside_assistance_cs";
    s.info_act_ref = "ROADSIDE_ASSISTANCE_suburbs_west_01_repair_2";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_suburbs_west_01", cf, ( -21504, 48320, 1308 ), ( 0, 270, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_01_ob_roadside_assistance_cs";
    s.info_act_ref = "ROADSIDE_ASSISTANCE_suburbs_west_01_repair_1";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_suburbs_west_01", cf, ( -21538, 48738, 1286 ), ( 0, 225, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_01_ob_roadside_assistance_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_suburbs_west_01", cf, ( -21684, 48140, 1320 ), ( 0, 90, 0 ), undefined, "cspf_1_auto6765928612504745703", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_01_ob_roadside_assistance_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.var_df8f7b8318d59fe5 = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_suburbs_west_01", cf, ( -21692, 48686, 1290 ), ( 0, 163.9, 0 ), "cspf_1_auto14916520072416908387", "cspf_1_auto3506096206900994066", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_01_ob_roadside_assistance_cs";
    s.loop_route = "1";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.var_df8f7b8318d59fe5 = "1";
    s.start_point = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_suburbs_west_01", cf, ( -21672, 48188, 1314 ), ( 0, 159.34, 0 ), "cspf_1_auto6765928612504745703", "cspf_1_auto14916520072416908387", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_01_ob_roadside_assistance_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.var_df8f7b8318d59fe5 = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_suburbs_west_01", cf, ( -21070, 48604, 1276 ), ( 0, 338.01, 0 ), "cspf_1_auto3506096206900994066", "cspf_1_auto8524075815580069845", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_01_ob_roadside_assistance_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.var_df8f7b8318d59fe5 = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_suburbs_west_01", cf, ( -21126, 48130, 1304 ), ( 0, 339.13, 0 ), "cspf_1_auto8524075815580069845", "cspf_1_auto6765928612504745703", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_01_ob_roadside_assistance_cs";
    s.ai_interaction = "idle_wreck_crouch_investigate";
    s.var_9a1a6bc9877cfff7 = "-1";
    s.repeat_interaction = "0";
    s.script_delay = "0";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_suburbs_west_01", cf, ( -21344, 48320, 1302 ), ( 0, 88.58, 0 ), "ROADSIDE_ASSISTANCE_suburbs_west_01_repair_1", undefined, "info_act", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_01_ob_roadside_assistance_cs";
    s.ai_interaction = "idle_wreck_crouch_investigate";
    s.var_9a1a6bc9877cfff7 = "-1";
    s.repeat_interaction = "0";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_suburbs_west_01", cf, ( -21168, 48398, 1292 ), ( 0, 193.58, 0 ), "ROADSIDE_ASSISTANCE_suburbs_west_01_repair_3", undefined, "info_act", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_01_ob_roadside_assistance_cs";
    s.ai_interaction = "idle_wreck_investigate";
    s.var_9a1a6bc9877cfff7 = "-1";
    s.repeat_interaction = "0";
    s.script_delay = "0";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_suburbs_west_01", cf, ( -21462, 48452, 1304 ), ( 0, 328.57, 0 ), "ROADSIDE_ASSISTANCE_suburbs_west_01_repair_2", undefined, "info_act", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_01_ob_roadside_assistance_cs";
    s.info_act_ref = "ROADSIDE_ASSISTANCE_suburbs_south_01_repair_3";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_suburbs_south_01", cf, ( -15972, 37154, 1582 ), ( 0, 360, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_01_ob_roadside_assistance_cs";
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
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_suburbs_south_01", cf, ( -16380, 37170, 1580 ), ( 0, 312.59, 0 ), "ROADSIDE_ASSISTANCE_suburbs_south_01_enc_vol", undefined, "noent_volume_ai_encounter_cs", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_01_ob_roadside_assistance_cs";
    s.activity_bundle = "sat_ob_activitydef_roadside_assistance";
    s.name = "ROADSIDE_ASSISTANCE_suburbs_south_01";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_suburbs_south_01", cf, ( -16380, 37170, 1580 ), ( 0, 312.59, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_01_ob_roadside_assistance_cs";
    s.info_act_ref = "ROADSIDE_ASSISTANCE_suburbs_south_01_repair_2";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_suburbs_south_01", cf, ( -16422, 37028, 1592 ), ( 0, 270, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_01_ob_roadside_assistance_cs";
    s.info_act_ref = "ROADSIDE_ASSISTANCE_suburbs_south_01_repair_1";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_suburbs_south_01", cf, ( -16352, 37648, 1590 ), ( 0, 89, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_01_ob_roadside_assistance_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_suburbs_south_01", cf, ( -16820, 37262, 1594 ), ( 0, 44, 0 ), undefined, "cspf_2_auto6765928612504745703", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_01_ob_roadside_assistance_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.var_df8f7b8318d59fe5 = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_suburbs_south_01", cf, ( -16318, 37558, 1600 ), ( 0, 117.9, 0 ), "cspf_2_auto14916520072416908387", "cspf_2_auto3506096206900994066", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_01_ob_roadside_assistance_cs";
    s.loop_route = "1";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.var_df8f7b8318d59fe5 = "1";
    s.start_point = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_suburbs_south_01", cf, ( -16778, 37286, 1598 ), ( 0, 113.34, 0 ), "cspf_2_auto6765928612504745703", "cspf_2_auto14916520072416908387", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_01_ob_roadside_assistance_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.var_df8f7b8318d59fe5 = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_suburbs_south_01", cf, ( -16060, 37142, 1590 ), ( 0, 292.01, 0 ), "cspf_2_auto3506096206900994066", "cspf_2_auto8524075815580069845", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_01_ob_roadside_assistance_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.var_df8f7b8318d59fe5 = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_suburbs_south_01", cf, ( -16440, 36854, 1584 ), ( 0, 293.13, 0 ), "cspf_2_auto8524075815580069845", "cspf_2_auto6765928612504745703", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_01_ob_roadside_assistance_cs";
    s.ai_interaction = "idle_wreck_crouch_investigate";
    s.var_9a1a6bc9877cfff7 = "-1";
    s.repeat_interaction = "0";
    s.script_delay = "0";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_suburbs_south_01", cf, ( -16454, 37142, 1590 ), ( 0, 42.58, 0 ), "ROADSIDE_ASSISTANCE_suburbs_south_01_repair_1", undefined, "info_act", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_01_ob_roadside_assistance_cs";
    s.ai_interaction = "idle_wreck_crouch_investigate";
    s.var_9a1a6bc9877cfff7 = "-1";
    s.repeat_interaction = "0";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_suburbs_south_01", cf, ( -16276, 37070, 1588 ), ( 0, 147.58, 0 ), "ROADSIDE_ASSISTANCE_suburbs_south_01_repair_3", undefined, "info_act", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_01_ob_roadside_assistance_cs";
    s.ai_interaction = "idle_wreck_investigate";
    s.var_9a1a6bc9877cfff7 = "-1";
    s.repeat_interaction = "0";
    s.script_delay = "0";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_suburbs_south_01", cf, ( -16442, 37318, 1582 ), ( 0, 282.57, 0 ), "ROADSIDE_ASSISTANCE_suburbs_south_01_repair_2", undefined, "info_act", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_01_ob_roadside_assistance_cs";
    s.info_act_ref = "ROADSIDE_ASSISTANCE_casino_east_01_repair_3";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_casino_east_01", cf, ( -5360, 30572, 360 ), ( 0, 160, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_01_ob_roadside_assistance_cs";
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
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_casino_east_01", cf, ( -5074, 30296, 370 ), ( 0, 105.73, 0 ), "ROADSIDE_ASSISTANCE_casino_east_01_enc_vol", undefined, "noent_volume_ai_encounter_cs", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_01_ob_roadside_assistance_cs";
    s.activity_bundle = "sat_ob_activitydef_roadside_assistance";
    s.name = "ROADSIDE_ASSISTANCE_casino_east_01";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_casino_east_01", cf, ( -5074, 30294, 370 ), ( 0, 112.59, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_01_ob_roadside_assistance_cs";
    s.info_act_ref = "ROADSIDE_ASSISTANCE_casino_east_01_repair_2";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_casino_east_01", cf, ( -4966, 30518, 310 ), ( 0, 70, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_01_ob_roadside_assistance_cs";
    s.info_act_ref = "ROADSIDE_ASSISTANCE_casino_east_01_repair_1";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_casino_east_01", cf, ( -4770, 30026, 322 ), ( 0, 249, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_01_ob_roadside_assistance_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_casino_east_01", cf, ( -4654, 30166, 256 ), ( 0, 114, 0 ), undefined, "cspf_3_auto6765928612504745703", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_01_ob_roadside_assistance_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.var_df8f7b8318d59fe5 = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_casino_east_01", cf, ( -5084, 30092, 398 ), ( 0, 277.9, 0 ), "cspf_3_auto14916520072416908387", "cspf_3_auto3506096206900994066", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_01_ob_roadside_assistance_cs";
    s.loop_route = "1";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.var_df8f7b8318d59fe5 = "1";
    s.start_point = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_casino_east_01", cf, ( -4780, 30246, 290 ), ( 0, 273.34, 0 ), "cspf_3_auto6765928612504745703", "cspf_3_auto14916520072416908387", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_01_ob_roadside_assistance_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.var_df8f7b8318d59fe5 = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_casino_east_01", cf, ( -5372, 30488, 360 ), ( 0, 92.01, 0 ), "cspf_3_auto3506096206900994066", "cspf_3_auto8524075815580069845", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_01_ob_roadside_assistance_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.var_df8f7b8318d59fe5 = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_casino_east_01", cf, ( -4876, 30680, 250 ), ( 0, 93.13, 0 ), "cspf_3_auto8524075815580069845", "cspf_3_auto6765928612504745703", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_01_ob_roadside_assistance_cs";
    s.ai_interaction = "idle_wreck_crouch_investigate";
    s.var_9a1a6bc9877cfff7 = "-1";
    s.repeat_interaction = "0";
    s.script_delay = "0";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_casino_east_01", cf, ( -4982, 30302, 346 ), ( 0, 202.58, 0 ), "ROADSIDE_ASSISTANCE_casino_east_01_repair_1", undefined, "info_act", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_01_ob_roadside_assistance_cs";
    s.ai_interaction = "idle_wreck_crouch_investigate";
    s.var_9a1a6bc9877cfff7 = "-1";
    s.repeat_interaction = "0";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_casino_east_01", cf, ( -5164, 30330, 372 ), ( 0, 25, 0 ), "ROADSIDE_ASSISTANCE_casino_east_01_repair_3", undefined, "info_act", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_01_ob_roadside_assistance_cs";
    s.ai_interaction = "idle_wreck_investigate";
    s.var_9a1a6bc9877cfff7 = "-1";
    s.repeat_interaction = "0";
    s.script_delay = "0";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_casino_east_01", cf, ( -5066, 30134, 390 ), ( 0, 82.57, 0 ), "ROADSIDE_ASSISTANCE_casino_east_01_repair_2", undefined, "info_act", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_01_ob_roadside_assistance_cs";
    s.info_act_ref = "ROADSIDE_ASSISTANCE_casino_south_01_repair_3";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_casino_south_01", cf, ( -9844, 12634, 26 ), ( 0, 225, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_01_ob_roadside_assistance_cs";
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
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_casino_south_01", cf, ( -10176, 12648, 212 ), ( 0, 311.59, 0 ), "ROADSIDE_ASSISTANCE_casino_south_01_enc_vol", undefined, "noent_volume_ai_encounter_cs", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_01_ob_roadside_assistance_cs";
    s.activity_bundle = "sat_ob_activitydef_roadside_assistance";
    s.name = "ROADSIDE_ASSISTANCE_casino_south_01";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_casino_south_01", cf, ( -10176, 12648, 212 ), ( 0, 306.59, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_01_ob_roadside_assistance_cs";
    s.info_act_ref = "ROADSIDE_ASSISTANCE_casino_south_01_repair_2";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_casino_south_01", cf, ( -10379.5, 12656.3, 232.65 ), ( 0, 225, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_01_ob_roadside_assistance_cs";
    s.info_act_ref = "ROADSIDE_ASSISTANCE_casino_south_01_repair_1";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_casino_south_01", cf, ( -10100, 13090, 242 ), ( 0, 83, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_01_ob_roadside_assistance_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_casino_south_01", cf, ( -10386, 12252, 234 ), ( 0, 38, 0 ), undefined, "cspf_4_auto6765928612504745703", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_01_ob_roadside_assistance_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.var_df8f7b8318d59fe5 = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_casino_south_01", cf, ( -9846, 12832, 30 ), ( 0, 111.9, 0 ), "cspf_4_auto14916520072416908387", "cspf_4_auto3506096206900994066", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_01_ob_roadside_assistance_cs";
    s.loop_route = "1";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.var_df8f7b8318d59fe5 = "1";
    s.start_point = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_casino_south_01", cf, ( -10340, 12272, 224 ), ( 0, 107.34, 0 ), "cspf_4_auto6765928612504745703", "cspf_4_auto14916520072416908387", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_01_ob_roadside_assistance_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.var_df8f7b8318d59fe5 = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_casino_south_01", cf, ( -9694, 12574, 10 ), ( 0, 286.01, 0 ), "cspf_4_auto3506096206900994066", "cspf_4_auto8524075815580069845", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_01_ob_roadside_assistance_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.var_df8f7b8318d59fe5 = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_casino_south_01", cf, ( -10134, 12176, 136 ), ( 0, 287.13, 0 ), "cspf_4_auto8524075815580069845", "cspf_4_auto6765928612504745703", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_01_ob_roadside_assistance_cs";
    s.ai_interaction = "idle_wreck_crouch_investigate";
    s.var_9a1a6bc9877cfff7 = "-1";
    s.repeat_interaction = "0";
    s.script_delay = "0";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_casino_south_01", cf, ( -10296, 12620, 220 ), ( 0, 45, 0 ), "ROADSIDE_ASSISTANCE_casino_south_01_repair_1", undefined, "info_act", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_01_ob_roadside_assistance_cs";
    s.ai_interaction = "idle_wreck_crouch_investigate";
    s.var_9a1a6bc9877cfff7 = "-1";
    s.repeat_interaction = "0";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_casino_south_01", cf, ( -10040, 12534, 102 ), ( 0, 141.58, 0 ), "ROADSIDE_ASSISTANCE_casino_south_01_repair_3", undefined, "info_act", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_01_ob_roadside_assistance_cs";
    s.ai_interaction = "idle_wreck_investigate";
    s.var_9a1a6bc9877cfff7 = "-1";
    s.repeat_interaction = "0";
    s.script_delay = "0";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_casino_south_01", cf, ( -10114, 12722, 218 ), ( 0, 270, 0 ), "ROADSIDE_ASSISTANCE_casino_south_01_repair_2", undefined, "info_act", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_01_ob_roadside_assistance_cs";
    s.info_act_ref = "ROADSIDE_ASSISTANCE_casino_west_01_repair_3";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_casino_west_01", cf, ( -21452, 19554, 1586 ), ( 0.85, 315, -0.92 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_01_ob_roadside_assistance_cs";
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
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_casino_west_01", cf, ( -21356, 19818, 1522 ), ( 0, 216.77, 0 ), "ROADSIDE_ASSISTANCE_casino_west_01_enc_vol", undefined, "noent_volume_ai_encounter_cs", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_01_ob_roadside_assistance_cs";
    s.activity_bundle = "sat_ob_activitydef_roadside_assistance";
    s.name = "ROADSIDE_ASSISTANCE_casino_west_01";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_casino_west_01", cf, ( -21356, 19818, 1522 ), ( 0, 216.77, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_01_ob_roadside_assistance_cs";
    s.info_act_ref = "ROADSIDE_ASSISTANCE_casino_west_01_repair_2";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_casino_west_01", cf, ( -21806, 19884, 1496 ), ( 1.25, 6.17, -0.05 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_01_ob_roadside_assistance_cs";
    s.info_act_ref = "ROADSIDE_ASSISTANCE_casino_west_01_repair_1";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_casino_west_01", cf, ( -21284, 20304, 1548 ), ( 0.92, 45, 0.85 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_01_ob_roadside_assistance_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_casino_west_01", cf, ( -21236, 20148, 1544 ), ( 0.62, 270, -1.09 ), undefined, "cspf_5_auto6765928612504745703", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_01_ob_roadside_assistance_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.var_df8f7b8318d59fe5 = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_casino_west_01", cf, ( -21054, 19754, 1524 ), ( 1.22, 22.08, 0.29 ), "cspf_5_auto14916520072416908387", "cspf_5_auto3506096206900994066", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_01_ob_roadside_assistance_cs";
    s.loop_route = "1";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.var_df8f7b8318d59fe5 = "1";
    s.start_point = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_casino_west_01", cf, ( -21218, 20098, 1544 ), ( 1.24, 17.51, 0.2 ), "cspf_5_auto6765928612504745703", "cspf_5_auto14916520072416908387", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_01_ob_roadside_assistance_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.var_df8f7b8318d59fe5 = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_casino_west_01", cf, ( -21492, 19430, 1606 ), ( 358.76, 196.19, -0.17 ), "cspf_5_auto3506096206900994066", "cspf_5_auto8524075815580069845", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_01_ob_roadside_assistance_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.var_df8f7b8318d59fe5 = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_casino_west_01", cf, ( -21616, 19894, 1524 ), ( 358.76, 197.3, -0.19 ), "cspf_5_auto8524075815580069845", "cspf_5_auto6765928612504745703", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_01_ob_roadside_assistance_cs";
    s.ai_interaction = "idle_wreck_crouch_investigate";
    s.var_9a1a6bc9877cfff7 = "-1";
    s.repeat_interaction = "0";
    s.script_delay = "0";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_casino_west_01", cf, ( -21388, 19910, 1522 ), ( 0, 306.75, 0 ), "ROADSIDE_ASSISTANCE_casino_west_01_repair_1", undefined, "info_act", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_01_ob_roadside_assistance_cs";
    s.ai_interaction = "idle_wreck_crouch_investigate";
    s.var_9a1a6bc9877cfff7 = "-1";
    s.repeat_interaction = "0";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_casino_west_01", cf, ( -21510, 19822, 1536 ), ( 0, 315, 0 ), "ROADSIDE_ASSISTANCE_casino_west_01_repair_3", undefined, "info_act", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_01_ob_roadside_assistance_cs";
    s.ai_interaction = "idle_wreck_investigate";
    s.var_9a1a6bc9877cfff7 = "-1";
    s.repeat_interaction = "0";
    s.script_delay = "0";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_casino_west_01", cf, ( -21356, 19706, 1538 ), ( 0, 135, 0 ), "ROADSIDE_ASSISTANCE_casino_west_01_repair_2", undefined, "info_act", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_01_ob_roadside_assistance_cs";
    s.info_act_ref = "ROADSIDE_ASSISTANCE_construction_site_west_01_repair_3";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_construction_site_west_01", cf, ( -27426, 22828, 1750 ), ( 0, 270, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_01_ob_roadside_assistance_cs";
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
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_construction_site_west_01", cf, ( -27282, 23008, 1754 ), ( 0, 210.59, 0 ), "ROADSIDE_ASSISTANCE_construction_site_west_01_enc_vol", undefined, "noent_volume_ai_encounter_cs", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_01_ob_roadside_assistance_cs";
    s.activity_bundle = "sat_ob_activitydef_roadside_assistance";
    s.name = "ROADSIDE_ASSISTANCE_construction_site_west_01";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_construction_site_west_01", cf, ( -27282, 23008, 1754 ), ( 0, 210.59, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_01_ob_roadside_assistance_cs";
    s.info_act_ref = "ROADSIDE_ASSISTANCE_construction_site_west_01_repair_2";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_construction_site_west_01", cf, ( -27588, 23128, 1750 ), ( 0, 180, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_01_ob_roadside_assistance_cs";
    s.info_act_ref = "ROADSIDE_ASSISTANCE_construction_site_west_01_repair_1";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_construction_site_west_01", cf, ( -27182, 23276, 1761.3 ), ( 0, 360, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_01_ob_roadside_assistance_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_construction_site_west_01", cf, ( -27162, 23508, 1788 ), ( 0, 270, 0 ), undefined, "cspf_6_auto6765928612504745703", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_01_ob_roadside_assistance_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.var_df8f7b8318d59fe5 = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_construction_site_west_01", cf, ( -27004, 23260, 1774 ), ( 0, 15.9, 0 ), "cspf_6_auto14916520072416908387", "cspf_6_auto3506096206900994066", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_01_ob_roadside_assistance_cs";
    s.loop_route = "1";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.var_df8f7b8318d59fe5 = "1";
    s.start_point = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_construction_site_west_01", cf, ( -27146, 23460, 1782 ), ( 0, 270, 0 ), "cspf_6_auto6765928612504745703", "cspf_6_auto14916520072416908387", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_01_ob_roadside_assistance_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.var_df8f7b8318d59fe5 = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_construction_site_west_01", cf, ( -27574, 22958, 1750 ), ( 0, 190.01, 0 ), "cspf_6_auto3506096206900994066", "cspf_6_auto8524075815580069845", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_01_ob_roadside_assistance_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.var_df8f7b8318d59fe5 = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_construction_site_west_01", cf, ( -27790, 23154, 1750 ), ( 0, 191.13, 0 ), "cspf_6_auto8524075815580069845", "cspf_6_auto6765928612504745703", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_01_ob_roadside_assistance_cs";
    s.ai_interaction = "idle_wreck_crouch_investigate";
    s.var_9a1a6bc9877cfff7 = "-1";
    s.repeat_interaction = "0";
    s.script_delay = "0";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_construction_site_west_01", cf, ( -27252, 23110, 1752 ), ( 0, 300.58, 0 ), "ROADSIDE_ASSISTANCE_construction_site_west_01_repair_1", undefined, "info_act", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_01_ob_roadside_assistance_cs";
    s.ai_interaction = "idle_wreck_crouch_investigate";
    s.var_9a1a6bc9877cfff7 = "-1";
    s.repeat_interaction = "0";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_construction_site_west_01", cf, ( -27386, 23024, 1750 ), ( 0, 315, 0 ), "ROADSIDE_ASSISTANCE_construction_site_west_01_repair_3", undefined, "info_act", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_01_ob_roadside_assistance_cs";
    s.ai_interaction = "idle_wreck_investigate";
    s.var_9a1a6bc9877cfff7 = "-1";
    s.repeat_interaction = "0";
    s.script_delay = "0";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_construction_site_west_01", cf, ( -27234, 22938, 1756 ), ( 0, 135, 0 ), "ROADSIDE_ASSISTANCE_construction_site_west_01_repair_2", undefined, "info_act", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_01_ob_roadside_assistance_cs";
    s.info_act_ref = "ROADSIDE_ASSISTANCE_stadium_west_01_repair_3";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_stadium_west_01", cf, ( -47388, 17798, 402 ), ( 0, 90, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_01_ob_roadside_assistance_cs";
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
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_stadium_west_01", cf, ( -47496, 17510, 346 ), ( 0, 267.79, 0 ), "ROADSIDE_ASSISTANCE_stadium_west_01_enc_vol", undefined, "noent_volume_ai_encounter_cs", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_01_ob_roadside_assistance_cs";
    s.activity_bundle = "sat_ob_activitydef_roadside_assistance";
    s.name = "ROADSIDE_ASSISTANCE_stadium_west_01";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_stadium_west_01", cf, ( -47496, 17510, 346 ), ( 0, 267.79, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_01_ob_roadside_assistance_cs";
    s.info_act_ref = "ROADSIDE_ASSISTANCE_stadium_west_01_repair_2";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_stadium_west_01", cf, ( -47632, 17386, 318 ), ( 0, 270, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_01_ob_roadside_assistance_cs";
    s.info_act_ref = "ROADSIDE_ASSISTANCE_stadium_west_01_repair_1";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_stadium_west_01", cf, ( -47384, 17564, 262 ), ( 0, 360, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_01_ob_roadside_assistance_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_stadium_west_01", cf, ( -47572, 17888, 400 ), ( 0, 359.2, 0 ), undefined, "cspf_7_auto6765928612504745703", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_01_ob_roadside_assistance_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.var_df8f7b8318d59fe5 = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_stadium_west_01", cf, ( -47212, 17876, 380 ), ( 0, 73.1, 0 ), "cspf_7_auto14916520072416908387", "cspf_7_auto3506096206900994066", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_01_ob_roadside_assistance_cs";
    s.loop_route = "1";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.var_df8f7b8318d59fe5 = "1";
    s.start_point = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_stadium_west_01", cf, ( -47524, 17874, 402 ), ( 0, 68.54, 0 ), "cspf_7_auto6765928612504745703", "cspf_7_auto14916520072416908387", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_01_ob_roadside_assistance_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.var_df8f7b8318d59fe5 = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_stadium_west_01", cf, ( -47396, 17660, 366 ), ( 0, 247.21, 0 ), "cspf_7_auto3506096206900994066", "cspf_7_auto8524075815580069845", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_01_ob_roadside_assistance_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.var_df8f7b8318d59fe5 = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_stadium_west_01", cf, ( -47678, 17696, 361.91 ), ( 0, 248.33, 0 ), "cspf_7_auto8524075815580069845", "cspf_7_auto6765928612504745703", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_01_ob_roadside_assistance_cs";
    s.ai_interaction = "idle_wreck_crouch_investigate";
    s.var_9a1a6bc9877cfff7 = "-1";
    s.repeat_interaction = "0";
    s.script_delay = "0";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_stadium_west_01", cf, ( -47570, 17542, 346 ), ( 0, 357.78, 0 ), "ROADSIDE_ASSISTANCE_stadium_west_01_repair_1", undefined, "info_act", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_01_ob_roadside_assistance_cs";
    s.ai_interaction = "idle_wreck_crouch_investigate";
    s.var_9a1a6bc9877cfff7 = "-1";
    s.repeat_interaction = "0";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_stadium_west_01", cf, ( -47564, 17404, 328 ), ( 0, 18, 0 ), "ROADSIDE_ASSISTANCE_stadium_west_01_repair_3", undefined, "info_act", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_01_ob_roadside_assistance_cs";
    s.ai_interaction = "idle_wreck_investigate";
    s.var_9a1a6bc9877cfff7 = "-1";
    s.repeat_interaction = "0";
    s.script_delay = "0";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_stadium_west_01", cf, ( -47436, 17658, 372 ), ( 0, 237.77, 0 ), "ROADSIDE_ASSISTANCE_stadium_west_01_repair_2", undefined, "info_act", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace mp_sat_avalon_quad_01_ob_roadside_assistance_cs
// Params 0, eflags: 0x4
// Checksum 0x199155ec, Offset: 0x5684
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace mp_sat_avalon_quad_01_ob_roadside_assistance_cs
// Params 0
// Checksum 0x75e6f6ba, Offset: 0x568e
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "mp_sat_avalon_quad_01_ob_roadside_assistance_cs" );
}

// Namespace mp_sat_avalon_quad_01_ob_roadside_assistance_cs
// Params 0
// Checksum 0x3f7c915d, Offset: 0x56a4
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

// Namespace mp_sat_avalon_quad_01_ob_roadside_assistance_cs
// Params 4
// Checksum 0x4de63e31, Offset: 0x5713
// Size: 0xf3
function function_d4323822d7042e5a( var_4312b79c960726b6, fe, us, cf = "mp_sat_avalon_quad_01_ob_roadside_assistance_cs" )
{
    switch ( var_4312b79c960726b6 )
    {
        case #"hash_193625b87b85a50c":
            function_f9fdd708df876574( fe, us, cf );
            break;
        case #"hash_34dd4feb3fc1d30":
            function_b458a102402ef868( fe, us, cf );
            break;
        case #"hash_d209576187c37507":
            function_26eedec99be3586f( fe, us, cf );
            break;
        case #"hash_77f0bd205819a8b3":
            function_839317dd5c69cf0b( fe, us, cf );
            break;
        case #"hash_f41569a20fa213fd":
            function_65797bfb5c796dc5( fe, us, cf );
            break;
        case #"hash_b9cee3e47016068f":
            function_5555bfc577ad2307( fe, us, cf );
            break;
        case #"hash_497d14ba28df5ac1":
            function_682128200c0d0549( fe, us, cf );
            break;
    }
}

// Namespace mp_sat_avalon_quad_01_ob_roadside_assistance_cs
// Params 3
// Checksum 0x132eea83, Offset: 0x580e
// Size: 0x187
function function_f9fdd708df876574( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_01_ob_roadside_assistance_cs";
    s.name = "teleport_location";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_suburbs_west_01", cf, ( -21730, 47702, 1502 ), ( 0, 264.59, 0 ), "`", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_01_ob_roadside_assistance_cs";
    s.name = "cargo";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_suburbs_west_01", cf, ( -21444, 48396, 1298 ), ( 0, 358.59, 0 ), "ROADSIDE_ASSISTANCE_suburbs_west_01_cargo", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_01_ob_roadside_assistance_cs";
    s.name = "vehicle";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_suburbs_west_01", cf, ( -21312, 48394, 1300 ), ( 0, 358.59, 0 ), "ROADSIDE_ASSISTANCE_suburbs_west_01_vehicle", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_sat_avalon_quad_01_ob_roadside_assistance_cs
// Params 3
// Checksum 0x747d613a, Offset: 0x599d
// Size: 0x187
function function_b458a102402ef868( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_01_ob_roadside_assistance_cs";
    s.name = "teleport_location";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_suburbs_south_01", cf, ( -16762, 36358, 2030 ), ( 0, 264.59, 0 ), "`", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_01_ob_roadside_assistance_cs";
    s.name = "cargo";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_suburbs_south_01", cf, ( -16470, 37266, 1586 ), ( 0, 312.59, 0 ), "ROADSIDE_ASSISTANCE_suburbs_south_01_cargo", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_01_ob_roadside_assistance_cs";
    s.name = "vehicle";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_suburbs_south_01", cf, ( -16380, 37170, 1580 ), ( 0, 312.59, 0 ), "ROADSIDE_ASSISTANCE_suburbs_south_01_vehicle", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_sat_avalon_quad_01_ob_roadside_assistance_cs
// Params 3
// Checksum 0xad0c4926, Offset: 0x5b2c
// Size: 0x187
function function_26eedec99be3586f( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_01_ob_roadside_assistance_cs";
    s.name = "teleport_location";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_casino_east_01", cf, ( -6042, 30678, 354 ), ( 0, 264.59, 0 ), "`", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_01_ob_roadside_assistance_cs";
    s.name = "cargo";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_casino_east_01", cf, ( -4958, 30232, 346 ), ( 0, 360, 0 ), "ROADSIDE_ASSISTANCE_casino_east_01_cargo", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_01_ob_roadside_assistance_cs";
    s.name = "vehicle";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_casino_east_01", cf, ( -5074, 30296, 362 ), ( 1.08, 105.73, 8.97 ), "ROADSIDE_ASSISTANCE_casino_east_01_vehicle", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_sat_avalon_quad_01_ob_roadside_assistance_cs
// Params 3
// Checksum 0xd527f2fc, Offset: 0x5cbb
// Size: 0x187
function function_839317dd5c69cf0b( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_01_ob_roadside_assistance_cs";
    s.name = "teleport_location";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_casino_south_01", cf, ( -9030, 12094, 798 ), ( 0, 354.59, 0 ), "`", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_01_ob_roadside_assistance_cs";
    s.name = "cargo";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_casino_south_01", cf, ( -10256, 12782, 226 ), ( 357, 89.35, 12.3 ), "ROADSIDE_ASSISTANCE_casino_south_01_cargo", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_01_ob_roadside_assistance_cs";
    s.name = "vehicle";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_casino_south_01", cf, ( -10176, 12649, 196 ), ( 12.72, 317.27, 4.97 ), "ROADSIDE_ASSISTANCE_casino_south_01_vehicle", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_sat_avalon_quad_01_ob_roadside_assistance_cs
// Params 3
// Checksum 0x882a316, Offset: 0x5e4a
// Size: 0x187
function function_65797bfb5c796dc5( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_01_ob_roadside_assistance_cs";
    s.name = "teleport_location";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_casino_west_01", cf, ( -20920, 19454, 1508 ), ( 0, 174.59, 0 ), "`", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_01_ob_roadside_assistance_cs";
    s.name = "cargo";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_casino_west_01", cf, ( -21244, 19902, 1526 ), ( 0, 306.77, 0 ), "ROADSIDE_ASSISTANCE_casino_west_01_cargo", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_01_ob_roadside_assistance_cs";
    s.name = "vehicle";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_casino_west_01", cf, ( -21362, 19811, 1526 ), ( 353.28, 217.56, -1.68 ), "ROADSIDE_ASSISTANCE_casino_west_01_vehicle", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_sat_avalon_quad_01_ob_roadside_assistance_cs
// Params 3
// Checksum 0xc8d3c309, Offset: 0x5fd9
// Size: 0x187
function function_5555bfc577ad2307( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_01_ob_roadside_assistance_cs";
    s.name = "teleport_location";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_construction_site_west_01", cf, ( -28210, 23090, 2630 ), ( 0, 174.59, 0 ), "`", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_01_ob_roadside_assistance_cs";
    s.name = "cargo";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_construction_site_west_01", cf, ( -27168, 23076, 1762 ), ( 0, 210.59, 0 ), "ROADSIDE_ASSISTANCE_construction_site_west_01_cargo", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_01_ob_roadside_assistance_cs";
    s.name = "vehicle";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_construction_site_west_01", cf, ( -27282, 23008, 1753 ), ( 2.68, 210.58, -0.11 ), "ROADSIDE_ASSISTANCE_construction_site_west_01_vehicle", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_sat_avalon_quad_01_ob_roadside_assistance_cs
// Params 3
// Checksum 0x31a72285, Offset: 0x6168
// Size: 0x187
function function_682128200c0d0549( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_01_ob_roadside_assistance_cs";
    s.name = "teleport_location";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_stadium_west_01", cf, ( -47542, 16680, 2630 ), ( 0, 264.59, 0 ), "`", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_01_ob_roadside_assistance_cs";
    s.name = "cargo";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_stadium_west_01", cf, ( -47492, 17642, 370 ), ( 0, 267.79, 0 ), "ROADSIDE_ASSISTANCE_stadium_west_01_cargo", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_01_ob_roadside_assistance_cs";
    s.name = "vehicle";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_stadium_west_01", cf, ( -47496, 17510, 352 ), ( 3.2, 266.68, -0.06 ), "ROADSIDE_ASSISTANCE_stadium_west_01_vehicle", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_sat_avalon_quad_01_ob_roadside_assistance_cs
// Params 0
// Checksum 0xed97936e, Offset: 0x62f7
// Size: 0x42c
function function_d9dd7965c51c95d1()
{
    activityinstances = [];
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_ob_activitydef_roadside_assistance";
    var_881289d7987bc770.cf = "mp_sat_avalon_quad_01_ob_roadside_assistance_cs";
    var_881289d7987bc770.scriptstructorigin = ( -21312, 48394, 1300 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [];
    var_881289d7987bc770.var_31ce4477e3543d24 = [];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [];
    var_881289d7987bc770.locationradius = [];
    activityinstances[ "ROADSIDE_ASSISTANCE_suburbs_west_01" ] = var_881289d7987bc770;
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_ob_activitydef_roadside_assistance";
    var_881289d7987bc770.cf = "mp_sat_avalon_quad_01_ob_roadside_assistance_cs";
    var_881289d7987bc770.scriptstructorigin = ( -16380, 37170, 1580 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [];
    var_881289d7987bc770.var_31ce4477e3543d24 = [];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [];
    var_881289d7987bc770.locationradius = [];
    activityinstances[ "ROADSIDE_ASSISTANCE_suburbs_south_01" ] = var_881289d7987bc770;
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_ob_activitydef_roadside_assistance";
    var_881289d7987bc770.cf = "mp_sat_avalon_quad_01_ob_roadside_assistance_cs";
    var_881289d7987bc770.scriptstructorigin = ( -5074, 30294, 370 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [];
    var_881289d7987bc770.var_31ce4477e3543d24 = [];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [];
    var_881289d7987bc770.locationradius = [];
    activityinstances[ "ROADSIDE_ASSISTANCE_casino_east_01" ] = var_881289d7987bc770;
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_ob_activitydef_roadside_assistance";
    var_881289d7987bc770.cf = "mp_sat_avalon_quad_01_ob_roadside_assistance_cs";
    var_881289d7987bc770.scriptstructorigin = ( -10176, 12648, 212 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [];
    var_881289d7987bc770.var_31ce4477e3543d24 = [];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [];
    var_881289d7987bc770.locationradius = [];
    activityinstances[ "ROADSIDE_ASSISTANCE_casino_south_01" ] = var_881289d7987bc770;
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_ob_activitydef_roadside_assistance";
    var_881289d7987bc770.cf = "mp_sat_avalon_quad_01_ob_roadside_assistance_cs";
    var_881289d7987bc770.scriptstructorigin = ( -21356, 19818, 1522 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [];
    var_881289d7987bc770.var_31ce4477e3543d24 = [];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [];
    var_881289d7987bc770.locationradius = [];
    activityinstances[ "ROADSIDE_ASSISTANCE_casino_west_01" ] = var_881289d7987bc770;
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_ob_activitydef_roadside_assistance";
    var_881289d7987bc770.cf = "mp_sat_avalon_quad_01_ob_roadside_assistance_cs";
    var_881289d7987bc770.scriptstructorigin = ( -27282, 23008, 1754 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [];
    var_881289d7987bc770.var_31ce4477e3543d24 = [];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [];
    var_881289d7987bc770.locationradius = [];
    activityinstances[ "ROADSIDE_ASSISTANCE_construction_site_west_01" ] = var_881289d7987bc770;
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_ob_activitydef_roadside_assistance";
    var_881289d7987bc770.cf = "mp_sat_avalon_quad_01_ob_roadside_assistance_cs";
    var_881289d7987bc770.scriptstructorigin = ( -47496, 17510, 346 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [];
    var_881289d7987bc770.var_31ce4477e3543d24 = [];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [];
    var_881289d7987bc770.locationradius = [];
    activityinstances[ "ROADSIDE_ASSISTANCE_stadium_west_01" ] = var_881289d7987bc770;
    return activityinstances;
}

