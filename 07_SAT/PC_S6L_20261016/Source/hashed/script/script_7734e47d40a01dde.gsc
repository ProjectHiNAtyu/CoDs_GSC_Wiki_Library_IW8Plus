// script_7734e47d40a01dde  (hash_7734e47d40a01dde.gscc) (size: 8335 Bytes / 0x208f / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x754c8c1a (1967950874)
// size ...... 8335 (0x208f)
// includes .. 4   (offset: 0x1c7f)
// strings ... 27  (offset: 0x1c9f)
// dev strs .. 0   (offset: 0x208f)
// exports ... 14  (offset: 0x1753)
// cseg ...... 0x2ac + 0x14a7 (0x1753)
// imports ... 27  (offset: 0x1983)
// animtree1 . 0   (offset: 0x208f)
// animtree2 . 0   (offset: 0x208f)
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace mp_sat_avalon_q1_ob_contract_precious_cargo_cs;

// Namespace mp_sat_avalon_q1_ob_contract_precious_cargo_cs
// Params 0, eflags: 0x5
// Checksum 0x5ecf7da0, Offset: 0x2ca
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"mp_sat_avalon_q1_ob_contract_precious_cargo_cs", #"activity_common", &function_b39ecd3d51489472, undefined );
}

// Namespace mp_sat_avalon_q1_ob_contract_precious_cargo_cs
// Params 0, eflags: 0x4
// Checksum 0x591df567, Offset: 0x2f3
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace mp_sat_avalon_q1_ob_contract_precious_cargo_cs
// Params 0, eflags: 0x4
// Checksum 0xdc26268b, Offset: 0x304
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace mp_sat_avalon_q1_ob_contract_precious_cargo_cs
// Params 2
// Checksum 0x8773f332, Offset: 0x315
// Size: 0x8c
function main( unused, unused2 )
{
    if ( utility::flag_exist( "mp_sat_avalon_q1_ob_contract_precious_cargo_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "mp_sat_avalon_q1_ob_contract_precious_cargo_cs" ) )
    {
        return;
    }
    
    activity_common::function_e1df676808c1d1e3( &function_4cd78e661617f3 );
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "mp_sat_avalon_q1_ob_contract_precious_cargo_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "mp_sat_avalon_q1_ob_contract_precious_cargo_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace mp_sat_avalon_q1_ob_contract_precious_cargo_cs
// Params 3, eflags: 0x4
// Checksum 0x5fa49244, Offset: 0x3a9
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "mp_sat_avalon_q1_ob_contract_precious_cargo_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "mp_sat_avalon_q1_ob_contract_precious_cargo_cs" );
}

// Namespace mp_sat_avalon_q1_ob_contract_precious_cargo_cs
// Params 3, eflags: 0x4
// Checksum 0xdccdea2a, Offset: 0x423
// Size: 0x1052
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_precious_cargo_cs";
    s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
    s.groupid = "heli_stadium";
    s.script_unload = "default";
    s.spawngroup = "heli_test_guys";
    fe [[ f ]]( s, us, cf, ( -45287.4, 20055.8, 7177.15 ), ( 0, 320, 0 ), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_precious_cargo_cs";
    s.groupid = "end_point01";
    s.name = "end_point";
    fe [[ f ]]( s, us, cf, ( -13611.6, 48191.6, 561.9 ), ( 0, 47.79, 0 ), "precious_cargo_end", undefined, undefined, undefined, undefined, undefined, undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_precious_cargo_cs";
    s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
    s.groupid = "heli_stadium";
    s.script_unload = "default";
    s.spawngroup = "heli_test_guys";
    fe [[ f ]]( s, us, cf, ( -52789.2, 5970.33, 3612.12 ), ( 0, 35, 0 ), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_precious_cargo_cs";
    s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
    s.groupid = "heli_stadium";
    s.script_unload = "default";
    s.spawngroup = "heli_test_guys";
    fe [[ f ]]( s, us, cf, ( -46290, 5782.62, 4451.09 ), ( 0, 80, 0 ), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_precious_cargo_cs";
    s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
    s.groupid = "heli_stadium";
    s.script_unload = "default";
    s.spawngroup = "heli_test_guys";
    fe [[ f ]]( s, us, cf, ( -34081.7, 5798, 3793.5 ), ( 0, 125, 0 ), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_precious_cargo_cs";
    s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
    s.groupid = "heli_stadium";
    s.script_unload = "default";
    s.spawngroup = "heli_test_guys";
    fe [[ f ]]( s, us, cf, ( -26442.8, 20939.3, 5118.91 ), ( 0, 170, 0 ), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_precious_cargo_cs";
    s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
    s.groupid = "heli_stadium";
    s.script_unload = "default";
    s.spawngroup = "heli_test_guys";
    fe [[ f ]]( s, us, cf, ( -35378.2, 20090.4, 7177.15 ), ( 0, 320, 0 ), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_precious_cargo_cs";
    s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
    s.groupid = "heli_stadium";
    s.script_unload = "default";
    s.spawngroup = "heli_test_guys";
    fe [[ f ]]( s, us, cf, ( -51710.9, 13447.6, 3176.1 ), ( 0, 350, 0 ), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_precious_cargo_cs";
    s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
    s.groupid = "heli_stadium";
    s.script_unload = "default";
    s.spawngroup = "heli_test_guys";
    fe [[ f ]]( s, us, cf, ( -29962.5, 11508.4, 6149.61 ), ( 0, 320, 0 ), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_precious_cargo_cs";
    s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
    s.groupid = "heli_stadium";
    s.script_unload = "default";
    s.spawngroup = "heli_test_guys";
    fe [[ f ]]( s, us, cf, ( -23741.3, 6706.63, 6149.61 ), ( 0, 320, 0 ), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_precious_cargo_cs";
    s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
    s.groupid = "heli_stadium";
    s.script_unload = "default";
    s.spawngroup = "heli_test_guys";
    fe [[ f ]]( s, us, cf, ( -14746.2, 10908.2, 5954.01 ), ( 0, 320, 0 ), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_precious_cargo_cs";
    s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
    s.groupid = "heli_stadium";
    s.script_unload = "default";
    s.spawngroup = "heli_test_guys";
    fe [[ f ]]( s, us, cf, ( -13875.4, 15623.3, 6149.61 ), ( 0, 320, 0 ), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_precious_cargo_cs";
    s.groupid = "end_point02";
    s.name = "end_point";
    fe [[ f ]]( s, us, cf, ( -41051.3, 28345, 1584.86 ), ( 0, 116.37, 0 ), "precious_cargo_end", undefined, undefined, undefined, undefined, undefined, undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_precious_cargo_cs";
    fe [[ f ]]( s, "PRECIOUS_CARGO_Q1_STADIUM", cf, ( -41265.5, 25088, 1447.12 ), ( 11.54, 273.51, -13.01 ), "activity_nexus_instance_joiner", undefined, "PRECIOUS_CARGO_Q1_STADIUM", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_precious_cargo_cs";
    s.activity_bundle = "sat_activitydefinition_precious_cargo";
    s.name = "PRECIOUS_CARGO_Q1_STADIUM";
    s.var_265c4f33e2a6daa7 = "1";
    fe [[ f ]]( s, "PRECIOUS_CARGO_Q1_STADIUM", cf, ( -34127, 12959.6, 440 ), ( 0, 270.15, 0 ), "activity_nexus_variant", "PRECIOUS_CARGO_Q1_STADIUM", undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_precious_cargo_cs";
    fe [[ f ]]( s, "PRECIOUS_CARGO_Q1_STADIUM", cf, ( -34128.7, 13078.4, 440 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "OB_Spacer_Spatial_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 50 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_precious_cargo_cs";
    s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
    s.groupid = "heli_suburbs";
    s.script_unload = "default";
    s.spawngroup = "heli_test_guys";
    fe [[ f ]]( s, us, cf, ( -11945.2, 36908.7, 4451 ), ( 0, 190, 0 ), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_precious_cargo_cs";
    fe [[ f ]]( s, "PRECIOUS_CARGO_Q1_SUBURBS", cf, ( -19554.5, 33654.3, 2169.88 ), ( 357.6, 160.36, 0 ), "activity_nexus_instance_joiner", undefined, "PRECIOUS_CARGO_Q1_SUBURBS", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_precious_cargo_cs";
    s.activity_bundle = "sat_activitydefinition_precious_cargo";
    s.name = "PRECIOUS_CARGO_Q1_SUBURBS";
    s.var_265c4f33e2a6daa7 = "1";
    fe [[ f ]]( s, "PRECIOUS_CARGO_Q1_SUBURBS", cf, ( -12924.2, 37612.3, 803.77 ), ( 0, 225.24, 0 ), "activity_nexus_variant", "PRECIOUS_CARGO_Q1_SUBURBS", undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_precious_cargo_cs";
    fe [[ f ]]( s, "PRECIOUS_CARGO_Q1_SUBURBS", cf, ( -36991.2, 25023.7, 1799.85 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "OB_Spacer_Spatial_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 50 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_precious_cargo_cs";
    s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
    s.groupid = "heli_suburbs";
    s.script_unload = "default";
    s.spawngroup = "heli_test_guys";
    fe [[ f ]]( s, us, cf, ( -14961.2, 35348.7, 4451 ), ( 0, 190, 0 ), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_precious_cargo_cs";
    s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
    s.groupid = "heli_suburbs";
    s.script_unload = "default";
    s.spawngroup = "heli_test_guys";
    fe [[ f ]]( s, us, cf, ( -23065.2, 36060.7, 4451 ), ( 0, 55, 0 ), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_precious_cargo_cs";
    s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
    s.groupid = "heli_suburbs";
    s.script_unload = "default";
    s.spawngroup = "heli_test_guys";
    fe [[ f ]]( s, us, cf, ( -23525.2, 39968.7, 4451 ), ( 0, 55, 0 ), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_precious_cargo_cs";
    s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
    s.groupid = "heli_suburbs";
    s.script_unload = "default";
    s.spawngroup = "heli_test_guys";
    fe [[ f ]]( s, us, cf, ( -25585.2, 44552.7, 4451 ), ( 0, 55, 0 ), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_precious_cargo_cs";
    s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
    s.groupid = "heli_suburbs";
    s.script_unload = "default";
    s.spawngroup = "heli_test_guys";
    fe [[ f ]]( s, us, cf, ( -22873.2, 48892.7, 4451 ), ( 0, 315, 0 ), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_precious_cargo_cs";
    s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
    s.groupid = "heli_suburbs";
    s.script_unload = "default";
    s.spawngroup = "heli_test_guys";
    fe [[ f ]]( s, us, cf, ( -18233.2, 51304.7, 4451 ), ( 0, 315, 0 ), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_precious_cargo_cs";
    s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
    s.groupid = "heli_suburbs";
    s.script_unload = "default";
    s.spawngroup = "heli_test_guys";
    fe [[ f ]]( s, us, cf, ( -11805.2, 50544.7, 4451 ), ( 0, 270, 0 ), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_precious_cargo_cs";
    s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
    s.groupid = "heli_suburbs";
    s.script_unload = "default";
    s.spawngroup = "heli_test_guys";
    fe [[ f ]]( s, us, cf, ( -9185.2, 46132.7, 4451 ), ( 0, 270, 0 ), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_precious_cargo_cs";
    s.groupid = "end_point03";
    s.name = "end_point";
    fe [[ f ]]( s, us, cf, ( -41853.4, 27260.1, 1583.86 ), ( 0, 21.4, 0 ), "precious_cargo_end", undefined, undefined, undefined, undefined, undefined, undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_precious_cargo_cs";
    s.groupid = "end_point04";
    s.name = "end_point";
    fe [[ f ]]( s, us, cf, ( -52725.4, 5922.13, 352 ), ( 0, 356.94, 0 ), "precious_cargo_end", undefined, undefined, undefined, undefined, undefined, undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_precious_cargo_cs";
    s.groupid = "end_point05";
    s.name = "end_point";
    fe [[ f ]]( s, us, cf, ( -54246.4, -312.62, 240 ), ( 0, 336.41, 0 ), "precious_cargo_end", undefined, undefined, undefined, undefined, undefined, undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_precious_cargo_cs";
    s.groupid = "end_point06";
    s.name = "end_point";
    fe [[ f ]]( s, us, cf, ( -30658.8, 15991.8, 1065.32 ), ( 0, 79.49, 0 ), "precious_cargo_end", undefined, undefined, undefined, undefined, undefined, undefined, 200 );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace mp_sat_avalon_q1_ob_contract_precious_cargo_cs
// Params 0, eflags: 0x4
// Checksum 0x90f7477f, Offset: 0x147d
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace mp_sat_avalon_q1_ob_contract_precious_cargo_cs
// Params 0
// Checksum 0x9df74f09, Offset: 0x1487
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "mp_sat_avalon_q1_ob_contract_precious_cargo_cs" );
}

// Namespace mp_sat_avalon_q1_ob_contract_precious_cargo_cs
// Params 0
// Checksum 0x1a094c93, Offset: 0x149d
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

// Namespace mp_sat_avalon_q1_ob_contract_precious_cargo_cs
// Params 4
// Checksum 0x55f17098, Offset: 0x150c
// Size: 0x71
function function_d4323822d7042e5a( var_4312b79c960726b6, fe, us, cf = "mp_sat_avalon_q1_ob_contract_precious_cargo_cs" )
{
    switch ( var_4312b79c960726b6 )
    {
        case #"hash_3faffa23c6c29a7":
            function_9dce21b7bbce930f( fe, us, cf );
            break;
        case #"hash_91890bdd64b6df26":
            function_d2fcae1d65762c0e( fe, us, cf );
            break;
    }
}

// Namespace mp_sat_avalon_q1_ob_contract_precious_cargo_cs
// Params 3
// Checksum 0x78c4492a, Offset: 0x1585
// Size: 0x2f
function function_9dce21b7bbce930f( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
}

// Namespace mp_sat_avalon_q1_ob_contract_precious_cargo_cs
// Params 3
// Checksum 0xf36225c1, Offset: 0x15bc
// Size: 0x2f
function function_d2fcae1d65762c0e( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
}

// Namespace mp_sat_avalon_q1_ob_contract_precious_cargo_cs
// Params 0
// Checksum 0x24b52108, Offset: 0x15f3
// Size: 0x15f
function function_d9dd7965c51c95d1()
{
    activityinstances = [];
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_activitydefinition_precious_cargo";
    var_881289d7987bc770.var_265c4f33e2a6daa7 = 1;
    var_881289d7987bc770.cf = "mp_sat_avalon_q1_ob_contract_precious_cargo_cs";
    var_881289d7987bc770.scriptstructorigin = ( -34127, 12959.6, 440 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [];
    var_881289d7987bc770.var_31ce4477e3543d24 = [];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [];
    var_881289d7987bc770.locationradius = [];
    activityinstances[ "PRECIOUS_CARGO_Q1_STADIUM" ] = var_881289d7987bc770;
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_activitydefinition_precious_cargo";
    var_881289d7987bc770.var_265c4f33e2a6daa7 = 1;
    var_881289d7987bc770.cf = "mp_sat_avalon_q1_ob_contract_precious_cargo_cs";
    var_881289d7987bc770.scriptstructorigin = ( -12924.2, 37612.3, 803.77 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [];
    var_881289d7987bc770.var_31ce4477e3543d24 = [];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [];
    var_881289d7987bc770.locationradius = [];
    activityinstances[ "PRECIOUS_CARGO_Q1_SUBURBS" ] = var_881289d7987bc770;
    return activityinstances;
}

