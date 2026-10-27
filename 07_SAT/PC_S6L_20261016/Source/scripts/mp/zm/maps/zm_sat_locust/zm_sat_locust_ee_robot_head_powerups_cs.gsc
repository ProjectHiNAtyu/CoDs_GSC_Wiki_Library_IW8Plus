// scripts\mp\zm\maps\zm_sat_locust\zm_sat_locust_ee_robot_head_powerups_cs.gsc  (hash_79f75503dc856b55.gscc) (size: 6803 Bytes / 0x1a93 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xfc7bc91e (4235970846)
// size ...... 6803 (0x1a93)
// includes .. 3   (offset: 0x17a3)
// strings ... 25  (offset: 0x17bb)
// dev strs .. 0   (offset: 0x1a93)
// exports ... 9   (offset: 0x140b)
// cseg ...... 0x1b5 + 0x1256 (0x140b)
// imports ... 20  (offset: 0x1573)
// animtree1 . 0   (offset: 0x1a93)
// animtree2 . 0   (offset: 0x1a93)
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace zm_sat_locust_ee_robot_head_powerups_cs;

// Namespace zm_sat_locust_ee_robot_head_powerups_cs
// Params 0, eflags: 0x5
// Checksum 0xc6c2ba03, Offset: 0x1d3
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"zm_sat_locust_ee_robot_head_powerups_cs", undefined, &function_b39ecd3d51489472, undefined );
}

// Namespace zm_sat_locust_ee_robot_head_powerups_cs
// Params 0, eflags: 0x4
// Checksum 0xedd8d3e9, Offset: 0x1f4
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace zm_sat_locust_ee_robot_head_powerups_cs
// Params 0, eflags: 0x4
// Checksum 0x68e30005, Offset: 0x205
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace zm_sat_locust_ee_robot_head_powerups_cs
// Params 2
// Checksum 0xd80a564c, Offset: 0x216
// Size: 0x80
function main( unused, unused2 )
{
    if ( utility::flag_exist( "zm_sat_locust_ee_robot_head_powerups_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "zm_sat_locust_ee_robot_head_powerups_cs" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "zm_sat_locust_ee_robot_head_powerups_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "zm_sat_locust_ee_robot_head_powerups_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace zm_sat_locust_ee_robot_head_powerups_cs
// Params 3, eflags: 0x4
// Checksum 0xeb61b4ca, Offset: 0x29e
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "zm_sat_locust_ee_robot_head_powerups_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "zm_sat_locust_ee_robot_head_powerups_cs" );
}

// Namespace zm_sat_locust_ee_robot_head_powerups_cs
// Params 3, eflags: 0x4
// Checksum 0xb03d15ac, Offset: 0x318
// Size: 0x10d3
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_robot_head_powerups_cs";
    s.groupid = "lights";
    fe [[ f ]]( s, us, cf, ( 2870.59, 9555.44, 1796.84 ), ( 0, 0, 0 ), "rh_exterior_light" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_robot_head_powerups_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s._size_max = ( 2000, 1424, 1014 );
    s._size_min = ( 1166, 1642, 378 );
    s.groupid = "lighthouse";
    s.height = 128;
    s.length = "128";
    s.width = "128";
    fe [[ f ]]( s, us, cf, ( 6370.32, 1675.59, 346.55 ), ( 0, 0, 0 ), "rh_lighthouse" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_robot_head_powerups_cs";
    s.groupid = "lights";
    fe [[ f ]]( s, us, cf, ( 3029.89, 9526.36, 1704.87 ), ( 0, 0, 0 ), "rh_interior_ring" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_robot_head_powerups_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s._size_max = ( 1518, 1336, 122 );
    s._size_min = ( 710, 1642, 378 );
    s.groupid = "spawn";
    s.height = 128;
    s.length = "128";
    s.width = "128";
    fe [[ f ]]( s, us, cf, ( 3608, 400, 344 ), ( 0, 0, 0 ), "rh_spawn" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_robot_head_powerups_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s._size_max = ( 938, 1364, 122 );
    s._size_min = ( 1326, 1768, 378 );
    s.groupid = "downtown";
    s.height = 128;
    s.length = "128";
    s.width = "128";
    fe [[ f ]]( s, us, cf, ( 4224, 3504, 352 ), ( 0, 0, 0 ), "rh_downtown" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_robot_head_powerups_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s._size_max = ( 202, 1054, 122 );
    s._size_min = ( 582, 984, 378 );
    s.groupid = "downtown";
    s.height = 128;
    s.length = "128";
    s.width = "128";
    fe [[ f ]]( s, us, cf, ( 2696, 3272, 344 ), ( 0, 0, 0 ), "rh_downtown" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_robot_head_powerups_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s._size_max = ( 622, 910, 122 );
    s._size_min = ( 182, 624, 378 );
    s.groupid = "downtown";
    s.height = 128;
    s.length = "128";
    s.width = "128";
    fe [[ f ]]( s, us, cf, ( 5344, 3728, 344 ), ( 0, 0, 0 ), "rh_downtown" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_robot_head_powerups_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s._size_max = ( 806, -12, 232 );
    s._size_min = ( 1430, 1224, 378 );
    s.groupid = "market";
    s.height = 128;
    s.length = "128";
    s.width = "128";
    fe [[ f ]]( s, us, cf, ( 5012.31, 6091.73, 346.55 ), ( 0, 0, 0 ), "rh_market" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_robot_head_powerups_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s._size_max = ( 1930, 336, 376 );
    s._size_min = ( 1794, 800, 378 );
    s.groupid = "bridge";
    s.height = 128;
    s.length = "128";
    s.width = "128";
    fe [[ f ]]( s, us, cf, ( 1639.41, 7969.73, 346.55 ), ( 0, 10, 0 ), "rh_bridge" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_robot_head_powerups_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s._size_max = ( 154, 632, 232 );
    s._size_min = ( 410, 448, 378 );
    s.groupid = "market";
    s.height = 128;
    s.length = "128";
    s.width = "128";
    fe [[ f ]]( s, us, cf, ( 4268.31, 6527.73, 346.55 ), ( 0, 0, 0 ), "rh_market" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_robot_head_powerups_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s._size_max = ( 1312, 1384, 464 );
    s._size_min = ( 1154, 1026, 380 );
    s.groupid = "foundry";
    s.height = 128;
    s.length = "128";
    s.width = "128";
    fe [[ f ]]( s, us, cf, ( -752, 5152, 348 ), ( 0, 32, 0 ), "rh_foundry" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_robot_head_powerups_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s._size_max = ( 1296, 1292, 186 );
    s._size_min = ( 1852, 630, 532 );
    s.groupid = "dock";
    s.height = 128;
    s.length = "128";
    s.width = "128";
    fe [[ f ]]( s, us, cf, ( 452, 3172, 348 ), ( 0, 32, 0 ), "rh_dock" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_robot_head_powerups_cs";
    s.groupid = "lights";
    fe [[ f ]]( s, us, cf, ( 3144.32, 9407.66, 1796.76 ), ( 0, 0, 0 ), "rh_exterior_light" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_robot_head_powerups_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s._size_max = ( 898, 668, 186 );
    s._size_min = ( 1852, 784, 532 );
    s.groupid = "dock";
    s.height = 128;
    s.length = "128";
    s.width = "128";
    fe [[ f ]]( s, us, cf, ( 1141.49, 2081.61, 346.55 ), ( 0, 32, 0 ), "rh_dock" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_robot_head_powerups_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s._size_max = ( 996, 1356, 214 );
    s._size_min = ( 990, 602, 378 );
    s.groupid = "fishery";
    s.height = 128;
    s.length = "128";
    s.width = "128";
    fe [[ f ]]( s, us, cf, ( 1902.46, 5417.71, 346.55 ), ( 0, 0, 0 ), "rh_fishery" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_robot_head_powerups_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s._size_max = ( 296, 1014, 214 );
    s._size_min = ( 112, 884, 378 );
    s.groupid = "fishery";
    s.height = 128;
    s.length = "128";
    s.width = "128";
    fe [[ f ]]( s, us, cf, ( 3011.51, 5752.7, 346.55 ), ( 0, 0, 0 ), "rh_fishery" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_robot_head_powerups_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s._size_max = ( 50, 630, 214 );
    s._size_min = ( 314, 428, 378 );
    s.groupid = "fishery";
    s.height = 128;
    s.length = "128";
    s.width = "128";
    fe [[ f ]]( s, us, cf, ( 862.27, 6143.77, 346.55 ), ( 0, 0, 0 ), "rh_fishery" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_robot_head_powerups_cs";
    s.groupid = "bridge";
    fe [[ f ]]( s, us, cf, ( 1849.74, 7741.46, 505.41 ), ( 0, 0, 0 ), "rh_debug", undefined, "bridge" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_robot_head_powerups_cs";
    s.groupid = "fishery";
    fe [[ f ]]( s, us, cf, ( 1860.75, 5723.86, 117.88 ), ( 0, 0, 0 ), "rh_debug", undefined, "fishery" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_robot_head_powerups_cs";
    s.groupid = "foundry";
    fe [[ f ]]( s, us, cf, ( -752.65, 6062.32, 343.69 ), ( 0, 0, 0 ), "rh_debug", undefined, "foundry" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_robot_head_powerups_cs";
    s.groupid = "dock";
    fe [[ f ]]( s, us, cf, ( 905.38, 3443.87, -149.32 ), ( 0, 0, 0 ), "rh_debug", undefined, "dock" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_robot_head_powerups_cs";
    s.groupid = "spawn";
    fe [[ f ]]( s, us, cf, ( 3408.28, 267.9, 202.06 ), ( 0, 0, 0 ), "rh_debug", undefined, "spawn" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_robot_head_powerups_cs";
    s.groupid = "downtown";
    fe [[ f ]]( s, us, cf, ( 3911.68, 3141.67, 96.37 ), ( 0, 0, 0 ), "rh_debug", undefined, "downtown" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_robot_head_powerups_cs";
    s.groupid = "lighthouse";
    fe [[ f ]]( s, us, cf, ( 6212.81, 1813.7, 115.68 ), ( 0, 0, 0 ), "rh_debug", undefined, "lighthouse" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_robot_head_powerups_cs";
    s.groupid = "market";
    fe [[ f ]]( s, us, cf, ( 4739.6, 5847.32, 221.6 ), ( 0, 0, 0 ), "rh_debug", undefined, "market" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_robot_head_powerups_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s._size_max = ( 1518, -184, 122 );
    s._size_min = ( -834, 1314, 378 );
    s.groupid = "spawn";
    s.height = 128;
    s.length = "128";
    s.width = "128";
    fe [[ f ]]( s, us, cf, ( 1384, 344, 344 ), ( 0, 0, 0 ), "rh_spawn" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_robot_head_powerups_cs";
    fe [[ f ]]( s, us, cf, ( 3028.19, 9524.83, 1686.05 ), ( 0, 0, 0 ), "howard_fx" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_robot_head_powerups_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s._size_max = ( 1666, 316, 232 );
    s._size_min = ( 894, 1224, 378 );
    s.groupid = "market";
    s.height = 128;
    s.length = "128";
    s.width = "128";
    fe [[ f ]]( s, us, cf, ( 5316.31, 7303.73, 346.55 ), ( 0, 0, 0 ), "rh_market" );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace zm_sat_locust_ee_robot_head_powerups_cs
// Params 0, eflags: 0x4
// Checksum 0x2b72c439, Offset: 0x13f3
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace zm_sat_locust_ee_robot_head_powerups_cs
// Params 0
// Checksum 0x29326987, Offset: 0x13fd
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "zm_sat_locust_ee_robot_head_powerups_cs" );
}

