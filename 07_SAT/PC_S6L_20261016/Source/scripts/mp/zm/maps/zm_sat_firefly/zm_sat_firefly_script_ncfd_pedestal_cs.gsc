// scripts\mp\zm\maps\zm_sat_firefly\zm_sat_firefly_script_ncfd_pedestal_cs.gsc  (hash_54964dd863a7c91b.gscc) (size: 1686 Bytes / 0x696 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x39b66e21 (968257057)
// size ...... 1686 (0x696)
// includes .. 3   (offset: 0x63e)
// strings ... 3   (offset: 0x656)
// dev strs .. 0   (offset: 0x696)
// exports ... 9   (offset: 0x2a6)
// cseg ...... 0x9f + 0x207 (0x2a6)
// imports ... 20  (offset: 0x40e)
// animtree1 . 0   (offset: 0x696)
// animtree2 . 0   (offset: 0x696)
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace zm_sat_firefly_script_ncfd_pedestal_cs;

// Namespace zm_sat_firefly_script_ncfd_pedestal_cs
// Params 0, eflags: 0x5
// Checksum 0x7f06b7cd, Offset: 0xbd
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"zm_sat_firefly_script_ncfd_pedestal_cs", undefined, &function_b39ecd3d51489472, undefined );
}

// Namespace zm_sat_firefly_script_ncfd_pedestal_cs
// Params 0, eflags: 0x4
// Checksum 0xc367b778, Offset: 0xde
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace zm_sat_firefly_script_ncfd_pedestal_cs
// Params 0, eflags: 0x4
// Checksum 0x465c6494, Offset: 0xef
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace zm_sat_firefly_script_ncfd_pedestal_cs
// Params 2
// Checksum 0xf6b532dd, Offset: 0x100
// Size: 0x80
function main( unused, unused2 )
{
    if ( utility::flag_exist( "zm_sat_firefly_script_ncfd_pedestal_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "zm_sat_firefly_script_ncfd_pedestal_cs" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "zm_sat_firefly_script_ncfd_pedestal_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "zm_sat_firefly_script_ncfd_pedestal_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace zm_sat_firefly_script_ncfd_pedestal_cs
// Params 3, eflags: 0x4
// Checksum 0xc5ded05b, Offset: 0x188
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "zm_sat_firefly_script_ncfd_pedestal_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "zm_sat_firefly_script_ncfd_pedestal_cs" );
}

// Namespace zm_sat_firefly_script_ncfd_pedestal_cs
// Params 3, eflags: 0x4
// Checksum 0x97c41f3e, Offset: 0x202
// Size: 0x84
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_ncfd_pedestal_cs";
    fe [[ f ]]( s, us, cf, ( 2848.16, -1052.29, 182.25 ), ( 0, 90.07, 0 ) );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace zm_sat_firefly_script_ncfd_pedestal_cs
// Params 0, eflags: 0x4
// Checksum 0xb378c734, Offset: 0x28e
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace zm_sat_firefly_script_ncfd_pedestal_cs
// Params 0
// Checksum 0x78d0d16, Offset: 0x298
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "zm_sat_firefly_script_ncfd_pedestal_cs" );
}

