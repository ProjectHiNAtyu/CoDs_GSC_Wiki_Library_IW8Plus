// script_5ab22dda0fb7f0  (hash_005ab22dda0fb7f0.gscc) (size: 23798 Bytes / 0x5cf6 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x72187865 (1914206309)
// size ...... 23798 (0x5cf6)
// includes .. 4   (offset: 0x4f26)
// strings ... 86  (offset: 0x4f46)
// dev strs .. 0   (offset: 0x5cf6)
// exports ... 14  (offset: 0x49fa)
// cseg ...... 0x9e9 + 0x4011 (0x49fa)
// imports ... 27  (offset: 0x4c2a)
// animtree1 . 0   (offset: 0x5cf6)
// animtree2 . 0   (offset: 0x5cf6)
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace mp_sat_avalon_q1_ob_activity_heli_takedown_cs;

// Namespace mp_sat_avalon_q1_ob_activity_heli_takedown_cs
// Params 0, eflags: 0x5
// Checksum 0xe3895503, Offset: 0xa07
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"mp_sat_avalon_q1_ob_activity_heli_takedown_cs", #"activity_common", &function_b39ecd3d51489472, undefined );
}

// Namespace mp_sat_avalon_q1_ob_activity_heli_takedown_cs
// Params 0, eflags: 0x4
// Checksum 0xd3e15f40, Offset: 0xa30
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace mp_sat_avalon_q1_ob_activity_heli_takedown_cs
// Params 0, eflags: 0x4
// Checksum 0x56da8cac, Offset: 0xa41
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace mp_sat_avalon_q1_ob_activity_heli_takedown_cs
// Params 2
// Checksum 0x46ef1ac8, Offset: 0xa52
// Size: 0x8c
function main( unused, unused2 )
{
    if ( utility::flag_exist( "mp_sat_avalon_q1_ob_activity_heli_takedown_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "mp_sat_avalon_q1_ob_activity_heli_takedown_cs" ) )
    {
        return;
    }
    
    activity_common::function_e1df676808c1d1e3( &function_4cd78e661617f3 );
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "mp_sat_avalon_q1_ob_activity_heli_takedown_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "mp_sat_avalon_q1_ob_activity_heli_takedown_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace mp_sat_avalon_q1_ob_activity_heli_takedown_cs
// Params 3, eflags: 0x4
// Checksum 0xd5583863, Offset: 0xae6
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "mp_sat_avalon_q1_ob_activity_heli_takedown_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "mp_sat_avalon_q1_ob_activity_heli_takedown_cs" );
}

// Namespace mp_sat_avalon_q1_ob_activity_heli_takedown_cs
// Params 3, eflags: 0x4
// Checksum 0x84eed34d, Offset: 0xb60
// Size: 0x2956
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_heli_takedown_cs";
    s.activity_bundle = "sat_activitydef_activity_helitakedown";
    s.name = "HELI_TAKEDOWN_Q1_STADIUM";
    s.var_265c4f33e2a6daa7 = "1";
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q1_STADIUM", cf, ( -46641.9, 21793.2, 755.57 ), ( 0, 101.39, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_heli_takedown_cs";
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q1_STADIUM", cf, ( -46654.6, 21798, 787.04 ), ( 0, 101.39, 0 ), "activity_nexus_spatial_zone", undefined, "join_radius", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 2500 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_heli_takedown_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "500";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "ht_short";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q1_STADIUM", cf, ( -45765.3, 21874.1, 719.9 ), ( 0, 134.39, 0 ), undefined, "cspf_1_auto10863636412982703467", "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_heli_takedown_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.reverse_route = "1";
    s.start_point = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q1_STADIUM", cf, ( -46322, 22568.6, 719.89 ), ( 0, 249.62, 0 ), "cspf_1_auto10863636412982703467", "cspf_1_auto10847846362951288487", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_heli_takedown_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.reverse_route = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q1_STADIUM", cf, ( -46814.1, 22649, 718.01 ), ( 0, 249.62, 0 ), "cspf_1_auto10847846362951288487", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_heli_takedown_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "500";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "ht_short";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q1_STADIUM", cf, ( -46937, 21029.9, 719.87 ), ( 0, 320.38, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_heli_takedown_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "500";
    s.preferred_spawnpoint = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "ht_long";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q1_STADIUM", cf, ( -47105.5, 21298.3, 719.67 ), ( 0, 235.91, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_heli_takedown_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "500";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "ht_long";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q1_STADIUM", cf, ( -47254.7, 21508.1, 719.88 ), ( 0, 223.2, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_heli_takedown_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "500";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "ht_long";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q1_STADIUM", cf, ( -46836, 20844.4, 719.89 ), ( 0, 44.39, 0 ), undefined, "cspf_1_auto7147688311945460799", "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_heli_takedown_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "500";
    s.preferred_spawnpoint = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "ht_short";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q1_STADIUM", cf, ( -46422.4, 22454.7, 719.83 ), ( 0, 46.99, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_heli_takedown_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "500";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "ht_short";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q1_STADIUM", cf, ( -46625.6, 22852.8, 717.84 ), ( 0, 242.39, 0 ), undefined, "cspf_1_auto5837052364958190009", "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_heli_takedown_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "500";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "ht_long";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q1_STADIUM", cf, ( -46984.6, 20860.2, 719.89 ), ( 0, 134.39, 0 ), undefined, "cspf_1_auto2068967809947837597", "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_heli_takedown_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.reverse_route = "1";
    s.start_point = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q1_STADIUM", cf, ( -47194.3, 22465.3, 719.02 ), ( 0, 43.62, 0 ), "cspf_1_auto5837052364958190009", "cspf_1_auto15010539576255324433", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_heli_takedown_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.reverse_route = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q1_STADIUM", cf, ( -47363.2, 21719.1, 719.85 ), ( 0, 159.62, 0 ), "cspf_1_auto15010539576255324433", "cspf_1_auto14535033379445729085", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_heli_takedown_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "500";
    s.preferred_spawnpoint = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "ht_short";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q1_STADIUM", cf, ( -47584.8, 21919.6, 719.9 ), ( 0, 316.64, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_heli_takedown_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.reverse_route = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q1_STADIUM", cf, ( -47229.3, 21007, 719.88 ), ( 0, 159.62, 0 ), "cspf_1_auto14535033379445729085", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_heli_takedown_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.reverse_route = "1";
    s.start_point = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q1_STADIUM", cf, ( -46089.3, 21456.3, 718.58 ), ( 0, 159.62, 0 ), "cspf_1_auto7147688311945460799", "cspf_1_auto7850959231254042433", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_heli_takedown_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.reverse_route = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q1_STADIUM", cf, ( -45530.2, 21942.8, 719.89 ), ( 0, 159.62, 0 ), "cspf_1_auto7850959231254042433", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_heli_takedown_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.reverse_route = "1";
    s.start_point = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q1_STADIUM", cf, ( -47492, 21584.2, 719.88 ), ( 0, 249.62, 0 ), "cspf_1_auto2068967809947837597", "cspf_1_auto18292375127441977161", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_heli_takedown_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.reverse_route = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q1_STADIUM", cf, ( -46555.7, 22270.7, 719.2 ), ( 0, 249.62, 0 ), "cspf_1_auto18292375127441977161", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_heli_takedown_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "500";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "ht_long";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q1_STADIUM", cf, ( -45948, 21892.6, 719.89 ), ( 0, 348.02, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_heli_takedown_cs";
    s._size_max = ( 2466.16, 2690.25, 572 );
    s._size_min = ( -192.487, 408.829, 32 );
    s.var_5afd49978f924648 = "1";
    s.var_a8568d8e0b0b6076 = "1";
    s.var_3f3960eb7318312d = "1";
    s.default_goal_radius = "-1";
    s.height = 128;
    s.length = "128";
    s.script_stealthgroup = "-1";
    s.script_string = "sat_heli_takedown_enc_soldier";
    s.var_95e2cee7aca5aaae = "1";
    s.width = "128";
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q1_STADIUM", cf, ( -44952.1, 21427.8, 623.5 ), ( 0, 126.39, 0 ), "encounter_HELI_TAKEDOWN_Q1_STADIUM_RADIANT", undefined, "noent_volume_ai_encounter_cs", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_heli_takedown_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "500";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "ht_dawg";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q1_STADIUM", cf, ( -46221.6, 22074.2, 719.8 ), ( 0, 44.39, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_heli_takedown_cs";
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q1_STADIUM", cf, ( -46671.4, 21768.6, 722.2 ), ( 0, 126.39, 0 ), "activity_nexus_spatial_zone", undefined, "Ambient_AI_Exclusion_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 1800 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_heli_takedown_cs";
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q1_STADIUM", cf, ( -46651.4, 21589.6, 739.09 ), ( 0, 141.08, 0 ), "activity_nexus_spatial_zone", undefined, "Awareness_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 5000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_heli_takedown_cs";
    s.activity_bundle = "sat_activitydef_activity_helitakedown";
    s.name = "HELI_TAKEDOWN_Q1_TENNIS_COURT";
    s.var_265c4f33e2a6daa7 = "1";
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q1_TENNIS_COURT", cf, ( -18207.1, 40207.7, 1635.09 ), ( 0, 218.59, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_heli_takedown_cs";
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q1_TENNIS_COURT", cf, ( -18003.7, 40099.8, 1666.56 ), ( 0, 218.59, 0 ), "activity_nexus_spatial_zone", undefined, "join_radius", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 2000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_heli_takedown_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "500";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "ht_long";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q1_TENNIS_COURT", cf, ( -18565.1, 40776.8, 1599.07 ), ( 0, 222.41, 0 ), undefined, "cspf_2_auto10863636412982703467", "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_heli_takedown_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.reverse_route = "1";
    s.start_point = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q1_TENNIS_COURT", cf, ( -18998.6, 40463.7, 1599.07 ), ( 0, 6.81, 0 ), "cspf_2_auto10863636412982703467", "cspf_2_auto10847846362951288487", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_heli_takedown_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.reverse_route = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q1_TENNIS_COURT", cf, ( -18591.7, 39935.9, 1611.02 ), ( 0, 6.81, 0 ), "cspf_2_auto10847846362951288487", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_heli_takedown_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "500";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "ht_short";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q1_TENNIS_COURT", cf, ( -18891.5, 40460.6, 1599.07 ), ( 0, 325.83, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_heli_takedown_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "500";
    s.preferred_spawnpoint = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "ht_long";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q1_TENNIS_COURT", cf, ( -17481.6, 40050.4, 1601.77 ), ( 0, 353.11, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_heli_takedown_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "500";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "ht_long";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q1_TENNIS_COURT", cf, ( -17642.5, 39754.9, 1599.05 ), ( 0, 340.39, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_heli_takedown_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "500";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "ht_short";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q1_TENNIS_COURT", cf, ( -16960.4, 40222.8, 1401.14 ), ( 0, 142.27, 0 ), undefined, "cspf_2_auto7147688311945460799", "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_heli_takedown_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "500";
    s.preferred_spawnpoint = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "ht_short";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q1_TENNIS_COURT", cf, ( -19026.4, 40500.2, 1599.07 ), ( 0, 164.19, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_heli_takedown_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "500";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "ht_short";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q1_TENNIS_COURT", cf, ( -18693.2, 39883.5, 1626.01 ), ( 0, 352.61, 0 ), undefined, "cspf_2_auto5837052364958190009", "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_heli_takedown_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "500";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "ht_short";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q1_TENNIS_COURT", cf, ( -18202.8, 40510, 1594.06 ), ( 0, 341.58, 0 ), undefined, "cspf_2_auto2068967809947837597", "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_heli_takedown_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.reverse_route = "1";
    s.start_point = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q1_TENNIS_COURT", cf, ( -17557.6, 39170.4, 1543.12 ), ( 0, 160.81, 0 ), "cspf_2_auto5837052364958190009", "cspf_2_auto15010539576255324433", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_heli_takedown_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.reverse_route = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q1_TENNIS_COURT", cf, ( -17427.3, 39566.1, 1493.27 ), ( 0, 276.81, 0 ), "cspf_2_auto15010539576255324433", "cspf_2_auto14535033379445729085", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_heli_takedown_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "500";
    s.preferred_spawnpoint = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "ht_long";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q1_TENNIS_COURT", cf, ( -17251.4, 40223, 1515.41 ), ( 0, 343.84, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_heli_takedown_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.reverse_route = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q1_TENNIS_COURT", cf, ( -17263.5, 40154.2, 1514.89 ), ( 0, 276.81, 0 ), "cspf_2_auto14535033379445729085", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_heli_takedown_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.reverse_route = "1";
    s.start_point = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q1_TENNIS_COURT", cf, ( -17870.2, 41316.2, 1455.07 ), ( 0, 276.81, 0 ), "cspf_2_auto7147688311945460799", "cspf_2_auto7850959231254042433", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_heli_takedown_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.reverse_route = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q1_TENNIS_COURT", cf, ( -18474.2, 40825.7, 1592.37 ), ( 0, 276.81, 0 ), "cspf_2_auto7850959231254042433", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_heli_takedown_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.reverse_route = "1";
    s.start_point = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q1_TENNIS_COURT", cf, ( -17581.9, 40291.3, 1589.05 ), ( 0, 6.81, 0 ), "cspf_2_auto2068967809947837597", "cspf_2_auto18292375127441977161", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_heli_takedown_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.reverse_route = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q1_TENNIS_COURT", cf, ( -17566.4, 39686.7, 1611.05 ), ( 0, 6.81, 0 ), "cspf_2_auto18292375127441977161", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_heli_takedown_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "500";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "ht_long";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q1_TENNIS_COURT", cf, ( -17804.5, 40575.1, 1586.99 ), ( 0, 105.22, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_heli_takedown_cs";
    s._size_max = ( 2000.31, 2350.23, 626 );
    s._size_min = ( -585.122, -117.426, 32 );
    s.var_5afd49978f924648 = "1";
    s.var_a8568d8e0b0b6076 = "1";
    s.var_3f3960eb7318312d = "1";
    s.default_goal_radius = "-1";
    s.height = 128;
    s.length = "128";
    s.script_stealthgroup = "-1";
    s.script_string = "sat_heli_takedown_enc_soldier";
    s.var_95e2cee7aca5aaae = "1";
    s.width = "128";
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q1_TENNIS_COURT", cf, ( -18654.5, 41877.7, 1361.09 ), ( 0, 243.59, 0 ), "encounter_HELI_TAKEDOWN_Q1_TENNIS_COURT_RADIANT", undefined, "noent_volume_ai_encounter_cs", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_heli_takedown_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "500";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "ht_dawg";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q1_TENNIS_COURT", cf, ( -18153.6, 39930.9, 1601.07 ), ( 0, 251.58, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_heli_takedown_cs";
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q1_TENNIS_COURT", cf, ( -17964.3, 40095.1, 1808.08 ), ( 0, 243.59, 0 ), "activity_nexus_spatial_zone", undefined, "Ambient_AI_Exclusion_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 1800 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_heli_takedown_cs";
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q1_TENNIS_COURT", cf, ( -17963.7, 40244.4, 1634.11 ), ( 0, 141.08, 0 ), "activity_nexus_spatial_zone", undefined, "Awareness_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 5000 );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace mp_sat_avalon_q1_ob_activity_heli_takedown_cs
// Params 0, eflags: 0x4
// Checksum 0x516bae85, Offset: 0x34be
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace mp_sat_avalon_q1_ob_activity_heli_takedown_cs
// Params 0
// Checksum 0x170be52e, Offset: 0x34c8
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "mp_sat_avalon_q1_ob_activity_heli_takedown_cs" );
}

// Namespace mp_sat_avalon_q1_ob_activity_heli_takedown_cs
// Params 0
// Checksum 0x90c852d0, Offset: 0x34de
// Size: 0x66
function function_4cd78e661617f3()
{
    activityinfostruct = {};
    activityinfostruct.name = "REV_OB_HELI_TAKEDOWN";
    activityinfostruct.scriptbundle = "sat_activitydef_activity_helitakedown";
    activityinfostruct.mainfunction = &main;
    activityinfostruct.var_934f068483ae4ddb = &function_d4323822d7042e5a;
    activityinfostruct.metadatafunction = &function_d9dd7965c51c95d1;
    return activityinfostruct;
}

// Namespace mp_sat_avalon_q1_ob_activity_heli_takedown_cs
// Params 4
// Checksum 0x11a0efb8, Offset: 0x354d
// Size: 0x71
function function_d4323822d7042e5a( var_4312b79c960726b6, fe, us, cf = "mp_sat_avalon_q1_ob_activity_heli_takedown_cs" )
{
    switch ( var_4312b79c960726b6 )
    {
        case #"hash_3b065422aa320304":
            function_a31a1a27c337e84c( fe, us, cf );
            break;
        case #"hash_b4682619556b539e":
            function_4f2bd477665821a6( fe, us, cf );
            break;
    }
}

// Namespace mp_sat_avalon_q1_ob_activity_heli_takedown_cs
// Params 3
// Checksum 0xc7ee078d, Offset: 0x35c6
// Size: 0x962
function function_a31a1a27c337e84c( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_heli_takedown_cs";
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q1_STADIUM", cf, ( -46473, 21946.1, 1880.97 ), ( 0, 35, 0 ), "HELI_TAKEDOWN_Q1_STADIUM", undefined, undefined, "cspf_3_1", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_heli_takedown_cs";
    s.groupid = "vtol_escape_path";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q1_STADIUM", cf, ( -46876.4, 21616, 876.27 ), ( 0, 215, 0 ), "s_heli_takedown_heli_spawn", "cspf_3_auto8494757589517366665", undefined, "cspf_3_2", "cspf_3_1", ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 10, 1 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_heli_takedown_cs";
    s.groupid = "vtol_escape_path";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q1_STADIUM", cf, ( -47375.2, 20823.2, 2214.03 ), ( 0, 7.83, 0 ), "cspf_3_auto8494757589517366665", "cspf_3_auto4612352738519139850", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_heli_takedown_cs";
    s.groupid = "vtol_escape_path";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q1_STADIUM", cf, ( -47367.8, 20428.3, 2984.03 ), ( 0, 315.15, 0 ), "cspf_3_auto4612352738519139850", "cspf_3_auto10095321859284440761", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_heli_takedown_cs";
    s.groupid = "vtol_escape_path";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q1_STADIUM", cf, ( -47254, 20107.4, 3606.43 ), ( 0, 315.15, 0 ), "cspf_3_auto10095321859284440761", "cspf_3_auto9117064054671232171", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_heli_takedown_cs";
    s.groupid = "vtol_escape_path";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q1_STADIUM", cf, ( -46945.5, 19745.9, 4135.43 ), ( 0, 315.15, 0 ), "cspf_3_auto9117064054671232171", "cspf_3_auto17546438238563180426", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_heli_takedown_cs";
    s.groupid = "vtol_escape_path";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q1_STADIUM", cf, ( -45909.3, 19502.8, 4558.93 ), ( 0, 315.15, 0 ), "cspf_3_auto17546438238563180426", "cspf_3_auto3392554419138434722", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_heli_takedown_cs";
    s.groupid = "vtol_escape_path";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q1_STADIUM", cf, ( -44209, 19702.8, 4899.43 ), ( 0, 313.55, 0 ), "cspf_3_auto3392554419138434722", "cspf_3_auto678961591699957337", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_heli_takedown_cs";
    s.groupid = "vtol_escape_path";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q1_STADIUM", cf, ( -43052.6, 20187, 4969.43 ), ( 0, 19.2, 0 ), "cspf_3_auto678961591699957337", "cspf_3_auto17798406878246190170", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_heli_takedown_cs";
    s.groupid = "vtol_escape_path";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q1_STADIUM", cf, ( -41963.5, 20909, 5088.93 ), ( 0, 19.2, 0 ), "cspf_3_auto17798406878246190170", "cspf_3_auto14348649893522508367", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_heli_takedown_cs";
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q1_STADIUM", cf, ( -32530.2, 21955.9, 5163.44 ), ( 0, 277.75, 0 ), "heli_leave", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_heli_takedown_cs";
    s.groupid = "vtol_escape_path";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q1_STADIUM", cf, ( -40675.6, 22262.7, 5155.93 ), ( 0, 19.2, 0 ), "cspf_3_auto14348649893522508367", "cspf_3_auto13757901738603966073", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_heli_takedown_cs";
    s.groupid = "vtol_escape_path";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q1_STADIUM", cf, ( -39275.9, 23219.8, 5163.93 ), ( 0, 315.15, 0 ), "cspf_3_auto13757901738603966073", "cspf_3_auto4562139456735891158", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_heli_takedown_cs";
    s.groupid = "vtol_escape_path";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q1_STADIUM", cf, ( -38059.1, 23357.9, 5163.93 ), ( 0, 265.15, 0 ), "cspf_3_auto4562139456735891158", "cspf_3_auto8766061891730312246", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_heli_takedown_cs";
    s.groupid = "vtol_escape_path";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q1_STADIUM", cf, ( -35540.2, 22836, 5098.93 ), ( 0, 315.15, 0 ), "cspf_3_auto8766061891730312246", "cspf_3_auto14709416443788656615", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_heli_takedown_cs";
    s.groupid = "vtol_escape_path";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q1_STADIUM", cf, ( -32908.4, 22081.6, 5153.43 ), ( 0, 275.87, 0 ), "cspf_3_auto14709416443788656615", "cspf_3_auto15600294591917143653", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_heli_takedown_cs";
    s.groupid = "vtol_escape_path";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q1_STADIUM", cf, ( -30081.1, 21122.5, 5153.43 ), ( 0, 275.87, 0 ), "cspf_3_auto15600294591917143653", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_heli_takedown_cs";
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q1_STADIUM", cf, ( -47762.9, 22154.6, 705.09 ), ( 0, 101.39, 0 ), "s_heli_takedown_teleport", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_heli_takedown_cs";
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q1_STADIUM", cf, ( -44893.2, 21405.2, 680.83 ), ( 0, 126.39, 0 ), "HELI_TAKEDOWN_Q1_STADIUM_RADIANT", "encounter_HELI_TAKEDOWN_Q1_STADIUM_RADIANT", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_sat_avalon_q1_ob_activity_heli_takedown_cs
// Params 3
// Checksum 0xa56c9d24, Offset: 0x3f30
// Size: 0x962
function function_4f2bd477665821a6( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_heli_takedown_cs";
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q1_TENNIS_COURT", cf, ( -18396.5, 40373.9, 2760.49 ), ( 0, 155, 0 ), "HELI_TAKEDOWN_Q1_TENNIS_COURT", undefined, undefined, "cspf_4_1", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_heli_takedown_cs";
    s.groupid = "vtol_escape_path";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q1_TENNIS_COURT", cf, ( -17942.4, 40080.1, 1755.79 ), ( 0, 335, 0 ), "s_heli_takedown_heli_spawn", "cspf_4_auto8494757589517366665", undefined, "cspf_4_2", "cspf_4_1", ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 10, 1 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_heli_takedown_cs";
    s.groupid = "vtol_escape_path";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q1_TENNIS_COURT", cf, ( -17009.2, 39998.9, 3093.55 ), ( 0, 125.03, 0 ), "cspf_4_auto8494757589517366665", "cspf_4_auto4612352738519139850", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_heli_takedown_cs";
    s.groupid = "vtol_escape_path";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q1_TENNIS_COURT", cf, ( -16661.4, 40185.9, 3863.55 ), ( 0, 72.35, 0 ), "cspf_4_auto4612352738519139850", "cspf_4_auto10095321859284440761", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_heli_takedown_cs";
    s.groupid = "vtol_escape_path";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q1_TENNIS_COURT", cf, ( -16428, 40433.8, 4485.95 ), ( 0, 72.35, 0 ), "cspf_4_auto10095321859284440761", "cspf_4_auto9117064054671232171", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_heli_takedown_cs";
    s.groupid = "vtol_escape_path";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q1_TENNIS_COURT", cf, ( -16247.5, 40873.5, 5014.95 ), ( 0, 72.35, 0 ), "cspf_4_auto9117064054671232171", "cspf_4_auto17546438238563180426", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_heli_takedown_cs";
    s.groupid = "vtol_escape_path";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q1_TENNIS_COURT", cf, ( -16504.8, 41906.2, 5438.45 ), ( 0, 72.35, 0 ), "cspf_4_auto17546438238563180426", "cspf_4_auto3392554419138434722", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_heli_takedown_cs";
    s.groupid = "vtol_escape_path";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q1_TENNIS_COURT", cf, ( -17459.9, 43327.1, 5778.95 ), ( 0, 70.74, 0 ), "cspf_4_auto3392554419138434722", "cspf_4_auto678961591699957337", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_heli_takedown_cs";
    s.groupid = "vtol_escape_path";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q1_TENNIS_COURT", cf, ( -18419.1, 44134.3, 5848.95 ), ( 0, 136.4, 0 ), "cspf_4_auto678961591699957337", "cspf_4_auto17798406878246190170", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_heli_takedown_cs";
    s.groupid = "vtol_escape_path";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q1_TENNIS_COURT", cf, ( -19559.1, 44773, 5968.45 ), ( 0, 136.4, 0 ), "cspf_4_auto17798406878246190170", "cspf_4_auto14348649893522508367", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_heli_takedown_cs";
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q1_TENNIS_COURT", cf, ( -24802, 52684.7, 6042.96 ), ( 0, 34.95, 0 ), "heli_leave", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_heli_takedown_cs";
    s.groupid = "vtol_escape_path";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q1_TENNIS_COURT", cf, ( -21351.8, 45299.7, 6035.45 ), ( 0, 136.4, 0 ), "cspf_4_auto14348649893522508367", "cspf_4_auto13757901738603966073", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_heli_takedown_cs";
    s.groupid = "vtol_escape_path";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q1_TENNIS_COURT", cf, ( -22842.8, 46107.2, 6043.45 ), ( 0, 72.35, 0 ), "cspf_4_auto13757901738603966073", "cspf_4_auto4562139456735891158", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_heli_takedown_cs";
    s.groupid = "vtol_escape_path";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q1_TENNIS_COURT", cf, ( -23521.8, 47126.3, 6043.45 ), ( 0, 22.35, 0 ), "cspf_4_auto4562139456735891158", "cspf_4_auto8766061891730312246", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_heli_takedown_cs";
    s.groupid = "vtol_escape_path";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q1_TENNIS_COURT", cf, ( -24209, 49605.3, 5978.45 ), ( 0, 72.35, 0 ), "cspf_4_auto8766061891730312246", "cspf_4_auto14709416443788656615", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_heli_takedown_cs";
    s.groupid = "vtol_escape_path";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q1_TENNIS_COURT", cf, ( -24740.9, 52290.9, 6032.95 ), ( 0, 33.06, 0 ), "cspf_4_auto14709416443788656615", "cspf_4_auto15600294591917143653", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_heli_takedown_cs";
    s.groupid = "vtol_escape_path";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q1_TENNIS_COURT", cf, ( -25180.1, 55243.9, 6032.95 ), ( 0, 33.06, 0 ), "cspf_4_auto15600294591917143653", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_heli_takedown_cs";
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q1_TENNIS_COURT", cf, ( -18016.2, 39045.5, 1584.61 ), ( 0, 218.59, 0 ), "s_heli_takedown_teleport", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_heli_takedown_cs";
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q1_TENNIS_COURT", cf, ( -18661.3, 41940.4, 1560.34 ), ( 0, 243.59, 0 ), "HELI_TAKEDOWN_Q1_TENNIS_COURT_RADIANT", "encounter_HELI_TAKEDOWN_Q1_TENNIS_COURT_RADIANT", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_sat_avalon_q1_ob_activity_heli_takedown_cs
// Params 0
// Checksum 0x22ef5bf5, Offset: 0x489a
// Size: 0x15f
function function_d9dd7965c51c95d1()
{
    activityinstances = [];
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_activitydef_activity_helitakedown";
    var_881289d7987bc770.var_265c4f33e2a6daa7 = 1;
    var_881289d7987bc770.cf = "mp_sat_avalon_q1_ob_activity_heli_takedown_cs";
    var_881289d7987bc770.scriptstructorigin = ( -46641.9, 21793.2, 755.57 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [];
    var_881289d7987bc770.var_31ce4477e3543d24 = [];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [];
    var_881289d7987bc770.locationradius = [];
    activityinstances[ "HELI_TAKEDOWN_Q1_STADIUM" ] = var_881289d7987bc770;
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_activitydef_activity_helitakedown";
    var_881289d7987bc770.var_265c4f33e2a6daa7 = 1;
    var_881289d7987bc770.cf = "mp_sat_avalon_q1_ob_activity_heli_takedown_cs";
    var_881289d7987bc770.scriptstructorigin = ( -18207.1, 40207.7, 1635.09 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [];
    var_881289d7987bc770.var_31ce4477e3543d24 = [];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [];
    var_881289d7987bc770.locationradius = [];
    activityinstances[ "HELI_TAKEDOWN_Q1_TENNIS_COURT" ] = var_881289d7987bc770;
    return activityinstances;
}

