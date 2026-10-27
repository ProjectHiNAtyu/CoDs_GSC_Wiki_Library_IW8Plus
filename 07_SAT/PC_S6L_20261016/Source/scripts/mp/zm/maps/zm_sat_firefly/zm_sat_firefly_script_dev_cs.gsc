// scripts\mp\zm\maps\zm_sat_firefly\zm_sat_firefly_script_dev_cs.gsc  (hash_0808ec73645faad2.gscc) (size: 2330 Bytes / 0x91a / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x60478784 (1615300484)
// size ...... 2330 (0x91a)
// includes .. 3   (offset: 0x82a)
// strings ... 12  (offset: 0x842)
// dev strs .. 0   (offset: 0x91a)
// exports ... 9   (offset: 0x4ae)
// cseg ...... 0x10e + 0x3a0 (0x4ae)
// imports ... 19  (offset: 0x616)
// animtree1 . 0   (offset: 0x91a)
// animtree2 . 0   (offset: 0x91a)
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace zm_sat_firefly_script_dev_cs;

// Namespace zm_sat_firefly_script_dev_cs
// Params 0, eflags: 0x5
// Checksum 0x274c48a2, Offset: 0x12c
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"zm_sat_firefly_script_dev_cs", undefined, &function_b39ecd3d51489472, undefined );
}

// Namespace zm_sat_firefly_script_dev_cs
// Params 0, eflags: 0x4
// Checksum 0x3dc3cabe, Offset: 0x14d
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace zm_sat_firefly_script_dev_cs
// Params 0, eflags: 0x4
// Checksum 0xb8f81952, Offset: 0x15e
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace zm_sat_firefly_script_dev_cs
// Params 2
// Checksum 0xcb4b0d14, Offset: 0x16f
// Size: 0x70
function main( unused, unused2 )
{
    if ( utility::flag_exist( "zm_sat_firefly_script_dev_cs" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "zm_sat_firefly_script_dev_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "zm_sat_firefly_script_dev_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace zm_sat_firefly_script_dev_cs
// Params 3, eflags: 0x4
// Checksum 0x3b7aad9d, Offset: 0x1e7
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "zm_sat_firefly_script_dev_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "zm_sat_firefly_script_dev_cs" );
}

// Namespace zm_sat_firefly_script_dev_cs
// Params 3, eflags: 0x4
// Checksum 0xae087ac4, Offset: 0x261
// Size: 0x22d
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_dev_cs";
    s.groupid = "Pluto";
    fe [[ f ]]( s, us, cf, ( 3868.05, -859.41, -285 ), ( 0, 359.64, 0 ), "dev_upgrade_pluto", undefined, "4" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_dev_cs";
    s.groupid = "Pluto";
    fe [[ f ]]( s, us, cf, ( 3681.43, -860.51, -285 ), ( 0, 359.64, 0 ), "dev_upgrade_pluto", undefined, "1" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_dev_cs";
    s.groupid = "Pluto";
    fe [[ f ]]( s, us, cf, ( 3745.38, -860.19, -285 ), ( 0, 359.64, 0 ), "dev_upgrade_pluto", undefined, "2" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_dev_cs";
    s.groupid = "Pluto";
    fe [[ f ]]( s, us, cf, ( 3803.51, -859.08, -285 ), ( 0, 359.64, 0 ), "dev_upgrade_pluto", undefined, "3" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_dev_cs";
    s.groupid = "Pluto";
    fe [[ f ]]( s, us, cf, ( 3745.09, -866.04, -241 ), ( 0, 264.68, 0 ), "upgrade_pluto_title" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_dev_cs";
    fe [[ f ]]( s, us, cf, ( 13947.5, -4479.5, 575.75 ), ( 359.8, 43.66, 0.88 ), "s_farm_quick_revive", undefined, "specialty_quickrevive" );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace zm_sat_firefly_script_dev_cs
// Params 0, eflags: 0x4
// Checksum 0x6c3269a5, Offset: 0x496
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace zm_sat_firefly_script_dev_cs
// Params 0
// Checksum 0xf92970d0, Offset: 0x4a0
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "zm_sat_firefly_script_dev_cs" );
}

