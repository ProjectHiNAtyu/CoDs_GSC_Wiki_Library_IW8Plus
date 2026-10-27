// script_3e264eb2549fd19a  (hash_3e264eb2549fd19a.gscc) (size: 38638 Bytes / 0x96ee / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xb1ea0ba8 (2984905640)
// size ...... 38638 (0x96ee)
// includes .. 4   (offset: 0x8072)
// strings ... 132 (offset: 0x8092)
// dev strs .. 0   (offset: 0x96ee)
// exports ... 16  (offset: 0x7ab6)
// cseg ...... 0xfae + 0x6b08 (0x7ab6)
// imports ... 29  (offset: 0x7d36)
// animtree1 . 0   (offset: 0x96ee)
// animtree2 . 0   (offset: 0x96ee)
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace mp_sat_avalon_q2_ob_heli_takedown_cs;

// Namespace mp_sat_avalon_q2_ob_heli_takedown_cs
// Params 0, eflags: 0x5
// Checksum 0xb08b9f07, Offset: 0xfcc
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"mp_sat_avalon_q2_ob_heli_takedown_cs", #"activity_common", &function_b39ecd3d51489472, undefined );
}

// Namespace mp_sat_avalon_q2_ob_heli_takedown_cs
// Params 0, eflags: 0x4
// Checksum 0xcf52a605, Offset: 0xff5
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace mp_sat_avalon_q2_ob_heli_takedown_cs
// Params 0, eflags: 0x4
// Checksum 0x4a6975e9, Offset: 0x1006
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace mp_sat_avalon_q2_ob_heli_takedown_cs
// Params 2
// Checksum 0xb0ccc8ff, Offset: 0x1017
// Size: 0x8c
function main( unused, unused2 )
{
    if ( utility::flag_exist( "mp_sat_avalon_q2_ob_heli_takedown_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "mp_sat_avalon_q2_ob_heli_takedown_cs" ) )
    {
        return;
    }
    
    activity_common::function_e1df676808c1d1e3( &function_4cd78e661617f3 );
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "mp_sat_avalon_q2_ob_heli_takedown_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "mp_sat_avalon_q2_ob_heli_takedown_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace mp_sat_avalon_q2_ob_heli_takedown_cs
// Params 3, eflags: 0x4
// Checksum 0xc9ebc126, Offset: 0x10ab
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "mp_sat_avalon_q2_ob_heli_takedown_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "mp_sat_avalon_q2_ob_heli_takedown_cs" );
}

// Namespace mp_sat_avalon_q2_ob_heli_takedown_cs
// Params 3, eflags: 0x4
// Checksum 0x79bcc725, Offset: 0x1125
// Size: 0x3e83
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_heli_takedown_cs";
    s.activity_bundle = "sat_activitydef_activity_helitakedown";
    s.name = "HELI_TAKEDOWN_Q2_LOW_TOWN";
    s.var_265c4f33e2a6daa7 = "1";
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q2_LOW_TOWN", cf, ( 11823.6, 5415.1, 269.79 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_heli_takedown_cs";
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q2_LOW_TOWN", cf, ( 11823.2, 5372.54, 271.18 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Ambient_AI_Exclusion_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 2000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_heli_takedown_cs";
    s.name = "script_struct_activity_instance_nexus_radius";
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q2_LOW_TOWN", cf, ( 11823.3, 5307.55, 273.9 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "join_radius", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 2000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_heli_takedown_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "500";
    s.preferred_spawnpoint = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "ht_short";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q2_LOW_TOWN", cf, ( 12121.7, 5128.77, 260.74 ), ( 0, 270.74, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_heli_takedown_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "500";
    s.preferred_spawnpoint = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "ht_short";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q2_LOW_TOWN", cf, ( 12749.3, 5591.01, 254.01 ), ( 0, 188.99, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_heli_takedown_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "500";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "ht_long";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q2_LOW_TOWN", cf, ( 11626.5, 4843.18, 331.48 ), ( 0, 202.25, 0 ), undefined, "cspf_1_auto10863636412982703467", "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_heli_takedown_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.reverse_route = "1";
    s.start_point = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q2_LOW_TOWN", cf, ( 11268.2, 4725.68, 358.16 ), ( 0, 212.48, 0 ), "cspf_1_auto10863636412982703467", "cspf_1_auto10847846362951288487", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_heli_takedown_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.reverse_route = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q2_LOW_TOWN", cf, ( 11068.1, 4515.28, 401.17 ), ( 0, 212.48, 0 ), "cspf_1_auto10847846362951288487", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_heli_takedown_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "500";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "ht_long";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q2_LOW_TOWN", cf, ( 12519.6, 5201.11, 254.59 ), ( 0, 138.9, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_heli_takedown_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "500";
    s.preferred_spawnpoint = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "ht_short";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q2_LOW_TOWN", cf, ( 11519.6, 5972.64, 261.96 ), ( 0, 177.49, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_heli_takedown_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "500";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "ht_long";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q2_LOW_TOWN", cf, ( 12460.7, 5772.92, 256 ), ( 0, 219.81, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_heli_takedown_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "500";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "ht_short";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q2_LOW_TOWN", cf, ( 12171.6, 6163.97, 256 ), ( 0, 254.05, 0 ), undefined, "cspf_1_auto7147688311945460799", "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_heli_takedown_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "500";
    s.preferred_spawnpoint = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "ht_long";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q2_LOW_TOWN", cf, ( 11145, 5179.53, 327.27 ), ( 0, 137.07, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_heli_takedown_cs";
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q2_LOW_TOWN", cf, ( 11823.3, 5339.9, 272.5 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Awareness_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 5000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_heli_takedown_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.reverse_route = "1";
    s.start_point = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q2_LOW_TOWN", cf, ( 12035.2, 5889.91, 253.97 ), ( 0, 122.48, 0 ), "cspf_1_auto7147688311945460799", "cspf_1_auto7850959231254042433", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_heli_takedown_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.reverse_route = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q2_LOW_TOWN", cf, ( 11728.9, 5889.22, 253.97 ), ( 0, 122.48, 0 ), "cspf_1_auto7850959231254042433", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_heli_takedown_cs";
    s._size_max = ( 860.68, 865.15, 877.609 );
    s._size_min = ( 684.957, 990.37, 32 );
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
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q2_LOW_TOWN", cf, ( 11886.4, 5402.23, 266.38 ), ( 0, 90.1, 0 ), "encounter_HELI_TAKEDOWN_Q2_LOW_TOWN_RADIANT", undefined, "noent_volume_ai_encounter_cs", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_heli_takedown_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "500";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "ht_dawg";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q2_LOW_TOWN", cf, ( 11279.9, 4986.73, 326.48 ), ( 0, 228.9, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_heli_takedown_cs";
    s.activity_bundle = "sat_activitydef_activity_helitakedown";
    s.name = "HELI_TAKEDOWN_WINERY";
    s.var_265c4f33e2a6daa7 = "1";
    fe [[ f ]]( s, "HELI_TAKEDOWN_WINERY", cf, ( 15885.3, 58231.2, 959.76 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_heli_takedown_cs";
    fe [[ f ]]( s, "HELI_TAKEDOWN_WINERY", cf, ( 15885, 58266.6, 959.67 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "join_radius", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 2500 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_heli_takedown_cs";
    fe [[ f ]]( s, "HELI_TAKEDOWN_WINERY", cf, ( 15884.8, 58334.9, 960.43 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Awareness_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 5000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_heli_takedown_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.reverse_route = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "HELI_TAKEDOWN_WINERY", cf, ( 15319.1, 58737.3, 942.94 ), ( 0, 305.89, 0 ), "cspf_2_auto1527685414035167573", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_heli_takedown_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "500";
    s.preferred_spawnpoint = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "ht_long";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "HELI_TAKEDOWN_WINERY", cf, ( 16155.4, 57680, 958.27 ), ( 0, 1.2, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_heli_takedown_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "500";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "ht_short";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "HELI_TAKEDOWN_WINERY", cf, ( 15767, 57685.9, 959.85 ), ( 0, 98, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_heli_takedown_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "500";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "ht_short";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "HELI_TAKEDOWN_WINERY", cf, ( 16908.9, 58745.5, 966.96 ), ( 0, 190.66, 0 ), undefined, "cspf_2_auto7147688311945460799", "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_heli_takedown_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "500";
    s.preferred_spawnpoint = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "ht_short";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "HELI_TAKEDOWN_WINERY", cf, ( 14635.8, 58115.9, 959.63 ), ( 0, 180.86, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_heli_takedown_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "500";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "ht_long";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "HELI_TAKEDOWN_WINERY", cf, ( 15217, 57446.2, 986.88 ), ( 0, 3.66, 0 ), undefined, "cspf_2_auto5837052364958190009", "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_heli_takedown_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "500";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "ht_long";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "HELI_TAKEDOWN_WINERY", cf, ( 17497, 58693.5, 960.16 ), ( 0, 4.98, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_heli_takedown_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.reverse_route = "1";
    s.start_point = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "HELI_TAKEDOWN_WINERY", cf, ( 15750.5, 57426.2, 998.6 ), ( 0, 189.89, 0 ), "cspf_2_auto5837052364958190009", "cspf_2_auto15010539576255324433", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_heli_takedown_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.reverse_route = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "HELI_TAKEDOWN_WINERY", cf, ( 16418, 57396.7, 993.56 ), ( 0, 52.68, 0 ), "cspf_2_auto15010539576255324433", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_heli_takedown_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "500";
    s.preferred_spawnpoint = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "ht_long";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "HELI_TAKEDOWN_WINERY", cf, ( 14614.1, 57448.1, 998.88 ), ( 0, 36.34, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_heli_takedown_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.reverse_route = "1";
    s.start_point = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "HELI_TAKEDOWN_WINERY", cf, ( 16694.4, 58705.5, 964.03 ), ( 0, 305.89, 0 ), "cspf_2_auto7147688311945460799", "cspf_2_auto7850959231254042433", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_heli_takedown_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.reverse_route = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "HELI_TAKEDOWN_WINERY", cf, ( 15757.4, 58728.2, 960.01 ), ( 0, 305.89, 0 ), "cspf_2_auto7850959231254042433", "cspf_2_auto1527685414035167573", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_heli_takedown_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "500";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "ht_short";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "HELI_TAKEDOWN_WINERY", cf, ( 16276.9, 58976.3, 947.83 ), ( 0, 271.56, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_heli_takedown_cs";
    s._size_max = ( 944.19, 2097.5, 572 );
    s._size_min = ( 1111.73, 1644.25, 32 );
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
    fe [[ f ]]( s, "HELI_TAKEDOWN_WINERY", cf, ( 16033.9, 58093.2, 709.03 ), ( 0, 270.02, 0 ), "encounter_HELI_TAKEDOWN_WINERY_RADIANT", undefined, "noent_volume_ai_encounter_cs", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_heli_takedown_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "500";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "ht_dawg";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "HELI_TAKEDOWN_WINERY", cf, ( 14874.2, 58648.4, 941.43 ), ( 0, 274.2, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_heli_takedown_cs";
    fe [[ f ]]( s, "HELI_TAKEDOWN_WINERY", cf, ( 15884.9, 58300.5, 959.95 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Ambient_AI_Exclusion_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 1800 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_heli_takedown_cs";
    s.activity_bundle = "sat_activitydef_activity_helitakedown";
    s.name = "HELI_TAKEDOWN_Q2_SUPERMARKET_01";
    s.var_265c4f33e2a6daa7 = "1";
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q2_SUPERMARKET_01", cf, ( 22077.3, 17167.1, 540.1 ), ( 0, 101.36, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_heli_takedown_cs";
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q2_SUPERMARKET_01", cf, ( 22081.8, 17159.7, 536.02 ), ( 0, 101.36, 0 ), "activity_nexus_spatial_zone", undefined, "join_radius", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 1800 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_heli_takedown_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "500";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "ht_short";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q2_SUPERMARKET_01", cf, ( 22286.1, 16644.8, 346.02 ), ( 0, 192.32, 0 ), undefined, "cspf_3_auto10863636412982703467", "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_heli_takedown_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.reverse_route = "1";
    s.start_point = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q2_SUPERMARKET_01", cf, ( 21544.1, 16588.3, 342.35 ), ( 0, 249.59, 0 ), "cspf_3_auto10863636412982703467", "cspf_3_auto10847846362951288487", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_heli_takedown_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.reverse_route = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q2_SUPERMARKET_01", cf, ( 20679.5, 16847.8, 318 ), ( 0, 249.59, 0 ), "cspf_3_auto10847846362951288487", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_heli_takedown_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "500";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "ht_long";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q2_SUPERMARKET_01", cf, ( 22039, 18275.2, 507.95 ), ( 0, 23.89, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_heli_takedown_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "500";
    s.preferred_spawnpoint = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "ht_short";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q2_SUPERMARKET_01", cf, ( 22454.6, 17145.7, 347.78 ), ( 0, 51.68, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_heli_takedown_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "500";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "ht_long";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q2_SUPERMARKET_01", cf, ( 22490.9, 16819.3, 345.94 ), ( 0, 333.9, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_heli_takedown_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "500";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "ht_long";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q2_SUPERMARKET_01", cf, ( 22888.5, 16952.8, 357.72 ), ( 0, 137.03, 0 ), undefined, "cspf_3_auto7147688311945460799", "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_heli_takedown_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "500";
    s.preferred_spawnpoint = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "ht_long";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q2_SUPERMARKET_01", cf, ( 21143.8, 16431.8, 345.36 ), ( 0, 118.53, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_heli_takedown_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "500";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "ht_long";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q2_SUPERMARKET_01", cf, ( 21697.1, 17265.6, 354.23 ), ( 0, 152.36, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_heli_takedown_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "500";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "ht_short";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q2_SUPERMARKET_01", cf, ( 21911.7, 18052.6, 487.92 ), ( 0, 349.78, 0 ), undefined, "cspf_3_auto2068967809947837597", "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_heli_takedown_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "500";
    s.preferred_spawnpoint = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "ht_short";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q2_SUPERMARKET_01", cf, ( 22398.8, 17928.7, 443.81 ), ( 0, 91.16, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_heli_takedown_cs";
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q2_SUPERMARKET_01", cf, ( 22076.3, 17159.9, 350.44 ), ( 0, 126.36, 0 ), "activity_nexus_spatial_zone", undefined, "Awareness_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 5000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_heli_takedown_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.reverse_route = "1";
    s.start_point = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q2_SUPERMARKET_01", cf, ( 22618, 17318.7, 376.74 ), ( 0, 159.59, 0 ), "cspf_3_auto7147688311945460799", "cspf_3_auto7850959231254042433", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_heli_takedown_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.reverse_route = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q2_SUPERMARKET_01", cf, ( 22615, 17906.6, 468.53 ), ( 0, 159.59, 0 ), "cspf_3_auto7850959231254042433", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_heli_takedown_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.reverse_route = "1";
    s.start_point = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q2_SUPERMARKET_01", cf, ( 21354.6, 17369.7, 408.95 ), ( 0, 249.59, 0 ), "cspf_3_auto2068967809947837597", "cspf_3_auto18292375127441977161", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_heli_takedown_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.reverse_route = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q2_SUPERMARKET_01", cf, ( 20842.7, 17048.6, 374.79 ), ( 0, 249.59, 0 ), "cspf_3_auto18292375127441977161", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_heli_takedown_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "500";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "ht_short";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q2_SUPERMARKET_01", cf, ( 21133.9, 16904.8, 344.82 ), ( 0, 215.83, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_heli_takedown_cs";
    s._size_max = ( 2246.78, 2107.26, 572 );
    s._size_min = ( -363.879, 32, 32 );
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
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q2_SUPERMARKET_01", cf, ( 23468.8, 16668.8, 181.84 ), ( 0, 126.36, 0 ), "encounter_HELI_TAKEDOWN_Q2_SUPERMARKET_01_RADIANT", undefined, "noent_volume_ai_encounter_cs", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_heli_takedown_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "500";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "ht_dawg";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q2_SUPERMARKET_01", cf, ( 22460.6, 17643.4, 408.16 ), ( 0, 134.36, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_heli_takedown_cs";
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q2_SUPERMARKET_01", cf, ( 22076.3, 17159.9, 545.3 ), ( 0, 126.36, 0 ), "activity_nexus_spatial_zone", undefined, "Ambient_AI_Exclusion_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 1800 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_heli_takedown_cs";
    s.activity_bundle = "sat_activitydef_activity_helitakedown";
    s.name = "HELI_TAKEDOWN_Q2_COLOSSEUM";
    s.var_265c4f33e2a6daa7 = "1";
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q2_COLOSSEUM", cf, ( 36357, 29406.9, 1305.32 ), ( 0, 83.87, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_heli_takedown_cs";
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q2_COLOSSEUM", cf, ( 36389.3, 29403.2, 1304.55 ), ( 0, 83.87, 0 ), "activity_nexus_spatial_zone", undefined, "Ambient_AI_Exclusion_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 2000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_heli_takedown_cs";
    s.name = "script_struct_activity_instance_nexus_radius";
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q2_COLOSSEUM", cf, ( 36454, 29396.4, 1302.94 ), ( 0, 83.87, 0 ), "activity_nexus_spatial_zone", undefined, "join_radius", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 2000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_heli_takedown_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "500";
    s.preferred_spawnpoint = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "ht_short";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q2_COLOSSEUM", cf, ( 35896.6, 29138.2, 1327.59 ), ( 0, 86.74, 0 ), undefined, "cspf_4_auto7147688311945460799", "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_heli_takedown_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "500";
    s.preferred_spawnpoint = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "ht_short";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q2_COLOSSEUM", cf, ( 35875.5, 28634, 1305.12 ), ( 0, 296.99, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_heli_takedown_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "500";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "ht_short";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q2_COLOSSEUM", cf, ( 36821, 29759.3, 1214.04 ), ( 0, 228.25, 0 ), undefined, "cspf_4_auto10863636412982703467", "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_heli_takedown_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.reverse_route = "1";
    s.start_point = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q2_COLOSSEUM", cf, ( 36637.9, 29485.5, 1221.34 ), ( 0, 212.48, 0 ), "cspf_4_auto10863636412982703467", "cspf_4_auto10847846362951288487", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_heli_takedown_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.reverse_route = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q2_COLOSSEUM", cf, ( 36660.4, 29191.6, 1239.33 ), ( 0, 212.48, 0 ), "cspf_4_auto10847846362951288487", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_heli_takedown_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "500";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "ht_long";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q2_COLOSSEUM", cf, ( 36043.7, 30041.6, 1243.08 ), ( 0, 304.9, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_heli_takedown_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "500";
    s.preferred_spawnpoint = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "ht_short";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q2_COLOSSEUM", cf, ( 37080.3, 29506.9, 1196.43 ), ( 0, 132.26, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_heli_takedown_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "500";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "ht_long";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q2_COLOSSEUM", cf, ( 36576.7, 30278.6, 1241.46 ), ( 0, 154.55, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_heli_takedown_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "500";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "ht_long";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q2_COLOSSEUM", cf, ( 36705.6, 29985.9, 1215.81 ), ( 0, 274.05, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_heli_takedown_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "500";
    s.preferred_spawnpoint = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "ht_long";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q2_COLOSSEUM", cf, ( 36718.5, 28888.5, 1212.13 ), ( 0, 278.97, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_heli_takedown_cs";
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q2_COLOSSEUM", cf, ( 36421.8, 29399.9, 1303.74 ), ( 0, 83.87, 0 ), "activity_nexus_spatial_zone", undefined, "Awareness_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 5000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_heli_takedown_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.reverse_route = "1";
    s.start_point = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q2_COLOSSEUM", cf, ( 35911.7, 29281.4, 1308.3 ), ( 0, 122.48, 0 ), "cspf_4_auto7147688311945460799", "cspf_4_auto7850959231254042433", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_heli_takedown_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.reverse_route = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q2_COLOSSEUM", cf, ( 35945.1, 29623.8, 1279.01 ), ( 0, 122.48, 0 ), "cspf_4_auto7850959231254042433", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_heli_takedown_cs";
    s._size_max = ( 1566.68, 493.15, 877.609 );
    s._size_min = ( 580.957, 1188.37, 32 );
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
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q2_COLOSSEUM", cf, ( 36197.8, 28835.9, 1118.1 ), ( 0, 84.59, 0 ), "encounter_HELI_TAKEDOWN_Q2_COLOSSEUM_RADIANT", undefined, "noent_volume_ai_encounter_cs", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace mp_sat_avalon_q2_ob_heli_takedown_cs
// Params 0, eflags: 0x4
// Checksum 0xa7487cb2, Offset: 0x4fb0
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace mp_sat_avalon_q2_ob_heli_takedown_cs
// Params 0
// Checksum 0xbb81c6b, Offset: 0x4fba
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "mp_sat_avalon_q2_ob_heli_takedown_cs" );
}

// Namespace mp_sat_avalon_q2_ob_heli_takedown_cs
// Params 0
// Checksum 0x8c7bab95, Offset: 0x4fd0
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

// Namespace mp_sat_avalon_q2_ob_heli_takedown_cs
// Params 4
// Checksum 0xa62c6f3a, Offset: 0x503f
// Size: 0xa5
function function_d4323822d7042e5a( var_4312b79c960726b6, fe, us, cf = "mp_sat_avalon_q2_ob_heli_takedown_cs" )
{
    switch ( var_4312b79c960726b6 )
    {
        case #"hash_95f79ec6a191efd9":
            function_34e6d7a446da20e1( fe, us, cf );
            break;
        case #"hash_261a14531e22e6a2":
            function_63da83c0e2702f4a( fe, us, cf );
            break;
        case #"hash_f6a6f239bf1690d5":
            function_b28fa262662579d( fe, us, cf );
            break;
        case #"hash_19237f2cca7eec04":
            function_8a9922a37b1c906c( fe, us, cf );
            break;
    }
}

// Namespace mp_sat_avalon_q2_ob_heli_takedown_cs
// Params 3
// Checksum 0x438e4ce4, Offset: 0x50ec
// Size: 0x988
function function_34e6d7a446da20e1( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_heli_takedown_cs";
    s.name = "vehicle";
    s.script_label = "vehicle";
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q2_LOW_TOWN", cf, ( 10351.5, 3529.82, 602.23 ), ( 0, 189.16, 0 ), "s_veh_HELI_TAKEDOWN_Q2_LOW_TOWN", undefined, "veh_sat_atv_ob", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_heli_takedown_cs";
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q2_LOW_TOWN", cf, ( 12404.7, 5542.78, 868.26 ), ( 0, 0, 0 ), "HELI_TAKEDOWN_Q2_LOW_TOWN", undefined, undefined, "cspf_5_1", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_heli_takedown_cs";
    s.groupid = "vtol_escape_path";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q2_LOW_TOWN", cf, ( 12324, 5425, 444 ), ( 0.63, 209.07, 1.3 ), "s_heli_takedown_heli_spawn", "cspf_5_auto8494757589517366665", undefined, "cspf_5_2", "cspf_5_1", ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 10, 1 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_heli_takedown_cs";
    s.groupid = "vtol_escape_path";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q2_LOW_TOWN", cf, ( 11746.5, 5154.8, 1723.51 ), ( 0, 234.51, 0 ), "cspf_5_auto8494757589517366665", "cspf_5_auto4612352738519139850", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_heli_takedown_cs";
    s.groupid = "vtol_escape_path";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q2_LOW_TOWN", cf, ( 10892.8, 4049, 2733.51 ), ( 0, 95.83, 0 ), "cspf_5_auto4612352738519139850", "cspf_5_auto10095321859284440761", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_heli_takedown_cs";
    s.groupid = "vtol_escape_path";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q2_LOW_TOWN", cf, ( 10635.5, 3713.9, 2900 ), ( 0, 95.83, 0 ), "cspf_5_auto10095321859284440761", "cspf_5_auto9117064054671232171", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_heli_takedown_cs";
    s.groupid = "vtol_escape_path";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q2_LOW_TOWN", cf, ( 10335.5, 3440.35, 3000 ), ( 0, 95.83, 0 ), "cspf_5_auto9117064054671232171", "cspf_5_auto17546438238563180426", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_heli_takedown_cs";
    s.groupid = "vtol_escape_path";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q2_LOW_TOWN", cf, ( 9844.45, 3223.25, 3100 ), ( 0, 95.83, 0 ), "cspf_5_auto17546438238563180426", "cspf_5_auto3392554419138434722", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_heli_takedown_cs";
    s.groupid = "vtol_escape_path";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q2_LOW_TOWN", cf, ( 9306, 3134.2, 3200 ), ( 0, 94.23, 0 ), "cspf_5_auto3392554419138434722", "cspf_5_auto678961591699957337", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_heli_takedown_cs";
    s.groupid = "vtol_escape_path";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q2_LOW_TOWN", cf, ( 7758.4, 3334.2, 3300 ), ( 0, 159.88, 0 ), "cspf_5_auto678961591699957337", "cspf_5_auto17798406878246190170", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_heli_takedown_cs";
    s.groupid = "vtol_escape_path";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q2_LOW_TOWN", cf, ( 5612.4, 3951.7, 3400 ), ( 0, 159.88, 0 ), "cspf_5_auto17798406878246190170", "cspf_5_auto14348649893522508367", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_heli_takedown_cs";
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q2_LOW_TOWN", cf, ( 2322.75, 15200.5, 3500 ), ( 0, 58.44, 0 ), "heli_leave", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_heli_takedown_cs";
    s.groupid = "vtol_escape_path";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q2_LOW_TOWN", cf, ( 4980.32, 4190.4, 3500 ), ( 0, 159.88, 0 ), "cspf_5_auto14348649893522508367", "cspf_5_auto13757901738603966073", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_heli_takedown_cs";
    s.groupid = "vtol_escape_path";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q2_LOW_TOWN", cf, ( 4732.89, 4520.7, 3500 ), ( 0, 95.83, 0 ), "cspf_5_auto13757901738603966073", "cspf_5_auto4562139456735891158", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_heli_takedown_cs";
    s.groupid = "vtol_escape_path";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q2_LOW_TOWN", cf, ( 4724.04, 7686.7, 3500 ), ( 0, 45.84, 0 ), "cspf_5_auto4562139456735891158", "cspf_5_auto8766061891730312246", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_heli_takedown_cs";
    s.groupid = "vtol_escape_path";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q2_LOW_TOWN", cf, ( 4007.92, 11744.5, 3500 ), ( 0, 95.83, 0 ), "cspf_5_auto8766061891730312246", "cspf_5_auto14709416443788656615", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_heli_takedown_cs";
    s.groupid = "vtol_escape_path";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q2_LOW_TOWN", cf, ( 2841.8, 14455.5, 3500 ), ( 0, 56.55, 0 ), "cspf_5_auto14709416443788656615", "cspf_5_auto15600294591917143653", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_heli_takedown_cs";
    s.groupid = "vtol_escape_path";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q2_LOW_TOWN", cf, ( 867.93, 17295, 3500 ), ( 0, 56.55, 0 ), "cspf_5_auto15600294591917143653", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_heli_takedown_cs";
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q2_LOW_TOWN", cf, ( 11847.9, 5340.53, 270.59 ), ( 0, 0, 0 ), "HELI_TAKEDOWN_Q2_LOW_TOWN_RADIANT", "encounter_HELI_TAKEDOWN_Q2_LOW_TOWN_RADIANT", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_sat_avalon_q2_ob_heli_takedown_cs
// Params 3
// Checksum 0xc0bc840d, Offset: 0x5a7c
// Size: 0x988
function function_63da83c0e2702f4a( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_heli_takedown_cs";
    fe [[ f ]]( s, "HELI_TAKEDOWN_WINERY", cf, ( 14981.7, 58082.5, 1732.95 ), ( 0, 188.77, 0 ), "HELI_TAKEDOWN_WINERY", undefined, undefined, "cspf_6_1", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_heli_takedown_cs";
    s.groupid = "vtol_escape_path";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "HELI_TAKEDOWN_WINERY", cf, ( 15502.2, 58121.6, 1120.25 ), ( 0, 0.25, 0 ), "s_heli_takedown_heli_spawn", "cspf_6_auto8494757589517366665", undefined, "cspf_6_2", "cspf_6_1", ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 10, 1 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_heli_takedown_cs";
    s.groupid = "vtol_escape_path";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "HELI_TAKEDOWN_WINERY", cf, ( 17336.9, 57965, 2485.8 ), ( 0, 331.93, 0 ), "cspf_6_auto8494757589517366665", "cspf_6_auto4612352738519139850", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_heli_takedown_cs";
    s.groupid = "vtol_escape_path";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "HELI_TAKEDOWN_WINERY", cf, ( 18540.6, 57512.6, 3255.8 ), ( 0, 279.25, 0 ), "cspf_6_auto4612352738519139850", "cspf_6_auto10095321859284440761", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_heli_takedown_cs";
    s.groupid = "vtol_escape_path";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "HELI_TAKEDOWN_WINERY", cf, ( 19190.5, 57136, 3878.2 ), ( 0, 279.25, 0 ), "cspf_6_auto10095321859284440761", "cspf_6_auto9117064054671232171", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_heli_takedown_cs";
    s.groupid = "vtol_escape_path";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "HELI_TAKEDOWN_WINERY", cf, ( 19588.5, 56650.3, 4407.2 ), ( 0, 279.25, 0 ), "cspf_6_auto9117064054671232171", "cspf_6_auto17546438238563180426", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_heli_takedown_cs";
    s.groupid = "vtol_escape_path";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "HELI_TAKEDOWN_WINERY", cf, ( 20197.1, 55957.8, 4830.7 ), ( 0, 279.25, 0 ), "cspf_6_auto17546438238563180426", "cspf_6_auto3392554419138434722", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_heli_takedown_cs";
    s.groupid = "vtol_escape_path";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "HELI_TAKEDOWN_WINERY", cf, ( 21131.7, 55218.6, 5171.2 ), ( 0, 277.64, 0 ), "cspf_6_auto3392554419138434722", "cspf_6_auto678961591699957337", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_heli_takedown_cs";
    s.groupid = "vtol_escape_path";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "HELI_TAKEDOWN_WINERY", cf, ( 22248.3, 54696.7, 5241.2 ), ( 0, 343.3, 0 ), "cspf_6_auto678961591699957337", "cspf_6_auto17798406878246190170", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_heli_takedown_cs";
    s.groupid = "vtol_escape_path";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "HELI_TAKEDOWN_WINERY", cf, ( 23553.9, 54642.7, 5360.7 ), ( 0, 343.3, 0 ), "cspf_6_auto17798406878246190170", "cspf_6_auto14348649893522508367", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_heli_takedown_cs";
    fe [[ f ]]( s, "HELI_TAKEDOWN_WINERY", cf, ( 31808.6, 49958.5, 5435.21 ), ( 0, 241.85, 0 ), "heli_leave", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_heli_takedown_cs";
    s.groupid = "vtol_escape_path";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "HELI_TAKEDOWN_WINERY", cf, ( 25390.9, 54983.9, 5427.7 ), ( 0, 343.3, 0 ), "cspf_6_auto14348649893522508367", "cspf_6_auto13757901738603966073", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_heli_takedown_cs";
    s.groupid = "vtol_escape_path";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "HELI_TAKEDOWN_WINERY", cf, ( 27086, 54938.2, 5435.7 ), ( 0, 279.25, 0 ), "cspf_6_auto13757901738603966073", "cspf_6_auto4562139456735891158", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_heli_takedown_cs";
    s.groupid = "vtol_escape_path";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "HELI_TAKEDOWN_WINERY", cf, ( 28152.5, 54336.6, 5435.7 ), ( 0, 229.25, 0 ), "cspf_6_auto4562139456735891158", "cspf_6_auto8766061891730312246", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_heli_takedown_cs";
    s.groupid = "vtol_escape_path";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "HELI_TAKEDOWN_WINERY", cf, ( 29886.8, 52436.6, 5370.7 ), ( 0, 279.25, 0 ), "cspf_6_auto8766061891730312246", "cspf_6_auto14709416443788656615", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_heli_takedown_cs";
    s.groupid = "vtol_escape_path";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "HELI_TAKEDOWN_WINERY", cf, ( 31576, 50282.1, 5425.2 ), ( 0, 239.96, 0 ), "cspf_6_auto14709416443788656615", "cspf_6_auto15600294591917143653", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_heli_takedown_cs";
    s.groupid = "vtol_escape_path";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "HELI_TAKEDOWN_WINERY", cf, ( 33303.7, 47847.1, 5425.2 ), ( 0, 239.96, 0 ), "cspf_6_auto15600294591917143653", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_heli_takedown_cs";
    s.name = "vehicle";
    s.script_label = "vehicle";
    fe [[ f ]]( s, "HELI_TAKEDOWN_WINERY", cf, ( 17362.2, 57537.5, 1000.66 ), ( 0, 0.15, 0 ), "s_veh_HELI_TAKEDOWN_WINERY", undefined, "veh_sat_atv_ob", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_heli_takedown_cs";
    fe [[ f ]]( s, "HELI_TAKEDOWN_WINERY", cf, ( 15912.9, 58293.4, 961.87 ), ( 0, 0, 0 ), "HELI_TAKEDOWN_WINERY_RADIANT", "encounter_HELI_TAKEDOWN_WINERY_RADIANT", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_sat_avalon_q2_ob_heli_takedown_cs
// Params 3
// Checksum 0x93eebc1d, Offset: 0x640c
// Size: 0xa6c
function function_b28fa262662579d( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_heli_takedown_cs";
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q2_SUPERMARKET_01", cf, ( 21722, 16895.6, 1553.89 ), ( 0, 222.47, 0 ), "HELI_TAKEDOWN_Q2_SUPERMARKET_01", undefined, undefined, "cspf_7_1", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_heli_takedown_cs";
    s.groupid = "vtol_escape_path";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q2_SUPERMARKET_01", cf, ( 22079.8, 17168.4, 508.21 ), ( 0, 37.14, 0 ), "s_heli_takedown_heli_spawn", "cspf_7_auto8494757589517366665", undefined, "cspf_7_2", "cspf_7_1", ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 10, 1 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_heli_takedown_cs";
    s.groupid = "vtol_escape_path";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q2_SUPERMARKET_01", cf, ( 22622.6, 18033.2, 1886.95 ), ( 0, 185.62, 0 ), "cspf_7_auto8494757589517366665", "cspf_7_auto4612352738519139850", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_heli_takedown_cs";
    s.groupid = "vtol_escape_path";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q2_SUPERMARKET_01", cf, ( 22630.6, 18428.2, 2656.95 ), ( 0, 132.94, 0 ), "cspf_7_auto4612352738519139850", "cspf_7_auto10095321859284440761", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_heli_takedown_cs";
    s.groupid = "vtol_escape_path";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q2_SUPERMARKET_01", cf, ( 22529.3, 18753.3, 3279.35 ), ( 0, 132.94, 0 ), "cspf_7_auto10095321859284440761", "cspf_7_auto9117064054671232171", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_heli_takedown_cs";
    s.groupid = "vtol_escape_path";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q2_SUPERMARKET_01", cf, ( 22234.8, 19126.4, 3808.35 ), ( 0, 132.94, 0 ), "cspf_7_auto9117064054671232171", "cspf_7_auto17546438238563180426", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_heli_takedown_cs";
    s.groupid = "vtol_escape_path";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q2_SUPERMARKET_01", cf, ( 21208.9, 19409.2, 4231.85 ), ( 0, 132.94, 0 ), "cspf_7_auto17546438238563180426", "cspf_7_auto3392554419138434722", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_heli_takedown_cs";
    s.groupid = "vtol_escape_path";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q2_SUPERMARKET_01", cf, ( 19502.1, 19275, 4572.35 ), ( 0, 131.34, 0 ), "cspf_7_auto3392554419138434722", "cspf_7_auto678961591699957337", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_heli_takedown_cs";
    s.groupid = "vtol_escape_path";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q2_SUPERMARKET_01", cf, ( 18328, 18835.6, 4642.35 ), ( 0, 196.99, 0 ), "cspf_7_auto678961591699957337", "cspf_7_auto17798406878246190170", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_heli_takedown_cs";
    s.groupid = "vtol_escape_path";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q2_SUPERMARKET_01", cf, ( 17211.7, 18156.2, 4761.85 ), ( 0, 196.99, 0 ), "cspf_7_auto17798406878246190170", "cspf_7_auto14348649893522508367", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_heli_takedown_cs";
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q2_SUPERMARKET_01", cf, ( 7745.14, 17473.6, 4836.36 ), ( 0, 95.54, 0 ), "heli_leave", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_heli_takedown_cs";
    s.groupid = "vtol_escape_path";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q2_SUPERMARKET_01", cf, ( 15872.6, 16853.2, 4828.85 ), ( 0, 196.99, 0 ), "cspf_7_auto14348649893522508367", "cspf_7_auto13757901738603966073", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_heli_takedown_cs";
    s.groupid = "vtol_escape_path";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q2_SUPERMARKET_01", cf, ( 14437, 15950.8, 4836.85 ), ( 0, 132.94, 0 ), "cspf_7_auto13757901738603966073", "cspf_7_auto4562139456735891158", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_heli_takedown_cs";
    s.groupid = "vtol_escape_path";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q2_SUPERMARKET_01", cf, ( 13215.9, 15859.6, 4836.85 ), ( 0, 82.94, 0 ), "cspf_7_auto4562139456735891158", "cspf_7_auto8766061891730312246", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_heli_takedown_cs";
    s.groupid = "vtol_escape_path";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q2_SUPERMARKET_01", cf, ( 10718.9, 16478.1, 4771.85 ), ( 0, 132.94, 0 ), "cspf_7_auto8766061891730312246", "cspf_7_auto14709416443788656615", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_heli_takedown_cs";
    s.groupid = "vtol_escape_path";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q2_SUPERMARKET_01", cf, ( 8118.25, 17333.5, 4826.35 ), ( 0, 93.66, 0 ), "cspf_7_auto14709416443788656615", "cspf_7_auto15600294591917143653", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_heli_takedown_cs";
    s.groupid = "vtol_escape_path";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q2_SUPERMARKET_01", cf, ( 5329.77, 18400.9, 4826.35 ), ( 0, 93.66, 0 ), "cspf_7_auto15600294591917143653", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_heli_takedown_cs";
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q2_SUPERMARKET_01", cf, ( 22083.3, 17151.3, 550.97 ), ( 0, 101.36, 0 ), "s_heli_takedown_teleport", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_heli_takedown_cs";
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q2_SUPERMARKET_01", cf, ( 22090.6, 17162.3, 558.01 ), ( 0, 126.36, 0 ), "HELI_TAKEDOWN_Q2_SUPERMARKET_01_RADIANT", "encounter_HELI_TAKEDOWN_Q2_SUPERMARKET_01_RADIANT", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_heli_takedown_cs";
    s.name = "vehicle";
    s.script_label = "vehicle";
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q2_SUPERMARKET_01", cf, ( 22561.7, 18255.8, 510.08 ), ( 0, 90, 0 ), "s_veh_HELI_TAKEDOWN_Q2_SUPERMARKET_01", undefined, "veh_sat_atv_ob", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_heli_takedown_cs";
    s.name = "vehicle";
    s.script_label = "vehicle";
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q2_SUPERMARKET_01", cf, ( 20970, 16914.3, 344.4 ), ( 0, 180, 0 ), "s_veh_HELI_TAKEDOWN_Q2_SUPERMARKET_01", undefined, "veh_sat_atv_ob", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_sat_avalon_q2_ob_heli_takedown_cs
// Params 3
// Checksum 0x8c1a98df, Offset: 0x6e80
// Size: 0x988
function function_8a9922a37b1c906c( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_heli_takedown_cs";
    s.name = "vehicle";
    s.script_label = "vehicle";
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q2_COLOSSEUM", cf, ( 35949.3, 27794, 1298.73 ), ( 0, 266.15, 0 ), "s_veh_HELI_TAKEDOWN_Q2_COLOSSEUM", undefined, "veh_sat_atv_ob", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_heli_takedown_cs";
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q2_COLOSSEUM", cf, ( 36183, 28962, 1868.82 ), ( 0, 2, 0 ), "HELI_TAKEDOWN_Q2_COLOSSEUM", undefined, undefined, "cspf_8_1", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_heli_takedown_cs";
    s.groupid = "vtol_escape_path";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q2_COLOSSEUM", cf, ( 36303.1, 29493.6, 1391.1 ), ( 359.06, 262, -0.88 ), "s_heli_takedown_heli_spawn", "cspf_8_auto8494757589517366665", undefined, "cspf_8_2", "cspf_8_1", ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 10, 1 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_heli_takedown_cs";
    s.groupid = "vtol_escape_path";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q2_COLOSSEUM", cf, ( 36221.5, 27472.3, 2500 ), ( 0, 280.51, 0 ), "cspf_8_auto8494757589517366665", "cspf_8_auto4612352738519139850", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_heli_takedown_cs";
    s.groupid = "vtol_escape_path";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q2_COLOSSEUM", cf, ( 36206.9, 26341.3, 2900 ), ( 0, 141.83, 0 ), "cspf_8_auto4612352738519139850", "cspf_8_auto10095321859284440761", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_heli_takedown_cs";
    s.groupid = "vtol_escape_path";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q2_COLOSSEUM", cf, ( 36231.2, 25619.4, 3100 ), ( 0, 141.83, 0 ), "cspf_8_auto10095321859284440761", "cspf_8_auto9117064054671232171", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_heli_takedown_cs";
    s.groupid = "vtol_escape_path";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q2_COLOSSEUM", cf, ( 36247.6, 25133.6, 3200 ), ( 0, 141.83, 0 ), "cspf_8_auto9117064054671232171", "cspf_8_auto17546438238563180426", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_heli_takedown_cs";
    s.groupid = "vtol_escape_path";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q2_COLOSSEUM", cf, ( 36266.6, 24751.6, 3300 ), ( 0, 141.83, 0 ), "cspf_8_auto17546438238563180426", "cspf_8_auto3392554419138434722", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_heli_takedown_cs";
    s.groupid = "vtol_escape_path";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q2_COLOSSEUM", cf, ( 36302.7, 23546.4, 3400 ), ( 0, 140.23, 0 ), "cspf_8_auto3392554419138434722", "cspf_8_auto678961591699957337", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_heli_takedown_cs";
    s.groupid = "vtol_escape_path";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q2_COLOSSEUM", cf, ( 36337.7, 21956.1, 3500 ), ( 0, 205.88, 0 ), "cspf_8_auto678961591699957337", "cspf_8_auto17798406878246190170", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_heli_takedown_cs";
    s.groupid = "vtol_escape_path";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q2_COLOSSEUM", cf, ( 36366.8, 18903.3, 3500 ), ( 0, 205.88, 0 ), "cspf_8_auto17798406878246190170", "cspf_8_auto14348649893522508367", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_heli_takedown_cs";
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q2_COLOSSEUM", cf, ( 36413.2, 15379.8, 3500 ), ( 0, 104.44, 0 ), "heli_leave", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_heli_takedown_cs";
    s.groupid = "vtol_escape_path";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q2_COLOSSEUM", cf, ( 36374, 17902.4, 3500 ), ( 0, 205.88, 0 ), "cspf_8_auto14348649893522508367", "cspf_8_auto13757901738603966073", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_heli_takedown_cs";
    s.groupid = "vtol_escape_path";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q2_COLOSSEUM", cf, ( 36390.5, 17087.9, 3500 ), ( 0, 141.83, 0 ), "cspf_8_auto13757901738603966073", "cspf_8_auto4562139456735891158", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_heli_takedown_cs";
    s.groupid = "vtol_escape_path";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q2_COLOSSEUM", cf, ( 36411, 15674.8, 3500 ), ( 0, 91.84, 0 ), "cspf_8_auto4562139456735891158", "cspf_8_auto8766061891730312246", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_heli_takedown_cs";
    s.groupid = "vtol_escape_path";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q2_COLOSSEUM", cf, ( 36420.6, 12780.5, 3500 ), ( 0, 141.83, 0 ), "cspf_8_auto8766061891730312246", "cspf_8_auto14709416443788656615", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_heli_takedown_cs";
    s.groupid = "vtol_escape_path";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q2_COLOSSEUM", cf, ( 36408.4, 10046.9, 3500 ), ( 0, 102.55, 0 ), "cspf_8_auto14709416443788656615", "cspf_8_auto15600294591917143653", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_heli_takedown_cs";
    s.groupid = "vtol_escape_path";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q2_COLOSSEUM", cf, ( 36402.6, 6639.46, 3500 ), ( 0, 102.55, 0 ), "cspf_8_auto15600294591917143653", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_heli_takedown_cs";
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q2_COLOSSEUM", cf, ( 36378.3, 29441.2, 1220.9 ), ( 0, 83.87, 0 ), "HELI_TAKEDOWN_Q2_COLOSSEUM_RADIANT", "encounter_HELI_TAKEDOWN_Q2_COLOSSEUM_RADIANT", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_sat_avalon_q2_ob_heli_takedown_cs
// Params 0
// Checksum 0xeda9ccd0, Offset: 0x7810
// Size: 0x2a5
function function_d9dd7965c51c95d1()
{
    activityinstances = [];
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_activitydef_activity_helitakedown";
    var_881289d7987bc770.var_265c4f33e2a6daa7 = 1;
    var_881289d7987bc770.cf = "mp_sat_avalon_q2_ob_heli_takedown_cs";
    var_881289d7987bc770.scriptstructorigin = ( 11823.6, 5415.1, 269.79 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [];
    var_881289d7987bc770.var_31ce4477e3543d24 = [];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [];
    var_881289d7987bc770.locationradius = [];
    activityinstances[ "HELI_TAKEDOWN_Q2_LOW_TOWN" ] = var_881289d7987bc770;
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_activitydef_activity_helitakedown";
    var_881289d7987bc770.var_265c4f33e2a6daa7 = 1;
    var_881289d7987bc770.cf = "mp_sat_avalon_q2_ob_heli_takedown_cs";
    var_881289d7987bc770.scriptstructorigin = ( 15885.3, 58231.2, 959.76 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [];
    var_881289d7987bc770.var_31ce4477e3543d24 = [];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [];
    var_881289d7987bc770.locationradius = [];
    activityinstances[ "HELI_TAKEDOWN_WINERY" ] = var_881289d7987bc770;
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_activitydef_activity_helitakedown";
    var_881289d7987bc770.var_265c4f33e2a6daa7 = 1;
    var_881289d7987bc770.cf = "mp_sat_avalon_q2_ob_heli_takedown_cs";
    var_881289d7987bc770.scriptstructorigin = ( 22077.3, 17167.1, 540.1 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [];
    var_881289d7987bc770.var_31ce4477e3543d24 = [];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [];
    var_881289d7987bc770.locationradius = [];
    activityinstances[ "HELI_TAKEDOWN_Q2_SUPERMARKET_01" ] = var_881289d7987bc770;
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_activitydef_activity_helitakedown";
    var_881289d7987bc770.var_265c4f33e2a6daa7 = 1;
    var_881289d7987bc770.cf = "mp_sat_avalon_q2_ob_heli_takedown_cs";
    var_881289d7987bc770.scriptstructorigin = ( 36357, 29406.9, 1305.32 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [];
    var_881289d7987bc770.var_31ce4477e3543d24 = [];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [];
    var_881289d7987bc770.locationradius = [];
    activityinstances[ "HELI_TAKEDOWN_Q2_COLOSSEUM" ] = var_881289d7987bc770;
    return activityinstances;
}

