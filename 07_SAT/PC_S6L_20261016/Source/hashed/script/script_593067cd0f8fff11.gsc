// script_593067cd0f8fff11  (hash_593067cd0f8fff11.gscc) (size: 27158 Bytes / 0x6a16 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x19ede21c (435020316)
// size ...... 27158 (0x6a16)
// includes .. 4   (offset: 0x5ab6)
// strings ... 104 (offset: 0x5ad6)
// dev strs .. 0   (offset: 0x6a16)
// exports ... 15  (offset: 0x5542)
// cseg ...... 0xc41 + 0x4901 (0x5542)
// imports ... 28  (offset: 0x579a)
// animtree1 . 0   (offset: 0x6a16)
// animtree2 . 0   (offset: 0x6a16)
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace mp_sat_avalon_q1_ob_contract_dawg_escort_cs;

// Namespace mp_sat_avalon_q1_ob_contract_dawg_escort_cs
// Params 0, eflags: 0x5
// Checksum 0x3504ac95, Offset: 0xc5f
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"mp_sat_avalon_q1_ob_contract_dawg_escort_cs", #"activity_common", &function_b39ecd3d51489472, undefined );
}

// Namespace mp_sat_avalon_q1_ob_contract_dawg_escort_cs
// Params 0, eflags: 0x4
// Checksum 0xef71c4e7, Offset: 0xc88
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace mp_sat_avalon_q1_ob_contract_dawg_escort_cs
// Params 0, eflags: 0x4
// Checksum 0x6a4a170b, Offset: 0xc99
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace mp_sat_avalon_q1_ob_contract_dawg_escort_cs
// Params 2
// Checksum 0x9dd04dd5, Offset: 0xcaa
// Size: 0x8c
function main( unused, unused2 )
{
    if ( utility::flag_exist( "mp_sat_avalon_q1_ob_contract_dawg_escort_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "mp_sat_avalon_q1_ob_contract_dawg_escort_cs" ) )
    {
        return;
    }
    
    activity_common::function_e1df676808c1d1e3( &function_4cd78e661617f3 );
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "mp_sat_avalon_q1_ob_contract_dawg_escort_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "mp_sat_avalon_q1_ob_contract_dawg_escort_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace mp_sat_avalon_q1_ob_contract_dawg_escort_cs
// Params 3, eflags: 0x4
// Checksum 0xe9c8a3c4, Offset: 0xd3e
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "mp_sat_avalon_q1_ob_contract_dawg_escort_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "mp_sat_avalon_q1_ob_contract_dawg_escort_cs" );
}

// Namespace mp_sat_avalon_q1_ob_contract_dawg_escort_cs
// Params 3, eflags: 0x4
// Checksum 0xbd9fe9f6, Offset: 0xdb8
// Size: 0xe62
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_dawg_escort_cs";
    s.activity_bundle = "sat_ob_activitydefinition_dawg_escort";
    s.name = "ESCORT_DAWG_CASINO";
    fe [[ f ]]( s, "ESCORT_DAWG_CASINO", cf, ( -11997.8, 29557.6, 768 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_dawg_escort_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "dawg_escort";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "ESCORT_DAWG_CASINO", cf, ( -11603.5, 29286.6, 768 ), ( 0, 42, 0 ), undefined, undefined, "dawg_escort_casino", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_dawg_escort_cs";
    fe [[ f ]]( s, "ESCORT_DAWG_CASINO", cf, ( -13665.2, 26810, 544 ), ( 0, 58.2, 0 ), "activity_nexus_instance_joiner", "ESCORT_DAWG_CASINO", "ESCORT_DAWG_CASINO", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_dawg_escort_cs";
    fe [[ f ]]( s, "ESCORT_DAWG_CASINO", cf, ( -11610.2, 29551.8, 768 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Awareness_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 1500 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_dawg_escort_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "dawg_escort";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "ESCORT_DAWG_CASINO", cf, ( -11664.1, 29613.3, 768 ), ( 0, 132, 0 ), undefined, undefined, "dawg_escort_casino", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_dawg_escort_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "dawg_escort";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "ESCORT_DAWG_CASINO", cf, ( -11858.6, 30064.1, 768 ), ( 0, 132, 0 ), undefined, undefined, "dawg_escort_casino", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_dawg_escort_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "dawg_escort";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "ESCORT_DAWG_CASINO", cf, ( -11151.5, 29345.2, 768 ), ( 0, 312, 0 ), undefined, undefined, "dawg_escort_casino", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_dawg_escort_cs";
    s.activity_bundle = "sat_ob_activitydefinition_dawg_escort";
    s.name = "ESCORT_DAWG_GLAMPING";
    fe [[ f ]]( s, "ESCORT_DAWG_GLAMPING", cf, ( -24234.6, 47128.1, 1555.25 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_dawg_escort_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "dawg_escort";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "ESCORT_DAWG_GLAMPING", cf, ( -24378.4, 46984.6, 1566.44 ), ( 0, 312, 0 ), undefined, undefined, "dawg_escort_glamping", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_dawg_escort_cs";
    fe [[ f ]]( s, "ESCORT_DAWG_GLAMPING", cf, ( -20638.8, 46474.8, 1155.06 ), ( 0, 173.2, 0 ), "activity_nexus_instance_joiner", "ESCORT_DAWG_GLAMPING", "ESCORT_DAWG_GLAMPING", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_dawg_escort_cs";
    fe [[ f ]]( s, "ESCORT_DAWG_GLAMPING", cf, ( -24439.2, 46917.9, 1565.75 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Awareness_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 1500 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_dawg_escort_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "dawg_escort";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "ESCORT_DAWG_GLAMPING", cf, ( -24524.6, 46885.3, 1579.01 ), ( 0, 229.7, 0 ), undefined, undefined, "dawg_escort_glamping", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_dawg_escort_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "dawg_escort";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "ESCORT_DAWG_GLAMPING", cf, ( -24461.3, 47195.9, 1583.51 ), ( 0, 132, 0 ), undefined, undefined, "dawg_escort_glamping", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_dawg_escort_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "dawg_escort";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "ESCORT_DAWG_GLAMPING", cf, ( -24730.3, 47001.2, 1601.04 ), ( 0, 158.8, 0 ), undefined, undefined, "dawg_escort_glamping", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_dawg_escort_cs";
    s.activity_bundle = "sat_ob_activitydefinition_dawg_escort";
    s.name = "ESCORT_DAWG_STADIUM";
    fe [[ f ]]( s, "ESCORT_DAWG_STADIUM", cf, ( -46698.2, 12055.1, 336 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_dawg_escort_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "dawg_escort";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "ESCORT_DAWG_STADIUM", cf, ( -46925.5, 12274.5, 263 ), ( 0, 226.4, 0 ), undefined, undefined, "dawg_escort_stadium", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_dawg_escort_cs";
    fe [[ f ]]( s, "ESCORT_DAWG_STADIUM", cf, ( -44871.1, 14858.7, 244.55 ), ( 0, 230.1, 0 ), "activity_nexus_instance_joiner", "ESCORT_DAWG_STADIUM", "ESCORT_DAWG_STADIUM", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_dawg_escort_cs";
    fe [[ f ]]( s, "ESCORT_DAWG_STADIUM", cf, ( -46549.9, 11872.4, 336 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Awareness_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 1500 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_dawg_escort_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "dawg_escort";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "ESCORT_DAWG_STADIUM", cf, ( -46543.1, 11688.9, 336 ), ( 0, 101.4, 0 ), undefined, undefined, "dawg_escort_stadium", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_dawg_escort_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "dawg_escort";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "ESCORT_DAWG_STADIUM", cf, ( -46284.3, 12195.1, 336 ), ( 0, 83.2, 0 ), undefined, undefined, "dawg_escort_stadium", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_dawg_escort_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "dawg_escort";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "ESCORT_DAWG_STADIUM", cf, ( -46776, 11895.4, 336 ), ( 0, 200.1, 0 ), undefined, undefined, "dawg_escort_stadium", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace mp_sat_avalon_q1_ob_contract_dawg_escort_cs
// Params 0, eflags: 0x4
// Checksum 0x8a54f998, Offset: 0x1c22
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace mp_sat_avalon_q1_ob_contract_dawg_escort_cs
// Params 0
// Checksum 0x2b9b7e89, Offset: 0x1c2c
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "mp_sat_avalon_q1_ob_contract_dawg_escort_cs" );
}

// Namespace mp_sat_avalon_q1_ob_contract_dawg_escort_cs
// Params 0
// Checksum 0x3974579e, Offset: 0x1c42
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

// Namespace mp_sat_avalon_q1_ob_contract_dawg_escort_cs
// Params 4
// Checksum 0x4990654f, Offset: 0x1cb1
// Size: 0x8b
function function_d4323822d7042e5a( var_4312b79c960726b6, fe, us, cf = "mp_sat_avalon_q1_ob_contract_dawg_escort_cs" )
{
    switch ( var_4312b79c960726b6 )
    {
        case #"hash_dc130b41a354fee3":
            function_a69d8c6e37ee5efb( fe, us, cf );
            break;
        case #"hash_b1aa1b87b8a33b91":
            function_21b62c6b54106f59( fe, us, cf );
            break;
        case #"hash_c7971ef88abf46b7":
            function_3fef4c4479811a8f( fe, us, cf );
            break;
    }
}

// Namespace mp_sat_avalon_q1_ob_contract_dawg_escort_cs
// Params 3
// Checksum 0x45a5f4d1, Offset: 0x1d44
// Size: 0x12a8
function function_a69d8c6e37ee5efb( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node";
    fe [[ f ]]( s, "ESCORT_DAWG_CASINO", cf, ( -10231.8, 27299.4, 768 ), ( 0, 0, 0 ), "cspf_4_auto13800611643972878409", "cspf_4_auto15747674001173024670", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node";
    fe [[ f ]]( s, "ESCORT_DAWG_CASINO", cf, ( -10433.2, 27628.3, 768 ), ( 0, 0, 0 ), "cspf_4_auto6003449379766086771", "cspf_4_auto13800611643972878409", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node";
    fe [[ f ]]( s, "ESCORT_DAWG_CASINO", cf, ( -10082.1, 27118.5, 768 ), ( 0, 0, 0 ), "cspf_4_auto10688394956594171936", "cspf_4_auto5348514299692589813", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "start_path";
    fe [[ f ]]( s, "ESCORT_DAWG_CASINO", cf, ( -11610.2, 29551.8, 768 ), ( 0, 310, 0 ), "ESCORT_DAWG_CASINO_PATH_START", "cspf_4_auto15580734621475046237", "path_start_node", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_dawg_escort_cs";
    fe [[ f ]]( s, "ESCORT_DAWG_CASINO", cf, ( -6145.22, 22321.7, 704 ), ( 0, 0, 0 ), "ESCORT_DAWG_CASINO_REWARD", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node";
    fe [[ f ]]( s, "ESCORT_DAWG_CASINO", cf, ( -11315.1, 29198.8, 768 ), ( 0, 0, 0 ), "cspf_4_auto15580734621475046237", "cspf_4_auto16209657584490013156", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node";
    fe [[ f ]]( s, "ESCORT_DAWG_CASINO", cf, ( -11368.7, 28802.8, 768 ), ( 0, 0, 0 ), "cspf_4_auto16209657584490013156", "cspf_4_auto6003449379766086771", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node_ambush";
    s.target2 = "ambush1_point";
    fe [[ f ]]( s, "ESCORT_DAWG_CASINO", cf, ( -10159.2, 27206.6, 802 ), ( 0, 0, 0 ), "cspf_4_auto15747674001173024670", "cspf_4_auto10688394956594171936", "ambush", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node";
    fe [[ f ]]( s, "ESCORT_DAWG_CASINO", cf, ( -9674.4, 26705, 768 ), ( 0, 0, 0 ), "cspf_4_auto5348514299692589813", "cspf_4_auto16945942842540786971", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node_ambush";
    s.target2 = "ambush2_point";
    fe [[ f ]]( s, "ESCORT_DAWG_CASINO", cf, ( -8874.96, 25954.8, 768 ), ( 0, 0, 0 ), "cspf_4_auto7506293857130010347", "cspf_4_auto9312016267918506334", "ambush", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node";
    fe [[ f ]]( s, "ESCORT_DAWG_CASINO", cf, ( -9040.43, 26144, 768 ), ( 0, 0, 0 ), "cspf_4_auto16257117452669729480", "cspf_4_auto7506293857130010347", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node_ambush";
    s.target2 = "ambush3_point";
    fe [[ f ]]( s, "ESCORT_DAWG_CASINO", cf, ( -7865.66, 24549.2, 768 ), ( 0, 0, 0 ), "cspf_4_auto15630897851852100380", "cspf_4_auto1868615636547401434", "ambush", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node";
    fe [[ f ]]( s, "ESCORT_DAWG_CASINO", cf, ( -7628.68, 24294.4, 768 ), ( 0, 0, 0 ), "cspf_4_auto1868615636547401434", "cspf_4_auto13631424358659564518", "attack", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_dawg_escort_cs";
    fe [[ f ]]( s, "ESCORT_DAWG_CASINO", cf, ( -12076.5, 29567.6, 768 ), ( 0, 0, 0 ), "ESCORT_DAWG_CASINO", undefined, "dawg_escort_casino", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node_end";
    s.target2 = "ambushend_point";
    fe [[ f ]]( s, "ESCORT_DAWG_CASINO", cf, ( -6062.84, 22426.5, 704 ), ( 0, 310, 0 ), "cspf_4_auto3433752182511304780", undefined, "ESCORT_DAWG_CASINO_ENDPOINT", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_dawg_escort_cs";
    s.name = "ambush1_point";
    fe [[ f ]]( s, "ESCORT_DAWG_CASINO", cf, ( -10774.4, 26531.1, 768 ), ( 0, 0, 0 ), "ambush1_point", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 300 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_dawg_escort_cs";
    s.name = "ambush1_point";
    fe [[ f ]]( s, "ESCORT_DAWG_CASINO", cf, ( -9356.89, 27900.2, 768 ), ( 0, 270, 0 ), "ambush1_point", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 300 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_dawg_escort_cs";
    s.name = "ambush1_point";
    fe [[ f ]]( s, "ESCORT_DAWG_CASINO", cf, ( -9577.2, 26609.7, 768 ), ( 0, 0, 0 ), "ambush1_point", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 300 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_dawg_escort_cs";
    s.name = "ambush2_point";
    fe [[ f ]]( s, "ESCORT_DAWG_CASINO", cf, ( -8230.93, 25003.8, 768 ), ( 0, 0, 0 ), "ambush2_point", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 300 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_dawg_escort_cs";
    s.name = "ambush2_point";
    fe [[ f ]]( s, "ESCORT_DAWG_CASINO", cf, ( -8053.29, 26148.9, 768 ), ( 0, 0, 0 ), "ambush2_point", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 300 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_dawg_escort_cs";
    s.name = "ambush2_point";
    fe [[ f ]]( s, "ESCORT_DAWG_CASINO", cf, ( -8510.29, 25319, 768 ), ( 0, 0, 0 ), "ambush2_point", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 300 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_dawg_escort_cs";
    s.name = "ambush3_point";
    fe [[ f ]]( s, "ESCORT_DAWG_CASINO", cf, ( -7076.93, 25081.4, 768 ), ( 0, 0, 0 ), "ambush3_point", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 300 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_dawg_escort_cs";
    s.name = "ambush3_point";
    fe [[ f ]]( s, "ESCORT_DAWG_CASINO", cf, ( -7501.44, 24129.7, 970 ), ( 0, 0, 0 ), "ambush3_point", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 300 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_dawg_escort_cs";
    s.name = "ambush3_point";
    fe [[ f ]]( s, "ESCORT_DAWG_CASINO", cf, ( -7386.85, 24011.5, 768 ), ( 0, 0, 0 ), "ambush3_point", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 300 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node";
    fe [[ f ]]( s, "ESCORT_DAWG_CASINO", cf, ( -9450.28, 26793.5, 768 ), ( 0, 0, 0 ), "cspf_4_auto16945942842540786971", "cspf_4_auto3694911459347536485", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node";
    fe [[ f ]]( s, "ESCORT_DAWG_CASINO", cf, ( -9126.97, 26648.8, 768 ), ( 0, 0, 0 ), "cspf_4_auto3694911459347536485", "cspf_4_auto16257117452669729480", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node";
    fe [[ f ]]( s, "ESCORT_DAWG_CASINO", cf, ( -8454.22, 25801.4, 768 ), ( 0, 0, 0 ), "cspf_4_auto9312016267918506334", "cspf_4_auto2973328367453607495", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node";
    fe [[ f ]]( s, "ESCORT_DAWG_CASINO", cf, ( -7446.37, 24081.2, 768 ), ( 0, 0, 0 ), "cspf_4_auto13631424358659564518", "cspf_4_auto3654473408460131489", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node";
    fe [[ f ]]( s, "ESCORT_DAWG_CASINO", cf, ( -6985.43, 23777.3, 760.01 ), ( 0, 0, 0 ), "cspf_4_auto3654473408460131489", "cspf_4_auto14499600148721125212", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node";
    fe [[ f ]]( s, "ESCORT_DAWG_CASINO", cf, ( -8408.52, 25568, 768 ), ( 0, 0, 0 ), "cspf_4_auto2973328367453607495", "cspf_4_auto3188208149445745104", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node";
    fe [[ f ]]( s, "ESCORT_DAWG_CASINO", cf, ( -6860.96, 23476.6, 768 ), ( 0, 0, 0 ), "cspf_4_auto14499600148721125212", "cspf_4_auto9264513666015430663", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node";
    fe [[ f ]]( s, "ESCORT_DAWG_CASINO", cf, ( -6235.05, 22838.3, 704 ), ( 0, 0, 0 ), "cspf_4_auto17349287045644331296", "cspf_4_auto3433752182511304780", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node";
    fe [[ f ]]( s, "ESCORT_DAWG_CASINO", cf, ( -6546.85, 23086.2, 704 ), ( 0, 0, 0 ), "cspf_4_auto9264513666015430663", "cspf_4_auto17349287045644331296", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node";
    fe [[ f ]]( s, "ESCORT_DAWG_CASINO", cf, ( -8400.47, 25208.5, 768 ), ( 0, 0, 0 ), "cspf_4_auto3188208149445745104", "cspf_4_auto15630897851852100380", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_dawg_escort_cs";
    s.name = "ambushend_point";
    fe [[ f ]]( s, "ESCORT_DAWG_CASINO", cf, ( -6548.67, 23806.6, 768 ), ( 0, 0, 0 ), "ambushend_point", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 300 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_dawg_escort_cs";
    s.name = "ambushend_point";
    fe [[ f ]]( s, "ESCORT_DAWG_CASINO", cf, ( -4885.3, 21034.8, 430 ), ( 0, 0, 0 ), "ambushend_point", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 300 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_dawg_escort_cs";
    s.name = "ambushend_point";
    fe [[ f ]]( s, "ESCORT_DAWG_CASINO", cf, ( -7309.62, 23168.8, 768 ), ( 0, 0, 0 ), "ambushend_point", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 300 );
}

// Namespace mp_sat_avalon_q1_ob_contract_dawg_escort_cs
// Params 3
// Checksum 0x7369543b, Offset: 0x2ff4
// Size: 0x1119
function function_21b62c6b54106f59( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node";
    fe [[ f ]]( s, "ESCORT_DAWG_GLAMPING", cf, ( -26318.7, 48966.6, 1700 ), ( 0, 0, 0 ), "cspf_5_auto8395365048207118860", "cspf_5_auto10688394956594171936", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node";
    fe [[ f ]]( s, "ESCORT_DAWG_GLAMPING", cf, ( -25711.4, 48480.3, 1686.68 ), ( 0, 0, 0 ), "cspf_5_auto6003449379766086771", "cspf_5_auto13800611643972878409", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node";
    fe [[ f ]]( s, "ESCORT_DAWG_GLAMPING", cf, ( -26983.5, 49146.9, 1687.64 ), ( 0, 0, 0 ), "cspf_5_auto10688394956594171936", "cspf_5_auto5348514299692589813", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "start_path";
    fe [[ f ]]( s, "ESCORT_DAWG_GLAMPING", cf, ( -24439.2, 46917.9, 1565.75 ), ( 0, 145, 0 ), "ESCORT_DAWG_GLAMPING_PATH_START", "cspf_5_auto15580734621475046237", "path_start_node", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_dawg_escort_cs";
    fe [[ f ]]( s, "ESCORT_DAWG_GLAMPING", cf, ( -25348.6, 55336.1, 2675.81 ), ( 0, 0, 0 ), "ESCORT_DAWG_GLAMPING_REWARD", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node";
    fe [[ f ]]( s, "ESCORT_DAWG_GLAMPING", cf, ( -24725.8, 47141.5, 1584.46 ), ( 0, 0, 0 ), "cspf_5_auto15580734621475046237", "cspf_5_auto16209657584490013156", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node";
    fe [[ f ]]( s, "ESCORT_DAWG_GLAMPING", cf, ( -25389.1, 47922.7, 1667.39 ), ( 0, 0, 0 ), "cspf_5_auto16209657584490013156", "cspf_5_auto6003449379766086771", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node_ambush";
    s.target2 = "ambush1_point";
    fe [[ f ]]( s, "ESCORT_DAWG_GLAMPING", cf, ( -25953.1, 49026, 1687.73 ), ( 0, 165.9, 0 ), "cspf_5_auto13800611643972878409", "cspf_5_auto8395365048207118860", "ambush", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node_ambush";
    s.target2 = "ambush2_point";
    fe [[ f ]]( s, "ESCORT_DAWG_GLAMPING", cf, ( -27355.7, 53095.1, 2355.62 ), ( 0, 86.7, 0 ), "cspf_5_auto7506293857130010347", "cspf_5_auto9312016267918506334", "ambush", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node";
    fe [[ f ]]( s, "ESCORT_DAWG_GLAMPING", cf, ( -27710.8, 52051.8, 2108.99 ), ( 0, 0, 0 ), "cspf_5_auto16257117452669729480", "cspf_5_auto7506293857130010347", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node_ambush";
    s.target2 = "ambush3_point";
    fe [[ f ]]( s, "ESCORT_DAWG_GLAMPING", cf, ( -27040.1, 55053.4, 2641.64 ), ( 0, 50.8, 0 ), "cspf_5_auto15630897851852100380", "cspf_5_auto1868615636547401434", "ambush", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node";
    fe [[ f ]]( s, "ESCORT_DAWG_GLAMPING", cf, ( -26776.9, 55350, 2653.92 ), ( 0, 0, 0 ), "cspf_5_auto1868615636547401434", "cspf_5_auto13631424358659564518", "attack", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_dawg_escort_cs";
    fe [[ f ]]( s, "ESCORT_DAWG_GLAMPING", cf, ( -24178.6, 47097.4, 1555.92 ), ( 0, 0, 0 ), "ESCORT_DAWG_GLAMPING", undefined, "dawg_escort_glamping", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node_end";
    s.target2 = "ambushend_point";
    fe [[ f ]]( s, "ESCORT_DAWG_GLAMPING", cf, ( -25595.9, 55283.1, 2670.17 ), ( 0, 310, 0 ), "cspf_5_auto9264513666015430663", undefined, "ESCORT_DAWG_GLAMPING_ENDPOINT", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_dawg_escort_cs";
    s.name = "ambush1_point";
    fe [[ f ]]( s, "ESCORT_DAWG_GLAMPING", cf, ( -26830.5, 48672.2, 1687.71 ), ( 0, 0, 0 ), "ambush1_point", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 300 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_dawg_escort_cs";
    s.name = "ambush1_point";
    fe [[ f ]]( s, "ESCORT_DAWG_GLAMPING", cf, ( -26898.7, 49873.7, 1687.23 ), ( 0, 270, 0 ), "ambush1_point", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 300 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_dawg_escort_cs";
    s.name = "ambush1_point";
    fe [[ f ]]( s, "ESCORT_DAWG_GLAMPING", cf, ( -25857.8, 49898.1, 1767.65 ), ( 0, 0, 0 ), "ambush1_point", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 300 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_dawg_escort_cs";
    s.name = "ambush2_point";
    fe [[ f ]]( s, "ESCORT_DAWG_GLAMPING", cf, ( -28523, 53386.9, 2543.56 ), ( 0, 0, 0 ), "ambush2_point", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 300 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_dawg_escort_cs";
    s.name = "ambush2_point";
    fe [[ f ]]( s, "ESCORT_DAWG_GLAMPING", cf, ( -28281.3, 52217.5, 2552 ), ( 0, 0, 0 ), "ambush2_point", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 300 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_dawg_escort_cs";
    s.name = "ambush2_point";
    fe [[ f ]]( s, "ESCORT_DAWG_GLAMPING", cf, ( -26834.9, 54325.1, 2605.68 ), ( 0, 0, 0 ), "ambush2_point", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 300 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_dawg_escort_cs";
    s.name = "ambush3_point";
    fe [[ f ]]( s, "ESCORT_DAWG_GLAMPING", cf, ( -26165, 54827.4, 2680 ), ( 0, 0, 0 ), "ambush3_point", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 300 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_dawg_escort_cs";
    s.name = "ambush3_point";
    fe [[ f ]]( s, "ESCORT_DAWG_GLAMPING", cf, ( -26249.5, 54489.6, 2827.14 ), ( 0, 0, 0 ), "ambush3_point", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 300 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_dawg_escort_cs";
    s.name = "ambush3_point";
    fe [[ f ]]( s, "ESCORT_DAWG_GLAMPING", cf, ( -26191, 56134, 2664.6 ), ( 0, 0, 0 ), "ambush3_point", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 300 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node";
    fe [[ f ]]( s, "ESCORT_DAWG_GLAMPING", cf, ( -27502.7, 50359.4, 1719.98 ), ( 0, 0, 0 ), "cspf_5_auto5348514299692589813", "cspf_5_auto3694911459347536485", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node";
    fe [[ f ]]( s, "ESCORT_DAWG_GLAMPING", cf, ( -27683.4, 51053.8, 1879.13 ), ( 0, 0, 0 ), "cspf_5_auto3694911459347536485", "cspf_5_auto16257117452669729480", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node";
    fe [[ f ]]( s, "ESCORT_DAWG_GLAMPING", cf, ( -27357.1, 53556.1, 2461.68 ), ( 0, 0, 0 ), "cspf_5_auto9312016267918506334", "cspf_5_auto2973328367453607495", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node";
    fe [[ f ]]( s, "ESCORT_DAWG_GLAMPING", cf, ( -26494, 55520.2, 2648.8 ), ( 0, 0, 0 ), "cspf_5_auto13631424358659564518", "cspf_5_auto3654473408460131489", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node";
    fe [[ f ]]( s, "ESCORT_DAWG_GLAMPING", cf, ( -26137.1, 55565.1, 2649.64 ), ( 0, 0, 0 ), "cspf_5_auto3654473408460131489", "cspf_5_auto14499600148721125212", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node";
    fe [[ f ]]( s, "ESCORT_DAWG_GLAMPING", cf, ( -27617.1, 54076.4, 2543.74 ), ( 0, 0, 0 ), "cspf_5_auto2973328367453607495", "cspf_5_auto3188208149445745104", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node";
    fe [[ f ]]( s, "ESCORT_DAWG_GLAMPING", cf, ( -25838.1, 55477.2, 2658.96 ), ( 0, 0, 0 ), "cspf_5_auto14499600148721125212", "cspf_5_auto9264513666015430663", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node";
    fe [[ f ]]( s, "ESCORT_DAWG_GLAMPING", cf, ( -27553.8, 54300.9, 2558.09 ), ( 0, 0, 0 ), "cspf_5_auto3188208149445745104", "cspf_5_auto15630897851852100380", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_dawg_escort_cs";
    s.name = "ambushend_point";
    fe [[ f ]]( s, "ESCORT_DAWG_GLAMPING", cf, ( -26211.4, 54819.7, 2680 ), ( 0, 0, 0 ), "ambushend_point", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 300 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_dawg_escort_cs";
    s.name = "ambushend_point";
    fe [[ f ]]( s, "ESCORT_DAWG_GLAMPING", cf, ( -25009.4, 54746.9, 2675.49 ), ( 0, 0, 0 ), "ambushend_point", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 300 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_dawg_escort_cs";
    s.name = "ambushend_point";
    fe [[ f ]]( s, "ESCORT_DAWG_GLAMPING", cf, ( -26225, 54944.4, 2824 ), ( 0, 0, 0 ), "ambushend_point", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 300 );
}

// Namespace mp_sat_avalon_q1_ob_contract_dawg_escort_cs
// Params 3
// Checksum 0x17c4afe0, Offset: 0x4115
// Size: 0x119e
function function_3fef4c4479811a8f( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node";
    fe [[ f ]]( s, "ESCORT_DAWG_STADIUM", cf, ( -44708.8, 11637.7, 464 ), ( 0, 0, 0 ), "cspf_6_auto8395365048207118860", "cspf_6_auto10688394956594171936", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node";
    fe [[ f ]]( s, "ESCORT_DAWG_STADIUM", cf, ( -41778.3, 9487.18, 416 ), ( 0, 0, 0 ), "cspf_6_auto16718275286863508888", "cspf_6_auto15630897851852100380", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node";
    fe [[ f ]]( s, "ESCORT_DAWG_STADIUM", cf, ( -45374, 11690.4, 464 ), ( 0, 0, 0 ), "cspf_6_auto6003449379766086771", "cspf_6_auto13800611643972878409", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node";
    fe [[ f ]]( s, "ESCORT_DAWG_STADIUM", cf, ( -43344.3, 11631, 400 ), ( 0, 0, 0 ), "cspf_6_auto10688394956594171936", "cspf_6_auto5348514299692589813", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "start_path";
    fe [[ f ]]( s, "ESCORT_DAWG_STADIUM", cf, ( -46549.9, 11872.4, 336 ), ( 0, 0, 0 ), "ESCORT_DAWG_STADIUM_PATH_START", "cspf_6_auto15580734621475046237", "path_start_node", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_dawg_escort_cs";
    fe [[ f ]]( s, "ESCORT_DAWG_STADIUM", cf, ( -25348.6, 55336.1, 2675.81 ), ( 0, 0, 0 ), "ESCORT_DAWG_STADIUM_REWARD", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node";
    fe [[ f ]]( s, "ESCORT_DAWG_STADIUM", cf, ( -46117.1, 11777.5, 336 ), ( 0, 0, 0 ), "cspf_6_auto15580734621475046237", "cspf_6_auto16209657584490013156", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node";
    fe [[ f ]]( s, "ESCORT_DAWG_STADIUM", cf, ( -45902.7, 11779.8, 464 ), ( 0, 0, 0 ), "cspf_6_auto16209657584490013156", "cspf_6_auto6003449379766086771", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node_ambush";
    s.target2 = "ambush1_point";
    fe [[ f ]]( s, "ESCORT_DAWG_STADIUM", cf, ( -45044.5, 11693.3, 464 ), ( 0, 0, 0 ), "cspf_6_auto13800611643972878409", "cspf_6_auto8395365048207118860", "ambush", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node_ambush";
    s.target2 = "ambush2_point";
    fe [[ f ]]( s, "ESCORT_DAWG_STADIUM", cf, ( -42267.4, 11308.9, 448 ), ( 0, 0, 0 ), "cspf_6_auto7506293857130010347", "cspf_6_auto9312016267918506334", "ambush", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node";
    fe [[ f ]]( s, "ESCORT_DAWG_STADIUM", cf, ( -42448.9, 11331.2, 448 ), ( 0, 0, 0 ), "cspf_6_auto16257117452669729480", "cspf_6_auto7506293857130010347", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node_ambush";
    s.target2 = "ambush3_point";
    fe [[ f ]]( s, "ESCORT_DAWG_STADIUM", cf, ( -41447.2, 9056.21, 416 ), ( 0, 315, 0 ), "cspf_6_auto15630897851852100380", "cspf_6_auto1868615636547401434", "ambush", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node";
    fe [[ f ]]( s, "ESCORT_DAWG_STADIUM", cf, ( -40975.2, 8713.99, 416 ), ( 0, 0, 0 ), "cspf_6_auto1868615636547401434", "cspf_6_auto13631424358659564518", "attack", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_dawg_escort_cs";
    fe [[ f ]]( s, "ESCORT_DAWG_STADIUM", cf, ( -46661.2, 12136.5, 336 ), ( 0, 0, 0 ), "ESCORT_DAWG_STADIUM", undefined, "dawg_escort_stadium", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node_end";
    s.target2 = "ambushend_point";
    fe [[ f ]]( s, "ESCORT_DAWG_STADIUM", cf, ( -39147, 9808.53, 352.75 ), ( 0, 310, 0 ), "cspf_6_auto9264513666015430663", undefined, "ESCORT_DAWG_STADIUM_ENDPOINT", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_dawg_escort_cs";
    s.name = "ambush1_point";
    fe [[ f ]]( s, "ESCORT_DAWG_STADIUM", cf, ( -44488.3, 12303.7, 464 ), ( 0, 0, 0 ), "ambush1_point", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 300 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_dawg_escort_cs";
    s.name = "ambush1_point";
    fe [[ f ]]( s, "ESCORT_DAWG_STADIUM", cf, ( -44114.1, 11686.9, 432 ), ( 0, 270, 0 ), "ambush1_point", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 300 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_dawg_escort_cs";
    s.name = "ambush1_point";
    fe [[ f ]]( s, "ESCORT_DAWG_STADIUM", cf, ( -44666.6, 11104.4, 464 ), ( 0, 0, 0 ), "ambush1_point", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 300 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_dawg_escort_cs";
    s.name = "ambush2_point";
    fe [[ f ]]( s, "ESCORT_DAWG_STADIUM", cf, ( -41453, 11007, 408 ), ( 0, 0, 0 ), "ambush2_point", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 300 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_dawg_escort_cs";
    s.name = "ambush2_point";
    fe [[ f ]]( s, "ESCORT_DAWG_STADIUM", cf, ( -41995.3, 10560.1, 448 ), ( 0, 0, 0 ), "ambush2_point", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 300 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_dawg_escort_cs";
    s.name = "ambush2_point";
    fe [[ f ]]( s, "ESCORT_DAWG_STADIUM", cf, ( -42131.1, 12031, 448 ), ( 0, 0, 0 ), "ambush2_point", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 300 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_dawg_escort_cs";
    s.name = "ambush3_point";
    fe [[ f ]]( s, "ESCORT_DAWG_STADIUM", cf, ( -40376.6, 8577.09, 416 ), ( 0, 0, 0 ), "ambush3_point", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 300 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_dawg_escort_cs";
    s.name = "ambush3_point";
    fe [[ f ]]( s, "ESCORT_DAWG_STADIUM", cf, ( -41366.6, 8237.7, 416 ), ( 0, 0, 0 ), "ambush3_point", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 300 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_dawg_escort_cs";
    s.name = "ambush3_point";
    fe [[ f ]]( s, "ESCORT_DAWG_STADIUM", cf, ( -41086.2, 9405.11, 416 ), ( 0, 0, 0 ), "ambush3_point", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 300 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node";
    fe [[ f ]]( s, "ESCORT_DAWG_STADIUM", cf, ( -43085.8, 11283.6, 400 ), ( 0, 0, 0 ), "cspf_6_auto5348514299692589813", "cspf_6_auto3694911459347536485", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node";
    fe [[ f ]]( s, "ESCORT_DAWG_STADIUM", cf, ( -42738.6, 11337.5, 400 ), ( 0, 0, 0 ), "cspf_6_auto3694911459347536485", "cspf_6_auto16257117452669729480", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node";
    fe [[ f ]]( s, "ESCORT_DAWG_STADIUM", cf, ( -41986.6, 11243.1, 448 ), ( 0, 0, 0 ), "cspf_6_auto9312016267918506334", "cspf_6_auto2973328367453607495", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node";
    fe [[ f ]]( s, "ESCORT_DAWG_STADIUM", cf, ( -40455, 8745.58, 416 ), ( 0, 0, 0 ), "cspf_6_auto13631424358659564518", "cspf_6_auto3654473408460131489", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node";
    fe [[ f ]]( s, "ESCORT_DAWG_STADIUM", cf, ( -40089.8, 8884, 416 ), ( 0, 0, 0 ), "cspf_6_auto3654473408460131489", "cspf_6_auto14499600148721125212", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node";
    fe [[ f ]]( s, "ESCORT_DAWG_STADIUM", cf, ( -41902.7, 10431.9, 455.27 ), ( 0, 0, 0 ), "cspf_6_auto2973328367453607495", "cspf_6_auto3188208149445745104", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node";
    fe [[ f ]]( s, "ESCORT_DAWG_STADIUM", cf, ( -39995.6, 9809.01, 264 ), ( 0, 0, 0 ), "cspf_6_auto14499600148721125212", "cspf_6_auto9264513666015430663", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node";
    fe [[ f ]]( s, "ESCORT_DAWG_STADIUM", cf, ( -41902, 9965.02, 416 ), ( 0, 0, 0 ), "cspf_6_auto3188208149445745104", "cspf_6_auto16718275286863508888", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_dawg_escort_cs";
    s.name = "ambushend_point";
    fe [[ f ]]( s, "ESCORT_DAWG_STADIUM", cf, ( -38684.5, 8887.84, 416 ), ( 0, 0, 0 ), "ambushend_point", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 300 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_dawg_escort_cs";
    s.name = "ambushend_point";
    fe [[ f ]]( s, "ESCORT_DAWG_STADIUM", cf, ( -39202.2, 8539.02, 608 ), ( 0, 0, 0 ), "ambushend_point", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 300 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_dawg_escort_cs";
    s.name = "ambushend_point";
    fe [[ f ]]( s, "ESCORT_DAWG_STADIUM", cf, ( -39963.2, 8151.56, 928 ), ( 0, 0, 0 ), "ambushend_point", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 300 );
}

// Namespace mp_sat_avalon_q1_ob_contract_dawg_escort_cs
// Params 0
// Checksum 0x4acf3a6f, Offset: 0x52bb
// Size: 0x286
function function_d9dd7965c51c95d1()
{
    activityinstances = [];
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_ob_activitydefinition_dawg_escort";
    var_881289d7987bc770.cf = "mp_sat_avalon_q1_ob_contract_dawg_escort_cs";
    var_881289d7987bc770.scriptstructorigin = ( -11997.8, 29557.6, 768 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [ ( -8896.34, 25969.7, 768 ) ];
    var_881289d7987bc770.var_31ce4477e3543d24 = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.locationradius = [ 6000 ];
    activityinstances[ "ESCORT_DAWG_CASINO" ] = var_881289d7987bc770;
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_ob_activitydefinition_dawg_escort";
    var_881289d7987bc770.cf = "mp_sat_avalon_q1_ob_contract_dawg_escort_cs";
    var_881289d7987bc770.scriptstructorigin = ( -24234.6, 47128.1, 1555.25 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [ ( -8896.34, 25969.7, 768 ) ];
    var_881289d7987bc770.var_31ce4477e3543d24 = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.locationradius = [ 6000 ];
    activityinstances[ "ESCORT_DAWG_GLAMPING" ] = var_881289d7987bc770;
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_ob_activitydefinition_dawg_escort";
    var_881289d7987bc770.cf = "mp_sat_avalon_q1_ob_contract_dawg_escort_cs";
    var_881289d7987bc770.scriptstructorigin = ( -46698.2, 12055.1, 336 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [ ( -42487.7, 10994.6, 263.81 ) ];
    var_881289d7987bc770.var_31ce4477e3543d24 = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.locationradius = [ 5000 ];
    activityinstances[ "ESCORT_DAWG_STADIUM" ] = var_881289d7987bc770;
    return activityinstances;
}

