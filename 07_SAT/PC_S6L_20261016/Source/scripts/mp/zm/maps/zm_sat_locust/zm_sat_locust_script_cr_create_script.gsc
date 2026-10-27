// scripts\mp\zm\maps\zm_sat_locust\zm_sat_locust_script_cr_create_script.gsc  (hash_50a71d9ccb03c77e.gscc) (size: 8191 Bytes / 0x1fff / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x4b080bd8 (1258818520)
// size ...... 8191 (0x1fff)
// includes .. 3   (offset: 0x1b43)
// strings ... 50  (offset: 0x1b5b)
// dev strs .. 0   (offset: 0x1fff)
// exports ... 9   (offset: 0x177b)
// cseg ...... 0x398 + 0x13e3 (0x177b)
// imports ... 21  (offset: 0x18e3)
// animtree1 . 0   (offset: 0x1fff)
// animtree2 . 0   (offset: 0x1fff)
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace zm_sat_locust_script_cr_create_script;

// Namespace zm_sat_locust_script_cr_create_script
// Params 0, eflags: 0x5
// Checksum 0x5123720b, Offset: 0x3b6
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"zm_sat_locust_script_cr_create_script", undefined, &function_b39ecd3d51489472, undefined );
}

// Namespace zm_sat_locust_script_cr_create_script
// Params 0, eflags: 0x4
// Checksum 0x520e26ea, Offset: 0x3d7
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace zm_sat_locust_script_cr_create_script
// Params 0, eflags: 0x4
// Checksum 0xd735f506, Offset: 0x3e8
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace zm_sat_locust_script_cr_create_script
// Params 2
// Checksum 0x67dca34f, Offset: 0x3f9
// Size: 0x80
function main( unused, unused2 )
{
    if ( utility::flag_exist( "zm_sat_locust_script_cr_create_script" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "zm_sat_locust_script_cr_create_script" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "zm_sat_locust_script_cr_create_script" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "zm_sat_locust_script_cr_create_script" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace zm_sat_locust_script_cr_create_script
// Params 3, eflags: 0x4
// Checksum 0x54b741c9, Offset: 0x481
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "zm_sat_locust_script_cr_create_script" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "zm_sat_locust_script_cr_create_script" );
}

// Namespace zm_sat_locust_script_cr_create_script
// Params 3, eflags: 0x4
// Checksum 0xcff78822, Offset: 0x4fb
// Size: 0x1260
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_cr_create_script";
    s.name = "green_portal";
    s.script_int = int( 1 );
    fe [[ f ]]( s, us, cf, ( 4839.74, 3643.94, 235.92 ), ( 89, 64.6, -25.39 ), "relic_green_portal" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_cr_create_script";
    s.name = "green_portal";
    s.script_int = int( 0 );
    fe [[ f ]]( s, us, cf, ( 3033.54, 2752.9, 205.51 ), ( 89, 64.61, -175.49 ), "relic_green_portal" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_cr_create_script";
    s.name = "yellow_portal";
    s.script_int = int( 0 );
    fe [[ f ]]( s, us, cf, ( 1437.8, 6276.74, 293.18 ), ( 89, 64.6, -34.59 ), "relic_yellow_portal" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_cr_create_script";
    s.name = "yellow_portal";
    s.script_int = int( 1 );
    fe [[ f ]]( s, us, cf, ( 2553.11, 6471.99, 301.35 ), ( 89, 64.6, 7.91 ), "relic_yellow_portal" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_cr_create_script";
    s.name = "red_portal";
    s.script_int = int( 0 );
    fe [[ f ]]( s, us, cf, ( 1208.34, 3090.7, 83.83 ), ( 89, 64.6, -56.19 ), "relic_red_portal" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_cr_create_script";
    s.name = "red_portal";
    s.script_int = int( 1 );
    fe [[ f ]]( s, us, cf, ( 1325.5, 1549.28, 206.34 ), ( 89, 64.6, 33.91 ), "relic_red_portal" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_cr_create_script";
    s.name = "red_warp";
    fe [[ f ]]( s, us, cf, ( 1632.83, 1205.99, 223.44 ), ( 0, 95, 0 ), "red_warp_1" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_cr_create_script";
    s.name = "red_warp";
    fe [[ f ]]( s, us, cf, ( 1567.41, 1200.36, 278.49 ), ( 0, 95, 0 ), undefined, "red_warp_1", "relic_warp_loc_3" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_cr_create_script";
    s.name = "red_warp";
    fe [[ f ]]( s, us, cf, ( 1584.58, 1200.76, 223.44 ), ( 0, 95, 0 ), "red_warp_1" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_cr_create_script";
    s.name = "red_warp";
    fe [[ f ]]( s, us, cf, ( 1539.34, 1198.81, 223.44 ), ( 0, 95, 0 ), "red_warp_1" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_cr_create_script";
    s.name = "red_warp";
    fe [[ f ]]( s, us, cf, ( 1489.69, 1195.47, 223.44 ), ( 0, 95, 0 ), "red_warp_1" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_cr_create_script";
    s.name = "green_warp";
    fe [[ f ]]( s, us, cf, ( 4128.61, 3470.25, 113.12 ), ( 0, 116.3, 0 ), "green_warp_1" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_cr_create_script";
    s.name = "green_warp";
    fe [[ f ]]( s, us, cf, ( 4069.7, 3441.24, 168.17 ), ( 0, 116.3, 0 ), undefined, "green_warp_1", "relic_warp_loc_1" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_cr_create_script";
    s.name = "green_warp";
    fe [[ f ]]( s, us, cf, ( 4085.56, 3447.86, 113.12 ), ( 0, 116.3, 0 ), "green_warp_1" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_cr_create_script";
    s.name = "green_warp";
    fe [[ f ]]( s, us, cf, ( 4044.11, 3429.61, 113.12 ), ( 0, 116.3, 0 ), "green_warp_1" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_cr_create_script";
    s.name = "green_warp";
    fe [[ f ]]( s, us, cf, ( 3999.07, 3408.46, 113.12 ), ( 0, 116.3, 0 ), "green_warp_1" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_cr_create_script";
    s.name = "yellow_warp";
    fe [[ f ]]( s, us, cf, ( 1822.71, 5076.85, 255.75 ), ( 0, 89.4, 0 ), "yellow_warp_1" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_cr_create_script";
    s.name = "yellow_warp";
    fe [[ f ]]( s, us, cf, ( 1757.05, 5077.63, 310.8 ), ( 0, 89.4, 0 ), "yellow_warp_1", "yellow_warp_1", "relic_warp_loc_2" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_cr_create_script";
    s.name = "yellow_warp";
    fe [[ f ]]( s, us, cf, ( 1774.19, 5076.36, 255.75 ), ( 0, 89.4, 0 ), "yellow_warp_1" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_cr_create_script";
    s.name = "yellow_warp";
    fe [[ f ]]( s, us, cf, ( 1728.97, 5078.84, 255.75 ), ( 0, 89.4, 0 ), "yellow_warp_1" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_cr_create_script";
    s.name = "yellow_warp";
    fe [[ f ]]( s, us, cf, ( 1679.23, 5080.36, 255.75 ), ( 0, 89.4, 0 ), "yellow_warp_1" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_cr_create_script";
    s.name = "mrp_events";
    fe [[ f ]]( s, us, cf, ( -975.38, 2518.79, 100.57 ), ( 357.24, 39.63, -2.21 ), "mrp_event", "mrp_event_reward_0" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_cr_create_script";
    s.name = "mrp_events";
    fe [[ f ]]( s, us, cf, ( 611.75, -644.53, 1160.4 ), ( 353.04, 39.79, 8.28 ), "mrp_event", "mrp_event_reward_1" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_cr_create_script";
    s.name = "mrp_event_reward";
    fe [[ f ]]( s, us, cf, ( 1765.24, 1005.81, 237.56 ), ( 0, 0, 0 ), "mrp_event_reward_1", undefined, "mrp_event_reward" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_cr_create_script";
    s.name = "mrp_event_reward";
    fe [[ f ]]( s, us, cf, ( -659.22, 2707.95, -141.74 ), ( 0, 0, 0 ), "mrp_event_reward_0", undefined, "mrp_event_reward" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_cr_create_script";
    s.name = "mrp_events";
    fe [[ f ]]( s, us, cf, ( -871.72, 4932.86, 660.2 ), ( 358.79, 333, 14.42 ), "mrp_event", "mrp_event_reward_2" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_cr_create_script";
    s.name = "mrp_event_reward";
    fe [[ f ]]( s, us, cf, ( -599.29, 4942.36, 183.91 ), ( 0, 0, 0 ), "mrp_event_reward_2", undefined, "mrp_event_reward" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_cr_create_script";
    s.name = "mrp_events";
    fe [[ f ]]( s, us, cf, ( 1556.2, 6061.19, 360.69 ), ( 1.41, 6.4, -4.32 ), "mrp_event", "mrp_event_reward_3" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_cr_create_script";
    s.name = "mrp_event_reward";
    fe [[ f ]]( s, us, cf, ( 1740.79, 5916.67, 74.77 ), ( 0, 0, 0 ), "mrp_event_reward_3", undefined, "mrp_event_reward" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_cr_create_script";
    s.name = "mrp_events";
    fe [[ f ]]( s, us, cf, ( 4807.11, 7021.56, 477.96 ), ( 357.57, 316.14, 1.66 ), "mrp_event", "mrp_event_reward_4" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_cr_create_script";
    s.name = "mrp_event_reward";
    fe [[ f ]]( s, us, cf, ( 4832.2, 6867.64, 297.17 ), ( 0, 0, 0 ), "mrp_event_reward_4", undefined, "mrp_event_reward" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_cr_create_script";
    s.name = "mrp_events";
    fe [[ f ]]( s, us, cf, ( 5666.2, 3927.76, 512.23 ), ( 2.92, 176.98, 0.34 ), "mrp_event", "mrp_event_reward_5" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_cr_create_script";
    s.name = "mrp_event_reward";
    fe [[ f ]]( s, us, cf, ( 5496.46, 3926.09, 159.42 ), ( 0, 0, 0 ), "mrp_event_reward_5", undefined, "mrp_event_reward" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_cr_create_script";
    s.name = "mrp_events";
    fe [[ f ]]( s, us, cf, ( 5166.76, 2658.34, 121.48 ), ( 2.92, 176.98, 6.73 ), "mrp_event", "mrp_event_reward_6" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_cr_create_script";
    s.name = "mrp_event_reward";
    fe [[ f ]]( s, us, cf, ( 4575.21, 2654.48, 190.78 ), ( 0, 0, 0 ), "mrp_event_reward_6", undefined, "mrp_event_reward" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_cr_create_script";
    s.name = "mrp_events";
    fe [[ f ]]( s, us, cf, ( 3361.04, -127.28, 98.94 ), ( 2.92, 356.38, 0.73 ), "mrp_event", "mrp_event_reward_7" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_cr_create_script";
    s.name = "mrp_event_reward";
    fe [[ f ]]( s, us, cf, ( 3806.95, -8.1, 178.33 ), ( 0, 179.4, 0 ), "mrp_event_reward_7", undefined, "mrp_event_reward" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_cr_create_script";
    fe [[ f ]]( s, us, cf, ( 4119.13, 5953.44, 221.75 ), ( 0, 57.2, 0 ), "crf_z_5", undefined, undefined, undefined, undefined, undefined, undefined, 250 );
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_cr_create_script";
    fe [[ f ]]( s, us, cf, ( 3996.36, 3583.38, 102.86 ), ( 0, 106, 0 ), "crf_z_4", undefined, undefined, undefined, undefined, undefined, undefined, 300 );
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_cr_create_script";
    fe [[ f ]]( s, us, cf, ( 6018.96, 1623.98, 117.48 ), ( 0, 262, 0 ), "crf_z_3", undefined, undefined, undefined, undefined, undefined, undefined, 350 );
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_cr_create_script";
    fe [[ f ]]( s, us, cf, ( 2460.59, 5675.47, 263.57 ), ( 0, 258.8, 0 ), "crf_z_0", undefined, undefined, undefined, undefined, undefined, undefined, 500 );
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_cr_create_script";
    fe [[ f ]]( s, us, cf, ( -662.34, 7423.49, 261.21 ), ( 0, 0, 0 ), "crf_z_1", undefined, undefined, undefined, undefined, undefined, undefined, 450 );
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_cr_create_script";
    fe [[ f ]]( s, us, cf, ( 1326.11, 1965.21, 159.55 ), ( 0, 64.2, 0 ), "crf_z_2", undefined, undefined, undefined, undefined, undefined, undefined, 400 );
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_cr_create_script";
    s.groupid = "Trial eggs";
    fe [[ f ]]( s, us, cf, ( 837.06, 7705.32, 468.23 ), ( 0, 0, 0 ), "ct_mb_l_3" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_cr_create_script";
    s.groupid = "Trial eggs";
    fe [[ f ]]( s, us, cf, ( 985.38, 2572.87, 171.53 ), ( 0, 0, 0 ), "ct_mb_l_1" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_cr_create_script";
    s.groupid = "Trial eggs";
    fe [[ f ]]( s, us, cf, ( 895.33, 2447.07, 348.05 ), ( 0, 0, 0 ), "ct_mb_m_1" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_cr_create_script";
    s.groupid = "Trial eggs";
    fe [[ f ]]( s, us, cf, ( 776.85, 2202.19, 390.35 ), ( 0, 0, 0 ), "ct_mb_1" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_cr_create_script";
    s.groupid = "Trial eggs";
    fe [[ f ]]( s, us, cf, ( 7774.47, 1766.06, 364.96 ), ( 1.1, 0, 0 ), "ct_mb_m_2" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_cr_create_script";
    s.groupid = "Trial eggs";
    fe [[ f ]]( s, us, cf, ( 294.69, 7946.64, 439.34 ), ( 0, 0, 0 ), "ct_mb_3" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_cr_create_script";
    s.groupid = "Trial eggs";
    fe [[ f ]]( s, us, cf, ( 7402.48, 1524.74, 471.54 ), ( 1.1, 0, 0 ), "ct_mb_2" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_cr_create_script";
    s.groupid = "Trial eggs";
    fe [[ f ]]( s, us, cf, ( 5454.9, 5661.44, 403.53 ), ( 15.1, 0, 0 ), "ct_mb_4" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_cr_create_script";
    s.groupid = "Trial eggs";
    fe [[ f ]]( s, us, cf, ( 5147.35, 5506.42, 260.88 ), ( 1.1, 0, 0 ), "ct_mb_l_4" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_cr_create_script";
    s.groupid = "Trial eggs";
    fe [[ f ]]( s, us, cf, ( 7792.14, 2035.65, 112.93 ), ( 1.1, 0, 0 ), "ct_mb_l_2" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_cr_create_script";
    s.groupid = "Trial eggs";
    fe [[ f ]]( s, us, cf, ( 5278.53, 5576.91, 422.33 ), ( 1.1, 0, 0 ), "ct_mb_m_4" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_cr_create_script";
    s.groupid = "Trial eggs";
    fe [[ f ]]( s, us, cf, ( 603.55, 7796.17, 559.98 ), ( 0, 0, 0 ), "ct_mb_m_3" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_cr_create_script";
    s.name = "mrp_events";
    fe [[ f ]]( s, us, cf, ( 6938.27, 1279.05, 1007.9 ), ( 359, 192.86, 1.82 ), "mrp_event", "mrp_event_reward_8", "zone_lighthouse_mrp_event" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_cr_create_script";
    s.name = "mrp_event_reward";
    fe [[ f ]]( s, us, cf, ( 6587.91, 1182.63, 473.27 ), ( 0, 0, 0 ), "mrp_event_reward_8", undefined, "mrp_event_reward" );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace zm_sat_locust_script_cr_create_script
// Params 0, eflags: 0x4
// Checksum 0x11137266, Offset: 0x1763
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace zm_sat_locust_script_cr_create_script
// Params 0
// Checksum 0x96e49c84, Offset: 0x176d
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "zm_sat_locust_script_cr_create_script" );
}

