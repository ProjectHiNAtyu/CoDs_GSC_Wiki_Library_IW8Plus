// scripts\mp\zm\maps\zm_sat_locust\zm_sat_locust_rej_cs.gsc  (hash_7be71f31a4a0b504.gscc) (size: 4611 Bytes / 0x1203 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x80f508e0 (2163542240)
// size ...... 4611 (0x1203)
// includes .. 3   (offset: 0x101f)
// strings ... 19  (offset: 0x1037)
// dev strs .. 0   (offset: 0x1203)
// exports ... 9   (offset: 0xc03)
// cseg ...... 0x1d1 + 0xa32 (0xc03)
// imports ... 21  (offset: 0xd6b)
// animtree1 . 0   (offset: 0x1203)
// animtree2 . 0   (offset: 0x1203)
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace zm_sat_locust_rej_cs;

// Namespace zm_sat_locust_rej_cs
// Params 0, eflags: 0x5
// Checksum 0xe39b28f1, Offset: 0x1ef
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"zm_sat_locust_rej_cs", undefined, &function_b39ecd3d51489472, undefined );
}

// Namespace zm_sat_locust_rej_cs
// Params 0, eflags: 0x4
// Checksum 0x57247ffa, Offset: 0x210
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace zm_sat_locust_rej_cs
// Params 0, eflags: 0x4
// Checksum 0xd21fac16, Offset: 0x221
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace zm_sat_locust_rej_cs
// Params 2
// Checksum 0x62f6fa5f, Offset: 0x232
// Size: 0x80
function main( unused, unused2 )
{
    if ( utility::flag_exist( "zm_sat_locust_rej_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "zm_sat_locust_rej_cs" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "zm_sat_locust_rej_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "zm_sat_locust_rej_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace zm_sat_locust_rej_cs
// Params 3, eflags: 0x4
// Checksum 0x519d18d9, Offset: 0x2ba
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "zm_sat_locust_rej_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "zm_sat_locust_rej_cs" );
}

// Namespace zm_sat_locust_rej_cs
// Params 3, eflags: 0x4
// Checksum 0x3f3c317d, Offset: 0x334
// Size: 0x8af
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "zm_sat_locust_rej_cs";
    s.groupid = "Downtown Tube";
    s.script_int = int( 4 );
    s.script_radius = int( 64 );
    s.script_string = "downtown";
    fe [[ f ]]( s, us, cf, ( 3279, 9791, 1624 ), ( 0, 228.31, 0 ), "robot_ejection_tube", "cspf_0_auto3278687741270138455" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_rej_cs";
    s.groupid = "random_landing";
    s.script_int = int( 3000 );
    fe [[ f ]]( s, us, cf, ( 2342, 980, 219.56 ), ( 0, 92, 0 ), "random_landing" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_rej_cs";
    s.groupid = "Shipyard Tube";
    s.script_int = int( 3000 );
    fe [[ f ]]( s, us, cf, ( 1066, 3536, -151.86 ), ( 0, 210, 0 ), "cspf_0_auto8837817623719977927" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_rej_cs";
    s.groupid = "Downtown Tube";
    s.script_int = int( 3000 );
    fe [[ f ]]( s, us, cf, ( 4044, 3606, 108.09 ), ( 0, 165, 0 ), "cspf_0_auto3278687741270138455" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_rej_cs";
    s.groupid = "random_landing";
    s.script_int = int( 3000 );
    fe [[ f ]]( s, us, cf, ( 3722, -520, 209.6 ), ( 0, 92, 0 ), "random_landing" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_rej_cs";
    s.groupid = "Shipyard Tube";
    s.script_int = int( 1 );
    s.script_radius = int( 64 );
    s.script_string = "shipyard";
    fe [[ f ]]( s, us, cf, ( 3114, 9882, 1624 ), ( 0, 264.61, 0 ), "robot_ejection_tube", "cspf_0_auto8837817623719977927" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_rej_cs";
    s.groupid = "random_landing";
    s.script_int = int( 3000 );
    fe [[ f ]]( s, us, cf, ( 5898, 1568, 107.53 ), ( 0, 5, 0 ), "random_landing" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_rej_cs";
    s.groupid = "random_landing";
    s.script_int = int( 3000 );
    fe [[ f ]]( s, us, cf, ( 4794, 5672, 223.98 ), ( 0, 172, 0 ), "random_landing" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_rej_cs";
    s.groupid = "random_landing";
    s.script_int = int( 3000 );
    fe [[ f ]]( s, us, cf, ( 1918, 7708, 504.79 ), ( 0, 18.7, 0 ), "random_landing" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_rej_cs";
    s.groupid = "random_landing";
    s.script_int = int( 3000 );
    fe [[ f ]]( s, us, cf, ( -532, 5952, 304.13 ), ( 0, 208, 0 ), "random_landing" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_rej_cs";
    s.groupid = "Narrative Rooms";
    s.script_index = int( 3 );
    s.script_int = int( 24 );
    fe [[ f ]]( s, us, cf, ( 5390.92, 10293.9, 671.5 ), ( 0, 360, 0 ), "narrative_room" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_rej_cs";
    s.groupid = "Foundry Tube";
    s.script_int = int( 2 );
    s.script_radius = int( 64 );
    s.script_string = "foundry";
    fe [[ f ]]( s, us, cf, ( 3176, 9872, 1624 ), ( 0, 251.61, 0 ), "robot_ejection_tube", "cspf_0_auto7651188284169098334" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_rej_cs";
    s.groupid = "Narrative Rooms";
    s.script_index = int( 2 );
    s.script_int = int( 24 );
    fe [[ f ]]( s, us, cf, ( 6897.72, 9989.47, 671.5 ), ( 0, 270, 0 ), "narrative_room" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_rej_cs";
    s.groupid = "Narrative Rooms";
    s.script_index = int( 1 );
    s.script_int = int( 24 );
    fe [[ f ]]( s, us, cf, ( 6584.83, 9940.47, 671.5 ), ( 0, 180, 0 ), "narrative_room" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_rej_cs";
    s.groupid = "Market Tube";
    s.script_int = int( 3 );
    s.script_radius = int( 64 );
    s.script_string = "market";
    fe [[ f ]]( s, us, cf, ( 3236, 9840, 1624 ), ( 0, 239.31, 0 ), "robot_ejection_tube", "cspf_0_auto6945437370069470719" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_rej_cs";
    s.groupid = "Market Tube";
    s.script_int = int( 3000 );
    fe [[ f ]]( s, us, cf, ( 4788, 5632, 223.98 ), ( 0, 172, 0 ), "cspf_0_auto6945437370069470719" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_rej_cs";
    s.groupid = "Foundry Tube";
    s.script_int = int( 3000 );
    fe [[ f ]]( s, us, cf, ( -516, 5920, 304.13 ), ( 0, 208, 0 ), "cspf_0_auto7651188284169098334" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_rej_cs";
    s.groupid = "random_landing";
    s.script_int = int( 3000 );
    fe [[ f ]]( s, us, cf, ( 4058, 3652, 108.46 ), ( 0, 165, 0 ), "random_landing" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_rej_cs";
    s.groupid = "random_landing";
    s.script_int = int( 3000 );
    fe [[ f ]]( s, us, cf, ( 1090, 3496, -152 ), ( 0, 210, 0 ), "random_landing" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_rej_cs";
    s.groupid = "random_landing";
    s.script_int = int( 3000 );
    fe [[ f ]]( s, us, cf, ( 1698, 5836, 57 ), ( 0, 93.7, 0 ), "random_landing" );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace zm_sat_locust_rej_cs
// Params 0, eflags: 0x4
// Checksum 0xbe9f7376, Offset: 0xbeb
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace zm_sat_locust_rej_cs
// Params 0
// Checksum 0x93cec594, Offset: 0xbf5
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "zm_sat_locust_rej_cs" );
}

