// script_61d7a9a6532300fc  (hash_61d7a9a6532300fc.gscc) (size: 5476 Bytes / 0x1564 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xc9a427ca (3382978506)
// size ...... 5476 (0x1564)
// includes .. 4   (offset: 0x1374)
// strings ... 14  (offset: 0x1394)
// dev strs .. 0   (offset: 0x1564)
// exports ... 16  (offset: 0xdb8)
// cseg ...... 0x1bb + 0xbfd (0xdb8)
// imports ... 29  (offset: 0x1038)
// animtree1 . 0   (offset: 0x1564)
// animtree2 . 0   (offset: 0x1564)
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace mp_sat_avalon_quad_04_ob_activity_cradle_vent_cs;

// Namespace mp_sat_avalon_quad_04_ob_activity_cradle_vent_cs
// Params 0, eflags: 0x5
// Checksum 0x478bf665, Offset: 0x1d9
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"mp_sat_avalon_quad_04_ob_activity_cradle_vent_cs", #"activity_common", &function_b39ecd3d51489472, undefined );
}

// Namespace mp_sat_avalon_quad_04_ob_activity_cradle_vent_cs
// Params 0, eflags: 0x4
// Checksum 0x2863201b, Offset: 0x202
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace mp_sat_avalon_quad_04_ob_activity_cradle_vent_cs
// Params 0, eflags: 0x4
// Checksum 0xad58f3f7, Offset: 0x213
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace mp_sat_avalon_quad_04_ob_activity_cradle_vent_cs
// Params 2
// Checksum 0x41df679b, Offset: 0x224
// Size: 0x8c
function main( unused, unused2 )
{
    if ( utility::flag_exist( "mp_sat_avalon_quad_04_ob_activity_cradle_vent_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "mp_sat_avalon_quad_04_ob_activity_cradle_vent_cs" ) )
    {
        return;
    }
    
    activity_common::function_e1df676808c1d1e3( &function_4cd78e661617f3 );
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "mp_sat_avalon_quad_04_ob_activity_cradle_vent_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "mp_sat_avalon_quad_04_ob_activity_cradle_vent_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace mp_sat_avalon_quad_04_ob_activity_cradle_vent_cs
// Params 3, eflags: 0x4
// Checksum 0x2eda4738, Offset: 0x2b8
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "mp_sat_avalon_quad_04_ob_activity_cradle_vent_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "mp_sat_avalon_quad_04_ob_activity_cradle_vent_cs" );
}

// Namespace mp_sat_avalon_quad_04_ob_activity_cradle_vent_cs
// Params 3, eflags: 0x4
// Checksum 0xa97906c3, Offset: 0x332
// Size: 0x408
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_04_ob_activity_cradle_vent_cs";
    s.activity_bundle = "sat_activitydefinition_cradle_vents";
    s.name = "CRADLE_VENTS_RECYCLE";
    fe [[ f ]]( s, "CRADLE_VENTS_RECYCLE", cf, ( 43582.2, -53979.5, 597.67 ), ( 0, 152, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_04_ob_activity_cradle_vent_cs";
    fe [[ f ]]( s, "CRADLE_VENTS_RECYCLE", cf, ( 43654.9, -54115.8, 597.7 ), ( 0, 17, 0 ), "activity_nexus_spatial_zone", undefined, "join_radius", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 2500 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_04_ob_activity_cradle_vent_cs";
    s.activity_bundle = "sat_activitydefinition_cradle_vents";
    s.name = "CRADLE_VENTS_HELIPAD";
    fe [[ f ]]( s, "CRADLE_VENTS_HELIPAD", cf, ( 53381.8, -45103, 2021.45 ), ( 0, 83.1, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_04_ob_activity_cradle_vent_cs";
    fe [[ f ]]( s, "CRADLE_VENTS_HELIPAD", cf, ( 53280.8, -45219.9, 2015.64 ), ( 0, 308.1, 0 ), "activity_nexus_spatial_zone", undefined, "join_radius", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 2500 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_04_ob_activity_cradle_vent_cs";
    s.activity_bundle = "sat_activitydefinition_cradle_vents";
    s.name = "CRADLE_VENTS_WATER_TREATMENT";
    fe [[ f ]]( s, "CRADLE_VENTS_WATER_TREATMENT", cf, ( 44379.2, -16427.8, 608.25 ), ( 0, 218.3, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_04_ob_activity_cradle_vent_cs";
    fe [[ f ]]( s, "CRADLE_VENTS_WATER_TREATMENT", cf, ( 44533.3, -16416.1, 606.96 ), ( 0, 83.3, 0 ), "activity_nexus_spatial_zone", undefined, "join_radius", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 2500 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_04_ob_activity_cradle_vent_cs";
    s.activity_bundle = "sat_activitydefinition_cradle_vents";
    s.name = "CRADLE_VENTS_FIRING_RANGE";
    fe [[ f ]]( s, "CRADLE_VENTS_FIRING_RANGE", cf, ( 54738.5, 6450.9, 1915.25 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_04_ob_activity_cradle_vent_cs";
    fe [[ f ]]( s, "CRADLE_VENTS_FIRING_RANGE", cf, ( 54851.9, 6337.7, 1917.91 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "join_radius", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 2500 );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace mp_sat_avalon_quad_04_ob_activity_cradle_vent_cs
// Params 0, eflags: 0x4
// Checksum 0x565bd3d6, Offset: 0x742
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace mp_sat_avalon_quad_04_ob_activity_cradle_vent_cs
// Params 0
// Checksum 0xec899a75, Offset: 0x74c
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "mp_sat_avalon_quad_04_ob_activity_cradle_vent_cs" );
}

// Namespace mp_sat_avalon_quad_04_ob_activity_cradle_vent_cs
// Params 0
// Checksum 0x81ad4d44, Offset: 0x762
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

// Namespace mp_sat_avalon_quad_04_ob_activity_cradle_vent_cs
// Params 4
// Checksum 0xbeeaaf67, Offset: 0x7d1
// Size: 0xa5
function function_d4323822d7042e5a( var_4312b79c960726b6, fe, us, cf = "mp_sat_avalon_quad_04_ob_activity_cradle_vent_cs" )
{
    switch ( var_4312b79c960726b6 )
    {
        case #"hash_28df9ffb02cfd227":
            function_1a79b73f9adbbd3f( fe, us, cf );
            break;
        case #"hash_71cef6ad5337c163":
            function_85113c5c10b3d98b( fe, us, cf );
            break;
        case #"hash_26ef170d55e4bc06":
            function_986dbcf3a5d5b2ae( fe, us, cf );
            break;
        case #"hash_42c3615286c2e22f":
            function_be20b6c81b4eea47( fe, us, cf );
            break;
    }
}

// Namespace mp_sat_avalon_quad_04_ob_activity_cradle_vent_cs
// Params 3
// Checksum 0xfceb250c, Offset: 0x87e
// Size: 0xab
function function_1a79b73f9adbbd3f( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_04_ob_activity_cradle_vent_cs";
    s.name = "power_core";
    fe [[ f ]]( s, "CRADLE_VENTS_RECYCLE", cf, ( 43617.4, -54140, 597.67 ), ( 0, 127.69, 0 ), "power_core", undefined, "CRADLE_VENTS_RECYCLE", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_sat_avalon_quad_04_ob_activity_cradle_vent_cs
// Params 3
// Checksum 0x31b9c5a5, Offset: 0x931
// Size: 0xab
function function_85113c5c10b3d98b( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_04_ob_activity_cradle_vent_cs";
    s.name = "power_core";
    fe [[ f ]]( s, "CRADLE_VENTS_HELIPAD", cf, ( 53244.7, -45193.6, 2015.86 ), ( 0, 58.79, 0 ), "power_core", undefined, "CRADLE_VENTS_HELIPAD", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_sat_avalon_quad_04_ob_activity_cradle_vent_cs
// Params 3
// Checksum 0x5c8e1e0b, Offset: 0x9e4
// Size: 0xab
function function_986dbcf3a5d5b2ae( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_04_ob_activity_cradle_vent_cs";
    s.name = "power_core";
    fe [[ f ]]( s, "CRADLE_VENTS_WATER_TREATMENT", cf, ( 44540.3, -16460.2, 602.75 ), ( 0, 193.99, 0 ), "power_core", undefined, "CRADLE_VENTS_WATER_TREATMENT", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_sat_avalon_quad_04_ob_activity_cradle_vent_cs
// Params 3
// Checksum 0x5a5aec1c, Offset: 0xa97
// Size: 0xab
function function_be20b6c81b4eea47( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_04_ob_activity_cradle_vent_cs";
    s.name = "power_core";
    fe [[ f ]]( s, "CRADLE_VENTS_FIRING_RANGE", cf, ( 54823, 6303.6, 1917.16 ), ( 0, 144.69, 0 ), "power_core", undefined, "CRADLE_VENTS_FIRING_RANGE", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_sat_avalon_quad_04_ob_activity_cradle_vent_cs
// Params 0
// Checksum 0xb9911dff, Offset: 0xb4a
// Size: 0x26d
function function_d9dd7965c51c95d1()
{
    activityinstances = [];
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_activitydefinition_cradle_vents";
    var_881289d7987bc770.cf = "mp_sat_avalon_quad_04_ob_activity_cradle_vent_cs";
    var_881289d7987bc770.scriptstructorigin = ( 43582.2, -53979.5, 597.67 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [];
    var_881289d7987bc770.var_31ce4477e3543d24 = [];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [];
    var_881289d7987bc770.locationradius = [];
    activityinstances[ "CRADLE_VENTS_RECYCLE" ] = var_881289d7987bc770;
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_activitydefinition_cradle_vents";
    var_881289d7987bc770.cf = "mp_sat_avalon_quad_04_ob_activity_cradle_vent_cs";
    var_881289d7987bc770.scriptstructorigin = ( 53381.8, -45103, 2021.45 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [];
    var_881289d7987bc770.var_31ce4477e3543d24 = [];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [];
    var_881289d7987bc770.locationradius = [];
    activityinstances[ "CRADLE_VENTS_HELIPAD" ] = var_881289d7987bc770;
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_activitydefinition_cradle_vents";
    var_881289d7987bc770.cf = "mp_sat_avalon_quad_04_ob_activity_cradle_vent_cs";
    var_881289d7987bc770.scriptstructorigin = ( 44379.2, -16427.8, 608.25 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [];
    var_881289d7987bc770.var_31ce4477e3543d24 = [];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [];
    var_881289d7987bc770.locationradius = [];
    activityinstances[ "CRADLE_VENTS_WATER_TREATMENT" ] = var_881289d7987bc770;
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_activitydefinition_cradle_vents";
    var_881289d7987bc770.cf = "mp_sat_avalon_quad_04_ob_activity_cradle_vent_cs";
    var_881289d7987bc770.scriptstructorigin = ( 54738.5, 6450.9, 1915.25 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [];
    var_881289d7987bc770.var_31ce4477e3543d24 = [];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [];
    var_881289d7987bc770.locationradius = [];
    activityinstances[ "CRADLE_VENTS_FIRING_RANGE" ] = var_881289d7987bc770;
    return activityinstances;
}

