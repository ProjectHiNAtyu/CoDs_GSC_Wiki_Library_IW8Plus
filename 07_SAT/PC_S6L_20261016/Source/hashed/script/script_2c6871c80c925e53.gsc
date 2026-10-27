// script_2c6871c80c925e53  (hash_2c6871c80c925e53.gscc) (size: 4557 Bytes / 0x11cd / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xc671c312 (3329344274)
// size ...... 4557 (0x11cd)
// includes .. 3   (offset: 0xf59)
// strings ... 38  (offset: 0xf71)
// dev strs .. 0   (offset: 0x11cd)
// exports ... 9   (offset: 0xbc1)
// cseg ...... 0x469 + 0x758 (0xbc1)
// imports ... 20  (offset: 0xd29)
// animtree1 . 0   (offset: 0x11cd)
// animtree2 . 0   (offset: 0x11cd)
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace mp_sat_avalon_quad_04_ob_nm_shards_cs;

// Namespace mp_sat_avalon_quad_04_ob_nm_shards_cs
// Params 0, eflags: 0x5
// Checksum 0xf6141d2b, Offset: 0x487
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"mp_sat_avalon_quad_04_ob_nm_shards_cs", undefined, &function_b39ecd3d51489472, undefined );
}

// Namespace mp_sat_avalon_quad_04_ob_nm_shards_cs
// Params 0, eflags: 0x4
// Checksum 0x7d30b3f0, Offset: 0x4a8
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace mp_sat_avalon_quad_04_ob_nm_shards_cs
// Params 0, eflags: 0x4
// Checksum 0xf80b601c, Offset: 0x4b9
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace mp_sat_avalon_quad_04_ob_nm_shards_cs
// Params 2
// Checksum 0x48e23655, Offset: 0x4ca
// Size: 0x80
function main( unused, unused2 )
{
    if ( utility::flag_exist( "mp_sat_avalon_quad_04_ob_nm_shards_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "mp_sat_avalon_quad_04_ob_nm_shards_cs" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "mp_sat_avalon_quad_04_ob_nm_shards_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "mp_sat_avalon_quad_04_ob_nm_shards_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace mp_sat_avalon_quad_04_ob_nm_shards_cs
// Params 3, eflags: 0x4
// Checksum 0x7b89d4d3, Offset: 0x552
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "mp_sat_avalon_quad_04_ob_nm_shards_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "mp_sat_avalon_quad_04_ob_nm_shards_cs" );
}

// Namespace mp_sat_avalon_quad_04_ob_nm_shards_cs
// Params 3, eflags: 0x4
// Checksum 0x95f2ad13, Offset: 0x5cc
// Size: 0x5d5
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_04_ob_nm_shards_cs";
    s.entity_id = "mp_sat_avalon_quad_04_ob_nm_shards_cs_1";
    fe [[ f ]]( s, us, cf, ( 44120, -10544, 717 ), ( 0, 0, 0 ), "ob_nightmare_shard", undefined, "38" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_04_ob_nm_shards_cs";
    s.entity_id = "mp_sat_avalon_quad_04_ob_nm_shards_cs_2";
    fe [[ f ]]( s, us, cf, ( 49560, -8048, 928 ), ( 0, 0, 0 ), "ob_nightmare_shard", undefined, "37" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_04_ob_nm_shards_cs";
    s.entity_id = "mp_sat_avalon_quad_04_ob_nm_shards_cs_3";
    fe [[ f ]]( s, us, cf, ( 31824, -2912, 2158 ), ( 0, 0, 0 ), "ob_nightmare_shard", undefined, "39" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_04_ob_nm_shards_cs";
    s.entity_id = "mp_sat_avalon_quad_04_ob_nm_shards_cs_4";
    fe [[ f ]]( s, us, cf, ( 50640, -36000, 2843.5 ), ( 0, 0, 0 ), "ob_nightmare_shard", undefined, "42" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_04_ob_nm_shards_cs";
    s.entity_id = "mp_sat_avalon_quad_04_ob_nm_shards_cs_5";
    fe [[ f ]]( s, us, cf, ( 58232, -31536, 3296 ), ( 0, 0, 0 ), "ob_nightmare_shard", undefined, "40" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_04_ob_nm_shards_cs";
    s.entity_id = "mp_sat_avalon_quad_04_ob_nm_shards_cs_6";
    fe [[ f ]]( s, us, cf, ( 54744, -36896, 2040 ), ( 0, 0, 0 ), "ob_nightmare_shard", undefined, "41" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_04_ob_nm_shards_cs";
    s.entity_id = "mp_sat_avalon_quad_04_ob_nm_shards_cs_7";
    fe [[ f ]]( s, us, cf, ( 30200, -50128, 1145 ), ( 0, 0, 0 ), "ob_nightmare_shard", undefined, "44" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_04_ob_nm_shards_cs";
    s.entity_id = "mp_sat_avalon_quad_04_ob_nm_shards_cs_8";
    fe [[ f ]]( s, us, cf, ( 53336, -53168, 927 ), ( 0, 0, 0 ), "ob_nightmare_shard", undefined, "43" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_04_ob_nm_shards_cs";
    s.entity_id = "mp_sat_avalon_quad_04_ob_nm_shards_cs_9";
    fe [[ f ]]( s, us, cf, ( 23744, -40704, 1169.68 ), ( 0, 0, 0 ), "ob_nightmare_shard", undefined, "45" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_04_ob_nm_shards_cs";
    s.entity_id = "mp_sat_avalon_quad_04_ob_nm_shards_cs_10";
    fe [[ f ]]( s, us, cf, ( 30512, -18880, 1056 ), ( 0, 0, 0 ), "ob_nightmare_shard", undefined, "47" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_04_ob_nm_shards_cs";
    s.entity_id = "mp_sat_avalon_quad_04_ob_nm_shards_cs_11";
    fe [[ f ]]( s, us, cf, ( 11192, -32336, 5308 ), ( 0, 0, 0 ), "ob_nightmare_shard", undefined, "46" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_04_ob_nm_shards_cs";
    s.entity_id = "mp_sat_avalon_quad_04_ob_nm_shards_cs_12";
    fe [[ f ]]( s, us, cf, ( 16320, -8816, 3886.84 ), ( 0, 0, 0 ), "ob_nightmare_shard", undefined, "48" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_04_ob_nm_shards_cs";
    s.entity_id = "mp_sat_avalon_quad_04_ob_nm_shards_cs_13";
    fe [[ f ]]( s, us, cf, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_04_ob_nm_shards_cs";
    s.entity_id = "mp_sat_avalon_quad_04_ob_nm_shards_cs_15";
    fe [[ f ]]( s, us, cf, ( 944, -1120, 1416 ), ( 0, 0, 0 ), "ob_nightmare_shard", undefined, "49" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_04_ob_nm_shards_cs";
    s.entity_id = "mp_sat_avalon_quad_04_ob_nm_shards_cs_16";
    fe [[ f ]]( s, us, cf, ( 29802, -50468, 1096 ), ( 0, 222, 0 ), "act3_nm_network_hub", undefined, "sat_wc_quest_act3_quest1_network" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_04_ob_nm_shards_cs";
    s.entity_id = "mp_sat_avalon_quad_04_ob_nm_shards_cs_17";
    fe [[ f ]]( s, us, cf, ( 30466, -18842, 1008 ), ( 0, 326, 0 ), "act3_nm_network_hub", undefined, "sat_wc_quest_act3_quest4_network" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_04_ob_nm_shards_cs";
    s.entity_id = "mp_sat_avalon_quad_04_ob_nm_shards_cs_18";
    fe [[ f ]]( s, us, cf, ( -1874, -962, 840 ), ( 0, 302, 0 ), "act3_nm_network_hub", undefined, "sat_wc_quest_act3_quest9_network1" );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace mp_sat_avalon_quad_04_ob_nm_shards_cs
// Params 0, eflags: 0x4
// Checksum 0x3b4db9e8, Offset: 0xba9
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace mp_sat_avalon_quad_04_ob_nm_shards_cs
// Params 0
// Checksum 0xb9da099e, Offset: 0xbb3
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "mp_sat_avalon_quad_04_ob_nm_shards_cs" );
}

