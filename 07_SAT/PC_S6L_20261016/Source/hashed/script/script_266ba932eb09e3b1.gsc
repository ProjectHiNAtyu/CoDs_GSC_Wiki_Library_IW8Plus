// script_266ba932eb09e3b1  (hash_266ba932eb09e3b1.gscc) (size: 7875 Bytes / 0x1ec3 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xb28f6b4e (2995743566)
// size ...... 7875 (0x1ec3)
// includes .. 4   (offset: 0x1b23)
// strings ... 20  (offset: 0x1b43)
// dev strs .. 0   (offset: 0x1ec3)
// exports ... 14  (offset: 0x15f7)
// cseg ...... 0x238 + 0x13bf (0x15f7)
// imports ... 27  (offset: 0x1827)
// animtree1 . 0   (offset: 0x1ec3)
// animtree2 . 0   (offset: 0x1ec3)
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace mp_sat_avalon_q3_ob_activity_cradle_convergence_cs;

// Namespace mp_sat_avalon_q3_ob_activity_cradle_convergence_cs
// Params 0, eflags: 0x5
// Checksum 0x5032e404, Offset: 0x256
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"mp_sat_avalon_q3_ob_activity_cradle_convergence_cs", #"activity_common", &function_b39ecd3d51489472, undefined );
}

// Namespace mp_sat_avalon_q3_ob_activity_cradle_convergence_cs
// Params 0, eflags: 0x4
// Checksum 0xacb2e772, Offset: 0x27f
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace mp_sat_avalon_q3_ob_activity_cradle_convergence_cs
// Params 0, eflags: 0x4
// Checksum 0x2989349e, Offset: 0x290
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace mp_sat_avalon_q3_ob_activity_cradle_convergence_cs
// Params 2
// Checksum 0x9107fbff, Offset: 0x2a1
// Size: 0x8c
function main( unused, unused2 )
{
    if ( utility::flag_exist( "mp_sat_avalon_q3_ob_activity_cradle_convergence_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "mp_sat_avalon_q3_ob_activity_cradle_convergence_cs" ) )
    {
        return;
    }
    
    activity_common::function_e1df676808c1d1e3( &function_4cd78e661617f3 );
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "mp_sat_avalon_q3_ob_activity_cradle_convergence_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "mp_sat_avalon_q3_ob_activity_cradle_convergence_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace mp_sat_avalon_q3_ob_activity_cradle_convergence_cs
// Params 3, eflags: 0x4
// Checksum 0xaa0b8051, Offset: 0x335
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "mp_sat_avalon_q3_ob_activity_cradle_convergence_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "mp_sat_avalon_q3_ob_activity_cradle_convergence_cs" );
}

// Namespace mp_sat_avalon_q3_ob_activity_cradle_convergence_cs
// Params 3, eflags: 0x4
// Checksum 0x74e43770, Offset: 0x3af
// Size: 0x232
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_cradle_convergence_cs";
    s.activity_bundle = "sat_activitydef_global_activity_poi_boss";
    s.name = "POI_BOSS_LISTENING_POST";
    fe [[ f ]]( s, "POI_BOSS_LISTENING_POST", cf, ( -21142.5, -46243, 382.71 ), ( 0, 190, 0 ), "activity_nexus_variant", "activity_nexus_variant", undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_cradle_convergence_cs";
    fe [[ f ]]( s, "POI_BOSS_LISTENING_POST", cf, ( -22310.8, -43207.8, 355.58 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Awareness_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 5500 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_cradle_convergence_cs";
    s.activity_bundle = "sat_activitydef_global_activity_poi_boss";
    s.name = "POI_BOSS_FORT";
    fe [[ f ]]( s, "POI_BOSS_FORT", cf, ( -36110.3, -44564.3, 495.57 ), ( 0, 93.7, 0 ), "activity_nexus_variant", "activity_nexus_variant", undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_cradle_convergence_cs";
    fe [[ f ]]( s, "POI_BOSS_FORT", cf, ( -37729.8, -41923, 726.8 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Awareness_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 4500 );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace mp_sat_avalon_q3_ob_activity_cradle_convergence_cs
// Params 0, eflags: 0x4
// Checksum 0x86834fb2, Offset: 0x5e9
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace mp_sat_avalon_q3_ob_activity_cradle_convergence_cs
// Params 0
// Checksum 0x68585d1c, Offset: 0x5f3
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "mp_sat_avalon_q3_ob_activity_cradle_convergence_cs" );
}

// Namespace mp_sat_avalon_q3_ob_activity_cradle_convergence_cs
// Params 0
// Checksum 0xe2fcbaf0, Offset: 0x609
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

// Namespace mp_sat_avalon_q3_ob_activity_cradle_convergence_cs
// Params 4
// Checksum 0xe9a4180b, Offset: 0x678
// Size: 0x71
function function_d4323822d7042e5a( var_4312b79c960726b6, fe, us, cf = "mp_sat_avalon_q3_ob_activity_cradle_convergence_cs" )
{
    switch ( var_4312b79c960726b6 )
    {
        case #"hash_b63bf6ce783f9aa2":
            function_2748ab6f71b12cca( fe, us, cf );
            break;
        case #"hash_33c822fdbe60e443":
            function_238df2bce1cf70b( fe, us, cf );
            break;
    }
}

// Namespace mp_sat_avalon_q3_ob_activity_cradle_convergence_cs
// Params 3
// Checksum 0x28aa9e72, Offset: 0x6f1
// Size: 0x69f
function function_2748ab6f71b12cca( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_cradle_convergence_cs";
    s.boss_leash = "3500";
    fe [[ f ]]( s, "POI_BOSS_LISTENING_POST", cf, ( -21142.5, -46242.9, 382.72 ), ( 0, 190, 0 ), "cspf_3_auto13159979657078099638", undefined, "s_boss_spawn_pos_alt", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 3500 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_cradle_convergence_cs";
    s.name = "s_deposit_portal";
    fe [[ f ]]( s, "POI_BOSS_LISTENING_POST", cf, ( -25028.8, -40231.1, 692.31 ), ( 0, 310, 0 ), "cspf_3_auto13159979657078099638", undefined, "s_deposit_portal", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_cradle_convergence_cs";
    s.name = "s_deposit_portal";
    fe [[ f ]]( s, "POI_BOSS_LISTENING_POST", cf, ( -25198.1, -41785.1, 660 ), ( 0, 340, 0 ), "cspf_3_auto13159979657078099638", undefined, "s_deposit_portal", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_cradle_convergence_cs";
    s.name = "s_center";
    fe [[ f ]]( s, "POI_BOSS_LISTENING_POST", cf, ( -21142.5, -46242.9, 382.72 ), ( 0, 190, 0 ), "activity_nexus_variant", "cspf_3_auto13159979657078099638", "POI_BOSS_LISTENING_POST", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 500 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_cradle_convergence_cs";
    s.name = "s_deposit_portal";
    fe [[ f ]]( s, "POI_BOSS_LISTENING_POST", cf, ( -25837.5, -44534.5, 472 ), ( 0, 15, 0 ), "cspf_3_auto13159979657078099638", undefined, "s_deposit_portal", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_cradle_convergence_cs";
    s.name = "s_deposit_portal";
    fe [[ f ]]( s, "POI_BOSS_LISTENING_POST", cf, ( -22515.1, -40550.3, 450.61 ), ( 0, 10, 0 ), "cspf_3_auto13159979657078099638", undefined, "s_deposit_portal", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_cradle_convergence_cs";
    s.name = "s_deposit_portal";
    fe [[ f ]]( s, "POI_BOSS_LISTENING_POST", cf, ( -20226.9, -39575.4, 409.04 ), ( 0, 105, 0 ), "cspf_3_auto13159979657078099638", undefined, "s_deposit_portal", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_cradle_convergence_cs";
    s.name = "s_deposit_portal";
    fe [[ f ]]( s, "POI_BOSS_LISTENING_POST", cf, ( -23584.8, -43865.9, 573.34 ), ( 0, 10, 0 ), "cspf_3_auto13159979657078099638", undefined, "s_deposit_portal", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_cradle_convergence_cs";
    s.name = "s_deposit_portal";
    fe [[ f ]]( s, "POI_BOSS_LISTENING_POST", cf, ( -20719.3, -44834.8, 440.98 ), ( 0, 283.5, 0 ), "cspf_3_auto13159979657078099638", undefined, "s_deposit_portal", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_cradle_convergence_cs";
    s.name = "s_deposit_portal";
    fe [[ f ]]( s, "POI_BOSS_LISTENING_POST", cf, ( -19484.7, -43463.6, 396.14 ), ( 0, 10, 0 ), "cspf_3_auto13159979657078099638", undefined, "s_deposit_portal", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_cradle_convergence_cs";
    s.name = "s_deposit_portal";
    fe [[ f ]]( s, "POI_BOSS_LISTENING_POST", cf, ( -20251.1, -41643.9, 406.26 ), ( 0, 10, 0 ), "cspf_3_auto13159979657078099638", undefined, "s_deposit_portal", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_cradle_convergence_cs";
    s.name = "s_deposit_portal";
    fe [[ f ]]( s, "POI_BOSS_LISTENING_POST", cf, ( -22918.6, -39528, 836 ), ( 0, 283.5, 0 ), "cspf_3_auto13159979657078099638", undefined, "s_deposit_portal", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_cradle_convergence_cs";
    s.boss_leash = "3500";
    fe [[ f ]]( s, "POI_BOSS_LISTENING_POST", cf, ( -21142.5, -46242.9, 382.72 ), ( 0, 190, 0 ), "cspf_3_auto13159979657078099638", undefined, "s_boss_spawn_pos", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 3500 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_cradle_convergence_cs";
    s.name = "script_struct_leash";
    fe [[ f ]]( s, "POI_BOSS_LISTENING_POST", cf, ( -21178.2, -46235.9, 382.3 ), ( 0, 190, 0 ), "cspf_3_auto13159979657078099638", undefined, "s_boss_tether_data", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 6000 );
}

// Namespace mp_sat_avalon_q3_ob_activity_cradle_convergence_cs
// Params 3
// Checksum 0xd398a276, Offset: 0xd98
// Size: 0x69f
function function_238df2bce1cf70b( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_cradle_convergence_cs";
    s.name = "script_struct_leash";
    fe [[ f ]]( s, "POI_BOSS_FORT", cf, ( -36078.2, -44523.3, 501.48 ), ( 0, 190, 0 ), "cspf_4_auto3775574694229595671", undefined, "s_boss_tether_data", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 5000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_cradle_convergence_cs";
    s.boss_leash = "3500";
    fe [[ f ]]( s, "POI_BOSS_FORT", cf, ( -36110.3, -44564.3, 495.6 ), ( 0, 93.7, 0 ), "cspf_4_auto3775574694229595671", undefined, "s_boss_spawn_pos_alt", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 3500 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_cradle_convergence_cs";
    s.name = "s_deposit_portal";
    fe [[ f ]]( s, "POI_BOSS_FORT", cf, ( -38588.5, -42082.6, 779.76 ), ( 0, 180, 0 ), "cspf_4_auto3775574694229595671", undefined, "s_deposit_portal", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_cradle_convergence_cs";
    s.name = "s_deposit_portal";
    fe [[ f ]]( s, "POI_BOSS_FORT", cf, ( -39377.3, -40866.3, 954.42 ), ( 0, 228.1, 0 ), "cspf_4_auto3775574694229595671", undefined, "s_deposit_portal", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_cradle_convergence_cs";
    s.name = "s_center";
    fe [[ f ]]( s, "POI_BOSS_FORT", cf, ( -36110.3, -44564.3, 495.6 ), ( 0, 93.7, 0 ), "activity_nexus_variant", "cspf_4_auto3775574694229595671", "POI_BOSS_FORT", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 500 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_cradle_convergence_cs";
    s.name = "s_deposit_portal";
    fe [[ f ]]( s, "POI_BOSS_FORT", cf, ( -38338.6, -40263.1, 1090.17 ), ( 0, 270, 0 ), "cspf_4_auto3775574694229595671", undefined, "s_deposit_portal", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_cradle_convergence_cs";
    s.name = "s_deposit_portal";
    fe [[ f ]]( s, "POI_BOSS_FORT", cf, ( -37305.7, -40647.8, 930.42 ), ( 0, 0, 0 ), "cspf_4_auto3775574694229595671", undefined, "s_deposit_portal", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_cradle_convergence_cs";
    s.name = "s_deposit_portal";
    fe [[ f ]]( s, "POI_BOSS_FORT", cf, ( -36907.7, -41608.9, 788.42 ), ( 0, 90, 0 ), "cspf_4_auto3775574694229595671", undefined, "s_deposit_portal", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_cradle_convergence_cs";
    s.name = "s_deposit_portal";
    fe [[ f ]]( s, "POI_BOSS_FORT", cf, ( -37471.3, -42581.3, 1116.25 ), ( 0, 270, 0 ), "cspf_4_auto3775574694229595671", undefined, "s_deposit_portal", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_cradle_convergence_cs";
    s.name = "s_deposit_portal";
    fe [[ f ]]( s, "POI_BOSS_FORT", cf, ( -37939.5, -43190, 737.66 ), ( 0, 270, 0 ), "cspf_4_auto3775574694229595671", undefined, "s_deposit_portal", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_cradle_convergence_cs";
    s.name = "s_deposit_portal";
    fe [[ f ]]( s, "POI_BOSS_FORT", cf, ( -39355.9, -42798.1, 752.16 ), ( 0, 270, 0 ), "cspf_4_auto3775574694229595671", undefined, "s_deposit_portal", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_cradle_convergence_cs";
    s.name = "s_deposit_portal";
    fe [[ f ]]( s, "POI_BOSS_FORT", cf, ( -36129.2, -42094.2, 779.2 ), ( 0, 0, 0 ), "cspf_4_auto3775574694229595671", undefined, "s_deposit_portal", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_cradle_convergence_cs";
    s.name = "s_deposit_portal";
    fe [[ f ]]( s, "POI_BOSS_FORT", cf, ( -38622.5, -39277.7, 943 ), ( 0, 270, 0 ), "cspf_4_auto3775574694229595671", undefined, "s_deposit_portal", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_activity_cradle_convergence_cs";
    s.boss_leash = "3500";
    fe [[ f ]]( s, "POI_BOSS_FORT", cf, ( -36110.3, -44564.3, 495.6 ), ( 0, 93.7, 0 ), "cspf_4_auto3775574694229595671", undefined, "s_boss_spawn_pos", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 3500 );
}

// Namespace mp_sat_avalon_q3_ob_activity_cradle_convergence_cs
// Params 0
// Checksum 0xb0e2e684, Offset: 0x143f
// Size: 0x1b7
function function_d9dd7965c51c95d1()
{
    activityinstances = [];
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_activitydef_global_activity_poi_boss";
    var_881289d7987bc770.cf = "mp_sat_avalon_q3_ob_activity_cradle_convergence_cs";
    var_881289d7987bc770.scriptstructorigin = ( -21142.5, -46243, 382.71 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [ ( -22310.8, -43207.8, 355.58 ) ];
    var_881289d7987bc770.var_31ce4477e3543d24 = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.locationradius = [ 4500 ];
    activityinstances[ "POI_BOSS_LISTENING_POST" ] = var_881289d7987bc770;
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_activitydef_global_activity_poi_boss";
    var_881289d7987bc770.cf = "mp_sat_avalon_q3_ob_activity_cradle_convergence_cs";
    var_881289d7987bc770.scriptstructorigin = ( -36110.3, -44564.3, 495.57 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [ ( -37729.8, -41923, 726.8 ) ];
    var_881289d7987bc770.var_31ce4477e3543d24 = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.locationradius = [ 3500 ];
    activityinstances[ "POI_BOSS_FORT" ] = var_881289d7987bc770;
    return activityinstances;
}

