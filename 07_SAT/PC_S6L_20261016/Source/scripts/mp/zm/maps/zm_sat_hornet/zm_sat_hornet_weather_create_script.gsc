// scripts\mp\zm\maps\zm_sat_hornet\zm_sat_hornet_weather_create_script.gsc  (hash_31a97bad504aa85b.gscc) (size: 8676 Bytes / 0x21e4 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x26efe22d (653255213)
// size ...... 8676 (0x21e4)
// includes .. 2   (offset: 0x1c00)
// strings ... 21  (offset: 0x1c10)
// dev strs .. 0   (offset: 0x21e4)
// exports ... 6   (offset: 0x1950)
// cseg ...... 0x187 + 0x17c9 (0x1950)
// imports ... 16  (offset: 0x1a40)
// animtree1 . 0   (offset: 0x21e4)
// animtree2 . 0   (offset: 0x21e4)
#using scripts\common\create_script_utility;
#using scripts\common\utility;

#namespace zm_sat_hornet_weather_create_script;

// Namespace zm_sat_hornet_weather_create_script
// Params 2
// Checksum 0x644c8e5d, Offset: 0x1a5
// Size: 0x80
function main( unused, unused2 )
{
    if ( utility::flag_exist( "zm_sat_hornet_weather_create_script" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "zm_sat_hornet_weather_create_script" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "zm_sat_hornet_weather_create_script" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "zm_sat_hornet_weather_create_script" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace zm_sat_hornet_weather_create_script
// Params 3, eflags: 0x4
// Checksum 0x57276cdb, Offset: 0x22d
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "zm_sat_hornet_weather_create_script" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "zm_sat_hornet_weather_create_script" );
}

// Namespace zm_sat_hornet_weather_create_script
// Params 3, eflags: 0x4
// Checksum 0x180f7bc0, Offset: 0x2a7
// Size: 0x1689
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "zm_sat_hornet_weather_create_script";
    s.groupid = "zone_main_bailey";
    fe [[ f ]]( s, us, cf, ( 484, -20198, 619.6 ), ( 0, 0, 0 ), "cb_waypoint", "zone_main_bailey", "2" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_weather_create_script";
    s.groupid = "zone_second_bailey";
    fe [[ f ]]( s, us, cf, ( 2880, -20812, 408.15 ), ( 0, 0, 0 ), "cb_waypoint", "zone_second_bailey", "2" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_weather_create_script";
    fe [[ f ]]( s, us, cf, ( 114, -20480, 726 ), ( 0, 0, 0 ), "cb_big_center" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_weather_create_script";
    s.groupid = "zone_main_bailey";
    fe [[ f ]]( s, us, cf, ( 26, -20200, 727.69 ), ( 0, 0, 0 ), "cb_waypoint", "zone_main_bailey", "1" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_weather_create_script";
    s.groupid = "zone_main_bailey";
    fe [[ f ]]( s, us, cf, ( 442, -20416, 624.87 ), ( 0, 0, 0 ), "cb_waypoint", "zone_main_bailey", "4" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_weather_create_script";
    s.groupid = "zone_main_bailey";
    fe [[ f ]]( s, us, cf, ( 90, -20406, 687.8 ), ( 0, 0, 0 ), "cb_waypoint", "zone_main_bailey", "3" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_weather_create_script";
    s.groupid = "zone_main_bailey";
    fe [[ f ]]( s, us, cf, ( 510, -20752, 619.99 ), ( 0, 0, 0 ), "cb_waypoint", "zone_main_bailey", "8" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_weather_create_script";
    s.groupid = "zone_main_bailey";
    fe [[ f ]]( s, us, cf, ( 28, -20802, 617.38 ), ( 0, 0, 0 ), "cb_waypoint", "zone_main_bailey", "6" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_weather_create_script";
    s.groupid = "zone_main_bailey";
    fe [[ f ]]( s, us, cf, ( 270, -20568, 732.06 ), ( 0, 0, 0 ), "cb_waypoint", "zone_main_bailey", "7" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_weather_create_script";
    s.groupid = "zone_main_bailey";
    fe [[ f ]]( s, us, cf, ( 264, -20196, 668.34 ), ( 0, 0, 0 ), "cb_waypoint", "zone_main_bailey", "5" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_weather_create_script";
    s.groupid = "zone_second_bailey";
    fe [[ f ]]( s, us, cf, ( 2440, -20776, 417.4 ), ( 0, 0, 0 ), "cb_waypoint", "zone_second_bailey", "1" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_weather_create_script";
    s.groupid = "zone_second_bailey";
    fe [[ f ]]( s, us, cf, ( 2796, -20974, 415.91 ), ( 0, 0, 0 ), "cb_waypoint", "zone_second_bailey", "4" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_weather_create_script";
    s.groupid = "zone_second_bailey";
    fe [[ f ]]( s, us, cf, ( 2488, -20936, 410.9 ), ( 0, 0, 0 ), "cb_waypoint", "zone_second_bailey", "3" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_weather_create_script";
    s.groupid = "zone_second_bailey";
    fe [[ f ]]( s, us, cf, ( 2786, -21330, 399.66 ), ( 0, 0, 0 ), "cb_waypoint", "zone_second_bailey", "8" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_weather_create_script";
    s.groupid = "zone_second_bailey";
    fe [[ f ]]( s, us, cf, ( 2426, -21216, 403.85 ), ( 0, 0, 0 ), "cb_waypoint", "zone_second_bailey", "6" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_weather_create_script";
    s.groupid = "zone_second_bailey";
    fe [[ f ]]( s, us, cf, ( 2642, -21074, 401.5 ), ( 0, 0, 0 ), "cb_waypoint", "zone_second_bailey", "7" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_weather_create_script";
    s.groupid = "zone_second_bailey";
    fe [[ f ]]( s, us, cf, ( 2678, -20772, 415.1 ), ( 0, 0, 0 ), "cb_waypoint", "zone_second_bailey", "5" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_weather_create_script";
    s.groupid = "zone_lava_garden";
    fe [[ f ]]( s, us, cf, ( 2661.56, -22880.5, 282.68 ), ( 0, 296, 0 ), "cb_waypoint", "zone_lava_garden", "2" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_weather_create_script";
    s.groupid = "zone_lava_garden";
    fe [[ f ]]( s, us, cf, ( 2501.04, -22469.3, 186.31 ), ( 0, 296, 0 ), "cb_waypoint", "zone_lava_garden", "1" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_weather_create_script";
    s.groupid = "zone_lava_garden";
    fe [[ f ]]( s, us, cf, ( 2527.14, -22886, 225.77 ), ( 0, 296, 0 ), "cb_waypoint", "zone_lava_garden", "4" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_weather_create_script";
    s.groupid = "zone_lava_garden";
    fe [[ f ]]( s, us, cf, ( 2378.27, -22582.5, 224.73 ), ( 0, 296, 0 ), "cb_waypoint", "zone_lava_garden", "3" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_weather_create_script";
    s.groupid = "zone_lava_garden";
    fe [[ f ]]( s, us, cf, ( 2204.78, -23017.1, 185.98 ), ( 0, 296, 0 ), "cb_waypoint", "zone_lava_garden", "8" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_weather_create_script";
    s.groupid = "zone_lava_garden";
    fe [[ f ]]( s, us, cf, ( 2103.43, -22693.6, 201.35 ), ( 0, 296, 0 ), "cb_waypoint", "zone_lava_garden", "6" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_weather_create_script";
    s.groupid = "zone_lava_garden";
    fe [[ f ]]( s, us, cf, ( 2349.75, -22783.4, 173 ), ( 0, 296, 0 ), "cb_waypoint", "zone_lava_garden", "7" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_weather_create_script";
    s.groupid = "zone_lava_garden";
    fe [[ f ]]( s, us, cf, ( 2640.96, -22669.4, 200.67 ), ( 0, 296, 0 ), "cb_waypoint", "zone_lava_garden", "5" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_weather_create_script";
    s.groupid = "zone_third_bailey";
    fe [[ f ]]( s, us, cf, ( -70.23, -22236.6, 180.42 ), ( 0, 84, 0 ), "cb_waypoint", "zone_third_bailey", "2" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_weather_create_script";
    s.groupid = "zone_third_bailey";
    fe [[ f ]]( s, us, cf, ( -116.11, -22692.3, 158.91 ), ( 0, 84, 0 ), "cb_waypoint", "zone_third_bailey", "1" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_weather_create_script";
    s.groupid = "zone_third_bailey";
    fe [[ f ]]( s, us, cf, ( 142.19, -22301.1, 215.27 ), ( 0, 84, 0 ), "cb_waypoint", "zone_third_bailey", "4" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_weather_create_script";
    s.groupid = "zone_third_bailey";
    fe [[ f ]]( s, us, cf, ( 95.45, -22650.2, 199.64 ), ( 0, 84, 0 ), "cb_waypoint", "zone_third_bailey", "3" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_weather_create_script";
    s.groupid = "zone_third_bailey";
    fe [[ f ]]( s, us, cf, ( 483.46, -22268.6, 172.47 ), ( 0, 84, 0 ), "cb_waypoint", "zone_third_bailey", "8" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_weather_create_script";
    s.groupid = "zone_third_bailey";
    fe [[ f ]]( s, us, cf, ( 540.8, -22647.2, 174.9 ), ( 0, 84, 0 ), "cb_waypoint", "zone_third_bailey", "6" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_weather_create_script";
    s.groupid = "zone_third_bailey";
    fe [[ f ]]( s, us, cf, ( 265.38, -22486.1, 214.23 ), ( 0, 84, 0 ), "cb_waypoint", "zone_third_bailey", "7" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_weather_create_script";
    s.groupid = "zone_third_bailey";
    fe [[ f ]]( s, us, cf, ( -57.21, -22425.2, 172.94 ), ( 0, 84, 0 ), "cb_waypoint", "zone_third_bailey", "5" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_weather_create_script";
    s.groupid = "zone_lava_tubes";
    fe [[ f ]]( s, us, cf, ( -119.4, -24546.2, 278.87 ), ( 0, 174, 0 ), "cb_waypoint", "zone_lava_tubes", "2" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_weather_create_script";
    s.groupid = "zone_lava_tubes";
    fe [[ f ]]( s, us, cf, ( 336.3, -24592.1, 256.46 ), ( 0, 174, 0 ), "cb_waypoint", "zone_lava_tubes", "1" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_weather_create_script";
    s.groupid = "zone_lava_tubes";
    fe [[ f ]]( s, us, cf, ( -54.9, -24333.8, 209.7 ), ( 0, 174, 0 ), "cb_waypoint", "zone_lava_tubes", "4" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_weather_create_script";
    s.groupid = "zone_lava_tubes";
    fe [[ f ]]( s, us, cf, ( 294.2, -24380.6, 227.78 ), ( 0, 174, 0 ), "cb_waypoint", "zone_lava_tubes", "3" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_weather_create_script";
    s.groupid = "zone_lava_tubes";
    fe [[ f ]]( s, us, cf, ( -67.4, -24104.5, 162.04 ), ( 0, 174, 0 ), "cb_waypoint", "zone_lava_tubes", "8" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_weather_create_script";
    s.groupid = "zone_lava_tubes";
    fe [[ f ]]( s, us, cf, ( 311.2, -24053.2, 89.7 ), ( 0, 174, 0 ), "cb_waypoint", "zone_lava_tubes", "6" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_weather_create_script";
    s.groupid = "zone_lava_tubes";
    fe [[ f ]]( s, us, cf, ( 130.1, -24210.6, 173.69 ), ( 0, 174, 0 ), "cb_waypoint", "zone_lava_tubes", "7" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_weather_create_script";
    s.groupid = "zone_lava_tubes";
    fe [[ f ]]( s, us, cf, ( 117.2, -24517.2, 288.32 ), ( 0, 174, 0 ), "cb_waypoint", "zone_lava_tubes", "5" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_weather_create_script";
    s.groupid = "zone_west_bailey";
    fe [[ f ]]( s, us, cf, ( -1971.18, -22868.7, 162 ), ( 0, 126, 0 ), "cb_waypoint", "zone_west_bailey", "2" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_weather_create_script";
    s.groupid = "zone_west_bailey";
    fe [[ f ]]( s, us, cf, ( -1700.37, -23238.1, 175.82 ), ( 0, 126, 0 ), "cb_waypoint", "zone_west_bailey", "1" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_weather_create_script";
    s.groupid = "zone_west_bailey";
    fe [[ f ]]( s, us, cf, ( -1588.18, -22648.5, 209.58 ), ( 0, 126, 0 ), "cb_waypoint", "zone_west_bailey", "4" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_weather_create_script";
    s.groupid = "zone_west_bailey";
    fe [[ f ]]( s, us, cf, ( -1395.37, -22899.3, 239.75 ), ( 0, 126, 0 ), "cb_waypoint", "zone_west_bailey", "3" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_weather_create_script";
    s.groupid = "zone_west_bailey";
    fe [[ f ]]( s, us, cf, ( -1420.14, -22495.8, 278.32 ), ( 0, 126, 0 ), "cb_waypoint", "zone_west_bailey", "8" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_weather_create_script";
    s.groupid = "zone_west_bailey";
    fe [[ f ]]( s, us, cf, ( -1190.69, -22764.8, 311.28 ), ( 0, 126, 0 ), "cb_waypoint", "zone_west_bailey", "6" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_weather_create_script";
    s.groupid = "zone_west_bailey";
    fe [[ f ]]( s, us, cf, ( -1428.84, -22691.6, 357.55 ), ( 0, 126, 0 ), "cb_waypoint", "zone_west_bailey", "7" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_weather_create_script";
    s.groupid = "zone_west_bailey";
    fe [[ f ]]( s, us, cf, ( -1791.32, -23025.1, 162 ), ( 0, 126, 0 ), "cb_waypoint", "zone_west_bailey", "5" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_weather_create_script";
    s.groupid = "zone_broken_turrets";
    fe [[ f ]]( s, us, cf, ( -2516, -21504, 255.9 ), ( 0, 0, 0 ), "cb_waypoint", "zone_broken_turrets", "2" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_weather_create_script";
    s.groupid = "zone_broken_turrets";
    fe [[ f ]]( s, us, cf, ( -2974, -21506, 135.06 ), ( 0, 0, 0 ), "cb_waypoint", "zone_broken_turrets", "1" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_weather_create_script";
    s.groupid = "zone_broken_turrets";
    fe [[ f ]]( s, us, cf, ( -2558, -21722, 233.18 ), ( 0, 0, 0 ), "cb_waypoint", "zone_broken_turrets", "4" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_weather_create_script";
    s.groupid = "zone_broken_turrets";
    fe [[ f ]]( s, us, cf, ( -2910, -21712, 153.37 ), ( 0, 0, 0 ), "cb_waypoint", "zone_broken_turrets", "3" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_weather_create_script";
    s.groupid = "zone_broken_turrets";
    fe [[ f ]]( s, us, cf, ( -2490, -22058, 263.53 ), ( 0, 0, 0 ), "cb_waypoint", "zone_broken_turrets", "8" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_weather_create_script";
    s.groupid = "zone_broken_turrets";
    fe [[ f ]]( s, us, cf, ( -2972, -22108, 161.85 ), ( 0, 0, 0 ), "cb_waypoint", "zone_broken_turrets", "6" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_weather_create_script";
    s.groupid = "zone_broken_turrets";
    fe [[ f ]]( s, us, cf, ( -2730, -21874, 185.72 ), ( 0, 0, 0 ), "cb_waypoint", "zone_broken_turrets", "7" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_weather_create_script";
    s.groupid = "zone_broken_turrets";
    fe [[ f ]]( s, us, cf, ( -2736, -21502, 178.53 ), ( 0, 0, 0 ), "cb_waypoint", "zone_broken_turrets", "5" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_weather_create_script";
    s.groupid = "zone_main_keep";
    fe [[ f ]]( s, us, cf, ( -52, -17928, 916 ), ( 0, 0, 0 ), "cb_waypoint", "zone_main_keep", "2" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_weather_create_script";
    s.groupid = "zone_main_keep";
    fe [[ f ]]( s, us, cf, ( -556, -17992, 1020.38 ), ( 0, 0, 0 ), "cb_waypoint", "zone_main_keep", "1" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_weather_create_script";
    s.groupid = "zone_main_keep";
    fe [[ f ]]( s, us, cf, ( -128, -18110, 916 ), ( 0, 0, 0 ), "cb_waypoint", "zone_main_keep", "4" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_weather_create_script";
    s.groupid = "zone_main_keep";
    fe [[ f ]]( s, us, cf, ( -462, -18180, 993.88 ), ( 0, 0, 0 ), "cb_waypoint", "zone_main_keep", "3" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_weather_create_script";
    s.groupid = "zone_main_keep";
    fe [[ f ]]( s, us, cf, ( -56, -18468, 930.38 ), ( 0, 0, 0 ), "cb_waypoint", "zone_main_keep", "8" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_weather_create_script";
    s.groupid = "zone_main_keep";
    fe [[ f ]]( s, us, cf, ( -444, -18548, 916 ), ( 0, 0, 0 ), "cb_waypoint", "zone_main_keep", "6" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_weather_create_script";
    s.groupid = "zone_main_keep";
    fe [[ f ]]( s, us, cf, ( -296, -18290, 940 ), ( 0, 0, 0 ), "cb_waypoint", "zone_main_keep", "7" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_weather_create_script";
    s.groupid = "zone_main_keep";
    fe [[ f ]]( s, us, cf, ( -328, -17954, 958.18 ), ( 0, 0, 0 ), "cb_waypoint", "zone_main_keep", "5" );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace zm_sat_hornet_weather_create_script
// Params 0, eflags: 0x4
// Checksum 0x34bdeb25, Offset: 0x1938
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace zm_sat_hornet_weather_create_script
// Params 0
// Checksum 0x9574b196, Offset: 0x1942
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "zm_sat_hornet_weather_create_script" );
}

