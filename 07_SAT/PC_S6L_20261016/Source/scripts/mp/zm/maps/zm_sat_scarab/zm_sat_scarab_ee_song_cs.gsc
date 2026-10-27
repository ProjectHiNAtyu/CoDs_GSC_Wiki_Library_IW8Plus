// scripts\mp\zm\maps\zm_sat_scarab\zm_sat_scarab_ee_song_cs.gsc  (hash_6fe77262aaba8031.gscc) (size: 1881 Bytes / 0x759 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xfcffc23f (4244619839)
// size ...... 1881 (0x759)
// includes .. 3   (offset: 0x6e1)
// strings ... 5   (offset: 0x6f9)
// dev strs .. 0   (offset: 0x759)
// exports ... 9   (offset: 0x349)
// cseg ...... 0xc4 + 0x285 (0x349)
// imports ... 20  (offset: 0x4b1)
// animtree1 . 0   (offset: 0x759)
// animtree2 . 0   (offset: 0x759)
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace zm_sat_scarab_ee_song_cs;

// Namespace zm_sat_scarab_ee_song_cs
// Params 0, eflags: 0x5
// Checksum 0x36bdf64d, Offset: 0xe2
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"zm_sat_scarab_ee_song_cs", undefined, &function_b39ecd3d51489472, undefined );
}

// Namespace zm_sat_scarab_ee_song_cs
// Params 0, eflags: 0x4
// Checksum 0xf29cff, Offset: 0x103
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace zm_sat_scarab_ee_song_cs
// Params 0, eflags: 0x4
// Checksum 0x85c94f13, Offset: 0x114
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace zm_sat_scarab_ee_song_cs
// Params 2
// Checksum 0x3520195a, Offset: 0x125
// Size: 0x80
function main( unused, unused2 )
{
    if ( utility::flag_exist( "zm_sat_scarab_ee_song_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "zm_sat_scarab_ee_song_cs" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "zm_sat_scarab_ee_song_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "zm_sat_scarab_ee_song_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace zm_sat_scarab_ee_song_cs
// Params 3, eflags: 0x4
// Checksum 0x64bfbdc, Offset: 0x1ad
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "zm_sat_scarab_ee_song_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "zm_sat_scarab_ee_song_cs" );
}

// Namespace zm_sat_scarab_ee_song_cs
// Params 3, eflags: 0x4
// Checksum 0x7fddd0a8, Offset: 0x227
// Size: 0x102
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "zm_sat_scarab_ee_song_cs";
    fe [[ f ]]( s, us, cf, ( 329, -3723.5, 1924.25 ), ( 2.35, 330.61, -4.95 ), undefined, undefined, "ee_song_gramophone_record" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_ee_song_cs";
    fe [[ f ]]( s, us, cf, ( 328.16, -3724.11, 1913.54 ), ( 2.35, 330.61, -4.95 ), undefined, undefined, "ee_song_gramophone" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_ee_song_cs";
    fe [[ f ]]( s, us, cf, ( 0, -0.25, 0.25 ), ( 0, 0, 0 ) );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace zm_sat_scarab_ee_song_cs
// Params 0, eflags: 0x4
// Checksum 0x99599323, Offset: 0x331
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace zm_sat_scarab_ee_song_cs
// Params 0
// Checksum 0xc4182691, Offset: 0x33b
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "zm_sat_scarab_ee_song_cs" );
}

