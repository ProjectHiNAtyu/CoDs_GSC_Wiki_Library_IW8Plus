// script_2241f62deb36a7f0  (hash_2241f62deb36a7f0.gscc) (size: 1783 Bytes / 0x6f7 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x3a79db9b (981064603)
// size ...... 1783 (0x6f7)
// includes .. 3   (offset: 0x67f)
// strings ... 5   (offset: 0x697)
// dev strs .. 0   (offset: 0x6f7)
// exports ... 9   (offset: 0x303)
// cseg ...... 0xbe + 0x245 (0x303)
// imports ... 19  (offset: 0x46b)
// animtree1 . 0   (offset: 0x6f7)
// animtree2 . 0   (offset: 0x6f7)
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace mp_sat_avalon_quad_03_ob_exfil_cs;

// Namespace mp_sat_avalon_quad_03_ob_exfil_cs
// Params 0, eflags: 0x5
// Checksum 0xd5b984b4, Offset: 0xdc
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"mp_sat_avalon_quad_03_ob_exfil_cs", undefined, &function_b39ecd3d51489472, undefined );
}

// Namespace mp_sat_avalon_quad_03_ob_exfil_cs
// Params 0, eflags: 0x4
// Checksum 0x7f2d263f, Offset: 0xfd
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace mp_sat_avalon_quad_03_ob_exfil_cs
// Params 0, eflags: 0x4
// Checksum 0xfa16f5d3, Offset: 0x10e
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace mp_sat_avalon_quad_03_ob_exfil_cs
// Params 2
// Checksum 0x3b569edd, Offset: 0x11f
// Size: 0x70
function main( unused, unused2 )
{
    if ( utility::flag_exist( "mp_sat_avalon_quad_03_ob_exfil_cs" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "mp_sat_avalon_quad_03_ob_exfil_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "mp_sat_avalon_quad_03_ob_exfil_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace mp_sat_avalon_quad_03_ob_exfil_cs
// Params 3, eflags: 0x4
// Checksum 0x7994411c, Offset: 0x197
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "mp_sat_avalon_quad_03_ob_exfil_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "mp_sat_avalon_quad_03_ob_exfil_cs" );
}

// Namespace mp_sat_avalon_quad_03_ob_exfil_cs
// Params 3, eflags: 0x4
// Checksum 0xae0d56bc, Offset: 0x211
// Size: 0xd2
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_exfil_cs";
    fe [[ f ]]( s, us, cf, ( -22233.8, -46164, 381.95 ), ( 0, 0, 0 ), "ob_exfil_spawnpoint", undefined, "CHI_Q1_MS" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_exfil_cs";
    fe [[ f ]]( s, us, cf, ( -30099, -23220.6, 1151.5 ), ( 0, 0, 0 ), "ob_exfil_spawnpoint", undefined, "CHI_Q1_MS" );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace mp_sat_avalon_quad_03_ob_exfil_cs
// Params 0, eflags: 0x4
// Checksum 0x9c2ffa6c, Offset: 0x2eb
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace mp_sat_avalon_quad_03_ob_exfil_cs
// Params 0
// Checksum 0xbbc79c51, Offset: 0x2f5
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "mp_sat_avalon_quad_03_ob_exfil_cs" );
}

