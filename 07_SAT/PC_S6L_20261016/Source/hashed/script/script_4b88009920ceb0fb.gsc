// script_4b88009920ceb0fb  (hash_4b88009920ceb0fb.gscc) (size: 10432 Bytes / 0x28c0 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x63a2a74a (1671604042)
// size ...... 10432 (0x28c0)
// includes .. 4   (offset: 0x23d4)
// strings ... 28  (offset: 0x23f4)
// dev strs .. 0   (offset: 0x28c0)
// exports ... 16  (offset: 0x1e34)
// cseg ...... 0x395 + 0x1a9f (0x1e34)
// imports ... 28  (offset: 0x20b4)
// animtree1 . 0   (offset: 0x28c0)
// animtree2 . 0   (offset: 0x28c0)
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace mp_sat_avalon_q3_ob_activity_prop_hunt_cs;

// Namespace mp_sat_avalon_q3_ob_activity_prop_hunt_cs
// Params 0, eflags: 0x5
// Checksum 0xd7601dbb, Offset: 0x3b3
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"mp_sat_avalon_q3_ob_activity_prop_hunt_cs", #"activity_common", &function_b39ecd3d51489472, undefined );
}

// Namespace mp_sat_avalon_q3_ob_activity_prop_hunt_cs
// Params 0, eflags: 0x4
// Checksum 0x69e60a35, Offset: 0x3dc
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace mp_sat_avalon_q3_ob_activity_prop_hunt_cs
// Params 0, eflags: 0x4
// Checksum 0x1022c394, Offset: 0x3ed
// Size: 0x15
function private structs_init()
{
    main();
    activity_common::function_e1df676808c1d1e3( &function_4cd78e661617f3 );
}

// Namespace mp_sat_avalon_q3_ob_activity_prop_hunt_cs
// Params 2
// Checksum 0x10364521, Offset: 0x40a
// Size: 0x70
function main( unused, unused2 )
{
    if ( utility::flag_exist( "mp_sat_avalon_q3_ob_activity_prop_hunt_cs" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "mp_sat_avalon_q3_ob_activity_prop_hunt_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "mp_sat_avalon_q3_ob_activity_prop_hunt_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace mp_sat_avalon_q3_ob_activity_prop_hunt_cs
// Params 3, eflags: 0x4
// Checksum 0x6f5f6d16, Offset: 0x482
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "mp_sat_avalon_q3_ob_activity_prop_hunt_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "mp_sat_avalon_q3_ob_activity_prop_hunt_cs" );
}

// Namespace mp_sat_avalon_q3_ob_activity_prop_hunt_cs
// Params 3, eflags: 0x4
// Checksum 0xe7d25758, Offset: 0x4fc
// Size: 0x40c
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_prop_hunt_cs";
    s.activity_bundle = "sat_ob_activitydefinition_prop_hunt_q3_fortress_wall";
    s.name = "PROP_HUNT_FORTRESS_WALL";
    fe [[ f ]]( s, "PROP_HUNT_FORTRESS_WALL", cf, ( -22411.6, -39630.5, 624 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_prop_hunt_cs";
    fe [[ f ]]( s, "PROP_HUNT_FORTRESS_WALL", cf, ( -22436.7, -39634.2, 624 ), ( 0, 0, 0 ), "activity_nexus_instance_joiner", "PROP_HUNT_FORTRESS_WALL", "PROP_HUNT_FORTRESS_WALL", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_prop_hunt_cs";
    s.activity_bundle = "sat_ob_activitydefinition_prop_hunt_q3_yacht";
    s.name = "PROP_HUNT_YACHT";
    fe [[ f ]]( s, "PROP_HUNT_YACHT", cf, ( -25054.1, -1584.39, 241.96 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_prop_hunt_cs";
    fe [[ f ]]( s, "PROP_HUNT_YACHT", cf, ( -25079.2, -1588.1, 241.95 ), ( 0, 0, 0 ), "activity_nexus_instance_joiner", "PROP_HUNT_YACHT", "PROP_HUNT_YACHT", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_prop_hunt_cs";
    s.activity_bundle = "sat_ob_activitydefinition_prop_hunt_q3_base_storage";
    s.name = "PROP_HUNT_BASE_STORAGE";
    fe [[ f ]]( s, "PROP_HUNT_BASE_STORAGE", cf, ( -40771.6, -36045.2, 1021.95 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_prop_hunt_cs";
    fe [[ f ]]( s, "PROP_HUNT_BASE_STORAGE", cf, ( -40796.7, -36048.9, 1019.45 ), ( 0, 0, 0 ), "activity_nexus_instance_joiner", "PROP_HUNT_BASE_STORAGE", "PROP_HUNT_BASE_STORAGE", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_prop_hunt_cs";
    s.activity_bundle = "sat_ob_activitydefinition_prop_hunt_q3_pit_stop";
    s.name = "PROP_HUNT_PIT_STOP";
    fe [[ f ]]( s, "PROP_HUNT_PIT_STOP", cf, ( -1284, -32750.7, 288.75 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_prop_hunt_cs";
    fe [[ f ]]( s, "PROP_HUNT_PIT_STOP", cf, ( -1309.1, -32754.4, 288.75 ), ( 0, 0, 0 ), "activity_nexus_instance_joiner", "PROP_HUNT_PIT_STOP", "PROP_HUNT_PIT_STOP", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace mp_sat_avalon_q3_ob_activity_prop_hunt_cs
// Params 0, eflags: 0x4
// Checksum 0xb74f2190, Offset: 0x910
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace mp_sat_avalon_q3_ob_activity_prop_hunt_cs
// Params 0
// Checksum 0xad0cb05b, Offset: 0x91a
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "mp_sat_avalon_q3_ob_activity_prop_hunt_cs" );
}

// Namespace mp_sat_avalon_q3_ob_activity_prop_hunt_cs
// Params 0
// Checksum 0xeb346c8c, Offset: 0x930
// Size: 0x66
function function_4cd78e661617f3()
{
    activityinfostruct = {};
    activityinfostruct.name = "REV_OB_PROP_HUNT";
    activityinfostruct.scriptbundle = "sat_ob_activitydefinition_prop_hunt";
    activityinfostruct.mainfunction = &main;
    activityinfostruct.var_934f068483ae4ddb = &function_d4323822d7042e5a;
    activityinfostruct.metadatafunction = &function_d9dd7965c51c95d1;
    return activityinfostruct;
}

// Namespace mp_sat_avalon_q3_ob_activity_prop_hunt_cs
// Params 4
// Checksum 0x5be3965f, Offset: 0x99f
// Size: 0xa5
function function_d4323822d7042e5a( var_4312b79c960726b6, fe, us, cf = "mp_sat_avalon_q3_ob_activity_prop_hunt_cs" )
{
    switch ( var_4312b79c960726b6 )
    {
        case #"hash_48f88797dbbfcd0c":
            function_731cac177e9983e4( fe, us, cf );
            break;
        case #"hash_8d11ea82df7ddaec":
            function_d860b5a3a6fac64( fe, us, cf );
            break;
        case #"hash_fe43e1a98df78192":
            function_4d277371989a5da( fe, us, cf );
            break;
        case #"hash_bb51267606311a3b":
            function_e383b00e4bec7253( fe, us, cf );
            break;
    }
}

// Namespace mp_sat_avalon_q3_ob_activity_prop_hunt_cs
// Params 3
// Checksum 0xf82b8aee, Offset: 0xa4c
// Size: 0x4e4
function function_731cac177e9983e4( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_prop_hunt_cs";
    s.groupid = "prop_1";
    s.name = "mysteryprop_1_enemy_struct";
    fe [[ f ]]( s, "PROP_HUNT_FORTRESS_WALL", cf, ( -23624.7, -39578.9, 784 ), ( 0, 286.7, 0 ), "mysteryprop_1_enemy_struct", "PROP_HUNT_FORTRESS_WALL", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_prop_hunt_cs";
    s.groupid = "prop_1";
    s.name = "mysteryprop_1_scriptable_struct";
    fe [[ f ]]( s, "PROP_HUNT_FORTRESS_WALL", cf, ( -23662.2, -39590.9, 784 ), ( 0, 14.5, 0 ), "mysteryprop_1_scriptable_struct", "PROP_HUNT_FORTRESS_WALL", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_prop_hunt_cs";
    s.groupid = "prop_1";
    s.name = "mysteryprop_1_chest_struct";
    fe [[ f ]]( s, "PROP_HUNT_FORTRESS_WALL", cf, ( -23624.7, -39578.9, 784 ), ( 0, 286.7, 0 ), "mysteryprop_1_chest_struct", "PROP_HUNT_FORTRESS_WALL", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_prop_hunt_cs";
    s.groupid = "prop_2";
    s.name = "mysteryprop_2_scriptable_struct";
    fe [[ f ]]( s, "PROP_HUNT_FORTRESS_WALL", cf, ( -22541.9, -39362.6, 840 ), ( 0, 165.5, 0 ), "mysteryprop_2_scriptable_struct", "PROP_HUNT_FORTRESS_WALL", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_prop_hunt_cs";
    s.groupid = "prop_3";
    s.name = "mysteryprop_3_scriptable_struct";
    fe [[ f ]]( s, "PROP_HUNT_FORTRESS_WALL", cf, ( -23219.6, -40007.3, 624 ), ( 0, 15.2, 0 ), "mysteryprop_3_scriptable_struct", "PROP_HUNT_FORTRESS_WALL", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_prop_hunt_cs";
    s.groupid = "prop_2";
    s.name = "mysteryprop_2_enemy_struct";
    fe [[ f ]]( s, "PROP_HUNT_FORTRESS_WALL", cf, ( -22578.2, -39356.5, 840 ), ( 0, 78.1, 0 ), "mysteryprop_2_enemy_struct", "PROP_HUNT_FORTRESS_WALL", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_prop_hunt_cs";
    s.groupid = "prop_2";
    s.name = "mysteryprop_2_chest_struct";
    fe [[ f ]]( s, "PROP_HUNT_FORTRESS_WALL", cf, ( -22578.2, -39356.5, 840 ), ( 0, 78.1, 0 ), "mysteryprop_2_chest_struct", "PROP_HUNT_FORTRESS_WALL", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_prop_hunt_cs";
    s.groupid = "prop_3";
    s.name = "mysteryprop_3_enemy_struct";
    fe [[ f ]]( s, "PROP_HUNT_FORTRESS_WALL", cf, ( -23184.1, -39982.7, 624 ), ( 0, 287.2, 0 ), "mysteryprop_3_enemy_struct", "PROP_HUNT_FORTRESS_WALL", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_prop_hunt_cs";
    s.groupid = "prop_3";
    s.name = "mysteryprop_3_chest_struct";
    fe [[ f ]]( s, "PROP_HUNT_FORTRESS_WALL", cf, ( -23184.1, -39982.7, 624 ), ( 0, 287.2, 0 ), "mysteryprop_3_chest_struct", "PROP_HUNT_FORTRESS_WALL", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_sat_avalon_q3_ob_activity_prop_hunt_cs
// Params 3
// Checksum 0x5e7c811e, Offset: 0xf38
// Size: 0x4e4
function function_d860b5a3a6fac64( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_prop_hunt_cs";
    s.groupid = "prop_1";
    s.name = "mysteryprop_1_enemy_struct";
    fe [[ f ]]( s, "PROP_HUNT_YACHT", cf, ( -25381.3, -980.41, 241 ), ( 0, 216.7, 0 ), "mysteryprop_1_enemy_struct", "PROP_HUNT_YACHT", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_prop_hunt_cs";
    s.groupid = "prop_1";
    s.name = "mysteryprop_1_scriptable_struct";
    fe [[ f ]]( s, "PROP_HUNT_YACHT", cf, ( -25398.1, -964.58, 241 ), ( 0, 299.5, 0 ), "mysteryprop_1_scriptable_struct", "PROP_HUNT_YACHT", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_prop_hunt_cs";
    s.groupid = "prop_1";
    s.name = "mysteryprop_1_chest_struct";
    fe [[ f ]]( s, "PROP_HUNT_YACHT", cf, ( -25381.3, -980.41, 241 ), ( 0, 216.7, 0 ), "mysteryprop_1_chest_struct", "PROP_HUNT_YACHT", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_prop_hunt_cs";
    s.groupid = "prop_2";
    s.name = "mysteryprop_2_scriptable_struct";
    fe [[ f ]]( s, "PROP_HUNT_YACHT", cf, ( -25334.3, -1578.75, 241 ), ( 0, 35.5, 0 ), "mysteryprop_2_scriptable_struct", "PROP_HUNT_YACHT", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_prop_hunt_cs";
    s.groupid = "prop_3";
    s.name = "mysteryprop_3_scriptable_struct";
    fe [[ f ]]( s, "PROP_HUNT_YACHT", cf, ( -25551.6, -1095.79, 241 ), ( 0, 295.2, 0 ), "mysteryprop_3_scriptable_struct", "PROP_HUNT_YACHT", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_prop_hunt_cs";
    s.groupid = "prop_2";
    s.name = "mysteryprop_2_enemy_struct";
    fe [[ f ]]( s, "PROP_HUNT_YACHT", cf, ( -25318.8, -1572.25, 241 ), ( 0, 303.1, 0 ), "mysteryprop_2_enemy_struct", "PROP_HUNT_YACHT", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_prop_hunt_cs";
    s.groupid = "prop_2";
    s.name = "mysteryprop_2_chest_struct";
    fe [[ f ]]( s, "PROP_HUNT_YACHT", cf, ( -25318.8, -1572.25, 241 ), ( 0, 303.1, 0 ), "mysteryprop_2_chest_struct", "PROP_HUNT_YACHT", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_prop_hunt_cs";
    s.groupid = "prop_3";
    s.name = "mysteryprop_3_enemy_struct";
    fe [[ f ]]( s, "PROP_HUNT_YACHT", cf, ( -25541.6, -1111.8, 241 ), ( 0, 217.2, 0 ), "mysteryprop_3_enemy_struct", "PROP_HUNT_YACHT", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_prop_hunt_cs";
    s.groupid = "prop_3";
    s.name = "mysteryprop_3_chest_struct";
    fe [[ f ]]( s, "PROP_HUNT_YACHT", cf, ( -25541.6, -1111.8, 241 ), ( 0, 217.2, 0 ), "mysteryprop_3_chest_struct", "PROP_HUNT_YACHT", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_sat_avalon_q3_ob_activity_prop_hunt_cs
// Params 3
// Checksum 0x23088e43, Offset: 0x1424
// Size: 0x4e4
function function_4d277371989a5da( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_prop_hunt_cs";
    s.groupid = "prop_1";
    s.name = "mysteryprop_1_enemy_struct";
    fe [[ f ]]( s, "PROP_HUNT_BASE_STORAGE", cf, ( -39398.2, -36113.2, 1020.4 ), ( 0, 94.7, 0 ), "mysteryprop_1_enemy_struct", "PROP_HUNT_BASE_STORAGE", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_prop_hunt_cs";
    s.groupid = "prop_1";
    s.name = "mysteryprop_1_scriptable_struct";
    fe [[ f ]]( s, "PROP_HUNT_BASE_STORAGE", cf, ( -39371.6, -36113.5, 1020.41 ), ( 0, 176.29, 0 ), "mysteryprop_1_scriptable_struct", "PROP_HUNT_BASE_STORAGE", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_prop_hunt_cs";
    s.groupid = "prop_1";
    s.name = "mysteryprop_1_chest_struct";
    fe [[ f ]]( s, "PROP_HUNT_BASE_STORAGE", cf, ( -39398.2, -36113.2, 1020.4 ), ( 0, 94.7, 0 ), "mysteryprop_1_chest_struct", "PROP_HUNT_BASE_STORAGE", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_prop_hunt_cs";
    s.groupid = "prop_2";
    s.name = "mysteryprop_2_scriptable_struct";
    fe [[ f ]]( s, "PROP_HUNT_BASE_STORAGE", cf, ( -39893.1, -35734.2, 1129.72 ), ( 0, 220.5, 0 ), "mysteryprop_2_scriptable_struct", "PROP_HUNT_BASE_STORAGE", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_prop_hunt_cs";
    s.groupid = "prop_3";
    s.name = "mysteryprop_3_scriptable_struct";
    fe [[ f ]]( s, "PROP_HUNT_BASE_STORAGE", cf, ( -40121.2, -36701, 1069.94 ), ( 0, 186.19, 0 ), "mysteryprop_3_scriptable_struct", "PROP_HUNT_BASE_STORAGE", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_prop_hunt_cs";
    s.groupid = "prop_2";
    s.name = "mysteryprop_2_enemy_struct";
    fe [[ f ]]( s, "PROP_HUNT_BASE_STORAGE", cf, ( -39912.5, -35731.2, 1128.91 ), ( 0, 88.1, 0 ), "mysteryprop_2_enemy_struct", "PROP_HUNT_BASE_STORAGE", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_prop_hunt_cs";
    s.groupid = "prop_2";
    s.name = "mysteryprop_2_chest_struct";
    fe [[ f ]]( s, "PROP_HUNT_BASE_STORAGE", cf, ( -39912.5, -35731.2, 1128.91 ), ( 0, 88.1, 0 ), "mysteryprop_2_chest_struct", "PROP_HUNT_BASE_STORAGE", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_prop_hunt_cs";
    s.groupid = "prop_3";
    s.name = "mysteryprop_3_enemy_struct";
    fe [[ f ]]( s, "PROP_HUNT_BASE_STORAGE", cf, ( -40139.8, -36701.8, 1069.08 ), ( 0, 92.2, 0 ), "mysteryprop_3_enemy_struct", "PROP_HUNT_BASE_STORAGE", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_prop_hunt_cs";
    s.groupid = "prop_3";
    s.name = "mysteryprop_3_chest_struct";
    fe [[ f ]]( s, "PROP_HUNT_BASE_STORAGE", cf, ( -40139.8, -36701.8, 1069.08 ), ( 0, 92.2, 0 ), "mysteryprop_3_chest_struct", "PROP_HUNT_BASE_STORAGE", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_sat_avalon_q3_ob_activity_prop_hunt_cs
// Params 3
// Checksum 0x1331e4c8, Offset: 0x1910
// Size: 0x1c6
function function_e383b00e4bec7253( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_prop_hunt_cs";
    s.groupid = "prop_1";
    s.name = "mysteryprop_1_scriptable_struct";
    fe [[ f ]]( s, "PROP_HUNT_PIT_STOP", cf, ( -1102.85, -33185.1, 288.75 ), ( 0, 104.5, 0 ), "mysteryprop_1_scriptable_struct", "PROP_HUNT_PIT_STOP", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_prop_hunt_cs";
    s.groupid = "prop_2";
    s.name = "mysteryprop_2_scriptable_struct";
    fe [[ f ]]( s, "PROP_HUNT_PIT_STOP", cf, ( -1414.75, -32365.3, 288.75 ), ( 0, 275.5, 0 ), "mysteryprop_2_scriptable_struct", "PROP_HUNT_PIT_STOP", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_prop_hunt_cs";
    s.groupid = "prop_3";
    s.name = "mysteryprop_3_scriptable_struct";
    fe [[ f ]]( s, "PROP_HUNT_PIT_STOP", cf, ( -1813.39, -32574.3, 296 ), ( 0, 15.2, 0 ), "mysteryprop_3_scriptable_struct", "PROP_HUNT_PIT_STOP", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_sat_avalon_q3_ob_activity_prop_hunt_cs
// Params 0
// Checksum 0xd73d932a, Offset: 0x1ade
// Size: 0x355
function function_d9dd7965c51c95d1()
{
    activityinstances = [];
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_ob_activitydefinition_prop_hunt_q3_fortress_wall";
    var_881289d7987bc770.cf = "mp_sat_avalon_q3_ob_activity_prop_hunt_cs";
    var_881289d7987bc770.scriptstructorigin = ( -22411.6, -39630.5, 624 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [ ( -22442.4, -39662.4, 624 ) ];
    var_881289d7987bc770.var_31ce4477e3543d24 = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.locationradius = [ 1500 ];
    activityinstances[ "PROP_HUNT_FORTRESS_WALL" ] = var_881289d7987bc770;
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_ob_activitydefinition_prop_hunt_q3_yacht";
    var_881289d7987bc770.cf = "mp_sat_avalon_q3_ob_activity_prop_hunt_cs";
    var_881289d7987bc770.scriptstructorigin = ( -25054.1, -1584.39, 241.96 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [ ( -25084.9, -1616.36, 241.96 ) ];
    var_881289d7987bc770.var_31ce4477e3543d24 = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.locationradius = [ 1500 ];
    activityinstances[ "PROP_HUNT_YACHT" ] = var_881289d7987bc770;
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_ob_activitydefinition_prop_hunt_q3_base_storage";
    var_881289d7987bc770.cf = "mp_sat_avalon_q3_ob_activity_prop_hunt_cs";
    var_881289d7987bc770.scriptstructorigin = ( -40771.6, -36045.2, 1021.95 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [ ( -40802.4, -36077.1, 1018.49 ) ];
    var_881289d7987bc770.var_31ce4477e3543d24 = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.locationradius = [ 1500 ];
    activityinstances[ "PROP_HUNT_BASE_STORAGE" ] = var_881289d7987bc770;
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_ob_activitydefinition_prop_hunt_q3_pit_stop";
    var_881289d7987bc770.cf = "mp_sat_avalon_q3_ob_activity_prop_hunt_cs";
    var_881289d7987bc770.scriptstructorigin = ( -1284, -32750.7, 288.75 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [ ( -1314.8, -32782.6, 288.75 ) ];
    var_881289d7987bc770.var_31ce4477e3543d24 = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.locationradius = [ 1500 ];
    activityinstances[ "PROP_HUNT_PIT_STOP" ] = var_881289d7987bc770;
    return activityinstances;
}

