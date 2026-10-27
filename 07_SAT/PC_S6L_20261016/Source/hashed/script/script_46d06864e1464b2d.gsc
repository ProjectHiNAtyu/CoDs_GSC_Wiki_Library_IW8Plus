// script_46d06864e1464b2d  (hash_46d06864e1464b2d.gscc) (size: 4815 Bytes / 0x12cf / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x2d6d2fc6 (762130374)
// size ...... 4815 (0x12cf)
// includes .. 4   (offset: 0x1123)
// strings ... 14  (offset: 0x1143)
// dev strs .. 0   (offset: 0x12cf)
// exports ... 15  (offset: 0xbaf)
// cseg ...... 0x1c6 + 0x9e9 (0xbaf)
// imports ... 28  (offset: 0xe07)
// animtree1 . 0   (offset: 0x12cf)
// animtree2 . 0   (offset: 0x12cf)
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace mp_sat_avalon_quad_03_ob_activity_cradle_vents_cs;

// Namespace mp_sat_avalon_quad_03_ob_activity_cradle_vents_cs
// Params 0, eflags: 0x5
// Checksum 0xf6ff70d6, Offset: 0x1e4
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"mp_sat_avalon_quad_03_ob_activity_cradle_vents_cs", #"activity_common", &function_b39ecd3d51489472, undefined );
}

// Namespace mp_sat_avalon_quad_03_ob_activity_cradle_vents_cs
// Params 0, eflags: 0x4
// Checksum 0xfc9ed012, Offset: 0x20d
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace mp_sat_avalon_quad_03_ob_activity_cradle_vents_cs
// Params 0, eflags: 0x4
// Checksum 0x79a503fe, Offset: 0x21e
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace mp_sat_avalon_quad_03_ob_activity_cradle_vents_cs
// Params 2
// Checksum 0xa56382f3, Offset: 0x22f
// Size: 0x8c
function main( unused, unused2 )
{
    if ( utility::flag_exist( "mp_sat_avalon_quad_03_ob_activity_cradle_vents_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "mp_sat_avalon_quad_03_ob_activity_cradle_vents_cs" ) )
    {
        return;
    }
    
    activity_common::function_e1df676808c1d1e3( &function_4cd78e661617f3 );
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "mp_sat_avalon_quad_03_ob_activity_cradle_vents_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "mp_sat_avalon_quad_03_ob_activity_cradle_vents_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace mp_sat_avalon_quad_03_ob_activity_cradle_vents_cs
// Params 3, eflags: 0x4
// Checksum 0xfa27b731, Offset: 0x2c3
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "mp_sat_avalon_quad_03_ob_activity_cradle_vents_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "mp_sat_avalon_quad_03_ob_activity_cradle_vents_cs" );
}

// Namespace mp_sat_avalon_quad_03_ob_activity_cradle_vents_cs
// Params 3, eflags: 0x4
// Checksum 0x8b982c32, Offset: 0x33d
// Size: 0x356
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_cradle_vents_cs";
    fe [[ f ]]( s, us, cf, ( 32, 0, -16 ), ( 0, 0, 0 ), "q3_cradle_vents_parent_cs" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_cradle_vents_cs";
    s.activity_bundle = "sat_activitydefinition_cradle_vents";
    s.name = "CRADLE_VENTS_SMALL_ISLAND";
    fe [[ f ]]( s, "CRADLE_VENTS_SMALL_ISLAND", cf, ( -36319.4, -49449.7, 199.97 ), ( 0, 30, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_cradle_vents_cs";
    fe [[ f ]]( s, "CRADLE_VENTS_SMALL_ISLAND", cf, ( -36164.6, -49491, 199.97 ), ( 0, 30, 0 ), "activity_nexus_spatial_zone", undefined, "join_radius", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 2500 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_cradle_vents_cs";
    s.activity_bundle = "sat_activitydefinition_cradle_vents";
    s.name = "CRADLE_VENTS_MILITARY_OUTPOST";
    fe [[ f ]]( s, "CRADLE_VENTS_MILITARY_OUTPOST", cf, ( -18644.1, -15564.1, 301.19 ), ( 0, 55, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_cradle_vents_cs";
    fe [[ f ]]( s, "CRADLE_VENTS_MILITARY_OUTPOST", cf, ( -18486.4, -15536.2, 301.07 ), ( 0, 55, 0 ), "activity_nexus_spatial_zone", undefined, "join_radius", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 2500 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_cradle_vents_cs";
    s.activity_bundle = "sat_activitydefinition_cradle_vents";
    s.name = "CRADLE_VENTS_MI_TRAINING";
    fe [[ f ]]( s, "CRADLE_VENTS_MI_TRAINING", cf, ( -23511.5, -28508.1, 935.02 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_cradle_vents_cs";
    fe [[ f ]]( s, "CRADLE_VENTS_MI_TRAINING", cf, ( -23398.1, -28621.3, 937.15 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "join_radius", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 2500 );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace mp_sat_avalon_quad_03_ob_activity_cradle_vents_cs
// Params 0, eflags: 0x4
// Checksum 0xb2e736be, Offset: 0x69b
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace mp_sat_avalon_quad_03_ob_activity_cradle_vents_cs
// Params 0
// Checksum 0x38746a7c, Offset: 0x6a5
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "mp_sat_avalon_quad_03_ob_activity_cradle_vents_cs" );
}

// Namespace mp_sat_avalon_quad_03_ob_activity_cradle_vents_cs
// Params 0
// Checksum 0x5550bd4d, Offset: 0x6bb
// Size: 0x66
function function_4cd78e661617f3()
{
    activityinfostruct = {};
    activityinfostruct.name = "REV_OB_CRADLE_VENTS";
    activityinfostruct.scriptbundle = "sat_activitydefinition_cradle_vents";
    activityinfostruct.mainfunction = &main;
    activityinfostruct.var_934f068483ae4ddb = &function_d4323822d7042e5a;
    activityinfostruct.metadatafunction = &function_d9dd7965c51c95d1;
    return activityinfostruct;
}

// Namespace mp_sat_avalon_quad_03_ob_activity_cradle_vents_cs
// Params 4
// Checksum 0x818f9879, Offset: 0x72a
// Size: 0x8b
function function_d4323822d7042e5a( var_4312b79c960726b6, fe, us, cf = "mp_sat_avalon_quad_03_ob_activity_cradle_vents_cs" )
{
    switch ( var_4312b79c960726b6 )
    {
        case #"hash_dec85bdcbf610127":
            function_4c3a0a14417932ff( fe, us, cf );
            break;
        case #"hash_17c7df3802724708":
            function_579493ffd8dcdb10( fe, us, cf );
            break;
        case #"hash_573f237438cc1a13":
            function_8a2ef03799962d9b( fe, us, cf );
            break;
    }
}

// Namespace mp_sat_avalon_quad_03_ob_activity_cradle_vents_cs
// Params 3
// Checksum 0x409a0ab2, Offset: 0x7bd
// Size: 0xab
function function_4c3a0a14417932ff( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_cradle_vents_cs";
    s.name = "power_core";
    fe [[ f ]]( s, "CRADLE_VENTS_SMALL_ISLAND", cf, ( -36172.6, -49535, 199.97 ), ( 0, 174.69, 0 ), "power_core", undefined, "CRADLE_VENTS_SMALL_ISLAND", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_sat_avalon_quad_03_ob_activity_cradle_vents_cs
// Params 3
// Checksum 0xc5cadea3, Offset: 0x870
// Size: 0xab
function function_579493ffd8dcdb10( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_cradle_vents_cs";
    s.name = "power_core";
    fe [[ f ]]( s, "CRADLE_VENTS_MILITARY_OUTPOST", cf, ( -18475, -15579.4, 301.62 ), ( 0, 199.69, 0 ), "power_core", undefined, "CRADLE_VENTS_MILITARY_OUTPOST", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_sat_avalon_quad_03_ob_activity_cradle_vents_cs
// Params 3
// Checksum 0x34d49e0d, Offset: 0x923
// Size: 0xab
function function_8a2ef03799962d9b( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_cradle_vents_cs";
    s.name = "power_core";
    fe [[ f ]]( s, "CRADLE_VENTS_MI_TRAINING", cf, ( -23427, -28655.4, 937.35 ), ( 0, 144.69, 0 ), "power_core", undefined, "CRADLE_VENTS_MI_TRAINING", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_sat_avalon_quad_03_ob_activity_cradle_vents_cs
// Params 0
// Checksum 0x94e5f31b, Offset: 0x9d6
// Size: 0x1d8
function function_d9dd7965c51c95d1()
{
    activityinstances = [];
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_activitydefinition_cradle_vents";
    var_881289d7987bc770.cf = "mp_sat_avalon_quad_03_ob_activity_cradle_vents_cs";
    var_881289d7987bc770.scriptstructorigin = ( -36319.4, -49449.7, 199.97 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [];
    var_881289d7987bc770.var_31ce4477e3543d24 = [];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [];
    var_881289d7987bc770.locationradius = [];
    activityinstances[ "CRADLE_VENTS_SMALL_ISLAND" ] = var_881289d7987bc770;
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_activitydefinition_cradle_vents";
    var_881289d7987bc770.cf = "mp_sat_avalon_quad_03_ob_activity_cradle_vents_cs";
    var_881289d7987bc770.scriptstructorigin = ( -18644.1, -15564.1, 301.19 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [];
    var_881289d7987bc770.var_31ce4477e3543d24 = [];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [];
    var_881289d7987bc770.locationradius = [];
    activityinstances[ "CRADLE_VENTS_MILITARY_OUTPOST" ] = var_881289d7987bc770;
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_activitydefinition_cradle_vents";
    var_881289d7987bc770.cf = "mp_sat_avalon_quad_03_ob_activity_cradle_vents_cs";
    var_881289d7987bc770.scriptstructorigin = ( -23511.5, -28508.1, 935.02 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [];
    var_881289d7987bc770.var_31ce4477e3543d24 = [];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [];
    var_881289d7987bc770.locationradius = [];
    activityinstances[ "CRADLE_VENTS_MI_TRAINING" ] = var_881289d7987bc770;
    return activityinstances;
}

