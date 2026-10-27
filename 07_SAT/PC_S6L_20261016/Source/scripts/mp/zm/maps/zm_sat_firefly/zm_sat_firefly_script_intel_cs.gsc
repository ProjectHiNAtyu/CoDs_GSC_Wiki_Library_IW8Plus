// scripts\mp\zm\maps\zm_sat_firefly\zm_sat_firefly_script_intel_cs.gsc  (hash_0fe9edf8a6fd1adb.gscc) (size: 4504 Bytes / 0x1198 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x2fb8e40c (800646156)
// size ...... 4504 (0x1198)
// includes .. 3   (offset: 0xf8c)
// strings ... 26  (offset: 0xfa4)
// dev strs .. 0   (offset: 0x1198)
// exports ... 9   (offset: 0xbf4)
// cseg ...... 0x305 + 0x8ef (0xbf4)
// imports ... 20  (offset: 0xd5c)
// animtree1 . 0   (offset: 0x1198)
// animtree2 . 0   (offset: 0x1198)
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace zm_sat_firefly_script_intel_cs;

// Namespace zm_sat_firefly_script_intel_cs
// Params 0, eflags: 0x5
// Checksum 0xba3ce548, Offset: 0x323
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"zm_sat_firefly_script_intel_cs", undefined, &function_b39ecd3d51489472, undefined );
}

// Namespace zm_sat_firefly_script_intel_cs
// Params 0, eflags: 0x4
// Checksum 0xc830e9a9, Offset: 0x344
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace zm_sat_firefly_script_intel_cs
// Params 0, eflags: 0x4
// Checksum 0x4d0b3a45, Offset: 0x355
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace zm_sat_firefly_script_intel_cs
// Params 2
// Checksum 0xfde26c0c, Offset: 0x366
// Size: 0x80
function main( unused, unused2 )
{
    if ( utility::flag_exist( "zm_sat_firefly_script_intel_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "zm_sat_firefly_script_intel_cs" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "zm_sat_firefly_script_intel_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "zm_sat_firefly_script_intel_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace zm_sat_firefly_script_intel_cs
// Params 3, eflags: 0x4
// Checksum 0xce898e8a, Offset: 0x3ee
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "zm_sat_firefly_script_intel_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "zm_sat_firefly_script_intel_cs" );
}

// Namespace zm_sat_firefly_script_intel_cs
// Params 3, eflags: 0x4
// Checksum 0x294f9a1e, Offset: 0x468
// Size: 0x76c
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_intel_cs";
    fe [[ f ]]( s, us, cf, ( -8404.18, -6753.84, 1360.29 ), ( 0, 186.7, 0 ), "firefly_audiolog_4" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_intel_cs";
    fe [[ f ]]( s, us, cf, ( 14079, -4136.5, 623 ), ( 0, 0, 0 ), "firefly_document4_interact" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_intel_cs";
    fe [[ f ]]( s, us, cf, ( 14424, -4797, 558 ), ( 0, 0, 0 ), "firefly_document4_interact" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_intel_cs";
    fe [[ f ]]( s, us, cf, ( 14689.5, -4790, 558 ), ( 0, 0, 0 ), "firefly_document4_interact", undefined, "entrance_bale_landing" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_intel_cs";
    fe [[ f ]]( s, us, cf, ( 14131, -3256, 669 ), ( 0, 0, 0 ), "firefly_document4_interact" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_intel_cs";
    fe [[ f ]]( s, us, cf, ( 14639, -4801.5, 521.75 ), ( 0, 0, 0 ), "entrance_bale_landing" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_intel_cs";
    fe [[ f ]]( s, us, cf, ( 13278.1, -3263.44, 540.68 ), ( 0, 316.6, 0 ), "firefly_audiolog_2" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_intel_cs";
    fe [[ f ]]( s, us, cf, ( 14466, -5962, 547 ), ( 0, 0, 0 ), "firefly_document4_interact" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_intel_cs";
    fe [[ f ]]( s, us, cf, ( 24226.8, 468, 336.75 ), ( 0, 0, 0 ), "tank_barrel" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_intel_cs";
    fe [[ f ]]( s, us, cf, ( -6677, -6335, 1579.5 ), ( 0, 329.2, 0 ), "firefly_document2_stack" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_intel_cs";
    s.script_string = "zmintel_sat_firefly_document_5";
    fe [[ f ]]( s, us, cf, ( -13099, 4203, 457 ), ( 0, 235, 0 ), undefined, undefined, "zombie_intel" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_intel_cs";
    s.script_string = "zmintel_sat_firefly_document_3";
    fe [[ f ]]( s, us, cf, ( 3961.5, -2068.5, -46.5 ), ( 0, 342.1, 0 ), undefined, undefined, "zombie_intel" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_intel_cs";
    fe [[ f ]]( s, us, cf, ( 24249.5, 423.25, 305 ), ( 0, 0, 0 ), "tank_doc_landing" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_intel_cs";
    fe [[ f ]]( s, us, cf, ( 12673, 3160, 1036.75 ), ( 0, 0, 0 ), "bullseye_doc_landing" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_intel_cs";
    s.script_string = "zmintel_sat_firefly_audiolog_5";
    fe [[ f ]]( s, us, cf, ( -12046.9, 3323.51, 527.89 ), ( 0, 27.07, 0 ), undefined, undefined, "zombie_intel" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_intel_cs";
    s.script_string = "zmintel_sat_firefly_audiolog_6";
    fe [[ f ]]( s, us, cf, ( -13586.6, 3743.53, 481.1 ), ( 0, 140, 0 ), undefined, undefined, "zombie_intel" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_intel_cs";
    s.script_string = "zmintel_sat_firefly_audiolog_7";
    fe [[ f ]]( s, us, cf, ( 3725, -3244, 526 ), ( 0, 269.45, 0 ), undefined, undefined, "zombie_intel" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_intel_cs";
    s.script_string = "zmintel_sat_firefly_audiolog_8";
    fe [[ f ]]( s, us, cf, ( 3354.75, -404.5, 493.75 ), ( 359.59, 183.71, -11.17 ), undefined, undefined, "zombie_intel" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_intel_cs";
    s.script_string = "zmintel_sat_firefly_audiolog_10";
    fe [[ f ]]( s, us, cf, ( 4093.96, -1209.49, -290.5 ), ( 0, 99.8, 0 ), undefined, undefined, "zombie_intel" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_intel_cs";
    s.script_string = "zmintel_sat_firefly_audiolog_9";
    fe [[ f ]]( s, us, cf, ( 14522.5, 2565, 944 ), ( 0, 249.96, 0 ), undefined, undefined, "zombie_intel" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_intel_cs";
    s.script_string = "zmintel_sat_firefly_audiolog_1";
    fe [[ f ]]( s, us, cf, ( 13292.5, -3290.46, 711.51 ), ( 0, 61.9, 0 ), undefined, undefined, "zombie_intel" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_intel_cs";
    fe [[ f ]]( s, us, cf, ( -6877.36, -6339.26, 1600.6 ), ( 0, 56.9, 1.6 ), "firefly_audiolog_3" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_intel_cs";
    fe [[ f ]]( s, us, cf, ( 14340.6, 2339.5, 939.53 ), ( 0, 0, 0 ), "firefly_audiolog_12" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_intel_cs";
    fe [[ f ]]( s, us, cf, ( 13810.6, 2647.33, 1091.92 ), ( 0, 0, 0 ), "firefly_audiolog_11" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_intel_cs";
    fe [[ f ]]( s, us, cf, ( 12922.8, 2003.25, 1254.49 ), ( 0, 84, 0 ), "firefly_audiolog_13" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_intel_cs";
    fe [[ f ]]( s, us, cf, ( 12646.7, 3020, 1073.44 ), ( 0, 116, 0 ), "firefly_audiolog_14" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_intel_cs";
    fe [[ f ]]( s, us, cf, ( 13730, -3919, 647 ), ( 0, 0, 0 ), "firefly_document4_interact" );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace zm_sat_firefly_script_intel_cs
// Params 0, eflags: 0x4
// Checksum 0x74916634, Offset: 0xbdc
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace zm_sat_firefly_script_intel_cs
// Params 0
// Checksum 0xcda53c7, Offset: 0xbe6
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "zm_sat_firefly_script_intel_cs" );
}

