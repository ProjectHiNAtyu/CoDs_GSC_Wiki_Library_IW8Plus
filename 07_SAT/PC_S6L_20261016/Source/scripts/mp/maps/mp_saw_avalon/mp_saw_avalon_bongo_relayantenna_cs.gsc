// scripts\mp\maps\mp_saw_avalon\mp_saw_avalon_bongo_relayantenna_cs.gsc  (hash_1486905dfd57223f.gscc) (size: 28794 Bytes / 0x707a / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x49cde22f (1238229551)
// size ...... 28794 (0x707a)
// includes .. 4   (offset: 0x5c22)
// strings ... 228 (offset: 0x5c42)
// dev strs .. 0   (offset: 0x707a)
// exports ... 13  (offset: 0x573e)
// cseg ...... 0x1ba6 + 0x3b98 (0x573e)
// imports ... 26  (offset: 0x5946)
// animtree1 . 0   (offset: 0x707a)
// animtree2 . 0   (offset: 0x707a)
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace mp_saw_avalon_bongo_relayantenna_cs;

// Namespace mp_saw_avalon_bongo_relayantenna_cs
// Params 0, eflags: 0x5
// Checksum 0xe0622fca, Offset: 0x1bc4
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"mp_saw_avalon_bongo_relayantenna_cs", #"activity_common", &function_b39ecd3d51489472, undefined );
}

// Namespace mp_saw_avalon_bongo_relayantenna_cs
// Params 0, eflags: 0x4
// Checksum 0xcd5404a1, Offset: 0x1bed
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace mp_saw_avalon_bongo_relayantenna_cs
// Params 0, eflags: 0x4
// Checksum 0x486fd74d, Offset: 0x1bfe
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace mp_saw_avalon_bongo_relayantenna_cs
// Params 2
// Checksum 0xe7883aec, Offset: 0x1c0f
// Size: 0x8c
function main( unused, unused2 )
{
    if ( utility::flag_exist( "mp_saw_avalon_bongo_relayantenna_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "mp_saw_avalon_bongo_relayantenna_cs" ) )
    {
        return;
    }
    
    activity_common::function_e1df676808c1d1e3( &function_4cd78e661617f3 );
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "mp_saw_avalon_bongo_relayantenna_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "mp_saw_avalon_bongo_relayantenna_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace mp_saw_avalon_bongo_relayantenna_cs
// Params 3, eflags: 0x4
// Checksum 0xcbed6382, Offset: 0x1ca3
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "mp_saw_avalon_bongo_relayantenna_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "mp_saw_avalon_bongo_relayantenna_cs" );
}

// Namespace mp_saw_avalon_bongo_relayantenna_cs
// Params 3, eflags: 0x4
// Checksum 0x468206be, Offset: 0x1d1d
// Size: 0x1ca8
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_relayantenna_cs";
    s.entity_id = "mp_saw_avalon_bongo_relayantenna_cs_1";
    s.activity_bundle = "saw_bongo_activity_relay_antenna";
    s.name = "loc01_relay_antenna";
    fe [[ f ]]( s, "loc01_relay_antenna", cf, ( -39108.3, -23889.7, 257.61 ), ( 0, 0, 0 ), "activity_nexus_variant", "loc01_relay_antenna", undefined, "activity_link", undefined, undefined, undefined, 100 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_relayantenna_cs";
    s.entity_id = "mp_saw_avalon_bongo_relayantenna_cs_3";
    s.activity_bundle = "saw_bongo_activity_relay_antenna";
    s.name = "loc02_relay_antenna";
    fe [[ f ]]( s, "loc01_relay_antenna", cf, ( -25820.2, -34212.1, 889.02 ), ( 0, 0, 0 ), "activity_nexus_variant", "loc02_relay_antenna", undefined, "activity_link", undefined, undefined, undefined, 100 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_relayantenna_cs";
    s.entity_id = "mp_saw_avalon_bongo_relayantenna_cs_4";
    s.activity_bundle = "saw_bongo_activity_relay_antenna";
    s.name = "loc04_relay_antenna";
    fe [[ f ]]( s, "loc01_relay_antenna", cf, ( -19263.1, 2593.46, 613.3 ), ( 0, 0, 0 ), "activity_nexus_variant", "loc04_relay_antenna", undefined, "activity_link", undefined, undefined, undefined, 100 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_relayantenna_cs";
    s.entity_id = "mp_saw_avalon_bongo_relayantenna_cs_8";
    s.activity_bundle = "saw_bongo_activity_relay_antenna";
    s.name = "loc41_relay_antenna";
    fe [[ f ]]( s, "loc01_relay_antenna", cf, ( 21959, 55771.2, 704.89 ), ( 0, 0, 0 ), "activity_nexus_variant", "loc41_relay_antenna", undefined, "activity_link", undefined, undefined, undefined, 100 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_relayantenna_cs";
    s.entity_id = "mp_saw_avalon_bongo_relayantenna_cs_10";
    s.activity_bundle = "saw_bongo_activity_relay_antenna";
    s.name = "loc09_relay_antenna";
    fe [[ f ]]( s, "loc01_relay_antenna", cf, ( -23479.4, 16193.3, 1648.3 ), ( 0, 0, 0 ), "activity_nexus_variant", "loc09_relay_antenna", undefined, "activity_link", undefined, undefined, undefined, 100 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_relayantenna_cs";
    s.entity_id = "mp_saw_avalon_bongo_relayantenna_cs_11";
    s.activity_bundle = "saw_bongo_activity_relay_antenna";
    s.name = "loc42_relay_antenna";
    fe [[ f ]]( s, "loc01_relay_antenna", cf, ( 1207.67, 2711.87, 538.7 ), ( 0, 0, 0 ), "activity_nexus_variant", "loc42_relay_antenna", undefined, "activity_link", undefined, undefined, undefined, 100 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_relayantenna_cs";
    s.entity_id = "mp_saw_avalon_bongo_relayantenna_cs_14";
    s.activity_bundle = "saw_bongo_activity_relay_antenna";
    s.name = "loc43_relay_antenna";
    fe [[ f ]]( s, "loc01_relay_antenna", cf, ( -1448.09, -18516, 173.12 ), ( 0, 0, 0 ), "activity_nexus_variant", "loc43_relay_antenna", undefined, "activity_link", undefined, undefined, undefined, 100 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_relayantenna_cs";
    s.entity_id = "mp_saw_avalon_bongo_relayantenna_cs_17";
    s.activity_bundle = "saw_bongo_activity_relay_antenna";
    s.name = "loc44_relay_antenna";
    fe [[ f ]]( s, "loc01_relay_antenna", cf, ( 4049.8, -28419.3, 1363.31 ), ( 0, 0, 0 ), "activity_nexus_variant", "loc44_relay_antenna", undefined, "activity_link", undefined, undefined, undefined, 100 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_relayantenna_cs";
    s.entity_id = "mp_saw_avalon_bongo_relayantenna_cs_20";
    s.activity_bundle = "saw_bongo_activity_relay_antenna";
    s.name = "loc45_relay_antenna";
    fe [[ f ]]( s, "loc01_relay_antenna", cf, ( -13925.3, -40468.4, 395.15 ), ( 0, 0, 0 ), "activity_nexus_variant", "loc45_relay_antenna", undefined, "activity_link", undefined, undefined, undefined, 100 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_relayantenna_cs";
    s.entity_id = "mp_saw_avalon_bongo_relayantenna_cs_23";
    s.activity_bundle = "saw_bongo_activity_relay_antenna";
    s.name = "loc46_relay_antenna";
    fe [[ f ]]( s, "loc01_relay_antenna", cf, ( 1292.48, 52250.9, 621.75 ), ( 0, 0, 0 ), "activity_nexus_variant", "loc46_relay_antenna", undefined, "activity_link", undefined, undefined, undefined, 100 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_relayantenna_cs";
    s.entity_id = "mp_saw_avalon_bongo_relayantenna_cs_26";
    s.activity_bundle = "saw_bongo_activity_relay_antenna";
    s.name = "loc47_relay_antenna";
    fe [[ f ]]( s, "loc01_relay_antenna", cf, ( 18923.5, 19747.5, 754.89 ), ( 0, 0, 0 ), "activity_nexus_variant", "loc47_relay_antenna", undefined, "activity_link", undefined, undefined, undefined, 100 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_relayantenna_cs";
    s.entity_id = "mp_saw_avalon_bongo_relayantenna_cs_29";
    s.activity_bundle = "saw_bongo_activity_relay_antenna";
    s.name = "loc48_relay_antenna";
    fe [[ f ]]( s, "loc01_relay_antenna", cf, ( 13051.7, -15809.5, 3135.09 ), ( 0, 0, 0 ), "activity_nexus_variant", "loc48_relay_antenna", undefined, "activity_link", undefined, undefined, undefined, 100 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_relayantenna_cs";
    s.entity_id = "mp_saw_avalon_bongo_relayantenna_cs_32";
    s.activity_bundle = "saw_bongo_activity_relay_antenna";
    s.name = "loc49_relay_antenna";
    fe [[ f ]]( s, "loc01_relay_antenna", cf, ( 7659.53, -42027.1, 1916.15 ), ( 0, 0, 0 ), "activity_nexus_variant", "loc49_relay_antenna", undefined, "activity_link", undefined, undefined, undefined, 100 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_relayantenna_cs";
    s.entity_id = "mp_saw_avalon_bongo_relayantenna_cs_35";
    s.activity_bundle = "saw_bongo_activity_relay_antenna";
    s.name = "loc50_relay_antenna";
    fe [[ f ]]( s, "loc01_relay_antenna", cf, ( -11160.9, -47880.8, 150.36 ), ( 0, 0, 0 ), "activity_nexus_variant", "loc50_relay_antenna", undefined, "activity_link", undefined, undefined, undefined, 100 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_relayantenna_cs";
    s.entity_id = "mp_saw_avalon_bongo_relayantenna_cs_38";
    s.activity_bundle = "saw_bongo_activity_relay_antenna";
    s.name = "loc51_relay_antenna";
    fe [[ f ]]( s, "loc01_relay_antenna", cf, ( 26792.1, -15648.8, 377.25 ), ( 0, 0, 0 ), "activity_nexus_variant", "loc51_relay_antenna", undefined, "activity_link", undefined, undefined, undefined, 100 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_relayantenna_cs";
    s.entity_id = "mp_saw_avalon_bongo_relayantenna_cs_47";
    s.activity_bundle = "saw_bongo_activity_relay_antenna";
    s.name = "loc52_relay_antenna";
    fe [[ f ]]( s, "loc01_relay_antenna", cf, ( 35250.1, 16999.7, 1070.84 ), ( 0, 0, 0 ), "activity_nexus_variant", "loc52_relay_antenna", undefined, "activity_link", undefined, undefined, undefined, 100 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_relayantenna_cs";
    s.entity_id = "mp_saw_avalon_bongo_relayantenna_cs_54";
    s.activity_bundle = "saw_bongo_activity_relay_antenna";
    s.name = "loc53_relay_antenna";
    fe [[ f ]]( s, "loc01_relay_antenna", cf, ( -24479.2, -14155.4, 1436.7 ), ( 0, 0, 0 ), "activity_nexus_variant", "loc53_relay_antenna", undefined, "activity_link", undefined, undefined, undefined, 100 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_relayantenna_cs";
    s.entity_id = "mp_saw_avalon_bongo_relayantenna_cs_61";
    s.activity_bundle = "saw_bongo_activity_relay_antenna";
    s.name = "loc54_relay_antenna";
    fe [[ f ]]( s, "loc01_relay_antenna", cf, ( 58860.4, -15766.5, 2411.3 ), ( 0, 0, 0 ), "activity_nexus_variant", "loc54_relay_antenna", undefined, "activity_link", undefined, undefined, undefined, 100 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_relayantenna_cs";
    s.entity_id = "mp_saw_avalon_bongo_relayantenna_cs_74";
    s.activity_bundle = "saw_bongo_activity_relay_antenna";
    s.name = "loc55_relay_antenna";
    fe [[ f ]]( s, "loc01_relay_antenna", cf, ( 20670.2, -53320, 193.87 ), ( 0, 0, 0 ), "activity_nexus_variant", "loc55_relay_antenna", undefined, "activity_link", undefined, undefined, undefined, 100 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_relayantenna_cs";
    s.entity_id = "mp_saw_avalon_bongo_relayantenna_cs_83";
    s.activity_bundle = "saw_bongo_activity_relay_antenna";
    s.name = "loc03_relay_antenna";
    fe [[ f ]]( s, "loc01_relay_antenna", cf, ( 42367.8, -20326.7, 358.22 ), ( 0, 0, 0 ), "activity_nexus_variant", "loc03_relay_antenna", undefined, "activity_link", undefined, undefined, undefined, 100 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_relayantenna_cs";
    s.entity_id = "mp_saw_avalon_bongo_relayantenna_cs_85";
    s.activity_bundle = "saw_bongo_activity_relay_antenna";
    s.name = "loc06_relay_antenna";
    fe [[ f ]]( s, "loc01_relay_antenna", cf, ( -27425, 54255.3, 2552.02 ), ( 0, 0, 0 ), "activity_nexus_variant", "loc06_relay_antenna", undefined, "activity_link", undefined, undefined, undefined, 100 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_relayantenna_cs";
    s.entity_id = "mp_saw_avalon_bongo_relayantenna_cs_87";
    s.activity_bundle = "saw_bongo_activity_relay_antenna";
    s.name = "loc07_relay_antenna";
    fe [[ f ]]( s, "loc01_relay_antenna", cf, ( -7357.73, -32881.7, 152.54 ), ( 0, 0, 0 ), "activity_nexus_variant", "loc07_relay_antenna", undefined, "activity_link", undefined, undefined, undefined, 100 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_relayantenna_cs";
    s.entity_id = "mp_saw_avalon_bongo_relayantenna_cs_88";
    s.activity_bundle = "saw_bongo_activity_relay_antenna";
    s.name = "loc05_relay_antenna";
    fe [[ f ]]( s, "loc01_relay_antenna", cf, ( 14675, 5810.51, 364.52 ), ( 0, 0, 0 ), "activity_nexus_variant", "loc05_relay_antenna", undefined, "activity_link", undefined, undefined, undefined, 100 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_relayantenna_cs";
    s.entity_id = "mp_saw_avalon_bongo_relayantenna_cs_92";
    s.activity_bundle = "saw_bongo_activity_relay_antenna";
    s.name = "loc08_relay_antenna";
    fe [[ f ]]( s, "loc01_relay_antenna", cf, ( -33386.8, 31343.7, 1667.58 ), ( 0, 0, 0 ), "activity_nexus_variant", "loc08_relay_antenna", undefined, "activity_link", undefined, undefined, undefined, 100 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_relayantenna_cs";
    s.entity_id = "mp_saw_avalon_bongo_relayantenna_cs_95";
    s.activity_bundle = "saw_bongo_activity_relay_antenna";
    s.name = "loc10_relay_antenna";
    fe [[ f ]]( s, "loc01_relay_antenna", cf, ( -32092.3, 5548.19, 60.91 ), ( 0, 0, 0 ), "activity_nexus_variant", "loc10_relay_antenna", undefined, "activity_link", undefined, undefined, undefined, 100 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_relayantenna_cs";
    s.entity_id = "mp_saw_avalon_bongo_relayantenna_cs_96";
    s.activity_bundle = "saw_bongo_activity_relay_antenna";
    s.name = "loc12_relay_antenna";
    fe [[ f ]]( s, "loc01_relay_antenna", cf, ( 15975.8, 29138.8, 1400.29 ), ( 0, 0, 0 ), "activity_nexus_variant", "loc12_relay_antenna", undefined, "activity_link", undefined, undefined, undefined, 100 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_relayantenna_cs";
    s.entity_id = "mp_saw_avalon_bongo_relayantenna_cs_98";
    s.activity_bundle = "saw_bongo_activity_relay_antenna";
    s.name = "loc11_relay_antenna";
    fe [[ f ]]( s, "loc01_relay_antenna", cf, ( 28205, -34910, 149.86 ), ( 0, 0, 0 ), "activity_nexus_variant", "loc11_relay_antenna", undefined, "activity_link", undefined, undefined, undefined, 100 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_relayantenna_cs";
    s.entity_id = "mp_saw_avalon_bongo_relayantenna_cs_101";
    s.activity_bundle = "saw_bongo_activity_relay_antenna";
    s.name = "loc13_relay_antenna";
    fe [[ f ]]( s, "loc01_relay_antenna", cf, ( -11900.8, 32124.1, 601.51 ), ( 0, 0, 0 ), "activity_nexus_variant", "loc13_relay_antenna", undefined, "activity_link", undefined, undefined, undefined, 100 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_relayantenna_cs";
    s.entity_id = "mp_saw_avalon_bongo_relayantenna_cs_103";
    s.activity_bundle = "saw_bongo_activity_relay_antenna";
    s.name = "loc14_relay_antenna";
    fe [[ f ]]( s, "loc01_relay_antenna", cf, ( 42058.1, -6741.54, 318.49 ), ( 0, 0, 0 ), "activity_nexus_variant", "loc14_relay_antenna", undefined, "activity_link", undefined, undefined, undefined, 100 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_relayantenna_cs";
    s.entity_id = "mp_saw_avalon_bongo_relayantenna_cs_105";
    s.activity_bundle = "saw_bongo_activity_relay_antenna";
    s.name = "loc15_relay_antenna";
    fe [[ f ]]( s, "loc01_relay_antenna", cf, ( -28964.5, 40490.5, 1681.23 ), ( 0, 0, 0 ), "activity_nexus_variant", "loc15_relay_antenna", undefined, "activity_link", undefined, undefined, undefined, 100 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_relayantenna_cs";
    s.entity_id = "mp_saw_avalon_bongo_relayantenna_cs_107";
    s.activity_bundle = "saw_bongo_activity_relay_antenna";
    s.name = "loc16_relay_antenna";
    fe [[ f ]]( s, "loc01_relay_antenna", cf, ( -9392.11, 40451.4, 292.15 ), ( 0, 0, 0 ), "activity_nexus_variant", "loc16_relay_antenna", undefined, "activity_link", undefined, undefined, undefined, 100 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_relayantenna_cs";
    s.entity_id = "mp_saw_avalon_bongo_relayantenna_cs_109";
    s.activity_bundle = "saw_bongo_activity_relay_antenna";
    s.name = "loc17_relay_antenna";
    fe [[ f ]]( s, "loc01_relay_antenna", cf, ( -15502.8, 21295.7, 1454.83 ), ( 0, 0, 0 ), "activity_nexus_variant", "loc17_relay_antenna", undefined, "activity_link", undefined, undefined, undefined, 100 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_relayantenna_cs";
    s.entity_id = "mp_saw_avalon_bongo_relayantenna_cs_111";
    s.activity_bundle = "saw_bongo_activity_relay_antenna";
    s.name = "loc18_relay_antenna";
    fe [[ f ]]( s, "loc01_relay_antenna", cf, ( -42913.3, 26038.1, 1609.99 ), ( 0, 0, 0 ), "activity_nexus_variant", "loc18_relay_antenna", undefined, "activity_link", undefined, undefined, undefined, 100 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_relayantenna_cs";
    s.entity_id = "mp_saw_avalon_bongo_relayantenna_cs_113";
    s.activity_bundle = "saw_bongo_activity_relay_antenna";
    s.name = "loc19_relay_antenna";
    fe [[ f ]]( s, "loc01_relay_antenna", cf, ( -24809.1, 33375.3, 2370 ), ( 0, 0, 0 ), "activity_nexus_variant", "loc19_relay_antenna", undefined, "activity_link", undefined, undefined, undefined, 100 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_relayantenna_cs";
    s.entity_id = "mp_saw_avalon_bongo_relayantenna_cs_115";
    s.activity_bundle = "saw_bongo_activity_relay_antenna";
    s.name = "loc20_relay_antenna";
    fe [[ f ]]( s, "loc01_relay_antenna", cf, ( -35942.4, 43535.7, 2302.4 ), ( 0, 0, 0 ), "activity_nexus_variant", "loc20_relay_antenna", undefined, "activity_link", undefined, undefined, undefined, 100 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_relayantenna_cs";
    s.entity_id = "mp_saw_avalon_bongo_relayantenna_cs_117";
    s.activity_bundle = "saw_bongo_activity_relay_antenna";
    s.name = "loc21_relay_antenna";
    fe [[ f ]]( s, "loc01_relay_antenna", cf, ( 35059, -25494.6, 282.56 ), ( 0, 0, 0 ), "activity_nexus_variant", "loc21_relay_antenna", undefined, "activity_link", undefined, undefined, undefined, 100 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_relayantenna_cs";
    s.entity_id = "mp_saw_avalon_bongo_relayantenna_cs_119";
    s.activity_bundle = "saw_bongo_activity_relay_antenna";
    s.name = "loc22_relay_antenna";
    fe [[ f ]]( s, "loc01_relay_antenna", cf, ( -45437.8, -17086.3, 133.27 ), ( 0, 0, 0 ), "activity_nexus_variant", "loc22_relay_antenna", undefined, "activity_link", undefined, undefined, undefined, 100 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_relayantenna_cs";
    s.entity_id = "mp_saw_avalon_bongo_relayantenna_cs_121";
    s.activity_bundle = "saw_bongo_activity_relay_antenna";
    s.name = "loc23_relay_antenna";
    fe [[ f ]]( s, "loc01_relay_antenna", cf, ( -45343.9, 9119.8, 381.36 ), ( 0, 0, 0 ), "activity_nexus_variant", "loc23_relay_antenna", undefined, "activity_link", undefined, undefined, undefined, 100 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_relayantenna_cs";
    s.entity_id = "mp_saw_avalon_bongo_relayantenna_cs_123";
    s.activity_bundle = "saw_bongo_activity_relay_antenna";
    s.name = "loc24_relay_antenna";
    fe [[ f ]]( s, "loc01_relay_antenna", cf, ( 2763.32, 25868.9, 529.17 ), ( 0, 0, 0 ), "activity_nexus_variant", "loc24_relay_antenna", undefined, "activity_link", undefined, undefined, undefined, 100 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_relayantenna_cs";
    s.entity_id = "mp_saw_avalon_bongo_relayantenna_cs_125";
    s.activity_bundle = "saw_bongo_activity_relay_antenna";
    s.name = "loc25_relay_antenna";
    fe [[ f ]]( s, "loc01_relay_antenna", cf, ( -21717.1, 43576.4, 1451.89 ), ( 0, 0, 0 ), "activity_nexus_variant", "loc25_relay_antenna", undefined, "activity_link", undefined, undefined, undefined, 100 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_relayantenna_cs";
    s.entity_id = "mp_saw_avalon_bongo_relayantenna_cs_127";
    s.activity_bundle = "saw_bongo_activity_relay_antenna";
    s.name = "loc26_relay_antenna";
    fe [[ f ]]( s, "loc01_relay_antenna", cf, ( -12621.4, 12034.9, 1089.9 ), ( 0, 0, 0 ), "activity_nexus_variant", "loc26_relay_antenna", undefined, "activity_link", undefined, undefined, undefined, 100 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_relayantenna_cs";
    s.entity_id = "mp_saw_avalon_bongo_relayantenna_cs_129";
    s.activity_bundle = "saw_bongo_activity_relay_antenna";
    s.name = "loc27_relay_antenna";
    fe [[ f ]]( s, "loc01_relay_antenna", cf, ( 26094.7, -937.46, 1141.89 ), ( 0, 0, 0 ), "activity_nexus_variant", "loc27_relay_antenna", undefined, "activity_link", undefined, undefined, undefined, 100 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_relayantenna_cs";
    s.entity_id = "mp_saw_avalon_bongo_relayantenna_cs_131";
    s.activity_bundle = "saw_bongo_activity_relay_antenna";
    s.name = "loc28_relay_antenna";
    fe [[ f ]]( s, "loc01_relay_antenna", cf, ( -30235.7, -6063.46, 453.08 ), ( 0, 0, 0 ), "activity_nexus_variant", "loc28_relay_antenna", undefined, "activity_link", undefined, undefined, undefined, 100 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_relayantenna_cs";
    s.entity_id = "mp_saw_avalon_bongo_relayantenna_cs_133";
    s.activity_bundle = "saw_bongo_activity_relay_antenna";
    s.name = "loc29_relay_antenna";
    fe [[ f ]]( s, "loc01_relay_antenna", cf, ( -30901.7, -44498, 20.17 ), ( 0, 0, 0 ), "activity_nexus_variant", "loc29_relay_antenna", undefined, "activity_link", undefined, undefined, undefined, 100 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_relayantenna_cs";
    s.entity_id = "mp_saw_avalon_bongo_relayantenna_cs_135";
    s.activity_bundle = "saw_bongo_activity_relay_antenna";
    s.name = "loc30_relay_antenna";
    fe [[ f ]]( s, "loc01_relay_antenna", cf, ( 24752.9, 9701.68, 835.84 ), ( 0, 0, 0 ), "activity_nexus_variant", "loc30_relay_antenna", undefined, "activity_link", undefined, undefined, undefined, 100 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_relayantenna_cs";
    s.entity_id = "mp_saw_avalon_bongo_relayantenna_cs_137";
    s.activity_bundle = "saw_bongo_activity_relay_antenna";
    s.name = "loc31_relay_antenna";
    fe [[ f ]]( s, "loc01_relay_antenna", cf, ( -14411.4, 52424.9, 564 ), ( 0, 0, 0 ), "activity_nexus_variant", "loc31_relay_antenna", undefined, "activity_link", undefined, undefined, undefined, 100 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_relayantenna_cs";
    s.entity_id = "mp_saw_avalon_bongo_relayantenna_cs_139";
    s.activity_bundle = "saw_bongo_activity_relay_antenna";
    s.name = "loc32_relay_antenna";
    fe [[ f ]]( s, "loc01_relay_antenna", cf, ( 54966.4, 8162.76, 1834.84 ), ( 0, 0, 0 ), "activity_nexus_variant", "loc32_relay_antenna", undefined, "activity_link", undefined, undefined, undefined, 100 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_relayantenna_cs";
    s.entity_id = "mp_saw_avalon_bongo_relayantenna_cs_141";
    s.activity_bundle = "saw_bongo_activity_relay_antenna";
    s.name = "loc33_relay_antenna";
    fe [[ f ]]( s, "loc01_relay_antenna", cf, ( 54014.5, 16898.8, 317.11 ), ( 0, 0, 0 ), "activity_nexus_variant", "loc33_relay_antenna", undefined, "activity_link", undefined, undefined, undefined, 100 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_relayantenna_cs";
    s.entity_id = "mp_saw_avalon_bongo_relayantenna_cs_143";
    s.activity_bundle = "saw_bongo_activity_relay_antenna";
    s.name = "loc34_relay_antenna";
    fe [[ f ]]( s, "loc01_relay_antenna", cf, ( 45440.7, 28629.8, 809.19 ), ( 0, 0, 0 ), "activity_nexus_variant", "loc34_relay_antenna", undefined, "activity_link", undefined, undefined, undefined, 100 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_relayantenna_cs";
    s.entity_id = "mp_saw_avalon_bongo_relayantenna_cs_145";
    s.activity_bundle = "saw_bongo_activity_relay_antenna";
    s.name = "loc35_relay_antenna";
    fe [[ f ]]( s, "loc01_relay_antenna", cf, ( 10214, 1454.44, 758.59 ), ( 0, 0, 0 ), "activity_nexus_variant", "loc35_relay_antenna", undefined, "activity_link", undefined, undefined, undefined, 100 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_relayantenna_cs";
    s.entity_id = "mp_saw_avalon_bongo_relayantenna_cs_147";
    s.activity_bundle = "saw_bongo_activity_relay_antenna";
    s.name = "loc36_relay_antenna";
    fe [[ f ]]( s, "loc01_relay_antenna", cf, ( 20425.1, -27946.7, 1382.24 ), ( 0, 0, 0 ), "activity_nexus_variant", "loc36_relay_antenna", undefined, "activity_link", undefined, undefined, undefined, 100 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_relayantenna_cs";
    s.entity_id = "mp_saw_avalon_bongo_relayantenna_cs_149";
    s.activity_bundle = "saw_bongo_activity_relay_antenna";
    s.name = "loc37_relay_antenna";
    fe [[ f ]]( s, "loc01_relay_antenna", cf, ( -15697.3, -14602.6, 230.61 ), ( 0, 0, 0 ), "activity_nexus_variant", "loc37_relay_antenna", undefined, "activity_link", undefined, undefined, undefined, 100 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_relayantenna_cs";
    s.entity_id = "mp_saw_avalon_bongo_relayantenna_cs_151";
    s.activity_bundle = "saw_bongo_activity_relay_antenna";
    s.name = "loc38_relay_antenna";
    fe [[ f ]]( s, "loc01_relay_antenna", cf, ( -4195.29, 36611.3, 119.14 ), ( 0, 0, 0 ), "activity_nexus_variant", "loc38_relay_antenna", undefined, "activity_link", undefined, undefined, undefined, 100 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_relayantenna_cs";
    s.entity_id = "mp_saw_avalon_bongo_relayantenna_cs_153";
    s.activity_bundle = "saw_bongo_activity_relay_antenna";
    s.name = "loc39_relay_antenna";
    fe [[ f ]]( s, "loc01_relay_antenna", cf, ( -32321.1, -14942.3, 292.12 ), ( 0, 0, 0 ), "activity_nexus_variant", "loc39_relay_antenna", undefined, "activity_link", undefined, undefined, undefined, 100 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_relayantenna_cs";
    s.entity_id = "mp_saw_avalon_bongo_relayantenna_cs_156";
    s.activity_bundle = "saw_bongo_activity_relay_antenna";
    s.name = "loc40_relay_antenna";
    fe [[ f ]]( s, "loc01_relay_antenna", cf, ( -48260.3, -8571.02, 128.01 ), ( 0, 0, 0 ), "activity_nexus_variant", "loc40_relay_antenna", undefined, "activity_link", undefined, undefined, undefined, 100 );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace mp_saw_avalon_bongo_relayantenna_cs
// Params 0, eflags: 0x4
// Checksum 0xf00c8ea1, Offset: 0x39cd
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace mp_saw_avalon_bongo_relayantenna_cs
// Params 0
// Checksum 0x9bebecf, Offset: 0x39d7
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "mp_saw_avalon_bongo_relayantenna_cs" );
}

// Namespace mp_saw_avalon_bongo_relayantenna_cs
// Params 0
// Checksum 0xdd9bb46e, Offset: 0x39ed
// Size: 0x44
function function_4cd78e661617f3()
{
    activityinfostruct = {};
    activityinfostruct.mainfunction = &main;
    activityinfostruct.var_934f068483ae4ddb = &function_d4323822d7042e5a;
    activityinfostruct.metadatafunction = &function_d9dd7965c51c95d1;
    return activityinfostruct;
}

// Namespace mp_saw_avalon_bongo_relayantenna_cs
// Params 4
// Checksum 0xd1d8fdda, Offset: 0x3a3a
// Size: 0x57
function function_d4323822d7042e5a( var_4312b79c960726b6, fe, us, cf = "mp_saw_avalon_bongo_relayantenna_cs" )
{
    switch ( var_4312b79c960726b6 )
    {
        case #"hash_a78dab577ed40f2c":
            function_3229dd8193ee9cc4( fe, us, cf );
            break;
    }
}

// Namespace mp_saw_avalon_bongo_relayantenna_cs
// Params 3
// Checksum 0x7754e686, Offset: 0x3a99
// Size: 0x1bee
function function_3229dd8193ee9cc4( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_relayantenna_cs";
    s.entity_id = "mp_saw_avalon_bongo_relayantenna_cs_2";
    s.name = "loc01_beacon";
    s.variantname = "content_struct";
    fe [[ f ]]( s, "loc01_relay_antenna", cf, ( -38820.3, -23985.7, 266.13 ), ( 0, 0, 0 ), "loc01_relay_antenna", undefined, "beacon", undefined, undefined, undefined, undefined, 3000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_relayantenna_cs";
    s.entity_id = "mp_saw_avalon_bongo_relayantenna_cs_5";
    s.name = "loc04_beacon";
    s.variantname = "content_struct";
    fe [[ f ]]( s, "loc01_relay_antenna", cf, ( -19263.1, 2337.46, 607.49 ), ( 0, 0, 0 ), "loc04_relay_antenna", undefined, "beacon", undefined, undefined, undefined, undefined, 3000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_relayantenna_cs";
    s.entity_id = "mp_saw_avalon_bongo_relayantenna_cs_9";
    s.name = "loc40_beacon";
    s.variantname = "content_struct";
    fe [[ f ]]( s, "loc01_relay_antenna", cf, ( -48458.3, -8443.98, 127.99 ), ( 0, 0, 0 ), "loc40_relay_antenna", undefined, "beacon", undefined, undefined, undefined, undefined, 3000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_relayantenna_cs";
    s.entity_id = "mp_saw_avalon_bongo_relayantenna_cs_12";
    s.name = "loc42_beacon";
    s.variantname = "content_struct";
    fe [[ f ]]( s, "loc01_relay_antenna", cf, ( 786.67, 2637.87, 529.51 ), ( 0, 0, 0 ), "loc42_relay_antenna", undefined, "beacon", undefined, undefined, undefined, undefined, 3000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_relayantenna_cs";
    s.entity_id = "mp_saw_avalon_bongo_relayantenna_cs_15";
    s.name = "loc43_beacon";
    s.variantname = "content_struct";
    fe [[ f ]]( s, "loc01_relay_antenna", cf, ( -1183.09, -18516, 171.97 ), ( 0, 0, 0 ), "loc43_relay_antenna", undefined, "beacon", undefined, undefined, undefined, undefined, 3000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_relayantenna_cs";
    s.entity_id = "mp_saw_avalon_bongo_relayantenna_cs_18";
    s.name = "loc44_beacon";
    s.variantname = "content_struct";
    fe [[ f ]]( s, "loc01_relay_antenna", cf, ( 4031.77, -28069.2, 1384.75 ), ( 0, 0, 0 ), "loc44_relay_antenna", undefined, "beacon", undefined, undefined, undefined, undefined, 3000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_relayantenna_cs";
    s.entity_id = "mp_saw_avalon_bongo_relayantenna_cs_21";
    s.name = "loc45_beacon";
    s.variantname = "content_struct";
    fe [[ f ]]( s, "loc01_relay_antenna", cf, ( -14289.5, -40371.4, 392.51 ), ( 0, 0, 0 ), "loc45_relay_antenna", undefined, "beacon", undefined, undefined, undefined, undefined, 3000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_relayantenna_cs";
    s.entity_id = "mp_saw_avalon_bongo_relayantenna_cs_24";
    s.name = "loc46_beacon";
    s.variantname = "content_struct";
    fe [[ f ]]( s, "loc01_relay_antenna", cf, ( 1249.48, 52708.9, 648.94 ), ( 0, 0, 0 ), "loc46_relay_antenna", undefined, "beacon", undefined, undefined, undefined, undefined, 3000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_relayantenna_cs";
    s.entity_id = "mp_saw_avalon_bongo_relayantenna_cs_27";
    s.name = "loc47_beacon";
    s.variantname = "content_struct";
    fe [[ f ]]( s, "loc01_relay_antenna", cf, ( 19136.5, 19998.9, 645.9 ), ( 0, 0, 0 ), "loc47_relay_antenna", undefined, "beacon", undefined, undefined, undefined, undefined, 3000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_relayantenna_cs";
    s.entity_id = "mp_saw_avalon_bongo_relayantenna_cs_30";
    s.name = "loc48_beacon";
    s.variantname = "content_struct";
    fe [[ f ]]( s, "loc01_relay_antenna", cf, ( 12829.7, -15734.5, 3118.47 ), ( 0, 0, 0 ), "loc48_relay_antenna", undefined, "beacon", undefined, undefined, undefined, undefined, 3000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_relayantenna_cs";
    s.entity_id = "mp_saw_avalon_bongo_relayantenna_cs_33";
    s.name = "loc49_beacon";
    s.variantname = "content_struct";
    fe [[ f ]]( s, "loc01_relay_antenna", cf, ( 7465.53, -42029.1, 1772.39 ), ( 0, 0, 0 ), "loc49_relay_antenna", undefined, "beacon", undefined, undefined, undefined, undefined, 3000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_relayantenna_cs";
    s.entity_id = "mp_saw_avalon_bongo_relayantenna_cs_36";
    s.name = "loc50_beacon";
    s.variantname = "content_struct";
    fe [[ f ]]( s, "loc01_relay_antenna", cf, ( -11489.9, -48014.8, 40.92 ), ( 0, 0, 0 ), "loc50_relay_antenna", undefined, "beacon", undefined, undefined, undefined, undefined, 3000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_relayantenna_cs";
    s.entity_id = "mp_saw_avalon_bongo_relayantenna_cs_39";
    s.name = "loc51_beacon";
    s.variantname = "content_struct";
    fe [[ f ]]( s, "loc01_relay_antenna", cf, ( 26553.1, -15646.8, 279.61 ), ( 0, 0, 0 ), "loc51_relay_antenna", undefined, "beacon", undefined, undefined, undefined, undefined, 3000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_relayantenna_cs";
    s.entity_id = "mp_saw_avalon_bongo_relayantenna_cs_50";
    s.name = "loc52_beacon";
    s.variantname = "content_struct";
    fe [[ f ]]( s, "loc01_relay_antenna", cf, ( 35077.1, 17160.7, 970.97 ), ( 0, 0, 0 ), "loc52_relay_antenna", undefined, "beacon", undefined, undefined, undefined, undefined, 3000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_relayantenna_cs";
    s.entity_id = "mp_saw_avalon_bongo_relayantenna_cs_57";
    s.name = "loc53_beacon";
    s.variantname = "content_struct";
    fe [[ f ]]( s, "loc01_relay_antenna", cf, ( -24738.2, -14157.4, 1322.11 ), ( 0, 0, 0 ), "loc53_relay_antenna", undefined, "beacon", undefined, undefined, undefined, undefined, 3000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_relayantenna_cs";
    s.entity_id = "mp_saw_avalon_bongo_relayantenna_cs_66";
    s.name = "loc54_beacon";
    s.variantname = "content_struct";
    fe [[ f ]]( s, "loc01_relay_antenna", cf, ( 58878.4, -16034.5, 2302.32 ), ( 0, 0, 0 ), "loc54_relay_antenna", undefined, "beacon", undefined, undefined, undefined, undefined, 3000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_relayantenna_cs";
    s.entity_id = "mp_saw_avalon_bongo_relayantenna_cs_76";
    s.name = "loc55_beacon";
    s.variantname = "content_struct";
    fe [[ f ]]( s, "loc01_relay_antenna", cf, ( 20380.2, -53619, 79.25 ), ( 0, 0, 0 ), "loc55_relay_antenna", undefined, "beacon", undefined, undefined, undefined, undefined, 3000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_relayantenna_cs";
    s.entity_id = "mp_saw_avalon_bongo_relayantenna_cs_82";
    s.name = "loc02_beacon";
    s.variantname = "content_struct";
    fe [[ f ]]( s, "loc01_relay_antenna", cf, ( -25390.4, -34102.4, 728.14 ), ( 0, 0, 0 ), "loc02_relay_antenna", undefined, "beacon", undefined, undefined, undefined, undefined, 3000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_relayantenna_cs";
    s.entity_id = "mp_saw_avalon_bongo_relayantenna_cs_84";
    s.name = "loc03_beacon";
    s.variantname = "content_struct";
    fe [[ f ]]( s, "loc01_relay_antenna", cf, ( 42367.8, -20454.7, 331.8 ), ( 0, 0, 0 ), "loc03_relay_antenna", undefined, "beacon", undefined, undefined, undefined, undefined, 3000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_relayantenna_cs";
    s.entity_id = "mp_saw_avalon_bongo_relayantenna_cs_86";
    s.name = "loc06_beacon";
    s.variantname = "content_struct";
    fe [[ f ]]( s, "loc01_relay_antenna", cf, ( -27168, 54188.3, 2565.67 ), ( 0, 0, 0 ), "loc06_relay_antenna", undefined, "beacon", undefined, undefined, undefined, undefined, 3000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_relayantenna_cs";
    s.entity_id = "mp_saw_avalon_bongo_relayantenna_cs_89";
    s.name = "loc05_beacon";
    s.variantname = "content_struct";
    fe [[ f ]]( s, "loc01_relay_antenna", cf, ( 14835, 6034.51, 352.51 ), ( 0, 0, 0 ), "loc05_relay_antenna", undefined, "beacon", undefined, undefined, undefined, undefined, 3000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_relayantenna_cs";
    s.entity_id = "mp_saw_avalon_bongo_relayantenna_cs_90";
    s.name = "loc07_beacon";
    s.variantname = "content_struct";
    fe [[ f ]]( s, "loc01_relay_antenna", cf, ( -7598.27, -32956.3, 163.4 ), ( 0, 0, 0 ), "loc07_relay_antenna", undefined, "beacon", undefined, undefined, undefined, undefined, 3000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_relayantenna_cs";
    s.entity_id = "mp_saw_avalon_bongo_relayantenna_cs_93";
    s.name = "loc08_beacon";
    s.variantname = "content_struct";
    fe [[ f ]]( s, "loc01_relay_antenna", cf, ( -33283.6, 31669.3, 1637.07 ), ( 0, 0, 0 ), "loc08_relay_antenna", undefined, "beacon", undefined, undefined, undefined, undefined, 3000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_relayantenna_cs";
    s.entity_id = "mp_saw_avalon_bongo_relayantenna_cs_94";
    s.name = "loc09_beacon";
    s.variantname = "content_struct";
    fe [[ f ]]( s, "loc01_relay_antenna", cf, ( -23479.4, 16421.3, 1666.14 ), ( 0, 0, 0 ), "loc09_relay_antenna", undefined, "beacon", undefined, undefined, undefined, undefined, 3000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_relayantenna_cs";
    s.entity_id = "mp_saw_avalon_bongo_relayantenna_cs_97";
    s.name = "loc10_beacon";
    s.variantname = "content_struct";
    fe [[ f ]]( s, "loc01_relay_antenna", cf, ( -32017.7, 5204.81, 112.42 ), ( 0, 0, 0 ), "loc10_relay_antenna", undefined, "beacon", undefined, undefined, undefined, undefined, 3000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_relayantenna_cs";
    s.entity_id = "mp_saw_avalon_bongo_relayantenna_cs_99";
    s.name = "loc11_beacon";
    s.variantname = "content_struct";
    fe [[ f ]]( s, "loc01_relay_antenna", cf, ( 28250, -34724, 152.57 ), ( 0, 0, 0 ), "loc11_relay_antenna", undefined, "beacon", undefined, undefined, undefined, undefined, 3000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_relayantenna_cs";
    s.entity_id = "mp_saw_avalon_bongo_relayantenna_cs_100";
    s.name = "loc12_beacon";
    s.variantname = "content_struct";
    fe [[ f ]]( s, "loc01_relay_antenna", cf, ( 15769.8, 29464.8, 1458.67 ), ( 0, 0, 0 ), "loc12_relay_antenna", undefined, "beacon", undefined, undefined, undefined, undefined, 3000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_relayantenna_cs";
    s.entity_id = "mp_saw_avalon_bongo_relayantenna_cs_102";
    s.name = "loc13_beacon";
    s.variantname = "content_struct";
    fe [[ f ]]( s, "loc01_relay_antenna", cf, ( -12010.8, 32332.1, 611.04 ), ( 0, 0, 0 ), "loc13_relay_antenna", undefined, "beacon", undefined, undefined, undefined, undefined, 3000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_relayantenna_cs";
    s.entity_id = "mp_saw_avalon_bongo_relayantenna_cs_104";
    s.name = "loc14_beacon";
    s.variantname = "content_struct";
    fe [[ f ]]( s, "loc01_relay_antenna", cf, ( 42044.9, -6360.66, 354.16 ), ( 0, 0, 0 ), "loc14_relay_antenna", undefined, "beacon", undefined, undefined, undefined, undefined, 3000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_relayantenna_cs";
    s.entity_id = "mp_saw_avalon_bongo_relayantenna_cs_106";
    s.name = "loc15_beacon";
    s.variantname = "content_struct";
    fe [[ f ]]( s, "loc01_relay_antenna", cf, ( -28961.5, 40163.5, 1629.92 ), ( 0, 0, 0 ), "loc15_relay_antenna", undefined, "beacon", undefined, undefined, undefined, undefined, 3000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_relayantenna_cs";
    s.entity_id = "mp_saw_avalon_bongo_relayantenna_cs_108";
    s.name = "loc16_beacon";
    s.variantname = "content_struct";
    fe [[ f ]]( s, "loc01_relay_antenna", cf, ( -9266.11, 40265.4, 328.69 ), ( 0, 0, 0 ), "loc16_relay_antenna", undefined, "beacon", undefined, undefined, undefined, undefined, 3000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_relayantenna_cs";
    s.entity_id = "mp_saw_avalon_bongo_relayantenna_cs_110";
    s.name = "loc17_beacon";
    s.variantname = "content_struct";
    fe [[ f ]]( s, "loc01_relay_antenna", cf, ( -15154.8, 21204.7, 1431.72 ), ( 0, 0, 0 ), "loc17_relay_antenna", undefined, "beacon", undefined, undefined, undefined, undefined, 3000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_relayantenna_cs";
    s.entity_id = "mp_saw_avalon_bongo_relayantenna_cs_112";
    s.name = "loc18_beacon";
    s.variantname = "content_struct";
    fe [[ f ]]( s, "loc01_relay_antenna", cf, ( -42655.6, 25771.9, 1507.45 ), ( 0, 0, 0 ), "loc18_relay_antenna", undefined, "beacon", undefined, undefined, undefined, undefined, 3000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_relayantenna_cs";
    s.entity_id = "mp_saw_avalon_bongo_relayantenna_cs_114";
    s.name = "loc19_beacon";
    s.variantname = "content_struct";
    fe [[ f ]]( s, "loc01_relay_antenna", cf, ( -25156.4, 33428.5, 2317.21 ), ( 0, 0, 0 ), "loc19_relay_antenna", undefined, "beacon", undefined, undefined, undefined, undefined, 3000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_relayantenna_cs";
    s.entity_id = "mp_saw_avalon_bongo_relayantenna_cs_116";
    s.name = "loc20_beacon";
    s.variantname = "content_struct";
    fe [[ f ]]( s, "loc01_relay_antenna", cf, ( -35987.4, 43976.7, 2354.56 ), ( 0, 0, 0 ), "loc20_relay_antenna", undefined, "beacon", undefined, undefined, undefined, undefined, 3000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_relayantenna_cs";
    s.entity_id = "mp_saw_avalon_bongo_relayantenna_cs_118";
    s.name = "loc21_beacon";
    s.variantname = "content_struct";
    fe [[ f ]]( s, "loc01_relay_antenna", cf, ( 35285, -25248.6, 251.87 ), ( 0, 0, 0 ), "loc21_relay_antenna", undefined, "beacon", undefined, undefined, undefined, undefined, 3000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_relayantenna_cs";
    s.entity_id = "mp_saw_avalon_bongo_relayantenna_cs_120";
    s.name = "loc22_beacon";
    s.variantname = "content_struct";
    fe [[ f ]]( s, "loc01_relay_antenna", cf, ( -45147.2, -16961.5, 31.28 ), ( 0, 0, 0 ), "loc22_relay_antenna", undefined, "beacon", undefined, undefined, undefined, undefined, 3000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_relayantenna_cs";
    s.entity_id = "mp_saw_avalon_bongo_relayantenna_cs_122";
    s.name = "loc23_beacon";
    s.variantname = "content_struct";
    fe [[ f ]]( s, "loc01_relay_antenna", cf, ( -45548.2, 9376.6, 264.55 ), ( 0, 0, 0 ), "loc23_relay_antenna", undefined, "beacon", undefined, undefined, undefined, undefined, 3000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_relayantenna_cs";
    s.entity_id = "mp_saw_avalon_bongo_relayantenna_cs_124";
    s.name = "loc24_beacon";
    s.variantname = "content_struct";
    fe [[ f ]]( s, "loc01_relay_antenna", cf, ( 2947.32, 26291.9, 620.24 ), ( 0, 0, 0 ), "loc24_relay_antenna", undefined, "beacon", undefined, undefined, undefined, undefined, 3000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_relayantenna_cs";
    s.entity_id = "mp_saw_avalon_bongo_relayantenna_cs_126";
    s.name = "loc25_beacon";
    s.variantname = "content_struct";
    fe [[ f ]]( s, "loc01_relay_antenna", cf, ( -21960.1, 43572.4, 1451.85 ), ( 0, 0, 0 ), "loc25_relay_antenna", undefined, "beacon", undefined, undefined, undefined, undefined, 3000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_relayantenna_cs";
    s.entity_id = "mp_saw_avalon_bongo_relayantenna_cs_128";
    s.name = "loc26_beacon";
    s.variantname = "content_struct";
    fe [[ f ]]( s, "loc01_relay_antenna", cf, ( -12721.1, 12254.7, 1109.86 ), ( 0, 0, 0 ), "loc26_relay_antenna", undefined, "beacon", undefined, undefined, undefined, undefined, 3000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_relayantenna_cs";
    s.entity_id = "mp_saw_avalon_bongo_relayantenna_cs_130";
    s.name = "loc27_beacon";
    s.variantname = "content_struct";
    fe [[ f ]]( s, "loc01_relay_antenna", cf, ( 26403.7, -977.65, 1058.15 ), ( 0, 0, 0 ), "loc27_relay_antenna", undefined, "beacon", undefined, undefined, undefined, undefined, 3000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_relayantenna_cs";
    s.entity_id = "mp_saw_avalon_bongo_relayantenna_cs_132";
    s.name = "loc28_beacon";
    s.variantname = "content_struct";
    fe [[ f ]]( s, "loc01_relay_antenna", cf, ( -30467.7, -5763.46, 481.69 ), ( 0, 0, 0 ), "loc28_relay_antenna", undefined, "beacon", undefined, undefined, undefined, undefined, 3000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_relayantenna_cs";
    s.entity_id = "mp_saw_avalon_bongo_relayantenna_cs_134";
    s.name = "loc29_beacon";
    s.variantname = "content_struct";
    fe [[ f ]]( s, "loc01_relay_antenna", cf, ( -31236.7, -44510, 71.45 ), ( 0, 0, 0 ), "loc29_relay_antenna", undefined, "beacon", undefined, undefined, undefined, undefined, 3000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_relayantenna_cs";
    s.entity_id = "mp_saw_avalon_bongo_relayantenna_cs_136";
    s.name = "loc30_beacon";
    s.variantname = "content_struct";
    fe [[ f ]]( s, "loc01_relay_antenna", cf, ( 24529.2, 9856.49, 753.19 ), ( 0, 0, 0 ), "loc30_relay_antenna", undefined, "beacon", undefined, undefined, undefined, undefined, 3000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_relayantenna_cs";
    s.entity_id = "mp_saw_avalon_bongo_relayantenna_cs_138";
    s.name = "loc31_beacon";
    s.variantname = "content_struct";
    fe [[ f ]]( s, "loc01_relay_antenna", cf, ( -14160, 52417.5, 564 ), ( 0, 0, 0 ), "loc31_relay_antenna", undefined, "beacon", undefined, undefined, undefined, undefined, 3000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_relayantenna_cs";
    s.entity_id = "mp_saw_avalon_bongo_relayantenna_cs_140";
    s.name = "loc32_beacon";
    s.variantname = "content_struct";
    fe [[ f ]]( s, "loc01_relay_antenna", cf, ( 54740.4, 8545.91, 1897.86 ), ( 0, 0, 0 ), "loc32_relay_antenna", undefined, "beacon", undefined, undefined, undefined, undefined, 3000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_relayantenna_cs";
    s.entity_id = "mp_saw_avalon_bongo_relayantenna_cs_142";
    s.name = "loc33_beacon";
    s.variantname = "content_struct";
    fe [[ f ]]( s, "loc01_relay_antenna", cf, ( 53866.5, 17110.8, 356.29 ), ( 0, 0, 0 ), "loc33_relay_antenna", undefined, "beacon", undefined, undefined, undefined, undefined, 3000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_relayantenna_cs";
    s.entity_id = "mp_saw_avalon_bongo_relayantenna_cs_144";
    s.name = "loc34_beacon";
    s.variantname = "content_struct";
    fe [[ f ]]( s, "loc01_relay_antenna", cf, ( 45434.8, 28206.8, 844.09 ), ( 0, 0, 0 ), "loc34_relay_antenna", undefined, "beacon", undefined, undefined, undefined, undefined, 3000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_relayantenna_cs";
    s.entity_id = "mp_saw_avalon_bongo_relayantenna_cs_146";
    s.name = "loc35_beacon";
    s.variantname = "content_struct";
    fe [[ f ]]( s, "loc01_relay_antenna", cf, ( 10574.1, 1664.87, 768.59 ), ( 0, 0, 0 ), "loc35_relay_antenna", undefined, "beacon", undefined, undefined, undefined, undefined, 3000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_relayantenna_cs";
    s.entity_id = "mp_saw_avalon_bongo_relayantenna_cs_148";
    s.name = "loc36_beacon";
    s.variantname = "content_struct";
    fe [[ f ]]( s, "loc01_relay_antenna", cf, ( 20716.2, -27724.6, 1288.08 ), ( 0, 0, 0 ), "loc36_relay_antenna", undefined, "beacon", undefined, undefined, undefined, undefined, 3000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_relayantenna_cs";
    s.entity_id = "mp_saw_avalon_bongo_relayantenna_cs_150";
    s.name = "loc37_beacon";
    s.variantname = "content_struct";
    fe [[ f ]]( s, "loc01_relay_antenna", cf, ( -15673.3, -14941.6, 206.64 ), ( 0, 0, 0 ), "loc37_relay_antenna", undefined, "beacon", undefined, undefined, undefined, undefined, 3000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_relayantenna_cs";
    s.entity_id = "mp_saw_avalon_bongo_relayantenna_cs_152";
    s.name = "loc38_beacon";
    s.variantname = "content_struct";
    fe [[ f ]]( s, "loc01_relay_antenna", cf, ( -4190.1, 36142.3, 108.63 ), ( 0, 0, 0 ), "loc38_relay_antenna", undefined, "beacon", undefined, undefined, undefined, undefined, 3000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_relayantenna_cs";
    s.entity_id = "mp_saw_avalon_bongo_relayantenna_cs_154";
    s.name = "loc39_beacon";
    s.variantname = "content_struct";
    fe [[ f ]]( s, "loc01_relay_antenna", cf, ( -32476.1, -15197.4, 289.12 ), ( 0, 0, 0 ), "loc39_relay_antenna", undefined, "beacon", undefined, undefined, undefined, undefined, 3000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_relayantenna_cs";
    s.entity_id = "mp_saw_avalon_bongo_relayantenna_cs_157";
    s.name = "loc41_beacon";
    s.variantname = "content_struct";
    fe [[ f ]]( s, "loc01_relay_antenna", cf, ( 21509, 55657.8, 705.11 ), ( 0, 0, 0 ), "loc41_relay_antenna", undefined, "beacon", undefined, undefined, undefined, undefined, 3000 );
}

// Namespace mp_saw_avalon_bongo_relayantenna_cs
// Params 0
// Checksum 0x87531397, Offset: 0x568f
// Size: 0xae
function function_d9dd7965c51c95d1()
{
    activityinstances = [];
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "saw_bongo_activity_relay_antenna";
    var_881289d7987bc770.cf = "mp_saw_avalon_bongo_relayantenna_cs";
    var_881289d7987bc770.scriptstructorigin = ( -39108.3, -23889.7, 257.61 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [];
    var_881289d7987bc770.var_31ce4477e3543d24 = [];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [];
    var_881289d7987bc770.locationradius = [];
    activityinstances[ "loc01_relay_antenna" ] = var_881289d7987bc770;
    return activityinstances;
}

