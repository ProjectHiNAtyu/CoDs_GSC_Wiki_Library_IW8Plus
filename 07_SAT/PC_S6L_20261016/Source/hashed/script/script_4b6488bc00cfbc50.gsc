// script_4b6488bc00cfbc50  (hash_4b6488bc00cfbc50.gscc) (size: 7252 Bytes / 0x1c54 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x2bf51181 (737481089)
// size ...... 7252 (0x1c54)
// includes .. 4   (offset: 0x19e0)
// strings ... 23  (offset: 0x1a00)
// dev strs .. 0   (offset: 0x1c54)
// exports ... 19  (offset: 0x134c)
// cseg ...... 0x35e + 0xfee (0x134c)
// imports ... 32  (offset: 0x1644)
// animtree1 . 0   (offset: 0x1c54)
// animtree2 . 0   (offset: 0x1c54)
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace mp_sat_avalon_q1_ob_activity_surprise_shipment_cs;

// Namespace mp_sat_avalon_q1_ob_activity_surprise_shipment_cs
// Params 0, eflags: 0x5
// Checksum 0xdf482fa, Offset: 0x37c
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"mp_sat_avalon_q1_ob_activity_surprise_shipment_cs", #"activity_common", &function_b39ecd3d51489472, undefined );
}

// Namespace mp_sat_avalon_q1_ob_activity_surprise_shipment_cs
// Params 0, eflags: 0x4
// Checksum 0xe5cd6599, Offset: 0x3a5
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace mp_sat_avalon_q1_ob_activity_surprise_shipment_cs
// Params 0, eflags: 0x4
// Checksum 0x60f6b675, Offset: 0x3b6
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace mp_sat_avalon_q1_ob_activity_surprise_shipment_cs
// Params 2
// Checksum 0xb1128230, Offset: 0x3c7
// Size: 0x8c
function main( unused, unused2 )
{
    if ( utility::flag_exist( "mp_sat_avalon_q1_ob_activity_surprise_shipment_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "mp_sat_avalon_q1_ob_activity_surprise_shipment_cs" ) )
    {
        return;
    }
    
    activity_common::function_e1df676808c1d1e3( &function_4cd78e661617f3 );
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "mp_sat_avalon_q1_ob_activity_surprise_shipment_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "mp_sat_avalon_q1_ob_activity_surprise_shipment_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace mp_sat_avalon_q1_ob_activity_surprise_shipment_cs
// Params 3, eflags: 0x4
// Checksum 0xe37402ba, Offset: 0x45b
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "mp_sat_avalon_q1_ob_activity_surprise_shipment_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "mp_sat_avalon_q1_ob_activity_surprise_shipment_cs" );
}

// Namespace mp_sat_avalon_q1_ob_activity_surprise_shipment_cs
// Params 3, eflags: 0x4
// Checksum 0x25172838, Offset: 0x4d5
// Size: 0x3ef
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_surprise_shipment_cs";
    s.activity_bundle = "sat_ob_activitydefinition_surprise_shipment_whitebox";
    s.name = "SURPRISE_SHIPMENT_ROUNDABOUT";
    fe [[ f ]]( s, "SURPRISE_SHIPMENT_ROUNDABOUT", cf, ( -4137.4, 46586, 311 ), ( 0, 350.9, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_surprise_shipment_cs";
    s.activity_bundle = "sat_ob_activitydefinition_surprise_shipment_whitebox";
    s.name = "SURPRISE_SHIPMENT_MANSIONS";
    fe [[ f ]]( s, "SURPRISE_SHIPMENT_MANSIONS", cf, ( -54943.4, 3190.26, 358.43 ), ( 0, 350.9, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_surprise_shipment_cs";
    s.activity_bundle = "sat_ob_activitydefinition_surprise_shipment_whitebox";
    s.name = "SURPRISE_SHIPMENT_OVERLOOK";
    fe [[ f ]]( s, "SURPRISE_SHIPMENT_OVERLOOK", cf, ( -38752.5, 21781.1, 1163.64 ), ( 0, 80.9, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_surprise_shipment_cs";
    s.activity_bundle = "sat_ob_activitydefinition_surprise_shipment_whitebox";
    s.name = "SURPRISE_SHIPMENT_CITY";
    fe [[ f ]]( s, "SURPRISE_SHIPMENT_CITY", cf, ( -24046.5, 9004.88, 1214.31 ), ( 0, 80.9, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_surprise_shipment_cs";
    s.activity_bundle = "sat_ob_activitydefinition_surprise_shipment_whitebox";
    s.name = "SURPRISE_SHIPMENT_CASINO";
    fe [[ f ]]( s, "SURPRISE_SHIPMENT_CASINO", cf, ( -17452, 23312.2, 1668.85 ), ( 0, 350.9, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_surprise_shipment_cs";
    s.activity_bundle = "sat_ob_activitydefinition_surprise_shipment_whitebox";
    s.name = "SURPRISE_SHIPMENT_PARK";
    fe [[ f ]]( s, "SURPRISE_SHIPMENT_PARK", cf, ( -19077, 30651.5, 2285.81 ), ( 0, 350.9, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_surprise_shipment_cs";
    s.activity_bundle = "sat_ob_activitydefinition_surprise_shipment_whitebox";
    s.name = "SURPRISE_SHIPMENT_SUBDIVISION";
    fe [[ f ]]( s, "SURPRISE_SHIPMENT_SUBDIVISION", cf, ( -7410.33, 37409.7, 662.45 ), ( 0, 350.9, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace mp_sat_avalon_q1_ob_activity_surprise_shipment_cs
// Params 0, eflags: 0x4
// Checksum 0xa696367d, Offset: 0x8cc
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace mp_sat_avalon_q1_ob_activity_surprise_shipment_cs
// Params 0
// Checksum 0x2127dff7, Offset: 0x8d6
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "mp_sat_avalon_q1_ob_activity_surprise_shipment_cs" );
}

// Namespace mp_sat_avalon_q1_ob_activity_surprise_shipment_cs
// Params 0
// Checksum 0xac5ff0cd, Offset: 0x8ec
// Size: 0x66
function function_4cd78e661617f3()
{
    activityinfostruct = {};
    activityinfostruct.name = "REV_OB_SURPRISE_SHIPMENT";
    activityinfostruct.scriptbundle = "sat_ob_activitydefinition_surprise_shipment";
    activityinfostruct.mainfunction = &main;
    activityinfostruct.var_934f068483ae4ddb = &function_d4323822d7042e5a;
    activityinfostruct.metadatafunction = &function_d9dd7965c51c95d1;
    return activityinfostruct;
}

// Namespace mp_sat_avalon_q1_ob_activity_surprise_shipment_cs
// Params 4
// Checksum 0xceda9abf, Offset: 0x95b
// Size: 0xf3
function function_d4323822d7042e5a( var_4312b79c960726b6, fe, us, cf = "mp_sat_avalon_q1_ob_activity_surprise_shipment_cs" )
{
    switch ( var_4312b79c960726b6 )
    {
        case #"hash_6ccad32a193e4fe7":
            function_87b6d057000463f( fe, us, cf );
            break;
        case #"hash_685868a97cde43d4":
            function_cb0143d2d082e74c( fe, us, cf );
            break;
        case #"hash_60e7ca6bb9777887":
            function_38df5c7156f9a31f( fe, us, cf );
            break;
        case #"hash_5c8546a40e9be2d1":
            function_c56b12df9ed1f8b9( fe, us, cf );
            break;
        case #"hash_1d5dfd896dde4045":
            function_42ff365e7771299d( fe, us, cf );
            break;
        case #"hash_4e67044a0be87d3e":
            function_37601f8078228c36( fe, us, cf );
            break;
        case #"hash_fa1cce5b3daefb7f":
            function_4ee992fed14bd787( fe, us, cf );
            break;
    }
}

// Namespace mp_sat_avalon_q1_ob_activity_surprise_shipment_cs
// Params 3
// Checksum 0xd1fb75cf, Offset: 0xa56
// Size: 0xa7
function function_87b6d057000463f( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_surprise_shipment_cs";
    s.name = "ability_crate";
    fe [[ f ]]( s, "SURPRISE_SHIPMENT_ROUNDABOUT", cf, ( -3958.69, 45892.9, 301.5 ), ( 0, 174.37, 0 ), "ability_case_SURPRISE_SHIPMENT_ROUNDABOUT", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_sat_avalon_q1_ob_activity_surprise_shipment_cs
// Params 3
// Checksum 0x452f6ce7, Offset: 0xb05
// Size: 0xa7
function function_cb0143d2d082e74c( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_surprise_shipment_cs";
    s.name = "ability_crate";
    fe [[ f ]]( s, "SURPRISE_SHIPMENT_MANSIONS", cf, ( -54915.8, 3146.17, 368.21 ), ( 0, 253.65, 0 ), "ability_case_SURPRISE_SHIPMENT_MANSIONS", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_sat_avalon_q1_ob_activity_surprise_shipment_cs
// Params 3
// Checksum 0xcbda4535, Offset: 0xbb4
// Size: 0xa7
function function_38df5c7156f9a31f( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_surprise_shipment_cs";
    s.name = "ability_crate";
    fe [[ f ]]( s, "SURPRISE_SHIPMENT_OVERLOOK", cf, ( -39285.5, 21873.9, 1106.5 ), ( 0, 201.34, 0 ), "ability_case_SURPRISE_SHIPMENT_OVERLOOK", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_sat_avalon_q1_ob_activity_surprise_shipment_cs
// Params 3
// Checksum 0x731bda9a, Offset: 0xc63
// Size: 0xa7
function function_c56b12df9ed1f8b9( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_surprise_shipment_cs";
    s.name = "ability_crate";
    fe [[ f ]]( s, "SURPRISE_SHIPMENT_CITY", cf, ( -23906.5, 9154.63, 1240.65 ), ( 3.09, 200.66, -2.23 ), "ability_case_SURPRISE_SHIPMENT_CITY", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_sat_avalon_q1_ob_activity_surprise_shipment_cs
// Params 3
// Checksum 0xa897bd90, Offset: 0xd12
// Size: 0xa7
function function_42ff365e7771299d( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_surprise_shipment_cs";
    s.name = "ability_crate";
    fe [[ f ]]( s, "SURPRISE_SHIPMENT_CASINO", cf, ( -17050.1, 23494, 1635.42 ), ( 0, 217.9, 0 ), "ability_case_SURPRISE_SHIPMENT_CASINO", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_sat_avalon_q1_ob_activity_surprise_shipment_cs
// Params 3
// Checksum 0x9a91142d, Offset: 0xdc1
// Size: 0xa7
function function_37601f8078228c36( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_surprise_shipment_cs";
    s.name = "ability_crate";
    fe [[ f ]]( s, "SURPRISE_SHIPMENT_PARK", cf, ( -18958.8, 30852.5, 2278.88 ), ( 0.16, 234.55, -1.7 ), "ability_case_SURPRISE_SHIPMENT_PARK", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_sat_avalon_q1_ob_activity_surprise_shipment_cs
// Params 3
// Checksum 0x5b052c39, Offset: 0xe70
// Size: 0xa7
function function_4ee992fed14bd787( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_surprise_shipment_cs";
    s.name = "ability_crate";
    fe [[ f ]]( s, "SURPRISE_SHIPMENT_SUBDIVISION", cf, ( -7706.67, 37965.2, 760.51 ), ( 4.01, 53.17, -0.1 ), "ability_case_SURPRISE_SHIPMENT_SUBDIVISION", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_sat_avalon_q1_ob_activity_surprise_shipment_cs
// Params 0
// Checksum 0xdfdcc9b3, Offset: 0xf1f
// Size: 0x42c
function function_d9dd7965c51c95d1()
{
    activityinstances = [];
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_ob_activitydefinition_surprise_shipment_whitebox";
    var_881289d7987bc770.cf = "mp_sat_avalon_q1_ob_activity_surprise_shipment_cs";
    var_881289d7987bc770.scriptstructorigin = ( -4137.4, 46586, 311 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [];
    var_881289d7987bc770.var_31ce4477e3543d24 = [];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [];
    var_881289d7987bc770.locationradius = [];
    activityinstances[ "SURPRISE_SHIPMENT_ROUNDABOUT" ] = var_881289d7987bc770;
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_ob_activitydefinition_surprise_shipment_whitebox";
    var_881289d7987bc770.cf = "mp_sat_avalon_q1_ob_activity_surprise_shipment_cs";
    var_881289d7987bc770.scriptstructorigin = ( -54943.4, 3190.26, 358.43 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [];
    var_881289d7987bc770.var_31ce4477e3543d24 = [];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [];
    var_881289d7987bc770.locationradius = [];
    activityinstances[ "SURPRISE_SHIPMENT_MANSIONS" ] = var_881289d7987bc770;
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_ob_activitydefinition_surprise_shipment_whitebox";
    var_881289d7987bc770.cf = "mp_sat_avalon_q1_ob_activity_surprise_shipment_cs";
    var_881289d7987bc770.scriptstructorigin = ( -38752.5, 21781.1, 1163.64 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [];
    var_881289d7987bc770.var_31ce4477e3543d24 = [];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [];
    var_881289d7987bc770.locationradius = [];
    activityinstances[ "SURPRISE_SHIPMENT_OVERLOOK" ] = var_881289d7987bc770;
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_ob_activitydefinition_surprise_shipment_whitebox";
    var_881289d7987bc770.cf = "mp_sat_avalon_q1_ob_activity_surprise_shipment_cs";
    var_881289d7987bc770.scriptstructorigin = ( -24046.5, 9004.88, 1214.31 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [];
    var_881289d7987bc770.var_31ce4477e3543d24 = [];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [];
    var_881289d7987bc770.locationradius = [];
    activityinstances[ "SURPRISE_SHIPMENT_CITY" ] = var_881289d7987bc770;
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_ob_activitydefinition_surprise_shipment_whitebox";
    var_881289d7987bc770.cf = "mp_sat_avalon_q1_ob_activity_surprise_shipment_cs";
    var_881289d7987bc770.scriptstructorigin = ( -17452, 23312.2, 1668.85 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [];
    var_881289d7987bc770.var_31ce4477e3543d24 = [];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [];
    var_881289d7987bc770.locationradius = [];
    activityinstances[ "SURPRISE_SHIPMENT_CASINO" ] = var_881289d7987bc770;
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_ob_activitydefinition_surprise_shipment_whitebox";
    var_881289d7987bc770.cf = "mp_sat_avalon_q1_ob_activity_surprise_shipment_cs";
    var_881289d7987bc770.scriptstructorigin = ( -19077, 30651.5, 2285.81 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [];
    var_881289d7987bc770.var_31ce4477e3543d24 = [];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [];
    var_881289d7987bc770.locationradius = [];
    activityinstances[ "SURPRISE_SHIPMENT_PARK" ] = var_881289d7987bc770;
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_ob_activitydefinition_surprise_shipment_whitebox";
    var_881289d7987bc770.cf = "mp_sat_avalon_q1_ob_activity_surprise_shipment_cs";
    var_881289d7987bc770.scriptstructorigin = ( -7410.33, 37409.7, 662.45 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [];
    var_881289d7987bc770.var_31ce4477e3543d24 = [];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [];
    var_881289d7987bc770.locationradius = [];
    activityinstances[ "SURPRISE_SHIPMENT_SUBDIVISION" ] = var_881289d7987bc770;
    return activityinstances;
}

