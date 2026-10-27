// script_381a00ee74d94dde  (hash_381a00ee74d94dde.gscc) (size: 2962 Bytes / 0xb92 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xe24fb7d5 (3796875221)
// size ...... 2962 (0xb92)
// includes .. 4   (offset: 0xac2)
// strings ... 10  (offset: 0xae2)
// dev strs .. 0   (offset: 0xb92)
// exports ... 13  (offset: 0x5de)
// cseg ...... 0x173 + 0x46b (0x5de)
// imports ... 26  (offset: 0x7e6)
// animtree1 . 0   (offset: 0xb92)
// animtree2 . 0   (offset: 0xb92)
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace mp_sat_avalon_q1_ob_activity_possessed_convoy_cs;

// Namespace mp_sat_avalon_q1_ob_activity_possessed_convoy_cs
// Params 0, eflags: 0x5
// Checksum 0x8792bc8, Offset: 0x191
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"mp_sat_avalon_q1_ob_activity_possessed_convoy_cs", #"activity_common", &function_b39ecd3d51489472, undefined );
}

// Namespace mp_sat_avalon_q1_ob_activity_possessed_convoy_cs
// Params 0, eflags: 0x4
// Checksum 0x184e9097, Offset: 0x1ba
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace mp_sat_avalon_q1_ob_activity_possessed_convoy_cs
// Params 0, eflags: 0x4
// Checksum 0x9d75437b, Offset: 0x1cb
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace mp_sat_avalon_q1_ob_activity_possessed_convoy_cs
// Params 2
// Checksum 0xa60d8876, Offset: 0x1dc
// Size: 0x8c
function main( unused, unused2 )
{
    if ( utility::flag_exist( "mp_sat_avalon_q1_ob_activity_possessed_convoy_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "mp_sat_avalon_q1_ob_activity_possessed_convoy_cs" ) )
    {
        return;
    }
    
    activity_common::function_e1df676808c1d1e3( &function_4cd78e661617f3 );
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "mp_sat_avalon_q1_ob_activity_possessed_convoy_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "mp_sat_avalon_q1_ob_activity_possessed_convoy_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace mp_sat_avalon_q1_ob_activity_possessed_convoy_cs
// Params 3, eflags: 0x4
// Checksum 0x1ef7f7b4, Offset: 0x270
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "mp_sat_avalon_q1_ob_activity_possessed_convoy_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "mp_sat_avalon_q1_ob_activity_possessed_convoy_cs" );
}

// Namespace mp_sat_avalon_q1_ob_activity_possessed_convoy_cs
// Params 3, eflags: 0x4
// Checksum 0x3334db58, Offset: 0x2ea
// Size: 0x129
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_possessed_convoy_cs";
    s.name = "POSSESSED_CONVOY_Q1_GOLFCLUB";
    fe [[ f ]]( s, "POSSESSED_CONVOY_Q1_GOLFCLUB", cf, ( -12986.1, 37032.5, 893.33 ), ( 0, 15.53, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_possessed_convoy_cs";
    fe [[ f ]]( s, "POSSESSED_CONVOY_Q1_GOLFCLUB", cf, ( -36991.2, 25023.7, 1799.85 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "OB_Spacer_Spatial_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 50 );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace mp_sat_avalon_q1_ob_activity_possessed_convoy_cs
// Params 0, eflags: 0x4
// Checksum 0xb1893c3b, Offset: 0x41b
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace mp_sat_avalon_q1_ob_activity_possessed_convoy_cs
// Params 0
// Checksum 0xdca42af9, Offset: 0x425
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "mp_sat_avalon_q1_ob_activity_possessed_convoy_cs" );
}

// Namespace mp_sat_avalon_q1_ob_activity_possessed_convoy_cs
// Params 0
// Checksum 0x20510b5, Offset: 0x43b
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

// Namespace mp_sat_avalon_q1_ob_activity_possessed_convoy_cs
// Params 4
// Checksum 0x162ad6ef, Offset: 0x4aa
// Size: 0x57
function function_d4323822d7042e5a( var_4312b79c960726b6, fe, us, cf = "mp_sat_avalon_q1_ob_activity_possessed_convoy_cs" )
{
    switch ( var_4312b79c960726b6 )
    {
        case #"hash_37d1bb001e702fc5":
            function_f3e762dbb75016cd( fe, us, cf );
            break;
    }
}

// Namespace mp_sat_avalon_q1_ob_activity_possessed_convoy_cs
// Params 3
// Checksum 0x6231b005, Offset: 0x509
// Size: 0x2f
function function_f3e762dbb75016cd( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
}

// Namespace mp_sat_avalon_q1_ob_activity_possessed_convoy_cs
// Params 0
// Checksum 0x3a406755, Offset: 0x540
// Size: 0x9d
function function_d9dd7965c51c95d1()
{
    activityinstances = [];
    var_881289d7987bc770 = {};
    var_881289d7987bc770.cf = "mp_sat_avalon_q1_ob_activity_possessed_convoy_cs";
    var_881289d7987bc770.scriptstructorigin = ( -12986.1, 37032.5, 893.33 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [];
    var_881289d7987bc770.var_31ce4477e3543d24 = [];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [];
    var_881289d7987bc770.locationradius = [];
    activityinstances[ "POSSESSED_CONVOY_Q1_GOLFCLUB" ] = var_881289d7987bc770;
    return activityinstances;
}

