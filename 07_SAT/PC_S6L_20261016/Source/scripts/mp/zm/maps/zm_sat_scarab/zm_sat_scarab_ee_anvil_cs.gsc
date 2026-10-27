// scripts\mp\zm\maps\zm_sat_scarab\zm_sat_scarab_ee_anvil_cs.gsc  (hash_673ed437de3aa2f8.gscc) (size: 2557 Bytes / 0x9fd / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x5b857386 (1535472518)
// size ...... 2557 (0x9fd)
// includes .. 3   (offset: 0x931)
// strings ... 6   (offset: 0x949)
// dev strs .. 0   (offset: 0x9fd)
// exports ... 9   (offset: 0x599)
// cseg ...... 0xd6 + 0x4c3 (0x599)
// imports ... 20  (offset: 0x701)
// animtree1 . 0   (offset: 0x9fd)
// animtree2 . 0   (offset: 0x9fd)
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace zm_sat_scarab_ee_anvil_cs;

// Namespace zm_sat_scarab_ee_anvil_cs
// Params 0, eflags: 0x5
// Checksum 0x13ce1fb4, Offset: 0xf4
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"zm_sat_scarab_ee_anvil_cs", undefined, &function_b39ecd3d51489472, undefined );
}

// Namespace zm_sat_scarab_ee_anvil_cs
// Params 0, eflags: 0x4
// Checksum 0x737eb773, Offset: 0x115
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace zm_sat_scarab_ee_anvil_cs
// Params 0, eflags: 0x4
// Checksum 0xf645649f, Offset: 0x126
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace zm_sat_scarab_ee_anvil_cs
// Params 2
// Checksum 0x46ac32d6, Offset: 0x137
// Size: 0x80
function main( unused, unused2 )
{
    if ( utility::flag_exist( "zm_sat_scarab_ee_anvil_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "zm_sat_scarab_ee_anvil_cs" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "zm_sat_scarab_ee_anvil_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "zm_sat_scarab_ee_anvil_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace zm_sat_scarab_ee_anvil_cs
// Params 3, eflags: 0x4
// Checksum 0x75c7d050, Offset: 0x1bf
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "zm_sat_scarab_ee_anvil_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "zm_sat_scarab_ee_anvil_cs" );
}

// Namespace zm_sat_scarab_ee_anvil_cs
// Params 3, eflags: 0x4
// Checksum 0x17891726, Offset: 0x239
// Size: 0x340
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "zm_sat_scarab_ee_anvil_cs";
    fe [[ f ]]( s, us, cf, ( 3288.54, 2444.47, 2330.58 ), ( 0, 316.96, 0.83 ), undefined, undefined, "ee_anvil_offer_loc" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_ee_anvil_cs";
    fe [[ f ]]( s, us, cf, ( 3268.62, 2511.54, 2276.99 ), ( 0, 43.55, 0 ), undefined, undefined, "ee_anvil_reward_loc" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_ee_anvil_cs";
    fe [[ f ]]( s, us, cf, ( 3341.38, 2481.33, 2276.98 ), ( 0, 43.55, 0 ), undefined, undefined, "ee_anvil_reward_loc" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_ee_anvil_cs";
    fe [[ f ]]( s, us, cf, ( 3298.37, 2489.64, 2276.99 ), ( 0, 43.55, 0 ), undefined, undefined, "ee_anvil_reward_loc" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_ee_anvil_cs";
    fe [[ f ]]( s, us, cf, ( 3371.16, 2495.69, 2276.99 ), ( 0, 43.55, 0 ), undefined, undefined, "ee_anvil_reward_loc" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_ee_anvil_cs";
    fe [[ f ]]( s, us, cf, ( 3328.82, 2459.55, 2276.99 ), ( 0, 43.55, 0 ), undefined, undefined, "ee_anvil_reward_loc" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_ee_anvil_cs";
    fe [[ f ]]( s, us, cf, ( 3314.58, 2523.81, 2276.99 ), ( 0, 43.55, 0 ), undefined, undefined, "ee_anvil_reward_loc" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_ee_anvil_cs";
    fe [[ f ]]( s, us, cf, ( 3327.84, 2501.11, 2276.99 ), ( 0, 43.55, 0 ), undefined, undefined, "ee_anvil_reward_loc" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_ee_anvil_cs";
    fe [[ f ]]( s, us, cf, ( 3361.02, 2429.01, 2276.99 ), ( 0, 49.69, 0 ), undefined, undefined, "ee_anvil_reward_loc" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_ee_anvil_cs";
    fe [[ f ]]( s, us, cf, ( 3286.9, 2445.42, 2328 ), ( 0, 316.96, -0.88 ), undefined, undefined, "ee_anvil_gunlet_loc" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_ee_anvil_cs";
    fe [[ f ]]( s, us, cf, ( 3367.15, 2460.41, 2276.98 ), ( 0, 43.55, 0 ), undefined, undefined, "ee_anvil_reward_loc" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_ee_anvil_cs";
    fe [[ f ]]( s, us, cf, ( 3349.04, 2526.65, 2276.99 ), ( 0, 43.55, 0 ), undefined, undefined, "ee_anvil_reward_loc" );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace zm_sat_scarab_ee_anvil_cs
// Params 0, eflags: 0x4
// Checksum 0x6510afd0, Offset: 0x581
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace zm_sat_scarab_ee_anvil_cs
// Params 0
// Checksum 0xb7940d1d, Offset: 0x58b
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "zm_sat_scarab_ee_anvil_cs" );
}

