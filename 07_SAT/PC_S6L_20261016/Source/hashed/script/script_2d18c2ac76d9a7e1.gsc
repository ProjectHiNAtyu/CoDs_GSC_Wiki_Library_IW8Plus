// script_2d18c2ac76d9a7e1  (hash_2d18c2ac76d9a7e1.gscc) (size: 3439 Bytes / 0xd6f / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x9454a859 (2488576089)
// size ...... 3439 (0xd6f)
// includes .. 3   (offset: 0xbc3)
// strings ... 25  (offset: 0xbdb)
// dev strs .. 0   (offset: 0xd6f)
// exports ... 9   (offset: 0x82b)
// cseg ...... 0x2cb + 0x560 (0x82b)
// imports ... 20  (offset: 0x993)
// animtree1 . 0   (offset: 0xd6f)
// animtree2 . 0   (offset: 0xd6f)
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace mp_sat_avalon_quad_01_ob_nm_shards_cs;

// Namespace mp_sat_avalon_quad_01_ob_nm_shards_cs
// Params 0, eflags: 0x5
// Checksum 0x8893a72b, Offset: 0x2e9
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"mp_sat_avalon_quad_01_ob_nm_shards_cs", undefined, &function_b39ecd3d51489472, undefined );
}

// Namespace mp_sat_avalon_quad_01_ob_nm_shards_cs
// Params 0, eflags: 0x4
// Checksum 0xd6d02e7b, Offset: 0x30a
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace mp_sat_avalon_quad_01_ob_nm_shards_cs
// Params 0, eflags: 0x4
// Checksum 0x53ebfd97, Offset: 0x31b
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace mp_sat_avalon_quad_01_ob_nm_shards_cs
// Params 2
// Checksum 0xe302abde, Offset: 0x32c
// Size: 0x80
function main( unused, unused2 )
{
    if ( utility::flag_exist( "mp_sat_avalon_quad_01_ob_nm_shards_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "mp_sat_avalon_quad_01_ob_nm_shards_cs" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "mp_sat_avalon_quad_01_ob_nm_shards_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "mp_sat_avalon_quad_01_ob_nm_shards_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace mp_sat_avalon_quad_01_ob_nm_shards_cs
// Params 3, eflags: 0x4
// Checksum 0xd0694958, Offset: 0x3b4
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "mp_sat_avalon_quad_01_ob_nm_shards_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "mp_sat_avalon_quad_01_ob_nm_shards_cs" );
}

// Namespace mp_sat_avalon_quad_01_ob_nm_shards_cs
// Params 3, eflags: 0x4
// Checksum 0xf889efbd, Offset: 0x42e
// Size: 0x3dd
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_01_ob_nm_shards_cs";
    s.entity_id = "mp_sat_avalon_quad_01_ob_nm_shards_cs_1";
    fe [[ f ]]( s, us, cf, ( -13463, -6934, 1392.25 ), ( 0, 0, 0 ), "ob_nightmare_shard", undefined, "01" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_01_ob_nm_shards_cs";
    s.entity_id = "mp_sat_avalon_quad_01_ob_nm_shards_cs_2";
    fe [[ f ]]( s, us, cf, ( -16872, 6056, 2400 ), ( 0, 0, 0 ), "ob_nightmare_shard", undefined, "00" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_01_ob_nm_shards_cs";
    s.entity_id = "mp_sat_avalon_quad_01_ob_nm_shards_cs_3";
    fe [[ f ]]( s, us, cf, ( -7520, 24176, 1831.75 ), ( 0, 0, 0 ), "ob_nightmare_shard", undefined, "02" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_01_ob_nm_shards_cs";
    s.entity_id = "mp_sat_avalon_quad_01_ob_nm_shards_cs_4";
    fe [[ f ]]( s, us, cf, ( -9424, 26416, 820.75 ), ( 0, 0, 0 ), "ob_nightmare_shard", undefined, "03" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_01_ob_nm_shards_cs";
    s.entity_id = "mp_sat_avalon_quad_01_ob_nm_shards_cs_5";
    fe [[ f ]]( s, us, cf, ( -29624, 41392, 2208 ), ( 0, 0, 0 ), "ob_nightmare_shard", undefined, "07" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_01_ob_nm_shards_cs";
    s.entity_id = "mp_sat_avalon_quad_01_ob_nm_shards_cs_6";
    fe [[ f ]]( s, us, cf, ( -10400, 51264, 520 ), ( 0, 0, 0 ), "ob_nightmare_shard", undefined, "04" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_01_ob_nm_shards_cs";
    s.entity_id = "mp_sat_avalon_quad_01_ob_nm_shards_cs_7";
    fe [[ f ]]( s, us, cf, ( -18136, 44056, 1240 ), ( 0, 0, 0 ), "ob_nightmare_shard", undefined, "05" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_01_ob_nm_shards_cs";
    s.entity_id = "mp_sat_avalon_quad_01_ob_nm_shards_cs_8";
    fe [[ f ]]( s, us, cf, ( -32912, 37328, 2416 ), ( 0, 0, 0 ), "ob_nightmare_shard", undefined, "06" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_01_ob_nm_shards_cs";
    s.entity_id = "mp_sat_avalon_quad_01_ob_nm_shards_cs_9";
    fe [[ f ]]( s, us, cf, ( -39072, 15720, 145 ), ( 0, 0, 0 ), "ob_nightmare_shard", undefined, "09" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_01_ob_nm_shards_cs";
    s.entity_id = "mp_sat_avalon_quad_01_ob_nm_shards_cs_10";
    fe [[ f ]]( s, us, cf, ( -36536, 8200, 1416 ), ( 0, 0, 0 ), "ob_nightmare_shard", undefined, "08" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_01_ob_nm_shards_cs";
    s.entity_id = "mp_sat_avalon_quad_01_ob_nm_shards_cs_11";
    fe [[ f ]]( s, us, cf, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace mp_sat_avalon_quad_01_ob_nm_shards_cs
// Params 0, eflags: 0x4
// Checksum 0x6403c8ef, Offset: 0x813
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace mp_sat_avalon_quad_01_ob_nm_shards_cs
// Params 0
// Checksum 0x123a9415, Offset: 0x81d
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "mp_sat_avalon_quad_01_ob_nm_shards_cs" );
}

