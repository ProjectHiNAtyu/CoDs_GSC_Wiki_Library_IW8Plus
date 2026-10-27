// scripts\mp\zm\maps\zm_sat_hornet\zm_sat_hornet_intel_create_script.gsc  (hash_499b0ee9b321b37f.gscc) (size: 4169 Bytes / 0x1049 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x1d39b9e7 (490322407)
// size ...... 4169 (0x1049)
// includes .. 3   (offset: 0xe65)
// strings ... 24  (offset: 0xe7d)
// dev strs .. 0   (offset: 0x1049)
// exports ... 9   (offset: 0xacd)
// cseg ...... 0x2f8 + 0x7d5 (0xacd)
// imports ... 20  (offset: 0xc35)
// animtree1 . 0   (offset: 0x1049)
// animtree2 . 0   (offset: 0x1049)
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace zm_sat_hornet_intel_create_script;

// Namespace zm_sat_hornet_intel_create_script
// Params 0, eflags: 0x5
// Checksum 0x30a020ed, Offset: 0x316
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"zm_sat_hornet_intel_create_script", undefined, &function_b39ecd3d51489472, undefined );
}

// Namespace zm_sat_hornet_intel_create_script
// Params 0, eflags: 0x4
// Checksum 0x1dc2a143, Offset: 0x337
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace zm_sat_hornet_intel_create_script
// Params 0, eflags: 0x4
// Checksum 0x98f972af, Offset: 0x348
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace zm_sat_hornet_intel_create_script
// Params 2
// Checksum 0x281024e6, Offset: 0x359
// Size: 0x80
function main( unused, unused2 )
{
    if ( utility::flag_exist( "zm_sat_hornet_intel_create_script" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "zm_sat_hornet_intel_create_script" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "zm_sat_hornet_intel_create_script" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "zm_sat_hornet_intel_create_script" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace zm_sat_hornet_intel_create_script
// Params 3, eflags: 0x4
// Checksum 0x1b7bc660, Offset: 0x3e1
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "zm_sat_hornet_intel_create_script" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "zm_sat_hornet_intel_create_script" );
}

// Namespace zm_sat_hornet_intel_create_script
// Params 3, eflags: 0x4
// Checksum 0x4d5bca94, Offset: 0x45b
// Size: 0x652
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "zm_sat_hornet_intel_create_script";
    s.script_string = "zmintel_sat_hornet_audiolog_8";
    fe [[ f ]]( s, us, cf, ( 3134.5, -24103.2, 93 ), ( 0, 195.25, 0 ), undefined, undefined, "zombie_intel" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_intel_create_script";
    s.script_string = "zmintel_sat_hornet_audiolog_7";
    fe [[ f ]]( s, us, cf, ( 737, -23850, 135 ), ( 0, 345.5, 0 ), undefined, undefined, "zombie_intel" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_intel_create_script";
    s.script_string = "zmintel_sat_hornet_audiolog_9";
    fe [[ f ]]( s, us, cf, ( -2523, -22292, 338 ), ( 0, 336.3, 0 ), undefined, undefined, "zombie_intel" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_intel_create_script";
    fe [[ f ]]( s, us, cf, ( 3050.5, -21486.5, 414.75 ), ( 0, 120.1, 0 ), "doc6_interact_landing1" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_intel_create_script";
    fe [[ f ]]( s, us, cf, ( 3202.5, -21419.8, 435.75 ), ( 0, 152.96, 0 ), "hornet_document6_interact", undefined, "doc6_interact_landing4" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_intel_create_script";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( -207, -17017, 1381 ), ( 0, 0, 0 ), "hornet_scroll_stack" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_intel_create_script";
    fe [[ f ]]( s, us, cf, ( -752.5, -17956.5, 1059 ), ( 0, 198.42, 0 ), "zmintel_sat_hornet_audiolog_11" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_intel_create_script";
    fe [[ f ]]( s, us, cf, ( 3139, -21276, 442 ), ( 0, 0, 0 ), "hornet_document6_interact" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_intel_create_script";
    fe [[ f ]]( s, us, cf, ( 3073, -21541, 452 ), ( 0, 120.1, 0 ), "hornet_document6_interact", undefined, "doc6_interact_landing1" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_intel_create_script";
    fe [[ f ]]( s, us, cf, ( 3297, -21340, 432 ), ( 0, 133.1, 0 ), "hornet_document6_interact", undefined, "doc6_interact_landing3" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_intel_create_script";
    fe [[ f ]]( s, us, cf, ( 3187, -20760, 427 ), ( 0, 286.7, 0 ), "hornet_document6_interact", undefined, "doc6_interact_landing2" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_intel_create_script";
    s.groupid = "evidence_room_locs";
    fe [[ f ]]( s, us, cf, ( -1295.87, -17710.4, 1205.75 ), ( 0, 12.02, 0 ), "zmintel_sat_hornet_audiolog_1" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_intel_create_script";
    fe [[ f ]]( s, us, cf, ( 824.75, -17176.2, 1376.5 ), ( 0, 191.27, 0 ), "zmintel_sat_hornet_audiolog_6" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_intel_create_script";
    s.groupid = "evidence_room_locs";
    fe [[ f ]]( s, us, cf, ( -1321.81, -17744.5, 1223.75 ), ( 0, 12.02, 0 ), "zmintel_sat_hornet_audiolog_2" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_intel_create_script";
    fe [[ f ]]( s, us, cf, ( -244, -19280.2, 1169.25 ), ( 24.7, 359.96, -2.52 ), "hornet_audiolog_10_landing" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_intel_create_script";
    s.groupid = "evidence_room_locs";
    fe [[ f ]]( s, us, cf, ( -1312.34, -17776.5, 1207.89 ), ( 0.13, 304.5, -0.75 ), "zmintel_sat_hornet_audiolog_3" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_intel_create_script";
    s.groupid = "evidence_room_locs";
    fe [[ f ]]( s, us, cf, ( -1312.84, -17712.3, 1241.5 ), ( 0, 298.58, 0 ), "zmintel_sat_hornet_audiolog_4" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_intel_create_script";
    s.groupid = "evidence_room_locs";
    fe [[ f ]]( s, us, cf, ( -1324.85, -17729.3, 1205.5 ), ( 0, 12, 0 ), "zmintel_sat_hornet_audiolog_5" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_intel_create_script";
    s.groupid = "evidence_room_locs";
    fe [[ f ]]( s, us, cf, ( -1298.04, -17813.6, 1207.93 ), ( 0.7, 12.02, -0.21 ), "zmintel_sat_hornet_audiolog_12" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_intel_create_script";
    fe [[ f ]]( s, us, cf, ( 3196, -20783.5, 381.75 ), ( 0, 286.7, 0 ), "doc6_interact_landing2" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_intel_create_script";
    fe [[ f ]]( s, us, cf, ( 3292, -21297, 389.5 ), ( 0, 286.7, 0 ), "doc6_interact_landing3" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_intel_create_script";
    fe [[ f ]]( s, us, cf, ( 3212, -21385.3, 399.25 ), ( 0, 152.96, 0 ), "doc6_interact_landing4" );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace zm_sat_hornet_intel_create_script
// Params 0, eflags: 0x4
// Checksum 0x14eb7875, Offset: 0xab5
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace zm_sat_hornet_intel_create_script
// Params 0
// Checksum 0xd9281b2d, Offset: 0xabf
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "zm_sat_hornet_intel_create_script" );
}

