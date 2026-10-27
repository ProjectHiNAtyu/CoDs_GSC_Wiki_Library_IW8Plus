// script_56ff92b32e841b7b  (hash_56ff92b32e841b7b.gscc) (size: 8373 Bytes / 0x20b5 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xbcae339d (3165533085)
// size ...... 8373 (0x20b5)
// includes .. 4   (offset: 0x1d15)
// strings ... 37  (offset: 0x1d35)
// dev strs .. 0   (offset: 0x20b5)
// exports ... 13  (offset: 0x1761)
// cseg ...... 0x442 + 0x131f (0x1761)
// imports ... 28  (offset: 0x1969)
// animtree1 . 0   (offset: 0x20b5)
// animtree2 . 0   (offset: 0x20b5)
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace mp_sat_avalon_quad_03_ob_activity_quarantine_island_cs;

// Namespace mp_sat_avalon_quad_03_ob_activity_quarantine_island_cs
// Params 0, eflags: 0x5
// Checksum 0x7324c033, Offset: 0x460
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"mp_sat_avalon_quad_03_ob_activity_quarantine_island_cs", #"activity_common", &function_b39ecd3d51489472, undefined );
}

// Namespace mp_sat_avalon_quad_03_ob_activity_quarantine_island_cs
// Params 0, eflags: 0x4
// Checksum 0xf26855bb, Offset: 0x489
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace mp_sat_avalon_quad_03_ob_activity_quarantine_island_cs
// Params 0, eflags: 0x4
// Checksum 0x77538657, Offset: 0x49a
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace mp_sat_avalon_quad_03_ob_activity_quarantine_island_cs
// Params 2
// Checksum 0xd3bc2e8d, Offset: 0x4ab
// Size: 0x8c
function main( unused, unused2 )
{
    if ( utility::flag_exist( "mp_sat_avalon_quad_03_ob_activity_quarantine_island_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "mp_sat_avalon_quad_03_ob_activity_quarantine_island_cs" ) )
    {
        return;
    }
    
    activity_common::function_e1df676808c1d1e3( &function_4cd78e661617f3 );
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "mp_sat_avalon_quad_03_ob_activity_quarantine_island_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "mp_sat_avalon_quad_03_ob_activity_quarantine_island_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace mp_sat_avalon_quad_03_ob_activity_quarantine_island_cs
// Params 3, eflags: 0x4
// Checksum 0xf4d13298, Offset: 0x53f
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "mp_sat_avalon_quad_03_ob_activity_quarantine_island_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "mp_sat_avalon_quad_03_ob_activity_quarantine_island_cs" );
}

// Namespace mp_sat_avalon_quad_03_ob_activity_quarantine_island_cs
// Params 3, eflags: 0x4
// Checksum 0x8bda2831, Offset: 0x5b9
// Size: 0xceb
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_quarantine_island_cs";
    s.groupid = "falkner_spawn";
    s.maxspawns = int( 1 );
    s.minspawns = int( 1 );
    s.var_6324368dbfa7058a = float( 3000 );
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "quarantine_island_falkner_spawn";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "QUARANTINE_ISLAND_Q3_ISLAND_ARMORY", cf, ( -29937.8, -56776.5, 325.5 ), ( 0.04, 125.72, 0.06 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 2, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_quarantine_island_cs";
    s._size_max = ( 408, 252.5, 134.5 );
    s._size_min = ( 270.5, 500, 32 );
    s.var_5afd49978f924648 = int( 0 );
    s.var_a8568d8e0b0b6076 = int( 0 );
    s.var_3f3960eb7318312d = int( 1 );
    s.default_goal_radius = float( -1 );
    s.height = 128;
    s.length = "128";
    s.script_stealthgroup = "-1";
    s.script_string = "enc_ob_quarantine_island_disciple_boss";
    s.var_95e2cee7aca5aaae = int( 1 );
    s.width = "128";
    fe [[ f ]]( s, "QUARANTINE_ISLAND_Q3_ISLAND_ARMORY", cf, ( -29910, -56775.5, 320.5 ), ( 0, 0, 0 ), "quarantine_island_disciple_boss_encounter", undefined, "noent_volume_ai_encounter_cs", undefined, undefined, ( 0, 2, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_quarantine_island_cs";
    s._size_max = ( 159, 145.5, 134.5 );
    s._size_min = ( 150.5, 126, 32 );
    s.var_5afd49978f924648 = int( 0 );
    s.var_a8568d8e0b0b6076 = int( 0 );
    s.var_3f3960eb7318312d = int( 1 );
    s.default_goal_radius = float( -1 );
    s.height = 128;
    s.length = "128";
    s.script_stealthgroup = "-1";
    s.script_string = "enc_ob_quarantine_island_falkner";
    s.var_95e2cee7aca5aaae = int( 1 );
    s.width = "128";
    fe [[ f ]]( s, "QUARANTINE_ISLAND_Q3_ISLAND_ARMORY", cf, ( -29836.5, -56891, 320.5 ), ( 0, 0, 0 ), "quarantine_island_falker_encounter", undefined, "noent_volume_ai_encounter_cs", undefined, undefined, ( 0, 2, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_quarantine_island_cs";
    s.groupid = "disciple_boss_spawn";
    s.maxspawns = int( 1 );
    s.minspawns = int( 1 );
    s.var_6324368dbfa7058a = float( 3000 );
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "quarantine_island_disciple_boss_spawn";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "QUARANTINE_ISLAND_Q3_ISLAND_ARMORY", cf, ( -29878.3, -56867, 325.5 ), ( 0.04, 125.72, 0.06 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 2, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_quarantine_island_cs";
    s.activity_bundle = "sat_activitydef_quarantine_island";
    s.name = "QUARANTINE_ISLAND_Q3_ISLAND_ARMORY";
    fe [[ f ]]( s, "QUARANTINE_ISLAND_Q3_ISLAND_ARMORY", cf, ( -30295.2, -54812.3, 976.24 ), ( 0, 75.25, 0 ), "activity_nexus_variant", "QUARANTINE_ISLAND_Q3_ISLAND_ARMORY", undefined, "activity_link", undefined, ( 0, 2, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_quarantine_island_cs";
    fe [[ f ]]( s, "QUARANTINE_ISLAND_Q3_ISLAND_ARMORY", cf, ( -30336.9, -54752.4, 444 ), ( 0, 76, 0 ), "activity_nexus_spatial_zone", undefined, "OB_Spacer_Spatial_Zone", undefined, "activity_link", ( 0, 2, 0 ), ( 0, 0, 0 ), 4600 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_quarantine_island_cs";
    s.groupid = "amalgam_spawn";
    s.maxspawns = int( 1 );
    s.minspawns = int( 1 );
    s.var_6324368dbfa7058a = float( 3000 );
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "nest_doppleghast_spawnpoint";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "QUARANTINE_ISLAND_Q3_ISLAND_ARMORY", cf, ( -30402.8, -54709.5, 448 ), ( 0.07, 302.2, 0.03 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 2, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_quarantine_island_cs";
    s.groupid = "amalgam_spawn";
    s.maxspawns = int( 1 );
    s.minspawns = int( 1 );
    s.var_6324368dbfa7058a = float( 3000 );
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "nest_doppleghast_spawnpoint";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "QUARANTINE_ISLAND_Q3_ISLAND_ARMORY", cf, ( -30148.3, -54732.5, 448 ), ( 359.93, 261.93, -0.01 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 2, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_quarantine_island_cs";
    s.groupid = "amalgam_spawn";
    s.maxspawns = int( 1 );
    s.minspawns = int( 1 );
    s.var_6324368dbfa7058a = float( 3000 );
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "nest_doppleghast_spawnpoint";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "QUARANTINE_ISLAND_Q3_ISLAND_ARMORY", cf, ( -30491.7, -54919.7, 448 ), ( 0.05, 345.07, -0.06 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 2, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_quarantine_island_cs";
    s.groupid = "ai_encounter_spawnpoint";
    s.maxspawns = int( 1 );
    s.minspawns = int( 1 );
    s.var_6324368dbfa7058a = float( 3000 );
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "QUARANTINE_ISLAND_Q3_ISLAND_ARMORY", cf, ( -30195.3, -54939.6, 448 ), ( 0.01, 186.43, -0.07 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 2, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_quarantine_island_cs";
    s.groupid = "ai_encounter_spawnpoint";
    s.maxspawns = int( 1 );
    s.minspawns = int( 1 );
    s.var_6324368dbfa7058a = float( 3000 );
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "QUARANTINE_ISLAND_Q3_ISLAND_ARMORY", cf, ( -30423.2, -54967.5, 584.25 ), ( 0.04, 347.24, 0.06 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 2, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_quarantine_island_cs";
    s.groupid = "ai_encounter_spawnpoint";
    s.maxspawns = int( 1 );
    s.minspawns = int( 1 );
    s.var_6324368dbfa7058a = float( 3000 );
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "QUARANTINE_ISLAND_Q3_ISLAND_ARMORY", cf, ( -29884.7, -54968.7, 584 ), ( 359.93, 201.89, 0.01 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 2, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_quarantine_island_cs";
    s.groupid = "ai_encounter_spawnpoint";
    s.maxspawns = int( 1 );
    s.minspawns = int( 1 );
    s.var_6324368dbfa7058a = float( 3000 );
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "QUARANTINE_ISLAND_Q3_ISLAND_ARMORY", cf, ( -30311.4, -54716.1, 584 ), ( 359.95, 300.36, -0.05 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 2, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_quarantine_island_cs";
    s.groupid = "ai_encounter_spawnpoint";
    s.maxspawns = int( 1 );
    s.minspawns = int( 1 );
    s.var_6324368dbfa7058a = float( 3000 );
    s.script_stealthgroup = "-1";
    s.variantname = "ai_encounter_spawnpoint";
    s.zombie_spawn_anim = "none";
    fe [[ f ]]( s, "QUARANTINE_ISLAND_Q3_ISLAND_ARMORY", cf, ( -30324.6, -54678.4, 448 ), ( 359.93, 312.28, 0.03 ), undefined, undefined, "ai_encounter_spawnpoint", undefined, undefined, ( 0, 2, 0 ), ( 0, 0, 0 ) );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace mp_sat_avalon_quad_03_ob_activity_quarantine_island_cs
// Params 0, eflags: 0x4
// Checksum 0xc4389ac0, Offset: 0x12ac
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace mp_sat_avalon_quad_03_ob_activity_quarantine_island_cs
// Params 0
// Checksum 0x3682efd5, Offset: 0x12b6
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "mp_sat_avalon_quad_03_ob_activity_quarantine_island_cs" );
}

// Namespace mp_sat_avalon_quad_03_ob_activity_quarantine_island_cs
// Params 0
// Checksum 0xb3cd25bc, Offset: 0x12cc
// Size: 0x66
function function_4cd78e661617f3()
{
    activityinfostruct = {};
    activityinfostruct.name = "REV_OB_QUARANTINE_ISLAND";
    activityinfostruct.scriptbundle = "sat_activitydef_quarantine_island";
    activityinfostruct.mainfunction = &main;
    activityinfostruct.var_934f068483ae4ddb = &function_d4323822d7042e5a;
    activityinfostruct.metadatafunction = &function_d9dd7965c51c95d1;
    return activityinfostruct;
}

// Namespace mp_sat_avalon_quad_03_ob_activity_quarantine_island_cs
// Params 4
// Checksum 0xdf46c201, Offset: 0x133b
// Size: 0x57
function function_d4323822d7042e5a( var_4312b79c960726b6, fe, us, cf = "mp_sat_avalon_quad_03_ob_activity_quarantine_island_cs" )
{
    switch ( var_4312b79c960726b6 )
    {
        case #"hash_3bff3b464c9378f3":
            function_869799c54165a08b( fe, us, cf );
            break;
    }
}

// Namespace mp_sat_avalon_quad_03_ob_activity_quarantine_island_cs
// Params 3
// Checksum 0xbb9ecfb1, Offset: 0x139a
// Size: 0x2d6
function function_869799c54165a08b( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_quarantine_island_cs";
    s.name = "master_struct";
    fe [[ f ]]( s, "QUARANTINE_ISLAND_Q3_ISLAND_ARMORY", cf, ( -30712, -55514.3, 500 ), ( 0, 76, 0 ), "QUARANTINE_ISLAND_Q3_ISLAND_ARMORY_main", undefined, undefined, undefined, undefined, ( 0, 2, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_quarantine_island_cs";
    s.type = "simple";
    fe [[ f ]]( s, "QUARANTINE_ISLAND_Q3_ISLAND_ARMORY", cf, ( -29833, -56883.5, 329.79 ), ( 0, 315.09, 0 ), "ob_exfil_spawnpoint", undefined, "quarantine_island_exfil", undefined, undefined, ( 0, 2, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_quarantine_island_cs";
    fe [[ f ]]( s, "QUARANTINE_ISLAND_Q3_ISLAND_ARMORY", cf, ( -30407.7, -55260.1, 926.39 ), ( 0, 73.5, 0 ), "QUARANTINE_ISLAND_Q3_ISLAND_ARMORY", "cspf_2_auto14135615458493372089", "contract_activity_chain", undefined, undefined, ( 0, 2, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_quarantine_island_cs";
    s.script_label = "SUPPLY_DROP_Q3_ISLAND_ARMORY";
    fe [[ f ]]( s, "QUARANTINE_ISLAND_Q3_ISLAND_ARMORY", cf, ( -30249.1, -54688.7, 930.39 ), ( 0, 73.5, 0 ), "cspf_2_auto14135615458493372089", undefined, undefined, undefined, undefined, ( 0, 2, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_quarantine_island_cs";
    s.name = "safe_spawn_point";
    fe [[ f ]]( s, "QUARANTINE_ISLAND_Q3_ISLAND_ARMORY", cf, ( -30131.8, -55082.5, 448 ), ( 0, 75, 0 ), undefined, "QUARANTINE_ISLAND_Q3_ISLAND_ARMORY_main", "s_safe_spawn", undefined, undefined, ( 0, 2, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_activity_quarantine_island_cs";
    s.groupid = "amalgam_spawn";
    fe [[ f ]]( s, "QUARANTINE_ISLAND_Q3_ISLAND_ARMORY", cf, ( -30224, -54909.5, 456.5 ), ( 0, 196.88, 0 ), "s_quarantine_island_q3_island_armory_center", undefined, undefined, undefined, undefined, ( 0, 2, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_sat_avalon_quad_03_ob_activity_quarantine_island_cs
// Params 0
// Checksum 0xdf5d46a1, Offset: 0x1678
// Size: 0xe8
function function_d9dd7965c51c95d1()
{
    activityinstances = [];
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_activitydef_quarantine_island";
    var_881289d7987bc770.cf = "mp_sat_avalon_quad_03_ob_activity_quarantine_island_cs";
    var_881289d7987bc770.scriptstructorigin = ( -30295.2, -54812.3, 976.24 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 2, 0 );
    var_881289d7987bc770.locationorigin = [ ( -30301.4, -54799.1, 444 ) ];
    var_881289d7987bc770.var_31ce4477e3543d24 = [ ( 0, 2, 0 ) ];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.locationradius = [ 900 ];
    activityinstances[ "QUARANTINE_ISLAND_Q3_ISLAND_ARMORY" ] = var_881289d7987bc770;
    return activityinstances;
}

