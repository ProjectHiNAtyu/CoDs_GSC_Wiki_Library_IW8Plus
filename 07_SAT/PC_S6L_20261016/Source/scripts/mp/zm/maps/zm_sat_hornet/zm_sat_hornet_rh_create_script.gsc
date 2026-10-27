// scripts\mp\zm\maps\zm_sat_hornet\zm_sat_hornet_rh_create_script.gsc  (hash_6ddb7d5e12a236a7.gscc) (size: 14250 Bytes / 0x37aa / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x9f236cb8 (2669898936)
// size ...... 14250 (0x37aa)
// includes .. 3   (offset: 0x2ea6)
// strings ... 110 (offset: 0x2ebe)
// dev strs .. 0   (offset: 0x37aa)
// exports ... 9   (offset: 0x2b0e)
// cseg ...... 0xc8a + 0x1e84 (0x2b0e)
// imports ... 20  (offset: 0x2c76)
// animtree1 . 0   (offset: 0x37aa)
// animtree2 . 0   (offset: 0x37aa)
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace zm_sat_hornet_rh_create_script;

// Namespace zm_sat_hornet_rh_create_script
// Params 0, eflags: 0x5
// Checksum 0x6fc7c8ff, Offset: 0xca8
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"zm_sat_hornet_rh_create_script", undefined, &function_b39ecd3d51489472, undefined );
}

// Namespace zm_sat_hornet_rh_create_script
// Params 0, eflags: 0x4
// Checksum 0x7db4f1e1, Offset: 0xcc9
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace zm_sat_hornet_rh_create_script
// Params 0, eflags: 0x4
// Checksum 0xf88f220d, Offset: 0xcda
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace zm_sat_hornet_rh_create_script
// Params 2
// Checksum 0x48667444, Offset: 0xceb
// Size: 0x80
function main( unused, unused2 )
{
    if ( utility::flag_exist( "zm_sat_hornet_rh_create_script" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "zm_sat_hornet_rh_create_script" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "zm_sat_hornet_rh_create_script" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "zm_sat_hornet_rh_create_script" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace zm_sat_hornet_rh_create_script
// Params 3, eflags: 0x4
// Checksum 0x7b0d96c2, Offset: 0xd73
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "zm_sat_hornet_rh_create_script" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "zm_sat_hornet_rh_create_script" );
}

// Namespace zm_sat_hornet_rh_create_script
// Params 3, eflags: 0x4
// Checksum 0xb25d93d5, Offset: 0xded
// Size: 0x1d01
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "zm_sat_hornet_rh_create_script";
    s.groupid = "Chest_spline";
    fe [[ f ]]( s, us, cf, ( -318.87, -17178, 1582.72 ), ( 0, 189.7, 0 ), undefined, "cspf_0_auto14449211871676662580", "ch_roll" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_rh_create_script";
    fe [[ f ]]( s, us, cf, ( -317.87, -17179, 1582.72 ), ( 0, 189.7, 0 ), "tb_start" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_rh_create_script";
    s.groupid = "Chest_spline";
    fe [[ f ]]( s, us, cf, ( -250.24, -17320.8, 1461.19 ), ( 0, 189.7, -39 ), "cspf_0_auto14449211871676662580", "cspf_0_auto9935336530880229716" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_rh_create_script";
    s.groupid = "Chest_spline";
    fe [[ f ]]( s, us, cf, ( -527.38, -18099.4, 1092.92 ), ( 10.58, 144.85, -10.56 ), "cspf_0_auto2182747679439140383", "cspf_0_auto18392446860063324657" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_rh_create_script";
    s.groupid = "Chest_spline";
    fe [[ f ]]( s, us, cf, ( -636.88, -18180.3, 906.43 ), ( 9.05, 14.64, 10.97 ), "cspf_0_auto18392446860063324657", undefined, "final_tb" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_rh_create_script";
    s.groupid = "Inital_flight_failed";
    fe [[ f ]]( s, us, cf, ( -68.23, -18609.1, 1304.49 ), ( 2.73, 237.11, -11.23 ), undefined, "cspf_0_auto2645385719960581624", "pg_perch_start_failed" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_rh_create_script";
    fe [[ f ]]( s, us, cf, ( -630.69, -18181.7, 917.57 ), ( 343.56, 15.55, 5.11 ), "pg_box_start" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_rh_create_script";
    s.groupid = "Chest_spline";
    fe [[ f ]]( s, us, cf, ( -189.12, -17536.7, 1361.03 ), ( 6.99, 186.7, -18.08 ), "cspf_0_auto9935336530880229716", "cspf_0_auto6916049751018246629" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_rh_create_script";
    fe [[ f ]]( s, us, cf, ( -382, -17177, 1350.14 ), ( 0, 189.5, 0 ), "cb_radius", undefined, undefined, undefined, undefined, undefined, undefined, 200 );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_rh_create_script";
    s.groupid = "Chest_spline";
    fe [[ f ]]( s, us, cf, ( -251.96, -17743.8, 1300.11 ), ( 13.23, 144.34, -13.06 ), "cspf_0_auto6916049751018246629", "cspf_0_auto5575184010303921928" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_rh_create_script";
    s.groupid = "Chest_spline";
    fe [[ f ]]( s, us, cf, ( -363.14, -17875.5, 1146.78 ), ( 10.58, 144.85, -10.56 ), "cspf_0_auto5575184010303921928", "cspf_0_auto2182747679439140383" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_rh_create_script";
    s.groupid = "Inital_flight";
    fe [[ f ]]( s, us, cf, ( -430.63, -18091.2, 1155.45 ), ( 354.73, 23.9, 4.28 ), "cspf_0_auto13216295183911416177", "cspf_0_auto11779508830371182191", "pg_first_flight_start" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_rh_create_script";
    s.groupid = "Inital_flight";
    fe [[ f ]]( s, us, cf, ( -247.77, -18105, 1193.27 ), ( 348.48, 344.29, 12.85 ), "cspf_0_auto11779508830371182191", "cspf_0_auto9722185015439282708" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_rh_create_script";
    s.groupid = "Inital_flight";
    fe [[ f ]]( s, us, cf, ( -126.25, -18233.7, 1199.85 ), ( 354.5, 321.2, 16.31 ), "cspf_0_auto9722185015439282708", "cspf_0_auto15415565106111568720" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_rh_create_script";
    s.groupid = "Inital_flight";
    fe [[ f ]]( s, us, cf, ( -35.68, -18415.1, 1236.78 ), ( 355.57, 298.13, 3.63 ), "cspf_0_auto15415565106111568720", "cspf_0_auto17447348143771864446" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_rh_create_script";
    s.groupid = "Inital_flight";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( -68.23, -18609.1, 1304.49 ), ( 2.36, 235.24, -11.31 ), "cspf_0_auto17447348143771864446", undefined, "pg_perch_start" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_rh_create_script";
    s.groupid = "second_tree_path";
    fe [[ f ]]( s, us, cf, ( 2558.63, -20874.6, 547.11 ), ( 0.03, 338.84, 23.36 ), undefined, "cspf_0_auto12653158501013413464", "st_path" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_rh_create_script";
    fe [[ f ]]( s, us, cf, ( -489.38, -20713.1, 1301.37 ), ( 0, 295.3, 0 ), "f_nest" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_rh_create_script";
    s.groupid = "First_tree";
    fe [[ f ]]( s, us, cf, ( -68.23, -18609.1, 1304.49 ), ( 2.36, 235.24, -11.31 ), undefined, "cspf_0_auto13605797165527779112", "ft_path" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_rh_create_script";
    s.groupid = "First_tree";
    fe [[ f ]]( s, us, cf, ( -170.53, -18593.2, 1102.88 ), ( 5.98, 249.11, -14.06 ), "cspf_0_auto13605797165527779112", "cspf_0_auto16230209118932278581" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_rh_create_script";
    s.groupid = "First_tree";
    fe [[ f ]]( s, us, cf, ( -153.08, -18784.6, 1034.92 ), ( 12.36, 279.97, -9.02 ), "cspf_0_auto16230209118932278581", "cspf_0_auto5739932609299527844" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_rh_create_script";
    s.groupid = "First_tree";
    fe [[ f ]]( s, us, cf, ( -103.69, -19012.2, 892.02 ), ( 7.16, 279.97, -0.02 ), "cspf_0_auto5739932609299527844", "cspf_0_auto15955962047392925328" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_rh_create_script";
    s.groupid = "First_tree";
    fe [[ f ]]( s, us, cf, ( -45.88, -19336.2, 850.84 ), ( 7.16, 279.97, -0.02 ), "cspf_0_auto15955962047392925328", "cspf_0_auto1330216079617599032" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_rh_create_script";
    s.groupid = "First_tree";
    fe [[ f ]]( s, us, cf, ( 147.74, -19763.1, 934.9 ), ( 7.16, 279.97, -0.02 ), "cspf_0_auto1330216079617599032", "cspf_0_auto14895575790370512438" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_rh_create_script";
    s.groupid = "First_tree";
    fe [[ f ]]( s, us, cf, ( 454.96, -20205.4, 873.62 ), ( 6.79, 298.61, 2.26 ), "cspf_0_auto14895575790370512438", "cspf_0_auto2021767066575798008" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_rh_create_script";
    s.groupid = "First_tree";
    fe [[ f ]]( s, us, cf, ( 881.17, -20769.6, 574.96 ), ( 5.9, 314.68, 4.05 ), "cspf_0_auto2021767066575798008", "cspf_0_auto15898084553525844007" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_rh_create_script";
    s.groupid = "First_tree";
    fe [[ f ]]( s, us, cf, ( 1261.78, -21061.4, 604.85 ), ( 2.22, 352.11, 6.8 ), "cspf_0_auto15898084553525844007", "cspf_0_auto4189087471281807176" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_rh_create_script";
    s.groupid = "First_tree";
    fe [[ f ]]( s, us, cf, ( 1828.68, -21030, 626.09 ), ( 358.06, 6.14, 11.84 ), "cspf_0_auto4189087471281807176", "cspf_0_auto13120915812000893751" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_rh_create_script";
    s.groupid = "First_tree";
    fe [[ f ]]( s, us, cf, ( 2558.63, -20874.6, 547.11 ), ( 358.56, 342.24, 23.31 ), "cspf_0_auto13120915812000893751" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_rh_create_script";
    s.groupid = "second_tree_path";
    fe [[ f ]]( s, us, cf, ( 2405.64, -21167.2, 639.5 ), ( 355.21, 223.73, -6.62 ), "cspf_0_auto12653158501013413464", "cspf_0_auto9590066070004935258" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_rh_create_script";
    s.groupid = "second_tree_path";
    fe [[ f ]]( s, us, cf, ( 2303.53, -21299.2, 748.15 ), ( 355.66, 226.93, -5.78 ), "cspf_0_auto9590066070004935258", "cspf_0_auto12021964091621373303" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_rh_create_script";
    s.groupid = "second_tree_path";
    fe [[ f ]]( s, us, cf, ( 2106.81, -21872.2, 765.13 ), ( 0.8, 270.06, -7.19 ), "cspf_0_auto12021964091621373303", "cspf_0_auto10143705252640707039" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_rh_create_script";
    s.groupid = "second_tree_path";
    fe [[ f ]]( s, us, cf, ( 2357.42, -22376.4, 585.34 ), ( 0.8, 270.06, -7.19 ), "cspf_0_auto10143705252640707039", "cspf_0_auto2172896136401428064" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_rh_create_script";
    s.groupid = "second_tree_path";
    fe [[ f ]]( s, us, cf, ( 2003.48, -23053, 295.21 ), ( 353.65, 202.4, -3.46 ), "cspf_0_auto2172896136401428064", "cspf_0_auto1503852252824334276" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_rh_create_script";
    s.groupid = "second_tree_path";
    fe [[ f ]]( s, us, cf, ( 1577.18, -23065.1, 289.43 ), ( 14.48, 176.15, 1.55 ), "cspf_0_auto1503852252824334276", "cspf_0_auto17314665328042004329" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_rh_create_script";
    s.groupid = "second_tree_path";
    fe [[ f ]]( s, us, cf, ( 641.39, -23122.8, 348.64 ), ( 10.21, 123.89, -6.88 ), "cspf_0_auto17314665328042004329", "cspf_0_auto7077983276876954718" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_rh_create_script";
    s.groupid = "second_tree_path";
    fe [[ f ]]( s, us, cf, ( 387.12, -22496, 404.51 ), ( 4.93, 132.03, 4.1 ), "cspf_0_auto7077983276876954718", "cspf_0_auto5344696147727098662" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_rh_create_script";
    s.groupid = "second_tree_path";
    fe [[ f ]]( s, us, cf, ( 305.89, -22399.8, 409.2 ), ( 8.67, 201.44, -0.46 ), "cspf_0_auto5344696147727098662" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_rh_create_script";
    s.groupid = "third_PATH";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( 305.81, -22400.7, 409.27 ), ( 8.67, 201.44, -0.46 ), undefined, "cspf_0_auto17741108687187028213", "tht_path" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_rh_create_script";
    s.groupid = "third_PATH";
    fe [[ f ]]( s, us, cf, ( 111.53, -23075.9, 442.87 ), ( 355.34, 202.18, 0.51 ), "cspf_0_auto17741108687187028213", "cspf_0_auto13831510852924487223" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_rh_create_script";
    s.groupid = "third_PATH";
    fe [[ f ]]( s, us, cf, ( -552.83, -22896.5, 238.82 ), ( 355.45, 190.39, 0.36 ), "cspf_0_auto13831510852924487223", "cspf_0_auto17170650220764288334" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_rh_create_script";
    s.groupid = "third_PATH";
    fe [[ f ]]( s, us, cf, ( -867.3, -22955.3, 264.36 ), ( 355.45, 190.39, 0.36 ), "cspf_0_auto17170650220764288334", "cspf_0_auto630030256957626704" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_rh_create_script";
    s.groupid = "third_PATH";
    fe [[ f ]]( s, us, cf, ( -2012.08, -22802.7, 232.54 ), ( 356, 165.93, 2.21 ), "cspf_0_auto630030256957626704", "cspf_0_auto9530846725861574843" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_rh_create_script";
    s.groupid = "third_PATH";
    fe [[ f ]]( s, us, cf, ( -2640.88, -22649.5, 188.47 ), ( 356, 165.93, 2.21 ), "cspf_0_auto9530846725861574843", "cspf_0_auto18183305030969380692" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_rh_create_script";
    s.groupid = "third_PATH";
    fe [[ f ]]( s, us, cf, ( -2856.23, -22540.9, 202.91 ), ( 348.89, 82.81, 4.34 ), "cspf_0_auto18183305030969380692", "cspf_0_auto14207315361233312476" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_rh_create_script";
    s.groupid = "third_PATH";
    fe [[ f ]]( s, us, cf, ( -2573.85, -21597.4, 451.25 ), ( 347.02, 35.84, 9.84 ), "cspf_0_auto14207315361233312476" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_rh_create_script";
    s.groupid = "Final_path";
    fe [[ f ]]( s, us, cf, ( -2573.82, -21597.4, 451.24 ), ( 348.35, 28.6, 11.39 ), undefined, "cspf_0_auto18396886526435868195", "fnt_path" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_rh_create_script";
    s.groupid = "Final_path";
    fe [[ f ]]( s, us, cf, ( -2238.69, -21231, 611.71 ), ( 342.04, 359, 5.99 ), "cspf_0_auto18396886526435868195", "cspf_0_auto12208934583769194356" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_rh_create_script";
    s.groupid = "Final_path";
    fe [[ f ]]( s, us, cf, ( -1425.99, -21483.6, 850.02 ), ( 342.04, 359, 5.99 ), "cspf_0_auto12208934583769194356", "cspf_0_auto18297494359102449019" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_rh_create_script";
    s.groupid = "Final_path";
    fe [[ f ]]( s, us, cf, ( -958.36, -21492.8, 1001.3 ), ( 359.35, 0.79, 5.7 ), "cspf_0_auto18297494359102449019", "cspf_0_auto11487917846847898449" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_rh_create_script";
    s.groupid = "Final_path";
    fe [[ f ]]( s, us, cf, ( -535.03, -21127.5, 1192.4 ), ( 355.26, 49.99, 3.23 ), "cspf_0_auto11487917846847898449", "cspf_0_auto17290431055076052630" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_rh_create_script";
    s.groupid = "Final_path";
    fe [[ f ]]( s, us, cf, ( -506.3, -20721.8, 1332.62 ), ( 4.08, 309.06, 4.03 ), "cspf_0_auto17290431055076052630", undefined, "fn_br_pt" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_rh_create_script";
    fe [[ f ]]( s, us, cf, ( -208.98, -20992.9, 1158.85 ), ( 0, 0, 0 ), "tpc_m_p" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_rh_create_script";
    fe [[ f ]]( s, us, cf, ( 82.82, -20547.5, 533.24 ), ( 0, 0, 0 ), "cb_t_t", undefined, undefined, undefined, undefined, undefined, undefined, 700 );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_rh_create_script";
    fe [[ f ]]( s, us, cf, ( -209.98, -21020.5, 562 ), ( 0, 0, 0 ), "tpc_f_p" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_rh_create_script";
    s.groupid = "first_tree_return";
    fe [[ f ]]( s, us, cf, ( 2560.12, -20875.1, 546.62 ), ( 3.2, 343.65, 6.39 ), undefined, "cspf_0_auto10234288350419738313", "ft_return_path" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_rh_create_script";
    s.groupid = "first_tree_return";
    fe [[ f ]]( s, us, cf, ( 2001.73, -21098.2, 860.07 ), ( 356.36, 159.67, -6.16 ), "cspf_0_auto10234288350419738313", "cspf_0_auto7469391565741153215" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_rh_create_script";
    s.groupid = "first_tree_return";
    fe [[ f ]]( s, us, cf, ( 1348.73, -20878.2, 1090 ), ( 356.36, 159.67, -6.16 ), "cspf_0_auto7469391565741153215", "cspf_0_auto185559172490751120" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_rh_create_script";
    s.groupid = "first_tree_return";
    fe [[ f ]]( s, us, cf, ( 610.94, -20175.1, 1193.25 ), ( 356.36, 159.67, -6.16 ), "cspf_0_auto185559172490751120", "cspf_0_auto1408621734169126112" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_rh_create_script";
    s.groupid = "first_tree_return";
    fe [[ f ]]( s, us, cf, ( 217.72, -19746.1, 1327.21 ), ( 352.95, 109.75, -1.19 ), "cspf_0_auto1408621734169126112", "cspf_0_auto17591096952581786494" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_rh_create_script";
    s.groupid = "first_tree_return";
    fe [[ f ]]( s, us, cf, ( -30.17, -19058, 1487.56 ), ( 352.95, 109.75, -1.19 ), "cspf_0_auto17591096952581786494", "cspf_0_auto2260507687710197914" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_rh_create_script";
    s.groupid = "first_tree_return";
    fe [[ f ]]( s, us, cf, ( -297.44, -18445.9, 1104.53 ), ( 5.61, 142, -1.54 ), "cspf_0_auto2260507687710197914", "cspf_0_auto3678735281195104604" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_rh_create_script";
    s.groupid = "second_tree_return";
    fe [[ f ]]( s, us, cf, ( 306.08, -22401.4, 409.26 ), ( 8.67, 201.44, -0.46 ), undefined, "cspf_0_auto9365511851764041826", "st_return_path" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_rh_create_script";
    s.groupid = "second_tree_return";
    fe [[ f ]]( s, us, cf, ( 125.5, -21883.1, 737.69 ), ( 343, 91.91, 1.58 ), "cspf_0_auto9365511851764041826", "cspf_0_auto4156781995411951652" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_rh_create_script";
    s.groupid = "second_tree_return";
    fe [[ f ]]( s, us, cf, ( 190.6, -20918.6, 1239.92 ), ( 343, 91.91, 1.58 ), "cspf_0_auto4156781995411951652", "cspf_0_auto16922836070351047767" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_rh_create_script";
    s.groupid = "second_tree_return";
    fe [[ f ]]( s, us, cf, ( -37.26, -19502.7, 1364.95 ), ( 357.39, 92.3, 1.51 ), "cspf_0_auto16922836070351047767", "cspf_0_auto7867341798151048511" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_rh_create_script";
    s.groupid = "second_tree_return";
    fe [[ f ]]( s, us, cf, ( 83.9, -19014.8, 1449.34 ), ( 357.39, 92.3, 1.51 ), "cspf_0_auto7867341798151048511", "cspf_0_auto877393637781704378" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_rh_create_script";
    s.groupid = "second_tree_return";
    fe [[ f ]]( s, us, cf, ( -298.36, -18444.9, 1104.03 ), ( 5.61, 142, -1.54 ), "cspf_0_auto877393637781704378", "cspf_0_auto2178625064956544258" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_rh_create_script";
    s.groupid = "third_tree_return";
    fe [[ f ]]( s, us, cf, ( -2573.85, -21597.4, 451.25 ), ( 347.21, 34.73, 10.09 ), undefined, "cspf_0_auto10042236869237056656", "tt_return_path" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_rh_create_script";
    s.groupid = "third_tree_return";
    fe [[ f ]]( s, us, cf, ( -1979.16, -20787.8, 916.55 ), ( 346.55, 38.78, -6.73 ), "cspf_0_auto10042236869237056656", "cspf_0_auto6495901594283157283" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_rh_create_script";
    s.groupid = "third_tree_return";
    fe [[ f ]]( s, us, cf, ( -1147.34, -19971.4, 1279.37 ), ( 346.55, 38.78, -6.73 ), "cspf_0_auto6495901594283157283", "cspf_0_auto13237934897925854720" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_rh_create_script";
    s.groupid = "third_tree_return";
    fe [[ f ]]( s, us, cf, ( -669.97, -19306.2, 1441.24 ), ( 348.9, 54.88, -10.17 ), "cspf_0_auto13237934897925854720", "cspf_0_auto685598679916260986" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_rh_create_script";
    s.groupid = "third_tree_return";
    fe [[ f ]]( s, us, cf, ( -290.36, -18510.9, 1305.03 ), ( 5.61, 142, -1.54 ), "cspf_0_auto685598679916260986", "cspf_0_auto11290793218595786649" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_rh_create_script";
    s.groupid = "Inital_failed_flight";
    fe [[ f ]]( s, us, cf, ( -221, -18099, 1140 ), ( 352.29, 329.04, 15.41 ), "cspf_0_auto9541510742987588699", "cspf_0_auto324671966364920076" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_rh_create_script";
    s.groupid = "Inital_failed_flight";
    fe [[ f ]]( s, us, cf, ( -427, -18093, 1153 ), ( 343.56, 15.55, 5.11 ), "pg_inactive_point", "cspf_0_auto9541510742987588699", "pg_ft_failure" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_rh_create_script";
    s.groupid = "Inital_failed_flight";
    fe [[ f ]]( s, us, cf, ( -94.5, -18331.5, 1121 ), ( 14.18, 248.31, 9.82 ), "cspf_0_auto324671966364920076", "cspf_0_auto1870264486834292603" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_rh_create_script";
    s.groupid = "Inital_failed_flight";
    fe [[ f ]]( s, us, cf, ( -348, -18450, 1100.5 ), ( 11.36, 163.59, -12.98 ), "cspf_0_auto1870264486834292603", "cspf_0_auto4771925881190449014" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_rh_create_script";
    s.groupid = "Inital_failed_flight";
    fe [[ f ]]( s, us, cf, ( -524, -18234, 1111 ), ( 354.26, 104.1, -3.33 ), "cspf_0_auto4771925881190449014", "cspf_0_auto18238421140011841952" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_rh_create_script";
    s.groupid = "Inital_failed_flight";
    fe [[ f ]]( s, us, cf, ( -427, -18093, 1153 ), ( 343.47, 16.69, 4.78 ), "cspf_0_auto18238421140011841952" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_rh_create_script";
    s.groupid = "first_tree_return";
    fe [[ f ]]( s, us, cf, ( -469, -18319, 1129 ), ( 4.68, 120.73, -3.46 ), "cspf_0_auto3678735281195104604", "cspf_0_auto9071307232499267374" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_rh_create_script";
    s.groupid = "first_tree_return";
    fe [[ f ]]( s, us, cf, ( -520, -18178, 1163 ), ( 357.3, 39.79, -5.16 ), "cspf_0_auto9071307232499267374", "cspf_0_auto15350215599724878521" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_rh_create_script";
    s.groupid = "first_tree_return";
    fe [[ f ]]( s, us, cf, ( -416.42, -18102.4, 1113.42 ), ( 351.93, 4.82, -5.08 ), "cspf_0_auto15350215599724878521" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_rh_create_script";
    s.groupid = "second_tree_return";
    fe [[ f ]]( s, us, cf, ( -563, -18258, 1084 ), ( 2.59, 93.66, -5.21 ), "cspf_0_auto2178625064956544258", "cspf_0_auto2753111303846585246" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_rh_create_script";
    s.groupid = "second_tree_return";
    fe [[ f ]]( s, us, cf, ( -427, -18096, 1154 ), ( 354.82, 4.39, -2.64 ), "cspf_0_auto2753111303846585246" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_rh_create_script";
    s.groupid = "third_tree_return";
    fe [[ f ]]( s, us, cf, ( -441, -18406, 1091 ), ( 5.1, 128.35, -2.81 ), "cspf_0_auto11290793218595786649", "cspf_0_auto8073999637982130568" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_rh_create_script";
    s.groupid = "third_tree_return";
    fe [[ f ]]( s, us, cf, ( -547, -18286, 1087 ), ( 3.25, 101.14, -4.83 ), "cspf_0_auto8073999637982130568", "cspf_0_auto5463667778396018955" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_rh_create_script";
    s.groupid = "third_tree_return";
    fe [[ f ]]( s, us, cf, ( -427, -18093, 1153 ), ( 356.45, 29.82, -4.61 ), "cspf_0_auto5463667778396018955" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_rh_create_script";
    s.groupid = "Inital_flight_failed";
    fe [[ f ]]( s, us, cf, ( -269, -18432, 1288 ), ( 16.01, 141.71, -1.59 ), "cspf_0_auto2645385719960581624", "cspf_0_auto6758353452058298130" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_rh_create_script";
    s.groupid = "Inital_flight_failed";
    fe [[ f ]]( s, us, cf, ( -543, -18237, 1107 ), ( 8.01, 86.65, -14 ), "cspf_0_auto6758353452058298130", "cspf_0_auto4586595011093641441" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_rh_create_script";
    s.groupid = "Inital_flight_failed";
    fe [[ f ]]( s, us, cf, ( -427, -18096, 1154 ), ( 347.91, 9.47, -2.49 ), "cspf_0_auto4586595011093641441" );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace zm_sat_hornet_rh_create_script
// Params 0, eflags: 0x4
// Checksum 0xd4dab163, Offset: 0x2af6
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace zm_sat_hornet_rh_create_script
// Params 0
// Checksum 0xb95e4b8f, Offset: 0x2b00
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "zm_sat_hornet_rh_create_script" );
}

