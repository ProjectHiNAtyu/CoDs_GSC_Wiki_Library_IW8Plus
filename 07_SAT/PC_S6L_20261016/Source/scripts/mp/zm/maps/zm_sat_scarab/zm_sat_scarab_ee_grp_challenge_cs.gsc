// scripts\mp\zm\maps\zm_sat_scarab\zm_sat_scarab_ee_grp_challenge_cs.gsc  (hash_4351efa37878c7a1.gscc) (size: 6328 Bytes / 0x18b8 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x5b5816df (1532499679)
// size ...... 6328 (0x18b8)
// includes .. 3   (offset: 0x1550)
// strings ... 38  (offset: 0x1568)
// dev strs .. 0   (offset: 0x18b8)
// exports ... 9   (offset: 0x11b8)
// cseg ...... 0x52c + 0xc8c (0x11b8)
// imports ... 20  (offset: 0x1320)
// animtree1 . 0   (offset: 0x18b8)
// animtree2 . 0   (offset: 0x18b8)
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace zm_sat_scarab_ee_grp_challenge_cs;

// Namespace zm_sat_scarab_ee_grp_challenge_cs
// Params 0, eflags: 0x5
// Checksum 0x54c7117f, Offset: 0x54a
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"zm_sat_scarab_ee_grp_challenge_cs", undefined, &function_b39ecd3d51489472, undefined );
}

// Namespace zm_sat_scarab_ee_grp_challenge_cs
// Params 0, eflags: 0x4
// Checksum 0x7bf4b7c1, Offset: 0x56b
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace zm_sat_scarab_ee_grp_challenge_cs
// Params 0, eflags: 0x4
// Checksum 0xfecf642d, Offset: 0x57c
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace zm_sat_scarab_ee_grp_challenge_cs
// Params 2
// Checksum 0x4e263264, Offset: 0x58d
// Size: 0x80
function main( unused, unused2 )
{
    if ( utility::flag_exist( "zm_sat_scarab_ee_grp_challenge_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "zm_sat_scarab_ee_grp_challenge_cs" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "zm_sat_scarab_ee_grp_challenge_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "zm_sat_scarab_ee_grp_challenge_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace zm_sat_scarab_ee_grp_challenge_cs
// Params 3, eflags: 0x4
// Checksum 0x7d4dd0e2, Offset: 0x615
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "zm_sat_scarab_ee_grp_challenge_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "zm_sat_scarab_ee_grp_challenge_cs" );
}

// Namespace zm_sat_scarab_ee_grp_challenge_cs
// Params 3, eflags: 0x4
// Checksum 0x19e5f724, Offset: 0x68f
// Size: 0xb09
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "zm_sat_scarab_ee_grp_challenge_cs";
    s.do_bob = "1";
    s.script_label = "sat_zm_scarab_ee_grp_challenge_bunny_arm_lft";
    s.script_poi = "dmztest";
    fe [[ f ]]( s, us, cf, ( 1444.32, 3949.68, 1506.23 ), ( 0, 138, 0 ), undefined, undefined, "ee_grp_bunny_part" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_ee_grp_challenge_cs";
    s.do_bob = "1";
    s.script_label = "sat_zm_scarab_ee_grp_challenge_bunny_arm_rgt";
    s.script_poi = "dmztest";
    fe [[ f ]]( s, us, cf, ( 4337.55, -307.92, 1233.55 ), ( 0, 0, 0 ), undefined, undefined, "ee_grp_bunny_part" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_ee_grp_challenge_cs";
    s.do_bob = "0";
    s.script_label = "sat_zm_scarab_ee_grp_challenge_bunny_head";
    s.script_poi = "dmztest";
    fe [[ f ]]( s, us, cf, ( 516.66, -3903.31, 1925.7 ), ( 8.87, 79.34, 27.34 ), undefined, undefined, "ee_grp_bunny_part" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_ee_grp_challenge_cs";
    s.do_bob = "1";
    s.script_label = "sat_zm_scarab_ee_grp_challenge_bunny_leg_lft";
    s.script_poi = "dmztest";
    fe [[ f ]]( s, us, cf, ( -5140.45, 1245.07, 2091.07 ), ( 0, 0, 0 ), undefined, undefined, "ee_grp_bunny_part" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_ee_grp_challenge_cs";
    s.do_bob = "1";
    s.script_label = "sat_zm_scarab_ee_grp_challenge_bunny_leg_rgt";
    s.script_poi = "dmztest";
    fe [[ f ]]( s, us, cf, ( 1274.72, -2204.58, 1508.86 ), ( 0, 0, 0 ), undefined, undefined, "ee_grp_bunny_part" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_ee_grp_challenge_cs";
    s.do_bob = "1";
    s.script_label = "sat_zm_scarab_ee_grp_challenge_bunny_torso";
    s.script_poi = "dmztest";
    fe [[ f ]]( s, us, cf, ( 205.63, 758.77, 1184.96 ), ( 0, 84.82, 0 ), undefined, undefined, "ee_grp_bunny_part" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_ee_grp_challenge_cs";
    s.script_poi = "dmztest";
    fe [[ f ]]( s, us, cf, ( 3869.37, -663.37, 1726.78 ), ( 0, 270.93, 0 ), "cspf_0_auto11784578804650616348", "cspf_0_auto756578660764710079" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_ee_grp_challenge_cs";
    s.script_poi = "dmztest";
    fe [[ f ]]( s, us, cf, ( 3319.15, -2020.12, 1698.38 ), ( 0, 137.51, 0 ), undefined, "cspf_0_auto10107108669965470341", "ee_grp_clg_bunny_loc_source" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_ee_grp_challenge_cs";
    s.script_poi = "dmztest";
    fe [[ f ]]( s, us, cf, ( 3765.47, -1513.92, 1712.72 ), ( 0, 228.51, 0 ), "cspf_0_auto10107108669965470341", "cspf_0_auto11784578804650616348" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_ee_grp_challenge_cs";
    s.script_poi = "dmztest";
    fe [[ f ]]( s, us, cf, ( 2449.45, 1219.39, 1773.05 ), ( 0, 318.52, 0 ), "cspf_0_auto11473664526574502668", "cspf_0_auto6566859182975962899" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_ee_grp_challenge_cs";
    s.script_poi = "dmztest";
    fe [[ f ]]( s, us, cf, ( -4188.34, 1471.05, 1702.81 ), ( 0, 60.35, 0 ), "cspf_0_auto11056992202207936214", "cspf_0_auto16484363488838718466" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_ee_grp_challenge_cs";
    s.script_poi = "dmztest";
    fe [[ f ]]( s, us, cf, ( 2902.55, 3095.57, 1972.85 ), ( 0, 260.03, 0 ), "cspf_0_auto11212289376438255231", "cspf_0_auto10764333080640242962" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_ee_grp_challenge_cs";
    s.script_poi = "dmztest";
    fe [[ f ]]( s, us, cf, ( 1330.06, 3571.69, 1955.57 ), ( 0, 355.64, 0 ), "cspf_0_auto11348329719798788114", "cspf_0_auto11090838653091415596" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_ee_grp_challenge_cs";
    s.script_poi = "dmztest";
    fe [[ f ]]( s, us, cf, ( 698.53, 3927.9, 2013.73 ), ( 0, 339.19, 0 ), "cspf_0_auto11090838653091415596", "cspf_0_auto2566147212150071712" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_ee_grp_challenge_cs";
    s.script_poi = "dmztest";
    fe [[ f ]]( s, us, cf, ( -932.46, 3375.23, 1678.42 ), ( 0, 11.31, 0 ), "cspf_0_auto9609085903857690886", "cspf_0_auto16013918032087481373" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_ee_grp_challenge_cs";
    s.script_poi = "dmztest";
    fe [[ f ]]( s, us, cf, ( -3750.64, 2105.81, 1647.19 ), ( 0, 44.37, 0 ), "cspf_0_auto2889250054061208858", "cspf_0_auto11056992202207936214" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_ee_grp_challenge_cs";
    s.script_poi = "dmztest";
    fe [[ f ]]( s, us, cf, ( -4864.78, 1076.64, 2092.61 ), ( 0.71, 41.7, -0 ), "cspf_0_auto16484363488838718466", "cspf_0_auto16483583968157544556" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_ee_grp_challenge_cs";
    s.script_poi = "dmztest";
    fe [[ f ]]( s, us, cf, ( -6120.46, -216.23, 1790.84 ), ( 0, 46.14, 0 ), "cspf_0_auto16483583968157544556", "cspf_0_auto17377081371393586587" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_ee_grp_challenge_cs";
    s.script_poi = "dmztest";
    fe [[ f ]]( s, us, cf, ( -6104.69, -1550.55, 1671.09 ), ( 0, 90.46, 0 ), "cspf_0_auto17377081371393586587", "cspf_0_auto4730189108594571603" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_ee_grp_challenge_cs";
    s.script_poi = "dmztest";
    fe [[ f ]]( s, us, cf, ( -5520.01, -2374.5, 1767.35 ), ( 6.85, 124.83, -0 ), "cspf_0_auto4730189108594571603", "cspf_0_auto3299069621759326158" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_ee_grp_challenge_cs";
    s.script_poi = "dmztest";
    fe [[ f ]]( s, us, cf, ( -4531.18, -2507.27, 1802.8 ), ( 0.48, 178.35, 0.22 ), "cspf_0_auto3299069621759326158", "cspf_0_auto4076727593681944112" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_ee_grp_challenge_cs";
    s.script_poi = "dmztest";
    fe [[ f ]]( s, us, cf, ( -3583.35, -2370.38, 1815.02 ), ( 359.54, 180.03, 0.58 ), "cspf_0_auto4076727593681944112" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_ee_grp_challenge_cs";
    s.script_poi = "dmztest";
    fe [[ f ]]( s, us, cf, ( -3124.63, -2374.63, 1432.34 ), ( 0, 1.36, 0 ), undefined, undefined, "ee_grp_clg_rwd_loc_end" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_ee_grp_challenge_cs";
    s.script_poi = "dmztest";
    fe [[ f ]]( s, us, cf, ( -3104.87, -2369.75, 1483.18 ), ( 0, 165.28, 0 ), undefined, undefined, "ee_grp_clg_rwd_loc_start" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_ee_grp_challenge_cs";
    s.script_poi = "dmztest";
    fe [[ f ]]( s, us, cf, ( 2128.9, 2010.35, 2084.31 ), ( 0, 290.3, 0 ), "cspf_0_auto6566859182975962899", "cspf_0_auto3605151869406758706" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_ee_grp_challenge_cs";
    s.script_poi = "dmztest";
    fe [[ f ]]( s, us, cf, ( -2236.38, 3603.03, 1725.39 ), ( 0, 40.48, 0 ), "cspf_0_auto16013918032087481373", "cspf_0_auto12770257857780542947" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_ee_grp_challenge_cs";
    s.script_poi = "dmztest";
    fe [[ f ]]( s, us, cf, ( 3603.44, 255.64, 1759.45 ), ( 0, 287.05, 0 ), "cspf_0_auto756578660764710079", "cspf_0_auto11473664526574502668" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_ee_grp_challenge_cs";
    s.script_poi = "dmztest";
    fe [[ f ]]( s, us, cf, ( 2584.51, 3609.89, 1929.41 ), ( 0, 317.39, 0 ), "cspf_0_auto10764333080640242962", "cspf_0_auto11348329719798788114" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_ee_grp_challenge_cs";
    s.script_poi = "dmztest";
    fe [[ f ]]( s, us, cf, ( 2573.76, 2660.13, 2005.48 ), ( 0, 223.26, 0 ), "cspf_0_auto3605151869406758706", "cspf_0_auto11212289376438255231" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_ee_grp_challenge_cs";
    s.script_poi = "dmztest";
    fe [[ f ]]( s, us, cf, ( 30.94, 3502, 2001.62 ), ( 0, 23.07, 0 ), "cspf_0_auto2566147212150071712", "cspf_0_auto9609085903857690886" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_ee_grp_challenge_cs";
    s.script_poi = "dmztest";
    fe [[ f ]]( s, us, cf, ( -2979.11, 2872.28, 1641.12 ), ( 0, 45.27, 0 ), "cspf_0_auto12770257857780542947", "cspf_0_auto2889250054061208858" );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace zm_sat_scarab_ee_grp_challenge_cs
// Params 0, eflags: 0x4
// Checksum 0xc16e1d71, Offset: 0x11a0
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace zm_sat_scarab_ee_grp_challenge_cs
// Params 0
// Checksum 0xbf1e0daf, Offset: 0x11aa
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "zm_sat_scarab_ee_grp_challenge_cs" );
}

