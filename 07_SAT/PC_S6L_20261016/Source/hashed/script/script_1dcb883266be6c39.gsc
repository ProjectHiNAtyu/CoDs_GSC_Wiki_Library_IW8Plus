// script_1dcb883266be6c39  (hash_1dcb883266be6c39.gscc) (size: 19966 Bytes / 0x4dfe / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x211f8ecf (555716303)
// size ...... 19966 (0x4dfe)
// includes .. 4   (offset: 0x42ae)
// strings ... 83  (offset: 0x42ce)
// dev strs .. 0   (offset: 0x4dfe)
// exports ... 14  (offset: 0x3d82)
// cseg ...... 0x98e + 0x33f4 (0x3d82)
// imports ... 27  (offset: 0x3fb2)
// animtree1 . 0   (offset: 0x4dfe)
// animtree2 . 0   (offset: 0x4dfe)
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace mp_sat_avalon_q2_ob_contract_dawg_escort_cs;

// Namespace mp_sat_avalon_q2_ob_contract_dawg_escort_cs
// Params 0, eflags: 0x5
// Checksum 0xe70507e2, Offset: 0x9ac
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"mp_sat_avalon_q2_ob_contract_dawg_escort_cs", #"activity_common", &function_b39ecd3d51489472, undefined );
}

// Namespace mp_sat_avalon_q2_ob_contract_dawg_escort_cs
// Params 0, eflags: 0x4
// Checksum 0xaa64d983, Offset: 0x9d5
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace mp_sat_avalon_q2_ob_contract_dawg_escort_cs
// Params 0, eflags: 0x4
// Checksum 0x2f5f0a6f, Offset: 0x9e6
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace mp_sat_avalon_q2_ob_contract_dawg_escort_cs
// Params 2
// Checksum 0xda1b5796, Offset: 0x9f7
// Size: 0x8c
function main( unused, unused2 )
{
    if ( utility::flag_exist( "mp_sat_avalon_q2_ob_contract_dawg_escort_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "mp_sat_avalon_q2_ob_contract_dawg_escort_cs" ) )
    {
        return;
    }
    
    activity_common::function_e1df676808c1d1e3( &function_4cd78e661617f3 );
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "mp_sat_avalon_q2_ob_contract_dawg_escort_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "mp_sat_avalon_q2_ob_contract_dawg_escort_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace mp_sat_avalon_q2_ob_contract_dawg_escort_cs
// Params 3, eflags: 0x4
// Checksum 0xacddbea0, Offset: 0xa8b
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "mp_sat_avalon_q2_ob_contract_dawg_escort_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "mp_sat_avalon_q2_ob_contract_dawg_escort_cs" );
}

// Namespace mp_sat_avalon_q2_ob_contract_dawg_escort_cs
// Params 3, eflags: 0x4
// Checksum 0x797fed32, Offset: 0xb05
// Size: 0x9b0
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_dawg_escort_cs";
    s.activity_bundle = "sat_ob_activitydefinition_dawg_escort";
    s.name = "ESCORT_DAWG_CLIFFTOWN";
    fe [[ f ]]( s, "ESCORT_DAWG_CLIFFTOWN", cf, ( 39435.4, 11935.2, 1034.14 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_dawg_escort_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "dawg_escort";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "ESCORT_DAWG_CLIFFTOWN", cf, ( 39544.9, 11966.7, 1020.97 ), ( 0, 312, 0 ), undefined, undefined, "dawg_escort_clifftown", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_dawg_escort_cs";
    fe [[ f ]]( s, "ESCORT_DAWG_CLIFFTOWN", cf, ( 41888.7, 10903.5, 87.28 ), ( 0, 99.59, 0 ), "activity_nexus_instance_joiner", "ESCORT_DAWG_CLIFFTOWN", "ESCORT_DAWG_CLIFFTOWN", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_dawg_escort_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "dawg_escort";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "ESCORT_DAWG_CLIFFTOWN", cf, ( 39276.9, 11830.5, 1053.26 ), ( 0, 54.8, 0 ), undefined, undefined, "dawg_escort_clifftown", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_dawg_escort_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "dawg_escort";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "ESCORT_DAWG_CLIFFTOWN", cf, ( 38794.1, 11865.2, 1064 ), ( 0, 312, 0 ), undefined, undefined, "dawg_escort_clifftown", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_dawg_escort_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "dawg_escort";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "ESCORT_DAWG_CLIFFTOWN", cf, ( 38876.2, 11231.4, 1062.82 ), ( 0, 343.6, 0 ), undefined, undefined, "dawg_escort_clifftown", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_dawg_escort_cs";
    fe [[ f ]]( s, "ESCORT_DAWG_CLIFFTOWN", cf, ( 39208.4, 11993.3, 1060.52 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Awareness_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 1500 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_dawg_escort_cs";
    s.activity_bundle = "sat_ob_activitydefinition_dawg_escort";
    s.name = "ESCORT_DAWG_WINERY";
    fe [[ f ]]( s, "ESCORT_DAWG_WINERY", cf, ( 18797, 52742.8, 888 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_dawg_escort_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "dawg_escort";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "ESCORT_DAWG_WINERY", cf, ( 19407.1, 52270.8, 887.82 ), ( 0, 12.8, 0 ), undefined, undefined, "dawg_escort_winery", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_dawg_escort_cs";
    fe [[ f ]]( s, "ESCORT_DAWG_WINERY", cf, ( 21913.1, 55203.8, 708.5 ), ( 0, 215.29, 0 ), "activity_nexus_instance_joiner", "ESCORT_DAWG_WINERY", "ESCORT_DAWG_WINERY", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_dawg_escort_cs";
    fe [[ f ]]( s, "ESCORT_DAWG_WINERY", cf, ( 18892.6, 52669.8, 888 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Awareness_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 1500 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_dawg_escort_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "dawg_escort";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "ESCORT_DAWG_WINERY", cf, ( 18728.6, 52591.1, 888 ), ( 0, 342.7, 0 ), undefined, undefined, "dawg_escort_winery", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_dawg_escort_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "dawg_escort";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "ESCORT_DAWG_WINERY", cf, ( 19106.8, 52756.1, 888 ), ( 0, 281.1, 0 ), undefined, undefined, "dawg_escort_winery", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_dawg_escort_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "dawg_escort";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "ESCORT_DAWG_WINERY", cf, ( 19066, 52501.4, 888 ), ( 0, 198.3, 0 ), undefined, undefined, "dawg_escort_winery", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace mp_sat_avalon_q2_ob_contract_dawg_escort_cs
// Params 0, eflags: 0x4
// Checksum 0xcd9fe3db, Offset: 0x14bd
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace mp_sat_avalon_q2_ob_contract_dawg_escort_cs
// Params 0
// Checksum 0x6e8e63ed, Offset: 0x14c7
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "mp_sat_avalon_q2_ob_contract_dawg_escort_cs" );
}

// Namespace mp_sat_avalon_q2_ob_contract_dawg_escort_cs
// Params 0
// Checksum 0x7c614afa, Offset: 0x14dd
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

// Namespace mp_sat_avalon_q2_ob_contract_dawg_escort_cs
// Params 4
// Checksum 0x7e3c70d6, Offset: 0x154c
// Size: 0x71
function function_d4323822d7042e5a( var_4312b79c960726b6, fe, us, cf = "mp_sat_avalon_q2_ob_contract_dawg_escort_cs" )
{
    switch ( var_4312b79c960726b6 )
    {
        case #"hash_80ffa89a00dc5b92":
            function_717dc4dc232e6eca( fe, us, cf );
            break;
        case #"hash_2289341ba6279484":
            function_36a873b93a27c09c( fe, us, cf );
            break;
    }
}

// Namespace mp_sat_avalon_q2_ob_contract_dawg_escort_cs
// Params 3
// Checksum 0x59388147, Offset: 0x15c5
// Size: 0x12bc
function function_717dc4dc232e6eca( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node";
    fe [[ f ]]( s, "ESCORT_DAWG_CLIFFTOWN", cf, ( 38973.5, 11333.7, 1059.9 ), ( 0, 0, 0 ), "cspf_3_auto13800611643972878409", "cspf_3_auto15747674001173024670", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node";
    fe [[ f ]]( s, "ESCORT_DAWG_CLIFFTOWN", cf, ( 41405.8, 8576.43, 1095.11 ), ( 0, 0, 0 ), "cspf_3_auto9148947221812865071", "cspf_3_auto15630897851852100380", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node";
    fe [[ f ]]( s, "ESCORT_DAWG_CLIFFTOWN", cf, ( 38838.8, 11606.7, 1060.5 ), ( 0, 0, 0 ), "cspf_3_auto6003449379766086771", "cspf_3_auto13800611643972878409", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node";
    fe [[ f ]]( s, "ESCORT_DAWG_CLIFFTOWN", cf, ( 39608.3, 10515.4, 1016.29 ), ( 0, 0, 0 ), "cspf_3_auto10688394956594171936", "cspf_3_auto5348514299692589813", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "start_path";
    fe [[ f ]]( s, "ESCORT_DAWG_CLIFFTOWN", cf, ( 39208.4, 11993.3, 1060.52 ), ( 0, 205.7, -0 ), "ESCORT_DAWG_CLIFFTOWN_PATH_START", "cspf_3_auto15580734621475046237", "path_start_node", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_dawg_escort_cs";
    fe [[ f ]]( s, "ESCORT_DAWG_CLIFFTOWN", cf, ( 42217, 7221.28, 1251.1 ), ( 0, 0, 0 ), "ESCORT_DAWG_CLIFFTOWN_REWARD", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node";
    fe [[ f ]]( s, "ESCORT_DAWG_CLIFFTOWN", cf, ( 42997.2, 6882.26, 1274.36 ), ( 0, 267.8, 0 ), "cspf_3_auto11156031664289587569", "cspf_3_auto5046764984057054530", "attack", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node";
    fe [[ f ]]( s, "ESCORT_DAWG_CLIFFTOWN", cf, ( 38932.8, 11874, 1059.78 ), ( 0, 0, 0 ), "cspf_3_auto15580734621475046237", "cspf_3_auto6003449379766086771", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node_ambush";
    s.target2 = "ambush1_point";
    fe [[ f ]]( s, "ESCORT_DAWG_CLIFFTOWN", cf, ( 39291.7, 11018.3, 1059.43 ), ( 0, 0, 0 ), "cspf_3_auto15747674001173024670", "cspf_3_auto10688394956594171936", "ambush", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node";
    fe [[ f ]]( s, "ESCORT_DAWG_CLIFFTOWN", cf, ( 39617.5, 10264.9, 993.29 ), ( 0, 0, 0 ), "cspf_3_auto5348514299692589813", "cspf_3_auto16945942842540786971", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node_ambush";
    s.target2 = "ambush2_point";
    fe [[ f ]]( s, "ESCORT_DAWG_CLIFFTOWN", cf, ( 39757.7, 9143.82, 921 ), ( 0, 0, 0 ), "cspf_3_auto7506293857130010347", "cspf_3_auto9312016267918506334", "ambush", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node";
    fe [[ f ]]( s, "ESCORT_DAWG_CLIFFTOWN", cf, ( 39767.5, 9375.92, 948.62 ), ( 0, 0, 0 ), "cspf_3_auto16257117452669729480", "cspf_3_auto7506293857130010347", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node_ambush";
    s.target2 = "ambush3_point";
    fe [[ f ]]( s, "ESCORT_DAWG_CLIFFTOWN", cf, ( 41388.2, 8085.94, 1139.01 ), ( 0, 0, 0 ), "cspf_3_auto15630897851852100380", "cspf_3_auto1868615636547401434", "ambush", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node";
    fe [[ f ]]( s, "ESCORT_DAWG_CLIFFTOWN", cf, ( 41494.5, 7895.62, 1137.6 ), ( 0, 0, 0 ), "cspf_3_auto1868615636547401434", "cspf_3_auto13677630410256605362", "attack", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_dawg_escort_cs";
    fe [[ f ]]( s, "ESCORT_DAWG_CLIFFTOWN", cf, ( 39442.2, 11971.1, 1038.65 ), ( 0, 0, 0 ), "ESCORT_DAWG_CLIFFTOWN", undefined, "dawg_escort_clifftown", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node_end";
    s.target2 = "ambushend_point";
    fe [[ f ]]( s, "ESCORT_DAWG_CLIFFTOWN", cf, ( 44206.3, 7107.3, 1384 ), ( 0, 346, 0 ), "cspf_3_auto13631424358659564518", undefined, "ESCORT_DAWG_CLIFFTOWN_ENDPOINT", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_dawg_escort_cs";
    s.name = "ambush1_point";
    fe [[ f ]]( s, "ESCORT_DAWG_CLIFFTOWN", cf, ( 38960.5, 10206.9, 1120 ), ( 0, 0, 0 ), "ambush1_point", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 300 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_dawg_escort_cs";
    s.name = "ambush1_point";
    fe [[ f ]]( s, "ESCORT_DAWG_CLIFFTOWN", cf, ( 40144.6, 10270.8, 1005.56 ), ( 0, 270, 0 ), "ambush1_point", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 300 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_dawg_escort_cs";
    s.name = "ambush1_point";
    fe [[ f ]]( s, "ESCORT_DAWG_CLIFFTOWN", cf, ( 40241.7, 10893, 1056.07 ), ( 0, 0, 0 ), "ambush1_point", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 300 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_dawg_escort_cs";
    s.name = "ambush2_point";
    fe [[ f ]]( s, "ESCORT_DAWG_CLIFFTOWN", cf, ( 39848.8, 8217.98, 896.75 ), ( 0, 0, 0 ), "ambush2_point", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 300 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_dawg_escort_cs";
    s.name = "ambush2_point";
    fe [[ f ]]( s, "ESCORT_DAWG_CLIFFTOWN", cf, ( 39016, 8819.16, 960.11 ), ( 0, 0, 0 ), "ambush2_point", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 300 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_dawg_escort_cs";
    s.name = "ambush2_point";
    fe [[ f ]]( s, "ESCORT_DAWG_CLIFFTOWN", cf, ( 40495.9, 8865.78, 1008 ), ( 0, 0, 0 ), "ambush2_point", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 300 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_dawg_escort_cs";
    s.name = "ambush3_point";
    fe [[ f ]]( s, "ESCORT_DAWG_CLIFFTOWN", cf, ( 41334.4, 7300.76, 1170 ), ( 0, 0, 0 ), "ambush3_point", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 300 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_dawg_escort_cs";
    s.name = "ambush3_point";
    fe [[ f ]]( s, "ESCORT_DAWG_CLIFFTOWN", cf, ( 40548.9, 7373.03, 1078.75 ), ( 0, 0, 0 ), "ambush3_point", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 300 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_dawg_escort_cs";
    s.name = "ambush3_point";
    fe [[ f ]]( s, "ESCORT_DAWG_CLIFFTOWN", cf, ( 42290.6, 7402.12, 1242.73 ), ( 0, 0, 0 ), "ambush3_point", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 300 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node";
    fe [[ f ]]( s, "ESCORT_DAWG_CLIFFTOWN", cf, ( 39421.3, 9937.77, 984.14 ), ( 0, 0, 0 ), "cspf_3_auto16945942842540786971", "cspf_3_auto3694911459347536485", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node";
    fe [[ f ]]( s, "ESCORT_DAWG_CLIFFTOWN", cf, ( 39444.6, 9722.1, 975.11 ), ( 0, 0, 0 ), "cspf_3_auto3694911459347536485", "cspf_3_auto16257117452669729480", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node";
    fe [[ f ]]( s, "ESCORT_DAWG_CLIFFTOWN", cf, ( 39818.7, 8860.49, 880.62 ), ( 0, 0, 0 ), "cspf_3_auto9312016267918506334", "cspf_3_auto2973328367453607495", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node";
    fe [[ f ]]( s, "ESCORT_DAWG_CLIFFTOWN", cf, ( 42162.7, 7430.04, 1216.79 ), ( 0, 0, 0 ), "cspf_3_auto13677630410256605362", "cspf_3_auto593872273934552400", "attack", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node";
    fe [[ f ]]( s, "ESCORT_DAWG_CLIFFTOWN", cf, ( 42405, 7322.95, 1254.51 ), ( 0, 0, 0 ), "cspf_3_auto593872273934552400", "cspf_3_auto10606635314809095629", "attack", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node";
    fe [[ f ]]( s, "ESCORT_DAWG_CLIFFTOWN", cf, ( 40211, 8548.24, 898.69 ), ( 0, 0, 0 ), "cspf_3_auto2973328367453607495", "cspf_3_auto3188208149445745104", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node";
    fe [[ f ]]( s, "ESCORT_DAWG_CLIFFTOWN", cf, ( 42821.5, 6788.18, 1258.46 ), ( 0, 267.8, 0 ), "cspf_3_auto10606635314809095629", "cspf_3_auto11156031664289587569", "attack", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node";
    fe [[ f ]]( s, "ESCORT_DAWG_CLIFFTOWN", cf, ( 43513, 7270.62, 1304 ), ( 0, 348.8, 0 ), "cspf_3_auto5046764984057054530", "cspf_3_auto13631424358659564518", "attack", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node";
    fe [[ f ]]( s, "ESCORT_DAWG_CLIFFTOWN", cf, ( 41015.5, 8952.32, 986.7 ), ( 0, 0, 0 ), "cspf_3_auto3188208149445745104", "cspf_3_auto9148947221812865071", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_dawg_escort_cs";
    s.name = "ambushend_point";
    fe [[ f ]]( s, "ESCORT_DAWG_CLIFFTOWN", cf, ( 45017, 7733.74, 1288 ), ( 0, 0, 0 ), "ambushend_point", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 300 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_dawg_escort_cs";
    s.name = "ambushend_point";
    fe [[ f ]]( s, "ESCORT_DAWG_CLIFFTOWN", cf, ( 44193.6, 8099.21, 1384 ), ( 0, 0, 0 ), "ambushend_point", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 300 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_dawg_escort_cs";
    s.name = "ambushend_point";
    fe [[ f ]]( s, "ESCORT_DAWG_CLIFFTOWN", cf, ( 43780, 6438.17, 1496 ), ( 0, 0, 0 ), "ambushend_point", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 300 );
}

// Namespace mp_sat_avalon_q2_ob_contract_dawg_escort_cs
// Params 3
// Checksum 0xfbf8d63b, Offset: 0x2889
// Size: 0x1339
function function_36a873b93a27c09c( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node";
    fe [[ f ]]( s, "ESCORT_DAWG_WINERY", cf, ( 18339.5, 51917.6, 888 ), ( 0, 0, 0 ), "cspf_4_auto13800611643972878409", "cspf_4_auto15747674001173024670", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node";
    fe [[ f ]]( s, "ESCORT_DAWG_WINERY", cf, ( 17474.1, 49116.5, 814.02 ), ( 0, 0, 0 ), "cspf_4_auto15920535377439089584", "cspf_4_auto794810206124290573", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node";
    fe [[ f ]]( s, "ESCORT_DAWG_WINERY", cf, ( 17229.4, 48561.4, 817.09 ), ( 0, 0, 0 ), "cspf_4_auto794810206124290573", "cspf_4_auto6254498937379152790", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node";
    fe [[ f ]]( s, "ESCORT_DAWG_WINERY", cf, ( 18558.5, 52127.9, 888 ), ( 0, 0, 0 ), "cspf_4_auto6003449379766086771", "cspf_4_auto13800611643972878409", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node";
    fe [[ f ]]( s, "ESCORT_DAWG_WINERY", cf, ( 18121.8, 51415.6, 888 ), ( 0, 0, 0 ), "cspf_4_auto10688394956594171936", "cspf_4_auto5348514299692589813", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "start_path";
    fe [[ f ]]( s, "ESCORT_DAWG_WINERY", cf, ( 18892.6, 52669.8, 888 ), ( 360, 280, -0 ), "ESCORT_DAWG_WINERY_PATH_START", "cspf_4_auto15580734621475046237", "path_start_node", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_dawg_escort_cs";
    fe [[ f ]]( s, "ESCORT_DAWG_WINERY", cf, ( 18776.2, 44785.3, 820.5 ), ( 0, 0, 0 ), "ESCORT_DAWG_WINERY_REWARD", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node";
    fe [[ f ]]( s, "ESCORT_DAWG_WINERY", cf, ( 17868.4, 50546.8, 822.93 ), ( 0, 0, 0 ), "cspf_4_auto12026477965097220007", "cspf_4_auto3694911459347536485", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node";
    fe [[ f ]]( s, "ESCORT_DAWG_WINERY", cf, ( 18881.3, 52548.2, 888 ), ( 0, 0, 0 ), "cspf_4_auto15580734621475046237", "cspf_4_auto6003449379766086771", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node_ambush";
    s.target2 = "ambush1_point";
    fe [[ f ]]( s, "ESCORT_DAWG_WINERY", cf, ( 18375.9, 51492.2, 888 ), ( 0, 280.7, 0 ), "cspf_4_auto15747674001173024670", "cspf_4_auto10688394956594171936", "ambush", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node";
    fe [[ f ]]( s, "ESCORT_DAWG_WINERY", cf, ( 18069.6, 51146.1, 888 ), ( 0, 0, 0 ), "cspf_4_auto5348514299692589813", "cspf_4_auto16945942842540786971", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node_ambush";
    s.target2 = "ambush2_point";
    fe [[ f ]]( s, "ESCORT_DAWG_WINERY", cf, ( 18131.9, 47939.9, 824 ), ( 0, 11.2, 0 ), "cspf_4_auto7506293857130010347", "cspf_4_auto9312016267918506334", "ambush", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node";
    fe [[ f ]]( s, "ESCORT_DAWG_WINERY", cf, ( 17431.8, 50017, 819.94 ), ( 0, 0, 0 ), "cspf_4_auto3694911459347536485", "cspf_4_auto15920535377439089584", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node_ambush";
    s.target2 = "ambush3_point";
    fe [[ f ]]( s, "ESCORT_DAWG_WINERY", cf, ( 18817.1, 46645.5, 824.25 ), ( 0, 279.5, 0 ), "cspf_4_auto3188208149445745104", "cspf_4_auto1868615636547401434", "ambush", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node";
    fe [[ f ]]( s, "ESCORT_DAWG_WINERY", cf, ( 18929.4, 46516.1, 824.25 ), ( 0, 0, 0 ), "cspf_4_auto1868615636547401434", "cspf_4_auto13677630410256605362", "attack", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_dawg_escort_cs";
    fe [[ f ]]( s, "ESCORT_DAWG_WINERY", cf, ( 18824.9, 52700.7, 888 ), ( 0, 0, 0 ), "ESCORT_DAWG_WINERY", undefined, "dawg_escort_winery", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node_end";
    s.target2 = "ambushend_point";
    fe [[ f ]]( s, "ESCORT_DAWG_WINERY", cf, ( 19101.4, 44883.6, 820.5 ), ( 0, 280.3, 0 ), "cspf_4_auto11156031664289587569", undefined, "ESCORT_DAWG_WINERY_ENDPOINT", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_dawg_escort_cs";
    s.name = "ambush1_point";
    fe [[ f ]]( s, "ESCORT_DAWG_WINERY", cf, ( 17703.8, 50633, 808.02 ), ( 0, 0, 0 ), "ambush1_point", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 300 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_dawg_escort_cs";
    s.name = "ambush1_point";
    fe [[ f ]]( s, "ESCORT_DAWG_WINERY", cf, ( 19024.8, 50451.9, 816.99 ), ( 0, 270, 0 ), "ambush1_point", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 300 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_dawg_escort_cs";
    s.name = "ambush1_point";
    fe [[ f ]]( s, "ESCORT_DAWG_WINERY", cf, ( 18395.4, 50279.1, 825.8 ), ( 0, 0, 0 ), "ambush1_point", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 300 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_dawg_escort_cs";
    s.name = "ambush2_point";
    fe [[ f ]]( s, "ESCORT_DAWG_WINERY", cf, ( 17468.6, 47818.3, 824 ), ( 0, 0, 0 ), "ambush2_point", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 300 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_dawg_escort_cs";
    s.name = "ambush2_point";
    fe [[ f ]]( s, "ESCORT_DAWG_WINERY", cf, ( 18868.1, 47550.4, 816 ), ( 0, 0, 0 ), "ambush2_point", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 300 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_dawg_escort_cs";
    s.name = "ambush2_point";
    fe [[ f ]]( s, "ESCORT_DAWG_WINERY", cf, ( 18926.9, 48186.2, 816 ), ( 0, 0, 0 ), "ambush2_point", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 300 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_dawg_escort_cs";
    s.name = "ambush3_point";
    fe [[ f ]]( s, "ESCORT_DAWG_WINERY", cf, ( 19350.2, 45559.1, 820.5 ), ( 0, 0, 0 ), "ambush3_point", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 300 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_dawg_escort_cs";
    s.name = "ambush3_point";
    fe [[ f ]]( s, "ESCORT_DAWG_WINERY", cf, ( 18615.2, 45441.1, 820.5 ), ( 0, 0, 0 ), "ambush3_point", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 300 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_dawg_escort_cs";
    s.name = "ambush3_point";
    fe [[ f ]]( s, "ESCORT_DAWG_WINERY", cf, ( 18046.1, 46357.9, 814.24 ), ( 0, 0, 0 ), "ambush3_point", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 300 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node";
    fe [[ f ]]( s, "ESCORT_DAWG_WINERY", cf, ( 17895.9, 51023.1, 888 ), ( 0, 0, 0 ), "cspf_4_auto16945942842540786971", "cspf_4_auto12026477965097220007", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node";
    fe [[ f ]]( s, "ESCORT_DAWG_WINERY", cf, ( 18410.5, 47823, 816 ), ( 0, 0, 0 ), "cspf_4_auto9312016267918506334", "cspf_4_auto2973328367453607495", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node";
    fe [[ f ]]( s, "ESCORT_DAWG_WINERY", cf, ( 18896.5, 46089.7, 824.25 ), ( 0, 0, 0 ), "cspf_4_auto13677630410256605362", "cspf_4_auto593872273934552400", "attack", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node";
    fe [[ f ]]( s, "ESCORT_DAWG_WINERY", cf, ( 18800.3, 45569.2, 820.5 ), ( 0, 0, 0 ), "cspf_4_auto593872273934552400", "cspf_4_auto10606635314809095629", "attack", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node";
    fe [[ f ]]( s, "ESCORT_DAWG_WINERY", cf, ( 18635.7, 47630.6, 816 ), ( 0, 0, 0 ), "cspf_4_auto2973328367453607495", "cspf_4_auto3188208149445745104", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node";
    fe [[ f ]]( s, "ESCORT_DAWG_WINERY", cf, ( 18825, 45139.1, 820.5 ), ( 0, 267.8, 0 ), "cspf_4_auto10606635314809095629", "cspf_4_auto11156031664289587569", "attack", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_dawg_escort_cs";
    s.name = "ambushend_point";
    fe [[ f ]]( s, "ESCORT_DAWG_WINERY", cf, ( 17848.8, 45249.4, 824 ), ( 0, 0, 0 ), "ambushend_point", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 300 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_dawg_escort_cs";
    s.name = "ambushend_point";
    fe [[ f ]]( s, "ESCORT_DAWG_WINERY", cf, ( 19786.3, 46521.9, 888 ), ( 0, 0, 0 ), "ambushend_point", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 300 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_dawg_escort_cs";
    s.name = "ambushend_point";
    fe [[ f ]]( s, "ESCORT_DAWG_WINERY", cf, ( 18835.6, 46359.8, 824 ), ( 0, 0, 0 ), "ambushend_point", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 300 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node";
    fe [[ f ]]( s, "ESCORT_DAWG_WINERY", cf, ( 17268.6, 48294.8, 818.55 ), ( 0, 0, 0 ), "cspf_4_auto6254498937379152790", "cspf_4_auto7440354479704131576", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node";
    fe [[ f ]]( s, "ESCORT_DAWG_WINERY", cf, ( 17758.9, 48027.2, 824 ), ( 0, 0, 0 ), "cspf_4_auto7440354479704131576", "cspf_4_auto2936731062823066777", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node";
    fe [[ f ]]( s, "ESCORT_DAWG_WINERY", cf, ( 17874.2, 47892.4, 824 ), ( 0, 0, 0 ), "cspf_4_auto2936731062823066777", "cspf_4_auto7506293857130010347", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_sat_avalon_q2_ob_contract_dawg_escort_cs
// Params 0
// Checksum 0x4b3d5b51, Offset: 0x3bca
// Size: 0x1b7
function function_d9dd7965c51c95d1()
{
    activityinstances = [];
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_ob_activitydefinition_dawg_escort";
    var_881289d7987bc770.cf = "mp_sat_avalon_q2_ob_contract_dawg_escort_cs";
    var_881289d7987bc770.scriptstructorigin = ( 39435.4, 11935.2, 1034.14 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [ ( 39938, 9270.59, 859.55 ) ];
    var_881289d7987bc770.var_31ce4477e3543d24 = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.locationradius = [ 3500 ];
    activityinstances[ "ESCORT_DAWG_CLIFFTOWN" ] = var_881289d7987bc770;
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_ob_activitydefinition_dawg_escort";
    var_881289d7987bc770.cf = "mp_sat_avalon_q2_ob_contract_dawg_escort_cs";
    var_881289d7987bc770.scriptstructorigin = ( 18797, 52742.8, 888 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [ ( 18757.2, 48695.1, 819.01 ) ];
    var_881289d7987bc770.var_31ce4477e3543d24 = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.locationradius = [ 4500 ];
    activityinstances[ "ESCORT_DAWG_WINERY" ] = var_881289d7987bc770;
    return activityinstances;
}

