// script_5817ef14af2ac1  (hash_005817ef14af2ac1.gscc) (size: 19800 Bytes / 0x4d58 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x7d89e7ea (2106189802)
// size ...... 19800 (0x4d58)
// includes .. 4   (offset: 0x4324)
// strings ... 74  (offset: 0x4344)
// dev strs .. 0   (offset: 0x4d58)
// exports ... 16  (offset: 0x3d68)
// cseg ...... 0x8e6 + 0x3482 (0x3d68)
// imports ... 29  (offset: 0x3fe8)
// animtree1 . 0   (offset: 0x4d58)
// animtree2 . 0   (offset: 0x4d58)
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace mp_sat_avalon_q4_ob_contract_mystery_cargo_cs;

// Namespace mp_sat_avalon_q4_ob_contract_mystery_cargo_cs
// Params 0, eflags: 0x5
// Checksum 0x8345a207, Offset: 0x904
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"mp_sat_avalon_q4_ob_contract_mystery_cargo_cs", #"activity_common", &function_b39ecd3d51489472, undefined );
}

// Namespace mp_sat_avalon_q4_ob_contract_mystery_cargo_cs
// Params 0, eflags: 0x4
// Checksum 0x18bba4a8, Offset: 0x92d
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace mp_sat_avalon_q4_ob_contract_mystery_cargo_cs
// Params 0, eflags: 0x4
// Checksum 0x9d807744, Offset: 0x93e
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace mp_sat_avalon_q4_ob_contract_mystery_cargo_cs
// Params 2
// Checksum 0xe3210cf0, Offset: 0x94f
// Size: 0x8c
function main( unused, unused2 )
{
    if ( utility::flag_exist( "mp_sat_avalon_q4_ob_contract_mystery_cargo_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "mp_sat_avalon_q4_ob_contract_mystery_cargo_cs" ) )
    {
        return;
    }
    
    activity_common::function_e1df676808c1d1e3( &function_4cd78e661617f3 );
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "mp_sat_avalon_q4_ob_contract_mystery_cargo_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "mp_sat_avalon_q4_ob_contract_mystery_cargo_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace mp_sat_avalon_q4_ob_contract_mystery_cargo_cs
// Params 3, eflags: 0x4
// Checksum 0x1e02c38b, Offset: 0x9e3
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "mp_sat_avalon_q4_ob_contract_mystery_cargo_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "mp_sat_avalon_q4_ob_contract_mystery_cargo_cs" );
}

// Namespace mp_sat_avalon_q4_ob_contract_mystery_cargo_cs
// Params 3, eflags: 0x4
// Checksum 0x4bab2a1b, Offset: 0xa5d
// Size: 0x15ad
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_mystery_cargo_cs";
    fe [[ f ]]( s, "MYSTERY_CARGO_AQUEDUCT", cf, ( 40171, 5063, 1550 ), ( 0, 155, 0 ), "activity_nexus_instance_joiner", "MYSTERY_CARGO_AQUEDUCT", undefined, undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_mystery_cargo_cs";
    s._size_max = ( 326, 898, 888 );
    s._size_min = ( 1000, 994, 202 );
    s.var_5afd49978f924648 = "1";
    s.var_a8568d8e0b0b6076 = "1";
    s.var_3f3960eb7318312d = "1";
    s.default_goal_radius = "-1";
    s.height = 128;
    s.length = "128";
    s.script_stealthgroup = "-1";
    s.script_string = "enc_mystery_cargo_helicopter1";
    s.var_95e2cee7aca5aaae = "1";
    s.width = "128";
    fe [[ f ]]( s, "MYSTERY_CARGO_AQUEDUCT", cf, ( 37742.8, -1173.74, 366.16 ), ( 0, 191.2, 0 ), "MYSTERY_CARGO_AQUEDUCT1", undefined, "noent_volume_ai_encounter_cs", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_mystery_cargo_cs";
    s.activity_bundle = "ob_contract_activitydefinition_mystery_cargo";
    s.name = "MYSTERY_CARGO_AQUEDUCT";
    fe [[ f ]]( s, "MYSTERY_CARGO_AQUEDUCT", cf, ( 38775, -1201, 535.95 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_mystery_cargo_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "mystery_cargo_vtol2";
    s.variantname = "ai_encounter_spawnpoint";
    s.var_4501e0172e168ddf = "AQUEDUCT_EAST_MYSTERYCARGO_VTOL_02";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "MYSTERY_CARGO_AQUEDUCT", cf, ( 39390.1, -825.33, 639.82 ), ( 0, 205.91, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_mystery_cargo_cs";
    s._size_max = ( 1180, 624, 802 );
    s._size_min = ( 676, 624, 442 );
    s.var_5afd49978f924648 = "1";
    s.var_a8568d8e0b0b6076 = "1";
    s.var_3f3960eb7318312d = "1";
    s.default_goal_radius = "-1";
    s.height = 128;
    s.length = "128";
    s.script_stealthgroup = "-1";
    s.script_string = "enc_mystery_cargo_helicopter2";
    s.var_95e2cee7aca5aaae = "1";
    s.width = "128";
    fe [[ f ]]( s, "MYSTERY_CARGO_AQUEDUCT", cf, ( 39288.8, -596.25, 646.42 ), ( 0, 281.6, 0 ), "MYSTERY_CARGO_AQUEDUCT2", undefined, "noent_volume_ai_encounter_cs", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_mystery_cargo_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "mystery_cargo_vtol1";
    s.variantname = "ai_encounter_spawnpoint";
    s.var_4501e0172e168ddf = "AQUEDUCT_EAST_MYSTERYCARGO_VTOL_01";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "MYSTERY_CARGO_AQUEDUCT", cf, ( 38507.6, -1704.24, 481.32 ), ( 0, 330.91, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_mystery_cargo_cs";
    fe [[ f ]]( s, "MYSTERY_CARGO_FIRE_STATION", cf, ( 42370.7, -28748.4, 340 ), ( 0, 58.06, 0 ), "activity_nexus_instance_joiner", "MYSTERY_CARGO_FIRE_STATION", undefined, undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_mystery_cargo_cs";
    s._size_max = ( 848, 320, 820 );
    s._size_min = ( 760, 926, 336 );
    s.var_5afd49978f924648 = "1";
    s.var_a8568d8e0b0b6076 = "1";
    s.var_3f3960eb7318312d = "1";
    s.default_goal_radius = "-1";
    s.height = 128;
    s.length = "128";
    s.script_stealthgroup = "-1";
    s.script_string = "enc_mystery_cargo_helicopter1";
    s.var_95e2cee7aca5aaae = "1";
    s.width = "128";
    fe [[ f ]]( s, "MYSTERY_CARGO_FIRE_STATION", cf, ( 38985.6, -35782.9, 1235.74 ), ( 0, 318, -0 ), "MYSTERY_CARGO_FIRE_STATION1", undefined, "noent_volume_ai_encounter_cs", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_mystery_cargo_cs";
    s.activity_bundle = "ob_contract_activitydefinition_mystery_cargo";
    s.name = "MYSTERY_CARGO_FIRE_STATION";
    fe [[ f ]]( s, "MYSTERY_CARGO_FIRE_STATION", cf, ( 39721, -35963, 1333 ), ( 0, 300.8, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_mystery_cargo_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "mystery_cargo_vtol1";
    s.variantname = "ai_encounter_spawnpoint";
    s.var_4501e0172e168ddf = "FIRE_STATION_MYSTERYCARGO_VTOL_01";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "MYSTERY_CARGO_FIRE_STATION", cf, ( 39079.1, -36106.8, 1240.82 ), ( 0, 52.01, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_mystery_cargo_cs";
    s._size_max = ( 776, 1388, 678 );
    s._size_min = ( 1296, -46, 418 );
    s.var_5afd49978f924648 = "1";
    s.var_a8568d8e0b0b6076 = "1";
    s.var_3f3960eb7318312d = "1";
    s.default_goal_radius = "-1";
    s.height = 128;
    s.length = "128";
    s.script_stealthgroup = "-1";
    s.script_string = "enc_mystery_cargo_helicopter2";
    s.var_95e2cee7aca5aaae = "1";
    s.width = "128";
    fe [[ f ]]( s, "MYSTERY_CARGO_FIRE_STATION", cf, ( 40611.7, -35041.8, 1465.67 ), ( 0, 47.6, 0 ), "MYSTERY_CARGO_FIRE_STATION2", undefined, "noent_volume_ai_encounter_cs", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_mystery_cargo_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "mystery_cargo_vtol2";
    s.variantname = "ai_encounter_spawnpoint";
    s.var_4501e0172e168ddf = "FIRE_STATION_MYSTERYCARGO_VTOL_02";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "MYSTERY_CARGO_FIRE_STATION", cf, ( 39660.2, -34634.8, 1206.82 ), ( 0, 238.41, -0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_mystery_cargo_cs";
    fe [[ f ]]( s, "MYSTERY_CARGO_TOWER", cf, ( 6479.5, -17680.5, 1086 ), ( 0, 56.61, 0 ), "activity_nexus_instance_joiner", "MYSTERY_CARGO_TOWER", undefined, undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_mystery_cargo_cs";
    s._size_max = ( 961, 460, 674 );
    s._size_min = ( 623, 697, 378 );
    s.var_5afd49978f924648 = "1";
    s.var_a8568d8e0b0b6076 = "1";
    s.var_3f3960eb7318312d = "1";
    s.default_goal_radius = "-1";
    s.height = 128;
    s.length = "128";
    s.script_stealthgroup = "-1";
    s.script_string = "enc_mystery_cargo_helicopter2";
    s.var_95e2cee7aca5aaae = "1";
    s.width = "128";
    fe [[ f ]]( s, "MYSTERY_CARGO_TOWER", cf, ( 12057.3, -25873.9, 3798.76 ), ( 0, 85, 0 ), "MYSTERY_CARGO_TOWER2", undefined, "noent_volume_ai_encounter_cs", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_mystery_cargo_cs";
    s.activity_bundle = "ob_contract_activitydefinition_mystery_cargo";
    s.name = "MYSTERY_CARGO_TOWER";
    fe [[ f ]]( s, "MYSTERY_CARGO_TOWER", cf, ( 11949, -24881, 3817 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_mystery_cargo_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "mystery_cargo_vtol1";
    s.variantname = "ai_encounter_spawnpoint";
    s.var_4501e0172e168ddf = "TOWER_MYSTERYCARGO_VTOL_01";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "MYSTERY_CARGO_TOWER", cf, ( 12265.5, -23912.2, 3789.82 ), ( 0, 253.11, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_mystery_cargo_cs";
    s._size_max = ( 961, 460, 674 );
    s._size_min = ( 623, 697, 378 );
    s.var_5afd49978f924648 = "1";
    s.var_a8568d8e0b0b6076 = "1";
    s.var_3f3960eb7318312d = "1";
    s.default_goal_radius = "-1";
    s.height = 128;
    s.length = "128";
    s.script_stealthgroup = "-1";
    s.script_string = "enc_mystery_cargo_helicopter1";
    s.var_95e2cee7aca5aaae = "1";
    s.width = "128";
    fe [[ f ]]( s, "MYSTERY_CARGO_TOWER", cf, ( 12199.3, -24250.9, 3798.76 ), ( 0, 85, 0 ), "MYSTERY_CARGO_TOWER1", undefined, "noent_volume_ai_encounter_cs", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_mystery_cargo_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "mystery_cargo_vtol2";
    s.variantname = "ai_encounter_spawnpoint";
    s.var_4501e0172e168ddf = "TOWER_MYSTERYCARGO_VTOL_02";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "MYSTERY_CARGO_TOWER", cf, ( 11948.7, -25878.6, 3855.82 ), ( 0, 55.31, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_mystery_cargo_cs";
    s.name = "script_struct_nexus_activity_joiner";
    fe [[ f ]]( s, "MYSTERY_CARGO_NEIGHBORHOOD", cf, ( 6972, -9765, 2006 ), ( 0, 318.6, 0 ), "activity_nexus_instance_joiner", "MYSTERY_CARGO_NEIGHBORHOOD", undefined, undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_mystery_cargo_cs";
    s._size_max = ( 1116, 652, 952 );
    s._size_min = ( 870, 1450, 150 );
    s.var_5afd49978f924648 = "1";
    s.var_a8568d8e0b0b6076 = "1";
    s.var_3f3960eb7318312d = "1";
    s.default_goal_radius = "-1";
    s.height = 128;
    s.length = "128";
    s.script_stealthgroup = "-1";
    s.script_string = "enc_mystery_cargo_helicopter1";
    s.var_95e2cee7aca5aaae = "1";
    s.width = "128";
    fe [[ f ]]( s, "MYSTERY_CARGO_NEIGHBORHOOD", cf, ( -701.58, -20864.4, 314.48 ), ( 0, 270, 0 ), "MYSTERY_CARGO_NEIGHBORHOOD1", undefined, "noent_volume_ai_encounter_cs", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_mystery_cargo_cs";
    s.activity_bundle = "ob_contract_activitydefinition_mystery_cargo";
    s.name = "MYSTERY_CARGO_NEIGHBORHOOD";
    fe [[ f ]]( s, "MYSTERY_CARGO_NEIGHBORHOOD", cf, ( -64, -20654, 346.34 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_mystery_cargo_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "mystery_cargo_vtol1";
    s.variantname = "ai_encounter_spawnpoint";
    s.var_4501e0172e168ddf = "NEIGHBORHOOD_MYSTERYCARGO_VTOL_01";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "MYSTERY_CARGO_NEIGHBORHOOD", cf, ( -1685.13, -20929, 170.82 ), ( 0, 4.01, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_mystery_cargo_cs";
    s._size_max = ( 932, 1024, 952 );
    s._size_min = ( 694, 952, 50 );
    s.var_5afd49978f924648 = "1";
    s.var_a8568d8e0b0b6076 = "1";
    s.var_3f3960eb7318312d = "1";
    s.default_goal_radius = "-1";
    s.height = 128;
    s.length = "128";
    s.script_stealthgroup = "-1";
    s.script_string = "enc_mystery_cargo_helicopter2";
    s.var_95e2cee7aca5aaae = "1";
    s.width = "128";
    fe [[ f ]]( s, "MYSTERY_CARGO_NEIGHBORHOOD", cf, ( 956.42, -20688.4, 158.54 ), ( 0, 270, 0 ), "MYSTERY_CARGO_NEIGHBORHOOD2", undefined, "noent_volume_ai_encounter_cs", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_mystery_cargo_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "mystery_cargo_vtol2";
    s.variantname = "ai_encounter_spawnpoint";
    s.var_4501e0172e168ddf = "NEIGHBORHOOD_MYSTERYCARGO_VTOL_02";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "MYSTERY_CARGO_NEIGHBORHOOD", cf, ( 568.15, -20968.5, 344.82 ), ( 0, 170.31, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace mp_sat_avalon_q4_ob_contract_mystery_cargo_cs
// Params 0, eflags: 0x4
// Checksum 0xf4a5b8bd, Offset: 0x2012
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace mp_sat_avalon_q4_ob_contract_mystery_cargo_cs
// Params 0
// Checksum 0xdc511ec6, Offset: 0x201c
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "mp_sat_avalon_q4_ob_contract_mystery_cargo_cs" );
}

// Namespace mp_sat_avalon_q4_ob_contract_mystery_cargo_cs
// Params 0
// Checksum 0xff7f69e6, Offset: 0x2032
// Size: 0x66
function function_4cd78e661617f3()
{
    activityinfostruct = {};
    activityinfostruct.name = "REV_OB_MYSTERY_CARGO";
    activityinfostruct.scriptbundle = "ob_contract_activitydefinition_mystery_cargo";
    activityinfostruct.mainfunction = &main;
    activityinfostruct.var_934f068483ae4ddb = &function_d4323822d7042e5a;
    activityinfostruct.metadatafunction = &function_d9dd7965c51c95d1;
    return activityinfostruct;
}

// Namespace mp_sat_avalon_q4_ob_contract_mystery_cargo_cs
// Params 4
// Checksum 0x15f80221, Offset: 0x20a1
// Size: 0xa5
function function_d4323822d7042e5a( var_4312b79c960726b6, fe, us, cf = "mp_sat_avalon_q4_ob_contract_mystery_cargo_cs" )
{
    switch ( var_4312b79c960726b6 )
    {
        case #"hash_303207ed588329b6":
            function_557cec22b7f0548e( fe, us, cf );
            break;
        case #"hash_50c4d83090fc2f99":
            function_4df09c1cb7401021( fe, us, cf );
            break;
        case #"hash_e3e2aeae96e28e1f":
            function_869bead39c9e5d37( fe, us, cf );
            break;
        case #"hash_8723dc975624d0ee":
            function_d7267e14ae22b3f6( fe, us, cf );
            break;
    }
}

// Namespace mp_sat_avalon_q4_ob_contract_mystery_cargo_cs
// Params 3
// Checksum 0x7e8591cf, Offset: 0x214e
// Size: 0x663
function function_557cec22b7f0548e( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_mystery_cargo_cs";
    s.name = "cargo_container";
    fe [[ f ]]( s, "MYSTERY_CARGO_AQUEDUCT", cf, ( 38764, -1209, 534 ), ( 0, 90, 0 ), "activity_nexus_variant", undefined, "MYSTERY_CARGO_AQUEDUCT", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_mystery_cargo_cs";
    s.groupid = "reinforcement_spawn_point_01";
    s.ishelistruct = 1;
    s.script_accel = "350";
    fe [[ f ]]( s, "MYSTERY_CARGO_AQUEDUCT", cf, ( 38463.3, -1592.84, 1100.92 ), ( 0, 4.1, 0 ), "AQUEDUCT_EAST_MYSTERYCARGO_VTOL_01", "cspf_5_auto3378833844094279436", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_mystery_cargo_cs";
    s.groupid = "reinforcement_spawn_point_01";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MYSTERY_CARGO_AQUEDUCT", cf, ( 56860.8, -1140.21, 5035.35 ), ( 359.47, 0, 0.5 ), "cspf_5_auto537692158296776830", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_mystery_cargo_cs";
    s.groupid = "reinforcement_spawn_point_01";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MYSTERY_CARGO_AQUEDUCT", cf, ( 37618.4, 14282.3, 5354.7 ), ( 0, 289.04, 0 ), undefined, "cspf_5_auto13918011251922956337", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150, 1 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_mystery_cargo_cs";
    s.groupid = "reinforcement_spawn_point_01";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MYSTERY_CARGO_AQUEDUCT", cf, ( 43031.1, -1147.08, 3459.22 ), ( 359.47, 0, 0.5 ), "cspf_5_auto3378833844094279436", "cspf_5_auto537692158296776830", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_mystery_cargo_cs";
    s.groupid = "reinforcement_spawn_point_01";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MYSTERY_CARGO_AQUEDUCT", cf, ( 36266.4, 3450.31, 3998.54 ), ( 0, 200.92, 0 ), "cspf_5_auto13918011251922956337", "AQUEDUCT_EAST_MYSTERYCARGO_VTOL_01", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_mystery_cargo_cs";
    s.groupid = "reinforcement_spawn_point_02";
    s.ishelistruct = 1;
    s.script_accel = "350";
    fe [[ f ]]( s, "MYSTERY_CARGO_AQUEDUCT", cf, ( 39506.8, -852.9, 1259.42 ), ( 0, 211.51, 0 ), "AQUEDUCT_EAST_MYSTERYCARGO_VTOL_02", "cspf_5_auto13411782576134045474", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_mystery_cargo_cs";
    s.groupid = "reinforcement_spawn_point_02";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MYSTERY_CARGO_AQUEDUCT", cf, ( 28166.9, 1112.82, 4849.6 ), ( 359.47, 164.73, 0.5 ), "cspf_5_auto16213326393526512306", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_mystery_cargo_cs";
    s.groupid = "reinforcement_spawn_point_02";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MYSTERY_CARGO_AQUEDUCT", cf, ( 53374.1, -1470.66, 5415.7 ), ( 0, 185.03, 0 ), undefined, "cspf_5_auto14719648745708270423", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150, 1 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_mystery_cargo_cs";
    s.groupid = "reinforcement_spawn_point_02";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MYSTERY_CARGO_AQUEDUCT", cf, ( 33873.5, -280.8, 3253.72 ), ( 359.47, 164.73, 0.5 ), "cspf_5_auto13411782576134045474", "cspf_5_auto16213326393526512306", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_mystery_cargo_cs";
    s.groupid = "reinforcement_spawn_point_02";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MYSTERY_CARGO_AQUEDUCT", cf, ( 41863.9, -590.4, 4059.54 ), ( 0, 96.92, 0 ), "cspf_5_auto14719648745708270423", "AQUEDUCT_EAST_MYSTERYCARGO_VTOL_02", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_mystery_cargo_cs";
    s.name = "ability_crate";
    fe [[ f ]]( s, "MYSTERY_CARGO_AQUEDUCT", cf, ( 38762.4, -1185.68, 548.54 ), ( 0, 0.98, 0 ), "ability_case_MYSTERY_CARGO_AQUEDUCT", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_sat_avalon_q4_ob_contract_mystery_cargo_cs
// Params 3
// Checksum 0xc3a3026d, Offset: 0x27b9
// Size: 0x663
function function_4df09c1cb7401021( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_mystery_cargo_cs";
    s.name = "cargo_container";
    fe [[ f ]]( s, "MYSTERY_CARGO_FIRE_STATION", cf, ( 39721, -35965, 1334 ), ( 0, 168.1, 0 ), "activity_nexus_variant", undefined, "MYSTERY_CARGO_FIRE_STATION", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_mystery_cargo_cs";
    s.groupid = "reinforcement_spawn_point_01";
    s.ishelistruct = 1;
    s.script_accel = "350";
    fe [[ f ]]( s, "MYSTERY_CARGO_FIRE_STATION", cf, ( 38962.2, -36133.4, 1860.42 ), ( 0, 57.62, 0 ), "FIRE_STATION_MYSTERYCARGO_VTOL_01", "cspf_6_auto3378833844094279436", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_mystery_cargo_cs";
    s.groupid = "reinforcement_spawn_point_01";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MYSTERY_CARGO_FIRE_STATION", cf, ( 33151, -24621.8, 5406.6 ), ( 359.47, 31.73, 0.5 ), "cspf_6_auto537692158296776830", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_mystery_cargo_cs";
    s.groupid = "reinforcement_spawn_point_01";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MYSTERY_CARGO_FIRE_STATION", cf, ( 29026.8, -48163.8, 5688.7 ), ( 0, 50.34, 0 ), undefined, "cspf_6_auto13918011251922956337", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150, 1 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_mystery_cargo_cs";
    s.groupid = "reinforcement_spawn_point_01";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MYSTERY_CARGO_FIRE_STATION", cf, ( 35714.6, -31289.2, 4318.72 ), ( 359.47, 31.73, 0.5 ), "cspf_6_auto3378833844094279436", "cspf_6_auto537692158296776830", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_mystery_cargo_cs";
    s.groupid = "reinforcement_spawn_point_01";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MYSTERY_CARGO_FIRE_STATION", cf, ( 36081.2, -39399.8, 3524.54 ), ( 0, 323.92, -0 ), "cspf_6_auto13918011251922956337", "FIRE_STATION_MYSTERYCARGO_VTOL_01", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_mystery_cargo_cs";
    s.groupid = "reinforcement_spawn_point_02";
    s.ishelistruct = 1;
    s.script_accel = "350";
    fe [[ f ]]( s, "MYSTERY_CARGO_FIRE_STATION", cf, ( 39773.3, -34595.4, 1826.42 ), ( 0, 244.01, 0 ), "FIRE_STATION_MYSTERYCARGO_VTOL_02", "cspf_6_auto2134390764817724756", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_mystery_cargo_cs";
    s.groupid = "reinforcement_spawn_point_02";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MYSTERY_CARGO_FIRE_STATION", cf, ( 31692.6, -38244.3, 6759.6 ), ( 359.47, 224.83, 0.5 ), "cspf_6_auto4862168342851838557", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_mystery_cargo_cs";
    s.groupid = "reinforcement_spawn_point_02";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MYSTERY_CARGO_FIRE_STATION", cf, ( 36973.5, -24421.8, 5224.7 ), ( 0, 290.13, 0 ), undefined, "cspf_6_auto10528125660072076913", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150, 1 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_mystery_cargo_cs";
    s.groupid = "reinforcement_spawn_point_02";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MYSTERY_CARGO_FIRE_STATION", cf, ( 35372.6, -34183.4, 3797.72 ), ( 359.47, 224.83, 0.5 ), "cspf_6_auto2134390764817724756", "cspf_6_auto4862168342851838557", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_mystery_cargo_cs";
    s.groupid = "reinforcement_spawn_point_02";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MYSTERY_CARGO_FIRE_STATION", cf, ( 39398.5, -31739.5, 3095.54 ), ( 0, 157.01, -0 ), "cspf_6_auto10528125660072076913", "FIRE_STATION_MYSTERYCARGO_VTOL_02", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_mystery_cargo_cs";
    s.name = "ability_crate";
    fe [[ f ]]( s, "MYSTERY_CARGO_FIRE_STATION", cf, ( 39697.9, -35966, 1348.23 ), ( 0, 80.56, 0 ), "ability_case_MYSTERY_CARGO_FIRE_STATION", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_sat_avalon_q4_ob_contract_mystery_cargo_cs
// Params 3
// Checksum 0x61af1040, Offset: 0x2e24
// Size: 0x663
function function_869bead39c9e5d37( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_mystery_cargo_cs";
    s.name = "cargo_container";
    fe [[ f ]]( s, "MYSTERY_CARGO_TOWER", cf, ( 11964, -24886, 3817 ), ( 0, 72.23, 0 ), "activity_nexus_variant", undefined, "MYSTERY_CARGO_TOWER", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_mystery_cargo_cs";
    s.groupid = "reinforcement_spawn_point_01";
    s.ishelistruct = 1;
    s.script_accel = "350";
    fe [[ f ]]( s, "MYSTERY_CARGO_TOWER", cf, ( 12365.1, -23845.3, 4409.42 ), ( 0, 258.72, 0 ), "TOWER_MYSTERYCARGO_VTOL_01", "cspf_7_auto3378833844094279436", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_mystery_cargo_cs";
    s.groupid = "reinforcement_spawn_point_01";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MYSTERY_CARGO_TOWER", cf, ( 14275.5, -36180.8, 7340.6 ), ( 359.47, 193.73, 0.5 ), "cspf_7_auto537692158296776830", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_mystery_cargo_cs";
    s.groupid = "reinforcement_spawn_point_01";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MYSTERY_CARGO_TOWER", cf, ( 13628.5, -11794.1, 7498.7 ), ( 0, 264.04, 0 ), undefined, "cspf_7_auto13918011251922956337", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150, 1 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_mystery_cargo_cs";
    s.groupid = "reinforcement_spawn_point_01";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MYSTERY_CARGO_TOWER", cf, ( 13522.6, -29149.7, 5976.72 ), ( 359.47, 193.73, 0.5 ), "cspf_7_auto3378833844094279436", "cspf_7_auto537692158296776830", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_mystery_cargo_cs";
    s.groupid = "reinforcement_spawn_point_01";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MYSTERY_CARGO_TOWER", cf, ( 12943.6, -17640.1, 6894.54 ), ( 0, 125.92, 0 ), "cspf_7_auto13918011251922956337", "TOWER_MYSTERYCARGO_VTOL_01", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_mystery_cargo_cs";
    s.groupid = "reinforcement_spawn_point_02";
    s.ishelistruct = 1;
    s.script_accel = "350";
    fe [[ f ]]( s, "MYSTERY_CARGO_TOWER", cf, ( 11833.4, -25911.8, 4475.42 ), ( 0, 60.92, -0 ), "TOWER_MYSTERYCARGO_VTOL_02", "cspf_7_auto14719153730539176141", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_mystery_cargo_cs";
    s.groupid = "reinforcement_spawn_point_02";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MYSTERY_CARGO_TOWER", cf, ( 20014.6, -17396.7, 7154.03 ), ( 0.49, 305.54, 0.53 ), "cspf_7_auto2815591772771143540", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_mystery_cargo_cs";
    s.groupid = "reinforcement_spawn_point_02";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MYSTERY_CARGO_TOWER", cf, ( 15630.6, -37167.8, 7309.7 ), ( 0, 105.33, -0 ), undefined, "cspf_7_auto8122959797612273977", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150, 1 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_mystery_cargo_cs";
    s.groupid = "reinforcement_spawn_point_02";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MYSTERY_CARGO_TOWER", cf, ( 13752.8, -20687.3, 5802.72 ), ( 0.49, 305.54, 0.53 ), "cspf_7_auto14719153730539176141", "cspf_7_auto2815591772771143540", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_mystery_cargo_cs";
    s.groupid = "reinforcement_spawn_point_02";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MYSTERY_CARGO_TOWER", cf, ( 14145.1, -31472.3, 6705.54 ), ( 0, 327.22, 0 ), "cspf_7_auto8122959797612273977", "TOWER_MYSTERYCARGO_VTOL_02", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_mystery_cargo_cs";
    s.name = "ability_crate";
    fe [[ f ]]( s, "MYSTERY_CARGO_TOWER", cf, ( 11965.4, -24863.7, 3831.88 ), ( 0, 344.12, 0 ), "ability_case_MYSTERY_CARGO_TOWER", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_sat_avalon_q4_ob_contract_mystery_cargo_cs
// Params 3
// Checksum 0xc111c138, Offset: 0x348f
// Size: 0x663
function function_d7267e14ae22b3f6( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_mystery_cargo_cs";
    s.name = "cargo_container";
    fe [[ f ]]( s, "MYSTERY_CARGO_NEIGHBORHOOD", cf, ( -77, -20633, 346.05 ), ( 0, 15.39, 0 ), "activity_nexus_variant", undefined, "MYSTERY_CARGO_NEIGHBORHOOD", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_mystery_cargo_cs";
    s.groupid = "reinforcement_spawn_point_01";
    s.ishelistruct = 1;
    s.script_accel = "350";
    fe [[ f ]]( s, "MYSTERY_CARGO_NEIGHBORHOOD", cf, ( -1783.11, -20859.9, 790.42 ), ( 0, 9.62, 0 ), "NEIGHBORHOOD_MYSTERYCARGO_VTOL_01", "cspf_8_auto3378833844094279436", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_mystery_cargo_cs";
    s.groupid = "reinforcement_spawn_point_01";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MYSTERY_CARGO_NEIGHBORHOOD", cf, ( 2057.36, -11211.5, 4016.6 ), ( 359.47, 343.73, 0.5 ), "cspf_8_auto537692158296776830", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_mystery_cargo_cs";
    s.groupid = "reinforcement_spawn_point_01";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MYSTERY_CARGO_NEIGHBORHOOD", cf, ( -1984.65, -34482.6, 4098.7 ), ( 0, 94.04, 0 ), undefined, "cspf_8_auto13918011251922956337", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150, 1 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_mystery_cargo_cs";
    s.groupid = "reinforcement_spawn_point_01";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MYSTERY_CARGO_NEIGHBORHOOD", cf, ( -726.05, -15974.1, 2176.72 ), ( 359.47, 343.73, 0.5 ), "cspf_8_auto3378833844094279436", "cspf_8_auto537692158296776830", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_mystery_cargo_cs";
    s.groupid = "reinforcement_spawn_point_01";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MYSTERY_CARGO_NEIGHBORHOOD", cf, ( -2378.4, -25455.7, 2378.54 ), ( 0, 275.92, 0 ), "cspf_8_auto13918011251922956337", "NEIGHBORHOOD_MYSTERYCARGO_VTOL_01", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_mystery_cargo_cs";
    s.groupid = "reinforcement_spawn_point_02";
    s.ishelistruct = 1;
    s.script_accel = "350";
    fe [[ f ]]( s, "MYSTERY_CARGO_NEIGHBORHOOD", cf, ( 646.99, -21059, 964.42 ), ( 0, 175.91, 0 ), "NEIGHBORHOOD_MYSTERYCARGO_VTOL_02", "cspf_8_auto17566771065204556309", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_mystery_cargo_cs";
    s.groupid = "reinforcement_spawn_point_02";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MYSTERY_CARGO_NEIGHBORHOOD", cf, ( -8214.59, -19119.8, 4240.6 ), ( 359.47, 141.83, 0.5 ), "cspf_8_auto9077257229661180227", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_mystery_cargo_cs";
    s.groupid = "reinforcement_spawn_point_02";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MYSTERY_CARGO_NEIGHBORHOOD", cf, ( 10780.3, -21155.6, 5876.7 ), ( 0, 170.13, 0 ), undefined, "cspf_8_auto3598859981271379343", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150, 1 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_mystery_cargo_cs";
    s.groupid = "reinforcement_spawn_point_02";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MYSTERY_CARGO_NEIGHBORHOOD", cf, ( -3530.65, -20150, 2400.72 ), ( 359.47, 141.83, 0.5 ), "cspf_8_auto17566771065204556309", "cspf_8_auto9077257229661180227", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_mystery_cargo_cs";
    s.groupid = "reinforcement_spawn_point_02";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MYSTERY_CARGO_NEIGHBORHOOD", cf, ( 4336.14, -20074.3, 3211.54 ), ( 0, 352.02, 0 ), "cspf_8_auto3598859981271379343", "NEIGHBORHOOD_MYSTERYCARGO_VTOL_02", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_mystery_cargo_cs";
    s.name = "ability_crate";
    fe [[ f ]]( s, "MYSTERY_CARGO_NEIGHBORHOOD", cf, ( -56.25, -20621.4, 360.5 ), ( 0, 286.17, 0 ), "ability_case_MYSTERY_CARGO_NEIGHBORHOOD", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_sat_avalon_q4_ob_contract_mystery_cargo_cs
// Params 0
// Checksum 0x62f4a315, Offset: 0x3afa
// Size: 0x26d
function function_d9dd7965c51c95d1()
{
    activityinstances = [];
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "ob_contract_activitydefinition_mystery_cargo";
    var_881289d7987bc770.cf = "mp_sat_avalon_q4_ob_contract_mystery_cargo_cs";
    var_881289d7987bc770.scriptstructorigin = ( 38775, -1201, 535.95 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [];
    var_881289d7987bc770.var_31ce4477e3543d24 = [];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [];
    var_881289d7987bc770.locationradius = [];
    activityinstances[ "MYSTERY_CARGO_AQUEDUCT" ] = var_881289d7987bc770;
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "ob_contract_activitydefinition_mystery_cargo";
    var_881289d7987bc770.cf = "mp_sat_avalon_q4_ob_contract_mystery_cargo_cs";
    var_881289d7987bc770.scriptstructorigin = ( 39721, -35963, 1333 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [];
    var_881289d7987bc770.var_31ce4477e3543d24 = [];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [];
    var_881289d7987bc770.locationradius = [];
    activityinstances[ "MYSTERY_CARGO_FIRE_STATION" ] = var_881289d7987bc770;
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "ob_contract_activitydefinition_mystery_cargo";
    var_881289d7987bc770.cf = "mp_sat_avalon_q4_ob_contract_mystery_cargo_cs";
    var_881289d7987bc770.scriptstructorigin = ( 11949, -24881, 3817 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [];
    var_881289d7987bc770.var_31ce4477e3543d24 = [];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [];
    var_881289d7987bc770.locationradius = [];
    activityinstances[ "MYSTERY_CARGO_TOWER" ] = var_881289d7987bc770;
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "ob_contract_activitydefinition_mystery_cargo";
    var_881289d7987bc770.cf = "mp_sat_avalon_q4_ob_contract_mystery_cargo_cs";
    var_881289d7987bc770.scriptstructorigin = ( -64, -20654, 346.34 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [];
    var_881289d7987bc770.var_31ce4477e3543d24 = [];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [];
    var_881289d7987bc770.locationradius = [];
    activityinstances[ "MYSTERY_CARGO_NEIGHBORHOOD" ] = var_881289d7987bc770;
    return activityinstances;
}

