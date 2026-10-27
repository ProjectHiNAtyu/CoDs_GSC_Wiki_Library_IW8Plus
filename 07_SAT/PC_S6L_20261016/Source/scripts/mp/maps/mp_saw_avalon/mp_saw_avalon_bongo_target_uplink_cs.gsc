// scripts\mp\maps\mp_saw_avalon\mp_saw_avalon_bongo_target_uplink_cs.gsc  (hash_35a8d143bccc9f3c.gscc) (size: 7453 Bytes / 0x1d1d / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x3c49e211 (1011474961)
// size ...... 7453 (0x1d1d)
// includes .. 2   (offset: 0x18f9)
// strings ... 41  (offset: 0x1909)
// dev strs .. 0   (offset: 0x1d1d)
// exports ... 6   (offset: 0x1649)
// cseg ...... 0x445 + 0x1204 (0x1649)
// imports ... 16  (offset: 0x1739)
// animtree1 . 0   (offset: 0x1d1d)
// animtree2 . 0   (offset: 0x1d1d)
#using scripts\common\create_script_utility;
#using scripts\common\utility;

#namespace mp_saw_avalon_bongo_target_uplink_cs;

// Namespace mp_saw_avalon_bongo_target_uplink_cs
// Params 2
// Checksum 0xb2fb7aac, Offset: 0x463
// Size: 0x80
function main( unused, unused2 )
{
    if ( utility::flag_exist( "mp_saw_avalon_bongo_target_uplink_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "mp_saw_avalon_bongo_target_uplink_cs" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "mp_saw_avalon_bongo_target_uplink_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "mp_saw_avalon_bongo_target_uplink_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace mp_saw_avalon_bongo_target_uplink_cs
// Params 3, eflags: 0x4
// Checksum 0x8190982a, Offset: 0x4eb
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "mp_saw_avalon_bongo_target_uplink_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "mp_saw_avalon_bongo_target_uplink_cs" );
}

// Namespace mp_saw_avalon_bongo_target_uplink_cs
// Params 3, eflags: 0x4
// Checksum 0x3429310e, Offset: 0x565
// Size: 0x10c4
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_target_uplink_cs";
    s.name = "STADIUM_UPLINK_TOWER";
    fe [[ f ]]( s, us, cf, ( -41915.9, 11668.1, 448 ), ( 0, 178.9, 0 ), "STADIUM_TARGET_UPLINK", undefined, "uplink_station", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 19700 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_target_uplink_cs";
    s.name = "HIGHTOWN_UPLINK_TOWER";
    fe [[ f ]]( s, us, cf, ( -17491.6, 5646.56, 1056 ), ( 0, 320.9, 0 ), "HIGHTOWN_TARGET_UPLINK", undefined, "uplink_station", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 19700 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_target_uplink_cs";
    s.activity_bundle = "saw_activity_bongo_target_uplink";
    s.name = "HIGHTOWN_TARGET_UPLINK";
    fe [[ f ]]( s, us, cf, ( -17491.5, 5646.57, 1056 ), ( 0, 320.9, 0 ), "activity_nexus_variant", "HIGHTOWN_TARGET_UPLINK", undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_target_uplink_cs";
    s.activity_bundle = "saw_activity_bongo_target_uplink";
    s.name = "STADIUM_TARGET_UPLINK";
    fe [[ f ]]( s, us, cf, ( -41915.9, 11668, 484.43 ), ( 0, 178.9, 0 ), "activity_nexus_variant", "STADIUM_TARGET_UPLINK", undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_target_uplink_cs";
    s.name = "CASINO_UPLINK_TOWER";
    fe [[ f ]]( s, us, cf, ( -8673.44, 26698.7, 768 ), ( 0, 131.1, 0 ), "CASINO_TARGET_UPLINK", undefined, "uplink_station", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 19700 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_target_uplink_cs";
    s.activity_bundle = "saw_activity_bongo_target_uplink";
    s.name = "CASINO_TARGET_UPLINK";
    fe [[ f ]]( s, us, cf, ( -8673.52, 26698.6, 822.46 ), ( 0, 131.1, 0 ), "activity_nexus_variant", "CASINO_TARGET_UPLINK", undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_target_uplink_cs";
    s.name = "GOLF_UPLINK_TOWER";
    fe [[ f ]]( s, us, cf, ( -33534.5, 36957.1, 1948 ), ( 0, 136.6, 0 ), "GOLF_TARGET_UPLINK", undefined, "uplink_station", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 19700 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_target_uplink_cs";
    s.activity_bundle = "saw_activity_bongo_target_uplink";
    s.name = "GOLF_TARGET_UPLINK";
    fe [[ f ]]( s, us, cf, ( -33534.6, 36957, 1997.7 ), ( 0, 136.6, 0 ), "activity_nexus_variant", "GOLF_TARGET_UPLINK", undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_target_uplink_cs";
    s.name = "SUBURB_UPLINK_TOWER";
    fe [[ f ]]( s, us, cf, ( -10870.4, 51008.3, 472 ), ( 0, 0, 0 ), "SUBURB_TARGET_UPLINK", undefined, "uplink_station", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 19700 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_target_uplink_cs";
    s.activity_bundle = "saw_activity_bongo_target_uplink";
    s.name = "SUBURB_TARGET_UPLINK";
    fe [[ f ]]( s, us, cf, ( -10870.3, 51008.2, 520.77 ), ( 0, 0, 0 ), "activity_nexus_variant", "SUBURB_TARGET_UPLINK", undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_target_uplink_cs";
    s.name = "LIGHTHOUSE_UPLINK_TOWER";
    fe [[ f ]]( s, us, cf, ( -51885.4, -17097.4, 464 ), ( 0, 42.06, 0 ), "LIGHTHOUSE_TARGET_UPLINK", undefined, "uplink_station", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 19700 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_target_uplink_cs";
    s.activity_bundle = "saw_activity_bongo_target_uplink";
    s.name = "LIGHTHOUSE_TARGET_UPLINK";
    fe [[ f ]]( s, us, cf, ( -51885.4, -17097.4, 509.86 ), ( 0, 42.06, 0 ), "activity_nexus_variant", "LIGHTHOUSE_TARGET_UPLINK", undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_target_uplink_cs";
    s.name = "FIRINGRANGE_UPLINK_TOWER";
    fe [[ f ]]( s, us, cf, ( -29081.7, -30138.2, 918.5 ), ( 0, 230.4, 0 ), "FIRINGRANGE_TARGET_UPLINK", undefined, "uplink_station", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 19700 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_target_uplink_cs";
    s.activity_bundle = "saw_activity_bongo_target_uplink";
    s.name = "FIRINGRANGE_TARGET_UPLINK";
    fe [[ f ]]( s, us, cf, ( -29081.7, -30138.2, 968.41 ), ( 0, 230.4, 0 ), "activity_nexus_variant", "FIRINGRANGE_TARGET_UPLINK", undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_target_uplink_cs";
    s.name = "WINERY_UPLINK_TOWER";
    fe [[ f ]]( s, us, cf, ( 18947.2, 48351.8, 952 ), ( 0, 8.7, 0 ), "WINERY_TARGET_UPLINK", undefined, "uplink_station", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 19700 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_target_uplink_cs";
    s.activity_bundle = "saw_activity_bongo_target_uplink";
    s.name = "WINERY_TARGET_UPLINK";
    fe [[ f ]]( s, us, cf, ( 18947.4, 48351.7, 1012.51 ), ( 0, 8.7, 0 ), "activity_nexus_variant", "WINERY_TARGET_UPLINK", undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_target_uplink_cs";
    s.name = "COLOSSEUM_UPLINK_TOWER";
    fe [[ f ]]( s, us, cf, ( 45344.3, 22130, 673.27 ), ( 0, 8.7, 0 ), "COLOSSEUM_TARGET_UPLINK", undefined, "uplink_station", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 19700 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_target_uplink_cs";
    s.activity_bundle = "saw_activity_bongo_target_uplink";
    s.name = "COLOSSEUM_TARGET_UPLINK";
    fe [[ f ]]( s, us, cf, ( 45344.6, 22129.9, 720.59 ), ( 0, 8.7, 0 ), "activity_nexus_variant", "COLOSSEUM_TARGET_UPLINK", undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_target_uplink_cs";
    s.name = "RESORT_UPLINK_TOWER";
    fe [[ f ]]( s, us, cf, ( 11856.1, 21029, 580 ), ( 0, 89.3, 0 ), "RESORT_TARGET_UPLINK", undefined, "uplink_station", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 19700 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_target_uplink_cs";
    s.activity_bundle = "saw_activity_bongo_target_uplink";
    s.name = "RESORT_TARGET_UPLINK";
    fe [[ f ]]( s, us, cf, ( 11856.3, 21029.3, 626.22 ), ( 0, 89.3, 0 ), "activity_nexus_variant", "RESORT_TARGET_UPLINK", undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_target_uplink_cs";
    s.name = "LOWTOWN_UPLINK_TOWER";
    fe [[ f ]]( s, us, cf, ( 7094.55, -2733.87, 748 ), ( 0, 139.7, 0 ), "LOWTOWN_TARGET_UPLINK", undefined, "uplink_station", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 19700 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_target_uplink_cs";
    s.activity_bundle = "saw_activity_bongo_target_uplink";
    s.name = "LOWTOWN_TARGET_UPLINK";
    fe [[ f ]]( s, us, cf, ( 7094.45, -2733.52, 807 ), ( 0, 139.7, 0 ), "activity_nexus_variant", "LOWTOWN_TARGET_UPLINK", undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_target_uplink_cs";
    s.name = "PIER_UPLINK_TOWER";
    fe [[ f ]]( s, us, cf, ( -4113.17, -20017.7, 142 ), ( 0, 154.8, 0 ), "PIER_TARGET_UPLINK", undefined, "uplink_station", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 19700 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_target_uplink_cs";
    s.activity_bundle = "saw_activity_bongo_target_uplink";
    s.name = "PIER_TARGET_UPLINK";
    fe [[ f ]]( s, us, cf, ( -4113.36, -20017.4, 206.39 ), ( 0, 154.8, 0 ), "activity_nexus_variant", "PIER_TARGET_UPLINK", undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_target_uplink_cs";
    s.name = "CHOPSHOP_UPLINK_TOWER";
    fe [[ f ]]( s, us, cf, ( 1793.46, -47528.4, 104 ), ( 0, 154.8, 0 ), "CHOPSHOP_TARGET_UPLINK", undefined, "uplink_station", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 19700 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_target_uplink_cs";
    s.activity_bundle = "saw_activity_bongo_target_uplink";
    s.name = "CHOPSHOP_TARGET_UPLINK";
    fe [[ f ]]( s, us, cf, ( 1793.27, -47528.1, 170.03 ), ( 0, 154.8, 0 ), "activity_nexus_variant", "CHOPSHOP_TARGET_UPLINK", undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_target_uplink_cs";
    s.name = "HELIPORT_UPLINK_TOWER";
    fe [[ f ]]( s, us, cf, ( 30423.7, -18357.7, 272 ), ( 0, 144.5, 0 ), "HELIPORT_TARGET_UPLINK", undefined, "uplink_station", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 19700 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_target_uplink_cs";
    s.activity_bundle = "saw_activity_bongo_target_uplink";
    s.name = "HELIPORT_TARGET_UPLINK";
    fe [[ f ]]( s, us, cf, ( 30423.6, -18357.4, 321.67 ), ( 0, 144.5, 0 ), "activity_nexus_variant", "HELIPORT_TARGET_UPLINK", undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_target_uplink_cs";
    s.name = "ARSENAL_UPLINK_TOWER";
    fe [[ f ]]( s, us, cf, ( 31851.2, -52951.4, 208 ), ( 0, 309.3, 0 ), "ARSENAL_TARGET_UPLINK", undefined, "uplink_station", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 19700 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_target_uplink_cs";
    s.activity_bundle = "saw_activity_bongo_target_uplink";
    s.name = "ARSENAL_TARGET_UPLINK";
    fe [[ f ]]( s, us, cf, ( 31851.2, -52951.8, 208 ), ( 0, 309.3, 0 ), "activity_nexus_variant", "ARSENAL_TARGET_UPLINK", undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_target_uplink_cs";
    s.name = "CARFACTORY_UPLINK_TOWER";
    fe [[ f ]]( s, us, cf, ( 51896.6, -38623.7, 1991 ), ( 0, 42.7, 0 ), "CARFACTORY_TARGET_UPLINK", undefined, "uplink_station", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 19700 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_target_uplink_cs";
    s.activity_bundle = "saw_activity_bongo_target_uplink";
    s.name = "CARFACTORY_TARGET_UPLINK";
    fe [[ f ]]( s, us, cf, ( 51897, -38623.7, 2050.08 ), ( 0, 42.7, 0 ), "activity_nexus_variant", "CARFACTORY_TARGET_UPLINK", undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_target_uplink_cs";
    s.name = "WATER_UPLINK_TOWER";
    fe [[ f ]]( s, us, cf, ( 47160.8, -11291.1, 441 ), ( 0, 183.7, 0 ), "WATER_TARGET_UPLINK", undefined, "uplink_station", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 19700 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_target_uplink_cs";
    s.activity_bundle = "saw_activity_bongo_target_uplink";
    s.name = "WATER_TARGET_UPLINK";
    fe [[ f ]]( s, us, cf, ( 47160.4, -11290.9, 481.62 ), ( 0, 183.7, 0 ), "activity_nexus_variant", "WATER_TARGET_UPLINK", undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace mp_saw_avalon_bongo_target_uplink_cs
// Params 0, eflags: 0x4
// Checksum 0xe544b714, Offset: 0x1631
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace mp_saw_avalon_bongo_target_uplink_cs
// Params 0
// Checksum 0x43c34567, Offset: 0x163b
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "mp_saw_avalon_bongo_target_uplink_cs" );
}

