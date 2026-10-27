// script_74c8283b43e4357  (hash_074c8283b43e4357.gscc) (size: 19737 Bytes / 0x4d19 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x52f3af11 (1391701777)
// size ...... 19737 (0x4d19)
// includes .. 4   (offset: 0x42ed)
// strings ... 48  (offset: 0x430d)
// dev strs .. 0   (offset: 0x4d19)
// exports ... 15  (offset: 0x3d79)
// cseg ...... 0x59f + 0x37da (0x3d79)
// imports ... 28  (offset: 0x3fd1)
// animtree1 . 0   (offset: 0x4d19)
// animtree2 . 0   (offset: 0x4d19)
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace mp_sat_avalon_q2_ob_activity_quarantine_zone_cs;

// Namespace mp_sat_avalon_q2_ob_activity_quarantine_zone_cs
// Params 0, eflags: 0x5
// Checksum 0x41fe28f0, Offset: 0x5bd
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"mp_sat_avalon_q2_ob_activity_quarantine_zone_cs", #"activity_common", &function_b39ecd3d51489472, undefined );
}

// Namespace mp_sat_avalon_q2_ob_activity_quarantine_zone_cs
// Params 0, eflags: 0x4
// Checksum 0x54ddb7cf, Offset: 0x5e6
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace mp_sat_avalon_q2_ob_activity_quarantine_zone_cs
// Params 0, eflags: 0x4
// Checksum 0xd1e66423, Offset: 0x5f7
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace mp_sat_avalon_q2_ob_activity_quarantine_zone_cs
// Params 2
// Checksum 0xc2194b00, Offset: 0x608
// Size: 0x8c
function main( unused, unused2 )
{
    if ( utility::flag_exist( "mp_sat_avalon_q2_ob_activity_quarantine_zone_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "mp_sat_avalon_q2_ob_activity_quarantine_zone_cs" ) )
    {
        return;
    }
    
    activity_common::function_e1df676808c1d1e3( &function_4cd78e661617f3 );
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "mp_sat_avalon_q2_ob_activity_quarantine_zone_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "mp_sat_avalon_q2_ob_activity_quarantine_zone_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace mp_sat_avalon_q2_ob_activity_quarantine_zone_cs
// Params 3, eflags: 0x4
// Checksum 0x5264d0ec, Offset: 0x69c
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "mp_sat_avalon_q2_ob_activity_quarantine_zone_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "mp_sat_avalon_q2_ob_activity_quarantine_zone_cs" );
}

// Namespace mp_sat_avalon_q2_ob_activity_quarantine_zone_cs
// Params 3, eflags: 0x4
// Checksum 0x12e00a63, Offset: 0x716
// Size: 0x1ce3
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_quarantine_zone_cs";
    s.groupid = "ai_encounter_spawnpoint";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "QUARANTINE_ZONE_PONY_CLUB", cf, ( 30350.8, 50097.2, 1384 ), ( 0, 272, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_quarantine_zone_cs";
    s.groupid = "ai_encounter_spawnpoint";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "QUARANTINE_ZONE_PONY_CLUB", cf, ( 30501.7, 49554.8, 1384 ), ( 0, 94, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_quarantine_zone_cs";
    s.groupid = "ai_encounter_spawnpoint";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "QUARANTINE_ZONE_PONY_CLUB", cf, ( 30013.8, 49821.5, 1384 ), ( 0, 360, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_quarantine_zone_cs";
    s.groupid = "ai_encounter_spawnpoint";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "QUARANTINE_ZONE_PONY_CLUB", cf, ( 29962.6, 50110.7, 1384 ), ( 0, 282, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_quarantine_zone_cs";
    s.groupid = "ai_encounter_spawnpoint";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "QUARANTINE_ZONE_PONY_CLUB", cf, ( 30014, 49613.3, 1528 ), ( 0, 322, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_quarantine_zone_cs";
    s.groupid = "ai_encounter_spawnpoint";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "QUARANTINE_ZONE_PONY_CLUB", cf, ( 30454.1, 49555, 1528 ), ( 0, 176, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_quarantine_zone_cs";
    s.groupid = "ai_encounter_spawnpoint";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "QUARANTINE_ZONE_PONY_CLUB", cf, ( 30148.1, 50126.7, 1528 ), ( 0, 282, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_quarantine_zone_cs";
    s.groupid = "ai_encounter_spawnpoint";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "QUARANTINE_ZONE_PONY_CLUB", cf, ( 30331.5, 49949.5, 1528 ), ( 0, 51, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_quarantine_zone_cs";
    s.groupid = "ai_encounter_spawnpoint";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "QUARANTINE_ZONE_PONY_CLUB", cf, ( 30516.3, 50072.7, 1528 ), ( 0, 168, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_quarantine_zone_cs";
    s.activity_bundle = "sat_activitydef_quarantine_zone";
    s.name = "QUARANTINE_ZONE_PONY_CLUB";
    fe [[ f ]]( s, "QUARANTINE_ZONE_PONY_CLUB", cf, ( 30236.7, 49831.9, 1904.15 ), ( 0, 0.88, 0 ), "activity_nexus_variant", "QUARANTINE_ZONE_PONY_CLUB", undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_quarantine_zone_cs";
    s.groupid = "amalgam_spawn";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "nest_doppleghast_spawnpoint";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "QUARANTINE_ZONE_PONY_CLUB", cf, ( 30180.7, 49590.5, 1528 ), ( 0, 93.69, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_quarantine_zone_cs";
    fe [[ f ]]( s, "QUARANTINE_ZONE_PONY_CLUB", cf, ( 30240.8, 49843, 1384 ), ( 0, 3, 0 ), "activity_nexus_spatial_zone", undefined, "OB_Spacer_Spatial_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 2000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_quarantine_zone_cs";
    fe [[ f ]]( s, "QUARANTINE_ZONE_WINERY_FERMENTATION", cf, ( 12446.9, 43937.5, 716 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "OB_Spacer_Spatial_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 2000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_quarantine_zone_cs";
    s.groupid = "amalgam_spawnpoint";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "nest_doppleghast_spawnpoint";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "QUARANTINE_ZONE_WINERY_FERMENTATION", cf, ( 11850.7, 43935.8, 859 ), ( 0, 317.69, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_quarantine_zone_cs";
    s.groupid = "amalgam_spawnpoint";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "nest_doppleghast_spawnpoint";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "QUARANTINE_ZONE_WINERY_FERMENTATION", cf, ( 12024.3, 43637.1, 859 ), ( 0, 123.27, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_quarantine_zone_cs";
    s.groupid = "amalgam_spawnpoint";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "nest_doppleghast_spawnpoint";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "QUARANTINE_ZONE_WINERY_FERMENTATION", cf, ( 12069.8, 43900.1, 859 ), ( 0, 206.69, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_quarantine_zone_cs";
    s.groupid = "ai_encounter_spawnpoint";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "QUARANTINE_ZONE_WINERY_FERMENTATION", cf, ( 12291.6, 43689.3, 859 ), ( 0, 342, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_quarantine_zone_cs";
    s.groupid = "ai_encounter_spawnpoint";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "QUARANTINE_ZONE_WINERY_FERMENTATION", cf, ( 12039, 43722.7, 859 ), ( 0, 342, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_quarantine_zone_cs";
    s.groupid = "ai_encounter_spawnpoint";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "QUARANTINE_ZONE_WINERY_FERMENTATION", cf, ( 11873.6, 43570.3, 859 ), ( 0, 342, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_quarantine_zone_cs";
    s.groupid = "ai_encounter_spawnpoint";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "QUARANTINE_ZONE_WINERY_FERMENTATION", cf, ( 12691.8, 43783.9, 715 ), ( 0, 87, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_quarantine_zone_cs";
    s.groupid = "ai_encounter_spawnpoint";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "QUARANTINE_ZONE_WINERY_FERMENTATION", cf, ( 12784.2, 44138.1, 715 ), ( 0, 163.5, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_quarantine_zone_cs";
    s.groupid = "ai_encounter_spawnpoint";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "QUARANTINE_ZONE_WINERY_FERMENTATION", cf, ( 11871.4, 43769.2, 715 ), ( 0, 342, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_quarantine_zone_cs";
    s.groupid = "ai_encounter_spawnpoint";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "QUARANTINE_ZONE_WINERY_FERMENTATION", cf, ( 12441.1, 43436.7, 715 ), ( 0, 342, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_quarantine_zone_cs";
    s.groupid = "ai_encounter_spawnpoint";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "QUARANTINE_ZONE_WINERY_FERMENTATION", cf, ( 12671.4, 43659.7, 859 ), ( 0, 342, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_quarantine_zone_cs";
    s.groupid = "ai_encounter_spawnpoint";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "QUARANTINE_ZONE_WINERY_FERMENTATION", cf, ( 13004.7, 43622.6, 859 ), ( 0, 342, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_quarantine_zone_cs";
    s.activity_bundle = "sat_activitydef_quarantine_zone";
    s.name = "QUARANTINE_ZONE_WINERY_FERMENTATION";
    fe [[ f ]]( s, "QUARANTINE_ZONE_WINERY_FERMENTATION", cf, ( 12439.9, 43906.2, 1307.5 ), ( 0, 349.86, 1 ), "activity_nexus_variant", "QUARANTINE_ZONE_WINERY_FERMENTATION", undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_quarantine_zone_cs";
    s.groupid = "amalgam_spawnpoint";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "nest_doppleghast_spawnpoint";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "QUARANTINE_ZONE_WINERY_COURTYARD", cf, ( 18354.8, 48946.6, 824 ), ( 0, 57.27, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_quarantine_zone_cs";
    fe [[ f ]]( s, "QUARANTINE_ZONE_WINERY_COURTYARD", cf, ( 18461.7, 49237.3, 824.06 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "OB_Spacer_Spatial_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 2000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_quarantine_zone_cs";
    s.groupid = "ai_encounter_spawnpoint";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "QUARANTINE_ZONE_WINERY_COURTYARD", cf, ( 18069.7, 49801.7, 976 ), ( 0, 2, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_quarantine_zone_cs";
    s.groupid = "ai_encounter_spawnpoint";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "QUARANTINE_ZONE_WINERY_COURTYARD", cf, ( 18640, 48703.2, 824 ), ( 0, 210, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_quarantine_zone_cs";
    s.groupid = "ai_encounter_spawnpoint";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "QUARANTINE_ZONE_WINERY_COURTYARD", cf, ( 18163.1, 48626.5, 824 ), ( 0, 12, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_quarantine_zone_cs";
    s.groupid = "ai_encounter_spawnpoint";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "QUARANTINE_ZONE_WINERY_COURTYARD", cf, ( 18464.2, 49091.5, 952 ), ( 0, 178, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_quarantine_zone_cs";
    s.groupid = "ai_encounter_spawnpoint";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "QUARANTINE_ZONE_WINERY_COURTYARD", cf, ( 18594.3, 48840.6, 824 ), ( 0, 142, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_quarantine_zone_cs";
    s.groupid = "ai_encounter_spawnpoint";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "QUARANTINE_ZONE_WINERY_COURTYARD", cf, ( 18475.2, 49801.2, 824 ), ( 0, 258, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_quarantine_zone_cs";
    s.groupid = "ai_encounter_spawnpoint";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "QUARANTINE_ZONE_WINERY_COURTYARD", cf, ( 18461.2, 49074.3, 824 ), ( 0, 54, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_quarantine_zone_cs";
    s.activity_bundle = "sat_activitydef_quarantine_zone";
    s.name = "QUARANTINE_ZONE_WINERY_COURTYARD";
    fe [[ f ]]( s, "QUARANTINE_ZONE_WINERY_COURTYARD", cf, ( 18399.5, 49395.7, 1401.5 ), ( 0, 280, 0 ), "activity_nexus_variant", "QUARANTINE_ZONE_WINERY_COURTYARD", undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace mp_sat_avalon_q2_ob_activity_quarantine_zone_cs
// Params 0, eflags: 0x4
// Checksum 0xd59dff4d, Offset: 0x2401
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace mp_sat_avalon_q2_ob_activity_quarantine_zone_cs
// Params 0
// Checksum 0x90370da1, Offset: 0x240b
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "mp_sat_avalon_q2_ob_activity_quarantine_zone_cs" );
}

// Namespace mp_sat_avalon_q2_ob_activity_quarantine_zone_cs
// Params 0
// Checksum 0xc6fe2ff, Offset: 0x2421
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

// Namespace mp_sat_avalon_q2_ob_activity_quarantine_zone_cs
// Params 4
// Checksum 0xe8c6a62f, Offset: 0x2490
// Size: 0x8b
function function_d4323822d7042e5a( var_4312b79c960726b6, fe, us, cf = "mp_sat_avalon_q2_ob_activity_quarantine_zone_cs" )
{
    switch ( var_4312b79c960726b6 )
    {
        case #"hash_178de4ffacd142ea":
            function_a7c788cee78f9ca2( fe, us, cf );
            break;
        case #"hash_6d1f7735700705b8":
            function_e0dc2eb2a22d5070( fe, us, cf );
            break;
        case #"hash_5be8d34c1d22d6dd":
            function_c42da6520bdd49f5( fe, us, cf );
            break;
    }
}

// Namespace mp_sat_avalon_q2_ob_activity_quarantine_zone_cs
// Params 3
// Checksum 0xb29c61af, Offset: 0x2523
// Size: 0x5b3
function function_a7c788cee78f9ca2( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_quarantine_zone_cs";
    s.name = "master_struct";
    fe [[ f ]]( s, "QUARANTINE_ZONE_PONY_CLUB", cf, ( 30243.4, 49779.9, 1384 ), ( 0, 3, 0 ), "QUARANTINE_ZONE_PONY_CLUB_main", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_quarantine_zone_cs";
    s.name = "safe_spawn_point";
    fe [[ f ]]( s, "QUARANTINE_ZONE_PONY_CLUB", cf, ( 29949.2, 49475, 1528 ), ( 0, 92, 0 ), undefined, "QUARANTINE_ZONE_PONY_CLUB_main", "s_safe_spawn", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_quarantine_zone_cs";
    s.groupid = "amalgam_spawn";
    fe [[ f ]]( s, "QUARANTINE_ZONE_PONY_CLUB", cf, ( 30076, 49539, 1528 ), ( 0, 105.88, 0 ), "s_quarantine_zone_pony_club_center", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_quarantine_zone_cs";
    fe [[ f ]]( s, "QUARANTINE_ZONE_PONY_CLUB", cf, ( 30293.2, 49197.5, 1914.73 ), ( 0, 97, 0 ), "QUARANTINE_ZONE_PONY_CLUB", "cspf_4_auto14135615458493372089", "contract_activity_chain", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_quarantine_zone_cs";
    s.script_label = "SUPPLY_DROP_PONY_CLUB";
    fe [[ f ]]( s, "QUARANTINE_ZONE_PONY_CLUB", cf, ( 30267, 49790.4, 1918.73 ), ( 0, 97, 0 ), "cspf_4_auto14135615458493372089", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_quarantine_zone_cs";
    s.groupid = "lock_door";
    fe [[ f ]]( s, "QUARANTINE_ZONE_PONY_CLUB", cf, ( 30607.7, 49844, 1386.76 ), ( 0, 0, 0 ), undefined, "QUARANTINE_ZONE_PONY_CLUB_main", "s_locked_door", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_quarantine_zone_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s._size_max = ( 32, 120, 32 );
    s._size_min = ( 32, 76, 32 );
    s.groupid = "entrance_trigger";
    s.height = 128;
    s.length = "128";
    s.width = "128";
    fe [[ f ]]( s, "QUARANTINE_ZONE_PONY_CLUB", cf, ( 30055.3, 50135.6, 1528 ), ( 0, 182, 0 ), "entrance_QUARANTINE_ZONE_PONY_CLUB", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_quarantine_zone_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s._size_max = ( 56, 88, 32 );
    s._size_min = ( 27, 100, 32 );
    s.groupid = "entrance_trigger";
    s.height = 128;
    s.length = "128";
    s.width = "128";
    fe [[ f ]]( s, "QUARANTINE_ZONE_PONY_CLUB", cf, ( 30552.5, 49843.5, 1384 ), ( 0, 2, 0 ), "entrance_QUARANTINE_ZONE_PONY_CLUB", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_quarantine_zone_cs";
    s.groupid = "lock_door";
    fe [[ f ]]( s, "QUARANTINE_ZONE_PONY_CLUB", cf, ( 30023.7, 50132.6, 1528.25 ), ( 0, 182.59, 0 ), undefined, "QUARANTINE_ZONE_PONY_CLUB_main", "s_locked_door", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_quarantine_zone_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s.height = 550;
    fe [[ f ]]( s, "QUARANTINE_ZONE_PONY_CLUB", cf, ( 30243.4, 49783.3, 1345.8 ), ( 1.32, 306.67, 2.49 ), "combat_volume_QUARANTINE_ZONE_PONY_CLUB", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 684 );
}

// Namespace mp_sat_avalon_q2_ob_activity_quarantine_zone_cs
// Params 3
// Checksum 0x2542ea9b, Offset: 0x2ade
// Size: 0x789
function function_e0dc2eb2a22d5070( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_quarantine_zone_cs";
    s.groupid = "lock_door";
    fe [[ f ]]( s, "QUARANTINE_ZONE_WINERY_FERMENTATION", cf, ( 11726.9, 43720.6, 769.86 ), ( 0, 169.35, 0 ), undefined, "QUARANTINE_ZONE_WINERY_FERMENTATION_main", "s_locked_rollup_door", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_quarantine_zone_cs";
    s.name = "master_struct";
    fe [[ f ]]( s, "QUARANTINE_ZONE_WINERY_FERMENTATION", cf, ( 12450.9, 43745.5, 718 ), ( 0, 0, 0 ), "QUARANTINE_ZONE_WINERY_FERMENTATION_main", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_quarantine_zone_cs";
    s.name = "safe_spawn_point";
    fe [[ f ]]( s, "QUARANTINE_ZONE_WINERY_FERMENTATION", cf, ( 11922.9, 43482.8, 859 ), ( 0, 169.09, 0 ), undefined, "QUARANTINE_ZONE_WINERY_FERMENTATION_main", "s_safe_spawn", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_quarantine_zone_cs";
    fe [[ f ]]( s, "QUARANTINE_ZONE_WINERY_FERMENTATION", cf, ( 11624.3, 43998.4, 1231.5 ), ( 0, 356, 0 ), "QUARANTINE_ZONE_WINERY_FERMENTATION", "cspf_5_auto14135615458493372089", "contract_activity_chain", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_quarantine_zone_cs";
    s.script_label = "SUPPLY_DROP_WINERY";
    fe [[ f ]]( s, "QUARANTINE_ZONE_WINERY_FERMENTATION", cf, ( 12352.8, 43894.8, 1235.5 ), ( 0, 356, 0 ), "cspf_5_auto14135615458493372089", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_quarantine_zone_cs";
    s.groupid = "lock_door";
    fe [[ f ]]( s, "QUARANTINE_ZONE_WINERY_FERMENTATION", cf, ( 11778.9, 44013.1, 770.86 ), ( 0, 169.35, 0 ), undefined, "QUARANTINE_ZONE_WINERY_FERMENTATION_main", "s_locked_rollup_door", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_quarantine_zone_cs";
    s.groupid = "lock_door";
    fe [[ f ]]( s, "QUARANTINE_ZONE_WINERY_FERMENTATION", cf, ( 13068.8, 43636.4, 768.5 ), ( 0, 349.35, 0 ), undefined, "QUARANTINE_ZONE_WINERY_FERMENTATION_main", "s_locked_rollup_door", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_quarantine_zone_cs";
    s.groupid = "lock_door";
    fe [[ f ]]( s, "QUARANTINE_ZONE_WINERY_FERMENTATION", cf, ( 13016.8, 43343.4, 770.5 ), ( 0, 349.35, 0 ), undefined, "QUARANTINE_ZONE_WINERY_FERMENTATION_main", "s_locked_rollup_door", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_quarantine_zone_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s._size_max = ( 32, 326, 32 );
    s._size_min = ( 32, 222, 32 );
    s.groupid = "entrance_trigger";
    s.height = 128;
    s.length = "128";
    s.width = "128";
    fe [[ f ]]( s, "QUARANTINE_ZONE_WINERY_FERMENTATION", cf, ( 13021.6, 43625.8, 715 ), ( 0, 349.17, 0 ), "entrance_QUARANTINE_ZONE_WINERY_FERMENTATION", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_quarantine_zone_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s._size_max = ( 32, 228, 32 );
    s._size_min = ( 32, 204, 32 );
    s.groupid = "entrance_trigger";
    s.height = 128;
    s.length = "128";
    s.width = "128";
    fe [[ f ]]( s, "QUARANTINE_ZONE_WINERY_FERMENTATION", cf, ( 11782.6, 43776.4, 715 ), ( 0, 349.17, 0 ), "entrance_QUARANTINE_ZONE_WINERY_FERMENTATION", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_quarantine_zone_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s._size_max = ( 32, 228, 32 );
    s._size_min = ( 32, 204, 32 );
    s.groupid = "entrance_trigger";
    s.height = 128;
    s.length = "128";
    s.width = "128";
    fe [[ f ]]( s, "QUARANTINE_ZONE_WINERY_FERMENTATION", cf, ( 12512.5, 44308.7, 715 ), ( 0, 349.17, 0 ), "entrance_QUARANTINE_ZONE_WINERY_FERMENTATION", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_quarantine_zone_cs";
    s.groupid = "amalgam_spawnpoint";
    fe [[ f ]]( s, "QUARANTINE_ZONE_WINERY_FERMENTATION", cf, ( 11930.9, 44188.3, 720.5 ), ( 0, 349.88, 0 ), "s_quarantine_zone_winery_fermentation_center", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_quarantine_zone_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s.height = 650;
    fe [[ f ]]( s, "QUARANTINE_ZONE_WINERY_FERMENTATION", cf, ( 12484, 43812, 700 ), ( 0, 0, 0 ), "combat_volume_QUARANTINE_ZONE_WINERY_FERMENTATION", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 1044 );
}

// Namespace mp_sat_avalon_q2_ob_activity_quarantine_zone_cs
// Params 3
// Checksum 0xa8639bd3, Offset: 0x326f
// Size: 0x87b
function function_c42da6520bdd49f5( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_quarantine_zone_cs";
    s.name = "master_struct";
    fe [[ f ]]( s, "QUARANTINE_ZONE_WINERY_COURTYARD", cf, ( 18400.3, 49227.5, 824.06 ), ( 0, 280, 0 ), "QUARANTINE_ZONE_WINERY_COURTYARD_main", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_quarantine_zone_cs";
    s.name = "safe_spawn_point";
    fe [[ f ]]( s, "QUARANTINE_ZONE_WINERY_COURTYARD", cf, ( 18420.4, 49227.2, 824 ), ( 0, 281.09, 0 ), undefined, "QUARANTINE_ZONE_WINERY_COURTYARD_main", "s_safe_spawn", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_quarantine_zone_cs";
    s.groupid = "amalgam_spawnpoint";
    fe [[ f ]]( s, "QUARANTINE_ZONE_WINERY_COURTYARD", cf, ( 18005.8, 48855.2, 996 ), ( 0, 105.88, 0 ), "s_quarantine_zone_winery_courtyard_center", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_quarantine_zone_cs";
    fe [[ f ]]( s, "QUARANTINE_ZONE_WINERY_COURTYARD", cf, ( 17906.1, 49121.6, 1335.04 ), ( 0, 14, 0 ), "QUARANTINE_ZONE_WINERY_COURTYARD", "cspf_6_auto14135615458493372089", "contract_activity_chain", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_quarantine_zone_cs";
    s.script_label = "SUPPLY_DROP_WINERY_COURTYARD";
    fe [[ f ]]( s, "QUARANTINE_ZONE_WINERY_COURTYARD", cf, ( 18491.4, 49219.8, 1339.04 ), ( 0, 14, 0 ), "cspf_6_auto14135615458493372089", "QUARANTINE_ZONE_WINERY_COURTYARD", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_quarantine_zone_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s._size_max = ( 32, 160, 32 );
    s._size_min = ( 32, 112, 32 );
    s.groupid = "entrance_trigger";
    s.height = 128;
    s.length = "128";
    s.width = "128";
    fe [[ f ]]( s, "QUARANTINE_ZONE_WINERY_COURTYARD", cf, ( 18093.5, 49246.8, 952 ), ( 0, 190, 0 ), "entrance_QUARANTINE_ZONE_WINERY_COURTYARD", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_quarantine_zone_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s._size_max = ( 56, 144, 32 );
    s._size_min = ( 27, 108, 32 );
    s.groupid = "entrance_trigger";
    s.height = 128;
    s.length = "128";
    s.width = "128";
    fe [[ f ]]( s, "QUARANTINE_ZONE_WINERY_COURTYARD", cf, ( 18374.3, 49010.2, 952 ), ( 0, 280, 0 ), "entrance_QUARANTINE_ZONE_WINERY_COURTYARD", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_quarantine_zone_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s._size_max = ( 32, 104, 32 );
    s._size_min = ( 32, 112, 32 );
    s.groupid = "entrance_trigger";
    s.height = 128;
    s.length = "128";
    s.width = "128";
    fe [[ f ]]( s, "QUARANTINE_ZONE_WINERY_COURTYARD", cf, ( 18766.5, 48729.8, 824 ), ( 0, 10, 0 ), "entrance_QUARANTINE_ZONE_WINERY_COURTYARD", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_quarantine_zone_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s.height = 650;
    fe [[ f ]]( s, "QUARANTINE_ZONE_WINERY_COURTYARD", cf, ( 18310, 49278.9, 794.18 ), ( 1.32, 306.67, 2.49 ), "combat_volume_QUARANTINE_ZONE_WINERY_COURTYARD", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 1080 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_quarantine_zone_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s._size_max = ( 32, 82, 32 );
    s._size_min = ( 32, 58, 32 );
    s.groupid = "entrance_trigger";
    s.height = 128;
    s.length = "128";
    s.width = "128";
    fe [[ f ]]( s, "QUARANTINE_ZONE_WINERY_COURTYARD", cf, ( 18214.4, 49893.2, 976 ), ( 0, 100, 0 ), "entrance_QUARANTINE_ZONE_WINERY_COURTYARD", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_quarantine_zone_cs";
    s.groupid = "lock_door";
    fe [[ f ]]( s, "QUARANTINE_ZONE_WINERY_COURTYARD", cf, ( 18376.2, 48955.1, 957.82 ), ( 0, 280.33, 0 ), undefined, "QUARANTINE_ZONE_WINERY_COURTYARD_main", "s_locked_door", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_quarantine_zone_cs";
    s.groupid = "lock_door";
    fe [[ f ]]( s, "QUARANTINE_ZONE_WINERY_COURTYARD", cf, ( 18066.2, 49226, 957.82 ), ( 0, 190.33, 0 ), undefined, "QUARANTINE_ZONE_WINERY_COURTYARD_main", "s_locked_door", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_quarantine_zone_cs";
    s.groupid = "lock_door";
    fe [[ f ]]( s, "QUARANTINE_ZONE_WINERY_COURTYARD", cf, ( 18233.2, 49932.9, 976 ), ( 0, 100.33, 0 ), undefined, "QUARANTINE_ZONE_WINERY_COURTYARD_main", "s_locked_door", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_quarantine_zone_cs";
    s.groupid = "lock_door";
    fe [[ f ]]( s, "QUARANTINE_ZONE_WINERY_COURTYARD", cf, ( 18813.7, 48707.5, 824 ), ( 0, 10.33, 0 ), undefined, "QUARANTINE_ZONE_WINERY_COURTYARD_main", "s_locked_door", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_sat_avalon_q2_ob_activity_quarantine_zone_cs
// Params 0
// Checksum 0xf9da772a, Offset: 0x3af2
// Size: 0x286
function function_d9dd7965c51c95d1()
{
    activityinstances = [];
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_activitydef_quarantine_zone";
    var_881289d7987bc770.cf = "mp_sat_avalon_q2_ob_activity_quarantine_zone_cs";
    var_881289d7987bc770.scriptstructorigin = ( 30236.7, 49831.9, 1904.15 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [ ( 30239.1, 49878, 1384 ) ];
    var_881289d7987bc770.var_31ce4477e3543d24 = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.locationradius = [ 900 ];
    activityinstances[ "QUARANTINE_ZONE_PONY_CLUB" ] = var_881289d7987bc770;
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_activitydef_quarantine_zone";
    var_881289d7987bc770.cf = "mp_sat_avalon_q2_ob_activity_quarantine_zone_cs";
    var_881289d7987bc770.scriptstructorigin = ( 12439.9, 43906.2, 1307.5 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [ ( 12446.9, 43937.5, 716 ) ];
    var_881289d7987bc770.var_31ce4477e3543d24 = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.locationradius = [ 900 ];
    activityinstances[ "QUARANTINE_ZONE_WINERY_FERMENTATION" ] = var_881289d7987bc770;
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_activitydef_quarantine_zone";
    var_881289d7987bc770.cf = "mp_sat_avalon_q2_ob_activity_quarantine_zone_cs";
    var_881289d7987bc770.scriptstructorigin = ( 18399.5, 49395.7, 1401.5 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [ ( 18461.7, 49237.3, 824.06 ) ];
    var_881289d7987bc770.var_31ce4477e3543d24 = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.locationradius = [ 900 ];
    activityinstances[ "QUARANTINE_ZONE_WINERY_COURTYARD" ] = var_881289d7987bc770;
    return activityinstances;
}

