// scripts\mp\maps\mp_saw_avalon\mp_saw_avalon_dronehunt_bongo_cs.gsc  (hash_593b7ff8a86f3264.gscc) (size: 13630 Bytes / 0x353e / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x8099403f (2157527103)
// size ...... 13630 (0x353e)
// includes .. 3   (offset: 0x2df6)
// strings ... 68  (offset: 0x2e0e)
// dev strs .. 0   (offset: 0x353e)
// exports ... 9   (offset: 0x2a5e)
// cseg ...... 0x813 + 0x224b (0x2a5e)
// imports ... 20  (offset: 0x2bc6)
// animtree1 . 0   (offset: 0x353e)
// animtree2 . 0   (offset: 0x353e)
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace mp_saw_avalon_dronehunt_bongo_cs;

// Namespace mp_saw_avalon_dronehunt_bongo_cs
// Params 0, eflags: 0x5
// Checksum 0x52aa5043, Offset: 0x831
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"mp_saw_avalon_dronehunt_bongo_cs", undefined, &function_b39ecd3d51489472, undefined );
}

// Namespace mp_saw_avalon_dronehunt_bongo_cs
// Params 0, eflags: 0x4
// Checksum 0x5f61a916, Offset: 0x852
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace mp_saw_avalon_dronehunt_bongo_cs
// Params 0, eflags: 0x4
// Checksum 0xda5a7afa, Offset: 0x863
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace mp_saw_avalon_dronehunt_bongo_cs
// Params 2
// Checksum 0x6ab32cb3, Offset: 0x874
// Size: 0x80
function main( unused, unused2 )
{
    if ( utility::flag_exist( "mp_saw_avalon_dronehunt_bongo_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "mp_saw_avalon_dronehunt_bongo_cs" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "mp_saw_avalon_dronehunt_bongo_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "mp_saw_avalon_dronehunt_bongo_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace mp_saw_avalon_dronehunt_bongo_cs
// Params 3, eflags: 0x4
// Checksum 0x59d8ce35, Offset: 0x8fc
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "mp_saw_avalon_dronehunt_bongo_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "mp_saw_avalon_dronehunt_bongo_cs" );
}

// Namespace mp_saw_avalon_dronehunt_bongo_cs
// Params 3, eflags: 0x4
// Checksum 0x80b01c3d, Offset: 0x976
// Size: 0x20c8
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_saw_avalon_dronehunt_bongo_cs";
    s.activity_bundle = "saw_activity_bongo_drone_hunt";
    s.name = "DRONE_HUNT_CITY_HIGHTOWN";
    fe [[ f ]]( s, us, cf, ( -23349.9, 13321.7, 1322.42 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 4000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_dronehunt_bongo_cs";
    s.activity_bundle = "saw_activity_bongo_drone_hunt";
    s.name = "DRONE_HUNT_Q1_GOLF";
    fe [[ f ]]( s, us, cf, ( -30803.3, 32322.3, 1614.81 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 4000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_dronehunt_bongo_cs";
    s.activity_bundle = "saw_activity_bongo_drone_hunt";
    s.name = "DRONE_HUNT_Q1_MANSION";
    fe [[ f ]]( s, us, cf, ( -55014.9, 3064.7, 357.84 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 4000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_dronehunt_bongo_cs";
    s.activity_bundle = "saw_activity_bongo_drone_hunt";
    s.name = "DRONE_HUNT_CITY_HIGHTTOWN_PARK";
    fe [[ f ]]( s, us, cf, ( -13534.9, -3651.3, 837.03 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 4000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_dronehunt_bongo_cs";
    s.activity_bundle = "saw_activity_bongo_drone_hunt";
    s.name = "DRONE_HUNT_Q2_COLOSSEUM_WEST";
    fe [[ f ]]( s, us, cf, ( 32632.8, 22789.4, 3236.11 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 4000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_dronehunt_bongo_cs";
    s.activity_bundle = "saw_activity_bongo_drone_hunt";
    s.name = "DRONE_HUNT_LOWTOWN_DOCKS2";
    fe [[ f ]]( s, us, cf, ( 4592.1, 8664.7, 85.32 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 4000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_dronehunt_bongo_cs";
    s.activity_bundle = "saw_activity_bongo_drone_hunt";
    s.name = "DRONE_HUNT_Q4_WATER_EAST";
    fe [[ f ]]( s, us, cf, ( 55230.9, -6655.5, 725.74 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 4000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_dronehunt_bongo_cs";
    s.activity_bundle = "saw_activity_bongo_drone_hunt";
    s.name = "DRONE_HUNT_Q1_STADIUM";
    fe [[ f ]]( s, us, cf, ( -44503.9, 15255.7, 238.16 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 4000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_dronehunt_bongo_cs";
    s.activity_bundle = "saw_activity_bongo_drone_hunt";
    s.name = "DRONE_HUNT_Q2_CLIFFTOWN";
    fe [[ f ]]( s, us, cf, ( 44636.6, 1609.4, 1488.37 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 4000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_dronehunt_bongo_cs";
    s.activity_bundle = "saw_activity_bongo_drone_hunt";
    s.name = "DRONE_HUNT_Q1_SUBURBS_EAST";
    fe [[ f ]]( s, us, cf, ( -4976.64, 48358.9, 508.5 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 4000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_dronehunt_bongo_cs";
    s.activity_bundle = "saw_activity_bongo_drone_hunt";
    s.name = "DRONE_HUNT_Q2_WINERY_SOUTH_EAST";
    fe [[ f ]]( s, us, cf, ( 33709, 37946, 3321.79 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 4000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_dronehunt_bongo_cs";
    s.activity_bundle = "saw_activity_bongo_drone_hunt";
    s.name = "DRONE_HUNT_Q2_WINERY_SOUTH";
    fe [[ f ]]( s, us, cf, ( 20109.5, 34770.5, 2337.79 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 4000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_dronehunt_bongo_cs";
    s.activity_bundle = "saw_activity_bongo_drone_hunt";
    s.name = "DRONE_HUNT_Q3_RUINS";
    fe [[ f ]]( s, us, cf, ( -24202.9, -13851.3, 1347.95 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 4000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_dronehunt_bongo_cs";
    s.activity_bundle = "saw_activity_bongo_drone_hunt";
    s.name = "DRONE_HUNT_LOWTOWN";
    fe [[ f ]]( s, us, cf, ( 3022.1, -7518.3, 1282 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 4000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_dronehunt_bongo_cs";
    s.activity_bundle = "saw_activity_bongo_drone_hunt";
    s.name = "DRONE_HUNT_Q3_DOCK";
    fe [[ f ]]( s, us, cf, ( -44151.9, -37333.3, 246.5 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 4000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_dronehunt_bongo_cs";
    s.activity_bundle = "saw_activity_bongo_drone_hunt";
    s.name = "DRONE_HUNT_Q3_LISTENING_WEST";
    fe [[ f ]]( s, us, cf, ( -28126.4, -40266.9, 709.72 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 4000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_dronehunt_bongo_cs";
    s.activity_bundle = "saw_activity_bongo_drone_hunt";
    s.name = "DRONE_HUNT_Q3_FIRINGRANGE";
    fe [[ f ]]( s, us, cf, ( -26519.6, -29173.5, 929.92 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 4000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_dronehunt_bongo_cs";
    s.activity_bundle = "saw_activity_bongo_drone_hunt";
    s.name = "DRONE_HUNT_Q4_HELIPORT1";
    fe [[ f ]]( s, us, cf, ( 26673.2, -17832.5, 280.74 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 4000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_dronehunt_bongo_cs";
    s.activity_bundle = "saw_activity_bongo_drone_hunt";
    s.name = "DRONE_HUNT_Q4_SHIPYARD";
    fe [[ f ]]( s, us, cf, ( 23416.9, -55030.5, 1087.97 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 4000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_dronehunt_bongo_cs";
    s.activity_bundle = "saw_activity_bongo_drone_hunt";
    s.name = "DRONE_HUNT_Q4_CARFACTORY_EAST";
    fe [[ f ]]( s, us, cf, ( 59339.6, -35561.5, 2448.29 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 4000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_dronehunt_bongo_cs";
    s.activity_bundle = "saw_activity_bongo_drone_hunt";
    s.name = "DRONE_HUNT_Q1_GOLF_SUPERMARKET";
    fe [[ f ]]( s, us, cf, ( -41735.9, 29946.7, 1758 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 4000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_dronehunt_bongo_cs";
    s.activity_bundle = "saw_activity_bongo_drone_hunt";
    s.name = "DRONE_HUNT_Q1_SUBURBS_WEST";
    fe [[ f ]]( s, us, cf, ( -15196.6, 48358.9, 561.9 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 4000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_dronehunt_bongo_cs";
    s.activity_bundle = "saw_activity_bongo_drone_hunt";
    s.name = "DRONE_HUNT_Q1_GLAMPING";
    fe [[ f ]]( s, us, cf, ( -26561.6, 53256.9, 2338.68 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 4000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_dronehunt_bongo_cs";
    s.activity_bundle = "saw_activity_bongo_drone_hunt";
    s.name = "DRONE_HUNT_Q4_CARFACTORY_WEST";
    fe [[ f ]]( s, us, cf, ( 40822.6, -36692.5, 2015.93 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 4000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_dronehunt_bongo_cs";
    s.activity_bundle = "saw_activity_bongo_drone_hunt";
    s.name = "DRONE_HUNT_Q4_WATER_SOUTH";
    fe [[ f ]]( s, us, cf, ( 48314.9, -18858.5, 427.29 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 4000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_dronehunt_bongo_cs";
    s.activity_bundle = "saw_activity_bongo_drone_hunt";
    s.name = "DRONE_HUNT_Q3_SECURITY";
    fe [[ f ]]( s, us, cf, ( -45375.6, -4509.5, 213.28 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 4000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_dronehunt_bongo_cs";
    s.activity_bundle = "saw_activity_bongo_drone_hunt";
    s.name = "DRONE_HUNT_CITY_CASINO_NORTH";
    fe [[ f ]]( s, us, cf, ( -10333.9, 34597.7, 895.82 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 4000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_dronehunt_bongo_cs";
    s.activity_bundle = "saw_activity_bongo_drone_hunt";
    s.name = "DRONE_HUNT_CITY_CONSTRUCTION";
    fe [[ f ]]( s, us, cf, ( -21399.9, 25253.7, 2397.89 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 4000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_dronehunt_bongo_cs";
    s.activity_bundle = "saw_activity_bongo_drone_hunt";
    s.name = "DRONE_HUNT_Q1_SUBURBS_TENNISCLUB";
    fe [[ f ]]( s, us, cf, ( -24385.6, 38476.9, 1828.91 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 4000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_dronehunt_bongo_cs";
    s.activity_bundle = "saw_activity_bongo_drone_hunt";
    s.name = "DRONE_HUNT_CITY_CASINO_RESORT";
    fe [[ f ]]( s, us, cf, ( 17853.8, 24191.4, 711.69 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 4000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_dronehunt_bongo_cs";
    s.activity_bundle = "saw_activity_bongo_drone_hunt";
    s.name = "DRONE_HUNT_Q2_WINERY_WEST";
    fe [[ f ]]( s, us, cf, ( 11041.5, 52229.5, 627.81 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 4000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_dronehunt_bongo_cs";
    s.activity_bundle = "saw_activity_bongo_drone_hunt";
    s.name = "DRONE_HUNT_Q2_WINERY_MARKET";
    fe [[ f ]]( s, us, cf, ( 2896.5, 31543.5, 1022.82 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 4000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_dronehunt_bongo_cs";
    s.activity_bundle = "saw_activity_bongo_drone_hunt";
    s.name = "DRONE_HUNT_Q4_WATER_CHOPSHOP";
    fe [[ f ]]( s, us, cf, ( 1959.9, -39453.5, 868.9 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 4000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_dronehunt_bongo_cs";
    s.activity_bundle = "saw_activity_bongo_drone_hunt";
    s.name = "DRONE_HUNT_Q4_WATER_FIRESTATION2";
    fe [[ f ]]( s, us, cf, ( 8131.9, -25068.5, 1970.15 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 4000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_dronehunt_bongo_cs";
    s.activity_bundle = "saw_activity_bongo_drone_hunt";
    s.name = "DRONE_HUNT_Q4_WATER_PIER1";
    fe [[ f ]]( s, us, cf, ( -794.1, -15920.5, 315.73 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 4000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_dronehunt_bongo_cs";
    s.activity_bundle = "saw_activity_bongo_drone_hunt";
    s.name = "DRONE_HUNT_Q3_FLOODED";
    fe [[ f ]]( s, us, cf, ( -44096.9, -26886.3, 357.84 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 4000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_dronehunt_bongo_cs";
    s.activity_bundle = "saw_activity_bongo_drone_hunt";
    s.name = "DRONE_HUNT_Q3_LIGHTHOUSE";
    fe [[ f ]]( s, us, cf, ( -50041.9, -16988.3, 357.84 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 4000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_dronehunt_bongo_cs";
    s.activity_bundle = "saw_activity_bongo_drone_hunt";
    s.name = "DRONE_HUNT_Q2_AQUADUCT";
    fe [[ f ]]( s, us, cf, ( 24479.6, -101.6, 1804.67 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 4000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_dronehunt_bongo_cs";
    s.activity_bundle = "saw_activity_bongo_drone_hunt";
    s.name = "DRONE_HUNT_Q2_COLOSSEUM_EAST";
    fe [[ f ]]( s, us, cf, ( 48291.8, 29773.4, 907.89 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 4000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_dronehunt_bongo_cs";
    s.activity_bundle = "saw_activity_bongo_drone_hunt";
    s.name = "DRONE_HUNT_Q2_WINERY_EAST";
    fe [[ f ]]( s, us, cf, ( 25331.5, 50634.5, 1873.2 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 4000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_dronehunt_bongo_cs";
    s.activity_bundle = "saw_activity_bongo_drone_hunt";
    s.name = "DRONE_HUNT_Q4_RECYCLING";
    fe [[ f ]]( s, us, cf, ( 47807.9, -54870.5, 454.41 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 4000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_dronehunt_bongo_cs";
    s.activity_bundle = "saw_activity_bongo_drone_hunt";
    s.name = "DRONE_HUNT_Q2_COLOSSEUM_RUINS";
    fe [[ f ]]( s, us, cf, ( 57221.8, 14221.4, 1277.78 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 4000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_dronehunt_bongo_cs";
    s.activity_bundle = "saw_activity_bongo_drone_hunt";
    s.name = "DRONE_HUNT_Q3_YAUGHT";
    fe [[ f ]]( s, us, cf, ( -31334.6, -4797.5, 617.99 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 4000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_dronehunt_bongo_cs";
    s.activity_bundle = "saw_activity_bongo_drone_hunt";
    s.name = "DRONE_HUNT_Q4_SHIPYARD_BRIDGE2";
    fe [[ f ]]( s, us, cf, ( 23872.6, -40420.5, 1438.63 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 4000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_dronehunt_bongo_cs";
    s.activity_bundle = "saw_activity_bongo_drone_hunt";
    s.name = "DRONE_HUNT_Q3_LISTENING_EAST";
    fe [[ f ]]( s, us, cf, ( -15106.4, -42190.9, 523.31 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 4000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_dronehunt_bongo_cs";
    s.activity_bundle = "saw_activity_bongo_drone_hunt";
    s.name = "DRONE_HUNT_Q3_LISTENING_ISLAND2";
    fe [[ f ]]( s, us, cf, ( -15170.4, -21339.9, 708.47 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 4000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_dronehunt_bongo_cs";
    s.activity_bundle = "saw_activity_bongo_drone_hunt";
    s.name = "DRONE_HUNT_Q2_WINERY_SOUTH_WEST";
    fe [[ f ]]( s, us, cf, ( 8817.5, 44163.5, 564.51 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 4000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_dronehunt_bongo_cs";
    s.activity_bundle = "saw_activity_bongo_drone_hunt";
    s.name = "DRONE_HUNT_CITY_HIGHTOWN_MANSIONS";
    fe [[ f ]]( s, us, cf, ( -13605.9, 15913.7, 1100.45 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 4000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_dronehunt_bongo_cs";
    s.activity_bundle = "saw_activity_bongo_drone_hunt";
    s.name = "DRONE_HUNT_Q4_WATER_CHOPSHOP_RUINS";
    fe [[ f ]]( s, us, cf, ( 597.9, -53611.5, 1208.09 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 4000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_dronehunt_bongo_cs";
    s.activity_bundle = "saw_activity_bongo_drone_hunt";
    s.name = "DRONE_HUNT_Q4_RUINS1";
    fe [[ f ]]( s, us, cf, ( 16926.2, -8702.5, 3439.7 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 4000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_dronehunt_bongo_cs";
    s.activity_bundle = "saw_activity_bongo_drone_hunt";
    s.name = "DRONE_HUNT_LOWTOWN_PIER";
    fe [[ f ]]( s, us, cf, ( 13601.2, 6437.5, 156 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 4000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_dronehunt_bongo_cs";
    s.activity_bundle = "saw_activity_bongo_drone_hunt";
    s.name = "DRONE_HUNT_Q4_HELIPORT2";
    fe [[ f ]]( s, us, cf, ( 34771.2, -11578.5, 219.75 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 4000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_dronehunt_bongo_cs";
    s.activity_bundle = "saw_activity_bongo_drone_hunt";
    s.name = "DRONE_HUNT_Q4_RUINS2";
    fe [[ f ]]( s, us, cf, ( 12855.2, -17694.5, 3079.31 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 4000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_dronehunt_bongo_cs";
    s.activity_bundle = "saw_activity_bongo_drone_hunt";
    s.name = "DRONE_HUNT_Q4_HELIPORT3";
    fe [[ f ]]( s, us, cf, ( 22033.2, -31837.5, 980.74 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 4000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_dronehunt_bongo_cs";
    s.activity_bundle = "saw_activity_bongo_drone_hunt";
    s.name = "DRONE_HUNT_Q4_WATER_FIRESTATION1";
    fe [[ f ]]( s, us, cf, ( -4977.1, -31483.5, 104.4 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 4000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_dronehunt_bongo_cs";
    s.activity_bundle = "saw_activity_bongo_drone_hunt";
    s.name = "DRONE_HUNT_Q4_WATER_PIER2";
    fe [[ f ]]( s, us, cf, ( -1457.1, -24148.5, 315.73 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 4000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_dronehunt_bongo_cs";
    s.activity_bundle = "saw_activity_bongo_drone_hunt";
    s.name = "DRONE_HUNT_Q4_SHIPYARD_BRIDGE1";
    fe [[ f ]]( s, us, cf, ( 14348.6, -38742.5, 1089.04 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 4000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_dronehunt_bongo_cs";
    s.activity_bundle = "saw_activity_bongo_drone_hunt";
    s.name = "DRONE_HUNT_Q4_SHIPYARD_BRIDGE3";
    fe [[ f ]]( s, us, cf, ( 32380.6, -41971.5, 1140.91 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 4000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_dronehunt_bongo_cs";
    s.activity_bundle = "saw_activity_bongo_drone_hunt";
    s.name = "DRONE_HUNT_Q2_CANAL";
    fe [[ f ]]( s, us, cf, ( 29846.8, 14547.4, 1171.37 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 4000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_dronehunt_bongo_cs";
    s.activity_bundle = "saw_activity_bongo_drone_hunt";
    s.name = "DRONE_HUNT_Q4_HELIPORT4";
    fe [[ f ]]( s, us, cf, ( 30301.2, -26746.5, 27.21 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 4000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_dronehunt_bongo_cs";
    s.activity_bundle = "saw_activity_bongo_drone_hunt";
    s.name = "DRONE_HUNT_LOWTOWN_DOCKS1";
    fe [[ f ]]( s, us, cf, ( -5766.9, 13722.7, 120.37 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 4000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_dronehunt_bongo_cs";
    s.activity_bundle = "saw_activity_bongo_drone_hunt";
    s.name = "DRONE_HUNT_Q3_LISTENING_ISLAND1";
    fe [[ f ]]( s, us, cf, ( -16913.4, -13228.9, 20.7 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 4000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_dronehunt_bongo_cs";
    s.activity_bundle = "saw_activity_bongo_drone_hunt";
    s.name = "DRONE_HUNT_Q3_LISTENING_ISLAND2";
    fe [[ f ]]( s, us, cf, ( -14825.4, -30203.9, 506.91 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 4000 );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace mp_saw_avalon_dronehunt_bongo_cs
// Params 0, eflags: 0x4
// Checksum 0x5b943c08, Offset: 0x2a46
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace mp_saw_avalon_dronehunt_bongo_cs
// Params 0
// Checksum 0x9b8b1378, Offset: 0x2a50
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "mp_saw_avalon_dronehunt_bongo_cs" );
}

