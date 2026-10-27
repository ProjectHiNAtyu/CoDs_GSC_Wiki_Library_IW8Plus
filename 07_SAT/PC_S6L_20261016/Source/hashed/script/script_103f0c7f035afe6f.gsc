// script_103f0c7f035afe6f  (hash_103f0c7f035afe6f.gscc) (size: 6901 Bytes / 0x1af5 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xaad977dd (2866378717)
// size ...... 6901 (0x1af5)
// includes .. 3   (offset: 0x17d1)
// strings ... 9   (offset: 0x17e9)
// dev strs .. 0   (offset: 0x1af5)
// exports ... 9   (offset: 0x1439)
// cseg ...... 0x133 + 0x1306 (0x1439)
// imports ... 20  (offset: 0x15a1)
// animtree1 . 0   (offset: 0x1af5)
// animtree2 . 0   (offset: 0x1af5)
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace mp_sat_avalon_q1_ob_vehicles_cs;

// Namespace mp_sat_avalon_q1_ob_vehicles_cs
// Params 0, eflags: 0x5
// Checksum 0x8ca6ab52, Offset: 0x151
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"mp_sat_avalon_q1_ob_vehicles_cs", undefined, &function_b39ecd3d51489472, undefined );
}

// Namespace mp_sat_avalon_q1_ob_vehicles_cs
// Params 0, eflags: 0x4
// Checksum 0x68a5b793, Offset: 0x172
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace mp_sat_avalon_q1_ob_vehicles_cs
// Params 0, eflags: 0x4
// Checksum 0xed9e647f, Offset: 0x183
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace mp_sat_avalon_q1_ob_vehicles_cs
// Params 2
// Checksum 0x5d773236, Offset: 0x194
// Size: 0x80
function main( unused, unused2 )
{
    if ( utility::flag_exist( "mp_sat_avalon_q1_ob_vehicles_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "mp_sat_avalon_q1_ob_vehicles_cs" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "mp_sat_avalon_q1_ob_vehicles_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "mp_sat_avalon_q1_ob_vehicles_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace mp_sat_avalon_q1_ob_vehicles_cs
// Params 3, eflags: 0x4
// Checksum 0x6e1cd0b0, Offset: 0x21c
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "mp_sat_avalon_q1_ob_vehicles_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "mp_sat_avalon_q1_ob_vehicles_cs" );
}

// Namespace mp_sat_avalon_q1_ob_vehicles_cs
// Params 3, eflags: 0x4
// Checksum 0xa84f8aba, Offset: 0x296
// Size: 0x1183
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_vehicles_cs";
    s.script_vehiclebundle = "veh_sat_mil_lnd_cargo_truck_ob";
    fe [[ f ]]( s, us, cf, ( -25758.7, 24340.1, 1964.07 ), ( 0, 196.09, 0 ), "veh_sat_mil_lnd_cargo_truck_ob" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_vehicles_cs";
    s.script_vehiclebundle = "veh_sat_utv_ob";
    fe [[ f ]]( s, us, cf, ( -4972.5, 53055.5, 489 ), ( 0, 155.39, 0 ), "veh_sat_utv_ob" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_vehicles_cs";
    s.script_vehiclebundle = "veh_sat_medium_truck_ob";
    fe [[ f ]]( s, us, cf, ( -45357.6, 20420.8, 719.76 ), ( 0, 16.33, 0 ), "veh_sat_utv_ob" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_vehicles_cs";
    s.script_vehiclebundle = "veh_sat_utv_ob";
    fe [[ f ]]( s, us, cf, ( -38143.3, 7222.75, 38.4 ), ( 0, 45.15, 0 ), "veh_sat_utv_ob", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, 0 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_vehicles_cs";
    s.script_vehiclebundle = "veh_sat_utv_ob";
    fe [[ f ]]( s, us, cf, ( -24346, 36495, 1996 ), ( 0, 25.2, 0 ), "veh_sat_utv_ob" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_vehicles_cs";
    s.script_vehiclebundle = "veh_sat_utv_ob";
    fe [[ f ]]( s, us, cf, ( -12389, 53869, 481 ), ( 0, 231.74, 0 ), "veh_sat_utv_ob" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_vehicles_cs";
    s.script_vehiclebundle = "veh_sat_atv_ob";
    fe [[ f ]]( s, us, cf, ( -28722.8, 35525.3, 1657.01 ), ( 0, 49.65, 0 ), "veh_sat_atv_ob" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_vehicles_cs";
    s.script_vehiclebundle = "veh_sat_utv_ob";
    fe [[ f ]]( s, us, cf, ( -15769.5, 47977.5, 594 ), ( 0, 331.78, 0 ), "veh_sat_utv_ob" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_vehicles_cs";
    s.script_vehiclebundle = "veh_sat_utv_ob";
    fe [[ f ]]( s, us, cf, ( -15539.2, 41864.9, 1200.42 ), ( 0, 56.29, 0 ), "veh_sat_utv_ob" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_vehicles_cs";
    s.script_vehiclebundle = "veh_sat_utv_ob";
    fe [[ f ]]( s, us, cf, ( -7816.5, 42289.5, 308 ), ( 0, 46.1, 0 ), "veh_sat_utv_ob" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_vehicles_cs";
    s.script_vehiclebundle = "veh_sat_medium_truck_ob";
    fe [[ f ]]( s, us, cf, ( -30986.1, 7336.63, 277.68 ), ( 0, 202.18, 0 ), "veh_sat_utv_ob", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, 8 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_vehicles_cs";
    s.script_vehiclebundle = "veh_sat_medium_truck_ob";
    fe [[ f ]]( s, us, cf, ( -33712.3, 13733.7, 415.93 ), ( 0, 150, 0 ), "veh_sat_utv_ob", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, 8 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_vehicles_cs";
    s.script_vehiclebundle = "veh_sat_utv_ob";
    fe [[ f ]]( s, us, cf, ( -22890.5, 52648.5, 2075 ), ( 0, 133.69, 0 ), "veh_sat_utv_ob" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_vehicles_cs";
    s.script_vehiclebundle = "veh_sat_utv_ob";
    fe [[ f ]]( s, us, cf, ( -25397, 49334, 1700 ), ( 0, 43.2, 0 ), "veh_sat_utv_ob" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_vehicles_cs";
    s.script_vehiclebundle = "veh_sat_atv_ob";
    fe [[ f ]]( s, us, cf, ( -50255.5, 659.5, 276.66 ), ( 0, 125.05, 0 ), "veh_sat_atv_ob" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_vehicles_cs";
    s.script_vehiclebundle = "veh_sat_tactical_raft_ob";
    fe [[ f ]]( s, us, cf, ( -37063, 3793.94, 1 ), ( 1.12, 269.43, -2.08 ), "veh_sat_tactical_raft_ob" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_vehicles_cs";
    s.script_vehiclebundle = "veh_sat_utv_ob";
    fe [[ f ]]( s, us, cf, ( -33770.5, 13135, 447 ), ( 0, 113.96, 0 ), "veh_sat_utv_ob" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_vehicles_cs";
    s.script_vehiclebundle = "veh_sat_tactical_raft_ob";
    fe [[ f ]]( s, us, cf, ( -34421.8, 3601.63, 52.82 ), ( 359.33, 278.07, -0.97 ), "veh_sat_tactical_raft_ob" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_vehicles_cs";
    s.script_vehiclebundle = "veh_sat_utv_ob";
    fe [[ f ]]( s, us, cf, ( -24215.8, 12152.1, 1340.85 ), ( 0, 160.18, 0 ), "veh_sat_utv_ob" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_vehicles_cs";
    s.script_vehiclebundle = "veh_sat_tactical_raft_ob";
    fe [[ f ]]( s, us, cf, ( -26561.5, 3766, 0 ), ( 0, 150.23, 0 ), "veh_sat_tactical_raft_ob" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_vehicles_cs";
    s.script_vehiclebundle = "veh_sat_utv_ob";
    fe [[ f ]]( s, us, cf, ( -33138.5, 24583, 1746.47 ), ( 0, 97.91, 0 ), "veh_sat_utv_ob" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_vehicles_cs";
    s.script_vehiclebundle = "veh_sat_utv_ob";
    fe [[ f ]]( s, us, cf, ( -10921.4, 32098.2, 622.99 ), ( 8.65, 34.51, 3.55 ), "veh_sat_utv_ob" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_vehicles_cs";
    s.script_vehiclebundle = "veh_sat_atv_ob";
    fe [[ f ]]( s, us, cf, ( -19511, 15686, 1815.97 ), ( 0, 169, 0 ), "veh_sat_atv_ob" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_vehicles_cs";
    s.script_vehiclebundle = "veh_sat_utv_ob";
    fe [[ f ]]( s, us, cf, ( -16100, 9695.5, 1046 ), ( 0, 12.5, 0 ), "veh_sat_utv_ob" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_vehicles_cs";
    s.script_vehiclebundle = "veh_sat_atv_ob";
    fe [[ f ]]( s, us, cf, ( -33838, 28560.5, 1573.71 ), ( 0, 121.48, 0 ), "veh_sat_atv_ob" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_vehicles_cs";
    s.script_vehiclebundle = "veh_sat_utv_ob";
    fe [[ f ]]( s, us, cf, ( -20823, 39957.5, 1707.84 ), ( 0, 113.54, 0 ), "veh_sat_utv_ob" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_vehicles_cs";
    s.script_vehiclebundle = "veh_sat_utv_ob";
    fe [[ f ]]( s, us, cf, ( -26734.5, 33884.5, 1823 ), ( 0, 137.8, 0 ), "veh_sat_utv_ob" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_vehicles_cs";
    s.script_vehiclebundle = "veh_sat_atv_ob";
    fe [[ f ]]( s, us, cf, ( -27240, 53305.5, 2422.6 ), ( 8.37, 266.27, -0 ), "veh_sat_atv_ob" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_vehicles_cs";
    s.script_vehiclebundle = "veh_sat_medium_truck_ob";
    fe [[ f ]]( s, us, cf, ( -36332, 25811, 1825 ), ( 0, 122.92, 0 ), "veh_sat_medium_truck_ob" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_vehicles_cs";
    s.script_vehiclebundle = "veh_sat_utv_ob";
    fe [[ f ]]( s, us, cf, ( -31642, 43420.5, 1763.98 ), ( 0, 225, 0 ), "veh_sat_utv_ob" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_vehicles_cs";
    s.script_vehiclebundle = "veh_sat_atv_ob";
    fe [[ f ]]( s, us, cf, ( -24893, 31781, 2137.94 ), ( 0, 312.01, 0 ), "veh_sat_atv_ob" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_vehicles_cs";
    s.script_vehiclebundle = "veh_sat_utv_ob";
    fe [[ f ]]( s, us, cf, ( -25912.1, 40793.2, 1856.12 ), ( 0, 309.85, 0 ), "veh_sat_utv_ob" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_vehicles_cs";
    s.script_vehiclebundle = "veh_sat_atv_ob";
    fe [[ f ]]( s, us, cf, ( -15560.5, 31889, 1308.68 ), ( 0, 247.61, 0 ), "veh_sat_atv_ob" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_vehicles_cs";
    s.script_vehiclebundle = "veh_sat_utv_ob";
    fe [[ f ]]( s, us, cf, ( -26000.5, 6591.5, 472 ), ( 0, 31.58, 0 ), "veh_sat_utv_ob" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_vehicles_cs";
    s.script_vehiclebundle = "veh_sat_medium_truck_ob";
    fe [[ f ]]( s, us, cf, ( -34587.5, 24956, 1710 ), ( 0, 189.27, 0 ), "veh_sat_medium_truck_ob" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_vehicles_cs";
    s.script_vehiclebundle = "veh_sat_utv_ob";
    fe [[ f ]]( s, us, cf, ( -4546.5, 43884, 247.5 ), ( 0, 40.19, 0 ), "veh_sat_utv_ob" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_vehicles_cs";
    s.script_vehiclebundle = "veh_sat_medium_truck_ob";
    fe [[ f ]]( s, us, cf, ( -40319.5, 30527, 1603.5 ), ( 0, 6.94, 0 ), "veh_sat_medium_truck_ob" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_vehicles_cs";
    s.script_vehiclebundle = "veh_sat_medium_truck_ob";
    fe [[ f ]]( s, us, cf, ( -7779.24, 22898.1, 752.26 ), ( 0, 281.92, 0 ), "veh_sat_medium_truck_ob" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_vehicles_cs";
    s.script_vehiclebundle = "veh_sat_atv_ob";
    fe [[ f ]]( s, us, cf, ( -35942.5, 37570, 1919 ), ( 0, 227.93, 0 ), "veh_sat_atv_ob" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_vehicles_cs";
    s.script_vehiclebundle = "veh_sat_medium_truck_ob";
    fe [[ f ]]( s, us, cf, ( -45815, 13882.5, 263.91 ), ( 0, 180, 0 ), "veh_sat_medium_truck_ob" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_vehicles_cs";
    s.script_vehiclebundle = "veh_sat_atv_ob";
    fe [[ f ]]( s, us, cf, ( -6826, 46171, 247.5 ), ( 0, 44.68, 0 ), "veh_sat_atv_ob" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_vehicles_cs";
    s.script_vehiclebundle = "veh_sat_utv_ob";
    fe [[ f ]]( s, us, cf, ( -37884, 21392, 1249 ), ( 0, 322.63, 0 ), "veh_sat_utv_ob" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_vehicles_cs";
    s.script_vehiclebundle = "veh_sat_utv_ob";
    fe [[ f ]]( s, us, cf, ( -32217.2, 34881.1, 1737.75 ), ( 0, 256.27, 0 ), "veh_sat_utv_ob" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_vehicles_cs";
    s.script_vehiclebundle = "veh_sat_tactical_raft_ob";
    fe [[ f ]]( s, us, cf, ( -2373, 18650.5, 0 ), ( 0, 305.79, 0 ), "veh_sat_tactical_raft_ob" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_vehicles_cs";
    s.script_vehiclebundle = "veh_sat_tactical_raft_ob";
    fe [[ f ]]( s, us, cf, ( -7401.5, 43948.5, 64.5 ), ( 0, 314.13, 0 ), "veh_sat_tactical_raft_ob" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_vehicles_cs";
    s.script_vehiclebundle = "veh_sat_mil_us_boat_pgb_ob";
    fe [[ f ]]( s, us, cf, ( -8621, 51233.5, 119.5 ), ( 0, 83.82, 0 ), "veh_sat_mil_us_boat_pgb_ob" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_vehicles_cs";
    s.script_vehiclebundle = "veh_sat_tactical_raft_ob";
    fe [[ f ]]( s, us, cf, ( -47711.5, 2088, 0 ), ( 0, 75.79, 0 ), "veh_sat_tactical_raft_ob" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_vehicles_cs";
    s.script_vehiclebundle = "veh_sat_medium_truck_ob";
    fe [[ f ]]( s, us, cf, ( -24751, 15923.5, 1547.35 ), ( 0, 106.92, 0 ), "veh_sat_medium_truck_ob", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, 8 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_vehicles_cs";
    s.script_vehiclebundle = "veh_sat_atv_ob";
    fe [[ f ]]( s, us, cf, ( -28045, 14654, 1314.44 ), ( 0, 195.07, 0 ), "veh_sat_atv_ob" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_vehicles_cs";
    s.script_vehiclebundle = "veh_sat_atv_ob";
    fe [[ f ]]( s, us, cf, ( -9259, 19830, 562.33 ), ( 0, 240.71, 0 ), "veh_sat_atv_ob" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_vehicles_cs";
    s.script_vehiclebundle = "veh_sat_atv_ob";
    fe [[ f ]]( s, us, cf, ( -25848.5, 20688.5, 1897.01 ), ( 0, 179.94, 0 ), "veh_sat_atv_ob" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_vehicles_cs";
    s.script_vehiclebundle = "veh_sat_utv_ob";
    fe [[ f ]]( s, us, cf, ( -16963, 26869.5, 1289 ), ( 0, 71.3, 0 ), "veh_sat_utv_ob" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_vehicles_cs";
    s.script_vehiclebundle = "veh_sat_utv_ob";
    fe [[ f ]]( s, us, cf, ( -21011.5, 18739, 1467.5 ), ( 0, 86.09, 0 ), "veh_sat_utv_ob" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_vehicles_cs";
    s.script_vehiclebundle = "veh_sat_mil_lnd_cargo_truck_ob";
    fe [[ f ]]( s, us, cf, ( -10816, 50322, 504 ), ( 0, 238, 0 ), "veh_sat_mil_lnd_cargo_truck_ob" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_vehicles_cs";
    s.script_vehiclebundle = "veh_sat_tactical_raft_ob";
    fe [[ f ]]( s, us, cf, ( -10333.5, 10194, 0 ), ( 0, 38.08, 0 ), "veh_sat_tactical_raft_ob" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_vehicles_cs";
    s.script_vehiclebundle = "veh_sat_medium_truck_ob";
    fe [[ f ]]( s, us, cf, ( -7042.5, 35487, 277.98 ), ( 0, 272.66, 0 ), "veh_sat_medium_truck_ob" );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace mp_sat_avalon_q1_ob_vehicles_cs
// Params 0, eflags: 0x4
// Checksum 0xee16a3a2, Offset: 0x1421
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace mp_sat_avalon_q1_ob_vehicles_cs
// Params 0
// Checksum 0xac4f0dfd, Offset: 0x142b
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "mp_sat_avalon_q1_ob_vehicles_cs" );
}

