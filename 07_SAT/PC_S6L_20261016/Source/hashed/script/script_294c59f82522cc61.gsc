// script_294c59f82522cc61  (hash_294c59f82522cc61.gscc) (size: 22628 Bytes / 0x5864 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xd517918c (3575091596)
// size ...... 22628 (0x5864)
// includes .. 4   (offset: 0x4ac0)
// strings ... 87  (offset: 0x4ae0)
// dev strs .. 0   (offset: 0x5864)
// exports ... 14  (offset: 0x4594)
// cseg ...... 0xa09 + 0x3b8b (0x4594)
// imports ... 27  (offset: 0x47c4)
// animtree1 . 0   (offset: 0x5864)
// animtree2 . 0   (offset: 0x5864)
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace mp_sat_avalon_q1_ob_activity_prime_target_cs;

// Namespace mp_sat_avalon_q1_ob_activity_prime_target_cs
// Params 0, eflags: 0x5
// Checksum 0x4f5a6795, Offset: 0xa27
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"mp_sat_avalon_q1_ob_activity_prime_target_cs", #"activity_common", &function_b39ecd3d51489472, undefined );
}

// Namespace mp_sat_avalon_q1_ob_activity_prime_target_cs
// Params 0, eflags: 0x4
// Checksum 0x55cda05, Offset: 0xa50
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace mp_sat_avalon_q1_ob_activity_prime_target_cs
// Params 0, eflags: 0x4
// Checksum 0x806709e9, Offset: 0xa61
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace mp_sat_avalon_q1_ob_activity_prime_target_cs
// Params 2
// Checksum 0x63cd78a1, Offset: 0xa72
// Size: 0x8c
function main( unused, unused2 )
{
    if ( utility::flag_exist( "mp_sat_avalon_q1_ob_activity_prime_target_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "mp_sat_avalon_q1_ob_activity_prime_target_cs" ) )
    {
        return;
    }
    
    activity_common::function_e1df676808c1d1e3( &function_4cd78e661617f3 );
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "mp_sat_avalon_q1_ob_activity_prime_target_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "mp_sat_avalon_q1_ob_activity_prime_target_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace mp_sat_avalon_q1_ob_activity_prime_target_cs
// Params 3, eflags: 0x4
// Checksum 0x3e5bd26, Offset: 0xb06
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "mp_sat_avalon_q1_ob_activity_prime_target_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "mp_sat_avalon_q1_ob_activity_prime_target_cs" );
}

// Namespace mp_sat_avalon_q1_ob_activity_prime_target_cs
// Params 3, eflags: 0x4
// Checksum 0xcb58a3b5, Offset: 0xb80
// Size: 0x3654
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_prime_target_cs";
    s.activity_bundle = "sat_ob_activitydefinition_primetarget";
    s.name = "PRIME_TARGET_CONSTRUCTION";
    fe [[ f ]]( s, "PRIME_TARGET_CONSTRUCTION", cf, ( -25288.5, 25430.3, 2367.24 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_prime_target_cs";
    s._size_max = ( 1722, 1756, 428 );
    s._size_min = ( 1968, 2060, 200 );
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
    fe [[ f ]]( s, "PRIME_TARGET_CONSTRUCTION", cf, ( -24529.4, 25487.2, 2014.09 ), ( 0, 300, 0 ), "PRIME_TARGET_CONSTRUCTION_enc_vol", undefined, "noent_volume_ai_encounter_cs", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_prime_target_cs";
    s._size_max = ( 726, 816, 350 );
    s._size_min = ( 700, 662, 200 );
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
    fe [[ f ]]( s, "PRIME_TARGET_CONSTRUCTION", cf, ( -24966.5, 25365.3, 2138.09 ), ( 0, 300, 0 ), "PRIME_TARGET_CONSTRUCTION_boss_enc_vol", undefined, "noent_volume_ai_encounter_cs", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_prime_target_cs";
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
    fe [[ f ]]( s, "PRIME_TARGET_CONSTRUCTION", cf, ( -24809.8, 25448.9, 2150.09 ), ( 0, 30, 0 ), "PRIME_TARGET_CONSTRUCTION_reinforcement_enc_vol", undefined, "noent_volume_ai_encounter_cs", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_prime_target_cs";
    fe [[ f ]]( s, "PRIME_TARGET_CONSTRUCTION", cf, ( -25167.7, 25185.1, 2247.24 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Proximity_Join_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 1920 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_prime_target_cs";
    s.ai_interaction = "idle_stretching";
    s.var_9a1a6bc9877cfff7 = "-1";
    s.repeat_interaction = "0";
    s.script_delay_max = "25";
    s.script_delay_min = "10";
    fe [[ f ]]( s, "PRIME_TARGET_CONSTRUCTION", cf, ( -26280.3, 24593.1, 1949.98 ), ( 0, 255, 0 ), "pt_construction_idle_stretch_01", undefined, "info_act", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_prime_target_cs";
    s.ai_interaction = "idle_smoke";
    s.var_9a1a6bc9877cfff7 = "-1";
    s.repeat_interaction = "0";
    s.script_delay_max = "25";
    s.script_delay_min = "10";
    fe [[ f ]]( s, "PRIME_TARGET_CONSTRUCTION", cf, ( -26544.3, 25057.1, 1951.76 ), ( 0, 225, 0 ), "pt_construction_idle_smoke_01", undefined, "info_act", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_prime_target_cs";
    s.ai_interaction = "idle_stretching";
    s.var_9a1a6bc9877cfff7 = "-1";
    s.repeat_interaction = "0";
    s.script_delay_max = "25";
    s.script_delay_min = "10";
    fe [[ f ]]( s, "PRIME_TARGET_CONSTRUCTION", cf, ( -24352.3, 27057.1, 2156.37 ), ( 0, 270, 0 ), "pt_construction_idle_stretch_02", undefined, "info_act", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_prime_target_cs";
    s.ai_interaction = "idle_smoke";
    s.var_9a1a6bc9877cfff7 = "-1";
    s.repeat_interaction = "0";
    s.script_delay_max = "25";
    s.script_delay_min = "10";
    fe [[ f ]]( s, "PRIME_TARGET_CONSTRUCTION", cf, ( -24985.7, 24685.2, 2049.54 ), ( 0, 255, 0 ), "pt_construction_idle_smoke_02", undefined, "info_act", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_prime_target_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "PRIME_TARGET_CONSTRUCTION", cf, ( -25208.3, 25609.1, 2076.48 ), ( 0, 150, 0 ), "cspf_1_auto16647615519556124629", "cspf_1_auto10129340643357836480", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_prime_target_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "PRIME_TARGET_CONSTRUCTION", cf, ( -24328.3, 24377.1, 2068.6 ), ( 0, 0, 0 ), "cspf_1_auto15861179457398889748", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_prime_target_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.reverse_route = "1";
    s.start_point = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "PRIME_TARGET_CONSTRUCTION", cf, ( -24928.3, 23985.1, 2043.18 ), ( 0, 240, 0 ), "cspf_1_auto9044815471456115058", "cspf_1_auto15861179457398889748", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_prime_target_cs";
    s.location_spawnpoint = "0";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.name = "spawnpoint_boss";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "boss";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "PRIME_TARGET_CONSTRUCTION", cf, ( -24092.3, 24390.1, 2069.11 ), ( 0, 278.94, 0 ), undefined, "cspf_1_auto15303103030946615494", "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_prime_target_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "PRIME_TARGET_CONSTRUCTION", cf, ( -23848.3, 24281.1, 2068.82 ), ( 0, 0, 0 ), "cspf_1_auto7045862638278467887", "cspf_1_auto10936792276475045436", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_prime_target_cs";
    s.loop_route = "1";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.start_point = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "PRIME_TARGET_CONSTRUCTION", cf, ( -24056.3, 24417.1, 2069.28 ), ( 0, 150, 0 ), "cspf_1_auto15303103030946615494", "cspf_1_auto7045862638278467887", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_prime_target_cs";
    s.info_act_ref = "pt_construction_idle_stretch_02";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "PRIME_TARGET_CONSTRUCTION", cf, ( -24352.3, 26993.1, 2158.1 ), ( 0, 0, 0 ), "cspf_1_auto5600987850319771130", "cspf_1_auto10213717576745265220", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_prime_target_cs";
    s.loop_route = "1";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.start_point = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "PRIME_TARGET_CONSTRUCTION", cf, ( -23752.3, 26897.1, 2152.2 ), ( 0, 0, 0 ), "cspf_1_auto3801834949416243439", "cspf_1_auto5600987850319771130", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_prime_target_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "PRIME_TARGET_CONSTRUCTION", cf, ( -25024.3, 26969.1, 2159.99 ), ( 0, 0, 0 ), "cspf_1_auto10213717576745265220", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_prime_target_cs";
    s.info_act_ref = "pt_construction_idle_smoke_01";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "PRIME_TARGET_CONSTRUCTION", cf, ( -26528.3, 25033.1, 1951.62 ), ( 0, 0, 0 ), "cspf_1_auto12188472329812895341", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_prime_target_cs";
    s.location_spawnpoint = "0";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.name = "spawnpoint_guard";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "PRIME_TARGET_CONSTRUCTION", cf, ( -23788.3, 26830.1, 2153.23 ), ( 0, 278.94, 0 ), undefined, "cspf_1_auto3801834949416243439", "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_prime_target_cs";
    s.location_spawnpoint = "0";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.name = "spawnpoint_guard";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "PRIME_TARGET_CONSTRUCTION", cf, ( -25420.3, 25598.1, 2073.57 ), ( 0, 278.94, 0 ), undefined, "cspf_1_auto4336741951980715216", "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_prime_target_cs";
    s.location_spawnpoint = "0";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.name = "spawnpoint_guard";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "PRIME_TARGET_CONSTRUCTION", cf, ( -24988.3, 23982.1, 2030.48 ), ( 0, 173.94, 0 ), undefined, "cspf_1_auto9044815471456115058", "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_prime_target_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.reverse_route = "1";
    s.start_point = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "PRIME_TARGET_CONSTRUCTION", cf, ( -25504.3, 24913.1, 2042.58 ), ( 0, 30, 0 ), "cspf_1_auto5878499519563514503", "cspf_1_auto17756196966866880918", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_prime_target_cs";
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
    fe [[ f ]]( s, "PRIME_TARGET_CONSTRUCTION", cf, ( -25468.3, 24894.1, 2046.52 ), ( 0, 278.94, 0 ), undefined, "cspf_1_auto5878499519563514503", "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_prime_target_cs";
    s.location_spawnpoint = "0";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.name = "spawnpoint_guard";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "PRIME_TARGET_CONSTRUCTION", cf, ( -25628.3, 25606.1, 2074.68 ), ( 0, 278.94, 0 ), undefined, "cspf_1_auto17292410690714824440", "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_prime_target_cs";
    s.info_act_ref = "pt_construction_idle_stretch_01";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "PRIME_TARGET_CONSTRUCTION", cf, ( -26240.3, 24625.1, 1948.72 ), ( 0, 0, 0 ), "cspf_1_auto17756196966866880918", "cspf_1_auto12188472329812895341", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_prime_target_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.reverse_route = "1";
    s.start_point = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "PRIME_TARGET_CONSTRUCTION", cf, ( -25616.3, 25609.1, 2074.46 ), ( 0, 135, 0 ), "cspf_1_auto17292410690714824440", "cspf_1_auto729020851454787773", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_prime_target_cs";
    s.info_act_ref = "pt_construction_idle_smoke_02";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "PRIME_TARGET_CONSTRUCTION", cf, ( -24984.3, 24729.1, 2052.14 ), ( 0, 0, 0 ), "cspf_1_auto729020851454787773", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_prime_target_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "PRIME_TARGET_CONSTRUCTION", cf, ( -24888.3, 26089.1, 2082.55 ), ( 0, 0, 0 ), "cspf_1_auto16052322187747377698", "cspf_1_auto1494540594000645549", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_prime_target_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.reverse_route = "1";
    s.start_point = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "PRIME_TARGET_CONSTRUCTION", cf, ( -25432.3, 25641.1, 2073.6 ), ( 0, 0, 0 ), "cspf_1_auto4336741951980715216", "cspf_1_auto16052322187747377698", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_prime_target_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "PRIME_TARGET_CONSTRUCTION", cf, ( -24472.3, 25697.1, 2073.58 ), ( 0, 0, 0 ), "cspf_1_auto1494540594000645549", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_prime_target_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "PRIME_TARGET_CONSTRUCTION", cf, ( -23504.3, 25113.1, 2070.09 ), ( 0, 0, 0 ), "cspf_1_auto10936792276475045436", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_prime_target_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.reverse_route = "1";
    s.start_point = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "PRIME_TARGET_CONSTRUCTION", cf, ( -25072.3, 25393.1, 2078.74 ), ( 0, 0, 0 ), undefined, "cspf_1_auto16647615519556124629", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_prime_target_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "PRIME_TARGET_CONSTRUCTION", cf, ( -24808.3, 25873.1, 2076.48 ), ( 0, 30, 0 ), "cspf_1_auto10129340643357836480", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_prime_target_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "PRIME_TARGET_GOLF_NURSERY", cf, ( -35411.7, 41644.6, 2241.86 ), ( 0, 0, 0 ), "cspf_2_auto14872666858436150606", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_prime_target_cs";
    s.activity_bundle = "sat_ob_activitydefinition_primetarget";
    s.name = "PRIME_TARGET_GOLF_NURSERY";
    fe [[ f ]]( s, "PRIME_TARGET_GOLF_NURSERY", cf, ( -36627.9, 42481.8, 2844.88 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_prime_target_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.reverse_route = "1";
    s.start_point = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "PRIME_TARGET_GOLF_NURSERY", cf, ( -36067.7, 41916.6, 2262.23 ), ( 0, 0, 0 ), "cspf_2_auto4492684904031525275", "cspf_2_auto14872666858436150606", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_prime_target_cs";
    s._size_max = ( 1252, 2034, 200 );
    s._size_min = ( 1180, 1816, 632 );
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
    fe [[ f ]]( s, "PRIME_TARGET_GOLF_NURSERY", cf, ( -35958.8, 42894.7, 2635.73 ), ( 0, 336, 0 ), "PRIME_TARGET_GOLF_NURSERY_enc_vol", undefined, "noent_volume_ai_encounter_cs", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_prime_target_cs";
    s._size_max = ( 590, 892, 210 );
    s._size_min = ( 698, 844, 200 );
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
    fe [[ f ]]( s, "PRIME_TARGET_GOLF_NURSERY", cf, ( -35705.9, 42168.8, 2335.73 ), ( 0, 336, 0 ), "PRIME_TARGET_GOLF_NURSERY_boss_enc_vol", undefined, "noent_volume_ai_encounter_cs", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_prime_target_cs";
    s._size_max = ( 1274, 994, 930 );
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
    fe [[ f ]]( s, "PRIME_TARGET_GOLF_NURSERY", cf, ( -35783.2, 42212.4, 1979.73 ), ( 0, 336, 0 ), "PRIME_TARGET_GOLF_NURSERY_reinforcement_enc_vol", undefined, "noent_volume_ai_encounter_cs", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_prime_target_cs";
    fe [[ f ]]( s, "PRIME_TARGET_GOLF_NURSERY", cf, ( -36507.1, 42236.6, 2724.88 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Proximity_Join_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 1920 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_prime_target_cs";
    s.ai_interaction = "idle_stretching";
    s.var_9a1a6bc9877cfff7 = "-1";
    s.repeat_interaction = "0";
    s.script_delay_max = "25";
    s.script_delay_min = "10";
    fe [[ f ]]( s, "PRIME_TARGET_GOLF_NURSERY", cf, ( -36227.7, 41972.6, 2254.53 ), ( 0, 45, 0 ), "pt_nursery_idle_stretch_01", undefined, "info_act", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_prime_target_cs";
    s.ai_interaction = "idle_smoke";
    s.var_9a1a6bc9877cfff7 = "-1";
    s.repeat_interaction = "0";
    s.script_delay_max = "25";
    s.script_delay_min = "10";
    fe [[ f ]]( s, "PRIME_TARGET_GOLF_NURSERY", cf, ( -36105.7, 42582.2, 2265.65 ), ( 0, 225, 0 ), "pt_nursery_idle_smoke_01", undefined, "info_act", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_prime_target_cs";
    s.ai_interaction = "idle_stretching";
    s.var_9a1a6bc9877cfff7 = "-1";
    s.repeat_interaction = "0";
    s.script_delay_max = "25";
    s.script_delay_min = "10";
    fe [[ f ]]( s, "PRIME_TARGET_GOLF_NURSERY", cf, ( -35875.7, 43212.6, 2264.7 ), ( 0, 225, 0 ), "pt_nursery_idle_stretch_02", undefined, "info_act", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_prime_target_cs";
    s.ai_interaction = "idle_smoke";
    s.var_9a1a6bc9877cfff7 = "-1";
    s.repeat_interaction = "0";
    s.script_delay_max = "25";
    s.script_delay_min = "10";
    fe [[ f ]]( s, "PRIME_TARGET_GOLF_NURSERY", cf, ( -35084.2, 42534.7, 2256.75 ), ( 0, 330, 0 ), "pt_nursery_idle_smoke_02", undefined, "info_act", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_prime_target_cs";
    s.location_spawnpoint = "0";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.name = "spawnpoint_boss";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "boss";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "PRIME_TARGET_GOLF_NURSERY", cf, ( -35775.7, 42497.6, 2264 ), ( 0, 278.94, 0 ), undefined, "cspf_2_auto16576394102660539869", "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_prime_target_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "PRIME_TARGET_GOLF_NURSERY", cf, ( -35931.7, 42076.6, 2264 ), ( 0, 0, 0 ), "cspf_2_auto7494885640477847889", "cspf_2_auto12900504690156911375", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_prime_target_cs";
    s.loop_route = "1";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.start_point = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "PRIME_TARGET_GOLF_NURSERY", cf, ( -35739.7, 42524.6, 2264 ), ( 0, 0, 0 ), "cspf_2_auto16576394102660539869", "cspf_2_auto7494885640477847889", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_prime_target_cs";
    s.info_act_ref = "pt_nursery_idle_stretch_02";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "PRIME_TARGET_GOLF_NURSERY", cf, ( -35859.7, 43236.6, 2266.98 ), ( 0, 210, 0 ), "cspf_2_auto15710479985483242660", "cspf_2_auto7101823421312125996", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_prime_target_cs";
    s.loop_route = "1";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.start_point = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "PRIME_TARGET_GOLF_NURSERY", cf, ( -34891.7, 42988.6, 2255.15 ), ( 0, 330, 0 ), "cspf_2_auto10078049662682197902", "cspf_2_auto15710479985483242660", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_prime_target_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "PRIME_TARGET_GOLF_NURSERY", cf, ( -36011.7, 44092.6, 2372.16 ), ( 0, 0, 0 ), "cspf_2_auto7101823421312125996", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_prime_target_cs";
    s.info_act_ref = "pt_nursery_idle_smoke_01";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "PRIME_TARGET_GOLF_NURSERY", cf, ( -36089.7, 42558.2, 2265.48 ), ( 0, 0, 0 ), "cspf_2_auto7872325361702326259", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_prime_target_cs";
    s.location_spawnpoint = "0";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.name = "spawnpoint_guard";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "PRIME_TARGET_GOLF_NURSERY", cf, ( -34927.7, 42921.6, 2260.82 ), ( 0, 278.94, 0 ), undefined, "cspf_2_auto10078049662682197902", "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_prime_target_cs";
    s.location_spawnpoint = "0";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.name = "spawnpoint_guard";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "PRIME_TARGET_GOLF_NURSERY", cf, ( -36325.9, 43984.8, 2338.88 ), ( 0, 278.94, 0 ), undefined, "cspf_2_auto3003381773113419133", "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_prime_target_cs";
    s.location_spawnpoint = "0";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.name = "spawnpoint_guard";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "PRIME_TARGET_GOLF_NURSERY", cf, ( -36047.7, 41953.6, 2263.99 ), ( 0, 278.94, 0 ), undefined, "cspf_2_auto4492684904031525275", "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_prime_target_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.reverse_route = "1";
    s.start_point = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "PRIME_TARGET_GOLF_NURSERY", cf, ( -36099.7, 41100.6, 2110.23 ), ( 0, 0, 0 ), "cspf_2_auto4569095511449364373", "cspf_2_auto10268944942237459873", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_prime_target_cs";
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
    fe [[ f ]]( s, "PRIME_TARGET_GOLF_NURSERY", cf, ( -36063.7, 41081.6, 2104.34 ), ( 0, 278.94, 0 ), undefined, "cspf_2_auto4569095511449364373", "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_prime_target_cs";
    s.location_spawnpoint = "0";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.name = "spawnpoint_guard";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "PRIME_TARGET_GOLF_NURSERY", cf, ( -35959.7, 42865.6, 2264 ), ( 0, 278.94, 0 ), undefined, "cspf_2_auto12425271093216327617", "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_prime_target_cs";
    s.info_act_ref = "pt_nursery_idle_stretch_01";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "PRIME_TARGET_GOLF_NURSERY", cf, ( -36243.7, 41956.6, 2253.25 ), ( 0, 0, 0 ), "cspf_2_auto10268944942237459873", "cspf_2_auto7872325361702326259", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_prime_target_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.reverse_route = "1";
    s.start_point = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "PRIME_TARGET_GOLF_NURSERY", cf, ( -35947.7, 42868.6, 2264 ), ( 0, 0, 0 ), "cspf_2_auto12425271093216327617", "cspf_2_auto13184345285388143714", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_prime_target_cs";
    s.info_act_ref = "pt_nursery_idle_smoke_02";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "PRIME_TARGET_GOLF_NURSERY", cf, ( -35107.7, 42564.6, 2262.71 ), ( 0, 0, 0 ), "cspf_2_auto13184345285388143714", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_prime_target_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "PRIME_TARGET_GOLF_NURSERY", cf, ( -35843.3, 44342.9, 2392.98 ), ( 0, 0, 0 ), "cspf_2_auto6110686541424644785", "cspf_2_auto1160656581641774983", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_prime_target_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.reverse_route = "1";
    s.start_point = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "PRIME_TARGET_GOLF_NURSERY", cf, ( -36337.9, 44027.8, 2340.03 ), ( 0, 0, 0 ), "cspf_2_auto3003381773113419133", "cspf_2_auto6110686541424644785", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_prime_target_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "PRIME_TARGET_GOLF_NURSERY", cf, ( -34942.4, 44007.4, 2375.95 ), ( 0, 0, 0 ), "cspf_2_auto1160656581641774983", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_prime_target_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "PRIME_TARGET_GOLF_NURSERY", cf, ( -35619.7, 41948.6, 2265.79 ), ( 0, 0, 0 ), "cspf_2_auto12900504690156911375", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace mp_sat_avalon_q1_ob_activity_prime_target_cs
// Params 0, eflags: 0x4
// Checksum 0x7449ccec, Offset: 0x41dc
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace mp_sat_avalon_q1_ob_activity_prime_target_cs
// Params 0
// Checksum 0xc1b6606b, Offset: 0x41e6
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "mp_sat_avalon_q1_ob_activity_prime_target_cs" );
}

// Namespace mp_sat_avalon_q1_ob_activity_prime_target_cs
// Params 0
// Checksum 0xa7a7ba66, Offset: 0x41fc
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

// Namespace mp_sat_avalon_q1_ob_activity_prime_target_cs
// Params 4
// Checksum 0xf0c63dac, Offset: 0x426b
// Size: 0x71
function function_d4323822d7042e5a( var_4312b79c960726b6, fe, us, cf = "mp_sat_avalon_q1_ob_activity_prime_target_cs" )
{
    switch ( var_4312b79c960726b6 )
    {
        case #"hash_215d125b542103b4":
            function_6d4e05acc61d8fac( fe, us, cf );
            break;
        case #"hash_25e5b8c41d6fc492":
            function_914fcda4a946958a( fe, us, cf );
            break;
    }
}

// Namespace mp_sat_avalon_q1_ob_activity_prime_target_cs
// Params 3
// Checksum 0x753752e, Offset: 0x42e4
// Size: 0xae
function function_6d4e05acc61d8fac( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_prime_target_cs";
    s.name = "prime_target_boss_spawnpoint";
    fe [[ f ]]( s, "PRIME_TARGET_CONSTRUCTION", cf, ( -24813.7, 25491.1, 2076.48 ), ( 0, 0, 0 ), "encounter_spawntarget", undefined, "PRIME_TARGET_CONSTRUCTION", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 512 );
}

// Namespace mp_sat_avalon_q1_ob_activity_prime_target_cs
// Params 3
// Checksum 0x57438583, Offset: 0x439a
// Size: 0xae
function function_914fcda4a946958a( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_prime_target_cs";
    s.name = "prime_target_boss_spawnpoint";
    fe [[ f ]]( s, "PRIME_TARGET_GOLF_NURSERY", cf, ( -35753.1, 42254.6, 2265.79 ), ( 0, 0, 0 ), "encounter_spawntarget", undefined, "PRIME_TARGET_GOLF_NURSERY", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 384 );
}

// Namespace mp_sat_avalon_q1_ob_activity_prime_target_cs
// Params 0
// Checksum 0xe5646808, Offset: 0x4450
// Size: 0x143
function function_d9dd7965c51c95d1()
{
    activityinstances = [];
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_ob_activitydefinition_primetarget";
    var_881289d7987bc770.cf = "mp_sat_avalon_q1_ob_activity_prime_target_cs";
    var_881289d7987bc770.scriptstructorigin = ( -25288.5, 25430.3, 2367.24 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [];
    var_881289d7987bc770.var_31ce4477e3543d24 = [];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [];
    var_881289d7987bc770.locationradius = [];
    activityinstances[ "PRIME_TARGET_CONSTRUCTION" ] = var_881289d7987bc770;
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_ob_activitydefinition_primetarget";
    var_881289d7987bc770.cf = "mp_sat_avalon_q1_ob_activity_prime_target_cs";
    var_881289d7987bc770.scriptstructorigin = ( -36627.9, 42481.8, 2844.88 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [];
    var_881289d7987bc770.var_31ce4477e3543d24 = [];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [];
    var_881289d7987bc770.locationradius = [];
    activityinstances[ "PRIME_TARGET_GOLF_NURSERY" ] = var_881289d7987bc770;
    return activityinstances;
}

