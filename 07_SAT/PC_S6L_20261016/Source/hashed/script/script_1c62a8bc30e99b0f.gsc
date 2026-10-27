// script_1c62a8bc30e99b0f  (hash_1c62a8bc30e99b0f.gscc) (size: 5677 Bytes / 0x162d / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xca0817d8 (3389528024)
// size ...... 5677 (0x162d)
// includes .. 4   (offset: 0x137d)
// strings ... 34  (offset: 0x139d)
// dev strs .. 0   (offset: 0x162d)
// exports ... 13  (offset: 0xe99)
// cseg ...... 0x38f + 0xb0a (0xe99)
// imports ... 26  (offset: 0x10a1)
// animtree1 . 0   (offset: 0x162d)
// animtree2 . 0   (offset: 0x162d)
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace mp_sat_avalon_q2_ob_activity_flight_school_cs;

// Namespace mp_sat_avalon_q2_ob_activity_flight_school_cs
// Params 0, eflags: 0x5
// Checksum 0x3a45fef0, Offset: 0x3ad
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"mp_sat_avalon_q2_ob_activity_flight_school_cs", #"activity_common", &function_b39ecd3d51489472, undefined );
}

// Namespace mp_sat_avalon_q2_ob_activity_flight_school_cs
// Params 0, eflags: 0x4
// Checksum 0x6a3a3c87, Offset: 0x3d6
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace mp_sat_avalon_q2_ob_activity_flight_school_cs
// Params 0, eflags: 0x4
// Checksum 0xef01ef6b, Offset: 0x3e7
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace mp_sat_avalon_q2_ob_activity_flight_school_cs
// Params 2
// Checksum 0x69e5255c, Offset: 0x3f8
// Size: 0x8c
function main( unused, unused2 )
{
    if ( utility::flag_exist( "mp_sat_avalon_q2_ob_activity_flight_school_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "mp_sat_avalon_q2_ob_activity_flight_school_cs" ) )
    {
        return;
    }
    
    activity_common::function_e1df676808c1d1e3( &function_4cd78e661617f3 );
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "mp_sat_avalon_q2_ob_activity_flight_school_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "mp_sat_avalon_q2_ob_activity_flight_school_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace mp_sat_avalon_q2_ob_activity_flight_school_cs
// Params 3, eflags: 0x4
// Checksum 0x6c835ba4, Offset: 0x48c
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "mp_sat_avalon_q2_ob_activity_flight_school_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "mp_sat_avalon_q2_ob_activity_flight_school_cs" );
}

// Namespace mp_sat_avalon_q2_ob_activity_flight_school_cs
// Params 3, eflags: 0x4
// Checksum 0x1db74820, Offset: 0x506
// Size: 0x279
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_flight_school_cs";
    s.activity_bundle = "sat_ob_activity_flight_school";
    s.name = "FLIGHT_SCHOOL_CLIFFTOWN";
    fe [[ f ]]( s, "FLIGHT_SCHOOL_CLIFFTOWN", cf, ( 39711.1, -2944, 2149.78 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_flight_school_cs";
    fe [[ f ]]( s, "FLIGHT_SCHOOL_CLIFFTOWN", cf, ( 39818, -2909.92, 1232 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Awareness_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 2560 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_flight_school_cs";
    fe [[ f ]]( s, "FLIGHT_SCHOOL_CLIFFTOWN", cf, ( 39863.1, -2897.37, 1232 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Proximity_Join_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 3096 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_flight_school_cs";
    fe [[ f ]]( s, "FLIGHT_SCHOOL_CLIFFTOWN", cf, ( 39863.1, -2897.37, 1232 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "OB_Spacer_Spatial_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 3096 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_flight_school_cs";
    fe [[ f ]]( s, "FLIGHT_SCHOOL_CLIFFTOWN", cf, ( 39863.1, -2897.37, 1232 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Proximity_Abandon_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 3096 );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace mp_sat_avalon_q2_ob_activity_flight_school_cs
// Params 0, eflags: 0x4
// Checksum 0x7e619111, Offset: 0x787
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace mp_sat_avalon_q2_ob_activity_flight_school_cs
// Params 0
// Checksum 0xaed086e9, Offset: 0x791
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "mp_sat_avalon_q2_ob_activity_flight_school_cs" );
}

// Namespace mp_sat_avalon_q2_ob_activity_flight_school_cs
// Params 0
// Checksum 0x64478367, Offset: 0x7a7
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

// Namespace mp_sat_avalon_q2_ob_activity_flight_school_cs
// Params 4
// Checksum 0xc47bafe4, Offset: 0x816
// Size: 0x57
function function_d4323822d7042e5a( var_4312b79c960726b6, fe, us, cf = "mp_sat_avalon_q2_ob_activity_flight_school_cs" )
{
    switch ( var_4312b79c960726b6 )
    {
        case #"hash_cf1ee6b98a5871f1":
            function_ab32864179a0c289( fe, us, cf );
            break;
    }
}

// Namespace mp_sat_avalon_q2_ob_activity_flight_school_cs
// Params 3
// Checksum 0x25e26680, Offset: 0x875
// Size: 0x533
function function_ab32864179a0c289( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_flight_school_cs";
    s.name = "s_portal";
    fe [[ f ]]( s, "FLIGHT_SCHOOL_CLIFFTOWN", cf, ( 39755.4, -2912.56, 2192 ), ( 0, 360, 0 ), undefined, "FLIGHT_SCHOOL_CLIFFTOWN_PORTAL", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_flight_school_cs";
    s.name = "s_player_teleport";
    fe [[ f ]]( s, "FLIGHT_SCHOOL_CLIFFTOWN", cf, ( 36281.6, -5005.5, 4584 ), ( 0, 90, 0 ), "FLIGHT_SCHOOL_CLIFFTOWN_PORTAL", undefined, "s_player_teleport", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_flight_school_cs";
    s.name = "s_path_start";
    fe [[ f ]]( s, "FLIGHT_SCHOOL_CLIFFTOWN", cf, ( 36269.1, -3292, 3545.95 ), ( 0, 90, 0 ), "FLIGHT_SCHOOL_CLIFFTOWN_PORTAL", "cspf_2_auto7063479757472785748", "s_path_start", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_flight_school_cs";
    s.name = "path_node_01";
    fe [[ f ]]( s, "FLIGHT_SCHOOL_CLIFFTOWN", cf, ( 36024, 2108, 2180 ), ( 0, 90, 0 ), "cspf_2_auto7063479757472785748", "cspf_2_auto9027957599245291098", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_flight_school_cs";
    s.name = "path_node_02";
    fe [[ f ]]( s, "FLIGHT_SCHOOL_CLIFFTOWN", cf, ( 36556, 4864, 672 ), ( 0, 60, 0 ), "cspf_2_auto9027957599245291098", "cspf_2_auto14303366757806971857", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_flight_school_cs";
    s.name = "path_node_03";
    fe [[ f ]]( s, "FLIGHT_SCHOOL_CLIFFTOWN", cf, ( 37344, 6724, 580 ), ( 0, 50, 0 ), "cspf_2_auto14303366757806971857", "cspf_2_auto11324041981534597379", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_flight_school_cs";
    s.name = "path_node_04";
    fe [[ f ]]( s, "FLIGHT_SCHOOL_CLIFFTOWN", cf, ( 38976, 8064, 152 ), ( 0, 50, 0 ), "cspf_2_auto11324041981534597379", "cspf_2_auto13260366706314988759", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_flight_school_cs";
    s.name = "path_node_05";
    fe [[ f ]]( s, "FLIGHT_SCHOOL_CLIFFTOWN", cf, ( 39760, 9144, 148 ), ( 0, 80, 0 ), "cspf_2_auto13260366706314988759", "cspf_2_auto15093106348672169015", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_flight_school_cs";
    s.name = "path_node_06";
    fe [[ f ]]( s, "FLIGHT_SCHOOL_CLIFFTOWN", cf, ( 39971.7, 10460, 124 ), ( 0, 80, 0 ), "cspf_2_auto15093106348672169015", "cspf_2_auto1743934247841797950", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_flight_school_cs";
    s.name = "path_node_07";
    fe [[ f ]]( s, "FLIGHT_SCHOOL_CLIFFTOWN", cf, ( 40735.7, 12704, 140 ), ( 0, 65, 0 ), "cspf_2_auto1743934247841797950", "cspf_2_auto7004006715785350921", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_flight_school_cs";
    s.name = "path_node_08";
    fe [[ f ]]( s, "FLIGHT_SCHOOL_CLIFFTOWN", cf, ( 41463.7, 13660, 303.16 ), ( 0, 230, 0 ), "cspf_2_auto7004006715785350921", undefined, "end", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_sat_avalon_q2_ob_activity_flight_school_cs
// Params 0
// Checksum 0x3b2d87ba, Offset: 0xdb0
// Size: 0xe8
function function_d9dd7965c51c95d1()
{
    activityinstances = [];
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_ob_activity_flight_school";
    var_881289d7987bc770.cf = "mp_sat_avalon_q2_ob_activity_flight_school_cs";
    var_881289d7987bc770.scriptstructorigin = ( 39711.1, -2944, 2149.78 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [ ( 39818, -2909.92, 1232 ) ];
    var_881289d7987bc770.var_31ce4477e3543d24 = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.locationradius = [ 1024 ];
    activityinstances[ "FLIGHT_SCHOOL_CLIFFTOWN" ] = var_881289d7987bc770;
    return activityinstances;
}

