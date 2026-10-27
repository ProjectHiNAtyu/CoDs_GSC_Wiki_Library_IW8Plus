// scripts\mp\zm\maps\zm_sat_firefly\zm_sat_firefly_arcxd_racing_quest_cs.gsc  (hash_4bd780a1be7443f5.gscc) (size: 12508 Bytes / 0x30dc / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x2cc30200 (750977536)
// size ...... 12508 (0x30dc)
// includes .. 3   (offset: 0x29d0)
// strings ... 28  (offset: 0x29e8)
// dev strs .. 0   (offset: 0x30dc)
// exports ... 9   (offset: 0x2614)
// cseg ...... 0x346 + 0x22ce (0x2614)
// imports ... 21  (offset: 0x277c)
// animtree1 . 0   (offset: 0x30dc)
// animtree2 . 0   (offset: 0x30dc)
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace zm_sat_firefly_arcxd_racing_quest_cs;

// Namespace zm_sat_firefly_arcxd_racing_quest_cs
// Params 0, eflags: 0x5
// Checksum 0xc4861cb8, Offset: 0x364
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"zm_sat_firefly_arcxd_racing_quest_cs", undefined, &function_b39ecd3d51489472, undefined );
}

// Namespace zm_sat_firefly_arcxd_racing_quest_cs
// Params 0, eflags: 0x4
// Checksum 0xd9ed102f, Offset: 0x385
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace zm_sat_firefly_arcxd_racing_quest_cs
// Params 0, eflags: 0x4
// Checksum 0x5cd6c3c3, Offset: 0x396
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace zm_sat_firefly_arcxd_racing_quest_cs
// Params 2
// Checksum 0xec3f958a, Offset: 0x3a7
// Size: 0x80
function main( unused, unused2 )
{
    if ( utility::flag_exist( "zm_sat_firefly_arcxd_racing_quest_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "zm_sat_firefly_arcxd_racing_quest_cs" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "zm_sat_firefly_arcxd_racing_quest_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "zm_sat_firefly_arcxd_racing_quest_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace zm_sat_firefly_arcxd_racing_quest_cs
// Params 3, eflags: 0x4
// Checksum 0xdf54770c, Offset: 0x42f
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "zm_sat_firefly_arcxd_racing_quest_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "zm_sat_firefly_arcxd_racing_quest_cs" );
}

// Namespace zm_sat_firefly_arcxd_racing_quest_cs
// Params 3, eflags: 0x4
// Checksum 0x319c33e5, Offset: 0x4a9
// Size: 0x214b
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "zm_sat_firefly_arcxd_racing_quest_cs";
    s.script_poi = "arcxd_racing";
    fe [[ f ]]( s, us, cf, ( -1808.28, 599.84, 256.33 ), ( 0, 125.1, 0 ), "dancing_zombie_20", undefined, "sq_dancing_zombie_loc" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_arcxd_racing_quest_cs";
    s.script_poi = "arcxd_racing";
    fe [[ f ]]( s, us, cf, ( -6835, -6479.5, 1576 ), ( 0, 143.37, 0 ), undefined, undefined, "arcxd_racing_start_position" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_arcxd_racing_quest_cs";
    s.script_poi = "arcxd_racing";
    fe [[ f ]]( s, us, cf, ( -7826.16, -5763.13, 1384 ), ( 0, 232.6, 0 ), "sat_zm_arcxd_racing_track", undefined, "arcxd_rail" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_arcxd_racing_quest_cs";
    s.script_poi = "arcxd_racing";
    fe [[ f ]]( s, us, cf, ( -8307, -6498, 1640 ), ( 0, 320.35, 0 ), "sat_zm_arcxd_racing_track", undefined, "arcxd_rail" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_arcxd_racing_quest_cs";
    s.script_poi = "arcxd_racing";
    fe [[ f ]]( s, us, cf, ( -6800.9, -6414.49, 1576 ), ( 0, 232.6, 0 ), "sat_zm_arcxd_racing_track", undefined, "arcxd_rail" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_arcxd_racing_quest_cs";
    s.script_poi = "arcxd_racing";
    fe [[ f ]]( s, us, cf, ( -8180, -6345, 1640 ), ( 0, 319.21, 0 ), "sat_zm_arcxd_racing_track", undefined, "arcxd_rail" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_arcxd_racing_quest_cs";
    s.script_poi = "arcxd_racing";
    fe [[ f ]]( s, us, cf, ( -7107.89, -5674.17, 1576 ), ( 0, 232.78, 0 ), undefined, "cspf_0_auto8470637438449398282", "arcxd_racing_player_start_loc" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_arcxd_racing_quest_cs";
    s.script_poi = "arcxd_racing";
    fe [[ f ]]( s, us, cf, ( -7053.02, -5715.9, 1576 ), ( 0, 232.78, 0 ), undefined, "cspf_0_auto12560114509730169524", "arcxd_racing_player_start_loc" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_arcxd_racing_quest_cs";
    s.script_poi = "arcxd_racing";
    fe [[ f ]]( s, us, cf, ( -7899.66, -5706.63, 1384 ), ( 0, 232.6, 0 ), "sat_zm_arcxd_racing_track", undefined, "arcxd_rail" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_arcxd_racing_quest_cs";
    s.script_poi = "arcxd_racing";
    fe [[ f ]]( s, us, cf, ( -7164.34, -5631.53, 1576 ), ( 0, 232.78, 0 ), undefined, "cspf_0_auto6676184318906244311", "arcxd_racing_player_start_loc" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_arcxd_racing_quest_cs";
    s.script_poi = "arcxd_racing";
    fe [[ f ]]( s, us, cf, ( -7222.5, -5587.5, 1576 ), ( 0, 232.78, 0 ), undefined, "cspf_0_auto11225822353470404209", "arcxd_racing_player_start_loc" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_arcxd_racing_quest_cs";
    s.script_poi = "arcxd_racing";
    fe [[ f ]]( s, us, cf, ( -7974.16, -5652.13, 1384 ), ( 0, 232.6, 0 ), "sat_zm_arcxd_racing_track", undefined, "arcxd_rail" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_arcxd_racing_quest_cs";
    s.script_poi = "arcxd_racing";
    fe [[ f ]]( s, us, cf, ( -7369.5, -6126.5, 1576 ), ( 0, 232.6, 0 ), "sat_zm_arcxd_racing_track", undefined, "arcxd_rail" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_arcxd_racing_quest_cs";
    s.name = "dancing_zombie";
    s.script_poi = "arcxd_racing";
    fe [[ f ]]( s, us, cf, ( -7353.3, -6241.82, 1576 ), ( 0, 299.7, 0 ), undefined, undefined, "arcxd_racing_dancing_zombie_loc" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_arcxd_racing_quest_cs";
    s.script_poi = "arcxd_racing";
    fe [[ f ]]( s, us, cf, ( -8322.83, -5426.58, 1576 ), ( 0, 259.61, 0 ), "sat_zm_arcxd_racing_track", undefined, "arcxd_rail" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_arcxd_racing_quest_cs";
    s.script_poi = "arcxd_racing";
    fe [[ f ]]( s, us, cf, ( -8366, -6573, 1640 ), ( 0, 323.76, 0 ), "sat_zm_arcxd_racing_track", undefined, "arcxd_rail" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_arcxd_racing_quest_cs";
    s.name = "dancing_zombie";
    s.script_poi = "arcxd_racing";
    fe [[ f ]]( s, us, cf, ( -7423.78, -6334.37, 1576 ), ( 0, 15.02, 0 ), undefined, undefined, "arcxd_racing_dancing_zombie_loc" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_arcxd_racing_quest_cs";
    s.script_poi = "arcxd_racing";
    fe [[ f ]]( s, us, cf, ( -8099, -6321.5, 1631.65 ), ( 0, 254.43, -8.61 ), "sat_zm_arcxd_racing_track", undefined, "arcxd_rail" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_arcxd_racing_quest_cs";
    s.script_poi = "arcxd_racing";
    fe [[ f ]]( s, us, cf, ( -8866.8, -4883.49, 1576 ), ( 0.13, 144.03, 0.48 ), "sat_zm_arcxd_racing_track_extend", undefined, "arcxd_rail" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_arcxd_racing_quest_cs";
    s.script_poi = "arcxd_racing";
    fe [[ f ]]( s, us, cf, ( -8010.5, -6345.5, 1616.85 ), ( 0.29, 256.36, -8.6 ), "sat_zm_arcxd_racing_track", undefined, "arcxd_rail" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_arcxd_racing_quest_cs";
    s.script_poi = "arcxd_racing";
    fe [[ f ]]( s, us, cf, ( -7919, -6365.5, 1602.05 ), ( 0.29, 256.34, -8.6 ), "sat_zm_arcxd_racing_track", undefined, "arcxd_rail" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_arcxd_racing_quest_cs";
    s.script_poi = "arcxd_racing";
    fe [[ f ]]( s, us, cf, ( -9074.69, -5284.11, 1459.79 ), ( 9.95, 144.09, 0.19 ), "sat_zm_arcxd_racing_track_extend", undefined, "arcxd_rail" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_arcxd_racing_quest_cs";
    s.script_poi = "arcxd_racing";
    fe [[ f ]]( s, us, cf, ( -7828.5, -6387.5, 1587.17 ), ( 0.29, 256.34, -8.6 ), "sat_zm_arcxd_racing_track", undefined, "arcxd_rail" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_arcxd_racing_quest_cs";
    s.script_poi = "arcxd_racing";
    fe [[ f ]]( s, us, cf, ( -9002.4, -5070.24, 1576 ), ( 0.13, 144.03, 0.48 ), "sat_zm_arcxd_racing_track_extend", undefined, "arcxd_rail" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_arcxd_racing_quest_cs";
    s.script_poi = "arcxd_racing";
    fe [[ f ]]( s, us, cf, ( -9163.19, -5397.61, 1459.39 ), ( 2.2, 144.04, 0.36 ), "sat_zm_arcxd_racing_track_extend", undefined, "arcxd_rail" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_arcxd_racing_quest_cs";
    s.script_poi = "arcxd_racing";
    fe [[ f ]]( s, us, cf, ( -9270.19, -5524.11, 1449.98 ), ( 0.13, 144.03, 0.48 ), "sat_zm_arcxd_racing_track_extend", undefined, "arcxd_rail" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_arcxd_racing_quest_cs";
    s.script_poi = "arcxd_racing";
    fe [[ f ]]( s, us, cf, ( -7740.5, -6408, 1572.81 ), ( 0.29, 256.34, -8.6 ), "sat_zm_arcxd_racing_track", undefined, "arcxd_rail" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_arcxd_racing_quest_cs";
    s.script_poi = "arcxd_racing";
    fe [[ f ]]( s, us, cf, ( -9231.51, -5446.95, 1455.43 ), ( 0.28, 125.27, 0.41 ), "sat_zm_arcxd_racing_track", undefined, "arcxd_rail" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_arcxd_racing_quest_cs";
    s.script_poi = "arcxd_racing";
    fe [[ f ]]( s, us, cf, ( -7651.5, -6426.5, 1558.51 ), ( 0.29, 256.34, -8.6 ), "sat_zm_arcxd_racing_track", undefined, "arcxd_rail" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_arcxd_racing_quest_cs";
    s.script_poi = "arcxd_racing";
    fe [[ f ]]( s, us, cf, ( -7698.5, -6160.5, 1576 ), ( 0, 143.47, 0 ), "sat_zm_arcxd_racing_track", undefined, "arcxd_rail" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_arcxd_racing_quest_cs";
    s.script_poi = "arcxd_racing";
    fe [[ f ]]( s, us, cf, ( -7002.23, -6885.86, 1449.3 ), ( 0, 320.9, 0 ), "sat_zm_arcxd_racing_track_extend", undefined, "arcxd_rail" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_arcxd_racing_quest_cs";
    s.script_poi = "arcxd_racing";
    fe [[ f ]]( s, us, cf, ( -7451.5, -6330.5, 1576 ), ( 0, 322.79, 0 ), "sat_zm_arcxd_racing_track", undefined, "arcxd_rail" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_arcxd_racing_quest_cs";
    s.script_poi = "arcxd_racing";
    fe [[ f ]]( s, us, cf, ( -6987.12, -6821.04, 1449.93 ), ( 8.61, 344.67, 0.04 ), "sat_zm_arcxd_racing_track", undefined, "arcxd_rail" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_arcxd_racing_quest_cs";
    s.script_poi = "arcxd_racing";
    fe [[ f ]]( s, us, cf, ( -7391, -6251.5, 1576 ), ( 0, 322.79, 0 ), "sat_zm_arcxd_racing_track", undefined, "arcxd_rail" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_arcxd_racing_quest_cs";
    s.script_poi = "arcxd_racing";
    fe [[ f ]]( s, us, cf, ( -8475, -7325, 1639 ), ( 0, 0, 0 ), "cspf_0_auto9190526008083138955" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_arcxd_racing_quest_cs";
    s.script_poi = "arcxd_racing";
    fe [[ f ]]( s, us, cf, ( -7330.5, -6172, 1576 ), ( 0, 322.79, 0 ), "sat_zm_arcxd_racing_track", undefined, "arcxd_rail" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_arcxd_racing_quest_cs";
    s.script_poi = "arcxd_racing";
    fe [[ f ]]( s, us, cf, ( -7444.5, -6069.5, 1576 ), ( 0, 232.6, 0 ), "sat_zm_arcxd_racing_track", undefined, "arcxd_rail" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_arcxd_racing_quest_cs";
    s.script_poi = "arcxd_racing";
    fe [[ f ]]( s, us, cf, ( -7516, -6015, 1576 ), ( 0, 232.6, 0 ), "sat_zm_arcxd_racing_track", undefined, "arcxd_rail" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_arcxd_racing_quest_cs";
    s.script_poi = "arcxd_racing";
    fe [[ f ]]( s, us, cf, ( -7585, -6007.5, 1576 ), ( 0, 143.47, 0 ), "sat_zm_arcxd_racing_track", undefined, "arcxd_rail" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_arcxd_racing_quest_cs";
    s.script_poi = "arcxd_racing";
    fe [[ f ]]( s, us, cf, ( -8418.33, -5410.08, 1576 ), ( 0, 259.61, 0 ), "sat_zm_arcxd_racing_track", undefined, "arcxd_rail" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_arcxd_racing_quest_cs";
    s.script_poi = "arcxd_racing";
    fe [[ f ]]( s, us, cf, ( -8536.33, -5387.58, 1576 ), ( 0, 259.61, 0 ), "sat_zm_arcxd_racing_track", undefined, "arcxd_rail" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_arcxd_racing_quest_cs";
    s.name = "dancing_zombie";
    s.script_poi = "arcxd_racing";
    fe [[ f ]]( s, us, cf, ( -7384.63, -6289.06, 1576 ), ( 0, 318.81, 0 ), undefined, undefined, "arcxd_racing_dancing_zombie_loc" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_arcxd_racing_quest_cs";
    s.script_poi = "arcxd_racing";
    fe [[ f ]]( s, us, cf, ( -7642.5, -6085.5, 1576 ), ( 0, 143.47, 0 ), "sat_zm_arcxd_racing_track", undefined, "arcxd_rail" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_arcxd_racing_quest_cs";
    s.script_poi = "arcxd_racing";
    fe [[ f ]]( s, us, cf, ( -8715.69, -5534.61, 1537.1 ), ( 0, 159.45, 0.49 ), "sat_zm_arcxd_racing_track", undefined, "arcxd_rail" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_arcxd_racing_quest_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s._size_max = ( 7, 280, 114 );
    s._size_min = ( 6, -8, 80 );
    s.height = 128;
    s.length = "128";
    s.script_poi = "arcxd_racing";
    s.width = "128";
    fe [[ f ]]( s, us, cf, ( -7713, -6198, 1642 ), ( 0, 233.4, 0 ), undefined, undefined, "arcxd_racing_finish" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_arcxd_racing_quest_cs";
    s.script_poi = "arcxd_racing";
    fe [[ f ]]( s, us, cf, ( -8748.19, -5621.11, 1540.53 ), ( 0, 159.45, 2.99 ), "sat_zm_arcxd_racing_track", undefined, "arcxd_rail" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_arcxd_racing_quest_cs";
    s.script_poi = "arcxd_racing";
    fe [[ f ]]( s, us, cf, ( -8780.69, -5708.61, 1545.17 ), ( 0, 159.45, 1.68 ), "sat_zm_arcxd_racing_track", undefined, "arcxd_rail" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_arcxd_racing_quest_cs";
    s.name = "dancing_zombie";
    s.script_poi = "arcxd_racing";
    fe [[ f ]]( s, us, cf, ( -8500.05, -5425.96, 1576 ), ( 0, 78.73, 0 ), undefined, undefined, "arcxd_racing_dancing_zombie_loc" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_arcxd_racing_quest_cs";
    s.name = "dancing_zombie";
    s.script_poi = "arcxd_racing";
    fe [[ f ]]( s, us, cf, ( -8426.05, -5467.46, 1576 ), ( 0, 78.73, 0 ), undefined, undefined, "arcxd_racing_dancing_zombie_loc" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_arcxd_racing_quest_cs";
    s.script_poi = "arcxd_racing";
    fe [[ f ]]( s, us, cf, ( -8812.69, -5794.11, 1547.67 ), ( 0, 159.45, 1.68 ), "sat_zm_arcxd_racing_track", undefined, "arcxd_rail" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_arcxd_racing_quest_cs";
    s.name = "rc_controller";
    s.script_int = int( 1 );
    s.script_poi = "arcxd_racing";
    fe [[ f ]]( s, us, cf, ( 10036.4, 2396.39, 942.6 ), ( 0, 298.8, 0 ), undefined, undefined, "arcxd_toy_car" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_arcxd_racing_quest_cs";
    s.script_poi = "arcxd_racing";
    fe [[ f ]]( s, us, cf, ( -8494.43, -6494.16, 1304 ), ( 0, 53.14, 0 ), "sat_zm_arcxd_racing_track", undefined, "arcxd_rail" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_arcxd_racing_quest_cs";
    s.script_poi = "arcxd_racing";
    fe [[ f ]]( s, us, cf, ( -7094.73, -6997.86, 1449.3 ), ( 0, 320.9, 0 ), "sat_zm_arcxd_racing_track_extend", undefined, "arcxd_rail" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_arcxd_racing_quest_cs";
    s.script_poi = "arcxd_racing";
    fe [[ f ]]( s, us, cf, ( -8475, -7325, 1296 ), ( 0, 0, 0 ), undefined, "cspf_0_auto9190526008083138955", "arc_moving_platform" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_arcxd_racing_quest_cs";
    s.name = "rc_controller";
    s.script_int = int( 2 );
    s.script_poi = "arcxd_racing";
    fe [[ f ]]( s, us, cf, ( -9744.94, -2625.16, 1423.79 ), ( 3.46, 141.73, 10.86 ), undefined, undefined, "arcxd_toy_car" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_arcxd_racing_quest_cs";
    s.script_poi = "arcxd_racing";
    fe [[ f ]]( s, us, cf, ( -7549.15, -6828.25, 1448 ), ( 0, 322.54, 0 ), "sat_zm_arcxd_racing_track", undefined, "arcxd_rail" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_arcxd_racing_quest_cs";
    s.name = "rc_controller";
    s.script_int = int( 3 );
    s.script_poi = "arcxd_racing";
    fe [[ f ]]( s, us, cf, ( 8022.8, -3740.49, 633.41 ), ( 0, 0, -7.7 ), undefined, undefined, "arcxd_toy_car" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_arcxd_racing_quest_cs";
    s.script_poi = "arcxd_racing";
    fe [[ f ]]( s, us, cf, ( -8725.72, -5925.44, 1575.43 ), ( 1.39, 103.49, -5.7 ), "sat_zm_arcxd_racing_track", undefined, "arcxd_rail" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_arcxd_racing_quest_cs";
    s.script_poi = "arcxd_racing";
    fe [[ f ]]( s, us, cf, ( -8635.22, -5903.44, 1585.71 ), ( 1.39, 103.49, -5.7 ), "sat_zm_arcxd_racing_track", undefined, "arcxd_rail" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_arcxd_racing_quest_cs";
    s.script_poi = "arcxd_racing";
    fe [[ f ]]( s, us, cf, ( -8543.72, -5881.44, 1596.12 ), ( 1.39, 103.49, -5.7 ), "sat_zm_arcxd_racing_track", undefined, "arcxd_rail" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_arcxd_racing_quest_cs";
    s.script_poi = "arcxd_racing";
    fe [[ f ]]( s, us, cf, ( -8454.72, -5854.94, 1605.72 ), ( 1.39, 103.49, -5.7 ), "sat_zm_arcxd_racing_track", undefined, "arcxd_rail" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_arcxd_racing_quest_cs";
    s.script_poi = "arcxd_racing";
    fe [[ f ]]( s, us, cf, ( -8367.72, -5858.44, 1619.32 ), ( 356.89, 56.63, -8.2 ), "sat_zm_arcxd_racing_track", undefined, "arcxd_rail" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_arcxd_racing_quest_cs";
    s.script_poi = "arcxd_racing";
    fe [[ f ]]( s, us, cf, ( -8293.22, -5914.44, 1632.32 ), ( 356.63, 54.83, -8.1 ), "sat_zm_arcxd_racing_track", undefined, "arcxd_rail" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_arcxd_racing_quest_cs";
    s.name = "dancing_zombie";
    s.script_poi = "arcxd_racing";
    fe [[ f ]]( s, us, cf, ( -8497.54, -6454.45, 1302.26 ), ( 0, 232.23, 0 ), undefined, undefined, "arcxd_racing_dancing_zombie_loc" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_arcxd_racing_quest_cs";
    s.name = "dancing_zombie";
    s.script_poi = "arcxd_racing";
    fe [[ f ]]( s, us, cf, ( -8467.04, -6475.45, 1302.26 ), ( 0, 232.23, 0 ), undefined, undefined, "arcxd_racing_dancing_zombie_loc" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_arcxd_racing_quest_cs";
    s.script_poi = "arcxd_racing";
    fe [[ f ]]( s, us, cf, ( -7158, -5794.5, 1576 ), ( 0, 232.6, 0 ), "sat_zm_arcxd_racing_track", undefined, "arcxd_rail" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_arcxd_racing_quest_cs";
    s.script_poi = "arcxd_racing";
    fe [[ f ]]( s, us, cf, ( -7233, -5737.5, 1576 ), ( 0, 232.6, 0 ), "sat_zm_arcxd_racing_track", undefined, "arcxd_rail" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_arcxd_racing_quest_cs";
    s.script_poi = "arcxd_racing";
    fe [[ f ]]( s, us, cf, ( -7304.5, -5683, 1576 ), ( 0, 232.6, 0 ), "sat_zm_arcxd_racing_track", undefined, "arcxd_rail" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_arcxd_racing_quest_cs";
    s.script_poi = "arcxd_racing";
    fe [[ f ]]( s, us, cf, ( -7089.5, -5856.5, 1576 ), ( 0, 217.93, 0 ), "sat_zm_arcxd_racing_track", undefined, "arcxd_rail" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_arcxd_racing_quest_cs";
    s.script_poi = "arcxd_racing";
    fe [[ f ]]( s, us, cf, ( -7359, -5630, 1576 ), ( 0, 238.12, 0 ), "sat_zm_arcxd_racing_track", undefined, "arcxd_rail" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_arcxd_racing_quest_cs";
    s.script_poi = "arcxd_racing";
    fe [[ f ]]( s, us, cf, ( -6862.26, -6516.1, 1576 ), ( 0, 143.37, 0 ), undefined, undefined, "arcxd_racing_start_position" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_arcxd_racing_quest_cs";
    s.script_poi = "arcxd_racing";
    fe [[ f ]]( s, us, cf, ( -6887.95, -6550.74, 1576 ), ( 0, 143.37, 0 ), undefined, undefined, "arcxd_racing_start_position" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_arcxd_racing_quest_cs";
    s.script_poi = "arcxd_racing";
    fe [[ f ]]( s, us, cf, ( -6914.67, -6586.36, 1576 ), ( 0, 143.37, 0 ), undefined, undefined, "arcxd_racing_start_position" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_arcxd_racing_quest_cs";
    s.script_poi = "arcxd_racing";
    fe [[ f ]]( s, us, cf, ( -7197.89, -5793.17, 1617 ), ( 0, 232.78, 0 ), "cspf_0_auto8470637438449398282" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_arcxd_racing_quest_cs";
    s.script_poi = "arcxd_racing";
    fe [[ f ]]( s, us, cf, ( -7144.02, -5835.9, 1617 ), ( 0, 232.78, 0 ), "cspf_0_auto12560114509730169524" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_arcxd_racing_quest_cs";
    s.name = "dancing_zombie";
    s.script_poi = "arcxd_racing";
    fe [[ f ]]( s, us, cf, ( -7165.96, -7094.06, 1517 ), ( 0, 141.73, 0 ), undefined, undefined, "arcxd_racing_dancing_zombie_loc" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_arcxd_racing_quest_cs";
    s.script_poi = "arcxd_racing";
    fe [[ f ]]( s, us, cf, ( -7253.34, -5749.53, 1617 ), ( 0, 232.78, 0 ), "cspf_0_auto6676184318906244311" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_arcxd_racing_quest_cs";
    s.script_poi = "arcxd_racing";
    fe [[ f ]]( s, us, cf, ( -7310.5, -5703.5, 1617 ), ( 0, 232.78, 0 ), "cspf_0_auto11225822353470404209" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_arcxd_racing_quest_cs";
    s.script_poi = "arcxd_racing";
    fe [[ f ]]( s, us, cf, ( -6957.35, -5957.72, 1640 ), ( 0, 323, 0 ), "t10_zm_powerarrows_dark_aether_02a", undefined, "arc_arrow" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_arcxd_racing_quest_cs";
    s.script_poi = "arcxd_racing";
    fe [[ f ]]( s, us, cf, ( -7098, -6378, 1576 ), ( 0, 264.2, -90 ), "t10_zm_powerarrows_dark_aether_02b", undefined, "arc_arrow" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_arcxd_racing_quest_cs";
    s.script_poi = "arcxd_racing";
    fe [[ f ]]( s, us, cf, ( -7479.55, -5712.76, 1621.06 ), ( 0, 53, 0 ), "t10_zm_powerarrows_dark_aether_02a", undefined, "arc_arrow" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_arcxd_racing_quest_cs";
    s.script_poi = "arcxd_racing";
    fe [[ f ]]( s, us, cf, ( -8598.48, -5144.42, 1576 ), ( 360, 6.1, -90 ), "t10_zm_powerarrows_dark_aether_01", undefined, "arc_arrow" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_arcxd_racing_quest_cs";
    s.script_poi = "arcxd_racing";
    fe [[ f ]]( s, us, cf, ( -9065.52, -5764.85, 1561.32 ), ( 19.7, 143, -0 ), "t10_zm_powerarrows_dark_aether_01a", undefined, "arc_arrow" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_arcxd_racing_quest_cs";
    s.script_poi = "arcxd_racing";
    fe [[ f ]]( s, us, cf, ( -8585.76, -7231.28, 1365.56 ), ( 0, 233, 0 ), "t10_zm_powerarrows_dark_aether_02a", undefined, "arc_arrow" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_arcxd_racing_quest_cs";
    s.script_poi = "arcxd_racing";
    fe [[ f ]]( s, us, cf, ( -7103.96, -6678.98, 1522.66 ), ( 11.5, 323, -0 ), "t10_zm_powerarrows_dark_aether_02a", undefined, "arc_arrow" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_arcxd_racing_quest_cs";
    s.script_poi = "arcxd_racing";
    fe [[ f ]]( s, us, cf, ( -8245, -6423, 1640 ), ( 0, 320.35, 0 ), "sat_zm_arcxd_racing_track", undefined, "arcxd_rail" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_arcxd_racing_quest_cs";
    s.script_poi = "arcxd_racing";
    fe [[ f ]]( s, us, cf, ( -8193.83, -6482.03, 1628.8 ), ( 352.82, 93.75, -81.95 ), "t10_zm_powerarrows_dark_aether_01", undefined, "arc_arrow" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_arcxd_racing_quest_cs";
    s.script_poi = "arcxd_racing";
    fe [[ f ]]( s, us, cf, ( -8389.69, -7088.54, 1640 ), ( 0, 344.6, -90 ), "t10_zm_powerarrows_dark_aether_02a", undefined, "arc_arrow" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_arcxd_racing_quest_cs";
    s.script_poi = "arcxd_racing";
    fe [[ f ]]( s, us, cf, ( -9104.4, -6543.15, 1640 ), ( 0, 226.4, -90 ), "t10_zm_powerarrows_dark_aether_02a", undefined, "arc_arrow" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_arcxd_racing_quest_cs";
    s.script_poi = "arcxd_racing";
    fe [[ f ]]( s, us, cf, ( -7569.1, -6402.32, 1556.71 ), ( 33.69, 322.35, -0.36 ), "sat_zm_arcxd_racing_track", undefined, "arcxd_rail" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_arcxd_racing_quest_cs";
    s.script_poi = "arcxd_racing";
    fe [[ f ]]( s, us, cf, ( -7485.02, -6922.39, 1448.52 ), ( 360, 143.4, -90 ), "t10_zm_powerarrows_dark_aether_02a", undefined, "arc_arrow" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_arcxd_racing_quest_cs";
    s.name = "dancing_zombie";
    s.script_poi = "arcxd_racing";
    fe [[ f ]]( s, us, cf, ( -9315.93, -6667.85, 1296 ), ( 0, 17.46, 0 ), undefined, undefined, "arcxd_racing_dancing_zombie_loc" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_arcxd_racing_quest_cs";
    s.script_poi = "arcxd_racing";
    fe [[ f ]]( s, us, cf, ( -9261.12, -6673.87, 1296 ), ( 360, 233.12, -0 ), "sat_zm_arcxd_racing_track", undefined, "arcxd_rail" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_arcxd_racing_quest_cs";
    s.script_poi = "arcxd_racing";
    fe [[ f ]]( s, us, cf, ( -7753.92, -6515.12, 1564.25 ), ( 9.87, 312.75, -91.78 ), "t10_zm_powerarrows_dark_aether_02a", undefined, "arc_arrow" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_arcxd_racing_quest_cs";
    s.script_poi = "arcxd_racing";
    fe [[ f ]]( s, us, cf, ( -8490.42, -5954.62, 1611.36 ), ( 9.48, 125.35, -93 ), "t10_zm_powerarrows_dark_aether_02a", undefined, "arc_arrow" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_arcxd_racing_quest_cs";
    s.script_poi = "arcxd_racing";
    fe [[ f ]]( s, us, cf, ( -9238.76, -6850.39, 1683.88 ), ( 3.57, 233, -180 ), "t10_zm_powerarrows_dark_aether_01", undefined, "arc_arrow" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_arcxd_racing_quest_cs";
    s.name = "dancing_zombie";
    s.script_poi = "arcxd_racing";
    fe [[ f ]]( s, us, cf, ( -8672.97, -5668.48, 1555.93 ), ( 0, 145.58, 0 ), undefined, undefined, "arcxd_racing_dancing_zombie_loc" );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace zm_sat_firefly_arcxd_racing_quest_cs
// Params 0, eflags: 0x4
// Checksum 0x702049ba, Offset: 0x25fc
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace zm_sat_firefly_arcxd_racing_quest_cs
// Params 0
// Checksum 0x1d07aa41, Offset: 0x2606
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "zm_sat_firefly_arcxd_racing_quest_cs" );
}

