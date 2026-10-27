// scripts\mp\zm\maps\zm_sat_locust\zm_sat_locust_intel_create_script.gsc  (hash_7d17b45b7b78bbeb.gscc) (size: 4234 Bytes / 0x108a / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xba53e5f9 (3126060537)
// size ...... 4234 (0x108a)
// includes .. 3   (offset: 0xe86)
// strings ... 24  (offset: 0xe9e)
// dev strs .. 0   (offset: 0x108a)
// exports ... 9   (offset: 0xaee)
// cseg ...... 0x2d4 + 0x81a (0xaee)
// imports ... 20  (offset: 0xc56)
// animtree1 . 0   (offset: 0x108a)
// animtree2 . 0   (offset: 0x108a)
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace zm_sat_locust_intel_create_script;

// Namespace zm_sat_locust_intel_create_script
// Params 0, eflags: 0x5
// Checksum 0x2e9ff5f, Offset: 0x2f2
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"zm_sat_locust_intel_create_script", undefined, &function_b39ecd3d51489472, undefined );
}

// Namespace zm_sat_locust_intel_create_script
// Params 0, eflags: 0x4
// Checksum 0x694e2baf, Offset: 0x313
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace zm_sat_locust_intel_create_script
// Params 0, eflags: 0x4
// Checksum 0xec75f843, Offset: 0x324
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace zm_sat_locust_intel_create_script
// Params 2
// Checksum 0x5c9cae0a, Offset: 0x335
// Size: 0x80
function main( unused, unused2 )
{
    if ( utility::flag_exist( "zm_sat_locust_intel_create_script" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "zm_sat_locust_intel_create_script" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "zm_sat_locust_intel_create_script" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "zm_sat_locust_intel_create_script" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace zm_sat_locust_intel_create_script
// Params 3, eflags: 0x4
// Checksum 0x6ff74c8c, Offset: 0x3bd
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "zm_sat_locust_intel_create_script" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "zm_sat_locust_intel_create_script" );
}

// Namespace zm_sat_locust_intel_create_script
// Params 3, eflags: 0x4
// Checksum 0x64509181, Offset: 0x437
// Size: 0x697
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "zm_sat_locust_intel_create_script";
    s.groupid = "audiologs";
    s.script_string = "zmintel_sat_locust_audiolog_2";
    fe [[ f ]]( s, us, cf, ( 1358.25, 6038.92, 104.45 ), ( 0, 133, 0 ), undefined, undefined, "zombie_intel" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_intel_create_script";
    s.groupid = "Documents";
    s.script_string = "zmintel_sat_locust_document_4";
    fe [[ f ]]( s, us, cf, ( 3045.34, 3218.58, 215.88 ), ( 83.16, 50.78, -97.57 ), undefined, undefined, "zombie_intel" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_intel_create_script";
    s.groupid = "audiologs";
    s.script_string = "zmintel_sat_locust_audiolog_1";
    fe [[ f ]]( s, us, cf, ( 4115.48, 600.36, 268.81 ), ( 0, 320.2, 0 ), undefined, undefined, "zombie_intel" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_intel_create_script";
    s.groupid = "audiologs";
    s.script_string = "zmintel_sat_locust_audiolog_3";
    fe [[ f ]]( s, us, cf, ( 3390.62, 390.73, 243.37 ), ( 0, 267.9, 0 ), undefined, undefined, "zombie_intel" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_intel_create_script";
    s.groupid = "Documents";
    s.script_string = "zmintel_sat_locust_document_8";
    fe [[ f ]]( s, us, cf, ( 7279.28, 1234.35, 1632.88 ), ( 88.41, 142.17, 1.97 ), undefined, undefined, "zombie_intel" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_intel_create_script";
    s.groupid = "Documents";
    s.script_string = "zmintel_sat_locust_document_7";
    fe [[ f ]]( s, us, cf, ( 7256.86, 1472.14, 492.51 ), ( 0, 237.1, 0 ), undefined, undefined, "zombie_intel" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_intel_create_script";
    s.groupid = "audiologs";
    s.script_string = "zmintel_sat_locust_audiolog_4";
    fe [[ f ]]( s, us, cf, ( 2572.61, 3420.51, 101.64 ), ( 0, 240.1, 0 ), undefined, undefined, "zombie_intel" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_intel_create_script";
    s.groupid = "audiologs";
    s.script_string = "zmintel_sat_locust_audiolog_9";
    fe [[ f ]]( s, us, cf, ( -30.64, 6119.72, 341.12 ), ( 0, 0, 0 ), undefined, undefined, "zombie_intel" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_intel_create_script";
    s.groupid = "audiologs";
    s.script_string = "zmintel_sat_locust_audiolog_5";
    fe [[ f ]]( s, us, cf, ( -1650.89, 4706.13, 192.05 ), ( 0, 33, -1 ), undefined, undefined, "zombie_intel" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_intel_create_script";
    s.groupid = "Documents";
    fe [[ f ]]( s, us, cf, ( -1649.82, 5474.71, 484.95 ), ( 349.77, 341.29, -10.94 ), "p_vt_s" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_intel_create_script";
    s.groupid = "Documents";
    fe [[ f ]]( s, us, cf, ( -1789.06, 5654.66, 352.74 ), ( 0.02, 346.34, -0.26 ), "p_vt_l" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_intel_create_script";
    s.groupid = "Documents";
    s.script_string = "zmintel_sat_locust_document_3";
    fe [[ f ]]( s, us, cf, ( 4183.14, 4482.93, 115.78 ), ( 0, 246.1, 0 ), undefined, undefined, "zombie_intel" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_intel_create_script";
    s.groupid = "Documents";
    s.script_string = "zmintel_sat_locust_document_5";
    fe [[ f ]]( s, us, cf, ( 1593.97, 6262.01, 248.75 ), ( 0, 213.3, 0 ), undefined, undefined, "zombie_intel" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_intel_create_script";
    s.groupid = "Documents";
    s.script_string = "zmintel_sat_locust_document_2";
    fe [[ f ]]( s, us, cf, ( 347.8, 2625.29, 84.14 ), ( 0, 0, 0 ), undefined, undefined, "zombie_intel" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_intel_create_script";
    s.groupid = "Documents";
    s.script_string = "zmintel_sat_locust_document_1";
    fe [[ f ]]( s, us, cf, ( 4354.48, 5872.72, 254.66 ), ( 6.51, 308.96, 2.21 ), undefined, undefined, "zombie_intel" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_intel_create_script";
    s.groupid = "artifacts";
    s.script_string = "zmintel_sat_locust_artifact_5";
    fe [[ f ]]( s, us, cf, ( -623.61, 5233.78, 360.76 ), ( 0, 119.6, 0 ), undefined, undefined, "zombie_intel" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_intel_create_script";
    s.groupid = "artifacts";
    s.script_string = "zmintel_sat_locust_artifact_4";
    fe [[ f ]]( s, us, cf, ( 1201.93, 6334.48, 120.75 ), ( 0, 187, 0 ), undefined, undefined, "zombie_intel" );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace zm_sat_locust_intel_create_script
// Params 0, eflags: 0x4
// Checksum 0x189592cb, Offset: 0xad6
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace zm_sat_locust_intel_create_script
// Params 0
// Checksum 0xada491c1, Offset: 0xae0
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "zm_sat_locust_intel_create_script" );
}

