// script_8f54c92e24bb00  (hash_008f54c92e24bb00.gscc) (size: 29062 Bytes / 0x7186 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x70673e83 (1885814403)
// size ...... 29062 (0x7186)
// includes .. 4   (offset: 0x60be)
// strings ... 116 (offset: 0x60de)
// dev strs .. 0   (offset: 0x7186)
// exports ... 15  (offset: 0x5b4a)
// cseg ...... 0xd62 + 0x4de8 (0x5b4a)
// imports ... 28  (offset: 0x5da2)
// animtree1 . 0   (offset: 0x7186)
// animtree2 . 0   (offset: 0x7186)
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace mp_sat_avalon_quad_03_ob_activity_vtol_takedown_cs;

// Namespace mp_sat_avalon_quad_03_ob_activity_vtol_takedown_cs
// Params 0, eflags: 0x5
// Checksum 0x80fcb65f, Offset: 0xd80
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"mp_sat_avalon_quad_03_ob_activity_vtol_takedown_cs", #"activity_common", &function_b39ecd3d51489472, undefined );
}

// Namespace mp_sat_avalon_quad_03_ob_activity_vtol_takedown_cs
// Params 0, eflags: 0x4
// Checksum 0x9280aeb8, Offset: 0xda9
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace mp_sat_avalon_quad_03_ob_activity_vtol_takedown_cs
// Params 0, eflags: 0x4
// Checksum 0x17bb7d54, Offset: 0xdba
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace mp_sat_avalon_quad_03_ob_activity_vtol_takedown_cs
// Params 2
// Checksum 0x916a386e, Offset: 0xdcb
// Size: 0x8c
function main( unused, unused2 )
{
    if ( utility::flag_exist( "mp_sat_avalon_quad_03_ob_activity_vtol_takedown_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "mp_sat_avalon_quad_03_ob_activity_vtol_takedown_cs" ) )
    {
        return;
    }
    
    activity_common::function_e1df676808c1d1e3( &function_4cd78e661617f3 );
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "mp_sat_avalon_quad_03_ob_activity_vtol_takedown_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "mp_sat_avalon_quad_03_ob_activity_vtol_takedown_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace mp_sat_avalon_quad_03_ob_activity_vtol_takedown_cs
// Params 3, eflags: 0x4
// Checksum 0x9439c99b, Offset: 0xe5f
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "mp_sat_avalon_quad_03_ob_activity_vtol_takedown_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "mp_sat_avalon_quad_03_ob_activity_vtol_takedown_cs" );
}

// Namespace mp_sat_avalon_quad_03_ob_activity_vtol_takedown_cs
// Params 3, eflags: 0x4
// Checksum 0x447ec659, Offset: 0xed9
// Size: 0x2ad8
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_vtol_takedown_cs";
    s.activity_bundle = "sat_activitydef_activity_helitakedown";
    s.name = "HELI_TAKEDOWN_COAST_GUARD";
    s.var_265c4f33e2a6daa7 = "1";
    fe [[ f ]]( s, "HELI_TAKEDOWN_COAST_GUARD", cf, ( -46880.7, -10278.2, 212.28 ), ( 0, 139.7, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_vtol_takedown_cs";
    fe [[ f ]]( s, "HELI_TAKEDOWN_COAST_GUARD", cf, ( -46873.1, -10365.7, 193.58 ), ( 0, 139.7, 0 ), "activity_nexus_spatial_zone", undefined, "join_radius", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 2200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_vtol_takedown_cs";
    fe [[ f ]]( s, "HELI_TAKEDOWN_COAST_GUARD", cf, ( -47006.3, -10787.6, 297 ), ( 0, 280, 0 ), "activity_nexus_spatial_zone", undefined, "Ambient_AI_Exclusion_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 1800 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_vtol_takedown_cs";
    fe [[ f ]]( s, "HELI_TAKEDOWN_COAST_GUARD", cf, ( -46840.4, -10753.1, 285.98 ), ( 0, 141.08, 0 ), "activity_nexus_spatial_zone", undefined, "Awareness_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 5000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_vtol_takedown_cs";
    s.activity_bundle = "sat_activitydef_activity_helitakedown";
    s.name = "HELI_TAKEDOWN_Q3_FORT";
    s.var_265c4f33e2a6daa7 = "1";
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q3_FORT", cf, ( -34538.4, -41719.7, 836.5 ), ( 0, 139.7, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_vtol_takedown_cs";
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q3_FORT", cf, ( -34746.7, -41524.9, 837.68 ), ( 0, 335, 0 ), "activity_nexus_spatial_zone", undefined, "join_radius", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 2500 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_vtol_takedown_cs";
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q3_FORT", cf, ( -34676.6, -41525.1, 839.14 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Ambient_AI_Exclusion_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 1500 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_vtol_takedown_cs";
    s._size_max = ( 1672.25, 1609.25, 572 );
    s._size_min = ( 120, 84.5, 32 );
    s.var_5afd49978f924648 = "1";
    s.var_a8568d8e0b0b6076 = "1";
    s.var_3f3960eb7318312d = "1";
    s.default_goal_radius = "-1";
    s.height = 128;
    s.length = "128";
    s.script_stealthgroup = "-1";
    s.script_string = "sat_heli_takedown_enc_soldier";
    s.var_95e2cee7aca5aaae = "1";
    s.width = "128";
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q3_FORT", cf, ( -35451.8, -42251.5, 655.25 ), ( 0, 0, 0 ), "encounter_HELI_TAKEDOWN_Q3_FORT_RADIANT", undefined, "noent_volume_ai_encounter_cs", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_vtol_takedown_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "500";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "ht_dawg";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q3_FORT", cf, ( -35403.4, -42254.3, 687.13 ), ( 0, 71.53, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_vtol_takedown_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "500";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "ht_short";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q3_FORT", cf, ( -35064.3, -41122.3, 684.97 ), ( 0, 148.77, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_vtol_takedown_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "500";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "ht_long";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q3_FORT", cf, ( -33863.7, -40885.4, 693.34 ), ( 0, 202.37, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_vtol_takedown_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "500";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "ht_short";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q3_FORT", cf, ( -35161.5, -41982.2, 683.77 ), ( 0, 335.37, 0 ), undefined, "cspf_2_auto1311748202089054075", "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_vtol_takedown_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "500";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "ht_short";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q3_FORT", cf, ( -35480.8, -41887.2, 692.37 ), ( 0, 86.44, 0 ), undefined, "cspf_2_auto16377838395494831733", "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_vtol_takedown_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "500";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "ht_long";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q3_FORT", cf, ( -34427.3, -40714, 692.56 ), ( 0, 190.41, 0 ), undefined, "cspf_2_auto18026478021365398769", "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_vtol_takedown_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "500";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "ht_long";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q3_FORT", cf, ( -34575.7, -41059.1, 687.74 ), ( 0, 90.88, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_vtol_takedown_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "500";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "ht_short";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q3_FORT", cf, ( -33930.7, -41328.3, 685.45 ), ( 0, 260.23, 0 ), undefined, "cspf_2_auto4699825305385922030", "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_vtol_takedown_cs";
    s.groupid = "ai_spawnpoints";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.reverse_route = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q3_FORT", cf, ( -35517.6, -41367.7, 690.58 ), ( 0, 133.08, 0 ), "cspf_2_auto7734762739429880322", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_vtol_takedown_cs";
    s.groupid = "ai_spawnpoints";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.reverse_route = "1";
    s.start_point = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q3_FORT", cf, ( -35481.4, -41602.6, 693.69 ), ( 0, 179.8, 0 ), "cspf_2_auto16377838395494831733", "cspf_2_auto7734762739429880322", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_vtol_takedown_cs";
    s.groupid = "ai_spawnpoints";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.reverse_route = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q3_FORT", cf, ( -33999.2, -41906.6, 683 ), ( 0, 329, 0 ), "cspf_2_auto16126410121668116991", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_vtol_takedown_cs";
    s.groupid = "ai_spawnpoints";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.reverse_route = "1";
    s.start_point = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q3_FORT", cf, ( -33989.8, -41628.5, 680.86 ), ( 0, 86.72, 0 ), "cspf_2_auto4699825305385922030", "cspf_2_auto16126410121668116991", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_vtol_takedown_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "500";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "ht_short";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q3_FORT", cf, ( -34185.2, -42209.5, 682.73 ), ( 0, 121.54, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_vtol_takedown_cs";
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q3_FORT", cf, ( -34568, -41565.8, 842.87 ), ( 0, 141.08, 0 ), "activity_nexus_spatial_zone", undefined, "Awareness_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 5000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_vtol_takedown_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q3_FORT", cf, ( -35060.7, -41985.7, 684.67 ), ( 0, 0, 0 ), "cspf_2_auto7082820761050667755", "cspf_2_auto1311748202089054075", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_vtol_takedown_cs";
    s.loop_route = "1";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.start_point = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q3_FORT", cf, ( -35056.8, -42015.5, 677.33 ), ( 0, 0, 0 ), "cspf_2_auto1311748202089054075", "cspf_2_auto4136164668155088838", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_vtol_takedown_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q3_FORT", cf, ( -34374.9, -42011.5, 675.17 ), ( 0, 0, 0 ), "cspf_2_auto4136164668155088838", "cspf_2_auto15374399479689393699", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_vtol_takedown_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q3_FORT", cf, ( -34374.8, -41989.7, 680.44 ), ( 0, 0, 0 ), "cspf_2_auto15374399479689393699", "cspf_2_auto7082820761050667755", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_vtol_takedown_cs";
    s.loop_route = "1";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.start_point = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q3_FORT", cf, ( -34659.8, -40781.9, 688.8 ), ( 0, 0, 0 ), "cspf_2_auto18026478021365398769", "cspf_2_auto12509695647493388639", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_vtol_takedown_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q3_FORT", cf, ( -35053.5, -40797.9, 690.29 ), ( 0, 0, 0 ), "cspf_2_auto12509695647493388639", "cspf_2_auto7616548914729763322", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_vtol_takedown_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q3_FORT", cf, ( -35171.2, -40708.1, 690.58 ), ( 0, 0, 0 ), "cspf_2_auto7616548914729763322", "cspf_2_auto10710237804357424065", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_vtol_takedown_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q3_FORT", cf, ( -35053.8, -40676.8, 689.94 ), ( 0, 0, 0 ), "cspf_2_auto10710237804357424065", "cspf_2_auto8547026237123340583", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_vtol_takedown_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q3_FORT", cf, ( -34659.6, -40787.3, 688.5 ), ( 0, 0, 0 ), "cspf_2_auto8547026237123340583", "cspf_2_auto1103987685760736280", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_vtol_takedown_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q3_FORT", cf, ( -34431.9, -40732.2, 692.21 ), ( 0, 0, 0 ), "cspf_2_auto1103987685760736280", "cspf_2_auto18026478021365398769", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_vtol_takedown_cs";
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q3_FORT", cf, ( -34676.6, -41525.1, 839.14 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "OB_Spacer_Spatial_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 1500 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_vtol_takedown_cs";
    s.activity_bundle = "sat_activitydef_activity_helitakedown";
    s.name = "HELI_TAKEDOWN_Q3_ISLAND";
    s.var_265c4f33e2a6daa7 = "1";
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q3_ISLAND", cf, ( -29764.6, -57056.4, 505 ), ( 0, 355.43, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_vtol_takedown_cs";
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q3_ISLAND", cf, ( -29757.8, -57030, 595.14 ), ( 0, 355.43, 0 ), "activity_nexus_spatial_zone", undefined, "join_radius", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 1800 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_vtol_takedown_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "500";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "ht_short";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q3_ISLAND", cf, ( -30560.4, -57367.7, 272 ), ( 0, 86.38, 0 ), undefined, "cspf_3_auto10863636412982703467", "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_vtol_takedown_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.reverse_route = "1";
    s.start_point = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q3_ISLAND", cf, ( -30407.4, -56595.7, 270.95 ), ( 0, 143.65, 0 ), "cspf_3_auto10863636412982703467", "cspf_3_auto10847846362951288487", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_vtol_takedown_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.reverse_route = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q3_ISLAND", cf, ( -29844.9, -56182.6, 272 ), ( 0, 143.65, 0 ), "cspf_3_auto10847846362951288487", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_vtol_takedown_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "500";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "ht_short";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q3_ISLAND", cf, ( -30102.6, -56675.3, 318 ), ( 0, 184.82, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_vtol_takedown_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "500";
    s.preferred_spawnpoint = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "ht_long";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q3_ISLAND", cf, ( -30125.4, -56837.5, 318 ), ( 0, 198.29, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_vtol_takedown_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "500";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "ht_long";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q3_ISLAND", cf, ( -29996.2, -56004.6, 400 ), ( 0, 176.42, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_vtol_takedown_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "500";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "ht_long";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q3_ISLAND", cf, ( -30212.8, -55878.3, 400 ), ( 0, 256.79, 0 ), undefined, "cspf_3_auto7147688311945460799", "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_vtol_takedown_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "500";
    s.preferred_spawnpoint = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "ht_long";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q3_ISLAND", cf, ( -30782.4, -57409.2, 272 ), ( 0, 165.43, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_vtol_takedown_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "500";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "ht_long";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q3_ISLAND", cf, ( -30565, -56463.5, 431 ), ( 0, 355.16, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_vtol_takedown_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "500";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "ht_short";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q3_ISLAND", cf, ( -30611.2, -55933.2, 432 ), ( 0, 300.84, 0 ), undefined, "cspf_3_auto2068967809947837597", "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_vtol_takedown_cs";
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q3_ISLAND", cf, ( -29889.4, -56678.8, 339.35 ), ( 0, 141.08, 0 ), "activity_nexus_spatial_zone", undefined, "Awareness_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 5000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_vtol_takedown_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "500";
    s.preferred_spawnpoint = "1";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "ht_short";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q3_ISLAND", cf, ( -30493.6, -56115.9, 432 ), ( 0, 345.22, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_vtol_takedown_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.reverse_route = "1";
    s.start_point = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q3_ISLAND", cf, ( -30314.8, -56330.8, 271.09 ), ( 0, 53.65, 0 ), "cspf_3_auto7147688311945460799", "cspf_3_auto7850959231254042433", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_vtol_takedown_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.reverse_route = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q3_ISLAND", cf, ( -30529.1, -57101.9, 272 ), ( 0, 53.65, 0 ), "cspf_3_auto7850959231254042433", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_vtol_takedown_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.reverse_route = "1";
    s.start_point = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q3_ISLAND", cf, ( -30532.7, -56186.9, 432 ), ( 0, 143.65, 0 ), "cspf_3_auto2068967809947837597", "cspf_3_auto18292375127441977161", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_vtol_takedown_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "2";
    s.move_speed = "1";
    s.reverse_route = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q3_ISLAND", cf, ( -30748, -56808.3, 430.61 ), ( 0, 143.65, 0 ), "cspf_3_auto18292375127441977161", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_vtol_takedown_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "500";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "ht_short";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q3_ISLAND", cf, ( -29690.9, -56462.9, 318 ), ( 0, 109.89, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_vtol_takedown_cs";
    s._size_max = ( 1591.95, 2269.13, 572 );
    s._size_min = ( -32.7837, -652.264, 32 );
    s.var_5afd49978f924648 = "1";
    s.var_a8568d8e0b0b6076 = "1";
    s.var_3f3960eb7318312d = "1";
    s.default_goal_radius = "-1";
    s.height = 128;
    s.length = "128";
    s.script_stealthgroup = "-1";
    s.script_string = "sat_heli_takedown_enc_soldier";
    s.var_95e2cee7aca5aaae = "1";
    s.width = "128";
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q3_ISLAND", cf, ( -30625.7, -58257.6, 146.74 ), ( 0, 20.43, 0 ), "encounter_HELI_TAKEDOWN_Q3_ISLAND_RADIANT", undefined, "noent_volume_ai_encounter_cs", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_vtol_takedown_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "500";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "ht_dawg";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q3_ISLAND", cf, ( -30316.1, -56922, 318 ), ( 0, 170.74, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_vtol_takedown_cs";
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q3_ISLAND", cf, ( -30122.2, -56792.6, 522.88 ), ( 0, 20.43, 0 ), "activity_nexus_spatial_zone", undefined, "Ambient_AI_Exclusion_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 1500 );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace mp_sat_avalon_quad_03_ob_activity_vtol_takedown_cs
// Params 0, eflags: 0x4
// Checksum 0x86ee8c23, Offset: 0x39b9
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace mp_sat_avalon_quad_03_ob_activity_vtol_takedown_cs
// Params 0
// Checksum 0x566a14d6, Offset: 0x39c3
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "mp_sat_avalon_quad_03_ob_activity_vtol_takedown_cs" );
}

// Namespace mp_sat_avalon_quad_03_ob_activity_vtol_takedown_cs
// Params 0
// Checksum 0xd1a9a328, Offset: 0x39d9
// Size: 0x66
function function_4cd78e661617f3()
{
    activityinfostruct = {};
    activityinfostruct.name = "REV_OB_HELI_TAKEDOWN";
    activityinfostruct.scriptbundle = "sat_activitydef_activity_helitakedown";
    activityinfostruct.mainfunction = &main;
    activityinfostruct.var_934f068483ae4ddb = &function_d4323822d7042e5a;
    activityinfostruct.metadatafunction = &function_d9dd7965c51c95d1;
    return activityinfostruct;
}

// Namespace mp_sat_avalon_quad_03_ob_activity_vtol_takedown_cs
// Params 4
// Checksum 0xa402009, Offset: 0x3a48
// Size: 0x8b
function function_d4323822d7042e5a( var_4312b79c960726b6, fe, us, cf = "mp_sat_avalon_quad_03_ob_activity_vtol_takedown_cs" )
{
    switch ( var_4312b79c960726b6 )
    {
        case #"hash_df9c516418db98da":
            function_bfa5ef5bb2f4f7c2( fe, us, cf );
            break;
        case #"hash_f984fa135dc6f0a":
            function_fd03b7ac738a7c92( fe, us, cf );
            break;
        case #"hash_86adc9da77d2578e":
            function_4a506e7281ee3f76( fe, us, cf );
            break;
    }
}

// Namespace mp_sat_avalon_quad_03_ob_activity_vtol_takedown_cs
// Params 3
// Checksum 0x75a7384b, Offset: 0x3adb
// Size: 0x757
function function_bfa5ef5bb2f4f7c2( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_vtol_takedown_cs";
    fe [[ f ]]( s, "HELI_TAKEDOWN_COAST_GUARD", cf, ( -46897.7, -10472.8, 1145.42 ), ( 0, 260.8, 0 ), "HELI_TAKEDOWN_COAST_GUARD", undefined, undefined, "cspf_4_1", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_vtol_takedown_cs";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "HELI_TAKEDOWN_COAST_GUARD", cf, ( -46947.8, -10852.1, 419.34 ), ( 0, 343.1, 0 ), "s_heli_takedown_heli_spawn", "cspf_4_auto8494757589517366665", undefined, "cspf_4_2", "cspf_4_1", ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 8, 1 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_vtol_takedown_cs";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "HELI_TAKEDOWN_COAST_GUARD", cf, ( -45536, -11325.6, 1668.1 ), ( 0, 27.68, 0 ), "cspf_4_auto8494757589517366665", "cspf_4_auto4612352738519139850", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 8 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_vtol_takedown_cs";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "HELI_TAKEDOWN_COAST_GUARD", cf, ( -44560.5, -11681.1, 2438.1 ), ( 0, 335, 0 ), "cspf_4_auto4612352738519139850", "cspf_4_auto10095321859284440761", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 8 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_vtol_takedown_cs";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "HELI_TAKEDOWN_COAST_GUARD", cf, ( -43975.5, -11915.5, 3060.5 ), ( 0, 335, 0 ), "cspf_4_auto10095321859284440761", "cspf_4_auto9117064054671232171", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 8 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_vtol_takedown_cs";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "HELI_TAKEDOWN_COAST_GUARD", cf, ( -42430, -12484, 3558.5 ), ( 0, 335, 0 ), "cspf_4_auto9117064054671232171", "cspf_4_auto678961591699957337", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 8 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_vtol_takedown_cs";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "HELI_TAKEDOWN_COAST_GUARD", cf, ( -41686, -12755, 4072.5 ), ( 0, 335, 0 ), "cspf_4_auto678961591699957337", "cspf_4_auto17798406878246190170", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 8 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_vtol_takedown_cs";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "HELI_TAKEDOWN_COAST_GUARD", cf, ( -40580.5, -13110, 4543 ), ( 0, 335, 0 ), "cspf_4_auto17798406878246190170", "cspf_4_auto14348649893522508367", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 8 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_vtol_takedown_cs";
    fe [[ f ]]( s, "HELI_TAKEDOWN_COAST_GUARD", cf, ( -12627.8, -41774.6, 5245.01 ), ( 0, 8.47, 0 ), "heli_leave", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_vtol_takedown_cs";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "HELI_TAKEDOWN_COAST_GUARD", cf, ( -37844.5, -15003.5, 4610 ), ( 0, 335, 0 ), "cspf_4_auto14348649893522508367", "cspf_4_auto13757901738603966073", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 8 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_vtol_takedown_cs";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "HELI_TAKEDOWN_COAST_GUARD", cf, ( -35017.5, -17403, 4618 ), ( 0, 335, 0 ), "cspf_4_auto13757901738603966073", "cspf_4_auto4562139456735891158", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 8 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_vtol_takedown_cs";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "HELI_TAKEDOWN_COAST_GUARD", cf, ( -31226.5, -21734.5, 4618 ), ( 0, 335, 0 ), "cspf_4_auto4562139456735891158", "cspf_4_auto8766061891730312246", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 8 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_vtol_takedown_cs";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "HELI_TAKEDOWN_COAST_GUARD", cf, ( -27390.5, -25770, 4618 ), ( 0, 335, 0 ), "cspf_4_auto8766061891730312246", "cspf_4_auto1184075174230807318", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 8 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_vtol_takedown_cs";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "HELI_TAKEDOWN_COAST_GUARD", cf, ( -21682.5, -31989.5, 4610 ), ( 0, 335, 0 ), "cspf_4_auto1184075174230807318", "cspf_4_auto17624274953810368946", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 8 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_vtol_takedown_cs";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "HELI_TAKEDOWN_COAST_GUARD", cf, ( -17349, -36672.5, 4603 ), ( 0, 335, 0 ), "cspf_4_auto17624274953810368946", "cspf_4_auto14709416443788656615", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 8 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_vtol_takedown_cs";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "HELI_TAKEDOWN_COAST_GUARD", cf, ( -12982.5, -41421, 4619 ), ( 0, 335, 0 ), "cspf_4_auto14709416443788656615", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 8 );
}

// Namespace mp_sat_avalon_quad_03_ob_activity_vtol_takedown_cs
// Params 3
// Checksum 0x2134fd4e, Offset: 0x423a
// Size: 0xd9b
function function_fd03b7ac738a7c92( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_vtol_takedown_cs";
    s.groupid = "vtol_escape_path";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q3_FORT", cf, ( -34777.1, -41694.3, 972.5 ), ( 0, 270, 0 ), "s_heli_takedown_heli_spawn", "cspf_5_auto11683872346724568355", undefined, "cspf_5_2", "cspf_5_1", ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 8, 1 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_vtol_takedown_cs";
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q3_FORT", cf, ( -34705, -41665.8, 1217.75 ), ( 0, 126.49, 0 ), "HELI_TAKEDOWN_Q3_FORT", undefined, undefined, "cspf_5_1", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_vtol_takedown_cs";
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q3_FORT", cf, ( -34558.4, -41781.2, 827.25 ), ( 0, 0, 0 ), "HELI_TAKEDOWN_Q3_FORT_RADIANT", "encounter_HELI_TAKEDOWN_Q3_FORT_RADIANT", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_vtol_takedown_cs";
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q3_FORT", cf, ( -17343.8, -18201.2, 4148.75 ), ( 0, 15.79, 0 ), "heli_leave", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_vtol_takedown_cs";
    s.groupid = "vtol_escape_path";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q3_FORT", cf, ( -34991.3, -41255, 1664.75 ), ( 0, 126.25, 0 ), "cspf_5_auto11683872346724568355", "cspf_5_auto14445080005883472983", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_vtol_takedown_cs";
    s.groupid = "vtol_escape_path";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q3_FORT", cf, ( -35223.8, -40870.5, 2068.5 ), ( 0, 126.25, 0 ), "cspf_5_auto14445080005883472983", "cspf_5_auto1869601917983056487", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_vtol_takedown_cs";
    s.groupid = "vtol_escape_path";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q3_FORT", cf, ( -35460.8, -40265.8, 2588.25 ), ( 0, 94.45, 0 ), "cspf_5_auto1869601917983056487", "cspf_5_auto16470152771037065802", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_vtol_takedown_cs";
    s.groupid = "vtol_escape_path";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q3_FORT", cf, ( -35603.5, -39517.8, 3059.5 ), ( 0, 91.2, 0 ), "cspf_5_auto16470152771037065802", "cspf_5_auto3230081159965063379", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_vtol_takedown_cs";
    s.groupid = "vtol_escape_path";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q3_FORT", cf, ( -35607.2, -38760, 3391 ), ( 0, 91.2, 0 ), "cspf_5_auto3230081159965063379", "cspf_5_auto15637787390623406108", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_vtol_takedown_cs";
    s.groupid = "vtol_escape_path";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q3_FORT", cf, ( -35612.5, -37560.2, 3864.75 ), ( 0, 91.2, 0 ), "cspf_5_auto15637787390623406108", "cspf_5_auto13104103977165077630", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_vtol_takedown_cs";
    s.groupid = "vtol_escape_path";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q3_FORT", cf, ( -35629.5, -36483.5, 4148.75 ), ( 0, 91.2, 0 ), "cspf_5_auto13104103977165077630", "cspf_5_auto9462926018645652633", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_vtol_takedown_cs";
    s.groupid = "vtol_escape_path";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q3_FORT", cf, ( -35498.2, -35684.5, 4148.75 ), ( 0, 91.2, 0 ), "cspf_5_auto9462926018645652633", "cspf_5_auto8651611977846050726", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_vtol_takedown_cs";
    s.groupid = "vtol_escape_path";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q3_FORT", cf, ( -35161, -34564.2, 4148.75 ), ( 0, 66.27, 0 ), "cspf_5_auto8651611977846050726", "cspf_5_auto3004262568604092982", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_vtol_takedown_cs";
    s.groupid = "vtol_escape_path";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q3_FORT", cf, ( -34440.2, -33172.2, 4148.75 ), ( 0, 64.81, 0 ), "cspf_5_auto3004262568604092982", "cspf_5_auto7381561213099642701", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_vtol_takedown_cs";
    s.groupid = "vtol_escape_path";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q3_FORT", cf, ( -33840.2, -31972.8, 4148.75 ), ( 0, 91.2, 0 ), "cspf_5_auto7381561213099642701", "cspf_5_auto17661041891484188405", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_vtol_takedown_cs";
    s.groupid = "vtol_escape_path";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q3_FORT", cf, ( -33029.5, -30442.2, 4148.75 ), ( 0, 91.2, 0 ), "cspf_5_auto17661041891484188405", "cspf_5_auto13561826082653077957", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_vtol_takedown_cs";
    s.groupid = "vtol_escape_path";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q3_FORT", cf, ( -32201.2, -29220, 4148.75 ), ( 0, 91.2, 0 ), "cspf_5_auto13561826082653077957", "cspf_5_auto15785727167667153261", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_vtol_takedown_cs";
    s.groupid = "vtol_escape_path";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q3_FORT", cf, ( -31260.2, -28094.5, 4148.75 ), ( 0, 91.2, 0 ), "cspf_5_auto15785727167667153261", "cspf_5_auto511065442808362287", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_vtol_takedown_cs";
    s.groupid = "vtol_escape_path";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q3_FORT", cf, ( -30032.8, -26975, 4148.75 ), ( 0, 91.2, 0 ), "cspf_5_auto511065442808362287", "cspf_5_auto160106325905049752", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_vtol_takedown_cs";
    s.groupid = "vtol_escape_path";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q3_FORT", cf, ( -28348, -25271.8, 4148.75 ), ( 0, 91.2, 0 ), "cspf_5_auto160106325905049752", "cspf_5_auto10314266479204636428", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_vtol_takedown_cs";
    s.groupid = "vtol_escape_path";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q3_FORT", cf, ( -26419, -23573.8, 4148.75 ), ( 0, 91.2, 0 ), "cspf_5_auto10314266479204636428", "cspf_5_auto1832830549598014543", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_vtol_takedown_cs";
    s.groupid = "vtol_escape_path";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q3_FORT", cf, ( -24639, -22061.8, 4148.75 ), ( 0, 91.2, 0 ), "cspf_5_auto1832830549598014543", "cspf_5_auto5893182350148334209", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_vtol_takedown_cs";
    s.groupid = "vtol_escape_path";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q3_FORT", cf, ( -22176.5, -20310, 4148.75 ), ( 0, 91.2, 0 ), "cspf_5_auto5893182350148334209", "cspf_5_auto17816915333658579629", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_vtol_takedown_cs";
    s.groupid = "vtol_escape_path";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q3_FORT", cf, ( -19758.8, -18963.5, 4148.75 ), ( 0, 17.37, 0 ), "cspf_5_auto17816915333658579629", "cspf_5_auto5317579845409859998", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_vtol_takedown_cs";
    s.groupid = "vtol_escape_path";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q3_FORT", cf, ( -17380, -18211.5, 4148.75 ), ( 0, 15.94, 0 ), "cspf_5_auto5317579845409859998", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_vtol_takedown_cs";
    s.name = "vehicle";
    s.script_label = "vehicle";
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q3_FORT", cf, ( -33658.4, -41847.7, 683.51 ), ( 0, 246.81, 0 ), "s_veh_HELI_TAKEDOWN_Q3_FORT", undefined, "veh_sat_atv_ob", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_vtol_takedown_cs";
    s.name = "vehicle";
    s.script_label = "vehicle";
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q3_FORT", cf, ( -35650, -41255.8, 705.75 ), ( 0, 58.84, 0 ), "s_veh_HELI_TAKEDOWN_Q3_FORT", undefined, "veh_sat_atv_ob", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_sat_avalon_quad_03_ob_activity_vtol_takedown_cs
// Params 3
// Checksum 0x731f1536, Offset: 0x4fdd
// Size: 0x962
function function_4a506e7281ee3f76( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_vtol_takedown_cs";
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q3_ISLAND", cf, ( -29928.1, -56640.2, 1518.79 ), ( 0, 116.53, 0 ), "HELI_TAKEDOWN_Q3_ISLAND", undefined, undefined, "cspf_6_1", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_vtol_takedown_cs";
    s.groupid = "vtol_escape_path";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q3_ISLAND", cf, ( -29726, -56832.1, 494.12 ), ( 0, 29.23, 0 ), "s_heli_takedown_heli_spawn", "cspf_6_auto8494757589517366665", undefined, "cspf_6_2", "cspf_6_1", ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 10, 1 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_vtol_takedown_cs";
    s.groupid = "vtol_escape_path";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q3_ISLAND", cf, ( -28882, -56386.5, 1916.35 ), ( 0, 29.65, 0 ), "cspf_6_auto8494757589517366665", "cspf_6_auto4612352738519139850", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_vtol_takedown_cs";
    s.groupid = "vtol_escape_path";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q3_ISLAND", cf, ( -28326.3, -56108.7, 2617.35 ), ( 0, 27.01, 0 ), "cspf_6_auto4612352738519139850", "cspf_6_auto10095321859284440761", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_vtol_takedown_cs";
    s.groupid = "vtol_escape_path";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q3_ISLAND", cf, ( -27833.4, -55874.5, 3244.25 ), ( 0, 27.01, 0 ), "cspf_6_auto10095321859284440761", "cspf_6_auto9117064054671232171", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_vtol_takedown_cs";
    s.groupid = "vtol_escape_path";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q3_ISLAND", cf, ( -27366.8, -55662.2, 3887.75 ), ( 0, 22.01, 0 ), "cspf_6_auto9117064054671232171", "cspf_6_auto17546438238563180426", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_vtol_takedown_cs";
    s.groupid = "vtol_escape_path";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q3_ISLAND", cf, ( -27151.7, -55547.9, 4196.75 ), ( 0, 66.72, 0 ), "cspf_6_auto17546438238563180426", "cspf_6_auto3392554419138434722", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_vtol_takedown_cs";
    s.groupid = "vtol_escape_path";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q3_ISLAND", cf, ( -26968.7, -55126.8, 4345.75 ), ( 0, 25.4, 0 ), "cspf_6_auto3392554419138434722", "cspf_6_auto678961591699957337", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_vtol_takedown_cs";
    s.groupid = "vtol_escape_path";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q3_ISLAND", cf, ( -27126.9, -54143.2, 4569.25 ), ( 0, 91.05, 0 ), "cspf_6_auto678961591699957337", "cspf_6_auto17798406878246190170", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_vtol_takedown_cs";
    s.groupid = "vtol_escape_path";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q3_ISLAND", cf, ( -27477.7, -52649.3, 4726.75 ), ( 0, 91.05, 0 ), "cspf_6_auto17798406878246190170", "cspf_6_auto14348649893522508367", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_vtol_takedown_cs";
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q3_ISLAND", cf, ( -25535.2, -43359.1, 4801.26 ), ( 0, 349.61, 0 ), "heli_leave", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_vtol_takedown_cs";
    s.groupid = "vtol_escape_path";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q3_ISLAND", cf, ( -28363, -51003.9, 4793.75 ), ( 0, 91.05, 0 ), "cspf_6_auto14348649893522508367", "cspf_6_auto13757901738603966073", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_vtol_takedown_cs";
    s.groupid = "vtol_escape_path";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q3_ISLAND", cf, ( -28836.6, -49375.7, 4801.75 ), ( 0, 27.01, 0 ), "cspf_6_auto13757901738603966073", "cspf_6_auto4562139456735891158", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_vtol_takedown_cs";
    s.groupid = "vtol_escape_path";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q3_ISLAND", cf, ( -28589.1, -48176.5, 4801.75 ), ( 0, 337.01, 0 ), "cspf_6_auto4562139456735891158", "cspf_6_auto8766061891730312246", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_vtol_takedown_cs";
    s.groupid = "vtol_escape_path";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q3_ISLAND", cf, ( -27308.8, -45945.3, 4736.75 ), ( 0, 27.01, 0 ), "cspf_6_auto8766061891730312246", "cspf_6_auto14709416443788656615", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_vtol_takedown_cs";
    s.groupid = "vtol_escape_path";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q3_ISLAND", cf, ( -25772.3, -43679.4, 4791.25 ), ( 0, 347.72, 0 ), "cspf_6_auto14709416443788656615", "cspf_6_auto15600294591917143653", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_vtol_takedown_cs";
    s.groupid = "vtol_escape_path";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q3_ISLAND", cf, ( -23980.4, -41291.1, 4791.25 ), ( 0, 347.72, 0 ), "cspf_6_auto15600294591917143653", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_vtol_takedown_cs";
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q3_ISLAND", cf, ( -29781.4, -57057.8, 515.87 ), ( 0, 355.43, 0 ), "s_heli_takedown_teleport", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_vtol_takedown_cs";
    fe [[ f ]]( s, "HELI_TAKEDOWN_Q3_ISLAND", cf, ( -29772.8, -57067.9, 522.91 ), ( 0, 20.43, 0 ), "HELI_TAKEDOWN_Q3_ISLAND_RADIANT", "encounter_HELI_TAKEDOWN_Q3_ISLAND_RADIANT", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_sat_avalon_quad_03_ob_activity_vtol_takedown_cs
// Params 0
// Checksum 0x1eee2165, Offset: 0x5947
// Size: 0x202
function function_d9dd7965c51c95d1()
{
    activityinstances = [];
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_activitydef_activity_helitakedown";
    var_881289d7987bc770.var_265c4f33e2a6daa7 = 1;
    var_881289d7987bc770.cf = "mp_sat_avalon_quad_03_ob_activity_vtol_takedown_cs";
    var_881289d7987bc770.scriptstructorigin = ( -46880.7, -10278.2, 212.28 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [];
    var_881289d7987bc770.var_31ce4477e3543d24 = [];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [];
    var_881289d7987bc770.locationradius = [];
    activityinstances[ "HELI_TAKEDOWN_COAST_GUARD" ] = var_881289d7987bc770;
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_activitydef_activity_helitakedown";
    var_881289d7987bc770.var_265c4f33e2a6daa7 = 1;
    var_881289d7987bc770.cf = "mp_sat_avalon_quad_03_ob_activity_vtol_takedown_cs";
    var_881289d7987bc770.scriptstructorigin = ( -34538.4, -41719.7, 836.5 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [];
    var_881289d7987bc770.var_31ce4477e3543d24 = [];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [];
    var_881289d7987bc770.locationradius = [];
    activityinstances[ "HELI_TAKEDOWN_Q3_FORT" ] = var_881289d7987bc770;
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_activitydef_activity_helitakedown";
    var_881289d7987bc770.var_265c4f33e2a6daa7 = 1;
    var_881289d7987bc770.cf = "mp_sat_avalon_quad_03_ob_activity_vtol_takedown_cs";
    var_881289d7987bc770.scriptstructorigin = ( -29764.6, -57056.4, 505 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [];
    var_881289d7987bc770.var_31ce4477e3543d24 = [];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [];
    var_881289d7987bc770.locationradius = [];
    activityinstances[ "HELI_TAKEDOWN_Q3_ISLAND" ] = var_881289d7987bc770;
    return activityinstances;
}

