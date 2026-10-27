// script_7cc655bfe3961040  (hash_7cc655bfe3961040.gscc) (size: 7922 Bytes / 0x1ef2 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x162a67c7 (371877831)
// size ...... 7922 (0x1ef2)
// includes .. 3   (offset: 0x1b52)
// strings ... 12  (offset: 0x1b6a)
// dev strs .. 0   (offset: 0x1ef2)
// exports ... 9   (offset: 0x17ba)
// cseg ...... 0x19b + 0x161f (0x17ba)
// imports ... 20  (offset: 0x1922)
// animtree1 . 0   (offset: 0x1ef2)
// animtree2 . 0   (offset: 0x1ef2)
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace mp_sat_avalon_quad_04_ob_vehicles_cs;

// Namespace mp_sat_avalon_quad_04_ob_vehicles_cs
// Params 0, eflags: 0x5
// Checksum 0x52e41670, Offset: 0x1b9
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"mp_sat_avalon_quad_04_ob_vehicles_cs", undefined, &function_b39ecd3d51489472, undefined );
}

// Namespace mp_sat_avalon_quad_04_ob_vehicles_cs
// Params 0, eflags: 0x4
// Checksum 0x3c42926b, Offset: 0x1da
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace mp_sat_avalon_quad_04_ob_vehicles_cs
// Params 0, eflags: 0x4
// Checksum 0xb9794187, Offset: 0x1eb
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace mp_sat_avalon_quad_04_ob_vehicles_cs
// Params 2
// Checksum 0x99017ce, Offset: 0x1fc
// Size: 0x80
function main( unused, unused2 )
{
    if ( utility::flag_exist( "mp_sat_avalon_quad_04_ob_vehicles_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "mp_sat_avalon_quad_04_ob_vehicles_cs" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "mp_sat_avalon_quad_04_ob_vehicles_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "mp_sat_avalon_quad_04_ob_vehicles_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace mp_sat_avalon_quad_04_ob_vehicles_cs
// Params 3, eflags: 0x4
// Checksum 0x3afbf548, Offset: 0x284
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "mp_sat_avalon_quad_04_ob_vehicles_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "mp_sat_avalon_quad_04_ob_vehicles_cs" );
}

// Namespace mp_sat_avalon_quad_04_ob_vehicles_cs
// Params 3, eflags: 0x4
// Checksum 0x7dfd7dc4, Offset: 0x2fe
// Size: 0x149c
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_04_ob_vehicles_cs";
    s.script_vehiclebundle = "veh_sat_mil_us_boat_pgb_ob";
    fe [[ f ]]( s, us, cf, ( 33214.5, -22832.5, -24 ), ( 0, 55.77, 0 ), "veh_sat_mil_us_boat_pgb_ob" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_04_ob_vehicles_cs";
    s.script_vehiclebundle = "veh_sat_atv_ob";
    fe [[ f ]]( s, us, cf, ( 30206.4, -11935.1, 286.2 ), ( 0, 250, 0 ), "veh_sat_atv_ob", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, 8 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_04_ob_vehicles_cs";
    s.script_vehiclebundle = "veh_sat_tactical_raft_ob";
    fe [[ f ]]( s, us, cf, ( 40302, -12188, 2 ), ( 0, 90.77, 0 ), "veh_sat_tactical_raft_ob" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_04_ob_vehicles_cs";
    s.script_vehiclebundle = "veh_sat_mil_lnd_cargo_truck_ob";
    fe [[ f ]]( s, us, cf, ( 55698.7, -27217.9, 2487.86 ), ( 0, 157.11, 0 ), "veh_sat_mil_lnd_cargo_truck_ob" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_04_ob_vehicles_cs";
    s.script_vehiclebundle = "veh_sat_mil_lnd_cargo_truck_ob";
    fe [[ f ]]( s, us, cf, ( 35020, -13884, 266 ), ( 0, 180.64, 0 ), "veh_sat_mil_lnd_cargo_truck_ob" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_04_ob_vehicles_cs";
    s.script_vehiclebundle = "veh_sat_mil_lnd_cargo_truck_ob";
    fe [[ f ]]( s, us, cf, ( 50640, -9904, 498 ), ( 0, 240.64, 0 ), "veh_sat_mil_lnd_cargo_truck_ob" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_04_ob_vehicles_cs";
    s.script_vehiclebundle = "veh_sat_atv_ob";
    fe [[ f ]]( s, us, cf, ( 36468, -33416, 636 ), ( 0, 130.2, 0 ), "veh_sat_atv_ob" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_04_ob_vehicles_cs";
    s.script_vehiclebundle = "veh_sat_mil_lnd_cargo_truck_ob";
    fe [[ f ]]( s, us, cf, ( 41317, -28800, 263 ), ( 0, 179.74, 0 ), "veh_sat_mil_lnd_cargo_truck_ob" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_04_ob_vehicles_cs";
    s.script_vehiclebundle = "veh_sat_medium_truck_ob";
    fe [[ f ]]( s, us, cf, ( 26601.5, -23186.4, 246.35 ), ( 0, 108.33, 0 ), "veh_sat_medium_truck_ob", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, 8 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_04_ob_vehicles_cs";
    s.script_vehiclebundle = "veh_sat_medium_truck_ob";
    fe [[ f ]]( s, us, cf, ( 27373.8, -12229.5, 292.45 ), ( 0, 308.74, 0 ), "veh_sat_medium_truck_ob", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, 8 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_04_ob_vehicles_cs";
    s.script_vehiclebundle = "veh_sat_utv_ob";
    fe [[ f ]]( s, us, cf, ( 52878.5, -41701.1, 2084 ), ( 0, 45.23, 0 ), "veh_sat_utv_ob" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_04_ob_vehicles_cs";
    s.script_vehiclebundle = "veh_sat_atv_ob";
    fe [[ f ]]( s, us, cf, ( 47179.5, -323.1, 950.04 ), ( 0.17, 257.38, -15.05 ), "veh_sat_atv_ob", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, 8 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_04_ob_vehicles_cs";
    s.name = "pisces_shipyard_cargo_truck_ob";
    s.script_vehiclebundle = "veh_sat_mil_lnd_cargo_truck_ob";
    fe [[ f ]]( s, us, cf, ( 32916.5, -47920, 208.45 ), ( 0, 81.6, 0 ), "veh_sat_atv_ob", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, 8 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_04_ob_vehicles_cs";
    s.script_vehiclebundle = "veh_sat_atv_ob";
    fe [[ f ]]( s, us, cf, ( 47625.5, -21711.1, 859.92 ), ( 352.95, 258.85, -10.01 ), "veh_sat_atv_ob", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, 8 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_04_ob_vehicles_cs";
    s.script_vehiclebundle = "veh_sat_medium_truck_ob";
    fe [[ f ]]( s, us, cf, ( 46826, -37186, 1988.82 ), ( 0, 134, 0 ), "veh_sat_mil_lnd_cargo_truck_ob" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_04_ob_vehicles_cs";
    s.script_vehiclebundle = "veh_sat_utv_ob";
    fe [[ f ]]( s, us, cf, ( 5900, -51236, 730 ), ( 0, 30, 0 ), "veh_sat_utv_ob" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_04_ob_vehicles_cs";
    s.name = "pisces_shipyard_medium_truck_ob";
    s.script_vehiclebundle = "veh_sat_medium_truck_mg_ob";
    fe [[ f ]]( s, us, cf, ( 31033, -46106, 195.28 ), ( 0, 181.51, 0 ), "veh_sat_atv_ob", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, 8 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_04_ob_vehicles_cs";
    s.script_vehiclebundle = "veh_sat_atv_ob";
    fe [[ f ]]( s, us, cf, ( 46845.3, -21809.5, 897.08 ), ( 356.95, 289.51, 7.18 ), "veh_sat_atv_ob", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, 8 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_04_ob_vehicles_cs";
    s.script_vehiclebundle = "veh_sat_medium_truck_ob";
    fe [[ f ]]( s, us, cf, ( 27362.6, -19452, 267.55 ), ( 0, 159.3, 0 ), "veh_sat_medium_truck_ob", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, 8 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_04_ob_vehicles_cs";
    s.script_vehiclebundle = "veh_sat_utv_ob";
    fe [[ f ]]( s, us, cf, ( 43742.3, -42396.2, 1251.58 ), ( 0, 50.23, 0 ), "veh_sat_utv_ob" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_04_ob_vehicles_cs";
    s.script_vehiclebundle = "veh_sat_atv_ob";
    fe [[ f ]]( s, us, cf, ( 12037.4, -17031.4, 3067.79 ), ( 0, 278.9, 0 ), "veh_sat_atv_ob", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, 0 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_04_ob_vehicles_cs";
    s.script_vehiclebundle = "veh_sat_medium_truck_ob";
    fe [[ f ]]( s, us, cf, ( 8708, -8616, 1808 ), ( 0, 60.23, 0 ), "veh_sat_medium_truck_ob" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_04_ob_vehicles_cs";
    s.name = "pisces_shipyard_cargo_truck_ob";
    s.script_vehiclebundle = "veh_sat_mil_lnd_cargo_truck_ob";
    fe [[ f ]]( s, us, cf, ( 52495.5, -2734, 829.35 ), ( 6.99, 217.02, -6.66 ), "veh_sat_atv_ob", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, 8 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_04_ob_vehicles_cs";
    s.script_vehiclebundle = "veh_sat_atv_ob";
    fe [[ f ]]( s, us, cf, ( 15856, -1344, 1870 ), ( 0, 205.2, 0 ), "veh_sat_atv_ob" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_04_ob_vehicles_cs";
    s.name = "pisces_shipyard_cargo_truck_ob";
    s.script_vehiclebundle = "veh_sat_mil_lnd_cargo_truck_ob";
    fe [[ f ]]( s, us, cf, ( 40059.5, -3022, 542.26 ), ( 2.81, 299.56, 1.08 ), "veh_sat_atv_ob", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, 8 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_04_ob_vehicles_cs";
    s.script_vehiclebundle = "veh_sat_medium_truck_ob";
    fe [[ f ]]( s, us, cf, ( 34864, -48552, 208 ), ( 0, 80.23, 0 ), "veh_sat_medium_truck_ob" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_04_ob_vehicles_cs";
    s.script_vehiclebundle = "veh_sat_atv_ob";
    fe [[ f ]]( s, us, cf, ( 54260, -43920, 2002 ), ( 0, 220.2, 0 ), "veh_sat_atv_ob" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_04_ob_vehicles_cs";
    s.script_vehiclebundle = "veh_sat_medium_truck_ob";
    fe [[ f ]]( s, us, cf, ( 40362.5, -1353.9, 606.1 ), ( 0, 141.31, 0 ), "veh_sat_medium_truck_ob", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, 8 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_04_ob_vehicles_cs";
    s.script_vehiclebundle = "veh_sat_atv_ob";
    fe [[ f ]]( s, us, cf, ( 29076, -34764, 242 ), ( 0, 20.2, 0 ), "veh_sat_atv_ob" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_04_ob_vehicles_cs";
    s.script_vehiclebundle = "veh_sat_medium_truck_ob";
    fe [[ f ]]( s, us, cf, ( 49994.5, -14177.4, 344.64 ), ( 0, 244.79, 0 ), "veh_sat_medium_truck_ob", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, 8 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_04_ob_vehicles_cs";
    s.script_vehiclebundle = "veh_sat_medium_truck_ob";
    fe [[ f ]]( s, us, cf, ( 42097.5, -14066.4, 296.77 ), ( 0, 244.79, 0 ), "veh_sat_medium_truck_ob", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, 8 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_04_ob_vehicles_cs";
    s.script_vehiclebundle = "veh_sat_atv_ob";
    fe [[ f ]]( s, us, cf, ( 45102.5, -2590.5, 836.18 ), ( 0, 231, 0 ), "veh_sat_atv_ob", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, 8 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_04_ob_vehicles_cs";
    s.script_vehiclebundle = "veh_sat_medium_truck_ob";
    fe [[ f ]]( s, us, cf, ( 42200, -24328, 320 ), ( 0, 60.23, 0 ), "veh_sat_medium_truck_ob", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, 8 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_04_ob_vehicles_cs";
    s.script_vehiclebundle = "veh_sat_mil_lnd_cargo_truck_ob";
    fe [[ f ]]( s, us, cf, ( 46013, -54640, 504 ), ( 0, 90.04, 0 ), "veh_sat_mil_lnd_cargo_truck_ob" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_04_ob_vehicles_cs";
    s.script_vehiclebundle = "veh_sat_utv_ob";
    fe [[ f ]]( s, us, cf, ( 30423.7, -3499.42, 321.51 ), ( 0, 135.24, 0 ), "veh_sat_utv_ob" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_04_ob_vehicles_cs";
    s.script_vehiclebundle = "veh_sat_atv_ob";
    fe [[ f ]]( s, us, cf, ( 44006, -17502.5, 585.83 ), ( 0, 301.73, 0 ), "veh_sat_atv_ob", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, 8 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_04_ob_vehicles_cs";
    s.script_vehiclebundle = "veh_sat_mil_us_boat_pgb_ob";
    fe [[ f ]]( s, us, cf, ( 26285.5, -36015.5, -10 ), ( 0, 89.97, 0 ), "veh_sat_mil_us_boat_pgb_ob" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_04_ob_vehicles_cs";
    s.script_vehiclebundle = "veh_sat_tactical_raft_ob";
    fe [[ f ]]( s, us, cf, ( 32923, -22480, 2 ), ( 0, 55.77, 0 ), "veh_sat_tactical_raft_ob" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_04_ob_vehicles_cs";
    s.script_vehiclebundle = "veh_sat_atv_ob";
    fe [[ f ]]( s, us, cf, ( 2569.41, -7280.13, 1300.78 ), ( 0, 210, 0 ), "veh_sat_atv_ob" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_04_ob_vehicles_cs";
    s.script_vehiclebundle = "veh_sat_atv_ob";
    fe [[ f ]]( s, us, cf, ( 46776, -13584.5, 448.4 ), ( 0, 272.67, 0 ), "veh_sat_atv_ob", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, 8 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_04_ob_vehicles_cs";
    s.script_vehiclebundle = "veh_sat_tactical_raft_ob";
    fe [[ f ]]( s, us, cf, ( 32398.5, -53324.5, 2 ), ( 3.46, 233.96, -2.42 ), "veh_sat_tactical_raft_ob" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_04_ob_vehicles_cs";
    s.script_vehiclebundle = "veh_sat_utv_ob";
    fe [[ f ]]( s, us, cf, ( 15399.4, -9229.27, 3494.78 ), ( 360, 295.23, -0 ), "veh_sat_utv_ob" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_04_ob_vehicles_cs";
    s.script_vehiclebundle = "veh_sat_utv_ob";
    fe [[ f ]]( s, us, cf, ( 8480, -12804, 1930 ), ( 0, 255.24, 0 ), "veh_sat_utv_ob" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_04_ob_vehicles_cs";
    s.script_vehiclebundle = "veh_sat_atv_ob";
    fe [[ f ]]( s, us, cf, ( 30948, -42528, 1090 ), ( 0, 0.2, 0 ), "veh_sat_atv_ob" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_04_ob_vehicles_cs";
    s.script_vehiclebundle = "veh_sat_atv_ob";
    fe [[ f ]]( s, us, cf, ( 22392, -19660, 374 ), ( 0, 250.24, 0 ), "veh_sat_atv_ob", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, 8 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_04_ob_vehicles_cs";
    s.script_vehiclebundle = "veh_sat_mil_us_boat_pgb_ob";
    fe [[ f ]]( s, us, cf, ( 20511.1, -55359.7, -0 ), ( 0, 286.67, 0 ), "veh_sat_mil_us_boat_pgb_ob" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_04_ob_vehicles_cs";
    s.script_vehiclebundle = "veh_sat_medium_truck_ob";
    fe [[ f ]]( s, us, cf, ( 4861.72, -29982.6, 1537.1 ), ( 0, 337.24, 0 ), "veh_sat_medium_truck_ob" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_04_ob_vehicles_cs";
    s.script_vehiclebundle = "veh_sat_tactical_raft_ob";
    fe [[ f ]]( s, us, cf, ( 28107.7, -51056.9, 0 ), ( 3.46, 53.26, -2.42 ), "veh_sat_tactical_raft_ob" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_04_ob_vehicles_cs";
    s.script_vehiclebundle = "veh_sat_atv_ob";
    fe [[ f ]]( s, us, cf, ( 57632, -31520, 2238 ), ( 0, 130.2, 0 ), "veh_sat_atv_ob" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_04_ob_vehicles_cs";
    s.script_vehiclebundle = "veh_sat_mil_us_boat_pgb_ob";
    fe [[ f ]]( s, us, cf, ( 239.5, -48022.5, -14.5 ), ( 0, 333.77, 0 ), "veh_sat_mil_us_boat_pgb_ob" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_04_ob_vehicles_cs";
    s.script_vehiclebundle = "veh_sat_tactical_raft_ob";
    fe [[ f ]]( s, us, cf, ( 23820.7, -48423.9, 0 ), ( 3.46, 57.56, -2.42 ), "veh_sat_tactical_raft_ob" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_04_ob_vehicles_cs";
    s.script_vehiclebundle = "veh_sat_atv_ob";
    fe [[ f ]]( s, us, cf, ( 9748, -42220, 1658 ), ( 0, 100.2, 0 ), "veh_sat_atv_ob" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_04_ob_vehicles_cs";
    s.script_vehiclebundle = "veh_sat_atv_ob";
    fe [[ f ]]( s, us, cf, ( 52392, -32512, 2071.65 ), ( 0, 170, 0 ), "veh_sat_atv_ob" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_04_ob_vehicles_cs";
    s.script_vehiclebundle = "veh_sat_atv_ob";
    fe [[ f ]]( s, us, cf, ( 5420, -44536, 242 ), ( 0, 310.2, 0 ), "veh_sat_atv_ob" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_04_ob_vehicles_cs";
    s.script_vehiclebundle = "veh_sat_atv_ob";
    fe [[ f ]]( s, us, cf, ( 23692, -32376, 55.48 ), ( 0, 170, 0 ), "veh_sat_atv_ob" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_04_ob_vehicles_cs";
    s.script_vehiclebundle = "veh_sat_tactical_raft_ob";
    fe [[ f ]]( s, us, cf, ( 23931, -32981, 2 ), ( 0, 320.77, 0 ), "veh_sat_tactical_raft_ob" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_04_ob_vehicles_cs";
    s.script_vehiclebundle = "veh_sat_atv_ob";
    fe [[ f ]]( s, us, cf, ( 24130.5, -23412.3, 404.68 ), ( 0, 236.96, 0 ), "veh_sat_atv_ob", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, 0 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_04_ob_vehicles_cs";
    s.script_vehiclebundle = "veh_sat_utv_ob";
    fe [[ f ]]( s, us, cf, ( 62000, -16788, 1872 ), ( 0, 70, 0 ), "veh_sat_utv_ob" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_04_ob_vehicles_cs";
    s.script_vehiclebundle = "veh_sat_atv_ob";
    fe [[ f ]]( s, us, cf, ( 26724, -5746.85, 415.75 ), ( 0, 160.3, 0 ), "veh_sat_atv_ob", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, 8 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_04_ob_vehicles_cs";
    s.script_vehiclebundle = "veh_sat_utv_ob";
    fe [[ f ]]( s, us, cf, ( 39748, -27288, 258 ), ( 0, 210, 0 ), "veh_sat_utv_ob" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_04_ob_vehicles_cs";
    s.script_vehiclebundle = "veh_sat_tactical_raft_ob";
    fe [[ f ]]( s, us, cf, ( 23106.5, -57432.5, 2 ), ( 0, 326.17, 0 ), "veh_sat_tactical_raft_ob" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_04_ob_vehicles_cs";
    s.script_vehiclebundle = "veh_sat_tactical_raft_ob";
    fe [[ f ]]( s, us, cf, ( 6012.08, -47654.2, -6 ), ( 0, 277.77, 0 ), "veh_sat_tactical_raft_ob" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_04_ob_vehicles_cs";
    s.script_vehiclebundle = "veh_sat_mil_us_boat_pgb_ob";
    fe [[ f ]]( s, us, cf, ( 3273.5, -48865.1, -38.5 ), ( 0, 324.1, 0 ), "veh_sat_mil_us_boat_pgb_ob" );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace mp_sat_avalon_quad_04_ob_vehicles_cs
// Params 0, eflags: 0x4
// Checksum 0x2efc8daa, Offset: 0x17a2
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace mp_sat_avalon_quad_04_ob_vehicles_cs
// Params 0
// Checksum 0xf8a82805, Offset: 0x17ac
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "mp_sat_avalon_quad_04_ob_vehicles_cs" );
}

