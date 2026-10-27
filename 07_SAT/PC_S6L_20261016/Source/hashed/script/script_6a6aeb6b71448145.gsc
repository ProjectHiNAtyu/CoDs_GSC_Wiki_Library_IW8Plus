// script_6a6aeb6b71448145  (hash_6a6aeb6b71448145.gscc) (size: 5736 Bytes / 0x1668 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xd29fb539 (3533681977)
// size ...... 5736 (0x1668)
// includes .. 4   (offset: 0x13d4)
// strings ... 25  (offset: 0x13f4)
// dev strs .. 0   (offset: 0x1668)
// exports ... 13  (offset: 0xef0)
// cseg ...... 0x2ab + 0xc45 (0xef0)
// imports ... 26  (offset: 0x10f8)
// animtree1 . 0   (offset: 0x1668)
// animtree2 . 0   (offset: 0x1668)
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace mp_sat_avalon_quad_03_ob_contract_precious_cargo_cs;

// Namespace mp_sat_avalon_quad_03_ob_contract_precious_cargo_cs
// Params 0, eflags: 0x5
// Checksum 0x9337e0ea, Offset: 0x2c9
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"mp_sat_avalon_quad_03_ob_contract_precious_cargo_cs", #"activity_common", &function_b39ecd3d51489472, undefined );
}

// Namespace mp_sat_avalon_quad_03_ob_contract_precious_cargo_cs
// Params 0, eflags: 0x4
// Checksum 0x5f276056, Offset: 0x2f2
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace mp_sat_avalon_quad_03_ob_contract_precious_cargo_cs
// Params 0, eflags: 0x4
// Checksum 0xda1cb3ba, Offset: 0x303
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace mp_sat_avalon_quad_03_ob_contract_precious_cargo_cs
// Params 2
// Checksum 0x86e834d3, Offset: 0x314
// Size: 0x8c
function main( unused, unused2 )
{
    if ( utility::flag_exist( "mp_sat_avalon_quad_03_ob_contract_precious_cargo_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "mp_sat_avalon_quad_03_ob_contract_precious_cargo_cs" ) )
    {
        return;
    }
    
    activity_common::function_e1df676808c1d1e3( &function_4cd78e661617f3 );
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "mp_sat_avalon_quad_03_ob_contract_precious_cargo_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "mp_sat_avalon_quad_03_ob_contract_precious_cargo_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace mp_sat_avalon_quad_03_ob_contract_precious_cargo_cs
// Params 3, eflags: 0x4
// Checksum 0x599e0775, Offset: 0x3a8
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "mp_sat_avalon_quad_03_ob_contract_precious_cargo_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "mp_sat_avalon_quad_03_ob_contract_precious_cargo_cs" );
}

// Namespace mp_sat_avalon_quad_03_ob_contract_precious_cargo_cs
// Params 3, eflags: 0x4
// Checksum 0x3a44b830, Offset: 0x422
// Size: 0x8e4
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_contract_precious_cargo_cs";
    fe [[ f ]]( s, "PRECIOUS_CARGO_Q3_MITRAINING", cf, ( -22767.2, -12363.2, 785.44 ), ( 359.94, 300.95, -6.14 ), "activity_nexus_instance_joiner", undefined, "PRECIOUS_CARGO_Q3_MITRAINING", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_contract_precious_cargo_cs";
    s.activity_bundle = "sat_activitydefinition_precious_cargo";
    s.name = "PRECIOUS_CARGO_Q3_MITRAINING";
    s.var_265c4f33e2a6daa7 = "1";
    fe [[ f ]]( s, "PRECIOUS_CARGO_Q3_MITRAINING", cf, ( -21646.6, -27692.2, 421.21 ), ( 0, 180.24, 0 ), "activity_nexus_variant", "PRECIOUS_CARGO_Q3_MITRAINING", undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_contract_precious_cargo_cs";
    fe [[ f ]]( s, "PRECIOUS_CARGO_Q3_MITRAINING", cf, ( -21311.3, -27578.7, 396.76 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "OB_Spacer_Spatial_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 50 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_contract_precious_cargo_cs";
    fe [[ f ]]( s, us, cf, ( -25202.1, -20817.8, 977.57 ), ( 0, 37.1, 0 ), "precious_cargo_end_lv1", undefined, "PRECIOUS_CARGO_CITY_GROUND_TIER_1", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_contract_precious_cargo_cs";
    fe [[ f ]]( s, us, cf, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_contract_precious_cargo_cs";
    s.groupid = "end_point02";
    s.name = "end_point";
    fe [[ f ]]( s, us, cf, ( -42511.5, -11988, 176 ), ( 0, 57.73, 0 ), "precious_cargo_end", undefined, undefined, undefined, undefined, undefined, undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_contract_precious_cargo_cs";
    s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
    s.groupid = "heli_mitraining";
    s.script_unload = "default";
    s.spawngroup = "heli_test_guys";
    fe [[ f ]]( s, us, cf, ( -36886.3, -29994.2, 4451 ), ( 0, 55, 0 ), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_contract_precious_cargo_cs";
    s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
    s.groupid = "heli_mitraining";
    s.script_unload = "default";
    s.spawngroup = "heli_test_guys";
    fe [[ f ]]( s, us, cf, ( -38646.3, -25542.2, 4451 ), ( 0, 360, 0 ), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_contract_precious_cargo_cs";
    s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
    s.groupid = "heli_mitraining";
    s.script_unload = "default";
    s.spawngroup = "heli_test_guys";
    fe [[ f ]]( s, us, cf, ( -38238.3, -21606.2, 4451 ), ( 0, 360, 0 ), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_contract_precious_cargo_cs";
    s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
    s.groupid = "heli_mitraining";
    s.script_unload = "default";
    s.spawngroup = "heli_test_guys";
    fe [[ f ]]( s, us, cf, ( -30986.3, -17330.2, 4451 ), ( 0, 305, 0 ), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_contract_precious_cargo_cs";
    s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
    s.groupid = "heli_mitraining";
    s.script_unload = "default";
    s.spawngroup = "heli_test_guys";
    fe [[ f ]]( s, us, cf, ( -26286.3, -20270.2, 4451 ), ( 0, 305, 0 ), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_contract_precious_cargo_cs";
    s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
    s.groupid = "heli_mitraining";
    s.script_unload = "default";
    s.spawngroup = "heli_test_guys";
    fe [[ f ]]( s, us, cf, ( -20742.3, -23430.2, 4451 ), ( 0, 305, 0 ), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_contract_precious_cargo_cs";
    s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
    s.groupid = "heli_mitraining";
    s.script_unload = "default";
    s.spawngroup = "heli_test_guys";
    fe [[ f ]]( s, us, cf, ( -17878.3, -29178.2, 4451 ), ( 0, 244.99, 0 ), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_contract_precious_cargo_cs";
    s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
    s.groupid = "heli_mitraining";
    s.script_unload = "default";
    s.spawngroup = "heli_test_guys";
    fe [[ f ]]( s, us, cf, ( -24414.3, -32686.2, 4451 ), ( 0, 124.99, 0 ), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_contract_precious_cargo_cs";
    s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
    s.groupid = "heli_mitraining";
    s.script_unload = "default";
    s.spawngroup = "heli_test_guys";
    fe [[ f ]]( s, us, cf, ( -29834.3, -31950.2, 4451 ), ( 0, 124.99, 0 ), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_contract_precious_cargo_cs";
    s.groupid = "end_point03";
    s.name = "end_point";
    fe [[ f ]]( s, us, cf, ( 780.22, -45287.2, 108.99 ), ( 0, 61.91, 0 ), "precious_cargo_end", undefined, undefined, undefined, undefined, undefined, undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_contract_precious_cargo_cs";
    s.groupid = "end_point04";
    s.name = "end_point";
    fe [[ f ]]( s, us, cf, ( -1116.86, -31981.4, 288.75 ), ( 0, 190.82, 0 ), "precious_cargo_end", undefined, undefined, undefined, undefined, undefined, undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_contract_precious_cargo_cs";
    s.groupid = "end_point01";
    s.name = "end_point";
    fe [[ f ]]( s, us, cf, ( -25564.5, -20580.8, 968.82 ), ( 0, 348.06, 0 ), "precious_cargo_end", undefined, undefined, undefined, undefined, undefined, undefined, 200 );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace mp_sat_avalon_quad_03_ob_contract_precious_cargo_cs
// Params 0, eflags: 0x4
// Checksum 0x916c809e, Offset: 0xd0e
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace mp_sat_avalon_quad_03_ob_contract_precious_cargo_cs
// Params 0
// Checksum 0x9bcdda38, Offset: 0xd18
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "mp_sat_avalon_quad_03_ob_contract_precious_cargo_cs" );
}

// Namespace mp_sat_avalon_quad_03_ob_contract_precious_cargo_cs
// Params 0
// Checksum 0x1c33d9a2, Offset: 0xd2e
// Size: 0x66
function function_4cd78e661617f3()
{
    activityinfostruct = {};
    activityinfostruct.name = "REV_OB_CONTRACT_PRECIOUS_CARGO";
    activityinfostruct.scriptbundle = "sat_activitydefinition_precious_cargo";
    activityinfostruct.mainfunction = &main;
    activityinfostruct.var_934f068483ae4ddb = &function_d4323822d7042e5a;
    activityinfostruct.metadatafunction = &function_d9dd7965c51c95d1;
    return activityinfostruct;
}

// Namespace mp_sat_avalon_quad_03_ob_contract_precious_cargo_cs
// Params 4
// Checksum 0x8ce33a29, Offset: 0xd9d
// Size: 0x57
function function_d4323822d7042e5a( var_4312b79c960726b6, fe, us, cf = "mp_sat_avalon_quad_03_ob_contract_precious_cargo_cs" )
{
    switch ( var_4312b79c960726b6 )
    {
        case #"hash_41cf4e3721653d72":
            function_965087042bf1cd2a( fe, us, cf );
            break;
    }
}

// Namespace mp_sat_avalon_quad_03_ob_contract_precious_cargo_cs
// Params 3
// Checksum 0x8abd66a6, Offset: 0xdfc
// Size: 0x2f
function function_965087042bf1cd2a( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
}

// Namespace mp_sat_avalon_quad_03_ob_contract_precious_cargo_cs
// Params 0
// Checksum 0xa875210f, Offset: 0xe33
// Size: 0xbc
function function_d9dd7965c51c95d1()
{
    activityinstances = [];
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_activitydefinition_precious_cargo";
    var_881289d7987bc770.var_265c4f33e2a6daa7 = 1;
    var_881289d7987bc770.cf = "mp_sat_avalon_quad_03_ob_contract_precious_cargo_cs";
    var_881289d7987bc770.scriptstructorigin = ( -21646.6, -27692.2, 421.21 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [];
    var_881289d7987bc770.var_31ce4477e3543d24 = [];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [];
    var_881289d7987bc770.locationradius = [];
    activityinstances[ "PRECIOUS_CARGO_Q3_MITRAINING" ] = var_881289d7987bc770;
    return activityinstances;
}

