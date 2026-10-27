// scripts\mp\zm\maps\zm_sat_firefly\zm_sat_firefly_script_pluto_upgrade_cs.gsc  (hash_396ab71ba4409a1c.gscc) (size: 3294 Bytes / 0xcde / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x5c438baf (1547930543)
// size ...... 3294 (0xcde)
// includes .. 3   (offset: 0xb6e)
// strings ... 20  (offset: 0xb86)
// dev strs .. 0   (offset: 0xcde)
// exports ... 9   (offset: 0x7d6)
// cseg ...... 0x23b + 0x59b (0x7d6)
// imports ... 20  (offset: 0x93e)
// animtree1 . 0   (offset: 0xcde)
// animtree2 . 0   (offset: 0xcde)
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace zm_sat_firefly_script_pluto_upgrade_cs;

// Namespace zm_sat_firefly_script_pluto_upgrade_cs
// Params 0, eflags: 0x5
// Checksum 0xb87510bb, Offset: 0x259
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"zm_sat_firefly_script_pluto_upgrade_cs", undefined, &function_b39ecd3d51489472, undefined );
}

// Namespace zm_sat_firefly_script_pluto_upgrade_cs
// Params 0, eflags: 0x4
// Checksum 0xd1d14c31, Offset: 0x27a
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace zm_sat_firefly_script_pluto_upgrade_cs
// Params 0, eflags: 0x4
// Checksum 0x54ea9fdd, Offset: 0x28b
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace zm_sat_firefly_script_pluto_upgrade_cs
// Params 2
// Checksum 0xe403c994, Offset: 0x29c
// Size: 0x80
function main( unused, unused2 )
{
    if ( utility::flag_exist( "zm_sat_firefly_script_pluto_upgrade_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "zm_sat_firefly_script_pluto_upgrade_cs" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "zm_sat_firefly_script_pluto_upgrade_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "zm_sat_firefly_script_pluto_upgrade_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace zm_sat_firefly_script_pluto_upgrade_cs
// Params 3, eflags: 0x4
// Checksum 0xd7682b12, Offset: 0x324
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "zm_sat_firefly_script_pluto_upgrade_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "zm_sat_firefly_script_pluto_upgrade_cs" );
}

// Namespace zm_sat_firefly_script_pluto_upgrade_cs
// Params 3, eflags: 0x4
// Checksum 0x4c7f617, Offset: 0x39e
// Size: 0x418
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_pluto_upgrade_cs";
    s.is_cs_model = 1;
    s.groupid = "Pluto";
    s.model = "sat_zm_refrigerator_door_right";
    s.var_4a62bf732f3923cb = "1";
    s.var_8ef9cdfc2a34bab3 = "1";
    fe [[ f ]]( s, us, cf, ( -12391.8, 3421.25, 506 ), ( 0, 306.68, 0 ), "freezer_door_r" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_pluto_upgrade_cs";
    s.groupid = "Pluto";
    s.script_animation = "spawn";
    fe [[ f ]]( s, us, cf, ( -12223, 3735, 488 ), ( 0, 210, 0 ), undefined, undefined, "freezer_key_zombie_spawner" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_pluto_upgrade_cs";
    s.groupid = "Pluto";
    fe [[ f ]]( s, us, cf, ( -12430.5, 3409.5, 539.5 ), ( 0, 305.43, 0 ), undefined, undefined, "abom_carcass_itemspawn" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_pluto_upgrade_cs";
    s.is_cs_model = 1;
    s.groupid = "Pluto";
    s.model = "sat_zm_refrigerator_door_left";
    s.var_4a62bf732f3923cb = "1";
    s.var_8ef9cdfc2a34bab3 = "1";
    fe [[ f ]]( s, us, cf, ( -12441, 3384.25, 506 ), ( 0, 307.08, 0 ), "freezer_door_l" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_pluto_upgrade_cs";
    s.groupid = "Pluto";
    fe [[ f ]]( s, us, cf, ( -12416, 3403, 534 ), ( 0, 306.7, 0 ), undefined, undefined, "pluto_freezer_interact" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_pluto_upgrade_cs";
    fe [[ f ]]( s, us, cf, ( -12425, 3416, 528 ), ( 0, 308.9, 0 ), "pluto_upgrade_abom_step5" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_pluto_upgrade_cs";
    fe [[ f ]]( s, us, cf, ( -12413, 3391, 488 ), ( 0, 0, 0 ), "cspf_0_auto18098924277240266978" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_pluto_upgrade_cs";
    fe [[ f ]]( s, us, cf, ( -12208, 3552, 488 ), ( 0, 0, 0 ), "freezer_key_default_drop" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_pluto_upgrade_cs";
    fe [[ f ]]( s, us, cf, ( -11987, 3326, 525 ), ( 0, 0, 0 ), "pluto_upgrade_abom_step2", undefined, undefined, undefined, undefined, undefined, undefined, 500 );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_pluto_upgrade_cs";
    fe [[ f ]]( s, us, cf, ( -11485, 3428, 538 ), ( 0, 307.1, 0 ), "pluto_upgrade_abom_step1" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_pluto_upgrade_cs";
    s.is_cs_model = 1;
    s.model = "sat_zm_refrigerator_buckle_lock";
    s.var_8ef9cdfc2a34bab3 = "1";
    fe [[ f ]]( s, us, cf, ( -12416.5, 3402.5, 534.5 ), ( 0, 307.6, 0 ), undefined, "cspf_0_auto18098924277240266978", "pluto_upgrade_lock" );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace zm_sat_firefly_script_pluto_upgrade_cs
// Params 0, eflags: 0x4
// Checksum 0x48590823, Offset: 0x7be
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace zm_sat_firefly_script_pluto_upgrade_cs
// Params 0
// Checksum 0x153bf65f, Offset: 0x7c8
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "zm_sat_firefly_script_pluto_upgrade_cs" );
}

