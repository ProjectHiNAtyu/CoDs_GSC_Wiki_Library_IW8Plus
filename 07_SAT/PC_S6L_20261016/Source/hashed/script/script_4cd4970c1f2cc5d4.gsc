// script_4cd4970c1f2cc5d4  (hash_4cd4970c1f2cc5d4.gscc) (size: 3438 Bytes / 0xd6e / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x55ead825 (1441454117)
// size ...... 3438 (0xd6e)
// includes .. 4   (offset: 0xc4a)
// strings ... 11  (offset: 0xc6a)
// dev strs .. 0   (offset: 0xd6e)
// exports ... 13  (offset: 0x766)
// cseg ...... 0x198 + 0x5ce (0x766)
// imports ... 26  (offset: 0x96e)
// animtree1 . 0   (offset: 0xd6e)
// animtree2 . 0   (offset: 0xd6e)
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace mp_sat_avalon_q3_ob_contract_libra_mission_launch_cs;

// Namespace mp_sat_avalon_q3_ob_contract_libra_mission_launch_cs
// Params 0, eflags: 0x5
// Checksum 0xe840768c, Offset: 0x1b6
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"mp_sat_avalon_q3_ob_contract_libra_mission_launch_cs", #"activity_common", &function_b39ecd3d51489472, undefined );
}

// Namespace mp_sat_avalon_q3_ob_contract_libra_mission_launch_cs
// Params 0, eflags: 0x4
// Checksum 0x88a0a177, Offset: 0x1df
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace mp_sat_avalon_q3_ob_contract_libra_mission_launch_cs
// Params 0, eflags: 0x4
// Checksum 0xd9b729b, Offset: 0x1f0
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace mp_sat_avalon_q3_ob_contract_libra_mission_launch_cs
// Params 2
// Checksum 0xfcd504ea, Offset: 0x201
// Size: 0x8c
function main( unused, unused2 )
{
    if ( utility::flag_exist( "mp_sat_avalon_q3_ob_contract_libra_mission_launch_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "mp_sat_avalon_q3_ob_contract_libra_mission_launch_cs" ) )
    {
        return;
    }
    
    activity_common::function_e1df676808c1d1e3( &function_4cd78e661617f3 );
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "mp_sat_avalon_q3_ob_contract_libra_mission_launch_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "mp_sat_avalon_q3_ob_contract_libra_mission_launch_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace mp_sat_avalon_q3_ob_contract_libra_mission_launch_cs
// Params 3, eflags: 0x4
// Checksum 0x8e19c654, Offset: 0x295
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "mp_sat_avalon_q3_ob_contract_libra_mission_launch_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "mp_sat_avalon_q3_ob_contract_libra_mission_launch_cs" );
}

// Namespace mp_sat_avalon_q3_ob_contract_libra_mission_launch_cs
// Params 3, eflags: 0x4
// Checksum 0x459e70b4, Offset: 0x30f
// Size: 0x155
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_contract_libra_mission_launch_cs";
    s.activity_bundle = "sat_activitydef_contract_libra_mission_launch";
    s.name = "REV_OB_LIBRA_MISSION_LAUNCH";
    fe [[ f ]]( s, "REV_OB_LIBRA_MISSION_LAUNCH", cf, ( -49088.7, -14731.2, 47.47 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_contract_libra_mission_launch_cs";
    fe [[ f ]]( s, "REV_OB_LIBRA_MISSION_LAUNCH", cf, ( -49174, -15080, 44.39 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "test_radii", undefined, "activity_link", undefined, undefined, 1000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_contract_libra_mission_launch_cs";
    fe [[ f ]]( s, "REV_OB_LIBRA_MISSION_LAUNCH", cf, ( -49085.4, -15386.5, 81.02 ), ( 270, 180, -90 ), "activity_nexus_instance_joiner", undefined, "REV_OB_LIBRA_MISSION_LAUNCH", undefined, "activity_link" );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace mp_sat_avalon_q3_ob_contract_libra_mission_launch_cs
// Params 0, eflags: 0x4
// Checksum 0xeb51b0a7, Offset: 0x46c
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace mp_sat_avalon_q3_ob_contract_libra_mission_launch_cs
// Params 0
// Checksum 0x4c4a1b19, Offset: 0x476
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "mp_sat_avalon_q3_ob_contract_libra_mission_launch_cs" );
}

// Namespace mp_sat_avalon_q3_ob_contract_libra_mission_launch_cs
// Params 0
// Checksum 0x986f11b8, Offset: 0x48c
// Size: 0x44
function function_4cd78e661617f3()
{
    activityinfostruct = {};
    activityinfostruct.mainfunction = &main;
    activityinfostruct.var_934f068483ae4ddb = &function_d4323822d7042e5a;
    activityinfostruct.metadatafunction = &function_d9dd7965c51c95d1;
    return activityinfostruct;
}

// Namespace mp_sat_avalon_q3_ob_contract_libra_mission_launch_cs
// Params 4
// Checksum 0x13779473, Offset: 0x4d9
// Size: 0x57
function function_d4323822d7042e5a( var_4312b79c960726b6, fe, us, cf = "mp_sat_avalon_q3_ob_contract_libra_mission_launch_cs" )
{
    switch ( var_4312b79c960726b6 )
    {
        case #"hash_c8452f811645b640":
            function_698eead374685658( fe, us, cf );
            break;
    }
}

// Namespace mp_sat_avalon_q3_ob_contract_libra_mission_launch_cs
// Params 3
// Checksum 0x6ca88433, Offset: 0x538
// Size: 0x177
function function_698eead374685658( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_contract_libra_mission_launch_cs";
    fe [[ f ]]( s, "REV_OB_LIBRA_MISSION_LAUNCH", cf, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_contract_libra_mission_launch_cs";
    fe [[ f ]]( s, "REV_OB_LIBRA_MISSION_LAUNCH", cf, ( -49050.2, -15421.9, 28 ), ( 0, 107, 0 ), "libra_mission_launch_teleport" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_contract_libra_mission_launch_cs";
    fe [[ f ]]( s, "REV_OB_LIBRA_MISSION_LAUNCH", cf, ( -49004.3, -15407.9, 28 ), ( 0, 107, 0 ), "libra_mission_launch_teleport" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_contract_libra_mission_launch_cs";
    fe [[ f ]]( s, "REV_OB_LIBRA_MISSION_LAUNCH", cf, ( -49096.1, -15436, 28 ), ( 0, 107, 0 ), "libra_mission_launch_teleport" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_contract_libra_mission_launch_cs";
    fe [[ f ]]( s, "REV_OB_LIBRA_MISSION_LAUNCH", cf, ( -49142, -15450, 28 ), ( 0, 107, 0 ), "libra_mission_launch_teleport" );
}

// Namespace mp_sat_avalon_q3_ob_contract_libra_mission_launch_cs
// Params 0
// Checksum 0xe8200e03, Offset: 0x6b7
// Size: 0xae
function function_d9dd7965c51c95d1()
{
    activityinstances = [];
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_activitydef_contract_libra_mission_launch";
    var_881289d7987bc770.cf = "mp_sat_avalon_q3_ob_contract_libra_mission_launch_cs";
    var_881289d7987bc770.scriptstructorigin = ( -49088.7, -14731.2, 47.47 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [];
    var_881289d7987bc770.var_31ce4477e3543d24 = [];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [];
    var_881289d7987bc770.locationradius = [];
    activityinstances[ "REV_OB_LIBRA_MISSION_LAUNCH" ] = var_881289d7987bc770;
    return activityinstances;
}

