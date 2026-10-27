// script_750f050da97ad8ae  (hash_750f050da97ad8ae.gscc) (size: 4538 Bytes / 0x11ba / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x2841c4e6 (675398886)
// size ...... 4538 (0x11ba)
// includes .. 4   (offset: 0x1082)
// strings ... 11  (offset: 0x10a2)
// dev strs .. 0   (offset: 0x11ba)
// exports ... 16  (offset: 0xac6)
// cseg ...... 0x179 + 0x94d (0xac6)
// imports ... 29  (offset: 0xd46)
// animtree1 . 0   (offset: 0x11ba)
// animtree2 . 0   (offset: 0x11ba)
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace mp_sat_avalon_q3_ob_activity_harvester_orb_cs;

// Namespace mp_sat_avalon_q3_ob_activity_harvester_orb_cs
// Params 0, eflags: 0x5
// Checksum 0x7b1e1049, Offset: 0x197
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"mp_sat_avalon_q3_ob_activity_harvester_orb_cs", #"activity_common", &function_b39ecd3d51489472, undefined );
}

// Namespace mp_sat_avalon_q3_ob_activity_harvester_orb_cs
// Params 0, eflags: 0x4
// Checksum 0xb2e06c1a, Offset: 0x1c0
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace mp_sat_avalon_q3_ob_activity_harvester_orb_cs
// Params 0, eflags: 0x4
// Checksum 0x37dbbff6, Offset: 0x1d1
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace mp_sat_avalon_q3_ob_activity_harvester_orb_cs
// Params 2
// Checksum 0x6b413368, Offset: 0x1e2
// Size: 0x8c
function main( unused, unused2 )
{
    if ( utility::flag_exist( "mp_sat_avalon_q3_ob_activity_harvester_orb_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "mp_sat_avalon_q3_ob_activity_harvester_orb_cs" ) )
    {
        return;
    }
    
    activity_common::function_e1df676808c1d1e3( &function_4cd78e661617f3 );
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "mp_sat_avalon_q3_ob_activity_harvester_orb_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "mp_sat_avalon_q3_ob_activity_harvester_orb_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace mp_sat_avalon_q3_ob_activity_harvester_orb_cs
// Params 3, eflags: 0x4
// Checksum 0xb4590b39, Offset: 0x276
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "mp_sat_avalon_q3_ob_activity_harvester_orb_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "mp_sat_avalon_q3_ob_activity_harvester_orb_cs" );
}

// Namespace mp_sat_avalon_q3_ob_activity_harvester_orb_cs
// Params 3, eflags: 0x4
// Checksum 0x6383bf74, Offset: 0x2f0
// Size: 0x260
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_harvester_orb_cs";
    s.activity_bundle = "sat_activitydef_harvesterorb";
    s.name = "HARVESTERORB_Q3_TRAININGSITE";
    fe [[ f ]]( s, "HARVESTERORB_Q3_TRAININGSITE", cf, ( -26519.6, -29173.5, 929.92 ), ( 0, 0, 0 ), undefined, undefined, "activity_nexus_variant", "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_harvester_orb_cs";
    s.activity_bundle = "sat_activitydef_harvesterorb";
    s.name = "HARVESTERORB_Q3_LISTENINGPOS";
    fe [[ f ]]( s, "HARVESTERORB_Q3_LISTENINGPOS", cf, ( -28126.4, -40266.9, 709.72 ), ( 0, 0, 0 ), undefined, undefined, "activity_nexus_variant", "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_harvester_orb_cs";
    s.activity_bundle = "sat_activitydef_harvesterorb";
    s.name = "HARVESTERORB_Q3_DOCK";
    fe [[ f ]]( s, "HARVESTERORB_Q3_DOCK", cf, ( -44151.9, -37333.3, 246.5 ), ( 0, 0, 0 ), undefined, undefined, "activity_nexus_variant", "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_harvester_orb_cs";
    s.activity_bundle = "sat_activitydef_harvesterorb";
    s.name = "HARVESTERORB_Q3_RUINS";
    fe [[ f ]]( s, "HARVESTERORB_Q3_RUINS", cf, ( -24202.9, -13851.3, 1347.95 ), ( 0, 0, 0 ), undefined, undefined, "activity_nexus_variant", "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace mp_sat_avalon_q3_ob_activity_harvester_orb_cs
// Params 0, eflags: 0x4
// Checksum 0x7cc58725, Offset: 0x558
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace mp_sat_avalon_q3_ob_activity_harvester_orb_cs
// Params 0
// Checksum 0x760ad674, Offset: 0x562
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "mp_sat_avalon_q3_ob_activity_harvester_orb_cs" );
}

// Namespace mp_sat_avalon_q3_ob_activity_harvester_orb_cs
// Params 0
// Checksum 0xfe08e73b, Offset: 0x578
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

// Namespace mp_sat_avalon_q3_ob_activity_harvester_orb_cs
// Params 4
// Checksum 0x12e5f118, Offset: 0x5e7
// Size: 0xa5
function function_d4323822d7042e5a( var_4312b79c960726b6, fe, us, cf = "mp_sat_avalon_q3_ob_activity_harvester_orb_cs" )
{
    switch ( var_4312b79c960726b6 )
    {
        case #"hash_a1e6e65683f21691":
            function_5a4cc412d11d3fd9( fe, us, cf );
            break;
        case #"hash_3e2812291799c6cd":
            function_e93c398826aba665( fe, us, cf );
            break;
        case #"hash_6fc4fba97392e8a3":
            function_44686fa99421493b( fe, us, cf );
            break;
        case #"hash_56b46496a53af087":
            function_4df71d856b2dd5cf( fe, us, cf );
            break;
    }
}

// Namespace mp_sat_avalon_q3_ob_activity_harvester_orb_cs
// Params 3
// Checksum 0x8a386d62, Offset: 0x694
// Size: 0x2f
function function_5a4cc412d11d3fd9( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
}

// Namespace mp_sat_avalon_q3_ob_activity_harvester_orb_cs
// Params 3
// Checksum 0x6a9917f1, Offset: 0x6cb
// Size: 0x2f
function function_e93c398826aba665( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
}

// Namespace mp_sat_avalon_q3_ob_activity_harvester_orb_cs
// Params 3
// Checksum 0x3c670731, Offset: 0x702
// Size: 0x2f
function function_44686fa99421493b( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
}

// Namespace mp_sat_avalon_q3_ob_activity_harvester_orb_cs
// Params 3
// Checksum 0xd0d6bfe3, Offset: 0x739
// Size: 0x2f
function function_4df71d856b2dd5cf( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
}

// Namespace mp_sat_avalon_q3_ob_activity_harvester_orb_cs
// Params 0
// Checksum 0x696cfe78, Offset: 0x770
// Size: 0x355
function function_d9dd7965c51c95d1()
{
    activityinstances = [];
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_activitydef_harvesterorb";
    var_881289d7987bc770.cf = "mp_sat_avalon_q3_ob_activity_harvester_orb_cs";
    var_881289d7987bc770.scriptstructorigin = ( -26519.6, -29173.5, 929.92 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [ ( -26519.6, -29173.5, 929.92 ) ];
    var_881289d7987bc770.var_31ce4477e3543d24 = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.locationradius = [ 1000 ];
    activityinstances[ "HARVESTERORB_Q3_TRAININGSITE" ] = var_881289d7987bc770;
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_activitydef_harvesterorb";
    var_881289d7987bc770.cf = "mp_sat_avalon_q3_ob_activity_harvester_orb_cs";
    var_881289d7987bc770.scriptstructorigin = ( -28126.4, -40266.9, 709.72 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [ ( -28126.4, -40266.9, 709.72 ) ];
    var_881289d7987bc770.var_31ce4477e3543d24 = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.locationradius = [ 1000 ];
    activityinstances[ "HARVESTERORB_Q3_LISTENINGPOS" ] = var_881289d7987bc770;
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_activitydef_harvesterorb";
    var_881289d7987bc770.cf = "mp_sat_avalon_q3_ob_activity_harvester_orb_cs";
    var_881289d7987bc770.scriptstructorigin = ( -44151.9, -37333.3, 246.5 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [ ( -44151.9, -37333.3, 246.5 ) ];
    var_881289d7987bc770.var_31ce4477e3543d24 = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.locationradius = [ 1000 ];
    activityinstances[ "HARVESTERORB_Q3_DOCK" ] = var_881289d7987bc770;
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_activitydef_harvesterorb";
    var_881289d7987bc770.cf = "mp_sat_avalon_q3_ob_activity_harvester_orb_cs";
    var_881289d7987bc770.scriptstructorigin = ( -24202.9, -13851.3, 1347.95 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [ ( -24202.9, -13851.3, 1347.95 ) ];
    var_881289d7987bc770.var_31ce4477e3543d24 = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.locationradius = [ 1000 ];
    activityinstances[ "HARVESTERORB_Q3_RUINS" ] = var_881289d7987bc770;
    return activityinstances;
}

