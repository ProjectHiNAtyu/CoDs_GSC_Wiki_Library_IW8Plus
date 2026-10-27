// script_40a6e6302f85ec58  (hash_40a6e6302f85ec58.gscc) (size: 7078 Bytes / 0x1ba6 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x3dc71003 (1036455939)
// size ...... 7078 (0x1ba6)
// includes .. 4   (offset: 0x186e)
// strings ... 24  (offset: 0x188e)
// dev strs .. 0   (offset: 0x1ba6)
// exports ... 14  (offset: 0x1342)
// cseg ...... 0x2ff + 0x1043 (0x1342)
// imports ... 27  (offset: 0x1572)
// animtree1 . 0   (offset: 0x1ba6)
// animtree2 . 0   (offset: 0x1ba6)
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace mp_sat_avalon_city_ob_activity_prop_hunt_cs;

// Namespace mp_sat_avalon_city_ob_activity_prop_hunt_cs
// Params 0, eflags: 0x5
// Checksum 0xdeeda1c7, Offset: 0x31d
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"mp_sat_avalon_city_ob_activity_prop_hunt_cs", #"activity_common", &function_b39ecd3d51489472, undefined );
}

// Namespace mp_sat_avalon_city_ob_activity_prop_hunt_cs
// Params 0, eflags: 0x4
// Checksum 0xc1130270, Offset: 0x346
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace mp_sat_avalon_city_ob_activity_prop_hunt_cs
// Params 0, eflags: 0x4
// Checksum 0x4428d19c, Offset: 0x357
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace mp_sat_avalon_city_ob_activity_prop_hunt_cs
// Params 2
// Checksum 0x4e5b1558, Offset: 0x368
// Size: 0x8c
function main( unused, unused2 )
{
    if ( utility::flag_exist( "mp_sat_avalon_city_ob_activity_prop_hunt_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "mp_sat_avalon_city_ob_activity_prop_hunt_cs" ) )
    {
        return;
    }
    
    activity_common::function_e1df676808c1d1e3( &function_4cd78e661617f3 );
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "mp_sat_avalon_city_ob_activity_prop_hunt_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "mp_sat_avalon_city_ob_activity_prop_hunt_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace mp_sat_avalon_city_ob_activity_prop_hunt_cs
// Params 3, eflags: 0x4
// Checksum 0xc7aa6553, Offset: 0x3fc
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "mp_sat_avalon_city_ob_activity_prop_hunt_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "mp_sat_avalon_city_ob_activity_prop_hunt_cs" );
}

// Namespace mp_sat_avalon_city_ob_activity_prop_hunt_cs
// Params 3, eflags: 0x4
// Checksum 0x75f3d4a8, Offset: 0x476
// Size: 0x22c
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_prop_hunt_cs";
    s.activity_bundle = "sat_ob_activitydefinition_prop_hunt_city_art_gallery";
    s.name = "PROP_HUNT_ART_GALLERY";
    fe [[ f ]]( s, "PROP_HUNT_ART_GALLERY", cf, ( -14650.5, -7640.54, 1056 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_prop_hunt_cs";
    fe [[ f ]]( s, "PROP_HUNT_ART_GALLERY", cf, ( -14634.5, -7653.42, 1059.07 ), ( 0, 0, 0 ), "activity_nexus_instance_joiner", "PROP_HUNT_ART_GALLERY", "PROP_HUNT_ART_GALLERY", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_prop_hunt_cs";
    s.activity_bundle = "sat_ob_activitydefinition_prop_hunt_city_tennis";
    s.name = "PROP_HUNT_TENNIS";
    fe [[ f ]]( s, "PROP_HUNT_TENNIS", cf, ( 7830.09, -2471.81, 557.11 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_prop_hunt_cs";
    fe [[ f ]]( s, "PROP_HUNT_TENNIS", cf, ( 7827.44, -2424.83, 733.06 ), ( 0, 0, 0 ), "activity_nexus_instance_joiner", "PROP_HUNT_TENNIS", "PROP_HUNT_TENNIS", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace mp_sat_avalon_city_ob_activity_prop_hunt_cs
// Params 0, eflags: 0x4
// Checksum 0x59dfa115, Offset: 0x6aa
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace mp_sat_avalon_city_ob_activity_prop_hunt_cs
// Params 0
// Checksum 0x5f9b81e, Offset: 0x6b4
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "mp_sat_avalon_city_ob_activity_prop_hunt_cs" );
}

// Namespace mp_sat_avalon_city_ob_activity_prop_hunt_cs
// Params 0
// Checksum 0x43c164c9, Offset: 0x6ca
// Size: 0x66
function function_4cd78e661617f3()
{
    activityinfostruct = {};
    activityinfostruct.name = "REV_OB_PROP_HUNT";
    activityinfostruct.scriptbundle = "sat_ob_activitydefinition_prop_hunt";
    activityinfostruct.mainfunction = &main;
    activityinfostruct.var_934f068483ae4ddb = &function_d4323822d7042e5a;
    activityinfostruct.metadatafunction = &function_d9dd7965c51c95d1;
    return activityinfostruct;
}

// Namespace mp_sat_avalon_city_ob_activity_prop_hunt_cs
// Params 4
// Checksum 0x6d01e8c7, Offset: 0x739
// Size: 0x71
function function_d4323822d7042e5a( var_4312b79c960726b6, fe, us, cf = "mp_sat_avalon_city_ob_activity_prop_hunt_cs" )
{
    switch ( var_4312b79c960726b6 )
    {
        case #"hash_57a0bacf2eb6f3c7":
            function_b57e2817ff788c7f( fe, us, cf );
            break;
        case #"hash_886310da61cba1ce":
            function_6ed03af44d84daa6( fe, us, cf );
            break;
    }
}

// Namespace mp_sat_avalon_city_ob_activity_prop_hunt_cs
// Params 3
// Checksum 0xe47465cd, Offset: 0x7b2
// Size: 0x4e4
function function_b57e2817ff788c7f( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_prop_hunt_cs";
    s.groupid = "prop_1";
    s.name = "mysteryprop_1_enemy_struct";
    fe [[ f ]]( s, "PROP_HUNT_ART_GALLERY", cf, ( -13998.7, -7337.6, 1056 ), ( 0, 181.7, 0 ), "mysteryprop_1_enemy_struct", "PROP_HUNT_ART_GALLERY", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_prop_hunt_cs";
    s.groupid = "prop_1";
    s.name = "mysteryprop_1_scriptable_struct";
    fe [[ f ]]( s, "PROP_HUNT_ART_GALLERY", cf, ( -13980.8, -7341.2, 1056 ), ( 0, 90, 0 ), "mysteryprop_1_scriptable_struct", "PROP_HUNT_ART_GALLERY", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_prop_hunt_cs";
    s.groupid = "prop_2";
    s.name = "mysteryprop_2_scriptable_struct";
    fe [[ f ]]( s, "PROP_HUNT_ART_GALLERY", cf, ( -14193.6, -7623.61, 1088 ), ( 0, 104, 0 ), "mysteryprop_2_scriptable_struct", "PROP_HUNT_ART_GALLERY", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_prop_hunt_cs";
    s.groupid = "prop_3";
    s.name = "mysteryprop_3_scriptable_struct";
    fe [[ f ]]( s, "PROP_HUNT_ART_GALLERY", cf, ( -14723.3, -7576.78, 1056 ), ( 0, 60, 0 ), "mysteryprop_3_scriptable_struct", "PROP_HUNT_ART_GALLERY", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_prop_hunt_cs";
    s.groupid = "prop_1";
    s.name = "mysteryprop_1_chest_struct";
    fe [[ f ]]( s, "PROP_HUNT_ART_GALLERY", cf, ( -13998.7, -7337.6, 1056 ), ( 0, 181.69, 0 ), "mysteryprop_1_chest_struct", "PROP_HUNT_ART_GALLERY", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_prop_hunt_cs";
    s.groupid = "prop_2";
    s.name = "mysteryprop_2_enemy_struct";
    fe [[ f ]]( s, "PROP_HUNT_ART_GALLERY", cf, ( -14176.2, -7615.82, 1088 ), ( 0, 280.4, 0 ), "mysteryprop_2_enemy_struct", "PROP_HUNT_ART_GALLERY", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_prop_hunt_cs";
    s.groupid = "prop_2";
    s.name = "mysteryprop_2_chest_struct";
    fe [[ f ]]( s, "PROP_HUNT_ART_GALLERY", cf, ( -14176.2, -7615.82, 1088 ), ( 0, 280.4, 0 ), "mysteryprop_2_chest_struct", "PROP_HUNT_ART_GALLERY", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_prop_hunt_cs";
    s.groupid = "prop_3";
    s.name = "mysteryprop_3_enemy_struct";
    fe [[ f ]]( s, "PROP_HUNT_ART_GALLERY", cf, ( -14745.3, -7563.49, 1056 ), ( 0, 61.2, 0 ), "mysteryprop_3_enemy_struct", "PROP_HUNT_ART_GALLERY", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_prop_hunt_cs";
    s.groupid = "prop_3";
    s.name = "mysteryprop_3_chest_struct";
    fe [[ f ]]( s, "PROP_HUNT_ART_GALLERY", cf, ( -14745.3, -7563.49, 1056 ), ( 0, 61.2, 0 ), "mysteryprop_3_chest_struct", "PROP_HUNT_ART_GALLERY", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_sat_avalon_city_ob_activity_prop_hunt_cs
// Params 3
// Checksum 0x1733a274, Offset: 0xc9e
// Size: 0x4e4
function function_6ed03af44d84daa6( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_prop_hunt_cs";
    s.groupid = "prop_1";
    s.name = "mysteryprop_1_enemy_struct";
    fe [[ f ]]( s, "PROP_HUNT_TENNIS", cf, ( 7792.86, -2022.45, 724 ), ( 0, 136.7, 0 ), "mysteryprop_1_enemy_struct", "PROP_HUNT_TENNIS", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_prop_hunt_cs";
    s.groupid = "prop_3";
    s.name = "mysteryprop_3_scriptable_struct";
    fe [[ f ]]( s, "PROP_HUNT_TENNIS", cf, ( 7853.16, -2427.46, 724 ), ( 0, 318, 0 ), "mysteryprop_3_scriptable_struct", "PROP_HUNT_TENNIS", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_prop_hunt_cs";
    s.groupid = "prop_1";
    s.name = "mysteryprop_1_chest_struct";
    fe [[ f ]]( s, "PROP_HUNT_TENNIS", cf, ( 7792.86, -2022.45, 724 ), ( 0, 136.7, 0 ), "mysteryprop_1_chest_struct", "PROP_HUNT_TENNIS", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_prop_hunt_cs";
    s.groupid = "prop_2";
    s.name = "mysteryprop_2_enemy_struct";
    fe [[ f ]]( s, "PROP_HUNT_TENNIS", cf, ( 7564.2, -3116.59, 740 ), ( 0, 230.4, 0 ), "mysteryprop_2_enemy_struct", "PROP_HUNT_TENNIS", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_prop_hunt_cs";
    s.groupid = "prop_2";
    s.name = "mysteryprop_2_scriptable_struct";
    fe [[ f ]]( s, "PROP_HUNT_TENNIS", cf, ( 7547.34, -3100.11, 740 ), ( 0, 320, 0 ), "mysteryprop_2_scriptable_struct", "PROP_HUNT_TENNIS", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_prop_hunt_cs";
    s.groupid = "prop_1";
    s.name = "mysteryprop_1_scriptable_struct";
    fe [[ f ]]( s, "PROP_HUNT_TENNIS", cf, ( 7807.85, -2001.08, 724 ), ( 0, 230, 0 ), "mysteryprop_1_scriptable_struct", "PROP_HUNT_TENNIS", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_prop_hunt_cs";
    s.groupid = "prop_2";
    s.name = "mysteryprop_2_chest_struct";
    fe [[ f ]]( s, "PROP_HUNT_TENNIS", cf, ( 7564.2, -3116.59, 740 ), ( 0, 230.4, 0 ), "mysteryprop_2_chest_struct", "PROP_HUNT_TENNIS", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_prop_hunt_cs";
    s.groupid = "prop_3";
    s.name = "mysteryprop_3_enemy_struct";
    fe [[ f ]]( s, "PROP_HUNT_TENNIS", cf, ( 7882.09, -2444.53, 724 ), ( 0, 231.2, 0 ), "mysteryprop_3_enemy_struct", "PROP_HUNT_TENNIS", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_prop_hunt_cs";
    s.groupid = "prop_3";
    s.name = "mysteryprop_3_chest_struct";
    fe [[ f ]]( s, "PROP_HUNT_TENNIS", cf, ( 7882.09, -2444.53, 724 ), ( 0, 231.2, 0 ), "mysteryprop_3_chest_struct", "PROP_HUNT_TENNIS", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_sat_avalon_city_ob_activity_prop_hunt_cs
// Params 0
// Checksum 0x28dfc1b, Offset: 0x118a
// Size: 0x1b7
function function_d9dd7965c51c95d1()
{
    activityinstances = [];
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_ob_activitydefinition_prop_hunt_city_art_gallery";
    var_881289d7987bc770.cf = "mp_sat_avalon_city_ob_activity_prop_hunt_cs";
    var_881289d7987bc770.scriptstructorigin = ( -14650.5, -7640.54, 1056 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [ ( -14658.2, -7656.75, 1056 ) ];
    var_881289d7987bc770.var_31ce4477e3543d24 = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.locationradius = [ 1500 ];
    activityinstances[ "PROP_HUNT_ART_GALLERY" ] = var_881289d7987bc770;
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_ob_activitydefinition_prop_hunt_city_tennis";
    var_881289d7987bc770.cf = "mp_sat_avalon_city_ob_activity_prop_hunt_cs";
    var_881289d7987bc770.scriptstructorigin = ( 7830.09, -2471.81, 557.11 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [ ( 7859.17, -2426.77, 733.03 ) ];
    var_881289d7987bc770.var_31ce4477e3543d24 = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.locationradius = [ 1500 ];
    activityinstances[ "PROP_HUNT_TENNIS" ] = var_881289d7987bc770;
    return activityinstances;
}

