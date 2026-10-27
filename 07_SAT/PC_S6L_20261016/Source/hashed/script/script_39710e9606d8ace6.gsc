// script_39710e9606d8ace6  (hash_39710e9606d8ace6.gscc) (size: 5179 Bytes / 0x143b / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x60001097 (1610616983)
// size ...... 5179 (0x143b)
// includes .. 4   (offset: 0x1293)
// strings ... 17  (offset: 0x12b3)
// dev strs .. 0   (offset: 0x143b)
// exports ... 16  (offset: 0xcd7)
// cseg ...... 0x292 + 0xa45 (0xcd7)
// imports ... 29  (offset: 0xf57)
// animtree1 . 0   (offset: 0x143b)
// animtree2 . 0   (offset: 0x143b)
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace mp_sat_avalon_q3_ob_activity_suprise_shipment_cs;

// Namespace mp_sat_avalon_q3_ob_activity_suprise_shipment_cs
// Params 0, eflags: 0x5
// Checksum 0x410ec882, Offset: 0x2b0
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"mp_sat_avalon_q3_ob_activity_suprise_shipment_cs", #"activity_common", &function_b39ecd3d51489472, undefined );
}

// Namespace mp_sat_avalon_q3_ob_activity_suprise_shipment_cs
// Params 0, eflags: 0x4
// Checksum 0xaf0dbc0f, Offset: 0x2d9
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace mp_sat_avalon_q3_ob_activity_suprise_shipment_cs
// Params 0, eflags: 0x4
// Checksum 0x2a366fe3, Offset: 0x2ea
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace mp_sat_avalon_q3_ob_activity_suprise_shipment_cs
// Params 2
// Checksum 0xf7d72470, Offset: 0x2fb
// Size: 0x8c
function main( unused, unused2 )
{
    if ( utility::flag_exist( "mp_sat_avalon_q3_ob_activity_suprise_shipment_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "mp_sat_avalon_q3_ob_activity_suprise_shipment_cs" ) )
    {
        return;
    }
    
    activity_common::function_e1df676808c1d1e3( &function_4cd78e661617f3 );
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "mp_sat_avalon_q3_ob_activity_suprise_shipment_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "mp_sat_avalon_q3_ob_activity_suprise_shipment_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace mp_sat_avalon_q3_ob_activity_suprise_shipment_cs
// Params 3, eflags: 0x4
// Checksum 0xa9b4db2c, Offset: 0x38f
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "mp_sat_avalon_q3_ob_activity_suprise_shipment_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "mp_sat_avalon_q3_ob_activity_suprise_shipment_cs" );
}

// Namespace mp_sat_avalon_q3_ob_activity_suprise_shipment_cs
// Params 3, eflags: 0x4
// Checksum 0x7fbdb4c1, Offset: 0x409
// Size: 0x260
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_suprise_shipment_cs";
    s.activity_bundle = "sat_ob_activitydefinition_surprise_shipment_whitebox";
    s.name = "SURPRISE_SHIPMENT_FORT_STORAGE";
    fe [[ f ]]( s, "SURPRISE_SHIPMENT_FORT_STORAGE", cf, ( -38970.2, -35779.4, 1016.36 ), ( 0, 270, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_suprise_shipment_cs";
    s.activity_bundle = "sat_ob_activitydefinition_surprise_shipment_whitebox";
    s.name = "SURPRISE_SHIPMENT_SAM_SITE";
    fe [[ f ]]( s, "SURPRISE_SHIPMENT_SAM_SITE", cf, ( -31009.4, -19751, 234.12 ), ( 0, 270, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_suprise_shipment_cs";
    s.activity_bundle = "sat_ob_activitydefinition_surprise_shipment_whitebox";
    s.name = "SURPRISE_SHIPMENT_BASE";
    fe [[ f ]]( s, "SURPRISE_SHIPMENT_BASE", cf, ( -19966.5, -41355.3, 352.24 ), ( 0, 180, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_suprise_shipment_cs";
    s.activity_bundle = "sat_ob_activitydefinition_surprise_shipment_whitebox";
    s.name = "SURPRISE_SHIPMENT_PARKING_LOT";
    fe [[ f ]]( s, "SURPRISE_SHIPMENT_PARKING_LOT", cf, ( -22146.8, -31584.4, 433.07 ), ( 0, 90, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace mp_sat_avalon_q3_ob_activity_suprise_shipment_cs
// Params 0, eflags: 0x4
// Checksum 0xe053903d, Offset: 0x671
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace mp_sat_avalon_q3_ob_activity_suprise_shipment_cs
// Params 0
// Checksum 0x6be70661, Offset: 0x67b
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "mp_sat_avalon_q3_ob_activity_suprise_shipment_cs" );
}

// Namespace mp_sat_avalon_q3_ob_activity_suprise_shipment_cs
// Params 0
// Checksum 0xe69f295b, Offset: 0x691
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

// Namespace mp_sat_avalon_q3_ob_activity_suprise_shipment_cs
// Params 4
// Checksum 0xc4cb122, Offset: 0x700
// Size: 0xa5
function function_d4323822d7042e5a( var_4312b79c960726b6, fe, us, cf = "mp_sat_avalon_q3_ob_activity_suprise_shipment_cs" )
{
    switch ( var_4312b79c960726b6 )
    {
        case #"hash_7e05e0ceaf5b8e5":
            function_f7d6bac5b0ffd1bd( fe, us, cf );
            break;
        case #"hash_c0e48a51ae8ad63d":
            function_89dde9dd8c036fb5( fe, us, cf );
            break;
        case #"hash_c3fca2a0050a44bb":
            function_9ff54ec2a7b914c3( fe, us, cf );
            break;
        case #"hash_8be4b2583f253afa":
            function_6d468578ac8f992( fe, us, cf );
            break;
    }
}

// Namespace mp_sat_avalon_q3_ob_activity_suprise_shipment_cs
// Params 3
// Checksum 0x98e2b9b0, Offset: 0x7ad
// Size: 0xa7
function function_f7d6bac5b0ffd1bd( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_suprise_shipment_cs";
    s.name = "ability_crate";
    fe [[ f ]]( s, "SURPRISE_SHIPMENT_FORT_STORAGE", cf, ( -38831, -35900.9, 1023 ), ( 0, 271.84, 0 ), "ability_case_SURPRISE_SHIPMENT_FORT_STORAGE", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_sat_avalon_q3_ob_activity_suprise_shipment_cs
// Params 3
// Checksum 0xa7b9d4bb, Offset: 0x85c
// Size: 0xa7
function function_89dde9dd8c036fb5( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_suprise_shipment_cs";
    s.name = "ability_crate";
    fe [[ f ]]( s, "SURPRISE_SHIPMENT_SAM_SITE", cf, ( -31174.7, -19796.1, 242.47 ), ( 0, 82.17, -0.98 ), "ability_case_SURPRISE_SHIPMENT_SAM_SITE", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_sat_avalon_q3_ob_activity_suprise_shipment_cs
// Params 3
// Checksum 0xd228ffc1, Offset: 0x90b
// Size: 0xa7
function function_9ff54ec2a7b914c3( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_suprise_shipment_cs";
    s.name = "ability_crate";
    fe [[ f ]]( s, "SURPRISE_SHIPMENT_BASE", cf, ( -19880.6, -41636.3, 362.29 ), ( 0, 189.85, 0 ), "ability_case_SURPRISE_SHIPMENT_BASE", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_sat_avalon_q3_ob_activity_suprise_shipment_cs
// Params 3
// Checksum 0xeb07dbed, Offset: 0x9ba
// Size: 0xa7
function function_6d468578ac8f992( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_suprise_shipment_cs";
    s.name = "ability_crate";
    fe [[ f ]]( s, "SURPRISE_SHIPMENT_PARKING_LOT", cf, ( -21984.4, -32385.7, 440.12 ), ( 0, 181.42, 0 ), "ability_case_SURPRISE_SHIPMENT_PARKING_LOT", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_sat_avalon_q3_ob_activity_suprise_shipment_cs
// Params 0
// Checksum 0xf5e0f8d0, Offset: 0xa69
// Size: 0x26d
function function_d9dd7965c51c95d1()
{
    activityinstances = [];
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_ob_activitydefinition_surprise_shipment_whitebox";
    var_881289d7987bc770.cf = "mp_sat_avalon_q3_ob_activity_suprise_shipment_cs";
    var_881289d7987bc770.scriptstructorigin = ( -38970.2, -35779.4, 1016.36 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [];
    var_881289d7987bc770.var_31ce4477e3543d24 = [];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [];
    var_881289d7987bc770.locationradius = [];
    activityinstances[ "SURPRISE_SHIPMENT_FORT_STORAGE" ] = var_881289d7987bc770;
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_ob_activitydefinition_surprise_shipment_whitebox";
    var_881289d7987bc770.cf = "mp_sat_avalon_q3_ob_activity_suprise_shipment_cs";
    var_881289d7987bc770.scriptstructorigin = ( -31009.4, -19751, 234.12 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [];
    var_881289d7987bc770.var_31ce4477e3543d24 = [];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [];
    var_881289d7987bc770.locationradius = [];
    activityinstances[ "SURPRISE_SHIPMENT_SAM_SITE" ] = var_881289d7987bc770;
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_ob_activitydefinition_surprise_shipment_whitebox";
    var_881289d7987bc770.cf = "mp_sat_avalon_q3_ob_activity_suprise_shipment_cs";
    var_881289d7987bc770.scriptstructorigin = ( -19966.5, -41355.3, 352.24 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [];
    var_881289d7987bc770.var_31ce4477e3543d24 = [];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [];
    var_881289d7987bc770.locationradius = [];
    activityinstances[ "SURPRISE_SHIPMENT_BASE" ] = var_881289d7987bc770;
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_ob_activitydefinition_surprise_shipment_whitebox";
    var_881289d7987bc770.cf = "mp_sat_avalon_q3_ob_activity_suprise_shipment_cs";
    var_881289d7987bc770.scriptstructorigin = ( -22146.8, -31584.4, 433.07 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [];
    var_881289d7987bc770.var_31ce4477e3543d24 = [];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [];
    var_881289d7987bc770.locationradius = [];
    activityinstances[ "SURPRISE_SHIPMENT_PARKING_LOT" ] = var_881289d7987bc770;
    return activityinstances;
}

