// scripts\mp\zm\maps\zm_sat_scarab\zm_sat_scarab_cr_create_script.gsc  (hash_7870243afbf8aff4.gscc) (size: 2834 Bytes / 0xb12 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xfad2269c (4208076444)
// size ...... 2834 (0xb12)
// includes .. 3   (offset: 0x9de)
// strings ... 11  (offset: 0x9f6)
// dev strs .. 0   (offset: 0xb12)
// exports ... 9   (offset: 0x646)
// cseg ...... 0x134 + 0x512 (0x646)
// imports ... 20  (offset: 0x7ae)
// animtree1 . 0   (offset: 0xb12)
// animtree2 . 0   (offset: 0xb12)
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace zm_sat_scarab_cr_create_script;

// Namespace zm_sat_scarab_cr_create_script
// Params 0, eflags: 0x5
// Checksum 0x855eef04, Offset: 0x152
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"zm_sat_scarab_cr_create_script", undefined, &function_b39ecd3d51489472, undefined );
}

// Namespace zm_sat_scarab_cr_create_script
// Params 0, eflags: 0x4
// Checksum 0xc2311157, Offset: 0x173
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace zm_sat_scarab_cr_create_script
// Params 0, eflags: 0x4
// Checksum 0x470ac2bb, Offset: 0x184
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace zm_sat_scarab_cr_create_script
// Params 2
// Checksum 0xf7e394f2, Offset: 0x195
// Size: 0x80
function main( unused, unused2 )
{
    if ( utility::flag_exist( "zm_sat_scarab_cr_create_script" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "zm_sat_scarab_cr_create_script" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "zm_sat_scarab_cr_create_script" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "zm_sat_scarab_cr_create_script" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace zm_sat_scarab_cr_create_script
// Params 3, eflags: 0x4
// Checksum 0xc4887674, Offset: 0x21d
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "zm_sat_scarab_cr_create_script" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "zm_sat_scarab_cr_create_script" );
}

// Namespace zm_sat_scarab_cr_create_script
// Params 3, eflags: 0x4
// Checksum 0xd983dcf5, Offset: 0x297
// Size: 0x38f
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "zm_sat_scarab_cr_create_script";
    s.name = "mrp_event_reward";
    fe [[ f ]]( s, us, cf, ( 811.42, -301.64, 1333.38 ), ( 0, 0, 0 ), "mrp_event_reward_0", undefined, "mrp_event_reward" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_cr_create_script";
    s.name = "mrp_event_reward";
    fe [[ f ]]( s, us, cf, ( -2149.54, -1860.85, 1286.68 ), ( 0, 0, 0 ), "mrp_event_reward_1", undefined, "mrp_event_reward" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_cr_create_script";
    s.name = "mrp_events";
    fe [[ f ]]( s, us, cf, ( -2853.67, -1524.96, 2128.01 ), ( 0, 5.1, 0 ), "mrp_event", "mrp_event_reward_1" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_cr_create_script";
    s.name = "mrp_event_reward";
    fe [[ f ]]( s, us, cf, ( -6588.52, -2391.85, 1543.63 ), ( 0, 0, 0 ), "mrp_event_reward_2", undefined, "mrp_event_reward" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_cr_create_script";
    s.name = "mrp_events";
    fe [[ f ]]( s, us, cf, ( -7550.04, -2303, 1184.35 ), ( 0, 5.1, 0 ), "mrp_event", "mrp_event_reward_2" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_cr_create_script";
    s.name = "mrp_event_reward";
    fe [[ f ]]( s, us, cf, ( -4867.68, 1055.35, 1997.71 ), ( 0, 0, 0 ), "mrp_event_reward_3", undefined, "mrp_event_reward" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_cr_create_script";
    s.name = "mrp_events";
    fe [[ f ]]( s, us, cf, ( -4186.18, 1653.59, 2298.34 ), ( 0, 221.1, 0 ), "mrp_event", "mrp_event_reward_3" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_cr_create_script";
    s.name = "mrp_event_reward";
    fe [[ f ]]( s, us, cf, ( 462.32, 3444.03, 1742.05 ), ( 0, 219.1, 0 ), "mrp_event_reward_4", undefined, "mrp_event_reward" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_cr_create_script";
    s.name = "mrp_events";
    fe [[ f ]]( s, us, cf, ( 905.73, 3390.52, 2170.91 ), ( 0, 151.5, 0 ), "mrp_event", "mrp_event_reward_4" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_cr_create_script";
    s.name = "mrp_events";
    fe [[ f ]]( s, us, cf, ( 952.84, -195.03, 2651.71 ), ( 0, 244.5, 0 ), "mrp_event", "mrp_event_reward_0" );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace zm_sat_scarab_cr_create_script
// Params 0, eflags: 0x4
// Checksum 0x580cbe6a, Offset: 0x62e
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace zm_sat_scarab_cr_create_script
// Params 0
// Checksum 0x6dbab39, Offset: 0x638
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "zm_sat_scarab_cr_create_script" );
}

