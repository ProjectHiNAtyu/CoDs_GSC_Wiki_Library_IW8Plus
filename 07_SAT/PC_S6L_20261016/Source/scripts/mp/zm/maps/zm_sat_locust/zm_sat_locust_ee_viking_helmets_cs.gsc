// scripts\mp\zm\maps\zm_sat_locust\zm_sat_locust_ee_viking_helmets_cs.gsc  (hash_3cb36b3672257237.gscc) (size: 2010 Bytes / 0x7da / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xf66e9059 (4134441049)
// size ...... 2010 (0x7da)
// includes .. 3   (offset: 0x72e)
// strings ... 8   (offset: 0x746)
// dev strs .. 0   (offset: 0x7da)
// exports ... 9   (offset: 0x396)
// cseg ...... 0xbb + 0x2db (0x396)
// imports ... 20  (offset: 0x4fe)
// animtree1 . 0   (offset: 0x7da)
// animtree2 . 0   (offset: 0x7da)
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace zm_sat_locust_ee_viking_helmets_cs;

// Namespace zm_sat_locust_ee_viking_helmets_cs
// Params 0, eflags: 0x5
// Checksum 0x85f20544, Offset: 0xd9
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"zm_sat_locust_ee_viking_helmets_cs", undefined, &function_b39ecd3d51489472, undefined );
}

// Namespace zm_sat_locust_ee_viking_helmets_cs
// Params 0, eflags: 0x4
// Checksum 0x859cc094, Offset: 0xfa
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace zm_sat_locust_ee_viking_helmets_cs
// Params 0, eflags: 0x4
// Checksum 0xa71378, Offset: 0x10b
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace zm_sat_locust_ee_viking_helmets_cs
// Params 2
// Checksum 0xb04e4531, Offset: 0x11c
// Size: 0x80
function main( unused, unused2 )
{
    if ( utility::flag_exist( "zm_sat_locust_ee_viking_helmets_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "zm_sat_locust_ee_viking_helmets_cs" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "zm_sat_locust_ee_viking_helmets_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "zm_sat_locust_ee_viking_helmets_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace zm_sat_locust_ee_viking_helmets_cs
// Params 3, eflags: 0x4
// Checksum 0x8325a7b7, Offset: 0x1a4
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "zm_sat_locust_ee_viking_helmets_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "zm_sat_locust_ee_viking_helmets_cs" );
}

// Namespace zm_sat_locust_ee_viking_helmets_cs
// Params 3, eflags: 0x4
// Checksum 0x55110468, Offset: 0x21e
// Size: 0x158
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_viking_helmets_cs";
    fe [[ f ]]( s, us, cf, ( 5165.99, 4042.15, 181.79 ), ( 0, 313.62, 0 ), "vi_he_lo", undefined, "3" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_viking_helmets_cs";
    fe [[ f ]]( s, us, cf, ( 5011.14, 4043.77, 181.78 ), ( 0, 245.76, 0 ), "vi_he_lo", undefined, "2" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_viking_helmets_cs";
    fe [[ f ]]( s, us, cf, ( 4718.2, 3806.32, 181.8 ), ( 0, 40.43, 0 ), "vi_he_lo", undefined, "1" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_viking_helmets_cs";
    fe [[ f ]]( s, us, cf, ( 5470.52, 3807.28, 181.85 ), ( 0, 125, 0 ), "vi_he_lo", undefined, "4" );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace zm_sat_locust_ee_viking_helmets_cs
// Params 0, eflags: 0x4
// Checksum 0x817bb23d, Offset: 0x37e
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace zm_sat_locust_ee_viking_helmets_cs
// Params 0
// Checksum 0x41767afa, Offset: 0x388
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "zm_sat_locust_ee_viking_helmets_cs" );
}

