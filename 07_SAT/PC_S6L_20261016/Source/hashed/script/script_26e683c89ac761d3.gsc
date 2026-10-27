// script_26e683c89ac761d3  (hash_26e683c89ac761d3.gscc) (size: 4390 Bytes / 0x1126 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x584cfbbb (1481440187)
// size ...... 4390 (0x1126)
// includes .. 3   (offset: 0xed2)
// strings ... 36  (offset: 0xeea)
// dev strs .. 0   (offset: 0x1126)
// exports ... 9   (offset: 0xb3a)
// cseg ...... 0x436 + 0x704 (0xb3a)
// imports ... 20  (offset: 0xca2)
// animtree1 . 0   (offset: 0x1126)
// animtree2 . 0   (offset: 0x1126)
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace mp_sat_avalon_quad_02_ob_nm_shards_cs;

// Namespace mp_sat_avalon_quad_02_ob_nm_shards_cs
// Params 0, eflags: 0x5
// Checksum 0x18e7995f, Offset: 0x454
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"mp_sat_avalon_quad_02_ob_nm_shards_cs", undefined, &function_b39ecd3d51489472, undefined );
}

// Namespace mp_sat_avalon_quad_02_ob_nm_shards_cs
// Params 0, eflags: 0x4
// Checksum 0x6bdb492, Offset: 0x475
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace mp_sat_avalon_quad_02_ob_nm_shards_cs
// Params 0, eflags: 0x4
// Checksum 0x8386677e, Offset: 0x486
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace mp_sat_avalon_quad_02_ob_nm_shards_cs
// Params 2
// Checksum 0x336f3137, Offset: 0x497
// Size: 0x80
function main( unused, unused2 )
{
    if ( utility::flag_exist( "mp_sat_avalon_quad_02_ob_nm_shards_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "mp_sat_avalon_quad_02_ob_nm_shards_cs" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "mp_sat_avalon_quad_02_ob_nm_shards_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "mp_sat_avalon_quad_02_ob_nm_shards_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace mp_sat_avalon_quad_02_ob_nm_shards_cs
// Params 3, eflags: 0x4
// Checksum 0x4d3b1, Offset: 0x51f
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "mp_sat_avalon_quad_02_ob_nm_shards_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "mp_sat_avalon_quad_02_ob_nm_shards_cs" );
}

// Namespace mp_sat_avalon_quad_02_ob_nm_shards_cs
// Params 3, eflags: 0x4
// Checksum 0x4f654dfd, Offset: 0x599
// Size: 0x581
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_02_ob_nm_shards_cs";
    s.entity_id = "mp_sat_avalon_quad_02_ob_nm_shards_cs_1";
    fe [[ f ]]( s, us, cf, ( 11464, 12352, 285.25 ), ( 0, 0, 0 ), "ob_nightmare_shard", undefined, "11" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_02_ob_nm_shards_cs";
    s.entity_id = "mp_sat_avalon_quad_02_ob_nm_shards_cs_2";
    fe [[ f ]]( s, us, cf, ( 12896, 20608, 2856 ), ( 0, 0, 0 ), "ob_nightmare_shard", undefined, "10" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_02_ob_nm_shards_cs";
    s.entity_id = "mp_sat_avalon_quad_02_ob_nm_shards_cs_3";
    fe [[ f ]]( s, us, cf, ( 30248, 50696, 1439.25 ), ( 0, 0, 0 ), "ob_nightmare_shard", undefined, "14" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_02_ob_nm_shards_cs";
    s.entity_id = "mp_sat_avalon_quad_02_ob_nm_shards_cs_4";
    fe [[ f ]]( s, us, cf, ( 15304, 33960, 2952 ), ( 0, 0, 0 ), "ob_nightmare_shard", undefined, "12" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_02_ob_nm_shards_cs";
    s.entity_id = "mp_sat_avalon_quad_02_ob_nm_shards_cs_5";
    fe [[ f ]]( s, us, cf, ( 19184, 47456, 1242.5 ), ( 0, 0, 0 ), "ob_nightmare_shard", undefined, "13" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_02_ob_nm_shards_cs";
    s.entity_id = "mp_sat_avalon_quad_02_ob_nm_shards_cs_6";
    fe [[ f ]]( s, us, cf, ( 31592, 29080, 3385.5 ), ( 0, 0, 0 ), "ob_nightmare_shard", undefined, "17" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_02_ob_nm_shards_cs";
    s.entity_id = "mp_sat_avalon_quad_02_ob_nm_shards_cs_7";
    fe [[ f ]]( s, us, cf, ( 5568, 62056, 1040 ), ( 0, 0, 0 ), "ob_nightmare_shard", undefined, "15" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_02_ob_nm_shards_cs";
    s.entity_id = "mp_sat_avalon_quad_02_ob_nm_shards_cs_8";
    fe [[ f ]]( s, us, cf, ( 28272, 32328, 3456 ), ( 0, 0, 0 ), "ob_nightmare_shard", undefined, "16" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_02_ob_nm_shards_cs";
    s.entity_id = "mp_sat_avalon_quad_02_ob_nm_shards_cs_9";
    fe [[ f ]]( s, us, cf, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_02_ob_nm_shards_cs";
    s.entity_id = "mp_sat_avalon_quad_02_ob_nm_shards_cs_10";
    fe [[ f ]]( s, us, cf, ( 49560, 17920, 232 ), ( 0, 0, 0 ), "ob_nightmare_shard", undefined, "19" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_02_ob_nm_shards_cs";
    s.entity_id = "mp_sat_avalon_quad_02_ob_nm_shards_cs_11";
    fe [[ f ]]( s, us, cf, ( 44752, 23456, 208 ), ( 0, 0, 0 ), "ob_nightmare_shard", undefined, "18" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_02_ob_nm_shards_cs";
    s.entity_id = "mp_sat_avalon_quad_02_ob_nm_shards_cs_12";
    fe [[ f ]]( s, us, cf, ( 35976, 4776, 184 ), ( 0, 0, 0 ), "ob_nightmare_shard", undefined, "21" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_02_ob_nm_shards_cs";
    s.entity_id = "mp_sat_avalon_quad_02_ob_nm_shards_cs_13";
    fe [[ f ]]( s, us, cf, ( 39976, 9808, 1952 ), ( 0, 0, 0 ), "ob_nightmare_shard", undefined, "20" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_02_ob_nm_shards_cs";
    s.entity_id = "mp_sat_avalon_quad_02_ob_nm_shards_cs_14";
    fe [[ f ]]( s, us, cf, ( 44660, 22362, 290 ), ( 0, 92, 0 ), "act3_nm_network_hub", undefined, "sat_wc_quest_act3_quest3_network" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_02_ob_nm_shards_cs";
    s.entity_id = "mp_sat_avalon_quad_02_ob_nm_shards_cs_15";
    fe [[ f ]]( s, us, cf, ( 12972, 20496, 2808 ), ( 0, 110, 0 ), "act3_nm_network_hub", undefined, "sat_wc_quest_act3_quest6_network" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_02_ob_nm_shards_cs";
    s.entity_id = "mp_sat_avalon_quad_02_ob_nm_shards_cs_16";
    fe [[ f ]]( s, us, cf, ( 39088, 11722, 1240 ), ( 0, 322, 0 ), "act3_nm_network_hub", undefined, "sat_wc_quest_act3_quest2_network" );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace mp_sat_avalon_quad_02_ob_nm_shards_cs
// Params 0, eflags: 0x4
// Checksum 0xe7f40982, Offset: 0xb22
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace mp_sat_avalon_quad_02_ob_nm_shards_cs
// Params 0
// Checksum 0xc2570efc, Offset: 0xb2c
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "mp_sat_avalon_quad_02_ob_nm_shards_cs" );
}

