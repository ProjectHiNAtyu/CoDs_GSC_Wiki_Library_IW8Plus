// scripts\mp\zm\maps\zm_sat_scarab\zm_sat_scarab_script_quest_ee_dance_off_cs.gsc  (hash_71795ddd2f71effa.gscc) (size: 7713 Bytes / 0x1e21 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xa200fb27 (2717973287)
// size ...... 7713 (0x1e21)
// includes .. 3   (offset: 0x1955)
// strings ... 50  (offset: 0x196d)
// dev strs .. 0   (offset: 0x1e21)
// exports ... 9   (offset: 0x15bd)
// cseg ...... 0x3ff + 0x11be (0x15bd)
// imports ... 20  (offset: 0x1725)
// animtree1 . 0   (offset: 0x1e21)
// animtree2 . 0   (offset: 0x1e21)
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace zm_sat_scarab_script_quest_ee_dance_off_cs;

// Namespace zm_sat_scarab_script_quest_ee_dance_off_cs
// Params 0, eflags: 0x5
// Checksum 0x64d6d78, Offset: 0x41d
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"zm_sat_scarab_script_quest_ee_dance_off_cs", undefined, &function_b39ecd3d51489472, undefined );
}

// Namespace zm_sat_scarab_script_quest_ee_dance_off_cs
// Params 0, eflags: 0x4
// Checksum 0x891dad6d, Offset: 0x43e
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace zm_sat_scarab_script_quest_ee_dance_off_cs
// Params 0, eflags: 0x4
// Checksum 0xc267e81, Offset: 0x44f
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace zm_sat_scarab_script_quest_ee_dance_off_cs
// Params 2
// Checksum 0xbccf28c8, Offset: 0x460
// Size: 0x80
function main( unused, unused2 )
{
    if ( utility::flag_exist( "zm_sat_scarab_script_quest_ee_dance_off_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "zm_sat_scarab_script_quest_ee_dance_off_cs" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "zm_sat_scarab_script_quest_ee_dance_off_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "zm_sat_scarab_script_quest_ee_dance_off_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace zm_sat_scarab_script_quest_ee_dance_off_cs
// Params 3, eflags: 0x4
// Checksum 0x8fa4ca4e, Offset: 0x4e8
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "zm_sat_scarab_script_quest_ee_dance_off_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "zm_sat_scarab_script_quest_ee_dance_off_cs" );
}

// Namespace zm_sat_scarab_script_quest_ee_dance_off_cs
// Params 3, eflags: 0x4
// Checksum 0xeb4538d8, Offset: 0x562
// Size: 0x103b
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_ee_dance_off_cs";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( -855.88, -1613.69, 1308 ), ( 0, 39.36, 0 ), "ka_vr_es", "cspf_0_auto4679177149565606004", "2" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_ee_dance_off_cs";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( 3.88, -3909.87, 1782.16 ), ( 355.1, 188.85, 5.1 ), "gp_ly_ms" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_ee_dance_off_cs";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( 63.07, -3953.13, 1782.33 ), ( 355.83, 181.12, 5.71 ), "un_yt_os", undefined, "0" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_ee_dance_off_cs";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( 134.98, -4004.09, 1782.29 ), ( 355.87, 180.75, 5.74 ), "un_yt_os", undefined, "2" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_ee_dance_off_cs";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( 246.98, 2497.49, 1861.55 ), ( 290, 60, 0 ), "xe_nd_ci" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_ee_dance_off_cs";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( 58.03, -3844.45, 1773.51 ), ( 355.27, 187, 5.25 ), "un_yt_os", undefined, "1" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_ee_dance_off_cs";
    s.groupid = "p";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( 246.5, -3707, 1707.75 ), ( 0, 0, 0 ), "oz_ke_pr", undefined, "dj_booth" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_ee_dance_off_cs";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( -71.6, -3916.73, 1836.42 ), ( 4.79, 7.62, -5.2 ), "rv_to_c1" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_ee_dance_off_cs";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( -827.97, -1646.95, 1308 ), ( 0, 40, 0 ), "ka_vr_es", "cspf_0_auto13550741032463818596", "0" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_ee_dance_off_cs";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( -797.72, -1683, 1308 ), ( 0, 40, 0 ), "ka_vr_es", "cspf_0_auto1112955946537229846", "1" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_ee_dance_off_cs";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( -767.57, -1718.93, 1308 ), ( 0, 40, 0 ), "ka_vr_es", "cspf_0_auto13869500139311552983", "3" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_ee_dance_off_cs";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( -800.88, -1570.33, 1354 ), ( 0, 224.1, 0 ), "cspf_0_auto4679177149565606004" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_ee_dance_off_cs";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( -772.8, -1603.79, 1354 ), ( 0, 220, 0 ), "cspf_0_auto13550741032463818596" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_ee_dance_off_cs";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( -742.73, -1639.63, 1354 ), ( 0, 220, 0 ), "cspf_0_auto1112955946537229846" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_ee_dance_off_cs";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( -712.58, -1675.56, 1354 ), ( 0, 220, 0 ), "cspf_0_auto13869500139311552983" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_ee_dance_off_cs";
    s.groupid = "p";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( 238.38, -3844.92, 1756.27 ), ( 4.51, 4.69, -5.44 ), "dancing_zombie_1", undefined, "dc_he_zb" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_ee_dance_off_cs";
    s.groupid = "p";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( 156.38, -3703.42, 1782.52 ), ( 353.01, 226.78, 1.02 ), "bn_qw_mp" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_ee_dance_off_cs";
    s.groupid = "p";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( 251.38, -3967.67, 1766.52 ), ( 353.26, 236.28, -0.38 ), "dancing_zombie_2", undefined, "dc_he_zb" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_ee_dance_off_cs";
    s.groupid = "p";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( 276.38, -3935.17, 1762.52 ), ( 358.41, 156.67, 6.56 ), "dancing_zombie_3", undefined, "dc_he_zb" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_ee_dance_off_cs";
    s.groupid = "p";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( 462, -3840, 1860 ), ( 0, 270.9, 0 ), "oz_ke_pr", undefined, "laser_light" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_ee_dance_off_cs";
    s.groupid = "p";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( 72.8, -4177.91, 1801.56 ), ( 9.08, 64.61, 3.55 ), "dancing_zombie_4", undefined, "dc_he_zb" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_ee_dance_off_cs";
    s.groupid = "p";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( 164.84, -3822.61, 1763.17 ), ( 357.33, 184.07, 5.3 ), "dancing_zombie_10", undefined, "dc_he_zb" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_ee_dance_off_cs";
    s.groupid = "p";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( 461, -3841, 1873 ), ( 0, 0, 0 ), "oz_ke_pr", undefined, "disco_ball" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_ee_dance_off_cs";
    s.groupid = "p";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( 88, -3727, 1880.5 ), ( 0, 0, -2.97 ), "oz_ke_pr", undefined, "rotate_light" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_ee_dance_off_cs";
    s.groupid = "p";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( 110.3, -3847.65, 1894 ), ( 5.61, 92.74, 0 ), "oz_ke_pr", undefined, "rotate_light" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_ee_dance_off_cs";
    s.groupid = "p";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( 134.19, -3992.63, 1905.22 ), ( 1.78, 339.62, 0 ), "oz_ke_pr", undefined, "rotate_light" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_ee_dance_off_cs";
    s.groupid = "p";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( 156.88, -3702.42, 1782.52 ), ( 353.01, 226.78, 1.02 ), "oz_ke_pr", undefined, "bunny_fx" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_ee_dance_off_cs";
    s.script_scenescriptbundle = "sat_zm_quest_scarab_dance_party_mangler";
    fe [[ f ]]( s, us, cf, ( 40.98, -3743.62, 1758.94 ), ( 353.74, 231.47, 0.43 ), "qf_iu_mg" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_ee_dance_off_cs";
    s.groupid = "p";
    s.name = "script_struct_scene";
    s.script_scenescriptbundle = "zm_sat_scarab_dance_off_base_zombie_dance";
    fe [[ f ]]( s, us, cf, ( 0, 0, -96.5 ), ( 0, 0, 0 ), "wy_pa_sc" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_ee_dance_off_cs";
    s.groupid = "p";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( 368.38, -3857.17, 1746.52 ), ( 358.85, 153.44, 6.97 ), "dancing_zombie_7", undefined, "dc_he_zb" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_ee_dance_off_cs";
    s.groupid = "p";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( 269.88, -3781.67, 1748.52 ), ( 354.95, 278.62, -4.94 ), "dancing_zombie_8", undefined, "dc_he_zb" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_ee_dance_off_cs";
    s.groupid = "p";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( 66.04, -3728.28, 1755.73 ), ( 354.68, 193.88, 4.65 ), "dancing_zombie_11", undefined, "dc_he_zb" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_ee_dance_off_cs";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( 242.78, 2490.32, 1863.28 ), ( 20, 60, 0 ), "pn_lw_cp" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_ee_dance_off_cs";
    s.groupid = "p";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( 123.89, -3738.35, 1752.19 ), ( 352.99, 227.64, 0.92 ), "oz_ke_pr", undefined, "dj_booth" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_ee_dance_off_cs";
    s.groupid = "p";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( 25.89, -3720.01, 1757.57 ), ( 358.17, 310.15, -6.82 ), "dancing_zombie_9", undefined, "dc_he_zb" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_ee_dance_off_cs";
    s.groupid = "p";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( 117.88, -4168.26, 1796.42 ), ( 3.95, 111.26, 5.86 ), "dancing_zombie_12", undefined, "dc_he_zb" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_ee_dance_off_cs";
    s.groupid = "p";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( 200.12, -3934.6, 1766.55 ), ( 354.15, 200.91, 3.96 ), "dancing_zombie_13", undefined, "dc_he_zb" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_ee_dance_off_cs";
    s.groupid = "p";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( 117.22, -3789.47, 1757.89 ), ( 352.94, 237.66, -0.31 ), "dancing_zombie_6", undefined, "dc_he_zb" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_ee_dance_off_cs";
    s.name = "script_struct_scene";
    s.script_scenescriptbundle = "sat_zm_quest_scarab_dance_off_bunny";
    fe [[ f ]]( s, us, cf, ( -704, -1580, 1376 ), ( 0, 220, 0 ), "ml_za_ens" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_ee_dance_off_cs";
    s.groupid = "p";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( 139.19, -4065.08, 1784.37 ), ( 352.94, 232.55, 0.31 ), "dancing_zombie_15", undefined, "dc_he_zb" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_ee_dance_off_cs";
    s.groupid = "p";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( 135.08, -4112.7, 1791.24 ), ( 356.72, 156.97, 8.09 ), "dancing_zombie_14", undefined, "dc_he_zb" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_ee_dance_off_cs";
    s.script_scenescriptbundle = "sat_zm_quest_scarab_dance_party_mangler";
    fe [[ f ]]( s, us, cf, ( 102.97, -4114.73, 1789.65 ), ( 2.28, 119.31, 7.27 ), "qf_iu_mg" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_ee_dance_off_cs";
    s.groupid = "p";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( -1.4, -3898.9, 1776.4 ), ( 0, 0, 0 ), "oz_ke_pr", undefined, "house_party_fx" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_ee_dance_off_cs";
    fe [[ f ]]( s, us, cf, ( 134.75, -3901.5, 1768 ), ( 0, 0, 0 ), "ti_ro_cc", undefined, undefined, undefined, undefined, undefined, undefined, 500 );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace zm_sat_scarab_script_quest_ee_dance_off_cs
// Params 0, eflags: 0x4
// Checksum 0x5de74cf8, Offset: 0x15a5
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace zm_sat_scarab_script_quest_ee_dance_off_cs
// Params 0
// Checksum 0x4df71703, Offset: 0x15af
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "zm_sat_scarab_script_quest_ee_dance_off_cs" );
}

