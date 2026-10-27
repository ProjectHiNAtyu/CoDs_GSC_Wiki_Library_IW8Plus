// script_89bec8671429e9c  (hash_089bec8671429e9c.gscc) (size: 15808 Bytes / 0x3dc0 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xe883674 (243807860)
// size ...... 15808 (0x3dc0)
// includes .. 4   (offset: 0x3568)
// strings ... 40  (offset: 0x3588)
// dev strs .. 0   (offset: 0x3dc0)
// exports ... 14  (offset: 0x303c)
// cseg ...... 0x497 + 0x2ba5 (0x303c)
// imports ... 27  (offset: 0x326c)
// animtree1 . 0   (offset: 0x3dc0)
// animtree2 . 0   (offset: 0x3dc0)
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace mp_sat_avalon_city_ob_activity_quarantine_zone_cs;

// Namespace mp_sat_avalon_city_ob_activity_quarantine_zone_cs
// Params 0, eflags: 0x5
// Checksum 0x904791c2, Offset: 0x4b5
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"mp_sat_avalon_city_ob_activity_quarantine_zone_cs", #"activity_common", &function_b39ecd3d51489472, undefined );
}

// Namespace mp_sat_avalon_city_ob_activity_quarantine_zone_cs
// Params 0, eflags: 0x4
// Checksum 0x123f7519, Offset: 0x4de
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace mp_sat_avalon_city_ob_activity_quarantine_zone_cs
// Params 0, eflags: 0x4
// Checksum 0x9704a6f5, Offset: 0x4ef
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace mp_sat_avalon_city_ob_activity_quarantine_zone_cs
// Params 2
// Checksum 0x9db09fd8, Offset: 0x500
// Size: 0x8c
function main( unused, unused2 )
{
    if ( utility::flag_exist( "mp_sat_avalon_city_ob_activity_quarantine_zone_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "mp_sat_avalon_city_ob_activity_quarantine_zone_cs" ) )
    {
        return;
    }
    
    activity_common::function_e1df676808c1d1e3( &function_4cd78e661617f3 );
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "mp_sat_avalon_city_ob_activity_quarantine_zone_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "mp_sat_avalon_city_ob_activity_quarantine_zone_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace mp_sat_avalon_city_ob_activity_quarantine_zone_cs
// Params 3, eflags: 0x4
// Checksum 0x1486123a, Offset: 0x594
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "mp_sat_avalon_city_ob_activity_quarantine_zone_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "mp_sat_avalon_city_ob_activity_quarantine_zone_cs" );
}

// Namespace mp_sat_avalon_city_ob_activity_quarantine_zone_cs
// Params 3, eflags: 0x4
// Checksum 0x1b91c45c, Offset: 0x60e
// Size: 0x1bf0
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_quarantine_zone_cs";
    s.activity_bundle = "sat_activitydef_quarantine_zone";
    s.name = "QUARANTINE_ZONE_CITY_TOWNHALL";
    fe [[ f ]]( s, "QUARANTINE_ZONE_CITY_TOWNHALL", cf, ( 1548.67, -761.76, 1220 ), ( 0, 150.25, 0 ), "activity_nexus_variant", "QUARANTINE_ZONE_CITY_TOWNHALL", undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_quarantine_zone_cs";
    fe [[ f ]]( s, "QUARANTINE_ZONE_CITY_TOWNHALL", cf, ( 1525.34, -708.98, 568.03 ), ( 0, 151, 0 ), "activity_nexus_spatial_zone", undefined, "OB_Spacer_Spatial_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 2000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_quarantine_zone_cs";
    s.groupid = "ai_encounter_spawnpoint";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "QUARANTINE_ZONE_CITY_TOWNHALL", cf, ( 1468.53, -543.55, 568 ), ( 0, 152.45, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_quarantine_zone_cs";
    s.groupid = "ai_encounter_spawnpoint";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "QUARANTINE_ZONE_CITY_TOWNHALL", cf, ( 1186.89, -761.18, 744 ), ( 0, 340.45, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_quarantine_zone_cs";
    s.groupid = "ai_encounter_spawnpoint";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "QUARANTINE_ZONE_CITY_TOWNHALL", cf, ( 1937.01, -513.48, 568 ), ( 0, 293.45, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_quarantine_zone_cs";
    s.groupid = "ai_encounter_spawnpoint";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "QUARANTINE_ZONE_CITY_TOWNHALL", cf, ( 1076.9, -983.04, 743 ), ( 0, 303.45, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_quarantine_zone_cs";
    s.groupid = "ai_encounter_spawnpoint";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "QUARANTINE_ZONE_CITY_TOWNHALL", cf, ( 922.04, -1128.77, 568 ), ( 0, 60.45, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_quarantine_zone_cs";
    s.groupid = "ai_encounter_spawnpoint";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "QUARANTINE_ZONE_CITY_TOWNHALL", cf, ( 1502.03, -242.48, 568 ), ( 0, 257.45, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_quarantine_zone_cs";
    s.groupid = "ai_encounter_spawnpoint";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "QUARANTINE_ZONE_CITY_TOWNHALL", cf, ( 1506.89, -1412.39, 568 ), ( 0, 63.45, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_quarantine_zone_cs";
    s.groupid = "ai_encounter_spawnpoint";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "QUARANTINE_ZONE_CITY_TOWNHALL", cf, ( 1465.78, -239.87, 744 ), ( 0, 331.45, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_quarantine_zone_cs";
    s.groupid = "ai_encounter_spawnpoint";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "QUARANTINE_ZONE_CITY_TOWNHALL", cf, ( 1138.17, -860.44, 568 ), ( 0, 63.45, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_quarantine_zone_cs";
    s.groupid = "ai_encounter_spawnpoint";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "QUARANTINE_ZONE_CITY_TOWNHALL", cf, ( 2004.43, -558.63, 744 ), ( 0, 147.45, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_quarantine_zone_cs";
    s.groupid = "ai_encounter_spawnpoint";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "QUARANTINE_ZONE_CITY_TOWNHALL", cf, ( 1977.6, -1038.68, 744 ), ( 0, 238.45, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_quarantine_zone_cs";
    s.groupid = "ai_encounter_spawnpoint";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "QUARANTINE_ZONE_CITY_TOWNHALL", cf, ( 1795.15, -1353.53, 744 ), ( 0, 69.45, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_quarantine_zone_cs";
    s.groupid = "ai_encounter_spawnpoint";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "QUARANTINE_ZONE_CITY_TOWNHALL", cf, ( 1227.47, -1262.62, 744 ), ( 0, 50.45, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_quarantine_zone_cs";
    s.groupid = "ai_encounter_spawnpoint";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "QUARANTINE_ZONE_CITY_TOWNHALL", cf, ( 1742.77, -1173.47, 568 ), ( 0, 129.45, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_quarantine_zone_cs";
    s.groupid = "amalgam_spawnpoint";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "nest_doppleghast_spawnpoint";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "QUARANTINE_ZONE_CITY_TOWNHALL", cf, ( 1301.27, -787.92, 744 ), ( 0, 343.22, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_quarantine_zone_cs";
    s.groupid = "amalgam_spawnpoint";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "nest_doppleghast_spawnpoint";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "QUARANTINE_ZONE_CITY_TOWNHALL", cf, ( 1734.7, -998.52, 744 ), ( 0, 152.24, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_quarantine_zone_cs";
    s.activity_bundle = "sat_activitydef_quarantine_zone";
    s.name = "QUARANTINE_ZONE_CITY_FIRE_STATION";
    fe [[ f ]]( s, "QUARANTINE_ZONE_CITY_FIRE_STATION", cf, ( 9113.1, -233.09, 1300.28 ), ( 0, 137.25, 0 ), "activity_nexus_variant", "QUARANTINE_ZONE_CITY_FIRE_STATION", undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_quarantine_zone_cs";
    fe [[ f ]]( s, "QUARANTINE_ZONE_CITY_FIRE_STATION", cf, ( 9128.25, -205.91, 742.55 ), ( 0, 138, 0 ), "activity_nexus_spatial_zone", undefined, "OB_Spacer_Spatial_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 2000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_quarantine_zone_cs";
    s.groupid = "ai_encounter_spawnpoint";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "QUARANTINE_ZONE_CITY_FIRE_STATION", cf, ( 9021.32, -426.01, 744 ), ( 0, 230.96, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_quarantine_zone_cs";
    s.groupid = "ai_encounter_spawnpoint";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "QUARANTINE_ZONE_CITY_FIRE_STATION", cf, ( 9609.76, -286.52, 743.88 ), ( 0, 225.96, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_quarantine_zone_cs";
    s.groupid = "ai_encounter_spawnpoint";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "QUARANTINE_ZONE_CITY_FIRE_STATION", cf, ( 8865.42, -250.35, 743.88 ), ( 0, 53.96, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_quarantine_zone_cs";
    s.groupid = "ai_encounter_spawnpoint";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "QUARANTINE_ZONE_CITY_FIRE_STATION", cf, ( 9311.68, 145.53, 743.88 ), ( 0, 307.96, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_quarantine_zone_cs";
    s.groupid = "ai_encounter_spawnpoint";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "QUARANTINE_ZONE_CITY_FIRE_STATION", cf, ( 9392.33, -411.74, 743.88 ), ( 0, 137.96, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_quarantine_zone_cs";
    s.groupid = "ai_encounter_spawnpoint";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "QUARANTINE_ZONE_CITY_FIRE_STATION", cf, ( 9414.07, -111.6, 920 ), ( 0, 195.96, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_quarantine_zone_cs";
    s.groupid = "ai_encounter_spawnpoint";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "QUARANTINE_ZONE_CITY_FIRE_STATION", cf, ( 9266.5, 213.5, 919.88 ), ( 0, 292.96, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_quarantine_zone_cs";
    s.groupid = "ai_encounter_spawnpoint";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "QUARANTINE_ZONE_CITY_FIRE_STATION", cf, ( 8886.39, -432.31, 920 ), ( 0, 9.96, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_quarantine_zone_cs";
    s.groupid = "ai_encounter_spawnpoint";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "QUARANTINE_ZONE_CITY_FIRE_STATION", cf, ( 8884.68, -713.36, 919.88 ), ( 0, 109.96, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_quarantine_zone_cs";
    s.groupid = "ai_encounter_spawnpoint";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "QUARANTINE_ZONE_CITY_FIRE_STATION", cf, ( 9587.66, 1.71, 743.88 ), ( 0, 129.96, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_quarantine_zone_cs";
    s.groupid = "ai_encounter_spawnpoint";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "QUARANTINE_ZONE_CITY_FIRE_STATION", cf, ( 8678.25, -508.5, 919.88 ), ( 0, 330.96, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_quarantine_zone_cs";
    s.groupid = "amalgam_spawn";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "nest_doppleghast_spawnpoint";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "QUARANTINE_ZONE_CITY_FIRE_STATION", cf, ( 9187.35, -378.21, 920 ), ( 0, 164.64, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_quarantine_zone_cs";
    s.groupid = "amalgam_spawn";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "nest_doppleghast_spawnpoint";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "QUARANTINE_ZONE_CITY_FIRE_STATION", cf, ( 8844.47, -363.68, 920 ), ( 0, 328.24, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_quarantine_zone_cs";
    s.groupid = "amalgam_spawn";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "nest_doppleghast_spawnpoint";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "QUARANTINE_ZONE_CITY_FIRE_STATION", cf, ( 8944.62, -538.17, 919.88 ), ( 0, 87.65, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace mp_sat_avalon_city_ob_activity_quarantine_zone_cs
// Params 0, eflags: 0x4
// Checksum 0x8a342b95, Offset: 0x2206
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace mp_sat_avalon_city_ob_activity_quarantine_zone_cs
// Params 0
// Checksum 0xd6d5cf77, Offset: 0x2210
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "mp_sat_avalon_city_ob_activity_quarantine_zone_cs" );
}

// Namespace mp_sat_avalon_city_ob_activity_quarantine_zone_cs
// Params 0
// Checksum 0x4a8d2029, Offset: 0x2226
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

// Namespace mp_sat_avalon_city_ob_activity_quarantine_zone_cs
// Params 4
// Checksum 0x217791e3, Offset: 0x2295
// Size: 0x71
function function_d4323822d7042e5a( var_4312b79c960726b6, fe, us, cf = "mp_sat_avalon_city_ob_activity_quarantine_zone_cs" )
{
    switch ( var_4312b79c960726b6 )
    {
        case #"hash_87212cf4500ec1ec":
            function_73d8d5bd57e41694( fe, us, cf );
            break;
        case #"hash_83410a7da21da284":
            function_c38c67d3a2e46b0c( fe, us, cf );
            break;
    }
}

// Namespace mp_sat_avalon_city_ob_activity_quarantine_zone_cs
// Params 3
// Checksum 0x4c1237ed, Offset: 0x230e
// Size: 0x5b3
function function_73d8d5bd57e41694( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_quarantine_zone_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s._size_max = ( 32, 82, 32 );
    s._size_min = ( 32, 86, 32 );
    s.groupid = "entrance_trigger";
    s.height = 128;
    s.length = "128";
    s.width = "128";
    fe [[ f ]]( s, "QUARANTINE_ZONE_CITY_TOWNHALL", cf, ( 1210, -399.75, 568 ), ( 0, 150, 0 ), "entrance_QUARANTINE_ZONE_CITY_TOWNHALL", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_quarantine_zone_cs";
    s.name = "master_struct";
    fe [[ f ]]( s, "QUARANTINE_ZONE_CITY_TOWNHALL", cf, ( 1538.71, -685.73, 568.03 ), ( 0, 151, 0 ), "QUARANTINE_ZONE_CITY_TOWNHALL_main", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_quarantine_zone_cs";
    fe [[ f ]]( s, "QUARANTINE_ZONE_CITY_TOWNHALL", cf, ( 1966.42, -793.65, 1220 ), ( 0, 148.5, 0 ), "QUARANTINE_ZONE_CITY_TOWNHALL", "cspf_3_auto14135615458493372089", "contract_activity_chain", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_quarantine_zone_cs";
    s.name = "safe_spawn_point";
    fe [[ f ]]( s, "QUARANTINE_ZONE_CITY_TOWNHALL", cf, ( 1269.79, -1056.06, 744 ), ( 0, 330.54, 0 ), undefined, "QUARANTINE_ZONE_CITY_TOWNHALL_main", "s_safe_spawn", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_quarantine_zone_cs";
    s.script_label = "SUPPLY_DROP_CITY_LOW_TOWN_TOWNHALL";
    fe [[ f ]]( s, "QUARANTINE_ZONE_CITY_TOWNHALL", cf, ( 1455.5, -492.59, 1220.57 ), ( 0, 148.5, 0 ), "cspf_3_auto14135615458493372089", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_quarantine_zone_cs";
    s.groupid = "amalgam_spawnpoint";
    fe [[ f ]]( s, "QUARANTINE_ZONE_CITY_TOWNHALL", cf, ( 1472.35, -984.74, 744 ), ( 0, 330, 0 ), "s_quarantine_zone_city_townhall_center", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_quarantine_zone_cs";
    s.groupid = "lock_door";
    fe [[ f ]]( s, "QUARANTINE_ZONE_CITY_TOWNHALL", cf, ( 1179.47, -379.45, 568 ), ( 0, 150.46, 0 ), undefined, "QUARANTINE_ZONE_CITY_TOWNHALL_main", "s_locked_door", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_quarantine_zone_cs";
    s.groupid = "lock_door";
    fe [[ f ]]( s, "QUARANTINE_ZONE_CITY_TOWNHALL", cf, ( 1890.79, -1270.12, 568 ), ( 0, 330.46, 0 ), undefined, "QUARANTINE_ZONE_CITY_TOWNHALL_main", "s_locked_door", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_quarantine_zone_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s.height = 650;
    fe [[ f ]]( s, "QUARANTINE_ZONE_CITY_TOWNHALL", cf, ( 1546.01, -878.97, 532.7 ), ( 1.32, 306.67, 2.49 ), "combat_volume_QUARANTINE_ZONE_CITY_TOWNHALL", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 1004 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_quarantine_zone_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s._size_max = ( 40, 128, 32 );
    s._size_min = ( 32, 142, 32 );
    s.groupid = "entrance_trigger";
    s.height = 128;
    s.length = "128";
    s.width = "128";
    fe [[ f ]]( s, "QUARANTINE_ZONE_CITY_TOWNHALL", cf, ( 1855.14, -1248.64, 568 ), ( 0, 330, 0 ), "entrance_QUARANTINE_ZONE_CITY_TOWNHALL", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_sat_avalon_city_ob_activity_quarantine_zone_cs
// Params 3
// Checksum 0xafc1e5af, Offset: 0x28c9
// Size: 0x5b3
function function_c38c67d3a2e46b0c( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_quarantine_zone_cs";
    s.name = "master_struct";
    fe [[ f ]]( s, "QUARANTINE_ZONE_CITY_FIRE_STATION", cf, ( 9146.5, -186.26, 742.55 ), ( 0, 138, 0 ), "QUARANTINE_ZONE_CITY_FIRE_STATION_main", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_quarantine_zone_cs";
    s.groupid = "lock_door";
    fe [[ f ]]( s, "QUARANTINE_ZONE_CITY_FIRE_STATION", cf, ( 8809.09, -665.63, 744.25 ), ( 0, 227.99, 0 ), undefined, "QUARANTINE_ZONE_CITY_FIRE_STATION_main", "s_locked_door", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_quarantine_zone_cs";
    fe [[ f ]]( s, "QUARANTINE_ZONE_CITY_FIRE_STATION", cf, ( 9538.98, -387.63, 1394.52 ), ( 0, 135.5, 0 ), "QUARANTINE_ZONE_CITY_FIRE_STATION", "cspf_4_auto14135615458493372089", "contract_activity_chain", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_quarantine_zone_cs";
    s.script_label = "SUPPLY_DROP_CITY_LOW_TOWN_FIRESTATION";
    fe [[ f ]]( s, "QUARANTINE_ZONE_CITY_FIRE_STATION", cf, ( 9108.87, 20.64, 1395.09 ), ( 0, 135.5, 0 ), "cspf_4_auto14135615458493372089", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_quarantine_zone_cs";
    s.groupid = "lock_door";
    fe [[ f ]]( s, "QUARANTINE_ZONE_CITY_FIRE_STATION", cf, ( 9341.54, 313.06, 744.31 ), ( 0, 47.99, 0 ), undefined, "QUARANTINE_ZONE_CITY_FIRE_STATION_main", "s_locked_door", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_quarantine_zone_cs";
    s.name = "safe_spawn_point";
    fe [[ f ]]( s, "QUARANTINE_ZONE_CITY_FIRE_STATION", cf, ( 8961.38, -260.24, 920 ), ( 0, 227.97, 0 ), undefined, "QUARANTINE_ZONE_CITY_FIRE_STATION_main", "s_safe_spawn", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_quarantine_zone_cs";
    s.groupid = "amalgam_spawn";
    fe [[ f ]]( s, "QUARANTINE_ZONE_CITY_FIRE_STATION", cf, ( 8976.53, -410.01, 920 ), ( 0, 64.84, 0 ), "s_quarantine_zone_city_fire_station_center", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_quarantine_zone_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s._size_max = ( 32, 122, 32 );
    s._size_min = ( 32, 118, 32 );
    s.groupid = "entrance_trigger";
    s.height = 128;
    s.length = "128";
    s.width = "128";
    fe [[ f ]]( s, "QUARANTINE_ZONE_CITY_FIRE_STATION", cf, ( 8831.57, -640.41, 744 ), ( 0, 228, 0 ), "entrance_QUARANTINE_ZONE_CITY_FIRE_STATION", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_quarantine_zone_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s.height = 650;
    fe [[ f ]]( s, "QUARANTINE_ZONE_CITY_FIRE_STATION", cf, ( 9173.5, -258.5, 744 ), ( 0, 0, 0 ), "combat_volume_QUARANTINE_ZONE_CITY_FIRE_STATION", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 824 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_quarantine_zone_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s._size_max = ( 40, 128, 32 );
    s._size_min = ( 32, 204, 32 );
    s.groupid = "entrance_trigger";
    s.height = 128;
    s.length = "128";
    s.width = "128";
    fe [[ f ]]( s, "QUARANTINE_ZONE_CITY_FIRE_STATION", cf, ( 9344.49, 273.18, 744 ), ( 0, 48, 0 ), "entrance_QUARANTINE_ZONE_CITY_FIRE_STATION", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_sat_avalon_city_ob_activity_quarantine_zone_cs
// Params 0
// Checksum 0xdeb52f3b, Offset: 0x2e84
// Size: 0x1b7
function function_d9dd7965c51c95d1()
{
    activityinstances = [];
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_activitydef_quarantine_zone";
    var_881289d7987bc770.cf = "mp_sat_avalon_city_ob_activity_quarantine_zone_cs";
    var_881289d7987bc770.scriptstructorigin = ( 1548.67, -761.76, 1220 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [ ( 1507.63, -739.41, 568.03 ) ];
    var_881289d7987bc770.var_31ce4477e3543d24 = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.locationradius = [ 900 ];
    activityinstances[ "QUARANTINE_ZONE_CITY_TOWNHALL" ] = var_881289d7987bc770;
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_activitydef_quarantine_zone";
    var_881289d7987bc770.cf = "mp_sat_avalon_city_ob_activity_quarantine_zone_cs";
    var_881289d7987bc770.scriptstructorigin = ( 9113.1, -233.09, 1300.28 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [ ( 9104.14, -231.58, 742.55 ) ];
    var_881289d7987bc770.var_31ce4477e3543d24 = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.locationradius = [ 900 ];
    activityinstances[ "QUARANTINE_ZONE_CITY_FIRE_STATION" ] = var_881289d7987bc770;
    return activityinstances;
}

