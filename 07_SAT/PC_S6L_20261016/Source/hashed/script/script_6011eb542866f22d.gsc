// script_6011eb542866f22d  (hash_6011eb542866f22d.gscc) (size: 7934 Bytes / 0x1efe / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xf630557e (4130362750)
// size ...... 7934 (0x1efe)
// includes .. 4   (offset: 0x1b02)
// strings ... 36  (offset: 0x1b22)
// dev strs .. 0   (offset: 0x1efe)
// exports ... 13  (offset: 0x161e)
// cseg ...... 0x3cb + 0x1253 (0x161e)
// imports ... 26  (offset: 0x1826)
// animtree1 . 0   (offset: 0x1efe)
// animtree2 . 0   (offset: 0x1efe)
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace mp_sat_avalon_city_ob_activity_merc_stronghold_cs;

// Namespace mp_sat_avalon_city_ob_activity_merc_stronghold_cs
// Params 0, eflags: 0x5
// Checksum 0x877eb008, Offset: 0x3e9
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"mp_sat_avalon_city_ob_activity_merc_stronghold_cs", #"activity_common", &function_b39ecd3d51489472, undefined );
}

// Namespace mp_sat_avalon_city_ob_activity_merc_stronghold_cs
// Params 0, eflags: 0x4
// Checksum 0xf9662192, Offset: 0x412
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace mp_sat_avalon_city_ob_activity_merc_stronghold_cs
// Params 0, eflags: 0x4
// Checksum 0x7c5df27e, Offset: 0x423
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace mp_sat_avalon_city_ob_activity_merc_stronghold_cs
// Params 2
// Checksum 0x76a72921, Offset: 0x434
// Size: 0x8c
function main( unused, unused2 )
{
    if ( utility::flag_exist( "mp_sat_avalon_city_ob_activity_merc_stronghold_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "mp_sat_avalon_city_ob_activity_merc_stronghold_cs" ) )
    {
        return;
    }
    
    activity_common::function_e1df676808c1d1e3( &function_4cd78e661617f3 );
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "mp_sat_avalon_city_ob_activity_merc_stronghold_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "mp_sat_avalon_city_ob_activity_merc_stronghold_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace mp_sat_avalon_city_ob_activity_merc_stronghold_cs
// Params 3, eflags: 0x4
// Checksum 0xffdf46b1, Offset: 0x4c8
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "mp_sat_avalon_city_ob_activity_merc_stronghold_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "mp_sat_avalon_city_ob_activity_merc_stronghold_cs" );
}

// Namespace mp_sat_avalon_city_ob_activity_merc_stronghold_cs
// Params 3, eflags: 0x4
// Checksum 0x77ef1c0a, Offset: 0x542
// Size: 0x6a4
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_merc_stronghold_cs";
    fe [[ f ]]( s, "MERC_STRONGHOLD_LOW_TOWN_POLICE_STATION", cf, ( -4103.12, -5801.46, 368.95 ), ( 0, 13.88, 0 ), "activity_nexus_spatial_zone", undefined, "Awareness_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 3600 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_merc_stronghold_cs";
    s.activity_bundle = "sat_activitydefinition_merc_stronghold";
    s.name = "MERC_STRONGHOLD_LOW_TOWN_POLICE_STATION";
    fe [[ f ]]( s, "MERC_STRONGHOLD_LOW_TOWN_POLICE_STATION", cf, ( -4215.04, -5667.02, 1162.75 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_merc_stronghold_cs";
    fe [[ f ]]( s, "MERC_STRONGHOLD_LOW_TOWN_POLICE_STATION", cf, ( -4263.31, -5753.5, 415.25 ), ( 0, 13.88, 0 ), "activity_nexus_spatial_zone", undefined, "Proximity_Join_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 1200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_merc_stronghold_cs";
    fe [[ f ]]( s, "MERC_STRONGHOLD_LOW_TOWN_POLICE_STATION", cf, ( -4267.18, -5771.06, 417.41 ), ( 0, 13.88, 0 ), "activity_nexus_spatial_zone", undefined, "Ambient_AI_Exclusion_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 1000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_merc_stronghold_cs";
    s.groupid = "reinforcement_spawn_point";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "sh_reinforce_heli";
    s.variantname = "ai_encounter_spawnpoint";
    s.var_4501e0172e168ddf = "MERC_STRONGHOLD_LOW_TOWN_POLICE_STATION_VTOL";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "MERC_STRONGHOLD_LOW_TOWN_POLICE_STATION", cf, ( -5471.99, -5462.17, 425.79 ), ( 0, 270.25, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_merc_stronghold_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "parachute_reinforce";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "MERC_STRONGHOLD_LOW_TOWN_POLICE_STATION", cf, ( -5495.76, -5292.53, 425.79 ), ( 0, 216.13, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_merc_stronghold_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "parachute_reinforce";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "MERC_STRONGHOLD_LOW_TOWN_POLICE_STATION", cf, ( -5376.82, -5258.61, 425.79 ), ( 0, 207.54, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_merc_stronghold_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "parachute_reinforce";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "MERC_STRONGHOLD_LOW_TOWN_POLICE_STATION", cf, ( -5379.85, -5383.58, 425.79 ), ( 0, 192.26, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_merc_stronghold_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "parachute_reinforce";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "MERC_STRONGHOLD_LOW_TOWN_POLICE_STATION", cf, ( -5508.05, -5196.87, 425.8 ), ( 0, 151.83, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace mp_sat_avalon_city_ob_activity_merc_stronghold_cs
// Params 0, eflags: 0x4
// Checksum 0x61239d6c, Offset: 0xbee
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace mp_sat_avalon_city_ob_activity_merc_stronghold_cs
// Params 0
// Checksum 0x3d8c9bfc, Offset: 0xbf8
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "mp_sat_avalon_city_ob_activity_merc_stronghold_cs" );
}

// Namespace mp_sat_avalon_city_ob_activity_merc_stronghold_cs
// Params 0
// Checksum 0xe03ec2fa, Offset: 0xc0e
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

// Namespace mp_sat_avalon_city_ob_activity_merc_stronghold_cs
// Params 4
// Checksum 0xf7b6a6f7, Offset: 0xc7d
// Size: 0x57
function function_d4323822d7042e5a( var_4312b79c960726b6, fe, us, cf = "mp_sat_avalon_city_ob_activity_merc_stronghold_cs" )
{
    switch ( var_4312b79c960726b6 )
    {
        case #"hash_89a207ba0d9ceb1d":
            function_e6cff5dd2449f6d5( fe, us, cf );
            break;
    }
}

// Namespace mp_sat_avalon_city_ob_activity_merc_stronghold_cs
// Params 3
// Checksum 0xc179c91c, Offset: 0xcdc
// Size: 0x851
function function_e6cff5dd2449f6d5( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_merc_stronghold_cs";
    s.groupid = "traps";
    s.name = "sentry";
    fe [[ f ]]( s, "MERC_STRONGHOLD_LOW_TOWN_POLICE_STATION", cf, ( -5558.97, -5995.46, 425.79 ), ( 0, 241.09, 0 ), "cspf_2_auto13616119982007906281", undefined, "sentry_turret", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_merc_stronghold_cs";
    fe [[ f ]]( s, "MERC_STRONGHOLD_LOW_TOWN_POLICE_STATION", cf, ( -4239.54, -5841.36, 278.45 ), ( 0, 13.88, 0 ), "MERC_STRONGHOLD_LOW_TOWN_POLICE_STATION_main", "MERC_STRONGHOLD_LOW_TOWN_POLICE_STATION", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_merc_stronghold_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    s.script_accel = "350";
    fe [[ f ]]( s, "MERC_STRONGHOLD_LOW_TOWN_POLICE_STATION", cf, ( -5742.87, -5178.01, 1033.44 ), ( 0, 247.59, 0 ), "MERC_STRONGHOLD_LOW_TOWN_POLICE_STATION_VTOL", "cspf_2_auto16575009579664662677", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_merc_stronghold_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MERC_STRONGHOLD_LOW_TOWN_POLICE_STATION", cf, ( -8266.96, -24400.7, 8639.5 ), ( 359.47, 25.19, 0.49 ), "cspf_2_auto11387957997915763495", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_merc_stronghold_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MERC_STRONGHOLD_LOW_TOWN_POLICE_STATION", cf, ( 395.11, 6592.33, 7069.27 ), ( 0, 246.93, 0 ), undefined, "cspf_2_auto18441560641740155286", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150, 1 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_merc_stronghold_cs";
    s.name = "killstreak_support";
    fe [[ f ]]( s, "MERC_STRONGHOLD_LOW_TOWN_POLICE_STATION", cf, ( -5400.71, -5547.55, 425.79 ), ( 0, 348.28, 0 ), "cspf_2_auto13616119982007906281", undefined, "killstreak_support", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_merc_stronghold_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MERC_STRONGHOLD_LOW_TOWN_POLICE_STATION", cf, ( -9024.62, -11826.6, 4969.52 ), ( 359.47, 25.19, 0.49 ), "cspf_2_auto16575009579664662677", "cspf_2_auto11387957997915763495", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_merc_stronghold_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MERC_STRONGHOLD_LOW_TOWN_POLICE_STATION", cf, ( -1901.92, 1408.52, 5991.77 ), ( 0, 215.32, 0 ), "cspf_2_auto18441560641740155286", "MERC_STRONGHOLD_LOW_TOWN_POLICE_STATION_VTOL", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_merc_stronghold_cs";
    s.groupid = "traps";
    s.name = "mine";
    fe [[ f ]]( s, "MERC_STRONGHOLD_LOW_TOWN_POLICE_STATION", cf, ( -4556.08, -5513.96, 449 ), ( 0, 2.16, 0 ), "cspf_2_auto13616119982007906281", undefined, "mine", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_merc_stronghold_cs";
    s.groupid = "traps";
    s.name = "sentry";
    fe [[ f ]]( s, "MERC_STRONGHOLD_LOW_TOWN_POLICE_STATION", cf, ( -4117.29, -5141.43, 473 ), ( 0, 95.07, 0 ), "cspf_2_auto13616119982007906281", undefined, "sentry_turret", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_merc_stronghold_cs";
    s.name = "MERC_STRONGHOLD_LOW_TOWN_POLICE_STATION_Exterior_encounter";
    fe [[ f ]]( s, "MERC_STRONGHOLD_LOW_TOWN_POLICE_STATION", cf, ( -4183.12, -5790.23, 247.86 ), ( 0, 13.88, 0 ), "MERC_STRONGHOLD_LOW_TOWN_POLICE_STATION_Exterior_encounter", "cspf_2_auto13616119982007906281", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 2200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_merc_stronghold_cs";
    s.groupid = "traps";
    s.name = "mine";
    fe [[ f ]]( s, "MERC_STRONGHOLD_LOW_TOWN_POLICE_STATION", cf, ( -4939.3, -6194.61, 473 ), ( 0, 2.16, 0 ), "cspf_2_auto13616119982007906281", undefined, "mine", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_merc_stronghold_cs";
    s.groupid = "traps";
    s.name = "mine";
    fe [[ f ]]( s, "MERC_STRONGHOLD_LOW_TOWN_POLICE_STATION", cf, ( -3609.29, -5222.41, 433 ), ( 0, 272.33, 0 ), "cspf_2_auto13616119982007906281", undefined, "mine", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_merc_stronghold_cs";
    s.groupid = "traps";
    s.name = "mine";
    fe [[ f ]]( s, "MERC_STRONGHOLD_LOW_TOWN_POLICE_STATION", cf, ( -4861.74, -5658.67, 793 ), ( 0, 2.16, 0 ), "cspf_2_auto13616119982007906281", undefined, "mine", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_merc_stronghold_cs";
    s.groupid = "traps";
    s.name = "sentry";
    fe [[ f ]]( s, "MERC_STRONGHOLD_LOW_TOWN_POLICE_STATION", cf, ( -5566.15, -5306.04, 425.79 ), ( 0, 120.21, 0 ), "cspf_2_auto13616119982007906281", undefined, "sentry_turret", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_merc_stronghold_cs";
    s.name = "vehicle";
    s.script_label = "vehicle";
    fe [[ f ]]( s, "MERC_STRONGHOLD_LOW_TOWN_POLICE_STATION", cf, ( -6209.22, -4802.15, 408.86 ), ( 0, 359.19, 0 ), "cspf_2_auto13616119982007906281", undefined, "veh_sat_medium_truck_ob", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_sat_avalon_city_ob_activity_merc_stronghold_cs
// Params 0
// Checksum 0xf75050b5, Offset: 0x1535
// Size: 0xe8
function function_d9dd7965c51c95d1()
{
    activityinstances = [];
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_activitydefinition_merc_stronghold";
    var_881289d7987bc770.cf = "mp_sat_avalon_city_ob_activity_merc_stronghold_cs";
    var_881289d7987bc770.scriptstructorigin = ( -4215.04, -5667.02, 1162.75 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [ ( -4486.41, -5695.33, 571.25 ) ];
    var_881289d7987bc770.var_31ce4477e3543d24 = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.locationradius = [ 1500 ];
    activityinstances[ "MERC_STRONGHOLD_LOW_TOWN_POLICE_STATION" ] = var_881289d7987bc770;
    return activityinstances;
}

