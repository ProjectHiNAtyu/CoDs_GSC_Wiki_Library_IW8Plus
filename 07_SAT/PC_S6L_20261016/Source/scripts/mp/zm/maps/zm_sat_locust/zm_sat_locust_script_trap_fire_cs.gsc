// scripts\mp\zm\maps\zm_sat_locust\zm_sat_locust_script_trap_fire_cs.gsc  (hash_665711e731126dcd.gscc) (size: 13284 Bytes / 0x33e4 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xcc9b241e (3432719390)
// size ...... 13284 (0x33e4)
// includes .. 3   (offset: 0x2ce8)
// strings ... 58  (offset: 0x2d00)
// dev strs .. 0   (offset: 0x33e4)
// exports ... 9   (offset: 0x28c0)
// cseg ...... 0x53d + 0x2383 (0x28c0)
// imports ... 22  (offset: 0x2a28)
// animtree1 . 0   (offset: 0x33e4)
// animtree2 . 0   (offset: 0x33e4)
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace zm_sat_locust_script_trap_fire_cs;

// Namespace zm_sat_locust_script_trap_fire_cs
// Params 0, eflags: 0x5
// Checksum 0xcbe89f5e, Offset: 0x55b
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"zm_sat_locust_script_trap_fire_cs", undefined, &function_b39ecd3d51489472, undefined );
}

// Namespace zm_sat_locust_script_trap_fire_cs
// Params 0, eflags: 0x4
// Checksum 0x76118f40, Offset: 0x57c
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace zm_sat_locust_script_trap_fire_cs
// Params 0, eflags: 0x4
// Checksum 0xf32a5cac, Offset: 0x58d
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace zm_sat_locust_script_trap_fire_cs
// Params 2
// Checksum 0x43c30ae5, Offset: 0x59e
// Size: 0x80
function main( unused, unused2 )
{
    if ( utility::flag_exist( "zm_sat_locust_script_trap_fire_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "zm_sat_locust_script_trap_fire_cs" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "zm_sat_locust_script_trap_fire_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "zm_sat_locust_script_trap_fire_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace zm_sat_locust_script_trap_fire_cs
// Params 3, eflags: 0x4
// Checksum 0x70a8e863, Offset: 0x626
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "zm_sat_locust_script_trap_fire_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "zm_sat_locust_script_trap_fire_cs" );
}

// Namespace zm_sat_locust_script_trap_fire_cs
// Params 3, eflags: 0x4
// Checksum 0x746d4c0c, Offset: 0x6a0
// Size: 0x2200
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_trap_fire_cs";
    s.groupid = "boss_fire_trap_1";
    s.name = "boss_ft_switch";
    s.script_cost = int( 1000 );
    s.script_duration = float( 40 );
    s.script_label = "zm_sat_locust_fire_trap_switch_offensive";
    s.script_power = "power_on";
    s.script_timeout = float( 60 );
    fe [[ f ]]( s, us, cf, ( 9114.21, 24426.7, 5242 ), ( 0, 55, 0 ), "fire_trap_switch", "cspf_0_auto6971569224884060195", "zone_robot_head", undefined, undefined, undefined, undefined, 80 );
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_trap_fire_cs";
    s.groupid = "fire_trap_1";
    s.name = "ft_switch_1";
    s.script_cost = int( 1000 );
    s.script_duration = float( 40 );
    s.script_label = "zm_sat_locust_fire_trap_switch_offensive";
    s.script_power = "power_on";
    s.script_timeout = float( 60 );
    fe [[ f ]]( s, us, cf, ( 1618, 1200, 326 ), ( 0, 0, 0 ), "fire_trap_switch", "cspf_0_auto14577095895443065925", "zone_robot_head", undefined, undefined, undefined, undefined, 80 );
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_trap_fire_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s._size_max = ( 75, 20, 8 );
    s._size_min = ( 82, 20, 48 );
    s.groupid = "fire_trap_1";
    s.height = 128;
    s.length = "128";
    s.width = "128";
    fe [[ f ]]( s, us, cf, ( 1564.26, 1138.71, 272 ), ( 0, 165, 0 ), "cspf_0_auto214597015384405551", undefined, "1" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_trap_fire_cs";
    s.groupid = "fire_trap_1";
    s.name = "ft_switch_pos_1";
    s.script_label = "zm_sat_grant_trap_switch";
    fe [[ f ]]( s, us, cf, ( 1672, 1339, 272 ), ( 0, 270, 0 ), "cspf_0_auto14577095895443065925", undefined, "switch" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_trap_fire_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s._size_max = ( 75, 20, 8 );
    s._size_min = ( 82, 20, 48 );
    s.groupid = "fire_trap_1";
    s.height = 128;
    s.length = "128";
    s.width = "128";
    fe [[ f ]]( s, us, cf, ( 1724.03, 1182.1, 272 ), ( 0, 45, 0 ), "cspf_0_auto214597015384405551", undefined, "0" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_trap_fire_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s._size_max = ( 75, 20, 8 );
    s._size_min = ( 82, 20, 54 );
    s.groupid = "fire_trap_1";
    s.height = 128;
    s.length = "128";
    s.name = "noent_volume_trigger_box";
    s.width = "128";
    fe [[ f ]]( s, us, cf, ( 1673.18, 1021.57, 272 ), ( 0, 280, 0 ), "cspf_0_auto214597015384405551", undefined, "2" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_trap_fire_cs";
    s.groupid = "fire_trap_2";
    s.name = "ft_body_2";
    s.script_label = "zm_sat_grant_trap";
    fe [[ f ]]( s, us, cf, ( -838.35, 6278.27, 351.5 ), ( 0, 300, 0 ), "cspf_0_auto9408091676589524249", "cspf_0_auto17451732182219069101", "trap" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_trap_fire_cs";
    s.groupid = "fire_trap_2";
    s.name = "ft_switch_2";
    s.script_cost = int( 1000 );
    s.script_duration = float( 40 );
    s.script_label = "zm_sat_locust_fire_trap_switch_offensive";
    s.script_power = "power_on";
    s.script_timeout = float( 60 );
    fe [[ f ]]( s, us, cf, ( -833.96, 6293.88, 442.5 ), ( 0, 5, 0 ), "fire_trap_switch", "cspf_0_auto9408091676589524249", "zone_robot_head", undefined, undefined, undefined, undefined, 80 );
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_trap_fire_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s._size_max = ( 75, 20, 8 );
    s._size_min = ( 84, 20, 48 );
    s.groupid = "fire_trap_2";
    s.height = 128;
    s.length = "128";
    s.width = "128";
    fe [[ f ]]( s, us, cf, ( -935.01, 6278.18, 400.5 ), ( 0, 180.12, 0 ), "cspf_0_auto17451732182219069101", undefined, "1" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_trap_fire_cs";
    s.groupid = "fire_trap_2";
    s.name = "ft_switch_pos_2";
    s.script_label = "zm_sat_grant_trap_switch";
    fe [[ f ]]( s, us, cf, ( -654.5, 6323, 400 ), ( 0, 210, 0 ), "cspf_0_auto9408091676589524249", undefined, "switch" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_trap_fire_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s._size_max = ( 75, 20, 8 );
    s._size_min = ( 82, 20, 48 );
    s.groupid = "fire_trap_2";
    s.height = 128;
    s.length = "128";
    s.width = "128";
    fe [[ f ]]( s, us, cf, ( -792.63, 6361.34, 400.5 ), ( 0, 61.99, 0 ), "cspf_0_auto17451732182219069101", undefined, "0" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_trap_fire_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s._size_max = ( 75, 20, 8 );
    s._size_min = ( 84, 20, 48 );
    s.groupid = "fire_trap_2";
    s.height = 128;
    s.length = "128";
    s.width = "128";
    fe [[ f ]]( s, us, cf, ( -786.39, 6194.64, 400 ), ( 0, 299.21, 0 ), "cspf_0_auto17451732182219069101", undefined, "2" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_trap_fire_cs";
    s.groupid = "Fire_Trap_3";
    s.name = "ft_body_3";
    s.script_label = "zm_sat_grant_trap";
    fe [[ f ]]( s, us, cf, ( 5632, 6888, 218.07 ), ( 0, 0, 0 ), "cspf_0_auto7291840760519515697", "cspf_0_auto13748477655335174141", "trap" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_trap_fire_cs";
    s.groupid = "Fire_Trap_3";
    s.name = "ft_switch_3";
    s.script_cost = int( 1000 );
    s.script_duration = float( 40 );
    s.script_label = "zm_sat_locust_fire_trap_switch_offensive";
    s.script_power = "power_on";
    s.script_timeout = float( 60 );
    fe [[ f ]]( s, us, cf, ( 5645, 6878.5, 306 ), ( 0, 0, 0 ), "fire_trap_switch", "cspf_0_auto7291840760519515697", "zone_robot_head", undefined, undefined, undefined, undefined, 80 );
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_trap_fire_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s._size_max = ( 75, 20, 8 );
    s._size_min = ( 82, 20, 54 );
    s.groupid = "Fire_Trap_3";
    s.height = 128;
    s.length = "128";
    s.width = "128";
    fe [[ f ]]( s, us, cf, ( 5588, 6972, 268 ), ( 0, 115, 0 ), "cspf_0_auto13748477655335174141", undefined, "1" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_trap_fire_cs";
    s.groupid = "Fire_Trap_3";
    s.name = "ft_switch_pos_3";
    s.script_label = "zm_sat_grant_trap_switch";
    fe [[ f ]]( s, us, cf, ( 5434, 6600, 270 ), ( 0, 20, 0 ), "cspf_0_auto7291840760519515697", undefined, "switch" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_trap_fire_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s._size_max = ( 75, 20, 8 );
    s._size_min = ( 90, 20, 54 );
    s.groupid = "Fire_Trap_3";
    s.height = 128;
    s.length = "128";
    s.width = "128";
    fe [[ f ]]( s, us, cf, ( 5732, 6888.5, 266 ), ( 0, 0, 0 ), "cspf_0_auto13748477655335174141", undefined, "0" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_trap_fire_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s._size_max = ( 75, 20, 8 );
    s._size_min = ( 82, 20, 54 );
    s.groupid = "Fire_Trap_3";
    s.height = 128;
    s.length = "128";
    s.width = "128";
    fe [[ f ]]( s, us, cf, ( 5588, 6804, 268 ), ( 0, 245, 0 ), "cspf_0_auto13748477655335174141", undefined, "2" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_trap_fire_cs";
    s.groupid = "Fire_Trap_4";
    s.name = "ft_body_4";
    s.script_label = "zm_sat_grant_trap";
    fe [[ f ]]( s, us, cf, ( 4331.66, 3463.26, 112 ), ( 0, 350, 0 ), "cspf_0_auto5338326832198079169", "cspf_0_auto4591478451364530574", "trap" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_trap_fire_cs";
    s.groupid = "Fire_Trap_4";
    s.name = "ft_switch_4";
    s.script_cost = int( 1000 );
    s.script_duration = float( 40 );
    s.script_label = "zm_sat_locust_fire_trap_switch_offensive";
    s.script_power = "power_on";
    s.script_timeout = float( 60 );
    fe [[ f ]]( s, us, cf, ( 4325.65, 3473.82, 203 ), ( 0, 20, 0 ), "fire_trap_switch", "cspf_0_auto5338326832198079169", "zone_robot_head", undefined, undefined, undefined, undefined, 80 );
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_trap_fire_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s._size_max = ( 75, 20, 8 );
    s._size_min = ( 82, 20, 54 );
    s.groupid = "Fire_Trap_4";
    s.height = 128;
    s.length = "128";
    s.width = "128";
    fe [[ f ]]( s, us, cf, ( 4296, 3552, 160 ), ( 0, 110, 0 ), "cspf_0_auto4591478451364530574", undefined, "1" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_trap_fire_cs";
    s.groupid = "Fire_Trap_4";
    s.name = "ft_switch_pos_4";
    s.script_label = "zm_sat_grant_trap_switch";
    fe [[ f ]]( s, us, cf, ( 4475.5, 3297, 171 ), ( 0, 157.59, 0 ), "cspf_0_auto5338326832198079169", undefined, "switch" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_trap_fire_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s._size_max = ( 75, 20, 8 );
    s._size_min = ( 86, 20, 54 );
    s.groupid = "Fire_Trap_4";
    s.height = 128;
    s.length = "128";
    s.width = "128";
    fe [[ f ]]( s, us, cf, ( 4430.83, 3445.1, 161 ), ( 0, 350, 0 ), "cspf_0_auto4591478451364530574", undefined, "0" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_trap_fire_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s._size_max = ( 75, 20, 8 );
    s._size_min = ( 82, 20, 54 );
    s.groupid = "Fire_Trap_4";
    s.height = 128;
    s.length = "128";
    s.width = "128";
    fe [[ f ]]( s, us, cf, ( 4272, 3388, 160 ), ( 0, 230, 0 ), "cspf_0_auto4591478451364530574", undefined, "2" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_trap_fire_cs";
    s.groupid = "Fire_Trap_5";
    s.name = "ft_body_5";
    s.script_label = "zm_sat_grant_trap";
    fe [[ f ]]( s, us, cf, ( 7372, 1998, 112 ), ( 0, 340, 0 ), "cspf_0_auto17046475089990957501", "cspf_0_auto5413617384564568598", "trap" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_trap_fire_cs";
    s.groupid = "Fire_Trap_5";
    s.name = "ft_switch_5";
    s.script_cost = int( 1000 );
    s.script_duration = float( 40 );
    s.script_label = "zm_sat_locust_fire_trap_switch_offensive";
    s.script_power = "power_on";
    s.script_timeout = float( 60 );
    fe [[ f ]]( s, us, cf, ( 7385, 1996.5, 209 ), ( 0, 0, 0 ), "fire_trap_switch", "cspf_0_auto17046475089990957501", "zone_robot_head", undefined, undefined, undefined, undefined, 80 );
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_trap_fire_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s._size_max = ( 75, 20, 8 );
    s._size_min = ( 84, 20, 62 );
    s.groupid = "Fire_Trap_5";
    s.height = 128;
    s.length = "128";
    s.width = "128";
    fe [[ f ]]( s, us, cf, ( 7354, 2094, 164 ), ( 0, 100, 0 ), "cspf_0_auto5413617384564568598", undefined, "1" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_trap_fire_cs";
    s.groupid = "Fire_Trap_5";
    s.name = "ft_switch_pos_5";
    s.script_label = "zm_sat_grant_trap_switch";
    fe [[ f ]]( s, us, cf, ( 7379, 1768, 169 ), ( 0, 90, 0 ), "cspf_0_auto17046475089990957501", undefined, "switch" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_trap_fire_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s._size_max = ( 75, 20, 8 );
    s._size_min = ( 88, 20, 62 );
    s.groupid = "Fire_Trap_5";
    s.height = 128;
    s.length = "128";
    s.width = "128";
    fe [[ f ]]( s, us, cf, ( 7466, 1964, 164 ), ( 0, 340, 0 ), "cspf_0_auto5413617384564568598", undefined, "0" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_trap_fire_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s._size_max = ( 75, 20, 8 );
    s._size_min = ( 82, 20, 54 );
    s.groupid = "Fire_Trap_5";
    s.height = 128;
    s.length = "128";
    s.width = "128";
    fe [[ f ]]( s, us, cf, ( 7302, 1934, 164 ), ( 0, 223, 0 ), "cspf_0_auto5413617384564568598", undefined, "2" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_trap_fire_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s._size_max = ( 75, 20, 8 );
    s._size_min = ( 60, 20, 6 );
    s.groupid = "boss_fire_trap_1";
    s.height = 128;
    s.length = "128";
    s.width = "128";
    fe [[ f ]]( s, us, cf, ( -19222, 18103, 2768 ), ( 0, 120, 0 ), "cspf_0_auto8718363935500792666", undefined, "1" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_trap_fire_cs";
    s.groupid = "fire_trap_1";
    s.name = "ft_body_1";
    s.script_label = "zm_sat_grant_trap";
    fe [[ f ]]( s, us, cf, ( 1655.8, 1113.59, 224 ), ( 0, 45, 0 ), "cspf_0_auto14577095895443065925", "cspf_0_auto214597015384405551", "trap" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_trap_fire_cs";
    s.groupid = "boss_fire_trap_1";
    s.name = "boss_ft_switch_pos";
    s.script_label = "zm_sat_grant_trap_switch";
    fe [[ f ]]( s, us, cf, ( 9114.21, 24423.7, 4811 ), ( 0, 55, 0 ), "cspf_0_auto6971569224884060195", undefined, "switch" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_trap_fire_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s._size_max = ( 75, 20, 8 );
    s._size_min = ( 60, 20, 6 );
    s.groupid = "boss_fire_trap_1";
    s.height = 128;
    s.length = "128";
    s.width = "128";
    fe [[ f ]]( s, us, cf, ( -19125, 18048.5, 2768 ), ( 0, 0, 0 ), "cspf_0_auto8718363935500792666", undefined, "0" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_trap_fire_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s._size_max = ( 75, 20, 8 );
    s._size_min = ( 60, 20, 6 );
    s.groupid = "boss_fire_trap_1";
    s.height = 128;
    s.length = "128";
    s.name = "noent_volume_trigger_box";
    s.width = "128";
    fe [[ f ]]( s, us, cf, ( -19220.5, 17992, 2768 ), ( 0, 240, 0 ), "cspf_0_auto8718363935500792666", undefined, "2" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_trap_fire_cs";
    s.groupid = "boss_fire_trap_1";
    s.name = "boss_ft_body";
    s.script_label = "zm_sat_grant_trap";
    fe [[ f ]]( s, us, cf, ( 9122.16, 24427.5, 5224.31 ), ( 0, 55, 0 ), "cspf_0_auto6971569224884060195", "cspf_0_auto8718363935500792666", "trap" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_trap_fire_cs";
    s.groupid = "boss_fire_trap_2";
    s.name = "boss_ft_switch";
    s.script_cost = int( 1000 );
    s.script_duration = float( 40 );
    s.script_label = "zm_sat_locust_fire_trap_switch_offensive";
    s.script_power = "power_on";
    s.script_timeout = float( 60 );
    fe [[ f ]]( s, us, cf, ( 9316, 25943, 4859 ), ( 0, 100, 0 ), "fire_trap_switch", "cspf_0_auto10895638006278956322", "zone_robot_head", undefined, undefined, undefined, undefined, 80 );
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_trap_fire_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s._size_max = ( 75, 20, 8 );
    s._size_min = ( 60, 20, 6 );
    s.groupid = "boss_fire_trap_2";
    s.height = 128;
    s.length = "128";
    s.width = "128";
    fe [[ f ]]( s, us, cf, ( -17997, 16995, 2512 ), ( 0, 120, 0 ), "cspf_0_auto4551143435009009256", undefined, "1" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_trap_fire_cs";
    s.groupid = "boss_fire_trap_2";
    s.name = "boss_ft_switch_pos";
    s.script_label = "zm_sat_grant_trap_switch";
    fe [[ f ]]( s, us, cf, ( 9319, 25942.5, 4436 ), ( 0, 100, 0 ), "cspf_0_auto10895638006278956322", undefined, "switch" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_trap_fire_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s._size_max = ( 75, 20, 8 );
    s._size_min = ( 60, 20, 6 );
    s.groupid = "boss_fire_trap_2";
    s.height = 128;
    s.length = "128";
    s.width = "128";
    fe [[ f ]]( s, us, cf, ( -17900, 16940.5, 2512 ), ( 0, 0, 0 ), "cspf_0_auto4551143435009009256", undefined, "0" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_trap_fire_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s._size_max = ( 75, 20, 8 );
    s._size_min = ( 60, 20, 6 );
    s.groupid = "boss_fire_trap_2";
    s.height = 128;
    s.length = "128";
    s.name = "noent_volume_trigger_box";
    s.width = "128";
    fe [[ f ]]( s, us, cf, ( -17995.5, 16884, 2512 ), ( 0, 240, 0 ), "cspf_0_auto4551143435009009256", undefined, "2" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_trap_fire_cs";
    s.groupid = "boss_fire_trap_2";
    s.name = "boss_ft_body";
    s.script_label = "zm_sat_grant_trap";
    fe [[ f ]]( s, us, cf, ( 9319, 25947, 4842 ), ( 0, 10, 0 ), "cspf_0_auto10895638006278956322", "cspf_0_auto4551143435009009256", "trap" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_trap_fire_cs";
    s.groupid = "boss_fire_trap_3";
    s.name = "boss_ft_switch";
    s.script_cost = int( 1000 );
    s.script_duration = float( 40 );
    s.script_label = "zm_sat_locust_fire_trap_switch_offensive";
    s.script_power = "power_on";
    s.script_timeout = float( 60 );
    fe [[ f ]]( s, us, cf, ( 9062.41, 27709.5, 5136.5 ), ( 0, 100, 0 ), "fire_trap_switch", "cspf_0_auto15068447491420378189", "zone_robot_head", undefined, undefined, undefined, undefined, 80 );
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_trap_fire_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s._size_max = ( 75, 20, 8 );
    s._size_min = ( 60, 20, 6 );
    s.groupid = "boss_fire_trap_3";
    s.height = 128;
    s.length = "128";
    s.width = "128";
    fe [[ f ]]( s, us, cf, ( -15973, 17632, 2672 ), ( 0, 120, 0 ), "cspf_0_auto2068197173024207293", undefined, "1" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_trap_fire_cs";
    s.groupid = "boss_fire_trap_3";
    s.name = "boss_ft_switch_pos";
    s.script_label = "zm_sat_grant_trap_switch";
    fe [[ f ]]( s, us, cf, ( 9068.91, 27703.5, 4779 ), ( 0, 100, 0 ), "cspf_0_auto15068447491420378189", undefined, "switch" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_trap_fire_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s._size_max = ( 75, 20, 8 );
    s._size_min = ( 60, 20, 6 );
    s.groupid = "boss_fire_trap_3";
    s.height = 128;
    s.length = "128";
    s.width = "128";
    fe [[ f ]]( s, us, cf, ( -15876, 17578, 2672 ), ( 0, 0, 0 ), "cspf_0_auto2068197173024207293", undefined, "0" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_trap_fire_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s._size_max = ( 75, 20, 8 );
    s._size_min = ( 60, 20, 6 );
    s.groupid = "boss_fire_trap_3";
    s.height = 128;
    s.length = "128";
    s.name = "noent_volume_trigger_box";
    s.width = "128";
    fe [[ f ]]( s, us, cf, ( -15971, 17521, 2672 ), ( 0, 240, 0 ), "cspf_0_auto2068197173024207293", undefined, "2" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_trap_fire_cs";
    s.groupid = "boss_fire_trap_3";
    s.name = "boss_ft_body";
    s.script_label = "zm_sat_grant_trap";
    fe [[ f ]]( s, us, cf, ( 9069.55, 27710.9, 5117.26 ), ( 0, 100, 0 ), "cspf_0_auto15068447491420378189", "cspf_0_auto2068197173024207293", "trap" );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace zm_sat_locust_script_trap_fire_cs
// Params 0, eflags: 0x4
// Checksum 0x75acab51, Offset: 0x28a8
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace zm_sat_locust_script_trap_fire_cs
// Params 0
// Checksum 0xb2fb352e, Offset: 0x28b2
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "zm_sat_locust_script_trap_fire_cs" );
}

