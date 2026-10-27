// script_6238c25d3df6c868  (hash_6238c25d3df6c868.gscc) (size: 8729 Bytes / 0x2219 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xa662ba12 (2791488018)
// size ...... 8729 (0x2219)
// includes .. 4   (offset: 0x1db9)
// strings ... 32  (offset: 0x1dd9)
// dev strs .. 0   (offset: 0x2219)
// exports ... 13  (offset: 0x18d5)
// cseg ...... 0x363 + 0x1572 (0x18d5)
// imports ... 26  (offset: 0x1add)
// animtree1 . 0   (offset: 0x2219)
// animtree2 . 0   (offset: 0x2219)
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace mp_sat_avalon_quad_04_ob_activity_quarantine_zone_cs;

// Namespace mp_sat_avalon_quad_04_ob_activity_quarantine_zone_cs
// Params 0, eflags: 0x5
// Checksum 0x9e249b12, Offset: 0x381
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"mp_sat_avalon_quad_04_ob_activity_quarantine_zone_cs", #"activity_common", &function_b39ecd3d51489472, undefined );
}

// Namespace mp_sat_avalon_quad_04_ob_activity_quarantine_zone_cs
// Params 0, eflags: 0x4
// Checksum 0x1e77d4d0, Offset: 0x3aa
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace mp_sat_avalon_quad_04_ob_activity_quarantine_zone_cs
// Params 0, eflags: 0x4
// Checksum 0x9b4c073c, Offset: 0x3bb
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace mp_sat_avalon_quad_04_ob_activity_quarantine_zone_cs
// Params 2
// Checksum 0x7fed41b3, Offset: 0x3cc
// Size: 0x8c
function main( unused, unused2 )
{
    if ( utility::flag_exist( "mp_sat_avalon_quad_04_ob_activity_quarantine_zone_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "mp_sat_avalon_quad_04_ob_activity_quarantine_zone_cs" ) )
    {
        return;
    }
    
    activity_common::function_e1df676808c1d1e3( &function_4cd78e661617f3 );
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "mp_sat_avalon_quad_04_ob_activity_quarantine_zone_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "mp_sat_avalon_quad_04_ob_activity_quarantine_zone_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace mp_sat_avalon_quad_04_ob_activity_quarantine_zone_cs
// Params 3, eflags: 0x4
// Checksum 0x18ceb3f3, Offset: 0x460
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "mp_sat_avalon_quad_04_ob_activity_quarantine_zone_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "mp_sat_avalon_quad_04_ob_activity_quarantine_zone_cs" );
}

// Namespace mp_sat_avalon_quad_04_ob_activity_quarantine_zone_cs
// Params 3, eflags: 0x4
// Checksum 0x7b67a989, Offset: 0x4da
// Size: 0xc61
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_04_ob_activity_quarantine_zone_cs";
    s.groupid = "ai_encounter_spawnpoint";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "QUARANTINE_ZONE_Q4_FIRE_STATION", cf, ( 34188.5, -37560.9, 1090.5 ), ( 0, 183.43, -0.07 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_04_ob_activity_quarantine_zone_cs";
    s.groupid = "ai_encounter_spawnpoint";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "QUARANTINE_ZONE_Q4_FIRE_STATION", cf, ( 34161.3, -37851.8, 1090.5 ), ( 0.03, 27.43, -0.07 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_04_ob_activity_quarantine_zone_cs";
    s.activity_bundle = "sat_activitydef_quarantine_zone";
    s.name = "QUARANTINE_ZONE_Q4_FIRE_STATION";
    fe [[ f ]]( s, "QUARANTINE_ZONE_Q4_FIRE_STATION", cf, ( 34377.3, -37500.4, 1646.58 ), ( 0, 90, 0 ), "activity_nexus_variant", "QUARANTINE_ZONE_Q4_FIRE_STATION", undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_04_ob_activity_quarantine_zone_cs";
    fe [[ f ]]( s, "QUARANTINE_ZONE_Q4_FIRE_STATION", cf, ( 34407.5, -37492.7, 1088.85 ), ( 0, 90, 0 ), "activity_nexus_spatial_zone", undefined, "OB_Spacer_Spatial_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 2000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_04_ob_activity_quarantine_zone_cs";
    s.groupid = "ai_encounter_spawnpoint";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "QUARANTINE_ZONE_Q4_FIRE_STATION", cf, ( 34644.4, -37899.8, 1090.5 ), ( 0, 178.43, 0.07 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_04_ob_activity_quarantine_zone_cs";
    s.groupid = "ai_encounter_spawnpoint";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "QUARANTINE_ZONE_Q4_FIRE_STATION", cf, ( 34168.5, -37326.3, 1090.5 ), ( 0.01, 6.43, -0.07 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_04_ob_activity_quarantine_zone_cs";
    s.groupid = "ai_encounter_spawnpoint";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "QUARANTINE_ZONE_Q4_FIRE_STATION", cf, ( 34784.4, -37371.6, 1090.5 ), ( 359.93, 260.43, 0.01 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_04_ob_activity_quarantine_zone_cs";
    s.groupid = "ai_encounter_spawnpoint";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "QUARANTINE_ZONE_Q4_FIRE_STATION", cf, ( 34815.6, -37677.1, 1266.5 ), ( 360, 183.43, 0.07 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_04_ob_activity_quarantine_zone_cs";
    s.groupid = "ai_encounter_spawnpoint";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "QUARANTINE_ZONE_Q4_FIRE_STATION", cf, ( 34890.5, -37293.8, 1266.5 ), ( 359.93, 224.43, 0.03 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_04_ob_activity_quarantine_zone_cs";
    s.groupid = "ai_encounter_spawnpoint";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "QUARANTINE_ZONE_Q4_FIRE_STATION", cf, ( 34040.4, -37535.3, 1266.5 ), ( 359.93, 3.43, -0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_04_ob_activity_quarantine_zone_cs";
    s.groupid = "ai_encounter_spawnpoint";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "QUARANTINE_ZONE_Q4_FIRE_STATION", cf, ( 33849, -37680.2, 1266.5 ), ( 0.06, 62.43, -0.04 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_04_ob_activity_quarantine_zone_cs";
    s.groupid = "ai_encounter_spawnpoint";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "QUARANTINE_ZONE_Q4_FIRE_STATION", cf, ( 34842, -37688.9, 1090.5 ), ( 0.07, 82.43, -0.01 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_04_ob_activity_quarantine_zone_cs";
    s.groupid = "ai_encounter_spawnpoint";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "QUARANTINE_ZONE_Q4_FIRE_STATION", cf, ( 33880.7, -37277.3, 1266.5 ), ( 359.93, 283.43, -0.02 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_04_ob_activity_quarantine_zone_cs";
    s.groupid = "amalgam_spawn";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "nest_doppleghast_spawnpoint";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "QUARANTINE_ZONE_Q4_FIRE_STATION", cf, ( 34776.4, -37363.2, 1266.5 ), ( 0.07, 270.01, 0.03 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_04_ob_activity_quarantine_zone_cs";
    s.groupid = "amalgam_spawn";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "nest_doppleghast_spawnpoint";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "QUARANTINE_ZONE_Q4_FIRE_STATION", cf, ( 34557.2, -37568.3, 1266.5 ), ( 359.93, 19.3, -0.01 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace mp_sat_avalon_quad_04_ob_activity_quarantine_zone_cs
// Params 0, eflags: 0x4
// Checksum 0x6869f5fe, Offset: 0x1143
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace mp_sat_avalon_quad_04_ob_activity_quarantine_zone_cs
// Params 0
// Checksum 0xda9d6ebe, Offset: 0x114d
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "mp_sat_avalon_quad_04_ob_activity_quarantine_zone_cs" );
}

// Namespace mp_sat_avalon_quad_04_ob_activity_quarantine_zone_cs
// Params 0
// Checksum 0x46c581e0, Offset: 0x1163
// Size: 0x66
function function_4cd78e661617f3()
{
    activityinfostruct = {};
    activityinfostruct.name = "REV_OB_QUARANTINE_ZONE";
    activityinfostruct.scriptbundle = "sat_activitydef_quarantine_zone";
    activityinfostruct.mainfunction = &main;
    activityinfostruct.var_934f068483ae4ddb = &function_d4323822d7042e5a;
    activityinfostruct.metadatafunction = &function_d9dd7965c51c95d1;
    return activityinfostruct;
}

// Namespace mp_sat_avalon_quad_04_ob_activity_quarantine_zone_cs
// Params 4
// Checksum 0x2789fc55, Offset: 0x11d2
// Size: 0x57
function function_d4323822d7042e5a( var_4312b79c960726b6, fe, us, cf = "mp_sat_avalon_quad_04_ob_activity_quarantine_zone_cs" )
{
    switch ( var_4312b79c960726b6 )
    {
        case #"hash_a5a20b199c483b1a":
            function_73c879c80e8f8482( fe, us, cf );
            break;
    }
}

// Namespace mp_sat_avalon_quad_04_ob_activity_quarantine_zone_cs
// Params 3
// Checksum 0x6c0a0308, Offset: 0x1231
// Size: 0x5b3
function function_73c879c80e8f8482( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_04_ob_activity_quarantine_zone_cs";
    s.name = "master_struct";
    fe [[ f ]]( s, "QUARANTINE_ZONE_Q4_FIRE_STATION", cf, ( 34434.3, -37492.4, 1088.85 ), ( 0, 90, 0 ), "QUARANTINE_ZONE_Q4_FIRE_STATION_main", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_04_ob_activity_quarantine_zone_cs";
    fe [[ f ]]( s, "QUARANTINE_ZONE_Q4_FIRE_STATION", cf, ( 34558.8, -37915.6, 1740.82 ), ( 0, 90, 0 ), "QUARANTINE_ZONE_Q4_FIRE_STATION", "cspf_2_auto14135615458493372089", "contract_activity_chain", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_04_ob_activity_quarantine_zone_cs";
    s.script_label = "SUPPLY_DROP_Q4_FLATS_FIRE_STATION";
    fe [[ f ]]( s, "QUARANTINE_ZONE_Q4_FIRE_STATION", cf, ( 34558.3, -37322.5, 1741.39 ), ( 0, 90, 0 ), "cspf_2_auto14135615458493372089", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_04_ob_activity_quarantine_zone_cs";
    s.name = "safe_spawn_point";
    fe [[ f ]]( s, "QUARANTINE_ZONE_Q4_FIRE_STATION", cf, ( 33953.6, -37526.9, 1266.5 ), ( 0, 360, 0 ), undefined, "QUARANTINE_ZONE_Q4_FIRE_STATION_main", "s_safe_spawn", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_04_ob_activity_quarantine_zone_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s._size_max = ( 32, 114, 32 );
    s._size_min = ( 32, 110, 32 );
    s.groupid = "entrance_trigger";
    s.height = 128;
    s.length = "128";
    s.width = "128";
    fe [[ f ]]( s, "QUARANTINE_ZONE_Q4_FIRE_STATION", cf, ( 33879.9, -37564.2, 1090.5 ), ( 0, 180, 0 ), "entrance_QUARANTINE_ZONE_Q4_FIRE_STATION", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_04_ob_activity_quarantine_zone_cs";
    s.groupid = "amalgam_spawn";
    fe [[ f ]]( s, "QUARANTINE_ZONE_Q4_FIRE_STATION", cf, ( 34518.5, -37450.3, 1266.5 ), ( 0, 330, 0 ), "s_quarantine_zone_q4_fire_station_center", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_04_ob_activity_quarantine_zone_cs";
    s.groupid = "lock_door";
    fe [[ f ]]( s, "QUARANTINE_ZONE_Q4_FIRE_STATION", cf, ( 33846.3, -37563.3, 1090.75 ), ( 0, 180, 0 ), undefined, "QUARANTINE_ZONE_Q4_FIRE_STATION_main", "s_locked_door", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_04_ob_activity_quarantine_zone_cs";
    s.groupid = "lock_door";
    fe [[ f ]]( s, "QUARANTINE_ZONE_Q4_FIRE_STATION", cf, ( 34935.6, -37306.2, 1096.23 ), ( 0, 0, 0 ), undefined, "QUARANTINE_ZONE_Q4_FIRE_STATION_main", "s_locked_door", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_04_ob_activity_quarantine_zone_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s._size_max = ( 40, 128, 32 );
    s._size_min = ( 32, 204, 32 );
    s.groupid = "entrance_trigger";
    s.height = 128;
    s.length = "128";
    s.width = "128";
    fe [[ f ]]( s, "QUARANTINE_ZONE_Q4_FIRE_STATION", cf, ( 34893.4, -37333.8, 1090.5 ), ( 0, 360, 0 ), "entrance_QUARANTINE_ZONE_Q4_FIRE_STATION", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_04_ob_activity_quarantine_zone_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s.height = 650;
    fe [[ f ]]( s, "QUARANTINE_ZONE_Q4_FIRE_STATION", cf, ( 34369.9, -37541.3, 1079.25 ), ( 0, 360, 0 ), "combat_volume_QUARANTINE_ZONE_Q4_FIRE_STATION", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 812 );
}

// Namespace mp_sat_avalon_quad_04_ob_activity_quarantine_zone_cs
// Params 0
// Checksum 0x7791d56c, Offset: 0x17ec
// Size: 0xe8
function function_d9dd7965c51c95d1()
{
    activityinstances = [];
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_activitydef_quarantine_zone";
    var_881289d7987bc770.cf = "mp_sat_avalon_quad_04_ob_activity_quarantine_zone_cs";
    var_881289d7987bc770.scriptstructorigin = ( 34377.3, -37500.4, 1646.58 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [ ( 34372.3, -37492.9, 1088.85 ) ];
    var_881289d7987bc770.var_31ce4477e3543d24 = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.locationradius = [ 900 ];
    activityinstances[ "QUARANTINE_ZONE_Q4_FIRE_STATION" ] = var_881289d7987bc770;
    return activityinstances;
}

