// script_66e5c4f571d3fc01  (hash_66e5c4f571d3fc01.gscc) (size: 15914 Bytes / 0x3e2a / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xcd64afdd (3445927901)
// size ...... 15914 (0x3e2a)
// includes .. 4   (offset: 0x3552)
// strings ... 34  (offset: 0x3572)
// dev strs .. 0   (offset: 0x3e2a)
// exports ... 14  (offset: 0x3026)
// cseg ...... 0x2df + 0x2d47 (0x3026)
// imports ... 27  (offset: 0x3256)
// animtree1 . 0   (offset: 0x3e2a)
// animtree2 . 0   (offset: 0x3e2a)
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace mp_sat_avalon_q2_ob_activity_abom_hunt_cs;

// Namespace mp_sat_avalon_q2_ob_activity_abom_hunt_cs
// Params 0, eflags: 0x5
// Checksum 0x1263c24e, Offset: 0x2fd
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"mp_sat_avalon_q2_ob_activity_abom_hunt_cs", #"activity_common", &function_b39ecd3d51489472, undefined );
}

// Namespace mp_sat_avalon_q2_ob_activity_abom_hunt_cs
// Params 0, eflags: 0x4
// Checksum 0x9e62d967, Offset: 0x326
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace mp_sat_avalon_q2_ob_activity_abom_hunt_cs
// Params 0, eflags: 0x4
// Checksum 0x1b590a8b, Offset: 0x337
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace mp_sat_avalon_q2_ob_activity_abom_hunt_cs
// Params 2
// Checksum 0xd4962066, Offset: 0x348
// Size: 0x8c
function main( unused, unused2 )
{
    if ( utility::flag_exist( "mp_sat_avalon_q2_ob_activity_abom_hunt_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "mp_sat_avalon_q2_ob_activity_abom_hunt_cs" ) )
    {
        return;
    }
    
    activity_common::function_e1df676808c1d1e3( &function_4cd78e661617f3 );
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "mp_sat_avalon_q2_ob_activity_abom_hunt_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "mp_sat_avalon_q2_ob_activity_abom_hunt_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace mp_sat_avalon_q2_ob_activity_abom_hunt_cs
// Params 3, eflags: 0x4
// Checksum 0x98dbbe44, Offset: 0x3dc
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "mp_sat_avalon_q2_ob_activity_abom_hunt_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "mp_sat_avalon_q2_ob_activity_abom_hunt_cs" );
}

// Namespace mp_sat_avalon_q2_ob_activity_abom_hunt_cs
// Params 3, eflags: 0x4
// Checksum 0xcc700f49, Offset: 0x456
// Size: 0xd0a
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_abom_hunt_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "500";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "abom_hunt_boss";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "ACTIVITY_ABOM_HUNT", cf, ( 48819.4, 21606.1, 616.51 ), ( 0, 100.6, 0 ), undefined, undefined, "boss_spawn", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_abom_hunt_cs";
    s.activity_bundle = "sat_activity_definition_abom_hunt";
    s.name = "ACTIVITY_ABOM_HUNT";
    fe [[ f ]]( s, "ACTIVITY_ABOM_HUNT", cf, ( 60325.6, 34183.3, 407.03 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_abom_hunt_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "500";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "abom_hunt_boss";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "ACTIVITY_ABOM_HUNT", cf, ( 17210.8, -9781.52, 3367.18 ), ( 0, 158.52, 0 ), undefined, undefined, "boss_spawn", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_abom_hunt_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "500";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "abom_hunt_boss";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "ACTIVITY_ABOM_HUNT", cf, ( -13108.9, 30705.3, 599.9 ), ( 0, 301.88, 0 ), undefined, undefined, "boss_spawn", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_abom_hunt_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "500";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "abom_hunt_boss";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "ACTIVITY_ABOM_HUNT", cf, ( -46704.3, 21764.3, 719.86 ), ( 0, 325.44, 0 ), undefined, undefined, "boss_spawn", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_abom_hunt_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "500";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "abom_hunt_boss";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "ACTIVITY_ABOM_HUNT", cf, ( -37775.2, -44923.7, 514.76 ), ( 0, 340.43, 0 ), undefined, undefined, "boss_spawn", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_abom_hunt_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "500";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "abom_hunt_boss";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "ACTIVITY_ABOM_HUNT", cf, ( 42387.5, 20608.3, 558.03 ), ( 0, 116.43, 0 ), undefined, undefined, "boss_spawn", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_abom_hunt_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "500";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "abom_hunt_boss";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "ACTIVITY_ABOM_HUNT", cf, ( 54540.9, 23159.7, 512.2 ), ( 0, 253.67, 0 ), undefined, undefined, "boss_spawn", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_abom_hunt_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "500";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "abom_hunt_boss";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "ACTIVITY_ABOM_HUNT", cf, ( 11226.7, -22533.6, 3486.36 ), ( 0, 330.66, 0 ), undefined, undefined, "boss_spawn", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_abom_hunt_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "500";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "abom_hunt_boss";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "ACTIVITY_ABOM_HUNT", cf, ( 41046.1, -37208.3, 2049.19 ), ( 0, 300.93, 0 ), undefined, undefined, "boss_spawn", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_abom_hunt_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "500";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "abom_hunt_boss";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "ACTIVITY_ABOM_HUNT", cf, ( -51551.6, 12507.5, 992.93 ), ( 0, 36.62, 0 ), undefined, undefined, "boss_spawn", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_abom_hunt_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "500";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "abom_hunt_boss";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "ACTIVITY_ABOM_HUNT", cf, ( -5561.73, 21840.5, 560.1 ), ( 0, 309.12, 0 ), undefined, undefined, "boss_spawn", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_abom_hunt_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "500";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "abom_hunt_boss";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "ACTIVITY_ABOM_HUNT", cf, ( -21556.9, -47952, 199.32 ), ( 0, 93.05, 0 ), undefined, undefined, "boss_spawn", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_abom_hunt_cs";
    s.activity_bundle = "sat_activity_definition_abom_hunt";
    s.name = "ACTIVITY_ABOM_HUNT_STRIKE_BOSS";
    fe [[ f ]]( s, "ACTIVITY_ABOM_HUNT_STRIKE_BOSS", cf, ( 59063.8, 56860.8, 277.34 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_abom_hunt_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "500";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "abom_hunt_boss";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "ACTIVITY_ABOM_HUNT_STRIKE_BOSS", cf, ( 10787.1, 52195.9, 698.42 ), ( 0, 275.67, 0 ), undefined, undefined, "boss_spawn", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_abom_hunt_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "500";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "abom_hunt_boss";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "ACTIVITY_ABOM_HUNT_STRIKE_BOSS", cf, ( 16885.7, 43813.9, 809.8 ), ( 0, 249.67, 0 ), undefined, undefined, "boss_spawn", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace mp_sat_avalon_q2_ob_activity_abom_hunt_cs
// Params 0, eflags: 0x4
// Checksum 0xc312942b, Offset: 0x1168
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace mp_sat_avalon_q2_ob_activity_abom_hunt_cs
// Params 0
// Checksum 0x5a886309, Offset: 0x1172
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "mp_sat_avalon_q2_ob_activity_abom_hunt_cs" );
}

// Namespace mp_sat_avalon_q2_ob_activity_abom_hunt_cs
// Params 0
// Checksum 0x37a6001b, Offset: 0x1188
// Size: 0x66
function function_4cd78e661617f3()
{
    activityinfostruct = {};
    activityinfostruct.name = "REV_OB_ABOM_HUNT";
    activityinfostruct.scriptbundle = "sat_activity_definition_abom_hunt";
    activityinfostruct.mainfunction = &main;
    activityinfostruct.var_934f068483ae4ddb = &function_d4323822d7042e5a;
    activityinfostruct.metadatafunction = &function_d9dd7965c51c95d1;
    return activityinfostruct;
}

// Namespace mp_sat_avalon_q2_ob_activity_abom_hunt_cs
// Params 4
// Checksum 0xcd5e612e, Offset: 0x11f7
// Size: 0x71
function function_d4323822d7042e5a( var_4312b79c960726b6, fe, us, cf = "mp_sat_avalon_q2_ob_activity_abom_hunt_cs" )
{
    switch ( var_4312b79c960726b6 )
    {
        case #"hash_1e3c70341e6d1eba":
            function_6b9f462de0ce11c2( fe, us, cf );
            break;
        case #"hash_1608816526c7bd8f":
            function_ee637df4441a6c07( fe, us, cf );
            break;
    }
}

// Namespace mp_sat_avalon_q2_ob_activity_abom_hunt_cs
// Params 3
// Checksum 0xd7d8fdc7, Offset: 0x1270
// Size: 0x179a
function function_6b9f462de0ce11c2( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_abom_hunt_cs";
    s.groupid = "abom_hunt_colosseum";
    s.name = "joiner_deadbody";
    fe [[ f ]]( s, "ACTIVITY_ABOM_HUNT", cf, ( 48748.6, 22000.6, 601 ), ( 0, 97, 0 ), undefined, undefined, undefined, "colosseum_return", "cspf_4_1", ( 0, 0, 0 ), ( 0, 0, 0 ), 2000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_abom_hunt_cs";
    fe [[ f ]]( s, "ACTIVITY_ABOM_HUNT", cf, ( 10518.5, 3281.18, 5101.19 ), ( 0, 0, 0 ), "ACTIVITY_ABOM_HUNT", undefined, undefined, "cspf_4_1", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_abom_hunt_cs";
    s.groupid = "abom_hunt_casino";
    s.name = "joiner_deadbody";
    fe [[ f ]]( s, "ACTIVITY_ABOM_HUNT", cf, ( -12706.8, 30101.6, 600.55 ), ( 0, 279, 0 ), undefined, undefined, undefined, "casino_return", "cspf_4_1", ( 0, 0, 0 ), ( 0, 0, 0 ), 2000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_abom_hunt_cs";
    s.groupid = "abom_hunt_heliport";
    s.name = "joiner_deadbody";
    fe [[ f ]]( s, "ACTIVITY_ABOM_HUNT", cf, ( 16695.7, -9569.61, 3482.33 ), ( 0, 156, 0 ), undefined, undefined, undefined, "heliport_return", "cspf_4_1", ( 0, 0, 0 ), ( 0, 0, 0 ), 2000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_abom_hunt_cs";
    s.groupid = "abom_hunt_stadium";
    s.name = "joiner_deadbody";
    fe [[ f ]]( s, "ACTIVITY_ABOM_HUNT", cf, ( -45985.8, 21159.9, 767 ), ( 0, 305, 0 ), undefined, undefined, undefined, "stadium_return", "cspf_4_1", ( 0, 0, 0 ), ( 0, 0, 0 ), 2000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_abom_hunt_cs";
    s.groupid = "abom_hunt_fort";
    s.name = "joiner_deadbody";
    fe [[ f ]]( s, "ACTIVITY_ABOM_HUNT", cf, ( -36853, -45273.6, 511.97 ), ( 0, 105.95, 0 ), undefined, undefined, undefined, "fort_return", "cspf_4_1", ( 0, 0, 0 ), ( 0, 0, 0 ), 2000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_abom_hunt_cs";
    s.groupid = "abom_hunt_heliport";
    s.name = "joiner_deadbody";
    fe [[ f ]]( s, "ACTIVITY_ABOM_HUNT", cf, ( 11936.2, -23038.4, 3702.24 ), ( 0, 161, 0 ), undefined, undefined, undefined, "heliport_return", "cspf_4_1", ( 0, 0, 0 ), ( 0, 0, 0 ), 2000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_abom_hunt_cs";
    s.groupid = "abom_hunt_colosseum";
    s.name = "joiner_deadbody";
    fe [[ f ]]( s, "ACTIVITY_ABOM_HUNT", cf, ( 42122.7, 21216.2, 641.78 ), ( 0, 315.5, 0 ), undefined, undefined, undefined, "colosseum_return", "cspf_4_1", ( 0, 0, 0 ), ( 0, 0, 0 ), 2000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_abom_hunt_cs";
    s.groupid = "abom_hunt_colosseum";
    s.name = "joiner_deadbody";
    fe [[ f ]]( s, "ACTIVITY_ABOM_HUNT", cf, ( 54340.5, 22402.6, 519 ), ( 0, 45, 0 ), undefined, undefined, undefined, "colosseum_return", "cspf_4_1", ( 0, 0, 0 ), ( 0, 0, 0 ), 2000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_abom_hunt_cs";
    s.groupid = "abom_hunt_shipyard";
    s.name = "joiner_deadbody";
    fe [[ f ]]( s, "ACTIVITY_ABOM_HUNT", cf, ( 41287.4, -37873.7, 2089.36 ), ( 0, 310.06, 0 ), undefined, undefined, undefined, "shipyard_return", "cspf_4_1", ( 0, 0, 0 ), ( 0, 0, 0 ), 2000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_abom_hunt_cs";
    s.groupid = "abom_hunt_stadium";
    s.name = "joiner_deadbody";
    fe [[ f ]]( s, "ACTIVITY_ABOM_HUNT", cf, ( -51041.5, 12862.6, 922.94 ), ( 0, 303.77, 0 ), undefined, undefined, undefined, "stadium_return", "cspf_4_1", ( 0, 0, 0 ), ( 0, 0, 0 ), 2000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_abom_hunt_cs";
    s.groupid = "abom_hunt_casino";
    s.name = "joiner_deadbody";
    fe [[ f ]]( s, "ACTIVITY_ABOM_HUNT", cf, ( -5127.24, 21313.2, 566 ), ( 0, 130, 0 ), undefined, undefined, undefined, "casino_return", "cspf_4_1", ( 0, 0, 0 ), ( 0, 0, 0 ), 2000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_abom_hunt_cs";
    s.groupid = "abom_hunt_fort";
    s.name = "joiner_deadbody";
    fe [[ f ]]( s, "ACTIVITY_ABOM_HUNT", cf, ( -21432.1, -47399.5, 358.5 ), ( 0, 108.5, 0 ), undefined, undefined, undefined, "fort_return", "cspf_4_1", ( 0, 0, 0 ), ( 0, 0, 0 ), 2000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_abom_hunt_cs";
    s.groupid = "abom_hunt_colosseum";
    s.name = "return_point";
    fe [[ f ]]( s, "ACTIVITY_ABOM_HUNT", cf, ( 54272.9, 21986, 519 ), ( 0, 0, 0 ), undefined, undefined, "return_point", undefined, "colosseum_return", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_abom_hunt_cs";
    s.groupid = "abom_hunt_colosseum";
    s.name = "return_point";
    fe [[ f ]]( s, "ACTIVITY_ABOM_HUNT", cf, ( 48708.4, 19930.7, 364.98 ), ( 0, 0, 0 ), undefined, undefined, "return_point", undefined, "colosseum_return", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_abom_hunt_cs";
    s.groupid = "abom_hunt_colosseum";
    s.name = "return_point";
    fe [[ f ]]( s, "ACTIVITY_ABOM_HUNT", cf, ( 43147.7, 19965.8, 486.37 ), ( 0, 0, 0 ), undefined, undefined, "return_point", undefined, "colosseum_return", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_abom_hunt_cs";
    s.groupid = "abom_hunt_colosseum";
    s.name = "return_point";
    fe [[ f ]]( s, "ACTIVITY_ABOM_HUNT", cf, ( 45364.3, 28169.4, 835.91 ), ( 0, 0, 0 ), undefined, undefined, "return_point", undefined, "colosseum_return", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_abom_hunt_cs";
    s.groupid = "abom_hunt_colosseum";
    s.name = "return_point";
    fe [[ f ]]( s, "ACTIVITY_ABOM_HUNT", cf, ( 53727.9, 27608.9, 856.45 ), ( 0, 0, 0 ), undefined, undefined, "return_point", undefined, "colosseum_return", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_abom_hunt_cs";
    s.groupid = "abom_hunt_casino";
    s.name = "return_point";
    fe [[ f ]]( s, "ACTIVITY_ABOM_HUNT", cf, ( -5579.61, 21866.3, 560.1 ), ( 0, 0, 0 ), undefined, undefined, "return_point", undefined, "casino_return", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_abom_hunt_cs";
    s.groupid = "abom_hunt_casino";
    s.name = "return_point";
    fe [[ f ]]( s, "ACTIVITY_ABOM_HUNT", cf, ( -9043.38, 19289.8, 560 ), ( 0, 0, 0 ), undefined, undefined, "return_point", undefined, "casino_return", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_abom_hunt_cs";
    s.groupid = "abom_hunt_casino";
    s.name = "return_point";
    fe [[ f ]]( s, "ACTIVITY_ABOM_HUNT", cf, ( -16942.1, 21067.1, 1435.55 ), ( 0, 0, 0 ), undefined, undefined, "return_point", undefined, "casino_return", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_abom_hunt_cs";
    s.groupid = "abom_hunt_casino";
    s.name = "return_point";
    fe [[ f ]]( s, "ACTIVITY_ABOM_HUNT", cf, ( -12251.2, 33560.4, 826.52 ), ( 0, 0, 0 ), undefined, undefined, "return_point", undefined, "casino_return", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_abom_hunt_cs";
    s.groupid = "abom_hunt_casino";
    s.name = "return_point";
    fe [[ f ]]( s, "ACTIVITY_ABOM_HUNT", cf, ( -5908.65, 29799.7, 459.87 ), ( 0, 0, 0 ), undefined, undefined, "return_point", undefined, "casino_return", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_abom_hunt_cs";
    s.groupid = "abom_hunt_casino";
    s.name = "return_point";
    fe [[ f ]]( s, "ACTIVITY_ABOM_HUNT", cf, ( -15943, 26342.7, 1017.77 ), ( 0, 0, 0 ), undefined, undefined, "return_point", undefined, "casino_return", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_abom_hunt_cs";
    s.groupid = "abom_hunt_fort";
    s.name = "return_point";
    fe [[ f ]]( s, "ACTIVITY_ABOM_HUNT", cf, ( -32804, -44020, 416.08 ), ( 0, 0, 0 ), undefined, undefined, "return_point", undefined, "fort_return", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_abom_hunt_cs";
    s.groupid = "abom_hunt_fort";
    s.name = "return_point";
    fe [[ f ]]( s, "ACTIVITY_ABOM_HUNT", cf, ( -21849.6, -46404.6, 384.74 ), ( 0, 0, 0 ), undefined, undefined, "return_point", undefined, "fort_return", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_abom_hunt_cs";
    s.groupid = "abom_hunt_fort";
    s.name = "return_point";
    fe [[ f ]]( s, "ACTIVITY_ABOM_HUNT", cf, ( -23740.2, -33771.3, 634.54 ), ( 0, 0, 0 ), undefined, undefined, "return_point", undefined, "fort_return", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_abom_hunt_cs";
    s.groupid = "abom_hunt_fort";
    s.name = "return_point";
    fe [[ f ]]( s, "ACTIVITY_ABOM_HUNT", cf, ( -28636.9, -35557, 952 ), ( 0, 0, 0 ), undefined, undefined, "return_point", undefined, "fort_return", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_abom_hunt_cs";
    s.groupid = "abom_hunt_heliport";
    s.name = "return_point";
    fe [[ f ]]( s, "ACTIVITY_ABOM_HUNT", cf, ( 13680.3, -21982.8, 3467.81 ), ( 0, 0, 0 ), undefined, undefined, "return_point", undefined, "heliport_return", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_abom_hunt_cs";
    s.groupid = "abom_hunt_heliport";
    s.name = "return_point";
    fe [[ f ]]( s, "ACTIVITY_ABOM_HUNT", cf, ( 8405.28, -16152.1, 1527.97 ), ( 0, 0, 0 ), undefined, undefined, "return_point", undefined, "heliport_return", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_abom_hunt_cs";
    s.groupid = "abom_hunt_heliport";
    s.name = "return_point";
    fe [[ f ]]( s, "ACTIVITY_ABOM_HUNT", cf, ( 11257, -8793.6, 2114.45 ), ( 0, 0, 0 ), undefined, undefined, "return_point", undefined, "heliport_return", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_abom_hunt_cs";
    s.groupid = "abom_hunt_heliport";
    s.name = "return_point";
    fe [[ f ]]( s, "ACTIVITY_ABOM_HUNT", cf, ( 16070.2, -10664.3, 3385.94 ), ( 0, 0, 0 ), undefined, undefined, "return_point", undefined, "heliport_return", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_abom_hunt_cs";
    s.groupid = "abom_hunt_heliport";
    s.name = "return_point";
    fe [[ f ]]( s, "ACTIVITY_ABOM_HUNT", cf, ( 19483.8, -16701.2, 1214.61 ), ( 0, 0, 0 ), undefined, undefined, "return_point", undefined, "heliport_return", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_abom_hunt_cs";
    s.groupid = "abom_hunt_heliport";
    s.name = "return_point";
    fe [[ f ]]( s, "ACTIVITY_ABOM_HUNT", cf, ( 19312.8, -20561.8, 1019.86 ), ( 0, 0, 0 ), undefined, undefined, "return_point", undefined, "heliport_return", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_abom_hunt_cs";
    s.groupid = "abom_hunt_shipyard";
    s.name = "return_point";
    fe [[ f ]]( s, "ACTIVITY_ABOM_HUNT", cf, ( 34375.3, -44643.2, 1043.9 ), ( 0, 0, 0 ), undefined, undefined, "return_point", undefined, "shipyard_return", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_abom_hunt_cs";
    s.groupid = "abom_hunt_shipyard";
    s.name = "return_point";
    fe [[ f ]]( s, "ACTIVITY_ABOM_HUNT", cf, ( 32555.7, -40427.1, 1088.98 ), ( 0, 0, 0 ), undefined, undefined, "return_point", undefined, "shipyard_return", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_abom_hunt_cs";
    s.groupid = "abom_hunt_shipyard";
    s.name = "return_point";
    fe [[ f ]]( s, "ACTIVITY_ABOM_HUNT", cf, ( 34787.3, -33983, 626.26 ), ( 0, 0, 0 ), undefined, undefined, "return_point", undefined, "shipyard_return", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_abom_hunt_cs";
    s.groupid = "abom_hunt_shipyard";
    s.name = "return_point";
    fe [[ f ]]( s, "ACTIVITY_ABOM_HUNT", cf, ( 42784, -36771.9, 2117.29 ), ( 0, 0, 0 ), undefined, undefined, "return_point", undefined, "shipyard_return", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_abom_hunt_cs";
    s.groupid = "abom_hunt_shipyard";
    s.name = "return_point";
    fe [[ f ]]( s, "ACTIVITY_ABOM_HUNT", cf, ( 43352.1, -42211.3, 1268.36 ), ( 0, 0, 0 ), undefined, undefined, "return_point", undefined, "shipyard_return", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_abom_hunt_cs";
    s.groupid = "abom_hunt_shipyard";
    s.name = "return_point";
    fe [[ f ]]( s, "ACTIVITY_ABOM_HUNT", cf, ( 40920.4, -46732.6, 634.08 ), ( 0, 0, 0 ), undefined, undefined, "return_point", undefined, "shipyard_return", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_abom_hunt_cs";
    s.groupid = "abom_hunt_stadium";
    s.name = "return_point";
    fe [[ f ]]( s, "ACTIVITY_ABOM_HUNT", cf, ( -48069.6, 7764.61, 264 ), ( 0, 0, 0 ), undefined, undefined, "return_point", undefined, "stadium_return", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_abom_hunt_cs";
    s.groupid = "abom_hunt_stadium";
    s.name = "return_point";
    fe [[ f ]]( s, "ACTIVITY_ABOM_HUNT", cf, ( -37746.3, 7014.26, 35.92 ), ( 0, 0, 0 ), undefined, undefined, "return_point", undefined, "stadium_return", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_abom_hunt_cs";
    s.groupid = "abom_hunt_stadium";
    s.name = "return_point";
    fe [[ f ]]( s, "ACTIVITY_ABOM_HUNT", cf, ( -40623, 19705.6, 508.96 ), ( 0, 0, 0 ), undefined, undefined, "return_point", undefined, "stadium_return", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_abom_hunt_cs";
    s.groupid = "abom_hunt_stadium";
    s.name = "return_point";
    fe [[ f ]]( s, "ACTIVITY_ABOM_HUNT", cf, ( -48043.1, 18466, 465.63 ), ( 0, 0, 0 ), undefined, undefined, "return_point", undefined, "stadium_return", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_abom_hunt_cs";
    s.groupid = "abom_hunt_stadium";
    s.name = "return_point";
    fe [[ f ]]( s, "ACTIVITY_ABOM_HUNT", cf, ( -52303.8, 14212.9, 1011.57 ), ( 0, 0, 0 ), undefined, undefined, "return_point", undefined, "stadium_return", ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_sat_avalon_q2_ob_activity_abom_hunt_cs
// Params 3
// Checksum 0x40d06a39, Offset: 0x2a12
// Size: 0x4c8
function function_ee637df4441a6c07( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_abom_hunt_cs";
    fe [[ f ]]( s, "ACTIVITY_ABOM_HUNT_STRIKE_BOSS", cf, ( 10518.5, 47439.2, 5101.19 ), ( 0, 0, 0 ), "ACTIVITY_ABOM_HUNT_STRIKE_BOSS", undefined, undefined, "cspf_5_1", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_abom_hunt_cs";
    s.groupid = "abom_hunt_winery";
    s.name = "joiner_deadbody";
    fe [[ f ]]( s, "ACTIVITY_ABOM_HUNT_STRIKE_BOSS", cf, ( 10793.2, 51703.4, 635.05 ), ( 0, 105, 0 ), undefined, undefined, undefined, "winery_return", "cspf_5_1", ( 0, 0, 0 ), ( 0, 0, 0 ), 2000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_abom_hunt_cs";
    s.groupid = "abom_hunt_winery";
    s.name = "return_point";
    fe [[ f ]]( s, "ACTIVITY_ABOM_HUNT_STRIKE_BOSS", cf, ( 16351.7, 44595.1, 764.05 ), ( 0, 0, 0 ), undefined, undefined, "return_point", undefined, "winery_return", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_abom_hunt_cs";
    s.groupid = "abom_hunt_winery";
    s.name = "return_point";
    fe [[ f ]]( s, "ACTIVITY_ABOM_HUNT_STRIKE_BOSS", cf, ( 11264.3, 47106.9, 601.88 ), ( 0, 0, 0 ), undefined, undefined, "return_point", undefined, "winery_return", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_abom_hunt_cs";
    s.groupid = "abom_hunt_winery";
    s.name = "return_point";
    fe [[ f ]]( s, "ACTIVITY_ABOM_HUNT_STRIKE_BOSS", cf, ( 10305.9, 52489.2, 705.24 ), ( 0, 0, 0 ), undefined, undefined, "return_point", undefined, "winery_return", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_abom_hunt_cs";
    s.groupid = "abom_hunt_winery";
    s.name = "return_point";
    fe [[ f ]]( s, "ACTIVITY_ABOM_HUNT_STRIKE_BOSS", cf, ( 16803.3, 55797.7, 770.69 ), ( 0, 0, 0 ), undefined, undefined, "return_point", undefined, "winery_return", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_abom_hunt_cs";
    s.groupid = "abom_hunt_winery";
    s.name = "return_point";
    fe [[ f ]]( s, "ACTIVITY_ABOM_HUNT_STRIKE_BOSS", cf, ( 22720.6, 53848.7, 896.97 ), ( 0, 0, 0 ), undefined, undefined, "return_point", undefined, "winery_return", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_abom_hunt_cs";
    s.groupid = "abom_hunt_winery";
    s.name = "return_point";
    fe [[ f ]]( s, "ACTIVITY_ABOM_HUNT_STRIKE_BOSS", cf, ( 20537.7, 43034.4, 918.94 ), ( 0, 0, 0 ), undefined, undefined, "return_point", undefined, "winery_return", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_abom_hunt_cs";
    s.groupid = "abom_hunt_winery";
    s.name = "joiner_deadbody";
    fe [[ f ]]( s, "ACTIVITY_ABOM_HUNT_STRIKE_BOSS", cf, ( 16731.1, 43423.2, 810.81 ), ( 0, 117, 0 ), undefined, undefined, undefined, "winery_return", "cspf_5_1", ( 0, 0, 0 ), ( 0, 0, 0 ), 2000 );
}

// Namespace mp_sat_avalon_q2_ob_activity_abom_hunt_cs
// Params 0
// Checksum 0x20bd5a3b, Offset: 0x2ee2
// Size: 0x143
function function_d9dd7965c51c95d1()
{
    activityinstances = [];
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_activity_definition_abom_hunt";
    var_881289d7987bc770.cf = "mp_sat_avalon_q2_ob_activity_abom_hunt_cs";
    var_881289d7987bc770.scriptstructorigin = ( 60325.6, 34183.3, 407.03 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [];
    var_881289d7987bc770.var_31ce4477e3543d24 = [];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [];
    var_881289d7987bc770.locationradius = [];
    activityinstances[ "ACTIVITY_ABOM_HUNT" ] = var_881289d7987bc770;
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_activity_definition_abom_hunt";
    var_881289d7987bc770.cf = "mp_sat_avalon_q2_ob_activity_abom_hunt_cs";
    var_881289d7987bc770.scriptstructorigin = ( 59063.8, 56860.8, 277.34 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [];
    var_881289d7987bc770.var_31ce4477e3543d24 = [];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [];
    var_881289d7987bc770.locationradius = [];
    activityinstances[ "ACTIVITY_ABOM_HUNT_STRIKE_BOSS" ] = var_881289d7987bc770;
    return activityinstances;
}

