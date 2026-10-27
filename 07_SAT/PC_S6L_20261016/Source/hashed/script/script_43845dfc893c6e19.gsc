// script_43845dfc893c6e19  (hash_43845dfc893c6e19.gscc) (size: 21805 Bytes / 0x552d / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xe0568cb0 (3763768496)
// size ...... 21805 (0x552d)
// includes .. 4   (offset: 0x4805)
// strings ... 85  (offset: 0x4825)
// dev strs .. 0   (offset: 0x552d)
// exports ... 14  (offset: 0x42d9)
// cseg ...... 0x981 + 0x3958 (0x42d9)
// imports ... 27  (offset: 0x4509)
// animtree1 . 0   (offset: 0x552d)
// animtree2 . 0   (offset: 0x552d)
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace mp_sat_avalon_q2_ob_activity_prime_target_cs;

// Namespace mp_sat_avalon_q2_ob_activity_prime_target_cs
// Params 0, eflags: 0x5
// Checksum 0x9c6bae3d, Offset: 0x99f
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"mp_sat_avalon_q2_ob_activity_prime_target_cs", #"activity_common", &function_b39ecd3d51489472, undefined );
}

// Namespace mp_sat_avalon_q2_ob_activity_prime_target_cs
// Params 0, eflags: 0x4
// Checksum 0x5162557c, Offset: 0x9c8
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace mp_sat_avalon_q2_ob_activity_prime_target_cs
// Params 0, eflags: 0x4
// Checksum 0xd4598690, Offset: 0x9d9
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace mp_sat_avalon_q2_ob_activity_prime_target_cs
// Params 2
// Checksum 0x92fb9cb4, Offset: 0x9ea
// Size: 0x8c
function main( unused, unused2 )
{
    if ( utility::flag_exist( "mp_sat_avalon_q2_ob_activity_prime_target_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "mp_sat_avalon_q2_ob_activity_prime_target_cs" ) )
    {
        return;
    }
    
    activity_common::function_e1df676808c1d1e3( &function_4cd78e661617f3 );
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "mp_sat_avalon_q2_ob_activity_prime_target_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "mp_sat_avalon_q2_ob_activity_prime_target_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace mp_sat_avalon_q2_ob_activity_prime_target_cs
// Params 3, eflags: 0x4
// Checksum 0x57db325f, Offset: 0xa7e
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "mp_sat_avalon_q2_ob_activity_prime_target_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "mp_sat_avalon_q2_ob_activity_prime_target_cs" );
}

// Namespace mp_sat_avalon_q2_ob_activity_prime_target_cs
// Params 3, eflags: 0x4
// Checksum 0x2817c48, Offset: 0xaf8
// Size: 0x3421
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_prime_target_cs";
    s.activity_bundle = "sat_ob_activitydefinition_primetarget";
    s.name = "PRIME_TARGET_MARKET";
    fe [[ f ]]( s, "PRIME_TARGET_MARKET", cf, ( 1263.8, 30989.2, 1264 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_prime_target_cs";
    s._size_max = ( 1252, 1756, 200 );
    s._size_min = ( 1180, 1500, 200 );
    s.var_5afd49978f924648 = "1";
    s.var_a8568d8e0b0b6076 = "1";
    s.var_3f3960eb7318312d = "1";
    s.default_goal_radius = "-1";
    s.height = 128;
    s.length = "128";
    s.name = "encounter_volume_guards";
    s.script_stealthgroup = "-1";
    s.script_string = "enc_prime_target_guards";
    s.var_95e2cee7aca5aaae = "1";
    s.width = "128";
    fe [[ f ]]( s, "PRIME_TARGET_MARKET", cf, ( 2022.92, 31046.1, 1054.85 ), ( 0, 0, 0 ), "PRIME_TARGET_MARKET_enc_vol", undefined, "noent_volume_ai_encounter_cs", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_prime_target_cs";
    s._size_max = ( 590, 892, 210 );
    s._size_min = ( 1038, 844, 200 );
    s.var_5afd49978f924648 = "1";
    s.var_a8568d8e0b0b6076 = "0";
    s.var_3f3960eb7318312d = "0";
    s.default_goal_radius = "-1";
    s.height = 128;
    s.length = "128";
    s.name = "encounter_volume_boss";
    s.script_stealthgroup = "-1";
    s.script_string = "enc_prime_target_boss";
    s.var_95e2cee7aca5aaae = "1";
    s.width = "128";
    fe [[ f ]]( s, "PRIME_TARGET_MARKET", cf, ( 1925.79, 30784.2, 990.85 ), ( 0, 0, 0 ), "PRIME_TARGET_MARKET_boss_enc_vol", undefined, "noent_volume_ai_encounter_cs", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_prime_target_cs";
    s._size_max = ( 1274, 1154, 930 );
    s._size_min = ( 1330, 1322, 200 );
    s.var_5afd49978f924648 = "1";
    s.var_a8568d8e0b0b6076 = "0";
    s.var_3f3960eb7318312d = "1";
    s.default_goal_radius = "-1";
    s.height = 128;
    s.length = "128";
    s.name = "encounter_volume_reinforcements";
    s.script_stealthgroup = "-1";
    s.script_string = "enc_prime_target_reinforcements";
    s.var_95e2cee7aca5aaae = "1";
    s.width = "128";
    fe [[ f ]]( s, "PRIME_TARGET_MARKET", cf, ( 1934.52, 30707.8, 1046.85 ), ( 0, 0, 0 ), "PRIME_TARGET_MARKET_reinforcement_enc_vol", undefined, "noent_volume_ai_encounter_cs", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_prime_target_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "PRIME_TARGET_MARKET", cf, ( 1600, 30904, 1022.85 ), ( 0, 0, 0 ), "cspf_1_auto2891537018317027543", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_prime_target_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.reverse_route = "1";
    s.start_point = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "PRIME_TARGET_MARKET", cf, ( 1584, 30344, 1022.84 ), ( 0, 0, 0 ), "cspf_1_auto16654063839022466926", "cspf_1_auto2891537018317027543", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_prime_target_cs";
    s.location_spawnpoint = "0";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.name = "spawnpoint_boss";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "boss";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "PRIME_TARGET_MARKET", cf, ( 2340, 30557, 1022.86 ), ( 0, 278.94, 0 ), undefined, "cspf_1_auto2309035334403970407", "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_prime_target_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "PRIME_TARGET_MARKET", cf, ( 2360, 30368, 1024 ), ( 0, 0, 0 ), "cspf_1_auto14852260711424473435", "cspf_1_auto2942792952397200159", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_prime_target_cs";
    s.loop_route = "1";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.start_point = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "PRIME_TARGET_MARKET", cf, ( 2376, 30584, 1024 ), ( 0, 0, 0 ), "cspf_1_auto2309035334403970407", "cspf_1_auto14852260711424473435", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_prime_target_cs";
    s.info_act_ref = "pt_market_idle_stretch_02";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "PRIME_TARGET_MARKET", cf, ( 1640, 31736, 1096 ), ( 0, 0, 0 ), "cspf_1_auto15788386923317566026", "cspf_1_auto888956845678709015", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_prime_target_cs";
    s.loop_route = "1";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.start_point = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "PRIME_TARGET_MARKET", cf, ( 2672, 31744, 1096 ), ( 0, 0, 0 ), "cspf_1_auto16125577633983813005", "cspf_1_auto15788386923317566026", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_prime_target_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "PRIME_TARGET_MARKET", cf, ( 1632, 32304, 1096 ), ( 0, 0, 0 ), "cspf_1_auto888956845678709015", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_prime_target_cs";
    s.info_act_ref = "pt_market_idle_smoke_01";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "PRIME_TARGET_MARKET", cf, ( 1144, 30824, 1023.66 ), ( 0, 0, 0 ), "cspf_1_auto10315055643774403954", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_prime_target_cs";
    s.location_spawnpoint = "0";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.name = "spawnpoint_guard";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "PRIME_TARGET_MARKET", cf, ( 2636, 31677, 1096 ), ( 0, 278.94, 0 ), undefined, "cspf_1_auto16125577633983813005", "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_prime_target_cs";
    s.location_spawnpoint = "0";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.name = "spawnpoint_guard";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "PRIME_TARGET_MARKET", cf, ( 1460, 31357, 1022.85 ), ( 0, 278.94, 0 ), undefined, "cspf_1_auto12497173744007075338", "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_prime_target_cs";
    s.location_spawnpoint = "0";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.name = "spawnpoint_guard";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "PRIME_TARGET_MARKET", cf, ( 1604, 30381, 1022.84 ), ( 0, 278.94, 0 ), undefined, "cspf_1_auto16654063839022466926", "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_prime_target_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.reverse_route = "1";
    s.start_point = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "PRIME_TARGET_MARKET", cf, ( 2224, 30144, 1024 ), ( 0, 0, 0 ), "cspf_1_auto4256245229637977618", "cspf_1_auto15810318258153242011", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_prime_target_cs";
    s.location_spawnpoint = "0";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.name = "spawnpoint_guard";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "prime_target_guards";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "PRIME_TARGET_MARKET", cf, ( 2260, 30125, 1024 ), ( 0, 278.94, 0 ), undefined, "cspf_1_auto4256245229637977618", "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_prime_target_cs";
    fe [[ f ]]( s, "PRIME_TARGET_MARKET", cf, ( 1384.6, 30744, 1144 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Proximity_Join_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 1920 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_prime_target_cs";
    s.location_spawnpoint = "0";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.name = "spawnpoint_guard";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "PRIME_TARGET_MARKET", cf, ( 1148, 31037, 1022.84 ), ( 0, 278.94, 0 ), undefined, "cspf_1_auto8238808123437051795", "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_prime_target_cs";
    s.info_act_ref = "pt_market_idle_stretch_01";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "PRIME_TARGET_MARKET", cf, ( 1208, 30144, 1050.5 ), ( 0, 0, 0 ), "cspf_1_auto15810318258153242011", "cspf_1_auto10315055643774403954", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_prime_target_cs";
    s.ai_interaction = "idle_stretching";
    s.var_9a1a6bc9877cfff7 = "-1";
    s.repeat_interaction = "0";
    s.script_delay_max = "25";
    s.script_delay_min = "10";
    fe [[ f ]]( s, "PRIME_TARGET_MARKET", cf, ( 1224, 30160, 1022.27 ), ( 0, 45, 0 ), "pt_market_idle_stretch_01", undefined, "info_act", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_prime_target_cs";
    s.ai_interaction = "idle_smoke";
    s.var_9a1a6bc9877cfff7 = "-1";
    s.repeat_interaction = "0";
    s.script_delay_max = "25";
    s.script_delay_min = "10";
    fe [[ f ]]( s, "PRIME_TARGET_MARKET", cf, ( 1128, 30848, 1024.55 ), ( 0, 225, 0 ), "pt_market_idle_smoke_01", undefined, "info_act", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_prime_target_cs";
    s.ai_interaction = "idle_stretching";
    s.var_9a1a6bc9877cfff7 = "-1";
    s.repeat_interaction = "0";
    s.script_delay_max = "25";
    s.script_delay_min = "10";
    fe [[ f ]]( s, "PRIME_TARGET_MARKET", cf, ( 1600, 31704, 1096 ), ( 0, 225, 0 ), "pt_market_idle_stretch_02", undefined, "info_act", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_prime_target_cs";
    s.ai_interaction = "idle_smoke";
    s.var_9a1a6bc9877cfff7 = "-1";
    s.repeat_interaction = "0";
    s.script_delay_max = "25";
    s.script_delay_min = "10";
    fe [[ f ]]( s, "PRIME_TARGET_MARKET", cf, ( 1232, 30680, 1296 ), ( 0, 45, 0 ), "pt_market_idle_smoke_02", undefined, "info_act", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_prime_target_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.reverse_route = "1";
    s.start_point = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "PRIME_TARGET_MARKET", cf, ( 1160, 31040, 1022.84 ), ( 0, 0, 0 ), "cspf_1_auto8238808123437051795", "cspf_1_auto6519404033834096272", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_prime_target_cs";
    s.info_act_ref = "pt_market_idle_smoke_02";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "PRIME_TARGET_MARKET", cf, ( 2192, 31032, 1022.87 ), ( 0, 0, 0 ), "cspf_1_auto6519404033834096272", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_prime_target_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "PRIME_TARGET_MARKET", cf, ( 2384, 31432, 1024 ), ( 0, 0, 0 ), "cspf_1_auto11954216901148840626", "cspf_1_auto6703425262405207974", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_prime_target_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.reverse_route = "1";
    s.start_point = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "PRIME_TARGET_MARKET", cf, ( 1448, 31400, 1024 ), ( 0, 0, 0 ), "cspf_1_auto12497173744007075338", "cspf_1_auto11954216901148840626", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_prime_target_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "PRIME_TARGET_MARKET", cf, ( 2384, 30648, 1024 ), ( 0, 0, 0 ), "cspf_1_auto6703425262405207974", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_prime_target_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "PRIME_TARGET_MARKET", cf, ( 2888, 30360, 1024 ), ( 0, 0, 0 ), "cspf_1_auto2942792952397200159", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_prime_target_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "PRIME_TARGET_DIGSITE", cf, ( 29103.5, 30272.2, 3163.38 ), ( 0, 150, 0 ), "cspf_2_auto2466512117732693697", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_prime_target_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.reverse_route = "1";
    s.start_point = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "PRIME_TARGET_DIGSITE", cf, ( 29755.2, 30599.5, 3160.69 ), ( 0, 90, 0 ), "cspf_2_auto8276900732559074991", "cspf_2_auto2466512117732693697", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_prime_target_cs";
    s.activity_bundle = "sat_ob_activitydefinition_primetarget";
    s.name = "PRIME_TARGET_DIGSITE";
    fe [[ f ]]( s, "PRIME_TARGET_DIGSITE", cf, ( 29115.8, 30962.5, 3505.65 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_prime_target_cs";
    s._size_max = ( 870, 1004, 590 );
    s._size_min = ( 1210, 1120, 602 );
    s.var_5afd49978f924648 = "1";
    s.var_a8568d8e0b0b6076 = "1";
    s.var_3f3960eb7318312d = "1";
    s.default_goal_radius = "-1";
    s.height = 128;
    s.length = "128";
    s.name = "encounter_volume_guards";
    s.script_stealthgroup = "-1";
    s.script_string = "enc_prime_target_guards";
    s.var_95e2cee7aca5aaae = "1";
    s.width = "128";
    fe [[ f ]]( s, "PRIME_TARGET_DIGSITE", cf, ( 29058.9, 31171.4, 3448.5 ), ( 0, 0, 0 ), "PRIME_TARGET_DIGSITE_enc_vol", undefined, "noent_volume_ai_encounter_cs", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_prime_target_cs";
    s._size_max = ( 346, 422, 210 );
    s._size_min = ( 384, 412, 200 );
    s.var_5afd49978f924648 = "1";
    s.var_a8568d8e0b0b6076 = "0";
    s.var_3f3960eb7318312d = "0";
    s.default_goal_radius = "-1";
    s.height = 128;
    s.length = "128";
    s.name = "encounter_volume_boss";
    s.script_stealthgroup = "-1";
    s.script_string = "enc_prime_target_boss";
    s.var_95e2cee7aca5aaae = "1";
    s.width = "128";
    fe [[ f ]]( s, "PRIME_TARGET_DIGSITE", cf, ( 29425.8, 30413.5, 3216.49 ), ( 0, 115, 0 ), "PRIME_TARGET_DIGSITE_boss_enc_vol", undefined, "noent_volume_ai_encounter_cs", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_prime_target_cs";
    s._size_max = ( 1028, 610, 748 );
    s._size_min = ( 734, 424, 606 );
    s.var_5afd49978f924648 = "1";
    s.var_a8568d8e0b0b6076 = "0";
    s.var_3f3960eb7318312d = "1";
    s.default_goal_radius = "-1";
    s.height = 128;
    s.length = "128";
    s.name = "encounter_volume_reinforcements";
    s.script_stealthgroup = "-1";
    s.script_string = "enc_prime_target_reinforcements";
    s.var_95e2cee7aca5aaae = "1";
    s.width = "128";
    fe [[ f ]]( s, "PRIME_TARGET_DIGSITE", cf, ( 28930.5, 30925.1, 3412.5 ), ( 0, 0, 0 ), "PRIME_TARGET_DIGSITE_reinforcement_enc_vol", undefined, "noent_volume_ai_encounter_cs", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_prime_target_cs";
    s.height = 512;
    fe [[ f ]]( s, "PRIME_TARGET_DIGSITE", cf, ( 28948.6, 30997.3, 2979.02 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Proximity_Join_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 1920 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_prime_target_cs";
    s.ai_interaction = "idle_stretching";
    s.var_9a1a6bc9877cfff7 = "-1";
    s.repeat_interaction = "0";
    s.script_delay_max = "25";
    s.script_delay_min = "10";
    fe [[ f ]]( s, "PRIME_TARGET_DIGSITE", cf, ( 28472.5, 30511.2, 3167.12 ), ( 0, 45, 0 ), "pt_digsite_idle_stretch_01", undefined, "info_act", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_prime_target_cs";
    s.ai_interaction = "idle_smoke";
    s.var_9a1a6bc9877cfff7 = "-1";
    s.repeat_interaction = "0";
    s.script_delay_max = "25";
    s.script_delay_min = "10";
    fe [[ f ]]( s, "PRIME_TARGET_DIGSITE", cf, ( 28333, 30883.3, 3167 ), ( 0, 105, 0 ), "pt_digsite_idle_smoke_01", undefined, "info_act", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_prime_target_cs";
    s.ai_interaction = "idle_stretching";
    s.var_9a1a6bc9877cfff7 = "-1";
    s.repeat_interaction = "0";
    s.script_delay_max = "25";
    s.script_delay_min = "10";
    fe [[ f ]]( s, "PRIME_TARGET_DIGSITE", cf, ( 29760.1, 31586.3, 3063.14 ), ( 0, 255, 0 ), "pt_digsite_idle_stretch_02", undefined, "info_act", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_prime_target_cs";
    s.ai_interaction = "idle_smoke";
    s.var_9a1a6bc9877cfff7 = "-1";
    s.repeat_interaction = "0";
    s.script_delay_max = "25";
    s.script_delay_min = "10";
    fe [[ f ]]( s, "PRIME_TARGET_DIGSITE", cf, ( 28669, 31020.8, 3165.78 ), ( 0, 345, 0 ), "pt_digsite_idle_smoke_02", undefined, "info_act", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_prime_target_cs";
    s.location_spawnpoint = "0";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.name = "spawnpoint_boss";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "boss";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "PRIME_TARGET_DIGSITE", cf, ( 29818.1, 30646.9, 3163.87 ), ( 0, 278.94, 0 ), undefined, "cspf_2_auto8276900732559074991", "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_prime_target_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "PRIME_TARGET_DIGSITE", cf, ( 29398.6, 31212.5, 2973.67 ), ( 0, 0, 0 ), "cspf_2_auto14964606970242146705", "cspf_2_auto1371199067725866738", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_prime_target_cs";
    s.loop_route = "1";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.start_point = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "PRIME_TARGET_DIGSITE", cf, ( 29042.5, 31168.9, 2975.83 ), ( 0, 0, 0 ), "cspf_2_auto11845841627666279353", "cspf_2_auto14964606970242146705", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_prime_target_cs";
    s.info_act_ref = "pt_digsite_idle_stretch_02";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "PRIME_TARGET_DIGSITE", cf, ( 29776.1, 31618.3, 3063.63 ), ( 0, 0, 0 ), "cspf_2_auto2118265003986295784", "cspf_2_auto15488002165689632967", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_prime_target_cs";
    s.loop_route = "1";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.start_point = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "PRIME_TARGET_DIGSITE", cf, ( 29414.3, 31505.7, 3149.3 ), ( 0, 300, 0 ), "cspf_2_auto17815678945600064774", "cspf_2_auto2118265003986295784", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_prime_target_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "PRIME_TARGET_DIGSITE", cf, ( 29702.1, 31283.2, 3071.97 ), ( 0, 0, 0 ), "cspf_2_auto15488002165689632967", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_prime_target_cs";
    s.info_act_ref = "pt_digsite_idle_smoke_01";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "PRIME_TARGET_DIGSITE", cf, ( 28349, 30859.3, 3167 ), ( 0, 0, 0 ), "cspf_2_auto16577339658983209668", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_prime_target_cs";
    s.location_spawnpoint = "0";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.name = "spawnpoint_guard";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "PRIME_TARGET_DIGSITE", cf, ( 29378.3, 31478.7, 3149.3 ), ( 0, 278.94, 0 ), undefined, "cspf_2_auto17815678945600064774", "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_prime_target_cs";
    s.location_spawnpoint = "0";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.name = "spawnpoint_guard";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "PRIME_TARGET_DIGSITE", cf, ( 29703.9, 30844.3, 3077 ), ( 0, 278.94, 0 ), undefined, "cspf_2_auto13460498477012824736", "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_prime_target_cs";
    s.location_spawnpoint = "0";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.name = "spawnpoint_guard";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "PRIME_TARGET_DIGSITE", cf, ( 28988.6, 31147.7, 2974.08 ), ( 0, 278.94, 0 ), undefined, "cspf_2_auto11845841627666279353", "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_prime_target_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.reverse_route = "1";
    s.start_point = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "PRIME_TARGET_DIGSITE", cf, ( 28831.1, 30370.1, 3072 ), ( 0, 45, 0 ), "cspf_2_auto5091100592046796756", "cspf_2_auto3277439383112133971", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_prime_target_cs";
    s.location_spawnpoint = "0";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.name = "spawnpoint_guard";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "prime_target_guards";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "PRIME_TARGET_DIGSITE", cf, ( 28795.1, 30383.1, 3072 ), ( 0, 53.94, 0 ), undefined, "cspf_2_auto5091100592046796756", "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_prime_target_cs";
    s.location_spawnpoint = "0";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.name = "spawnpoint_guard";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "PRIME_TARGET_DIGSITE", cf, ( 28518.1, 31441.4, 3166.48 ), ( 0, 278.94, 0 ), undefined, "cspf_2_auto15687204509656780688", "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_prime_target_cs";
    s.info_act_ref = "pt_digsite_idle_stretch_01";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "PRIME_TARGET_DIGSITE", cf, ( 28456.5, 30495.2, 3168.41 ), ( 0, 0, 0 ), "cspf_2_auto3277439383112133971", "cspf_2_auto16577339658983209668", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_prime_target_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.reverse_route = "1";
    s.start_point = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "PRIME_TARGET_DIGSITE", cf, ( 28530.1, 31444.4, 3164.95 ), ( 0, 0, 0 ), "cspf_2_auto15687204509656780688", "cspf_2_auto14953445625591015105", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_prime_target_cs";
    s.info_act_ref = "pt_digsite_idle_smoke_02";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "PRIME_TARGET_DIGSITE", cf, ( 28524.1, 31005, 3167 ), ( 0, 0, 0 ), "cspf_2_auto14953445625591015105", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_prime_target_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "PRIME_TARGET_DIGSITE", cf, ( 29795.6, 31054.4, 3067.14 ), ( 0, 0, 0 ), "cspf_2_auto16056316551191153285", "cspf_2_auto12465656614736568910", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_prime_target_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.reverse_route = "1";
    s.start_point = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "PRIME_TARGET_DIGSITE", cf, ( 29691.9, 30887.3, 3068.12 ), ( 0, 195, 0 ), "cspf_2_auto13460498477012824736", "cspf_2_auto16056316551191153285", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_prime_target_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "PRIME_TARGET_DIGSITE", cf, ( 30052.7, 31247, 3069.5 ), ( 0, 0, 0 ), "cspf_2_auto12465656614736568910", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_prime_target_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "PRIME_TARGET_DIGSITE", cf, ( 29446.6, 30780.5, 2977.5 ), ( 0, 0, 0 ), "cspf_2_auto1371199067725866738", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace mp_sat_avalon_q2_ob_activity_prime_target_cs
// Params 0, eflags: 0x4
// Checksum 0x857f28f9, Offset: 0x3f21
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace mp_sat_avalon_q2_ob_activity_prime_target_cs
// Params 0
// Checksum 0x9588ef12, Offset: 0x3f2b
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "mp_sat_avalon_q2_ob_activity_prime_target_cs" );
}

// Namespace mp_sat_avalon_q2_ob_activity_prime_target_cs
// Params 0
// Checksum 0xf399351f, Offset: 0x3f41
// Size: 0x66
function function_4cd78e661617f3()
{
    activityinfostruct = {};
    activityinfostruct.name = "REV_OB_PRIME_TARGET";
    activityinfostruct.scriptbundle = "sat_ob_activitydefinition_primetarget";
    activityinfostruct.mainfunction = &main;
    activityinfostruct.var_934f068483ae4ddb = &function_d4323822d7042e5a;
    activityinfostruct.metadatafunction = &function_d9dd7965c51c95d1;
    return activityinfostruct;
}

// Namespace mp_sat_avalon_q2_ob_activity_prime_target_cs
// Params 4
// Checksum 0xea5081e6, Offset: 0x3fb0
// Size: 0x71
function function_d4323822d7042e5a( var_4312b79c960726b6, fe, us, cf = "mp_sat_avalon_q2_ob_activity_prime_target_cs" )
{
    switch ( var_4312b79c960726b6 )
    {
        case #"hash_f3d72f7c6f0d2029":
            function_b6fbf3f2e60af811( fe, us, cf );
            break;
        case #"hash_810a2ae3bcc10fe8":
            function_cc8105113aede640( fe, us, cf );
            break;
    }
}

// Namespace mp_sat_avalon_q2_ob_activity_prime_target_cs
// Params 3
// Checksum 0xebd40c51, Offset: 0x4029
// Size: 0xae
function function_b6fbf3f2e60af811( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_prime_target_cs";
    s.name = "prime_target_boss_spawnpoint";
    fe [[ f ]]( s, "PRIME_TARGET_MARKET", cf, ( 1978.6, 30746, 1022.87 ), ( 0, 0, 0 ), "encounter_spawntarget", undefined, "PRIME_TARGET_MARKET", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 768 );
}

// Namespace mp_sat_avalon_q2_ob_activity_prime_target_cs
// Params 3
// Checksum 0xb45b0369, Offset: 0x40df
// Size: 0xae
function function_cc8105113aede640( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_prime_target_cs";
    s.name = "prime_target_boss_spawnpoint";
    fe [[ f ]]( s, "PRIME_TARGET_DIGSITE", cf, ( 29442.2, 30376, 3167.51 ), ( 0, 0, 0 ), "encounter_spawntarget", undefined, "PRIME_TARGET_DIGSITE", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 384 );
}

// Namespace mp_sat_avalon_q2_ob_activity_prime_target_cs
// Params 0
// Checksum 0x69bc93d7, Offset: 0x4195
// Size: 0x143
function function_d9dd7965c51c95d1()
{
    activityinstances = [];
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_ob_activitydefinition_primetarget";
    var_881289d7987bc770.cf = "mp_sat_avalon_q2_ob_activity_prime_target_cs";
    var_881289d7987bc770.scriptstructorigin = ( 1263.8, 30989.2, 1264 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [];
    var_881289d7987bc770.var_31ce4477e3543d24 = [];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [];
    var_881289d7987bc770.locationradius = [];
    activityinstances[ "PRIME_TARGET_MARKET" ] = var_881289d7987bc770;
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_ob_activitydefinition_primetarget";
    var_881289d7987bc770.cf = "mp_sat_avalon_q2_ob_activity_prime_target_cs";
    var_881289d7987bc770.scriptstructorigin = ( 29115.8, 30962.5, 3505.65 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [];
    var_881289d7987bc770.var_31ce4477e3543d24 = [];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [];
    var_881289d7987bc770.locationradius = [];
    activityinstances[ "PRIME_TARGET_DIGSITE" ] = var_881289d7987bc770;
    return activityinstances;
}

