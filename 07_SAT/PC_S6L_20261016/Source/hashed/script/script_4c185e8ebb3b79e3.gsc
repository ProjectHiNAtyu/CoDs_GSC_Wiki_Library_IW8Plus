// script_4c185e8ebb3b79e3  (hash_4c185e8ebb3b79e3.gscc) (size: 8192 Bytes / 0x2000 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x10ea37b (17736571)
// size ...... 8192 (0x2000)
// includes .. 4   (offset: 0x1c44)
// strings ... 26  (offset: 0x1c64)
// dev strs .. 0   (offset: 0x2000)
// exports ... 15  (offset: 0x16ec)
// cseg ...... 0x345 + 0x13a7 (0x16ec)
// imports ... 27  (offset: 0x1944)
// animtree1 . 0   (offset: 0x2000)
// animtree2 . 0   (offset: 0x2000)
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace mp_sat_avalon_q1_ob_activity_prop_hunt_cs;

// Namespace mp_sat_avalon_q1_ob_activity_prop_hunt_cs
// Params 0, eflags: 0x5
// Checksum 0xd4999c0c, Offset: 0x363
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"mp_sat_avalon_q1_ob_activity_prop_hunt_cs", #"activity_common", &function_b39ecd3d51489472, undefined );
}

// Namespace mp_sat_avalon_q1_ob_activity_prop_hunt_cs
// Params 0, eflags: 0x4
// Checksum 0x58cd5094, Offset: 0x38c
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace mp_sat_avalon_q1_ob_activity_prop_hunt_cs
// Params 0, eflags: 0x4
// Checksum 0x3443d25a, Offset: 0x39d
// Size: 0x15
function private structs_init()
{
    main();
    activity_common::function_e1df676808c1d1e3( &function_4cd78e661617f3 );
}

// Namespace mp_sat_avalon_q1_ob_activity_prop_hunt_cs
// Params 2
// Checksum 0x345754ef, Offset: 0x3ba
// Size: 0x70
function main( unused, unused2 )
{
    if ( utility::flag_exist( "mp_sat_avalon_q1_ob_activity_prop_hunt_cs" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "mp_sat_avalon_q1_ob_activity_prop_hunt_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "mp_sat_avalon_q1_ob_activity_prop_hunt_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace mp_sat_avalon_q1_ob_activity_prop_hunt_cs
// Params 3, eflags: 0x4
// Checksum 0x5e7437b7, Offset: 0x432
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "mp_sat_avalon_q1_ob_activity_prop_hunt_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "mp_sat_avalon_q1_ob_activity_prop_hunt_cs" );
}

// Namespace mp_sat_avalon_q1_ob_activity_prop_hunt_cs
// Params 3, eflags: 0x4
// Checksum 0xaa3684b2, Offset: 0x4ac
// Size: 0x31c
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_prop_hunt_cs";
    s.activity_bundle = "sat_ob_activitydefinition_prop_hunt_q1_golf";
    s.name = "PROP_HUNT_Q1_GOLF";
    fe [[ f ]]( s, "PROP_HUNT_Q1_GOLF", cf, ( -29335.9, 34694.5, 1731.94 ), ( 0, 90, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_prop_hunt_cs";
    fe [[ f ]]( s, "PROP_HUNT_Q1_GOLF", cf, ( -29335.9, 34694.5, 1731.94 ), ( 0, 90, 0 ), "activity_nexus_instance_joiner", "PROP_HUNT_Q1_GOLF", "PROP_HUNT_Q1_GOLF", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_prop_hunt_cs";
    s.activity_bundle = "sat_ob_activitydefinition_prop_hunt_q1_living_room";
    s.name = "PROP_HUNT_Q1_LIVING_ROOM";
    fe [[ f ]]( s, "PROP_HUNT_Q1_LIVING_ROOM", cf, ( -33590.3, 23884.5, 1758 ), ( 0, 90, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_prop_hunt_cs";
    fe [[ f ]]( s, "PROP_HUNT_Q1_LIVING_ROOM", cf, ( -33590.3, 23884.5, 1758 ), ( 0, 90, 0 ), "activity_nexus_instance_joiner", "PROP_HUNT_Q1_LIVING_ROOM", "PROP_HUNT_Q1_LIVING_ROOM", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_prop_hunt_cs";
    s.activity_bundle = "sat_ob_activitydefinition_prop_hunt_q1_stadium";
    s.name = "PROP_HUNT_Q1_STADIUM";
    fe [[ f ]]( s, "PROP_HUNT_Q1_STADIUM", cf, ( -36865.4, 8609.54, 416 ), ( 0, 90, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_prop_hunt_cs";
    fe [[ f ]]( s, "PROP_HUNT_Q1_STADIUM", cf, ( -36853.9, 8630.99, 416 ), ( 0, 90, 0 ), "activity_nexus_instance_joiner", "PROP_HUNT_Q1_STADIUM", "PROP_HUNT_Q1_STADIUM", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace mp_sat_avalon_q1_ob_activity_prop_hunt_cs
// Params 0, eflags: 0x4
// Checksum 0x932e305e, Offset: 0x7d0
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace mp_sat_avalon_q1_ob_activity_prop_hunt_cs
// Params 0
// Checksum 0x9c27eafa, Offset: 0x7da
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "mp_sat_avalon_q1_ob_activity_prop_hunt_cs" );
}

// Namespace mp_sat_avalon_q1_ob_activity_prop_hunt_cs
// Params 0
// Checksum 0xda1f362d, Offset: 0x7f0
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

// Namespace mp_sat_avalon_q1_ob_activity_prop_hunt_cs
// Params 4
// Checksum 0x6fc9eee2, Offset: 0x85f
// Size: 0x8b
function function_d4323822d7042e5a( var_4312b79c960726b6, fe, us, cf = "mp_sat_avalon_q1_ob_activity_prop_hunt_cs" )
{
    switch ( var_4312b79c960726b6 )
    {
        case #"hash_5149d250e8349964":
            function_635c7ed5e94f61ac( fe, us, cf );
            break;
        case #"hash_708c2c5e894613b1":
            function_3f89d3ba5d8998e9( fe, us, cf );
            break;
        case #"hash_4314a1cef3941e3f":
            function_f7b321ea8e98a477( fe, us, cf );
            break;
    }
}

// Namespace mp_sat_avalon_q1_ob_activity_prop_hunt_cs
// Params 3
// Checksum 0x556d4f17, Offset: 0x8f2
// Size: 0x4e4
function function_635c7ed5e94f61ac( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_prop_hunt_cs";
    s.groupid = "prop_1";
    s.name = "mysteryprop_1_scriptable_struct";
    fe [[ f ]]( s, "PROP_HUNT_Q1_GOLF", cf, ( -29847.6, 35278.9, 1817.8 ), ( 0, 331.4, 0 ), "mysteryprop_1_scriptable_struct", "PROP_HUNT_Q1_GOLF", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_prop_hunt_cs";
    s.groupid = "prop_2";
    s.name = "mysteryprop_2_scriptable_struct";
    fe [[ f ]]( s, "PROP_HUNT_Q1_GOLF", cf, ( -28914.6, 34539, 1666.57 ), ( 0, 146.9, 0 ), "mysteryprop_2_scriptable_struct", "PROP_HUNT_Q1_GOLF", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_prop_hunt_cs";
    s.groupid = "prop_3";
    s.name = "mysteryprop_3_scriptable_struct";
    fe [[ f ]]( s, "PROP_HUNT_Q1_GOLF", cf, ( -29276.9, 35336.1, 1777.35 ), ( 0, 268.2, 0 ), "mysteryprop_3_scriptable_struct", "PROP_HUNT_Q1_GOLF", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_prop_hunt_cs";
    s.groupid = "prop_1";
    s.name = "mysteryprop_1_enemy_struct";
    fe [[ f ]]( s, "PROP_HUNT_Q1_GOLF", cf, ( -29822.3, 35287.5, 1816.98 ), ( 0, 248.4, 0 ), "mysteryprop_1_enemy_struct", "PROP_HUNT_Q1_GOLF", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_prop_hunt_cs";
    s.groupid = "prop_1";
    s.name = "mysteryprop_1_chest_struct";
    fe [[ f ]]( s, "PROP_HUNT_Q1_GOLF", cf, ( -29815.8, 35286, 1816.71 ), ( 0, 248.4, 0 ), "mysteryprop_1_chest_struct", "PROP_HUNT_Q1_GOLF", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_prop_hunt_cs";
    s.groupid = "prop_2";
    s.name = "mysteryprop_2_enemy_struct";
    fe [[ f ]]( s, "PROP_HUNT_Q1_GOLF", cf, ( -28936.9, 34560.1, 1669.68 ), ( 0, 57.3, 0 ), "mysteryprop_2_enemy_struct", "PROP_HUNT_Q1_GOLF", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_prop_hunt_cs";
    s.groupid = "prop_3";
    s.name = "mysteryprop_3_chest_struct";
    fe [[ f ]]( s, "PROP_HUNT_Q1_GOLF", cf, ( -29253.1, 35311.8, 1776.94 ), ( 0, 185.7, 0 ), "mysteryprop_3_chest_struct", "PROP_HUNT_Q1_GOLF", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_prop_hunt_cs";
    s.groupid = "prop_3";
    s.name = "mysteryprop_3_enemy_struct";
    fe [[ f ]]( s, "PROP_HUNT_Q1_GOLF", cf, ( -29253, 35311.6, 1776.95 ), ( 0, 185.7, 0 ), "mysteryprop_3_enemy_struct", "PROP_HUNT_Q1_GOLF", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_prop_hunt_cs";
    s.groupid = "prop_2";
    s.name = "mysteryprop_2_chest_struct";
    fe [[ f ]]( s, "PROP_HUNT_Q1_GOLF", cf, ( -28936.8, 34560.6, 1669.67 ), ( 0, 57.3, 0 ), "mysteryprop_2_chest_struct", "PROP_HUNT_Q1_GOLF", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_sat_avalon_q1_ob_activity_prop_hunt_cs
// Params 3
// Checksum 0xdc4dcd90, Offset: 0xdde
// Size: 0x4e4
function function_3f89d3ba5d8998e9( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_prop_hunt_cs";
    s.groupid = "prop_1";
    s.name = "mysteryprop_1_enemy_struct";
    fe [[ f ]]( s, "PROP_HUNT_Q1_LIVING_ROOM", cf, ( -33758.4, 23757.1, 1758.01 ), ( 0, 3.7, 0 ), "mysteryprop_1_enemy_struct", "PROP_HUNT_Q1_LIVING_ROOM", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_prop_hunt_cs";
    s.groupid = "prop_1";
    s.name = "mysteryprop_1_scriptable_struct";
    fe [[ f ]]( s, "PROP_HUNT_Q1_LIVING_ROOM", cf, ( -33756.1, 23750, 1758.01 ), ( 351.17, 98.47, 87.07 ), "mysteryprop_1_scriptable_struct", "PROP_HUNT_Q1_LIVING_ROOM", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_prop_hunt_cs";
    s.groupid = "prop_1";
    s.name = "mysteryprop_1_chest_struct";
    fe [[ f ]]( s, "PROP_HUNT_Q1_LIVING_ROOM", cf, ( -33758.4, 23757.1, 1758.01 ), ( 0, 3.7, 0 ), "mysteryprop_1_chest_struct", "PROP_HUNT_Q1_LIVING_ROOM", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_prop_hunt_cs";
    s.groupid = "prop_2";
    s.name = "mysteryprop_2_scriptable_struct";
    fe [[ f ]]( s, "PROP_HUNT_Q1_LIVING_ROOM", cf, ( -33271.3, 23735.5, 1757.2 ), ( 356.71, 183.91, 92.06 ), "mysteryprop_2_scriptable_struct", "PROP_HUNT_Q1_LIVING_ROOM", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_prop_hunt_cs";
    s.groupid = "prop_3";
    s.name = "mysteryprop_3_scriptable_struct";
    fe [[ f ]]( s, "PROP_HUNT_Q1_LIVING_ROOM", cf, ( -33731.4, 23728.6, 1777.22 ), ( 341.98, 96.74, 89.68 ), "mysteryprop_3_scriptable_struct", "PROP_HUNT_Q1_LIVING_ROOM", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_prop_hunt_cs";
    s.groupid = "prop_2";
    s.name = "mysteryprop_2_enemy_struct";
    fe [[ f ]]( s, "PROP_HUNT_Q1_LIVING_ROOM", cf, ( -33277.4, 23729.1, 1759.21 ), ( 0, 98.15, 0 ), "mysteryprop_2_enemy_struct", "PROP_HUNT_Q1_LIVING_ROOM", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_prop_hunt_cs";
    s.groupid = "prop_2";
    s.name = "mysteryprop_2_chest_struct";
    fe [[ f ]]( s, "PROP_HUNT_Q1_LIVING_ROOM", cf, ( -33277.4, 23729.1, 1759.21 ), ( 0, 98.15, 0 ), "mysteryprop_2_chest_struct", "PROP_HUNT_Q1_LIVING_ROOM", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_prop_hunt_cs";
    s.groupid = "prop_3";
    s.name = "mysteryprop_3_enemy_struct";
    fe [[ f ]]( s, "PROP_HUNT_Q1_LIVING_ROOM", cf, ( -33736.2, 23757.7, 1759.11 ), ( 0, 9.2, 0 ), "mysteryprop_3_enemy_struct", "PROP_HUNT_Q1_LIVING_ROOM", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_prop_hunt_cs";
    s.groupid = "prop_3";
    s.name = "mysteryprop_3_chest_struct";
    fe [[ f ]]( s, "PROP_HUNT_Q1_LIVING_ROOM", cf, ( -33736.2, 23757.7, 1759.11 ), ( 0, 9.2, 0 ), "mysteryprop_3_chest_struct", "PROP_HUNT_Q1_LIVING_ROOM", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_sat_avalon_q1_ob_activity_prop_hunt_cs
// Params 3
// Checksum 0x2a16f4b1, Offset: 0x12ca
// Size: 0x193
function function_f7b321ea8e98a477( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_prop_hunt_cs";
    s.name = "mysteryprop_1_scriptable_struct";
    fe [[ f ]]( s, "PROP_HUNT_Q1_STADIUM", cf, ( -37311.8, 8872.25, 416 ), ( 0, 264.4, 0 ), "mysteryprop_1_scriptable_struct", "PROP_HUNT_Q1_STADIUM", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_prop_hunt_cs";
    s.name = "mysteryprop_2_scriptable_struct";
    fe [[ f ]]( s, "PROP_HUNT_Q1_STADIUM", cf, ( -36954.6, 8663.2, 416 ), ( 0, 357.6, 0 ), "mysteryprop_2_scriptable_struct", "PROP_HUNT_Q1_STADIUM", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_prop_hunt_cs";
    s.name = "mysteryprop_3_scriptable_struct";
    fe [[ f ]]( s, "PROP_HUNT_Q1_STADIUM", cf, ( -36638.6, 9021.5, 448 ), ( 0, 315.64, 0 ), "mysteryprop_3_scriptable_struct", "PROP_HUNT_Q1_STADIUM", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_sat_avalon_q1_ob_activity_prop_hunt_cs
// Params 0
// Checksum 0x1fd7eb24, Offset: 0x1465
// Size: 0x286
function function_d9dd7965c51c95d1()
{
    activityinstances = [];
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_ob_activitydefinition_prop_hunt_q1_golf";
    var_881289d7987bc770.cf = "mp_sat_avalon_q1_ob_activity_prop_hunt_cs";
    var_881289d7987bc770.scriptstructorigin = ( -29335.9, 34694.5, 1731.94 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [ ( -29373.1, 34661.8, 1733.07 ) ];
    var_881289d7987bc770.var_31ce4477e3543d24 = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.locationradius = [ 1000 ];
    activityinstances[ "PROP_HUNT_Q1_GOLF" ] = var_881289d7987bc770;
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_ob_activitydefinition_prop_hunt_q1_living_room";
    var_881289d7987bc770.cf = "mp_sat_avalon_q1_ob_activity_prop_hunt_cs";
    var_881289d7987bc770.scriptstructorigin = ( -33590.3, 23884.5, 1758 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [ ( -33590.3, 23884.5, 1758 ) ];
    var_881289d7987bc770.var_31ce4477e3543d24 = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.locationradius = [ 1000 ];
    activityinstances[ "PROP_HUNT_Q1_LIVING_ROOM" ] = var_881289d7987bc770;
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_ob_activitydefinition_prop_hunt_q1_stadium";
    var_881289d7987bc770.cf = "mp_sat_avalon_q1_ob_activity_prop_hunt_cs";
    var_881289d7987bc770.scriptstructorigin = ( -36865.4, 8609.54, 416 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [ ( -36849.4, 8604.2, 416 ) ];
    var_881289d7987bc770.var_31ce4477e3543d24 = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.locationradius = [ 1000 ];
    activityinstances[ "PROP_HUNT_Q1_STADIUM" ] = var_881289d7987bc770;
    return activityinstances;
}

