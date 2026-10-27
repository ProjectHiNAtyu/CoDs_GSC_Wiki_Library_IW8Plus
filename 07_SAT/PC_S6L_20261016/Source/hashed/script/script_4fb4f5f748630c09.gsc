// script_4fb4f5f748630c09  (hash_4fb4f5f748630c09.gscc) (size: 11327 Bytes / 0x2c3f / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x1857e5e4 (408413668)
// size ...... 11327 (0x2c3f)
// includes .. 4   (offset: 0x2687)
// strings ... 50  (offset: 0x26a7)
// dev strs .. 0   (offset: 0x2c3f)
// exports ... 14  (offset: 0x215b)
// cseg ...... 0x582 + 0x1bd9 (0x215b)
// imports ... 27  (offset: 0x238b)
// animtree1 . 0   (offset: 0x2c3f)
// animtree2 . 0   (offset: 0x2c3f)
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace mp_sat_avalon_q1_ob_contract_mystery_cargo_cs;

// Namespace mp_sat_avalon_q1_ob_contract_mystery_cargo_cs
// Params 0, eflags: 0x5
// Checksum 0xce06fd6f, Offset: 0x5a0
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"mp_sat_avalon_q1_ob_contract_mystery_cargo_cs", #"activity_common", &function_b39ecd3d51489472, undefined );
}

// Namespace mp_sat_avalon_q1_ob_contract_mystery_cargo_cs
// Params 0, eflags: 0x4
// Checksum 0x8a736175, Offset: 0x5c9
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace mp_sat_avalon_q1_ob_contract_mystery_cargo_cs
// Params 0, eflags: 0x4
// Checksum 0xf48b299, Offset: 0x5da
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace mp_sat_avalon_q1_ob_contract_mystery_cargo_cs
// Params 2
// Checksum 0xbc0aa605, Offset: 0x5eb
// Size: 0x8c
function main( unused, unused2 )
{
    if ( utility::flag_exist( "mp_sat_avalon_q1_ob_contract_mystery_cargo_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "mp_sat_avalon_q1_ob_contract_mystery_cargo_cs" ) )
    {
        return;
    }
    
    activity_common::function_e1df676808c1d1e3( &function_4cd78e661617f3 );
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "mp_sat_avalon_q1_ob_contract_mystery_cargo_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "mp_sat_avalon_q1_ob_contract_mystery_cargo_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace mp_sat_avalon_q1_ob_contract_mystery_cargo_cs
// Params 3, eflags: 0x4
// Checksum 0x8cca0656, Offset: 0x67f
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "mp_sat_avalon_q1_ob_contract_mystery_cargo_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "mp_sat_avalon_q1_ob_contract_mystery_cargo_cs" );
}

// Namespace mp_sat_avalon_q1_ob_contract_mystery_cargo_cs
// Params 3, eflags: 0x4
// Checksum 0x5c903d63, Offset: 0x6f9
// Size: 0xaf4
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_mystery_cargo_cs";
    fe [[ f ]]( s, "MYSTERY_CARGO_GOLF", cf, ( -34326, 32088.5, 1692 ), ( 0, 56.61, 0 ), "activity_nexus_instance_joiner", "MYSTERY_CARGO_GOLF", undefined, undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_mystery_cargo_cs";
    s._size_max = ( 1660, 1248, 988 );
    s._size_min = ( 958, 1200, 50 );
    s.var_5afd49978f924648 = "1";
    s.var_a8568d8e0b0b6076 = "1";
    s.var_3f3960eb7318312d = "1";
    s.default_goal_radius = "-1";
    s.height = 128;
    s.length = "128";
    s.script_stealthgroup = "-1";
    s.script_string = "enc_mystery_cargo_helicopter2";
    s.var_95e2cee7aca5aaae = "1";
    s.width = "128";
    fe [[ f ]]( s, "MYSTERY_CARGO_GOLF", cf, ( -29609.7, 37162.8, 1779.54 ), ( 0, 230, 0 ), "MYSTERY_CARGO_GOLF2", undefined, "noent_volume_ai_encounter_cs", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_mystery_cargo_cs";
    s.activity_bundle = "ob_contract_activitydefinition_mystery_cargo";
    s.name = "MYSTERY_CARGO_GOLF";
    fe [[ f ]]( s, "MYSTERY_CARGO_GOLF", cf, ( -30317, 38213, 1715 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_mystery_cargo_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "mystery_cargo_vtol1";
    s.variantname = "ai_encounter_spawnpoint";
    s.var_4501e0172e168ddf = "GOLF_MYSTERYCARGO_VTOL_01";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "MYSTERY_CARGO_GOLF", cf, ( -31377.1, 38584, 1826.82 ), ( 0, 324.01, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_mystery_cargo_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "mystery_cargo_vtol2";
    s.variantname = "ai_encounter_spawnpoint";
    s.var_4501e0172e168ddf = "GOLF_MYSTERYCARGO_VTOL_02";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "MYSTERY_CARGO_GOLF", cf, ( -30846.8, 36495, 1857.82 ), ( 0, 74.41, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_mystery_cargo_cs";
    s._size_max = ( 1248, 954, 988 );
    s._size_min = ( 782, 1200, 50 );
    s.var_5afd49978f924648 = "1";
    s.var_a8568d8e0b0b6076 = "1";
    s.var_3f3960eb7318312d = "1";
    s.default_goal_radius = "-1";
    s.height = 128;
    s.length = "128";
    s.script_stealthgroup = "-1";
    s.script_string = "enc_mystery_cargo_helicopter1";
    s.var_95e2cee7aca5aaae = "1";
    s.width = "128";
    fe [[ f ]]( s, "MYSTERY_CARGO_GOLF", cf, ( -31076.7, 38787.8, 1778.54 ), ( 0, 230, 0 ), "MYSTERY_CARGO_GOLF1", undefined, "noent_volume_ai_encounter_cs", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_mystery_cargo_cs";
    fe [[ f ]]( s, "MYSTERY_CARGO_SUBURBS", cf, ( -26547.5, 48604.5, 1733 ), ( 0, 82.92, 0 ), "activity_nexus_instance_joiner", "MYSTERY_CARGO_SUBURBS", undefined, undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_mystery_cargo_cs";
    s._size_max = ( 1346, 1848, 848 );
    s._size_min = ( 1154, 1354, 50 );
    s.var_5afd49978f924648 = "1";
    s.var_a8568d8e0b0b6076 = "1";
    s.var_3f3960eb7318312d = "1";
    s.default_goal_radius = "-1";
    s.height = 128;
    s.length = "128";
    s.script_stealthgroup = "-1";
    s.script_string = "enc_mystery_cargo_helicopter2";
    s.var_95e2cee7aca5aaae = "1";
    s.width = "128";
    fe [[ f ]]( s, "MYSTERY_CARGO_SUBURBS", cf, ( -14992.7, 47881.2, 551.54 ), ( 0, 177.4, 0 ), "MYSTERY_CARGO_SUBURBS2", undefined, "noent_volume_ai_encounter_cs", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_mystery_cargo_cs";
    s.activity_bundle = "ob_contract_activitydefinition_mystery_cargo";
    s.name = "MYSTERY_CARGO_SUBURBS";
    fe [[ f ]]( s, "MYSTERY_CARGO_SUBURBS", cf, ( -13826, 47054, 562 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_mystery_cargo_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "mystery_cargo_vtol1";
    s.variantname = "ai_encounter_spawnpoint";
    s.var_4501e0172e168ddf = "SUBURBS_MYSTERYCARGO_VTOL_01";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "MYSTERY_CARGO_SUBURBS", cf, ( -13251.1, 48124.5, 562.82 ), ( 0, 239.01, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_mystery_cargo_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "mystery_cargo_vtol2";
    s.variantname = "ai_encounter_spawnpoint";
    s.var_4501e0172e168ddf = "SUBURBS_MYSTERYCARGO_VTOL_02";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "MYSTERY_CARGO_SUBURBS", cf, ( -14805.3, 47431.3, 562.82 ), ( 0, 318.81, 0 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_mystery_cargo_cs";
    s._size_max = ( 1650, 1848, 848 );
    s._size_min = ( 772, 1354, 50 );
    s.var_5afd49978f924648 = "1";
    s.var_a8568d8e0b0b6076 = "1";
    s.var_3f3960eb7318312d = "1";
    s.default_goal_radius = "-1";
    s.height = 128;
    s.length = "128";
    s.script_stealthgroup = "-1";
    s.script_string = "enc_mystery_cargo_helicopter1";
    s.var_95e2cee7aca5aaae = "1";
    s.width = "128";
    fe [[ f ]]( s, "MYSTERY_CARGO_SUBURBS", cf, ( -12163.7, 47768.2, 550.54 ), ( 0, 177.6, 0 ), "MYSTERY_CARGO_SUBURBS1", undefined, "noent_volume_ai_encounter_cs", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace mp_sat_avalon_q1_ob_contract_mystery_cargo_cs
// Params 0, eflags: 0x4
// Checksum 0xab8e1248, Offset: 0x11f5
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace mp_sat_avalon_q1_ob_contract_mystery_cargo_cs
// Params 0
// Checksum 0x4e99db1b, Offset: 0x11ff
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "mp_sat_avalon_q1_ob_contract_mystery_cargo_cs" );
}

// Namespace mp_sat_avalon_q1_ob_contract_mystery_cargo_cs
// Params 0
// Checksum 0x6db7ac3b, Offset: 0x1215
// Size: 0x66
function function_4cd78e661617f3()
{
    activityinfostruct = {};
    activityinfostruct.name = "REV_OB_MYSTERY_CARGO";
    activityinfostruct.scriptbundle = "ob_contract_activitydefinition_mystery_cargo";
    activityinfostruct.mainfunction = &main;
    activityinfostruct.var_934f068483ae4ddb = &function_d4323822d7042e5a;
    activityinfostruct.metadatafunction = &function_d9dd7965c51c95d1;
    return activityinfostruct;
}

// Namespace mp_sat_avalon_q1_ob_contract_mystery_cargo_cs
// Params 4
// Checksum 0x3d70ad57, Offset: 0x1284
// Size: 0x71
function function_d4323822d7042e5a( var_4312b79c960726b6, fe, us, cf = "mp_sat_avalon_q1_ob_contract_mystery_cargo_cs" )
{
    switch ( var_4312b79c960726b6 )
    {
        case #"hash_19a0a9847981af5e":
            function_111d668b1b284ed6( fe, us, cf );
            break;
        case #"hash_41216a052eef603c":
            function_d399df0758cd084( fe, us, cf );
            break;
    }
}

// Namespace mp_sat_avalon_q1_ob_contract_mystery_cargo_cs
// Params 3
// Checksum 0xe92c42e9, Offset: 0x12fd
// Size: 0x6a7
function function_111d668b1b284ed6( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_mystery_cargo_cs";
    s.name = "cargo_container";
    fe [[ f ]]( s, "MYSTERY_CARGO_GOLF", cf, ( -30295, 38201, 1715 ), ( 0, 88.36, 0 ), "activity_nexus_variant", undefined, "MYSTERY_CARGO_GOLF", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_mystery_cargo_cs";
    s.groupid = "reinforcement_spawn_point_01";
    s.ishelistruct = 1;
    s.script_accel = "350";
    fe [[ f ]]( s, "MYSTERY_CARGO_GOLF", cf, ( -31407.8, 38699.9, 2446.42 ), ( 0, 329.62, 0 ), "GOLF_MYSTERYCARGO_VTOL_01", "cspf_3_auto3378833844094279436", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_mystery_cargo_cs";
    s.groupid = "reinforcement_spawn_point_01";
    s.ishelistruct = 1;
    s.name = "script_struct_heli";
    fe [[ f ]]( s, "MYSTERY_CARGO_GOLF", cf, ( -23041.8, 50123.3, 4860.6 ), ( 359.47, 358.73, 0.5 ), "cspf_3_auto537692158296776830", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_mystery_cargo_cs";
    s.groupid = "reinforcement_spawn_point_01";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MYSTERY_CARGO_GOLF", cf, ( -41230.3, 33282.1, 5570.7 ), ( 0, 19.04, 0 ), undefined, "cspf_3_auto13918011251922956337", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150, 1 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_mystery_cargo_cs";
    s.groupid = "reinforcement_spawn_point_01";
    s.ishelistruct = 1;
    s.name = "script_struct_heli";
    fe [[ f ]]( s, "MYSTERY_CARGO_GOLF", cf, ( -26960.9, 40115.1, 3196.72 ), ( 359.47, 358.73, 0.5 ), "cspf_3_auto3378833844094279436", "cspf_3_auto537692158296776830", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_mystery_cargo_cs";
    s.groupid = "reinforcement_spawn_point_01";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MYSTERY_CARGO_GOLF", cf, ( -35342.3, 36258.2, 4174.54 ), ( 0, 290.92, 0 ), "cspf_3_auto13918011251922956337", "GOLF_MYSTERYCARGO_VTOL_01", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_mystery_cargo_cs";
    s.groupid = "reinforcement_spawn_point_02";
    s.ishelistruct = 1;
    s.script_accel = "350";
    fe [[ f ]]( s, "MYSTERY_CARGO_GOLF", cf, ( -30944.7, 36425.8, 2477.42 ), ( 0, 80.02, 0 ), "GOLF_MYSTERYCARGO_VTOL_02", "cspf_3_auto17597941135660927320", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_mystery_cargo_cs";
    s.groupid = "reinforcement_spawn_point_02";
    s.ishelistruct = 1;
    s.name = "script_struct_heli";
    fe [[ f ]]( s, "MYSTERY_CARGO_GOLF", cf, ( -44567.8, 40285.2, 4860.6 ), ( 359.47, 109.13, 0.5 ), "cspf_3_auto371809451914167357", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_mystery_cargo_cs";
    s.groupid = "reinforcement_spawn_point_02";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MYSTERY_CARGO_GOLF", cf, ( -22442.8, 29107.8, 5570.7 ), ( 0, 129.44, 0 ), undefined, "cspf_3_auto10760704316705680718", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150, 1 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_mystery_cargo_cs";
    s.groupid = "reinforcement_spawn_point_02";
    s.ishelistruct = 1;
    s.name = "script_struct_heli";
    fe [[ f ]]( s, "MYSTERY_CARGO_GOLF", cf, ( -33821.2, 40100.5, 3196.72 ), ( 359.47, 109.13, 0.5 ), "cspf_3_auto17597941135660927320", "cspf_3_auto371809451914167357", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_mystery_cargo_cs";
    s.groupid = "reinforcement_spawn_point_02";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MYSTERY_CARGO_GOLF", cf, ( -27284.7, 33589.2, 4174.54 ), ( 0, 41.32, 0 ), "cspf_3_auto10760704316705680718", "GOLF_MYSTERYCARGO_VTOL_02", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_mystery_cargo_cs";
    s.name = "ability_crate";
    fe [[ f ]]( s, "MYSTERY_CARGO_GOLF", cf, ( -30299.8, 38223.6, 1729.76 ), ( 0, 358.09, 0 ), "ability_case_MYSTERY_CARGO_GOLF", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_sat_avalon_q1_ob_contract_mystery_cargo_cs
// Params 3
// Checksum 0xd419b7df, Offset: 0x19ac
// Size: 0x663
function function_d399df0758cd084( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_mystery_cargo_cs";
    s.name = "cargo_container";
    fe [[ f ]]( s, "MYSTERY_CARGO_SUBURBS", cf, ( -13815, 47044, 562 ), ( 0, 172.18, 0 ), "activity_nexus_variant", undefined, "MYSTERY_CARGO_SUBURBS", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_mystery_cargo_cs";
    s.groupid = "reinforcement_spawn_point_01";
    s.ishelistruct = 1;
    s.script_accel = "350";
    fe [[ f ]]( s, "MYSTERY_CARGO_SUBURBS", cf, ( -13138.3, 48165.1, 1182.42 ), ( 0, 244.62, 0 ), "SUBURBS_MYSTERYCARGO_VTOL_01", "cspf_4_auto3378833844094279436", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_mystery_cargo_cs";
    s.groupid = "reinforcement_spawn_point_01";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MYSTERY_CARGO_SUBURBS", cf, ( -6346.79, 43668.6, 2440.6 ), ( 359.47, 218.73, 0.5 ), "cspf_4_auto537692158296776830", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_mystery_cargo_cs";
    s.groupid = "reinforcement_spawn_point_01";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MYSTERY_CARGO_SUBURBS", cf, ( -5624.24, 53757.9, 3838.7 ), ( 0, 239.04, 0 ), undefined, "cspf_4_auto13918011251922956337", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150, 1 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_mystery_cargo_cs";
    s.groupid = "reinforcement_spawn_point_01";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MYSTERY_CARGO_SUBURBS", cf, ( -11232, 45396.9, 1696.72 ), ( 359.47, 218.73, 0.5 ), "cspf_4_auto3378833844094279436", "cspf_4_auto537692158296776830", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_mystery_cargo_cs";
    s.groupid = "reinforcement_spawn_point_01";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MYSTERY_CARGO_SUBURBS", cf, ( -11103.8, 49944.8, 2138.54 ), ( 0, 150.92, 0 ), "cspf_4_auto13918011251922956337", "SUBURBS_MYSTERYCARGO_VTOL_01", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_mystery_cargo_cs";
    s.groupid = "reinforcement_spawn_point_02";
    s.ishelistruct = 1;
    s.script_accel = "350";
    fe [[ f ]]( s, "MYSTERY_CARGO_SUBURBS", cf, ( -14825.3, 47549.5, 1182.42 ), ( 0, 324.42, 0 ), "SUBURBS_MYSTERYCARGO_VTOL_02", "cspf_4_auto8790027982616585474", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_mystery_cargo_cs";
    s.groupid = "reinforcement_spawn_point_02";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MYSTERY_CARGO_SUBURBS", cf, ( -9197.15, 53437.4, 2440.6 ), ( 359.47, 298.53, 0.5 ), "cspf_4_auto11829126741094269581", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_mystery_cargo_cs";
    s.groupid = "reinforcement_spawn_point_02";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MYSTERY_CARGO_SUBURBS", cf, ( -18999, 55935.2, 3838.7 ), ( 0, 318.84, 0 ), undefined, "cspf_4_auto11433102830741435057", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150, 1 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_mystery_cargo_cs";
    s.groupid = "reinforcement_spawn_point_02";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MYSTERY_CARGO_SUBURBS", cf, ( -11763.2, 48935.5, 1696.72 ), ( 359.47, 298.53, 0.5 ), "cspf_4_auto8790027982616585474", "cspf_4_auto11829126741094269581", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_mystery_cargo_cs";
    s.groupid = "reinforcement_spawn_point_02";
    s.ishelistruct = 1;
    fe [[ f ]]( s, "MYSTERY_CARGO_SUBURBS", cf, ( -16216.5, 49867, 2138.54 ), ( 0, 230.72, 0 ), "cspf_4_auto11433102830741435057", "SUBURBS_MYSTERYCARGO_VTOL_02", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q1_ob_contract_mystery_cargo_cs";
    s.name = "ability_crate";
    fe [[ f ]]( s, "MYSTERY_CARGO_SUBURBS", cf, ( -13838.2, 47041.6, 576.3 ), ( 0, 263.21, 0 ), "ability_case_MYSTERY_CARGO_SUBURBS", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_sat_avalon_q1_ob_contract_mystery_cargo_cs
// Params 0
// Checksum 0xcd3cd8c3, Offset: 0x2017
// Size: 0x143
function function_d9dd7965c51c95d1()
{
    activityinstances = [];
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "ob_contract_activitydefinition_mystery_cargo";
    var_881289d7987bc770.cf = "mp_sat_avalon_q1_ob_contract_mystery_cargo_cs";
    var_881289d7987bc770.scriptstructorigin = ( -30317, 38213, 1715 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [];
    var_881289d7987bc770.var_31ce4477e3543d24 = [];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [];
    var_881289d7987bc770.locationradius = [];
    activityinstances[ "MYSTERY_CARGO_GOLF" ] = var_881289d7987bc770;
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "ob_contract_activitydefinition_mystery_cargo";
    var_881289d7987bc770.cf = "mp_sat_avalon_q1_ob_contract_mystery_cargo_cs";
    var_881289d7987bc770.scriptstructorigin = ( -13826, 47054, 562 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [];
    var_881289d7987bc770.var_31ce4477e3543d24 = [];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [];
    var_881289d7987bc770.locationradius = [];
    activityinstances[ "MYSTERY_CARGO_SUBURBS" ] = var_881289d7987bc770;
    return activityinstances;
}

