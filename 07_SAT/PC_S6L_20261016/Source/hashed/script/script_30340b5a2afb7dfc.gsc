// script_30340b5a2afb7dfc  (hash_30340b5a2afb7dfc.gscc) (size: 4560 Bytes / 0x11d0 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x23de3f44 (601767748)
// size ...... 4560 (0x11d0)
// includes .. 3   (offset: 0xfb4)
// strings ... 11  (offset: 0xfcc)
// dev strs .. 0   (offset: 0x11d0)
// exports ... 9   (offset: 0xc1c)
// cseg ...... 0x143 + 0xad9 (0xc1c)
// imports ... 20  (offset: 0xd84)
// animtree1 . 0   (offset: 0x11d0)
// animtree2 . 0   (offset: 0x11d0)
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace mp_sat_avalon_city_ob_vehicles_cs;

// Namespace mp_sat_avalon_city_ob_vehicles_cs
// Params 0, eflags: 0x5
// Checksum 0xd9b6c3a5, Offset: 0x161
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"mp_sat_avalon_city_ob_vehicles_cs", undefined, &function_b39ecd3d51489472, undefined );
}

// Namespace mp_sat_avalon_city_ob_vehicles_cs
// Params 0, eflags: 0x4
// Checksum 0x97cc5213, Offset: 0x182
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace mp_sat_avalon_city_ob_vehicles_cs
// Params 0, eflags: 0x4
// Checksum 0x12f781ff, Offset: 0x193
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace mp_sat_avalon_city_ob_vehicles_cs
// Params 2
// Checksum 0xa21ed7b6, Offset: 0x1a4
// Size: 0x80
function main( unused, unused2 )
{
    if ( utility::flag_exist( "mp_sat_avalon_city_ob_vehicles_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "mp_sat_avalon_city_ob_vehicles_cs" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "mp_sat_avalon_city_ob_vehicles_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "mp_sat_avalon_city_ob_vehicles_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace mp_sat_avalon_city_ob_vehicles_cs
// Params 3, eflags: 0x4
// Checksum 0x91753530, Offset: 0x22c
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "mp_sat_avalon_city_ob_vehicles_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "mp_sat_avalon_city_ob_vehicles_cs" );
}

// Namespace mp_sat_avalon_city_ob_vehicles_cs
// Params 3, eflags: 0x4
// Checksum 0xf4347e65, Offset: 0x2a6
// Size: 0x956
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_vehicles_cs";
    s.script_poi = "delta_cityhall";
    s.script_vehiclebundle = "veh_sat_mil_us_boat_pgb_ob";
    fe [[ f ]]( s, us, cf, ( 3754.85, 14023.1, -20 ), ( 0, 0.62, 0 ), "veh_sat_mil_us_boat_pgb_ob" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_vehicles_cs";
    s.script_poi = "delta_cityhall";
    s.script_vehiclebundle = "veh_sat_tactical_raft_ob";
    fe [[ f ]]( s, us, cf, ( -4637.38, 7442.21, -16 ), ( 0, 327.48, 0 ), "veh_sat_tactical_raft_ob" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_vehicles_cs";
    s.script_poi = "delta_cityhall";
    s.script_vehiclebundle = "veh_sat_tactical_raft_ob";
    fe [[ f ]]( s, us, cf, ( 4930.5, 11958, -12 ), ( 0, 186.2, 0 ), "veh_sat_tactical_raft_ob" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_vehicles_cs";
    s.script_poi = "delta_cityhall";
    s.script_vehiclebundle = "veh_sat_utv_ob";
    fe [[ f ]]( s, us, cf, ( -4994.6, 5717.06, 20.86 ), ( 0, 102.41, 0 ), "veh_sat_utv_ob" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_vehicles_cs";
    s.script_poi = "delta_cityhall";
    s.script_vehiclebundle = "veh_sat_utv_ob";
    fe [[ f ]]( s, us, cf, ( -6906.68, -3272.39, 293.02 ), ( 359.65, 53.65, 0.52 ), "veh_sat_utv_ob" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_vehicles_cs";
    s.script_poi = "delta_cityhall";
    s.script_string = "18e";
    s.script_vehiclebundle = "veh_sat_medium_truck_ob";
    fe [[ f ]]( s, us, cf, ( -18891.8, 6605.48, 1045.77 ), ( 0, 67.7, 0 ), "veh_sat_medium_truck_ob" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_vehicles_cs";
    s.script_poi = "delta_cityhall";
    s.script_vehiclebundle = "veh_sat_mil_us_boat_pgb_ob";
    fe [[ f ]]( s, us, cf, ( -7391.36, 6786.71, -30 ), ( 0, 74.41, 0 ), "veh_sat_mil_us_boat_pgb_ob" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_vehicles_cs";
    s.script_poi = "delta_cityhall";
    s.script_vehiclebundle = "veh_sat_medium_truck_ob";
    fe [[ f ]]( s, us, cf, ( 4049, 8819.5, 117 ), ( 0, 155, 0 ), "veh_sat_medium_truck_ob" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_vehicles_cs";
    s.script_poi = "delta_cityhall";
    s.script_vehiclebundle = "veh_sat_medium_truck_ob";
    fe [[ f ]]( s, us, cf, ( -1975.04, 1910.5, 553 ), ( 0, 12.2, 0 ), "veh_sat_medium_truck_ob" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_vehicles_cs";
    s.script_poi = "delta_cityhall";
    s.script_vehiclebundle = "veh_sat_medium_truck_ob";
    fe [[ f ]]( s, us, cf, ( -7707.95, 1972.53, 284 ), ( 0, 283.86, 0 ), "veh_sat_medium_truck_ob" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_vehicles_cs";
    s.script_poi = "delta_cityhall";
    s.script_string = "15e";
    s.script_vehiclebundle = "veh_sat_utv_ob";
    fe [[ f ]]( s, us, cf, ( -15509.6, 10808.1, 1102.33 ), ( 0, 335.34, 0 ), "veh_sat_utv_ob" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_vehicles_cs";
    s.script_poi = "delta_cityhall";
    s.script_vehiclebundle = "veh_sat_medium_truck_ob";
    fe [[ f ]]( s, us, cf, ( -13396.2, 1771.49, 1018.99 ), ( 0, 314.66, 0 ), "veh_sat_medium_truck_ob" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_vehicles_cs";
    s.script_poi = "delta_cityhall";
    s.script_vehiclebundle = "veh_sat_medium_truck_ob";
    fe [[ f ]]( s, us, cf, ( -15150.2, 6527.38, 1051 ), ( 0, 37.32, 0 ), "veh_sat_medium_truck_ob" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_vehicles_cs";
    s.script_poi = "delta_cityhall";
    s.script_vehiclebundle = "veh_sat_utv_ob";
    fe [[ f ]]( s, us, cf, ( 5692.56, 541.83, 646.07 ), ( 0, 347.75, 0 ), "veh_sat_utv_ob" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_vehicles_cs";
    s.script_poi = "delta_cityhall";
    s.script_vehiclebundle = "veh_sat_tactical_raft_ob";
    fe [[ f ]]( s, us, cf, ( -2670.15, 11652.1, -18.5 ), ( 0, 346.99, 0 ), "veh_sat_tactical_raft_ob" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_vehicles_cs";
    s.script_poi = "delta_cityhall";
    s.script_vehiclebundle = "veh_sat_tactical_raft_ob";
    fe [[ f ]]( s, us, cf, ( -6757.91, 8805.49, -18 ), ( 0, 95.01, 0 ), "veh_sat_tactical_raft_ob" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_vehicles_cs";
    s.script_poi = "delta_cityhall";
    s.script_vehiclebundle = "veh_sat_medium_truck_ob";
    fe [[ f ]]( s, us, cf, ( 627, 3596, 545 ), ( 0, 0, 0 ), "veh_sat_medium_truck_ob" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_vehicles_cs";
    s.script_poi = "delta_cityhall";
    s.script_vehiclebundle = "veh_sat_medium_truck_ob";
    fe [[ f ]]( s, us, cf, ( -17636.9, 1982.01, 1035 ), ( 0, 130.1, 0 ), "veh_sat_medium_truck_ob" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_vehicles_cs";
    s.script_poi = "delta_cityhall";
    s.script_vehiclebundle = "veh_sat_medium_truck_ob";
    fe [[ f ]]( s, us, cf, ( -12316, 4544, 1043.81 ), ( 0, 121.59, 5 ), "veh_sat_medium_truck_ob" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_vehicles_cs";
    s.script_poi = "delta_cityhall";
    s.script_vehiclebundle = "veh_sat_utv_ob";
    fe [[ f ]]( s, us, cf, ( -5146.18, 3557.74, 544 ), ( 0, 164.7, 0 ), "veh_sat_utv_ob" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_vehicles_cs";
    s.script_poi = "delta_cityhall";
    s.script_vehiclebundle = "veh_sat_medium_truck_ob";
    fe [[ f ]]( s, us, cf, ( -14041.1, -2979, 1031.99 ), ( 0, 13.77, 0 ), "veh_sat_medium_truck_ob" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_vehicles_cs";
    s.script_poi = "delta_cityhall";
    s.script_vehiclebundle = "veh_sat_tactical_raft_ob";
    fe [[ f ]]( s, us, cf, ( -15206.2, -8623.57, -15.57 ), ( 0, 2.48, 0 ), "veh_sat_tactical_raft_ob" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_vehicles_cs";
    s.script_poi = "delta_cityhall";
    s.script_vehiclebundle = "veh_sat_tactical_raft_ob";
    fe [[ f ]]( s, us, cf, ( 976, 8512, -16 ), ( 0, 170, 0 ), "veh_sat_tactical_raft_ob" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_vehicles_cs";
    s.script_poi = "delta_cityhall";
    s.script_vehiclebundle = "veh_sat_mil_lnd_cargo_truck_ob";
    fe [[ f ]]( s, us, cf, ( -17902.6, -3877.28, 1064 ), ( 0, 227.9, 0 ), "veh_sat_mil_lnd_cargo_truck_ob" );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace mp_sat_avalon_city_ob_vehicles_cs
// Params 0, eflags: 0x4
// Checksum 0xab2316f9, Offset: 0xc04
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace mp_sat_avalon_city_ob_vehicles_cs
// Params 0
// Checksum 0x5326e87d, Offset: 0xc0e
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "mp_sat_avalon_city_ob_vehicles_cs" );
}

