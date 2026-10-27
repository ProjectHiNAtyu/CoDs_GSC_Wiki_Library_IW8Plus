// scripts\mp\zm\maps\zm_sat_firefly\zm_sat_firefly_script_bullseye_ee_cs.gsc  (hash_4229f7e3272ecbc9.gscc) (size: 3228 Bytes / 0xc9c / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xa4a6673 (172648051)
// size ...... 3228 (0xc9c)
// includes .. 3   (offset: 0xb3c)
// strings ... 17  (offset: 0xb54)
// dev strs .. 0   (offset: 0xc9c)
// exports ... 9   (offset: 0x7a4)
// cseg ...... 0x1f5 + 0x5af (0x7a4)
// imports ... 20  (offset: 0x90c)
// animtree1 . 0   (offset: 0xc9c)
// animtree2 . 0   (offset: 0xc9c)
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace zm_sat_firefly_script_bullseye_ee_cs;

// Namespace zm_sat_firefly_script_bullseye_ee_cs
// Params 0, eflags: 0x5
// Checksum 0x75b1a46e, Offset: 0x213
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"zm_sat_firefly_script_bullseye_ee_cs", undefined, &function_b39ecd3d51489472, undefined );
}

// Namespace zm_sat_firefly_script_bullseye_ee_cs
// Params 0, eflags: 0x4
// Checksum 0x512d5759, Offset: 0x234
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace zm_sat_firefly_script_bullseye_ee_cs
// Params 0, eflags: 0x4
// Checksum 0xd41684b5, Offset: 0x245
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace zm_sat_firefly_script_bullseye_ee_cs
// Params 2
// Checksum 0x64ffd2fc, Offset: 0x256
// Size: 0x80
function main( unused, unused2 )
{
    if ( utility::flag_exist( "zm_sat_firefly_script_bullseye_ee_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "zm_sat_firefly_script_bullseye_ee_cs" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "zm_sat_firefly_script_bullseye_ee_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "zm_sat_firefly_script_bullseye_ee_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace zm_sat_firefly_script_bullseye_ee_cs
// Params 3, eflags: 0x4
// Checksum 0x5794307a, Offset: 0x2de
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "zm_sat_firefly_script_bullseye_ee_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "zm_sat_firefly_script_bullseye_ee_cs" );
}

// Namespace zm_sat_firefly_script_bullseye_ee_cs
// Params 3, eflags: 0x4
// Checksum 0x413a3f76, Offset: 0x358
// Size: 0x42c
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_bullseye_ee_cs";
    fe [[ f ]]( s, us, cf, ( 12358, 544, 1058 ), ( 0, 60, 0 ), "cspf_0_auto5431579010458976381", undefined, "static" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_bullseye_ee_cs";
    fe [[ f ]]( s, us, cf, ( 12474, 3019, 1088 ), ( 0, 24, 0 ), undefined, undefined, "firefly_trophy_interact" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_bullseye_ee_cs";
    s.is_cs_model = 1;
    s.model = "sat_zm_axe_throwing_trophy_gold";
    s.var_8ef9cdfc2a34bab3 = "1";
    fe [[ f ]]( s, us, cf, ( 12471, 3017, 1081.5 ), ( 0, 25.6, 1.1 ), undefined, undefined, "bullseye_ee_trophy" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_bullseye_ee_cs";
    fe [[ f ]]( s, us, cf, ( 12274, 588, 1084 ), ( 0, 60, 0 ), undefined, "cspf_0_auto5431579010458976381", "bullseye_target_start" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_bullseye_ee_cs";
    fe [[ f ]]( s, us, cf, ( 12318, 568, 1108 ), ( 0, 60, 0 ), "cspf_0_auto5431579010458976381", undefined, "static" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_bullseye_ee_cs";
    fe [[ f ]]( s, us, cf, ( 12314, 564, 1020 ), ( 0, 60, 0 ), "cspf_0_auto5431579010458976381", undefined, "static" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_bullseye_ee_cs";
    fe [[ f ]]( s, us, cf, ( 12288, 580, 1064 ), ( 0, 60, 0 ), "cspf_0_auto5431579010458976381", undefined, "static" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_bullseye_ee_cs";
    fe [[ f ]]( s, us, cf, ( 12228, 602, 1078 ), ( 0, 60, 0 ), "cspf_0_auto5431579010458976381", undefined, "static" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_bullseye_ee_cs";
    fe [[ f ]]( s, us, cf, ( 12234, 598, 1018 ), ( 0, 60, 0 ), "cspf_0_auto5431579010458976381", undefined, "static" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_bullseye_ee_cs";
    s.groupid = "Axe";
    fe [[ f ]]( s, us, cf, ( 12814, 2749, 1059 ), ( 0, 285, 0 ), "combataxe_bullseye_ee_start" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_bullseye_ee_cs";
    fe [[ f ]]( s, us, cf, ( 12600, 1412, 956 ), ( 0, 180.29, 0 ), "combataxe_bullseye_ee_respawn" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_bullseye_ee_cs";
    s.script_scenescriptbundle = "t10_zm_cosmic_bowling_openning_1p";
    fe [[ f ]]( s, us, cf, ( 12304, 728, 1007 ), ( 0, 60, 0 ), "bullseye_mr_peek_dance_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_bullseye_ee_cs";
    fe [[ f ]]( s, us, cf, ( 12459, 861, 903.95 ), ( 0, 0, 0 ), "bullseye_reward_pos", undefined, undefined, undefined, undefined, undefined, undefined, 100 );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_bullseye_ee_cs";
    fe [[ f ]]( s, us, cf, ( 12815, 2744, 1052 ), ( 0, 195, 110.3 ), undefined, undefined, "bullseye_pickup_axe" );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace zm_sat_firefly_script_bullseye_ee_cs
// Params 0, eflags: 0x4
// Checksum 0xa18f76ce, Offset: 0x78c
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace zm_sat_firefly_script_bullseye_ee_cs
// Params 0
// Checksum 0x95c7ed37, Offset: 0x796
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "zm_sat_firefly_script_bullseye_ee_cs" );
}

