// script_1ca1dd6d27cf5c1  (hash_01ca1dd6d27cf5c1.gscc) (size: 3535 Bytes / 0xdcf / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x27f79660 (670537312)
// size ...... 3535 (0xdcf)
// includes .. 4   (offset: 0xcc7)
// strings ... 11  (offset: 0xce7)
// dev strs .. 0   (offset: 0xdcf)
// exports ... 14  (offset: 0x79b)
// cseg ...... 0x17e + 0x61d (0x79b)
// imports ... 27  (offset: 0x9cb)
// animtree1 . 0   (offset: 0xdcf)
// animtree2 . 0   (offset: 0xdcf)
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace mp_sat_avalon_city_ob_convoy_cs;

// Namespace mp_sat_avalon_city_ob_convoy_cs
// Params 0, eflags: 0x5
// Checksum 0xaaae07d3, Offset: 0x19c
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"mp_sat_avalon_city_ob_convoy_cs", #"activity_common", &function_b39ecd3d51489472, undefined );
}

// Namespace mp_sat_avalon_city_ob_convoy_cs
// Params 0, eflags: 0x4
// Checksum 0x599e7469, Offset: 0x1c5
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace mp_sat_avalon_city_ob_convoy_cs
// Params 0, eflags: 0x4
// Checksum 0xdca5a785, Offset: 0x1d6
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace mp_sat_avalon_city_ob_convoy_cs
// Params 2
// Checksum 0xefe05471, Offset: 0x1e7
// Size: 0x8c
function main( unused, unused2 )
{
    if ( utility::flag_exist( "mp_sat_avalon_city_ob_convoy_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "mp_sat_avalon_city_ob_convoy_cs" ) )
    {
        return;
    }
    
    activity_common::function_e1df676808c1d1e3( &function_4cd78e661617f3 );
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "mp_sat_avalon_city_ob_convoy_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "mp_sat_avalon_city_ob_convoy_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace mp_sat_avalon_city_ob_convoy_cs
// Params 3, eflags: 0x4
// Checksum 0x5f27134a, Offset: 0x27b
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "mp_sat_avalon_city_ob_convoy_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "mp_sat_avalon_city_ob_convoy_cs" );
}

// Namespace mp_sat_avalon_city_ob_convoy_cs
// Params 3, eflags: 0x4
// Checksum 0x9b7f68, Offset: 0x2f5
// Size: 0x206
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_convoy_cs";
    fe [[ f ]]( s, "ARMORED_CONVOY_CITY_LOW_TOWN", cf, ( 7767.2, -13366.8, -1430.31 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "OB_Spacer_Spatial_Zone", undefined, "activity_link", ( 14488, -3224, 2020.66 ), ( 0, 0, 0 ), 50 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_convoy_cs";
    s.name = "ARMORED_CONVOY_CITY_LOW_TOWN";
    fe [[ f ]]( s, "ARMORED_CONVOY_CITY_LOW_TOWN", cf, ( 0, 0, 0 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 14488, -3224, 2020.66 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_convoy_cs";
    fe [[ f ]]( s, "ARMORED_CONVOY_CITY_HIGH_TOWN", cf, ( -14650, 10343, 1063.1 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "OB_Spacer_Spatial_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 50 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_convoy_cs";
    s.name = "ARMORED_CONVOY_CITY_HIGH_TOWN";
    fe [[ f ]]( s, "ARMORED_CONVOY_CITY_HIGH_TOWN", cf, ( -15127.4, 9897.61, 1039.25 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace mp_sat_avalon_city_ob_convoy_cs
// Params 0, eflags: 0x4
// Checksum 0xf864e03c, Offset: 0x503
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace mp_sat_avalon_city_ob_convoy_cs
// Params 0
// Checksum 0x9d74ce07, Offset: 0x50d
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "mp_sat_avalon_city_ob_convoy_cs" );
}

// Namespace mp_sat_avalon_city_ob_convoy_cs
// Params 0
// Checksum 0x289d0735, Offset: 0x523
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

// Namespace mp_sat_avalon_city_ob_convoy_cs
// Params 4
// Checksum 0x74cc56bb, Offset: 0x592
// Size: 0x71
function function_d4323822d7042e5a( var_4312b79c960726b6, fe, us, cf = "mp_sat_avalon_city_ob_convoy_cs" )
{
    switch ( var_4312b79c960726b6 )
    {
        case #"hash_ca4aa0df8035df4c":
            function_9edf95c0165667a4( fe, us, cf );
            break;
        case #"hash_9616e2f288f0b9d0":
            function_1db2dbeec5275dc8( fe, us, cf );
            break;
    }
}

// Namespace mp_sat_avalon_city_ob_convoy_cs
// Params 3
// Checksum 0x7b3ab35e, Offset: 0x60b
// Size: 0x2f
function function_9edf95c0165667a4( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
}

// Namespace mp_sat_avalon_city_ob_convoy_cs
// Params 3
// Checksum 0x732e5eb8, Offset: 0x642
// Size: 0x2f
function function_1db2dbeec5275dc8( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
}

// Namespace mp_sat_avalon_city_ob_convoy_cs
// Params 0
// Checksum 0xad5a5da, Offset: 0x679
// Size: 0x121
function function_d9dd7965c51c95d1()
{
    activityinstances = [];
    var_881289d7987bc770 = {};
    var_881289d7987bc770.cf = "mp_sat_avalon_city_ob_convoy_cs";
    var_881289d7987bc770.scriptstructorigin = ( 0, 0, 0 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 14488, -3224, 2020.66 );
    var_881289d7987bc770.locationorigin = [];
    var_881289d7987bc770.var_31ce4477e3543d24 = [];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [];
    var_881289d7987bc770.locationradius = [];
    activityinstances[ "ARMORED_CONVOY_CITY_LOW_TOWN" ] = var_881289d7987bc770;
    var_881289d7987bc770 = {};
    var_881289d7987bc770.cf = "mp_sat_avalon_city_ob_convoy_cs";
    var_881289d7987bc770.scriptstructorigin = ( -15127.4, 9897.61, 1039.25 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [];
    var_881289d7987bc770.var_31ce4477e3543d24 = [];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [];
    var_881289d7987bc770.locationradius = [];
    activityinstances[ "ARMORED_CONVOY_CITY_HIGH_TOWN" ] = var_881289d7987bc770;
    return activityinstances;
}

