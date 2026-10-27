// scripts\mp\zm\maps\zm_sat_hornet\zm_sat_hornet_murder_holes_create_script.gsc  (hash_5917ce00fb3fd996.gscc) (size: 7291 Bytes / 0x1c7b / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x48e3451 (76428369)
// size ...... 7291 (0x1c7b)
// includes .. 2   (offset: 0x17a3)
// strings ... 58  (offset: 0x17b3)
// dev strs .. 0   (offset: 0x1c7b)
// exports ... 6   (offset: 0x14f3)
// cseg ...... 0x41d + 0x10d6 (0x14f3)
// imports ... 16  (offset: 0x15e3)
// animtree1 . 0   (offset: 0x1c7b)
// animtree2 . 0   (offset: 0x1c7b)
#using scripts\common\create_script_utility;
#using scripts\common\utility;

#namespace zm_sat_hornet_murder_holes_create_script;

// Namespace zm_sat_hornet_murder_holes_create_script
// Params 2
// Checksum 0x675a2e2e, Offset: 0x43b
// Size: 0x80
function main( unused, unused2 )
{
    if ( utility::flag_exist( "zm_sat_hornet_murder_holes_create_script" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "zm_sat_hornet_murder_holes_create_script" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "zm_sat_hornet_murder_holes_create_script" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "zm_sat_hornet_murder_holes_create_script" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace zm_sat_hornet_murder_holes_create_script
// Params 3, eflags: 0x4
// Checksum 0x5431cca8, Offset: 0x4c3
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "zm_sat_hornet_murder_holes_create_script" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "zm_sat_hornet_murder_holes_create_script" );
}

// Namespace zm_sat_hornet_murder_holes_create_script
// Params 3, eflags: 0x4
// Checksum 0xb6d5f338, Offset: 0x53d
// Size: 0xf96
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "zm_sat_hornet_murder_holes_create_script";
    s.groupid = "group_3";
    s.name = "root";
    s.script_label = "door_lava_garden_to_second_bailey";
    s.script_power = "power_on";
    fe [[ f ]]( s, us, cf, ( 2844, 2158, 256 ), ( 0, 162, 0 ), "murder_holes_trap", "mh_komainu_3", "mh_root_3" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_murder_holes_create_script";
    s.groupid = "group_1";
    fe [[ f ]]( s, us, cf, ( -242, 878.98, -103.03 ), ( 0, 171, 0 ), "mh_komainu_1", undefined, "trap" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_murder_holes_create_script";
    s.groupid = "group_2";
    s.name = "root";
    s.script_label = "door_west_bailey_to_broken_turrets";
    s.script_power = "power_on";
    fe [[ f ]]( s, us, cf, ( -2172, 1848, 128 ), ( 0, 0, 0 ), "murder_holes_trap", "mh_komainu_2", "mh_root_2" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_murder_holes_create_script";
    s.groupid = "group_4";
    fe [[ f ]]( s, us, cf, ( -84, 4686, 823 ), ( 0, 285.9, 0 ), "mh_ghosts_4_2" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_murder_holes_create_script";
    s.groupid = "group_4";
    s.name = "root";
    s.script_label = "door_main_bailey_to_main_keep";
    s.script_power = "power_on";
    fe [[ f ]]( s, us, cf, ( -308.37, 4615.38, 736 ), ( 0, 192, 0 ), "murder_holes_trap", "mh_komainu_4", "mh_root_4" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_murder_holes_create_script";
    s.groupid = "group_3";
    s.script_label = "alt";
    fe [[ f ]]( s, us, cf, ( 2970, 2146, 258.51 ), ( 0, 252, 0 ), "mh_komainu_3", "mh_sbl_3", "switch" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_murder_holes_create_script";
    s.groupid = "group_1";
    s.name = "root";
    s.script_label = "door_start_to_third_bailey_east";
    s.script_power = "power_on";
    fe [[ f ]]( s, us, cf, ( 639.57, 946.5, 199.23 ), ( 0, 160, 0 ), "murder_holes_trap", "mh_komainu_1", "mh_root_1" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_murder_holes_create_script";
    s.groupid = "group_2";
    fe [[ f ]]( s, us, cf, ( -238, 896.98, -103.03 ), ( 0, 171, 0 ), "mh_komainu_2", undefined, "trap" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_murder_holes_create_script";
    s.groupid = "group_4";
    fe [[ f ]]( s, us, cf, ( -178, 4668, 818 ), ( 0, 283.1, 0 ), "mh_ghosts_4_1" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_murder_holes_create_script";
    s.groupid = "group_2";
    s.script_label = "zm_sat_hornet_komainu";
    fe [[ f ]]( s, us, cf, ( -2185.35, 1686.28, 128 ), ( 0, 352, 0 ), "mh_komainu_2", "mh_sbl_2", "switch" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_murder_holes_create_script";
    s.groupid = "group_4";
    fe [[ f ]]( s, us, cf, ( 10, 4702, 821 ), ( 0, 284, 0 ), "mh_ghosts_4_3" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_murder_holes_create_script";
    s.groupid = "group_2";
    s.script_label = "alt";
    fe [[ f ]]( s, us, cf, ( -2147.35, 2004.28, 129.28 ), ( 0, 352, 0 ), "mh_komainu_2", "mh_sbl_2", "switch" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_murder_holes_create_script";
    s.groupid = "group_3";
    s.script_label = "zm_sat_hornet_komainu";
    fe [[ f ]]( s, us, cf, ( 2745, 2208, 258.52 ), ( 0, 252, 0 ), "mh_komainu_3", "mh_sbl_3", "switch" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_murder_holes_create_script";
    s.groupid = "group_4";
    s.script_label = "zm_sat_hornet_komainu";
    fe [[ f ]]( s, us, cf, ( -412.38, 4591.13, 744.85 ), ( 0, 278, 0 ), "mh_komainu_4", "mh_sbl_4", "switch" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_murder_holes_create_script";
    s.groupid = "group_4";
    s.script_label = "alt";
    fe [[ f ]]( s, us, cf, ( -215.88, 4623.88, 747.33 ), ( 0, 280.51, 0 ), "mh_komainu_4", "mh_sbl_4", "switch" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_murder_holes_create_script";
    s.groupid = "group_3";
    fe [[ f ]]( s, us, cf, ( -234, 914.98, -103.03 ), ( 0, 171, 0 ), "mh_komainu_3", undefined, "trap" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_murder_holes_create_script";
    s.groupid = "group_4";
    fe [[ f ]]( s, us, cf, ( -230, 932.98, -103.03 ), ( 0, 171, 0 ), "mh_komainu_4", undefined, "trap" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_murder_holes_create_script";
    s.groupid = "group_4";
    fe [[ f ]]( s, us, cf, ( 105, 4719, 826 ), ( 0, 280.3, 0 ), "mh_ghosts_4_4" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_murder_holes_create_script";
    s.groupid = "group_2";
    s.name = "upgrade";
    fe [[ f ]]( s, us, cf, ( -2200, 1489, 128 ), ( 0, 355, 0 ), undefined, undefined, "mh_upg_2" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_murder_holes_create_script";
    s.groupid = "group_1";
    s.name = "upgrade";
    fe [[ f ]]( s, us, cf, ( 102, 921, 88 ), ( 0, 270, 0 ), undefined, undefined, "mh_upg_1" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_murder_holes_create_script";
    s.groupid = "group_3";
    s.name = "upgrade";
    fe [[ f ]]( s, us, cf, ( 2665, 2236, 256 ), ( 0, 255, 0 ), undefined, undefined, "mh_upg_3" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_murder_holes_create_script";
    s.groupid = "group_1";
    s.script_label = "alt";
    fe [[ f ]]( s, us, cf, ( 797.94, 972.86, 181.09 ), ( 0, 280.34, 0 ), "mh_komainu_1", "mh_sbl_1", "switch" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_murder_holes_create_script";
    s.groupid = "group_1";
    s.script_label = "zm_sat_hornet_komainu";
    fe [[ f ]]( s, us, cf, ( 526.94, 928.83, 179.92 ), ( 0, 277, 0 ), "mh_komainu_1", "mh_sbl_1", "switch" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_murder_holes_create_script";
    s.groupid = "group_4";
    s.name = "upgrade";
    fe [[ f ]]( s, us, cf, ( -67, 4664, 736.28 ), ( 0, 280, 0 ), undefined, undefined, "mh_upg_4" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_murder_holes_create_script";
    s.groupid = "group_4";
    fe [[ f ]]( s, us, cf, ( 199, 4736, 822 ), ( 0, 274.5, 0 ), "mh_ghosts_4_5" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_murder_holes_create_script";
    s.groupid = "group_1";
    fe [[ f ]]( s, us, cf, ( 182, 923, 216 ), ( 0, 271.8, 0 ), "mh_ghosts_1_2" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_murder_holes_create_script";
    s.groupid = "group_1";
    fe [[ f ]]( s, us, cf, ( 136, 929, 217 ), ( 0, 271.8, 0 ), "mh_ghosts_1_1" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_murder_holes_create_script";
    s.groupid = "group_1";
    fe [[ f ]]( s, us, cf, ( 402, 937, 235 ), ( 0, 271.8, 0 ), "mh_ghosts_1_3" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_murder_holes_create_script";
    s.groupid = "group_1";
    fe [[ f ]]( s, us, cf, ( 447, 939, 235 ), ( 0, 271.8, 0 ), "mh_ghosts_1_4" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_murder_holes_create_script";
    s.groupid = "group_1";
    fe [[ f ]]( s, us, cf, ( 875, 1007, 278 ), ( 12.8, 277.8, 0 ), "mh_ghosts_1_5" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_murder_holes_create_script";
    s.groupid = "group_1";
    fe [[ f ]]( s, us, cf, ( 914, 1010, 273 ), ( 13.9, 278.1, 0 ), "mh_ghosts_1_6" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_murder_holes_create_script";
    s.groupid = "group_2";
    fe [[ f ]]( s, us, cf, ( -2225, 1566, 324 ), ( 0, 357, 0 ), "mh_ghosts_2_2" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_murder_holes_create_script";
    s.groupid = "group_2";
    fe [[ f ]]( s, us, cf, ( -2241, 1490, 323 ), ( 0, 357, 0 ), "mh_ghosts_2_1" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_murder_holes_create_script";
    s.groupid = "group_2";
    fe [[ f ]]( s, us, cf, ( -2205, 1805, 326 ), ( 0, 357, 0 ), "mh_ghosts_2_3" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_murder_holes_create_script";
    s.groupid = "group_2";
    fe [[ f ]]( s, us, cf, ( -2195, 1886, 326 ), ( 0, 357, 0 ), "mh_ghosts_2_4" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_murder_holes_create_script";
    s.groupid = "group_2";
    fe [[ f ]]( s, us, cf, ( -2072, 2173, 336 ), ( 0, 262.9, 0 ), "mh_ghosts_2_5" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_murder_holes_create_script";
    s.groupid = "group_2";
    fe [[ f ]]( s, us, cf, ( -2023, 2167, 334 ), ( 0, 262.9, 0 ), "mh_ghosts_2_6" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_murder_holes_create_script";
    s.groupid = "group_3";
    fe [[ f ]]( s, us, cf, ( 2439, 2640, 456 ), ( 0, 256.3, 0 ), "mh_ghosts_3_2" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_murder_holes_create_script";
    s.groupid = "group_3";
    fe [[ f ]]( s, us, cf, ( 2399, 2649, 457 ), ( 0, 256.3, 0 ), "mh_ghosts_3_1" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_murder_holes_create_script";
    s.groupid = "group_3";
    fe [[ f ]]( s, us, cf, ( 2584, 2597, 456 ), ( 0, 253, 0 ), "mh_ghosts_3_3" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_murder_holes_create_script";
    s.groupid = "group_3";
    fe [[ f ]]( s, us, cf, ( 2625, 2592, 459 ), ( 0, 253, 0 ), "mh_ghosts_3_4" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_murder_holes_create_script";
    s.groupid = "group_3";
    fe [[ f ]]( s, us, cf, ( 2851, 2233, 461 ), ( 0, 253, 0 ), "mh_ghosts_3_5" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_murder_holes_create_script";
    s.groupid = "group_3";
    fe [[ f ]]( s, us, cf, ( 2888, 2222, 460 ), ( 0, 253, 0 ), "mh_ghosts_3_6" );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace zm_sat_hornet_murder_holes_create_script
// Params 0, eflags: 0x4
// Checksum 0xcb7d1ad2, Offset: 0x14db
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace zm_sat_hornet_murder_holes_create_script
// Params 0
// Checksum 0x966211e5, Offset: 0x14e5
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "zm_sat_hornet_murder_holes_create_script" );
}

