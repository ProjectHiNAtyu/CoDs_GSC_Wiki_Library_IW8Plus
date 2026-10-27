// scripts\mp\maps\mp_saw_avalon\mp_saw_mechanics_bongo_safecrack_cs.gsc  (hash_53614ca43888b438.gscc) (size: 1783 Bytes / 0x6f7 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xd2a7a7a9 (3534202793)
// size ...... 1783 (0x6f7)
// includes .. 2   (offset: 0x653)
// strings ... 9   (offset: 0x663)
// dev strs .. 0   (offset: 0x6f7)
// exports ... 6   (offset: 0x3a3)
// cseg ...... 0x122 + 0x281 (0x3a3)
// imports ... 16  (offset: 0x493)
// animtree1 . 0   (offset: 0x6f7)
// animtree2 . 0   (offset: 0x6f7)
#using scripts\common\create_script_utility;
#using scripts\common\utility;

#namespace mp_saw_mechanics_bongo_safecrack_cs;

// Namespace mp_saw_mechanics_bongo_safecrack_cs
// Params 2
// Checksum 0x17b1be07, Offset: 0x140
// Size: 0x80
function main( unused, unused2 )
{
    if ( utility::flag_exist( "mp_saw_mechanics_bongo_safecrack_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "mp_saw_mechanics_bongo_safecrack_cs" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "mp_saw_mechanics_bongo_safecrack_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "mp_saw_mechanics_bongo_safecrack_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace mp_saw_mechanics_bongo_safecrack_cs
// Params 3, eflags: 0x4
// Checksum 0x24da5c81, Offset: 0x1c8
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "mp_saw_mechanics_bongo_safecrack_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "mp_saw_mechanics_bongo_safecrack_cs" );
}

// Namespace mp_saw_mechanics_bongo_safecrack_cs
// Params 3, eflags: 0x4
// Checksum 0xdb0391d1, Offset: 0x242
// Size: 0x141
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_saw_mechanics_bongo_safecrack_cs";
    s.name = "MECHANICS_SAFE";
    fe [[ f ]]( s, us, cf, ( -1300, 1950, -512 ), ( 0, -90, 0 ), "MECHANICS_SAFECRACK", undefined, "safecrack_safe", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_mechanics_bongo_safecrack_cs";
    s.activity_bundle = "saw_activity_bongo_safecrack";
    s.name = "MECHANICS_SAFECRACK";
    fe [[ f ]]( s, us, cf, ( -1300, 1950, -512 ), ( 0, 0, 0 ), "activity_nexus_variant", "MECHANICS_SAFECRACK", undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace mp_saw_mechanics_bongo_safecrack_cs
// Params 0, eflags: 0x4
// Checksum 0xeafb0ed6, Offset: 0x38b
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace mp_saw_mechanics_bongo_safecrack_cs
// Params 0
// Checksum 0xe68981cc, Offset: 0x395
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "mp_saw_mechanics_bongo_safecrack_cs" );
}

