// script_59a762600cfbf037  (hash_59a762600cfbf037.gscc) (size: 5477 Bytes / 0x1565 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x7f66e888 (2137450632)
// size ...... 5477 (0x1565)
// includes .. 4   (offset: 0x12d9)
// strings ... 32  (offset: 0x12f9)
// dev strs .. 0   (offset: 0x1565)
// exports ... 13  (offset: 0xdf5)
// cseg ...... 0x35b + 0xa9a (0xdf5)
// imports ... 26  (offset: 0xffd)
// animtree1 . 0   (offset: 0x1565)
// animtree2 . 0   (offset: 0x1565)
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace mp_sat_avalon_q1_ob_activity_flight_school_cs;

// Namespace mp_sat_avalon_q1_ob_activity_flight_school_cs
// Params 0, eflags: 0x5
// Checksum 0xcd6fc228, Offset: 0x379
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"mp_sat_avalon_q1_ob_activity_flight_school_cs", #"activity_common", &function_b39ecd3d51489472, undefined );
}

// Namespace mp_sat_avalon_q1_ob_activity_flight_school_cs
// Params 0, eflags: 0x4
// Checksum 0xce8d7288, Offset: 0x3a2
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace mp_sat_avalon_q1_ob_activity_flight_school_cs
// Params 0, eflags: 0x4
// Checksum 0x4bb6a164, Offset: 0x3b3
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace mp_sat_avalon_q1_ob_activity_flight_school_cs
// Params 2
// Checksum 0x89f34e4b, Offset: 0x3c4
// Size: 0x8c
function main( unused, unused2 )
{
    if ( utility::flag_exist( "mp_sat_avalon_q1_ob_activity_flight_school_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "mp_sat_avalon_q1_ob_activity_flight_school_cs" ) )
    {
        return;
    }
    
    activity_common::function_e1df676808c1d1e3( &function_4cd78e661617f3 );
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "mp_sat_avalon_q1_ob_activity_flight_school_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "mp_sat_avalon_q1_ob_activity_flight_school_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace mp_sat_avalon_q1_ob_activity_flight_school_cs
// Params 3, eflags: 0x4
// Checksum 0xc83415ab, Offset: 0x458
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "mp_sat_avalon_q1_ob_activity_flight_school_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "mp_sat_avalon_q1_ob_activity_flight_school_cs" );
}

// Namespace mp_sat_avalon_q1_ob_activity_flight_school_cs
// Params 3, eflags: 0x4
// Checksum 0xfcd9943d, Offset: 0x4d2
// Size: 0x279
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_flight_school_cs";
    s.activity_bundle = "sat_ob_activity_flight_school";
    s.name = "FLIGHT_SCHOOL_HIGHTOWN";
    fe [[ f ]]( s, "FLIGHT_SCHOOL_HIGHTOWN", cf, ( -16694.8, 5155.75, 4075 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_flight_school_cs";
    fe [[ f ]]( s, "FLIGHT_SCHOOL_HIGHTOWN", cf, ( -17071.7, 5423.98, 3907 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Awareness_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 2560 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_flight_school_cs";
    fe [[ f ]]( s, "FLIGHT_SCHOOL_HIGHTOWN", cf, ( -17026.6, 5436.53, 3907 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Proximity_Join_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 3096 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_flight_school_cs";
    fe [[ f ]]( s, "FLIGHT_SCHOOL_HIGHTOWN", cf, ( -17026.6, 5436.53, 3907 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "OB_Spacer_Spatial_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 3096 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_flight_school_cs";
    fe [[ f ]]( s, "FLIGHT_SCHOOL_HIGHTOWN", cf, ( -17026.6, 5436.53, 3907 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Proximity_Abandon_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 3096 );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace mp_sat_avalon_q1_ob_activity_flight_school_cs
// Params 0, eflags: 0x4
// Checksum 0x9e77fa06, Offset: 0x753
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace mp_sat_avalon_q1_ob_activity_flight_school_cs
// Params 0
// Checksum 0xa67c8e6, Offset: 0x75d
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "mp_sat_avalon_q1_ob_activity_flight_school_cs" );
}

// Namespace mp_sat_avalon_q1_ob_activity_flight_school_cs
// Params 0
// Checksum 0xc0f0cd68, Offset: 0x773
// Size: 0x66
function function_4cd78e661617f3()
{
    activityinfostruct = {};
    activityinfostruct.name = "REV_OB_FLIGHT_SCHOOL";
    activityinfostruct.scriptbundle = "sat_ob_activity_flight_school";
    activityinfostruct.mainfunction = &main;
    activityinfostruct.var_934f068483ae4ddb = &function_d4323822d7042e5a;
    activityinfostruct.metadatafunction = &function_d9dd7965c51c95d1;
    return activityinfostruct;
}

// Namespace mp_sat_avalon_q1_ob_activity_flight_school_cs
// Params 4
// Checksum 0xe6ae9070, Offset: 0x7e2
// Size: 0x57
function function_d4323822d7042e5a( var_4312b79c960726b6, fe, us, cf = "mp_sat_avalon_q1_ob_activity_flight_school_cs" )
{
    switch ( var_4312b79c960726b6 )
    {
        case #"hash_e7c05eb58097a62d":
            function_95446aadfda0a185( fe, us, cf );
            break;
    }
}

// Namespace mp_sat_avalon_q1_ob_activity_flight_school_cs
// Params 3
// Checksum 0x9680f6b2, Offset: 0x841
// Size: 0x4c3
function function_95446aadfda0a185( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_flight_school_cs";
    s.name = "s_portal";
    fe [[ f ]]( s, "FLIGHT_SCHOOL_HIGHTOWN", cf, ( -16424.1, 4973.44, 3987 ), ( 0, 140, 0 ), undefined, "FLIGHT_SCHOOL_HIGHTOWN_PORTAL", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_flight_school_cs";
    s.name = "s_player_teleport";
    fe [[ f ]]( s, "FLIGHT_SCHOOL_HIGHTOWN", cf, ( -16690.4, 5166.5, 4876 ), ( 0, 325, 0 ), "FLIGHT_SCHOOL_HIGHTOWN_PORTAL", undefined, "s_player_teleport", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_flight_school_cs";
    s.name = "s_path_start";
    fe [[ f ]]( s, "FLIGHT_SCHOOL_HIGHTOWN", cf, ( -14714.9, 3788, 4045.95 ), ( 0, 315, 0 ), "FLIGHT_SCHOOL_HIGHTOWN_PORTAL", "cspf_2_auto7063479757472785748", "s_path_start", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 415 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_flight_school_cs";
    s.name = "path_node_01";
    fe [[ f ]]( s, "FLIGHT_SCHOOL_HIGHTOWN", cf, ( -11564, 1372, 2180 ), ( 0, 90, 0 ), "cspf_2_auto7063479757472785748", "cspf_2_auto9027957599245291098", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_flight_school_cs";
    s.name = "path_node_02";
    fe [[ f ]]( s, "FLIGHT_SCHOOL_HIGHTOWN", cf, ( -9432, -3820, 496 ), ( 0, 60, 0 ), "cspf_2_auto9027957599245291098", "cspf_2_auto14303366757806971857", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_flight_school_cs";
    s.name = "path_node_03";
    fe [[ f ]]( s, "FLIGHT_SCHOOL_HIGHTOWN", cf, ( -9916, -8508, 372 ), ( 0, 50, 0 ), "cspf_2_auto14303366757806971857", "cspf_2_auto11324041981534597379", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_flight_school_cs";
    s.name = "path_node_04";
    fe [[ f ]]( s, "FLIGHT_SCHOOL_HIGHTOWN", cf, ( -14112, -10052, 564 ), ( 0, 50, 0 ), "cspf_2_auto11324041981534597379", "cspf_2_auto13260366706314988759", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_flight_school_cs";
    s.name = "path_node_05";
    fe [[ f ]]( s, "FLIGHT_SCHOOL_HIGHTOWN", cf, ( -19684, -7184, 460 ), ( 0, 80, 0 ), "cspf_2_auto13260366706314988759", "cspf_2_auto15093106348672169015", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_flight_school_cs";
    s.name = "path_node_06";
    fe [[ f ]]( s, "FLIGHT_SCHOOL_HIGHTOWN", cf, ( -24820.3, -5424, 440 ), ( 0, 80, 0 ), "cspf_2_auto15093106348672169015", "cspf_2_auto1743934247841797950", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_flight_school_cs";
    s.name = "path_node_07";
    fe [[ f ]]( s, "FLIGHT_SCHOOL_HIGHTOWN", cf, ( -29972.3, -5208, 216 ), ( 0, 65, 0 ), "cspf_2_auto1743934247841797950", undefined, "end", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_sat_avalon_q1_ob_activity_flight_school_cs
// Params 0
// Checksum 0x55a2882e, Offset: 0xd0c
// Size: 0xe8
function function_d9dd7965c51c95d1()
{
    activityinstances = [];
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_ob_activity_flight_school";
    var_881289d7987bc770.cf = "mp_sat_avalon_q1_ob_activity_flight_school_cs";
    var_881289d7987bc770.scriptstructorigin = ( -16694.8, 5155.75, 4075 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [ ( -17071.7, 5423.98, 3907 ) ];
    var_881289d7987bc770.var_31ce4477e3543d24 = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.locationradius = [ 1024 ];
    activityinstances[ "FLIGHT_SCHOOL_HIGHTOWN" ] = var_881289d7987bc770;
    return activityinstances;
}

