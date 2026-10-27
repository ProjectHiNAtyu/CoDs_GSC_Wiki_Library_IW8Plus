// scripts\mp\zm\maps\zm_sat_mantis\zm_sat_mantis_ee_jumpscare_cs.gsc  (hash_6a3dd77101f91b86.gscc) (size: 3011 Bytes / 0xbc3 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xc304e96b (3271879019)
// size ...... 3011 (0xbc3)
// includes .. 3   (offset: 0xa4f)
// strings ... 22  (offset: 0xa67)
// dev strs .. 0   (offset: 0xbc3)
// exports ... 9   (offset: 0x6b7)
// cseg ...... 0x195 + 0x522 (0x6b7)
// imports ... 20  (offset: 0x81f)
// animtree1 . 0   (offset: 0xbc3)
// animtree2 . 0   (offset: 0xbc3)
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace zm_sat_mantis_ee_jumpscare_cs;

// Namespace zm_sat_mantis_ee_jumpscare_cs
// Params 0, eflags: 0x5
// Checksum 0xe17fcac9, Offset: 0x1b3
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"zm_sat_mantis_ee_jumpscare_cs", undefined, &function_b39ecd3d51489472, undefined );
}

// Namespace zm_sat_mantis_ee_jumpscare_cs
// Params 0, eflags: 0x4
// Checksum 0x220054ce, Offset: 0x1d4
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace zm_sat_mantis_ee_jumpscare_cs
// Params 0, eflags: 0x4
// Checksum 0xa73b8722, Offset: 0x1e5
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace zm_sat_mantis_ee_jumpscare_cs
// Params 2
// Checksum 0x17d2d16b, Offset: 0x1f6
// Size: 0x80
function main( unused, unused2 )
{
    if ( utility::flag_exist( "zm_sat_mantis_ee_jumpscare_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "zm_sat_mantis_ee_jumpscare_cs" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "zm_sat_mantis_ee_jumpscare_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "zm_sat_mantis_ee_jumpscare_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace zm_sat_mantis_ee_jumpscare_cs
// Params 3, eflags: 0x4
// Checksum 0x24b933ed, Offset: 0x27e
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "zm_sat_mantis_ee_jumpscare_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "zm_sat_mantis_ee_jumpscare_cs" );
}

// Namespace zm_sat_mantis_ee_jumpscare_cs
// Params 3, eflags: 0x4
// Checksum 0x986f6c8d, Offset: 0x2f8
// Size: 0x39f
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "zm_sat_mantis_ee_jumpscare_cs";
    s.name = "antenna_loc";
    fe [[ f ]]( s, us, cf, ( 77782.1, -30502.1, 178.07 ), ( 0, 222.9, 0 ), undefined, undefined, "js_ee_antenna_loc" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_ee_jumpscare_cs";
    s.name = "orb_loc_2";
    fe [[ f ]]( s, us, cf, ( 75846.1, -30280.1, 300 ), ( 0, 203.9, 0 ), "2", undefined, "js_ee_orb_loc" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_ee_jumpscare_cs";
    s.name = "orb_loc_3";
    fe [[ f ]]( s, us, cf, ( 77148.1, -28668.1, 300 ), ( 0, 203.9, 0 ), "3", undefined, "js_ee_orb_loc" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_ee_jumpscare_cs";
    s.name = "orb_loc_4";
    fe [[ f ]]( s, us, cf, ( 79098.1, -29046.1, 300 ), ( 0, 203.9, 0 ), "4", undefined, "js_ee_orb_loc" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_ee_jumpscare_cs";
    s.name = "orb_loc_5";
    fe [[ f ]]( s, us, cf, ( 79836.1, -30802.1, 300 ), ( 0, 203.9, 0 ), "5", undefined, "js_ee_orb_loc" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_ee_jumpscare_cs";
    s.name = "orb_loc_6";
    fe [[ f ]]( s, us, cf, ( 78404.1, -32424.1, 300 ), ( 0, 203.9, 0 ), "6", undefined, "js_ee_orb_loc" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_ee_jumpscare_cs";
    s.name = "tv_loc";
    fe [[ f ]]( s, us, cf, ( 77769.6, -30574.6, 50.08 ), ( 0, 23.9, 0 ), undefined, "cspf_0_auto9132620263224643675", "js_ee_tv_loc" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_ee_jumpscare_cs";
    s.name = "tv_loc_target";
    fe [[ f ]]( s, us, cf, ( 77777, -30569.2, 42.78 ), ( 0, 27.5, 0 ), "cspf_0_auto9132620263224643675" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_ee_jumpscare_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s._size_max = ( 334, 196, 8 );
    s._size_min = ( 40, 27.853, 22 );
    s.height = 128;
    s.length = "128";
    s.width = "128";
    fe [[ f ]]( s, us, cf, ( 78011.1, -30336.7, 33.01 ), ( 0, 204.8, 0 ), undefined, undefined, "check_players_in_tv_room" );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace zm_sat_mantis_ee_jumpscare_cs
// Params 0, eflags: 0x4
// Checksum 0x39597a0c, Offset: 0x69f
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace zm_sat_mantis_ee_jumpscare_cs
// Params 0
// Checksum 0xe6eaeea0, Offset: 0x6a9
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "zm_sat_mantis_ee_jumpscare_cs" );
}

