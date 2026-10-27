// script_209b35d9eb583699  (hash_209b35d9eb583699.gscc) (size: 19725 Bytes / 0x4d0d / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x8525e31 (139615793)
// size ...... 19725 (0x4d0d)
// includes .. 4   (offset: 0x41fd)
// strings ... 82  (offset: 0x421d)
// dev strs .. 0   (offset: 0x4d0d)
// exports ... 14  (offset: 0x3cd1)
// cseg ...... 0x982 + 0x334f (0x3cd1)
// imports ... 27  (offset: 0x3f01)
// animtree1 . 0   (offset: 0x4d0d)
// animtree2 . 0   (offset: 0x4d0d)
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace mp_sat_avalon_q3_ob_contract_dawg_escort_cs;

// Namespace mp_sat_avalon_q3_ob_contract_dawg_escort_cs
// Params 0, eflags: 0x5
// Checksum 0x4b00009f, Offset: 0x9a0
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"mp_sat_avalon_q3_ob_contract_dawg_escort_cs", #"activity_common", &function_b39ecd3d51489472, undefined );
}

// Namespace mp_sat_avalon_q3_ob_contract_dawg_escort_cs
// Params 0, eflags: 0x4
// Checksum 0x1e4d5ad7, Offset: 0x9c9
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace mp_sat_avalon_q3_ob_contract_dawg_escort_cs
// Params 0, eflags: 0x4
// Checksum 0x9b76893b, Offset: 0x9da
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace mp_sat_avalon_q3_ob_contract_dawg_escort_cs
// Params 2
// Checksum 0x6f8729df, Offset: 0x9eb
// Size: 0x8c
function main( unused, unused2 )
{
    if ( utility::flag_exist( "mp_sat_avalon_q3_ob_contract_dawg_escort_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "mp_sat_avalon_q3_ob_contract_dawg_escort_cs" ) )
    {
        return;
    }
    
    activity_common::function_e1df676808c1d1e3( &function_4cd78e661617f3 );
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "mp_sat_avalon_q3_ob_contract_dawg_escort_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "mp_sat_avalon_q3_ob_contract_dawg_escort_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace mp_sat_avalon_q3_ob_contract_dawg_escort_cs
// Params 3, eflags: 0x4
// Checksum 0x18f43df4, Offset: 0xa7f
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "mp_sat_avalon_q3_ob_contract_dawg_escort_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "mp_sat_avalon_q3_ob_contract_dawg_escort_cs" );
}

// Namespace mp_sat_avalon_q3_ob_contract_dawg_escort_cs
// Params 3, eflags: 0x4
// Checksum 0xce684b3a, Offset: 0xaf9
// Size: 0x9b0
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_contract_dawg_escort_cs";
    s.activity_bundle = "sat_ob_activitydefinition_dawg_escort";
    s.name = "ESCORT_DAWG_FORT";
    fe [[ f ]]( s, "ESCORT_DAWG_FORT", cf, ( -34309.7, -42696.4, 691.3 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_contract_dawg_escort_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "dawg_escort";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "ESCORT_DAWG_FORT", cf, ( -34630.1, -42878.5, 680.67 ), ( 0, 271.8, 0 ), undefined, undefined, "dawg_escort_fort", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_contract_dawg_escort_cs";
    fe [[ f ]]( s, "ESCORT_DAWG_FORT", cf, ( -32323, -44475.2, 237.43 ), ( 0, 116.2, 0 ), "activity_nexus_instance_joiner", "ESCORT_DAWG_FORT", "ESCORT_DAWG_FORT", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_contract_dawg_escort_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "dawg_escort";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "ESCORT_DAWG_FORT", cf, ( -34188.2, -42906.2, 692.08 ), ( 0, 345.7, 0 ), undefined, undefined, "dawg_escort_fort", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_contract_dawg_escort_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "dawg_escort";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "ESCORT_DAWG_FORT", cf, ( -34664.6, -43239.3, 682.54 ), ( 0, 181.1, 0 ), undefined, undefined, "dawg_escort_fort", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_contract_dawg_escort_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "dawg_escort";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "ESCORT_DAWG_FORT", cf, ( -34410.4, -43689.9, 683.32 ), ( 0, 272.7, 0 ), undefined, undefined, "dawg_escort_fort", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_contract_dawg_escort_cs";
    fe [[ f ]]( s, "ESCORT_DAWG_FORT", cf, ( -34472.9, -42830.9, 686.44 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Awareness_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 1500 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_contract_dawg_escort_cs";
    s.activity_bundle = "sat_ob_activitydefinition_dawg_escort";
    s.name = "ESCORT_DAWG_TRAINING_GROUNDS";
    fe [[ f ]]( s, "ESCORT_DAWG_TRAINING_GROUNDS", cf, ( -31374.6, -26844.5, 766.22 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_contract_dawg_escort_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "dawg_escort";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "ESCORT_DAWG_TRAINING_GROUNDS", cf, ( -31649.1, -27006.1, 769.64 ), ( 0, 137.4, 0 ), undefined, undefined, "dawg_escort_training_grounds", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_contract_dawg_escort_cs";
    fe [[ f ]]( s, "ESCORT_DAWG_TRAINING_GROUNDS", cf, ( -28444.3, -27184.6, 844 ), ( 0, 153.29, 0 ), "activity_nexus_instance_joiner", "ESCORT_DAWG_TRAINING_GROUNDS", "ESCORT_DAWG_TRAINING_GROUNDS", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_contract_dawg_escort_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "dawg_escort";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "ESCORT_DAWG_TRAINING_GROUNDS", cf, ( -31441.2, -27074.5, 763.12 ), ( 0, 43.9, 0 ), undefined, undefined, "dawg_escort_training_grounds", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_contract_dawg_escort_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "dawg_escort";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "ESCORT_DAWG_TRAINING_GROUNDS", cf, ( -31435.1, -26648.4, 763.73 ), ( 0, 42.1, 0 ), undefined, undefined, "dawg_escort_training_grounds", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_contract_dawg_escort_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "dawg_escort";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "ESCORT_DAWG_TRAINING_GROUNDS", cf, ( -31076, -27187.6, 769.86 ), ( 0, 253, 0 ), undefined, undefined, "dawg_escort_training_grounds", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_contract_dawg_escort_cs";
    fe [[ f ]]( s, "ESCORT_DAWG_TRAINING_GROUNDS", cf, ( -31478.8, -26953.1, 762.69 ), ( 0, 0, 0 ), "activity_nexus_spatial_zone", undefined, "Awareness_Zone", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ), 1500 );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace mp_sat_avalon_q3_ob_contract_dawg_escort_cs
// Params 0, eflags: 0x4
// Checksum 0x78039d92, Offset: 0x14b1
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace mp_sat_avalon_q3_ob_contract_dawg_escort_cs
// Params 0
// Checksum 0xdaa7e0b9, Offset: 0x14bb
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "mp_sat_avalon_q3_ob_contract_dawg_escort_cs" );
}

// Namespace mp_sat_avalon_q3_ob_contract_dawg_escort_cs
// Params 0
// Checksum 0xc848c9ae, Offset: 0x14d1
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

// Namespace mp_sat_avalon_q3_ob_contract_dawg_escort_cs
// Params 4
// Checksum 0x329ae3a2, Offset: 0x1540
// Size: 0x71
function function_d4323822d7042e5a( var_4312b79c960726b6, fe, us, cf = "mp_sat_avalon_q3_ob_contract_dawg_escort_cs" )
{
    switch ( var_4312b79c960726b6 )
    {
        case #"hash_ab3df503e9ebe0f5":
            function_3ef0c1e1ab7c3d6d( fe, us, cf );
            break;
        case #"hash_ae5ea482514f4139":
            function_6e24698a157ccd51( fe, us, cf );
            break;
    }
}

// Namespace mp_sat_avalon_q3_ob_contract_dawg_escort_cs
// Params 3
// Checksum 0x177968d7, Offset: 0x15b9
// Size: 0x1437
function function_3ef0c1e1ab7c3d6d( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node";
    fe [[ f ]]( s, "ESCORT_DAWG_FORT", cf, ( -37471.4, -39434.6, 889 ), ( 0, 180, 0 ), "cspf_3_auto6943640134076607822", "cspf_3_auto7506293857130010347", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node";
    fe [[ f ]]( s, "ESCORT_DAWG_FORT", cf, ( -36109.1, -42561.3, 713.97 ), ( 0, 90, 0 ), "cspf_3_auto13800611643972878409", "cspf_3_auto15747674001173024670", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node";
    fe [[ f ]]( s, "ESCORT_DAWG_FORT", cf, ( -35970.1, -43123, 682.11 ), ( 0, 0, 0 ), "cspf_3_auto6003449379766086771", "cspf_3_auto13800611643972878409", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node";
    fe [[ f ]]( s, "ESCORT_DAWG_FORT", cf, ( -36156.4, -40463.9, 745.56 ), ( 0, 0, 0 ), "cspf_3_auto10688394956594171936", "cspf_3_auto5348514299692589813", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "start_path";
    fe [[ f ]]( s, "ESCORT_DAWG_FORT", cf, ( -34472.9, -42830.9, 686.44 ), ( 0, 270, 0 ), "ESCORT_DAWG_FORT_PATH_START", "cspf_3_auto4625320087516359556", "path_start_node", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_contract_dawg_escort_cs";
    fe [[ f ]]( s, "ESCORT_DAWG_FORT", cf, ( -40628.5, -36594.3, 991.95 ), ( 0, 0, 0 ), "ESCORT_DAWG_FORT_REWARD", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node";
    fe [[ f ]]( s, "ESCORT_DAWG_FORT", cf, ( -34892.6, -43238.1, 681.99 ), ( 0, 0, 0 ), "cspf_3_auto15580734621475046237", "cspf_3_auto16209657584490013156", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node";
    fe [[ f ]]( s, "ESCORT_DAWG_FORT", cf, ( -35772.5, -43260.4, 692.69 ), ( 0, 0, 0 ), "cspf_3_auto16209657584490013156", "cspf_3_auto6003449379766086771", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node_ambush";
    s.target2 = "ambush1_point";
    fe [[ f ]]( s, "ESCORT_DAWG_FORT", cf, ( -36121.1, -42183.8, 723.76 ), ( 0, 90, 0 ), "cspf_3_auto15747674001173024670", "cspf_3_auto10688394956594171936", "ambush", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node";
    fe [[ f ]]( s, "ESCORT_DAWG_FORT", cf, ( -36412.7, -40289.1, 761.75 ), ( 0, 0, 0 ), "cspf_3_auto5348514299692589813", "cspf_3_auto16945942842540786971", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node_ambush";
    s.target2 = "ambush2_point";
    fe [[ f ]]( s, "ESCORT_DAWG_FORT", cf, ( -37942.9, -39407.8, 889.27 ), ( 0, 180, 0 ), "cspf_3_auto7506293857130010347", "cspf_3_auto9312016267918506334", "ambush", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node";
    fe [[ f ]]( s, "ESCORT_DAWG_FORT", cf, ( -37191.5, -39614.6, 902.5 ), ( 0, 0, 0 ), "cspf_3_auto16257117452669729480", "cspf_3_auto6943640134076607822", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node_ambush";
    s.target2 = "ambush3_point";
    fe [[ f ]]( s, "ESCORT_DAWG_FORT", cf, ( -40249.6, -38242.7, 904.47 ), ( 0, 0, 0 ), "cspf_3_auto15630897851852100380", "cspf_3_auto1868615636547401434", "ambush", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node";
    fe [[ f ]]( s, "ESCORT_DAWG_FORT", cf, ( -40799.1, -37648.9, 916.64 ), ( 0, 0, 0 ), "cspf_3_auto1868615636547401434", "cspf_3_auto13631424358659564518", "attack", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_contract_dawg_escort_cs";
    fe [[ f ]]( s, "ESCORT_DAWG_FORT", cf, ( -34350.4, -42702, 691.3 ), ( 0, 0, 0 ), "ESCORT_DAWG_FORT", undefined, "dawg_escort_fort", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node_end";
    s.target2 = "ambushend_point";
    fe [[ f ]]( s, "ESCORT_DAWG_FORT", cf, ( -39750.1, -36177.8, 1021.56 ), ( 0, 310, 0 ), "cspf_3_auto3433752182511304780", undefined, "ESCORT_DAWG_FORT_ENDPOINT", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_contract_dawg_escort_cs";
    s.name = "ambush1_point";
    fe [[ f ]]( s, "ESCORT_DAWG_FORT", cf, ( -36918.2, -42085.7, 719.95 ), ( 0, 0, 0 ), "ambush1_point", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 300 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_contract_dawg_escort_cs";
    s.name = "ambush1_point";
    fe [[ f ]]( s, "ESCORT_DAWG_FORT", cf, ( -35348.7, -42108.7, 678.65 ), ( 0, 270, 0 ), "ambush1_point", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 300 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_contract_dawg_escort_cs";
    s.name = "ambush1_point";
    fe [[ f ]]( s, "ESCORT_DAWG_FORT", cf, ( -36130.7, -41296.2, 740.23 ), ( 0, 0, 0 ), "ambush1_point", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 300 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_contract_dawg_escort_cs";
    s.name = "ambush2_point";
    fe [[ f ]]( s, "ESCORT_DAWG_FORT", cf, ( -37528.7, -40105.9, 888 ), ( 0, 0, 0 ), "ambush2_point", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 300 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_contract_dawg_escort_cs";
    s.name = "ambush2_point";
    fe [[ f ]]( s, "ESCORT_DAWG_FORT", cf, ( -38470.2, -40099.9, 879.74 ), ( 0, 0, 0 ), "ambush2_point", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 300 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_contract_dawg_escort_cs";
    s.name = "ambush2_point";
    fe [[ f ]]( s, "ESCORT_DAWG_FORT", cf, ( -37955, -38583.4, 889 ), ( 0, 0, 0 ), "ambush2_point", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 300 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_contract_dawg_escort_cs";
    s.name = "ambush3_point";
    fe [[ f ]]( s, "ESCORT_DAWG_FORT", cf, ( -40657.5, -37373, 934.23 ), ( 0, 0, 0 ), "ambush3_point", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 300 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_contract_dawg_escort_cs";
    s.name = "ambush3_point";
    fe [[ f ]]( s, "ESCORT_DAWG_FORT", cf, ( -41117.6, -38360.3, 912.57 ), ( 0, 0, 0 ), "ambush3_point", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 300 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_contract_dawg_escort_cs";
    s.name = "ambush3_point";
    fe [[ f ]]( s, "ESCORT_DAWG_FORT", cf, ( -39375.6, -37644.5, 897.85 ), ( 0, 0, 0 ), "ambush3_point", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 300 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node";
    fe [[ f ]]( s, "ESCORT_DAWG_FORT", cf, ( -36984.7, -40285, 847.01 ), ( 0, 0, 0 ), "cspf_3_auto16945942842540786971", "cspf_3_auto3694911459347536485", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node";
    fe [[ f ]]( s, "ESCORT_DAWG_FORT", cf, ( -37190.7, -40058.5, 880.32 ), ( 0, 0, 0 ), "cspf_3_auto3694911459347536485", "cspf_3_auto16257117452669729480", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node";
    fe [[ f ]]( s, "ESCORT_DAWG_FORT", cf, ( -38309.8, -39391, 889 ), ( 0, 0, 0 ), "cspf_3_auto9312016267918506334", "cspf_3_auto2973328367453607495", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node";
    fe [[ f ]]( s, "ESCORT_DAWG_FORT", cf, ( -40757.6, -37447.9, 927.23 ), ( 0, 0, 0 ), "cspf_3_auto13631424358659564518", "cspf_3_auto3654473408460131489", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node";
    fe [[ f ]]( s, "ESCORT_DAWG_FORT", cf, ( -40723, -37405.3, 929.58 ), ( 0, 0, 0 ), "cspf_3_auto3654473408460131489", "cspf_3_auto14499600148721125212", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node";
    fe [[ f ]]( s, "ESCORT_DAWG_FORT", cf, ( -38780.9, -39046.1, 889 ), ( 0, 0, 0 ), "cspf_3_auto2973328367453607495", "cspf_3_auto3188208149445745104", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node";
    fe [[ f ]]( s, "ESCORT_DAWG_FORT", cf, ( -40534.9, -37228.4, 950.81 ), ( 0, 0, 0 ), "cspf_3_auto14499600148721125212", "cspf_3_auto9264513666015430663", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node";
    fe [[ f ]]( s, "ESCORT_DAWG_FORT", cf, ( -40258.6, -36344.4, 1023.12 ), ( 0, 0, 0 ), "cspf_3_auto17349287045644331296", "cspf_3_auto3433752182511304780", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node";
    fe [[ f ]]( s, "ESCORT_DAWG_FORT", cf, ( -40414.4, -36840.3, 992.34 ), ( 0, 0, 0 ), "cspf_3_auto9264513666015430663", "cspf_3_auto17349287045644331296", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node";
    fe [[ f ]]( s, "ESCORT_DAWG_FORT", cf, ( -39299, -38981.3, 883.57 ), ( 0, 0, 0 ), "cspf_3_auto3188208149445745104", "cspf_3_auto414720478623316145", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_contract_dawg_escort_cs";
    s.name = "ambushend_point";
    fe [[ f ]]( s, "ESCORT_DAWG_FORT", cf, ( -38162.8, -36101.8, 960.34 ), ( 0, 0, 0 ), "ambushend_point", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 300 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_contract_dawg_escort_cs";
    s.name = "ambushend_point";
    fe [[ f ]]( s, "ESCORT_DAWG_FORT", cf, ( -39189.7, -36805.9, 1026.54 ), ( 0, 0, 0 ), "ambushend_point", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 300 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_contract_dawg_escort_cs";
    s.name = "ambushend_point";
    fe [[ f ]]( s, "ESCORT_DAWG_FORT", cf, ( -39138.4, -35559.6, 1024.37 ), ( 0, 0, 0 ), "ambushend_point", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 300 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node";
    fe [[ f ]]( s, "ESCORT_DAWG_FORT", cf, ( -39669.2, -38819.4, 890.16 ), ( 0, 0, 0 ), "cspf_3_auto414720478623316145", "cspf_3_auto15630897851852100380", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node";
    fe [[ f ]]( s, "ESCORT_DAWG_FORT", cf, ( -34483.3, -43035.8, 680.65 ), ( 0, 0, 0 ), "cspf_3_auto4625320087516359556", "cspf_3_auto15580734621475046237", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_sat_avalon_q3_ob_contract_dawg_escort_cs
// Params 3
// Checksum 0xc0ced46c, Offset: 0x29f8
// Size: 0x1119
function function_6e24698a157ccd51( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node";
    fe [[ f ]]( s, "ESCORT_DAWG_TRAINING_GROUNDS", cf, ( -26573.3, -32537.4, 817.68 ), ( 0, 0, 0 ), "cspf_4_auto8347864235030735767", "cspf_4_auto591213557595269662", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node";
    fe [[ f ]]( s, "ESCORT_DAWG_TRAINING_GROUNDS", cf, ( -26370, -32301.6, 817.64 ), ( 0, 0, 0 ), "cspf_4_auto591213557595269662", "cspf_4_auto11731810469621168935", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node";
    fe [[ f ]]( s, "ESCORT_DAWG_TRAINING_GROUNDS", cf, ( -32192, -29545.6, 821.24 ), ( 0, 0, 0 ), "cspf_4_auto7282335461919288211", "cspf_4_auto5348514299692589813", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node";
    fe [[ f ]]( s, "ESCORT_DAWG_TRAINING_GROUNDS", cf, ( -31174.6, -27598.4, 762.86 ), ( 0, 0, 0 ), "cspf_4_auto13857929294236233594", "cspf_4_auto8699015438312170618", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node";
    fe [[ f ]]( s, "ESCORT_DAWG_TRAINING_GROUNDS", cf, ( -32432.5, -29133.6, 776.97 ), ( 0, 0, 0 ), "cspf_4_auto10688394956594171936", "cspf_4_auto7282335461919288211", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "start_path";
    fe [[ f ]]( s, "ESCORT_DAWG_TRAINING_GROUNDS", cf, ( -31478.8, -26953.1, 762.69 ), ( 0, 313.2, 0 ), "ESCORT_DAWG_TRAINING_GROUNDS_PATH_START", "cspf_4_auto4625320087516359556", "path_start_node", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_contract_dawg_escort_cs";
    fe [[ f ]]( s, "ESCORT_DAWG_TRAINING_GROUNDS", cf, ( -26414, -31810.9, 815.65 ), ( 0, 0, 0 ), "ESCORT_DAWG_TRAINING_GROUNDS_REWARD", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node";
    fe [[ f ]]( s, "ESCORT_DAWG_TRAINING_GROUNDS", cf, ( -31180.8, -27271.5, 764.79 ), ( 0, 0, 0 ), "cspf_4_auto4625320087516359556", "cspf_4_auto13857929294236233594", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node";
    fe [[ f ]]( s, "ESCORT_DAWG_TRAINING_GROUNDS", cf, ( -30907.7, -30951, 851.18 ), ( 0, 0, 0 ), "cspf_4_auto8572430652078657947", "cspf_4_auto16945942842540786971", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node_ambush";
    s.target2 = "ambush1_point";
    fe [[ f ]]( s, "ESCORT_DAWG_TRAINING_GROUNDS", cf, ( -31992.5, -28549.1, 766.09 ), ( 0, 231.4, 0 ), "cspf_4_auto8699015438312170618", "cspf_4_auto10688394956594171936", "ambush", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node";
    fe [[ f ]]( s, "ESCORT_DAWG_TRAINING_GROUNDS", cf, ( -31640.8, -30116.1, 822.18 ), ( 0, 0, 0 ), "cspf_4_auto5348514299692589813", "cspf_4_auto8686144422624919709", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node_ambush";
    s.target2 = "ambush2_point";
    fe [[ f ]]( s, "ESCORT_DAWG_TRAINING_GROUNDS", cf, ( -29814.8, -31929, 891.03 ), ( 0, 316.4, 0 ), "cspf_4_auto16945942842540786971", "cspf_4_auto9312016267918506334", "ambush", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node";
    fe [[ f ]]( s, "ESCORT_DAWG_TRAINING_GROUNDS", cf, ( -31515.5, -30348.8, 835.32 ), ( 0, 0, 0 ), "cspf_4_auto8686144422624919709", "cspf_4_auto8572430652078657947", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node_ambush";
    s.target2 = "ambush3_point";
    fe [[ f ]]( s, "ESCORT_DAWG_TRAINING_GROUNDS", cf, ( -28446.6, -33196.2, 890.79 ), ( 0, 0, 0 ), "cspf_4_auto3188208149445745104", "cspf_4_auto1868615636547401434", "ambush", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node";
    fe [[ f ]]( s, "ESCORT_DAWG_TRAINING_GROUNDS", cf, ( -27857.9, -32708.1, 887.97 ), ( 0, 0, 0 ), "cspf_4_auto1868615636547401434", "cspf_4_auto13631424358659564518", "attack", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_contract_dawg_escort_cs";
    fe [[ f ]]( s, "ESCORT_DAWG_TRAINING_GROUNDS", cf, ( -31344, -26866.1, 767.23 ), ( 0, 0, 0 ), "ESCORT_DAWG_TRAINING_GROUNDS", undefined, "dawg_escort_training_grounds", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node_end";
    s.target2 = "ambushend_point";
    fe [[ f ]]( s, "ESCORT_DAWG_TRAINING_GROUNDS", cf, ( -26579.5, -31789.2, 815.65 ), ( 0, 139.2, 0 ), "cspf_4_auto11731810469621168935", undefined, "ESCORT_DAWG_TRAINING_GROUNDS_ENDPOINT", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_contract_dawg_escort_cs";
    s.name = "ambush1_point";
    fe [[ f ]]( s, "ESCORT_DAWG_TRAINING_GROUNDS", cf, ( -32790.6, -28736.4, 766.68 ), ( 0, 0, 0 ), "ambush1_point", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 300 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_contract_dawg_escort_cs";
    s.name = "ambush1_point";
    fe [[ f ]]( s, "ESCORT_DAWG_TRAINING_GROUNDS", cf, ( -32315.2, -29526.9, 780.88 ), ( 0, 270, 0 ), "ambush1_point", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 300 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_contract_dawg_escort_cs";
    s.name = "ambush1_point";
    fe [[ f ]]( s, "ESCORT_DAWG_TRAINING_GROUNDS", cf, ( -31582.6, -29353.5, 828.8 ), ( 0, 0, 0 ), "ambush1_point", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 300 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_contract_dawg_escort_cs";
    s.name = "ambush2_point";
    fe [[ f ]]( s, "ESCORT_DAWG_TRAINING_GROUNDS", cf, ( -29753, -32851.2, 888.95 ), ( 0, 0, 0 ), "ambush2_point", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 300 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_contract_dawg_escort_cs";
    s.name = "ambush2_point";
    fe [[ f ]]( s, "ESCORT_DAWG_TRAINING_GROUNDS", cf, ( -28928.4, -32290.7, 886.17 ), ( 0, 0, 0 ), "ambush2_point", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 300 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_contract_dawg_escort_cs";
    s.name = "ambush2_point";
    fe [[ f ]]( s, "ESCORT_DAWG_TRAINING_GROUNDS", cf, ( -30093.1, -32604.7, 898.48 ), ( 0, 0, 0 ), "ambush2_point", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 300 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_contract_dawg_escort_cs";
    s.name = "ambush3_point";
    fe [[ f ]]( s, "ESCORT_DAWG_TRAINING_GROUNDS", cf, ( -27826.8, -32710, 887.79 ), ( 0, 0, 0 ), "ambush3_point", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 300 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_contract_dawg_escort_cs";
    s.name = "ambush3_point";
    fe [[ f ]]( s, "ESCORT_DAWG_TRAINING_GROUNDS", cf, ( -27774.2, -33558.5, 889.27 ), ( 0, 0, 0 ), "ambush3_point", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 300 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_contract_dawg_escort_cs";
    s.name = "ambush3_point";
    fe [[ f ]]( s, "ESCORT_DAWG_TRAINING_GROUNDS", cf, ( -28540.4, -32341.7, 896 ), ( 0, 0, 0 ), "ambush3_point", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 300 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node";
    fe [[ f ]]( s, "ESCORT_DAWG_TRAINING_GROUNDS", cf, ( -29114.8, -33082.3, 892.44 ), ( 0, 0, 0 ), "cspf_4_auto9312016267918506334", "cspf_4_auto2973328367453607495", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node";
    fe [[ f ]]( s, "ESCORT_DAWG_TRAINING_GROUNDS", cf, ( -27407.3, -32568, 886.78 ), ( 0, 0, 0 ), "cspf_4_auto13631424358659564518", "cspf_4_auto3654473408460131489", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node";
    fe [[ f ]]( s, "ESCORT_DAWG_TRAINING_GROUNDS", cf, ( -27088.7, -32366.9, 822 ), ( 0, 0, 0 ), "cspf_4_auto3654473408460131489", "cspf_4_auto14499600148721125212", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node";
    fe [[ f ]]( s, "ESCORT_DAWG_TRAINING_GROUNDS", cf, ( -28820.8, -33185.4, 893.74 ), ( 0, 0, 0 ), "cspf_4_auto2973328367453607495", "cspf_4_auto3188208149445745104", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_contract_dawg_escort_cs";
    s.groupid = "DawgPath";
    s.name = "path_node";
    fe [[ f ]]( s, "ESCORT_DAWG_TRAINING_GROUNDS", cf, ( -26821, -32401.3, 817.92 ), ( 0, 0, 0 ), "cspf_4_auto14499600148721125212", "cspf_4_auto8347864235030735767", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_contract_dawg_escort_cs";
    s.name = "ambushend_point";
    fe [[ f ]]( s, "ESCORT_DAWG_TRAINING_GROUNDS", cf, ( -27187, -31933.3, 822 ), ( 0, 0, 0 ), "ambushend_point", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 300 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_contract_dawg_escort_cs";
    s.name = "ambushend_point";
    fe [[ f ]]( s, "ESCORT_DAWG_TRAINING_GROUNDS", cf, ( -26793.8, -30923.8, 814.85 ), ( 0, 0, 0 ), "ambushend_point", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 300 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q3_ob_contract_dawg_escort_cs";
    s.name = "ambushend_point";
    fe [[ f ]]( s, "ESCORT_DAWG_TRAINING_GROUNDS", cf, ( -27248.1, -31107.3, 880.84 ), ( 0, 0, 0 ), "ambushend_point", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 300 );
}

// Namespace mp_sat_avalon_q3_ob_contract_dawg_escort_cs
// Params 0
// Checksum 0xf985ee66, Offset: 0x3b19
// Size: 0x1b7
function function_d9dd7965c51c95d1()
{
    activityinstances = [];
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_ob_activitydefinition_dawg_escort";
    var_881289d7987bc770.cf = "mp_sat_avalon_q3_ob_contract_dawg_escort_cs";
    var_881289d7987bc770.scriptstructorigin = ( -34309.7, -42696.4, 691.3 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [ ( -37433.4, -39532.1, 885.29 ) ];
    var_881289d7987bc770.var_31ce4477e3543d24 = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.locationradius = [ 5500 ];
    activityinstances[ "ESCORT_DAWG_FORT" ] = var_881289d7987bc770;
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_ob_activitydefinition_dawg_escort";
    var_881289d7987bc770.cf = "mp_sat_avalon_q3_ob_contract_dawg_escort_cs";
    var_881289d7987bc770.scriptstructorigin = ( -31374.6, -26844.5, 766.22 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [ ( -29497.3, -30189.7, 918.5 ) ];
    var_881289d7987bc770.var_31ce4477e3543d24 = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.locationradius = [ 4000 ];
    activityinstances[ "ESCORT_DAWG_TRAINING_GROUNDS" ] = var_881289d7987bc770;
    return activityinstances;
}

