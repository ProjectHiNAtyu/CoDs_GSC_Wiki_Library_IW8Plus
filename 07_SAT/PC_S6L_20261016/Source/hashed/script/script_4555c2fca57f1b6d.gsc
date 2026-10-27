// script_4555c2fca57f1b6d  (hash_4555c2fca57f1b6d.gscc) (size: 4501 Bytes / 0x1195 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x2891c920 (680642848)
// size ...... 4501 (0x1195)
// includes .. 4   (offset: 0x1061)
// strings ... 11  (offset: 0x1081)
// dev strs .. 0   (offset: 0x1195)
// exports ... 16  (offset: 0xac1)
// cseg ...... 0x184 + 0x93d (0xac1)
// imports ... 28  (offset: 0xd41)
// animtree1 . 0   (offset: 0x1195)
// animtree2 . 0   (offset: 0x1195)
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace mp_sat_avalon_city_ob_activity_harvester_orb_cs;

// Namespace mp_sat_avalon_city_ob_activity_harvester_orb_cs
// Params 0, eflags: 0x5
// Checksum 0x7e99161c, Offset: 0x1a2
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"mp_sat_avalon_city_ob_activity_harvester_orb_cs", #"activity_common", &function_b39ecd3d51489472, undefined );
}

// Namespace mp_sat_avalon_city_ob_activity_harvester_orb_cs
// Params 0, eflags: 0x4
// Checksum 0x3bbd71ae, Offset: 0x1cb
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace mp_sat_avalon_city_ob_activity_harvester_orb_cs
// Params 0, eflags: 0x4
// Checksum 0x4caba7ec, Offset: 0x1dc
// Size: 0x15
function private structs_init()
{
    main();
    activity_common::function_e1df676808c1d1e3( &function_4cd78e661617f3 );
}

// Namespace mp_sat_avalon_city_ob_activity_harvester_orb_cs
// Params 2
// Checksum 0x4cbf2159, Offset: 0x1f9
// Size: 0x70
function main( unused, unused2 )
{
    if ( utility::flag_exist( "mp_sat_avalon_city_ob_activity_harvester_orb_cs" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "mp_sat_avalon_city_ob_activity_harvester_orb_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "mp_sat_avalon_city_ob_activity_harvester_orb_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace mp_sat_avalon_city_ob_activity_harvester_orb_cs
// Params 3, eflags: 0x4
// Checksum 0x3d04168d, Offset: 0x271
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "mp_sat_avalon_city_ob_activity_harvester_orb_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "mp_sat_avalon_city_ob_activity_harvester_orb_cs" );
}

// Namespace mp_sat_avalon_city_ob_activity_harvester_orb_cs
// Params 3, eflags: 0x4
// Checksum 0xea1abcff, Offset: 0x2eb
// Size: 0x260
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_harvester_orb_cs";
    s.activity_bundle = "sat_activitydef_harvesterorb";
    s.name = "HARVESTERORB_CITY_HIGHTOWN";
    fe [[ f ]]( s, "HARVESTERORB_CITY_HIGHTOWN", cf, ( -23349.9, 13321.7, 1322.42 ), ( 0, 0, 0 ), undefined, undefined, "activity_nexus_variant", "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_harvester_orb_cs";
    s.activity_bundle = "sat_activitydef_harvesterorb";
    s.name = "HARVESTERORB_CITY_LOWTOWN";
    fe [[ f ]]( s, "HARVESTERORB_CITY_LOWTOWN", cf, ( 4592.1, 8664.7, 85.32 ), ( 0, 0, 0 ), undefined, undefined, "activity_nexus_variant", "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_harvester_orb_cs";
    s.activity_bundle = "sat_activitydef_harvesterorb";
    s.name = "HARVESTERORB_CITY_HIGHTTOWN_PARK";
    fe [[ f ]]( s, "HARVESTERORB_CITY_HIGHTTOWN_PARK", cf, ( -13534.9, -3651.3, 837.03 ), ( 0, 0, 0 ), undefined, undefined, "activity_nexus_variant", "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_harvester_orb_cs";
    s.activity_bundle = "sat_activitydef_harvesterorb";
    s.name = "HARVESTERORB_CITY_CLIFF";
    fe [[ f ]]( s, "HARVESTERORB_CITY_CLIFF", cf, ( 3022.1, -7518.3, 1282 ), ( 0, 0, 0 ), undefined, undefined, "activity_nexus_variant", "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace mp_sat_avalon_city_ob_activity_harvester_orb_cs
// Params 0, eflags: 0x4
// Checksum 0xebc645e8, Offset: 0x553
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace mp_sat_avalon_city_ob_activity_harvester_orb_cs
// Params 0
// Checksum 0xff57cbc0, Offset: 0x55d
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "mp_sat_avalon_city_ob_activity_harvester_orb_cs" );
}

// Namespace mp_sat_avalon_city_ob_activity_harvester_orb_cs
// Params 0
// Checksum 0x7755fa8f, Offset: 0x573
// Size: 0x66
function function_4cd78e661617f3()
{
    activityinfostruct = {};
    activityinfostruct.name = "REV_OB_HARVESTERORB";
    activityinfostruct.scriptbundle = "sat_activitydef_harvesterorb";
    activityinfostruct.mainfunction = &main;
    activityinfostruct.var_934f068483ae4ddb = &function_d4323822d7042e5a;
    activityinfostruct.metadatafunction = &function_d9dd7965c51c95d1;
    return activityinfostruct;
}

// Namespace mp_sat_avalon_city_ob_activity_harvester_orb_cs
// Params 4
// Checksum 0xb03d3656, Offset: 0x5e2
// Size: 0xa5
function function_d4323822d7042e5a( var_4312b79c960726b6, fe, us, cf = "mp_sat_avalon_city_ob_activity_harvester_orb_cs" )
{
    switch ( var_4312b79c960726b6 )
    {
        case #"hash_3c256faeb360c58d":
            function_efbf2b33c9360055( fe, us, cf );
            break;
        case #"hash_51b07680fa506071":
            function_f543ed18b6df6b79( fe, us, cf );
            break;
        case #"hash_53d2d47ae5c57fd0":
            function_2925b21270e8c4f8( fe, us, cf );
            break;
        case #"hash_25c321b8cc1dd8f1":
            function_9ac96613bf86d759( fe, us, cf );
            break;
    }
}

// Namespace mp_sat_avalon_city_ob_activity_harvester_orb_cs
// Params 3
// Checksum 0x33e28a81, Offset: 0x68f
// Size: 0x2f
function function_efbf2b33c9360055( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
}

// Namespace mp_sat_avalon_city_ob_activity_harvester_orb_cs
// Params 3
// Checksum 0x6d3d0621, Offset: 0x6c6
// Size: 0x2f
function function_f543ed18b6df6b79( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
}

// Namespace mp_sat_avalon_city_ob_activity_harvester_orb_cs
// Params 3
// Checksum 0x3b9395d5, Offset: 0x6fd
// Size: 0x2f
function function_2925b21270e8c4f8( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
}

// Namespace mp_sat_avalon_city_ob_activity_harvester_orb_cs
// Params 3
// Checksum 0x768578, Offset: 0x734
// Size: 0x2f
function function_9ac96613bf86d759( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
}

// Namespace mp_sat_avalon_city_ob_activity_harvester_orb_cs
// Params 0
// Checksum 0x3658e2f7, Offset: 0x76b
// Size: 0x355
function function_d9dd7965c51c95d1()
{
    activityinstances = [];
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_activitydef_harvesterorb";
    var_881289d7987bc770.cf = "mp_sat_avalon_city_ob_activity_harvester_orb_cs";
    var_881289d7987bc770.scriptstructorigin = ( -23349.9, 13321.7, 1322.42 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [ ( -23349.9, 13321.7, 1322.42 ) ];
    var_881289d7987bc770.var_31ce4477e3543d24 = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.locationradius = [ 1000 ];
    activityinstances[ "HARVESTERORB_CITY_HIGHTOWN" ] = var_881289d7987bc770;
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_activitydef_harvesterorb";
    var_881289d7987bc770.cf = "mp_sat_avalon_city_ob_activity_harvester_orb_cs";
    var_881289d7987bc770.scriptstructorigin = ( 4592.1, 8664.7, 85.32 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [ ( 4592.1, 8664.7, 85.32 ) ];
    var_881289d7987bc770.var_31ce4477e3543d24 = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.locationradius = [ 1000 ];
    activityinstances[ "HARVESTERORB_CITY_LOWTOWN" ] = var_881289d7987bc770;
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_activitydef_harvesterorb";
    var_881289d7987bc770.cf = "mp_sat_avalon_city_ob_activity_harvester_orb_cs";
    var_881289d7987bc770.scriptstructorigin = ( -13534.9, -3651.3, 837.03 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [ ( -13534.9, -3651.3, 837.03 ) ];
    var_881289d7987bc770.var_31ce4477e3543d24 = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.locationradius = [ 1000 ];
    activityinstances[ "HARVESTERORB_CITY_HIGHTTOWN_PARK" ] = var_881289d7987bc770;
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_activitydef_harvesterorb";
    var_881289d7987bc770.cf = "mp_sat_avalon_city_ob_activity_harvester_orb_cs";
    var_881289d7987bc770.scriptstructorigin = ( 3022.1, -7518.3, 1282 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [ ( 3022.1, -7518.3, 1282 ) ];
    var_881289d7987bc770.var_31ce4477e3543d24 = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.locationradius = [ 1000 ];
    activityinstances[ "HARVESTERORB_CITY_CLIFF" ] = var_881289d7987bc770;
    return activityinstances;
}

