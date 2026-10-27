// scripts\mp\zm\maps\zm_sat_scarab\zm_sat_scarab_teleport_back_cs.gsc  (hash_2356a977fd6b764e.gscc) (size: 20116 Bytes / 0x4e94 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x7f049de8 (2131009000)
// size ...... 20116 (0x4e94)
// includes .. 3   (offset: 0x44bc)
// strings ... 52  (offset: 0x44d4)
// dev strs .. 0   (offset: 0x4e94)
// exports ... 9   (offset: 0x4124)
// cseg ...... 0x722 + 0x3a02 (0x4124)
// imports ... 20  (offset: 0x428c)
// animtree1 . 0   (offset: 0x4e94)
// animtree2 . 0   (offset: 0x4e94)
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace zm_sat_scarab_teleport_back_cs;

// Namespace zm_sat_scarab_teleport_back_cs
// Params 0, eflags: 0x5
// Checksum 0x99bdd495, Offset: 0x740
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"zm_sat_scarab_teleport_back_cs", undefined, &function_b39ecd3d51489472, undefined );
}

// Namespace zm_sat_scarab_teleport_back_cs
// Params 0, eflags: 0x4
// Checksum 0x417c21b8, Offset: 0x761
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace zm_sat_scarab_teleport_back_cs
// Params 0, eflags: 0x4
// Checksum 0xc447f254, Offset: 0x772
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace zm_sat_scarab_teleport_back_cs
// Params 2
// Checksum 0x74aea41d, Offset: 0x783
// Size: 0x80
function main( unused, unused2 )
{
    if ( utility::flag_exist( "zm_sat_scarab_teleport_back_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "zm_sat_scarab_teleport_back_cs" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "zm_sat_scarab_teleport_back_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "zm_sat_scarab_teleport_back_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace zm_sat_scarab_teleport_back_cs
// Params 3, eflags: 0x4
// Checksum 0x47c5469b, Offset: 0x80b
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "zm_sat_scarab_teleport_back_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "zm_sat_scarab_teleport_back_cs" );
}

// Namespace zm_sat_scarab_teleport_back_cs
// Params 3, eflags: 0x4
// Checksum 0x9223078c, Offset: 0x885
// Size: 0x387f
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( 356.68, -752.46, 2740 ), ( 0, 0, 0 ), "teleport_back_pos", "cspf_0_auto12886199143415404758" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( -1203.89, -2270.56, 1584 ), ( 0, 210, 0 ), "cspf_0_auto12886199143415404758", "cspf_0_auto12838885354152493914" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( -1407.77, -2303.17, 1368.87 ), ( 4.09, 334.54, 3.46 ), "cspf_0_auto12838885354152493914" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( -1358.55, -2161.09, 1368 ), ( 0, 334.42, 0 ), "cspf_0_auto12838885354152493914" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( -1375.68, -2209.09, 1368.21 ), ( 2.87, 334.24, -3.56 ), "cspf_0_auto12838885354152493914" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( -1387.37, -2256.68, 1370.69 ), ( 2.87, 334.24, -3.56 ), "cspf_0_auto12838885354152493914" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( -228.92, -1931.1, 1424 ), ( 0, 185.2, 0 ), "cspf_0_auto12886199143415404758", "cspf_0_auto609831181282211208" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( -137.72, -1932.13, 1322 ), ( 0, 69.62, 0 ), "cspf_0_auto609831181282211208" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( -283.9, -1890.49, 1322 ), ( 0, 69.62, 0 ), "cspf_0_auto609831181282211208" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( -237.74, -1903.64, 1322 ), ( 0, 69.62, 0 ), "cspf_0_auto609831181282211208" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( -189.38, -1909.09, 1322 ), ( 0, 69.62, 0 ), "cspf_0_auto609831181282211208" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( 803.33, -1704.15, 1430.06 ), ( 0.72, 111, -2.16 ), "cspf_0_auto12886199143415404758", "cspf_0_auto16748005962143947459" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( 847.93, -1791.99, 1327 ), ( 0, 355.42, 0 ), "cspf_0_auto16748005962143947459" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( 848.14, -1639.99, 1327 ), ( 0, 355.42, 0 ), "cspf_0_auto16748005962143947459" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( 848.08, -1687.99, 1327 ), ( 0, 355.42, 0 ), "cspf_0_auto16748005962143947459" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( 856, -1736, 1327 ), ( 0, 355.42, 0 ), "cspf_0_auto16748005962143947459" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( 912, -1088, 1424 ), ( 0, 111.09, 0 ), "cspf_0_auto12886199143415404758", "cspf_0_auto4054239038351410908" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( 992, -996, 1322 ), ( 0, 165.52, 0 ), "cspf_0_auto4054239038351410908" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( 965.61, -1145.69, 1322 ), ( 0, 165.52, 0 ), "cspf_0_auto4054239038351410908" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( 973.94, -1098.42, 1322 ), ( 0, 165.52, 0 ), "cspf_0_auto4054239038351410908" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( 974.4, -1049.76, 1322 ), ( 0, 165.52, 0 ), "cspf_0_auto4054239038351410908" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( -187, 20, 1424 ), ( 0, 21.09, 0 ), "cspf_0_auto12886199143415404758", "cspf_0_auto10877914993949421259" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( -253.46, 26.08, 1322 ), ( 0, 276.01, 0 ), "cspf_0_auto10877914993949421259" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( -104, 53.78, 1322 ), ( 0, 276.01, 0 ), "cspf_0_auto10877914993949421259" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( -151.2, 45.03, 1322 ), ( 0, 276.01, 0 ), "cspf_0_auto10877914993949421259" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( -196.94, 28.42, 1322 ), ( 0, 276.01, 0 ), "cspf_0_auto10877914993949421259" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( -931.94, -1101.38, 1424 ), ( 0, 303.89, 0 ), "cspf_0_auto12886199143415404758", "cspf_0_auto14447308076132055094" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( -953.56, -1175.57, 1322 ), ( 0, 8.31, 0 ), "cspf_0_auto14447308076132055094" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( -987.24, -1027.34, 1322 ), ( 0, 8.31, 0 ), "cspf_0_auto14447308076132055094" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( -976.6, -1074.15, 1322 ), ( 0, 8.31, 0 ), "cspf_0_auto14447308076132055094" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( -958.16, -1119.19, 1322 ), ( 0, 8.31, 0 ), "cspf_0_auto14447308076132055094" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( 1748.36, -2201.78, 1600 ), ( 0, 244, 0 ), "cspf_0_auto12886199143415404758", "cspf_0_auto14858992511952691551" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( 1662.47, -2195.41, 1273.17 ), ( 358.5, 77.51, -3.57 ), "cspf_0_auto14858992511952691551" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( 1865, -2313.73, 1282.79 ), ( 356.7, 32.4, -2.29 ), "cspf_0_auto14858992511952691551" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( 1830.38, -2264.13, 1284.21 ), ( 356.43, 24.88, -1.84 ), "cspf_0_auto14858992511952691551" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( 1709.26, -2227.21, 1275.91 ), ( 359.01, 85.58, -3.75 ), "cspf_0_auto14858992511952691551" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( -807.79, -1958.36, 1584 ), ( 0, 75, 0 ), "cspf_0_auto12886199143415404758", "cspf_0_auto14297323241918044310" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( -819.16, -1890.93, 1334.55 ), ( 354.51, 319.26, -11.94 ), "cspf_0_auto14297323241918044310" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( -734.84, -1766.44, 1313.15 ), ( 354.78, 320.53, -12.06 ), "cspf_0_auto14297323241918044310" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( -763.82, -1808.35, 1320.43 ), ( 354.78, 320.53, -12.06 ), "cspf_0_auto14297323241918044310" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( -787.43, -1851.31, 1327.6 ), ( 354.84, 320.82, -12.08 ), "cspf_0_auto14297323241918044310" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( -1722.97, -2208.06, 1616 ), ( 0, 30, 0 ), "cspf_0_auto12886199143415404758", "cspf_0_auto14521176567768485953" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( -1524.75, -2459.95, 1366.62 ), ( 358.69, 190.09, -5.19 ), "cspf_0_auto14521176567768485953" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( -1499.81, -2607.14, 1349.73 ), ( 359.25, 190.05, -8.33 ), "cspf_0_auto14521176567768485953" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( -1513.66, -2558.12, 1357.22 ), ( 359.25, 190.05, -8.33 ), "cspf_0_auto14521176567768485953" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( -1514.31, -2509.62, 1361.97 ), ( 358.69, 190.09, -5.19 ), "cspf_0_auto14521176567768485953" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( -1717.27, -1831.08, 1624 ), ( 0, 225, 0 ), "cspf_0_auto12886199143415404758", "cspf_0_auto6226562832188741264" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( -1506.14, -1893.86, 1339.18 ), ( 354.47, 300.25, -4 ), "cspf_0_auto6226562832188741264" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( -1641.41, -1960.52, 1345 ), ( 0, 286.5, 0 ), "cspf_0_auto6226562832188741264" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( -1595.36, -1938.21, 1343.46 ), ( 353.67, 286.36, -2.56 ), "cspf_0_auto6226562832188741264" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( -1553.43, -1912.31, 1342.43 ), ( 353.84, 289.84, -2.94 ), "cspf_0_auto6226562832188741264" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( -2269.2, -1547.47, 1488 ), ( 0, 135, 0 ), "cspf_0_auto12886199143415404758", "cspf_0_auto9381525082875690185" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( -2165.78, -1932.87, 1272 ), ( 0, 230.65, 0 ), "cspf_0_auto9381525082875690185" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( -2280.78, -1836, 1272 ), ( 0, 230.79, 0 ), "cspf_0_auto9381525082875690185" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( -2242.13, -1869.19, 1272 ), ( 0, 228.99, 0 ), "cspf_0_auto9381525082875690185" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( -2201.87, -1897.17, 1272 ), ( 0, 230.45, 0 ), "cspf_0_auto9381525082875690185" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( -2090.97, -2702.56, 1488 ), ( 0, 30, 0 ), "cspf_0_auto12886199143415404758", "cspf_0_auto5826795221989557204" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( -2227.78, -2889.68, 1268.29 ), ( 9.43, 175.41, -0.75 ), "cspf_0_auto5826795221989557204" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( -2222.28, -2844.61, 1268.45 ), ( 9.03, 162.47, -2.84 ), "cspf_0_auto5826795221989557204" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( -2211.23, -2794.33, 1267.21 ), ( 9.03, 162.47, -2.84 ), "cspf_0_auto5826795221989557204" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( -2231.69, -2940.78, 1267.63 ), ( 9.43, 175.41, -0.75 ), "cspf_0_auto5826795221989557204" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( -981.36, 499.47, 1767.86 ), ( 0, 324.09, 0 ), "cspf_0_auto12886199143415404758", "cspf_0_auto8080063985456293223" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( -1053.03, 579.57, 1646.19 ), ( 6.54, 221.75, -1.93 ), "cspf_0_auto8080063985456293223" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( -941.86, 475.91, 1637.19 ), ( 12.7, 213.64, -8.18 ), "cspf_0_auto8080063985456293223" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( -976.96, 508.64, 1641.57 ), ( 12.7, 213.64, -8.18 ), "cspf_0_auto8080063985456293223" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( -1014.29, 546.55, 1644.63 ), ( 7.25, 220.63, -3.55 ), "cspf_0_auto8080063985456293223" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( -1748.04, 258.6, 1976 ), ( 0, 296.09, 0 ), "cspf_0_auto12886199143415404758", "cspf_0_auto16233089721533979569" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( -1699.2, 379.79, 1604.54 ), ( 0, 33.21, 0 ), "cspf_0_auto16233089721533979569" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( -1663.69, 337.84, 1599.22 ), ( 0, 40.53, 0 ), "cspf_0_auto16233089721533979569" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( -1612.89, 265.4, 1609.48 ), ( 0, 40.53, 0 ), "cspf_0_auto16233089721533979569" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( -1737.91, 440.84, 1604 ), ( 0, 33.21, 0 ), "cspf_0_auto16233089721533979569" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( -912.57, 1610.69, 1928 ), ( 0, 156.09, 0 ), "cspf_0_auto12886199143415404758", "cspf_0_auto11315581496374153018" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( -839.19, 1653.57, 1649.33 ), ( 2.05, 211.71, -0.76 ), "cspf_0_auto11315581496374153018" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( -868.04, 1695.47, 1651.03 ), ( 358.45, 224.11, 1.92 ), "cspf_0_auto11315581496374153018" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( -898.32, 1727.43, 1648.28 ), ( 358.45, 224.11, 1.92 ), "cspf_0_auto11315581496374153018" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( -814.5, 1606.5, 1654.06 ), ( 356.72, 211.82, 0.77 ), "cspf_0_auto11315581496374153018" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( -316.29, 1905.57, 1766.42 ), ( 0, 351.09, 0 ), "cspf_0_auto12886199143415404758", "cspf_0_auto17823319149126114422" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( -412.5, 1914.93, 1638.9 ), ( 0, 235.51, 0 ), "cspf_0_auto17823319149126114422" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( -280.86, 1838.93, 1665.71 ), ( 0, 235.51, 0 ), "cspf_0_auto17823319149126114422" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( -322.43, 1862.93, 1657.24 ), ( 0, 235.51, 0 ), "cspf_0_auto17823319149126114422" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( -368, 1880, 1648.78 ), ( 0, 235.51, 0 ), "cspf_0_auto17823319149126114422" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( 1248, 3224, 2006 ), ( 0, 111.09, 0 ), "cspf_0_auto12886199143415404758", "cspf_0_auto16109642301174260382" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( 1255.23, 3150.18, 1862 ), ( 0, 230.5, 0 ), "cspf_0_auto16109642301174260382" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( 1258, 3307.5, 1862 ), ( 0, 118.9, 0 ), "cspf_0_auto16109642301174260382" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( 1298.08, 3333.91, 1862 ), ( 0, 118.9, 0 ), "cspf_0_auto16109642301174260382" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( 1296.5, 3111.5, 1862 ), ( 0, 230.5, 0 ), "cspf_0_auto16109642301174260382" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( 740.43, -297.31, 1727.43 ), ( 0, 156.09, 0 ), "cspf_0_auto12886199143415404758", "cspf_0_auto3930943953663144871" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( 784.17, -340.14, 1318 ), ( 0, 215.14, 0 ), "cspf_0_auto3930943953663144871" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( 746.74, -290.56, 1318 ), ( 0, 219.74, 0 ), "cspf_0_auto3930943953663144871" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( 713.58, -255.85, 1318 ), ( 0, 219.74, 0 ), "cspf_0_auto3930943953663144871" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( 813.96, -388.24, 1318 ), ( 0, 215.94, 0 ), "cspf_0_auto3930943953663144871" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( 2448, -1680, 1643 ), ( 0, 291.09, 0 ), "cspf_0_auto12886199143415404758", "cspf_0_auto13967400826680567791" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( 2368, -1648, 1459 ), ( 0, 175.51, 0 ), "cspf_0_auto13967400826680567791" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( 2368, -1800, 1459 ), ( 0, 175.51, 0 ), "cspf_0_auto13967400826680567791" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( 2368, -1752, 1459 ), ( 0, 175.51, 0 ), "cspf_0_auto13967400826680567791" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( 2360, -1704, 1459 ), ( 0, 175.51, 0 ), "cspf_0_auto13967400826680567791" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( -4412.23, -2104.94, 1643 ), ( 0, 120, 0 ), "cspf_0_auto12886199143415404758", "cspf_0_auto2476546641892852707" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( -4340.35, -2048.73, 1464 ), ( 0, 204.47, 0 ), "cspf_0_auto2476546641892852707" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( -4390.35, -2027.93, 1462 ), ( 0, 228.83, 0 ), "cspf_0_auto2476546641892852707" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( -4446.46, -2020.04, 1462 ), ( 0, 228.83, 0 ), "cspf_0_auto2476546641892852707" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( -4315.3, -2099.71, 1464 ), ( 0, 204.47, 0 ), "cspf_0_auto2476546641892852707" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( -6188.84, -698.42, 1799.33 ), ( 0, 195, 0 ), "cspf_0_auto12886199143415404758", "cspf_0_auto7410439318060189840" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( -6115.85, -619.85, 1625.5 ), ( 0, 259.98, 0 ), "cspf_0_auto7410439318060189840" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( -6175.98, -628.45, 1623.5 ), ( 0, 266.18, 0 ), "cspf_0_auto7410439318060189840" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( -6226.89, -630.33, 1623.5 ), ( 0, 266.18, 0 ), "cspf_0_auto7410439318060189840" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( -6065.6, -627.03, 1625.5 ), ( 0, 259.97, 0 ), "cspf_0_auto7410439318060189840" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( 1662.75, 2014.62, 1902 ), ( 0, 74.99, 0 ), "cspf_0_auto12886199143415404758", "cspf_0_auto16853159848213742203" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( 1651.37, 1920.06, 1686 ), ( 0, 319.41, 0 ), "cspf_0_auto16853159848213742203" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( 1735.69, 2044.55, 1686 ), ( 0, 319.41, 0 ), "cspf_0_auto16853159848213742203" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( 1706.72, 2002.64, 1686 ), ( 0, 319.41, 0 ), "cspf_0_auto16853159848213742203" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( 1683.1, 1959.68, 1686 ), ( 0, 319.41, 0 ), "cspf_0_auto16853159848213742203" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( -5448.09, 904.33, 2013.45 ), ( 0, 105, 0 ), "cspf_0_auto12886199143415404758", "cspf_0_auto9909946786521819683" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( -5451.14, 623.38, 1700 ), ( 0, 340.17, 0 ), "cspf_0_auto9909946786521819683" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( -5414.51, 769.2, 1700 ), ( 0, 340.17, 0 ), "cspf_0_auto9909946786521819683" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( -5427.39, 719.91, 1700 ), ( 0, 340.17, 0 ), "cspf_0_auto9909946786521819683" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( -5434.89, 671.46, 1700 ), ( 0, 340.17, 0 ), "cspf_0_auto9909946786521819683" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( -2128.68, 3763.15, 1725.45 ), ( 0, 120, 0 ), "cspf_0_auto12886199143415404758", "cspf_0_auto11511467378610742795" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( -2035.94, 3706.87, 1616 ), ( 0, 165.92, 0 ), "cspf_0_auto11511467378610742795" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( -2041.13, 3762.88, 1615 ), ( 0, 192.22, 0 ), "cspf_0_auto11511467378610742795" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( -2057.03, 3811.3, 1615 ), ( 0, 192.22, 0 ), "cspf_0_auto11511467378610742795" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( -2046.64, 3657.26, 1616 ), ( 0, 165.92, 0 ), "cspf_0_auto11511467378610742795" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( -768.68, 3707.15, 1887.62 ), ( 0, 120, 0 ), "cspf_0_auto12886199143415404758", "cspf_0_auto3132740711102026445" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( -709.85, 3632.24, 1618 ), ( 0, 4.41, 0 ), "cspf_0_auto3132740711102026445" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( -738.27, 3779.89, 1612.99 ), ( 0, 4.41, 0 ), "cspf_0_auto3132740711102026445" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( -729.11, 3729.77, 1614.6 ), ( 0, 4.41, 0 ), "cspf_0_auto3132740711102026445" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( -715.43, 3682.69, 1617.01 ), ( 0, 4.41, 0 ), "cspf_0_auto3132740711102026445" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( 473.98, 2439.79, 2078 ), ( 0, 14.99, 0 ), "cspf_0_auto12886199143415404758", "cspf_0_auto10554970672801895978" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( 386.39, 2402.36, 1862 ), ( 0, 83.26, 0 ), "cspf_0_auto10554970672801895978" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( 536.37, 2391.59, 1862 ), ( 0, 81.58, 0 ), "cspf_0_auto10554970672801895978" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( 485.59, 2395.72, 1862 ), ( 0, 73.97, 0 ), "cspf_0_auto10554970672801895978" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( 436.57, 2394.69, 1862 ), ( 0, 80.68, 0 ), "cspf_0_auto10554970672801895978" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( 2469.82, 3386.23, 1990 ), ( 0, 299.99, 0 ), "cspf_0_auto12886199143415404758", "cspf_0_auto9760794725443274276" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( 2504.87, 3328.62, 1818.5 ), ( 0, 7.51, 0 ), "cspf_0_auto9760794725443274276" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( 2515.41, 3267.99, 1819.5 ), ( 0, 6.11, 0 ), "cspf_0_auto9760794725443274276" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( 2526.06, 3218.16, 1819.5 ), ( 0, 6.11, 0 ), "cspf_0_auto9760794725443274276" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( 2496.57, 3378.69, 1818.5 ), ( 0, 7.51, 0 ), "cspf_0_auto9760794725443274276" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( 2917.44, 760.7, 1870 ), ( 0, 254.99, 0 ), "cspf_0_auto12886199143415404758", "cspf_0_auto1422733764992549725" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( 2923.16, 860.93, 1694 ), ( 0, 139.41, 0 ), "cspf_0_auto1422733764992549725" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( 2838.85, 747.74, 1694 ), ( 0, 139.41, 0 ), "cspf_0_auto1422733764992549725" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( 2867.81, 789.66, 1694 ), ( 0, 139.41, 0 ), "cspf_0_auto1422733764992549725" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( 2891.43, 821.31, 1694 ), ( 0, 139.41, 0 ), "cspf_0_auto1422733764992549725" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( 3868.11, -482.56, 1774 ), ( 0, 209.99, 0 ), "cspf_0_auto12886199143415404758", "cspf_0_auto2151222016128796783" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( 3942.52, -415.73, 1598.25 ), ( 0, 265.69, 0 ), "cspf_0_auto2151222016128796783" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( 3803.37, -436.15, 1604.5 ), ( 0, 272.94, 0 ), "cspf_0_auto2151222016128796783" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( 3853.49, -426.99, 1601.5 ), ( 0, 269.87, 0 ), "cspf_0_auto2151222016128796783" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( 3892.57, -421.31, 1600.5 ), ( 0, 267.3, 0 ), "cspf_0_auto2151222016128796783" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( -3511.16, -2781.58, 1824 ), ( 0, 15, 0 ), "cspf_0_auto12886199143415404758", "cspf_0_auto8644711582169306710" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( 3625.67, 403.27, 1769.78 ), ( 357.92, 29.26, 4.59 ), "cspf_0_auto10569285859391373141" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( 3548.15, 521.1, 1780.72 ), ( 357.92, 29.26, 4.59 ), "cspf_0_auto10569285859391373141" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( 3577.64, 479.58, 1776.85 ), ( 357.92, 29.26, 4.59 ), "cspf_0_auto10569285859391373141" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( 3599.29, 446.6, 1773.79 ), ( 357.92, 29.26, 4.59 ), "cspf_0_auto10569285859391373141" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( -3715.74, -2699.55, 1462.5 ), ( 0, 34.1, 0 ), "cspf_0_auto8644711582169306710" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( -3685.45, -2747.78, 1462 ), ( 0, 35.07, 0 ), "cspf_0_auto8644711582169306710" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( -3652.01, -2786.22, 1462 ), ( 0, 35.07, 0 ), "cspf_0_auto8644711582169306710" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( -3745.58, -2658.48, 1462.5 ), ( 0, 34.1, 0 ), "cspf_0_auto8644711582169306710" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( -6665.16, -2359.58, 1799.33 ), ( 0, 15, 0 ), "cspf_0_auto12886199143415404758", "cspf_0_auto17861337400125922715" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( -6727, -2322.5, 1527.5 ), ( 0, 1.7, 0 ), "cspf_0_auto17861337400125922715" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( -6736.81, -2427.02, 1526 ), ( 0, 358.3, 0 ), "cspf_0_auto17861337400125922715" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( -6738, -2467, 1526 ), ( 0, 358.3, 0 ), "cspf_0_auto17861337400125922715" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( -6728.66, -2270.02, 1527.5 ), ( 0, 1.7, 0 ), "cspf_0_auto17861337400125922715" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( 1263.43, 492.69, 1928 ), ( 0, 156.09, 0 ), "cspf_0_auto12886199143415404758", "cspf_0_auto7414827351079683138" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( 1216.06, 453.26, 1494 ), ( 0, 219.31, 0 ), "cspf_0_auto7414827351079683138" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( 1323.54, 345.78, 1494 ), ( 0, 219.44, 0 ), "cspf_0_auto7414827351079683138" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( 1289.6, 379.72, 1494 ), ( 0, 219.44, 0 ), "cspf_0_auto7414827351079683138" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( 1250, 408, 1494 ), ( 0, 219.75, 0 ), "cspf_0_auto7414827351079683138" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( 3629.89, 503.02, 1901.59 ), ( 0.87, 355.07, 9.96 ), "cspf_0_auto12886199143415404758", "cspf_0_auto10569285859391373141" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( 30568.8, 30793.4, 1657.5 ), ( 0, 241.2, 0 ), "cspf_0_auto12886199143415404758", "cspf_0_auto1537569355646889688" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( 30620.7, 30868.4, 1543.5 ), ( 0, 125.61, 0 ), "cspf_0_auto1537569355646889688" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( 30504.4, 30770.5, 1543.5 ), ( 0, 125.61, 0 ), "cspf_0_auto1537569355646889688" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( 30541.1, 30801.4, 1543.5 ), ( 0, 125.61, 0 ), "cspf_0_auto1537569355646889688" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( 30572.7, 30838.5, 1543.5 ), ( 0, 125.61, 0 ), "cspf_0_auto1537569355646889688" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( 30573.6, 30459.5, 1661.5 ), ( 0, 337.2, 0 ), "cspf_0_auto12886199143415404758", "cspf_0_auto440006793697729982" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( 30493.6, 30503.2, 1547.5 ), ( 0, 221.61, 0 ), "cspf_0_auto440006793697729982" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( 30603.1, 30397.8, 1547.5 ), ( 0, 221.61, 0 ), "cspf_0_auto440006793697729982" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( 30568.5, 30431.1, 1547.5 ), ( 0, 221.61, 0 ), "cspf_0_auto440006793697729982" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( 30528.4, 30458.6, 1547.5 ), ( 0, 221.61, 0 ), "cspf_0_auto440006793697729982" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( 30949.1, 30455.8, 1675.5 ), ( 0, 65.2, 0 ), "cspf_0_auto12886199143415404758", "cspf_0_auto7459367702494082779" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( 30902.6, 30377.4, 1545.5 ), ( 0, 309.61, 0 ), "cspf_0_auto7459367702494082779" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( 31011.7, 30483.1, 1545.5 ), ( 0, 309.61, 0 ), "cspf_0_auto7459367702494082779" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( 30977.3, 30449.7, 1545.5 ), ( 0, 309.61, 0 ), "cspf_0_auto7459367702494082779" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( 30948.4, 30410.6, 1545.5 ), ( 0, 309.61, 0 ), "cspf_0_auto7459367702494082779" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( 30941.3, 30814.6, 1659.5 ), ( 0, 161.2, 0 ), "cspf_0_auto12886199143415404758", "cspf_0_auto7467935169743039259" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( 31024.2, 30776.5, 1545.5 ), ( 0, 45.61, 0 ), "cspf_0_auto7467935169743039259" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( 30907.6, 30874, 1545.5 ), ( 0, 45.61, 0 ), "cspf_0_auto7467935169743039259" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( 30944.4, 30843.2, 1545.5 ), ( 0, 45.61, 0 ), "cspf_0_auto7467935169743039259" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( 30986.4, 30818.6, 1545.5 ), ( 0, 45.61, 0 ), "cspf_0_auto7467935169743039259" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( -154.35, -3449.89, 1840 ), ( 0, 220.2, 0 ), "cspf_0_auto12886199143415404758", "cspf_0_auto1130272487678752230" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( -271.04, -3442.91, 1737.5 ), ( 0, 283.15, 0 ), "cspf_0_auto1130272487678752230" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( -123.68, -3409.86, 1726.5 ), ( 0, 283.15, 0 ), "cspf_0_auto1130272487678752230" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( -171.93, -3411.4, 1724 ), ( 0, 283.15, 0 ), "cspf_0_auto1130272487678752230" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( -215.25, -3433.57, 1733 ), ( 0, 283.15, 0 ), "cspf_0_auto1130272487678752230" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( -4226.19, 1857.55, 1837.45 ), ( 0, 165, 0 ), "cspf_0_auto12886199143415404758", "cspf_0_auto4038089046873087118" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( -3984.42, 1714.43, 1524 ), ( 0, 40.17, 0 ), "cspf_0_auto4038089046873087118" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( -4092.39, 1819.06, 1524 ), ( 0, 40.16, 0 ), "cspf_0_auto4038089046873087118" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( -4056.14, 1783.27, 1524 ), ( 0, 40.16, 0 ), "cspf_0_auto4038089046873087118" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( -4017.93, 1752.55, 1524 ), ( 0, 40.16, 0 ), "cspf_0_auto4038089046873087118" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( 633.06, 357.31, 2008 ), ( 0, 276.09, 0 ), "cspf_0_auto12886199143415404758", "cspf_0_auto14180689325225291396" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( 690.89, 336, 1585 ), ( 0, 339.31, 0 ), "cspf_0_auto14180689325225291396" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( 730.23, 482.82, 1585 ), ( 0, 339.44, 0 ), "cspf_0_auto14180689325225291396" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( 717.81, 436.46, 1585 ), ( 0, 339.44, 0 ), "cspf_0_auto14180689325225291396" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( 713.12, 388.02, 1585 ), ( 0, 339.75, 0 ), "cspf_0_auto14180689325225291396" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( 3493.82, 2514.23, 2430 ), ( 0, 299.99, 0 ), "cspf_0_auto12886199143415404758", "cspf_0_auto17942597373752187273" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( 3522.99, 2497.14, 2254 ), ( 0, 184.41, 0 ), "cspf_0_auto17942597373752187273" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( 3543.41, 2357.49, 2254 ), ( 0, 184.41, 0 ), "cspf_0_auto17942597373752187273" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( 3534.25, 2407.61, 2254 ), ( 0, 184.41, 0 ), "cspf_0_auto17942597373752187273" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( 3528.57, 2446.69, 2254 ), ( 0, 184.41, 0 ), "cspf_0_auto17942597373752187273" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( 3868.11, -1293.56, 1491.5 ), ( 0, 209.99, 0 ), "cspf_0_auto12886199143415404758", "cspf_0_auto16167386794598345920" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( 3769.3, -1415.28, 1315.5 ), ( 0, 267.77, 0 ), "cspf_0_auto16167386794598345920" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( 3910.37, -1411.15, 1315.5 ), ( 0, 267.76, 0 ), "cspf_0_auto16167386794598345920" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( 3859.53, -1414.45, 1315.5 ), ( 0, 267.76, 0 ), "cspf_0_auto16167386794598345920" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( 3820.05, -1415.58, 1315.5 ), ( 0, 267.76, 0 ), "cspf_0_auto16167386794598345920" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( -2556.4, 1603.04, 1977 ), ( 0, 206.09, 0 ), "cspf_0_auto12886199143415404758", "cspf_0_auto12665698102785027791" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( 30799, 30655, 1606 ), ( 0, 0, 0 ), "scarab_boss_fight_arena_center" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( -2449.98, 1550.2, 1605.54 ), ( 0, 135, 0 ), "cspf_0_auto12665698102785027791" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( -2525.16, 1477.69, 1607.22 ), ( 0, 135, 0 ), "cspf_0_auto12665698102785027791" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( -2493.64, 1497, 1610.48 ), ( 0, 135, 0 ), "cspf_0_auto12665698102785027791" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( -2472.66, 1528.91, 1605 ), ( 0, 135, 0 ), "cspf_0_auto12665698102785027791" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( -3239.4, 2273.04, 1897 ), ( 0, 206.09, 0 ), "cspf_0_auto12886199143415404758", "cspf_0_auto10359071670891432381" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( -3132.98, 2220.2, 1525.54 ), ( 0, 135, 0 ), "cspf_0_auto10359071670891432381" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( -3208.16, 2147.69, 1527.22 ), ( 0, 135, 0 ), "cspf_0_auto10359071670891432381" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( -3176.64, 2167, 1530.48 ), ( 0, 135, 0 ), "cspf_0_auto10359071670891432381" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( -3155.66, 2198.91, 1525 ), ( 0, 135, 0 ), "cspf_0_auto10359071670891432381" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( -143.01, -684.43, 1019 ), ( 0, 235.19, 0 ), "cspf_0_auto12886199143415404758", "cspf_0_auto9866379428074829428" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( -219.99, -691.22, 917 ), ( 0, 299.61, 0 ), "cspf_0_auto9866379428074829428" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( -94.1, -606.02, 917 ), ( 0, 299.61, 0 ), "cspf_0_auto9866379428074829428" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( -133.86, -632.93, 917 ), ( 0, 299.61, 0 ), "cspf_0_auto9866379428074829428" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( -169.13, -666.46, 917 ), ( 0, 299.61, 0 ), "cspf_0_auto9866379428074829428" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( -135.01, -1225.71, 1014.5 ), ( 0, 22.76, 0 ), "cspf_0_auto12886199143415404758", "cspf_0_auto14614614399871040581" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( -66.4, -1261.26, 912.5 ), ( 0, 87.18, 0 ), "cspf_0_auto14614614399871040581" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( -218.34, -1265.67, 912.5 ), ( 0, 87.18, 0 ), "cspf_0_auto14614614399871040581" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( -170.36, -1264.28, 912.5 ), ( 0, 87.18, 0 ), "cspf_0_auto14614614399871040581" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( -122.61, -1254.88, 912.5 ), ( 0, 87.18, 0 ), "cspf_0_auto14614614399871040581" );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace zm_sat_scarab_teleport_back_cs
// Params 0, eflags: 0x4
// Checksum 0xcb78e7c8, Offset: 0x410c
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace zm_sat_scarab_teleport_back_cs
// Params 0
// Checksum 0x85969bd6, Offset: 0x4116
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "zm_sat_scarab_teleport_back_cs" );
}

