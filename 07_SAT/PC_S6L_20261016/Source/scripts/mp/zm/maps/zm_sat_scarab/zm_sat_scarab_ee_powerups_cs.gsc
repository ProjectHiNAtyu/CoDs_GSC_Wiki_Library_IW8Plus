// scripts\mp\zm\maps\zm_sat_scarab\zm_sat_scarab_ee_powerups_cs.gsc  (hash_5a08a5b9668b9bed.gscc) (size: 2581 Bytes / 0xa15 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x12934231 (311640625)
// size ...... 2581 (0xa15)
// includes .. 3   (offset: 0x8fd)
// strings ... 14  (offset: 0x915)
// dev strs .. 0   (offset: 0xa15)
// exports ... 9   (offset: 0x565)
// cseg ...... 0x13b + 0x42a (0x565)
// imports ... 20  (offset: 0x6cd)
// animtree1 . 0   (offset: 0xa15)
// animtree2 . 0   (offset: 0xa15)
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace zm_sat_scarab_ee_powerups_cs;

// Namespace zm_sat_scarab_ee_powerups_cs
// Params 0, eflags: 0x5
// Checksum 0x74896db3, Offset: 0x159
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"zm_sat_scarab_ee_powerups_cs", undefined, &function_b39ecd3d51489472, undefined );
}

// Namespace zm_sat_scarab_ee_powerups_cs
// Params 0, eflags: 0x4
// Checksum 0xf6ff54a5, Offset: 0x17a
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace zm_sat_scarab_ee_powerups_cs
// Params 0, eflags: 0x4
// Checksum 0x73c48749, Offset: 0x18b
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace zm_sat_scarab_ee_powerups_cs
// Params 2
// Checksum 0xc32dd100, Offset: 0x19c
// Size: 0x80
function main( unused, unused2 )
{
    if ( utility::flag_exist( "zm_sat_scarab_ee_powerups_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "zm_sat_scarab_ee_powerups_cs" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "zm_sat_scarab_ee_powerups_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "zm_sat_scarab_ee_powerups_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace zm_sat_scarab_ee_powerups_cs
// Params 3, eflags: 0x4
// Checksum 0xf0463386, Offset: 0x224
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "zm_sat_scarab_ee_powerups_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "zm_sat_scarab_ee_powerups_cs" );
}

// Namespace zm_sat_scarab_ee_powerups_cs
// Params 3, eflags: 0x4
// Checksum 0x25e9d84c, Offset: 0x29e
// Size: 0x2a7
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "zm_sat_scarab_ee_powerups_cs";
    fe [[ f ]]( s, us, cf, ( 575.25, 4784.25, 710 ), ( 12.05, 261.19, -65.68 ), "pu_ee_complete_spawn", undefined, "free_perk" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_ee_powerups_cs";
    fe [[ f ]]( s, us, cf, ( -1187.75, -5601.75, 1187.75 ), ( 0, 40.9, 0 ), "pu_ee_spawn", undefined, "bonus_points_team" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_ee_powerups_cs";
    fe [[ f ]]( s, us, cf, ( -2509, 1320, 1992 ), ( 0, 133.11, 0 ), "pu_ee_spawn", undefined, "full_power" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_ee_powerups_cs";
    fe [[ f ]]( s, us, cf, ( 9103.5, 940.14, 1115.71 ), ( 7.04, 119.37, -3.64 ), "pu_ee_spawn", undefined, "nuke" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_ee_powerups_cs";
    fe [[ f ]]( s, us, cf, ( 591.5, -6678.5, 1297.25 ), ( 0, 191.76, 0 ), "pu_ee_spawn", undefined, "double_points" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_ee_powerups_cs";
    fe [[ f ]]( s, us, cf, ( -4281.75, -2060.25, 1134 ), ( 0, 132.65, 0 ), "pu_ee_spawn", undefined, "insta_kill" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_ee_powerups_cs";
    fe [[ f ]]( s, us, cf, ( 1554.75, 1158.75, 1692.75 ), ( 0, 32.64, 0 ), "pu_ee_spawn", undefined, "full_armor" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_ee_powerups_cs";
    fe [[ f ]]( s, us, cf, ( -6272.75, 2552, 1354.25 ), ( 0, 7.43, 0 ), "pu_ee_complete_spawn", undefined, "fire_sale" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_ee_powerups_cs";
    fe [[ f ]]( s, us, cf, ( -438.11, -4011.29, 1902.5 ), ( 0, 102, 0 ), "pu_ee_spawn", undefined, "full_ammo" );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace zm_sat_scarab_ee_powerups_cs
// Params 0, eflags: 0x4
// Checksum 0xe77621ef, Offset: 0x54d
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace zm_sat_scarab_ee_powerups_cs
// Params 0
// Checksum 0x3215eecb, Offset: 0x557
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "zm_sat_scarab_ee_powerups_cs" );
}

