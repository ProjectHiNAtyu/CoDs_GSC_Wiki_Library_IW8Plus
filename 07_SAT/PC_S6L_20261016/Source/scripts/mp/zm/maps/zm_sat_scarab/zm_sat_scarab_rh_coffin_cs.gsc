// scripts\mp\zm\maps\zm_sat_scarab\zm_sat_scarab_rh_coffin_cs.gsc  (hash_3e760610411d97d9.gscc) (size: 3983 Bytes / 0xf8f / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x7910862c (2031126060)
// size ...... 3983 (0xf8f)
// includes .. 3   (offset: 0xd4f)
// strings ... 28  (offset: 0xd67)
// dev strs .. 0   (offset: 0xf8f)
// exports ... 9   (offset: 0x9b7)
// cseg ...... 0x192 + 0x825 (0x9b7)
// imports ... 20  (offset: 0xb1f)
// animtree1 . 0   (offset: 0xf8f)
// animtree2 . 0   (offset: 0xf8f)
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace zm_sat_scarab_rh_coffin_cs;

// Namespace zm_sat_scarab_rh_coffin_cs
// Params 0, eflags: 0x5
// Checksum 0xddac9969, Offset: 0x1b0
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"zm_sat_scarab_rh_coffin_cs", undefined, &function_b39ecd3d51489472, undefined );
}

// Namespace zm_sat_scarab_rh_coffin_cs
// Params 0, eflags: 0x4
// Checksum 0xa23a7e2b, Offset: 0x1d1
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace zm_sat_scarab_rh_coffin_cs
// Params 0, eflags: 0x4
// Checksum 0x2701adc7, Offset: 0x1e2
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace zm_sat_scarab_rh_coffin_cs
// Params 2
// Checksum 0x97e8fb8e, Offset: 0x1f3
// Size: 0x80
function main( unused, unused2 )
{
    if ( utility::flag_exist( "zm_sat_scarab_rh_coffin_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "zm_sat_scarab_rh_coffin_cs" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "zm_sat_scarab_rh_coffin_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "zm_sat_scarab_rh_coffin_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace zm_sat_scarab_rh_coffin_cs
// Params 3, eflags: 0x4
// Checksum 0xa4831908, Offset: 0x27b
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "zm_sat_scarab_rh_coffin_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "zm_sat_scarab_rh_coffin_cs" );
}

// Namespace zm_sat_scarab_rh_coffin_cs
// Params 3, eflags: 0x4
// Checksum 0xc8638636, Offset: 0x2f5
// Size: 0x6a2
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "zm_sat_scarab_rh_coffin_cs";
    fe [[ f ]]( s, us, cf, ( 247, -3978.93, 1972.01 ), ( 0, 91.1, -4.98 ), "bird", undefined, "2" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_rh_coffin_cs";
    fe [[ f ]]( s, us, cf, ( 248.25, -3954.55, 1970.53 ), ( 5.88, 90.5, 0.04 ), "bird", undefined, "3" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_rh_coffin_cs";
    fe [[ f ]]( s, us, cf, ( 244.12, -3959.98, 1956.77 ), ( 6.85, 17.56, -6.22 ), "bird", "bird", "4" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_rh_coffin_cs";
    fe [[ f ]]( s, us, cf, ( 246.76, -3981.79, 1958.85 ), ( 5.78, 90.5, 4.86 ), "bird", undefined, "5" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_rh_coffin_cs";
    fe [[ f ]]( s, us, cf, ( 246.38, -4003.6, 1961.27 ), ( 5.33, 92.69, 3.73 ), "bird", undefined, "6" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_rh_coffin_cs";
    s.groupid = "box_spline";
    fe [[ f ]]( s, us, cf, ( 351.76, -3453.82, 1687.96 ), ( 0, 202, 0 ), "cspf_0_auto2436210304038133193", undefined, "tb_final" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_rh_coffin_cs";
    s.groupid = "box_spline";
    fe [[ f ]]( s, us, cf, ( 429.7, -3421.65, 1948.88 ), ( 0, 18.8, 0 ), "tb_roll", "cspf_0_auto2436210304038133193", "tb_roll" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_rh_coffin_cs";
    fe [[ f ]]( s, us, cf, ( -1853.05, -1907.44, 1058.64 ), ( 359.29, 2.3, 91.36 ), "ll_rh" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_rh_coffin_cs";
    fe [[ f ]]( s, us, cf, ( -278.55, -1576.67, 2276.76 ), ( 0, 0, 0 ), "pin_2_m" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_rh_coffin_cs";
    fe [[ f ]]( s, us, cf, ( -2185.49, -1837.69, 2860.76 ), ( 0, 0, 0 ), "pin_1_m" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_rh_coffin_cs";
    s.groupid = "pin";
    s.string_int = "2";
    fe [[ f ]]( s, us, cf, ( 4170.18, 569.52, 2019.14 ), ( 0, 333.2, 0 ), "pn_rh", "pn_2_rh", "pn_rh_2" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_rh_coffin_cs";
    s.groupid = "pin";
    s.string_int = "1";
    fe [[ f ]]( s, us, cf, ( 461.9, 2637.16, 2167.07 ), ( 0, 353.7, 0 ), "pn_rh", "pn_1_rh", "pn_rh_1" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_rh_coffin_cs";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( 248.05, -4004.22, 1976.07 ), ( 354.48, 279.21, -4.97 ), "bird", undefined, "1" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_rh_coffin_cs";
    s.groupid = "pin";
    fe [[ f ]]( s, us, cf, ( 4224.09, 533.25, 1591.73 ), ( 0, 268.1, 0 ), "pn_2_rh" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_rh_coffin_cs";
    s.groupid = "pin";
    fe [[ f ]]( s, us, cf, ( 453.66, 2686.85, 1811.25 ), ( 0, 353.7, 0 ), "pn_1_rh" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_rh_coffin_cs";
    s.groupid = "pin";
    fe [[ f ]]( s, us, cf, ( -5224.67, 451.21, 1643.61 ), ( 0, 0, 0 ), "pn_0_rh" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_rh_coffin_cs";
    s.groupid = "pin";
    s.string_int = "0";
    fe [[ f ]]( s, us, cf, ( -5191.01, 607.58, 1979.6 ), ( 0, 0, 0 ), "pn_rh", "pn_0_rh", "pn_rh_0" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_rh_coffin_cs";
    s.groupid = "pin";
    fe [[ f ]]( s, us, cf, ( 4223.61, 511.58, 1857.68 ), ( 0, 333.2, 0 ), "pn_rh_2" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_rh_coffin_cs";
    s.groupid = "pin";
    fe [[ f ]]( s, us, cf, ( -5213.23, 487.66, 1868.29 ), ( 0, 356.53, 0 ), "pn_rh_0" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_rh_coffin_cs";
    s.groupid = "pin";
    fe [[ f ]]( s, us, cf, ( 461.65, 2708.07, 2016.29 ), ( 0, 353.7, 0 ), "pn_rh_1" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_rh_coffin_cs";
    fe [[ f ]]( s, us, cf, ( 820.11, -2547.5, 2370.76 ), ( 0, 0, 0 ), "pin_3_m" );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace zm_sat_scarab_rh_coffin_cs
// Params 0, eflags: 0x4
// Checksum 0x1914c4cb, Offset: 0x99f
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace zm_sat_scarab_rh_coffin_cs
// Params 0
// Checksum 0x66d0c445, Offset: 0x9a9
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "zm_sat_scarab_rh_coffin_cs" );
}

