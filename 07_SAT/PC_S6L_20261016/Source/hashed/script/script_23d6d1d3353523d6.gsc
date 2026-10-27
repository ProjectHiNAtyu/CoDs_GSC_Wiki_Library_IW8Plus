// script_23d6d1d3353523d6  (hash_23d6d1d3353523d6.gscc) (size: 11458 Bytes / 0x2cc2 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xb451baf1 (3025255153)
// size ...... 11458 (0x2cc2)
// includes .. 4   (offset: 0x270a)
// strings ... 33  (offset: 0x272a)
// dev strs .. 0   (offset: 0x2cc2)
// exports ... 16  (offset: 0x214e)
// cseg ...... 0x342 + 0x1e0c (0x214e)
// imports ... 29  (offset: 0x23ce)
// animtree1 . 0   (offset: 0x2cc2)
// animtree2 . 0   (offset: 0x2cc2)
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace mp_sat_avalon_q2_ob_contract_precious_cargo_cs;

// Namespace mp_sat_avalon_q2_ob_contract_precious_cargo_cs
// Params 0, eflags: 0x5
// Checksum 0x5856c0f, Offset: 0x360
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"mp_sat_avalon_q2_ob_contract_precious_cargo_cs", #"activity_common", &function_b39ecd3d51489472, undefined );
}

// Namespace mp_sat_avalon_q2_ob_contract_precious_cargo_cs
// Params 0, eflags: 0x4
// Checksum 0x5c196259, Offset: 0x389
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace mp_sat_avalon_q2_ob_contract_precious_cargo_cs
// Params 0, eflags: 0x4
// Checksum 0xd922b1b5, Offset: 0x39a
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace mp_sat_avalon_q2_ob_contract_precious_cargo_cs
// Params 2
// Checksum 0x915f5d7f, Offset: 0x3ab
// Size: 0x8c
function main( unused, unused2 )
{
    if ( utility::flag_exist( "mp_sat_avalon_q2_ob_contract_precious_cargo_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "mp_sat_avalon_q2_ob_contract_precious_cargo_cs" ) )
    {
        return;
    }
    
    activity_common::function_e1df676808c1d1e3( &function_4cd78e661617f3 );
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "mp_sat_avalon_q2_ob_contract_precious_cargo_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "mp_sat_avalon_q2_ob_contract_precious_cargo_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace mp_sat_avalon_q2_ob_contract_precious_cargo_cs
// Params 3, eflags: 0x4
// Checksum 0x5aa0057a, Offset: 0x43f
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "mp_sat_avalon_q2_ob_contract_precious_cargo_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "mp_sat_avalon_q2_ob_contract_precious_cargo_cs" );
}

// Namespace mp_sat_avalon_q2_ob_contract_precious_cargo_cs
// Params 3, eflags: 0x4
// Checksum 0xb16b09a4, Offset: 0x4b9
// Size: 0x170f
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_precious_cargo_cs";
    s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
    s.groupid = "heli_clifftown";
    s.script_unload = "default";
    s.spawngroup = "heli_test_guys";
    fe [[ f ]]( s, us, cf, ( 40797.4, 23503.2, 7146.39 ), ( 0, 76.74, 0 ), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_precious_cargo_cs";
    s.activity_bundle = "sat_activitydefinition_precious_cargo";
    s.difficulty_tier = "2";
    s.name = "PRECIOUS_CARGO_CLIFFTOWN";
    fe [[ f ]]( s, "PRECIOUS_CARGO_CLIFFTOWN", cf, ( 36147, 23925.1, 1490.43 ), ( 0, 0, 0 ), "activity_nexus_variant", "PRECIOUS_CARGO_CLIFFTOWN", undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_precious_cargo_cs";
    fe [[ f ]]( s, "PRECIOUS_CARGO_CLIFFTOWN", cf, ( 32351.4, 17035.7, 1193.17 ), ( 0, 156.7, 0 ), "activity_nexus_instance_joiner", undefined, "PRECIOUS_CARGO_CLIFFTOWN", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_precious_cargo_cs";
    fe [[ f ]]( s, "PRECIOUS_CARGO_CLIFFTOWN", cf, ( 36482.3, 24064.2, 1489.92 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "OB_Spacer_Spatial_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 50 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_precious_cargo_cs";
    s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
    s.groupid = "heli_resort";
    s.script_unload = "default";
    s.spawngroup = "heli_test_guys";
    fe [[ f ]]( s, us, cf, ( 6940.47, 34356.1, 5204.58 ), ( 0, 76.74, 0 ), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_precious_cargo_cs";
    s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
    s.groupid = "heli_clifftown";
    s.script_unload = "default";
    s.spawngroup = "heli_test_guys";
    fe [[ f ]]( s, us, cf, ( 33923.3, 32231.7, 7146.39 ), ( 0, 76.74, 0 ), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_precious_cargo_cs";
    s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
    s.groupid = "heli_clifftown";
    s.script_unload = "default";
    s.spawngroup = "heli_test_guys";
    fe [[ f ]]( s, us, cf, ( 45336.4, 36559.2, 7146.39 ), ( 0, 76.74, 0 ), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_precious_cargo_cs";
    s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
    s.groupid = "heli_clifftown";
    s.script_unload = "default";
    s.spawngroup = "heli_test_guys";
    fe [[ f ]]( s, us, cf, ( 54860.1, 20563.4, 7146.39 ), ( 0, 76.74, 0 ), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_precious_cargo_cs";
    s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
    s.groupid = "heli_clifftown";
    s.script_unload = "default";
    s.spawngroup = "heli_test_guys";
    fe [[ f ]]( s, us, cf, ( 44071.2, 15441.3, 7146.39 ), ( 0, 76.74, 0 ), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_precious_cargo_cs";
    s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
    s.groupid = "heli_clifftown";
    s.script_unload = "default";
    s.spawngroup = "heli_test_guys";
    fe [[ f ]]( s, us, cf, ( 38783.3, 10487.2, 7146.39 ), ( 0, 76.74, 0 ), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_precious_cargo_cs";
    s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
    s.groupid = "heli_clifftown";
    s.script_unload = "default";
    s.spawngroup = "heli_test_guys";
    fe [[ f ]]( s, us, cf, ( 30630.5, 4656.27, 7146.39 ), ( 0, 76.74, 0 ), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_precious_cargo_cs";
    s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
    s.groupid = "heli_clifftown";
    s.script_unload = "default";
    s.spawngroup = "heli_test_guys";
    fe [[ f ]]( s, us, cf, ( 28347.3, 13171.5, 7146.39 ), ( 0, 76.74, 0 ), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_precious_cargo_cs";
    s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
    s.groupid = "heli_resort";
    s.script_unload = "default";
    s.spawngroup = "heli_test_guys";
    fe [[ f ]]( s, us, cf, ( 13007.8, 29510.5, 6075.48 ), ( 0, 76.74, 0 ), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_precious_cargo_cs";
    s.activity_bundle = "sat_activitydefinition_precious_cargo";
    s.name = "PRECIOUS_CARGO_Q2_WINERY";
    s.var_265c4f33e2a6daa7 = "1";
    fe [[ f ]]( s, "PRECIOUS_CARGO_Q2_WINERY", cf, ( 21455.1, 44222.2, 937.62 ), ( 0, 265.24, 0 ), "activity_nexus_variant", "PRECIOUS_CARGO_Q2_WINERY", undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_precious_cargo_cs";
    fe [[ f ]]( s, "PRECIOUS_CARGO_Q2_WINERY", cf, ( -310.78, 46816.4, 263.94 ), ( 0, 0.46, 9.1 ), "activity_nexus_instance_joiner", undefined, "PRECIOUS_CARGO_Q2_WINERY", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_precious_cargo_cs";
    fe [[ f ]]( s, "PRECIOUS_CARGO_Q2_WINERY", cf, ( 21480.1, 43977.9, 929.43 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "OB_Spacer_Spatial_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 50 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_precious_cargo_cs";
    s.activity_bundle = "sat_activitydefinition_precious_cargo";
    s.name = "PRECIOUS_CARGO_Q2_HILLSIDE";
    s.var_265c4f33e2a6daa7 = "1";
    fe [[ f ]]( s, "PRECIOUS_CARGO_Q2_HILLSIDE", cf, ( 24428.8, 34096.4, 2617.51 ), ( 0, 271.55, 0 ), "activity_nexus_variant", "PRECIOUS_CARGO_Q2_HILLSIDE", undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_precious_cargo_cs";
    fe [[ f ]]( s, "PRECIOUS_CARGO_Q2_HILLSIDE", cf, ( 25998.9, 43643.4, 1272.04 ), ( 353, 6.8, 0 ), "activity_nexus_instance_joiner", undefined, "PRECIOUS_CARGO_Q2_HILLSIDE", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_precious_cargo_cs";
    fe [[ f ]]( s, "PRECIOUS_CARGO_Q2_HILLSIDE", cf, ( 21480.1, 43977.9, 929.43 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "OB_Spacer_Spatial_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 50 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_precious_cargo_cs";
    s.activity_bundle = "sat_activitydefinition_precious_cargo";
    s.name = "PRECIOUS_CARGO_Q2_RESORT";
    s.var_265c4f33e2a6daa7 = "1";
    fe [[ f ]]( s, "PRECIOUS_CARGO_Q2_RESORT", cf, ( 13315.6, 39721.7, 929.88 ), ( 0, 118.55, 0 ), "activity_nexus_variant", "PRECIOUS_CARGO_Q2_RESORT", undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_precious_cargo_cs";
    fe [[ f ]]( s, "PRECIOUS_CARGO_Q2_RESORT", cf, ( -3733.57, 25342.8, 411.48 ), ( 357.6, 294.59, 0 ), "activity_nexus_instance_joiner", undefined, "PRECIOUS_CARGO_Q2_RESORT", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_precious_cargo_cs";
    fe [[ f ]]( s, "PRECIOUS_CARGO_Q2_RESORT", cf, ( 13104.4, 39910.9, 898.41 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "OB_Spacer_Spatial_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 50 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_precious_cargo_cs";
    s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
    s.groupid = "heli_resort";
    s.script_unload = "default";
    s.spawngroup = "heli_test_guys";
    fe [[ f ]]( s, us, cf, ( 21584.5, 30631.7, 5445.78 ), ( 0, 76.74, 0 ), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_precious_cargo_cs";
    s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
    s.groupid = "heli_resort";
    s.script_unload = "default";
    s.spawngroup = "heli_test_guys";
    fe [[ f ]]( s, us, cf, ( 18771.8, 37785.7, 4160.58 ), ( 0, 76.74, 0 ), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_precious_cargo_cs";
    s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
    s.groupid = "heli_resort";
    s.script_unload = "default";
    s.spawngroup = "heli_test_guys";
    fe [[ f ]]( s, us, cf, ( 11402.8, 38371, 4699.78 ), ( 0, 76.74, 0 ), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_precious_cargo_cs";
    s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
    s.groupid = "heli_winery";
    s.script_unload = "default";
    s.spawngroup = "heli_test_guys";
    fe [[ f ]]( s, us, cf, ( 7861.45, 44740.1, 5235.72 ), ( 0, 76.74, 0 ), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_precious_cargo_cs";
    s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
    s.groupid = "heli_winery";
    s.script_unload = "default";
    s.spawngroup = "heli_test_guys";
    fe [[ f ]]( s, us, cf, ( 15937.1, 43279.4, 5597.66 ), ( 0, 76.74, 0 ), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_precious_cargo_cs";
    s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
    s.groupid = "heli_winery";
    s.script_unload = "default";
    s.spawngroup = "heli_test_guys";
    fe [[ f ]]( s, us, cf, ( 22343.7, 42983.3, 5793.36 ), ( 0, 76.74, 0 ), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_precious_cargo_cs";
    s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
    s.groupid = "heli_winery";
    s.script_unload = "default";
    s.spawngroup = "heli_test_guys";
    fe [[ f ]]( s, us, cf, ( 22348.3, 50490.5, 5665.65 ), ( 0, 76.74, 0 ), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_precious_cargo_cs";
    s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
    s.groupid = "heli_winery";
    s.script_unload = "default";
    s.spawngroup = "heli_test_guys";
    fe [[ f ]]( s, us, cf, ( 18214.5, 53723.1, 5442.5 ), ( 0, 76.74, 0 ), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_precious_cargo_cs";
    s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
    s.groupid = "heli_winery";
    s.script_unload = "default";
    s.spawngroup = "heli_test_guys";
    fe [[ f ]]( s, us, cf, ( 10713.1, 53290.1, 5561.94 ), ( 0, 76.74, 0 ), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_precious_cargo_cs";
    s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
    s.groupid = "heli_winery";
    s.script_unload = "default";
    s.spawngroup = "heli_test_guys";
    fe [[ f ]]( s, us, cf, ( 4640.33, 50142.1, 5259.34 ), ( 0, 76.74, 0 ), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_precious_cargo_cs";
    s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
    s.groupid = "heli_winery";
    s.script_unload = "default";
    s.spawngroup = "heli_test_guys";
    fe [[ f ]]( s, us, cf, ( 9607.09, 48969.4, 5234.8 ), ( 0, 76.74, 0 ), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_precious_cargo_cs";
    s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
    s.groupid = "heli_hillside";
    s.script_unload = "default";
    s.spawngroup = "heli_test_guys";
    fe [[ f ]]( s, us, cf, ( 25061.5, 42477.6, 5871.88 ), ( 0, 76.74, 0 ), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_precious_cargo_cs";
    s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
    s.groupid = "heli_hillside";
    s.script_unload = "default";
    s.spawngroup = "heli_test_guys";
    fe [[ f ]]( s, us, cf, ( 22818.7, 36804.8, 6795.38 ), ( 0, 76.74, 0 ), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_precious_cargo_cs";
    s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
    s.groupid = "heli_hillside";
    s.script_unload = "default";
    s.spawngroup = "heli_test_guys";
    fe [[ f ]]( s, us, cf, ( 28036, 35312.5, 7778.38 ), ( 0, 76.74, 0 ), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_precious_cargo_cs";
    s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
    s.groupid = "heli_hillside";
    s.script_unload = "default";
    s.spawngroup = "heli_test_guys";
    fe [[ f ]]( s, us, cf, ( 32208, 37231.5, 7936.68 ), ( 0, 76.74, 0 ), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_precious_cargo_cs";
    s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
    s.groupid = "heli_hillside";
    s.script_unload = "default";
    s.spawngroup = "heli_test_guys";
    fe [[ f ]]( s, us, cf, ( 36977.8, 38860.3, 7314.38 ), ( 0, 76.74, 0 ), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_precious_cargo_cs";
    s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
    s.groupid = "heli_hillside";
    s.script_unload = "default";
    s.spawngroup = "heli_test_guys";
    fe [[ f ]]( s, us, cf, ( 35798.7, 41990.6, 6503.08 ), ( 0, 76.74, 0 ), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_precious_cargo_cs";
    s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
    s.groupid = "heli_hillside";
    s.script_unload = "default";
    s.spawngroup = "heli_test_guys";
    fe [[ f ]]( s, us, cf, ( 28225.6, 42873.1, 5968.48 ), ( 0, 76.74, 0 ), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_precious_cargo_cs";
    s.groupid = "end_point02";
    s.name = "end_point";
    fe [[ f ]]( s, us, cf, ( 38757.6, 40505.8, 1886.69 ), ( 0, 45.27, 0 ), "precious_cargo_end", undefined, undefined, undefined, undefined, undefined, undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_precious_cargo_cs";
    s.groupid = "end_point04";
    s.name = "end_point";
    fe [[ f ]]( s, us, cf, ( 47427.9, 9931.68, 650.5 ), ( 0, 273.5, 0 ), "precious_cargo_end", undefined, undefined, undefined, undefined, undefined, undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_precious_cargo_cs";
    s.groupid = "end_point05";
    s.name = "end_point";
    fe [[ f ]]( s, us, cf, ( 20103.5, 57483.7, 964.24 ), ( 0, 90.09, 0 ), "precious_cargo_end", undefined, undefined, undefined, undefined, undefined, undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_precious_cargo_cs";
    s.groupid = "end_point03";
    s.name = "end_point";
    fe [[ f ]]( s, us, cf, ( 2879.47, 20472.8, 40 ), ( 0, 328.95, 0 ), "precious_cargo_end", undefined, undefined, undefined, undefined, undefined, undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_precious_cargo_cs";
    s.groupid = "end_point01";
    s.name = "end_point";
    fe [[ f ]]( s, us, cf, ( 21174.5, 21881.1, 647.89 ), ( 0, 288.74, 0 ), "precious_cargo_end", undefined, undefined, undefined, undefined, undefined, undefined, 200 );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace mp_sat_avalon_q2_ob_contract_precious_cargo_cs
// Params 0, eflags: 0x4
// Checksum 0x86dbe932, Offset: 0x1bd0
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace mp_sat_avalon_q2_ob_contract_precious_cargo_cs
// Params 0
// Checksum 0x98f3d837, Offset: 0x1bda
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "mp_sat_avalon_q2_ob_contract_precious_cargo_cs" );
}

// Namespace mp_sat_avalon_q2_ob_contract_precious_cargo_cs
// Params 0
// Checksum 0x1f0ddbad, Offset: 0x1bf0
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

// Namespace mp_sat_avalon_q2_ob_contract_precious_cargo_cs
// Params 4
// Checksum 0xb175634e, Offset: 0x1c5f
// Size: 0xa5
function function_d4323822d7042e5a( var_4312b79c960726b6, fe, us, cf = "mp_sat_avalon_q2_ob_contract_precious_cargo_cs" )
{
    switch ( var_4312b79c960726b6 )
    {
        case #"hash_bc40e0964a756e65":
            function_90bd5dae26374f0d( fe, us, cf );
            break;
        case #"hash_7b5db50804cd985b":
            function_bea46065bf8b2b63( fe, us, cf );
            break;
        case #"hash_cea4c87f5b2de89b":
            function_fbe1776277d6363( fe, us, cf );
            break;
        case #"hash_dba768b1a994aca2":
            function_589990fff9c6f6a( fe, us, cf );
            break;
    }
}

// Namespace mp_sat_avalon_q2_ob_contract_precious_cargo_cs
// Params 3
// Checksum 0xeb39edc2, Offset: 0x1d0c
// Size: 0xfd
function function_90bd5dae26374f0d( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_precious_cargo_cs";
    fe [[ f ]]( s, "PRECIOUS_CARGO_CLIFFTOWN", cf, ( 21723.9, 15002.6, 220.12 ), ( 0, 0, 0 ), "s_precious_cargo_city_ground_tier_2", undefined, "PRECIOUS_CARGO_CLIFFTOWN", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_precious_cargo_cs";
    fe [[ f ]]( s, "PRECIOUS_CARGO_CLIFFTOWN", cf, ( 21372.7, 14946.1, 266.09 ), ( 0, 0, 0 ), undefined, "PRECIOUS_CARGO_CLIFFTOWN", "precious_cargo_spawn_vehicle", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_sat_avalon_q2_ob_contract_precious_cargo_cs
// Params 3
// Checksum 0x786b50a2, Offset: 0x1e11
// Size: 0x2f
function function_bea46065bf8b2b63( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
}

// Namespace mp_sat_avalon_q2_ob_contract_precious_cargo_cs
// Params 3
// Checksum 0xc4d045ae, Offset: 0x1e48
// Size: 0x2f
function function_fbe1776277d6363( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
}

// Namespace mp_sat_avalon_q2_ob_contract_precious_cargo_cs
// Params 3
// Checksum 0x3c035a39, Offset: 0x1e7f
// Size: 0x2f
function function_589990fff9c6f6a( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
}

// Namespace mp_sat_avalon_q2_ob_contract_precious_cargo_cs
// Params 0
// Checksum 0x6fc5a4c, Offset: 0x1eb6
// Size: 0x297
function function_d9dd7965c51c95d1()
{
    activityinstances = [];
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_activitydefinition_precious_cargo";
    var_881289d7987bc770.cf = "mp_sat_avalon_q2_ob_contract_precious_cargo_cs";
    var_881289d7987bc770.scriptstructorigin = ( 36147, 23925.1, 1490.43 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [];
    var_881289d7987bc770.var_31ce4477e3543d24 = [];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [];
    var_881289d7987bc770.locationradius = [];
    activityinstances[ "PRECIOUS_CARGO_CLIFFTOWN" ] = var_881289d7987bc770;
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_activitydefinition_precious_cargo";
    var_881289d7987bc770.var_265c4f33e2a6daa7 = 1;
    var_881289d7987bc770.cf = "mp_sat_avalon_q2_ob_contract_precious_cargo_cs";
    var_881289d7987bc770.scriptstructorigin = ( 21455.1, 44222.2, 937.62 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [];
    var_881289d7987bc770.var_31ce4477e3543d24 = [];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [];
    var_881289d7987bc770.locationradius = [];
    activityinstances[ "PRECIOUS_CARGO_Q2_WINERY" ] = var_881289d7987bc770;
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_activitydefinition_precious_cargo";
    var_881289d7987bc770.var_265c4f33e2a6daa7 = 1;
    var_881289d7987bc770.cf = "mp_sat_avalon_q2_ob_contract_precious_cargo_cs";
    var_881289d7987bc770.scriptstructorigin = ( 24428.8, 34096.4, 2617.51 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [];
    var_881289d7987bc770.var_31ce4477e3543d24 = [];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [];
    var_881289d7987bc770.locationradius = [];
    activityinstances[ "PRECIOUS_CARGO_Q2_HILLSIDE" ] = var_881289d7987bc770;
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_activitydefinition_precious_cargo";
    var_881289d7987bc770.var_265c4f33e2a6daa7 = 1;
    var_881289d7987bc770.cf = "mp_sat_avalon_q2_ob_contract_precious_cargo_cs";
    var_881289d7987bc770.scriptstructorigin = ( 13315.6, 39721.7, 929.88 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [];
    var_881289d7987bc770.var_31ce4477e3543d24 = [];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [];
    var_881289d7987bc770.locationradius = [];
    activityinstances[ "PRECIOUS_CARGO_Q2_RESORT" ] = var_881289d7987bc770;
    return activityinstances;
}

