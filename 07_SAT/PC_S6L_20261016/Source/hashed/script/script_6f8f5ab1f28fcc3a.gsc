// script_6f8f5ab1f28fcc3a  (hash_6f8f5ab1f28fcc3a.gscc) (size: 23266 Bytes / 0x5ae2 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x5b5f63bd (1532978109)
// size ...... 23266 (0x5ae2)
// includes .. 4   (offset: 0x4c46)
// strings ... 113 (offset: 0x4c66)
// dev strs .. 0   (offset: 0x5ae2)
// exports ... 13  (offset: 0x4762)
// cseg ...... 0x8de + 0x3e84 (0x4762)
// imports ... 26  (offset: 0x496a)
// animtree1 . 0   (offset: 0x5ae2)
// animtree2 . 0   (offset: 0x5ae2)
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace mp_sat_avalon_q2_ob_activity_locked_in_cs;

// Namespace mp_sat_avalon_q2_ob_activity_locked_in_cs
// Params 0, eflags: 0x5
// Checksum 0x8286e261, Offset: 0x8fc
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"mp_sat_avalon_q2_ob_activity_locked_in_cs", #"activity_common", &function_b39ecd3d51489472, undefined );
}

// Namespace mp_sat_avalon_q2_ob_activity_locked_in_cs
// Params 0, eflags: 0x4
// Checksum 0xa7a0d5c3, Offset: 0x925
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace mp_sat_avalon_q2_ob_activity_locked_in_cs
// Params 0, eflags: 0x4
// Checksum 0x229b062f, Offset: 0x936
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace mp_sat_avalon_q2_ob_activity_locked_in_cs
// Params 2
// Checksum 0x29579155, Offset: 0x947
// Size: 0x8c
function main( unused, unused2 )
{
    if ( utility::flag_exist( "mp_sat_avalon_q2_ob_activity_locked_in_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "mp_sat_avalon_q2_ob_activity_locked_in_cs" ) )
    {
        return;
    }
    
    activity_common::function_e1df676808c1d1e3( &function_4cd78e661617f3 );
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "mp_sat_avalon_q2_ob_activity_locked_in_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "mp_sat_avalon_q2_ob_activity_locked_in_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace mp_sat_avalon_q2_ob_activity_locked_in_cs
// Params 3, eflags: 0x4
// Checksum 0xa119b2e0, Offset: 0x9db
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "mp_sat_avalon_q2_ob_activity_locked_in_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "mp_sat_avalon_q2_ob_activity_locked_in_cs" );
}

// Namespace mp_sat_avalon_q2_ob_activity_locked_in_cs
// Params 3, eflags: 0x4
// Checksum 0xff3be66f, Offset: 0xa55
// Size: 0x13b
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_locked_in_cs";
    fe [[ f ]]( s, "LOCKED_IN_RESORTS", cf, ( 12576.2, 20888.4, 2520.05 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Awareness_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 3000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_locked_in_cs";
    s.activity_bundle = "sat_activity_definition_locked_in";
    s.name = "LOCKED_IN_RESORTS";
    fe [[ f ]]( s, "LOCKED_IN_RESORTS", cf, ( 12576.2, 20920.4, 2520.05 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace mp_sat_avalon_q2_ob_activity_locked_in_cs
// Params 0, eflags: 0x4
// Checksum 0x3ed32518, Offset: 0xb98
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace mp_sat_avalon_q2_ob_activity_locked_in_cs
// Params 0
// Checksum 0x634a6fad, Offset: 0xba2
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "mp_sat_avalon_q2_ob_activity_locked_in_cs" );
}

// Namespace mp_sat_avalon_q2_ob_activity_locked_in_cs
// Params 0
// Checksum 0xf7e8655b, Offset: 0xbb8
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

// Namespace mp_sat_avalon_q2_ob_activity_locked_in_cs
// Params 4
// Checksum 0xf2483439, Offset: 0xc27
// Size: 0x57
function function_d4323822d7042e5a( var_4312b79c960726b6, fe, us, cf = "mp_sat_avalon_q2_ob_activity_locked_in_cs" )
{
    switch ( var_4312b79c960726b6 )
    {
        case #"hash_cf67fdcc5b88778e":
            function_5c282b68075571f6( fe, us, cf );
            break;
    }
}

// Namespace mp_sat_avalon_q2_ob_activity_locked_in_cs
// Params 3
// Checksum 0x7aea6da2, Offset: 0xc86
// Size: 0x39eb
function function_5c282b68075571f6( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_locked_in_cs";
    s.height = 3000;
    s.name = "center_struct";
    fe [[ f ]]( s, "LOCKED_IN_RESORTS", cf, ( 12600.2, 20888.4, 2520.05 ), ( 0, 0, 0 ), "LOCKED_IN_RESORTS", undefined, undefined, "phase", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 3000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_locked_in_cs";
    s.var_235de1e35f60da4f = "1";
    s.var_5accfd2db39d41b7 = "0.75";
    s.name = "firewall_spawn_root";
    fe [[ f ]]( s, "LOCKED_IN_RESORTS", cf, ( 12600.2, 20920.4, 2520.05 ), ( 0, 0, 0 ), undefined, undefined, "firewall_spawn_root", "firewall_spawn_point", "phase", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_locked_in_cs";
    s.groupid = "warning_blocks";
    s.name = "root";
    fe [[ f ]]( s, "LOCKED_IN_RESORTS", cf, ( 12599.9, 20856.8, 2520.05 ), ( 0, 0, 0 ), undefined, undefined, "warning_blocks_root", "blocks", "phase", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_locked_in_cs";
    s.groupid = "terminal";
    s.name = "terminal";
    s.var_4d433da9852c2079 = "300";
    s.var_bd0bcf1748163778 = "300";
    fe [[ f ]]( s, "LOCKED_IN_RESORTS", cf, ( 12096, 21144.2, 2360 ), ( 0, 90, 0 ), undefined, undefined, "command_node_terminal", undefined, "phase", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_locked_in_cs";
    s.groupid = "terminal";
    s.var_297c4a455dbf7232 = "0,1";
    s.name = "defend_area";
    fe [[ f ]]( s, "LOCKED_IN_RESORTS", cf, ( 12096, 21144.2, 2360 ), ( 0, 0, 0 ), undefined, undefined, "defend_area", "defend_dawg_spawn", "phase", ( 0, 0, 0 ), ( 0, 0, 0 ), 300 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_locked_in_cs";
    s.groupid = "terminal";
    s.name = "ability_case_drop_point2";
    fe [[ f ]]( s, "LOCKED_IN_RESORTS", cf, ( 12221.5, 21141, 2360 ), ( 0, 0, 0 ), undefined, undefined, "ability_case_drop_point", undefined, "phase", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_locked_in_cs";
    s.groupid = "terminal";
    s.name = "ability_case_drop_point1";
    fe [[ f ]]( s, "LOCKED_IN_RESORTS", cf, ( 11970.5, 21141, 2360 ), ( 0, 180, 0 ), undefined, undefined, "ability_case_drop_point", undefined, "phase", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_locked_in_cs";
    s.groupid = "warning_blocks";
    s.name = "window";
    fe [[ f ]]( s, "LOCKED_IN_RESORTS", cf, ( 13141.7, 21552.3, 2352 ), ( 0, 90, 0 ), undefined, undefined, "block_w", undefined, "blocks", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_locked_in_cs";
    s.groupid = "warning_blocks";
    s.name = "window";
    fe [[ f ]]( s, "LOCKED_IN_RESORTS", cf, ( 12259.5, 20593.6, 2352 ), ( 0, 270, 0 ), undefined, undefined, "block_w", undefined, "blocks", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_locked_in_cs";
    s.groupid = "warning_blocks";
    s.name = "window";
    fe [[ f ]]( s, "LOCKED_IN_RESORTS", cf, ( 13392, 21018, 2352 ), ( 0, 0, 0 ), undefined, undefined, "block_w", undefined, "blocks", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_locked_in_cs";
    s.groupid = "warning_blocks";
    s.name = "window";
    fe [[ f ]]( s, "LOCKED_IN_RESORTS", cf, ( 13184.3, 21391.3, 2352 ), ( 0, 0, 0 ), undefined, undefined, "block_w", undefined, "blocks", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_locked_in_cs";
    s.groupid = "warning_blocks";
    s.name = "window";
    fe [[ f ]]( s, "LOCKED_IN_RESORTS", cf, ( 13101.2, 21552.3, 2352 ), ( 0, 90, 0 ), undefined, undefined, "block_w", undefined, "blocks", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_locked_in_cs";
    s.groupid = "warning_blocks";
    s.name = "window";
    fe [[ f ]]( s, "LOCKED_IN_RESORTS", cf, ( 13056.3, 21595.3, 2352 ), ( 0, 0, 0 ), undefined, undefined, "block_w", undefined, "blocks", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_locked_in_cs";
    s.groupid = "warning_blocks";
    s.name = "door";
    fe [[ f ]]( s, "LOCKED_IN_RESORTS", cf, ( 12870.6, 21839.7, 2405.12 ), ( 0, 90, 0 ), undefined, undefined, "block_d", undefined, "blocks", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_locked_in_cs";
    s.groupid = "warning_blocks";
    s.name = "door";
    fe [[ f ]]( s, "LOCKED_IN_RESORTS", cf, ( 12177.9, 21932, 2360.76 ), ( 0, 90, 0 ), undefined, undefined, "block_d", undefined, "blocks", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_locked_in_cs";
    s.groupid = "warning_blocks";
    s.name = "door";
    fe [[ f ]]( s, "LOCKED_IN_RESORTS", cf, ( 11998.4, 21932, 2360.76 ), ( 0, 90, 0 ), undefined, undefined, "block_d", undefined, "blocks", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_locked_in_cs";
    s.groupid = "warning_blocks";
    s.name = "window";
    fe [[ f ]]( s, "LOCKED_IN_RESORTS", cf, ( 12395.2, 21883.3, 2351.92 ), ( 0, 0, 0 ), undefined, undefined, "block_w", undefined, "blocks", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_locked_in_cs";
    s.groupid = "warning_blocks";
    s.name = "window";
    fe [[ f ]]( s, "LOCKED_IN_RESORTS", cf, ( 11779.3, 21883.2, 2351.92 ), ( 0, 180, 0 ), undefined, undefined, "block_w", undefined, "blocks", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_locked_in_cs";
    s.groupid = "warning_blocks";
    s.name = "door";
    fe [[ f ]]( s, "LOCKED_IN_RESORTS", cf, ( 11518.8, 21836.5, 2361.26 ), ( 0, 90, 0 ), undefined, undefined, "block_d", undefined, "blocks", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_locked_in_cs";
    s.groupid = "warning_blocks";
    s.name = "door";
    fe [[ f ]]( s, "LOCKED_IN_RESORTS", cf, ( 11436, 21836.5, 2361.26 ), ( 0, 90, 0 ), undefined, undefined, "block_d", undefined, "blocks", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_locked_in_cs";
    s.groupid = "warning_blocks";
    s.name = "door";
    fe [[ f ]]( s, "LOCKED_IN_RESORTS", cf, ( 11228.5, 21516.5, 2360.4 ), ( 0, 180, 0 ), undefined, undefined, "block_d", undefined, "blocks", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_locked_in_cs";
    s.groupid = "warning_blocks";
    s.name = "door";
    fe [[ f ]]( s, "LOCKED_IN_RESORTS", cf, ( 10939.8, 20702.8, 2360.82 ), ( 0, 180, 0 ), undefined, undefined, "block_d", undefined, "blocks", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_locked_in_cs";
    s.groupid = "warning_blocks";
    s.name = "door";
    fe [[ f ]]( s, "LOCKED_IN_RESORTS", cf, ( 11772.2, 20170.5, 2360.01 ), ( 0, 0, 0 ), undefined, undefined, "block_d", undefined, "blocks", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_locked_in_cs";
    s.groupid = "warning_blocks";
    s.name = "door";
    fe [[ f ]]( s, "LOCKED_IN_RESORTS", cf, ( 12095.5, 20598.4, 2263.38 ), ( 0, 270, 0 ), undefined, undefined, "block_d", undefined, "blocks", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_locked_in_cs";
    s.groupid = "warning_blocks";
    s.name = "door";
    fe [[ f ]]( s, "LOCKED_IN_RESORTS", cf, ( 12419.2, 20351.5, 2362.97 ), ( 0, 180, 0 ), undefined, undefined, "block_d", undefined, "blocks", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_locked_in_cs";
    s.groupid = "warning_blocks";
    s.name = "door";
    fe [[ f ]]( s, "LOCKED_IN_RESORTS", cf, ( 12419.2, 20210.5, 2362.97 ), ( 0, 180, 0 ), undefined, undefined, "block_d", undefined, "blocks", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_locked_in_cs";
    s.groupid = "warning_blocks";
    s.name = "window";
    fe [[ f ]]( s, "LOCKED_IN_RESORTS", cf, ( 13374.8, 20323.7, 2353 ), ( 0, 0, 0 ), undefined, undefined, "block_w", undefined, "blocks", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_locked_in_cs";
    s.groupid = "warning_blocks";
    s.name = "window";
    fe [[ f ]]( s, "LOCKED_IN_RESORTS", cf, ( 13392, 21070, 2352 ), ( 0, 0, 0 ), undefined, undefined, "block_w", undefined, "blocks", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_locked_in_cs";
    s.groupid = "warning_blocks";
    s.name = "window";
    fe [[ f ]]( s, "LOCKED_IN_RESORTS", cf, ( 13370, 20158, 2528 ), ( 0, 0, 0 ), undefined, undefined, "block_w", undefined, "blocks", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_locked_in_cs";
    s.groupid = "warning_blocks";
    s.name = "door";
    fe [[ f ]]( s, "LOCKED_IN_RESORTS", cf, ( 11997, 20588, 2524.31 ), ( 0, 270, 0 ), undefined, undefined, "block_d", undefined, "blocks", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_locked_in_cs";
    s.groupid = "warning_blocks";
    s.name = "door";
    fe [[ f ]]( s, "LOCKED_IN_RESORTS", cf, ( 12193, 20588, 2524.31 ), ( 0, 270, 0 ), undefined, undefined, "block_d", undefined, "blocks", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_locked_in_cs";
    s.groupid = "warning_blocks";
    s.name = "window";
    fe [[ f ]]( s, "LOCKED_IN_RESORTS", cf, ( 12507.2, 20447.8, 2110.36 ), ( 0, 270, 0 ), undefined, undefined, "block_w", undefined, "blocks", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_locked_in_cs";
    s.groupid = "warning_blocks";
    s.name = "window";
    fe [[ f ]]( s, "LOCKED_IN_RESORTS", cf, ( 12438.1, 20517, 2110.16 ), ( 0, 180, 0 ), undefined, undefined, "block_w", undefined, "blocks", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_locked_in_cs";
    s.groupid = "warning_blocks";
    s.name = "window";
    fe [[ f ]]( s, "LOCKED_IN_RESORTS", cf, ( 12585, 20358, 2224 ), ( 0, 180, 0 ), undefined, undefined, "block_w", undefined, "blocks", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_locked_in_cs";
    s.groupid = "warning_blocks";
    s.name = "window";
    fe [[ f ]]( s, "LOCKED_IN_RESORTS", cf, ( 12528, 20276, 2224 ), ( 0, 90, 0 ), undefined, undefined, "block_w", undefined, "blocks", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_locked_in_cs";
    s.groupid = "firewall1";
    s.name = "firewall_spawn_point1";
    fe [[ f ]]( s, "LOCKED_IN_RESORTS", cf, ( 13368, 20765.8, 2480.21 ), ( 0, 270, 90 ), undefined, undefined, "firewall_spawn", "firewall1", "firewall_spawn_point", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_locked_in_cs";
    s.groupid = "firewall1";
    s.name = "firewall1_drone1";
    fe [[ f ]]( s, "LOCKED_IN_RESORTS", cf, ( 13357, 20827.8, 2480.21 ), ( 0, 180, 0 ), undefined, undefined, "drone_spawn", undefined, "firewall1", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_locked_in_cs";
    s.groupid = "firewall2";
    s.name = "firewall_spawn_point2";
    fe [[ f ]]( s, "LOCKED_IN_RESORTS", cf, ( 12421.9, 20112.5, 2654.2 ), ( 0, 90, 90 ), undefined, undefined, "firewall_spawn", "firewall2", "firewall_spawn_point", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_locked_in_cs";
    s.groupid = "firewall2";
    s.name = "firewall2_drone1";
    fe [[ f ]]( s, "LOCKED_IN_RESORTS", cf, ( 12432.9, 20044.5, 2654.2 ), ( 0, 0, 0 ), undefined, undefined, "drone_spawn", undefined, "firewall2", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_locked_in_cs";
    s.groupid = "firewall3";
    s.name = "firewall_spawn_point3";
    fe [[ f ]]( s, "LOCKED_IN_RESORTS", cf, ( 12095.5, 21056, 2484 ), ( 0, 0, 90 ), undefined, undefined, "firewall_spawn", "firewall3", "firewall_spawn_point", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_locked_in_cs";
    s.groupid = "firewall3";
    s.name = "firewall3_drone1";
    fe [[ f ]]( s, "LOCKED_IN_RESORTS", cf, ( 12036, 21047.5, 2484 ), ( 0, 270, 0 ), undefined, undefined, "drone_spawn", undefined, "firewall3", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_locked_in_cs";
    s.groupid = "firewall1";
    s.name = "firewall1_drone2";
    fe [[ f ]]( s, "LOCKED_IN_RESORTS", cf, ( 13355, 20708.8, 2480.21 ), ( 0, 180, 0 ), undefined, undefined, "drone_spawn", undefined, "firewall1", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_locked_in_cs";
    s.groupid = "firewall2";
    s.name = "firewall2_drone2";
    fe [[ f ]]( s, "LOCKED_IN_RESORTS", cf, ( 12430.9, 20172.5, 2654.2 ), ( 0, 0, 0 ), undefined, undefined, "drone_spawn", undefined, "firewall2", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_locked_in_cs";
    s.groupid = "firewall3";
    s.name = "firewall3_drone2";
    fe [[ f ]]( s, "LOCKED_IN_RESORTS", cf, ( 12156, 21047.5, 2484 ), ( 0, 270, 0 ), undefined, undefined, "drone_spawn", undefined, "firewall3", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_locked_in_cs";
    s.groupid = "firewall4";
    s.name = "firewall_spawn_point4";
    fe [[ f ]]( s, "LOCKED_IN_RESORTS", cf, ( 12677, 21645.6, 2488.73 ), ( 0, 90, 90 ), undefined, undefined, "firewall_spawn", "firewall4", "firewall_spawn_point", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_locked_in_cs";
    s.groupid = "firewall4";
    s.name = "firewall4_drone1";
    fe [[ f ]]( s, "LOCKED_IN_RESORTS", cf, ( 12683, 21581.6, 2488.73 ), ( 0, 0, 0 ), undefined, undefined, "drone_spawn", undefined, "firewall4", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_locked_in_cs";
    s.groupid = "firewall4";
    s.name = "firewall4_drone2";
    fe [[ f ]]( s, "LOCKED_IN_RESORTS", cf, ( 12683, 21706.6, 2488.73 ), ( 0, 0, 0 ), undefined, undefined, "drone_spawn", undefined, "firewall4", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_locked_in_cs";
    s.groupid = "firewall5";
    s.name = "firewall_spawn_point5";
    fe [[ f ]]( s, "LOCKED_IN_RESORTS", cf, ( 11349.5, 21328, 2482.2 ), ( 0, 180, 90 ), undefined, undefined, "firewall_spawn", "firewall5", "firewall_spawn_point", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_locked_in_cs";
    s.groupid = "firewall5";
    s.name = "firewall5_drone1";
    fe [[ f ]]( s, "LOCKED_IN_RESORTS", cf, ( 11419.5, 21336.5, 2482.2 ), ( 0, 90, 0 ), undefined, undefined, "drone_spawn", undefined, "firewall5", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_locked_in_cs";
    s.groupid = "firewall5";
    s.name = "firewall5_drone2";
    fe [[ f ]]( s, "LOCKED_IN_RESORTS", cf, ( 11280.5, 21336.5, 2482.2 ), ( 0, 90, 0 ), undefined, undefined, "drone_spawn", undefined, "firewall5", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_locked_in_cs";
    s.groupid = "firewall6";
    s.name = "firewall_spawn_point6";
    fe [[ f ]]( s, "LOCKED_IN_RESORTS", cf, ( 11224, 20844.7, 2456.08 ), ( 0, 270, 90 ), undefined, undefined, "firewall_spawn", "firewall6", "firewall_spawn_point", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_locked_in_cs";
    s.groupid = "firewall6";
    s.name = "firewall6_drone1";
    fe [[ f ]]( s, "LOCKED_IN_RESORTS", cf, ( 11215.5, 20914.2, 2456.08 ), ( 0, 180, 0 ), undefined, undefined, "drone_spawn", undefined, "firewall6", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_locked_in_cs";
    s.groupid = "firewall6";
    s.name = "firewall6_drone2";
    fe [[ f ]]( s, "LOCKED_IN_RESORTS", cf, ( 11215.5, 20776.2, 2456.08 ), ( 0, 180, 0 ), undefined, undefined, "drone_spawn", undefined, "firewall6", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_locked_in_cs";
    s.groupid = "firewall8";
    s.name = "firewall8_drone1";
    fe [[ f ]]( s, "LOCKED_IN_RESORTS", cf, ( 13188, 20353, 2667 ), ( 0, 90, 0 ), undefined, undefined, "drone_spawn", undefined, "firewall8", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_locked_in_cs";
    s.groupid = "firewall7";
    s.name = "firewall7_drone1";
    fe [[ f ]]( s, "LOCKED_IN_RESORTS", cf, ( 11457, 20415, 2472 ), ( 0, 270, 0 ), undefined, undefined, "drone_spawn", undefined, "firewall7", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_locked_in_cs";
    s.groupid = "firewall7";
    s.name = "firewall_spawn_point7";
    fe [[ f ]]( s, "LOCKED_IN_RESORTS", cf, ( 11520, 20424, 2472 ), ( 0, 0, 90 ), undefined, undefined, "firewall_spawn", "firewall7", "firewall_spawn_point", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_locked_in_cs";
    s.groupid = "firewall8";
    s.name = "firewall_spawn_point8";
    fe [[ f ]]( s, "LOCKED_IN_RESORTS", cf, ( 13120, 20344, 2667 ), ( 0, 180, 90 ), undefined, undefined, "firewall_spawn", "firewall8", "firewall_spawn_point", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_locked_in_cs";
    s.groupid = "firewall7";
    s.name = "firewall7_drone2";
    fe [[ f ]]( s, "LOCKED_IN_RESORTS", cf, ( 11590, 20415, 2472 ), ( 0, 270, 0 ), undefined, undefined, "drone_spawn", undefined, "firewall7", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_locked_in_cs";
    s.groupid = "firewall8";
    s.name = "firewall8_drone2";
    fe [[ f ]]( s, "LOCKED_IN_RESORTS", cf, ( 13051, 20353, 2667 ), ( 0, 90, 0 ), undefined, undefined, "drone_spawn", undefined, "firewall8", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_locked_in_cs";
    s.groupid = "firewall9";
    s.name = "firewall_spawn_point9";
    fe [[ f ]]( s, "LOCKED_IN_RESORTS", cf, ( 12573.5, 20976, 2662 ), ( 0, 0, 90 ), undefined, undefined, "firewall_spawn", "firewall9", "firewall_spawn_point", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_locked_in_cs";
    s.groupid = "firewall9";
    s.name = "firewall9_drone1";
    fe [[ f ]]( s, "LOCKED_IN_RESORTS", cf, ( 12513.5, 20967, 2662 ), ( 0, 270, 0 ), undefined, undefined, "drone_spawn", undefined, "firewall9", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_locked_in_cs";
    s.groupid = "firewall9";
    s.name = "firewall9_drone2";
    fe [[ f ]]( s, "LOCKED_IN_RESORTS", cf, ( 12633.5, 20967, 2671 ), ( 0, 270, 0 ), undefined, undefined, "drone_spawn", undefined, "firewall9", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_locked_in_cs";
    s.groupid = "firewall_10";
    s.name = "firewall_spawn_point10";
    fe [[ f ]]( s, "LOCKED_IN_RESORTS", cf, ( 12680, 20525, 2385 ), ( 0, 90, 90 ), undefined, undefined, "firewall_spawn", "firewall10", "firewall_spawn_point", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_locked_in_cs";
    s.groupid = "firewall_10";
    s.name = "firewall10_drone1";
    fe [[ f ]]( s, "LOCKED_IN_RESORTS", cf, ( 12689, 20525, 2421 ), ( 0, 0, 0 ), undefined, undefined, "drone_spawn", undefined, "firewall10", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_locked_in_cs";
    s.groupid = "firewall_10";
    s.name = "firewall10_drone2";
    fe [[ f ]]( s, "LOCKED_IN_RESORTS", cf, ( 12689, 20525, 2349 ), ( 0, 0, 0 ), undefined, undefined, "drone_spawn", undefined, "firewall10", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_locked_in_cs";
    s.groupid = "firewall_11";
    s.name = "firewall_spawn_point11";
    fe [[ f ]]( s, "LOCKED_IN_RESORTS", cf, ( 11878, 20068, 2315 ), ( 0, 180, 90 ), undefined, undefined, "firewall_spawn", "firewall11", "firewall_spawn_point", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_locked_in_cs";
    s.groupid = "firewall_11";
    s.name = "firewall11_drone1";
    fe [[ f ]]( s, "LOCKED_IN_RESORTS", cf, ( 11925, 20077, 2315 ), ( 0, 90, 0 ), undefined, undefined, "drone_spawn", undefined, "firewall11", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_locked_in_cs";
    s.groupid = "firewall_11";
    s.name = "firewall11_drone2";
    fe [[ f ]]( s, "LOCKED_IN_RESORTS", cf, ( 11835, 20077, 2315 ), ( 0, 90, 0 ), undefined, undefined, "drone_spawn", undefined, "firewall11", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_locked_in_cs";
    s.groupid = "firewall_12";
    s.name = "firewall_spawn_point12";
    fe [[ f ]]( s, "LOCKED_IN_RESORTS", cf, ( 11475, 20572, 2466 ), ( 0, 180, 90 ), undefined, undefined, "firewall_spawn", "firewall12", "firewall_spawn_point", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_locked_in_cs";
    s.groupid = "firewall_12";
    s.name = "firewall12_drone1";
    fe [[ f ]]( s, "LOCKED_IN_RESORTS", cf, ( 11533, 20581, 2466 ), ( 0, 90, 0 ), undefined, undefined, "drone_spawn", undefined, "firewall12", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_locked_in_cs";
    s.groupid = "firewall_12";
    s.name = "firewall12_drone2";
    fe [[ f ]]( s, "LOCKED_IN_RESORTS", cf, ( 11419, 20581, 2466 ), ( 0, 90, 0 ), undefined, undefined, "drone_spawn", undefined, "firewall12", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_locked_in_cs";
    s.groupid = "firewall_13";
    s.name = "firewall_spawn_point13";
    fe [[ f ]]( s, "LOCKED_IN_RESORTS", cf, ( 11858, 21930, 2479 ), ( 0, 0, 90 ), undefined, undefined, "firewall_spawn", "firewall13", "firewall_spawn_point", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_locked_in_cs";
    s.groupid = "firewall_13";
    s.name = "firewall13_drone1";
    fe [[ f ]]( s, "LOCKED_IN_RESORTS", cf, ( 11797, 21919, 2479 ), ( 0, 270, 0 ), undefined, undefined, "drone_spawn", undefined, "firewall13", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_locked_in_cs";
    s.groupid = "firewall_13";
    s.name = "firewall13_drone2";
    fe [[ f ]]( s, "LOCKED_IN_RESORTS", cf, ( 11915, 21920, 2479 ), ( 0, 270, 0 ), undefined, undefined, "drone_spawn", undefined, "firewall13", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_locked_in_cs";
    s.groupid = "firewall_14";
    s.name = "firewall_spawn_point14";
    fe [[ f ]]( s, "LOCKED_IN_RESORTS", cf, ( 12768, 21126, 2307 ), ( 0, 270, 90 ), undefined, undefined, "firewall_spawn", "firewall14", "firewall_spawn_point", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_locked_in_cs";
    s.groupid = "firewall_14";
    s.name = "firewall14_drone1";
    fe [[ f ]]( s, "LOCKED_IN_RESORTS", cf, ( 12759, 21192, 2307 ), ( 0, 180, 0 ), undefined, undefined, "drone_spawn", undefined, "firewall14", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_locked_in_cs";
    s.groupid = "firewall_14";
    s.name = "firewall14_drone2";
    fe [[ f ]]( s, "LOCKED_IN_RESORTS", cf, ( 12759, 21058, 2307 ), ( 0, 180, 0 ), undefined, undefined, "drone_spawn", undefined, "firewall14", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_locked_in_cs";
    s.groupid = "firewall_15";
    s.name = "firewall_spawn_point15";
    fe [[ f ]]( s, "LOCKED_IN_RESORTS", cf, ( 12424, 20611, 2258 ), ( 0, 180, 90 ), undefined, undefined, "firewall_spawn", "firewall15", "firewall_spawn_point", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_locked_in_cs";
    s.groupid = "firewall_15";
    s.name = "firewall15_drone1";
    fe [[ f ]]( s, "LOCKED_IN_RESORTS", cf, ( 12485, 20620, 2258 ), ( 0, 90, 0 ), undefined, undefined, "drone_spawn", undefined, "firewall15", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_locked_in_cs";
    s.groupid = "firewall_15";
    s.name = "firewall15_drone2";
    fe [[ f ]]( s, "LOCKED_IN_RESORTS", cf, ( 12363, 20620, 2258 ), ( 0, 90, 0 ), undefined, undefined, "drone_spawn", undefined, "firewall15", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_locked_in_cs";
    s.groupid = "firewall_16";
    s.name = "firewall_spawn_point16";
    fe [[ f ]]( s, "LOCKED_IN_RESORTS", cf, ( 12320, 20068, 2328.5 ), ( 0, 180, 90 ), undefined, undefined, "firewall_spawn", "firewall16", "firewall_spawn_point", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_locked_in_cs";
    s.groupid = "firewall_16";
    s.name = "firewall16_drone1";
    fe [[ f ]]( s, "LOCKED_IN_RESORTS", cf, ( 12365, 20076.5, 2328.5 ), ( 0, 90, 0 ), undefined, undefined, "drone_spawn", undefined, "firewall16", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_locked_in_cs";
    s.groupid = "firewall_16";
    s.name = "firewall16_drone2";
    fe [[ f ]]( s, "LOCKED_IN_RESORTS", cf, ( 12267, 20076.5, 2328.5 ), ( 0, 90, 0 ), undefined, undefined, "drone_spawn", undefined, "firewall16", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_locked_in_cs";
    s.groupid = "warning_blocks";
    s.name = "window";
    fe [[ f ]]( s, "LOCKED_IN_RESORTS", cf, ( 12325.5, 20593.6, 2352 ), ( 0, 270, 0 ), undefined, undefined, "block_w", undefined, "blocks", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_locked_in_cs";
    s.groupid = "warning_blocks";
    s.name = "window";
    fe [[ f ]]( s, "LOCKED_IN_RESORTS", cf, ( 11861.5, 20593.6, 2352 ), ( 0, 270, 0 ), undefined, undefined, "block_w", undefined, "blocks", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_locked_in_cs";
    s.groupid = "warning_blocks";
    s.name = "window";
    fe [[ f ]]( s, "LOCKED_IN_RESORTS", cf, ( 13374.8, 20369.7, 2353 ), ( 0, 0, 0 ), undefined, undefined, "block_w", undefined, "blocks", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_locked_in_cs";
    s.groupid = "warning_blocks";
    s.name = "window";
    fe [[ f ]]( s, "LOCKED_IN_RESORTS", cf, ( 13371.3, 20711, 2512 ), ( 0, 0, 0 ), undefined, undefined, "block_w", undefined, "blocks", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_locked_in_cs";
    s.groupid = "warning_blocks";
    s.name = "window";
    fe [[ f ]]( s, "LOCKED_IN_RESORTS", cf, ( 13371.3, 20765, 2512 ), ( 0, 0, 0 ), undefined, undefined, "block_w", undefined, "blocks", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_locked_in_cs";
    s.groupid = "warning_blocks";
    s.name = "window";
    fe [[ f ]]( s, "LOCKED_IN_RESORTS", cf, ( 13392, 21132, 2352 ), ( 0, 0, 0 ), undefined, undefined, "block_w", undefined, "blocks", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_locked_in_cs";
    s.groupid = "warning_blocks";
    s.name = "window";
    fe [[ f ]]( s, "LOCKED_IN_RESORTS", cf, ( 13184.3, 21455.8, 2352 ), ( 0, 0, 0 ), undefined, undefined, "block_w", undefined, "blocks", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_locked_in_cs";
    s.groupid = "warning_blocks";
    s.name = "window";
    fe [[ f ]]( s, "LOCKED_IN_RESORTS", cf, ( 13184.3, 21513.8, 2352 ), ( 0, 0, 0 ), undefined, undefined, "block_w", undefined, "blocks", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_locked_in_cs";
    s.groupid = "warning_blocks";
    s.name = "window";
    fe [[ f ]]( s, "LOCKED_IN_RESORTS", cf, ( 13056.3, 21659.8, 2352 ), ( 0, 0, 0 ), undefined, undefined, "block_w", undefined, "blocks", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_locked_in_cs";
    s.groupid = "warning_blocks";
    s.name = "window";
    fe [[ f ]]( s, "LOCKED_IN_RESORTS", cf, ( 13056.3, 21717.8, 2352 ), ( 0, 0, 0 ), undefined, undefined, "block_w", undefined, "blocks", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_locked_in_cs";
    s.groupid = "warning_blocks";
    s.name = "window";
    fe [[ f ]]( s, "LOCKED_IN_RESORTS", cf, ( 13056.3, 21784.8, 2352 ), ( 0, 0, 0 ), undefined, undefined, "block_w", undefined, "blocks", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_locked_in_cs";
    s.groupid = "warning_blocks";
    s.name = "window";
    fe [[ f ]]( s, "LOCKED_IN_RESORTS", cf, ( 12971, 21145.3, 2512 ), ( 0, 90, 0 ), undefined, undefined, "block_w", undefined, "blocks", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_locked_in_cs";
    s.groupid = "warning_blocks";
    s.name = "window";
    fe [[ f ]]( s, "LOCKED_IN_RESORTS", cf, ( 12917, 21145.3, 2512 ), ( 0, 90, 0 ), undefined, undefined, "block_w", undefined, "blocks", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_locked_in_cs";
    s.groupid = "warning_blocks";
    s.name = "window";
    fe [[ f ]]( s, "LOCKED_IN_RESORTS", cf, ( 13370, 20218, 2528 ), ( 0, 0, 0 ), undefined, undefined, "block_w", undefined, "blocks", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_locked_in_cs";
    s.groupid = "warning_blocks";
    s.name = "window";
    fe [[ f ]]( s, "LOCKED_IN_RESORTS", cf, ( 13370, 20102, 2528 ), ( 0, 0, 0 ), undefined, undefined, "block_w", undefined, "blocks", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_locked_in_cs";
    s.groupid = "warning_blocks";
    s.name = "window";
    fe [[ f ]]( s, "LOCKED_IN_RESORTS", cf, ( 11927.5, 20593.6, 2352 ), ( 0, 270, 0 ), undefined, undefined, "block_w", undefined, "blocks", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_locked_in_cs";
    s.groupid = "warning_blocks";
    s.name = "window";
    fe [[ f ]]( s, "LOCKED_IN_RESORTS", cf, ( 12376, 20276, 2224 ), ( 0, 90, 0 ), undefined, undefined, "block_w", undefined, "blocks", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_locked_in_cs";
    s.groupid = "participate_phase_reinforcement";
    s.ishelistruct = 1;
    s.script_accel = "350";
    fe [[ f ]]( s, "LOCKED_IN_RESORTS", cf, ( 14448.8, 20859.4, 3043.69 ), ( 0, 91.41, 0 ), "LOCKED_IN_RESORTS_PARTICIPATE", "LOCKED_IN_RESORTS_VTOL_2", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_locked_in_cs";
    s.groupid = "participate_phase_reinforcement";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "LOCKED_IN_RESORTS", cf, ( -728.52, 28743.2, 11032.2 ), ( 359.47, 8.21, 0.49 ), "LOCKED_IN_RESORTS_VTOL_3", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_locked_in_cs";
    s.groupid = "participate_phase_reinforcement";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "LOCKED_IN_RESORTS", cf, ( 4721.36, 10233.1, 9462.02 ), ( 0, 59.83, 0 ), undefined, "LOCKED_IN_RESORTS_VTOL_1", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150, 1 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_locked_in_cs";
    s.groupid = "participate_phase_reinforcement";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "LOCKED_IN_RESORTS", cf, ( 11911.7, 27266.8, 7362.27 ), ( 359.47, 8.21, 0.49 ), "LOCKED_IN_RESORTS_VTOL_2", "LOCKED_IN_RESORTS_VTOL_3", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_locked_in_cs";
    s.groupid = "participate_phase_reinforcement";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "LOCKED_IN_RESORTS", cf, ( 8801.47, 15235.9, 8384.52 ), ( 0, 332.95, 0 ), "LOCKED_IN_RESORTS_VTOL_1", "LOCKED_IN_RESORTS_PARTICIPATE", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_locked_in_cs";
    s.groupid = "warning_blocks";
    s.name = "window";
    fe [[ f ]]( s, "LOCKED_IN_RESORTS", cf, ( 12322, 20276, 2224 ), ( 0, 90, 0 ), undefined, undefined, "block_w", undefined, "blocks", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_locked_in_cs";
    s.name = "reward";
    fe [[ f ]]( s, "LOCKED_IN_RESORTS", cf, ( 12287.5, 21355.4, 2360 ), ( 0, 0, 0 ), undefined, undefined, "reward", undefined, "phase", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_locked_in_cs";
    s.groupid = "warning_blocks";
    s.name = "window";
    fe [[ f ]]( s, "LOCKED_IN_RESORTS", cf, ( 12446, 20276, 2224 ), ( 0, 90, 0 ), undefined, undefined, "block_w", undefined, "blocks", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_locked_in_cs";
    s.groupid = "warning_blocks";
    s.name = "window";
    fe [[ f ]]( s, "LOCKED_IN_RESORTS", cf, ( 11524.1, 20638.7, 2512 ), ( 0, 180, 0 ), undefined, undefined, "block_w", undefined, "blocks", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_locked_in_cs";
    s.groupid = "warning_blocks";
    s.name = "window";
    fe [[ f ]]( s, "LOCKED_IN_RESORTS", cf, ( 11524.1, 20698.7, 2512 ), ( 0, 180, 0 ), undefined, undefined, "block_w", undefined, "blocks", ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_sat_avalon_q2_ob_activity_locked_in_cs
// Params 0
// Checksum 0x6a012f15, Offset: 0x4679
// Size: 0xe8
function function_d9dd7965c51c95d1()
{
    activityinstances = [];
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_activity_definition_locked_in";
    var_881289d7987bc770.cf = "mp_sat_avalon_q2_ob_activity_locked_in_cs";
    var_881289d7987bc770.scriptstructorigin = ( 12576.2, 20920.4, 2520.05 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [ ( 12576.2, 20856.4, 2520.05 ) ];
    var_881289d7987bc770.var_31ce4477e3543d24 = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.locationradius = [ 3000 ];
    activityinstances[ "LOCKED_IN_RESORTS" ] = var_881289d7987bc770;
    return activityinstances;
}

