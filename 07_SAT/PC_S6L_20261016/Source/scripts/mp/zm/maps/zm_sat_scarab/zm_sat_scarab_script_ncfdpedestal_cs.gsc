// scripts\mp\zm\maps\zm_sat_scarab\zm_sat_scarab_script_ncfdpedestal_cs.gsc  (hash_005652578d3cbe2e.gscc) (size: 3493 Bytes / 0xda5 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x43988069 (1134067817)
// size ...... 3493 (0xda5)
// includes .. 3   (offset: 0xbb9)
// strings ... 24  (offset: 0xbd1)
// dev strs .. 0   (offset: 0xda5)
// exports ... 9   (offset: 0x821)
// cseg ...... 0x116 + 0x70b (0x821)
// imports ... 20  (offset: 0x989)
// animtree1 . 0   (offset: 0xda5)
// animtree2 . 0   (offset: 0xda5)
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace zm_sat_scarab_script_ncfdpedestal_cs;

// Namespace zm_sat_scarab_script_ncfdpedestal_cs
// Params 0, eflags: 0x5
// Checksum 0xcf71c832, Offset: 0x134
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"zm_sat_scarab_script_ncfdpedestal_cs", undefined, &function_b39ecd3d51489472, undefined );
}

// Namespace zm_sat_scarab_script_ncfdpedestal_cs
// Params 0, eflags: 0x4
// Checksum 0xa6e7ddc7, Offset: 0x155
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace zm_sat_scarab_script_ncfdpedestal_cs
// Params 0, eflags: 0x4
// Checksum 0x23dc0e2b, Offset: 0x166
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace zm_sat_scarab_script_ncfdpedestal_cs
// Params 2
// Checksum 0x93355862, Offset: 0x177
// Size: 0x80
function main( unused, unused2 )
{
    if ( utility::flag_exist( "zm_sat_scarab_script_ncfdpedestal_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "zm_sat_scarab_script_ncfdpedestal_cs" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "zm_sat_scarab_script_ncfdpedestal_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "zm_sat_scarab_script_ncfdpedestal_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace zm_sat_scarab_script_ncfdpedestal_cs
// Params 3, eflags: 0x4
// Checksum 0xa05ebae4, Offset: 0x1ff
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "zm_sat_scarab_script_ncfdpedestal_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "zm_sat_scarab_script_ncfdpedestal_cs" );
}

// Namespace zm_sat_scarab_script_ncfdpedestal_cs
// Params 3, eflags: 0x4
// Checksum 0x769282f0, Offset: 0x279
// Size: 0x588
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_ncfdpedestal_cs";
    fe [[ f ]]( s, us, cf, ( -31.18, -1942.9, 1312 ), ( 0, 85.5, 0 ), "np_loc", undefined, "1" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_ncfdpedestal_cs";
    fe [[ f ]]( s, us, cf, ( -2290.07, 3803.16, 1608.12 ), ( 0, 316.8, 0 ), "np_loc", undefined, "20" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_ncfdpedestal_cs";
    fe [[ f ]]( s, us, cf, ( -5026.33, -2363.82, 1488.18 ), ( 0, 270.4, 0 ), "np_loc", undefined, "2" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_ncfdpedestal_cs";
    fe [[ f ]]( s, us, cf, ( -3414.5, 2437.43, 1584.32 ), ( 0, 0, 0 ), "np_loc", undefined, "3" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_ncfdpedestal_cs";
    fe [[ f ]]( s, us, cf, ( 3007.69, 2172.96, 1638.05 ), ( 0, 45.3, 0 ), "np_loc", undefined, "4" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_ncfdpedestal_cs";
    fe [[ f ]]( s, us, cf, ( 1320.03, 3216.09, 1855.68 ), ( 0, 0, 0 ), "np_loc", undefined, "5" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_ncfdpedestal_cs";
    fe [[ f ]]( s, us, cf, ( 3597.54, 679.69, 1783.6 ), ( 0, 0, 0 ), "np_loc", undefined, "6" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_ncfdpedestal_cs";
    fe [[ f ]]( s, us, cf, ( -4827.83, 769.68, 1706.43 ), ( 0, 323.62, 0 ), "np_loc", undefined, "7" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_ncfdpedestal_cs";
    fe [[ f ]]( s, us, cf, ( 30192.5, 31750.2, 1568 ), ( 0, 298.3, 0 ), "np_loc", undefined, "8" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_ncfdpedestal_cs";
    fe [[ f ]]( s, us, cf, ( 3956.54, -1729.81, 1306.85 ), ( 0, 0, 0 ), "np_loc", undefined, "9" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_ncfdpedestal_cs";
    fe [[ f ]]( s, us, cf, ( -0.19, -1715.4, 974 ), ( 0, 89.5, 0 ), "np_loc", undefined, "10" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_ncfdpedestal_cs";
    fe [[ f ]]( s, us, cf, ( -32.19, 57.1, 1312 ), ( 0, 85.5, 0 ), "np_loc", undefined, "11" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_ncfdpedestal_cs";
    fe [[ f ]]( s, us, cf, ( -868.19, 1575.61, 1648.12 ), ( 0, 118.8, 0 ), "np_loc", undefined, "12" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_ncfdpedestal_cs";
    fe [[ f ]]( s, us, cf, ( 2521.84, 3142.18, 1814 ), ( 0, 44.8, 0 ), "np_loc", undefined, "13" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_ncfdpedestal_cs";
    fe [[ f ]]( s, us, cf, ( 2761.32, 711.65, 1686.2 ), ( 0, 74.8, 0 ), "np_loc", undefined, "14" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_ncfdpedestal_cs";
    fe [[ f ]]( s, us, cf, ( 3762.93, -462.84, 1595 ), ( 0, 0, 0 ), "np_loc", undefined, "15" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_ncfdpedestal_cs";
    fe [[ f ]]( s, us, cf, ( -6291.94, -800.91, 1615.5 ), ( 0, 0, 0 ), "np_loc", undefined, "16" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_ncfdpedestal_cs";
    fe [[ f ]]( s, us, cf, ( -3978.5, 1607.43, 1512.32 ), ( 0, 45, 0 ), "np_loc", undefined, "17" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_ncfdpedestal_cs";
    fe [[ f ]]( s, us, cf, ( 1661.44, 1877.61, 1678.9 ), ( 0, 264.8, 0 ), "np_loc", undefined, "18" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_ncfdpedestal_cs";
    fe [[ f ]]( s, us, cf, ( 30239.5, 29627.2, 1569.03 ), ( 0, 59.89, 0 ), "np_loc", undefined, "19" );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace zm_sat_scarab_script_ncfdpedestal_cs
// Params 0, eflags: 0x4
// Checksum 0x7093a1e4, Offset: 0x809
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace zm_sat_scarab_script_ncfdpedestal_cs
// Params 0
// Checksum 0x620d67a9, Offset: 0x813
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "zm_sat_scarab_script_ncfdpedestal_cs" );
}

