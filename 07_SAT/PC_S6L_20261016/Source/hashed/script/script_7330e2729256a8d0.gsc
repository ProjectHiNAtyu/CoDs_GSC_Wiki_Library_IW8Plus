// script_7330e2729256a8d0  (hash_7330e2729256a8d0.gscc) (size: 4718 Bytes / 0x126e / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x159cd621 (362599969)
// size ...... 4718 (0x126e)
// includes .. 4   (offset: 0x10f6)
// strings ... 13  (offset: 0x1116)
// dev strs .. 0   (offset: 0x126e)
// exports ... 16  (offset: 0xb3a)
// cseg ...... 0x1b9 + 0x981 (0xb3a)
// imports ... 29  (offset: 0xdba)
// animtree1 . 0   (offset: 0x126e)
// animtree2 . 0   (offset: 0x126e)
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace mp_sat_avalon_q2_ob_activity_convoy_cs;

// Namespace mp_sat_avalon_q2_ob_activity_convoy_cs
// Params 0, eflags: 0x5
// Checksum 0xc997c312, Offset: 0x1d7
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"mp_sat_avalon_q2_ob_activity_convoy_cs", #"activity_common", &function_b39ecd3d51489472, undefined );
}

// Namespace mp_sat_avalon_q2_ob_activity_convoy_cs
// Params 0, eflags: 0x4
// Checksum 0xcf0265ca, Offset: 0x200
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace mp_sat_avalon_q2_ob_activity_convoy_cs
// Params 0, eflags: 0x4
// Checksum 0x4a39b626, Offset: 0x211
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace mp_sat_avalon_q2_ob_activity_convoy_cs
// Params 2
// Checksum 0x88b98c9d, Offset: 0x222
// Size: 0x8c
function main( unused, unused2 )
{
    if ( utility::flag_exist( "mp_sat_avalon_q2_ob_activity_convoy_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "mp_sat_avalon_q2_ob_activity_convoy_cs" ) )
    {
        return;
    }
    
    activity_common::function_e1df676808c1d1e3( &function_4cd78e661617f3 );
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "mp_sat_avalon_q2_ob_activity_convoy_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "mp_sat_avalon_q2_ob_activity_convoy_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace mp_sat_avalon_q2_ob_activity_convoy_cs
// Params 3, eflags: 0x4
// Checksum 0xc9bb02e9, Offset: 0x2b6
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "mp_sat_avalon_q2_ob_activity_convoy_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "mp_sat_avalon_q2_ob_activity_convoy_cs" );
}

// Namespace mp_sat_avalon_q2_ob_activity_convoy_cs
// Params 3, eflags: 0x4
// Checksum 0xf8a60fd8, Offset: 0x330
// Size: 0x3c0
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_convoy_cs";
    fe [[ f ]]( s, "ARMORED_CONVOY_Q2_WINERY", cf, ( 21480.1, 43977.9, 929.43 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "OB_Spacer_Spatial_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 50 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_convoy_cs";
    s.name = "ARMORED_CONVOY_Q2_WINERY";
    fe [[ f ]]( s, "ARMORED_CONVOY_Q2_WINERY", cf, ( 21303.6, 44183.6, 929.42 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_convoy_cs";
    fe [[ f ]]( s, "ARMORED_CONVOY_Q2_RESORT", cf, ( 13104.4, 39910.9, 898.41 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "OB_Spacer_Spatial_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 50 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_convoy_cs";
    s.name = "ARMORED_CONVOY_Q2_RESORT";
    fe [[ f ]]( s, "ARMORED_CONVOY_Q2_RESORT", cf, ( 13043, 39687.2, 924.37 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_convoy_cs";
    fe [[ f ]]( s, "ARMORED_CONVOY_Q2_HILLSIDE", cf, ( 21480.1, 43977.9, 929.43 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "OB_Spacer_Spatial_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 50 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_convoy_cs";
    s.name = "ARMORED_CONVOY_Q2_HILLSIDE";
    fe [[ f ]]( s, "ARMORED_CONVOY_Q2_HILLSIDE", cf, ( 24855.8, 34092, 2701.75 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_convoy_cs";
    fe [[ f ]]( s, "ARMORED_CONVOY_Q2_CLIFFTOWN", cf, ( 36482.3, 24064.2, 1489.92 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "OB_Spacer_Spatial_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 50 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_convoy_cs";
    s.name = "ARMORED_CONVOY_Q2_CLIFFTOWN";
    fe [[ f ]]( s, "ARMORED_CONVOY_Q2_CLIFFTOWN", cf, ( 36145.7, 24631.8, 1484.99 ), ( 0, 282.19, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace mp_sat_avalon_q2_ob_activity_convoy_cs
// Params 0, eflags: 0x4
// Checksum 0x9f3d38d0, Offset: 0x6f8
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace mp_sat_avalon_q2_ob_activity_convoy_cs
// Params 0
// Checksum 0xbe8dfa4, Offset: 0x702
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "mp_sat_avalon_q2_ob_activity_convoy_cs" );
}

// Namespace mp_sat_avalon_q2_ob_activity_convoy_cs
// Params 0
// Checksum 0xbe011696, Offset: 0x718
// Size: 0x66
function function_4cd78e661617f3()
{
    activityinfostruct = {};
    activityinfostruct.name = "REV_OB_ARMORED_CONVOY";
    activityinfostruct.scriptbundle = "sat_activitydefinition_armoredconvoy";
    activityinfostruct.mainfunction = &main;
    activityinfostruct.var_934f068483ae4ddb = &function_d4323822d7042e5a;
    activityinfostruct.metadatafunction = &function_d9dd7965c51c95d1;
    return activityinfostruct;
}

// Namespace mp_sat_avalon_q2_ob_activity_convoy_cs
// Params 4
// Checksum 0xa27ea505, Offset: 0x787
// Size: 0xa5
function function_d4323822d7042e5a( var_4312b79c960726b6, fe, us, cf = "mp_sat_avalon_q2_ob_activity_convoy_cs" )
{
    switch ( var_4312b79c960726b6 )
    {
        case #"hash_be1043efe17a0ed7":
            function_8fc416248832f98f( fe, us, cf );
            break;
        case #"hash_3a1efd24edb8dabe":
            function_d15f130c9abe33b6( fe, us, cf );
            break;
        case #"hash_583fbd4ad9656cf":
            function_80c2c44cee454a7( fe, us, cf );
            break;
        case #"hash_9a5d64ea53c4ab5f":
            function_6d910640950908d7( fe, us, cf );
            break;
    }
}

// Namespace mp_sat_avalon_q2_ob_activity_convoy_cs
// Params 3
// Checksum 0x1cdb235, Offset: 0x834
// Size: 0x2f
function function_8fc416248832f98f( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
}

// Namespace mp_sat_avalon_q2_ob_activity_convoy_cs
// Params 3
// Checksum 0x45a5b8ae, Offset: 0x86b
// Size: 0x2f
function function_d15f130c9abe33b6( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
}

// Namespace mp_sat_avalon_q2_ob_activity_convoy_cs
// Params 3
// Checksum 0x30ae18a9, Offset: 0x8a2
// Size: 0x2f
function function_80c2c44cee454a7( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
}

// Namespace mp_sat_avalon_q2_ob_activity_convoy_cs
// Params 3
// Checksum 0x84e4703a, Offset: 0x8d9
// Size: 0x2f
function function_6d910640950908d7( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
}

// Namespace mp_sat_avalon_q2_ob_activity_convoy_cs
// Params 0
// Checksum 0x4994f09, Offset: 0x910
// Size: 0x229
function function_d9dd7965c51c95d1()
{
    activityinstances = [];
    var_881289d7987bc770 = {};
    var_881289d7987bc770.cf = "mp_sat_avalon_q2_ob_activity_convoy_cs";
    var_881289d7987bc770.scriptstructorigin = ( 21303.6, 44183.6, 929.42 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [];
    var_881289d7987bc770.var_31ce4477e3543d24 = [];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [];
    var_881289d7987bc770.locationradius = [];
    activityinstances[ "ARMORED_CONVOY_Q2_WINERY" ] = var_881289d7987bc770;
    var_881289d7987bc770 = {};
    var_881289d7987bc770.cf = "mp_sat_avalon_q2_ob_activity_convoy_cs";
    var_881289d7987bc770.scriptstructorigin = ( 13043, 39687.2, 924.37 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [];
    var_881289d7987bc770.var_31ce4477e3543d24 = [];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [];
    var_881289d7987bc770.locationradius = [];
    activityinstances[ "ARMORED_CONVOY_Q2_RESORT" ] = var_881289d7987bc770;
    var_881289d7987bc770 = {};
    var_881289d7987bc770.cf = "mp_sat_avalon_q2_ob_activity_convoy_cs";
    var_881289d7987bc770.scriptstructorigin = ( 24855.8, 34092, 2701.75 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [];
    var_881289d7987bc770.var_31ce4477e3543d24 = [];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [];
    var_881289d7987bc770.locationradius = [];
    activityinstances[ "ARMORED_CONVOY_Q2_HILLSIDE" ] = var_881289d7987bc770;
    var_881289d7987bc770 = {};
    var_881289d7987bc770.cf = "mp_sat_avalon_q2_ob_activity_convoy_cs";
    var_881289d7987bc770.scriptstructorigin = ( 36145.7, 24631.8, 1484.99 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [];
    var_881289d7987bc770.var_31ce4477e3543d24 = [];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [];
    var_881289d7987bc770.locationradius = [];
    activityinstances[ "ARMORED_CONVOY_Q2_CLIFFTOWN" ] = var_881289d7987bc770;
    return activityinstances;
}

