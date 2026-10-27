// scripts\mp\zm\maps\zm_sat_locust\zm_sat_locust_script_livingworld_cs.gsc  (hash_5b465bc5bdc17fd8.gscc) (size: 4770 Bytes / 0x12a2 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xc2926bc3 (3264375747)
// size ...... 4770 (0x12a2)
// includes .. 3   (offset: 0x10fa)
// strings ... 11  (offset: 0x1112)
// dev strs .. 0   (offset: 0x12a2)
// exports ... 9   (offset: 0xcee)
// cseg ...... 0x1de + 0xb10 (0xcee)
// imports ... 21  (offset: 0xe56)
// animtree1 . 0   (offset: 0x12a2)
// animtree2 . 0   (offset: 0x12a2)
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace zm_sat_locust_script_livingworld_cs;

// Namespace zm_sat_locust_script_livingworld_cs
// Params 0, eflags: 0x5
// Checksum 0x255ed59a, Offset: 0x1fc
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"zm_sat_locust_script_livingworld_cs", undefined, &function_b39ecd3d51489472, undefined );
}

// Namespace zm_sat_locust_script_livingworld_cs
// Params 0, eflags: 0x4
// Checksum 0x95ff66d9, Offset: 0x21d
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace zm_sat_locust_script_livingworld_cs
// Params 0, eflags: 0x4
// Checksum 0x10c4b535, Offset: 0x22e
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace zm_sat_locust_script_livingworld_cs
// Params 2
// Checksum 0xa02de37c, Offset: 0x23f
// Size: 0x80
function main( unused, unused2 )
{
    if ( utility::flag_exist( "zm_sat_locust_script_livingworld_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "zm_sat_locust_script_livingworld_cs" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "zm_sat_locust_script_livingworld_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "zm_sat_locust_script_livingworld_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace zm_sat_locust_script_livingworld_cs
// Params 3, eflags: 0x4
// Checksum 0x934601fa, Offset: 0x2c7
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "zm_sat_locust_script_livingworld_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "zm_sat_locust_script_livingworld_cs" );
}

// Namespace zm_sat_locust_script_livingworld_cs
// Params 3, eflags: 0x4
// Checksum 0x8360de43, Offset: 0x341
// Size: 0x98d
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_livingworld_cs";
    s.script_forcespawn = int( 0 );
    s.script_scenescriptbundle = "sat_cin_zm_living_world_multi_eating_corpse_zmb";
    fe [[ f ]]( s, us, cf, ( 722, 3334, -152 ), ( 0, 96, 0 ), "zm_living_world", undefined, undefined, undefined, undefined, undefined, undefined, 250 );
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_livingworld_cs";
    s.script_forcespawn = int( 0 );
    s.script_scenescriptbundle = "sat_cin_zm_living_world_multi_eating_corpse_zmb";
    fe [[ f ]]( s, us, cf, ( -878, 4486, 160 ), ( 0, 248, 0 ), "zm_living_world", undefined, undefined, undefined, undefined, undefined, undefined, 250 );
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_livingworld_cs";
    s.script_forcespawn = int( 0 );
    s.script_scenescriptbundle = "sat_cin_zm_living_world_crushed_zmb";
    fe [[ f ]]( s, us, cf, ( 3354, -307, 225 ), ( 0, 183.5, 0 ), "zm_living_world", undefined, undefined, undefined, undefined, undefined, undefined, 150 );
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_livingworld_cs";
    s.script_forcespawn = int( 0 );
    s.script_scenescriptbundle = "sat_cin_zm_living_world_caught_zmb";
    fe [[ f ]]( s, us, cf, ( 4064, -754, 234 ), ( 0, 194, 0 ), "zm_living_world", undefined, undefined, undefined, undefined, undefined, undefined, 150 );
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_livingworld_cs";
    s.script_forcespawn = int( 0 );
    s.script_scenescriptbundle = "sat_cin_zm_living_world_slumped_over_zmb";
    fe [[ f ]]( s, us, cf, ( -21, 2956, 113 ), ( 0, 301.3, 0 ), "zm_living_world", undefined, undefined, undefined, undefined, undefined, undefined, 200 );
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_livingworld_cs";
    s.script_forcespawn = int( 0 );
    s.script_scenescriptbundle = "sat_cin_zm_living_world_multi_eating_corpse_zmb";
    fe [[ f ]]( s, us, cf, ( 4208, 1520, 160 ), ( 0, 333, 0 ), "zm_living_world", undefined, undefined, undefined, undefined, undefined, undefined, 250 );
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_livingworld_cs";
    s.script_forcespawn = int( 0 );
    s.script_scenescriptbundle = "sat_cin_zm_living_world_slumped_chair_zmb";
    fe [[ f ]]( s, us, cf, ( 1460, 6512, 254 ), ( 0, 302, 0 ), "zm_living_world", undefined, undefined, undefined, undefined, undefined, undefined, 250 );
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_livingworld_cs";
    s.script_forcespawn = int( 0 );
    s.script_scenescriptbundle = "sat_cin_zm_living_world_slumped_over_zmb";
    fe [[ f ]]( s, us, cf, ( 3736, 460, 160 ), ( 0, 3, 0 ), "zm_living_world", undefined, undefined, undefined, undefined, undefined, undefined, 200 );
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_livingworld_cs";
    s.script_forcespawn = int( 0 );
    s.script_scenescriptbundle = "sat_cin_zm_living_world_slumped_over_zmb";
    fe [[ f ]]( s, us, cf, ( -1672, 4964, 160 ), ( 0, 311, 0 ), "zm_living_world", undefined, undefined, undefined, undefined, undefined, undefined, 150 );
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_livingworld_cs";
    s.script_forcespawn = int( 0 );
    s.script_scenescriptbundle = "sat_cin_zm_living_world_slumped_over_zmb";
    fe [[ f ]]( s, us, cf, ( 1768, 826, 224 ), ( 0, 248, 0 ), "zm_living_world", undefined, undefined, undefined, undefined, undefined, undefined, 150 );
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_livingworld_cs";
    s.script_forcespawn = int( 0 );
    s.script_scenescriptbundle = "sat_cin_zm_living_world_crushed_zmb";
    fe [[ f ]]( s, us, cf, ( -964, 7116, 260.94 ), ( 0, 26, 0 ), "zm_living_world", undefined, undefined, undefined, undefined, undefined, undefined, 150 );
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_livingworld_cs";
    s.script_forcespawn = int( 0 );
    s.script_scenescriptbundle = "sat_cin_zm_living_world_crushed_zmb";
    fe [[ f ]]( s, us, cf, ( 1094, 2180, 160 ), ( 0, 347.1, 0 ), "zm_living_world", undefined, undefined, undefined, undefined, undefined, undefined, 150 );
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_livingworld_cs";
    s.script_forcespawn = int( 0 );
    s.script_scenescriptbundle = "sat_cin_zm_living_world_crushed_zmb";
    fe [[ f ]]( s, us, cf, ( -1318, 6062, 352 ), ( 0, 47.99, 0 ), "zm_living_world", undefined, undefined, undefined, undefined, undefined, undefined, 250 );
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_livingworld_cs";
    s.script_forcespawn = int( 0 );
    s.script_scenescriptbundle = "sat_cin_zm_living_world_crushed_zmb";
    fe [[ f ]]( s, us, cf, ( 1102, 5330, 254.9 ), ( 0, 32, 0 ), "zm_living_world", undefined, undefined, undefined, undefined, undefined, undefined, 250 );
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_livingworld_cs";
    s.script_forcespawn = int( 0 );
    s.script_scenescriptbundle = "sat_cin_zm_living_world_caught_zmb";
    fe [[ f ]]( s, us, cf, ( 4820, 6788, 282 ), ( 0, 173, 0 ), "zm_living_world", undefined, undefined, undefined, undefined, undefined, undefined, 150 );
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_livingworld_cs";
    s.script_forcespawn = int( 0 );
    s.script_scenescriptbundle = "sat_cin_zm_living_world_slumped_over_zmb";
    fe [[ f ]]( s, us, cf, ( 4616, 5732, 224 ), ( 0, 49, 0 ), "zm_living_world", undefined, undefined, undefined, undefined, undefined, undefined, 125 );
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_livingworld_cs";
    s.script_forcespawn = int( 0 );
    s.script_scenescriptbundle = "sat_cin_zm_living_world_half_eaten_zmb";
    fe [[ f ]]( s, us, cf, ( 5306, 5526, 224.23 ), ( 0, 183, 0 ), "zm_living_world", undefined, undefined, undefined, undefined, undefined, undefined, 125 );
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_livingworld_cs";
    s.script_forcespawn = int( 0 );
    s.script_scenescriptbundle = "sat_cin_zm_living_world_undr_low_obj_zmb";
    fe [[ f ]]( s, us, cf, ( 4426, 4012, 160 ), ( 0, 271, 0 ), "zm_living_world", undefined, undefined, undefined, undefined, undefined, undefined, 150 );
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_livingworld_cs";
    s.script_forcespawn = int( 0 );
    s.script_scenescriptbundle = "sat_cin_zm_living_world_crushed_zmb";
    fe [[ f ]]( s, us, cf, ( 3774, 3314, 87.72 ), ( 352, 1.01, -0.14 ), "zm_living_world", undefined, undefined, undefined, undefined, undefined, undefined, 150 );
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_livingworld_cs";
    s.script_forcespawn = int( 0 );
    s.script_scenescriptbundle = "sat_cin_zm_living_world_caught_zmb";
    fe [[ f ]]( s, us, cf, ( 3284, 3892, 117 ), ( 0, 7.6, 0 ), "zm_living_world", undefined, undefined, undefined, undefined, undefined, undefined, 150 );
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_livingworld_cs";
    s.script_forcespawn = int( 0 );
    s.script_scenescriptbundle = "sat_cin_zm_living_world_multi_eating_corpse_zmb";
    fe [[ f ]]( s, us, cf, ( 7654, 2158, 104 ), ( 0, 297, 0 ), "zm_living_world", undefined, undefined, undefined, undefined, undefined, undefined, 250 );
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_livingworld_cs";
    s.script_forcespawn = int( 0 );
    s.script_scenescriptbundle = "sat_cin_zm_living_world_undr_low_obj_zmb";
    fe [[ f ]]( s, us, cf, ( 3292, 7916, 256 ), ( 0, 73, 0 ), "zm_living_world", undefined, undefined, undefined, undefined, undefined, undefined, 95 );
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_livingworld_cs";
    s.script_forcespawn = int( 0 );
    s.script_scenescriptbundle = "sat_cin_zm_living_world_crushed_zmb";
    fe [[ f ]]( s, us, cf, ( -234, 4690, 197 ), ( 0, 33, 0 ), "zm_living_world", undefined, undefined, undefined, undefined, undefined, undefined, 250 );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace zm_sat_locust_script_livingworld_cs
// Params 0, eflags: 0x4
// Checksum 0xf6bc3bd0, Offset: 0xcd6
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace zm_sat_locust_script_livingworld_cs
// Params 0
// Checksum 0x5115dcb7, Offset: 0xce0
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "zm_sat_locust_script_livingworld_cs" );
}

