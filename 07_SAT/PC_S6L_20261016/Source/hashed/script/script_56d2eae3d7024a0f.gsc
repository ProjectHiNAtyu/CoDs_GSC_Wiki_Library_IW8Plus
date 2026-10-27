// script_56d2eae3d7024a0f  (hash_56d2eae3d7024a0f.gscc) (size: 5275 Bytes / 0x149b / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x31b06722 (833644322)
// size ...... 5275 (0x149b)
// includes .. 4   (offset: 0x1233)
// strings ... 30  (offset: 0x1253)
// dev strs .. 0   (offset: 0x149b)
// exports ... 13  (offset: 0xd4f)
// cseg ...... 0x329 + 0xa26 (0xd4f)
// imports ... 26  (offset: 0xf57)
// animtree1 . 0   (offset: 0x149b)
// animtree2 . 0   (offset: 0x149b)
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace mp_sat_avalon_q4_ob_activity_flight_school_cs;

// Namespace mp_sat_avalon_q4_ob_activity_flight_school_cs
// Params 0, eflags: 0x5
// Checksum 0x3b3841e0, Offset: 0x347
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"mp_sat_avalon_q4_ob_activity_flight_school_cs", #"activity_common", &function_b39ecd3d51489472, undefined );
}

// Namespace mp_sat_avalon_q4_ob_activity_flight_school_cs
// Params 0, eflags: 0x4
// Checksum 0x56a0b611, Offset: 0x370
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace mp_sat_avalon_q4_ob_activity_flight_school_cs
// Params 0, eflags: 0x4
// Checksum 0xd39b65fd, Offset: 0x381
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace mp_sat_avalon_q4_ob_activity_flight_school_cs
// Params 2
// Checksum 0xdc3de5fa, Offset: 0x392
// Size: 0x8c
function main( unused, unused2 )
{
    if ( utility::flag_exist( "mp_sat_avalon_q4_ob_activity_flight_school_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "mp_sat_avalon_q4_ob_activity_flight_school_cs" ) )
    {
        return;
    }
    
    activity_common::function_e1df676808c1d1e3( &function_4cd78e661617f3 );
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "mp_sat_avalon_q4_ob_activity_flight_school_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "mp_sat_avalon_q4_ob_activity_flight_school_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace mp_sat_avalon_q4_ob_activity_flight_school_cs
// Params 3, eflags: 0x4
// Checksum 0x5019d132, Offset: 0x426
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "mp_sat_avalon_q4_ob_activity_flight_school_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "mp_sat_avalon_q4_ob_activity_flight_school_cs" );
}

// Namespace mp_sat_avalon_q4_ob_activity_flight_school_cs
// Params 3, eflags: 0x4
// Checksum 0xad52f5be, Offset: 0x4a0
// Size: 0x279
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_flight_school_cs";
    s.activity_bundle = "sat_ob_activity_flight_school";
    s.name = "FLIGHT_SCHOOL_SHIPYARD";
    fe [[ f ]]( s, "FLIGHT_SCHOOL_SHIPYARD", cf, ( 24927.2, -52108.8, 291.88 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_flight_school_cs";
    fe [[ f ]]( s, "FLIGHT_SCHOOL_SHIPYARD", cf, ( 24744, -51944, 207.63 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Awareness_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 2560 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_flight_school_cs";
    fe [[ f ]]( s, "FLIGHT_SCHOOL_SHIPYARD", cf, ( 24744, -51944, 207.63 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Proximity_Join_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 1536 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_flight_school_cs";
    fe [[ f ]]( s, "FLIGHT_SCHOOL_SHIPYARD", cf, ( 24744, -51944, 207.63 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "OB_Spacer_Spatial_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 3096 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_flight_school_cs";
    fe [[ f ]]( s, "FLIGHT_SCHOOL_SHIPYARD", cf, ( 24744, -51944, 207.63 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Proximity_Abandon_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 3096 );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace mp_sat_avalon_q4_ob_activity_flight_school_cs
// Params 0, eflags: 0x4
// Checksum 0xcbb951b7, Offset: 0x721
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace mp_sat_avalon_q4_ob_activity_flight_school_cs
// Params 0
// Checksum 0x924a0c7f, Offset: 0x72b
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "mp_sat_avalon_q4_ob_activity_flight_school_cs" );
}

// Namespace mp_sat_avalon_q4_ob_activity_flight_school_cs
// Params 0
// Checksum 0x58dd09f1, Offset: 0x741
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

// Namespace mp_sat_avalon_q4_ob_activity_flight_school_cs
// Params 4
// Checksum 0xb3603bc1, Offset: 0x7b0
// Size: 0x57
function function_d4323822d7042e5a( var_4312b79c960726b6, fe, us, cf = "mp_sat_avalon_q4_ob_activity_flight_school_cs" )
{
    switch ( var_4312b79c960726b6 )
    {
        case #"hash_4dba4a53cd648d0f":
            function_3a3bf3effec0187( fe, us, cf );
            break;
    }
}

// Namespace mp_sat_avalon_q4_ob_activity_flight_school_cs
// Params 3
// Checksum 0x79d6286a, Offset: 0x80f
// Size: 0x44f
function function_3a3bf3effec0187( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_flight_school_cs";
    s.name = "s_portal";
    fe [[ f ]]( s, "FLIGHT_SCHOOL_SHIPYARD", cf, ( 24776, -51992, 295.29 ), ( 0, 310, 0 ), undefined, "FLIGHT_SCHOOL_SHIPYARD_PORTAL", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_flight_school_cs";
    s.name = "s_player_teleport";
    fe [[ f ]]( s, "FLIGHT_SCHOOL_SHIPYARD", cf, ( 24556.4, -52196, 2390.86 ), ( 0, 45, 0 ), "FLIGHT_SCHOOL_SHIPYARD_PORTAL", undefined, "s_player_teleport", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_flight_school_cs";
    s.name = "s_path_start";
    fe [[ f ]]( s, "FLIGHT_SCHOOL_SHIPYARD", cf, ( 25199.9, -51754.5, 2036.81 ), ( 0, 45, 0 ), "FLIGHT_SCHOOL_SHIPYARD_PORTAL", "cspf_2_auto7063479757472785748", "s_path_start", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 415 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_flight_school_cs";
    s.name = "path_node_01";
    fe [[ f ]]( s, "FLIGHT_SCHOOL_SHIPYARD", cf, ( 26894.8, -50194.5, 410.86 ), ( 0, 90, 0 ), "cspf_2_auto7063479757472785748", "cspf_2_auto9027957599245291098", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_flight_school_cs";
    s.name = "path_node_02";
    fe [[ f ]]( s, "FLIGHT_SCHOOL_SHIPYARD", cf, ( 28030.8, -49366.5, 162.86 ), ( 0, 40, 0 ), "cspf_2_auto9027957599245291098", "cspf_2_auto14303366757806971857", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_flight_school_cs";
    s.name = "path_node_03";
    fe [[ f ]]( s, "FLIGHT_SCHOOL_SHIPYARD", cf, ( 28602.8, -48882.5, 138.86 ), ( 0, 50, 0 ), "cspf_2_auto14303366757806971857", "cspf_2_auto11324041981534597379", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_flight_school_cs";
    s.name = "path_node_04";
    fe [[ f ]]( s, "FLIGHT_SCHOOL_SHIPYARD", cf, ( 29017.5, -48211.6, 160 ), ( 0, 40, 0 ), "cspf_2_auto11324041981534597379", "cspf_2_auto13260366706314988759", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_flight_school_cs";
    s.name = "path_node_05";
    fe [[ f ]]( s, "FLIGHT_SCHOOL_SHIPYARD", cf, ( 29740.1, -47314.7, 487.5 ), ( 0, 45, 0 ), "cspf_2_auto13260366706314988759", "cspf_2_auto15093106348672169015", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_flight_school_cs";
    s.name = "path_node_06";
    fe [[ f ]]( s, "FLIGHT_SCHOOL_SHIPYARD", cf, ( 29880.6, -45623.4, 643.5 ), ( 0, 80, 0 ), "cspf_2_auto15093106348672169015", undefined, "end", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_sat_avalon_q4_ob_activity_flight_school_cs
// Params 0
// Checksum 0x453c37ad, Offset: 0xc66
// Size: 0xe8
function function_d9dd7965c51c95d1()
{
    activityinstances = [];
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_ob_activity_flight_school";
    var_881289d7987bc770.cf = "mp_sat_avalon_q4_ob_activity_flight_school_cs";
    var_881289d7987bc770.scriptstructorigin = ( 24927.2, -52108.8, 291.88 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [ ( 24744, -51944, 207.63 ) ];
    var_881289d7987bc770.var_31ce4477e3543d24 = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.locationradius = [ 1024 ];
    activityinstances[ "FLIGHT_SCHOOL_SHIPYARD" ] = var_881289d7987bc770;
    return activityinstances;
}

