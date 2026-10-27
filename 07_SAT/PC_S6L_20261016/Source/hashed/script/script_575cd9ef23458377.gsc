// script_575cd9ef23458377  (hash_575cd9ef23458377.gscc) (size: 5453 Bytes / 0x154d / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xb01044d4 (2953856212)
// size ...... 5453 (0x154d)
// includes .. 4   (offset: 0x135d)
// strings ... 14  (offset: 0x137d)
// dev strs .. 0   (offset: 0x154d)
// exports ... 16  (offset: 0xda1)
// cseg ...... 0x1a4 + 0xbfd (0xda1)
// imports ... 29  (offset: 0x1021)
// animtree1 . 0   (offset: 0x154d)
// animtree2 . 0   (offset: 0x154d)
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace mp_sat_avalon_q1_ob_activity_cradle_vent_cs;

// Namespace mp_sat_avalon_q1_ob_activity_cradle_vent_cs
// Params 0, eflags: 0x5
// Checksum 0xbf5a5629, Offset: 0x1c2
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"mp_sat_avalon_q1_ob_activity_cradle_vent_cs", #"activity_common", &function_b39ecd3d51489472, undefined );
}

// Namespace mp_sat_avalon_q1_ob_activity_cradle_vent_cs
// Params 0, eflags: 0x4
// Checksum 0x57979851, Offset: 0x1eb
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace mp_sat_avalon_q1_ob_activity_cradle_vent_cs
// Params 0, eflags: 0x4
// Checksum 0xd2ac4bbd, Offset: 0x1fc
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace mp_sat_avalon_q1_ob_activity_cradle_vent_cs
// Params 2
// Checksum 0x3b002e03, Offset: 0x20d
// Size: 0x8c
function main( unused, unused2 )
{
    if ( utility::flag_exist( "mp_sat_avalon_q1_ob_activity_cradle_vent_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "mp_sat_avalon_q1_ob_activity_cradle_vent_cs" ) )
    {
        return;
    }
    
    activity_common::function_e1df676808c1d1e3( &function_4cd78e661617f3 );
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "mp_sat_avalon_q1_ob_activity_cradle_vent_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "mp_sat_avalon_q1_ob_activity_cradle_vent_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace mp_sat_avalon_q1_ob_activity_cradle_vent_cs
// Params 3, eflags: 0x4
// Checksum 0x512eff72, Offset: 0x2a1
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "mp_sat_avalon_q1_ob_activity_cradle_vent_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "mp_sat_avalon_q1_ob_activity_cradle_vent_cs" );
}

// Namespace mp_sat_avalon_q1_ob_activity_cradle_vent_cs
// Params 3, eflags: 0x4
// Checksum 0xfc7abb59, Offset: 0x31b
// Size: 0x408
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_cradle_vent_cs";
    s.activity_bundle = "sat_activitydefinition_cradle_vents";
    s.name = "CRADLE_VENTS_STADIUM";
    fe [[ f ]]( s, "CRADLE_VENTS_STADIUM", cf, ( -38710.5, 11731.9, 126.98 ), ( 0, 86, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_cradle_vent_cs";
    fe [[ f ]]( s, "CRADLE_VENTS_STADIUM", cf, ( -38589.7, 11837.1, 126.98 ), ( 0, 86, 0 ), "activity_nexus_spatial_zone", undefined, "join_radius", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 2500 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_cradle_vent_cs";
    s.activity_bundle = "sat_activitydefinition_cradle_vents";
    s.name = "CRADLE_VENTS_GOLF";
    fe [[ f ]]( s, "CRADLE_VENTS_GOLF", cf, ( -31045.4, 32030.4, 1620.72 ), ( 0, 62, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_cradle_vent_cs";
    fe [[ f ]]( s, "CRADLE_VENTS_GOLF", cf, ( -30892.2, 32077.4, 1618.83 ), ( 0, 62, 0 ), "activity_nexus_spatial_zone", undefined, "join_radius", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 2500 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_cradle_vent_cs";
    s.activity_bundle = "sat_activitydefinition_cradle_vents";
    s.name = "CRADLE_VENTS_HILLS";
    fe [[ f ]]( s, "CRADLE_VENTS_HILLS", cf, ( -29605.2, 48318.8, 2096.66 ), ( 0, 245.1, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_cradle_vent_cs";
    fe [[ f ]]( s, "CRADLE_VENTS_HILLS", cf, ( -29755.6, 48263.5, 2096.53 ), ( 0, 245.1, 0 ), "activity_nexus_spatial_zone", undefined, "join_radius", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 2500 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_cradle_vent_cs";
    s.activity_bundle = "sat_activitydefinition_cradle_vents";
    s.name = "CRADLE_VENTS_SUBURBS";
    fe [[ f ]]( s, "CRADLE_VENTS_SUBURBS", cf, ( -12137.7, 47394, 537.9 ), ( 0, 10.1, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_cradle_vent_cs";
    fe [[ f ]]( s, "CRADLE_VENTS_SUBURBS", cf, ( -12006.2, 47302.5, 537.9 ), ( 0, 10.1, 0 ), "activity_nexus_spatial_zone", undefined, "join_radius", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 2500 );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace mp_sat_avalon_q1_ob_activity_cradle_vent_cs
// Params 0, eflags: 0x4
// Checksum 0x2c849a4e, Offset: 0x72b
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace mp_sat_avalon_q1_ob_activity_cradle_vent_cs
// Params 0
// Checksum 0x937d223f, Offset: 0x735
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "mp_sat_avalon_q1_ob_activity_cradle_vent_cs" );
}

// Namespace mp_sat_avalon_q1_ob_activity_cradle_vent_cs
// Params 0
// Checksum 0xfe59f50e, Offset: 0x74b
// Size: 0x66
function function_4cd78e661617f3()
{
    activityinfostruct = {};
    activityinfostruct.name = "REV_OB_CRADLE_VENTS";
    activityinfostruct.scriptbundle = "sat_activitydefinition_cradle_vents";
    activityinfostruct.mainfunction = &main;
    activityinfostruct.var_934f068483ae4ddb = &function_d4323822d7042e5a;
    activityinfostruct.metadatafunction = &function_d9dd7965c51c95d1;
    return activityinfostruct;
}

// Namespace mp_sat_avalon_q1_ob_activity_cradle_vent_cs
// Params 4
// Checksum 0x65ab7e91, Offset: 0x7ba
// Size: 0xa5
function function_d4323822d7042e5a( var_4312b79c960726b6, fe, us, cf = "mp_sat_avalon_q1_ob_activity_cradle_vent_cs" )
{
    switch ( var_4312b79c960726b6 )
    {
        case #"hash_3a048c10c7d7a5f5":
            function_6af922e1009a50d( fe, us, cf );
            break;
        case #"hash_461d02ecf250eeae":
            function_1c3088a2af9dde56( fe, us, cf );
            break;
        case #"hash_abf5a1c60c0e07fa":
            function_a245cbb47bc723d2( fe, us, cf );
            break;
        case #"hash_b591a8e508b7200c":
            function_98aa9809ed8deb04( fe, us, cf );
            break;
    }
}

// Namespace mp_sat_avalon_q1_ob_activity_cradle_vent_cs
// Params 3
// Checksum 0xab3b8693, Offset: 0x867
// Size: 0xab
function function_6af922e1009a50d( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_cradle_vent_cs";
    s.name = "power_core";
    fe [[ f ]]( s, "CRADLE_VENTS_STADIUM", cf, ( -38557.7, 11805.9, 126.98 ), ( 0, 230.69, 0 ), "power_core", undefined, "CRADLE_VENTS_STADIUM", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_sat_avalon_q1_ob_activity_cradle_vent_cs
// Params 3
// Checksum 0x6dbe8e88, Offset: 0x91a
// Size: 0xab
function function_1c3088a2af9dde56( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_cradle_vent_cs";
    s.name = "power_core";
    fe [[ f ]]( s, "CRADLE_VENTS_GOLF", cf, ( -30875.7, 32035.9, 1619.89 ), ( 0, 206.69, 0 ), "power_core", undefined, "CRADLE_VENTS_GOLF", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_sat_avalon_q1_ob_activity_cradle_vent_cs
// Params 3
// Checksum 0xd5a56857, Offset: 0x9cd
// Size: 0xab
function function_a245cbb47bc723d2( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_cradle_vent_cs";
    s.name = "power_core";
    fe [[ f ]]( s, "CRADLE_VENTS_HILLS", cf, ( -29774.3, 48304.1, 2096.37 ), ( 0, 29.79, 0 ), "power_core", undefined, "CRADLE_VENTS_HILLS", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_sat_avalon_q1_ob_activity_cradle_vent_cs
// Params 3
// Checksum 0x26379bba, Offset: 0xa80
// Size: 0xab
function function_98aa9809ed8deb04( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_cradle_vent_cs";
    s.name = "power_core";
    fe [[ f ]]( s, "CRADLE_VENTS_SUBURBS", cf, ( -12028.7, 47263.9, 537.9 ), ( 0, 154.79, 0 ), "power_core", undefined, "CRADLE_VENTS_SUBURBS", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_sat_avalon_q1_ob_activity_cradle_vent_cs
// Params 0
// Checksum 0x6e1b45e9, Offset: 0xb33
// Size: 0x26d
function function_d9dd7965c51c95d1()
{
    activityinstances = [];
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_activitydefinition_cradle_vents";
    var_881289d7987bc770.cf = "mp_sat_avalon_q1_ob_activity_cradle_vent_cs";
    var_881289d7987bc770.scriptstructorigin = ( -38710.5, 11731.9, 126.98 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [];
    var_881289d7987bc770.var_31ce4477e3543d24 = [];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [];
    var_881289d7987bc770.locationradius = [];
    activityinstances[ "CRADLE_VENTS_STADIUM" ] = var_881289d7987bc770;
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_activitydefinition_cradle_vents";
    var_881289d7987bc770.cf = "mp_sat_avalon_q1_ob_activity_cradle_vent_cs";
    var_881289d7987bc770.scriptstructorigin = ( -31045.4, 32030.4, 1620.72 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [];
    var_881289d7987bc770.var_31ce4477e3543d24 = [];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [];
    var_881289d7987bc770.locationradius = [];
    activityinstances[ "CRADLE_VENTS_GOLF" ] = var_881289d7987bc770;
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_activitydefinition_cradle_vents";
    var_881289d7987bc770.cf = "mp_sat_avalon_q1_ob_activity_cradle_vent_cs";
    var_881289d7987bc770.scriptstructorigin = ( -29605.2, 48318.8, 2096.66 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [];
    var_881289d7987bc770.var_31ce4477e3543d24 = [];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [];
    var_881289d7987bc770.locationradius = [];
    activityinstances[ "CRADLE_VENTS_HILLS" ] = var_881289d7987bc770;
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_activitydefinition_cradle_vents";
    var_881289d7987bc770.cf = "mp_sat_avalon_q1_ob_activity_cradle_vent_cs";
    var_881289d7987bc770.scriptstructorigin = ( -12137.7, 47394, 537.9 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [];
    var_881289d7987bc770.var_31ce4477e3543d24 = [];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [];
    var_881289d7987bc770.locationradius = [];
    activityinstances[ "CRADLE_VENTS_SUBURBS" ] = var_881289d7987bc770;
    return activityinstances;
}

