// script_65832207846ffee6  (hash_65832207846ffee6.gscc) (size: 4482 Bytes / 0x1182 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xbeb24c1c (3199355932)
// size ...... 4482 (0x1182)
// includes .. 4   (offset: 0x104e)
// strings ... 11  (offset: 0x106e)
// dev strs .. 0   (offset: 0x1182)
// exports ... 16  (offset: 0xaae)
// cseg ...... 0x171 + 0x93d (0xaae)
// imports ... 28  (offset: 0xd2e)
// animtree1 . 0   (offset: 0x1182)
// animtree2 . 0   (offset: 0x1182)
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace mp_sat_avalon_q1_ob_activity_harvester_orb_cs;

// Namespace mp_sat_avalon_q1_ob_activity_harvester_orb_cs
// Params 0, eflags: 0x5
// Checksum 0x8001d281, Offset: 0x18f
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"mp_sat_avalon_q1_ob_activity_harvester_orb_cs", #"activity_common", &function_b39ecd3d51489472, undefined );
}

// Namespace mp_sat_avalon_q1_ob_activity_harvester_orb_cs
// Params 0, eflags: 0x4
// Checksum 0x940e3d84, Offset: 0x1b8
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace mp_sat_avalon_q1_ob_activity_harvester_orb_cs
// Params 0, eflags: 0x4
// Checksum 0x8587f2af, Offset: 0x1c9
// Size: 0x15
function private structs_init()
{
    main();
    activity_common::function_e1df676808c1d1e3( &function_4cd78e661617f3 );
}

// Namespace mp_sat_avalon_q1_ob_activity_harvester_orb_cs
// Params 2
// Checksum 0x8593741a, Offset: 0x1e6
// Size: 0x70
function main( unused, unused2 )
{
    if ( utility::flag_exist( "mp_sat_avalon_q1_ob_activity_harvester_orb_cs" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "mp_sat_avalon_q1_ob_activity_harvester_orb_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "mp_sat_avalon_q1_ob_activity_harvester_orb_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace mp_sat_avalon_q1_ob_activity_harvester_orb_cs
// Params 3, eflags: 0x4
// Checksum 0x92b75aa7, Offset: 0x25e
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "mp_sat_avalon_q1_ob_activity_harvester_orb_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "mp_sat_avalon_q1_ob_activity_harvester_orb_cs" );
}

// Namespace mp_sat_avalon_q1_ob_activity_harvester_orb_cs
// Params 3, eflags: 0x4
// Checksum 0x445922ec, Offset: 0x2d8
// Size: 0x260
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_harvester_orb_cs";
    s.activity_bundle = "sat_activitydef_harvesterorb";
    s.name = "HARVESTERORB_Q1_GOLF";
    fe [[ f ]]( s, "HARVESTERORB_Q1_GOLF", cf, ( -27349.3, 44012.3, 1668.39 ), ( 0, 0, 0 ), undefined, undefined, "activity_nexus_variant", "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_harvester_orb_cs";
    s.activity_bundle = "sat_activitydef_harvesterorb";
    s.name = "HARVESTERORB_Q1_SUBURBS";
    fe [[ f ]]( s, "HARVESTERORB_Q1_SUBURBS", cf, ( -4976.64, 48358.9, 508.5 ), ( 0, 0, 0 ), undefined, undefined, "activity_nexus_variant", "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_harvester_orb_cs";
    s.activity_bundle = "sat_activitydef_harvesterorb";
    s.name = "HARVESTERORB_Q1_STADIUM";
    fe [[ f ]]( s, "HARVESTERORB_Q1_STADIUM", cf, ( -44503.9, 15255.7, 238.16 ), ( 0, 0, 0 ), undefined, undefined, "activity_nexus_variant", "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_harvester_orb_cs";
    s.activity_bundle = "sat_activitydef_harvesterorb";
    s.name = "HARVESTERORB_Q1_MANSION";
    fe [[ f ]]( s, "HARVESTERORB_Q1_MANSION", cf, ( -55014.9, 3064.7, 357.84 ), ( 0, 0, 0 ), undefined, undefined, "activity_nexus_variant", "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace mp_sat_avalon_q1_ob_activity_harvester_orb_cs
// Params 0, eflags: 0x4
// Checksum 0x22ea10ab, Offset: 0x540
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace mp_sat_avalon_q1_ob_activity_harvester_orb_cs
// Params 0
// Checksum 0x50e487ea, Offset: 0x54a
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "mp_sat_avalon_q1_ob_activity_harvester_orb_cs" );
}

// Namespace mp_sat_avalon_q1_ob_activity_harvester_orb_cs
// Params 0
// Checksum 0xd8e6b6a5, Offset: 0x560
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

// Namespace mp_sat_avalon_q1_ob_activity_harvester_orb_cs
// Params 4
// Checksum 0x45d56c70, Offset: 0x5cf
// Size: 0xa5
function function_d4323822d7042e5a( var_4312b79c960726b6, fe, us, cf = "mp_sat_avalon_q1_ob_activity_harvester_orb_cs" )
{
    switch ( var_4312b79c960726b6 )
    {
        case #"hash_3f55ba7a91aee126":
            function_f3f618eb0845ff7e( fe, us, cf );
            break;
        case #"hash_df17f490f2b114d4":
            function_3b2c8b938869ff9c( fe, us, cf );
            break;
        case #"hash_ed5478836a5b725d":
            function_1dc994ae028d09c5( fe, us, cf );
            break;
        case #"hash_5a97c21ece27d033":
            function_5f0e1ebba935a22b( fe, us, cf );
            break;
    }
}

// Namespace mp_sat_avalon_q1_ob_activity_harvester_orb_cs
// Params 3
// Checksum 0xc41cfe28, Offset: 0x67c
// Size: 0x2f
function function_f3f618eb0845ff7e( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
}

// Namespace mp_sat_avalon_q1_ob_activity_harvester_orb_cs
// Params 3
// Checksum 0x8c633945, Offset: 0x6b3
// Size: 0x2f
function function_3b2c8b938869ff9c( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
}

// Namespace mp_sat_avalon_q1_ob_activity_harvester_orb_cs
// Params 3
// Checksum 0x7c555ae, Offset: 0x6ea
// Size: 0x2f
function function_1dc994ae028d09c5( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
}

// Namespace mp_sat_avalon_q1_ob_activity_harvester_orb_cs
// Params 3
// Checksum 0x5857283, Offset: 0x721
// Size: 0x2f
function function_5f0e1ebba935a22b( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
}

// Namespace mp_sat_avalon_q1_ob_activity_harvester_orb_cs
// Params 0
// Checksum 0x959fae41, Offset: 0x758
// Size: 0x355
function function_d9dd7965c51c95d1()
{
    activityinstances = [];
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_activitydef_harvesterorb";
    var_881289d7987bc770.cf = "mp_sat_avalon_q1_ob_activity_harvester_orb_cs";
    var_881289d7987bc770.scriptstructorigin = ( -27349.3, 44012.3, 1668.39 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [ ( -27349.3, 44012.3, 1668.39 ) ];
    var_881289d7987bc770.var_31ce4477e3543d24 = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.locationradius = [ 1000 ];
    activityinstances[ "HARVESTERORB_Q1_GOLF" ] = var_881289d7987bc770;
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_activitydef_harvesterorb";
    var_881289d7987bc770.cf = "mp_sat_avalon_q1_ob_activity_harvester_orb_cs";
    var_881289d7987bc770.scriptstructorigin = ( -4976.64, 48358.9, 508.5 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [ ( -4976.64, 48358.9, 508.5 ) ];
    var_881289d7987bc770.var_31ce4477e3543d24 = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.locationradius = [ 1000 ];
    activityinstances[ "HARVESTERORB_Q1_SUBURBS" ] = var_881289d7987bc770;
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_activitydef_harvesterorb";
    var_881289d7987bc770.cf = "mp_sat_avalon_q1_ob_activity_harvester_orb_cs";
    var_881289d7987bc770.scriptstructorigin = ( -44503.9, 15255.7, 238.16 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [ ( -44503.9, 15255.7, 238.16 ) ];
    var_881289d7987bc770.var_31ce4477e3543d24 = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.locationradius = [ 1000 ];
    activityinstances[ "HARVESTERORB_Q1_STADIUM" ] = var_881289d7987bc770;
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_activitydef_harvesterorb";
    var_881289d7987bc770.cf = "mp_sat_avalon_q1_ob_activity_harvester_orb_cs";
    var_881289d7987bc770.scriptstructorigin = ( -55014.9, 3064.7, 357.84 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [ ( -55014.9, 3064.7, 357.84 ) ];
    var_881289d7987bc770.var_31ce4477e3543d24 = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.locationradius = [ 1000 ];
    activityinstances[ "HARVESTERORB_Q1_MANSION" ] = var_881289d7987bc770;
    return activityinstances;
}

