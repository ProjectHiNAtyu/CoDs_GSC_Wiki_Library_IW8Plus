// script_4c29d3ec55e8576f  (hash_4c29d3ec55e8576f.gscc) (size: 10898 Bytes / 0x2a92 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x5cdf1f0d (1558126349)
// size ...... 10898 (0x2a92)
// includes .. 4   (offset: 0x2516)
// strings ... 50  (offset: 0x2536)
// dev strs .. 0   (offset: 0x2a92)
// exports ... 15  (offset: 0x1fa2)
// cseg ...... 0x5c2 + 0x19e0 (0x1fa2)
// imports ... 28  (offset: 0x21fa)
// animtree1 . 0   (offset: 0x2a92)
// animtree2 . 0   (offset: 0x2a92)
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace mp_sat_avalon_q3_ob_activity_flight_school_cs;

// Namespace mp_sat_avalon_q3_ob_activity_flight_school_cs
// Params 0, eflags: 0x5
// Checksum 0x83ee4860, Offset: 0x5e0
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"mp_sat_avalon_q3_ob_activity_flight_school_cs", #"activity_common", &function_b39ecd3d51489472, undefined );
}

// Namespace mp_sat_avalon_q3_ob_activity_flight_school_cs
// Params 0, eflags: 0x4
// Checksum 0x7d5bc692, Offset: 0x609
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace mp_sat_avalon_q3_ob_activity_flight_school_cs
// Params 0, eflags: 0x4
// Checksum 0xf860157e, Offset: 0x61a
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace mp_sat_avalon_q3_ob_activity_flight_school_cs
// Params 2
// Checksum 0x42e43c41, Offset: 0x62b
// Size: 0x8c
function main( unused, unused2 )
{
    if ( utility::flag_exist( "mp_sat_avalon_q3_ob_activity_flight_school_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "mp_sat_avalon_q3_ob_activity_flight_school_cs" ) )
    {
        return;
    }
    
    activity_common::function_e1df676808c1d1e3( &function_4cd78e661617f3 );
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "mp_sat_avalon_q3_ob_activity_flight_school_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "mp_sat_avalon_q3_ob_activity_flight_school_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace mp_sat_avalon_q3_ob_activity_flight_school_cs
// Params 3, eflags: 0x4
// Checksum 0x7be2a1b1, Offset: 0x6bf
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "mp_sat_avalon_q3_ob_activity_flight_school_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "mp_sat_avalon_q3_ob_activity_flight_school_cs" );
}

// Namespace mp_sat_avalon_q3_ob_activity_flight_school_cs
// Params 3, eflags: 0x4
// Checksum 0xb33cd892, Offset: 0x739
// Size: 0x6d3
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_flight_school_cs";
    s.activity_bundle = "sat_ob_activity_flight_school";
    s.name = "FLIGHT_SCHOOL_COASTGUARD_01";
    fe [[ f ]]( s, "FLIGHT_SCHOOL_COASTGUARD_01", cf, ( -41326.3, -5029.98, 304 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_flight_school_cs";
    fe [[ f ]]( s, "FLIGHT_SCHOOL_COASTGUARD_01", cf, ( -41335.5, -5064.06, 128 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Awareness_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 2560 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_flight_school_cs";
    fe [[ f ]]( s, "FLIGHT_SCHOOL_COASTGUARD_01", cf, ( -41335.5, -5064.06, 128 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Proximity_Join_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 1536 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_flight_school_cs";
    fe [[ f ]]( s, "FLIGHT_SCHOOL_COASTGUARD_01", cf, ( -41335.5, -5064.06, 128 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "OB_Spacer_Spatial_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 3096 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_flight_school_cs";
    fe [[ f ]]( s, "FLIGHT_SCHOOL_COASTGUARD_01", cf, ( -41335.5, -5064.06, 128 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Proximity_Abandon_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 3096 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_flight_school_cs";
    s.activity_bundle = "sat_ob_activity_flight_school";
    s.name = "FLIGHT_SCHOOL_COASTGUARD_02";
    fe [[ f ]]( s, "FLIGHT_SCHOOL_COASTGUARD_02", cf, ( -41128.1, -12028, 598 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_flight_school_cs";
    fe [[ f ]]( s, "FLIGHT_SCHOOL_COASTGUARD_02", cf, ( -41144.1, -12023.9, 360 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Awareness_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 2560 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_flight_school_cs";
    fe [[ f ]]( s, "FLIGHT_SCHOOL_COASTGUARD_02", cf, ( -41144.1, -12023.9, 360 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Proximity_Join_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 1536 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_flight_school_cs";
    fe [[ f ]]( s, "FLIGHT_SCHOOL_COASTGUARD_02", cf, ( -41144.1, -12023.9, 360 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "OB_Spacer_Spatial_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 3096 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_flight_school_cs";
    fe [[ f ]]( s, "FLIGHT_SCHOOL_COASTGUARD_02", cf, ( -41144.1, -12023.9, 360 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Proximity_Abandon_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 3096 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_flight_school_cs";
    s.activity_bundle = "sat_ob_activity_flight_school";
    s.name = "FLIGHT_SCHOOL_PALACE_GROUNDS";
    fe [[ f ]]( s, "FLIGHT_SCHOOL_PALACE_GROUNDS", cf, ( -13480, -6928, 2296 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_flight_school_cs";
    fe [[ f ]]( s, "FLIGHT_SCHOOL_PALACE_GROUNDS", cf, ( -13512, -6936, 1888 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Awareness_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 3840 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_flight_school_cs";
    fe [[ f ]]( s, "FLIGHT_SCHOOL_PALACE_GROUNDS", cf, ( -13512, -6936, 1888 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Proximity_Join_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 3096 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_flight_school_cs";
    fe [[ f ]]( s, "FLIGHT_SCHOOL_PALACE_GROUNDS", cf, ( -13512, -6936, 1888 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "OB_Spacer_Spatial_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 3096 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_flight_school_cs";
    fe [[ f ]]( s, "FLIGHT_SCHOOL_PALACE_GROUNDS", cf, ( -13512, -6936, 1888 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Proximity_Abandon_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 3096 );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace mp_sat_avalon_q3_ob_activity_flight_school_cs
// Params 0, eflags: 0x4
// Checksum 0x5560880c, Offset: 0xe14
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace mp_sat_avalon_q3_ob_activity_flight_school_cs
// Params 0
// Checksum 0xb9b17cfc, Offset: 0xe1e
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "mp_sat_avalon_q3_ob_activity_flight_school_cs" );
}

// Namespace mp_sat_avalon_q3_ob_activity_flight_school_cs
// Params 0
// Checksum 0x73267972, Offset: 0xe34
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

// Namespace mp_sat_avalon_q3_ob_activity_flight_school_cs
// Params 4
// Checksum 0xf8f6804c, Offset: 0xea3
// Size: 0x8b
function function_d4323822d7042e5a( var_4312b79c960726b6, fe, us, cf = "mp_sat_avalon_q3_ob_activity_flight_school_cs" )
{
    switch ( var_4312b79c960726b6 )
    {
        case #"hash_6e65b932b7a27c98":
            function_98d9136e58757430( fe, us, cf );
            break;
        case #"hash_6e65bc32b7a28151":
            function_98d9166e58757ac9( fe, us, cf );
            break;
        case #"hash_7d6408e5347848e2":
            function_99c29fdc72e0b82a( fe, us, cf );
            break;
    }
}

// Namespace mp_sat_avalon_q3_ob_activity_flight_school_cs
// Params 3
// Checksum 0x8f81ee2e, Offset: 0xf36
// Size: 0x3d7
function function_98d9136e58757430( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_flight_school_cs";
    s.name = "s_portal";
    fe [[ f ]]( s, "FLIGHT_SCHOOL_COASTGUARD_01", cf, ( -40898, -5066, 776 ), ( 0, 185, 0 ), undefined, "FLIGHT_SCHOOL_COASTGUARD_01_PORTAL", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_flight_school_cs";
    s.name = "s_player_teleport";
    fe [[ f ]]( s, "FLIGHT_SCHOOL_COASTGUARD_01", cf, ( -40393.9, -5911.38, 1504 ), ( 0, 225, 0 ), "FLIGHT_SCHOOL_COASTGUARD_01_PORTAL", undefined, "s_player_teleport", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_flight_school_cs";
    s.name = "s_path_start";
    fe [[ f ]]( s, "FLIGHT_SCHOOL_COASTGUARD_01", cf, ( -41419.2, -7206.78, 1328 ), ( 0, 225, 0 ), "FLIGHT_SCHOOL_COASTGUARD_01_PORTAL", "cspf_4_auto7063479757472785748", "s_path_start", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_flight_school_cs";
    s.name = "path_node_01";
    fe [[ f ]]( s, "FLIGHT_SCHOOL_COASTGUARD_01", cf, ( -42372.2, -8332.32, 56 ), ( 0, 240, 0 ), "cspf_4_auto7063479757472785748", "cspf_4_auto9027957599245291098", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_flight_school_cs";
    s.name = "path_node_02";
    fe [[ f ]]( s, "FLIGHT_SCHOOL_COASTGUARD_01", cf, ( -42961.2, -9110.5, 162.86 ), ( 0, 190, 0 ), "cspf_4_auto9027957599245291098", "cspf_4_auto14303366757806971857", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_flight_school_cs";
    s.name = "path_node_03";
    fe [[ f ]]( s, "FLIGHT_SCHOOL_COASTGUARD_01", cf, ( -44269.2, -9226.5, 66.86 ), ( 0, 155, 0 ), "cspf_4_auto14303366757806971857", "cspf_4_auto11324041981534597379", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_flight_school_cs";
    s.name = "path_node_04";
    fe [[ f ]]( s, "FLIGHT_SCHOOL_COASTGUARD_01", cf, ( -46030.5, -8331.6, 120 ), ( 0, 160, 0 ), "cspf_4_auto11324041981534597379", "cspf_4_auto13260366706314988759", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_flight_school_cs";
    s.name = "path_node_05";
    fe [[ f ]]( s, "FLIGHT_SCHOOL_COASTGUARD_01", cf, ( -47275.3, -7963.09, 24.25 ), ( 0, 135, 0 ), "cspf_4_auto13260366706314988759", undefined, "end", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_sat_avalon_q3_ob_activity_flight_school_cs
// Params 3
// Checksum 0x9408d42d, Offset: 0x1315
// Size: 0x533
function function_98d9166e58757ac9( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_flight_school_cs";
    s.name = "s_portal";
    fe [[ f ]]( s, "FLIGHT_SCHOOL_COASTGUARD_02", cf, ( -41191.1, -11994.4, 822 ), ( 0, 143, 0 ), undefined, "FLIGHT_SCHOOL_COASTGUARD_02_PORTAL", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_flight_school_cs";
    s.name = "s_player_teleport";
    fe [[ f ]]( s, "FLIGHT_SCHOOL_COASTGUARD_02", cf, ( -41954.6, -11417.5, 1986 ), ( 0, 323, 0 ), "FLIGHT_SCHOOL_COASTGUARD_02_PORTAL", undefined, "s_player_teleport", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_flight_school_cs";
    s.name = "s_path_start";
    fe [[ f ]]( s, "FLIGHT_SCHOOL_COASTGUARD_02", cf, ( -40698.7, -12458.6, 1438 ), ( 0, 323, 0 ), "FLIGHT_SCHOOL_COASTGUARD_02_PORTAL", "cspf_5_auto7063479757472785748", "s_path_start", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 340 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_flight_school_cs";
    s.name = "path_node_01";
    fe [[ f ]]( s, "FLIGHT_SCHOOL_COASTGUARD_02", cf, ( -38865.8, -14541.1, 294 ), ( 0, 315, 0 ), "cspf_5_auto7063479757472785748", "cspf_5_auto9027957599245291098", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_flight_school_cs";
    s.name = "path_node_02";
    fe [[ f ]]( s, "FLIGHT_SCHOOL_COASTGUARD_02", cf, ( -38225.6, -15153.9, 184 ), ( 0, 190, 0 ), "cspf_5_auto9027957599245291098", "cspf_5_auto14303366757806971857", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_flight_school_cs";
    s.name = "path_node_03";
    fe [[ f ]]( s, "FLIGHT_SCHOOL_COASTGUARD_02", cf, ( -37306.7, -14996.1, 160 ), ( 0, 155, 0 ), "cspf_5_auto14303366757806971857", "cspf_5_auto11324041981534597379", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_flight_school_cs";
    s.name = "path_node_04";
    fe [[ f ]]( s, "FLIGHT_SCHOOL_COASTGUARD_02", cf, ( -35813, -15021.9, 160 ), ( 0, 160, 0 ), "cspf_5_auto11324041981534597379", "cspf_5_auto13260366706314988759", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_flight_school_cs";
    s.name = "path_node_05";
    fe [[ f ]]( s, "FLIGHT_SCHOOL_COASTGUARD_02", cf, ( -35215.8, -15942.9, 160 ), ( 0, 135, 0 ), "cspf_5_auto13260366706314988759", "cspf_5_auto3707688132793096714", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_flight_school_cs";
    s.name = "path_node_06";
    fe [[ f ]]( s, "FLIGHT_SCHOOL_COASTGUARD_02", cf, ( -35495.8, -17414.9, 160 ), ( 0, 240, 0 ), "cspf_5_auto3707688132793096714", "cspf_5_auto14896219473021936720", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_flight_school_cs";
    s.name = "path_node_07";
    fe [[ f ]]( s, "FLIGHT_SCHOOL_COASTGUARD_02", cf, ( -35887.8, -18422.9, 160 ), ( 0, 270, 0 ), "cspf_5_auto14896219473021936720", "cspf_5_auto3396117112400555324", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_flight_school_cs";
    s.name = "path_node_08";
    fe [[ f ]]( s, "FLIGHT_SCHOOL_COASTGUARD_02", cf, ( -35207.8, -20158.9, 17.99 ), ( 0, 300, 0 ), "cspf_5_auto3396117112400555324", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_sat_avalon_q3_ob_activity_flight_school_cs
// Params 3
// Checksum 0xf5618d32, Offset: 0x1850
// Size: 0x4c3
function function_99c29fdc72e0b82a( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_flight_school_cs";
    s.name = "s_portal";
    fe [[ f ]]( s, "FLIGHT_SCHOOL_PALACE_GROUNDS", cf, ( -13456, -6600, 2296 ), ( 0, 90, 0 ), undefined, "FLIGHT_SCHOOL_PALACE_GROUNDS_PORTAL", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_flight_school_cs";
    s.name = "s_player_teleport";
    fe [[ f ]]( s, "FLIGHT_SCHOOL_PALACE_GROUNDS", cf, ( -13456, -6432, 2984 ), ( 0, 90, 0 ), "FLIGHT_SCHOOL_PALACE_GROUNDS_PORTAL", undefined, "s_player_teleport", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_flight_school_cs";
    s.name = "s_path_start";
    fe [[ f ]]( s, "FLIGHT_SCHOOL_PALACE_GROUNDS", cf, ( -13456, -5528, 2520 ), ( 0, 90, 0 ), "FLIGHT_SCHOOL_PALACE_GROUNDS_PORTAL", "cspf_6_auto7063479757472785748", "s_path_start", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 375 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_flight_school_cs";
    s.name = "path_node_01";
    fe [[ f ]]( s, "FLIGHT_SCHOOL_PALACE_GROUNDS", cf, ( -13548, -4052, 2180 ), ( 0, 90, 0 ), "cspf_6_auto7063479757472785748", "cspf_6_auto9027957599245291098", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_flight_school_cs";
    s.name = "path_node_02";
    fe [[ f ]]( s, "FLIGHT_SCHOOL_PALACE_GROUNDS", cf, ( -15304, -2500, 1296 ), ( 0, 60, 0 ), "cspf_6_auto9027957599245291098", "cspf_6_auto14303366757806971857", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_flight_school_cs";
    s.name = "path_node_03";
    fe [[ f ]]( s, "FLIGHT_SCHOOL_PALACE_GROUNDS", cf, ( -15524.7, -1654.07, 1094.64 ), ( 0, 100, 0 ), "cspf_6_auto14303366757806971857", "cspf_6_auto11324041981534597379", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_flight_school_cs";
    s.name = "path_node_04";
    fe [[ f ]]( s, "FLIGHT_SCHOOL_PALACE_GROUNDS", cf, ( -15732, -292, 1084 ), ( 0, 95, 0 ), "cspf_6_auto11324041981534597379", "cspf_6_auto13260366706314988759", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_flight_school_cs";
    s.name = "path_node_05";
    fe [[ f ]]( s, "FLIGHT_SCHOOL_PALACE_GROUNDS", cf, ( -15844, 112, 1420 ), ( 0, 95, 0 ), "cspf_6_auto13260366706314988759", "cspf_6_auto15093106348672169015", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_flight_school_cs";
    s.name = "path_node_06";
    fe [[ f ]]( s, "FLIGHT_SCHOOL_PALACE_GROUNDS", cf, ( -15717.5, 1452.39, 1367 ), ( 0, 85, 0 ), "cspf_6_auto15093106348672169015", "cspf_6_auto1743934247841797950", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_flight_school_cs";
    s.name = "path_node_07";
    fe [[ f ]]( s, "FLIGHT_SCHOOL_PALACE_GROUNDS", cf, ( -15672.7, 1959.04, 1039 ), ( 0, 90, 0 ), "cspf_6_auto1743934247841797950", undefined, "end", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_sat_avalon_q3_ob_activity_flight_school_cs
// Params 0
// Checksum 0x1a528f83, Offset: 0x1d1b
// Size: 0x286
function function_d9dd7965c51c95d1()
{
    activityinstances = [];
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_ob_activity_flight_school";
    var_881289d7987bc770.cf = "mp_sat_avalon_q3_ob_activity_flight_school_cs";
    var_881289d7987bc770.scriptstructorigin = ( -41326.3, -5029.98, 304 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [ ( -41335.5, -5064.06, 128 ) ];
    var_881289d7987bc770.var_31ce4477e3543d24 = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.locationradius = [ 1024 ];
    activityinstances[ "FLIGHT_SCHOOL_COASTGUARD_01" ] = var_881289d7987bc770;
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_ob_activity_flight_school";
    var_881289d7987bc770.cf = "mp_sat_avalon_q3_ob_activity_flight_school_cs";
    var_881289d7987bc770.scriptstructorigin = ( -41128.1, -12028, 598 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [ ( -41144.1, -12023.9, 360 ) ];
    var_881289d7987bc770.var_31ce4477e3543d24 = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.locationradius = [ 1024 ];
    activityinstances[ "FLIGHT_SCHOOL_COASTGUARD_02" ] = var_881289d7987bc770;
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_ob_activity_flight_school";
    var_881289d7987bc770.cf = "mp_sat_avalon_q3_ob_activity_flight_school_cs";
    var_881289d7987bc770.scriptstructorigin = ( -13480, -6928, 2296 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [ ( -13512, -6936, 1888 ) ];
    var_881289d7987bc770.var_31ce4477e3543d24 = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.locationradius = [ 1024 ];
    activityinstances[ "FLIGHT_SCHOOL_PALACE_GROUNDS" ] = var_881289d7987bc770;
    return activityinstances;
}

