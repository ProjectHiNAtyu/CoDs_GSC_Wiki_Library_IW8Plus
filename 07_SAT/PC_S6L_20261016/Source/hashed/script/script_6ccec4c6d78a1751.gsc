// script_6ccec4c6d78a1751  (hash_6ccec4c6d78a1751.gscc) (size: 5196 Bytes / 0x144c / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xb5f50559 (3052733785)
// size ...... 5196 (0x144c)
// includes .. 4   (offset: 0x1218)
// strings ... 18  (offset: 0x1238)
// dev strs .. 0   (offset: 0x144c)
// exports ... 13  (offset: 0xd34)
// cseg ...... 0x1fc + 0xb38 (0xd34)
// imports ... 26  (offset: 0xf3c)
// animtree1 . 0   (offset: 0x144c)
// animtree2 . 0   (offset: 0x144c)
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace mp_sat_avalon_q2_ob_activity_cradle_convergence_cs;

// Namespace mp_sat_avalon_q2_ob_activity_cradle_convergence_cs
// Params 0, eflags: 0x5
// Checksum 0x8a1b6b84, Offset: 0x21a
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"mp_sat_avalon_q2_ob_activity_cradle_convergence_cs", #"activity_common", &function_b39ecd3d51489472, undefined );
}

// Namespace mp_sat_avalon_q2_ob_activity_cradle_convergence_cs
// Params 0, eflags: 0x4
// Checksum 0x7fc72d5d, Offset: 0x243
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace mp_sat_avalon_q2_ob_activity_cradle_convergence_cs
// Params 0, eflags: 0x4
// Checksum 0xfafcfeb1, Offset: 0x254
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace mp_sat_avalon_q2_ob_activity_cradle_convergence_cs
// Params 2
// Checksum 0x8dec2618, Offset: 0x265
// Size: 0x8c
function main( unused, unused2 )
{
    if ( utility::flag_exist( "mp_sat_avalon_q2_ob_activity_cradle_convergence_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "mp_sat_avalon_q2_ob_activity_cradle_convergence_cs" ) )
    {
        return;
    }
    
    activity_common::function_e1df676808c1d1e3( &function_4cd78e661617f3 );
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "mp_sat_avalon_q2_ob_activity_cradle_convergence_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "mp_sat_avalon_q2_ob_activity_cradle_convergence_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace mp_sat_avalon_q2_ob_activity_cradle_convergence_cs
// Params 3, eflags: 0x4
// Checksum 0x797e4a7e, Offset: 0x2f9
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "mp_sat_avalon_q2_ob_activity_cradle_convergence_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "mp_sat_avalon_q2_ob_activity_cradle_convergence_cs" );
}

// Namespace mp_sat_avalon_q2_ob_activity_cradle_convergence_cs
// Params 3, eflags: 0x4
// Checksum 0x892dff1f, Offset: 0x373
// Size: 0x13b
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_cradle_convergence_cs";
    s.activity_bundle = "sat_activitydef_global_activity_poi_boss";
    s.name = "POI_BOSS_WINERY";
    fe [[ f ]]( s, "POI_BOSS_WINERY", cf, ( 9384.37, 50650.7, 479.72 ), ( 0, 290.1, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_cradle_convergence_cs";
    fe [[ f ]]( s, "POI_BOSS_WINERY", cf, ( 9402.27, 50907.4, 513.16 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Awareness_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 6000 );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace mp_sat_avalon_q2_ob_activity_cradle_convergence_cs
// Params 0, eflags: 0x4
// Checksum 0x9a689255, Offset: 0x4b6
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace mp_sat_avalon_q2_ob_activity_cradle_convergence_cs
// Params 0
// Checksum 0xbb2d9733, Offset: 0x4c0
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "mp_sat_avalon_q2_ob_activity_cradle_convergence_cs" );
}

// Namespace mp_sat_avalon_q2_ob_activity_cradle_convergence_cs
// Params 0
// Checksum 0x318970df, Offset: 0x4d6
// Size: 0x66
function function_4cd78e661617f3()
{
    activityinfostruct = {};
    activityinfostruct.name = "REV_OB_POI_BOSS";
    activityinfostruct.scriptbundle = "sat_activitydef_global_activity_poi_boss";
    activityinfostruct.mainfunction = &main;
    activityinfostruct.var_934f068483ae4ddb = &function_d4323822d7042e5a;
    activityinfostruct.metadatafunction = &function_d9dd7965c51c95d1;
    return activityinfostruct;
}

// Namespace mp_sat_avalon_q2_ob_activity_cradle_convergence_cs
// Params 4
// Checksum 0xa294fb94, Offset: 0x545
// Size: 0x57
function function_d4323822d7042e5a( var_4312b79c960726b6, fe, us, cf = "mp_sat_avalon_q2_ob_activity_cradle_convergence_cs" )
{
    switch ( var_4312b79c960726b6 )
    {
        case #"hash_18391cc3664c0bb2":
            function_6d17074849495fa( fe, us, cf );
            break;
    }
}

// Namespace mp_sat_avalon_q2_ob_activity_cradle_convergence_cs
// Params 3
// Checksum 0xa24bc64, Offset: 0x5a4
// Size: 0x69f
function function_6d17074849495fa( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_cradle_convergence_cs";
    s.name = "script_struct_leash";
    fe [[ f ]]( s, "POI_BOSS_WINERY", cf, ( 9369.06, 50673.2, 484.53 ), ( 0, 290.6, 0 ), "cspf_2_auto8555039067624045478", undefined, "s_boss_tether_data", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 5000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_cradle_convergence_cs";
    s.name = "s_deposit_portal";
    fe [[ f ]]( s, "POI_BOSS_WINERY", cf, ( 12106, 51350.9, 682.81 ), ( 0, 200, 0 ), "cspf_2_auto8555039067624045478", undefined, "s_deposit_portal", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_cradle_convergence_cs";
    s.name = "s_deposit_portal";
    fe [[ f ]]( s, "POI_BOSS_WINERY", cf, ( 10900.8, 47166.1, 649.99 ), ( 0, 165, 0 ), "cspf_2_auto8555039067624045478", undefined, "s_deposit_portal", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_cradle_convergence_cs";
    s.name = "s_center";
    fe [[ f ]]( s, "POI_BOSS_WINERY", cf, ( 9384.37, 50650.7, 479.72 ), ( 0, 290.6, 0 ), "activity_nexus_variant", "cspf_2_auto8555039067624045478", "POI_BOSS_WINERY", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 500 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_cradle_convergence_cs";
    s.name = "s_deposit_portal";
    fe [[ f ]]( s, "POI_BOSS_WINERY", cf, ( 8344.1, 48249.5, 471.01 ), ( 0, 64.7, 0 ), "cspf_2_auto8555039067624045478", undefined, "s_deposit_portal", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_cradle_convergence_cs";
    s.name = "s_deposit_portal";
    fe [[ f ]]( s, "POI_BOSS_WINERY", cf, ( 10350.2, 54307.5, 851.1 ), ( 0, 90, 0 ), "cspf_2_auto8555039067624045478", undefined, "s_deposit_portal", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_cradle_convergence_cs";
    s.name = "s_deposit_portal";
    fe [[ f ]]( s, "POI_BOSS_WINERY", cf, ( 6600.2, 49175.5, 354.81 ), ( 0, 38.8, 0 ), "cspf_2_auto8555039067624045478", undefined, "s_deposit_portal", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_cradle_convergence_cs";
    s.name = "s_deposit_portal";
    fe [[ f ]]( s, "POI_BOSS_WINERY", cf, ( 6861.2, 50714.5, 494.53 ), ( 0, 152, 0 ), "cspf_2_auto8555039067624045478", undefined, "s_deposit_portal", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_cradle_convergence_cs";
    s.name = "s_deposit_portal";
    fe [[ f ]]( s, "POI_BOSS_WINERY", cf, ( 8225.1, 53912.3, 788.72 ), ( 0, 309.6, 0 ), "cspf_2_auto8555039067624045478", undefined, "s_deposit_portal", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_cradle_convergence_cs";
    s.name = "s_deposit_portal";
    fe [[ f ]]( s, "POI_BOSS_WINERY", cf, ( 8549.5, 51986.6, 732.22 ), ( 0, 14.1, 0 ), "cspf_2_auto8555039067624045478", undefined, "s_deposit_portal", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_cradle_convergence_cs";
    s.name = "s_deposit_portal";
    fe [[ f ]]( s, "POI_BOSS_WINERY", cf, ( 11362.1, 49998.1, 684.42 ), ( 0, 290, 0 ), "cspf_2_auto8555039067624045478", undefined, "s_deposit_portal", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_cradle_convergence_cs";
    s.name = "s_deposit_portal";
    fe [[ f ]]( s, "POI_BOSS_WINERY", cf, ( 6598.2, 53469.6, 846 ), ( 0, 180, 0 ), "cspf_2_auto8555039067624045478", undefined, "s_deposit_portal", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_cradle_convergence_cs";
    s.boss_leash = "3500";
    fe [[ f ]]( s, "POI_BOSS_WINERY", cf, ( 9384.37, 50650.7, 479.72 ), ( 0, 290.6, 0 ), "cspf_2_auto8555039067624045478", undefined, "s_boss_spawn_pos_alt", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 3500 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_cradle_convergence_cs";
    s.boss_leash = "3500";
    fe [[ f ]]( s, "POI_BOSS_WINERY", cf, ( 9384.37, 50650.7, 479.72 ), ( 0, 290.6, 0 ), "cspf_2_auto8555039067624045478", undefined, "s_boss_spawn_pos", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 3500 );
}

// Namespace mp_sat_avalon_q2_ob_activity_cradle_convergence_cs
// Params 0
// Checksum 0x5f87fc40, Offset: 0xc4b
// Size: 0xe8
function function_d9dd7965c51c95d1()
{
    activityinstances = [];
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_activitydef_global_activity_poi_boss";
    var_881289d7987bc770.cf = "mp_sat_avalon_q2_ob_activity_cradle_convergence_cs";
    var_881289d7987bc770.scriptstructorigin = ( 9384.37, 50650.7, 479.72 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [ ( 9402.27, 50907.4, 513.16 ) ];
    var_881289d7987bc770.var_31ce4477e3543d24 = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.locationradius = [ 4500 ];
    activityinstances[ "POI_BOSS_WINERY" ] = var_881289d7987bc770;
    return activityinstances;
}

