// scripts\mp\zm\maps\zm_sat_scarab\zm_sat_scarab_script_boss_arena_cs.gsc  (hash_50228062b13b3e7c.gscc) (size: 3568 Bytes / 0xdf0 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xf4f72e0b (4109839883)
// size ...... 3568 (0xdf0)
// includes .. 2   (offset: 0xc18)
// strings ... 22  (offset: 0xc28)
// dev strs .. 0   (offset: 0xdf0)
// exports ... 6   (offset: 0x968)
// cseg ...... 0x28e + 0x6da (0x968)
// imports ... 16  (offset: 0xa58)
// animtree1 . 0   (offset: 0xdf0)
// animtree2 . 0   (offset: 0xdf0)
#using scripts\common\create_script_utility;
#using scripts\common\utility;

#namespace zm_sat_scarab_script_boss_arena_cs;

// Namespace zm_sat_scarab_script_boss_arena_cs
// Params 2
// Checksum 0x9b47d428, Offset: 0x2ac
// Size: 0x80
function main( unused, unused2 )
{
    if ( utility::flag_exist( "zm_sat_scarab_script_boss_arena_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "zm_sat_scarab_script_boss_arena_cs" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "zm_sat_scarab_script_boss_arena_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "zm_sat_scarab_script_boss_arena_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace zm_sat_scarab_script_boss_arena_cs
// Params 3, eflags: 0x4
// Checksum 0xa82c36ae, Offset: 0x334
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "zm_sat_scarab_script_boss_arena_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "zm_sat_scarab_script_boss_arena_cs" );
}

// Namespace zm_sat_scarab_script_boss_arena_cs
// Params 3, eflags: 0x4
// Checksum 0x164d40e1, Offset: 0x3ae
// Size: 0x59a
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_boss_arena_cs";
    fe [[ f ]]( s, us, cf, ( 932, 1827, 32 ), ( 0, 0, 0 ), "scarab_blessing_pedestals", "cspf_0_auto2413762449154661832", "scarab_ruby_boss" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_boss_arena_cs";
    fe [[ f ]]( s, us, cf, ( 1064, 2505, 32 ), ( 0, 342, 0 ), "scarab_blessing_pedestals", "cspf_0_auto13229981520773149764", "scarab_firefly_boss" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_boss_arena_cs";
    fe [[ f ]]( s, us, cf, ( 3325, 2183, 32 ), ( 0, 270, 0 ), "scarab_blessing_pedestals", "cspf_0_auto10470673358845071516", "scarab_hornet_boss" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_boss_arena_cs";
    fe [[ f ]]( s, us, cf, ( 2352, 2990, 32 ), ( 0, 245, 0 ), "scarab_blessing_pedestals", "cspf_0_auto7873819251006742995", "scarab_locust_boss" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_boss_arena_cs";
    fe [[ f ]]( s, us, cf, ( 2352, 2990, 84 ), ( 0, 0, 0 ), "cspf_0_auto7873819251006742995", undefined, "powerup_spawn" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_boss_arena_cs";
    fe [[ f ]]( s, us, cf, ( 3325, 2183, 86 ), ( 0, 270, 0 ), "cspf_0_auto10470673358845071516", undefined, "powerup_spawn" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_boss_arena_cs";
    fe [[ f ]]( s, us, cf, ( 932, 1827, 88 ), ( 0, 90, 0 ), "cspf_0_auto2413762449154661832", undefined, "powerup_spawn" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_boss_arena_cs";
    fe [[ f ]]( s, us, cf, ( 1064, 2505, 87 ), ( 0, 72, 0 ), "cspf_0_auto13229981520773149764", undefined, "powerup_spawn" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_boss_arena_cs";
    fe [[ f ]]( s, us, cf, ( 1064, 2505, -27 ), ( 0, 342, 0 ), "cspf_0_auto13229981520773149764", undefined, "start_pos" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_boss_arena_cs";
    fe [[ f ]]( s, us, cf, ( 932, 1827, -32 ), ( 0, 0, 0 ), "cspf_0_auto2413762449154661832", undefined, "start_pos" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_boss_arena_cs";
    fe [[ f ]]( s, us, cf, ( 2352, 2990, -24 ), ( 0, 245, 0 ), "cspf_0_auto7873819251006742995", undefined, "start_pos" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_boss_arena_cs";
    fe [[ f ]]( s, us, cf, ( 3325, 2183, -24 ), ( 0, 270, 0 ), "cspf_0_auto10470673358845071516", undefined, "start_pos" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_boss_arena_cs";
    s.script_scenescriptbundle = "sat_cin_zm_vig_plr_dth_weyward_02";
    fe [[ f ]]( s, us, cf, ( 2117, 2057, -8 ), ( 0, 0, 0 ), "sat_cin_zm_vig_plr_dth_weyward_02", undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_boss_arena_cs";
    s.script_scenescriptbundle = "ai_sat_zm_weyward_intro";
    fe [[ f ]]( s, us, cf, ( 2192, 4992, 248 ), ( 0, 0, 0 ), "ai_sat_zm_weyward_intro" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_boss_arena_cs";
    s.script_scenescriptbundle = "sat_cin_zm_scarab_outro";
    fe [[ f ]]( s, us, cf, ( 2161, 2007, 11 ), ( 0, 0, 0 ), "sat_cin_zm_scarab_outro" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_boss_arena_cs";
    s.script_scenescriptbundle = "sat_cin_zm_vig_plr_dth_weyward_01";
    fe [[ f ]]( s, us, cf, ( 2175, 2049, -10 ), ( 0, 0, 0 ), "sat_cin_zm_vig_plr_dth_weyward_01", undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_boss_arena_cs";
    s.name = "Boss";
    fe [[ f ]]( s, us, cf, ( 2226, 5132, 248 ), ( 0, 277, 0 ), undefined, undefined, "weyward_immune_pos" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_boss_arena_cs";
    s.script_scenescriptbundle = "sat_zm_scarab_boss_cage_ava";
    fe [[ f ]]( s, us, cf, ( 1968, 5270, 552 ), ( 0, 0, 0 ), "sat_zm_scarab_boss_cage_ava" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_boss_arena_cs";
    fe [[ f ]]( s, us, cf, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace zm_sat_scarab_script_boss_arena_cs
// Params 0, eflags: 0x4
// Checksum 0x5d677fd6, Offset: 0x950
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace zm_sat_scarab_script_boss_arena_cs
// Params 0
// Checksum 0x6a7febe3, Offset: 0x95a
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "zm_sat_scarab_script_boss_arena_cs" );
}

