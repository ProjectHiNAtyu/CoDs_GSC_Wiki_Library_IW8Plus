// scripts\mp\zm\maps\zm_sat_locust\zm_sat_locust_quest_mq_cs.gsc  (hash_0a4c75991ee4ef96.gscc) (size: 1702 Bytes / 0x6a6 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x37a9fb5b (933886811)
// size ...... 1702 (0x6a6)
// includes .. 3   (offset: 0x642)
// strings ... 4   (offset: 0x65a)
// dev strs .. 0   (offset: 0x6a6)
// exports ... 9   (offset: 0x2aa)
// cseg ...... 0x9e + 0x20c (0x2aa)
// imports ... 20  (offset: 0x412)
// animtree1 . 0   (offset: 0x6a6)
// animtree2 . 0   (offset: 0x6a6)
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace zm_sat_locust_quest_mq_cs;

// Namespace zm_sat_locust_quest_mq_cs
// Params 0, eflags: 0x5
// Checksum 0xf43001c9, Offset: 0xbc
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"zm_sat_locust_quest_mq_cs", undefined, &function_b39ecd3d51489472, undefined );
}

// Namespace zm_sat_locust_quest_mq_cs
// Params 0, eflags: 0x4
// Checksum 0x7a9312d8, Offset: 0xdd
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace zm_sat_locust_quest_mq_cs
// Params 0, eflags: 0x4
// Checksum 0xffa8c134, Offset: 0xee
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace zm_sat_locust_quest_mq_cs
// Params 2
// Checksum 0x4f41977d, Offset: 0xff
// Size: 0x80
function main( unused, unused2 )
{
    if ( utility::flag_exist( "zm_sat_locust_quest_mq_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "zm_sat_locust_quest_mq_cs" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "zm_sat_locust_quest_mq_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "zm_sat_locust_quest_mq_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace zm_sat_locust_quest_mq_cs
// Params 3, eflags: 0x4
// Checksum 0x7c2a75fb, Offset: 0x187
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "zm_sat_locust_quest_mq_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "zm_sat_locust_quest_mq_cs" );
}

// Namespace zm_sat_locust_quest_mq_cs
// Params 3, eflags: 0x4
// Checksum 0xc0cc6ecd, Offset: 0x201
// Size: 0x89
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "zm_sat_locust_quest_mq_cs";
    fe [[ f ]]( s, us, cf, ( 1696, 1120, 224 ), ( 0, 0, 0 ), "deleteme" );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace zm_sat_locust_quest_mq_cs
// Params 0, eflags: 0x4
// Checksum 0xa658c5a2, Offset: 0x292
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace zm_sat_locust_quest_mq_cs
// Params 0
// Checksum 0xbe79a8b6, Offset: 0x29c
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "zm_sat_locust_quest_mq_cs" );
}

