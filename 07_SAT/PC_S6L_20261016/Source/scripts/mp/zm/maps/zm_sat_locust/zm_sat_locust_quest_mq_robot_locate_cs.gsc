// scripts\mp\zm\maps\zm_sat_locust\zm_sat_locust_quest_mq_robot_locate_cs.gsc  (hash_1952a8415c225880.gscc) (size: 4839 Bytes / 0x12e7 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xa11c805e (2702999646)
// size ...... 4839 (0x12e7)
// includes .. 3   (offset: 0x1053)
// strings ... 34  (offset: 0x106b)
// dev strs .. 0   (offset: 0x12e7)
// exports ... 9   (offset: 0xc87)
// cseg ...... 0x22b + 0xa5c (0xc87)
// imports ... 21  (offset: 0xdef)
// animtree1 . 0   (offset: 0x12e7)
// animtree2 . 0   (offset: 0x12e7)
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace zm_sat_locust_quest_mq_robot_locate_cs;

// Namespace zm_sat_locust_quest_mq_robot_locate_cs
// Params 0, eflags: 0x5
// Checksum 0x58e9ed23, Offset: 0x249
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"zm_sat_locust_quest_mq_robot_locate_cs", undefined, &function_b39ecd3d51489472, undefined );
}

// Namespace zm_sat_locust_quest_mq_robot_locate_cs
// Params 0, eflags: 0x4
// Checksum 0x5dc697ec, Offset: 0x26a
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace zm_sat_locust_quest_mq_robot_locate_cs
// Params 0, eflags: 0x4
// Checksum 0xd8fd4400, Offset: 0x27b
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace zm_sat_locust_quest_mq_robot_locate_cs
// Params 2
// Checksum 0x68141249, Offset: 0x28c
// Size: 0x80
function main( unused, unused2 )
{
    if ( utility::flag_exist( "zm_sat_locust_quest_mq_robot_locate_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "zm_sat_locust_quest_mq_robot_locate_cs" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "zm_sat_locust_quest_mq_robot_locate_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "zm_sat_locust_quest_mq_robot_locate_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace zm_sat_locust_quest_mq_robot_locate_cs
// Params 3, eflags: 0x4
// Checksum 0x5b7ff0cf, Offset: 0x314
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "zm_sat_locust_quest_mq_robot_locate_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "zm_sat_locust_quest_mq_robot_locate_cs" );
}

// Namespace zm_sat_locust_quest_mq_robot_locate_cs
// Params 3, eflags: 0x4
// Checksum 0x9a7113ce, Offset: 0x38e
// Size: 0x8d9
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "zm_sat_locust_quest_mq_robot_locate_cs";
    s.groupid = "Pyres - E";
    fe [[ f ]]( s, us, cf, ( 5585.06, 5483.59, 194.63 ), ( 0, 0, 0 ), "quest_mq_pyre", undefined, "e" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_quest_mq_robot_locate_cs";
    s.groupid = "Pyres - NE";
    fe [[ f ]]( s, us, cf, ( 5665.91, 7459.18, 265.28 ), ( 0, 0, 0 ), "quest_mq_pyre", undefined, "ne" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_quest_mq_robot_locate_cs";
    s.groupid = "Pyres - NW";
    fe [[ f ]]( s, us, cf, ( -1597.49, 7792.78, 283.85 ), ( 0, 0, 0 ), "quest_mq_pyre", undefined, "nw" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_quest_mq_robot_locate_cs";
    s.script_radius = int( 53 );
    fe [[ f ]]( s, us, cf, ( 5351.29, 3928.29, 153.79 ), ( 0, 0, 0 ), "mqlo_ha_fi", "cspf_0_auto11819280120952327644" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_quest_mq_robot_locate_cs";
    s.script_radius = int( 48 );
    fe [[ f ]]( s, us, cf, ( 4940, 6885, 323.25 ), ( 0, 90, 0 ), "mqlo_pe_lo", undefined, undefined, undefined, undefined, undefined, undefined, 48 );
    s = {};
    s.script_cs_flag = "zm_sat_locust_quest_mq_robot_locate_cs";
    s.groupid = "Pyres - S";
    fe [[ f ]]( s, us, cf, ( 3407.94, -875.87, 381.64 ), ( 0, 0, 0 ), "quest_mq_pyre", undefined, "s" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_quest_mq_robot_locate_cs";
    s.groupid = "Pyres - N";
    fe [[ f ]]( s, us, cf, ( 4531.17, 7260.28, 311.84 ), ( 0, 0, 0 ), "quest_mq_pyre", undefined, "n" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_quest_mq_robot_locate_cs";
    s.groupid = "Pyres - SE";
    fe [[ f ]]( s, us, cf, ( 5328.59, 4573.17, 90.24 ), ( 0, 0, 0 ), "quest_mq_pyre", undefined, "se" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_quest_mq_robot_locate_cs";
    s.groupid = "Pyres - W";
    fe [[ f ]]( s, us, cf, ( 259.95, 5360.15, 70.9 ), ( 0, 0, 0 ), "quest_mq_pyre", undefined, "w" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_quest_mq_robot_locate_cs";
    fe [[ f ]]( s, us, cf, ( -898.91, 7855.43, 328.95 ), ( 1.56, 337.92, -5.11 ), "mqlo_ss_dr" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_quest_mq_robot_locate_cs";
    s.script_animation = "spawn";
    fe [[ f ]]( s, us, cf, ( 5588.09, 3925.01, 167 ), ( 0, 180, 0 ), "mqlo_hv_sp" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_quest_mq_robot_locate_cs";
    s.script_radius = int( 53 );
    fe [[ f ]]( s, us, cf, ( 5350.29, 3928.29, 195.79 ), ( 0, 0, 0 ), "cspf_0_auto11819280120952327644" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_quest_mq_robot_locate_cs";
    s.groupid = "Pyres - SW";
    fe [[ f ]]( s, us, cf, ( 933.3, 973.44, 224 ), ( 0, 0, 0 ), "quest_mq_pyre", undefined, "sw" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_quest_mq_robot_locate_cs";
    fe [[ f ]]( s, us, cf, ( 4905.4, 7041.45, 522.11 ), ( 0, 270, 0 ), "mq_locate_wall" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_quest_mq_robot_locate_cs";
    fe [[ f ]]( s, us, cf, ( 4939.95, 6885.61, 320.15 ), ( 0, 0, 0 ), "mqlo_di_lo" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_quest_mq_robot_locate_cs";
    s.groupid = "Church Candles";
    s.script_radius = int( 128 );
    fe [[ f ]]( s, us, cf, ( 4695, 7000, 360 ), ( 0, 330.4, 0 ), "mq_locate_candle", undefined, undefined, undefined, undefined, undefined, undefined, 128 );
    s = {};
    s.script_cs_flag = "zm_sat_locust_quest_mq_robot_locate_cs";
    s.groupid = "Church Candles";
    s.script_radius = int( 128 );
    fe [[ f ]]( s, us, cf, ( 5014, 7008, 336 ), ( 0, 178.8, 0 ), "mq_locate_candle", undefined, undefined, undefined, undefined, undefined, undefined, 128 );
    s = {};
    s.script_cs_flag = "zm_sat_locust_quest_mq_robot_locate_cs";
    s.groupid = "Church Candles";
    s.script_radius = int( 128 );
    fe [[ f ]]( s, us, cf, ( 5185, 6755, 360 ), ( 0, 112.8, 0 ), "mq_locate_candle", undefined, undefined, undefined, undefined, undefined, undefined, 128 );
    s = {};
    s.script_cs_flag = "zm_sat_locust_quest_mq_robot_locate_cs";
    s.groupid = "Church Candles";
    s.script_radius = int( 128 );
    fe [[ f ]]( s, us, cf, ( 4697, 6752, 360 ), ( 0, 37.5, 0 ), "mq_locate_candle", undefined, undefined, undefined, undefined, undefined, undefined, 128 );
    s = {};
    s.script_cs_flag = "zm_sat_locust_quest_mq_robot_locate_cs";
    s.groupid = "dmqlo_do_blo";
    fe [[ f ]]( s, us, cf, ( 4846, 4218, 144 ), ( 0, 90, 0 ), "mqlo_do_blo" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_quest_mq_robot_locate_cs";
    fe [[ f ]]( s, us, cf, ( 4940, 6885, 1550 ), ( 180, 0, 0 ), "mqlo_co_lo" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_quest_mq_robot_locate_cs";
    fe [[ f ]]( s, us, cf, ( 9221.74, 24704.6, 5813.32 ), ( 0, 0, 0 ), "mq_vi_la" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_quest_mq_robot_locate_cs";
    s.groupid = "mqlo_do_blo";
    fe [[ f ]]( s, us, cf, ( 4259, 3927, 152 ), ( 0, 180, 0 ), "mqlo_do_blo" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_quest_mq_robot_locate_cs";
    s.groupid = "mqlo_do_blo";
    fe [[ f ]]( s, us, cf, ( 5020, 3636, 191 ), ( 0, 270, 0 ), "mqlo_do_blo" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_quest_mq_robot_locate_cs";
    s.groupid = "mqlo_do_blo";
    fe [[ f ]]( s, us, cf, ( 5680, 3665.5, 145 ), ( 0, 0, 0 ), "mqlo_do_blo" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_quest_mq_robot_locate_cs";
    s.groupid = "mqlo_do_blo";
    fe [[ f ]]( s, us, cf, ( 5355, 4219, 167 ), ( 0, 90, 0 ), "mqlo_do_blo" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_quest_mq_robot_locate_cs";
    s.groupid = "mqlo_do_blo";
    fe [[ f ]]( s, us, cf, ( 5775, 4089.5, 153 ), ( 0, 90, 0 ), "mqlo_do_blo" );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace zm_sat_locust_quest_mq_robot_locate_cs
// Params 0, eflags: 0x4
// Checksum 0xefcec9ee, Offset: 0xc6f
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace zm_sat_locust_quest_mq_robot_locate_cs
// Params 0
// Checksum 0x992c2d82, Offset: 0xc79
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "zm_sat_locust_quest_mq_robot_locate_cs" );
}

