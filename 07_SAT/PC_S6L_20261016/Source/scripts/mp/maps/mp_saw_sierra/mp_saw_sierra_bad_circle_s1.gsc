// scripts\mp\maps\mp_saw_sierra\mp_saw_sierra_bad_circle_s1.gsc  (hash_04306beaa6a0b60f.gscc) (size: 10312 Bytes / 0x2848 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x5bd73610 (1540830736)
// size ...... 10312 (0x2848)
// includes .. 3   (offset: 0x246c)
// strings ... 5   (offset: 0x2484)
// dev strs .. 0   (offset: 0x2848)
// exports ... 9   (offset: 0x20d4)
// cseg ...... 0xb4 + 0x2020 (0x20d4)
// imports ... 20  (offset: 0x223c)
// animtree1 . 0   (offset: 0x2848)
// animtree2 . 0   (offset: 0x2848)
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace mp_saw_sierra_bad_circle_s1;

// Namespace mp_saw_sierra_bad_circle_s1
// Params 0, eflags: 0x5
// Checksum 0x2c967047, Offset: 0xd2
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"mp_saw_sierra_bad_circle_s1", undefined, &function_b39ecd3d51489472, undefined );
}

// Namespace mp_saw_sierra_bad_circle_s1
// Params 0, eflags: 0x4
// Checksum 0x1881f42c, Offset: 0xf3
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace mp_saw_sierra_bad_circle_s1
// Params 0, eflags: 0x4
// Checksum 0x9dba27c0, Offset: 0x104
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace mp_saw_sierra_bad_circle_s1
// Params 2
// Checksum 0x2d537189, Offset: 0x115
// Size: 0x80
function main( unused, unused2 )
{
    if ( utility::flag_exist( "mp_saw_sierra_bad_circle_s1" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "mp_saw_sierra_bad_circle_s1" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "mp_saw_sierra_bad_circle_s1" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "mp_saw_sierra_bad_circle_s1" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace mp_saw_sierra_bad_circle_s1
// Params 3, eflags: 0x4
// Checksum 0x1e38930f, Offset: 0x19d
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "mp_saw_sierra_bad_circle_s1" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "mp_saw_sierra_bad_circle_s1" );
}

// Namespace mp_saw_sierra_bad_circle_s1
// Params 3, eflags: 0x4
// Checksum 0xb0b27010, Offset: 0x217
// Size: 0x1e9d
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_saw_sierra_bad_circle_s1";
    fe [[ f ]]( s, us, cf, ( 58080, -47378.8, -275 ), ( 0, 0, 0 ), undefined, undefined, "badCircle", undefined, undefined, undefined, undefined, 5000 );
    s = {};
    s.script_cs_flag = "mp_saw_sierra_bad_circle_s1";
    fe [[ f ]]( s, us, cf, ( 43372, -50872.3, -275 ), ( 0, 0, 0 ), undefined, undefined, "badCircle", undefined, undefined, undefined, undefined, 7000 );
    s = {};
    s.script_cs_flag = "mp_saw_sierra_bad_circle_s1";
    fe [[ f ]]( s, us, cf, ( 51868.6, -51357.6, -275 ), ( 0, 0, 0 ), undefined, undefined, "badCircle", undefined, undefined, undefined, undefined, 7500 );
    s = {};
    s.script_cs_flag = "mp_saw_sierra_bad_circle_s1";
    fe [[ f ]]( s, us, cf, ( 61401, -43161, -275 ), ( 0, 0, 0 ), undefined, undefined, "badCircle", undefined, undefined, undefined, undefined, 4800 );
    s = {};
    s.script_cs_flag = "mp_saw_sierra_bad_circle_s1";
    fe [[ f ]]( s, us, cf, ( 32850, -51436.8, -275 ), ( 0, 0, 0 ), undefined, undefined, "badCircle", undefined, undefined, undefined, undefined, 7000 );
    s = {};
    s.script_cs_flag = "mp_saw_sierra_bad_circle_s1";
    fe [[ f ]]( s, us, cf, ( 34353.3, -43130.8, -275 ), ( 0, 0, 0 ), undefined, undefined, "badCircle", undefined, undefined, undefined, undefined, 2500 );
    s = {};
    s.script_cs_flag = "mp_saw_sierra_bad_circle_s1";
    fe [[ f ]]( s, us, cf, ( 30364.6, -41131.1, -536 ), ( 0, 0, 0 ), undefined, undefined, "badCircle", undefined, undefined, undefined, undefined, 4000 );
    s = {};
    s.script_cs_flag = "mp_saw_sierra_bad_circle_s1";
    fe [[ f ]]( s, us, cf, ( 28457.1, -37429.1, -275 ), ( 0, 0, 0 ), undefined, undefined, "badCircle", undefined, undefined, undefined, undefined, 1500 );
    s = {};
    s.script_cs_flag = "mp_saw_sierra_bad_circle_s1";
    fe [[ f ]]( s, us, cf, ( 28224.1, -32799.6, -275 ), ( 0, 0, 0 ), undefined, undefined, "badCircle", undefined, undefined, undefined, undefined, 1500 );
    s = {};
    s.script_cs_flag = "mp_saw_sierra_bad_circle_s1";
    fe [[ f ]]( s, us, cf, ( 28207.3, -34377.4, -275 ), ( 0, 0, 0 ), undefined, undefined, "badCircle", undefined, undefined, undefined, undefined, 1400 );
    s = {};
    s.script_cs_flag = "mp_saw_sierra_bad_circle_s1";
    fe [[ f ]]( s, us, cf, ( 28044.3, -35676.8, -275 ), ( 0, 0, 0 ), undefined, undefined, "badCircle", undefined, undefined, undefined, undefined, 1500 );
    s = {};
    s.script_cs_flag = "mp_saw_sierra_bad_circle_s1";
    fe [[ f ]]( s, us, cf, ( 39551, -45914.1, -275 ), ( 0, 0, 0 ), undefined, undefined, "badCircle", undefined, undefined, undefined, undefined, 2000 );
    s = {};
    s.script_cs_flag = "mp_saw_sierra_bad_circle_s1";
    fe [[ f ]]( s, us, cf, ( 36383.5, -44609.8, -275 ), ( 0, 0, 0 ), undefined, undefined, "badCircle", undefined, undefined, undefined, undefined, 1500 );
    s = {};
    s.script_cs_flag = "mp_saw_sierra_bad_circle_s1";
    fe [[ f ]]( s, us, cf, ( 38149.5, -45040.3, -275 ), ( 0, 0, 0 ), undefined, undefined, "badCircle", undefined, undefined, undefined, undefined, 1500 );
    s = {};
    s.script_cs_flag = "mp_saw_sierra_bad_circle_s1";
    fe [[ f ]]( s, us, cf, ( 26034.1, -36675.6, -275 ), ( 0, 0, 0 ), undefined, undefined, "badCircle", undefined, undefined, undefined, undefined, 1400 );
    s = {};
    s.script_cs_flag = "mp_saw_sierra_bad_circle_s1";
    fe [[ f ]]( s, us, cf, ( 24441.1, -35961.4, -486 ), ( 0, 0, 0 ), undefined, undefined, "badCircle", undefined, undefined, undefined, undefined, 1400 );
    s = {};
    s.script_cs_flag = "mp_saw_sierra_bad_circle_s1";
    fe [[ f ]]( s, us, cf, ( 22965.6, -36590.4, -486 ), ( 0, 0, 0 ), undefined, undefined, "badCircle", undefined, undefined, undefined, undefined, 1400 );
    s = {};
    s.script_cs_flag = "mp_saw_sierra_bad_circle_s1";
    fe [[ f ]]( s, us, cf, ( 17688.6, -40868.1, -486 ), ( 0, 0, 0 ), undefined, undefined, "badCircle", undefined, undefined, undefined, undefined, 3500 );
    s = {};
    s.script_cs_flag = "mp_saw_sierra_bad_circle_s1";
    fe [[ f ]]( s, us, cf, ( 24789.3, -40511.6, -486 ), ( 0, 0, 0 ), undefined, undefined, "badCircle", undefined, undefined, undefined, undefined, 3500 );
    s = {};
    s.script_cs_flag = "mp_saw_sierra_bad_circle_s1";
    fe [[ f ]]( s, us, cf, ( 21093.6, -38192.1, -486 ), ( 0, 0, 0 ), undefined, undefined, "badCircle", undefined, undefined, undefined, undefined, 2500 );
    s = {};
    s.script_cs_flag = "mp_saw_sierra_bad_circle_s1";
    fe [[ f ]]( s, us, cf, ( 12684.1, -41400.6, -486 ), ( 0, 0, 0 ), undefined, undefined, "badCircle", undefined, undefined, undefined, undefined, 3500 );
    s = {};
    s.script_cs_flag = "mp_saw_sierra_bad_circle_s1";
    fe [[ f ]]( s, us, cf, ( 8502.85, -38799.1, -486 ), ( 0, 0, 0 ), undefined, undefined, "badCircle", undefined, undefined, undefined, undefined, 3500 );
    s = {};
    s.script_cs_flag = "mp_saw_sierra_bad_circle_s1";
    fe [[ f ]]( s, us, cf, ( 11651.6, -37636.1, -486 ), ( 0, 0, 0 ), undefined, undefined, "badCircle", undefined, undefined, undefined, undefined, 1500 );
    s = {};
    s.script_cs_flag = "mp_saw_sierra_bad_circle_s1";
    fe [[ f ]]( s, us, cf, ( 11632.1, -36417.9, -486 ), ( 0, 0, 0 ), undefined, undefined, "badCircle", undefined, undefined, undefined, undefined, 1500 );
    s = {};
    s.script_cs_flag = "mp_saw_sierra_bad_circle_s1";
    fe [[ f ]]( s, us, cf, ( 9762.35, -36389.6, -556 ), ( 0, 0, 0 ), undefined, undefined, "badCircle", undefined, undefined, undefined, undefined, 1600 );
    s = {};
    s.script_cs_flag = "mp_saw_sierra_bad_circle_s1";
    fe [[ f ]]( s, us, cf, ( 5049.85, -38587.4, -250 ), ( 0, 0, 0 ), undefined, undefined, "badCircle", undefined, undefined, undefined, undefined, 1600 );
    s = {};
    s.script_cs_flag = "mp_saw_sierra_bad_circle_s1";
    fe [[ f ]]( s, us, cf, ( 2813.85, -40898.4, -238.25 ), ( 0, 0, 0 ), undefined, undefined, "badCircle", undefined, undefined, undefined, undefined, 3000 );
    s = {};
    s.script_cs_flag = "mp_saw_sierra_bad_circle_s1";
    fe [[ f ]]( s, us, cf, ( -72.9, -43715.9, 382.25 ), ( 0, 0, 0 ), undefined, undefined, "badCircle", undefined, undefined, undefined, undefined, 3000 );
    s = {};
    s.script_cs_flag = "mp_saw_sierra_bad_circle_s1";
    fe [[ f ]]( s, us, cf, ( -4517.4, -44743.9, 262.5 ), ( 0, 0, 0 ), undefined, undefined, "badCircle", undefined, undefined, undefined, undefined, 3000 );
    s = {};
    s.script_cs_flag = "mp_saw_sierra_bad_circle_s1";
    fe [[ f ]]( s, us, cf, ( -8237.4, -44353.4, 53.5 ), ( 0, 0, 0 ), undefined, undefined, "badCircle", undefined, undefined, undefined, undefined, 3000 );
    s = {};
    s.script_cs_flag = "mp_saw_sierra_bad_circle_s1";
    fe [[ f ]]( s, us, cf, ( -11475.4, -46307.9, 53.5 ), ( 0, 0, 0 ), undefined, undefined, "badCircle", undefined, undefined, undefined, undefined, 3000 );
    s = {};
    s.script_cs_flag = "mp_saw_sierra_bad_circle_s1";
    fe [[ f ]]( s, us, cf, ( -15071.7, -46956.6, 53.5 ), ( 0, 0, 0 ), undefined, undefined, "badCircle", undefined, undefined, undefined, undefined, 3000 );
    s = {};
    s.script_cs_flag = "mp_saw_sierra_bad_circle_s1";
    fe [[ f ]]( s, us, cf, ( -19514.4, -46403.4, 53.5 ), ( 0, 0, 0 ), undefined, undefined, "badCircle", undefined, undefined, undefined, undefined, 3000 );
    s = {};
    s.script_cs_flag = "mp_saw_sierra_bad_circle_s1";
    fe [[ f ]]( s, us, cf, ( -23485.2, -43861.1, 659.5 ), ( 0, 0, 0 ), undefined, undefined, "badCircle", undefined, undefined, undefined, undefined, 3000 );
    s = {};
    s.script_cs_flag = "mp_saw_sierra_bad_circle_s1";
    fe [[ f ]]( s, us, cf, ( -26964.4, -42654.4, 364 ), ( 0, 0, 0 ), undefined, undefined, "badCircle", undefined, undefined, undefined, undefined, 3000 );
    s = {};
    s.script_cs_flag = "mp_saw_sierra_bad_circle_s1";
    fe [[ f ]]( s, us, cf, ( -30776.2, -41000.4, 364 ), ( 0, 0, 0 ), undefined, undefined, "badCircle", undefined, undefined, undefined, undefined, 3000 );
    s = {};
    s.script_cs_flag = "mp_saw_sierra_bad_circle_s1";
    fe [[ f ]]( s, us, cf, ( -34947.2, -38768.4, 364 ), ( 0, 0, 0 ), undefined, undefined, "badCircle", undefined, undefined, undefined, undefined, 3000 );
    s = {};
    s.script_cs_flag = "mp_saw_sierra_bad_circle_s1";
    fe [[ f ]]( s, us, cf, ( -37851.7, -35806.6, 714.25 ), ( 0, 0, 0 ), undefined, undefined, "badCircle", undefined, undefined, undefined, undefined, 3000 );
    s = {};
    s.script_cs_flag = "mp_saw_sierra_bad_circle_s1";
    fe [[ f ]]( s, us, cf, ( -43770.9, -36865.1, 714.25 ), ( 0, 0, 0 ), undefined, undefined, "badCircle", undefined, undefined, undefined, undefined, 4000 );
    s = {};
    s.script_cs_flag = "mp_saw_sierra_bad_circle_s1";
    fe [[ f ]]( s, us, cf, ( -40973.4, -49173.1, 714.25 ), ( 0, 0, 0 ), undefined, undefined, "badCircle", undefined, undefined, undefined, undefined, 12000 );
    s = {};
    s.script_cs_flag = "mp_saw_sierra_bad_circle_s1";
    fe [[ f ]]( s, us, cf, ( -26797.6, -51390.4, 714.25 ), ( 0, 0, 0 ), undefined, undefined, "badCircle", undefined, undefined, undefined, undefined, 9000 );
    s = {};
    s.script_cs_flag = "mp_saw_sierra_bad_circle_s1";
    fe [[ f ]]( s, us, cf, ( -15884.6, -52450.6, 714.25 ), ( 0, 0, 0 ), undefined, undefined, "badCircle", undefined, undefined, undefined, undefined, 5000 );
    s = {};
    s.script_cs_flag = "mp_saw_sierra_bad_circle_s1";
    fe [[ f ]]( s, us, cf, ( -4680.35, -55168.9, 714.25 ), ( 0, 0, 0 ), undefined, undefined, "badCircle", undefined, undefined, undefined, undefined, 10000 );
    s = {};
    s.script_cs_flag = "mp_saw_sierra_bad_circle_s1";
    fe [[ f ]]( s, us, cf, ( 7984.65, -50366.4, 714.25 ), ( 0, 0, 0 ), undefined, undefined, "badCircle", undefined, undefined, undefined, undefined, 10000 );
    s = {};
    s.script_cs_flag = "mp_saw_sierra_bad_circle_s1";
    fe [[ f ]]( s, us, cf, ( 22421.9, -50093.4, 714.25 ), ( 0, 0, 0 ), undefined, undefined, "badCircle", undefined, undefined, undefined, undefined, 10000 );
    s = {};
    s.script_cs_flag = "mp_saw_sierra_bad_circle_s1";
    fe [[ f ]]( s, us, cf, ( -47402.6, -35178.6, 714.25 ), ( 0, 0, 0 ), undefined, undefined, "badCircle", undefined, undefined, undefined, undefined, 3000 );
    s = {};
    s.script_cs_flag = "mp_saw_sierra_bad_circle_s1";
    fe [[ f ]]( s, us, cf, ( -33130.9, 35350.9, 2043 ), ( 0, 0, 0 ), undefined, undefined, "badCircle", undefined, undefined, undefined, undefined, 2500 );
    s = {};
    s.script_cs_flag = "mp_saw_sierra_bad_circle_s1";
    fe [[ f ]]( s, us, cf, ( -31759.4, 36493.1, 2043 ), ( 0, 0, 0 ), undefined, undefined, "badCircle", undefined, undefined, undefined, undefined, 2500 );
    s = {};
    s.script_cs_flag = "mp_saw_sierra_bad_circle_s1";
    fe [[ f ]]( s, us, cf, ( -29336.4, 37968.4, 2043 ), ( 0, 0, 0 ), undefined, undefined, "badCircle", undefined, undefined, undefined, undefined, 2800 );
    s = {};
    s.script_cs_flag = "mp_saw_sierra_bad_circle_s1";
    fe [[ f ]]( s, us, cf, ( -28046.2, 39039.1, 2043 ), ( 0, 0, 0 ), undefined, undefined, "badCircle", undefined, undefined, undefined, undefined, 2500 );
    s = {};
    s.script_cs_flag = "mp_saw_sierra_bad_circle_s1";
    fe [[ f ]]( s, us, cf, ( -28088.9, 40814.6, 2043 ), ( 0, 0, 0 ), undefined, undefined, "badCircle", undefined, undefined, undefined, undefined, 2800 );
    s = {};
    s.script_cs_flag = "mp_saw_sierra_bad_circle_s1";
    fe [[ f ]]( s, us, cf, ( -27149.4, 43790.9, 2641.25 ), ( 0, 0, 0 ), undefined, undefined, "badCircle", undefined, undefined, undefined, undefined, 2000 );
    s = {};
    s.script_cs_flag = "mp_saw_sierra_bad_circle_s1";
    fe [[ f ]]( s, us, cf, ( -27164.4, 45697.9, 2641.25 ), ( 0, 0, 0 ), undefined, undefined, "badCircle", undefined, undefined, undefined, undefined, 1600 );
    s = {};
    s.script_cs_flag = "mp_saw_sierra_bad_circle_s1";
    fe [[ f ]]( s, us, cf, ( -18305.7, 50710.9, 2671 ), ( 0, 0, 0 ), undefined, undefined, "badCircle", undefined, undefined, undefined, undefined, 1400 );
    s = {};
    s.script_cs_flag = "mp_saw_sierra_bad_circle_s1";
    fe [[ f ]]( s, us, cf, ( -17792.7, 48967.1, 2622.5 ), ( 0, 0, 0 ), undefined, undefined, "badCircle", undefined, undefined, undefined, undefined, 1400 );
    s = {};
    s.script_cs_flag = "mp_saw_sierra_bad_circle_s1";
    fe [[ f ]]( s, us, cf, ( -17274.7, 47442.1, 2250.25 ), ( 0, 0, 0 ), undefined, undefined, "badCircle", undefined, undefined, undefined, undefined, 1400 );
    s = {};
    s.script_cs_flag = "mp_saw_sierra_bad_circle_s1";
    fe [[ f ]]( s, us, cf, ( -17055.7, 45798.6, 1829.75 ), ( 0, 0, 0 ), undefined, undefined, "badCircle", undefined, undefined, undefined, undefined, 1500 );
    s = {};
    s.script_cs_flag = "mp_saw_sierra_bad_circle_s1";
    fe [[ f ]]( s, us, cf, ( -16275.2, 44196.4, 1709.25 ), ( 0, 0, 0 ), undefined, undefined, "badCircle", undefined, undefined, undefined, undefined, 1500 );
    s = {};
    s.script_cs_flag = "mp_saw_sierra_bad_circle_s1";
    fe [[ f ]]( s, us, cf, ( -14642.5, 43389.6, 1688.5 ), ( 0, 0, 0 ), undefined, undefined, "badCircle", undefined, undefined, undefined, undefined, 1800 );
    s = {};
    s.script_cs_flag = "mp_saw_sierra_bad_circle_s1";
    fe [[ f ]]( s, us, cf, ( 63619.8, -38684, 621.75 ), ( 0, 0, 0 ), undefined, undefined, "badCircle", undefined, undefined, undefined, undefined, 3500 );
    s = {};
    s.script_cs_flag = "mp_saw_sierra_bad_circle_s1";
    fe [[ f ]]( s, us, cf, ( -20413.7, 49260.9, 2671 ), ( 0, 0, 0 ), undefined, undefined, "badCircle", undefined, undefined, undefined, undefined, 2800 );
    s = {};
    s.script_cs_flag = "mp_saw_sierra_bad_circle_s1";
    fe [[ f ]]( s, us, cf, ( -22827.7, 48340.9, 2671 ), ( 0, 0, 0 ), undefined, undefined, "badCircle", undefined, undefined, undefined, undefined, 2800 );
    s = {};
    s.script_cs_flag = "mp_saw_sierra_bad_circle_s1";
    fe [[ f ]]( s, us, cf, ( -25530.2, 46761.4, 2671 ), ( 0, 0, 0 ), undefined, undefined, "badCircle", undefined, undefined, undefined, undefined, 2800 );
    s = {};
    s.script_cs_flag = "mp_saw_sierra_bad_circle_s1";
    fe [[ f ]]( s, us, cf, ( 46007.8, 44720.9, 754.5 ), ( 0, 0, 0 ), undefined, undefined, "badCircle", undefined, undefined, undefined, undefined, 2500 );
    s = {};
    s.script_cs_flag = "mp_saw_sierra_bad_circle_s1";
    fe [[ f ]]( s, us, cf, ( 27278.6, 3754.6, -530.5 ), ( 0, 0, 0 ), undefined, undefined, "badCircle", undefined, undefined, undefined, undefined, 5000 );
    s = {};
    s.script_cs_flag = "mp_saw_sierra_bad_circle_s1";
    fe [[ f ]]( s, us, cf, ( 29574.6, 1786.6, -686.5 ), ( 0, 0, 0 ), undefined, undefined, "badCircle", undefined, undefined, undefined, undefined, 5500 );
    s = {};
    s.script_cs_flag = "mp_saw_sierra_bad_circle_s1";
    fe [[ f ]]( s, us, cf, ( 39314.6, 7114.6, -142.5 ), ( 0, 0, 0 ), undefined, undefined, "badCircle", undefined, undefined, undefined, undefined, 3000 );
    s = {};
    s.script_cs_flag = "mp_saw_sierra_bad_circle_s1";
    fe [[ f ]]( s, us, cf, ( 43718.6, -22841.4, -430.5 ), ( 0, 0, 0 ), undefined, undefined, "badCircle", undefined, undefined, undefined, undefined, 2000 );
    s = {};
    s.script_cs_flag = "mp_saw_sierra_bad_circle_s1";
    fe [[ f ]]( s, us, cf, ( 40642.6, -12593.4, 141.5 ), ( 0, 0, 0 ), undefined, undefined, "badCircle", undefined, undefined, undefined, undefined, 1600 );
    s = {};
    s.script_cs_flag = "mp_saw_sierra_bad_circle_s1";
    fe [[ f ]]( s, us, cf, ( 36882.6, -12693.4, -398.5 ), ( 0, 0, 0 ), undefined, undefined, "badCircle", undefined, undefined, undefined, undefined, 1400 );
    s = {};
    s.script_cs_flag = "mp_saw_sierra_bad_circle_s1";
    fe [[ f ]]( s, us, cf, ( 37098.6, -11141.4, -330.5 ), ( 0, 0, 0 ), undefined, undefined, "badCircle", undefined, undefined, undefined, undefined, 1550 );
    s = {};
    s.script_cs_flag = "mp_saw_sierra_bad_circle_s1";
    fe [[ f ]]( s, us, cf, ( 37102.6, -9581.4, -338.5 ), ( 0, 0, 0 ), undefined, undefined, "badCircle", undefined, undefined, undefined, undefined, 1400 );
    s = {};
    s.script_cs_flag = "mp_saw_sierra_bad_circle_s1";
    fe [[ f ]]( s, us, cf, ( 37258.6, -8145.4, -334.5 ), ( 0, 0, 0 ), undefined, undefined, "badCircle", undefined, undefined, undefined, undefined, 1750 );
    s = {};
    s.script_cs_flag = "mp_saw_sierra_bad_circle_s1";
    fe [[ f ]]( s, us, cf, ( 37698.6, -6797.4, -342.5 ), ( 0, 0, 0 ), undefined, undefined, "badCircle", undefined, undefined, undefined, undefined, 1400 );
    s = {};
    s.script_cs_flag = "mp_saw_sierra_bad_circle_s1";
    fe [[ f ]]( s, us, cf, ( 10734.6, -4617.4, -334.5 ), ( 0, 0, 0 ), undefined, undefined, "badCircle", undefined, undefined, undefined, undefined, 1500 );
    s = {};
    s.script_cs_flag = "mp_saw_sierra_bad_circle_s1";
    fe [[ f ]]( s, us, cf, ( 11046.6, -5741.4, -334.5 ), ( 0, 0, 0 ), undefined, undefined, "badCircle", undefined, undefined, undefined, undefined, 1650 );
    s = {};
    s.script_cs_flag = "mp_saw_sierra_bad_circle_s1";
    fe [[ f ]]( s, us, cf, ( 9258.6, -5249.4, -334.5 ), ( 0, 0, 0 ), undefined, undefined, "badCircle", undefined, undefined, undefined, undefined, 1300 );
    s = {};
    s.script_cs_flag = "mp_saw_sierra_bad_circle_s1";
    fe [[ f ]]( s, us, cf, ( 11954.6, -6969.4, -334.5 ), ( 0, 0, 0 ), undefined, undefined, "badCircle", undefined, undefined, undefined, undefined, 1000 );
    s = {};
    s.script_cs_flag = "mp_saw_sierra_bad_circle_s1";
    fe [[ f ]]( s, us, cf, ( 11990.6, -16153.4, -334.5 ), ( 0, 0, 0 ), undefined, undefined, "badCircle", undefined, undefined, undefined, undefined, 1000 );
    s = {};
    s.script_cs_flag = "mp_saw_sierra_bad_circle_s1";
    fe [[ f ]]( s, us, cf, ( 11962.6, -17177.4, -334.5 ), ( 0, 0, 0 ), undefined, undefined, "badCircle", undefined, undefined, undefined, undefined, 1000 );
    s = {};
    s.script_cs_flag = "mp_saw_sierra_bad_circle_s1";
    fe [[ f ]]( s, us, cf, ( -20985.4, 8518.6, -282.5 ), ( 0, 0, 0 ), undefined, undefined, "badCircle", undefined, undefined, undefined, undefined, 1500 );
    s = {};
    s.script_cs_flag = "mp_saw_sierra_bad_circle_s1";
    fe [[ f ]]( s, us, cf, ( -20913.4, 7702.6, -282.5 ), ( 0, 0, 0 ), undefined, undefined, "badCircle", undefined, undefined, undefined, undefined, 1500 );
    s = {};
    s.script_cs_flag = "mp_saw_sierra_bad_circle_s1";
    fe [[ f ]]( s, us, cf, ( -19749.4, 9798.6, -282.5 ), ( 0, 0, 0 ), undefined, undefined, "badCircle", undefined, undefined, undefined, undefined, 800 );
    s = {};
    s.script_cs_flag = "mp_saw_sierra_bad_circle_s1";
    fe [[ f ]]( s, us, cf, ( 47822.6, 8978.6, 41.5 ), ( 0, 0, 0 ), undefined, undefined, "badCircle", undefined, undefined, undefined, undefined, 1700 );
    s = {};
    s.script_cs_flag = "mp_saw_sierra_bad_circle_s1";
    fe [[ f ]]( s, us, cf, ( 46978.6, 7538.6, -34.5 ), ( 0, 0, 0 ), undefined, undefined, "badCircle", undefined, undefined, undefined, undefined, 650 );
    s = {};
    s.script_cs_flag = "mp_saw_sierra_bad_circle_s1";
    fe [[ f ]]( s, us, cf, ( 3946.6, 7966.6, -454.5 ), ( 0, 0, 0 ), undefined, undefined, "badCircle", undefined, undefined, undefined, undefined, 1500 );
    s = {};
    s.script_cs_flag = "mp_saw_sierra_bad_circle_s1";
    fe [[ f ]]( s, us, cf, ( 3798.6, 9278.6, -394.5 ), ( 0, 0, 0 ), undefined, undefined, "badCircle", undefined, undefined, undefined, undefined, 1300 );
    s = {};
    s.script_cs_flag = "mp_saw_sierra_bad_circle_s1";
    fe [[ f ]]( s, us, cf, ( 3446.6, 10506.6, -394.5 ), ( 0, 0, 0 ), undefined, undefined, "badCircle", undefined, undefined, undefined, undefined, 1100 );
    s = {};
    s.script_cs_flag = "mp_saw_sierra_bad_circle_s1";
    fe [[ f ]]( s, us, cf, ( 3446.6, 11974.6, -338.5 ), ( 0, 0, 0 ), undefined, undefined, "badCircle", undefined, undefined, undefined, undefined, 1300 );
    s = {};
    s.script_cs_flag = "mp_saw_sierra_bad_circle_s1";
    fe [[ f ]]( s, us, cf, ( 3222.6, 13342.6, -338.5 ), ( 0, 0, 0 ), undefined, undefined, "badCircle", undefined, undefined, undefined, undefined, 1500 );
    s = {};
    s.script_cs_flag = "mp_saw_sierra_bad_circle_s1";
    fe [[ f ]]( s, us, cf, ( 3494.6, 14626.6, -338.5 ), ( 0, 0, 0 ), undefined, undefined, "badCircle", undefined, undefined, undefined, undefined, 1500 );
    s = {};
    s.script_cs_flag = "mp_saw_sierra_bad_circle_s1";
    fe [[ f ]]( s, us, cf, ( 3754.6, 16594.6, -338.5 ), ( 0, 0, 0 ), undefined, undefined, "badCircle", undefined, undefined, undefined, undefined, 1500 );
    s = {};
    s.script_cs_flag = "mp_saw_sierra_bad_circle_s1";
    fe [[ f ]]( s, us, cf, ( 3218.6, 17754.6, -246.5 ), ( 0, 0, 0 ), undefined, undefined, "badCircle", undefined, undefined, undefined, undefined, 1500 );
    s = {};
    s.script_cs_flag = "mp_saw_sierra_bad_circle_s1";
    fe [[ f ]]( s, us, cf, ( -8229.4, 11106.6, -246.5 ), ( 0, 0, 0 ), undefined, undefined, "badCircle", undefined, undefined, undefined, undefined, 1800 );
    s = {};
    s.script_cs_flag = "mp_saw_sierra_bad_circle_s1";
    fe [[ f ]]( s, us, cf, ( -6037.4, 12150.6, -246.5 ), ( 0, 0, 0 ), undefined, undefined, "badCircle", undefined, undefined, undefined, undefined, 1000 );
    s = {};
    s.script_cs_flag = "mp_saw_sierra_bad_circle_s1";
    fe [[ f ]]( s, us, cf, ( -7229.4, 12630.6, -246.5 ), ( 0, 0, 0 ), undefined, undefined, "badCircle", undefined, undefined, undefined, undefined, 550 );
    s = {};
    s.script_cs_flag = "mp_saw_sierra_bad_circle_s1";
    fe [[ f ]]( s, us, cf, ( -6181.4, 10954.6, -246.5 ), ( 0, 0, 0 ), undefined, undefined, "badCircle", undefined, undefined, undefined, undefined, 550 );
    s = {};
    s.script_cs_flag = "mp_saw_sierra_bad_circle_s1";
    fe [[ f ]]( s, us, cf, ( -9929.4, 12034.6, -346.5 ), ( 0, 0, 0 ), undefined, undefined, "badCircle", undefined, undefined, undefined, undefined, 950 );
    s = {};
    s.script_cs_flag = "mp_saw_sierra_bad_circle_s1";
    fe [[ f ]]( s, us, cf, ( -7701.4, 9402.6, -378.5 ), ( 0, 0, 0 ), undefined, undefined, "badCircle", undefined, undefined, undefined, undefined, 850 );
    s = {};
    s.script_cs_flag = "mp_saw_sierra_bad_circle_s1";
    fe [[ f ]]( s, us, cf, ( -9161.4, 9598.6, -378.5 ), ( 0, 0, 0 ), undefined, undefined, "badCircle", undefined, undefined, undefined, undefined, 850 );
    s = {};
    s.script_cs_flag = "mp_saw_sierra_bad_circle_s1";
    fe [[ f ]]( s, us, cf, ( -8769.4, 8154.6, -378.5 ), ( 0, 0, 0 ), undefined, undefined, "badCircle", undefined, undefined, undefined, undefined, 1250 );
    s = {};
    s.script_cs_flag = "mp_saw_sierra_bad_circle_s1";
    fe [[ f ]]( s, us, cf, ( -6893.4, 10350.6, -378.5 ), ( 0, 0, 0 ), undefined, undefined, "badCircle", undefined, undefined, undefined, undefined, 850 );
    s = {};
    s.script_cs_flag = "mp_saw_sierra_bad_circle_s1";
    fe [[ f ]]( s, us, cf, ( -8905.4, 12666.6, -346.5 ), ( 0, 0, 0 ), undefined, undefined, "badCircle", undefined, undefined, undefined, undefined, 450 );
    s = {};
    s.script_cs_flag = "mp_saw_sierra_bad_circle_s1";
    fe [[ f ]]( s, us, cf, ( 40387.8, 40040.9, 1278.5 ), ( 0, 0, 0 ), undefined, undefined, "badCircle", undefined, undefined, undefined, undefined, 1200 );
    s = {};
    s.script_cs_flag = "mp_saw_sierra_bad_circle_s1";
    fe [[ f ]]( s, us, cf, ( 39723.8, 39072.9, 1278.5 ), ( 0, 0, 0 ), undefined, undefined, "badCircle", undefined, undefined, undefined, undefined, 1200 );
    s = {};
    s.script_cs_flag = "mp_saw_sierra_bad_circle_s1";
    fe [[ f ]]( s, us, cf, ( 39219.8, 37804.9, 1278.5 ), ( 0, 0, 0 ), undefined, undefined, "badCircle", undefined, undefined, undefined, undefined, 900 );
    s = {};
    s.script_cs_flag = "mp_saw_sierra_bad_circle_s1";
    fe [[ f ]]( s, us, cf, ( -17366.5, 37585.6, -595.5 ), ( 0, 0, 0 ), undefined, undefined, "badCircle", undefined, undefined, undefined, undefined, 1800 );
    s = {};
    s.script_cs_flag = "mp_saw_sierra_bad_circle_s1";
    fe [[ f ]]( s, us, cf, ( -18282.5, 38949.6, -595.5 ), ( 0, 0, 0 ), undefined, undefined, "badCircle", undefined, undefined, undefined, undefined, 2000 );
    s = {};
    s.script_cs_flag = "mp_saw_sierra_bad_circle_s1";
    fe [[ f ]]( s, us, cf, ( -19306.5, 40993.6, -595.5 ), ( 0, 0, 0 ), undefined, undefined, "badCircle", undefined, undefined, undefined, undefined, 1800 );
    s = {};
    s.script_cs_flag = "mp_saw_sierra_bad_circle_s1";
    fe [[ f ]]( s, us, cf, ( -15850.5, 36505.6, -595.5 ), ( 0, 0, 0 ), undefined, undefined, "badCircle", undefined, undefined, undefined, undefined, 1000 );
    s = {};
    s.script_cs_flag = "mp_saw_sierra_bad_circle_s1";
    fe [[ f ]]( s, us, cf, ( 42, 148, -858 ), ( 0, 0, 0 ), "bad_circle_test" );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace mp_saw_sierra_bad_circle_s1
// Params 0, eflags: 0x4
// Checksum 0x4e165a10, Offset: 0x20bc
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace mp_saw_sierra_bad_circle_s1
// Params 0
// Checksum 0xdc6b4e42, Offset: 0x20c6
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "mp_saw_sierra_bad_circle_s1" );
}

