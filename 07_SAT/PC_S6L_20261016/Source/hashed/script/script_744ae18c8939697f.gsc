// script_744ae18c8939697f  (hash_744ae18c8939697f.gscc) (size: 2904 Bytes / 0xb58 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xe59ef23d (3852399165)
// size ...... 2904 (0xb58)
// includes .. 4   (offset: 0xa8c)
// strings ... 10  (offset: 0xaac)
// dev strs .. 0   (offset: 0xb58)
// exports ... 13  (offset: 0x5c4)
// cseg ...... 0x169 + 0x45b (0x5c4)
// imports ... 25  (offset: 0x7cc)
// animtree1 . 0   (offset: 0xb58)
// animtree2 . 0   (offset: 0xb58)
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace mp_sat_avalon_quad_03_ob_activity_convoy_cs;

// Namespace mp_sat_avalon_quad_03_ob_activity_convoy_cs
// Params 0, eflags: 0x5
// Checksum 0xda34d207, Offset: 0x187
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"mp_sat_avalon_quad_03_ob_activity_convoy_cs", #"activity_common", &function_b39ecd3d51489472, undefined );
}

// Namespace mp_sat_avalon_quad_03_ob_activity_convoy_cs
// Params 0, eflags: 0x4
// Checksum 0x453e4625, Offset: 0x1b0
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace mp_sat_avalon_quad_03_ob_activity_convoy_cs
// Params 0, eflags: 0x4
// Checksum 0x763b20f0, Offset: 0x1c1
// Size: 0x15
function private structs_init()
{
    main();
    activity_common::function_e1df676808c1d1e3( &function_4cd78e661617f3 );
}

// Namespace mp_sat_avalon_quad_03_ob_activity_convoy_cs
// Params 2
// Checksum 0x762fa645, Offset: 0x1de
// Size: 0x70
function main( unused, unused2 )
{
    if ( utility::flag_exist( "mp_sat_avalon_quad_03_ob_activity_convoy_cs" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "mp_sat_avalon_quad_03_ob_activity_convoy_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "mp_sat_avalon_quad_03_ob_activity_convoy_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace mp_sat_avalon_quad_03_ob_activity_convoy_cs
// Params 3, eflags: 0x4
// Checksum 0x43872106, Offset: 0x256
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "mp_sat_avalon_quad_03_ob_activity_convoy_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "mp_sat_avalon_quad_03_ob_activity_convoy_cs" );
}

// Namespace mp_sat_avalon_quad_03_ob_activity_convoy_cs
// Params 3, eflags: 0x4
// Checksum 0x1772a723, Offset: 0x2d0
// Size: 0x129
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_convoy_cs";
    fe [[ f ]]( s, "ARMORED_CONVOY_Q3_MITRAINING", cf, ( -21311.3, -27578.7, 396.76 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "OB_Spacer_Spatial_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 50 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_convoy_cs";
    s.name = "ARMORED_CONVOY_Q3_MITRAINING";
    fe [[ f ]]( s, "ARMORED_CONVOY_Q3_MITRAINING", cf, ( -21531.2, -27941.2, 406.52 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace mp_sat_avalon_quad_03_ob_activity_convoy_cs
// Params 0, eflags: 0x4
// Checksum 0xd156c2f4, Offset: 0x401
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace mp_sat_avalon_quad_03_ob_activity_convoy_cs
// Params 0
// Checksum 0x81d4fc4b, Offset: 0x40b
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "mp_sat_avalon_quad_03_ob_activity_convoy_cs" );
}

// Namespace mp_sat_avalon_quad_03_ob_activity_convoy_cs
// Params 0
// Checksum 0x343d3579, Offset: 0x421
// Size: 0x66
function function_4cd78e661617f3()
{
    activityinfostruct = {};
    activityinfostruct.name = "REV_OB_ARMORED_CONVOY";
    activityinfostruct.scriptbundle = "sat_activitydefinition_armoredconvoy";
    activityinfostruct.mainfunction = &main;
    activityinfostruct.var_934f068483ae4ddb = &function_d4323822d7042e5a;
    activityinfostruct.metadatafunction = &function_d9dd7965c51c95d1;
    return activityinfostruct;
}

// Namespace mp_sat_avalon_quad_03_ob_activity_convoy_cs
// Params 4
// Checksum 0x41ed0d90, Offset: 0x490
// Size: 0x57
function function_d4323822d7042e5a( var_4312b79c960726b6, fe, us, cf = "mp_sat_avalon_quad_03_ob_activity_convoy_cs" )
{
    switch ( var_4312b79c960726b6 )
    {
        case #"hash_9968546790c5d17e":
            function_59a948b1f85744c6( fe, us, cf );
            break;
    }
}

// Namespace mp_sat_avalon_quad_03_ob_activity_convoy_cs
// Params 3
// Checksum 0xd8001f6, Offset: 0x4ef
// Size: 0x2f
function function_59a948b1f85744c6( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
}

// Namespace mp_sat_avalon_quad_03_ob_activity_convoy_cs
// Params 0
// Checksum 0xd9faf01d, Offset: 0x526
// Size: 0x9d
function function_d9dd7965c51c95d1()
{
    activityinstances = [];
    var_881289d7987bc770 = {};
    var_881289d7987bc770.cf = "mp_sat_avalon_quad_03_ob_activity_convoy_cs";
    var_881289d7987bc770.scriptstructorigin = ( -21531.2, -27941.2, 406.52 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [];
    var_881289d7987bc770.var_31ce4477e3543d24 = [];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [];
    var_881289d7987bc770.locationradius = [];
    activityinstances[ "ARMORED_CONVOY_Q3_MITRAINING" ] = var_881289d7987bc770;
    return activityinstances;
}

