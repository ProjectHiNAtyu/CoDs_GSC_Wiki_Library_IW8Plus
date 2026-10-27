// script_19c9073651225f93  (hash_19c9073651225f93.gscc) (size: 7896 Bytes / 0x1ed8 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x7a7e5cd1 (2055101649)
// size ...... 7896 (0x1ed8)
// includes .. 4   (offset: 0x1adc)
// strings ... 27  (offset: 0x1afc)
// dev strs .. 0   (offset: 0x1ed8)
// exports ... 13  (offset: 0x15f8)
// cseg ...... 0x20f + 0x13e9 (0x15f8)
// imports ... 26  (offset: 0x1800)
// animtree1 . 0   (offset: 0x1ed8)
// animtree2 . 0   (offset: 0x1ed8)
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace mp_sat_avalon_quad_02_ob_activity_strike_boss_cs;

// Namespace mp_sat_avalon_quad_02_ob_activity_strike_boss_cs
// Params 0, eflags: 0x5
// Checksum 0x90b40aad, Offset: 0x22d
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"mp_sat_avalon_quad_02_ob_activity_strike_boss_cs", #"activity_common", &function_b39ecd3d51489472, undefined );
}

// Namespace mp_sat_avalon_quad_02_ob_activity_strike_boss_cs
// Params 0, eflags: 0x4
// Checksum 0x49bb734e, Offset: 0x256
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace mp_sat_avalon_quad_02_ob_activity_strike_boss_cs
// Params 0, eflags: 0x4
// Checksum 0xcc80a0a2, Offset: 0x267
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace mp_sat_avalon_quad_02_ob_activity_strike_boss_cs
// Params 2
// Checksum 0x868f4072, Offset: 0x278
// Size: 0x8c
function main( unused, unused2 )
{
    if ( utility::flag_exist( "mp_sat_avalon_quad_02_ob_activity_strike_boss_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "mp_sat_avalon_quad_02_ob_activity_strike_boss_cs" ) )
    {
        return;
    }
    
    activity_common::function_e1df676808c1d1e3( &function_4cd78e661617f3 );
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "mp_sat_avalon_quad_02_ob_activity_strike_boss_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "mp_sat_avalon_quad_02_ob_activity_strike_boss_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace mp_sat_avalon_quad_02_ob_activity_strike_boss_cs
// Params 3, eflags: 0x4
// Checksum 0x4f02146d, Offset: 0x30c
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "mp_sat_avalon_quad_02_ob_activity_strike_boss_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "mp_sat_avalon_quad_02_ob_activity_strike_boss_cs" );
}

// Namespace mp_sat_avalon_quad_02_ob_activity_strike_boss_cs
// Params 3, eflags: 0x4
// Checksum 0x83d3dd05, Offset: 0x386
// Size: 0x83f
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_02_ob_activity_strike_boss_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "500";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "mimic";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "ACTIVITY_STRIKE_BOSS", cf, ( 16960, 48637, 828.79 ), ( 0, 265.42, 0 ), undefined, undefined, "boss_spawn", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_02_ob_activity_strike_boss_cs";
    s.activity_bundle = "sat_activity_definition_strike_boss";
    s.name = "ACTIVITY_STRIKE_BOSS";
    fe [[ f ]]( s, "ACTIVITY_STRIKE_BOSS", cf, ( -18499, -31357.5, 275.5 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_02_ob_activity_strike_boss_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "500";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "mangler";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "ACTIVITY_STRIKE_BOSS", cf, ( 17422, 48132.9, 821.91 ), ( 0, 175.38, 0 ), undefined, undefined, "boss_spawn", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_02_ob_activity_strike_boss_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "500";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "disciple";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "ACTIVITY_STRIKE_BOSS", cf, ( 16311.8, 48067, 836.96 ), ( 0, 8.66, 0 ), undefined, undefined, "boss_spawn", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_02_ob_activity_strike_boss_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "red_flood_boss";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "ACTIVITY_STRIKE_BOSS", cf, ( 18076.5, 55996.3, 766.62 ), ( 0, 0, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_02_ob_activity_strike_boss_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "red_flood_boss";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "ACTIVITY_STRIKE_BOSS", cf, ( 11919.4, 51420.2, 633.75 ), ( 0, 0, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_02_ob_activity_strike_boss_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "red_flood_boss";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "ACTIVITY_STRIKE_BOSS", cf, ( 11484, 47076.3, 603.26 ), ( 0, 0, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_02_ob_activity_strike_boss_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "red_flood_boss";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "ACTIVITY_STRIKE_BOSS", cf, ( 12576.4, 54803.8, 630.88 ), ( 0, 0, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_02_ob_activity_strike_boss_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "red_flood_boss";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "ACTIVITY_STRIKE_BOSS", cf, ( 19094.2, 44904.1, 824 ), ( 0, 283.22, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_02_ob_activity_strike_boss_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "red_flood_boss";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, "ACTIVITY_STRIKE_BOSS", cf, ( 18391.5, 51456.2, 888 ), ( 0, 96.14, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace mp_sat_avalon_quad_02_ob_activity_strike_boss_cs
// Params 0, eflags: 0x4
// Checksum 0x910bf43f, Offset: 0xbcd
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace mp_sat_avalon_quad_02_ob_activity_strike_boss_cs
// Params 0
// Checksum 0x8d51c920, Offset: 0xbd7
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "mp_sat_avalon_quad_02_ob_activity_strike_boss_cs" );
}

// Namespace mp_sat_avalon_quad_02_ob_activity_strike_boss_cs
// Params 0
// Checksum 0xbea02ba5, Offset: 0xbed
// Size: 0x66
function function_4cd78e661617f3()
{
    activityinfostruct = {};
    activityinfostruct.name = "REV_OB_STRIKE_BOSS";
    activityinfostruct.scriptbundle = "sat_activity_definition_strike_boss";
    activityinfostruct.mainfunction = &main;
    activityinfostruct.var_934f068483ae4ddb = &function_d4323822d7042e5a;
    activityinfostruct.metadatafunction = &function_d9dd7965c51c95d1;
    return activityinfostruct;
}

// Namespace mp_sat_avalon_quad_02_ob_activity_strike_boss_cs
// Params 4
// Checksum 0x8c28fc51, Offset: 0xc5c
// Size: 0x57
function function_d4323822d7042e5a( var_4312b79c960726b6, fe, us, cf = "mp_sat_avalon_quad_02_ob_activity_strike_boss_cs" )
{
    switch ( var_4312b79c960726b6 )
    {
        case #"hash_4f0f1d342a4fd47d":
            function_efd9a7b808168e95( fe, us, cf );
            break;
    }
}

// Namespace mp_sat_avalon_quad_02_ob_activity_strike_boss_cs
// Params 3
// Checksum 0x5e24e2e8, Offset: 0xcbb
// Size: 0x886
function function_efd9a7b808168e95( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_02_ob_activity_strike_boss_cs";
    s.height = 5000;
    s.name = "phase_struct";
    s.script_linkname = "phase_struct";
    s.script_linkto = "1";
    fe [[ f ]]( s, "ACTIVITY_STRIKE_BOSS", cf, ( 16111.8, 50326.1, -124.48 ), ( 0, 0, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 10000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_02_ob_activity_strike_boss_cs";
    s.groupid = "boss";
    s.name = "boss_spawn";
    s.script_linkname = "1";
    fe [[ f ]]( s, "ACTIVITY_STRIKE_BOSS", cf, ( 18287.3, 52002.3, 888 ), ( 0, 0, 0 ), undefined, undefined, "boss_spawn", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 1500 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_02_ob_activity_strike_boss_cs";
    s.groupid = "boss";
    s.name = "boss_spawn";
    s.script_linkname = "1";
    fe [[ f ]]( s, "ACTIVITY_STRIKE_BOSS", cf, ( 17964.1, 55955.2, 774.59 ), ( 0, 0, 0 ), undefined, undefined, "boss_spawn", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 1500 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_02_ob_activity_strike_boss_cs";
    s.groupid = "boss";
    s.name = "boss_spawn";
    s.script_linkname = "1";
    fe [[ f ]]( s, "ACTIVITY_STRIKE_BOSS", cf, ( 11922, 51318.1, 627.68 ), ( 0, 0, 0 ), undefined, undefined, "boss_spawn", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 1500 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_02_ob_activity_strike_boss_cs";
    s.groupid = "boss";
    s.name = "boss_spawn";
    s.script_linkname = "1";
    fe [[ f ]]( s, "ACTIVITY_STRIKE_BOSS", cf, ( 11479.9, 46860.1, 601.29 ), ( 0, 0, 0 ), undefined, undefined, "boss_spawn", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 1500 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_02_ob_activity_strike_boss_cs";
    s.groupid = "return";
    s.name = "return_point";
    fe [[ f ]]( s, "ACTIVITY_STRIKE_BOSS", cf, ( 16351.7, 44595.1, 764.05 ), ( 0, 0, 0 ), undefined, undefined, "return_point", undefined, "cspf_2_1", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_02_ob_activity_strike_boss_cs";
    s.groupid = "cradle_site";
    s.name = "cradle_crate";
    s.script_linkname = "1";
    fe [[ f ]]( s, "ACTIVITY_STRIKE_BOSS", cf, ( 16792.2, 48152.2, 842.41 ), ( 0, 179.35, 0 ), undefined, undefined, "cradle_crate", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_02_ob_activity_strike_boss_cs";
    s.groupid = "boss";
    s.name = "boss_spawn";
    s.script_linkname = "1";
    fe [[ f ]]( s, "ACTIVITY_STRIKE_BOSS", cf, ( 12498.9, 54850.5, 637.03 ), ( 0, 0, 0 ), undefined, undefined, "boss_spawn", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 1500 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_02_ob_activity_strike_boss_cs";
    s.groupid = "boss";
    s.name = "boss_spawn";
    s.script_linkname = "1";
    fe [[ f ]]( s, "ACTIVITY_STRIKE_BOSS", cf, ( 19146.7, 44599.1, 823.97 ), ( 0, 0, 0 ), undefined, undefined, "boss_spawn", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 1500 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_02_ob_activity_strike_boss_cs";
    s.groupid = "return";
    s.name = "return_point";
    fe [[ f ]]( s, "ACTIVITY_STRIKE_BOSS", cf, ( 11264.3, 47106.9, 601.88 ), ( 0, 0, 0 ), undefined, undefined, "return_point", undefined, "cspf_2_1", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_02_ob_activity_strike_boss_cs";
    s.groupid = "return";
    s.name = "return_point";
    fe [[ f ]]( s, "ACTIVITY_STRIKE_BOSS", cf, ( 10305.9, 52489.2, 705.24 ), ( 0, 0, 0 ), undefined, undefined, "return_point", undefined, "cspf_2_1", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_02_ob_activity_strike_boss_cs";
    s.groupid = "return";
    s.name = "return_point";
    fe [[ f ]]( s, "ACTIVITY_STRIKE_BOSS", cf, ( 16803.3, 55797.7, 770.69 ), ( 0, 0, 0 ), undefined, undefined, "return_point", undefined, "cspf_2_1", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_02_ob_activity_strike_boss_cs";
    s.groupid = "return";
    s.name = "return_point";
    fe [[ f ]]( s, "ACTIVITY_STRIKE_BOSS", cf, ( 22720.6, 53848.7, 896.97 ), ( 0, 0, 0 ), undefined, undefined, "return_point", undefined, "cspf_2_1", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_02_ob_activity_strike_boss_cs";
    s.name = "master";
    s.script_linkto = "phase_struct";
    fe [[ f ]]( s, "ACTIVITY_STRIKE_BOSS", cf, ( 15552.8, 47014.9, 11060.7 ), ( 0, 0, 0 ), "ACTIVITY_STRIKE_BOSS", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_02_ob_activity_strike_boss_cs";
    s.groupid = "return";
    s.name = "return_point";
    fe [[ f ]]( s, "ACTIVITY_STRIKE_BOSS", cf, ( 20537.7, 43034.4, 918.94 ), ( 0, 0, 0 ), undefined, undefined, "return_point", undefined, "cspf_2_1", ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_sat_avalon_quad_02_ob_activity_strike_boss_cs
// Params 0
// Checksum 0x7522a546, Offset: 0x1549
// Size: 0xae
function function_d9dd7965c51c95d1()
{
    activityinstances = [];
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_activity_definition_strike_boss";
    var_881289d7987bc770.cf = "mp_sat_avalon_quad_02_ob_activity_strike_boss_cs";
    var_881289d7987bc770.scriptstructorigin = ( -18499, -31357.5, 275.5 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [];
    var_881289d7987bc770.var_31ce4477e3543d24 = [];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [];
    var_881289d7987bc770.locationradius = [];
    activityinstances[ "ACTIVITY_STRIKE_BOSS" ] = var_881289d7987bc770;
    return activityinstances;
}

