// script_27d3f9b56b57d81f  (hash_27d3f9b56b57d81f.gscc) (size: 27809 Bytes / 0x6ca1 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x26ba8f97 (649760663)
// size ...... 27809 (0x6ca1)
// includes .. 4   (offset: 0x5bbd)
// strings ... 92  (offset: 0x5bdd)
// dev strs .. 0   (offset: 0x6ca1)
// exports ... 14  (offset: 0x5691)
// cseg ...... 0xa57 + 0x4c3a (0x5691)
// imports ... 27  (offset: 0x58c1)
// animtree1 . 0   (offset: 0x6ca1)
// animtree2 . 0   (offset: 0x6ca1)
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace mp_sat_avalon_city_ob_activity_supply_sites_cs;

// Namespace mp_sat_avalon_city_ob_activity_supply_sites_cs
// Params 0, eflags: 0x5
// Checksum 0x2541e730, Offset: 0xa75
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"mp_sat_avalon_city_ob_activity_supply_sites_cs", #"activity_common", &function_b39ecd3d51489472, undefined );
}

// Namespace mp_sat_avalon_city_ob_activity_supply_sites_cs
// Params 0, eflags: 0x4
// Checksum 0x947741a, Offset: 0xa9e
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace mp_sat_avalon_city_ob_activity_supply_sites_cs
// Params 0, eflags: 0x4
// Checksum 0x8c7ca7f6, Offset: 0xaaf
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace mp_sat_avalon_city_ob_activity_supply_sites_cs
// Params 2
// Checksum 0x5919127f, Offset: 0xac0
// Size: 0x8c
function main( unused, unused2 )
{
    if ( utility::flag_exist( "mp_sat_avalon_city_ob_activity_supply_sites_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "mp_sat_avalon_city_ob_activity_supply_sites_cs" ) )
    {
        return;
    }
    
    activity_common::function_e1df676808c1d1e3( &function_4cd78e661617f3 );
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "mp_sat_avalon_city_ob_activity_supply_sites_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "mp_sat_avalon_city_ob_activity_supply_sites_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace mp_sat_avalon_city_ob_activity_supply_sites_cs
// Params 3, eflags: 0x4
// Checksum 0xffe1339, Offset: 0xb54
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "mp_sat_avalon_city_ob_activity_supply_sites_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "mp_sat_avalon_city_ob_activity_supply_sites_cs" );
}

// Namespace mp_sat_avalon_city_ob_activity_supply_sites_cs
// Params 3, eflags: 0x4
// Checksum 0x7d26156b, Offset: 0xbce
// Size: 0x3e65
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_supply_sites_cs";
    s.activity_bundle = "sat_activitydefinition_destroy_supplies";
    s.name = "SUPPLY_SITES_LOW_TOWN_GRAND_STAND";
    s.var_265c4f33e2a6daa7 = "1";
    fe [[ f ]]( s, "SUPPLY_SITES_LOW_TOWN_GRAND_STAND", cf, ( -7013.9, -1485.52, 280 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_supply_sites_cs";
    fe [[ f ]]( s, "SUPPLY_SITES_LOW_TOWN_GRAND_STAND", cf, ( -7005.55, -1526.06, 280 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Awareness_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 4000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_supply_sites_cs";
    fe [[ f ]]( s, "SUPPLY_SITES_LOW_TOWN_GRAND_STAND", cf, ( -7040.93, -1494.73, 280 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Ambient_AI_Exclusion_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 1200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_supply_sites_cs";
    s._size_max = ( 542.481, 939.15, 194 );
    s._size_min = ( 409.87, 2170.73, 484 );
    s.var_5afd49978f924648 = "1";
    s.var_a8568d8e0b0b6076 = "1";
    s.var_3f3960eb7318312d = "1";
    s.default_goal_radius = "-1";
    s.height = 128;
    s.length = "128";
    s.script_stealthgroup = "-1";
    s.script_string = "sat_ob_supply_sites_encounter";
    s.var_95e2cee7aca5aaae = "1";
    s.width = "128";
    fe [[ f ]]( s, "SUPPLY_SITES_LOW_TOWN_GRAND_STAND", cf, ( -7139.9, -222.27, 280.56 ), ( 0, 0, 0 ), "SUPPLY_SITES_LOW_TOWN_GRAND_STAND", undefined, "noent_volume_ai_encounter_cs", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_supply_sites_cs";
    s._size_max = ( 542.481, 939.15, 194 );
    s._size_min = ( 409.87, 2170.73, 484 );
    s.var_5afd49978f924648 = "1";
    s.var_a8568d8e0b0b6076 = "1";
    s.var_3f3960eb7318312d = "1";
    s.default_goal_radius = "-1";
    s.height = 128;
    s.length = "128";
    s.script_stealthgroup = "-1";
    s.script_string = "sat_ob_supply_sites_encounter_charging_pad";
    s.var_95e2cee7aca5aaae = "1";
    s.width = "128";
    fe [[ f ]]( s, "SUPPLY_SITES_LOW_TOWN_GRAND_STAND", cf, ( -7139.9, -222.27, 280.56 ), ( 0, 0, 0 ), "SUPPLY_SITES_LOW_TOWN_GRAND_STAND_charging_pad", undefined, "noent_volume_ai_encounter_cs", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_supply_sites_cs";
    s.groupid = "ai_spawn";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_parameters = "_a";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "advanced_guild_bot_charging_pad";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "SUPPLY_SITES_LOW_TOWN_GRAND_STAND", cf, ( -6886.06, -76.11, 279.42 ), ( 0, 180, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_supply_sites_cs";
    s.groupid = "ai_spawn";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_parameters = "_b";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "guild_bot_charging_pad";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "SUPPLY_SITES_LOW_TOWN_GRAND_STAND", cf, ( -7178.94, -1200.83, 285 ), ( 0, 0, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_supply_sites_cs";
    s.groupid = "ai_spawn";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "ss_shock";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "SUPPLY_SITES_LOW_TOWN_GRAND_STAND", cf, ( -7220.15, -2248.1, 285 ), ( 0, 89.18, 0 ), "cspf_1_auto1647015130178513540", "cspf_1_auto17187488804303003139", "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_supply_sites_cs";
    s.groupid = "ai_spawn";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_parameters = "_b";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "dawg_charging_pad";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "SUPPLY_SITES_LOW_TOWN_GRAND_STAND", cf, ( -6798.43, -1777.45, 280 ), ( 0, 179.76, 0 ), "cspf_1_auto1647015130178513540", undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_supply_sites_cs";
    s.groupid = "ai_spawn";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "ss_scientist";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "SUPPLY_SITES_LOW_TOWN_GRAND_STAND", cf, ( -7253.43, -6.99, 284.52 ), ( 0, 270.38, 0 ), "cspf_1_auto1647015130178513540", "cspf_1_auto2581874710071539672", "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_supply_sites_cs";
    s.groupid = "ai_spawn";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_parameters = "_a";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "guild_bot_charging_pad";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "SUPPLY_SITES_LOW_TOWN_GRAND_STAND", cf, ( -7179.53, 134.08, 284.5 ), ( 0, 0, 0 ), "cspf_1_auto1647015130178513540", undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_supply_sites_cs";
    s.groupid = "ai_spawn";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_parameters = "_a";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "dawg_charging_pad";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "SUPPLY_SITES_LOW_TOWN_GRAND_STAND", cf, ( -6798.67, -591.39, 280 ), ( 0, 180, 0 ), "cspf_1_auto1647015130178513540", undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_supply_sites_cs";
    s.groupid = "ai_spawn";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "ss_scientist";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "SUPPLY_SITES_LOW_TOWN_GRAND_STAND", cf, ( -6790.04, -1443.98, 280 ), ( 0, 181.41, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_supply_sites_cs";
    s.groupid = "ai_spawn";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "ss_dawg";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "SUPPLY_SITES_LOW_TOWN_GRAND_STAND", cf, ( -6764.75, -1251.66, 280 ), ( 0, 79.34, 0 ), undefined, "cspf_1_auto11684248440648482647", "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_supply_sites_cs";
    s.groupid = "ai_spawn";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_parameters = "_b";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "advanced_guild_bot_charging_pad";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "SUPPLY_SITES_LOW_TOWN_GRAND_STAND", cf, ( -6886.37, -1547.25, 277.96 ), ( 0, 180, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_supply_sites_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_SITES_LOW_TOWN_GRAND_STAND", cf, ( -7250.46, -2191.69, 285 ), ( 0, 0, 0 ), "cspf_1_auto10843155033873345491", "cspf_1_auto17187488804303003139", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_supply_sites_cs";
    s.loop_route = "1";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.start_point = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_SITES_LOW_TOWN_GRAND_STAND", cf, ( -7207.79, -2192.79, 285 ), ( 0, 0, 0 ), "cspf_1_auto17187488804303003139", "cspf_1_auto14637689081792785870", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_supply_sites_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_SITES_LOW_TOWN_GRAND_STAND", cf, ( -7204.33, -1508.81, 285 ), ( 0, 0, 0 ), "cspf_1_auto14637689081792785870", "cspf_1_auto13665486697813148224", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_supply_sites_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_SITES_LOW_TOWN_GRAND_STAND", cf, ( -7251.18, -1507.23, 285 ), ( 0, 0, 0 ), "cspf_1_auto13665486697813148224", "cspf_1_auto10843155033873345491", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_supply_sites_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_SITES_LOW_TOWN_GRAND_STAND", cf, ( -7259.65, -815.99, 285 ), ( 0, 0, 0 ), "cspf_1_auto16410180230083755840", "cspf_1_auto6278937038187123951", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_supply_sites_cs";
    s.loop_route = "1";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_SITES_LOW_TOWN_GRAND_STAND", cf, ( -7216.98, -817.09, 285 ), ( 0, 0, 0 ), "cspf_1_auto6278937038187123951", "cspf_1_auto18115655078449917358", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_supply_sites_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_SITES_LOW_TOWN_GRAND_STAND", cf, ( -7213.52, -133.11, 285 ), ( 0, 0, 0 ), "cspf_1_auto18115655078449917358", "cspf_1_auto2581874710071539672", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_supply_sites_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.start_point = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_SITES_LOW_TOWN_GRAND_STAND", cf, ( -7260.37, -131.53, 285 ), ( 0, 0, 0 ), "cspf_1_auto2581874710071539672", "cspf_1_auto16410180230083755840", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_supply_sites_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_SITES_LOW_TOWN_GRAND_STAND", cf, ( -6788.85, -773.17, 280 ), ( 0, 0, 0 ), "cspf_1_auto11898394348751784938", "cspf_1_auto7378659771554057944", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_supply_sites_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_SITES_LOW_TOWN_GRAND_STAND", cf, ( -6721.83, -775.04, 280 ), ( 0, 0, 0 ), "cspf_1_auto11859256957330661103", "cspf_1_auto11898394348751784938", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_supply_sites_cs";
    s.loop_route = "1";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.start_point = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_SITES_LOW_TOWN_GRAND_STAND", cf, ( -6743.65, -1185.77, 280 ), ( 0, 0, 0 ), "cspf_1_auto11684248440648482647", "cspf_1_auto11859256957330661103", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_supply_sites_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_SITES_LOW_TOWN_GRAND_STAND", cf, ( -6790.38, -1184.61, 280 ), ( 0, 0, 0 ), "cspf_1_auto7378659771554057944", "cspf_1_auto11684248440648482647", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_supply_sites_cs";
    s.groupid = "reinforcement_spawn_point_b";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.reinforcement_spawn = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "ss_vtol_rein_b";
    s.variantname = "ai_encounter_spawnpoint";
    s.var_4501e0172e168ddf = "SUPPLY_SITES_LOW_TOWN_GRAND_STAND_B";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "SUPPLY_SITES_LOW_TOWN_GRAND_STAND", cf, ( -7022.92, -215.24, 279.92 ), ( 0, 305.91, -0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_supply_sites_cs";
    s.groupid = "reinforcement_spawn_point_a";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.name = "ai_encounter_spawnpoint";
    s.var_6324368dbfa7058a = "3000";
    s.reinforcement_spawn = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "ss_vtol_rein_a";
    s.variantname = "ai_encounter_spawnpoint";
    s.var_4501e0172e168ddf = "SUPPLY_SITES_LOW_TOWN_GRAND_STAND_A";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "SUPPLY_SITES_LOW_TOWN_GRAND_STAND", cf, ( -7068, -2117.4, 279.42 ), ( 0, 176.68, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_supply_sites_cs";
    s.activity_bundle = "sat_activitydefinition_destroy_supplies";
    s.name = "SUPPLY_SITES_HIGH_TOWN_UNDERGROUND_TUNNEL";
    s.var_265c4f33e2a6daa7 = "1";
    fe [[ f ]]( s, "SUPPLY_SITES_HIGH_TOWN_UNDERGROUND_TUNNEL", cf, ( -16298.1, 8425.21, 542 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_supply_sites_cs";
    fe [[ f ]]( s, "SUPPLY_SITES_HIGH_TOWN_UNDERGROUND_TUNNEL", cf, ( -16191, 8411.37, 542 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Proximity_Abandon_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 1400 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_supply_sites_cs";
    fe [[ f ]]( s, "SUPPLY_SITES_HIGH_TOWN_UNDERGROUND_TUNNEL", cf, ( -16216, 8417.25, 542 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Awareness_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 1400 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_supply_sites_cs";
    fe [[ f ]]( s, "SUPPLY_SITES_HIGH_TOWN_UNDERGROUND_TUNNEL", cf, ( -16234, 8420.54, 542 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Proximity_Join_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 1400 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_supply_sites_cs";
    fe [[ f ]]( s, "SUPPLY_SITES_HIGH_TOWN_UNDERGROUND_TUNNEL", cf, ( -16229.1, 8420.7, 542 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Ambient_AI_Exclusion_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 1400 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_supply_sites_cs";
    s._size_max = ( 276, 1668, 194 );
    s._size_min = ( 885.87, 1836, 484 );
    s.var_5afd49978f924648 = "1";
    s.var_a8568d8e0b0b6076 = "1";
    s.var_3f3960eb7318312d = "1";
    s.default_goal_radius = "-1";
    s.height = 128;
    s.length = "128";
    s.script_stealthgroup = "-1";
    s.script_string = "sat_ob_supply_sites_encounter";
    s.var_95e2cee7aca5aaae = "1";
    s.width = "128";
    fe [[ f ]]( s, "SUPPLY_SITES_HIGH_TOWN_UNDERGROUND_TUNNEL", cf, ( -16330.4, 8078.58, 735.57 ), ( 0, 276, 0 ), "SUPPLY_SITES_HIGH_TOWN_UNDERGROUND_TUNNEL", undefined, "noent_volume_ai_encounter_cs", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_supply_sites_cs";
    s.groupid = "reinforcement_spawn_point_a";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.reinforcement_spawn = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "supply_site_backup_a";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "SUPPLY_SITES_HIGH_TOWN_UNDERGROUND_TUNNEL", cf, ( -16477.8, 8423.39, 542 ), ( 0, 2.65, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_supply_sites_cs";
    s.groupid = "reinforcement_spawn_point_a";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.reinforcement_spawn = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "supply_site_backup_a";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "SUPPLY_SITES_HIGH_TOWN_UNDERGROUND_TUNNEL", cf, ( -14870, 8544.27, 542.51 ), ( 0, 192.65, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_supply_sites_cs";
    s.groupid = "reinforcement_spawn_point_a";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.reinforcement_spawn = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "supply_site_backup_a";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "SUPPLY_SITES_HIGH_TOWN_UNDERGROUND_TUNNEL", cf, ( -16478.4, 8628.04, 542 ), ( 0, 2.65, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_supply_sites_cs";
    s.groupid = "reinforcement_spawn_point_b";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.reinforcement_spawn = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "supply_site_backup_b";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "SUPPLY_SITES_HIGH_TOWN_UNDERGROUND_TUNNEL", cf, ( -16370.8, 8432.38, 542 ), ( 0, 181.94, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_supply_sites_cs";
    s.groupid = "reinforcement_spawn_point_b";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.reinforcement_spawn = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "supply_site_backup_b";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "SUPPLY_SITES_HIGH_TOWN_UNDERGROUND_TUNNEL", cf, ( -18054.8, 8210.12, 536 ), ( 0, 38.84, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_supply_sites_cs";
    s.groupid = "reinforcement_spawn_point_b";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.reinforcement_spawn = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "supply_site_backup_b";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "SUPPLY_SITES_HIGH_TOWN_UNDERGROUND_TUNNEL", cf, ( -17816.1, 7906.89, 536 ), ( 0, 42.44, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_supply_sites_cs";
    s.groupid = "reinforcement_spawn_point_a";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.reinforcement_spawn = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "supply_site_backup_a";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "SUPPLY_SITES_HIGH_TOWN_UNDERGROUND_TUNNEL", cf, ( -14944.1, 8869.4, 541.42 ), ( 0, 192.65, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_supply_sites_cs";
    s.groupid = "reinforcement_spawn_point_a";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.reinforcement_spawn = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "supply_site_backup_a";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "SUPPLY_SITES_HIGH_TOWN_UNDERGROUND_TUNNEL", cf, ( -14920.3, 8707.7, 541.98 ), ( 0, 192.65, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_supply_sites_cs";
    s.groupid = "reinforcement_spawn_point_b";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.reinforcement_spawn = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "supply_site_backup_b";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "SUPPLY_SITES_HIGH_TOWN_UNDERGROUND_TUNNEL", cf, ( -16367.5, 8623.75, 542 ), ( 0, 186.94, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_supply_sites_cs";
    s.groupid = "reinforcement_spawn_point_b";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.reinforcement_spawn = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "supply_site_backup_b";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "SUPPLY_SITES_HIGH_TOWN_UNDERGROUND_TUNNEL", cf, ( -17930.3, 8032.26, 536 ), ( 0, 23.84, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_supply_sites_cs";
    s.groupid = "ai_spawn";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "advanced_guild_bot_charging_pad";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "SUPPLY_SITES_HIGH_TOWN_UNDERGROUND_TUNNEL", cf, ( -17271.8, 8296.58, 539.29 ), ( 0, 279.25, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_supply_sites_cs";
    s.groupid = "ai_spawn";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "dawg_charging_pad";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "SUPPLY_SITES_HIGH_TOWN_UNDERGROUND_TUNNEL", cf, ( -16912.2, 8719.56, 547.5 ), ( 0, 270.81, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_supply_sites_cs";
    s._size_max = ( 500, 1668, 194 );
    s._size_min = ( 1153.87, 3000, 484 );
    s.var_5afd49978f924648 = "1";
    s.var_a8568d8e0b0b6076 = "1";
    s.var_3f3960eb7318312d = "1";
    s.default_goal_radius = "-1";
    s.height = 128;
    s.length = "128";
    s.script_stealthgroup = "-1";
    s.script_string = "sat_ob_supply_sites_encounter_charging_pad";
    s.var_95e2cee7aca5aaae = "1";
    s.width = "128";
    fe [[ f ]]( s, "SUPPLY_SITES_HIGH_TOWN_UNDERGROUND_TUNNEL", cf, ( -16330.4, 8078.58, 735.57 ), ( 0, 276, 0 ), "SUPPLY_SITES_HIGH_TOWN_UNDERGROUND_TUNNEL_charging_pad", undefined, "noent_volume_ai_encounter_cs", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_supply_sites_cs";
    s.groupid = "ai_spawn";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "guild_bot_charging_pad";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "SUPPLY_SITES_HIGH_TOWN_UNDERGROUND_TUNNEL", cf, ( -16894.8, 8405.58, 542 ), ( 0, 0.76, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_supply_sites_cs";
    s.groupid = "ai_spawn";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "ss_scientist";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "SUPPLY_SITES_HIGH_TOWN_UNDERGROUND_TUNNEL", cf, ( -16389.9, 8086.37, 548.39 ), ( 0, 82.66, 0 ), "cspf_2_auto13183114791415917122", "cspf_2_auto11704500567778554789", "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_supply_sites_cs";
    s.groupid = "ai_spawn";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "advanced_guild_bot_charging_pad";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "SUPPLY_SITES_HIGH_TOWN_UNDERGROUND_TUNNEL", cf, ( -15651.9, 8454.24, 542.62 ), ( 0, 284.7, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_supply_sites_cs";
    s.groupid = "ai_spawn";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "guild_bot_charging_pad";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "SUPPLY_SITES_HIGH_TOWN_UNDERGROUND_TUNNEL", cf, ( -15917, 8783.65, 547.5 ), ( 0, 281.7, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_supply_sites_cs";
    s.groupid = "ai_spawn";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "ss_scientist";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "SUPPLY_SITES_HIGH_TOWN_UNDERGROUND_TUNNEL", cf, ( -16074.1, 8766.22, 547.5 ), ( 0, 190.54, 0 ), undefined, "cspf_2_auto9910402968494491533", "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_supply_sites_cs";
    s.groupid = "ai_spawn";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "ss_dawg";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "SUPPLY_SITES_HIGH_TOWN_UNDERGROUND_TUNNEL", cf, ( -16441.7, 8367.82, 542 ), ( 0, 19.34, 0 ), undefined, "cspf_2_auto16889381289849293877", "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_supply_sites_cs";
    s.groupid = "ai_spawn";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "ss_shock";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "SUPPLY_SITES_HIGH_TOWN_UNDERGROUND_TUNNEL", cf, ( -16519.2, 8448.25, 542 ), ( 0, 116.34, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_supply_sites_cs";
    s.groupid = "ai_spawn";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "dawg_charging_pad";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "SUPPLY_SITES_HIGH_TOWN_UNDERGROUND_TUNNEL", cf, ( -16826.1, 8072.51, 547.77 ), ( 0, 89.25, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_supply_sites_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_SITES_HIGH_TOWN_UNDERGROUND_TUNNEL", cf, ( -16118.9, 8744.44, 547.5 ), ( 0, 0, 0 ), "cspf_2_auto7317174688641960904", "cspf_2_auto9910402968494491533", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_supply_sites_cs";
    s.loop_route = "1";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.start_point = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_SITES_HIGH_TOWN_UNDERGROUND_TUNNEL", cf, ( -16126.6, 8770.47, 547.5 ), ( 0, 0, 0 ), "cspf_2_auto9910402968494491533", "cspf_2_auto5912953348116575722", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_supply_sites_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_SITES_HIGH_TOWN_UNDERGROUND_TUNNEL", cf, ( -16696.1, 8695.55, 547.5 ), ( 0, 0, 0 ), "cspf_2_auto3112373998667058122", "cspf_2_auto7317174688641960904", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_supply_sites_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_SITES_HIGH_TOWN_UNDERGROUND_TUNNEL", cf, ( -16708.2, 8729.38, 547.5 ), ( 0, 0, 0 ), "cspf_2_auto5912953348116575722", "cspf_2_auto3112373998667058122", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_supply_sites_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_SITES_HIGH_TOWN_UNDERGROUND_TUNNEL", cf, ( -16382.6, 8105.16, 548.38 ), ( 0, 0, 0 ), "cspf_2_auto14686697373736134893", "cspf_2_auto11734475183893158163", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_supply_sites_cs";
    s.loop_route = "1";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.start_point = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_SITES_HIGH_TOWN_UNDERGROUND_TUNNEL", cf, ( -16378.8, 8055.75, 548.38 ), ( 0, 0, 0 ), "cspf_2_auto11704500567778554789", "cspf_2_auto6130672358984564975", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_supply_sites_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_SITES_HIGH_TOWN_UNDERGROUND_TUNNEL", cf, ( -16618.2, 8054.06, 548.16 ), ( 0, 0, 0 ), "cspf_2_auto6130672358984564975", "cspf_2_auto2716567539758565325", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_supply_sites_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_SITES_HIGH_TOWN_UNDERGROUND_TUNNEL", cf, ( -16618.6, 8095.37, 548.16 ), ( 0, 0, 0 ), "cspf_2_auto2716567539758565325", "cspf_2_auto14686697373736134893", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_supply_sites_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_SITES_HIGH_TOWN_UNDERGROUND_TUNNEL", cf, ( -16175.3, 8078.63, 547.62 ), ( 0, 0, 0 ), "cspf_2_auto4182847731589925948", "cspf_2_auto11704500567778554789", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_supply_sites_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_SITES_HIGH_TOWN_UNDERGROUND_TUNNEL", cf, ( -16172.4, 8127.75, 547.61 ), ( 0, 0, 0 ), "cspf_2_auto11734475183893158163", "cspf_2_auto7408644939880549526", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_supply_sites_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_SITES_HIGH_TOWN_UNDERGROUND_TUNNEL", cf, ( -15958.8, 8121.38, 547.7 ), ( 0, 0, 0 ), "cspf_2_auto6332546527174102931", "cspf_2_auto4182847731589925948", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_supply_sites_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_SITES_HIGH_TOWN_UNDERGROUND_TUNNEL", cf, ( -15955.7, 8152.06, 547.73 ), ( 0, 0, 0 ), "cspf_2_auto7408644939880549526", "cspf_2_auto6332546527174102931", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_supply_sites_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_SITES_HIGH_TOWN_UNDERGROUND_TUNNEL", cf, ( -16304.4, 8432.52, 542 ), ( 0, 0, 0 ), "cspf_2_auto5769531214132422338", "cspf_2_auto16889381289849293877", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_supply_sites_cs";
    s.loop_route = "1";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.start_point = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_SITES_HIGH_TOWN_UNDERGROUND_TUNNEL", cf, ( -16305.8, 8368.45, 542 ), ( 0, 0, 0 ), "cspf_2_auto16889381289849293877", "cspf_2_auto356410406254371043", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_supply_sites_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_SITES_HIGH_TOWN_UNDERGROUND_TUNNEL", cf, ( -15867, 8476.03, 542.1 ), ( 0, 0, 0 ), "cspf_2_auto16738047592620801524", "cspf_2_auto5769531214132422338", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_supply_sites_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_SITES_HIGH_TOWN_UNDERGROUND_TUNNEL", cf, ( -15861.1, 8436.19, 542.13 ), ( 0, 0, 0 ), "cspf_2_auto356410406254371043", "cspf_2_auto16738047592620801524", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace mp_sat_avalon_city_ob_activity_supply_sites_cs
// Params 0, eflags: 0x4
// Checksum 0x4e9da632, Offset: 0x4a3b
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace mp_sat_avalon_city_ob_activity_supply_sites_cs
// Params 0
// Checksum 0xcdadce74, Offset: 0x4a45
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "mp_sat_avalon_city_ob_activity_supply_sites_cs" );
}

// Namespace mp_sat_avalon_city_ob_activity_supply_sites_cs
// Params 0
// Checksum 0x5e404f07, Offset: 0x4a5b
// Size: 0x66
function function_4cd78e661617f3()
{
    activityinfostruct = {};
    activityinfostruct.name = "REV_OB_DESTROY_SUPPLIES";
    activityinfostruct.scriptbundle = "sat_activitydefinition_destroy_supplies";
    activityinfostruct.mainfunction = &main;
    activityinfostruct.var_934f068483ae4ddb = &function_d4323822d7042e5a;
    activityinfostruct.metadatafunction = &function_d9dd7965c51c95d1;
    return activityinfostruct;
}

// Namespace mp_sat_avalon_city_ob_activity_supply_sites_cs
// Params 4
// Checksum 0x7b16ad33, Offset: 0x4aca
// Size: 0x71
function function_d4323822d7042e5a( var_4312b79c960726b6, fe, us, cf = "mp_sat_avalon_city_ob_activity_supply_sites_cs" )
{
    switch ( var_4312b79c960726b6 )
    {
        case #"hash_b44eb3c4cb3e2e1f":
            function_7aa5eca95c5ad1e7( fe, us, cf );
            break;
        case #"hash_acffea1f6b0da390":
            function_56ef8061d0fb8f48( fe, us, cf );
            break;
    }
}

// Namespace mp_sat_avalon_city_ob_activity_supply_sites_cs
// Params 3
// Checksum 0x2ae2894f, Offset: 0x4b43
// Size: 0x818
function function_7aa5eca95c5ad1e7( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_supply_sites_cs";
    s.name = "supply_site_struct";
    s.script_label = "_b";
    fe [[ f ]]( s, "SUPPLY_SITES_LOW_TOWN_GRAND_STAND", cf, ( -6810.94, -1560.99, 281.5 ), ( 0, 0, 0 ), "cspf_3_auto16340160686260259487", undefined, "bombsite", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_supply_sites_cs";
    s.name = "supply_site_struct";
    s.script_label = "_a";
    fe [[ f ]]( s, "SUPPLY_SITES_LOW_TOWN_GRAND_STAND", cf, ( -6810.99, -102.81, 280.5 ), ( 0, 0, 0 ), "cspf_3_auto16340160686260259487", undefined, "bombsite", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_supply_sites_cs";
    s.name = "Master_struct";
    s.script_parameters = "vtol_infil";
    fe [[ f ]]( s, "SUPPLY_SITES_LOW_TOWN_GRAND_STAND", cf, ( -6728.6, -1411.17, 727.67 ), ( 0, 0, 0 ), undefined, "cspf_3_auto16340160686260259487", "SUPPLY_SITES_LOW_TOWN_GRAND_STAND", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_supply_sites_cs";
    s.groupid = "reinforcement_spawn_point_b";
    s.ishelistruct = 1;
    s.script_accel = "350";
    fe [[ f ]]( s, "SUPPLY_SITES_LOW_TOWN_GRAND_STAND", cf, ( -7071.5, -125.48, 888.42 ), ( 0, 1.42, -0 ), "SUPPLY_SITES_LOW_TOWN_GRAND_STAND_B", "cspf_3_auto782228661794935373", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_supply_sites_cs";
    s.groupid = "reinforcement_spawn_point_b";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "SUPPLY_SITES_LOW_TOWN_GRAND_STAND", cf, ( 5404.39, 13719.6, 8016.98 ), ( 359.47, 300.15, 0.49 ), "cspf_3_auto9220701321852841133", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_supply_sites_cs";
    s.groupid = "reinforcement_spawn_point_b";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "SUPPLY_SITES_LOW_TOWN_GRAND_STAND", cf, ( -2908.28, 15568.2, 7297.24 ), ( 0, 166.72, 0 ), "cspf_3_auto1940020992070457794", "cspf_3_auto11199300065694080849", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_supply_sites_cs";
    s.groupid = "reinforcement_spawn_point_b";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "SUPPLY_SITES_LOW_TOWN_GRAND_STAND", cf, ( 4222.15, 15507.4, 7316.73 ), ( 0, 166.72, 0 ), undefined, "cspf_3_auto1940020992070457794", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150, 1 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_supply_sites_cs";
    s.groupid = "reinforcement_spawn_point_b";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "SUPPLY_SITES_LOW_TOWN_GRAND_STAND", cf, ( -3345.5, 433.99, 4133 ), ( 359.47, 300.15, 0.49 ), "cspf_3_auto782228661794935373", "cspf_3_auto9220701321852841133", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_supply_sites_cs";
    s.groupid = "reinforcement_spawn_point_b";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "SUPPLY_SITES_LOW_TOWN_GRAND_STAND", cf, ( -11349.3, 6672.01, 6239.24 ), ( 0, 232.34, 0 ), "cspf_3_auto11199300065694080849", "SUPPLY_SITES_LOW_TOWN_GRAND_STAND_B", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_supply_sites_cs";
    s.groupid = "reinforcement_spawn_point_a";
    s.ishelistruct = 1;
    s.script_accel = "350";
    fe [[ f ]]( s, "SUPPLY_SITES_LOW_TOWN_GRAND_STAND", cf, ( -6967.86, -2136.43, 887.92 ), ( 0, 247.66, -0 ), "SUPPLY_SITES_LOW_TOWN_GRAND_STAND_A", "cspf_3_auto1524406265229526637", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_supply_sites_cs";
    s.groupid = "reinforcement_spawn_point_a";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "SUPPLY_SITES_LOW_TOWN_GRAND_STAND", cf, ( -9209.9, -20593.4, 12329.5 ), ( 359.47, 170.92, 0.49 ), "cspf_3_auto12823595121126769375", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_supply_sites_cs";
    s.groupid = "reinforcement_spawn_point_a";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "SUPPLY_SITES_LOW_TOWN_GRAND_STAND", cf, ( 2556.09, -15286.3, 7296.75 ), ( 0, 37.49, 0 ), "cspf_3_auto6323477253654959753", "cspf_3_auto10919077907836932839", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_supply_sites_cs";
    s.groupid = "reinforcement_spawn_point_a";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "SUPPLY_SITES_LOW_TOWN_GRAND_STAND", cf, ( -2000.14, -20771.3, 7316.25 ), ( 0, 37.49, 0 ), undefined, "cspf_3_auto6323477253654959753", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150, 1 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_supply_sites_cs";
    s.groupid = "reinforcement_spawn_point_a";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "SUPPLY_SITES_LOW_TOWN_GRAND_STAND", cf, ( -9637.05, -11301.7, 5356 ), ( 359.47, 170.92, 0.49 ), "cspf_3_auto1524406265229526637", "cspf_3_auto12823595121126769375", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_supply_sites_cs";
    s.groupid = "reinforcement_spawn_point_a";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "SUPPLY_SITES_LOW_TOWN_GRAND_STAND", cf, ( 1003.15, -3121.52, 6238.75 ), ( 0, 103.12, 0 ), "cspf_3_auto10919077907836932839", "SUPPLY_SITES_LOW_TOWN_GRAND_STAND_A", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
}

// Namespace mp_sat_avalon_city_ob_activity_supply_sites_cs
// Params 3
// Checksum 0x45e6b7f3, Offset: 0x5363
// Size: 0x1c6
function function_56ef8061d0fb8f48( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_supply_sites_cs";
    s.name = "supply_site_struct";
    s.script_label = "_b";
    fe [[ f ]]( s, "SUPPLY_SITES_HIGH_TOWN_UNDERGROUND_TUNNEL", cf, ( -17304.7, 8365.11, 538.95 ), ( 0, 278.77, 0 ), "cspf_4_auto7739827356371561120", undefined, "bombsite", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_supply_sites_cs";
    s.name = "supply_site_struct";
    s.script_label = "_a";
    fe [[ f ]]( s, "SUPPLY_SITES_HIGH_TOWN_UNDERGROUND_TUNNEL", cf, ( -15693.2, 8516.57, 542.5 ), ( 0, 282.74, 0 ), "cspf_4_auto7739827356371561120", undefined, "bombsite", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_supply_sites_cs";
    s.name = "Master_struct";
    s.script_parameters = "indoor";
    fe [[ f ]]( s, "SUPPLY_SITES_HIGH_TOWN_UNDERGROUND_TUNNEL", cf, ( -16419.7, 8474.3, 764.64 ), ( 0, 0, 0 ), undefined, "cspf_4_auto7739827356371561120", "SUPPLY_SITES_HIGH_TOWN_UNDERGROUND_TUNNEL", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_sat_avalon_city_ob_activity_supply_sites_cs
// Params 0
// Checksum 0xb43664d6, Offset: 0x5531
// Size: 0x15f
function function_d9dd7965c51c95d1()
{
    activityinstances = [];
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_activitydefinition_destroy_supplies";
    var_881289d7987bc770.var_265c4f33e2a6daa7 = 1;
    var_881289d7987bc770.cf = "mp_sat_avalon_city_ob_activity_supply_sites_cs";
    var_881289d7987bc770.scriptstructorigin = ( -7013.9, -1485.52, 280 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [];
    var_881289d7987bc770.var_31ce4477e3543d24 = [];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [];
    var_881289d7987bc770.locationradius = [];
    activityinstances[ "SUPPLY_SITES_LOW_TOWN_GRAND_STAND" ] = var_881289d7987bc770;
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_activitydefinition_destroy_supplies";
    var_881289d7987bc770.var_265c4f33e2a6daa7 = 1;
    var_881289d7987bc770.cf = "mp_sat_avalon_city_ob_activity_supply_sites_cs";
    var_881289d7987bc770.scriptstructorigin = ( -16298.1, 8425.21, 542 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [];
    var_881289d7987bc770.var_31ce4477e3543d24 = [];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [];
    var_881289d7987bc770.locationradius = [];
    activityinstances[ "SUPPLY_SITES_HIGH_TOWN_UNDERGROUND_TUNNEL" ] = var_881289d7987bc770;
    return activityinstances;
}

