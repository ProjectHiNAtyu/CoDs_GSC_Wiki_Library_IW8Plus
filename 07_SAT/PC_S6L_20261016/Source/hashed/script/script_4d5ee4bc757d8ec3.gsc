// script_4d5ee4bc757d8ec3  (hash_4d5ee4bc757d8ec3.gscc) (size: 17547 Bytes / 0x448b / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xad78f15 (181899029)
// size ...... 17547 (0x448b)
// includes .. 4   (offset: 0x3b3f)
// strings ... 52  (offset: 0x3b5f)
// dev strs .. 0   (offset: 0x448b)
// exports ... 15  (offset: 0x35cb)
// cseg ...... 0x5d3 + 0x2ff8 (0x35cb)
// imports ... 28  (offset: 0x3823)
// animtree1 . 0   (offset: 0x448b)
// animtree2 . 0   (offset: 0x448b)
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace mp_sat_avalon_quad_03_ob_activity_merc_stronghold_cs;

// Namespace mp_sat_avalon_quad_03_ob_activity_merc_stronghold_cs
// Params 0, eflags: 0x5
// Checksum 0xc60f1e25, Offset: 0x5f1
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"mp_sat_avalon_quad_03_ob_activity_merc_stronghold_cs", #"activity_common", &function_b39ecd3d51489472, undefined );
}

// Namespace mp_sat_avalon_quad_03_ob_activity_merc_stronghold_cs
// Params 0, eflags: 0x4
// Checksum 0x1d700a09, Offset: 0x61a
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace mp_sat_avalon_quad_03_ob_activity_merc_stronghold_cs
// Params 0, eflags: 0x4
// Checksum 0x984bd9e5, Offset: 0x62b
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace mp_sat_avalon_quad_03_ob_activity_merc_stronghold_cs
// Params 2
// Checksum 0xc4316f8d, Offset: 0x63c
// Size: 0x8c
function main( unused, unused2 )
{
    if ( utility::flag_exist( "mp_sat_avalon_quad_03_ob_activity_merc_stronghold_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "mp_sat_avalon_quad_03_ob_activity_merc_stronghold_cs" ) )
    {
        return;
    }
    
    activity_common::function_e1df676808c1d1e3( &function_4cd78e661617f3 );
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "mp_sat_avalon_quad_03_ob_activity_merc_stronghold_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "mp_sat_avalon_quad_03_ob_activity_merc_stronghold_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace mp_sat_avalon_quad_03_ob_activity_merc_stronghold_cs
// Params 3, eflags: 0x4
// Checksum 0x1bc96d2a, Offset: 0x6d0
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "mp_sat_avalon_quad_03_ob_activity_merc_stronghold_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "mp_sat_avalon_quad_03_ob_activity_merc_stronghold_cs" );
}

// Namespace mp_sat_avalon_quad_03_ob_activity_merc_stronghold_cs
// Params 3, eflags: 0x4
// Checksum 0xc34caa3e, Offset: 0x74a
// Size: 0x1354
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_stronghold_cs";
    fe [[ f ]]( s, "MERC_STRONGHOLD_Q3_COAST_GUARD", cf, ( -3.09, 82.69, 83.94 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Awareness_Zone", undefined, "activity_link", ( -40903.8, -12138, 114.25 ), ( 0, 0, 0 ), 3600 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_stronghold_cs";
    s.activity_bundle = "sat_activitydefinition_merc_stronghold";
    s.name = "MERC_STRONGHOLD_Q3_COAST_GUARD";
    fe [[ f ]]( s, "MERC_STRONGHOLD_Q3_COAST_GUARD", cf, ( 88.58, 49.1, 628 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( -40903.8, -12138, 114.25 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_stronghold_cs";
    fe [[ f ]]( s, "MERC_STRONGHOLD_Q3_COAST_GUARD", cf, ( -2, 91, 86.5 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Proximity_Join_Zone", undefined, "activity_link", ( -40903.8, -12138, 114.25 ), ( 0, 0, 0 ), 1500 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_stronghold_cs";
    fe [[ f ]]( s, "MERC_STRONGHOLD_Q3_COAST_GUARD", cf, ( 19.54, 73.37, 86.5 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Ambient_AI_Exclusion_Zone", undefined, "activity_link", ( -40903.8, -12138, 114.25 ), ( 0, 0, 0 ), 1100 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_stronghold_cs";
    s.groupid = "reinforcement_spawn_point";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "sh_reinforce_heli";
    s.variantname = "ai_encounter_spawnpoint";
    s.var_4501e0172e168ddf = "MERC_STRONGHOLD_Q3_COAST_GUARD_VTOL";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "MERC_STRONGHOLD_Q3_COAST_GUARD", cf, ( 997.23, -308.9, 13.74 ), ( 0, 277.41, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( -40903.8, -12138, 114.25 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_stronghold_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "parachute_reinforce";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "MERC_STRONGHOLD_Q3_COAST_GUARD", cf, ( 622.84, 672.29, 13.73 ), ( 0, 298.12, 0 ), undefined, undefined, undefined, undefined, undefined, ( -40903.8, -12138, 114.25 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_stronghold_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "parachute_reinforce";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "MERC_STRONGHOLD_Q3_COAST_GUARD", cf, ( 610.71, 808.58, 13.73 ), ( 0, 278.72, 0 ), undefined, undefined, undefined, undefined, undefined, ( -40903.8, -12138, 114.25 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_stronghold_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "parachute_reinforce";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "MERC_STRONGHOLD_Q3_COAST_GUARD", cf, ( 510.99, 745.3, 14.2 ), ( 0, 287.88, 0 ), undefined, undefined, undefined, undefined, undefined, ( -40903.8, -12138, 114.25 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_stronghold_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "parachute_reinforce";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "MERC_STRONGHOLD_Q3_COAST_GUARD", cf, ( 498.22, 851.44, 13.73 ), ( 0, 290.9, 0 ), undefined, undefined, undefined, undefined, undefined, ( -40903.8, -12138, 114.25 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_stronghold_cs";
    fe [[ f ]]( s, "MERC_STRONGHOLD_MI_FORT", cf, ( 348.48, 64, 0 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Awareness_Zone", undefined, "activity_link", ( -38466.2, -38030.2, 902 ), ( 0, 0, 0 ), 3600 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_stronghold_cs";
    fe [[ f ]]( s, "MERC_STRONGHOLD_MI_FORT", cf, ( 60.93, 114, 59 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Ambient_AI_Exclusion_Zone", undefined, "activity_link", ( -38466.2, -38030.2, 902 ), ( 0, 0, 0 ), 1000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_stronghold_cs";
    fe [[ f ]]( s, "MERC_STRONGHOLD_MI_FORT", cf, ( 177.01, -59.75, 0 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Proximity_Join_Zone", undefined, "activity_link", ( -38466.2, -38030.2, 902 ), ( 0, 0, 0 ), 1800 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_stronghold_cs";
    s.activity_bundle = "sat_activitydefinition_merc_stronghold";
    s.name = "MERC_STRONGHOLD_MI_FORT";
    fe [[ f ]]( s, "MERC_STRONGHOLD_MI_FORT", cf, ( 280.64, 5.72, 638.82 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( -38466.2, -38030.2, 902 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_stronghold_cs";
    s.groupid = "reinforcement_spawn_point";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "sh_reinforce_heli";
    s.variantname = "ai_encounter_spawnpoint";
    s.var_4501e0172e168ddf = "MERC_STRONGHOLD_MI_FORT_VTOL";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "MERC_STRONGHOLD_MI_FORT", cf, ( -11.74, -644.73, 13.24 ), ( 0, 40.77, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( -38466.2, -38030.2, 902 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_stronghold_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "parachute_reinforce";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "MERC_STRONGHOLD_MI_FORT", cf, ( 174.83, -594.88, -11.5 ), ( 0, 94.82, 0 ), undefined, undefined, undefined, undefined, undefined, ( -38466.2, -38030.2, 902 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_stronghold_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "parachute_reinforce";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "MERC_STRONGHOLD_MI_FORT", cf, ( 271.87, -513.54, -11.5 ), ( 0, 95.79, 0 ), undefined, undefined, undefined, undefined, undefined, ( -38466.2, -38030.2, 902 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_stronghold_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "parachute_reinforce";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "MERC_STRONGHOLD_MI_FORT", cf, ( 409.11, -522.68, -11.5 ), ( 0, 121.85, 0 ), undefined, undefined, undefined, undefined, undefined, ( -38466.2, -38030.2, 902 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_stronghold_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "parachute_reinforce";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "MERC_STRONGHOLD_MI_FORT", cf, ( 333.74, -610.66, -11.5 ), ( 0, 63.18, 0 ), undefined, undefined, undefined, undefined, undefined, ( -38466.2, -38030.2, 902 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_stronghold_cs";
    s.activity_bundle = "sat_activitydefinition_merc_stronghold";
    s.name = "MERC_STRONGHOLD_Q3_RADAR";
    fe [[ f ]]( s, "MERC_STRONGHOLD_Q3_RADAR", cf, ( 25.68, 32.3, 529.78 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( -21620, -42952, 372 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_stronghold_cs";
    fe [[ f ]]( s, "MERC_STRONGHOLD_Q3_RADAR", cf, ( -34.98, 95.29, -6.72 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Awareness_Zone", undefined, "activity_link", ( -21620, -42952, 372 ), ( 0, 0, 0 ), 3600 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_stronghold_cs";
    fe [[ f ]]( s, "MERC_STRONGHOLD_Q3_RADAR", cf, ( 17.4, 94.19, -6.72 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Ambient_AI_Exclusion_Zone", undefined, "activity_link", ( -21620, -42952, 372 ), ( 0, 0, 0 ), 1000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_stronghold_cs";
    fe [[ f ]]( s, "MERC_STRONGHOLD_Q3_RADAR", cf, ( -48.13, 87.93, -6.72 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Proximity_Join_Zone", undefined, "activity_link", ( -21620, -42952, 372 ), ( 0, 0, 0 ), 1500 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_stronghold_cs";
    s.groupid = "reinforcement_spawn_point";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "sh_reinforce_heli";
    s.variantname = "ai_encounter_spawnpoint";
    s.var_4501e0172e168ddf = "MERC_STRONGHOLD_Q3_RADAR_VTOL";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "MERC_STRONGHOLD_Q3_RADAR", cf, ( 90.2, 935.24, -7.18 ), ( 0, 297.43, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( -21620, -42952, 372 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_stronghold_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "parachute_reinforce";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "MERC_STRONGHOLD_Q3_RADAR", cf, ( -192.39, 1024.96, -9.35 ), ( 0, 252.66, 0 ), undefined, undefined, undefined, undefined, undefined, ( -21620, -42952, 372 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_stronghold_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "parachute_reinforce";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "MERC_STRONGHOLD_Q3_RADAR", cf, ( -76.87, 1043.31, -9.31 ), ( 0, 248.96, 0 ), undefined, undefined, undefined, undefined, undefined, ( -21620, -42952, 372 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_stronghold_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "parachute_reinforce";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "MERC_STRONGHOLD_Q3_RADAR", cf, ( 7.5, 1061.22, -10.74 ), ( 0, 243.64, 0 ), undefined, undefined, undefined, undefined, undefined, ( -21620, -42952, 372 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_stronghold_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "parachute_reinforce";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "MERC_STRONGHOLD_Q3_RADAR", cf, ( 103.25, 1081.48, -10.64 ), ( 0, 243.24, 0 ), undefined, undefined, undefined, undefined, undefined, ( -21620, -42952, 372 ), ( 0, 0, 0 ) );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace mp_sat_avalon_quad_03_ob_activity_merc_stronghold_cs
// Params 0, eflags: 0x4
// Checksum 0xd3b5dbc0, Offset: 0x1aa6
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace mp_sat_avalon_quad_03_ob_activity_merc_stronghold_cs
// Params 0
// Checksum 0xd99ab067, Offset: 0x1ab0
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "mp_sat_avalon_quad_03_ob_activity_merc_stronghold_cs" );
}

// Namespace mp_sat_avalon_quad_03_ob_activity_merc_stronghold_cs
// Params 0
// Checksum 0x428e961, Offset: 0x1ac6
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

// Namespace mp_sat_avalon_quad_03_ob_activity_merc_stronghold_cs
// Params 4
// Checksum 0x83dfa6b6, Offset: 0x1b35
// Size: 0x8b
function function_d4323822d7042e5a( var_4312b79c960726b6, fe, us, cf = "mp_sat_avalon_quad_03_ob_activity_merc_stronghold_cs" )
{
    switch ( var_4312b79c960726b6 )
    {
        case #"hash_ab25abd643fd07a7":
            function_b8ebfa85c801baf( fe, us, cf );
            break;
        case #"hash_85858ac21d239182":
            function_8cc38e564c68d6ca( fe, us, cf );
            break;
        case #"hash_d8ef9ff280821dab":
            function_2416c3a4ebfa5a33( fe, us, cf );
            break;
    }
}

// Namespace mp_sat_avalon_quad_03_ob_activity_merc_stronghold_cs
// Params 3
// Checksum 0xdd9a2a2c, Offset: 0x1bc8
// Size: 0x7cc
function function_b8ebfa85c801baf( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_stronghold_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    s.script_accel = "350";
    fe [[ f ]]( s, "MERC_STRONGHOLD_Q3_COAST_GUARD", cf, ( 1026.5, -362.2, 622.94 ), ( 0, 266.05, 0 ), "MERC_STRONGHOLD_Q3_COAST_GUARD_VTOL", "cspf_4_auto16930928438227835385", undefined, undefined, undefined, ( -40903.8, -12138, 114.25 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_stronghold_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MERC_STRONGHOLD_Q3_COAST_GUARD", cf, ( -7355.4, -11295.7, 7877.02 ), ( 359.47, 325.57, 0.5 ), "cspf_4_auto2167616861107467170", undefined, undefined, undefined, undefined, ( -40903.8, -12138, 114.25 ), ( 0, 0, 0 ), undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_stronghold_cs";
    fe [[ f ]]( s, "MERC_STRONGHOLD_Q3_COAST_GUARD", cf, ( -111.55, 7.64, 245.75 ), ( 0, 0, 0 ), "MERC_STRONGHOLD_Q3_COAST_GUARD_main", "MERC_STRONGHOLD_Q3_COAST_GUARD", undefined, undefined, undefined, ( -40903.8, -12138, 114.25 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_stronghold_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MERC_STRONGHOLD_Q3_COAST_GUARD", cf, ( 9161.8, 8818.3, 7081.77 ), ( 0, 175.75, 0 ), undefined, "cspf_4_auto1780538671794234990", undefined, undefined, undefined, ( -40903.8, -12138, 114.25 ), ( 0, 0, 0 ), undefined, 150, 1 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_stronghold_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MERC_STRONGHOLD_Q3_COAST_GUARD", cf, ( -2691.1, -4009.7, 4982.02 ), ( 359.47, 325.57, 0.5 ), "cspf_4_auto16930928438227835385", "cspf_4_auto2167616861107467170", undefined, undefined, undefined, ( -40903.8, -12138, 114.25 ), ( 0, 0, 0 ), undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_stronghold_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MERC_STRONGHOLD_Q3_COAST_GUARD", cf, ( 6097, 6203.3, 6004.27 ), ( 0, 290.32, 0 ), "cspf_4_auto1780538671794234990", "MERC_STRONGHOLD_Q3_COAST_GUARD_VTOL", undefined, undefined, undefined, ( -40903.8, -12138, 114.25 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_stronghold_cs";
    s.name = "killstreak_support";
    fe [[ f ]]( s, "MERC_STRONGHOLD_Q3_COAST_GUARD", cf, ( -336.59, 1135.74, 20.34 ), ( 0, 348.28, 0 ), "cspf_4_auto18070280937949346675", undefined, "killstreak_support", undefined, undefined, ( -40903.8, -12138, 114.25 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_stronghold_cs";
    s.groupid = "traps";
    s.name = "mine";
    fe [[ f ]]( s, "MERC_STRONGHOLD_Q3_COAST_GUARD", cf, ( 2.88, 424.35, 20.75 ), ( 0, 184.19, 0 ), "cspf_4_auto18070280937949346675", undefined, "mine", undefined, undefined, ( -40903.8, -12138, 114.25 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_stronghold_cs";
    s.groupid = "traps";
    s.name = "sentry";
    fe [[ f ]]( s, "MERC_STRONGHOLD_Q3_COAST_GUARD", cf, ( 778.13, -297.92, 13.75 ), ( 0, 329.09, 0 ), "cspf_4_auto18070280937949346675", undefined, "sentry_turret", undefined, undefined, ( -40903.8, -12138, 114.25 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_stronghold_cs";
    s.groupid = "traps";
    s.name = "mine";
    fe [[ f ]]( s, "MERC_STRONGHOLD_Q3_COAST_GUARD", cf, ( -186.39, 174.13, 300.23 ), ( 0, 184.19, 0 ), "cspf_4_auto18070280937949346675", undefined, "mine", undefined, undefined, ( -40903.8, -12138, 114.25 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_stronghold_cs";
    s.groupid = "traps";
    s.name = "mine";
    fe [[ f ]]( s, "MERC_STRONGHOLD_Q3_COAST_GUARD", cf, ( -743.95, 484.39, 20.75 ), ( 0, 94.36, 0 ), "cspf_4_auto18070280937949346675", undefined, "mine", undefined, undefined, ( -40903.8, -12138, 114.25 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_stronghold_cs";
    s.groupid = "traps";
    s.name = "mine";
    fe [[ f ]]( s, "MERC_STRONGHOLD_Q3_COAST_GUARD", cf, ( 719.62, 323.07, 15.47 ), ( 0, 184.19, 0 ), "cspf_4_auto18070280937949346675", undefined, "mine", undefined, undefined, ( -40903.8, -12138, 114.25 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_stronghold_cs";
    s.groupid = "traps";
    s.name = "sentry";
    fe [[ f ]]( s, "MERC_STRONGHOLD_Q3_COAST_GUARD", cf, ( 795.17, 449.05, 13.74 ), ( 0, 132.36, 0 ), "cspf_4_auto18070280937949346675", undefined, "sentry_turret", undefined, undefined, ( -40903.8, -12138, 114.25 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_stronghold_cs";
    s.name = "MERC_STRONGHOLD_Q3_COAST_GUARD_Exterior_encounter";
    fe [[ f ]]( s, "MERC_STRONGHOLD_Q3_COAST_GUARD", cf, ( -6.94, 90.57, 132.85 ), ( 0, 195.91, 0 ), "MERC_STRONGHOLD_Q3_COAST_GUARD_Exterior_encounter", "cspf_4_auto18070280937949346675", undefined, undefined, undefined, ( -40903.8, -12138, 114.25 ), ( 0, 0, 0 ), 2000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_stronghold_cs";
    s.name = "vehicle";
    s.script_label = "vehicle";
    fe [[ f ]]( s, "MERC_STRONGHOLD_Q3_COAST_GUARD", cf, ( -232.75, 1780.32, 13.76 ), ( 0, 140.38, 0 ), "cspf_4_auto18070280937949346675", undefined, "veh_sat_medium_truck_ob", undefined, undefined, ( -40903.8, -12138, 114.25 ), ( 0, 0, 0 ) );
}

// Namespace mp_sat_avalon_quad_03_ob_activity_merc_stronghold_cs
// Params 3
// Checksum 0xef0eee42, Offset: 0x239c
// Size: 0x7cc
function function_8cc38e564c68d6ca( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_stronghold_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    s.script_accel = "350";
    fe [[ f ]]( s, "MERC_STRONGHOLD_MI_FORT", cf, ( -98.55, -611.83, 595.44 ), ( 0, 325.71, 0 ), "MERC_STRONGHOLD_MI_FORT_VTOL", "cspf_5_auto13547631828582308307", undefined, undefined, undefined, ( -38466.2, -38030.2, 902 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_stronghold_cs";
    s.groupid = "traps";
    s.name = "mine";
    fe [[ f ]]( s, "MERC_STRONGHOLD_MI_FORT", cf, ( -286.2, -371.97, -16.39 ), ( 0, 348.28, 0 ), "cspf_5_auto18070280937949346675", undefined, "mine", undefined, undefined, ( -38466.2, -38030.2, 902 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_stronghold_cs";
    s.groupid = "traps";
    s.name = "sentry";
    fe [[ f ]]( s, "MERC_STRONGHOLD_MI_FORT", cf, ( 230.58, 878.37, 122 ), ( 0, 160.97, 0 ), "cspf_5_auto18070280937949346675", undefined, "sentry_turret", undefined, undefined, ( -38466.2, -38030.2, 902 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_stronghold_cs";
    s.groupid = "traps";
    s.name = "mine";
    fe [[ f ]]( s, "MERC_STRONGHOLD_MI_FORT", cf, ( 944.05, 1.6, -6 ), ( 0, 348.28, 0 ), "cspf_5_auto18070280937949346675", undefined, "mine", undefined, undefined, ( -38466.2, -38030.2, 902 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_stronghold_cs";
    fe [[ f ]]( s, "MERC_STRONGHOLD_MI_FORT", cf, ( 0, 0, 0 ), ( 0, 0, 0 ), "MERC_STRONGHOLD_MI_FORT_main", "MERC_STRONGHOLD_MI_FORT", undefined, undefined, undefined, ( -38466.2, -38030.2, 902 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_stronghold_cs";
    s.name = "killstreak_support";
    fe [[ f ]]( s, "MERC_STRONGHOLD_MI_FORT", cf, ( 1060.66, -541.33, -14.14 ), ( 0, 348.28, 0 ), "cspf_5_auto18070280937949346675", undefined, "killstreak_support", undefined, undefined, ( -38466.2, -38030.2, 902 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_stronghold_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MERC_STRONGHOLD_MI_FORT", cf, ( 13305.8, -4189, 7876.52 ), ( 359.47, 88.94, 0.5 ), "cspf_5_auto2075552426922962849", undefined, undefined, undefined, undefined, ( -38466.2, -38030.2, 902 ), ( 0, 0, 0 ), undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_stronghold_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MERC_STRONGHOLD_MI_FORT", cf, ( -10583, 10893.6, 9551.27 ), ( 0, 310.25, 0 ), undefined, "cspf_5_auto12314733894875890141", undefined, undefined, undefined, ( -38466.2, -38030.2, 902 ), ( 0, 0, 0 ), undefined, 150, 1 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_stronghold_cs";
    s.groupid = "traps";
    s.name = "mine";
    fe [[ f ]]( s, "MERC_STRONGHOLD_MI_FORT", cf, ( -277.82, 869.6, 122 ), ( 0, 258.45, 0 ), "cspf_5_auto18070280937949346675", undefined, "mine", undefined, undefined, ( -38466.2, -38030.2, 902 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_stronghold_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MERC_STRONGHOLD_MI_FORT", cf, ( 5346.7, -3542.73, 4981.52 ), ( 359.47, 88.94, 0.5 ), "cspf_5_auto13547631828582308307", "cspf_5_auto2075552426922962849", undefined, undefined, undefined, ( -38466.2, -38030.2, 902 ), ( 0, 0, 0 ), undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_stronghold_cs";
    s.groupid = "traps";
    s.name = "sentry";
    fe [[ f ]]( s, "MERC_STRONGHOLD_MI_FORT", cf, ( -191.23, -573.82, -12.81 ), ( 0, 318.04, 0 ), "cspf_5_auto18070280937949346675", undefined, "sentry_turret", undefined, undefined, ( -38466.2, -38030.2, 902 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_stronghold_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MERC_STRONGHOLD_MI_FORT", cf, ( -4175.42, 3092.86, 6003.77 ), ( 0, 53.68, 0 ), "cspf_5_auto12314733894875890141", "MERC_STRONGHOLD_MI_FORT_VTOL", undefined, undefined, undefined, ( -38466.2, -38030.2, 902 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_stronghold_cs";
    s.groupid = "traps";
    s.name = "sentry";
    fe [[ f ]]( s, "MERC_STRONGHOLD_MI_FORT", cf, ( 1349.52, -577.07, -12.23 ), ( 0, 180.9, 0 ), "cspf_5_auto18070280937949346675", undefined, "sentry_turret", undefined, undefined, ( -38466.2, -38030.2, 902 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_stronghold_cs";
    s.name = "MERC_STRONGHOLD_MI_FORT_Exterior_encounter";
    fe [[ f ]]( s, "MERC_STRONGHOLD_MI_FORT", cf, ( -0.85, 2.88, 44.56 ), ( 0, 0, 0 ), "MERC_STRONGHOLD_MI_FORT_Exterior_encounter", "cspf_5_auto18070280937949346675", undefined, undefined, undefined, ( -38466.2, -38030.2, 902 ), ( 0, 0, 0 ), 2500 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_stronghold_cs";
    s.name = "vehicle";
    s.script_label = "vehicle";
    fe [[ f ]]( s, "MERC_STRONGHOLD_MI_FORT", cf, ( -12.31, -1598.64, -11.31 ), ( 2.4, 88.07, -0.09 ), "cspf_5_auto18070280937949346675", undefined, "veh_sat_medium_truck_ob", undefined, undefined, ( -38466.2, -38030.2, 902 ), ( 0, 0, 0 ) );
}

// Namespace mp_sat_avalon_quad_03_ob_activity_merc_stronghold_cs
// Params 3
// Checksum 0xb8834e18, Offset: 0x2b70
// Size: 0x7cc
function function_2416c3a4ebfa5a33( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_stronghold_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    s.script_accel = "350";
    fe [[ f ]]( s, "MERC_STRONGHOLD_Q3_RADAR", cf, ( 87.93, 1129.04, 602.44 ), ( 0, 286.08, 0 ), "MERC_STRONGHOLD_Q3_RADAR_VTOL", "cspf_6_auto2982137174404601509", undefined, undefined, undefined, ( -21620, -42952, 372 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_stronghold_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MERC_STRONGHOLD_Q3_RADAR", cf, ( 250.75, -18564.5, 7876.02 ), ( 359.47, 88.94, 0.5 ), "cspf_6_auto5482279885822003292", undefined, undefined, undefined, undefined, ( -21620, -42952, 372 ), ( 0, 0, 0 ), undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_stronghold_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MERC_STRONGHOLD_Q3_RADAR", cf, ( -9219.5, 20543.1, 8584.27 ), ( 0, 318.21, 0 ), undefined, "cspf_6_auto15077700659417923590", undefined, undefined, undefined, ( -21620, -42952, 372 ), ( 0, 0, 0 ), undefined, 150, 1 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_stronghold_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MERC_STRONGHOLD_Q3_RADAR", cf, ( 1153.2, -3892.23, 4981.02 ), ( 359.47, 88.94, 0.5 ), "cspf_6_auto2982137174404601509", "cspf_6_auto5482279885822003292", undefined, undefined, undefined, ( -21620, -42952, 372 ), ( 0, 0, 0 ), undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_stronghold_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MERC_STRONGHOLD_Q3_RADAR", cf, ( -3039.92, 9469.36, 6003.27 ), ( 0, 53.68, 0 ), "cspf_6_auto15077700659417923590", "MERC_STRONGHOLD_Q3_RADAR_VTOL", undefined, undefined, undefined, ( -21620, -42952, 372 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_stronghold_cs";
    fe [[ f ]]( s, "MERC_STRONGHOLD_Q3_RADAR", cf, ( -58.54, 68.83, -6.72 ), ( 0, 0, 0 ), "MERC_STRONGHOLD_Q3_RADAR_main", "MERC_STRONGHOLD_Q3_RADAR", undefined, undefined, undefined, ( -21620, -42952, 372 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_stronghold_cs";
    s.name = "killstreak_support";
    fe [[ f ]]( s, "MERC_STRONGHOLD_Q3_RADAR", cf, ( 524.76, 710.49, -14.92 ), ( 0, 348.28, 0 ), "cspf_6_auto18070280937949346675", undefined, "killstreak_support", undefined, undefined, ( -21620, -42952, 372 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_stronghold_cs";
    s.name = "MERC_STRONGHOLD_Q3_RADAR_Exterior_encounter";
    fe [[ f ]]( s, "MERC_STRONGHOLD_Q3_RADAR", cf, ( -25.99, 79.46, -6.72 ), ( 0, 0, 0 ), "MERC_STRONGHOLD_Q3_RADAR_Exterior_encounter", "cspf_6_auto18070280937949346675", undefined, undefined, undefined, ( -21620, -42952, 372 ), ( 0, 0, 0 ), 2000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_stronghold_cs";
    s.groupid = "traps";
    s.name = "mine";
    fe [[ f ]]( s, "MERC_STRONGHOLD_Q3_RADAR", cf, ( -378.36, 852.49, -7.72 ), ( 0, 184.19, 0 ), "cspf_6_auto18070280937949346675", undefined, "mine", undefined, undefined, ( -21620, -42952, 372 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_stronghold_cs";
    s.groupid = "traps";
    s.name = "sentry";
    fe [[ f ]]( s, "MERC_STRONGHOLD_Q3_RADAR", cf, ( -507.65, 908.03, -10.44 ), ( 0, 35.19, 0 ), "cspf_6_auto18070280937949346675", undefined, "sentry_turret", undefined, undefined, ( -21620, -42952, 372 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_stronghold_cs";
    s.groupid = "traps";
    s.name = "mine";
    fe [[ f ]]( s, "MERC_STRONGHOLD_Q3_RADAR", cf, ( 127.57, 290.41, -7.72 ), ( 0, 184.19, 0 ), "cspf_6_auto18070280937949346675", undefined, "mine", undefined, undefined, ( -21620, -42952, 372 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_stronghold_cs";
    s.groupid = "traps";
    s.name = "mine";
    fe [[ f ]]( s, "MERC_STRONGHOLD_Q3_RADAR", cf, ( 592.45, -268.81, -7.72 ), ( 0, 94.36, 0 ), "cspf_6_auto18070280937949346675", undefined, "mine", undefined, undefined, ( -21620, -42952, 372 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_stronghold_cs";
    s.groupid = "traps";
    s.name = "mine";
    fe [[ f ]]( s, "MERC_STRONGHOLD_Q3_RADAR", cf, ( -219.98, -778.52, -10.07 ), ( 0, 184.19, 0 ), "cspf_6_auto18070280937949346675", undefined, "mine", undefined, undefined, ( -21620, -42952, 372 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_stronghold_cs";
    s.groupid = "traps";
    s.name = "sentry";
    fe [[ f ]]( s, "MERC_STRONGHOLD_Q3_RADAR", cf, ( 136.55, -830.16, -14.69 ), ( 0, 264.71, 0 ), "cspf_6_auto18070280937949346675", undefined, "sentry_turret", undefined, undefined, ( -21620, -42952, 372 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_merc_stronghold_cs";
    s.name = "vehicle";
    s.script_label = "vehicle";
    fe [[ f ]]( s, "MERC_STRONGHOLD_Q3_RADAR", cf, ( 1518.27, 402.14, -24.06 ), ( 0, 193.09, 0 ), "cspf_6_auto18070280937949346675", undefined, "veh_sat_medium_truck_ob", undefined, undefined, ( -21620, -42952, 372 ), ( 0, 0, 0 ) );
}

// Namespace mp_sat_avalon_quad_03_ob_activity_merc_stronghold_cs
// Params 0
// Checksum 0xb459a812, Offset: 0x3344
// Size: 0x286
function function_d9dd7965c51c95d1()
{
    activityinstances = [];
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_activitydefinition_merc_stronghold";
    var_881289d7987bc770.cf = "mp_sat_avalon_quad_03_ob_activity_merc_stronghold_cs";
    var_881289d7987bc770.scriptstructorigin = ( 88.58, 49.1, 628 );
    var_881289d7987bc770.scriptstructoriginoffset = ( -40903.8, -12138, 114.25 );
    var_881289d7987bc770.locationorigin = [ ( 1.56, 85.54, 81.05 ) ];
    var_881289d7987bc770.var_31ce4477e3543d24 = [ ( -40903.8, -12138, 114.25 ) ];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.locationradius = [ 1500 ];
    activityinstances[ "MERC_STRONGHOLD_Q3_COAST_GUARD" ] = var_881289d7987bc770;
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_activitydefinition_merc_stronghold";
    var_881289d7987bc770.cf = "mp_sat_avalon_quad_03_ob_activity_merc_stronghold_cs";
    var_881289d7987bc770.scriptstructorigin = ( 280.64, 5.72, 638.82 );
    var_881289d7987bc770.scriptstructoriginoffset = ( -38466.2, -38030.2, 902 );
    var_881289d7987bc770.locationorigin = [ ( 44.53, 94.55, 0 ) ];
    var_881289d7987bc770.var_31ce4477e3543d24 = [ ( -38466.2, -38030.2, 902 ) ];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.locationradius = [ 1500 ];
    activityinstances[ "MERC_STRONGHOLD_MI_FORT" ] = var_881289d7987bc770;
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_activitydefinition_merc_stronghold";
    var_881289d7987bc770.cf = "mp_sat_avalon_quad_03_ob_activity_merc_stronghold_cs";
    var_881289d7987bc770.scriptstructorigin = ( 25.68, 32.3, 529.78 );
    var_881289d7987bc770.scriptstructoriginoffset = ( -21620, -42952, 372 );
    var_881289d7987bc770.locationorigin = [ ( -43.82, 77.66, -6.72 ) ];
    var_881289d7987bc770.var_31ce4477e3543d24 = [ ( -21620, -42952, 372 ) ];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.locationradius = [ 1500 ];
    activityinstances[ "MERC_STRONGHOLD_Q3_RADAR" ] = var_881289d7987bc770;
    return activityinstances;
}

