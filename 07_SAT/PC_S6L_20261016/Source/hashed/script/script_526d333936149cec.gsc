// script_526d333936149cec  (hash_526d333936149cec.gscc) (size: 6453 Bytes / 0x1935 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xc0c1c802 (3233925122)
// size ...... 6453 (0x1935)
// includes .. 3   (offset: 0x164d)
// strings ... 10  (offset: 0x1665)
// dev strs .. 0   (offset: 0x1935)
// exports ... 9   (offset: 0x12b5)
// cseg ...... 0x14f + 0x1166 (0x12b5)
// imports ... 20  (offset: 0x141d)
// animtree1 . 0   (offset: 0x1935)
// animtree2 . 0   (offset: 0x1935)
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace mp_sat_avalon_quad_02_ob_vehicles_cs;

// Namespace mp_sat_avalon_quad_02_ob_vehicles_cs
// Params 0, eflags: 0x5
// Checksum 0x7b2273fc, Offset: 0x16d
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"mp_sat_avalon_quad_02_ob_vehicles_cs", undefined, &function_b39ecd3d51489472, undefined );
}

// Namespace mp_sat_avalon_quad_02_ob_vehicles_cs
// Params 0, eflags: 0x4
// Checksum 0x4e7fbb15, Offset: 0x18e
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace mp_sat_avalon_quad_02_ob_vehicles_cs
// Params 0, eflags: 0x4
// Checksum 0xcb4468f9, Offset: 0x19f
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace mp_sat_avalon_quad_02_ob_vehicles_cs
// Params 2
// Checksum 0x7bad3eb0, Offset: 0x1b0
// Size: 0x80
function main( unused, unused2 )
{
    if ( utility::flag_exist( "mp_sat_avalon_quad_02_ob_vehicles_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "mp_sat_avalon_quad_02_ob_vehicles_cs" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "mp_sat_avalon_quad_02_ob_vehicles_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "mp_sat_avalon_quad_02_ob_vehicles_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace mp_sat_avalon_quad_02_ob_vehicles_cs
// Params 3, eflags: 0x4
// Checksum 0x48c6dc36, Offset: 0x238
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "mp_sat_avalon_quad_02_ob_vehicles_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "mp_sat_avalon_quad_02_ob_vehicles_cs" );
}

// Namespace mp_sat_avalon_quad_02_ob_vehicles_cs
// Params 3, eflags: 0x4
// Checksum 0xaf0e3428, Offset: 0x2b2
// Size: 0xfe3
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_02_ob_vehicles_cs";
    s.script_vehiclebundle = "veh_sat_atv_ob";
    fe [[ f ]]( s, us, cf, ( 18734.6, 44032.1, 849.79 ), ( 0, 343.87, 0 ), "veh_sat_atv_ob", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, 0 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_02_ob_vehicles_cs";
    s.script_vehiclebundle = "veh_sat_tactical_raft_ob";
    fe [[ f ]]( s, us, cf, ( 13649.1, 15854.6, -0 ), ( 0, 96.22, 0 ), "veh_sat_tactical_raft_ob" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_02_ob_vehicles_cs";
    s.script_vehiclebundle = "veh_sat_tactical_raft_ob";
    fe [[ f ]]( s, us, cf, ( 29088.2, 12240.1, 13.37 ), ( 0, 175.42, 0 ), "veh_sat_tactical_raft_ob" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_02_ob_vehicles_cs";
    s.script_vehiclebundle = "veh_sat_utv_ob";
    fe [[ f ]]( s, us, cf, ( 32536.8, 47662, 1374.77 ), ( 0, 303.49, 0 ), "veh_sat_utv_ob" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_02_ob_vehicles_cs";
    s.script_vehiclebundle = "veh_sat_mil_lnd_cargo_truck_ob";
    fe [[ f ]]( s, us, cf, ( 30312.3, 32342.8, 3571.89 ), ( 7.57, 320.02, 0.5 ), "veh_sat_mil_lnd_cargo_truck_ob" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_02_ob_vehicles_cs";
    s.script_vehiclebundle = "veh_sat_medium_truck_ob";
    fe [[ f ]]( s, us, cf, ( 54616, 11537.2, 1644.33 ), ( 4.84, 86.26, 4.53 ), "veh_sat_medium_truck_ob" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_02_ob_vehicles_cs";
    s.script_vehiclebundle = "veh_sat_mil_lnd_cargo_truck_ob";
    fe [[ f ]]( s, us, cf, ( 39695.8, 22291.5, 759.26 ), ( 354.58, 180.82, -5.31 ), "veh_sat_mil_lnd_cargo_truck_ob" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_02_ob_vehicles_cs";
    s.script_vehiclebundle = "veh_sat_atv_ob";
    fe [[ f ]]( s, us, cf, ( 28396.3, 26856.8, 3132.71 ), ( 0, 290, 0 ), "veh_sat_atv_ob" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_02_ob_vehicles_cs";
    s.script_vehiclebundle = "veh_sat_utv_ob";
    fe [[ f ]]( s, us, cf, ( 51871.9, 21196.7, 414.6 ), ( 0, 191.02, 0 ), "veh_sat_utv_ob" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_02_ob_vehicles_cs";
    s.script_vehiclebundle = "veh_sat_utv_ob";
    fe [[ f ]]( s, us, cf, ( 40745.4, 28608.7, 718.98 ), ( 0, 142.53, 0 ), "veh_sat_utv_ob" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_02_ob_vehicles_cs";
    s.script_vehiclebundle = "veh_sat_atv_ob";
    fe [[ f ]]( s, us, cf, ( 43952.1, 33713.4, 1266.57 ), ( 358.29, 228.96, -20.77 ), "veh_sat_atv_ob", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, 0 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_02_ob_vehicles_cs";
    s.script_vehiclebundle = "veh_sat_atv_ob";
    fe [[ f ]]( s, us, cf, ( 39394.6, 44270.9, 1543.31 ), ( 356.77, 224.97, -20.6 ), "veh_sat_atv_ob", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, 0 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_02_ob_vehicles_cs";
    s.script_vehiclebundle = "veh_sat_mil_lnd_cargo_truck_ob";
    fe [[ f ]]( s, us, cf, ( 10865.8, 51446.5, 692.63 ), ( 0, 165.46, 0 ), "veh_sat_mil_lnd_cargo_truck_ob", undefined, "activity_stronghold" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_02_ob_vehicles_cs";
    s.script_vehiclebundle = "veh_sat_atv_ob";
    fe [[ f ]]( s, us, cf, ( 29255.9, 37582.7, 2273.56 ), ( 0, 64.42, 0 ), "veh_sat_atv_ob" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_02_ob_vehicles_cs";
    s.script_vehiclebundle = "veh_sat_utv_ob";
    fe [[ f ]]( s, us, cf, ( 51083.9, 13455.4, 756.56 ), ( 0, 292.68, 0 ), "veh_sat_utv_ob" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_02_ob_vehicles_cs";
    s.script_vehiclebundle = "veh_sat_atv_ob";
    fe [[ f ]]( s, us, cf, ( 1185.72, 37504.9, 749.89 ), ( 0, 126.23, 0 ), "veh_sat_atv_ob", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, 0 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_02_ob_vehicles_cs";
    s.script_vehiclebundle = "veh_sat_utv_ob";
    fe [[ f ]]( s, us, cf, ( 39390, 40508.6, 1902.18 ), ( 0, 314.6, 0 ), "veh_sat_utv_ob", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, 8 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_02_ob_vehicles_cs";
    s.script_vehiclebundle = "veh_sat_atv_ob";
    fe [[ f ]]( s, us, cf, ( 17991.1, 39147.5, 1163.14 ), ( 2.35, 152.05, 4.42 ), "veh_sat_atv_ob" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_02_ob_vehicles_cs";
    s.script_vehiclebundle = "veh_sat_atv_ob";
    fe [[ f ]]( s, us, cf, ( 23014.9, 50332.7, 886.48 ), ( 0, 145.93, 0 ), "veh_sat_atv_ob" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_02_ob_vehicles_cs";
    s.script_vehiclebundle = "veh_sat_utv_ob";
    fe [[ f ]]( s, us, cf, ( 31482.8, 25135.4, 3130.34 ), ( 355, 0, 0 ), "veh_sat_utv_ob" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_02_ob_vehicles_cs";
    s.script_vehiclebundle = "veh_sat_utv_ob";
    fe [[ f ]]( s, us, cf, ( 22015.3, 41689.3, 1011.25 ), ( 0, 264.5, 0 ), "veh_sat_utv_ob" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_02_ob_vehicles_cs";
    s.script_vehiclebundle = "veh_sat_utv_ob";
    fe [[ f ]]( s, us, cf, ( 6000.79, 38644.5, 756.71 ), ( 0, 81.01, 0 ), "veh_sat_utv_ob" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_02_ob_vehicles_cs";
    s.script_vehiclebundle = "veh_sat_utv_ob";
    fe [[ f ]]( s, us, cf, ( 23795.7, 1324.77, 2135.1 ), ( 9.81, 29.45, 10.97 ), "veh_sat_utv_ob" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_02_ob_vehicles_cs";
    s.script_vehiclebundle = "veh_sat_utv_ob";
    fe [[ f ]]( s, us, cf, ( 44541.4, 40703.9, 2049.37 ), ( 0, 273.96, 0 ), "veh_sat_utv_ob" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_02_ob_vehicles_cs";
    s.script_vehiclebundle = "veh_sat_atv_ob";
    fe [[ f ]]( s, us, cf, ( 53186.9, 16840.1, 364.62 ), ( 355.8, 271.14, 2.08 ), "veh_sat_atv_ob", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, 0 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_02_ob_vehicles_cs";
    s.script_vehiclebundle = "veh_sat_mil_us_boat_pgb_ob";
    fe [[ f ]]( s, us, cf, ( 3122.14, 19905.4, -25.12 ), ( 0, 242.41, 0 ), "veh_sat_mil_us_boat_pgb_ob" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_02_ob_vehicles_cs";
    s.script_vehiclebundle = "veh_sat_atv_ob";
    fe [[ f ]]( s, us, cf, ( 6378.9, 49311.8, 310.56 ), ( 2.11, 155.08, 4.53 ), "veh_sat_atv_ob" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_02_ob_vehicles_cs";
    s.script_vehiclebundle = "veh_sat_medium_truck_ob";
    fe [[ f ]]( s, us, cf, ( 38710.9, 39809.4, 1886.68 ), ( 0, 36.28, 0 ), "veh_sat_medium_truck_ob", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, 8 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_02_ob_vehicles_cs";
    s.script_vehiclebundle = "veh_sat_atv_ob";
    fe [[ f ]]( s, us, cf, ( 20672.5, 41163, 936.34 ), ( 0, 145.93, 0 ), "veh_sat_atv_ob" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_02_ob_vehicles_cs";
    s.script_vehiclebundle = "veh_sat_utv_ob";
    fe [[ f ]]( s, us, cf, ( 42453.2, 17131.2, 65.38 ), ( 358.81, 93.12, 0 ), "veh_sat_utv_ob" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_02_ob_vehicles_cs";
    s.script_vehiclebundle = "veh_sat_atv_ob";
    fe [[ f ]]( s, us, cf, ( 31137.8, 43236.8, 1252.16 ), ( 355.63, 294.82, -0.49 ), "veh_sat_atv_ob" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_02_ob_vehicles_cs";
    s.script_vehiclebundle = "veh_sat_mil_lnd_cargo_truck_ob";
    fe [[ f ]]( s, us, cf, ( 23706.2, 20399.3, 647.89 ), ( 0, 178.58, 0 ), "veh_sat_mil_lnd_cargo_truck_ob" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_02_ob_vehicles_cs";
    s.script_vehiclebundle = "veh_sat_tactical_raft_ob";
    fe [[ f ]]( s, us, cf, ( 12526.9, 8377.31, 8.84 ), ( 0, 87.99, 0 ), "veh_sat_tactical_raft_ob" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_02_ob_vehicles_cs";
    s.script_vehiclebundle = "veh_sat_atv_ob";
    fe [[ f ]]( s, us, cf, ( 20949, 19286.1, 645.91 ), ( 0, 317.97, 0 ), "veh_sat_atv_ob" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_02_ob_vehicles_cs";
    s.script_vehiclebundle = "veh_sat_atv_ob";
    fe [[ f ]]( s, us, cf, ( 10621.9, 24943.3, 760.94 ), ( 0, 132.94, 0 ), "veh_sat_atv_ob" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_02_ob_vehicles_cs";
    s.script_vehiclebundle = "veh_sat_tactical_raft_ob";
    fe [[ f ]]( s, us, cf, ( 42392.1, 16086.4, -12 ), ( 0, 287.37, 0 ), "veh_sat_tactical_raft_ob" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_02_ob_vehicles_cs";
    s.script_vehiclebundle = "veh_sat_utv_ob";
    fe [[ f ]]( s, us, cf, ( 2561.46, 50221.7, 536.6 ), ( 0, 111.03, 0 ), "veh_sat_utv_ob" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_02_ob_vehicles_cs";
    s.script_vehiclebundle = "veh_sat_atv_ob";
    fe [[ f ]]( s, us, cf, ( 16838.9, 36353.5, 1984.95 ), ( 0, 30.86, 0 ), "veh_sat_atv_ob" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_02_ob_vehicles_cs";
    s.script_vehiclebundle = "veh_sat_utv_ob";
    fe [[ f ]]( s, us, cf, ( 1181.3, 32944.5, 1086.98 ), ( 0, 267.94, 0 ), "veh_sat_utv_ob" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_02_ob_vehicles_cs";
    s.script_vehiclebundle = "veh_sat_utv_ob";
    fe [[ f ]]( s, us, cf, ( 30088.5, 15279.8, 1324.12 ), ( 0, 352.23, -0 ), "veh_sat_utv_ob" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_02_ob_vehicles_cs";
    s.script_vehiclebundle = "veh_sat_atv_ob";
    fe [[ f ]]( s, us, cf, ( 19521.2, 53967.2, 648.97 ), ( 0, 32.27, 0 ), "veh_sat_atv_ob" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_02_ob_vehicles_cs";
    s.script_vehiclebundle = "veh_sat_utv_ob";
    fe [[ f ]]( s, us, cf, ( 5395.83, 54948.7, 929.13 ), ( 0, 90, 0 ), "veh_sat_utv_ob" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_02_ob_vehicles_cs";
    s.script_vehiclebundle = "veh_sat_utv_ob";
    fe [[ f ]]( s, us, cf, ( 23427.1, 32648, 2621.29 ), ( 0, 122.62, 0 ), "veh_sat_utv_ob" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_02_ob_vehicles_cs";
    s.script_vehiclebundle = "veh_sat_utv_ob";
    fe [[ f ]]( s, us, cf, ( 9622.56, 32963.6, 2208.43 ), ( 0, 292.68, 0 ), "veh_sat_utv_ob" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_02_ob_vehicles_cs";
    s.script_vehiclebundle = "veh_sat_utv_ob";
    fe [[ f ]]( s, us, cf, ( 20546.3, 32343.3, 2295.8 ), ( 17.88, 183.12, 7.16 ), "veh_sat_utv_ob" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_02_ob_vehicles_cs";
    s.script_vehiclebundle = "veh_sat_utv_ob";
    fe [[ f ]]( s, us, cf, ( 34547, 37096.3, 2976.18 ), ( 0, 172.63, 0 ), "veh_sat_utv_ob" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_02_ob_vehicles_cs";
    s.script_vehiclebundle = "veh_sat_tactical_raft_ob";
    fe [[ f ]]( s, us, cf, ( 45410.6, 18310.4, 12.31 ), ( 0, 280.08, 0 ), "veh_sat_tactical_raft_ob" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_02_ob_vehicles_cs";
    s.script_vehiclebundle = "veh_sat_mil_us_boat_pgb_ob";
    fe [[ f ]]( s, us, cf, ( 43365.9, 11653, -27.5 ), ( 0, 152.79, 0 ), "veh_sat_mil_us_boat_pgb_ob" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_02_ob_vehicles_cs";
    s.script_vehiclebundle = "veh_sat_tactical_raft_ob";
    fe [[ f ]]( s, us, cf, ( 40010.6, 8818.4, -3.69 ), ( 0, 175.08, 0 ), "veh_sat_tactical_raft_ob", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, 8 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_02_ob_vehicles_cs";
    s.script_vehiclebundle = "veh_sat_tactical_raft_ob";
    fe [[ f ]]( s, us, cf, ( 40314.6, 9366.4, -3.69 ), ( 0, 155.08, 0 ), "veh_sat_tactical_raft_ob", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, 8 );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace mp_sat_avalon_quad_02_ob_vehicles_cs
// Params 0, eflags: 0x4
// Checksum 0xf50cd30, Offset: 0x129d
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace mp_sat_avalon_quad_02_ob_vehicles_cs
// Params 0
// Checksum 0x8a95017b, Offset: 0x12a7
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "mp_sat_avalon_quad_02_ob_vehicles_cs" );
}

