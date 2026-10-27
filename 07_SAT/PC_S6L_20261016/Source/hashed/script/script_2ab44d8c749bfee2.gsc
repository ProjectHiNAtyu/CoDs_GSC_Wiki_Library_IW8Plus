// script_2ab44d8c749bfee2  (hash_2ab44d8c749bfee2.gscc) (size: 11595 Bytes / 0x2d4b / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x6d89aff2 (1837740018)
// size ...... 11595 (0x2d4b)
// includes .. 4   (offset: 0x26fb)
// strings ... 56  (offset: 0x271b)
// dev strs .. 0   (offset: 0x2d4b)
// exports ... 13  (offset: 0x2217)
// cseg ...... 0x611 + 0x1c06 (0x2217)
// imports ... 26  (offset: 0x241f)
// animtree1 . 0   (offset: 0x2d4b)
// animtree2 . 0   (offset: 0x2d4b)
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace mp_sat_avalon_city_ob_contract_dawg_escort_cs;

// Namespace mp_sat_avalon_city_ob_contract_dawg_escort_cs
// Params 0, eflags: 0x5
// Checksum 0xb5daa5da, Offset: 0x62f
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"mp_sat_avalon_city_ob_contract_dawg_escort_cs", #"activity_common", &function_b39ecd3d51489472, undefined );
}

// Namespace mp_sat_avalon_city_ob_contract_dawg_escort_cs
// Params 0, eflags: 0x4
// Checksum 0xafb0f49f, Offset: 0x658
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace mp_sat_avalon_city_ob_contract_dawg_escort_cs
// Params 0, eflags: 0x4
// Checksum 0x2a8b2773, Offset: 0x669
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace mp_sat_avalon_city_ob_contract_dawg_escort_cs
// Params 2
// Checksum 0xf6e31dae, Offset: 0x67a
// Size: 0x8c
function main( unused, unused2 )
{
    if ( utility::flag_exist( "mp_sat_avalon_city_ob_contract_dawg_escort_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "mp_sat_avalon_city_ob_contract_dawg_escort_cs" ) )
    {
        return;
    }
    
    activity_common::function_e1df676808c1d1e3( &function_4cd78e661617f3 );
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "mp_sat_avalon_city_ob_contract_dawg_escort_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "mp_sat_avalon_city_ob_contract_dawg_escort_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace mp_sat_avalon_city_ob_contract_dawg_escort_cs
// Params 3, eflags: 0x4
// Checksum 0xa90993bc, Offset: 0x70e
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "mp_sat_avalon_city_ob_contract_dawg_escort_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "mp_sat_avalon_city_ob_contract_dawg_escort_cs" );
}

// Namespace mp_sat_avalon_city_ob_contract_dawg_escort_cs
// Params 3, eflags: 0x4
// Checksum 0x5166c7a3, Offset: 0x788
// Size: 0x4fe
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_contract_dawg_escort_cs";
    s.activity_bundle = "sat_ob_activitydefinition_dawg_escort";
    s.name = "ESCORT_DAWG_LOW_TOWN";
    fe [[ f ]]( s, "ESCORT_DAWG_LOW_TOWN", cf, ( -3474.3, -3470.54, 536 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_contract_dawg_escort_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "dawg_escort";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "ESCORT_DAWG_LOW_TOWN", cf, ( -2891.59, -3809.86, 535.5 ), ( 0, 222, 0 ), undefined, undefined, "dawg_escort_low_town", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_contract_dawg_escort_cs";
    fe [[ f ]]( s, "ESCORT_DAWG_LOW_TOWN", cf, ( -2934.62, -3860.21, 535.5 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Awareness_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 1500 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_contract_dawg_escort_cs";
    fe [[ f ]]( s, "ESCORT_DAWG_LOW_TOWN", cf, ( -4849.42, -1358.37, 535.47 ), ( 0, 293.8, 0 ), "activity_nexus_instance_joiner", "ESCORT_DAWG_LOW_TOWN", "ESCORT_DAWG_LOW_TOWN", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_contract_dawg_escort_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "dawg_escort";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "ESCORT_DAWG_LOW_TOWN", cf, ( -2825.37, -4075.87, 536.73 ), ( 0, 318.3, 0 ), undefined, undefined, "dawg_escort_low_town", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_contract_dawg_escort_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "dawg_escort";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "ESCORT_DAWG_LOW_TOWN", cf, ( -3260.56, -3432.9, 536 ), ( 0, 162.3, 0 ), undefined, undefined, "dawg_escort_low_town", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_contract_dawg_escort_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "dawg_escort";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "ESCORT_DAWG_LOW_TOWN", cf, ( -3156.94, -3728.48, 536 ), ( 0, 42, 0 ), undefined, undefined, "dawg_escort_low_town", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace mp_sat_avalon_city_ob_contract_dawg_escort_cs
// Params 0, eflags: 0x4
// Checksum 0xe167a9e3, Offset: 0xc8e
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace mp_sat_avalon_city_ob_contract_dawg_escort_cs
// Params 0
// Checksum 0x6b5a4ef1, Offset: 0xc98
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "mp_sat_avalon_city_ob_contract_dawg_escort_cs" );
}

// Namespace mp_sat_avalon_city_ob_contract_dawg_escort_cs
// Params 0
// Checksum 0x79b567e6, Offset: 0xcae
// Size: 0x66
function function_4cd78e661617f3()
{
    activityinfostruct = {};
    activityinfostruct.name = "REV_OB_ESCORT_DAWG";
    activityinfostruct.scriptbundle = "sat_ob_activitydefinition_dawg_escort";
    activityinfostruct.mainfunction = &main;
    activityinfostruct.var_934f068483ae4ddb = &function_d4323822d7042e5a;
    activityinfostruct.metadatafunction = &function_d9dd7965c51c95d1;
    return activityinfostruct;
}

// Namespace mp_sat_avalon_city_ob_contract_dawg_escort_cs
// Params 4
// Checksum 0xabe0800e, Offset: 0xd1d
// Size: 0x57
function function_d4323822d7042e5a( var_4312b79c960726b6, fe, us, cf = "mp_sat_avalon_city_ob_contract_dawg_escort_cs" )
{
    switch ( var_4312b79c960726b6 )
    {
        case #"hash_1e0bd6b161fd29f":
            function_2d1c1f751886fed7( fe, us, cf );
            break;
    }
}

// Namespace mp_sat_avalon_city_ob_contract_dawg_escort_cs
// Params 3
// Checksum 0x98b8f814, Offset: 0xd7c
// Size: 0x13aa
function function_2d1c1f751886fed7( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node";
    fe [[ f ]]( s, "ESCORT_DAWG_LOW_TOWN", cf, ( 3635.1, -1249.22, 558 ), ( 0, 0, 0 ), "cspf_2_auto1868615636547401434", "cspf_2_auto16044692308504351431", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node";
    fe [[ f ]]( s, "ESCORT_DAWG_LOW_TOWN", cf, ( 3953.81, -1010.11, 558 ), ( 0, 0, 0 ), "cspf_2_auto16044692308504351431", "cspf_2_auto7267152678765197352", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node";
    fe [[ f ]]( s, "ESCORT_DAWG_LOW_TOWN", cf, ( 4362.82, -956.49, 557.5 ), ( 0, 0, 0 ), "cspf_2_auto7267152678765197352", "cspf_2_auto17830674164757866945", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node";
    fe [[ f ]]( s, "ESCORT_DAWG_LOW_TOWN", cf, ( 2882.14, -2493.94, 555.14 ), ( 0, 0, 0 ), "cspf_2_auto753168034460982434", "cspf_2_auto15747674001173024670", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node";
    fe [[ f ]]( s, "ESCORT_DAWG_LOW_TOWN", cf, ( 5584.07, -1299.8, 617.02 ), ( 0, 0, 0 ), "cspf_2_auto7596979517766528467", "cspf_2_auto16705028367543847431", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_contract_dawg_escort_cs";
    fe [[ f ]]( s, "ESCORT_DAWG_LOW_TOWN", cf, ( 6185.25, -1053.74, 647.26 ), ( 0, 0, 0 ), "ESCORT_DAWG_LOW_TOWN_REWARD", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node";
    fe [[ f ]]( s, "ESCORT_DAWG_LOW_TOWN", cf, ( 6114.1, -1219.94, 642.62 ), ( 0, 0, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node";
    fe [[ f ]]( s, "ESCORT_DAWG_LOW_TOWN", cf, ( 5297, -1317.06, 600.36 ), ( 0, 0, 0 ), "cspf_2_auto17830674164757866945", "cspf_2_auto7596979517766528467", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node_ambush";
    s.target2 = "ambush1_point";
    fe [[ f ]]( s, "ESCORT_DAWG_LOW_TOWN", cf, ( -1199.56, -4415.54, 536 ), ( 0, 20.4, 0 ), "cspf_2_auto15630897851852100380", "cspf_2_auto4208633741599071260", "ambush", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node";
    fe [[ f ]]( s, "ESCORT_DAWG_LOW_TOWN", cf, ( 2723.93, -2597.35, 552.96 ), ( 0, 0, 0 ), "cspf_2_auto18043972950886580154", "cspf_2_auto753168034460982434", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node_ambush";
    s.target2 = "ambush2_point";
    fe [[ f ]]( s, "ESCORT_DAWG_LOW_TOWN", cf, ( 666.35, -3639.05, 510.75 ), ( 0, 0, 0 ), "cspf_2_auto1607611484420627356", "cspf_2_auto9312016267918506334", "ambush", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node";
    fe [[ f ]]( s, "ESCORT_DAWG_LOW_TOWN", cf, ( 1513.93, -2972.55, 542.5 ), ( 0, 0, 0 ), "cspf_2_auto10541923940865691922", "cspf_2_auto11006185141580917401", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node";
    fe [[ f ]]( s, "ESCORT_DAWG_LOW_TOWN", cf, ( -1086.75, -4269.21, 536 ), ( 0, 0, 0 ), "cspf_2_auto4208633741599071260", "cspf_2_auto1931754452578709676", "attack", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_contract_dawg_escort_cs";
    fe [[ f ]]( s, "ESCORT_DAWG_LOW_TOWN", cf, ( -3426.67, -3504.94, 537.55 ), ( 0, 0, 0 ), "ESCORT_DAWG_LOW_TOWN", undefined, "dawg_escort_low_town", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node";
    fe [[ f ]]( s, "ESCORT_DAWG_LOW_TOWN", cf, ( 1145.88, -3180.09, 510.75 ), ( 0, 0, 0 ), "cspf_2_auto17740595116870458809", "cspf_2_auto10541923940865691922", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_contract_dawg_escort_cs";
    s.name = "ambush1_point";
    fe [[ f ]]( s, "ESCORT_DAWG_LOW_TOWN", cf, ( -593.66, -3587, 536 ), ( 0, 0, 0 ), "ambush1_point", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 300 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_contract_dawg_escort_cs";
    s.name = "ambush1_point";
    fe [[ f ]]( s, "ESCORT_DAWG_LOW_TOWN", cf, ( -312.1, -4216.6, 536 ), ( 0, 270, 0 ), "ambush1_point", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 300 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_contract_dawg_escort_cs";
    s.name = "ambush1_point";
    fe [[ f ]]( s, "ESCORT_DAWG_LOW_TOWN", cf, ( -661.07, -5172.17, 536 ), ( 0, 0, 0 ), "ambush1_point", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 300 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_contract_dawg_escort_cs";
    s.name = "ambush2_point";
    fe [[ f ]]( s, "ESCORT_DAWG_LOW_TOWN", cf, ( 843.57, -2822.71, 510.75 ), ( 0, 0, 0 ), "ambush2_point", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 300 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_contract_dawg_escort_cs";
    s.name = "ambush2_point";
    fe [[ f ]]( s, "ESCORT_DAWG_LOW_TOWN", cf, ( 1478.27, -2910.59, 535.01 ), ( 0, 0, 0 ), "ambush2_point", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 300 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_contract_dawg_escort_cs";
    s.name = "ambush2_point";
    fe [[ f ]]( s, "ESCORT_DAWG_LOW_TOWN", cf, ( 1699.58, -3476.16, 544.5 ), ( 0, 0, 0 ), "ambush2_point", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 300 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_contract_dawg_escort_cs";
    s.name = "ambush3_point";
    fe [[ f ]]( s, "ESCORT_DAWG_LOW_TOWN", cf, ( 3985.78, -2019.21, 584.5 ), ( 0, 0, 0 ), "ambush3_point", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 300 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_contract_dawg_escort_cs";
    s.name = "ambush3_point";
    fe [[ f ]]( s, "ESCORT_DAWG_LOW_TOWN", cf, ( 4239.84, -1262.25, 563 ), ( 0, 0, 0 ), "ambush3_point", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 300 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_contract_dawg_escort_cs";
    s.name = "ambush3_point";
    fe [[ f ]]( s, "ESCORT_DAWG_LOW_TOWN", cf, ( 3799.21, -659.67, 563 ), ( 0, 0, 0 ), "ambush3_point", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 300 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node";
    fe [[ f ]]( s, "ESCORT_DAWG_LOW_TOWN", cf, ( 2363.62, -2761.27, 540.33 ), ( 0, 0, 0 ), "cspf_2_auto11391911955718121482", "cspf_2_auto18043972950886580154", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node";
    fe [[ f ]]( s, "ESCORT_DAWG_LOW_TOWN", cf, ( 2091.91, -2774.75, 540.21 ), ( 0, 0, 0 ), "cspf_2_auto11006185141580917401", "cspf_2_auto11391911955718121482", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node";
    fe [[ f ]]( s, "ESCORT_DAWG_LOW_TOWN", cf, ( 1110.65, -3467.9, 510.75 ), ( 0, 0, 0 ), "cspf_2_auto9312016267918506334", "cspf_2_auto17740595116870458809", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node";
    fe [[ f ]]( s, "ESCORT_DAWG_LOW_TOWN", cf, ( -1335.98, -4470.76, 536 ), ( 0, 0, 0 ), "cspf_2_auto13978540722589699991", "cspf_2_auto15630897851852100380", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node";
    fe [[ f ]]( s, "ESCORT_DAWG_LOW_TOWN", cf, ( -1646.37, -4631.56, 541.6 ), ( 0, 0, 0 ), "cspf_2_auto14556961221537003159", "cspf_2_auto13978540722589699991", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node_ambush";
    s.target2 = "ambush3_point";
    fe [[ f ]]( s, "ESCORT_DAWG_LOW_TOWN", cf, ( 3219.53, -1946.55, 557.5 ), ( 0, 177.6, 0 ), "cspf_2_auto15747674001173024670", "cspf_2_auto1868615636547401434", "ambush", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node";
    fe [[ f ]]( s, "ESCORT_DAWG_LOW_TOWN", cf, ( -1958.21, -4718.38, 538.91 ), ( 0, 0, 0 ), "cspf_2_auto15372287976933566247", "cspf_2_auto14556961221537003159", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node";
    fe [[ f ]]( s, "ESCORT_DAWG_LOW_TOWN", cf, ( -774.73, -4253.26, 536 ), ( 0, 0, 0 ), "cspf_2_auto1931754452578709676", "cspf_2_auto10502796266513790248", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node";
    fe [[ f ]]( s, "ESCORT_DAWG_LOW_TOWN", cf, ( -2150.18, -4642.16, 535 ), ( 0, 0, 0 ), "cspf_2_auto5074901369842898268", "cspf_2_auto15372287976933566247", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node";
    fe [[ f ]]( s, "ESCORT_DAWG_LOW_TOWN", cf, ( 63.27, -3887.29, 536 ), ( 0, 0, 0 ), "cspf_2_auto10502796266513790248", "cspf_2_auto1607611484420627356", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_contract_dawg_escort_cs";
    s.name = "ambushend_point";
    fe [[ f ]]( s, "ESCORT_DAWG_LOW_TOWN", cf, ( 6922.51, -1588.83, 716 ), ( 0, 0, 0 ), "ambushend_point", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 300 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_contract_dawg_escort_cs";
    s.name = "ambushend_point";
    fe [[ f ]]( s, "ESCORT_DAWG_LOW_TOWN", cf, ( 5703.84, -164.93, 644.5 ), ( 0, 0, 0 ), "ambushend_point", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 300 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_contract_dawg_escort_cs";
    s.name = "ambushend_point";
    fe [[ f ]]( s, "ESCORT_DAWG_LOW_TOWN", cf, ( 7283.75, -286.1, 716.25 ), ( 0, 0, 0 ), "ambushend_point", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 300 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "start_path";
    fe [[ f ]]( s, "ESCORT_DAWG_LOW_TOWN", cf, ( -2934.62, -3860.21, 535.5 ), ( 0, 314.3, 0 ), "ESCORT_DAWG_LOW_TOWN_PATH_START", "cspf_2_auto5074901369842898268", "path_start_node", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_city_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node_end";
    s.target2 = "ambushend_point";
    fe [[ f ]]( s, "ESCORT_DAWG_LOW_TOWN", cf, ( 6172.23, -923.81, 647.4 ), ( 0, 38, 0 ), "cspf_2_auto16705028367543847431", undefined, "ESCORT_DAWG_LOW_TOWN_ENDPOINT", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_sat_avalon_city_ob_contract_dawg_escort_cs
// Params 0
// Checksum 0xc84b63f5, Offset: 0x212e
// Size: 0xe8
function function_d9dd7965c51c95d1()
{
    activityinstances = [];
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_ob_activitydefinition_dawg_escort";
    var_881289d7987bc770.cf = "mp_sat_avalon_city_ob_contract_dawg_escort_cs";
    var_881289d7987bc770.scriptstructorigin = ( -3474.3, -3470.54, 536 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [ ( 824.68, -2794.05, 459.15 ) ];
    var_881289d7987bc770.var_31ce4477e3543d24 = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.locationradius = [ 6000 ];
    activityinstances[ "ESCORT_DAWG_LOW_TOWN" ] = var_881289d7987bc770;
    return activityinstances;
}

