// script_bbec198d1fd3386  (hash_0bbec198d1fd3386.gscc) (size: 3717 Bytes / 0xe85 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x6971d072 (1769066610)
// size ...... 3717 (0xe85)
// includes .. 4   (offset: 0xd45)
// strings ... 12  (offset: 0xd65)
// dev strs .. 0   (offset: 0xe85)
// exports ... 14  (offset: 0x819)
// cseg ...... 0x19a + 0x67f (0x819)
// imports ... 27  (offset: 0xa49)
// animtree1 . 0   (offset: 0xe85)
// animtree2 . 0   (offset: 0xe85)
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace mp_sat_avalon_city_ob_activity_scorpio_cs;

// Namespace mp_sat_avalon_city_ob_activity_scorpio_cs
// Params 0, eflags: 0x5
// Checksum 0xf49df194, Offset: 0x1b8
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"mp_sat_avalon_city_ob_activity_scorpio_cs", #"activity_common", &function_b39ecd3d51489472, undefined );
}

// Namespace mp_sat_avalon_city_ob_activity_scorpio_cs
// Params 0, eflags: 0x4
// Checksum 0x406c2c35, Offset: 0x1e1
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace mp_sat_avalon_city_ob_activity_scorpio_cs
// Params 0, eflags: 0x4
// Checksum 0xc557ffd9, Offset: 0x1f2
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace mp_sat_avalon_city_ob_activity_scorpio_cs
// Params 2
// Checksum 0x83395cc6, Offset: 0x203
// Size: 0x8c
function main( unused, unused2 )
{
    if ( utility::flag_exist( "mp_sat_avalon_city_ob_activity_scorpio_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "mp_sat_avalon_city_ob_activity_scorpio_cs" ) )
    {
        return;
    }
    
    activity_common::function_e1df676808c1d1e3( &function_4cd78e661617f3 );
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "mp_sat_avalon_city_ob_activity_scorpio_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "mp_sat_avalon_city_ob_activity_scorpio_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace mp_sat_avalon_city_ob_activity_scorpio_cs
// Params 3, eflags: 0x4
// Checksum 0x46d54b16, Offset: 0x297
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "mp_sat_avalon_city_ob_activity_scorpio_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "mp_sat_avalon_city_ob_activity_scorpio_cs" );
}

// Namespace mp_sat_avalon_city_ob_activity_scorpio_cs
// Params 3, eflags: 0x4
// Checksum 0x8cde5b3f, Offset: 0x311
// Size: 0x268
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_scorpio_cs";
    s.activity_bundle = "sat_activitydef_scorpio_unlock";
    s.name = "scorpio_unlock_path_01";
    fe [[ f ]]( s, "scorpio_unlock_path_01", cf, ( 14741, -2880, 2033 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "scorpio_activity_link_01" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_scorpio_cs";
    fe [[ f ]]( s, "scorpio_unlock_path_01", cf, ( 14741, -2880, 2014 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Proximity_Join_Zone", undefined, "scorpio_activity_link_01", undefined, undefined, 800 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_scorpio_cs";
    fe [[ f ]]( s, "scorpio_unlock_path_01", cf, ( 14741, -2880, 2014 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Proximity_Abandon_Zone", undefined, "scorpio_activity_link_01", undefined, undefined, 1600 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_scorpio_cs";
    s.activity_bundle = "sat_activitydef_scorpio_unlock";
    s.name = "scorpio_unlock_path_02";
    fe [[ f ]]( s, "scorpio_unlock_path_02", cf, ( 59529, 25061, 939 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "scorpio_activity_link_02" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_scorpio_cs";
    fe [[ f ]]( s, "scorpio_unlock_path_02", cf, ( 59529, 25061, 920 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Proximity_Join_Zone", undefined, "scorpio_activity_link_02", undefined, undefined, 800 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_scorpio_cs";
    fe [[ f ]]( s, "scorpio_unlock_path_02", cf, ( 59529, 25061, 920 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Proximity_Abandon_Zone", undefined, "scorpio_activity_link_02", undefined, undefined, 1600 );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace mp_sat_avalon_city_ob_activity_scorpio_cs
// Params 0, eflags: 0x4
// Checksum 0x94bde88b, Offset: 0x581
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace mp_sat_avalon_city_ob_activity_scorpio_cs
// Params 0
// Checksum 0x8486965b, Offset: 0x58b
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "mp_sat_avalon_city_ob_activity_scorpio_cs" );
}

// Namespace mp_sat_avalon_city_ob_activity_scorpio_cs
// Params 0
// Checksum 0x50a39cfa, Offset: 0x5a1
// Size: 0x44
function function_4cd78e661617f3()
{
    activityinfostruct = {};
    activityinfostruct.mainfunction = &main;
    activityinfostruct.var_934f068483ae4ddb = &function_d4323822d7042e5a;
    activityinfostruct.metadatafunction = &function_d9dd7965c51c95d1;
    return activityinfostruct;
}

// Namespace mp_sat_avalon_city_ob_activity_scorpio_cs
// Params 4
// Checksum 0x4c80a9ca, Offset: 0x5ee
// Size: 0x71
function function_d4323822d7042e5a( var_4312b79c960726b6, fe, us, cf = "mp_sat_avalon_city_ob_activity_scorpio_cs" )
{
    switch ( var_4312b79c960726b6 )
    {
        case #"hash_9aad2031c3f457d7":
            function_4757c6367d8509bf( fe, us, cf );
            break;
        case #"hash_9aad2131c3f4596a":
            function_4757c7367d850bf2( fe, us, cf );
            break;
    }
}

// Namespace mp_sat_avalon_city_ob_activity_scorpio_cs
// Params 3
// Checksum 0x7f3b7f2b, Offset: 0x667
// Size: 0x2f
function function_4757c6367d8509bf( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
}

// Namespace mp_sat_avalon_city_ob_activity_scorpio_cs
// Params 3
// Checksum 0xe6322e91, Offset: 0x69e
// Size: 0x2f
function function_4757c7367d850bf2( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
}

// Namespace mp_sat_avalon_city_ob_activity_scorpio_cs
// Params 0
// Checksum 0xb7bd9803, Offset: 0x6d5
// Size: 0x143
function function_d9dd7965c51c95d1()
{
    activityinstances = [];
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_activitydef_scorpio_unlock";
    var_881289d7987bc770.cf = "mp_sat_avalon_city_ob_activity_scorpio_cs";
    var_881289d7987bc770.scriptstructorigin = ( 14741, -2880, 2033 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [];
    var_881289d7987bc770.var_31ce4477e3543d24 = [];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [];
    var_881289d7987bc770.locationradius = [];
    activityinstances[ "scorpio_unlock_path_01" ] = var_881289d7987bc770;
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_activitydef_scorpio_unlock";
    var_881289d7987bc770.cf = "mp_sat_avalon_city_ob_activity_scorpio_cs";
    var_881289d7987bc770.scriptstructorigin = ( 59529, 25061, 939 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [];
    var_881289d7987bc770.var_31ce4477e3543d24 = [];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [];
    var_881289d7987bc770.locationradius = [];
    activityinstances[ "scorpio_unlock_path_02" ] = var_881289d7987bc770;
    return activityinstances;
}

