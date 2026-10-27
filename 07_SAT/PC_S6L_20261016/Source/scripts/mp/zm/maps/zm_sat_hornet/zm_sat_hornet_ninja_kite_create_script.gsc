// scripts\mp\zm\maps\zm_sat_hornet\zm_sat_hornet_ninja_kite_create_script.gsc  (hash_7e89d2d3cfcdaba7.gscc) (size: 16509 Bytes / 0x407d / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x6c89b614 (1820964372)
// size ...... 16509 (0x407d)
// includes .. 2   (offset: 0x34e1)
// strings ... 97  (offset: 0x34f1)
// dev strs .. 0   (offset: 0x407d)
// exports ... 6   (offset: 0x3231)
// cseg ...... 0x845 + 0x29ec (0x3231)
// imports ... 16  (offset: 0x3321)
// animtree1 . 0   (offset: 0x407d)
// animtree2 . 0   (offset: 0x407d)
#using scripts\common\create_script_utility;
#using scripts\common\utility;

#namespace zm_sat_hornet_ninja_kite_create_script;

// Namespace zm_sat_hornet_ninja_kite_create_script
// Params 2
// Checksum 0xeeef087, Offset: 0x863
// Size: 0x80
function main( unused, unused2 )
{
    if ( utility::flag_exist( "zm_sat_hornet_ninja_kite_create_script" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "zm_sat_hornet_ninja_kite_create_script" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "zm_sat_hornet_ninja_kite_create_script" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "zm_sat_hornet_ninja_kite_create_script" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace zm_sat_hornet_ninja_kite_create_script
// Params 3, eflags: 0x4
// Checksum 0x3d851201, Offset: 0x8eb
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "zm_sat_hornet_ninja_kite_create_script" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "zm_sat_hornet_ninja_kite_create_script" );
}

// Namespace zm_sat_hornet_ninja_kite_create_script
// Params 3, eflags: 0x4
// Checksum 0x20f6d12b, Offset: 0x965
// Size: 0x28ac
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ninja_kite_create_script";
    s.groupid = "common_path";
    s.script_label = "0";
    fe [[ f ]]( s, us, cf, ( -446, 7226.75, 1369 ), ( 0, 263, 0 ), "ft_high_path_common_0", "cspf_0_auto12530179871573940948", "ft_high_path_common" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ninja_kite_create_script";
    s.groupid = "path_b";
    s.script_label = "1";
    fe [[ f ]]( s, us, cf, ( 104, 4012, 1284 ), ( 0, 280, 0 ), "cspf_0_auto15504227111744859859", "cspf_0_auto15632106248422124142", "ft_high_path_b" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ninja_kite_create_script";
    fe [[ f ]]( s, us, cf, ( -396.75, 7267.25, 1367.9 ), ( 0, 280, 0 ), "ft_interact_high" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ninja_kite_create_script";
    s.groupid = "path_a";
    s.name = "script_struct";
    s.script_label = "9";
    fe [[ f ]]( s, us, cf, ( -1374, 1954, 400 ), ( 0, 280, 0 ), "cspf_0_auto9887864850456641234", undefined, "ft_high_path_a" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ninja_kite_create_script";
    s.groupid = "path_b";
    s.name = "script_struct";
    s.script_label = "5";
    fe [[ f ]]( s, us, cf, ( 600, 652, 464 ), ( 0, 280, 0 ), "cspf_0_auto2677910933768701183", "cspf_0_auto17888503315716405668", "ft_high_path_b" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ninja_kite_create_script";
    s.groupid = "path_c";
    s.script_label = "5";
    fe [[ f ]]( s, us, cf, ( 2912, 1922, 412 ), ( 0, 280, 0 ), "cspf_0_auto15580546353442453574", "cspf_0_auto6085386212801878565", "ft_high_path_c" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ninja_kite_create_script";
    s.groupid = "common_path";
    s.script_label = "4";
    fe [[ f ]]( s, us, cf, ( -494, 6344, 1600 ), ( 0, 280, 0 ), "cspf_0_auto1227352226878939909", "cspf_0_auto9509266703879613030", "ft_high_path_common" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ninja_kite_create_script";
    s.groupid = "common_path";
    s.script_label = "2";
    fe [[ f ]]( s, us, cf, ( -576, 6911.5, 1531.5 ), ( 0, 351.22, 0 ), "cspf_0_auto8772425063804734938", "cspf_0_auto13235506731456179637", "ft_high_path_common" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ninja_kite_create_script";
    s.groupid = "path_c";
    s.name = "script_struct";
    s.script_label = "1";
    fe [[ f ]]( s, us, cf, ( 352, 4184, 1384 ), ( 0, 280, 0 ), "cspf_0_auto12250791371041967360", "cspf_0_auto1081915116058906886", "ft_high_path_c" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ninja_kite_create_script";
    s.groupid = "path_a";
    s.script_label = "8";
    fe [[ f ]]( s, us, cf, ( -1231, 2102, 500 ), ( 0, 0, 0 ), "cspf_0_auto17023205864925404875", "cspf_0_auto9887864850456641234", "ft_high_path_a" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ninja_kite_create_script";
    s.groupid = "path_c";
    s.name = "script_struct";
    s.script_label = "2";
    fe [[ f ]]( s, us, cf, ( 764, 3944, 1196 ), ( 0, 280, 0 ), "cspf_0_auto1081915116058906886", "cspf_0_auto3036615674255891283", "ft_high_path_c" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ninja_kite_create_script";
    s.groupid = "path_c";
    s.script_label = "3";
    fe [[ f ]]( s, us, cf, ( 1348, 2630, 732 ), ( 0, 280, 0 ), "cspf_0_auto3036615674255891283", "cspf_0_auto1181812244254890663", "ft_high_path_c" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ninja_kite_create_script";
    s.groupid = "path_c";
    s.script_label = "4";
    fe [[ f ]]( s, us, cf, ( 2362, 2164, 570 ), ( 0, 280, 0 ), "cspf_0_auto1181812244254890663", "cspf_0_auto15580546353442453574", "ft_high_path_c" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ninja_kite_create_script";
    s.groupid = "path_c";
    s.script_label = "0";
    fe [[ f ]]( s, us, cf, ( 40, 4708, 1344 ), ( 0, 280, 0 ), undefined, "cspf_0_auto12250791371041967360", "ft_high_path_c" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ninja_kite_create_script";
    s.groupid = "path_b";
    s.script_label = "0";
    fe [[ f ]]( s, us, cf, ( 40, 4676, 1344 ), ( 0, 280, 0 ), undefined, "cspf_0_auto15504227111744859859", "ft_high_path_b" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ninja_kite_create_script";
    s.groupid = "path_b";
    s.script_label = "2";
    fe [[ f ]]( s, us, cf, ( 208, 3260, 1152 ), ( 0, 280, 0 ), "cspf_0_auto15632106248422124142", "cspf_0_auto482689119724646416", "ft_high_path_b" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ninja_kite_create_script";
    s.groupid = "path_b";
    s.script_label = "3";
    fe [[ f ]]( s, us, cf, ( 260, 2220, 780 ), ( 0, 280, 0 ), "cspf_0_auto482689119724646416", "cspf_0_auto15510462685911450735", "ft_high_path_b" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ninja_kite_create_script";
    s.groupid = "path_d";
    s.name = "script_struct";
    s.script_label = "0";
    fe [[ f ]]( s, us, cf, ( 374, 3003, 1288.88 ), ( 0, 0, 0 ), undefined, "cspf_0_auto7154891933823665814", "ft_low_path_d" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ninja_kite_create_script";
    s.groupid = "path_a";
    s.script_label = "1";
    fe [[ f ]]( s, us, cf, ( -434.5, 4210.25, 1065.08 ), ( 347.4, 0, 0 ), "cspf_0_auto746103100286342390", "cspf_0_auto17862483847974230406", "ft_high_path_a" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ninja_kite_create_script";
    s.groupid = "path_a";
    s.script_label = "0";
    fe [[ f ]]( s, us, cf, ( 40, 4632, 1344 ), ( 0, 0, 0 ), undefined, "cspf_0_auto746103100286342390", "ft_high_path_a" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ninja_kite_create_script";
    s.groupid = "path_a";
    s.script_label = "5";
    fe [[ f ]]( s, us, cf, ( -1323.42, 3245.26, 790.1 ), ( 0, 0, 0 ), "cspf_0_auto6339354235274326294", "cspf_0_auto8895535932898722332", "ft_high_path_a" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ninja_kite_create_script";
    s.groupid = "path_a";
    s.name = "script_struct";
    s.script_label = "6";
    fe [[ f ]]( s, us, cf, ( -1466.25, 2873.5, 746.7 ), ( 0, 0, 0 ), "cspf_0_auto8895535932898722332", "cspf_0_auto7849998222900607926", "ft_high_path_a" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ninja_kite_create_script";
    s.groupid = "path_a";
    s.script_label = "7";
    fe [[ f ]]( s, us, cf, ( -1206.25, 2375, 646 ), ( 346.29, 0, 0 ), "cspf_0_auto7849998222900607926", "cspf_0_auto17023205864925404875", "ft_high_path_a" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ninja_kite_create_script";
    s.groupid = "common_path";
    s.script_label = "9";
    fe [[ f ]]( s, us, cf, ( 40, 4816, 1344 ), ( 0, 280, 0 ), "ft_high_path_common_end", undefined, "ft_high_path_common" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ninja_kite_create_script";
    s.groupid = "common_path";
    s.script_label = "1";
    fe [[ f ]]( s, us, cf, ( -498.75, 7052.25, 1474.75 ), ( 0, 348.18, 0 ), "cspf_0_auto12530179871573940948", "cspf_0_auto8772425063804734938", "ft_high_path_common" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ninja_kite_create_script";
    s.groupid = "common_path";
    s.script_label = "3";
    fe [[ f ]]( s, us, cf, ( -596, 6726, 1568 ), ( 0, 280, 0 ), "cspf_0_auto13235506731456179637", "cspf_0_auto1227352226878939909", "ft_high_path_common" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ninja_kite_create_script";
    s.groupid = "common_path";
    s.script_label = "5";
    fe [[ f ]]( s, us, cf, ( -338, 6066, 1592 ), ( 0, 280, 0 ), "cspf_0_auto9509266703879613030", "cspf_0_auto14022765110039264532", "ft_high_path_common" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ninja_kite_create_script";
    s.groupid = "common_path_low";
    s.name = "script_struct";
    s.script_label = "0";
    fe [[ f ]]( s, us, cf, ( 400.5, 1604.25, 369.88 ), ( 0, 0, 0 ), undefined, "cspf_0_auto5220220781371812931", "ft_low_path_common" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ninja_kite_create_script";
    s.groupid = "common_path_low";
    s.name = "script_struct";
    s.script_label = "1";
    fe [[ f ]]( s, us, cf, ( 374, 1723, 736.88 ), ( 0, 0, 0 ), "cspf_0_auto5220220781371812931", "cspf_0_auto8721937689040632893", "ft_low_path_common" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ninja_kite_create_script";
    s.groupid = "common_path";
    s.script_label = "8";
    fe [[ f ]]( s, us, cf, ( 40, 4980, 1344 ), ( 0, 280, 0 ), "cspf_0_auto1836074059453388146", "ft_high_path_common_end", "ft_high_path_common" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ninja_kite_create_script";
    s.groupid = "common_path_low";
    s.name = "script_struct";
    s.script_label = "2";
    fe [[ f ]]( s, us, cf, ( 374, 2011, 944.88 ), ( 0, 0, 0 ), "cspf_0_auto8721937689040632893", "cspf_0_auto13263966836034154583", "ft_low_path_common" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ninja_kite_create_script";
    s.groupid = "common_path_low";
    s.name = "script_struct";
    s.script_label = "3";
    fe [[ f ]]( s, us, cf, ( 366, 2319, 1144.88 ), ( 0, 0, 0 ), "cspf_0_auto13263966836034154583", "cspf_0_auto13026517146667996748", "ft_low_path_common" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ninja_kite_create_script";
    s.groupid = "common_path_low";
    s.name = "script_struct";
    s.script_label = "5";
    fe [[ f ]]( s, us, cf, ( 374, 2789, 1288.88 ), ( 0, 0, 0 ), "ft_low_path_common_end", undefined, "ft_low_path_common" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ninja_kite_create_script";
    fe [[ f ]]( s, us, cf, ( 380, 1507, 381.02 ), ( 0, 80, 0 ), "ft_interact_low" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ninja_kite_create_script";
    s.groupid = "common_path_low";
    s.name = "script_struct";
    s.script_label = "4";
    fe [[ f ]]( s, us, cf, ( 374, 2641, 1288.88 ), ( 0, 0, 0 ), "cspf_0_auto13026517146667996748", "ft_low_path_common_end", "ft_low_path_common" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ninja_kite_create_script";
    s.groupid = "path_d";
    s.name = "script_struct";
    s.script_label = "1";
    fe [[ f ]]( s, us, cf, ( 462, 3443, 1424.88 ), ( 0, 0, 0 ), "cspf_0_auto7154891933823665814", "cspf_0_auto12683682819814239205", "ft_low_path_d" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ninja_kite_create_script";
    s.groupid = "path_d";
    s.name = "script_struct";
    s.script_label = "2";
    fe [[ f ]]( s, us, cf, ( 198, 4411, 1480.88 ), ( 0, 0, 0 ), "cspf_0_auto12683682819814239205", "cspf_0_auto4928651568957885862", "ft_low_path_d" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ninja_kite_create_script";
    s.groupid = "path_d";
    s.name = "script_struct";
    s.script_label = "3";
    fe [[ f ]]( s, us, cf, ( -242, 5419, 1464.88 ), ( 0, 0, 0 ), "cspf_0_auto4928651568957885862", "cspf_0_auto13160465719886265683", "ft_low_path_d" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ninja_kite_create_script";
    s.groupid = "path_d";
    s.name = "script_struct";
    s.script_label = "4";
    fe [[ f ]]( s, us, cf, ( -466, 5859, 1450.88 ), ( 0, 0, 0 ), "cspf_0_auto13160465719886265683", "cspf_0_auto8828590335246108183", "ft_low_path_d" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ninja_kite_create_script";
    s.groupid = "path_d";
    s.name = "script_struct";
    s.script_label = "5";
    fe [[ f ]]( s, us, cf, ( -482, 6443, 1358.88 ), ( 0, 0, 0 ), "cspf_0_auto8828590335246108183", "cspf_0_auto15980858588696732831", "ft_low_path_d" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ninja_kite_create_script";
    s.groupid = "path_d";
    s.name = "script_struct";
    s.script_label = "6";
    fe [[ f ]]( s, us, cf, ( -450, 7023.5, 1209.5 ), ( 0, 0, 0 ), "cspf_0_auto15980858588696732831", undefined, "ft_low_path_d" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ninja_kite_create_script";
    s.groupid = "path_b";
    s.name = "script_struct";
    s.script_label = "6";
    fe [[ f ]]( s, us, cf, ( 291.58, 234.74, 282.25 ), ( 0, 280, 0 ), "cspf_0_auto17888503315716405668", undefined, "ft_high_path_b" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ninja_kite_create_script";
    s.groupid = "path_c";
    s.script_label = "6";
    fe [[ f ]]( s, us, cf, ( 3053.17, 1698.71, 317.64 ), ( 0, 280, 0 ), "cspf_0_auto6085386212801878565", undefined, "ft_high_path_c" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ninja_kite_create_script";
    s.groupid = "path_b";
    s.name = "script_struct";
    s.script_label = "4";
    fe [[ f ]]( s, us, cf, ( 608, 1392, 656 ), ( 0, 280, 0 ), "cspf_0_auto15510462685911450735", "cspf_0_auto2677910933768701183", "ft_high_path_b" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ninja_kite_create_script";
    s.groupid = "common_path";
    s.script_label = "6";
    fe [[ f ]]( s, us, cf, ( -98.48, 5842.97, 1485.56 ), ( 0, 280, 0 ), "cspf_0_auto14022765110039264532", "cspf_0_auto4970639473059190505", "ft_high_path_common" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ninja_kite_create_script";
    s.groupid = "common_path";
    s.script_label = "7";
    fe [[ f ]]( s, us, cf, ( 70.93, 5493.53, 1418.31 ), ( 0, 280, 0 ), "cspf_0_auto4970639473059190505", "cspf_0_auto1836074059453388146", "ft_high_path_common" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ninja_kite_create_script";
    s.groupid = "path_a";
    s.script_label = "2";
    fe [[ f ]]( s, us, cf, ( -602.19, 3965.51, 997.38 ), ( 0, 0, 0 ), "cspf_0_auto17862483847974230406", "cspf_0_auto11636898983360641236", "ft_high_path_a" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ninja_kite_create_script";
    s.groupid = "path_a";
    s.script_label = "3";
    fe [[ f ]]( s, us, cf, ( -700.04, 3536.04, 1025.29 ), ( 0, 311.92, 0 ), "cspf_0_auto11636898983360641236", "cspf_0_auto1117582536258903831", "ft_high_path_a" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ninja_kite_create_script";
    s.groupid = "path_a";
    s.script_label = "4";
    fe [[ f ]]( s, us, cf, ( -964.54, 3376.59, 990.73 ), ( 0, 0, 0 ), "cspf_0_auto1117582536258903831", "cspf_0_auto6339354235274326294", "ft_high_path_a" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ninja_kite_create_script";
    s.groupid = "vials";
    fe [[ f ]]( s, us, cf, ( 1796.75, 2404.5, 658.38 ), ( 0, 0, 0 ), "nk_v_loc", undefined, "left" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ninja_kite_create_script";
    s.groupid = "vials";
    fe [[ f ]]( s, us, cf, ( 1016.25, 3421.5, 1011.49 ), ( 0, 0, 0 ), "nk_v_loc", undefined, "left" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ninja_kite_create_script";
    s.groupid = "vials";
    fe [[ f ]]( s, us, cf, ( -676.5, 3658.5, 1013.97 ), ( 0, 0, 0 ), "nk_v_loc", undefined, "right" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ninja_kite_create_script";
    s.groupid = "vials";
    fe [[ f ]]( s, us, cf, ( -1298.25, 2540.25, 694.69 ), ( 0, 0, 0 ), "nk_v_loc", undefined, "right" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ninja_kite_create_script";
    s.groupid = "path_b_fx";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( -60.99, 5805.67, 1353.96 ), ( 358.83, 291.12, 0.4 ), "s_path_fx_2", undefined, "5" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ninja_kite_create_script";
    s.groupid = "path_b_fx";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( -19.99, 5696.17, 1331.71 ), ( 358.92, 280.5, 0.61 ), "s_path_fx_2", undefined, "6" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ninja_kite_create_script";
    s.groupid = "path_b_fx";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( 30.26, 5650.67, 1318.71 ), ( 358.92, 280.5, 0.61 ), "s_path_fx_2", undefined, "7" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ninja_kite_create_script";
    s.groupid = "path_b_fx";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( 63.26, 5521.67, 1303.21 ), ( 359.09, 266.96, 0.84 ), "s_path_fx_2", undefined, "8" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ninja_kite_create_script";
    s.groupid = "path_b_fx";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( 48.26, 5422.67, 1304.71 ), ( 359.29, 254.92, 1.01 ), "s_path_fx_2", undefined, "9" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ninja_kite_create_script";
    s.groupid = "path_b_fx";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( 30.76, 5307.17, 1256.21 ), ( 359.08, 268.13, 0.82 ), "s_path_fx_2", undefined, "10" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ninja_kite_create_script";
    s.groupid = "path_a_fx";
    fe [[ f ]]( s, us, cf, ( 26.26, 4819.17, 1241.46 ), ( 358.98, 275.62, 0.69 ), "s_path_fx_1", undefined, "1" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ninja_kite_create_script";
    s.groupid = "path_a_fx";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( 30.51, 4786.92, 1241.96 ), ( 358.98, 275.62, 0.69 ), "s_path_fx_1", undefined, "2" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ninja_kite_create_script";
    s.groupid = "path_a_fx";
    fe [[ f ]]( s, us, cf, ( 32.5, 4767.48, 1242.34 ), ( 358.81, 293.54, 0.35 ), "s_path_fx_1", undefined, "3" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ninja_kite_create_script";
    s.groupid = "path_a_fx";
    fe [[ f ]]( s, us, cf, ( 24.51, 4749.92, 1242.46 ), ( 359.62, 237.79, 1.17 ), "s_path_fx_1", undefined, "4" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ninja_kite_create_script";
    s.groupid = "path_a_fx";
    fe [[ f ]]( s, us, cf, ( 12.82, 4725.12, 1242.64 ), ( 359.8, 229.27, 1.22 ), "s_path_fx_1", undefined, "5" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ninja_kite_create_script";
    s.groupid = "path_a_fx";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( -0.68, 4692.87, 1242.89 ), ( 359.93, 222.97, 1.23 ), "s_path_fx_1", undefined, "6" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ninja_kite_create_script";
    s.groupid = "path_a_fx";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( -17.18, 4660.37, 1224.89 ), ( 359.94, 222.62, 1.23 ), "s_path_fx_1", undefined, "7" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ninja_kite_create_script";
    s.groupid = "path_a_fx";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( -37.93, 4621.12, 1209.39 ), ( 359.94, 222.78, 1.23 ), "s_path_fx_1", undefined, "8" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ninja_kite_create_script";
    s.groupid = "path_a_fx";
    fe [[ f ]]( s, us, cf, ( -57.68, 4583.37, 1206.14 ), ( 0.06, 217.22, 1.23 ), "s_path_fx_1", undefined, "9" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ninja_kite_create_script";
    s.groupid = "path_a_fx";
    fe [[ f ]]( s, us, cf, ( -81.43, 4539.62, 1207.89 ), ( 0.06, 217.23, 1.23 ), "s_path_fx_1", undefined, "10" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ninja_kite_create_script";
    s.groupid = "path_a_fx";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( -104.93, 4505.62, 1204.14 ), ( 0.08, 216.06, 1.23 ), "s_path_fx_1", undefined, "11" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ninja_kite_create_script";
    s.groupid = "path_a_fx";
    fe [[ f ]]( s, us, cf, ( -133.93, 4460.37, 1194.89 ), ( 0.07, 216.44, 1.23 ), "s_path_fx_1", undefined, "12" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ninja_kite_create_script";
    s.groupid = "path_a_fx";
    fe [[ f ]]( s, us, cf, ( -164.49, 4417.81, 1177 ), ( 0.01, 219.54, 1.23 ), "s_path_fx_1", undefined, "13" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ninja_kite_create_script";
    s.groupid = "path_b_fx";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( -96.49, 5883.67, 1368.96 ), ( 358.81, 295.33, 0.31 ), "s_path_fx_2", undefined, "4" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ninja_kite_create_script";
    s.groupid = "path_b_fx";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( 39.27, 5170.29, 1246.68 ), ( 359.08, 268.13, 0.82 ), "s_path_fx_2", undefined, "11" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ninja_kite_create_script";
    s.groupid = "path_b_fx";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( 33.38, 5065.43, 1235.12 ), ( 359.08, 268.13, 0.82 ), "s_path_fx_2", undefined, "12" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ninja_kite_create_script";
    s.groupid = "path_b_fx";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( -154.99, 5951.17, 1397.46 ), ( 13.84, 288.4, 0.47 ), "s_path_fx_2", undefined, "3" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ninja_kite_create_script";
    s.groupid = "path_b_fx";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( -227.99, 6036.42, 1430.96 ), ( 21.34, 288.47, 0.49 ), "s_path_fx_2", undefined, "2" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ninja_kite_create_script";
    s.groupid = "path_b_fx";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( -232.24, 6044.92, 1421.71 ), ( 19.29, 313.49, 9.3 ), "s_path_fx_2", undefined, "1" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ninja_kite_create_script";
    s.groupid = "path_b_fx";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( 33.58, 4966.32, 1234.11 ), ( 359.08, 268.13, 0.82 ), "s_path_fx_2", undefined, "13" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ninja_kite_create_script";
    s.groupid = "path_b_fx";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( 29.08, 4832.57, 1236.36 ), ( 359.08, 268.13, 0.82 ), "s_path_fx_2", undefined, "14" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ninja_kite_create_script";
    s.groupid = "path_b_fx";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( 27.08, 4768.32, 1237.36 ), ( 358.77, 303.33, 0.14 ), "s_path_fx_2", undefined, "15" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ninja_kite_create_script";
    s.groupid = "path_b_fx";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( 59.33, 4721.82, 1232.11 ), ( 358.77, 303.33, 0.14 ), "s_path_fx_2", undefined, "16" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ninja_kite_create_script";
    s.groupid = "path_b_fx";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( 91.58, 4663.82, 1233.36 ), ( 358.77, 303.33, 0.14 ), "s_path_fx_2", undefined, "17" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ninja_kite_create_script";
    s.groupid = "path_b_fx";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( 122.58, 4609.82, 1234.61 ), ( 358.77, 303.33, 0.14 ), "s_path_fx_2", undefined, "18" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ninja_kite_create_script";
    s.groupid = "path_b_fx";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( 150.58, 4570.32, 1248.86 ), ( 358.77, 303.33, 0.14 ), "s_path_fx_2", undefined, "19" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ninja_kite_create_script";
    s.groupid = "path_b_fx";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( 177.33, 4541.07, 1249.61 ), ( 357.54, 303.32, 0.14 ), "s_path_fx_2", undefined, "20" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ninja_kite_create_script";
    s.groupid = "path_b_fx";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( 229.33, 4485.07, 1240.36 ), ( 342.48, 303.29, 0.15 ), "s_path_fx_2", undefined, "21" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ninja_kite_create_script";
    s.groupid = "path_b_fx";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( 258.08, 4441.32, 1256.86 ), ( 342.48, 303.29, 0.15 ), "s_path_fx_2", undefined, "22" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ninja_kite_create_script";
    s.groupid = "path_b_fx";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( 287.83, 4395.82, 1274.11 ), ( 342.48, 303.29, 0.15 ), "s_path_fx_2", undefined, "23" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ninja_kite_create_script";
    s.groupid = "path_b_fx";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( 322.58, 4342.82, 1294.11 ), ( 342.48, 303.29, 0.15 ), "s_path_fx_2", undefined, "24" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ninja_kite_create_script";
    s.groupid = "path_c_fx";
    fe [[ f ]]( s, us, cf, ( -262.94, 6201.05, 1459.72 ), ( 13.15, 278.43, -0.18 ), "s_path_fx_3", undefined, "3" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ninja_kite_create_script";
    s.groupid = "path_c_fx";
    fe [[ f ]]( s, us, cf, ( -258.69, 6171.8, 1452.97 ), ( 13.15, 278.43, -0.18 ), "s_path_fx_3", undefined, "4" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ninja_kite_create_script";
    s.groupid = "path_c_fx";
    fe [[ f ]]( s, us, cf, ( -253.44, 6135.8, 1444.47 ), ( 13.15, 278.43, -0.18 ), "s_path_fx_3", undefined, "5" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ninja_kite_create_script";
    s.groupid = "path_c_fx";
    fe [[ f ]]( s, us, cf, ( -248.44, 6101.8, 1436.47 ), ( 13.15, 278.43, -0.18 ), "s_path_fx_3", undefined, "6" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ninja_kite_create_script";
    s.groupid = "path_c_fx";
    fe [[ f ]]( s, us, cf, ( -242.19, 6059.05, 1426.47 ), ( 13.15, 278.43, -0.18 ), "s_path_fx_3", undefined, "7" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ninja_kite_create_script";
    s.groupid = "path_c_fx";
    fe [[ f ]]( s, us, cf, ( -267.69, 6232.8, 1467.22 ), ( 13.15, 278.43, -0.18 ), "s_path_fx_3", undefined, "2" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ninja_kite_create_script";
    s.groupid = "path_c_fx";
    fe [[ f ]]( s, us, cf, ( -273.43, 6264.23, 1473.36 ), ( 13.15, 278.43, -0.18 ), "s_path_fx_3", undefined, "1" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ninja_kite_create_script";
    s.groupid = "path_a_fx";
    fe [[ f ]]( s, us, cf, ( -220.43, 4357.87, 1137.39 ), ( 0.09, 215.74, 1.23 ), "s_path_fx_1", undefined, "14" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ninja_kite_create_script";
    s.groupid = "path_a_fx";
    fe [[ f ]]( s, us, cf, ( -284.88, 4265.12, 1108.5 ), ( 338.5, 190.34, 0.91 ), "s_path_fx_1", undefined, "15" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ninja_kite_create_script";
    s.groupid = "path_a_fx";
    fe [[ f ]]( s, us, cf, ( -356.57, 4209.23, 1083.35 ), ( 359.12, 202.78, 0.9 ), "s_path_fx_1", undefined, "16" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ninja_kite_create_script";
    s.groupid = "path_a_fx";
    fe [[ f ]]( s, us, cf, ( -412.98, 4164.46, 1060.15 ), ( 357.17, 207.87, 0.22 ), "s_path_fx_1", undefined, "17" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ninja_kite_create_script";
    fe [[ f ]]( s, us, cf, ( -475.25, 7055, 1388.9 ), ( 24.25, 261.64, -0 ), "takeoff_high" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ninja_kite_create_script";
    fe [[ f ]]( s, us, cf, ( 364.5, 1612.75, 417.52 ), ( 357.99, 80, -0 ), "takeoff_low" );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace zm_sat_hornet_ninja_kite_create_script
// Params 0, eflags: 0x4
// Checksum 0x715ce75b, Offset: 0x3219
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace zm_sat_hornet_ninja_kite_create_script
// Params 0
// Checksum 0xffd6cf4c, Offset: 0x3223
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "zm_sat_hornet_ninja_kite_create_script" );
}

