// scripts\mp\zm\maps\zm_sat_locust\zm_sat_locust_rh_create_script.gsc  (hash_40d18fedac31cf1b.gscc) (size: 2397 Bytes / 0x95d / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xd4bb8701 (3569059585)
// size ...... 2397 (0x95d)
// includes .. 3   (offset: 0x895)
// strings ... 8   (offset: 0x8ad)
// dev strs .. 0   (offset: 0x95d)
// exports ... 9   (offset: 0x4fd)
// cseg ...... 0xd1 + 0x42c (0x4fd)
// imports ... 20  (offset: 0x665)
// animtree1 . 0   (offset: 0x95d)
// animtree2 . 0   (offset: 0x95d)
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace zm_sat_locust_rh_create_script;

// Namespace zm_sat_locust_rh_create_script
// Params 0, eflags: 0x5
// Checksum 0x8051a7e6, Offset: 0xef
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"zm_sat_locust_rh_create_script", undefined, &function_b39ecd3d51489472, undefined );
}

// Namespace zm_sat_locust_rh_create_script
// Params 0, eflags: 0x4
// Checksum 0xe40dd7a, Offset: 0x110
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace zm_sat_locust_rh_create_script
// Params 0, eflags: 0x4
// Checksum 0x8b7b0e96, Offset: 0x121
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace zm_sat_locust_rh_create_script
// Params 2
// Checksum 0x3b9258df, Offset: 0x132
// Size: 0x80
function main( unused, unused2 )
{
    if ( utility::flag_exist( "zm_sat_locust_rh_create_script" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "zm_sat_locust_rh_create_script" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "zm_sat_locust_rh_create_script" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "zm_sat_locust_rh_create_script" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace zm_sat_locust_rh_create_script
// Params 3, eflags: 0x4
// Checksum 0x8f9ba59, Offset: 0x1ba
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "zm_sat_locust_rh_create_script" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "zm_sat_locust_rh_create_script" );
}

// Namespace zm_sat_locust_rh_create_script
// Params 3, eflags: 0x4
// Checksum 0xbbc57b63, Offset: 0x234
// Size: 0x2a9
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "zm_sat_locust_rh_create_script";
    fe [[ f ]]( s, us, cf, ( 2905, 4087, 103.85 ), ( 0, 282.4, 0 ), "tb_wat_final" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_rh_create_script";
    fe [[ f ]]( s, us, cf, ( 2684, 4302, 40.85 ), ( 0, 291.8, 0 ), "tb_wat" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_rh_create_script";
    fe [[ f ]]( s, us, cf, ( 2802, 4230, 256 ), ( 0, 291.8, 0 ), "tb_wat_mid" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_rh_create_script";
    fe [[ f ]]( s, us, cf, ( 6250, 7256, 276 ), ( 0, 278.9, 0 ), "fk_sp" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_rh_create_script";
    fe [[ f ]]( s, us, cf, ( 6651, 6905, 276 ), ( 0, 191.3, 0 ), "fk_sp" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_rh_create_script";
    fe [[ f ]]( s, us, cf, ( 5991, 7490, 276 ), ( 0, 278.9, 0 ), "fk_sp" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_rh_create_script";
    fe [[ f ]]( s, us, cf, ( 5648, 7445, 270 ), ( 0, 266.9, 0 ), "fk_sp" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_rh_create_script";
    fe [[ f ]]( s, us, cf, ( 5981, 6432, 273 ), ( 0, 151.6, 0 ), "fk_sp" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_rh_create_script";
    fe [[ f ]]( s, us, cf, ( 6401, 1407, 376 ), ( 7.12, 281.17, -2.26 ), "kk_sp" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_rh_create_script";
    fe [[ f ]]( s, us, cf, ( 2693, 4300, 57 ), ( 0, 0, 0 ) );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace zm_sat_locust_rh_create_script
// Params 0, eflags: 0x4
// Checksum 0x2f66ad5d, Offset: 0x4e5
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace zm_sat_locust_rh_create_script
// Params 0
// Checksum 0xcaaa6714, Offset: 0x4ef
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "zm_sat_locust_rh_create_script" );
}

