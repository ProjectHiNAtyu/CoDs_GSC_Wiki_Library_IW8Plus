// script_5b00982ef00ce7ce  (hash_5b00982ef00ce7ce.gscc) (size: 5005 Bytes / 0x138d / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x4b0d6cf8 (1259171064)
// size ...... 5005 (0x138d)
// includes .. 4   (offset: 0x1219)
// strings ... 12  (offset: 0x1239)
// dev strs .. 0   (offset: 0x138d)
// exports ... 16  (offset: 0xc79)
// cseg ...... 0x198 + 0xae1 (0xc79)
// imports ... 28  (offset: 0xef9)
// animtree1 . 0   (offset: 0x138d)
// animtree2 . 0   (offset: 0x138d)
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace mp_sat_avalon_q2_ob_activity_harvester_orb_cs;

// Namespace mp_sat_avalon_q2_ob_activity_harvester_orb_cs
// Params 0, eflags: 0x5
// Checksum 0x946e0c79, Offset: 0x1b6
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"mp_sat_avalon_q2_ob_activity_harvester_orb_cs", #"activity_common", &function_b39ecd3d51489472, undefined );
}

// Namespace mp_sat_avalon_q2_ob_activity_harvester_orb_cs
// Params 0, eflags: 0x4
// Checksum 0xc5546f37, Offset: 0x1df
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace mp_sat_avalon_q2_ob_activity_harvester_orb_cs
// Params 0, eflags: 0x4
// Checksum 0x907c8504, Offset: 0x1f0
// Size: 0x15
function private structs_init()
{
    main();
    activity_common::function_e1df676808c1d1e3( &function_4cd78e661617f3 );
}

// Namespace mp_sat_avalon_q2_ob_activity_harvester_orb_cs
// Params 2
// Checksum 0x906803b1, Offset: 0x20d
// Size: 0x70
function main( unused, unused2 )
{
    if ( utility::flag_exist( "mp_sat_avalon_q2_ob_activity_harvester_orb_cs" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "mp_sat_avalon_q2_ob_activity_harvester_orb_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "mp_sat_avalon_q2_ob_activity_harvester_orb_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace mp_sat_avalon_q2_ob_activity_harvester_orb_cs
// Params 3, eflags: 0x4
// Checksum 0xc3ed0814, Offset: 0x285
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "mp_sat_avalon_q2_ob_activity_harvester_orb_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "mp_sat_avalon_q2_ob_activity_harvester_orb_cs" );
}

// Namespace mp_sat_avalon_q2_ob_activity_harvester_orb_cs
// Params 3, eflags: 0x4
// Checksum 0x1109a113, Offset: 0x2ff
// Size: 0x260
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_harvester_orb_cs";
    s.activity_bundle = "sat_activitydef_harvesterorb";
    s.name = "HARVESTERORB_Q2_WINERY";
    fe [[ f ]]( s, "HARVESTERORB_Q2_WINERY", cf, ( 33709, 37946, 3321.79 ), ( 0, 0, 0 ), undefined, undefined, "activity_nexus_variant", "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_harvester_orb_cs";
    s.activity_bundle = "sat_activitydef_harvesterorb";
    s.name = "HARVESTERORB_Q2_COLOSSEUM";
    fe [[ f ]]( s, "HARVESTERORB_Q2_COLOSSEUM", cf, ( 32632.8, 22789.4, 3236.11 ), ( 0, 0, 0 ), undefined, undefined, "activity_nexus_variant", "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_harvester_orb_cs";
    s.activity_bundle = "sat_activitydef_harvesterorb";
    s.name = "HARVESTERORB_Q2_WINERY_SOUTH";
    fe [[ f ]]( s, "HARVESTERORB_Q2_WINERY_SOUTH", cf, ( 20109.5, 34770.5, 2337.79 ), ( 0, 0, 0 ), undefined, undefined, "activity_nexus_variant", "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_harvester_orb_cs";
    s.activity_bundle = "sat_activitydef_harvesterorb";
    s.name = "HARVESTERORB_Q2_CLIFFTOWN";
    fe [[ f ]]( s, "HARVESTERORB_Q2_CLIFFTOWN", cf, ( 44636.6, 1609.4, 1488.37 ), ( 0, 0, 0 ), undefined, undefined, "activity_nexus_variant", "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace mp_sat_avalon_q2_ob_activity_harvester_orb_cs
// Params 0, eflags: 0x4
// Checksum 0x37116700, Offset: 0x567
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace mp_sat_avalon_q2_ob_activity_harvester_orb_cs
// Params 0
// Checksum 0x1bed559, Offset: 0x571
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "mp_sat_avalon_q2_ob_activity_harvester_orb_cs" );
}

// Namespace mp_sat_avalon_q2_ob_activity_harvester_orb_cs
// Params 0
// Checksum 0x89bce416, Offset: 0x587
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

// Namespace mp_sat_avalon_q2_ob_activity_harvester_orb_cs
// Params 4
// Checksum 0x670aaa57, Offset: 0x5f6
// Size: 0xa5
function function_d4323822d7042e5a( var_4312b79c960726b6, fe, us, cf = "mp_sat_avalon_q2_ob_activity_harvester_orb_cs" )
{
    switch ( var_4312b79c960726b6 )
    {
        case #"hash_9488b3b4b88c7b09":
            function_6df7e8678acd84f1( fe, us, cf );
            break;
        case #"hash_cc9a4d65fc29f4a9":
            function_d4491ecdb52e03d1( fe, us, cf );
            break;
        case #"hash_7f7b6b52d7fef007":
            function_19fc1c3b4228e35f( fe, us, cf );
            break;
        case #"hash_671917c72851adf9":
            function_9e9704a3e0c94ae1( fe, us, cf );
            break;
    }
}

// Namespace mp_sat_avalon_q2_ob_activity_harvester_orb_cs
// Params 3
// Checksum 0xd7e2443d, Offset: 0x6a3
// Size: 0x9a
function function_6df7e8678acd84f1( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_harvester_orb_cs";
    fe [[ f ]]( s, "HARVESTERORB_Q2_WINERY", cf, ( 33709, 37846, 3321.79 ), ( 0, 0, 0 ), "HARVESTERORB_Q2_WINERY", "PRECIOUS_CARGO_CLIFFTOWN", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_sat_avalon_q2_ob_activity_harvester_orb_cs
// Params 3
// Checksum 0xd1b17895, Offset: 0x745
// Size: 0x96
function function_d4491ecdb52e03d1( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_harvester_orb_cs";
    fe [[ f ]]( s, "HARVESTERORB_Q2_COLOSSEUM", cf, ( 32728, 22701.1, 3224.14 ), ( 0, 0, 0 ), "HARVESTERORB_Q2_COLOSSEUM", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_sat_avalon_q2_ob_activity_harvester_orb_cs
// Params 3
// Checksum 0x2821161, Offset: 0x7e3
// Size: 0x9a
function function_19fc1c3b4228e35f( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_harvester_orb_cs";
    fe [[ f ]]( s, "HARVESTERORB_Q2_WINERY_SOUTH", cf, ( 20109.5, 34670.5, 2337.79 ), ( 0, 0, 0 ), "HARVESTERORB_Q2_WINERY_SOUTH", "PRECIOUS_CARGO_CLIFFTOWN", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_sat_avalon_q2_ob_activity_harvester_orb_cs
// Params 3
// Checksum 0xbb59eb81, Offset: 0x885
// Size: 0x96
function function_9e9704a3e0c94ae1( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_harvester_orb_cs";
    fe [[ f ]]( s, "HARVESTERORB_Q2_CLIFFTOWN", cf, ( 44731.8, 1521.1, 1476.4 ), ( 0, 0, 0 ), "HARVESTERORB_Q2_CLIFFTOWN", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_sat_avalon_q2_ob_activity_harvester_orb_cs
// Params 0
// Checksum 0xa397f43b, Offset: 0x923
// Size: 0x355
function function_d9dd7965c51c95d1()
{
    activityinstances = [];
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_activitydef_harvesterorb";
    var_881289d7987bc770.cf = "mp_sat_avalon_q2_ob_activity_harvester_orb_cs";
    var_881289d7987bc770.scriptstructorigin = ( 33709, 37946, 3321.79 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [ ( 33709, 37946, 3321.79 ) ];
    var_881289d7987bc770.var_31ce4477e3543d24 = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.locationradius = [ 1000 ];
    activityinstances[ "HARVESTERORB_Q2_WINERY" ] = var_881289d7987bc770;
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_activitydef_harvesterorb";
    var_881289d7987bc770.cf = "mp_sat_avalon_q2_ob_activity_harvester_orb_cs";
    var_881289d7987bc770.scriptstructorigin = ( 32632.8, 22789.4, 3236.11 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [ ( 32632.8, 22789.4, 3236.11 ) ];
    var_881289d7987bc770.var_31ce4477e3543d24 = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.locationradius = [ 1000 ];
    activityinstances[ "HARVESTERORB_Q2_COLOSSEUM" ] = var_881289d7987bc770;
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_activitydef_harvesterorb";
    var_881289d7987bc770.cf = "mp_sat_avalon_q2_ob_activity_harvester_orb_cs";
    var_881289d7987bc770.scriptstructorigin = ( 20109.5, 34770.5, 2337.79 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [ ( 20109.5, 34770.5, 2337.79 ) ];
    var_881289d7987bc770.var_31ce4477e3543d24 = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.locationradius = [ 1000 ];
    activityinstances[ "HARVESTERORB_Q2_WINERY_SOUTH" ] = var_881289d7987bc770;
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_activitydef_harvesterorb";
    var_881289d7987bc770.cf = "mp_sat_avalon_q2_ob_activity_harvester_orb_cs";
    var_881289d7987bc770.scriptstructorigin = ( 44636.6, 1609.4, 1488.37 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [ ( 44636.6, 1609.4, 1488.37 ) ];
    var_881289d7987bc770.var_31ce4477e3543d24 = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.locationradius = [ 1000 ];
    activityinstances[ "HARVESTERORB_Q2_CLIFFTOWN" ] = var_881289d7987bc770;
    return activityinstances;
}

