// script_45b868462863b855  (hash_45b868462863b855.gscc) (size: 5085 Bytes / 0x13dd / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xa3bdb73b (2747119419)
// size ...... 5085 (0x13dd)
// includes .. 3   (offset: 0x1109)
// strings ... 44  (offset: 0x1121)
// dev strs .. 0   (offset: 0x13dd)
// exports ... 9   (offset: 0xd71)
// cseg ...... 0x51d + 0x854 (0xd71)
// imports ... 20  (offset: 0xed9)
// animtree1 . 0   (offset: 0x13dd)
// animtree2 . 0   (offset: 0x13dd)
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace mp_sat_avalon_quad_03_ob_nm_shards_cs;

// Namespace mp_sat_avalon_quad_03_ob_nm_shards_cs
// Params 0, eflags: 0x5
// Checksum 0xf7546130, Offset: 0x53b
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"mp_sat_avalon_quad_03_ob_nm_shards_cs", undefined, &function_b39ecd3d51489472, undefined );
}

// Namespace mp_sat_avalon_quad_03_ob_nm_shards_cs
// Params 0, eflags: 0x4
// Checksum 0xf4264796, Offset: 0x55c
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace mp_sat_avalon_quad_03_ob_nm_shards_cs
// Params 0, eflags: 0x4
// Checksum 0x711d947a, Offset: 0x56d
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace mp_sat_avalon_quad_03_ob_nm_shards_cs
// Params 2
// Checksum 0xc1f4c233, Offset: 0x57e
// Size: 0x80
function main( unused, unused2 )
{
    if ( utility::flag_exist( "mp_sat_avalon_quad_03_ob_nm_shards_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "mp_sat_avalon_quad_03_ob_nm_shards_cs" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "mp_sat_avalon_quad_03_ob_nm_shards_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "mp_sat_avalon_quad_03_ob_nm_shards_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace mp_sat_avalon_quad_03_ob_nm_shards_cs
// Params 3, eflags: 0x4
// Checksum 0xf29f20b5, Offset: 0x606
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "mp_sat_avalon_quad_03_ob_nm_shards_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "mp_sat_avalon_quad_03_ob_nm_shards_cs" );
}

// Namespace mp_sat_avalon_quad_03_ob_nm_shards_cs
// Params 3, eflags: 0x4
// Checksum 0xed57dc39, Offset: 0x680
// Size: 0x6d1
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_nm_shards_cs";
    s.entity_id = "mp_sat_avalon_quad_03_ob_nm_shards_cs_1";
    fe [[ f ]]( s, us, cf, ( -23688, -43296, 1364 ), ( 0, 0, 0 ), "ob_nightmare_shard", undefined, "22" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_nm_shards_cs";
    s.entity_id = "mp_sat_avalon_quad_03_ob_nm_shards_cs_2";
    fe [[ f ]]( s, us, cf, ( 2208, -45616, 285 ), ( 0, 0, 0 ), "ob_nightmare_shard", undefined, "23" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_nm_shards_cs";
    s.entity_id = "mp_sat_avalon_quad_03_ob_nm_shards_cs_3";
    fe [[ f ]]( s, us, cf, ( 1024, -53248, 1272 ), ( 0, 0, 0 ), "ob_nightmare_shard", undefined, "24" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_nm_shards_cs";
    s.entity_id = "mp_sat_avalon_quad_03_ob_nm_shards_cs_4";
    fe [[ f ]]( s, us, cf, ( -5384, -40520, 728 ), ( 0, 0, 0 ), "ob_nightmare_shard", undefined, "25" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_nm_shards_cs";
    s.entity_id = "mp_sat_avalon_quad_03_ob_nm_shards_cs_5";
    fe [[ f ]]( s, us, cf, ( -34192, -40048, 875 ), ( 0, 0, 0 ), "ob_nightmare_shard", undefined, "27" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_nm_shards_cs";
    s.entity_id = "mp_sat_avalon_quad_03_ob_nm_shards_cs_6";
    fe [[ f ]]( s, us, cf, ( -39696, -37784, 1459 ), ( 0, 0, 0 ), "ob_nightmare_shard", undefined, "26" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_nm_shards_cs";
    s.entity_id = "mp_sat_avalon_quad_03_ob_nm_shards_cs_7";
    fe [[ f ]]( s, us, cf, ( -28120, -32624, 1185 ), ( 0, 0, 0 ), "ob_nightmare_shard", undefined, "28" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_nm_shards_cs";
    s.entity_id = "mp_sat_avalon_quad_03_ob_nm_shards_cs_8";
    fe [[ f ]]( s, us, cf, ( -45056, -28264, 48 ), ( 0, 0, 0 ), "ob_nightmare_shard", undefined, "33" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_nm_shards_cs";
    s.entity_id = "mp_sat_avalon_quad_03_ob_nm_shards_cs_9";
    fe [[ f ]]( s, us, cf, ( -23810, -41830, 730 ), ( 0, 190, 0 ), "act3_nm_network_hub", undefined, "sat_wc_quest_act3_quest5_network" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_nm_shards_cs";
    s.entity_id = "mp_sat_avalon_quad_03_ob_nm_shards_cs_10";
    fe [[ f ]]( s, us, cf, ( -31536, -54128, 1534 ), ( 0, 0, 0 ), "ob_nightmare_shard", undefined, "30" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_nm_shards_cs";
    s.entity_id = "mp_sat_avalon_quad_03_ob_nm_shards_cs_11";
    fe [[ f ]]( s, us, cf, ( -5304, -19352, 168 ), ( 0, 0, 0 ), "ob_nightmare_shard", undefined, "31" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_nm_shards_cs";
    s.entity_id = "mp_sat_avalon_quad_03_ob_nm_shards_cs_12";
    fe [[ f ]]( s, us, cf, ( -23992, -13192, 1664 ), ( 0, 0, 0 ), "ob_nightmare_shard", undefined, "32" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_nm_shards_cs";
    s.entity_id = "mp_sat_avalon_quad_03_ob_nm_shards_cs_13";
    fe [[ f ]]( s, us, cf, ( -25560, -904, 320 ), ( 0, 0, 0 ), "ob_nightmare_shard", undefined, "29" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_nm_shards_cs";
    s.entity_id = "mp_sat_avalon_quad_03_ob_nm_shards_cs_14";
    fe [[ f ]]( s, us, cf, ( -41448, -11976, 604 ), ( 0, 0, 0 ), "ob_nightmare_shard", undefined, "34" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_nm_shards_cs";
    s.entity_id = "mp_sat_avalon_quad_03_ob_nm_shards_cs_15";
    fe [[ f ]]( s, us, cf, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_nm_shards_cs";
    s.entity_id = "mp_sat_avalon_quad_03_ob_nm_shards_cs_16";
    fe [[ f ]]( s, us, cf, ( -45456, -6720, 1982 ), ( 0, 0, 0 ), "ob_nightmare_shard", undefined, "35" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_nm_shards_cs";
    s.entity_id = "mp_sat_avalon_quad_03_ob_nm_shards_cs_17";
    fe [[ f ]]( s, us, cf, ( -51824, -17232, 1552 ), ( 0, 0, 0 ), "ob_nightmare_shard", undefined, "36" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_nm_shards_cs";
    s.entity_id = "mp_sat_avalon_quad_03_ob_nm_shards_cs_18";
    fe [[ f ]]( s, us, cf, ( -28800, -29150, 1055.5 ), ( 0, 230, 0 ), "act3_nm_network_hub", undefined, "sat_wc_quest_act3_quest9_network2" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_nm_shards_cs";
    s.entity_id = "mp_sat_avalon_quad_03_ob_nm_shards_cs_19";
    fe [[ f ]]( s, us, cf, ( -41500, -12218, 136 ), ( 0, 234, 0 ), "act3_nm_network_hub", undefined, "sat_wc_quest_act3_quest8_network" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_nm_shards_cs";
    s.entity_id = "mp_sat_avalon_quad_03_ob_nm_shards_cs_20";
    fe [[ f ]]( s, us, cf, ( -13788, -7834, 1856 ), ( 0, 360, 0 ), "act3_nm_network_hub", undefined, "sat_wc_quest_act3_quest7_network" );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace mp_sat_avalon_quad_03_ob_nm_shards_cs
// Params 0, eflags: 0x4
// Checksum 0x92c931c5, Offset: 0xd59
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace mp_sat_avalon_quad_03_ob_nm_shards_cs
// Params 0
// Checksum 0x30ccfdf8, Offset: 0xd63
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "mp_sat_avalon_quad_03_ob_nm_shards_cs" );
}

