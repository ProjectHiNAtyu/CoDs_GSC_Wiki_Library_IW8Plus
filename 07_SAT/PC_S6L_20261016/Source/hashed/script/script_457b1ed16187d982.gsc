// script_457b1ed16187d982  (hash_457b1ed16187d982.gscc) (size: 13906 Bytes / 0x3652 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x63e45516 (1675908374)
// size ...... 13906 (0x3652)
// includes .. 4   (offset: 0x2f2a)
// strings ... 38  (offset: 0x2f4a)
// dev strs .. 0   (offset: 0x3652)
// exports ... 14  (offset: 0x29fe)
// cseg ...... 0x455 + 0x25a9 (0x29fe)
// imports ... 27  (offset: 0x2c2e)
// animtree1 . 0   (offset: 0x3652)
// animtree2 . 0   (offset: 0x3652)
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace mp_sat_avalon_quad_03_ob_activity_quarantine_zone_cs;

// Namespace mp_sat_avalon_quad_03_ob_activity_quarantine_zone_cs
// Params 0, eflags: 0x5
// Checksum 0x173dfe67, Offset: 0x473
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"mp_sat_avalon_quad_03_ob_activity_quarantine_zone_cs", #"activity_common", &function_b39ecd3d51489472, undefined );
}

// Namespace mp_sat_avalon_quad_03_ob_activity_quarantine_zone_cs
// Params 0, eflags: 0x4
// Checksum 0xb15f9d5a, Offset: 0x49c
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace mp_sat_avalon_quad_03_ob_activity_quarantine_zone_cs
// Params 0, eflags: 0x4
// Checksum 0x34644eb6, Offset: 0x4ad
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace mp_sat_avalon_quad_03_ob_activity_quarantine_zone_cs
// Params 2
// Checksum 0x68501aac, Offset: 0x4be
// Size: 0x8c
function main( unused, unused2 )
{
    if ( utility::flag_exist( "mp_sat_avalon_quad_03_ob_activity_quarantine_zone_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "mp_sat_avalon_quad_03_ob_activity_quarantine_zone_cs" ) )
    {
        return;
    }
    
    activity_common::function_e1df676808c1d1e3( &function_4cd78e661617f3 );
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "mp_sat_avalon_quad_03_ob_activity_quarantine_zone_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "mp_sat_avalon_quad_03_ob_activity_quarantine_zone_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace mp_sat_avalon_quad_03_ob_activity_quarantine_zone_cs
// Params 3, eflags: 0x4
// Checksum 0xb7e6fa79, Offset: 0x552
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "mp_sat_avalon_quad_03_ob_activity_quarantine_zone_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "mp_sat_avalon_quad_03_ob_activity_quarantine_zone_cs" );
}

// Namespace mp_sat_avalon_quad_03_ob_activity_quarantine_zone_cs
// Params 3, eflags: 0x4
// Checksum 0x34729e1d, Offset: 0x5cc
// Size: 0x15f4
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_quarantine_zone_cs";
    s.activity_bundle = "sat_activitydef_quarantine_zone";
    s.name = "QUARANTINE_ZONE_Q3_FIRE_STATION";
    fe [[ f ]]( s, "QUARANTINE_ZONE_Q3_FIRE_STATION", cf, ( -4148.49, -30060.2, 852 ), ( 0.07, 270.43, -0 ), "activity_nexus_variant", "QUARANTINE_ZONE_Q3_FIRE_STATION", undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_quarantine_zone_cs";
    s.groupid = "ai_encounter_spawnpoint";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "QUARANTINE_ZONE_Q3_FIRE_STATION", cf, ( -3928.15, -29996.7, 292 ), ( 0, 183.43, -0.07 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_quarantine_zone_cs";
    s.groupid = "ai_encounter_spawnpoint";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "QUARANTINE_ZONE_Q3_FIRE_STATION", cf, ( -4469.48, -29659.1, 292 ), ( 0, 358.43, 0.07 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_quarantine_zone_cs";
    s.groupid = "ai_encounter_spawnpoint";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "QUARANTINE_ZONE_Q3_FIRE_STATION", cf, ( -3993.57, -30232.6, 292 ), ( 0.01, 186.43, -0.07 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_quarantine_zone_cs";
    s.groupid = "ai_encounter_spawnpoint";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "QUARANTINE_ZONE_Q3_FIRE_STATION", cf, ( -4586.91, -30170.7, 292 ), ( 359.93, 80.43, 0.01 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_quarantine_zone_cs";
    s.groupid = "ai_encounter_spawnpoint";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "QUARANTINE_ZONE_Q3_FIRE_STATION", cf, ( -4230.31, -29734.9, 292 ), ( 0.07, 270.43, -0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_quarantine_zone_cs";
    s.groupid = "ai_encounter_spawnpoint";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "QUARANTINE_ZONE_Q3_FIRE_STATION", cf, ( -4474.73, -29907.7, 468 ), ( 360, 3.43, 0.07 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_quarantine_zone_cs";
    s.groupid = "ai_encounter_spawnpoint";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "QUARANTINE_ZONE_Q3_FIRE_STATION", cf, ( -4606.53, -30250.1, 468 ), ( 359.93, 65.43, 0.03 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_quarantine_zone_cs";
    s.groupid = "ai_encounter_spawnpoint";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "QUARANTINE_ZONE_Q3_FIRE_STATION", cf, ( -3865.5, -30089.2, 468 ), ( 359.93, 157.43, -0.01 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_quarantine_zone_cs";
    s.groupid = "ai_encounter_spawnpoint";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "QUARANTINE_ZONE_Q3_FIRE_STATION", cf, ( -3665.05, -29905.9, 468 ), ( 0.06, 242.43, -0.04 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_quarantine_zone_cs";
    s.groupid = "ai_encounter_spawnpoint";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "QUARANTINE_ZONE_Q3_FIRE_STATION", cf, ( -4667.16, -29870, 292 ), ( 0.07, 262.43, -0.01 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_quarantine_zone_cs";
    s.groupid = "ai_encounter_spawnpoint";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "QUARANTINE_ZONE_Q3_FIRE_STATION", cf, ( -3676.78, -30196.5, 468 ), ( 359.93, 103.43, -0.02 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_quarantine_zone_cs";
    s.groupid = "amalgam_spawn";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "nest_doppleghast_spawnpoint";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "QUARANTINE_ZONE_Q3_FIRE_STATION", cf, ( -4115.68, -29886.1, 468 ), ( 0.07, 297.11, 0.03 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_quarantine_zone_cs";
    s.groupid = "amalgam_spawn";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "nest_doppleghast_spawnpoint";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "QUARANTINE_ZONE_Q3_FIRE_STATION", cf, ( -3878.73, -30224.2, 468 ), ( 359.93, 100.7, -0.01 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_quarantine_zone_cs";
    s.groupid = "amalgam_spawn";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "nest_doppleghast_spawnpoint";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "QUARANTINE_ZONE_Q3_FIRE_STATION", cf, ( -3834.74, -29980, 468 ), ( 0.05, 220.12, -0.06 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_quarantine_zone_cs";
    fe [[ f ]]( s, "QUARANTINE_ZONE_Q3_FIRE_STATION", cf, ( -4204.27, -30040, 292 ), ( 0.07, 270.43, -0 ), "activity_nexus_spatial_zone", undefined, "OB_Spacer_Spatial_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 2000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_quarantine_zone_cs";
    s.activity_bundle = "sat_activitydef_quarantine_zone";
    s.name = "QUARANTINE_ZONE_Q3_FIRING_RANGE";
    fe [[ f ]]( s, "QUARANTINE_ZONE_Q3_FIRING_RANGE", cf, ( -29457.7, -30185.2, 1413.06 ), ( 0, 140.25, 0 ), "activity_nexus_variant", "QUARANTINE_ZONE_Q3_FIRING_RANGE", undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_quarantine_zone_cs";
    fe [[ f ]]( s, "QUARANTINE_ZONE_Q3_FIRING_RANGE", cf, ( -29400.9, -30177.8, 921.06 ), ( 0, 141, 0 ), "activity_nexus_spatial_zone", undefined, "OB_Spacer_Spatial_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 2000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_quarantine_zone_cs";
    s.groupid = "ai_encounter_spawnpoint";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "QUARANTINE_ZONE_Q3_FIRING_RANGE", cf, ( -29431.3, -29543.4, 918.5 ), ( 0, 142.23, -0.07 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_quarantine_zone_cs";
    s.groupid = "ai_encounter_spawnpoint";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "QUARANTINE_ZONE_Q3_FIRING_RANGE", cf, ( -29271.2, -29869.5, 918.5 ), ( 0, 3.51, 0.07 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_quarantine_zone_cs";
    s.groupid = "ai_encounter_spawnpoint";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "QUARANTINE_ZONE_Q3_FIRING_RANGE", cf, ( -28953.5, -29881.5, 918.5 ), ( 0.01, 186.43, -0.07 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_quarantine_zone_cs";
    s.groupid = "ai_encounter_spawnpoint";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "QUARANTINE_ZONE_Q3_FIRING_RANGE", cf, ( -29186, -30478.1, 918.5 ), ( 359.95, 140.81, -0.05 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_quarantine_zone_cs";
    s.groupid = "ai_encounter_spawnpoint";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "QUARANTINE_ZONE_Q3_FIRING_RANGE", cf, ( -29369.8, -30252, 918.5 ), ( 359.97, 234.39, -0.07 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_quarantine_zone_cs";
    s.groupid = "ai_encounter_spawnpoint";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "QUARANTINE_ZONE_Q3_FIRING_RANGE", cf, ( -29737.7, -30396.3, 918.5 ), ( 359.93, 292.28, 0.03 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_quarantine_zone_cs";
    s.groupid = "ai_encounter_spawnpoint";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "QUARANTINE_ZONE_Q3_FIRING_RANGE", cf, ( -30245.6, -30191.3, 918.5 ), ( 359.93, 141.68, -0.01 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_quarantine_zone_cs";
    s.groupid = "ai_encounter_spawnpoint";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "QUARANTINE_ZONE_Q3_FIRING_RANGE", cf, ( -29791, -30745.5, 918.5 ), ( 0.05, 46.26, 0.05 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_quarantine_zone_cs";
    s.groupid = "amalgam_spawn";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "nest_doppleghast_spawnpoint";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "QUARANTINE_ZONE_Q3_FIRING_RANGE", cf, ( -29172.7, -29968.6, 918.5 ), ( 359.93, 319.93, -0.01 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace mp_sat_avalon_quad_03_ob_activity_quarantine_zone_cs
// Params 0, eflags: 0x4
// Checksum 0x7fd4aee1, Offset: 0x1bc8
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace mp_sat_avalon_quad_03_ob_activity_quarantine_zone_cs
// Params 0
// Checksum 0x75b52734, Offset: 0x1bd2
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "mp_sat_avalon_quad_03_ob_activity_quarantine_zone_cs" );
}

// Namespace mp_sat_avalon_quad_03_ob_activity_quarantine_zone_cs
// Params 0
// Checksum 0xe9edc86a, Offset: 0x1be8
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

// Namespace mp_sat_avalon_quad_03_ob_activity_quarantine_zone_cs
// Params 4
// Checksum 0x43697fc5, Offset: 0x1c57
// Size: 0x71
function function_d4323822d7042e5a( var_4312b79c960726b6, fe, us, cf = "mp_sat_avalon_quad_03_ob_activity_quarantine_zone_cs" )
{
    switch ( var_4312b79c960726b6 )
    {
        case #"hash_8dcfdb736df79f61":
            function_d56a7b45e28b2be9( fe, us, cf );
            break;
        case #"hash_e49897d62127c1a7":
            function_dfc300913bd899ef( fe, us, cf );
            break;
    }
}

// Namespace mp_sat_avalon_quad_03_ob_activity_quarantine_zone_cs
// Params 3
// Checksum 0x2d56b2e9, Offset: 0x1cd0
// Size: 0x5b3
function function_d56a7b45e28b2be9( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_quarantine_zone_cs";
    s.groupid = "amalgam_spawn";
    fe [[ f ]]( s, "QUARANTINE_ZONE_Q3_FIRE_STATION", cf, ( -3955.2, -30042.5, 468 ), ( 0, 196.88, 0 ), "s_quarantine_zone_q3_fire_station_center", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_quarantine_zone_cs";
    s.groupid = "lock_door";
    fe [[ f ]]( s, "QUARANTINE_ZONE_Q3_FIRE_STATION", cf, ( -3650.51, -29994.4, 292.25 ), ( 0, 0, 0 ), undefined, "QUARANTINE_ZONE_Q3_FIRE_STATION_main", "s_locked_door", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_quarantine_zone_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s._size_max = ( 32, 122, 32 );
    s._size_min = ( 32, 118, 32 );
    s.groupid = "entrance_trigger";
    s.height = 128;
    s.length = "128";
    s.width = "128";
    fe [[ f ]]( s, "QUARANTINE_ZONE_Q3_FIRE_STATION", cf, ( -3684.11, -29995.2, 292 ), ( 0, 360, 0 ), "entrance_QUARANTINE_ZONE_Q3_FIRE_STATION", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_quarantine_zone_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s._size_max = ( 40, 128, 32 );
    s._size_min = ( 32, 204, 32 );
    s.groupid = "entrance_trigger";
    s.height = 128;
    s.length = "128";
    s.width = "128";
    fe [[ f ]]( s, "QUARANTINE_ZONE_Q3_FIRE_STATION", cf, ( -4691.67, -30226.7, 292 ), ( 0, 180, 0 ), "entrance_QUARANTINE_ZONE_Q3_FIRE_STATION", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_quarantine_zone_cs";
    s.name = "master_struct";
    fe [[ f ]]( s, "QUARANTINE_ZONE_Q3_FIRE_STATION", cf, ( -4267.42, -30038.5, 292.11 ), ( 0.07, 270.43, -0 ), "QUARANTINE_ZONE_Q3_FIRE_STATION_main", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_quarantine_zone_cs";
    s.name = "safe_spawn_point";
    fe [[ f ]]( s, "QUARANTINE_ZONE_Q3_FIRE_STATION", cf, ( -4052.69, -30152.8, 468 ), ( 0, 0, 0 ), undefined, "QUARANTINE_ZONE_Q3_FIRE_STATION_main", "s_safe_spawn", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_quarantine_zone_cs";
    fe [[ f ]]( s, "QUARANTINE_ZONE_Q3_FIRE_STATION", cf, ( -4940.59, -30056.1, 288 ), ( 0, 0.43, 0.07 ), "QUARANTINE_ZONE_Q3_FIRE_STATION", "cspf_3_auto14135615458493372089", "contract_activity_chain", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_quarantine_zone_cs";
    s.script_label = "SUPPLY_DROP_Q3_FLATS_FIRE_STATION";
    fe [[ f ]]( s, "QUARANTINE_ZONE_Q3_FIRE_STATION", cf, ( -4347.79, -30041.2, 794.11 ), ( 0, 0.43, 0.07 ), "cspf_3_auto14135615458493372089", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_quarantine_zone_cs";
    s.groupid = "lock_door";
    fe [[ f ]]( s, "QUARANTINE_ZONE_Q3_FIRE_STATION", cf, ( -4732.87, -30254.7, 295.69 ), ( 0, 180, 0 ), undefined, "QUARANTINE_ZONE_Q3_FIRE_STATION_main", "s_locked_door", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_quarantine_zone_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s.height = 650;
    fe [[ f ]]( s, "QUARANTINE_ZONE_Q3_FIRE_STATION", cf, ( -4170, -30056, 283.5 ), ( 0, 0, 0 ), "combat_volume_QUARANTINE_ZONE_Q3_FIRE_STATION", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 796 );
}

// Namespace mp_sat_avalon_quad_03_ob_activity_quarantine_zone_cs
// Params 3
// Checksum 0xe1038587, Offset: 0x228b
// Size: 0x5b3
function function_dfc300913bd899ef( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_quarantine_zone_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s._size_max = ( 32, 158, 32 );
    s._size_min = ( 32, 142, 32 );
    s.groupid = "entrance_trigger";
    s.height = 128;
    s.length = "128";
    s.width = "128";
    fe [[ f ]]( s, "QUARANTINE_ZONE_Q3_FIRING_RANGE", cf, ( -29685.6, -29324.9, 918.5 ), ( 0, 140, 0 ), "entrance_QUARANTINE_ZONE_Q3_FIRING_RANGE", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_quarantine_zone_cs";
    s.name = "master_struct";
    fe [[ f ]]( s, "QUARANTINE_ZONE_Q3_FIRING_RANGE", cf, ( -29383.7, -30157.2, 921.06 ), ( 0, 141, 0 ), "QUARANTINE_ZONE_Q3_FIRING_RANGE_main", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_quarantine_zone_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s._size_max = ( 40, 150, 32 );
    s._size_min = ( 32, 167.5, 32 );
    s.groupid = "entrance_trigger";
    s.height = 128;
    s.length = "128";
    s.width = "128";
    fe [[ f ]]( s, "QUARANTINE_ZONE_Q3_FIRING_RANGE", cf, ( -30338.6, -30113.9, 918.5 ), ( 0, 140, 0 ), "entrance_QUARANTINE_ZONE_Q3_FIRING_RANGE", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_quarantine_zone_cs";
    fe [[ f ]]( s, "QUARANTINE_ZONE_Q3_FIRING_RANGE", cf, ( -29115.9, -30387.1, 1403.46 ), ( 0, 138.5, 0 ), "QUARANTINE_ZONE_Q3_FIRING_RANGE", "cspf_4_auto14135615458493372089", "contract_activity_chain", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_quarantine_zone_cs";
    s.script_label = "SUPPLY_DROP_Q3_FIRINGRANGE_MIL_MESS_HALL";
    fe [[ f ]]( s, "QUARANTINE_ZONE_Q3_FIRING_RANGE", cf, ( -29566.8, -30001.9, 1407.46 ), ( 0, 138.5, 0 ), "cspf_4_auto14135615458493372089", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_quarantine_zone_cs";
    s.name = "safe_spawn_point";
    fe [[ f ]]( s, "QUARANTINE_ZONE_Q3_FIRING_RANGE", cf, ( -29062.1, -30053.2, 918.5 ), ( 0, 50, 0 ), undefined, "QUARANTINE_ZONE_Q3_FIRING_RANGE_main", "s_safe_spawn", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_quarantine_zone_cs";
    s.groupid = "amalgam_spawn";
    fe [[ f ]]( s, "QUARANTINE_ZONE_Q3_FIRING_RANGE", cf, ( -29077.9, -29967.1, 918.5 ), ( 0, 196.88, 0 ), "s_quarantine_zone_q3_firing_range_center", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_quarantine_zone_cs";
    s.groupid = "lock_door";
    fe [[ f ]]( s, "QUARANTINE_ZONE_Q3_FIRING_RANGE", cf, ( -29711.6, -29302, 918.75 ), ( 0, 140.46, 0 ), undefined, "QUARANTINE_ZONE_Q3_FIRING_RANGE_main", "s_locked_door", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_quarantine_zone_cs";
    s.groupid = "lock_door";
    fe [[ f ]]( s, "QUARANTINE_ZONE_Q3_FIRING_RANGE", cf, ( -30369.8, -30087.3, 918.75 ), ( 0, 140.46, 0 ), undefined, "QUARANTINE_ZONE_Q3_FIRING_RANGE_main", "s_locked_door", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_quarantine_zone_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s.height = 350;
    fe [[ f ]]( s, "QUARANTINE_ZONE_Q3_FIRING_RANGE", cf, ( -29552.8, -30114.3, 898.29 ), ( 1.32, 306.67, 2.49 ), "combat_volume_QUARANTINE_ZONE_Q3_FIRE_STATION", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 1240 );
}

// Namespace mp_sat_avalon_quad_03_ob_activity_quarantine_zone_cs
// Params 0
// Checksum 0xf51142f5, Offset: 0x2846
// Size: 0x1b7
function function_d9dd7965c51c95d1()
{
    activityinstances = [];
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_activitydef_quarantine_zone";
    var_881289d7987bc770.cf = "mp_sat_avalon_quad_03_ob_activity_quarantine_zone_cs";
    var_881289d7987bc770.scriptstructorigin = ( -4148.49, -30060.2, 852 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [ ( -4169.14, -30040.4, 292 ) ];
    var_881289d7987bc770.var_31ce4477e3543d24 = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.locationradius = [ 900 ];
    activityinstances[ "QUARANTINE_ZONE_Q3_FIRE_STATION" ] = var_881289d7987bc770;
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_activitydef_quarantine_zone";
    var_881289d7987bc770.cf = "mp_sat_avalon_quad_03_ob_activity_quarantine_zone_cs";
    var_881289d7987bc770.scriptstructorigin = ( -29457.7, -30185.2, 1413.06 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [ ( -29419.7, -30204.7, 921.06 ) ];
    var_881289d7987bc770.var_31ce4477e3543d24 = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.locationradius = [ 900 ];
    activityinstances[ "QUARANTINE_ZONE_Q3_FIRING_RANGE" ] = var_881289d7987bc770;
    return activityinstances;
}

