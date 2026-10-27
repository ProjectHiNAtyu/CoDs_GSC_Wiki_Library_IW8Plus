// script_2f8750a821ab59a  (hash_02f8750a821ab59a.gscc) (size: 4440 Bytes / 0x1158 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xf303b89a (4077107354)
// size ...... 4440 (0x1158)
// includes .. 4   (offset: 0x1000)
// strings ... 15  (offset: 0x1020)
// dev strs .. 0   (offset: 0x1158)
// exports ... 16  (offset: 0xa44)
// cseg ...... 0x1df + 0x865 (0xa44)
// imports ... 29  (offset: 0xcc4)
// animtree1 . 0   (offset: 0x1158)
// animtree2 . 0   (offset: 0x1158)
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace mp_sat_avalon_q2_ob_activity_hunt_squad_cs;

// Namespace mp_sat_avalon_q2_ob_activity_hunt_squad_cs
// Params 0, eflags: 0x5
// Checksum 0xbdb6b89e, Offset: 0x1fd
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"mp_sat_avalon_q2_ob_activity_hunt_squad_cs", #"activity_common", &function_b39ecd3d51489472, undefined );
}

// Namespace mp_sat_avalon_q2_ob_activity_hunt_squad_cs
// Params 0, eflags: 0x4
// Checksum 0xdf9dfd9c, Offset: 0x226
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace mp_sat_avalon_q2_ob_activity_hunt_squad_cs
// Params 0, eflags: 0x4
// Checksum 0x5aa62e70, Offset: 0x237
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace mp_sat_avalon_q2_ob_activity_hunt_squad_cs
// Params 2
// Checksum 0xd2fbaa53, Offset: 0x248
// Size: 0x8c
function main( unused, unused2 )
{
    if ( utility::flag_exist( "mp_sat_avalon_q2_ob_activity_hunt_squad_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "mp_sat_avalon_q2_ob_activity_hunt_squad_cs" ) )
    {
        return;
    }
    
    activity_common::function_e1df676808c1d1e3( &function_4cd78e661617f3 );
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "mp_sat_avalon_q2_ob_activity_hunt_squad_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "mp_sat_avalon_q2_ob_activity_hunt_squad_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace mp_sat_avalon_q2_ob_activity_hunt_squad_cs
// Params 3, eflags: 0x4
// Checksum 0xd9249abf, Offset: 0x2dc
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "mp_sat_avalon_q2_ob_activity_hunt_squad_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "mp_sat_avalon_q2_ob_activity_hunt_squad_cs" );
}

// Namespace mp_sat_avalon_q2_ob_activity_hunt_squad_cs
// Params 3, eflags: 0x4
// Checksum 0xc1022e5b, Offset: 0x356
// Size: 0x260
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_hunt_squad_cs";
    s.activity_bundle = "sat_activitydef_hunt_squad_medium";
    s.name = "HUNT_SQUAD_MEDIUM";
    fe [[ f ]]( s, "HUNT_SQUAD_MEDIUM", cf, ( 7408.22, 23931.3, 547.81 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 8, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_hunt_squad_cs";
    s.activity_bundle = "sat_activitydef_hunt_squad_hard";
    s.name = "HUNT_SQUAD_HARD";
    fe [[ f ]]( s, "HUNT_SQUAD_HARD", cf, ( 7408.22, 23931.3, 547.81 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 8, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_hunt_squad_cs";
    s.activity_bundle = "sat_activitydef_hunt_squad_elite";
    s.name = "HUNT_SQUAD_ELITE";
    fe [[ f ]]( s, "HUNT_SQUAD_ELITE", cf, ( 7408.22, 23931.3, 547.81 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 8, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_hunt_squad_cs";
    s.activity_bundle = "sat_activitydef_hunt_squad_easy";
    s.name = "HUNT_SQUAD_EASY";
    fe [[ f ]]( s, "HUNT_SQUAD_EASY", cf, ( 7408.22, 23931.3, 547.81 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 8, 0 ), ( 0, 0, 0 ) );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace mp_sat_avalon_q2_ob_activity_hunt_squad_cs
// Params 0, eflags: 0x4
// Checksum 0xc57f1e1e, Offset: 0x5be
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace mp_sat_avalon_q2_ob_activity_hunt_squad_cs
// Params 0
// Checksum 0x1b7747f2, Offset: 0x5c8
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "mp_sat_avalon_q2_ob_activity_hunt_squad_cs" );
}

// Namespace mp_sat_avalon_q2_ob_activity_hunt_squad_cs
// Params 0
// Checksum 0x7e1e94ef, Offset: 0x5de
// Size: 0x66
function function_4cd78e661617f3()
{
    activityinfostruct = {};
    activityinfostruct.name = "REV_OB_HUNT_SQUAD";
    activityinfostruct.scriptbundle = "sat_activitydef_hunt_squad";
    activityinfostruct.mainfunction = &main;
    activityinfostruct.var_934f068483ae4ddb = &function_d4323822d7042e5a;
    activityinfostruct.metadatafunction = &function_d9dd7965c51c95d1;
    return activityinfostruct;
}

// Namespace mp_sat_avalon_q2_ob_activity_hunt_squad_cs
// Params 4
// Checksum 0xa6093c1e, Offset: 0x64d
// Size: 0xa5
function function_d4323822d7042e5a( var_4312b79c960726b6, fe, us, cf = "mp_sat_avalon_q2_ob_activity_hunt_squad_cs" )
{
    switch ( var_4312b79c960726b6 )
    {
        case #"hash_c1bdd93a79fa145":
            function_752c3880b1a5663d( fe, us, cf );
            break;
        case #"hash_e4fb02047562e71f":
            function_3a3fb0cf87d8f737( fe, us, cf );
            break;
        case #"hash_390d25a0d9742d4d":
            function_1d23e7e8aaac8285( fe, us, cf );
            break;
        case #"hash_dd4f312323622680":
            function_b9f8eed0c9e40b98( fe, us, cf );
            break;
    }
}

// Namespace mp_sat_avalon_q2_ob_activity_hunt_squad_cs
// Params 3
// Checksum 0x4103deed, Offset: 0x6fa
// Size: 0x2f
function function_752c3880b1a5663d( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
}

// Namespace mp_sat_avalon_q2_ob_activity_hunt_squad_cs
// Params 3
// Checksum 0x3e33c8be, Offset: 0x731
// Size: 0x2f
function function_3a3fb0cf87d8f737( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
}

// Namespace mp_sat_avalon_q2_ob_activity_hunt_squad_cs
// Params 3
// Checksum 0xa1a0ecac, Offset: 0x768
// Size: 0x2f
function function_1d23e7e8aaac8285( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
}

// Namespace mp_sat_avalon_q2_ob_activity_hunt_squad_cs
// Params 3
// Checksum 0xb6444dfb, Offset: 0x79f
// Size: 0x2f
function function_b9f8eed0c9e40b98( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
}

// Namespace mp_sat_avalon_q2_ob_activity_hunt_squad_cs
// Params 0
// Checksum 0x106270a5, Offset: 0x7d6
// Size: 0x26d
function function_d9dd7965c51c95d1()
{
    activityinstances = [];
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_activitydef_hunt_squad_medium";
    var_881289d7987bc770.cf = "mp_sat_avalon_q2_ob_activity_hunt_squad_cs";
    var_881289d7987bc770.scriptstructorigin = ( 7408.22, 23931.3, 547.81 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 8, 0 );
    var_881289d7987bc770.locationorigin = [];
    var_881289d7987bc770.var_31ce4477e3543d24 = [];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [];
    var_881289d7987bc770.locationradius = [];
    activityinstances[ "HUNT_SQUAD_MEDIUM" ] = var_881289d7987bc770;
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_activitydef_hunt_squad_hard";
    var_881289d7987bc770.cf = "mp_sat_avalon_q2_ob_activity_hunt_squad_cs";
    var_881289d7987bc770.scriptstructorigin = ( 7408.22, 23931.3, 547.81 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 8, 0 );
    var_881289d7987bc770.locationorigin = [];
    var_881289d7987bc770.var_31ce4477e3543d24 = [];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [];
    var_881289d7987bc770.locationradius = [];
    activityinstances[ "HUNT_SQUAD_HARD" ] = var_881289d7987bc770;
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_activitydef_hunt_squad_elite";
    var_881289d7987bc770.cf = "mp_sat_avalon_q2_ob_activity_hunt_squad_cs";
    var_881289d7987bc770.scriptstructorigin = ( 7408.22, 23931.3, 547.81 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 8, 0 );
    var_881289d7987bc770.locationorigin = [];
    var_881289d7987bc770.var_31ce4477e3543d24 = [];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [];
    var_881289d7987bc770.locationradius = [];
    activityinstances[ "HUNT_SQUAD_ELITE" ] = var_881289d7987bc770;
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_activitydef_hunt_squad_easy";
    var_881289d7987bc770.cf = "mp_sat_avalon_q2_ob_activity_hunt_squad_cs";
    var_881289d7987bc770.scriptstructorigin = ( 7408.22, 23931.3, 547.81 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 8, 0 );
    var_881289d7987bc770.locationorigin = [];
    var_881289d7987bc770.var_31ce4477e3543d24 = [];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [];
    var_881289d7987bc770.locationradius = [];
    activityinstances[ "HUNT_SQUAD_EASY" ] = var_881289d7987bc770;
    return activityinstances;
}

