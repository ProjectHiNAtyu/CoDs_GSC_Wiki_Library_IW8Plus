// script_b77edf693614ac6  (hash_0b77edf693614ac6.gscc) (size: 2960 Bytes / 0xb90 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x27fcd60 (41930080)
// size ...... 2960 (0xb90)
// includes .. 4   (offset: 0xac0)
// strings ... 10  (offset: 0xae0)
// dev strs .. 0   (offset: 0xb90)
// exports ... 13  (offset: 0x5dc)
// cseg ...... 0x171 + 0x46b (0x5dc)
// imports ... 26  (offset: 0x7e4)
// animtree1 . 0   (offset: 0xb90)
// animtree2 . 0   (offset: 0xb90)
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace mp_sat_avalon_q2_ob_activity_possessed_convoy_cs;

// Namespace mp_sat_avalon_q2_ob_activity_possessed_convoy_cs
// Params 0, eflags: 0x5
// Checksum 0x93c6fef9, Offset: 0x18f
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"mp_sat_avalon_q2_ob_activity_possessed_convoy_cs", #"activity_common", &function_b39ecd3d51489472, undefined );
}

// Namespace mp_sat_avalon_q2_ob_activity_possessed_convoy_cs
// Params 0, eflags: 0x4
// Checksum 0x9355c65f, Offset: 0x1b8
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace mp_sat_avalon_q2_ob_activity_possessed_convoy_cs
// Params 0, eflags: 0x4
// Checksum 0x166e15b3, Offset: 0x1c9
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace mp_sat_avalon_q2_ob_activity_possessed_convoy_cs
// Params 2
// Checksum 0x76016fab, Offset: 0x1da
// Size: 0x8c
function main( unused, unused2 )
{
    if ( utility::flag_exist( "mp_sat_avalon_q2_ob_activity_possessed_convoy_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "mp_sat_avalon_q2_ob_activity_possessed_convoy_cs" ) )
    {
        return;
    }
    
    activity_common::function_e1df676808c1d1e3( &function_4cd78e661617f3 );
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "mp_sat_avalon_q2_ob_activity_possessed_convoy_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "mp_sat_avalon_q2_ob_activity_possessed_convoy_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace mp_sat_avalon_q2_ob_activity_possessed_convoy_cs
// Params 3, eflags: 0x4
// Checksum 0x95eca17c, Offset: 0x26e
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "mp_sat_avalon_q2_ob_activity_possessed_convoy_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "mp_sat_avalon_q2_ob_activity_possessed_convoy_cs" );
}

// Namespace mp_sat_avalon_q2_ob_activity_possessed_convoy_cs
// Params 3, eflags: 0x4
// Checksum 0x7ed9f582, Offset: 0x2e8
// Size: 0x129
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_possessed_convoy_cs";
    s.name = "POSSESSED_CONVOY_Q2_WINERY";
    fe [[ f ]]( s, "POSSESSED_CONVOY_Q2_WINERY", cf, ( 23093.3, 44211.1, 1049.3 ), ( 0, 15.53, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_possessed_convoy_cs";
    fe [[ f ]]( s, "POSSESSED_CONVOY_Q2_WINERY", cf, ( 21480.1, 43977.9, 929.43 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "OB_Spacer_Spatial_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 50 );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace mp_sat_avalon_q2_ob_activity_possessed_convoy_cs
// Params 0, eflags: 0x4
// Checksum 0x6185dbe6, Offset: 0x419
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace mp_sat_avalon_q2_ob_activity_possessed_convoy_cs
// Params 0
// Checksum 0x57bf7c31, Offset: 0x423
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "mp_sat_avalon_q2_ob_activity_possessed_convoy_cs" );
}

// Namespace mp_sat_avalon_q2_ob_activity_possessed_convoy_cs
// Params 0
// Checksum 0x891e467d, Offset: 0x439
// Size: 0x66
function function_4cd78e661617f3()
{
    activityinfostruct = {};
    activityinfostruct.name = "REV_OB_POSSESSED_CONVOY";
    activityinfostruct.scriptbundle = "sat_activitydefinition_possessed_convoy";
    activityinfostruct.mainfunction = &main;
    activityinfostruct.var_934f068483ae4ddb = &function_d4323822d7042e5a;
    activityinfostruct.metadatafunction = &function_d9dd7965c51c95d1;
    return activityinfostruct;
}

// Namespace mp_sat_avalon_q2_ob_activity_possessed_convoy_cs
// Params 4
// Checksum 0x123ab724, Offset: 0x4a8
// Size: 0x57
function function_d4323822d7042e5a( var_4312b79c960726b6, fe, us, cf = "mp_sat_avalon_q2_ob_activity_possessed_convoy_cs" )
{
    switch ( var_4312b79c960726b6 )
    {
        case #"hash_d6777e59d96cf3e2":
            function_96c43b45592caa8a( fe, us, cf );
            break;
    }
}

// Namespace mp_sat_avalon_q2_ob_activity_possessed_convoy_cs
// Params 3
// Checksum 0x1974e618, Offset: 0x507
// Size: 0x2f
function function_96c43b45592caa8a( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
}

// Namespace mp_sat_avalon_q2_ob_activity_possessed_convoy_cs
// Params 0
// Checksum 0xf77af0b9, Offset: 0x53e
// Size: 0x9d
function function_d9dd7965c51c95d1()
{
    activityinstances = [];
    var_881289d7987bc770 = {};
    var_881289d7987bc770.cf = "mp_sat_avalon_q2_ob_activity_possessed_convoy_cs";
    var_881289d7987bc770.scriptstructorigin = ( 23093.3, 44211.1, 1049.3 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [];
    var_881289d7987bc770.var_31ce4477e3543d24 = [];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [];
    var_881289d7987bc770.locationradius = [];
    activityinstances[ "POSSESSED_CONVOY_Q2_WINERY" ] = var_881289d7987bc770;
    return activityinstances;
}

