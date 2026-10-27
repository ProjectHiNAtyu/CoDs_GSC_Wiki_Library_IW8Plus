// script_2163a6058e7be9e6  (hash_2163a6058e7be9e6.gscc) (size: 26180 Bytes / 0x6644 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xd1301f52 (3509591890)
// size ...... 26180 (0x6644)
// includes .. 4   (offset: 0x567c)
// strings ... 83  (offset: 0x569c)
// dev strs .. 0   (offset: 0x6644)
// exports ... 14  (offset: 0x5150)
// cseg ...... 0x8bf + 0x4891 (0x5150)
// imports ... 27  (offset: 0x5380)
// animtree1 . 0   (offset: 0x6644)
// animtree2 . 0   (offset: 0x6644)
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace mp_sat_avalon_q3_ob_activity_supply_sites_cs;

// Namespace mp_sat_avalon_q3_ob_activity_supply_sites_cs
// Params 0, eflags: 0x5
// Checksum 0x6618aabe, Offset: 0x8dd
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"mp_sat_avalon_q3_ob_activity_supply_sites_cs", #"activity_common", &function_b39ecd3d51489472, undefined );
}

// Namespace mp_sat_avalon_q3_ob_activity_supply_sites_cs
// Params 0, eflags: 0x4
// Checksum 0x8484af37, Offset: 0x906
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace mp_sat_avalon_q3_ob_activity_supply_sites_cs
// Params 0, eflags: 0x4
// Checksum 0x1bf7cdb, Offset: 0x917
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace mp_sat_avalon_q3_ob_activity_supply_sites_cs
// Params 2
// Checksum 0x8bf7d8c0, Offset: 0x928
// Size: 0x8c
function main( unused, unused2 )
{
    if ( utility::flag_exist( "mp_sat_avalon_q3_ob_activity_supply_sites_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "mp_sat_avalon_q3_ob_activity_supply_sites_cs" ) )
    {
        return;
    }
    
    activity_common::function_e1df676808c1d1e3( &function_4cd78e661617f3 );
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "mp_sat_avalon_q3_ob_activity_supply_sites_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "mp_sat_avalon_q3_ob_activity_supply_sites_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace mp_sat_avalon_q3_ob_activity_supply_sites_cs
// Params 3, eflags: 0x4
// Checksum 0x823dc814, Offset: 0x9bc
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "mp_sat_avalon_q3_ob_activity_supply_sites_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "mp_sat_avalon_q3_ob_activity_supply_sites_cs" );
}

// Namespace mp_sat_avalon_q3_ob_activity_supply_sites_cs
// Params 3, eflags: 0x4
// Checksum 0x8850d0c3, Offset: 0xa36
// Size: 0x346a
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_sites_cs";
    s.activity_bundle = "sat_activitydefinition_destroy_supplies";
    s.name = "SUPPLY_SITES_Q3_RADAR";
    s.var_265c4f33e2a6daa7 = "1";
    fe [[ f ]]( s, "SUPPLY_SITES_Q3_RADAR", cf, ( -13413.6, -44978.8, 521.97 ), ( 0, 300.81, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_sites_cs";
    s.groupid = "ai_spawn_point";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_parameters = "_a";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "guild_bot_charging_pad";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "SUPPLY_SITES_Q3_RADAR", cf, ( -13667.7, -45175.8, 521.18 ), ( 0, 29.5, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_sites_cs";
    fe [[ f ]]( s, "SUPPLY_SITES_Q3_RADAR", cf, ( -13402, -44945.6, 521.97 ), ( 0, 300.81, 0 ), "activity_nexus_spatial_zone", undefined, "Awareness_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 4000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_sites_cs";
    s.groupid = "ai_spawn_point";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_parameters = "_a";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "guild_bot_charging_pad";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "SUPPLY_SITES_Q3_RADAR", cf, ( -13518, -45087.2, 521.18 ), ( 0, 29.5, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_sites_cs";
    s.groupid = "ai_spawn_point";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_parameters = "_b";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "guild_bot_charging_pad";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "SUPPLY_SITES_Q3_RADAR", cf, ( -13434.6, -45226.9, 521.18 ), ( 0, 29.5, 0 ), "cspf_1_auto11425119445362156030", undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_sites_cs";
    s.groupid = "ai_spawn_point";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_parameters = "_b";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "guild_bot_charging_pad";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "SUPPLY_SITES_Q3_RADAR", cf, ( -13587.7, -45314.5, 521.18 ), ( 0, 29.5, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_sites_cs";
    s.groupid = "ai_spawn_point";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "ss_scientist";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "SUPPLY_SITES_Q3_RADAR", cf, ( -12962.2, -45316.8, 528 ), ( 0, 215.08, 0 ), undefined, "cspf_1_auto10303510121436989351", "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_sites_cs";
    s.groupid = "ai_spawn_point";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_parameters = "_b";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "advanced_guild_bot_charging_pad";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "SUPPLY_SITES_Q3_RADAR", cf, ( -13513.5, -45273.1, 529.18 ), ( 0, 29.5, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_sites_cs";
    s.groupid = "ai_spawn_point";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_parameters = "_a";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "advanced_guild_bot_charging_pad";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "SUPPLY_SITES_Q3_RADAR", cf, ( -13592.6, -45132, 529.18 ), ( 0, 29.5, 0 ), "cspf_1_auto11425119445362156030", undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_sites_cs";
    s.groupid = "ai_spawn_point";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "ss_scientist";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "SUPPLY_SITES_Q3_RADAR", cf, ( -13992.1, -45100.9, 679.5 ), ( 0, 300.58, 0 ), "cspf_1_auto11425119445362156030", "cspf_1_auto2485624362090482491", "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_sites_cs";
    s.groupid = "ai_spawn_point";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "ss_dawg";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "SUPPLY_SITES_Q3_RADAR", cf, ( -13364.8, -45081.4, 521.18 ), ( 0, 32.8, 0 ), "cspf_1_auto11425119445362156030", undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_sites_cs";
    s.groupid = "ai_spawn_point";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "ss_shock";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "SUPPLY_SITES_Q3_RADAR", cf, ( -13194.4, -44898.5, 528 ), ( 0, 210.57, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_sites_cs";
    fe [[ f ]]( s, "SUPPLY_SITES_Q3_RADAR", cf, ( -13412.5, -44986.5, 521.97 ), ( 0, 300.81, 0 ), "activity_nexus_spatial_zone", undefined, "Ambient_AI_Exclusion_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 1200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_sites_cs";
    s._size_max = ( 950.97, 1197.65, 441 );
    s._size_min = ( 593.35, 1000.43, 372.5 );
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
    fe [[ f ]]( s, "SUPPLY_SITES_Q3_RADAR", cf, ( -13522.2, -44850.1, 521.18 ), ( 0, 300.81, 0 ), "SUPPLY_SITES_Q3_RADAR", "cspf_1_auto11425119445362156030", "noent_volume_ai_encounter_cs", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_sites_cs";
    s.groupid = "ai_spawn_point";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "5";
    s.move_speed = "1";
    s.reverse_route = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_SITES_Q3_RADAR", cf, ( -13546.2, -45673.4, 528 ), ( 0, 208.16, 0 ), "cspf_1_auto2562041368370624205", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_sites_cs";
    s.groupid = "ai_spawn_point";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.reverse_route = "1";
    s.start_point = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_SITES_Q3_RADAR", cf, ( -13113.2, -45423.6, 528 ), ( 0, 208.16, 0 ), "cspf_1_auto10303510121436989351", "cspf_1_auto2562041368370624205", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_sites_cs";
    s.groupid = "ai_spawn_point";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.reverse_route = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_SITES_Q3_RADAR", cf, ( -13733.8, -45556.2, 685 ), ( 0, 301.71, 0 ), "cspf_1_auto4578035955962056019", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_sites_cs";
    s.groupid = "ai_spawn_point";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.reverse_route = "1";
    s.start_point = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_SITES_Q3_RADAR", cf, ( -13966.5, -45146, 684.5 ), ( 0, 28.21, 0 ), "cspf_1_auto2485624362090482491", "cspf_1_auto4578035955962056019", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_sites_cs";
    s.groupid = "reinforcement_spawn_point_a";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.reinforcement_spawn = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "ss_vtol_rein_a";
    s.variantname = "ai_encounter_spawnpoint";
    s.var_4501e0172e168ddf = "SUPPLY_SITES_Q3_RADAR_A";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "SUPPLY_SITES_Q3_RADAR", cf, ( -13407.2, -44164.5, 517 ), ( 0, 319.21, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_sites_cs";
    s.groupid = "reinforcement_spawn_point_b";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.reinforcement_spawn = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "ss_vtol_rein_b";
    s.variantname = "ai_encounter_spawnpoint";
    s.var_4501e0172e168ddf = "SUPPLY_SITES_Q3_RADAR_B";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "SUPPLY_SITES_Q3_RADAR", cf, ( -13977.7, -45376.9, 827.5 ), ( 0, 200.45, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_sites_cs";
    s._size_max = ( 950.97, 1197.65, 441 );
    s._size_min = ( 593.35, 1000.43, 372.5 );
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
    fe [[ f ]]( s, "SUPPLY_SITES_Q3_RADAR", cf, ( -13522.2, -44850.1, 521.18 ), ( 0, 300.81, 0 ), "SUPPLY_SITES_Q3_RADAR_charging_pad", "cspf_1_auto11425119445362156030", "noent_volume_ai_encounter_cs", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_sites_cs";
    s.activity_bundle = "sat_activitydefinition_destroy_supplies";
    s.name = "SUPPLY_SITES_Q3_FORT";
    s.var_265c4f33e2a6daa7 = "1";
    fe [[ f ]]( s, "SUPPLY_SITES_Q3_FORT", cf, ( -38471.8, -36113.2, 1027.37 ), ( 0, 269.89, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_sites_cs";
    s.groupid = "ai_spawn_point";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_parameters = "_b";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "dawg_charging_pad";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "SUPPLY_SITES_Q3_FORT", cf, ( -38591.1, -35909.2, 1009.73 ), ( 0, 179.46, 0 ), "cspf_2_auto11425119445362156030", undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_sites_cs";
    fe [[ f ]]( s, "SUPPLY_SITES_Q3_FORT", cf, ( -38444.8, -36090.7, 1027.37 ), ( 0, 269.89, 0 ), "activity_nexus_spatial_zone", undefined, "Awareness_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 4000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_sites_cs";
    s.groupid = "ai_spawn_point";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_parameters = "_a";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "guild_bot_charging_pad";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "SUPPLY_SITES_Q3_FORT", cf, ( -37971.3, -36027.8, 958.26 ), ( 0, 181.46, 0 ), "cspf_2_auto11425119445362156030", undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_sites_cs";
    s.groupid = "ai_spawn_point";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_parameters = "_b";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "guild_bot_charging_pad";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "SUPPLY_SITES_Q3_FORT", cf, ( -38811.7, -35576.9, 1019.88 ), ( 0, 269.32, 0 ), "cspf_2_auto11425119445362156030", undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_sites_cs";
    s.groupid = "ai_spawn_point";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_parameters = "_a";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "advanced_guild_bot_charging_pad";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "SUPPLY_SITES_Q3_FORT", cf, ( -38297, -35961.2, 961.41 ), ( 0, 357.75, 0 ), "cspf_2_auto11425119445362156030", undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_sites_cs";
    s.groupid = "ai_spawn_point";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "ss_scientist";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "SUPPLY_SITES_Q3_FORT", cf, ( -38559.9, -35818.2, 1009.58 ), ( 0, 189.96, 0 ), "cspf_2_auto11425119445362156030", "cspf_2_auto11183092968803177139", "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_sites_cs";
    s.groupid = "ai_spawn_point";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_parameters = "_a";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "dawg_charging_pad";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "SUPPLY_SITES_Q3_FORT", cf, ( -38146.6, -35963.8, 960.48 ), ( 0, 175.08, 0 ), "cspf_2_auto11425119445362156030", undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_sites_cs";
    s.groupid = "ai_spawn_point";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "ss_shock";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "SUPPLY_SITES_Q3_FORT", cf, ( -38954.5, -36316.3, 1026.66 ), ( 0, 130.46, 0 ), "cspf_2_auto11425119445362156030", undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_sites_cs";
    s.groupid = "ai_spawn_point";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "ss_scientist";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "SUPPLY_SITES_Q3_FORT", cf, ( -39142.9, -36048.2, 1029.56 ), ( 0, 3.94, 0 ), "cspf_2_auto11425119445362156030", "cspf_2_auto1351619051878245969", "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_sites_cs";
    s.groupid = "ai_spawn_point";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "ss_dawg";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "SUPPLY_SITES_Q3_FORT", cf, ( -38399.5, -36117.5, 977.04 ), ( 0, 181.08, 0 ), "cspf_2_auto11425119445362156030", undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_sites_cs";
    s.groupid = "ai_spawn_point";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_parameters = "_b";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "advanced_guild_bot_charging_pad";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "SUPPLY_SITES_Q3_FORT", cf, ( -39178.7, -35840.4, 1026.66 ), ( 0, 359.73, 0 ), "cspf_2_auto11425119445362156030", undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_sites_cs";
    fe [[ f ]]( s, "SUPPLY_SITES_Q3_FORT", cf, ( -38474.8, -36120.4, 1027.37 ), ( 0, 269.89, 0 ), "activity_nexus_spatial_zone", undefined, "Ambient_AI_Exclusion_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 1200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_sites_cs";
    s._size_max = ( 604, 824, 194 );
    s._size_min = ( 940.955, 1708, 414 );
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
    fe [[ f ]]( s, "SUPPLY_SITES_Q3_FORT", cf, ( -37964, -36240.7, 960.48 ), ( 0, 269.89, 0 ), "SUPPLY_SITES_Q3_FORT", "cspf_2_auto11425119445362156030", "noent_volume_ai_encounter_cs", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_sites_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "5";
    s.min_wait_time = "1";
    s.move_speed = "1";
    s.reverse_route = "1";
    s.start_point = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_SITES_Q3_FORT", cf, ( -39079.3, -35841, 1023.56 ), ( 0, 94.4, 0 ), "cspf_2_auto11183092968803177139", "cspf_2_auto3938313280324510115", "ai_encounter_patrol_point", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_sites_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "5";
    s.min_wait_time = "1";
    s.move_speed = "1";
    s.reverse_route = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_SITES_Q3_FORT", cf, ( -39079, -35624.5, 1026.03 ), ( 0, 94.4, 0 ), "cspf_2_auto3938313280324510115", "cspf_2_auto7706829558518356843", "ai_encounter_patrol_point", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_sites_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "5";
    s.min_wait_time = "1";
    s.move_speed = "1";
    s.reverse_route = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_SITES_Q3_FORT", cf, ( -38656.9, -35638.6, 1014.34 ), ( 0, 94.4, 0 ), "cspf_2_auto7706829558518356843", undefined, "ai_encounter_patrol_point", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_sites_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "5";
    s.min_wait_time = "1";
    s.move_speed = "1";
    s.reverse_route = "1";
    s.start_point = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_SITES_Q3_FORT", cf, ( -39027.4, -36050.5, 1025.32 ), ( 0, 221.47, 0 ), "cspf_2_auto1351619051878245969", "cspf_2_auto7128732292817030071", "ai_encounter_patrol_point", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_sites_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "5";
    s.min_wait_time = "1";
    s.move_speed = "1";
    s.reverse_route = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_SITES_Q3_FORT", cf, ( -38885.2, -36049, 1020.49 ), ( 0, 221.47, 0 ), "cspf_2_auto7128732292817030071", "cspf_2_auto12372826835403432600", "ai_encounter_patrol_point", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_sites_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "5";
    s.min_wait_time = "1";
    s.move_speed = "1";
    s.reverse_route = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_SITES_Q3_FORT", cf, ( -38638.4, -36044.4, 1010.29 ), ( 0, 221.47, 0 ), "cspf_2_auto12372826835403432600", undefined, "ai_encounter_patrol_point", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_sites_cs";
    s.groupid = "reinforcement_spawn_point";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.reinforcement_spawn = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "supply_site_backup_a";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "SUPPLY_SITES_Q3_FORT", cf, ( -38794, -36123.2, 1016.42 ), ( 0, 4.85, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_sites_cs";
    s.groupid = "reinforcement_spawn_point";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.reinforcement_spawn = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "supply_site_backup_a";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "SUPPLY_SITES_Q3_FORT", cf, ( -37393.9, -36067.4, 956.48 ), ( 0, 199.85, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_sites_cs";
    s.groupid = "reinforcement_spawn_point";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.reinforcement_spawn = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "supply_site_backup_a";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "SUPPLY_SITES_Q3_FORT", cf, ( -37284.7, -36139.7, 955.26 ), ( 0, 184.85, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_sites_cs";
    s.groupid = "reinforcement_spawn_point";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.reinforcement_spawn = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "supply_site_backup_b";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "SUPPLY_SITES_Q3_FORT", cf, ( -39101.6, -35429.9, 1019.76 ), ( 0, 269.08, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_sites_cs";
    s.groupid = "reinforcement_spawn_point";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.reinforcement_spawn = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "supply_site_backup_b";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "SUPPLY_SITES_Q3_FORT", cf, ( -39175.4, -36596.3, 1030.89 ), ( 0, 90.98, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_sites_cs";
    s.groupid = "reinforcement_spawn_point";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.reinforcement_spawn = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "supply_site_backup_b";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "SUPPLY_SITES_Q3_FORT", cf, ( -39217.1, -36720.2, 1030.57 ), ( 0, 79.58, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_sites_cs";
    s.groupid = "reinforcement_spawn_point";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.reinforcement_spawn = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "supply_site_backup_a";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "SUPPLY_SITES_Q3_FORT", cf, ( -37466.3, -36147, 957.54 ), ( 0, 194.85, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_sites_cs";
    s.groupid = "reinforcement_spawn_point";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.reinforcement_spawn = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "supply_site_backup_a";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "SUPPLY_SITES_Q3_FORT", cf, ( -38896.8, -36186.3, 1019.56 ), ( 0, 24.85, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_sites_cs";
    s.groupid = "reinforcement_spawn_point";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.reinforcement_spawn = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "supply_site_backup_b";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "SUPPLY_SITES_Q3_FORT", cf, ( -38274.7, -36084.3, 963.77 ), ( 0, 164.08, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_sites_cs";
    s.groupid = "reinforcement_spawn_point";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.reinforcement_spawn = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "supply_site_backup_b";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "SUPPLY_SITES_Q3_FORT", cf, ( -39564.4, -36134, 1020.67 ), ( 0, 15.98, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_sites_cs";
    s.groupid = "reinforcement_spawn_point_a";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.reinforcement_spawn = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "ss_vtol_rein_a";
    s.variantname = "ai_encounter_spawnpoint";
    s.var_4501e0172e168ddf = "SUPPLY_SITES_Q3_FORT_A";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "SUPPLY_SITES_Q3_FORT", cf, ( -37514.9, -36106.2, 960.5 ), ( 0, 79.34, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_sites_cs";
    s.groupid = "reinforcement_spawn_point_b";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.reinforcement_spawn = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "ss_vtol_rein_b";
    s.variantname = "ai_encounter_spawnpoint";
    s.var_4501e0172e168ddf = "SUPPLY_SITES_Q3_FORT_B";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "SUPPLY_SITES_Q3_FORT", cf, ( -39206.1, -36140.8, 1028 ), ( 0, 259.08, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_sites_cs";
    s._size_max = ( 604, 824, 194 );
    s._size_min = ( 940.955, 1708, 414 );
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
    fe [[ f ]]( s, "SUPPLY_SITES_Q3_FORT", cf, ( -37964, -36240.7, 960.48 ), ( 0, 269.89, 0 ), "SUPPLY_SITES_Q3_FORT_charging_pad", "cspf_2_auto11425119445362156030", "noent_volume_ai_encounter_cs", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace mp_sat_avalon_q3_ob_activity_supply_sites_cs
// Params 0, eflags: 0x4
// Checksum 0x9c736c8d, Offset: 0x3ea8
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace mp_sat_avalon_q3_ob_activity_supply_sites_cs
// Params 0
// Checksum 0x406e1559, Offset: 0x3eb2
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "mp_sat_avalon_q3_ob_activity_supply_sites_cs" );
}

// Namespace mp_sat_avalon_q3_ob_activity_supply_sites_cs
// Params 0
// Checksum 0xd383942a, Offset: 0x3ec8
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

// Namespace mp_sat_avalon_q3_ob_activity_supply_sites_cs
// Params 4
// Checksum 0x61207473, Offset: 0x3f37
// Size: 0x71
function function_d4323822d7042e5a( var_4312b79c960726b6, fe, us, cf = "mp_sat_avalon_q3_ob_activity_supply_sites_cs" )
{
    switch ( var_4312b79c960726b6 )
    {
        case #"hash_63303d0d9129b2bd":
            function_aace97edfbcac285( fe, us, cf );
            break;
        case #"hash_7f14b17712d1a27e":
            function_d7fceede9a3a8266( fe, us, cf );
            break;
    }
}

// Namespace mp_sat_avalon_q3_ob_activity_supply_sites_cs
// Params 3
// Checksum 0x16ab5bf5, Offset: 0x3fb0
// Size: 0x818
function function_aace97edfbcac285( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_sites_cs";
    s.name = "Master_struct";
    s.script_parameters = "vtol_infil";
    fe [[ f ]]( s, "SUPPLY_SITES_Q3_RADAR", cf, ( -13287.3, -45097.9, 830.83 ), ( 0, 300.81, 0 ), undefined, "cspf_3_auto8153501790644273524", "SUPPLY_SITES_Q3_RADAR", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_sites_cs";
    s.name = "supply_site_struct";
    s.script_label = "_a";
    fe [[ f ]]( s, "SUPPLY_SITES_Q3_RADAR", cf, ( -13933.6, -44857.4, 528 ), ( 0, 300, 0 ), "cspf_3_auto8153501790644273524", undefined, "bombsite", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_sites_cs";
    s.name = "supply_site_struct";
    s.script_label = "_b";
    fe [[ f ]]( s, "SUPPLY_SITES_Q3_RADAR", cf, ( -13195.8, -45400, 528 ), ( 0, 120, 0 ), "cspf_3_auto8153501790644273524", undefined, "bombsite", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_sites_cs";
    s.groupid = "reinforcement_spawn_point_a";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "SUPPLY_SITES_Q3_RADAR", cf, ( -18971.4, -36314.6, 6614 ), ( 0, 109.75, 0 ), "cspf_3_auto13267654821569209441", "cspf_3_auto6699908544940068553", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_sites_cs";
    s.groupid = "reinforcement_spawn_point_a";
    s.ishelistruct = 1;
    s.script_accel = "350";
    fe [[ f ]]( s, "SUPPLY_SITES_Q3_RADAR", cf, ( -13498.6, -44109, 1142.5 ), ( 0, 331.6, 0 ), "SUPPLY_SITES_Q3_RADAR_A", "cspf_3_auto7889547205081991126", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_sites_cs";
    s.groupid = "reinforcement_spawn_point_b";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "SUPPLY_SITES_Q3_RADAR", cf, ( -7328.28, -34812.2, 6924.5 ), ( 0, 142.12, 0 ), "cspf_3_auto5893748203824166342", "cspf_3_auto8671411176944308166", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_sites_cs";
    s.groupid = "reinforcement_spawn_point_b";
    s.ishelistruct = 1;
    s.script_accel = "350";
    fe [[ f ]]( s, "SUPPLY_SITES_Q3_RADAR", cf, ( -13932.6, -45364.5, 1453 ), ( 0, 212.84, 0 ), "SUPPLY_SITES_Q3_RADAR_B", "cspf_3_auto6442798647055032873", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_sites_cs";
    s.groupid = "reinforcement_spawn_point_a";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "SUPPLY_SITES_Q3_RADAR", cf, ( -8286.21, -39649.2, 7644 ), ( 0, 231.75, 0 ), "cspf_3_auto7889547205081991126", "cspf_3_auto8086277061411068156", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_sites_cs";
    s.groupid = "reinforcement_spawn_point_a";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "SUPPLY_SITES_Q3_RADAR", cf, ( -17267, -41429.9, 3245.5 ), ( 0, 241.74, 0 ), "cspf_3_auto6699908544940068553", "SUPPLY_SITES_Q3_RADAR_A", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_sites_cs";
    s.groupid = "reinforcement_spawn_point_a";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "SUPPLY_SITES_Q3_RADAR", cf, ( -17923.5, -29215.1, 8885 ), ( 13.05, 245.44, 0 ), undefined, "cspf_3_auto13267654821569209441", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150, 1 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_sites_cs";
    s.groupid = "reinforcement_spawn_point_a";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "SUPPLY_SITES_Q3_RADAR", cf, ( -4220.95, -27181.7, 10208 ), ( 0, 231.75, 0 ), "cspf_3_auto8086277061411068156", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_sites_cs";
    s.groupid = "reinforcement_spawn_point_b";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "SUPPLY_SITES_Q3_RADAR", cf, ( -18201.7, -46624.7, 6651.5 ), ( 0, 112.98, 0 ), "cspf_3_auto6442798647055032873", "cspf_3_auto7802666184214533379", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_sites_cs";
    s.groupid = "reinforcement_spawn_point_b";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "SUPPLY_SITES_Q3_RADAR", cf, ( -9770.76, -43350.2, 3556 ), ( 0, 122.98, 0 ), "cspf_3_auto8671411176944308166", "SUPPLY_SITES_Q3_RADAR_B", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_sites_cs";
    s.groupid = "reinforcement_spawn_point_b";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "SUPPLY_SITES_Q3_RADAR", cf, ( -15182.5, -29923.7, 9195.5 ), ( 0, 344.49, 0 ), undefined, "cspf_3_auto5893748203824166342", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150, 1 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_sites_cs";
    s.groupid = "reinforcement_spawn_point_b";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "SUPPLY_SITES_Q3_RADAR", cf, ( -23658.5, -29509, 10518.5 ), ( 0, 112.98, 0 ), "cspf_3_auto7802666184214533379", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 200 );
}

// Namespace mp_sat_avalon_q3_ob_activity_supply_sites_cs
// Params 3
// Checksum 0x8c1e02a5, Offset: 0x47d0
// Size: 0x818
function function_d7fceede9a3a8266( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_sites_cs";
    s.groupid = "reinforcement_spawn_point_a";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "SUPPLY_SITES_Q3_FORT", cf, ( -31895.9, -47320.3, 7057.5 ), ( 0, 21.01, 0 ), "cspf_4_auto5178724373942888017", "cspf_4_auto18054160376412082048", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_sites_cs";
    s.name = "Master_struct";
    s.script_parameters = "vtol_infil";
    fe [[ f ]]( s, "SUPPLY_SITES_Q3_FORT", cf, ( -38879.6, -35962.8, 1336.22 ), ( 0, 269.89, 0 ), undefined, "cspf_4_auto8153501790644273524", "SUPPLY_SITES_Q3_FORT", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_sites_cs";
    s.groupid = "reinforcement_spawn_point_a";
    s.ishelistruct = 1;
    s.script_accel = "350";
    fe [[ f ]]( s, "SUPPLY_SITES_Q3_FORT", cf, ( -37517, -36213, 1586 ), ( 0, 91.73, 0 ), "SUPPLY_SITES_Q3_FORT_A", "cspf_4_auto16719670558164836091", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_sites_cs";
    s.name = "supply_site_struct";
    s.script_label = "_a";
    fe [[ f ]]( s, "SUPPLY_SITES_Q3_FORT", cf, ( -38191.2, -36256.2, 962.16 ), ( 0, 269.79, 0 ), "cspf_4_auto8153501790644273524", undefined, "bombsite", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_sites_cs";
    s.name = "supply_site_struct";
    s.script_label = "_b";
    fe [[ f ]]( s, "SUPPLY_SITES_Q3_FORT", cf, ( -38960.5, -35959.5, 1025.62 ), ( 0, 90, 0 ), "cspf_4_auto8153501790644273524", undefined, "bombsite", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_sites_cs";
    s.groupid = "reinforcement_spawn_point_b";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "SUPPLY_SITES_Q3_FORT", cf, ( -44774.2, -24901.4, 7125 ), ( 0, 200.75, 0 ), "cspf_4_auto5893748203824166342", "cspf_4_auto8671411176944308166", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_sites_cs";
    s.groupid = "reinforcement_spawn_point_b";
    s.ishelistruct = 1;
    s.script_accel = "350";
    fe [[ f ]]( s, "SUPPLY_SITES_Q3_FORT", cf, ( -39203.5, -36034, 1653.5 ), ( 0, 271.47, 0 ), "SUPPLY_SITES_Q3_FORT_B", "cspf_4_auto6442798647055032873", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_sites_cs";
    s.groupid = "reinforcement_spawn_point_a";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "SUPPLY_SITES_Q3_FORT", cf, ( -34772.8, -31470.6, 6784.5 ), ( 0, 351.88, 0 ), "cspf_4_auto16719670558164836091", "cspf_4_auto4558613134952590506", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_sites_cs";
    s.groupid = "reinforcement_spawn_point_a";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "SUPPLY_SITES_Q3_FORT", cf, ( -37943.2, -40817.1, 3689 ), ( 0, 1.87, 0 ), "cspf_4_auto18054160376412082048", "SUPPLY_SITES_Q3_FORT_A", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_sites_cs";
    s.groupid = "reinforcement_spawn_point_a";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "SUPPLY_SITES_Q3_FORT", cf, ( -23651.8, -43122.3, 9328.5 ), ( 0, 223.38, 0 ), undefined, "cspf_4_auto5178724373942888017", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150, 1 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_sites_cs";
    s.groupid = "reinforcement_spawn_point_a";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "SUPPLY_SITES_Q3_FORT", cf, ( -27210.6, -22495.8, 10651.5 ), ( 0, 351.88, 0 ), "cspf_4_auto4558613134952590506", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_sites_cs";
    s.groupid = "reinforcement_spawn_point_b";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "SUPPLY_SITES_Q3_FORT", cf, ( -40350.2, -40334.9, 6852 ), ( 0, 171.62, 0 ), "cspf_4_auto6442798647055032873", "cspf_4_auto7802666184214533379", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_sites_cs";
    s.groupid = "reinforcement_spawn_point_b";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "SUPPLY_SITES_Q3_FORT", cf, ( -38756.4, -31431.9, 3756.5 ), ( 0, 181.61, 0 ), "cspf_4_auto8671411176944308166", "SUPPLY_SITES_Q3_FORT_B", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_sites_cs";
    s.groupid = "reinforcement_spawn_point_b";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "SUPPLY_SITES_Q3_FORT", cf, ( -53037.2, -29061.9, 9396 ), ( 0, 43.12, 0 ), undefined, "cspf_4_auto5893748203824166342", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150, 1 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_supply_sites_cs";
    s.groupid = "reinforcement_spawn_point_b";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "SUPPLY_SITES_Q3_FORT", cf, ( -35093.5, -55322.3, 10719 ), ( 0, 171.62, 0 ), "cspf_4_auto7802666184214533379", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 200 );
}

// Namespace mp_sat_avalon_q3_ob_activity_supply_sites_cs
// Params 0
// Checksum 0xabb35b0a, Offset: 0x4ff0
// Size: 0x15f
function function_d9dd7965c51c95d1()
{
    activityinstances = [];
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_activitydefinition_destroy_supplies";
    var_881289d7987bc770.var_265c4f33e2a6daa7 = 1;
    var_881289d7987bc770.cf = "mp_sat_avalon_q3_ob_activity_supply_sites_cs";
    var_881289d7987bc770.scriptstructorigin = ( -13413.6, -44978.8, 521.97 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [];
    var_881289d7987bc770.var_31ce4477e3543d24 = [];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [];
    var_881289d7987bc770.locationradius = [];
    activityinstances[ "SUPPLY_SITES_Q3_RADAR" ] = var_881289d7987bc770;
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_activitydefinition_destroy_supplies";
    var_881289d7987bc770.var_265c4f33e2a6daa7 = 1;
    var_881289d7987bc770.cf = "mp_sat_avalon_q3_ob_activity_supply_sites_cs";
    var_881289d7987bc770.scriptstructorigin = ( -38471.8, -36113.2, 1027.37 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [];
    var_881289d7987bc770.var_31ce4477e3543d24 = [];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [];
    var_881289d7987bc770.locationradius = [];
    activityinstances[ "SUPPLY_SITES_Q3_FORT" ] = var_881289d7987bc770;
    return activityinstances;
}

