// scripts\mp\zm\maps\zm_sat_firefly\zm_sat_firefly_script_loot_destruction_creature_cs.gsc  (hash_24b45f4550fa420a.gscc) (size: 3217 Bytes / 0xc91 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x748e09e0 (1955465696)
// size ...... 3217 (0xc91)
// includes .. 3   (offset: 0xb29)
// strings ... 17  (offset: 0xb41)
// dev strs .. 0   (offset: 0xc91)
// exports ... 9   (offset: 0x7ad)
// cseg ...... 0x2b2 + 0x4fb (0x7ad)
// imports ... 19  (offset: 0x915)
// animtree1 . 0   (offset: 0xc91)
// animtree2 . 0   (offset: 0xc91)
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace zm_sat_firefly_script_loot_destruction_creature_cs;

// Namespace zm_sat_firefly_script_loot_destruction_creature_cs
// Params 0, eflags: 0x5
// Checksum 0x2bbd3f55, Offset: 0x2d0
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"zm_sat_firefly_script_loot_destruction_creature_cs", undefined, &function_b39ecd3d51489472, undefined );
}

// Namespace zm_sat_firefly_script_loot_destruction_creature_cs
// Params 0, eflags: 0x4
// Checksum 0x1328ee05, Offset: 0x2f1
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace zm_sat_firefly_script_loot_destruction_creature_cs
// Params 0, eflags: 0x4
// Checksum 0x96133de9, Offset: 0x302
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace zm_sat_firefly_script_loot_destruction_creature_cs
// Params 2
// Checksum 0xccd4b43c, Offset: 0x313
// Size: 0x70
function main( unused, unused2 )
{
    if ( utility::flag_exist( "zm_sat_firefly_script_loot_destruction_creature_cs" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "zm_sat_firefly_script_loot_destruction_creature_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "zm_sat_firefly_script_loot_destruction_creature_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace zm_sat_firefly_script_loot_destruction_creature_cs
// Params 3, eflags: 0x4
// Checksum 0x15918926, Offset: 0x38b
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "zm_sat_firefly_script_loot_destruction_creature_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "zm_sat_firefly_script_loot_destruction_creature_cs" );
}

// Namespace zm_sat_firefly_script_loot_destruction_creature_cs
// Params 3, eflags: 0x4
// Checksum 0xb36972fb, Offset: 0x405
// Size: 0x388
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_loot_destruction_creature_cs";
    fe [[ f ]]( s, us, cf, ( 22875.4, 536.12, 270.6 ), ( 0, 314.45, 0 ), "scriptable_loot_des_creature_0", undefined, "sc_nw_scriptable_loot_des_creature" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_loot_destruction_creature_cs";
    fe [[ f ]]( s, us, cf, ( 12793, 1684.8, 1024.7 ), ( 0, 216.28, 0 ), "scriptable_loot_des_creature_post_1", "scriptable_loot_des_creature_1", "sc_nw_scriptable_loot_des_creature_post" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_loot_destruction_creature_cs";
    fe [[ f ]]( s, us, cf, ( 22879.9, 606.32, 298.9 ), ( 0, 314.45, 0 ), "scriptable_loot_des_creature_post_0", "scriptable_loot_des_creature_0", "sc_nw_scriptable_loot_des_creature_post" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_loot_destruction_creature_cs";
    fe [[ f ]]( s, us, cf, ( 12766, 1716.7, 983.1 ), ( 0, 211.3, 0 ), "scriptable_loot_des_creature_1", undefined, "sc_nw_scriptable_loot_des_creature" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_loot_destruction_creature_cs";
    fe [[ f ]]( s, us, cf, ( 2833, -3226.4, 418.6 ), ( 0, 60, 0 ), "scriptable_loot_des_creature_post_2", "scriptable_loot_des_creature_2", "sc_nw_scriptable_loot_des_creature_post" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_loot_destruction_creature_cs";
    fe [[ f ]]( s, us, cf, ( 2862.5, -3245.5, 381.1 ), ( 0, 60, 0 ), "scriptable_loot_des_creature_2", undefined, "sc_nw_scriptable_loot_des_creature" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_loot_destruction_creature_cs";
    fe [[ f ]]( s, us, cf, ( -7257.12, -6216.46, 1571.4 ), ( 0, 264.81, 0 ), "scriptable_loot_des_creature_post_3", "scriptable_loot_des_creature_3", "sc_nw_scriptable_loot_des_creature_post" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_loot_destruction_creature_cs";
    fe [[ f ]]( s, us, cf, ( -7300.08, -6225.33, 1533 ), ( 0, 264.81, 0 ), "scriptable_loot_des_creature_3", undefined, "sc_nw_scriptable_loot_des_creature" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_loot_destruction_creature_cs";
    fe [[ f ]]( s, us, cf, ( -12842.1, 2638.17, 415.4 ), ( 0, 40.75, 0 ), "scriptable_loot_des_creature_post_4", "scriptable_loot_des_creature_4", "sc_nw_scriptable_loot_des_creature_post" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_loot_destruction_creature_cs";
    fe [[ f ]]( s, us, cf, ( -12808.7, 2607.88, 375.1 ), ( 0, 40.75, 0 ), "scriptable_loot_des_creature_4", undefined, "sc_nw_scriptable_loot_des_creature" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_loot_destruction_creature_cs";
    fe [[ f ]]( s, us, cf, ( 14022, -3011, 598.1 ), ( 0, 300, 0 ), "scriptable_loot_des_creature_5", undefined, "sc_nw_scriptable_loot_des_creature" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_loot_destruction_creature_cs";
    fe [[ f ]]( s, us, cf, ( 14083, -2975, 635 ), ( 0, 300, 0 ), "scriptable_loot_des_creature_post_5", "scriptable_loot_des_creature_5", "sc_nw_scriptable_loot_des_creature_post" );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace zm_sat_firefly_script_loot_destruction_creature_cs
// Params 0, eflags: 0x4
// Checksum 0x6badd08d, Offset: 0x795
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace zm_sat_firefly_script_loot_destruction_creature_cs
// Params 0
// Checksum 0xd7c2546b, Offset: 0x79f
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "zm_sat_firefly_script_loot_destruction_creature_cs" );
}

