// script_7c65946d99099a0e  (hash_7c65946d99099a0e.gscc) (size: 1941 Bytes / 0x795 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xfd202934 (4246743348)
// size ...... 1941 (0x795)
// includes .. 3   (offset: 0x705)
// strings ... 5   (offset: 0x71d)
// dev strs .. 0   (offset: 0x795)
// exports ... 9   (offset: 0x389)
// cseg ...... 0xbe + 0x2cb (0x389)
// imports ... 19  (offset: 0x4f1)
// animtree1 . 0   (offset: 0x795)
// animtree2 . 0   (offset: 0x795)
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace mp_sat_avalon_quad_04_ob_exfil_cs;

// Namespace mp_sat_avalon_quad_04_ob_exfil_cs
// Params 0, eflags: 0x5
// Checksum 0x42f90d34, Offset: 0xdc
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"mp_sat_avalon_quad_04_ob_exfil_cs", undefined, &function_b39ecd3d51489472, undefined );
}

// Namespace mp_sat_avalon_quad_04_ob_exfil_cs
// Params 0, eflags: 0x4
// Checksum 0x1cd8482e, Offset: 0xfd
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace mp_sat_avalon_quad_04_ob_exfil_cs
// Params 0, eflags: 0x4
// Checksum 0x99e39bc2, Offset: 0x10e
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace mp_sat_avalon_quad_04_ob_exfil_cs
// Params 2
// Checksum 0x25d0f694, Offset: 0x11f
// Size: 0x70
function main( unused, unused2 )
{
    if ( utility::flag_exist( "mp_sat_avalon_quad_04_ob_exfil_cs" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "mp_sat_avalon_quad_04_ob_exfil_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "mp_sat_avalon_quad_04_ob_exfil_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace mp_sat_avalon_quad_04_ob_exfil_cs
// Params 3, eflags: 0x4
// Checksum 0x1a612f0d, Offset: 0x197
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "mp_sat_avalon_quad_04_ob_exfil_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "mp_sat_avalon_quad_04_ob_exfil_cs" );
}

// Namespace mp_sat_avalon_quad_04_ob_exfil_cs
// Params 3, eflags: 0x4
// Checksum 0xcbfcb50c, Offset: 0x211
// Size: 0x158
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_04_ob_exfil_cs";
    fe [[ f ]]( s, us, cf, ( 34267.1, -15131.5, 212.29 ), ( 0, 0, 0 ), "ob_exfil_spawnpoint", undefined, "CHI_Q1_MS" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_04_ob_exfil_cs";
    fe [[ f ]]( s, us, cf, ( 3418.8, -30939, 1427.08 ), ( 0, 0, 0 ), "ob_exfil_spawnpoint", undefined, "CHI_Q1_MS" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_04_ob_exfil_cs";
    fe [[ f ]]( s, us, cf, ( 57520.2, -5615.84, 1587.54 ), ( 0, 0, 0 ), "ob_exfil_spawnpoint", undefined, "CHI_Q1_MS" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_04_ob_exfil_cs";
    fe [[ f ]]( s, us, cf, ( 40366.5, -48290.9, 482.19 ), ( 0, 0, 0 ), "ob_exfil_spawnpoint", undefined, "CHI_Q1_MS" );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace mp_sat_avalon_quad_04_ob_exfil_cs
// Params 0, eflags: 0x4
// Checksum 0x82a99225, Offset: 0x371
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace mp_sat_avalon_quad_04_ob_exfil_cs
// Params 0
// Checksum 0xd832f240, Offset: 0x37b
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "mp_sat_avalon_quad_04_ob_exfil_cs" );
}

