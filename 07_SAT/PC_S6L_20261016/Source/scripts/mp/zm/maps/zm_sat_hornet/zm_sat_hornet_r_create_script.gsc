// scripts\mp\zm\maps\zm_sat_hornet\zm_sat_hornet_r_create_script.gsc  (hash_712a7ccccb602cd9.gscc) (size: 5331 Bytes / 0x14d3 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x6191c887 (1636944007)
// size ...... 5331 (0x14d3)
// includes .. 3   (offset: 0x120f)
// strings ... 27  (offset: 0x1227)
// dev strs .. 0   (offset: 0x14d3)
// exports ... 9   (offset: 0xe47)
// cseg ...... 0x24b + 0xbfc (0xe47)
// imports ... 21  (offset: 0xfaf)
// animtree1 . 0   (offset: 0x14d3)
// animtree2 . 0   (offset: 0x14d3)
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace zm_sat_hornet_r_create_script;

// Namespace zm_sat_hornet_r_create_script
// Params 0, eflags: 0x5
// Checksum 0x6fa04ee8, Offset: 0x269
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"zm_sat_hornet_r_create_script", undefined, &function_b39ecd3d51489472, undefined );
}

// Namespace zm_sat_hornet_r_create_script
// Params 0, eflags: 0x4
// Checksum 0x70d36b38, Offset: 0x28a
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace zm_sat_hornet_r_create_script
// Params 0, eflags: 0x4
// Checksum 0xf5e8b8d4, Offset: 0x29b
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace zm_sat_hornet_r_create_script
// Params 2
// Checksum 0x4501ee9d, Offset: 0x2ac
// Size: 0x80
function main( unused, unused2 )
{
    if ( utility::flag_exist( "zm_sat_hornet_r_create_script" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "zm_sat_hornet_r_create_script" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "zm_sat_hornet_r_create_script" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "zm_sat_hornet_r_create_script" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace zm_sat_hornet_r_create_script
// Params 3, eflags: 0x4
// Checksum 0x766a0c1b, Offset: 0x334
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "zm_sat_hornet_r_create_script" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "zm_sat_hornet_r_create_script" );
}

// Namespace zm_sat_hornet_r_create_script
// Params 3, eflags: 0x4
// Checksum 0x95b72b96, Offset: 0x3ae
// Size: 0xa79
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "zm_sat_hornet_r_create_script";
    s.name = "green_portal";
    s.script_int = int( 1 );
    fe [[ f ]]( s, us, cf, ( 3116.69, -22115.4, 475.88 ), ( 89.9, 165.9, 0 ), "relic_green_portal" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_r_create_script";
    s.name = "green_warp";
    fe [[ f ]]( s, us, cf, ( 3065.84, -22569.4, 292.87 ), ( 0, 233, 0 ), "green_warp_1" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_r_create_script";
    s.name = "green_warp";
    fe [[ f ]]( s, us, cf, ( 3074.34, -22570.5, 343.77 ), ( 0, 0, 0 ), undefined, "green_warp_1", "relic_warp_loc_1" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_r_create_script";
    s.name = "green_warp";
    fe [[ f ]]( s, us, cf, ( 3024.75, -22538.2, 292.87 ), ( 0, 233, 0 ), "green_warp_1" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_r_create_script";
    s.name = "green_warp";
    fe [[ f ]]( s, us, cf, ( 3098.76, -22594.5, 292.87 ), ( 0, 233, 0 ), "green_warp_1" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_r_create_script";
    s.name = "green_warp";
    fe [[ f ]]( s, us, cf, ( 3129.94, -22618.2, 292.87 ), ( 0, 233, 0 ), "green_warp_1" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_r_create_script";
    s.name = "yellow_portal";
    s.script_int = int( 1 );
    fe [[ f ]]( s, us, cf, ( -952.86, -20709.7, 587.14 ), ( 88.7, 3.1, -0 ), "relic_yellow_portal" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_r_create_script";
    s.name = "yellow_portal";
    s.script_int = int( 0 );
    fe [[ f ]]( s, us, cf, ( -2210.59, -21741.5, 328.5 ), ( 88.9, 85.9, 0 ), "relic_yellow_portal" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_r_create_script";
    s.name = "yellow_warp";
    fe [[ f ]]( s, us, cf, ( -458.55, -21154.5, 570.97 ), ( 0, 48.8, 0 ), "yellow_warp_1" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_r_create_script";
    s.name = "yellow_warp";
    fe [[ f ]]( s, us, cf, ( -499.81, -21116.4, 613.45 ), ( 0, 48.8, 0 ), "yellow_warp_1", "yellow_warp_1", "relic_warp_loc_2" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_r_create_script";
    s.name = "yellow_warp";
    fe [[ f ]]( s, us, cf, ( -488.65, -21128.2, 570.97 ), ( 0, 48.8, 0 ), "yellow_warp_1" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_r_create_script";
    s.name = "yellow_warp";
    fe [[ f ]]( s, us, cf, ( -515.57, -21104.8, 570.97 ), ( 0, 48.8, 0 ), "yellow_warp_1" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_r_create_script";
    s.name = "yellow_warp";
    fe [[ f ]]( s, us, cf, ( -543.28, -21080.7, 570.97 ), ( 0, 48.8, 0 ), "yellow_warp_1" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_r_create_script";
    s.name = "red_portal";
    s.script_int = int( 1 );
    fe [[ f ]]( s, us, cf, ( 501.46, -17192.6, 1226.19 ), ( 89.7, 9.8, 88.31 ), "relic_red_portal" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_r_create_script";
    s.name = "red_portal";
    s.script_int = int( 0 );
    fe [[ f ]]( s, us, cf, ( 138.52, -18636, 1235.61 ), ( 89.5, 10.89, -0.01 ), "relic_red_portal" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_r_create_script";
    s.name = "red_warp";
    fe [[ f ]]( s, us, cf, ( -112.42, -17097.7, 1216.85 ), ( 0, 278.9, 0 ), "red_warp_1" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_r_create_script";
    s.name = "red_warp";
    fe [[ f ]]( s, us, cf, ( -48.95, -17086.6, 1264.41 ), ( 0, 278.9, 0 ), undefined, "red_warp_1", "relic_warp_loc_3" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_r_create_script";
    s.name = "red_warp";
    fe [[ f ]]( s, us, cf, ( -65.94, -17091.6, 1216.85 ), ( 0, 278.9, 0 ), "red_warp_1" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_r_create_script";
    s.name = "red_warp";
    fe [[ f ]]( s, us, cf, ( -25.45, -17086.5, 1216.85 ), ( 0, 278.9, 0 ), "red_warp_1" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_r_create_script";
    s.name = "red_warp";
    fe [[ f ]]( s, us, cf, ( 12.11, -17081.7, 1216.85 ), ( 0, 278.9, 0 ), "red_warp_1" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_r_create_script";
    s.name = "mrp_events";
    fe [[ f ]]( s, us, cf, ( 2196.3, -20786.4, 720.36 ), ( 1.18, 258.72, 1.38 ), "mrp_event", "mrp_event_reward_1" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_r_create_script";
    s.name = "mrp_events";
    fe [[ f ]]( s, us, cf, ( -133.2, -20390.5, 1540.62 ), ( 0.52, 108.09, 0.6 ), "mrp_event", "mrp_event_reward_0", "castle_mrp_event" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_r_create_script";
    s.name = "mrp_event_reward";
    fe [[ f ]]( s, us, cf, ( -199.15, -19657.4, 776.21 ), ( 0, 0, 0 ), "mrp_event_reward_0", undefined, "mrp_event_reward" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_r_create_script";
    s.name = "mrp_event_reward";
    fe [[ f ]]( s, us, cf, ( 2042.86, -20926.6, 394.64 ), ( 0, 0, 0 ), "mrp_event_reward_1", undefined, "mrp_event_reward" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_r_create_script";
    s.name = "mrp_events";
    fe [[ f ]]( s, us, cf, ( 2747.5, -23289.9, 468.15 ), ( 6.4, 135.46, 5.78 ), "mrp_event", "mrp_event_reward_2" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_r_create_script";
    s.name = "mrp_event_reward";
    fe [[ f ]]( s, us, cf, ( 2281.97, -22871.6, 160.66 ), ( 0.36, 138.79, -7.64 ), "mrp_event_reward_2", undefined, "mrp_event_reward" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_r_create_script";
    s.name = "mrp_events";
    fe [[ f ]]( s, us, cf, ( -700.53, -25192.5, 798.78 ), ( 33.81, 68.12, 0.78 ), "mrp_event", "mrp_event_reward_3" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_r_create_script";
    s.name = "mrp_event_reward";
    fe [[ f ]]( s, us, cf, ( -183.25, -24652.9, 301.12 ), ( 2.26, 149.62, 17.14 ), "mrp_event_reward_3", undefined, "mrp_event_reward" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_r_create_script";
    s.name = "mrp_events";
    fe [[ f ]]( s, us, cf, ( -2501.41, -22757, 322.06 ), ( 355.76, 178.34, 1.44 ), "mrp_event", "mrp_event_reward_4" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_r_create_script";
    s.name = "mrp_event_reward";
    fe [[ f ]]( s, us, cf, ( -2836.47, -22573.6, 137.61 ), ( 358.67, 263.88, 0.76 ), "mrp_event_reward_4", undefined, "mrp_event_reward" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_r_create_script";
    s.name = "green_portal";
    s.script_int = int( 0 );
    fe [[ f ]]( s, us, cf, ( 2885.63, -24124.3, 125.46 ), ( 89.9, 299.68, 179.98 ), "relic_green_portal" );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace zm_sat_hornet_r_create_script
// Params 0, eflags: 0x4
// Checksum 0x9e597183, Offset: 0xe2f
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace zm_sat_hornet_r_create_script
// Params 0
// Checksum 0xb439d156, Offset: 0xe39
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "zm_sat_hornet_r_create_script" );
}

