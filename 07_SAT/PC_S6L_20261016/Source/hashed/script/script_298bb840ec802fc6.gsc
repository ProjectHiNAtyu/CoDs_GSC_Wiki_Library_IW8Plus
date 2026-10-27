// script_298bb840ec802fc6  (hash_298bb840ec802fc6.gscc) (size: 3569 Bytes / 0xdf1 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xc028f8cf (3223910607)
// size ...... 3569 (0xdf1)
// includes .. 4   (offset: 0xce9)
// strings ... 11  (offset: 0xd09)
// dev strs .. 0   (offset: 0xdf1)
// exports ... 14  (offset: 0x7bd)
// cseg ...... 0x1a0 + 0x61d (0x7bd)
// imports ... 27  (offset: 0x9ed)
// animtree1 . 0   (offset: 0xdf1)
// animtree2 . 0   (offset: 0xdf1)
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace mp_sat_avalon_q4_ob_activity_possessed_convoy_cs;

// Namespace mp_sat_avalon_q4_ob_activity_possessed_convoy_cs
// Params 0, eflags: 0x5
// Checksum 0x165265d7, Offset: 0x1be
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"mp_sat_avalon_q4_ob_activity_possessed_convoy_cs", #"activity_common", &function_b39ecd3d51489472, undefined );
}

// Namespace mp_sat_avalon_q4_ob_activity_possessed_convoy_cs
// Params 0, eflags: 0x4
// Checksum 0x209dd73b, Offset: 0x1e7
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace mp_sat_avalon_q4_ob_activity_possessed_convoy_cs
// Params 0, eflags: 0x4
// Checksum 0xa5a604d7, Offset: 0x1f8
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace mp_sat_avalon_q4_ob_activity_possessed_convoy_cs
// Params 2
// Checksum 0x73e61ce5, Offset: 0x209
// Size: 0x8c
function main( unused, unused2 )
{
    if ( utility::flag_exist( "mp_sat_avalon_q4_ob_activity_possessed_convoy_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "mp_sat_avalon_q4_ob_activity_possessed_convoy_cs" ) )
    {
        return;
    }
    
    activity_common::function_e1df676808c1d1e3( &function_4cd78e661617f3 );
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "mp_sat_avalon_q4_ob_activity_possessed_convoy_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "mp_sat_avalon_q4_ob_activity_possessed_convoy_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace mp_sat_avalon_q4_ob_activity_possessed_convoy_cs
// Params 3, eflags: 0x4
// Checksum 0x2624b018, Offset: 0x29d
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "mp_sat_avalon_q4_ob_activity_possessed_convoy_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "mp_sat_avalon_q4_ob_activity_possessed_convoy_cs" );
}

// Namespace mp_sat_avalon_q4_ob_activity_possessed_convoy_cs
// Params 3, eflags: 0x4
// Checksum 0x34efa456, Offset: 0x317
// Size: 0x206
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_possessed_convoy_cs";
    s.name = "POSSESSED_CONVOY_Q4_MOUNTAIN_RANGE";
    fe [[ f ]]( s, "POSSESSED_CONVOY_Q4_MOUNTAIN_RANGE", cf, ( 8778.85, -13248.5, 1885.11 ), ( 0, 15.53, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_possessed_convoy_cs";
    fe [[ f ]]( s, "POSSESSED_CONVOY_Q4_MOUNTAIN_RANGE", cf, ( 22255.2, -16590.8, 590.35 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "OB_Spacer_Spatial_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 50 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_possessed_convoy_cs";
    fe [[ f ]]( s, "POSSESSED_CONVOY_Q4_WATER_TREATMENT", cf, ( 59284.2, -22774.9, 2479.99 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "OB_Spacer_Spatial_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 50 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_possessed_convoy_cs";
    s.name = "POSSESSED_CONVOY_Q4_WATER_TREATMENT";
    fe [[ f ]]( s, "POSSESSED_CONVOY_Q4_WATER_TREATMENT", cf, ( 48786.1, -5535.75, 416.24 ), ( 0, 15.53, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace mp_sat_avalon_q4_ob_activity_possessed_convoy_cs
// Params 0, eflags: 0x4
// Checksum 0x6462a8a8, Offset: 0x525
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace mp_sat_avalon_q4_ob_activity_possessed_convoy_cs
// Params 0
// Checksum 0xe4776d55, Offset: 0x52f
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "mp_sat_avalon_q4_ob_activity_possessed_convoy_cs" );
}

// Namespace mp_sat_avalon_q4_ob_activity_possessed_convoy_cs
// Params 0
// Checksum 0x3ad65719, Offset: 0x545
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

// Namespace mp_sat_avalon_q4_ob_activity_possessed_convoy_cs
// Params 4
// Checksum 0xa350ed25, Offset: 0x5b4
// Size: 0x71
function function_d4323822d7042e5a( var_4312b79c960726b6, fe, us, cf = "mp_sat_avalon_q4_ob_activity_possessed_convoy_cs" )
{
    switch ( var_4312b79c960726b6 )
    {
        case #"hash_c68f8bab9cb69a65":
            function_a146f3cd7a1fe8ed( fe, us, cf );
            break;
        case #"hash_afae2955810bb528":
            function_c1a055e1874c8080( fe, us, cf );
            break;
    }
}

// Namespace mp_sat_avalon_q4_ob_activity_possessed_convoy_cs
// Params 3
// Checksum 0xacb77d8b, Offset: 0x62d
// Size: 0x2f
function function_a146f3cd7a1fe8ed( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
}

// Namespace mp_sat_avalon_q4_ob_activity_possessed_convoy_cs
// Params 3
// Checksum 0x31b67095, Offset: 0x664
// Size: 0x2f
function function_c1a055e1874c8080( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
}

// Namespace mp_sat_avalon_q4_ob_activity_possessed_convoy_cs
// Params 0
// Checksum 0x9f518ff4, Offset: 0x69b
// Size: 0x121
function function_d9dd7965c51c95d1()
{
    activityinstances = [];
    var_881289d7987bc770 = {};
    var_881289d7987bc770.cf = "mp_sat_avalon_q4_ob_activity_possessed_convoy_cs";
    var_881289d7987bc770.scriptstructorigin = ( 8778.85, -13248.5, 1885.11 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [];
    var_881289d7987bc770.var_31ce4477e3543d24 = [];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [];
    var_881289d7987bc770.locationradius = [];
    activityinstances[ "POSSESSED_CONVOY_Q4_MOUNTAIN_RANGE" ] = var_881289d7987bc770;
    var_881289d7987bc770 = {};
    var_881289d7987bc770.cf = "mp_sat_avalon_q4_ob_activity_possessed_convoy_cs";
    var_881289d7987bc770.scriptstructorigin = ( 48786.1, -5535.75, 416.24 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [];
    var_881289d7987bc770.var_31ce4477e3543d24 = [];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [];
    var_881289d7987bc770.locationradius = [];
    activityinstances[ "POSSESSED_CONVOY_Q4_WATER_TREATMENT" ] = var_881289d7987bc770;
    return activityinstances;
}

