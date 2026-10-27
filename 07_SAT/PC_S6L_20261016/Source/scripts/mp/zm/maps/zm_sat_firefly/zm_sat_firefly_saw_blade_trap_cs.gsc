// scripts\mp\zm\maps\zm_sat_firefly\zm_sat_firefly_saw_blade_trap_cs.gsc  (hash_0a8f09349941af75.gscc) (size: 3652 Bytes / 0xe44 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x50b90962 (1354303842)
// size ...... 3652 (0xe44)
// includes .. 3   (offset: 0xca4)
// strings ... 19  (offset: 0xcbc)
// dev strs .. 0   (offset: 0xe44)
// exports ... 9   (offset: 0x8b8)
// cseg ...... 0x21f + 0x699 (0x8b8)
// imports ... 22  (offset: 0xa20)
// animtree1 . 0   (offset: 0xe44)
// animtree2 . 0   (offset: 0xe44)
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace zm_sat_firefly_saw_blade_trap_cs;

// Namespace zm_sat_firefly_saw_blade_trap_cs
// Params 0, eflags: 0x5
// Checksum 0x2d7354a, Offset: 0x23d
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"zm_sat_firefly_saw_blade_trap_cs", undefined, &function_b39ecd3d51489472, undefined );
}

// Namespace zm_sat_firefly_saw_blade_trap_cs
// Params 0, eflags: 0x4
// Checksum 0xef4bfd01, Offset: 0x25e
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace zm_sat_firefly_saw_blade_trap_cs
// Params 0, eflags: 0x4
// Checksum 0x6a702eed, Offset: 0x26f
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace zm_sat_firefly_saw_blade_trap_cs
// Params 2
// Checksum 0xda9978a4, Offset: 0x280
// Size: 0x80
function main( unused, unused2 )
{
    if ( utility::flag_exist( "zm_sat_firefly_saw_blade_trap_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "zm_sat_firefly_saw_blade_trap_cs" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "zm_sat_firefly_saw_blade_trap_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "zm_sat_firefly_saw_blade_trap_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace zm_sat_firefly_saw_blade_trap_cs
// Params 3, eflags: 0x4
// Checksum 0xe9f29a22, Offset: 0x308
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "zm_sat_firefly_saw_blade_trap_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "zm_sat_firefly_saw_blade_trap_cs" );
}

// Namespace zm_sat_firefly_saw_blade_trap_cs
// Params 3, eflags: 0x4
// Checksum 0xf462e200, Offset: 0x382
// Size: 0x516
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "zm_sat_firefly_saw_blade_trap_cs";
    s.script_label = "sat_zm_saw_blade_trap_switch";
    fe [[ f ]]( s, us, cf, ( -11755.2, 2895.42, 544.14 ), ( 0, 36.73, 0 ), "cspf_0_auto2705621408616611156", undefined, "switch" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_saw_blade_trap_cs";
    s.script_label = "sat_zm_saw_blade_trap_switch";
    fe [[ f ]]( s, us, cf, ( 3455.27, 235.61, 530.82 ), ( 354.15, 0, 0 ), "cspf_0_auto680726397122299896", undefined, "switch" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_saw_blade_trap_cs";
    s.script_cost = int( 1000 );
    s.script_duration = float( 40 );
    s.script_power = "power_on3";
    s.script_timeout = float( 60 );
    fe [[ f ]]( s, us, cf, ( 3608.41, 397.42, 583.87 ), ( 0, 0, 0 ), "saw_blade_trap_switch", "cspf_0_auto680726397122299896", "zone_sunken_brothel_exterior", undefined, undefined, undefined, undefined, 80 );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_saw_blade_trap_cs";
    s.script_label = "sat_zm_saw_blade_trap";
    fe [[ f ]]( s, us, cf, ( 3636.95, 197.46, 491.24 ), ( 355, 0, -0 ), "cspf_0_auto680726397122299896", "cspf_0_auto14989292371882612894", "trap" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_saw_blade_trap_cs";
    s.script_label = "sat_zm_saw_blade_trap_switch";
    s.script_parameters = "no_minimap";
    fe [[ f ]]( s, us, cf, ( 3446.33, 237.74, 529.66 ), ( 3.79, 180, 0 ), "cspf_0_auto680726397122299896", undefined, "switch" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_saw_blade_trap_cs";
    s.script_cost = int( 1000 );
    s.script_duration = float( 40 );
    s.script_timeout = float( 60 );
    fe [[ f ]]( s, us, cf, ( -11693.9, 3030.4, 563.95 ), ( 0, 0, 0 ), "saw_blade_trap_switch", "cspf_0_auto2705621408616611156", undefined, undefined, undefined, undefined, undefined, 80 );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_saw_blade_trap_cs";
    s.script_label = "sat_zm_saw_blade_trap";
    fe [[ f ]]( s, us, cf, ( -11669.6, 3091.82, 487.53 ), ( 0, 0, 0 ), "cspf_0_auto2705621408616611156", "cspf_0_auto7115015175019822714", "trap" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_saw_blade_trap_cs";
    s.script_label = "sat_zm_saw_blade_trap_switch";
    fe [[ f ]]( s, us, cf, ( 14007.5, -4569.38, 617.5 ), ( 0, 44.93, 0 ), "cspf_0_auto15078538651346556228", undefined, "switch" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_saw_blade_trap_cs";
    s.script_cost = int( 1000 );
    s.script_duration = float( 40 );
    s.script_power = "power_on2";
    s.script_timeout = float( 60 );
    fe [[ f ]]( s, us, cf, ( 14071, -4507.55, 648.36 ), ( 0, 0, 0 ), "saw_blade_trap_switch", "cspf_0_auto15078538651346556228", "zone_farm", undefined, undefined, undefined, undefined, 80 );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_saw_blade_trap_cs";
    s.script_label = "sat_zm_saw_blade_trap";
    fe [[ f ]]( s, us, cf, ( 14131.2, -4414.64, 568.68 ), ( 0, 0, 0 ), "cspf_0_auto15078538651346556228", "cspf_0_auto6318708266281942297", "trap" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_saw_blade_trap_cs";
    fe [[ f ]]( s, us, cf, ( 3633.52, 197.52, 524.13 ), ( 355, 0, -0 ), "cspf_0_auto14989292371882612894" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_saw_blade_trap_cs";
    fe [[ f ]]( s, us, cf, ( 14130.7, -4414.76, 599.97 ), ( 0, 0, 0 ), "cspf_0_auto6318708266281942297" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_saw_blade_trap_cs";
    fe [[ f ]]( s, us, cf, ( -11669.4, 3092.83, 520.36 ), ( 0, 0, 0 ), "cspf_0_auto7115015175019822714" );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace zm_sat_firefly_saw_blade_trap_cs
// Params 0, eflags: 0x4
// Checksum 0x5fcc81ba, Offset: 0x8a0
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace zm_sat_firefly_saw_blade_trap_cs
// Params 0
// Checksum 0x2ba1476f, Offset: 0x8aa
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "zm_sat_firefly_saw_blade_trap_cs" );
}

