// script_179c3b5f54442e86  (hash_179c3b5f54442e86.gscc) (size: 23336 Bytes / 0x5b28 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xa77dee81 (2810048129)
// size ...... 23336 (0x5b28)
// includes .. 4   (offset: 0x4b90)
// strings ... 48  (offset: 0x4bb0)
// dev strs .. 0   (offset: 0x5b28)
// exports ... 13  (offset: 0x46ac)
// cseg ...... 0x3d4 + 0x42d8 (0x46ac)
// imports ... 26  (offset: 0x48b4)
// animtree1 . 0   (offset: 0x5b28)
// animtree2 . 0   (offset: 0x5b28)
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace mp_sat_avalon_q2_ob_activity_red_flood_cs;

// Namespace mp_sat_avalon_q2_ob_activity_red_flood_cs
// Params 0, eflags: 0x5
// Checksum 0x78845d, Offset: 0x3f2
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"mp_sat_avalon_q2_ob_activity_red_flood_cs", #"activity_common", &function_b39ecd3d51489472, undefined );
}

// Namespace mp_sat_avalon_q2_ob_activity_red_flood_cs
// Params 0, eflags: 0x4
// Checksum 0x5bca64bb, Offset: 0x41b
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace mp_sat_avalon_q2_ob_activity_red_flood_cs
// Params 0, eflags: 0x4
// Checksum 0xdef1b757, Offset: 0x42c
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace mp_sat_avalon_q2_ob_activity_red_flood_cs
// Params 2
// Checksum 0x1a5d9701, Offset: 0x43d
// Size: 0x8c
function main( unused, unused2 )
{
    if ( utility::flag_exist( "mp_sat_avalon_q2_ob_activity_red_flood_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "mp_sat_avalon_q2_ob_activity_red_flood_cs" ) )
    {
        return;
    }
    
    activity_common::function_e1df676808c1d1e3( &function_4cd78e661617f3 );
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "mp_sat_avalon_q2_ob_activity_red_flood_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "mp_sat_avalon_q2_ob_activity_red_flood_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace mp_sat_avalon_q2_ob_activity_red_flood_cs
// Params 3, eflags: 0x4
// Checksum 0x5d730398, Offset: 0x4d1
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "mp_sat_avalon_q2_ob_activity_red_flood_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "mp_sat_avalon_q2_ob_activity_red_flood_cs" );
}

// Namespace mp_sat_avalon_q2_ob_activity_red_flood_cs
// Params 3, eflags: 0x4
// Checksum 0x3c409513, Offset: 0x54b
// Size: 0x20ae
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_red_flood_cs";
    s.activity_bundle = "sat_activity_definition_red_flood";
    s.name = "RED_FLOOD";
    fe [[ f ]]( s, "RED_FLOOD", cf, ( 28049.2, 29499, 3595.76 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_red_flood_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "500";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "red_flood_boss";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "RED_FLOOD", cf, ( -13941.3, 26148.3, 568.25 ), ( 0, 13.75, 0 ), undefined, undefined, "boss_spawn" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_red_flood_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "500";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "red_flood_boss";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "RED_FLOOD", cf, ( -11504.8, 22239.6, 680.13 ), ( 0, 13.75, 0 ), undefined, undefined, "boss_spawn" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_red_flood_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "500";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "red_flood_boss";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "RED_FLOOD", cf, ( -8917.25, 31754.4, 364.63 ), ( 0, 356.44, 0 ), undefined, undefined, "boss_spawn" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_red_flood_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "500";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "red_flood_boss";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "RED_FLOOD", cf, ( -5679.07, 21907.1, 560.42 ), ( 0, 13.75, 0 ), undefined, undefined, "boss_spawn" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_red_flood_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "500";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "red_flood_boss";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "RED_FLOOD", cf, ( -16829.9, 21958.7, 1643.85 ), ( 0, 13.75, 0 ), undefined, undefined, "boss_spawn" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_red_flood_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "500";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "red_flood_boss";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "RED_FLOOD", cf, ( -49920.1, 11432.1, 698.63 ), ( 0, 13.75, 0 ), undefined, undefined, "boss_spawn" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_red_flood_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "500";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "red_flood_boss";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "RED_FLOOD", cf, ( -48869.6, 14994.9, 444.23 ), ( 0, 13.75, 0 ), undefined, undefined, "boss_spawn" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_red_flood_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "500";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "red_flood_boss";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "RED_FLOOD", cf, ( -43363.1, 17458.5, 298.28 ), ( 0, 13.75, 0 ), undefined, undefined, "boss_spawn" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_red_flood_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "500";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "red_flood_boss";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "RED_FLOOD", cf, ( -44447.6, 7155.29, 124.66 ), ( 0, 299.03, 0 ), undefined, undefined, "boss_spawn" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_red_flood_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "500";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "red_flood_boss";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "RED_FLOOD", cf, ( 54295.8, 21919.6, 519 ), ( 0, 135.02, 0 ), undefined, undefined, "boss_spawn" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_red_flood_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "500";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "red_flood_boss";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "RED_FLOOD", cf, ( 48662.3, 19691.3, 322.33 ), ( 0, 135.02, 0 ), undefined, undefined, "boss_spawn" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_red_flood_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "500";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "red_flood_boss";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "RED_FLOOD", cf, ( 44889.9, 23548.9, 673.89 ), ( 0, 85.8, 0 ), undefined, undefined, "boss_spawn" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_red_flood_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "500";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "red_flood_boss";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "RED_FLOOD", cf, ( 46737.3, 30528.5, 893.27 ), ( 0, 283.8, 0 ), undefined, undefined, "boss_spawn" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_red_flood_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "500";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "red_flood_boss";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "RED_FLOOD", cf, ( 12635.2, -13759.3, 2926.31 ), ( 0, 37.93, 0 ), undefined, undefined, "boss_spawn" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_red_flood_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "500";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "red_flood_boss";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "RED_FLOOD", cf, ( 15855.1, -10945.7, 3359.55 ), ( 0, 37.93, 0 ), undefined, undefined, "boss_spawn" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_red_flood_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "500";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "red_flood_boss";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "RED_FLOOD", cf, ( 12757.6, -21467.6, 3599.89 ), ( 0, 37.93, 0 ), undefined, undefined, "boss_spawn" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_red_flood_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "500";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "red_flood_boss";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "RED_FLOOD", cf, ( 20190.2, -17113.4, 999.83 ), ( 0, 37.93, 0 ), undefined, undefined, "boss_spawn" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_red_flood_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "500";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "red_flood_boss";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "RED_FLOOD", cf, ( 6988.87, -14272.7, 1660.12 ), ( 0, 37.93, 0 ), undefined, undefined, "boss_spawn" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_red_flood_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "500";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "red_flood_boss";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "RED_FLOOD", cf, ( 43350.4, -42112.4, 1279.18 ), ( 0, 37.93, 0 ), undefined, undefined, "boss_spawn" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_red_flood_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "500";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "red_flood_boss";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "RED_FLOOD", cf, ( 36768.9, -41827.5, 996.64 ), ( 0, 37.93, 0 ), undefined, undefined, "boss_spawn" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_red_flood_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "500";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "red_flood_boss";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "RED_FLOOD", cf, ( 42502.8, -36853.8, 2140.35 ), ( 0, 37.93, 0 ), undefined, undefined, "boss_spawn" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_red_flood_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "500";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "red_flood_boss";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "RED_FLOOD", cf, ( 35159.1, -33777.6, 587.45 ), ( 0, 37.93, 0 ), undefined, undefined, "boss_spawn" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_red_flood_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "500";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "red_flood_boss_klaus";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "RED_FLOOD", cf, ( -28821, -35583.3, 932.17 ), ( 0, 254.04, 0 ), undefined, undefined, "boss_spawn" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_red_flood_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "500";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "red_flood_boss_neptune";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "RED_FLOOD", cf, ( -32548.5, -43994.1, 348.7 ), ( 0, 254.04, 0 ), undefined, undefined, "boss_spawn" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_red_flood_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "500";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "red_flood_boss_oscar";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "RED_FLOOD", cf, ( -23635.3, -34353.3, 560.08 ), ( 0, 298.12, 0 ), undefined, undefined, "boss_spawn" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_red_flood_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "500";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "red_flood_boss_neptune";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "RED_FLOOD", cf, ( -21810.3, -46937, 364.1 ), ( 0, 254.04, 0 ), undefined, undefined, "boss_spawn" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_red_flood_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "500";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "mimic";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "RED_FLOOD", cf, ( 12744.6, -16291.2, 3127.84 ), ( 0, 331.82, 0 ), undefined, undefined, "boss_spawn" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_red_flood_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "500";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "mangler";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "RED_FLOOD", cf, ( 13379.4, -17224.3, 3006.96 ), ( 0, 78.9, 0 ), undefined, undefined, "boss_spawn" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_red_flood_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "500";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "disciple";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "RED_FLOOD", cf, ( 14127.6, -16709.3, 2984.95 ), ( 0, 169.73, 0 ), undefined, undefined, "boss_spawn" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_red_flood_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "500";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "mimic";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "RED_FLOOD", cf, ( 48447.9, 24881, 809.18 ), ( 0, 326.92, 0 ), undefined, undefined, "boss_spawn" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_red_flood_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "500";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "mangler";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "RED_FLOOD", cf, ( 49049, 24287.6, 789 ), ( 0, 103.61, 0 ), undefined, undefined, "boss_spawn" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_red_flood_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "500";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "disciple";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "RED_FLOOD", cf, ( 49205.5, 25002.1, 812.56 ), ( 0, 242.69, 0 ), undefined, undefined, "boss_spawn" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_red_flood_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "500";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "mimic";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "RED_FLOOD", cf, ( -11555.7, 25784.1, 512 ), ( 0, 309.62, 0 ), undefined, undefined, "boss_spawn" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_red_flood_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "500";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "mangler";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "RED_FLOOD", cf, ( -11385, 24938.9, 520.26 ), ( 0, 50.7, 0 ), undefined, undefined, "boss_spawn" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_red_flood_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "500";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "disciple";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "RED_FLOOD", cf, ( -10529.8, 25074.7, 640 ), ( 0, 128.85, 0 ), undefined, undefined, "boss_spawn" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_red_flood_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "500";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "mimic";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "RED_FLOOD", cf, ( -45654.8, 12630.8, 336 ), ( 0, 269.53, 0 ), undefined, undefined, "boss_spawn" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_red_flood_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "500";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "mangler";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "RED_FLOOD", cf, ( -45657.6, 11167.5, 336 ), ( 0, 89.63, 0 ), undefined, undefined, "boss_spawn" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_red_flood_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "500";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "disciple";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "RED_FLOOD", cf, ( -46264.5, 11874.8, 336 ), ( 0, 0, 0 ), undefined, undefined, "boss_spawn" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_red_flood_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "500";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "mimic";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "RED_FLOOD", cf, ( -29630.8, -39663.9, 676.7 ), ( 0, 310.32, 0 ), undefined, undefined, "boss_spawn" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_red_flood_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "500";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "mangler";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "RED_FLOOD", cf, ( -29376.3, -40613.6, 650.93 ), ( 0, 104.29, 0 ), undefined, undefined, "boss_spawn" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_red_flood_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "500";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "disciple";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "RED_FLOOD", cf, ( -29982, -40110.8, 692.24 ), ( 0, 8.66, 0 ), undefined, undefined, "boss_spawn" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_red_flood_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "500";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "mimic";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "RED_FLOOD", cf, ( 37712.5, -38097.9, 1221 ), ( 0, 172.23, 0 ), undefined, undefined, "boss_spawn" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_red_flood_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "500";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "mangler";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "RED_FLOOD", cf, ( 36767.9, -38170.7, 1221 ), ( 0, 359.09, 0 ), undefined, undefined, "boss_spawn" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_red_flood_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "500";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "disciple";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "RED_FLOOD", cf, ( 37439.6, -37583, 1221 ), ( 0, 270.85, 0 ), undefined, undefined, "boss_spawn" );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace mp_sat_avalon_q2_ob_activity_red_flood_cs
// Params 0, eflags: 0x4
// Checksum 0xdd9234c, Offset: 0x2601
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace mp_sat_avalon_q2_ob_activity_red_flood_cs
// Params 0
// Checksum 0x9f20ded5, Offset: 0x260b
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "mp_sat_avalon_q2_ob_activity_red_flood_cs" );
}

// Namespace mp_sat_avalon_q2_ob_activity_red_flood_cs
// Params 0
// Checksum 0x4b05d474, Offset: 0x2621
// Size: 0x44
function function_4cd78e661617f3()
{
    activityinfostruct = {};
    activityinfostruct.mainfunction = &main;
    activityinfostruct.var_934f068483ae4ddb = &function_d4323822d7042e5a;
    activityinfostruct.metadatafunction = &function_d9dd7965c51c95d1;
    return activityinfostruct;
}

// Namespace mp_sat_avalon_q2_ob_activity_red_flood_cs
// Params 4
// Checksum 0x3bb31563, Offset: 0x266e
// Size: 0x57
function function_d4323822d7042e5a( var_4312b79c960726b6, fe, us, cf = "mp_sat_avalon_q2_ob_activity_red_flood_cs" )
{
    switch ( var_4312b79c960726b6 )
    {
        case #"hash_8b56e316298fcb7f":
            function_7f41e6c946203ea7( fe, us, cf );
            break;
    }
}

// Namespace mp_sat_avalon_q2_ob_activity_red_flood_cs
// Params 3
// Checksum 0x72b6ed1f, Offset: 0x26cd
// Size: 0x1f28
function function_7f41e6c946203ea7( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_red_flood_cs";
    s.groupid = "red_flood_casino";
    s.height = 4500;
    s.name = "casino_master";
    fe [[ f ]]( s, "RED_FLOOD", cf, ( -10782.5, 25969.1, -639.65 ), ( 0, 0, 0 ), undefined, undefined, "cradle_crate", "red_flood_casino_boss", "phase", undefined, undefined, 10500 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_red_flood_cs";
    s.name = "master";
    fe [[ f ]]( s, "RED_FLOOD", cf, ( 28036.3, 29507.7, 11060.7 ), ( 0, 0, 0 ), "RED_FLOOD", undefined, undefined, "phase" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_red_flood_cs";
    s.groupid = "red_flood_casino";
    s.name = "casino_boss";
    s.script_parameters = "boss_all";
    fe [[ f ]]( s, "RED_FLOOD", cf, ( -9216.77, 31953.6, 434.24 ), ( 0, 0, 0 ), undefined, undefined, "boss_spawn", undefined, "red_flood_casino_boss", undefined, undefined, 3000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_red_flood_cs";
    s.groupid = "red_flood_casino";
    s.name = "casino_boss";
    fe [[ f ]]( s, "RED_FLOOD", cf, ( -13750.6, 25953.7, 587.02 ), ( 0, 0, 0 ), undefined, undefined, "boss_spawn", undefined, "red_flood_casino_boss", undefined, undefined, 3000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_red_flood_cs";
    s.groupid = "red_flood_casino";
    s.name = "casino_boss";
    fe [[ f ]]( s, "RED_FLOOD", cf, ( -11328.8, 22356, 680.72 ), ( 0, 0, 0 ), undefined, undefined, "boss_spawn", undefined, "red_flood_casino_boss", undefined, undefined, 3000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_red_flood_cs";
    s.groupid = "red_flood_casino";
    fe [[ f ]]( s, "RED_FLOOD", cf, ( -11080.6, 25350.7, 448 ), ( 0, 220.62, 0 ), undefined, undefined, "cradle_crate", undefined, "red_flood_casino_boss" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_red_flood_cs";
    s.groupid = "red_flood_casino";
    s.name = "casino_boss";
    fe [[ f ]]( s, "RED_FLOOD", cf, ( -5765.16, 22029.5, 568 ), ( 0, 0, 0 ), undefined, undefined, "boss_spawn", undefined, "red_flood_casino_boss", undefined, undefined, 3000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_red_flood_cs";
    s.groupid = "red_flood_casino";
    s.name = "casino_boss";
    s.script_parameters = "boss_all";
    fe [[ f ]]( s, "RED_FLOOD", cf, ( -16703.2, 22050.3, 1664.29 ), ( 0, 0, 0 ), undefined, undefined, "boss_spawn", undefined, "red_flood_casino_boss", undefined, undefined, 3000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_red_flood_cs";
    s.groupid = "red_flood_stadium";
    fe [[ f ]]( s, "RED_FLOOD", cf, ( -45715.8, 11879.9, 464 ), ( 0, 180, 0 ), undefined, undefined, "cradle_crate", undefined, "red_flood_stadium_boss" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_red_flood_cs";
    s.groupid = "red_flood_colosseum";
    s.height = 4500;
    s.name = "colosseum_master";
    fe [[ f ]]( s, "RED_FLOOD", cf, ( 49177.8, 24496.1, -1891.88 ), ( 0, 0, 0 ), undefined, undefined, "cradle_crate", "red_flood_colosseum_boss", "phase", undefined, undefined, 10000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_red_flood_cs";
    s.groupid = "red_flood_colosseum";
    s.name = "colosseum_boss";
    fe [[ f ]]( s, "RED_FLOOD", cf, ( 54115.8, 21856.2, 519 ), ( 0, 0, 0 ), undefined, undefined, "boss_spawn", undefined, "red_flood_colosseum_boss", undefined, undefined, 3000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_red_flood_cs";
    s.groupid = "red_flood_stadium";
    s.name = "return_point";
    fe [[ f ]]( s, "RED_FLOOD", cf, ( -48069.6, 7764.61, 264 ), ( 0, 0, 0 ), undefined, undefined, "return_point", undefined, "red_flood_stadium_boss" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_red_flood_cs";
    s.groupid = "red_flood_stadium";
    s.name = "return_point";
    fe [[ f ]]( s, "RED_FLOOD", cf, ( -37746.3, 7014.26, 35.92 ), ( 0, 0, 0 ), undefined, undefined, "return_point", undefined, "red_flood_stadium_boss" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_red_flood_cs";
    s.groupid = "red_flood_stadium";
    s.name = "return_point";
    fe [[ f ]]( s, "RED_FLOOD", cf, ( -40623, 19705.6, 508.96 ), ( 0, 0, 0 ), undefined, undefined, "return_point", undefined, "red_flood_stadium_boss" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_red_flood_cs";
    s.groupid = "red_flood_stadium";
    s.name = "return_point";
    fe [[ f ]]( s, "RED_FLOOD", cf, ( -48043.1, 18466, 465.63 ), ( 0, 0, 0 ), undefined, undefined, "return_point", undefined, "red_flood_stadium_boss" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_red_flood_cs";
    s.groupid = "red_flood_stadium";
    s.height = 4500;
    s.name = "stadium_master";
    fe [[ f ]]( s, "RED_FLOOD", cf, ( -44846.3, 12520.9, -1239.5 ), ( 0, 0, 0 ), undefined, undefined, "cradle_crate", "red_flood_stadium_boss", "phase", undefined, undefined, 11350 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_red_flood_cs";
    s.groupid = "red_flood_shipyard";
    s.height = 6000;
    s.name = "shipyard_master";
    fe [[ f ]]( s, "RED_FLOOD", cf, ( 40010.5, -39117.8, -665.29 ), ( 0, 0, 0 ), undefined, undefined, "cradle_crate", "red_flood_shipyard_boss", "phase", undefined, undefined, 10000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_red_flood_cs";
    s.groupid = "red_flood_shipyard";
    s.name = "heliport_boss";
    s.script_parameters = "boss_all";
    fe [[ f ]]( s, "RED_FLOOD", cf, ( 43257.8, -42136, 1258.72 ), ( 0, 0, 0 ), undefined, undefined, "boss_spawn", undefined, "red_flood_shipyard_boss", undefined, undefined, 3000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_red_flood_cs";
    s.groupid = "red_flood_stadium";
    s.name = "stadium_boss";
    s.script_parameters = "boss_all";
    fe [[ f ]]( s, "RED_FLOOD", cf, ( -49853.3, 11437.1, 687.3 ), ( 0, 0, 0 ), undefined, undefined, "boss_spawn", undefined, "red_flood_stadium_boss", undefined, undefined, 3000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_red_flood_cs";
    s.groupid = "red_flood_stadium";
    s.name = "stadium_boss";
    s.script_parameters = "boss_all";
    fe [[ f ]]( s, "RED_FLOOD", cf, ( -48836.1, 14945.2, 442.45 ), ( 0, 0, 0 ), undefined, undefined, "boss_spawn", undefined, "red_flood_stadium_boss", undefined, undefined, 3000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_red_flood_cs";
    s.groupid = "red_flood_stadium";
    s.name = "stadium_boss";
    fe [[ f ]]( s, "RED_FLOOD", cf, ( -43436.5, 17566.5, 314.06 ), ( 0, 0, 0 ), undefined, undefined, "boss_spawn", undefined, "red_flood_stadium_boss", undefined, undefined, 3000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_red_flood_cs";
    s.groupid = "red_flood_stadium";
    s.name = "stadium_boss";
    fe [[ f ]]( s, "RED_FLOOD", cf, ( -44406.1, 7076.2, 119.27 ), ( 0, 0, 0 ), undefined, undefined, "boss_spawn", undefined, "red_flood_stadium_boss", undefined, undefined, 3000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_red_flood_cs";
    s.groupid = "red_flood_stadium";
    s.name = "return_point";
    fe [[ f ]]( s, "RED_FLOOD", cf, ( -52303.8, 14212.9, 1011.57 ), ( 0, 0, 0 ), undefined, undefined, "return_point", undefined, "red_flood_stadium_boss" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_red_flood_cs";
    s.groupid = "red_flood_colosseum";
    s.name = "colosseum_boss";
    fe [[ f ]]( s, "RED_FLOOD", cf, ( 48844.4, 20066.8, 365.75 ), ( 0, 0, 0 ), undefined, undefined, "boss_spawn", undefined, "red_flood_colosseum_boss", undefined, undefined, 3000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_red_flood_cs";
    s.groupid = "red_flood_colosseum";
    s.name = "colosseum_boss";
    fe [[ f ]]( s, "RED_FLOOD", cf, ( 44737.5, 23384.9, 673.89 ), ( 0, 0, 0 ), undefined, undefined, "boss_spawn", undefined, "red_flood_colosseum_boss", undefined, undefined, 3000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_red_flood_cs";
    s.groupid = "red_flood_casino";
    s.name = "return_point";
    fe [[ f ]]( s, "RED_FLOOD", cf, ( -5579.61, 21866.3, 560.1 ), ( 0, 0, 0 ), undefined, undefined, "return_point", undefined, "red_flood_casino_boss" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_red_flood_cs";
    s.groupid = "red_flood_casino";
    s.name = "return_point";
    fe [[ f ]]( s, "RED_FLOOD", cf, ( -9043.38, 19289.8, 560 ), ( 0, 0, 0 ), undefined, undefined, "return_point", undefined, "red_flood_casino_boss" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_red_flood_cs";
    s.groupid = "red_flood_casino";
    s.name = "return_point";
    fe [[ f ]]( s, "RED_FLOOD", cf, ( -16942.1, 21067.1, 1435.55 ), ( 0, 0, 0 ), undefined, undefined, "return_point", undefined, "red_flood_casino_boss" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_red_flood_cs";
    s.groupid = "red_flood_casino";
    s.name = "return_point";
    fe [[ f ]]( s, "RED_FLOOD", cf, ( -12251.2, 33560.4, 826.52 ), ( 0, 0, 0 ), undefined, undefined, "return_point", undefined, "red_flood_casino_boss" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_red_flood_cs";
    s.groupid = "red_flood_casino";
    s.name = "return_point";
    fe [[ f ]]( s, "RED_FLOOD", cf, ( -5908.65, 29799.7, 459.87 ), ( 0, 0, 0 ), undefined, undefined, "return_point", undefined, "red_flood_casino_boss" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_red_flood_cs";
    s.groupid = "red_flood_casino";
    s.name = "return_point";
    fe [[ f ]]( s, "RED_FLOOD", cf, ( -15943, 26342.7, 1017.77 ), ( 0, 0, 0 ), undefined, undefined, "return_point", undefined, "red_flood_casino_boss" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_red_flood_cs";
    s.groupid = "red_flood_colosseum";
    s.name = "colosseum_boss";
    s.script_parameters = "boss_all";
    fe [[ f ]]( s, "RED_FLOOD", cf, ( 46956.8, 30635.9, 882.29 ), ( 0, 0, 0 ), undefined, undefined, "boss_spawn", undefined, "red_flood_colosseum_boss", undefined, undefined, 3000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_red_flood_cs";
    s.groupid = "red_flood_colosseum";
    s.name = "return_point";
    fe [[ f ]]( s, "RED_FLOOD", cf, ( 54272.9, 21986, 519 ), ( 0, 0, 0 ), undefined, undefined, "return_point", undefined, "red_flood_colosseum_boss" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_red_flood_cs";
    s.groupid = "red_flood_colosseum";
    s.name = "return_point";
    fe [[ f ]]( s, "RED_FLOOD", cf, ( 48708.4, 19930.7, 364.98 ), ( 0, 0, 0 ), undefined, undefined, "return_point", undefined, "red_flood_colosseum_boss" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_red_flood_cs";
    s.groupid = "red_flood_colosseum";
    s.name = "return_point";
    fe [[ f ]]( s, "RED_FLOOD", cf, ( 43147.7, 19965.8, 486.37 ), ( 0, 0, 0 ), undefined, undefined, "return_point", undefined, "red_flood_colosseum_boss" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_red_flood_cs";
    s.groupid = "red_flood_colosseum";
    s.name = "return_point";
    fe [[ f ]]( s, "RED_FLOOD", cf, ( 45364.3, 28169.4, 835.91 ), ( 0, 0, 0 ), undefined, undefined, "return_point", undefined, "red_flood_colosseum_boss" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_red_flood_cs";
    s.groupid = "red_flood_colosseum";
    s.name = "return_point";
    fe [[ f ]]( s, "RED_FLOOD", cf, ( 53727.9, 27608.9, 856.45 ), ( 0, 0, 0 ), undefined, undefined, "return_point", undefined, "red_flood_colosseum_boss" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_red_flood_cs";
    s.groupid = "red_flood_heliport";
    s.height = 8500;
    s.name = "heliport_master";
    fe [[ f ]]( s, "RED_FLOOD", cf, ( 13546.2, -16338.6, -419.18 ), ( 0, 0, 0 ), undefined, undefined, "cradle_crate", "red_flood_heliport_boss", "phase", undefined, undefined, 11200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_red_flood_cs";
    s.groupid = "red_flood_heliport";
    s.name = "heliport_boss";
    fe [[ f ]]( s, "RED_FLOOD", cf, ( 12738.2, -13713.2, 2933.61 ), ( 0, 0, 0 ), undefined, undefined, "boss_spawn", undefined, "red_flood_heliport_boss", undefined, undefined, 2000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_red_flood_cs";
    s.groupid = "red_flood_heliport";
    s.name = "heliport_boss";
    s.script_parameters = "boss_all";
    fe [[ f ]]( s, "RED_FLOOD", cf, ( 15700.7, -10912.6, 3356.62 ), ( 0, 0, 0 ), undefined, undefined, "boss_spawn", undefined, "red_flood_heliport_boss", undefined, undefined, 2000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_red_flood_cs";
    s.groupid = "red_flood_heliport";
    fe [[ f ]]( s, "RED_FLOOD", cf, ( 13533.7, -16293.3, 3123.84 ), ( 0, 90, 0 ), undefined, undefined, "cradle_crate", undefined, "red_flood_heliport_boss" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_red_flood_cs";
    s.groupid = "red_flood_heliport";
    s.name = "heliport_boss";
    s.script_parameters = "boss_all";
    fe [[ f ]]( s, "RED_FLOOD", cf, ( 12988, -21482.8, 3591.42 ), ( 0, 0, 0 ), undefined, undefined, "boss_spawn", undefined, "red_flood_heliport_boss", undefined, undefined, 2000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_red_flood_cs";
    s.groupid = "red_flood_heliport";
    s.name = "heliport_boss";
    fe [[ f ]]( s, "RED_FLOOD", cf, ( 20033.8, -17441.8, 947.44 ), ( 0, 0, 0 ), undefined, undefined, "boss_spawn", undefined, "red_flood_heliport_boss", undefined, undefined, 2000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_red_flood_cs";
    s.groupid = "red_flood_heliport";
    s.name = "heliport_boss";
    fe [[ f ]]( s, "RED_FLOOD", cf, ( 7291.68, -14163.8, 1694.7 ), ( 0, 0, 0 ), undefined, undefined, "boss_spawn", undefined, "red_flood_heliport_boss", undefined, undefined, 2000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_red_flood_cs";
    s.groupid = "red_flood_heliport";
    s.name = "return_point";
    fe [[ f ]]( s, "RED_FLOOD", cf, ( 13680.3, -21982.8, 3467.81 ), ( 0, 0, 0 ), undefined, undefined, "return_point", undefined, "red_flood_heliport_boss" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_red_flood_cs";
    s.groupid = "red_flood_heliport";
    s.name = "return_point";
    fe [[ f ]]( s, "RED_FLOOD", cf, ( 8405.28, -16152.1, 1527.97 ), ( 0, 0, 0 ), undefined, undefined, "return_point", undefined, "red_flood_heliport_boss" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_red_flood_cs";
    s.groupid = "red_flood_heliport";
    s.name = "return_point";
    fe [[ f ]]( s, "RED_FLOOD", cf, ( 11257, -8793.6, 2114.45 ), ( 0, 0, 0 ), undefined, undefined, "return_point", undefined, "red_flood_heliport_boss" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_red_flood_cs";
    s.groupid = "red_flood_heliport";
    s.name = "return_point";
    fe [[ f ]]( s, "RED_FLOOD", cf, ( 16070.2, -10664.3, 3385.94 ), ( 0, 0, 0 ), undefined, undefined, "return_point", undefined, "red_flood_heliport_boss" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_red_flood_cs";
    s.groupid = "red_flood_heliport";
    s.name = "return_point";
    fe [[ f ]]( s, "RED_FLOOD", cf, ( 19483.8, -16701.2, 1214.61 ), ( 0, 0, 0 ), undefined, undefined, "return_point", undefined, "red_flood_heliport_boss" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_red_flood_cs";
    s.groupid = "red_flood_heliport";
    s.name = "return_point";
    fe [[ f ]]( s, "RED_FLOOD", cf, ( 19312.8, -20561.8, 1019.86 ), ( 0, 0, 0 ), undefined, undefined, "return_point", undefined, "red_flood_heliport_boss" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_red_flood_cs";
    s.groupid = "red_flood_shipyard";
    fe [[ f ]]( s, "RED_FLOOD", cf, ( 37234.8, -37952.8, 1221 ), ( 0, 90, 0 ), undefined, undefined, "cradle_crate", undefined, "red_flood_shipyard_boss" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_red_flood_cs";
    s.groupid = "red_flood_shipyard";
    s.name = "heliport_boss";
    fe [[ f ]]( s, "RED_FLOOD", cf, ( 36852.7, -41840.6, 980.43 ), ( 0, 0, 0 ), undefined, undefined, "boss_spawn", undefined, "red_flood_shipyard_boss", undefined, undefined, 3000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_red_flood_cs";
    s.groupid = "red_flood_colosseum";
    fe [[ f ]]( s, "RED_FLOOD", cf, ( 48881.1, 24614.4, 818 ), ( 0, 191.91, 0 ), undefined, undefined, "cradle_crate", undefined, "red_flood_colosseum_boss" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_red_flood_cs";
    s.groupid = "red_flood_shipyard";
    s.name = "heliport_boss";
    s.script_parameters = "boss_all";
    fe [[ f ]]( s, "RED_FLOOD", cf, ( 42424.3, -36907.4, 2147.38 ), ( 0, 0, 0 ), undefined, undefined, "boss_spawn", undefined, "red_flood_shipyard_boss", undefined, undefined, 3000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_red_flood_cs";
    s.groupid = "red_flood_shipyard";
    s.name = "heliport_boss";
    fe [[ f ]]( s, "RED_FLOOD", cf, ( 35270.4, -33723.1, 596.62 ), ( 0, 0, 0 ), undefined, undefined, "boss_spawn", undefined, "red_flood_shipyard_boss", undefined, undefined, 2000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_red_flood_cs";
    s.groupid = "red_flood_shipyard";
    s.name = "return_point";
    fe [[ f ]]( s, "RED_FLOOD", cf, ( 34375.3, -44643.2, 1043.9 ), ( 0, 0, 0 ), undefined, undefined, "return_point", undefined, "red_flood_shipyard_boss" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_red_flood_cs";
    s.groupid = "red_flood_shipyard";
    s.name = "return_point";
    fe [[ f ]]( s, "RED_FLOOD", cf, ( 32555.7, -40427.1, 1088.98 ), ( 0, 0, 0 ), undefined, undefined, "return_point", undefined, "red_flood_shipyard_boss" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_red_flood_cs";
    s.groupid = "red_flood_shipyard";
    s.name = "return_point";
    fe [[ f ]]( s, "RED_FLOOD", cf, ( 34787.3, -33983, 626.26 ), ( 0, 0, 0 ), undefined, undefined, "return_point", undefined, "red_flood_shipyard_boss" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_red_flood_cs";
    s.groupid = "red_flood_shipyard";
    s.name = "return_point";
    fe [[ f ]]( s, "RED_FLOOD", cf, ( 42784, -36771.9, 2117.29 ), ( 0, 0, 0 ), undefined, undefined, "return_point", undefined, "red_flood_shipyard_boss" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_red_flood_cs";
    s.groupid = "red_flood_shipyard";
    s.name = "return_point";
    fe [[ f ]]( s, "RED_FLOOD", cf, ( 43352.1, -42211.3, 1268.36 ), ( 0, 0, 0 ), undefined, undefined, "return_point", undefined, "red_flood_shipyard_boss" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_red_flood_cs";
    s.groupid = "red_flood_shipyard";
    s.name = "return_point";
    fe [[ f ]]( s, "RED_FLOOD", cf, ( 40920.4, -46732.6, 634.08 ), ( 0, 0, 0 ), undefined, undefined, "return_point", undefined, "red_flood_shipyard_boss" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_red_flood_cs";
    s.groupid = "red_flood_fort";
    s.height = 5500;
    s.name = "fort_master";
    fe [[ f ]]( s, "RED_FLOOD", cf, ( -28227.6, -40742.6, -827.3 ), ( 0, 0, 0 ), undefined, undefined, "cradle_crate", "red_flood_fort_boss", "phase", undefined, undefined, 12500 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_red_flood_cs";
    s.groupid = "red_flood_fort";
    s.name = "return_point";
    fe [[ f ]]( s, "RED_FLOOD", cf, ( -32804, -44020, 416.08 ), ( 0, 0, 0 ), undefined, undefined, "return_point", undefined, "red_flood_fort_boss" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_red_flood_cs";
    s.groupid = "red_flood_fort";
    s.name = "fort_boss";
    fe [[ f ]]( s, "RED_FLOOD", cf, ( -28910.1, -35514.1, 921.12 ), ( 0, 0, 0 ), undefined, undefined, "boss_spawn", undefined, "red_flood_fort_boss", undefined, undefined, 3000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_red_flood_cs";
    s.groupid = "red_flood_fort";
    s.name = "fort_boss";
    fe [[ f ]]( s, "RED_FLOOD", cf, ( -32760, -43858.7, 402.26 ), ( 0, 0, 0 ), undefined, undefined, "boss_spawn", undefined, "red_flood_fort_boss", undefined, undefined, 3000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_red_flood_cs";
    s.groupid = "red_flood_fort";
    s.name = "return_point";
    fe [[ f ]]( s, "RED_FLOOD", cf, ( -21849.6, -46404.6, 384.74 ), ( 0, 0, 0 ), undefined, undefined, "return_point", undefined, "red_flood_fort_boss" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_red_flood_cs";
    s.groupid = "red_flood_fort";
    s.name = "return_point";
    fe [[ f ]]( s, "RED_FLOOD", cf, ( -23740.2, -33771.3, 634.54 ), ( 0, 0, 0 ), undefined, undefined, "return_point", undefined, "red_flood_fort_boss" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_red_flood_cs";
    s.groupid = "red_flood_fort";
    s.name = "return_point";
    fe [[ f ]]( s, "RED_FLOOD", cf, ( -28636.9, -35557, 952 ), ( 0, 0, 0 ), undefined, undefined, "return_point", undefined, "red_flood_fort_boss" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_red_flood_cs";
    s.groupid = "red_flood_fort";
    s.name = "fort_boss";
    fe [[ f ]]( s, "RED_FLOOD", cf, ( -23725.3, -34330.9, 583.43 ), ( 0, 0, 0 ), undefined, undefined, "boss_spawn", undefined, "red_flood_fort_boss", undefined, undefined, 3000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_red_flood_cs";
    s.groupid = "red_flood_fort";
    fe [[ f ]]( s, "RED_FLOOD", cf, ( -29098.2, -40131.2, 677.67 ), ( 0, 331.76, 0 ), undefined, undefined, "cradle_crate", undefined, "red_flood_fort_boss" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_red_flood_cs";
    s.groupid = "red_flood_fort";
    s.name = "fort_boss";
    s.script_parameters = "boss_all";
    fe [[ f ]]( s, "RED_FLOOD", cf, ( -21838.5, -47093.8, 354.01 ), ( 0, 0, 0 ), undefined, undefined, "boss_spawn", undefined, "red_flood_fort_boss", undefined, undefined, 3000 );
}

// Namespace mp_sat_avalon_q2_ob_activity_red_flood_cs
// Params 0
// Checksum 0x612e28d6, Offset: 0x45fd
// Size: 0xae
function function_d9dd7965c51c95d1()
{
    activityinstances = [];
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_activity_definition_red_flood";
    var_881289d7987bc770.cf = "mp_sat_avalon_q2_ob_activity_red_flood_cs";
    var_881289d7987bc770.scriptstructorigin = ( 28049.2, 29499, 3595.76 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [];
    var_881289d7987bc770.var_31ce4477e3543d24 = [];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [];
    var_881289d7987bc770.locationradius = [];
    activityinstances[ "RED_FLOOD" ] = var_881289d7987bc770;
    return activityinstances;
}

