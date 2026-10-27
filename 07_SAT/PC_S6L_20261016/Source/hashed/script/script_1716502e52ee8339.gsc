// script_1716502e52ee8339  (hash_1716502e52ee8339.gscc) (size: 18533 Bytes / 0x4865 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xd92ec77b (3643721595)
// size ...... 18533 (0x4865)
// includes .. 4   (offset: 0x3e15)
// strings ... 76  (offset: 0x3e35)
// dev strs .. 0   (offset: 0x4865)
// exports ... 14  (offset: 0x38e9)
// cseg ...... 0x8b5 + 0x3034 (0x38e9)
// imports ... 27  (offset: 0x3b19)
// animtree1 . 0   (offset: 0x4865)
// animtree2 . 0   (offset: 0x4865)
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace mp_sat_avalon_q4_ob_contract_dawg_escort_cs;

// Namespace mp_sat_avalon_q4_ob_contract_dawg_escort_cs
// Params 0, eflags: 0x5
// Checksum 0x462e468c, Offset: 0x8d3
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"mp_sat_avalon_q4_ob_contract_dawg_escort_cs", #"activity_common", &function_b39ecd3d51489472, undefined );
}

// Namespace mp_sat_avalon_q4_ob_contract_dawg_escort_cs
// Params 0, eflags: 0x4
// Checksum 0x914b14e3, Offset: 0x8fc
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace mp_sat_avalon_q4_ob_contract_dawg_escort_cs
// Params 0, eflags: 0x4
// Checksum 0x1470c70f, Offset: 0x90d
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace mp_sat_avalon_q4_ob_contract_dawg_escort_cs
// Params 2
// Checksum 0xe48894b8, Offset: 0x91e
// Size: 0x8c
function main( unused, unused2 )
{
    if ( utility::flag_exist( "mp_sat_avalon_q4_ob_contract_dawg_escort_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "mp_sat_avalon_q4_ob_contract_dawg_escort_cs" ) )
    {
        return;
    }
    
    activity_common::function_e1df676808c1d1e3( &function_4cd78e661617f3 );
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "mp_sat_avalon_q4_ob_contract_dawg_escort_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "mp_sat_avalon_q4_ob_contract_dawg_escort_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace mp_sat_avalon_q4_ob_contract_dawg_escort_cs
// Params 3, eflags: 0x4
// Checksum 0x97f273c0, Offset: 0x9b2
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "mp_sat_avalon_q4_ob_contract_dawg_escort_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "mp_sat_avalon_q4_ob_contract_dawg_escort_cs" );
}

// Namespace mp_sat_avalon_q4_ob_contract_dawg_escort_cs
// Params 3, eflags: 0x4
// Checksum 0x41a07a94, Offset: 0xa2c
// Size: 0x9b3
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_dawg_escort_cs";
    s.activity_bundle = "sat_ob_activitydefinition_dawg_escort";
    s.name = "ESCORT_DAWG_CAR_FACTORY";
    fe [[ f ]]( s, "ESCORT_DAWG_CAR_FACTORY", cf, ( 47184.9, -36497.3, 1988.83 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_dawg_escort_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "dawg_escort";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "ESCORT_DAWG_CAR_FACTORY", cf, ( 48257.7, -36376.3, 1988.87 ), ( 0, 312, 0 ), undefined, undefined, "dawg_escort_car_factory", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_dawg_escort_cs";
    fe [[ f ]]( s, "ESCORT_DAWG_CAR_FACTORY", cf, ( 43214.3, -39684.3, 1459.98 ), ( 0, 23, 0 ), "activity_nexus_instance_joiner", "ESCORT_DAWG_CAR_FACTORY", "ESCORT_DAWG_CAR_FACTORY", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_dawg_escort_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "dawg_escort";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "ESCORT_DAWG_CAR_FACTORY", cf, ( 47954.9, -36474.2, 1995 ), ( 0, 222, 0 ), undefined, undefined, "dawg_escort_car_factory", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_dawg_escort_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "dawg_escort";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "ESCORT_DAWG_CAR_FACTORY", cf, ( 47922, -35952.4, 1988.82 ), ( 0, 132, 0 ), undefined, undefined, "dawg_escort_car_factory", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_dawg_escort_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "dawg_escort";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "ESCORT_DAWG_CAR_FACTORY", cf, ( 48033.6, -36267.8, 1988.83 ), ( 0, 42, 0 ), undefined, undefined, "dawg_escort_car_factory", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_dawg_escort_cs";
    fe [[ f ]]( s, "ESCORT_DAWG_CAR_FACTORY", cf, ( 48075, -36310.9, 1995 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Awareness_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 1500 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_dawg_escort_cs";
    s.activity_bundle = "sat_ob_activitydefinition_dawg_escort";
    s.name = "ESCORT_DAWG_HELIPORT";
    fe [[ f ]]( s, "ESCORT_DAWG_HELIPORT", cf, ( 27409, -24514.1, 240.5 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 350 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_dawg_escort_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "dawg_escort";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "ESCORT_DAWG_HELIPORT", cf, ( 27132.9, -24667, 240.5 ), ( 0, 195.6, 0 ), undefined, undefined, "dawg_escort_heliport", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_dawg_escort_cs";
    fe [[ f ]]( s, "ESCORT_DAWG_HELIPORT", cf, ( 23663.6, -25113.5, 439.67 ), ( 0, 10.3, 0 ), "activity_nexus_instance_joiner", "ESCORT_DAWG_HELIPORT", "ESCORT_DAWG_HELIPORT", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_dawg_escort_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "dawg_escort";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "ESCORT_DAWG_HELIPORT", cf, ( 27413.3, -24747.4, 240.5 ), ( 0, 329.5, 0 ), undefined, undefined, "dawg_escort_heliport", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_dawg_escort_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "dawg_escort";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "ESCORT_DAWG_HELIPORT", cf, ( 27198.1, -24295.7, 240.5 ), ( 0, 330.3, 0 ), undefined, undefined, "dawg_escort_heliport", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_dawg_escort_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "dawg_escort";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "ESCORT_DAWG_HELIPORT", cf, ( 27608, -24275.4, 240.5 ), ( 0, 52.9, 0 ), undefined, undefined, "dawg_escort_heliport", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_dawg_escort_cs";
    fe [[ f ]]( s, "ESCORT_DAWG_HELIPORT", cf, ( 27150.4, -24584.4, 240.5 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Awareness_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 1500 );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace mp_sat_avalon_q4_ob_contract_dawg_escort_cs
// Params 0, eflags: 0x4
// Checksum 0xf30c20f5, Offset: 0x13e7
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace mp_sat_avalon_q4_ob_contract_dawg_escort_cs
// Params 0
// Checksum 0x55a1ae8d, Offset: 0x13f1
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "mp_sat_avalon_q4_ob_contract_dawg_escort_cs" );
}

// Namespace mp_sat_avalon_q4_ob_contract_dawg_escort_cs
// Params 0
// Checksum 0x474e879a, Offset: 0x1407
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

// Namespace mp_sat_avalon_q4_ob_contract_dawg_escort_cs
// Params 4
// Checksum 0x2e1137e, Offset: 0x1476
// Size: 0x71
function function_d4323822d7042e5a( var_4312b79c960726b6, fe, us, cf = "mp_sat_avalon_q4_ob_contract_dawg_escort_cs" )
{
    switch ( var_4312b79c960726b6 )
    {
        case #"hash_4f7fc0d5f830c6b3":
            function_db8e0aed37c618db( fe, us, cf );
            break;
        case #"hash_44f97baac2d985af":
            function_c466db0c41224fd7( fe, us, cf );
            break;
    }
}

// Namespace mp_sat_avalon_q4_ob_contract_dawg_escort_cs
// Params 3
// Checksum 0xa59ccb0a, Offset: 0x14ef
// Size: 0x1094
function function_db8e0aed37c618db( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node";
    fe [[ f ]]( s, "ESCORT_DAWG_CAR_FACTORY", cf, ( 49259.8, -36087, 1933.77 ), ( 0, 0, 0 ), "cspf_3_auto6003449379766086771", "cspf_3_auto15747674001173024670", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node";
    fe [[ f ]]( s, "ESCORT_DAWG_CAR_FACTORY", cf, ( 50365.2, -37170, 1989.83 ), ( 0, 0, 0 ), "cspf_3_auto10688394956594171936", "cspf_3_auto5348514299692589813", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "start_path";
    fe [[ f ]]( s, "ESCORT_DAWG_CAR_FACTORY", cf, ( 48075, -36310.9, 1995 ), ( 0, 45, 0 ), "ESCORT_DAWG_CAR_FACTORY_PATH_START", "cspf_3_auto15580734621475046237", "path_start_node", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_dawg_escort_cs";
    fe [[ f ]]( s, "ESCORT_DAWG_CAR_FACTORY", cf, ( 53647.1, -40371.3, 2069.24 ), ( 0, 0, 0 ), "ESCORT_DAWG_CAR_FACTORY_REWARD", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node";
    fe [[ f ]]( s, "ESCORT_DAWG_CAR_FACTORY", cf, ( 48339.9, -36059.3, 1988.83 ), ( 0, 0, 0 ), "cspf_3_auto15580734621475046237", "cspf_3_auto16209657584490013156", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_dawg_escort_cs";
    s.name = "ambushend_point";
    fe [[ f ]]( s, "ESCORT_DAWG_CAR_FACTORY", cf, ( 54594.3, -41249.3, 2056 ), ( 0, 0, 0 ), "ambushend_point", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 300 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node";
    fe [[ f ]]( s, "ESCORT_DAWG_CAR_FACTORY", cf, ( 48716.2, -36117.4, 1988.82 ), ( 0, 0, 0 ), "cspf_3_auto16209657584490013156", "cspf_3_auto6003449379766086771", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_dawg_escort_cs";
    s.name = "ambushend_point";
    fe [[ f ]]( s, "ESCORT_DAWG_CAR_FACTORY", cf, ( 53427.4, -39116.1, 2112.29 ), ( 0, 0, 0 ), "ambushend_point", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 300 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node_ambush";
    s.target2 = "ambush1_point";
    fe [[ f ]]( s, "ESCORT_DAWG_CAR_FACTORY", cf, ( 49977.1, -36811.9, 1965.43 ), ( 0, 0, 0 ), "cspf_3_auto15747674001173024670", "cspf_3_auto10688394956594171936", "ambush", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node";
    fe [[ f ]]( s, "ESCORT_DAWG_CAR_FACTORY", cf, ( 50658.1, -37179.6, 1989.83 ), ( 0, 0, 0 ), "cspf_3_auto5348514299692589813", "cspf_3_auto16945942842540786971", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node_ambush";
    s.target2 = "ambush2_point";
    fe [[ f ]]( s, "ESCORT_DAWG_CAR_FACTORY", cf, ( 51769.9, -37130, 1990.33 ), ( 0, 0, 0 ), "cspf_3_auto7401685673565424057", "cspf_3_auto9312016267918506334", "ambush", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node";
    fe [[ f ]]( s, "ESCORT_DAWG_CAR_FACTORY", cf, ( 51964.2, -37383.4, 1990.02 ), ( 0, 0, 0 ), "cspf_3_auto9312016267918506334", "cspf_3_auto16257117452669729480", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node";
    fe [[ f ]]( s, "ESCORT_DAWG_CAR_FACTORY", cf, ( 51939.4, -37995.1, 1989.76 ), ( 0, 0, 0 ), "cspf_3_auto16257117452669729480", "cspf_3_auto7506293857130010347", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node_ambush";
    s.target2 = "ambush3_point";
    fe [[ f ]]( s, "ESCORT_DAWG_CAR_FACTORY", cf, ( 52155.9, -39126.2, 2148.21 ), ( 0, 0, 0 ), "cspf_3_auto15630897851852100380", "cspf_3_auto1868615636547401434", "ambush", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node";
    fe [[ f ]]( s, "ESCORT_DAWG_CAR_FACTORY", cf, ( 51797, -39639.5, 2147.83 ), ( 0, 0, 0 ), "cspf_3_auto1868615636547401434", "cspf_3_auto13631424358659564518", "attack", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_dawg_escort_cs";
    fe [[ f ]]( s, "ESCORT_DAWG_CAR_FACTORY", cf, ( 47094.3, -36487, 1988.82 ), ( 0, 0, 0 ), "ESCORT_DAWG_CAR_FACTORY", undefined, "dawg_escort_car_factory", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node_end";
    s.target2 = "ambushend_point";
    fe [[ f ]]( s, "ESCORT_DAWG_CAR_FACTORY", cf, ( 53537.6, -40364.1, 2080.57 ), ( 0, 298.42, 0 ), "cspf_3_auto3433752182511304780", undefined, "ESCORT_DAWG_CAR_FACTORY_ENDPOINT", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_dawg_escort_cs";
    s.name = "ambush1_point";
    fe [[ f ]]( s, "ESCORT_DAWG_CAR_FACTORY", cf, ( 50301, -37789.8, 1987.97 ), ( 0, 0, 0 ), "ambush1_point", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 300 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_dawg_escort_cs";
    s.name = "ambush1_point";
    fe [[ f ]]( s, "ESCORT_DAWG_CAR_FACTORY", cf, ( 50777, -37069.3, 1988.08 ), ( 0, 270, 0 ), "ambush1_point", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 300 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_dawg_escort_cs";
    s.name = "ambush1_point";
    fe [[ f ]]( s, "ESCORT_DAWG_CAR_FACTORY", cf, ( 49913.6, -37498.3, 1991 ), ( 0, 0, 0 ), "ambush1_point", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 300 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_dawg_escort_cs";
    s.name = "ambush2_point";
    fe [[ f ]]( s, "ESCORT_DAWG_CAR_FACTORY", cf, ( 52181.1, -38241.1, 2024.03 ), ( 0, 0, 0 ), "ambush2_point", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 300 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_dawg_escort_cs";
    s.name = "ambush2_point";
    fe [[ f ]]( s, "ESCORT_DAWG_CAR_FACTORY", cf, ( 51201.5, -37736.2, 1991 ), ( 0, 0, 0 ), "ambush2_point", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 300 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_dawg_escort_cs";
    s.name = "ambush2_point";
    fe [[ f ]]( s, "ESCORT_DAWG_CAR_FACTORY", cf, ( 51671, -37979.5, 1989.86 ), ( 0, 0, 0 ), "ambush2_point", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 300 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_dawg_escort_cs";
    s.name = "ambush3_point";
    fe [[ f ]]( s, "ESCORT_DAWG_CAR_FACTORY", cf, ( 52426.8, -39710.1, 2150.5 ), ( 0, 0, 0 ), "ambush3_point", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 300 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_dawg_escort_cs";
    s.name = "ambush3_point";
    fe [[ f ]]( s, "ESCORT_DAWG_CAR_FACTORY", cf, ( 52247.2, -40130.5, 2152 ), ( 0, 0, 0 ), "ambush3_point", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 300 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_dawg_escort_cs";
    s.name = "ambush3_point";
    fe [[ f ]]( s, "ESCORT_DAWG_CAR_FACTORY", cf, ( 51399.1, -39126.9, 2151 ), ( 0, 0, 0 ), "ambush3_point", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 300 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node";
    fe [[ f ]]( s, "ESCORT_DAWG_CAR_FACTORY", cf, ( 51051.9, -36806.7, 1987.97 ), ( 0, 0, 0 ), "cspf_3_auto16945942842540786971", "cspf_3_auto3694911459347536485", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node";
    fe [[ f ]]( s, "ESCORT_DAWG_CAR_FACTORY", cf, ( 51400.7, -36776.6, 1989.85 ), ( 0, 0, 0 ), "cspf_3_auto3694911459347536485", "cspf_3_auto7401685673565424057", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node";
    fe [[ f ]]( s, "ESCORT_DAWG_CAR_FACTORY", cf, ( 52553.1, -38659.2, 2144.77 ), ( 0, 0, 0 ), "cspf_3_auto7506293857130010347", "cspf_3_auto14275695806036283456", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node";
    fe [[ f ]]( s, "ESCORT_DAWG_CAR_FACTORY", cf, ( 52489.6, -38767.6, 2145.86 ), ( 0, 0, 0 ), "cspf_3_auto14275695806036283456", "cspf_3_auto15630897851852100380", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node";
    fe [[ f ]]( s, "ESCORT_DAWG_CAR_FACTORY", cf, ( 52404, -40293.4, 2147.69 ), ( 0, 0, 0 ), "cspf_3_auto13631424358659564518", "cspf_3_auto3654473408460131489", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node";
    fe [[ f ]]( s, "ESCORT_DAWG_CAR_FACTORY", cf, ( 52955, -40649.6, 2133.47 ), ( 0, 0, 0 ), "cspf_3_auto3654473408460131489", "cspf_3_auto3433752182511304780", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_dawg_escort_cs";
    s.name = "ambushend_point";
    fe [[ f ]]( s, "ESCORT_DAWG_CAR_FACTORY", cf, ( 54566.3, -40117.4, 2053.72 ), ( 0, 0, 0 ), "ambushend_point", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 300 );
}

// Namespace mp_sat_avalon_q4_ob_contract_dawg_escort_cs
// Params 3
// Checksum 0xc2bf13aa, Offset: 0x258b
// Size: 0x119e
function function_c466db0c41224fd7( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node";
    fe [[ f ]]( s, "ESCORT_DAWG_HELIPORT", cf, ( 29124.4, -24540, 240.02 ), ( 0, 0, 0 ), "cspf_4_auto6233931169114354498", "cspf_4_auto13363526720033884858", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node";
    fe [[ f ]]( s, "ESCORT_DAWG_HELIPORT", cf, ( 28516.6, -24131.1, 239.17 ), ( 0, 0, 0 ), "cspf_4_auto6003449379766086771", "cspf_4_auto6233931169114354498", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node";
    fe [[ f ]]( s, "ESCORT_DAWG_HELIPORT", cf, ( 29539.2, -24364.3, 239.89 ), ( 0, 0, 0 ), "cspf_4_auto13363526720033884858", "cspf_4_auto15747674001173024670", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node";
    fe [[ f ]]( s, "ESCORT_DAWG_HELIPORT", cf, ( 30760.6, -22551.2, 239.9 ), ( 0, 0, 0 ), "cspf_4_auto10688394956594171936", "cspf_4_auto5348514299692589813", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "start_path";
    fe [[ f ]]( s, "ESCORT_DAWG_HELIPORT", cf, ( 27150.4, -24584.4, 240.5 ), ( 0, 55, 0 ), "ESCORT_DAWG_HELIPORT_PATH_START", "cspf_4_auto15580734621475046237", "path_start_node", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_dawg_escort_cs";
    fe [[ f ]]( s, "ESCORT_DAWG_HELIPORT", cf, ( 33805.6, -18573.5, 288 ), ( 0, 0, 0 ), "ESCORT_DAWG_HELIPORT_REWARD", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node";
    fe [[ f ]]( s, "ESCORT_DAWG_HELIPORT", cf, ( 27405, -24222.3, 240.5 ), ( 0, 0, 0 ), "cspf_4_auto15580734621475046237", "cspf_4_auto16209657584490013156", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node";
    fe [[ f ]]( s, "ESCORT_DAWG_HELIPORT", cf, ( 27712, -24125.3, 240.5 ), ( 0, 0, 0 ), "cspf_4_auto16209657584490013156", "cspf_4_auto6003449379766086771", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node_ambush";
    s.target2 = "ambush1_point";
    fe [[ f ]]( s, "ESCORT_DAWG_HELIPORT", cf, ( 30281.6, -23292.4, 239.94 ), ( 0, 0, 0 ), "cspf_4_auto15747674001173024670", "cspf_4_auto10688394956594171936", "ambush", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node";
    fe [[ f ]]( s, "ESCORT_DAWG_HELIPORT", cf, ( 30718.3, -22039.9, 239.95 ), ( 0, 0, 0 ), "cspf_4_auto5348514299692589813", "cspf_4_auto16945942842540786971", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node_ambush";
    s.target2 = "ambush2_point";
    fe [[ f ]]( s, "ESCORT_DAWG_HELIPORT", cf, ( 30271, -20158.9, 240 ), ( 0, 0, 0 ), "cspf_4_auto7401685673565424057", "cspf_4_auto9312016267918506334", "ambush", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node";
    fe [[ f ]]( s, "ESCORT_DAWG_HELIPORT", cf, ( 30408.9, -19966.1, 240 ), ( 0, 0, 0 ), "cspf_4_auto9312016267918506334", "cspf_4_auto16257117452669729480", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node";
    fe [[ f ]]( s, "ESCORT_DAWG_HELIPORT", cf, ( 30735.2, -19968.7, 240 ), ( 0, 0, 0 ), "cspf_4_auto16257117452669729480", "cspf_4_auto7506293857130010347", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node_ambush";
    s.target2 = "ambush3_point";
    fe [[ f ]]( s, "ESCORT_DAWG_HELIPORT", cf, ( 31890, -20031.7, 240.01 ), ( 0, 0, 0 ), "cspf_4_auto15630897851852100380", "cspf_4_auto1868615636547401434", "ambush", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node";
    fe [[ f ]]( s, "ESCORT_DAWG_HELIPORT", cf, ( 32788.8, -18815, 240 ), ( 0, 0, 0 ), "cspf_4_auto1868615636547401434", "cspf_4_auto13631424358659564518", "attack", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_dawg_escort_cs";
    fe [[ f ]]( s, "ESCORT_DAWG_HELIPORT", cf, ( 27422.5, -24461.7, 240.5 ), ( 0, 0, 0 ), "ESCORT_DAWG_HELIPORT", undefined, "dawg_escort_heliport", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node_end";
    s.target2 = "ambushend_point";
    fe [[ f ]]( s, "ESCORT_DAWG_HELIPORT", cf, ( 33640.5, -18483.5, 288 ), ( 0, 298.42, 0 ), "cspf_4_auto3433752182511304780", undefined, "ESCORT_DAWG_HELIPORT_ENDPOINT", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_dawg_escort_cs";
    s.name = "ambush1_point";
    fe [[ f ]]( s, "ESCORT_DAWG_HELIPORT", cf, ( 30023.6, -22481, 240.5 ), ( 0, 0, 0 ), "ambush1_point", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 300 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_dawg_escort_cs";
    s.name = "ambush1_point";
    fe [[ f ]]( s, "ESCORT_DAWG_HELIPORT", cf, ( 30572.6, -21875, 239.98 ), ( 0, 270, 0 ), "ambush1_point", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 300 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_dawg_escort_cs";
    s.name = "ambush1_point";
    fe [[ f ]]( s, "ESCORT_DAWG_HELIPORT", cf, ( 31570.5, -22574.5, 240 ), ( 0, 0, 0 ), "ambush1_point", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 300 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_dawg_escort_cs";
    s.name = "ambush2_point";
    fe [[ f ]]( s, "ESCORT_DAWG_HELIPORT", cf, ( 29960.3, -19074.4, 272 ), ( 0, 0, 0 ), "ambush2_point", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 300 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_dawg_escort_cs";
    s.name = "ambush2_point";
    fe [[ f ]]( s, "ESCORT_DAWG_HELIPORT", cf, ( 31336.4, -19710.3, 240 ), ( 0, 0, 0 ), "ambush2_point", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 300 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_dawg_escort_cs";
    s.name = "ambush2_point";
    fe [[ f ]]( s, "ESCORT_DAWG_HELIPORT", cf, ( 31666.8, -19304.1, 240 ), ( 0, 0, 0 ), "ambush2_point", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 300 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_dawg_escort_cs";
    s.name = "ambush3_point";
    fe [[ f ]]( s, "ESCORT_DAWG_HELIPORT", cf, ( 32684.2, -19837.1, 240.5 ), ( 0, 0, 0 ), "ambush3_point", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 300 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_dawg_escort_cs";
    s.name = "ambush3_point";
    fe [[ f ]]( s, "ESCORT_DAWG_HELIPORT", cf, ( 32057.9, -20765.6, 240 ), ( 0, 0, 0 ), "ambush3_point", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 300 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_dawg_escort_cs";
    s.name = "ambush3_point";
    fe [[ f ]]( s, "ESCORT_DAWG_HELIPORT", cf, ( 31643.3, -19317.6, 240 ), ( 0, 0, 0 ), "ambush3_point", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 300 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node";
    fe [[ f ]]( s, "ESCORT_DAWG_HELIPORT", cf, ( 29671.9, -21291.5, 240 ), ( 0, 0, 0 ), "cspf_4_auto16945942842540786971", "cspf_4_auto3694911459347536485", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node";
    fe [[ f ]]( s, "ESCORT_DAWG_HELIPORT", cf, ( 29729.1, -20938.6, 240 ), ( 0, 0, 0 ), "cspf_4_auto3694911459347536485", "cspf_4_auto7401685673565424057", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node";
    fe [[ f ]]( s, "ESCORT_DAWG_HELIPORT", cf, ( 31402, -20393.2, 240 ), ( 0, 0, 0 ), "cspf_4_auto7506293857130010347", "cspf_4_auto14275695806036283456", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node";
    fe [[ f ]]( s, "ESCORT_DAWG_HELIPORT", cf, ( 31653.3, -20275.4, 240.46 ), ( 0, 0, 0 ), "cspf_4_auto14275695806036283456", "cspf_4_auto15630897851852100380", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node";
    fe [[ f ]]( s, "ESCORT_DAWG_HELIPORT", cf, ( 33136.3, -18638.2, 240 ), ( 0, 0, 0 ), "cspf_4_auto13631424358659564518", "cspf_4_auto3654473408460131489", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node";
    fe [[ f ]]( s, "ESCORT_DAWG_HELIPORT", cf, ( 33450.8, -18805.4, 291 ), ( 0, 0, 0 ), "cspf_4_auto3654473408460131489", "cspf_4_auto3433752182511304780", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_dawg_escort_cs";
    s.name = "ambushend_point";
    fe [[ f ]]( s, "ESCORT_DAWG_HELIPORT", cf, ( 33207.8, -19818.4, 240 ), ( 0, 0, 0 ), "ambushend_point", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 300 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_dawg_escort_cs";
    s.name = "ambushend_point";
    fe [[ f ]]( s, "ESCORT_DAWG_HELIPORT", cf, ( 31685.5, -18478.7, 240 ), ( 0, 0, 0 ), "ambushend_point", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 300 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_contract_dawg_escort_cs";
    s.name = "ambushend_point";
    fe [[ f ]]( s, "ESCORT_DAWG_HELIPORT", cf, ( 32116.4, -19132.8, 240.03 ), ( 0, 0, 0 ), "ambushend_point", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 300 );
}

// Namespace mp_sat_avalon_q4_ob_contract_dawg_escort_cs
// Params 0
// Checksum 0xae421eae, Offset: 0x3731
// Size: 0x1b7
function function_d9dd7965c51c95d1()
{
    activityinstances = [];
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_ob_activitydefinition_dawg_escort";
    var_881289d7987bc770.cf = "mp_sat_avalon_q4_ob_contract_dawg_escort_cs";
    var_881289d7987bc770.scriptstructorigin = ( 47184.9, -36497.3, 1988.83 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [ ( 50460.2, -38359, 1989.76 ) ];
    var_881289d7987bc770.var_31ce4477e3543d24 = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.locationradius = [ 4500 ];
    activityinstances[ "ESCORT_DAWG_CAR_FACTORY" ] = var_881289d7987bc770;
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_ob_activitydefinition_dawg_escort";
    var_881289d7987bc770.cf = "mp_sat_avalon_q4_ob_contract_dawg_escort_cs";
    var_881289d7987bc770.scriptstructorigin = ( 27409, -24514.1, 240.5 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [ ( 31185.6, -22467.3, 240 ) ];
    var_881289d7987bc770.var_31ce4477e3543d24 = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.locationradius = [ 1000 ];
    activityinstances[ "ESCORT_DAWG_HELIPORT" ] = var_881289d7987bc770;
    return activityinstances;
}

