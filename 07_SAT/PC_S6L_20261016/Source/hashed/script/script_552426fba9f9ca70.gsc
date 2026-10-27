// script_552426fba9f9ca70  (hash_552426fba9f9ca70.gscc) (size: 7873 Bytes / 0x1ec1 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x45177a65 (1159166565)
// size ...... 7873 (0x1ec1)
// includes .. 4   (offset: 0x1b21)
// strings ... 20  (offset: 0x1b41)
// dev strs .. 0   (offset: 0x1ec1)
// exports ... 14  (offset: 0x15f5)
// cseg ...... 0x236 + 0x13bf (0x15f5)
// imports ... 27  (offset: 0x1825)
// animtree1 . 0   (offset: 0x1ec1)
// animtree2 . 0   (offset: 0x1ec1)
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace mp_sat_avalon_city_ob_activity_cradle_convergence_cs;

// Namespace mp_sat_avalon_city_ob_activity_cradle_convergence_cs
// Params 0, eflags: 0x5
// Checksum 0x703db84c, Offset: 0x254
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"mp_sat_avalon_city_ob_activity_cradle_convergence_cs", #"activity_common", &function_b39ecd3d51489472, undefined );
}

// Namespace mp_sat_avalon_city_ob_activity_cradle_convergence_cs
// Params 0, eflags: 0x4
// Checksum 0xe8959bb9, Offset: 0x27d
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace mp_sat_avalon_city_ob_activity_cradle_convergence_cs
// Params 0, eflags: 0x4
// Checksum 0x6dae4855, Offset: 0x28e
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace mp_sat_avalon_city_ob_activity_cradle_convergence_cs
// Params 2
// Checksum 0xedb69020, Offset: 0x29f
// Size: 0x8c
function main( unused, unused2 )
{
    if ( utility::flag_exist( "mp_sat_avalon_city_ob_activity_cradle_convergence_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "mp_sat_avalon_city_ob_activity_cradle_convergence_cs" ) )
    {
        return;
    }
    
    activity_common::function_e1df676808c1d1e3( &function_4cd78e661617f3 );
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "mp_sat_avalon_city_ob_activity_cradle_convergence_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "mp_sat_avalon_city_ob_activity_cradle_convergence_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace mp_sat_avalon_city_ob_activity_cradle_convergence_cs
// Params 3, eflags: 0x4
// Checksum 0xee2cfc9a, Offset: 0x333
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "mp_sat_avalon_city_ob_activity_cradle_convergence_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "mp_sat_avalon_city_ob_activity_cradle_convergence_cs" );
}

// Namespace mp_sat_avalon_city_ob_activity_cradle_convergence_cs
// Params 3, eflags: 0x4
// Checksum 0x4d641bfc, Offset: 0x3ad
// Size: 0x232
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_cradle_convergence_cs";
    s.activity_bundle = "sat_activitydef_global_activity_poi_boss";
    s.name = "POI_BOSS_HIGH_TOWN";
    fe [[ f ]]( s, "POI_BOSS_HIGH_TOWN", cf, ( -15928.4, 7290.48, 1041.43 ), ( 0, 323.6, 0 ), "activity_nexus_variant", "activity_nexus_variant", undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_cradle_convergence_cs";
    fe [[ f ]]( s, "POI_BOSS_HIGH_TOWN", cf, ( -16653.2, 6895.57, 1092.5 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Awareness_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 4500 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_cradle_convergence_cs";
    s.activity_bundle = "sat_activitydef_global_activity_poi_boss";
    s.name = "POI_BOSS_MARINA";
    fe [[ f ]]( s, "POI_BOSS_MARINA", cf, ( -2629.5, 5232.15, 63.52 ), ( 0, 116.6, 0 ), "activity_nexus_variant", "activity_nexus_variant", undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_cradle_convergence_cs";
    fe [[ f ]]( s, "POI_BOSS_MARINA", cf, ( -2972.84, 8237.1, 78 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Awareness_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 7000 );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace mp_sat_avalon_city_ob_activity_cradle_convergence_cs
// Params 0, eflags: 0x4
// Checksum 0xfa32246d, Offset: 0x5e7
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace mp_sat_avalon_city_ob_activity_cradle_convergence_cs
// Params 0
// Checksum 0x2c7f21d7, Offset: 0x5f1
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "mp_sat_avalon_city_ob_activity_cradle_convergence_cs" );
}

// Namespace mp_sat_avalon_city_ob_activity_cradle_convergence_cs
// Params 0
// Checksum 0xa6dbc63b, Offset: 0x607
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

// Namespace mp_sat_avalon_city_ob_activity_cradle_convergence_cs
// Params 4
// Checksum 0xfbd844f, Offset: 0x676
// Size: 0x71
function function_d4323822d7042e5a( var_4312b79c960726b6, fe, us, cf = "mp_sat_avalon_city_ob_activity_cradle_convergence_cs" )
{
    switch ( var_4312b79c960726b6 )
    {
        case #"hash_f1edeea660a50e0f":
            function_5f115b3cef7442d7( fe, us, cf );
            break;
        case #"hash_7a41db49fa70e290":
            function_e5abf72c39891f98( fe, us, cf );
            break;
    }
}

// Namespace mp_sat_avalon_city_ob_activity_cradle_convergence_cs
// Params 3
// Checksum 0x114a3ec6, Offset: 0x6ef
// Size: 0x69f
function function_5f115b3cef7442d7( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_cradle_convergence_cs";
    s.name = "s_deposit_portal";
    fe [[ f ]]( s, "POI_BOSS_HIGH_TOWN", cf, ( -16751.1, 6483.1, 1230.98 ), ( 0, 320, 0 ), "cspf_3_auto8791823884026273525", undefined, "s_deposit_portal", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_cradle_convergence_cs";
    s.name = "s_deposit_portal";
    fe [[ f ]]( s, "POI_BOSS_HIGH_TOWN", cf, ( -17511.5, 10210.5, 1219 ), ( 0, 302, 0 ), "cspf_3_auto8791823884026273525", undefined, "s_deposit_portal", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_cradle_convergence_cs";
    s.name = "s_center";
    fe [[ f ]]( s, "POI_BOSS_HIGH_TOWN", cf, ( -15928.4, 7290.48, 1041.43 ), ( 0, 324.1, 0 ), "activity_nexus_variant", "cspf_3_auto8791823884026273525", "POI_BOSS_HIGH_TOWN", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 500 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_cradle_convergence_cs";
    s.name = "s_deposit_portal";
    fe [[ f ]]( s, "POI_BOSS_HIGH_TOWN", cf, ( -18941, 5977.7, 1095.51 ), ( 0, 0, 0 ), "cspf_3_auto8791823884026273525", undefined, "s_deposit_portal", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_cradle_convergence_cs";
    s.name = "s_deposit_portal";
    fe [[ f ]]( s, "POI_BOSS_HIGH_TOWN", cf, ( -19327.3, 8949.8, 1253.18 ), ( 0, 90, 0 ), "cspf_3_auto8791823884026273525", undefined, "s_deposit_portal", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_cradle_convergence_cs";
    s.name = "s_deposit_portal";
    fe [[ f ]]( s, "POI_BOSS_HIGH_TOWN", cf, ( -16847.5, 4337.6, 1092.19 ), ( 0, 18.5, 0 ), "cspf_3_auto8791823884026273525", undefined, "s_deposit_portal", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_cradle_convergence_cs";
    s.name = "s_deposit_portal";
    fe [[ f ]]( s, "POI_BOSS_HIGH_TOWN", cf, ( -14508.1, 7840.3, 979.44 ), ( 0, 52.1, 0 ), "cspf_3_auto8791823884026273525", undefined, "s_deposit_portal", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_cradle_convergence_cs";
    s.name = "s_deposit_portal";
    fe [[ f ]]( s, "POI_BOSS_HIGH_TOWN", cf, ( -13989, 5920.6, 1086.76 ), ( 0, 322.4, 0 ), "cspf_3_auto8791823884026273525", undefined, "s_deposit_portal", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_cradle_convergence_cs";
    s.name = "s_deposit_portal";
    fe [[ f ]]( s, "POI_BOSS_HIGH_TOWN", cf, ( -16502.8, 6534, 1102.5 ), ( 0, 52.4, 0 ), "cspf_3_auto8791823884026273525", undefined, "s_deposit_portal", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_cradle_convergence_cs";
    s.name = "s_deposit_portal";
    fe [[ f ]]( s, "POI_BOSS_HIGH_TOWN", cf, ( -17304.2, 8642.7, 1086.08 ), ( 0, 106, 0 ), "cspf_3_auto8791823884026273525", undefined, "s_deposit_portal", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_cradle_convergence_cs";
    s.name = "s_deposit_portal";
    fe [[ f ]]( s, "POI_BOSS_HIGH_TOWN", cf, ( -15412.9, 4275.4, 1092 ), ( 0, 231.1, 0 ), "cspf_3_auto8791823884026273525", undefined, "s_deposit_portal", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_cradle_convergence_cs";
    s.boss_leash = "3500";
    fe [[ f ]]( s, "POI_BOSS_HIGH_TOWN", cf, ( -15928.4, 7290.48, 1041.43 ), ( 0, 324.1, 0 ), "cspf_3_auto8791823884026273525", undefined, "s_boss_spawn_pos_alt", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 3500 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_cradle_convergence_cs";
    s.boss_leash = "3500";
    fe [[ f ]]( s, "POI_BOSS_HIGH_TOWN", cf, ( -15928.4, 7290.48, 1041.43 ), ( 0, 324.1, 0 ), "cspf_3_auto8791823884026273525", undefined, "s_boss_spawn_pos", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 3500 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_cradle_convergence_cs";
    s.name = "script_struct_leash";
    fe [[ f ]]( s, "POI_BOSS_HIGH_TOWN", cf, ( -15898.4, 7278.54, 1041.4 ), ( 0, 190, 0 ), "cspf_3_auto8791823884026273525", undefined, "s_boss_tether_data", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 6000 );
}

// Namespace mp_sat_avalon_city_ob_activity_cradle_convergence_cs
// Params 3
// Checksum 0x6d294070, Offset: 0xd96
// Size: 0x69f
function function_e5abf72c39891f98( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_cradle_convergence_cs";
    s.name = "script_struct_leash";
    fe [[ f ]]( s, "POI_BOSS_MARINA", cf, ( 638.91, 3147.04, 533.69 ), ( 0, 190, 0 ), "cspf_4_auto5868028640655835144", undefined, "s_boss_tether_data", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 6000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_cradle_convergence_cs";
    s.name = "s_deposit_portal";
    fe [[ f ]]( s, "POI_BOSS_MARINA", cf, ( -2727.4, 10415, 66 ), ( 0, 255, 0 ), "cspf_4_auto5868028640655835144", undefined, "s_deposit_portal", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_cradle_convergence_cs";
    s.name = "s_deposit_portal";
    fe [[ f ]]( s, "POI_BOSS_MARINA", cf, ( -3641.05, 9470.52, 186 ), ( 0, 255.3, 0 ), "cspf_4_auto5868028640655835144", undefined, "s_deposit_portal", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_cradle_convergence_cs";
    s.name = "s_center";
    fe [[ f ]]( s, "POI_BOSS_MARINA", cf, ( -2637.62, 5230.77, 62 ), ( 0, 117.1, 0 ), "activity_nexus_variant", "cspf_4_auto5868028640655835144", "POI_BOSS_MARINA", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 500 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_cradle_convergence_cs";
    s.name = "s_deposit_portal";
    fe [[ f ]]( s, "POI_BOSS_MARINA", cf, ( -4218.57, 10555.5, 66 ), ( 0, 270, 0 ), "cspf_4_auto5868028640655835144", undefined, "s_deposit_portal", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_cradle_convergence_cs";
    s.name = "s_deposit_portal";
    fe [[ f ]]( s, "POI_BOSS_MARINA", cf, ( -6206, 7977.62, 66 ), ( 0, 345, 0 ), "cspf_4_auto5868028640655835144", undefined, "s_deposit_portal", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_cradle_convergence_cs";
    s.name = "s_deposit_portal";
    fe [[ f ]]( s, "POI_BOSS_MARINA", cf, ( -4849.33, 6784.63, 66 ), ( 0, 55, 0 ), "cspf_4_auto5868028640655835144", undefined, "s_deposit_portal", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_cradle_convergence_cs";
    s.name = "s_deposit_portal";
    fe [[ f ]]( s, "POI_BOSS_MARINA", cf, ( -3246.45, 6289.16, 66 ), ( 0, 125, 0 ), "cspf_4_auto5868028640655835144", undefined, "s_deposit_portal", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_cradle_convergence_cs";
    s.name = "s_deposit_portal";
    fe [[ f ]]( s, "POI_BOSS_MARINA", cf, ( -6056.88, 9938.27, 258 ), ( 0, 300, 0 ), "cspf_4_auto5868028640655835144", undefined, "s_deposit_portal", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_cradle_convergence_cs";
    s.name = "s_deposit_portal";
    fe [[ f ]]( s, "POI_BOSS_MARINA", cf, ( -2310.93, 8375.1, 130 ), ( 0, 255, 0 ), "cspf_4_auto5868028640655835144", undefined, "s_deposit_portal", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_cradle_convergence_cs";
    s.name = "s_deposit_portal";
    fe [[ f ]]( s, "POI_BOSS_MARINA", cf, ( 64.09, 7267.79, 162 ), ( 0, 165, 0 ), "cspf_4_auto5868028640655835144", undefined, "s_deposit_portal", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_cradle_convergence_cs";
    s.name = "s_deposit_portal";
    fe [[ f ]]( s, "POI_BOSS_MARINA", cf, ( -4249.5, 8407.31, 130 ), ( 0, 165, 0 ), "cspf_4_auto5868028640655835144", undefined, "s_deposit_portal", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_cradle_convergence_cs";
    s.boss_leash = "3500";
    fe [[ f ]]( s, "POI_BOSS_MARINA", cf, ( 611.4, 3119.85, 533.65 ), ( 0, 117.1, 0 ), "cspf_4_auto5868028640655835144", undefined, "s_boss_spawn_pos_alt", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 3500 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_cradle_convergence_cs";
    s.boss_leash = "3500";
    fe [[ f ]]( s, "POI_BOSS_MARINA", cf, ( 611.4, 3119.85, 533.65 ), ( 0, 117.1, 0 ), "cspf_4_auto5868028640655835144", undefined, "s_boss_spawn_pos", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 3500 );
}

// Namespace mp_sat_avalon_city_ob_activity_cradle_convergence_cs
// Params 0
// Checksum 0xb1395694, Offset: 0x143d
// Size: 0x1b7
function function_d9dd7965c51c95d1()
{
    activityinstances = [];
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_activitydef_global_activity_poi_boss";
    var_881289d7987bc770.cf = "mp_sat_avalon_city_ob_activity_cradle_convergence_cs";
    var_881289d7987bc770.scriptstructorigin = ( -15928.4, 7290.48, 1041.43 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [ ( -16653.2, 6895.57, 1092.5 ) ];
    var_881289d7987bc770.var_31ce4477e3543d24 = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.locationradius = [ 4000 ];
    activityinstances[ "POI_BOSS_HIGH_TOWN" ] = var_881289d7987bc770;
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_activitydef_global_activity_poi_boss";
    var_881289d7987bc770.cf = "mp_sat_avalon_city_ob_activity_cradle_convergence_cs";
    var_881289d7987bc770.scriptstructorigin = ( -2629.5, 5232.15, 63.52 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [ ( -2972.84, 8237.1, 78 ) ];
    var_881289d7987bc770.var_31ce4477e3543d24 = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.locationradius = [ 4000 ];
    activityinstances[ "POI_BOSS_MARINA" ] = var_881289d7987bc770;
    return activityinstances;
}

