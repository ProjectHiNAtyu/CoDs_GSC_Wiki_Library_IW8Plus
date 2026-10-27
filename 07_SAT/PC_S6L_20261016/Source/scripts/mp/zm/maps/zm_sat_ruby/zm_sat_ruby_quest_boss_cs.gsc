// scripts\mp\zm\maps\zm_sat_ruby\zm_sat_ruby_quest_boss_cs.gsc  (hash_09b620f1392e891f.gscc) (size: 3133 Bytes / 0xc3d / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xaf62dd44 (2942491972)
// size ...... 3133 (0xc3d)
// includes .. 2   (offset: 0xacd)
// strings ... 17  (offset: 0xadd)
// dev strs .. 0   (offset: 0xc3d)
// exports ... 6   (offset: 0x81d)
// cseg ...... 0x1e4 + 0x639 (0x81d)
// imports ... 16  (offset: 0x90d)
// animtree1 . 0   (offset: 0xc3d)
// animtree2 . 0   (offset: 0xc3d)
#using scripts\common\create_script_utility;
#using scripts\common\utility;

#namespace zm_sat_ruby_quest_boss_cs;

// Namespace zm_sat_ruby_quest_boss_cs
// Params 2
// Checksum 0xddd51905, Offset: 0x202
// Size: 0x80
function main( unused, unused2 )
{
    if ( utility::flag_exist( "zm_sat_ruby_quest_boss_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "zm_sat_ruby_quest_boss_cs" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "zm_sat_ruby_quest_boss_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "zm_sat_ruby_quest_boss_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace zm_sat_ruby_quest_boss_cs
// Params 3, eflags: 0x4
// Checksum 0xeebefb83, Offset: 0x28a
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "zm_sat_ruby_quest_boss_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "zm_sat_ruby_quest_boss_cs" );
}

// Namespace zm_sat_ruby_quest_boss_cs
// Params 3, eflags: 0x4
// Checksum 0xe2be40b7, Offset: 0x304
// Size: 0x4f9
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "zm_sat_ruby_quest_boss_cs";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( 4130, -48366, -7334 ), ( 0, 90, 0 ), "ruby_boss_uranus_spawn_pos" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_quest_boss_cs";
    s.name = "tower";
    fe [[ f ]]( s, us, cf, ( 3253, -41606, -12366.5 ), ( 0, 0, 0 ), "ruby_boss_uranus_tower_2_emitter" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_quest_boss_cs";
    s.name = "tower";
    fe [[ f ]]( s, us, cf, ( 5001, -41606, -12366.5 ), ( 0, 0, 0 ), "ruby_boss_uranus_tower_1_emitter" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_quest_boss_cs";
    s.name = "panel";
    fe [[ f ]]( s, us, cf, ( 4120.5, -41278.8, -12759.5 ), ( 0, 90, 0 ), "ruby_boss_uranus_panel_interact" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_quest_boss_cs";
    s.name = "toxic_fog_spawn_pos";
    fe [[ f ]]( s, us, cf, ( 3572, -42330, -12974 ), ( 0, 0, 0 ), "ruby_boss_uranus_toxic_fog_pos" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_quest_boss_cs";
    s.name = "toxic_fog_spawn_pos";
    fe [[ f ]]( s, us, cf, ( 3591, -41558, -12974 ), ( 0, 0, 0 ), "ruby_boss_uranus_toxic_fog_pos" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_quest_boss_cs";
    s.name = "toxic_fog_spawn_pos";
    fe [[ f ]]( s, us, cf, ( 4691, -42336, -12974 ), ( 0, 0, 0 ), "ruby_boss_uranus_toxic_fog_pos" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_quest_boss_cs";
    s.name = "toxic_fog_spawn_pos";
    fe [[ f ]]( s, us, cf, ( 4629, -41554, -12974 ), ( 0, 0, 0 ), "ruby_boss_uranus_toxic_fog_pos" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_quest_boss_cs";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( 4130, -41892, -12936.8 ), ( 0, 90, 0 ), "ruby_boss_neptune_spawn_pos" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_quest_boss_cs";
    s.name = "boss_mars_spawn";
    fe [[ f ]]( s, us, cf, ( 4016.96, -40883.6, -12798.5 ), ( 0, 272.86, 0 ), "boss_mars_spawn" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_quest_boss_cs";
    fe [[ f ]]( s, us, cf, ( 4120.25, -41180.7, -12804.2 ), ( 0, 0, 0 ), "pedestal_spawn" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_quest_boss_cs";
    s.name = "boss_mars_spawn";
    fe [[ f ]]( s, us, cf, ( 4080.21, -40883.6, -12798.5 ), ( 0, 272.86, 0 ), "boss_mars_spawn" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_quest_boss_cs";
    s.name = "boss_mars_spawn";
    fe [[ f ]]( s, us, cf, ( 4147.21, -40884.4, -12798.5 ), ( 0, 272.86, 0 ), "boss_mars_spawn" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_quest_boss_cs";
    s.name = "boss_mars_spawn";
    fe [[ f ]]( s, us, cf, ( 4215.96, -40886.1, -12798.5 ), ( 0, 272.86, 0 ), "boss_mars_spawn" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_quest_boss_cs";
    fe [[ f ]]( s, us, cf, ( 4109, -40477.7, -12432.5 ), ( 0, 0, 0 ), "mars_stairs_top" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_quest_boss_cs";
    fe [[ f ]]( s, us, cf, ( 4109, -40778.2, -12773.8 ), ( 0, 0, 0 ), "mars_stairs_bottom" );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace zm_sat_ruby_quest_boss_cs
// Params 0, eflags: 0x4
// Checksum 0xb6e4bb71, Offset: 0x805
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace zm_sat_ruby_quest_boss_cs
// Params 0
// Checksum 0x2ced26ce, Offset: 0x80f
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "zm_sat_ruby_quest_boss_cs" );
}

