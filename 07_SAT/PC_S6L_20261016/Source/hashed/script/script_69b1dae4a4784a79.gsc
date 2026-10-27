// script_69b1dae4a4784a79  (hash_69b1dae4a4784a79.gscc) (size: 7870 Bytes / 0x1ebe / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xecd8a44f (3973620815)
// size ...... 7870 (0x1ebe)
// includes .. 4   (offset: 0x1b1e)
// strings ... 20  (offset: 0x1b3e)
// dev strs .. 0   (offset: 0x1ebe)
// exports ... 14  (offset: 0x15f2)
// cseg ...... 0x233 + 0x13bf (0x15f2)
// imports ... 27  (offset: 0x1822)
// animtree1 . 0   (offset: 0x1ebe)
// animtree2 . 0   (offset: 0x1ebe)
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace mp_sat_avalon_q1_ob_activity_cradle_convergence_cs;

// Namespace mp_sat_avalon_q1_ob_activity_cradle_convergence_cs
// Params 0, eflags: 0x5
// Checksum 0x2b046c21, Offset: 0x251
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"mp_sat_avalon_q1_ob_activity_cradle_convergence_cs", #"activity_common", &function_b39ecd3d51489472, undefined );
}

// Namespace mp_sat_avalon_q1_ob_activity_cradle_convergence_cs
// Params 0, eflags: 0x4
// Checksum 0x2ae568b1, Offset: 0x27a
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace mp_sat_avalon_q1_ob_activity_cradle_convergence_cs
// Params 0, eflags: 0x4
// Checksum 0xafdebb5d, Offset: 0x28b
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace mp_sat_avalon_q1_ob_activity_cradle_convergence_cs
// Params 2
// Checksum 0x531d5ded, Offset: 0x29c
// Size: 0x8c
function main( unused, unused2 )
{
    if ( utility::flag_exist( "mp_sat_avalon_q1_ob_activity_cradle_convergence_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "mp_sat_avalon_q1_ob_activity_cradle_convergence_cs" ) )
    {
        return;
    }
    
    activity_common::function_e1df676808c1d1e3( &function_4cd78e661617f3 );
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "mp_sat_avalon_q1_ob_activity_cradle_convergence_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "mp_sat_avalon_q1_ob_activity_cradle_convergence_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace mp_sat_avalon_q1_ob_activity_cradle_convergence_cs
// Params 3, eflags: 0x4
// Checksum 0x2c5c0f92, Offset: 0x330
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "mp_sat_avalon_q1_ob_activity_cradle_convergence_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "mp_sat_avalon_q1_ob_activity_cradle_convergence_cs" );
}

// Namespace mp_sat_avalon_q1_ob_activity_cradle_convergence_cs
// Params 3, eflags: 0x4
// Checksum 0x90712e74, Offset: 0x3aa
// Size: 0x232
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_cradle_convergence_cs";
    s.activity_bundle = "sat_activitydef_global_activity_poi_boss";
    s.name = "POI_BOSS_STADIUM";
    fe [[ f ]]( s, "POI_BOSS_STADIUM", cf, ( -46104.7, 14220.4, 274.02 ), ( 0, 290.1, 0 ), "activity_nexus_variant", "activity_nexus_variant", undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_cradle_convergence_cs";
    fe [[ f ]]( s, "POI_BOSS_STADIUM", cf, ( -46120.6, 14232.5, 274.05 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Awareness_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 5000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_cradle_convergence_cs";
    s.activity_bundle = "sat_activitydef_global_activity_poi_boss";
    s.name = "POI_BOSS_CASINO";
    fe [[ f ]]( s, "POI_BOSS_CASINO", cf, ( -12101.3, 23259.3, 616 ), ( 0, 22.3, 0 ), "activity_nexus_variant", "activity_nexus_variant", undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_cradle_convergence_cs";
    fe [[ f ]]( s, "POI_BOSS_CASINO", cf, ( -9859.04, 25693.8, 772.5 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Awareness_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 7000 );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace mp_sat_avalon_q1_ob_activity_cradle_convergence_cs
// Params 0, eflags: 0x4
// Checksum 0x4499e9a0, Offset: 0x5e4
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace mp_sat_avalon_q1_ob_activity_cradle_convergence_cs
// Params 0
// Checksum 0xee0fd2df, Offset: 0x5ee
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "mp_sat_avalon_q1_ob_activity_cradle_convergence_cs" );
}

// Namespace mp_sat_avalon_q1_ob_activity_cradle_convergence_cs
// Params 0
// Checksum 0x64ab3533, Offset: 0x604
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

// Namespace mp_sat_avalon_q1_ob_activity_cradle_convergence_cs
// Params 4
// Checksum 0xf1aab956, Offset: 0x673
// Size: 0x71
function function_d4323822d7042e5a( var_4312b79c960726b6, fe, us, cf = "mp_sat_avalon_q1_ob_activity_cradle_convergence_cs" )
{
    switch ( var_4312b79c960726b6 )
    {
        case #"hash_be43738c9b0b8e01":
            function_678bcdc408794ca9( fe, us, cf );
            break;
        case #"hash_f1cdb8c524b6a52d":
            function_2fa78d023765f435( fe, us, cf );
            break;
    }
}

// Namespace mp_sat_avalon_q1_ob_activity_cradle_convergence_cs
// Params 3
// Checksum 0x98771ebb, Offset: 0x6ec
// Size: 0x69f
function function_678bcdc408794ca9( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_cradle_convergence_cs";
    s.name = "script_struct_leash";
    fe [[ f ]]( s, "POI_BOSS_STADIUM", cf, ( -45257, 16041.3, 334.22 ), ( 0, 290.6, 0 ), "cspf_3_auto15031814326340931857", undefined, "s_boss_tether_data", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 4000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_cradle_convergence_cs";
    s.name = "s_deposit_portal";
    fe [[ f ]]( s, "POI_BOSS_STADIUM", cf, ( -42831.9, 11718, 449.98 ), ( 0, 0, 0 ), "cspf_3_auto15031814326340931857", undefined, "s_deposit_portal", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_cradle_convergence_cs";
    s.name = "s_deposit_portal";
    fe [[ f ]]( s, "POI_BOSS_STADIUM", cf, ( -46329.6, 11873.8, 385.98 ), ( 0, 180, 0 ), "cspf_3_auto15031814326340931857", undefined, "s_deposit_portal", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_cradle_convergence_cs";
    s.name = "s_center";
    fe [[ f ]]( s, "POI_BOSS_STADIUM", cf, ( -46120.8, 14228.2, 274.04 ), ( 0, 290.6, 0 ), "activity_nexus_variant", "cspf_3_auto15031814326340931857", "POI_BOSS_STADIUM", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 500 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_cradle_convergence_cs";
    s.name = "s_deposit_portal";
    fe [[ f ]]( s, "POI_BOSS_STADIUM", cf, ( -44840.4, 12915.8, 513.98 ), ( 0, 270.5, 0 ), "cspf_3_auto15031814326340931857", undefined, "s_deposit_portal", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_cradle_convergence_cs";
    s.name = "s_deposit_portal";
    fe [[ f ]]( s, "POI_BOSS_STADIUM", cf, ( -45435, 14530.4, 314.67 ), ( 0, 15, 0 ), "cspf_3_auto15031814326340931857", undefined, "s_deposit_portal", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_cradle_convergence_cs";
    s.name = "s_deposit_portal";
    fe [[ f ]]( s, "POI_BOSS_STADIUM", cf, ( -44025.7, 14184.2, 436.99 ), ( 0, 303.5, 0 ), "cspf_3_auto15031814326340931857", undefined, "s_deposit_portal", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_cradle_convergence_cs";
    s.name = "s_deposit_portal";
    fe [[ f ]]( s, "POI_BOSS_STADIUM", cf, ( -44990.3, 11679.5, 517.74 ), ( 0, 0, 0 ), "cspf_3_auto15031814326340931857", undefined, "s_deposit_portal", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_cradle_convergence_cs";
    s.name = "s_deposit_portal";
    fe [[ f ]]( s, "POI_BOSS_STADIUM", cf, ( -44257.8, 10361.9, 455.73 ), ( 0, 270, 0 ), "cspf_3_auto15031814326340931857", undefined, "s_deposit_portal", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_cradle_convergence_cs";
    s.name = "s_deposit_portal";
    fe [[ f ]]( s, "POI_BOSS_STADIUM", cf, ( -45626, 10460, 357.98 ), ( 0, 270, 0 ), "cspf_3_auto15031814326340931857", undefined, "s_deposit_portal", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_cradle_convergence_cs";
    s.name = "s_deposit_portal";
    fe [[ f ]]( s, "POI_BOSS_STADIUM", cf, ( -43791, 15744.5, 314.98 ), ( 0, 252, 0 ), "cspf_3_auto15031814326340931857", undefined, "s_deposit_portal", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_cradle_convergence_cs";
    s.name = "s_deposit_portal";
    fe [[ f ]]( s, "POI_BOSS_STADIUM", cf, ( -43868.1, 12246.3, 483.98 ), ( 0, 90, 0 ), "cspf_3_auto15031814326340931857", undefined, "s_deposit_portal", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_cradle_convergence_cs";
    s.boss_leash = "3500";
    fe [[ f ]]( s, "POI_BOSS_STADIUM", cf, ( -46792.6, 15497.2, 262.96 ), ( 0, 290.6, 0 ), "cspf_3_auto15031814326340931857", undefined, "s_boss_spawn_pos_alt", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 3500 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_cradle_convergence_cs";
    s.boss_leash = "3500";
    fe [[ f ]]( s, "POI_BOSS_STADIUM", cf, ( -46792.6, 15497.2, 262.96 ), ( 0, 290.6, 0 ), "cspf_3_auto15031814326340931857", undefined, "s_boss_spawn_pos", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 3500 );
}

// Namespace mp_sat_avalon_q1_ob_activity_cradle_convergence_cs
// Params 3
// Checksum 0xd51314cd, Offset: 0xd93
// Size: 0x69f
function function_2fa78d023765f435( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_cradle_convergence_cs";
    s.name = "script_struct_leash";
    fe [[ f ]]( s, "POI_BOSS_CASINO", cf, ( -12161.5, 23350, 616 ), ( 0, 290.6, 0 ), "cspf_4_auto8782103999559488459", undefined, "s_boss_tether_data", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 4000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_cradle_convergence_cs";
    s.name = "s_deposit_portal";
    fe [[ f ]]( s, "POI_BOSS_CASINO", cf, ( -12033.6, 28571.6, 817.68 ), ( 0, 310, 0 ), "cspf_4_auto8782103999559488459", undefined, "s_deposit_portal", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_cradle_convergence_cs";
    s.name = "s_deposit_portal";
    fe [[ f ]]( s, "POI_BOSS_CASINO", cf, ( -12349.4, 26769.2, 497.68 ), ( 0, 130, 0 ), "cspf_4_auto8782103999559488459", undefined, "s_deposit_portal", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_cradle_convergence_cs";
    s.name = "s_center";
    fe [[ f ]]( s, "POI_BOSS_CASINO", cf, ( -12101.3, 23259.3, 616 ), ( 0, 22.8, 0 ), "activity_nexus_variant", "cspf_4_auto8782103999559488459", "POI_BOSS_CASINO", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 500 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_cradle_convergence_cs";
    s.name = "s_deposit_portal";
    fe [[ f ]]( s, "POI_BOSS_CASINO", cf, ( -10479.1, 24483.9, 819.68 ), ( 0, 310, 0 ), "cspf_4_auto8782103999559488459", undefined, "s_deposit_portal", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_cradle_convergence_cs";
    s.name = "s_deposit_portal";
    fe [[ f ]]( s, "POI_BOSS_CASINO", cf, ( -7300.2, 23903.5, 813.68 ), ( 0, 130, 0 ), "cspf_4_auto8782103999559488459", undefined, "s_deposit_portal", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_cradle_convergence_cs";
    s.name = "s_deposit_portal";
    fe [[ f ]]( s, "POI_BOSS_CASINO", cf, ( -7223, 25085.3, 817.68 ), ( 0, 220, 0 ), "cspf_4_auto8782103999559488459", undefined, "s_deposit_portal", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_cradle_convergence_cs";
    s.name = "s_deposit_portal";
    fe [[ f ]]( s, "POI_BOSS_CASINO", cf, ( -6336.1, 25727.5, 820.68 ), ( 0, 310, 0 ), "cspf_4_auto8782103999559488459", undefined, "s_deposit_portal", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_cradle_convergence_cs";
    s.name = "s_deposit_portal";
    fe [[ f ]]( s, "POI_BOSS_CASINO", cf, ( -8537.5, 25376.2, 819.68 ), ( 0, 310, 0 ), "cspf_4_auto8782103999559488459", undefined, "s_deposit_portal", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_cradle_convergence_cs";
    s.name = "s_deposit_portal";
    fe [[ f ]]( s, "POI_BOSS_CASINO", cf, ( -9909.7, 27011.6, 817.68 ), ( 0, 310, 0 ), "cspf_4_auto8782103999559488459", undefined, "s_deposit_portal", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_cradle_convergence_cs";
    s.name = "s_deposit_portal";
    fe [[ f ]]( s, "POI_BOSS_CASINO", cf, ( -8758.2, 28395.1, 819.68 ), ( 0, 220, 0 ), "cspf_4_auto8782103999559488459", undefined, "s_deposit_portal", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_cradle_convergence_cs";
    s.name = "s_deposit_portal";
    fe [[ f ]]( s, "POI_BOSS_CASINO", cf, ( -10756.3, 28498.4, 819.68 ), ( 0, 220, 0 ), "cspf_4_auto8782103999559488459", undefined, "s_deposit_portal", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_cradle_convergence_cs";
    s.boss_leash = "3500";
    fe [[ f ]]( s, "POI_BOSS_CASINO", cf, ( -12101.3, 23259.3, 616 ), ( 0, 22.8, 0 ), "cspf_4_auto8782103999559488459", undefined, "s_boss_spawn_pos_alt", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 3500 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_activity_cradle_convergence_cs";
    s.boss_leash = "3500";
    fe [[ f ]]( s, "POI_BOSS_CASINO", cf, ( -12101.3, 23259.3, 616 ), ( 0, 22.8, 0 ), "cspf_4_auto8782103999559488459", undefined, "s_boss_spawn_pos", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 3500 );
}

// Namespace mp_sat_avalon_q1_ob_activity_cradle_convergence_cs
// Params 0
// Checksum 0x13f2606c, Offset: 0x143a
// Size: 0x1b7
function function_d9dd7965c51c95d1()
{
    activityinstances = [];
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_activitydef_global_activity_poi_boss";
    var_881289d7987bc770.cf = "mp_sat_avalon_q1_ob_activity_cradle_convergence_cs";
    var_881289d7987bc770.scriptstructorigin = ( -46104.7, 14220.4, 274.02 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [ ( -44966, 13048, 464 ) ];
    var_881289d7987bc770.var_31ce4477e3543d24 = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.locationradius = [ 4000 ];
    activityinstances[ "POI_BOSS_STADIUM" ] = var_881289d7987bc770;
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_activitydef_global_activity_poi_boss";
    var_881289d7987bc770.cf = "mp_sat_avalon_q1_ob_activity_cradle_convergence_cs";
    var_881289d7987bc770.scriptstructorigin = ( -12101.3, 23259.3, 616 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [ ( -9859.04, 25693.8, 770 ) ];
    var_881289d7987bc770.var_31ce4477e3543d24 = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.locationradius = [ 4000 ];
    activityinstances[ "POI_BOSS_CASINO" ] = var_881289d7987bc770;
    return activityinstances;
}

