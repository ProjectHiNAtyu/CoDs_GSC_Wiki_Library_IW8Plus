// script_79e89624a7d2db6a  (hash_79e89624a7d2db6a.gscc) (size: 5846 Bytes / 0x16d6 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x94f6b51f (2499196191)
// size ...... 5846 (0x16d6)
// includes .. 4   (offset: 0x1456)
// strings ... 25  (offset: 0x1476)
// dev strs .. 0   (offset: 0x16d6)
// exports ... 13  (offset: 0xf72)
// cseg ...... 0x2fe + 0xc74 (0xf72)
// imports ... 26  (offset: 0x117a)
// animtree1 . 0   (offset: 0x16d6)
// animtree2 . 0   (offset: 0x16d6)
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace mp_sat_avalon_q2_ob_aquarius_sam_launch_cs;

// Namespace mp_sat_avalon_q2_ob_aquarius_sam_launch_cs
// Params 0, eflags: 0x5
// Checksum 0xfc35d53b, Offset: 0x31c
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"mp_sat_avalon_q2_ob_aquarius_sam_launch_cs", #"activity_common", &function_b39ecd3d51489472, undefined );
}

// Namespace mp_sat_avalon_q2_ob_aquarius_sam_launch_cs
// Params 0, eflags: 0x4
// Checksum 0x3b38b4ec, Offset: 0x345
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace mp_sat_avalon_q2_ob_aquarius_sam_launch_cs
// Params 0, eflags: 0x4
// Checksum 0xbe036700, Offset: 0x356
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace mp_sat_avalon_q2_ob_aquarius_sam_launch_cs
// Params 2
// Checksum 0xc1924cfe, Offset: 0x367
// Size: 0x8c
function main( unused, unused2 )
{
    if ( utility::flag_exist( "mp_sat_avalon_q2_ob_aquarius_sam_launch_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "mp_sat_avalon_q2_ob_aquarius_sam_launch_cs" ) )
    {
        return;
    }
    
    activity_common::function_e1df676808c1d1e3( &function_4cd78e661617f3 );
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "mp_sat_avalon_q2_ob_aquarius_sam_launch_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "mp_sat_avalon_q2_ob_aquarius_sam_launch_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace mp_sat_avalon_q2_ob_aquarius_sam_launch_cs
// Params 3, eflags: 0x4
// Checksum 0x3d81d3cf, Offset: 0x3fb
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "mp_sat_avalon_q2_ob_aquarius_sam_launch_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "mp_sat_avalon_q2_ob_aquarius_sam_launch_cs" );
}

// Namespace mp_sat_avalon_q2_ob_aquarius_sam_launch_cs
// Params 3, eflags: 0x4
// Checksum 0xbbf0a210, Offset: 0x475
// Size: 0xff
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_aquarius_sam_launch_cs";
    s.activity_bundle = "sat_activitydef_contract_aquarius_drone";
    s.name = "REV_OB_AQUARIUS_DRONE";
    fe [[ f ]]( s, "REV_OB_AQUARIUS_DRONE", cf, ( 18478.3, 47000.7, 858.35 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_aquarius_sam_launch_cs";
    fe [[ f ]]( s, "REV_OB_AQUARIUS_DRONE", cf, ( 18478.3, 47395.7, 858.35 ), ( 360, 131.9, -0 ), "activity_nexus_instance_joiner", undefined, undefined, undefined, "activity_link" );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace mp_sat_avalon_q2_ob_aquarius_sam_launch_cs
// Params 0, eflags: 0x4
// Checksum 0xd616f8b3, Offset: 0x57c
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace mp_sat_avalon_q2_ob_aquarius_sam_launch_cs
// Params 0
// Checksum 0xffd20e82, Offset: 0x586
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "mp_sat_avalon_q2_ob_aquarius_sam_launch_cs" );
}

// Namespace mp_sat_avalon_q2_ob_aquarius_sam_launch_cs
// Params 0
// Checksum 0x2bf70423, Offset: 0x59c
// Size: 0x44
function function_4cd78e661617f3()
{
    activityinfostruct = {};
    activityinfostruct.mainfunction = &main;
    activityinfostruct.var_934f068483ae4ddb = &function_d4323822d7042e5a;
    activityinfostruct.metadatafunction = &function_d9dd7965c51c95d1;
    return activityinfostruct;
}

// Namespace mp_sat_avalon_q2_ob_aquarius_sam_launch_cs
// Params 4
// Checksum 0x19f86929, Offset: 0x5e9
// Size: 0x57
function function_d4323822d7042e5a( var_4312b79c960726b6, fe, us, cf = "mp_sat_avalon_q2_ob_aquarius_sam_launch_cs" )
{
    switch ( var_4312b79c960726b6 )
    {
        case #"hash_df6aed43dfa1ca67":
            function_ec06afd7cb383f5f( fe, us, cf );
            break;
    }
}

// Namespace mp_sat_avalon_q2_ob_aquarius_sam_launch_cs
// Params 3
// Checksum 0x69e09565, Offset: 0x648
// Size: 0x873
function function_ec06afd7cb383f5f( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_aquarius_sam_launch_cs";
    fe [[ f ]]( s, "REV_OB_AQUARIUS_DRONE", cf, ( 48257.4, 29066.2, 905.27 ), ( 359.7, 94, 0.57 ), "aqua_swat_teleport_locs" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_aquarius_sam_launch_cs";
    fe [[ f ]]( s, "REV_OB_AQUARIUS_DRONE", cf, ( 48091.5, 29030.6, 906.94 ), ( 0, 94, 0.58 ), "aqua_swat_teleport_locs" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_aquarius_sam_launch_cs";
    fe [[ f ]]( s, "REV_OB_AQUARIUS_DRONE", cf, ( 48436.3, 29030.7, 902.76 ), ( 359.6, 93.99, 0.85 ), "aqua_swat_teleport_locs" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_aquarius_sam_launch_cs";
    fe [[ f ]]( s, "REV_OB_AQUARIUS_DRONE", cf, ( 47931.9, 29019.5, 907 ), ( 0.01, 94, -0.01 ), "aqua_swat_teleport_locs" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_aquarius_sam_launch_cs";
    fe [[ f ]]( s, "REV_OB_AQUARIUS_DRONE", cf, ( 48619.3, 29051.5, 899.57 ), ( 359.52, 93.99, 1.17 ), "aqua_swat_teleport_locs" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_aquarius_sam_launch_cs";
    fe [[ f ]]( s, "REV_OB_AQUARIUS_DRONE", cf, ( 47689.1, 29050.6, 907.02 ), ( 359.87, 94, -0.04 ), "aqua_swat_teleport_locs" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_aquarius_sam_launch_cs";
    s.name = "cache";
    fe [[ f ]]( s, "REV_OB_AQUARIUS_DRONE", cf, ( 49074.5, 28812, 1163.75 ), ( 0, 7.88, 0 ), "defend_crates", undefined, "ob_sat_items_aqua_defend" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_aquarius_sam_launch_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s._size_max = ( 352, 336, 558 );
    s._size_min = ( 624, 2046, 32 );
    s.height = 128;
    s.length = "128";
    s.width = "128";
    fe [[ f ]]( s, "REV_OB_AQUARIUS_DRONE", cf, ( 18356, 49792, 816 ), ( 0, 10, 0 ), "aquarius_drone_inside_stronghold_trigger" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_aquarius_sam_launch_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s.height = 1000;
    fe [[ f ]]( s, "REV_OB_AQUARIUS_DRONE", cf, ( 18536, 48288, 304 ), ( 0, 0, 0 ), "aquarius_drone_near_stronghold_trigger", undefined, undefined, undefined, undefined, undefined, undefined, 6000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_aquarius_sam_launch_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s._size_max = ( 352, 336, 558 );
    s._size_min = ( 624, 2046, 32 );
    s.height = 128;
    s.length = "128";
    s.width = "128";
    fe [[ f ]]( s, "REV_OB_AQUARIUS_DRONE", cf, ( 18920, 46752, 816 ), ( 0, 10, 0 ), "aquarius_drone_inside_stronghold_trigger" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_aquarius_sam_launch_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s._size_max = ( 352, 252, 558 );
    s._size_min = ( 1088, 1358, 32 );
    s.height = 128;
    s.length = "128";
    s.width = "128";
    fe [[ f ]]( s, "REV_OB_AQUARIUS_DRONE", cf, ( 18748, 48616, 816 ), ( 0, 10, 0 ), "aquarius_drone_inside_stronghold_trigger" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_aquarius_sam_launch_cs";
    s.name = "cache";
    fe [[ f ]]( s, "REV_OB_AQUARIUS_DRONE", cf, ( 48076, 28669, 918 ), ( 0, 317.43, 0 ), "defend_crates", undefined, "ob_sat_items_gear_weapon_roll_tier_2_sm" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_aquarius_sam_launch_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s._size_max = ( 252, 140, 72 );
    s._size_min = ( 234, 194, 34 );
    s.height = 128;
    s.length = "128";
    s.width = "128";
    fe [[ f ]]( s, "REV_OB_AQUARIUS_DRONE", cf, ( 18528, 47272, 856 ), ( 0, 10, 0 ), "aquarius_drone_near_keycard_trigger" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_aquarius_sam_launch_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s.height = 1500;
    fe [[ f ]]( s, "REV_OB_AQUARIUS_DRONE", cf, ( 23980, 29640, 2088 ), ( 0, 0, 0 ), "aquarius_drone_near_sam_trigger", undefined, undefined, undefined, undefined, undefined, undefined, 3000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_aquarius_sam_launch_cs";
    s.name = "cache";
    fe [[ f ]]( s, "REV_OB_AQUARIUS_DRONE", cf, ( 47821.2, 28435.8, 894.05 ), ( 0, 27.49, 0 ), "defend_crates", undefined, "ob_sat_items_gear_weapon_roll_tier_2_sm" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_aquarius_sam_launch_cs";
    s.groupid = "initial_test_wave";
    s.height = 100;
    s.name = "goal_node_test";
    fe [[ f ]]( s, "REV_OB_AQUARIUS_DRONE", cf, ( 49026.3, 29369.6, 1028.69 ), ( 0, 0, 0 ), "initial_wave_target_01", undefined, undefined, undefined, undefined, undefined, undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_aquarius_sam_launch_cs";
    s.groupid = "initial_test_wave";
    s.height = 100;
    s.name = "goal_node_test";
    fe [[ f ]]( s, "REV_OB_AQUARIUS_DRONE", cf, ( 47563.2, 29488.4, 1270.8 ), ( 0, 0, 0 ), "initial_wave_target_02", undefined, undefined, undefined, undefined, undefined, undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_aquarius_sam_launch_cs";
    s.groupid = "initial_test_wave";
    fe [[ f ]]( s, "REV_OB_AQUARIUS_DRONE", cf, ( 48399.1, 29095.5, 1034.84 ), ( 0, 0, 0 ), undefined, undefined, "test_aqua_struct" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_aquarius_sam_launch_cs";
    fe [[ f ]]( s, "REV_OB_AQUARIUS_DRONE", cf, ( 48072, 28548.1, 918 ), ( 0, 214.4, 0 ), "aqua_sam_site_interact_struct" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_aquarius_sam_launch_cs";
    fe [[ f ]]( s, "REV_OB_AQUARIUS_DRONE", cf, ( 47988.9, 28209.5, 907 ), ( 0.01, 94, -0.01 ), "aqua_defense_center" );
}

// Namespace mp_sat_avalon_q2_ob_aquarius_sam_launch_cs
// Params 0
// Checksum 0xcb59041a, Offset: 0xec3
// Size: 0xae
function function_d9dd7965c51c95d1()
{
    activityinstances = [];
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_activitydef_contract_aquarius_drone";
    var_881289d7987bc770.cf = "mp_sat_avalon_q2_ob_aquarius_sam_launch_cs";
    var_881289d7987bc770.scriptstructorigin = ( 18478.3, 47000.7, 858.35 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [];
    var_881289d7987bc770.var_31ce4477e3543d24 = [];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [];
    var_881289d7987bc770.locationradius = [];
    activityinstances[ "REV_OB_AQUARIUS_DRONE" ] = var_881289d7987bc770;
    return activityinstances;
}

