// scripts\mp\zm\maps\zm_sat_firefly\zm_sat_firefly_script_quest_create_script.gsc  (hash_6e57f4a22451738d.gscc) (size: 1547 Bytes / 0x60b / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x5d96f743 (1570174787)
// size ...... 1547 (0x60b)
// includes .. 2   (offset: 0x593)
// strings ... 6   (offset: 0x5a3)
// dev strs .. 0   (offset: 0x60b)
// exports ... 6   (offset: 0x2e3)
// cseg ...... 0xcc + 0x217 (0x2e3)
// imports ... 16  (offset: 0x3d3)
// animtree1 . 0   (offset: 0x60b)
// animtree2 . 0   (offset: 0x60b)
#using scripts\common\create_script_utility;
#using scripts\common\utility;

#namespace zm_sat_firefly_script_quest_create_script;

// Namespace zm_sat_firefly_script_quest_create_script
// Params 2
// Checksum 0x80da6239, Offset: 0xea
// Size: 0x80
function main( unused, unused2 )
{
    if ( utility::flag_exist( "zm_sat_firefly_script_quest_create_script" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "zm_sat_firefly_script_quest_create_script" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "zm_sat_firefly_script_quest_create_script" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "zm_sat_firefly_script_quest_create_script" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace zm_sat_firefly_script_quest_create_script
// Params 3, eflags: 0x4
// Checksum 0xb3b180bf, Offset: 0x172
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "zm_sat_firefly_script_quest_create_script" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "zm_sat_firefly_script_quest_create_script" );
}

// Namespace zm_sat_firefly_script_quest_create_script
// Params 3, eflags: 0x4
// Checksum 0xf59b3d27, Offset: 0x1ec
// Size: 0xd7
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_quest_create_script";
    s.groupid = "Axe";
    fe [[ f ]]( s, us, cf, ( -12265, 3103, 536 ), ( 359.3, 295.85, 114.29 ), "g_combataxe" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_quest_create_script";
    fe [[ f ]]( s, us, cf, ( 25206.3, 684.87, 451.2 ), ( 0, 0, 0 ), "round_accelerant" );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace zm_sat_firefly_script_quest_create_script
// Params 0, eflags: 0x4
// Checksum 0x6583e4e2, Offset: 0x2cb
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace zm_sat_firefly_script_quest_create_script
// Params 0
// Checksum 0x71e25df2, Offset: 0x2d5
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "zm_sat_firefly_script_quest_create_script" );
}

