// script_9463b32712680d6  (hash_09463b32712680d6.gscc) (size: 9780 Bytes / 0x2634 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x25b928aa (632891562)
// size ...... 9780 (0x2634)
// includes .. 4   (offset: 0x2160)
// strings ... 31  (offset: 0x2180)
// dev strs .. 0   (offset: 0x2634)
// exports ... 15  (offset: 0x1bec)
// cseg ...... 0x305 + 0x18e7 (0x1bec)
// imports ... 28  (offset: 0x1e44)
// animtree1 . 0   (offset: 0x2634)
// animtree2 . 0   (offset: 0x2634)
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace mp_sat_avalon_q4_ob_contract_precious_cargo_cs;

// Namespace mp_sat_avalon_q4_ob_contract_precious_cargo_cs
// Params 0, eflags: 0x5
// Checksum 0x4949a685, Offset: 0x323
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"mp_sat_avalon_q4_ob_contract_precious_cargo_cs", #"activity_common", &function_b39ecd3d51489472, undefined );
}

// Namespace mp_sat_avalon_q4_ob_contract_precious_cargo_cs
// Params 0, eflags: 0x4
// Checksum 0x6a3b42bd, Offset: 0x34c
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace mp_sat_avalon_q4_ob_contract_precious_cargo_cs
// Params 0, eflags: 0x4
// Checksum 0xef009151, Offset: 0x35d
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace mp_sat_avalon_q4_ob_contract_precious_cargo_cs
// Params 2
// Checksum 0x812d0f7d, Offset: 0x36e
// Size: 0x8c
function main( unused, unused2 )
{
    if ( utility::flag_exist( "mp_sat_avalon_q4_ob_contract_precious_cargo_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "mp_sat_avalon_q4_ob_contract_precious_cargo_cs" ) )
    {
        return;
    }
    
    activity_common::function_e1df676808c1d1e3( &function_4cd78e661617f3 );
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "mp_sat_avalon_q4_ob_contract_precious_cargo_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "mp_sat_avalon_q4_ob_contract_precious_cargo_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace mp_sat_avalon_q4_ob_contract_precious_cargo_cs
// Params 3, eflags: 0x4
// Checksum 0x6c82259e, Offset: 0x402
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "mp_sat_avalon_q4_ob_contract_precious_cargo_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "mp_sat_avalon_q4_ob_contract_precious_cargo_cs" );
}

// Namespace mp_sat_avalon_q4_ob_contract_precious_cargo_cs
// Params 3, eflags: 0x4
// Checksum 0x2d0376a2, Offset: 0x47c
// Size: 0x139e
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_precious_cargo_cs";
    s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
    s.groupid = "heli_silos";
    s.script_unload = "default";
    s.spawngroup = "heli_test_guys";
    fe [[ f ]]( s, us, cf, ( 39488.4, -8901.98, 5235 ), ( 0, 316.42, 0 ), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_precious_cargo_cs";
    fe [[ f ]]( s, "PRECIOUS_CARGO_Q4_SILOS", cf, ( 58749.5, -20884.5, 2437.52 ), ( 0.18, 32.27, 1.84 ), "activity_nexus_instance_joiner", undefined, "PRECIOUS_CARGO_Q4_SILOS", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_precious_cargo_cs";
    s.activity_bundle = "sat_activitydefinition_precious_cargo";
    s.name = "PRECIOUS_CARGO_Q4_SILOS";
    s.var_265c4f33e2a6daa7 = "1";
    fe [[ f ]]( s, "PRECIOUS_CARGO_Q4_SILOS", cf, ( 48119.6, -5935.46, 328.69 ), ( 0, 89.97, 0 ), "activity_nexus_variant", "PRECIOUS_CARGO_Q4_SILOS", undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_precious_cargo_cs";
    fe [[ f ]]( s, "PRECIOUS_CARGO_Q4_SILOS", cf, ( 59284.2, -22774.9, 2479.99 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "OB_Spacer_Spatial_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 50 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_precious_cargo_cs";
    s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
    s.groupid = "heli_silos";
    s.script_unload = "default";
    s.spawngroup = "heli_test_guys";
    fe [[ f ]]( s, us, cf, ( 45952.4, -12134, 5235 ), ( 0, 37.85, 0 ), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_precious_cargo_cs";
    s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
    s.groupid = "heli_silos";
    s.script_unload = "default";
    s.spawngroup = "heli_test_guys";
    fe [[ f ]]( s, us, cf, ( 52048.9, -11491.5, 5235 ), ( 0, 37.85, 0 ), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_precious_cargo_cs";
    s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
    s.groupid = "heli_silos";
    s.script_unload = "default";
    s.spawngroup = "heli_test_guys";
    fe [[ f ]]( s, us, cf, ( 53646.4, -6386.5, 5235 ), ( 0, 121.84, 0 ), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_precious_cargo_cs";
    s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
    s.groupid = "heli_silos";
    s.script_unload = "default";
    s.spawngroup = "heli_test_guys";
    fe [[ f ]]( s, us, cf, ( 54105.4, -896, 5235 ), ( 0, 121.84, 0 ), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_precious_cargo_cs";
    s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
    s.groupid = "heli_silos";
    s.script_unload = "default";
    s.spawngroup = "heli_test_guys";
    fe [[ f ]]( s, us, cf, ( 50891.9, 4558, 5235 ), ( 0, 121.84, 0 ), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_precious_cargo_cs";
    s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
    s.groupid = "heli_silos";
    s.script_unload = "default";
    s.spawngroup = "heli_test_guys";
    fe [[ f ]]( s, us, cf, ( 44978.9, 6137.5, 5235 ), ( 0, 205.49, 0 ), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_precious_cargo_cs";
    s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
    s.groupid = "heli_silos";
    s.script_unload = "default";
    s.spawngroup = "heli_test_guys";
    fe [[ f ]]( s, us, cf, ( 36458.4, 4062.5, 5235 ), ( 0, 324, 0 ), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_precious_cargo_cs";
    s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
    s.groupid = "heli_silos";
    s.script_unload = "default";
    s.spawngroup = "heli_test_guys";
    fe [[ f ]]( s, us, cf, ( 36825.9, -2475, 5235 ), ( 0, 324, 0 ), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_precious_cargo_cs";
    s.groupid = "end_point02";
    s.name = "end_point";
    fe [[ f ]]( s, us, cf, ( 27578.1, -47040.7, 207.23 ), ( 0, 317.18, 0 ), "precious_cargo_end", undefined, undefined, undefined, undefined, undefined, undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_precious_cargo_cs";
    s.groupid = "end_point03";
    s.name = "end_point";
    fe [[ f ]]( s, us, cf, ( 35275.2, -39140.8, 1087 ), ( 0, 86.75, 0 ), "precious_cargo_end", undefined, undefined, undefined, undefined, undefined, undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_precious_cargo_cs";
    s.groupid = "end_point04";
    s.name = "end_point";
    fe [[ f ]]( s, us, cf, ( 41457.9, -25156.5, 321.17 ), ( 0, 153.68, 0 ), "precious_cargo_end", undefined, undefined, undefined, undefined, undefined, undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_precious_cargo_cs";
    s.groupid = "end_point05";
    s.name = "end_point";
    fe [[ f ]]( s, us, cf, ( 22930.8, -23010.7, 378.14 ), ( 0, 239.41, 0 ), "precious_cargo_end", undefined, undefined, undefined, undefined, undefined, undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_precious_cargo_cs";
    s.groupid = "end_point06";
    s.name = "end_point";
    fe [[ f ]]( s, us, cf, ( 31059.9, -19360.9, 240 ), ( 0, 148.38, 0 ), "precious_cargo_end", undefined, undefined, undefined, undefined, undefined, undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_precious_cargo_cs";
    s.groupid = "end_point07";
    s.name = "end_point";
    fe [[ f ]]( s, us, cf, ( 52110.5, -41653, 2052.86 ), ( 0, 41.59, 0 ), "precious_cargo_end", undefined, undefined, undefined, undefined, undefined, undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_precious_cargo_cs";
    s.groupid = "end_point08";
    s.name = "end_point";
    fe [[ f ]]( s, us, cf, ( 48192.7, -52170.3, 489.62 ), ( 0, 176.66, 0 ), "precious_cargo_end", undefined, undefined, undefined, undefined, undefined, undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_precious_cargo_cs";
    s.groupid = "end_point09";
    s.name = "end_point";
    fe [[ f ]]( s, us, cf, ( 53033.4, -53520.5, 867.62 ), ( 0, 228.59, 0 ), "precious_cargo_end", undefined, undefined, undefined, undefined, undefined, undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_precious_cargo_cs";
    s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
    s.groupid = "heli_mountain_range";
    s.script_unload = "default";
    s.spawngroup = "heli_test_guys";
    fe [[ f ]]( s, us, cf, ( 14773.4, -35952.7, 10651.6 ), ( 0, 316.42, 0 ), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_precious_cargo_cs";
    fe [[ f ]]( s, "PRECIOUS_CARGO_Q4_MOUNTAIN_RANGE", cf, ( -1197.19, -39482.8, 916 ), ( 359.95, 14.78, 0.32 ), "activity_nexus_instance_joiner", undefined, "PRECIOUS_CARGO_Q4_MOUNTAIN_RANGE", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_precious_cargo_cs";
    s.activity_bundle = "sat_activitydefinition_precious_cargo";
    s.name = "PRECIOUS_CARGO_Q4_MOUNTAIN_RANGE";
    s.var_265c4f33e2a6daa7 = "1";
    fe [[ f ]]( s, "PRECIOUS_CARGO_Q4_MOUNTAIN_RANGE", cf, ( 21843.6, -16793.6, 617.77 ), ( 0, 118.55, 0 ), "activity_nexus_variant", "PRECIOUS_CARGO_Q4_MOUNTAIN_RANGE", undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_precious_cargo_cs";
    fe [[ f ]]( s, "PRECIOUS_CARGO_Q4_MOUNTAIN_RANGE", cf, ( 22255.2, -16590.8, 590.35 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "OB_Spacer_Spatial_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 50 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_precious_cargo_cs";
    s.activity_bundle = "sat_activitydefinition_precious_cargo";
    s.name = "PRECIOUS_CARGO_Q4_SHIP_YARD";
    s.var_265c4f33e2a6daa7 = "1";
    fe [[ f ]]( s, "PRECIOUS_CARGO_Q4_SHIP_YARD", cf, ( 27297.5, -47547.2, 206.33 ), ( 0, 118.55, 0 ), "activity_nexus_variant", "PRECIOUS_CARGO_Q4_SHIP_YARD", undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_precious_cargo_cs";
    fe [[ f ]]( s, "PRECIOUS_CARGO_Q4_SHIP_YARD", cf, ( 41169.8, -8889.08, 313.56 ), ( 358.15, 271.72, -2.41 ), "activity_nexus_instance_joiner", undefined, "PRECIOUS_CARGO_Q4_SHIP_YARD", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_precious_cargo_cs";
    fe [[ f ]]( s, "PRECIOUS_CARGO_Q4_SHIP_YARD", cf, ( 27057.9, -47224.2, 207.67 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "OB_Spacer_Spatial_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 50 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_precious_cargo_cs";
    s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
    s.groupid = "heli_ship_yard";
    s.script_unload = "default";
    s.spawngroup = "heli_test_guys";
    fe [[ f ]]( s, us, cf, ( 35454, -50505.7, 7359.71 ), ( 0, 316.42, 0 ), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_precious_cargo_cs";
    s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
    s.groupid = "heli_mountain_range";
    s.script_unload = "default";
    s.spawngroup = "heli_test_guys";
    fe [[ f ]]( s, us, cf, ( 22108, -31903.4, 9260.3 ), ( 0, 316.42, 0 ), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_precious_cargo_cs";
    s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
    s.groupid = "heli_mountain_range";
    s.script_unload = "default";
    s.spawngroup = "heli_test_guys";
    fe [[ f ]]( s, us, cf, ( 20125.2, -22615.2, 9539.54 ), ( 0, 316.42, 0 ), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_precious_cargo_cs";
    s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
    s.groupid = "heli_mountain_range";
    s.script_unload = "default";
    s.spawngroup = "heli_test_guys";
    fe [[ f ]]( s, us, cf, ( 23265.4, -15360.4, 9276.71 ), ( 0, 316.42, 0 ), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_precious_cargo_cs";
    s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
    s.groupid = "heli_mountain_range";
    s.script_unload = "default";
    s.spawngroup = "heli_test_guys";
    fe [[ f ]]( s, us, cf, ( 9955.66, -18638.6, 10346.3 ), ( 0, 316.42, 0 ), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_precious_cargo_cs";
    s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
    s.groupid = "heli_mountain_range";
    s.script_unload = "default";
    s.spawngroup = "heli_test_guys";
    fe [[ f ]]( s, us, cf, ( 5567.37, -25247.1, 10075.2 ), ( 0, 316.42, 0 ), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_precious_cargo_cs";
    s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
    s.groupid = "heli_mountain_range";
    s.script_unload = "default";
    s.spawngroup = "heli_test_guys";
    fe [[ f ]]( s, us, cf, ( 3356.87, -32236.3, 10079.5 ), ( 0, 316.42, 0 ), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_precious_cargo_cs";
    s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
    s.groupid = "heli_mountain_range";
    s.script_unload = "default";
    s.spawngroup = "heli_test_guys";
    fe [[ f ]]( s, us, cf, ( 3448.75, -38524.6, 9803.36 ), ( 0, 316.42, 0 ), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_precious_cargo_cs";
    s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
    s.groupid = "heli_mountain_range";
    s.script_unload = "default";
    s.spawngroup = "heli_test_guys";
    fe [[ f ]]( s, us, cf, ( 8826.03, -44355.1, 10115.9 ), ( 0, 316.42, 0 ), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_precious_cargo_cs";
    s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
    s.groupid = "heli_ship_yard";
    s.script_unload = "default";
    s.spawngroup = "heli_test_guys";
    fe [[ f ]]( s, us, cf, ( 27913.3, -44470.3, 7329.66 ), ( 0, 316.42, 0 ), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_precious_cargo_cs";
    s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
    s.groupid = "heli_ship_yard";
    s.script_unload = "default";
    s.spawngroup = "heli_test_guys";
    fe [[ f ]]( s, us, cf, ( 26877.6, -52291.1, 7384.06 ), ( 0, 316.42, 0 ), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_precious_cargo_cs";
    s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
    s.groupid = "heli_ship_yard";
    s.script_unload = "default";
    s.spawngroup = "heli_test_guys";
    fe [[ f ]]( s, us, cf, ( 21435.7, -54931.8, 7423.04 ), ( 0, 316.42, 0 ), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45 );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace mp_sat_avalon_q4_ob_contract_precious_cargo_cs
// Params 0, eflags: 0x4
// Checksum 0x96a9bb30, Offset: 0x1822
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace mp_sat_avalon_q4_ob_contract_precious_cargo_cs
// Params 0
// Checksum 0xaed1f8d3, Offset: 0x182c
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "mp_sat_avalon_q4_ob_contract_precious_cargo_cs" );
}

// Namespace mp_sat_avalon_q4_ob_contract_precious_cargo_cs
// Params 0
// Checksum 0x292ffb49, Offset: 0x1842
// Size: 0x66
function function_4cd78e661617f3()
{
    activityinfostruct = {};
    activityinfostruct.name = "REV_OB_CONTRACT_PRECIOUS_CARGO";
    activityinfostruct.scriptbundle = "sat_activitydefinition_precious_cargo";
    activityinfostruct.mainfunction = &main;
    activityinfostruct.var_934f068483ae4ddb = &function_d4323822d7042e5a;
    activityinfostruct.metadatafunction = &function_d9dd7965c51c95d1;
    return activityinfostruct;
}

// Namespace mp_sat_avalon_q4_ob_contract_precious_cargo_cs
// Params 4
// Checksum 0xdc379952, Offset: 0x18b1
// Size: 0x8b
function function_d4323822d7042e5a( var_4312b79c960726b6, fe, us, cf = "mp_sat_avalon_q4_ob_contract_precious_cargo_cs" )
{
    switch ( var_4312b79c960726b6 )
    {
        case #"hash_3e05496715ebb525":
            function_fc5bab7785da745d( fe, us, cf );
            break;
        case #"hash_7b5224f202d052d8":
            function_7c8abb3d4ef1ee40( fe, us, cf );
            break;
        case #"hash_e02109282d32b5c4":
            function_c7e1594a9a8fa52c( fe, us, cf );
            break;
    }
}

// Namespace mp_sat_avalon_q4_ob_contract_precious_cargo_cs
// Params 3
// Checksum 0xeb12f6f5, Offset: 0x1944
// Size: 0x2f
function function_fc5bab7785da745d( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
}

// Namespace mp_sat_avalon_q4_ob_contract_precious_cargo_cs
// Params 3
// Checksum 0x1de68e80, Offset: 0x197b
// Size: 0x2f
function function_7c8abb3d4ef1ee40( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
}

// Namespace mp_sat_avalon_q4_ob_contract_precious_cargo_cs
// Params 3
// Checksum 0x812a2894, Offset: 0x19b2
// Size: 0x2f
function function_c7e1594a9a8fa52c( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
}

// Namespace mp_sat_avalon_q4_ob_contract_precious_cargo_cs
// Params 0
// Checksum 0x6cbf04a, Offset: 0x19e9
// Size: 0x202
function function_d9dd7965c51c95d1()
{
    activityinstances = [];
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_activitydefinition_precious_cargo";
    var_881289d7987bc770.var_265c4f33e2a6daa7 = 1;
    var_881289d7987bc770.cf = "mp_sat_avalon_q4_ob_contract_precious_cargo_cs";
    var_881289d7987bc770.scriptstructorigin = ( 48119.6, -5935.46, 328.69 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [];
    var_881289d7987bc770.var_31ce4477e3543d24 = [];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [];
    var_881289d7987bc770.locationradius = [];
    activityinstances[ "PRECIOUS_CARGO_Q4_SILOS" ] = var_881289d7987bc770;
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_activitydefinition_precious_cargo";
    var_881289d7987bc770.var_265c4f33e2a6daa7 = 1;
    var_881289d7987bc770.cf = "mp_sat_avalon_q4_ob_contract_precious_cargo_cs";
    var_881289d7987bc770.scriptstructorigin = ( 21843.6, -16793.6, 617.77 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [];
    var_881289d7987bc770.var_31ce4477e3543d24 = [];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [];
    var_881289d7987bc770.locationradius = [];
    activityinstances[ "PRECIOUS_CARGO_Q4_MOUNTAIN_RANGE" ] = var_881289d7987bc770;
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_activitydefinition_precious_cargo";
    var_881289d7987bc770.var_265c4f33e2a6daa7 = 1;
    var_881289d7987bc770.cf = "mp_sat_avalon_q4_ob_contract_precious_cargo_cs";
    var_881289d7987bc770.scriptstructorigin = ( 27297.5, -47547.2, 206.33 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [];
    var_881289d7987bc770.var_31ce4477e3543d24 = [];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [];
    var_881289d7987bc770.locationradius = [];
    activityinstances[ "PRECIOUS_CARGO_Q4_SHIP_YARD" ] = var_881289d7987bc770;
    return activityinstances;
}

