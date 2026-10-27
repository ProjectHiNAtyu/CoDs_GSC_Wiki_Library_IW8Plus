// script_753a90fe0824fea2  (hash_753a90fe0824fea2.gscc) (size: 30422 Bytes / 0x76d6 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xf607f07 (257982215)
// size ...... 30422 (0x76d6)
// includes .. 4   (offset: 0x63f6)
// strings ... 118 (offset: 0x6416)
// dev strs .. 0   (offset: 0x76d6)
// exports ... 14  (offset: 0x5eca)
// cseg ...... 0x95e + 0x556c (0x5eca)
// imports ... 27  (offset: 0x60fa)
// animtree1 . 0   (offset: 0x76d6)
// animtree2 . 0   (offset: 0x76d6)
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace mp_sat_avalon_q1_ob_activity_locked_in_cs;

// Namespace mp_sat_avalon_q1_ob_activity_locked_in_cs
// Params 0, eflags: 0x5
// Checksum 0x91b62c49, Offset: 0x97c
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"mp_sat_avalon_q1_ob_activity_locked_in_cs", #"activity_common", &function_b39ecd3d51489472, undefined );
}

// Namespace mp_sat_avalon_q1_ob_activity_locked_in_cs
// Params 0, eflags: 0x4
// Checksum 0x3b787918, Offset: 0x9a5
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace mp_sat_avalon_q1_ob_activity_locked_in_cs
// Params 0, eflags: 0x4
// Checksum 0xbe43aaf4, Offset: 0x9b6
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace mp_sat_avalon_q1_ob_activity_locked_in_cs
// Params 2
// Checksum 0x47d8d076, Offset: 0x9c7
// Size: 0x8c
function main( unused, unused2 )
{
    if ( utility::flag_exist( "mp_sat_avalon_q1_ob_activity_locked_in_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "mp_sat_avalon_q1_ob_activity_locked_in_cs" ) )
    {
        return;
    }
    
    activity_common::function_e1df676808c1d1e3( &function_4cd78e661617f3 );
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "mp_sat_avalon_q1_ob_activity_locked_in_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "mp_sat_avalon_q1_ob_activity_locked_in_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace mp_sat_avalon_q1_ob_activity_locked_in_cs
// Params 3, eflags: 0x4
// Checksum 0x3dc11e3b, Offset: 0xa5b
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "mp_sat_avalon_q1_ob_activity_locked_in_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "mp_sat_avalon_q1_ob_activity_locked_in_cs" );
}

// Namespace mp_sat_avalon_q1_ob_activity_locked_in_cs
// Params 3, eflags: 0x4
// Checksum 0xde76b48, Offset: 0xad5
// Size: 0x22a
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_locked_in_cs";
    fe [[ f ]]( s, "LOCKED_IN_MUSEUM", cf, ( -13461.9, -7011.46, 1056 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Awareness_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 3000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_locked_in_cs";
    s.activity_bundle = "sat_activity_definition_locked_in";
    s.name = "LOCKED_IN_MUSEUM";
    fe [[ f ]]( s, "LOCKED_IN_MUSEUM", cf, ( -13461.9, -6979.46, 1056 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_locked_in_cs";
    fe [[ f ]]( s, "LOCKED_IN_CASINO", cf, ( -9428.19, 26416.5, 772.75 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Awareness_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 3000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_locked_in_cs";
    s.activity_bundle = "sat_activity_definition_locked_in";
    s.name = "LOCKED_IN_CASINO";
    fe [[ f ]]( s, "LOCKED_IN_CASINO", cf, ( -9428.19, 26448.5, 772.75 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace mp_sat_avalon_q1_ob_activity_locked_in_cs
// Params 0, eflags: 0x4
// Checksum 0x505c643b, Offset: 0xd07
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace mp_sat_avalon_q1_ob_activity_locked_in_cs
// Params 0
// Checksum 0xff92c376, Offset: 0xd11
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "mp_sat_avalon_q1_ob_activity_locked_in_cs" );
}

// Namespace mp_sat_avalon_q1_ob_activity_locked_in_cs
// Params 0
// Checksum 0x6b30c980, Offset: 0xd27
// Size: 0x66
function function_4cd78e661617f3()
{
    activityinfostruct = {};
    activityinfostruct.name = "REV_OB_LOCKED_IN";
    activityinfostruct.scriptbundle = "sat_activity_definition_locked_in";
    activityinfostruct.mainfunction = &main;
    activityinfostruct.var_934f068483ae4ddb = &function_d4323822d7042e5a;
    activityinfostruct.metadatafunction = &function_d9dd7965c51c95d1;
    return activityinfostruct;
}

// Namespace mp_sat_avalon_q1_ob_activity_locked_in_cs
// Params 4
// Checksum 0x3794fce7, Offset: 0xd96
// Size: 0x71
function function_d4323822d7042e5a( var_4312b79c960726b6, fe, us, cf = "mp_sat_avalon_q1_ob_activity_locked_in_cs" )
{
    switch ( var_4312b79c960726b6 )
    {
        case #"hash_412000eb9b66b808":
            function_d931e904245950b0( fe, us, cf );
            break;
        case #"hash_556e50776cbe8363":
            function_e6c9f21b0542d2db( fe, us, cf );
            break;
    }
}

// Namespace mp_sat_avalon_q1_ob_activity_locked_in_cs
// Params 3
// Checksum 0x57460bb, Offset: 0xe0f
// Size: 0x2737
function function_d931e904245950b0( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_locked_in_cs";
    s.height = 3000;
    s.name = "center_struct";
    fe [[ f ]]( s, "LOCKED_IN_MUSEUM", cf, ( -13437.9, -7011.46, 1056 ), ( 0, 0, 0 ), "LOCKED_IN_MUSEUM", undefined, undefined, "phase", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 3000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_locked_in_cs";
    s.groupid = "terminal";
    s.name = "terminal";
    s.var_4d433da9852c2079 = "300";
    s.var_bd0bcf1748163778 = "300";
    fe [[ f ]]( s, "LOCKED_IN_MUSEUM", cf, ( -13462, -7656.85, 1376 ), ( 0, 90, 0 ), undefined, undefined, "command_node_terminal", undefined, "phase", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_locked_in_cs";
    s.groupid = "terminal";
    s.var_297c4a455dbf7232 = "0,1";
    s.name = "defend_area";
    fe [[ f ]]( s, "LOCKED_IN_MUSEUM", cf, ( -13462, -7656.85, 1376 ), ( 0, 0, 0 ), undefined, undefined, "defend_area", "defend_dawg_spawn", "phase", ( 0, 0, 0 ), ( 0, 0, 0 ), 300 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_locked_in_cs";
    s.var_235de1e35f60da4f = "1";
    s.var_5accfd2db39d41b7 = "0.75";
    s.name = "firewall_spawn_root";
    fe [[ f ]]( s, "LOCKED_IN_MUSEUM", cf, ( -13437.9, -6979.46, 1056 ), ( 0, 0, 0 ), undefined, undefined, "firewall_spawn_root", "firewall_spawn_point", "phase", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_locked_in_cs";
    s.groupid = "firewall1";
    s.name = "firewall_spawn_point1";
    fe [[ f ]]( s, "LOCKED_IN_MUSEUM", cf, ( -13238, -7203.88, 1265.46 ), ( 0, 270, 90 ), undefined, undefined, "firewall_spawn", "firewall1", "firewall_spawn_point", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_locked_in_cs";
    s.groupid = "firewall1";
    s.name = "firewall1_drone1";
    fe [[ f ]]( s, "LOCKED_IN_MUSEUM", cf, ( -13246, -7138.12, 1265.46 ), ( 0, 180, 0 ), undefined, undefined, "drone_spawn", undefined, "firewall1", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_locked_in_cs";
    s.groupid = "firewall2";
    s.name = "firewall_spawn_point2";
    fe [[ f ]]( s, "LOCKED_IN_MUSEUM", cf, ( -13677.5, -6886, 1246.54 ), ( 0, 0, 90 ), undefined, undefined, "firewall_spawn", "firewall2", "firewall_spawn_point", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_locked_in_cs";
    s.groupid = "firewall2";
    s.name = "firewall2_drone1";
    fe [[ f ]]( s, "LOCKED_IN_MUSEUM", cf, ( -13758, -6894.5, 1246.54 ), ( 0, 270, 0 ), undefined, undefined, "drone_spawn", undefined, "firewall2", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_locked_in_cs";
    s.groupid = "firewall3";
    s.name = "firewall_spawn_point3";
    fe [[ f ]]( s, "LOCKED_IN_MUSEUM", cf, ( -13734.2, -6710, 1602.34 ), ( 0, 0, 90 ), undefined, undefined, "firewall_spawn", "firewall3", "firewall_spawn_point", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_locked_in_cs";
    s.groupid = "terminal";
    s.name = "ability_case_drop_point2";
    fe [[ f ]]( s, "LOCKED_IN_MUSEUM", cf, ( -13315, -7737.74, 1376 ), ( 0, 0, 0 ), undefined, undefined, "ability_case_drop_point", undefined, "phase", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_locked_in_cs";
    s.groupid = "firewall3";
    s.name = "firewall3_drone1";
    fe [[ f ]]( s, "LOCKED_IN_MUSEUM", cf, ( -13835, -6719.2, 1602.34 ), ( 0, 270, 0 ), undefined, undefined, "drone_spawn", undefined, "firewall3", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_locked_in_cs";
    s.groupid = "terminal";
    s.name = "ability_case_drop_point1";
    fe [[ f ]]( s, "LOCKED_IN_MUSEUM", cf, ( -13609, -7737.74, 1376 ), ( 0, 180, 0 ), undefined, undefined, "ability_case_drop_point", undefined, "phase", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_locked_in_cs";
    s.groupid = "firewall1";
    s.name = "firewall1_drone2";
    fe [[ f ]]( s, "LOCKED_IN_MUSEUM", cf, ( -13246, -7272.12, 1265.46 ), ( 0, 180, 0 ), undefined, undefined, "drone_spawn", undefined, "firewall1", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_locked_in_cs";
    s.groupid = "firewall2";
    s.name = "firewall2_drone2";
    fe [[ f ]]( s, "LOCKED_IN_MUSEUM", cf, ( -13591.5, -6894, 1246.54 ), ( 0, 270, 0 ), undefined, undefined, "drone_spawn", undefined, "firewall2", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_locked_in_cs";
    s.groupid = "firewall3";
    s.name = "firewall3_drone2";
    fe [[ f ]]( s, "LOCKED_IN_MUSEUM", cf, ( -13637.8, -6719, 1602.34 ), ( 0, 270, 0 ), undefined, undefined, "drone_spawn", undefined, "firewall3", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_locked_in_cs";
    s.groupid = "firewall4";
    s.name = "firewall_spawn_point4";
    fe [[ f ]]( s, "LOCKED_IN_MUSEUM", cf, ( -13772.6, -7318, 1504.86 ), ( 0, 180, 90 ), undefined, undefined, "firewall_spawn", "firewall4", "firewall_spawn_point", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_locked_in_cs";
    s.groupid = "firewall4";
    s.name = "firewall4_drone1";
    fe [[ f ]]( s, "LOCKED_IN_MUSEUM", cf, ( -13691.4, -7309, 1504.86 ), ( 0, 90, 0 ), undefined, undefined, "drone_spawn", undefined, "firewall4", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_locked_in_cs";
    s.groupid = "firewall4";
    s.name = "firewall4_drone2";
    fe [[ f ]]( s, "LOCKED_IN_MUSEUM", cf, ( -13848.4, -7309, 1504.86 ), ( 0, 90, 0 ), undefined, undefined, "drone_spawn", undefined, "firewall4", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_locked_in_cs";
    s.groupid = "firewall5";
    s.name = "firewall_spawn_point5";
    fe [[ f ]]( s, "LOCKED_IN_MUSEUM", cf, ( -13633.1, -7478, 1229.54 ), ( 0, 0, 90 ), undefined, undefined, "firewall_spawn", "firewall5", "firewall_spawn_point", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_locked_in_cs";
    s.groupid = "firewall5";
    s.name = "firewall5_drone1";
    fe [[ f ]]( s, "LOCKED_IN_MUSEUM", cf, ( -13633.1, -7486, 1177.54 ), ( 0, 270, 0 ), undefined, undefined, "drone_spawn", undefined, "firewall5", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_locked_in_cs";
    s.groupid = "firewall5";
    s.name = "firewall5_drone2";
    fe [[ f ]]( s, "LOCKED_IN_MUSEUM", cf, ( -13633.1, -7478, 1280.54 ), ( 0, 270, 0 ), undefined, undefined, "drone_spawn", undefined, "firewall5", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_locked_in_cs";
    s.groupid = "firewall6";
    s.name = "firewall_spawn_point6";
    fe [[ f ]]( s, "LOCKED_IN_MUSEUM", cf, ( -14998, -7291.86, 1235.35 ), ( 0, 90, 90 ), undefined, undefined, "firewall_spawn", "firewall6", "firewall_spawn_point", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_locked_in_cs";
    s.groupid = "firewall6";
    s.name = "firewall6_drone1";
    fe [[ f ]]( s, "LOCKED_IN_MUSEUM", cf, ( -14989, -7368.14, 1235.35 ), ( 0, 0, 0 ), undefined, undefined, "drone_spawn", undefined, "firewall6", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_locked_in_cs";
    s.groupid = "firewall6";
    s.name = "firewall6_drone2";
    fe [[ f ]]( s, "LOCKED_IN_MUSEUM", cf, ( -14989, -7216.14, 1235.35 ), ( 0, 0, 0 ), undefined, undefined, "drone_spawn", undefined, "firewall6", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_locked_in_cs";
    s.groupid = "firewall8";
    s.name = "firewall8_drone1";
    fe [[ f ]]( s, "LOCKED_IN_MUSEUM", cf, ( -12717, -7419.26, 1252.95 ), ( 0, 0, 0 ), undefined, undefined, "drone_spawn", undefined, "firewall8", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_locked_in_cs";
    s.groupid = "firewall7";
    s.name = "firewall7_drone1";
    fe [[ f ]]( s, "LOCKED_IN_MUSEUM", cf, ( -11935, -7255.44, 1254.45 ), ( 0, 180, 0 ), undefined, undefined, "drone_spawn", undefined, "firewall7", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_locked_in_cs";
    s.groupid = "firewall7";
    s.name = "firewall_spawn_point7";
    fe [[ f ]]( s, "LOCKED_IN_MUSEUM", cf, ( -11926, -7328.44, 1254.45 ), ( 0, 270, 90 ), undefined, undefined, "firewall_spawn", "firewall7", "firewall_spawn_point", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_locked_in_cs";
    s.groupid = "firewall8";
    s.name = "firewall_spawn_point8";
    fe [[ f ]]( s, "LOCKED_IN_MUSEUM", cf, ( -12726, -7342.26, 1252.95 ), ( 0, 90, 90 ), undefined, undefined, "firewall_spawn", "firewall8", "firewall_spawn_point", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_locked_in_cs";
    s.groupid = "firewall7";
    s.name = "firewall7_drone2";
    fe [[ f ]]( s, "LOCKED_IN_MUSEUM", cf, ( -11935, -7402.44, 1254.45 ), ( 0, 180, 0 ), undefined, undefined, "drone_spawn", undefined, "firewall7", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_locked_in_cs";
    s.groupid = "firewall8";
    s.name = "firewall8_drone2";
    fe [[ f ]]( s, "LOCKED_IN_MUSEUM", cf, ( -12718, -7267.26, 1252.95 ), ( 0, 0, 0 ), undefined, undefined, "drone_spawn", undefined, "firewall8", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_locked_in_cs";
    s.groupid = "firewall9";
    s.name = "firewall_spawn_point9";
    fe [[ f ]]( s, "LOCKED_IN_MUSEUM", cf, ( -13463.7, -7926, 1609.26 ), ( 0, 180, 90 ), undefined, undefined, "firewall_spawn", "firewall9", "firewall_spawn_point", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_locked_in_cs";
    s.groupid = "firewall9";
    s.name = "firewall9_drone1";
    fe [[ f ]]( s, "LOCKED_IN_MUSEUM", cf, ( -13389.7, -7917, 1609.26 ), ( 0, 90, 0 ), undefined, undefined, "drone_spawn", undefined, "firewall9", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_locked_in_cs";
    s.groupid = "firewall9";
    s.name = "firewall9_drone2";
    fe [[ f ]]( s, "LOCKED_IN_MUSEUM", cf, ( -13506.7, -7917, 1609.26 ), ( 0, 90, 0 ), undefined, undefined, "drone_spawn", undefined, "firewall9", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_locked_in_cs";
    s.groupid = "firewall_10";
    s.name = "firewall_spawn_point10";
    fe [[ f ]]( s, "LOCKED_IN_MUSEUM", cf, ( -12918, -7292.58, 1564.88 ), ( 0, 90, 90 ), undefined, undefined, "firewall_spawn", "firewall10", "firewall_spawn_point", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_locked_in_cs";
    s.groupid = "firewall_10";
    s.name = "firewall10_drone1";
    fe [[ f ]]( s, "LOCKED_IN_MUSEUM", cf, ( -12909, -7364.58, 1564.88 ), ( 0, 0, 0 ), undefined, undefined, "drone_spawn", undefined, "firewall10", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_locked_in_cs";
    s.groupid = "firewall_10";
    s.name = "firewall10_drone2";
    fe [[ f ]]( s, "LOCKED_IN_MUSEUM", cf, ( -12909, -7222.58, 1564.88 ), ( 0, 0, 0 ), undefined, undefined, "drone_spawn", undefined, "firewall10", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_locked_in_cs";
    s.groupid = "firewall_11";
    s.name = "firewall_spawn_point11";
    fe [[ f ]]( s, "LOCKED_IN_MUSEUM", cf, ( -12125.6, -7190, 1559.31 ), ( 0, 0, 90 ), undefined, undefined, "firewall_spawn", "firewall11", "firewall_spawn_point", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_locked_in_cs";
    s.groupid = "firewall_11";
    s.name = "firewall11_drone1";
    fe [[ f ]]( s, "LOCKED_IN_MUSEUM", cf, ( -12188.6, -7199, 1559.31 ), ( 0, 270, 0 ), undefined, undefined, "drone_spawn", undefined, "firewall11", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_locked_in_cs";
    s.groupid = "firewall_11";
    s.name = "firewall11_drone2";
    fe [[ f ]]( s, "LOCKED_IN_MUSEUM", cf, ( -12062.6, -7199, 1559.31 ), ( 0, 270, 0 ), undefined, undefined, "drone_spawn", undefined, "firewall11", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_locked_in_cs";
    s.groupid = "firewall_12";
    s.name = "firewall_spawn_point12";
    fe [[ f ]]( s, "LOCKED_IN_MUSEUM", cf, ( -14998, -7725.43, 1559.33 ), ( 0, 90, 90 ), undefined, undefined, "firewall_spawn", "firewall12", "firewall_spawn_point", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_locked_in_cs";
    s.groupid = "firewall_12";
    s.name = "firewall12_drone1";
    fe [[ f ]]( s, "LOCKED_IN_MUSEUM", cf, ( -14960, -7789.57, 1559.33 ), ( 0, 90, 0 ), undefined, undefined, "drone_spawn", undefined, "firewall12", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_locked_in_cs";
    s.groupid = "firewall_12";
    s.name = "firewall12_drone2";
    fe [[ f ]]( s, "LOCKED_IN_MUSEUM", cf, ( -14986, -7657.43, 1559.33 ), ( 0, 0, 0 ), undefined, undefined, "drone_spawn", undefined, "firewall12", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_locked_in_cs";
    s.groupid = "participate_phase_reinforcement";
    s.ishelistruct = 1;
    s.script_accel = "350";
    fe [[ f ]]( s, "LOCKED_IN_MUSEUM", cf, ( -13620.5, -5814.64, 1576.69 ), ( 0, 179.81, 0 ), "LOCKED_IN_MUSEUM_PARTICIPATE", "LOCKED_IN_MUSEUM_VTOL_2", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_locked_in_cs";
    s.groupid = "participate_phase_reinforcement";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "LOCKED_IN_MUSEUM", cf, ( -21924.9, -20765.9, 9565.25 ), ( 359.47, 96.61, 0.49 ), "LOCKED_IN_MUSEUM_VTOL_3", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_locked_in_cs";
    s.groupid = "participate_phase_reinforcement";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "LOCKED_IN_MUSEUM", cf, ( -3269.87, -15834.9, 7995.02 ), ( 0, 148.23, 0 ), undefined, "LOCKED_IN_MUSEUM_VTOL_1", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150, 1 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_locked_in_cs";
    s.groupid = "participate_phase_reinforcement";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "LOCKED_IN_MUSEUM", cf, ( -20096.2, -8171.79, 5895.27 ), ( 359.47, 96.61, 0.49 ), "LOCKED_IN_MUSEUM_VTOL_2", "LOCKED_IN_MUSEUM_VTOL_3", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_locked_in_cs";
    s.groupid = "participate_phase_reinforcement";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "LOCKED_IN_MUSEUM", cf, ( -8156.79, -11616.7, 6917.52 ), ( 0, 61.35, 0 ), "LOCKED_IN_MUSEUM_VTOL_1", "LOCKED_IN_MUSEUM_PARTICIPATE", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_locked_in_cs";
    s.groupid = "warning_blocks";
    s.name = "root";
    fe [[ f ]]( s, "LOCKED_IN_MUSEUM", cf, ( -13438.2, -7043.06, 1056 ), ( 0, 0, 0 ), undefined, undefined, "warning_blocks_root", "blocks", "phase", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_locked_in_cs";
    s.groupid = "warning_blocks";
    s.name = "window";
    fe [[ f ]]( s, "LOCKED_IN_MUSEUM", cf, ( -11916.7, -7493.41, 1368 ), ( 0, 0, 0 ), undefined, undefined, "block_w", undefined, "blocks", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_locked_in_cs";
    s.groupid = "warning_blocks";
    s.name = "window";
    fe [[ f ]]( s, "LOCKED_IN_MUSEUM", cf, ( -15006.8, -7461.96, 1368 ), ( 0, 180, 0 ), undefined, undefined, "block_w", undefined, "blocks", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_locked_in_cs";
    s.groupid = "warning_blocks";
    s.name = "door";
    fe [[ f ]]( s, "LOCKED_IN_MUSEUM", cf, ( -13238.6, -6877.82, 1248 ), ( 0, 0, 0 ), undefined, undefined, "block_d", undefined, "blocks", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_locked_in_cs";
    s.groupid = "warning_blocks";
    s.name = "door";
    fe [[ f ]]( s, "LOCKED_IN_MUSEUM", cf, ( -13238.6, -6877.82, 1056.45 ), ( 0, 0, 0 ), undefined, undefined, "block_d", undefined, "blocks", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_locked_in_cs";
    s.groupid = "warning_blocks";
    s.name = "door";
    fe [[ f ]]( s, "LOCKED_IN_MUSEUM", cf, ( -13462, -6706.73, 1347.3 ), ( 0, 90, 0 ), undefined, undefined, "block_d", undefined, "blocks", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_locked_in_cs";
    s.name = "reward";
    fe [[ f ]]( s, "LOCKED_IN_MUSEUM", cf, ( -13464.1, -7460.78, 1376 ), ( 0, 0, 0 ), undefined, undefined, "reward", undefined, "phase", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_locked_in_cs";
    s.groupid = "firewall_13";
    s.name = "firewall_spawn_point13";
    fe [[ f ]]( s, "LOCKED_IN_MUSEUM", cf, ( -14006, -7293.97, 1647.82 ), ( 0, 270, 90 ), undefined, undefined, "firewall_spawn", "firewall13", "firewall_spawn_point", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_locked_in_cs";
    s.groupid = "firewall_13";
    s.name = "firewall13_drone1";
    fe [[ f ]]( s, "LOCKED_IN_MUSEUM", cf, ( -14015, -7201.97, 1647.82 ), ( 0, 180, 0 ), undefined, undefined, "drone_spawn", undefined, "firewall13", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_locked_in_cs";
    s.groupid = "firewall_13";
    s.name = "firewall13_drone2";
    fe [[ f ]]( s, "LOCKED_IN_MUSEUM", cf, ( -14016, -7387.97, 1647.82 ), ( 0, 180, 0 ), undefined, undefined, "drone_spawn", undefined, "firewall13", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_locked_in_cs";
    s.groupid = "firewall_14";
    s.name = "firewall_spawn_point14";
    fe [[ f ]]( s, "LOCKED_IN_MUSEUM", cf, ( -13942, -7442.85, 1266.22 ), ( 0, 270, 90 ), undefined, undefined, "firewall_spawn", "firewall14", "firewall_spawn_point", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_locked_in_cs";
    s.groupid = "firewall_14";
    s.name = "firewall14_drone1";
    fe [[ f ]]( s, "LOCKED_IN_MUSEUM", cf, ( -13953, -7442.85, 1313.22 ), ( 0, 180, 0 ), undefined, undefined, "drone_spawn", undefined, "firewall14", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_locked_in_cs";
    s.groupid = "firewall_14";
    s.name = "firewall14_drone2";
    fe [[ f ]]( s, "LOCKED_IN_MUSEUM", cf, ( -13951, -7442.85, 1215.22 ), ( 0, 180, 0 ), undefined, undefined, "drone_spawn", undefined, "firewall14", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_locked_in_cs";
    s.groupid = "firewall_15";
    s.name = "firewall_spawn_point15";
    fe [[ f ]]( s, "LOCKED_IN_MUSEUM", cf, ( -13461.8, -7158, 1688.88 ), ( 0, 180, 90 ), undefined, undefined, "firewall_spawn", "firewall15", "firewall_spawn_point", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_locked_in_cs";
    s.groupid = "firewall_15";
    s.name = "firewall15_drone1";
    fe [[ f ]]( s, "LOCKED_IN_MUSEUM", cf, ( -13391.8, -7149, 1688.88 ), ( 0, 90, 0 ), undefined, undefined, "drone_spawn", undefined, "firewall15", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_locked_in_cs";
    s.groupid = "firewall_15";
    s.name = "firewall15_drone2";
    fe [[ f ]]( s, "LOCKED_IN_MUSEUM", cf, ( -13530.8, -7149, 1688.88 ), ( 0, 90, 0 ), undefined, undefined, "drone_spawn", undefined, "firewall15", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_locked_in_cs";
    s.groupid = "firewall_16";
    s.name = "firewall_spawn_point16";
    fe [[ f ]]( s, "LOCKED_IN_MUSEUM", cf, ( -13334, -7274.38, 1649.59 ), ( 0, 270, 90 ), undefined, undefined, "firewall_spawn", "firewall16", "firewall_spawn_point", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_locked_in_cs";
    s.groupid = "firewall_16";
    s.name = "firewall16_drone1";
    fe [[ f ]]( s, "LOCKED_IN_MUSEUM", cf, ( -13343, -7205.38, 1649.59 ), ( 0, 180, 0 ), undefined, undefined, "drone_spawn", undefined, "firewall16", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_locked_in_cs";
    s.groupid = "firewall_16";
    s.name = "firewall16_drone2";
    fe [[ f ]]( s, "LOCKED_IN_MUSEUM", cf, ( -13343, -7339.38, 1649.59 ), ( 0, 180, 0 ), undefined, undefined, "drone_spawn", undefined, "firewall16", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_locked_in_cs";
    s.groupid = "warning_blocks";
    s.name = "window";
    fe [[ f ]]( s, "LOCKED_IN_MUSEUM", cf, ( -13343.8, -7931.51, 1848.5 ), ( 0, 270, 0 ), undefined, undefined, "block_w", undefined, "blocks", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_locked_in_cs";
    s.groupid = "warning_blocks";
    s.name = "window";
    fe [[ f ]]( s, "LOCKED_IN_MUSEUM", cf, ( -13582.2, -7931.58, 1848.5 ), ( 0, 270, 0 ), undefined, undefined, "block_w", undefined, "blocks", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_locked_in_cs";
    s.groupid = "warning_blocks";
    s.name = "door";
    fe [[ f ]]( s, "LOCKED_IN_MUSEUM", cf, ( -13286.6, -6912.82, 1472 ), ( 0, 0, 0 ), undefined, undefined, "block_d", undefined, "blocks", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_locked_in_cs";
    s.groupid = "warning_blocks";
    s.name = "door";
    fe [[ f ]]( s, "LOCKED_IN_MUSEUM", cf, ( -13462, -6691.73, 1056 ), ( 0, 90, 0 ), undefined, undefined, "block_d", undefined, "blocks", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_locked_in_cs";
    s.groupid = "warning_blocks";
    s.name = "window";
    fe [[ f ]]( s, "LOCKED_IN_MUSEUM", cf, ( -11916.7, -7493.41, 1048 ), ( 0, 0, 0 ), undefined, undefined, "block_w", undefined, "blocks", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_locked_in_cs";
    s.groupid = "warning_blocks";
    s.name = "window";
    fe [[ f ]]( s, "LOCKED_IN_MUSEUM", cf, ( -12262, -7183, 1048 ), ( 0, 90, 0 ), undefined, undefined, "block_w", undefined, "blocks", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_locked_in_cs";
    s.groupid = "warning_blocks";
    s.name = "window";
    fe [[ f ]]( s, "LOCKED_IN_MUSEUM", cf, ( -15004, -7462, 1048 ), ( 0, 180, 0 ), undefined, undefined, "block_w", undefined, "blocks", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_locked_in_cs";
    s.groupid = "warning_blocks";
    s.name = "window";
    fe [[ f ]]( s, "LOCKED_IN_MUSEUM", cf, ( -14662, -7184, 1048 ), ( 0, 90, 0 ), undefined, undefined, "block_w", undefined, "blocks", ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_sat_avalon_q1_ob_activity_locked_in_cs
// Params 3
// Checksum 0x54b1788c, Offset: 0x354e
// Size: 0x27bc
function function_e6c9f21b0542d2db( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_locked_in_cs";
    s.height = 3000;
    s.name = "center_struct";
    fe [[ f ]]( s, "LOCKED_IN_CASINO", cf, ( -9404.19, 26416.5, 772.75 ), ( 0, 0, 0 ), "LOCKED_IN_CASINO", undefined, undefined, "phase", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 3000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_locked_in_cs";
    s.groupid = "terminal";
    s.name = "terminal";
    s.var_4d433da9852c2079 = "300";
    s.var_bd0bcf1748163778 = "300";
    fe [[ f ]]( s, "LOCKED_IN_CASINO", cf, ( -10191.5, 27177.9, 768 ), ( 0, 220, 0 ), undefined, undefined, "command_node_terminal", undefined, "phase", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_locked_in_cs";
    s.groupid = "terminal";
    s.var_297c4a455dbf7232 = "0,1";
    s.name = "defend_area";
    fe [[ f ]]( s, "LOCKED_IN_CASINO", cf, ( -10191.5, 27177.9, 768 ), ( 0, 0, 0 ), undefined, undefined, "defend_area", "defend_dawg_spawn", "phase", ( 0, 0, 0 ), ( 0, 0, 0 ), 300 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_locked_in_cs";
    s.var_235de1e35f60da4f = "1";
    s.var_5accfd2db39d41b7 = "0.75";
    s.name = "firewall_spawn_root";
    fe [[ f ]]( s, "LOCKED_IN_CASINO", cf, ( -9404.19, 26448.5, 772.75 ), ( 0, 0, 0 ), undefined, undefined, "firewall_spawn_root", "firewall_spawn_point", "phase", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_locked_in_cs";
    s.groupid = "firewall1";
    s.name = "firewall_spawn_point1";
    fe [[ f ]]( s, "LOCKED_IN_CASINO", cf, ( -7566.81, 24473.4, 886.73 ), ( 0, 220, 90 ), undefined, undefined, "firewall_spawn", "firewall1", "firewall_spawn_point", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_locked_in_cs";
    s.groupid = "firewall1";
    s.name = "firewall1_drone1";
    fe [[ f ]]( s, "LOCKED_IN_CASINO", cf, ( -7531.81, 24533.4, 886.73 ), ( 0, 130, 0 ), undefined, undefined, "drone_spawn", undefined, "firewall1", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_locked_in_cs";
    s.groupid = "firewall2";
    s.name = "firewall_spawn_point2";
    fe [[ f ]]( s, "LOCKED_IN_CASINO", cf, ( -7270.5, 25360, 886.5 ), ( 0, 40, 90 ), undefined, undefined, "firewall_spawn", "firewall2", "firewall_spawn_point", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_locked_in_cs";
    s.groupid = "firewall2";
    s.name = "firewall2_drone1";
    fe [[ f ]]( s, "LOCKED_IN_CASINO", cf, ( -7308.5, 25297, 886.5 ), ( 0, 310, 0 ), undefined, undefined, "drone_spawn", undefined, "firewall2", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_locked_in_cs";
    s.groupid = "firewall3";
    s.name = "firewall_spawn_point3";
    fe [[ f ]]( s, "LOCKED_IN_CASINO", cf, ( -7383.02, 24349.2, 1088.68 ), ( 0, 310, 90 ), undefined, undefined, "firewall_spawn", "firewall3", "firewall_spawn_point", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_locked_in_cs";
    s.groupid = "terminal";
    s.name = "ability_case_drop_point2";
    fe [[ f ]]( s, "LOCKED_IN_CASINO", cf, ( -10145.7, 27165.2, 802 ), ( 0, 310, 0 ), undefined, undefined, "ability_case_drop_point", undefined, "phase", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_locked_in_cs";
    s.groupid = "firewall3";
    s.name = "firewall3_drone1";
    fe [[ f ]]( s, "LOCKED_IN_CASINO", cf, ( -7439.52, 24394.7, 1088.68 ), ( 0, 220, 0 ), undefined, undefined, "drone_spawn", undefined, "firewall3", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_locked_in_cs";
    s.groupid = "terminal";
    s.name = "ability_case_drop_point1";
    fe [[ f ]]( s, "LOCKED_IN_CASINO", cf, ( -10195.8, 27225, 802 ), ( 0, 130, 0 ), undefined, undefined, "ability_case_drop_point", undefined, "phase", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_locked_in_cs";
    s.groupid = "firewall1";
    s.name = "firewall1_drone2";
    fe [[ f ]]( s, "LOCKED_IN_CASINO", cf, ( -7623.81, 24448.4, 886.73 ), ( 0, 130, 0 ), undefined, undefined, "drone_spawn", undefined, "firewall1", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_locked_in_cs";
    s.groupid = "firewall2";
    s.name = "firewall2_drone2";
    fe [[ f ]]( s, "LOCKED_IN_CASINO", cf, ( -7203, 25386.5, 886.5 ), ( 0, 310, 0 ), undefined, undefined, "drone_spawn", undefined, "firewall2", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_locked_in_cs";
    s.groupid = "firewall3";
    s.name = "firewall3_drone2";
    fe [[ f ]]( s, "LOCKED_IN_CASINO", cf, ( -7347.02, 24289.2, 1088.68 ), ( 0, 220, 0 ), undefined, undefined, "drone_spawn", undefined, "firewall3", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_locked_in_cs";
    s.groupid = "firewall4";
    s.name = "firewall_spawn_point4";
    fe [[ f ]]( s, "LOCKED_IN_CASINO", cf, ( -8353.5, 24660, 1088.5 ), ( 0, 40, 90 ), undefined, undefined, "firewall_spawn", "firewall4", "firewall_spawn_point", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_locked_in_cs";
    s.groupid = "firewall4";
    s.name = "firewall4_drone1";
    fe [[ f ]]( s, "LOCKED_IN_CASINO", cf, ( -8379.5, 24607, 1088.5 ), ( 0, 40, 0 ), undefined, undefined, "drone_spawn", undefined, "firewall4", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_locked_in_cs";
    s.groupid = "firewall4";
    s.name = "firewall4_drone2";
    fe [[ f ]]( s, "LOCKED_IN_CASINO", cf, ( -8299, 24677.5, 1088.5 ), ( 0, 220, 0 ), undefined, undefined, "drone_spawn", undefined, "firewall4", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_locked_in_cs";
    s.groupid = "firewall5";
    s.name = "firewall_spawn_point5";
    fe [[ f ]]( s, "LOCKED_IN_CASINO", cf, ( -7716.38, 26433.2, 890.53 ), ( 0, 310, 90 ), undefined, undefined, "firewall_spawn", "firewall5", "firewall_spawn_point", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_locked_in_cs";
    s.groupid = "firewall5";
    s.name = "firewall5_drone1";
    fe [[ f ]]( s, "LOCKED_IN_CASINO", cf, ( -7761.38, 26471.2, 890.53 ), ( 0, 220, 0 ), undefined, undefined, "drone_spawn", undefined, "firewall5", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_locked_in_cs";
    s.groupid = "firewall5";
    s.name = "firewall5_drone2";
    fe [[ f ]]( s, "LOCKED_IN_CASINO", cf, ( -7686.88, 26382.2, 890.53 ), ( 0, 220, 0 ), undefined, undefined, "drone_spawn", undefined, "firewall5", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_locked_in_cs";
    s.groupid = "firewall6";
    s.name = "firewall_spawn_point6";
    fe [[ f ]]( s, "LOCKED_IN_CASINO", cf, ( -8763.28, 25590.3, 918.43 ), ( 0, 265, 90 ), undefined, undefined, "firewall_spawn", "firewall6", "firewall_spawn_point", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_locked_in_cs";
    s.groupid = "firewall6";
    s.name = "firewall6_drone1";
    fe [[ f ]]( s, "LOCKED_IN_CASINO", cf, ( -8769.28, 25668.3, 918.43 ), ( 0, 175, 0 ), undefined, undefined, "drone_spawn", undefined, "firewall6", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_locked_in_cs";
    s.groupid = "firewall6";
    s.name = "firewall6_drone2";
    fe [[ f ]]( s, "LOCKED_IN_CASINO", cf, ( -8777.28, 25514.3, 918.43 ), ( 0, 175, 0 ), undefined, undefined, "drone_spawn", undefined, "firewall6", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_locked_in_cs";
    s.groupid = "firewall8";
    s.name = "firewall8_drone1";
    fe [[ f ]]( s, "LOCKED_IN_CASINO", cf, ( -9761.5, 25866, 928.41 ), ( 0, 130, 0 ), undefined, undefined, "drone_spawn", undefined, "firewall8", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_locked_in_cs";
    s.groupid = "firewall7";
    s.name = "firewall7_drone1";
    fe [[ f ]]( s, "LOCKED_IN_CASINO", cf, ( -8964.15, 27175.3, 886.76 ), ( 0, 310, 0 ), undefined, undefined, "drone_spawn", undefined, "firewall7", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_locked_in_cs";
    s.groupid = "firewall7";
    s.name = "firewall_spawn_point7";
    fe [[ f ]]( s, "LOCKED_IN_CASINO", cf, ( -8927.15, 27237, 886.76 ), ( 0, 40, 90 ), undefined, undefined, "firewall_spawn", "firewall7", "firewall_spawn_point", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_locked_in_cs";
    s.groupid = "firewall8";
    s.name = "firewall_spawn_point8";
    fe [[ f ]]( s, "LOCKED_IN_CASINO", cf, ( -9800.25, 25814.5, 928.41 ), ( 0, 220, 90 ), undefined, undefined, "firewall_spawn", "firewall8", "firewall_spawn_point", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_locked_in_cs";
    s.groupid = "firewall7";
    s.name = "firewall7_drone2";
    fe [[ f ]]( s, "LOCKED_IN_CASINO", cf, ( -8859.4, 27263, 886.76 ), ( 0, 310, 0 ), undefined, undefined, "drone_spawn", undefined, "firewall7", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_locked_in_cs";
    s.groupid = "firewall8";
    s.name = "firewall8_drone2";
    fe [[ f ]]( s, "LOCKED_IN_CASINO", cf, ( -9870.25, 25810, 928.41 ), ( 0, 40, 0 ), undefined, undefined, "drone_spawn", undefined, "firewall8", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_locked_in_cs";
    s.groupid = "firewall9";
    s.name = "firewall_spawn_point9";
    fe [[ f ]]( s, "LOCKED_IN_CASINO", cf, ( -10747.4, 26355.3, 900.48 ), ( 0, 130, 90 ), undefined, undefined, "firewall_spawn", "firewall9", "firewall_spawn_point", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_locked_in_cs";
    s.groupid = "firewall9";
    s.name = "firewall9_drone1";
    fe [[ f ]]( s, "LOCKED_IN_CASINO", cf, ( -10706.4, 26319.8, 900.48 ), ( 0, 40, 0 ), undefined, undefined, "drone_spawn", undefined, "firewall9", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_locked_in_cs";
    s.groupid = "firewall9";
    s.name = "firewall9_drone2";
    fe [[ f ]]( s, "LOCKED_IN_CASINO", cf, ( -10775.4, 26401.8, 900.48 ), ( 0, 40, 0 ), undefined, undefined, "drone_spawn", undefined, "firewall9", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_locked_in_cs";
    s.groupid = "firewall_10";
    s.name = "firewall_spawn_point10";
    fe [[ f ]]( s, "LOCKED_IN_CASINO", cf, ( -9713.89, 28210.6, 901.45 ), ( 0, 40, 90 ), undefined, undefined, "firewall_spawn", "firewall10", "firewall_spawn_point", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_locked_in_cs";
    s.groupid = "firewall_10";
    s.name = "firewall10_drone1";
    fe [[ f ]]( s, "LOCKED_IN_CASINO", cf, ( -9747.64, 28170.4, 901.45 ), ( 0, 310, 0 ), undefined, undefined, "drone_spawn", undefined, "firewall10", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_locked_in_cs";
    s.groupid = "firewall_10";
    s.name = "firewall10_drone2";
    fe [[ f ]]( s, "LOCKED_IN_CASINO", cf, ( -9671.89, 28231.9, 901.45 ), ( 6.11, 310.6, -178.55 ), undefined, undefined, "drone_spawn", undefined, "firewall10", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_locked_in_cs";
    s.groupid = "firewall_11";
    s.name = "firewall_spawn_point11";
    fe [[ f ]]( s, "LOCKED_IN_CASINO", cf, ( -10541.8, 27487.2, 933.15 ), ( 0, 40, 90 ), undefined, undefined, "firewall_spawn", "firewall11", "firewall_spawn_point", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_locked_in_cs";
    s.groupid = "firewall_11";
    s.name = "firewall11_drone1";
    fe [[ f ]]( s, "LOCKED_IN_CASINO", cf, ( -10587.8, 27443.9, 933.15 ), ( 0, 310, 0 ), undefined, undefined, "drone_spawn", undefined, "firewall11", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_locked_in_cs";
    s.groupid = "firewall_11";
    s.name = "firewall11_drone2";
    fe [[ f ]]( s, "LOCKED_IN_CASINO", cf, ( -10491.3, 27522.7, 933.15 ), ( 0, 310, 0 ), undefined, undefined, "drone_spawn", undefined, "firewall11", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_locked_in_cs";
    s.groupid = "firewall_12";
    s.name = "firewall_spawn_point12";
    fe [[ f ]]( s, "LOCKED_IN_CASINO", cf, ( -11010.6, 27955.1, 886.68 ), ( 0, 220, 90 ), undefined, undefined, "firewall_spawn", "firewall12", "firewall_spawn_point", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_locked_in_cs";
    s.groupid = "firewall_12";
    s.name = "firewall12_drone1";
    fe [[ f ]]( s, "LOCKED_IN_CASINO", cf, ( -10975.6, 28015.3, 886.68 ), ( 0, 130, 0 ), undefined, undefined, "drone_spawn", undefined, "firewall12", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_locked_in_cs";
    s.groupid = "firewall_12";
    s.name = "firewall12_drone2";
    fe [[ f ]]( s, "LOCKED_IN_CASINO", cf, ( -11085.6, 27934.1, 886.68 ), ( 0, 40, 0 ), undefined, undefined, "drone_spawn", undefined, "firewall12", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_locked_in_cs";
    s.groupid = "participate_phase_reinforcement";
    s.ishelistruct = 1;
    s.script_accel = "350";
    fe [[ f ]]( s, "LOCKED_IN_CASINO", cf, ( -8470.86, 28509.2, 1416.69 ), ( 0, 130.61, 0 ), "LOCKED_IN_CASINO_PARTICIPATE", "LOCKED_IN_CASINO_VTOL_2", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_locked_in_cs";
    s.groupid = "participate_phase_reinforcement";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "LOCKED_IN_CASINO", cf, ( -25215.2, 25026.2, 9405.25 ), ( 359.47, 47.41, 0.49 ), "LOCKED_IN_CASINO_VTOL_3", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_locked_in_cs";
    s.groupid = "participate_phase_reinforcement";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "LOCKED_IN_CASINO", cf, ( -9292.89, 14126.4, 7835.02 ), ( 0, 99.03, 0 ), undefined, "LOCKED_IN_CASINO_VTOL_1", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150, 1 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_locked_in_cs";
    s.groupid = "participate_phase_reinforcement";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "LOCKED_IN_CASINO", cf, ( -14486.6, 31871.1, 5735.27 ), ( 359.47, 47.41, 0.49 ), "LOCKED_IN_CASINO_VTOL_2", "LOCKED_IN_CASINO_VTOL_3", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_locked_in_cs";
    s.groupid = "participate_phase_reinforcement";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "LOCKED_IN_CASINO", cf, ( -9292.94, 20582.1, 6757.52 ), ( 0, 12.15, 0 ), "LOCKED_IN_CASINO_VTOL_1", "LOCKED_IN_CASINO_PARTICIPATE", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_locked_in_cs";
    s.groupid = "warning_blocks";
    s.name = "window";
    fe [[ f ]]( s, "LOCKED_IN_CASINO", cf, ( -7591.56, 24049.8, 1020 ), ( 0, 310, 0 ), undefined, undefined, "block_w", undefined, "blocks", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_locked_in_cs";
    s.groupid = "warning_blocks";
    s.name = "window";
    fe [[ f ]]( s, "LOCKED_IN_CASINO", cf, ( -7493.56, 24131.8, 1020 ), ( 0, 310, 0 ), undefined, undefined, "block_w", undefined, "blocks", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_locked_in_cs";
    s.groupid = "warning_blocks";
    s.name = "window";
    fe [[ f ]]( s, "LOCKED_IN_CASINO", cf, ( -7395.56, 24213.8, 1020 ), ( 0, 310, 0 ), undefined, undefined, "block_w", undefined, "blocks", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_locked_in_cs";
    s.groupid = "warning_blocks";
    s.name = "door";
    fe [[ f ]]( s, "LOCKED_IN_CASINO", cf, ( -7585.08, 24244.7, 762 ), ( 0, 310, 0 ), undefined, undefined, "block_d", undefined, "blocks", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_locked_in_cs";
    s.groupid = "warning_blocks";
    s.name = "door";
    fe [[ f ]]( s, "LOCKED_IN_CASINO", cf, ( -6875, 25866.5, 770 ), ( 0, 40, 0 ), undefined, undefined, "block_d", undefined, "blocks", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_locked_in_cs";
    s.groupid = "warning_blocks";
    s.name = "door";
    fe [[ f ]]( s, "LOCKED_IN_CASINO", cf, ( -9753.05, 28668.3, 770 ), ( 0, 130, 0 ), undefined, undefined, "block_d", undefined, "blocks", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_locked_in_cs";
    s.groupid = "warning_blocks";
    s.name = "door";
    fe [[ f ]]( s, "LOCKED_IN_CASINO", cf, ( -11293, 28661, 772 ), ( 0, 130, 0 ), undefined, undefined, "block_d", undefined, "blocks", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_locked_in_cs";
    s.groupid = "warning_blocks";
    s.name = "door";
    fe [[ f ]]( s, "LOCKED_IN_CASINO", cf, ( -10504, 26228, 762 ), ( 0, 310, 0 ), undefined, undefined, "block_d", undefined, "blocks", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_locked_in_cs";
    s.groupid = "warning_blocks";
    s.name = "door";
    fe [[ f ]]( s, "LOCKED_IN_CASINO", cf, ( -10029.2, 25972.6, 762 ), ( 0, 220, 0 ), undefined, undefined, "block_d", undefined, "blocks", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_locked_in_cs";
    s.groupid = "warning_blocks";
    s.name = "door";
    fe [[ f ]]( s, "LOCKED_IN_CASINO", cf, ( -9969.2, 25900.6, 762 ), ( 0, 220, 0 ), undefined, undefined, "block_d", undefined, "blocks", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_locked_in_cs";
    s.groupid = "warning_blocks";
    s.name = "root";
    fe [[ f ]]( s, "LOCKED_IN_CASINO", cf, ( -9404.49, 26384.9, 772.75 ), ( 0, 0, 0 ), undefined, undefined, "warning_blocks_root", "blocks", "phase", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_locked_in_cs";
    s.groupid = "warning_blocks";
    s.name = "window";
    fe [[ f ]]( s, "LOCKED_IN_CASINO", cf, ( -9143.64, 28202.7, 760.02 ), ( 0, 40, 0 ), undefined, undefined, "block_w", undefined, "blocks", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_locked_in_cs";
    s.groupid = "warning_blocks";
    s.name = "window";
    fe [[ f ]]( s, "LOCKED_IN_CASINO", cf, ( -9016.13, 28050.1, 760 ), ( 0, 40, 0 ), undefined, undefined, "block_w", undefined, "blocks", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_locked_in_cs";
    s.groupid = "warning_blocks";
    s.name = "window";
    fe [[ f ]]( s, "LOCKED_IN_CASINO", cf, ( -8621.46, 27242.7, 760 ), ( 0, 40, 0 ), undefined, undefined, "block_w", undefined, "blocks", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_locked_in_cs";
    s.groupid = "warning_blocks";
    s.name = "window";
    fe [[ f ]]( s, "LOCKED_IN_CASINO", cf, ( -8471.93, 27064.5, 760 ), ( 0, 40, 0 ), undefined, undefined, "block_w", undefined, "blocks", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_locked_in_cs";
    s.name = "reward";
    fe [[ f ]]( s, "LOCKED_IN_CASINO", cf, ( -10350, 27059.8, 768 ), ( 0, 0, 0 ), undefined, undefined, "reward", undefined, "phase", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_locked_in_cs";
    s.groupid = "firewall_13";
    s.name = "firewall_spawn_point13";
    fe [[ f ]]( s, "LOCKED_IN_CASINO", cf, ( -9622.67, 27211.5, 929.37 ), ( 0, 265, 90 ), undefined, undefined, "firewall_spawn", "firewall13", "firewall_spawn_point", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_locked_in_cs";
    s.groupid = "firewall_13";
    s.name = "firewall13_drone1";
    fe [[ f ]]( s, "LOCKED_IN_CASINO", cf, ( -9634.67, 27273.5, 929.37 ), ( 0, 175, 0 ), undefined, undefined, "drone_spawn", undefined, "firewall13", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_locked_in_cs";
    s.groupid = "firewall_13";
    s.name = "firewall13_drone2";
    fe [[ f ]]( s, "LOCKED_IN_CASINO", cf, ( -9644.67, 27151.5, 929.37 ), ( 0, 175, 0 ), undefined, undefined, "drone_spawn", undefined, "firewall13", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_locked_in_cs";
    s.groupid = "firewall_14";
    s.name = "firewall_spawn_point14";
    fe [[ f ]]( s, "LOCKED_IN_CASINO", cf, ( -7314.42, 25587.4, 893.39 ), ( 0, 130, 90 ), undefined, undefined, "firewall_spawn", "firewall14", "firewall_spawn_point", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_locked_in_cs";
    s.groupid = "firewall_14";
    s.name = "firewall14_drone1";
    fe [[ f ]]( s, "LOCKED_IN_CASINO", cf, ( -7272.42, 25555.4, 893.39 ), ( 0, 40, 0 ), undefined, undefined, "drone_spawn", undefined, "firewall14", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_locked_in_cs";
    s.groupid = "firewall_14";
    s.name = "firewall14_drone2";
    fe [[ f ]]( s, "LOCKED_IN_CASINO", cf, ( -7312.42, 25641.4, 893.39 ), ( 0, 310, 0 ), undefined, undefined, "drone_spawn", undefined, "firewall14", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_locked_in_cs";
    s.groupid = "firewall_15";
    s.name = "firewall_spawn_point15";
    fe [[ f ]]( s, "LOCKED_IN_CASINO", cf, ( -10607.8, 27080.8, 885.07 ), ( 0, 130, 90 ), undefined, undefined, "firewall_spawn", "firewall15", "firewall_spawn_point", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_locked_in_cs";
    s.groupid = "firewall_15";
    s.name = "firewall15_drone1";
    fe [[ f ]]( s, "LOCKED_IN_CASINO", cf, ( -10557.8, 27038.8, 885.07 ), ( 0, 40, 0 ), undefined, undefined, "drone_spawn", undefined, "firewall15", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_locked_in_cs";
    s.groupid = "firewall_15";
    s.name = "firewall15_drone2";
    fe [[ f ]]( s, "LOCKED_IN_CASINO", cf, ( -10645.8, 27140.8, 885.07 ), ( 0, 40, 0 ), undefined, undefined, "drone_spawn", undefined, "firewall15", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_locked_in_cs";
    s.groupid = "firewall_16";
    s.name = "firewall_spawn_point16";
    fe [[ f ]]( s, "LOCKED_IN_CASINO", cf, ( -9482.7, 26503.3, 912.25 ), ( 0, 220, 90 ), undefined, undefined, "firewall_spawn", "firewall16", "firewall_spawn_point", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_locked_in_cs";
    s.groupid = "firewall_16";
    s.name = "firewall16_drone1";
    fe [[ f ]]( s, "LOCKED_IN_CASINO", cf, ( -9450.95, 26571.6, 912.25 ), ( 0, 130, 0 ), undefined, undefined, "drone_spawn", undefined, "firewall16", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_locked_in_cs";
    s.groupid = "firewall_16";
    s.name = "firewall16_drone2";
    fe [[ f ]]( s, "LOCKED_IN_CASINO", cf, ( -9549.95, 26483.6, 912.25 ), ( 0, 130, 0 ), undefined, undefined, "drone_spawn", undefined, "firewall16", ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_sat_avalon_q1_ob_activity_locked_in_cs
// Params 0
// Checksum 0x897631e9, Offset: 0x5d12
// Size: 0x1b7
function function_d9dd7965c51c95d1()
{
    activityinstances = [];
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_activity_definition_locked_in";
    var_881289d7987bc770.cf = "mp_sat_avalon_q1_ob_activity_locked_in_cs";
    var_881289d7987bc770.scriptstructorigin = ( -13461.9, -6979.46, 1056 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [ ( -13461.9, -7043.46, 1056 ) ];
    var_881289d7987bc770.var_31ce4477e3543d24 = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.locationradius = [ 3000 ];
    activityinstances[ "LOCKED_IN_MUSEUM" ] = var_881289d7987bc770;
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_activity_definition_locked_in";
    var_881289d7987bc770.cf = "mp_sat_avalon_q1_ob_activity_locked_in_cs";
    var_881289d7987bc770.scriptstructorigin = ( -9428.19, 26448.5, 772.75 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [ ( -9428.19, 26384.5, 772.75 ) ];
    var_881289d7987bc770.var_31ce4477e3543d24 = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.locationradius = [ 3000 ];
    activityinstances[ "LOCKED_IN_CASINO" ] = var_881289d7987bc770;
    return activityinstances;
}

