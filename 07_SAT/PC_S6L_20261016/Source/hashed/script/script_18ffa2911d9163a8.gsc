// script_18ffa2911d9163a8  (hash_18ffa2911d9163a8.gscc) (size: 8014 Bytes / 0x1f4e / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xcbf4f8b1 (3421829297)
// size ...... 8014 (0x1f4e)
// includes .. 4   (offset: 0x1c96)
// strings ... 25  (offset: 0x1cb6)
// dev strs .. 0   (offset: 0x1f4e)
// exports ... 20  (offset: 0x15ba)
// cseg ...... 0x3e9 + 0x11d1 (0x15ba)
// imports ... 33  (offset: 0x18da)
// animtree1 . 0   (offset: 0x1f4e)
// animtree2 . 0   (offset: 0x1f4e)
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace mp_sat_avalon_q2_ob_activity_surprise_shipment_cs;

// Namespace mp_sat_avalon_q2_ob_activity_surprise_shipment_cs
// Params 0, eflags: 0x5
// Checksum 0xf85ae128, Offset: 0x407
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"mp_sat_avalon_q2_ob_activity_surprise_shipment_cs", #"activity_common", &function_b39ecd3d51489472, undefined );
}

// Namespace mp_sat_avalon_q2_ob_activity_surprise_shipment_cs
// Params 0, eflags: 0x4
// Checksum 0x5fd0a7f8, Offset: 0x430
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace mp_sat_avalon_q2_ob_activity_surprise_shipment_cs
// Params 0, eflags: 0x4
// Checksum 0xdaeb7414, Offset: 0x441
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace mp_sat_avalon_q2_ob_activity_surprise_shipment_cs
// Params 2
// Checksum 0x6689b30b, Offset: 0x452
// Size: 0x8c
function main( unused, unused2 )
{
    if ( utility::flag_exist( "mp_sat_avalon_q2_ob_activity_surprise_shipment_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "mp_sat_avalon_q2_ob_activity_surprise_shipment_cs" ) )
    {
        return;
    }
    
    activity_common::function_e1df676808c1d1e3( &function_4cd78e661617f3 );
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "mp_sat_avalon_q2_ob_activity_surprise_shipment_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "mp_sat_avalon_q2_ob_activity_surprise_shipment_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace mp_sat_avalon_q2_ob_activity_surprise_shipment_cs
// Params 3, eflags: 0x4
// Checksum 0x5969c0db, Offset: 0x4e6
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "mp_sat_avalon_q2_ob_activity_surprise_shipment_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "mp_sat_avalon_q2_ob_activity_surprise_shipment_cs" );
}

// Namespace mp_sat_avalon_q2_ob_activity_surprise_shipment_cs
// Params 3, eflags: 0x4
// Checksum 0xaf55a0df, Offset: 0x560
// Size: 0x474
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_surprise_shipment_cs";
    s.activity_bundle = "sat_ob_activitydefinition_surprise_shipment_whitebox";
    s.name = "SURPRISE_SHIPMENT_WINERY_EAST";
    fe [[ f ]]( s, "SURPRISE_SHIPMENT_WINERY_EAST", cf, ( 25601.9, 50896.1, 1879.47 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_surprise_shipment_cs";
    s.activity_bundle = "sat_ob_activitydefinition_surprise_shipment";
    s.name = "SURPRISE_SHIPMENT_WINERY_WEST";
    fe [[ f ]]( s, "SURPRISE_SHIPMENT_WINERY_WEST", cf, ( 11133, 51915.6, 633.51 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_surprise_shipment_cs";
    s.activity_bundle = "sat_ob_activitydefinition_surprise_shipment";
    s.name = "SURPRISE_SHIPMENT_DIGSITE_01";
    fe [[ f ]]( s, "SURPRISE_SHIPMENT_DIGSITE_01", cf, ( 34493.7, 38906.5, 2890.07 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_surprise_shipment_cs";
    s.activity_bundle = "sat_ob_activitydefinition_surprise_shipment";
    s.name = "SURPRISE_SHIPMENT_CAMPSITE_01";
    fe [[ f ]]( s, "SURPRISE_SHIPMENT_CAMPSITE_01", cf, ( 8003.43, 31265.7, 2341.55 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_surprise_shipment_cs";
    s.activity_bundle = "sat_ob_activitydefinition_surprise_shipment";
    s.name = "SURPRISE_SHIPMENT_COLOSSEUM_SOUTH";
    fe [[ f ]]( s, "SURPRISE_SHIPMENT_COLOSSEUM_SOUTH", cf, ( 43924.1, 19426.6, 442.94 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_surprise_shipment_cs";
    s.activity_bundle = "sat_ob_activitydefinition_surprise_shipment";
    s.name = "SURPRISE_SHIPMENT_COLOSSEUM_EAST";
    fe [[ f ]]( s, "SURPRISE_SHIPMENT_COLOSSEUM_EAST", cf, ( 50619.7, 29474.6, 1038.98 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_surprise_shipment_cs";
    s.activity_bundle = "sat_ob_activitydefinition_surprise_shipment";
    s.name = "SURPRISE_SHIPMENT_MTN_TOWN_01";
    fe [[ f ]]( s, "SURPRISE_SHIPMENT_MTN_TOWN_01", cf, ( 23020.5, 28501.8, 2509.88 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_surprise_shipment_cs";
    s.activity_bundle = "sat_ob_activitydefinition_surprise_shipment";
    s.name = "SURPRISE_SHIPMENT_CLIFFTOWN";
    fe [[ f ]]( s, "SURPRISE_SHIPMENT_CLIFFTOWN", cf, ( 45665.9, 824.86, 1463.7 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace mp_sat_avalon_q2_ob_activity_surprise_shipment_cs
// Params 0, eflags: 0x4
// Checksum 0x710d0746, Offset: 0x9dc
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace mp_sat_avalon_q2_ob_activity_surprise_shipment_cs
// Params 0
// Checksum 0x9b3a1d96, Offset: 0x9e6
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "mp_sat_avalon_q2_ob_activity_surprise_shipment_cs" );
}

// Namespace mp_sat_avalon_q2_ob_activity_surprise_shipment_cs
// Params 0
// Checksum 0x164232ac, Offset: 0x9fc
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

// Namespace mp_sat_avalon_q2_ob_activity_surprise_shipment_cs
// Params 4
// Checksum 0xdea2e581, Offset: 0xa6b
// Size: 0x10d
function function_d4323822d7042e5a( var_4312b79c960726b6, fe, us, cf = "mp_sat_avalon_q2_ob_activity_surprise_shipment_cs" )
{
    switch ( var_4312b79c960726b6 )
    {
        case #"hash_a844bff832c9470a":
            function_5448a036bc0cc422( fe, us, cf );
            break;
        case #"hash_f46654502fd01ba8":
            function_f42c7579132e65e0( fe, us, cf );
            break;
        case #"hash_1726fc1ca61be189":
            function_309696b1a3c67a1( fe, us, cf );
            break;
        case #"hash_491ba921f65e5376":
            function_1b8d4962221b30fe( fe, us, cf );
            break;
        case #"hash_f335476855eb6766":
            function_690b1e9dfa36c14e( fe, us, cf );
            break;
        case #"hash_dfc9df1b98834118":
            function_fcb026af3a349c50( fe, us, cf );
            break;
        case #"hash_120be3a195af0762":
            function_c04a4caabcb871da( fe, us, cf );
            break;
        case #"hash_df33d18af8d0b28":
            function_43603deb6076080( fe, us, cf );
            break;
    }
}

// Namespace mp_sat_avalon_q2_ob_activity_surprise_shipment_cs
// Params 3
// Checksum 0x9c30c21a, Offset: 0xb80
// Size: 0xa7
function function_5448a036bc0cc422( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_surprise_shipment_cs";
    s.name = "ability_crate";
    fe [[ f ]]( s, "SURPRISE_SHIPMENT_WINERY_EAST", cf, ( 25434.3, 50872.7, 1895.51 ), ( 2.49, 291.02, 0.78 ), "ability_case_SURPRISE_SHIPMENT_WINERY_EAST", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_sat_avalon_q2_ob_activity_surprise_shipment_cs
// Params 3
// Checksum 0x1e4b4748, Offset: 0xc2f
// Size: 0xa7
function function_f42c7579132e65e0( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_surprise_shipment_cs";
    s.name = "ability_crate";
    fe [[ f ]]( s, "SURPRISE_SHIPMENT_WINERY_WEST", cf, ( 11153.1, 51685.8, 642.76 ), ( 0, 256.37, 0 ), "ability_case_SURPRISE_SHIPMENT_WINERY_WEST", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_sat_avalon_q2_ob_activity_surprise_shipment_cs
// Params 3
// Checksum 0xd75b24b4, Offset: 0xcde
// Size: 0xa7
function function_309696b1a3c67a1( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_surprise_shipment_cs";
    s.name = "ability_crate";
    fe [[ f ]]( s, "SURPRISE_SHIPMENT_DIGSITE_01", cf, ( 34263.2, 38902.6, 2897.1 ), ( 1.64, 163.32, 2.8 ), "ability_case_SURPRISE_SHIPMENT_DIGSITE_01", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_sat_avalon_q2_ob_activity_surprise_shipment_cs
// Params 3
// Checksum 0xfede6b3f, Offset: 0xd8d
// Size: 0xa7
function function_1b8d4962221b30fe( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_surprise_shipment_cs";
    s.name = "ability_crate";
    fe [[ f ]]( s, "SURPRISE_SHIPMENT_CAMPSITE_01", cf, ( 8134.62, 31450.1, 2363.39 ), ( 1.11, 108.64, -4.43 ), "ability_case_SURPRISE_SHIPMENT_CAMPSITE_01", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_sat_avalon_q2_ob_activity_surprise_shipment_cs
// Params 3
// Checksum 0x94ef5fc4, Offset: 0xe3c
// Size: 0xa7
function function_690b1e9dfa36c14e( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_surprise_shipment_cs";
    s.name = "ability_crate";
    fe [[ f ]]( s, "SURPRISE_SHIPMENT_COLOSSEUM_SOUTH", cf, ( 43658.6, 19459, 464.16 ), ( 359.99, 36.59, 1.29 ), "ability_case_SURPRISE_SHIPMENT_COLOSSEUM_SOUTH", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_sat_avalon_q2_ob_activity_surprise_shipment_cs
// Params 3
// Checksum 0x4036f253, Offset: 0xeeb
// Size: 0xa7
function function_fcb026af3a349c50( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_surprise_shipment_cs";
    s.name = "ability_crate";
    fe [[ f ]]( s, "SURPRISE_SHIPMENT_COLOSSEUM_EAST", cf, ( 50815.9, 29555.3, 1048.98 ), ( 0, 0, 0 ), "ability_case_SURPRISE_SHIPMENT_COLOSSEUM_EAST", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_sat_avalon_q2_ob_activity_surprise_shipment_cs
// Params 3
// Checksum 0xf5462577, Offset: 0xf9a
// Size: 0xa7
function function_c04a4caabcb871da( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_surprise_shipment_cs";
    s.name = "ability_crate";
    fe [[ f ]]( s, "SURPRISE_SHIPMENT_MTN_TOWN_01", cf, ( 23323.4, 28906.9, 2571.79 ), ( 352.49, 39.32, -0.12 ), "ability_case_SURPRISE_SHIPMENT_MTN_TOWN_01", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_sat_avalon_q2_ob_activity_surprise_shipment_cs
// Params 3
// Checksum 0x428528b5, Offset: 0x1049
// Size: 0xa7
function function_43603deb6076080( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_surprise_shipment_cs";
    s.name = "ability_crate";
    fe [[ f ]]( s, "SURPRISE_SHIPMENT_CLIFFTOWN", cf, ( 45439.5, 953.29, 1464.08 ), ( 358.7, 133.53, 0.1 ), "ability_case_SURPRISE_SHIPMENT_CLIFFTOWN", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_sat_avalon_q2_ob_activity_surprise_shipment_cs
// Params 0
// Checksum 0xce65806f, Offset: 0x10f8
// Size: 0x4c1
function function_d9dd7965c51c95d1()
{
    activityinstances = [];
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_ob_activitydefinition_surprise_shipment_whitebox";
    var_881289d7987bc770.cf = "mp_sat_avalon_q2_ob_activity_surprise_shipment_cs";
    var_881289d7987bc770.scriptstructorigin = ( 25601.9, 50896.1, 1879.47 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [];
    var_881289d7987bc770.var_31ce4477e3543d24 = [];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [];
    var_881289d7987bc770.locationradius = [];
    activityinstances[ "SURPRISE_SHIPMENT_WINERY_EAST" ] = var_881289d7987bc770;
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_ob_activitydefinition_surprise_shipment";
    var_881289d7987bc770.cf = "mp_sat_avalon_q2_ob_activity_surprise_shipment_cs";
    var_881289d7987bc770.scriptstructorigin = ( 11133, 51915.6, 633.51 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [];
    var_881289d7987bc770.var_31ce4477e3543d24 = [];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [];
    var_881289d7987bc770.locationradius = [];
    activityinstances[ "SURPRISE_SHIPMENT_WINERY_WEST" ] = var_881289d7987bc770;
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_ob_activitydefinition_surprise_shipment";
    var_881289d7987bc770.cf = "mp_sat_avalon_q2_ob_activity_surprise_shipment_cs";
    var_881289d7987bc770.scriptstructorigin = ( 34493.7, 38906.5, 2890.07 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [];
    var_881289d7987bc770.var_31ce4477e3543d24 = [];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [];
    var_881289d7987bc770.locationradius = [];
    activityinstances[ "SURPRISE_SHIPMENT_DIGSITE_01" ] = var_881289d7987bc770;
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_ob_activitydefinition_surprise_shipment";
    var_881289d7987bc770.cf = "mp_sat_avalon_q2_ob_activity_surprise_shipment_cs";
    var_881289d7987bc770.scriptstructorigin = ( 8003.43, 31265.7, 2341.55 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [];
    var_881289d7987bc770.var_31ce4477e3543d24 = [];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [];
    var_881289d7987bc770.locationradius = [];
    activityinstances[ "SURPRISE_SHIPMENT_CAMPSITE_01" ] = var_881289d7987bc770;
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_ob_activitydefinition_surprise_shipment";
    var_881289d7987bc770.cf = "mp_sat_avalon_q2_ob_activity_surprise_shipment_cs";
    var_881289d7987bc770.scriptstructorigin = ( 43924.1, 19426.6, 442.94 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [];
    var_881289d7987bc770.var_31ce4477e3543d24 = [];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [];
    var_881289d7987bc770.locationradius = [];
    activityinstances[ "SURPRISE_SHIPMENT_COLOSSEUM_SOUTH" ] = var_881289d7987bc770;
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_ob_activitydefinition_surprise_shipment";
    var_881289d7987bc770.cf = "mp_sat_avalon_q2_ob_activity_surprise_shipment_cs";
    var_881289d7987bc770.scriptstructorigin = ( 50619.7, 29474.6, 1038.98 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [];
    var_881289d7987bc770.var_31ce4477e3543d24 = [];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [];
    var_881289d7987bc770.locationradius = [];
    activityinstances[ "SURPRISE_SHIPMENT_COLOSSEUM_EAST" ] = var_881289d7987bc770;
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_ob_activitydefinition_surprise_shipment";
    var_881289d7987bc770.cf = "mp_sat_avalon_q2_ob_activity_surprise_shipment_cs";
    var_881289d7987bc770.scriptstructorigin = ( 23020.5, 28501.8, 2509.88 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [];
    var_881289d7987bc770.var_31ce4477e3543d24 = [];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [];
    var_881289d7987bc770.locationradius = [];
    activityinstances[ "SURPRISE_SHIPMENT_MTN_TOWN_01" ] = var_881289d7987bc770;
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_ob_activitydefinition_surprise_shipment";
    var_881289d7987bc770.cf = "mp_sat_avalon_q2_ob_activity_surprise_shipment_cs";
    var_881289d7987bc770.scriptstructorigin = ( 45665.9, 824.86, 1463.7 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [];
    var_881289d7987bc770.var_31ce4477e3543d24 = [];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [];
    var_881289d7987bc770.locationradius = [];
    activityinstances[ "SURPRISE_SHIPMENT_CLIFFTOWN" ] = var_881289d7987bc770;
    return activityinstances;
}

