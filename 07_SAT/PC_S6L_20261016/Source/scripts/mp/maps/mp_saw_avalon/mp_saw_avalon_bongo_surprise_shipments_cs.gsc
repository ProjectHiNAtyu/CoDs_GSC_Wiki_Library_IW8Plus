// scripts\mp\maps\mp_saw_avalon\mp_saw_avalon_bongo_surprise_shipments_cs.gsc  (hash_5cf4fe39263f16fe.gscc) (size: 28353 Bytes / 0x6ec1 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x168dc312 (378389266)
// size ...... 28353 (0x6ec1)
// includes .. 3   (offset: 0x5f09)
// strings ... 125 (offset: 0x5f21)
// dev strs .. 0   (offset: 0x6ec1)
// exports ... 9   (offset: 0x5b71)
// cseg ...... 0x110c + 0x4a65 (0x5b71)
// imports ... 20  (offset: 0x5cd9)
// animtree1 . 0   (offset: 0x6ec1)
// animtree2 . 0   (offset: 0x6ec1)
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace mp_saw_avalon_bongo_surprise_shipments_cs;

// Namespace mp_saw_avalon_bongo_surprise_shipments_cs
// Params 0, eflags: 0x5
// Checksum 0x7304fc31, Offset: 0x112a
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"mp_saw_avalon_bongo_surprise_shipments_cs", undefined, &function_b39ecd3d51489472, undefined );
}

// Namespace mp_saw_avalon_bongo_surprise_shipments_cs
// Params 0, eflags: 0x4
// Checksum 0x918e0c86, Offset: 0x114b
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace mp_saw_avalon_bongo_surprise_shipments_cs
// Params 0, eflags: 0x4
// Checksum 0x14b5df6a, Offset: 0x115c
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace mp_saw_avalon_bongo_surprise_shipments_cs
// Params 2
// Checksum 0xa45c8923, Offset: 0x116d
// Size: 0x80
function main( unused, unused2 )
{
    if ( utility::flag_exist( "mp_saw_avalon_bongo_surprise_shipments_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "mp_saw_avalon_bongo_surprise_shipments_cs" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "mp_saw_avalon_bongo_surprise_shipments_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "mp_saw_avalon_bongo_surprise_shipments_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace mp_saw_avalon_bongo_surprise_shipments_cs
// Params 3, eflags: 0x4
// Checksum 0x97376ba5, Offset: 0x11f5
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "mp_saw_avalon_bongo_surprise_shipments_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "mp_saw_avalon_bongo_surprise_shipments_cs" );
}

// Namespace mp_saw_avalon_bongo_surprise_shipments_cs
// Params 3, eflags: 0x4
// Checksum 0x18597752, Offset: 0x126f
// Size: 0x48e2
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_surprise_shipments_cs";
    s.activity_bundle = "saw_bongo_activity_surprise_shipment";
    s.name = "SURPRISE_SHIPMENT_LOC02";
    fe [[ f ]]( s, us, cf, ( 26627, -14210, 779.72 ), ( 0, 90, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_surprise_shipments_cs";
    s.activity_bundle = "saw_bongo_activity_surprise_shipment";
    s.name = "SURPRISE_SHIPMENT_BASE";
    fe [[ f ]]( s, us, cf, ( -19843.5, -41552.3, 494.24 ), ( 0, 180, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_surprise_shipments_cs";
    s.activity_bundle = "saw_bongo_activity_surprise_shipment";
    s.name = "SURPRISE_SHIPMENT_LOC01";
    fe [[ f ]]( s, us, cf, ( 33173, -11231, 218.72 ), ( 0, 90, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_surprise_shipments_cs";
    s.activity_bundle = "saw_bongo_activity_surprise_shipment";
    s.name = "SURPRISE_SHIPMENT_OVERLOOK";
    fe [[ f ]]( s, us, cf, ( -39329.5, 21944.1, 1232.64 ), ( 0, 80.9, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_surprise_shipments_cs";
    s.activity_bundle = "saw_bongo_activity_surprise_shipment";
    s.name = "SURPRISE_SHIPMENT_MC_BOAT_REFUEL_STATION";
    fe [[ f ]]( s, us, cf, ( 28974, -36702, 401.21 ), ( 0, 90, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_surprise_shipments_cs";
    s.activity_bundle = "saw_bongo_activity_surprise_shipment";
    s.name = "SURPRISE_SHIPMENT_CASINO";
    fe [[ f ]]( s, us, cf, ( -17070, 23568.2, 1745.85 ), ( 0, 350.9, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_surprise_shipments_cs";
    s.activity_bundle = "saw_bongo_activity_surprise_shipment";
    s.name = "SURPRISE_SHIPMENT_CAMPSITE_01";
    fe [[ f ]]( s, us, cf, ( 8117.43, 31417.7, 2478.55 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_surprise_shipments_cs";
    s.activity_bundle = "saw_bongo_activity_surprise_shipment";
    s.name = "SURPRISE_SHIPMENT_WINERY_EAST";
    fe [[ f ]]( s, us, cf, ( 25403.9, 50896.1, 2013.47 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_surprise_shipments_cs";
    s.activity_bundle = "saw_bongo_activity_surprise_shipment";
    s.name = "SURPRISE_SHIPMENT_CLIFFTOWN";
    fe [[ f ]]( s, us, cf, ( 46050.9, 939.86, 1593.7 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_surprise_shipments_cs";
    s.activity_bundle = "saw_bongo_activity_surprise_shipment";
    s.name = "SURPRISE_SHIPMENT_CAR_FACTORY";
    fe [[ f ]]( s, us, cf, ( 53830, -42824, 2179.85 ), ( 0, 90, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_surprise_shipments_cs";
    s.activity_bundle = "saw_bongo_activity_surprise_shipment";
    s.name = "SURPRISE_SHIPMENT_CAR_FACTORY_NORTH";
    fe [[ f ]]( s, us, cf, ( 51068, -31679, 2239.41 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_surprise_shipments_cs";
    s.activity_bundle = "saw_bongo_activity_surprise_shipment";
    s.name = "SURPRISE_SHIPMENT_ROUNDABOUT";
    fe [[ f ]]( s, us, cf, ( -3920.4, 45964, 833 ), ( 0, 350.9, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_surprise_shipments_cs";
    s.activity_bundle = "saw_bongo_activity_surprise_shipment";
    s.name = "SURPRISE_SHIPMENT_CHOP_SHOP";
    fe [[ f ]]( s, us, cf, ( 10107, -49367, 1325.04 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_surprise_shipments_cs";
    s.activity_bundle = "saw_bongo_activity_surprise_shipment";
    s.name = "SURPRISE_SHIPMENT_CITY";
    fe [[ f ]]( s, us, cf, ( -22553.4, 10020.9, 1380.13 ), ( 0, 80.9, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_surprise_shipments_cs";
    s.activity_bundle = "saw_bongo_activity_surprise_shipment";
    s.name = "SURPRISE_SHIPMENT_DIGSITE_01";
    fe [[ f ]]( s, us, cf, ( 34316.7, 38969.5, 3010.07 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_surprise_shipments_cs";
    s.activity_bundle = "saw_bongo_activity_surprise_shipment";
    s.name = "SURPRISE_SHIPMENT_COLOSSEUM_EAST";
    fe [[ f ]]( s, us, cf, ( 50781.7, 29485.6, 1167.98 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_surprise_shipments_cs";
    s.activity_bundle = "saw_bongo_activity_surprise_shipment";
    s.name = "SURPRISE_SHIPMENT_MTN_TOWN_01";
    fe [[ f ]]( s, us, cf, ( 23167.5, 28608.8, 2661.88 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_surprise_shipments_cs";
    s.activity_bundle = "saw_bongo_activity_surprise_shipment";
    s.name = "SURPRISE_SHIPMENT_MANSIONS";
    fe [[ f ]]( s, us, cf, ( -55029.4, 3048.26, 481.43 ), ( 0, 350.9, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_surprise_shipments_cs";
    s.activity_bundle = "saw_bongo_activity_surprise_shipment";
    s.name = "SURPRISE_SHIPMENT_COLOSSEUM_SOUTH";
    fe [[ f ]]( s, us, cf, ( 43949.1, 18381.6, 372.94 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_surprise_shipments_cs";
    s.activity_bundle = "saw_bongo_activity_surprise_shipment";
    s.name = "SURPRISE_SHIPMENT_PARK";
    fe [[ f ]]( s, us, cf, ( -19313, 30690.5, 2419.81 ), ( 0, 350.9, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_surprise_shipments_cs";
    s.activity_bundle = "saw_bongo_activity_surprise_shipment";
    s.name = "SURPRISE_SHIPMENT_WINERY_WEST";
    fe [[ f ]]( s, us, cf, ( 11091, 51738.6, 756.51 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_surprise_shipments_cs";
    s.activity_bundle = "saw_bongo_activity_surprise_shipment";
    s.name = "SURPRISE_SHIPMENT_FORT_STORAGE";
    fe [[ f ]]( s, us, cf, ( -38945.2, -35921.4, 1132.36 ), ( 0, 270, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_surprise_shipments_cs";
    s.activity_bundle = "saw_bongo_activity_surprise_shipment";
    s.name = "SURPRISE_SHIPMENT_GAS_STATION_NORTH";
    fe [[ f ]]( s, us, cf, ( 9325, -10021, 2116.94 ), ( 0, 90, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_surprise_shipments_cs";
    s.activity_bundle = "saw_bongo_activity_surprise_shipment";
    s.name = "SURPRISE_SHIPMENT_PARKING_LOT";
    fe [[ f ]]( s, us, cf, ( -21949.8, -32310.4, 585.08 ), ( 0, 90, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_surprise_shipments_cs";
    s.activity_bundle = "saw_bongo_activity_surprise_shipment";
    s.name = "SURPRISE_SHIPMENT_SAM_SITE";
    fe [[ f ]]( s, us, cf, ( -31047.4, -19820, 359.12 ), ( 0, 270, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_surprise_shipments_cs";
    s.activity_bundle = "saw_bongo_activity_surprise_shipment";
    s.name = "SURPRISE_SHIPMENT_SC_BRIDGE_BUILDINGS";
    fe [[ f ]]( s, us, cf, ( 19158, -37884, 571.99 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_surprise_shipments_cs";
    s.activity_bundle = "saw_bongo_activity_surprise_shipment";
    s.name = "SURPRISE_SHIPMENT_SHIPYARD_GROUND";
    fe [[ f ]]( s, us, cf, ( 33821, -49299, 320.11 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_surprise_shipments_cs";
    s.activity_bundle = "saw_bongo_activity_surprise_shipment";
    s.name = "SURPRISE_SHIPMENT_SUBDIVISION";
    fe [[ f ]]( s, us, cf, ( -7507.33, 39724.7, 447.56 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_surprise_shipments_cs";
    s.activity_bundle = "saw_bongo_activity_surprise_shipment";
    s.name = "SURPRISE_SHIPMENT_VIGNETTE_SHEDS";
    fe [[ f ]]( s, us, cf, ( 52608, -53291, 993.09 ), ( 0, 90, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_surprise_shipments_cs";
    s.activity_bundle = "saw_bongo_activity_surprise_shipment";
    s.name = "SURPRISE_SHIPMENT_WATER_TREATMENT";
    fe [[ f ]]( s, us, cf, ( 44800, -16852, 779.72 ), ( 0, 90, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_surprise_shipments_cs";
    s.activity_bundle = "saw_bongo_activity_surprise_shipment";
    s.name = "SURPRISE_SHIPMENT_LOC03";
    fe [[ f ]]( s, us, cf, ( 30805, -23616, 470.72 ), ( 0, 90, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_surprise_shipments_cs";
    s.is_cs_scriptable = 1;
    s.var_f480445067531e7b = "state:";
    s.model = "sat_storage_guild_large_shipping_container_closed_01";
    s.name = "SURPRISE_SHIPMENT_OVERLOOK_container";
    s.var_4bdd7a94c9bc3392 = "high";
    s.var_8ef9cdfc2a34bab3 = "1";
    fe [[ f ]]( s, us, cf, ( -39328.1, 21945, 1104.46 ), ( 0, 112.02, 0 ), "SURPRISE_SHIPMENT_OVERLOOK_container", undefined, "sat_ob_surprise_shipping_container", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 2000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_surprise_shipments_cs";
    s.is_cs_scriptable = 1;
    s.var_f480445067531e7b = "state:";
    s.model = "sat_storage_guild_large_shipping_container_closed_01";
    s.name = "SURPRISE_SHIPMENT_WINERY_WEST_container";
    s.var_4bdd7a94c9bc3392 = "high";
    s.var_8ef9cdfc2a34bab3 = "1";
    fe [[ f ]]( s, us, cf, ( 11092.2, 51737.6, 632.5 ), ( 0, 344.6, 0 ), "SURPRISE_SHIPMENT_WINERY_WEST_container", undefined, "sat_ob_surprise_shipping_container", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 2000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_surprise_shipments_cs";
    s.is_cs_scriptable = 1;
    s.var_f480445067531e7b = "state:";
    s.model = "sat_storage_guild_large_shipping_container_closed_01";
    s.name = "SURPRISE_SHIPMENT_SAM_SITE_container";
    s.var_4bdd7a94c9bc3392 = "high";
    s.var_8ef9cdfc2a34bab3 = "1";
    fe [[ f ]]( s, us, cf, ( -31048.8, -19820, 234.25 ), ( 359.44, 270.51, -0.13 ), "SURPRISE_SHIPMENT_SAM_SITE_container", undefined, "sat_ob_surprise_shipping_container", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 2000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_surprise_shipments_cs";
    s.is_cs_scriptable = 1;
    s.var_f480445067531e7b = "state:";
    s.model = "sat_storage_guild_large_shipping_container_closed_01";
    s.name = "SURPRISE_SHIPMENT_MC_BOAT_REFUEL_STATION_container";
    s.var_4bdd7a94c9bc3392 = "high";
    s.var_8ef9cdfc2a34bab3 = "1";
    fe [[ f ]]( s, us, cf, ( 28974, -36701, 242 ), ( 0, 180.3, 0 ), "SURPRISE_SHIPMENT_MC_BOAT_REFUEL_STATION_container", undefined, "sat_ob_surprise_shipping_container", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 2000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_surprise_shipments_cs";
    s.is_cs_scriptable = 1;
    s.var_f480445067531e7b = "state:";
    s.model = "sat_storage_guild_large_shipping_container_closed_01";
    s.name = "SURPRISE_SHIPMENT_ROUNDABOUT_container";
    s.var_4bdd7a94c9bc3392 = "high";
    s.var_8ef9cdfc2a34bab3 = "1";
    fe [[ f ]]( s, us, cf, ( -3923.4, 45963.8, 290.84 ), ( 0, 173.25, 0 ), "SURPRISE_SHIPMENT_ROUNDABOUT_container", undefined, "sat_ob_surprise_shipping_container", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 2000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_surprise_shipments_cs";
    s.is_cs_scriptable = 1;
    s.var_f480445067531e7b = "state:";
    s.model = "sat_storage_guild_large_shipping_container_closed_01";
    s.name = "SURPRISE_SHIPMENT_CITY_container";
    s.var_4bdd7a94c9bc3392 = "high";
    s.var_8ef9cdfc2a34bab3 = "1";
    fe [[ f ]]( s, us, cf, ( -22564, 10020.8, 1239.01 ), ( 358.15, 228.81, -1.39 ), "SURPRISE_SHIPMENT_CITY_container", undefined, "sat_ob_surprise_shipping_container", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 2000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_surprise_shipments_cs";
    s.is_cs_scriptable = 1;
    s.var_f480445067531e7b = "state:";
    s.model = "sat_storage_guild_large_shipping_container_closed_01";
    s.name = "SURPRISE_SHIPMENT_CASINO_container";
    s.var_4bdd7a94c9bc3392 = "high";
    s.var_8ef9cdfc2a34bab3 = "1";
    fe [[ f ]]( s, us, cf, ( -17069.5, 23575.6, 1622.68 ), ( 0.01, 217.34, 0.51 ), "SURPRISE_SHIPMENT_CASINO_container", undefined, "sat_ob_surprise_shipping_container", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 2000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_surprise_shipments_cs";
    s.is_cs_scriptable = 1;
    s.var_f480445067531e7b = "state:";
    s.model = "sat_storage_guild_large_shipping_container_closed_01";
    s.name = "SURPRISE_SHIPMENT_PARK_container";
    s.var_4bdd7a94c9bc3392 = "high";
    s.var_8ef9cdfc2a34bab3 = "1";
    fe [[ f ]]( s, us, cf, ( -19312.3, 30687.7, 2291.46 ), ( 358.28, 142.47, 0.15 ), "SURPRISE_SHIPMENT_PARK_container", undefined, "sat_ob_surprise_shipping_container", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 2000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_surprise_shipments_cs";
    s.is_cs_scriptable = 1;
    s.var_f480445067531e7b = "state:";
    s.model = "sat_storage_guild_large_shipping_container_closed_01";
    s.name = "SURPRISE_SHIPMENT_LOC01_container";
    s.var_4bdd7a94c9bc3392 = "high";
    s.var_8ef9cdfc2a34bab3 = "1";
    fe [[ f ]]( s, us, cf, ( 33093.6, -11080.5, 191.07 ), ( 360, 360, 0 ), "SURPRISE_SHIPMENT_LOC01_container", undefined, "sat_ob_surprise_shipping_container", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 2000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_surprise_shipments_cs";
    s.is_cs_scriptable = 1;
    s.var_f480445067531e7b = "state:";
    s.model = "sat_storage_guild_large_shipping_container_closed_01";
    s.name = "SURPRISE_SHIPMENT_SUBDIVISION_container";
    s.var_4bdd7a94c9bc3392 = "high";
    s.var_8ef9cdfc2a34bab3 = "1";
    fe [[ f ]]( s, us, cf, ( -7506.5, 39720.6, 300.16 ), ( 0.67, 45.56, -1.5 ), "SURPRISE_SHIPMENT_SUBDIVISION_container", undefined, "sat_ob_surprise_shipping_container", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 2000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_surprise_shipments_cs";
    s.is_cs_scriptable = 1;
    s.var_f480445067531e7b = "state:";
    s.model = "sat_storage_guild_large_shipping_container_closed_01";
    s.name = "SURPRISE_SHIPMENT_MANSIONS_container";
    s.var_4bdd7a94c9bc3392 = "high";
    s.var_8ef9cdfc2a34bab3 = "1";
    fe [[ f ]]( s, us, cf, ( -55027.5, 3047.66, 357.59 ), ( 359.32, 77.6, -0.74 ), "SURPRISE_SHIPMENT_MANSIONS_container", undefined, "sat_ob_surprise_shipping_container", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 2000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_surprise_shipments_cs";
    s.is_cs_scriptable = 1;
    s.var_f480445067531e7b = "state:";
    s.model = "sat_storage_guild_large_shipping_container_closed_01";
    s.name = "SURPRISE_SHIPMENT_LOC02_container";
    s.var_4bdd7a94c9bc3392 = "high";
    s.var_8ef9cdfc2a34bab3 = "1";
    fe [[ f ]]( s, us, cf, ( 26770.5, -14210.6, 296 ), ( 0, 230.6, 0 ), "SURPRISE_SHIPMENT_LOC02_container", undefined, "sat_ob_surprise_shipping_container", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 2000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_surprise_shipments_cs";
    s.is_cs_scriptable = 1;
    s.var_f480445067531e7b = "state:";
    s.model = "sat_storage_guild_large_shipping_container_closed_01";
    s.name = "SURPRISE_SHIPMENT_DIGSITE_01_container";
    s.var_4bdd7a94c9bc3392 = "high";
    s.var_8ef9cdfc2a34bab3 = "1";
    fe [[ f ]]( s, us, cf, ( 34315.8, 38964, 2879.97 ), ( 3.8, 74.6, -0 ), "SURPRISE_SHIPMENT_DIGSITE_01_container", undefined, "sat_ob_surprise_shipping_container", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 2000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_surprise_shipments_cs";
    s.is_cs_scriptable = 1;
    s.var_f480445067531e7b = "state:";
    s.model = "sat_storage_guild_large_shipping_container_closed_01";
    s.name = "SURPRISE_SHIPMENT_CAMPSITE_01_container";
    s.var_4bdd7a94c9bc3392 = "high";
    s.var_8ef9cdfc2a34bab3 = "1";
    fe [[ f ]]( s, us, cf, ( 8124.72, 31413.7, 2351.58 ), ( 0, 140.5, -0 ), "SURPRISE_SHIPMENT_CAMPSITE_01_container", undefined, "sat_ob_surprise_shipping_container", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 2000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_surprise_shipments_cs";
    s.is_cs_scriptable = 1;
    s.var_f480445067531e7b = "state:";
    s.model = "sat_storage_guild_large_shipping_container_closed_01";
    s.name = "SURPRISE_SHIPMENT_MTN_TOWN_01_container";
    s.var_4bdd7a94c9bc3392 = "high";
    s.var_8ef9cdfc2a34bab3 = "1";
    fe [[ f ]]( s, us, cf, ( 23172.2, 28615.7, 2529.21 ), ( 1.2, 305.59, 4.3 ), "SURPRISE_SHIPMENT_MTN_TOWN_01_container", undefined, "sat_ob_surprise_shipping_container", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 2000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_surprise_shipments_cs";
    s.is_cs_scriptable = 1;
    s.var_f480445067531e7b = "state:";
    s.model = "sat_storage_guild_large_shipping_container_closed_01";
    s.name = "SURPRISE_SHIPMENT_COLOSSEUM_EAST_container";
    s.var_4bdd7a94c9bc3392 = "high";
    s.var_8ef9cdfc2a34bab3 = "1";
    fe [[ f ]]( s, us, cf, ( 50780, 29483, 1039 ), ( 0, 268.7, 0 ), "SURPRISE_SHIPMENT_COLOSSEUM_EAST_container", undefined, "sat_ob_surprise_shipping_container", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 2000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_surprise_shipments_cs";
    s.is_cs_scriptable = 1;
    s.var_f480445067531e7b = "state:";
    s.model = "sat_storage_guild_large_shipping_container_closed_01";
    s.name = "SURPRISE_SHIPMENT_COLOSSEUM_SOUTH_container";
    s.var_4bdd7a94c9bc3392 = "high";
    s.var_8ef9cdfc2a34bab3 = "1";
    fe [[ f ]]( s, us, cf, ( 43951.3, 18378.8, 247.79 ), ( 3, 137.57, -2.93 ), "SURPRISE_SHIPMENT_COLOSSEUM_SOUTH_container", undefined, "sat_ob_surprise_shipping_container", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 2000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_surprise_shipments_cs";
    s.is_cs_scriptable = 1;
    s.var_f480445067531e7b = "state:";
    s.model = "sat_storage_guild_large_shipping_container_closed_01";
    s.name = "SURPRISE_SHIPMENT_CLIFFTOWN_container";
    s.var_4bdd7a94c9bc3392 = "high";
    s.var_8ef9cdfc2a34bab3 = "1";
    fe [[ f ]]( s, us, cf, ( 46050.3, 938.49, 1464.14 ), ( 359.92, 116, 0.17 ), "SURPRISE_SHIPMENT_CLIFFTOWN_container", undefined, "sat_ob_surprise_shipping_container", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 2000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_surprise_shipments_cs";
    s.is_cs_scriptable = 1;
    s.var_f480445067531e7b = "state:";
    s.model = "sat_storage_guild_large_shipping_container_closed_01";
    s.name = "SURPRISE_SHIPMENT_WINERY_EAST_container";
    s.var_4bdd7a94c9bc3392 = "high";
    s.var_8ef9cdfc2a34bab3 = "1";
    fe [[ f ]]( s, us, cf, ( 25402.9, 50887.8, 1883 ), ( 0, 90.6, 0.6 ), "SURPRISE_SHIPMENT_WINERY_EAST_container", undefined, "sat_ob_surprise_shipping_container", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 2000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_surprise_shipments_cs";
    s.is_cs_scriptable = 1;
    s.var_f480445067531e7b = "state:";
    s.model = "sat_storage_guild_large_shipping_container_closed_01";
    s.name = "SURPRISE_SHIPMENT_BASE_container";
    s.var_4bdd7a94c9bc3392 = "high";
    s.var_8ef9cdfc2a34bab3 = "1";
    fe [[ f ]]( s, us, cf, ( -19859.9, -41558.1, 349.18 ), ( 0, 104.59, 0 ), "SURPRISE_SHIPMENT_BASE_container", undefined, "sat_ob_surprise_shipping_container", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 2000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_surprise_shipments_cs";
    s.is_cs_scriptable = 1;
    s.var_f480445067531e7b = "state:";
    s.model = "sat_storage_guild_large_shipping_container_closed_01";
    s.name = "SURPRISE_SHIPMENT_PARKING_LOT_container";
    s.var_4bdd7a94c9bc3392 = "high";
    s.var_8ef9cdfc2a34bab3 = "1";
    fe [[ f ]]( s, us, cf, ( -21950.7, -32311.6, 429.87 ), ( 0, 4.6, 0 ), "SURPRISE_SHIPMENT_PARKING_LOT_container", undefined, "sat_ob_surprise_shipping_container", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 2000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_surprise_shipments_cs";
    s.is_cs_scriptable = 1;
    s.var_f480445067531e7b = "state:";
    s.model = "sat_storage_guild_large_shipping_container_closed_01";
    s.name = "SURPRISE_SHIPMENT_LOC03_container";
    s.var_4bdd7a94c9bc3392 = "high";
    s.var_8ef9cdfc2a34bab3 = "1";
    fe [[ f ]]( s, us, cf, ( 30783.4, -23646.5, 239.22 ), ( 0, 144.8, 0 ), "SURPRISE_SHIPMENT_LOC03_container", undefined, "sat_ob_surprise_shipping_container", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 2000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_surprise_shipments_cs";
    s.is_cs_scriptable = 1;
    s.var_f480445067531e7b = "state:";
    s.model = "sat_storage_guild_large_shipping_container_closed_01";
    s.name = "SURPRISE_SHIPMENT_FORT_STORAGE_container";
    s.var_4bdd7a94c9bc3392 = "high";
    s.var_8ef9cdfc2a34bab3 = "1";
    fe [[ f ]]( s, us, cf, ( -38935.9, -35918.1, 1018.19 ), ( 0, 270, 0 ), "SURPRISE_SHIPMENT_FORT_STORAGE_container", undefined, "sat_ob_surprise_shipping_container", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 2000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_surprise_shipments_cs";
    s.is_cs_scriptable = 1;
    s.var_f480445067531e7b = "state:";
    s.model = "sat_storage_guild_large_shipping_container_closed_01";
    s.name = "SURPRISE_SHIPMENT_SC_BRIDGE_BUILDINGS_container";
    s.var_4bdd7a94c9bc3392 = "high";
    s.var_8ef9cdfc2a34bab3 = "1";
    fe [[ f ]]( s, us, cf, ( 19160, -37885, 448.99 ), ( 0, 0.5, -0 ), "SURPRISE_SHIPMENT_SC_BRIDGE_BUILDINGS_container", undefined, "sat_ob_surprise_shipping_container", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 2000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_surprise_shipments_cs";
    s.is_cs_scriptable = 1;
    s.var_f480445067531e7b = "state:";
    s.model = "sat_storage_guild_large_shipping_container_closed_01";
    s.name = "SURPRISE_SHIPMENT_VIGNETTE_SHEDS_container";
    s.var_4bdd7a94c9bc3392 = "high";
    s.var_8ef9cdfc2a34bab3 = "1";
    fe [[ f ]]( s, us, cf, ( 52606.6, -53284.6, 860.69 ), ( 359.86, 212.1, -2.32 ), "SURPRISE_SHIPMENT_VIGNETTE_SHEDS_container", undefined, "sat_ob_surprise_shipping_container", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 2000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_surprise_shipments_cs";
    s.is_cs_scriptable = 1;
    s.var_f480445067531e7b = "state:";
    s.model = "sat_storage_guild_large_shipping_container_closed_01";
    s.name = "SURPRISE_SHIPMENT_CAR_FACTORY_container";
    s.var_4bdd7a94c9bc3392 = "high";
    s.var_8ef9cdfc2a34bab3 = "1";
    fe [[ f ]]( s, us, cf, ( 53833.3, -42820.1, 2052.85 ), ( 0, 0.09, 0 ), "SURPRISE_SHIPMENT_CAR_FACTORY_container", undefined, "sat_ob_surprise_shipping_container", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 2000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_surprise_shipments_cs";
    s.is_cs_scriptable = 1;
    s.var_f480445067531e7b = "state:";
    s.model = "sat_storage_guild_large_shipping_container_closed_01";
    s.name = "SURPRISE_SHIPMENT_CHOP_SHOP_container";
    s.var_4bdd7a94c9bc3392 = "high";
    s.var_8ef9cdfc2a34bab3 = "1";
    fe [[ f ]]( s, us, cf, ( 10105, -49367, 1193.2 ), ( 1, 29.6, -0.01 ), "SURPRISE_SHIPMENT_CHOP_SHOP_container", undefined, "sat_ob_surprise_shipping_container", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 2000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_surprise_shipments_cs";
    s.is_cs_scriptable = 1;
    s.var_f480445067531e7b = "state:";
    s.model = "sat_storage_guild_large_shipping_container_closed_01";
    s.name = "SURPRISE_SHIPMENT_SHIPYARD_GROUND_container";
    s.var_4bdd7a94c9bc3392 = "high";
    s.var_8ef9cdfc2a34bab3 = "1";
    fe [[ f ]]( s, us, cf, ( 33821.9, -49301.5, 208.18 ), ( 360, 77.96, -0 ), "SURPRISE_SHIPMENT_SHIPYARD_GROUND_container", undefined, "sat_ob_surprise_shipping_container", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 2000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_surprise_shipments_cs";
    s.is_cs_scriptable = 1;
    s.var_f480445067531e7b = "state:";
    s.model = "sat_storage_guild_large_shipping_container_closed_01";
    s.name = "SURPRISE_SHIPMENT_CAR_FACTORY_NORTH_container";
    s.var_4bdd7a94c9bc3392 = "high";
    s.var_8ef9cdfc2a34bab3 = "1";
    fe [[ f ]]( s, us, cf, ( 51074.3, -31679.3, 2108.26 ), ( 0, 272.02, 0 ), "SURPRISE_SHIPMENT_CAR_FACTORY_NORTH_container", undefined, "sat_ob_surprise_shipping_container", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 2000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_surprise_shipments_cs";
    s.is_cs_scriptable = 1;
    s.var_f480445067531e7b = "state:";
    s.model = "sat_storage_guild_large_shipping_container_closed_01";
    s.name = "SURPRISE_SHIPMENT_WATER_TREATMENT_container";
    s.var_4bdd7a94c9bc3392 = "high";
    s.var_8ef9cdfc2a34bab3 = "1";
    fe [[ f ]]( s, us, cf, ( 44794, -16848.3, 644.99 ), ( 356.22, 210.65, -1.22 ), "SURPRISE_SHIPMENT_WATER_TREATMENT_container", undefined, "sat_ob_surprise_shipping_container", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 2000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_surprise_shipments_cs";
    s.is_cs_scriptable = 1;
    s.var_f480445067531e7b = "state:";
    s.model = "sat_storage_guild_large_shipping_container_closed_01";
    s.name = "SURPRISE_SHIPMENT_GAS_STATION_NORTH_container";
    s.var_4bdd7a94c9bc3392 = "high";
    s.var_8ef9cdfc2a34bab3 = "1";
    fe [[ f ]]( s, us, cf, ( 9323.84, -10020.9, 1956.53 ), ( 0.18, 152.12, 0.64 ), "SURPRISE_SHIPMENT_GAS_STATION_NORTH_container", undefined, "sat_ob_surprise_shipping_container", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 2000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_surprise_shipments_cs";
    s.activity_bundle = "saw_bongo_activity_surprise_shipment";
    s.name = "SURPRISE_SHIPMENT_LOC04";
    fe [[ f ]]( s, us, cf, ( 23236, -20599, 543.2 ), ( 0, 199.79, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_surprise_shipments_cs";
    s.is_cs_scriptable = 1;
    s.var_f480445067531e7b = "state:";
    s.model = "sat_storage_guild_large_shipping_container_closed_01";
    s.name = "SURPRISE_SHIPMENT_LOC04_container";
    s.var_4bdd7a94c9bc3392 = "high";
    s.var_8ef9cdfc2a34bab3 = "1";
    fe [[ f ]]( s, us, cf, ( 23235.8, -20599, 365.88 ), ( 0, 254.59, 0 ), "SURPRISE_SHIPMENT_LOC04_container", undefined, "sat_ob_surprise_shipping_container", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 2000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_surprise_shipments_cs";
    s.activity_bundle = "saw_bongo_activity_surprise_shipment";
    s.name = "SURPRISE_SHIPMENT_LOC05";
    fe [[ f ]]( s, us, cf, ( 16570, -7717, 3550 ), ( 0, 270, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_surprise_shipments_cs";
    s.is_cs_scriptable = 1;
    s.var_f480445067531e7b = "state:";
    s.model = "sat_storage_guild_large_shipping_container_closed_01";
    s.name = "SURPRISE_SHIPMENT_LOC05_container";
    s.var_4bdd7a94c9bc3392 = "high";
    s.var_8ef9cdfc2a34bab3 = "1";
    fe [[ f ]]( s, us, cf, ( 16591.6, -7686.5, 3410 ), ( 0, 324.8, 0 ), "SURPRISE_SHIPMENT_LOC05_container", undefined, "sat_ob_surprise_shipping_container", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 2000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_surprise_shipments_cs";
    s.activity_bundle = "saw_bongo_activity_surprise_shipment";
    s.name = "SURPRISE_SHIPMENT_LOC06";
    fe [[ f ]]( s, us, cf, ( 29757.4, -2941.35, 434.14 ), ( 357.39, 119.18, -1.86 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_surprise_shipments_cs";
    s.is_cs_scriptable = 1;
    s.var_f480445067531e7b = "state:";
    s.model = "sat_storage_guild_large_shipping_container_closed_01";
    s.name = "SURPRISE_SHIPMENT_LOC06_container";
    s.var_4bdd7a94c9bc3392 = "high";
    s.var_8ef9cdfc2a34bab3 = "1";
    fe [[ f ]]( s, us, cf, ( 29754.4, -2971.5, 305.05 ), ( 0.05, 173.9, -3.2 ), "SURPRISE_SHIPMENT_LOC06_container", undefined, "sat_ob_surprise_shipping_container", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 2000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_surprise_shipments_cs";
    s.activity_bundle = "saw_bongo_activity_surprise_shipment";
    s.name = "SURPRISE_SHIPMENT_LOC07";
    fe [[ f ]]( s, us, cf, ( 28347.9, 10425.8, 160.97 ), ( 0, 206.76, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_surprise_shipments_cs";
    s.is_cs_scriptable = 1;
    s.var_f480445067531e7b = "state:";
    s.model = "sat_storage_guild_large_shipping_container_closed_01";
    s.name = "SURPRISE_SHIPMENT_LOC07_container";
    s.var_4bdd7a94c9bc3392 = "high";
    s.var_8ef9cdfc2a34bab3 = "1";
    fe [[ f ]]( s, us, cf, ( 28386.9, 10407.9, 31.97 ), ( 0, 265.6, 0 ), "SURPRISE_SHIPMENT_LOC07_container", undefined, "sat_ob_surprise_shipping_container", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 2000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_surprise_shipments_cs";
    s.activity_bundle = "saw_bongo_activity_surprise_shipment";
    s.name = "SURPRISE_SHIPMENT_LOC08";
    fe [[ f ]]( s, us, cf, ( 21954.2, 16923.2, 471.04 ), ( 0.17, 217.46, -0.17 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_surprise_shipments_cs";
    s.is_cs_scriptable = 1;
    s.var_f480445067531e7b = "state:";
    s.model = "sat_storage_guild_large_shipping_container_closed_01";
    s.name = "SURPRISE_SHIPMENT_LOC08_container";
    s.var_4bdd7a94c9bc3392 = "high";
    s.var_8ef9cdfc2a34bab3 = "1";
    fe [[ f ]]( s, us, cf, ( 21995.9, 16912.9, 346.02 ), ( 0.19, 276.3, 0.03 ), "SURPRISE_SHIPMENT_LOC08_container", undefined, "sat_ob_surprise_shipping_container", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 2000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_surprise_shipments_cs";
    s.activity_bundle = "saw_bongo_activity_surprise_shipment";
    s.name = "SURPRISE_SHIPMENT_LOC09";
    fe [[ f ]]( s, us, cf, ( 10938.2, 24338.2, 719 ), ( 0, 217.46, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_surprise_shipments_cs";
    s.is_cs_scriptable = 1;
    s.var_f480445067531e7b = "state:";
    s.model = "sat_storage_guild_large_shipping_container_closed_01";
    s.name = "SURPRISE_SHIPMENT_LOC09_container";
    s.var_4bdd7a94c9bc3392 = "high";
    s.var_8ef9cdfc2a34bab3 = "1";
    fe [[ f ]]( s, us, cf, ( 10979.9, 24327.9, 576 ), ( 0, 276.3, -0 ), "SURPRISE_SHIPMENT_LOC09_container", undefined, "sat_ob_surprise_shipping_container", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 2000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_surprise_shipments_cs";
    s.activity_bundle = "saw_bongo_activity_surprise_shipment";
    s.name = "SURPRISE_SHIPMENT_LOC10";
    fe [[ f ]]( s, us, cf, ( -4627.8, 23325.2, 703.52 ), ( 355.41, 217.46, 0.01 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_surprise_shipments_cs";
    s.is_cs_scriptable = 1;
    s.var_f480445067531e7b = "state:";
    s.model = "sat_storage_guild_large_shipping_container_closed_01";
    s.name = "SURPRISE_SHIPMENT_LOC10_container";
    s.var_4bdd7a94c9bc3392 = "high";
    s.var_8ef9cdfc2a34bab3 = "1";
    fe [[ f ]]( s, us, cf, ( -4595.1, 23307.9, 563.7 ), ( 358.7, 276.37, -3.14 ), "SURPRISE_SHIPMENT_LOC10_container", undefined, "sat_ob_surprise_shipping_container", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 2000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_surprise_shipments_cs";
    s.activity_bundle = "saw_bongo_activity_surprise_shipment";
    s.name = "SURPRISE_SHIPMENT_LOC11";
    fe [[ f ]]( s, us, cf, ( 11252.8, 11652.8, 231.79 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_surprise_shipments_cs";
    s.is_cs_scriptable = 1;
    s.var_f480445067531e7b = "state:";
    s.model = "sat_storage_guild_large_shipping_container_closed_01";
    s.name = "SURPRISE_SHIPMENT_LOC11_container";
    s.var_4bdd7a94c9bc3392 = "high";
    s.var_8ef9cdfc2a34bab3 = "1";
    fe [[ f ]]( s, us, cf, ( 11289.9, 11645.9, 98 ), ( 0, 252.87, 0 ), "SURPRISE_SHIPMENT_LOC11_container", undefined, "sat_ob_surprise_shipping_container", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 2000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_surprise_shipments_cs";
    s.activity_bundle = "saw_bongo_activity_surprise_shipment";
    s.name = "SURPRISE_SHIPMENT_LOC12";
    fe [[ f ]]( s, us, cf, ( -183.2, 10104.8, 150 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_surprise_shipments_cs";
    s.is_cs_scriptable = 1;
    s.var_f480445067531e7b = "state:";
    s.model = "sat_storage_guild_large_shipping_container_closed_01";
    s.name = "SURPRISE_SHIPMENT_LOC12_container";
    s.var_4bdd7a94c9bc3392 = "high";
    s.var_8ef9cdfc2a34bab3 = "1";
    fe [[ f ]]( s, us, cf, ( -146.1, 10097.9, 24 ), ( 0, 252.87, 0 ), "SURPRISE_SHIPMENT_LOC12_container", undefined, "sat_ob_surprise_shipping_container", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 2000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_surprise_shipments_cs";
    s.activity_bundle = "saw_bongo_activity_surprise_shipment";
    s.name = "SURPRISE_SHIPMENT_LOC13";
    fe [[ f ]]( s, us, cf, ( -3455.21, -8879.48, 930.19 ), ( 359.05, 292.81, -0.31 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_surprise_shipments_cs";
    s.is_cs_scriptable = 1;
    s.var_f480445067531e7b = "state:";
    s.model = "sat_storage_guild_large_shipping_container_closed_01";
    s.name = "SURPRISE_SHIPMENT_LOC13_container";
    s.var_4bdd7a94c9bc3392 = "high";
    s.var_8ef9cdfc2a34bab3 = "1";
    fe [[ f ]]( s, us, cf, ( -3446.1, -8918.1, 803.85 ), ( 359.96, 187.5, 1.04 ), "SURPRISE_SHIPMENT_LOC13_container", undefined, "sat_ob_surprise_shipping_container", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 2000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_surprise_shipments_cs";
    s.activity_bundle = "saw_bongo_activity_surprise_shipment";
    s.name = "SURPRISE_SHIPMENT_LOC14";
    fe [[ f ]]( s, us, cf, ( 6721.33, -19725.6, 1111.04 ), ( 359.15, 267.46, -0.94 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_surprise_shipments_cs";
    s.is_cs_scriptable = 1;
    s.var_f480445067531e7b = "state:";
    s.model = "sat_storage_guild_large_shipping_container_closed_01";
    s.name = "SURPRISE_SHIPMENT_LOC14_container";
    s.var_4bdd7a94c9bc3392 = "high";
    s.var_8ef9cdfc2a34bab3 = "1";
    fe [[ f ]]( s, us, cf, ( 6705.84, -19746.9, 986.33 ), ( 357.86, 161.79, -0.44 ), "SURPRISE_SHIPMENT_LOC14_container", undefined, "sat_ob_surprise_shipping_container", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 2000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_surprise_shipments_cs";
    s.activity_bundle = "saw_bongo_activity_surprise_shipment";
    s.name = "SURPRISE_SHIPMENT_LOC15";
    fe [[ f ]]( s, us, cf, ( 12535.6, -31352.4, 4180 ), ( 0, 337.02, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_surprise_shipments_cs";
    s.is_cs_scriptable = 1;
    s.var_f480445067531e7b = "state:";
    s.model = "sat_storage_guild_large_shipping_container_closed_01";
    s.name = "SURPRISE_SHIPMENT_LOC15_container";
    s.var_4bdd7a94c9bc3392 = "high";
    s.var_8ef9cdfc2a34bab3 = "1";
    fe [[ f ]]( s, us, cf, ( 12550.9, -31373.1, 4040 ), ( 0, 231.25, 0 ), "SURPRISE_SHIPMENT_LOC15_container", undefined, "sat_ob_surprise_shipping_container", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 2000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_surprise_shipments_cs";
    s.activity_bundle = "saw_bongo_activity_surprise_shipment";
    s.name = "SURPRISE_SHIPMENT_LOC17";
    fe [[ f ]]( s, us, cf, ( 4155.21, -27791.8, 1526.98 ), ( 0.01, 354.02, -0.06 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_surprise_shipments_cs";
    s.is_cs_scriptable = 1;
    s.var_f480445067531e7b = "state:";
    s.model = "sat_storage_guild_large_shipping_container_closed_01";
    s.name = "SURPRISE_SHIPMENT_LOC17_container";
    s.var_4bdd7a94c9bc3392 = "high";
    s.var_8ef9cdfc2a34bab3 = "1";
    fe [[ f ]]( s, us, cf, ( 4175.9, -27807.1, 1384.96 ), ( 359.99, 248.25, -0.01 ), "SURPRISE_SHIPMENT_LOC17_container", undefined, "sat_ob_surprise_shipping_container", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 2000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_surprise_shipments_cs";
    s.activity_bundle = "saw_bongo_activity_surprise_shipment";
    s.name = "SURPRISE_SHIPMENT_LOC18";
    fe [[ f ]]( s, us, cf, ( -13728.9, -43462.8, 652.83 ), ( 0.64, 45.59, -1.9 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_surprise_shipments_cs";
    s.is_cs_scriptable = 1;
    s.var_f480445067531e7b = "state:";
    s.model = "sat_storage_guild_large_shipping_container_closed_01";
    s.name = "SURPRISE_SHIPMENT_LOC18_container";
    s.var_4bdd7a94c9bc3392 = "high";
    s.var_8ef9cdfc2a34bab3 = "1";
    fe [[ f ]]( s, us, cf, ( -13702.1, -43460.1, 514.9 ), ( 360, 299.85, 0 ), "SURPRISE_SHIPMENT_LOC18_container", undefined, "sat_ob_surprise_shipping_container", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 2000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_surprise_shipments_cs";
    s.activity_bundle = "saw_bongo_activity_surprise_shipment";
    s.name = "SURPRISE_SHIPMENT_LOC19";
    fe [[ f ]]( s, us, cf, ( -43711.8, -7652.95, 281.99 ), ( 0, 91.11, -0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_surprise_shipments_cs";
    s.is_cs_scriptable = 1;
    s.var_f480445067531e7b = "state:";
    s.model = "sat_storage_guild_large_shipping_container_closed_01";
    s.name = "SURPRISE_SHIPMENT_LOC19_container";
    s.var_4bdd7a94c9bc3392 = "high";
    s.var_8ef9cdfc2a34bab3 = "1";
    fe [[ f ]]( s, us, cf, ( -43710.1, -7621.1, 127.99 ), ( 360, 343.57, -0 ), "SURPRISE_SHIPMENT_LOC19_container", undefined, "sat_ob_surprise_shipping_container", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 2000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_surprise_shipments_cs";
    s.activity_bundle = "saw_bongo_activity_surprise_shipment";
    s.name = "SURPRISE_SHIPMENT_LOC20";
    fe [[ f ]]( s, us, cf, ( -32825.7, -3000.78, 593.86 ), ( 2.09, 37.72, 2.93 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_surprise_shipments_cs";
    s.is_cs_scriptable = 1;
    s.var_f480445067531e7b = "state:";
    s.model = "sat_storage_guild_large_shipping_container_closed_01";
    s.name = "SURPRISE_SHIPMENT_LOC20_container";
    s.var_4bdd7a94c9bc3392 = "high";
    s.var_8ef9cdfc2a34bab3 = "1";
    fe [[ f ]]( s, us, cf, ( -32807.1, -2981.1, 450.61 ), ( 2.46, 290.86, 0.24 ), "SURPRISE_SHIPMENT_LOC20_container", undefined, "sat_ob_surprise_shipping_container", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 2000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_surprise_shipments_cs";
    s.activity_bundle = "saw_bongo_activity_surprise_shipment";
    s.name = "SURPRISE_SHIPMENT_LOC21";
    fe [[ f ]]( s, us, cf, ( -32719.1, 7684.83, 403.07 ), ( 359.41, 18.06, -0.89 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_surprise_shipments_cs";
    s.is_cs_scriptable = 1;
    s.var_f480445067531e7b = "state:";
    s.model = "sat_storage_guild_large_shipping_container_closed_01";
    s.name = "SURPRISE_SHIPMENT_LOC21_container";
    s.var_4bdd7a94c9bc3392 = "high";
    s.var_8ef9cdfc2a34bab3 = "1";
    fe [[ f ]]( s, us, cf, ( -32695.1, 7695.9, 267.26 ), ( 359.4, 271.1, 0.83 ), "SURPRISE_SHIPMENT_LOC21_container", undefined, "sat_ob_surprise_shipping_container", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 2000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_surprise_shipments_cs";
    s.activity_bundle = "saw_bongo_activity_surprise_shipment";
    s.name = "SURPRISE_SHIPMENT_LOC22";
    fe [[ f ]]( s, us, cf, ( -32050, 36704.9, 2097.9 ), ( 0.06, 297.54, -0.26 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_surprise_shipments_cs";
    s.is_cs_scriptable = 1;
    s.var_f480445067531e7b = "state:";
    s.model = "sat_storage_guild_large_shipping_container_closed_01";
    s.name = "SURPRISE_SHIPMENT_LOC22_container";
    s.var_4bdd7a94c9bc3392 = "high";
    s.var_8ef9cdfc2a34bab3 = "1";
    fe [[ f ]]( s, us, cf, ( -32033.1, 36683.9, 1915.84 ), ( 359.74, 190.6, 0.01 ), "SURPRISE_SHIPMENT_LOC22_container", undefined, "sat_ob_surprise_shipping_container", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 2000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_surprise_shipments_cs";
    s.activity_bundle = "saw_bongo_activity_surprise_shipment";
    s.name = "SURPRISE_SHIPMENT_LOC23";
    fe [[ f ]]( s, us, cf, ( -15973, 51100.9, 708.89 ), ( 0, 297.54, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_surprise_shipments_cs";
    s.is_cs_scriptable = 1;
    s.var_f480445067531e7b = "state:";
    s.model = "sat_storage_guild_large_shipping_container_closed_01";
    s.name = "SURPRISE_SHIPMENT_LOC23_container";
    s.var_4bdd7a94c9bc3392 = "high";
    s.var_8ef9cdfc2a34bab3 = "1";
    fe [[ f ]]( s, us, cf, ( -15956.1, 51079.9, 561.89 ), ( 360, 190.6, 0 ), "SURPRISE_SHIPMENT_LOC23_container", undefined, "sat_ob_surprise_shipping_container", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 2000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_surprise_shipments_cs";
    s.activity_bundle = "saw_bongo_activity_surprise_shipment";
    s.name = "SURPRISE_SHIPMENT_LOC24";
    fe [[ f ]]( s, us, cf, ( -20015, 44237.1, 1619.76 ), ( 0, 117.54, -0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_surprise_shipments_cs";
    s.is_cs_scriptable = 1;
    s.var_f480445067531e7b = "state:";
    s.model = "sat_storage_guild_large_shipping_container_closed_01";
    s.name = "SURPRISE_SHIPMENT_LOC24_container";
    s.var_4bdd7a94c9bc3392 = "high";
    s.var_8ef9cdfc2a34bab3 = "1";
    fe [[ f ]]( s, us, cf, ( -20032.1, 44258.1, 1451.76 ), ( 0, 118.56, -0 ), "SURPRISE_SHIPMENT_LOC24_container", undefined, "sat_ob_surprise_shipping_container", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 2000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_surprise_shipments_cs";
    s.activity_bundle = "saw_bongo_activity_surprise_shipment";
    s.name = "SURPRISE_SHIPMENT_LOC25";
    fe [[ f ]]( s, us, cf, ( 11521, 43826.3, 848.03 ), ( 0.62, 95.74, -0.46 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_surprise_shipments_cs";
    s.is_cs_scriptable = 1;
    s.var_f480445067531e7b = "state:";
    s.model = "sat_storage_guild_large_shipping_container_closed_01";
    s.name = "SURPRISE_SHIPMENT_LOC25_container";
    s.var_4bdd7a94c9bc3392 = "high";
    s.var_8ef9cdfc2a34bab3 = "1";
    fe [[ f ]]( s, us, cf, ( 11514.1, 43851.1, 711.92 ), ( 0.81, 348.81, 0.23 ), "SURPRISE_SHIPMENT_LOC25_container", undefined, "sat_ob_surprise_shipping_container", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 2000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_surprise_shipments_cs";
    s.activity_bundle = "saw_bongo_activity_surprise_shipment";
    s.name = "SURPRISE_SHIPMENT_LOC26";
    fe [[ f ]]( s, us, cf, ( 23762.3, -40422, 1587.08 ), ( 359.45, 5.75, -0.16 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_surprise_shipments_cs";
    s.is_cs_scriptable = 1;
    s.var_f480445067531e7b = "state:";
    s.model = "sat_storage_guild_large_shipping_container_closed_01";
    s.name = "SURPRISE_SHIPMENT_LOC26_container";
    s.var_4bdd7a94c9bc3392 = "high";
    s.var_8ef9cdfc2a34bab3 = "1";
    fe [[ f ]]( s, us, cf, ( 23788.1, -40415.1, 1447.31 ), ( 0.01, 258.8, 0.57 ), "SURPRISE_SHIPMENT_LOC26_container", undefined, "sat_ob_surprise_shipping_container", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 2000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_surprise_shipments_cs";
    s.activity_bundle = "saw_bongo_activity_surprise_shipment";
    s.name = "SURPRISE_SHIPMENT_LOC27";
    fe [[ f ]]( s, us, cf, ( -6932.79, -40992.9, 1043 ), ( 0, 32.64, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_surprise_shipments_cs";
    s.is_cs_scriptable = 1;
    s.var_f480445067531e7b = "state:";
    s.model = "sat_storage_guild_large_shipping_container_closed_01";
    s.name = "SURPRISE_SHIPMENT_LOC27_container";
    s.var_4bdd7a94c9bc3392 = "high";
    s.var_8ef9cdfc2a34bab3 = "1";
    fe [[ f ]]( s, us, cf, ( -6925.9, -40927.9, 916 ), ( 0, 105.7, 0 ), "SURPRISE_SHIPMENT_LOC27_container", undefined, "sat_ob_surprise_shipping_container", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 2000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_surprise_shipments_cs";
    s.activity_bundle = "saw_bongo_activity_surprise_shipment";
    s.name = "SURPRISE_SHIPMENT_LOC28";
    fe [[ f ]]( s, us, cf, ( -19950.5, -6573.95, 1137.5 ), ( 0, 66.44, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_surprise_shipments_cs";
    s.is_cs_scriptable = 1;
    s.var_f480445067531e7b = "state:";
    s.model = "sat_storage_guild_large_shipping_container_closed_01";
    s.name = "SURPRISE_SHIPMENT_LOC28_container";
    s.var_4bdd7a94c9bc3392 = "high";
    s.var_8ef9cdfc2a34bab3 = "1";
    fe [[ f ]]( s, us, cf, ( -20015.2, -6487.35, 1002.5 ), ( 0, 319.5, 0 ), "SURPRISE_SHIPMENT_LOC28_container", undefined, "sat_ob_surprise_shipping_container", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 2000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_surprise_shipments_cs";
    s.activity_bundle = "saw_bongo_activity_surprise_shipment";
    s.name = "SURPRISE_SHIPMENT_LOC29";
    fe [[ f ]]( s, us, cf, ( -9123.47, 5650.49, 664 ), ( 0, 355.94, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_surprise_shipments_cs";
    s.is_cs_scriptable = 1;
    s.var_f480445067531e7b = "state:";
    s.model = "sat_storage_guild_large_shipping_container_closed_01";
    s.name = "SURPRISE_SHIPMENT_LOC29_container";
    s.var_4bdd7a94c9bc3392 = "high";
    s.var_8ef9cdfc2a34bab3 = "1";
    fe [[ f ]]( s, us, cf, ( -7900.9, 4917.15, 528 ), ( 0, 249, 0 ), "SURPRISE_SHIPMENT_LOC29_container", undefined, "sat_ob_surprise_shipping_container", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 2000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_surprise_shipments_cs";
    s.activity_bundle = "saw_bongo_activity_surprise_shipment";
    s.name = "SURPRISE_SHIPMENT_LOC30";
    fe [[ f ]]( s, us, cf, ( -14854.3, -22888.5, 683.5 ), ( 359.33, 288.55, -0.23 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_surprise_shipments_cs";
    s.is_cs_scriptable = 1;
    s.var_f480445067531e7b = "state:";
    s.model = "sat_storage_guild_large_shipping_container_closed_01";
    s.name = "SURPRISE_SHIPMENT_LOC30_container";
    s.var_4bdd7a94c9bc3392 = "high";
    s.var_8ef9cdfc2a34bab3 = "1";
    fe [[ f ]]( s, us, cf, ( -14841.9, -22913.1, 544.79 ), ( 359.97, 181.6, 0.7 ), "SURPRISE_SHIPMENT_LOC30_container", undefined, "sat_ob_surprise_shipping_container", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 2000 );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace mp_saw_avalon_bongo_surprise_shipments_cs
// Params 0, eflags: 0x4
// Checksum 0xb9bc31f8, Offset: 0x5b59
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace mp_saw_avalon_bongo_surprise_shipments_cs
// Params 0
// Checksum 0x5564b6e8, Offset: 0x5b63
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "mp_saw_avalon_bongo_surprise_shipments_cs" );
}

