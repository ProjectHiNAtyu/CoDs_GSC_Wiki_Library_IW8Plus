// scripts\mp\zm\systems\relics\zm_sat_hornet_r_props_create_script.gsc  (hash_26abc09b96302e8c.gscc) (size: 8565 Bytes / 0x2175 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x15db9abb (366713531)
// size ...... 8565 (0x2175)
// includes .. 3   (offset: 0x1d71)
// strings ... 35  (offset: 0x1d89)
// dev strs .. 0   (offset: 0x2175)
// exports ... 9   (offset: 0x19d9)
// cseg ...... 0x3a7 + 0x1632 (0x19d9)
// imports ... 20  (offset: 0x1b41)
// animtree1 . 0   (offset: 0x2175)
// animtree2 . 0   (offset: 0x2175)
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace zm_sat_hornet_r_props_create_script;

// Namespace zm_sat_hornet_r_props_create_script
// Params 0, eflags: 0x5
// Checksum 0x5045fc1f, Offset: 0x3c5
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"zm_sat_hornet_r_props_create_script", undefined, &function_b39ecd3d51489472, undefined );
}

// Namespace zm_sat_hornet_r_props_create_script
// Params 0, eflags: 0x4
// Checksum 0x318d5eb6, Offset: 0x3e6
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace zm_sat_hornet_r_props_create_script
// Params 0, eflags: 0x4
// Checksum 0xb4b68d5a, Offset: 0x3f7
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace zm_sat_hornet_r_props_create_script
// Params 2
// Checksum 0x45fdb13, Offset: 0x408
// Size: 0x80
function main( unused, unused2 )
{
    if ( utility::flag_exist( "zm_sat_hornet_r_props_create_script" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "zm_sat_hornet_r_props_create_script" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "zm_sat_hornet_r_props_create_script" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "zm_sat_hornet_r_props_create_script" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace zm_sat_hornet_r_props_create_script
// Params 3, eflags: 0x4
// Checksum 0x37343995, Offset: 0x490
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "zm_sat_hornet_r_props_create_script" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "zm_sat_hornet_r_props_create_script" );
}

// Namespace zm_sat_hornet_r_props_create_script
// Params 3, eflags: 0x4
// Checksum 0xeac923f6, Offset: 0x50a
// Size: 0x14af
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "zm_sat_hornet_r_props_create_script";
    fe [[ f ]]( s, us, cf, ( 684.73, -23867.4, 147.88 ), ( 358.1, 268.4, 0.03 ), "jp_s_l" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_r_props_create_script";
    fe [[ f ]]( s, us, cf, ( 3305.33, -23472.1, 165.18 ), ( 353.63, 48.16, -1.26 ), "jp_s_l" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_r_props_create_script";
    fe [[ f ]]( s, us, cf, ( -1427.08, -22503.6, 175.09 ), ( 352, 308.57, 26.06 ), "jp_s_l" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_r_props_create_script";
    fe [[ f ]]( s, us, cf, ( -381.28, -18806.9, 1082 ), ( 0, 191.1, 0 ), "jp_s_l" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_r_props_create_script";
    fe [[ f ]]( s, us, cf, ( -639.47, -18396.5, 1222.14 ), ( 0, 8.7, 0 ), "jp_s_l" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_r_props_create_script";
    fe [[ f ]]( s, us, cf, ( 823.24, -22644.6, 201.26 ), ( 67.21, 136.24, 100.22 ), "dmst_1" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_r_props_create_script";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( -1496.61, -17373.4, 1222.58 ), ( 359.96, 122, 0.4 ), "dmst_1" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_r_props_create_script";
    fe [[ f ]]( s, us, cf, ( -302.07, -17377.7, 1240.63 ), ( 0, 99.29, 0 ), "jp_s_l" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_r_props_create_script";
    fe [[ f ]]( s, us, cf, ( 1613, -23072, 238 ), ( 0, 0, 0 ), "crf_rng_2_flame" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_r_props_create_script";
    fe [[ f ]]( s, us, cf, ( 930, -23094, 222 ), ( 0, -90, 0 ), "crf_z_rng_2" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_r_props_create_script";
    fe [[ f ]]( s, us, cf, ( 1613, -23119, 238 ), ( 0, 0, 0 ), "crf_rng_2_flame" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_r_props_create_script";
    fe [[ f ]]( s, us, cf, ( 1613, -23025, 238 ), ( 0, 0, 0 ), "crf_rng_2_flame" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_r_props_create_script";
    fe [[ f ]]( s, us, cf, ( 719.25, -23509.9, 192 ), ( 0, 276, 0 ), "crf_rng_2_flame" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_r_props_create_script";
    fe [[ f ]]( s, us, cf, ( 672.51, -23514.8, 192 ), ( 0, 276, 0 ), "crf_rng_2_flame" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_r_props_create_script";
    fe [[ f ]]( s, us, cf, ( 766, -23505, 192 ), ( 0, 276, 0 ), "crf_rng_2_flame" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_r_props_create_script";
    fe [[ f ]]( s, us, cf, ( 631.25, -23517.9, 192 ), ( 0, 276, 0 ), "crf_rng_2_flame" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_r_props_create_script";
    fe [[ f ]]( s, us, cf, ( 584.51, -23522.8, 192 ), ( 0, 276, 0 ), "crf_rng_2_flame" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_r_props_create_script";
    fe [[ f ]]( s, us, cf, ( 540.51, -23526.8, 192 ), ( 0, 276, 0 ), "crf_rng_2_flame" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_r_props_create_script";
    fe [[ f ]]( s, us, cf, ( -560.61, -22842.8, 194 ), ( 0, 8, 0 ), "crf_rng_2_flame" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_r_props_create_script";
    fe [[ f ]]( s, us, cf, ( -554.08, -22889.3, 194 ), ( 0, 8, 0 ), "crf_rng_2_flame" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_r_props_create_script";
    fe [[ f ]]( s, us, cf, ( -565.14, -22810.2, 194 ), ( 0, 8, 0 ), "crf_rng_2_flame" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_r_props_create_script";
    fe [[ f ]]( s, us, cf, ( -549.55, -22930.4, 194 ), ( 0, 8, 0 ), "crf_rng_2_flame" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_r_props_create_script";
    fe [[ f ]]( s, us, cf, ( -543.02, -22977, 194 ), ( 0, 8, 0 ), "crf_rng_2_flame" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_r_props_create_script";
    fe [[ f ]]( s, us, cf, ( -539.49, -23006.8, 194 ), ( 0, 8, 0 ), "crf_rng_2_flame" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_r_props_create_script";
    fe [[ f ]]( s, us, cf, ( 69.82, -21982.9, 322 ), ( 0, 271.99, 0 ), "crf_rng_2_flame" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_r_props_create_script";
    fe [[ f ]]( s, us, cf, ( 22.89, -21984.6, 322 ), ( 0, 271.99, 0 ), "crf_rng_2_flame" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_r_props_create_script";
    fe [[ f ]]( s, us, cf, ( 102.72, -21981.8, 322 ), ( 0, 271.99, 0 ), "crf_rng_2_flame" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_r_props_create_script";
    fe [[ f ]]( s, us, cf, ( -18.45, -21984.8, 322 ), ( 0, 271.99, 0 ), "crf_rng_2_flame" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_r_props_create_script";
    fe [[ f ]]( s, us, cf, ( -65.48, -21986.4, 322 ), ( 0, 271.99, 0 ), "crf_rng_2_flame" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_r_props_create_script";
    fe [[ f ]]( s, us, cf, ( -95.48, -21986.8, 322 ), ( 0, 271.99, 0 ), "crf_rng_2_flame" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_r_props_create_script";
    fe [[ f ]]( s, us, cf, ( 686, -22964, 170 ), ( 0, -90, 0 ), "crf_z_rng_2_abom_spawn" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_r_props_create_script";
    fe [[ f ]]( s, us, cf, ( 1190, -22964, 160 ), ( 0, -90, 0 ), "crf_z_rng_2_abom_spawn" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_r_props_create_script";
    fe [[ f ]]( s, us, cf, ( 544, -21016, 562 ), ( 0, 40, 0 ), "crf_z_rng_3_mrp_point_2" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_r_props_create_script";
    fe [[ f ]]( s, us, cf, ( 228, -21144, 586 ), ( 0, 2, 0 ), "crf_z_rng_3_mrp_point_1" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_r_props_create_script";
    fe [[ f ]]( s, us, cf, ( 780, -20820, 552 ), ( 0, 40, 0 ), "crf_z_rng_3_mrp_point_3" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_r_props_create_script";
    fe [[ f ]]( s, us, cf, ( 886, -20562, 552 ), ( 0, 116, 0 ), "crf_z_rng_3_mrp_point_4" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_r_props_create_script";
    fe [[ f ]]( s, us, cf, ( 790, -20356, 568 ), ( 0, 116, 0 ), "crf_z_rng_3_mrp_point_5" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_r_props_create_script";
    fe [[ f ]]( s, us, cf, ( 710, -20272, 626 ), ( 0, 116, 0 ), "crf_z_rng_3_mrp_point_6" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_r_props_create_script";
    fe [[ f ]]( s, us, cf, ( 566, -20200, 672 ), ( 0, 144, 0 ), "crf_z_rng_3_mrp_point_8" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_r_props_create_script";
    fe [[ f ]]( s, us, cf, ( 660, -20230, 654 ), ( 0, 142, 0 ), "crf_z_rng_3_mrp_point_7" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_r_props_create_script";
    fe [[ f ]]( s, us, cf, ( 444, -20130, 672 ), ( 0, 166, 0 ), "crf_z_rng_3_mrp_point_9" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_r_props_create_script";
    fe [[ f ]]( s, us, cf, ( 234, -20038, 694 ), ( 0, 166, 0 ), "crf_z_rng_3_mrp_point_10" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_r_props_create_script";
    fe [[ f ]]( s, us, cf, ( -38, -20014, 756 ), ( 0, 194, 0 ), "crf_z_rng_3_mrp_point_11" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_r_props_create_script";
    fe [[ f ]]( s, us, cf, ( -288, -20074, 772 ), ( 0, 99.99, 0 ), "crf_z_rng_3_mrp_point_12" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_r_props_create_script";
    fe [[ f ]]( s, us, cf, ( -334, -19814, 804 ), ( 0, 99.99, 0 ), "crf_z_rng_3_mrp_point_14" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_r_props_create_script";
    fe [[ f ]]( s, us, cf, ( -312, -19932, 790 ), ( 0, 99.99, 0 ), "crf_z_rng_3_mrp_point_13" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_r_props_create_script";
    fe [[ f ]]( s, us, cf, ( -328, -19704, 810 ), ( 0, 15.99, 0 ), "crf_z_rng_3_mrp_point_15" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_r_props_create_script";
    fe [[ f ]]( s, us, cf, ( -198, -19668, 810 ), ( 0, 15.99, 0 ), "crf_z_rng_3_mrp_point_16" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_r_props_create_script";
    fe [[ f ]]( s, us, cf, ( 34, -19462, 810 ), ( 0, 107.99, 0 ), "crf_z_rng_3_mrp_point_18" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_r_props_create_script";
    fe [[ f ]]( s, us, cf, ( 18, -19606, 810 ), ( 0, 15.99, 0 ), "crf_z_rng_3_mrp_point_17" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_r_props_create_script";
    fe [[ f ]]( s, us, cf, ( -38, -19238, 840 ), ( 0, 107.99, 0 ), "crf_z_rng_3_mrp_point_19" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_r_props_create_script";
    fe [[ f ]]( s, us, cf, ( -170, -18566, 930 ), ( 0, 107.99, 0 ), "crf_z_rng_3_mrp_point_21" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_r_props_create_script";
    fe [[ f ]]( s, us, cf, ( -134, -18940, 878 ), ( 0, 97.99, 0 ), "crf_z_rng_3_mrp_point_20" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_r_props_create_script";
    fe [[ f ]]( s, us, cf, ( -148, -21194, 580 ), ( 0, 2, 0 ), "crf_z_rng_3_mrp_point_0" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_r_props_create_script";
    fe [[ f ]]( s, us, cf, ( -448, -18092, 930 ), ( 0, 285.99, 0 ), "crf_z_rng_4_orion_spawn" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_r_props_create_script";
    fe [[ f ]]( s, us, cf, ( -88, -18066, 930 ), ( 0, 275.99, 0 ), "crf_z_rng_4_orion_spawn" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_r_props_create_script";
    fe [[ f ]]( s, us, cf, ( -166.61, -23524.8, 192 ), ( 0, 70, 0 ), "crf_rng_2_flame" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_r_props_create_script";
    fe [[ f ]]( s, us, cf, ( -236, -20382, 702 ), ( 0, 0, 0 ), "crf_z_rng_5" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_r_props_create_script";
    fe [[ f ]]( s, us, cf, ( -356, -19986, 768 ), ( 0, 282, 0 ), "crf_rng_5_flame" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_r_props_create_script";
    fe [[ f ]]( s, us, cf, ( -306, -19976, 768 ), ( 0, 282, 0 ), "crf_rng_5_flame" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_r_props_create_script";
    fe [[ f ]]( s, us, cf, ( -262, -19968, 768 ), ( 0, 282, 0 ), "crf_rng_5_flame" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_r_props_create_script";
    fe [[ f ]]( s, us, cf, ( -316, -18252, 922 ), ( 0, 12, 0 ), "crf_z_rng_6" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_r_props_create_script";
    fe [[ f ]]( s, us, cf, ( -112.49, -23510.9, 204 ), ( 0, 70, 0 ), "crf_rng_2_flame" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_r_props_create_script";
    fe [[ f ]]( s, us, cf, ( 565.38, -19930.5, 686 ), ( 0, 228, 0 ), "crf_rng_5_flame" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_r_props_create_script";
    fe [[ f ]]( s, us, cf, ( 602.86, -19965.1, 686 ), ( 0, 228, 0 ), "crf_rng_5_flame" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_r_props_create_script";
    fe [[ f ]]( s, us, cf, ( 635.19, -19996, 686 ), ( 0, 228, 0 ), "crf_rng_5_flame" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_r_props_create_script";
    fe [[ f ]]( s, us, cf, ( -207.53, -23539.5, 184 ), ( 0, 70, 0 ), "crf_rng_2_flame" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_r_props_create_script";
    fe [[ f ]]( s, us, cf, ( 985.88, -20828, 534 ), ( 0, 134, 0 ), "crf_rng_5_flame" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_r_props_create_script";
    fe [[ f ]]( s, us, cf, ( 956.16, -20856, 534 ), ( 0, 134, 0 ), "crf_rng_5_flame" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_r_props_create_script";
    fe [[ f ]]( s, us, cf, ( 919.03, -20891, 534 ), ( 0, 134, 0 ), "crf_rng_5_flame" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_r_props_create_script";
    fe [[ f ]]( s, us, cf, ( -66.07, -23508.2, 204 ), ( 0, 70, 0 ), "crf_rng_2_flame" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_r_props_create_script";
    fe [[ f ]]( s, us, cf, ( -17.86, -23510.3, 204 ), ( 0, 70, 0 ), "crf_rng_2_flame" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_r_props_create_script";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( 12.11, -23515.1, 204 ), ( 0, 70, 0 ), "crf_rng_2_flame" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_r_props_create_script";
    fe [[ f ]]( s, us, cf, ( 1015.03, -20799, 534 ), ( 0, 134, 0 ), "crf_rng_5_flame" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_r_props_create_script";
    fe [[ f ]]( s, us, cf, ( 346.06, -21282.5, 568 ), ( 0, 94, 0 ), "crf_rng_5_flame" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_r_props_create_script";
    fe [[ f ]]( s, us, cf, ( 305.3, -21284.8, 568 ), ( 0, 94, 0 ), "crf_rng_5_flame" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_r_props_create_script";
    fe [[ f ]]( s, us, cf, ( -613.9, -21100.2, 542 ), ( 0, 6, 0 ), "crf_rng_5_flame" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_r_props_create_script";
    fe [[ f ]]( s, us, cf, ( 437.97, -21276.1, 568 ), ( 0, 94, 0 ), "crf_rng_5_flame" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_r_props_create_script";
    fe [[ f ]]( s, us, cf, ( 387.03, -21279, 568 ), ( 0, 94, 0 ), "crf_rng_5_flame" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_r_props_create_script";
    fe [[ f ]]( s, us, cf, ( -600.74, -20770, 562 ), ( 0, 356, 0 ), "crf_rng_5_flame" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_r_props_create_script";
    fe [[ f ]]( s, us, cf, ( -600.47, -21232.5, 542 ), ( 0, 6, 0 ), "crf_rng_5_flame" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_r_props_create_script";
    fe [[ f ]]( s, us, cf, ( -604.29, -21191.8, 542 ), ( 0, 6, 0 ), "crf_rng_5_flame" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_r_props_create_script";
    fe [[ f ]]( s, us, cf, ( -608.97, -21141, 542 ), ( 0, 6, 0 ), "crf_rng_5_flame" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_r_props_create_script";
    fe [[ f ]]( s, us, cf, ( -607.19, -20861.8, 562 ), ( 0, 356, 0 ), "crf_rng_5_flame" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_r_props_create_script";
    fe [[ f ]]( s, us, cf, ( -602.97, -20811, 562 ), ( 0, 356, 0 ), "crf_rng_5_flame" );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace zm_sat_hornet_r_props_create_script
// Params 0, eflags: 0x4
// Checksum 0xbb6921a2, Offset: 0x19c1
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace zm_sat_hornet_r_props_create_script
// Params 0
// Checksum 0xf567e4d8, Offset: 0x19cb
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "zm_sat_hornet_r_props_create_script" );
}

