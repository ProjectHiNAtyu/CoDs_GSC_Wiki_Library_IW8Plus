// scripts\mp\zm\maps\zm_sat_mantis\zm_sat_mantis_intel_create_script.gsc  (hash_4acc177f1047eaef.gscc) (size: 3202 Bytes / 0xc82 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x5ac2ac1b (1522707483)
// size ...... 3202 (0xc82)
// includes .. 3   (offset: 0xb32)
// strings ... 17  (offset: 0xb4a)
// dev strs .. 0   (offset: 0xc82)
// exports ... 9   (offset: 0x79a)
// cseg ...... 0x207 + 0x593 (0x79a)
// imports ... 20  (offset: 0x902)
// animtree1 . 0   (offset: 0xc82)
// animtree2 . 0   (offset: 0xc82)
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace zm_sat_mantis_intel_create_script;

// Namespace zm_sat_mantis_intel_create_script
// Params 0, eflags: 0x5
// Checksum 0x2df1e84a, Offset: 0x225
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"zm_sat_mantis_intel_create_script", undefined, &function_b39ecd3d51489472, undefined );
}

// Namespace zm_sat_mantis_intel_create_script
// Params 0, eflags: 0x4
// Checksum 0x5729e884, Offset: 0x246
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace zm_sat_mantis_intel_create_script
// Params 0, eflags: 0x4
// Checksum 0xd2123b68, Offset: 0x257
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace zm_sat_mantis_intel_create_script
// Params 2
// Checksum 0x62fb6d21, Offset: 0x268
// Size: 0x80
function main( unused, unused2 )
{
    if ( utility::flag_exist( "zm_sat_mantis_intel_create_script" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "zm_sat_mantis_intel_create_script" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "zm_sat_mantis_intel_create_script" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "zm_sat_mantis_intel_create_script" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace zm_sat_mantis_intel_create_script
// Params 3, eflags: 0x4
// Checksum 0x51908fa7, Offset: 0x2f0
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "zm_sat_mantis_intel_create_script" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "zm_sat_mantis_intel_create_script" );
}

// Namespace zm_sat_mantis_intel_create_script
// Params 3, eflags: 0x4
// Checksum 0x3850b5b2, Offset: 0x36a
// Size: 0x410
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "zm_sat_mantis_intel_create_script";
    s.script_string = "zmintel_sat_mantis_audiolog_2";
    fe [[ f ]]( s, us, cf, ( 55236.3, -30565.7, 50.85 ), ( 0, 25.5, 0 ), undefined, undefined, "zombie_intel" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_intel_create_script";
    s.script_string = "zmintel_sat_mantis_audiolog_1";
    fe [[ f ]]( s, us, cf, ( 56199.9, -31517.3, 82.49 ), ( 337.29, 219.33, -25.06 ), undefined, undefined, "zombie_intel" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_intel_create_script";
    s.script_string = "zmintel_sat_mantis_audiolog_3";
    fe [[ f ]]( s, us, cf, ( 79454.8, -31855.9, -82.05 ), ( 0, 110.2, 0 ), undefined, undefined, "zombie_intel" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_intel_create_script";
    s.script_string = "zmintel_sat_mantis_audiolog_5";
    fe [[ f ]]( s, us, cf, ( 76396.1, -32598.9, -57.12 ), ( 0, 330.6, 0 ), undefined, undefined, "zombie_intel" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_intel_create_script";
    s.script_string = "zmintel_sat_mantis_audiolog_4";
    fe [[ f ]]( s, us, cf, ( 55016.2, -30115.5, 48.29 ), ( 0, 114.8, 0 ), undefined, undefined, "zombie_intel" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_intel_create_script";
    s.script_string = "zmintel_sat_mantis_audiolog_6";
    fe [[ f ]]( s, us, cf, ( 54208.6, -32715.7, -91.74 ), ( 0, 110.2, 0 ), undefined, undefined, "zombie_intel" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_intel_create_script";
    s.script_string = "zmintel_sat_mantis_document_1";
    fe [[ f ]]( s, us, cf, ( 55391.8, -30321.6, -83.47 ), ( 359.3, 110.2, -0 ), undefined, undefined, "zombie_intel" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_intel_create_script";
    s.script_string = "zmintel_sat_mantis_document_2";
    fe [[ f ]]( s, us, cf, ( 78940.7, -31587.2, -86.56 ), ( 0, 275.5, 0 ), undefined, undefined, "zombie_intel" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_intel_create_script";
    s.script_string = "zmintel_sat_mantis_document_3";
    fe [[ f ]]( s, us, cf, ( 77690, -32046.7, -88.63 ), ( 89.9, 317.1, -179.8 ), undefined, undefined, "zombie_intel" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_intel_create_script";
    fe [[ f ]]( s, us, cf, ( 76958, -29665, -102 ), ( 90, 0, -115 ), "chalk_d_2" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_intel_create_script";
    fe [[ f ]]( s, us, cf, ( 54707, -31778.5, -96 ), ( 90, 326, -86 ), "chalk_d_3" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_intel_create_script";
    fe [[ f ]]( s, us, cf, ( 78214, -30666, -71 ), ( 90, 0, -78 ), "chalk_d_4" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_intel_create_script";
    fe [[ f ]]( s, us, cf, ( 57014, -31332, -104 ), ( 90, 0, -150 ), "chalk_d_1" );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace zm_sat_mantis_intel_create_script
// Params 0, eflags: 0x4
// Checksum 0x706106ed, Offset: 0x782
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace zm_sat_mantis_intel_create_script
// Params 0
// Checksum 0x93c352ea, Offset: 0x78c
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "zm_sat_mantis_intel_create_script" );
}

