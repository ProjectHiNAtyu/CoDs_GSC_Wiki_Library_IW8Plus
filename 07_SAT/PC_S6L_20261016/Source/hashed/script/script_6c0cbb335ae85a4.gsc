// script_6c0cbb335ae85a4  (hash_06c0cbb335ae85a4.gscc) (size: 37051 Bytes / 0x90bb / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xa8a7b3c8 (2829562824)
// size ...... 37051 (0x90bb)
// includes .. 4   (offset: 0x7c3b)
// strings ... 114 (offset: 0x7c5b)
// dev strs .. 0   (offset: 0x90bb)
// exports ... 20  (offset: 0x755f)
// cseg ...... 0x1096 + 0x64c9 (0x755f)
// imports ... 33  (offset: 0x787f)
// animtree1 . 0   (offset: 0x90bb)
// animtree2 . 0   (offset: 0x90bb)
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace mp_sat_avalon_q2_ob_activity_roadside_assistance_cs;

// Namespace mp_sat_avalon_q2_ob_activity_roadside_assistance_cs
// Params 0, eflags: 0x5
// Checksum 0x173d25dd, Offset: 0x10b4
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"mp_sat_avalon_q2_ob_activity_roadside_assistance_cs", #"activity_common", &function_b39ecd3d51489472, undefined );
}

// Namespace mp_sat_avalon_q2_ob_activity_roadside_assistance_cs
// Params 0, eflags: 0x4
// Checksum 0x4afe7179, Offset: 0x10dd
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace mp_sat_avalon_q2_ob_activity_roadside_assistance_cs
// Params 0, eflags: 0x4
// Checksum 0xcfc5a295, Offset: 0x10ee
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace mp_sat_avalon_q2_ob_activity_roadside_assistance_cs
// Params 2
// Checksum 0xef363dff, Offset: 0x10ff
// Size: 0x8c
function main( unused, unused2 )
{
    if ( utility::flag_exist( "mp_sat_avalon_q2_ob_activity_roadside_assistance_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "mp_sat_avalon_q2_ob_activity_roadside_assistance_cs" ) )
    {
        return;
    }
    
    activity_common::function_e1df676808c1d1e3( &function_4cd78e661617f3 );
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "mp_sat_avalon_q2_ob_activity_roadside_assistance_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "mp_sat_avalon_q2_ob_activity_roadside_assistance_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace mp_sat_avalon_q2_ob_activity_roadside_assistance_cs
// Params 3, eflags: 0x4
// Checksum 0x4c47165a, Offset: 0x1193
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "mp_sat_avalon_q2_ob_activity_roadside_assistance_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "mp_sat_avalon_q2_ob_activity_roadside_assistance_cs" );
}

// Namespace mp_sat_avalon_q2_ob_activity_roadside_assistance_cs
// Params 3, eflags: 0x4
// Checksum 0x12766da7, Offset: 0x120d
// Size: 0x506c
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_roadside_assistance_cs";
    s.info_act_ref = "ROADSIDE_ASSISTANCE_winery_01_repair_3";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_winery_01", cf, ( 17600, 44546, 816 ), ( 0, 180, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_roadside_assistance_cs";
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
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_winery_01", cf, ( 17820, 44542, 822 ), ( 0, 132.59, 0 ), "ROADSIDE_ASSISTANCE_winery_01_enc_vol", undefined, "noent_volume_ai_encounter_cs", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_roadside_assistance_cs";
    s.activity_bundle = "sat_ob_activitydef_roadside_assistance";
    s.name = "ROADSIDE_ASSISTANCE_winery_01";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_winery_01", cf, ( 17820, 44542, 822 ), ( 0, 132.59, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_roadside_assistance_cs";
    s.info_act_ref = "ROADSIDE_ASSISTANCE_winery_01_repair_2";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_winery_01", cf, ( 17798, 44736, 818 ), ( 0, 135, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_roadside_assistance_cs";
    s.info_act_ref = "ROADSIDE_ASSISTANCE_winery_01_repair_1";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_winery_01", cf, ( 17844, 44308, 840 ), ( 0, 315, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_roadside_assistance_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_winery_01", cf, ( 18208, 44474, 834 ), ( 0, 224, 0 ), undefined, "cspf_1_auto6765928612504745703", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_roadside_assistance_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.var_df8f7b8318d59fe5 = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_winery_01", cf, ( 17854, 44194, 838 ), ( 0, 297.9, 0 ), "cspf_1_auto14916520072416908387", "cspf_1_auto3506096206900994066", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_roadside_assistance_cs";
    s.loop_route = "1";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.var_df8f7b8318d59fe5 = "1";
    s.start_point = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_winery_01", cf, ( 18166, 44450, 836 ), ( 0, 293.34, 0 ), "cspf_1_auto6765928612504745703", "cspf_1_auto14916520072416908387", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_roadside_assistance_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.var_df8f7b8318d59fe5 = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_winery_01", cf, ( 17424, 44530, 816 ), ( 0, 112.01, 0 ), "cspf_1_auto3506096206900994066", "cspf_1_auto8524075815580069845", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_roadside_assistance_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.var_df8f7b8318d59fe5 = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_winery_01", cf, ( 17780, 44894, 828 ), ( 0, 113.13, 0 ), "cspf_1_auto8524075815580069845", "cspf_1_auto6765928612504745703", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_roadside_assistance_cs";
    s.ai_interaction = "idle_wreck_crouch_investigate";
    s.var_9a1a6bc9877cfff7 = "-1";
    s.repeat_interaction = "0";
    s.script_delay = "0";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_winery_01", cf, ( 17894, 44570, 830 ), ( 0, 222.58, 0 ), "ROADSIDE_ASSISTANCE_winery_01_repair_1", undefined, "info_act", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_roadside_assistance_cs";
    s.ai_interaction = "idle_wreck_crouch_investigate";
    s.var_9a1a6bc9877cfff7 = "-1";
    s.repeat_interaction = "0";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_winery_01", cf, ( 17716, 44642, 808 ), ( 0, 327.58, 0 ), "ROADSIDE_ASSISTANCE_winery_01_repair_3", undefined, "info_act", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_roadside_assistance_cs";
    s.ai_interaction = "idle_wreck_investigate";
    s.var_9a1a6bc9877cfff7 = "-1";
    s.repeat_interaction = "0";
    s.script_delay = "0";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_winery_01", cf, ( 17882, 44394, 826 ), ( 0, 102.57, 0 ), "ROADSIDE_ASSISTANCE_winery_01_repair_2", undefined, "info_act", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_roadside_assistance_cs";
    s.info_act_ref = "ROADSIDE_ASSISTANCE_clifftown_east_01_repair_3";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_clifftown_east_01", cf, ( 50386, 11184, 1220 ), ( 0, 270, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_roadside_assistance_cs";
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
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_clifftown_east_01", cf, ( 50750, 11302, 1184 ), ( 0, 240.59, 0 ), "ROADSIDE_ASSISTANCE_clifftown_east_01_enc_vol", undefined, "noent_volume_ai_encounter_cs", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_roadside_assistance_cs";
    s.activity_bundle = "sat_ob_activitydef_roadside_assistance";
    s.name = "ROADSIDE_ASSISTANCE_clifftown_east_01";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_clifftown_east_01", cf, ( 50750, 11302, 1184 ), ( 0, 240.59, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_roadside_assistance_cs";
    s.info_act_ref = "ROADSIDE_ASSISTANCE_clifftown_east_01_repair_2";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_clifftown_east_01", cf, ( 50836, 11486, 1166 ), ( 0, 90, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_roadside_assistance_cs";
    s.info_act_ref = "ROADSIDE_ASSISTANCE_clifftown_east_01_repair_1";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_clifftown_east_01", cf, ( 50998, 11188, 1184 ), ( 0, 360, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_roadside_assistance_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_clifftown_east_01", cf, ( 50684, 11630, 1116 ), ( 0, 242, 0 ), undefined, "cspf_2_auto6765928612504745703", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_roadside_assistance_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.var_df8f7b8318d59fe5 = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_clifftown_east_01", cf, ( 51042, 11498, 1146 ), ( 0, 45.9, 0 ), "cspf_2_auto14916520072416908387", "cspf_2_auto3506096206900994066", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_roadside_assistance_cs";
    s.loop_route = "1";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.var_df8f7b8318d59fe5 = "1";
    s.start_point = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_clifftown_east_01", cf, ( 50678, 11592, 1112 ), ( 0, 41.34, 0 ), "cspf_2_auto6765928612504745703", "cspf_2_auto14916520072416908387", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_roadside_assistance_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.var_df8f7b8318d59fe5 = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_clifftown_east_01", cf, ( 50840, 11034, 1248 ), ( 0, 220.01, 0 ), "cspf_2_auto3506096206900994066", "cspf_2_auto8524075815580069845", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_roadside_assistance_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.var_df8f7b8318d59fe5 = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_clifftown_east_01", cf, ( 50468, 11228, 1212 ), ( 0, 221.13, 0 ), "cspf_2_auto8524075815580069845", "cspf_2_auto6765928612504745703", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_roadside_assistance_cs";
    s.ai_interaction = "idle_wreck_crouch_investigate";
    s.var_9a1a6bc9877cfff7 = "-1";
    s.repeat_interaction = "0";
    s.script_delay = "0";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_clifftown_east_01", cf, ( 50700, 11364, 1178 ), ( 0, 330.58, 0 ), "ROADSIDE_ASSISTANCE_clifftown_east_01_repair_1", undefined, "info_act", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_roadside_assistance_cs";
    s.ai_interaction = "idle_wreck_crouch_investigate";
    s.var_9a1a6bc9877cfff7 = "-1";
    s.repeat_interaction = "0";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_clifftown_east_01", cf, ( 50686, 11172, 1206 ), ( 0, 75.58, 0 ), "ROADSIDE_ASSISTANCE_clifftown_east_01_repair_3", undefined, "info_act", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_roadside_assistance_cs";
    s.ai_interaction = "idle_wreck_investigate";
    s.var_9a1a6bc9877cfff7 = "-1";
    s.repeat_interaction = "0";
    s.script_delay = "0";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_clifftown_east_01", cf, ( 50872, 11408, 1170 ), ( 0, 210.57, 0 ), "ROADSIDE_ASSISTANCE_clifftown_east_01_repair_2", undefined, "info_act", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_roadside_assistance_cs";
    s.info_act_ref = "ROADSIDE_ASSISTANCE_winery_south_01_repair_3";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_winery_south_01", cf, ( 21306, 34304, 2322 ), ( 0, 90, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_roadside_assistance_cs";
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
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_winery_south_01", cf, ( 21534, 34022, 2316 ), ( 0, 164.59, 0 ), "ROADSIDE_ASSISTANCE_winery_south_01_enc_vol", undefined, "noent_volume_ai_encounter_cs", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_roadside_assistance_cs";
    s.activity_bundle = "sat_ob_activitydef_roadside_assistance";
    s.name = "ROADSIDE_ASSISTANCE_winery_south_01";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_winery_south_01", cf, ( 21534, 34022, 2316 ), ( 0, 164.59, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_roadside_assistance_cs";
    s.info_act_ref = "ROADSIDE_ASSISTANCE_winery_south_01_repair_2";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_winery_south_01", cf, ( 21438, 33918, 2316 ), ( 0, 225, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_roadside_assistance_cs";
    s.info_act_ref = "ROADSIDE_ASSISTANCE_winery_south_01_repair_1";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_winery_south_01", cf, ( 21772, 33608, 2340 ), ( 0, 315, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_roadside_assistance_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_winery_south_01", cf, ( 21898, 34170, 2272 ), ( 0, 256, 0 ), undefined, "cspf_3_auto6765928612504745703", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_roadside_assistance_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.var_df8f7b8318d59fe5 = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_winery_south_01", cf, ( 21670, 33772, 2306 ), ( 0, 329.9, 0 ), "cspf_3_auto14916520072416908387", "cspf_3_auto3506096206900994066", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_roadside_assistance_cs";
    s.loop_route = "1";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.var_df8f7b8318d59fe5 = "1";
    s.start_point = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_winery_south_01", cf, ( 21876, 34128, 2272 ), ( 0, 325.34, 0 ), "cspf_3_auto6765928612504745703", "cspf_3_auto14916520072416908387", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_roadside_assistance_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.var_df8f7b8318d59fe5 = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_winery_south_01", cf, ( 21206, 33802, 2324 ), ( 0, 144.01, 0 ), "cspf_3_auto3506096206900994066", "cspf_3_auto8524075815580069845", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_roadside_assistance_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.var_df8f7b8318d59fe5 = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_winery_south_01", cf, ( 21406, 34248, 2318 ), ( 0, 145.13, 0 ), "cspf_3_auto8524075815580069845", "cspf_3_auto6765928612504745703", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_roadside_assistance_cs";
    s.ai_interaction = "idle_wreck_crouch_investigate";
    s.var_9a1a6bc9877cfff7 = "-1";
    s.repeat_interaction = "0";
    s.script_delay = "0";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_winery_south_01", cf, ( 21582, 34086, 2316 ), ( 0, 254.58, 0 ), "ROADSIDE_ASSISTANCE_winery_south_01_repair_1", undefined, "info_act", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_roadside_assistance_cs";
    s.ai_interaction = "idle_wreck_crouch_investigate";
    s.var_9a1a6bc9877cfff7 = "-1";
    s.repeat_interaction = "0";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_winery_south_01", cf, ( 21392, 34052, 2320 ), ( 0, 359.57, 0 ), "ROADSIDE_ASSISTANCE_winery_south_01_repair_3", undefined, "info_act", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_roadside_assistance_cs";
    s.ai_interaction = "idle_wreck_investigate";
    s.var_9a1a6bc9877cfff7 = "-1";
    s.repeat_interaction = "0";
    s.script_delay = "0";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_winery_south_01", cf, ( 21666, 33930, 2304 ), ( 0, 134.57, 0 ), "ROADSIDE_ASSISTANCE_winery_south_01_repair_2", undefined, "info_act", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_roadside_assistance_cs";
    s.info_act_ref = "ROADSIDE_ASSISTANCE_winery_west_01_repair_3";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_winery_west_01", cf, ( 2326, 37160, 782 ), ( 0, 270, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_roadside_assistance_cs";
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
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_winery_west_01", cf, ( 2222, 37330, 750 ), ( 0, 240.59, 0 ), "ROADSIDE_ASSISTANCE_winery_west_01_enc_vol", undefined, "noent_volume_ai_encounter_cs", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_roadside_assistance_cs";
    s.activity_bundle = "sat_ob_activitydef_roadside_assistance";
    s.name = "ROADSIDE_ASSISTANCE_winery_west_01";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_winery_west_01", cf, ( 2222, 37330, 750 ), ( 0, 240.59, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_roadside_assistance_cs";
    s.info_act_ref = "ROADSIDE_ASSISTANCE_winery_west_01_repair_2";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_winery_west_01", cf, ( 2236, 37554, 728 ), ( 0, 180, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_roadside_assistance_cs";
    s.info_act_ref = "ROADSIDE_ASSISTANCE_winery_west_01_repair_1";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_winery_west_01", cf, ( 2540, 37394, 754 ), ( 0, 45, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_roadside_assistance_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_winery_west_01", cf, ( 2166, 37720, 696 ), ( 0, 332, 0 ), undefined, "cspf_4_auto6765928612504745703", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_roadside_assistance_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.var_df8f7b8318d59fe5 = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_winery_west_01", cf, ( 2698, 37462, 762 ), ( 0, 45.9, 0 ), "cspf_4_auto14916520072416908387", "cspf_4_auto3506096206900994066", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_roadside_assistance_cs";
    s.loop_route = "1";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.var_df8f7b8318d59fe5 = "1";
    s.start_point = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_winery_west_01", cf, ( 2202, 37688, 708 ), ( 0, 41.34, 0 ), "cspf_4_auto6765928612504745703", "cspf_4_auto14916520072416908387", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_roadside_assistance_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.var_df8f7b8318d59fe5 = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_winery_west_01", cf, ( 2356, 36958, 798 ), ( 0, 220.01, 0 ), "cspf_4_auto3506096206900994066", "cspf_4_auto8524075815580069845", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_roadside_assistance_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.var_df8f7b8318d59fe5 = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_winery_west_01", cf, ( 1900, 37184, 770 ), ( 0, 221.13, 0 ), "cspf_4_auto8524075815580069845", "cspf_4_auto6765928612504745703", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_roadside_assistance_cs";
    s.ai_interaction = "idle_wreck_crouch_investigate";
    s.var_9a1a6bc9877cfff7 = "-1";
    s.repeat_interaction = "0";
    s.script_delay = "0";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_winery_west_01", cf, ( 2172, 37392, 740 ), ( 0, 330.58, 0 ), "ROADSIDE_ASSISTANCE_winery_west_01_repair_1", undefined, "info_act", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_roadside_assistance_cs";
    s.ai_interaction = "idle_wreck_crouch_investigate";
    s.var_9a1a6bc9877cfff7 = "-1";
    s.repeat_interaction = "0";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_winery_west_01", cf, ( 2158, 37200, 768 ), ( 0, 75.58, 0 ), "ROADSIDE_ASSISTANCE_winery_west_01_repair_3", undefined, "info_act", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_roadside_assistance_cs";
    s.ai_interaction = "idle_wreck_investigate";
    s.var_9a1a6bc9877cfff7 = "-1";
    s.repeat_interaction = "0";
    s.script_delay = "0";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_winery_west_01", cf, ( 2344, 37436, 740 ), ( 0, 210.57, 0 ), "ROADSIDE_ASSISTANCE_winery_west_01_repair_2", undefined, "info_act", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_roadside_assistance_cs";
    s.info_act_ref = "ROADSIDE_ASSISTANCE_beach_resorts_east_01_repair_3";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_beach_resorts_east_01", cf, ( 25536, 20430, 758 ), ( 0, 360, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_roadside_assistance_cs";
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
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_beach_resorts_east_01", cf, ( 25366, 20048, 702 ), ( 0, 108.59, 0 ), "ROADSIDE_ASSISTANCE_beach_resorts_east_01_enc_vol", undefined, "noent_volume_ai_encounter_cs", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_roadside_assistance_cs";
    s.activity_bundle = "sat_ob_activitydef_roadside_assistance";
    s.name = "ROADSIDE_ASSISTANCE_beach_resorts_east_01";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_beach_resorts_east_01", cf, ( 25366, 20048, 702 ), ( 0, 108.59, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_roadside_assistance_cs";
    s.info_act_ref = "ROADSIDE_ASSISTANCE_beach_resorts_east_01_repair_2";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_beach_resorts_east_01", cf, ( 25180, 20120, 678 ), ( 0, 135, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_roadside_assistance_cs";
    s.info_act_ref = "ROADSIDE_ASSISTANCE_beach_resorts_east_01_repair_1";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_beach_resorts_east_01", cf, ( 25258, 19700, 668 ), ( 0, 270, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_roadside_assistance_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_beach_resorts_east_01", cf, ( 25692, 19828, 718 ), ( 0, 200, 0 ), undefined, "cspf_5_auto6765928612504745703", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_roadside_assistance_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.var_df8f7b8318d59fe5 = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_beach_resorts_east_01", cf, ( 25234, 19794, 670 ), ( 0, 273.9, 0 ), "cspf_5_auto14916520072416908387", "cspf_5_auto3506096206900994066", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_roadside_assistance_cs";
    s.loop_route = "1";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.var_df8f7b8318d59fe5 = "1";
    s.start_point = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_beach_resorts_east_01", cf, ( 25644, 19824, 714 ), ( 0, 269.34, 0 ), "cspf_5_auto6765928612504745703", "cspf_5_auto14916520072416908387", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_roadside_assistance_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.var_df8f7b8318d59fe5 = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_beach_resorts_east_01", cf, ( 25000, 20196, 654 ), ( 0, 88.01, 0 ), "cspf_5_auto3506096206900994066", "cspf_5_auto8524075815580069845", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_roadside_assistance_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.var_df8f7b8318d59fe5 = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_beach_resorts_east_01", cf, ( 25482, 20280, 736 ), ( 0, 89.13, 0 ), "cspf_5_auto8524075815580069845", "cspf_5_auto6765928612504745703", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_roadside_assistance_cs";
    s.ai_interaction = "idle_wreck_crouch_investigate";
    s.var_9a1a6bc9877cfff7 = "-1";
    s.repeat_interaction = "0";
    s.script_delay = "0";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_beach_resorts_east_01", cf, ( 25446, 20044, 714 ), ( 0, 198.58, 0 ), "ROADSIDE_ASSISTANCE_beach_resorts_east_01_repair_1", undefined, "info_act", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_roadside_assistance_cs";
    s.ai_interaction = "idle_wreck_crouch_investigate";
    s.var_9a1a6bc9877cfff7 = "-1";
    s.repeat_interaction = "0";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_beach_resorts_east_01", cf, ( 25312, 20182, 696 ), ( 0, 303.57, 0 ), "ROADSIDE_ASSISTANCE_beach_resorts_east_01_repair_3", undefined, "info_act", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_roadside_assistance_cs";
    s.ai_interaction = "idle_wreck_investigate";
    s.var_9a1a6bc9877cfff7 = "-1";
    s.repeat_interaction = "0";
    s.script_delay = "0";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_beach_resorts_east_01", cf, ( 25364, 19886, 692 ), ( 0, 78.57, 0 ), "ROADSIDE_ASSISTANCE_beach_resorts_east_01_repair_2", undefined, "info_act", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_roadside_assistance_cs";
    s.info_act_ref = "ROADSIDE_ASSISTANCE_dig_site_east_01_repair_3";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_dig_site_east_01", cf, ( 38344, 31182, 1276 ), ( 0, 270, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_roadside_assistance_cs";
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
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_dig_site_east_01", cf, ( 38174, 30800, 1162 ), ( 0, 108.59, 0 ), "ROADSIDE_ASSISTANCE_dig_site_east_01_enc_vol", undefined, "noent_volume_ai_encounter_cs", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_roadside_assistance_cs";
    s.activity_bundle = "sat_ob_activitydef_roadside_assistance";
    s.name = "ROADSIDE_ASSISTANCE_dig_site_east_01";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_dig_site_east_01", cf, ( 38174, 30800, 1162 ), ( 0, 108.59, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_roadside_assistance_cs";
    s.info_act_ref = "ROADSIDE_ASSISTANCE_dig_site_east_01_repair_2";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_dig_site_east_01", cf, ( 37988, 30872, 1192 ), ( 0, 135, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_roadside_assistance_cs";
    s.info_act_ref = "ROADSIDE_ASSISTANCE_dig_site_east_01_repair_1";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_dig_site_east_01", cf, ( 38066, 30452, 1072 ), ( 0, 270, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_roadside_assistance_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_dig_site_east_01", cf, ( 38500, 30580, 1080 ), ( 0, 200, 0 ), undefined, "cspf_6_auto6765928612504745703", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_roadside_assistance_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.var_df8f7b8318d59fe5 = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_dig_site_east_01", cf, ( 38042, 30546, 1100 ), ( 0, 273.9, 0 ), "cspf_6_auto14916520072416908387", "cspf_6_auto3506096206900994066", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_roadside_assistance_cs";
    s.loop_route = "1";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.var_df8f7b8318d59fe5 = "1";
    s.start_point = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_dig_site_east_01", cf, ( 38452, 30576, 1084 ), ( 0, 269.34, 0 ), "cspf_6_auto6765928612504745703", "cspf_6_auto14916520072416908387", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_roadside_assistance_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.var_df8f7b8318d59fe5 = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_dig_site_east_01", cf, ( 37808, 30948, 1230 ), ( 0, 88.01, 0 ), "cspf_6_auto3506096206900994066", "cspf_6_auto8524075815580069845", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_roadside_assistance_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.var_df8f7b8318d59fe5 = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_dig_site_east_01", cf, ( 38290, 31032, 1234 ), ( 0, 89.13, 0 ), "cspf_6_auto8524075815580069845", "cspf_6_auto6765928612504745703", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_roadside_assistance_cs";
    s.ai_interaction = "idle_wreck_crouch_investigate";
    s.var_9a1a6bc9877cfff7 = "-1";
    s.repeat_interaction = "0";
    s.script_delay = "0";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_dig_site_east_01", cf, ( 38254, 30796, 1158 ), ( 0, 198.58, 0 ), "ROADSIDE_ASSISTANCE_dig_site_east_01_repair_1", undefined, "info_act", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_roadside_assistance_cs";
    s.ai_interaction = "idle_wreck_crouch_investigate";
    s.var_9a1a6bc9877cfff7 = "-1";
    s.repeat_interaction = "0";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_dig_site_east_01", cf, ( 38120, 30934, 1206 ), ( 0, 303.57, 0 ), "ROADSIDE_ASSISTANCE_dig_site_east_01_repair_3", undefined, "info_act", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_roadside_assistance_cs";
    s.ai_interaction = "idle_wreck_investigate";
    s.var_9a1a6bc9877cfff7 = "-1";
    s.repeat_interaction = "0";
    s.script_delay = "0";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_dig_site_east_01", cf, ( 38172, 30638, 1116 ), ( 0, 78.57, 0 ), "ROADSIDE_ASSISTANCE_dig_site_east_01_repair_2", undefined, "info_act", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_roadside_assistance_cs";
    s.info_act_ref = "ROADSIDE_ASSISTANCE_clifftown_west_01_repair_3";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_clifftown_west_01", cf, ( 31220, 7742, 810 ), ( 0, 312, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_roadside_assistance_cs";
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
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_clifftown_west_01", cf, ( 31268, 8122, 834 ), ( 0, 282.59, 0 ), "ROADSIDE_ASSISTANCE_clifftown_west_01_enc_vol", undefined, "noent_volume_ai_encounter_cs", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_roadside_assistance_cs";
    s.activity_bundle = "sat_ob_activitydef_roadside_assistance";
    s.name = "ROADSIDE_ASSISTANCE_clifftown_west_01";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_clifftown_west_01", cf, ( 31268, 8122, 834 ), ( 0, 282.59, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_roadside_assistance_cs";
    s.info_act_ref = "ROADSIDE_ASSISTANCE_clifftown_west_01_repair_2";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_clifftown_west_01", cf, ( 31144, 8096, 810 ), ( 0, 132, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_roadside_assistance_cs";
    s.info_act_ref = "ROADSIDE_ASSISTANCE_clifftown_west_01_repair_1";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_clifftown_west_01", cf, ( 31528, 8202, 870 ), ( 0, 135, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_roadside_assistance_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_clifftown_west_01", cf, ( 31000, 8320, 790 ), ( 0, 284, 0 ), undefined, "cspf_7_auto6765928612504745703", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_roadside_assistance_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.var_df8f7b8318d59fe5 = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_clifftown_west_01", cf, ( 31354, 8462, 830 ), ( 0, 87.9, 0 ), "cspf_7_auto14916520072416908387", "cspf_7_auto3506096206900994066", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_roadside_assistance_cs";
    s.loop_route = "1";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.var_df8f7b8318d59fe5 = "1";
    s.start_point = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_clifftown_west_01", cf, ( 31020, 8288, 790 ), ( 0, 83.34, 0 ), "cspf_7_auto6765928612504745703", "cspf_7_auto14916520072416908387", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_roadside_assistance_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.var_df8f7b8318d59fe5 = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_clifftown_west_01", cf, ( 31598, 7914, 866 ), ( 0, 262.01, 0 ), "cspf_7_auto3506096206900994066", "cspf_7_auto8524075815580069845", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_roadside_assistance_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.var_df8f7b8318d59fe5 = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_clifftown_west_01", cf, ( 31132, 7826, 806 ), ( 0, 263.13, 0 ), "cspf_7_auto8524075815580069845", "cspf_7_auto6765928612504745703", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_roadside_assistance_cs";
    s.ai_interaction = "idle_wreck_crouch_investigate";
    s.var_9a1a6bc9877cfff7 = "-1";
    s.repeat_interaction = "0";
    s.script_delay = "0";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_clifftown_west_01", cf, ( 31188, 8134, 816 ), ( 0, 12.58, 0 ), "ROADSIDE_ASSISTANCE_clifftown_west_01_repair_1", undefined, "info_act", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_roadside_assistance_cs";
    s.ai_interaction = "idle_wreck_crouch_investigate";
    s.var_9a1a6bc9877cfff7 = "-1";
    s.repeat_interaction = "0";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_clifftown_west_01", cf, ( 31306, 7982, 828 ), ( 0, 117.58, 0 ), "ROADSIDE_ASSISTANCE_clifftown_west_01_repair_3", undefined, "info_act", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_roadside_assistance_cs";
    s.ai_interaction = "idle_wreck_investigate";
    s.var_9a1a6bc9877cfff7 = "-1";
    s.repeat_interaction = "0";
    s.script_delay = "0";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_clifftown_west_01", cf, ( 31288, 8282, 834 ), ( 0, 252.57, 0 ), "ROADSIDE_ASSISTANCE_clifftown_west_01_repair_2", undefined, "info_act", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_roadside_assistance_cs";
    s.info_act_ref = "ROADSIDE_ASSISTANCE_marina_01_repair_3";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_marina_01", cf, ( 6526, 4364, 180 ), ( 0, 225, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_roadside_assistance_cs";
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
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_marina_01", cf, ( 6598, 4216, 224 ), ( 0, 144.59, 0 ), "ROADSIDE_ASSISTANCE_marina_01_enc_vol", undefined, "noent_volume_ai_encounter_cs", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_roadside_assistance_cs";
    s.activity_bundle = "sat_ob_activitydef_roadside_assistance";
    s.name = "ROADSIDE_ASSISTANCE_marina_01";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_marina_01", cf, ( 6598, 4216, 224 ), ( 0, 144.59, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_roadside_assistance_cs";
    s.info_act_ref = "ROADSIDE_ASSISTANCE_marina_01_repair_2";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_marina_01", cf, ( 7038, 4298, 258 ), ( 0, 315, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_roadside_assistance_cs";
    s.info_act_ref = "ROADSIDE_ASSISTANCE_marina_01_repair_1";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_marina_01", cf, ( 6250, 4254, 148 ), ( 0, 315, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_roadside_assistance_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_marina_01", cf, ( 6930, 4248, 278 ), ( 0, 146, 0 ), undefined, "cspf_8_auto6765928612504745703", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_roadside_assistance_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.var_df8f7b8318d59fe5 = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_marina_01", cf, ( 6838, 3982, 306 ), ( 0, 309.9, 0 ), "cspf_8_auto14916520072416908387", "cspf_8_auto3506096206900994066", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_roadside_assistance_cs";
    s.loop_route = "1";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.var_df8f7b8318d59fe5 = "1";
    s.start_point = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_marina_01", cf, ( 6894, 4258, 272 ), ( 0, 305.34, 0 ), "cspf_8_auto6765928612504745703", "cspf_8_auto14916520072416908387", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_roadside_assistance_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.var_df8f7b8318d59fe5 = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_marina_01", cf, ( 6318, 4166, 174 ), ( 0, 124.01, 0 ), "cspf_8_auto3506096206900994066", "cspf_8_auto8524075815580069845", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_roadside_assistance_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.var_df8f7b8318d59fe5 = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_marina_01", cf, ( 6490, 4468, 136 ), ( 0, 125.13, 0 ), "cspf_8_auto8524075815580069845", "cspf_8_auto6765928612504745703", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_roadside_assistance_cs";
    s.ai_interaction = "idle_wreck_crouch_investigate";
    s.var_9a1a6bc9877cfff7 = "-1";
    s.repeat_interaction = "0";
    s.script_delay = "0";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_marina_01", cf, ( 6666, 4260, 230 ), ( 0, 234.58, 0 ), "ROADSIDE_ASSISTANCE_marina_01_repair_1", undefined, "info_act", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_roadside_assistance_cs";
    s.ai_interaction = "idle_wreck_crouch_investigate";
    s.var_9a1a6bc9877cfff7 = "-1";
    s.repeat_interaction = "0";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_marina_01", cf, ( 6476, 4294, 186 ), ( 0, 339.57, 0 ), "ROADSIDE_ASSISTANCE_marina_01_repair_3", undefined, "info_act", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_roadside_assistance_cs";
    s.ai_interaction = "idle_wreck_investigate";
    s.var_9a1a6bc9877cfff7 = "-1";
    s.repeat_interaction = "0";
    s.script_delay = "0";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_marina_01", cf, ( 6690, 4084, 260 ), ( 0, 114.57, 0 ), "ROADSIDE_ASSISTANCE_marina_01_repair_2", undefined, "info_act", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace mp_sat_avalon_q2_ob_activity_roadside_assistance_cs
// Params 0, eflags: 0x4
// Checksum 0xf8b289b2, Offset: 0x6281
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace mp_sat_avalon_q2_ob_activity_roadside_assistance_cs
// Params 0
// Checksum 0x8e14cb17, Offset: 0x628b
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "mp_sat_avalon_q2_ob_activity_roadside_assistance_cs" );
}

// Namespace mp_sat_avalon_q2_ob_activity_roadside_assistance_cs
// Params 0
// Checksum 0xc48eacf0, Offset: 0x62a1
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

// Namespace mp_sat_avalon_q2_ob_activity_roadside_assistance_cs
// Params 4
// Checksum 0x43b0c80f, Offset: 0x6310
// Size: 0x10d
function function_d4323822d7042e5a( var_4312b79c960726b6, fe, us, cf = "mp_sat_avalon_q2_ob_activity_roadside_assistance_cs" )
{
    switch ( var_4312b79c960726b6 )
    {
        case #"hash_54ab2d8b4130dc48":
            function_79c63985630257d0( fe, us, cf );
            break;
        case #"hash_11c1987ec07a782a":
            function_6db0479ade975492( fe, us, cf );
            break;
        case #"hash_4b275c0e2a2bb246":
            function_8108b1d611931be( fe, us, cf );
            break;
        case #"hash_db6dba56a9a478b6":
            function_4dac3f0e0af8f65e( fe, us, cf );
            break;
        case #"hash_be67297d0c5c6fa2":
            function_c9b00af10cb9a05a( fe, us, cf );
            break;
        case #"hash_2f203c95e9d3e722":
            function_b4d05b6a10f378ea( fe, us, cf );
            break;
        case #"hash_a8f3ed6013c9b08c":
            function_3a401da25242aa74( fe, us, cf );
            break;
        case #"hash_9b3b8c5d0ed9fea6":
            function_1cca743629ecf6ce( fe, us, cf );
            break;
    }
}

// Namespace mp_sat_avalon_q2_ob_activity_roadside_assistance_cs
// Params 3
// Checksum 0xa92e754b, Offset: 0x6425
// Size: 0x187
function function_79c63985630257d0( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_roadside_assistance_cs";
    s.name = "teleport_location";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_winery_01", cf, ( 18154, 45018, 1398 ), ( 0, 84.59, 0 ), "`", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_roadside_assistance_cs";
    s.name = "cargo";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_winery_01", cf, ( 17910, 44446, 830 ), ( 0, 132.59, 0 ), "ROADSIDE_ASSISTANCE_winery_01_cargo", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_roadside_assistance_cs";
    s.name = "vehicle";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_winery_01", cf, ( 17820, 44542, 822 ), ( 0, 132.59, 0 ), "ROADSIDE_ASSISTANCE_winery_01_vehicle", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_sat_avalon_q2_ob_activity_roadside_assistance_cs
// Params 3
// Checksum 0x8ca3c865, Offset: 0x65b4
// Size: 0x187
function function_6db0479ade975492( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_roadside_assistance_cs";
    s.name = "teleport_location";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_clifftown_east_01", cf, ( 50206, 11602, 1177.74 ), ( 0, 174.59, 0 ), "`", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_roadside_assistance_cs";
    s.name = "cargo";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_clifftown_east_01", cf, ( 50814, 11418, 1170 ), ( 0, 240.59, 0 ), "ROADSIDE_ASSISTANCE_clifftown_east_01_cargo", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_roadside_assistance_cs";
    s.name = "vehicle";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_clifftown_east_01", cf, ( 50750, 11302, 1184 ), ( 0, 240.59, 0 ), "ROADSIDE_ASSISTANCE_clifftown_east_01_vehicle", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_sat_avalon_q2_ob_activity_roadside_assistance_cs
// Params 3
// Checksum 0x3c0a0676, Offset: 0x6743
// Size: 0x187
function function_8108b1d611931be( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_roadside_assistance_cs";
    s.name = "teleport_location";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_winery_south_01", cf, ( 21022, 34170, 2316 ), ( 0, 174.59, 0 ), "`", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_roadside_assistance_cs";
    s.name = "cargo";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_winery_south_01", cf, ( 21662, 33988, 2308 ), ( 0, 164.59, 0 ), "ROADSIDE_ASSISTANCE_winery_south_01_cargo", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_roadside_assistance_cs";
    s.name = "vehicle";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_winery_south_01", cf, ( 21534, 34022, 2316 ), ( 0, 164.59, 0 ), "ROADSIDE_ASSISTANCE_winery_south_01_vehicle", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_sat_avalon_q2_ob_activity_roadside_assistance_cs
// Params 3
// Checksum 0xa0ffc081, Offset: 0x68d2
// Size: 0x187
function function_4dac3f0e0af8f65e( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_roadside_assistance_cs";
    s.name = "teleport_location";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_winery_west_01", cf, ( 1734, 37570, 1398 ), ( 0, 174.59, 0 ), "`", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_roadside_assistance_cs";
    s.name = "cargo";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_winery_west_01", cf, ( 2286, 37446, 736 ), ( 0, 240.59, 0 ), "ROADSIDE_ASSISTANCE_winery_west_01_cargo", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_roadside_assistance_cs";
    s.name = "vehicle";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_winery_west_01", cf, ( 2222, 37330, 750 ), ( 0, 240.59, 0 ), "ROADSIDE_ASSISTANCE_winery_west_01_vehicle", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_sat_avalon_q2_ob_activity_roadside_assistance_cs
// Params 3
// Checksum 0xaf7854ed, Offset: 0x6a61
// Size: 0x187
function function_c9b00af10cb9a05a( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_roadside_assistance_cs";
    s.name = "teleport_location";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_beach_resorts_east_01", cf, ( 24686, 20530, 2316 ), ( 0, 174.59, 0 ), "`", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_roadside_assistance_cs";
    s.name = "cargo";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_beach_resorts_east_01", cf, ( 25410, 19922, 702 ), ( 0, 108.59, 0 ), "ROADSIDE_ASSISTANCE_beach_resorts_east_01_cargo", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_roadside_assistance_cs";
    s.name = "vehicle";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_beach_resorts_east_01", cf, ( 25366, 20048, 702 ), ( 0, 108.59, 0 ), "ROADSIDE_ASSISTANCE_beach_resorts_east_01_vehicle", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_sat_avalon_q2_ob_activity_roadside_assistance_cs
// Params 3
// Checksum 0x2df32994, Offset: 0x6bf0
// Size: 0x187
function function_b4d05b6a10f378ea( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_roadside_assistance_cs";
    s.name = "teleport_location";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_dig_site_east_01", cf, ( 37494, 31282, 1350 ), ( 0, 174.59, 0 ), "`", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_roadside_assistance_cs";
    s.name = "cargo";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_dig_site_east_01", cf, ( 38218, 30674, 1124 ), ( 0, 108.59, 0 ), "ROADSIDE_ASSISTANCE_dig_site_east_01_cargo", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_roadside_assistance_cs";
    s.name = "vehicle";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_dig_site_east_01", cf, ( 38174, 30800, 1160 ), ( 343.96, 109.19, -2.18 ), "ROADSIDE_ASSISTANCE_dig_site_east_01_vehicle", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_sat_avalon_q2_ob_activity_roadside_assistance_cs
// Params 3
// Checksum 0xac1f08e0, Offset: 0x6d7f
// Size: 0x187
function function_3a401da25242aa74( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_roadside_assistance_cs";
    s.name = "teleport_location";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_clifftown_west_01", cf, ( 30678, 8578, 790 ), ( 0, 174.59, 0 ), "`", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_roadside_assistance_cs";
    s.name = "cargo";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_clifftown_west_01", cf, ( 31238, 8250, 824 ), ( 0, 282.59, 0 ), "ROADSIDE_ASSISTANCE_clifftown_west_01_cargo", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_roadside_assistance_cs";
    s.name = "vehicle";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_clifftown_west_01", cf, ( 31268, 8122, 834 ), ( 0, 282.59, 0 ), "ROADSIDE_ASSISTANCE_clifftown_west_01_vehicle", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_sat_avalon_q2_ob_activity_roadside_assistance_cs
// Params 3
// Checksum 0xa3bc7cae, Offset: 0x6f0e
// Size: 0x187
function function_1cca743629ecf6ce( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_roadside_assistance_cs";
    s.name = "teleport_location";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_marina_01", cf, ( 7390, 4184, 334 ), ( 0, 36.59, 0 ), "`", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_roadside_assistance_cs";
    s.name = "cargo";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_marina_01", cf, ( 6706, 4142, 262 ), ( 0, 144.59, 0 ), "ROADSIDE_ASSISTANCE_marina_01_cargo", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_roadside_assistance_cs";
    s.name = "vehicle";
    fe [[ f ]]( s, "ROADSIDE_ASSISTANCE_marina_01", cf, ( 6598, 4216, 222 ), ( 16.01, 144.42, -0.59 ), "ROADSIDE_ASSISTANCE_marina_01_vehicle", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_sat_avalon_q2_ob_activity_roadside_assistance_cs
// Params 0
// Checksum 0xd019b9e4, Offset: 0x709d
// Size: 0x4c1
function function_d9dd7965c51c95d1()
{
    activityinstances = [];
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_ob_activitydef_roadside_assistance";
    var_881289d7987bc770.cf = "mp_sat_avalon_q2_ob_activity_roadside_assistance_cs";
    var_881289d7987bc770.scriptstructorigin = ( 17820, 44542, 822 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [];
    var_881289d7987bc770.var_31ce4477e3543d24 = [];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [];
    var_881289d7987bc770.locationradius = [];
    activityinstances[ "ROADSIDE_ASSISTANCE_winery_01" ] = var_881289d7987bc770;
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_ob_activitydef_roadside_assistance";
    var_881289d7987bc770.cf = "mp_sat_avalon_q2_ob_activity_roadside_assistance_cs";
    var_881289d7987bc770.scriptstructorigin = ( 50750, 11302, 1184 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [];
    var_881289d7987bc770.var_31ce4477e3543d24 = [];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [];
    var_881289d7987bc770.locationradius = [];
    activityinstances[ "ROADSIDE_ASSISTANCE_clifftown_east_01" ] = var_881289d7987bc770;
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_ob_activitydef_roadside_assistance";
    var_881289d7987bc770.cf = "mp_sat_avalon_q2_ob_activity_roadside_assistance_cs";
    var_881289d7987bc770.scriptstructorigin = ( 21534, 34022, 2316 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [];
    var_881289d7987bc770.var_31ce4477e3543d24 = [];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [];
    var_881289d7987bc770.locationradius = [];
    activityinstances[ "ROADSIDE_ASSISTANCE_winery_south_01" ] = var_881289d7987bc770;
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_ob_activitydef_roadside_assistance";
    var_881289d7987bc770.cf = "mp_sat_avalon_q2_ob_activity_roadside_assistance_cs";
    var_881289d7987bc770.scriptstructorigin = ( 2222, 37330, 750 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [];
    var_881289d7987bc770.var_31ce4477e3543d24 = [];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [];
    var_881289d7987bc770.locationradius = [];
    activityinstances[ "ROADSIDE_ASSISTANCE_winery_west_01" ] = var_881289d7987bc770;
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_ob_activitydef_roadside_assistance";
    var_881289d7987bc770.cf = "mp_sat_avalon_q2_ob_activity_roadside_assistance_cs";
    var_881289d7987bc770.scriptstructorigin = ( 25366, 20048, 702 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [];
    var_881289d7987bc770.var_31ce4477e3543d24 = [];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [];
    var_881289d7987bc770.locationradius = [];
    activityinstances[ "ROADSIDE_ASSISTANCE_beach_resorts_east_01" ] = var_881289d7987bc770;
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_ob_activitydef_roadside_assistance";
    var_881289d7987bc770.cf = "mp_sat_avalon_q2_ob_activity_roadside_assistance_cs";
    var_881289d7987bc770.scriptstructorigin = ( 38174, 30800, 1162 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [];
    var_881289d7987bc770.var_31ce4477e3543d24 = [];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [];
    var_881289d7987bc770.locationradius = [];
    activityinstances[ "ROADSIDE_ASSISTANCE_dig_site_east_01" ] = var_881289d7987bc770;
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_ob_activitydef_roadside_assistance";
    var_881289d7987bc770.cf = "mp_sat_avalon_q2_ob_activity_roadside_assistance_cs";
    var_881289d7987bc770.scriptstructorigin = ( 31268, 8122, 834 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [];
    var_881289d7987bc770.var_31ce4477e3543d24 = [];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [];
    var_881289d7987bc770.locationradius = [];
    activityinstances[ "ROADSIDE_ASSISTANCE_clifftown_west_01" ] = var_881289d7987bc770;
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_ob_activitydef_roadside_assistance";
    var_881289d7987bc770.cf = "mp_sat_avalon_q2_ob_activity_roadside_assistance_cs";
    var_881289d7987bc770.scriptstructorigin = ( 6598, 4216, 224 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [];
    var_881289d7987bc770.var_31ce4477e3543d24 = [];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [];
    var_881289d7987bc770.locationradius = [];
    activityinstances[ "ROADSIDE_ASSISTANCE_marina_01" ] = var_881289d7987bc770;
    return activityinstances;
}

