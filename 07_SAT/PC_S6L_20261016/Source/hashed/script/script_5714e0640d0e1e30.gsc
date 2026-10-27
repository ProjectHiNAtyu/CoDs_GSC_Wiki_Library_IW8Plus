// script_5714e0640d0e1e30  (hash_5714e0640d0e1e30.gscc) (size: 12448 Bytes / 0x30a0 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x49481ea (76841450)
// size ...... 12448 (0x30a0)
// includes .. 4   (offset: 0x2950)
// strings ... 61  (offset: 0x2970)
// dev strs .. 0   (offset: 0x30a0)
// exports ... 13  (offset: 0x246c)
// cseg ...... 0x66b + 0x1e01 (0x246c)
// imports ... 26  (offset: 0x2674)
// animtree1 . 0   (offset: 0x30a0)
// animtree2 . 0   (offset: 0x30a0)
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace mp_sat_avalon_city_ob_activity_prime_target_cs;

// Namespace mp_sat_avalon_city_ob_activity_prime_target_cs
// Params 0, eflags: 0x5
// Checksum 0x673ba2a7, Offset: 0x689
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"mp_sat_avalon_city_ob_activity_prime_target_cs", #"activity_common", &function_b39ecd3d51489472, undefined );
}

// Namespace mp_sat_avalon_city_ob_activity_prime_target_cs
// Params 0, eflags: 0x4
// Checksum 0x7177e822, Offset: 0x6b2
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace mp_sat_avalon_city_ob_activity_prime_target_cs
// Params 0, eflags: 0x4
// Checksum 0xf44c3bce, Offset: 0x6c3
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace mp_sat_avalon_city_ob_activity_prime_target_cs
// Params 2
// Checksum 0x8ec4e95c, Offset: 0x6d4
// Size: 0x8c
function main( unused, unused2 )
{
    if ( utility::flag_exist( "mp_sat_avalon_city_ob_activity_prime_target_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "mp_sat_avalon_city_ob_activity_prime_target_cs" ) )
    {
        return;
    }
    
    activity_common::function_e1df676808c1d1e3( &function_4cd78e661617f3 );
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "mp_sat_avalon_city_ob_activity_prime_target_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "mp_sat_avalon_city_ob_activity_prime_target_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace mp_sat_avalon_city_ob_activity_prime_target_cs
// Params 3, eflags: 0x4
// Checksum 0x77ce8f01, Offset: 0x768
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "mp_sat_avalon_city_ob_activity_prime_target_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "mp_sat_avalon_city_ob_activity_prime_target_cs" );
}

// Namespace mp_sat_avalon_city_ob_activity_prime_target_cs
// Params 3, eflags: 0x4
// Checksum 0x6178cdc2, Offset: 0x7e2
// Size: 0x1a2f
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_prime_target_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "PRIME_TARGET_CAROUSEL", cf, ( 3306.92, 2233.55, 549.05 ), ( 0, 0, 0 ), "cspf_1_auto767939111694608526", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_prime_target_cs";
    s.activity_bundle = "sat_ob_activitydefinition_primetarget";
    s.name = "PRIME_TARGET_CAROUSEL";
    fe [[ f ]]( s, "PRIME_TARGET_CAROUSEL", cf, ( 3909.13, 1727.74, 1103.62 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_prime_target_cs";
    s._size_max = ( 1362, 1114, 200 );
    s._size_min = ( 1774, 692, 200 );
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
    fe [[ f ]]( s, "PRIME_TARGET_CAROUSEL", cf, ( 3948.25, 1368.64, 634.47 ), ( 0, 0, 0 ), "PRIME_TARGET_CAROUSEL_enc_vol", undefined, "noent_volume_ai_encounter_cs", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_prime_target_cs";
    s._size_max = ( 590, 528, 210 );
    s._size_min = ( 468, 512, 200 );
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
    fe [[ f ]]( s, "PRIME_TARGET_CAROUSEL", cf, ( 3923.12, 1722.74, 654.46 ), ( 0, 0, 0 ), "PRIME_TARGET_CAROUSEL_boss_enc_vol", undefined, "noent_volume_ai_encounter_cs", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_prime_target_cs";
    s._size_max = ( 1274, 1154, 930 );
    s._size_min = ( 1196, 970, 200 );
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
    fe [[ f ]]( s, "PRIME_TARGET_CAROUSEL", cf, ( 3935.85, 1714.35, 474.47 ), ( 0, 0, 0 ), "PRIME_TARGET_CAROUSEL_reinforcement_enc_vol", undefined, "noent_volume_ai_encounter_cs", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_prime_target_cs";
    fe [[ f ]]( s, "PRIME_TARGET_CAROUSEL", cf, ( 3938.87, 1418.19, 616.91 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Proximity_Join_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 1920 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_prime_target_cs";
    s.ai_interaction = "idle_stretching";
    s.var_9a1a6bc9877cfff7 = "-1";
    s.repeat_interaction = "0";
    s.script_delay_max = "25";
    s.script_delay_min = "10";
    fe [[ f ]]( s, "PRIME_TARGET_CAROUSEL", cf, ( 3570.74, 1350.1, 535.46 ), ( 0, 225, 0 ), "pt_carousel_idle_stretch_01", undefined, "info_act", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_prime_target_cs";
    s.ai_interaction = "idle_smoke";
    s.var_9a1a6bc9877cfff7 = "-1";
    s.repeat_interaction = "0";
    s.script_delay_max = "25";
    s.script_delay_min = "10";
    fe [[ f ]]( s, "PRIME_TARGET_CAROUSEL", cf, ( 3533.11, 2051.75, 536.63 ), ( 0, 165, 0 ), "pt_carousel_idle_smoke_01", undefined, "info_act", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_prime_target_cs";
    s.ai_interaction = "idle_stretching";
    s.var_9a1a6bc9877cfff7 = "-1";
    s.repeat_interaction = "0";
    s.script_delay_max = "25";
    s.script_delay_min = "10";
    fe [[ f ]]( s, "PRIME_TARGET_CAROUSEL", cf, ( 4734.96, 1119.77, 597.09 ), ( 0, 180, 0 ), "pt_carousel_idle_stretch_02", undefined, "info_act", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_prime_target_cs";
    s.ai_interaction = "idle_smoke";
    s.var_9a1a6bc9877cfff7 = "-1";
    s.repeat_interaction = "0";
    s.script_delay_max = "25";
    s.script_delay_min = "10";
    fe [[ f ]]( s, "PRIME_TARGET_CAROUSEL", cf, ( 5248.22, 1760.02, 540.88 ), ( 0, 45, 0 ), "pt_carousel_idle_smoke_02", undefined, "info_act", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_prime_target_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.reverse_route = "1";
    s.start_point = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "PRIME_TARGET_CAROUSEL", cf, ( 4462.98, 2183.46, 551.84 ), ( 0, 0, 0 ), "cspf_1_auto12806473104580498483", "cspf_1_auto767939111694608526", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_prime_target_cs";
    s.location_spawnpoint = "0";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.name = "spawnpoint_boss";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "boss";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "PRIME_TARGET_CAROUSEL", cf, ( 2672.9, 1152.53, 511.05 ), ( 0, 278.94, 0 ), undefined, "cspf_1_auto14320132531446214948", "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_prime_target_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "PRIME_TARGET_CAROUSEL", cf, ( 3199.73, 839.49, 545.17 ), ( 0, 0, 0 ), "cspf_1_auto10520005119842451685", "cspf_1_auto5747520993233471551", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_prime_target_cs";
    s.loop_route = "1";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.start_point = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "PRIME_TARGET_CAROUSEL", cf, ( 2708.9, 1179.53, 512.19 ), ( 0, 0, 0 ), "cspf_1_auto14320132531446214948", "cspf_1_auto10520005119842451685", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_prime_target_cs";
    s.info_act_ref = "pt_carousel_idle_stretch_02";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "PRIME_TARGET_CAROUSEL", cf, ( 4814.96, 1095.77, 597.27 ), ( 0, 0, 0 ), "cspf_1_auto7669582170659943405", "cspf_1_auto17768481290162309677", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_prime_target_cs";
    s.loop_route = "1";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.start_point = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "PRIME_TARGET_CAROUSEL", cf, ( 4600.27, 1400.78, 597.02 ), ( 0, 0, 0 ), "cspf_1_auto11617906441223323745", "cspf_1_auto7669582170659943405", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_prime_target_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "PRIME_TARGET_CAROUSEL", cf, ( 5286.84, 680.51, 609.98 ), ( 0, 315, 0 ), "cspf_1_auto17768481290162309677", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_prime_target_cs";
    s.info_act_ref = "pt_carousel_idle_smoke_01";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "PRIME_TARGET_CAROUSEL", cf, ( 3549.11, 2027.75, 536.7 ), ( 0, 0, 0 ), "cspf_1_auto14010660558918058647", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_prime_target_cs";
    s.location_spawnpoint = "0";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.name = "spawnpoint_guard";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "PRIME_TARGET_CAROUSEL", cf, ( 4588.27, 1397.78, 597.01 ), ( 0, 278.94, 0 ), undefined, "cspf_1_auto11617906441223323745", "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_prime_target_cs";
    s.location_spawnpoint = "0";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.name = "spawnpoint_guard";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "PRIME_TARGET_CAROUSEL", cf, ( 2802.53, 2024.58, 511.91 ), ( 0, 278.94, 0 ), undefined, "cspf_1_auto2945013678501617174", "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_prime_target_cs";
    s.location_spawnpoint = "0";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.name = "spawnpoint_guard";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "PRIME_TARGET_CAROUSEL", cf, ( 4486.87, 2179.23, 551.78 ), ( 0, 278.94, 0 ), undefined, "cspf_1_auto12806473104580498483", "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_prime_target_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.reverse_route = "1";
    s.start_point = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "PRIME_TARGET_CAROUSEL", cf, ( 4179.46, 1361.47, 504.52 ), ( 0, 0, 0 ), "cspf_1_auto5506897521478685519", "cspf_1_auto18406914240695249544", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_prime_target_cs";
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
    fe [[ f ]]( s, "PRIME_TARGET_CAROUSEL", cf, ( 4215.46, 1342.47, 504.52 ), ( 0, 278.94, 0 ), undefined, "cspf_1_auto5506897521478685519", "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_prime_target_cs";
    s.location_spawnpoint = "0";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.name = "spawnpoint_guard";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "PRIME_TARGET_CAROUSEL", cf, ( 4405.2, 1687.65, 538.03 ), ( 0, 278.94, 0 ), undefined, "cspf_1_auto6185284556237548479", "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_prime_target_cs";
    s.info_act_ref = "pt_carousel_idle_stretch_01";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "PRIME_TARGET_CAROUSEL", cf, ( 3594.74, 1374.1, 534.89 ), ( 0, 0, 0 ), "cspf_1_auto18406914240695249544", "cspf_1_auto14010660558918058647", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_prime_target_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.reverse_route = "1";
    s.start_point = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "PRIME_TARGET_CAROUSEL", cf, ( 4331.2, 1690.65, 538 ), ( 0, 0, 0 ), "cspf_1_auto6185284556237548479", "cspf_1_auto11055434837918562807", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_prime_target_cs";
    s.info_act_ref = "pt_carousel_idle_smoke_02";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "PRIME_TARGET_CAROUSEL", cf, ( 5246.19, 1725, 540.39 ), ( 0, 0, 0 ), "cspf_1_auto11055434837918562807", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_prime_target_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "PRIME_TARGET_CAROUSEL", cf, ( 2844.3, 1759.06, 545.28 ), ( 0, 0, 0 ), "cspf_1_auto16170991564358797257", "cspf_1_auto5728001623942664285", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_prime_target_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.reverse_route = "1";
    s.start_point = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "PRIME_TARGET_CAROUSEL", cf, ( 2790.53, 2067.58, 513.06 ), ( 0, 0, 0 ), "cspf_1_auto2945013678501617174", "cspf_1_auto16170991564358797257", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_prime_target_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "PRIME_TARGET_CAROUSEL", cf, ( 2286.86, 1707.73, 544.96 ), ( 0, 0, 0 ), "cspf_1_auto5728001623942664285", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_prime_target_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "PRIME_TARGET_CAROUSEL", cf, ( 4228.54, 809.71, 532.71 ), ( 0, 0, 0 ), "cspf_1_auto5747520993233471551", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace mp_sat_avalon_city_ob_activity_prime_target_cs
// Params 0, eflags: 0x4
// Checksum 0x99405d11, Offset: 0x2219
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace mp_sat_avalon_city_ob_activity_prime_target_cs
// Params 0
// Checksum 0xb59d524c, Offset: 0x2223
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "mp_sat_avalon_city_ob_activity_prime_target_cs" );
}

// Namespace mp_sat_avalon_city_ob_activity_prime_target_cs
// Params 0
// Checksum 0xd38c8841, Offset: 0x2239
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

// Namespace mp_sat_avalon_city_ob_activity_prime_target_cs
// Params 4
// Checksum 0x114fb6cd, Offset: 0x22a8
// Size: 0x57
function function_d4323822d7042e5a( var_4312b79c960726b6, fe, us, cf = "mp_sat_avalon_city_ob_activity_prime_target_cs" )
{
    switch ( var_4312b79c960726b6 )
    {
        case #"hash_472fa014288b1dab":
            function_de40fac9ea3a8e73( fe, us, cf );
            break;
    }
}

// Namespace mp_sat_avalon_city_ob_activity_prime_target_cs
// Params 3
// Checksum 0xd4492b23, Offset: 0x2307
// Size: 0xae
function function_de40fac9ea3a8e73( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_prime_target_cs";
    s.name = "prime_target_boss_spawnpoint";
    fe [[ f ]]( s, "PRIME_TARGET_CAROUSEL", cf, ( 3932.64, 1461.92, 538 ), ( 0, 0, 0 ), "encounter_spawntarget", undefined, "PRIME_TARGET_CAROUSEL", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 768 );
}

// Namespace mp_sat_avalon_city_ob_activity_prime_target_cs
// Params 0
// Checksum 0x9d2bfa71, Offset: 0x23bd
// Size: 0xae
function function_d9dd7965c51c95d1()
{
    activityinstances = [];
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_ob_activitydefinition_primetarget";
    var_881289d7987bc770.cf = "mp_sat_avalon_city_ob_activity_prime_target_cs";
    var_881289d7987bc770.scriptstructorigin = ( 3909.13, 1727.74, 1103.62 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [];
    var_881289d7987bc770.var_31ce4477e3543d24 = [];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [];
    var_881289d7987bc770.locationradius = [];
    activityinstances[ "PRIME_TARGET_CAROUSEL" ] = var_881289d7987bc770;
    return activityinstances;
}

