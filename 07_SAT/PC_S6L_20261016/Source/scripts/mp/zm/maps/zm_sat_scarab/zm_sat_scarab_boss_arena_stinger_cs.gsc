// scripts\mp\zm\maps\zm_sat_scarab\zm_sat_scarab_boss_arena_stinger_cs.gsc  (hash_0f6dcd0d835697d5.gscc) (size: 10933 Bytes / 0x2ab5 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x6868d814 (1751701524)
// size ...... 10933 (0x2ab5)
// includes .. 2   (offset: 0x248d)
// strings ... 16  (offset: 0x249d)
// dev strs .. 0   (offset: 0x2ab5)
// exports ... 6   (offset: 0x21dd)
// cseg ...... 0x181 + 0x205c (0x21dd)
// imports ... 16  (offset: 0x22cd)
// animtree1 . 0   (offset: 0x2ab5)
// animtree2 . 0   (offset: 0x2ab5)
#using scripts\common\create_script_utility;
#using scripts\common\utility;

#namespace zm_sat_scarab_boss_arena_stinger_cs;

// Namespace zm_sat_scarab_boss_arena_stinger_cs
// Params 2
// Checksum 0xff6710ae, Offset: 0x19f
// Size: 0x80
function main( unused, unused2 )
{
    if ( utility::flag_exist( "zm_sat_scarab_boss_arena_stinger_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "zm_sat_scarab_boss_arena_stinger_cs" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "zm_sat_scarab_boss_arena_stinger_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "zm_sat_scarab_boss_arena_stinger_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace zm_sat_scarab_boss_arena_stinger_cs
// Params 3, eflags: 0x4
// Checksum 0xcc0cf228, Offset: 0x227
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "zm_sat_scarab_boss_arena_stinger_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "zm_sat_scarab_boss_arena_stinger_cs" );
}

// Namespace zm_sat_scarab_boss_arena_stinger_cs
// Params 3, eflags: 0x4
// Checksum 0x8a581863, Offset: 0x2a1
// Size: 0x1f1c
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "zm_sat_scarab_boss_arena_stinger_cs";
    s.groupid = "pattern_1";
    fe [[ f ]]( s, us, cf, ( 2084, 1022, 32 ), ( 0, 0, 0 ), "phase_3", undefined, "weyward_stinger_pat_1", undefined, undefined, undefined, undefined, 300 );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_boss_arena_stinger_cs";
    s.groupid = "pattern_1";
    fe [[ f ]]( s, us, cf, ( 1732, 2046, 0 ), ( 0, 0, 0 ), "phase_3", undefined, "weyward_stinger_pat_1", undefined, undefined, undefined, undefined, 300 );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_boss_arena_stinger_cs";
    s.groupid = "pattern_1";
    fe [[ f ]]( s, us, cf, ( 1124, 2046, 32 ), ( 0, 0, 0 ), "phase_3", undefined, "weyward_stinger_pat_1", undefined, undefined, undefined, undefined, 300 );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_boss_arena_stinger_cs";
    s.groupid = "pattern_1";
    fe [[ f ]]( s, us, cf, ( 2500, 2030, 0 ), ( 0, 0, 0 ), "phase_3", undefined, "weyward_stinger_pat_1", undefined, undefined, undefined, undefined, 300 );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_boss_arena_stinger_cs";
    s.groupid = "pattern_1";
    fe [[ f ]]( s, us, cf, ( 2132, 2366, 0 ), ( 0, 0, 0 ), "phase_3", undefined, "weyward_stinger_pat_1", undefined, undefined, undefined, undefined, 300 );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_boss_arena_stinger_cs";
    s.groupid = "pattern_1";
    fe [[ f ]]( s, us, cf, ( 2068, 2990, 32 ), ( 0, 0, 0 ), "phase_3", undefined, "weyward_stinger_pat_1", undefined, undefined, undefined, undefined, 300 );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_boss_arena_stinger_cs";
    s.groupid = "pattern_1";
    fe [[ f ]]( s, us, cf, ( 3188, 1998, 32 ), ( 0, 0, 0 ), "phase_3", undefined, "weyward_stinger_pat_1", undefined, undefined, undefined, undefined, 300 );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_boss_arena_stinger_cs";
    s.groupid = "pattern_2";
    fe [[ f ]]( s, us, cf, ( 1428, 1214, 32 ), ( 0, 0, 0 ), "phase_3", undefined, "weyward_stinger_pat_2", undefined, undefined, undefined, undefined, 300 );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_boss_arena_stinger_cs";
    s.groupid = "pattern_2";
    fe [[ f ]]( s, us, cf, ( 2788, 1134, 32 ), ( 0, 0, 0 ), "phase_3", undefined, "weyward_stinger_pat_2", undefined, undefined, undefined, undefined, 300 );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_boss_arena_stinger_cs";
    s.groupid = "pattern_2";
    fe [[ f ]]( s, us, cf, ( 1412, 2878, 32 ), ( 0, 0, 0 ), "phase_3", undefined, "weyward_stinger_pat_2", undefined, undefined, undefined, undefined, 300 );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_boss_arena_stinger_cs";
    s.groupid = "pattern_2";
    fe [[ f ]]( s, us, cf, ( 2340, 1662, 0 ), ( 0, 0, 0 ), "phase_3", undefined, "weyward_stinger_pat_2", undefined, undefined, undefined, undefined, 300 );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_boss_arena_stinger_cs";
    s.groupid = "pattern_2";
    fe [[ f ]]( s, us, cf, ( 1876, 2318, 0 ), ( 0, 0, 0 ), "phase_3", undefined, "weyward_stinger_pat_2", undefined, undefined, undefined, undefined, 300 );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_boss_arena_stinger_cs";
    s.groupid = "pattern_2";
    fe [[ f ]]( s, us, cf, ( 2948, 2654, 32 ), ( 0, 0, 0 ), "phase_3", undefined, "weyward_stinger_pat_2", undefined, undefined, undefined, undefined, 300 );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_boss_arena_stinger_cs";
    s.groupid = "pattern_2";
    fe [[ f ]]( s, us, cf, ( 2388, 2286, 0 ), ( 0, 0, 0 ), "phase_3", undefined, "weyward_stinger_pat_2", undefined, undefined, undefined, undefined, 300 );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_boss_arena_stinger_cs";
    s.groupid = "pattern_2";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( 1780, 1726, 0 ), ( 0, 0, 0 ), "phase_3", undefined, "weyward_stinger_pat_2", undefined, undefined, undefined, undefined, 300 );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_boss_arena_stinger_cs";
    s.groupid = "pattern_3";
    fe [[ f ]]( s, us, cf, ( 2196, 3054, 32 ), ( 0, 0, 0 ), "phase_3", undefined, "weyward_stinger_pat_3", undefined, undefined, undefined, undefined, 300 );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_boss_arena_stinger_cs";
    s.groupid = "pattern_3";
    fe [[ f ]]( s, us, cf, ( 2036, 1054, 32 ), ( 0, 0, 0 ), "phase_3", undefined, "weyward_stinger_pat_3", undefined, undefined, undefined, undefined, 300 );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_boss_arena_stinger_cs";
    s.groupid = "pattern_1";
    fe [[ f ]]( s, us, cf, ( 2084, 1614, 0 ), ( 0, 0, 0 ), "phase_3", undefined, "weyward_stinger_pat_1", undefined, undefined, undefined, undefined, 300 );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_boss_arena_stinger_cs";
    s.groupid = "pattern_3";
    fe [[ f ]]( s, us, cf, ( 1092, 2014, 32 ), ( 0, 0, 0 ), "phase_3", undefined, "weyward_stinger_pat_3", undefined, undefined, undefined, undefined, 300 );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_boss_arena_stinger_cs";
    s.groupid = "pattern_3";
    fe [[ f ]]( s, us, cf, ( 2340, 1662, 0 ), ( 0, 0, 0 ), "phase_3", undefined, "weyward_stinger_pat_3", undefined, undefined, undefined, undefined, 300 );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_boss_arena_stinger_cs";
    s.groupid = "pattern_3";
    fe [[ f ]]( s, us, cf, ( 1876, 2318, 0 ), ( 0, 0, 0 ), "phase_3", undefined, "weyward_stinger_pat_3", undefined, undefined, undefined, undefined, 300 );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_boss_arena_stinger_cs";
    s.groupid = "pattern_3";
    fe [[ f ]]( s, us, cf, ( 3172, 2014, 32 ), ( 0, 0, 0 ), "phase_3", undefined, "weyward_stinger_pat_3", undefined, undefined, undefined, undefined, 300 );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_boss_arena_stinger_cs";
    s.groupid = "pattern_3";
    fe [[ f ]]( s, us, cf, ( 2388, 2286, 0 ), ( 0, 0, 0 ), "phase_3", undefined, "weyward_stinger_pat_3", undefined, undefined, undefined, undefined, 300 );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_boss_arena_stinger_cs";
    s.groupid = "pattern_3";
    fe [[ f ]]( s, us, cf, ( 1780, 1726, 0 ), ( 0, 0, 0 ), "phase_3", undefined, "weyward_stinger_pat_3", undefined, undefined, undefined, undefined, 300 );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_boss_arena_stinger_cs";
    s.groupid = "pattern_4";
    fe [[ f ]]( s, us, cf, ( 1508, 2722, 0 ), ( 0, 0, 0 ), "phase_3", undefined, "weyward_stinger_pat_4", undefined, undefined, undefined, undefined, 300 );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_boss_arena_stinger_cs";
    s.groupid = "pattern_4";
    fe [[ f ]]( s, us, cf, ( 2124, 2764, 0 ), ( 0, 0, 0 ), "phase_3", undefined, "weyward_stinger_pat_4", undefined, undefined, undefined, undefined, 300 );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_boss_arena_stinger_cs";
    s.groupid = "pattern_4";
    fe [[ f ]]( s, us, cf, ( 2796, 2722, 0 ), ( 0, 0, 0 ), "phase_3", undefined, "weyward_stinger_pat_4", undefined, undefined, undefined, undefined, 300 );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_boss_arena_stinger_cs";
    s.groupid = "pattern_4";
    fe [[ f ]]( s, us, cf, ( 1202, 2052, 0 ), ( 0, 0, 0 ), "phase_3", undefined, "weyward_stinger_pat_4", undefined, undefined, undefined, undefined, 300 );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_boss_arena_stinger_cs";
    s.groupid = "pattern_4";
    fe [[ f ]]( s, us, cf, ( 2124, 2094, 0 ), ( 0, 0, 0 ), "phase_3", undefined, "weyward_stinger_pat_4", undefined, undefined, undefined, undefined, 300 );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_boss_arena_stinger_cs";
    s.groupid = "pattern_4";
    fe [[ f ]]( s, us, cf, ( 3128, 2052, 4 ), ( 0, 0, 0 ), "phase_3", undefined, "weyward_stinger_pat_4", undefined, undefined, undefined, undefined, 300 );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_boss_arena_stinger_cs";
    s.groupid = "pattern_4";
    fe [[ f ]]( s, us, cf, ( 1508, 1352, 0 ), ( 0, 0, 0 ), "phase_3", undefined, "weyward_stinger_pat_4", undefined, undefined, undefined, undefined, 300 );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_boss_arena_stinger_cs";
    s.groupid = "pattern_4";
    fe [[ f ]]( s, us, cf, ( 2124, 1228, 0 ), ( 0, 0, 0 ), "phase_3", undefined, "weyward_stinger_pat_4", undefined, undefined, undefined, undefined, 300 );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_boss_arena_stinger_cs";
    s.groupid = "pattern_4";
    fe [[ f ]]( s, us, cf, ( 2796, 1352, 0 ), ( 0, 0, 0 ), "phase_3", undefined, "weyward_stinger_pat_4", undefined, undefined, undefined, undefined, 300 );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_boss_arena_stinger_cs";
    s.groupid = "pattern_4";
    fe [[ f ]]( s, us, cf, ( 2449, 963, 34.35 ), ( 0, 0, 0 ), "phase_2", undefined, "weyward_stinger_pat_4", undefined, undefined, undefined, undefined, 300 );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_boss_arena_stinger_cs";
    s.groupid = "pattern_1";
    fe [[ f ]]( s, us, cf, ( 1732, 2046, 0 ), ( 0, 0, 0 ), "phase_2", undefined, "weyward_stinger_pat_1", undefined, undefined, undefined, undefined, 300 );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_boss_arena_stinger_cs";
    s.groupid = "pattern_1";
    fe [[ f ]]( s, us, cf, ( 1124, 2046, 32 ), ( 0, 0, 0 ), "phase_2", undefined, "weyward_stinger_pat_1", undefined, undefined, undefined, undefined, 300 );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_boss_arena_stinger_cs";
    s.groupid = "pattern_1";
    fe [[ f ]]( s, us, cf, ( 2500, 2030, 0 ), ( 0, 0, 0 ), "phase_2", undefined, "weyward_stinger_pat_1", undefined, undefined, undefined, undefined, 300 );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_boss_arena_stinger_cs";
    s.groupid = "pattern_5";
    fe [[ f ]]( s, us, cf, ( 3182.79, 1711.3, 32 ), ( 0, 58, 0 ), "phase_2", undefined, "weyward_stinger_pat_5", undefined, undefined, undefined, undefined, 300 );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_boss_arena_stinger_cs";
    s.groupid = "pattern_5";
    fe [[ f ]]( s, us, cf, ( 2657.79, 1201.43, 32.96 ), ( 0, 58, 0 ), "phase_2", undefined, "weyward_stinger_pat_5", undefined, undefined, undefined, undefined, 300 );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_boss_arena_stinger_cs";
    s.groupid = "pattern_1";
    fe [[ f ]]( s, us, cf, ( 3188, 1998, 32 ), ( 0, 0, 0 ), "phase_2", undefined, "weyward_stinger_pat_1", undefined, undefined, undefined, undefined, 300 );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_boss_arena_stinger_cs";
    s.groupid = "pattern_4";
    fe [[ f ]]( s, us, cf, ( 1748, 1211, 28.57 ), ( 0, 0, 0 ), "phase_2", undefined, "weyward_stinger_pat_4", undefined, undefined, undefined, undefined, 300 );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_boss_arena_stinger_cs";
    s.groupid = "pattern_2";
    fe [[ f ]]( s, us, cf, ( 2084, 1022, 32 ), ( 0, 0, 0 ), "phase_2", undefined, "weyward_stinger_pat_2", undefined, undefined, undefined, undefined, 300 );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_boss_arena_stinger_cs";
    s.groupid = "pattern_4";
    fe [[ f ]]( s, us, cf, ( 1091, 1887, 30.39 ), ( 0, 0, 0 ), "phase_2", undefined, "weyward_stinger_pat_4", undefined, undefined, undefined, undefined, 300 );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_boss_arena_stinger_cs";
    s.groupid = "pattern_4";
    fe [[ f ]]( s, us, cf, ( 1732, 1867, -14 ), ( 0, 0, 0 ), "phase_2", undefined, "weyward_stinger_pat_4", undefined, undefined, undefined, undefined, 300 );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_boss_arena_stinger_cs";
    s.groupid = "pattern_4";
    fe [[ f ]]( s, us, cf, ( 2217, 1664, -13.43 ), ( 0, 0, 0 ), "phase_2", undefined, "weyward_stinger_pat_4", undefined, undefined, undefined, undefined, 300 );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_boss_arena_stinger_cs";
    s.groupid = "pattern_2";
    fe [[ f ]]( s, us, cf, ( 2132, 2366, 0 ), ( 0, 0, 0 ), "phase_2", undefined, "weyward_stinger_pat_2", undefined, undefined, undefined, undefined, 300 );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_boss_arena_stinger_cs";
    s.groupid = "pattern_2";
    fe [[ f ]]( s, us, cf, ( 2068, 2990, 32 ), ( 0, 0, 0 ), "phase_2", undefined, "weyward_stinger_pat_2", undefined, undefined, undefined, undefined, 300 );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_boss_arena_stinger_cs";
    s.groupid = "pattern_5";
    fe [[ f ]]( s, us, cf, ( 1909.72, 1018.49, 32 ), ( 0, 58, 0 ), "phase_2", undefined, "weyward_stinger_pat_5", undefined, undefined, undefined, undefined, 300 );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_boss_arena_stinger_cs";
    s.groupid = "pattern_2";
    fe [[ f ]]( s, us, cf, ( 2084, 1614, 0 ), ( 0, 0, 0 ), "phase_2", undefined, "weyward_stinger_pat_2", undefined, undefined, undefined, undefined, 300 );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_boss_arena_stinger_cs";
    s.groupid = "pattern_3";
    fe [[ f ]]( s, us, cf, ( 2084, 1372, 10 ), ( 0, 0, 0 ), "phase_2", undefined, "weyward_stinger_pat_3", undefined, undefined, undefined, undefined, 300 );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_boss_arena_stinger_cs";
    s.groupid = "pattern_5";
    fe [[ f ]]( s, us, cf, ( 2067.26, 1582.09, -14 ), ( 0, 58, 0 ), "phase_2", undefined, "weyward_stinger_pat_5", undefined, undefined, undefined, undefined, 300 );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_boss_arena_stinger_cs";
    s.groupid = "pattern_3";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( 1406, 2046, 11.42 ), ( 0, 0, 0 ), "phase_2", undefined, "weyward_stinger_pat_3", undefined, undefined, undefined, undefined, 300 );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_boss_arena_stinger_cs";
    s.groupid = "pattern_5";
    fe [[ f ]]( s, us, cf, ( 2609.8, 1917.39, 1.75 ), ( 0, 58, 0 ), "phase_2", undefined, "weyward_stinger_pat_5", undefined, undefined, undefined, undefined, 300 );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_boss_arena_stinger_cs";
    s.groupid = "pattern_1";
    fe [[ f ]]( s, us, cf, ( 1732, 2688, 0 ), ( 0, 0, 0 ), "phase_2", undefined, "weyward_stinger_pat_1", undefined, undefined, undefined, undefined, 300 );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_boss_arena_stinger_cs";
    s.groupid = "pattern_3";
    fe [[ f ]]( s, us, cf, ( 2068, 2673, 11.54 ), ( 0, 0, 0 ), "phase_2", undefined, "weyward_stinger_pat_3", undefined, undefined, undefined, undefined, 300 );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_boss_arena_stinger_cs";
    s.groupid = "pattern_3";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( 2778, 1998, 13.08 ), ( 0, 0, 0 ), "phase_2", undefined, "weyward_stinger_pat_3", undefined, undefined, undefined, undefined, 300 );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_boss_arena_stinger_cs";
    s.groupid = "pattern_3";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( 3192, 1998, 32 ), ( 0, 0, 0 ), "phase_2", undefined, "weyward_stinger_pat_3", undefined, undefined, undefined, undefined, 300 );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_boss_arena_stinger_cs";
    s.groupid = "pattern_1";
    fe [[ f ]]( s, us, cf, ( 2500, 2672, 0 ), ( 0, 0, 0 ), "phase_2", undefined, "weyward_stinger_pat_1", undefined, undefined, undefined, undefined, 300 );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_boss_arena_stinger_cs";
    s.groupid = "pattern_2";
    fe [[ f ]]( s, us, cf, ( 2754, 2366, 0 ), ( 0, 0, 0 ), "phase_2", undefined, "weyward_stinger_pat_2", undefined, undefined, undefined, undefined, 300 );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_boss_arena_stinger_cs";
    s.groupid = "pattern_1";
    fe [[ f ]]( s, us, cf, ( 1732, 1374, 0 ), ( 0, 0, 0 ), "phase_2", undefined, "weyward_stinger_pat_1", undefined, undefined, undefined, undefined, 300 );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_boss_arena_stinger_cs";
    s.groupid = "pattern_2";
    fe [[ f ]]( s, us, cf, ( 1464, 2366, 0 ), ( 0, 0, 0 ), "phase_2", undefined, "weyward_stinger_pat_2", undefined, undefined, undefined, undefined, 300 );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_boss_arena_stinger_cs";
    s.groupid = "pattern_1";
    fe [[ f ]]( s, us, cf, ( 2500, 1358, 0 ), ( 0, 0, 0 ), "phase_2", undefined, "weyward_stinger_pat_1", undefined, undefined, undefined, undefined, 300 );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_boss_arena_stinger_cs";
    s.groupid = "pattern_2";
    fe [[ f ]]( s, us, cf, ( 2706, 1614, 0 ), ( 0, 0, 0 ), "phase_2", undefined, "weyward_stinger_pat_2", undefined, undefined, undefined, undefined, 300 );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_boss_arena_stinger_cs";
    s.groupid = "pattern_3";
    fe [[ f ]]( s, us, cf, ( 2068, 3128, 32 ), ( 0, 0, 0 ), "phase_2", undefined, "weyward_stinger_pat_3", undefined, undefined, undefined, undefined, 300 );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_boss_arena_stinger_cs";
    s.groupid = "pattern_2";
    fe [[ f ]]( s, us, cf, ( 1416, 1614, 0 ), ( 0, 0, 0 ), "phase_2", undefined, "weyward_stinger_pat_2", undefined, undefined, undefined, undefined, 300 );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_boss_arena_stinger_cs";
    s.groupid = "pattern_3";
    fe [[ f ]]( s, us, cf, ( 2084, 773, 32 ), ( 0, 0, 0 ), "phase_2", undefined, "weyward_stinger_pat_3", undefined, undefined, undefined, undefined, 300 );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_boss_arena_stinger_cs";
    s.groupid = "pattern_3";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( 1002, 2046, 32 ), ( 0, 0, 0 ), "phase_2", undefined, "weyward_stinger_pat_3", undefined, undefined, undefined, undefined, 300 );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_boss_arena_stinger_cs";
    s.groupid = "pattern_4";
    fe [[ f ]]( s, us, cf, ( 1652.16, 2974.09, 35.06 ), ( 0, 169, 0 ), "phase_2", undefined, "weyward_stinger_pat_4", undefined, undefined, undefined, undefined, 300 );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_boss_arena_stinger_cs";
    s.groupid = "pattern_4";
    fe [[ f ]]( s, us, cf, ( 2495.96, 2904.89, 35.92 ), ( 0, 169, 0 ), "phase_2", undefined, "weyward_stinger_pat_4", undefined, undefined, undefined, undefined, 300 );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_boss_arena_stinger_cs";
    s.groupid = "pattern_4";
    fe [[ f ]]( s, us, cf, ( 3011.9, 2115.95, 32 ), ( 0, 169, 0 ), "phase_2", undefined, "weyward_stinger_pat_4", undefined, undefined, undefined, undefined, 300 );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_boss_arena_stinger_cs";
    s.groupid = "pattern_4";
    fe [[ f ]]( s, us, cf, ( 2386.49, 2257.89, -14 ), ( 0, 169, 0 ), "phase_2", undefined, "weyward_stinger_pat_4", undefined, undefined, undefined, undefined, 300 );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_boss_arena_stinger_cs";
    s.groupid = "pattern_4";
    fe [[ f ]]( s, us, cf, ( 1949.14, 2549.7, 10 ), ( 0, 169, 0 ), "phase_2", undefined, "weyward_stinger_pat_4", undefined, undefined, undefined, undefined, 300 );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_boss_arena_stinger_cs";
    s.groupid = "pattern_5";
    fe [[ f ]]( s, us, cf, ( 1259.39, 2420.38, 32.69 ), ( 0, 233.4, 0 ), "phase_2", undefined, "weyward_stinger_pat_5", undefined, undefined, undefined, undefined, 300 );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_boss_arena_stinger_cs";
    s.groupid = "pattern_5";
    fe [[ f ]]( s, us, cf, ( 1823.59, 2886.51, 32.36 ), ( 0, 233.4, 0 ), "phase_2", undefined, "weyward_stinger_pat_5", undefined, undefined, undefined, undefined, 300 );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_boss_arena_stinger_cs";
    s.groupid = "pattern_5";
    fe [[ f ]]( s, us, cf, ( 2583.92, 3008.86, 37.37 ), ( 0, 233.4, 0 ), "phase_2", undefined, "weyward_stinger_pat_5", undefined, undefined, undefined, undefined, 300 );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_boss_arena_stinger_cs";
    s.groupid = "pattern_5";
    fe [[ f ]]( s, us, cf, ( 2381.68, 2459.72, 10.91 ), ( 0, 233.4, 0 ), "phase_2", undefined, "weyward_stinger_pat_5", undefined, undefined, undefined, undefined, 300 );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_boss_arena_stinger_cs";
    s.groupid = "pattern_5";
    fe [[ f ]]( s, us, cf, ( 1814, 2169, -14 ), ( 0, 233.4, 0 ), "phase_2", undefined, "weyward_stinger_pat_5", undefined, undefined, undefined, undefined, 300 );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_boss_arena_stinger_cs";
    s.groupid = "pattern_1";
    fe [[ f ]]( s, us, cf, ( 2980, 1451, 31.42 ), ( 0, 0, 0 ), "phase_2", undefined, "weyward_stinger_pat_1", undefined, undefined, undefined, undefined, 300 );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_boss_arena_stinger_cs";
    s.groupid = "pattern_1";
    fe [[ f ]]( s, us, cf, ( 1176, 2554, 28.72 ), ( 0, 0, 0 ), "phase_2", undefined, "weyward_stinger_pat_1", undefined, undefined, undefined, undefined, 300 );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_boss_arena_stinger_cs";
    s.groupid = "pattern_2";
    fe [[ f ]]( s, us, cf, ( 1507, 1156, 27.33 ), ( 0, 0, 0 ), "phase_2", undefined, "weyward_stinger_pat_2", undefined, undefined, undefined, undefined, 300 );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_boss_arena_stinger_cs";
    s.groupid = "pattern_2";
    fe [[ f ]]( s, us, cf, ( 2597, 2743, 32 ), ( 0, 0, 0 ), "phase_2", undefined, "weyward_stinger_pat_2", undefined, undefined, undefined, undefined, 300 );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_boss_arena_stinger_cs";
    s.groupid = "pattern_3";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( 1852, 2286, -13.29 ), ( 0, 0, 0 ), "phase_2", undefined, "weyward_stinger_pat_3", undefined, undefined, undefined, undefined, 300 );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_boss_arena_stinger_cs";
    s.groupid = "pattern_3";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( 2405, 1714, -10.95 ), ( 0, 0, 0 ), "phase_2", undefined, "weyward_stinger_pat_3", undefined, undefined, undefined, undefined, 300 );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_boss_arena_stinger_cs";
    s.groupid = "pattern_3";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( 2387, 2303, -14 ), ( 0, 0, 0 ), "phase_2", undefined, "weyward_stinger_pat_3", undefined, undefined, undefined, undefined, 300 );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_boss_arena_stinger_cs";
    s.groupid = "pattern_3";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( 1786, 1750, -14 ), ( 0, 0, 0 ), "phase_2", undefined, "weyward_stinger_pat_3", undefined, undefined, undefined, undefined, 300 );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace zm_sat_scarab_boss_arena_stinger_cs
// Params 0, eflags: 0x4
// Checksum 0xad3e8d69, Offset: 0x21c5
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace zm_sat_scarab_boss_arena_stinger_cs
// Params 0
// Checksum 0xe5f2f65, Offset: 0x21cf
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "zm_sat_scarab_boss_arena_stinger_cs" );
}

