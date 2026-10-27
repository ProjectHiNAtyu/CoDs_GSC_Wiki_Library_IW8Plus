// script_55cf3c46d680d606  (hash_55cf3c46d680d606.gscc) (size: 7750 Bytes / 0x1e46 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xbbe49ee4 (3152322276)
// size ...... 7750 (0x1e46)
// includes .. 4   (offset: 0x1a62)
// strings ... 36  (offset: 0x1a82)
// dev strs .. 0   (offset: 0x1e46)
// exports ... 13  (offset: 0x157e)
// cseg ...... 0x3b0 + 0x11ce (0x157e)
// imports ... 26  (offset: 0x1786)
// animtree1 . 0   (offset: 0x1e46)
// animtree2 . 0   (offset: 0x1e46)
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace mp_sat_avalon_q2_ob_activity_merc_stronghold_cs;

// Namespace mp_sat_avalon_q2_ob_activity_merc_stronghold_cs
// Params 0, eflags: 0x5
// Checksum 0x452f8b92, Offset: 0x3ce
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"mp_sat_avalon_q2_ob_activity_merc_stronghold_cs", #"activity_common", &function_b39ecd3d51489472, undefined );
}

// Namespace mp_sat_avalon_q2_ob_activity_merc_stronghold_cs
// Params 0, eflags: 0x4
// Checksum 0x9260bf4, Offset: 0x3f7
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace mp_sat_avalon_q2_ob_activity_merc_stronghold_cs
// Params 0, eflags: 0x4
// Checksum 0x8c1dd818, Offset: 0x408
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace mp_sat_avalon_q2_ob_activity_merc_stronghold_cs
// Params 2
// Checksum 0x9fac1549, Offset: 0x419
// Size: 0x8c
function main( unused, unused2 )
{
    if ( utility::flag_exist( "mp_sat_avalon_q2_ob_activity_merc_stronghold_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "mp_sat_avalon_q2_ob_activity_merc_stronghold_cs" ) )
    {
        return;
    }
    
    activity_common::function_e1df676808c1d1e3( &function_4cd78e661617f3 );
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "mp_sat_avalon_q2_ob_activity_merc_stronghold_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "mp_sat_avalon_q2_ob_activity_merc_stronghold_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace mp_sat_avalon_q2_ob_activity_merc_stronghold_cs
// Params 3, eflags: 0x4
// Checksum 0xf9f6cd7, Offset: 0x4ad
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "mp_sat_avalon_q2_ob_activity_merc_stronghold_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "mp_sat_avalon_q2_ob_activity_merc_stronghold_cs" );
}

// Namespace mp_sat_avalon_q2_ob_activity_merc_stronghold_cs
// Params 3, eflags: 0x4
// Checksum 0xbc37b255, Offset: 0x527
// Size: 0x6a4
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_stronghold_cs";
    fe [[ f ]]( s, "MERC_STRONGHOLD_Q2_POLICE_STATION", cf, ( 5088.27, 22548.4, 596.22 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Awareness_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 3600 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_stronghold_cs";
    s.activity_bundle = "sat_activitydefinition_merc_stronghold";
    s.name = "MERC_STRONGHOLD_Q2_POLICE_STATION";
    fe [[ f ]]( s, "MERC_STRONGHOLD_Q2_POLICE_STATION", cf, ( 4879.53, 22615.4, 1198.75 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_stronghold_cs";
    fe [[ f ]]( s, "MERC_STRONGHOLD_Q2_POLICE_STATION", cf, ( 4944.27, 22633.4, 592.22 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Proximity_Join_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 1200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_stronghold_cs";
    fe [[ f ]]( s, "MERC_STRONGHOLD_Q2_POLICE_STATION", cf, ( 4931.77, 22653.4, 561.72 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Ambient_AI_Exclusion_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 1000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_stronghold_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "parachute_reinforce";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "MERC_STRONGHOLD_Q2_POLICE_STATION", cf, ( 4973.26, 23447.9, 510.93 ), ( 0, 324.17, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_stronghold_cs";
    s.groupid = "reinforcement_spawn_point";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "sh_reinforce_heli";
    s.variantname = "ai_encounter_spawnpoint";
    s.var_4501e0172e168ddf = "MERC_STRONGHOLD_Q2_POLICE_STATION_VTOL";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "MERC_STRONGHOLD_Q2_POLICE_STATION", cf, ( 4092.65, 23654.5, 511 ), ( 0, 253.93, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_stronghold_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "parachute_reinforce";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "MERC_STRONGHOLD_Q2_POLICE_STATION", cf, ( 4844.84, 23443, 510.94 ), ( 0, 341.19, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_stronghold_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "parachute_reinforce";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "MERC_STRONGHOLD_Q2_POLICE_STATION", cf, ( 4917.74, 23546.9, 510.93 ), ( 0, 331.61, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_stronghold_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "parachute_reinforce";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "MERC_STRONGHOLD_Q2_POLICE_STATION", cf, ( 5072.02, 23382.4, 510.93 ), ( 0, 318.69, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace mp_sat_avalon_q2_ob_activity_merc_stronghold_cs
// Params 0, eflags: 0x4
// Checksum 0x8828a104, Offset: 0xbd3
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace mp_sat_avalon_q2_ob_activity_merc_stronghold_cs
// Params 0
// Checksum 0xcdccb19a, Offset: 0xbdd
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "mp_sat_avalon_q2_ob_activity_merc_stronghold_cs" );
}

// Namespace mp_sat_avalon_q2_ob_activity_merc_stronghold_cs
// Params 0
// Checksum 0x107ee89c, Offset: 0xbf3
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

// Namespace mp_sat_avalon_q2_ob_activity_merc_stronghold_cs
// Params 4
// Checksum 0xc44243e3, Offset: 0xc62
// Size: 0x57
function function_d4323822d7042e5a( var_4312b79c960726b6, fe, us, cf = "mp_sat_avalon_q2_ob_activity_merc_stronghold_cs" )
{
    switch ( var_4312b79c960726b6 )
    {
        case #"hash_35faaaaab1c8753d":
            function_aa1367a74d940f85( fe, us, cf );
            break;
    }
}

// Namespace mp_sat_avalon_q2_ob_activity_merc_stronghold_cs
// Params 3
// Checksum 0xdf2685b2, Offset: 0xcc1
// Size: 0x7cc
function function_aa1367a74d940f85( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_stronghold_cs";
    s.name = "killstreak_support";
    fe [[ f ]]( s, "MERC_STRONGHOLD_Q2_POLICE_STATION", cf, ( 3935.03, 22761.7, 510.92 ), ( 0, 348.28, 0 ), "cspf_2_auto18070280937949346675", undefined, "killstreak_support", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_stronghold_cs";
    fe [[ f ]]( s, "MERC_STRONGHOLD_Q2_POLICE_STATION", cf, ( 4946.27, 22542.4, 505.72 ), ( 0, 0, 0 ), "MERC_STRONGHOLD_Q2_POLICE_STATION_main", "MERC_STRONGHOLD_Q2_POLICE_STATION", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_stronghold_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    s.script_accel = "350";
    fe [[ f ]]( s, "MERC_STRONGHOLD_Q2_POLICE_STATION", cf, ( 4174.52, 23599.1, 1120.44 ), ( 0, 247.06, 0 ), "MERC_STRONGHOLD_Q2_POLICE_STATION_VTOL", "cspf_2_auto4274935029285559968", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_stronghold_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MERC_STRONGHOLD_Q2_POLICE_STATION", cf, ( -10060.3, 11426.1, 13753.5 ), ( 359.47, 186.69, 0.5 ), "cspf_2_auto12970257441331309654", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_stronghold_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MERC_STRONGHOLD_Q2_POLICE_STATION", cf, ( 5673.79, 35341.9, 7272.77 ), ( 0, 264.57, 0 ), undefined, "cspf_2_auto18272141432198641506", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150, 1 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_stronghold_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MERC_STRONGHOLD_Q2_POLICE_STATION", cf, ( 1618.31, 14680.7, 7511.02 ), ( 359.47, 186.69, 0.5 ), "cspf_2_auto4274935029285559968", "cspf_2_auto12970257441331309654", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_stronghold_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MERC_STRONGHOLD_Q2_POLICE_STATION", cf, ( 5838.29, 31284.9, 6900.77 ), ( 0, 151.43, 0 ), "cspf_2_auto18272141432198641506", "MERC_STRONGHOLD_Q2_POLICE_STATION_VTOL", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_stronghold_cs";
    s.groupid = "traps";
    s.name = "mine";
    fe [[ f ]]( s, "MERC_STRONGHOLD_Q2_POLICE_STATION", cf, ( 4298.53, 22773.7, 858 ), ( 0, 348.28, 0 ), "cspf_2_auto18070280937949346675", undefined, "mine", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_stronghold_cs";
    s.groupid = "traps";
    s.name = "sentry";
    fe [[ f ]]( s, "MERC_STRONGHOLD_Q2_POLICE_STATION", cf, ( 5577.48, 23104.6, 511 ), ( 0, 120.33, 0 ), "cspf_2_auto18070280937949346675", undefined, "sentry_turret", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_stronghold_cs";
    s.name = "MERC_STRONGHOLD_Q2_POLICE_STATION_Exterior_encounter";
    fe [[ f ]]( s, "MERC_STRONGHOLD_Q2_POLICE_STATION", cf, ( 5013.31, 22578.5, 475.13 ), ( 0, 0, 0 ), "MERC_STRONGHOLD_Q2_POLICE_STATION_Exterior_encounter", "cspf_2_auto18070280937949346675", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 2200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_stronghold_cs";
    s.groupid = "traps";
    s.name = "mine";
    fe [[ f ]]( s, "MERC_STRONGHOLD_Q2_POLICE_STATION", cf, ( 5577.45, 22940.1, 511 ), ( 0, 348.28, 0 ), "cspf_2_auto18070280937949346675", undefined, "mine", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_stronghold_cs";
    s.groupid = "traps";
    s.name = "mine";
    fe [[ f ]]( s, "MERC_STRONGHOLD_Q2_POLICE_STATION", cf, ( 4137.69, 22322.3, 538 ), ( 0, 258.45, 0 ), "cspf_2_auto18070280937949346675", undefined, "mine", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_stronghold_cs";
    s.groupid = "traps";
    s.name = "mine";
    fe [[ f ]]( s, "MERC_STRONGHOLD_Q2_POLICE_STATION", cf, ( 4534.44, 22880.9, 511 ), ( 0, 348.28, 0 ), "cspf_2_auto18070280937949346675", undefined, "mine", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_stronghold_cs";
    s.groupid = "traps";
    s.name = "sentry";
    fe [[ f ]]( s, "MERC_STRONGHOLD_Q2_POLICE_STATION", cf, ( 4540.03, 23411.6, 511 ), ( 0, 22.95, 0 ), "cspf_2_auto18070280937949346675", undefined, "sentry_turret", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_merc_stronghold_cs";
    s.name = "vehicle";
    s.script_label = "vehicle";
    fe [[ f ]]( s, "MERC_STRONGHOLD_Q2_POLICE_STATION", cf, ( 5074, 23861.5, 515 ), ( 0, 125.62, 0 ), "cspf_2_auto18070280937949346675", undefined, "veh_sat_medium_truck_ob", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_sat_avalon_q2_ob_activity_merc_stronghold_cs
// Params 0
// Checksum 0x74f0cb09, Offset: 0x1495
// Size: 0xe8
function function_d9dd7965c51c95d1()
{
    activityinstances = [];
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_activitydefinition_merc_stronghold";
    var_881289d7987bc770.cf = "mp_sat_avalon_q2_ob_activity_merc_stronghold_cs";
    var_881289d7987bc770.scriptstructorigin = ( 4879.53, 22615.4, 1198.75 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [ ( 4946.27, 22542.4, 505.72 ) ];
    var_881289d7987bc770.var_31ce4477e3543d24 = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.locationradius = [ 1500 ];
    activityinstances[ "MERC_STRONGHOLD_Q2_POLICE_STATION" ] = var_881289d7987bc770;
    return activityinstances;
}

