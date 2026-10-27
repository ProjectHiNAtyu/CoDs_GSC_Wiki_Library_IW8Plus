// scripts\mp\zm\maps\zm_sat_firefly\zm_sat_firefly_script_powerups_ee_create_script.gsc  (hash_2ec0dc4156eb3963.gscc) (size: 2663 Bytes / 0xa67 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x1a79b448 (444183624)
// size ...... 2663 (0xa67)
// includes .. 3   (offset: 0x94f)
// strings ... 14  (offset: 0x967)
// dev strs .. 0   (offset: 0xa67)
// exports ... 9   (offset: 0x5b7)
// cseg ...... 0x14e + 0x469 (0x5b7)
// imports ... 20  (offset: 0x71f)
// animtree1 . 0   (offset: 0xa67)
// animtree2 . 0   (offset: 0xa67)
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace zm_sat_firefly_script_powerups_ee_create_script;

// Namespace zm_sat_firefly_script_powerups_ee_create_script
// Params 0, eflags: 0x5
// Checksum 0xf3057e6e, Offset: 0x16c
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"zm_sat_firefly_script_powerups_ee_create_script", undefined, &function_b39ecd3d51489472, undefined );
}

// Namespace zm_sat_firefly_script_powerups_ee_create_script
// Params 0, eflags: 0x4
// Checksum 0x97f83795, Offset: 0x18d
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace zm_sat_firefly_script_powerups_ee_create_script
// Params 0, eflags: 0x4
// Checksum 0x12c3e479, Offset: 0x19e
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace zm_sat_firefly_script_powerups_ee_create_script
// Params 2
// Checksum 0xa22ab230, Offset: 0x1af
// Size: 0x80
function main( unused, unused2 )
{
    if ( utility::flag_exist( "zm_sat_firefly_script_powerups_ee_create_script" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "zm_sat_firefly_script_powerups_ee_create_script" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "zm_sat_firefly_script_powerups_ee_create_script" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "zm_sat_firefly_script_powerups_ee_create_script" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace zm_sat_firefly_script_powerups_ee_create_script
// Params 3, eflags: 0x4
// Checksum 0x914150b6, Offset: 0x237
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "zm_sat_firefly_script_powerups_ee_create_script" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "zm_sat_firefly_script_powerups_ee_create_script" );
}

// Namespace zm_sat_firefly_script_powerups_ee_create_script
// Params 3, eflags: 0x4
// Checksum 0x138d8815, Offset: 0x2b1
// Size: 0x2e6
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_powerups_ee_create_script";
    fe [[ f ]]( s, us, cf, ( 17911, 2885, 766 ), ( 12.05, 261.19, -65.68 ), "pu_ee_complete_spawn", undefined, "free_perk", undefined, undefined, undefined, undefined, undefined, undefined, undefined );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_powerups_ee_create_script";
    fe [[ f ]]( s, us, cf, ( -13181, 3266, 922 ), ( 0, 45, 0 ), "pu_ee_spawn", undefined, "bonus_points_team", undefined, undefined, undefined, undefined, undefined, undefined, undefined );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_powerups_ee_create_script";
    fe [[ f ]]( s, us, cf, ( -7454, -7670, 1504 ), ( 0, 99.87, 0 ), "pu_ee_spawn", undefined, "full_power", undefined, undefined, undefined, undefined, undefined, undefined, undefined );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_powerups_ee_create_script";
    fe [[ f ]]( s, us, cf, ( 4968.25, -1405.86, 503.46 ), ( 7.04, 119.37, -3.64 ), "pu_ee_spawn", undefined, "nuke", undefined, undefined, undefined, undefined, undefined, undefined, undefined );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_powerups_ee_create_script";
    fe [[ f ]]( s, us, cf, ( 10778, 496, 1152 ), ( 0, 206.59, 0 ), "pu_ee_spawn", undefined, "double_points", undefined, undefined, undefined, undefined, undefined, undefined, undefined );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_powerups_ee_create_script";
    fe [[ f ]]( s, us, cf, ( 12953, -4331, 1364 ), ( 0, 132.65, 0 ), "pu_ee_spawn", undefined, "insta_kill", undefined, undefined, undefined, undefined, undefined, undefined, undefined );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_powerups_ee_create_script";
    fe [[ f ]]( s, us, cf, ( 8802, -4396, 781 ), ( 0, 284.04, 0 ), "pu_ee_spawn", undefined, "full_armor", undefined, undefined, undefined, undefined, undefined, undefined, undefined );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_powerups_ee_create_script";
    fe [[ f ]]( s, us, cf, ( 13363, 2195, 1435 ), ( 0, 7.43, 0 ), "pu_ee_complete_spawn", undefined, "fire_sale", undefined, undefined, undefined, undefined, undefined, undefined, undefined );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_powerups_ee_create_script";
    fe [[ f ]]( s, us, cf, ( 23113, -600, 614 ), ( 0, 277.6, 0 ), "pu_ee_spawn", undefined, "full_ammo", undefined, undefined, undefined, undefined, undefined, undefined, undefined );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace zm_sat_firefly_script_powerups_ee_create_script
// Params 0, eflags: 0x4
// Checksum 0xd62687cc, Offset: 0x59f
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace zm_sat_firefly_script_powerups_ee_create_script
// Params 0
// Checksum 0x53128dfb, Offset: 0x5a9
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "zm_sat_firefly_script_powerups_ee_create_script" );
}

