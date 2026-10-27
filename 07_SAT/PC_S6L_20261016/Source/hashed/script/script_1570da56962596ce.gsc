// script_1570da56962596ce  (hash_1570da56962596ce.gscc) (size: 4488 Bytes / 0x1188 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x3f4cdf5 (66375157)
// size ...... 4488 (0x1188)
// includes .. 4   (offset: 0x1054)
// strings ... 11  (offset: 0x1074)
// dev strs .. 0   (offset: 0x1188)
// exports ... 16  (offset: 0xab4)
// cseg ...... 0x177 + 0x93d (0xab4)
// imports ... 28  (offset: 0xd34)
// animtree1 . 0   (offset: 0x1188)
// animtree2 . 0   (offset: 0x1188)
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace mp_sat_avalon_q4_ob_activity_harvester_orb_cs;

// Namespace mp_sat_avalon_q4_ob_activity_harvester_orb_cs
// Params 0, eflags: 0x5
// Checksum 0xaa48c999, Offset: 0x195
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"mp_sat_avalon_q4_ob_activity_harvester_orb_cs", #"activity_common", &function_b39ecd3d51489472, undefined );
}

// Namespace mp_sat_avalon_q4_ob_activity_harvester_orb_cs
// Params 0, eflags: 0x4
// Checksum 0x1e884785, Offset: 0x1be
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace mp_sat_avalon_q4_ob_activity_harvester_orb_cs
// Params 0, eflags: 0x4
// Checksum 0xc2e2e786, Offset: 0x1cf
// Size: 0x15
function private structs_init()
{
    main();
    activity_common::function_e1df676808c1d1e3( &function_4cd78e661617f3 );
}

// Namespace mp_sat_avalon_q4_ob_activity_harvester_orb_cs
// Params 2
// Checksum 0xc2f66133, Offset: 0x1ec
// Size: 0x70
function main( unused, unused2 )
{
    if ( utility::flag_exist( "mp_sat_avalon_q4_ob_activity_harvester_orb_cs" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "mp_sat_avalon_q4_ob_activity_harvester_orb_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "mp_sat_avalon_q4_ob_activity_harvester_orb_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace mp_sat_avalon_q4_ob_activity_harvester_orb_cs
// Params 3, eflags: 0x4
// Checksum 0x183120a6, Offset: 0x264
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "mp_sat_avalon_q4_ob_activity_harvester_orb_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "mp_sat_avalon_q4_ob_activity_harvester_orb_cs" );
}

// Namespace mp_sat_avalon_q4_ob_activity_harvester_orb_cs
// Params 3, eflags: 0x4
// Checksum 0xcc967492, Offset: 0x2de
// Size: 0x260
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_harvester_orb_cs";
    s.activity_bundle = "sat_activitydef_harvesterorb";
    s.name = "HARVESTERORB_Q4_SHIPYARD";
    fe [[ f ]]( s, "HARVESTERORB_Q4_SHIPYARD", cf, ( 31977.9, -42767.5, 1087.97 ), ( 0, 0, 0 ), undefined, undefined, "activity_nexus_variant", "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_harvester_orb_cs";
    s.activity_bundle = "sat_activitydef_harvesterorb";
    s.name = "HARVESTERORB_Q4_HELIPORT";
    fe [[ f ]]( s, "HARVESTERORB_Q4_HELIPORT", cf, ( 26673.2, -17832.5, 280.74 ), ( 0, 0, 0 ), undefined, undefined, "activity_nexus_variant", "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_harvester_orb_cs";
    s.activity_bundle = "sat_activitydef_harvesterorb";
    s.name = "HARVESTERORB_Q4_TOWER";
    fe [[ f ]]( s, "HARVESTERORB_Q4_TOWER", cf, ( 59339.6, -35561.5, 2448.29 ), ( 0, 0, 0 ), undefined, undefined, "activity_nexus_variant", "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_harvester_orb_cs";
    s.activity_bundle = "sat_activitydef_harvesterorb";
    s.name = "HARVESTERORB_Q4_CHECKPOINT";
    fe [[ f ]]( s, "HARVESTERORB_Q4_CHECKPOINT", cf, ( 60056.9, -6655.5, 1215.45 ), ( 0, 0, 0 ), undefined, undefined, "activity_nexus_variant", "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace mp_sat_avalon_q4_ob_activity_harvester_orb_cs
// Params 0, eflags: 0x4
// Checksum 0x658f0582, Offset: 0x546
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace mp_sat_avalon_q4_ob_activity_harvester_orb_cs
// Params 0
// Checksum 0xda62fdeb, Offset: 0x550
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "mp_sat_avalon_q4_ob_activity_harvester_orb_cs" );
}

// Namespace mp_sat_avalon_q4_ob_activity_harvester_orb_cs
// Params 0
// Checksum 0x5260cca4, Offset: 0x566
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

// Namespace mp_sat_avalon_q4_ob_activity_harvester_orb_cs
// Params 4
// Checksum 0x320644a4, Offset: 0x5d5
// Size: 0xa5
function function_d4323822d7042e5a( var_4312b79c960726b6, fe, us, cf = "mp_sat_avalon_q4_ob_activity_harvester_orb_cs" )
{
    switch ( var_4312b79c960726b6 )
    {
        case #"hash_c63fe632823f1d41":
            function_a328910229847989( fe, us, cf );
            break;
        case #"hash_f662d00507e21e98":
            function_1463d99cb5747850( fe, us, cf );
            break;
        case #"hash_677c6ec361894664":
            function_7dcd8b0253c3f69c( fe, us, cf );
            break;
        case #"hash_791887c5eb55e115":
            function_44735c93d039fdfd( fe, us, cf );
            break;
    }
}

// Namespace mp_sat_avalon_q4_ob_activity_harvester_orb_cs
// Params 3
// Checksum 0x39766d82, Offset: 0x682
// Size: 0x2f
function function_a328910229847989( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
}

// Namespace mp_sat_avalon_q4_ob_activity_harvester_orb_cs
// Params 3
// Checksum 0x2e6c379b, Offset: 0x6b9
// Size: 0x2f
function function_1463d99cb5747850( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
}

// Namespace mp_sat_avalon_q4_ob_activity_harvester_orb_cs
// Params 3
// Checksum 0x3e9426b6, Offset: 0x6f0
// Size: 0x2f
function function_7dcd8b0253c3f69c( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
}

// Namespace mp_sat_avalon_q4_ob_activity_harvester_orb_cs
// Params 3
// Checksum 0xe9959cd8, Offset: 0x727
// Size: 0x2f
function function_44735c93d039fdfd( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
}

// Namespace mp_sat_avalon_q4_ob_activity_harvester_orb_cs
// Params 0
// Checksum 0xa58f2070, Offset: 0x75e
// Size: 0x355
function function_d9dd7965c51c95d1()
{
    activityinstances = [];
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_activitydef_harvesterorb";
    var_881289d7987bc770.cf = "mp_sat_avalon_q4_ob_activity_harvester_orb_cs";
    var_881289d7987bc770.scriptstructorigin = ( 31977.9, -42767.5, 1087.97 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [ ( 31977.9, -42767.5, 1087.97 ) ];
    var_881289d7987bc770.var_31ce4477e3543d24 = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.locationradius = [ 1000 ];
    activityinstances[ "HARVESTERORB_Q4_SHIPYARD" ] = var_881289d7987bc770;
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_activitydef_harvesterorb";
    var_881289d7987bc770.cf = "mp_sat_avalon_q4_ob_activity_harvester_orb_cs";
    var_881289d7987bc770.scriptstructorigin = ( 26673.2, -17832.5, 280.74 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [ ( 26673.2, -17832.5, 280.74 ) ];
    var_881289d7987bc770.var_31ce4477e3543d24 = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.locationradius = [ 1000 ];
    activityinstances[ "HARVESTERORB_Q4_HELIPORT" ] = var_881289d7987bc770;
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_activitydef_harvesterorb";
    var_881289d7987bc770.cf = "mp_sat_avalon_q4_ob_activity_harvester_orb_cs";
    var_881289d7987bc770.scriptstructorigin = ( 59339.6, -35561.5, 2448.29 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [ ( 59339.6, -35561.5, 2448.29 ) ];
    var_881289d7987bc770.var_31ce4477e3543d24 = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.locationradius = [ 1000 ];
    activityinstances[ "HARVESTERORB_Q4_TOWER" ] = var_881289d7987bc770;
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_activitydef_harvesterorb";
    var_881289d7987bc770.cf = "mp_sat_avalon_q4_ob_activity_harvester_orb_cs";
    var_881289d7987bc770.scriptstructorigin = ( 60056.9, -6655.5, 1215.45 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [ ( 60056.9, -6655.5, 1215.45 ) ];
    var_881289d7987bc770.var_31ce4477e3543d24 = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.locationradius = [ 1000 ];
    activityinstances[ "HARVESTERORB_Q4_CHECKPOINT" ] = var_881289d7987bc770;
    return activityinstances;
}

