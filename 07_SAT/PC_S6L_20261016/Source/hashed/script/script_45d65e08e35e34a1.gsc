// script_45d65e08e35e34a1  (hash_45d65e08e35e34a1.gscc) (size: 11244 Bytes / 0x2bec / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xc6217c6c (3324083308)
// size ...... 11244 (0x2bec)
// includes .. 4   (offset: 0x264c)
// strings ... 49  (offset: 0x266c)
// dev strs .. 0   (offset: 0x2bec)
// exports ... 14  (offset: 0x2120)
// cseg ...... 0x58b + 0x1b95 (0x2120)
// imports ... 27  (offset: 0x2350)
// animtree1 . 0   (offset: 0x2bec)
// animtree2 . 0   (offset: 0x2bec)
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace mp_sat_avalon_q3_ob_contract_mystery_cargo_cs;

// Namespace mp_sat_avalon_q3_ob_contract_mystery_cargo_cs
// Params 0, eflags: 0x5
// Checksum 0x70e578e7, Offset: 0x5a9
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"mp_sat_avalon_q3_ob_contract_mystery_cargo_cs", #"activity_common", &function_b39ecd3d51489472, undefined );
}

// Namespace mp_sat_avalon_q3_ob_contract_mystery_cargo_cs
// Params 0, eflags: 0x4
// Checksum 0x855151ff, Offset: 0x5d2
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace mp_sat_avalon_q3_ob_contract_mystery_cargo_cs
// Params 0, eflags: 0x4
// Checksum 0x6a8213, Offset: 0x5e3
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace mp_sat_avalon_q3_ob_contract_mystery_cargo_cs
// Params 2
// Checksum 0xcbe9509f, Offset: 0x5f4
// Size: 0x8c
function main( unused, unused2 )
{
    if ( utility::flag_exist( "mp_sat_avalon_q3_ob_contract_mystery_cargo_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "mp_sat_avalon_q3_ob_contract_mystery_cargo_cs" ) )
    {
        return;
    }
    
    activity_common::function_e1df676808c1d1e3( &function_4cd78e661617f3 );
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "mp_sat_avalon_q3_ob_contract_mystery_cargo_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "mp_sat_avalon_q3_ob_contract_mystery_cargo_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace mp_sat_avalon_q3_ob_contract_mystery_cargo_cs
// Params 3, eflags: 0x4
// Checksum 0x83e836dc, Offset: 0x688
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "mp_sat_avalon_q3_ob_contract_mystery_cargo_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "mp_sat_avalon_q3_ob_contract_mystery_cargo_cs" );
}

// Namespace mp_sat_avalon_q3_ob_contract_mystery_cargo_cs
// Params 3, eflags: 0x4
// Checksum 0x566b3da4, Offset: 0x702
// Size: 0xaf4
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_contract_mystery_cargo_cs";
    fe [[ f ]]( s, "MYSTERY_CARGO_OUTPOST", cf, ( -27683.9, -16411.9, 83 ), ( 0, 174.22, 0 ), "activity_nexus_instance_joiner", "MYSTERY_CARGO_OUTPOST", undefined, undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_contract_mystery_cargo_cs";
    s._size_max = ( 1288, 1342, 682 );
    s._size_min = ( 1154, 696, 874 );
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
    fe [[ f ]]( s, "MYSTERY_CARGO_OUTPOST", cf, ( -15120.4, -14542.1, 207.49 ), ( 0, 6.5, -0 ), "MYSTERY_CARGO_OUTPOST2", undefined, "noent_volume_ai_encounter_cs", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_contract_mystery_cargo_cs";
    s.activity_bundle = "ob_contract_activitydefinition_mystery_cargo";
    s.name = "MYSTERY_CARGO_OUTPOST";
    fe [[ f ]]( s, "MYSTERY_CARGO_OUTPOST", cf, ( -13816, -14423, 142 ), ( 0, 95.1, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_contract_mystery_cargo_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "mystery_cargo_vtol1";
    s.variantname = "ai_encounter_spawnpoint";
    s.var_4501e0172e168ddf = "OUTPOST_MYSTERYCARGO_VTOL_01";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "MYSTERY_CARGO_OUTPOST", cf, ( -13413, -13964.5, 79.82 ), ( 0, 221.81, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_contract_mystery_cargo_cs";
    s._size_max = ( 1174, 796, 682 );
    s._size_min = ( 748, 376, 874 );
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
    fe [[ f ]]( s, "MYSTERY_CARGO_OUTPOST", cf, ( -13032.4, -14353.3, 188.37 ), ( 0, 96.3, 0 ), "MYSTERY_CARGO_OUTPOST1", undefined, "noent_volume_ai_encounter_cs", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_contract_mystery_cargo_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "mystery_cargo_vtol2";
    s.variantname = "ai_encounter_spawnpoint";
    s.var_4501e0172e168ddf = "OUTPOST_MYSTERYCARGO_VTOL_02";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "MYSTERY_CARGO_OUTPOST", cf, ( -14693.4, -14382.6, 151.82 ), ( 0, 15.61, -0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_contract_mystery_cargo_cs";
    fe [[ f ]]( s, "MYSTERY_CARGO_LISTENING", cf, ( -5240.47, -35316.4, 35.86 ), ( 0, 214.38, 0 ), "activity_nexus_instance_joiner", "MYSTERY_CARGO_LISTENING", undefined, undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_contract_mystery_cargo_cs";
    s._size_max = ( 1554, 1028, 964 );
    s._size_min = ( 302, 630, 580 );
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
    fe [[ f ]]( s, "MYSTERY_CARGO_LISTENING", cf, ( -25589.4, -45471.3, 410.54 ), ( 0, 285.2, 0 ), "MYSTERY_CARGO_LISTENING1", undefined, "noent_volume_ai_encounter_cs", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_contract_mystery_cargo_cs";
    s.activity_bundle = "ob_contract_activitydefinition_mystery_cargo";
    s.name = "MYSTERY_CARGO_LISTENING";
    fe [[ f ]]( s, "MYSTERY_CARGO_LISTENING", cf, ( -24464, -45712, 471 ), ( 0, 227.5, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_contract_mystery_cargo_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "mystery_cargo_vtol1";
    s.variantname = "ai_encounter_spawnpoint";
    s.var_4501e0172e168ddf = "LISTENING_MYSTERYCARGO_VTOL_01";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "MYSTERY_CARGO_LISTENING", cf, ( -24724.9, -46187.8, 594.82 ), ( 0, 344.71, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_contract_mystery_cargo_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "mystery_cargo_vtol2";
    s.variantname = "ai_encounter_spawnpoint";
    s.var_4501e0172e168ddf = "LISTENING_MYSTERYCARGO_VTOL_02";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "MYSTERY_CARGO_LISTENING", cf, ( -22894.3, -46006.7, 384.82 ), ( 0, 167.21, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_contract_mystery_cargo_cs";
    s._size_max = ( 1304, 1466, 882 );
    s._size_min = ( 786, 796, 208 );
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
    fe [[ f ]]( s, "MYSTERY_CARGO_LISTENING", cf, ( -23229, -45197.1, 483.75 ), ( 0, 195.1, 0 ), "MYSTERY_CARGO_LISTENING2", undefined, "noent_volume_ai_encounter_cs", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace mp_sat_avalon_q3_ob_contract_mystery_cargo_cs
// Params 0, eflags: 0x4
// Checksum 0xdc6de4d2, Offset: 0x11fe
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace mp_sat_avalon_q3_ob_contract_mystery_cargo_cs
// Params 0
// Checksum 0x41bbeb91, Offset: 0x1208
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "mp_sat_avalon_q3_ob_contract_mystery_cargo_cs" );
}

// Namespace mp_sat_avalon_q3_ob_contract_mystery_cargo_cs
// Params 0
// Checksum 0x62959cb1, Offset: 0x121e
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

// Namespace mp_sat_avalon_q3_ob_contract_mystery_cargo_cs
// Params 4
// Checksum 0x23e8abfe, Offset: 0x128d
// Size: 0x71
function function_d4323822d7042e5a( var_4312b79c960726b6, fe, us, cf = "mp_sat_avalon_q3_ob_contract_mystery_cargo_cs" )
{
    switch ( var_4312b79c960726b6 )
    {
        case #"hash_151081607e269f10":
            function_787a3e42c0fed558( fe, us, cf );
            break;
        case #"hash_5a4180937652738b":
            function_8a52a143b30f15e3( fe, us, cf );
            break;
    }
}

// Namespace mp_sat_avalon_q3_ob_contract_mystery_cargo_cs
// Params 3
// Checksum 0x30d3d9b, Offset: 0x1306
// Size: 0x663
function function_787a3e42c0fed558( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_contract_mystery_cargo_cs";
    s.name = "cargo_container";
    fe [[ f ]]( s, "MYSTERY_CARGO_OUTPOST", cf, ( -13818, -14427, 143 ), ( 0, 151.21, 0 ), "activity_nexus_variant", undefined, "MYSTERY_CARGO_OUTPOST", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_contract_mystery_cargo_cs";
    s.groupid = "reinforcement_spawn_point_01";
    s.ishelistruct = 1;
    s.script_accel = "350";
    fe [[ f ]]( s, "MYSTERY_CARGO_OUTPOST", cf, ( -13293.3, -13959, 699.42 ), ( 0, 227.41, 0 ), "OUTPOST_MYSTERYCARGO_VTOL_01", "cspf_3_auto3378833844094279436", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_contract_mystery_cargo_cs";
    s.groupid = "reinforcement_spawn_point_01";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MYSTERY_CARGO_OUTPOST", cf, ( -13626.3, -22318, 3144.6 ), ( 359.47, 216.53, 0.5 ), "cspf_3_auto537692158296776830", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_contract_mystery_cargo_cs";
    s.groupid = "reinforcement_spawn_point_01";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MYSTERY_CARGO_OUTPOST", cf, ( -16011.6, 2268.56, 3698.7 ), ( 0, 281.83, 0 ), undefined, "cspf_3_auto13918011251922956337", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150, 1 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_contract_mystery_cargo_cs";
    s.groupid = "reinforcement_spawn_point_01";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MYSTERY_CARGO_OUTPOST", cf, ( -13012.7, -16349.2, 1940.72 ), ( 359.47, 216.53, 0.5 ), "cspf_3_auto3378833844094279436", "cspf_3_auto537692158296776830", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_contract_mystery_cargo_cs";
    s.groupid = "reinforcement_spawn_point_01";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MYSTERY_CARGO_OUTPOST", cf, ( -14375, -7659.85, 2298.54 ), ( 0, 148.72, 0 ), "cspf_3_auto13918011251922956337", "OUTPOST_MYSTERYCARGO_VTOL_01", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_contract_mystery_cargo_cs";
    s.groupid = "reinforcement_spawn_point_02";
    s.ishelistruct = 1;
    s.script_accel = "350";
    fe [[ f ]]( s, "MYSTERY_CARGO_OUTPOST", cf, ( -14803.3, -14334.5, 771.42 ), ( 0, 21.21, -0 ), "OUTPOST_MYSTERYCARGO_VTOL_02", "cspf_3_auto7136759207801884646", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_contract_mystery_cargo_cs";
    s.groupid = "reinforcement_spawn_point_02";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MYSTERY_CARGO_OUTPOST", cf, ( -10926.2, -6943.77, 3224.6 ), ( 359.47, 10.33, 0.5 ), "cspf_3_auto8569305857600075672", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_contract_mystery_cargo_cs";
    s.groupid = "reinforcement_spawn_point_02";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MYSTERY_CARGO_OUTPOST", cf, ( -19641.2, -30057.4, 3778.7 ), ( 0, 75.63, -0 ), undefined, "cspf_3_auto18004422743955762253", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150, 1 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_contract_mystery_cargo_cs";
    s.groupid = "reinforcement_spawn_point_02";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MYSTERY_CARGO_OUTPOST", cf, ( -14112, -12028.4, 2020.72 ), ( 359.47, 10.33, 0.5 ), "cspf_3_auto7136759207801884646", "cspf_3_auto8569305857600075672", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_contract_mystery_cargo_cs";
    s.groupid = "reinforcement_spawn_point_02";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MYSTERY_CARGO_OUTPOST", cf, ( -16726.2, -20426.5, 2378.54 ), ( 0, 302.52, -0 ), "cspf_3_auto18004422743955762253", "OUTPOST_MYSTERYCARGO_VTOL_02", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_contract_mystery_cargo_cs";
    s.name = "ability_crate";
    fe [[ f ]]( s, "MYSTERY_CARGO_OUTPOST", cf, ( -13840.1, -14420.8, 157.68 ), ( 0, 60.06, 0 ), "ability_case_MYSTERY_CARGO_OUTPOST", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_sat_avalon_q3_ob_contract_mystery_cargo_cs
// Params 3
// Checksum 0xec0dbb61, Offset: 0x1971
// Size: 0x663
function function_8a52a143b30f15e3( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_contract_mystery_cargo_cs";
    s.name = "cargo_container";
    fe [[ f ]]( s, "MYSTERY_CARGO_LISTENING", cf, ( -24447, -45726, 471 ), ( 0, 283.61, 0 ), "activity_nexus_variant", undefined, "MYSTERY_CARGO_LISTENING", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_contract_mystery_cargo_cs";
    s.groupid = "reinforcement_spawn_point_01";
    s.ishelistruct = 1;
    s.script_accel = "350";
    fe [[ f ]]( s, "MYSTERY_CARGO_LISTENING", cf, ( -24794.5, -46090.2, 1214.42 ), ( 0, 350.32, 0 ), "LISTENING_MYSTERYCARGO_VTOL_01", "cspf_4_auto3378833844094279436", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_contract_mystery_cargo_cs";
    s.groupid = "reinforcement_spawn_point_01";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MYSTERY_CARGO_LISTENING", cf, ( -37083.7, -44561.6, 4017.7 ), ( 0, 339.04, 0 ), undefined, "cspf_4_auto13918011251922956337", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150, 1 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_contract_mystery_cargo_cs";
    s.groupid = "reinforcement_spawn_point_01";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MYSTERY_CARGO_LISTENING", cf, ( -22845.3, -42634, 2391.72 ), ( 359.47, 318.73, 0.5 ), "cspf_4_auto3378833844094279436", "cspf_4_auto537692158296776830", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_contract_mystery_cargo_cs";
    s.groupid = "reinforcement_spawn_point_01";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MYSTERY_CARGO_LISTENING", cf, ( -28180.2, -45996.7, 1801.54 ), ( 0, 250.92, 0 ), "cspf_4_auto13918011251922956337", "LISTENING_MYSTERYCARGO_VTOL_01", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_contract_mystery_cargo_cs";
    s.groupid = "reinforcement_spawn_point_01";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MYSTERY_CARGO_LISTENING", cf, ( -12871.6, -31348.6, 2727.6 ), ( 359.47, 318.73, 0.5 ), "cspf_4_auto537692158296776830", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_contract_mystery_cargo_cs";
    s.groupid = "reinforcement_spawn_point_02";
    s.ishelistruct = 1;
    s.script_accel = "350";
    fe [[ f ]]( s, "MYSTERY_CARGO_LISTENING", cf, ( -22820.5, -46101.1, 1004.42 ), ( 0, 172.81, 0 ), "LISTENING_MYSTERYCARGO_VTOL_02", "cspf_4_auto16613814389322742947", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_contract_mystery_cargo_cs";
    s.groupid = "reinforcement_spawn_point_02";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MYSTERY_CARGO_LISTENING", cf, ( -11315.7, -42736.5, 4215.7 ), ( 0, 181.03, 0 ), undefined, "cspf_4_auto13515958815453053286", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150, 1 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_contract_mystery_cargo_cs";
    s.groupid = "reinforcement_spawn_point_02";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MYSTERY_CARGO_LISTENING", cf, ( -28453.4, -43835.5, 2589.72 ), ( 359.47, 160.73, 0.5 ), "cspf_4_auto16613814389322742947", "cspf_4_auto13294910479130937496", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_contract_mystery_cargo_cs";
    s.groupid = "reinforcement_spawn_point_02";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MYSTERY_CARGO_LISTENING", cf, ( -20108.4, -44741.2, 1999.54 ), ( 0, 92.91, -0 ), "cspf_4_auto13515958815453053286", "LISTENING_MYSTERYCARGO_VTOL_02", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_contract_mystery_cargo_cs";
    s.groupid = "reinforcement_spawn_point_02";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MYSTERY_CARGO_LISTENING", cf, ( -37500.7, -40551.8, 7962.6 ), ( 359.47, 160.73, 0.5 ), "cspf_4_auto13294910479130937496", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_contract_mystery_cargo_cs";
    s.name = "ability_crate";
    fe [[ f ]]( s, "MYSTERY_CARGO_LISTENING", cf, ( -24436.2, -45746.7, 485.8 ), ( 0, 194.81, 0 ), "ability_case_MYSTERY_CARGO_LISTENING", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_sat_avalon_q3_ob_contract_mystery_cargo_cs
// Params 0
// Checksum 0x8377b562, Offset: 0x1fdc
// Size: 0x143
function function_d9dd7965c51c95d1()
{
    activityinstances = [];
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "ob_contract_activitydefinition_mystery_cargo";
    var_881289d7987bc770.cf = "mp_sat_avalon_q3_ob_contract_mystery_cargo_cs";
    var_881289d7987bc770.scriptstructorigin = ( -13816, -14423, 142 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [];
    var_881289d7987bc770.var_31ce4477e3543d24 = [];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [];
    var_881289d7987bc770.locationradius = [];
    activityinstances[ "MYSTERY_CARGO_OUTPOST" ] = var_881289d7987bc770;
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "ob_contract_activitydefinition_mystery_cargo";
    var_881289d7987bc770.cf = "mp_sat_avalon_q3_ob_contract_mystery_cargo_cs";
    var_881289d7987bc770.scriptstructorigin = ( -24464, -45712, 471 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [];
    var_881289d7987bc770.var_31ce4477e3543d24 = [];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [];
    var_881289d7987bc770.locationradius = [];
    activityinstances[ "MYSTERY_CARGO_LISTENING" ] = var_881289d7987bc770;
    return activityinstances;
}

