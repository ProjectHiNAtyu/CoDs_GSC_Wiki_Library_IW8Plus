// script_dad2f0edef38319  (hash_0dad2f0edef38319.gscc) (size: 31422 Bytes / 0x7abe / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x147c317c (343683452)
// size ...... 31422 (0x7abe)
// includes .. 4   (offset: 0x67a2)
// strings ... 111 (offset: 0x67c2)
// dev strs .. 0   (offset: 0x7abe)
// exports ... 15  (offset: 0x622e)
// cseg ...... 0xd6a + 0x54c4 (0x622e)
// imports ... 28  (offset: 0x6486)
// animtree1 . 0   (offset: 0x7abe)
// animtree2 . 0   (offset: 0x7abe)
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace mp_sat_avalon_q4_ob_activity_prime_target_cs;

// Namespace mp_sat_avalon_q4_ob_activity_prime_target_cs
// Params 0, eflags: 0x5
// Checksum 0x16a1f630, Offset: 0xd88
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"mp_sat_avalon_q4_ob_activity_prime_target_cs", #"activity_common", &function_b39ecd3d51489472, undefined );
}

// Namespace mp_sat_avalon_q4_ob_activity_prime_target_cs
// Params 0, eflags: 0x4
// Checksum 0x61f0b7fb, Offset: 0xdb1
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace mp_sat_avalon_q4_ob_activity_prime_target_cs
// Params 0, eflags: 0x4
// Checksum 0xe4cb6417, Offset: 0xdc2
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace mp_sat_avalon_q4_ob_activity_prime_target_cs
// Params 2
// Checksum 0x3308aeaa, Offset: 0xdd3
// Size: 0x8c
function main( unused, unused2 )
{
    if ( utility::flag_exist( "mp_sat_avalon_q4_ob_activity_prime_target_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "mp_sat_avalon_q4_ob_activity_prime_target_cs" ) )
    {
        return;
    }
    
    activity_common::function_e1df676808c1d1e3( &function_4cd78e661617f3 );
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "mp_sat_avalon_q4_ob_activity_prime_target_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "mp_sat_avalon_q4_ob_activity_prime_target_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace mp_sat_avalon_q4_ob_activity_prime_target_cs
// Params 3, eflags: 0x4
// Checksum 0x6749d0d8, Offset: 0xe67
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "mp_sat_avalon_q4_ob_activity_prime_target_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "mp_sat_avalon_q4_ob_activity_prime_target_cs" );
}

// Namespace mp_sat_avalon_q4_ob_activity_prime_target_cs
// Params 3, eflags: 0x4
// Checksum 0xa27756f0, Offset: 0xee1
// Size: 0x4e28
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_prime_target_cs";
    s.activity_bundle = "sat_ob_activitydefinition_primetarget";
    s.name = "PRIME_TARGET_STORE_01";
    fe [[ f ]]( s, "PRIME_TARGET_STORE_01", cf, ( 7050.56, -10128.4, 2318.44 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_prime_target_cs";
    s._size_max = ( 1252, 410, 200 );
    s._size_min = ( 1446, 944, 384 );
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
    fe [[ f ]]( s, "PRIME_TARGET_STORE_01", cf, ( 7801.76, -9879.5, 2095.29 ), ( 0, 333, 0 ), "PRIME_TARGET_STORE_01_enc_vol", undefined, "noent_volume_ai_encounter_cs", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_prime_target_cs";
    s._size_max = ( 218, 488, 210 );
    s._size_min = ( 580, 688, 200 );
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
    fe [[ f ]]( s, "PRIME_TARGET_STORE_01", cf, ( 7672.56, -9981.4, 2071.28 ), ( 0, 333, 0 ), "PRIME_TARGET_STORE_01_boss_enc_vol", undefined, "noent_volume_ai_encounter_cs", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_prime_target_cs";
    s._size_max = ( 450, 326, 930 );
    s._size_min = ( 946, 834, 200 );
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
    fe [[ f ]]( s, "PRIME_TARGET_STORE_01", cf, ( 7549.36, -9735.8, 1795.29 ), ( 0, 334, 0 ), "PRIME_TARGET_STORE_01_reinforcement_enc_vol", undefined, "noent_volume_ai_encounter_cs", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_prime_target_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "PRIME_TARGET_STORE_01", cf, ( 6505.05, -9517.93, 1968.79 ), ( 0, 105, 0 ), "cspf_1_auto2806756190238722979", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_prime_target_cs";
    fe [[ f ]]( s, "PRIME_TARGET_STORE_01", cf, ( 7475.26, -9930.23, 1970 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Proximity_Join_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 1920 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_prime_target_cs";
    s.ai_interaction = "idle_stretching";
    s.var_9a1a6bc9877cfff7 = "-1";
    s.repeat_interaction = "0";
    s.script_delay_max = "25";
    s.script_delay_min = "10";
    fe [[ f ]]( s, "PRIME_TARGET_STORE_01", cf, ( 6899.48, -9646.4, 1970 ), ( 0, 45, 0 ), "pt_store_01_idle_stretch_01", undefined, "info_act", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_prime_target_cs";
    s.ai_interaction = "idle_smoke";
    s.var_9a1a6bc9877cfff7 = "-1";
    s.repeat_interaction = "0";
    s.script_delay_max = "25";
    s.script_delay_min = "10";
    fe [[ f ]]( s, "PRIME_TARGET_STORE_01", cf, ( 6619.69, -10157.6, 1970 ), ( 0, 225, 0 ), "pt_store_01_idle_smoke_01", undefined, "info_act", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_prime_target_cs";
    s.ai_interaction = "idle_stretching";
    s.var_9a1a6bc9877cfff7 = "-1";
    s.repeat_interaction = "0";
    s.script_delay_max = "25";
    s.script_delay_min = "10";
    fe [[ f ]]( s, "PRIME_TARGET_STORE_01", cf, ( 7849, -9701.01, 1970 ), ( 0, 90, 0 ), "pt_store_01_idle_stretch_02", undefined, "info_act", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_prime_target_cs";
    s.ai_interaction = "idle_smoke";
    s.var_9a1a6bc9877cfff7 = "-1";
    s.repeat_interaction = "0";
    s.script_delay_max = "25";
    s.script_delay_min = "10";
    fe [[ f ]]( s, "PRIME_TARGET_STORE_01", cf, ( 8092.74, -10977, 1970 ), ( 0, 45, 0 ), "pt_store_01_idle_smoke_02", undefined, "info_act", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_prime_target_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.reverse_route = "1";
    s.start_point = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "PRIME_TARGET_STORE_01", cf, ( 6297.05, -9909.93, 1970 ), ( 0, 195, 0 ), "cspf_1_auto621149290791933388", "cspf_1_auto2806756190238722979", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_prime_target_cs";
    s.location_spawnpoint = "0";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.name = "spawnpoint_boss";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "boss";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "PRIME_TARGET_STORE_01", cf, ( 7542.65, -9957.59, 1970 ), ( 0, 278.94, 0 ), undefined, "cspf_1_auto11918294980403215760", "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_prime_target_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "PRIME_TARGET_STORE_01", cf, ( 7192.29, -9829.21, 1970 ), ( 0, 0, 0 ), "cspf_1_auto592172448590550966", "cspf_1_auto5225315823009482496", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_prime_target_cs";
    s.loop_route = "1";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.start_point = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "PRIME_TARGET_STORE_01", cf, ( 7578.65, -9930.59, 1970 ), ( 0, 0, 0 ), "cspf_1_auto11918294980403215760", "cspf_1_auto592172448590550966", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_prime_target_cs";
    s.info_act_ref = "pt_store_01_idle_stretch_02";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "PRIME_TARGET_STORE_01", cf, ( 7801, -9737.01, 1970 ), ( 0, 0, 0 ), "cspf_1_auto3721303700430732474", "cspf_1_auto5022618621184192474", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_prime_target_cs";
    s.loop_route = "1";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.start_point = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "PRIME_TARGET_STORE_01", cf, ( 8849, -10287, 1970 ), ( 0, 0, 0 ), "cspf_1_auto13913973454951812069", "cspf_1_auto3721303700430732474", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_prime_target_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "PRIME_TARGET_STORE_01", cf, ( 7607, -10055, 1970 ), ( 0, 0, 0 ), "cspf_1_auto5022618621184192474", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_prime_target_cs";
    s.info_act_ref = "pt_store_01_idle_smoke_01";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "PRIME_TARGET_STORE_01", cf, ( 6635.69, -10181.6, 1970 ), ( 0, 0, 0 ), "cspf_1_auto170973614053679975", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_prime_target_cs";
    s.location_spawnpoint = "0";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.name = "spawnpoint_guard";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "PRIME_TARGET_STORE_01", cf, ( 8813, -10354, 2003.78 ), ( 0, 278.94, 0 ), undefined, "cspf_1_auto13913973454951812069", "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_prime_target_cs";
    s.location_spawnpoint = "0";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.name = "spawnpoint_guard";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "PRIME_TARGET_STORE_01", cf, ( 7130.21, -9650.92, 1970 ), ( 0, 278.94, 0 ), undefined, "cspf_1_auto3020775649406573667", "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_prime_target_cs";
    s.location_spawnpoint = "0";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.name = "spawnpoint_guard";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "PRIME_TARGET_STORE_01", cf, ( 6317.05, -9872.93, 1970 ), ( 0, 278.94, 0 ), undefined, "cspf_1_auto621149290791933388", "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_prime_target_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.reverse_route = "1";
    s.start_point = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "PRIME_TARGET_STORE_01", cf, ( 6603.59, -9483.23, 1970 ), ( 0, 105, 0 ), "cspf_1_auto4648574295905247996", "cspf_1_auto1713242599433663006", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_prime_target_cs";
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
    fe [[ f ]]( s, "PRIME_TARGET_STORE_01", cf, ( 6639.59, -9502.23, 1970 ), ( 0, 278.94, 0 ), undefined, "cspf_1_auto4648574295905247996", "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_prime_target_cs";
    s.location_spawnpoint = "0";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.name = "spawnpoint_guard";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "PRIME_TARGET_STORE_01", cf, ( 7285.29, -10533.9, 1970 ), ( 0, 278.94, 0 ), undefined, "cspf_1_auto3263094664937273125", "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_prime_target_cs";
    s.info_act_ref = "pt_store_01_idle_stretch_01";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "PRIME_TARGET_STORE_01", cf, ( 6883.48, -9662.4, 1970 ), ( 0, 0, 0 ), "cspf_1_auto1713242599433663006", "cspf_1_auto170973614053679975", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_prime_target_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.reverse_route = "1";
    s.start_point = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "PRIME_TARGET_STORE_01", cf, ( 7297.29, -10530.9, 1970 ), ( 0, 0, 0 ), "cspf_1_auto3263094664937273125", "cspf_1_auto16046700137655424782", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_prime_target_cs";
    s.info_act_ref = "pt_store_01_idle_smoke_02";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "PRIME_TARGET_STORE_01", cf, ( 8089.29, -10954.9, 1970 ), ( 0, 0, 0 ), "cspf_1_auto16046700137655424782", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_prime_target_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "PRIME_TARGET_STORE_01", cf, ( 7307.6, -9306.54, 1937.31 ), ( 0, 0, 0 ), "cspf_1_auto11108259958285833117", "cspf_1_auto5440422888329842147", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_prime_target_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.reverse_route = "1";
    s.start_point = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "PRIME_TARGET_STORE_01", cf, ( 7118.21, -9607.92, 1970 ), ( 0, 0, 0 ), "cspf_1_auto3020775649406573667", "cspf_1_auto11108259958285833117", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_prime_target_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "PRIME_TARGET_STORE_01", cf, ( 7622.06, -9477.02, 1970.5 ), ( 0, 60, 0 ), "cspf_1_auto5440422888329842147", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_prime_target_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "PRIME_TARGET_STORE_01", cf, ( 6899, -10186.6, 1970 ), ( 0, 0, 0 ), "cspf_1_auto5225315823009482496", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_prime_target_cs";
    s.activity_bundle = "sat_ob_activitydefinition_primetarget";
    s.name = "PRIME_TARGET_BRIDGE_BUILDINGS_01";
    fe [[ f ]]( s, "PRIME_TARGET_BRIDGE_BUILDINGS_01", cf, ( 19636.7, -37159.3, 1158.61 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_prime_target_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "PRIME_TARGET_BRIDGE_BUILDINGS_01", cf, ( 20370.6, -36322.8, 450.01 ), ( 0, 0, 0 ), "cspf_2_auto9199877476215762618", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_prime_target_cs";
    s._size_max = ( 850, 940, 200 );
    s._size_min = ( 618, 1014, 200 );
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
    fe [[ f ]]( s, "PRIME_TARGET_BRIDGE_BUILDINGS_01", cf, ( 19779.9, -36686.4, 645.46 ), ( 0, 350, 0 ), "PRIME_TARGET_BRIDGE_BUILDINGS_01_enc_vol", undefined, "noent_volume_ai_encounter_cs", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_prime_target_cs";
    s._size_max = ( 236, 388, 406 );
    s._size_min = ( 286, 410, 200 );
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
    fe [[ f ]]( s, "PRIME_TARGET_BRIDGE_BUILDINGS_01", cf, ( 19818.7, -36756.3, 506.44 ), ( 0, 350, 0 ), "PRIME_TARGET_BRIDGE_BUILDINGS_01_boss_enc_vol", undefined, "noent_volume_ai_encounter_cs", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_prime_target_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.reverse_route = "1";
    s.start_point = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "PRIME_TARGET_BRIDGE_BUILDINGS_01", cf, ( 19537.5, -36159.4, 452 ), ( 0, 0, 0 ), "cspf_2_auto6224719363800280092", "cspf_2_auto9199877476215762618", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_prime_target_cs";
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
    fe [[ f ]]( s, "PRIME_TARGET_BRIDGE_BUILDINGS_01", cf, ( 19811.5, -36752.7, 525.46 ), ( 0, 0, 0 ), "PRIME_TARGET_BRIDGE_BUILDINGS_01_reinforcement_enc_vol", undefined, "noent_volume_ai_encounter_cs", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_prime_target_cs";
    s.info_act_ref = "pt_bridge_buildings_01_idle_smoke_01";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "PRIME_TARGET_BRIDGE_BUILDINGS_01", cf, ( 20162.6, -36831.4, 449.99 ), ( 0, 75, 0 ), "cspf_2_auto907689653703391425", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_prime_target_cs";
    fe [[ f ]]( s, "PRIME_TARGET_BRIDGE_BUILDINGS_01", cf, ( 19879.5, -36774, 456 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Proximity_Join_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 1920 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_prime_target_cs";
    s.location_spawnpoint = "0";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.name = "spawnpoint_guard";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "PRIME_TARGET_BRIDGE_BUILDINGS_01", cf, ( 19629.8, -36680.5, 600 ), ( 0, 113.94, 0 ), undefined, "cspf_2_auto4872600082795973270", "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_prime_target_cs";
    s.info_act_ref = "pt_bridge_buildings_01_idle_stretch_02";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "PRIME_TARGET_BRIDGE_BUILDINGS_01", cf, ( 19246.7, -37138.7, 449.99 ), ( 0, 0, 0 ), "cspf_2_auto10490856171369800783", "cspf_2_auto905309134426354450", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_prime_target_cs";
    s.loop_route = "1";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.start_point = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "PRIME_TARGET_BRIDGE_BUILDINGS_01", cf, ( 19876.6, -37282, 449.99 ), ( 0, 0, 0 ), "cspf_2_auto6039733567276408764", "cspf_2_auto10490856171369800783", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_prime_target_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "PRIME_TARGET_BRIDGE_BUILDINGS_01", cf, ( 19504, -35959.3, 475.04 ), ( 0, 0, 0 ), "cspf_2_auto905309134426354450", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_prime_target_cs";
    s.location_spawnpoint = "0";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.name = "spawnpoint_boss";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "boss";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "PRIME_TARGET_BRIDGE_BUILDINGS_01", cf, ( 19574.5, -36854, 600 ), ( 0, 278.94, 0 ), undefined, "cspf_2_auto9079953378649190599", "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_prime_target_cs";
    s.location_spawnpoint = "0";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.name = "spawnpoint_guard";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "PRIME_TARGET_BRIDGE_BUILDINGS_01", cf, ( 19840.6, -37349, 449.99 ), ( 0, 278.94, 0 ), undefined, "cspf_2_auto6039733567276408764", "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_prime_target_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "PRIME_TARGET_BRIDGE_BUILDINGS_01", cf, ( 19914.5, -37059, 600 ), ( 0, 0, 0 ), "cspf_2_auto415246093575301544", "cspf_2_auto2222980675568648206", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_prime_target_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.reverse_route = "1";
    s.start_point = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "PRIME_TARGET_BRIDGE_BUILDINGS_01", cf, ( 20176, -37297.8, 449.13 ), ( 0, 0, 0 ), "cspf_2_auto16630707789828887311", "cspf_2_auto16429607533201961287", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_prime_target_cs";
    s.loop_route = "1";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.start_point = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "PRIME_TARGET_BRIDGE_BUILDINGS_01", cf, ( 19610.5, -36827, 600 ), ( 0, 0, 0 ), "cspf_2_auto9079953378649190599", "cspf_2_auto415246093575301544", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_prime_target_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "PRIME_TARGET_BRIDGE_BUILDINGS_01", cf, ( 20050.5, -36491, 600 ), ( 0, 0, 0 ), "cspf_2_auto2222980675568648206", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_prime_target_cs";
    s.location_spawnpoint = "0";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.name = "spawnpoint_guard";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "PRIME_TARGET_BRIDGE_BUILDINGS_01", cf, ( 20232.4, -37409.9, 449.11 ), ( 0, 278.94, 0 ), undefined, "cspf_2_auto17988196727622384796", "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_prime_target_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.reverse_route = "1";
    s.start_point = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "PRIME_TARGET_BRIDGE_BUILDINGS_01", cf, ( 20244.4, -37406.9, 449.06 ), ( 0, 0, 0 ), "cspf_2_auto17988196727622384796", "cspf_2_auto11111824222249609799", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_prime_target_cs";
    s.info_act_ref = "pt_bridge_buildings_01_idle_smoke_02";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "PRIME_TARGET_BRIDGE_BUILDINGS_01", cf, ( 20508, -36452.2, 454.61 ), ( 0, 0, 0 ), "cspf_2_auto11111824222249609799", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_prime_target_cs";
    s.ai_interaction = "idle_stretching";
    s.var_9a1a6bc9877cfff7 = "-1";
    s.repeat_interaction = "0";
    s.script_delay_max = "25";
    s.script_delay_min = "10";
    fe [[ f ]]( s, "PRIME_TARGET_BRIDGE_BUILDINGS_01", cf, ( 19522.8, -37037.6, 744 ), ( 0, 210, 0 ), "pt_bridge_buildings_01_idle_stretch_01", undefined, "info_act", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_prime_target_cs";
    s.ai_interaction = "idle_smoke";
    s.var_9a1a6bc9877cfff7 = "-1";
    s.repeat_interaction = "0";
    s.script_delay_max = "25";
    s.script_delay_min = "10";
    fe [[ f ]]( s, "PRIME_TARGET_BRIDGE_BUILDINGS_01", cf, ( 19627.3, -36483, 744 ), ( 0, 165, 0 ), "pt_bridge_buildings_01_idle_smoke_01", undefined, "info_act", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_prime_target_cs";
    s.ai_interaction = "idle_stretching";
    s.var_9a1a6bc9877cfff7 = "-1";
    s.repeat_interaction = "0";
    s.script_delay_max = "25";
    s.script_delay_min = "10";
    fe [[ f ]]( s, "PRIME_TARGET_BRIDGE_BUILDINGS_01", cf, ( 19909.5, -37301.6, 449.95 ), ( 0, 345, 0 ), "pt_bridge_buildings_01_idle_stretch_02", undefined, "info_act", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_prime_target_cs";
    s.ai_interaction = "idle_smoke";
    s.var_9a1a6bc9877cfff7 = "-1";
    s.repeat_interaction = "0";
    s.script_delay_max = "25";
    s.script_delay_min = "10";
    fe [[ f ]]( s, "PRIME_TARGET_BRIDGE_BUILDINGS_01", cf, ( 20537.1, -36404.6, 454.11 ), ( 0, 60, 0 ), "pt_bridge_buildings_01_idle_smoke_02", undefined, "info_act", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_prime_target_cs";
    s.location_spawnpoint = "0";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.name = "spawnpoint_guard";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "PRIME_TARGET_BRIDGE_BUILDINGS_01", cf, ( 19557.5, -36122.4, 452.71 ), ( 0, 278.94, 0 ), undefined, "cspf_2_auto6224719363800280092", "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_prime_target_cs";
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
    fe [[ f ]]( s, "PRIME_TARGET_BRIDGE_BUILDINGS_01", cf, ( 20212, -37316.8, 449.05 ), ( 0, 278.94, 0 ), undefined, "cspf_2_auto16630707789828887311", "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_prime_target_cs";
    s.info_act_ref = "pt_bridge_buildings_01_idle_stretch_01";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "PRIME_TARGET_BRIDGE_BUILDINGS_01", cf, ( 20251.7, -36854.6, 449.99 ), ( 0, 0, 0 ), "cspf_2_auto16429607533201961287", "cspf_2_auto907689653703391425", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_prime_target_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "PRIME_TARGET_BRIDGE_BUILDINGS_01", cf, ( 19862, -36689.6, 600 ), ( 0, 0, 0 ), "cspf_2_auto8973755072058196468", "cspf_2_auto16474687020682940648", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_prime_target_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.reverse_route = "1";
    s.start_point = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "PRIME_TARGET_BRIDGE_BUILDINGS_01", cf, ( 19670.3, -36662.2, 600 ), ( 0, 120, 0 ), "cspf_2_auto4872600082795973270", "cspf_2_auto8973755072058196468", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_prime_target_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "PRIME_TARGET_BRIDGE_BUILDINGS_01", cf, ( 19883, -36603.1, 600 ), ( 0, 345, 0 ), "cspf_2_auto16474687020682940648", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_prime_target_cs";
    s.activity_bundle = "sat_ob_activitydefinition_primetarget";
    s.name = "PRIME_TARGET_TRUCK_STOP_01";
    fe [[ f ]]( s, "PRIME_TARGET_TRUCK_STOP_01", cf, ( 41665.9, -25562.8, 737.4 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_prime_target_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "PRIME_TARGET_TRUCK_STOP_01", cf, ( 42019.5, -25412.9, 464 ), ( 0, 30, 0 ), "cspf_3_auto17970038256126377702", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_prime_target_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.reverse_route = "1";
    s.start_point = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "PRIME_TARGET_TRUCK_STOP_01", cf, ( 41674.4, -25211.7, 471.83 ), ( 0, 105, 0 ), "cspf_3_auto13849394604446703754", "cspf_3_auto17970038256126377702", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_prime_target_cs";
    s._size_max = ( 1216, 1008, 588 );
    s._size_min = ( 902, 988, 200 );
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
    fe [[ f ]]( s, "PRIME_TARGET_TRUCK_STOP_01", cf, ( 41577.1, -25497.9, 368.25 ), ( 0, 330, 0 ), "PRIME_TARGET_TRUCK_STOP_01_enc_vol", undefined, "noent_volume_ai_encounter_cs", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_prime_target_cs";
    s.location_spawnpoint = "0";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.name = "spawnpoint_boss";
    s.var_6324368dbfa7058a = "3000";
    s.preferred_spawnpoint = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "boss";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "PRIME_TARGET_TRUCK_STOP_01", cf, ( 41659.1, -25303.7, 464 ), ( 0, 278.94, 0 ), undefined, "cspf_3_auto14458160082851713358", "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_prime_target_cs";
    s._size_max = ( 408, 176, 210 );
    s._size_min = ( 566, 570, 200 );
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
    fe [[ f ]]( s, "PRIME_TARGET_TRUCK_STOP_01", cf, ( 41779.9, -25495.8, 568.24 ), ( 0, 330, 0 ), "PRIME_TARGET_TRUCK_STOP_01_boss_enc_vol", undefined, "noent_volume_ai_encounter_cs", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_prime_target_cs";
    s._size_max = ( 1176, 952, 930 );
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
    fe [[ f ]]( s, "PRIME_TARGET_TRUCK_STOP_01", cf, ( 41820.7, -25612.2, 404.25 ), ( 0, 330, 0 ), "PRIME_TARGET_TRUCK_STOP_01_reinforcement_enc_vol", undefined, "noent_volume_ai_encounter_cs", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_prime_target_cs";
    fe [[ f ]]( s, "PRIME_TARGET_TRUCK_STOP_01", cf, ( 41724.4, -25729, 464 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Proximity_Join_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 1920 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_prime_target_cs";
    s.ai_interaction = "idle_stretching";
    s.var_9a1a6bc9877cfff7 = "-1";
    s.repeat_interaction = "0";
    s.script_delay_max = "25";
    s.script_delay_min = "10";
    fe [[ f ]]( s, "PRIME_TARGET_TRUCK_STOP_01", cf, ( 42074.3, -26599.4, 321 ), ( 0, 210, 0 ), "pt_truck_stop_stretch_01", undefined, "info_act", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_prime_target_cs";
    s.ai_interaction = "idle_smoke";
    s.var_9a1a6bc9877cfff7 = "-1";
    s.repeat_interaction = "0";
    s.script_delay_max = "25";
    s.script_delay_min = "10";
    fe [[ f ]]( s, "PRIME_TARGET_TRUCK_STOP_01", cf, ( 41087.3, -25970.1, 321 ), ( 0, 45, 0 ), "pt_truck_stop_smoke_01", undefined, "info_act", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_prime_target_cs";
    s.ai_interaction = "idle_stretching";
    s.var_9a1a6bc9877cfff7 = "-1";
    s.repeat_interaction = "0";
    s.script_delay_max = "25";
    s.script_delay_min = "10";
    fe [[ f ]]( s, "PRIME_TARGET_TRUCK_STOP_01", cf, ( 41722.7, -24603.2, 321.13 ), ( 0, 120, 0 ), "pt_truck_stop_idle_stretch_02", undefined, "info_act", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_prime_target_cs";
    s.ai_interaction = "idle_smoke";
    s.var_9a1a6bc9877cfff7 = "-1";
    s.repeat_interaction = "0";
    s.script_delay_max = "25";
    s.script_delay_min = "10";
    fe [[ f ]]( s, "PRIME_TARGET_TRUCK_STOP_01", cf, ( 40704.6, -25610.9, 319.71 ), ( 0, 240, 0 ), "pt_truck_stop_idle_smoke_02", undefined, "info_act", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_prime_target_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "PRIME_TARGET_TRUCK_STOP_01", cf, ( 41369.1, -25841.5, 463.93 ), ( 0, 0, 0 ), "cspf_3_auto13880656590045315359", "cspf_3_auto13833863223743681025", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_prime_target_cs";
    s.loop_route = "1";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.start_point = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "PRIME_TARGET_TRUCK_STOP_01", cf, ( 41695.1, -25276.7, 464 ), ( 0, 60, 0 ), "cspf_3_auto14458160082851713358", "cspf_3_auto13880656590045315359", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_prime_target_cs";
    s.info_act_ref = "pt_truck_stop_idle_stretch_02";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "PRIME_TARGET_TRUCK_STOP_01", cf, ( 41786.7, -24651.2, 321.17 ), ( 0, 120, 0 ), "cspf_3_auto14619060896222728758", "cspf_3_auto16510771407148844314", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_prime_target_cs";
    s.loop_route = "1";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.start_point = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "PRIME_TARGET_TRUCK_STOP_01", cf, ( 41555.4, -25030.9, 321.17 ), ( 0, 120, 0 ), "cspf_3_auto1495587167275408113", "cspf_3_auto14619060896222728758", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_prime_target_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "PRIME_TARGET_TRUCK_STOP_01", cf, ( 42565.8, -25106.2, 321.16 ), ( 0, 0, 0 ), "cspf_3_auto16510771407148844314", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_prime_target_cs";
    s.info_act_ref = "pt_truck_stop_idle_smoke_01";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "PRIME_TARGET_TRUCK_STOP_01", cf, ( 41055.3, -26010.1, 321 ), ( 0, 120, 0 ), "cspf_3_auto17844492335161665409", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_prime_target_cs";
    s.location_spawnpoint = "0";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.name = "spawnpoint_guard";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "PRIME_TARGET_TRUCK_STOP_01", cf, ( 41519.4, -25097.9, 321.17 ), ( 0, 278.94, 0 ), undefined, "cspf_3_auto1495587167275408113", "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_prime_target_cs";
    s.location_spawnpoint = "0";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.name = "spawnpoint_guard";
    s.var_6324368dbfa7058a = "3000";
    s.preferred_spawnpoint = "1";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "PRIME_TARGET_TRUCK_STOP_01", cf, ( 41868.8, -25804.1, 473.14 ), ( 0, 278.94, 0 ), undefined, "cspf_3_auto15527722862418486014", "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_prime_target_cs";
    s.location_spawnpoint = "0";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.name = "spawnpoint_guard";
    s.var_6324368dbfa7058a = "3000";
    s.preferred_spawnpoint = "1";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "PRIME_TARGET_TRUCK_STOP_01", cf, ( 41659.4, -25226.7, 471.97 ), ( 0, 68.94, 0 ), undefined, "cspf_3_auto13849394604446703754", "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_prime_target_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.reverse_route = "1";
    s.start_point = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "PRIME_TARGET_TRUCK_STOP_01", cf, ( 42269.1, -26310, 321 ), ( 0, 0, 0 ), "cspf_3_auto2107168310113062184", "cspf_3_auto16864501213816347732", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_prime_target_cs";
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
    fe [[ f ]]( s, "PRIME_TARGET_TRUCK_STOP_01", cf, ( 42305.1, -26329, 321 ), ( 0, 278.94, 0 ), undefined, "cspf_3_auto2107168310113062184", "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_prime_target_cs";
    s.location_spawnpoint = "0";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.name = "spawnpoint_guard";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "PRIME_TARGET_TRUCK_STOP_01", cf, ( 41099.9, -24835.7, 321.29 ), ( 0, 278.94, 0 ), undefined, "cspf_3_auto11469512683747444433", "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_prime_target_cs";
    s.info_act_ref = "pt_truck_stop_idle_stretch_01";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "PRIME_TARGET_TRUCK_STOP_01", cf, ( 42122.3, -26551.4, 321 ), ( 0, 0, 0 ), "cspf_3_auto16864501213816347732", "cspf_3_auto17844492335161665409", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_prime_target_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.reverse_route = "1";
    s.start_point = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "PRIME_TARGET_TRUCK_STOP_01", cf, ( 41111.9, -24832.7, 321.17 ), ( 0, 60, 0 ), "cspf_3_auto11469512683747444433", "cspf_3_auto14286362498953250522", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_prime_target_cs";
    s.info_act_ref = "pt_truck_stop_idle_smoke_02";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "PRIME_TARGET_TRUCK_STOP_01", cf, ( 40681.3, -25565.3, 319.85 ), ( 0, 345, 0 ), "cspf_3_auto14286362498953250522", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_prime_target_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "PRIME_TARGET_TRUCK_STOP_01", cf, ( 42010, -25851.1, 463.94 ), ( 0, 0, 0 ), "cspf_3_auto16268292363024255071", "cspf_3_auto7849836228322312186", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_prime_target_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.reverse_route = "1";
    s.start_point = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "PRIME_TARGET_TRUCK_STOP_01", cf, ( 41580.7, -25585.9, 464 ), ( 0, 30, 0 ), "cspf_3_auto15527722862418486014", "cspf_3_auto16268292363024255071", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_prime_target_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "PRIME_TARGET_TRUCK_STOP_01", cf, ( 41831.1, -26126.4, 464.18 ), ( 0, 0, 0 ), "cspf_3_auto7849836228322312186", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_prime_target_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "PRIME_TARGET_TRUCK_STOP_01", cf, ( 41665.1, -26005.5, 464.02 ), ( 0, 0, 0 ), "cspf_3_auto13833863223743681025", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace mp_sat_avalon_q4_ob_activity_prime_target_cs
// Params 0, eflags: 0x4
// Checksum 0x248c1ae7, Offset: 0x5d11
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace mp_sat_avalon_q4_ob_activity_prime_target_cs
// Params 0
// Checksum 0xa51a0d95, Offset: 0x5d1b
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "mp_sat_avalon_q4_ob_activity_prime_target_cs" );
}

// Namespace mp_sat_avalon_q4_ob_activity_prime_target_cs
// Params 0
// Checksum 0xc30bd798, Offset: 0x5d31
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

// Namespace mp_sat_avalon_q4_ob_activity_prime_target_cs
// Params 4
// Checksum 0x8b3c0ab2, Offset: 0x5da0
// Size: 0x8b
function function_d4323822d7042e5a( var_4312b79c960726b6, fe, us, cf = "mp_sat_avalon_q4_ob_activity_prime_target_cs" )
{
    switch ( var_4312b79c960726b6 )
    {
        case #"hash_fc181711a7dc7760":
            function_f8d4da6b75f6d1e8( fe, us, cf );
            break;
        case #"hash_bc319a54502236dc":
            function_244312957f724ea4( fe, us, cf );
            break;
        case #"hash_e692a1d2bfd26f09":
            function_f0170432ab5bdc81( fe, us, cf );
            break;
    }
}

// Namespace mp_sat_avalon_q4_ob_activity_prime_target_cs
// Params 3
// Checksum 0x9b310afc, Offset: 0x5e33
// Size: 0xae
function function_f8d4da6b75f6d1e8( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_prime_target_cs";
    s.name = "prime_target_boss_spawnpoint";
    fe [[ f ]]( s, "PRIME_TARGET_STORE_01", cf, ( 7589.53, -10002, 1970 ), ( 0, 0, 0 ), "encounter_spawntarget", undefined, "PRIME_TARGET_STORE_01", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 512 );
}

// Namespace mp_sat_avalon_q4_ob_activity_prime_target_cs
// Params 3
// Checksum 0xfcc440c6, Offset: 0x5ee9
// Size: 0xae
function function_244312957f724ea4( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_prime_target_cs";
    s.name = "prime_target_boss_spawnpoint";
    fe [[ f ]]( s, "PRIME_TARGET_BRIDGE_BUILDINGS_01", cf, ( 19784, -36768, 456 ), ( 0, 0, 0 ), "encounter_spawntarget", undefined, "PRIME_TARGET_BRIDGE_BUILDINGS_01", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 256 );
}

// Namespace mp_sat_avalon_q4_ob_activity_prime_target_cs
// Params 3
// Checksum 0xc8b54b32, Offset: 0x5f9f
// Size: 0xae
function function_f0170432ab5bdc81( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_prime_target_cs";
    s.name = "prime_target_boss_spawnpoint";
    fe [[ f ]]( s, "PRIME_TARGET_TRUCK_STOP_01", cf, ( 41703.9, -25672.5, 468.5 ), ( 0, 0, 0 ), "encounter_spawntarget", undefined, "PRIME_TARGET_TRUCK_STOP_01", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 512 );
}

// Namespace mp_sat_avalon_q4_ob_activity_prime_target_cs
// Params 0
// Checksum 0x757485e9, Offset: 0x6055
// Size: 0x1d8
function function_d9dd7965c51c95d1()
{
    activityinstances = [];
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_ob_activitydefinition_primetarget";
    var_881289d7987bc770.cf = "mp_sat_avalon_q4_ob_activity_prime_target_cs";
    var_881289d7987bc770.scriptstructorigin = ( 7050.56, -10128.4, 2318.44 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [];
    var_881289d7987bc770.var_31ce4477e3543d24 = [];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [];
    var_881289d7987bc770.locationradius = [];
    activityinstances[ "PRIME_TARGET_STORE_01" ] = var_881289d7987bc770;
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_ob_activitydefinition_primetarget";
    var_881289d7987bc770.cf = "mp_sat_avalon_q4_ob_activity_prime_target_cs";
    var_881289d7987bc770.scriptstructorigin = ( 19636.7, -37159.3, 1158.61 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [];
    var_881289d7987bc770.var_31ce4477e3543d24 = [];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [];
    var_881289d7987bc770.locationradius = [];
    activityinstances[ "PRIME_TARGET_BRIDGE_BUILDINGS_01" ] = var_881289d7987bc770;
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_ob_activitydefinition_primetarget";
    var_881289d7987bc770.cf = "mp_sat_avalon_q4_ob_activity_prime_target_cs";
    var_881289d7987bc770.scriptstructorigin = ( 41665.9, -25562.8, 737.4 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [];
    var_881289d7987bc770.var_31ce4477e3543d24 = [];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [];
    var_881289d7987bc770.locationradius = [];
    activityinstances[ "PRIME_TARGET_TRUCK_STOP_01" ] = var_881289d7987bc770;
    return activityinstances;
}

