// scripts\mp\zm\systems\relics\zm_relic_ruby_ee_challenges_cs.gsc  (hash_2e398d6009316a2b.gscc) (size: 8436 Bytes / 0x20f4 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x2aebbac3 (720091843)
// size ...... 8436 (0x20f4)
// includes .. 3   (offset: 0x1c24)
// strings ... 46  (offset: 0x1c3c)
// dev strs .. 0   (offset: 0x20f4)
// exports ... 9   (offset: 0x188c)
// cseg ...... 0x3a0 + 0x14ec (0x188c)
// imports ... 20  (offset: 0x19f4)
// animtree1 . 0   (offset: 0x20f4)
// animtree2 . 0   (offset: 0x20f4)
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace zm_relic_ruby_ee_challenges_cs;

// Namespace zm_relic_ruby_ee_challenges_cs
// Params 0, eflags: 0x5
// Checksum 0x29702cda, Offset: 0x3be
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"zm_relic_ruby_ee_challenges_cs", undefined, &function_b39ecd3d51489472, undefined );
}

// Namespace zm_relic_ruby_ee_challenges_cs
// Params 0, eflags: 0x4
// Checksum 0xc728cf24, Offset: 0x3df
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace zm_relic_ruby_ee_challenges_cs
// Params 0, eflags: 0x4
// Checksum 0x42131cc8, Offset: 0x3f0
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace zm_relic_ruby_ee_challenges_cs
// Params 2
// Checksum 0xf2fa4a81, Offset: 0x401
// Size: 0x80
function main( unused, unused2 )
{
    if ( utility::flag_exist( "zm_relic_ruby_ee_challenges_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "zm_relic_ruby_ee_challenges_cs" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "zm_relic_ruby_ee_challenges_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "zm_relic_ruby_ee_challenges_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace zm_relic_ruby_ee_challenges_cs
// Params 3, eflags: 0x4
// Checksum 0xc191a807, Offset: 0x489
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "zm_relic_ruby_ee_challenges_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "zm_relic_ruby_ee_challenges_cs" );
}

// Namespace zm_relic_ruby_ee_challenges_cs
// Params 3, eflags: 0x4
// Checksum 0x2efcb8be, Offset: 0x503
// Size: 0x1369
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "zm_relic_ruby_ee_challenges_cs";
    fe [[ f ]]( s, us, cf, ( 3943, -42039, -12932 ), ( 0, 0, 0 ), "explosive_vertex" );
    s = {};
    s.script_cs_flag = "zm_relic_ruby_ee_challenges_cs";
    fe [[ f ]]( s, us, cf, ( -101, 287, 428.25 ), ( 0, 0, 0 ), "relic_wax", undefined, "nw" );
    s = {};
    s.script_cs_flag = "zm_relic_ruby_ee_challenges_cs";
    fe [[ f ]]( s, us, cf, ( 4120, -41719, -12932 ), ( 0, 0, 0 ), "explosive_vertex" );
    s = {};
    s.script_cs_flag = "zm_relic_ruby_ee_challenges_cs";
    fe [[ f ]]( s, us, cf, ( 4313, -42027, -12932 ), ( 0, 0, 0 ), "explosive_vertex" );
    s = {};
    s.script_cs_flag = "zm_relic_ruby_ee_challenges_cs";
    fe [[ f ]]( s, us, cf, ( 4121, -41929, -12930 ), ( 0, 0, 0 ), "explosive_center", undefined, undefined, undefined, undefined, undefined, undefined, 250 );
    s = {};
    s.script_cs_flag = "zm_relic_ruby_ee_challenges_cs";
    fe [[ f ]]( s, us, cf, ( -496.25, 275, 428.25 ), ( 0, 0, 0 ), "relic_wax", undefined, "sw" );
    s = {};
    s.script_cs_flag = "zm_relic_ruby_ee_challenges_cs";
    fe [[ f ]]( s, us, cf, ( -391.75, -720, 428.25 ), ( 0, 0, 0 ), "relic_wax", undefined, "se" );
    s = {};
    s.script_cs_flag = "zm_relic_ruby_ee_challenges_cs";
    fe [[ f ]]( s, us, cf, ( -9, -679.75, 428.25 ), ( 0, 0, 0 ), "relic_wax", undefined, "ne" );
    s = {};
    s.script_cs_flag = "zm_relic_ruby_ee_challenges_cs";
    fe [[ f ]]( s, us, cf, ( -150.75, 281.75, 428.25 ), ( 0, 0, 0 ), "relic_wax", undefined, "nw" );
    s = {};
    s.script_cs_flag = "zm_relic_ruby_ee_challenges_cs";
    fe [[ f ]]( s, us, cf, ( -527.25, 271.75, 428.25 ), ( 0, 0, 0 ), "relic_wax", undefined, "sw" );
    s = {};
    s.script_cs_flag = "zm_relic_ruby_ee_challenges_cs";
    fe [[ f ]]( s, us, cf, ( -506.75, 226, 428.25 ), ( 0, 0, 0 ), "relic_wax", undefined, "sw" );
    s = {};
    s.script_cs_flag = "zm_relic_ruby_ee_challenges_cs";
    fe [[ f ]]( s, us, cf, ( -46, -713.25, 428.25 ), ( 0, 0, 0 ), "relic_wax", undefined, "ne" );
    s = {};
    s.script_cs_flag = "zm_relic_ruby_ee_challenges_cs";
    fe [[ f ]]( s, us, cf, ( -2768.75, -18.75, -10.17 ), ( 8.7, 328, 0 ), "relic_h_l", undefined, "nw" );
    s = {};
    s.script_cs_flag = "zm_relic_ruby_ee_challenges_cs";
    fe [[ f ]]( s, us, cf, ( -2797.25, -77, -8.17 ), ( 8.7, 328, 0 ), "relic_h_r", undefined, "ne" );
    s = {};
    s.script_cs_flag = "zm_relic_ruby_ee_challenges_cs";
    fe [[ f ]]( s, us, cf, ( -2966.22, 90.23, 33.08 ), ( 351, 148, 0 ), "relic_b_l", undefined, "sw" );
    s = {};
    s.script_cs_flag = "zm_relic_ruby_ee_challenges_cs";
    fe [[ f ]]( s, us, cf, ( -3003.22, 13.73, 35.08 ), ( 351, 148, 0 ), "relic_b_r", undefined, "se" );
    s = {};
    s.script_cs_flag = "zm_relic_ruby_ee_challenges_cs";
    fe [[ f ]]( s, us, cf, ( 1533, -2722, 164 ), ( 270, 0, 0 ), "relic_light", "cspf_0_auto7239360210979945757" );
    s = {};
    s.script_cs_flag = "zm_relic_ruby_ee_challenges_cs";
    fe [[ f ]]( s, us, cf, ( 4263, -1837, 145 ), ( 0, -5, 90 ), "relic_light", "cspf_0_auto7513889848973028199" );
    s = {};
    s.script_cs_flag = "zm_relic_ruby_ee_challenges_cs";
    fe [[ f ]]( s, us, cf, ( 777, 547, 430 ), ( 0, 5, 90 ), "relic_light", "cspf_0_auto4016445230085869756" );
    s = {};
    s.script_cs_flag = "zm_relic_ruby_ee_challenges_cs";
    fe [[ f ]]( s, us, cf, ( 1539, -2722, 164 ), ( 0, 0, 0 ), "cspf_0_auto7239360210979945757" );
    s = {};
    s.script_cs_flag = "zm_relic_ruby_ee_challenges_cs";
    fe [[ f ]]( s, us, cf, ( 4263.5, -1831.5, 145 ), ( 0, 85, 0 ), "cspf_0_auto7513889848973028199" );
    s = {};
    s.script_cs_flag = "zm_relic_ruby_ee_challenges_cs";
    fe [[ f ]]( s, us, cf, ( 776.5, 552.5, 430 ), ( 0, 95, 0 ), "cspf_0_auto4016445230085869756" );
    s = {};
    s.script_cs_flag = "zm_relic_ruby_ee_challenges_cs";
    fe [[ f ]]( s, us, cf, ( 4120, -40432, -12588 ), ( 0, 0, 0 ), "mars_portal_pos", undefined, undefined, undefined, undefined, undefined, undefined, 100 );
    s = {};
    s.script_cs_flag = "zm_relic_ruby_ee_challenges_cs";
    fe [[ f ]]( s, us, cf, ( 1080, -2695, 129 ), ( 0, 0, 0 ), "cannon_source" );
    s = {};
    s.script_cs_flag = "zm_relic_ruby_ee_challenges_cs";
    fe [[ f ]]( s, us, cf, ( 2105, -2597, 64 ), ( 0, 0, 0 ), "relic_weapon" );
    s = {};
    s.script_cs_flag = "zm_relic_ruby_ee_challenges_cs";
    fe [[ f ]]( s, us, cf, ( 1730, 826, 260.07 ), ( 0, 0, 0 ), "relic_weapon" );
    s = {};
    s.script_cs_flag = "zm_relic_ruby_ee_challenges_cs";
    fe [[ f ]]( s, us, cf, ( 3765, -1754, 24 ), ( 0, 0, 0 ), "relic_weapon" );
    s = {};
    s.script_cs_flag = "zm_relic_ruby_ee_challenges_cs";
    fe [[ f ]]( s, us, cf, ( 4184, -1516, -72 ), ( 0, 0, 0 ), "relic_weapon" );
    s = {};
    s.script_cs_flag = "zm_relic_ruby_ee_challenges_cs";
    fe [[ f ]]( s, us, cf, ( 240, -2408, 208 ), ( 0, 0, 0 ), "relic_weapon" );
    s = {};
    s.script_cs_flag = "zm_relic_ruby_ee_challenges_cs";
    fe [[ f ]]( s, us, cf, ( 705, 2344, 292 ), ( 0, 0, 0 ), "relic_weapon" );
    s = {};
    s.script_cs_flag = "zm_relic_ruby_ee_challenges_cs";
    fe [[ f ]]( s, us, cf, ( 3423.29, -1236.98, 64.68 ), ( 90, 50.19, -74.81 ), "relic_green_portal" );
    s = {};
    s.script_cs_flag = "zm_relic_ruby_ee_challenges_cs";
    fe [[ f ]]( s, us, cf, ( 4989, -837, 64 ), ( 90, 113.15, -60.85 ), "relic_green_portal" );
    s = {};
    s.script_cs_flag = "zm_relic_ruby_ee_challenges_cs";
    fe [[ f ]]( s, us, cf, ( -146, -2297, 248 ), ( 90, 0, 0 ), "relic_yellow_portal" );
    s = {};
    s.script_cs_flag = "zm_relic_ruby_ee_challenges_cs";
    fe [[ f ]]( s, us, cf, ( 1929, -2382, 104 ), ( 90, 197.62, -69.38 ), "relic_yellow_portal" );
    s = {};
    s.script_cs_flag = "zm_relic_ruby_ee_challenges_cs";
    fe [[ f ]]( s, us, cf, ( -898, 243, 298 ), ( 90, 95, 0 ), "relic_red_portal" );
    s = {};
    s.script_cs_flag = "zm_relic_ruby_ee_challenges_cs";
    fe [[ f ]]( s, us, cf, ( -1529, 989, 292 ), ( 90, 305, -60 ), "relic_red_portal" );
    s = {};
    s.script_cs_flag = "zm_relic_ruby_ee_challenges_cs";
    s.name = "mrp_events";
    fe [[ f ]]( s, us, cf, ( -729, -923, 545 ), ( 0, 186, 0 ), "mrp_event", "mrp_event_reward_3" );
    s = {};
    s.script_cs_flag = "zm_relic_ruby_ee_challenges_cs";
    s.name = "mrp_event_reward";
    fe [[ f ]]( s, us, cf, ( -1255, -535, 241 ), ( 0, 180, 0 ), "mrp_event_reward_3", undefined, "mrp_event_reward" );
    s = {};
    s.script_cs_flag = "zm_relic_ruby_ee_challenges_cs";
    s.name = "mrp_events";
    fe [[ f ]]( s, us, cf, ( -1101.41, -1304.41, 240.01 ), ( 0, 30, 0 ), "mrp_event", "mrp_event_reward_4" );
    s = {};
    s.script_cs_flag = "zm_relic_ruby_ee_challenges_cs";
    s.name = "mrp_event_reward";
    fe [[ f ]]( s, us, cf, ( -689, -697, 254 ), ( 0, 180, 0 ), "mrp_event_reward_4", undefined, "mrp_event_reward" );
    s = {};
    s.script_cs_flag = "zm_relic_ruby_ee_challenges_cs";
    s.name = "mrp_events";
    fe [[ f ]]( s, us, cf, ( -280, 222.59, 933.15 ), ( 0, 100, 0 ), "mrp_event", "mrp_event_reward_2" );
    s = {};
    s.script_cs_flag = "zm_relic_ruby_ee_challenges_cs";
    s.name = "mrp_event_reward";
    fe [[ f ]]( s, us, cf, ( -615, 985, 251.89 ), ( 0, 180, 0 ), "mrp_event_reward_2", undefined, "mrp_event_reward" );
    s = {};
    s.script_cs_flag = "zm_relic_ruby_ee_challenges_cs";
    s.name = "mrp_events";
    fe [[ f ]]( s, us, cf, ( -2856.41, 11, 7.01 ), ( 0, -23, 0 ), "mrp_event", "mrp_event_reward_5" );
    s = {};
    s.script_cs_flag = "zm_relic_ruby_ee_challenges_cs";
    s.name = "mrp_event_reward";
    fe [[ f ]]( s, us, cf, ( -2789, 156, -13.26 ), ( 0, 180, 0 ), "mrp_event_reward_5", undefined, "mrp_event_reward" );
    s = {};
    s.script_cs_flag = "zm_relic_ruby_ee_challenges_cs";
    s.name = "mrp_events";
    fe [[ f ]]( s, us, cf, ( 4388, -968.41, 889 ), ( 0, 85, 0 ), "mrp_event", "mrp_event_reward_0" );
    s = {};
    s.script_cs_flag = "zm_relic_ruby_ee_challenges_cs";
    s.name = "mrp_event_reward";
    fe [[ f ]]( s, us, cf, ( 4499, -421, 14.23 ), ( 0, 180, 0 ), "mrp_event_reward_0", undefined, "mrp_event_reward" );
    s = {};
    s.script_cs_flag = "zm_relic_ruby_ee_challenges_cs";
    s.name = "mrp_events";
    fe [[ f ]]( s, us, cf, ( 4232.41, 1257.41, -480 ), ( 0, 220, 0 ), "mrp_event", "mrp_event_reward_1" );
    s = {};
    s.script_cs_flag = "zm_relic_ruby_ee_challenges_cs";
    s.name = "mrp_event_reward";
    fe [[ f ]]( s, us, cf, ( 3918, 844, -47.44 ), ( 0, 180, 0 ), "mrp_event_reward_1", undefined, "mrp_event_reward" );
    s = {};
    s.script_cs_flag = "zm_relic_ruby_ee_challenges_cs";
    s.name = "mrp_events";
    fe [[ f ]]( s, us, cf, ( 1239, -3114.41, 678 ), ( 0, 110, 0 ), "mrp_event", "mrp_event_reward_6" );
    s = {};
    s.script_cs_flag = "zm_relic_ruby_ee_challenges_cs";
    s.name = "mrp_event_reward";
    fe [[ f ]]( s, us, cf, ( 1408, -3060, 202 ), ( 0, 180, 0 ), "mrp_event_reward_6", undefined, "mrp_event_reward" );
    s = {};
    s.script_cs_flag = "zm_relic_ruby_ee_challenges_cs";
    s.name = "yellow_warp";
    fe [[ f ]]( s, us, cf, ( 1410.49, -2767.62, 64 ), ( 0, 165, 0 ), "yellow_warp_1" );
    s = {};
    s.script_cs_flag = "zm_relic_ruby_ee_challenges_cs";
    s.name = "green_warp";
    fe [[ f ]]( s, us, cf, ( 4373.63, -152.88, -44.36 ), ( 0, 135, 0 ), "green_warp_1" );
    s = {};
    s.script_cs_flag = "zm_relic_ruby_ee_challenges_cs";
    s.name = "mrp_events";
    fe [[ f ]]( s, us, cf, ( 4055.75, -40862.4, -12420.2 ), ( 0, 274.3, 0 ), undefined, "mrp_event_reward_7", "zone_temple_mrp_event" );
    s = {};
    s.script_cs_flag = "zm_relic_ruby_ee_challenges_cs";
    fe [[ f ]]( s, us, cf, ( -2811, -33, -4.61 ), ( 0, 155, 0 ), "jump_start_loc", undefined, undefined, undefined, undefined, undefined, undefined, 200 );
    s = {};
    s.script_cs_flag = "zm_relic_ruby_ee_challenges_cs";
    s.name = "red_warp";
    fe [[ f ]]( s, us, cf, ( -2679.51, -161.62, -5.6 ), ( 0, 135, 0 ), "red_warp_1" );
    s = {};
    s.script_cs_flag = "zm_relic_ruby_ee_challenges_cs";
    s.name = "red_warp";
    fe [[ f ]]( s, us, cf, ( -2624.01, -74.93, -4.48 ), ( 0, 155, 0 ), "red_warp_1" );
    s = {};
    s.script_cs_flag = "zm_relic_ruby_ee_challenges_cs";
    s.name = "red_warp";
    fe [[ f ]]( s, us, cf, ( -2732.21, -219.14, -21.7 ), ( 0, 135, 0 ), "red_warp_1" );
    s = {};
    s.script_cs_flag = "zm_relic_ruby_ee_challenges_cs";
    s.name = "red_warp";
    fe [[ f ]]( s, us, cf, ( -2578.61, 10.18, -0.4 ), ( 0, 160, 0 ), "red_warp_1" );
    s = {};
    s.script_cs_flag = "zm_relic_ruby_ee_challenges_cs";
    s.name = "red_warp";
    fe [[ f ]]( s, us, cf, ( -2590.54, -130.47, -4.08 ), ( 0, 0, 0 ), undefined, "red_warp_1", "relic_warp_loc_3" );
    s = {};
    s.script_cs_flag = "zm_relic_ruby_ee_challenges_cs";
    s.name = "yellow_warp";
    fe [[ f ]]( s, us, cf, ( 1417.99, -2662.93, 64 ), ( 0, 180, 0 ), "yellow_warp_1" );
    s = {};
    s.script_cs_flag = "zm_relic_ruby_ee_challenges_cs";
    s.name = "yellow_warp";
    fe [[ f ]]( s, us, cf, ( 1414.79, -2849.14, 64 ), ( 0, 150, 0 ), "yellow_warp_1" );
    s = {};
    s.script_cs_flag = "zm_relic_ruby_ee_challenges_cs";
    s.name = "yellow_warp";
    fe [[ f ]]( s, us, cf, ( 1463.39, -2577.82, 64 ), ( 0, 195, 0 ), "yellow_warp_1" );
    s = {};
    s.script_cs_flag = "zm_relic_ruby_ee_challenges_cs";
    s.name = "yellow_warp";
    fe [[ f ]]( s, us, cf, ( 1451.46, -2718.47, 64 ), ( 0, 0, 0 ), undefined, "yellow_warp_1", "relic_warp_loc_2" );
    s = {};
    s.script_cs_flag = "zm_relic_ruby_ee_challenges_cs";
    s.name = "green_warp";
    fe [[ f ]]( s, us, cf, ( 4452.96, -84.15, -40.69 ), ( 0, 135, 0 ), "green_warp_1" );
    s = {};
    s.script_cs_flag = "zm_relic_ruby_ee_challenges_cs";
    s.name = "green_warp";
    fe [[ f ]]( s, us, cf, ( 4319.03, -213.56, -39.75 ), ( 0, 125, 0 ), "green_warp_1" );
    s = {};
    s.script_cs_flag = "zm_relic_ruby_ee_challenges_cs";
    s.name = "green_warp";
    fe [[ f ]]( s, us, cf, ( 4545.25, -56.07, -38.65 ), ( 0, 150, 0 ), "green_warp_1" );
    s = {};
    s.script_cs_flag = "zm_relic_ruby_ee_challenges_cs";
    s.name = "green_warp";
    fe [[ f ]]( s, us, cf, ( 4461.36, -192.09, -40.47 ), ( 0, 315, 0 ), undefined, "green_warp_1", "relic_warp_loc_1" );
    s = {};
    s.script_cs_flag = "zm_relic_ruby_ee_challenges_cs";
    s.name = "mrp_event_reward";
    fe [[ f ]]( s, us, cf, ( 4099.85, -41027.9, -12800 ), ( 0, 180, 0 ), "mrp_event_reward_7", undefined, "mrp_event_reward" );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace zm_relic_ruby_ee_challenges_cs
// Params 0, eflags: 0x4
// Checksum 0x7ed52b0f, Offset: 0x1874
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace zm_relic_ruby_ee_challenges_cs
// Params 0
// Checksum 0x3c2754a, Offset: 0x187e
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "zm_relic_ruby_ee_challenges_cs" );
}

