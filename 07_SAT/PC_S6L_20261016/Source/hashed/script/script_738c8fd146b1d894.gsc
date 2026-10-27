// script_738c8fd146b1d894  (hash_738c8fd146b1d894.gscc) (size: 1831 Bytes / 0x727 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xa5115b65 (2769378149)
// size ...... 1831 (0x727)
// includes .. 3   (offset: 0x6ab)
// strings ... 5   (offset: 0x6c3)
// dev strs .. 0   (offset: 0x727)
// exports ... 9   (offset: 0x313)
// cseg ...... 0xbe + 0x255 (0x313)
// imports ... 20  (offset: 0x47b)
// animtree1 . 0   (offset: 0x727)
// animtree2 . 0   (offset: 0x727)
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace mp_sat_avalon_quad_01_ob_exfil_cs;

// Namespace mp_sat_avalon_quad_01_ob_exfil_cs
// Params 0, eflags: 0x5
// Checksum 0xa66359bb, Offset: 0xdc
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"mp_sat_avalon_quad_01_ob_exfil_cs", undefined, &function_b39ecd3d51489472, undefined );
}

// Namespace mp_sat_avalon_quad_01_ob_exfil_cs
// Params 0, eflags: 0x4
// Checksum 0x406dc8d6, Offset: 0xfd
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace mp_sat_avalon_quad_01_ob_exfil_cs
// Params 0, eflags: 0x4
// Checksum 0xc5561b3a, Offset: 0x10e
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace mp_sat_avalon_quad_01_ob_exfil_cs
// Params 2
// Checksum 0x75bf4d73, Offset: 0x11f
// Size: 0x80
function main( unused, unused2 )
{
    if ( utility::flag_exist( "mp_sat_avalon_quad_01_ob_exfil_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "mp_sat_avalon_quad_01_ob_exfil_cs" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "mp_sat_avalon_quad_01_ob_exfil_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "mp_sat_avalon_quad_01_ob_exfil_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace mp_sat_avalon_quad_01_ob_exfil_cs
// Params 3, eflags: 0x4
// Checksum 0x46d4aff5, Offset: 0x1a7
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "mp_sat_avalon_quad_01_ob_exfil_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "mp_sat_avalon_quad_01_ob_exfil_cs" );
}

// Namespace mp_sat_avalon_quad_01_ob_exfil_cs
// Params 3, eflags: 0x4
// Checksum 0x92eba34c, Offset: 0x221
// Size: 0xd2
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_01_ob_exfil_cs";
    fe [[ f ]]( s, us, cf, ( -27924, 39326.1, 1810.72 ), ( 0, 0, 0 ), "ob_exfil_spawnpoint", undefined, "CHI_Q1_MS" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_01_ob_exfil_cs";
    fe [[ f ]]( s, us, cf, ( -25892.2, 4482.42, 183 ), ( 0, 0, 0 ), "ob_exfil_spawnpoint", undefined, "CHI_Q1_MS" );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace mp_sat_avalon_quad_01_ob_exfil_cs
// Params 0, eflags: 0x4
// Checksum 0xc333a1ce, Offset: 0x2fb
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace mp_sat_avalon_quad_01_ob_exfil_cs
// Params 0
// Checksum 0x848772b8, Offset: 0x305
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "mp_sat_avalon_quad_01_ob_exfil_cs" );
}

