// script_45c4b0a26fe5609  (hash_045c4b0a26fe5609.gscc) (size: 26448 Bytes / 0x6750 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xc7c189db (3351349723)
// size ...... 26448 (0x6750)
// includes .. 4   (offset: 0x5830)
// strings ... 82  (offset: 0x5850)
// dev strs .. 0   (offset: 0x6750)
// exports ... 16  (offset: 0x5274)
// cseg ...... 0x98b + 0x48e9 (0x5274)
// imports ... 29  (offset: 0x54f4)
// animtree1 . 0   (offset: 0x6750)
// animtree2 . 0   (offset: 0x6750)
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace mp_sat_avalon_q2_ob_activity_supply_drop_cs;

// Namespace mp_sat_avalon_q2_ob_activity_supply_drop_cs
// Params 0, eflags: 0x5
// Checksum 0x91c30196, Offset: 0x9a9
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"mp_sat_avalon_q2_ob_activity_supply_drop_cs", #"activity_common", &function_b39ecd3d51489472, undefined );
}

// Namespace mp_sat_avalon_q2_ob_activity_supply_drop_cs
// Params 0, eflags: 0x4
// Checksum 0xb5d8cf87, Offset: 0x9d2
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace mp_sat_avalon_q2_ob_activity_supply_drop_cs
// Params 0, eflags: 0x4
// Checksum 0x30e31c6b, Offset: 0x9e3
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace mp_sat_avalon_q2_ob_activity_supply_drop_cs
// Params 2
// Checksum 0x5fa6e25a, Offset: 0x9f4
// Size: 0x8c
function main( unused, unused2 )
{
    if ( utility::flag_exist( "mp_sat_avalon_q2_ob_activity_supply_drop_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "mp_sat_avalon_q2_ob_activity_supply_drop_cs" ) )
    {
        return;
    }
    
    activity_common::function_e1df676808c1d1e3( &function_4cd78e661617f3 );
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "mp_sat_avalon_q2_ob_activity_supply_drop_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "mp_sat_avalon_q2_ob_activity_supply_drop_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace mp_sat_avalon_q2_ob_activity_supply_drop_cs
// Params 3, eflags: 0x4
// Checksum 0xb361a8a4, Offset: 0xa88
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "mp_sat_avalon_q2_ob_activity_supply_drop_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "mp_sat_avalon_q2_ob_activity_supply_drop_cs" );
}

// Namespace mp_sat_avalon_q2_ob_activity_supply_drop_cs
// Params 3, eflags: 0x4
// Checksum 0xabad6f37, Offset: 0xb02
// Size: 0x3484
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_supply_drop_cs";
    s.activity_bundle = "sat_activitydefinition_supply_drop";
    s.name = "SUPPLY_DROP_PONY_CLUB";
    fe [[ f ]]( s, "SUPPLY_DROP_PONY_CLUB", cf, ( 30788, 33507.1, 3272.31 ), ( 0, 179.99, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_supply_drop_cs";
    fe [[ f ]]( s, "SUPPLY_DROP_PONY_CLUB", cf, ( 30818.6, 33540.3, 3270.11 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Ambient_AI_Exclusion_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 1500 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_supply_drop_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_DROP_PONY_CLUB", cf, ( 30432.9, 34510.9, 3227.4 ), ( 0, 0, 0 ), "cspf_1_auto16682498061703684439", "cspf_1_auto6616799175904461968", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_supply_drop_cs";
    s.loop_route = "1";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.start_point = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_DROP_PONY_CLUB", cf, ( 30631.5, 34050.5, 3260 ), ( 0, 0, 0 ), "cspf_1_auto13123110924164279121", "cspf_1_auto2703930601506979436", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_supply_drop_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_DROP_PONY_CLUB", cf, ( 30559.8, 34173.5, 3247.1 ), ( 0, 0, 0 ), "cspf_1_auto6616799175904461968", "cspf_1_auto13123110924164279121", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_supply_drop_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_DROP_PONY_CLUB", cf, ( 30610.9, 34037.5, 3260.45 ), ( 0, 0, 0 ), "cspf_1_auto2703930601506979436", "cspf_1_auto4825871672479675685", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_supply_drop_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.preferred_spawnpoint = "1";
    s.reusecooldown = "10";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "supply_drop_rusher";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "SUPPLY_DROP_PONY_CLUB", cf, ( 30369.2, 33845.5, 3295.89 ), ( 0, 297.65, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_supply_drop_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "supply_drop_rusher";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "SUPPLY_DROP_PONY_CLUB", cf, ( 31190.3, 33489.5, 3249.67 ), ( 0, 321.75, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_supply_drop_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.preferred_spawnpoint = "1";
    s.reusecooldown = "10";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "supply_drop_rusher";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "SUPPLY_DROP_PONY_CLUB", cf, ( 30641.6, 32925.7, 3240.38 ), ( 0, 34.29, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_supply_drop_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.preferred_spawnpoint = "1";
    s.reusecooldown = "10";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "supply_drop_long";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "SUPPLY_DROP_PONY_CLUB", cf, ( 30496.9, 33262, 3283.13 ), ( 0, 127.19, 0 ), undefined, "cspf_1_auto14767192989612985585", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_supply_drop_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_DROP_PONY_CLUB", cf, ( 30539.5, 34163.8, 3247.89 ), ( 0, 0, 0 ), "cspf_1_auto4825871672479675685", "cspf_1_auto454672231324881721", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_supply_drop_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_DROP_PONY_CLUB", cf, ( 30407.3, 34503.5, 3227.6 ), ( 0, 0, 0 ), "cspf_1_auto454672231324881721", "cspf_1_auto16682498061703684439", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_supply_drop_cs";
    s.loop_route = "1";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.start_point = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_DROP_PONY_CLUB", cf, ( 30450.1, 33300.8, 3289.86 ), ( 0, 0, 0 ), "cspf_1_auto14767192989612985585", "cspf_1_auto7666011133583537219", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_supply_drop_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_DROP_PONY_CLUB", cf, ( 30466.5, 33333.5, 3287.5 ), ( 0, 0, 0 ), "cspf_1_auto4939346447985470269", "cspf_1_auto14767192989612985585", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_supply_drop_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.preferred_spawnpoint = "1";
    s.reusecooldown = "10";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "supply_drop_long";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "SUPPLY_DROP_PONY_CLUB", cf, ( 30750.3, 33977.9, 3269.41 ), ( 0, 175.73, 0 ), undefined, "cspf_1_auto13123110924164279121", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_supply_drop_cs";
    s.groupid = "reinforcement_spawn_point";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "supply_drop_heli";
    s.variantname = "ai_encounter_spawnpoint";
    s.var_4501e0172e168ddf = "SUPPLY_DROP_PONY_CLUB_VTOL";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "SUPPLY_DROP_PONY_CLUB", cf, ( 30619.4, 33664.6, 3282.8 ), ( 0, 52.03, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_supply_drop_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_DROP_PONY_CLUB", cf, ( 30127.2, 33439.5, 3333.46 ), ( 0, 0, 0 ), "cspf_1_auto7666011133583537219", "cspf_1_auto14187439071877341227", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_supply_drop_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_DROP_PONY_CLUB", cf, ( 30136.5, 33482.1, 3330.21 ), ( 0, 0, 0 ), "cspf_1_auto14187439071877341227", "cspf_1_auto4939346447985470269", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_supply_drop_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.reusecooldown = "10";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "supply_drop_long";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "SUPPLY_DROP_PONY_CLUB", cf, ( 30850.6, 32789.9, 3233.21 ), ( 0, 80.18, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_supply_drop_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "supply_drop_long";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "SUPPLY_DROP_POLICE_STATION", cf, ( 24229.2, 22574.6, 657 ), ( 0, 227.85, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_supply_drop_cs";
    s.activity_bundle = "sat_activitydefinition_supply_drop";
    s.name = "SUPPLY_DROP_POLICE_STATION";
    fe [[ f ]]( s, "SUPPLY_DROP_POLICE_STATION", cf, ( 24125, 22085.7, 648.62 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_supply_drop_cs";
    fe [[ f ]]( s, "SUPPLY_DROP_POLICE_STATION", cf, ( 24023.8, 21953.7, 647.96 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Ambient_AI_Exclusion_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 1800 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_supply_drop_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "supply_drop_long";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "SUPPLY_DROP_POLICE_STATION", cf, ( 23817.2, 22172.9, 647.89 ), ( 0, 289.64, 0 ), undefined, "cspf_2_auto12946859107984935576", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_supply_drop_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "supply_drop_rusher";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "SUPPLY_DROP_POLICE_STATION", cf, ( 24552.7, 21693.7, 655.62 ), ( 0, 183.95, 0 ), undefined, "cspf_2_auto10985510286616758294", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_supply_drop_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "supply_drop_rusher";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "SUPPLY_DROP_POLICE_STATION", cf, ( 24570.9, 22140.7, 674.05 ), ( 0, 13.14, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_supply_drop_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "supply_drop_long";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "SUPPLY_DROP_POLICE_STATION", cf, ( 24079.4, 21848.8, 648.07 ), ( 0, 209.49, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_supply_drop_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "supply_drop_rusher";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "SUPPLY_DROP_POLICE_STATION", cf, ( 23719.9, 22577.4, 647.89 ), ( 0, 283.56, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_supply_drop_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_DROP_POLICE_STATION", cf, ( 24577.4, 20956.2, 657.4 ), ( 0, 255.49, 0 ), "cspf_2_auto10086008083655810301", "cspf_2_auto17186318378131558775", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_supply_drop_cs";
    s.loop_route = "1";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.start_point = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_DROP_POLICE_STATION", cf, ( 24492.1, 21440.3, 657.5 ), ( 0, 255.49, 0 ), "cspf_2_auto10985510286616758294", "cspf_2_auto10660219961900480510", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_supply_drop_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_DROP_POLICE_STATION", cf, ( 24421.7, 21419.8, 657.5 ), ( 0, 255.49, 0 ), "cspf_2_auto17186318378131558775", "cspf_2_auto10985510286616758294", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_supply_drop_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_DROP_POLICE_STATION", cf, ( 24649.2, 20978.1, 657.43 ), ( 0, 255.49, 0 ), "cspf_2_auto10660219961900480510", "cspf_2_auto10086008083655810301", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_supply_drop_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_DROP_POLICE_STATION", cf, ( 23860.5, 21574.7, 647.89 ), ( 0, 90, 0 ), "cspf_2_auto13909117920583077262", "cspf_2_auto5997880360490674760", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_supply_drop_cs";
    s.loop_route = "1";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.start_point = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_DROP_POLICE_STATION", cf, ( 23687, 21970.5, 648 ), ( 0, 90, 0 ), "cspf_2_auto12946859107984935576", "cspf_2_auto3236879109939915617", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_supply_drop_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_DROP_POLICE_STATION", cf, ( 23794, 21549.5, 648 ), ( 0, 90, 0 ), "cspf_2_auto3236879109939915617", "cspf_2_auto13909117920583077262", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_supply_drop_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_DROP_POLICE_STATION", cf, ( 23680.1, 22300.2, 647.89 ), ( 0, 90, 0 ), "cspf_2_auto5997880360490674760", "cspf_2_auto12566832342219487728", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_supply_drop_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_DROP_POLICE_STATION", cf, ( 23609.1, 22284.7, 647.89 ), ( 0, 90, 0 ), "cspf_2_auto12566832342219487728", "cspf_2_auto12946859107984935576", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_supply_drop_cs";
    s.groupid = "reinforcement_spawn_point";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "supply_drop_heli";
    s.variantname = "ai_encounter_spawnpoint";
    s.var_4501e0172e168ddf = "SUPPLY_DROP_POLICE_STATION_VTOL";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "SUPPLY_DROP_POLICE_STATION", cf, ( 24479.3, 22252.7, 666.89 ), ( 0, 137.52, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_supply_drop_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.reverse_route = "1";
    s.start_point = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_DROP_WINERY", cf, ( 5925.35, 42521.8, 346.5 ), ( 0, 145.67, 0 ), "cspf_3_auto6967969328445233916", "cspf_3_auto18314157671860194755", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_supply_drop_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.reverse_route = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_DROP_WINERY", cf, ( 5982.16, 42913.1, 311.18 ), ( 0, 145.67, 0 ), "cspf_3_auto18314157671860194755", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_supply_drop_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "supply_drop_rusher";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "SUPPLY_DROP_WINERY", cf, ( 6138.59, 42453, 354.63 ), ( 0, 235.81, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_supply_drop_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.preferred_spawnpoint = "1";
    s.reusecooldown = "10";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "supply_drop_rusher";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "SUPPLY_DROP_WINERY", cf, ( 6727.4, 43987.5, 359.53 ), ( 0, 70.52, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_supply_drop_cs";
    s.activity_bundle = "sat_activitydefinition_supply_drop";
    s.name = "SUPPLY_DROP_WINERY";
    fe [[ f ]]( s, "SUPPLY_DROP_WINERY", cf, ( 6717.21, 43220.3, 339.78 ), ( 0, 179.99, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_supply_drop_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "supply_drop_rusher";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "SUPPLY_DROP_WINERY", cf, ( 7079.68, 43296.7, 385.59 ), ( 0, 174.98, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_supply_drop_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.preferred_spawnpoint = "1";
    s.reusecooldown = "10";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "supply_drop_long";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "SUPPLY_DROP_WINERY", cf, ( 7126.86, 43756.4, 388.77 ), ( 0, 83.57, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_supply_drop_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.preferred_spawnpoint = "1";
    s.reusecooldown = "10";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "supply_drop_long";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "SUPPLY_DROP_WINERY", cf, ( 5993.49, 42924, 310.93 ), ( 0, 249.66, 0 ), undefined, "cspf_3_auto6967969328445233916", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_supply_drop_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.preferred_spawnpoint = "1";
    s.reusecooldown = "10";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "supply_drop_long";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "SUPPLY_DROP_WINERY", cf, ( 6629.25, 42419.5, 351.13 ), ( 0, 292.15, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_supply_drop_cs";
    s.groupid = "reinforcement_spawn_point";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "supply_drop_heli";
    s.variantname = "ai_encounter_spawnpoint";
    s.var_4501e0172e168ddf = "SUPPLY_DROP_WINERY_VTOL";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "SUPPLY_DROP_WINERY", cf, ( 6439.51, 42695.4, 330.08 ), ( 0, 107.44, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_supply_drop_cs";
    fe [[ f ]]( s, "SUPPLY_DROP_WINERY", cf, ( 6721.36, 43262.8, 340.8 ), ( 0, 132, 0 ), "activity_nexus_spatial_zone", undefined, "Ambient_AI_Exclusion_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 1500 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_supply_drop_cs";
    fe [[ f ]]( s, "SUPPLY_DROP_WINERY_COURTYARD", cf, ( 21548.5, 55627.6, 728.28 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Ambient_AI_Exclusion_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 1800 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_supply_drop_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_DROP_WINERY_COURTYARD", cf, ( 21640.9, 55279.3, 704.87 ), ( 0, 0, 0 ), "cspf_4_auto8730033650691297412", "cspf_4_auto13502523302604739339", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_supply_drop_cs";
    s.loop_route = "1";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.start_point = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_DROP_WINERY_COURTYARD", cf, ( 21807.1, 55573.9, 705.62 ), ( 0, 0, 0 ), "cspf_4_auto3405723873040577077", "cspf_4_auto8730033650691297412", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_supply_drop_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_DROP_WINERY_COURTYARD", cf, ( 21612.4, 55294.7, 704.88 ), ( 0, 0, 0 ), "cspf_4_auto13502523302604739339", "cspf_4_auto14663956197539872676", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_supply_drop_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_DROP_WINERY_COURTYARD", cf, ( 21780.9, 55587.9, 705.14 ), ( 0, 0, 0 ), "cspf_4_auto14663956197539872676", "cspf_4_auto3405723873040577077", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_supply_drop_cs";
    s.groupid = "reinforcement_spawn_point";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "supply_drop_heli";
    s.variantname = "ai_encounter_spawnpoint";
    s.var_4501e0172e168ddf = "SUPPLY_DROP_WINERY_COURTYARD_VTOL";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "SUPPLY_DROP_WINERY_COURTYARD", cf, ( 21578.7, 55830.4, 703.3 ), ( 0, 211.77, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_supply_drop_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "supply_drop_rusher";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "SUPPLY_DROP_WINERY_COURTYARD", cf, ( 21480.8, 55215.6, 704.38 ), ( 357.15, 235.25, -5.73 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_supply_drop_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "supply_drop_rusher";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "SUPPLY_DROP_WINERY_COURTYARD", cf, ( 21911.1, 55884.6, 704.34 ), ( 357.06, 32.52, -5.68 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_supply_drop_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "supply_drop_rusher";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "SUPPLY_DROP_WINERY_COURTYARD", cf, ( 21153, 55898.7, 713.04 ), ( 5.23, 203.89, 3.69 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_supply_drop_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "supply_drop_long";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "SUPPLY_DROP_WINERY_COURTYARD", cf, ( 21830.9, 55717.6, 704.88 ), ( 6.38, 240.35, 0.49 ), undefined, "cspf_4_auto3405723873040577077", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_supply_drop_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "supply_drop_long";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "SUPPLY_DROP_WINERY_COURTYARD", cf, ( 21324.6, 55752.1, 705.81 ), ( 359.2, 298.12, 4.11 ), undefined, "cspf_4_auto11920740636010421194", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_supply_drop_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.parachute_landing_point = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "supply_drop_long";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "SUPPLY_DROP_WINERY_COURTYARD", cf, ( 21455.7, 56154.8, 715.33 ), ( 4.34, 152.13, -5.78 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_supply_drop_cs";
    s.loop_route = "1";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.start_point = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_DROP_WINERY_COURTYARD", cf, ( 21355.3, 55717.9, 705.08 ), ( 0, 230, 0 ), "cspf_4_auto11920740636010421194", "cspf_4_auto8522918706175210106", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_supply_drop_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_DROP_WINERY_COURTYARD", cf, ( 21454.7, 55449.1, 704.89 ), ( 0, 230, 0 ), "cspf_4_auto8522918706175210106", "cspf_4_auto3033924117764053010", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_supply_drop_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_DROP_WINERY_COURTYARD", cf, ( 21327.3, 55705.5, 705.36 ), ( 0, 230, 0 ), "cspf_4_auto18094109966050202540", "cspf_4_auto11920740636010421194", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_supply_drop_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_DROP_WINERY_COURTYARD", cf, ( 21424.7, 55438.5, 704.9 ), ( 0, 230, 0 ), "cspf_4_auto3033924117764053010", "cspf_4_auto18094109966050202540", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_supply_drop_cs";
    s.activity_bundle = "sat_activitydefinition_supply_drop";
    s.name = "SUPPLY_DROP_WINERY_COURTYARD";
    fe [[ f ]]( s, "SUPPLY_DROP_WINERY_COURTYARD", cf, ( 21656.3, 55650.5, 704.88 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace mp_sat_avalon_q2_ob_activity_supply_drop_cs
// Params 0, eflags: 0x4
// Checksum 0x48225617, Offset: 0x3f8e
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace mp_sat_avalon_q2_ob_activity_supply_drop_cs
// Params 0
// Checksum 0x713275e9, Offset: 0x3f98
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "mp_sat_avalon_q2_ob_activity_supply_drop_cs" );
}

// Namespace mp_sat_avalon_q2_ob_activity_supply_drop_cs
// Params 0
// Checksum 0xce27f5f6, Offset: 0x3fae
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

// Namespace mp_sat_avalon_q2_ob_activity_supply_drop_cs
// Params 4
// Checksum 0x525f2695, Offset: 0x401d
// Size: 0xa5
function function_d4323822d7042e5a( var_4312b79c960726b6, fe, us, cf = "mp_sat_avalon_q2_ob_activity_supply_drop_cs" )
{
    switch ( var_4312b79c960726b6 )
    {
        case #"hash_785b5cb446176f98":
            function_c54f2c368d025dc0( fe, us, cf );
            break;
        case #"hash_b7ffe59b690d4ce2":
            function_80e4ddd5a8a15d7a( fe, us, cf );
            break;
        case #"hash_6345c68c53f848f":
            function_8e06e1a0a49c74c7( fe, us, cf );
            break;
        case #"hash_40167766353e06cb":
            function_17183ed8f741e8f3( fe, us, cf );
            break;
    }
}

// Namespace mp_sat_avalon_q2_ob_activity_supply_drop_cs
// Params 3
// Checksum 0xe92e8a7a, Offset: 0x40ca
// Size: 0x3c6
function function_c54f2c368d025dc0( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_supply_drop_cs";
    s.name = "supply_drop_starter";
    fe [[ f ]]( s, "SUPPLY_DROP_PONY_CLUB", cf, ( 47831.5, 27707.7, 904.56 ), ( 0, 34.75, 0 ), undefined, "cspf_5_auto4299280297148095640", "SUPPLY_DROP_PONY_CLUB", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_supply_drop_cs";
    s.name = "supply_drop_point";
    fe [[ f ]]( s, "SUPPLY_DROP_PONY_CLUB", cf, ( 30763.1, 33488.2, 3274.5 ), ( 0, 0, 0 ), "cspf_5_auto4299280297148095640", undefined, "east", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 800 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_supply_drop_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    s.script_accel = "350";
    fe [[ f ]]( s, "SUPPLY_DROP_PONY_CLUB", cf, ( 30566.4, 33588.4, 3900.44 ), ( 0, 158.28, 0 ), "SUPPLY_DROP_PONY_CLUB_VTOL", "cspf_5_auto1182212845156663505", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_supply_drop_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "SUPPLY_DROP_PONY_CLUB", cf, ( 35269.7, 47637.9, 11124 ), ( 359.47, 81.38, 0.5 ), "cspf_5_auto11651856099433349027", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_supply_drop_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "SUPPLY_DROP_PONY_CLUB", cf, ( 41574.6, 24813.6, 10328.8 ), ( 0, 186.06, 0 ), undefined, "cspf_5_auto17011491461436723005", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150, 1 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_supply_drop_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "SUPPLY_DROP_PONY_CLUB", cf, ( 29949.6, 40655.4, 8229.02 ), ( 359.47, 81.38, 0.5 ), "cspf_5_auto1182212845156663505", "cspf_5_auto11651856099433349027", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_supply_drop_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "SUPPLY_DROP_PONY_CLUB", cf, ( 34966.8, 25356.9, 9251.27 ), ( 0, 46.12, 0 ), "cspf_5_auto17011491461436723005", "SUPPLY_DROP_PONY_CLUB_VTOL", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
}

// Namespace mp_sat_avalon_q2_ob_activity_supply_drop_cs
// Params 3
// Checksum 0x3fc25a1b, Offset: 0x4498
// Size: 0x3ca
function function_80e4ddd5a8a15d7a( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_supply_drop_cs";
    s.name = "supply_drop_starter";
    fe [[ f ]]( s, "SUPPLY_DROP_POLICE_STATION", cf, ( 33546, 17362.1, 1208.67 ), ( 0, 151, 0 ), "cspf_6_auto16356335374032275085", "cspf_6_auto323975276734225313", "SUPPLY_DROP_POLICE_STATION", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_supply_drop_cs";
    s.name = "supply_drop_point";
    fe [[ f ]]( s, "SUPPLY_DROP_POLICE_STATION", cf, ( 24122.6, 22081.8, 648.6 ), ( 0, 0, 0 ), "cspf_6_auto323975276734225313", undefined, "east", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 700 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_supply_drop_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    s.script_accel = "350";
    fe [[ f ]]( s, "SUPPLY_DROP_POLICE_STATION", cf, ( 24443.5, 22200, 1384.94 ), ( 0, 208.66, 0 ), "SUPPLY_DROP_POLICE_STATION_VTOL", "cspf_6_auto11066642277287114567", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_supply_drop_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "SUPPLY_DROP_POLICE_STATION", cf, ( 7058.43, 1668.7, 8608.52 ), ( 359.47, 131.76, 0.5 ), "cspf_6_auto15540340438790789204", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_supply_drop_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "SUPPLY_DROP_POLICE_STATION", cf, ( 34099.3, 10309.8, 7813.27 ), ( 0, 99.73, 0 ), undefined, "cspf_6_auto4782930881798624685", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150, 1 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_supply_drop_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "SUPPLY_DROP_POLICE_STATION", cf, ( 21034.2, 21628.4, 5713.52 ), ( 359.47, 131.76, 0.5 ), "cspf_6_auto11066642277287114567", "cspf_6_auto15540340438790789204", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_supply_drop_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "SUPPLY_DROP_POLICE_STATION", cf, ( 31619.4, 16730.7, 6735.77 ), ( 0, 96.5, 0 ), "cspf_6_auto4782930881798624685", "SUPPLY_DROP_POLICE_STATION_VTOL", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
}

// Namespace mp_sat_avalon_q2_ob_activity_supply_drop_cs
// Params 3
// Checksum 0x4b998936, Offset: 0x486a
// Size: 0x3c6
function function_8e06e1a0a49c74c7( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_supply_drop_cs";
    s.name = "supply_drop_starter";
    fe [[ f ]]( s, "SUPPLY_DROP_WINERY", cf, ( 14416.2, 30897.3, 1913.97 ), ( 0, 334.69, 0 ), undefined, "cspf_7_auto323975276734225313", "SUPPLY_DROP_WINERY", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_supply_drop_cs";
    s.name = "supply_drop_point";
    fe [[ f ]]( s, "SUPPLY_DROP_WINERY", cf, ( 6723.94, 43194.3, 337.69 ), ( 0, 0, 0 ), "cspf_7_auto323975276734225313", undefined, "north", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 1000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_supply_drop_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    s.script_accel = "350";
    fe [[ f ]]( s, "SUPPLY_DROP_WINERY", cf, ( 6468.9, 42619.2, 945.44 ), ( 0, 200.62, 0 ), "SUPPLY_DROP_WINERY_VTOL", "cspf_7_auto1794466632915145380", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_supply_drop_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "SUPPLY_DROP_WINERY", cf, ( -12088.8, 48915.7, 8169.02 ), ( 359.47, 146.4, 0.5 ), "cspf_7_auto12023408449177663872", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_supply_drop_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "SUPPLY_DROP_WINERY", cf, ( 19205.2, 50074.9, 7373.77 ), ( 0, 242.63, 0 ), undefined, "cspf_7_auto14491155304466615714", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150, 1 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_supply_drop_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "SUPPLY_DROP_WINERY", cf, ( -1046.1, 46463.9, 5274.02 ), ( 359.47, 146.4, 0.5 ), "cspf_7_auto1794466632915145380", "cspf_7_auto12023408449177663872", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_supply_drop_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "SUPPLY_DROP_WINERY", cf, ( 14377.3, 44730.4, 6296.27 ), ( 0, 111.14, 0 ), "cspf_7_auto14491155304466615714", "SUPPLY_DROP_WINERY_VTOL", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
}

// Namespace mp_sat_avalon_q2_ob_activity_supply_drop_cs
// Params 3
// Checksum 0x7956e90e, Offset: 0x4c38
// Size: 0x3c6
function function_17183ed8f741e8f3( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_supply_drop_cs";
    s.name = "supply_drop_point_north";
    fe [[ f ]]( s, "SUPPLY_DROP_WINERY_COURTYARD", cf, ( 21541.4, 55608.8, 705.03 ), ( 0, 0, 0 ), "cspf_8_auto14869932031561022685", undefined, "north", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 600 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_supply_drop_cs";
    s.name = "supply_drop_starter";
    fe [[ f ]]( s, "SUPPLY_DROP_WINERY_COURTYARD", cf, ( 24848, 44526.8, 1222.43 ), ( 0, 270.25, 0 ), undefined, "cspf_8_auto14869932031561022685", "SUPPLY_DROP_WINERY_COURTYARD", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_supply_drop_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    s.script_accel = "350";
    fe [[ f ]]( s, "SUPPLY_DROP_WINERY_COURTYARD", cf, ( 21625.4, 55750.2, 1320.94 ), ( 0, 200.62, 0 ), "SUPPLY_DROP_WINERY_COURTYARD_VTOL", "cspf_8_auto13636386745524065521", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_supply_drop_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "SUPPLY_DROP_WINERY_COURTYARD", cf, ( 3067.67, 62046.7, 8544.52 ), ( 359.47, 146.4, 0.5 ), "cspf_8_auto10862599176249370781", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_supply_drop_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "SUPPLY_DROP_WINERY_COURTYARD", cf, ( 34361.7, 63205.9, 7749.27 ), ( 0, 242.63, 0 ), undefined, "cspf_8_auto12335630103685196776", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150, 1 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_supply_drop_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "SUPPLY_DROP_WINERY_COURTYARD", cf, ( 14110.4, 59594.9, 5649.52 ), ( 359.47, 146.4, 0.5 ), "cspf_8_auto13636386745524065521", "cspf_8_auto10862599176249370781", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_supply_drop_cs";
    s.groupid = "reinforcement_spawn_point";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "SUPPLY_DROP_WINERY_COURTYARD", cf, ( 29533.8, 57861.4, 6671.77 ), ( 0, 111.14, 0 ), "cspf_8_auto12335630103685196776", "SUPPLY_DROP_WINERY_COURTYARD_VTOL", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
}

// Namespace mp_sat_avalon_q2_ob_activity_supply_drop_cs
// Params 0
// Checksum 0x478dffb8, Offset: 0x5006
// Size: 0x26d
function function_d9dd7965c51c95d1()
{
    activityinstances = [];
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_activitydefinition_supply_drop";
    var_881289d7987bc770.cf = "mp_sat_avalon_q2_ob_activity_supply_drop_cs";
    var_881289d7987bc770.scriptstructorigin = ( 30788, 33507.1, 3272.31 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [];
    var_881289d7987bc770.var_31ce4477e3543d24 = [];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [];
    var_881289d7987bc770.locationradius = [];
    activityinstances[ "SUPPLY_DROP_PONY_CLUB" ] = var_881289d7987bc770;
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_activitydefinition_supply_drop";
    var_881289d7987bc770.cf = "mp_sat_avalon_q2_ob_activity_supply_drop_cs";
    var_881289d7987bc770.scriptstructorigin = ( 24125, 22085.7, 648.62 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [];
    var_881289d7987bc770.var_31ce4477e3543d24 = [];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [];
    var_881289d7987bc770.locationradius = [];
    activityinstances[ "SUPPLY_DROP_POLICE_STATION" ] = var_881289d7987bc770;
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_activitydefinition_supply_drop";
    var_881289d7987bc770.cf = "mp_sat_avalon_q2_ob_activity_supply_drop_cs";
    var_881289d7987bc770.scriptstructorigin = ( 6717.21, 43220.3, 339.78 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [];
    var_881289d7987bc770.var_31ce4477e3543d24 = [];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [];
    var_881289d7987bc770.locationradius = [];
    activityinstances[ "SUPPLY_DROP_WINERY" ] = var_881289d7987bc770;
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_activitydefinition_supply_drop";
    var_881289d7987bc770.cf = "mp_sat_avalon_q2_ob_activity_supply_drop_cs";
    var_881289d7987bc770.scriptstructorigin = ( 21656.3, 55650.5, 704.88 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [];
    var_881289d7987bc770.var_31ce4477e3543d24 = [];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [];
    var_881289d7987bc770.locationradius = [];
    activityinstances[ "SUPPLY_DROP_WINERY_COURTYARD" ] = var_881289d7987bc770;
    return activityinstances;
}

