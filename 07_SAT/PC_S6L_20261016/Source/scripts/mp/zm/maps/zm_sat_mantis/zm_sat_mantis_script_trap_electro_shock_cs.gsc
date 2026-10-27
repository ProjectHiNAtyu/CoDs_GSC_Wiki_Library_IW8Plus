// scripts\mp\zm\maps\zm_sat_mantis\zm_sat_mantis_script_trap_electro_shock_cs.gsc  (hash_7582bbbaf55d0abc.gscc) (size: 5089 Bytes / 0x13e1 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xf9f08ebc (4193291964)
// size ...... 5089 (0x13e1)
// includes .. 3   (offset: 0x114d)
// strings ... 27  (offset: 0x1165)
// dev strs .. 0   (offset: 0x13e1)
// exports ... 9   (offset: 0xdb5)
// cseg ...... 0x306 + 0xaaf (0xdb5)
// imports ... 20  (offset: 0xf1d)
// animtree1 . 0   (offset: 0x13e1)
// animtree2 . 0   (offset: 0x13e1)
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace zm_sat_mantis_script_trap_electro_shock_cs;

// Namespace zm_sat_mantis_script_trap_electro_shock_cs
// Params 0, eflags: 0x5
// Checksum 0x41ec38c1, Offset: 0x324
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"zm_sat_mantis_script_trap_electro_shock_cs", undefined, &function_b39ecd3d51489472, undefined );
}

// Namespace zm_sat_mantis_script_trap_electro_shock_cs
// Params 0, eflags: 0x4
// Checksum 0x386d1a8c, Offset: 0x345
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace zm_sat_mantis_script_trap_electro_shock_cs
// Params 0, eflags: 0x4
// Checksum 0xbd56c960, Offset: 0x356
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace zm_sat_mantis_script_trap_electro_shock_cs
// Params 2
// Checksum 0xdbf9f29, Offset: 0x367
// Size: 0x80
function main( unused, unused2 )
{
    if ( utility::flag_exist( "zm_sat_mantis_script_trap_electro_shock_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "zm_sat_mantis_script_trap_electro_shock_cs" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "zm_sat_mantis_script_trap_electro_shock_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "zm_sat_mantis_script_trap_electro_shock_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace zm_sat_mantis_script_trap_electro_shock_cs
// Params 3, eflags: 0x4
// Checksum 0x3ed47daf, Offset: 0x3ef
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "zm_sat_mantis_script_trap_electro_shock_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "zm_sat_mantis_script_trap_electro_shock_cs" );
}

// Namespace zm_sat_mantis_script_trap_electro_shock_cs
// Params 3, eflags: 0x4
// Checksum 0x22b05aa5, Offset: 0x469
// Size: 0x92c
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_trap_electro_shock_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s._size_max = ( 116, 52, 82 );
    s._size_min = ( 16, -42, 32 );
    s.groupid = "trap_yellow_house_future";
    s.height = 128;
    s.length = "128";
    s.width = "128";
    fe [[ f ]]( s, us, cf, ( 56360.2, -31426.7, -92 ), ( 0, 59, 0 ), "cspf_0_auto11869573421616909523" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_trap_electro_shock_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s._size_max = ( 102, 52, 82 );
    s._size_min = ( 10, -42, 32 );
    s.groupid = "trap_green_house_future";
    s.height = 128;
    s.length = "128";
    s.width = "128";
    fe [[ f ]]( s, us, cf, ( 55226, -30390, -96 ), ( 0, 25, 0 ), "cspf_0_auto16641460998807935083" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_trap_electro_shock_cs";
    s.groupid = "trap_yellow_house_future";
    s.script_cost = "1000";
    s.script_duration = "40";
    s.script_timeout = "60";
    fe [[ f ]]( s, us, cf, ( 56355, -31367.5, -20.05 ), ( 0, 300, 0 ), "electro_shock_trap_garage_switch", "cspf_0_auto16359047728348036150", undefined, undefined, undefined, undefined, undefined, 80 );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_trap_electro_shock_cs";
    s.groupid = "trap_yellow_house_future";
    s.script_label = "sat_zm_electro_shock_trap_switch";
    fe [[ f ]]( s, us, cf, ( 56435, -31519.6, -66 ), ( 0, 60, 0 ), "cspf_0_auto16359047728348036150", undefined, "switch" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_trap_electro_shock_cs";
    s.groupid = "trap_yellow_house_future";
    s.name = "script_struct";
    s.script_label = "sat_zm_electro_shock_trap_garage";
    fe [[ f ]]( s, us, cf, ( 56342.2, -31357.4, -5.5 ), ( 0, 330.1, 0 ), "cspf_0_auto16359047728348036150", "cspf_0_auto11869573421616909523", "trap" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_trap_electro_shock_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s._size_max = ( 116, 52, 82 );
    s._size_min = ( 16, -42, 32 );
    s.groupid = "trap_yellow_house_past";
    s.height = 128;
    s.length = "128";
    s.width = "128";
    fe [[ f ]]( s, us, cf, ( 78889.2, -31425.7, -92 ), ( 0, 59, 0 ), "cspf_0_auto3981115834053123060" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_trap_electro_shock_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s._size_max = ( 102, 52, 82 );
    s._size_min = ( 10, -42, 32 );
    s.groupid = "trap_green_house_past";
    s.height = 128;
    s.length = "128";
    s.width = "128";
    fe [[ f ]]( s, us, cf, ( 77754, -30390, -96 ), ( 0, 25, 0 ), "cspf_0_auto3452035179380665817" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_trap_electro_shock_cs";
    s.groupid = "trap_yellow_house_past";
    s.script_cost = "1000";
    s.script_duration = "40";
    s.script_timeout = "60";
    fe [[ f ]]( s, us, cf, ( 78884, -31366.5, -20.05 ), ( 0, 300, 0 ), "electro_shock_trap_garage_switch", "cspf_0_auto16955117040347020630", undefined, undefined, undefined, undefined, undefined, 80 );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_trap_electro_shock_cs";
    s.groupid = "trap_yellow_house_past";
    s.script_label = "sat_zm_electro_shock_trap_switch";
    fe [[ f ]]( s, us, cf, ( 78963, -31518.6, -65 ), ( 0, 60, 0 ), "cspf_0_auto16955117040347020630", undefined, "switch" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_trap_electro_shock_cs";
    s.groupid = "trap_yellow_house_past";
    s.name = "script_struct";
    s.script_label = "sat_zm_electro_shock_trap_garage";
    fe [[ f ]]( s, us, cf, ( 78870.8, -31356.7, -5.5 ), ( 0, 330.1, 0 ), "cspf_0_auto16955117040347020630", "cspf_0_auto3981115834053123060", "trap" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_trap_electro_shock_cs";
    s.groupid = "trap_green_house_past";
    s.script_cost = "1000";
    s.script_duration = "40";
    s.script_timeout = "60";
    fe [[ f ]]( s, us, cf, ( 77787.6, -30359.5, -46.05 ), ( 0, 270, 0 ), "electro_shock_trap_switch", "cspf_0_auto10017437726728451438", undefined, undefined, undefined, undefined, undefined, 80 );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_trap_electro_shock_cs";
    s.groupid = "trap_green_house_past";
    s.script_label = "sat_zm_electro_shock_trap_switch";
    fe [[ f ]]( s, us, cf, ( 77717, -30361, -68 ), ( 0, 296, 0 ), "cspf_0_auto10017437726728451438", undefined, "switch" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_trap_electro_shock_cs";
    s.groupid = "trap_green_house_future";
    s.script_cost = "1000";
    s.script_duration = "40";
    s.script_timeout = "60";
    fe [[ f ]]( s, us, cf, ( 55259.6, -30359.5, -46.05 ), ( 0, 270, 0 ), "electro_shock_trap_switch", "cspf_0_auto7227051555658003276", undefined, undefined, undefined, undefined, undefined, 80 );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_trap_electro_shock_cs";
    s.groupid = "trap_green_house_future";
    s.script_label = "sat_zm_electro_shock_trap_switch";
    fe [[ f ]]( s, us, cf, ( 55183, -30363, -68 ), ( 0, 296, 0 ), "cspf_0_auto7227051555658003276", undefined, "switch" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_trap_electro_shock_cs";
    s.groupid = "trap_green_house_past";
    s.name = "script_struct";
    s.script_label = "sat_zm_electro_shock_trap";
    fe [[ f ]]( s, us, cf, ( 77777, -30327.5, -21.5 ), ( 0, 295, 0 ), "cspf_0_auto10017437726728451438", "cspf_0_auto3452035179380665817", "trap" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_trap_electro_shock_cs";
    s.groupid = "trap_green_house_future";
    s.name = "script_struct";
    s.script_label = "sat_zm_electro_shock_trap";
    fe [[ f ]]( s, us, cf, ( 55249.5, -30328, -21.5 ), ( 0, 295, 0 ), "cspf_0_auto7227051555658003276", "cspf_0_auto16641460998807935083", "trap" );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace zm_sat_mantis_script_trap_electro_shock_cs
// Params 0, eflags: 0x4
// Checksum 0x99d4b344, Offset: 0xd9d
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace zm_sat_mantis_script_trap_electro_shock_cs
// Params 0
// Checksum 0xfc87a0e2, Offset: 0xda7
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "zm_sat_mantis_script_trap_electro_shock_cs" );
}

