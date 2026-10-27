// scripts\mp\zm\maps\zm_sat_scarab\zm_sat_scarab_script_livingworld_cs.gsc  (hash_62a67b1064fe6074.gscc) (size: 11846 Bytes / 0x2e46 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x905c9bfc (2421988348)
// size ...... 11846 (0x2e46)
// includes .. 3   (offset: 0x266a)
// strings ... 82  (offset: 0x2682)
// dev strs .. 0   (offset: 0x2e46)
// exports ... 9   (offset: 0x22d2)
// cseg ...... 0x463 + 0x1e6f (0x22d2)
// imports ... 20  (offset: 0x243a)
// animtree1 . 0   (offset: 0x2e46)
// animtree2 . 0   (offset: 0x2e46)
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace zm_sat_scarab_script_livingworld_cs;

// Namespace zm_sat_scarab_script_livingworld_cs
// Params 0, eflags: 0x5
// Checksum 0x61742529, Offset: 0x481
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"zm_sat_scarab_script_livingworld_cs", undefined, &function_b39ecd3d51489472, undefined );
}

// Namespace zm_sat_scarab_script_livingworld_cs
// Params 0, eflags: 0x4
// Checksum 0x9193390e, Offset: 0x4a2
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace zm_sat_scarab_script_livingworld_cs
// Params 0, eflags: 0x4
// Checksum 0x14a8eae2, Offset: 0x4b3
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace zm_sat_scarab_script_livingworld_cs
// Params 2
// Checksum 0xa441bcab, Offset: 0x4c4
// Size: 0x80
function main( unused, unused2 )
{
    if ( utility::flag_exist( "zm_sat_scarab_script_livingworld_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "zm_sat_scarab_script_livingworld_cs" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "zm_sat_scarab_script_livingworld_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "zm_sat_scarab_script_livingworld_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace zm_sat_scarab_script_livingworld_cs
// Params 3, eflags: 0x4
// Checksum 0x972a5e2d, Offset: 0x54c
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "zm_sat_scarab_script_livingworld_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "zm_sat_scarab_script_livingworld_cs" );
}

// Namespace zm_sat_scarab_script_livingworld_cs
// Params 3, eflags: 0x4
// Checksum 0x90df03f8, Offset: 0x5c6
// Size: 0x1cec
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_livingworld_cs";
    s.groupid = "herhouse";
    s.script_count = "2";
    s.script_linkname = "her_house";
    s.script_linkto = "her_house";
    s.script_scenescriptbundle = "sat_cin_zm_living_world_slumped_over_zmb";
    s.script_spawngroup = "1";
    fe [[ f ]]( s, us, cf, ( 275.19, -3682.54, 1735.05 ), ( 4.01, 9.59, -5.82 ), "zm_living_world", undefined, undefined, undefined, undefined, undefined, undefined, 128 );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_livingworld_cs";
    s.groupid = "herhouse";
    s.script_count = "1";
    s.script_linkname = "her_house";
    s.script_linkto = "her_house";
    s.script_scenescriptbundle = "sat_cin_zm_living_world_slumped_over_zmb";
    s.script_spawngroup = "1";
    fe [[ f ]]( s, us, cf, ( 341.1, -4453.63, 1954.53 ), ( 355.03, 189.71, 5.02 ), "zm_living_world", undefined, undefined, undefined, undefined, undefined, undefined, 195 );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_livingworld_cs";
    s.groupid = "nexusforge";
    s.script_count = "39";
    s.script_scenescriptbundle = "sat_cin_zm_living_world_half_eaten_zmb";
    s.script_spawngroup = "1";
    fe [[ f ]]( s, us, cf, ( 903.64, -1705.61, 1313.02 ), ( 359.88, 154.29, -0.06 ), "zm_living_world", undefined, undefined, undefined, undefined, undefined, undefined, 157 );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_livingworld_cs";
    s.groupid = "nexusforge";
    s.script_count = "20";
    s.script_scenescriptbundle = "sat_cin_zm_living_world_multi_eating_corpse_zmb";
    s.script_spawngroup = "1";
    fe [[ f ]]( s, us, cf, ( -824.5, -166.43, 1322.64 ), ( 357.97, 62.81, 11.58 ), "zm_living_world", undefined, undefined, undefined, undefined, undefined, undefined, 200 );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_livingworld_cs";
    s.groupid = "nyxaraentrance";
    s.script_count = "4";
    s.script_scenescriptbundle = "sat_cin_zm_living_world_half_eaten_zmb";
    s.script_spawngroup = "2";
    fe [[ f ]]( s, us, cf, ( -3405.37, -2238.47, 1424 ), ( 0, 323.86, 0 ), "zm_living_world", undefined, undefined, undefined, undefined, undefined, undefined, 200 );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_livingworld_cs";
    s.groupid = "nyxarapassage";
    s.script_count = "3";
    s.script_linkname = "nyxara_passage";
    s.script_linkto = "nyxara_passage";
    s.script_scenescriptbundle = "sat_cin_zm_living_world_half_eaten_zmb";
    s.script_spawngroup = "2";
    fe [[ f ]]( s, us, cf, ( -2343.64, -1807.76, 1265.35 ), ( 359.27, 35.92, -0.45 ), "zm_living_world", undefined, undefined, undefined, undefined, undefined, undefined, 200 );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_livingworld_cs";
    s.groupid = "nyxaramainchamber";
    s.script_count = "7";
    s.script_scenescriptbundle = "sat_cin_zm_living_world_half_eaten_zmb";
    s.script_spawngroup = "2";
    fe [[ f ]]( s, us, cf, ( -4796.76, -2228.35, 1488 ), ( 0, 301.79, 0 ), "zm_living_world", undefined, undefined, undefined, undefined, undefined, undefined, 250 );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_livingworld_cs";
    s.groupid = "nyxaramainchamber";
    s.script_count = "6";
    s.script_linkname = "nyxara_main";
    s.script_linkto = "nyxara_main";
    s.script_scenescriptbundle = "sat_cin_zm_living_world_half_eaten_zmb";
    s.script_spawngroup = "2";
    fe [[ f ]]( s, us, cf, ( -4255.88, -2834.18, 1392 ), ( 0, 233.86, 0 ), "zm_living_world", undefined, undefined, undefined, undefined, undefined, undefined, 250 );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_livingworld_cs";
    s.groupid = "nyxaramainchamber";
    s.script_count = "5";
    s.script_linkname = "nyxara_main";
    s.script_linkto = "nyxara_main";
    s.script_scenescriptbundle = "sat_cin_zm_living_world_half_eaten_zmb";
    s.script_spawngroup = "2";
    fe [[ f ]]( s, us, cf, ( -4204.56, -1811.86, 1392 ), ( 0, 274.78, -4.21 ), "zm_living_world", undefined, undefined, undefined, undefined, undefined, undefined, 250 );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_livingworld_cs";
    s.groupid = "nyxarasanctuary";
    s.script_count = "9";
    s.script_linkname = "nyxara_sanctuary";
    s.script_linkto = "nyxara_sanctuary";
    s.script_scenescriptbundle = "sat_cin_zm_living_world_multi_eating_corpse_zmb";
    s.script_spawngroup = "2";
    fe [[ f ]]( s, us, cf, ( -6659.58, -2414.74, 1520 ), ( 0, 79.84, 0 ), "zm_living_world", undefined, undefined, undefined, undefined, undefined, undefined, 150 );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_livingworld_cs";
    s.groupid = "nyxarasanctuary";
    s.script_count = "8";
    s.script_linkname = "nyxara_sanctuary";
    s.script_linkto = "nyxara_sanctuary";
    s.script_scenescriptbundle = "sat_cin_zm_living_world_multi_eating_corpse_zmb";
    s.script_spawngroup = "2";
    fe [[ f ]]( s, us, cf, ( -6407.75, -2819.71, 1488 ), ( 0, 144.74, 0 ), "zm_living_world", undefined, undefined, undefined, undefined, undefined, undefined, 150 );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_livingworld_cs";
    s.groupid = "nyxarasanctuary";
    s.script_count = "10";
    s.script_linkname = "nyxara_sanctuary";
    s.script_linkto = "nyxara_sanctuary";
    s.script_scenescriptbundle = "sat_cin_zm_living_world_multi_eating_corpse_zmb";
    s.script_spawngroup = "2";
    fe [[ f ]]( s, us, cf, ( -5906.74, -1836.18, 1488 ), ( 0, 79.84, 0 ), "zm_living_world", undefined, undefined, undefined, undefined, undefined, undefined, 150 );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_livingworld_cs";
    s.groupid = "nyxarasanctuary";
    s.script_count = "11";
    s.script_scenescriptbundle = "sat_cin_zm_living_world_half_eaten_zmb";
    s.script_spawngroup = "2";
    fe [[ f ]]( s, us, cf, ( -6000.52, -937.86, 1616 ), ( 0, 196.15, 0 ), "zm_living_world", undefined, undefined, undefined, undefined, undefined, undefined, 250 );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_livingworld_cs";
    s.groupid = "spirainsula";
    s.script_count = "12";
    s.script_scenescriptbundle = "sat_cin_zm_living_world_half_eaten_zmb";
    s.script_spawngroup = "2";
    fe [[ f ]]( s, us, cf, ( -5736, 316, 1696 ), ( 358.06, 37.7, 0.98 ), "zm_living_world", undefined, undefined, undefined, undefined, undefined, undefined, 250 );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_livingworld_cs";
    s.groupid = "spirainsula";
    s.script_count = "13";
    s.script_scenescriptbundle = "sat_cin_zm_living_world_slumped_over_zmb";
    s.script_spawngroup = "2";
    fe [[ f ]]( s, us, cf, ( -5272.17, 799.17, 1686.91 ), ( 1.12, 17.9, 0.02 ), "zm_living_world", undefined, undefined, undefined, undefined, undefined, undefined, 250 );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_livingworld_cs";
    fe [[ f ]]( s, us, cf, ( 367, -79, -650 ), ( 0, 251, 0 ), "cage_zombie" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_livingworld_cs";
    fe [[ f ]]( s, us, cf, ( 608, -1171, -1338 ), ( 0, 160, 0 ), "cage_zombie" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_livingworld_cs";
    s.groupid = "veytharionpassage";
    s.script_count = "19";
    s.script_scenescriptbundle = "sat_cin_zm_living_world_half_eaten_zmb";
    s.script_spawngroup = "2";
    fe [[ f ]]( s, us, cf, ( -1172.78, 874.86, 1560.78 ), ( 0, 297.66, 0 ), "zm_living_world", undefined, undefined, undefined, undefined, undefined, undefined, 200 );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_livingworld_cs";
    fe [[ f ]]( s, us, cf, ( 123, -1666, -1150 ), ( 0, 103, 0 ), "cage_zombie" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_livingworld_cs";
    fe [[ f ]]( s, us, cf, ( 433, -1598, -847 ), ( 0, 125, 0 ), "cage_zombie" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_livingworld_cs";
    s.groupid = "veytharionmainchamber";
    s.script_count = "18";
    s.script_linkname = "veytharion_main";
    s.script_linkto = "veytharion_main";
    s.script_scenescriptbundle = "sat_cin_zm_living_world_multi_eating_corpse_zmb";
    s.script_spawngroup = "2";
    fe [[ f ]]( s, us, cf, ( -2252.69, 1394.77, 1608 ), ( 0, 344.75, 0 ), "zm_living_world", undefined, undefined, undefined, undefined, undefined, undefined, 200 );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_livingworld_cs";
    fe [[ f ]]( s, us, cf, ( -537, -1265, -1336 ), ( 0, 25, 0 ), "cage_zombie" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_livingworld_cs";
    fe [[ f ]]( s, us, cf, ( 215, -298, -1330 ), ( 0, 260, 0 ), "cage_zombie" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_livingworld_cs";
    fe [[ f ]]( s, us, cf, ( 814, -1439, -343 ), ( 0, 155, 0 ), "cage_zombie" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_livingworld_cs";
    fe [[ f ]]( s, us, cf, ( -468, -289, -842 ), ( 0, 312, 0 ), "cage_zombie" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_livingworld_cs";
    fe [[ f ]]( s, us, cf, ( 265, -503, -1843 ), ( 0, 236, 0 ), "cage_zombie" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_livingworld_cs";
    s.groupid = "veytharionmainchamber";
    s.script_count = "16";
    s.script_linkname = "veytharion_main";
    s.script_linkto = "veytharion_main";
    s.script_scenescriptbundle = "sat_cin_zm_living_world_multi_eating_corpse_zmb";
    s.script_spawngroup = "2";
    fe [[ f ]]( s, us, cf, ( -3014.97, 1764.9, 1512 ), ( 0, 16.35, 0 ), "zm_living_world", undefined, undefined, undefined, undefined, undefined, undefined, 200 );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_livingworld_cs";
    s.groupid = "veytharionsancutuary";
    s.script_count = "14";
    s.script_scenescriptbundle = "sat_cin_zm_living_world_slumped_over_zmb";
    s.script_spawngroup = "1";
    fe [[ f ]]( s, us, cf, ( -4201.68, 2003.27, 1512 ), ( 0, 44.29, 0 ), "zm_living_world", undefined, undefined, undefined, undefined, undefined, undefined, 200 );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_livingworld_cs";
    s.groupid = "veytharionsancutuary";
    s.script_count = "32";
    s.script_scenescriptbundle = "sat_cin_zm_living_world_slumped_over_zmb";
    s.script_spawngroup = "1";
    fe [[ f ]]( s, us, cf, ( -2603.14, 2976.75, 1512 ), ( 0, 312.5, 0 ), "zm_living_world", undefined, undefined, undefined, undefined, undefined, undefined, 200 );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_livingworld_cs";
    s.groupid = "ruinasinsula";
    s.script_count = "43";
    s.script_linkname = "ruinas_insula";
    s.script_linkto = "ruinas_insula";
    s.script_scenescriptbundle = "sat_cin_zm_living_world_half_eaten_zmb";
    s.script_spawngroup = "3";
    fe [[ f ]]( s, us, cf, ( 3963.58, 940.4, 1735.52 ), ( 359.77, 235.31, -4.92 ), "zm_living_world", undefined, undefined, undefined, undefined, undefined, undefined, 200 );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_livingworld_cs";
    s.groupid = "veytharionsancutuary";
    s.script_count = "17";
    s.script_scenescriptbundle = "sat_cin_zm_living_world_slumped_over_zmb";
    s.script_spawngroup = "1";
    fe [[ f ]]( s, us, cf, ( -2664.76, 1909.88, 1512 ), ( 0, 220.47, 0 ), "zm_living_world", undefined, undefined, undefined, undefined, undefined, undefined, 180 );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_livingworld_cs";
    s.groupid = "veytharionsanctuary";
    s.script_count = "33";
    s.script_linkname = "veytharion_sanctuary";
    s.script_linkto = "veytharion_sanctuary";
    s.script_scenescriptbundle = "sat_cin_zm_living_world_half_eaten_zmb";
    s.script_spawngroup = "2";
    fe [[ f ]]( s, us, cf, ( -3146.78, 3344.01, 1656 ), ( 0, 334.15, 0 ), "zm_living_world", undefined, undefined, undefined, undefined, undefined, undefined, 200 );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_livingworld_cs";
    s.groupid = "veytharionsanctuary";
    s.script_count = "31";
    s.script_linkname = "veytharion_sanctuary";
    s.script_linkto = "veytharion_sanctuary";
    s.script_scenescriptbundle = "sat_cin_zm_living_world_half_eaten_zmb";
    s.script_spawngroup = "2";
    fe [[ f ]]( s, us, cf, ( -2397.34, 3384.94, 1608 ), ( 0, 244.28, 0 ), "zm_living_world", undefined, undefined, undefined, undefined, undefined, undefined, 200 );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_livingworld_cs";
    s.groupid = "araneainsula";
    s.script_count = "28";
    s.script_scenescriptbundle = "sat_cin_zm_living_world_multi_eating_corpse_zmb";
    s.script_spawngroup = "3";
    fe [[ f ]]( s, us, cf, ( 401.55, 3188.21, 1728 ), ( 0, 16.35, 0 ), "zm_living_world", undefined, undefined, undefined, undefined, undefined, undefined, 200 );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_livingworld_cs";
    s.groupid = "araneainsula";
    s.script_count = "30";
    s.script_scenescriptbundle = "sat_cin_zm_living_world_half_eaten_zmb";
    s.script_spawngroup = "3";
    fe [[ f ]]( s, us, cf, ( -785.31, 3624.27, 1605.43 ), ( 0, 60.24, 0 ), "zm_living_world", undefined, undefined, undefined, undefined, undefined, undefined, 200 );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_livingworld_cs";
    s.groupid = "araneainsula";
    s.script_count = "29";
    s.script_scenescriptbundle = "sat_cin_zm_living_world_slumped_over_zmb";
    s.script_spawngroup = "3";
    fe [[ f ]]( s, us, cf, ( -42.69, 3875.45, 1728 ), ( 0, 357.29, 0 ), "zm_living_world", undefined, undefined, undefined, undefined, undefined, undefined, 200 );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_livingworld_cs";
    s.groupid = "araneainsula";
    s.script_count = "27";
    s.script_scenescriptbundle = "sat_cin_zm_living_world_half_eaten_zmb";
    s.script_spawngroup = "3";
    fe [[ f ]]( s, us, cf, ( 1255.44, 3073.08, 1856 ), ( 0, 84.54, 0 ), "zm_living_world", undefined, undefined, undefined, undefined, undefined, undefined, 200 );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_livingworld_cs";
    s.groupid = "araneainsula";
    s.script_count = "26";
    s.script_scenescriptbundle = "sat_cin_zm_living_world_half_eaten_zmb";
    s.script_spawngroup = "3";
    fe [[ f ]]( s, us, cf, ( 112.66, 2027.85, 1710.77 ), ( 1.71, 57.83, -6.61 ), "zm_living_world", undefined, undefined, undefined, undefined, undefined, undefined, 200 );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_livingworld_cs";
    s.groupid = "dravakarsanctuary";
    s.script_count = "34";
    s.script_scenescriptbundle = "sat_cin_zm_living_world_multi_eating_corpse_zmb";
    s.script_spawngroup = "3";
    fe [[ f ]]( s, us, cf, ( 2612.14, 3377.06, 1814 ), ( 0, 16.35, 0 ), "zm_living_world", undefined, undefined, undefined, undefined, undefined, undefined, 200 );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_livingworld_cs";
    s.groupid = "dravakarsanctuary";
    s.script_count = "35";
    s.script_scenescriptbundle = "sat_cin_zm_living_world_slumped_over_zmb";
    s.script_spawngroup = "3";
    fe [[ f ]]( s, us, cf, ( 3772.31, 2244.66, 1814 ), ( 0, 41.15, 0 ), "zm_living_world", undefined, undefined, undefined, undefined, undefined, undefined, 200 );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_livingworld_cs";
    s.groupid = "dravakarmain";
    s.script_count = "25";
    s.script_scenescriptbundle = "sat_cin_zm_living_world_slumped_over_zmb";
    s.script_spawngroup = "3";
    fe [[ f ]]( s, us, cf, ( 1881.22, 2211.82, 1926 ), ( 0, 45.2, 0 ), "zm_living_world", undefined, undefined, undefined, undefined, undefined, undefined, 300 );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_livingworld_cs";
    s.groupid = "dravakarmain";
    s.script_count = "24";
    s.script_scenescriptbundle = "sat_cin_zm_living_world_half_eaten_zmb";
    s.script_spawngroup = "3";
    fe [[ f ]]( s, us, cf, ( 2629.35, 763.8, 1902 ), ( 0, 64.8, 0 ), "zm_living_world", undefined, undefined, undefined, undefined, undefined, undefined, 200 );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_livingworld_cs";
    s.groupid = "dravakarmain";
    s.script_count = "23";
    s.script_scenescriptbundle = "sat_cin_zm_living_world_multi_eating_corpse_zmb";
    s.script_spawngroup = "3";
    fe [[ f ]]( s, us, cf, ( 2096.97, 1534.98, 1686 ), ( 0, 45.2, 0 ), "zm_living_world", undefined, undefined, undefined, undefined, undefined, undefined, 300 );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_livingworld_cs";
    s.groupid = "dravakarentrance";
    s.script_count = "22";
    s.script_scenescriptbundle = "sat_cin_zm_living_world_slumped_over_zmb";
    s.script_spawngroup = "3";
    fe [[ f ]]( s, us, cf, ( 1418.16, 1079.5, 1686 ), ( 0, 41.15, 0 ), "zm_living_world", undefined, undefined, undefined, undefined, undefined, undefined, 200 );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_livingworld_cs";
    s.groupid = "dravakarpassage";
    s.script_count = "21";
    s.script_scenescriptbundle = "sat_cin_zm_living_world_half_eaten_zmb";
    s.script_spawngroup = "3";
    fe [[ f ]]( s, us, cf, ( 1124.46, 366.56, 1421.14 ), ( 1.54, 302.61, 1.36 ), "zm_living_world", undefined, undefined, undefined, undefined, undefined, undefined, 200 );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_livingworld_cs";
    s.groupid = "caltherispassage";
    s.script_count = "38";
    s.script_linkname = "caltheris_passage";
    s.script_linkto = "caltheris_passage";
    s.script_scenescriptbundle = "sat_cin_zm_living_world_slumped_over_zmb";
    s.script_spawngroup = "3";
    fe [[ f ]]( s, us, cf, ( 2545.17, -1550.23, 1451 ), ( 0, 270.35, 0 ), "zm_living_world", undefined, undefined, undefined, undefined, undefined, undefined, 200 );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_livingworld_cs";
    s.groupid = "caltherismainchamber";
    s.script_count = "37";
    s.script_scenescriptbundle = "sat_cin_zm_living_world_multi_eating_corpse_zmb";
    s.script_spawngroup = "3";
    fe [[ f ]]( s, us, cf, ( 3787.57, -945.79, 1283 ), ( 0, 287.55, 0 ), "zm_living_world", undefined, undefined, undefined, undefined, undefined, undefined, 200 );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_livingworld_cs";
    s.groupid = "ruinasinsula";
    s.script_count = "36";
    s.script_linkname = "ruinas_insula";
    s.script_linkto = "ruinas_insula";
    s.script_scenescriptbundle = "sat_cin_zm_living_world_half_eaten_zmb";
    s.script_spawngroup = "3";
    fe [[ f ]]( s, us, cf, ( 4277.27, 666.74, 1570.78 ), ( 0.33, 41.18, 4.99 ), "zm_living_world", undefined, undefined, undefined, undefined, undefined, undefined, 200 );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_livingworld_cs";
    s.groupid = "caltherismainchamber";
    s.script_count = "40";
    s.script_scenescriptbundle = "sat_cin_zm_living_world_half_eaten_zmb";
    s.script_spawngroup = "3";
    fe [[ f ]]( s, us, cf, ( 3296.28, -2314.27, 1499 ), ( 0, 289.75, 0 ), "zm_living_world", undefined, undefined, undefined, undefined, undefined, undefined, 200 );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_livingworld_cs";
    s.groupid = "nyxarapassage";
    s.script_count = "41";
    s.script_linkname = "nyxara_passage";
    s.script_linkto = "nyxara_passage";
    s.script_scenescriptbundle = "sat_cin_zm_living_world_half_eaten_zmb";
    s.script_spawngroup = "2";
    fe [[ f ]]( s, us, cf, ( -2117.03, -2873.87, 1263.79 ), ( 359.57, 70.98, -1.27 ), "zm_living_world", undefined, undefined, undefined, undefined, undefined, undefined, 200 );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_livingworld_cs";
    s.groupid = "spirainsula";
    s.script_count = "42";
    s.script_scenescriptbundle = "sat_cin_zm_living_world_half_eaten_zmb";
    s.script_spawngroup = "2";
    fe [[ f ]]( s, us, cf, ( -4672.78, 1209.01, 1633 ), ( 0, 137, 0 ), "zm_living_world", undefined, undefined, undefined, undefined, undefined, undefined, 250 );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_livingworld_cs";
    s.groupid = "caltherispassage";
    s.script_count = "44";
    s.script_scenescriptbundle = "sat_cin_zm_living_world_half_eaten_zmb";
    s.script_spawngroup = "3";
    fe [[ f ]]( s, us, cf, ( 2352.52, -2166.47, 1450.41 ), ( 359.11, 36.89, 0.34 ), "zm_living_world", undefined, undefined, undefined, undefined, undefined, undefined, 200 );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_livingworld_cs";
    s.groupid = "nexuscore";
    s.script_count = "45";
    s.script_linkname = "nexus_core";
    s.script_linkto = "nexus_core";
    s.script_scenescriptbundle = "sat_cin_zm_living_world_half_eaten_zmb";
    s.script_spawngroup = "1";
    fe [[ f ]]( s, us, cf, ( -2.55, -330.94, 974 ), ( 0, 53.03, 0 ), "zm_living_world", undefined, undefined, undefined, undefined, undefined, undefined, 150 );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_livingworld_cs";
    s.groupid = "nexuscore";
    s.script_count = "46";
    s.script_linkname = "nexus_core";
    s.script_linkto = "nexus_core";
    s.script_scenescriptbundle = "sat_cin_zm_living_world_half_eaten_zmb";
    s.script_spawngroup = "1";
    fe [[ f ]]( s, us, cf, ( -11.35, -1598.65, 974 ), ( 0, 53.03, 0 ), "zm_living_world", undefined, undefined, undefined, undefined, undefined, undefined, 150 );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace zm_sat_scarab_script_livingworld_cs
// Params 0, eflags: 0x4
// Checksum 0xd218e360, Offset: 0x22ba
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace zm_sat_scarab_script_livingworld_cs
// Params 0
// Checksum 0x55798360, Offset: 0x22c4
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "zm_sat_scarab_script_livingworld_cs" );
}

