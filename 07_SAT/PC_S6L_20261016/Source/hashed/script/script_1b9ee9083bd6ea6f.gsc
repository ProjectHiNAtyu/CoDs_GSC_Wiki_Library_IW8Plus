// script_1b9ee9083bd6ea6f  (hash_1b9ee9083bd6ea6f.gscc) (size: 26369 Bytes / 0x6701 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x7fb75935 (2142722357)
// size ...... 26369 (0x6701)
// includes .. 4   (offset: 0x590d)
// strings ... 54  (offset: 0x592d)
// dev strs .. 0   (offset: 0x6701)
// exports ... 16  (offset: 0x5351)
// cseg ...... 0x6b5 + 0x4c9c (0x5351)
// imports ... 29  (offset: 0x55d1)
// animtree1 . 0   (offset: 0x6701)
// animtree2 . 0   (offset: 0x6701)
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace mp_sat_avalon_q1_ob_activity_quarantine_zone_cs;

// Namespace mp_sat_avalon_q1_ob_activity_quarantine_zone_cs
// Params 0, eflags: 0x5
// Checksum 0x12fd672f, Offset: 0x6d3
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"mp_sat_avalon_q1_ob_activity_quarantine_zone_cs", #"activity_common", &function_b39ecd3d51489472, undefined );
}

// Namespace mp_sat_avalon_q1_ob_activity_quarantine_zone_cs
// Params 0, eflags: 0x4
// Checksum 0x29adbcb, Offset: 0x6fc
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace mp_sat_avalon_q1_ob_activity_quarantine_zone_cs
// Params 0, eflags: 0x4
// Checksum 0x87a10827, Offset: 0x70d
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace mp_sat_avalon_q1_ob_activity_quarantine_zone_cs
// Params 2
// Checksum 0x5d412fbb, Offset: 0x71e
// Size: 0x8c
function main( unused, unused2 )
{
    if ( utility::flag_exist( "mp_sat_avalon_q1_ob_activity_quarantine_zone_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "mp_sat_avalon_q1_ob_activity_quarantine_zone_cs" ) )
    {
        return;
    }
    
    activity_common::function_e1df676808c1d1e3( &function_4cd78e661617f3 );
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "mp_sat_avalon_q1_ob_activity_quarantine_zone_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "mp_sat_avalon_q1_ob_activity_quarantine_zone_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace mp_sat_avalon_q1_ob_activity_quarantine_zone_cs
// Params 3, eflags: 0x4
// Checksum 0x423bce8, Offset: 0x7b2
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "mp_sat_avalon_q1_ob_activity_quarantine_zone_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "mp_sat_avalon_q1_ob_activity_quarantine_zone_cs" );
}

// Namespace mp_sat_avalon_q1_ob_activity_quarantine_zone_cs
// Params 3, eflags: 0x4
// Checksum 0x7bb652c9, Offset: 0x82c
// Size: 0x2dc9
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_quarantine_zone_cs";
    s.groupid = "ai_encounter_spawnpoint";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "QUARANTINE_ZONE_Q1_MANSIONS_03", cf, ( -51353, 6499.45, 384 ), ( 0, 181, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_quarantine_zone_cs";
    s.groupid = "ai_encounter_spawnpoint";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "QUARANTINE_ZONE_Q1_MANSIONS_03", cf, ( -51577.6, 6854.41, 384 ), ( 0, 282, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_quarantine_zone_cs";
    s.groupid = "ai_encounter_spawnpoint";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "QUARANTINE_ZONE_Q1_MANSIONS_03", cf, ( -51259.2, 6859.39, 384 ), ( 0, 187, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_quarantine_zone_cs";
    s.groupid = "ai_encounter_spawnpoint";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "QUARANTINE_ZONE_Q1_MANSIONS_03", cf, ( -51834.3, 6891.57, 528 ), ( 0, 282, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_quarantine_zone_cs";
    s.groupid = "ai_encounter_spawnpoint";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "QUARANTINE_ZONE_Q1_MANSIONS_03", cf, ( -51834.8, 6432.73, 528 ), ( 0, 96, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_quarantine_zone_cs";
    s.groupid = "ai_encounter_spawnpoint";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "QUARANTINE_ZONE_Q1_MANSIONS_03", cf, ( -51295.2, 6708.61, 528 ), ( 0, 196, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_quarantine_zone_cs";
    s.groupid = "ai_encounter_spawnpoint";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "QUARANTINE_ZONE_Q1_MANSIONS_03", cf, ( -51354.2, 6364.04, 528 ), ( 0, 18, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_quarantine_zone_cs";
    s.groupid = "ai_encounter_spawnpoint";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "QUARANTINE_ZONE_Q1_MANSIONS_03", cf, ( -51922.6, 6400.23, 384 ), ( 0, 23, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_quarantine_zone_cs";
    s.activity_bundle = "sat_activitydef_quarantine_zone";
    s.name = "QUARANTINE_ZONE_Q1_MANSIONS_03";
    fe [[ f ]]( s, "QUARANTINE_ZONE_Q1_MANSIONS_03", cf, ( -51576.6, 6638.38, 917.44 ), ( 0, 264.83, 0 ), "activity_nexus_variant", "QUARANTINE_ZONE_Q1_MANSIONS_03", undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_quarantine_zone_cs";
    s.groupid = "amalgam_spawn";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "nest_doppleghast_spawnpoint";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "QUARANTINE_ZONE_Q1_MANSIONS_03", cf, ( -51844.1, 6726.17, 528 ), ( 0, 353.71, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_quarantine_zone_cs";
    fe [[ f ]]( s, "QUARANTINE_ZONE_Q1_MANSIONS_03", cf, ( -51571.2, 6631.9, 384 ), ( 0, 264, 0 ), "activity_nexus_spatial_zone", undefined, "OB_Spacer_Spatial_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 2000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_quarantine_zone_cs";
    s.groupid = "ai_encounter_spawnpoint";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "QUARANTINE_ZONE_Q1_FIRE_STATION", cf, ( -14901.2, 51205.8, 568 ), ( 0, 92, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_quarantine_zone_cs";
    s.groupid = "ai_encounter_spawnpoint";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "QUARANTINE_ZONE_Q1_FIRE_STATION", cf, ( -14548.9, 51710.5, 568 ), ( 0, 267, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_quarantine_zone_cs";
    s.groupid = "ai_encounter_spawnpoint";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "QUARANTINE_ZONE_Q1_FIRE_STATION", cf, ( -15134.1, 51249.1, 568 ), ( 0, 95, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_quarantine_zone_cs";
    s.groupid = "ai_encounter_spawnpoint";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "QUARANTINE_ZONE_Q1_FIRE_STATION", cf, ( -15057.4, 51840.7, 568 ), ( 0, 349, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_quarantine_zone_cs";
    s.groupid = "ai_encounter_spawnpoint";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "QUARANTINE_ZONE_Q1_FIRE_STATION", cf, ( -14630.7, 51473.3, 568 ), ( 0, 179, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_quarantine_zone_cs";
    s.groupid = "ai_encounter_spawnpoint";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "QUARANTINE_ZONE_Q1_FIRE_STATION", cf, ( -14791.4, 51761.9, 744 ), ( 0, 272, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_quarantine_zone_cs";
    s.groupid = "ai_encounter_spawnpoint";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "QUARANTINE_ZONE_Q1_FIRE_STATION", cf, ( -15136.1, 51862.3, 744 ), ( 0, 334, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_quarantine_zone_cs";
    s.groupid = "ai_encounter_spawnpoint";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "QUARANTINE_ZONE_Q1_FIRE_STATION", cf, ( -15181.1, 51125.1, 744 ), ( 0, 2, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_quarantine_zone_cs";
    s.groupid = "ai_encounter_spawnpoint";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "QUARANTINE_ZONE_Q1_FIRE_STATION", cf, ( -14815.6, 50912.5, 744 ), ( 0, 151, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_quarantine_zone_cs";
    s.groupid = "ai_encounter_spawnpoint";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "QUARANTINE_ZONE_Q1_FIRE_STATION", cf, ( -14754.8, 51913.4, 568 ), ( 0, 171, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_quarantine_zone_cs";
    s.groupid = "ai_encounter_spawnpoint";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "QUARANTINE_ZONE_Q1_FIRE_STATION", cf, ( -15105.8, 50931.5, 744 ), ( 0, 12, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_quarantine_zone_cs";
    s.activity_bundle = "sat_activitydef_quarantine_zone";
    s.name = "QUARANTINE_ZONE_Q1_FIRE_STATION";
    fe [[ f ]]( s, "QUARANTINE_ZONE_Q1_FIRE_STATION", cf, ( -14955.9, 51382, 1287.5 ), ( 0, 179, 0 ), "activity_nexus_variant", "QUARANTINE_ZONE_Q1_FIRE_STATION", undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_quarantine_zone_cs";
    s.groupid = "amalgam_spawn";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "nest_doppleghast_spawnpoint";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "QUARANTINE_ZONE_Q1_FIRE_STATION", cf, ( -14875.8, 51158.8, 744 ), ( 0, 143.69, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_quarantine_zone_cs";
    fe [[ f ]]( s, "QUARANTINE_ZONE_Q1_FIRE_STATION", cf, ( -14936.3, 51454.9, 568 ), ( 0, 179, 0 ), "activity_nexus_spatial_zone", undefined, "OB_Spacer_Spatial_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 2000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_quarantine_zone_cs";
    s.groupid = "ai_encounter_spawnpoint";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "QUARANTINE_ZONE_Q1_GOLF_COURSE", cf, ( -33086.4, 36613, 1948 ), ( 0, 308.08, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_quarantine_zone_cs";
    s.groupid = "ai_encounter_spawnpoint";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "QUARANTINE_ZONE_Q1_GOLF_COURSE", cf, ( -32759.6, 36911.2, 1948 ), ( 0, 167.08, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_quarantine_zone_cs";
    s.groupid = "ai_encounter_spawnpoint";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "QUARANTINE_ZONE_Q1_GOLF_COURSE", cf, ( -33037.3, 37604.8, 1948 ), ( 0, 318.08, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_quarantine_zone_cs";
    s.groupid = "ai_encounter_spawnpoint";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "QUARANTINE_ZONE_Q1_GOLF_COURSE", cf, ( -33632.8, 37409.6, 1948 ), ( 0, 146.08, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_quarantine_zone_cs";
    s.groupid = "ai_encounter_spawnpoint";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "QUARANTINE_ZONE_Q1_GOLF_COURSE", cf, ( -33764.6, 36646, 1948 ), ( 0, 287.08, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_quarantine_zone_cs";
    s.groupid = "ai_encounter_spawnpoint";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "QUARANTINE_ZONE_Q1_GOLF_COURSE", cf, ( -33632.1, 36255.3, 1948 ), ( 0, 40.08, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_quarantine_zone_cs";
    s.groupid = "ai_encounter_spawnpoint";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "QUARANTINE_ZONE_Q1_GOLF_COURSE", cf, ( -34228.1, 36766.3, 1980 ), ( 0, 310.08, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_quarantine_zone_cs";
    s.groupid = "ai_encounter_spawnpoint";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "QUARANTINE_ZONE_Q1_GOLF_COURSE", cf, ( -32995.4, 37473.5, 2172 ), ( 0, 308.08, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_quarantine_zone_cs";
    s.groupid = "ai_encounter_spawnpoint";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "QUARANTINE_ZONE_Q1_GOLF_COURSE", cf, ( -33448.4, 37593, 2172 ), ( 0, 25.08, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_quarantine_zone_cs";
    s.groupid = "ai_encounter_spawnpoint";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "QUARANTINE_ZONE_Q1_GOLF_COURSE", cf, ( -34144.8, 36879.1, 2172 ), ( 0, 62.08, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_quarantine_zone_cs";
    s.groupid = "ai_encounter_spawnpoint";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "QUARANTINE_ZONE_Q1_GOLF_COURSE", cf, ( -33608.7, 36324.6, 2172 ), ( 0, 102.08, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_quarantine_zone_cs";
    s.groupid = "ai_encounter_spawnpoint";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "QUARANTINE_ZONE_Q1_GOLF_COURSE", cf, ( -33070.2, 36644.1, 2172 ), ( 0, 337.08, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_quarantine_zone_cs";
    s.groupid = "ai_encounter_spawnpoint";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "QUARANTINE_ZONE_Q1_GOLF_COURSE", cf, ( -33562.1, 37085.7, 2370 ), ( 0, 321.08, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_quarantine_zone_cs";
    s.groupid = "ai_encounter_spawnpoint";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "QUARANTINE_ZONE_Q1_GOLF_COURSE", cf, ( -33577.1, 37220.2, 2370 ), ( 0, 47.08, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_quarantine_zone_cs";
    s.groupid = "ai_encounter_spawnpoint";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "QUARANTINE_ZONE_Q1_GOLF_COURSE", cf, ( -33716.7, 37095.3, 2370 ), ( 0, 233.08, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_quarantine_zone_cs";
    s.activity_bundle = "sat_activitydef_quarantine_zone";
    s.name = "QUARANTINE_ZONE_Q1_GOLF_COURSE";
    fe [[ f ]]( s, "QUARANTINE_ZONE_Q1_GOLF_COURSE", cf, ( -33380.4, 36909.9, 2928.35 ), ( 0, 225, 0 ), "activity_nexus_variant", "QUARANTINE_ZONE_Q1_GOLF_COURSE", undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_quarantine_zone_cs";
    s.groupid = "amalgam_spawn";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "nest_doppleghast_spawnpoint";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "QUARANTINE_ZONE_Q1_GOLF_COURSE", cf, ( -33584.2, 36159.1, 1948 ), ( 0, 106.76, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_quarantine_zone_cs";
    s.groupid = "amalgam_spawn";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "nest_doppleghast_spawnpoint";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "QUARANTINE_ZONE_Q1_GOLF_COURSE", cf, ( -33710.4, 36291.5, 1948 ), ( 0, 0.35, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_quarantine_zone_cs";
    fe [[ f ]]( s, "QUARANTINE_ZONE_Q1_GOLF_COURSE", cf, ( -33569.6, 37094, 1948 ), ( 0, 225, 0 ), "activity_nexus_spatial_zone", undefined, "OB_Spacer_Spatial_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 2000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_quarantine_zone_cs";
    s.groupid = "ai_encounter_spawnpoint";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "QUARANTINE_ZONE_Q1_MANSIONS_01", cf, ( -13727.1, 14215.1, 1132 ), ( 0, 2.99, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_quarantine_zone_cs";
    s.groupid = "ai_encounter_spawnpoint";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "QUARANTINE_ZONE_Q1_MANSIONS_01", cf, ( -13985.4, 13648.2, 1132 ), ( 0, 89.99, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_quarantine_zone_cs";
    s.groupid = "ai_encounter_spawnpoint";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "QUARANTINE_ZONE_Q1_MANSIONS_01", cf, ( -13779.3, 13853.2, 1132 ), ( 0, 295, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_quarantine_zone_cs";
    s.groupid = "ai_encounter_spawnpoint";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "QUARANTINE_ZONE_Q1_MANSIONS_01", cf, ( -13803.6, 14651.1, 1132 ), ( 0, 277.99, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_quarantine_zone_cs";
    s.groupid = "ai_encounter_spawnpoint";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "QUARANTINE_ZONE_Q1_MANSIONS_01", cf, ( -14092.2, 14715.8, 1164 ), ( 0, 348, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_quarantine_zone_cs";
    s.groupid = "ai_encounter_spawnpoint";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "QUARANTINE_ZONE_Q1_MANSIONS_01", cf, ( -14179.3, 13770, 1292.7 ), ( 0, 11.99, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_quarantine_zone_cs";
    s.groupid = "ai_encounter_spawnpoint";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "QUARANTINE_ZONE_Q1_MANSIONS_01", cf, ( -13667.5, 13656.2, 1292 ), ( 0, 107.99, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_quarantine_zone_cs";
    s.groupid = "ai_encounter_spawnpoint";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "QUARANTINE_ZONE_Q1_MANSIONS_01", cf, ( -13918.8, 13592.9, 1292 ), ( 0, 7.99, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_quarantine_zone_cs";
    s.groupid = "ai_encounter_spawnpoint";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "QUARANTINE_ZONE_Q1_MANSIONS_01", cf, ( -14127.7, 14679.7, 1292.7 ), ( 0, 327.99, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_quarantine_zone_cs";
    s.groupid = "ai_encounter_spawnpoint";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "QUARANTINE_ZONE_Q1_MANSIONS_01", cf, ( -13794.5, 14662.5, 1292 ), ( 0, 315, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_quarantine_zone_cs";
    s.activity_bundle = "sat_activitydef_quarantine_zone";
    s.name = "QUARANTINE_ZONE_Q1_MANSIONS_01";
    fe [[ f ]]( s, "QUARANTINE_ZONE_Q1_MANSIONS_01", cf, ( -13870.6, 14231.8, 1627.45 ), ( 0, 329, 0 ), "activity_nexus_variant", "QUARANTINE_ZONE_Q1_MANSIONS_01", undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_quarantine_zone_cs";
    s.groupid = "amalgam_spawn";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "nest_doppleghast_spawnpoint";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "QUARANTINE_ZONE_Q1_MANSIONS_01", cf, ( -13903.8, 14712.8, 1292 ), ( 0, 350.91, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_quarantine_zone_cs";
    s.name = "script_struct_nexus_spatial_zone";
    fe [[ f ]]( s, "QUARANTINE_ZONE_Q1_MANSIONS_01", cf, ( -13851.5, 14262.8, 1179.45 ), ( 0, 329, 0 ), "activity_nexus_spatial_zone", undefined, "OB_Spacer_Spatial_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 2000 );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace mp_sat_avalon_q1_ob_activity_quarantine_zone_cs
// Params 0, eflags: 0x4
// Checksum 0x4ac59bf6, Offset: 0x35fd
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace mp_sat_avalon_q1_ob_activity_quarantine_zone_cs
// Params 0
// Checksum 0xc67061a5, Offset: 0x3607
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "mp_sat_avalon_q1_ob_activity_quarantine_zone_cs" );
}

// Namespace mp_sat_avalon_q1_ob_activity_quarantine_zone_cs
// Params 0
// Checksum 0x5a288efb, Offset: 0x361d
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

// Namespace mp_sat_avalon_q1_ob_activity_quarantine_zone_cs
// Params 4
// Checksum 0xccbc34be, Offset: 0x368c
// Size: 0xa5
function function_d4323822d7042e5a( var_4312b79c960726b6, fe, us, cf = "mp_sat_avalon_q1_ob_activity_quarantine_zone_cs" )
{
    switch ( var_4312b79c960726b6 )
    {
        case #"hash_7ef886536a354e0e":
            function_fcdf745de7ae3016( fe, us, cf );
            break;
        case #"hash_fa8cb5dfb02590b3":
            function_56d2900bb679a87b( fe, us, cf );
            break;
        case #"hash_784d26e15884bbac":
            function_e9b3e1970dee7af4( fe, us, cf );
            break;
        case #"hash_7ef884536a354ae8":
            function_fcdf725de7ae2bb0( fe, us, cf );
            break;
    }
}

// Namespace mp_sat_avalon_q1_ob_activity_quarantine_zone_cs
// Params 3
// Checksum 0xe0a6ef9b, Offset: 0x3739
// Size: 0x5b3
function function_fcdf745de7ae3016( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_quarantine_zone_cs";
    s.groupid = "amalgam_spawn";
    fe [[ f ]]( s, "QUARANTINE_ZONE_Q1_MANSIONS_03", cf, ( -51848.5, 6823.3, 528 ), ( 0, 105.88, 0 ), "s_quarantine_zone_q1_mansions_03_center", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_quarantine_zone_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s._size_max = ( 32, 120, 32 );
    s._size_min = ( 32, 76, 32 );
    s.groupid = "entrance_trigger";
    s.height = 128;
    s.length = "128";
    s.width = "128";
    fe [[ f ]]( s, "QUARANTINE_ZONE_Q1_MANSIONS_03", cf, ( -51258.3, 6785.61, 528 ), ( 0, 85, 0 ), "entrance_QUARANTINE_ZONE_Q1_MANSIONS_03", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_quarantine_zone_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s._size_max = ( 56, 88, 32 );
    s._size_min = ( 27, 100, 32 );
    s.groupid = "entrance_trigger";
    s.height = 128;
    s.length = "128";
    s.width = "128";
    fe [[ f ]]( s, "QUARANTINE_ZONE_Q1_MANSIONS_03", cf, ( -51607.7, 6329.14, 384 ), ( 0, 265, 0 ), "entrance_QUARANTINE_ZONE_Q1_MANSIONS_03", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_quarantine_zone_cs";
    s.name = "master_struct";
    fe [[ f ]]( s, "QUARANTINE_ZONE_Q1_MANSIONS_03", cf, ( -51633.8, 6640.31, 384 ), ( 0, 264, 0 ), "QUARANTINE_ZONE_Q1_MANSIONS_03_main", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_quarantine_zone_cs";
    s.name = "safe_spawn_point";
    fe [[ f ]]( s, "QUARANTINE_ZONE_Q1_MANSIONS_03", cf, ( -51900, 6969.5, 528 ), ( 0, -5, 0 ), undefined, "QUARANTINE_ZONE_Q1_MANSIONS_03_main", "s_safe_spawn", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_quarantine_zone_cs";
    fe [[ f ]]( s, "QUARANTINE_ZONE_Q1_MANSIONS_03", cf, ( -52216, 6692.4, 914.73 ), ( 0, 357, 0 ), "QUARANTINE_ZONE_Q1_MANSIONS_03", "cspf_5_auto14135615458493372089", "contract_activity_chain", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_quarantine_zone_cs";
    s.script_label = "SUPPLY_DROP_Q1_MANSIONS_03";
    fe [[ f ]]( s, "QUARANTINE_ZONE_Q1_MANSIONS_03", cf, ( -51627.5, 6615.24, 918.73 ), ( 0, 357, 0 ), "cspf_5_auto14135615458493372089", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_quarantine_zone_cs";
    s.groupid = "lock_door";
    fe [[ f ]]( s, "QUARANTINE_ZONE_Q1_MANSIONS_03", cf, ( -51253.6, 6817.44, 528.25 ), ( 0, 85.77, 0 ), undefined, "QUARANTINE_ZONE_Q1_MANSIONS_03_main", "s_locked_door", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_quarantine_zone_cs";
    s.groupid = "lock_door";
    fe [[ f ]]( s, "QUARANTINE_ZONE_Q1_MANSIONS_03", cf, ( -51614.3, 6273.34, 385.58 ), ( 0, 265.1, 0 ), undefined, "QUARANTINE_ZONE_Q1_MANSIONS_03_main", "s_locked_door", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_quarantine_zone_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s.height = 550;
    fe [[ f ]]( s, "QUARANTINE_ZONE_Q1_MANSIONS_03", cf, ( -51618.1, 6617.5, 341.94 ), ( 1.32, 306.67, 2.49 ), "combat_volume_QUARANTINE_ZONE_Q1_MANSIONS_03", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 692 );
}

// Namespace mp_sat_avalon_q1_ob_activity_quarantine_zone_cs
// Params 3
// Checksum 0xb8e6fa87, Offset: 0x3cf4
// Size: 0x5b3
function function_56d2900bb679a87b( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_quarantine_zone_cs";
    s.groupid = "amalgam_spawn";
    fe [[ f ]]( s, "QUARANTINE_ZONE_Q1_FIRE_STATION", cf, ( -14912.4, 51281, 744 ), ( 0, 105.88, 0 ), "s_quarantine_zone_q1_fire_station_center", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_quarantine_zone_cs";
    s.name = "master_struct";
    fe [[ f ]]( s, "QUARANTINE_ZONE_Q1_FIRE_STATION", cf, ( -14933.3, 51518, 568 ), ( 0, 179, 0 ), "QUARANTINE_ZONE_Q1_FIRE_STATION_main", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_quarantine_zone_cs";
    s.name = "safe_spawn_point";
    fe [[ f ]]( s, "QUARANTINE_ZONE_Q1_FIRE_STATION", cf, ( -15052.5, 51305, 744 ), ( 0, 269, 0 ), undefined, "QUARANTINE_ZONE_Q1_FIRE_STATION_main", "s_safe_spawn", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_quarantine_zone_cs";
    fe [[ f ]]( s, "QUARANTINE_ZONE_Q1_FIRE_STATION", cf, ( -14933.3, 52191.4, 1111.48 ), ( 0, 269, 0 ), "QUARANTINE_ZONE_Q1_FIRE_STATION", "cspf_6_auto14135615458493372089", "contract_activity_chain", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_quarantine_zone_cs";
    s.script_label = "SUPPLY_DROP_Q1_FIRE_STATION";
    fe [[ f ]]( s, "QUARANTINE_ZONE_Q1_FIRE_STATION", cf, ( -14933.3, 51598.4, 1115.48 ), ( 0, 269, 0 ), "cspf_6_auto14135615458493372089", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_quarantine_zone_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s._size_max = ( 32, 122, 32 );
    s._size_min = ( 32, 118, 32 );
    s.groupid = "entrance_trigger";
    s.height = 128;
    s.length = "128";
    s.width = "128";
    fe [[ f ]]( s, "QUARANTINE_ZONE_Q1_FIRE_STATION", cf, ( -14899.4, 50927.9, 568 ), ( 0, 269, 0 ), "entrance_QUARANTINE_ZONE_Q1_FIRE_STATION", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_quarantine_zone_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s._size_max = ( 40, 128, 32 );
    s._size_min = ( 32, 204, 32 );
    s.groupid = "entrance_trigger";
    s.height = 128;
    s.length = "128";
    s.width = "128";
    fe [[ f ]]( s, "QUARANTINE_ZONE_Q1_FIRE_STATION", cf, ( -15107.1, 51946.5, 568 ), ( 0, 89, 0 ), "entrance_QUARANTINE_ZONE_Q1_FIRE_STATION", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_quarantine_zone_cs";
    s.groupid = "lock_door";
    fe [[ f ]]( s, "QUARANTINE_ZONE_Q1_FIRE_STATION", cf, ( -15138.3, 51990.5, 570.1 ), ( 0, 90, 0 ), undefined, "QUARANTINE_ZONE_Q1_FIRE_STATION_main", "s_locked_door", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_quarantine_zone_cs";
    s.groupid = "lock_door";
    fe [[ f ]]( s, "QUARANTINE_ZONE_Q1_FIRE_STATION", cf, ( -14901.4, 50900.7, 568.25 ), ( 0, 270, 0 ), undefined, "QUARANTINE_ZONE_Q1_FIRE_STATION_main", "s_locked_door", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_quarantine_zone_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s.height = 650;
    fe [[ f ]]( s, "QUARANTINE_ZONE_Q1_FIRE_STATION", cf, ( -14948, 51416, 536 ), ( 0, 0, 0 ), "combat_volume_QUARANTINE_ZONE_Q1_FIRE_STATION", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 784 );
}

// Namespace mp_sat_avalon_q1_ob_activity_quarantine_zone_cs
// Params 3
// Checksum 0x9a9e4cf4, Offset: 0x42af
// Size: 0x789
function function_e9b3e1970dee7af4( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_quarantine_zone_cs";
    s.groupid = "amalgam_spawn";
    fe [[ f ]]( s, "QUARANTINE_ZONE_Q1_GOLF_COURSE", cf, ( -33613.2, 36270.5, 1948 ), ( 0, 105.88, 0 ), "s_quarantine_zone_q1_golf_course_center", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_quarantine_zone_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s._size_max = ( 32, 174, 32 );
    s._size_min = ( 32, 186, 32 );
    s.groupid = "entrance_trigger";
    s.height = 128;
    s.length = "128";
    s.width = "128";
    fe [[ f ]]( s, "QUARANTINE_ZONE_Q1_GOLF_COURSE", cf, ( -32789.5, 36309.1, 1972 ), ( 0, 315, 0 ), "entrance_QUARANTINE_ZONE_Q1_GOLF_COURSE", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_quarantine_zone_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s._size_max = ( 32, 228, 32 );
    s._size_min = ( 32, 204, 32 );
    s.groupid = "entrance_trigger";
    s.height = 128;
    s.length = "128";
    s.width = "128";
    fe [[ f ]]( s, "QUARANTINE_ZONE_Q1_GOLF_COURSE", cf, ( -32979.2, 36502.2, 2172.25 ), ( 0, 315, 0 ), "entrance_QUARANTINE_ZONE_Q1_GOLF_COURSE", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_quarantine_zone_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s._size_max = ( 32, 228, 32 );
    s._size_min = ( 32, 204, 32 );
    s.groupid = "entrance_trigger";
    s.height = 128;
    s.length = "128";
    s.width = "128";
    fe [[ f ]]( s, "QUARANTINE_ZONE_Q1_GOLF_COURSE", cf, ( -33844.6, 37359.9, 1948 ), ( 0, 134.17, 0 ), "entrance_QUARANTINE_ZONE_Q1_GOLF_COURSE", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_quarantine_zone_cs";
    s.groupid = "lock_door";
    fe [[ f ]]( s, "QUARANTINE_ZONE_Q1_GOLF_COURSE", cf, ( -32762.9, 36284.4, 1972.5 ), ( 0, 315, 0 ), undefined, "QUARANTINE_ZONE_Q1_GOLF_COURSE_main", "s_locked_door", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_quarantine_zone_cs";
    s.groupid = "lock_door";
    fe [[ f ]]( s, "QUARANTINE_ZONE_Q1_GOLF_COURSE", cf, ( -32956.5, 36477.4, 2172 ), ( 0, 315, 0 ), undefined, "QUARANTINE_ZONE_Q1_GOLF_COURSE_main", "s_locked_door", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_quarantine_zone_cs";
    s.groupid = "lock_door";
    fe [[ f ]]( s, "QUARANTINE_ZONE_Q1_GOLF_COURSE", cf, ( -33866.9, 37382.8, 1948.5 ), ( 0, 135, 0 ), undefined, "QUARANTINE_ZONE_Q1_GOLF_COURSE_main", "s_locked_door", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_quarantine_zone_cs";
    s.groupid = "lock_door";
    fe [[ f ]]( s, "QUARANTINE_ZONE_Q1_GOLF_COURSE", cf, ( -33867.3, 36943.8, 2370 ), ( 0, 225, 0 ), undefined, "QUARANTINE_ZONE_Q1_GOLF_COURSE_main", "s_locked_door", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_quarantine_zone_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s.height = 1000;
    fe [[ f ]]( s, "QUARANTINE_ZONE_Q1_GOLF_COURSE", cf, ( -33440, 36952, 1924 ), ( 0, 0, 0 ), "combat_volume_QUARANTINE_ZONE_Q1_GOLF_COURSE", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 1312 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_quarantine_zone_cs";
    s.name = "master_struct";
    fe [[ f ]]( s, "QUARANTINE_ZONE_Q1_GOLF_COURSE", cf, ( -33577.1, 36338.6, 1948 ), ( 0, 225, 0 ), "QUARANTINE_ZONE_Q1_GOLF_COURSE_main", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_quarantine_zone_cs";
    s.name = "safe_spawn_point";
    fe [[ f ]]( s, "QUARANTINE_ZONE_Q1_GOLF_COURSE", cf, ( -33394.3, 36329.4, 1948.25 ), ( 0, 225, 0 ), undefined, "QUARANTINE_ZONE_Q1_GOLF_COURSE_main", "s_safe_spawn", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_quarantine_zone_cs";
    fe [[ f ]]( s, "QUARANTINE_ZONE_Q1_GOLF_COURSE", cf, ( -33940.4, 37354.9, 2516.98 ), ( 0, 320.08, 0 ), "QUARANTINE_ZONE_Q1_GOLF_COURSE", "cspf_7_auto14135615458493372089", "contract_activity_chain", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_quarantine_zone_cs";
    s.script_label = "SUPPLY_DROP_Q1_GOLF_COURSE";
    fe [[ f ]]( s, "QUARANTINE_ZONE_Q1_GOLF_COURSE", cf, ( -33479.1, 36982.4, 2520.98 ), ( 0, 320.08, 0 ), "cspf_7_auto14135615458493372089", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_sat_avalon_q1_ob_activity_quarantine_zone_cs
// Params 3
// Checksum 0x3e3cc59a, Offset: 0x4a40
// Size: 0x5b3
function function_fcdf725de7ae2bb0( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_quarantine_zone_cs";
    s.name = "master_struct";
    fe [[ f ]]( s, "QUARANTINE_ZONE_Q1_MANSIONS_01", cf, ( -13884.7, 14209, 1179.45 ), ( 0, 329, 0 ), "QUARANTINE_ZONE_Q1_MANSIONS_01_main", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_quarantine_zone_cs";
    s.name = "safe_spawn_point";
    fe [[ f ]]( s, "QUARANTINE_ZONE_Q1_MANSIONS_01", cf, ( -13634.2, 14744, 1292 ), ( 0, 185, 0 ), undefined, "QUARANTINE_ZONE_Q1_MANSIONS_01_main", "s_safe_spawn", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_quarantine_zone_cs";
    fe [[ f ]]( s, "QUARANTINE_ZONE_Q1_MANSIONS_01", cf, ( -14169.1, 13698.3, 1710.18 ), ( 0, 62.99, 0 ), "QUARANTINE_ZONE_Q1_MANSIONS_01", "cspf_8_auto14135615458493372089", "contract_activity_chain", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_quarantine_zone_cs";
    s.script_label = "SUPPLY_DROP_Q1_HIGHTOWN_MANSIONS_01";
    fe [[ f ]]( s, "QUARANTINE_ZONE_Q1_MANSIONS_01", cf, ( -13859.2, 14204.5, 1714.18 ), ( 0, 62.99, 0 ), "cspf_8_auto14135615458493372089", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_quarantine_zone_cs";
    s.groupid = "amalgam_spawn";
    fe [[ f ]]( s, "QUARANTINE_ZONE_Q1_MANSIONS_01", cf, ( -13719.3, 14656.3, 1292 ), ( 0, 107.71, 0 ), "s_quarantine_zone_q1_mansions_01_center", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_quarantine_zone_cs";
    s.groupid = "lock_door";
    fe [[ f ]]( s, "QUARANTINE_ZONE_Q1_MANSIONS_01", cf, ( -13483.6, 14210.1, 1132 ), ( 0, 5.81, 0 ), undefined, "QUARANTINE_ZONE_Q1_MANSIONS_01_main", "s_locked_door", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_quarantine_zone_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s._size_max = ( 32, 212, 32 );
    s._size_min = ( 32, 204, 32 );
    s.groupid = "entrance_trigger";
    s.height = 128;
    s.length = "128";
    s.width = "128";
    fe [[ f ]]( s, "QUARANTINE_ZONE_Q1_MANSIONS_01", cf, ( -13577.6, 14201.9, 1292 ), ( 0, 5, 0 ), "entrance_QUARANTINE_ZONE_Q1_MANSIONS_01", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_quarantine_zone_cs";
    s.groupid = "lock_door";
    fe [[ f ]]( s, "QUARANTINE_ZONE_Q1_MANSIONS_01", cf, ( -13546.9, 14205.5, 1292 ), ( 0, 4.64, 0 ), undefined, "QUARANTINE_ZONE_Q1_MANSIONS_01_main", "s_locked_door", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_quarantine_zone_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s._size_max = ( 32, 124, 32 );
    s._size_min = ( 32, 120, 32 );
    s.groupid = "entrance_trigger";
    s.height = 128;
    s.length = "128";
    s.width = "128";
    fe [[ f ]]( s, "QUARANTINE_ZONE_Q1_MANSIONS_01", cf, ( -13514.2, 14207.5, 1132 ), ( 0, 5, 0 ), "entrance_QUARANTINE_ZONE_Q1_MANSIONS_01", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_quarantine_zone_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s.height = 550;
    fe [[ f ]]( s, "QUARANTINE_ZONE_Q1_MANSIONS_01", cf, ( -13901.7, 14219.3, 1090.98 ), ( 1.32, 306.67, 2.49 ), "combat_volume_QUARANTINE_ZONE_Q1_MANSIONS_01", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 892 );
}

// Namespace mp_sat_avalon_q1_ob_activity_quarantine_zone_cs
// Params 0
// Checksum 0x222944b3, Offset: 0x4ffb
// Size: 0x355
function function_d9dd7965c51c95d1()
{
    activityinstances = [];
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_activitydef_quarantine_zone";
    var_881289d7987bc770.cf = "mp_sat_avalon_q1_ob_activity_quarantine_zone_cs";
    var_881289d7987bc770.scriptstructorigin = ( -51576.6, 6638.38, 917.44 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [ ( -51536.4, 6627.5, 384 ) ];
    var_881289d7987bc770.var_31ce4477e3543d24 = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.locationradius = [ 900 ];
    activityinstances[ "QUARANTINE_ZONE_Q1_MANSIONS_03" ] = var_881289d7987bc770;
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_activitydef_quarantine_zone";
    var_881289d7987bc770.cf = "mp_sat_avalon_q1_ob_activity_quarantine_zone_cs";
    var_881289d7987bc770.scriptstructorigin = ( -14955.9, 51382, 1287.5 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [ ( -14937.6, 51419.8, 568 ) ];
    var_881289d7987bc770.var_31ce4477e3543d24 = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.locationradius = [ 900 ];
    activityinstances[ "QUARANTINE_ZONE_Q1_FIRE_STATION" ] = var_881289d7987bc770;
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_activitydef_quarantine_zone";
    var_881289d7987bc770.cf = "mp_sat_avalon_q1_ob_activity_quarantine_zone_cs";
    var_881289d7987bc770.scriptstructorigin = ( -33380.4, 36909.9, 2928.35 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [ ( -33545, 37069.6, 1950.75 ) ];
    var_881289d7987bc770.var_31ce4477e3543d24 = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.locationradius = [ 1200 ];
    activityinstances[ "QUARANTINE_ZONE_Q1_GOLF_COURSE" ] = var_881289d7987bc770;
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_activitydef_quarantine_zone";
    var_881289d7987bc770.cf = "mp_sat_avalon_q1_ob_activity_quarantine_zone_cs";
    var_881289d7987bc770.scriptstructorigin = ( -13870.6, 14231.8, 1627.45 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [ ( -13890.5, 14221, 1179.45 ) ];
    var_881289d7987bc770.var_31ce4477e3543d24 = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.locationradius = [ 900 ];
    activityinstances[ "QUARANTINE_ZONE_Q1_MANSIONS_01" ] = var_881289d7987bc770;
    return activityinstances;
}

