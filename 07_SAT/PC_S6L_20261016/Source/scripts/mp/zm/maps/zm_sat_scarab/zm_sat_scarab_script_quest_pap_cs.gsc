// scripts\mp\zm\maps\zm_sat_scarab\zm_sat_scarab_script_quest_pap_cs.gsc  (hash_41a22e853c3b9d49.gscc) (size: 7816 Bytes / 0x1e88 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x22ef6fa1 (586117025)
// size ...... 7816 (0x1e88)
// includes .. 3   (offset: 0x19f4)
// strings ... 54  (offset: 0x1a0c)
// dev strs .. 0   (offset: 0x1e88)
// exports ... 9   (offset: 0x163c)
// cseg ...... 0x4c1 + 0x117b (0x163c)
// imports ... 21  (offset: 0x17a4)
// animtree1 . 0   (offset: 0x1e88)
// animtree2 . 0   (offset: 0x1e88)
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace zm_sat_scarab_script_quest_pap_cs;

// Namespace zm_sat_scarab_script_quest_pap_cs
// Params 0, eflags: 0x5
// Checksum 0xd47475d3, Offset: 0x4df
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"zm_sat_scarab_script_quest_pap_cs", undefined, &function_b39ecd3d51489472, undefined );
}

// Namespace zm_sat_scarab_script_quest_pap_cs
// Params 0, eflags: 0x4
// Checksum 0x602952b9, Offset: 0x500
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace zm_sat_scarab_script_quest_pap_cs
// Params 0, eflags: 0x4
// Checksum 0xe5128155, Offset: 0x511
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace zm_sat_scarab_script_quest_pap_cs
// Params 2
// Checksum 0x55fbd71c, Offset: 0x522
// Size: 0x80
function main( unused, unused2 )
{
    if ( utility::flag_exist( "zm_sat_scarab_script_quest_pap_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "zm_sat_scarab_script_quest_pap_cs" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "zm_sat_scarab_script_quest_pap_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "zm_sat_scarab_script_quest_pap_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace zm_sat_scarab_script_quest_pap_cs
// Params 3, eflags: 0x4
// Checksum 0x6690359a, Offset: 0x5aa
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "zm_sat_scarab_script_quest_pap_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "zm_sat_scarab_script_quest_pap_cs" );
}

// Namespace zm_sat_scarab_script_quest_pap_cs
// Params 3, eflags: 0x4
// Checksum 0x947fafce, Offset: 0x624
// Size: 0xff8
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_pap_cs";
    s.name = "pq_skull_2";
    fe [[ f ]]( s, us, cf, ( -376.5, -347.03, 1560 ), ( 0, 360, 0 ), "pq_skull_2_path0", "pq_skull_2_path1" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_pap_cs";
    s.animation = "sat_fxanim_zm_skull_subtle_move";
    s.name = "pq_skull_1";
    s.target2 = "pq_skull_1_scene";
    fe [[ f ]]( s, us, cf, ( 224.5, -941.53, 1589.3 ), ( 344, 180, -0 ), "pq_skull_1", "pq_skull_1_path0" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_pap_cs";
    s.name = "pq_skull_2";
    s.target2 = "pq_skull_2_scene";
    fe [[ f ]]( s, us, cf, ( -219.79, -947.03, 1587.58 ), ( 342, 0, 0 ), "pq_skull_2", "pq_skull_2_path0" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_pap_cs";
    s.name = "pq_skull_1";
    fe [[ f ]]( s, us, cf, ( 380.5, -1541.53, 1560 ), ( 0, 180, 0 ), "pq_skull_1_path0", "pq_skull_1_path1" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_pap_cs";
    fe [[ f ]]( s, us, cf, ( 228.62, -940.12, 1591 ), ( 0, 180, 0 ), "pq_cage" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_pap_cs";
    fe [[ f ]]( s, us, cf, ( -225, -947, 1590 ), ( 0, 360, 0 ), "pq_cage" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_pap_cs";
    s.name = "pq_skull_path_temple_door";
    s.script_flag_set = "southeast_temple_door_bought";
    fe [[ f ]]( s, us, cf, ( 2572, -1736, 1746 ), ( 0, 0, 0 ), "pq_skull_path_temple_door" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_pap_cs";
    s.name = "pq_skull_2_path";
    fe [[ f ]]( s, us, cf, ( -923.95, -967.7, 1608.38 ), ( 0, 270, 0 ), "pq_skull_2_path1", "pq_skull_2_path2" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_pap_cs";
    s.name = "pq_skull_2_path";
    fe [[ f ]]( s, us, cf, ( -1392.12, -2047.63, 1612.34 ), ( 0, 270, 0 ), "pq_skull_2_path2", "pq_skull_2_path2_1" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_pap_cs";
    s.name = "pq_skull_2_path";
    fe [[ f ]]( s, us, cf, ( -2228.17, -1885.63, 1514.38 ), ( 0, 270, 0 ), "pq_skull_2_path2_1", "pq_skull_2_path2_2" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_pap_cs";
    s.name = "pq_skull_2_path";
    fe [[ f ]]( s, us, cf, ( -3608.07, -2669.7, 1666.38 ), ( 0, 270, 0 ), "pq_skull_2_path2_2", "pq_skull_2_path2_2_circle" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_pap_cs";
    s.name = "pq_skull_2_path";
    fe [[ f ]]( s, us, cf, ( -778.08, 310.3, 1834.44 ), ( 0, 270, 0 ), "pq_skull_2_path2", "pq_skull_2_path2_3" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_pap_cs";
    s.name = "pq_skull_2_path";
    fe [[ f ]]( s, us, cf, ( -1388.07, 730.38, 1858.38 ), ( 0, 270, 0 ), "pq_skull_2_path2_3", "pq_skull_2_path2_4" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_pap_cs";
    s.name = "pq_skull_2_path";
    fe [[ f ]]( s, us, cf, ( -2274.04, 1113.38, 1882.38 ), ( 0, 270, 0 ), "pq_skull_2_path2_4", "pq_skull_2_path2_4_circle" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_pap_cs";
    s.name = "pq_skull_1";
    fe [[ f ]]( s, us, cf, ( 924, -948.32, 1602.38 ), ( 0, 90, 0 ), "pq_skull_1_path1", "pq_skull_1_path2" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_pap_cs";
    s.name = "pq_skull_1";
    fe [[ f ]]( s, us, cf, ( 760.15, 161.62, 1686.41 ), ( 0, 90, 0 ), "pq_skull_1_path2", "pq_skull_1_path2_1" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_pap_cs";
    s.name = "pq_skull_1";
    fe [[ f ]]( s, us, cf, ( 1636.15, 799.62, 1776.41 ), ( 0, 90, 0 ), "pq_skull_1_path2_1", "pq_skull_1_path2_2" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_pap_cs";
    s.name = "pq_skull_1";
    fe [[ f ]]( s, us, cf, ( 2268.15, 1435.62, 1840.41 ), ( 0, 90, 0 ), "pq_skull_1_path2_2", "pq_skull_1_path2_2_circle" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_pap_cs";
    s.name = "pq_skull_1";
    fe [[ f ]]( s, us, cf, ( 3194.18, -1718.33, 1784.38 ), ( 0, 90, 0 ), "pq_skull_1_path2_4", "pq_skull_1_path2_4_circle" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_pap_cs";
    s.name = "pq_skull_1";
    fe [[ f ]]( s, us, cf, ( 1729.15, -1770.38, 1650.41 ), ( 0, 90, 0 ), "pq_skull_1_path2", "pq_skull_1_path2_3" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_pap_cs";
    s.name = "pq_skull_1";
    fe [[ f ]]( s, us, cf, ( 2352.06, -1738.34, 1718.38 ), ( 0, 90, 0 ), "pq_skull_1_path2_3", "pq_skull_1_path2_4" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_pap_cs";
    s.name = "pq_skull_1_path2_4_circle";
    fe [[ f ]]( s, us, cf, ( 3852.18, -1716.33, 1576.38 ), ( 0, 90, 0 ), "pq_skull_1_path2_4_circle", undefined, "zone_se_temple_finalroom", undefined, undefined, undefined, undefined, 275 );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_pap_cs";
    s.name = "pq_skull_1_path2_2_circle";
    fe [[ f ]]( s, us, cf, ( 2389.34, 1563.14, 1920.38 ), ( 0, 45, 0 ), "pq_skull_1_path2_2_circle", undefined, undefined, undefined, undefined, undefined, undefined, 275 );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_pap_cs";
    s.name = "pq_skull_2_path2_2_circle";
    fe [[ f ]]( s, us, cf, ( -4533.82, -2368.33, 1808.38 ), ( 0, 90, 0 ), "pq_skull_2_path2_2_circle", undefined, undefined, undefined, undefined, undefined, undefined, 275 );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_pap_cs";
    s.name = "pq_skull_2_path2_4_circle";
    fe [[ f ]]( s, us, cf, ( -2683.82, 1715.67, 1752.38 ), ( 0, 90, 0 ), "pq_skull_2_path2_4_circle", undefined, undefined, undefined, undefined, undefined, undefined, 275 );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_pap_cs";
    s.name = "pq_skull_path_temple_door";
    s.script_flag_set = "northeast_temple_door_bought";
    fe [[ f ]]( s, us, cf, ( 1404, 628, 1762 ), ( 0, 0, 0 ), "pq_skull_path_temple_door" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_pap_cs";
    s.name = "pq_skull_path_temple_door";
    s.script_flag_set = "northwest_temple_door_bought";
    fe [[ f ]]( s, us, cf, ( -1930, 968, 1878 ), ( 0, 0, 0 ), "pq_skull_path_temple_door" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_pap_cs";
    s.groupid = "pq_crank1";
    s.name = "pq_crank_base";
    fe [[ f ]]( s, us, cf, ( 5.2, -951, 1471 ), ( 0, 359.39, 0 ), "pq_crank_base", undefined, "1" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_pap_cs";
    s.groupid = "pq_crank1";
    s.name = "pq_crank";
    fe [[ f ]]( s, us, cf, ( -2.75, -826.7, 1501 ), ( 0, 360, 0.1 ), "pq_crank", undefined, "1" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_pap_cs";
    s.groupid = "pq_crank2";
    s.name = "pq_crank_base";
    fe [[ f ]]( s, us, cf, ( -6.7, -921.5, 1471 ), ( 0, 179.39, 0 ), "pq_crank_base", undefined, "2" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_pap_cs";
    s.groupid = "pq_crank2";
    s.name = "pq_crank";
    fe [[ f ]]( s, us, cf, ( 1.25, -1045.8, 1501 ), ( 0, 180, 0.1 ), "pq_crank", undefined, "2" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_pap_cs";
    s.name = "pq_skull_path_temple_door";
    s.script_flag_set = "southwest_temple_door_bought";
    fe [[ f ]]( s, us, cf, ( -3078, -2366, 1610 ), ( 0, 0, 0 ), "pq_skull_path_temple_door" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_pap_cs";
    s.name = "sat_zm_energy_ring_glow_02";
    fe [[ f ]]( s, us, cf, ( 0, -944, 1440 ), ( 0, 0, 0 ), "pq_forge_ring1", undefined, "1" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_pap_cs";
    fe [[ f ]]( s, us, cf, ( -33.16, -1050.3, 97.15 ), ( 0, 0, 0 ), "pq_fx" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_pap_cs";
    s.name = "pq_forge_brazier";
    fe [[ f ]]( s, us, cf, ( 0, -514, 1440 ), ( 0, 270, 0 ), "pq_forge_brazier", undefined, "2" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_pap_cs";
    s.name = "pq_forge_brazier";
    fe [[ f ]]( s, us, cf, ( 0, -1376, 1440 ), ( 0, 90, -0 ), "pq_forge_brazier", undefined, "1" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_pap_cs";
    s.name = "sat_zm_energy_ring_glow_01";
    fe [[ f ]]( s, us, cf, ( 0, -944, 1440 ), ( 0, 0, 0 ), "pq_forge_ring2", undefined, "2" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_pap_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s._size_max = ( 63, 22, 52 );
    s._size_min = ( -10, 16, 40 );
    s.height = 128;
    s.length = "128";
    s.name = "pq_crank_trigger2";
    s.script_int = int( 2 );
    s.triton = "exclude";
    s.width = "128";
    fe [[ f ]]( s, us, cf, ( -1.5, -1042, 1494 ), ( 0, 270, 0 ), "pq_crank_trigger", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, 512 );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_pap_cs";
    fe [[ f ]]( s, us, cf, ( 0, -936, 1464 ), ( 0, 336, 0 ), "pq_forge_end" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_pap_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s._size_max = ( 63, 20, 52 );
    s._size_min = ( -6, 18, 40 );
    s.height = 128;
    s.length = "128";
    s.name = "pq_crank_trigger1";
    s.script_int = int( 1 );
    s.triton = "exclude";
    s.width = "128";
    fe [[ f ]]( s, us, cf, ( -1.5, -826, 1494 ), ( 0, 90, 0 ), "pq_crank_trigger", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, 512 );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_pap_cs";
    s.name = "pq_skull_1_scene";
    s.script_scenescriptbundle = "zm_sat_skull_cage_scene";
    fe [[ f ]]( s, us, cf, ( 229, -940, 1591 ), ( 0, 180, 0 ), "pq_skull_1_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_pap_cs";
    s.name = "pq_skull_2_scene";
    s.script_scenescriptbundle = "zm_sat_skull_cage_scene";
    fe [[ f ]]( s, us, cf, ( -225, -947, 1590 ), ( 0, 0, 0 ), "pq_skull_2_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_pap_cs";
    fe [[ f ]]( s, us, cf, ( 0, -936, 1372 ), ( 0, 0, 0 ), "papq_forge_audio" );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace zm_sat_scarab_script_quest_pap_cs
// Params 0, eflags: 0x4
// Checksum 0x7a211b4d, Offset: 0x1624
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace zm_sat_scarab_script_quest_pap_cs
// Params 0
// Checksum 0xa4c3e8d7, Offset: 0x162e
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "zm_sat_scarab_script_quest_pap_cs" );
}

