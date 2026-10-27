// scripts\mp\zm\maps\zm_sat_locust\zm_sat_locust_powerups_ee_cs.gsc  (hash_59dde8f8e68dd1c3.gscc) (size: 2602 Bytes / 0xa2a / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x35d2bbef (903003119)
// size ...... 2602 (0xa2a)
// includes .. 3   (offset: 0x90e)
// strings ... 14  (offset: 0x926)
// dev strs .. 0   (offset: 0xa2a)
// exports ... 9   (offset: 0x576)
// cseg ...... 0x13b + 0x43b (0x576)
// imports ... 20  (offset: 0x6de)
// animtree1 . 0   (offset: 0xa2a)
// animtree2 . 0   (offset: 0xa2a)
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace zm_sat_locust_powerups_ee_cs;

// Namespace zm_sat_locust_powerups_ee_cs
// Params 0, eflags: 0x5
// Checksum 0xd80d45f, Offset: 0x159
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"zm_sat_locust_powerups_ee_cs", undefined, &function_b39ecd3d51489472, undefined );
}

// Namespace zm_sat_locust_powerups_ee_cs
// Params 0, eflags: 0x4
// Checksum 0x151cf75b, Offset: 0x17a
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace zm_sat_locust_powerups_ee_cs
// Params 0, eflags: 0x4
// Checksum 0x902724b7, Offset: 0x18b
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace zm_sat_locust_powerups_ee_cs
// Params 2
// Checksum 0x20ce72fe, Offset: 0x19c
// Size: 0x80
function main( unused, unused2 )
{
    if ( utility::flag_exist( "zm_sat_locust_powerups_ee_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "zm_sat_locust_powerups_ee_cs" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "zm_sat_locust_powerups_ee_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "zm_sat_locust_powerups_ee_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace zm_sat_locust_powerups_ee_cs
// Params 3, eflags: 0x4
// Checksum 0x13a59078, Offset: 0x224
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "zm_sat_locust_powerups_ee_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "zm_sat_locust_powerups_ee_cs" );
}

// Namespace zm_sat_locust_powerups_ee_cs
// Params 3, eflags: 0x4
// Checksum 0x4220b9de, Offset: 0x29e
// Size: 0x2b8
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "zm_sat_locust_powerups_ee_cs";
    fe [[ f ]]( s, us, cf, ( 6798, 2160, 163 ), ( 0, 259.4, -20 ), "pu_ee_spawn", undefined, "bonus_points_team" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_powerups_ee_cs";
    fe [[ f ]]( s, us, cf, ( 225, 3079, 264 ), ( 0, 210, 0 ), "pu_ee_spawn", undefined, "full_power" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_powerups_ee_cs";
    fe [[ f ]]( s, us, cf, ( -2820, 4289, 246 ), ( 0, 300, 0 ), "pu_ee_spawn", undefined, "nuke" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_powerups_ee_cs";
    fe [[ f ]]( s, us, cf, ( 1220, 8562, 485.13 ), ( 6.8, 0, 0 ), "pu_ee_spawn", undefined, "double_points" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_powerups_ee_cs";
    fe [[ f ]]( s, us, cf, ( 6276, 6320, 302 ), ( 0, 225, 0 ), "pu_ee_spawn", undefined, "insta_kill" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_powerups_ee_cs";
    fe [[ f ]]( s, us, cf, ( 3893, 924, 319.01 ), ( 0, 253.8, 0 ), "pu_ee_spawn", undefined, "full_armor" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_powerups_ee_cs";
    fe [[ f ]]( s, us, cf, ( 3253, 3773, 410.01 ), ( 352.02, 98.54, 12.27 ), "pu_ee_complete_spawn", undefined, "fire_sale" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_powerups_ee_cs";
    fe [[ f ]]( s, us, cf, ( 2427, 5969, 463.01 ), ( 0, 77.5, 0 ), "pu_ee_spawn", undefined, "full_ammo" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_powerups_ee_cs";
    s.name = "free_perk";
    fe [[ f ]]( s, us, cf, ( 3681, -1022, 289 ), ( 0, 0, 0 ), "pu_ee_complete_spawn", undefined, "free_perk" );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace zm_sat_locust_powerups_ee_cs
// Params 0, eflags: 0x4
// Checksum 0x3f0ea101, Offset: 0x55e
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace zm_sat_locust_powerups_ee_cs
// Params 0
// Checksum 0xd1f64d35, Offset: 0x568
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "zm_sat_locust_powerups_ee_cs" );
}

