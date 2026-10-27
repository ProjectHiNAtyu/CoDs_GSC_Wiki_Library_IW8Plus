// scripts\mp\zm\maps\zm_sat_hornet\zm_sat_hornet_ee_powerups_cs.gsc  (hash_565a749c4d25bead.gscc) (size: 2652 Bytes / 0xa5c / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x118e049e (294519966)
// size ...... 2652 (0xa5c)
// includes .. 3   (offset: 0x93c)
// strings ... 14  (offset: 0x954)
// dev strs .. 0   (offset: 0xa5c)
// exports ... 9   (offset: 0x5a4)
// cseg ...... 0x13b + 0x469 (0x5a4)
// imports ... 20  (offset: 0x70c)
// animtree1 . 0   (offset: 0xa5c)
// animtree2 . 0   (offset: 0xa5c)
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace zm_sat_hornet_ee_powerups_cs;

// Namespace zm_sat_hornet_ee_powerups_cs
// Params 0, eflags: 0x5
// Checksum 0x8f752ca5, Offset: 0x159
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"zm_sat_hornet_ee_powerups_cs", undefined, &function_b39ecd3d51489472, undefined );
}

// Namespace zm_sat_hornet_ee_powerups_cs
// Params 0, eflags: 0x4
// Checksum 0x1e6b8239, Offset: 0x17a
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace zm_sat_hornet_ee_powerups_cs
// Params 0, eflags: 0x4
// Checksum 0x9b5051d5, Offset: 0x18b
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace zm_sat_hornet_ee_powerups_cs
// Params 2
// Checksum 0x2bb9079c, Offset: 0x19c
// Size: 0x80
function main( unused, unused2 )
{
    if ( utility::flag_exist( "zm_sat_hornet_ee_powerups_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "zm_sat_hornet_ee_powerups_cs" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "zm_sat_hornet_ee_powerups_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "zm_sat_hornet_ee_powerups_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace zm_sat_hornet_ee_powerups_cs
// Params 3, eflags: 0x4
// Checksum 0x18d2e51a, Offset: 0x224
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "zm_sat_hornet_ee_powerups_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "zm_sat_hornet_ee_powerups_cs" );
}

// Namespace zm_sat_hornet_ee_powerups_cs
// Params 3, eflags: 0x4
// Checksum 0x59569174, Offset: 0x29e
// Size: 0x2e6
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_powerups_cs";
    fe [[ f ]]( s, us, cf, ( -2486, -21173, 43.28 ), ( 353.28, 202.74, -68.73 ), "pu_ee_spawn", undefined, "nuke" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_powerups_cs";
    fe [[ f ]]( s, us, cf, ( -735, -17969, 1032 ), ( 0, 341.8, -46.1 ), "pu_ee_spawn", undefined, "insta_kill" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_powerups_cs";
    fe [[ f ]]( s, us, cf, ( 4410, -23679, 136 ), ( 0, 204.3, 0 ), "pu_ee_spawn", undefined, "full_power" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_powerups_cs";
    fe [[ f ]]( s, us, cf, ( 2875, -21511, 502 ), ( 87.65, 85.93, -82.23 ), "pu_ee_spawn", undefined, "bonus_points_team" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_powerups_cs";
    fe [[ f ]]( s, us, cf, ( -345, -20521, 1330 ), ( 25.3, 131.69, -45.93 ), "pu_ee_spawn", undefined, "double_points" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_powerups_cs";
    fe [[ f ]]( s, us, cf, ( 455, -18884, 1024.75 ), ( 356.6, 180, -90 ), "pu_ee_complete_spawn", undefined, "fire_sale" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_powerups_cs";
    fe [[ f ]]( s, us, cf, ( -572, -17300, 1190 ), ( 6.48, 114.27, 2.91 ), "pu_ee_spawn", undefined, "full_armor" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_powerups_cs";
    fe [[ f ]]( s, us, cf, ( 2903, -21459, 568 ), ( 0, 256.3, 0 ), undefined, undefined, "bonus_points_team" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_powerups_cs";
    fe [[ f ]]( s, us, cf, ( 2220, -19928, 487.99 ), ( 0, 270, 0 ), "pu_ee_complete_spawn", undefined, "free_perk" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_powerups_cs";
    fe [[ f ]]( s, us, cf, ( -1902, -21786, 294 ), ( 0, 0, 0 ), "pu_ee_spawn", undefined, "full_ammo" );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace zm_sat_hornet_ee_powerups_cs
// Params 0, eflags: 0x4
// Checksum 0x8d2cbbe5, Offset: 0x58c
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace zm_sat_hornet_ee_powerups_cs
// Params 0
// Checksum 0xda813857, Offset: 0x596
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "zm_sat_hornet_ee_powerups_cs" );
}

