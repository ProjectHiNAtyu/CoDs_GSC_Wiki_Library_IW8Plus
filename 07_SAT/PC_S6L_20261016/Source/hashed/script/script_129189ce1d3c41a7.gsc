// script_129189ce1d3c41a7  (hash_129189ce1d3c41a7.gscc) (size: 9881 Bytes / 0x2699 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x270cdb16 (655153942)
// size ...... 9881 (0x2699)
// includes .. 4   (offset: 0x219d)
// strings ... 22  (offset: 0x21bd)
// dev strs .. 0   (offset: 0x2699)
// exports ... 13  (offset: 0x1cb9)
// cseg ...... 0x289 + 0x1a30 (0x1cb9)
// imports ... 26  (offset: 0x1ec1)
// animtree1 . 0   (offset: 0x2699)
// animtree2 . 0   (offset: 0x2699)
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace mp_sat_avalon_city_ob_contract_precious_cargo_cs;

// Namespace mp_sat_avalon_city_ob_contract_precious_cargo_cs
// Params 0, eflags: 0x5
// Checksum 0x2a70216d, Offset: 0x2a7
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"mp_sat_avalon_city_ob_contract_precious_cargo_cs", #"activity_common", &function_b39ecd3d51489472, undefined );
}

// Namespace mp_sat_avalon_city_ob_contract_precious_cargo_cs
// Params 0, eflags: 0x4
// Checksum 0x9996e337, Offset: 0x2d0
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace mp_sat_avalon_city_ob_contract_precious_cargo_cs
// Params 0, eflags: 0x4
// Checksum 0x1cad30db, Offset: 0x2e1
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace mp_sat_avalon_city_ob_contract_precious_cargo_cs
// Params 2
// Checksum 0x73f0a387, Offset: 0x2f2
// Size: 0x8c
function main( unused, unused2 )
{
    if ( utility::flag_exist( "mp_sat_avalon_city_ob_contract_precious_cargo_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "mp_sat_avalon_city_ob_contract_precious_cargo_cs" ) )
    {
        return;
    }
    
    activity_common::function_e1df676808c1d1e3( &function_4cd78e661617f3 );
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "mp_sat_avalon_city_ob_contract_precious_cargo_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "mp_sat_avalon_city_ob_contract_precious_cargo_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace mp_sat_avalon_city_ob_contract_precious_cargo_cs
// Params 3, eflags: 0x4
// Checksum 0x9f2f8414, Offset: 0x386
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "mp_sat_avalon_city_ob_contract_precious_cargo_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "mp_sat_avalon_city_ob_contract_precious_cargo_cs" );
}

// Namespace mp_sat_avalon_city_ob_contract_precious_cargo_cs
// Params 3, eflags: 0x4
// Checksum 0xd74e14c1, Offset: 0x400
// Size: 0x160f
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_contract_precious_cargo_cs";
    s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
    s.groupid = "heli_spawn_point";
    s.script_unload = "default";
    s.spawngroup = "heli_test_guys";
    fe [[ f ]]( s, us, cf, ( -25485.2, -21714.4, 3921.56 ), ( 0, 230, 0 ), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_contract_precious_cargo_cs";
    s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
    s.groupid = "heli_spawn_point";
    s.script_unload = "default";
    s.spawngroup = "heli_test_guys";
    fe [[ f ]]( s, us, cf, ( -15973.1, -6377.77, 4432.14 ), ( 0, 230, 0 ), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_contract_precious_cargo_cs";
    s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
    s.groupid = "heli_spawn_point";
    s.script_unload = "default";
    s.spawngroup = "heli_test_guys";
    fe [[ f ]]( s, us, cf, ( -22999.9, -12360.6, 3921.56 ), ( 0, 230, 0 ), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_contract_precious_cargo_cs";
    s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
    s.groupid = "heli_spawn_point";
    s.script_unload = "default";
    s.spawngroup = "heli_test_guys";
    fe [[ f ]]( s, us, cf, ( -2522.79, -11664.3, 4298.08 ), ( 0, 230, 0 ), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_contract_precious_cargo_cs";
    s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
    s.groupid = "heli_spawn_point";
    s.script_unload = "default";
    s.spawngroup = "heli_test_guys";
    fe [[ f ]]( s, us, cf, ( 1615.79, -1073.35, 3499.38 ), ( 0, 230, 0 ), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_contract_precious_cargo_cs";
    s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
    s.groupid = "heli_spawn_point";
    s.script_unload = "default";
    s.spawngroup = "heli_test_guys";
    fe [[ f ]]( s, us, cf, ( -1140.97, 7955.91, 3388.31 ), ( 0, 230, 0 ), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_contract_precious_cargo_cs";
    s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
    s.groupid = "heli_spawn_point";
    s.script_unload = "default";
    s.spawngroup = "heli_test_guys";
    fe [[ f ]]( s, us, cf, ( -10952.8, 14797.5, 3924.88 ), ( 0, 230, 0 ), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_contract_precious_cargo_cs";
    s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
    s.groupid = "heli_spawn_point";
    s.script_unload = "default";
    s.spawngroup = "heli_test_guys";
    fe [[ f ]]( s, us, cf, ( -24965.7, 8236.5, 4232.94 ), ( 0, 230, 0 ), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_contract_precious_cargo_cs";
    s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
    s.groupid = "heli_spawn_point";
    s.script_unload = "default";
    s.spawngroup = "heli_test_guys";
    fe [[ f ]]( s, us, cf, ( -19730.9, 18219.1, 5095.12 ), ( 0, 230, 0 ), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_contract_precious_cargo_cs";
    s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
    s.groupid = "heli_spawn_point";
    s.script_unload = "default";
    s.spawngroup = "heli_test_guys";
    fe [[ f ]]( s, us, cf, ( -44279.8, 21569.5, 8263.29 ), ( 0, 230, 0 ), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_contract_precious_cargo_cs";
    s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
    s.groupid = "heli_spawn_point";
    s.script_unload = "default";
    s.spawngroup = "heli_test_guys";
    fe [[ f ]]( s, us, cf, ( -30668.6, 6999.28, 4580.14 ), ( 0, 230, 0 ), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_contract_precious_cargo_cs";
    s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
    s.groupid = "heli_spawn_point";
    s.script_unload = "default";
    s.spawngroup = "heli_test_guys";
    fe [[ f ]]( s, us, cf, ( -28140.9, -28571.1, 6050.45 ), ( 0, 230, 0 ), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_contract_precious_cargo_cs";
    s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
    s.groupid = "heli_spawn_point";
    s.script_unload = "default";
    s.spawngroup = "heli_test_guys";
    fe [[ f ]]( s, us, cf, ( -34564.8, -20440.4, 4784.58 ), ( 0, 230, 0 ), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_contract_precious_cargo_cs";
    s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
    s.groupid = "heli_spawn_point";
    s.script_unload = "default";
    s.spawngroup = "heli_test_guys";
    fe [[ f ]]( s, us, cf, ( -21701.5, -30737.9, 4328.51 ), ( 0, 230, 0 ), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_contract_precious_cargo_cs";
    s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
    s.groupid = "heli_spawn_point";
    s.script_unload = "default";
    s.spawngroup = "heli_test_guys";
    fe [[ f ]]( s, us, cf, ( 13274.4, 2236.91, 4441.6 ), ( 0, 230, 0 ), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_contract_precious_cargo_cs";
    s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
    s.groupid = "heli_spawn_point";
    s.script_unload = "default";
    s.spawngroup = "heli_test_guys";
    fe [[ f ]]( s, us, cf, ( 10509.9, -7944.82, 5391.29 ), ( 0, 230, 0 ), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_contract_precious_cargo_cs";
    s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
    s.groupid = "heli_spawn_point";
    s.script_unload = "default";
    s.spawngroup = "heli_test_guys";
    fe [[ f ]]( s, us, cf, ( 3958.06, -12072.2, 5199.71 ), ( 0, 230, 0 ), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_contract_precious_cargo_cs";
    s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
    s.groupid = "heli_spawn_point";
    s.script_unload = "default";
    s.spawngroup = "heli_test_guys";
    fe [[ f ]]( s, us, cf, ( -4230.44, -12884.1, 3686.56 ), ( 0, 230, 0 ), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_contract_precious_cargo_cs";
    s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
    s.groupid = "heli_spawn_point";
    s.script_unload = "default";
    s.spawngroup = "heli_test_guys";
    fe [[ f ]]( s, us, cf, ( -7394.88, -570.3, 3817.31 ), ( 0, 230, 0 ), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_contract_precious_cargo_cs";
    s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
    s.groupid = "heli_spawn_point";
    s.script_unload = "default";
    s.spawngroup = "heli_test_guys";
    fe [[ f ]]( s, us, cf, ( 3615.31, 14599.3, 3561.31 ), ( 0, 230, 0 ), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_contract_precious_cargo_cs";
    fe [[ f ]]( s, "PRECIOUS_CARGO_CITY_GROUND_TIER_2", cf, ( -14650, 10343, 1063.1 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "OB_Spacer_Spatial_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 50 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_contract_precious_cargo_cs";
    fe [[ f ]]( s, "PRECIOUS_CARGO_CITY_GROUND_TIER_2", cf, ( -25853.9, 7499.27, 472.5 ), ( 354.47, 1.37, 7.54 ), "activity_nexus_instance_joiner", undefined, "PRECIOUS_CARGO_CITY_GROUND_TIER_2", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_contract_precious_cargo_cs";
    s.activity_bundle = "sat_activitydefinition_precious_cargo";
    s.difficulty_tier = "2";
    s.name = "PRECIOUS_CARGO_CITY_GROUND_TIER_2";
    fe [[ f ]]( s, "PRECIOUS_CARGO_CITY_GROUND_TIER_2", cf, ( -14564.4, 10044, 1042.96 ), ( 0, 231.24, 0 ), "activity_nexus_variant", "PRECIOUS_CARGO_CITY_GROUND_TIER_2", undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_contract_precious_cargo_cs";
    s.groupid = "end_point01";
    s.name = "end_point";
    fe [[ f ]]( s, us, cf, ( -1448.69, 10506.1, 14 ), ( 0, 73.72, 0 ), "precious_cargo_end", undefined, undefined, undefined, undefined, undefined, undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_contract_precious_cargo_cs";
    s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
    s.groupid = "heli_spawn_point";
    s.script_unload = "default";
    s.spawngroup = "heli_test_guys";
    fe [[ f ]]( s, us, cf, ( -23251.3, -27084.2, 3921.56 ), ( 0, 230, 0 ), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_contract_precious_cargo_cs";
    s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
    s.groupid = "heli_spawn_point";
    s.script_unload = "default";
    s.spawngroup = "heli_test_guys";
    fe [[ f ]]( s, us, cf, ( 5147.56, 1126.77, 3499.38 ), ( 0, 230, 0 ), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_contract_precious_cargo_cs";
    s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
    s.groupid = "heli_spawn_point";
    s.script_unload = "default";
    s.spawngroup = "heli_test_guys";
    fe [[ f ]]( s, us, cf, ( -17664.2, -18037.4, 3499.38 ), ( 0, 230, 0 ), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_contract_precious_cargo_cs";
    s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
    s.groupid = "heli_spawn_point";
    s.script_unload = "default";
    s.spawngroup = "heli_test_guys";
    fe [[ f ]]( s, us, cf, ( -32138.7, -14737.2, 3499.38 ), ( 0, 230, 0 ), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_contract_precious_cargo_cs";
    s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
    s.groupid = "heli_spawn_point";
    s.script_unload = "default";
    s.spawngroup = "heli_test_guys";
    fe [[ f ]]( s, us, cf, ( -19111.7, 1011.01, 3499.38 ), ( 0, 230, 0 ), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_contract_precious_cargo_cs";
    s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
    s.groupid = "heli_spawn_point";
    s.script_unload = "default";
    s.spawngroup = "heli_test_guys";
    fe [[ f ]]( s, us, cf, ( 3410.56, -20295.4, 3499.38 ), ( 0, 230, 0 ), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_contract_precious_cargo_cs";
    s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
    s.groupid = "heli_spawn_point";
    s.script_unload = "default";
    s.spawngroup = "heli_test_guys";
    fe [[ f ]]( s, us, cf, ( -43765.8, -7106.32, 4111.91 ), ( 0, 230, 0 ), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_contract_precious_cargo_cs";
    s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
    s.groupid = "heli_spawn_point";
    s.script_unload = "default";
    s.spawngroup = "heli_test_guys";
    fe [[ f ]]( s, us, cf, ( -9384.83, -22379.7, 3499.38 ), ( 0, 230, 0 ), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_contract_precious_cargo_cs";
    s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
    s.groupid = "heli_spawn_point";
    s.script_unload = "default";
    s.spawngroup = "heli_test_guys";
    fe [[ f ]]( s, us, cf, ( -2564.75, 2892.43, 4211.05 ), ( 0, 230, 0 ), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_contract_precious_cargo_cs";
    s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
    s.groupid = "heli_spawn_point";
    s.script_unload = "default";
    s.spawngroup = "heli_test_guys";
    fe [[ f ]]( s, us, cf, ( -2317.96, -19201.4, 6247.14 ), ( 0, 230, 0 ), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_contract_precious_cargo_cs";
    s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
    s.groupid = "heli_spawn_point";
    s.script_unload = "default";
    s.spawngroup = "heli_test_guys";
    fe [[ f ]]( s, us, cf, ( -25385.3, -18170.2, 4758.95 ), ( 0, 230, 0 ), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_contract_precious_cargo_cs";
    s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
    s.groupid = "heli_spawn_point";
    s.script_unload = "default";
    s.spawngroup = "heli_test_guys";
    fe [[ f ]]( s, us, cf, ( -46797.4, 8097.78, 3924.27 ), ( 0, 230, 0 ), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_contract_precious_cargo_cs";
    s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
    s.groupid = "heli_spawn_point";
    s.script_unload = "default";
    s.spawngroup = "heli_test_guys";
    fe [[ f ]]( s, us, cf, ( -25182, 17191.3, 4306.7 ), ( 0, 230, 0 ), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_contract_precious_cargo_cs";
    s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
    s.groupid = "heli_spawn_point";
    s.script_unload = "default";
    s.spawngroup = "heli_test_guys";
    fe [[ f ]]( s, us, cf, ( -13725.3, 13058.5, 4713.91 ), ( 0, 230, 0 ), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_contract_precious_cargo_cs";
    s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
    s.groupid = "heli_spawn_point";
    s.script_unload = "default";
    s.spawngroup = "heli_test_guys";
    fe [[ f ]]( s, us, cf, ( -2317.96, -19201.4, 4315.78 ), ( 0, 230, 0 ), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_contract_precious_cargo_cs";
    s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
    s.groupid = "heli_spawn_point";
    s.script_unload = "default";
    s.spawngroup = "heli_test_guys";
    fe [[ f ]]( s, us, cf, ( 2783.29, -7060.64, 5102.32 ), ( 0, 230, 0 ), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_contract_precious_cargo_cs";
    s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
    s.groupid = "heli_spawn_point";
    s.script_unload = "default";
    s.spawngroup = "heli_test_guys";
    fe [[ f ]]( s, us, cf, ( -31271.5, 5017.52, 3735.28 ), ( 0, 230, 0 ), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45 );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace mp_sat_avalon_city_ob_contract_precious_cargo_cs
// Params 0, eflags: 0x4
// Checksum 0x647417ca, Offset: 0x1a17
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace mp_sat_avalon_city_ob_contract_precious_cargo_cs
// Params 0
// Checksum 0x5d7c5959, Offset: 0x1a21
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "mp_sat_avalon_city_ob_contract_precious_cargo_cs" );
}

// Namespace mp_sat_avalon_city_ob_contract_precious_cargo_cs
// Params 0
// Checksum 0xda825ac3, Offset: 0x1a37
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

// Namespace mp_sat_avalon_city_ob_contract_precious_cargo_cs
// Params 4
// Checksum 0xffad0b05, Offset: 0x1aa6
// Size: 0x57
function function_d4323822d7042e5a( var_4312b79c960726b6, fe, us, cf = "mp_sat_avalon_city_ob_contract_precious_cargo_cs" )
{
    switch ( var_4312b79c960726b6 )
    {
        case #"hash_a025237042f1c49c":
            function_34151dfff1bd57d4( fe, us, cf );
            break;
    }
}

// Namespace mp_sat_avalon_city_ob_contract_precious_cargo_cs
// Params 3
// Checksum 0x7a07e3cc, Offset: 0x1b05
// Size: 0xfd
function function_34151dfff1bd57d4( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_contract_precious_cargo_cs";
    fe [[ f ]]( s, "PRECIOUS_CARGO_CITY_GROUND_TIER_2", cf, ( -12994.1, 4703.57, 1100.35 ), ( 0, 57.57, 0 ), "s_precious_cargo_city_ground_tier_2", undefined, "PRECIOUS_CARGO_CITY_GROUND_TIER_2", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_contract_precious_cargo_cs";
    fe [[ f ]]( s, "PRECIOUS_CARGO_CITY_GROUND_TIER_2", cf, ( -12873.6, 5034.88, 1087.61 ), ( 0, 51.38, 0 ), undefined, "PRECIOUS_CARGO_CITY_GROUND_TIER_2", "precious_cargo_spawn_vehicle", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_sat_avalon_city_ob_contract_precious_cargo_cs
// Params 0
// Checksum 0x76dd22bb, Offset: 0x1c0a
// Size: 0xae
function function_d9dd7965c51c95d1()
{
    activityinstances = [];
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_activitydefinition_precious_cargo";
    var_881289d7987bc770.cf = "mp_sat_avalon_city_ob_contract_precious_cargo_cs";
    var_881289d7987bc770.scriptstructorigin = ( -14564.4, 10044, 1042.96 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [];
    var_881289d7987bc770.var_31ce4477e3543d24 = [];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [];
    var_881289d7987bc770.locationradius = [];
    activityinstances[ "PRECIOUS_CARGO_CITY_GROUND_TIER_2" ] = var_881289d7987bc770;
    return activityinstances;
}

