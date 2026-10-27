// script_6ad6259c78ac3b9e  (hash_6ad6259c78ac3b9e.gscc) (size: 17774 Bytes / 0x456e / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xedcb5dc2 (3989528002)
// size ...... 17774 (0x456e)
// includes .. 4   (offset: 0x3bfa)
// strings ... 56  (offset: 0x3c1a)
// dev strs .. 0   (offset: 0x456e)
// exports ... 15  (offset: 0x3686)
// cseg ...... 0x66c + 0x301a (0x3686)
// imports ... 28  (offset: 0x38de)
// animtree1 . 0   (offset: 0x456e)
// animtree2 . 0   (offset: 0x456e)
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace mp_sat_avalon_q1_ob_activity_merc_stronghold_cs;

// Namespace mp_sat_avalon_q1_ob_activity_merc_stronghold_cs
// Params 0, eflags: 0x5
// Checksum 0xc86842e5, Offset: 0x68a
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"mp_sat_avalon_q1_ob_activity_merc_stronghold_cs", #"activity_common", &function_b39ecd3d51489472, undefined );
}

// Namespace mp_sat_avalon_q1_ob_activity_merc_stronghold_cs
// Params 0, eflags: 0x4
// Checksum 0x3e7dc000, Offset: 0x6b3
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace mp_sat_avalon_q1_ob_activity_merc_stronghold_cs
// Params 0, eflags: 0x4
// Checksum 0xbb4613ec, Offset: 0x6c4
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace mp_sat_avalon_q1_ob_activity_merc_stronghold_cs
// Params 2
// Checksum 0x61e8d602, Offset: 0x6d5
// Size: 0x8c
function main( unused, unused2 )
{
    if ( utility::flag_exist( "mp_sat_avalon_q1_ob_activity_merc_stronghold_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "mp_sat_avalon_q1_ob_activity_merc_stronghold_cs" ) )
    {
        return;
    }
    
    activity_common::function_e1df676808c1d1e3( &function_4cd78e661617f3 );
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "mp_sat_avalon_q1_ob_activity_merc_stronghold_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "mp_sat_avalon_q1_ob_activity_merc_stronghold_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace mp_sat_avalon_q1_ob_activity_merc_stronghold_cs
// Params 3, eflags: 0x4
// Checksum 0x38c4a723, Offset: 0x769
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "mp_sat_avalon_q1_ob_activity_merc_stronghold_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "mp_sat_avalon_q1_ob_activity_merc_stronghold_cs" );
}

// Namespace mp_sat_avalon_q1_ob_activity_merc_stronghold_cs
// Params 3, eflags: 0x4
// Checksum 0x3ac6e588, Offset: 0x7e3
// Size: 0x1376
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_merc_stronghold_cs";
    fe [[ f ]]( s, "MERC_STRONGHOLD_POLICE_STATION", cf, ( -29894.7, 9248.45, 403.51 ), ( 0, 194.75, 0 ), "activity_nexus_spatial_zone", undefined, "Awareness_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 3600 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_merc_stronghold_cs";
    s.activity_bundle = "sat_activitydefinition_merc_stronghold";
    s.name = "MERC_STRONGHOLD_POLICE_STATION";
    fe [[ f ]]( s, "MERC_STRONGHOLD_POLICE_STATION", cf, ( -29703.2, 9207.03, 981 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_merc_stronghold_cs";
    s.name = "script_struct_nexus_spatial_zone";
    fe [[ f ]]( s, "MERC_STRONGHOLD_POLICE_STATION", cf, ( -29757, 9215.15, 399.51 ), ( 0, 194.75, 0 ), "activity_nexus_spatial_zone", undefined, "Proximity_Join_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 1500 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_merc_stronghold_cs";
    fe [[ f ]]( s, "MERC_STRONGHOLD_POLICE_STATION", cf, ( -29740.5, 9278.64, 369.01 ), ( 0, 194.75, 0 ), "activity_nexus_spatial_zone", undefined, "Ambient_AI_Exclusion_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 1100 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_merc_stronghold_cs";
    s.groupid = "reinforcement_spawn_point";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "sh_reinforce_heli";
    s.variantname = "ai_encounter_spawnpoint";
    s.var_4501e0172e168ddf = "MERC_STRONGHOLD_POLICE_STATION_VTOL";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "MERC_STRONGHOLD_POLICE_STATION", cf, ( -29908.6, 8213, 284.05 ), ( 0, 73.33, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_merc_stronghold_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "parachute_reinforce";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "MERC_STRONGHOLD_POLICE_STATION", cf, ( -30363, 8484.28, 325 ), ( 0, 53.27, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_merc_stronghold_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "parachute_reinforce";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "MERC_STRONGHOLD_POLICE_STATION", cf, ( -30442.1, 8400.19, 325 ), ( 0, 41.84, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_merc_stronghold_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "parachute_reinforce";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "MERC_STRONGHOLD_POLICE_STATION", cf, ( -30250.8, 8442.73, 325 ), ( 0, 54.62, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_merc_stronghold_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "parachute_reinforce";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "MERC_STRONGHOLD_POLICE_STATION", cf, ( -30333.6, 8358.72, 325 ), ( 0, 55.58, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_merc_stronghold_cs";
    fe [[ f ]]( s, "MERC_STRONGHOLD_RIC_VILLA", cf, ( -30817.3, 19179, 1730.25 ), ( 0, 223.09, 0 ), "activity_nexus_spatial_zone", undefined, "Awareness_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 3600 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_merc_stronghold_cs";
    s.activity_bundle = "sat_activitydefinition_merc_stronghold";
    s.name = "MERC_STRONGHOLD_RIC_VILLA";
    fe [[ f ]]( s, "MERC_STRONGHOLD_RIC_VILLA", cf, ( -30541.1, 19303.3, 2339.48 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_merc_stronghold_cs";
    fe [[ f ]]( s, "MERC_STRONGHOLD_RIC_VILLA", cf, ( -30654, 19215.2, 1726.25 ), ( 0, 223.09, 0 ), "activity_nexus_spatial_zone", undefined, "Proximity_Join_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 1200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_merc_stronghold_cs";
    fe [[ f ]]( s, "MERC_STRONGHOLD_RIC_VILLA", cf, ( -30568.9, 19305.8, 1695.75 ), ( 0, 223.09, 0 ), "activity_nexus_spatial_zone", undefined, "Ambient_AI_Exclusion_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 600 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_merc_stronghold_cs";
    s.groupid = "reinforcement_spawn_point";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "sh_reinforce_heli";
    s.variantname = "ai_encounter_spawnpoint";
    s.var_4501e0172e168ddf = "MERC_STRONGHOLD_RIC_VILLA_VTOL";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "MERC_STRONGHOLD_RIC_VILLA", cf, ( -29268.7, 19680.3, 1653 ), ( 0, 104.26, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_merc_stronghold_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "parachute_reinforce";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "MERC_STRONGHOLD_RIC_VILLA", cf, ( -29458.4, 20150.2, 1652.52 ), ( 0, 239.97, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_merc_stronghold_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "parachute_reinforce";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "MERC_STRONGHOLD_RIC_VILLA", cf, ( -29526.3, 20277.6, 1650.39 ), ( 0, 239.46, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_merc_stronghold_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "parachute_reinforce";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "MERC_STRONGHOLD_RIC_VILLA", cf, ( -29372.4, 20018.2, 1651.67 ), ( 0, 243.94, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_merc_stronghold_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "parachute_reinforce";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "MERC_STRONGHOLD_RIC_VILLA", cf, ( -29601.4, 20427.8, 1650.31 ), ( 0, 251.03, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_merc_stronghold_cs";
    fe [[ f ]]( s, "MERC_STRONGHOLD_Q1_MANSION_LOT", cf, ( -53537.6, -1768.42, 681.91 ), ( 0, 255.41, 0 ), "activity_nexus_spatial_zone", undefined, "Awareness_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 3600 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_merc_stronghold_cs";
    s.activity_bundle = "sat_activitydefinition_merc_stronghold";
    s.name = "MERC_STRONGHOLD_Q1_MANSION_LOT";
    fe [[ f ]]( s, "MERC_STRONGHOLD_Q1_MANSION_LOT", cf, ( -53549.9, -1783.13, 1017.66 ), ( 0, 255.41, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_merc_stronghold_cs";
    s.name = "script_struct_nexus_spatial_zone";
    fe [[ f ]]( s, "MERC_STRONGHOLD_Q1_MANSION_LOT", cf, ( -53548.9, -1740.05, 677.91 ), ( 0, 255.41, 0 ), "activity_nexus_spatial_zone", undefined, "Proximity_Join_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 1500 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_merc_stronghold_cs";
    fe [[ f ]]( s, "MERC_STRONGHOLD_Q1_MANSION_LOT", cf, ( -53812.1, -1849.52, 647.41 ), ( 0, 255.41, 0 ), "activity_nexus_spatial_zone", undefined, "Ambient_AI_Exclusion_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 1400 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_merc_stronghold_cs";
    s.groupid = "reinforcement_spawn_point";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "sh_reinforce_heli";
    s.variantname = "ai_encounter_spawnpoint";
    s.var_4501e0172e168ddf = "MERC_STRONGHOLD_Q1_MANSION_LOT_VTOL";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "MERC_STRONGHOLD_Q1_MANSION_LOT", cf, ( -54078.3, -439.01, 309.8 ), ( 0, 302.96, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_merc_stronghold_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "parachute_reinforce";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "MERC_STRONGHOLD_Q1_MANSION_LOT", cf, ( -53931, -481.21, 240 ), ( 0, 296.53, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_merc_stronghold_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "parachute_reinforce";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "MERC_STRONGHOLD_Q1_MANSION_LOT", cf, ( -53852.3, -392.01, 240 ), ( 0, 289.83, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_merc_stronghold_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "parachute_reinforce";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "MERC_STRONGHOLD_Q1_MANSION_LOT", cf, ( -54016.9, -398.44, 240 ), ( 0, 283.5, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_merc_stronghold_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "parachute_reinforce";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "MERC_STRONGHOLD_Q1_MANSION_LOT", cf, ( -53937.7, -322.79, 240 ), ( 0, 284.51, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace mp_sat_avalon_q1_ob_activity_merc_stronghold_cs
// Params 0, eflags: 0x4
// Checksum 0x766c624f, Offset: 0x1b61
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace mp_sat_avalon_q1_ob_activity_merc_stronghold_cs
// Params 0
// Checksum 0xfa977a6e, Offset: 0x1b6b
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "mp_sat_avalon_q1_ob_activity_merc_stronghold_cs" );
}

// Namespace mp_sat_avalon_q1_ob_activity_merc_stronghold_cs
// Params 0
// Checksum 0x27252368, Offset: 0x1b81
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

// Namespace mp_sat_avalon_q1_ob_activity_merc_stronghold_cs
// Params 4
// Checksum 0xd72a0265, Offset: 0x1bf0
// Size: 0x8b
function function_d4323822d7042e5a( var_4312b79c960726b6, fe, us, cf = "mp_sat_avalon_q1_ob_activity_merc_stronghold_cs" )
{
    switch ( var_4312b79c960726b6 )
    {
        case #"hash_ed1f4084502df9e9":
            function_ddb79a41eda566b1( fe, us, cf );
            break;
        case #"hash_1c205adf6d06fb7d":
            function_9292df2192a3f455( fe, us, cf );
            break;
        case #"hash_28821aa615b14824":
            function_f2f64a220fa1acc( fe, us, cf );
            break;
    }
}

// Namespace mp_sat_avalon_q1_ob_activity_merc_stronghold_cs
// Params 3
// Checksum 0xd8e5ff04, Offset: 0x1c83
// Size: 0x7cc
function function_ddb79a41eda566b1( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_merc_stronghold_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    s.script_accel = "350";
    fe [[ f ]]( s, "MERC_STRONGHOLD_POLICE_STATION", cf, ( -29973.7, 8418.87, 945.94 ), ( 0, 68.28, 0 ), "MERC_STRONGHOLD_POLICE_STATION_VTOL", "cspf_4_auto7604240982425377588", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_merc_stronghold_cs";
    fe [[ f ]]( s, "MERC_STRONGHOLD_POLICE_STATION", cf, ( -29782.1, 9302.65, 313.01 ), ( 0, 194.75, 0 ), "MERC_STRONGHOLD_POLICE_STATION_main", "MERC_STRONGHOLD_POLICE_STATION", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_merc_stronghold_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MERC_STRONGHOLD_POLICE_STATION", cf, ( -15565.5, 22351.1, 8944.5 ), ( 359.47, 168.09, 0.49 ), "cspf_4_auto4486146544761868305", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_merc_stronghold_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MERC_STRONGHOLD_POLICE_STATION", cf, ( -41368.5, 12810.2, 7374.27 ), ( 0, 280.58, 0 ), undefined, "cspf_4_auto11903022455411039977", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150, 1 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_merc_stronghold_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MERC_STRONGHOLD_POLICE_STATION", cf, ( -25953.7, 8181.02, 5274.52 ), ( 359.47, 168.09, 0.49 ), "cspf_4_auto7604240982425377588", "cspf_4_auto4486146544761868305", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_merc_stronghold_cs";
    s.name = "killstreak_support";
    fe [[ f ]]( s, "MERC_STRONGHOLD_POLICE_STATION", cf, ( -30206.2, 8512.62, 325 ), ( 0, 348.28, 0 ), "cspf_4_auto18070280937949346675", undefined, "killstreak_support", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_merc_stronghold_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MERC_STRONGHOLD_POLICE_STATION", cf, ( -35959.1, 5432.61, 6296.77 ), ( 0, 358.22, 0 ), "cspf_4_auto11903022455411039977", "MERC_STRONGHOLD_POLICE_STATION_VTOL", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_merc_stronghold_cs";
    s.groupid = "traps";
    s.name = "mine";
    fe [[ f ]]( s, "MERC_STRONGHOLD_POLICE_STATION", cf, ( -29139.8, 9174.34, 668 ), ( 0, 183.03, 0 ), "cspf_4_auto18070280937949346675", undefined, "mine", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_merc_stronghold_cs";
    s.groupid = "traps";
    s.name = "sentry";
    fe [[ f ]]( s, "MERC_STRONGHOLD_POLICE_STATION", cf, ( -30249.4, 8598.25, 324.75 ), ( 0, 315.07, 0 ), "cspf_4_auto18070280937949346675", undefined, "sentry_turret", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_merc_stronghold_cs";
    s.name = "MERC_STRONGHOLD_POLICE_STATION_Exterior_encounter";
    fe [[ f ]]( s, "MERC_STRONGHOLD_POLICE_STATION", cf, ( -29837.7, 9250.66, 282.42 ), ( 0, 194.75, 0 ), "MERC_STRONGHOLD_POLICE_STATION_Exterior_encounter", "cspf_4_auto18070280937949346675", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 2200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_merc_stronghold_cs";
    s.groupid = "traps";
    s.name = "mine";
    fe [[ f ]]( s, "MERC_STRONGHOLD_POLICE_STATION", cf, ( -30329.4, 8726.81, 324.75 ), ( 0, 183.03, 0 ), "cspf_4_auto18070280937949346675", undefined, "mine", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_merc_stronghold_cs";
    s.groupid = "traps";
    s.name = "mine";
    fe [[ f ]]( s, "MERC_STRONGHOLD_POLICE_STATION", cf, ( -29067.5, 9686.58, 348 ), ( 0, 93.2, 0 ), "cspf_4_auto18070280937949346675", undefined, "mine", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_merc_stronghold_cs";
    s.groupid = "traps";
    s.name = "mine";
    fe [[ f ]]( s, "MERC_STRONGHOLD_POLICE_STATION", cf, ( -29324.7, 9017.42, 324.75 ), ( 0, 183.03, 0 ), "cspf_4_auto18070280937949346675", undefined, "mine", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_merc_stronghold_cs";
    s.groupid = "traps";
    s.name = "sentry";
    fe [[ f ]]( s, "MERC_STRONGHOLD_POLICE_STATION", cf, ( -29288.2, 8562.27, 324.75 ), ( 0, 217.7, 0 ), "cspf_4_auto18070280937949346675", undefined, "sentry_turret", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_merc_stronghold_cs";
    s.name = "vehicle";
    s.script_label = "vehicle";
    fe [[ f ]]( s, "MERC_STRONGHOLD_POLICE_STATION", cf, ( -31933.4, 8085.22, 277.47 ), ( 0, 180.92, 0 ), "cspf_4_auto18070280937949346675", undefined, "veh_sat_medium_truck_ob", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_sat_avalon_q1_ob_activity_merc_stronghold_cs
// Params 3
// Checksum 0x1623e356, Offset: 0x2457
// Size: 0x747
function function_9292df2192a3f455( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_merc_stronghold_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    s.script_accel = "350";
    fe [[ f ]]( s, "MERC_STRONGHOLD_RIC_VILLA", cf, ( -29334.7, 19705.9, 2267.94 ), ( 0, 68.28, 0 ), "MERC_STRONGHOLD_RIC_VILLA_VTOL", "cspf_5_auto16604331684983584021", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_merc_stronghold_cs";
    fe [[ f ]]( s, "MERC_STRONGHOLD_RIC_VILLA", cf, ( -30634.8, 19394.3, 2359 ), ( 0, 223.09, 0 ), "MERC_STRONGHOLD_RIC_VILLA_main", "MERC_STRONGHOLD_RIC_VILLA", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_merc_stronghold_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MERC_STRONGHOLD_RIC_VILLA", cf, ( -14926.5, 33638.1, 10317.5 ), ( 359.47, 168.09, 0.49 ), "cspf_5_auto11364724418346732150", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_merc_stronghold_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MERC_STRONGHOLD_RIC_VILLA", cf, ( -40729.5, 24097.2, 8747.27 ), ( 0, 280.58, 0 ), undefined, "cspf_5_auto1414255069922336845", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150, 1 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_merc_stronghold_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MERC_STRONGHOLD_RIC_VILLA", cf, ( -25314.7, 19468, 6647.52 ), ( 359.47, 168.09, 0.49 ), "cspf_5_auto16604331684983584021", "cspf_5_auto11364724418346732150", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_merc_stronghold_cs";
    s.name = "killstreak_support";
    fe [[ f ]]( s, "MERC_STRONGHOLD_RIC_VILLA", cf, ( -29456.2, 19792.4, 1653 ), ( 0, 348.28, 0 ), "cspf_5_auto18070280937949346675", undefined, "killstreak_support", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_merc_stronghold_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MERC_STRONGHOLD_RIC_VILLA", cf, ( -35320.1, 16719.6, 7669.77 ), ( 0, 358.22, 0 ), "cspf_5_auto1414255069922336845", "MERC_STRONGHOLD_RIC_VILLA_VTOL", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_merc_stronghold_cs";
    s.name = "vehicle";
    s.script_label = "vehicle";
    fe [[ f ]]( s, "MERC_STRONGHOLD_RIC_VILLA", cf, ( -28279.6, 21305.3, 1759.35 ), ( 0, 317.15, 0 ), "cspf_5_auto18070280937949346675", undefined, "veh_sat_medium_truck_ob", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_merc_stronghold_cs";
    s.groupid = "traps";
    s.name = "sentry";
    fe [[ f ]]( s, "MERC_STRONGHOLD_RIC_VILLA", cf, ( -29790.7, 19166, 1653 ), ( 0, 229.46, 0 ), "cspf_5_auto18070280937949346675", undefined, "sentry_turret", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_merc_stronghold_cs";
    s.name = "MERC_STRONGHOLD_RIC_VILLA_Exterior_encounter";
    fe [[ f ]]( s, "MERC_STRONGHOLD_RIC_VILLA", cf, ( -29883.1, 19917.2, 2167.42 ), ( 0, 223.09, 0 ), "MERC_STRONGHOLD_RIC_VILLA_Exterior_encounter", "cspf_5_auto18070280937949346675", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 2200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_merc_stronghold_cs";
    s.groupid = "traps";
    s.name = "mine";
    fe [[ f ]]( s, "MERC_STRONGHOLD_RIC_VILLA", cf, ( -31104.3, 19248.8, 1653 ), ( 0, 211.37, 0 ), "cspf_5_auto18070280937949346675", undefined, "mine", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_merc_stronghold_cs";
    s.groupid = "traps";
    s.name = "mine";
    fe [[ f ]]( s, "MERC_STRONGHOLD_RIC_VILLA", cf, ( -30029.1, 19538.2, 1653 ), ( 0, 121.55, 0 ), "cspf_5_auto18070280937949346675", undefined, "mine", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_merc_stronghold_cs";
    s.groupid = "traps";
    s.name = "mine";
    fe [[ f ]]( s, "MERC_STRONGHOLD_RIC_VILLA", cf, ( -30941, 18906.2, 1653 ), ( 0, 211.37, 0 ), "cspf_5_auto18070280937949346675", undefined, "mine", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_merc_stronghold_cs";
    s.groupid = "traps";
    s.name = "sentry";
    fe [[ f ]]( s, "MERC_STRONGHOLD_RIC_VILLA", cf, ( -30106.3, 19862.8, 1653 ), ( 0, 49.83, 0 ), "cspf_5_auto18070280937949346675", undefined, "sentry_turret", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_sat_avalon_q1_ob_activity_merc_stronghold_cs
// Params 3
// Checksum 0xa2a08f91, Offset: 0x2ba6
// Size: 0x851
function function_f2f64a220fa1acc( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_merc_stronghold_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    s.script_accel = "350";
    fe [[ f ]]( s, "MERC_STRONGHOLD_Q1_MANSION_LOT", cf, ( -53932.1, -426.6, 946.44 ), ( 0, 297.92, 0 ), "MERC_STRONGHOLD_Q1_MANSION_LOT_VTOL", "cspf_6_auto10247873923506636556", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_merc_stronghold_cs";
    fe [[ f ]]( s, "MERC_STRONGHOLD_Q1_MANSION_LOT", cf, ( -53555.4, -1717.39, 1310.66 ), ( 0, 255.41, 0 ), "MERC_STRONGHOLD_Q1_MANSION_LOT_main", "MERC_STRONGHOLD_Q1_MANSION_LOT", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_merc_stronghold_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MERC_STRONGHOLD_Q1_MANSION_LOT", cf, ( -68071.1, -8122.55, 8945 ), ( 359.47, 37.73, 0.49 ), "cspf_6_auto16625639244220778332", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_merc_stronghold_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MERC_STRONGHOLD_Q1_MANSION_LOT", cf, ( -48291.5, 15642.2, 7374.77 ), ( 0, 286.66, 0 ), undefined, "cspf_6_auto16037593484924023893", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150, 1 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_merc_stronghold_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MERC_STRONGHOLD_Q1_MANSION_LOT", cf, ( -57240.1, -6828.84, 5275.02 ), ( 359.47, 37.73, 0.49 ), "cspf_6_auto10247873923506636556", "cspf_6_auto16625639244220778332", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_merc_stronghold_cs";
    s.name = "spawn_heli_reinforcements";
    s.script_parameters = "merc_heli_stronghold_q1_mansion_lot";
    fe [[ f ]]( s, "MERC_STRONGHOLD_Q1_MANSION_LOT", cf, ( -54029.9, -445.95, 240 ), ( 0, 165.41, 0 ), undefined, "MERC_STRONGHOLD_Q1_MANSION_LOT", "s_heli_reinforce", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_merc_stronghold_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MERC_STRONGHOLD_Q1_MANSION_LOT", cf, ( -52233.9, 5958, 6297.27 ), ( 0, 227.85, 0 ), "cspf_6_auto16037593484924023893", "MERC_STRONGHOLD_Q1_MANSION_LOT_VTOL", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_merc_stronghold_cs";
    s.groupid = "traps";
    s.name = "mine";
    fe [[ f ]]( s, "MERC_STRONGHOLD_Q1_MANSION_LOT", cf, ( -53383.2, -1494.76, 415 ), ( 0, 243.69, 0 ), "cspf_6_auto18070280937949346675", undefined, "mine", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_merc_stronghold_cs";
    s.groupid = "traps";
    s.name = "sentry";
    fe [[ f ]]( s, "MERC_STRONGHOLD_Q1_MANSION_LOT", cf, ( -54579.5, -1531.18, 238.95 ), ( 0, 135.03, 0 ), "cspf_6_auto18070280937949346675", undefined, "sentry_turret", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_merc_stronghold_cs";
    s.name = "killstreak_support";
    fe [[ f ]]( s, "MERC_STRONGHOLD_Q1_MANSION_LOT", cf, ( -54642.8, -1178.29, 240.1 ), ( 0, 348.28, 0 ), "cspf_6_auto18070280937949346675", undefined, "killstreak_support", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_merc_stronghold_cs";
    s.name = "MERC_STRONGHOLD_Q1_MANSION_LOT_Exterior_encounter";
    fe [[ f ]]( s, "MERC_STRONGHOLD_Q1_MANSION_LOT", cf, ( -53570.3, -1697.32, 1035.58 ), ( 0, 255.41, 0 ), "MERC_STRONGHOLD_Q1_MANSION_LOT_Exterior_encounter", "cspf_6_auto18070280937949346675", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 3000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_merc_stronghold_cs";
    s.groupid = "traps";
    s.name = "mine";
    fe [[ f ]]( s, "MERC_STRONGHOLD_Q1_MANSION_LOT", cf, ( -52973.3, -1983.7, 255 ), ( 0, 243.69, 0 ), "cspf_6_auto18070280937949346675", undefined, "mine", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_merc_stronghold_cs";
    s.groupid = "traps";
    s.name = "mine";
    fe [[ f ]]( s, "MERC_STRONGHOLD_Q1_MANSION_LOT", cf, ( -53845.7, -2045.28, 287 ), ( 0, 153.86, 0 ), "cspf_6_auto18070280937949346675", undefined, "mine", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_merc_stronghold_cs";
    s.groupid = "traps";
    s.name = "mine";
    fe [[ f ]]( s, "MERC_STRONGHOLD_Q1_MANSION_LOT", cf, ( -54135.7, -1425.91, 255 ), ( 0, 243.69, 0 ), "cspf_6_auto18070280937949346675", undefined, "mine", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_merc_stronghold_cs";
    s.groupid = "traps";
    s.name = "sentry";
    fe [[ f ]]( s, "MERC_STRONGHOLD_Q1_MANSION_LOT", cf, ( -53251, -1335.77, 240.51 ), ( 0, 61.61, 0 ), "cspf_6_auto18070280937949346675", undefined, "sentry_turret", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_merc_stronghold_cs";
    s.name = "vehicle";
    s.script_label = "vehicle";
    fe [[ f ]]( s, "MERC_STRONGHOLD_Q1_MANSION_LOT", cf, ( -54186.3, 589.47, 266.67 ), ( 5.41, 329.86, 0.19 ), "cspf_6_auto18070280937949346675", undefined, "veh_sat_medium_truck_ob", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_sat_avalon_q1_ob_activity_merc_stronghold_cs
// Params 0
// Checksum 0xaa4bb00d, Offset: 0x33ff
// Size: 0x286
function function_d9dd7965c51c95d1()
{
    activityinstances = [];
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_activitydefinition_merc_stronghold";
    var_881289d7987bc770.cf = "mp_sat_avalon_q1_ob_activity_merc_stronghold_cs";
    var_881289d7987bc770.scriptstructorigin = ( -29703.2, 9207.03, 981 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [ ( -29641.5, 9136.78, 313.01 ) ];
    var_881289d7987bc770.var_31ce4477e3543d24 = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.locationradius = [ 1500 ];
    activityinstances[ "MERC_STRONGHOLD_POLICE_STATION" ] = var_881289d7987bc770;
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_activitydefinition_merc_stronghold";
    var_881289d7987bc770.cf = "mp_sat_avalon_q1_ob_activity_merc_stronghold_cs";
    var_881289d7987bc770.scriptstructorigin = ( -30541.1, 19303.3, 2339.48 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [ ( -30717.6, 19280.3, 1699.75 ) ];
    var_881289d7987bc770.var_31ce4477e3543d24 = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.locationradius = [ 1500 ];
    activityinstances[ "MERC_STRONGHOLD_RIC_VILLA" ] = var_881289d7987bc770;
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_activitydefinition_merc_stronghold";
    var_881289d7987bc770.cf = "mp_sat_avalon_q1_ob_activity_merc_stronghold_cs";
    var_881289d7987bc770.scriptstructorigin = ( -53549.9, -1783.13, 1017.66 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [ ( -53552.6, -1792.99, 651.41 ) ];
    var_881289d7987bc770.var_31ce4477e3543d24 = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.locationradius = [ 1600 ];
    activityinstances[ "MERC_STRONGHOLD_Q1_MANSION_LOT" ] = var_881289d7987bc770;
    return activityinstances;
}

