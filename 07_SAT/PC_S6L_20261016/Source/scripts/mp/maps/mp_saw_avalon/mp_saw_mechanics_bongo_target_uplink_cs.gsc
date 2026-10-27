// scripts\mp\maps\mp_saw_avalon\mp_saw_mechanics_bongo_target_uplink_cs.gsc  (hash_697d67b9858ce66a.gscc) (size: 1805 Bytes / 0x70d / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xeab865a5 (3937953189)
// size ...... 1805 (0x70d)
// includes .. 2   (offset: 0x669)
// strings ... 9   (offset: 0x679)
// dev strs .. 0   (offset: 0x70d)
// exports ... 6   (offset: 0x3b9)
// cseg ...... 0x138 + 0x281 (0x3b9)
// imports ... 16  (offset: 0x4a9)
// animtree1 . 0   (offset: 0x70d)
// animtree2 . 0   (offset: 0x70d)
#using scripts\common\create_script_utility;
#using scripts\common\utility;

#namespace mp_saw_mechanics_bongo_target_uplink_cs;

// Namespace mp_saw_mechanics_bongo_target_uplink_cs
// Params 2
// Checksum 0x321c8fa4, Offset: 0x156
// Size: 0x80
function main( unused, unused2 )
{
    if ( utility::flag_exist( "mp_saw_mechanics_bongo_target_uplink_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "mp_saw_mechanics_bongo_target_uplink_cs" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "mp_saw_mechanics_bongo_target_uplink_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "mp_saw_mechanics_bongo_target_uplink_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace mp_saw_mechanics_bongo_target_uplink_cs
// Params 3, eflags: 0x4
// Checksum 0x1776d22, Offset: 0x1de
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "mp_saw_mechanics_bongo_target_uplink_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "mp_saw_mechanics_bongo_target_uplink_cs" );
}

// Namespace mp_saw_mechanics_bongo_target_uplink_cs
// Params 3, eflags: 0x4
// Checksum 0xbff745dc, Offset: 0x258
// Size: 0x141
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_saw_mechanics_bongo_target_uplink_cs";
    s.name = "MECHANICS_UPLINK_STATION";
    fe [[ f ]]( s, us, cf, ( -1450, 1950, -512 ), ( 0, -90, 0 ), "MECHANICS_TARGET_UPLINK", undefined, "uplink_station", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_mechanics_bongo_target_uplink_cs";
    s.activity_bundle = "saw_activity_bongo_target_uplink";
    s.name = "MECHANICS_TARGET_UPLINK";
    fe [[ f ]]( s, us, cf, ( -1450, 1950, -512 ), ( 0, 0, 0 ), "activity_nexus_variant", "MECHANICS_TARGET_UPLINK", undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace mp_saw_mechanics_bongo_target_uplink_cs
// Params 0, eflags: 0x4
// Checksum 0xe04df9e4, Offset: 0x3a1
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace mp_saw_mechanics_bongo_target_uplink_cs
// Params 0
// Checksum 0xc324b06f, Offset: 0x3ab
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "mp_saw_mechanics_bongo_target_uplink_cs" );
}

