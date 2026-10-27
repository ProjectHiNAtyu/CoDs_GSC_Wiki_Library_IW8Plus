// scripts\mp\zm\maps\zm_sat_scarab\zm_sat_scarab_boss_fight_shadow_soul_cs.gsc  (hash_1aa3f70ce6aae75e.gscc) (size: 2199 Bytes / 0x897 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x50ec0d4a (1357647178)
// size ...... 2199 (0x897)
// includes .. 2   (offset: 0x7e3)
// strings ... 4   (offset: 0x7f3)
// dev strs .. 0   (offset: 0x897)
// exports ... 6   (offset: 0x533)
// cseg ...... 0xb3 + 0x480 (0x533)
// imports ... 16  (offset: 0x623)
// animtree1 . 0   (offset: 0x897)
// animtree2 . 0   (offset: 0x897)
#using scripts\common\create_script_utility;
#using scripts\common\utility;

#namespace zm_sat_scarab_boss_fight_shadow_soul_cs;

// Namespace zm_sat_scarab_boss_fight_shadow_soul_cs
// Params 2
// Checksum 0x85ee4433, Offset: 0xd1
// Size: 0x80
function main( unused, unused2 )
{
    if ( utility::flag_exist( "zm_sat_scarab_boss_fight_shadow_soul_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "zm_sat_scarab_boss_fight_shadow_soul_cs" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "zm_sat_scarab_boss_fight_shadow_soul_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "zm_sat_scarab_boss_fight_shadow_soul_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace zm_sat_scarab_boss_fight_shadow_soul_cs
// Params 3, eflags: 0x4
// Checksum 0xb685a6b5, Offset: 0x159
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "zm_sat_scarab_boss_fight_shadow_soul_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "zm_sat_scarab_boss_fight_shadow_soul_cs" );
}

// Namespace zm_sat_scarab_boss_fight_shadow_soul_cs
// Params 3, eflags: 0x4
// Checksum 0x2680bbb2, Offset: 0x1d3
// Size: 0x340
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "zm_sat_scarab_boss_fight_shadow_soul_cs";
    fe [[ f ]]( s, us, cf, ( 3616, 1967, 260 ), ( 0, 174, 0 ), undefined, undefined, "shadow_soul_pos" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_boss_fight_shadow_soul_cs";
    fe [[ f ]]( s, us, cf, ( 2996, 736, 160 ), ( 0, 122, 0 ), undefined, undefined, "shadow_soul_pos" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_boss_fight_shadow_soul_cs";
    fe [[ f ]]( s, us, cf, ( 885, 1586, 153 ), ( 0, 26, 0 ), undefined, undefined, "shadow_soul_pos" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_boss_fight_shadow_soul_cs";
    fe [[ f ]]( s, us, cf, ( 963, 2197, 324 ), ( 0, 0, 0 ), undefined, undefined, "shadow_soul_pos" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_boss_fight_shadow_soul_cs";
    fe [[ f ]]( s, us, cf, ( 1226, 2737, 333 ), ( 0, 330, 0 ), undefined, undefined, "shadow_soul_pos" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_boss_fight_shadow_soul_cs";
    fe [[ f ]]( s, us, cf, ( 3277, 1772, 411 ), ( 0, 180, 0 ), undefined, undefined, "shadow_soul_pos" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_boss_fight_shadow_soul_cs";
    fe [[ f ]]( s, us, cf, ( 3277, 2218, 390 ), ( 0, 180, 0 ), undefined, undefined, "shadow_soul_pos" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_boss_fight_shadow_soul_cs";
    fe [[ f ]]( s, us, cf, ( 1123, 3374, 214 ), ( 0, 312.3, 0 ), undefined, undefined, "shadow_soul_pos" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_boss_fight_shadow_soul_cs";
    fe [[ f ]]( s, us, cf, ( 2864.91, 3322.28, 214 ), ( 0, 244.59, 0 ), undefined, undefined, "shadow_soul_pos" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_boss_fight_shadow_soul_cs";
    fe [[ f ]]( s, us, cf, ( 2323, 605, 259 ), ( 0, 122, 0 ), undefined, undefined, "shadow_soul_pos" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_boss_fight_shadow_soul_cs";
    fe [[ f ]]( s, us, cf, ( 1292, 984, 233 ), ( 0, 122, 0 ), undefined, undefined, "shadow_soul_pos" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_boss_fight_shadow_soul_cs";
    fe [[ f ]]( s, us, cf, ( 3528, 2816, 179 ), ( 0, 203.5, 0 ), undefined, undefined, "shadow_soul_pos" );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace zm_sat_scarab_boss_fight_shadow_soul_cs
// Params 0, eflags: 0x4
// Checksum 0xca17e1f6, Offset: 0x51b
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace zm_sat_scarab_boss_fight_shadow_soul_cs
// Params 0
// Checksum 0x74d67bf8, Offset: 0x525
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "zm_sat_scarab_boss_fight_shadow_soul_cs" );
}

