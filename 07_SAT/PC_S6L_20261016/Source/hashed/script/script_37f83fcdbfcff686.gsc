// script_37f83fcdbfcff686  (hash_37f83fcdbfcff686.gscc) (size: 8787 Bytes / 0x2253 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x83eeca65 (2213464677)
// size ...... 8787 (0x2253)
// includes .. 4   (offset: 0x1f57)
// strings ... 27  (offset: 0x1f77)
// dev strs .. 0   (offset: 0x2253)
// exports ... 21  (offset: 0x1833)
// cseg ...... 0x47f + 0x13b4 (0x1833)
// imports ... 34  (offset: 0x1b7b)
// animtree1 . 0   (offset: 0x2253)
// animtree2 . 0   (offset: 0x2253)
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace mp_sat_avalon_q4_ob_activity_suprise_shipment_cs;

// Namespace mp_sat_avalon_q4_ob_activity_suprise_shipment_cs
// Params 0, eflags: 0x5
// Checksum 0xde43d20f, Offset: 0x49d
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"mp_sat_avalon_q4_ob_activity_suprise_shipment_cs", #"activity_common", &function_b39ecd3d51489472, undefined );
}

// Namespace mp_sat_avalon_q4_ob_activity_suprise_shipment_cs
// Params 0, eflags: 0x4
// Checksum 0xa30dff, Offset: 0x4c6
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace mp_sat_avalon_q4_ob_activity_suprise_shipment_cs
// Params 0, eflags: 0x4
// Checksum 0x8598de13, Offset: 0x4d7
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace mp_sat_avalon_q4_ob_activity_suprise_shipment_cs
// Params 2
// Checksum 0xd8a46759, Offset: 0x4e8
// Size: 0x8c
function main( unused, unused2 )
{
    if ( utility::flag_exist( "mp_sat_avalon_q4_ob_activity_suprise_shipment_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "mp_sat_avalon_q4_ob_activity_suprise_shipment_cs" ) )
    {
        return;
    }
    
    activity_common::function_e1df676808c1d1e3( &function_4cd78e661617f3 );
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "mp_sat_avalon_q4_ob_activity_suprise_shipment_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "mp_sat_avalon_q4_ob_activity_suprise_shipment_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace mp_sat_avalon_q4_ob_activity_suprise_shipment_cs
// Params 3, eflags: 0x4
// Checksum 0x61a6adc, Offset: 0x57c
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "mp_sat_avalon_q4_ob_activity_suprise_shipment_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "mp_sat_avalon_q4_ob_activity_suprise_shipment_cs" );
}

// Namespace mp_sat_avalon_q4_ob_activity_suprise_shipment_cs
// Params 3, eflags: 0x4
// Checksum 0xe388699, Offset: 0x5f6
// Size: 0x4f9
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_suprise_shipment_cs";
    s.activity_bundle = "sat_ob_activitydefinition_surprise_shipment_whitebox";
    s.name = "SURPRISE_SHIPMENT_MC_BOAT_REFUEL_STATION";
    fe [[ f ]]( s, "SURPRISE_SHIPMENT_MC_BOAT_REFUEL_STATION", cf, ( 210, 1076, 0 ), ( 0, 90, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 28746, -37488, 241.21 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_suprise_shipment_cs";
    s.activity_bundle = "sat_ob_activitydefinition_surprise_shipment_whitebox";
    s.name = "SURPRISE_SHIPMENT_CAR_FACTORY";
    fe [[ f ]]( s, "SURPRISE_SHIPMENT_CAR_FACTORY", cf, ( 53842, -42554, 2052.85 ), ( 0, 90, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_suprise_shipment_cs";
    s.activity_bundle = "sat_ob_activitydefinition_surprise_shipment_whitebox";
    s.name = "SURPRISE_SHIPMENT_VIGNETTE_SHEDS";
    fe [[ f ]]( s, "SURPRISE_SHIPMENT_VIGNETTE_SHEDS", cf, ( 52950, -53410, 861.09 ), ( 0, 90, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_suprise_shipment_cs";
    s.activity_bundle = "sat_ob_activitydefinition_surprise_shipment_whitebox";
    s.name = "SURPRISE_SHIPMENT_CHOP_SHOP";
    fe [[ f ]]( s, "SURPRISE_SHIPMENT_CHOP_SHOP", cf, ( 9901, -49600, 1212.04 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_suprise_shipment_cs";
    s.activity_bundle = "sat_ob_activitydefinition_surprise_shipment_whitebox";
    s.name = "SURPRISE_SHIPMENT_SHIPYARD_GROUND";
    fe [[ f ]]( s, "SURPRISE_SHIPMENT_SHIPYARD_GROUND", cf, ( 35741, -50955, 41.11 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_suprise_shipment_cs";
    s.activity_bundle = "sat_ob_activitydefinition_surprise_shipment_whitebox";
    s.name = "SURPRISE_SHIPMENT_CAR_FACTORY_NORTH";
    fe [[ f ]]( s, "SURPRISE_SHIPMENT_CAR_FACTORY_NORTH", cf, ( 51224, -30146, 2465.41 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_suprise_shipment_cs";
    s.activity_bundle = "sat_ob_activitydefinition_surprise_shipment_whitebox";
    s.name = "SURPRISE_SHIPMENT_WATER_TREATMENT";
    fe [[ f ]]( s, "SURPRISE_SHIPMENT_WATER_TREATMENT", cf, ( 44565, -16888, 637.72 ), ( 0, 90, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_suprise_shipment_cs";
    s.activity_bundle = "sat_ob_activitydefinition_surprise_shipment_whitebox";
    s.name = "SURPRISE_SHIPMENT_GAS_STATION_NORTH";
    fe [[ f ]]( s, "SURPRISE_SHIPMENT_GAS_STATION_NORTH", cf, ( 6836, -14058, 1666 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_suprise_shipment_cs";
    s.activity_bundle = "sat_ob_activitydefinition_surprise_shipment_whitebox";
    s.name = "SURPRISE_SHIPMENT_SC_BRIDGE_BUILDINGS";
    fe [[ f ]]( s, "SURPRISE_SHIPMENT_SC_BRIDGE_BUILDINGS", cf, ( 0, 0, 0 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 19158, -37884, 448.99 ), ( 0, 0, 0 ) );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace mp_sat_avalon_q4_ob_activity_suprise_shipment_cs
// Params 0, eflags: 0x4
// Checksum 0xcf20d314, Offset: 0xaf7
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace mp_sat_avalon_q4_ob_activity_suprise_shipment_cs
// Params 0
// Checksum 0xc449b791, Offset: 0xb01
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "mp_sat_avalon_q4_ob_activity_suprise_shipment_cs" );
}

// Namespace mp_sat_avalon_q4_ob_activity_suprise_shipment_cs
// Params 0
// Checksum 0x493198ab, Offset: 0xb17
// Size: 0x66
function function_4cd78e661617f3()
{
    activityinfostruct = {};
    activityinfostruct.name = "REV_OB_SURPRISE_SHIPMENT";
    activityinfostruct.scriptbundle = "sat_ob_activitydefinition_surprise_shipment";
    activityinfostruct.mainfunction = &main;
    activityinfostruct.var_934f068483ae4ddb = &function_d4323822d7042e5a;
    activityinfostruct.metadatafunction = &function_d9dd7965c51c95d1;
    return activityinfostruct;
}

// Namespace mp_sat_avalon_q4_ob_activity_suprise_shipment_cs
// Params 4
// Checksum 0x8b046468, Offset: 0xb86
// Size: 0x127
function function_d4323822d7042e5a( var_4312b79c960726b6, fe, us, cf = "mp_sat_avalon_q4_ob_activity_suprise_shipment_cs" )
{
    switch ( var_4312b79c960726b6 )
    {
        case #"hash_4dc977677d448228":
            function_e5376c38b32f4ca0( fe, us, cf );
            break;
        case #"hash_bfd6ab0919dc279d":
            function_3de074a376db0945( fe, us, cf );
            break;
        case #"hash_bd2c6e3bc798c750":
            function_2005a4e9be73b4b8( fe, us, cf );
            break;
        case #"hash_da32a7472a3adca3":
            function_16e82f239c1d890b( fe, us, cf );
            break;
        case #"hash_46567df67c044cf2":
            function_8e29bd846c0bf56a( fe, us, cf );
            break;
        case #"hash_9e1e7b1c25b74451":
            function_fe89387b65a96dd9( fe, us, cf );
            break;
        case #"hash_2879b6f2efc4b42":
            function_268fd299ba99d54a( fe, us, cf );
            break;
        case #"hash_207ecd02b044d9b8":
            function_560a3969d8afb710( fe, us, cf );
            break;
        case #"hash_2f689b23c12c2e1e":
            function_7cee20513b974686( fe, us, cf );
            break;
    }
}

// Namespace mp_sat_avalon_q4_ob_activity_suprise_shipment_cs
// Params 3
// Checksum 0xc5fbb13a, Offset: 0xcb5
// Size: 0xa7
function function_e5376c38b32f4ca0( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_suprise_shipment_cs";
    s.name = "ability_crate";
    fe [[ f ]]( s, "SURPRISE_SHIPMENT_MC_BOAT_REFUEL_STATION", cf, ( 262.07, 862.86, 10.79 ), ( 0, 0, 0 ), "ability_case_SURPRISE_SHIPMENT_MC_BOAT_REFUEL_STATION", undefined, undefined, undefined, undefined, ( 28746, -37488, 241.21 ), ( 0, 0, 0 ) );
}

// Namespace mp_sat_avalon_q4_ob_activity_suprise_shipment_cs
// Params 3
// Checksum 0xf2413c2a, Offset: 0xd64
// Size: 0xa7
function function_3de074a376db0945( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_suprise_shipment_cs";
    s.name = "ability_crate";
    fe [[ f ]]( s, "SURPRISE_SHIPMENT_CAR_FACTORY", cf, ( 53908.5, -42854.1, 2062.85 ), ( 0, 271.9, 0 ), "ability_case_SURPRISE_SHIPMENT_CAR_FACTORY", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_sat_avalon_q4_ob_activity_suprise_shipment_cs
// Params 3
// Checksum 0x6b01680b, Offset: 0xe13
// Size: 0xa7
function function_2005a4e9be73b4b8( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_suprise_shipment_cs";
    s.name = "ability_crate";
    fe [[ f ]]( s, "SURPRISE_SHIPMENT_VIGNETTE_SHEDS", cf, ( 52619.3, -53366.9, 863.99 ), ( 0.27, 213.47, -2.05 ), "ability_case_SURPRISE_SHIPMENT_VIGNETTE_SHEDS", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_sat_avalon_q4_ob_activity_suprise_shipment_cs
// Params 3
// Checksum 0x9f908025, Offset: 0xec2
// Size: 0xa7
function function_16e82f239c1d890b( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_suprise_shipment_cs";
    s.name = "ability_crate";
    fe [[ f ]]( s, "SURPRISE_SHIPMENT_CHOP_SHOP", cf, ( 10189.2, -49358.5, 1204.48 ), ( 0, 299.51, 0 ), "ability_case_SURPRISE_SHIPMENT_CHOP_SHOP", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_sat_avalon_q4_ob_activity_suprise_shipment_cs
// Params 3
// Checksum 0xe16ed448, Offset: 0xf71
// Size: 0xa7
function function_8e29bd846c0bf56a( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_suprise_shipment_cs";
    s.name = "ability_crate";
    fe [[ f ]]( s, "SURPRISE_SHIPMENT_SHIPYARD_GROUND", cf, ( 35781.3, -51161.3, 38.53 ), ( 3.1, 279.56, 0.82 ), "ability_case_SURPRISE_SHIPMENT_SHIPYARD_GROUND", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_sat_avalon_q4_ob_activity_suprise_shipment_cs
// Params 3
// Checksum 0x6bd966c7, Offset: 0x1020
// Size: 0xa7
function function_fe89387b65a96dd9( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_suprise_shipment_cs";
    s.name = "ability_crate";
    fe [[ f ]]( s, "SURPRISE_SHIPMENT_CAR_FACTORY_NORTH", cf, ( 51777.7, -30229.8, 2476.31 ), ( 0, 301.67, 0 ), "ability_case_SURPRISE_SHIPMENT_CAR_FACTORY_NORTH", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_sat_avalon_q4_ob_activity_suprise_shipment_cs
// Params 3
// Checksum 0xfbd7b9af, Offset: 0x10cf
// Size: 0xa7
function function_268fd299ba99d54a( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_suprise_shipment_cs";
    s.name = "ability_crate";
    fe [[ f ]]( s, "SURPRISE_SHIPMENT_WATER_TREATMENT", cf, ( 44756.5, -16826.7, 654.52 ), ( 0, 0, 0 ), "ability_case_SURPRISE_SHIPMENT_WATER_TREATMENT", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_sat_avalon_q4_ob_activity_suprise_shipment_cs
// Params 3
// Checksum 0xf2e64a60, Offset: 0x117e
// Size: 0xa7
function function_560a3969d8afb710( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_suprise_shipment_cs";
    s.name = "ability_crate";
    fe [[ f ]]( s, "SURPRISE_SHIPMENT_GAS_STATION_NORTH", cf, ( 6884.9, -13993.5, 1689.12 ), ( 355.54, 341.22, 4.05 ), "ability_case_SURPRISE_SHIPMENT_GAS_STATION_NORTH", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_sat_avalon_q4_ob_activity_suprise_shipment_cs
// Params 3
// Checksum 0xab55cf19, Offset: 0x122d
// Size: 0xa7
function function_7cee20513b974686( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_suprise_shipment_cs";
    s.name = "ability_crate";
    fe [[ f ]]( s, "SURPRISE_SHIPMENT_SC_BRIDGE_BUILDINGS", cf, ( 36.11, 75.01, 10 ), ( 0, 0, 0 ), "ability_case_SURPRISE_SHIPMENT_SC_BRIDGE_BUILDINGS", undefined, undefined, undefined, undefined, ( 19158, -37884, 448.99 ), ( 0, 0, 0 ) );
}

// Namespace mp_sat_avalon_q4_ob_activity_suprise_shipment_cs
// Params 0
// Checksum 0x37a05491, Offset: 0x12dc
// Size: 0x556
function function_d9dd7965c51c95d1()
{
    activityinstances = [];
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_ob_activitydefinition_surprise_shipment_whitebox";
    var_881289d7987bc770.cf = "mp_sat_avalon_q4_ob_activity_suprise_shipment_cs";
    var_881289d7987bc770.scriptstructorigin = ( 210, 1076, 0 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 28746, -37488, 241.21 );
    var_881289d7987bc770.locationorigin = [];
    var_881289d7987bc770.var_31ce4477e3543d24 = [];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [];
    var_881289d7987bc770.locationradius = [];
    activityinstances[ "SURPRISE_SHIPMENT_MC_BOAT_REFUEL_STATION" ] = var_881289d7987bc770;
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_ob_activitydefinition_surprise_shipment_whitebox";
    var_881289d7987bc770.cf = "mp_sat_avalon_q4_ob_activity_suprise_shipment_cs";
    var_881289d7987bc770.scriptstructorigin = ( 53842, -42554, 2052.85 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [];
    var_881289d7987bc770.var_31ce4477e3543d24 = [];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [];
    var_881289d7987bc770.locationradius = [];
    activityinstances[ "SURPRISE_SHIPMENT_CAR_FACTORY" ] = var_881289d7987bc770;
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_ob_activitydefinition_surprise_shipment_whitebox";
    var_881289d7987bc770.cf = "mp_sat_avalon_q4_ob_activity_suprise_shipment_cs";
    var_881289d7987bc770.scriptstructorigin = ( 52950, -53410, 861.09 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [];
    var_881289d7987bc770.var_31ce4477e3543d24 = [];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [];
    var_881289d7987bc770.locationradius = [];
    activityinstances[ "SURPRISE_SHIPMENT_VIGNETTE_SHEDS" ] = var_881289d7987bc770;
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_ob_activitydefinition_surprise_shipment_whitebox";
    var_881289d7987bc770.cf = "mp_sat_avalon_q4_ob_activity_suprise_shipment_cs";
    var_881289d7987bc770.scriptstructorigin = ( 9901, -49600, 1212.04 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [];
    var_881289d7987bc770.var_31ce4477e3543d24 = [];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [];
    var_881289d7987bc770.locationradius = [];
    activityinstances[ "SURPRISE_SHIPMENT_CHOP_SHOP" ] = var_881289d7987bc770;
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_ob_activitydefinition_surprise_shipment_whitebox";
    var_881289d7987bc770.cf = "mp_sat_avalon_q4_ob_activity_suprise_shipment_cs";
    var_881289d7987bc770.scriptstructorigin = ( 35741, -50955, 41.11 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [];
    var_881289d7987bc770.var_31ce4477e3543d24 = [];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [];
    var_881289d7987bc770.locationradius = [];
    activityinstances[ "SURPRISE_SHIPMENT_SHIPYARD_GROUND" ] = var_881289d7987bc770;
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_ob_activitydefinition_surprise_shipment_whitebox";
    var_881289d7987bc770.cf = "mp_sat_avalon_q4_ob_activity_suprise_shipment_cs";
    var_881289d7987bc770.scriptstructorigin = ( 51224, -30146, 2465.41 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [];
    var_881289d7987bc770.var_31ce4477e3543d24 = [];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [];
    var_881289d7987bc770.locationradius = [];
    activityinstances[ "SURPRISE_SHIPMENT_CAR_FACTORY_NORTH" ] = var_881289d7987bc770;
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_ob_activitydefinition_surprise_shipment_whitebox";
    var_881289d7987bc770.cf = "mp_sat_avalon_q4_ob_activity_suprise_shipment_cs";
    var_881289d7987bc770.scriptstructorigin = ( 44565, -16888, 637.72 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [];
    var_881289d7987bc770.var_31ce4477e3543d24 = [];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [];
    var_881289d7987bc770.locationradius = [];
    activityinstances[ "SURPRISE_SHIPMENT_WATER_TREATMENT" ] = var_881289d7987bc770;
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_ob_activitydefinition_surprise_shipment_whitebox";
    var_881289d7987bc770.cf = "mp_sat_avalon_q4_ob_activity_suprise_shipment_cs";
    var_881289d7987bc770.scriptstructorigin = ( 6836, -14058, 1666 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [];
    var_881289d7987bc770.var_31ce4477e3543d24 = [];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [];
    var_881289d7987bc770.locationradius = [];
    activityinstances[ "SURPRISE_SHIPMENT_GAS_STATION_NORTH" ] = var_881289d7987bc770;
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_ob_activitydefinition_surprise_shipment_whitebox";
    var_881289d7987bc770.cf = "mp_sat_avalon_q4_ob_activity_suprise_shipment_cs";
    var_881289d7987bc770.scriptstructorigin = ( 0, 0, 0 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 19158, -37884, 448.99 );
    var_881289d7987bc770.locationorigin = [];
    var_881289d7987bc770.var_31ce4477e3543d24 = [];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [];
    var_881289d7987bc770.locationradius = [];
    activityinstances[ "SURPRISE_SHIPMENT_SC_BRIDGE_BUILDINGS" ] = var_881289d7987bc770;
    return activityinstances;
}

