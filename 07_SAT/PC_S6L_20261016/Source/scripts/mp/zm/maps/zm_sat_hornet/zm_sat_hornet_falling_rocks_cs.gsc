// scripts\mp\zm\maps\zm_sat_hornet\zm_sat_hornet_falling_rocks_cs.gsc  (hash_29e9a929e56cdbd5.gscc) (size: 1732 Bytes / 0x6c4 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x1b3a91f9 (456823289)
// size ...... 1732 (0x6c4)
// includes .. 2   (offset: 0x624)
// strings ... 9   (offset: 0x634)
// dev strs .. 0   (offset: 0x6c4)
// exports ... 6   (offset: 0x374)
// cseg ...... 0xf6 + 0x27e (0x374)
// imports ... 16  (offset: 0x464)
// animtree1 . 0   (offset: 0x6c4)
// animtree2 . 0   (offset: 0x6c4)
#using scripts\common\create_script_utility;
#using scripts\common\utility;

#namespace zm_sat_hornet_falling_rocks_cs;

// Namespace zm_sat_hornet_falling_rocks_cs
// Params 2
// Checksum 0xe06e45, Offset: 0x114
// Size: 0x80
function main( unused, unused2 )
{
    if ( utility::flag_exist( "zm_sat_hornet_falling_rocks_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "zm_sat_hornet_falling_rocks_cs" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "zm_sat_hornet_falling_rocks_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "zm_sat_hornet_falling_rocks_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace zm_sat_hornet_falling_rocks_cs
// Params 3, eflags: 0x4
// Checksum 0x338b8cc3, Offset: 0x19c
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "zm_sat_hornet_falling_rocks_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "zm_sat_hornet_falling_rocks_cs" );
}

// Namespace zm_sat_hornet_falling_rocks_cs
// Params 3, eflags: 0x4
// Checksum 0x9b60872b, Offset: 0x216
// Size: 0x13e
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "zm_sat_hornet_falling_rocks_cs";
    fe [[ f ]]( s, us, cf, ( 0, -24576, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_falling_rocks_cs";
    s.name = "falling_rock_center";
    s.script_radius = "1400";
    fe [[ f ]]( s, us, cf, ( -27635.5, 48230.1, 28772 ), ( 0, 0, 0 ), "fr_struct", undefined, "zm_boss_arena", undefined, undefined, undefined, undefined, 1500 );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_falling_rocks_cs";
    s.name = "earthquake_center";
    fe [[ f ]]( s, us, cf, ( -27572.4, 47124.6, 28769 ), ( 0, 0, 0 ), "fr_eq_loc" );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace zm_sat_hornet_falling_rocks_cs
// Params 0, eflags: 0x4
// Checksum 0xf184268d, Offset: 0x35c
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace zm_sat_hornet_falling_rocks_cs
// Params 0
// Checksum 0xf1d8518e, Offset: 0x366
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "zm_sat_hornet_falling_rocks_cs" );
}

