// scripts\mp\zm\maps\zm_sat_hornet\zm_sat_hornet_ee_kodomo_cs.gsc  (hash_3b9345851af5d8d3.gscc) (size: 1690 Bytes / 0x69a / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x1d14a74e (487892814)
// size ...... 1690 (0x69a)
// includes .. 2   (offset: 0x61e)
// strings ... 6   (offset: 0x62e)
// dev strs .. 0   (offset: 0x69a)
// exports ... 6   (offset: 0x36e)
// cseg ...... 0xc5 + 0x2a9 (0x36e)
// imports ... 16  (offset: 0x45e)
// animtree1 . 0   (offset: 0x69a)
// animtree2 . 0   (offset: 0x69a)
#using scripts\common\create_script_utility;
#using scripts\common\utility;

#namespace zm_sat_hornet_ee_kodomo_cs;

// Namespace zm_sat_hornet_ee_kodomo_cs
// Params 2
// Checksum 0x4fc96000, Offset: 0xe3
// Size: 0x80
function main( unused, unused2 )
{
    if ( utility::flag_exist( "zm_sat_hornet_ee_kodomo_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "zm_sat_hornet_ee_kodomo_cs" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "zm_sat_hornet_ee_kodomo_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "zm_sat_hornet_ee_kodomo_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace zm_sat_hornet_ee_kodomo_cs
// Params 3, eflags: 0x4
// Checksum 0x7ca28286, Offset: 0x16b
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "zm_sat_hornet_ee_kodomo_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "zm_sat_hornet_ee_kodomo_cs" );
}

// Namespace zm_sat_hornet_ee_kodomo_cs
// Params 3, eflags: 0x4
// Checksum 0x4a905962, Offset: 0x1e5
// Size: 0x169
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_kodomo_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s.height = 144;
    fe [[ f ]]( s, us, cf, ( 244, -20627, 707.74 ), ( 0, 0, 0 ), "tk_trig_area_ken", undefined, undefined, undefined, undefined, undefined, undefined, 72 );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_kodomo_cs";
    fe [[ f ]]( s, us, cf, ( 93, -20564, 935 ), ( 0, 0, 0 ), "tk_toy_ken" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_kodomo_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s.height = 300;
    fe [[ f ]]( s, us, cf, ( 383, -20560, 539 ), ( 0, 0, 0 ), "tk_trig_area", undefined, undefined, undefined, undefined, undefined, undefined, 256 );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace zm_sat_hornet_ee_kodomo_cs
// Params 0, eflags: 0x4
// Checksum 0x80dbd157, Offset: 0x356
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace zm_sat_hornet_ee_kodomo_cs
// Params 0
// Checksum 0xbef15fcb, Offset: 0x360
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "zm_sat_hornet_ee_kodomo_cs" );
}

