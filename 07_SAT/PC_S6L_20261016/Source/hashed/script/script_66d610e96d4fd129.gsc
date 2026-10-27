// script_66d610e96d4fd129  (hash_66d610e96d4fd129.gscc) (size: 2969 Bytes / 0xb99 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x9bf26830 (2616354864)
// size ...... 2969 (0xb99)
// includes .. 4   (offset: 0xac9)
// strings ... 10  (offset: 0xae9)
// dev strs .. 0   (offset: 0xb99)
// exports ... 13  (offset: 0x5e5)
// cseg ...... 0x17a + 0x46b (0x5e5)
// imports ... 26  (offset: 0x7ed)
// animtree1 . 0   (offset: 0xb99)
// animtree2 . 0   (offset: 0xb99)
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace mp_sat_avalon_quad_03_ob_activity_possessed_convoy_cs;

// Namespace mp_sat_avalon_quad_03_ob_activity_possessed_convoy_cs
// Params 0, eflags: 0x5
// Checksum 0x62a479c8, Offset: 0x198
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"mp_sat_avalon_quad_03_ob_activity_possessed_convoy_cs", #"activity_common", &function_b39ecd3d51489472, undefined );
}

// Namespace mp_sat_avalon_quad_03_ob_activity_possessed_convoy_cs
// Params 0, eflags: 0x4
// Checksum 0x8e7ceef8, Offset: 0x1c1
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace mp_sat_avalon_quad_03_ob_activity_possessed_convoy_cs
// Params 0, eflags: 0x4
// Checksum 0xb473d14, Offset: 0x1d2
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace mp_sat_avalon_quad_03_ob_activity_possessed_convoy_cs
// Params 2
// Checksum 0x3462047f, Offset: 0x1e3
// Size: 0x8c
function main( unused, unused2 )
{
    if ( utility::flag_exist( "mp_sat_avalon_quad_03_ob_activity_possessed_convoy_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "mp_sat_avalon_quad_03_ob_activity_possessed_convoy_cs" ) )
    {
        return;
    }
    
    activity_common::function_e1df676808c1d1e3( &function_4cd78e661617f3 );
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "mp_sat_avalon_quad_03_ob_activity_possessed_convoy_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "mp_sat_avalon_quad_03_ob_activity_possessed_convoy_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace mp_sat_avalon_quad_03_ob_activity_possessed_convoy_cs
// Params 3, eflags: 0x4
// Checksum 0x88c589db, Offset: 0x277
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "mp_sat_avalon_quad_03_ob_activity_possessed_convoy_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "mp_sat_avalon_quad_03_ob_activity_possessed_convoy_cs" );
}

// Namespace mp_sat_avalon_quad_03_ob_activity_possessed_convoy_cs
// Params 3, eflags: 0x4
// Checksum 0x72769505, Offset: 0x2f1
// Size: 0x129
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_possessed_convoy_cs";
    fe [[ f ]]( s, "POSSESSED_CONVOY_Q3_MITRAINING", cf, ( -21311.3, -27578.7, 396.76 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "OB_Spacer_Spatial_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 50 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_possessed_convoy_cs";
    s.name = "POSSESSED_CONVOY_Q3_MITRAINING";
    fe [[ f ]]( s, "POSSESSED_CONVOY_Q3_MITRAINING", cf, ( -21175.2, -27931.8, 382.88 ), ( 0, 15.53, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace mp_sat_avalon_quad_03_ob_activity_possessed_convoy_cs
// Params 0, eflags: 0x4
// Checksum 0x23e6b032, Offset: 0x422
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace mp_sat_avalon_quad_03_ob_activity_possessed_convoy_cs
// Params 0
// Checksum 0x4a965496, Offset: 0x42c
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "mp_sat_avalon_quad_03_ob_activity_possessed_convoy_cs" );
}

// Namespace mp_sat_avalon_quad_03_ob_activity_possessed_convoy_cs
// Params 0
// Checksum 0x94376eda, Offset: 0x442
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

// Namespace mp_sat_avalon_quad_03_ob_activity_possessed_convoy_cs
// Params 4
// Checksum 0x9c061d38, Offset: 0x4b1
// Size: 0x57
function function_d4323822d7042e5a( var_4312b79c960726b6, fe, us, cf = "mp_sat_avalon_quad_03_ob_activity_possessed_convoy_cs" )
{
    switch ( var_4312b79c960726b6 )
    {
        case #"hash_3608c42610fc52a7":
            function_7e5ed211e8ad901f( fe, us, cf );
            break;
    }
}

// Namespace mp_sat_avalon_quad_03_ob_activity_possessed_convoy_cs
// Params 3
// Checksum 0xe84b3d37, Offset: 0x510
// Size: 0x2f
function function_7e5ed211e8ad901f( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
}

// Namespace mp_sat_avalon_quad_03_ob_activity_possessed_convoy_cs
// Params 0
// Checksum 0xfd86b8da, Offset: 0x547
// Size: 0x9d
function function_d9dd7965c51c95d1()
{
    activityinstances = [];
    var_881289d7987bc770 = {};
    var_881289d7987bc770.cf = "mp_sat_avalon_quad_03_ob_activity_possessed_convoy_cs";
    var_881289d7987bc770.scriptstructorigin = ( -21175.2, -27931.8, 382.88 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [];
    var_881289d7987bc770.var_31ce4477e3543d24 = [];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [];
    var_881289d7987bc770.locationradius = [];
    activityinstances[ "POSSESSED_CONVOY_Q3_MITRAINING" ] = var_881289d7987bc770;
    return activityinstances;
}

