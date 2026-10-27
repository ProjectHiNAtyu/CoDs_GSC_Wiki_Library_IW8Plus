// script_237c4919b1a1dd06  (hash_237c4919b1a1dd06.gscc) (size: 23161 Bytes / 0x5a79 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x88366544 (2285266244)
// size ...... 23161 (0x5a79)
// includes .. 4   (offset: 0x4e19)
// strings ... 63  (offset: 0x4e39)
// dev strs .. 0   (offset: 0x5a79)
// exports ... 16  (offset: 0x485d)
// cseg ...... 0x7c1 + 0x409c (0x485d)
// imports ... 29  (offset: 0x4add)
// animtree1 . 0   (offset: 0x5a79)
// animtree2 . 0   (offset: 0x5a79)
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace mp_sat_avalon_q4_ob_activity_merc_stronghold_cs;

// Namespace mp_sat_avalon_q4_ob_activity_merc_stronghold_cs
// Params 0, eflags: 0x5
// Checksum 0x1d32a3d5, Offset: 0x7df
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"mp_sat_avalon_q4_ob_activity_merc_stronghold_cs", #"activity_common", &function_b39ecd3d51489472, undefined );
}

// Namespace mp_sat_avalon_q4_ob_activity_merc_stronghold_cs
// Params 0, eflags: 0x4
// Checksum 0xb51bee0d, Offset: 0x808
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace mp_sat_avalon_q4_ob_activity_merc_stronghold_cs
// Params 0, eflags: 0x4
// Checksum 0x30203de1, Offset: 0x819
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace mp_sat_avalon_q4_ob_activity_merc_stronghold_cs
// Params 2
// Checksum 0x6adee78f, Offset: 0x82a
// Size: 0x8c
function main( unused, unused2 )
{
    if ( utility::flag_exist( "mp_sat_avalon_q4_ob_activity_merc_stronghold_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "mp_sat_avalon_q4_ob_activity_merc_stronghold_cs" ) )
    {
        return;
    }
    
    activity_common::function_e1df676808c1d1e3( &function_4cd78e661617f3 );
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "mp_sat_avalon_q4_ob_activity_merc_stronghold_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "mp_sat_avalon_q4_ob_activity_merc_stronghold_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace mp_sat_avalon_q4_ob_activity_merc_stronghold_cs
// Params 3, eflags: 0x4
// Checksum 0xb3a2892e, Offset: 0x8be
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "mp_sat_avalon_q4_ob_activity_merc_stronghold_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "mp_sat_avalon_q4_ob_activity_merc_stronghold_cs" );
}

// Namespace mp_sat_avalon_q4_ob_activity_merc_stronghold_cs
// Params 3, eflags: 0x4
// Checksum 0x72edbd28, Offset: 0x938
// Size: 0x19ac
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_stronghold_cs";
    s.activity_bundle = "sat_activitydefinition_merc_stronghold";
    s.name = "MERC_STRONGHOLD_Q4_MOUNTAIN_RANGE";
    fe [[ f ]]( s, "MERC_STRONGHOLD_Q4_MOUNTAIN_RANGE", cf, ( 12040.7, -29383.2, 4595.53 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_stronghold_cs";
    fe [[ f ]]( s, "MERC_STRONGHOLD_Q4_MOUNTAIN_RANGE", cf, ( 12030.2, -29491.2, 4277.28 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Awareness_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 3600 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_stronghold_cs";
    fe [[ f ]]( s, "MERC_STRONGHOLD_Q4_MOUNTAIN_RANGE", cf, ( 12025.7, -29391.3, 4099.28 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Ambient_AI_Exclusion_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 1100 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_stronghold_cs";
    fe [[ f ]]( s, "MERC_STRONGHOLD_Q4_MOUNTAIN_RANGE", cf, ( 12022, -29471.9, 4277.28 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Proximity_Join_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 1250 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_stronghold_cs";
    s.groupid = "reinforcement_spawn_point";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "sh_reinforce_heli";
    s.variantname = "ai_encounter_spawnpoint";
    s.var_4501e0172e168ddf = "MERC_STRONGHOLD_Q4_MOUNTAIN_RANGE_VTOL";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "MERC_STRONGHOLD_Q4_MOUNTAIN_RANGE", cf, ( 12272.6, -28702.2, 4050.94 ), ( 0, 233.5, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_stronghold_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "parachute_reinforce";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "MERC_STRONGHOLD_Q4_MOUNTAIN_RANGE", cf, ( 12075.1, -28855, 4051.39 ), ( 0, 290.77, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_stronghold_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "parachute_reinforce";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "MERC_STRONGHOLD_Q4_MOUNTAIN_RANGE", cf, ( 12207.6, -28824.2, 4050.94 ), ( 0, 239.09, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_stronghold_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "parachute_reinforce";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "MERC_STRONGHOLD_Q4_MOUNTAIN_RANGE", cf, ( 12019.7, -28753.5, 4052.32 ), ( 0, 251.4, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_stronghold_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "parachute_reinforce";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "MERC_STRONGHOLD_Q4_MOUNTAIN_RANGE", cf, ( 12166.7, -28728.8, 4050.94 ), ( 0, 249.7, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_stronghold_cs";
    s.activity_bundle = "sat_activitydefinition_merc_stronghold";
    s.name = "MERC_STRONGHOLD_Q4_CAR_FACTORY";
    fe [[ f ]]( s, "MERC_STRONGHOLD_Q4_CAR_FACTORY", cf, ( 54876.9, -37029.5, 2431.02 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_stronghold_cs";
    fe [[ f ]]( s, "MERC_STRONGHOLD_Q4_CAR_FACTORY", cf, ( 54693.8, -36840.5, 1991.22 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Awareness_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 3600 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_stronghold_cs";
    fe [[ f ]]( s, "MERC_STRONGHOLD_Q4_CAR_FACTORY", cf, ( 54748.1, -36828.4, 1991 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Ambient_AI_Exclusion_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 1100 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_stronghold_cs";
    fe [[ f ]]( s, "MERC_STRONGHOLD_Q4_CAR_FACTORY", cf, ( 54703.3, -36831.4, 2020.84 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Proximity_Join_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 1200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_stronghold_cs";
    s.groupid = "reinforcement_spawn_point";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "sh_reinforce_heli";
    s.variantname = "ai_encounter_spawnpoint";
    s.var_4501e0172e168ddf = "MERC_STRONGHOLD_Q4_CAR_FACTORY_VTOL";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "MERC_STRONGHOLD_Q4_CAR_FACTORY", cf, ( 54256.1, -36363.4, 1991 ), ( 0, 317.85, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_stronghold_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "parachute_reinforce";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "MERC_STRONGHOLD_Q4_CAR_FACTORY", cf, ( 53838, -35919.7, 1991 ), ( 0, 345.87, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_stronghold_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "parachute_reinforce";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "MERC_STRONGHOLD_Q4_CAR_FACTORY", cf, ( 53776.4, -35987.5, 1991 ), ( 0, 321.55, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_stronghold_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "parachute_reinforce";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "MERC_STRONGHOLD_Q4_CAR_FACTORY", cf, ( 53699.8, -35949.5, 1991 ), ( 0, 2.78, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_stronghold_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "parachute_reinforce";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "MERC_STRONGHOLD_Q4_CAR_FACTORY", cf, ( 53800.3, -35827.8, 1991 ), ( 0, 315.55, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_stronghold_cs";
    s.activity_bundle = "sat_activitydefinition_merc_stronghold";
    s.name = "MERC_STRONGHOLD_Q4_HELIPORT_POLICE_STATION";
    fe [[ f ]]( s, "MERC_STRONGHOLD_Q4_HELIPORT_POLICE_STATION", cf, ( 27342.1, -13653, 943.3 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_stronghold_cs";
    fe [[ f ]]( s, "MERC_STRONGHOLD_Q4_HELIPORT_POLICE_STATION", cf, ( 27238.8, -13633.4, 642.8 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Awareness_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 3600 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_stronghold_cs";
    fe [[ f ]]( s, "MERC_STRONGHOLD_Q4_HELIPORT_POLICE_STATION", cf, ( 27231.1, -13639.1, 642.8 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Proximity_Join_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 1200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_stronghold_cs";
    fe [[ f ]]( s, "MERC_STRONGHOLD_Q4_HELIPORT_POLICE_STATION", cf, ( 27311.5, -13600.6, 286.3 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Ambient_AI_Exclusion_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 1050 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_stronghold_cs";
    s.groupid = "reinforcement_spawn_point";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "sh_reinforce_heli";
    s.variantname = "ai_encounter_spawnpoint";
    s.var_4501e0172e168ddf = "MERC_STRONGHOLD_Q4_HELIPORT_POLICE_STATION_VTOL";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "MERC_STRONGHOLD_Q4_HELIPORT_POLICE_STATION", cf, ( 27866.4, -12795.9, 290 ), ( 0, 233.5, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_stronghold_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "parachute_reinforce";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "MERC_STRONGHOLD_Q4_HELIPORT_POLICE_STATION", cf, ( 27371.4, -12530.5, 292.87 ), ( 0, 288.65, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_stronghold_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "parachute_reinforce";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "MERC_STRONGHOLD_Q4_HELIPORT_POLICE_STATION", cf, ( 27373.3, -12610.6, 292.88 ), ( 0, 293.75, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_stronghold_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "parachute_reinforce";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "MERC_STRONGHOLD_Q4_HELIPORT_POLICE_STATION", cf, ( 27532.4, -12521.1, 293.18 ), ( 0, 301.49, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_stronghold_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "parachute_reinforce";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "MERC_STRONGHOLD_Q4_HELIPORT_POLICE_STATION", cf, ( 27581.2, -12639.6, 293.18 ), ( 0, 283.86, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_stronghold_cs";
    s.activity_bundle = "sat_activitydefinition_merc_stronghold";
    s.name = "MERC_STRONGHOLD_Q4_SHIP_YARD";
    fe [[ f ]]( s, "MERC_STRONGHOLD_Q4_SHIP_YARD", cf, ( 26462.6, -55279.3, 899.16 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_stronghold_cs";
    fe [[ f ]]( s, "MERC_STRONGHOLD_Q4_SHIP_YARD", cf, ( 26598.9, -55488, 80 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Awareness_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 3600 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_stronghold_cs";
    fe [[ f ]]( s, "MERC_STRONGHOLD_Q4_SHIP_YARD", cf, ( 26483.2, -55361.9, 80 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Ambient_AI_Exclusion_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 1000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_stronghold_cs";
    fe [[ f ]]( s, "MERC_STRONGHOLD_Q4_SHIP_YARD", cf, ( 26545.8, -55527.6, 80 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Proximity_Join_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 1300 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_stronghold_cs";
    s.groupid = "reinforcement_spawn_point";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "sh_reinforce_heli";
    s.variantname = "ai_encounter_spawnpoint";
    s.var_4501e0172e168ddf = "MERC_STRONGHOLD_Q4_SHIP_YARD_VTOL";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "MERC_STRONGHOLD_Q4_SHIP_YARD", cf, ( 27345, -55892.9, 81.44 ), ( 0, 166.72, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_stronghold_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "parachute_reinforce";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "MERC_STRONGHOLD_Q4_SHIP_YARD", cf, ( 27264.4, -55907.6, 81.64 ), ( 0, 94.82, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_stronghold_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "parachute_reinforce";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "MERC_STRONGHOLD_Q4_SHIP_YARD", cf, ( 27191.4, -56088.9, 81.84 ), ( 0, 95.79, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_stronghold_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "parachute_reinforce";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "MERC_STRONGHOLD_Q4_SHIP_YARD", cf, ( 27048.1, -56096.4, 82.21 ), ( 0, 121.85, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_stronghold_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "parachute_reinforce";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "MERC_STRONGHOLD_Q4_SHIP_YARD", cf, ( 27365.7, -55953.8, 81.53 ), ( 0, 63.18, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace mp_sat_avalon_q4_ob_activity_merc_stronghold_cs
// Params 0, eflags: 0x4
// Checksum 0x7d5a53c2, Offset: 0x22ec
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace mp_sat_avalon_q4_ob_activity_merc_stronghold_cs
// Params 0
// Checksum 0x71f15463, Offset: 0x22f6
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "mp_sat_avalon_q4_ob_activity_merc_stronghold_cs" );
}

// Namespace mp_sat_avalon_q4_ob_activity_merc_stronghold_cs
// Params 0
// Checksum 0xac430d65, Offset: 0x230c
// Size: 0x66
function function_4cd78e661617f3()
{
    activityinfostruct = {};
    activityinfostruct.name = "REV_OB_MERC_STRONGHOLD";
    activityinfostruct.scriptbundle = "sat_activitydefinition_merc_stronghold";
    activityinfostruct.mainfunction = &main;
    activityinfostruct.var_934f068483ae4ddb = &function_d4323822d7042e5a;
    activityinfostruct.metadatafunction = &function_d9dd7965c51c95d1;
    return activityinfostruct;
}

// Namespace mp_sat_avalon_q4_ob_activity_merc_stronghold_cs
// Params 4
// Checksum 0x1dd8a0dc, Offset: 0x237b
// Size: 0xa5
function function_d4323822d7042e5a( var_4312b79c960726b6, fe, us, cf = "mp_sat_avalon_q4_ob_activity_merc_stronghold_cs" )
{
    switch ( var_4312b79c960726b6 )
    {
        case #"hash_d5c19c29bac75a23":
            function_6738121b9c7fc86b( fe, us, cf );
            break;
        case #"hash_f1c99fedb94e8f3d":
            function_3c6e633542c23195( fe, us, cf );
            break;
        case #"hash_3b8f857d70899b8b":
            function_64496eb1dcaae933( fe, us, cf );
            break;
        case #"hash_737219b2ff9a5c05":
            function_d259d72b4d0f836d( fe, us, cf );
            break;
    }
}

// Namespace mp_sat_avalon_q4_ob_activity_merc_stronghold_cs
// Params 3
// Checksum 0x83f60020, Offset: 0x2428
// Size: 0x851
function function_6738121b9c7fc86b( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_stronghold_cs";
    s.name = "MERC_STRONGHOLD_Q4_MOUNTAIN_RANGE_Exterior_encounter";
    fe [[ f ]]( s, "MERC_STRONGHOLD_Q4_MOUNTAIN_RANGE", cf, ( 11543.1, -31030.7, 4493.62 ), ( 0, 0, 0 ), "MERC_STRONGHOLD_Q4_MOUNTAIN_RANGE_Exterior_encounter", "cspf_5_auto5258024133433001186", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 3500 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_stronghold_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    s.script_accel = "350";
    fe [[ f ]]( s, "MERC_STRONGHOLD_Q4_MOUNTAIN_RANGE", cf, ( 12350.8, -28772.8, 4657.94 ), ( 0, 226.63, 0 ), "MERC_STRONGHOLD_Q4_MOUNTAIN_RANGE_VTOL", "cspf_5_auto4889021132968025942", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_stronghold_cs";
    s.name = "killstreak_support";
    fe [[ f ]]( s, "MERC_STRONGHOLD_Q4_MOUNTAIN_RANGE", cf, ( 13024.7, -29293.4, 4046.77 ), ( 0, 348.28, 0 ), "cspf_5_auto5258024133433001186", undefined, "killstreak_support", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_stronghold_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MERC_STRONGHOLD_Q4_MOUNTAIN_RANGE", cf, ( -5536.6, -35017.2, 17023.5 ), ( 359.47, 166.26, 0.5 ), "cspf_5_auto6643362043425959807", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_stronghold_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MERC_STRONGHOLD_Q4_MOUNTAIN_RANGE", cf, ( 17556.5, -18098.8, 10542.8 ), ( 0, 244.14, 0 ), undefined, "cspf_5_auto3149979902808425491", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150, 1 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_stronghold_cs";
    fe [[ f ]]( s, "MERC_STRONGHOLD_Q4_MOUNTAIN_RANGE", cf, ( 12083.6, -29508.9, 4309.28 ), ( 0, 0, 0 ), "MERC_STRONGHOLD_Q4_MOUNTAIN_RANGE_main", "MERC_STRONGHOLD_Q4_MOUNTAIN_RANGE", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_stronghold_cs";
    s.groupid = "traps";
    s.name = "mine";
    fe [[ f ]]( s, "MERC_STRONGHOLD_Q4_MOUNTAIN_RANGE", cf, ( 12699.2, -29501.8, 4052.29 ), ( 0, 184.19, 0 ), "cspf_5_auto5258024133433001186", undefined, "mine", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_stronghold_cs";
    s.groupid = "traps";
    s.name = "mine";
    fe [[ f ]]( s, "MERC_STRONGHOLD_Q4_MOUNTAIN_RANGE", cf, ( 12061.1, -29085.4, 4052.37 ), ( 0, 184.19, 0 ), "cspf_5_auto5258024133433001186", undefined, "mine", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_stronghold_cs";
    s.groupid = "traps";
    s.name = "mine";
    fe [[ f ]]( s, "MERC_STRONGHOLD_Q4_MOUNTAIN_RANGE", cf, ( 11436.4, -28789.5, 4052.28 ), ( 0, 184.19, 0 ), "cspf_5_auto5258024133433001186", undefined, "mine", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_stronghold_cs";
    s.groupid = "traps";
    s.name = "mine";
    fe [[ f ]]( s, "MERC_STRONGHOLD_Q4_MOUNTAIN_RANGE", cf, ( 11537.1, -29654.2, 4052.28 ), ( 0, 184.19, 0 ), "cspf_5_auto5258024133433001186", undefined, "mine", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_stronghold_cs";
    s.groupid = "traps";
    s.name = "mine";
    fe [[ f ]]( s, "MERC_STRONGHOLD_Q4_MOUNTAIN_RANGE", cf, ( 12141.5, -30247.5, 4050.94 ), ( 0, 184.19, 0 ), "cspf_5_auto5258024133433001186", undefined, "mine", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_stronghold_cs";
    s.groupid = "traps";
    s.name = "sentry";
    fe [[ f ]]( s, "MERC_STRONGHOLD_Q4_MOUNTAIN_RANGE", cf, ( 12037.5, -28583.8, 4052.4 ), ( 0, 87.04, 0 ), "cspf_5_auto5258024133433001186", undefined, "sentry_turret", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_stronghold_cs";
    s.groupid = "traps";
    s.name = "sentry";
    fe [[ f ]]( s, "MERC_STRONGHOLD_Q4_MOUNTAIN_RANGE", cf, ( 10783.8, -33482.9, 4269.34 ), ( 0, 237.87, 0 ), "cspf_5_auto5258024133433001186", undefined, "sentry_turret", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_stronghold_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MERC_STRONGHOLD_Q4_MOUNTAIN_RANGE", cf, ( 6543.5, -36044.3, 10781 ), ( 359.47, 166.26, 0.5 ), "cspf_5_auto4889021132968025942", "cspf_5_auto6643362043425959807", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_stronghold_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MERC_STRONGHOLD_Q4_MOUNTAIN_RANGE", cf, ( 16294.4, -21957.9, 10170.8 ), ( 0, 131, 0 ), "cspf_5_auto3149979902808425491", "MERC_STRONGHOLD_Q4_MOUNTAIN_RANGE_VTOL", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_stronghold_cs";
    s.name = "vehicle";
    s.script_label = "vehicle";
    fe [[ f ]]( s, "MERC_STRONGHOLD_Q4_MOUNTAIN_RANGE", cf, ( 11480.4, -26808.5, 3858.52 ), ( 359.14, 232.96, 7.16 ), "cspf_5_auto5258024133433001186", undefined, "veh_sat_medium_truck_ob", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_sat_avalon_q4_ob_activity_merc_stronghold_cs
// Params 3
// Checksum 0xa355a9ad, Offset: 0x2c81
// Size: 0x851
function function_3c6e633542c23195( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_stronghold_cs";
    s.groupid = "traps";
    s.name = "mine";
    fe [[ f ]]( s, "MERC_STRONGHOLD_Q4_CAR_FACTORY", cf, ( 54623.5, -36037.5, 1991 ), ( 0, 184.19, 0 ), "cspf_6_auto14542517468604503059", undefined, "mine", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_stronghold_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    s.script_accel = "350";
    fe [[ f ]]( s, "MERC_STRONGHOLD_Q4_CAR_FACTORY", cf, ( 54341.8, -36314.2, 2600.44 ), ( 0, 310.98, 0 ), "MERC_STRONGHOLD_Q4_CAR_FACTORY_VTOL", "cspf_6_auto726309354391109002", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_stronghold_cs";
    s.name = "MERC_STRONGHOLD_Q4_CAR_FACTORY_Exterior_encounter";
    fe [[ f ]]( s, "MERC_STRONGHOLD_Q4_CAR_FACTORY", cf, ( 54699.7, -36847.7, 2005.64 ), ( 0, 0, 0 ), "MERC_STRONGHOLD_Q4_CAR_FACTORY_Exterior_encounter", "cspf_6_auto14542517468604503059", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 1800 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_stronghold_cs";
    fe [[ f ]]( s, "MERC_STRONGHOLD_Q4_CAR_FACTORY", cf, ( 54680.2, -36832, 1991 ), ( 0, 0, 0 ), "MERC_STRONGHOLD_Q4_CAR_FACTORY_main", "MERC_STRONGHOLD_Q4_CAR_FACTORY", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_stronghold_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MERC_STRONGHOLD_Q4_CAR_FACTORY", cf, ( 59016.3, -54451.5, 15225.5 ), ( 359.47, 250.61, 0.5 ), "cspf_6_auto8047942752686471156", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_stronghold_cs";
    s.name = "killstreak_support";
    fe [[ f ]]( s, "MERC_STRONGHOLD_Q4_CAR_FACTORY", cf, ( 54276, -35696.2, 1991 ), ( 0, 348.28, 0 ), "cspf_6_auto14542517468604503059", undefined, "killstreak_support", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_stronghold_cs";
    s.groupid = "traps";
    s.name = "mine";
    fe [[ f ]]( s, "MERC_STRONGHOLD_Q4_CAR_FACTORY", cf, ( 53896.4, -36762.6, 1991 ), ( 0, 184.19, 0 ), "cspf_6_auto14542517468604503059", undefined, "mine", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_stronghold_cs";
    s.groupid = "traps";
    s.name = "mine";
    fe [[ f ]]( s, "MERC_STRONGHOLD_Q4_CAR_FACTORY", cf, ( 54506.8, -37773, 1991 ), ( 0, 184.19, 0 ), "cspf_6_auto14542517468604503059", undefined, "mine", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_stronghold_cs";
    s.groupid = "traps";
    s.name = "mine";
    fe [[ f ]]( s, "MERC_STRONGHOLD_Q4_CAR_FACTORY", cf, ( 55627.2, -36671.6, 1991 ), ( 0, 184.19, 0 ), "cspf_6_auto14542517468604503059", undefined, "mine", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_stronghold_cs";
    s.groupid = "traps";
    s.name = "sentry";
    fe [[ f ]]( s, "MERC_STRONGHOLD_Q4_CAR_FACTORY", cf, ( 53897.9, -36019, 1991 ), ( 0, 135.37, 0 ), "cspf_6_auto14542517468604503059", undefined, "sentry_turret", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_stronghold_cs";
    s.groupid = "traps";
    s.name = "sentry";
    fe [[ f ]]( s, "MERC_STRONGHOLD_Q4_CAR_FACTORY", cf, ( 55457.7, -37749.5, 1990 ), ( 0, 197.95, 0 ), "cspf_6_auto14542517468604503059", undefined, "sentry_turret", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_stronghold_cs";
    s.name = "vehicle";
    s.script_label = "vehicle";
    fe [[ f ]]( s, "MERC_STRONGHOLD_Q4_CAR_FACTORY", cf, ( 53026.1, -35782.8, 1987.67 ), ( 0, 44.36, 0 ), "cspf_6_auto14542517468604503059", undefined, "veh_sat_medium_truck_ob", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_stronghold_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MERC_STRONGHOLD_Q4_CAR_FACTORY", cf, ( 44454.2, -29804.6, 8744.77 ), ( 0, 328.49, 0 ), undefined, "cspf_6_auto243372999194930071", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150, 1 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_stronghold_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MERC_STRONGHOLD_Q4_CAR_FACTORY", cf, ( 61228, -42531.3, 8983.02 ), ( 359.47, 250.61, 0.5 ), "cspf_6_auto726309354391109002", "cspf_6_auto8047942752686471156", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_stronghold_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MERC_STRONGHOLD_Q4_CAR_FACTORY", cf, ( 48170.3, -31440.6, 8372.77 ), ( 0, 215.35, 0 ), "cspf_6_auto243372999194930071", "MERC_STRONGHOLD_Q4_CAR_FACTORY_VTOL", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_stronghold_cs";
    s.groupid = "traps";
    s.name = "sentry";
    fe [[ f ]]( s, "MERC_STRONGHOLD_Q4_CAR_FACTORY", cf, ( 55945.1, -37273.8, 1990 ), ( 0, 80.69, 0 ), "cspf_6_auto14542517468604503059", undefined, "sentry_turret", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_sat_avalon_q4_ob_activity_merc_stronghold_cs
// Params 3
// Checksum 0x3ca51b9b, Offset: 0x34da
// Size: 0x851
function function_64496eb1dcaae933( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_stronghold_cs";
    s.name = "MERC_STRONGHOLD_Q4_HELIPORT_POLICE_STATION_Exterior_encounter";
    fe [[ f ]]( s, "MERC_STRONGHOLD_Q4_HELIPORT_POLICE_STATION", cf, ( 27318.9, -13854.8, 265.64 ), ( 0, 0, 0 ), "MERC_STRONGHOLD_Q4_HELIPORT_POLICE_STATION_Exterior_encounter", "cspf_7_auto8748859790318523794", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 1300 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_stronghold_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    s.script_accel = "350";
    fe [[ f ]]( s, "MERC_STRONGHOLD_Q4_HELIPORT_POLICE_STATION", cf, ( 28110.8, -12929.3, 899.44 ), ( 0, 226.63, 0 ), "MERC_STRONGHOLD_Q4_HELIPORT_POLICE_STATION_VTOL", "cspf_7_auto9162691001564262347", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_stronghold_cs";
    fe [[ f ]]( s, "MERC_STRONGHOLD_Q4_HELIPORT_POLICE_STATION", cf, ( 27210.5, -13671.7, 642.8 ), ( 0, 0, 0 ), "MERC_STRONGHOLD_Q4_HELIPORT_POLICE_STATION_main", "MERC_STRONGHOLD_Q4_HELIPORT_POLICE_STATION", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_stronghold_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MERC_STRONGHOLD_Q4_HELIPORT_POLICE_STATION", cf, ( 10134.9, -19129.2, 13277 ), ( 359.47, 166.26, 0.5 ), "cspf_7_auto13973953128165638921", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_stronghold_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MERC_STRONGHOLD_Q4_HELIPORT_POLICE_STATION", cf, ( 33228, -2210.75, 6796.27 ), ( 0, 244.14, 0 ), undefined, "cspf_7_auto14991308982428524467", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150, 1 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_stronghold_cs";
    s.name = "spawn_heli_reinforcements";
    s.script_parameters = "merc_heli_stronghold_q4_heliport_police_station";
    fe [[ f ]]( s, "MERC_STRONGHOLD_Q4_HELIPORT_POLICE_STATION", cf, ( 27422.3, -12464.5, 293.18 ), ( 0, 270, 0 ), undefined, "MERC_STRONGHOLD_Q4_HELIPORT_POLICE_STATION", "s_heli_reinforce", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_stronghold_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MERC_STRONGHOLD_Q4_HELIPORT_POLICE_STATION", cf, ( 22215, -20156.3, 7034.52 ), ( 359.47, 166.26, 0.5 ), "cspf_7_auto9162691001564262347", "cspf_7_auto13973953128165638921", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_stronghold_cs";
    s.name = "vehicle";
    s.script_label = "vehicle";
    fe [[ f ]]( s, "MERC_STRONGHOLD_Q4_HELIPORT_POLICE_STATION", cf, ( 28804.2, -14300, 283.18 ), ( 0, 222.98, 0 ), "cspf_7_auto8748859790318523794", undefined, "veh_sat_medium_truck_ob", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_stronghold_cs";
    s.groupid = "traps";
    s.name = "mine";
    fe [[ f ]]( s, "MERC_STRONGHOLD_Q4_HELIPORT_POLICE_STATION", cf, ( 27816.5, -13443, 322.8 ), ( 0, 348.28, 0 ), "cspf_7_auto8748859790318523794", undefined, "mine", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_stronghold_cs";
    s.groupid = "traps";
    s.name = "mine";
    fe [[ f ]]( s, "MERC_STRONGHOLD_Q4_HELIPORT_POLICE_STATION", cf, ( 26503.8, -13562.1, 322.8 ), ( 0, 348.28, 0 ), "cspf_7_auto8748859790318523794", undefined, "mine", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_stronghold_cs";
    s.groupid = "traps";
    s.name = "mine";
    fe [[ f ]]( s, "MERC_STRONGHOLD_Q4_HELIPORT_POLICE_STATION", cf, ( 26866.3, -13233.2, 642.8 ), ( 0, 348.28, 0 ), "cspf_7_auto8748859790318523794", undefined, "mine", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_stronghold_cs";
    s.groupid = "traps";
    s.name = "mine";
    fe [[ f ]]( s, "MERC_STRONGHOLD_Q4_HELIPORT_POLICE_STATION", cf, ( 27102.9, -13238.4, 296 ), ( 0, 348.28, 0 ), "cspf_7_auto8748859790318523794", undefined, "mine", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_stronghold_cs";
    s.groupid = "traps";
    s.name = "sentry";
    fe [[ f ]]( s, "MERC_STRONGHOLD_Q4_HELIPORT_POLICE_STATION", cf, ( 27978.7, -13137.1, 296 ), ( 0, 48.8, 0 ), "cspf_7_auto8748859790318523794", undefined, "sentry_turret", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_stronghold_cs";
    s.groupid = "traps";
    s.name = "sentry";
    fe [[ f ]]( s, "MERC_STRONGHOLD_Q4_HELIPORT_POLICE_STATION", cf, ( 27408.3, -12774.4, 296 ), ( 0, 98.68, 0 ), "cspf_7_auto8748859790318523794", undefined, "sentry_turret", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_stronghold_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MERC_STRONGHOLD_Q4_HELIPORT_POLICE_STATION", cf, ( 31965.9, -6069.89, 6424.27 ), ( 0, 131, 0 ), "cspf_7_auto14991308982428524467", "MERC_STRONGHOLD_Q4_HELIPORT_POLICE_STATION_VTOL", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_stronghold_cs";
    s.name = "killstreak_support";
    fe [[ f ]]( s, "MERC_STRONGHOLD_Q4_HELIPORT_POLICE_STATION", cf, ( 28308.2, -13238.5, 288.17 ), ( 0, 348.28, 0 ), "cspf_7_auto8748859790318523794", undefined, "killstreak_support", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_sat_avalon_q4_ob_activity_merc_stronghold_cs
// Params 3
// Checksum 0xb4825e49, Offset: 0x3d33
// Size: 0x7cc
function function_d259d72b4d0f836d( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_stronghold_cs";
    s.groupid = "traps";
    s.name = "sentry";
    fe [[ f ]]( s, "MERC_STRONGHOLD_Q4_SHIP_YARD", cf, ( 27179.4, -55648.7, 81.26 ), ( 0, 346.74, 0 ), "cspf_8_auto14542517468604503059", undefined, "sentry_turret", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_stronghold_cs";
    s.groupid = "traps";
    s.name = "sentry";
    fe [[ f ]]( s, "MERC_STRONGHOLD_Q4_SHIP_YARD", cf, ( 25933.7, -54662.7, 81 ), ( 0, 136.3, 0 ), "cspf_8_auto14542517468604503059", undefined, "sentry_turret", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_stronghold_cs";
    s.name = "MERC_STRONGHOLD_Q4_SHIP_YARD_Exterior_encounter";
    fe [[ f ]]( s, "MERC_STRONGHOLD_Q4_SHIP_YARD", cf, ( 26513.4, -55343, 59.57 ), ( 0, 0, 0 ), "MERC_STRONGHOLD_Q4_SHIP_YARD_Exterior_encounter", "cspf_8_auto14542517468604503059", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 1400 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_stronghold_cs";
    fe [[ f ]]( s, "MERC_STRONGHOLD_Q4_SHIP_YARD", cf, ( 26565.8, -55513.9, 80 ), ( 0, 0, 0 ), "MERC_STRONGHOLD_Q4_SHIP_YARD_main", "MERC_STRONGHOLD_Q4_SHIP_YARD", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_stronghold_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    s.script_accel = "350";
    fe [[ f ]]( s, "MERC_STRONGHOLD_Q4_SHIP_YARD", cf, ( 27311, -55992.6, 688.44 ), ( 0, 159.85, 0 ), "MERC_STRONGHOLD_Q4_SHIP_YARD_VTOL", "cspf_8_auto920846746521179711", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_stronghold_cs";
    s.name = "killstreak_support";
    fe [[ f ]]( s, "MERC_STRONGHOLD_Q4_SHIP_YARD", cf, ( 26529.6, -54440.8, 81 ), ( 0, 348.28, 0 ), "cspf_8_auto14542517468604503059", undefined, "killstreak_support", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_stronghold_cs";
    s.groupid = "traps";
    s.name = "mine";
    fe [[ f ]]( s, "MERC_STRONGHOLD_Q4_SHIP_YARD", cf, ( 26859.2, -55743, 82.25 ), ( 0, 184.19, 0 ), "cspf_8_auto14542517468604503059", undefined, "mine", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_stronghold_cs";
    s.groupid = "traps";
    s.name = "mine";
    fe [[ f ]]( s, "MERC_STRONGHOLD_Q4_SHIP_YARD", cf, ( 25818.2, -55634.8, 82.5 ), ( 0, 184.19, 0 ), "cspf_8_auto14542517468604503059", undefined, "mine", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_stronghold_cs";
    s.groupid = "traps";
    s.name = "mine";
    fe [[ f ]]( s, "MERC_STRONGHOLD_Q4_SHIP_YARD", cf, ( 26010.7, -54760.5, 81 ), ( 0, 184.19, 0 ), "cspf_8_auto14542517468604503059", undefined, "mine", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_stronghold_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MERC_STRONGHOLD_Q4_SHIP_YARD", cf, ( 15207, -41679.2, 13076.5 ), ( 359.47, 99.47, 0.5 ), "cspf_8_auto5982936128500270727", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_stronghold_cs";
    s.groupid = "traps";
    s.name = "sentry";
    fe [[ f ]]( s, "MERC_STRONGHOLD_Q4_SHIP_YARD", cf, ( 26763.7, -56004.4, 81.75 ), ( 0, 252.8, 0 ), "cspf_8_auto14542517468604503059", undefined, "sentry_turret", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_stronghold_cs";
    s.name = "vehicle";
    s.script_label = "vehicle";
    fe [[ f ]]( s, "MERC_STRONGHOLD_Q4_SHIP_YARD", cf, ( 27733, -54601.2, 82.5 ), ( 0, 130.36, 0 ), "cspf_8_auto14542517468604503059", undefined, "veh_sat_medium_truck_ob", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_stronghold_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MERC_STRONGHOLD_Q4_SHIP_YARD", cf, ( 39858.2, -56234, 6595.8 ), ( 0, 177.35, 0 ), undefined, "cspf_8_auto4878313221695803210", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150, 1 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_stronghold_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MERC_STRONGHOLD_Q4_SHIP_YARD", cf, ( 19024.6, -53186.1, 6834 ), ( 359.47, 99.47, 0.5 ), "cspf_8_auto920846746521179711", "cspf_8_auto5982936128500270727", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_merc_stronghold_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MERC_STRONGHOLD_Q4_SHIP_YARD", cf, ( 35814, -56595.2, 6223.8 ), ( 0, 64.22, 0 ), "cspf_8_auto4878313221695803210", "MERC_STRONGHOLD_Q4_SHIP_YARD_VTOL", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
}

// Namespace mp_sat_avalon_q4_ob_activity_merc_stronghold_cs
// Params 0
// Checksum 0xb0bcd79e, Offset: 0x4507
// Size: 0x355
function function_d9dd7965c51c95d1()
{
    activityinstances = [];
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_activitydefinition_merc_stronghold";
    var_881289d7987bc770.cf = "mp_sat_avalon_q4_ob_activity_merc_stronghold_cs";
    var_881289d7987bc770.scriptstructorigin = ( 12040.7, -29383.2, 4595.53 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [ ( 12044.9, -29469, 4277.28 ) ];
    var_881289d7987bc770.var_31ce4477e3543d24 = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.locationradius = [ 1250 ];
    activityinstances[ "MERC_STRONGHOLD_Q4_MOUNTAIN_RANGE" ] = var_881289d7987bc770;
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_activitydefinition_merc_stronghold";
    var_881289d7987bc770.cf = "mp_sat_avalon_q4_ob_activity_merc_stronghold_cs";
    var_881289d7987bc770.scriptstructorigin = ( 54876.9, -37029.5, 2431.02 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [ ( 54694, -36833.6, 1991 ) ];
    var_881289d7987bc770.var_31ce4477e3543d24 = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.locationradius = [ 1250 ];
    activityinstances[ "MERC_STRONGHOLD_Q4_CAR_FACTORY" ] = var_881289d7987bc770;
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_activitydefinition_merc_stronghold";
    var_881289d7987bc770.cf = "mp_sat_avalon_q4_ob_activity_merc_stronghold_cs";
    var_881289d7987bc770.scriptstructorigin = ( 27342.1, -13653, 943.3 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [ ( 27206.4, -13651.5, 642.8 ) ];
    var_881289d7987bc770.var_31ce4477e3543d24 = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.locationradius = [ 1400 ];
    activityinstances[ "MERC_STRONGHOLD_Q4_HELIPORT_POLICE_STATION" ] = var_881289d7987bc770;
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_activitydefinition_merc_stronghold";
    var_881289d7987bc770.cf = "mp_sat_avalon_q4_ob_activity_merc_stronghold_cs";
    var_881289d7987bc770.scriptstructorigin = ( 26462.6, -55279.3, 899.16 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [ ( 26554.5, -55539.5, 80 ) ];
    var_881289d7987bc770.var_31ce4477e3543d24 = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.locationradius = [ 1250 ];
    activityinstances[ "MERC_STRONGHOLD_Q4_SHIP_YARD" ] = var_881289d7987bc770;
    return activityinstances;
}

