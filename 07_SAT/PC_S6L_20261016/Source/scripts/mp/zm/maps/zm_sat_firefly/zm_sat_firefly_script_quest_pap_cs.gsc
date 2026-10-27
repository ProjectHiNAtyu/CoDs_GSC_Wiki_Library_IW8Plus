// scripts\mp\zm\maps\zm_sat_firefly\zm_sat_firefly_script_quest_pap_cs.gsc  (hash_42a88f5b37c3b95f.gscc) (size: 15137 Bytes / 0x3b21 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x41823ce9 (1099054313)
// size ...... 15137 (0x3b21)
// includes .. 3   (offset: 0x324d)
// strings ... 58  (offset: 0x3265)
// dev strs .. 0   (offset: 0x3b21)
// exports ... 9   (offset: 0x2eb5)
// cseg ...... 0x5bd + 0x28f8 (0x2eb5)
// imports ... 20  (offset: 0x301d)
// animtree1 . 0   (offset: 0x3b21)
// animtree2 . 0   (offset: 0x3b21)
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace zm_sat_firefly_script_quest_pap_cs;

// Namespace zm_sat_firefly_script_quest_pap_cs
// Params 0, eflags: 0x5
// Checksum 0xf44b0d15, Offset: 0x5db
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"zm_sat_firefly_script_quest_pap_cs", undefined, &function_b39ecd3d51489472, undefined );
}

// Namespace zm_sat_firefly_script_quest_pap_cs
// Params 0, eflags: 0x4
// Checksum 0x7909e8bc, Offset: 0x5fc
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace zm_sat_firefly_script_quest_pap_cs
// Params 0, eflags: 0x4
// Checksum 0xfc323b50, Offset: 0x60d
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace zm_sat_firefly_script_quest_pap_cs
// Params 2
// Checksum 0x4cdb6d19, Offset: 0x61e
// Size: 0x80
function main( unused, unused2 )
{
    if ( utility::flag_exist( "zm_sat_firefly_script_quest_pap_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "zm_sat_firefly_script_quest_pap_cs" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "zm_sat_firefly_script_quest_pap_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "zm_sat_firefly_script_quest_pap_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace zm_sat_firefly_script_quest_pap_cs
// Params 3, eflags: 0x4
// Checksum 0x7fb08f9f, Offset: 0x6a6
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "zm_sat_firefly_script_quest_pap_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "zm_sat_firefly_script_quest_pap_cs" );
}

// Namespace zm_sat_firefly_script_quest_pap_cs
// Params 3, eflags: 0x4
// Checksum 0xcbf6cb08, Offset: 0x720
// Size: 0x2775
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_quest_pap_cs";
    s.groupid = "T.E.D.D. Head";
    fe [[ f ]]( s, us, cf, ( 23069.6, -345.35, 458.18 ), ( 350.48, 1.25, -5.13 ), "pap_drain_grate" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_quest_pap_cs";
    s.groupid = "Power Switches";
    s.script_parameters = "lakefront";
    fe [[ f ]]( s, us, cf, ( 12838, 2146, 1229.5 ), ( 0, 33.59, 0 ), "power_switch", "cspf_0_auto3421718451930080470" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_quest_pap_cs";
    s.groupid = "T.E.D.D. Head";
    fe [[ f ]]( s, us, cf, ( 23066.5, -341.25, 452.5 ), ( 290.11, 84.38, 68 ), "tedd_head_spawn" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_quest_pap_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s._size_max = ( 124, 109.437, 127.5 );
    s._size_min = ( 124, 124.5, 154 );
    s.var_987019073a9ea125 = "22740.7";
    s.groupid = "Wood Barriers";
    s.height = 128;
    s.length = "128";
    s.name = "noent_volume_trigger_box - farm_to_janus";
    s.width = "128";
    fe [[ f ]]( s, us, cf, ( 16088.5, -4545.5, 608 ), ( 0, 3.33, 0 ), "pap_wood_barrier_trig", "farm_to_janus_ts_db" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_quest_pap_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s._size_max = ( 124, 122.5, 124 );
    s._size_min = ( 124, 119.5, 111 );
    s.var_987016073a9e9a8c = "22740.7";
    s.groupid = "Wood Barrier - Janus to Lakefront";
    s.height = 128;
    s.length = "128";
    s.name = "noent_volume_trigger_box - janus_to_lakefront";
    s.width = "128";
    fe [[ f ]]( s, us, cf, ( 23118.6, 2802.91, 277.4 ), ( 0.01, 320.6, -1.73 ), "pap_wood_barrier_trig", "janus_to_lakefront_ts_db", "janus_door" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_quest_pap_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s._size_max = ( 124, 123, 127.5 );
    s._size_min = ( 124, 128.871, 142 );
    s.var_987018073a9e9ef2 = "22740.7";
    s.groupid = "Wood Barriers";
    s.height = 128;
    s.length = "128";
    s.name = "noent_volume_trigger_box - janus_to_farm";
    s.width = "128";
    fe [[ f ]]( s, us, cf, ( 23643, -1548, 422.25 ), ( 0, 267.84, 0 ), "pap_wood_barrier_trig", "janus_to_farm_ts_db", "janus_door" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_quest_pap_cs";
    s.groupid = "Farm Energy Cysts - Full";
    s.script_label = "3";
    s.script_parameters = "farm";
    fe [[ f ]]( s, us, cf, ( 14903.4, -3838.32, 686.18 ), ( 33.08, 157.76, 88.08 ), "aether_generator_pustule" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_quest_pap_cs";
    fe [[ f ]]( s, us, cf, ( 15913, -4408.5, 510.5 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_quest_pap_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s._size_max = ( 118.5, 124, 110 );
    s._size_min = ( 138.5, 124, 145.5 );
    s.var_987016073a9e9a8c = "22740.7";
    s.groupid = "Wood Barriers";
    s.height = 128;
    s.length = "128";
    s.name = "noent_volume_trigger_box - lakefront_to_janus";
    s.width = "128";
    fe [[ f ]]( s, us, cf, ( 15506.5, 1976, 933 ), ( 0, 322.98, 0 ), "pap_wood_barrier_trig", "lakefront_to_janus_ts_db" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_quest_pap_cs";
    s.groupid = "T.E.D.D. Head";
    fe [[ f ]]( s, us, cf, ( 22996.5, -400, 567.5 ), ( 0, 0, 0 ), "pap_step_1_waypoint" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_quest_pap_cs";
    s.groupid = "Wood Barrier - Janus to Lakefront";
    fe [[ f ]]( s, us, cf, ( 23121.6, 2806.24, 182 ), ( 0, 320.1, 0 ), "pap_wood_barrier", "janus_to_lakefront_ts_db" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_quest_pap_cs";
    fe [[ f ]]( s, us, cf, ( 15665, -4411, 537.5 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_quest_pap_cs";
    s.groupid = "Farm Energy Cysts - Full";
    s.script_label = "2";
    s.script_parameters = "farm";
    fe [[ f ]]( s, us, cf, ( 14896.2, -3800.02, 635.24 ), ( 8.48, 66.99, -99.24 ), "aether_generator_pustule" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_quest_pap_cs";
    s.groupid = "Farm Energy Cysts - Full";
    s.script_label = "1";
    s.script_parameters = "farm";
    fe [[ f ]]( s, us, cf, ( 14936.1, -3931.43, 662.46 ), ( 9.27, 335.33, -2.74 ), "aether_generator_pustule" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_quest_pap_cs";
    s.groupid = "Farm Energy Cysts - Full";
    s.script_label = "3";
    s.script_parameters = "farm";
    fe [[ f ]]( s, us, cf, ( 14877.9, -3841.83, 664.62 ), ( 14.42, 33.92, -103.52 ), "aether_generator_pustule" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_quest_pap_cs";
    s.groupid = "Farm Energy Cysts - Full";
    s.script_label = "1";
    s.script_parameters = "farm";
    fe [[ f ]]( s, us, cf, ( 14864.2, -3858.93, 636.51 ), ( 340.86, 256.2, 88.07 ), "aether_generator_pustule" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_quest_pap_cs";
    s.groupid = "Wood Barriers";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( 15502, 1978.5, 809 ), ( 0, 53.15, 0 ), "pap_wood_barrier", "lakefront_to_janus_ts_db" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_quest_pap_cs";
    s.groupid = "Farm Energy";
    s.name = "script_struct DELETE ME";
    s.script_parameters = "farm";
    s.script_power = "power_farm";
    fe [[ f ]]( s, us, cf, ( 14934.6, -3928.74, 581.95 ), ( 1.81, 254.84, -1.84 ) );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_quest_pap_cs";
    s.groupid = "Farm Energy";
    s.name = "script_struct DELETE ME";
    s.script_parameters = "farm";
    s.script_power = "power_farm";
    fe [[ f ]]( s, us, cf, ( 14831.6, -3903.74, 584.95 ), ( 1.95, 259.23, -1.7 ) );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_quest_pap_cs";
    s.groupid = "Farm Energy";
    s.name = "script_struct DELETE ME";
    s.script_parameters = "farm";
    s.script_power = "power_farm";
    fe [[ f ]]( s, us, cf, ( 14908.1, -3793.24, 590.45 ), ( 356.93, 73.12, 4.51 ) );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_quest_pap_cs";
    s.groupid = "Wood Barriers";
    fe [[ f ]]( s, us, cf, ( 16088, -4546.5, 502 ), ( 0, 3.03, 0 ), "pap_wood_barrier", "farm_to_janus_ts_db" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_quest_pap_cs";
    s.groupid = "Farm Energy Cysts - Full";
    s.script_label = "1";
    s.script_parameters = "farm";
    fe [[ f ]]( s, us, cf, ( 14833.7, -3908.45, 665.69 ), ( 358.2, 113.64, -11.12 ), "aether_generator_pustule" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_quest_pap_cs";
    s.groupid = "Farm Energy Cysts - Full";
    s.script_label = "1";
    s.script_parameters = "farm";
    fe [[ f ]]( s, us, cf, ( 14915.3, -3784.89, 634.04 ), ( 330, 163.07, 88.32 ), "aether_generator_pustule" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_quest_pap_cs";
    s.groupid = "Farm Energy Cysts - Full";
    s.script_label = "1";
    s.script_parameters = "farm";
    fe [[ f ]]( s, us, cf, ( 14834.6, -3893.98, 627.23 ), ( 356.71, 188.71, 87.26 ), "aether_generator_pustule" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_quest_pap_cs";
    s.groupid = "Wood Barriers";
    fe [[ f ]]( s, us, cf, ( 23640, -1549.5, 309 ), ( 0, 88.62, 0 ), "pap_wood_barrier", "janus_to_farm_ts_db" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_quest_pap_cs";
    s.groupid = "Farm Energy Cysts - Full";
    s.script_label = "1";
    s.script_parameters = "farm";
    fe [[ f ]]( s, us, cf, ( 14929.8, -3941.07, 636.45 ), ( 6.56, 153.43, -91.43 ), "aether_generator_pustule" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_quest_pap_cs";
    s.groupid = "Lakefront Energy";
    s.script_parameters = "lakefront";
    s.script_power = "power_lakefront";
    fe [[ f ]]( s, us, cf, ( 12283.8, 1996, 1022.75 ), ( 0, 298.06, 0 ), "aether_generator" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_quest_pap_cs";
    s.groupid = "LAKEFRONT NEW  CYSTS";
    s.script_label = "3";
    s.script_parameters = "lakefront";
    fe [[ f ]]( s, us, cf, ( 12270.3, 2021.73, 1121.02 ), ( 35.94, 200.17, 91.3 ), "aether_generator_pustule" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_quest_pap_cs";
    s.groupid = "LAKEFRONT NEW  CYSTS";
    s.script_label = "2";
    s.script_parameters = "lakefront";
    fe [[ f ]]( s, us, cf, ( 12243.2, 2044.7, 1067.65 ), ( 11.03, 107.07, -102.22 ), "aether_generator_pustule" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_quest_pap_cs";
    s.groupid = "LAKEFRONT NEW  CYSTS";
    s.script_label = "1";
    s.script_parameters = "lakefront";
    fe [[ f ]]( s, us, cf, ( 12357, 1971.74, 1104.02 ), ( 6.26, 15.58, -5.24 ), "aether_generator_pustule" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_quest_pap_cs";
    s.groupid = "LAKEFRONT NEW  CYSTS";
    s.script_label = "3";
    s.script_parameters = "lakefront";
    fe [[ f ]]( s, us, cf, ( 12254.7, 2001.87, 1098.98 ), ( 14.93, 73.49, -107.51 ), "aether_generator_pustule" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_quest_pap_cs";
    s.groupid = "LAKEFRONT NEW  CYSTS";
    s.script_label = "1";
    s.script_parameters = "lakefront";
    fe [[ f ]]( s, us, cf, ( 12256, 1978.72, 1071.57 ), ( 337.87, 295.84, 90.75 ), "aether_generator_pustule" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_quest_pap_cs";
    s.groupid = "LAKEFRONT NEW  CYSTS";
    s.script_label = "1";
    s.script_parameters = "lakefront";
    fe [[ f ]]( s, us, cf, ( 12264.2, 1922.59, 1102.82 ), ( 2.1, 154.22, -11.27 ), "aether_generator_pustule" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_quest_pap_cs";
    s.groupid = "LAKEFRONT NEW  CYSTS";
    s.script_label = "1";
    s.script_parameters = "lakefront";
    fe [[ f ]]( s, us, cf, ( 12248, 2068.58, 1066.09 ), ( 332.68, 202.11, 91.54 ), "aether_generator_pustule" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_quest_pap_cs";
    s.groupid = "LAKEFRONT NEW  CYSTS";
    s.script_label = "1";
    s.script_parameters = "lakefront";
    fe [[ f ]]( s, us, cf, ( 12258, 1933.11, 1063.58 ), ( 357.86, 229.12, 90.99 ), "aether_generator_pustule" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_quest_pap_cs";
    s.groupid = "LAKEFRONT NEW  CYSTS";
    s.script_label = "1";
    s.script_parameters = "lakefront";
    fe [[ f ]]( s, us, cf, ( 12360.2, 1959.61, 1078.47 ), ( 9.63, 194.35, -89.01 ), "aether_generator_pustule" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_quest_pap_cs";
    s.groupid = "LAKEFRONT NEW  CYSTS";
    s.script_label = "1";
    s.script_parameters = "lakefront";
    fe [[ f ]]( s, us, cf, ( 12270.5, 1912.37, 1068.87 ), ( 359.34, 222.56, -91.76 ), "aether_generator_pustule" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_quest_pap_cs";
    s.groupid = "LAKEFRONT NEW  CYSTS";
    s.script_label = "1";
    s.script_parameters = "lakefront";
    fe [[ f ]]( s, us, cf, ( 12293.2, 2024.44, 1108.83 ), ( 358.13, 343.43, -90.37 ), "aether_generator_pustule" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_quest_pap_cs";
    s.groupid = "Lakefront Energy";
    s.script_parameters = "lakefront";
    fe [[ f ]]( s, us, cf, ( 12286, 1991.5, 1167 ), ( 2.32, 119.46, 1.05 ), "aether_generator_infestation_core" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_quest_pap_cs";
    s.groupid = "Farm Energy Cysts - Full";
    s.script_label = "1";
    s.script_parameters = "farm";
    fe [[ f ]]( s, us, cf, ( 14830.8, -3918.19, 631.15 ), ( 357.77, 182.06, -95.33 ), "aether_generator_pustule" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_quest_pap_cs";
    s.groupid = "Farm Energy Cysts - Full";
    s.script_label = "1";
    s.script_parameters = "farm";
    fe [[ f ]]( s, us, cf, ( 14921.8, -3850.71, 672.65 ), ( 1.99, 302.85, -89.89 ), "aether_generator_pustule" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_quest_pap_cs";
    s.groupid = "Farm Energy Cysts - Full";
    s.script_label = "2";
    s.script_parameters = "farm";
    fe [[ f ]]( s, us, cf, ( 14911.9, -3840.8, 639.18 ), ( 0.4, 327.62, -88.81 ), "aether_generator_pustule" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_quest_pap_cs";
    s.groupid = "Farm Energy Cysts - Full";
    s.script_label = "2";
    s.script_parameters = "farm";
    fe [[ f ]]( s, us, cf, ( 14865.6, -3858.4, 692.28 ), ( 35.19, 34.4, -115.13 ), "aether_generator_pustule" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_quest_pap_cs";
    s.groupid = "Farm Energy Cysts - Full";
    s.script_label = "2";
    s.script_parameters = "farm";
    fe [[ f ]]( s, us, cf, ( 14884, -3896.84, 636.65 ), ( 53.77, 146.02, -109.59 ), "aether_generator_pustule" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_quest_pap_cs";
    s.groupid = "Farm Energy Cysts - Full";
    s.script_label = "2";
    s.script_parameters = "farm";
    fe [[ f ]]( s, us, cf, ( 14928.2, -3881.12, 683.75 ), ( 50.88, 101.29, 117.8 ), "aether_generator_pustule" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_quest_pap_cs";
    s.groupid = "LAKEFRONT NEW  CYSTS";
    s.script_label = "2";
    s.script_parameters = "lakefront";
    fe [[ f ]]( s, us, cf, ( 12281.3, 2024.1, 1074.54 ), ( 357.09, 8.25, -90.87 ), "aether_generator_pustule" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_quest_pap_cs";
    s.groupid = "LAKEFRONT NEW  CYSTS";
    s.script_label = "2";
    s.script_parameters = "lakefront";
    fe [[ f ]]( s, us, cf, ( 12254.3, 1982.05, 1127.23 ), ( 35.68, 72.24, -119.88 ), "aether_generator_pustule" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_quest_pap_cs";
    s.groupid = "LAKEFRONT NEW  CYSTS";
    s.script_label = "2";
    s.script_parameters = "lakefront";
    fe [[ f ]]( s, us, cf, ( 12296.7, 1963.35, 1074.62 ), ( 57.08, 189.58, -105.97 ), "aether_generator_pustule" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_quest_pap_cs";
    s.groupid = "LAKEFRONT NEW  CYSTS";
    s.script_label = "2";
    s.script_parameters = "lakefront";
    fe [[ f ]]( s, us, cf, ( 12317, 2005.34, 1121.95 ), ( 54.65, 140.53, 116.11 ), "aether_generator_pustule" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_quest_pap_cs";
    s.groupid = "Farm Energy";
    s.name = "script_struct";
    s.script_parameters = "farm";
    s.script_power = "power_farm";
    fe [[ f ]]( s, us, cf, ( 14894.6, -3861.74, 587.45 ), ( 1.91, 257.81, -1.75 ), "aether_generator" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_quest_pap_cs";
    s.groupid = "Farm Energy Cysts - Full";
    s.script_label = "1";
    s.script_parameters = "farm";
    fe [[ f ]]( s, us, cf, ( 14945.9, -3928.9, 619.87 ), ( 357.75, 86.1, 91.45 ), "aether_generator_pustule" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_quest_pap_cs";
    s.groupid = "Ascender Objective Markers";
    fe [[ f ]]( s, us, cf, ( 3827.72, -2059.62, -223.38 ), ( 0, 0, 0 ), "pap_ascender" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_quest_pap_cs";
    s.groupid = "Farm Energy Cysts - Full";
    s.script_label = "3";
    s.script_parameters = "farm";
    fe [[ f ]]( s, us, cf, ( 14927.1, -3869.16, 643.7 ), ( 295.29, 83.79, 93.35 ), "aether_generator_pustule" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_quest_pap_cs";
    s.groupid = "LAKEFRONT NEW  CYSTS";
    s.script_label = "1";
    s.script_parameters = "lakefront";
    fe [[ f ]]( s, us, cf, ( 12365.5, 1978.87, 1061.66 ), ( 1.14, 126.71, 89.52 ), "aether_generator_pustule" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_quest_pap_cs";
    s.groupid = "Farm Energy Cysts - Full";
    s.script_label = "3";
    s.script_parameters = "farm";
    fe [[ f ]]( s, us, cf, ( 14898, -3900.85, 675.59 ), ( 351.63, 166.9, -88.77 ), "aether_generator_pustule" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_quest_pap_cs";
    s.groupid = "LAKEFRONT NEW  CYSTS";
    s.script_label = "3";
    s.script_parameters = "lakefront";
    fe [[ f ]]( s, us, cf, ( 12311, 2012.6, 1081.23 ), ( 298.66, 128.21, 89.04 ), "aether_generator_pustule" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_quest_pap_cs";
    s.groupid = "LAKEFRONT NEW  CYSTS";
    s.script_label = "3";
    s.script_parameters = "lakefront";
    fe [[ f ]]( s, us, cf, ( 12309.7, 1971.2, 1116.39 ), ( 353.52, 212.8, -87.84 ), "aether_generator_pustule" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_quest_pap_cs";
    s.groupid = "SUNKEN CYSTS";
    s.script_label = "3";
    s.script_parameters = "sunken";
    fe [[ f ]]( s, us, cf, ( 2887.31, -1519.12, 308.14 ), ( 47.38, 9, -90 ), "aether_generator_pustule" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_quest_pap_cs";
    s.groupid = "SUNKEN CYSTS";
    s.script_label = "2";
    s.script_parameters = "sunken";
    fe [[ f ]]( s, us, cf, ( 2874.59, -1481.8, 252.02 ), ( 12.12, 79.46, -101.25 ), "aether_generator_pustule" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_quest_pap_cs";
    s.groupid = "SUNKEN CYSTS";
    s.script_label = "1";
    s.script_parameters = "sunken";
    fe [[ f ]]( s, us, cf, ( 2939.45, -1603.08, 286.67 ), ( 7.17, 347.65, -6.36 ), "aether_generator_pustule" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_quest_pap_cs";
    s.groupid = "SUNKEN CYSTS";
    s.script_label = "3";
    s.script_parameters = "sunken";
    fe [[ f ]]( s, us, cf, ( 2866.19, -1527.68, 278.13 ), ( 1.34, 222.7, 90.01 ), "aether_generator_pustule" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_quest_pap_cs";
    s.groupid = "Farm Energy";
    s.script_parameters = "farm";
    fe [[ f ]]( s, us, cf, ( 14897, -3871.27, 729.79 ), ( 1.92, 308.94, 0.24 ), "aether_generator_infestation_core" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_quest_pap_cs";
    s.groupid = "SUNKEN CYSTS";
    s.script_label = "1";
    s.script_parameters = "sunken";
    fe [[ f ]]( s, us, cf, ( 2853.73, -1545.82, 257.08 ), ( 336.93, 268.5, 89.55 ), "aether_generator_pustule" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_quest_pap_cs";
    s.groupid = "SUNKEN CYSTS";
    s.script_label = "1";
    s.script_parameters = "sunken";
    fe [[ f ]]( s, us, cf, ( 2838.15, -1604.32, 285.86 ), ( 5.92, 125.83, -2.41 ), "aether_generator_pustule" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_quest_pap_cs";
    s.groupid = "SUNKEN CYSTS";
    s.script_label = "1";
    s.script_parameters = "sunken";
    fe [[ f ]]( s, us, cf, ( 2888.43, -1466.2, 249.61 ), ( 331.65, 173.77, 92.69 ), "aether_generator_pustule" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_quest_pap_cs";
    s.groupid = "SUNKEN CYSTS";
    s.script_label = "1";
    s.script_parameters = "sunken";
    fe [[ f ]]( s, us, cf, ( 2835.34, -1590.46, 250.13 ), ( 356.47, 201.3, 91.42 ), "aether_generator_pustule" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_quest_pap_cs";
    s.groupid = "SUNKEN CYSTS";
    s.name = "script_struct";
    s.script_label = "1";
    s.script_parameters = "sunken";
    fe [[ f ]]( s, us, cf, ( 2936.63, -1613.71, 263.37 ), ( 8.74, 166.74, -87.86 ), "aether_generator_pustule" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_quest_pap_cs";
    s.groupid = "SUNKEN CYSTS";
    s.script_label = "1";
    s.script_parameters = "sunken";
    fe [[ f ]]( s, us, cf, ( 2835.83, -1613.05, 255.77 ), ( 358.02, 194.75, -91.17 ), "aether_generator_pustule" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_quest_pap_cs";
    s.groupid = "SUNKEN CYSTS";
    s.script_label = "1";
    s.script_parameters = "sunken";
    fe [[ f ]]( s, us, cf, ( 2908.45, -1527.05, 291.26 ), ( 356.84, 315, -90 ), "aether_generator_pustule" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_quest_pap_cs";
    s.groupid = "SUNKEN CYSTS";
    s.script_label = "2";
    s.script_parameters = "sunken";
    fe [[ f ]]( s, us, cf, ( 2898.18, -1518.89, 261.17 ), ( 357.4, 349.8, -80.52 ), "aether_generator_pustule" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_quest_pap_cs";
    s.groupid = "SUNKEN CYSTS";
    s.script_label = "2";
    s.script_parameters = "sunken";
    fe [[ f ]]( s, us, cf, ( 2856.38, -1541.95, 313.42 ), ( 37.12, 44.55, -119.69 ), "aether_generator_pustule" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_quest_pap_cs";
    s.groupid = "SUNKEN CYSTS";
    s.script_label = "2";
    s.script_parameters = "sunken";
    fe [[ f ]]( s, us, cf, ( 2882.63, -1580.84, 260.08 ), ( 56.27, 163.61, -103.78 ), "aether_generator_pustule" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_quest_pap_cs";
    s.groupid = "Power Switches";
    s.script_parameters = "farm";
    fe [[ f ]]( s, us, cf, ( 13694, -4271.5, 779 ), ( 0, 315.05, 0 ), "power_switch", "cspf_0_auto12616720047913848469" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_quest_pap_cs";
    s.groupid = "SUNKEN CYSTS";
    s.script_label = "2";
    s.script_parameters = "sunken";
    fe [[ f ]]( s, us, cf, ( 2921.08, -1549.93, 306.22 ), ( 55.02, 114.72, 118.54 ), "aether_generator_pustule" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_quest_pap_cs";
    s.groupid = "SUNKEN CYSTS";
    s.script_label = "1";
    s.script_parameters = "sunken";
    fe [[ f ]]( s, us, cf, ( 2950.46, -1596.91, 246.07 ), ( 1.86, 98.94, 90.78 ), "aether_generator_pustule" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_quest_pap_cs";
    s.groupid = "Sunken Energy";
    s.script_parameters = "sunken";
    s.script_power = "power_sunken";
    fe [[ f ]]( s, us, cf, ( 2887.6, -1547.2, 204.64 ), ( 360, 270, 0 ), "aether_generator" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_quest_pap_cs";
    s.groupid = "SUNKEN CYSTS";
    s.script_label = "3";
    s.script_parameters = "sunken";
    fe [[ f ]]( s, us, cf, ( 2918.36, -1541.35, 265.4 ), ( 299.37, 98.14, 91.64 ), "aether_generator_pustule" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_quest_pap_cs";
    s.groupid = "SUNKEN CYSTS";
    s.script_label = "3";
    s.script_parameters = "sunken";
    fe [[ f ]]( s, us, cf, ( 2898.63, -1582.25, 297.66 ), ( 352.57, 181.89, -86.34 ), "aether_generator_pustule" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_quest_pap_cs";
    s.groupid = "Ascender Objective Markers";
    fe [[ f ]]( s, us, cf, ( 3248.4, -756.23, -154.13 ), ( 0, 0, 0 ), "pap_ascender" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_quest_pap_cs";
    s.groupid = "Lakefront Energy";
    fe [[ f ]]( s, us, cf, ( 12536.6, 1048.51, 1031.31 ), ( 0.24, 14.18, 0.06 ), "lakefront_generator_bread_crumb" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_quest_pap_cs";
    s.groupid = "Farm Energy";
    fe [[ f ]]( s, us, cf, ( 15416, -4709, 625 ), ( 0, 0, 0 ), "farm_generator_bread_crumb" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_quest_pap_cs";
    s.groupid = "Sunken Energy";
    s.script_parameters = "sunken";
    fe [[ f ]]( s, us, cf, ( 2887.63, -1546.96, 346.95 ), ( 359.02, 261.78, -0.67 ), "aether_generator_infestation_core" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_quest_pap_cs";
    s.groupid = "Travel to Sunken Town Waypoints";
    s.script_parameters = "farm";
    fe [[ f ]]( s, us, cf, ( 5145.02, -2042.27, 26.57 ), ( 0, 0, 0 ), "travel_to_sunken_waypoint_2", undefined, "zone_sunken_north" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_quest_pap_cs";
    s.groupid = "Travel to Sunken Town Waypoints";
    s.script_parameters = "farm";
    fe [[ f ]]( s, us, cf, ( 11559, -6299, 601 ), ( 0, 0, 0 ), "travel_to_sunken_waypoint_1", undefined, "zone_ts_boat_close_to_farm" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_quest_pap_cs";
    s.groupid = "Travel to Sunken Town Waypoints";
    s.script_parameters = "lakefront";
    fe [[ f ]]( s, us, cf, ( 11401, 2052, 969.5 ), ( 0, 0, 0 ), "travel_to_sunken_waypoint_1", undefined, "zone_ts_w_lakefront_close_to_lakefront" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_quest_pap_cs";
    s.groupid = "Travel to Sunken Town Waypoints";
    s.script_parameters = "lakefront";
    fe [[ f ]]( s, us, cf, ( 5079.98, -879.89, 38.8 ), ( 0, 0, 0 ), "travel_to_sunken_waypoint_2", undefined, "zone_sunken_north" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_quest_pap_cs";
    fe [[ f ]]( s, us, cf, ( 13526, -4256, 589 ), ( 0, 0, 0 ), "pap_step_10_door_waypoint_farm", undefined, "farm" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_quest_pap_cs";
    s.groupid = "Power Switches";
    s.script_parameters = "sunken";
    fe [[ f ]]( s, us, cf, ( 3077, -2236.6, 386.25 ), ( 0, 90, -90 ), "cspf_0_auto12567281026716688697" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_quest_pap_cs";
    s.groupid = "Power Switches";
    s.script_parameters = "sunken";
    fe [[ f ]]( s, us, cf, ( 3086.5, -2236.75, 381.5 ), ( 0, 90, -90 ), "power_switch", "cspf_0_auto12567281026716688697" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_quest_pap_cs";
    s.groupid = "Power Switches";
    s.script_parameters = "farm";
    fe [[ f ]]( s, us, cf, ( 13688.8, -4276.75, 825.25 ), ( 0, 315.05, 0 ), "cspf_0_auto12616720047913848469" );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace zm_sat_firefly_script_quest_pap_cs
// Params 0, eflags: 0x4
// Checksum 0x4eebebb8, Offset: 0x2e9d
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace zm_sat_firefly_script_quest_pap_cs
// Params 0
// Checksum 0xbde352d2, Offset: 0x2ea7
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "zm_sat_firefly_script_quest_pap_cs" );
}

