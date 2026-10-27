// script_440bdbc78413bb9b  (hash_440bdbc78413bb9b.gscc) (size: 6691 Bytes / 0x1a23 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x66dfdbd0 (1725946832)
// size ...... 6691 (0x1a23)
// includes .. 4   (offset: 0x1723)
// strings ... 24  (offset: 0x1743)
// dev strs .. 0   (offset: 0x1a23)
// exports ... 14  (offset: 0x1213)
// cseg ...... 0x2fb + 0xf18 (0x1213)
// imports ... 26  (offset: 0x1443)
// animtree1 . 0   (offset: 0x1a23)
// animtree2 . 0   (offset: 0x1a23)
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace mp_sat_avalon_q2_ob_activity_prop_hunt_cs;

// Namespace mp_sat_avalon_q2_ob_activity_prop_hunt_cs
// Params 0, eflags: 0x5
// Checksum 0xc5c71804, Offset: 0x319
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"mp_sat_avalon_q2_ob_activity_prop_hunt_cs", #"activity_common", &function_b39ecd3d51489472, undefined );
}

// Namespace mp_sat_avalon_q2_ob_activity_prop_hunt_cs
// Params 0, eflags: 0x4
// Checksum 0x1ec5336f, Offset: 0x342
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace mp_sat_avalon_q2_ob_activity_prop_hunt_cs
// Params 0, eflags: 0x4
// Checksum 0x801c5c59, Offset: 0x353
// Size: 0x15
function private structs_init()
{
    main();
    activity_common::function_e1df676808c1d1e3( &function_4cd78e661617f3 );
}

// Namespace mp_sat_avalon_q2_ob_activity_prop_hunt_cs
// Params 2
// Checksum 0x8008daec, Offset: 0x370
// Size: 0x70
function main( unused, unused2 )
{
    if ( utility::flag_exist( "mp_sat_avalon_q2_ob_activity_prop_hunt_cs" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "mp_sat_avalon_q2_ob_activity_prop_hunt_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "mp_sat_avalon_q2_ob_activity_prop_hunt_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace mp_sat_avalon_q2_ob_activity_prop_hunt_cs
// Params 3, eflags: 0x4
// Checksum 0x187c544c, Offset: 0x3e8
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "mp_sat_avalon_q2_ob_activity_prop_hunt_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "mp_sat_avalon_q2_ob_activity_prop_hunt_cs" );
}

// Namespace mp_sat_avalon_q2_ob_activity_prop_hunt_cs
// Params 3, eflags: 0x4
// Checksum 0xc016335b, Offset: 0x462
// Size: 0x22c
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_prop_hunt_cs";
    s.activity_bundle = "sat_ob_activitydefinition_prop_hunt_q2_bedroom";
    s.name = "PROP_HUNT_BEDROOM";
    fe [[ f ]]( s, "PROP_HUNT_BEDROOM", cf, ( 3579.25, 50987.1, 682 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_prop_hunt_cs";
    fe [[ f ]]( s, "PROP_HUNT_BEDROOM", cf, ( 3567.25, 50972.8, 684.23 ), ( 0, 0, 0 ), "activity_nexus_instance_joiner", "PROP_HUNT_BEDROOM", "PROP_HUNT_BEDROOM", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_prop_hunt_cs";
    s.activity_bundle = "sat_ob_activitydefinition_prop_hunt_q2_gas_station";
    s.name = "PROP_HUNT_GAS_STATION";
    fe [[ f ]]( s, "PROP_HUNT_GAS_STATION", cf, ( 21867.6, 23123.5, 655.89 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_prop_hunt_cs";
    fe [[ f ]]( s, "PROP_HUNT_GAS_STATION", cf, ( 21858.1, 23137.1, 639.78 ), ( 0, 0, 0 ), "activity_nexus_instance_joiner", "PROP_HUNT_GAS_STATION", "PROP_HUNT_GAS_STATION", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace mp_sat_avalon_q2_ob_activity_prop_hunt_cs
// Params 0, eflags: 0x4
// Checksum 0x2771be5d, Offset: 0x696
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace mp_sat_avalon_q2_ob_activity_prop_hunt_cs
// Params 0
// Checksum 0xda2f8901, Offset: 0x6a0
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "mp_sat_avalon_q2_ob_activity_prop_hunt_cs" );
}

// Namespace mp_sat_avalon_q2_ob_activity_prop_hunt_cs
// Params 0
// Checksum 0x9c1755d6, Offset: 0x6b6
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

// Namespace mp_sat_avalon_q2_ob_activity_prop_hunt_cs
// Params 4
// Checksum 0x3975fac5, Offset: 0x725
// Size: 0x71
function function_d4323822d7042e5a( var_4312b79c960726b6, fe, us, cf = "mp_sat_avalon_q2_ob_activity_prop_hunt_cs" )
{
    switch ( var_4312b79c960726b6 )
    {
        case #"hash_edf6f64f4e9ab1b3":
            function_df3b1d57c1adb2bb( fe, us, cf );
            break;
        case #"hash_9ec1ff9dd5db24f9":
            function_8d3c4b5afeb19eb1( fe, us, cf );
            break;
    }
}

// Namespace mp_sat_avalon_q2_ob_activity_prop_hunt_cs
// Params 3
// Checksum 0x1e393de8, Offset: 0x79e
// Size: 0x3c9
function function_df3b1d57c1adb2bb( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_prop_hunt_cs";
    s.name = "mysteryprop_1_scriptable_struct";
    fe [[ f ]]( s, "PROP_HUNT_BEDROOM", cf, ( 3533.95, 50896.1, 700.87 ), ( 0, 0, 0 ), "mysteryprop_1_scriptable_struct", "PROP_HUNT_BEDROOM", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_prop_hunt_cs";
    s.groupid = "prop_2";
    s.name = "mysteryprop_2_scriptable_struct";
    fe [[ f ]]( s, "PROP_HUNT_BEDROOM", cf, ( 3640.14, 50980.9, 700.42 ), ( 0, 175, 0 ), "mysteryprop_2_scriptable_struct", "PROP_HUNT_BEDROOM", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_prop_hunt_cs";
    s.groupid = "prop_3";
    s.name = "mysteryprop_3_scriptable_struct";
    fe [[ f ]]( s, "PROP_HUNT_BEDROOM", cf, ( 3753.32, 50962.7, 682 ), ( 0, 175, 0 ), "mysteryprop_3_scriptable_struct", "PROP_HUNT_BEDROOM", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_prop_hunt_cs";
    s.groupid = "prop_2";
    s.name = "mysteryprop_2_enemy_struct";
    fe [[ f ]]( s, "PROP_HUNT_BEDROOM", cf, ( 3636.34, 50977.6, 699.9 ), ( 0, 356.7, 0 ), "mysteryprop_2_enemy_struct", "PROP_HUNT_GAS_STATION", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_prop_hunt_cs";
    s.groupid = "prop_2";
    s.name = "mysteryprop_2_chest_struct";
    fe [[ f ]]( s, "PROP_HUNT_BEDROOM", cf, ( 3636.34, 50977.6, 699.9 ), ( 0, 356.69, 0 ), "mysteryprop_2_chest_struct", "PROP_HUNT_GAS_STATION", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_prop_hunt_cs";
    s.groupid = "prop_3";
    s.name = "mysteryprop_3_enemy_struct";
    fe [[ f ]]( s, "PROP_HUNT_BEDROOM", cf, ( 3734.58, 50966.1, 682 ), ( 0, 84.69, 0 ), "mysteryprop_3_enemy_struct", "PROP_HUNT_BEDROOM", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_prop_hunt_cs";
    s.groupid = "prop_3";
    s.name = "mysteryprop_3_chest_struct";
    fe [[ f ]]( s, "PROP_HUNT_BEDROOM", cf, ( 3734.58, 50966.1, 682 ), ( 0, 84.69, 0 ), "mysteryprop_3_chest_struct", "PROP_HUNT_BEDROOM", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_sat_avalon_q2_ob_activity_prop_hunt_cs
// Params 3
// Checksum 0xa04e5fbe, Offset: 0xb6f
// Size: 0x4e4
function function_8d3c4b5afeb19eb1( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_prop_hunt_cs";
    s.groupid = "prop_1";
    s.name = "mysteryprop_1_enemy_struct";
    fe [[ f ]]( s, "PROP_HUNT_GAS_STATION", cf, ( 23102.1, 23429, 712.65 ), ( 0, 99.7, 0 ), "mysteryprop_1_enemy_struct", "PROP_HUNT_GAS_STATION", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_prop_hunt_cs";
    s.groupid = "prop_1";
    s.name = "mysteryprop_1_scriptable_struct";
    fe [[ f ]]( s, "PROP_HUNT_GAS_STATION", cf, ( 23122.3, 23435.4, 713.81 ), ( 0, 189.8, 0 ), "mysteryprop_1_scriptable_struct", "PROP_HUNT_GAS_STATION", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_prop_hunt_cs";
    s.groupid = "prop_1";
    s.name = "mysteryprop_1_chest_struct";
    fe [[ f ]]( s, "PROP_HUNT_GAS_STATION", cf, ( 23102.1, 23429, 712.65 ), ( 0, 99.69, 0 ), "mysteryprop_1_chest_struct", "PROP_HUNT_GAS_STATION", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_prop_hunt_cs";
    s.groupid = "prop_2";
    s.name = "mysteryprop_2_enemy_struct";
    fe [[ f ]]( s, "PROP_HUNT_GAS_STATION", cf, ( 21051.3, 22975.1, 647.89 ), ( 0, 346.7, 0 ), "mysteryprop_2_enemy_struct", "PROP_HUNT_GAS_STATION", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_prop_hunt_cs";
    s.groupid = "prop_2";
    s.name = "mysteryprop_2_scriptable_struct";
    fe [[ f ]]( s, "PROP_HUNT_GAS_STATION", cf, ( 21040.5, 22954.5, 647.89 ), ( 0, 75.8, 0 ), "mysteryprop_2_scriptable_struct", "PROP_HUNT_GAS_STATION", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_prop_hunt_cs";
    s.groupid = "prop_3";
    s.name = "mysteryprop_3_scriptable_struct";
    fe [[ f ]]( s, "PROP_HUNT_GAS_STATION", cf, ( 22560.4, 23178, 647.89 ), ( 0, 160.8, 0 ), "mysteryprop_3_scriptable_struct", "PROP_HUNT_GAS_STATION", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_prop_hunt_cs";
    s.groupid = "prop_2";
    s.name = "mysteryprop_2_chest_struct";
    fe [[ f ]]( s, "PROP_HUNT_GAS_STATION", cf, ( 21051.3, 22975.1, 647.89 ), ( 0, 346.69, 0 ), "mysteryprop_2_chest_struct", "PROP_HUNT_GAS_STATION", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_prop_hunt_cs";
    s.groupid = "prop_3";
    s.name = "mysteryprop_3_enemy_struct";
    fe [[ f ]]( s, "PROP_HUNT_GAS_STATION", cf, ( 22541.7, 23177, 647.89 ), ( 0, 74.69, 0 ), "mysteryprop_3_enemy_struct", "PROP_HUNT_GAS_STATION", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_prop_hunt_cs";
    s.groupid = "prop_3";
    s.name = "mysteryprop_3_chest_struct";
    fe [[ f ]]( s, "PROP_HUNT_GAS_STATION", cf, ( 22541.7, 23177, 647.89 ), ( 0, 74.69, 0 ), "mysteryprop_3_chest_struct", "PROP_HUNT_GAS_STATION", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_sat_avalon_q2_ob_activity_prop_hunt_cs
// Params 0
// Checksum 0x16106105, Offset: 0x105b
// Size: 0x1b7
function function_d9dd7965c51c95d1()
{
    activityinstances = [];
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_ob_activitydefinition_prop_hunt_q2_bedroom";
    var_881289d7987bc770.cf = "mp_sat_avalon_q2_ob_activity_prop_hunt_cs";
    var_881289d7987bc770.scriptstructorigin = ( 3579.25, 50987.1, 682 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [ ( 3583.29, 50968, 682 ) ];
    var_881289d7987bc770.var_31ce4477e3543d24 = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.locationradius = [ 1500 ];
    activityinstances[ "PROP_HUNT_BEDROOM" ] = var_881289d7987bc770;
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_ob_activitydefinition_prop_hunt_q2_gas_station";
    var_881289d7987bc770.cf = "mp_sat_avalon_q2_ob_activity_prop_hunt_cs";
    var_881289d7987bc770.scriptstructorigin = ( 21867.6, 23123.5, 655.89 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [ ( 21833.5, 23139.6, 639.78 ) ];
    var_881289d7987bc770.var_31ce4477e3543d24 = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.locationradius = [ 1500 ];
    activityinstances[ "PROP_HUNT_GAS_STATION" ] = var_881289d7987bc770;
    return activityinstances;
}

