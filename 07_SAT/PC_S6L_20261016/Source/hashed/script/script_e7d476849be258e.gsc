// script_e7d476849be258e  (hash_0e7d476849be258e.gscc) (size: 1941 Bytes / 0x795 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x97e647a8 (2548451240)
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

#namespace mp_sat_avalon_quad_02_ob_exfil_cs;

// Namespace mp_sat_avalon_quad_02_ob_exfil_cs
// Params 0, eflags: 0x5
// Checksum 0xf38c5415, Offset: 0xdc
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"mp_sat_avalon_quad_02_ob_exfil_cs", undefined, &function_b39ecd3d51489472, undefined );
}

// Namespace mp_sat_avalon_quad_02_ob_exfil_cs
// Params 0, eflags: 0x4
// Checksum 0x5dfb6989, Offset: 0xfd
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace mp_sat_avalon_quad_02_ob_exfil_cs
// Params 0, eflags: 0x4
// Checksum 0xd8c0ba65, Offset: 0x10e
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace mp_sat_avalon_quad_02_ob_exfil_cs
// Params 2
// Checksum 0xc41608ee, Offset: 0x11f
// Size: 0x70
function main( unused, unused2 )
{
    if ( utility::flag_exist( "mp_sat_avalon_quad_02_ob_exfil_cs" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "mp_sat_avalon_quad_02_ob_exfil_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "mp_sat_avalon_quad_02_ob_exfil_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace mp_sat_avalon_quad_02_ob_exfil_cs
// Params 3, eflags: 0x4
// Checksum 0x5b420eaa, Offset: 0x197
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "mp_sat_avalon_quad_02_ob_exfil_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "mp_sat_avalon_quad_02_ob_exfil_cs" );
}

// Namespace mp_sat_avalon_quad_02_ob_exfil_cs
// Params 3, eflags: 0x4
// Checksum 0xa3f6df0, Offset: 0x211
// Size: 0x158
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_02_ob_exfil_cs";
    fe [[ f ]]( s, us, cf, ( 19807.4, -1563.47, 2865.48 ), ( 0, 0, 0 ), "ob_exfil_spawnpoint", undefined, "CHI_Q1_MS" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_02_ob_exfil_cs";
    fe [[ f ]]( s, us, cf, ( 38655.1, 19666.2, 612.62 ), ( 0, 0, 0 ), "ob_exfil_spawnpoint", undefined, "CHI_Q1_MS" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_02_ob_exfil_cs";
    fe [[ f ]]( s, us, cf, ( 27957.3, 43138.5, 1139.46 ), ( 0, 0, 0 ), "ob_exfil_spawnpoint", undefined, "CHI_Q1_MS" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_02_ob_exfil_cs";
    fe [[ f ]]( s, us, cf, ( 5132.06, 30330.7, 1779.9 ), ( 0, 0, 0 ), "ob_exfil_spawnpoint", undefined, "CHI_Q1_MS" );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace mp_sat_avalon_quad_02_ob_exfil_cs
// Params 0, eflags: 0x4
// Checksum 0x636f6c5f, Offset: 0x371
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace mp_sat_avalon_quad_02_ob_exfil_cs
// Params 0
// Checksum 0x9911d3e7, Offset: 0x37b
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "mp_sat_avalon_quad_02_ob_exfil_cs" );
}

