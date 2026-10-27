// scripts\mp\maps\mp_saw_avalon\mp_saw_avalon_bongo_safecrack_cs.gsc  (hash_07d28d246d9a74d6.gscc) (size: 24254 Bytes / 0x5ebe / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xfb1af57e (4212847998)
// size ...... 24254 (0x5ebe)
// includes .. 3   (offset: 0x504a)
// strings ... 135 (offset: 0x5062)
// dev strs .. 0   (offset: 0x5ebe)
// exports ... 9   (offset: 0x4cb2)
// cseg ...... 0xd76 + 0x3f3c (0x4cb2)
// imports ... 20  (offset: 0x4e1a)
// animtree1 . 0   (offset: 0x5ebe)
// animtree2 . 0   (offset: 0x5ebe)
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace mp_saw_avalon_bongo_safecrack_cs;

// Namespace mp_saw_avalon_bongo_safecrack_cs
// Params 0, eflags: 0x5
// Checksum 0x5eee6272, Offset: 0xd94
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"mp_saw_avalon_bongo_safecrack_cs", undefined, &function_b39ecd3d51489472, undefined );
}

// Namespace mp_saw_avalon_bongo_safecrack_cs
// Params 0, eflags: 0x4
// Checksum 0x1c588d8d, Offset: 0xdb5
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace mp_saw_avalon_bongo_safecrack_cs
// Params 0, eflags: 0x4
// Checksum 0x99635e61, Offset: 0xdc6
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace mp_saw_avalon_bongo_safecrack_cs
// Params 2
// Checksum 0x298a0828, Offset: 0xdd7
// Size: 0x80
function main( unused, unused2 )
{
    if ( utility::flag_exist( "mp_saw_avalon_bongo_safecrack_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "mp_saw_avalon_bongo_safecrack_cs" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "mp_saw_avalon_bongo_safecrack_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "mp_saw_avalon_bongo_safecrack_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace mp_saw_avalon_bongo_safecrack_cs
// Params 3, eflags: 0x4
// Checksum 0x1ae1eaae, Offset: 0xe5f
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "mp_saw_avalon_bongo_safecrack_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "mp_saw_avalon_bongo_safecrack_cs" );
}

// Namespace mp_saw_avalon_bongo_safecrack_cs
// Params 3, eflags: 0x4
// Checksum 0xd85dc58d, Offset: 0xed9
// Size: 0x3db9
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_safecrack_cs";
    s.activity_bundle = "saw_activity_bongo_safecrack";
    s.name = "CARFACTORY_01_SAFECRACK";
    fe [[ f ]]( s, us, cf, ( 54585.5, -41035.1, 2259.27 ), ( 0, 224.5, 0 ), "activity_nexus_variant", "CARFACTORY_01_SAFECRACK", undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_safecrack_cs";
    s.name = "CARFACTORY_01_SAFE";
    fe [[ f ]]( s, us, cf, ( 54585.5, -41035.1, 2192 ), ( 0, 224.5, 0 ), "CARFACTORY_01_SAFECRACK", undefined, "safecrack_safe", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_safecrack_cs";
    s.name = "HIGHTOWN_OFFICE_SAFE";
    fe [[ f ]]( s, us, cf, ( -20386.6, 10662.3, 1218.25 ), ( 0, 226.32, 0 ), "HIGHTOWN_OFFICE_SAFECRACK", undefined, "safecrack_safe", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_safecrack_cs";
    s.activity_bundle = "saw_activity_bongo_safecrack";
    s.name = "HIGHTOWN_OFFICE_SAFECRACK";
    fe [[ f ]]( s, us, cf, ( -20358.2, 10573.7, 1220.25 ), ( 0, 252.5, 0 ), "activity_nexus_variant", "HIGHTOWN_OFFICE_SAFECRACK", undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_safecrack_cs";
    s.activity_bundle = "saw_activity_bongo_safecrack";
    s.name = "LOWTOWN_GROCERS_SAFECRACK";
    fe [[ f ]]( s, us, cf, ( -5492.61, 7249.65, 296.07 ), ( 0, 252.5, 0 ), "activity_nexus_variant", "LOWTOWN_GROCERS_SAFECRACK", undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_safecrack_cs";
    s.name = "LOWTOWN_GROCERS_SAFE";
    fe [[ f ]]( s, us, cf, ( -5611.54, 7316.64, 294 ), ( 0, 326, 0 ), "LOWTOWN_GROCERS_SAFECRACK", undefined, "safecrack_safe", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_safecrack_cs";
    s.name = "HIGHTOWN_MED_SAFE";
    fe [[ f ]]( s, us, cf, ( -16292.3, 351.51, 1468 ), ( 0, 280.52, 0 ), "HIGHTOWN_MED_SAFECRACK", undefined, "safecrack_safe", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_safecrack_cs";
    s.activity_bundle = "saw_activity_bongo_safecrack";
    s.name = "HIGHTOWN_MED_SAFECRACK";
    fe [[ f ]]( s, us, cf, ( -16545.9, 86.42, 1468 ), ( 0, 180.34, 0 ), "activity_nexus_variant", "HIGHTOWN_MED_SAFECRACK", undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_safecrack_cs";
    s.activity_bundle = "saw_activity_bongo_safecrack";
    s.name = "LOWTOWN_CANALS_SAFECRACK";
    fe [[ f ]]( s, us, cf, ( -247.29, 6838.73, 100.57 ), ( 0, 271.28, 0 ), "activity_nexus_variant", "LOWTOWN_CANALS_SAFECRACK", undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_safecrack_cs";
    s.name = "LOWTOWN_CANALS_SAFE";
    fe [[ f ]]( s, us, cf, ( -250.95, 6761.05, 78 ), ( 0, 75.09, 0 ), "LOWTOWN_CANALS_SAFECRACK", undefined, "safecrack_safe", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_safecrack_cs";
    s.activity_bundle = "saw_activity_bongo_safecrack";
    s.name = "LOWTOWN_GROCERY_PARK_SAFECRACK";
    fe [[ f ]]( s, us, cf, ( 7354.39, 1736.6, 434.07 ), ( 0, 292.28, 0 ), "activity_nexus_variant", "LOWTOWN_GROCERY_PARK_SAFECRACK", undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_safecrack_cs";
    s.name = "LOWTOWN_GROCERY_PARK_SAFE";
    fe [[ f ]]( s, us, cf, ( 8063.32, 2105.4, 604 ), ( 0, 276.09, 0 ), "LOWTOWN_GROCERY_PARK_SAFECRACK", undefined, "safecrack_safe", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_safecrack_cs";
    s.activity_bundle = "saw_activity_bongo_safecrack";
    s.name = "LOWTOWN_MARINA_DISTRICT_SAFECRACK";
    fe [[ f ]]( s, us, cf, ( 5216.76, 8954.01, 32.57 ), ( 0, 286.05, 0 ), "activity_nexus_variant", "LOWTOWN_MARINA_DISTRICT_SAFECRACK", undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_safecrack_cs";
    s.name = "LOWTOWN_MARINA_DISTRICT_SAFE";
    fe [[ f ]]( s, us, cf, ( 5462.55, 9085.05, 100.25 ), ( 0, 359.87, 0 ), "LOWTOWN_MARINA_DISTRICT_SAFECRACK", undefined, "safecrack_safe", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_safecrack_cs";
    s.activity_bundle = "saw_activity_bongo_safecrack";
    s.name = "LOWTOWN_MARINA_MOTOR_POOL_SAFECRACK";
    fe [[ f ]]( s, us, cf, ( -1963.95, 10555.3, 27.7 ), ( 0, 180.34, 0 ), "activity_nexus_variant", "LOWTOWN_MARINA_MOTOR_POOL_SAFECRACK", undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_safecrack_cs";
    s.name = "LOWTOWN_MARINA_MOTOR_POOL_SAFE";
    fe [[ f ]]( s, us, cf, ( -2069.6, 10738.5, 14.12 ), ( 0, 345, 0 ), "LOWTOWN_MARINA_MOTOR_POOL_SAFECRACK", undefined, "safecrack_safe", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_safecrack_cs";
    s.name = "PALACE_SAFE";
    fe [[ f ]]( s, us, cf, ( -13093.1, -7300.64, 1855 ), ( 0, 0, 0 ), "PALACE_SAFECRACK", undefined, "safecrack_safe", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_safecrack_cs";
    s.activity_bundle = "saw_activity_bongo_safecrack";
    s.name = "PALACE_SAFECRACK";
    fe [[ f ]]( s, us, cf, ( -13077.3, -7381.37, 1870 ), ( 0, 357, 0 ), "activity_nexus_variant", "PALACE_SAFECRACK", undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_safecrack_cs";
    s.activity_bundle = "saw_activity_bongo_safecrack";
    s.name = "CASINO_ROOF_SAFECRACK";
    fe [[ f ]]( s, us, cf, ( -7668.97, 26270.9, 1359 ), ( 0, 180.34, 0 ), "activity_nexus_variant", "CASINO_ROOF_SAFECRACK", undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_safecrack_cs";
    s.name = "CASINO_ROOF_SAFE";
    fe [[ f ]]( s, us, cf, ( -7497.52, 26469.7, 1336 ), ( 0, 219.93, 0 ), "CASINO_ROOF_SAFECRACK", undefined, "safecrack_safe", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_safecrack_cs";
    s.activity_bundle = "saw_activity_bongo_safecrack";
    s.name = "GLAMPING_RESTAURANT_SAFECRACK";
    fe [[ f ]]( s, us, cf, ( -26800.2, 48654.2, 1716 ), ( 0, 180.34, 0 ), "activity_nexus_variant", "GLAMPING_RESTAURANT_SAFECRACK", undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_safecrack_cs";
    s.name = "GLAMPING_RESTAURANT_SAFE";
    fe [[ f ]]( s, us, cf, ( -26532.9, 48717.1, 1700 ), ( 0, 165, 0 ), "GLAMPING_RESTAURANT_SAFECRACK", undefined, "safecrack_safe", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_safecrack_cs";
    s.name = "GOLF_COURSE_RESORT_SAFE";
    fe [[ f ]]( s, us, cf, ( -32498.3, 25724.9, 1714.5 ), ( 0, 4.94, 0 ), "GOLF_COURSE_RESORT_SAFECRACK", undefined, "safecrack_safe", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_safecrack_cs";
    s.activity_bundle = "saw_activity_bongo_safecrack";
    s.name = "GOLF_COURSE_RESORT_SAFECRACK";
    fe [[ f ]]( s, us, cf, ( -32430.6, 25622, 1873.5 ), ( 0, 180.34, 0 ), "activity_nexus_variant", "GOLF_COURSE_RESORT_SAFECRACK", undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_safecrack_cs";
    s.name = "REPAIR_STORE_SAFE";
    fe [[ f ]]( s, us, cf, ( -42438.2, 27064.6, 1732 ), ( 0, 114, 0 ), "REPAIR_STORE_SAFECRACK", undefined, "safecrack_safe", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_safecrack_cs";
    s.activity_bundle = "saw_activity_bongo_safecrack";
    s.name = "REPAIR_STORE_SAFECRACK";
    fe [[ f ]]( s, us, cf, ( -42583.2, 27404.6, 1585.68 ), ( 0, 180.34, 0 ), "activity_nexus_variant", "REPAIR_STORE_SAFECRACK", undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_safecrack_cs";
    s.name = "STADIUM_TICKET_BOOTH_SAFE";
    fe [[ f ]]( s, us, cf, ( -41785.1, 11485.6, 447 ), ( 0, 180, 0 ), "STADIUM_TICKET_BOOTH_SAFECRACK", undefined, "safecrack_safe", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_safecrack_cs";
    s.activity_bundle = "saw_activity_bongo_safecrack";
    s.name = "STADIUM_TICKET_BOOTH_SAFECRACK";
    fe [[ f ]]( s, us, cf, ( -42271, 11346.4, 343.68 ), ( 0, 135.74, 0 ), "activity_nexus_variant", "STADIUM_TICKET_BOOTH_SAFECRACK", undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_safecrack_cs";
    s.activity_bundle = "saw_activity_bongo_safecrack";
    s.name = "STADIUM_EAST_SAFECRACK";
    fe [[ f ]]( s, us, cf, ( -31454.8, 16282.8, 1090.99 ), ( 0, 182.44, 0 ), "activity_nexus_variant", "STADIUM_EAST_SAFECRACK", undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_safecrack_cs";
    s.name = "STADIUM_EAST_SAFE";
    fe [[ f ]]( s, us, cf, ( -31405.8, 16014.7, 1074.99 ), ( 0, 95, 0 ), "STADIUM_EAST_SAFECRACK", undefined, "safecrack_safe", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_safecrack_cs";
    s.activity_bundle = "saw_activity_bongo_safecrack";
    s.name = "SUBURBS_CENTER_SAFECRACK";
    fe [[ f ]]( s, us, cf, ( -7270.76, 46604.8, 408.5 ), ( 0, 180.34, 0 ), "activity_nexus_variant", "SUBURBS_CENTER_SAFECRACK", undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_safecrack_cs";
    s.name = "SUBURBS_CENTER_SAFE";
    fe [[ f ]]( s, us, cf, ( -7235.34, 46434.2, 248 ), ( 0, 135.38, 0 ), "SUBURBS_CENTER_SAFECRACK", undefined, "safecrack_safe", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_safecrack_cs";
    s.name = "SUBURBS_GARDEN_SAFE";
    fe [[ f ]]( s, us, cf, ( -8167.27, 43102.3, 212 ), ( 0, 134.84, 0 ), "SUBURBS_GARDEN_SAFECRACK", undefined, "safecrack_safe", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_safecrack_cs";
    s.activity_bundle = "saw_activity_bongo_safecrack";
    s.name = "SUBURBS_GARDEN_SAFECRACK";
    fe [[ f ]]( s, us, cf, ( -8630.2, 43110.6, 143.68 ), ( 0, 180.34, 0 ), "activity_nexus_variant", "SUBURBS_GARDEN_SAFECRACK", undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_safecrack_cs";
    s.name = "SUBURBS_HILLTOP_SAFE";
    fe [[ f ]]( s, us, cf, ( -6683.7, 52894.6, 485.5 ), ( 0, 167, 0 ), "SUBURBS_HILLTOP_SAFECRACK", undefined, "safecrack_safe", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_safecrack_cs";
    s.activity_bundle = "saw_activity_bongo_safecrack";
    s.name = "SUBURBS_HILLTOP_SAFECRACK";
    fe [[ f ]]( s, us, cf, ( -7180.2, 52646.6, 327.68 ), ( 0, 180.34, 0 ), "activity_nexus_variant", "SUBURBS_HILLTOP_SAFECRACK", undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_safecrack_cs";
    s.activity_bundle = "saw_activity_bongo_safecrack";
    s.name = "CLIFFTOWN_FISH_PLANT_SAFECRACK";
    fe [[ f ]]( s, us, cf, ( 46311.8, 12019.5, 780.25 ), ( 0, 180.34, 0 ), "activity_nexus_variant", "CLIFFTOWN_FISH_PLANT_SAFECRACK", undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_safecrack_cs";
    s.name = "CLIFFTOWN_FISH_PLANT_SAFE";
    fe [[ f ]]( s, us, cf, ( 46025.4, 11839.1, 618.25 ), ( 0, 95.87, 0 ), "CLIFFTOWN_FISH_PLANT_SAFECRACK", undefined, "safecrack_safe", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_safecrack_cs";
    s.activity_bundle = "saw_activity_bongo_safecrack";
    s.name = "CLIFFTOWN_MARKET_SAFECRACK";
    fe [[ f ]]( s, us, cf, ( 41739.5, 7082.85, 1305.09 ), ( 0, 180.34, 0 ), "activity_nexus_variant", "CLIFFTOWN_MARKET_SAFECRACK", undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_safecrack_cs";
    s.name = "CLIFFTOWN_MARKET_SAFE";
    fe [[ f ]]( s, us, cf, ( 41739.1, 6981.38, 1289 ), ( 0, 50.69, 0 ), "CLIFFTOWN_MARKET_SAFECRACK", undefined, "safecrack_safe", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_safecrack_cs";
    s.name = "COLOSSEUM_BAR_SAFE";
    fe [[ f ]]( s, us, cf, ( 45368.5, 24083.1, 290 ), ( 0, 47.34, 0 ), "COLOSSEUM_BAR_SAFECRACK", undefined, "safecrack_safe", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_safecrack_cs";
    s.activity_bundle = "saw_activity_bongo_safecrack";
    s.name = "COLOSSEUM_BAR_SAFECRACK";
    fe [[ f ]]( s, us, cf, ( 45368.8, 24046, 306.94 ), ( 0, 180.34, 0 ), "activity_nexus_variant", "COLOSSEUM_BAR_SAFECRACK", undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_safecrack_cs";
    s.activity_bundle = "saw_activity_bongo_safecrack";
    s.name = "LAVENDER_RUINS_SAFECRACK";
    fe [[ f ]]( s, us, cf, ( 42873.8, 34903, 1342 ), ( 0, 180.34, 0 ), "activity_nexus_variant", "LAVENDER_RUINS_SAFECRACK", undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_safecrack_cs";
    s.name = "LAVENDER_RUINS_SAFE";
    fe [[ f ]]( s, us, cf, ( 43596.4, 34498, 1354 ), ( 0, 315, 0 ), "LAVENDER_RUINS_SAFECRACK", undefined, "safecrack_safe", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_safecrack_cs";
    s.name = "RESORT_BEDROOM_SAFE";
    fe [[ f ]]( s, us, cf, ( 13246.8, 20369.6, 2520 ), ( 0, 90.34, 0 ), "RESORT_BEDROOM_SAFECRACK", undefined, "safecrack_safe", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_safecrack_cs";
    s.activity_bundle = "saw_activity_bongo_safecrack";
    s.name = "RESORT_BEDROOM_SAFECRACK";
    fe [[ f ]]( s, us, cf, ( 12622.8, 20931.6, 2316.68 ), ( 0, 180.34, 0 ), "activity_nexus_variant", "RESORT_BEDROOM_SAFECRACK", undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_safecrack_cs";
    s.name = "WIND_TOWER_SAFE";
    fe [[ f ]]( s, us, cf, ( 14960.8, 32391.6, 1996.5 ), ( 0, 314.74, 0 ), "WIND_TOWER_SAFECRACK", undefined, "safecrack_safe", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_safecrack_cs";
    s.activity_bundle = "saw_activity_bongo_safecrack";
    s.name = "WIND_TOWER_SAFECRACK";
    fe [[ f ]]( s, us, cf, ( 14877.8, 32499.6, 1886.68 ), ( 0, 180.34, 0 ), "activity_nexus_variant", "WIND_TOWER_SAFECRACK", undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_safecrack_cs";
    s.name = "COAST_GUARD_LIGHTHOUSE_SAFE";
    fe [[ f ]]( s, us, cf, ( -51889.1, -16995.8, 464 ), ( 0, 340, 0 ), "COAST_GUARD_LIGHTHOUSE_SAFECRACK", undefined, "safecrack_safe", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_safecrack_cs";
    s.activity_bundle = "saw_activity_bongo_safecrack";
    s.name = "COAST_GUARD_LIGHTHOUSE_SAFECRACK";
    fe [[ f ]]( s, us, cf, ( -51824.3, -17390.6, 4.68 ), ( 0, 177.73, 0 ), "activity_nexus_variant", "COAST_GUARD_LIGHTHOUSE_SAFECRACK", undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_safecrack_cs";
    s.activity_bundle = "saw_activity_bongo_safecrack";
    s.name = "FIRING_RANGE_GAS_SAFECRACK";
    fe [[ f ]]( s, us, cf, ( -26192.6, -20533.5, 992.2 ), ( 0, 180.34, 0 ), "activity_nexus_variant", "FIRING_RANGE_GAS_SAFECRACK", undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_safecrack_cs";
    s.name = "FIRING_RANGE_GAS_SAFE";
    fe [[ f ]]( s, us, cf, ( -26182.3, -20341.7, 976 ), ( 0, 346, 0 ), "FIRING_RANGE_GAS_SAFECRACK", undefined, "safecrack_safe", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_safecrack_cs";
    s.name = "FIRING_RANGE_NORTH_SAFE";
    fe [[ f ]]( s, us, cf, ( -31830.6, -23341.8, 771 ), ( 0, 176.29, 0 ), "FIRING_RANGE_NORTH_SAFECRACK", undefined, "safecrack_safe", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_safecrack_cs";
    s.activity_bundle = "saw_activity_bongo_safecrack";
    s.name = "FIRING_RANGE_NORTH_SAFECRACK";
    fe [[ f ]]( s, us, cf, ( -32118.3, -23463.6, 343.68 ), ( 0, 177.73, 0 ), "activity_nexus_variant", "FIRING_RANGE_NORTH_SAFECRACK", undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_safecrack_cs";
    s.activity_bundle = "saw_activity_bongo_safecrack";
    s.name = "ISLAND_SOUTH_SAFECRACK";
    fe [[ f ]]( s, us, cf, ( -31673.9, -56816.8, 594.07 ), ( 0, 180.34, 0 ), "activity_nexus_variant", "ISLAND_SOUTH_SAFECRACK", undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_safecrack_cs";
    s.name = "ISLAND_SOUTH_SAFE";
    fe [[ f ]]( s, us, cf, ( -31729, -56722, 592 ), ( 0, 255, 0 ), "ISLAND_SOUTH_SAFECRACK", undefined, "safecrack_safe", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_safecrack_cs";
    s.activity_bundle = "saw_activity_bongo_safecrack";
    s.name = "AQUEDUCT_WEST_SAFECRACK";
    fe [[ f ]]( s, us, cf, ( 28367, -4293.57, 267.57 ), ( 0, 180.34, 0 ), "activity_nexus_variant", "AQUEDUCT_WEST_SAFECRACK", undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_safecrack_cs";
    s.name = "AQUEDUCT_WEST_SAFE";
    fe [[ f ]]( s, us, cf, ( 28218.1, -4365.85, 252 ), ( 0, 343.82, 0 ), "AQUEDUCT_WEST_SAFECRACK", undefined, "safecrack_safe", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_safecrack_cs";
    s.activity_bundle = "saw_activity_bongo_safecrack";
    s.name = "BOAT_GARAGE_SAFECRACK";
    fe [[ f ]]( s, us, cf, ( 29500, -36068, 265.07 ), ( 0, 16.28, 0 ), "activity_nexus_variant", "BOAT_GARAGE_SAFECRACK", undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_safecrack_cs";
    s.name = "BOAT_GARAGE_SAFE";
    fe [[ f ]]( s, us, cf, ( 29577.7, -36141.5, 248 ), ( 0, 90.94, 0 ), "BOAT_GARAGE_SAFECRACK", undefined, "safecrack_safe", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_safecrack_cs";
    s.activity_bundle = "saw_activity_bongo_safecrack";
    s.name = "CHOP_SHOP_GARAGE_SAFECRACK";
    fe [[ f ]]( s, us, cf, ( 3560.97, -47898.4, 72.57 ), ( 0, 180.34, 0 ), "activity_nexus_variant", "CHOP_SHOP_GARAGE_SAFECRACK", undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_safecrack_cs";
    s.name = "CHOP_SHOP_GARAGE_SAFE";
    fe [[ f ]]( s, us, cf, ( 3488.87, -47764.6, 56 ), ( 0, 333.97, 0 ), "CHOP_SHOP_GARAGE_SAFECRACK", undefined, "safecrack_safe", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_safecrack_cs";
    s.activity_bundle = "saw_activity_bongo_safecrack";
    s.name = "HELIPORT_HANGAR_SAFECRACK";
    fe [[ f ]]( s, us, cf, ( 27866.9, -25418.4, 242.32 ), ( 0, 72.5, 0 ), "activity_nexus_variant", "HELIPORT_HANGAR_SAFECRACK", undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_safecrack_cs";
    s.name = "HELIPORT_HANGAR_SAFE";
    fe [[ f ]]( s, us, cf, ( 27985.9, -25486.4, 241 ), ( 0, 146, 0 ), "HELIPORT_HANGAR_SAFECRACK", undefined, "safecrack_safe", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_safecrack_cs";
    s.activity_bundle = "saw_activity_bongo_safecrack";
    s.name = "IND_OFFICE_SAFECRACK";
    fe [[ f ]]( s, us, cf, ( 38635.7, -43715.5, 879.32 ), ( 0, 59.78, 0 ), "activity_nexus_variant", "IND_OFFICE_SAFECRACK", undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_safecrack_cs";
    s.name = "IND_OFFICE_SAFE";
    fe [[ f ]]( s, us, cf, ( 38129.6, -43771.4, 725.25 ), ( 0, 317.89, 0 ), "IND_OFFICE_SAFECRACK", undefined, "safecrack_safe", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_safecrack_cs";
    s.activity_bundle = "saw_activity_bongo_safecrack";
    s.name = "SHIPYARD_OFFICE_SAFECRACK";
    fe [[ f ]]( s, us, cf, ( 20475.8, -52261.5, 79.82 ), ( 0, 235.93, 0 ), "activity_nexus_variant", "SHIPYARD_OFFICE_SAFECRACK", undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_safecrack_cs";
    s.name = "SHIPYARD_OFFICE_SAFE";
    fe [[ f ]]( s, us, cf, ( 20366.5, -52254.1, 79.25 ), ( 0, 310.59, 0 ), "SHIPYARD_OFFICE_SAFECRACK", undefined, "safecrack_safe", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_safecrack_cs";
    s.activity_bundle = "saw_activity_bongo_safecrack";
    s.name = "SUPPORT_TRANSFOMERS_SAFECRACK";
    fe [[ f ]]( s, us, cf, ( 21799.7, -22445.2, 398.57 ), ( 0, 171.63, 0 ), "activity_nexus_variant", "SUPPORT_TRANSFOMERS_SAFECRACK", undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_safecrack_cs";
    s.name = "SUPPORT_TRANSFOMERS_SAFE";
    fe [[ f ]]( s, us, cf, ( 21636.7, -22496.4, 383 ), ( 0, 66.29, 0 ), "SUPPORT_TRANSFOMERS_SAFECRACK", undefined, "safecrack_safe", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_safecrack_cs";
    s.activity_bundle = "saw_activity_bongo_safecrack";
    s.name = "WAREHOUSE_SAFECRACK";
    fe [[ f ]]( s, us, cf, ( 32335.1, -9607.56, 307.07 ), ( 0, 107.52, 0 ), "activity_nexus_variant", "WAREHOUSE_SAFECRACK", undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_safecrack_cs";
    s.name = "WAREHOUSE_SAFE";
    fe [[ f ]]( s, us, cf, ( 32482.8, -9594.86, 304 ), ( 0, 180, 0 ), "WAREHOUSE_SAFECRACK", undefined, "safecrack_safe", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_safecrack_cs";
    s.activity_bundle = "saw_activity_bongo_safecrack";
    s.name = "WATER_TREATMENT_SAFECRACK";
    fe [[ f ]]( s, us, cf, ( 47053.2, -11472.9, 459.57 ), ( 0, 180.34, 0 ), "activity_nexus_variant", "WATER_TREATMENT_SAFECRACK", undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_safecrack_cs";
    s.name = "WATER_TREATMENT_SAFE";
    fe [[ f ]]( s, us, cf, ( 46802.5, -11611.5, 441 ), ( 0, 3, 0 ), "WATER_TREATMENT_SAFECRACK", undefined, "safecrack_safe", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_safecrack_cs";
    s.activity_bundle = "saw_activity_bongo_safecrack";
    s.name = "CARFACTORY_02_SAFECRACK";
    fe [[ f ]]( s, us, cf, ( 50318.2, -37534.9, 2218.42 ), ( 0, 180.34, 0 ), "activity_nexus_variant", "CARFACTORY_02_SAFECRACK", undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_safecrack_cs";
    s.name = "CARFACTORY_02_SAFE";
    fe [[ f ]]( s, us, cf, ( 50318.2, -37534.9, 2151 ), ( 0, 134.97, 0 ), "CARFACTORY_02_SAFECRACK", undefined, "safecrack_safe", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_safecrack_cs";
    s.activity_bundle = "saw_activity_bongo_safecrack";
    s.name = "FIRING_RANGE_03_SAFECRACK";
    fe [[ f ]]( s, us, cf, ( -30008.1, -32753.6, 964.08 ), ( 0, 180.34, 0 ), "activity_nexus_variant", "FIRING_RANGE_03_SAFECRACK", undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_safecrack_cs";
    s.name = "FIRING_RANGE_03_SAFE";
    fe [[ f ]]( s, us, cf, ( -30008.1, -32753.6, 900 ), ( 0, 139.6, 0 ), "FIRING_RANGE_03_SAFECRACK", undefined, "safecrack_safe", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_safecrack_cs";
    s.activity_bundle = "saw_activity_bongo_safecrack";
    s.name = "WINERY_SAFECRACK";
    fe [[ f ]]( s, us, cf, ( 18011.6, 47306.1, 1018.36 ), ( 0, 180.34, 0 ), "activity_nexus_variant", "WINERY_SAFECRACK", undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_safecrack_cs";
    s.name = "WINERY_SAFE";
    fe [[ f ]]( s, us, cf, ( 18011.6, 47306.1, 951.75 ), ( 0, 6.9, 0 ), "WINERY_SAFECRACK", undefined, "safecrack_safe", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_safecrack_cs";
    s.activity_bundle = "saw_activity_bongo_safecrack";
    s.name = "LOWTOWN_06_SAFECRACK";
    fe [[ f ]]( s, us, cf, ( -5087.52, -3188.96, 601.13 ), ( 0, 180.34, 0 ), "activity_nexus_variant", "LOWTOWN_06_SAFECRACK", undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_safecrack_cs";
    s.name = "LOWTOWN_06_SAFE";
    fe [[ f ]]( s, us, cf, ( -5087.52, -3188.96, 536.38 ), ( 0, 90, 0 ), "LOWTOWN_06_SAFECRACK", undefined, "safecrack_safe", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_safecrack_cs";
    s.activity_bundle = "saw_activity_bongo_safecrack";
    s.name = "LOWTOWN_07_SAFECRACK";
    fe [[ f ]]( s, us, cf, ( 1226.43, -633.02, 807.75 ), ( 0, 180.34, 0 ), "activity_nexus_variant", "LOWTOWN_07_SAFECRACK", undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_safecrack_cs";
    s.name = "LOWTOWN_07_SAFE";
    fe [[ f ]]( s, us, cf, ( 1226.43, -633.02, 744 ), ( 0, 241.2, 0 ), "LOWTOWN_07_SAFECRACK", undefined, "safecrack_safe", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_safecrack_cs";
    s.activity_bundle = "saw_activity_bongo_safecrack";
    s.name = "LOWTOWN_08_SAFECRACK";
    fe [[ f ]]( s, us, cf, ( 8840.03, -391.81, 809.45 ), ( 0, 180.34, 0 ), "activity_nexus_variant", "LOWTOWN_08_SAFECRACK", undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_safecrack_cs";
    s.name = "LOWTOWN_08_SAFE";
    fe [[ f ]]( s, us, cf, ( 8840.03, -391.81, 744 ), ( 0, 47.5, 0 ), "LOWTOWN_08_SAFECRACK", undefined, "safecrack_safe", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_safecrack_cs";
    s.activity_bundle = "saw_activity_bongo_safecrack";
    s.name = "GOLF_COURSE_MAIN_SAFECRACK";
    fe [[ f ]]( s, us, cf, ( -33416.6, 37046.4, 2437.8 ), ( 0, 180.34, 0 ), "activity_nexus_variant", "GOLF_COURSE_MAIN_SAFECRACK", undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_safecrack_cs";
    s.name = "GOLF_COURSE_MAIN_SAFE";
    fe [[ f ]]( s, us, cf, ( -33416.6, 37046.4, 2370 ), ( 0, 225.38, 0 ), "GOLF_COURSE_MAIN_SAFECRACK", undefined, "safecrack_safe", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_safecrack_cs";
    s.activity_bundle = "saw_activity_bongo_safecrack";
    s.name = "TENNISCLUB_SAFECRACK";
    fe [[ f ]]( s, us, cf, ( -20133.4, 41058.7, 1670.47 ), ( 0, 124.7, 0 ), "activity_nexus_variant", "TENNISCLUB_SAFECRACK", undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_safecrack_cs";
    s.name = "TENNISCLUB_SAFE";
    fe [[ f ]]( s, us, cf, ( -20133.4, 41058.7, 1603.07 ), ( 0, 124.7, 0 ), "TENNISCLUB_SAFECRACK", undefined, "safecrack_safe", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_safecrack_cs";
    s.activity_bundle = "saw_activity_bongo_safecrack";
    s.name = "PIER_01_SAFECRACK";
    fe [[ f ]]( s, us, cf, ( -5150.62, -20488.3, 126 ), ( 0, 194.04, 0 ), "activity_nexus_variant", "PIER_01_SAFECRACK", undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_safecrack_cs";
    s.name = "PIER_01_SAFE";
    fe [[ f ]]( s, us, cf, ( -5150.62, -20488.3, 126 ), ( 0, 358.7, 0 ), "PIER_01_SAFECRACK", undefined, "safecrack_safe", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_safecrack_cs";
    s.activity_bundle = "saw_activity_bongo_safecrack";
    s.name = "PIER_02_SAFECRACK";
    fe [[ f ]]( s, us, cf, ( 2490.23, -20636.3, 951.32 ), ( 0, 284.04, 0 ), "activity_nexus_variant", "PIER_02_SAFECRACK", undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_safecrack_cs";
    s.name = "PIER_02_SAFE";
    fe [[ f ]]( s, us, cf, ( 2490.23, -20636.3, 884 ), ( 0, 88.7, 0 ), "PIER_02_SAFECRACK", undefined, "safecrack_safe", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_safecrack_cs";
    s.activity_bundle = "saw_activity_bongo_safecrack";
    s.name = "LISTENINGPOST_SAFECRACK";
    fe [[ f ]]( s, us, cf, ( -21136.8, -43099.2, 429.72 ), ( 0, 0, 0 ), "activity_nexus_variant", "LISTENINGPOST_SAFECRACK", undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_safecrack_cs";
    s.name = "LISTENINGPOST_SAFE";
    fe [[ f ]]( s, us, cf, ( -21136.8, -43099.2, 365.28 ), ( 0, 190.8, 0 ), "LISTENINGPOST_SAFECRACK", undefined, "safecrack_safe", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_safecrack_cs";
    s.activity_bundle = "saw_activity_bongo_safecrack";
    s.name = "PONYCLUB_SAFECRACK";
    fe [[ f ]]( s, us, cf, ( 30387.2, 49482, 1607.53 ), ( 0, 0, 0 ), "activity_nexus_variant", "PONYCLUB_SAFECRACK", undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_safecrack_cs";
    s.name = "PONYCLUB_SAFE";
    fe [[ f ]]( s, us, cf, ( 30387.2, 49482, 1528 ), ( 0, 91.5, 0 ), "PONYCLUB_SAFECRACK", undefined, "safecrack_safe", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_safecrack_cs";
    s.activity_bundle = "saw_activity_bongo_safecrack";
    s.name = "CHOP_SHOP_OFFICE_SAFECRACK";
    fe [[ f ]]( s, us, cf, ( 2697.87, -44164.6, 318 ), ( 0, 151.8, 0 ), "activity_nexus_variant", "CHOP_SHOP_OFFICE_SAFECRACK", undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_safecrack_cs";
    s.name = "CHOP_SHOP_OFFICE_SAFE";
    fe [[ f ]]( s, us, cf, ( 2697.87, -44164.6, 248 ), ( 0, 151.8, 0 ), "CHOP_SHOP_OFFICE_SAFECRACK", undefined, "safecrack_safe", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 3900 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_safecrack_cs";
    s.activity_bundle = "saw_activity_bongo_safecrack";
    s.name = "HELIPORT_OFFICE_SAFECRACK";
    fe [[ f ]]( s, us, cf, ( 27866.9, -25418.4, 242.32 ), ( 0, 72.5, 0 ), "activity_nexus_variant", "HELIPORT_OFFICE_SAFECRACK", undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_safecrack_cs";
    s.name = "HELIPORT_OFFICE_SAFE";
    fe [[ f ]]( s, us, cf, ( 27985.9, -25486.4, 241 ), ( 0, 146, 0 ), "HELIPORT_OFFICE_SAFECRACK", undefined, "safecrack_safe", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 3900 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_safecrack_cs";
    s.activity_bundle = "saw_activity_bongo_safecrack";
    s.name = "HELIPORT_POLICE_SAFECRACK";
    fe [[ f ]]( s, us, cf, ( 27088.6, -14211.9, 415 ), ( 0, 356.7, 0 ), "activity_nexus_variant", "HELIPORT_POLICE_SAFECRACK", undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_safecrack_cs";
    s.name = "HELIPORT_POLICE_SAFE";
    fe [[ f ]]( s, us, cf, ( 27088.6, -14211.9, 322.8 ), ( 0, 52.7, 0 ), "HELIPORT_POLICE_SAFECRACK", undefined, "safecrack_safe", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 3900 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_safecrack_cs";
    s.activity_bundle = "saw_activity_bongo_safecrack";
    s.name = "HELIPORT_RUINS_SAFECRACK";
    fe [[ f ]]( s, us, cf, ( 16811.6, -7164.9, 3492.64 ), ( 0, 353.5, 0 ), "activity_nexus_variant", "HELIPORT_RUINS_SAFECRACK", undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_safecrack_cs";
    s.name = "HELIPORT_RUINS_SAFE";
    fe [[ f ]]( s, us, cf, ( 16811.6, -7164.9, 3399.04 ), ( 0, 49.5, 0 ), "HELIPORT_RUINS_SAFECRACK", undefined, "safecrack_safe", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 3900 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_safecrack_cs";
    s.activity_bundle = "saw_activity_bongo_safecrack";
    s.name = "HELIPORT_TERMINAL_SAFECRACK";
    fe [[ f ]]( s, us, cf, ( 30007.9, -18264.4, 344 ), ( 0, 90, 0 ), "activity_nexus_variant", "HELIPORT_TERMINAL_SAFECRACK", undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_safecrack_cs";
    s.name = "HELIPORT_TERMINAL_SAFE";
    fe [[ f ]]( s, us, cf, ( 30007.9, -18264.4, 272 ), ( 0, 146, 0 ), "HELIPORT_TERMINAL_SAFECRACK", undefined, "safecrack_safe", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 3900 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_safecrack_cs";
    s.name = "HIGHTOWN_BOAT_SAFE";
    fe [[ f ]]( s, us, cf, ( -24608.3, -2168.49, 273 ), ( 0, 215.1, 0 ), "HIGHTOWN_BOAT_SAFECRACK", undefined, "safecrack_safe", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 3900 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_safecrack_cs";
    s.activity_bundle = "saw_activity_bongo_safecrack";
    s.name = "HIGHTOWN_BOAT_SAFECRACK";
    fe [[ f ]]( s, us, cf, ( -24608.3, -2168.49, 348 ), ( 0, 35.44, 0 ), "activity_nexus_variant", "HIGHTOWN_BOAT_SAFECRACK", undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_safecrack_cs";
    s.activity_bundle = "saw_activity_bongo_safecrack";
    s.name = "LOWTOWN_09_SAFECRACK";
    fe [[ f ]]( s, us, cf, ( 7926.03, -10559.8, 2039 ), ( 0, 104.34, 0 ), "activity_nexus_variant", "LOWTOWN_09_SAFECRACK", undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_safecrack_cs";
    s.name = "LOWTOWN_09_SAFE";
    fe [[ f ]]( s, us, cf, ( 7926.03, -10559.8, 1970 ), ( 0, 331.5, 0 ), "LOWTOWN_09_SAFECRACK", undefined, "safecrack_safe", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 3900 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_safecrack_cs";
    s.name = "NICE_ANTENNA1_SAFE";
    fe [[ f ]]( s, us, cf, ( 10491.9, -30574.4, 4220 ), ( 0, 57.1, 0 ), "NICE_ANTENNA1_SAFECRACK", undefined, "safecrack_safe", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 3900 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_safecrack_cs";
    s.activity_bundle = "saw_activity_bongo_safecrack";
    s.name = "NICE_ANTENNA1_SAFECRACK";
    fe [[ f ]]( s, us, cf, ( 10491.9, -30574.4, 4291 ), ( 0, 57.1, 0 ), "activity_nexus_variant", "NICE_ANTENNA1_SAFECRACK", undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_safecrack_cs";
    s.name = "NICE_ANTENNA2_SAFE";
    fe [[ f ]]( s, us, cf, ( 12254.9, -29139.4, 4053.28 ), ( 0, 300.7, 0 ), "NICE_ANTENNA2_SAFECRACK", undefined, "safecrack_safe", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 3900 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_safecrack_cs";
    s.activity_bundle = "saw_activity_bongo_safecrack";
    s.name = "NICE_ANTENNA2_SAFECRACK";
    fe [[ f ]]( s, us, cf, ( 12254.9, -29139.4, 4124 ), ( 0, 300.7, 0 ), "activity_nexus_variant", "NICE_ANTENNA2_SAFECRACK", undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_safecrack_cs";
    s.name = "NICE_FIRE_SAFE";
    fe [[ f ]]( s, us, cf, ( -3835.1, -29335.4, 292 ), ( 0, 180.2, 0 ), "NICE_FIRE_SAFECRACK", undefined, "safecrack_safe", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 3900 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_safecrack_cs";
    s.activity_bundle = "saw_activity_bongo_safecrack";
    s.name = "NICE_FIRE_SAFECRACK";
    fe [[ f ]]( s, us, cf, ( -3835.1, -29335.4, 368 ), ( 0, 178.19, 0 ), "activity_nexus_variant", "NICE_FIRE_SAFECRACK", undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_safecrack_cs";
    s.name = "NICE_GAS_SAFE";
    fe [[ f ]]( s, us, cf, ( -681.58, -32488.1, 297 ), ( 0, 282.2, 0 ), "NICE_GAS_SAFECRACK", undefined, "safecrack_safe", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 3900 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_safecrack_cs";
    s.activity_bundle = "saw_activity_bongo_safecrack";
    s.name = "NICE_GAS_SAFECRACK";
    fe [[ f ]]( s, us, cf, ( -681.58, -32488.1, 368 ), ( 0, 280.19, 0 ), "activity_nexus_variant", "NICE_GAS_SAFECRACK", undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_safecrack_cs";
    s.name = "NICE_OFFICE1_SAFE";
    fe [[ f ]]( s, us, cf, ( 2990.42, -29225.1, 1354.25 ), ( 0, 22, 0 ), "NICE_OFFICE1_SAFECRACK", undefined, "safecrack_safe", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 3900 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_safecrack_cs";
    s.activity_bundle = "saw_activity_bongo_safecrack";
    s.name = "NICE_OFFICE1_SAFECRACK";
    fe [[ f ]]( s, us, cf, ( 3025.72, -29285.8, 1367.5 ), ( 0, 19.99, 0 ), "activity_nexus_variant", "NICE_OFFICE1_SAFECRACK", undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_safecrack_cs";
    s.name = "NICE_OFFICE2_SAFE";
    fe [[ f ]]( s, us, cf, ( 4927.9, -27331.4, 1858 ), ( 0, 338, 0 ), "NICE_OFFICE2_SAFECRACK", undefined, "safecrack_safe", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 3900 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_safecrack_cs";
    s.activity_bundle = "saw_activity_bongo_safecrack";
    s.name = "NICE_OFFICE2_SAFECRACK";
    fe [[ f ]]( s, us, cf, ( 4927.9, -27331.4, 1928 ), ( 0, 338, 0 ), "activity_nexus_variant", "NICE_OFFICE2_SAFECRACK", undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_safecrack_cs";
    s.name = "NICE_SHOP_SAFE";
    fe [[ f ]]( s, us, cf, ( 19985.1, -36969.6, 456 ), ( 0, 170, 0 ), "NICE_SHOP_SAFECRACK", undefined, "safecrack_safe", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 3900 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_safecrack_cs";
    s.activity_bundle = "saw_activity_bongo_safecrack";
    s.name = "NICE_SHOP_SAFECRACK";
    fe [[ f ]]( s, us, cf, ( 19985.1, -36969.6, 532 ), ( 0, 170, 0 ), "activity_nexus_variant", "NICE_SHOP_SAFECRACK", undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_safecrack_cs";
    s.activity_bundle = "saw_activity_bongo_safecrack";
    s.name = "PIER_03_SAFECRACK";
    fe [[ f ]]( s, us, cf, ( 6614.23, -17566.3, 1168 ), ( 0, 354.54, 0 ), "activity_nexus_variant", "PIER_03_SAFECRACK", undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_safecrack_cs";
    s.name = "PIER_03_SAFE";
    fe [[ f ]]( s, us, cf, ( 6614.23, -17566.3, 1086 ), ( 0, 159.2, 0 ), "PIER_03_SAFECRACK", undefined, "safecrack_safe", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 3900 );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace mp_saw_avalon_bongo_safecrack_cs
// Params 0, eflags: 0x4
// Checksum 0xc68f1d06, Offset: 0x4c9a
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace mp_saw_avalon_bongo_safecrack_cs
// Params 0
// Checksum 0xd8b237e3, Offset: 0x4ca4
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "mp_saw_avalon_bongo_safecrack_cs" );
}

