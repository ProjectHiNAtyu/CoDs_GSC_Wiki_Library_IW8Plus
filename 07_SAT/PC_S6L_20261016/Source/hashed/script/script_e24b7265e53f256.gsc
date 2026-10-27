// script_e24b7265e53f256  (hash_0e24b7265e53f256.gscc) (size: 31299 Bytes / 0x7a43 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x6e0f84cd (1846510797)
// size ...... 31299 (0x7a43)
// includes .. 4   (offset: 0x66ff)
// strings ... 95  (offset: 0x671f)
// dev strs .. 0   (offset: 0x7a43)
// exports ... 14  (offset: 0x61d3)
// cseg ...... 0x9fe + 0x57d5 (0x61d3)
// imports ... 27  (offset: 0x6403)
// animtree1 . 0   (offset: 0x7a43)
// animtree2 . 0   (offset: 0x7a43)
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace mp_sat_avalon_city_ob_contract_hvt_cs;

// Namespace mp_sat_avalon_city_ob_contract_hvt_cs
// Params 0, eflags: 0x5
// Checksum 0x47e9ced8, Offset: 0xa1c
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"mp_sat_avalon_city_ob_contract_hvt_cs", #"activity_common", &function_b39ecd3d51489472, undefined );
}

// Namespace mp_sat_avalon_city_ob_contract_hvt_cs
// Params 0, eflags: 0x4
// Checksum 0xd98e8d29, Offset: 0xa45
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace mp_sat_avalon_city_ob_contract_hvt_cs
// Params 0, eflags: 0x4
// Checksum 0x5cb55ec5, Offset: 0xa56
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace mp_sat_avalon_city_ob_contract_hvt_cs
// Params 2
// Checksum 0xe86d6dfa, Offset: 0xa67
// Size: 0x8c
function main( unused, unused2 )
{
    if ( utility::flag_exist( "mp_sat_avalon_city_ob_contract_hvt_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "mp_sat_avalon_city_ob_contract_hvt_cs" ) )
    {
        return;
    }
    
    activity_common::function_e1df676808c1d1e3( &function_4cd78e661617f3 );
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "mp_sat_avalon_city_ob_contract_hvt_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "mp_sat_avalon_city_ob_contract_hvt_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace mp_sat_avalon_city_ob_contract_hvt_cs
// Params 3, eflags: 0x4
// Checksum 0xdf37ea0a, Offset: 0xafb
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "mp_sat_avalon_city_ob_contract_hvt_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "mp_sat_avalon_city_ob_contract_hvt_cs" );
}

// Namespace mp_sat_avalon_city_ob_contract_hvt_cs
// Params 3, eflags: 0x4
// Checksum 0x4278f8dc, Offset: 0xb75
// Size: 0x4396
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_contract_hvt_cs";
    s.activity_bundle = "sat_activitydefinition_contract_hvt";
    s.name = "CONTRACT_HVT_CITY_TOWNHALL";
    fe [[ f ]]( s, "CONTRACT_HVT_CITY_TOWNHALL", cf, ( 7932.45, -10230.4, 1970.11 ), ( 0, 331, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_contract_hvt_cs";
    fe [[ f ]]( s, "CONTRACT_HVT_CITY_TOWNHALL", cf, ( 10689, -4384.26, 1388.11 ), ( 355.64, 297.46, 11.63 ), "activity_nexus_instance_joiner", "CONTRACT_HVT_CITY_TOWNHALL", undefined, undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_contract_hvt_cs";
    fe [[ f ]]( s, "CONTRACT_HVT_CITY_TOWNHALL", cf, ( 7923.22, -10178, 1970.11 ), ( 0, 331, 0 ), "activity_nexus_spatial_zone", undefined, undefined, undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 2000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_contract_hvt_cs";
    fe [[ f ]]( s, "CONTRACT_HVT_CITY_TOWNHALL", cf, ( 7903.1, -10214.3, 1970.11 ), ( 0, 331, 0 ), "activity_nexus_spatial_zone", undefined, "Ambient_AI_Exclusion_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 2000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_contract_hvt_cs";
    s.groupid = "ai_encounter";
    s.location_spawnpoint = "0";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.name = "bodyguard";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "sg";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "CONTRACT_HVT_CITY_TOWNHALL", cf, ( 8584.74, -10107.7, 1970 ), ( 0, 150, 0 ), undefined, "cspf_1_auto12188712843935047885", "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_contract_hvt_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "bg_sg";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "CONTRACT_HVT_CITY_TOWNHALL", cf, ( 8604.79, -10532.8, 2146.5 ), ( 0, 63, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_contract_hvt_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "bg_sg";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "CONTRACT_HVT_CITY_TOWNHALL", cf, ( 8425.47, -10628.7, 2434 ), ( 0, 112.25, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_contract_hvt_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "bg_sg";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "CONTRACT_HVT_CITY_TOWNHALL", cf, ( 8365.69, -10458.1, 1970 ), ( 0, 203.3, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_contract_hvt_cs";
    s.groupid = "ai_encounter";
    s.location_spawnpoint = "0";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.name = "bodyguard";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "smg";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "CONTRACT_HVT_CITY_TOWNHALL", cf, ( 7644.57, -9488.93, 1970 ), ( 0, 240, 0 ), undefined, "cspf_1_auto5098133790611998298", "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_contract_hvt_cs";
    s.groupid = "ai_encounter";
    s.location_spawnpoint = "0";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.name = "bodyguard";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "shield";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "CONTRACT_HVT_CITY_TOWNHALL", cf, ( 8996.98, -9687.67, 1970 ), ( 0, 61, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_contract_hvt_cs";
    s.groupid = "ai_encounter";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.reverse_route = "1";
    s.start_point = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "CONTRACT_HVT_CITY_TOWNHALL", cf, ( 7541.8, -9688.02, 1970 ), ( 0, 164, 0 ), "cspf_1_auto5098133790611998298", "cspf_1_auto4745471356556183330", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_contract_hvt_cs";
    s.groupid = "ai_encounter";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "CONTRACT_HVT_CITY_TOWNHALL", cf, ( 7447.47, -9872.98, 1970 ), ( 0, 164, 0 ), "cspf_1_auto4745471356556183330", "cspf_1_auto8254370923626736474", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_contract_hvt_cs";
    s.groupid = "ai_encounter";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "CONTRACT_HVT_CITY_TOWNHALL", cf, ( 7219.24, -9935.73, 1970 ), ( 0, 164, 0 ), "cspf_1_auto8254370923626736474", "cspf_1_auto1640805768956053976", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_contract_hvt_cs";
    s.groupid = "ai_encounter";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "CONTRACT_HVT_CITY_TOWNHALL", cf, ( 7445.37, -9868.45, 1970 ), ( 0, 164, 0 ), "cspf_1_auto1640805768956053976", "cspf_1_auto5098133790611998298", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_contract_hvt_cs";
    s.groupid = "ai_encounter";
    s.location_spawnpoint = "0";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.name = "bodyguard";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "smg";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "CONTRACT_HVT_CITY_TOWNHALL", cf, ( 7697.05, -10398.2, 2146.01 ), ( 0, 110, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_contract_hvt_cs";
    s.groupid = "ai_encounter";
    s.location_spawnpoint = "0";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.name = "bodyguard";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "CONTRACT_HVT_CITY_TOWNHALL", cf, ( 8636.94, -9797.16, 1969.4 ), ( 0, 330.18, 0 ), undefined, "cspf_1_auto12217365481542083654", "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_contract_hvt_cs";
    s.groupid = "ai_encounter";
    s.loop_route = "1";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.start_point = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "CONTRACT_HVT_CITY_TOWNHALL", cf, ( 8339.72, -9979.04, 1970 ), ( 0, 115, 0 ), "cspf_1_auto12188712843935047885", "cspf_1_auto12805727806029020236", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_contract_hvt_cs";
    s.groupid = "ai_encounter";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "CONTRACT_HVT_CITY_TOWNHALL", cf, ( 8234.91, -9926.1, 1970 ), ( 0, 115, 0 ), "cspf_1_auto13113603002566297078", "cspf_1_auto12188712843935047885", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_contract_hvt_cs";
    s.goal_area_target = "city_hvt_townhall_boss_combat_volume";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_parameters = "disable_stealth";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "hvt_jugg";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "CONTRACT_HVT_CITY_TOWNHALL", cf, ( 8295.02, -10728.5, 2438 ), ( 0, 65.45, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_contract_hvt_cs";
    s.groupid = "ai_encounter";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "CONTRACT_HVT_CITY_TOWNHALL", cf, ( 8094.02, -9854.42, 1970 ), ( 0, 115, 0 ), "cspf_1_auto12805727806029020236", "cspf_1_auto4187344827911358822", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_contract_hvt_cs";
    s.groupid = "ai_encounter";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "CONTRACT_HVT_CITY_TOWNHALL", cf, ( 8585.68, -10107.6, 1970 ), ( 0, 115, 0 ), "cspf_1_auto4187344827911358822", "cspf_1_auto13113603002566297078", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_contract_hvt_cs";
    s.groupid = "ai_encounter";
    s.loop_route = "1";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.start_point = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "CONTRACT_HVT_CITY_TOWNHALL", cf, ( 8958.38, -9840.31, 1970 ), ( 0, 117, 0 ), "cspf_1_auto12217365481542083654", "cspf_1_auto7839774048977721715", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_contract_hvt_cs";
    s.groupid = "ai_encounter";
    s.loop_route = "1";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "CONTRACT_HVT_CITY_TOWNHALL", cf, ( 8957.66, -10026.1, 1970 ), ( 0, 117, 0 ), "cspf_1_auto7839774048977721715", "cspf_1_auto11790847774830617100", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_contract_hvt_cs";
    s.groupid = "ai_encounter";
    s.loop_route = "1";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "CONTRACT_HVT_CITY_TOWNHALL", cf, ( 8958.42, -10027.9, 1970 ), ( 0, 117, 0 ), "cspf_1_auto697824352696487050", "cspf_1_auto12217365481542083654", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_contract_hvt_cs";
    s.groupid = "ai_encounter";
    s.loop_route = "1";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "CONTRACT_HVT_CITY_TOWNHALL", cf, ( 8853.39, -10230.2, 1970 ), ( 0, 117, 0 ), "cspf_1_auto11790847774830617100", "cspf_1_auto697824352696487050", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_contract_hvt_cs";
    s.groupid = "ai_encounter";
    s.location_spawnpoint = "0";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.name = "bodyguard";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "smg";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "CONTRACT_HVT_CITY_TOWNHALL", cf, ( 7930.84, -10164.7, 2434 ), ( 0, 106, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_contract_hvt_cs";
    s.groupid = "ai_encounter";
    s.location_spawnpoint = "0";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.name = "bodyguard";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "sg";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "CONTRACT_HVT_CITY_TOWNHALL", cf, ( 7310.43, -10103.2, 1966.97 ), ( 0, 255, 0 ), undefined, "cspf_1_auto8732705036651258760", "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_contract_hvt_cs";
    s.groupid = "ai_encounter";
    s.location_spawnpoint = "0";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.name = "bodyguard";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "sg";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "CONTRACT_HVT_CITY_TOWNHALL", cf, ( 7949.83, -10632.1, 1970 ), ( 0, 331.18, 0 ), undefined, "cspf_1_auto12538920020315507266", "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_contract_hvt_cs";
    s.groupid = "ai_encounter";
    s.location_spawnpoint = "0";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.name = "bodyguard";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "shield";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "CONTRACT_HVT_CITY_TOWNHALL", cf, ( 7473.85, -10478.7, 1970 ), ( 0, 245, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_contract_hvt_cs";
    s.groupid = "ai_encounter";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "CONTRACT_HVT_CITY_TOWNHALL", cf, ( 7290.56, -10371.1, 1970 ), ( 0, 74, 0 ), "cspf_1_auto11840842893238176813", "cspf_1_auto8732705036651258760", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_contract_hvt_cs";
    s.groupid = "ai_encounter";
    s.loop_route = "1";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.start_point = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "CONTRACT_HVT_CITY_TOWNHALL", cf, ( 7258.66, -10355.2, 1966.97 ), ( 0, 76, 0 ), "cspf_1_auto8732705036651258760", "cspf_1_auto16465257579950119636", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_contract_hvt_cs";
    s.groupid = "ai_encounter";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "CONTRACT_HVT_CITY_TOWNHALL", cf, ( 7655.71, -10150.2, 1970 ), ( 0, 74, 0 ), "cspf_1_auto5121732794538234112", "cspf_1_auto11840842893238176813", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_contract_hvt_cs";
    s.groupid = "ai_encounter";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "CONTRACT_HVT_CITY_TOWNHALL", cf, ( 7509.27, -10270.3, 1970 ), ( 0, 76, 0 ), "cspf_1_auto16465257579950119636", "cspf_1_auto5121732794538234112", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_contract_hvt_cs";
    s.groupid = "ai_encounter";
    s.loop_route = "1";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.start_point = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "CONTRACT_HVT_CITY_TOWNHALL", cf, ( 8173.42, -10752.4, 1970 ), ( 0, 125, 0 ), "cspf_1_auto12538920020315507266", "cspf_1_auto11022152284414414717", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_contract_hvt_cs";
    s.groupid = "ai_encounter";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "CONTRACT_HVT_CITY_TOWNHALL", cf, ( 7962.4, -10641.5, 1970 ), ( 0, 125, 0 ), "cspf_1_auto4906251479695588759", "cspf_1_auto12538920020315507266", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_contract_hvt_cs";
    s.groupid = "ai_encounter";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "CONTRACT_HVT_CITY_TOWNHALL", cf, ( 8245.37, -10789.2, 1970 ), ( 0, 125, 0 ), "cspf_1_auto17873527802537553549", "cspf_1_auto4906251479695588759", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_contract_hvt_cs";
    s.groupid = "ai_encounter";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "CONTRACT_HVT_CITY_TOWNHALL", cf, ( 8332.29, -10835.2, 1970 ), ( 0, 125, 0 ), "cspf_1_auto11022152284414414717", "cspf_1_auto17873527802537553549", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_contract_hvt_cs";
    s.groupid = "ai_encounter";
    s.location_spawnpoint = "0";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.name = "bodyguard";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "shield";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "CONTRACT_HVT_CITY_TOWNHALL", cf, ( 7857.08, -9652.41, 1970 ), ( 0, 60, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_contract_hvt_cs";
    s.groupid = "ai_encounter";
    s.location_spawnpoint = "0";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.name = "bodyguard";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "CONTRACT_HVT_CITY_TOWNHALL", cf, ( 7019.85, -10302.9, 1970 ), ( 0, 311.7, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_contract_hvt_cs";
    s.activity_bundle = "sat_activitydefinition_contract_hvt";
    s.name = "CONTRACT_HVT_CITY_POLICE_STATION";
    fe [[ f ]]( s, "CONTRACT_HVT_CITY_POLICE_STATION", cf, ( -1774.6, 7739.39, 78.06 ), ( 0, 345, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_contract_hvt_cs";
    fe [[ f ]]( s, "CONTRACT_HVT_CITY_POLICE_STATION", cf, ( -1796.24, 7788.06, 78.06 ), ( 0, 345, 0 ), "activity_nexus_spatial_zone", undefined, undefined, undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 2000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_contract_hvt_cs";
    fe [[ f ]]( s, "CONTRACT_HVT_CITY_POLICE_STATION", cf, ( -5037.63, -1115.77, 536.5 ), ( 0, 0, 0 ), "activity_nexus_instance_joiner", "CONTRACT_HVT_CITY_POLICE_STATION", undefined, undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_contract_hvt_cs";
    fe [[ f ]]( s, "CONTRACT_HVT_CITY_POLICE_STATION", cf, ( -1806.98, 7747.97, 78.06 ), ( 0, 345, 0 ), "activity_nexus_spatial_zone", undefined, "Ambient_AI_Exclusion_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 2000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_contract_hvt_cs";
    s.groupid = "ai_encounter";
    s.location_spawnpoint = "0";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.name = "bodyguard";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "sg";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "CONTRACT_HVT_CITY_POLICE_STATION", cf, ( -2512.3, 7627.16, 78 ), ( 0, 75, 0 ), undefined, "cspf_2_auto12188712843935047885", "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_contract_hvt_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "bg_sg";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "CONTRACT_HVT_CITY_POLICE_STATION", cf, ( -1108.42, 7719.91, 78 ), ( 0, 184, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_contract_hvt_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "bg_sg";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "CONTRACT_HVT_CITY_POLICE_STATION", cf, ( -1382.79, 7566.82, 78 ), ( 0, 146.25, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_contract_hvt_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "bg_sg";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "CONTRACT_HVT_CITY_POLICE_STATION", cf, ( -1917.66, 8044.97, 78 ), ( 0, 163.3, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_contract_hvt_cs";
    s.groupid = "ai_encounter";
    s.location_spawnpoint = "0";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.name = "bodyguard";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "smg";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "CONTRACT_HVT_CITY_POLICE_STATION", cf, ( -2054.29, 7074.84, 78 ), ( 0, 165, 0 ), undefined, "cspf_2_auto5098133790611998298", "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_contract_hvt_cs";
    s.groupid = "ai_encounter";
    s.location_spawnpoint = "0";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.name = "bodyguard";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "shield";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "CONTRACT_HVT_CITY_POLICE_STATION", cf, ( -2952.91, 7320.48, 78 ), ( 0, 171, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_contract_hvt_cs";
    s.groupid = "ai_encounter";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.reverse_route = "1";
    s.start_point = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "CONTRACT_HVT_CITY_POLICE_STATION", cf, ( -2234.27, 7123.01, 78 ), ( 0, 164, 0 ), "cspf_2_auto5098133790611998298", "cspf_2_auto4745471356556183330", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_contract_hvt_cs";
    s.groupid = "ai_encounter";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "CONTRACT_HVT_CITY_POLICE_STATION", cf, ( -2455.34, 7179.08, 78 ), ( 0, 164, 0 ), "cspf_2_auto4745471356556183330", "cspf_2_auto8254370923626736474", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_contract_hvt_cs";
    s.groupid = "ai_encounter";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "CONTRACT_HVT_CITY_POLICE_STATION", cf, ( -2594.58, 7222.27, 78 ), ( 0, 164, 0 ), "cspf_2_auto8254370923626736474", "cspf_2_auto1640805768956053976", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_contract_hvt_cs";
    s.groupid = "ai_encounter";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "CONTRACT_HVT_CITY_POLICE_STATION", cf, ( -2069.5, 7080.58, 78 ), ( 0, 164, 0 ), "cspf_2_auto1640805768956053976", "cspf_2_auto5098133790611998298", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_contract_hvt_cs";
    s.groupid = "ai_encounter";
    s.location_spawnpoint = "0";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.name = "bodyguard";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "smg";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "CONTRACT_HVT_CITY_POLICE_STATION", cf, ( -1845.34, 8047.86, 238 ), ( 0, 165, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_contract_hvt_cs";
    s.groupid = "ai_encounter";
    s.location_spawnpoint = "0";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.name = "bodyguard";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "CONTRACT_HVT_CITY_POLICE_STATION", cf, ( -1640.15, 7229.64, 78 ), ( 0, 170.18, 0 ), undefined, "cspf_2_auto12217365481542083654", "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_contract_hvt_cs";
    s.groupid = "ai_encounter";
    s.loop_route = "1";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.start_point = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "CONTRACT_HVT_CITY_POLICE_STATION", cf, ( -2494.37, 7739.38, 78 ), ( 0, 115, 0 ), "cspf_2_auto12188712843935047885", "cspf_2_auto12805727806029020236", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_contract_hvt_cs";
    s.groupid = "ai_encounter";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "CONTRACT_HVT_CITY_POLICE_STATION", cf, ( -2628.69, 7988.53, 78 ), ( 0, 115, 0 ), "cspf_2_auto13113603002566297078", "cspf_2_auto12188712843935047885", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_contract_hvt_cs";
    s.goal_area_target = "city_hvt_police_station_boss_combat_volume";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_parameters = "disable_stealth";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "hvt_jugg";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "CONTRACT_HVT_CITY_POLICE_STATION", cf, ( -476.99, 7411.91, 78 ), ( 0, 165.45, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_contract_hvt_cs";
    s.groupid = "ai_encounter";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "CONTRACT_HVT_CITY_POLICE_STATION", cf, ( -2629.7, 7986.96, 78 ), ( 0, 115, 0 ), "cspf_2_auto12805727806029020236", "cspf_2_auto4187344827911358822", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_contract_hvt_cs";
    s.groupid = "ai_encounter";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "CONTRACT_HVT_CITY_POLICE_STATION", cf, ( -2385.93, 8144.62, 78 ), ( 0, 115, 0 ), "cspf_2_auto4187344827911358822", "cspf_2_auto13113603002566297078", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_contract_hvt_cs";
    s.groupid = "ai_encounter";
    s.loop_route = "1";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.start_point = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "CONTRACT_HVT_CITY_POLICE_STATION", cf, ( -2001.35, 7330.46, 78 ), ( 0, 117, 0 ), "cspf_2_auto12217365481542083654", "cspf_2_auto7839774048977721715", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_contract_hvt_cs";
    s.groupid = "ai_encounter";
    s.loop_route = "1";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "CONTRACT_HVT_CITY_POLICE_STATION", cf, ( -2026.05, 7202.33, 78 ), ( 0, 117, 0 ), "cspf_2_auto7839774048977721715", "cspf_2_auto11790847774830617100", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_contract_hvt_cs";
    s.groupid = "ai_encounter";
    s.loop_route = "1";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "CONTRACT_HVT_CITY_POLICE_STATION", cf, ( -2027, 7201.92, 78 ), ( 0, 117, 0 ), "cspf_2_auto697824352696487050", "cspf_2_auto12217365481542083654", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_contract_hvt_cs";
    s.groupid = "ai_encounter";
    s.loop_route = "1";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "CONTRACT_HVT_CITY_POLICE_STATION", cf, ( -2367.54, 7292.72, 78 ), ( 0, 117, 0 ), "cspf_2_auto11790847774830617100", "cspf_2_auto697824352696487050", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_contract_hvt_cs";
    s.groupid = "ai_encounter";
    s.location_spawnpoint = "0";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.name = "bodyguard";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "smg";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "CONTRACT_HVT_CITY_POLICE_STATION", cf, ( -2954.42, 7685.81, 78 ), ( 0, 261, 0 ), undefined, "cspf_2_auto8732705036651258760", "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_contract_hvt_cs";
    s.groupid = "ai_encounter";
    s.location_spawnpoint = "0";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.name = "bodyguard";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "sg";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "CONTRACT_HVT_CITY_POLICE_STATION", cf, ( -2305.24, 7507.54, 77.01 ), ( 0, 255, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_contract_hvt_cs";
    s.groupid = "ai_encounter";
    s.location_spawnpoint = "0";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.name = "bodyguard";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "sg";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "CONTRACT_HVT_CITY_POLICE_STATION", cf, ( -1347.23, 7870.35, 238 ), ( 0, 166.18, 0 ), undefined, "cspf_2_auto12538920020315507266", "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_contract_hvt_cs";
    s.groupid = "ai_encounter";
    s.location_spawnpoint = "0";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.name = "bodyguard";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "shield";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "CONTRACT_HVT_CITY_POLICE_STATION", cf, ( -2085.25, 7841.8, 78 ), ( 0, 165, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_contract_hvt_cs";
    s.groupid = "ai_encounter";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "CONTRACT_HVT_CITY_POLICE_STATION", cf, ( -2929.66, 7794.24, 78 ), ( 0, 74, 0 ), "cspf_2_auto11840842893238176813", "cspf_2_auto8732705036651258760", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_contract_hvt_cs";
    s.groupid = "ai_encounter";
    s.loop_route = "1";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.start_point = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "CONTRACT_HVT_CITY_POLICE_STATION", cf, ( -3000.72, 7472.62, 78 ), ( 0, 76, 0 ), "cspf_2_auto8732705036651258760", "cspf_2_auto16465257579950119636", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_contract_hvt_cs";
    s.groupid = "ai_encounter";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "CONTRACT_HVT_CITY_POLICE_STATION", cf, ( -3001.48, 7474.14, 78 ), ( 0, 74, 0 ), "cspf_2_auto5121732794538234112", "cspf_2_auto11840842893238176813", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_contract_hvt_cs";
    s.groupid = "ai_encounter";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "CONTRACT_HVT_CITY_POLICE_STATION", cf, ( -2646.9, 7379.42, 78 ), ( 0, 76, 0 ), "cspf_2_auto16465257579950119636", "cspf_2_auto5121732794538234112", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_contract_hvt_cs";
    s.groupid = "ai_encounter";
    s.loop_route = "1";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.start_point = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "CONTRACT_HVT_CITY_POLICE_STATION", cf, ( -1547.92, 7920.67, 238 ), ( 0, 125, 0 ), "cspf_2_auto12538920020315507266", "cspf_2_auto11022152284414414717", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_contract_hvt_cs";
    s.groupid = "ai_encounter";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "CONTRACT_HVT_CITY_POLICE_STATION", cf, ( -1651.45, 7516.27, 238 ), ( 0, 125, 0 ), "cspf_2_auto4906251479695588759", "cspf_2_auto12538920020315507266", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_contract_hvt_cs";
    s.groupid = "ai_encounter";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "CONTRACT_HVT_CITY_POLICE_STATION", cf, ( -1300.22, 7423.41, 238 ), ( 0, 125, 0 ), "cspf_2_auto17873527802537553549", "cspf_2_auto4906251479695588759", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_contract_hvt_cs";
    s.groupid = "ai_encounter";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "CONTRACT_HVT_CITY_POLICE_STATION", cf, ( -1653.86, 7516.67, 238 ), ( 0, 125, 0 ), "cspf_2_auto11022152284414414717", "cspf_2_auto17873527802537553549", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_contract_hvt_cs";
    s.groupid = "ai_encounter";
    s.location_spawnpoint = "0";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.name = "bodyguard";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "shield";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "CONTRACT_HVT_CITY_POLICE_STATION", cf, ( -1832.71, 7003.85, 78 ), ( 0, 255, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_contract_hvt_cs";
    s.groupid = "ai_encounter";
    s.location_spawnpoint = "0";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.name = "bodyguard";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "CONTRACT_HVT_CITY_POLICE_STATION", cf, ( -2725.17, 8183.71, 77 ), ( 0, 281.7, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace mp_sat_avalon_city_ob_contract_hvt_cs
// Params 0, eflags: 0x4
// Checksum 0xffe9d9b7, Offset: 0x4f13
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace mp_sat_avalon_city_ob_contract_hvt_cs
// Params 0
// Checksum 0x1d643747, Offset: 0x4f1d
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "mp_sat_avalon_city_ob_contract_hvt_cs" );
}

// Namespace mp_sat_avalon_city_ob_contract_hvt_cs
// Params 0
// Checksum 0xd7de4a7e, Offset: 0x4f33
// Size: 0x66
function function_4cd78e661617f3()
{
    activityinfostruct = {};
    activityinfostruct.name = "REV_OB_CONTRACT_HVT";
    activityinfostruct.scriptbundle = "sat_activitydefinition_contract_hvt";
    activityinfostruct.mainfunction = &main;
    activityinfostruct.var_934f068483ae4ddb = &function_d4323822d7042e5a;
    activityinfostruct.metadatafunction = &function_d9dd7965c51c95d1;
    return activityinfostruct;
}

// Namespace mp_sat_avalon_city_ob_contract_hvt_cs
// Params 4
// Checksum 0x55817325, Offset: 0x4fa2
// Size: 0x71
function function_d4323822d7042e5a( var_4312b79c960726b6, fe, us, cf = "mp_sat_avalon_city_ob_contract_hvt_cs" )
{
    switch ( var_4312b79c960726b6 )
    {
        case #"hash_3358e26f22bf96e":
            function_18128be81365bc16( fe, us, cf );
            break;
        case #"hash_6915e58c3fbc780c":
            function_fee4aa4ed260634( fe, us, cf );
            break;
    }
}

// Namespace mp_sat_avalon_city_ob_contract_hvt_cs
// Params 3
// Checksum 0x30f81b86, Offset: 0x501b
// Size: 0x82d
function function_18128be81365bc16( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_contract_hvt_cs";
    s.groupid = "customize";
    s.name = "dynamic_encounter";
    s.script_parameters = "sat_ob_contract_hvt_encounter_base";
    fe [[ f ]]( s, "CONTRACT_HVT_CITY_TOWNHALL", cf, ( 7927.97, -10204.3, 1970.11 ), ( 0, 241, 0 ), "cspf_3_auto7761672611037368335", undefined, "dynamic_encounter", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 2000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_contract_hvt_cs";
    s.name = "region";
    fe [[ f ]]( s, "CONTRACT_HVT_CITY_TOWNHALL", cf, ( 10751.9, -4394.02, 1402.82 ), ( 0, 0.3, 0 ), "hvt_region", "CONTRACT_HVT_CITY_TOWNHALL", "CITY_TOWNHALL", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_contract_hvt_cs";
    fe [[ f ]]( s, "CONTRACT_HVT_CITY_TOWNHALL", cf, ( 10769.8, -4394.06, 1402.82 ), ( 0, 0.3, 0 ), "s_hvt_city_townhall", "CONTRACT_HVT_CITY_TOWNHALL", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_contract_hvt_cs";
    s.groupid = "customize";
    s.name = "master_struct";
    fe [[ f ]]( s, "CONTRACT_HVT_CITY_TOWNHALL", cf, ( 7927.97, -10204.3, 2772.11 ), ( 0, 0, 0 ), undefined, "cspf_3_auto7761672611037368335", "CONTRACT_HVT_CITY_TOWNHALL", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 3000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_contract_hvt_cs";
    s.groupid = "hvt_1";
    s.name = "hvt_spawn_struct_01";
    fe [[ f ]]( s, "CONTRACT_HVT_CITY_TOWNHALL", cf, ( 7927.97, -10204.3, 1970.11 ), ( 0, 286, 0 ), "cspf_3_auto7761672611037368335", "cspf_3_auto11461361575472084105", "hvt_spawn_struct", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 1500 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_contract_hvt_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s._size_max = ( 500, 266, 750 );
    s._size_min = ( 350, 358, 40 );
    s.height = 128;
    s.length = "128";
    s.width = "128";
    fe [[ f ]]( s, "CONTRACT_HVT_CITY_TOWNHALL", cf, ( 8065.08, -10453.6, 1970 ), ( 0, 332, 0 ), "city_hvt_townhall_boss_combat_volume", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_contract_hvt_cs";
    s.groupid = "customize";
    s.name = "trap_sentry";
    fe [[ f ]]( s, "CONTRACT_HVT_CITY_TOWNHALL", cf, ( 8330.38, -10418.2, 1970 ), ( 0, 204.5, 0 ), "cspf_3_auto11461361575472084105", undefined, "sentry", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_contract_hvt_cs";
    s.groupid = "customize";
    s.name = "trap_mine";
    fe [[ f ]]( s, "CONTRACT_HVT_CITY_TOWNHALL", cf, ( 7777.88, -10551.1, 2146 ), ( 0, 258.03, 0 ), "cspf_3_auto11461361575472084105", undefined, "mine", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_contract_hvt_cs";
    s.groupid = "customize";
    s.name = "trap_mine";
    fe [[ f ]]( s, "CONTRACT_HVT_CITY_TOWNHALL", cf, ( 8344.96, -10221.8, 1971.97 ), ( 0, 258.03, 0 ), "cspf_3_auto11461361575472084105", undefined, "mine", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_contract_hvt_cs";
    s.groupid = "customize";
    s.name = "trap_mine";
    fe [[ f ]]( s, "CONTRACT_HVT_CITY_TOWNHALL", cf, ( 7613.21, -9982.09, 1970 ), ( 0, 258.03, 0 ), "cspf_3_auto11461361575472084105", undefined, "mine", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_contract_hvt_cs";
    s.groupid = "customize";
    s.name = "trap_sentry";
    fe [[ f ]]( s, "CONTRACT_HVT_CITY_TOWNHALL", cf, ( 8737.29, -10472.4, 1970 ), ( 0, 152.2, 0 ), "cspf_3_auto11461361575472084105", undefined, "sentry", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_contract_hvt_cs";
    s.groupid = "customize";
    s.name = "trap_mine";
    fe [[ f ]]( s, "CONTRACT_HVT_CITY_TOWNHALL", cf, ( 8888.05, -9967.53, 1970 ), ( 0, 166.03, 0 ), "cspf_3_auto11461361575472084105", undefined, "mine", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_contract_hvt_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s._size_max = ( 196, 536, 698 );
    s._size_min = ( 432, 320, 256 );
    s.groupid = "hvt_1";
    s.height = 128;
    s.length = "128";
    s.width = "128";
    fe [[ f ]]( s, "CONTRACT_HVT_CITY_TOWNHALL", cf, ( 8272.04, -10481.2, 1982.35 ), ( 0, 62, 0 ), "cspf_3_auto11461361575472084105", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_contract_hvt_cs";
    s.groupid = "customize";
    s.name = "trap_sentry";
    fe [[ f ]]( s, "CONTRACT_HVT_CITY_TOWNHALL", cf, ( 7864.17, -9966.76, 1970 ), ( 0, 102.4, 0 ), "cspf_3_auto11461361575472084105", undefined, "sentry", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_sat_avalon_city_ob_contract_hvt_cs
// Params 3
// Checksum 0x7e13e753, Offset: 0x5850
// Size: 0x7c3
function function_fee4aa4ed260634( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_contract_hvt_cs";
    s.groupid = "customize";
    s.name = "dynamic_encounter";
    s.script_parameters = "sat_ob_contract_hvt_encounter_base";
    fe [[ f ]]( s, "CONTRACT_HVT_CITY_POLICE_STATION", cf, ( -1785.27, 7763.69, 78.06 ), ( 0, 255, 0 ), "cspf_4_auto7761672611037368335", undefined, "dynamic_encounter", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 2000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_contract_hvt_cs";
    s.name = "region";
    fe [[ f ]]( s, "CONTRACT_HVT_CITY_POLICE_STATION", cf, ( -4987.18, -1197.85, 536 ), ( 0, 254.6, 0 ), "hvt_region", "CONTRACT_HVT_CITY_POLICE_STATION", "CITY_POLICE_STATION", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_contract_hvt_cs";
    fe [[ f ]]( s, "CONTRACT_HVT_CITY_POLICE_STATION", cf, ( -4992.08, -1215.06, 536 ), ( 0, 254.6, 0 ), "s_hvt_city_police_station", "CONTRACT_HVT_CITY_POLICE_STATION", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_contract_hvt_cs";
    s.groupid = "customize";
    s.name = "master_struct";
    fe [[ f ]]( s, "CONTRACT_HVT_CITY_POLICE_STATION", cf, ( -1785.27, 7763.69, 1025.06 ), ( 0, 0, 0 ), undefined, "cspf_4_auto7761672611037368335", "CONTRACT_HVT_CITY_POLICE_STATION", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 3000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_contract_hvt_cs";
    s.groupid = "hvt_1";
    s.name = "hvt_spawn_struct_01";
    fe [[ f ]]( s, "CONTRACT_HVT_CITY_POLICE_STATION", cf, ( -1785.27, 7763.69, 78.06 ), ( 0, 300, 0 ), "cspf_4_auto7761672611037368335", "cspf_4_auto11461361575472084105", "hvt_spawn_struct", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 1500 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_contract_hvt_cs";
    s.name = "Boss_combat_volume";
    fe [[ f ]]( s, "CONTRACT_HVT_CITY_POLICE_STATION", cf, ( -814.79, 7643.9, 78 ), ( 0, 0, 0 ), "city_hvt_police_station_boss_combat_volume", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 1300 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_contract_hvt_cs";
    s.groupid = "customize";
    s.name = "trap_sentry";
    fe [[ f ]]( s, "CONTRACT_HVT_CITY_POLICE_STATION", cf, ( -1919.09, 8098.2, 78 ), ( 0, 164.5, 0 ), "cspf_4_auto11461361575472084105", undefined, "sentry", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_contract_hvt_cs";
    s.groupid = "customize";
    s.name = "trap_mine";
    fe [[ f ]]( s, "CONTRACT_HVT_CITY_POLICE_STATION", cf, ( -2554.3, 7458.01, 78 ), ( 0, 258.03, 0 ), "cspf_4_auto11461361575472084105", undefined, "mine", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_contract_hvt_cs";
    s.groupid = "customize";
    s.name = "trap_mine";
    fe [[ f ]]( s, "CONTRACT_HVT_CITY_POLICE_STATION", cf, ( -1824.12, 7168.16, 78 ), ( 0, 258.03, 0 ), "cspf_4_auto11461361575472084105", undefined, "mine", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_contract_hvt_cs";
    s.groupid = "customize";
    s.name = "trap_mine";
    fe [[ f ]]( s, "CONTRACT_HVT_CITY_POLICE_STATION", cf, ( -1478.98, 7681.85, 78 ), ( 0, 258.03, 0 ), "cspf_4_auto11461361575472084105", undefined, "mine", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_contract_hvt_cs";
    s.groupid = "customize";
    s.name = "trap_sentry";
    fe [[ f ]]( s, "CONTRACT_HVT_CITY_POLICE_STATION", cf, ( -2059.01, 7550.4, 78 ), ( 0, 165.2, 0 ), "cspf_4_auto11461361575472084105", undefined, "sentry", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_contract_hvt_cs";
    s.groupid = "customize";
    s.name = "trap_mine";
    fe [[ f ]]( s, "CONTRACT_HVT_CITY_POLICE_STATION", cf, ( -1981.19, 7813.94, 78 ), ( 0, 166.03, 0 ), "cspf_4_auto11461361575472084105", undefined, "mine", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_contract_hvt_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s._size_max = ( 42, 60, 636 );
    s._size_min = ( 808, 1062, 256 );
    s.groupid = "hvt_1";
    s.height = 128;
    s.length = "128";
    s.width = "128";
    fe [[ f ]]( s, "CONTRACT_HVT_CITY_POLICE_STATION", cf, ( -1251.52, 8014.7, 78 ), ( 0, 75, 0 ), "cspf_4_auto11461361575472084105", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_contract_hvt_cs";
    s.groupid = "customize";
    s.name = "trap_sentry";
    fe [[ f ]]( s, "CONTRACT_HVT_CITY_POLICE_STATION", cf, ( -1723.36, 8044.62, 78 ), ( 0, 254.4, 0 ), "cspf_4_auto11461361575472084105", undefined, "sentry", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_sat_avalon_city_ob_contract_hvt_cs
// Params 0
// Checksum 0x86e3546a, Offset: 0x601b
// Size: 0x1b7
function function_d9dd7965c51c95d1()
{
    activityinstances = [];
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_activitydefinition_contract_hvt";
    var_881289d7987bc770.cf = "mp_sat_avalon_city_ob_contract_hvt_cs";
    var_881289d7987bc770.scriptstructorigin = ( 7932.45, -10230.4, 1970.11 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [ ( 7952.07, -10194.2, 1970.11 ) ];
    var_881289d7987bc770.var_31ce4477e3543d24 = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.locationradius = [ 1500 ];
    activityinstances[ "CONTRACT_HVT_CITY_TOWNHALL" ] = var_881289d7987bc770;
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_activitydefinition_contract_hvt";
    var_881289d7987bc770.cf = "mp_sat_avalon_city_ob_contract_hvt_cs";
    var_881289d7987bc770.scriptstructorigin = ( -1774.6, 7739.39, 78.06 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [ ( -1764.32, 7779.3, 78.06 ) ];
    var_881289d7987bc770.var_31ce4477e3543d24 = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.locationradius = [ 1500 ];
    activityinstances[ "CONTRACT_HVT_CITY_POLICE_STATION" ] = var_881289d7987bc770;
    return activityinstances;
}

