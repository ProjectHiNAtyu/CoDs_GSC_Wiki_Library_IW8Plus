// script_4ab17c8203ffefa8  (hash_4ab17c8203ffefa8.gscc) (size: 26012 Bytes / 0x659c / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x9bb3159b (2612204955)
// size ...... 26012 (0x659c)
// includes .. 4   (offset: 0x5628)
// strings ... 97  (offset: 0x5648)
// dev strs .. 0   (offset: 0x659c)
// exports ... 13  (offset: 0x5144)
// cseg ...... 0x9fe + 0x4746 (0x5144)
// imports ... 26  (offset: 0x534c)
// animtree1 . 0   (offset: 0x659c)
// animtree2 . 0   (offset: 0x659c)
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace mp_sat_avalon_quad_03_ob_contract_supply_chain;

// Namespace mp_sat_avalon_quad_03_ob_contract_supply_chain
// Params 0, eflags: 0x5
// Checksum 0x2c5dbcde, Offset: 0xa1c
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"mp_sat_avalon_quad_03_ob_contract_supply_chain", #"activity_common", &function_b39ecd3d51489472, undefined );
}

// Namespace mp_sat_avalon_quad_03_ob_contract_supply_chain
// Params 0, eflags: 0x4
// Checksum 0xdff110bd, Offset: 0xa45
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace mp_sat_avalon_quad_03_ob_contract_supply_chain
// Params 0, eflags: 0x4
// Checksum 0x5acac351, Offset: 0xa56
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace mp_sat_avalon_quad_03_ob_contract_supply_chain
// Params 2
// Checksum 0x947ea5ce, Offset: 0xa67
// Size: 0x8c
function main( unused, unused2 )
{
    if ( utility::flag_exist( "mp_sat_avalon_quad_03_ob_contract_supply_chain" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "mp_sat_avalon_quad_03_ob_contract_supply_chain" ) )
    {
        return;
    }
    
    activity_common::function_e1df676808c1d1e3( &function_4cd78e661617f3 );
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "mp_sat_avalon_quad_03_ob_contract_supply_chain" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "mp_sat_avalon_quad_03_ob_contract_supply_chain" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace mp_sat_avalon_quad_03_ob_contract_supply_chain
// Params 3, eflags: 0x4
// Checksum 0xd948779e, Offset: 0xafb
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "mp_sat_avalon_quad_03_ob_contract_supply_chain" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "mp_sat_avalon_quad_03_ob_contract_supply_chain" );
}

// Namespace mp_sat_avalon_quad_03_ob_contract_supply_chain
// Params 3, eflags: 0x4
// Checksum 0xc6217add, Offset: 0xb75
// Size: 0x3605
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_contract_supply_chain";
    s.activity_bundle = "sat_activitydefinition_supply_chain";
    s.name = "SUPPLY_CHAIN_Q3";
    fe [[ f ]]( s, "SUPPLY_CHAIN_Q3", cf, ( -24268.5, -13150, 1484.15 ), ( 0, 348, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_contract_supply_chain";
    fe [[ f ]]( s, "SUPPLY_CHAIN_Q3", cf, ( -24065.5, -13117.9, 1621.37 ), ( 346.56, 261.77, 1.92 ), "activity_nexus_instance_joiner", undefined, "SUPPLY_CHAIN_Q3", "instance_link", "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_contract_supply_chain";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "sc_rooftop";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "SUPPLY_CHAIN_Q3", cf, ( -25970, -21390.4, 1112 ), ( 0, 0, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_contract_supply_chain";
    s._size_max = ( 346, 32, 526 );
    s._size_min = ( 1206, 1634, 32 );
    s.var_5afd49978f924648 = "1";
    s.var_a8568d8e0b0b6076 = "1";
    s.var_3f3960eb7318312d = "1";
    s.default_goal_radius = "-1";
    s.height = 128;
    s.length = "128";
    s.script_stealthgroup = "-1";
    s.script_string = "enc_sat_ob_supply_chain_guild_hideout";
    s.var_95e2cee7aca5aaae = "1";
    s.width = "128";
    fe [[ f ]]( s, "SUPPLY_CHAIN_Q3", cf, ( -25289.8, -20214.8, 922.63 ), ( 0, 348, 0 ), "SUPPLY_CHAIN_Q3_phase_1", undefined, "noent_volume_ai_encounter_cs", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_contract_supply_chain";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "sc_rooftop";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "SUPPLY_CHAIN_Q3", cf, ( -26012, -21555, 1112 ), ( 0, 0, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_contract_supply_chain";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "sc_rooftop";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "SUPPLY_CHAIN_Q3", cf, ( -25742.2, -20303.5, 1095.05 ), ( 0, 32, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_contract_supply_chain";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "sc_rooftop";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "SUPPLY_CHAIN_Q3", cf, ( -26281.9, -20159.7, 1093.81 ), ( 0, 32, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_contract_supply_chain";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "sc_standard";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "SUPPLY_CHAIN_Q3", cf, ( -25342.3, -20628.5, 968.97 ), ( 0, 252, 0 ), undefined, "cspf_1_auto4581366894831472256", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_contract_supply_chain";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "sc_standard";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "SUPPLY_CHAIN_Q3", cf, ( -25610.8, -21122.3, 968.97 ), ( 0, 24, 0 ), undefined, "cspf_1_auto5806701560084589720", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_contract_supply_chain";
    s.ai_interaction = "idle_cellphone";
    s.var_9a1a6bc9877cfff7 = "-1";
    s.groupid = "Phase_1_infiltrate_hideout";
    fe [[ f ]]( s, "SUPPLY_CHAIN_Q3", cf, ( -25570, -21128.6, 967.92 ), ( 0, 0, 0 ), "cspf_1_auto5806701560084589720", undefined, "info_act", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_contract_supply_chain";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "sc_standard";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "SUPPLY_CHAIN_Q3", cf, ( -25844.2, -21126, 976 ), ( 0, 348, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_contract_supply_chain";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "sc_standard";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "SUPPLY_CHAIN_Q3", cf, ( -25807.4, -20952.9, 976 ), ( 0, 348, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_contract_supply_chain";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "sc_standard";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "SUPPLY_CHAIN_Q3", cf, ( -25212.4, -20653.9, 968.97 ), ( 0, 252, 0 ), undefined, "cspf_1_auto1161972303366824619", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_contract_supply_chain";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "sc_dawg";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "SUPPLY_CHAIN_Q3", cf, ( -25283.7, -20633, 968.97 ), ( 0, 260, 0 ), undefined, "cspf_1_auto5111938665235281657", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_contract_supply_chain";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "2";
    s.min_wait_time = "1";
    s.move_speed = "1";
    s.reverse_route = "1";
    s.start_point = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_CHAIN_Q3", cf, ( -25315.9, -20754.7, 964.83 ), ( 0, 260, 0 ), "cspf_1_auto5111938665235281657", "cspf_1_auto14926644375483764668", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_contract_supply_chain";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "2";
    s.min_wait_time = "1";
    s.move_speed = "1";
    s.reverse_route = "1";
    s.start_point = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_CHAIN_Q3", cf, ( -25365.9, -20740.8, 964.83 ), ( 0, 260, 0 ), "cspf_1_auto4581366894831472256", "cspf_1_auto5603453428292952358", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_contract_supply_chain";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "2";
    s.min_wait_time = "1";
    s.move_speed = "1";
    s.reverse_route = "1";
    s.start_point = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_CHAIN_Q3", cf, ( -25245.5, -20740.7, 964.83 ), ( 0, 260, 0 ), "cspf_1_auto1161972303366824619", "cspf_1_auto18123220474331023940", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_contract_supply_chain";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_CHAIN_Q3", cf, ( -25578.5, -21688.7, 964.88 ), ( 0, 0, 0 ), "cspf_1_auto14926644375483764668", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_contract_supply_chain";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_CHAIN_Q3", cf, ( -25642.9, -21678, 964.88 ), ( 0, 0, 0 ), "cspf_1_auto5603453428292952358", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_contract_supply_chain";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_CHAIN_Q3", cf, ( -25512.7, -21694.9, 964.88 ), ( 0, 0, 0 ), "cspf_1_auto18123220474331023940", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_contract_supply_chain";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "guild_bot_charging_pad";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "SUPPLY_CHAIN_Q3", cf, ( -21625.9, -30320.1, 457.96 ), ( 0, 184, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_contract_supply_chain";
    s._size_max = ( 594, 678, 240 );
    s._size_min = ( 732, 556.51, 32 );
    s.var_5afd49978f924648 = "1";
    s.var_a8568d8e0b0b6076 = "1";
    s.var_3f3960eb7318312d = "1";
    s.default_goal_radius = "-1";
    s.height = 128;
    s.length = "128";
    s.script_stealthgroup = "-1";
    s.script_string = "enc_sat_ob_supply_chain_charging_station";
    s.var_95e2cee7aca5aaae = "1";
    s.width = "128";
    fe [[ f ]]( s, "SUPPLY_CHAIN_Q3", cf, ( -21777.7, -30566.9, 449.87 ), ( 0, 97, 0 ), "SUPPLY_CHAIN_Q3_phase_2_1", undefined, "noent_volume_ai_encounter_cs", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_contract_supply_chain";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "sc_standard";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "SUPPLY_CHAIN_Q3", cf, ( -22017.7, -30721.7, 601.5 ), ( 0, 300.14, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_contract_supply_chain";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "sc_dawg";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "SUPPLY_CHAIN_Q3", cf, ( -21824, -30660.5, 449.6 ), ( 0, 277.26, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_contract_supply_chain";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "sc_standard";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "SUPPLY_CHAIN_Q3", cf, ( -22031.6, -30820.3, 449.75 ), ( 0, 249.26, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_contract_supply_chain";
    fe [[ f ]]( s, "SUPPLY_CHAIN_Q3", cf, ( -24192, -12985, 1290.22 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "OB_Spacer_Spatial_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 1000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_contract_supply_chain";
    s._size_max = ( 813, 766, 246 );
    s._size_min = ( 930, 600, 32 );
    s.var_5afd49978f924648 = "1";
    s.var_a8568d8e0b0b6076 = "1";
    s.var_3f3960eb7318312d = "1";
    s.default_goal_radius = "-1";
    s.height = 128;
    s.length = "128";
    s.script_stealthgroup = "-1";
    s.script_string = "enc_sat_ob_supply_chain_charging_station";
    s.var_95e2cee7aca5aaae = "1";
    s.width = "128";
    fe [[ f ]]( s, "SUPPLY_CHAIN_Q3", cf, ( -27495.5, -30621.9, 880.84 ), ( 0, 319.14, 0 ), "SUPPLY_CHAIN_Q3_phase_2_2", undefined, "noent_volume_ai_encounter_cs", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_contract_supply_chain";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "sc_standard";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "SUPPLY_CHAIN_Q3", cf, ( -27113.8, -30860.7, 880.84 ), ( 0, 139.7, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_contract_supply_chain";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "guild_bot_charging_pad";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "SUPPLY_CHAIN_Q3", cf, ( -27300.6, -30301.2, 888.85 ), ( 0, 230, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_contract_supply_chain";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "guild_bot_charging_pad";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "SUPPLY_CHAIN_Q3", cf, ( -27014.5, -30542.2, 888.86 ), ( 0, 230, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_contract_supply_chain";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "sc_standard";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "SUPPLY_CHAIN_Q3", cf, ( -27517.6, -30101.5, 879.34 ), ( 0, 226.7, 0 ), undefined, "cspf_1_auto13079024191553130578", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_contract_supply_chain";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "guild_bot_charging_pad";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "SUPPLY_CHAIN_Q3", cf, ( -27109.1, -30463.1, 888.85 ), ( 0, 230, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_contract_supply_chain";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_CHAIN_Q3", cf, ( -27628.2, -30229.2, 880.81 ), ( 0, 327.4, 0 ), "cspf_1_auto8909532935723383254", "cspf_1_auto15134021160024204541", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_contract_supply_chain";
    s.loop_route = "1";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "2";
    s.min_wait_time = "1";
    s.move_speed = "1";
    s.start_point = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_CHAIN_Q3", cf, ( -27768.6, -30393.2, 880.84 ), ( 0, 327.4, 0 ), "cspf_1_auto13079024191553130578", "cspf_1_auto8909532935723383254", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_contract_supply_chain";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_CHAIN_Q3", cf, ( -27321.1, -30489.8, 880.84 ), ( 0, 327.4, 0 ), "cspf_1_auto15134021160024204541", "cspf_1_auto7690661959837686918", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_contract_supply_chain";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_CHAIN_Q3", cf, ( -27463, -30650.3, 880.84 ), ( 0, 327.4, 0 ), "cspf_1_auto7690661959837686918", "cspf_1_auto13079024191553130578", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_contract_supply_chain";
    fe [[ f ]]( s, "SUPPLY_CHAIN_Q3", cf, ( -34612.1, -41813.3, 795.87 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "OB_Spacer_Spatial_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 250 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_contract_supply_chain";
    s.groupid = "Phase_4_neutralize_vtol";
    fe [[ f ]]( s, "SUPPLY_CHAIN_Q3", cf, ( -34725.1, -41441.1, 795.87 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Ambient_AI_Exclusion_Zone_neutralize_vtol", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 2000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_contract_supply_chain";
    s._size_max = ( 2150, 32, 770 );
    s._size_min = ( 32, 1392, 32 );
    s.var_5afd49978f924648 = "1";
    s.var_a8568d8e0b0b6076 = "1";
    s.var_3f3960eb7318312d = "1";
    s.default_goal_radius = "-1";
    s.height = 128;
    s.length = "128";
    s.script_stealthgroup = "-1";
    s.script_string = "enc_sat_ob_supply_chain_delivery_site";
    s.var_95e2cee7aca5aaae = "1";
    s.width = "128";
    fe [[ f ]]( s, "SUPPLY_CHAIN_Q3", cf, ( -33770.4, -41997.8, 377.42 ), ( 0, 180.28, 0 ), "SUPPLY_CHAIN_Q3_phase_4", undefined, "noent_volume_ai_encounter_cs", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_contract_supply_chain";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "guild_bot_charging_pad";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "SUPPLY_CHAIN_Q3", cf, ( -32426.1, -22156.2, 689.06 ), ( 0, 261.5, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_contract_supply_chain";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "sc_standard";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "SUPPLY_CHAIN_Q3", cf, ( -32141.9, -22635.6, 745.87 ), ( 0, 81.47, 0 ), undefined, "cspf_1_auto12396521716148611024", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_contract_supply_chain";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "sc_standard";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "SUPPLY_CHAIN_Q3", cf, ( -31545.9, -22441.7, 691.56 ), ( 0, 169.17, 0 ), undefined, "cspf_1_auto4762281419051140735", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_contract_supply_chain";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "guild_bot_charging_pad";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "SUPPLY_CHAIN_Q3", cf, ( -32404.6, -22003.6, 699.87 ), ( 0, 261.5, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_contract_supply_chain";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "guild_bot_charging_pad";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "SUPPLY_CHAIN_Q3", cf, ( -32415.1, -22079.4, 691.87 ), ( 0, 261.5, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_contract_supply_chain";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_CHAIN_Q3", cf, ( -31791.1, -22209.1, 684.25 ), ( 0, 327.4, 0 ), "cspf_1_auto17689770994563425579", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_contract_supply_chain";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "2";
    s.min_wait_time = "1";
    s.move_speed = "1";
    s.reverse_route = "1";
    s.start_point = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "SUPPLY_CHAIN_Q3", cf, ( -31881.3, -22641.1, 744.3 ), ( 0, 327.4, 0 ), "cspf_1_auto4762281419051140735", "cspf_1_auto17689770994563425579", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_contract_supply_chain";
    s.ai_interaction = "idle_press_check";
    s.var_9a1a6bc9877cfff7 = "-1";
    s.groupid = "Phase_2_sabotage_charge_stations";
    fe [[ f ]]( s, "SUPPLY_CHAIN_Q3", cf, ( -32137.2, -22612.8, 745.86 ), ( 0, 81, 0 ), "cspf_1_auto12396521716148611024", undefined, "info_act", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_contract_supply_chain";
    s._size_max = ( 828.56, 496, 240 );
    s._size_min = ( 670.906, 450.19, 50 );
    s.var_5afd49978f924648 = "1";
    s.var_a8568d8e0b0b6076 = "1";
    s.var_3f3960eb7318312d = "1";
    s.default_goal_radius = "-1";
    s.height = 128;
    s.length = "128";
    s.script_stealthgroup = "-1";
    s.script_string = "enc_sat_ob_supply_chain_charging_station";
    s.var_95e2cee7aca5aaae = "1";
    s.width = "128";
    fe [[ f ]]( s, "SUPPLY_CHAIN_Q3", cf, ( -32175.1, -22372.7, 653.04 ), ( 0, 354.75, 0 ), "SUPPLY_CHAIN_Q3_phase_2_3", undefined, "noent_volume_ai_encounter_cs", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_contract_supply_chain";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "sc_standard";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "SUPPLY_CHAIN_Q3", cf, ( -35290.5, -41037.2, 689.54 ), ( 0, 185.53, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_contract_supply_chain";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "sc_standard";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "SUPPLY_CHAIN_Q3", cf, ( -35182.3, -41016.3, 685.66 ), ( 0, 185.53, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_contract_supply_chain";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "sc_standard";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "SUPPLY_CHAIN_Q3", cf, ( -35566.1, -41406, 681.5 ), ( 0, 185.53, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_contract_supply_chain";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "sc_standard";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "SUPPLY_CHAIN_Q3", cf, ( -35582.3, -41215.8, 678.6 ), ( 0, 185.53, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_contract_supply_chain";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "sc_standard";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "SUPPLY_CHAIN_Q3", cf, ( -35663.7, -41326.3, 675.99 ), ( 0, 185.53, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_contract_supply_chain";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "sc_standard";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "SUPPLY_CHAIN_Q3", cf, ( -25729.7, -21634.5, 968.97 ), ( 0, 0.37, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_contract_supply_chain";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "sc_dawg";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "SUPPLY_CHAIN_Q3", cf, ( -27496.6, -30766.5, 880.84 ), ( 0, 95.5, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_contract_supply_chain";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "guild_bot_charging_pad";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "SUPPLY_CHAIN_Q3", cf, ( -21615.3, -30447.3, 457.92 ), ( 0, 184, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_contract_supply_chain";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "sc_dawg";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "SUPPLY_CHAIN_Q3", cf, ( -32233.1, -22365.5, 707.74 ), ( 0, 348.59, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_contract_supply_chain";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "sc_standard";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "SUPPLY_CHAIN_Q3", cf, ( -35226.2, -41117.1, 685.71 ), ( 0, 185.53, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_contract_supply_chain";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "sc_standard";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "SUPPLY_CHAIN_Q3", cf, ( -35514.4, -40640.3, 697.71 ), ( 0, 185.53, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_contract_supply_chain";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "sc_standard";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "SUPPLY_CHAIN_Q3", cf, ( -35530.6, -40450.2, 692.94 ), ( 0, 185.53, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_contract_supply_chain";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "sc_standard";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "SUPPLY_CHAIN_Q3", cf, ( -35611.9, -40560.6, 702.02 ), ( 0, 185.53, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_contract_supply_chain";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "sc_dawg";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "SUPPLY_CHAIN_Q3", cf, ( -35251.6, -41348.8, 683.87 ), ( 0, 159.64, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_contract_supply_chain";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "sc_dawg";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "SUPPLY_CHAIN_Q3", cf, ( -35245.3, -40700.1, 684.93 ), ( 0, 185.53, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_contract_supply_chain";
    s.groupid = "Phase_1_infiltrate_hideout";
    s.name = "script_struct_nexus_spatial_zone";
    fe [[ f ]]( s, "SUPPLY_CHAIN_Q3", cf, ( -25952.9, -20888.1, 986.62 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Ambient_AI_Exclusion_Zone_infiltrate_hideout", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 2000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_contract_supply_chain";
    s.groupid = "Phase_2_sabotage_charge_stations";
    fe [[ f ]]( s, "SUPPLY_CHAIN_Q3", cf, ( -21672.5, -30834.2, 445.25 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Ambient_AI_Exclusion_Zone_sabotage_charge_stations_1", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 2000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_contract_supply_chain";
    s.groupid = "Phase_2_sabotage_charge_stations";
    fe [[ f ]]( s, "SUPPLY_CHAIN_Q3", cf, ( -27090.7, -30607.6, 880.84 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Ambient_AI_Exclusion_Zone_sabotage_charge_stations_2", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 2000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_contract_supply_chain";
    s.groupid = "Phase_2_sabotage_charge_stations";
    fe [[ f ]]( s, "SUPPLY_CHAIN_Q3", cf, ( -32239.2, -22158.1, 691.97 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Ambient_AI_Exclusion_Zone_sabotage_charge_stations_3", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 2000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_contract_supply_chain";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "guild_bot_charging_pad";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "SUPPLY_CHAIN_Q3", cf, ( -21592.2, -30705.4, 457.83 ), ( 0, 184, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace mp_sat_avalon_quad_03_ob_contract_supply_chain
// Params 0, eflags: 0x4
// Checksum 0x83fa1183, Offset: 0x4182
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace mp_sat_avalon_quad_03_ob_contract_supply_chain
// Params 0
// Checksum 0x1b1baad3, Offset: 0x418c
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "mp_sat_avalon_quad_03_ob_contract_supply_chain" );
}

// Namespace mp_sat_avalon_quad_03_ob_contract_supply_chain
// Params 0
// Checksum 0x763f7de2, Offset: 0x41a2
// Size: 0x66
function function_4cd78e661617f3()
{
    activityinfostruct = {};
    activityinfostruct.name = "REV_OB_SUPPLY_CHAIN";
    activityinfostruct.scriptbundle = "sat_activitydefinition_supply_chain";
    activityinfostruct.mainfunction = &main;
    activityinfostruct.var_934f068483ae4ddb = &function_d4323822d7042e5a;
    activityinfostruct.metadatafunction = &function_d9dd7965c51c95d1;
    return activityinfostruct;
}

// Namespace mp_sat_avalon_quad_03_ob_contract_supply_chain
// Params 4
// Checksum 0xed587ead, Offset: 0x4211
// Size: 0x57
function function_d4323822d7042e5a( var_4312b79c960726b6, fe, us, cf = "mp_sat_avalon_quad_03_ob_contract_supply_chain" )
{
    switch ( var_4312b79c960726b6 )
    {
        case #"hash_8859878b186d674d":
            function_8e0445d8b9d34185( fe, us, cf );
            break;
    }
}

// Namespace mp_sat_avalon_quad_03_ob_contract_supply_chain
// Params 3
// Checksum 0x8b9f297f, Offset: 0x4270
// Size: 0xe1d
function function_8e0445d8b9d34185( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_contract_supply_chain";
    s.groupid = "Phase_2_sabotage_charge_stations";
    s.name = "master_struct_p2";
    fe [[ f ]]( s, "SUPPLY_CHAIN_Q3", cf, ( -24181.6, -13605.8, 1358.79 ), ( 0, 268, 0 ), undefined, "SUPPLY_CHAIN_Q3_phase_2", "sabotage_charge_stations", "cspf_2_2", "instance_link", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_contract_supply_chain";
    s.groupid = "Phase_1_infiltrate_hideout";
    s.name = "master_struct_p1";
    fe [[ f ]]( s, "SUPPLY_CHAIN_Q3", cf, ( -24290.7, -13606.2, 1358.79 ), ( 0, 268, 0 ), undefined, "SUPPLY_CHAIN_Q3_phase_1", "infiltrate_hideout", "cspf_2_1", "instance_link", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_contract_supply_chain";
    s.groupid = "Phase_3_intercept_convoy";
    s.name = "master_struct_p3";
    fe [[ f ]]( s, "SUPPLY_CHAIN_Q3", cf, ( -24071.5, -13623.6, 1358.79 ), ( 0, 268, 0 ), undefined, "SUPPLY_CHAIN_Q3_phase_3", "intercept_convoy", "cspf_2_3", "instance_link", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_contract_supply_chain";
    s.groupid = "Phase_4_neutralize_vtol";
    s.name = "master_struct_p4";
    fe [[ f ]]( s, "SUPPLY_CHAIN_Q3", cf, ( -23943.2, -13631.2, 1358.79 ), ( 0, 268, 0 ), undefined, "SUPPLY_CHAIN_Q3_phase_4", "neutralize_vtol", "cspf_2_4", "instance_link", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_contract_supply_chain";
    s.groupid = "Phase_1_infiltrate_hideout";
    s.name = "terminal";
    fe [[ f ]]( s, "SUPPLY_CHAIN_Q3", cf, ( -26178.4, -20721.8, 976 ), ( 0, 166, 0 ), undefined, "cspf_2_auto11903991139237270409", "terminal", undefined, "cspf_2_1", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_contract_supply_chain";
    s.groupid = "Phase_1_infiltrate_hideout";
    s.name = "mine";
    fe [[ f ]]( s, "SUPPLY_CHAIN_Q3", cf, ( -26474.4, -21410.9, 1112 ), ( 0, 0, 0 ), undefined, undefined, "mine", undefined, "cspf_2_1", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_contract_supply_chain";
    s.groupid = "Phase_2_sabotage_charge_stations";
    s.name = "charge_station";
    s.script_label = "1";
    fe [[ f ]]( s, "SUPPLY_CHAIN_Q3", cf, ( -21672.5, -30834.2, 445.25 ), ( 0, 184, -4 ), undefined, undefined, "charge_station", undefined, "cspf_2_2", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_contract_supply_chain";
    s.groupid = "Phase_2_sabotage_charge_stations";
    s.name = "charge_station";
    s.script_label = "2";
    fe [[ f ]]( s, "SUPPLY_CHAIN_Q3", cf, ( -27052.8, -30786, 880.84 ), ( 0, 140, 0 ), undefined, undefined, "charge_station", undefined, "cspf_2_2", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_contract_supply_chain";
    s.groupid = "Phase_2_sabotage_charge_stations";
    s.name = "sentry";
    s.script_label = "1";
    fe [[ f ]]( s, "SUPPLY_CHAIN_Q3", cf, ( -21964.3, -30809.5, 449.75 ), ( 0, 272, 0 ), undefined, undefined, "sentry", undefined, "cspf_2_2", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_contract_supply_chain";
    s.groupid = "Phase_2_sabotage_charge_stations";
    s.name = "mine";
    s.script_label = "2";
    fe [[ f ]]( s, "SUPPLY_CHAIN_Q3", cf, ( -27365.8, -30036, 882.71 ), ( 0, 0, 0 ), undefined, undefined, "mine", undefined, "cspf_2_2", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_contract_supply_chain";
    s.groupid = "Phase_2_sabotage_charge_stations";
    s.name = "charge_station";
    s.script_label = "3";
    fe [[ f ]]( s, "SUPPLY_CHAIN_Q3", cf, ( -32228.7, -22172.3, 692.05 ), ( 0, 257, 0 ), undefined, undefined, "charge_station", undefined, "cspf_2_2", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_contract_supply_chain";
    s.groupid = "Phase_2_sabotage_charge_stations";
    s.name = "sentry";
    s.script_label = "3";
    fe [[ f ]]( s, "SUPPLY_CHAIN_Q3", cf, ( -32193.1, -22618.4, 748.34 ), ( 358.48, 83.6, 2.26 ), undefined, undefined, "sentry", undefined, "cspf_2_2", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_contract_supply_chain";
    s.groupid = "Phase_4_neutralize_vtol";
    s.ishelistruct = 1;
    s.name = "vtol_take_off_route";
    fe [[ f ]]( s, "SUPPLY_CHAIN_Q3", cf, ( -26479.2, -57146.5, 7842.74 ), ( 0, 0, 0 ), "cspf_2_auto12199925243335930023", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_contract_supply_chain";
    s.groupid = "Phase_3_intercept_convoy";
    s.name = "vtol_spawn_point";
    fe [[ f ]]( s, "SUPPLY_CHAIN_Q3", cf, ( -29905.9, -28757, 907.89 ), ( 0, 0, 0 ), undefined, undefined, "spawn_vtol", undefined, "cspf_2_3", ( 0, 0, 0 ), ( 0, 0, 0 ), 500 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_contract_supply_chain";
    s.groupid = "Phase_4_neutralize_vtol";
    s.ishelistruct = 1;
    s.name = "vtol_take_off_route";
    fe [[ f ]]( s, "SUPPLY_CHAIN_Q3", cf, ( -34772.3, -41571.9, 987 ), ( 0, 0, 0 ), undefined, "cspf_2_auto6132878008016450952", "vtol_takeoff_path", undefined, "cspf_2_4", ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 10, 1 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_contract_supply_chain";
    s.groupid = "Phase_4_neutralize_vtol";
    s.ishelistruct = 1;
    s.name = "vtol_take_off_route";
    fe [[ f ]]( s, "SUPPLY_CHAIN_Q3", cf, ( -34165.2, -41917.7, 4485.24 ), ( 0, 0, 0 ), "cspf_2_auto6132878008016450952", "cspf_2_auto12199925243335930023", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_contract_supply_chain";
    s.groupid = "Phase_4_neutralize_vtol";
    s.ishelistruct = 1;
    s.name = "vtol_landing_route";
    s.script_speed = "120";
    fe [[ f ]]( s, "SUPPLY_CHAIN_Q3", cf, ( -41109.5, -35193.9, 2914.89 ), ( 0, 0, 0 ), "cspf_2_auto8447064945313824996", "cspf_2_auto15614284250895840543", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 120 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_contract_supply_chain";
    s.groupid = "Phase_4_neutralize_vtol";
    s.ishelistruct = 1;
    s.name = "vtol_landing_route";
    s.script_speed = "40";
    fe [[ f ]]( s, "SUPPLY_CHAIN_Q3", cf, ( -24576.3, -28019.5, 1935.95 ), ( 0, 196.26, 0 ), undefined, "cspf_2_auto11781934826428837231", "vtol_landing_path", undefined, "cspf_2_4", ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 40, 1 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_contract_supply_chain";
    s.groupid = "Phase_4_neutralize_vtol";
    s.ishelistruct = 1;
    s.name = "vtol_landing_route";
    s.script_speed = "120";
    fe [[ f ]]( s, "SUPPLY_CHAIN_Q3", cf, ( -36676.7, -32048.3, 2062.78 ), ( 0, 0, 0 ), "cspf_2_auto11781934826428837231", "cspf_2_auto8447064945313824996", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 120 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_contract_supply_chain";
    s.groupid = "Phase_4_neutralize_vtol";
    s.ishelistruct = 1;
    s.name = "vtol_landing_route";
    s.script_speed = "60";
    fe [[ f ]]( s, "SUPPLY_CHAIN_Q3", cf, ( -39554.7, -42450, 3186.66 ), ( 0, 337.96, 0 ), "cspf_2_auto15614284250895840543", "cspf_2_auto15393059389530799857", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 60 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_contract_supply_chain";
    s.groupid = "Phase_4_neutralize_vtol";
    s.ishelistruct = 1;
    s.name = "vtol_landing_route";
    s.script_speed = "60";
    fe [[ f ]]( s, "SUPPLY_CHAIN_Q3", cf, ( -34774.5, -41569.8, 2772.96 ), ( 0, 0, 0 ), "cspf_2_auto15393059389530799857", "cspf_2_auto3662131125566985286", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 60 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_contract_supply_chain";
    s.groupid = "Phase_4_neutralize_vtol";
    s.ishelistruct = 1;
    s.name = "vtol_landing_route";
    s.script_speed = "10";
    fe [[ f ]]( s, "SUPPLY_CHAIN_Q3", cf, ( -34774.5, -41569.8, 987 ), ( 0, 0, 0 ), "cspf_2_auto3662131125566985286", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 10 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_contract_supply_chain";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s._size_max = ( 352, 528, 209 );
    s._size_min = ( 357, 747, 32 );
    s.groupid = "Phase_1_infiltrate_hideout";
    s.height = 128;
    s.length = "128";
    s.width = "128";
    fe [[ f ]]( s, "SUPPLY_CHAIN_Q3", cf, ( -26155.7, -20813.8, 1007 ), ( 0, 346.6, 0 ), "cspf_2_auto11903991139237270409", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_sat_avalon_quad_03_ob_contract_supply_chain
// Params 0
// Checksum 0x69e4e23a, Offset: 0x5095
// Size: 0xae
function function_d9dd7965c51c95d1()
{
    activityinstances = [];
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_activitydefinition_supply_chain";
    var_881289d7987bc770.cf = "mp_sat_avalon_quad_03_ob_contract_supply_chain";
    var_881289d7987bc770.scriptstructorigin = ( -24268.5, -13150, 1484.15 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [];
    var_881289d7987bc770.var_31ce4477e3543d24 = [];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [];
    var_881289d7987bc770.locationradius = [];
    activityinstances[ "SUPPLY_CHAIN_Q3" ] = var_881289d7987bc770;
    return activityinstances;
}

