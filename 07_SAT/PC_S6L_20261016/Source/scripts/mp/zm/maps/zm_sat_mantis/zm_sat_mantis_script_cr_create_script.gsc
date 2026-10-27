// scripts\mp\zm\maps\zm_sat_mantis\zm_sat_mantis_script_cr_create_script.gsc  (hash_658fcdc7edde1432.gscc) (size: 7368 Bytes / 0x1cc8 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xb8d4e097 (3100958871)
// size ...... 7368 (0x1cc8)
// includes .. 3   (offset: 0x1878)
// strings ... 54  (offset: 0x1890)
// dev strs .. 0   (offset: 0x1cc8)
// exports ... 9   (offset: 0x14bc)
// cseg ...... 0x382 + 0x113a (0x14bc)
// imports ... 21  (offset: 0x1624)
// animtree1 . 0   (offset: 0x1cc8)
// animtree2 . 0   (offset: 0x1cc8)
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace zm_sat_mantis_script_cr_create_script;

// Namespace zm_sat_mantis_script_cr_create_script
// Params 0, eflags: 0x5
// Checksum 0xb064f47b, Offset: 0x3a0
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"zm_sat_mantis_script_cr_create_script", undefined, &function_b39ecd3d51489472, undefined );
}

// Namespace zm_sat_mantis_script_cr_create_script
// Params 0, eflags: 0x4
// Checksum 0x361833d0, Offset: 0x3c1
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace zm_sat_mantis_script_cr_create_script
// Params 0, eflags: 0x4
// Checksum 0xb323e03c, Offset: 0x3d2
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace zm_sat_mantis_script_cr_create_script
// Params 2
// Checksum 0x3cab675, Offset: 0x3e3
// Size: 0x80
function main( unused, unused2 )
{
    if ( utility::flag_exist( "zm_sat_mantis_script_cr_create_script" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "zm_sat_mantis_script_cr_create_script" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "zm_sat_mantis_script_cr_create_script" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "zm_sat_mantis_script_cr_create_script" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace zm_sat_mantis_script_cr_create_script
// Params 3, eflags: 0x4
// Checksum 0x30a154f3, Offset: 0x46b
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "zm_sat_mantis_script_cr_create_script" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "zm_sat_mantis_script_cr_create_script" );
}

// Namespace zm_sat_mantis_script_cr_create_script
// Params 3, eflags: 0x4
// Checksum 0xba088291, Offset: 0x4e5
// Size: 0xfb7
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_cr_create_script";
    s.name = "mrp_events";
    fe [[ f ]]( s, us, cf, ( 79483.8, -30662.1, -106.66 ), ( 0, 270.9, 0 ), "mrp_event", "mrp_event_reward_1" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_cr_create_script";
    s.name = "mrp_events";
    fe [[ f ]]( s, us, cf, ( 76227.7, -32229.6, 253.79 ), ( 0, 310.8, 0 ), "mrp_event", "mrp_event_reward_0" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_cr_create_script";
    s.name = "mrp_event_reward";
    fe [[ f ]]( s, us, cf, ( 76469.2, -32184.8, -117.29 ), ( 0, 0, 0 ), "mrp_event_reward_0", undefined, "mrp_event_reward" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_cr_create_script";
    s.name = "mrp_event_reward";
    fe [[ f ]]( s, us, cf, ( 79391.2, -31260.3, -121.92 ), ( 0, 0, 0 ), "mrp_event_reward_1", undefined, "mrp_event_reward" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_cr_create_script";
    s.name = "mrp_events";
    fe [[ f ]]( s, us, cf, ( 54630.1, -33725.4, 46.83 ), ( 0, 157.8, 0 ), "mrp_event", "mrp_event_reward_2", "future_mrp_event" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_cr_create_script";
    s.name = "mrp_event_reward";
    fe [[ f ]]( s, us, cf, ( 54128.4, -33379.4, -119.31 ), ( 0, 137.8, 0 ), "mrp_event_reward_2", undefined, "mrp_event_reward" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_cr_create_script";
    s.name = "mrp_events";
    fe [[ f ]]( s, us, cf, ( 56673.4, -30457.9, 158.38 ), ( 4.88, 213.22, -10.64 ), "mrp_event", "mrp_event_reward_3", "future_mrp_event" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_cr_create_script";
    s.name = "mrp_event_reward";
    fe [[ f ]]( s, us, cf, ( 56261.5, -30887.5, -116.91 ), ( 0, 0, 0 ), "mrp_event_reward_3", undefined, "mrp_event_reward" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_cr_create_script";
    s.name = "red_warp";
    fe [[ f ]]( s, us, cf, ( 54915.9, -32136.1, -100.63 ), ( 0, 227, 0 ), "red_warp_1" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_cr_create_script";
    s.name = "red_portal";
    s.script_int = int( 0 );
    fe [[ f ]]( s, us, cf, ( 55430.9, -30596.2, 70.85 ), ( 88.7, 114.09, 180 ), "relic_red_portal" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_cr_create_script";
    s.name = "red_warp";
    fe [[ f ]]( s, us, cf, ( 54942.3, -32163, -41.3 ), ( 0, 228.7, 0 ), undefined, "red_warp_1", "relic_warp_loc_3" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_cr_create_script";
    s.name = "red_warp";
    fe [[ f ]]( s, us, cf, ( 54881, -32104.8, -99.63 ), ( 0, 227, 0 ), "red_warp_1" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_cr_create_script";
    s.name = "red_warp";
    fe [[ f ]]( s, us, cf, ( 54955.2, -32171.6, -101.63 ), ( 0, 227, 0 ), "red_warp_1" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_cr_create_script";
    s.name = "red_warp";
    fe [[ f ]]( s, us, cf, ( 54991.2, -32203.9, -102.63 ), ( 0, 227, 0 ), "red_warp_1" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_cr_create_script";
    s.name = "yellow_warp";
    fe [[ f ]]( s, us, cf, ( 78373.7, -31421.5, -105.44 ), ( 0, 156.3, 0 ), "yellow_warp_1" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_cr_create_script";
    s.name = "yellow_portal";
    s.script_int = int( 0 );
    fe [[ f ]]( s, us, cf, ( 78545.7, -31726.8, -73.54 ), ( 86.3, 59.4, 180 ), "relic_yellow_portal" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_cr_create_script";
    s.name = "yellow_warp";
    fe [[ f ]]( s, us, cf, ( 78392.9, -31450.3, -70.57 ), ( 0, 151.1, 0 ), "relic_warp_loc_2", "yellow_warp_1" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_cr_create_script";
    s.name = "yellow_warp";
    fe [[ f ]]( s, us, cf, ( 78393.2, -31378, -104.44 ), ( 0, 156.3, 0 ), "yellow_warp_1" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_cr_create_script";
    s.name = "yellow_warp";
    fe [[ f ]]( s, us, cf, ( 78354, -31465.4, -106.44 ), ( 0, 156.3, 0 ), "yellow_warp_1" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_cr_create_script";
    s.name = "yellow_warp";
    fe [[ f ]]( s, us, cf, ( 78333.5, -31511.1, -107.44 ), ( 0, 156.3, 0 ), "yellow_warp_1" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_cr_create_script";
    s.name = "green_warp";
    fe [[ f ]]( s, us, cf, ( 77323.8, -29791.9, -94.16 ), ( 0, 299.5, 0 ), "green_warp_1" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_cr_create_script";
    s.name = "green_portal";
    s.script_int = int( 0 );
    fe [[ f ]]( s, us, cf, ( 77724.5, -30509, 70.9 ), ( 88.4, 25, -0 ), "relic_green_portal" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_cr_create_script";
    s.name = "green_warp";
    fe [[ f ]]( s, us, cf, ( 77279.7, -29797.4, -25.73 ), ( 0, 298.5, 0 ), undefined, "green_warp_1", "relic_warp_loc_1" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_cr_create_script";
    s.name = "green_warp";
    fe [[ f ]]( s, us, cf, ( 77388, -29756.6, -93.16 ), ( 0, 299.5, 0 ), "green_warp_1" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_cr_create_script";
    s.name = "green_warp";
    fe [[ f ]]( s, us, cf, ( 77256.3, -29829.1, -95.16 ), ( 0, 299.5, 0 ), "green_warp_1" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_cr_create_script";
    s.name = "green_warp";
    fe [[ f ]]( s, us, cf, ( 77194.7, -29862.9, -96.16 ), ( 0, 299.5, 0 ), "green_warp_1" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_cr_create_script";
    fe [[ f ]]( s, us, cf, ( 55538.6, -30162.4, 204.96 ), ( 0, 65.2, 0 ), "c_md" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_cr_create_script";
    fe [[ f ]]( s, us, cf, ( 56011.4, -31508.3, -120.59 ), ( 0, 149.7, 0 ), "fn_mb" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_cr_create_script";
    fe [[ f ]]( s, us, cf, ( 78537.6, -31508.6, -120.91 ), ( 0, 150.4, 0 ), "pn_mb" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_cr_create_script";
    fe [[ f ]]( s, us, cf, ( 56009.4, -31507.4, -85.19 ), ( 0, 152.1, 0 ), "fn_mb_mrp" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_cr_create_script";
    fe [[ f ]]( s, us, cf, ( 78536.1, -31508.3, -85.54 ), ( 0, 148.7, 0 ), "pn_mb_mrp" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_cr_create_script";
    fe [[ f ]]( s, us, cf, ( 79613.1, -32041.5, -124.08 ), ( 0, 189.5, 0 ), "hh_b" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_cr_create_script";
    fe [[ f ]]( s, us, cf, ( 55739.8, -30320, -126.91 ), ( 0, 65.2, 0 ), "cl_ld" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_cr_create_script";
    fe [[ f ]]( s, us, cf, ( 55432.8, -30041.3, 126.25 ), ( 0, 65.2, 0 ), "cl_st" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_cr_create_script";
    fe [[ f ]]( s, us, cf, ( 54294.2, -29506.8, -127.68 ), ( 0.05, 26, -0.04 ), "tb_f" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_cr_create_script";
    fe [[ f ]]( s, us, cf, ( 54294.2, -29506.8, -179.65 ), ( 0.05, 26, -0.04 ), "tb_st" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_cr_create_script";
    fe [[ f ]]( s, us, cf, ( 54293.4, -29506.3, -71.92 ), ( 357.68, 204.48, -92.65 ), "b_pl" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_cr_create_script";
    fe [[ f ]]( s, us, cf, ( 54298.5, -29513.6, -122.95 ), ( 13.77, 207.7, -78.53 ), "c_pl" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_cr_create_script";
    fe [[ f ]]( s, us, cf, ( 79512.9, -32044.3, -122.75 ), ( 0, 112.7, 0 ), "s_lc" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_cr_create_script";
    fe [[ f ]]( s, us, cf, ( 56006.1, -31505.2, -89.89 ), ( 0.36, 236.2, -90.79 ), "fn_k" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_cr_create_script";
    fe [[ f ]]( s, us, cf, ( 78531.6, -31505.3, -90.2 ), ( 358.55, 234.51, -91.35 ), "pn_k" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_cr_create_script";
    fe [[ f ]]( s, us, cf, ( 79513.9, -32045.3, -142.95 ), ( 0, 112.7, 0 ), "s_l_st" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_cr_create_script";
    fe [[ f ]]( s, us, cf, ( 54812.5, -29755.1, -118.06 ), ( 0, 0, 0 ), "cr_loc_1", undefined, undefined, undefined, undefined, undefined, undefined, 450 );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_cr_create_script";
    fe [[ f ]]( s, us, cf, ( 54033, -32697.5, -122.57 ), ( 0, 0, 0 ), "cr_loc_0", undefined, undefined, undefined, undefined, undefined, undefined, 500 );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_cr_create_script";
    fe [[ f ]]( s, us, cf, ( 56873.5, -32001.5, -117.2 ), ( 0, 0, 0 ), "cr_loc_2", undefined, undefined, undefined, undefined, undefined, undefined, 400 );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_cr_create_script";
    fe [[ f ]]( s, us, cf, ( 78445.9, -30594.3, -115.88 ), ( 0, 0, 0 ), "cr_loc_4", undefined, undefined, undefined, undefined, undefined, undefined, 300 );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_cr_create_script";
    fe [[ f ]]( s, us, cf, ( 79386, -32017, -94 ), ( 0, 120, 0 ), "cr_trial_loc_3", undefined, "cr_trial_loc_3" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_cr_create_script";
    fe [[ f ]]( s, us, cf, ( 77343.9, -31838.6, -133.04 ), ( 0, 0, 0 ), "cr_loc_3", undefined, undefined, undefined, undefined, undefined, undefined, 350 );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_cr_create_script";
    fe [[ f ]]( s, us, cf, ( 77089.8, -32784.8, -115.88 ), ( 0, 0, 0 ), "cr_loc_5", undefined, undefined, undefined, undefined, undefined, undefined, 250 );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_cr_create_script";
    fe [[ f ]]( s, us, cf, ( 54881, -29775, -97 ), ( 0, -75, 0 ), "cr_trial_loc_1", undefined, "cr_trial_loc_1" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_cr_create_script";
    fe [[ f ]]( s, us, cf, ( 76441, -32828, -107 ), ( 0, 45, 0 ), "cr_trial_loc_5", undefined, "cr_trial_loc_5" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_cr_create_script";
    fe [[ f ]]( s, us, cf, ( 56905, -31996, -101 ), ( 0, 90, 0 ), "cr_trial_loc_2", undefined, "cr_trial_loc_2" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_cr_create_script";
    fe [[ f ]]( s, us, cf, ( 77401, -29793, -100 ), ( 0, -90, 0 ), "cr_trial_loc_4", undefined, "cr_trial_loc_4" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_cr_create_script";
    fe [[ f ]]( s, us, cf, ( 53952, -32808, -115 ), ( 0, 30, 0 ), "cr_trial_loc_0", undefined, "cr_trial_loc_0" );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace zm_sat_mantis_script_cr_create_script
// Params 0, eflags: 0x4
// Checksum 0x36f8aaac, Offset: 0x14a4
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace zm_sat_mantis_script_cr_create_script
// Params 0
// Checksum 0xf2f289be, Offset: 0x14ae
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "zm_sat_mantis_script_cr_create_script" );
}

