// script_3bb5d453cab4b569  (hash_3bb5d453cab4b569.gscc) (size: 36732 Bytes / 0x8f7c / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x8510d41f (2232472607)
// size ...... 36732 (0x8f7c)
// includes .. 4   (offset: 0x7a1c)
// strings ... 110 (offset: 0x7a3c)
// dev strs .. 0   (offset: 0x8f7c)
// exports ... 17  (offset: 0x7418)
// cseg ...... 0xdc6 + 0x6652 (0x7418)
// imports ... 30  (offset: 0x76c0)
// animtree1 . 0   (offset: 0x8f7c)
// animtree2 . 0   (offset: 0x8f7c)
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace mp_sat_avalon_q3_ob_activity_supply_drop_cs;

// Namespace mp_sat_avalon_q3_ob_activity_supply_drop_cs
// Params 0, eflags: 0x5
// Checksum 0x30c3f163, Offset: 0xde4
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"mp_sat_avalon_q3_ob_activity_supply_drop_cs", #"activity_common", &function_b39ecd3d51489472, undefined );
}

// Namespace mp_sat_avalon_q3_ob_activity_supply_drop_cs
// Params 0, eflags: 0x4
// Checksum 0x9f338c7, Offset: 0xe0d
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace mp_sat_avalon_q3_ob_activity_supply_drop_cs
// Params 0, eflags: 0x4
// Checksum 0x8cc8eb2b, Offset: 0xe1e
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace mp_sat_avalon_q3_ob_activity_supply_drop_cs
// Params 2
// Checksum 0xe238e807, Offset: 0xe2f
// Size: 0x8c
function main( unused, unused2 )
{
    if ( utility::flag_exist( "mp_sat_avalon_q3_ob_activity_supply_drop_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "mp_sat_avalon_q3_ob_activity_supply_drop_cs" ) )
    {
        return;
    }
    
    activity_common::function_e1df676808c1d1e3( &function_4cd78e661617f3 );
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "mp_sat_avalon_q3_ob_activity_supply_drop_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "mp_sat_avalon_q3_ob_activity_supply_drop_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace mp_sat_avalon_q3_ob_activity_supply_drop_cs
// Params 3, eflags: 0x4
// Checksum 0xf4a5fe4, Offset: 0xec3
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "mp_sat_avalon_q3_ob_activity_supply_drop_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "mp_sat_avalon_q3_ob_activity_supply_drop_cs" );
}

// Namespace mp_sat_avalon_q3_ob_activity_supply_drop_cs
// Params 3, eflags: 0x4
// Checksum 0xb3aebf75, Offset: 0xf3d
// Size: 0x4d74
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_drop_cs";
    s.activity_bundle = "sat_activitydefinition_supply_drop";
    s.name = "SUPPLY_DROP_Q3_ISLAND_ARMORY";
    fe [[ f ]]( s, "SUPPLY_DROP_Q3_ISLAND_ARMORY", cf, ( -37960.5, -43102.5, 690.76 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_drop_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "supply_drop_rusher";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "SUPPLY_DROP_Q3_ISLAND_ARMORY", cf, ( -37570.3, -43099.3, 684.66 ), ( 0, 232.22, 0 ), undefined, "cspf_1_auto15414284973388908", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_drop_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "supply_drop_rusher";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "SUPPLY_DROP_Q3_ISLAND_ARMORY", cf, ( -38283.9, -43172.3, 691.92 ), ( 0, 235.15, 0 ), undefined, "cspf_1_auto9015538694277187672", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_drop_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "supply_drop_rusher";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "SUPPLY_DROP_Q3_ISLAND_ARMORY", cf, ( -37564.1, -43413.1, 684.4 ), ( 0, 107.12, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_drop_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "supply_drop_long";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "SUPPLY_DROP_Q3_ISLAND_ARMORY", cf, ( -37635.1, -42793.1, 687.02 ), ( 0, 234.08, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_drop_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "supply_drop_long";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "SUPPLY_DROP_Q3_ISLAND_ARMORY", cf, ( -37740.4, -42963.6, 688.6 ), ( 0, 264.36, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_drop_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "supply_drop_long";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "SUPPLY_DROP_Q3_ISLAND_ARMORY", cf, ( -38215.6, -43012.9, 698.33 ), ( 0, 346.87, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_drop_cs";
    fe [[ f ]]( s, "SUPPLY_DROP_Q3_ISLAND_ARMORY", cf, ( -37946.4, -43094, 690.9 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Ambient_AI_Exclusion_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 1800 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_drop_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_DROP_Q3_ISLAND_ARMORY", cf, ( -38904.6, -43234.7, 700.58 ), ( 0, 180, 0 ), "cspf_1_auto16712301097167956901", "cspf_1_auto14315010123478467653", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_drop_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_DROP_Q3_ISLAND_ARMORY", cf, ( -38904.8, -43215.6, 700.53 ), ( 0, 180, 0 ), "cspf_1_auto17036042864117220799", "cspf_1_auto16712301097167956901", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_drop_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_DROP_Q3_ISLAND_ARMORY", cf, ( -38344.5, -43243.6, 693.52 ), ( 0, 180, 0 ), "cspf_1_auto14315010123478467653", "cspf_1_auto9015538694277187672", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_drop_cs";
    s.loop_route = "1";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.start_point = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_DROP_Q3_ISLAND_ARMORY", cf, ( -38345.2, -43223.5, 695.1 ), ( 0, 180, 0 ), "cspf_1_auto9015538694277187672", "cspf_1_auto17036042864117220799", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_drop_cs";
    s.loop_route = "1";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.start_point = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_DROP_Q3_ISLAND_ARMORY", cf, ( -37620.4, -43148.8, 684.66 ), ( 0, 0, 0 ), "cspf_1_auto15414284973388908", "cspf_1_auto14795397116717056910", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_drop_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_DROP_Q3_ISLAND_ARMORY", cf, ( -37620.8, -43169, 684.39 ), ( 0, 0, 0 ), "cspf_1_auto16945024672625325458", "cspf_1_auto15414284973388908", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_drop_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_DROP_Q3_ISLAND_ARMORY", cf, ( -36991.9, -43178, 684.93 ), ( 0, 0, 0 ), "cspf_1_auto8759203710955726772", "cspf_1_auto16945024672625325458", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_drop_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_DROP_Q3_ISLAND_ARMORY", cf, ( -36989.3, -43150.9, 686.98 ), ( 0, 0, 0 ), "cspf_1_auto14795397116717056910", "cspf_1_auto8759203710955726772", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_drop_cs";
    s.groupid = "reinforcement_spawn_point";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "supply_drop_heli";
    s.variantname = "ai_encounter_spawnpoint";
    s.var_4501e0172e168ddf = "SUPPLY_DROP_Q3_ISLAND_ARMORY_VTOL";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "SUPPLY_DROP_Q3_ISLAND_ARMORY", cf, ( -38255.8, -43273, 692.08 ), ( 0, 17.16, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_drop_cs";
    s.activity_bundle = "sat_activitydefinition_supply_drop";
    s.name = "SUPPLY_DROP_Q3_FLATS_FIRE_STATION";
    fe [[ f ]]( s, "SUPPLY_DROP_Q3_FLATS_FIRE_STATION", cf, ( -14526.6, -30325.7, 546.46 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_drop_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "supply_drop_long";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "SUPPLY_DROP_Q3_FLATS_FIRE_STATION", cf, ( -14421.4, -30147.1, 541.2 ), ( 0, 157.58, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_drop_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "supply_drop_long";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "SUPPLY_DROP_Q3_FLATS_FIRE_STATION", cf, ( -14718.3, -30190.7, 519.35 ), ( 0, 202.54, 0 ), undefined, "cspf_2_auto5275458771343455866", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_drop_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "supply_drop_rusher";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "SUPPLY_DROP_Q3_FLATS_FIRE_STATION", cf, ( -15013.1, -30480.5, 492 ), ( 0, 133.82, 0 ), undefined, "cspf_2_auto15032158590855882817", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_drop_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "supply_drop_rusher";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "SUPPLY_DROP_Q3_FLATS_FIRE_STATION", cf, ( -14774.4, -30707.4, 488.12 ), ( 0, 266.27, 0 ), undefined, "cspf_2_auto11778379722043677813", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_drop_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "supply_drop_long";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "SUPPLY_DROP_Q3_FLATS_FIRE_STATION", cf, ( -14787.5, -30478.4, 512.97 ), ( 0, 165.14, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_drop_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "supply_drop_rusher";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "SUPPLY_DROP_Q3_FLATS_FIRE_STATION", cf, ( -14545.3, -30531.4, 526.15 ), ( 0, 154.54, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_drop_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_DROP_Q3_FLATS_FIRE_STATION", cf, ( -14894.8, -30824.7, 463.24 ), ( 0, 0, 0 ), "cspf_2_auto4908887823150825468", "cspf_2_auto11837105958695995274", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_drop_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_DROP_Q3_FLATS_FIRE_STATION", cf, ( -14777.3, -30809.2, 479.52 ), ( 0, 0, 0 ), "cspf_2_auto11837105958695995274", "cspf_2_auto11778379722043677813", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_drop_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_DROP_Q3_FLATS_FIRE_STATION", cf, ( -15053.4, -30812.9, 449.99 ), ( 0, 0, 0 ), "cspf_2_auto6155658594789383904", "cspf_2_auto4908887823150825468", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_drop_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_DROP_Q3_FLATS_FIRE_STATION", cf, ( -15137.9, -30722.9, 447.52 ), ( 0, 0, 0 ), "cspf_2_auto2437670132250172827", "cspf_2_auto6155658594789383904", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_drop_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_DROP_Q3_FLATS_FIRE_STATION", cf, ( -15119, -30692.1, 452.74 ), ( 0, 0, 0 ), "cspf_2_auto6171374188073219343", "cspf_2_auto2437670132250172827", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_drop_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_DROP_Q3_FLATS_FIRE_STATION", cf, ( -15037.5, -30775, 451.83 ), ( 0, 0, 0 ), "cspf_2_auto16552712235694614159", "cspf_2_auto6171374188073219343", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_drop_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_DROP_Q3_FLATS_FIRE_STATION", cf, ( -14898.7, -30787.3, 465.95 ), ( 0, 0, 0 ), "cspf_2_auto1261286914289753000", "cspf_2_auto16552712235694614159", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_drop_cs";
    s.loop_route = "1";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.start_point = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_DROP_Q3_FLATS_FIRE_STATION", cf, ( -14786.9, -30773.9, 479.68 ), ( 0, 0, 0 ), "cspf_2_auto11778379722043677813", "cspf_2_auto1261286914289753000", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_drop_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_DROP_Q3_FLATS_FIRE_STATION", cf, ( -14938.1, -30189.4, 495.82 ), ( 0, 0, 0 ), "cspf_2_auto5626987802096756674", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_drop_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.start_point = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_DROP_Q3_FLATS_FIRE_STATION", cf, ( -14800.5, -30182.5, 509.36 ), ( 0, 0, 0 ), "cspf_2_auto5275458771343455866", "cspf_2_auto5626987802096756674", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_drop_cs";
    fe [[ f ]]( s, "SUPPLY_DROP_Q3_FLATS_FIRE_STATION", cf, ( -14533.5, -30359.5, 544.05 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Ambient_AI_Exclusion_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 2300 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_drop_cs";
    s.loop_route = "1";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.start_point = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_DROP_Q3_FLATS_FIRE_STATION", cf, ( -15062.4, -30403.3, 475.24 ), ( 0, 0, 0 ), "cspf_2_auto15032158590855882817", "cspf_2_auto5379114030405486210", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_drop_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.start_point = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_DROP_Q3_FLATS_FIRE_STATION", cf, ( -15063.2, -30332.9, 477.69 ), ( 0, 0, 0 ), "cspf_2_auto16652536527152816218", "cspf_2_auto15032158590855882817", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_drop_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.start_point = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_DROP_Q3_FLATS_FIRE_STATION", cf, ( -15584.1, -30276.8, 438.97 ), ( 0, 0, 0 ), "cspf_2_auto15593616667337048792", "cspf_2_auto16652536527152816218", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_drop_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.start_point = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_DROP_Q3_FLATS_FIRE_STATION", cf, ( -15589.3, -30337.4, 440.16 ), ( 0, 0, 0 ), "cspf_2_auto5379114030405486210", "cspf_2_auto15593616667337048792", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_drop_cs";
    s.groupid = "reinforcement_spawn_point";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "supply_drop_heli";
    s.variantname = "ai_encounter_spawnpoint";
    s.var_4501e0172e168ddf = "SUPPLY_DROP_Q3_FLATS_FIRE_STATION_VTOL";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "SUPPLY_DROP_Q3_FLATS_FIRE_STATION", cf, ( -15015.6, -30351.8, 483.65 ), ( 0, 3.89, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_drop_cs";
    s.activity_bundle = "sat_activitydefinition_supply_drop";
    s.name = "SUPPLY_DROP_Q3_LISTENING_POST_RADAR";
    fe [[ f ]]( s, "SUPPLY_DROP_Q3_LISTENING_POST_RADAR", cf, ( -11440.7, -43622.1, 681.41 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_drop_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "supply_drop_rusher";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "SUPPLY_DROP_Q3_LISTENING_POST_RADAR", cf, ( -11317.9, -43158.6, 682.3 ), ( 0, 289.66, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_drop_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "supply_drop_rusher";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "SUPPLY_DROP_Q3_LISTENING_POST_RADAR", cf, ( -11778.9, -43876.2, 656.94 ), ( 0, 266.11, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_drop_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "supply_drop_rusher";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "SUPPLY_DROP_Q3_LISTENING_POST_RADAR", cf, ( -10952.8, -43809.6, 684.33 ), ( 0, 48.84, 0 ), undefined, "cspf_3_auto10516492612074713682", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_drop_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "supply_drop_long";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "SUPPLY_DROP_Q3_LISTENING_POST_RADAR", cf, ( -11734.4, -43468.6, 673.15 ), ( 0, 148.26, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_drop_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "supply_drop_long";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "SUPPLY_DROP_Q3_LISTENING_POST_RADAR", cf, ( -11460.2, -44092.4, 654.24 ), ( 0, 128.21, 0 ), undefined, "cspf_3_auto14844029548592730658", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_drop_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "supply_drop_long";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "SUPPLY_DROP_Q3_LISTENING_POST_RADAR", cf, ( -11091.3, -43388.7, 691.3 ), ( 0, 94.34, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_drop_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_DROP_Q3_LISTENING_POST_RADAR", cf, ( -10867.6, -43766.7, 685.72 ), ( 0, 0, 0 ), "cspf_3_auto9233149766427035927", "cspf_3_auto10516492612074713682", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_drop_cs";
    s.loop_route = "1";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.start_point = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_DROP_Q3_LISTENING_POST_RADAR", cf, ( -10907.8, -43744.1, 685.71 ), ( 0, 0, 0 ), "cspf_3_auto10516492612074713682", "cspf_3_auto1838424409621931006", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_drop_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_DROP_Q3_LISTENING_POST_RADAR", cf, ( -10654, -43252, 706.14 ), ( 0, 0, 0 ), "cspf_3_auto1838424409621931006", "cspf_3_auto3789654850196288796", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_drop_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_DROP_Q3_LISTENING_POST_RADAR", cf, ( -10604.9, -43282.5, 706.93 ), ( 0, 0, 0 ), "cspf_3_auto3789654850196288796", "cspf_3_auto9233149766427035927", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_drop_cs";
    s.loop_route = "1";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.start_point = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_DROP_Q3_LISTENING_POST_RADAR", cf, ( -11513.4, -43967, 662.59 ), ( 0, 0, 0 ), "cspf_3_auto14844029548592730658", "cspf_3_auto15738963242013371908", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_drop_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_DROP_Q3_LISTENING_POST_RADAR", cf, ( -11325.1, -44147.8, 657.64 ), ( 0, 0, 0 ), "cspf_3_auto7426068540413486065", "cspf_3_auto14844029548592730658", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_drop_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_DROP_Q3_LISTENING_POST_RADAR", cf, ( -11125.9, -44265, 676.66 ), ( 0, 0, 0 ), "cspf_3_auto6746416481730218390", "cspf_3_auto7426068540413486065", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_drop_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_DROP_Q3_LISTENING_POST_RADAR", cf, ( -11301.7, -44059.4, 670.4 ), ( 0, 0, 0 ), "cspf_3_auto5578259089881488812", "cspf_3_auto6746416481730218390", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_drop_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_DROP_Q3_LISTENING_POST_RADAR", cf, ( -11387.2, -43757.6, 678.66 ), ( 0, 0, 0 ), "cspf_3_auto15371443313363514656", "cspf_3_auto5578259089881488812", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_drop_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_DROP_Q3_LISTENING_POST_RADAR", cf, ( -11497.1, -43681.3, 676.93 ), ( 0, 0, 0 ), "cspf_3_auto16658231042717218887", "cspf_3_auto15371443313363514656", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_drop_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_DROP_Q3_LISTENING_POST_RADAR", cf, ( -11629.9, -43643.8, 673.29 ), ( 0, 0, 0 ), "cspf_3_auto11320848543378147697", "cspf_3_auto16658231042717218887", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_drop_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_DROP_Q3_LISTENING_POST_RADAR", cf, ( -11906.9, -43503.7, 664.62 ), ( 0, 0, 0 ), "cspf_3_auto15738963242013371908", "cspf_3_auto11320848543378147697", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_drop_cs";
    fe [[ f ]]( s, "SUPPLY_DROP_Q3_LISTENING_POST_RADAR", cf, ( -11436.4, -43613.1, 681.58 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Ambient_AI_Exclusion_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 1750 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_drop_cs";
    s.groupid = "reinforcement_spawn_point";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "supply_drop_heli";
    s.variantname = "ai_encounter_spawnpoint";
    s.var_4501e0172e168ddf = "SUPPLY_DROP_Q3_LISTENING_POST_RADAR_VTOL";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "SUPPLY_DROP_Q3_LISTENING_POST_RADAR", cf, ( -11714, -43229.8, 672.09 ), ( 0, 298.93, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_drop_cs";
    s.activity_bundle = "sat_activitydefinition_supply_drop";
    s.name = "SUPPLY_DROP_Q3_FORT_MIFORT";
    fe [[ f ]]( s, "SUPPLY_DROP_Q3_FORT_MIFORT", cf, ( -5450.6, -20355.1, 120 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_drop_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_DROP_Q3_FORT_MIFORT", cf, ( -5263.94, -19988.2, 120 ), ( 0, 0, 0 ), "cspf_4_auto67473891103528095", "cspf_4_auto12061833542559176937", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_drop_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "supply_drop_rusher";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "SUPPLY_DROP_Q3_FORT_MIFORT", cf, ( -5215.37, -19911.5, 120.77 ), ( 0, 262.13, 0 ), undefined, "cspf_4_auto12061833542559176937", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_drop_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "supply_drop_rusher";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "SUPPLY_DROP_Q3_FORT_MIFORT", cf, ( -5554.23, -20515.7, 126 ), ( 0, 53.83, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_drop_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "supply_drop_rusher";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "SUPPLY_DROP_Q3_FORT_MIFORT", cf, ( -5768.4, -20614.7, 126 ), ( 0, 33.01, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_drop_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "supply_drop_long";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "SUPPLY_DROP_Q3_FORT_MIFORT", cf, ( -5482.23, -19799, 120 ), ( 0, 244.21, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_drop_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "supply_drop_long";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "SUPPLY_DROP_Q3_FORT_MIFORT", cf, ( -5850.71, -20029.3, 126 ), ( 0, 10.93, 0 ), undefined, "cspf_4_auto4100461181305257447", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_drop_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "supply_drop_long";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "SUPPLY_DROP_Q3_FORT_MIFORT", cf, ( -5380.27, -19715.1, 184 ), ( 0, 339.02, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_drop_cs";
    fe [[ f ]]( s, "SUPPLY_DROP_Q3_FORT_MIFORT", cf, ( -5399.47, -20066.7, 120 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Ambient_AI_Exclusion_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 1500 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_drop_cs";
    s.loop_route = "1";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.start_point = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_DROP_Q3_FORT_MIFORT", cf, ( -5228, -19988.5, 120 ), ( 0, 0, 0 ), "cspf_4_auto12061833542559176937", "cspf_4_auto13242109948975617183", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_drop_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_DROP_Q3_FORT_MIFORT", cf, ( -5269.22, -20592, 126 ), ( 0, 0, 0 ), "cspf_4_auto14683281244945473740", "cspf_4_auto67473891103528095", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_drop_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_DROP_Q3_FORT_MIFORT", cf, ( -5231.56, -20594.6, 126 ), ( 0, 0, 0 ), "cspf_4_auto13242109948975617183", "cspf_4_auto14683281244945473740", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_drop_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_DROP_Q3_FORT_MIFORT", cf, ( -4925.77, -19998.6, 120 ), ( 0, 0, 0 ), "cspf_4_auto16978314273026555331", "cspf_4_auto10745483656482345947", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_drop_cs";
    s.loop_route = "1";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.start_point = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_DROP_Q3_FORT_MIFORT", cf, ( -5782.5, -20017, 120 ), ( 0, 0, 0 ), "cspf_4_auto4100461181305257447", "cspf_4_auto16978314273026555331", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_drop_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_DROP_Q3_FORT_MIFORT", cf, ( -4923.63, -19943.4, 120 ), ( 0, 0, 0 ), "cspf_4_auto10745483656482345947", "cspf_4_auto13967950340570933682", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_drop_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_DROP_Q3_FORT_MIFORT", cf, ( -5781.96, -19955.8, 120 ), ( 0, 0, 0 ), "cspf_4_auto13967950340570933682", "cspf_4_auto4100461181305257447", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_drop_cs";
    s.groupid = "reinforcement_spawn_point";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "supply_drop_heli";
    s.variantname = "ai_encounter_spawnpoint";
    s.var_4501e0172e168ddf = "SUPPLY_DROP_Q3_FORT_MIFORT_VTOL";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "SUPPLY_DROP_Q3_FORT_MIFORT", cf, ( -5483.94, -20368.9, 139.58 ), ( 0, 26.43, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_drop_cs";
    s.activity_bundle = "sat_activitydefinition_supply_drop";
    s.name = "SUPPLY_DROP_Q3_FIRINGRANGE_MIL_MESS_HALL";
    fe [[ f ]]( s, "SUPPLY_DROP_Q3_FIRINGRANGE_MIL_MESS_HALL", cf, ( -16960.7, -24264.5, 141.75 ), ( 0, 120.75, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_drop_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "supply_drop_rusher";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "SUPPLY_DROP_Q3_FIRINGRANGE_MIL_MESS_HALL", cf, ( -16733.1, -23718.3, 134.25 ), ( 0, 326.06, 0 ), undefined, "cspf_5_auto5239106488006079512", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_drop_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "supply_drop_rusher";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "SUPPLY_DROP_Q3_FIRINGRANGE_MIL_MESS_HALL", cf, ( -16836, -23812.2, 133.03 ), ( 0, 308.57, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_drop_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "supply_drop_rusher";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "SUPPLY_DROP_Q3_FIRINGRANGE_MIL_MESS_HALL", cf, ( -16555.5, -24219.8, 128.31 ), ( 0, 167.88, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_drop_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "supply_drop_long";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "SUPPLY_DROP_Q3_FIRINGRANGE_MIL_MESS_HALL", cf, ( -17158.2, -23945.5, 141.75 ), ( 0, 212.73, 0 ), undefined, "cspf_5_auto10624646711274720943", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_drop_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "supply_drop_long";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "SUPPLY_DROP_Q3_FIRINGRANGE_MIL_MESS_HALL", cf, ( -16945, -24416.8, 141.75 ), ( 0, 190.39, 0 ), undefined, "cspf_5_auto16317309887018329544", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_drop_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "supply_drop_long";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "SUPPLY_DROP_Q3_FIRINGRANGE_MIL_MESS_HALL", cf, ( -16994.1, -24254, 371.75 ), ( 0, 213.03, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_drop_cs";
    fe [[ f ]]( s, "SUPPLY_DROP_Q3_FIRINGRANGE_MIL_MESS_HALL", cf, ( -16944.7, -24216.2, 139.71 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Ambient_AI_Exclusion_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 1500 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_drop_cs";
    s.loop_route = "1";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.start_point = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_DROP_Q3_FIRINGRANGE_MIL_MESS_HALL", cf, ( -16627.1, -23745.9, 134.02 ), ( 0, 0, 0 ), "cspf_5_auto5239106488006079512", "cspf_5_auto14614329035266883291", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_drop_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_DROP_Q3_FIRINGRANGE_MIL_MESS_HALL", cf, ( -16236, -23440.5, 183.28 ), ( 0, 0, 0 ), "cspf_5_auto14614329035266883291", "cspf_5_auto8768116506275421050", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_drop_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_DROP_Q3_FIRINGRANGE_MIL_MESS_HALL", cf, ( -16645, -23711.6, 134.18 ), ( 0, 0, 0 ), "cspf_5_auto11291031764081158513", "cspf_5_auto5239106488006079512", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_drop_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_DROP_Q3_FIRINGRANGE_MIL_MESS_HALL", cf, ( -16253.5, -23421.9, 178.56 ), ( 0, 0, 0 ), "cspf_5_auto8768116506275421050", "cspf_5_auto11291031764081158513", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_drop_cs";
    s.loop_route = "1";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.start_point = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_DROP_Q3_FIRINGRANGE_MIL_MESS_HALL", cf, ( -17193.2, -24003.6, 141.75 ), ( 0, 0, 0 ), "cspf_5_auto10624646711274720943", "cspf_5_auto15539343166328591779", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_drop_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_DROP_Q3_FIRINGRANGE_MIL_MESS_HALL", cf, ( -17208.1, -23979.7, 141.75 ), ( 0, 0, 0 ), "cspf_5_auto11527759484607405589", "cspf_5_auto10624646711274720943", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_drop_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_DROP_Q3_FIRINGRANGE_MIL_MESS_HALL", cf, ( -17711.1, -24300.5, 141.75 ), ( 0, 0, 0 ), "cspf_5_auto15539343166328591779", "cspf_5_auto1912104866820952083", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_drop_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_DROP_Q3_FIRINGRANGE_MIL_MESS_HALL", cf, ( -17725.2, -24274.9, 141.75 ), ( 0, 0, 0 ), "cspf_5_auto1912104866820952083", "cspf_5_auto11527759484607405589", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_drop_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_DROP_Q3_FIRINGRANGE_MIL_MESS_HALL", cf, ( -17057.6, -24407.4, 141.75 ), ( 0, 0, 0 ), "cspf_5_auto7231091981526126801", "cspf_5_auto16317309887018329544", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_drop_cs";
    s.loop_route = "1";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.start_point = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_DROP_Q3_FIRINGRANGE_MIL_MESS_HALL", cf, ( -17039.8, -24438.3, 141.75 ), ( 0, 0, 0 ), "cspf_5_auto16317309887018329544", "cspf_5_auto1653359565547328456", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_drop_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_DROP_Q3_FIRINGRANGE_MIL_MESS_HALL", cf, ( -17479.8, -24685.1, 141.75 ), ( 0, 0, 0 ), "cspf_5_auto1653359565547328456", "cspf_5_auto1498267655864157239", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_drop_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_DROP_Q3_FIRINGRANGE_MIL_MESS_HALL", cf, ( -17495.1, -24659.7, 141.75 ), ( 0, 0, 0 ), "cspf_5_auto1498267655864157239", "cspf_5_auto7231091981526126801", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_drop_cs";
    s.groupid = "reinforcement_spawn_point";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "supply_drop_heli";
    s.variantname = "ai_encounter_spawnpoint";
    s.var_4501e0172e168ddf = "SUPPLY_DROP_Q3_FIRINGRANGE_MIL_MESS_HALL_VTOL";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "SUPPLY_DROP_Q3_FIRINGRANGE_MIL_MESS_HALL", cf, ( -16554.7, -23795.1, 140.14 ), ( 0, 264.87, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace mp_sat_avalon_q3_ob_activity_supply_drop_cs
// Params 0, eflags: 0x4
// Checksum 0xf5bc5c4a, Offset: 0x5cb9
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace mp_sat_avalon_q3_ob_activity_supply_drop_cs
// Params 0
// Checksum 0xcd1982a9, Offset: 0x5cc3
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "mp_sat_avalon_q3_ob_activity_supply_drop_cs" );
}

// Namespace mp_sat_avalon_q3_ob_activity_supply_drop_cs
// Params 0
// Checksum 0x720c02b6, Offset: 0x5cd9
// Size: 0x66
function function_4cd78e661617f3()
{
    activityinfostruct = {};
    activityinfostruct.name = "REV_OB_SUPPLY_DROP";
    activityinfostruct.scriptbundle = "sat_activitydefinition_supply_drop";
    activityinfostruct.mainfunction = &main;
    activityinfostruct.var_934f068483ae4ddb = &function_d4323822d7042e5a;
    activityinfostruct.metadatafunction = &function_d9dd7965c51c95d1;
    return activityinfostruct;
}

// Namespace mp_sat_avalon_q3_ob_activity_supply_drop_cs
// Params 4
// Checksum 0x4c34be1a, Offset: 0x5d48
// Size: 0xbf
function function_d4323822d7042e5a( var_4312b79c960726b6, fe, us, cf = "mp_sat_avalon_q3_ob_activity_supply_drop_cs" )
{
    switch ( var_4312b79c960726b6 )
    {
        case #"hash_fe4017ef25642908":
            function_84d9c1b957a00010( fe, us, cf );
            break;
        case #"hash_3bf0aef64e7356a6":
            function_ee305defcd97e3fe( fe, us, cf );
            break;
        case #"hash_8872116fe3a0203f":
            function_bca8839116adb8e7( fe, us, cf );
            break;
        case #"hash_6bb36c09ffde5d01":
            function_49367ab9f2e34c09( fe, us, cf );
            break;
        case #"hash_ea55712d52c4503c":
            function_a247b232f8da574( fe, us, cf );
            break;
    }
}

// Namespace mp_sat_avalon_q3_ob_activity_supply_drop_cs
// Params 3
// Checksum 0x65de1104, Offset: 0x5e0f
// Size: 0x3c6
function function_84d9c1b957a00010( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_drop_cs";
    s.name = "supply_drop_starter";
    fe [[ f ]]( s, "SUPPLY_DROP_Q3_ISLAND_ARMORY", cf, ( -33108.2, -31409, 650.45 ), ( 0, 101.57, 0 ), undefined, "cspf_6_auto10411227252898693438", "SUPPLY_DROP_Q3_ISLAND_ARMORY", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_drop_cs";
    s.name = "supply_drop_point";
    fe [[ f ]]( s, "SUPPLY_DROP_Q3_ISLAND_ARMORY", cf, ( -37949.3, -43092.3, 691.68 ), ( 0, 0, 0 ), "cspf_6_auto10411227252898693438", undefined, "east", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 600 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_drop_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    s.script_accel = "350";
    fe [[ f ]]( s, "SUPPLY_DROP_Q3_ISLAND_ARMORY", cf, ( -38346, -43202.6, 1302.56 ), ( 0, 347.33, 0 ), "SUPPLY_DROP_Q3_ISLAND_ARMORY_VTOL", "cspf_6_auto4366912530742038418", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_drop_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "SUPPLY_DROP_Q3_ISLAND_ARMORY", cf, ( -29692.1, -25793, 8486.15 ), ( 359.47, 46.85, 0.49 ), "cspf_6_auto17453806023628962853", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_drop_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "SUPPLY_DROP_Q3_ISLAND_ARMORY", cf, ( -51833.2, -37001.7, 7690.9 ), ( 0, 333.11, 0 ), undefined, "cspf_6_auto9869098982952515711", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150, 1 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_drop_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "SUPPLY_DROP_Q3_ISLAND_ARMORY", cf, ( -33543.9, -39977.7, 5591.15 ), ( 359.47, 46.85, 0.49 ), "cspf_6_auto4366912530742038418", "cspf_6_auto17453806023628962853", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_drop_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "SUPPLY_DROP_Q3_ISLAND_ARMORY", cf, ( -45797.6, -38991.3, 6613.4 ), ( 0, 11.59, 0 ), "cspf_6_auto9869098982952515711", "SUPPLY_DROP_Q3_ISLAND_ARMORY_VTOL", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
}

// Namespace mp_sat_avalon_q3_ob_activity_supply_drop_cs
// Params 3
// Checksum 0xb76e524d, Offset: 0x61dd
// Size: 0x3c6
function function_ee305defcd97e3fe( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_drop_cs";
    s.name = "supply_drop_starter";
    fe [[ f ]]( s, "SUPPLY_DROP_Q3_FLATS_FIRE_STATION", cf, ( -23831.7, -22397.9, 962.21 ), ( 0, 193.53, 0 ), undefined, "cspf_7_auto17993646473205385441", "SUPPLY_DROP_Q3_FLATS_FIRE_STATION", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_drop_cs";
    s.name = "supply_drop_point";
    fe [[ f ]]( s, "SUPPLY_DROP_Q3_FLATS_FIRE_STATION", cf, ( -14742.5, -30346.4, 483.42 ), ( 0, 0, 0 ), "cspf_7_auto17993646473205385441", undefined, "east", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 600 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_drop_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    s.script_accel = "350";
    fe [[ f ]]( s, "SUPPLY_DROP_Q3_FLATS_FIRE_STATION", cf, ( -15093.9, -30287.3, 1100.56 ), ( 0, 347.71, 0 ), "SUPPLY_DROP_Q3_FLATS_FIRE_STATION_VTOL", "cspf_7_auto10601657325394337121", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_drop_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "SUPPLY_DROP_Q3_FLATS_FIRE_STATION", cf, ( -6551.38, -12848.3, 8280.65 ), ( 359.47, 47.24, 0.5 ), "cspf_7_auto18304345718262067475", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_drop_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "SUPPLY_DROP_Q3_FLATS_FIRE_STATION", cf, ( -28616.9, -24205, 7485.4 ), ( 0, 333.5, 0 ), undefined, "cspf_7_auto7738162300111823660", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150, 1 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_drop_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "SUPPLY_DROP_Q3_FLATS_FIRE_STATION", cf, ( -10308.2, -27058.5, 5385.65 ), ( 359.47, 47.24, 0.5 ), "cspf_7_auto10601657325394337121", "cspf_7_auto18304345718262067475", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_drop_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "SUPPLY_DROP_Q3_FLATS_FIRE_STATION", cf, ( -22568.1, -26154.1, 6407.9 ), ( 0, 11.98, 0 ), "cspf_7_auto7738162300111823660", "SUPPLY_DROP_Q3_FLATS_FIRE_STATION_VTOL", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
}

// Namespace mp_sat_avalon_q3_ob_activity_supply_drop_cs
// Params 3
// Checksum 0xd988891b, Offset: 0x65ab
// Size: 0x3c6
function function_bca8839116adb8e7( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_drop_cs";
    s.name = "supply_drop_starter";
    fe [[ f ]]( s, "SUPPLY_DROP_Q3_LISTENING_POST_RADAR", cf, ( 46.99, -38181.1, 732.22 ), ( 0, 306.87, 0 ), undefined, "cspf_8_auto3086314759702902907", "SUPPLY_DROP_Q3_LISTENING_POST_RADAR", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_drop_cs";
    s.name = "supply_drop_point";
    fe [[ f ]]( s, "SUPPLY_DROP_Q3_LISTENING_POST_RADAR", cf, ( -11428.8, -43632.8, 678.17 ), ( 0, 0, 0 ), "cspf_8_auto3086314759702902907", undefined, "east", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 600 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_drop_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    s.script_accel = "350";
    fe [[ f ]]( s, "SUPPLY_DROP_Q3_LISTENING_POST_RADAR", cf, ( -11835.6, -43171.6, 1317.57 ), ( 0, 288.01, 0 ), "SUPPLY_DROP_Q3_LISTENING_POST_RADAR_VTOL", "cspf_8_auto17394119443085273454", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_drop_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "SUPPLY_DROP_Q3_LISTENING_POST_RADAR", cf, ( -14763.7, -55536.5, 8501.16 ), ( 359.47, 46.85, 0.49 ), "cspf_8_auto15815091162902071454", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_drop_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "SUPPLY_DROP_Q3_LISTENING_POST_RADAR", cf, ( -25220.8, -37515.2, 7705.91 ), ( 0, 333.11, 0 ), undefined, "cspf_8_auto6354780609408215124", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150, 1 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_drop_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "SUPPLY_DROP_Q3_LISTENING_POST_RADAR", cf, ( -11830, -48618.2, 5606.16 ), ( 359.47, 46.85, 0.49 ), "cspf_8_auto17394119443085273454", "cspf_8_auto15815091162902071454", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_drop_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "SUPPLY_DROP_Q3_LISTENING_POST_RADAR", cf, ( -19185.2, -39504.8, 6628.41 ), ( 0, 11.59, 0 ), "cspf_8_auto6354780609408215124", "SUPPLY_DROP_Q3_LISTENING_POST_RADAR_VTOL", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
}

// Namespace mp_sat_avalon_q3_ob_activity_supply_drop_cs
// Params 3
// Checksum 0x3427c230, Offset: 0x6979
// Size: 0x3c6
function function_49367ab9f2e34c09( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_drop_cs";
    s.name = "supply_drop_starter";
    fe [[ f ]]( s, "SUPPLY_DROP_Q3_FORT_MIFORT", cf, ( -17486.8, -42851.4, 208.52 ), ( 0, 79.57, 0 ), undefined, "cspf_9_auto12134391970478913200", "SUPPLY_DROP_Q3_FORT_MIFORT", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_drop_cs";
    s.name = "supply_drop_point";
    fe [[ f ]]( s, "SUPPLY_DROP_Q3_FORT_MIFORT", cf, ( -5457.43, -20240.4, 120 ), ( 0, 0, 0 ), "cspf_9_auto12134391970478913200", undefined, "east", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 600 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_drop_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    s.script_accel = "350";
    fe [[ f ]]( s, "SUPPLY_DROP_Q3_FORT_MIFORT", cf, ( -5590.68, -20353.3, 753.56 ), ( 0, 10.25, 0 ), "SUPPLY_DROP_Q3_FORT_MIFORT_VTOL", "cspf_9_auto14874706015624763530", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_drop_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "SUPPLY_DROP_Q3_FORT_MIFORT", cf, ( -4300.45, -1017.88, 7933.65 ), ( 359.47, 69.78, 0.49 ), "cspf_9_auto7976480099295751395", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_drop_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "SUPPLY_DROP_Q3_FORT_MIFORT", cf, ( -20327, -19965.6, 7138.4 ), ( 0, 356.03, 0 ), undefined, "cspf_9_auto7080979741646766050", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150, 1 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_drop_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "SUPPLY_DROP_Q3_FORT_MIFORT", cf, ( 964, -19648.2, 5038.65 ), ( 359.47, 69.78, 0.49 ), "cspf_9_auto14874706015624763530", "cspf_9_auto7976480099295751395", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_drop_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "SUPPLY_DROP_Q3_FORT_MIFORT", cf, ( -13993, -19447.1, 6060.9 ), ( 0, 34.52, 0 ), "cspf_9_auto7080979741646766050", "SUPPLY_DROP_Q3_FORT_MIFORT_VTOL", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
}

// Namespace mp_sat_avalon_q3_ob_activity_supply_drop_cs
// Params 3
// Checksum 0xfec2093b, Offset: 0x6d47
// Size: 0x3c6
function function_a247b232f8da574( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_drop_cs";
    s.name = "supply_drop_starter";
    fe [[ f ]]( s, "SUPPLY_DROP_Q3_FIRINGRANGE_MIL_MESS_HALL", cf, ( -22956.4, -11012.4, 844.57 ), ( 0, 190.23, 0 ), undefined, "cspf_10_auto14242473800742835570", "SUPPLY_DROP_Q3_FIRINGRANGE_MIL_MESS_HALL", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_drop_cs";
    s.name = "supply_drop_point";
    fe [[ f ]]( s, "SUPPLY_DROP_Q3_FIRINGRANGE_MIL_MESS_HALL", cf, ( -16716.4, -24084.4, 129.47 ), ( 0, 0, 0 ), "cspf_10_auto14242473800742835570", undefined, "east", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 600 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_drop_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    s.script_accel = "350";
    fe [[ f ]]( s, "SUPPLY_DROP_Q3_FIRINGRANGE_MIL_MESS_HALL", cf, ( -16632.1, -23790.1, 747.57 ), ( 0, 337.03, 0 ), "SUPPLY_DROP_Q3_FIRINGRANGE_MIL_MESS_HALL_VTOL", "cspf_10_auto8975773905712169698", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_drop_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "SUPPLY_DROP_Q3_FIRINGRANGE_MIL_MESS_HALL", cf, ( -4561.52, -8444.35, 7993.15 ), ( 359.47, 36.56, 0.5 ), "cspf_10_auto10737086144682127944", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_drop_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "SUPPLY_DROP_Q3_FIRINGRANGE_MIL_MESS_HALL", cf, ( -28349.6, -15514.5, 7197.9 ), ( 0, 322.81, 0 ), undefined, "cspf_10_auto3226139033182567353", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150, 1 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_drop_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "SUPPLY_DROP_Q3_FIRINGRANGE_MIL_MESS_HALL", cf, ( -10887, -21712, 5098.15 ), ( 359.47, 36.56, 0.5 ), "cspf_10_auto8975773905712169698", "cspf_10_auto10737086144682127944", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_drop_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "SUPPLY_DROP_Q3_FIRINGRANGE_MIL_MESS_HALL", cf, ( -22766.9, -18550.9, 6120.4 ), ( 0, 1.3, 0 ), "cspf_10_auto3226139033182567353", "SUPPLY_DROP_Q3_FIRINGRANGE_MIL_MESS_HALL_VTOL", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
}

// Namespace mp_sat_avalon_q3_ob_activity_supply_drop_cs
// Params 0
// Checksum 0x635eb72a, Offset: 0x7115
// Size: 0x302
function function_d9dd7965c51c95d1()
{
    activityinstances = [];
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_activitydefinition_supply_drop";
    var_881289d7987bc770.cf = "mp_sat_avalon_q3_ob_activity_supply_drop_cs";
    var_881289d7987bc770.scriptstructorigin = ( -37960.5, -43102.5, 690.76 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [];
    var_881289d7987bc770.var_31ce4477e3543d24 = [];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [];
    var_881289d7987bc770.locationradius = [];
    activityinstances[ "SUPPLY_DROP_Q3_ISLAND_ARMORY" ] = var_881289d7987bc770;
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_activitydefinition_supply_drop";
    var_881289d7987bc770.cf = "mp_sat_avalon_q3_ob_activity_supply_drop_cs";
    var_881289d7987bc770.scriptstructorigin = ( -14526.6, -30325.7, 546.46 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [];
    var_881289d7987bc770.var_31ce4477e3543d24 = [];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [];
    var_881289d7987bc770.locationradius = [];
    activityinstances[ "SUPPLY_DROP_Q3_FLATS_FIRE_STATION" ] = var_881289d7987bc770;
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_activitydefinition_supply_drop";
    var_881289d7987bc770.cf = "mp_sat_avalon_q3_ob_activity_supply_drop_cs";
    var_881289d7987bc770.scriptstructorigin = ( -11440.7, -43622.1, 681.41 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [];
    var_881289d7987bc770.var_31ce4477e3543d24 = [];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [];
    var_881289d7987bc770.locationradius = [];
    activityinstances[ "SUPPLY_DROP_Q3_LISTENING_POST_RADAR" ] = var_881289d7987bc770;
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_activitydefinition_supply_drop";
    var_881289d7987bc770.cf = "mp_sat_avalon_q3_ob_activity_supply_drop_cs";
    var_881289d7987bc770.scriptstructorigin = ( -5450.6, -20355.1, 120 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [];
    var_881289d7987bc770.var_31ce4477e3543d24 = [];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [];
    var_881289d7987bc770.locationradius = [];
    activityinstances[ "SUPPLY_DROP_Q3_FORT_MIFORT" ] = var_881289d7987bc770;
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_activitydefinition_supply_drop";
    var_881289d7987bc770.cf = "mp_sat_avalon_q3_ob_activity_supply_drop_cs";
    var_881289d7987bc770.scriptstructorigin = ( -16960.7, -24264.5, 141.75 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [];
    var_881289d7987bc770.var_31ce4477e3543d24 = [];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [];
    var_881289d7987bc770.locationradius = [];
    activityinstances[ "SUPPLY_DROP_Q3_FIRINGRANGE_MIL_MESS_HALL" ] = var_881289d7987bc770;
    return activityinstances;
}

