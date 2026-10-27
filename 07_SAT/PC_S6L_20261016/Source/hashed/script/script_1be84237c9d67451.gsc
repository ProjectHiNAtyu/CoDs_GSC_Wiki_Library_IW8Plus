// script_1be84237c9d67451  (hash_1be84237c9d67451.gscc) (size: 3623 Bytes / 0xe27 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x61b2a883 (1639098499)
// size ...... 3623 (0xe27)
// includes .. 3   (offset: 0xca7)
// strings ... 5   (offset: 0xcbf)
// dev strs .. 0   (offset: 0xe27)
// exports ... 9   (offset: 0x92b)
// cseg ...... 0xbe + 0x86d (0x92b)
// imports ... 19  (offset: 0xa93)
// animtree1 . 0   (offset: 0xe27)
// animtree2 . 0   (offset: 0xe27)
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace mp_sat_avalon_quad_03_ob_pvp_spawns_cs;

// Namespace mp_sat_avalon_quad_03_ob_pvp_spawns_cs
// Params 0, eflags: 0x5
// Checksum 0x468de6cd, Offset: 0xdc
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"mp_sat_avalon_quad_03_ob_pvp_spawns_cs", undefined, &function_b39ecd3d51489472, undefined );
}

// Namespace mp_sat_avalon_quad_03_ob_pvp_spawns_cs
// Params 0, eflags: 0x4
// Checksum 0x4677272f, Offset: 0xfd
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace mp_sat_avalon_quad_03_ob_pvp_spawns_cs
// Params 0, eflags: 0x4
// Checksum 0xc34cf4c3, Offset: 0x10e
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace mp_sat_avalon_quad_03_ob_pvp_spawns_cs
// Params 2
// Checksum 0xec50f6d2, Offset: 0x11f
// Size: 0x70
function main( unused, unused2 )
{
    if ( utility::flag_exist( "mp_sat_avalon_quad_03_ob_pvp_spawns_cs" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "mp_sat_avalon_quad_03_ob_pvp_spawns_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "mp_sat_avalon_quad_03_ob_pvp_spawns_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace mp_sat_avalon_quad_03_ob_pvp_spawns_cs
// Params 3, eflags: 0x4
// Checksum 0x40ce400c, Offset: 0x197
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "mp_sat_avalon_quad_03_ob_pvp_spawns_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "mp_sat_avalon_quad_03_ob_pvp_spawns_cs" );
}

// Namespace mp_sat_avalon_quad_03_ob_pvp_spawns_cs
// Params 3, eflags: 0x4
// Checksum 0x931654f9, Offset: 0x211
// Size: 0x6fa
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_pvp_spawns_cs";
    s.name = "pvp_spawn";
    s.variantname = "content_struct";
    fe [[ f ]]( s, us, cf, ( -19009, -42331, 558 ), ( 0, 0, 0 ), "pvp_spawn" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_pvp_spawns_cs";
    s.name = "pvp_spawn";
    s.variantname = "content_struct";
    fe [[ f ]]( s, us, cf, ( -15386.9, -22554.4, 429.3 ), ( 0, 0, 0 ), "pvp_spawn" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_pvp_spawns_cs";
    s.name = "pvp_spawn";
    s.variantname = "content_struct";
    fe [[ f ]]( s, us, cf, ( -33565, -33104, 677 ), ( 0, 0, 0 ), "pvp_spawn" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_pvp_spawns_cs";
    s.name = "pvp_spawn";
    s.variantname = "content_struct";
    fe [[ f ]]( s, us, cf, ( -31887, -22931, 806 ), ( 0, 0, 0 ), "pvp_spawn" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_pvp_spawns_cs";
    s.name = "pvp_spawn";
    s.variantname = "content_struct";
    fe [[ f ]]( s, us, cf, ( -36630.7, -16430.6, 386.5 ), ( 0, 0, 0 ), "pvp_spawn" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_pvp_spawns_cs";
    s.name = "pvp_spawn";
    s.variantname = "content_struct";
    fe [[ f ]]( s, us, cf, ( -37463, -40284, 1068 ), ( 0, 0, 0 ), "pvp_spawn" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_pvp_spawns_cs";
    s.name = "pvp_spawn";
    s.variantname = "content_struct";
    fe [[ f ]]( s, us, cf, ( -44482, -24543, 380 ), ( 0, 0, 0 ), "pvp_spawn" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_pvp_spawns_cs";
    s.name = "pvp_spawn";
    s.variantname = "content_struct";
    fe [[ f ]]( s, us, cf, ( -23986, -49228, 138 ), ( 0, 0, 0 ), "pvp_spawn" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_pvp_spawns_cs";
    s.name = "pvp_spawn";
    s.variantname = "content_struct";
    fe [[ f ]]( s, us, cf, ( -31884.3, -12416.7, 119.7 ), ( 0, 0, 0 ), "pvp_spawn" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_pvp_spawns_cs";
    s.name = "pvp_spawn";
    s.variantname = "content_struct";
    fe [[ f ]]( s, us, cf, ( -22195, -30673, 670 ), ( 0, 0, 0 ), "pvp_spawn" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_pvp_spawns_cs";
    s.name = "pvp_spawn";
    s.variantname = "content_struct";
    fe [[ f ]]( s, us, cf, ( -30223, -54746, 491 ), ( 0, 0, 0 ), "pvp_spawn" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_pvp_spawns_cs";
    s.name = "pvp_spawn";
    s.variantname = "content_struct";
    fe [[ f ]]( s, us, cf, ( -26127.5, -13773.6, 932.2 ), ( 0, 0, 0 ), "pvp_spawn" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_pvp_spawns_cs";
    s.name = "pvp_spawn";
    s.variantname = "content_struct";
    fe [[ f ]]( s, us, cf, ( -48936, -15376, 85 ), ( 0, 0, 0 ), "pvp_spawn" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_pvp_spawns_cs";
    s.name = "pvp_spawn";
    s.variantname = "content_struct";
    fe [[ f ]]( s, us, cf, ( -12731, -29810, 215 ), ( 0, 0, 0 ), "pvp_spawn" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_pvp_spawns_cs";
    s.name = "pvp_spawn";
    s.variantname = "content_struct";
    fe [[ f ]]( s, us, cf, ( -34258, -48593, 550 ), ( 0, 0, 0 ), "pvp_spawn" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_pvp_spawns_cs";
    s.name = "pvp_spawn";
    s.variantname = "content_struct";
    fe [[ f ]]( s, us, cf, ( -29364, -39996, 658 ), ( 0, 0, 0 ), "pvp_spawn" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_pvp_spawns_cs";
    s.name = "pvp_spawn";
    s.variantname = "content_struct";
    fe [[ f ]]( s, us, cf, ( -45545.3, -6899.8, 323.3 ), ( 0, 0, 0 ), "pvp_spawn" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_pvp_spawns_cs";
    s.name = "pvp_spawn";
    s.variantname = "content_struct";
    fe [[ f ]]( s, us, cf, ( -47600, -31766, 422 ), ( 0, 0, 0 ), "pvp_spawn" );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace mp_sat_avalon_quad_03_ob_pvp_spawns_cs
// Params 0, eflags: 0x4
// Checksum 0x4b299263, Offset: 0x913
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace mp_sat_avalon_quad_03_ob_pvp_spawns_cs
// Params 0
// Checksum 0x829d9d41, Offset: 0x91d
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "mp_sat_avalon_quad_03_ob_pvp_spawns_cs" );
}

