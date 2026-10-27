// script_439fa13e546906b7  (hash_439fa13e546906b7.gscc) (size: 28686 Bytes / 0x700e / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x279300df (663945439)
// size ...... 28686 (0x700e)
// includes .. 4   (offset: 0x5f6a)
// strings ... 86  (offset: 0x5f8a)
// dev strs .. 0   (offset: 0x700e)
// exports ... 13  (offset: 0x5a86)
// cseg ...... 0x93f + 0x5147 (0x5a86)
// imports ... 26  (offset: 0x5c8e)
// animtree1 . 0   (offset: 0x700e)
// animtree2 . 0   (offset: 0x700e)
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace mp_sat_avalon_q1_ob_contract_taurus_cradle_vents_parent_cs;

// Namespace mp_sat_avalon_q1_ob_contract_taurus_cradle_vents_parent_cs
// Params 0, eflags: 0x5
// Checksum 0x86ba260c, Offset: 0x95d
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"mp_sat_avalon_q1_ob_contract_taurus_cradle_vents_parent_cs", #"activity_common", &function_b39ecd3d51489472, undefined );
}

// Namespace mp_sat_avalon_q1_ob_contract_taurus_cradle_vents_parent_cs
// Params 0, eflags: 0x4
// Checksum 0x6149382a, Offset: 0x986
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace mp_sat_avalon_q1_ob_contract_taurus_cradle_vents_parent_cs
// Params 0, eflags: 0x4
// Checksum 0xe472ebc6, Offset: 0x997
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace mp_sat_avalon_q1_ob_contract_taurus_cradle_vents_parent_cs
// Params 2
// Checksum 0xb2fdabaf, Offset: 0x9a8
// Size: 0x8c
function main( unused, unused2 )
{
    if ( utility::flag_exist( "mp_sat_avalon_q1_ob_contract_taurus_cradle_vents_parent_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "mp_sat_avalon_q1_ob_contract_taurus_cradle_vents_parent_cs" ) )
    {
        return;
    }
    
    activity_common::function_e1df676808c1d1e3( &function_4cd78e661617f3 );
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "mp_sat_avalon_q1_ob_contract_taurus_cradle_vents_parent_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "mp_sat_avalon_q1_ob_contract_taurus_cradle_vents_parent_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace mp_sat_avalon_q1_ob_contract_taurus_cradle_vents_parent_cs
// Params 3, eflags: 0x4
// Checksum 0x67f05f09, Offset: 0xa3c
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "mp_sat_avalon_q1_ob_contract_taurus_cradle_vents_parent_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "mp_sat_avalon_q1_ob_contract_taurus_cradle_vents_parent_cs" );
}

// Namespace mp_sat_avalon_q1_ob_contract_taurus_cradle_vents_parent_cs
// Params 3, eflags: 0x4
// Checksum 0x34028fdd, Offset: 0xab6
// Size: 0x28e7
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_cradle_vents_parent_cs";
    s.activity_bundle = "sat_activitydef_taurus_cradle_vents";
    s.name = "TAURUS_CRADLE_VENTS_01";
    s.script_parameters = "0";
    fe [[ f ]]( s, "TAURUS_CRADLE_VENTS_01", cf, ( -42123.2, 28114, 1641.9 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_cradle_vents_parent_cs";
    fe [[ f ]]( s, "TAURUS_CRADLE_VENTS_01", cf, ( -41990.2, 28022.5, 1641.9 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "join_radius", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 2500 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_cradle_vents_parent_cs";
    s._size_max = ( 1602, 1572, 732 );
    s._size_min = ( 2640, 1644, 200 );
    s.var_5afd49978f924648 = "1";
    s.var_a8568d8e0b0b6076 = "1";
    s.var_3f3960eb7318312d = "1";
    s.default_goal_radius = "-1";
    s.script_stealthgroup = "-1";
    s.script_string = "enc_ob_taurus_boss";
    s.var_95e2cee7aca5aaae = "0";
    s.width = "128";
    fe [[ f ]]( s, "TAURUS_CRADLE_VENTS_01", cf, ( -41977.4, 28359.2, 1510.09 ), ( 0, 270, 0 ), "TAURUS_CRADLE_VENTS_01_enc_vol", "cspf_1_auto8392943442380600238", "noent_volume_ai_encounter_cs", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_cradle_vents_parent_cs";
    s.var_433589829cadc877 = "1";
    s.groupid = "taurus_boss_enc";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "taurus_boss";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "TAURUS_CRADLE_VENTS_01", cf, ( -41367.5, 28991.8, 1600 ), ( 0, 210, 0 ), "cspf_1_auto8392943442380600238", undefined, "taurus_boss", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_cradle_vents_parent_cs";
    s.var_433589829cadc877 = "1";
    s.groupid = "taurus_boss_enc";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "taurus_boss_special";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "TAURUS_CRADLE_VENTS_01", cf, ( -41371.5, 29103.8, 1600 ), ( 0, 210, 0 ), "cspf_1_auto8392943442380600238", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_cradle_vents_parent_cs";
    s.var_433589829cadc877 = "1";
    s.groupid = "taurus_boss_enc";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "taurus_boss_mob";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "TAURUS_CRADLE_VENTS_01", cf, ( -41403.5, 29239.8, 1600 ), ( 0, 210, 0 ), "cspf_1_auto8392943442380600238", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_cradle_vents_parent_cs";
    s.var_433589829cadc877 = "1";
    s.groupid = "taurus_boss_enc";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "taurus_boss_mob";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "TAURUS_CRADLE_VENTS_01", cf, ( -41231.5, 28923.8, 1600 ), ( 0, 210, 0 ), "cspf_1_auto8392943442380600238", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_cradle_vents_parent_cs";
    s.var_433589829cadc877 = "1";
    s.groupid = "taurus_boss_enc";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "taurus_boss_mob";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "TAURUS_CRADLE_VENTS_01", cf, ( -41103.5, 28923.8, 1600 ), ( 0, 210, 0 ), "cspf_1_auto8392943442380600238", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_cradle_vents_parent_cs";
    s.var_433589829cadc877 = "1";
    s.groupid = "taurus_boss_enc";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "taurus_boss_mob";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "TAURUS_CRADLE_VENTS_01", cf, ( -41359.5, 29367.8, 1600 ), ( 0, 210, 0 ), "cspf_1_auto8392943442380600238", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_cradle_vents_parent_cs";
    s.var_433589829cadc877 = "1";
    s.groupid = "taurus_boss_enc";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "taurus_boss_reinforcements";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "TAURUS_CRADLE_VENTS_01", cf, ( -42783.2, 30275.7, 1592 ), ( 0, 245, 0 ), "cspf_1_auto8392943442380600238", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_cradle_vents_parent_cs";
    s.var_433589829cadc877 = "1";
    s.groupid = "taurus_boss_enc";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "taurus_boss_reinforcements";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "TAURUS_CRADLE_VENTS_01", cf, ( -43023.8, 29632.3, 1592 ), ( 0, 65, 0 ), "cspf_1_auto8392943442380600238", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_cradle_vents_parent_cs";
    s.var_433589829cadc877 = "1";
    s.groupid = "taurus_boss_enc";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "taurus_boss_reinforcements";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "TAURUS_CRADLE_VENTS_01", cf, ( -42851.1, 29463.5, 1592 ), ( 0, 35, 0 ), "cspf_1_auto8392943442380600238", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_cradle_vents_parent_cs";
    s.var_433589829cadc877 = "1";
    s.groupid = "taurus_boss_enc";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "taurus_boss_reinforcements";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "TAURUS_CRADLE_VENTS_01", cf, ( -42729.1, 27523.5, 1592 ), ( 0, 110, 0 ), "cspf_1_auto8392943442380600238", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_cradle_vents_parent_cs";
    s.var_433589829cadc877 = "1";
    s.groupid = "taurus_boss_enc";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "taurus_boss_reinforcements";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "TAURUS_CRADLE_VENTS_01", cf, ( -41987.2, 27055.4, 1584 ), ( 0, 35, 0 ), "cspf_1_auto8392943442380600238", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_cradle_vents_parent_cs";
    s.var_433589829cadc877 = "1";
    s.groupid = "taurus_boss_enc";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "taurus_boss_reinforcements";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "TAURUS_CRADLE_VENTS_01", cf, ( -41235.1, 27238.5, 1584 ), ( 0, 200, 0 ), "cspf_1_auto8392943442380600238", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_cradle_vents_parent_cs";
    s.var_433589829cadc877 = "1";
    s.groupid = "taurus_boss_enc";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "taurus_boss_reinforcements";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "TAURUS_CRADLE_VENTS_01", cf, ( -41643.1, 26776.4, 1584 ), ( 0, 335, 0 ), "cspf_1_auto8392943442380600238", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_cradle_vents_parent_cs";
    s.var_433589829cadc877 = "1";
    s.groupid = "taurus_boss_enc";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "taurus_boss_reinforcements";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "TAURUS_CRADLE_VENTS_01", cf, ( -40571.9, 27913.8, 1592 ), ( 0, 20, 0 ), "cspf_1_auto8392943442380600238", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_cradle_vents_parent_cs";
    s.var_433589829cadc877 = "1";
    s.groupid = "taurus_boss_enc";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "taurus_boss_reinforcements";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "TAURUS_CRADLE_VENTS_01", cf, ( -40822.8, 28172.9, 1592 ), ( 0, 125, 0 ), "cspf_1_auto8392943442380600238", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_cradle_vents_parent_cs";
    s.var_433589829cadc877 = "1";
    s.groupid = "taurus_boss_enc";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "taurus_boss_reinforcements";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "TAURUS_CRADLE_VENTS_01", cf, ( -41014.8, 27420.9, 1592 ), ( 0, 125, 0 ), "cspf_1_auto8392943442380600238", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_cradle_vents_parent_cs";
    s.var_433589829cadc877 = "1";
    s.groupid = "taurus_boss_enc";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "taurus_boss_reinforcements";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "TAURUS_CRADLE_VENTS_01", cf, ( -41211, 27918.9, 1592 ), ( 0, 200, 0 ), "cspf_1_auto8392943442380600238", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_cradle_vents_parent_cs";
    s.var_433589829cadc877 = "1";
    s.groupid = "taurus_boss_enc";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "taurus_boss_reinforcements";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "TAURUS_CRADLE_VENTS_01", cf, ( -42158, 27508.9, 1592 ), ( 0, 290, 0 ), "cspf_1_auto8392943442380600238", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_cradle_vents_parent_cs";
    s.var_433589829cadc877 = "1";
    s.groupid = "taurus_boss_enc";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "taurus_boss_reinforcements";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "TAURUS_CRADLE_VENTS_01", cf, ( -41413.8, 30004, 1592 ), ( 0, 80, 0 ), "cspf_1_auto8392943442380600238", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_cradle_vents_parent_cs";
    s.var_433589829cadc877 = "1";
    s.groupid = "taurus_boss_enc";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "taurus_boss_reinforcements";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "TAURUS_CRADLE_VENTS_01", cf, ( -41211.4, 30593, 1592 ), ( 0, 335, 0 ), "cspf_1_auto8392943442380600238", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_cradle_vents_parent_cs";
    s.var_433589829cadc877 = "1";
    s.groupid = "taurus_boss_enc";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "taurus_boss_reinforcements";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "TAURUS_CRADLE_VENTS_01", cf, ( -42235.4, 30845, 1592 ), ( 0, 65, 0 ), "cspf_1_auto8392943442380600238", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_cradle_vents_parent_cs";
    fe [[ f ]]( s, "TAURUS_CRADLE_VENTS_01", cf, ( -47288, 27496, 1808 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Exclusion_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 4000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_cradle_vents_parent_cs";
    s.var_433589829cadc877 = "1";
    s.groupid = "taurus_boss_enc";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "taurus_boss_special_large";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "TAURUS_CRADLE_VENTS_01", cf, ( -41251.5, 29523.8, 1600 ), ( 0, 210, 0 ), "cspf_1_auto8392943442380600238", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_cradle_vents_parent_cs";
    s.var_433589829cadc877 = "1";
    s.groupid = "taurus_boss_enc";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "taurus_boss_special_large";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "TAURUS_CRADLE_VENTS_01", cf, ( -40963.5, 28911.8, 1600 ), ( 0, 210, 0 ), "cspf_1_auto8392943442380600238", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_cradle_vents_parent_cs";
    s.var_433589829cadc877 = "1";
    s.groupid = "taurus_boss_enc";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "taurus_boss_mob_special";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "TAURUS_CRADLE_VENTS_01", cf, ( -41139.5, 29607.8, 1600 ), ( 0, 210, 0 ), "cspf_1_auto8392943442380600238", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_cradle_vents_parent_cs";
    s.var_433589829cadc877 = "1";
    s.groupid = "taurus_boss_enc";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "taurus_boss_mob_special";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "TAURUS_CRADLE_VENTS_01", cf, ( -40815.5, 28923.8, 1600 ), ( 0, 210, 0 ), "cspf_1_auto8392943442380600238", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_cradle_vents_parent_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "12";
    s.min_wait_time = "8";
    s.move_speed = "0.8";
    s.reverse_route = "1";
    s.var_df8f7b8318d59fe5 = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, us, cf, ( -38479.5, 16209.3, 96 ), ( 0, 90, 0 ), "cspf_2_auto3844762023785570599", "cspf_2_auto9183070863763516769", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_cradle_vents_parent_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s._size_max = ( 768, 496, 232 );
    s._size_min = ( 528, 400, 136 );
    s.groupid = "stadium_taurus_north_int_01";
    s.height = 128;
    s.length = "128";
    s.width = "128";
    fe [[ f ]]( s, us, cf, ( -38656, 15752, 216 ), ( 0, 0, 0 ), "stadium_taurus_north_int_trigger", "stadium_taurus_north_int_bots", "stadium_taurus_north_int", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_cradle_vents_parent_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "12";
    s.min_wait_time = "8";
    s.move_speed = "0.8";
    s.reverse_route = "1";
    s.var_df8f7b8318d59fe5 = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, us, cf, ( -38389.5, 15647.3, 97 ), ( 0, 225, 0 ), "cspf_2_auto9183070863763516769", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_cradle_vents_parent_cs";
    s.goal_area_target = "stadium_taurus_north_int_01_goal_01";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, us, cf, ( -39025.5, 15927.3, 97 ), ( 0, 90, 0 ), "stadium_taurus_north_int_spawnpoints_01", "cspf_2_auto16300498845813432696", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_cradle_vents_parent_cs";
    s.goal_area_target = "stadium_taurus_north_int_01_goal_01";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, us, cf, ( -38294.5, 16180.7, 96 ), ( 0, 90, 0 ), "stadium_taurus_north_int_spawnpoints_01", "cspf_2_auto12998028228983745681", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_cradle_vents_parent_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "6";
    s.min_wait_time = "4";
    s.move_speed = "0.8";
    s.reverse_route = "1";
    s.var_df8f7b8318d59fe5 = "1";
    s.start_point = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, us, cf, ( -38291.9, 16222.2, 97 ), ( 0, 270, 0 ), "cspf_2_auto12998028228983745681", "cspf_2_auto11461400604689978747", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_cradle_vents_parent_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "8";
    s.move_speed = "0.8";
    s.var_df8f7b8318d59fe5 = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, us, cf, ( -38360, 16848, 256 ), ( 0, 105, 0 ), "cspf_2_auto11461400604689978747", "cspf_2_auto12241972145909453659", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_cradle_vents_parent_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "12";
    s.min_wait_time = "8";
    s.move_speed = "0.8";
    s.reverse_route = "1";
    s.var_df8f7b8318d59fe5 = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, us, cf, ( -38552, 16840, 256 ), ( 0, 270, 0 ), "cspf_2_auto12241972145909453659", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_cradle_vents_parent_cs";
    s.groupid = "stadium_taurus_north_int_01";
    s.script_scenescriptbundle = "sat_ai_guildbot_folded";
    fe [[ f ]]( s, us, cf, ( -38968, 15816, 96 ), ( 0, 90, 0 ), "stadium_taurus_north_int_bots", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_cradle_vents_parent_cs";
    s.groupid = "stadium_taurus_north_int_01";
    s.script_scenescriptbundle = "sat_ai_guildbot_folded";
    fe [[ f ]]( s, us, cf, ( -37968, 15808, 96 ), ( 0, 180, 0 ), "stadium_taurus_north_int_bots", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_cradle_vents_parent_cs";
    s.groupid = "stadium_taurus_north_int_01";
    s.script_scenescriptbundle = "sat_ai_guildbot_folded";
    fe [[ f ]]( s, us, cf, ( -39144, 15432, 96 ), ( 0, 360, 0 ), "stadium_taurus_north_int_bots", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_cradle_vents_parent_cs";
    s.groupid = "stadium_taurus_north_int_01";
    s.script_scenescriptbundle = "sat_ai_guildbot_folded";
    fe [[ f ]]( s, us, cf, ( -38232, 15600, 96 ), ( 0, 360, 0 ), "stadium_taurus_north_int_bots", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_cradle_vents_parent_cs";
    s._size_max = ( 888, 1104, 192 );
    s._size_min = ( 488, 544, 144 );
    s.var_5afd49978f924648 = "1";
    s.var_a8568d8e0b0b6076 = "1";
    s.var_3f3960eb7318312d = "1";
    s.default_goal_radius = "-1";
    s.height = 128;
    s.length = "128";
    s.script_stealthgroup = "-1";
    s.script_string = "sat_ob_ambient_taurus_spawnpoint";
    s.var_95e2cee7aca5aaae = "0";
    s.width = "128";
    fe [[ f ]]( s, us, cf, ( -38718.8, 15784.5, 213.29 ), ( 0, 0, 0 ), "stadium_taurus_north_int_enc", "stadium_taurus_north_int_spawnpoints_01", "noent_volume_ai_encounter_cs", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_cradle_vents_parent_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "6";
    s.min_wait_time = "4";
    s.move_speed = "0.8";
    s.reverse_route = "1";
    s.var_df8f7b8318d59fe5 = "1";
    s.start_point = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, us, cf, ( -39075.9, 15894.2, 97 ), ( 0, 270, 0 ), "cspf_2_auto16300498845813432696", "cspf_2_auto16995950793703587223", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_cradle_vents_parent_cs";
    s.var_e8fdcbf62408dcde = "1";
    s.max_wait_time = "10";
    s.min_wait_time = "8";
    s.move_speed = "0.8";
    s.var_df8f7b8318d59fe5 = "1";
    s.variantname = "ai_encounter_patrol_point";
    fe [[ f ]]( s, us, cf, ( -39050.9, 16204.9, 96 ), ( 0, 315, 0 ), "cspf_2_auto16995950793703587223", "cspf_2_auto3844762023785570599", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_cradle_vents_parent_cs";
    s.groupid = "stadium_taurus_north_int_01";
    fe [[ f ]]( s, us, cf, ( -38664, 15696, 184 ), ( 0, 0, 0 ), "stadium_taurus_north_int", undefined, "bot_ambush", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_cradle_vents_parent_cs";
    fe [[ f ]]( s, us, cf, ( 0, 0, 0 ), ( 0, 0, 0 ), "q1_taurus_cradle_vents_parent" );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace mp_sat_avalon_q1_ob_contract_taurus_cradle_vents_parent_cs
// Params 0, eflags: 0x4
// Checksum 0xa5791fe2, Offset: 0x33a5
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace mp_sat_avalon_q1_ob_contract_taurus_cradle_vents_parent_cs
// Params 0
// Checksum 0xa5a38244, Offset: 0x33af
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "mp_sat_avalon_q1_ob_contract_taurus_cradle_vents_parent_cs" );
}

// Namespace mp_sat_avalon_q1_ob_contract_taurus_cradle_vents_parent_cs
// Params 0
// Checksum 0xcdcce929, Offset: 0x33c5
// Size: 0x66
function function_4cd78e661617f3()
{
    activityinfostruct = {};
    activityinfostruct.name = "REV_OB_TAURUS_CRADLE_VENTS";
    activityinfostruct.scriptbundle = "sat_activitydef_taurus_cradle_vents";
    activityinfostruct.mainfunction = &main;
    activityinfostruct.var_934f068483ae4ddb = &function_d4323822d7042e5a;
    activityinfostruct.metadatafunction = &function_d9dd7965c51c95d1;
    return activityinfostruct;
}

// Namespace mp_sat_avalon_q1_ob_contract_taurus_cradle_vents_parent_cs
// Params 4
// Checksum 0x4b07371e, Offset: 0x3434
// Size: 0x57
function function_d4323822d7042e5a( var_4312b79c960726b6, fe, us, cf = "mp_sat_avalon_q1_ob_contract_taurus_cradle_vents_parent_cs" )
{
    switch ( var_4312b79c960726b6 )
    {
        case #"hash_cb4f67f2f20887bc":
            function_125ff6172c289b04( fe, us, cf );
            break;
    }
}

// Namespace mp_sat_avalon_q1_ob_contract_taurus_cradle_vents_parent_cs
// Params 3
// Checksum 0xd9832bc5, Offset: 0x3493
// Size: 0x253c
function function_125ff6172c289b04( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_cradle_vents_parent_cs";
    s.name = "vtol_spawn_point";
    fe [[ f ]]( s, "TAURUS_CRADLE_VENTS_01", cf, ( -40286.4, 29717.8, 2400.89 ), ( 0, 210, 0 ), "taurus_boss_01", undefined, "heli_reinforceNode", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 500 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_cradle_vents_parent_cs";
    fe [[ f ]]( s, "TAURUS_CRADLE_VENTS_01", cf, ( -42804.7, 27824.5, 1597 ), ( 0, 45, 0 ), "taurus_boss_01", undefined, "taurus_boss_intro_teleport", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_cradle_vents_parent_cs";
    fe [[ f ]]( s, "TAURUS_CRADLE_VENTS_01", cf, ( -42113, 28684, 1621 ), ( 0, 0, 0 ), "TAURUS_CRADLE_VENTS_01", "taurus_boss_01", "taurus_cradle_vents_center_struct_01", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 4000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_cradle_vents_parent_cs";
    fe [[ f ]]( s, "TAURUS_CRADLE_VENTS_01", cf, ( -42770.7, 27790.5, 1597 ), ( 0, 45, 0 ), "taurus_boss_01", undefined, "taurus_boss_intro_teleport", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_cradle_vents_parent_cs";
    fe [[ f ]]( s, "TAURUS_CRADLE_VENTS_01", cf, ( -42838.6, 27858.4, 1597 ), ( 0, 45, 0 ), "taurus_boss_01", undefined, "taurus_boss_intro_teleport", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_cradle_vents_parent_cs";
    fe [[ f ]]( s, "TAURUS_CRADLE_VENTS_01", cf, ( -42872.6, 27892.3, 1597 ), ( 0, 45, 0 ), "taurus_boss_01", undefined, "taurus_boss_intro_teleport", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_cradle_vents_parent_cs";
    fe [[ f ]]( s, "TAURUS_CRADLE_VENTS_01", cf, ( -41331, 29086, 1599 ), ( 0, 0, 0 ), "taurus_boss_01", undefined, "taurus_boss_ai_spawn", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 300 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_cradle_vents_parent_cs";
    fe [[ f ]]( s, "TAURUS_CRADLE_VENTS_01", cf, ( -42140.3, 28468.1, 1593 ), ( 0, 270, 0 ), "taurus_boss_01", undefined, "taurus_boss_outro_teleport", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_cradle_vents_parent_cs";
    fe [[ f ]]( s, "TAURUS_CRADLE_VENTS_01", cf, ( -42188.3, 28468.1, 1593 ), ( 0, 270, 0 ), "taurus_boss_01", undefined, "taurus_boss_outro_teleport", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_cradle_vents_parent_cs";
    fe [[ f ]]( s, "TAURUS_CRADLE_VENTS_01", cf, ( -42092.3, 28468.1, 1593 ), ( 0, 270, 0 ), "taurus_boss_01", undefined, "taurus_boss_outro_teleport", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_cradle_vents_parent_cs";
    fe [[ f ]]( s, "TAURUS_CRADLE_VENTS_01", cf, ( -42044.3, 28468.1, 1593 ), ( 0, 270, 0 ), "taurus_boss_01", undefined, "taurus_boss_outro_teleport", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_cradle_vents_parent_cs";
    fe [[ f ]]( s, "TAURUS_CRADLE_VENTS_01", cf, ( -33027, 34890, 2400.89 ), ( 0, 215, 0 ), "taurus_boss_01", "cspf_3_auto15727990925494373259", "taurus_boss_vtol_strafe_spawn", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 500 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_cradle_vents_parent_cs";
    fe [[ f ]]( s, "TAURUS_CRADLE_VENTS_01", cf, ( -51332.5, 23082.6, 2400.89 ), ( 0, 215, 0 ), "cspf_3_auto15727990925494373259", undefined, "taurus_boss_vtol_strafe_delete", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 500 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_cradle_vents_parent_cs";
    fe [[ f ]]( s, "TAURUS_CRADLE_VENTS_01", cf, ( -41504.3, 28514.1, 1777 ), ( 0, 0, 0 ), "taurus_boss_01", undefined, "taurus_boss_teleport", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_cradle_vents_parent_cs";
    fe [[ f ]]( s, "TAURUS_CRADLE_VENTS_01", cf, ( -42113, 28684, 1593 ), ( 0, 0, 0 ), "taurus_boss_01", undefined, "taurus_boss_area_goal_target", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 2500 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_cradle_vents_parent_cs";
    fe [[ f ]]( s, "TAURUS_CRADLE_VENTS_01", cf, ( -42506.3, 29589.1, 1593 ), ( 0, 270, 0 ), "taurus_boss_01", undefined, "taurus_boss_teleport_ground", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_cradle_vents_parent_cs";
    fe [[ f ]]( s, "TAURUS_CRADLE_VENTS_01", cf, ( -41372.3, 28396.1, 1593 ), ( 0, 270, 0 ), "taurus_boss_01", undefined, "taurus_boss_teleport_ground", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_cradle_vents_parent_cs";
    fe [[ f ]]( s, "TAURUS_CRADLE_VENTS_01", cf, ( -42579.8, 29105.6, 1698.5 ), ( 0, 0, 0 ), "taurus_boss_01", undefined, "taurus_boss_teleport", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_cradle_vents_parent_cs";
    fe [[ f ]]( s, "TAURUS_CRADLE_VENTS_01", cf, ( -42342.3, 29326.1, 1593 ), ( 0, 270, 0 ), "taurus_boss_01", undefined, "taurus_boss_teleport_threshold", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 300 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_cradle_vents_parent_cs";
    fe [[ f ]]( s, "TAURUS_CRADLE_VENTS_01", cf, ( -41420.3, 28964.1, 1593 ), ( 0, 270, 0 ), "taurus_boss_01", undefined, "taurus_boss_teleport_ground", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_cradle_vents_parent_cs";
    fe [[ f ]]( s, "TAURUS_CRADLE_VENTS_01", cf, ( -41792.3, 29328.1, 1753 ), ( 0, 0, 0 ), "taurus_boss_01", undefined, "taurus_boss_teleport", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_cradle_vents_parent_cs";
    fe [[ f ]]( s, "TAURUS_CRADLE_VENTS_01", cf, ( -41820.3, 27460.1, 1593 ), ( 0, 270, 0 ), "taurus_boss_01", undefined, "taurus_boss_teleport_ground", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_cradle_vents_parent_cs";
    fe [[ f ]]( s, "TAURUS_CRADLE_VENTS_01", cf, ( -41252.3, 28676.1, 1593 ), ( 0, 270, 0 ), "taurus_boss_01", undefined, "taurus_boss_teleport_ground", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_cradle_vents_parent_cs";
    fe [[ f ]]( s, "TAURUS_CRADLE_VENTS_01", cf, ( -41940.3, 28292.1, 1593 ), ( 0, 270, 0 ), "taurus_boss_01", undefined, "taurus_boss_teleport_ground", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_cradle_vents_parent_cs";
    fe [[ f ]]( s, "TAURUS_CRADLE_VENTS_01", cf, ( -42228.3, 28564.1, 1593 ), ( 0, 270, 0 ), "taurus_boss_01", undefined, "taurus_boss_teleport_ground", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_cradle_vents_parent_cs";
    fe [[ f ]]( s, "TAURUS_CRADLE_VENTS_01", cf, ( -41686.3, 28878.1, 1593 ), ( 0, 270, 0 ), "taurus_boss_01", undefined, "taurus_boss_teleport_threshold", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 300 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_cradle_vents_parent_cs";
    fe [[ f ]]( s, "TAURUS_CRADLE_VENTS_01", cf, ( -50868.8, 22887.6, 2400.89 ), ( 0, 35, 0 ), "taurus_boss_01", "cspf_3_auto11472737563096027821", "taurus_boss_vtol_strafe_spawn", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 500 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_cradle_vents_parent_cs";
    fe [[ f ]]( s, "TAURUS_CRADLE_VENTS_01", cf, ( -32563.3, 34694.9, 2400.89 ), ( 0, 35, 0 ), "cspf_3_auto11472737563096027821", undefined, "taurus_boss_vtol_strafe_delete", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 500 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_cradle_vents_parent_cs";
    fe [[ f ]]( s, "TAURUS_CRADLE_VENTS_01", cf, ( -32878.6, 23427.1, 2400.89 ), ( 0, 150, 0 ), "taurus_boss_01", "cspf_3_auto10508086518930846457", "taurus_boss_vtol_strafe_spawn", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 500 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_cradle_vents_parent_cs";
    fe [[ f ]]( s, "TAURUS_CRADLE_VENTS_01", cf, ( -51316, 35027.4, 2400.89 ), ( 0, 150, 0 ), "cspf_3_auto10508086518930846457", undefined, "taurus_boss_vtol_strafe_delete", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 500 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_cradle_vents_parent_cs";
    fe [[ f ]]( s, "TAURUS_CRADLE_VENTS_01", cf, ( -51296.7, 34524.8, 2400.89 ), ( 0, 330, 0 ), "taurus_boss_01", "cspf_3_auto2618970178193740499", "taurus_boss_vtol_strafe_spawn", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 500 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_cradle_vents_parent_cs";
    fe [[ f ]]( s, "TAURUS_CRADLE_VENTS_01", cf, ( -32859.5, 22924.4, 2400.89 ), ( 0, 330, 0 ), "cspf_3_auto2618970178193740499", undefined, "taurus_boss_vtol_strafe_delete", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 500 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_cradle_vents_parent_cs";
    fe [[ f ]]( s, "TAURUS_CRADLE_VENTS_01", cf, ( -41664.5, 18488.8, 2400.89 ), ( 0, 92, 0 ), "taurus_boss_01", "cspf_3_auto4593239032785360107", "taurus_boss_vtol_strafe_spawn", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 500 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_cradle_vents_parent_cs";
    fe [[ f ]]( s, "TAURUS_CRADLE_VENTS_01", cf, ( -41597.1, 40271.8, 2400.89 ), ( 0, 92, 0 ), "cspf_3_auto4593239032785360107", undefined, "taurus_boss_vtol_strafe_delete", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 500 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_cradle_vents_parent_cs";
    fe [[ f ]]( s, "TAURUS_CRADLE_VENTS_01", cf, ( -42013.2, 39989.1, 2400.89 ), ( 0, 272, 0 ), "taurus_boss_01", "cspf_3_auto392353710078609965", "taurus_boss_vtol_strafe_spawn", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 500 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_cradle_vents_parent_cs";
    fe [[ f ]]( s, "TAURUS_CRADLE_VENTS_01", cf, ( -42080.7, 18206.1, 2400.89 ), ( 0, 272, 0 ), "cspf_3_auto392353710078609965", undefined, "taurus_boss_vtol_strafe_delete", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 500 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_cradle_vents_parent_cs";
    fe [[ f ]]( s, "TAURUS_CRADLE_VENTS_01", cf, ( -52497.3, 28817.1, 2400.89 ), ( 0, 2, 0 ), "taurus_boss_01", "cspf_3_auto3601206731564572914", "taurus_boss_vtol_strafe_spawn", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 500 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_cradle_vents_parent_cs";
    fe [[ f ]]( s, "TAURUS_CRADLE_VENTS_01", cf, ( -30714.3, 28749.7, 2400.89 ), ( 0, 2, 0 ), "cspf_3_auto3601206731564572914", undefined, "taurus_boss_vtol_strafe_delete", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 500 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_cradle_vents_parent_cs";
    fe [[ f ]]( s, "TAURUS_CRADLE_VENTS_01", cf, ( -30997, 29165.8, 2400.89 ), ( 0, 182, 0 ), "taurus_boss_01", "cspf_3_auto6102694883375622829", "taurus_boss_vtol_strafe_spawn", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 500 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_cradle_vents_parent_cs";
    fe [[ f ]]( s, "TAURUS_CRADLE_VENTS_01", cf, ( -52780, 29233.3, 2400.89 ), ( 0, 182, 0 ), "cspf_3_auto6102694883375622829", undefined, "taurus_boss_vtol_strafe_delete", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 500 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_cradle_vents_parent_cs";
    fe [[ f ]]( s, "TAURUS_CRADLE_VENTS_01", cf, ( -35527.5, 19713.7, 2400.89 ), ( 0, 125, 0 ), "taurus_boss_01", "cspf_3_auto7728378131011512490", "taurus_boss_vtol_strafe_spawn", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 500 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_cradle_vents_parent_cs";
    fe [[ f ]]( s, "TAURUS_CRADLE_VENTS_01", cf, ( -47334.9, 38019.1, 2400.89 ), ( 0, 125, 0 ), "cspf_3_auto7728378131011512490", undefined, "taurus_boss_vtol_strafe_delete", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 500 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_cradle_vents_parent_cs";
    fe [[ f ]]( s, "TAURUS_CRADLE_VENTS_01", cf, ( -47529.8, 37555.4, 2400.89 ), ( 0, 305, 0 ), "taurus_boss_01", "cspf_3_auto10571666520918277670", "taurus_boss_vtol_strafe_spawn", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 500 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_cradle_vents_parent_cs";
    fe [[ f ]]( s, "TAURUS_CRADLE_VENTS_01", cf, ( -35722.6, 19250, 2400.89 ), ( 0, 305, 0 ), "cspf_3_auto10571666520918277670", undefined, "taurus_boss_vtol_strafe_delete", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 500 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_cradle_vents_parent_cs";
    fe [[ f ]]( s, "TAURUS_CRADLE_VENTS_01", cf, ( -46581.1, 19141.9, 2400.89 ), ( 0, 65, 0 ), "taurus_boss_01", "cspf_3_auto6955351403784300884", "taurus_boss_vtol_strafe_spawn", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 500 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_cradle_vents_parent_cs";
    fe [[ f ]]( s, "TAURUS_CRADLE_VENTS_01", cf, ( -36631.8, 38520.1, 2400.89 ), ( 0, 65, 0 ), "cspf_3_auto6955351403784300884", undefined, "taurus_boss_vtol_strafe_delete", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 500 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_cradle_vents_parent_cs";
    fe [[ f ]]( s, "TAURUS_CRADLE_VENTS_01", cf, ( -37130.8, 38457, 2400.89 ), ( 0, 245, 0 ), "taurus_boss_01", "cspf_3_auto11068985920193210128", "taurus_boss_vtol_strafe_spawn", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 500 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_cradle_vents_parent_cs";
    fe [[ f ]]( s, "TAURUS_CRADLE_VENTS_01", cf, ( -47080.2, 19079, 2400.89 ), ( 0, 245, 0 ), "cspf_3_auto11068985920193210128", undefined, "taurus_boss_vtol_strafe_delete", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 500 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_cradle_vents_parent_cs";
    fe [[ f ]]( s, "TAURUS_CRADLE_VENTS_01", cf, ( -42955.4, 27536.7, 1589 ), ( 0, 45, 0 ), "taurus_boss_01", undefined, "taurus_boss_location_teleport", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_cradle_vents_parent_cs";
    fe [[ f ]]( s, "TAURUS_CRADLE_VENTS_01", cf, ( -42921.5, 27502.8, 1589 ), ( 0, 45, 0 ), "taurus_boss_01", undefined, "taurus_boss_location_teleport", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_cradle_vents_parent_cs";
    fe [[ f ]]( s, "TAURUS_CRADLE_VENTS_01", cf, ( -42989.4, 27570.6, 1589 ), ( 0, 45, 0 ), "taurus_boss_01", undefined, "taurus_boss_location_teleport", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_cradle_vents_parent_cs";
    fe [[ f ]]( s, "TAURUS_CRADLE_VENTS_01", cf, ( -43023.4, 27604.6, 1589 ), ( 0, 45, 0 ), "taurus_boss_01", undefined, "taurus_boss_location_teleport", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_cradle_vents_parent_cs";
    fe [[ f ]]( s, "TAURUS_CRADLE_VENTS_01", cf, ( -42152.3, 28346.1, 1593 ), ( 0, 270, 0 ), "taurus_boss_01", undefined, "taurus_boss_teleport_threshold", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 300 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_cradle_vents_parent_cs";
    fe [[ f ]]( s, "TAURUS_CRADLE_VENTS_01", cf, ( -41882.3, 27764.1, 1593 ), ( 0, 270, 0 ), "taurus_boss_01", undefined, "taurus_boss_teleport_threshold", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 300 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_cradle_vents_parent_cs";
    fe [[ f ]]( s, "TAURUS_CRADLE_VENTS_01", cf, ( -42778.3, 28466.1, 1593 ), ( 0, 270, 0 ), "taurus_boss_01", undefined, "taurus_boss_teleport_threshold", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 300 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_cradle_vents_parent_cs";
    fe [[ f ]]( s, "TAURUS_CRADLE_VENTS_01", cf, ( -41480.3, 28134.1, 1777 ), ( 0, 0, 0 ), "taurus_boss_01", undefined, "taurus_boss_teleport", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_cradle_vents_parent_cs";
    fe [[ f ]]( s, "TAURUS_CRADLE_VENTS_01", cf, ( -41014.3, 28642.1, 1593 ), ( 0, 270, 0 ), "taurus_boss_01", undefined, "taurus_boss_teleport_threshold", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 300 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_cradle_vents_parent_cs";
    fe [[ f ]]( s, "TAURUS_CRADLE_VENTS_01", cf, ( -42734.3, 29808.1, 1593 ), ( 0, 270, 0 ), "taurus_boss_01", undefined, "taurus_boss_teleport_threshold", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 300 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_cradle_vents_parent_cs";
    fe [[ f ]]( s, "TAURUS_CRADLE_VENTS_01", cf, ( -41544.3, 28262.1, 1777 ), ( 0, 0, 0 ), "taurus_boss_01", undefined, "taurus_boss_mega_jump", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_cradle_vents_parent_cs";
    fe [[ f ]]( s, "TAURUS_CRADLE_VENTS_01", cf, ( -41496.3, 28550.1, 1777 ), ( 0, 0, 0 ), "taurus_boss_01", undefined, "taurus_boss_mega_jump", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_cradle_vents_parent_cs";
    fe [[ f ]]( s, "TAURUS_CRADLE_VENTS_01", cf, ( -41288.3, 28422.1, 1777 ), ( 0, 0, 0 ), "taurus_boss_01", undefined, "taurus_boss_mega_jump", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_cradle_vents_parent_cs";
    fe [[ f ]]( s, "TAURUS_CRADLE_VENTS_01", cf, ( -41592.3, 27862.1, 1729 ), ( 0, 0, 0 ), "taurus_boss_01", undefined, "taurus_boss_mega_jump", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_cradle_vents_parent_cs";
    fe [[ f ]]( s, "TAURUS_CRADLE_VENTS_01", cf, ( -40904.3, 28190.1, 1729 ), ( 0, 0, 0 ), "taurus_boss_01", undefined, "taurus_boss_mega_jump", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_cradle_vents_parent_cs";
    fe [[ f ]]( s, "TAURUS_CRADLE_VENTS_01", cf, ( -41776.3, 29318.1, 1753 ), ( 0, 0, 0 ), "taurus_boss_01", undefined, "taurus_boss_mega_jump", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_cradle_vents_parent_cs";
    fe [[ f ]]( s, "TAURUS_CRADLE_VENTS_01", cf, ( -42528.3, 29078.1, 1697 ), ( 0, 0, 0 ), "taurus_boss_01", undefined, "taurus_boss_mega_jump", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_cradle_vents_parent_cs";
    fe [[ f ]]( s, "TAURUS_CRADLE_VENTS_01", cf, ( -42712.3, 29470.1, 1697 ), ( 0, 0, 0 ), "taurus_boss_01", undefined, "taurus_boss_mega_jump", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_cradle_vents_parent_cs";
    fe [[ f ]]( s, "TAURUS_CRADLE_VENTS_01", cf, ( -42779.8, 29401.6, 1698.5 ), ( 0, 0, 0 ), "taurus_boss_01", undefined, "taurus_boss_teleport", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_cradle_vents_parent_cs";
    fe [[ f ]]( s, "TAURUS_CRADLE_VENTS_01", cf, ( -42192.3, 27782.1, 1881 ), ( 0, 0, 0 ), "taurus_boss_01", undefined, "taurus_boss_mega_jump", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_cradle_vents_parent_cs";
    fe [[ f ]]( s, "TAURUS_CRADLE_VENTS_01", cf, ( -41440.3, 27486.1, 1729 ), ( 0, 0, 0 ), "taurus_boss_01", undefined, "taurus_boss_mega_jump", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_cradle_vents_parent_cs";
    fe [[ f ]]( s, "TAURUS_CRADLE_VENTS_01", cf, ( -41992.3, 29934.1, 1761 ), ( 0, 0, 0 ), "taurus_boss_01", undefined, "taurus_boss_mega_jump", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_cradle_vents_parent_cs";
    fe [[ f ]]( s, "TAURUS_CRADLE_VENTS_01", cf, ( -41264.3, 29910.1, 1761 ), ( 0, 0, 0 ), "taurus_boss_01", undefined, "taurus_boss_mega_jump", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_cradle_vents_parent_cs";
    fe [[ f ]]( s, "TAURUS_CRADLE_VENTS_01", cf, ( -41400.3, 29086.1, 1593 ), ( 0, 0, 0 ), "taurus_boss_01", undefined, "taurus_boss_mega_jump_ground", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_cradle_vents_parent_cs";
    fe [[ f ]]( s, "TAURUS_CRADLE_VENTS_01", cf, ( -41952.3, 28766.1, 1593 ), ( 0, 0, 0 ), "taurus_boss_01", undefined, "taurus_boss_mega_jump_ground", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_cradle_vents_parent_cs";
    fe [[ f ]]( s, "TAURUS_CRADLE_VENTS_01", cf, ( -42072.3, 29102.1, 1593 ), ( 0, 0, 0 ), "taurus_boss_01", undefined, "taurus_boss_mega_jump_ground", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_cradle_vents_parent_cs";
    fe [[ f ]]( s, "TAURUS_CRADLE_VENTS_01", cf, ( -42232.3, 28590.1, 1593 ), ( 0, 0, 0 ), "taurus_boss_01", undefined, "taurus_boss_mega_jump_ground", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_cradle_vents_parent_cs";
    fe [[ f ]]( s, "TAURUS_CRADLE_VENTS_01", cf, ( -42560.3, 28510.1, 1593 ), ( 0, 0, 0 ), "taurus_boss_01", undefined, "taurus_boss_mega_jump_ground", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_cradle_vents_parent_cs";
    fe [[ f ]]( s, "TAURUS_CRADLE_VENTS_01", cf, ( -42424.3, 29454.1, 1593 ), ( 0, 0, 0 ), "taurus_boss_01", undefined, "taurus_boss_mega_jump_ground", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_cradle_vents_parent_cs";
    fe [[ f ]]( s, "TAURUS_CRADLE_VENTS_01", cf, ( -42032.3, 28142.1, 1593 ), ( 0, 0, 0 ), "taurus_boss_01", undefined, "taurus_boss_mega_jump_ground", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_cradle_vents_parent_cs";
    fe [[ f ]]( s, "TAURUS_CRADLE_VENTS_01", cf, ( -41872.3, 27558.1, 1593 ), ( 0, 0, 0 ), "taurus_boss_01", undefined, "taurus_boss_mega_jump_ground", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_cradle_vents_parent_cs";
    fe [[ f ]]( s, "TAURUS_CRADLE_VENTS_01", cf, ( -41096.3, 28806.1, 1593 ), ( 0, 0, 0 ), "taurus_boss_01", undefined, "taurus_boss_mega_jump_ground", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_cradle_vents_parent_cs";
    fe [[ f ]]( s, "TAURUS_CRADLE_VENTS_01", cf, ( -40952.3, 28462.1, 1593 ), ( 0, 0, 0 ), "taurus_boss_01", undefined, "taurus_boss_mega_jump_ground", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_cradle_vents_parent_cs";
    fe [[ f ]]( s, "TAURUS_CRADLE_VENTS_01", cf, ( -41984, 29088, 1144 ), ( 0, 0, 0 ), "taurus_boss_01", undefined, "taurus_boss_hide_struct", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_cradle_vents_parent_cs";
    s.height = 90;
    fe [[ f ]]( s, "TAURUS_CRADLE_VENTS_01", cf, ( -41632.3, 29200.1, 1593 ), ( 0, 0, 0 ), "taurus_boss_01", undefined, "taurus_boss_block_traversal_struct", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 50 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_cradle_vents_parent_cs";
    s.height = 90;
    fe [[ f ]]( s, "TAURUS_CRADLE_VENTS_01", cf, ( -42292.3, 28816.1, 1593 ), ( 0, 0, 0 ), "taurus_boss_01", undefined, "taurus_boss_block_traversal_struct", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 50 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_cradle_vents_parent_cs";
    s.height = 90;
    fe [[ f ]]( s, "TAURUS_CRADLE_VENTS_01", cf, ( -42977.3, 29188.1, 1593 ), ( 0, 0, 0 ), "taurus_boss_01", undefined, "taurus_boss_block_traversal_struct", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 50 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_cradle_vents_parent_cs";
    fe [[ f ]]( s, "TAURUS_CRADLE_VENTS_01", cf, ( -42969.4, 27516.7, 1589 ), ( 0, 47, 0 ), "taurus_boss_01", undefined, "taurus_boss_respawn_struct", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_cradle_vents_parent_cs";
    fe [[ f ]]( s, "TAURUS_CRADLE_VENTS_01", cf, ( -42934.4, 27484, 1589 ), ( 0, 47, 0 ), "taurus_boss_01", undefined, "taurus_boss_respawn_struct", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_cradle_vents_parent_cs";
    fe [[ f ]]( s, "TAURUS_CRADLE_VENTS_01", cf, ( -43004.6, 27549.4, 1589 ), ( 0, 47, 0 ), "taurus_boss_01", undefined, "taurus_boss_respawn_struct", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_cradle_vents_parent_cs";
    fe [[ f ]]( s, "TAURUS_CRADLE_VENTS_01", cf, ( -43039.7, 27582.2, 1589 ), ( 0, 47, 0 ), "taurus_boss_01", undefined, "taurus_boss_respawn_struct", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_cradle_vents_parent_cs";
    fe [[ f ]]( s, "TAURUS_CRADLE_VENTS_01", cf, ( -42151.8, 29045.6, 1593 ), ( 0, 270, 0 ), "taurus_boss_01", undefined, "taurus_boss_teleport_ground", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_cradle_vents_parent_cs";
    s.height = 90;
    fe [[ f ]]( s, "TAURUS_CRADLE_VENTS_01", cf, ( -42725.3, 28957.1, 1593 ), ( 0, 0, 0 ), "taurus_boss_01", undefined, "taurus_boss_block_traversal_struct", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 50 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_cradle_vents_parent_cs";
    s.height = 90;
    fe [[ f ]]( s, "TAURUS_CRADLE_VENTS_01", cf, ( -42478.3, 28806.1, 1593 ), ( 0, 0, 0 ), "taurus_boss_01", undefined, "taurus_boss_block_traversal_struct", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 50 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_taurus_cradle_vents_parent_cs";
    s.height = 90;
    fe [[ f ]]( s, "TAURUS_CRADLE_VENTS_01", cf, ( -43014.3, 29512.1, 1593 ), ( 0, 0, 0 ), "taurus_boss_01", undefined, "taurus_boss_block_traversal_struct", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 50 );
}

// Namespace mp_sat_avalon_q1_ob_contract_taurus_cradle_vents_parent_cs
// Params 0
// Checksum 0x4ffc6ba9, Offset: 0x59d7
// Size: 0xae
function function_d9dd7965c51c95d1()
{
    activityinstances = [];
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_activitydef_taurus_cradle_vents";
    var_881289d7987bc770.cf = "mp_sat_avalon_q1_ob_contract_taurus_cradle_vents_parent_cs";
    var_881289d7987bc770.scriptstructorigin = ( -42123.2, 28114, 1641.9 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [];
    var_881289d7987bc770.var_31ce4477e3543d24 = [];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [];
    var_881289d7987bc770.locationradius = [];
    activityinstances[ "TAURUS_CRADLE_VENTS_01" ] = var_881289d7987bc770;
    return activityinstances;
}

