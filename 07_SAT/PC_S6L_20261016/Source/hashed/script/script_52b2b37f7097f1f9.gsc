// script_52b2b37f7097f1f9  (hash_52b2b37f7097f1f9.gscc) (size: 21845 Bytes / 0x5555 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xd900c7c1 (3640707009)
// size ...... 21845 (0x5555)
// includes .. 4   (offset: 0x482d)
// strings ... 85  (offset: 0x484d)
// dev strs .. 0   (offset: 0x5555)
// exports ... 14  (offset: 0x4301)
// cseg ...... 0x9b8 + 0x3949 (0x4301)
// imports ... 27  (offset: 0x4531)
// animtree1 . 0   (offset: 0x5555)
// animtree2 . 0   (offset: 0x5555)
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace mp_sat_avalon_q3_ob_activity_prime_target_cs;

// Namespace mp_sat_avalon_q3_ob_activity_prime_target_cs
// Params 0, eflags: 0x5
// Checksum 0x8e75a559, Offset: 0x9d6
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"mp_sat_avalon_q3_ob_activity_prime_target_cs", #"activity_common", &function_b39ecd3d51489472, undefined );
}

// Namespace mp_sat_avalon_q3_ob_activity_prime_target_cs
// Params 0, eflags: 0x4
// Checksum 0x2f4ec003, Offset: 0x9ff
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace mp_sat_avalon_q3_ob_activity_prime_target_cs
// Params 0, eflags: 0x4
// Checksum 0xaa7513ef, Offset: 0xa10
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace mp_sat_avalon_q3_ob_activity_prime_target_cs
// Params 2
// Checksum 0x8fd0d0ef, Offset: 0xa21
// Size: 0x8c
function main( unused, unused2 )
{
    if ( utility::flag_exist( "mp_sat_avalon_q3_ob_activity_prime_target_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "mp_sat_avalon_q3_ob_activity_prime_target_cs" ) )
    {
        return;
    }
    
    activity_common::function_e1df676808c1d1e3( &function_4cd78e661617f3 );
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "mp_sat_avalon_q3_ob_activity_prime_target_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "mp_sat_avalon_q3_ob_activity_prime_target_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace mp_sat_avalon_q3_ob_activity_prime_target_cs
// Params 3, eflags: 0x4
// Checksum 0x29f7a720, Offset: 0xab5
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "mp_sat_avalon_q3_ob_activity_prime_target_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "mp_sat_avalon_q3_ob_activity_prime_target_cs" );
}

// Namespace mp_sat_avalon_q3_ob_activity_prime_target_cs
// Params 3, eflags: 0x4
// Checksum 0x13b655a9, Offset: 0xb2f
// Size: 0x3412
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_prime_target_cs";
    s.activity_bundle = "sat_ob_activitydefinition_primetarget";
    s.name = "PRIME_TARGET_COAST_GUARD";
    fe [[ f ]]( s, "PRIME_TARGET_COAST_GUARD", cf, ( -42052, -5375.32, 757.73 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_prime_target_cs";
    s._size_max = ( 1252, 564, 200 );
    s._size_min = ( 1368, 1340, 200 );
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
    fe [[ f ]]( s, "PRIME_TARGET_COAST_GUARD", cf, ( -42116.8, -5470.42, 136.58 ), ( 0, 215, 0 ), "PRIME_TARGET_COAST_GUARD_enc_vol", undefined, "noent_volume_ai_encounter_cs", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_prime_target_cs";
    s._size_max = ( 590, 528, 210 );
    s._size_min = ( 438, 348, 200 );
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
    fe [[ f ]]( s, "PRIME_TARGET_COAST_GUARD", cf, ( -42070, -5300.32, 240.57 ), ( 0, 215, 0 ), "PRIME_TARGET_COAST_GUARD_boss_enc_vol", undefined, "noent_volume_ai_encounter_cs", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_prime_target_cs";
    s._size_max = ( 776, 356, 930 );
    s._size_min = ( 1608, 1228, 200 );
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
    fe [[ f ]]( s, "PRIME_TARGET_COAST_GUARD", cf, ( -42349.2, -5624.71, 264.58 ), ( 0, 215, 0 ), "PRIME_TARGET_COAST_GUARD_reinforcement_enc_vol", undefined, "noent_volume_ai_encounter_cs", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_prime_target_cs";
    fe [[ f ]]( s, "PRIME_TARGET_COAST_GUARD", cf, ( -42118.9, -5397.36, 128 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Proximity_Join_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 1920 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_prime_target_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "PRIME_TARGET_COAST_GUARD", cf, ( -41318.3, -4427.47, 128 ), ( 0, 0, 0 ), "cspf_1_auto3324167684532558211", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_prime_target_cs";
    s.ai_interaction = "idle_stretching";
    s.var_9a1a6bc9877cfff7 = "-1";
    s.repeat_interaction = "0";
    s.script_delay_max = "25";
    s.script_delay_min = "10";
    fe [[ f ]]( s, "PRIME_TARGET_COAST_GUARD", cf, ( -42656.8, -6075.16, 128 ), ( 0, 45, 0 ), "pt_coast_guard_idle_stretch_01", undefined, "info_act", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_prime_target_cs";
    s.ai_interaction = "idle_smoke";
    s.var_9a1a6bc9877cfff7 = "-1";
    s.repeat_interaction = "0";
    s.script_delay_max = "25";
    s.script_delay_min = "10";
    fe [[ f ]]( s, "PRIME_TARGET_COAST_GUARD", cf, ( -43080.8, -5531.17, 129.75 ), ( 0, 225, 0 ), "pt_coast_guard_idle_smoke_01", undefined, "info_act", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_prime_target_cs";
    s.ai_interaction = "idle_stretching";
    s.var_9a1a6bc9877cfff7 = "-1";
    s.repeat_interaction = "0";
    s.script_delay_max = "25";
    s.script_delay_min = "10";
    fe [[ f ]]( s, "PRIME_TARGET_COAST_GUARD", cf, ( -42649.3, -6315.76, 67 ), ( 0, 330, 0 ), "pt_coast_guard_idle_stretch_02", undefined, "info_act", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_prime_target_cs";
    s.ai_interaction = "idle_smoke";
    s.var_9a1a6bc9877cfff7 = "-1";
    s.repeat_interaction = "0";
    s.script_delay_max = "25";
    s.script_delay_min = "10";
    fe [[ f ]]( s, "PRIME_TARGET_COAST_GUARD", cf, ( -42614.2, -5636.88, 232 ), ( 0, 255, 0 ), "pt_coast_guard_idle_smoke_02", undefined, "info_act", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_prime_target_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.reverse_route = "1";
    s.start_point = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "PRIME_TARGET_COAST_GUARD", cf, ( -40958.3, -4987.46, 128 ), ( 0, 0, 0 ), "cspf_1_auto13509210273406537061", "cspf_1_auto3324167684532558211", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_prime_target_cs";
    s.location_spawnpoint = "0";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.name = "spawnpoint_boss";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "boss";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "PRIME_TARGET_COAST_GUARD", cf, ( -42219.2, -5138.16, 128 ), ( 0, 278.94, 0 ), undefined, "cspf_1_auto2715525634759718304", "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_prime_target_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "PRIME_TARGET_COAST_GUARD", cf, ( -41983.2, -5415.16, 128 ), ( 0, 0, 0 ), "cspf_1_auto2676970125363372085", "cspf_1_auto9976025264079623745", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_prime_target_cs";
    s.loop_route = "1";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.start_point = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "PRIME_TARGET_COAST_GUARD", cf, ( -42199.2, -5111.16, 128 ), ( 0, 0, 0 ), "cspf_1_auto2715525634759718304", "cspf_1_auto2676970125363372085", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_prime_target_cs";
    s.info_act_ref = "pt_coast_guard_idle_stretch_02";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "PRIME_TARGET_COAST_GUARD", cf, ( -42649.3, -6275.76, 64 ), ( 0, 0, 0 ), "cspf_1_auto16495042404102448553", "cspf_1_auto12069781826802108207", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_prime_target_cs";
    s.loop_route = "1";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.start_point = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "PRIME_TARGET_COAST_GUARD", cf, ( -42150.1, -5945.62, 64 ), ( 0, 0, 0 ), "cspf_1_auto545289309220199006", "cspf_1_auto16495042404102448553", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_prime_target_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "PRIME_TARGET_COAST_GUARD", cf, ( -42827.8, -6643.61, 64 ), ( 0, 255, 0 ), "cspf_1_auto12069781826802108207", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_prime_target_cs";
    s.info_act_ref = "pt_coast_guard_idle_smoke_01";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "PRIME_TARGET_COAST_GUARD", cf, ( -43064.8, -5555.17, 129.75 ), ( 0, 0, 0 ), "cspf_1_auto11354249269153874960", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_prime_target_cs";
    s.location_spawnpoint = "0";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.name = "spawnpoint_guard";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "PRIME_TARGET_COAST_GUARD", cf, ( -42170.1, -5972.62, 64 ), ( 0, 278.94, 0 ), undefined, "cspf_1_auto545289309220199006", "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_prime_target_cs";
    s.location_spawnpoint = "0";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.name = "spawnpoint_guard";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "PRIME_TARGET_COAST_GUARD", cf, ( -43564.2, -5164.06, 129.75 ), ( 0, 278.94, 0 ), undefined, "cspf_1_auto8952001688714768752", "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_prime_target_cs";
    s.location_spawnpoint = "0";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.name = "spawnpoint_guard";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "PRIME_TARGET_COAST_GUARD", cf, ( -40938.3, -4950.46, 128 ), ( 0, 278.94, 0 ), undefined, "cspf_1_auto13509210273406537061", "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_prime_target_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.reverse_route = "1";
    s.start_point = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "PRIME_TARGET_COAST_GUARD", cf, ( -42072.8, -5635.16, 98.36 ), ( 0, 0, 0 ), "cspf_1_auto3707936717723365423", "cspf_1_auto17106973336181246426", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_prime_target_cs";
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
    fe [[ f ]]( s, "PRIME_TARGET_COAST_GUARD", cf, ( -42036.8, -5654.16, 98.36 ), ( 0, 278.94, 0 ), undefined, "cspf_1_auto3707936717723365423", "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_prime_target_cs";
    s.location_spawnpoint = "0";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.name = "spawnpoint_guard";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "PRIME_TARGET_COAST_GUARD", cf, ( -42472.1, -5502.46, 232 ), ( 0, 278.94, 0 ), undefined, "cspf_1_auto13271895479057130743", "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_prime_target_cs";
    s.info_act_ref = "pt_coast_guard_idle_stretch_01";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "PRIME_TARGET_COAST_GUARD", cf, ( -42672.8, -6091.16, 128 ), ( 0, 0, 0 ), "cspf_1_auto17106973336181246426", "cspf_1_auto11354249269153874960", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_prime_target_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.reverse_route = "1";
    s.start_point = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "PRIME_TARGET_COAST_GUARD", cf, ( -42460.1, -5499.46, 232 ), ( 0, 0, 0 ), "cspf_1_auto13271895479057130743", "cspf_1_auto15820737553685542452", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_prime_target_cs";
    s.info_act_ref = "pt_coast_guard_idle_smoke_02";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "PRIME_TARGET_COAST_GUARD", cf, ( -42688, -5552, 232 ), ( 0, 225, 0 ), "cspf_1_auto15820737553685542452", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_prime_target_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "PRIME_TARGET_COAST_GUARD", cf, ( -42864.2, -5505.06, 128.85 ), ( 0, 0, 0 ), "cspf_1_auto16951058428971094634", "cspf_1_auto9395552320887165990", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_prime_target_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.reverse_route = "1";
    s.start_point = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "PRIME_TARGET_COAST_GUARD", cf, ( -43576.2, -5121.06, 129.75 ), ( 0, 0, 0 ), "cspf_1_auto8952001688714768752", "cspf_1_auto16951058428971094634", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_prime_target_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "PRIME_TARGET_COAST_GUARD", cf, ( -42664.2, -5793.04, 128 ), ( 0, 0, 0 ), "cspf_1_auto9395552320887165990", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_prime_target_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "PRIME_TARGET_COAST_GUARD", cf, ( -41471.2, -5071.16, 128 ), ( 0, 0, 0 ), "cspf_1_auto9976025264079623745", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_prime_target_cs";
    s.activity_bundle = "sat_ob_activitydefinition_primetarget";
    s.name = "PRIME_TARGET_RADARS_01";
    fe [[ f ]]( s, "PRIME_TARGET_RADARS_01", cf, ( -13633.8, -45180, 923.84 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_prime_target_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "PRIME_TARGET_RADARS_01", cf, ( -13071.7, -44666.4, 526.6 ), ( 0, 30, 0 ), "cspf_2_auto17403828168431525086", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_prime_target_cs";
    s._size_max = ( 1098, 782, 588 );
    s._size_min = ( 584, 988, 200 );
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
    fe [[ f ]]( s, "PRIME_TARGET_RADARS_01", cf, ( -13550.6, -45099.1, 610.69 ), ( 0, 300, 0 ), "PRIME_TARGET_RADARS_01_enc_vol", undefined, "noent_volume_ai_encounter_cs", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_prime_target_cs";
    s._size_max = ( 418, 610, 210 );
    s._size_min = ( 566, 844, 200 );
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
    fe [[ f ]]( s, "PRIME_TARGET_RADARS_01", cf, ( -13379.8, -45001, 682.68 ), ( 0, 300, 0 ), "PRIME_TARGET_RADARS_01_boss_enc_vol", undefined, "noent_volume_ai_encounter_cs", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_prime_target_cs";
    s._size_max = ( 1434, 1154, 930 );
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
    fe [[ f ]]( s, "PRIME_TARGET_RADARS_01", cf, ( -13559, -44565.4, 626.69 ), ( 0, 300, 0 ), "PRIME_TARGET_RADARS_01_reinforcement_enc_vol", undefined, "noent_volume_ai_encounter_cs", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_prime_target_cs";
    fe [[ f ]]( s, "PRIME_TARGET_RADARS_01", cf, ( -13584.2, -45107.8, 521.18 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Proximity_Join_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 1536 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_prime_target_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.reverse_route = "1";
    s.start_point = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "PRIME_TARGET_RADARS_01", cf, ( -13272.8, -44345.2, 529.03 ), ( 0, 75, 0 ), "cspf_2_auto1975556217819585096", "cspf_2_auto17403828168431525086", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_prime_target_cs";
    s.ai_interaction = "idle_stretching";
    s.var_9a1a6bc9877cfff7 = "-1";
    s.repeat_interaction = "0";
    s.script_delay_max = "25";
    s.script_delay_min = "10";
    fe [[ f ]]( s, "PRIME_TARGET_RADARS_01", cf, ( -13860.2, -46181.7, 530 ), ( 0, 210, 0 ), "pt_radars_01_idle_stretch_01", undefined, "info_act", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_prime_target_cs";
    s.ai_interaction = "idle_smoke";
    s.var_9a1a6bc9877cfff7 = "-1";
    s.repeat_interaction = "0";
    s.script_delay_max = "25";
    s.script_delay_min = "10";
    fe [[ f ]]( s, "PRIME_TARGET_RADARS_01", cf, ( -13206.9, -45559.6, 534 ), ( 0, 45, 0 ), "pt_radars_01_idle_smoke_01", undefined, "info_act", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_prime_target_cs";
    s.ai_interaction = "idle_stretching";
    s.var_9a1a6bc9877cfff7 = "-1";
    s.repeat_interaction = "0";
    s.script_delay_max = "25";
    s.script_delay_min = "10";
    fe [[ f ]]( s, "PRIME_TARGET_RADARS_01", cf, ( -14510, -45087.4, 528.25 ), ( 0, 120, 0 ), "pt_radars_01_idle_stretch_02", undefined, "info_act", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_prime_target_cs";
    s.ai_interaction = "idle_smoke";
    s.var_9a1a6bc9877cfff7 = "-1";
    s.repeat_interaction = "0";
    s.script_delay_max = "25";
    s.script_delay_min = "10";
    fe [[ f ]]( s, "PRIME_TARGET_RADARS_01", cf, ( -13724.5, -45553, 679.5 ), ( 0, 300, 0 ), "pt_radars_01_idle_smoke_02", undefined, "info_act", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_prime_target_cs";
    s.location_spawnpoint = "0";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.name = "spawnpoint_boss";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "boss";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "PRIME_TARGET_RADARS_01", cf, ( -14145.4, -45207.8, 679.75 ), ( 0, 278.94, 0 ), undefined, "cspf_2_auto16479738576856892202", "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_prime_target_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "PRIME_TARGET_RADARS_01", cf, ( -13969, -45641.4, 679.75 ), ( 0, 0, 0 ), "cspf_2_auto3982080175582791150", "cspf_2_auto16377435545759496917", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_prime_target_cs";
    s.loop_route = "1";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.start_point = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "PRIME_TARGET_RADARS_01", cf, ( -14109.4, -45180.8, 679.75 ), ( 0, 0, 0 ), "cspf_2_auto16479738576856892202", "cspf_2_auto3982080175582791150", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_prime_target_cs";
    s.info_act_ref = "pt_radars_01_idle_stretch_02";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "PRIME_TARGET_RADARS_01", cf, ( -14446, -45135.4, 528.58 ), ( 0, 120, 0 ), "cspf_2_auto15451756829015310632", "cspf_2_auto2520908996315584419", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_prime_target_cs";
    s.loop_route = "1";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.start_point = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "PRIME_TARGET_RADARS_01", cf, ( -14101.3, -44915.1, 528.25 ), ( 0, 120, 0 ), "cspf_2_auto16407455531695515206", "cspf_2_auto15451756829015310632", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_prime_target_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "PRIME_TARGET_RADARS_01", cf, ( -14170.9, -45686.4, 528.25 ), ( 0, 0, 0 ), "cspf_2_auto2520908996315584419", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_prime_target_cs";
    s.info_act_ref = "pt_radars_01_idle_smoke_01";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "PRIME_TARGET_RADARS_01", cf, ( -13238.9, -45599.6, 532 ), ( 0, 120, 0 ), "cspf_2_auto13876485861239215109", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_prime_target_cs";
    s.location_spawnpoint = "0";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.name = "spawnpoint_guard";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "PRIME_TARGET_RADARS_01", cf, ( -14137.3, -44982.1, 528.25 ), ( 0, 278.94, 0 ), undefined, "cspf_2_auto16407455531695515206", "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_prime_target_cs";
    s.location_spawnpoint = "0";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.name = "spawnpoint_guard";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "PRIME_TARGET_RADARS_01", cf, ( -13505.7, -44604.3, 521.18 ), ( 0, 278.94, 0 ), undefined, "cspf_2_auto10653366171283280826", "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_prime_target_cs";
    s.location_spawnpoint = "0";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.name = "spawnpoint_guard";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "PRIME_TARGET_RADARS_01", cf, ( -13252.8, -44308.2, 529.16 ), ( 0, 278.94, 0 ), undefined, "cspf_2_auto1975556217819585096", "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_prime_target_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.reverse_route = "1";
    s.start_point = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "PRIME_TARGET_RADARS_01", cf, ( -13716.5, -46313, 528 ), ( 0, 0, 0 ), "cspf_2_auto4436742959194630341", "cspf_2_auto4856503299605710287", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_prime_target_cs";
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
    fe [[ f ]]( s, "PRIME_TARGET_RADARS_01", cf, ( -13680.5, -46332, 528 ), ( 0, 278.94, 0 ), undefined, "cspf_2_auto4436742959194630341", "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_prime_target_cs";
    s.location_spawnpoint = "0";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.name = "spawnpoint_guard";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "PRIME_TARGET_RADARS_01", cf, ( -13993.2, -45113.8, 679.5 ), ( 0, 278.94, 0 ), undefined, "cspf_2_auto16118563522679013630", "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_prime_target_cs";
    s.info_act_ref = "pt_radars_01_idle_stretch_01";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "PRIME_TARGET_RADARS_01", cf, ( -13812.2, -46133.7, 528 ), ( 0, 0, 0 ), "cspf_2_auto4856503299605710287", "cspf_2_auto13876485861239215109", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_prime_target_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.reverse_route = "1";
    s.start_point = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "PRIME_TARGET_RADARS_01", cf, ( -13981.2, -45110.8, 679.5 ), ( 0, 0, 0 ), "cspf_2_auto16118563522679013630", "cspf_2_auto2402944602942087044", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_prime_target_cs";
    s.info_act_ref = "pt_radars_01_idle_smoke_02";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "PRIME_TARGET_RADARS_01", cf, ( -13747.8, -45507.4, 679.5 ), ( 0, 345, 0 ), "cspf_2_auto2402944602942087044", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_prime_target_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "PRIME_TARGET_RADARS_01", cf, ( -13092.3, -45362.3, 528 ), ( 0, 0, 0 ), "cspf_2_auto4811274826139422713", "cspf_2_auto15897009210992781685", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_prime_target_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.reverse_route = "1";
    s.start_point = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "PRIME_TARGET_RADARS_01", cf, ( -13509.7, -44569.3, 521.18 ), ( 0, 30, 0 ), "cspf_2_auto10653366171283280826", "cspf_2_auto4811274826139422713", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_prime_target_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "PRIME_TARGET_RADARS_01", cf, ( -13663.2, -45685.6, 528.25 ), ( 0, 0, 0 ), "cspf_2_auto15897009210992781685", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_prime_target_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "PRIME_TARGET_RADARS_01", cf, ( -13873, -45589.4, 679.84 ), ( 0, 0, 0 ), "cspf_2_auto16377435545759496917", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace mp_sat_avalon_q3_ob_activity_prime_target_cs
// Params 0, eflags: 0x4
// Checksum 0x985464a2, Offset: 0x3f49
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace mp_sat_avalon_q3_ob_activity_prime_target_cs
// Params 0
// Checksum 0xeba47a6d, Offset: 0x3f53
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "mp_sat_avalon_q3_ob_activity_prime_target_cs" );
}

// Namespace mp_sat_avalon_q3_ob_activity_prime_target_cs
// Params 0
// Checksum 0x8db5a060, Offset: 0x3f69
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

// Namespace mp_sat_avalon_q3_ob_activity_prime_target_cs
// Params 4
// Checksum 0x154615f2, Offset: 0x3fd8
// Size: 0x71
function function_d4323822d7042e5a( var_4312b79c960726b6, fe, us, cf = "mp_sat_avalon_q3_ob_activity_prime_target_cs" )
{
    switch ( var_4312b79c960726b6 )
    {
        case #"hash_7505e0463655addf":
            function_9e0e1f985b3a2a17( fe, us, cf );
            break;
        case #"hash_4ba27632a04729d2":
            function_14f610c9492d645a( fe, us, cf );
            break;
    }
}

// Namespace mp_sat_avalon_q3_ob_activity_prime_target_cs
// Params 3
// Checksum 0xd1cf2fde, Offset: 0x4051
// Size: 0xae
function function_9e0e1f985b3a2a17( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_prime_target_cs";
    s.name = "prime_target_boss_spawnpoint";
    fe [[ f ]]( s, "PRIME_TARGET_COAST_GUARD", cf, ( -42056, -5296, 128 ), ( 0, 0, 0 ), "encounter_spawntarget", undefined, "PRIME_TARGET_COAST_GUARD", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 384 );
}

// Namespace mp_sat_avalon_q3_ob_activity_prime_target_cs
// Params 3
// Checksum 0x29c9fe63, Offset: 0x4107
// Size: 0xae
function function_14f610c9492d645a( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_prime_target_cs";
    s.name = "prime_target_boss_spawnpoint";
    fe [[ f ]]( s, "PRIME_TARGET_RADARS_01", cf, ( -13876.4, -45309.1, 679.5 ), ( 0, 0, 0 ), "encounter_spawntarget", undefined, "PRIME_TARGET_RADARS_01", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 512 );
}

// Namespace mp_sat_avalon_q3_ob_activity_prime_target_cs
// Params 0
// Checksum 0x1fe6065d, Offset: 0x41bd
// Size: 0x143
function function_d9dd7965c51c95d1()
{
    activityinstances = [];
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_ob_activitydefinition_primetarget";
    var_881289d7987bc770.cf = "mp_sat_avalon_q3_ob_activity_prime_target_cs";
    var_881289d7987bc770.scriptstructorigin = ( -42052, -5375.32, 757.73 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [];
    var_881289d7987bc770.var_31ce4477e3543d24 = [];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [];
    var_881289d7987bc770.locationradius = [];
    activityinstances[ "PRIME_TARGET_COAST_GUARD" ] = var_881289d7987bc770;
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_ob_activitydefinition_primetarget";
    var_881289d7987bc770.cf = "mp_sat_avalon_q3_ob_activity_prime_target_cs";
    var_881289d7987bc770.scriptstructorigin = ( -13633.8, -45180, 923.84 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [];
    var_881289d7987bc770.var_31ce4477e3543d24 = [];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [];
    var_881289d7987bc770.locationradius = [];
    activityinstances[ "PRIME_TARGET_RADARS_01" ] = var_881289d7987bc770;
    return activityinstances;
}

