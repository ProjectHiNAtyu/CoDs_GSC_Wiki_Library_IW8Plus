// script_4ec9bbe3ec3ab2bd  (hash_4ec9bbe3ec3ab2bd.gscc) (size: 2407 Bytes / 0x967 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x72950513 (1922368787)
// size ...... 2407 (0x967)
// includes .. 3   (offset: 0x893)
// strings ... 10  (offset: 0x8ab)
// dev strs .. 0   (offset: 0x967)
// exports ... 9   (offset: 0x4fb)
// cseg ...... 0x107 + 0x3f4 (0x4fb)
// imports ... 20  (offset: 0x663)
// animtree1 . 0   (offset: 0x967)
// animtree2 . 0   (offset: 0x967)
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace zm_sat_mantis_relic_create_script;

// Namespace zm_sat_mantis_relic_create_script
// Params 0, eflags: 0x5
// Checksum 0xebf7a35c, Offset: 0x125
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"zm_sat_mantis_relic_create_script", undefined, &function_b39ecd3d51489472, undefined );
}

// Namespace zm_sat_mantis_relic_create_script
// Params 0, eflags: 0x4
// Checksum 0xec1dd0fd, Offset: 0x146
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace zm_sat_mantis_relic_create_script
// Params 0, eflags: 0x4
// Checksum 0x69260311, Offset: 0x157
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace zm_sat_mantis_relic_create_script
// Params 2
// Checksum 0xd9cf5558, Offset: 0x168
// Size: 0x80
function main( unused, unused2 )
{
    if ( utility::flag_exist( "zm_sat_mantis_relic_create_script" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "zm_sat_mantis_relic_create_script" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "zm_sat_mantis_relic_create_script" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "zm_sat_mantis_relic_create_script" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace zm_sat_mantis_relic_create_script
// Params 3, eflags: 0x4
// Checksum 0xeaa4b7de, Offset: 0x1f0
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "zm_sat_mantis_relic_create_script" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "zm_sat_mantis_relic_create_script" );
}

// Namespace zm_sat_mantis_relic_create_script
// Params 3, eflags: 0x4
// Checksum 0xad27db3b, Offset: 0x26a
// Size: 0x271
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "zm_sat_mantis_relic_create_script";
    fe [[ f ]]( s, us, cf, ( 54151.2, -33500.4, -114.68 ), ( 0, 0, 0 ), "stand_location" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_relic_create_script";
    fe [[ f ]]( s, us, cf, ( 55438.7, -32179.7, 85.84 ), ( 0, 0, 0 ), "flame_trigger" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_relic_create_script";
    fe [[ f ]]( s, us, cf, ( 55680.2, -31967.7, -103.19 ), ( 0, 0, 0 ), "bbq_check" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_relic_create_script";
    fe [[ f ]]( s, us, cf, ( 53767.4, -31025.1, -103.19 ), ( 0, 0, 0 ), "bbq_check" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_relic_create_script";
    fe [[ f ]]( s, us, cf, ( 75696.4, -30192.5, 38.97 ), ( 0, 0, 0 ), "electrical_target" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_relic_create_script";
    fe [[ f ]]( s, us, cf, ( 79046.2, -31452.2, 74.15 ), ( 0, 0, 0 ), "roof_trigger" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_relic_create_script";
    fe [[ f ]]( s, us, cf, ( 75436.3, -30466.4, 38.97 ), ( 0, 0, 0 ), "electrical_target" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_relic_create_script";
    fe [[ f ]]( s, us, cf, ( 76745.6, -33005.5, -47.93 ), ( 0, 0, 0 ), "key_loc" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_relic_create_script";
    fe [[ f ]]( s, us, cf, ( 54869.1, -31296, -114.68 ), ( 0, 0, 0 ), "bomb_zone" );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace zm_sat_mantis_relic_create_script
// Params 0, eflags: 0x4
// Checksum 0x8ddc2b6a, Offset: 0x4e3
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace zm_sat_mantis_relic_create_script
// Params 0
// Checksum 0x28f76a93, Offset: 0x4ed
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "zm_sat_mantis_relic_create_script" );
}

