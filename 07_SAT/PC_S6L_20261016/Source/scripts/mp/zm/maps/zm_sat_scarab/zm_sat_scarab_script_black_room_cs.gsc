// scripts\mp\zm\maps\zm_sat_scarab\zm_sat_scarab_script_black_room_cs.gsc  (hash_2914b3916066cb7e.gscc) (size: 3357 Bytes / 0xd1d / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x2ec89df8 (784899576)
// size ...... 3357 (0xd1d)
// includes .. 3   (offset: 0xba1)
// strings ... 19  (offset: 0xbb9)
// dev strs .. 0   (offset: 0xd1d)
// exports ... 9   (offset: 0x809)
// cseg ...... 0x23b + 0x5ce (0x809)
// imports ... 20  (offset: 0x971)
// animtree1 . 0   (offset: 0xd1d)
// animtree2 . 0   (offset: 0xd1d)
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace zm_sat_scarab_script_black_room_cs;

// Namespace zm_sat_scarab_script_black_room_cs
// Params 0, eflags: 0x5
// Checksum 0xac86023, Offset: 0x259
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"zm_sat_scarab_script_black_room_cs", undefined, &function_b39ecd3d51489472, undefined );
}

// Namespace zm_sat_scarab_script_black_room_cs
// Params 0, eflags: 0x4
// Checksum 0xd43766aa, Offset: 0x27a
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace zm_sat_scarab_script_black_room_cs
// Params 0, eflags: 0x4
// Checksum 0x510cb546, Offset: 0x28b
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace zm_sat_scarab_script_black_room_cs
// Params 2
// Checksum 0xe1e5e30f, Offset: 0x29c
// Size: 0x80
function main( unused, unused2 )
{
    if ( utility::flag_exist( "zm_sat_scarab_script_black_room_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "zm_sat_scarab_script_black_room_cs" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "zm_sat_scarab_script_black_room_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "zm_sat_scarab_script_black_room_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace zm_sat_scarab_script_black_room_cs
// Params 3, eflags: 0x4
// Checksum 0xd28e0189, Offset: 0x324
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "zm_sat_scarab_script_black_room_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "zm_sat_scarab_script_black_room_cs" );
}

// Namespace zm_sat_scarab_script_black_room_cs
// Params 3, eflags: 0x4
// Checksum 0x8308bc47, Offset: 0x39e
// Size: 0x44b
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_black_room_cs";
    s.name = "temple_2";
    fe [[ f ]]( s, us, cf, ( -3792.65, 2662.18, 1593 ), ( 0, 314.2, 0 ), "black_room_portal", "cspf_0_auto15132474903529437213" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_black_room_cs";
    s.name = "temple_3";
    fe [[ f ]]( s, us, cf, ( -5879.38, -928.19, 1673.94 ), ( 0, 180, 0 ), "black_room_portal", "cspf_0_auto10576586995787772830" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_black_room_cs";
    s.name = "temple_4";
    fe [[ f ]]( s, us, cf, ( 3733.34, 2144.71, 1875.5 ), ( 0, 315.14, 0 ), "black_room_portal", "cspf_0_auto11125090541932177243" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_black_room_cs";
    fe [[ f ]]( s, us, cf, ( 4920, -1575, 1529 ), ( 0, 180, 0 ), "black_room_center" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_black_room_cs";
    fe [[ f ]]( s, us, cf, ( 5224, -1575, 1529 ), ( 0, 180, 0 ), "black_room_player_transport" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_black_room_cs";
    fe [[ f ]]( s, us, cf, ( 4122.5, -2391, 1305 ), ( 0, 180.88, 0 ), "cspf_0_auto7733065570360506469" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_black_room_cs";
    fe [[ f ]]( s, us, cf, ( -3675.5, 2558, 1512 ), ( 0, 0, 0 ), "cspf_0_auto18006420777393432375" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_black_room_cs";
    fe [[ f ]]( s, us, cf, ( -6022, -940.5, 1616 ), ( 0, 0, 0 ), "cspf_0_auto9572323405812869053" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_black_room_cs";
    fe [[ f ]]( s, us, cf, ( 3824, 2064, 1814 ), ( 0, 0, 0 ), "cspf_0_auto13773883606427170331" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_black_room_cs";
    fe [[ f ]]( s, us, cf, ( 4920, -1577, 1557 ), ( 0, 180, 0 ), "cage_fx_origin" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_black_room_cs";
    fe [[ f ]]( s, us, cf, ( 4188.5, -2389.5, 1307 ), ( 0, 178.46, 0 ), "cspf_0_auto7792535058605645667", "cspf_0_auto7733065570360506469" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_black_room_cs";
    fe [[ f ]]( s, us, cf, ( -3737.5, 2622.5, 1512 ), ( 0, 313.73, 0 ), "cspf_0_auto15132474903529437213", "cspf_0_auto18006420777393432375" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_black_room_cs";
    fe [[ f ]]( s, us, cf, ( -5942, -940, 1616 ), ( 0, 179.09, 0 ), "cspf_0_auto10576586995787772830", "cspf_0_auto9572323405812869053" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_black_room_cs";
    fe [[ f ]]( s, us, cf, ( 3776, 2112.5, 1814 ), ( 0, 314.89, 0 ), "cspf_0_auto11125090541932177243", "cspf_0_auto13773883606427170331" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_black_room_cs";
    s.name = "temple_1";
    fe [[ f ]]( s, us, cf, ( 4258.78, -2399.05, 1378.5 ), ( 0, 0, 0 ), "black_room_portal", "cspf_0_auto7792535058605645667" );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace zm_sat_scarab_script_black_room_cs
// Params 0, eflags: 0x4
// Checksum 0xb4d8031c, Offset: 0x7f1
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace zm_sat_scarab_script_black_room_cs
// Params 0
// Checksum 0x10dddcc4, Offset: 0x7fb
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "zm_sat_scarab_script_black_room_cs" );
}

