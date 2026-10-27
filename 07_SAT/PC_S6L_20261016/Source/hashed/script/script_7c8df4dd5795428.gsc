// script_7c8df4dd5795428  (hash_07c8df4dd5795428.gscc) (size: 2969 Bytes / 0xb99 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x6f2d3e9e (1865236126)
// size ...... 2969 (0xb99)
// includes .. 4   (offset: 0xab1)
// strings ... 11  (offset: 0xad1)
// dev strs .. 0   (offset: 0xb99)
// exports ... 13  (offset: 0x5e9)
// cseg ...... 0x160 + 0x489 (0x5e9)
// imports ... 25  (offset: 0x7f1)
// animtree1 . 0   (offset: 0xb99)
// animtree2 . 0   (offset: 0xb99)
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace mp_sat_avalon_city_ob_activity_cradle_vent_cs;

// Namespace mp_sat_avalon_city_ob_activity_cradle_vent_cs
// Params 0, eflags: 0x5
// Checksum 0xe0e01b7e, Offset: 0x17e
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"mp_sat_avalon_city_ob_activity_cradle_vent_cs", #"activity_common", &function_b39ecd3d51489472, undefined );
}

// Namespace mp_sat_avalon_city_ob_activity_cradle_vent_cs
// Params 0, eflags: 0x4
// Checksum 0x84009c85, Offset: 0x1a7
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace mp_sat_avalon_city_ob_activity_cradle_vent_cs
// Params 0, eflags: 0x4
// Checksum 0x738c1c9d, Offset: 0x1b8
// Size: 0x15
function private structs_init()
{
    main();
    activity_common::function_e1df676808c1d1e3( &function_4cd78e661617f3 );
}

// Namespace mp_sat_avalon_city_ob_activity_cradle_vent_cs
// Params 2
// Checksum 0x73989a28, Offset: 0x1d5
// Size: 0x70
function main( unused, unused2 )
{
    if ( utility::flag_exist( "mp_sat_avalon_city_ob_activity_cradle_vent_cs" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "mp_sat_avalon_city_ob_activity_cradle_vent_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "mp_sat_avalon_city_ob_activity_cradle_vent_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace mp_sat_avalon_city_ob_activity_cradle_vent_cs
// Params 3, eflags: 0x4
// Checksum 0x82b9fba6, Offset: 0x24d
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "mp_sat_avalon_city_ob_activity_cradle_vent_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "mp_sat_avalon_city_ob_activity_cradle_vent_cs" );
}

// Namespace mp_sat_avalon_city_ob_activity_cradle_vent_cs
// Params 3, eflags: 0x4
// Checksum 0x66299f9f, Offset: 0x2c7
// Size: 0xf7
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_cradle_vent_cs";
    s.name = "CRADLE_VENTS_TEST";
    fe [[ f ]]( s, "CRADLE_VENTS_TEST", cf, ( -3946, 2102.21, 478.95 ), ( 0, 326.2, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_cradle_vent_cs";
    fe [[ f ]]( s, "CRADLE_VENTS_TEST", cf, ( -3928.14, 2219.47, 478.25 ), ( 0, 191.2, 0 ), "activity_nexus_spatial_zone", undefined, "join_radius", undefined, "activity_link", undefined, undefined, 2500 );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace mp_sat_avalon_city_ob_activity_cradle_vent_cs
// Params 0, eflags: 0x4
// Checksum 0xd4e1fe99, Offset: 0x3c6
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace mp_sat_avalon_city_ob_activity_cradle_vent_cs
// Params 0
// Checksum 0x40ea26eb, Offset: 0x3d0
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "mp_sat_avalon_city_ob_activity_cradle_vent_cs" );
}

// Namespace mp_sat_avalon_city_ob_activity_cradle_vent_cs
// Params 0
// Checksum 0x2dcef1da, Offset: 0x3e6
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

// Namespace mp_sat_avalon_city_ob_activity_cradle_vent_cs
// Params 4
// Checksum 0x20cda2ea, Offset: 0x455
// Size: 0x57
function function_d4323822d7042e5a( var_4312b79c960726b6, fe, us, cf = "mp_sat_avalon_city_ob_activity_cradle_vent_cs" )
{
    switch ( var_4312b79c960726b6 )
    {
        case #"hash_501ece90e1fbb57a":
            function_874066312d800b42( fe, us, cf );
            break;
    }
}

// Namespace mp_sat_avalon_city_ob_activity_cradle_vent_cs
// Params 3
// Checksum 0xcf32d16b, Offset: 0x4b4
// Size: 0x8f
function function_874066312d800b42( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_cradle_vent_cs";
    s.name = "power_core";
    fe [[ f ]]( s, "CRADLE_VENTS_TEST", cf, ( -3857.89, 2251.14, 525.9 ), ( 0, 178.19, 0 ), "power_core", undefined, "CRADLE_VENTS_TEST" );
}

// Namespace mp_sat_avalon_city_ob_activity_cradle_vent_cs
// Params 0
// Checksum 0x182d282a, Offset: 0x54b
// Size: 0x9d
function function_d9dd7965c51c95d1()
{
    activityinstances = [];
    var_881289d7987bc770 = {};
    var_881289d7987bc770.cf = "mp_sat_avalon_city_ob_activity_cradle_vent_cs";
    var_881289d7987bc770.scriptstructorigin = ( -3946, 2102.21, 478.95 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [];
    var_881289d7987bc770.var_31ce4477e3543d24 = [];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [];
    var_881289d7987bc770.locationradius = [];
    activityinstances[ "CRADLE_VENTS_TEST" ] = var_881289d7987bc770;
    return activityinstances;
}

