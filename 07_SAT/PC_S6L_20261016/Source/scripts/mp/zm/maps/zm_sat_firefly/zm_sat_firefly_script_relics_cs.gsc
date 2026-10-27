// scripts\mp\zm\maps\zm_sat_firefly\zm_sat_firefly_script_relics_cs.gsc  (hash_50ab84ad201015e1.gscc) (size: 10130 Bytes / 0x2792 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xb753285 (192230021)
// size ...... 10130 (0x2792)
// includes .. 3   (offset: 0x216e)
// strings ... 64  (offset: 0x2186)
// dev strs .. 0   (offset: 0x2792)
// exports ... 9   (offset: 0x1d86)
// cseg ...... 0x44a + 0x193c (0x1d86)
// imports ... 21  (offset: 0x1eee)
// animtree1 . 0   (offset: 0x2792)
// animtree2 . 0   (offset: 0x2792)
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace zm_sat_firefly_script_relics_cs;

// Namespace zm_sat_firefly_script_relics_cs
// Params 0, eflags: 0x5
// Checksum 0x918e3433, Offset: 0x468
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"zm_sat_firefly_script_relics_cs", undefined, &function_b39ecd3d51489472, undefined );
}

// Namespace zm_sat_firefly_script_relics_cs
// Params 0, eflags: 0x4
// Checksum 0x3a86dcb6, Offset: 0x489
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace zm_sat_firefly_script_relics_cs
// Params 0, eflags: 0x4
// Checksum 0xbfbd0f5a, Offset: 0x49a
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace zm_sat_firefly_script_relics_cs
// Params 2
// Checksum 0xf545913, Offset: 0x4ab
// Size: 0x80
function main( unused, unused2 )
{
    if ( utility::flag_exist( "zm_sat_firefly_script_relics_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "zm_sat_firefly_script_relics_cs" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "zm_sat_firefly_script_relics_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "zm_sat_firefly_script_relics_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace zm_sat_firefly_script_relics_cs
// Params 3, eflags: 0x4
// Checksum 0x3c3fbb95, Offset: 0x533
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "zm_sat_firefly_script_relics_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "zm_sat_firefly_script_relics_cs" );
}

// Namespace zm_sat_firefly_script_relics_cs
// Params 3, eflags: 0x4
// Checksum 0x1aa50d84, Offset: 0x5ad
// Size: 0x17b9
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_relics_cs";
    s.name = "green_warp";
    fe [[ f ]]( s, us, cf, ( 13871.7, -3809.83, 645.45 ), ( 0, 313.3, 0 ), "green_warp_1" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_relics_cs";
    s.name = "green_portal";
    s.script_int = int( 0 );
    fe [[ f ]]( s, us, cf, ( 13374.3, -4171.75, 641.86 ), ( 90, 131.51, -3.3 ), "relic_green_portal" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_relics_cs";
    s.name = "red_portal";
    s.script_int = int( 0 );
    fe [[ f ]]( s, us, cf, ( 13224.5, 2405.68, 1106.16 ), ( 90, 261.51, 0.01 ), "relic_red_portal" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_relics_cs";
    s.name = "yellow_portal";
    s.script_int = int( 0 );
    fe [[ f ]]( s, us, cf, ( -8246.6, -5201.36, 1630.36 ), ( 90, 230.19, -2.01 ), "relic_yellow_portal" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_relics_cs";
    s.name = "green_warp";
    fe [[ f ]]( s, us, cf, ( 13931.2, -3754.14, 646.45 ), ( 0, 311.8, 0 ), "green_warp_1" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_relics_cs";
    s.name = "green_warp";
    fe [[ f ]]( s, us, cf, ( 13816, -3862.35, 644.45 ), ( 0, 313, 0 ), "green_warp_1" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_relics_cs";
    s.name = "green_warp";
    fe [[ f ]]( s, us, cf, ( 13985.6, -3702.03, 643.45 ), ( 0, 314.2, 0 ), "green_warp_1" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_relics_cs";
    s.name = "green_warp";
    fe [[ f ]]( s, us, cf, ( 13949.3, -3822.57, 642.45 ), ( 0, 313.5, 0 ), undefined, "green_warp_1", "relic_warp_loc_1" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_relics_cs";
    s.name = "yellow_warp";
    fe [[ f ]]( s, us, cf, ( -8499.47, -5171.6, 1575 ), ( 0, 322.7, 0 ), "yellow_warp_1" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_relics_cs";
    s.name = "yellow_warp";
    fe [[ f ]]( s, us, cf, ( -8459.65, -5115.95, 1575 ), ( 0, 319.3, 0 ), "yellow_warp_1" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_relics_cs";
    s.name = "yellow_warp";
    fe [[ f ]]( s, us, cf, ( -8542.36, -5224.83, 1575 ), ( 0, 322.7, 0 ), "yellow_warp_1" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_relics_cs";
    s.name = "yellow_warp";
    fe [[ f ]]( s, us, cf, ( -8573.03, -5266.41, 1575 ), ( 0, 322.7, 0 ), "yellow_warp_1" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_relics_cs";
    s.name = "yellow_warp";
    fe [[ f ]]( s, us, cf, ( -8460.56, -5232.14, 1580.97 ), ( 0, 324.2, 0 ), undefined, "yellow_warp_1", "relic_warp_loc_2" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_relics_cs";
    s.name = "red_warp";
    fe [[ f ]]( s, us, cf, ( 12484, 1899.36, 1030.69 ), ( 0, 257.3, 0 ), "red_warp_1" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_relics_cs";
    s.name = "red_warp";
    fe [[ f ]]( s, us, cf, ( 12560.4, 1826.81, 1031.69 ), ( 0, 257.3, 0 ), undefined, "red_warp_1", "relic_warp_loc_3" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_relics_cs";
    s.name = "red_warp";
    fe [[ f ]]( s, us, cf, ( 12606.2, 1872.06, 1029.69 ), ( 0, 257.3, 0 ), "red_warp_1" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_relics_cs";
    s.name = "red_warp";
    fe [[ f ]]( s, us, cf, ( 12662.3, 1859.62, 1028.69 ), ( 0, 257.3, 0 ), "red_warp_1" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_relics_cs";
    s.name = "red_warp";
    fe [[ f ]]( s, us, cf, ( 12530.3, 1889.17, 1029.69 ), ( 0, 257.3, 0 ), "red_warp_1" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_relics_cs";
    s.name = "Peeks_relics";
    fe [[ f ]]( s, us, cf, ( 5021.2, -1358.49, 276.12 ), ( 12.32, 138.19, -11.84 ), "mrp_relics", undefined, "mrp_2" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_relics_cs";
    s.name = "Peeks_relics";
    fe [[ f ]]( s, us, cf, ( 12929.4, -4249.32, 1033.44 ), ( 0, 17.1, 0 ), "mrp_relics", undefined, "mrp_1" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_relics_cs";
    s.name = "Peeks_relics";
    fe [[ f ]]( s, us, cf, ( -7322.53, -6918.4, 1790.73 ), ( 1.1, 136.14, 10.22 ), "mrp_relics", undefined, "mrp_3" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_relics_cs";
    s.name = "Peeks_relics";
    fe [[ f ]]( s, us, cf, ( -7714.61, -6154.51, 1407.83 ), ( 359.39, 192.84, 2.23 ), "mrp_relics", undefined, "mrp_4" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_relics_cs";
    s.name = "Peeks_relics";
    fe [[ f ]]( s, us, cf, ( -12526.4, 2811.31, 1213.45 ), ( 2.02, 116.17, 1.11 ), "mrp_relics_final", undefined, "mrp_final" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_relics_cs";
    s.name = "Peeks_relics";
    fe [[ f ]]( s, us, cf, ( 8731.77, -6435.88, 704.95 ), ( 2, 129.2, -0 ), "mrp_relics", undefined, "mrp_6" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_relics_cs";
    s.name = "Peeks_relics";
    fe [[ f ]]( s, us, cf, ( 13557, 2303.71, 1194.51 ), ( 358.08, 325.61, -0.56 ), "mrp_relics", undefined, "mrp_7" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_relics_cs";
    s.name = "Peeks_relics";
    fe [[ f ]]( s, us, cf, ( 23028.1, 2680.41, 409.65 ), ( 358.08, 292.69, 0.57 ), "mrp_relics", undefined, "mrp_8" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_relics_cs";
    s.name = "Peeks_relics";
    fe [[ f ]]( s, us, cf, ( 9310.78, 1808.46, 985.7 ), ( 360, 124.75, -0.43 ), "mrp_relics", undefined, "mrp_9" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_relics_cs";
    s.name = "Peeks_relics";
    fe [[ f ]]( s, us, cf, ( 2044.82, 183.19, 815.52 ), ( 0.44, 354.41, 5.02 ), "mrp_relics", undefined, "mrp_10" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_relics_cs";
    s.name = "candle_relic";
    s.script_label = "1";
    fe [[ f ]]( s, us, cf, ( 3313.88, -458.65, 376.23 ), ( 0, 0, 11.4 ), "candle_relic" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_relics_cs";
    s.name = "candle_relic";
    s.script_label = "3";
    fe [[ f ]]( s, us, cf, ( 7923.14, 3089.67, 800.89 ), ( 0, 0, 0 ), "candle_relic" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_relics_cs";
    s.name = "candle_relic";
    s.script_label = "2";
    fe [[ f ]]( s, us, cf, ( 13643.1, -3285.01, 859.91 ), ( 0, 0, -0.8 ), "candle_relic" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_relics_cs";
    s.name = "target_2";
    s.script_label = "2";
    fe [[ f ]]( s, us, cf, ( 24872.8, 292.69, 1829.31 ), ( 0, 178.7, 0 ), "target_pads_relics" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_relics_cs";
    s.name = "target_1";
    s.script_label = "1";
    fe [[ f ]]( s, us, cf, ( 21737.2, 1492.29, 1917.71 ), ( 0, 261.2, 0 ), "target_pads_relics" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_relics_cs";
    s.name = "target_3";
    s.script_label = "3";
    fe [[ f ]]( s, us, cf, ( 21815, -1887.22, 1731 ), ( 343.77, 167.47, 1.58 ), "target_pads_relics" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_relics_cs";
    s.name = "place_loc_wine";
    fe [[ f ]]( s, us, cf, ( 2829.35, -192.92, 399.28 ), ( 359.17, 8.19, 8.73 ), "m_wine_b_p" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_relics_cs";
    s.name = "spawn_loc_wine";
    fe [[ f ]]( s, us, cf, ( 3748.45, 343.3, 531.4 ), ( 5.57, 174.67, -2.35 ), "m_wine_b" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_relics_cs";
    s.name = "green_portal";
    s.script_int = int( 1 );
    fe [[ f ]]( s, us, cf, ( 13755.6, -3203.97, 695.05 ), ( 90, 42.13, -2.67 ), "relic_green_portal" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_relics_cs";
    s.name = "green_portal";
    s.script_int = int( 2 );
    fe [[ f ]]( s, us, cf, ( 14419.5, -3150.06, 672.44 ), ( 89.93, 253.79, 88.99 ), "relic_green_portal" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_relics_cs";
    s.name = "yellow_portal";
    s.script_int = int( 1 );
    fe [[ f ]]( s, us, cf, ( -8511.56, -6512.61, 1694.78 ), ( 90, 50.3, -1.9 ), "relic_yellow_portal" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_relics_cs";
    s.name = "mrp_events";
    fe [[ f ]]( s, us, cf, ( 13220.4, 1613, 1174.74 ), ( 6.21, 257.96, 1.48 ), "mrp_event", "mrp_event_reward_0" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_relics_cs";
    s.name = "mrp_events";
    fe [[ f ]]( s, us, cf, ( 22845.3, 290.62, 463.94 ), ( 20.2, 0, 0 ), "mrp_event", "mrp_event_reward_1" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_relics_cs";
    s.name = "mrp_events";
    fe [[ f ]]( s, us, cf, ( 2484.31, -269.77, 754.22 ), ( 358.29, 350.08, 14.25 ), "mrp_event", "mrp_event_reward_2", "ashwood_mrp_event" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_relics_cs";
    s.name = "mrp_events";
    fe [[ f ]]( s, us, cf, ( 4341.07, -2918.28, 544.92 ), ( 4.02, 149.79, 5.92 ), "mrp_event", "mrp_event_reward_3", "ashwood_mrp_event" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_relics_cs";
    s.name = "mrp_events";
    fe [[ f ]]( s, us, cf, ( 14136, -4867.24, 744.4 ), ( 2.53, 9.77, 5.24 ), "mrp_event", "mrp_event_reward_4", "zone_farm_mrp_event" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_relics_cs";
    s.name = "mrp_events";
    fe [[ f ]]( s, us, cf, ( -11404.8, 3594.55, 756.62 ), ( 3.35, 3.66, 2.87 ), "mrp_event", "mrp_event_reward_5", "zone_exit115_mrp_event" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_relics_cs";
    s.name = "mrp_events";
    fe [[ f ]]( s, us, cf, ( -7823.97, -5497.36, 1881.83 ), ( 0.8, 225.25, 2.81 ), "mrp_event", "mrp_event_reward_6", "zone_launchpad_mrp_event" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_relics_cs";
    s.name = "relic_telephone";
    fe [[ f ]]( s, us, cf, ( -13712.7, 3823.48, 463.99 ), ( 0, 32.5, 0 ), "r_tp" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_relics_cs";
    s.name = "relic_telephone";
    fe [[ f ]]( s, us, cf, ( -6961.94, -6244.11, 1607.2 ), ( 0, 54.9, 0 ), "r_tp" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_relics_cs";
    s.name = "relic_telephone";
    fe [[ f ]]( s, us, cf, ( -11940, 3444.1, 527.72 ), ( 0, 262.2, 0 ), "r_tp" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_relics_cs";
    s.name = "relic_telephone";
    fe [[ f ]]( s, us, cf, ( 3542.59, -2907.55, 464.17 ), ( 0.27, 357.67, -10.18 ), "r_tp" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_relics_cs";
    s.name = "relic_telephone";
    fe [[ f ]]( s, us, cf, ( 4199.61, -2449.46, 325.81 ), ( 347.78, 224.25, -0.04 ), "r_tp" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_relics_cs";
    s.name = "relic_telephone";
    fe [[ f ]]( s, us, cf, ( 10007.8, 2151.39, 823.6 ), ( 0, 78.4, 0 ), "r_tp" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_relics_cs";
    s.name = "relic_telephone";
    fe [[ f ]]( s, us, cf, ( 12473.9, 3033.17, 1067.61 ), ( 0, 352.4, 0 ), "r_tp" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_relics_cs";
    s.name = "relic_telephone";
    fe [[ f ]]( s, us, cf, ( 13511, -3613.06, 706.47 ), ( 0, 66.5, 0 ), "r_tp" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_relics_cs";
    s.name = "relic_telephone";
    fe [[ f ]]( s, us, cf, ( 23188.7, -292.31, 505.32 ), ( 7.69, 188.72, 6 ), "r_tp" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_relics_cs";
    s.name = "mrp_event_reward";
    fe [[ f ]]( s, us, cf, ( 13201.4, 1524, 1037.74 ), ( 0, 0, 0 ), "mrp_event_reward_0", undefined, "mrp_event_reward" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_relics_cs";
    s.name = "mrp_event_reward";
    fe [[ f ]]( s, us, cf, ( 22973.3, 290.62, 318.94 ), ( 0, 0, 0 ), "mrp_event_reward_1", undefined, "mrp_event_reward" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_relics_cs";
    s.name = "mrp_event_reward";
    fe [[ f ]]( s, us, cf, ( 2654.31, -260.77, 380.22 ), ( 0, 0, 0 ), "mrp_event_reward_2", undefined, "mrp_event_reward" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_relics_cs";
    s.name = "mrp_event_reward";
    fe [[ f ]]( s, us, cf, ( 4210.07, -2918.28, 352.92 ), ( 0, 0, 0 ), "mrp_event_reward_3", undefined, "mrp_event_reward" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_relics_cs";
    s.name = "mrp_event_reward";
    fe [[ f ]]( s, us, cf, ( 14202, -4818.24, 583.4 ), ( 0, 0, 0 ), "mrp_event_reward_4", undefined, "mrp_event_reward" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_relics_cs";
    s.name = "mrp_event_reward";
    fe [[ f ]]( s, us, cf, ( -11281.8, 3655.55, 422.62 ), ( 0, 0, 0 ), "mrp_event_reward_5", undefined, "mrp_event_reward" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_relics_cs";
    s.name = "mrp_event_reward";
    fe [[ f ]]( s, us, cf, ( -7914.6, -5634.72, 1661.58 ), ( 0, 0, 0 ), "mrp_event_reward_6", undefined, "mrp_event_reward" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_relics_cs";
    s.name = "yellow_portal";
    s.script_int = int( 2 );
    fe [[ f ]]( s, us, cf, ( -8742.76, -6429.13, 1355.13 ), ( 90, 305.04, 26.84 ), "relic_yellow_portal" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_relics_cs";
    s.name = "red_portal";
    s.script_int = int( 1 );
    fe [[ f ]]( s, us, cf, ( 13644.9, 1748.66, 1084.63 ), ( 90, 280.3, 22.8 ), "relic_red_portal" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_relics_cs";
    s.name = "red_portal";
    s.script_int = int( 2 );
    fe [[ f ]]( s, us, cf, ( 14653.6, 2292.19, 928.34 ), ( 90, 6.38, -11.11 ), "relic_red_portal" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_relics_cs";
    s.script_int = int( 4 );
    fe [[ f ]]( s, us, cf, ( 13386.8, 2281.3, 1096.31 ), ( 0, 131.4, 0 ), "r_wb_s", undefined, "r_wb" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_relics_cs";
    s.script_int = int( 1 );
    fe [[ f ]]( s, us, cf, ( 13394, 2322.01, 1096.4 ), ( 0, 155.3, 0 ), "r_wb_s", undefined, "r_wb" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_relics_cs";
    s.script_int = int( 5 );
    fe [[ f ]]( s, us, cf, ( 13384.5, 2268.21, 1096.29 ), ( 0, 95.4, 0 ), "r_wb_s", undefined, "r_wb" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_relics_cs";
    s.script_int = int( 3 );
    fe [[ f ]]( s, us, cf, ( 13389.4, 2293.33, 1096.22 ), ( 0, 144.6, 0 ), "r_wb_trial", undefined, "3" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_relics_cs";
    s.script_int = int( 2 );
    fe [[ f ]]( s, us, cf, ( 13391.5, 2307.67, 1096.32 ), ( 0, 121.4, 0 ), "r_wb_bear", undefined, "2" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_relics_cs";
    fe [[ f ]]( s, us, cf, ( 13383.6, 2294.22, 1093.43 ), ( 0, 170.6, 0 ), "wb_interact_new" );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace zm_sat_firefly_script_relics_cs
// Params 0, eflags: 0x4
// Checksum 0x3f6cbed6, Offset: 0x1d6e
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace zm_sat_firefly_script_relics_cs
// Params 0
// Checksum 0xfe6c66d8, Offset: 0x1d78
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "zm_sat_firefly_script_relics_cs" );
}

