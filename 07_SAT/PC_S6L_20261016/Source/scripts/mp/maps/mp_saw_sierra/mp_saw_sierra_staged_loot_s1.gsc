// scripts\mp\maps\mp_saw_sierra\mp_saw_sierra_staged_loot_s1.gsc  (hash_55c1ce8169965ada.gscc) (size: 1893 Bytes / 0x765 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xd2318867 (3526461543)
// size ...... 1893 (0x765)
// includes .. 3   (offset: 0x6d9)
// strings ... 7   (offset: 0x6f1)
// dev strs .. 0   (offset: 0x765)
// exports ... 9   (offset: 0x341)
// cseg ...... 0xe1 + 0x260 (0x341)
// imports ... 20  (offset: 0x4a9)
// animtree1 . 0   (offset: 0x765)
// animtree2 . 0   (offset: 0x765)
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace mp_saw_sierra_staged_loot_s1;

// Namespace mp_saw_sierra_staged_loot_s1
// Params 0, eflags: 0x5
// Checksum 0x95b7357b, Offset: 0xff
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"mp_saw_sierra_staged_loot_s1", undefined, &function_b39ecd3d51489472, undefined );
}

// Namespace mp_saw_sierra_staged_loot_s1
// Params 0, eflags: 0x4
// Checksum 0x8866ac6b, Offset: 0x120
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace mp_saw_sierra_staged_loot_s1
// Params 0, eflags: 0x4
// Checksum 0xd5d7f87, Offset: 0x131
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace mp_saw_sierra_staged_loot_s1
// Params 2
// Checksum 0xbdb429ce, Offset: 0x142
// Size: 0x80
function main( unused, unused2 )
{
    if ( utility::flag_exist( "mp_saw_sierra_staged_loot_s1" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "mp_saw_sierra_staged_loot_s1" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "mp_saw_sierra_staged_loot_s1" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "mp_saw_sierra_staged_loot_s1" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace mp_saw_sierra_staged_loot_s1
// Params 3, eflags: 0x4
// Checksum 0x8edfcb48, Offset: 0x1ca
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "mp_saw_sierra_staged_loot_s1" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "mp_saw_sierra_staged_loot_s1" );
}

// Namespace mp_saw_sierra_staged_loot_s1
// Params 3, eflags: 0x4
// Checksum 0xfc610b9e, Offset: 0x244
// Size: 0xdd
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_saw_sierra_staged_loot_s1";
    s.script_parameters = "brloot_super_deployablekiosk";
    fe [[ f ]]( s, us, cf, ( 26506, 3835.75, -44 ), ( 0, 0, 0 ), "staged_items", undefined, "staged_item" );
    s = {};
    s.script_cs_flag = "mp_saw_sierra_staged_loot_s1";
    fe [[ f ]]( s, us, cf, ( 211, 228, -1157 ), ( 0, 0, 0 ), "loot_test" );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace mp_saw_sierra_staged_loot_s1
// Params 0, eflags: 0x4
// Checksum 0x939445e5, Offset: 0x329
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace mp_saw_sierra_staged_loot_s1
// Params 0
// Checksum 0x4c8c1605, Offset: 0x333
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "mp_saw_sierra_staged_loot_s1" );
}

