// scripts\mp\zm\maps\zm_sat_hornet\zm_sat_hornet_script_livingworld_cs.gsc  (hash_0281a96c4ab1c734.gscc) (size: 7401 Bytes / 0x1ce9 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x82d892c8 (2195231432)
// size ...... 7401 (0x1ce9)
// includes .. 3   (offset: 0x18f9)
// strings ... 27  (offset: 0x1911)
// dev strs .. 0   (offset: 0x1ce9)
// exports ... 9   (offset: 0x1561)
// cseg ...... 0x29c + 0x12c5 (0x1561)
// imports ... 20  (offset: 0x16c9)
// animtree1 . 0   (offset: 0x1ce9)
// animtree2 . 0   (offset: 0x1ce9)
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace zm_sat_hornet_script_livingworld_cs;

// Namespace zm_sat_hornet_script_livingworld_cs
// Params 0, eflags: 0x5
// Checksum 0xe91a9dce, Offset: 0x2ba
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"zm_sat_hornet_script_livingworld_cs", undefined, &function_b39ecd3d51489472, undefined );
}

// Namespace zm_sat_hornet_script_livingworld_cs
// Params 0, eflags: 0x4
// Checksum 0x1adde19b, Offset: 0x2db
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace zm_sat_hornet_script_livingworld_cs
// Params 0, eflags: 0x4
// Checksum 0x9fe63277, Offset: 0x2ec
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace zm_sat_hornet_script_livingworld_cs
// Params 2
// Checksum 0x2f0f643e, Offset: 0x2fd
// Size: 0x80
function main( unused, unused2 )
{
    if ( utility::flag_exist( "zm_sat_hornet_script_livingworld_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "zm_sat_hornet_script_livingworld_cs" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "zm_sat_hornet_script_livingworld_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "zm_sat_hornet_script_livingworld_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace zm_sat_hornet_script_livingworld_cs
// Params 3, eflags: 0x4
// Checksum 0x1c6486b8, Offset: 0x385
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "zm_sat_hornet_script_livingworld_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "zm_sat_hornet_script_livingworld_cs" );
}

// Namespace zm_sat_hornet_script_livingworld_cs
// Params 3, eflags: 0x4
// Checksum 0x8deb6e07, Offset: 0x3ff
// Size: 0x1142
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "zm_sat_hornet_script_livingworld_cs";
    s.groupid = "westbailey";
    s.script_scenescriptbundle = "sat_cin_zm_living_world_slumped_over_zmb";
    s.script_spawngroup = "2";
    fe [[ f ]]( s, us, cf, ( -739.01, -23112.2, 166.64 ), ( 358.94, 188.13, 0.82 ), "zm_living_world", undefined, undefined, undefined, undefined, undefined, undefined, 200 );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_script_livingworld_cs";
    s.groupid = "mainkeep";
    s.script_scenescriptbundle = "sat_cin_zm_living_world_half_eaten_zmb";
    s.script_spawngroup = "5";
    fe [[ f ]]( s, us, cf, ( 808.75, -17227.7, 1184 ), ( 0, 280, 0 ), "zm_living_world", undefined, undefined, undefined, undefined, undefined, undefined, 150 );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_script_livingworld_cs";
    s.groupid = "lavgar";
    s.script_scenescriptbundle = "sat_cin_zm_living_world_half_eaten_zmb";
    s.script_spawngroup = "3";
    fe [[ f ]]( s, us, cf, ( 2416, -22768.5, 171.86 ), ( 0, 273.83, 0 ), "zm_living_world", undefined, undefined, undefined, undefined, undefined, undefined, 250 );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_script_livingworld_cs";
    s.groupid = "broke";
    s.script_scenescriptbundle = "sat_cin_zm_living_world_multi_eating_corpse_zmb";
    s.script_spawngroup = "2";
    fe [[ f ]]( s, us, cf, ( -1214.09, -22321.4, 129.98 ), ( 0.11, 9.14, 2.35 ), "zm_living_world", undefined, undefined, undefined, undefined, undefined, undefined, 150 );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_script_livingworld_cs";
    s.groupid = "broke";
    s.script_linkname = "br_porch";
    s.script_linkto = "br_porch";
    s.script_scenescriptbundle = "sat_cin_zm_living_world_crushed_zmb";
    s.script_spawngroup = "2";
    fe [[ f ]]( s, us, cf, ( -3037.94, -22106.5, 130.93 ), ( 1.93, 64.09, -5.18 ), "zm_living_world", undefined, undefined, undefined, undefined, undefined, undefined, 150 );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_script_livingworld_cs";
    s.groupid = "mainkeep";
    s.script_scenescriptbundle = "sat_cin_zm_living_world_crushed_zmb";
    s.script_spawngroup = "5";
    fe [[ f ]]( s, us, cf, ( -656.69, -19206.5, 880.07 ), ( 10.28, 66.65, -3.65 ), "zm_living_world", undefined, undefined, undefined, undefined, undefined, undefined, 300 );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_script_livingworld_cs";
    s.groupid = "mainbailey";
    s.script_scenescriptbundle = "sat_cin_zm_living_world_slumped_over_zmb";
    s.script_spawngroup = "4";
    fe [[ f ]]( s, us, cf, ( -675.44, -21031.5, 519.2 ), ( 0, 90, -1.02 ), "zm_living_world", undefined, undefined, undefined, undefined, undefined, undefined, 150 );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_script_livingworld_cs";
    s.groupid = "spawn";
    s.script_scenescriptbundle = "sat_cin_zm_living_world_crushed_zmb";
    s.script_spawngroup = "1";
    fe [[ f ]]( s, us, cf, ( 316, -24756, 267.91 ), ( 12.32, 141.33, 23.48 ), "zm_living_world", undefined, undefined, undefined, undefined, undefined, undefined, 250 );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_script_livingworld_cs";
    s.groupid = "broke";
    s.script_scenescriptbundle = "sat_cin_zm_living_world_multi_eating_corpse_zmb";
    s.script_spawngroup = "2";
    fe [[ f ]]( s, us, cf, ( -1421.5, -21700.9, 260.45 ), ( 360, 200.27, 0 ), "zm_living_world", undefined, undefined, undefined, undefined, undefined, undefined, 150 );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_script_livingworld_cs";
    s.groupid = "secondbailey";
    s.script_linkname = "sb_porch";
    s.script_linkto = "sb_porch";
    s.script_scenescriptbundle = "sat_cin_zm_living_world_undr_low_obj_zmb";
    s.script_spawngroup = "3";
    fe [[ f ]]( s, us, cf, ( 2372.5, -20772.5, 399.6 ), ( 0, 256, 0 ), "zm_living_world", undefined, undefined, undefined, undefined, undefined, undefined, 300 );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_script_livingworld_cs";
    s.groupid = "thirdbailey";
    s.script_scenescriptbundle = "sat_cin_zm_living_world_slumped_chair_zmb";
    s.script_spawngroup = "1";
    fe [[ f ]]( s, us, cf, ( -432, -22650, 126 ), ( 0, 90, -14 ), "zm_living_world", undefined, undefined, undefined, undefined, undefined, undefined, 250 );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_script_livingworld_cs";
    s.groupid = "broke";
    s.script_linkname = "br_porch";
    s.script_linkto = "br_porch";
    s.script_scenescriptbundle = "sat_cin_zm_living_world_multi_eating_corpse_zmb";
    s.script_spawngroup = "2";
    fe [[ f ]]( s, us, cf, ( -2846.3, -22668.6, 128.91 ), ( 359.81, 107.58, 2.32 ), "zm_living_world", undefined, undefined, undefined, undefined, undefined, undefined, 350 );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_script_livingworld_cs";
    s.groupid = "thirdbailey";
    s.script_scenescriptbundle = "sat_cin_zm_living_world_caged_03_zmb";
    s.script_spawngroup = "1";
    fe [[ f ]]( s, us, cf, ( 1046.75, -22256, 144 ), ( 0, 16.5, 0 ), "zm_living_world", undefined, undefined, undefined, undefined, undefined, undefined, 900 );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_script_livingworld_cs";
    s.groupid = "lavgar";
    s.script_scenescriptbundle = "sat_cin_zm_living_world_undr_low_obj_zmb";
    s.script_spawngroup = "3";
    fe [[ f ]]( s, us, cf, ( 2263, -23231, 165.9 ), ( 5.3, 103.72, 22.14 ), "zm_living_world", undefined, undefined, undefined, undefined, undefined, undefined, 200 );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_script_livingworld_cs";
    s.groupid = "lavgar";
    s.script_scenescriptbundle = "sat_cin_zm_living_world_half_eaten_zmb";
    s.script_spawngroup = "3";
    fe [[ f ]]( s, us, cf, ( 2586, -24125.5, 57.56 ), ( 1.14, 180, -0.25 ), "zm_living_world", undefined, undefined, undefined, undefined, undefined, undefined, 250 );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_script_livingworld_cs";
    s.groupid = "mainkeep";
    s.script_scenescriptbundle = "sat_cin_zm_living_world_multi_eating_corpse_zmb";
    s.script_spawngroup = "5";
    fe [[ f ]]( s, us, cf, ( 24.91, -17311.7, 1344 ), ( 0, 119.36, 0 ), "zm_living_world", undefined, undefined, undefined, undefined, undefined, undefined, 150 );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_script_livingworld_cs";
    s.groupid = "westbailey";
    s.script_scenescriptbundle = "sat_cin_zm_living_world_half_eaten_zmb";
    s.script_spawngroup = "2";
    fe [[ f ]]( s, us, cf, ( -3137.37, -21405.6, 74.26 ), ( 3.43, 238.74, 9.97 ), "zm_living_world", undefined, undefined, undefined, undefined, undefined, undefined, 250 );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_script_livingworld_cs";
    s.groupid = "mainkeep";
    s.script_scenescriptbundle = "sat_cin_zm_living_world_half_eaten_zmb";
    s.script_spawngroup = "5";
    fe [[ f ]]( s, us, cf, ( 686.37, -17266.1, 1184 ), ( 0, 194.69, 0 ), "zm_living_world", undefined, undefined, undefined, undefined, undefined, undefined, 250 );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_script_livingworld_cs";
    s.groupid = "secondbailey";
    s.script_scenescriptbundle = "sat_cin_zm_living_world_undr_low_obj_zmb";
    s.script_spawngroup = "3";
    fe [[ f ]]( s, us, cf, ( 2856.91, -20236.6, 405.57 ), ( 5.08, 242.86, -0.28 ), "zm_living_world", undefined, undefined, undefined, undefined, undefined, undefined, 200 );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_script_livingworld_cs";
    s.groupid = "mainkeep";
    s.script_scenescriptbundle = "sat_cin_zm_living_world_multi_eating_corpse_zmb";
    s.script_spawngroup = "5";
    fe [[ f ]]( s, us, cf, ( 297.93, -18053.8, 1185.5 ), ( 0, 31.01, 0 ), "zm_living_world", undefined, undefined, undefined, undefined, undefined, undefined, 150 );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_script_livingworld_cs";
    s.groupid = "thirdbailey";
    s.script_scenescriptbundle = "sat_cin_zm_living_world_caged_05_zmb";
    s.script_spawngroup = "1";
    fe [[ f ]]( s, us, cf, ( 1022.5, -22499, 144 ), ( 0, 114.5, 0 ), "zm_living_world", undefined, undefined, undefined, undefined, undefined, undefined, 900 );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_script_livingworld_cs";
    s.groupid = "lavgar";
    s.script_scenescriptbundle = "sat_cin_zm_living_world_multi_eating_corpse_zmb";
    s.script_spawngroup = "3";
    fe [[ f ]]( s, us, cf, ( 3261.84, -23903.2, 81.18 ), ( 0, 212.93, 0 ), "zm_living_world", undefined, undefined, undefined, undefined, undefined, undefined, 250 );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_script_livingworld_cs";
    s.groupid = "secondbailey";
    s.script_scenescriptbundle = "sat_cin_zm_living_world_slumped_over_zmb";
    s.script_spawngroup = "3";
    fe [[ f ]]( s, us, cf, ( 3204.56, -21958, 416 ), ( 0, 256.54, 0 ), "zm_living_world", undefined, undefined, undefined, undefined, undefined, undefined, 150 );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_script_livingworld_cs";
    s.groupid = "mainkeep";
    s.script_scenescriptbundle = "sat_cin_zm_living_world_slumped_over_zmb";
    s.script_spawngroup = "5";
    fe [[ f ]]( s, us, cf, ( -1503.59, -17558.3, 1024 ), ( 0, 100.86, 0 ), "zm_living_world", undefined, undefined, undefined, undefined, undefined, undefined, 150 );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_script_livingworld_cs";
    s.groupid = "mainkeep";
    s.script_scenescriptbundle = "sat_cin_zm_living_world_slumped_over_zmb";
    s.script_spawngroup = "5";
    fe [[ f ]]( s, us, cf, ( -319.26, -17048.3, 1184 ), ( 0, 282.58, 0 ), "zm_living_world", undefined, undefined, undefined, undefined, undefined, undefined, 150 );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_script_livingworld_cs";
    s.groupid = "secondbailey";
    s.script_linkname = "sb_porch";
    s.script_linkto = "sb_porch";
    s.script_scenescriptbundle = "sat_cin_zm_living_world_multi_eating_corpse_zmb";
    s.script_spawngroup = "3";
    fe [[ f ]]( s, us, cf, ( 2403.5, -20717.5, 399.71 ), ( 0, 55.1, 0 ), "zm_living_world", undefined, undefined, undefined, undefined, undefined, undefined, 350 );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_script_livingworld_cs";
    s.groupid = "mainbailey";
    s.script_scenescriptbundle = "sat_cin_zm_living_world_multi_eating_corpse_zmb";
    s.script_spawngroup = "4";
    fe [[ f ]]( s, us, cf, ( 522.5, -21146, 524.19 ), ( 359.45, 216.74, -0.05 ), "zm_living_world", undefined, undefined, undefined, undefined, undefined, undefined, 250 );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_script_livingworld_cs";
    s.groupid = "mainkeep";
    s.script_scenescriptbundle = "sat_cin_zm_living_world_multi_eating_corpse_zmb";
    s.script_spawngroup = "5";
    fe [[ f ]]( s, us, cf, ( -1176.42, -18186.7, 1024 ), ( 0, 0, 0 ), "zm_living_world", undefined, undefined, undefined, undefined, undefined, undefined, 150 );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_script_livingworld_cs";
    s.groupid = "mainkeep";
    s.script_scenescriptbundle = "sat_cin_zm_living_world_multi_eating_corpse_zmb";
    s.script_spawngroup = "5";
    fe [[ f ]]( s, us, cf, ( -1060.59, -18073.1, 1185 ), ( 0, 163.2, 0 ), "zm_living_world", undefined, undefined, undefined, undefined, undefined, undefined, 150 );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_script_livingworld_cs";
    s.groupid = "mainbailey";
    s.script_scenescriptbundle = "sat_cin_zm_living_world_crushed_zmb";
    s.script_spawngroup = "4";
    fe [[ f ]]( s, us, cf, ( 234.75, -20222.1, 638.12 ), ( 9.52, 349.16, -0.92 ), "zm_living_world", undefined, undefined, undefined, undefined, undefined, undefined, 150 );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_script_livingworld_cs";
    s.groupid = "westbailey";
    s.script_scenescriptbundle = "sat_cin_zm_living_world_half_eaten_zmb";
    s.script_spawngroup = "2";
    fe [[ f ]]( s, us, cf, ( -1928.12, -23281.3, 160.22 ), ( 0.42, 342.34, -4.98 ), "zm_living_world", undefined, undefined, undefined, undefined, undefined, undefined, 250 );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_script_livingworld_cs";
    s.groupid = "secondbailey";
    s.script_scenescriptbundle = "sat_cin_zm_living_world_half_eaten_zmb";
    s.script_spawngroup = "3";
    fe [[ f ]]( s, us, cf, ( 2446.66, -21479, 408 ), ( 0, 16.97, 0 ), "zm_living_world", undefined, undefined, undefined, undefined, undefined, undefined, 250 );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_script_livingworld_cs";
    s.groupid = "broke";
    s.script_scenescriptbundle = "sat_cin_zm_living_world_slumped_over_zmb";
    s.script_spawngroup = "2";
    fe [[ f ]]( s, us, cf, ( -1907.37, -21640.6, 289.5 ), ( 0, 271.53, 0 ), "zm_living_world", undefined, undefined, undefined, undefined, undefined, undefined, 150 );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_script_livingworld_cs";
    s.groupid = "thirdbailey";
    s.script_scenescriptbundle = "sat_cin_zm_living_world_multi_eating_corpse_zmb";
    s.script_spawngroup = "1";
    fe [[ f ]]( s, us, cf, ( 1191.02, -23113.4, 129.31 ), ( 0.86, 323.34, -1.65 ), "zm_living_world", undefined, undefined, undefined, undefined, undefined, undefined, 250 );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_script_livingworld_cs";
    s.groupid = "thirdbailey";
    s.script_scenescriptbundle = "sat_cin_zm_living_world_slumped_over_zmb";
    s.script_spawngroup = "1";
    fe [[ f ]]( s, us, cf, ( 788.95, -22396.2, 143.55 ), ( 359.58, 283, 0.01 ), "zm_living_world", undefined, undefined, undefined, undefined, undefined, undefined, 150 );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace zm_sat_hornet_script_livingworld_cs
// Params 0, eflags: 0x4
// Checksum 0xbca19aee, Offset: 0x1549
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace zm_sat_hornet_script_livingworld_cs
// Params 0
// Checksum 0xde375bf5, Offset: 0x1553
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "zm_sat_hornet_script_livingworld_cs" );
}

