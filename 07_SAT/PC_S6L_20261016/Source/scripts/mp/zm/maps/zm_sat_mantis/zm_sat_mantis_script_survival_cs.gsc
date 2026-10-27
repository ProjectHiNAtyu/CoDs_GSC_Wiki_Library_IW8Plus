// scripts\mp\zm\maps\zm_sat_mantis\zm_sat_mantis_script_survival_cs.gsc  (hash_67b03b4d18c3c619.gscc) (size: 2176 Bytes / 0x880 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xee5fd218 (3999257112)
// size ...... 2176 (0x880)
// includes .. 3   (offset: 0x7dc)
// strings ... 6   (offset: 0x7f4)
// dev strs .. 0   (offset: 0x880)
// exports ... 9   (offset: 0x444)
// cseg ...... 0xfd + 0x347 (0x444)
// imports ... 20  (offset: 0x5ac)
// animtree1 . 0   (offset: 0x880)
// animtree2 . 0   (offset: 0x880)
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace zm_sat_mantis_script_survival_cs;

// Namespace zm_sat_mantis_script_survival_cs
// Params 0, eflags: 0x5
// Checksum 0xd72df8ab, Offset: 0x11b
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"zm_sat_mantis_script_survival_cs", undefined, &function_b39ecd3d51489472, undefined );
}

// Namespace zm_sat_mantis_script_survival_cs
// Params 0, eflags: 0x4
// Checksum 0xf25ee7db, Offset: 0x13c
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace zm_sat_mantis_script_survival_cs
// Params 0, eflags: 0x4
// Checksum 0x77653437, Offset: 0x14d
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace zm_sat_mantis_script_survival_cs
// Params 2
// Checksum 0xc78c627e, Offset: 0x15e
// Size: 0x80
function main( unused, unused2 )
{
    if ( utility::flag_exist( "zm_sat_mantis_script_survival_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "zm_sat_mantis_script_survival_cs" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "zm_sat_mantis_script_survival_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "zm_sat_mantis_script_survival_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace zm_sat_mantis_script_survival_cs
// Params 3, eflags: 0x4
// Checksum 0xf4e780f8, Offset: 0x1e6
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "zm_sat_mantis_script_survival_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "zm_sat_mantis_script_survival_cs" );
}

// Namespace zm_sat_mantis_script_survival_cs
// Params 3, eflags: 0x4
// Checksum 0x54755ce4, Offset: 0x260
// Size: 0x1c4
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_survival_cs";
    fe [[ f ]]( s, us, cf, ( 55379, -31502, -119 ), ( 0, 65, 0 ), "cspf_0_auto13162117426066871742" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_survival_cs";
    fe [[ f ]]( s, us, cf, ( 55337, -31483, -119 ), ( 0, 65, 0 ), "cspf_0_auto13162117426066871742" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_survival_cs";
    fe [[ f ]]( s, us, cf, ( 55413, -31518, -119 ), ( 0, 65, 0 ), "cspf_0_auto13162117426066871742" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_survival_cs";
    fe [[ f ]]( s, us, cf, ( 55460, -31540, -119 ), ( 0, 65, 0 ), "cspf_0_auto13162117426066871742" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_survival_cs";
    fe [[ f ]]( s, us, cf, ( 55210.7, -31644.2, -97.5 ), ( 0, 3.79, 0 ), "survival_round_accelerant_future" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_survival_cs";
    fe [[ f ]]( s, us, cf, ( 55288, -31488, -89 ), ( 0, 0, 0 ), "survival_spawn_set_future", "cspf_0_auto13162117426066871742", "survival_spawn_set_future" );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace zm_sat_mantis_script_survival_cs
// Params 0, eflags: 0x4
// Checksum 0x16e27385, Offset: 0x42c
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace zm_sat_mantis_script_survival_cs
// Params 0
// Checksum 0x36b45db5, Offset: 0x436
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "zm_sat_mantis_script_survival_cs" );
}

