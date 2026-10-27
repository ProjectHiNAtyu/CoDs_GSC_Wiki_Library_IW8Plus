// script_273ab04f185496fe  (hash_273ab04f185496fe.gscc) (size: 26480 Bytes / 0x6770 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xb0eb9e59 (2968231513)
// size ...... 26480 (0x6770)
// includes .. 4   (offset: 0x57f8)
// strings ... 89  (offset: 0x5818)
// dev strs .. 0   (offset: 0x6770)
// exports ... 15  (offset: 0x5284)
// cseg ...... 0xaee + 0x4796 (0x5284)
// imports ... 28  (offset: 0x54dc)
// animtree1 . 0   (offset: 0x6770)
// animtree2 . 0   (offset: 0x6770)
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace mp_sat_avalon_city_ob_activity_supply_drop_cs;

// Namespace mp_sat_avalon_city_ob_activity_supply_drop_cs
// Params 0, eflags: 0x5
// Checksum 0xe6507666, Offset: 0xb0c
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"mp_sat_avalon_city_ob_activity_supply_drop_cs", #"activity_common", &function_b39ecd3d51489472, undefined );
}

// Namespace mp_sat_avalon_city_ob_activity_supply_drop_cs
// Params 0, eflags: 0x4
// Checksum 0x1752951b, Offset: 0xb35
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace mp_sat_avalon_city_ob_activity_supply_drop_cs
// Params 0, eflags: 0x4
// Checksum 0x926946f7, Offset: 0xb46
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace mp_sat_avalon_city_ob_activity_supply_drop_cs
// Params 2
// Checksum 0xd400dfe2, Offset: 0xb57
// Size: 0x8c
function main( unused, unused2 )
{
    if ( utility::flag_exist( "mp_sat_avalon_city_ob_activity_supply_drop_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "mp_sat_avalon_city_ob_activity_supply_drop_cs" ) )
    {
        return;
    }
    
    activity_common::function_e1df676808c1d1e3( &function_4cd78e661617f3 );
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "mp_sat_avalon_city_ob_activity_supply_drop_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "mp_sat_avalon_city_ob_activity_supply_drop_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace mp_sat_avalon_city_ob_activity_supply_drop_cs
// Params 3, eflags: 0x4
// Checksum 0x11ebf238, Offset: 0xbeb
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "mp_sat_avalon_city_ob_activity_supply_drop_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "mp_sat_avalon_city_ob_activity_supply_drop_cs" );
}

// Namespace mp_sat_avalon_city_ob_activity_supply_drop_cs
// Params 3, eflags: 0x4
// Checksum 0xd91f41fb, Offset: 0xc65
// Size: 0x37b2
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_supply_drop_cs";
    fe [[ f ]]( s, "SUPPLY_DROP_CITY_LOW_TOWN_POLICESTATION", cf, ( 29077.2, -1478.73, 471.12 ), ( 0, 335, 0 ), "activity_nexus_spatial_zone", undefined, "Ambient_AI_Exclusion_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 1500 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_supply_drop_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_DROP_CITY_LOW_TOWN_POLICESTATION", cf, ( 29080.7, -1676.27, 419.56 ), ( 0, 0, 0 ), "cspf_1_auto13576561252421795455", "cspf_1_auto13459999378435873298", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_supply_drop_cs";
    s.loop_route = "1";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.start_point = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_DROP_CITY_LOW_TOWN_POLICESTATION", cf, ( 29343.7, -1733.06, 409.21 ), ( 0, 0, 0 ), "cspf_1_auto14027782669160426554", "cspf_1_auto13576561252421795455", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_supply_drop_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_DROP_CITY_LOW_TOWN_POLICESTATION", cf, ( 29093.4, -1619.21, 437.93 ), ( 0, 0, 0 ), "cspf_1_auto13459999378435873298", "cspf_1_auto13943673395761252019", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_supply_drop_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_DROP_CITY_LOW_TOWN_POLICESTATION", cf, ( 29637.5, -1735.98, 406.72 ), ( 0, 0, 0 ), "cspf_1_auto13943673395761252019", "cspf_1_auto744771535794045736", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_supply_drop_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_DROP_CITY_LOW_TOWN_POLICESTATION", cf, ( 29624.8, -1788.89, 407.49 ), ( 0, 0, 0 ), "cspf_1_auto744771535794045736", "cspf_1_auto14027782669160426554", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_supply_drop_cs";
    s.activity_bundle = "sat_activitydefinition_supply_drop";
    s.name = "SUPPLY_DROP_CITY_LOW_TOWN_POLICESTATION";
    fe [[ f ]]( s, "SUPPLY_DROP_CITY_LOW_TOWN_POLICESTATION", cf, ( 28967.1, -1557.97, 470.37 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_supply_drop_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "supply_drop_long";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "SUPPLY_DROP_CITY_LOW_TOWN_POLICESTATION", cf, ( 28637.7, -2516.45, 418.42 ), ( 0, 346.5, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_supply_drop_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "supply_drop_long";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "SUPPLY_DROP_CITY_LOW_TOWN_POLICESTATION", cf, ( 29304, -1815.02, 409.13 ), ( 0, 54.45, 0 ), undefined, "cspf_1_auto14027782669160426554", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_supply_drop_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "supply_drop_rusher";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "SUPPLY_DROP_CITY_LOW_TOWN_POLICESTATION", cf, ( 29107.4, -2587.59, 349.05 ), ( 0, 191.27, 0 ), undefined, "cspf_1_auto7863255434848741536", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_supply_drop_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "supply_drop_rusher";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "SUPPLY_DROP_CITY_LOW_TOWN_POLICESTATION", cf, ( 28429.7, -2175.75, 467.46 ), ( 0, 178.98, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_supply_drop_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "supply_drop_long";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "SUPPLY_DROP_CITY_LOW_TOWN_POLICESTATION", cf, ( 29046.8, -1813.78, 409.19 ), ( 0, 232.51, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_supply_drop_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "supply_drop_rusher";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "SUPPLY_DROP_CITY_LOW_TOWN_POLICESTATION", cf, ( 28636.3, -1926.66, 471.5 ), ( 0, 96.14, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_supply_drop_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_DROP_CITY_LOW_TOWN_POLICESTATION", cf, ( 29060.7, -2616.18, 351.97 ), ( 0, 0, 0 ), "cspf_1_auto128738927465479950", "cspf_1_auto7863255434848741536", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_supply_drop_cs";
    s.loop_route = "1";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.start_point = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_DROP_CITY_LOW_TOWN_POLICESTATION", cf, ( 29068, -2549, 357 ), ( 0, 0, 0 ), "cspf_1_auto7863255434848741536", "cspf_1_auto5602386061416102952", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_supply_drop_cs";
    s.groupid = "reinforcement_spawn_point";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "supply_drop_heli";
    s.variantname = "ai_encounter_spawnpoint";
    s.var_4501e0172e168ddf = "SUPPLY_DROP_CITY_LOW_TOWN_POLICESTATION_VTOL";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "SUPPLY_DROP_CITY_LOW_TOWN_POLICESTATION", cf, ( 28870.5, -1651.99, 475.34 ), ( 0, 186.87, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_supply_drop_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_DROP_CITY_LOW_TOWN_POLICESTATION", cf, ( 28702.2, -2578.44, 422.87 ), ( 0, 0, 0 ), "cspf_1_auto10681418607637842753", "cspf_1_auto128738927465479950", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_supply_drop_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_DROP_CITY_LOW_TOWN_POLICESTATION", cf, ( 28693.1, -2508.79, 415.14 ), ( 0, 0, 0 ), "cspf_1_auto5602386061416102952", "cspf_1_auto10681418607637842753", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_supply_drop_cs";
    s.activity_bundle = "sat_activitydefinition_supply_drop";
    s.name = "SUPPLY_DROP_CITY_LOW_TOWN_TOWNHALL";
    fe [[ f ]]( s, "SUPPLY_DROP_CITY_LOW_TOWN_TOWNHALL", cf, ( -16394.3, -5974.78, 402.75 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_supply_drop_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "supply_drop_long";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "SUPPLY_DROP_CITY_LOW_TOWN_TOWNHALL", cf, ( -16485.5, -5529.03, 404.42 ), ( 0, 132.69, 0 ), undefined, "cspf_2_auto17384173139011041851", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_supply_drop_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "supply_drop_long";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "SUPPLY_DROP_CITY_LOW_TOWN_TOWNHALL", cf, ( -16287.1, -5663.04, 388.95 ), ( 0, 339.71, 0 ), undefined, "cspf_2_auto16065411393292987581", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_supply_drop_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "supply_drop_rusher";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "SUPPLY_DROP_CITY_LOW_TOWN_TOWNHALL", cf, ( -16783, -5758.28, 376.52 ), ( 0, 348.85, 0 ), undefined, "cspf_2_auto4498263017193859355", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_supply_drop_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "supply_drop_rusher";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "SUPPLY_DROP_CITY_LOW_TOWN_TOWNHALL", cf, ( -16315.2, -6232.74, 408.77 ), ( 0, 188.13, 0 ), undefined, "cspf_2_auto13745723010168523717", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_supply_drop_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "supply_drop_long";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "SUPPLY_DROP_CITY_LOW_TOWN_TOWNHALL", cf, ( -16633.4, -5698.01, 402.87 ), ( 0, 347.03, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_supply_drop_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "supply_drop_rusher";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "SUPPLY_DROP_CITY_LOW_TOWN_TOWNHALL", cf, ( -16860.1, -5915.79, 382.95 ), ( 0, 138.27, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_supply_drop_cs";
    fe [[ f ]]( s, "SUPPLY_DROP_CITY_LOW_TOWN_TOWNHALL", cf, ( -16427.6, -5960.43, 389.33 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Ambient_AI_Exclusion_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 1200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_supply_drop_cs";
    s.loop_route = "1";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.start_point = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_DROP_CITY_LOW_TOWN_TOWNHALL", cf, ( -16704.9, -5793.16, 387.77 ), ( 0, 0, 0 ), "cspf_2_auto4498263017193859355", "cspf_2_auto6752773150449237546", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_supply_drop_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_DROP_CITY_LOW_TOWN_TOWNHALL", cf, ( -16413.3, -6065.44, 394.12 ), ( 0, 0, 0 ), "cspf_2_auto6752773150449237546", "cspf_2_auto10693424730894570768", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_supply_drop_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_DROP_CITY_LOW_TOWN_TOWNHALL", cf, ( -16153.5, -6237.25, 363.9 ), ( 0, 0, 0 ), "cspf_2_auto10693424730894570768", "cspf_2_auto13225192212377419338", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_supply_drop_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_DROP_CITY_LOW_TOWN_TOWNHALL", cf, ( -15855.7, -6363.55, 333.65 ), ( 0, 0, 0 ), "cspf_2_auto13225192212377419338", "cspf_2_auto17129870086089515827", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_supply_drop_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_DROP_CITY_LOW_TOWN_TOWNHALL", cf, ( -15867.6, -6395.2, 340.03 ), ( 0, 0, 0 ), "cspf_2_auto17129870086089515827", "cspf_2_auto5255028337952616787", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_supply_drop_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_DROP_CITY_LOW_TOWN_TOWNHALL", cf, ( -16164.9, -6271.38, 371.47 ), ( 0, 0, 0 ), "cspf_2_auto5255028337952616787", "cspf_2_auto8469151274107451945", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_supply_drop_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_DROP_CITY_LOW_TOWN_TOWNHALL", cf, ( -16439.2, -6095.6, 402.8 ), ( 0, 0, 0 ), "cspf_2_auto8469151274107451945", "cspf_2_auto15102551607452503038", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_supply_drop_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_DROP_CITY_LOW_TOWN_TOWNHALL", cf, ( -16732.1, -5824.1, 388.83 ), ( 0, 0, 0 ), "cspf_2_auto15102551607452503038", "cspf_2_auto4498263017193859355", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_supply_drop_cs";
    s.loop_route = "1";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.start_point = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_DROP_CITY_LOW_TOWN_TOWNHALL", cf, ( -16579.4, -5476.52, 411.74 ), ( 0, 0, 0 ), "cspf_2_auto17384173139011041851", "cspf_2_auto17104654685431678638", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_supply_drop_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_DROP_CITY_LOW_TOWN_TOWNHALL", cf, ( -16779, -5258.82, 434.62 ), ( 0, 0, 0 ), "cspf_2_auto17104654685431678638", "cspf_2_auto15960641645454661323", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_supply_drop_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_DROP_CITY_LOW_TOWN_TOWNHALL", cf, ( -16805.4, -5284.68, 433.87 ), ( 0, 0, 0 ), "cspf_2_auto15960641645454661323", "cspf_2_auto17804454491137698851", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_supply_drop_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_DROP_CITY_LOW_TOWN_TOWNHALL", cf, ( -16609.2, -5501.33, 411.5 ), ( 0, 0, 0 ), "cspf_2_auto17804454491137698851", "cspf_2_auto17384173139011041851", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_supply_drop_cs";
    s.loop_route = "1";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.start_point = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_DROP_CITY_LOW_TOWN_TOWNHALL", cf, ( -16224.9, -5698, 381.85 ), ( 0, 0, 0 ), "cspf_2_auto16065411393292987581", "cspf_2_auto5639217025468135643", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_supply_drop_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_DROP_CITY_LOW_TOWN_TOWNHALL", cf, ( -16241.9, -5722.66, 382.08 ), ( 0, 0, 0 ), "cspf_2_auto7258399695140744366", "cspf_2_auto16065411393292987581", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_supply_drop_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_DROP_CITY_LOW_TOWN_TOWNHALL", cf, ( -15971.9, -5860.92, 356.64 ), ( 0, 0, 0 ), "cspf_2_auto5639217025468135643", "cspf_2_auto15935481181802412322", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_supply_drop_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_DROP_CITY_LOW_TOWN_TOWNHALL", cf, ( -15986.9, -5891.08, 356.92 ), ( 0, 0, 0 ), "cspf_2_auto15935481181802412322", "cspf_2_auto7258399695140744366", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_supply_drop_cs";
    s.groupid = "reinforcement_spawn_point";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "supply_drop_heli";
    s.variantname = "ai_encounter_spawnpoint";
    s.var_4501e0172e168ddf = "SUPPLY_DROP_CITY_LOW_TOWN_TOWNHALL_VTOL";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "SUPPLY_DROP_CITY_LOW_TOWN_TOWNHALL", cf, ( -16493.6, -6142.57, 413.45 ), ( 0, 341.37, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_supply_drop_cs";
    s.loop_route = "1";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.start_point = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_DROP_CITY_LOW_TOWN_TOWNHALL", cf, ( -16409.9, -6239.46, 412.01 ), ( 0, 0, 0 ), "cspf_2_auto13745723010168523717", "cspf_2_auto16332249259040472792", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_supply_drop_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_DROP_CITY_LOW_TOWN_TOWNHALL", cf, ( -16540.8, -6121.47, 412.15 ), ( 0, 0, 0 ), "cspf_2_auto16332249259040472792", "cspf_2_auto5257359776437806689", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_supply_drop_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_DROP_CITY_LOW_TOWN_TOWNHALL", cf, ( -16567.6, -6150.75, 416.2 ), ( 0, 0, 0 ), "cspf_2_auto5257359776437806689", "cspf_2_auto5068143270024077724", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_supply_drop_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_DROP_CITY_LOW_TOWN_TOWNHALL", cf, ( -16436.8, -6264.92, 418.72 ), ( 0, 0, 0 ), "cspf_2_auto5068143270024077724", "cspf_2_auto13745723010168523717", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_supply_drop_cs";
    s.activity_bundle = "sat_activitydefinition_supply_drop";
    s.name = "SUPPLY_DROP_CITY_LOW_TOWN_FIRESTATION";
    fe [[ f ]]( s, "SUPPLY_DROP_CITY_LOW_TOWN_FIRESTATION", cf, ( 16169.6, -9445.5, 3480.5 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_supply_drop_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "supply_drop_long";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "SUPPLY_DROP_CITY_LOW_TOWN_FIRESTATION", cf, ( 15896.3, -8984.08, 3461.84 ), ( 0, 298.26, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_supply_drop_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "supply_drop_long";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "SUPPLY_DROP_CITY_LOW_TOWN_FIRESTATION", cf, ( 16590.3, -9439.58, 3474.41 ), ( 0, 187.86, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_supply_drop_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "supply_drop_rusher";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "SUPPLY_DROP_CITY_LOW_TOWN_FIRESTATION", cf, ( 16373.4, -9072.88, 3473.42 ), ( 0, 279.35, 0 ), undefined, "cspf_3_auto7677905597363888864", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_supply_drop_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "supply_drop_rusher";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "SUPPLY_DROP_CITY_LOW_TOWN_FIRESTATION", cf, ( 16348.2, -9633.67, 3474.56 ), ( 0, 76.13, 0 ), undefined, "cspf_3_auto1009552867772803616", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_supply_drop_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "supply_drop_long";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "SUPPLY_DROP_CITY_LOW_TOWN_FIRESTATION", cf, ( 15808.6, -9493.45, 3478.91 ), ( 0, 277.53, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_supply_drop_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "supply_drop_rusher";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "SUPPLY_DROP_CITY_LOW_TOWN_FIRESTATION", cf, ( 16133.6, -9923.9, 3464.08 ), ( 0, 117.27, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_supply_drop_cs";
    s.loop_route = "1";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.start_point = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_DROP_CITY_LOW_TOWN_FIRESTATION", cf, ( 16363.4, -9520.5, 3473.79 ), ( 0, 0, 0 ), "cspf_3_auto1009552867772803616", "cspf_3_auto1107560009578638557", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_supply_drop_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_DROP_CITY_LOW_TOWN_FIRESTATION", cf, ( 16402.1, -9538.64, 3475.88 ), ( 0, 0, 0 ), "cspf_3_auto805238206220420486", "cspf_3_auto1009552867772803616", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_supply_drop_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_DROP_CITY_LOW_TOWN_FIRESTATION", cf, ( 16525.9, -9217.33, 3472.95 ), ( 0, 0, 0 ), "cspf_3_auto1107560009578638557", "cspf_3_auto12750090992649013389", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_supply_drop_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_DROP_CITY_LOW_TOWN_FIRESTATION", cf, ( 16565.2, -9230.33, 3472.85 ), ( 0, 0, 0 ), "cspf_3_auto371591273882690784", "cspf_3_auto805238206220420486", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_supply_drop_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_DROP_CITY_LOW_TOWN_FIRESTATION", cf, ( 16710, -8885.73, 3465.06 ), ( 0, 0, 0 ), "cspf_3_auto1195471566147773670", "cspf_3_auto371591273882690784", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_supply_drop_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_DROP_CITY_LOW_TOWN_FIRESTATION", cf, ( 16678.1, -8870.21, 3464.27 ), ( 0, 0, 0 ), "cspf_3_auto12750090992649013389", "cspf_3_auto1195471566147773670", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_supply_drop_cs";
    s.loop_route = "1";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.start_point = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_DROP_CITY_LOW_TOWN_FIRESTATION", cf, ( 16392, -9133.7, 3472.92 ), ( 0, 0, 0 ), "cspf_3_auto7677905597363888864", "cspf_3_auto873907901890451262", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_supply_drop_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_DROP_CITY_LOW_TOWN_FIRESTATION", cf, ( 16286.5, -9337.7, 3473.74 ), ( 0, 0, 0 ), "cspf_3_auto873907901890451262", "cspf_3_auto2894048018190155430", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_supply_drop_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_DROP_CITY_LOW_TOWN_FIRESTATION", cf, ( 16140.5, -9558.56, 3476.34 ), ( 0, 0, 0 ), "cspf_3_auto2894048018190155430", "cspf_3_auto7282906034847022444", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_supply_drop_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_DROP_CITY_LOW_TOWN_FIRESTATION", cf, ( 16016.2, -9679.46, 3478.46 ), ( 0, 0, 0 ), "cspf_3_auto7282906034847022444", "cspf_3_auto2487939067203699503", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_supply_drop_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_DROP_CITY_LOW_TOWN_FIRESTATION", cf, ( 15895.3, -9785.77, 3460.58 ), ( 0, 0, 0 ), "cspf_3_auto2487939067203699503", "cspf_3_auto6760107819445116942", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_supply_drop_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_DROP_CITY_LOW_TOWN_FIRESTATION", cf, ( 15929, -9810.04, 3461.61 ), ( 0, 0, 0 ), "cspf_3_auto6760107819445116942", "cspf_3_auto3017966028439235404", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_supply_drop_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_DROP_CITY_LOW_TOWN_FIRESTATION", cf, ( 16050.7, -9702.04, 3479.37 ), ( 0, 0, 0 ), "cspf_3_auto3017966028439235404", "cspf_3_auto18111206810983492978", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_supply_drop_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_DROP_CITY_LOW_TOWN_FIRESTATION", cf, ( 16179.7, -9580.8, 3475.91 ), ( 0, 0, 0 ), "cspf_3_auto18111206810983492978", "cspf_3_auto1372657453281915952", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_supply_drop_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_DROP_CITY_LOW_TOWN_FIRESTATION", cf, ( 16326.6, -9350.75, 3473.79 ), ( 0, 0, 0 ), "cspf_3_auto1372657453281915952", "cspf_3_auto1980738620799839530", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_supply_drop_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_DROP_CITY_LOW_TOWN_FIRESTATION", cf, ( 16433.6, -9147.47, 3472.96 ), ( 0, 0, 0 ), "cspf_3_auto1980738620799839530", "cspf_3_auto7677905597363888864", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_supply_drop_cs";
    fe [[ f ]]( s, "SUPPLY_DROP_CITY_LOW_TOWN_FIRESTATION", cf, ( 16115, -9466.12, 3480.86 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Ambient_AI_Exclusion_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 1800 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_supply_drop_cs";
    s.groupid = "reinforcement_spawn_point";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "supply_drop_heli";
    s.variantname = "ai_encounter_spawnpoint";
    s.var_4501e0172e168ddf = "SUPPLY_DROP_CITY_LOW_TOWN_FIRESTATION_VTOL";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "SUPPLY_DROP_CITY_LOW_TOWN_FIRESTATION", cf, ( 15975.7, -9657.56, 3471.41 ), ( 0, 331.96, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace mp_sat_avalon_city_ob_activity_supply_drop_cs
// Params 0, eflags: 0x4
// Checksum 0xc3846baf, Offset: 0x441f
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace mp_sat_avalon_city_ob_activity_supply_drop_cs
// Params 0
// Checksum 0xd3b82f75, Offset: 0x4429
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "mp_sat_avalon_city_ob_activity_supply_drop_cs" );
}

// Namespace mp_sat_avalon_city_ob_activity_supply_drop_cs
// Params 0
// Checksum 0x6cadaf6a, Offset: 0x443f
// Size: 0x66
function function_4cd78e661617f3()
{
    activityinfostruct = {};
    activityinfostruct.name = "REV_OB_SUPPLY_DROP";
    activityinfostruct.scriptbundle = "sat_activitydefinition_supply_drop";
    activityinfostruct.mainfunction = &main;
    activityinfostruct.var_934f068483ae4ddb = &function_d4323822d7042e5a;
    activityinfostruct.metadatafunction = &function_d9dd7965c51c95d1;
    return activityinfostruct;
}

// Namespace mp_sat_avalon_city_ob_activity_supply_drop_cs
// Params 4
// Checksum 0xeb035ac2, Offset: 0x44ae
// Size: 0x8b
function function_d4323822d7042e5a( var_4312b79c960726b6, fe, us, cf = "mp_sat_avalon_city_ob_activity_supply_drop_cs" )
{
    switch ( var_4312b79c960726b6 )
    {
        case #"hash_2131b40d2d35093":
            function_69bf37888d933b1b( fe, us, cf );
            break;
        case #"hash_859a0990bc2874c0":
            function_82a7a7b8dc66c348( fe, us, cf );
            break;
        case #"hash_9fc50f144b7eb331":
            function_3d55d06f11679b59( fe, us, cf );
            break;
    }
}

// Namespace mp_sat_avalon_city_ob_activity_supply_drop_cs
// Params 3
// Checksum 0x1f8272dd, Offset: 0x4541
// Size: 0x3c6
function function_69bf37888d933b1b( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_supply_drop_cs";
    s.name = "supply_drop_starter";
    fe [[ f ]]( s, "SUPPLY_DROP_CITY_LOW_TOWN_POLICESTATION", cf, ( 16384.4, 4155.65, 748.6 ), ( 0, 115.73, 0 ), undefined, "cspf_4_auto12189821597260913835", "SUPPLY_DROP_CITY_LOW_TOWN_POLICESTATION", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_supply_drop_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    s.script_accel = "350";
    fe [[ f ]]( s, "SUPPLY_DROP_CITY_LOW_TOWN_POLICESTATION", cf, ( 29029.8, -1650.33, 1135.45 ), ( 0, 174.1, 0 ), "SUPPLY_DROP_CITY_LOW_TOWN_POLICESTATION_VTOL", "cspf_4_auto1387105593893568994", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_supply_drop_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "SUPPLY_DROP_CITY_LOW_TOWN_POLICESTATION", cf, ( 8637.6, -2333.18, 9043.01 ), ( 359.47, 306.53, 0.49 ), "cspf_4_auto5366327683798550542", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_supply_drop_cs";
    s.name = "supply_drop_point";
    fe [[ f ]]( s, "SUPPLY_DROP_CITY_LOW_TOWN_POLICESTATION", cf, ( 28919.6, -2046.64, 424.88 ), ( 0, 0, 0 ), "cspf_4_auto12189821597260913835", undefined, "east", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 600 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_supply_drop_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "SUPPLY_DROP_CITY_LOW_TOWN_POLICESTATION", cf, ( 47792.1, -1194.41, 9798.31 ), ( 0, 174.41, 0 ), undefined, "cspf_4_auto17043187106235356109", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150, 1 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_supply_drop_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "SUPPLY_DROP_CITY_LOW_TOWN_POLICESTATION", cf, ( 22236, -636.64, 5373.03 ), ( 359.47, 306.53, 0.49 ), "cspf_4_auto1387105593893568994", "cspf_4_auto5366327683798550542", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_supply_drop_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "SUPPLY_DROP_CITY_LOW_TOWN_POLICESTATION", cf, ( 37520.1, -1300.79, 6395.28 ), ( 0, 136.66, 0 ), "cspf_4_auto17043187106235356109", "SUPPLY_DROP_CITY_LOW_TOWN_POLICESTATION_VTOL", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
}

// Namespace mp_sat_avalon_city_ob_activity_supply_drop_cs
// Params 3
// Checksum 0x396b97db, Offset: 0x490f
// Size: 0x3c6
function function_82a7a7b8dc66c348( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_supply_drop_cs";
    s.name = "supply_drop_starter";
    fe [[ f ]]( s, "SUPPLY_DROP_CITY_LOW_TOWN_TOWNHALL", cf, ( -22392.8, 9877.97, 1235.55 ), ( 0, 59, 0 ), undefined, "cspf_5_auto9728654265935901976", "SUPPLY_DROP_CITY_LOW_TOWN_TOWNHALL", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_supply_drop_cs";
    s.name = "supply_drop_point";
    fe [[ f ]]( s, "SUPPLY_DROP_CITY_LOW_TOWN_TOWNHALL", cf, ( -16385.1, -5976.57, 386.01 ), ( 0, 0, 0 ), "cspf_5_auto9728654265935901976", undefined, "east", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 600 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_supply_drop_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    s.script_accel = "350";
    fe [[ f ]]( s, "SUPPLY_DROP_CITY_LOW_TOWN_TOWNHALL", cf, ( -16405.4, -6041.22, 1027.44 ), ( 0, 310.13, 0 ), "SUPPLY_DROP_CITY_LOW_TOWN_TOWNHALL_VTOL", "cspf_5_auto10531453841929063550", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_supply_drop_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "SUPPLY_DROP_CITY_LOW_TOWN_TOWNHALL", cf, ( -1323.25, -19411.4, 8798.5 ), ( 359.47, 82.55, 0.49 ), "cspf_5_auto6048975974737708627", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_supply_drop_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "SUPPLY_DROP_CITY_LOW_TOWN_TOWNHALL", cf, ( -30308, 8362.66, 7228.3 ), ( 0, 335.51, 0 ), undefined, "cspf_5_auto240816536259333209", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150, 1 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_supply_drop_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "SUPPLY_DROP_CITY_LOW_TOWN_TOWNHALL", cf, ( -14874.7, -11190.4, 5128.52 ), ( 359.47, 82.55, 0.49 ), "cspf_5_auto10531453841929063550", "cspf_5_auto6048975974737708627", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_supply_drop_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "SUPPLY_DROP_CITY_LOW_TOWN_TOWNHALL", cf, ( -22362.3, 110.53, 6150.77 ), ( 0, 272.68, 0 ), "cspf_5_auto240816536259333209", "SUPPLY_DROP_CITY_LOW_TOWN_TOWNHALL_VTOL", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
}

// Namespace mp_sat_avalon_city_ob_activity_supply_drop_cs
// Params 3
// Checksum 0x56e09b80, Offset: 0x4cdd
// Size: 0x3c6
function function_3d55d06f11679b59( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_supply_drop_cs";
    s.name = "supply_drop_starter";
    fe [[ f ]]( s, "SUPPLY_DROP_CITY_LOW_TOWN_FIRESTATION", cf, ( 25294, -17934.7, 277.2 ), ( 0, 254.93, 0 ), undefined, "cspf_6_auto12189821597260913835", "SUPPLY_DROP_CITY_LOW_TOWN_FIRESTATION", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_supply_drop_cs";
    s.name = "supply_drop_point";
    fe [[ f ]]( s, "SUPPLY_DROP_CITY_LOW_TOWN_FIRESTATION", cf, ( 16172.3, -9438.74, 3479.87 ), ( 0, 0, 0 ), "cspf_6_auto12189821597260913835", undefined, "east", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 600 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_supply_drop_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    s.script_accel = "350";
    fe [[ f ]]( s, "SUPPLY_DROP_CITY_LOW_TOWN_FIRESTATION", cf, ( 16138.4, -9704.82, 4127.94 ), ( 0, 300.72, 0 ), "SUPPLY_DROP_CITY_LOW_TOWN_FIRESTATION_VTOL", "cspf_6_auto4789440064540893282", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_supply_drop_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "SUPPLY_DROP_CITY_LOW_TOWN_FIRESTATION", cf, ( 28575.2, -25144.3, 11817.5 ), ( 359.47, 73.15, 0.49 ), "cspf_6_auto15095903762527541752", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_supply_drop_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "SUPPLY_DROP_CITY_LOW_TOWN_FIRESTATION", cf, ( 4519.11, 6993.24, 10247.3 ), ( 0, 326.11, 0 ), undefined, "cspf_6_auto4363186117024905534", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150, 1 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_supply_drop_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "SUPPLY_DROP_CITY_LOW_TOWN_FIRESTATION", cf, ( 19102.2, -15242, 8147.52 ), ( 359.47, 73.15, 0.49 ), "cspf_6_auto4789440064540893282", "cspf_6_auto15095903762527541752", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_activity_supply_drop_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "SUPPLY_DROP_CITY_LOW_TOWN_FIRESTATION", cf, ( 11009.4, -2446.51, 9169.77 ), ( 0, 263.28, 0 ), "cspf_6_auto4363186117024905534", "SUPPLY_DROP_CITY_LOW_TOWN_FIRESTATION_VTOL", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
}

// Namespace mp_sat_avalon_city_ob_activity_supply_drop_cs
// Params 0
// Checksum 0x2d4cd68c, Offset: 0x50ab
// Size: 0x1d8
function function_d9dd7965c51c95d1()
{
    activityinstances = [];
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_activitydefinition_supply_drop";
    var_881289d7987bc770.cf = "mp_sat_avalon_city_ob_activity_supply_drop_cs";
    var_881289d7987bc770.scriptstructorigin = ( 28967.1, -1557.97, 470.37 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [];
    var_881289d7987bc770.var_31ce4477e3543d24 = [];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [];
    var_881289d7987bc770.locationradius = [];
    activityinstances[ "SUPPLY_DROP_CITY_LOW_TOWN_POLICESTATION" ] = var_881289d7987bc770;
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_activitydefinition_supply_drop";
    var_881289d7987bc770.cf = "mp_sat_avalon_city_ob_activity_supply_drop_cs";
    var_881289d7987bc770.scriptstructorigin = ( -16394.3, -5974.78, 402.75 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [];
    var_881289d7987bc770.var_31ce4477e3543d24 = [];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [];
    var_881289d7987bc770.locationradius = [];
    activityinstances[ "SUPPLY_DROP_CITY_LOW_TOWN_TOWNHALL" ] = var_881289d7987bc770;
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_activitydefinition_supply_drop";
    var_881289d7987bc770.cf = "mp_sat_avalon_city_ob_activity_supply_drop_cs";
    var_881289d7987bc770.scriptstructorigin = ( 16169.6, -9445.5, 3480.5 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [];
    var_881289d7987bc770.var_31ce4477e3543d24 = [];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [];
    var_881289d7987bc770.locationradius = [];
    activityinstances[ "SUPPLY_DROP_CITY_LOW_TOWN_FIRESTATION" ] = var_881289d7987bc770;
    return activityinstances;
}

