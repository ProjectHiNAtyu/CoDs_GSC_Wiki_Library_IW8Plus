// scripts\mp\zm\maps\zm_sat_scarab\zm_sat_scarab_script_astral_motes_cs.gsc  (hash_6d8b031922091963.gscc) (size: 4964 Bytes / 0x1364 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xc961a540 (3378619712)
// size ...... 4964 (0x1364)
// includes .. 3   (offset: 0x1154)
// strings ... 7   (offset: 0x116c)
// dev strs .. 0   (offset: 0x1364)
// exports ... 9   (offset: 0xdbc)
// cseg ...... 0xdc + 0xce0 (0xdbc)
// imports ... 20  (offset: 0xf24)
// animtree1 . 0   (offset: 0x1364)
// animtree2 . 0   (offset: 0x1364)
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace zm_sat_scarab_script_astral_motes_cs;

// Namespace zm_sat_scarab_script_astral_motes_cs
// Params 0, eflags: 0x5
// Checksum 0xe1f3f53a, Offset: 0xfa
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"zm_sat_scarab_script_astral_motes_cs", undefined, &function_b39ecd3d51489472, undefined );
}

// Namespace zm_sat_scarab_script_astral_motes_cs
// Params 0, eflags: 0x4
// Checksum 0x16eacd16, Offset: 0x11b
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace zm_sat_scarab_script_astral_motes_cs
// Params 0, eflags: 0x4
// Checksum 0x93d11efa, Offset: 0x12c
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace zm_sat_scarab_script_astral_motes_cs
// Params 2
// Checksum 0x233848b3, Offset: 0x13d
// Size: 0x80
function main( unused, unused2 )
{
    if ( utility::flag_exist( "zm_sat_scarab_script_astral_motes_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "zm_sat_scarab_script_astral_motes_cs" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "zm_sat_scarab_script_astral_motes_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "zm_sat_scarab_script_astral_motes_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace zm_sat_scarab_script_astral_motes_cs
// Params 3, eflags: 0x4
// Checksum 0x1053aa35, Offset: 0x1c5
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "zm_sat_scarab_script_astral_motes_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "zm_sat_scarab_script_astral_motes_cs" );
}

// Namespace zm_sat_scarab_script_astral_motes_cs
// Params 3, eflags: 0x4
// Checksum 0x841b705e, Offset: 0x23f
// Size: 0xb5d
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_astral_motes_cs";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( -309.68, -2077.16, 1486.5 ), ( 0, 255.43, 0 ), "astral_mote_spawn", undefined, "forge" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_astral_motes_cs";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( 1123.32, -691.66, 1497.5 ), ( 0, 166.2, 0 ), "astral_mote_spawn", undefined, "forge" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_astral_motes_cs";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( -97.43, 229.09, 1550 ), ( 0, 91.71, 0 ), "astral_mote_spawn", undefined, "forge" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_astral_motes_cs";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( -1247.93, -764.91, 1470 ), ( 0, 354.66, 0 ), "astral_mote_spawn", undefined, "forge" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_astral_motes_cs";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( -1193.68, -1086.41, 1559.25 ), ( 0, 354.66, 0 ), "astral_mote_spawn", undefined, "forge" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_astral_motes_cs";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( 202.07, 177.09, 1443 ), ( 0, 191.75, 0 ), "astral_mote_spawn", undefined, "forge" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_astral_motes_cs";
    fe [[ f ]]( s, us, cf, ( 217.07, 2194.09, 2006 ), ( 0, 191.75, 0 ), "astral_mote_spawn" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_astral_motes_cs";
    fe [[ f ]]( s, us, cf, ( -536.93, 2863.09, 2077 ), ( 0, 191.75, 0 ), "astral_mote_spawn" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_astral_motes_cs";
    fe [[ f ]]( s, us, cf, ( 1444.57, 2795.09, 2040.5 ), ( 0, 201.96, 0 ), "astral_mote_spawn" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_astral_motes_cs";
    fe [[ f ]]( s, us, cf, ( 1333.07, 3912.59, 2104.5 ), ( 0, 201.96, 0 ), "astral_mote_spawn" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_astral_motes_cs";
    fe [[ f ]]( s, us, cf, ( 289.49, 4177.12, 2296.58 ), ( 1.65, 68.92, 4.27 ), "astral_mote_spawn" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_astral_motes_cs";
    fe [[ f ]]( s, us, cf, ( -4873.43, 363.09, 1996 ), ( 0, 191.75, 0 ), "astral_mote_spawn" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_astral_motes_cs";
    fe [[ f ]]( s, us, cf, ( -6346.93, -63.91, 1939.5 ), ( 0, 191.75, 0 ), "astral_mote_spawn" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_astral_motes_cs";
    fe [[ f ]]( s, us, cf, ( 4952.07, 933.09, 1992.5 ), ( 0, 191.75, 0 ), "astral_mote_spawn" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_astral_motes_cs";
    fe [[ f ]]( s, us, cf, ( 3269.57, 89.59, 1816 ), ( 0, 191.75, 0 ), "astral_mote_spawn" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_astral_motes_cs";
    fe [[ f ]]( s, us, cf, ( 4494.07, -71.41, 1816 ), ( 0, 191.75, 0 ), "astral_mote_spawn" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_astral_motes_cs";
    fe [[ f ]]( s, us, cf, ( 3486.07, -133.41, 2029.5 ), ( 0, 191.75, 0 ), "astral_mote_spawn" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_astral_motes_cs";
    fe [[ f ]]( s, us, cf, ( 4730.19, 132.63, 1965.87 ), ( 0.25, 227.83, -4.99 ), "astral_mote_spawn" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_astral_motes_cs";
    fe [[ f ]]( s, us, cf, ( 4428.07, 1128.59, 2025 ), ( 0, 191.75, 0 ), "astral_mote_spawn" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_astral_motes_cs";
    fe [[ f ]]( s, us, cf, ( 3889.35, 1384.38, 1905.04 ), ( 1.19, 238.77, -4.86 ), "astral_mote_spawn" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_astral_motes_cs";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( 250.07, -2109.91, 1497.5 ), ( 0, 166.2, 0 ), "astral_mote_spawn", undefined, "forge" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_astral_motes_cs";
    fe [[ f ]]( s, us, cf, ( -4364.43, 1153.59, 1930.5 ), ( 0, 191.75, 0 ), "astral_mote_spawn" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_astral_motes_cs";
    fe [[ f ]]( s, us, cf, ( -5038.93, 1498.09, 2044 ), ( 0, 191.75, 0 ), "astral_mote_spawn" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_astral_motes_cs";
    fe [[ f ]]( s, us, cf, ( -5757.93, 1068.59, 1964.5 ), ( 0, 191.75, 0 ), "astral_mote_spawn" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_astral_motes_cs";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( 3, -942.5, 1217 ), ( 0, 0, 0 ), "forge_center", undefined, undefined, undefined, undefined, undefined, undefined, 380 );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_astral_motes_cs";
    fe [[ f ]]( s, us, cf, ( -1318.18, -153.16, 1672 ), ( 0, 156.09, 0 ), "astral_mote_spawn" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_astral_motes_cs";
    fe [[ f ]]( s, us, cf, ( -904.96, 1828.96, 1895.25 ), ( 1.83, 137.42, 1.66 ), "astral_mote_spawn" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_astral_motes_cs";
    fe [[ f ]]( s, us, cf, ( -340.48, 1342.85, 1979 ), ( 0, 217.19, 0 ), "astral_mote_spawn" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_astral_motes_cs";
    fe [[ f ]]( s, us, cf, ( -617.27, 228.64, 1723.88 ), ( 356.91, 164.52, -11 ), "astral_mote_spawn" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_astral_motes_cs";
    fe [[ f ]]( s, us, cf, ( -2578.19, -3195.23, 1713 ), ( 0, 101.97, 0 ), "astral_mote_spawn" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_astral_motes_cs";
    fe [[ f ]]( s, us, cf, ( -1776.77, -2982.4, 1484.5 ), ( 0, 237.13, 0 ), "astral_mote_spawn" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_astral_motes_cs";
    fe [[ f ]]( s, us, cf, ( -2298.67, -1070.27, 1652.5 ), ( 0, 152.57, 0 ), "astral_mote_spawn" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_astral_motes_cs";
    fe [[ f ]]( s, us, cf, ( -1919.08, -1374.36, 1533 ), ( 0, 314.64, -0 ), "astral_mote_spawn" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_astral_motes_cs";
    fe [[ f ]]( s, us, cf, ( -1313.7, -1018.81, 1706 ), ( 0, 151.84, 0 ), "astral_mote_spawn" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_astral_motes_cs";
    fe [[ f ]]( s, us, cf, ( -1041.34, -2678.85, 1417.5 ), ( 358, 37.66, 8.31 ), "astral_mote_spawn" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_astral_motes_cs";
    fe [[ f ]]( s, us, cf, ( 2079.77, -2507.35, 1768 ), ( 0, 132.48, 0 ), "astral_mote_spawn" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_astral_motes_cs";
    fe [[ f ]]( s, us, cf, ( 1620.07, -2433.08, 1400.28 ), ( 358.11, 98.68, -5.44 ), "astral_mote_spawn" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_astral_motes_cs";
    fe [[ f ]]( s, us, cf, ( 364.14, 580.97, 1665.5 ), ( 0, 158.87, 0 ), "astral_mote_spawn" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_astral_motes_cs";
    fe [[ f ]]( s, us, cf, ( 1400.82, -105.7, 1925 ), ( 0, 52.96, 0 ), "astral_mote_spawn" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_astral_motes_cs";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( 1281.78, -390.38, 1581.41 ), ( 348.64, 49.25, -1.87 ), "astral_mote_spawn", undefined, "forge" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_astral_motes_cs";
    fe [[ f ]]( s, us, cf, ( 295.3, 812.76, 1747 ), ( 0, 138.6, 0 ), "astral_mote_spawn" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_astral_motes_cs";
    fe [[ f ]]( s, us, cf, ( -1451.22, 4211.66, 1738 ), ( 0, 81.12, 0 ), "astral_mote_spawn" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_astral_motes_cs";
    fe [[ f ]]( s, us, cf, ( -5216.28, -305.42, 1654.5 ), ( 0, 28.49, 0 ), "astral_mote_spawn" );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace zm_sat_scarab_script_astral_motes_cs
// Params 0, eflags: 0x4
// Checksum 0x74b27781, Offset: 0xda4
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace zm_sat_scarab_script_astral_motes_cs
// Params 0
// Checksum 0xd2007778, Offset: 0xdae
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "zm_sat_scarab_script_astral_motes_cs" );
}

