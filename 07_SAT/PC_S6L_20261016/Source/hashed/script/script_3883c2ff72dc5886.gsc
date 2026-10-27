// script_3883c2ff72dc5886  (hash_3883c2ff72dc5886.gscc) (size: 8799 Bytes / 0x225f / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x3d17f2c1 (1024979649)
// size ...... 8799 (0x225f)
// includes .. 3   (offset: 0x1dcb)
// strings ... 23  (offset: 0x1de3)
// dev strs .. 0   (offset: 0x225f)
// exports ... 9   (offset: 0x1a33)
// cseg ...... 0x269 + 0x17ca (0x1a33)
// imports ... 20  (offset: 0x1b9b)
// animtree1 . 0   (offset: 0x225f)
// animtree2 . 0   (offset: 0x225f)
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace mp_sat_avalon_quad_03_ob_vehicles_cs;

// Namespace mp_sat_avalon_quad_03_ob_vehicles_cs
// Params 0, eflags: 0x5
// Checksum 0x45639595, Offset: 0x287
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"mp_sat_avalon_quad_03_ob_vehicles_cs", undefined, &function_b39ecd3d51489472, undefined );
}

// Namespace mp_sat_avalon_quad_03_ob_vehicles_cs
// Params 0, eflags: 0x4
// Checksum 0x2981d149, Offset: 0x2a8
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace mp_sat_avalon_quad_03_ob_vehicles_cs
// Params 0, eflags: 0x4
// Checksum 0xacba02a5, Offset: 0x2b9
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace mp_sat_avalon_quad_03_ob_vehicles_cs
// Params 2
// Checksum 0x1c5354ec, Offset: 0x2ca
// Size: 0x80
function main( unused, unused2 )
{
    if ( utility::flag_exist( "mp_sat_avalon_quad_03_ob_vehicles_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "mp_sat_avalon_quad_03_ob_vehicles_cs" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "mp_sat_avalon_quad_03_ob_vehicles_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "mp_sat_avalon_quad_03_ob_vehicles_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace mp_sat_avalon_quad_03_ob_vehicles_cs
// Params 3, eflags: 0x4
// Checksum 0x2f38b66a, Offset: 0x352
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "mp_sat_avalon_quad_03_ob_vehicles_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "mp_sat_avalon_quad_03_ob_vehicles_cs" );
}

// Namespace mp_sat_avalon_quad_03_ob_vehicles_cs
// Params 3, eflags: 0x4
// Checksum 0x9ab83c75, Offset: 0x3cc
// Size: 0x1647
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_vehicles_cs";
    s.groupid = "boat";
    s.script_vehiclebundle = "veh_sat_mil_us_boat_pgb_ob";
    fe [[ f ]]( s, us, cf, ( -42678.7, -7836.7, -35 ), ( 0, 337.43, 0 ), "veh_sat_mil_us_boat_pgb_ob" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_vehicles_cs";
    s.groupid = "lnd_mil_gas_02";
    s.script_vehiclebundle = "veh_sat_utv_ob";
    fe [[ f ]]( s, us, cf, ( -24610, -20487, 963.5 ), ( 0, 256.32, 0 ), "veh_sat_utv_ob" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_vehicles_cs";
    s.groupid = "lnd_mi_listening";
    s.script_vehiclebundle = "veh_sat_atv_ob";
    fe [[ f ]]( s, us, cf, ( -23985, -40572.8, 552.26 ), ( 348.43, 310.98, 0 ), "veh_sat_atv_ob" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_vehicles_cs";
    s.groupid = "lnd_flat_neighborhood";
    s.script_vehiclebundle = "veh_sat_utv_ob";
    fe [[ f ]]( s, us, cf, ( -1290, -18240, 203.75 ), ( 0, 143.09, 0 ), "veh_sat_utv_ob" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_vehicles_cs";
    s.groupid = "lnd_mi_fort_north";
    s.script_vehiclebundle = "veh_sat_atv_ob";
    fe [[ f ]]( s, us, cf, ( -35095, -36280.3, 698.24 ), ( 0, 97.17, 0 ), "veh_sat_atv_ob" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_vehicles_cs";
    s.groupid = "lnd_mi_training_checkpoint";
    s.script_vehiclebundle = "veh_sat_utv_ob";
    fe [[ f ]]( s, us, cf, ( -20781.5, -33891, 541.89 ), ( 0, 4.08, 0 ), "veh_sat_utv_ob" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_vehicles_cs";
    s.groupid = "boat";
    s.script_vehiclebundle = "veh_sat_mil_us_boat_pgb_ob";
    fe [[ f ]]( s, us, cf, ( -36899.8, -13185.2, -8.5 ), ( 0, 359.76, 0 ), "veh_sat_mil_us_boat_pgb_ob", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, 0 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_vehicles_cs";
    s.groupid = "lnd_sam_site_01";
    s.script_vehiclebundle = "veh_sat_atv_ob";
    fe [[ f ]]( s, us, cf, ( -31183.5, -19714, 228.25 ), ( 0, 241.4, 0 ), "veh_sat_atv_ob" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_vehicles_cs";
    s.groupid = "lnd_mil_gas_02";
    s.script_vehiclebundle = "veh_sat_utv_ob";
    fe [[ f ]]( s, us, cf, ( -25956, -20461, 974 ), ( 0, 347.53, 0 ), "veh_sat_utv_ob" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_vehicles_cs";
    s.groupid = "lnd_sam_site_01";
    s.script_vehiclebundle = "veh_sat_mil_lnd_cargo_truck_ob";
    fe [[ f ]]( s, us, cf, ( -32046, -23801.5, 798.5 ), ( 0, 358.71, 0 ), "veh_sat_mil_lnd_cargo_truck_ob" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_vehicles_cs";
    s.groupid = "lnd_mi_fort_north";
    s.script_vehiclebundle = "veh_sat_atv_ob";
    fe [[ f ]]( s, us, cf, ( -40518, -42573.5, 722.07 ), ( 0, 345.3, 0 ), "veh_sat_atv_ob" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_vehicles_cs";
    s.groupid = "lnd_coast_guard_north";
    s.script_vehiclebundle = "veh_sat_utv_ob";
    fe [[ f ]]( s, us, cf, ( -43410.5, -6047.5, 158.5 ), ( 0, 275.24, 0 ), "veh_sat_utv_ob" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_vehicles_cs";
    s.groupid = "lnd_mi_training_checkpoint";
    s.script_vehiclebundle = "veh_sat_atv_ob";
    fe [[ f ]]( s, us, cf, ( -15098.5, -30431.5, 476.79 ), ( 350.86, 0, 0 ), "veh_sat_atv_ob" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_vehicles_cs";
    s.groupid = "lnd_mi_fort_south";
    s.script_vehiclebundle = "veh_sat_medium_truck_ob";
    fe [[ f ]]( s, us, cf, ( -39577.1, -43014.6, 728.71 ), ( 0, 324.18, 0 ), "veh_sat_medium_truck_ob" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_vehicles_cs";
    s.groupid = "lnd_mi_listening_cluster_radar";
    s.script_vehiclebundle = "veh_sat_mil_lnd_cargo_truck_ob";
    fe [[ f ]]( s, us, cf, ( -11870.5, -43788, 704.5 ), ( 0, 0, 0 ), "veh_sat_mil_lnd_cargo_truck_ob" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_vehicles_cs";
    s.groupid = "lnd_mi_fort_south";
    s.script_vehiclebundle = "veh_sat_medium_truck_ob";
    fe [[ f ]]( s, us, cf, ( -34922, -35134.5, 643.51 ), ( 0, 76.04, 0 ), "veh_sat_medium_truck_ob" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_vehicles_cs";
    s.groupid = "lnd_mi_training";
    s.script_vehiclebundle = "veh_sat_atv_ob";
    fe [[ f ]]( s, us, cf, ( -25549.2, -26435.2, 1011.54 ), ( 0, 0, 0 ), "veh_sat_atv_ob" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_vehicles_cs";
    s.groupid = "lnd_mi_fort_south";
    s.script_vehiclebundle = "veh_sat_atv_ob";
    fe [[ f ]]( s, us, cf, ( -34038.6, -44462.8, 528.8 ), ( 0, 96.29, 0 ), "veh_sat_atv_ob" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_vehicles_cs";
    s.groupid = "lnd_mil_gas_02_north";
    s.script_vehiclebundle = "veh_sat_atv_ob";
    fe [[ f ]]( s, us, cf, ( -24275, -13547.5, 1352.48 ), ( 0, 258.17, 0 ), "veh_sat_atv_ob" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_vehicles_cs";
    s.groupid = "lnd_flat_neighborhood";
    s.script_vehiclebundle = "veh_sat_utv_ob";
    fe [[ f ]]( s, us, cf, ( -21870.7, -47673.2, 315.94 ), ( 0, 219.19, 0 ), "veh_sat_utv_ob" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_vehicles_cs";
    s.groupid = "lnd_mi_listening";
    s.script_vehiclebundle = "veh_sat_mil_lnd_cargo_truck_ob";
    fe [[ f ]]( s, us, cf, ( -18488, -39231, 391.79 ), ( 0, 270.31, 0 ), "veh_sat_mil_lnd_cargo_truck_ob" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_vehicles_cs";
    s.groupid = "lnd_mi_listening";
    s.script_vehiclebundle = "veh_sat_utv_ob";
    fe [[ f ]]( s, us, cf, ( -22080.1, -46472.8, 389.23 ), ( 0, 97.49, 0 ), "veh_sat_utv_ob" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_vehicles_cs";
    s.groupid = "lnd_fire_gas";
    s.script_vehiclebundle = "veh_sat_utv_ob";
    fe [[ f ]]( s, us, cf, ( -1818.5, -33999, 328.5 ), ( 0, 146.15, 0 ), "veh_sat_utv_ob" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_vehicles_cs";
    s.groupid = "lnd_mi_fort_north";
    s.script_vehiclebundle = "veh_sat_utv_ob";
    fe [[ f ]]( s, us, cf, ( -42799.5, -37121.5, 842.99 ), ( 0, 256.01, 0 ), "veh_sat_utv_ob" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_vehicles_cs";
    s.groupid = "lnd_mi_training";
    s.script_vehiclebundle = "veh_sat_medium_truck_ob";
    fe [[ f ]]( s, us, cf, ( -26720.2, -30196.2, 905.26 ), ( 0, 49.47, 0 ), "veh_sat_medium_truck_ob" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_vehicles_cs";
    s.groupid = "boat";
    s.script_vehiclebundle = "veh_sat_tactical_raft_ob";
    fe [[ f ]]( s, us, cf, ( -5490.88, -35460.7, 0 ), ( 0, 151.87, 0 ), "veh_sat_tactical_raft_ob" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_vehicles_cs";
    s.groupid = "boat";
    s.script_vehiclebundle = "veh_sat_tactical_raft_ob";
    fe [[ f ]]( s, us, cf, ( -6472.19, -15509.8, -0 ), ( 0, 169.23, 0 ), "veh_sat_tactical_raft_ob" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_vehicles_cs";
    s.groupid = "lnd_coast_guard_south";
    s.script_vehiclebundle = "veh_sat_atv_ob";
    fe [[ f ]]( s, us, cf, ( -42925.5, -14928, 443 ), ( 0, 0, 0 ), "veh_sat_atv_ob" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_vehicles_cs";
    s.groupid = "lnd_mi_listening";
    s.script_vehiclebundle = "veh_sat_atv_ob";
    fe [[ f ]]( s, us, cf, ( -17770.9, -45850.2, 311.84 ), ( 348.43, 31.76, 0 ), "veh_sat_atv_ob" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_vehicles_cs";
    s.groupid = "boat";
    s.script_vehiclebundle = "veh_sat_tactical_raft_ob";
    fe [[ f ]]( s, us, cf, ( -23989, -3532.5, -6 ), ( 0, 6.67, 0 ), "veh_sat_tactical_raft_ob", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, 0 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_vehicles_cs";
    s.groupid = "lnd_coast_guard_north";
    s.script_vehiclebundle = "veh_sat_medium_truck_ob";
    fe [[ f ]]( s, us, cf, ( -43543.5, -7815.5, 126 ), ( 0, 243.72, 0 ), "veh_sat_medium_truck_ob" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_vehicles_cs";
    s.groupid = "lnd_mi_listening_cluster_radar";
    s.script_vehiclebundle = "veh_sat_atv_ob";
    fe [[ f ]]( s, us, cf, ( -14195.5, -40783.5, 287.75 ), ( 0, 354.32, 0 ), "veh_sat_atv_ob" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_vehicles_cs";
    s.groupid = "lnd_mi_training";
    s.script_vehiclebundle = "veh_sat_medium_truck_ob";
    fe [[ f ]]( s, us, cf, ( -32824.5, -31577.5, 666.64 ), ( 0, 283.07, 0 ), "veh_sat_medium_truck_ob" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_vehicles_cs";
    s.groupid = "lnd_mil_gas_02_north";
    s.script_vehiclebundle = "veh_sat_utv_ob";
    fe [[ f ]]( s, us, cf, ( -18463, -14952, 414.5 ), ( 0, 163.42, 0 ), "veh_sat_utv_ob" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_vehicles_cs";
    s.groupid = "boat";
    s.script_vehiclebundle = "veh_sat_tactical_raft_ob";
    fe [[ f ]]( s, us, cf, ( -24800, -49451, -10 ), ( 0, 211.25, 0 ), "veh_sat_tactical_raft_ob", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, 0 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_vehicles_cs";
    s.groupid = "lnd_mi_fort_south";
    s.script_vehiclebundle = "veh_sat_mil_lnd_cargo_truck_ob";
    fe [[ f ]]( s, us, cf, ( -33788, -39219, 760.5 ), ( 0, 261.48, 0 ), "veh_sat_mil_lnd_cargo_truck_ob" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_vehicles_cs";
    s.groupid = "lnd_coast_guard_south";
    s.script_vehiclebundle = "veh_sat_atv_ob";
    fe [[ f ]]( s, us, cf, ( -40800.5, -16578.2, 39.17 ), ( 354.51, 78.53, 0 ), "veh_sat_atv_ob" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_vehicles_cs";
    s.groupid = "lnd_sam_site_01";
    s.script_vehiclebundle = "veh_sat_atv_ob";
    fe [[ f ]]( s, us, cf, ( -34561, -25667, 606.5 ), ( 0, 337, 0 ), "veh_sat_atv_ob" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_vehicles_cs";
    s.groupid = "boat";
    s.script_vehiclebundle = "veh_sat_tactical_raft_ob";
    fe [[ f ]]( s, us, cf, ( -26583.5, -37328.5, -10 ), ( 0, 331.54, 0 ), "veh_sat_tactical_raft_ob" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_vehicles_cs";
    s.groupid = "boat";
    s.script_vehiclebundle = "veh_sat_mil_us_boat_pgb_ob";
    fe [[ f ]]( s, us, cf, ( -47169, -38141, -25 ), ( 0, 108.63, 0 ), "veh_sat_mil_us_boat_pgb_ob", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, 0 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_vehicles_cs";
    s.groupid = "boat";
    s.script_vehiclebundle = "veh_sat_tactical_raft_ob";
    fe [[ f ]]( s, us, cf, ( -21994.5, -37558.5, -10 ), ( 0, 202.66, 0 ), "veh_sat_tactical_raft_ob" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_vehicles_cs";
    s.groupid = "boat";
    s.script_vehiclebundle = "veh_sat_tactical_raft_ob";
    fe [[ f ]]( s, us, cf, ( -16143, -17735.5, -10 ), ( 0, 68.6, 0 ), "veh_sat_tactical_raft_ob", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, 0 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_vehicles_cs";
    s.groupid = "lnd_sam_site_01";
    s.script_vehiclebundle = "veh_sat_atv_ob";
    fe [[ f ]]( s, us, cf, ( -33758.8, -20136.2, 141.6 ), ( 0, 304.57, 0 ), "veh_sat_atv_ob" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_vehicles_cs";
    s.groupid = "boat";
    s.script_vehiclebundle = "veh_sat_tactical_raft_ob";
    fe [[ f ]]( s, us, cf, ( -6454, -29264, -10 ), ( 0, 89.52, 0 ), "veh_sat_tactical_raft_ob", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, 0 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_vehicles_cs";
    s.groupid = "boat";
    s.script_vehiclebundle = "veh_sat_tactical_raft_ob";
    fe [[ f ]]( s, us, cf, ( -6350, -19984, -10 ), ( 0, 179.94, 0 ), "veh_sat_tactical_raft_ob", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, 0 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_vehicles_cs";
    s.groupid = "boat";
    s.script_vehiclebundle = "veh_sat_tactical_raft_ob";
    fe [[ f ]]( s, us, cf, ( -28146.5, -16474.5, -10 ), ( 0, 168.78, 0 ), "veh_sat_tactical_raft_ob" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_vehicles_cs";
    s.groupid = "boat";
    s.script_vehiclebundle = "veh_sat_tactical_raft_ob";
    fe [[ f ]]( s, us, cf, ( -40773.5, -17066, -10 ), ( 0, 13.76, 0 ), "veh_sat_tactical_raft_ob", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, 0 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_vehicles_cs";
    s.groupid = "boat";
    s.script_vehiclebundle = "veh_sat_tactical_raft_ob";
    fe [[ f ]]( s, us, cf, ( -46975.5, -29484.5, -10 ), ( 0, 123.21, 0 ), "veh_sat_tactical_raft_ob", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, 0 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_vehicles_cs";
    s.groupid = "boat";
    s.script_vehiclebundle = "veh_sat_tactical_raft_ob";
    fe [[ f ]]( s, us, cf, ( -50017, -14818.5, -10 ), ( 0, 97.97, 0 ), "veh_sat_tactical_raft_ob", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, 0 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_vehicles_cs";
    s.groupid = "boat";
    s.script_vehiclebundle = "veh_sat_tactical_raft_ob";
    fe [[ f ]]( s, us, cf, ( -40929.5, -33067.5, -10 ), ( 0, 123.82, 0 ), "veh_sat_tactical_raft_ob" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_vehicles_cs";
    s.groupid = "boat";
    s.script_vehiclebundle = "veh_sat_tactical_raft_ob";
    fe [[ f ]]( s, us, cf, ( -35313.5, -31277.5, -10 ), ( 0, 192.13, 0 ), "veh_sat_tactical_raft_ob", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, 0 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_vehicles_cs";
    s.groupid = "boat";
    s.script_vehiclebundle = "veh_sat_tactical_raft_ob";
    fe [[ f ]]( s, us, cf, ( -32970.7, -35339.9, -10 ), ( 0, 101.56, 0 ), "veh_sat_tactical_raft_ob" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_vehicles_cs";
    s.groupid = "boat";
    s.script_vehiclebundle = "veh_sat_tactical_raft_ob";
    fe [[ f ]]( s, us, cf, ( -32202, -37435, -10 ), ( 0, 0.55, 0 ), "veh_sat_tactical_raft_ob" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_vehicles_cs";
    s.groupid = "boat";
    s.script_vehiclebundle = "veh_sat_tactical_raft_ob";
    fe [[ f ]]( s, us, cf, ( -31585.5, -42201, -10 ), ( 0, 308.07, 0 ), "veh_sat_tactical_raft_ob" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_vehicles_cs";
    s.groupid = "boat";
    s.script_vehiclebundle = "veh_sat_tactical_raft_ob";
    fe [[ f ]]( s, us, cf, ( -19923, -25523, -29 ), ( 0, 28.92, 0 ), "veh_sat_tactical_raft_ob", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, 0 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_vehicles_cs";
    s.groupid = "boat";
    s.script_vehiclebundle = "veh_sat_mil_us_boat_pgb_ob";
    fe [[ f ]]( s, us, cf, ( -29018.5, -50522, -42.5 ), ( 0, 345.44, 0 ), "veh_sat_mil_us_boat_pgb_ob", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, 0 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_vehicles_cs";
    s.groupid = "lnd_mi_training_checkpoint";
    s.script_vehiclebundle = "veh_sat_medium_truck_ob";
    fe [[ f ]]( s, us, cf, ( -21656.8, -31420.4, 433.87 ), ( 0, 25.85, 0 ), "veh_sat_medium_truck_ob" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_vehicles_cs";
    s.groupid = "lnd_mi_training_checkpoint";
    s.script_vehiclebundle = "veh_sat_utv_ob";
    fe [[ f ]]( s, us, cf, ( -21285.5, -26388.5, 160.6 ), ( 357.32, 298.68, -1.44 ), "veh_sat_utv_ob" );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace mp_sat_avalon_quad_03_ob_vehicles_cs
// Params 0, eflags: 0x4
// Checksum 0xc6c636fd, Offset: 0x1a1b
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace mp_sat_avalon_quad_03_ob_vehicles_cs
// Params 0
// Checksum 0xed6b6b27, Offset: 0x1a25
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "mp_sat_avalon_quad_03_ob_vehicles_cs" );
}

