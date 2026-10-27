// scripts\mp\zm\maps\zm_sat_scarab\zm_sat_scarab_script_quest_ww_cs.gsc  (hash_16ee7508f41c0040.gscc) (size: 19690 Bytes / 0x4cea / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x15b178b (22747019)
// size ...... 19690 (0x4cea)
// includes .. 3   (offset: 0x3fca)
// strings ... 144 (offset: 0x3fe2)
// dev strs .. 0   (offset: 0x4cea)
// exports ... 9   (offset: 0x3c32)
// cseg ...... 0x86f + 0x33c3 (0x3c32)
// imports ... 20  (offset: 0x3d9a)
// animtree1 . 0   (offset: 0x4cea)
// animtree2 . 0   (offset: 0x4cea)
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace zm_sat_scarab_script_quest_ww_cs;

// Namespace zm_sat_scarab_script_quest_ww_cs
// Params 0, eflags: 0x5
// Checksum 0x4e6cc7db, Offset: 0x88d
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"zm_sat_scarab_script_quest_ww_cs", undefined, &function_b39ecd3d51489472, undefined );
}

// Namespace zm_sat_scarab_script_quest_ww_cs
// Params 0, eflags: 0x4
// Checksum 0x886049ec, Offset: 0x8ae
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace zm_sat_scarab_script_quest_ww_cs
// Params 0, eflags: 0x4
// Checksum 0xd5b9a00, Offset: 0x8bf
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace zm_sat_scarab_script_quest_ww_cs
// Params 2
// Checksum 0xbdb2cc49, Offset: 0x8d0
// Size: 0x80
function main( unused, unused2 )
{
    if ( utility::flag_exist( "zm_sat_scarab_script_quest_ww_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "zm_sat_scarab_script_quest_ww_cs" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "zm_sat_scarab_script_quest_ww_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "zm_sat_scarab_script_quest_ww_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace zm_sat_scarab_script_quest_ww_cs
// Params 3, eflags: 0x4
// Checksum 0x8ed92ecf, Offset: 0x958
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "zm_sat_scarab_script_quest_ww_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "zm_sat_scarab_script_quest_ww_cs" );
}

// Namespace zm_sat_scarab_script_quest_ww_cs
// Params 3, eflags: 0x4
// Checksum 0x7233c7e8, Offset: 0x9d2
// Size: 0x3240
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_ww_cs";
    s.groupid = "L";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( -5769.91, -3032, 1973 ), ( 0, 90, 0 ), "cspf_0_auto8002117301883604371", "cspf_0_auto10708776948848749028", "18" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_ww_cs";
    s.groupid = "L";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( 1424.83, 1027.69, 2030 ), ( 0, 315, 0 ), "za_c" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_ww_cs";
    s.groupid = "L";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( 1347.14, 973.2, 2058.5 ), ( 12.32, 221.15, 65.34 ), "gb_l_p_item" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_ww_cs";
    s.groupid = "L";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( -7093.2, -2432, 1173.7 ), ( 0, 0, 0 ), "mh_l" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_ww_cs";
    s.groupid = "L";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( -8016.25, -2368, 1716.5 ), ( 0, 0, 0 ), "uf_l_start" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_ww_cs";
    s.groupid = "L";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( -5564, -2367.29, 2081.13 ), ( 0, 180, 0 ), "nm_p", "cspf_0_auto8002117301883604371", "16" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_ww_cs";
    s.groupid = "L";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( -6546.55, -1696, 1973 ), ( 0, -90, 0 ), "cspf_0_auto10708776948848749028", "cspf_0_auto793073457212220888", "15" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_ww_cs";
    s.groupid = "L";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( -4016.72, -3609, 1653.32 ), ( 0, 90, 0 ), "jr_l_r" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_ww_cs";
    s.groupid = "L";
    s.name = "script_struct";
    s.target2 = "l_p_3";
    fe [[ f ]]( s, us, cf, ( -6544.15, -3040.5, 1973 ), ( 0, 90, 0 ), "cspf_0_auto793073457212220888", "l_p_1", "10" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_ww_cs";
    s.groupid = "L";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( -4665.52, -1856, 1797.42 ), ( 0, -90, 0 ), "l_p_1", "cspf_0_auto3241959171322766981" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_ww_cs";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( -5058, -3947.42, 1264.5 ), ( 0, 208.8, 0 ), "va_fruit_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_ww_cs";
    s.groupid = "R";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( 3279.1, 3259.86, 1878.21 ), ( 0, 225, 0 ), "vn_r_s", "cspf_0_auto15064784174626225096", "1" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_ww_cs";
    s.groupid = "R";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( -4476, -2368, 1808 ), ( 85.9, 0, 0 ), "w_t_s", undefined, "4" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_ww_cs";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( -5075, -3993.5, 1264.5 ), ( 0, 106.96, 0 ), "va_fruit_scene", "cspf_0_auto8686564505961550264" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_ww_cs";
    s.groupid = "R";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( 4151.99, 2183.25, 1877.46 ), ( 0, 135, 0 ), "vn_r_s", "cspf_0_auto9806280736656416700", "2" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_ww_cs";
    s.groupid = "D";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( 3298.39, 2430.35, 2320.5 ), ( 0, 99.02, -0 ), "pk_d_a_part_b" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_ww_cs";
    s.groupid = "G";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( -5081, -3964, 1538.5 ), ( 0, 17.22, 0 ), "cspf_0_auto17271384113366322489" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_ww_cs";
    s.groupid = "R";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( 3558.16, 2172.48, 1749.46 ), ( 0, 195, -0 ), "vn_r_s", "cspf_0_auto8558934143788367187", "3" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_ww_cs";
    s.groupid = "A";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( -28590.8, 31291.7, 964.71 ), ( 3.66, 350.06, -3.04 ), "ty_part_b" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_ww_cs";
    s.groupid = "R";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( 3291.24, 2747.18, 1795.93 ), ( 0, 0, 0 ), "kl_r_i", undefined, "3" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_ww_cs";
    s.groupid = "R";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( 3076.22, 2241.49, 1801.18 ), ( 0, 45, 0 ), "fd_r" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_ww_cs";
    s.groupid = "R";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( 3588, 3044, 1794 ), ( 0, 270, 0 ), "kl_r_i", undefined, "1" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_ww_cs";
    s.groupid = "R";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( 3882, 2748, 1799 ), ( 0, 180, 0 ), "kl_r_i", undefined, "2" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_ww_cs";
    s.groupid = "R";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( 3586.33, 2452.87, 1800.52 ), ( 0, 90, 0 ), "kl_r_i", undefined, "4" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_ww_cs";
    s.groupid = "R";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( -3415, 1982.5, 1777.5 ), ( 270, 0, -90 ), "w_t_s", undefined, "1" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_ww_cs";
    s.groupid = "R";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( 3006, 2703, 1953 ), ( 90, 0, 105.17 ), "w_t_s", undefined, "2" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_ww_cs";
    s.groupid = "A";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( -28924, 29047, 964.95 ), ( 357.3, 103.5, 0 ), "a_p_c", undefined, "corpse_string" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_ww_cs";
    s.groupid = "G";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( -5067.79, -3962.68, 1328.25 ), ( 358.69, 301.66, 5.41 ), "xe_f" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_ww_cs";
    s.groupid = "G";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( -3, -937.5, 1197.25 ), ( 0, 0, 0 ), "gw_c_e_forge_r", undefined, undefined, undefined, undefined, undefined, undefined, 500 );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_ww_cs";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( -5072, -4003.5, 1264.5 ), ( 0, 106.96, 0 ), "cspf_0_auto8686564505961550264" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_ww_cs";
    s.groupid = "L";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( -3439, -2368.09, 1952.69 ), ( 0, 180, 0 ), "cspf_0_auto3241959171322766981", "cspf_0_auto174938876752176520" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_ww_cs";
    s.groupid = "R";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( 4395, -1727, 1520 ), ( 90, 0, -180 ), "w_t_s", undefined, "3" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_ww_cs";
    s.groupid = "A";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( -28538.5, 29852.5, 950 ), ( 0, 80.44, 0 ), "r_p_s_l" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_ww_cs";
    s.groupid = "A";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( -28874.4, 28989.5, 965.18 ), ( 1.49, 39.3, -1.27 ), "cf_part_bow_vision_angles" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_ww_cs";
    s.groupid = "G";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( -4228, -3967, 1303 ), ( 0, 318.13, 0 ), "cspf_0_auto3577180655570819111", "cspf_0_auto15380449211323118552" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_ww_cs";
    s.groupid = "L";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( -5706.12, -1704, 1973 ), ( 0, -90, 0 ), "l_p_2", "cspf_0_auto9199165193215368788", "15" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_ww_cs";
    s.groupid = "A";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( -28585.3, 31217.7, 963.71 ), ( 0, 84.11, 0 ), "b_p_l_s" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_ww_cs";
    s.groupid = "L";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( -5564.08, -2367.79, 1966.64 ), ( 0, 180, 90 ), "xu_prism_arrow_temp" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_ww_cs";
    s.groupid = "L";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( -5560, -1908.97, 1973 ), ( 0, 180, 0 ), "l_p_3", "cspf_0_auto12063026004968603192", "15" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_ww_cs";
    s.groupid = "V";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( -5081, -3964, 1238 ), ( 0, 0, 0 ), "n_c_v" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_ww_cs";
    s.groupid = "A";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( -28548.9, 31312, 963.42 ), ( 357.21, 276.92, -0.54 ), "a_p_c", undefined, "corpse_bow" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_ww_cs";
    s.groupid = "V";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( -5068, -3952, 1490 ), ( 0, 0, 0 ), "c_v_fx" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_ww_cs";
    s.groupid = "D";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( 3288.34, 2442.68, 2270 ), ( 360, 45.59, -0 ), "bx_d_a" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_ww_cs";
    s.groupid = "D";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( 3280.37, 2447.94, 2320.25 ), ( 0, 301.9, 0 ), "sn_d_a_part_r" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_ww_cs";
    s.groupid = "D";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( 3296.06, 2447.62, 2321 ), ( 0, 286.86, 0 ), "tr_d_a_part_s" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_ww_cs";
    s.groupid = "D";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( 3288.37, 2443.26, 2336 ), ( 360, 315, 0 ), "wt_spawn" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_ww_cs";
    s.groupid = "A";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( -28870.4, 29010.6, 955.07 ), ( 0, 0, 0 ), "az_part_s" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_ww_cs";
    s.groupid = "A";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( -27163, 29808.5, 1008 ), ( 0, 172.07, 0 ), "dg_a_p_spawn" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_ww_cs";
    s.groupid = "A";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( -28521, 29963, 923.5 ), ( 0, 269.73, 0 ), "a_p_c", undefined, "corpse_rifle" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_ww_cs";
    s.groupid = "A";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( -28897.9, 29025, 962.13 ), ( 1.49, 39.17, -1.27 ), "kr_a_p_f_b" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_ww_cs";
    s.groupid = "A";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( -28499.3, 29945.6, 959 ), ( 354.74, 312.83, -176.01 ), "wk_part_r" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_ww_cs";
    s.groupid = "A";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( -28656, 28183, 1008.5 ), ( 0, 90.31, 0 ), "nu_a_p_e" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_ww_cs";
    s.groupid = "G";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( -4947, -3967.5, 1353 ), ( 0, 0, 0 ), "cspf_0_auto15380449211323118552", "cspf_0_auto17271384113366322489" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_ww_cs";
    s.groupid = "A";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( -27056.7, 29796.8, 1056 ), ( 0, 171.9, 0 ), "nu_a_p_e" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_ww_cs";
    s.groupid = "A";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( -28654, 28304, 961 ), ( 0, 86.91, 0 ), "dg_a_p_spawn" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_ww_cs";
    s.groupid = "A";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( -30316.9, 29707.1, 920 ), ( 0, 2, 0 ), "nu_a_p_e" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_ww_cs";
    s.groupid = "A";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( -28654, 28308, 1009 ), ( 0, 85.16, 0 ), "lc_a_p_spawn_parent", "dg_a_p_spawn" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_ww_cs";
    s.groupid = "A";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( -4968.24, -3958.02, 1271 ), ( 0, 180.58, 0 ), "qx_a_p_end_spawn" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_ww_cs";
    s.groupid = "A";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( -4967.95, -3939.12, 1307 ), ( 0, 274.66, 0 ), "vt_a_p_end_spawn_parent", "qx_a_p_end_spawn" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_ww_cs";
    s.groupid = "A";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( -28523, 29952, 960 ), ( 0, 260.87, 0 ), "r_p_v_t" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_ww_cs";
    s.groupid = "L";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( -6623.12, -1815.47, 1859.53 ), ( 0.87, 270.32, -90.39 ), "cspf_0_auto12063026004968603192" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_ww_cs";
    s.groupid = "D";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( 4001.1, 3117.47, 4995.5 ), ( 360, 317.47, 0 ), "dx_m_start", "tn_m_end" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_ww_cs";
    s.groupid = "D";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( 3291.9, 2440.42, 2328 ), ( 0, 313.67, 0 ), "tn_m_end" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_ww_cs";
    s.groupid = "L";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( -6052.84, -3132, 1870.53 ), ( 90, 0, -90 ), "cspf_0_auto9199165193215368788" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_ww_cs";
    s.groupid = "A";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( -30195, 29714, 872 ), ( 0, 355.84, 0 ), "dg_a_p_spawn" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_ww_cs";
    s.groupid = "A";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( -28370, 29894, 962.12 ), ( 9.97, 54.39, 1.17 ), "to_a_p_zombie_spawn", undefined, "rifle" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_ww_cs";
    s.groupid = "A";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( -28723.8, 29697.6, 960 ), ( 0, 273.04, 0 ), "to_a_p_zombie_spawn", undefined, "rifle" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_ww_cs";
    s.groupid = "A";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( -28643, 28950, 958.97 ), ( 2.78, 227.04, -2.19 ), "to_a_p_zombie_spawn", undefined, "string" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_ww_cs";
    s.groupid = "A";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( -28742.2, 29918.3, 960 ), ( 0, 5.53, 0 ), "to_a_p_zombie_spawn", undefined, "rifle" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_ww_cs";
    s.groupid = "G";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( -4040, -3981, 1379 ), ( 0, 0, 0 ), "cspf_0_auto8158654659545519178", "cspf_0_auto3577180655570819111" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_ww_cs";
    s.groupid = "A";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( -28762, 29177, 960 ), ( 0, 272.78, 0 ), "to_a_p_zombie_spawn", undefined, "string" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_ww_cs";
    s.groupid = "S";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( -5007.36, -3796.96, 1272 ), ( 0, 357.33, 0 ), "eq_s_a_s" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_ww_cs";
    s.groupid = "A";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( -28624, 29175, 960 ), ( 0, 112.26, 0 ), "to_a_p_zombie_spawn", undefined, "string" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_ww_cs";
    s.groupid = "S";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( -4794.86, -3964.95, 1248 ), ( 0, 359.78, 0 ), "eq_s_a_s" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_ww_cs";
    s.groupid = "S";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( -5042.09, -4123.41, 1272 ), ( 0, 27.57, 0 ), "eq_s_a_s" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_ww_cs";
    s.groupid = "A";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( -28874, 30387, 966.91 ), ( 1.78, 184.44, -8.87 ), "to_a_p_zombie_spawn", undefined, "bow" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_ww_cs";
    s.groupid = "S";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( -5384.63, -3778.25, 1248 ), ( 0, 317.05, 0 ), "eq_s_a_s" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_ww_cs";
    s.groupid = "A";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( -28678, 30502, 960.24 ), ( 359.2, 339.76, -0.06 ), "to_a_p_zombie_spawn", undefined, "bow" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_ww_cs";
    s.groupid = "S";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( -5356.01, -4148.39, 1248 ), ( 0, 36.33, 0 ), "eq_s_a_s" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_ww_cs";
    s.groupid = "A";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( -28527, 31078, 982.43 ), ( 358.11, 238.77, -0.34 ), "to_a_p_zombie_spawn", undefined, "bow" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_ww_cs";
    s.groupid = "R";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( 3575.35, 2735.11, 1765.21 ), ( 0, 225, 0 ), "vn_r_s", "cspf_0_auto11187910973509320857", "4" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_ww_cs";
    s.groupid = "A";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( -28504.2, 29945.5, 957.5 ), ( 0, 267.61, 0 ), "s_p_v_t" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_ww_cs";
    s.groupid = "G";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( -4054.5, -3964.5, 1539 ), ( 0, 0, 0 ), "w_a_v", "cspf_0_auto8158654659545519178" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_ww_cs";
    s.groupid = "L";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( -4526, -2967, 1865.5 ), ( 0, 0, 0 ), "cspf_0_auto174938876752176520" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_ww_cs";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( 3588.5, 2758, 2196.25 ), ( 0, 45, 0 ), "fj_d_s_r_fx" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_ww_cs";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( 3591, 2762, 1715.75 ), ( 0, 45, 0 ), "qi_d_s_r_p_fx" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_ww_cs";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( -3928, -3840, 1488 ), ( 0, 0, 0 ), "rv_n_s_r_fx" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_ww_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s._size_max = ( 366, 212, 190 );
    s._size_min = ( 234, 332, 82 );
    s.height = 128;
    s.length = "128";
    s.name = "noent_volume_trigger";
    s.triton = "exclude";
    s.width = "128";
    fe [[ f ]]( s, us, cf, ( -6072.29, -3514.33, 1488 ), ( 0, 89.32, 0 ), "s_n_s_e_t" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_ww_cs";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( -4884.63, -3778.25, 1248 ), ( 0, 0, 0 ), "sy_a_p_r1" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_ww_cs";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( -5384.63, -3158.25, 1248 ), ( 0, 12, 0 ), "hr_r_s_k2" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_ww_cs";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( -6054.63, -3778.25, 1248 ), ( 0, 24, 0 ), "yg_r_i_q3" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_ww_cs";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( -4816.01, -4148.39, 1248 ), ( 0, 36, 0 ), "w_t_s_j4" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_ww_cs";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( -5356.01, -4598.39, 1248 ), ( 0, 48, 0 ), "ud_d_a_m5" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_ww_cs";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( -6056.01, -4148.39, 1248 ), ( 0, 60, 0 ), "st_l_p_n6" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_ww_cs";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( -3624.5, -3964.5, 1539 ), ( 0, 72, 0 ), "bw_n_s_t7" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_ww_cs";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( -4054.5, -3404.5, 1539 ), ( 0, 84, 0 ), "kp_f_s_v8" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_ww_cs";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( -4694.5, -3964.5, 1539 ), ( 0, 96, 0 ), "le_m_p_x9" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_ww_cs";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( -3458, -3840, 1488 ), ( 0, 108, 0 ), "jp_part_c1" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_ww_cs";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( -3928, -4450, 1488 ), ( 0, 120, 0 ), "mi_a_t_r2" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_ww_cs";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( -4448, -3840, 1488 ), ( 0, 132, 0 ), "cn_c_v_n3" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_ww_cs";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( 4025.35, 2735.11, 1765.21 ), ( 0, 144, 0 ), "mu_t_r_p4" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_ww_cs";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( 3575.35, 3415.11, 1765.21 ), ( 0, 156, 0 ), "hb_a_p_f5" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_ww_cs";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( 2985.35, 2735.11, 1765.21 ), ( 0, 168, 0 ), "om_d_s_r_n6" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_ww_cs";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( 4108.5, 2758, 2196.25 ), ( 0, 180, 0 ), "hq_n_s_r_t7" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_ww_cs";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( 3588.5, 2328, 2196.25 ), ( 0, 192, 0 ), "ct_r_p_v8" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_ww_cs";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( 2928.5, 2758, 2196.25 ), ( 0, 204, 0 ), "cy_l_r_x9" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_ww_cs";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( 4071, 2762, 1715.75 ), ( 0, 216, 0 ), "rw_f_g_b1" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_ww_cs";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( 3591, 3362, 1715.75 ), ( 0, 228, 0 ), "gs_p_s_h2" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_ww_cs";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( 3051, 2762, 1715.75 ), ( 0, 240, 0 ), "rf_a_p_z_s3" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_ww_cs";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( -28168, 30502, 960.24 ), ( 0, 252, 0 ), "yv_d_a_p_m4" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_ww_cs";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( -28678, 29862, 960.24 ), ( 0, 264, 0 ), "ep_c_e_f_r5" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_ww_cs";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( -29098, 30502, 960.24 ), ( 0, 276, 0 ), "zs_s_a_k6" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_ww_cs";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( -27827, 31078, 982.43 ), ( 0, 288, 0 ), "pb_r_i_m7" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_ww_cs";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( -28527, 31528, 982.43 ), ( 0, 300, 0 ), "w_t_s_n8" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_ww_cs";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( -29087, 31078, 982.43 ), ( 0, 312, 0 ), "po_l_s_q9" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_ww_cs";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( -27874.2, 29945.5, 957.5 ), ( 0, 324, 0 ), "pl_a_e_r1" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_ww_cs";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( -28504.2, 29445.5, 957.5 ), ( 0, 336, 0 ), "zk_m_e_t2" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_ww_cs";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( -28984.2, 29945.5, 957.5 ), ( 0, 348, 0 ), "dl_f_s_p3" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_ww_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s._size_max = ( 412, 236, 208 );
    s._size_min = ( 196, 356, 72 );
    s.height = 96;
    s.length = "144";
    s.name = "noent_volume_trigger";
    s.triton = "exclude";
    s.width = "88";
    fe [[ f ]]( s, us, cf, ( -5863.63, -2023.25, 1476 ), ( 0, 14, 0 ), "qn_n_v_a1" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_ww_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s._size_max = ( 348, 188, 244 );
    s._size_min = ( 228, 292, 96 );
    s.height = 160;
    s.length = "96";
    s.name = "noent_volume_trigger";
    s.triton = "exclude";
    s.width = "120";
    fe [[ f ]]( s, us, cf, ( -5478.63, -3288.25, 1602 ), ( 0, 39, 0 ), "rx_n_v_b2" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_ww_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s._size_max = ( 438, 264, 224 );
    s._size_min = ( 210, 382, 80 );
    s.height = 112;
    s.length = "176";
    s.name = "noent_volume_trigger";
    s.triton = "exclude";
    s.width = "104";
    fe [[ f ]]( s, us, cf, ( -5968.01, -4218.39, 1248 ), ( 0, 66, 0 ), "tm_n_v_c3" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_ww_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s._size_max = ( 372, 222, 238 );
    s._size_min = ( 202, 318, 86 );
    s.height = 136;
    s.length = "128";
    s.name = "noent_volume_trigger";
    s.triton = "exclude";
    s.width = "132";
    fe [[ f ]]( s, us, cf, ( -4093.5, -1283.5, 1539 ), ( 0, 92, 0 ), "vk_n_v_d4" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_ww_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s._size_max = ( 426, 248, 212 );
    s._size_min = ( 214, 344, 74 );
    s.height = 104;
    s.length = "152";
    s.name = "noent_volume_trigger";
    s.triton = "exclude";
    s.width = "92";
    fe [[ f ]]( s, us, cf, ( 3815.35, 2852.11, 1864.21 ), ( 0, 118, 0 ), "wp_n_v_e5" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_ww_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s._size_max = ( 334, 206, 252 );
    s._size_min = ( 134, 274, 108 );
    s.height = 172;
    s.length = "108";
    s.name = "noent_volume_trigger";
    s.triton = "exclude";
    s.width = "116";
    fe [[ f ]]( s, us, cf, ( 3308, 3479, 1825.75 ), ( 0, 146, 0 ), "xf_n_v_f6" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_ww_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s._size_max = ( 452, 274, 226 );
    s._size_min = ( 224, 396, 82 );
    s.height = 124;
    s.length = "168";
    s.name = "noent_volume_trigger";
    s.triton = "exclude";
    s.width = "100";
    fe [[ f ]]( s, us, cf, ( 380.68, 3622.81, 1771.2 ), ( 340.03, 92.49, -0.85 ), "yk_n_v_g7" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_ww_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s._size_max = ( 388, 232, 240 );
    s._size_min = ( 218, 326, 94 );
    s.height = 148;
    s.length = "136";
    s.name = "noent_volume_trigger";
    s.triton = "exclude";
    s.width = "128";
    fe [[ f ]]( s, us, cf, ( -28378.2, 29718.5, 957.5 ), ( 0, 199, 0 ), "zl_n_v_h8" );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace zm_sat_scarab_script_quest_ww_cs
// Params 0, eflags: 0x4
// Checksum 0x98bd528e, Offset: 0x3c1a
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace zm_sat_scarab_script_quest_ww_cs
// Params 0
// Checksum 0x4c8af382, Offset: 0x3c24
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "zm_sat_scarab_script_quest_ww_cs" );
}

