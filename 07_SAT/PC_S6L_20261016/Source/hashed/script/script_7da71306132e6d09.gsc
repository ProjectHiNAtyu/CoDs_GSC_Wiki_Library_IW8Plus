// script_7da71306132e6d09  (hash_7da71306132e6d09.gscc) (size: 42350 Bytes / 0xa56e / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xa6dde805 (2799560709)
// size ...... 42350 (0xa56e)
// includes .. 4   (offset: 0x8cc6)
// strings ... 123 (offset: 0x8ce6)
// dev strs .. 0   (offset: 0xa56e)
// exports ... 18  (offset: 0x867a)
// cseg ...... 0xf78 + 0x7702 (0x867a)
// imports ... 31  (offset: 0x894a)
// animtree1 . 0   (offset: 0xa56e)
// animtree2 . 0   (offset: 0xa56e)
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace mp_sat_avalon_q4_ob_activity_supply_drop_cs;

// Namespace mp_sat_avalon_q4_ob_activity_supply_drop_cs
// Params 0, eflags: 0x5
// Checksum 0xb886bcc0, Offset: 0xf96
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"mp_sat_avalon_q4_ob_activity_supply_drop_cs", #"activity_common", &function_b39ecd3d51489472, undefined );
}

// Namespace mp_sat_avalon_q4_ob_activity_supply_drop_cs
// Params 0, eflags: 0x4
// Checksum 0x1a8951f, Offset: 0xfbf
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace mp_sat_avalon_q4_ob_activity_supply_drop_cs
// Params 0, eflags: 0x4
// Checksum 0x849346f3, Offset: 0xfd0
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace mp_sat_avalon_q4_ob_activity_supply_drop_cs
// Params 2
// Checksum 0xee6ab68c, Offset: 0xfe1
// Size: 0x8c
function main( unused, unused2 )
{
    if ( utility::flag_exist( "mp_sat_avalon_q4_ob_activity_supply_drop_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "mp_sat_avalon_q4_ob_activity_supply_drop_cs" ) )
    {
        return;
    }
    
    activity_common::function_e1df676808c1d1e3( &function_4cd78e661617f3 );
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "mp_sat_avalon_q4_ob_activity_supply_drop_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "mp_sat_avalon_q4_ob_activity_supply_drop_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace mp_sat_avalon_q4_ob_activity_supply_drop_cs
// Params 3, eflags: 0x4
// Checksum 0x711f23c, Offset: 0x1075
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "mp_sat_avalon_q4_ob_activity_supply_drop_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "mp_sat_avalon_q4_ob_activity_supply_drop_cs" );
}

// Namespace mp_sat_avalon_q4_ob_activity_supply_drop_cs
// Params 3, eflags: 0x4
// Checksum 0xe715d05a, Offset: 0x10ef
// Size: 0x59a7
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_supply_drop_cs";
    s.activity_bundle = "sat_activitydefinition_supply_drop";
    s.name = "SUPPLY_DROP_Q4_MOUNTAIN_RANGE_MAIN_OFFICE";
    fe [[ f ]]( s, "SUPPLY_DROP_Q4_MOUNTAIN_RANGE_MAIN_OFFICE", cf, ( 3520.74, -44223.4, 251.17 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_supply_drop_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "supply_drop_long";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "SUPPLY_DROP_Q4_MOUNTAIN_RANGE_MAIN_OFFICE", cf, ( 3026.18, -44094.7, 251.17 ), ( 0, 86.83, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_supply_drop_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "supply_drop_long";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "SUPPLY_DROP_Q4_MOUNTAIN_RANGE_MAIN_OFFICE", cf, ( 4044.87, -44346.7, 251.84 ), ( 0, 346.1, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_supply_drop_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "supply_drop_rusher";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "SUPPLY_DROP_Q4_MOUNTAIN_RANGE_MAIN_OFFICE", cf, ( 3879.87, -43930.9, 251.17 ), ( 0, 261.41, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_supply_drop_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "supply_drop_rusher";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "SUPPLY_DROP_Q4_MOUNTAIN_RANGE_MAIN_OFFICE", cf, ( 3878.51, -44583.7, 251.17 ), ( 0, 20.56, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_supply_drop_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "supply_drop_long";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "SUPPLY_DROP_Q4_MOUNTAIN_RANGE_MAIN_OFFICE", cf, ( 3101.21, -44569.3, 251.16 ), ( 0, 264.03, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_supply_drop_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "supply_drop_rusher";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "SUPPLY_DROP_Q4_MOUNTAIN_RANGE_MAIN_OFFICE", cf, ( 3710.49, -44450.9, 251.17 ), ( 0, 29.97, 0 ), undefined, "cspf_1_auto14028896498581792746", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_supply_drop_cs";
    fe [[ f ]]( s, "SUPPLY_DROP_Q4_MOUNTAIN_RANGE_MAIN_OFFICE", cf, ( 3517.08, -44218.3, 251.17 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Ambient_AI_Exclusion_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 1600 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_supply_drop_cs";
    s.loop_route = "1";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.start_point = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_DROP_Q4_MOUNTAIN_RANGE_MAIN_OFFICE", cf, ( 3802.09, -44398.6, 251.17 ), ( 0, 0, 0 ), "cspf_1_auto14028896498581792746", "cspf_1_auto5189962303668421257", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_supply_drop_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_DROP_Q4_MOUNTAIN_RANGE_MAIN_OFFICE", cf, ( 4472.31, -44673.9, 251.17 ), ( 0, 0, 0 ), "cspf_1_auto5189962303668421257", "cspf_1_auto15367579940607790112", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_supply_drop_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_DROP_Q4_MOUNTAIN_RANGE_MAIN_OFFICE", cf, ( 4479.61, -44649.2, 251.17 ), ( 0, 0, 0 ), "cspf_1_auto15367579940607790112", "cspf_1_auto14884622363022541938", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_supply_drop_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_DROP_Q4_MOUNTAIN_RANGE_MAIN_OFFICE", cf, ( 3812.72, -44376.2, 251.17 ), ( 0, 0, 0 ), "cspf_1_auto14884622363022541938", "cspf_1_auto14028896498581792746", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_supply_drop_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_DROP_Q4_MOUNTAIN_RANGE_MAIN_OFFICE", cf, ( 3688.94, -43909.7, 251.17 ), ( 0, 0, 0 ), "cspf_1_auto5663156538907471189", "cspf_1_auto13865677886847293304", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_supply_drop_cs";
    s.loop_route = "1";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.start_point = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_DROP_Q4_MOUNTAIN_RANGE_MAIN_OFFICE", cf, ( 3656.47, -43963.4, 246.83 ), ( 0, 0, 0 ), "cspf_1_auto13865677886847293304", "cspf_1_auto6430902077516638303", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_supply_drop_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_DROP_Q4_MOUNTAIN_RANGE_MAIN_OFFICE", cf, ( 4304.22, -44209.9, 248.6 ), ( 0, 0, 0 ), "cspf_1_auto7707552898444609461", "cspf_1_auto5663156538907471189", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_supply_drop_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_DROP_Q4_MOUNTAIN_RANGE_MAIN_OFFICE", cf, ( 4279.22, -44256.1, 247.67 ), ( 0, 0, 0 ), "cspf_1_auto6430902077516638303", "cspf_1_auto7707552898444609461", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_supply_drop_cs";
    s.groupid = "reinforcement_spawn_point";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "supply_drop_heli";
    s.variantname = "ai_encounter_spawnpoint";
    s.var_4501e0172e168ddf = "SUPPLY_DROP_Q4_MOUNTAIN_RANGE_MAIN_OFFICE_VTOL";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "SUPPLY_DROP_Q4_MOUNTAIN_RANGE_MAIN_OFFICE", cf, ( 3739.24, -44326.1, 251.17 ), ( 0, 120.47, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_supply_drop_cs";
    s.activity_bundle = "sat_activitydefinition_supply_drop";
    s.name = "SUPPLY_DROP_Q4_FLATS_FIRE_STATION";
    fe [[ f ]]( s, "SUPPLY_DROP_Q4_FLATS_FIRE_STATION", cf, ( 39289.2, -28586.5, 278.5 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_supply_drop_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "supply_drop_long";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "SUPPLY_DROP_Q4_FLATS_FIRE_STATION", cf, ( 39105, -28866.8, 258.17 ), ( 0, 133.99, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_supply_drop_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "supply_drop_long";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "SUPPLY_DROP_Q4_FLATS_FIRE_STATION", cf, ( 39527.7, -28349.4, 258.18 ), ( 0, 212.01, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_supply_drop_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "supply_drop_rusher";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "SUPPLY_DROP_Q4_FLATS_FIRE_STATION", cf, ( 38924, -28086.7, 258.12 ), ( 0, 83.65, 0 ), undefined, "cspf_2_auto5889031371044806689", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_supply_drop_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "supply_drop_rusher";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "SUPPLY_DROP_Q4_FLATS_FIRE_STATION", cf, ( 39515.8, -28163.9, 258.18 ), ( 0, 96.08, 0 ), undefined, "cspf_2_auto13229895844989277126", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_supply_drop_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "supply_drop_long";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "SUPPLY_DROP_Q4_FLATS_FIRE_STATION", cf, ( 39322.6, -28889.8, 258.17 ), ( 0, 142.96, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_supply_drop_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "supply_drop_rusher";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "SUPPLY_DROP_Q4_FLATS_FIRE_STATION", cf, ( 38816.7, -28440.8, 258.17 ), ( 0, 315.54, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_supply_drop_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_DROP_Q4_FLATS_FIRE_STATION", cf, ( 38985.6, -27690.9, 258.18 ), ( 0, 0, 0 ), "cspf_2_auto12376944480608035533", "cspf_2_auto13121327398864838532", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_supply_drop_cs";
    s.loop_route = "1";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.start_point = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_DROP_Q4_FLATS_FIRE_STATION", cf, ( 38926.7, -27921.7, 258.17 ), ( 0, 0, 0 ), "cspf_2_auto5889031371044806689", "cspf_2_auto12376944480608035533", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_supply_drop_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_DROP_Q4_FLATS_FIRE_STATION", cf, ( 39129.2, -27420.8, 258.17 ), ( 0, 0, 0 ), "cspf_2_auto13121327398864838532", "cspf_2_auto14137360221188288378", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_supply_drop_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_DROP_Q4_FLATS_FIRE_STATION", cf, ( 39702.6, -26427.2, 261 ), ( 0, 0, 0 ), "cspf_2_auto14137360221188288378", "cspf_2_auto7120210046825256479", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_supply_drop_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_DROP_Q4_FLATS_FIRE_STATION", cf, ( 39745, -26445.3, 258.53 ), ( 0, 0, 0 ), "cspf_2_auto7120210046825256479", "cspf_2_auto9009715249202293786", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_supply_drop_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_DROP_Q4_FLATS_FIRE_STATION", cf, ( 39156.6, -27435.8, 258.19 ), ( 0, 0, 0 ), "cspf_2_auto9009715249202293786", "cspf_2_auto13295066613162535850", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_supply_drop_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_DROP_Q4_FLATS_FIRE_STATION", cf, ( 39032.9, -27716.7, 258.19 ), ( 0, 0, 0 ), "cspf_2_auto13295066613162535850", "cspf_2_auto5889031371044806689", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_supply_drop_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_DROP_Q4_FLATS_FIRE_STATION", cf, ( 39615.5, -27545.5, 258.18 ), ( 0, 92, 0 ), "cspf_2_auto4155947115343194021", "cspf_2_auto9126013324185651521", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_supply_drop_cs";
    s.loop_route = "1";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.start_point = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_DROP_Q4_FLATS_FIRE_STATION", cf, ( 39610.9, -28052.4, 258.07 ), ( 0, 92, 0 ), "cspf_2_auto13229895844989277126", "cspf_2_auto4155947115343194021", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_supply_drop_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_DROP_Q4_FLATS_FIRE_STATION", cf, ( 39581.4, -27542.5, 258.18 ), ( 0, 92, 0 ), "cspf_2_auto9126013324185651521", "cspf_2_auto14025672407412443752", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_supply_drop_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_DROP_Q4_FLATS_FIRE_STATION", cf, ( 39572.7, -28054, 258.05 ), ( 0, 92, 0 ), "cspf_2_auto14025672407412443752", "cspf_2_auto13229895844989277126", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_supply_drop_cs";
    fe [[ f ]]( s, "SUPPLY_DROP_Q4_FLATS_FIRE_STATION", cf, ( 39686.2, -28448.5, 278.5 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Ambient_AI_Exclusion_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 2000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_supply_drop_cs";
    s.groupid = "reinforcement_spawn_point";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "supply_drop_heli";
    s.variantname = "ai_encounter_spawnpoint";
    s.var_4501e0172e168ddf = "SUPPLY_DROP_Q4_FLATS_FIRE_STATION_VTOL";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "SUPPLY_DROP_Q4_FLATS_FIRE_STATION", cf, ( 39323.6, -28603, 258.17 ), ( 0, 58.71, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_supply_drop_cs";
    s.activity_bundle = "sat_activitydefinition_supply_drop";
    s.name = "SUPPLY_DROP_Q4_SHIP_YARD";
    fe [[ f ]]( s, "SUPPLY_DROP_Q4_SHIP_YARD", cf, ( 51038.3, -9172.17, 498.09 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_supply_drop_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_DROP_Q4_SHIP_YARD", cf, ( 50824.2, -8755.87, 602.17 ), ( 0, 0, 0 ), "cspf_3_auto12670122819246615073", "cspf_3_auto13937314890139312579", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_supply_drop_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "supply_drop_long";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "SUPPLY_DROP_Q4_SHIP_YARD", cf, ( 51402.9, -9313.87, 466.45 ), ( 0, 266.98, 0 ), undefined, "cspf_3_auto1404720470994631992", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_supply_drop_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "supply_drop_long";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "SUPPLY_DROP_Q4_SHIP_YARD", cf, ( 50739.5, -9549.94, 504.1 ), ( 0, 108.99, 0 ), undefined, "cspf_3_auto371084158238062083", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_supply_drop_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "supply_drop_rusher";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "SUPPLY_DROP_Q4_SHIP_YARD", cf, ( 50852.7, -8997.77, 564.06 ), ( 0, 303.56, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_supply_drop_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "supply_drop_rusher";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "SUPPLY_DROP_Q4_SHIP_YARD", cf, ( 51002.9, -9693.2, 463.62 ), ( 0, 237.39, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_supply_drop_cs";
    s.loop_route = "1";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.start_point = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_DROP_Q4_SHIP_YARD", cf, ( 50808, -8724, 604.5 ), ( 0, 0, 0 ), "cspf_3_auto13937314890139312579", "cspf_3_auto16761867415553111340", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_supply_drop_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "supply_drop_long";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "SUPPLY_DROP_Q4_SHIP_YARD", cf, ( 50750.6, -8801.3, 599.2 ), ( 0, 44.02, 0 ), undefined, "cspf_3_auto13937314890139312579", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_supply_drop_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "supply_drop_rusher";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "SUPPLY_DROP_Q4_SHIP_YARD", cf, ( 51495.9, -8874.53, 465.62 ), ( 0, 252.05, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_supply_drop_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_DROP_Q4_SHIP_YARD", cf, ( 51237.9, -8497.18, 598.71 ), ( 0, 0, 0 ), "cspf_3_auto8401302315055367760", "cspf_3_auto12670122819246615073", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_supply_drop_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_DROP_Q4_SHIP_YARD", cf, ( 51221.2, -8466.75, 603.6 ), ( 0, 0, 0 ), "cspf_3_auto16761867415553111340", "cspf_3_auto8401302315055367760", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_supply_drop_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_DROP_Q4_SHIP_YARD", cf, ( 50639.9, -9470.77, 533.74 ), ( 0, 0, 0 ), "cspf_3_auto1103302004151429935", "cspf_3_auto371084158238062083", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_supply_drop_cs";
    s.loop_route = "1";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.start_point = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_DROP_Q4_SHIP_YARD", cf, ( 50679.1, -9461.85, 529.87 ), ( 0, 0, 0 ), "cspf_3_auto371084158238062083", "cspf_3_auto11301522536295884617", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_supply_drop_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_DROP_Q4_SHIP_YARD", cf, ( 50573.7, -8991.42, 596.19 ), ( 0, 0, 0 ), "cspf_3_auto16906375733092500940", "cspf_3_auto1103302004151429935", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_supply_drop_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_DROP_Q4_SHIP_YARD", cf, ( 50622.6, -8979, 594.62 ), ( 0, 0, 0 ), "cspf_3_auto11301522536295884617", "cspf_3_auto16906375733092500940", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_supply_drop_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_DROP_Q4_SHIP_YARD", cf, ( 51442, -9406, 445.81 ), ( 0, 0, 0 ), "cspf_3_auto6649270556613716798", "cspf_3_auto1404720470994631992", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_supply_drop_cs";
    s.loop_route = "1";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.start_point = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_DROP_Q4_SHIP_YARD", cf, ( 51411, -9378, 450.5 ), ( 0, 0, 0 ), "cspf_3_auto1404720470994631992", "cspf_3_auto14426222806891335758", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_supply_drop_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_DROP_Q4_SHIP_YARD", cf, ( 51155.1, -9711.11, 440.2 ), ( 0, 0, 0 ), "cspf_3_auto12785348399038004727", "cspf_3_auto6649270556613716798", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_supply_drop_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_DROP_Q4_SHIP_YARD", cf, ( 51131.1, -9680.7, 443.23 ), ( 0, 0, 0 ), "cspf_3_auto14426222806891335758", "cspf_3_auto12785348399038004727", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_supply_drop_cs";
    fe [[ f ]]( s, "SUPPLY_DROP_Q4_SHIP_YARD", cf, ( 51069.6, -9185.51, 489.63 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Ambient_AI_Exclusion_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 1600 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_supply_drop_cs";
    s.groupid = "reinforcement_spawn_point";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "supply_drop_heli";
    s.variantname = "ai_encounter_spawnpoint";
    s.var_4501e0172e168ddf = "SUPPLY_DROP_Q4_SHIP_YARD_VTOL";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "SUPPLY_DROP_Q4_SHIP_YARD", cf, ( 50815.7, -9353.1, 522.68 ), ( 0, 4.61, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_supply_drop_cs";
    s.activity_bundle = "sat_activitydefinition_supply_drop";
    s.name = "SUPPLY_DROP_Q4_HELIPORT_POLICE_STATION";
    fe [[ f ]]( s, "SUPPLY_DROP_Q4_HELIPORT_POLICE_STATION", cf, ( 23379.5, -19408.1, 342.1 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_supply_drop_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "supply_drop_long";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "SUPPLY_DROP_Q4_HELIPORT_POLICE_STATION", cf, ( 23087.4, -19829.3, 348.9 ), ( 0, 309.69, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_supply_drop_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "supply_drop_long";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "SUPPLY_DROP_Q4_HELIPORT_POLICE_STATION", cf, ( 23457.8, -19621.3, 342.05 ), ( 0, 227.71, 0 ), undefined, "cspf_4_auto4178796105570428159", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_supply_drop_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "supply_drop_rusher";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "SUPPLY_DROP_Q4_HELIPORT_POLICE_STATION", cf, ( 23261.9, -19288.8, 347.41 ), ( 0, 36.85, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_supply_drop_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "supply_drop_rusher";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "SUPPLY_DROP_Q4_HELIPORT_POLICE_STATION", cf, ( 23123.3, -19671.2, 349.05 ), ( 0, 188.08, 0 ), undefined, "cspf_4_auto16111508195254316566", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_supply_drop_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "supply_drop_long";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "SUPPLY_DROP_Q4_HELIPORT_POLICE_STATION", cf, ( 23489.2, -19815, 345.36 ), ( 0, 105.18, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_supply_drop_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "supply_drop_rusher";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "SUPPLY_DROP_Q4_HELIPORT_POLICE_STATION", cf, ( 22948.8, -19820.4, 352 ), ( 0, 230.21, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_supply_drop_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_DROP_Q4_HELIPORT_POLICE_STATION", cf, ( 23402.1, -19668.8, 342.09 ), ( 0, 0, 0 ), "cspf_4_auto14480587800855579905", "cspf_4_auto4178796105570428159", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_supply_drop_cs";
    s.loop_route = "1";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.start_point = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_DROP_Q4_HELIPORT_POLICE_STATION", cf, ( 23435, -19678.1, 342.05 ), ( 0, 0, 0 ), "cspf_4_auto4178796105570428159", "cspf_4_auto5581263512426312616", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_supply_drop_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_DROP_Q4_HELIPORT_POLICE_STATION", cf, ( 23276, -20425.1, 359.52 ), ( 0, 0, 0 ), "cspf_4_auto9278147649948648667", "cspf_4_auto14480587800855579905", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_supply_drop_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_DROP_Q4_HELIPORT_POLICE_STATION", cf, ( 23311.5, -20435, 359.47 ), ( 0, 0, 0 ), "cspf_4_auto5581263512426312616", "cspf_4_auto9278147649948648667", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_supply_drop_cs";
    s.loop_route = "1";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.start_point = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_DROP_Q4_HELIPORT_POLICE_STATION", cf, ( 23078.4, -19636, 347.79 ), ( 0, 0, 0 ), "cspf_4_auto16111508195254316566", "cspf_4_auto14424466937713690269", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_supply_drop_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_DROP_Q4_HELIPORT_POLICE_STATION", cf, ( 23082.8, -19603.9, 347.79 ), ( 0, 0, 0 ), "cspf_4_auto7587659091825945611", "cspf_4_auto16111508195254316566", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_supply_drop_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_DROP_Q4_HELIPORT_POLICE_STATION", cf, ( 22643.3, -19591.7, 359.96 ), ( 0, 0, 0 ), "cspf_4_auto14424466937713690269", "cspf_4_auto552961550384389655", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_supply_drop_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_DROP_Q4_HELIPORT_POLICE_STATION", cf, ( 22647.7, -19559.6, 359.96 ), ( 0, 0, 0 ), "cspf_4_auto552961550384389655", "cspf_4_auto7587659091825945611", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_supply_drop_cs";
    fe [[ f ]]( s, "SUPPLY_DROP_Q4_HELIPORT_POLICE_STATION", cf, ( 23381, -19411.2, 342.14 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Ambient_AI_Exclusion_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 1600 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_supply_drop_cs";
    s.groupid = "reinforcement_spawn_point";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "supply_drop_heli";
    s.variantname = "ai_encounter_spawnpoint";
    s.var_4501e0172e168ddf = "SUPPLY_DROP_Q4_HELIPORT_POLICE_STATION_VTOL";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "SUPPLY_DROP_Q4_HELIPORT_POLICE_STATION", cf, ( 23267.4, -19493.8, 345.17 ), ( 0, 58.71, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_supply_drop_cs";
    s.activity_bundle = "sat_activitydefinition_supply_drop";
    s.name = "SUPPLY_DROP_Q4_CAMP_FIRESTATION";
    fe [[ f ]]( s, "SUPPLY_DROP_Q4_CAMP_FIRESTATION", cf, ( 37333.3, -38167.6, 1221 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_supply_drop_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "supply_drop_long";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "SUPPLY_DROP_Q4_CAMP_FIRESTATION", cf, ( 37856.8, -38369, 1221 ), ( 0, 62.32, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_supply_drop_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "supply_drop_long";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "SUPPLY_DROP_Q4_CAMP_FIRESTATION", cf, ( 36940, -38519.9, 1217.09 ), ( 0, 35.99, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_supply_drop_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "supply_drop_long";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "SUPPLY_DROP_Q4_CAMP_FIRESTATION", cf, ( 37389, -37760.1, 1221 ), ( 0, 174.28, 0 ), undefined, "cspf_5_auto188472274745549746", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_supply_drop_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "supply_drop_rusher";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "SUPPLY_DROP_Q4_CAMP_FIRESTATION", cf, ( 37666.1, -38304.5, 1221 ), ( 0, 236.12, 0 ), undefined, "cspf_5_auto2475095258511636162", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_supply_drop_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "supply_drop_rusher";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "SUPPLY_DROP_Q4_CAMP_FIRESTATION", cf, ( 36647.5, -38133.1, 1221 ), ( 0, 55.76, 0 ), undefined, "cspf_5_auto7278603446249324450", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_supply_drop_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "supply_drop_rusher";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "SUPPLY_DROP_Q4_CAMP_FIRESTATION", cf, ( 36821.9, -37883.5, 1221 ), ( 0, 320.41, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_supply_drop_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.reverse_route = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_DROP_Q4_CAMP_FIRESTATION", cf, ( 36708, -37267.1, 1221 ), ( 0, 0, 0 ), "cspf_5_auto2379717364282159233", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_supply_drop_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.reverse_route = "1";
    s.start_point = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_DROP_Q4_CAMP_FIRESTATION", cf, ( 36692, -38022, 1221 ), ( 0, 0, 0 ), "cspf_5_auto7278603446249324450", "cspf_5_auto16991507872921742594", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_supply_drop_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.reverse_route = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_DROP_Q4_CAMP_FIRESTATION", cf, ( 36699, -37745, 1221 ), ( 0, 0, 0 ), "cspf_5_auto16991507872921742594", "cspf_5_auto2379717364282159233", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_supply_drop_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.reverse_route = "1";
    s.start_point = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_DROP_Q4_CAMP_FIRESTATION", cf, ( 37568, -38368.9, 1221 ), ( 0, 0, 0 ), "cspf_5_auto2475095258511636162", "cspf_5_auto8388136105204239878", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_supply_drop_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.reverse_route = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_DROP_Q4_CAMP_FIRESTATION", cf, ( 37188.5, -38372.7, 1221 ), ( 0, 0, 0 ), "cspf_5_auto8388136105204239878", "cspf_5_auto5886237672724655002", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_supply_drop_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.reverse_route = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_DROP_Q4_CAMP_FIRESTATION", cf, ( 36879.1, -38373, 1221 ), ( 0, 0, 0 ), "cspf_5_auto5886237672724655002", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_supply_drop_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.reverse_route = "1";
    s.start_point = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_DROP_Q4_CAMP_FIRESTATION", cf, ( 37261, -37782, 1221 ), ( 0, 0, 0 ), "cspf_5_auto188472274745549746", "cspf_5_auto8678600331669036386", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_supply_drop_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.reverse_route = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_DROP_Q4_CAMP_FIRESTATION", cf, ( 37271, -37304, 1221 ), ( 0, 0, 0 ), "cspf_5_auto8678600331669036386", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_supply_drop_cs";
    s.groupid = "reinforcement_spawn_point";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "supply_drop_heli";
    s.variantname = "ai_encounter_spawnpoint";
    s.var_4501e0172e168ddf = "SUPPLY_DROP_Q4_CAMP_FIRESTATION_VTOL";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "SUPPLY_DROP_Q4_CAMP_FIRESTATION", cf, ( 37251.9, -38160.4, 1221 ), ( 0, 213.64, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_supply_drop_cs";
    fe [[ f ]]( s, "SUPPLY_DROP_Q4_CAMP_FIRESTATION", cf, ( 37435.4, -37890, 1221 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Ambient_AI_Exclusion_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 1500 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_supply_drop_cs";
    s.activity_bundle = "sat_activitydefinition_supply_drop";
    s.name = "SUPPLY_DROP_Q4_CAR_FACTORY_CAFETERIA";
    fe [[ f ]]( s, "SUPPLY_DROP_Q4_CAR_FACTORY_CAFETERIA", cf, ( 57600.5, -26775.2, 2417.99 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_supply_drop_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "supply_drop_long";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "SUPPLY_DROP_Q4_CAR_FACTORY_CAFETERIA", cf, ( 57719.6, -27196.7, 2425.74 ), ( 0, 147.22, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_supply_drop_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "supply_drop_long";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "SUPPLY_DROP_Q4_CAR_FACTORY_CAFETERIA", cf, ( 57406, -26471.7, 2426.22 ), ( 0, 120.59, 0 ), undefined, "cspf_6_auto15045675813358695032", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_supply_drop_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "supply_drop_long";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "SUPPLY_DROP_Q4_CAR_FACTORY_CAFETERIA", cf, ( 57155.3, -27210.9, 2427.99 ), ( 0, 15.48, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_supply_drop_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "supply_drop_rusher";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "SUPPLY_DROP_Q4_CAR_FACTORY_CAFETERIA", cf, ( 57007.5, -26473.4, 2429 ), ( 0, 290.52, 0 ), undefined, "cspf_6_auto3587854390284453012", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_supply_drop_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "supply_drop_rusher";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "SUPPLY_DROP_Q4_CAR_FACTORY_CAFETERIA", cf, ( 57621.3, -26932.2, 2429.66 ), ( 0, 178.16, 0 ), undefined, "cspf_6_auto9757395799349785564", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_supply_drop_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "supply_drop_rusher";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "SUPPLY_DROP_Q4_CAR_FACTORY_CAFETERIA", cf, ( 57382.6, -26740.9, 2424.07 ), ( 0, 351.81, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_supply_drop_cs";
    s.loop_route = "1";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.start_point = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_DROP_Q4_CAR_FACTORY_CAFETERIA", cf, ( 57009.5, -26555.6, 2429 ), ( 0, 0, 0 ), "cspf_6_auto3587854390284453012", "cspf_6_auto2826750557379246039", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_supply_drop_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_DROP_Q4_CAR_FACTORY_CAFETERIA", cf, ( 56831.8, -27231.9, 2429 ), ( 0, 0, 0 ), "cspf_6_auto2826750557379246039", "cspf_6_auto12726263463012919909", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_supply_drop_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_DROP_Q4_CAR_FACTORY_CAFETERIA", cf, ( 56896, -27250.5, 2429.36 ), ( 0, 0, 0 ), "cspf_6_auto12726263463012919909", "cspf_6_auto6737205748003978849", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_supply_drop_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_DROP_Q4_CAR_FACTORY_CAFETERIA", cf, ( 57123.1, -26407.8, 2429 ), ( 0, 0, 0 ), "cspf_6_auto6737205748003978849", "cspf_6_auto5111966332104208917", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_supply_drop_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_DROP_Q4_CAR_FACTORY_CAFETERIA", cf, ( 57058.6, -26390.1, 2429 ), ( 0, 0, 0 ), "cspf_6_auto5111966332104208917", "cspf_6_auto3587854390284453012", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_supply_drop_cs";
    s.loop_route = "1";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.start_point = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_DROP_Q4_CAR_FACTORY_CAFETERIA", cf, ( 57689.3, -26989.9, 2426.04 ), ( 0, 0, 0 ), "cspf_6_auto9757395799349785564", "cspf_6_auto16370029581655442562", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_supply_drop_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_DROP_Q4_CAR_FACTORY_CAFETERIA", cf, ( 57630.9, -26977.1, 2425.58 ), ( 0, 0, 0 ), "cspf_6_auto16345521688055374124", "cspf_6_auto9757395799349785564", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_supply_drop_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_DROP_Q4_CAR_FACTORY_CAFETERIA", cf, ( 57576.2, -27475.6, 2426.66 ), ( 0, 0, 0 ), "cspf_6_auto16370029581655442562", "cspf_6_auto15402890845043249155", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_supply_drop_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_DROP_Q4_CAR_FACTORY_CAFETERIA", cf, ( 57521.9, -27460.3, 2427.05 ), ( 0, 0, 0 ), "cspf_6_auto15402890845043249155", "cspf_6_auto16345521688055374124", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_supply_drop_cs";
    s.loop_route = "1";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.start_point = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_DROP_Q4_CAR_FACTORY_CAFETERIA", cf, ( 57404.9, -26401.8, 2426.4 ), ( 0, 0, 0 ), "cspf_6_auto15045675813358695032", "cspf_6_auto553291188820084486", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_supply_drop_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_DROP_Q4_CAR_FACTORY_CAFETERIA", cf, ( 56885.1, -26221.1, 2412.27 ), ( 0, 0, 0 ), "cspf_6_auto553291188820084486", "cspf_6_auto3883604733267783110", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_supply_drop_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_DROP_Q4_CAR_FACTORY_CAFETERIA", cf, ( 56910.9, -26148.7, 2412.19 ), ( 0, 0, 0 ), "cspf_6_auto3883604733267783110", "cspf_6_auto9035916016346920807", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_supply_drop_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_DROP_Q4_CAR_FACTORY_CAFETERIA", cf, ( 57425.8, -26335.5, 2425.81 ), ( 0, 0, 0 ), "cspf_6_auto9035916016346920807", "cspf_6_auto15045675813358695032", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_supply_drop_cs";
    fe [[ f ]]( s, "SUPPLY_DROP_Q4_CAR_FACTORY_CAFETERIA", cf, ( 57596.5, -26767.2, 2418.31 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Ambient_AI_Exclusion_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 1500 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_supply_drop_cs";
    s.groupid = "reinforcement_spawn_point";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "supply_drop_heli";
    s.variantname = "ai_encounter_spawnpoint";
    s.var_4501e0172e168ddf = "SUPPLY_DROP_Q4_CAR_FACTORY_CAFETERIA_VTOL";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "SUPPLY_DROP_Q4_CAR_FACTORY_CAFETERIA", cf, ( 57402.7, -27163, 2420.83 ), ( 0, 58.71, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace mp_sat_avalon_q4_ob_activity_supply_drop_cs
// Params 0, eflags: 0x4
// Checksum 0xf9ee02c1, Offset: 0x6a9e
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace mp_sat_avalon_q4_ob_activity_supply_drop_cs
// Params 0
// Checksum 0xc5422f71, Offset: 0x6aa8
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "mp_sat_avalon_q4_ob_activity_supply_drop_cs" );
}

// Namespace mp_sat_avalon_q4_ob_activity_supply_drop_cs
// Params 0
// Checksum 0x7a57af6e, Offset: 0x6abe
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

// Namespace mp_sat_avalon_q4_ob_activity_supply_drop_cs
// Params 4
// Checksum 0xfd4ab81d, Offset: 0x6b2d
// Size: 0xd9
function function_d4323822d7042e5a( var_4312b79c960726b6, fe, us, cf = "mp_sat_avalon_q4_ob_activity_supply_drop_cs" )
{
    switch ( var_4312b79c960726b6 )
    {
        case #"hash_1de7c18da38024cf":
            function_87fe8978784bf9f7( fe, us, cf );
            break;
        case #"hash_c77f7c2f7a32a839":
            function_90969adbdf354f1( fe, us, cf );
            break;
        case #"hash_f3b26df5510d56a":
            function_1e1f00cea642a2c2( fe, us, cf );
            break;
        case #"hash_219c5a8237ad49c8":
            function_dc250f2c3fb1ffc0( fe, us, cf );
            break;
        case #"hash_6ea800a23896f0d9":
            function_745736848ad833e1( fe, us, cf );
            break;
        case #"hash_79384640f172cb":
            function_52c85d782187b4d3( fe, us, cf );
            break;
    }
}

// Namespace mp_sat_avalon_q4_ob_activity_supply_drop_cs
// Params 3
// Checksum 0xc173375e, Offset: 0x6c0e
// Size: 0x3c6
function function_87fe8978784bf9f7( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_supply_drop_cs";
    s.name = "supply_drop_starter";
    fe [[ f ]]( s, "SUPPLY_DROP_Q4_MOUNTAIN_RANGE_MAIN_OFFICE", cf, ( 5585.79, -21265.5, 964.21 ), ( 0, 342.65, 0 ), undefined, "cspf_7_auto7816112992666981004", "SUPPLY_DROP_Q4_MOUNTAIN_RANGE_MAIN_OFFICE", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_supply_drop_cs";
    s.name = "supply_drop_point";
    fe [[ f ]]( s, "SUPPLY_DROP_Q4_MOUNTAIN_RANGE_MAIN_OFFICE", cf, ( 3521.98, -44221.7, 257.48 ), ( 0, 0, 0 ), "cspf_7_auto7816112992666981004", undefined, "east", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 600 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_supply_drop_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    s.script_accel = "350";
    fe [[ f ]]( s, "SUPPLY_DROP_Q4_MOUNTAIN_RANGE_MAIN_OFFICE", cf, ( 3605.46, -44389.8, 878.94 ), ( 0, 118.8, 0 ), "SUPPLY_DROP_Q4_MOUNTAIN_RANGE_MAIN_OFFICE_VTOL", "cspf_7_auto6972478287162756015", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_supply_drop_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "SUPPLY_DROP_Q4_MOUNTAIN_RANGE_MAIN_OFFICE", cf, ( 5299.58, -26418.3, 13623.5 ), ( 359.47, 53.23, 0.5 ), "cspf_7_auto17779768608460365586", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_supply_drop_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "SUPPLY_DROP_Q4_MOUNTAIN_RANGE_MAIN_OFFICE", cf, ( 16226.1, -52537.4, 7142.77 ), ( 0, 151.75, 0 ), undefined, "cspf_7_auto10177381876793932757", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150, 1 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_supply_drop_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "SUPPLY_DROP_Q4_MOUNTAIN_RANGE_MAIN_OFFICE", cf, ( 251.5, -38262.6, 7381.02 ), ( 359.47, 53.23, 0.5 ), "cspf_7_auto6972478287162756015", "cspf_7_auto17779768608460365586", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_supply_drop_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "SUPPLY_DROP_Q4_MOUNTAIN_RANGE_MAIN_OFFICE", cf, ( 11169.1, -49238.6, 6065.27 ), ( 0, 17.98, 0 ), "cspf_7_auto10177381876793932757", "SUPPLY_DROP_Q4_MOUNTAIN_RANGE_MAIN_OFFICE_VTOL", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
}

// Namespace mp_sat_avalon_q4_ob_activity_supply_drop_cs
// Params 3
// Checksum 0xdead1f92, Offset: 0x6fdc
// Size: 0x3c6
function function_90969adbdf354f1( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_supply_drop_cs";
    s.name = "supply_drop_starter";
    fe [[ f ]]( s, "SUPPLY_DROP_Q4_FLATS_FIRE_STATION", cf, ( 57824.1, -21728.4, 2453.53 ), ( 0, 79.44, 0 ), undefined, "cspf_8_auto3079351283742782929", "SUPPLY_DROP_Q4_FLATS_FIRE_STATION", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_supply_drop_cs";
    s.name = "supply_drop_point";
    fe [[ f ]]( s, "SUPPLY_DROP_Q4_FLATS_FIRE_STATION", cf, ( 39235.3, -28473.7, 278.5 ), ( 0, 0, 0 ), "cspf_8_auto3079351283742782929", undefined, "east", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 600 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_supply_drop_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    s.script_accel = "350";
    fe [[ f ]]( s, "SUPPLY_DROP_Q4_FLATS_FIRE_STATION", cf, ( 39242, -28544.2, 867.94 ), ( 0, 57.04, 0 ), "SUPPLY_DROP_Q4_FLATS_FIRE_STATION_VTOL", "cspf_8_auto944313994664060037", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_supply_drop_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "SUPPLY_DROP_Q4_FLATS_FIRE_STATION", cf, ( 56007, -21498.3, 13612.5 ), ( 359.47, 351.47, 0.5 ), "cspf_8_auto6307245555377699812", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_supply_drop_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "SUPPLY_DROP_Q4_FLATS_FIRE_STATION", cf, ( 38164.7, -43481.3, 7131.77 ), ( 0, 89.98, 0 ), undefined, "cspf_8_auto16190934809011521871", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150, 1 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_supply_drop_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "SUPPLY_DROP_Q4_FLATS_FIRE_STATION", cf, ( 43183.8, -22654.2, 7370.02 ), ( 359.47, 351.47, 0.5 ), "cspf_8_auto944313994664060037", "cspf_8_auto6307245555377699812", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_supply_drop_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "SUPPLY_DROP_Q4_FLATS_FIRE_STATION", cf, ( 38678.7, -37465.4, 6054.27 ), ( 0, 316.21, 0 ), "cspf_8_auto16190934809011521871", "SUPPLY_DROP_Q4_FLATS_FIRE_STATION_VTOL", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
}

// Namespace mp_sat_avalon_q4_ob_activity_supply_drop_cs
// Params 3
// Checksum 0x80ff517, Offset: 0x73aa
// Size: 0x3c6
function function_1e1f00cea642a2c2( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_supply_drop_cs";
    s.name = "supply_drop_starter";
    fe [[ f ]]( s, "SUPPLY_DROP_Q4_SHIP_YARD", cf, ( 49635.5, 7507.09, 1007.89 ), ( 0, 239.68, 0 ), undefined, "cspf_9_auto3551923933288835238", "SUPPLY_DROP_Q4_SHIP_YARD", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_supply_drop_cs";
    s.name = "supply_drop_point";
    fe [[ f ]]( s, "SUPPLY_DROP_Q4_SHIP_YARD", cf, ( 51079.7, -9160.66, 445.73 ), ( 0, 0, 0 ), "cspf_9_auto3551923933288835238", undefined, "east", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 600 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_supply_drop_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    s.script_accel = "350";
    fe [[ f ]]( s, "SUPPLY_DROP_Q4_SHIP_YARD", cf, ( 50908.2, -9237.9, 1147.44 ), ( 0, 329.91, 0 ), "SUPPLY_DROP_Q4_SHIP_YARD_VTOL", "cspf_9_auto14904177128120773274", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_supply_drop_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "SUPPLY_DROP_Q4_SHIP_YARD", cf, ( 58634, -25661.1, 13892 ), ( 359.47, 264.34, 0.49 ), "cspf_9_auto507941794704554105", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_supply_drop_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "SUPPLY_DROP_Q4_SHIP_YARD", cf, ( 35784.7, -8942.4, 7411.27 ), ( 0, 2.85, 0 ), undefined, "cspf_9_auto16131828428163790182", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150, 1 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_supply_drop_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "SUPPLY_DROP_Q4_SHIP_YARD", cf, ( 56837.1, -12911.8, 7649.52 ), ( 359.47, 264.34, 0.49 ), "cspf_9_auto14904177128120773274", "cspf_9_auto507941794704554105", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_supply_drop_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "SUPPLY_DROP_Q4_SHIP_YARD", cf, ( 41818.9, -9154.3, 6333.77 ), ( 0, 229.08, 0 ), "cspf_9_auto16131828428163790182", "SUPPLY_DROP_Q4_SHIP_YARD_VTOL", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
}

// Namespace mp_sat_avalon_q4_ob_activity_supply_drop_cs
// Params 3
// Checksum 0xa48842e9, Offset: 0x7778
// Size: 0x3c6
function function_dc250f2c3fb1ffc0( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_supply_drop_cs";
    s.name = "supply_drop_starter";
    fe [[ f ]]( s, "SUPPLY_DROP_Q4_HELIPORT_POLICE_STATION", cf, ( 16588.1, -40400.4, 1094.02 ), ( 0, 77.9, 0 ), undefined, "cspf_10_auto9167747691904354195", "SUPPLY_DROP_Q4_HELIPORT_POLICE_STATION", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_supply_drop_cs";
    s.name = "supply_drop_point";
    fe [[ f ]]( s, "SUPPLY_DROP_Q4_HELIPORT_POLICE_STATION", cf, ( 23321.1, -19421.3, 343.56 ), ( 0, 0, 0 ), "cspf_10_auto9167747691904354195", undefined, "east", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 600 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_supply_drop_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    s.script_accel = "350";
    fe [[ f ]]( s, "SUPPLY_DROP_Q4_HELIPORT_POLICE_STATION", cf, ( 23157.5, -19392.7, 954.94 ), ( 0, 57.04, 0 ), "SUPPLY_DROP_Q4_HELIPORT_POLICE_STATION_VTOL", "cspf_10_auto5261365883555308274", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_supply_drop_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "SUPPLY_DROP_Q4_HELIPORT_POLICE_STATION", cf, ( 39947, -12499.3, 13699.5 ), ( 359.47, 351.47, 0.5 ), "cspf_10_auto17806774955608444737", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_supply_drop_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "SUPPLY_DROP_Q4_HELIPORT_POLICE_STATION", cf, ( 22104.7, -34482.3, 7218.77 ), ( 0, 89.98, 0 ), undefined, "cspf_10_auto7637900331430113146", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150, 1 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_supply_drop_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "SUPPLY_DROP_Q4_HELIPORT_POLICE_STATION", cf, ( 27123.8, -13655.2, 7457.02 ), ( 359.47, 351.47, 0.5 ), "cspf_10_auto5261365883555308274", "cspf_10_auto17806774955608444737", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_supply_drop_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "SUPPLY_DROP_Q4_HELIPORT_POLICE_STATION", cf, ( 22618.7, -28466.4, 6141.27 ), ( 0, 316.21, 0 ), "cspf_10_auto7637900331430113146", "SUPPLY_DROP_Q4_HELIPORT_POLICE_STATION_VTOL", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
}

// Namespace mp_sat_avalon_q4_ob_activity_supply_drop_cs
// Params 3
// Checksum 0xa3f4e005, Offset: 0x7b46
// Size: 0x3c6
function function_745736848ad833e1( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_supply_drop_cs";
    s.name = "supply_drop_starter";
    fe [[ f ]]( s, "SUPPLY_DROP_Q4_CAMP_FIRESTATION", cf, ( 38717.8, -47205.8, 393.83 ), ( 0, 239.68, 0 ), undefined, "cspf_11_auto228680276187371416", "SUPPLY_DROP_Q4_CAMP_FIRESTATION", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_supply_drop_cs";
    s.name = "supply_drop_point";
    fe [[ f ]]( s, "SUPPLY_DROP_Q4_CAMP_FIRESTATION", cf, ( 37287, -38169.6, 1221 ), ( 0, 0, 0 ), "cspf_11_auto228680276187371416", undefined, "east", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 700 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_supply_drop_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    s.script_accel = "350";
    fe [[ f ]]( s, "SUPPLY_DROP_Q4_CAMP_FIRESTATION", cf, ( 37291.8, -38280.1, 1847.94 ), ( 0, 206.77, 0 ), "SUPPLY_DROP_Q4_CAMP_FIRESTATION_VTOL", "cspf_11_auto14340381128963415500", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_supply_drop_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "SUPPLY_DROP_Q4_CAMP_FIRESTATION", cf, ( 18933.7, -38333.8, 14482 ), ( 359.47, 146.4, 0.5 ), "cspf_11_auto2528355132685715210", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_supply_drop_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "SUPPLY_DROP_Q4_CAMP_FIRESTATION", cf, ( 46400.9, -30266.7, 8001.27 ), ( 0, 224.28, 0 ), undefined, "cspf_11_auto7788443558390803538", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150, 1 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_supply_drop_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "SUPPLY_DROP_Q4_CAMP_FIRESTATION", cf, ( 29946.4, -43403.6, 8239.52 ), ( 359.47, 146.4, 0.5 ), "cspf_11_auto14340381128963415500", "cspf_11_auto2528355132685715210", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_supply_drop_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "SUPPLY_DROP_Q4_CAMP_FIRESTATION", cf, ( 43902.8, -33467.6, 7629.27 ), ( 0, 111.14, 0 ), "cspf_11_auto7788443558390803538", "SUPPLY_DROP_Q4_CAMP_FIRESTATION_VTOL", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
}

// Namespace mp_sat_avalon_q4_ob_activity_supply_drop_cs
// Params 3
// Checksum 0xc6bbf7b0, Offset: 0x7f14
// Size: 0x3c6
function function_52c85d782187b4d3( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_supply_drop_cs";
    s.name = "supply_drop_starter";
    fe [[ f ]]( s, "SUPPLY_DROP_Q4_CAR_FACTORY_CAFETERIA", cf, ( 40644.4, -8005.25, 310.49 ), ( 0, 88.1, 0 ), undefined, "cspf_12_auto14243329167781931646", "SUPPLY_DROP_Q4_CAR_FACTORY_CAFETERIA", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_supply_drop_cs";
    s.name = "supply_drop_point";
    fe [[ f ]]( s, "SUPPLY_DROP_Q4_CAR_FACTORY_CAFETERIA", cf, ( 57570.2, -26731.9, 2420 ), ( 0, 0, 0 ), "cspf_12_auto14243329167781931646", undefined, "east", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 700 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_supply_drop_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    s.script_accel = "350";
    fe [[ f ]]( s, "SUPPLY_DROP_Q4_CAR_FACTORY_CAFETERIA", cf, ( 57298, -27070.2, 3039.94 ), ( 0, 57.04, 0 ), "SUPPLY_DROP_Q4_CAR_FACTORY_CAFETERIA_VTOL", "cspf_12_auto7645629526979657009", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_supply_drop_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "SUPPLY_DROP_Q4_CAR_FACTORY_CAFETERIA", cf, ( 74087.5, -20176.8, 15838 ), ( 359.47, 351.47, 0.5 ), "cspf_12_auto6246416932971676056", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_supply_drop_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "SUPPLY_DROP_Q4_CAR_FACTORY_CAFETERIA", cf, ( 56245.2, -42159.8, 9357.27 ), ( 0, 89.98, 0 ), undefined, "cspf_12_auto3444575322187146846", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150, 1 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_supply_drop_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "SUPPLY_DROP_Q4_CAR_FACTORY_CAFETERIA", cf, ( 61264.3, -21332.7, 9595.52 ), ( 359.47, 351.47, 0.5 ), "cspf_12_auto7645629526979657009", "cspf_12_auto6246416932971676056", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_supply_drop_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "SUPPLY_DROP_Q4_CAR_FACTORY_CAFETERIA", cf, ( 56759.2, -36143.9, 8279.77 ), ( 0, 316.21, 0 ), "cspf_12_auto3444575322187146846", "SUPPLY_DROP_Q4_CAR_FACTORY_CAFETERIA_VTOL", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
}

// Namespace mp_sat_avalon_q4_ob_activity_supply_drop_cs
// Params 0
// Checksum 0xecc6edae, Offset: 0x82e2
// Size: 0x397
function function_d9dd7965c51c95d1()
{
    activityinstances = [];
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_activitydefinition_supply_drop";
    var_881289d7987bc770.cf = "mp_sat_avalon_q4_ob_activity_supply_drop_cs";
    var_881289d7987bc770.scriptstructorigin = ( 3520.74, -44223.4, 251.17 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [];
    var_881289d7987bc770.var_31ce4477e3543d24 = [];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [];
    var_881289d7987bc770.locationradius = [];
    activityinstances[ "SUPPLY_DROP_Q4_MOUNTAIN_RANGE_MAIN_OFFICE" ] = var_881289d7987bc770;
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_activitydefinition_supply_drop";
    var_881289d7987bc770.cf = "mp_sat_avalon_q4_ob_activity_supply_drop_cs";
    var_881289d7987bc770.scriptstructorigin = ( 39289.2, -28586.5, 278.5 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [];
    var_881289d7987bc770.var_31ce4477e3543d24 = [];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [];
    var_881289d7987bc770.locationradius = [];
    activityinstances[ "SUPPLY_DROP_Q4_FLATS_FIRE_STATION" ] = var_881289d7987bc770;
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_activitydefinition_supply_drop";
    var_881289d7987bc770.cf = "mp_sat_avalon_q4_ob_activity_supply_drop_cs";
    var_881289d7987bc770.scriptstructorigin = ( 51038.3, -9172.17, 498.09 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [];
    var_881289d7987bc770.var_31ce4477e3543d24 = [];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [];
    var_881289d7987bc770.locationradius = [];
    activityinstances[ "SUPPLY_DROP_Q4_SHIP_YARD" ] = var_881289d7987bc770;
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_activitydefinition_supply_drop";
    var_881289d7987bc770.cf = "mp_sat_avalon_q4_ob_activity_supply_drop_cs";
    var_881289d7987bc770.scriptstructorigin = ( 23379.5, -19408.1, 342.1 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [];
    var_881289d7987bc770.var_31ce4477e3543d24 = [];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [];
    var_881289d7987bc770.locationradius = [];
    activityinstances[ "SUPPLY_DROP_Q4_HELIPORT_POLICE_STATION" ] = var_881289d7987bc770;
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_activitydefinition_supply_drop";
    var_881289d7987bc770.cf = "mp_sat_avalon_q4_ob_activity_supply_drop_cs";
    var_881289d7987bc770.scriptstructorigin = ( 37333.3, -38167.6, 1221 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [];
    var_881289d7987bc770.var_31ce4477e3543d24 = [];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [];
    var_881289d7987bc770.locationradius = [];
    activityinstances[ "SUPPLY_DROP_Q4_CAMP_FIRESTATION" ] = var_881289d7987bc770;
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_activitydefinition_supply_drop";
    var_881289d7987bc770.cf = "mp_sat_avalon_q4_ob_activity_supply_drop_cs";
    var_881289d7987bc770.scriptstructorigin = ( 57600.5, -26775.2, 2417.99 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [];
    var_881289d7987bc770.var_31ce4477e3543d24 = [];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [];
    var_881289d7987bc770.locationradius = [];
    activityinstances[ "SUPPLY_DROP_Q4_CAR_FACTORY_CAFETERIA" ] = var_881289d7987bc770;
    return activityinstances;
}

