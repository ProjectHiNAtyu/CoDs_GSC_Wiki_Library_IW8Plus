// scripts\mp\zm\maps\zm_sat_firefly\zm_sat_firefly_script_loot_buddy_chompy_cs.gsc  (hash_61e8cf60ba45a399.gscc) (size: 2276 Bytes / 0x8e4 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x13f2d84d (334682189)
// size ...... 2276 (0x8e4)
// includes .. 3   (offset: 0x810)
// strings ... 10  (offset: 0x828)
// dev strs .. 0   (offset: 0x8e4)
// exports ... 9   (offset: 0x478)
// cseg ...... 0x117 + 0x361 (0x478)
// imports ... 20  (offset: 0x5e0)
// animtree1 . 0   (offset: 0x8e4)
// animtree2 . 0   (offset: 0x8e4)
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace zm_sat_firefly_script_loot_buddy_chompy_cs;

// Namespace zm_sat_firefly_script_loot_buddy_chompy_cs
// Params 0, eflags: 0x5
// Checksum 0x7c42af29, Offset: 0x135
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"zm_sat_firefly_script_loot_buddy_chompy_cs", undefined, &function_b39ecd3d51489472, undefined );
}

// Namespace zm_sat_firefly_script_loot_buddy_chompy_cs
// Params 0, eflags: 0x4
// Checksum 0x2267d4e, Offset: 0x156
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace zm_sat_firefly_script_loot_buddy_chompy_cs
// Params 0, eflags: 0x4
// Checksum 0x871daea2, Offset: 0x167
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace zm_sat_firefly_script_loot_buddy_chompy_cs
// Params 2
// Checksum 0x37f4f8eb, Offset: 0x178
// Size: 0x80
function main( unused, unused2 )
{
    if ( utility::flag_exist( "zm_sat_firefly_script_loot_buddy_chompy_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "zm_sat_firefly_script_loot_buddy_chompy_cs" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "zm_sat_firefly_script_loot_buddy_chompy_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "zm_sat_firefly_script_loot_buddy_chompy_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace zm_sat_firefly_script_loot_buddy_chompy_cs
// Params 3, eflags: 0x4
// Checksum 0x49f1a6d, Offset: 0x200
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "zm_sat_firefly_script_loot_buddy_chompy_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "zm_sat_firefly_script_loot_buddy_chompy_cs" );
}

// Namespace zm_sat_firefly_script_loot_buddy_chompy_cs
// Params 3, eflags: 0x4
// Checksum 0xf52d214c, Offset: 0x27a
// Size: 0x1de
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_loot_buddy_chompy_cs";
    fe [[ f ]]( s, us, cf, ( 23013.6, -165.17, 432.57 ), ( 4, 85.19, -8.95 ), "loot_buddy_chompy", undefined, "zone_jplaza" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_loot_buddy_chompy_cs";
    fe [[ f ]]( s, us, cf, ( 13132.2, -3886.21, 623.57 ), ( 0, 348.5, 0 ), "loot_buddy_chompy", undefined, "zone_farm" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_loot_buddy_chompy_cs";
    fe [[ f ]]( s, us, cf, ( -7096.93, -6638.74, 1576 ), ( 0, 52.45, 0 ), "loot_buddy_chompy", undefined, "zone_launchpad" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_loot_buddy_chompy_cs";
    fe [[ f ]]( s, us, cf, ( -12584.6, 2662.59, 422.96 ), ( 0, 131.2, 0 ), "loot_buddy_chompy", undefined, "zone_exit115" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_loot_buddy_chompy_cs";
    fe [[ f ]]( s, us, cf, ( 13541.1, 2465.94, 1055.96 ), ( 0, 349.68, 0 ), "loot_buddy_chompy", undefined, "zone_lakefront" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_loot_buddy_chompy_cs";
    fe [[ f ]]( s, us, cf, ( 4469.63, -2634.85, 255.67 ), ( 343.82, 267.37, -4.71 ), "loot_buddy_chompy", undefined, "zone_sunken" );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace zm_sat_firefly_script_loot_buddy_chompy_cs
// Params 0, eflags: 0x4
// Checksum 0xdea0c01e, Offset: 0x460
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace zm_sat_firefly_script_loot_buddy_chompy_cs
// Params 0
// Checksum 0xc6ccc720, Offset: 0x46a
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "zm_sat_firefly_script_loot_buddy_chompy_cs" );
}

