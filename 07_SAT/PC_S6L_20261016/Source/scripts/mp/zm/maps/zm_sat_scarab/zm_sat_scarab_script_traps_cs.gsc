// scripts\mp\zm\maps\zm_sat_scarab\zm_sat_scarab_script_traps_cs.gsc  (hash_31869f64547eafa9.gscc) (size: 6359 Bytes / 0x18d7 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xb827936 (193100086)
// size ...... 6359 (0x18d7)
// includes .. 3   (offset: 0x15d7)
// strings ... 38  (offset: 0x15ef)
// dev strs .. 0   (offset: 0x18d7)
// exports ... 9   (offset: 0x123f)
// cseg ...... 0x360 + 0xedf (0x123f)
// imports ... 20  (offset: 0x13a7)
// animtree1 . 0   (offset: 0x18d7)
// animtree2 . 0   (offset: 0x18d7)
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace zm_sat_scarab_script_traps_cs;

// Namespace zm_sat_scarab_script_traps_cs
// Params 0, eflags: 0x5
// Checksum 0xae9b66e7, Offset: 0x37e
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"zm_sat_scarab_script_traps_cs", undefined, &function_b39ecd3d51489472, undefined );
}

// Namespace zm_sat_scarab_script_traps_cs
// Params 0, eflags: 0x4
// Checksum 0xd865685, Offset: 0x39f
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace zm_sat_scarab_script_traps_cs
// Params 0, eflags: 0x4
// Checksum 0x88bd8569, Offset: 0x3b0
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace zm_sat_scarab_script_traps_cs
// Params 2
// Checksum 0x3854d320, Offset: 0x3c1
// Size: 0x80
function main( unused, unused2 )
{
    if ( utility::flag_exist( "zm_sat_scarab_script_traps_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "zm_sat_scarab_script_traps_cs" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "zm_sat_scarab_script_traps_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "zm_sat_scarab_script_traps_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace zm_sat_scarab_script_traps_cs
// Params 3, eflags: 0x4
// Checksum 0xb3f31a6, Offset: 0x449
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "zm_sat_scarab_script_traps_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "zm_sat_scarab_script_traps_cs" );
}

// Namespace zm_sat_scarab_script_traps_cs
// Params 3, eflags: 0x4
// Checksum 0x47aa52b3, Offset: 0x4c3
// Size: 0xd5c
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_traps_cs";
    s.is_cs_trigger = 1;
    s._size_max = ( 116, 342, 202 );
    s._size_min = ( 140, 260, 128 );
    s.height = 128;
    s.length = "128";
    s.width = "128";
    fe [[ f ]]( s, us, cf, ( -1372.65, 328.12, 1592.01 ), ( 0, 355.72, 0 ), "cspf_1_auto1388732153387127557", undefined, "right", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_traps_cs";
    s.is_cs_trigger = 1;
    s._size_max = ( 116, 366, 202 );
    s._size_min = ( 142, 310, 128 );
    s.height = 128;
    s.length = "128";
    s.width = "128";
    fe [[ f ]]( s, us, cf, ( -1618.65, 623.12, 1592.01 ), ( 0, 310.2, 0 ), "cspf_1_auto1388732153387127557", undefined, "left", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_traps_cs";
    s.name = "right impact1";
    fe [[ f ]]( s, us, cf, ( -1362.41, 571.48, 1592 ), ( 0, 332, 0 ), "cspf_1_auto1388732153387127557", undefined, "right", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 150 );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_traps_cs";
    s.name = "dummy trap";
    fe [[ f ]]( s, us, cf, ( -1757, 224.5, 1614 ), ( 0, 270.18, 0 ), "cspf_1_auto15244276466097398626", "cspf_1_auto1388732153387127557", "trap", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_traps_cs";
    s.name = "left impact1";
    fe [[ f ]]( s, us, cf, ( -1465.26, 772.86, 1592 ), ( 0, 332, 0 ), "cspf_1_auto1388732153387127557", undefined, "left", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 175 );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_traps_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s._size_max = ( 550, 918, 590 );
    s._size_min = ( 1180, 1251.85, 190 );
    s.height = 128;
    s.length = "128";
    s.triton = "exclude";
    s.width = "128";
    fe [[ f ]]( s, us, cf, ( -1626.9, 769.3, 1391.01 ), ( 0, 122.8, 0 ), undefined, undefined, "check_zombie_in_radius_a", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_traps_cs";
    s.name = "attractor impact2";
    fe [[ f ]]( s, us, cf, ( -1513.76, 616.36, 1598 ), ( 0, 332, 0 ), "titan_attractor_impact_a", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 150 );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_traps_cs";
    s.name = "stone trap struct";
    s.script_label = "_a";
    fe [[ f ]]( s, us, cf, ( -1774, 204.5, 1676 ), ( 0, 315.18, 0 ), "stone_titan_trap", "cspf_1_auto15244276466097398626", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_traps_cs";
    s.name = "stone trap switch";
    fe [[ f ]]( s, us, cf, ( -1688.5, 192, 1589.62 ), ( 0, 46.18, 0 ), "cspf_1_auto15244276466097398626", undefined, "switch", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_traps_cs";
    s.name = "outer left fist attractor";
    fe [[ f ]]( s, us, cf, ( -1515.76, 608.86, 1592 ), ( 0, 332, 0 ), "titan_fist_attractor_a", undefined, "left_a", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_traps_cs";
    s.script_scenescriptbundle = "ai_sat_zm_scarab_titan_trap_a";
    fe [[ f ]]( s, us, cf, ( 0, 0, 0 ), ( 0, 0, 0 ), "titan_trap_scene_a", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_traps_cs";
    s.is_cs_trigger = 1;
    s._size_max = ( 116, 276, 184 );
    s._size_min = ( 128, 214, 128 );
    s.height = 128;
    s.length = "128";
    s.width = "128";
    fe [[ f ]]( s, us, cf, ( 1957, -1692, 1365.5 ), ( 0, 343.19, 0 ), "cspf_2_auto1388732153387127557", undefined, "left", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_traps_cs";
    s.name = "right impact1";
    fe [[ f ]]( s, us, cf, ( 1926.5, -1795, 1365.5 ), ( 0, 253.36, 0 ), "cspf_2_auto1388732153387127557", undefined, "left", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_traps_cs";
    s.name = "right impact1";
    fe [[ f ]]( s, us, cf, ( 1431.5, -1872.5, 1365.5 ), ( 0, 281.62, 0 ), "cspf_2_auto1388732153387127557", undefined, "right", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_traps_cs";
    s.is_cs_trigger = 1;
    s._size_max = ( 116, 230, 202 );
    s._size_min = ( 128, 206, 128 );
    s.height = 128;
    s.length = "128";
    s.width = "128";
    fe [[ f ]]( s, us, cf, ( 1428, -1787, 1365.5 ), ( 0, 11.94, 0 ), "cspf_2_auto1388732153387127557", undefined, "right", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_traps_cs";
    s.name = "dummy trap";
    fe [[ f ]]( s, us, cf, ( 1589.13, -1424.11, 1373 ), ( 0, 204.59, 0 ), "cspf_2_auto15244276466097398626", "cspf_2_auto1388732153387127557", "trap", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_traps_cs";
    s.name = "stone trap struct";
    s.script_label = "_b";
    fe [[ f ]]( s, us, cf, ( 1648.3, -1449.6, 1390 ), ( 0, 249.59, 0 ), "stone_titan_trap", "cspf_2_auto15244276466097398626", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_traps_cs";
    s.name = "stone trap switch";
    fe [[ f ]]( s, us, cf, ( 1710.5, -1583.5, 1363 ), ( 0, 270, 0 ), "cspf_2_auto15244276466097398626", undefined, "switch", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_traps_cs";
    s.name = "attractor impact1";
    fe [[ f ]]( s, us, cf, ( 1390.09, -1744.54, 1363 ), ( 0, 206.49, 0 ), "titan_attractor_impact_b", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 150 );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_traps_cs";
    s.name = "attractor impact2";
    fe [[ f ]]( s, us, cf, ( 1714.09, -1782.54, 1363 ), ( 0, 206.49, 0 ), "titan_attractor_impact_b", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 150 );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_traps_cs";
    s.name = "outer left fist attractor";
    fe [[ f ]]( s, us, cf, ( 1818.86, -1822.36, 1363 ), ( 0, 206.49, 0 ), "titan_fist_attractor_b", undefined, "left_b", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_traps_cs";
    s.name = "outer right fist attractor";
    fe [[ f ]]( s, us, cf, ( 1258.25, -1691.3, 1363 ), ( 0, 200.59, 0 ), "titan_fist_attractor_b", undefined, "right_b", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_traps_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s._size_max = ( 550, 918, 94 );
    s._size_min = ( 1180, 775.853, 190 );
    s.height = 128;
    s.length = "128";
    s.triton = "exclude";
    s.width = "128";
    fe [[ f ]]( s, us, cf, ( 1515.1, -1714.7, 1391.01 ), ( 0, 178.8, 0 ), undefined, undefined, "check_zombie_in_radius_b", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_traps_cs";
    s.script_scenescriptbundle = "ai_sat_scrab_titan_trap_b";
    fe [[ f ]]( s, us, cf, ( 0, 0, 0 ), ( 0, 0, 0 ), "titan_trap_scene_b", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace zm_sat_scarab_script_traps_cs
// Params 0, eflags: 0x4
// Checksum 0xd857bfd9, Offset: 0x1227
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace zm_sat_scarab_script_traps_cs
// Params 0
// Checksum 0xc96ceceb, Offset: 0x1231
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "zm_sat_scarab_script_traps_cs" );
}

