// scripts\mp\zm\maps\zm_sat_firefly\zm_sat_firefly_script_barnacle_cs.gsc  (hash_0887a50725b18853.gscc) (size: 13278 Bytes / 0x33de / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xa4cb96a3 (2764805795)
// size ...... 13278 (0x33de)
// includes .. 3   (offset: 0x2ab2)
// strings ... 99  (offset: 0x2aca)
// dev strs .. 0   (offset: 0x33de)
// exports ... 9   (offset: 0x271a)
// cseg ...... 0x6ef + 0x202b (0x271a)
// imports ... 20  (offset: 0x2882)
// animtree1 . 0   (offset: 0x33de)
// animtree2 . 0   (offset: 0x33de)
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace zm_sat_firefly_script_barnacle_cs;

// Namespace zm_sat_firefly_script_barnacle_cs
// Params 0, eflags: 0x5
// Checksum 0xe7bf5a34, Offset: 0x70d
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"zm_sat_firefly_script_barnacle_cs", undefined, &function_b39ecd3d51489472, undefined );
}

// Namespace zm_sat_firefly_script_barnacle_cs
// Params 0, eflags: 0x4
// Checksum 0xa8655983, Offset: 0x72e
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace zm_sat_firefly_script_barnacle_cs
// Params 0, eflags: 0x4
// Checksum 0x2d5e8a6f, Offset: 0x73f
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace zm_sat_firefly_script_barnacle_cs
// Params 2
// Checksum 0x9db7dc26, Offset: 0x750
// Size: 0x80
function main( unused, unused2 )
{
    if ( utility::flag_exist( "zm_sat_firefly_script_barnacle_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "zm_sat_firefly_script_barnacle_cs" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "zm_sat_firefly_script_barnacle_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "zm_sat_firefly_script_barnacle_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace zm_sat_firefly_script_barnacle_cs
// Params 3, eflags: 0x4
// Checksum 0xaedc3ea0, Offset: 0x7d8
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "zm_sat_firefly_script_barnacle_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "zm_sat_firefly_script_barnacle_cs" );
}

// Namespace zm_sat_firefly_script_barnacle_cs
// Params 3, eflags: 0x4
// Checksum 0x3e6021d3, Offset: 0x852
// Size: 0x1ea8
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_barnacle_cs";
    s.groupid = "Overgrown";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( 19925, 2674, 316.06 ), ( 356.56, 218.03, 5.75 ), undefined, "cspf_0_auto17623944917895111223", "barnacle_overgrown_set" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_barnacle_cs";
    s.groupid = "Overgrown";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( 19208.3, 3733.75, 425.63 ), ( 6.42, 23.28, 9.31 ), "cspf_0_auto17623944917895111223", "cspf_0_auto15845016919603363306", "4" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_barnacle_cs";
    fe [[ f ]]( s, us, cf, ( 19035.5, 2577.62, 369.87 ), ( 7.34, 27.09, 3.01 ), "cspf_0_auto11123115084170120532", undefined, "22" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_barnacle_cs";
    fe [[ f ]]( s, us, cf, ( 18658.2, 3167.01, 454.9 ), ( 6.73, 39.23, 2.54 ), "cspf_0_auto11123115084170120532", undefined, "23" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_barnacle_cs";
    fe [[ f ]]( s, us, cf, ( 19871.4, 3703.79, 342.26 ), ( 3.5, 313.92, -2.39 ), "cspf_0_auto11123115084170120532", undefined, "24" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_barnacle_cs";
    fe [[ f ]]( s, us, cf, ( 19967.5, -5639.33, 252.43 ), ( 354.45, 128.81, 16.22 ), "cspf_0_auto11684448761873175867", undefined, "25" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_barnacle_cs";
    fe [[ f ]]( s, us, cf, ( 21390.5, 3800.5, 280.5 ), ( 2.41, 0.13, 5.15 ), "cspf_0_auto11123115084170120532", undefined, "26" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_barnacle_cs";
    fe [[ f ]]( s, us, cf, ( 17973.3, 3294.75, 594.4 ), ( 5.44, 298.36, -8.52 ), "cspf_0_auto11123115084170120532", undefined, "27" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_barnacle_cs";
    fe [[ f ]]( s, us, cf, ( 22219.5, -4996.5, 30.5 ), ( 0, 0, 0 ), undefined, "cspf_0_auto11684448761873175867", "barnacle_set" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_barnacle_cs";
    fe [[ f ]]( s, us, cf, ( 21128, -5228, 2 ), ( 0, 0, 1.3 ), "cspf_0_auto11684448761873175867", undefined, "28" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_barnacle_cs";
    fe [[ f ]]( s, us, cf, ( 21989.5, -5247.9, 0.57 ), ( 0.45, 181.28, -1.18 ), "cspf_0_auto11684448761873175867", undefined, "29" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_barnacle_cs";
    fe [[ f ]]( s, us, cf, ( 18218.8, -4893.7, 498.71 ), ( 0.24, 66.87, 0.41 ), "cspf_0_auto11684448761873175867", undefined, "30" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_barnacle_cs";
    fe [[ f ]]( s, us, cf, ( 23353, -3051.4, 258.85 ), ( 359.15, 341.71, 1.45 ), "cspf_0_auto11684448761873175867", undefined, "31" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_barnacle_cs";
    fe [[ f ]]( s, us, cf, ( 20353, 2855.5, 274.5 ), ( 0, 0, 0 ), undefined, "cspf_0_auto11123115084170120532", "barnacle_set" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_barnacle_cs";
    s.groupid = "Overgrown";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( 17045, 3271.25, 767.25 ), ( 16.51, 24.69, 12.32 ), "cspf_0_auto17623944917895111223", "cspf_0_auto10701547685124904176", "5" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_barnacle_cs";
    s.groupid = "Overgrown";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( 20768, 2487.5, 296.55 ), ( 10.65, 100.55, -0.59 ), "cspf_0_auto17623944917895111223", "cspf_0_auto1890157842703444399", "6" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_barnacle_cs";
    s.groupid = "Overgrown";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( 18514.8, -5791.86, 521.75 ), ( 0, 9.26, 6.49 ), "cspf_0_auto808851715221464292", "cspf_0_auto13858425833830554903", "19" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_barnacle_cs";
    s.groupid = "Overgrown";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( 22091.5, -4982.5, 32 ), ( 0, 0, 0 ), undefined, "cspf_0_auto808851715221464292", "barnacle_overgrown_set" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_barnacle_cs";
    s.groupid = "Overgrown";
    s.name = "script_struct";
    s.script_label = "turret";
    fe [[ f ]]( s, us, cf, ( 22414.5, -5787.5, 184.65 ), ( 22.87, 72.67, -35.03 ), "cspf_0_auto808851715221464292", "cspf_0_auto10080786582704565643", "20" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_barnacle_cs";
    s.groupid = "Overgrown";
    s.name = "script_struct";
    s.script_label = "turret";
    fe [[ f ]]( s, us, cf, ( 18003.5, -4048.97, 709.06 ), ( 37.26, 235.99, 12.95 ), "cspf_0_auto808851715221464292", "cspf_0_auto8075662348234940359", "21" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_barnacle_cs";
    fe [[ f ]]( s, us, cf, ( -7028, 2560.5, 79.5 ), ( 352.4, 359.52, 4.35 ), "cspf_0_auto9386854091111098133", undefined, "32" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_barnacle_cs";
    fe [[ f ]]( s, us, cf, ( -5219, 3542, -224.5 ), ( 0, 0, 0 ), undefined, "cspf_0_auto9386854091111098133", "barnacle_set" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_barnacle_cs";
    fe [[ f ]]( s, us, cf, ( -8776.91, 2901.02, 237.62 ), ( 1.14, 92.39, 15.96 ), "cspf_0_auto9386854091111098133", undefined, "33" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_barnacle_cs";
    fe [[ f ]]( s, us, cf, ( -8646, 3350, 169.5 ), ( 16.11, 359.53, -5.85 ), "cspf_0_auto9386854091111098133", undefined, "34" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_barnacle_cs";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( -4199, 3669, -179.5 ), ( 353.65, 358.91, 6.78 ), "cspf_0_auto9386854091111098133", undefined, "35" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_barnacle_cs";
    fe [[ f ]]( s, us, cf, ( -3655.5, 1899, -71 ), ( 20.53, 0.5, 14.17 ), "cspf_0_auto9386854091111098133", undefined, "36" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_barnacle_cs";
    s.groupid = "Overgrown";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( -5123.5, 4086, -168.31 ), ( 15.91, 265.93, -0.67 ), "cspf_0_auto16866639120621235772", "cspf_0_auto17160419552645938810", "7" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_barnacle_cs";
    s.groupid = "Overgrown";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( -5223.5, 3583, -230 ), ( 0, 0, 0 ), undefined, "cspf_0_auto16866639120621235772", "barnacle_overgrown_set" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_barnacle_cs";
    s.groupid = "Overgrown";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( -3215.5, 2284.5, -121.63 ), ( 3.89, 115.47, -1.76 ), "cspf_0_auto16866639120621235772", "cspf_0_auto9142016674653885222", "8" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_barnacle_cs";
    s.groupid = "Overgrown";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( -7385.46, 2217.77, 141.25 ), ( 8.49, 85.42, 2 ), "cspf_0_auto16866639120621235772", "cspf_0_auto4663759021523498542", "9" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_barnacle_cs";
    fe [[ f ]]( s, us, cf, ( -9906.5, -1955, 1309 ), ( 354.37, 0.79, -8.1 ), "cspf_0_auto10947840599804769385", undefined, "37" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_barnacle_cs";
    fe [[ f ]]( s, us, cf, ( -10858, -1977.5, 1205.5 ), ( 0, 0, 0 ), undefined, "cspf_0_auto10947840599804769385", "barnacle_set" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_barnacle_cs";
    fe [[ f ]]( s, us, cf, ( -10841, -3301, 1369 ), ( 5.82, 359.76, -6.81 ), "cspf_0_auto10947840599804769385", undefined, "38" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_barnacle_cs";
    fe [[ f ]]( s, us, cf, ( -10511.3, -912.98, 1120.27 ), ( 355.39, 240.34, 16.38 ), "cspf_0_auto10947840599804769385", undefined, "39" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_barnacle_cs";
    fe [[ f ]]( s, us, cf, ( -11200.5, -1608.5, 1213.5 ), ( 3.81, 8.1, 7.35 ), "cspf_0_auto10947840599804769385", undefined, "40" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_barnacle_cs";
    fe [[ f ]]( s, us, cf, ( -13144.1, 611.27, 675.59 ), ( 2.34, 207.22, -15.78 ), "cspf_0_auto10947840599804769385", undefined, "41" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_barnacle_cs";
    s.groupid = "Overgrown";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( -9347, -4249.5, 1501.73 ), ( 356.27, 130.83, -14.15 ), "cspf_0_auto17331515275130668388", "cspf_0_auto13650706695469885010", "10" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_barnacle_cs";
    s.groupid = "Overgrown";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( -11000, -1910, 1176.5 ), ( 0, 0, 0 ), undefined, "cspf_0_auto17331515275130668388", "barnacle_overgrown_set" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_barnacle_cs";
    s.groupid = "Overgrown";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( -11009, -186.5, 954.91 ), ( 7.13, 158.97, 2.09 ), "cspf_0_auto17331515275130668388", "cspf_0_auto10095332519286625713", "11" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_barnacle_cs";
    s.groupid = "Overgrown";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( -12059, -810, 949.29 ), ( 0.2, 139.86, 2.95 ), "cspf_0_auto17331515275130668388", "cspf_0_auto9847868548633956800", "12" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_barnacle_cs";
    fe [[ f ]]( s, us, cf, ( -2972.16, -6886.97, 994.07 ), ( 345.23, 220.02, 2.8 ), "cspf_0_auto18132737094843810604", undefined, "42" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_barnacle_cs";
    fe [[ f ]]( s, us, cf, ( -2982, -6516.5, 936 ), ( 0, 0, 0 ), undefined, "cspf_0_auto18132737094843810604", "barnacle_set" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_barnacle_cs";
    fe [[ f ]]( s, us, cf, ( -2592.52, -5224.66, 710.43 ), ( 359.4, 45.92, 5.59 ), "cspf_0_auto18132737094843810604", undefined, "43" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_barnacle_cs";
    fe [[ f ]]( s, us, cf, ( -1394.88, -5610.29, 718.03 ), ( 359.31, 45.46, -7.2 ), "cspf_0_auto18132737094843810604", undefined, "44" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_barnacle_cs";
    fe [[ f ]]( s, us, cf, ( -4668.55, -6719.39, 1156.64 ), ( 8.24, 3, -7.98 ), "cspf_0_auto18132737094843810604", undefined, "45" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_barnacle_cs";
    fe [[ f ]]( s, us, cf, ( -3158, -6132, 1094.5 ), ( 350.95, 357.44, 5.68 ), "cspf_0_auto18132737094843810604", undefined, "46" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_barnacle_cs";
    s.groupid = "Overgrown";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( -4877.5, -6546, 1149.87 ), ( 10.5, 72.21, 3.31 ), "cspf_0_auto13221353093619220398", "cspf_0_auto13417939651535999871", "13" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_barnacle_cs";
    s.groupid = "Overgrown";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( -2928, -6578.5, 947 ), ( 0, 0, 0 ), undefined, "cspf_0_auto13221353093619220398", "barnacle_overgrown_set" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_barnacle_cs";
    s.groupid = "Overgrown";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( -2307, -6980.5, 995.45 ), ( 12.62, 102.11, 2.44 ), "cspf_0_auto13221353093619220398", "cspf_0_auto17457834086504219889", "14" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_barnacle_cs";
    s.groupid = "Overgrown";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( -1293, -4459, 488.88 ), ( 10.14, 17.16, -2.93 ), "cspf_0_auto13221353093619220398", "cspf_0_auto4631575556639871659", "15" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_barnacle_cs";
    fe [[ f ]]( s, us, cf, ( 8582.07, -6057.25, 425.21 ), ( 2.68, 212.14, 0.75 ), "cspf_0_auto12570162582101282235", undefined, "47" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_barnacle_cs";
    s.groupid = "Overgrown";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( 8839.5, -5899, 463 ), ( 0, 0, 0 ), undefined, "cspf_0_auto5513934483745298036", "barnacle_overgrown_set" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_barnacle_cs";
    fe [[ f ]]( s, us, cf, ( 8789, -5935.5, 462 ), ( 0, 0, 0 ), undefined, "cspf_0_auto12570162582101282235", "barnacle_set" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_barnacle_cs";
    s.groupid = "Overgrown";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( 12121.6, -5797.46, 510.08 ), ( 357.82, 255.34, -0.41 ), "cspf_0_auto5513934483745298036", "cspf_0_auto1820764915097617688", "16" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_barnacle_cs";
    fe [[ f ]]( s, us, cf, ( 9550, -4969.5, 670.5 ), ( 10.99, 1.82, 3.64 ), "cspf_0_auto12570162582101282235", undefined, "48" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_barnacle_cs";
    fe [[ f ]]( s, us, cf, ( 8157.16, -5355.57, 373.06 ), ( 348.53, 250.24, 8.36 ), "cspf_0_auto12570162582101282235", undefined, "49" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_barnacle_cs";
    fe [[ f ]]( s, us, cf, ( 7328.77, -4654.42, 255.97 ), ( 356.59, 343.83, 2.04 ), "cspf_0_auto12570162582101282235", undefined, "50" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_barnacle_cs";
    fe [[ f ]]( s, us, cf, ( 7602.5, -3962, 360.5 ), ( 339.09, 358.48, -20.36 ), "cspf_0_auto12570162582101282235", undefined, "51" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_barnacle_cs";
    s.groupid = "Overgrown";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( 6543, -5105, 327.13 ), ( 8.54, 352.71, 1.87 ), "cspf_0_auto5513934483745298036", "cspf_0_auto13320117056378242957", "17" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_barnacle_cs";
    s.groupid = "Overgrown";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( 8125.5, -2388.5, 521 ), ( 1.31, 327.49, -0 ), "cspf_0_auto5513934483745298036", "cspf_0_auto15231945685909511612", "18" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_barnacle_cs";
    fe [[ f ]]( s, us, cf, ( 7418.37, 1535.44, 530.78 ), ( 13.68, 299.47, 11.44 ), "cspf_0_auto2532723093118109886", undefined, "52" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_barnacle_cs";
    s.groupid = "Overgrown";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( 7195, 803.5, 333 ), ( 0, 0, 0 ), undefined, "cspf_0_auto11073874758963869791", "barnacle_overgrown_set" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_barnacle_cs";
    fe [[ f ]]( s, us, cf, ( 7241.5, 701, 320 ), ( 0, 0, 0 ), undefined, "cspf_0_auto2532723093118109886", "barnacle_set" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_barnacle_cs";
    s.groupid = "Overgrown";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( 7121.5, 2086.25, 733.45 ), ( 353.64, 27.09, 8.35 ), "cspf_0_auto11073874758963869791", "cspf_0_auto12226718046793208942", "1" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_barnacle_cs";
    fe [[ f ]]( s, us, cf, ( 6081.61, -179.8, 189 ), ( 358.84, 325.46, 15.6 ), "cspf_0_auto2532723093118109886", undefined, "53" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_barnacle_cs";
    fe [[ f ]]( s, us, cf, ( 7941, 1640.5, 781.5 ), ( 13.44, 3.62, -14.04 ), "cspf_0_auto2532723093118109886", undefined, "54" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_barnacle_cs";
    fe [[ f ]]( s, us, cf, ( 9217.5, 3745, 746 ), ( 358.22, 0, 0 ), "cspf_0_auto2532723093118109886", undefined, "55" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_barnacle_cs";
    fe [[ f ]]( s, us, cf, ( 7891.86, 1075.96, 476.69 ), ( 348.11, 53.11, -4.28 ), "cspf_0_auto2532723093118109886", undefined, "56" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_barnacle_cs";
    s.groupid = "Overgrown";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( 6659, 1143, 361.72 ), ( 356.49, 45.35, 17.58 ), "cspf_0_auto11073874758963869791", "cspf_0_auto2818266950921938313", "2" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_barnacle_cs";
    s.groupid = "Overgrown";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( 10588.7, 2180.75, 802.71 ), ( 358.61, 102.22, -9.05 ), "cspf_0_auto11073874758963869791", "cspf_0_auto10423663536517539840", "3" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_barnacle_cs";
    s.groupid = "Overgrown";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( 6676.55, 911.62, 302.51 ), ( 1.83, 201.43, -7.8 ), "cspf_0_auto2818266950921938313" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_barnacle_cs";
    s.groupid = "Overgrown";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( 7231.31, 2025.96, 731.24 ), ( 5.06, 194.24, -8.54 ), "cspf_0_auto12226718046793208942" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_barnacle_cs";
    s.groupid = "Overgrown";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( 10548.4, 2303.88, 807.42 ), ( 353.91, 31.39, -1.07 ), "cspf_0_auto10423663536517539840" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_barnacle_cs";
    s.groupid = "Overgrown";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( 19307.4, 3675.17, 401.11 ), ( 355.77, 66.95, 12.02 ), "cspf_0_auto15845016919603363306" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_barnacle_cs";
    s.groupid = "Overgrown";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( 17063.3, 3178.87, 758.71 ), ( 345.18, 196.39, -4.66 ), "cspf_0_auto10701547685124904176" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_barnacle_cs";
    s.groupid = "Overgrown";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( 20667, 2575.72, 287.64 ), ( 355.42, 207.03, 2.68 ), "cspf_0_auto1890157842703444399" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_barnacle_cs";
    s.groupid = "Overgrown";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( -5172.6, 3962.32, -188.58 ), ( 350.03, 108.75, -0.68 ), "cspf_0_auto17160419552645938810" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_barnacle_cs";
    s.groupid = "Overgrown";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( -3319.45, 2274.23, -137.25 ), ( 6.18, 120.17, -13.18 ), "cspf_0_auto9142016674653885222" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_barnacle_cs";
    s.groupid = "Overgrown";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( -7326.85, 2378.35, 97.41 ), ( 346.33, 280.4, -7.05 ), "cspf_0_auto4663759021523498542" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_barnacle_cs";
    s.groupid = "Overgrown";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( -9403.3, -4371.36, 1450.54 ), ( 2.43, 132.44, 2.87 ), "cspf_0_auto13650706695469885010" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_barnacle_cs";
    s.groupid = "Overgrown";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( -11087, -250.57, 950.43 ), ( 2.71, 201.09, 0.38 ), "cspf_0_auto10095332519286625713" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_barnacle_cs";
    s.groupid = "Overgrown";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( -11910.9, -795.3, 952.89 ), ( 13.3, 260.39, -13.19 ), "cspf_0_auto9847868548633956800" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_barnacle_cs";
    s.groupid = "Overgrown";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( -4737.37, -6617.09, 1145.42 ), ( 356.92, 309.55, -10.88 ), "cspf_0_auto13417939651535999871" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_barnacle_cs";
    s.groupid = "Overgrown";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( -2322.04, -6818.41, 959.75 ), ( 357.72, 173.42, 12.87 ), "cspf_0_auto17457834086504219889" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_barnacle_cs";
    s.groupid = "Overgrown";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( -1220.56, -4641.34, 473.63 ), ( 4.17, 59.11, 9.04 ), "cspf_0_auto4631575556639871659" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_barnacle_cs";
    s.groupid = "Overgrown";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( 12150.7, -6035.61, 512.49 ), ( 2.91, 343.46, -0.87 ), "cspf_0_auto1820764915097617688" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_barnacle_cs";
    s.groupid = "Overgrown";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( 6710.06, -5099.62, 297.01 ), ( 349.12, 226.9, 7.3 ), "cspf_0_auto13320117056378242957" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_barnacle_cs";
    s.groupid = "Overgrown";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( 8085.44, -2534.35, 513.85 ), ( 355.91, 228.98, 1.09 ), "cspf_0_auto15231945685909511612" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_barnacle_cs";
    s.groupid = "Overgrown";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( 18678.2, -5554.62, 517.97 ), ( 22.93, 160.42, 10.2 ), "cspf_0_auto13858425833830554903" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_barnacle_cs";
    s.groupid = "Overgrown";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( 22157.5, -5452.93, 0.27 ), ( 0.17, 153.18, -0 ), "cspf_0_auto10080786582704565643" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_barnacle_cs";
    s.groupid = "Overgrown";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( 17665.8, -4222.23, 511.59 ), ( 0.27, 256.42, 0.33 ), "cspf_0_auto8075662348234940359" );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace zm_sat_firefly_script_barnacle_cs
// Params 0, eflags: 0x4
// Checksum 0xcd2dfa3c, Offset: 0x2702
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace zm_sat_firefly_script_barnacle_cs
// Params 0
// Checksum 0x6c8fe3ed, Offset: 0x270c
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "zm_sat_firefly_script_barnacle_cs" );
}

