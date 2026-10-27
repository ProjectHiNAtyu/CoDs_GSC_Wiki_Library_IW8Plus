// scripts\mp\zm\systems\zm_livingworld.gsc  (hash_110f3a07c5099e1c.gscc) (size: 74897 Bytes / 0x12491 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x4f86da67 (1334237799)
// size ...... 74897 (0x12491)
// includes .. 37  (offset: 0x11355)
// strings ... 176 (offset: 0x1147d)
// dev strs .. 60  (offset: 0x12175)
// exports ... 119 (offset: 0xc8ed)
// cseg ...... 0xca8 + 0xbc45 (0xc8ed)
// imports ... 424 (offset: 0xdb85)
// animtree1 . 0   (offset: 0x12491)
// animtree2 . 0   (offset: 0x12491)
#using script_16ea1b94f0f381b3;
#using scripts\anim\dialogue;
#using scripts\anim\shared;
#using scripts\anim\utility_common;
#using scripts\asm\asm;
#using scripts\common\ai;
#using scripts\common\ai\aitypes\shared\zombie\zombie_attractor_manager;
#using scripts\common\ai\aitypes\shared\zombie\zombie_emergence_spawning;
#using scripts\common\ai\aitypes\shared\zombie\zombie_melee;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\ai\aitypes\zombie_base\zombie_base_dismemberment;
#using scripts\common\ai\subclass_to_aitype_map;
#using scripts\common\ai_lookat;
#using scripts\common\callbacks;
#using scripts\common\debug;
#using scripts\common\devgui;
#using scripts\common\scene;
#using scripts\common\system;
#using scripts\common\throttle;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\agents\agent_utils;
#using scripts\mp\ai_behavior;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\weapon_utility;
#using scripts\mp\damagefeedback;
#using scripts\mp\loot\common_item;
#using scripts\mp\zm\events;
#using scripts\mp\zm\systems\loot_drops;
#using scripts\mp\zm\systems\weapons\zm_damage;
#using scripts\mp\zm\systems\zm_livingworld_vo;
#using scripts\mp\zm\systems\zm_quest;
#using scripts\mp\zm\systems\zm_round_logic;
#using scripts\mp\zm\systems\zm_round_spawning;
#using scripts\mp\zm\systems\zm_save;
#using scripts\mp\zm\systems\zone_manager;
#using scripts\mp\zm\zm_utility;

#namespace zm_livingworld;

// Namespace zm_livingworld
// Params 0, eflags: 0x5
// Checksum 0x62b793bd, Offset: 0xcc6
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"zm_livingworld", undefined, undefined, &init_livingworld );
}

// Namespace zm_livingworld
// Params 0
// Checksum 0x35dfa65c, Offset: 0xce7
// Size: 0x414
function init_livingworld()
{
    if ( livingworld_is_disabled() )
    {
        return;
    }
    
    if ( isdefined( level._livingworld_info ) )
    {
        return;
    }
    
    /#
        if ( isofflinetoolrun( 31 ) )
        {
            return;
        }
    #/
    
    level._livingworld_info = spawnstruct();
    level._livingworld_info.script_funcs = [];
    var_35440c70bb0ec650 = getscriptbundle( hashcat( %"zmlivingworld:", level.gametypebundle.zmlivingworld ) );
    var_467e8972d25d65ee = "zmlivingworld_" + level.mapname;
    var_a30ca9b6543586b0 = getscriptbundle( "zmlivingworld:" + var_467e8972d25d65ee );
    assert( isdefined( var_35440c70bb0ec650 ), "<dev string:x24>" );
    livingworldbundle = var_a30ca9b6543586b0 ?? var_35440c70bb0ec650;
    level._livingworld_info.var_1ba91bfc52ee46f3 = isdefined( var_a30ca9b6543586b0 );
    
    if ( !isdefined( livingworldbundle.var_939c8b2cfefb86e0 ) )
    {
        livingworldbundle.var_939c8b2cfefb86e0 = 0;
    }
    
    if ( !isdefined( livingworldbundle.var_939c8e2cfefb8d79 ) )
    {
        livingworldbundle.var_939c8e2cfefb8d79 = 0;
    }
    
    if ( !isdefined( livingworldbundle.var_f670b2081fe497e9 ) )
    {
        livingworldbundle.var_f670b2081fe497e9 = 0;
    }
    
    if ( !isdefined( livingworldbundle.var_1762d6b7b834058d ) )
    {
        livingworldbundle.var_1762d6b7b834058d = 0;
    }
    
    if ( !isdefined( livingworldbundle.var_f9c65d952ff11e60 ) )
    {
        livingworldbundle.var_f9c65d952ff11e60 = 0;
    }
    
    if ( !isdefined( livingworldbundle.var_f0e7077dafd0a727 ) )
    {
        livingworldbundle.var_f0e7077dafd0a727 = 0;
    }
    
    if ( !isdefined( livingworldbundle.var_6192e0a84b9b8db6 ) )
    {
        livingworldbundle.var_6192e0a84b9b8db6 = 0;
    }
    
    level._livingworld_info.itemspawnlist = livingworldbundle.itemspawnlist;
    level._livingworld_info.var_939c8b2cfefb86e0 = livingworldbundle.var_939c8b2cfefb86e0;
    level._livingworld_info.var_939c8e2cfefb8d79 = livingworldbundle.var_939c8e2cfefb8d79;
    level._livingworld_info.var_f670b2081fe497e9 = livingworldbundle.var_f670b2081fe497e9;
    level._livingworld_info.var_1762d6b7b834058d = livingworldbundle.var_1762d6b7b834058d;
    level._livingworld_info.var_f9c65d952ff11e60 = livingworldbundle.var_f9c65d952ff11e60;
    level._livingworld_info.var_f0e7077dafd0a727 = livingworldbundle.var_f0e7077dafd0a727;
    level._livingworld_info.var_6192e0a84b9b8db6 = livingworldbundle.var_6192e0a84b9b8db6;
    level thread function_93dbb9caa6a6d326( livingworldbundle, var_35440c70bb0ec650, var_a30ca9b6543586b0 );
    level._livingworld_info.var_5fdeb72e7240c31c = [];
    level._livingworld_info.var_5fdeb72e7240c31c[ "head" ] = &namespace_b76ff2659823e89d::function_6c318bca7bb326e7;
    level._livingworld_info.var_5fdeb72e7240c31c[ "both_legs" ] = &namespace_b76ff2659823e89d::function_6903092d09bd9aa8;
    level._livingworld_info.var_5fdeb72e7240c31c[ "both_arms" ] = &namespace_b76ff2659823e89d::function_ea9f5a702fae84ee;
    level._livingworld_info.var_5fdeb72e7240c31c[ "left_leg" ] = &namespace_b76ff2659823e89d::dismember_left_leg;
    level._livingworld_info.var_5fdeb72e7240c31c[ "right_leg" ] = &namespace_b76ff2659823e89d::dismember_right_leg;
    level._livingworld_info.var_5fdeb72e7240c31c[ "left_arm" ] = &namespace_b76ff2659823e89d::dismember_left_arm;
    level._livingworld_info.var_5fdeb72e7240c31c[ "right_arm" ] = &namespace_b76ff2659823e89d::dismember_right_arm;
    level.livingworldthrottle = throttle::throttle_initialize( "livingworld_throttle" );
    level callback::add( "on_round_start", &on_round_start );
    level callback::add( "special_round_start", &function_b488eb0feb03048c, 1 );
    level callback::add( "special_round_end", &function_b488eb0feb03048c, 0 );
    level agent_utils::register_soldier_damage_callback( &function_140a69275d80d3c9 );
    level._effect[ "vfx_t10_levels_zm_quartz_human_teleport_out" ] = loadfxasset( "vfx_t10_levels_zm_quartz_human_teleport_out" );
    
    /#
        thread livingworld_init_debug();
    #/
    
    level thread function_d366a78868737acd();
}

// Namespace zm_livingworld
// Params 0, eflags: 0x4
// Checksum 0x423b6f9d, Offset: 0x1103
// Size: 0x9d
function private function_d366a78868737acd()
{
    utility::flag_wait( "zm_quest_initialized" );
    level._livingworld_info.livingworldstructs = utility::getstructarray( "zm_living_world", "targetname" );
    
    if ( !isdefined( level._livingworld_info.livingworldstructs ) || level._livingworld_info.livingworldstructs.size < 1 )
    {
        return;
    }
    
    zm_quest::register_quest_step( #"zm_livingworld", #"zm_livingworld", &livingworld_post_init, undefined );
    zm_save::function_1f44a48caae2acbf();
    level thread zm_quest::start_quest( #"zm_livingworld" );
}

// Namespace zm_livingworld
// Params 2
// Checksum 0x91cb8bef, Offset: 0x11a8
// Size: 0x7a, Type: bool
function livingworld_is_disabled( project_name, level_name )
{
    if ( getdvarint( @"livingworld_disable", 0 ) )
    {
        return true;
    }
    
    if ( level.livingworld_disabled )
    {
        return true;
    }
    
    if ( isdefined( project_name ) && getprojectname() != project_name )
    {
        return true;
    }
    
    if ( isdefined( level_name ) && level.mapname != level_name && !issubstr( level_name, level.mapname ) )
    {
        return true;
    }
    
    return false;
}

// Namespace zm_livingworld
// Params 3, eflags: 0x4
// Checksum 0xaaa95167, Offset: 0x122b
// Size: 0x4e9
function private function_93dbb9caa6a6d326( livingworldbundle, var_35440c70bb0ec650, var_a30ca9b6543586b0 )
{
    if ( isdefined( var_a30ca9b6543586b0 ) )
    {
        level._livingworld_info.var_6777f3bb24f08530 = function_55b13d1cb3cd5ab9( var_a30ca9b6543586b0.var_6777f3bb24f08530, var_35440c70bb0ec650.var_6777f3bb24f08530 );
        level._livingworld_info.var_fa33a1122ef89e = function_55b13d1cb3cd5ab9( var_a30ca9b6543586b0.var_fa33a1122ef89e, var_35440c70bb0ec650.var_fa33a1122ef89e );
        level._livingworld_info.var_cbb4589c276948cc = function_55b13d1cb3cd5ab9( var_a30ca9b6543586b0.var_cbb4589c276948cc, var_35440c70bb0ec650.var_cbb4589c276948cc );
        
        if ( isdefined( var_a30ca9b6543586b0.var_a66b05201982691e ) )
        {
            level utility::flag_wait( "init_" + level.mapname + "_anim_func_pairs" );
        }
    }
    else
    {
        level._livingworld_info.var_6777f3bb24f08530 = livingworldbundle.var_6777f3bb24f08530;
        level._livingworld_info.var_fa33a1122ef89e = livingworldbundle.var_fa33a1122ef89e;
        level._livingworld_info.var_cbb4589c276948cc = livingworldbundle.var_cbb4589c276948cc;
        level utility::flag_wait( "init_" + getprojectname() + "_anim_func_pairs" );
    }
    
    level._livingworld_info.var_5ff8434ee6eb2e70 = [];
    level._livingworld_info.spawned_ambient = [];
    level._livingworld_info.var_404d633ef6a0c46d = [];
    level._livingworld_info.var_98cc45f371fe5065 = [];
    level._livingworld_info.spawned_ai_vignette = [];
    level._livingworld_info.var_cfec75c2287ad6a4 = [];
    level._livingworld_info.var_55090b6244c73553 = [];
    level._livingworld_info.spawned_ai_combat = [];
    level._livingworld_info.var_c71cabaaa80ba3b2 = [];
    
    if ( !isdefined( level._livingworld_info.var_404d633ef6a0c46d ) )
    {
        level._livingworld_info.var_404d633ef6a0c46d = 0;
    }
    
    foreach ( var_7196936b4dc1beea in level._livingworld_info.var_6777f3bb24f08530 )
    {
        level._livingworld_info.var_404d633ef6a0c46d[ var_7196936b4dc1beea.scenebundle ] = 0;
        
        if ( isdefined( var_a30ca9b6543586b0 ) )
        {
            matching_bundle = function_3f1a3dabf7957b55( var_a30ca9b6543586b0.var_6777f3bb24f08530, var_7196936b4dc1beea );
            var_7196936b4dc1beea.var_1ba91bfc52ee46f3 = isdefined( matching_bundle );
        }
    }
    
    if ( !isdefined( level._livingworld_info.var_cfec75c2287ad6a4 ) )
    {
        level._livingworld_info.var_cfec75c2287ad6a4 = 0;
    }
    
    foreach ( var_9c4623451f441ea4 in level._livingworld_info.var_fa33a1122ef89e )
    {
        level._livingworld_info.var_cfec75c2287ad6a4[ var_9c4623451f441ea4.scenebundle ] = 0;
        
        if ( isdefined( var_a30ca9b6543586b0 ) )
        {
            matching_bundle = function_3f1a3dabf7957b55( var_a30ca9b6543586b0.var_fa33a1122ef89e, var_9c4623451f441ea4 );
            var_9c4623451f441ea4.var_1ba91bfc52ee46f3 = isdefined( matching_bundle );
        }
    }
    
    if ( !isdefined( level._livingworld_info.var_c71cabaaa80ba3b2 ) )
    {
        level._livingworld_info.var_c71cabaaa80ba3b2 = 0;
    }
    
    foreach ( var_c4dd800b0511578e in level._livingworld_info.var_cbb4589c276948cc )
    {
        level._livingworld_info.var_c71cabaaa80ba3b2[ var_c4dd800b0511578e.stringid ] = 0;
        
        if ( isdefined( var_a30ca9b6543586b0 ) )
        {
            matching_bundle = function_3f1a3dabf7957b55( var_a30ca9b6543586b0.var_cbb4589c276948cc, var_c4dd800b0511578e );
            var_c4dd800b0511578e.var_1ba91bfc52ee46f3 = isdefined( matching_bundle );
        }
    }
}

// Namespace zm_livingworld
// Params 2, eflags: 0x4
// Checksum 0xfb564ea2, Offset: 0x171c
// Size: 0xb1
function private function_55b13d1cb3cd5ab9( map_bundles, gametype_bundles )
{
    var_cd0c4ee0bbdafeae = arraycopy( map_bundles );
    
    foreach ( bundle in gametype_bundles )
    {
        matching_bundle = function_3f1a3dabf7957b55( var_cd0c4ee0bbdafeae, bundle );
        
        if ( !isdefined( matching_bundle ) )
        {
            var_cd0c4ee0bbdafeae[ var_cd0c4ee0bbdafeae.size ] = bundle;
        }
    }
    
    return var_cd0c4ee0bbdafeae;
}

// Namespace zm_livingworld
// Params 2, eflags: 0x4
// Checksum 0x6edb2ec3, Offset: 0x17d6
// Size: 0xc3
function private function_3f1a3dabf7957b55( a_bundles, var_eaacfe3de66a5e56 )
{
    if ( !isdefined( a_bundles ) )
    {
        return;
    }
    
    foreach ( bundle in a_bundles )
    {
        if ( var_eaacfe3de66a5e56.scenebundle == bundle.scenebundle )
        {
            return bundle;
        }
        
        if ( var_eaacfe3de66a5e56.stringid == bundle.stringid )
        {
            return bundle;
        }
    }
}

// Namespace zm_livingworld
// Params 2
// Checksum 0x5a044540, Offset: 0x18a2
// Size: 0x38e
function livingworld_post_init( b_skipped, b_save_restored )
{
    level endon( #"game_ended" );
    level utility::flag_wait( "initial_player_connected" );
    waitframe();
    
    if ( game_utility::function_21211f3255f8ea58() )
    {
        level utility::flag_wait( "survival_map_zone_setup_finished" );
        level._livingworld_info.var_c7e0a28ad8822ccc = [ level.poiname ];
        all_zones = zone_manager::get_all_zones();
        var_c9b2499180c5596f = all_zones[ level.poiname ].var_c96b1c3cfbbd6aac;
        
        foreach ( zone_name, zone_struct in var_c9b2499180c5596f )
        {
            level._livingworld_info.var_c7e0a28ad8822ccc[ level._livingworld_info.var_c7e0a28ad8822ccc.size ] = zone_name;
        }
    }
    
    if ( !isdefined( level._livingworld_info.var_90fad1f7b6fa1ff0 ) )
    {
        level._livingworld_info.var_90fad1f7b6fa1ff0 = [];
    }
    
    if ( !isdefined( level._livingworld_info.lw_inited ) )
    {
        level._livingworld_info.lw_inited = [];
    }
    
    var_c747a82fdcf79fc5 = arrayrandomize( level._livingworld_info.livingworldstructs );
    a_priority = [];
    a_remaining = [];
    
    foreach ( player in level.players )
    {
        var_9dc9273e9326d8bf = utility::function_b7f3d374aa10aa51( "zm_living_world", "targetname", player.origin, 600 );
        a_priority = arraycombineunique( a_priority, var_9dc9273e9326d8bf );
    }
    
    foreach ( livingworldstruct in var_c747a82fdcf79fc5 )
    {
        livingworld_init_struct( livingworldstruct );
        
        if ( livingworldstruct.script_forcespawn || arraycontains( a_priority, livingworldstruct ) )
        {
            a_priority = arraycombineunique( a_priority, [ livingworldstruct ] );
            livingworldstruct livingworld_spawn_struct( 1 );
        }
        else
        {
            a_remaining = arraycombineunique( a_remaining, [ livingworldstruct ] );
        }
        
        waitframe();
    }
    
    foreach ( livingworldstruct in a_remaining )
    {
        livingworldstruct livingworld_spawn_struct();
    }
    
    level utility::flag_set( "init_level_living_world_bundles" );
    level waittill( #"never" );
}

// Namespace zm_livingworld
// Params 1, eflags: 0x4
// Checksum 0xf06b422a, Offset: 0x1c38
// Size: 0x9c
function private livingworld_spawn_struct( is_priority )
{
    livingworldstruct = self;
    livingworldstruct.var_102b4c59fb321c29 = livingworld_can_spawn( livingworldstruct );
    
    if ( !livingworldstruct.var_102b4c59fb321c29 && !isdefined( livingworldstruct.info_structs[ "living_world_swap_no_spawned" ] ) )
    {
        return;
    }
    
    if ( livingworldstruct.var_102b4c59fb321c29 )
    {
        livingworldstruct function_9c08b38c56704764();
        livingworldstruct livingworld_spawn_encounter();
    }
    else if ( isdefined( livingworldstruct.info_structs[ "living_world_swap_no_spawned" ] ) )
    {
        livingworldstruct function_f96e4a67c7c1168c();
    }
    
    if ( !is_priority )
    {
        waitframe();
    }
}

// Namespace zm_livingworld
// Params 0
// Checksum 0x6972285c, Offset: 0x1cdc
// Size: 0x177
function function_f96e4a67c7c1168c()
{
    var_cb2380b261be371c = self.info_structs[ "living_world_swap_no_spawned" ];
    
    foreach ( info_struct in var_cb2380b261be371c )
    {
        if ( isdefined( info_struct.object ) || info_struct.var_2f54aeaff63fbdee )
        {
            continue;
        }
        
        if ( !isdefined( info_struct.script_modelname ) && !isdefined( info_struct.scriptbundlename ) )
        {
            assertmsg( "<dev string:x8e>" + info_struct.targetname + "<dev string:xd2>" );
            continue;
        }
        
        if ( info_struct.script_modelname )
        {
            swapped_object = utility::spawn_model( info_struct.script_modelname, info_struct.origin, info_struct.angles );
        }
        else
        {
            swapped_object = spawnscriptable( info_struct.scriptbundlename, info_struct.origin, info_struct.angles );
        }
        
        info_struct.object = swapped_object;
        info_struct.object.info_struct = info_struct;
    }
}

// Namespace zm_livingworld
// Params 1
// Checksum 0x147d03de, Offset: 0x1e5b
// Size: 0x3cb
function livingworld_init_struct( livingworldstruct )
{
    livingworldstruct.zone = livingworldstruct function_9753765cca6fffe5();
    
    if ( !isdefined( level._livingworld_info.var_5ff8434ee6eb2e70[ livingworldstruct.zone.script_zone_name ] ) )
    {
        level._livingworld_info.var_5ff8434ee6eb2e70[ livingworldstruct.zone.script_zone_name ] = 0;
    }
    
    if ( !isdefined( level._livingworld_info.var_98cc45f371fe5065[ livingworldstruct.zone.script_zone_name ] ) )
    {
        level._livingworld_info.var_98cc45f371fe5065[ livingworldstruct.zone.script_zone_name ] = 0;
    }
    
    if ( !isdefined( level._livingworld_info.var_55090b6244c73553[ livingworldstruct.zone.script_zone_name ] ) )
    {
        level._livingworld_info.var_55090b6244c73553[ livingworldstruct.zone.script_zone_name ] = 0;
    }
    
    livingworldstruct.encounterstruct = livingworldstruct function_6aa06979e69f1b41();
    livingworldstruct function_4e7a5dbd4c7cdae2();
    livingworldstruct function_d51d8f79399e315b();
    b_multiple_linked = isdefined( livingworldstruct.script_linkto ) && isdefined( livingworldstruct.script_linkname );
    livingworldstruct function_82ee724a9afe2ff6( b_multiple_linked );
    
    if ( !isdefined( livingworldstruct.var_94d1ab5da995e573 ) && ( isdefined( livingworldstruct.script_linkto ) || isdefined( livingworldstruct.script_linkname ) ) )
    {
        var_5ab965960962f972 = livingworldstruct.linked_lw[ "linkto" ];
        var_5a6e5e96091031c6 = livingworldstruct.linked_lw[ "linked" ];
        var_2d094f70cabb3cf7 = 0;
        
        foreach ( lw_encounter in var_5ab965960962f972 )
        {
            if ( livingworld_can_spawn( lw_encounter ) )
            {
                var_2d094f70cabb3cf7++;
            }
        }
        
        var_26c2842ab28283e3 = 0;
        
        foreach ( lw_encounter in var_5a6e5e96091031c6 )
        {
            if ( livingworld_can_spawn( lw_encounter ) )
            {
                var_26c2842ab28283e3++;
            }
        }
        
        lw_to_spawn = var_2d094f70cabb3cf7 > var_26c2842ab28283e3 ? var_5ab965960962f972 : var_5a6e5e96091031c6;
        lw_to_spawn = b_multiple_linked ? [ utility::array_random( lw_to_spawn ) ] : lw_to_spawn;
        var_a4d02376332e73c6 = arraycombineunique( var_5ab965960962f972, var_5a6e5e96091031c6 );
        
        foreach ( lw_encounter in var_a4d02376332e73c6 )
        {
            if ( lw_encounter.var_94d1ab5da995e573 )
            {
                continue;
            }
            
            lw_encounter.var_94d1ab5da995e573 = !arraycontains( lw_to_spawn, lw_encounter );
        }
    }
    
    level._livingworld_info.lw_inited[ level._livingworld_info.lw_inited.size ] = livingworldstruct;
}

// Namespace zm_livingworld
// Params 1, eflags: 0x4
// Checksum 0x55cc93c9, Offset: 0x222e
// Size: 0x180
function private function_82ee724a9afe2ff6( b_multiple_linked )
{
    livingworldstruct = self;
    livingworldstruct.linked_lw = [];
    livingworldstruct.linked_lw[ "linkto" ] = [];
    livingworldstruct.linked_lw[ "linked" ] = [];
    
    if ( !isdefined( livingworldstruct.script_linkto ) && !isdefined( livingworldstruct.script_linkname ) )
    {
        return;
    }
    
    if ( b_multiple_linked )
    {
        livingworldstruct.linked_lw[ "linkto" ] = utility::getstructarray( livingworldstruct.script_linkto, "script_linkname" );
        var_5a6e5e96091031c6 = function_830cd9ddd370dc80( livingworldstruct.script_linkname );
        livingworldstruct.linked_lw[ "linked" ] = arraycombineunique( var_5a6e5e96091031c6, [ livingworldstruct ] );
        return;
    }
    
    if ( isdefined( livingworldstruct.script_linkto ) )
    {
        livingworldstruct.linked_lw[ "linkto" ] = utility::getstructarray( livingworldstruct.script_linkto, "script_linkname" );
        livingworldstruct.linked_lw[ "linked" ] = function_830cd9ddd370dc80( livingworldstruct.script_linkto );
        return;
    }
    
    livingworldstruct.linked_lw[ "linkto" ] = function_830cd9ddd370dc80( livingworldstruct.script_linkname );
    livingworldstruct.linked_lw[ "linked" ] = utility::getstructarray( livingworldstruct.script_linkname, "script_linkname" );
}

// Namespace zm_livingworld
// Params 0, eflags: 0x4
// Checksum 0x47950022, Offset: 0x23b6
// Size: 0x14f
function private function_4e7a5dbd4c7cdae2()
{
    if ( ( isdefined( self.target ) || isdefined( self.target2 ) ) && !isdefined( self.info_structs ) )
    {
        target_info_structs = utility::getstructarray( self.target, "targetname" );
        var_501386e2d439f1f5 = utility::getstructarray( self.target2, "targetname" );
        info_structs = arraycombineunique( target_info_structs, var_501386e2d439f1f5 );
        
        foreach ( var_af6ad501c4923d18 in info_structs )
        {
            if ( isdefined( var_af6ad501c4923d18.script_string ) )
            {
                if ( !isdefined( self.info_structs[ var_af6ad501c4923d18.script_string ] ) )
                {
                    self.info_structs[ var_af6ad501c4923d18.script_string ] = [];
                }
                
                self.info_structs[ var_af6ad501c4923d18.script_string ][ self.info_structs[ var_af6ad501c4923d18.script_string ].size ] = var_af6ad501c4923d18;
            }
        }
    }
}

// Namespace zm_livingworld
// Params 1, eflags: 0x4
// Checksum 0x150371a9, Offset: 0x250d
// Size: 0xab
function private function_830cd9ddd370dc80( type )
{
    var_5a6e5e96091031c6 = [];
    
    foreach ( livingworldstruct in level._livingworld_info.livingworldstructs )
    {
        if ( livingworldstruct.script_linkto === type )
        {
            var_5a6e5e96091031c6[ var_5a6e5e96091031c6.size ] = livingworldstruct;
        }
    }
    
    return var_5a6e5e96091031c6;
}

// Namespace zm_livingworld
// Params 0, eflags: 0x4
// Checksum 0x86901a33, Offset: 0x25c1
// Size: 0xce
function private function_9753765cca6fffe5()
{
    if ( isdefined( self.script_zone_name ) )
    {
        zone = zone_manager::get_zone_struct( self.script_zone_name );
    }
    else
    {
        closest_pos = isnavmeshloaded() ? getclosestpointonnavmesh( self.origin + ( 0, 0, 10 ) ) : self.origin + ( 0, 0, 10 );
        zone = zone_manager::function_90e5c3e2272b0130( closest_pos );
        
        if ( !isdefined( zone ) )
        {
            zone = function_47c86977a18df38b( level.zone_manager.inited_defs, self.origin + ( 0, 0, 10 ) );
        }
    }
    
    assert( isdefined( zone ), "<dev string:xe4>" + self.origin );
    return zone;
}

// Namespace zm_livingworld
// Params 0, eflags: 0x4
// Checksum 0x6094c5c7, Offset: 0x2698
// Size: 0xa0
function private function_d51d8f79399e315b()
{
    if ( isdefined( self.var_3920f827ef511acd ) )
    {
        return;
    }
    
    cancel_type = self.script_scenescriptbundle ?? self.script_string;
    self.var_3920f827ef511acd = [ cancel_type + "_cancel_living_world_encounter_" + self.origin ];
    
    if ( isdefined( self.script_ender ) )
    {
        self.var_3920f827ef511acd = arraycombine( self.var_3920f827ef511acd, strtok( self.script_ender, "," ) );
    }
    
    self.var_3920f827ef511acd[ self.var_3920f827ef511acd.size ] = "game_ended";
}

// Namespace zm_livingworld
// Params 1
// Checksum 0x6462d3a9, Offset: 0x2740
// Size: 0x47d, Type: bool
function livingworld_can_spawn( livingworldstruct )
{
    if ( getdvarint( @"scr_spawn_no_living_world", 0 ) )
    {
        if ( !function_734891ebaa49335f( livingworldstruct, "only_living_world" ) )
        {
            return false;
        }
    }
    
    if ( function_734891ebaa49335f( livingworldstruct, "no_living_world" ) )
    {
        return false;
    }
    
    if ( livingworldstruct.var_94d1ab5da995e573 )
    {
        return false;
    }
    
    encounterstruct = livingworldstruct.encounterstruct ?? livingworldstruct function_6aa06979e69f1b41();
    zone = livingworldstruct.zone ?? livingworldstruct function_9753765cca6fffe5();
    
    if ( !( isdefined( encounterstruct ) && isdefined( zone ) ) )
    {
        return false;
    }
    
    if ( game_utility::function_21211f3255f8ea58() && !arraycontains( level._livingworld_info.var_c7e0a28ad8822ccc, zone.script_zone_name ) )
    {
        return false;
    }
    
    livingworldstruct function_d51d8f79399e315b();
    
    if ( !isdefined( level._livingworld_info.var_5ff8434ee6eb2e70[ zone.script_zone_name ] ) )
    {
        level._livingworld_info.var_5ff8434ee6eb2e70[ zone.script_zone_name ] = 0;
    }
    
    if ( !isdefined( level._livingworld_info.var_98cc45f371fe5065[ zone.script_zone_name ] ) )
    {
        level._livingworld_info.var_98cc45f371fe5065[ zone.script_zone_name ] = 0;
    }
    
    if ( !isdefined( level._livingworld_info.var_55090b6244c73553[ zone.script_zone_name ] ) )
    {
        level._livingworld_info.var_55090b6244c73553[ zone.script_zone_name ] = 0;
    }
    
    if ( livingworldstruct.var_67c31f2a94afd9b1 )
    {
        var_1537cffec31889d7 = level._livingworld_info.var_5ff8434ee6eb2e70[ zone.script_zone_name ];
        var_8c715a5283580d38 = level._livingworld_info.var_404d633ef6a0c46d[ livingworldstruct.script_scenescriptbundle ];
        var_ff70c1d124ff0985 = level._livingworld_info.var_f670b2081fe497e9;
        spawnchance = var_1537cffec31889d7 < 1 ? level._livingworld_info.var_939c8b2cfefb86e0 : level._livingworld_info.var_939c8e2cfefb8d79;
    }
    else if ( livingworldstruct.var_c2d5815a88c24edd )
    {
        var_1537cffec31889d7 = level._livingworld_info.var_98cc45f371fe5065[ zone.script_zone_name ];
        var_8c715a5283580d38 = level._livingworld_info.var_cfec75c2287ad6a4[ livingworldstruct.script_scenescriptbundle ];
        var_ff70c1d124ff0985 = level._livingworld_info.var_f9c65d952ff11e60;
        spawnchance = level._livingworld_info.var_1762d6b7b834058d;
    }
    else
    {
        var_1537cffec31889d7 = level._livingworld_info.var_55090b6244c73553[ zone.script_zone_name ];
        var_8c715a5283580d38 = level._livingworld_info.var_c71cabaaa80ba3b2[ encounterstruct.stringid ];
        var_ff70c1d124ff0985 = level._livingworld_info.var_6192e0a84b9b8db6;
        spawnchance = level._livingworld_info.var_f0e7077dafd0a727;
    }
    
    var_2db22a94c233b396 = 0;
    
    if ( level._livingworld_info.var_90fad1f7b6fa1ff0.size > 0 )
    {
        var_2db22a94c233b396 = level._livingworld_info.var_90fad1f7b6fa1ff0.size;
    }
    
    num_ai = function_65635ca686a6f72a( livingworldstruct );
    var_2db22a94c233b396 += num_ai;
    
    if ( var_2db22a94c233b396 > 36 )
    {
        return false;
    }
    
    save_code = livingworldstruct function_f53b19b14215d776();
    
    if ( zm_save::function_1dda3554974a999e() && save_code != "2" )
    {
        if ( save_code == "1" )
        {
            return false;
        }
        
        if ( !livingworldstruct.script_forcespawn && zone.is_enabled && encounterstruct.var_218c76bb91c75016 != 999 )
        {
            return false;
        }
    }
    
    b_can_spawn = utility::percent_chance( spawnchance * 100 );
    
    if ( livingworldstruct.script_forcespawn || getdvarint( @"scr_spawn_all_living_world", 0 ) )
    {
        return true;
    }
    else if ( ( encounterstruct.var_89ca25b5d21b44a0 == 0 || var_8c715a5283580d38 < encounterstruct.var_89ca25b5d21b44a0 ) && var_1537cffec31889d7 < var_ff70c1d124ff0985 && b_can_spawn )
    {
        return true;
    }
    
    return false;
}

// Namespace zm_livingworld
// Params 1, eflags: 0x4
// Checksum 0xfb967305, Offset: 0x2bc6
// Size: 0x15a
function private function_65635ca686a6f72a( livingworldstruct )
{
    if ( isdefined( livingworldstruct.script_scenescriptbundle ) )
    {
        scenescriptbundlename = livingworldstruct.script_scenescriptbundle;
        var_775c9d29657e0689 = isxhashasset( scenescriptbundlename ) ? scenescriptbundlename : hashcat( %"scenescriptbundle:", scenescriptbundlename );
        scriptbundle = utility::function_dc226e1c2f06ea0b( var_775c9d29657e0689 );
        num_ai = 0;
        
        foreach ( obj in scriptbundle.objects )
        {
            if ( obj.variant_type === "Types_Actor" )
            {
                num_ai++;
            }
        }
    }
    else
    {
        livingworldstruct function_4e7a5dbd4c7cdae2();
        
        if ( !isdefined( livingworldstruct.info_structs[ "living_world_spawner" ] ) )
        {
            assertmsg( "<dev string:x10f>" + livingworldstruct.script_string + "<dev string:x128>" );
            num_ai = 0;
        }
        else
        {
            num_ai = livingworldstruct.info_structs[ "living_world_spawner" ].size;
        }
    }
    
    return num_ai;
}

// Namespace zm_livingworld
// Params 0, eflags: 0x4
// Checksum 0x1ce737c6, Offset: 0x2d29
// Size: 0x3a
function private function_548a067eccee7343()
{
    if ( isdefined( self.script_scenescriptbundle ) )
    {
        return self.scene_ents[ "actors" ];
    }
    else
    {
        return arraycombine( self.var_8cdfbe729ebfdd80, self.var_b9dc955e2a0cb75f );
    }
    
    return [];
}

// Namespace zm_livingworld
// Params 2
// Checksum 0x966568ad, Offset: 0x2d6c
// Size: 0xdd, Type: bool
function function_734891ebaa49335f( livingworldstruct, var_294ec3f9c5ef8097 )
{
    if ( isdefined( livingworldstruct.script_spawngroup ) )
    {
        string = string( livingworldstruct.script_spawngroup );
        dvar_spawn_groups = strtok( string, "," );
        
        foreach ( spawn_group in dvar_spawn_groups )
        {
            if ( getdvarint( hashcat( @"scr_spawn", "_", var_294ec3f9c5ef8097 + spawn_group ), 0 ) )
            {
                return true;
            }
        }
    }
    
    return false;
}

// Namespace zm_livingworld
// Params 0
// Checksum 0x9ceff032, Offset: 0x2e52
// Size: 0x15a
function function_6aa06979e69f1b41()
{
    if ( !isdefined( level._livingworld_info ) )
    {
        return;
    }
    
    assert( isdefined( self.script_string ) || isdefined( self.script_scenescriptbundle ), "<dev string:x140>" + self.origin + "<dev string:x166>" );
    matching_bundle = undefined;
    
    if ( isdefined( self.script_string ) )
    {
        var_eaacfe3de66a5e56 = { #stringid:self.script_string };
        matching_bundle = function_3f1a3dabf7957b55( level._livingworld_info.var_cbb4589c276948cc, var_eaacfe3de66a5e56 );
        self.var_4e0eb39dc8466ea7 = isdefined( matching_bundle );
    }
    else if ( isdefined( self.script_scenescriptbundle ) )
    {
        var_eaacfe3de66a5e56 = { #scenebundle:self.script_scenescriptbundle };
        matching_bundle = function_3f1a3dabf7957b55( level._livingworld_info.var_6777f3bb24f08530, var_eaacfe3de66a5e56 );
        self.var_67c31f2a94afd9b1 = isdefined( matching_bundle );
        
        if ( isdefined( matching_bundle ) )
        {
            return matching_bundle;
        }
        
        matching_bundle = function_3f1a3dabf7957b55( level._livingworld_info.var_fa33a1122ef89e, var_eaacfe3de66a5e56 );
        self.var_c2d5815a88c24edd = isdefined( matching_bundle );
    }
    
    encounter = self.script_string ?? self.script_scenescriptbundle;
    assert( isdefined( encounter ), "<dev string:x1a8>" + encounter );
    return matching_bundle;
}

// Namespace zm_livingworld
// Params 0, eflags: 0x4
// Checksum 0xd61cdafd, Offset: 0x2fb5
// Size: 0xd0
function private function_f53b19b14215d776()
{
    if ( !isdefined( self.script_count ) )
    {
        return;
    }
    
    var_52739af5a80011fa = [ "2", "1" ];
    
    for ( i = 0; i < var_52739af5a80011fa.size ; i++ )
    {
        var_82a731556176587a = var_52739af5a80011fa[ i ];
        spawn_key = function_bd716da69c68dd2e( var_82a731556176587a );
        storage_int = zm_quest::function_73720cdf21c3cfd7( #"zm_livingworld", spawn_key );
        
        if ( !isdefined( storage_int ) )
        {
            continue;
        }
        
        index = utility::function_c73b75a176f26cf6( self.script_count );
        
        if ( !isdefined( index ) )
        {
            continue;
        }
        
        var_48f73d3122210fa4 = utility::get_bit_flag( storage_int, index );
        
        if ( !var_48f73d3122210fa4 )
        {
            continue;
        }
        
        return var_82a731556176587a;
    }
}

// Namespace zm_livingworld
// Params 1, eflags: 0x4
// Checksum 0x5863c9ef, Offset: 0x308e
// Size: 0x13c
function private function_4cd7c660bedf807a( save_code )
{
    var_481e6ab3e163cedb = arraycombineunique( [ self ], self.linked_lw[ "linkto" ], self.linked_lw[ "linked" ] );
    
    foreach ( lw_struct in var_481e6ab3e163cedb )
    {
        if ( !( isdefined( lw_struct.script_count ) && isdefined( save_code ) ) )
        {
            continue;
        }
        
        key = lw_struct function_bd716da69c68dd2e( save_code );
        index = utility::function_c73b75a176f26cf6( lw_struct.script_count );
        
        if ( !( isdefined( key ) && isdefined( index ) ) )
        {
            continue;
        }
        
        storage_int = zm_quest::function_73720cdf21c3cfd7( #"zm_livingworld", key ) ?? 0;
        storage_int = utility::set_bit_flag( storage_int, index );
        level zm_quest::function_4eefe6de31f5ddab( #"zm_livingworld", key, storage_int );
    }
}

// Namespace zm_livingworld
// Params 1, eflags: 0x4
// Checksum 0x740ebbb7, Offset: 0x31d2
// Size: 0x13c
function private function_3c898ee55a926e83( save_code )
{
    var_d16ca64e0b74f62a = arraycombineunique( [ self ], self.linked_lw[ "linkto" ], self.linked_lw[ "linked" ] );
    
    foreach ( lw_struct in var_d16ca64e0b74f62a )
    {
        if ( !( isdefined( lw_struct.script_count ) && isdefined( save_code ) ) )
        {
            continue;
        }
        
        key = lw_struct function_bd716da69c68dd2e( save_code );
        index = utility::function_c73b75a176f26cf6( lw_struct.script_count );
        
        if ( !( isdefined( key ) && isdefined( index ) ) )
        {
            continue;
        }
        
        storage_int = zm_quest::function_73720cdf21c3cfd7( #"zm_livingworld", key ) ?? 0;
        storage_int = utility::function_911d2d3c6d773726( storage_int, index );
        level zm_quest::function_4eefe6de31f5ddab( #"zm_livingworld", key, storage_int );
    }
}

// Namespace zm_livingworld
// Params 1, eflags: 0x4
// Checksum 0x22746951, Offset: 0x3316
// Size: 0x56
function private function_bd716da69c68dd2e( save_code )
{
    if ( !isdefined( self.script_count ) )
    {
        return;
    }
    
    var_78042192f6c685fd = utility::function_9ab002313e87d84c( self.script_count );
    var_a8d33a06f27f4ebb = string( var_78042192f6c685fd );
    return hashcat( #"zm_livingworld", save_code, var_a8d33a06f27f4ebb );
}

// Namespace zm_livingworld
// Params 0, eflags: 0x4
// Checksum 0xe3996311, Offset: 0x3375
// Size: 0x2f4
function private function_9c08b38c56704764()
{
    if ( self.var_67c31f2a94afd9b1 )
    {
        if ( !isdefined( level._livingworld_info.var_5ff8434ee6eb2e70[ self.zone.script_zone_name ] ) )
        {
            level._livingworld_info.var_5ff8434ee6eb2e70[ self.zone.script_zone_name ] = 0;
        }
        
        level._livingworld_info.var_5ff8434ee6eb2e70[ self.zone.script_zone_name ]++;
        level._livingworld_info.spawned_ambient[ level._livingworld_info.spawned_ambient.size ] = self;
        
        if ( !isdefined( level._livingworld_info.var_404d633ef6a0c46d ) )
        {
            level._livingworld_info.var_404d633ef6a0c46d = 0;
        }
        
        level._livingworld_info.var_404d633ef6a0c46d[ self.script_scenescriptbundle ]++;
        return;
    }
    
    if ( self.var_c2d5815a88c24edd )
    {
        if ( !isdefined( level._livingworld_info.var_98cc45f371fe5065[ self.zone.script_zone_name ] ) )
        {
            level._livingworld_info.var_98cc45f371fe5065[ self.zone.script_zone_name ] = 0;
        }
        
        level._livingworld_info.var_98cc45f371fe5065[ self.zone.script_zone_name ]++;
        level._livingworld_info.spawned_ai_vignette[ level._livingworld_info.spawned_ai_vignette.size ] = self;
        
        if ( !isdefined( level._livingworld_info.var_cfec75c2287ad6a4 ) )
        {
            level._livingworld_info.var_cfec75c2287ad6a4 = 0;
        }
        
        level._livingworld_info.var_cfec75c2287ad6a4[ self.script_scenescriptbundle ]++;
        return;
    }
    
    if ( !isdefined( level._livingworld_info.var_55090b6244c73553[ self.zone.script_zone_name ] ) )
    {
        level._livingworld_info.var_55090b6244c73553[ self.zone.script_zone_name ] = 0;
    }
    
    level._livingworld_info.var_55090b6244c73553[ self.zone.script_zone_name ]++;
    level._livingworld_info.spawned_ai_combat[ level._livingworld_info.spawned_ai_combat.size ] = self;
    
    if ( !isdefined( level._livingworld_info.var_c71cabaaa80ba3b2 ) )
    {
        level._livingworld_info.var_c71cabaaa80ba3b2 = 0;
    }
    
    level._livingworld_info.var_c71cabaaa80ba3b2[ self.encounterstruct.stringid ]++;
}

// Namespace zm_livingworld
// Params 0
// Checksum 0xd26a374, Offset: 0x3671
// Size: 0x883
function livingworld_spawn_encounter()
{
    self.isplaying = 0;
    self.var_47ea6ee6b1f5f5b7 = 0;
    self.var_94d1ab5da995e573 = 0;
    self.var_b409a727ea4063cc = 0;
    utility::ent_flag_clear( "any_ent_scene_died" );
    utility::ent_flag_clear( "any_ent_scene_ended" );
    utility::ent_flag_clear( "block_trigger" );
    level callback::callback( "zm_living_world_encounter_spawned", self );
    logstring( "Living World Info Scene:" + ( self.encounterstruct.stringid ?? self.script_scenescriptbundle ) );
    
    /#
        iprintlnbold( "<dev string:x1da>" + ( self.encounterstruct.stringid ?? self.script_scenescriptbundle ) );
    #/
    
    logstring( "Living World Info Location:" + self.origin + " // Zone: " + self.zone.script_zone_name );
    
    /#
        iprintlnbold( "<dev string:x1f3>" + self.origin + "<dev string:x20f>" + self.zone.script_zone_name );
    #/
    
    if ( isdefined( level._livingworld_info.itemspawnlist ) && isdefined( self.script_noteworthy ) )
    {
        function_bb20468909915a22();
    }
    
    if ( isdefined( self.info_structs[ "living_world_swap_no_spawned" ] ) )
    {
        var_cb2380b261be371c = self.info_structs[ "living_world_swap_no_spawned" ];
        
        foreach ( info_struct in var_cb2380b261be371c )
        {
            info_struct.var_2f54aeaff63fbdee = 1;
            
            if ( !isdefined( info_struct.object ) )
            {
                continue;
            }
            
            if ( info_struct.object utility::function_de1f80d93273abf5() )
            {
                info_struct.object freescriptable();
                continue;
            }
            
            info_struct.object delete();
        }
    }
    
    if ( isdefined( self.script_scenescriptbundle ) )
    {
        callback::callback( self.script_scenescriptbundle + "_spawned" );
        var_e32757d0c29da9ee = scene::get_shot_names();
        self.shotnames = [];
        self.shotnames[ "action" ] = [];
        self.shotnames[ "end" ] = [];
        self.shotnames[ "attack" ] = [];
        self.shotnames[ "return" ] = [];
        self.shotnames[ "death" ] = [];
        self.shotnames[ "looping_idle" ] = [];
        self.shotnames[ "idle" ] = [];
        self.shotnames[ "breakout" ] = [];
        self.shotnames[ "directional" ] = [];
        
        foreach ( shot_name in var_e32757d0c29da9ee )
        {
            str_array_to_add = function_92e65fd6edbfac4e( shot_name );
            
            if ( !isdefined( str_array_to_add ) )
            {
                continue;
            }
            
            if ( !isdefined( self.shotnames[ str_array_to_add ] ) )
            {
                self.shotnames[ str_array_to_add ] = [];
            }
            
            self.shotnames[ str_array_to_add ][ self.shotnames[ str_array_to_add ].size ] = shot_name;
            
            if ( issubstr( shot_name, "breakout" ) )
            {
                if ( !isdefined( self.shotnames[ "breakout" ] ) )
                {
                    self.shotnames[ "breakout" ] = [];
                }
                
                self.shotnames[ "breakout" ][ self.shotnames[ "breakout" ].size ] = shot_name;
            }
            
            var_c6657815cc681e83 = issubstr( shot_name, "left" ) || issubstr( shot_name, "right" ) || issubstr( shot_name, "forward" ) || issubstr( shot_name, "behind" );
            
            if ( var_c6657815cc681e83 )
            {
                if ( !isdefined( self.shotnames[ "directional" ] ) )
                {
                    self.shotnames[ "directional" ] = [];
                }
                
                self.shotnames[ "directional" ][ self.shotnames[ "directional" ].size ] = shot_name;
            }
            
            self.skip[ str_array_to_add ] = 0;
        }
        
        scene_objects = function_afddf62139dbeda();
        
        if ( !isdefined( self.scene_root ) )
        {
            if ( self.var_58e6c0d1fd24de83.size == 1 )
            {
                self.scene_root = self.var_58e6c0d1fd24de83[ 0 ];
            }
            else if ( isdefined( self.info_structs[ "living_world_tag_align" ] ) )
            {
                var_8316bae1b8340c08 = self.info_structs[ "living_world_tag_align" ][ 0 ];
                self.scene_root = utility::spawn_model( "tag_origin", var_8316bae1b8340c08.origin, var_8316bae1b8340c08.angles );
            }
            else
            {
                self.scene_root = self;
            }
        }
        
        self.scene_root.livingworldstruct = self;
        self.scene_root.init_shot = undefined;
        
        if ( function_7c9493cb0c008bdb( "looping_idle" ) )
        {
            self.scene_root.init_shot = function_29337345ce38903e( "looping_idle" );
        }
        else if ( function_7c9493cb0c008bdb( "idle" ) )
        {
            self.scene_root.init_shot = function_29337345ce38903e( "idle" );
        }
        else
        {
            self.scene_root.init_shot = function_29337345ce38903e( "action" );
        }
        
        function_25a74db025a58ccb( "_pre_play" );
        
        if ( isnavmeshloaded() )
        {
            self.scene_root scene::init( scene_objects, self.scene_root.init_shot, self.script_scenescriptbundle );
            self.scene_root callback::function_99edd620ee45cd95( getxhash( #"zm_livingworld" ) );
            self.scene_root function_aef9e0b80abf1246( 1, "callback_death_anim", &function_81a561e9fdd18c94, self, #"zm_livingworld" );
        }
        
        self.var_c0993ffe04a4ad27 = 0;
        self.var_3cd2eba2b7ff6812 = 0;
        self.scene_ents = [];
        self.scene_ents[ "actors" ] = [];
        self.scene_ents[ "props" ] = [];
        function_c3b7a0f5562679bc();
        
        foreach ( var_61ea0c942e76233d in self.scene_ents )
        {
            foreach ( ent in var_61ea0c942e76233d )
            {
                ent utility::ent_flag_clear( "ent_scene_death_anim_playing" );
            }
        }
        
        utility::ent_flag_clear( "any_ent_scene_died" );
        function_2035bfe862574dc();
        callback::callback( self.script_scenescriptbundle + "_idle" );
        level callback::callback( "zm_living_world_scene_idle", self );
    }
    else
    {
        callback::callback( self.encounterstruct.stringid + "_spawned" );
        self.var_b9dc955e2a0cb75f = [];
        self.var_8cdfbe729ebfdd80 = [];
        sparams = spawnstruct();
        sparams.encounterstruct = self.encounterstruct;
        function_25a74db025a58ccb( "_pre_play" );
        function_d9800dd668183bf2();
        callback::callback( self.encounterstruct.stringid + "_idle" );
        level callback::callback( "zm_living_world_aicombat_idle", self );
    }
    
    thread function_692a554a03c5806a();
}

// Namespace zm_livingworld
// Params 0, eflags: 0x4
// Checksum 0x1d66fac7, Offset: 0x3efc
// Size: 0x17e
function private function_692a554a03c5806a()
{
    level endon( #"game_ended" );
    self endon( #"cancel_encounter" );
    
    if ( self.idle_func_vars.var_aacbe22211b4a5db )
    {
        function_4cd7c660bedf807a( "2" );
    }
    else
    {
        function_3c898ee55a926e83( "2" );
    }
    
    function_c69e46798f3921ab();
    waittillframeend();
    
    if ( isdefined( self.script_scenescriptbundle ) )
    {
        existing_ents = function_a7ba0b783fa73958();
        
        if ( existing_ents.size && !self.var_47ea6ee6b1f5f5b7 )
        {
            callback::callback( self.script_scenescriptbundle + "_play" );
            level callback::callback( "zm_living_world_scene_play", self );
            function_168d64aabc6b69e8();
            callback::callback( self.script_scenescriptbundle + "_post_play" );
            level callback::callback( "zm_living_world_scene_post_play", self );
        }
    }
    else
    {
        callback::callback( self.encounterstruct.stringid + "_play" );
        level callback::callback( "zm_living_world_aicombat_play", self );
        function_2e154822ca458fa();
    }
    
    if ( !self.action_func_vars.var_aacbe22211b4a5db && ( self.action_func_vars.var_22a8df214305f621 || utility::ent_flag( "all_ai_encounter_died" ) ) )
    {
        function_4cd7c660bedf807a( "1" );
    }
    else
    {
        function_3c898ee55a926e83( "1" );
    }
    
    if ( !self.var_47ea6ee6b1f5f5b7 )
    {
        self notify( #"hash_30d11728ec87ccb" );
    }
}

// Namespace zm_livingworld
// Params 0
// Checksum 0xe1ec5209, Offset: 0x4082
// Size: 0x5c9
function function_afddf62139dbeda()
{
    scene_objects = undefined;
    
    if ( !isdefined( scene_objects ) )
    {
        scene_objects = [];
    }
    
    if ( !isdefined( self.var_58e6c0d1fd24de83 ) )
    {
        self.var_58e6c0d1fd24de83 = [];
    }
    
    if ( isdefined( self.target ) || isdefined( self.target2 ) )
    {
        if ( isdefined( self.target ) && isdefined( self.target2 ) )
        {
            var_849bb26973408b4c = getscriptablearray( self.target, #targetname );
            var_322899394dc702a9 = getentitylessscriptablearray( self.target, #targetname );
            var_a1ac6e1fe5c9f434 = getscriptablearray( self.target2, #targetname );
            var_7ac5dbe1314a87d1 = getentitylessscriptablearray( self.target2, #targetname );
        }
        else if ( isdefined( self.target ) )
        {
            var_849bb26973408b4c = getscriptablearray( self.target, #targetname );
            var_322899394dc702a9 = getentitylessscriptablearray( self.target, #targetname );
        }
        else
        {
            var_a1ac6e1fe5c9f434 = getscriptablearray( self.target2, #targetname );
            var_7ac5dbe1314a87d1 = getentitylessscriptablearray( self.target2, #targetname );
        }
        
        var_add18175a5765096 = arraycombine( var_849bb26973408b4c, var_322899394dc702a9, var_a1ac6e1fe5c9f434, var_7ac5dbe1314a87d1 );
        
        foreach ( var_af6ad501c4923d18 in var_add18175a5765096 )
        {
            if ( !isdefined( var_af6ad501c4923d18.script_noteworthy ) || arraycontains( scene_objects, var_af6ad501c4923d18 ) || !isdefined( var_af6ad501c4923d18 ) )
            {
                continue;
            }
            
            var_1c8f055674ecbb46 = strtok( var_af6ad501c4923d18.script_noteworthy, "," );
            living_world_info = var_1c8f055674ecbb46[ 0 ];
            objectname = var_1c8f055674ecbb46[ 1 ];
            
            if ( !( isdefined( living_world_info ) && isdefined( objectname ) ) || !isdefined( var_af6ad501c4923d18 ) )
            {
                continue;
            }
            
            if ( living_world_info != "living_world_vehicle" || !function_43698d627196312b( objectname ) || !isdefined( var_af6ad501c4923d18 ) )
            {
                continue;
            }
            
            var_af6ad501c4923d18.animname = objectname;
            self.var_58e6c0d1fd24de83[ self.var_58e6c0d1fd24de83.size ] = var_af6ad501c4923d18;
        }
    }
    
    if ( !self.encounterstruct.var_e4c1b229a4eca8d4 || !self.encounterstruct.objectoptions.size )
    {
        return scene_objects;
    }
    
    foreach ( option in self.encounterstruct.objectoptions )
    {
        if ( !option.objects.size )
        {
            continue;
        }
        
        if ( !function_43698d627196312b( option.objectname ) )
        {
            continue;
        }
        
        objects = [];
        object_weights = [];
        
        foreach ( objectoption in option.objects )
        {
            switch ( option.objectoption )
            {
                case #"hash_739cd2e1fbaf389a":
                    object = objectoption.model;
                    break;
                case #"hash_fa7cd9f6bda5bc3f":
                    object = objectoption.aitype;
                    break;
                case #"hash_74de1937c8048866":
                    object = objectoption.compositemodel;
                    break;
                default:
                    break;
            }
            
            if ( !isdefined( object ) )
            {
                assertmsg( "<dev string:x21a>" + option.objectname + "<dev string:x23c>" );
                continue;
            }
            
            objects[ objects.size ] = object;
            object_weights[ object_weights.size ] = objectoption.objectweight;
        }
        
        if ( !objects.size )
        {
            continue;
        }
        
        random_object = utility::random_weighted( objects, object_weights );
        
        if ( option.objectoption == "MODEL" || option.objectoption == "COMPOSITE_MODEL" )
        {
            scene_object = utility::spawn_model( random_object, self.origin, self.angles );
        }
        else if ( option.objectoption == "AI" )
        {
            scriptbundle = getaitypescriptbundle( random_object );
            team = isdefined( scriptbundle.type ) && scriptbundle.type != "zombie" ? scriptbundle.team : "team_two_hundred";
            scene_object = namespace_9d8e359c3b1041e5::spawnnewaitype_sharedfunc( random_object, self.origin, self.angles, team );
        }
        else
        {
            continue;
        }
        
        if ( !scene_object )
        {
            continue;
        }
        
        scene_object.animname = option.objectname;
        scene_objects[ scene_objects.size ] = scene_object;
    }
    
    return scene_objects;
}

// Namespace zm_livingworld
// Params 1
// Checksum 0x94fed854, Offset: 0x4654
// Size: 0x58, Type: bool
function function_43698d627196312b( objectname )
{
    if ( !isdefined( objectname ) )
    {
        assertmsg( objectname + "<dev string:x243>" );
        return false;
    }
    
    if ( !scene::function_91d4fb6d5b238f7c( self.script_scenescriptbundle, objectname ) )
    {
        assertmsg( objectname + "<dev string:x254>" + self.script_scenescriptbundle );
        return false;
    }
    
    return true;
}

// Namespace zm_livingworld
// Params 0
// Checksum 0x26cd9ff0, Offset: 0x46b5
// Size: 0x1b4
function function_c3b7a0f5562679bc()
{
    old_scene_ents = arraycombine( self.scene_ents[ "actors" ], self.scene_ents[ "props" ] );
    current_scene_ents = self.scene_root scene::get_entities();
    current_scene_ents = arraycombine( self.var_58e6c0d1fd24de83, current_scene_ents );
    scene_ents = arraycombineunique( current_scene_ents, old_scene_ents );
    self.scene_ents[ "actors" ] = [];
    self.scene_ents[ "props" ] = [];
    
    foreach ( ent in scene_ents )
    {
        if ( !isdefined( ent ) )
        {
            continue;
        }
        
        if ( !isai( ent ) )
        {
            self.scene_ents[ "props" ] = arraycombineunique( self.scene_ents[ "props" ], [ ent ] );
            continue;
        }
        
        if ( !isalive( ent ) )
        {
            continue;
        }
        
        self.scene_ents[ "actors" ] = arraycombineunique( self.scene_ents[ "actors" ], [ ent ] );
        
        if ( !arraycontains( level._livingworld_info.var_90fad1f7b6fa1ff0, ent ) )
        {
            level._livingworld_info.var_90fad1f7b6fa1ff0[ level._livingworld_info.var_90fad1f7b6fa1ff0.size ] = ent;
        }
    }
}

// Namespace zm_livingworld
// Params 0, eflags: 0x4
// Checksum 0xe4a55e35, Offset: 0x4871
// Size: 0x122
function private function_bb20468909915a22()
{
    var_8c0e28a3e48d9834 = utility::getstructarray( "zm_living_world_bait", "targetname" );
    var_8c0e28a3e48d9834 = function_5713d46873b29625( var_8c0e28a3e48d9834 );
    
    foreach ( bait_struct in var_8c0e28a3e48d9834 )
    {
        if ( self.script_noteworthy == bait_struct.script_noteworthy && !bait_struct.var_243ca41699751598 )
        {
            spawnoptions = common_item::items_initspawnoptions_spawnfromposition( bait_struct.origin, bait_struct.angles );
            self.bait = common_item::function_38cde6a6acb68ea6( level._livingworld_info.itemspawnlist, 1, spawnoptions );
            bait_struct.var_243ca41699751598 = 1;
            level callback::add( "on_round_start", &function_4dd1fa6ab0fc3543, self );
        }
    }
}

// Namespace zm_livingworld
// Params 1, eflags: 0x4
// Checksum 0xfed1523d, Offset: 0x499b
// Size: 0xbd
function private function_92e65fd6edbfac4e( shot_name )
{
    if ( issubstr( shot_name, "action" ) )
    {
        str_to_add = "action";
    }
    else if ( issubstr( shot_name, "end" ) )
    {
        str_to_add = "end";
    }
    else if ( issubstr( shot_name, "attack" ) )
    {
        str_to_add = "attack";
    }
    else if ( issubstr( shot_name, "return" ) )
    {
        str_to_add = "return";
    }
    else if ( issubstr( shot_name, "death" ) )
    {
        str_to_add = "death";
    }
    else if ( issubstr( shot_name, "idle" ) )
    {
        if ( issubstr( shot_name, "looping_idle" ) )
        {
            str_to_add = "looping_idle";
        }
        else
        {
            str_to_add = "idle";
        }
    }
    
    return str_to_add;
}

// Namespace zm_livingworld
// Params 0
// Checksum 0xd6686f4c, Offset: 0x4a61
// Size: 0x11, Type: bool
function livingworld_is_zombie()
{
    return self.type == "zombie";
}

// Namespace zm_livingworld
// Params 5
// Checksum 0x844f7a45, Offset: 0x4a7b
// Size: 0x77
function function_aef9e0b80abf1246( b_add_callback, event, func, s_additional_params, template_name )
{
    if ( isdefined( template_name ) )
    {
        template_name = getxhash( template_name );
        callback_ent = callback::get_template( template_name );
    }
    else
    {
        callback_ent = self;
    }
    
    callback_ent callback::remove( event, func, s_additional_params );
    
    if ( b_add_callback )
    {
        callback_ent callback::add( event, func, s_additional_params );
    }
}

// Namespace zm_livingworld
// Params 1
// Checksum 0xc81d0590, Offset: 0x4afa
// Size: 0x1f, Type: bool
function function_1d0b3d1864dce638( livingworldstruct )
{
    if ( self.var_f2bc035a31b7e81b != livingworldstruct )
    {
        return false;
    }
    
    return true;
}

// Namespace zm_livingworld
// Params 1, eflags: 0x4
// Checksum 0x6ba01bdb, Offset: 0x4b22
// Size: 0x362
function private on_round_start( sparams )
{
    round_number = zm_round_logic::get_rb_round_number();
    var_f6aa8f8da9bb7913 = arraycombine( level._livingworld_info.spawned_ambient, level._livingworld_info.spawned_ai_vignette, level._livingworld_info.spawned_ai_combat );
    
    foreach ( livingworldstruct in var_f6aa8f8da9bb7913 )
    {
        if ( !isdefined( livingworldstruct ) )
        {
            continue;
        }
        
        if ( !isdefined( livingworldstruct.var_b409a727ea4063cc ) )
        {
            continue;
        }
        
        livingworldstruct.var_b409a727ea4063cc++;
        var_72f61e6858e1a01b = livingworldstruct.script_int ?? livingworldstruct.encounterstruct.var_9d3a969000aa4fac;
        lw_ents = function_548a067eccee7343();
        
        foreach ( ent in lw_ents )
        {
            if ( !isalive( ent ) || !ent livingworld_is_zombie() || ent.health == ent.maxhealth )
            {
                continue;
            }
            
            if ( ent.health != 0 && ent.maxhealth != 0 )
            {
                old_health_perc = ent.health / ent.maxhealth;
                ent zombie_utils::set_zombie_round_difficulty( round_number );
                ent.health = int( ceil( ent.health * old_health_perc ) );
            }
        }
        
        if ( livingworldstruct.var_4321bdc43deb678f )
        {
            continue;
        }
        
        if ( livingworldstruct.isplaying )
        {
            if ( livingworldstruct.var_c2d5815a88c24edd )
            {
                continue;
            }
            
            if ( livingworldstruct.encounterstruct.var_218c76bb91c75016 == 999 )
            {
                continue;
            }
            
            if ( livingworldstruct.encounterstruct.var_218c76bb91c75016 > livingworldstruct.var_b409a727ea4063cc )
            {
                continue;
            }
        }
        else if ( round_number <= var_72f61e6858e1a01b || var_72f61e6858e1a01b == 0 )
        {
            continue;
        }
        
        b_anim_death = !livingworldstruct.var_4e0eb39dc8466ea7;
        
        foreach ( ent in lw_ents )
        {
            if ( !isalive( ent ) )
            {
                continue;
            }
            
            livingworldstruct thread cleanup_no_player_facing( ent, b_anim_death );
        }
        
        livingworldstruct.var_4321bdc43deb678f = 1;
    }
}

// Namespace zm_livingworld
// Params 2, eflags: 0x4
// Checksum 0x56d6fb06, Offset: 0x4e8c
// Size: 0x6f
function private cleanup_no_player_facing( ent, b_anim_death )
{
    level endon( #"game_ended" );
    self endon( #"cancel_encounter" );
    ent endon( #"death" );
    zm_utility::function_157b74f7b9e1ef04( ent.origin );
    
    if ( ent livingworld_is_zombie() )
    {
        function_7668bbd3077aa119( ent, undefined, b_anim_death );
        return;
    }
    
    function_7668bbd3077aa119( ent );
}

// Namespace zm_livingworld
// Params 2, eflags: 0x4
// Checksum 0xfd6f62e1, Offset: 0x4f03
// Size: 0x2cc
function private function_b488eb0feb03048c( sparams, var_d8114b74d05d7be0 )
{
    var_f6aa8f8da9bb7913 = arraycombine( level._livingworld_info.spawned_ambient, level._livingworld_info.spawned_ai_vignette, level._livingworld_info.spawned_ai_combat );
    
    foreach ( livingworldstruct in var_f6aa8f8da9bb7913 )
    {
        if ( !( isdefined( livingworldstruct ) && isdefined( level.var_a009ab14ee0d3223 ) ) )
        {
            continue;
        }
        
        if ( !isdefined( livingworldstruct.var_b409a727ea4063cc ) )
        {
            continue;
        }
        
        if ( livingworldstruct.var_4e0eb39dc8466ea7 )
        {
            lw_ents = livingworldstruct.var_b9dc955e2a0cb75f;
        }
        else
        {
            lw_ents = livingworldstruct.scene_ents[ "actors" ];
        }
        
        var_f7f4c360a2d395c1 = livingworldstruct.var_c0993ffe04a4ad27 || livingworldstruct.var_c2d5815a88c24edd || livingworldstruct.var_4e0eb39dc8466ea7;
        should_block_trigger = isdefined( livingworldstruct.action_func_vars.var_b93ffef3fae6de08 ) ? !livingworldstruct.action_func_vars.var_b93ffef3fae6de08 : !var_f7f4c360a2d395c1;
        
        foreach ( ent in lw_ents )
        {
            if ( !isalive( ent ) || !ent livingworld_is_zombie() )
            {
                continue;
            }
            
            if ( !should_block_trigger && livingworldstruct.isplaying )
            {
                if ( var_d8114b74d05d7be0 )
                {
                    level.var_a009ab14ee0d3223.var_939db9ccafac43a7[ level.var_a009ab14ee0d3223.var_939db9ccafac43a7.size ] = ent;
                }
                else
                {
                    level.var_a009ab14ee0d3223.var_939db9ccafac43a7 = arrayremove( level.var_a009ab14ee0d3223.var_939db9ccafac43a7, ent );
                }
                
                continue;
            }
            
            if ( should_block_trigger && !livingworldstruct.isplaying )
            {
                if ( var_d8114b74d05d7be0 )
                {
                    livingworldstruct utility::ent_flag_set( "block_trigger" );
                    continue;
                }
                
                livingworldstruct utility::ent_flag_clear( "block_trigger" );
            }
        }
    }
}

// Namespace zm_livingworld
// Params 4, eflags: 0x4
// Checksum 0x96be72c0, Offset: 0x51d7
// Size: 0xc7
function private function_7668bbd3077aa119( ent, source_pos, b_anim_death = 0, b_force_damage = 0 )
{
    if ( !isalive( ent ) || isalive( ent ) && ent.var_fd5c989cd241b6c4 && !b_force_damage )
    {
        return;
    }
    
    ent.var_b5c8ab3210a8543 = 1;
    
    if ( !b_anim_death )
    {
        ent val::set_allow_death( 1 );
        ent setcandamage( 1 );
    }
    else
    {
        ent val::set( "living_world", "allow_dismember", 0 );
    }
    
    if ( !isdefined( source_pos ) )
    {
        source_pos = ent.origin;
    }
    
    ent dodamage( ent.health, source_pos );
}

// Namespace zm_livingworld
// Params 1, eflags: 0x4
// Checksum 0xede07151, Offset: 0x52a6
// Size: 0x243
function private function_9bce79bcd64fcfb4( human )
{
    level endon( #"game_ended" );
    self endon( #"cancel_encounter" );
    human endon( #"death" );
    
    if ( !isalive( human ) || human.var_fd5c989cd241b6c4 )
    {
        return;
    }
    
    if ( self.var_4321bdc43deb678f && human.var_4321bdc43deb678f )
    {
        return;
    }
    
    human.var_4321bdc43deb678f = 1;
    self.var_4321bdc43deb678f = 1;
    human val::set( "living_world", "death", 0 );
    human val::set( "living_world", "damage", 0 );
    human val::set( "living_world", "damageshield", 1 );
    human val::set( "living_world", "show_healthbar", 0 );
    var_cd6d759b2c772946 = utility::function_dc226e1c2f06ea0b( hashcat( %"scenescriptbundle:", "t10_cin_zm_living_world_teleport_soldier" ) );
    human.animname = var_cd6d759b2c772946.objects[ 0 ].variant_object.name;
    scene_root = spawnstruct();
    scene_root.origin = human.origin;
    scene_root.angles = human.angles;
    shot_name = "action" + randomintrange( 1, 4 );
    scene_root thread scene::play( human, shot_name, "t10_cin_zm_living_world_teleport_soldier" );
    thread zm_livingworld_vo::function_fff44f2c6fb01ef3( human );
    human function_3e307dbfd237ea2f();
    playfx( level._effect[ "vfx_t10_levels_zm_quartz_human_teleport_out" ], human.origin );
    playsoundatpos( human.origin, "evt_zm_living_world_human_teleport_out" );
    scene_length = scene_root scene::function_b3c7b792a7a154fa( shot_name );
    wait scene_length - 0.5;
    human val::reset( "living_world", "death" );
    human val::reset( "living_world", "damage" );
    human val::reset( "living_world", "damageshield" );
    human.nocorpse = 1;
    human dialogue::stop_dialogue();
    waitframe();
    level function_7668bbd3077aa119( human );
}

// Namespace zm_livingworld
// Params 1, eflags: 0x4
// Checksum 0x5201f13f, Offset: 0x54f1
// Size: 0x33
function private function_140a69275d80d3c9( dmg_struct )
{
    if ( self.var_4321bdc43deb678f && !self.var_b5c8ab3210a8543 )
    {
        return 0;
    }
    
    return dmg_struct.idamage;
}

// Namespace zm_livingworld
// Params 2, eflags: 0x4
// Checksum 0xc2849bd8, Offset: 0x552d
// Size: 0x157
function private function_4dd1fa6ab0fc3543( sparams, livingworldstruct )
{
    if ( !isdefined( livingworldstruct.bait ) )
    {
        level function_aef9e0b80abf1246( 0, "on_round_start", &function_4dd1fa6ab0fc3543, livingworldstruct );
        return;
    }
    
    alive_ents = function_46f9072493651dc9( livingworldstruct.scene_ents[ "actors" ] );
    
    if ( alive_ents.size && !livingworldstruct.isplaying )
    {
        return;
    }
    
    level.var_6781718da4f78d1c waittill( #"round_cleared" );
    level function_aef9e0b80abf1246( 0, "on_round_start", &function_4dd1fa6ab0fc3543, livingworldstruct );
    
    if ( !isdefined( livingworldstruct.bait ) )
    {
        return;
    }
    
    if ( !isarray( livingworldstruct.bait ) )
    {
        livingworldstruct.bait = [ livingworldstruct.bait ];
    }
    
    foreach ( bait in livingworldstruct.bait )
    {
        bait thread common_item::function_869d7676e359a627( bait );
    }
}

// Namespace zm_livingworld
// Params 1, eflags: 0x4
// Checksum 0x8d9a5b0, Offset: 0x568c
// Size: 0xc3
function private function_5acaf1d18c245a8f( livingworldstruct )
{
    foreach ( prop in livingworldstruct.scene_ents[ "props" ] )
    {
        if ( !isdefined( prop ) )
        {
            continue;
        }
        
        throttle::throttle_wait_in_queue( level.livingworldthrottle, prop );
        
        if ( isdefined( prop ) && !arraycontains( livingworldstruct.var_58e6c0d1fd24de83, prop ) )
        {
            prop delete();
        }
    }
}

// Namespace zm_livingworld
// Params 0, eflags: 0x4
// Checksum 0x907b95b6, Offset: 0x5757
// Size: 0x29b
function private function_d9800dd668183bf2()
{
    if ( !isdefined( self.info_structs[ "living_world_spawner" ] ) )
    {
        assertmsg( "<dev string:x10f>" + self.script_string + "<dev string:x128>" );
        return;
    }
    
    spawners = self.info_structs[ "living_world_spawner" ];
    
    foreach ( spawner in spawners )
    {
        if ( isdefined( spawner.script_noteworthy ) )
        {
            var_5544bd57802f6974 = spawner.script_noteworthy;
        }
        else if ( self.var_b9dc955e2a0cb75f.size < 1 )
        {
            var_5544bd57802f6974 = "zombie_base";
        }
        else if ( self.var_8cdfbe729ebfdd80.size < 1 )
        {
            var_5544bd57802f6974 = "soldier";
        }
        else
        {
            var_5544bd57802f6974 = utility::percent_chance( 50 ) ? "soldier" : "zombie_base";
        }
        
        if ( var_5544bd57802f6974 == "soldier" )
        {
            aitype = function_b3988325430ce242( var_5544bd57802f6974 );
            
            if ( !isdefined( aitype ) )
            {
                aitype = subclass_to_aitype_map::function_427ae77ce1056e01( var_5544bd57802f6974, [ "stam_use_short_soldier" ] );
            }
            
            team = "team_hundred_ninety_nine";
        }
        else
        {
            aitype = function_b3988325430ce242( var_5544bd57802f6974 );
            team = "team_two_hundred";
        }
        
        aitypespawned = namespace_9d8e359c3b1041e5::spawnnewaitype_sharedfunc( aitype, spawner.origin, spawner.angles, team );
        
        if ( !isdefined( aitypespawned ) )
        {
            continue;
        }
        
        if ( aitypespawned livingworld_is_zombie() )
        {
            self.var_b9dc955e2a0cb75f[ self.var_b9dc955e2a0cb75f.size ] = aitypespawned;
            aitypespawned.attractor = aitypespawned zombie_attractor_manager::function_7eb1aaa8bc7cc15( spawner, 1, undefined, 0, undefined, &function_be01a8df0c488bb5 );
        }
        else
        {
            self.var_8cdfbe729ebfdd80[ self.var_8cdfbe729ebfdd80.size ] = aitypespawned;
            aitypespawned ai_behavior::function_4a3c03bb49dd5d76( aitypespawned.origin, 1, 1 );
        }
        
        function_3e06225ab3320460( aitypespawned, 1 );
        aitypespawned.living_world_spawner = spawner;
        aitypespawned val::set( "living_world", "death", 0 );
        level._livingworld_info.var_90fad1f7b6fa1ff0[ level._livingworld_info.var_90fad1f7b6fa1ff0.size ] = aitypespawned;
    }
    
    self.state = "idle";
    thread function_d7e6facba03842e4();
    function_25a74db025a58ccb();
}

// Namespace zm_livingworld
// Params 2
// Checksum 0x53f55027, Offset: 0x59fa
// Size: 0x5b, Type: bool
function function_be01a8df0c488bb5( attractor, zombie )
{
    if ( zombie utility::function_9f2c41c1dcc8c94( "brainrot", "brainrot_on" ) || zombie.var_f2bc035a31b7e81b.isplaying )
    {
        return false;
    }
    
    if ( !isalive( zombie ) || !isdefined( attractor ) )
    {
        return false;
    }
    
    return true;
}

// Namespace zm_livingworld
// Params 1
// Checksum 0x3cdcdc3f, Offset: 0x5a5e
// Size: 0x305
function function_3166c4778fc2ccd4( ent )
{
    self notify( #"hash_919c3a450a953262" );
    self endon( #"hash_919c3a450a953262" );
    self endon( #"death" );
    ent endon( #"death" );
    self endon( #"cancel_encounter" );
    
    if ( self.var_47ea6ee6b1f5f5b7 )
    {
        return;
    }
    
    if ( isdefined( self.info_structs[ "living_world_bounds" ] ) )
    {
        radius_zone = self.info_structs[ "living_world_bounds" ][ 0 ];
    }
    
    var_f3a3eae9ab73b625 = isdefined( radius_zone ) ? radius_zone.radius : 500;
    combat_origin = isdefined( radius_zone ) ? radius_zone.origin : ent.living_world_spawner.origin;
    originalpos = ent.origin;
    var_5f58682c05ea50b2 = self.action_func_vars.var_1c10b8fee43e668 ?? 50;
    ai_behavior::function_95ada18faf94770a( ent, combat_origin, var_f3a3eae9ab73b625, var_5f58682c05ea50b2 );
    
    while ( isalive( ent ) && isagent( ent ) && !ent.var_fd5c989cd241b6c4 )
    {
        var_4b4ad1164fe485fb = 1;
        
        if ( self.action_func_vars.var_c091d20360c631b2 )
        {
            if ( isplayer( ent.enemy ) )
            {
                playerposzone = ent.enemy zone_manager::get_current_zone();
                
                if ( playerposzone === self.zone )
                {
                    var_4b4ad1164fe485fb = ent cansee( ent.enemy );
                    radiusvariance = 50;
                    goalloc = ent.enemy.origin;
                }
            }
        }
        
        if ( var_4b4ad1164fe485fb )
        {
            if ( isdefined( ent.var_43d29453d7dc425e ) && isdefined( ent.var_cbf572a330b6e481 ) )
            {
                move_time_elapsed = utility::function_6f5d2e1f1ff70482( gettime() - ent.var_43d29453d7dc425e );
                
                if ( move_time_elapsed < ent.var_cbf572a330b6e481 )
                {
                    waitframe();
                    continue;
                }
            }
            
            radiusvariance = var_5f58682c05ea50b2;
            goalloc = ent.origin;
        }
        
        random_x = randomfloatrange( radiusvariance * -1, radiusvariance );
        random_y = randomfloatrange( radiusvariance * -1, radiusvariance );
        goalloc = ( goalloc[ 0 ] + random_x, goalloc[ 1 ] + random_y, goalloc[ 2 ] );
        goalpos = ent getclosestreachablepointonnavmesh( goalloc, 0 );
        goalposzone = zone_manager::function_90e5c3e2272b0130( goalpos );
        
        if ( isdefined( goalpos ) )
        {
            height_difference = ent.origin[ 2 ] - goalpos[ 2 ];
            
            if ( goalposzone === self.zone && height_difference < 100 || height_difference < -100 )
            {
                function_5279363c8ac94d04( ent, goalpos );
                waitframe();
                continue;
            }
        }
        
        function_5279363c8ac94d04( ent, originalpos );
    }
}

// Namespace zm_livingworld
// Params 2, eflags: 0x4
// Checksum 0x1beaa8a, Offset: 0x5d6b
// Size: 0x62
function private function_5279363c8ac94d04( ent, goalpos )
{
    ent ai_behavior::_setgoalpos( goalpos, 8 );
    ent thread ai_behavior::function_7d1c597e7c5c5b7b( ent );
    ent utility::waittill_any( "goal", "refreshGoalPos" );
    ent.var_43d29453d7dc425e = gettime();
    ent.var_cbf572a330b6e481 = randomfloatrange( 7, 10 );
}

// Namespace zm_livingworld
// Params 0, eflags: 0x4
// Checksum 0x8facaec8, Offset: 0x5dd5
// Size: 0x260
function private function_2e154822ca458fa()
{
    level endon( #"game_ended" );
    self endon( #"cancel_encounter" );
    
    if ( !self.var_47ea6ee6b1f5f5b7 )
    {
        self.isplaying = 1;
        
        foreach ( enemyspawned in self.var_b9dc955e2a0cb75f )
        {
            if ( !isalive( enemyspawned ) )
            {
                continue;
            }
            
            if ( isdefined( enemyspawned.attractor ) )
            {
                zombie_attractor_manager::remove_attractor( enemyspawned.attractor );
            }
            
            var_8cdfbe729ebfdd80 = function_46f9072493651dc9( self.var_8cdfbe729ebfdd80 );
            
            if ( var_8cdfbe729ebfdd80.size < 1 )
            {
                continue;
            }
            
            enemyspawned.favoriteenemy = utility::array_random( var_8cdfbe729ebfdd80 );
            function_3e06225ab3320460( enemyspawned, 0 );
            thread function_8ad951a9ce2ac4e5( enemyspawned );
            enemyspawned val::reset( "living_world", "death" );
        }
        
        foreach ( enemyspawned in self.var_8cdfbe729ebfdd80 )
        {
            if ( !isalive( enemyspawned ) )
            {
                continue;
            }
            
            var_b9dc955e2a0cb75f = function_46f9072493651dc9( self.var_b9dc955e2a0cb75f );
            
            if ( var_b9dc955e2a0cb75f.size < 1 )
            {
                continue;
            }
            
            enemyspawned.favoriteenemy = utility::array_random( var_b9dc955e2a0cb75f );
            enemyspawned aieventlistenerevent( "combat", enemyspawned.favoriteenemy, enemyspawned.favoriteenemy.origin );
            enemyspawned.favoriteenemy = enemyspawned.favoriteenemy;
            enemyspawned getenemyinfo( enemyspawned.favoriteenemy );
            function_3e06225ab3320460( enemyspawned, 0 );
            thread function_8ad951a9ce2ac4e5( enemyspawned );
            enemyspawned val::reset( "living_world", "death" );
        }
        
        self.state = "action";
    }
}

// Namespace zm_livingworld
// Params 0, eflags: 0x4
// Checksum 0xea5ce090, Offset: 0x603d
// Size: 0x4db
function private function_c69e46798f3921ab()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    self endon( #"cancel_encounter" );
    self endon( #"hash_75df6a939e8d6845" );
    self endon( #"hash_bfade9077f240b69" );
    level utility::flag_wait( "loading_screen_over" );
    self.var_47ea6ee6b1f5f5b7 = 0;
    self.wait_array = [];
    
    if ( isdefined( self.script_flag_wait ) )
    {
        self.wait_array[ self.wait_array.size ] = "flag_wait";
        utility::ent_flag_clear( "flag_wait" );
        childthread livingworld_flag_wait();
    }
    
    if ( isdefined( self.info_structs[ "living_world_transition_check" ] ) )
    {
        var_5ac0ba61d4941fc0 = self.info_structs[ "living_world_transition_check" ][ 0 ];
        var_4b7c2ef354cb96fd = var_5ac0ba61d4941fc0.target;
        
        if ( isdefined( var_4b7c2ef354cb96fd ) )
        {
            var_7e0ffb33f6127004 = getentarray( var_4b7c2ef354cb96fd, #targetname );
            var_3e319173f7071f57 = getnoentvolumearray( var_4b7c2ef354cb96fd, #targetname );
            var_56d0bd7291dd5c02 = utility::getstructarray( var_4b7c2ef354cb96fd, "targetname" );
        }
        
        var_642518994e7f310d = arraycombine( var_7e0ffb33f6127004, var_3e319173f7071f57, var_56d0bd7291dd5c02 );
        
        for ( i = 0; i < var_642518994e7f310d.size ; i++ )
        {
            var_af6ad501c4923d18 = var_642518994e7f310d[ i ];
            
            if ( !isdefined( var_af6ad501c4923d18 ) )
            {
                continue;
            }
            
            var_af6ad501c4923d18.var_d17a0a89a96dbdb8 = arraycontains( var_3e319173f7071f57, var_af6ad501c4923d18 );
            info_string = var_af6ad501c4923d18.var_d17a0a89a96dbdb8 ? var_af6ad501c4923d18.struct.script_string : var_af6ad501c4923d18.script_string;
            
            if ( info_string === "living_world_doorbuy" )
            {
                self.wait_array[ self.wait_array.size ] = "STR_ENT_DOOR_WAIT" + i;
                utility::ent_flag_clear( "STR_ENT_DOOR_WAIT" + i );
                childthread livingworld_door_wait( var_af6ad501c4923d18, i );
                continue;
            }
            
            if ( info_string === "living_world_trigger" )
            {
                if ( !var_af6ad501c4923d18.var_d17a0a89a96dbdb8 )
                {
                    var_af6ad501c4923d18 triggerenable();
                    
                    /#
                        botdebugdrawtrigger( 1, var_af6ad501c4923d18, ( 0, 0, 0 ), 0 );
                    #/
                }
                
                self.wait_array[ self.wait_array.size ] = "trigger_wait" + i;
                utility::ent_flag_clear( "trigger_wait" + i );
                childthread livingworld_trigger_wait( var_af6ad501c4923d18, i );
            }
        }
        
        if ( isdefined( var_5ac0ba61d4941fc0.radius ) )
        {
            range_struct = var_5ac0ba61d4941fc0;
        }
    }
    
    if ( isdefined( self.radius ) || isdefined( var_5ac0ba61d4941fc0.radius ) )
    {
        self.wait_array[ self.wait_array.size ] = "range_wait";
        utility::ent_flag_clear( "range_wait" );
        range_struct = self.radius > 0 ? self : range_struct;
        childthread livingworld_range_wait( range_struct );
    }
    
    a_ents = function_548a067eccee7343();
    
    foreach ( ent in a_ents )
    {
        if ( !isalive( ent ) )
        {
            continue;
        }
        
        template_name = self.script_scenescriptbundle ?? self.encounterstruct.stringid;
        ent function_aef9e0b80abf1246( 1, "on_agent_ai_damaged", &function_c972dc55e65eb465, self, template_name );
    }
    
    if ( isdefined( self.custom_living_world_transition_check ) )
    {
        self [[ self.custom_living_world_transition_check ]]();
    }
    
    is_alone_trigger = self.var_990a994e4c7389a ? utility::percent_chance( self.var_990a994e4c7389a ) : 0;
    var_2908974373e32d31 = self.var_727a0748d208ad92 ? randomintrange( 1, 2 ) : 0;
    var_11e2da0b973b3967 = 0;
    
    while ( true )
    {
        if ( self.script_parameters == "or" )
        {
            utility::ent_flag_wait_any_array( self.wait_array );
        }
        else
        {
            utility::ent_flag_wait_all_array( self.wait_array );
        }
        
        if ( utility::ent_flag( "block_trigger" ) )
        {
            waitframe();
            continue;
        }
        
        is_fakeout_surprise = self.var_727a0748d208ad92 ? utility::percent_chance( self.var_727a0748d208ad92 ) : 0;
        
        if ( is_fakeout_surprise && isplayer( self.triggeredent ) && var_11e2da0b973b3967 < var_2908974373e32d31 )
        {
            var_11e2da0b973b3967++;
            wait 2;
            continue;
        }
        
        if ( is_alone_trigger && !function_c6ba028bb9abe15b() )
        {
            waitframe();
            continue;
        }
        
        break;
    }
}

// Namespace zm_livingworld
// Params 0, eflags: 0x4
// Checksum 0xe0be0457, Offset: 0x6520
// Size: 0x106, Type: bool
function private function_c6ba028bb9abe15b()
{
    if ( !isplayer( self.triggeredent ) )
    {
        return true;
    }
    
    var_53f7dbeeb1242974 = 0;
    ai_nearby = getaiarrayinradius( self.triggeredent.origin, 350 );
    
    foreach ( ai in ai_nearby )
    {
        if ( ai.team != zm_utility::get_zombie_team() || ai utility::function_9f2c41c1dcc8c94( "brainrot", "brainrot_on" ) )
        {
            continue;
        }
        
        if ( ai namespace_b76ff2659823e89d::is_crawling() || !zm_utility::is_active_zombie( ai ) )
        {
            continue;
        }
        
        var_53f7dbeeb1242974++;
        
        if ( var_53f7dbeeb1242974 > 2 )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace zm_livingworld
// Params 0, eflags: 0x4
// Checksum 0x61cd60af, Offset: 0x662f
// Size: 0x8b
function private livingworld_flag_wait()
{
    if ( isdefined( self.script_flag_wait ) )
    {
        self.var_c898aefa8ae0a6d1 = strtok( self.script_flag_wait, "," );
        
        if ( arraycontains( self.var_c898aefa8ae0a6d1, "wait_all" ) )
        {
            self.var_c898aefa8ae0a6d1 = arrayremove( self.var_c898aefa8ae0a6d1, "wait_all" );
            level utility::flag_wait_all_array( self.var_c898aefa8ae0a6d1 );
        }
        else
        {
            level utility::flag_wait_any_array( self.var_c898aefa8ae0a6d1 );
        }
    }
    
    utility::ent_flag_set( "flag_wait" );
}

// Namespace zm_livingworld
// Params 2, eflags: 0x4
// Checksum 0x682c281a, Offset: 0x66c2
// Size: 0x25a
function private livingworld_trigger_wait( trigger, num_trigger_wait )
{
    if ( isdefined( trigger.script_flag_wait ) )
    {
        level utility::flag_wait( trigger.script_flag_wait );
    }
    else if ( trigger.var_d17a0a89a96dbdb8 && isdefined( trigger.struct.script_flag_wait ) )
    {
        level utility::flag_wait( trigger.struct.script_flag_wait );
    }
    
    for ( var_ba2e88aca366569b = 1; !self.isplaying ; var_ba2e88aca366569b = 1 )
    {
        if ( var_ba2e88aca366569b )
        {
            utility::ent_flag_clear( "trigger_wait" + num_trigger_wait );
            self.triggeredent = undefined;
            
            if ( isdefined( trigger.script_flag_set ) )
            {
                level utility::flag_clear( trigger.script_flag_set );
            }
            else if ( trigger.var_d17a0a89a96dbdb8 && isdefined( trigger.struct.script_flag_set ) )
            {
                level utility::flag_clear( trigger.struct.script_flag_set );
            }
            
            trigger waittill( #"trigger", triggeredent );
        }
        
        if ( !isplayer( triggeredent ) && !isplayer( triggeredent.driver ) )
        {
            var_ba2e88aca366569b = 1;
            waitframe();
            continue;
        }
        
        function_a292e0669dfbdbd0( triggeredent.origin );
        utility::ent_flag_set( "trigger_wait" + num_trigger_wait );
        self.triggeredent = triggeredent;
        
        if ( isdefined( trigger.script_flag_set ) )
        {
            level utility::flag_set( trigger.script_flag_set );
        }
        else if ( trigger.var_d17a0a89a96dbdb8 && isdefined( trigger.struct.script_flag_set ) )
        {
            level utility::flag_set( trigger.struct.script_flag_set );
        }
        
        results = trigger utility::waittill_any_return_params_or_timeout( 2, "trigger" );
        
        if ( results[ "message" ] == "trigger" )
        {
            var_ba2e88aca366569b = 0;
            triggeredent = results[ 0 ];
            self.triggeredent = triggeredent;
            continue;
        }
        
        if ( results[ "message" ] == "timeout" && !self.isplaying )
        {
        }
    }
}

// Namespace zm_livingworld
// Params 2, eflags: 0x4
// Checksum 0xeb83c664, Offset: 0x6924
// Size: 0x80
function private livingworld_door_wait( door, num_door_wait )
{
    while ( true )
    {
        level waittill( #"door_opened", result );
        
        if ( result.targetname == door.targetname )
        {
            self.triggeredent = result.s_doorbuy.player_paid;
            break;
        }
    }
    
    utility::ent_flag_set( "door_wait" + num_door_wait );
}

// Namespace zm_livingworld
// Params 1, eflags: 0x4
// Checksum 0xe0a86b28, Offset: 0x69ac
// Size: 0x1cf
function private livingworld_range_wait( ent )
{
    rangestart = ent.radius;
    assert( isdefined( rangestart ), "<dev string:x268>" );
    var_8a129ef1e3c8fc67 = isdefined( self.script_targetoffset_z ) ? ent.origin + ( 0, 0, int( self.script_targetoffset_z ) ) : ent.origin;
    trigger_height = isdefined( self.height ) ? int( self.height ) : rangestart;
    
    if ( !isdefined( self.trigger ) )
    {
        self.trigger = spawn( "noent_volume_trigger_radius", var_8a129ef1e3c8fc67, 0, rangestart, trigger_height );
    }
    
    for ( var_ba2e88aca366569b = 1; !self.isplaying ; var_ba2e88aca366569b = 1 )
    {
        if ( var_ba2e88aca366569b )
        {
            utility::ent_flag_clear( "range_wait" );
            self.triggeredent = undefined;
            self.trigger waittill( #"trigger", triggeredent );
        }
        
        if ( !isplayer( triggeredent ) && !isplayer( triggeredent.driver ) )
        {
            var_ba2e88aca366569b = 1;
            waitframe();
            continue;
        }
        
        function_a292e0669dfbdbd0( triggeredent.origin );
        self.triggeredent = triggeredent;
        utility::ent_flag_set( "range_wait" );
        results = self.trigger utility::waittill_any_return_params_or_timeout( 2, "trigger" );
        
        if ( results[ "message" ] == "trigger" )
        {
            var_ba2e88aca366569b = 0;
            triggeredent = results[ 0 ];
            self.triggeredent = triggeredent;
            waitframe();
            continue;
        }
        
        if ( results[ "message" ] == "timeout" && !self.isplaying )
        {
        }
    }
}

// Namespace zm_livingworld
// Params 2
// Checksum 0x1be40029, Offset: 0x6b83
// Size: 0x1cb
function function_c972dc55e65eb465( sparams, livingworldstruct )
{
    if ( !function_1d0b3d1864dce638( livingworldstruct ) )
    {
        return;
    }
    
    if ( !isplayer( sparams.eattacker ) || isdefined( sparams.eattacker.driver ) && !isplayer( sparams.eattacker.driver ) )
    {
        return;
    }
    
    function_99602bdbb9406b23( livingworldstruct );
    
    if ( livingworldstruct.isplaying || utility::ent_flag( "ent_scene_death_anim_playing" ) )
    {
        return;
    }
    
    if ( livingworldstruct utility::ent_flag( "block_trigger" ) || !livingworldstruct.zone.is_enabled )
    {
        if ( isplayer( sparams.eattacker ) )
        {
            events::function_92b70ecfc2f8e086( self, sparams.eattacker, sparams.einflictor, sparams.smeansofdeath, sparams.objweapon, sparams.vpoint, undefined, self.kiastring );
            zm_damage::update_kills( sparams.eattacker, sparams.einflictor, sparams.objweapon, sparams.smeansofdeath );
            
            if ( isai( self ) )
            {
                events::zm_event_on_ai_killed( sparams );
                val::set( "living_world", "allow_give_point", 0 );
            }
        }
        
        function_7668bbd3077aa119( self, undefined, 1 );
        return;
    }
    
    if ( isdefined( sparams.eattacker ) && isdefined( sparams.eattacker.origin ) )
    {
        livingworldstruct function_a292e0669dfbdbd0( sparams.eattacker.origin );
    }
    
    function_8eee74786bedf399( livingworldstruct );
}

// Namespace zm_livingworld
// Params 1, eflags: 0x4
// Checksum 0xb66cd625, Offset: 0x6d56
// Size: 0xd2
function private function_99602bdbb9406b23( livingworldstruct )
{
    a_ents = function_548a067eccee7343();
    
    foreach ( ent in a_ents )
    {
        if ( !isalive( ent ) )
        {
            continue;
        }
        
        template_name = self.script_scenescriptbundle ?? self.encounterstruct.stringid;
        ent function_aef9e0b80abf1246( 0, "on_agent_ai_damaged", &function_c972dc55e65eb465, livingworldstruct, template_name );
    }
}

// Namespace zm_livingworld
// Params 1, eflags: 0x4
// Checksum 0x9abfa084, Offset: 0x6e30
// Size: 0x110
function private function_a292e0669dfbdbd0( triggeredlocation )
{
    vec_to_target = vectornormalize( triggeredlocation - self.origin );
    ang_to_right = anglestoright( self.angles );
    var_e94c5e9e0eedad34 = anglestoforward( self.angles );
    dotproduct = vectordot( vec_to_target, ang_to_right );
    right_dir = vectornormalize( ang_to_right );
    fwd_dir = vectornormalize( var_e94c5e9e0eedad34 );
    ang_perc = int( self.script_angle_max ?? 33 ) / 100;
    
    if ( dotproduct > ang_perc )
    {
        self.dir = "right";
        return;
    }
    
    if ( dotproduct < ang_perc * -1 )
    {
        self.dir = "left";
        return;
    }
    
    fwd_dotproduct = vectordot( vec_to_target, var_e94c5e9e0eedad34 );
    
    if ( fwd_dotproduct >= 0 )
    {
        self.dir = "forward";
        return;
    }
    
    self.dir = "behind";
}

// Namespace zm_livingworld
// Params 0
// Checksum 0x44555ad8, Offset: 0x6f48
// Size: 0x20c
function function_2035bfe862574dc()
{
    self endon( #"cancel_encounter" );
    
    if ( isdefined( self.encounterstruct ) )
    {
        self notify( #"hash_e9b9d2fd50e6f404" );
        successful = function_bfff922493583b30( "looping_idle", 1 );
        
        if ( !successful )
        {
            self.state = "First Frame Init";
        }
    }
    
    foreach ( prop in self.scene_ents[ "props" ] )
    {
        prop.var_2fc3a5fb762afb6e = 1;
        level notify( #"highvis_reload_outline", undefined, [ prop ] );
        
        if ( self.scene_ents[ "actors" ].size <= 0 && self.scene_ents[ "props" ].size )
        {
            thread function_3343a0e5814d7722( prop );
        }
    }
    
    foreach ( ent in self.scene_ents[ "actors" ] )
    {
        if ( !isalive( ent ) )
        {
            continue;
        }
        
        function_3e06225ab3320460( ent, 1 );
        
        if ( self.scene_ents[ "props" ].size > 0 )
        {
            template_name = self.script_scenescriptbundle ?? self.encounterstruct.stringid;
            ent function_aef9e0b80abf1246( 1, "killed_body_cloned", &function_a60d472038498618, self, template_name );
        }
    }
    
    thread function_d7e6facba03842e4();
    function_25a74db025a58ccb();
}

// Namespace zm_livingworld
// Params 0
// Checksum 0x436cd09, Offset: 0x715c
// Size: 0x229
function function_168d64aabc6b69e8()
{
    self endon( #"cancel_encounter" );
    self.isplaying = 1;
    self notify( #"hash_43c323f558763d65" );
    
    if ( self.var_3cd2eba2b7ff6812 )
    {
        self.scene_root thread scene::cleanup();
    }
    else
    {
        function_bfff922493583b30( "idle" );
        function_52a9cbf27644e298();
    }
    
    foreach ( prop in self.scene_ents[ "props" ] )
    {
        if ( !isdefined( prop ) || prop utility::ent_flag( "ent_scene_death_anim_playing" ) || prop.sceneobjectdata.var_bf1c906895c88a1b )
        {
            continue;
        }
        
        prop.var_2fc3a5fb762afb6e = 0;
        level notify( #"highvis_reload_outline", undefined, [ prop ] );
    }
    
    foreach ( ent in self.scene_ents[ "actors" ] )
    {
        if ( !isalive( ent ) )
        {
            continue;
        }
        
        function_3e06225ab3320460( ent, 0 );
        
        if ( self.var_c0993ffe04a4ad27 || self.var_3cd2eba2b7ff6812 || self.var_c2d5815a88c24edd )
        {
            thread function_8ad951a9ce2ac4e5( ent );
            thread function_24d9d7857807eb51( ent );
            continue;
        }
        
        if ( function_7c9493cb0c008bdb( "attack" ) )
        {
            thread function_db74a75b90dcd62a( ent );
        }
        
        if ( function_7c9493cb0c008bdb( "return" ) )
        {
            level function_aef9e0b80abf1246( 1, "zone_changed", &function_4963add1a7d22ab6, self );
        }
    }
    
    function_25a74db025a58ccb();
}

// Namespace zm_livingworld
// Params 0, eflags: 0x4
// Checksum 0xa3c5649c, Offset: 0x738d
// Size: 0x42
function private function_52a9cbf27644e298()
{
    function_9c9d6559ee4ac8aa();
    
    if ( function_7c9493cb0c008bdb( "end" ) )
    {
        function_bfff922493583b30( "action" );
        function_bfff922493583b30( "end", 1 );
        return;
    }
    
    function_bfff922493583b30( "action", 1 );
}

// Namespace zm_livingworld
// Params 1, eflags: 0x4
// Checksum 0x5ca951dd, Offset: 0x73d7
// Size: 0x110
function private function_9c9d6559ee4ac8aa( b_force_breakout )
{
    if ( self.var_c0993ffe04a4ad27 || !function_7c9493cb0c008bdb( "breakout" ) )
    {
        return;
    }
    
    if ( utility::ent_flag( "block_trigger" ) )
    {
        return;
    }
    
    self.var_c0993ffe04a4ad27 = b_force_breakout || isdefined( self.script_chance ) && utility::percent_chance( float( self.script_chance ) );
    
    foreach ( ent in self.scene_ents[ "actors" ] )
    {
        if ( isalive( ent ) && self.var_c0993ffe04a4ad27 )
        {
            function_3e06225ab3320460( ent, 0 );
            thread function_8ad951a9ce2ac4e5( ent );
            thread function_24d9d7857807eb51( ent );
        }
    }
}

// Namespace zm_livingworld
// Params 1, eflags: 0x4
// Checksum 0xbdf0e248, Offset: 0x74ef
// Size: 0x190
function private function_db74a75b90dcd62a( ent )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    ent endon( #"death" );
    ent endon( #"ent_scene_death_anim_playing" );
    self endon( #"any_ent_scene_died" );
    self endon( #"cancel_encounter" );
    trigger_spawn_org = ent gettagorigin( "j_spine4", 1 );
    
    if ( !isdefined( trigger_spawn_org ) )
    {
        trigger_spawn_org = ent.origin;
    }
    
    if ( !isdefined( self.attacktrigger ) )
    {
        self.attacktrigger = spawn( "noent_volume_trigger_radius", trigger_spawn_org, 512, 75, 75 );
    }
    
    attack_queued = 0;
    
    while ( isalive( ent ) && !self.var_c0993ffe04a4ad27 && !ent.var_fd5c989cd241b6c4 && !self.var_47ea6ee6b1f5f5b7 )
    {
        self.attacktrigger waittill( #"trigger", triggeredent );
        
        if ( isalive( ent ) && !self.var_c0993ffe04a4ad27 && isplayer( triggeredent ) && !ent.var_fd5c989cd241b6c4 )
        {
            ent waittill( #"end_of_anim" );
            self notify( #"hash_4ab2cb41d12d3c73" );
            thread function_71762b8930a41b18( ent );
            function_bfff922493583b30( "attack" );
            function_52a9cbf27644e298();
            function_25a74db025a58ccb();
            var_35fd1bc7ee12f62b = randomfloatrange( 0.5, 2 );
            wait var_35fd1bc7ee12f62b;
        }
    }
}

// Namespace zm_livingworld
// Params 1
// Checksum 0x8059e515, Offset: 0x7687
// Size: 0xf1
function function_71762b8930a41b18( ent )
{
    self notify( #"hash_7d7edfcc4ff8eee5" );
    self endon( #"hash_7d7edfcc4ff8eee5" );
    level endon( #"game_ended" );
    self endon( #"death" );
    self endon( #"cancel_encounter" );
    self endon( #"any_ent_scene_died" );
    ent endon( #"death" );
    ent endon( #"ent_scene_death_anim_playing" );
    melee_info = function_c916b36dcaf4077a( ent );
    
    if ( isdefined( melee_info ) )
    {
        melee_info.target utility::knockback_flat( melee_info.var_efc8748fdbf5d5f8, 150 );
    }
    
    ent waittill( #"damage_notify" );
    melee_info = function_c916b36dcaf4077a( ent );
    
    if ( isdefined( melee_info ) )
    {
        ent.var_3eaa5cd097e43179 = melee_info.target;
        ent zombie_melee::function_d4a397a6f6cddafa( undefined, melee_info.var_efc8748fdbf5d5f8 );
    }
}

// Namespace zm_livingworld
// Params 1, eflags: 0x4
// Checksum 0x237c3969, Offset: 0x7780
// Size: 0xc7
function private function_c916b36dcaf4077a( ent )
{
    melee_info = undefined;
    a_players_to_melee = getplayersinradius( self.attacktrigger.origin, 75, 75, 1 );
    
    if ( isalive( ent ) && a_players_to_melee.size > 0 )
    {
        player_to_melee = function_47c86977a18df38b( a_players_to_melee, self.attacktrigger.origin );
        var_d2f53153fcdbe2dc = player_to_melee getcentroid();
        var_58802932708e4e8b = ent gettagorigin( "j_head" );
        var_efc8748fdbf5d5f8 = vectornormalize( var_d2f53153fcdbe2dc - var_58802932708e4e8b );
        melee_info = { #var_efc8748fdbf5d5f8:var_efc8748fdbf5d5f8, #target:player_to_melee };
    }
    
    return melee_info;
}

// Namespace zm_livingworld
// Params 2, eflags: 0x4
// Checksum 0x64b5b45e, Offset: 0x7850
// Size: 0x1f
function private function_4963add1a7d22ab6( params, livingworldstruct )
{
    thread function_67cadcce52883e08( params, livingworldstruct );
}

// Namespace zm_livingworld
// Params 2, eflags: 0x4
// Checksum 0xee5feb95, Offset: 0x7877
// Size: 0x18d
function private function_67cadcce52883e08( params, livingworldstruct )
{
    level endon( #"game_ended" );
    livingworldstruct endon( #"death" );
    livingworldstruct endon( #"cancel_encounter" );
    
    if ( livingworldstruct.scene_return || livingworldstruct.var_47ea6ee6b1f5f5b7 )
    {
        return;
    }
    
    existing_ents = livingworldstruct function_a7ba0b783fa73958();
    
    if ( existing_ents.size )
    {
        var_81a7163aba90bedd = zone_manager::get_zone_occupants( livingworldstruct.zone );
        
        if ( !isdefined( var_81a7163aba90bedd ) || var_81a7163aba90bedd.size == 0 )
        {
            livingworldstruct.scene_return = 1;
            
            foreach ( ent in self.scene_ents[ "actors" ] )
            {
                if ( isdefined( ent ) )
                {
                    livingworldstruct thread function_bfff922493583b30( "return" );
                }
            }
            
            livingworldstruct function_2035bfe862574dc();
            livingworldstruct function_c69e46798f3921ab();
            existing_ents = livingworldstruct function_a7ba0b783fa73958();
            
            if ( existing_ents.size )
            {
                livingworldstruct function_52a9cbf27644e298();
                livingworldstruct function_25a74db025a58ccb();
                livingworldstruct.scene_return = 0;
            }
        }
        
        return;
    }
    
    level function_aef9e0b80abf1246( 0, "zone_changed", &function_4963add1a7d22ab6, livingworldstruct );
}

// Namespace zm_livingworld
// Params 1, eflags: 0x4
// Checksum 0x9e4cf532, Offset: 0x7a0c
// Size: 0x505
function private function_3343a0e5814d7722( prop )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    self endon( #"cancel_encounter" );
    prop.var_f2bc035a31b7e81b = self;
    prop.health = 200;
    prop setcandamage( 1 );
    sparams = spawnstruct();
    sparams.entity = prop;
    sparams.entity.kiastring = #"zombie_kia";
    
    while ( prop.health > 1 )
    {
        prop setcandamage( 1 );
        results = utility::waittill_any_ents_return_params( prop, "damage", level, "powerup_nuke_pickup", prop, "death" );
        var_5e94b7b011663cfd = results[ "message" ] == "death";
        b_nuke = results[ "message" ] == "powerup_nuke_pickup";
        eattacker = var_5e94b7b011663cfd || b_nuke ? results[ 0 ] : results[ 1 ];
        
        if ( b_nuke )
        {
            var_405114090475aa1c = 0;
            
            for ( i = 0; i < level.players.size ; i++ )
            {
                player = level.players[ i ];
                
                if ( isdefined( player.origin ) && isdefined( player.angles ) && player zm_utility::is_player_facing( self.origin ) )
                {
                    var_405114090475aa1c = 1;
                }
            }
            
            if ( !self.zone.is_enabled && !var_405114090475aa1c )
            {
                continue;
            }
            
            if ( !self.isplaying && self.var_48a02b6726ecd796 && self.init_shot != "looping_idle" )
            {
                continue;
            }
            
            if ( prop.var_7ee152b43c7188e1 || prop.ignore_nuke_fx )
            {
                continue;
            }
        }
        
        if ( !isplayer( eattacker ) && !isplayer( eattacker.driver ) && !isplayer( eattacker.owner ) )
        {
            continue;
        }
        
        attacker = eattacker.owner ?? eattacker.driver ?? eattacker;
        sparams.eattacker = attacker;
        
        if ( !b_nuke && !var_5e94b7b011663cfd )
        {
            sparams.idamage = results[ 0 ];
            sparams.vdir = results[ 2 ];
            sparams.vpoint = results[ 3 ];
            sparams.smeansofdeath = results[ 4 ];
            sparams.objweapon = results[ 9 ];
            sparams.einflictor = results[ 13 ];
        }
        
        if ( !self.isplaying && !b_nuke && !var_5e94b7b011663cfd )
        {
            prop thread function_c972dc55e65eb465( sparams, self );
        }
        
        if ( isplayer( attacker ) && isalive( attacker ) )
        {
            if ( !isdefined( prop.a_n_player_damage ) )
            {
                prop.a_n_player_damage = [];
            }
            
            prop.a_n_player_damage = arraycombineunique( prop.a_n_player_damage, [ attacker ] );
        }
        
        isheadshot = 0;
        
        if ( prop tagexists( "j_head" ) && sparams.vpoint )
        {
            head_loc = prop gettagorigin( "j_head" );
            isheadshot = distancesquared( sparams.vpoint, head_loc ) < squared( 8 );
        }
        
        if ( b_nuke || sparams.objweapon == level.equipment.table[ "equip_molotov" ].objweapon || attacker utility::ent_flag( "powerup_insta_kill_active" ) || sparams.objweapon.classname == "rocketlauncher" || var_5e94b7b011663cfd )
        {
            prop.health = 0;
        }
        
        if ( !b_nuke && !var_5e94b7b011663cfd )
        {
            prop.health -= sparams.idamage;
            attacker thread damagefeedback::updatedamagefeedback( "standard", sparams.idamage >= prop.health, isheadshot );
            sparams.entity.kiastring = sparams.idamage >= prop.health && isheadshot ? #"zombie_kia_critical" : #"zombie_kia";
        }
    }
    
    self notify( #"hash_bfade9077f240b69" );
    successful = function_bfff922493583b30( "death", 1 );
    self.scene_root function_81a561e9fdd18c94( sparams, self );
}

// Namespace zm_livingworld
// Params 0, eflags: 0x4
// Checksum 0x4cc8e34d, Offset: 0x7f19
// Size: 0x106
function private function_c31ca6ba9ff01f20()
{
    livingworldstruct = self.var_f2bc035a31b7e81b;
    var_405114090475aa1c = 0;
    
    for ( i = 0; i < level.players.size ; i++ )
    {
        player = level.players[ i ];
        
        if ( isdefined( player.origin ) && isdefined( player.angles ) && player zm_utility::is_player_facing( self.origin ) )
        {
            var_405114090475aa1c = 1;
            break;
        }
    }
    
    if ( !livingworldstruct.zone.is_enabled && !var_405114090475aa1c )
    {
        return;
    }
    
    if ( !livingworldstruct.isplaying && self.var_48a02b6726ecd796 && livingworldstruct.init_shot != "looping_idle" )
    {
        return;
    }
    
    self.var_7ee152b43c7188e1 = 0;
    self.ignore_nuke_fx = 0;
    level function_7668bbd3077aa119( self, undefined, 1 );
}

// Namespace zm_livingworld
// Params 1, eflags: 0x4
// Checksum 0x9a3077c0, Offset: 0x8027
// Size: 0x9c
function private function_7c9493cb0c008bdb( var_224dcf25fb9b60e9 )
{
    if ( var_224dcf25fb9b60e9 == "return" || var_224dcf25fb9b60e9 == "attack" || var_224dcf25fb9b60e9 == "breakout" )
    {
        return ( self.shotnames[ var_224dcf25fb9b60e9 ].size > 0 );
    }
    
    normal_shots = arrayremove( self.shotnames[ var_224dcf25fb9b60e9 ], self.shotnames[ "breakout" ] );
    breakout_shots = self.shotnames[ "breakout" ];
    return self.var_c0993ffe04a4ad27 ? breakout_shots.size > 0 : normal_shots.size > 0;
}

// Namespace zm_livingworld
// Params 1, eflags: 0x4
// Checksum 0x9182ebd0, Offset: 0x80cc
// Size: 0x349
function private function_29337345ce38903e( var_224dcf25fb9b60e9 )
{
    if ( self.shotnames[ var_224dcf25fb9b60e9 ].size <= 0 )
    {
        return;
    }
    
    normal_shots = arrayremove( self.shotnames[ var_224dcf25fb9b60e9 ], self.shotnames[ "breakout" ] );
    breakout_shots = self.shotnames[ "breakout" ];
    var_5d373ce3d6540a3 = self.var_c0993ffe04a4ad27 ? breakout_shots : normal_shots;
    
    if ( isdefined( self.scenedata ) && !isdefined( self.current_set_num ) )
    {
        var_2417ea153f3aff58 = utility::function_f1933af772476229( self.scenedata.sceneplay );
        
        if ( isdefined( var_2417ea153f3aff58.currentshot ) && isdefined( self.scenedata.scenescriptbundle.shots ) )
        {
            current_shot_name = self.scenedata.scenescriptbundle.shots[ var_2417ea153f3aff58.currentshot ].variant_object.name;
            self.current_set_num = function_b1845c43b50d0f42( current_shot_name );
        }
    }
    
    if ( self.shotnames[ "directional" ].size > 0 )
    {
        var_9d8e6a8a57326e2a = 1;
    }
    
    forced_anims = isdefined( self.animation ) && self.animation.size ? strtok( self.animation, "," ) : [];
    excluded_anims = isdefined( self.script_exclude ) && self.script_exclude.size ? strtok( self.script_exclude, "," ) : [];
    
    if ( forced_anims.size && breakout_shots.size )
    {
        var_1fde63640430d02 = arrayintersection( forced_anims, breakout_shots );
        
        if ( var_1fde63640430d02.size )
        {
            function_9c9d6559ee4ac8aa( 1 );
        }
    }
    
    var_5d373ce3d6540a3 = arrayrandomize( var_5d373ce3d6540a3 );
    
    if ( isdefined( self.scene_root.init_shot ) && arraycontains( var_5d373ce3d6540a3, self.scene_root.init_shot ) )
    {
        var_5d373ce3d6540a3 = arrayremove( var_5d373ce3d6540a3, self.scene_root.init_shot );
        arrayinsert( var_5d373ce3d6540a3, self.scene_root.init_shot, 0 );
    }
    
    for ( i = 0; i < var_5d373ce3d6540a3.size ; i++ )
    {
        shot = var_5d373ce3d6540a3[ i ];
        
        if ( !issubstr( shot, var_224dcf25fb9b60e9 ) )
        {
            continue;
        }
        
        if ( isdefined( self.current_set_num ) && shot != var_224dcf25fb9b60e9 + "_" + self.current_set_num )
        {
            continue;
        }
        
        if ( var_9d8e6a8a57326e2a && isdefined( self.dir ) && !issubstr( shot, self.dir ) )
        {
            continue;
        }
        
        if ( forced_anims.size && !arraycontains( forced_anims, shot ) )
        {
            continue;
        }
        
        if ( excluded_anims.size && arraycontains( excluded_anims, shot ) )
        {
            continue;
        }
        
        var_d7102fd45869f2e1 = shot;
        break;
    }
    
    return var_d7102fd45869f2e1 ?? utility::array_random( normal_shots );
}

// Namespace zm_livingworld
// Params 1, eflags: 0x4
// Checksum 0xc8d88185, Offset: 0x841e
// Size: 0xa4
function private function_b1845c43b50d0f42( str )
{
    if ( !isdefined( str ) )
    {
        return;
    }
    
    set_num = undefined;
    
    if ( str.size > 1 && getsubstr( str, 0, 1 ) == "-" )
    {
        str = getsubstr( str, 1, str.size );
    }
    
    for ( var_9b09b44583feb12c = 0; var_9b09b44583feb12c < str.size ; var_9b09b44583feb12c++ )
    {
        _string = getsubstr( str, var_9b09b44583feb12c, var_9b09b44583feb12c + 1 );
        
        if ( utility::string_is_single_digit_integer( _string ) )
        {
            if ( !isdefined( set_num ) )
            {
                set_num = "";
            }
            
            set_num += _string;
            continue;
        }
        
        if ( isdefined( set_num ) )
        {
            break;
        }
    }
    
    return set_num;
}

// Namespace zm_livingworld
// Params 3, eflags: 0x4
// Checksum 0x381ba016, Offset: 0x84cb
// Size: 0x24d
function private function_bfff922493583b30( str_shot_name, b_thread_play = 0, force_shot_name )
{
    var_88bdd18c9b327904 = isdefined( str_shot_name ) && function_7c9493cb0c008bdb( str_shot_name ) || isdefined( force_shot_name );
    
    if ( var_88bdd18c9b327904 && !self.var_47ea6ee6b1f5f5b7 && !self.skip[ str_shot_name ] )
    {
        shotname = force_shot_name ?? function_29337345ce38903e( str_shot_name );
        self.state = shotname;
        
        foreach ( ent in self.var_58e6c0d1fd24de83 )
        {
            part = self.var_987da7ec49bd85eb ?? "living_world_scene";
            ent utility::function_32b24db3127bff40( part, shotname );
        }
        
        existing_ents = function_a7ba0b783fa73958();
        
        if ( existing_ents.size == 0 )
        {
            return 0;
        }
        
        foreach ( ent in existing_ents )
        {
            if ( ent.voice == #"sasfemale" )
            {
                ent setentitysoundcontext( "gender", "female" );
            }
        }
        
        function_1d44f32bbd313a67( "LivingWorld_PlayAnim", self.script_scenescriptbundle + " : " + shotname );
        
        if ( b_thread_play )
        {
            self.scene_root thread scene::play( existing_ents, shotname, self.script_scenescriptbundle );
        }
        else
        {
            shot_length = self.scene_root scene::function_b3c7b792a7a154fa( shotname );
            self.scene_root thread scene::play( existing_ents, shotname, self.script_scenescriptbundle );
            wait shot_length;
        }
        
        function_c3b7a0f5562679bc();
        return 1;
    }
    
    return 0;
}

// Namespace zm_livingworld
// Params 0
// Checksum 0xa159551f, Offset: 0x8720
// Size: 0xef
function function_a7ba0b783fa73958()
{
    function_c3b7a0f5562679bc();
    existingents = arraycombine( self.scene_ents[ "actors" ], self.scene_ents[ "props" ] );
    
    foreach ( ent in existingents )
    {
        if ( isai( ent ) && !isalive( ent ) || !isdefined( ent ) || ent utility::ent_flag( "ent_scene_death_anim_playing" ) || ent.sceneobjectdata.var_bf1c906895c88a1b )
        {
            existingents = arrayremove( existingents, ent );
        }
    }
    
    return existingents;
}

// Namespace zm_livingworld
// Params 2
// Checksum 0x7b685f7c, Offset: 0x8818
// Size: 0x464
function function_3e06225ab3320460( ent, var_b84028f2a0141008 )
{
    ent.is_living_world_ai = 1;
    ent.var_f2bc035a31b7e81b = self;
    ent.var_48a02b6726ecd796 = var_b84028f2a0141008;
    
    if ( var_b84028f2a0141008 )
    {
        template_name = self.script_scenescriptbundle ?? self.encounterstruct.stringid;
        
        if ( !ent callback::function_494399dbf14431f0( getxhash( template_name ) ) )
        {
            ent callback::function_99edd620ee45cd95( getxhash( template_name ) );
        }
        
        ent function_aef9e0b80abf1246( 1, #"on_ai_killed", &livingworld_on_ai_killed, self, template_name );
        
        if ( isdefined( self.script_scenescriptbundle ) )
        {
            ent function_aef9e0b80abf1246( 1, "killed_body_cloned", &function_39c6b614d4d298fa, self, template_name );
            
            if ( !isdefined( ent.var_4c7d7e0b37ebeecd ) )
            {
                ent.var_4c7d7e0b37ebeecd = createnavbadplacebyent( ent, undefined, ent.team );
            }
        }
        
        ent val::set( "living_world", "play_ambient_vo", 0 );
        ent val::set( "living_world", "allow_vo", 0 );
        ent.ignore_enemy_count = 1;
        ent utility::ent_flag_clear( "ent_scene_death_anim_playing" );
        function_2115cc9f415ec342( ent, 0 );
        ent disableaimassist();
        
        if ( !isdefined( ent.maxhealth ) )
        {
            ent ai::set_ai_max_health( ent.health );
        }
        
        if ( isdefined( self.encounterstruct.var_a54c927073815503 ) )
        {
            ent.health = int( ent.maxhealth * self.encounterstruct.var_a54c927073815503 );
        }
        
        if ( ent livingworld_is_zombie() )
        {
            ent.team = "team_two_hundred";
        }
        else
        {
            ent.primaryweapon = weapon_utility::function_66f7c63df61623d9( ent.primaryweapon );
            ent setcanusecover( 0 );
            ent allowedstances( "stand" );
            ent function_2ef9eb3349906d00( 1000 );
            ent.maxsightdistsqrd = squared( 1000 );
            ent.maxvisibledist = 1000;
            ent.maxfaceenemydist = 1000;
            ent.disablegrenaderesponse = 1;
            ent.grenadeammo = 0;
            ent.var_4d3dee2aa67fa6a0 = 0;
            ent.var_38a06ee92c60ee9e = 0;
            ent.dontevershoot = 1;
            ent.team = ent.force_team ?? "team_hundred_ninety_nine";
        }
        
        if ( isdefined( ent.sceneobjectdata.sceneobject ) )
        {
            ent.animname = ent.sceneobjectdata.sceneobject.variant_object.name;
        }
        
        if ( isdefined( self.encounterstruct.var_3101da2d233f5f78 ) && self.encounterstruct.var_3101da2d233f5f78 != "" )
        {
            ent.var_1e0c6c188b1cfd56 = self.encounterstruct.var_3101da2d233f5f78;
        }
    }
    else
    {
        if ( isdefined( self.action_func_vars.var_e06192d7cc86631 ) )
        {
            self thread [[ self.action_func_vars.var_e06192d7cc86631 ]]( ent );
        }
        
        if ( isdefined( ent.var_4c7d7e0b37ebeecd ) )
        {
            destroynavobstacle( ent.var_4c7d7e0b37ebeecd );
            ent.var_4c7d7e0b37ebeecd = undefined;
        }
        
        ent enableaimassist();
    }
    
    if ( self.init_shot != "looping_idle" )
    {
        ent.ignoreme = var_b84028f2a0141008;
    }
    
    ent.var_7ee152b43c7188e1 = var_b84028f2a0141008;
    ent.var_17e346ced9ac7924 = &function_c31ca6ba9ff01f20;
    ent.b_ignore_death_perception = var_b84028f2a0141008;
    ent.var_2fc3a5fb762afb6e = var_b84028f2a0141008;
    level notify( #"highvis_reload_outline", undefined, [ ent ] );
    ent val::set( "living_world", "ignoreme", var_b84028f2a0141008 );
    ent val::set( "living_world", "ignoreall", var_b84028f2a0141008 );
    ent val::set( "living_world", "show_healthbar", !var_b84028f2a0141008 );
    ent function_66dc8b6ae969f66d( var_b84028f2a0141008 );
}

// Namespace zm_livingworld
// Params 2, eflags: 0x4
// Checksum 0x241b9069, Offset: 0x8c84
// Size: 0x22b
function private function_2115cc9f415ec342( ent, var_b84028f2a0141008 )
{
    ent.noragdoll = !var_b84028f2a0141008 ? var_b84028f2a0141008 : undefined;
    ent.b_cleanup_no_respawn = !var_b84028f2a0141008;
    ent.var_825b17c932865df = !var_b84028f2a0141008;
    ent.var_15598d8e493afe88 = !var_b84028f2a0141008;
    ent.b_disable_annihilate = !var_b84028f2a0141008;
    ent.var_a13bed1ac47e1b2c = !var_b84028f2a0141008;
    ent.ignore_nuke_fx = !var_b84028f2a0141008;
    ent.var_17e346ced9ac7924 = &function_c31ca6ba9ff01f20;
    ent.var_75177cf6264a1cb2 = !var_b84028f2a0141008;
    ent.var_5927d2279779cec0 = var_b84028f2a0141008;
    
    if ( var_b84028f2a0141008 )
    {
        ent val::reset( "living_world", "ammomod_immune" );
    }
    else
    {
        ent val::set( "living_world", "ammomod_immune", !var_b84028f2a0141008 );
    }
    
    ent.var_70fbc1727d54c322 = !var_b84028f2a0141008;
    
    if ( var_b84028f2a0141008 )
    {
        ent val::reset( "living_world", "show_targetmarker" );
    }
    else
    {
        ent val::set( "living_world", "show_targetmarker", var_b84028f2a0141008 );
    }
    
    if ( !var_b84028f2a0141008 || !ent.b_force_ignore_cleanup )
    {
        if ( !var_b84028f2a0141008 )
        {
            ent val::set( "living_world", "ignore_cleanup", !var_b84028f2a0141008 );
        }
        else
        {
            ent val::reset( "living_world", "ignore_cleanup" );
        }
    }
    
    ent val::set( "living_world", "allow_secondary_attack_damage", var_b84028f2a0141008 );
    ent val::set( "living_world", "allow_brot", var_b84028f2a0141008 );
    ent val::set( "living_world", "play_ambient_vo", var_b84028f2a0141008 );
    ent val::set( "living_world", "allow_vo", var_b84028f2a0141008 );
    ent val::set( "living_world", "allow_combat_attractors", var_b84028f2a0141008 );
    ent val::set( "living_world", "allow_dismember", var_b84028f2a0141008 );
    
    if ( var_b84028f2a0141008 )
    {
        ent val::reset( "living_world", "collide_with_ai_allies" );
        ent function_7f8988ce63c1623d( 1 );
    }
    
    if ( var_b84028f2a0141008 )
    {
        ent clearbtgoal( 0 );
        return;
    }
    
    ent clearpath();
    ent setbtgoalstationary( 0 );
}

// Namespace zm_livingworld
// Params 1
// Checksum 0x6e37f2c9, Offset: 0x8eb7
// Size: 0x46
function livingworld_allow_dismember( ent )
{
    if ( !isdefined( ent ) || !ent.is_living_world_ai || ent.var_fd5c989cd241b6c4 )
    {
        return;
    }
    
    ent val::reset( "living_world", "allow_dismember" );
}

// Namespace zm_livingworld
// Params 1
// Checksum 0xdd18069a, Offset: 0x8f05
// Size: 0x388
function function_8ad951a9ce2ac4e5( ent )
{
    ent endon( #"death" );
    
    if ( ent.var_9686e1897a9ce028 || !isalive( ent ) || ent.var_fd5c989cd241b6c4 || ent.health < 1 || ent.maxhealth < 1 )
    {
        return;
    }
    
    if ( !self.var_4e0eb39dc8466ea7 )
    {
        ent utility::ent_flag_wait( "anim_ended" );
        
        if ( !isalive( ent ) || ent.var_fd5c989cd241b6c4 || ent.health < 1 || ent.maxhealth < 1 )
        {
            return;
        }
    }
    
    ent.var_9686e1897a9ce028 = 1;
    
    if ( !ent livingworld_is_zombie() )
    {
        thread function_3166c4778fc2ccd4( ent );
        
        if ( utility_common::isshotgun( ent.weapon ) )
        {
            ent.accuracy = randomfloatrange( 0.65, 0.85 );
        }
        else
        {
            ent.accuracy = randomfloatrange( 0.15, 0.5 );
        }
        
        ent.dontevershoot = 0;
    }
    
    thread function_67a0dafadded5989( ent, self.action_func_vars.custom_move_speed );
    function_2115cc9f415ec342( ent, 1 );
    ent.noragdoll = undefined;
    ent.favoriteenemy = function_3f8db38ff773ac8d( ent );
    
    if ( ent livingworld_is_zombie() )
    {
        if ( isdefined( level.var_a009ab14ee0d3223 ) && !level.var_a009ab14ee0d3223.isspecialround && !ent.force_ignore_enemy_count )
        {
            num_active_zombies = zm_utility::get_active_zombies_count();
            
            if ( num_active_zombies >= level.var_a009ab14ee0d3223.var_63a0ca44b877a390 )
            {
                level throttle::throttle_wait_in_queue( level.livingworldthrottle, ent );
                
                if ( level.var_21a155c9f2141948 == gettime() )
                {
                    waitframe();
                }
                
                level zm_utility::function_71d7c0e7375ef487( 1, [ "normal" ] );
            }
            
            level.var_a009ab14ee0d3223.var_939db9ccafac43a7[ level.var_a009ab14ee0d3223.var_939db9ccafac43a7.size ] = ent;
            ent.ignore_enemy_count = 0;
        }
        
        ent val::reset( "living_world", "allow_dismember" );
        round_number = zm_round_logic::get_rb_round_number();
        
        if ( ent.health != 0 && ent.maxhealth != 0 )
        {
            old_health_perc = ent.health / ent.maxhealth;
            ent zombie_utils::set_zombie_round_difficulty( round_number );
            ent.health = int( ceil( ent.health * old_health_perc ) );
        }
    }
    
    wait 1;
    ent.favoriteenemy = undefined;
    
    if ( ent livingworld_is_zombie() && level.var_a009ab14ee0d3223.isspecialround )
    {
        sparams = spawnstruct();
        sparams.livingworldstruct = self;
        ent thread function_236cafc608003a07( ent );
        return;
    }
    
    if ( !ent livingworld_is_zombie() && !ent.var_fd5c989cd241b6c4 )
    {
        utility::ent_flag_wait( "encounter_over" );
        thread zm_livingworld_vo::function_897af5e2d6e4c0ce( ent );
        wait randomfloatrange( 5, 8 );
        thread function_9bce79bcd64fcfb4( ent );
    }
}

// Namespace zm_livingworld
// Params 1, eflags: 0x4
// Checksum 0xed04cbe7, Offset: 0x9295
// Size: 0x135
function private function_3f8db38ff773ac8d( ent )
{
    ent.favoriteenemy = undefined;
    var_6f5c0bece5deb66e = ent function_f017e352a29a57a1( ent.origin, 1000 );
    
    if ( !var_6f5c0bece5deb66e.size )
    {
        return;
    }
    
    enemy = function_47c86977a18df38b( var_6f5c0bece5deb66e, self.origin );
    
    if ( isplayer( enemy ) )
    {
        return enemy;
    }
    
    closest_player = utility::get_closest_player();
    
    if ( !isdefined( closest_player ) )
    {
        return enemy;
    }
    
    if ( !isalive( enemy ) || enemy.var_fd5c989cd241b6c4 || ent val::get( "ignoreme" ) || isdefined( ent.var_fe5b48e832bc76f4 ) && !ent.var_fe5b48e832bc76f4.b_survive )
    {
        return closest_player;
    }
    
    var_9612e55d981ec3c6 = distancesquared( ent.origin, closest_player.origin );
    dist_to_ai = distancesquared( ent.origin, enemy.origin );
    
    if ( var_9612e55d981ec3c6 < dist_to_ai || var_9612e55d981ec3c6 - dist_to_ai < 300 )
    {
        return closest_player;
    }
    
    return enemy;
}

// Namespace zm_livingworld
// Params 1, eflags: 0x4
// Checksum 0xa56d4069, Offset: 0x93d3
// Size: 0x170
function private function_236cafc608003a07( sparams )
{
    ent = self;
    ent endon( #"death" );
    
    if ( sparams.var_116119b435cb0524 > 0 && sparams.var_d99e6683d333b772 )
    {
        return;
    }
    
    round_number = namespace_9d8e359c3b1041e5::function_57de0ca2e80536a1( ent.origin );
    
    if ( sparams.var_116119b435cb0524 > 0 && !ent namespace_659599414270bd0a::function_5b6b730e9f21cb98( round_number ) )
    {
        return;
    }
    
    ent namespace_659599414270bd0a::enable_emergence_spawning( 1 );
    ent utility::function_32b24db3127bff40( "transform", "transform_tell" );
    wait randomfloatrange( 1, 3 );
    host_data_params = spawnstruct();
    host_data_params.force_consecutive_spawn_func = &function_236cafc608003a07;
    host_data_params.var_704873fd9437ee43 = spawnstruct();
    host_data_params.var_704873fd9437ee43.livingworldstruct = sparams.livingworldstruct;
    host_data_params.var_704873fd9437ee43.var_d99e6683d333b772 = sparams.var_d99e6683d333b772;
    host_data_params.var_704873fd9437ee43.var_116119b435cb0524 = sparams.var_116119b435cb0524 ?? 0;
    host_data_params.var_704873fd9437ee43.var_116119b435cb0524++;
    ent namespace_659599414270bd0a::register_emergence_spawning_host_data( "force_consecutive_spawn", host_data_params );
    ent namespace_659599414270bd0a::force_emergence_spawning( 1, 1 );
}

// Namespace zm_livingworld
// Params 1
// Checksum 0xa6ec79f, Offset: 0x954b
// Size: 0x158
function function_2c3c99b60e6050bf( ent )
{
    ent endon( #"death" );
    
    if ( self.var_3cd2eba2b7ff6812 || self.var_47ea6ee6b1f5f5b7 )
    {
        return;
    }
    
    existing_ents = function_a7ba0b783fa73958();
    
    if ( !existing_ents.size )
    {
        return;
    }
    
    statename = ent asmgetcurrentstate( ent.asmname );
    asmname = ent.asmname;
    function_27163a1fce7f8c1c( ent, 1 );
    thread function_6e5fd0fe4f204c8e( asmname, statename, ent );
    lastnotetrack = ent asm::asm_donotetracks( asmname, statename, &function_9dda21dad29b2066, self );
    
    if ( !isalive( ent ) )
    {
        return;
    }
    
    function_27163a1fce7f8c1c( ent, 0 );
    
    if ( ent.var_fe5b48e832bc76f4.b_victim && !ent.var_fe5b48e832bc76f4.b_survive )
    {
        self notify( #"aivsai_ended" );
        ent.a.nodeath = 0;
        ent.var_f654ebe2aeab29f7 = 1;
        ent.noragdoll = 1;
        ent.disabledeathorient = 1;
        ent.var_fd5c989cd241b6c4 = 1;
        thread function_f4387e8267b53253( ent );
    }
}

// Namespace zm_livingworld
// Params 2, eflags: 0x4
// Checksum 0x4c165cbd, Offset: 0x96ab
// Size: 0x1da
function private function_27163a1fce7f8c1c( ent, var_b84028f2a0141008 )
{
    if ( !isalive( ent ) )
    {
        return;
    }
    
    if ( var_b84028f2a0141008 )
    {
        if ( ent.var_fe5b48e832bc76f4.b_victim )
        {
            ent animmode( "nogravity" );
        }
        else
        {
            ent animmode( "zonly_physics" );
        }
        
        ent val::set( "living_world", "ignoreme", 1 );
        ent.noragdoll = undefined;
        ent.script_noragdoll = undefined;
        return;
    }
    
    ent unlink();
    thread function_8ad951a9ce2ac4e5( ent );
    ent val::reset( "living_world", "death" );
    ent val::reset( "living_world", "damage" );
    ent val::reset( "living_world", "ignoreme" );
    
    if ( !ent livingworld_is_zombie() && ent.var_fe5b48e832bc76f4.b_survive && ent asm::asm_eventfired( ent.asmname, "weapon_drop" ) )
    {
        ent shared::default_weaponsetup();
        weaponname = ent.primaryweapon.basename ?? ent.lastweapon.basename;
        weapon = weapon_utility::function_d2c8356dc369d9ce( weaponname );
        ent shared::forceuseweapon( weapon, "primary" );
        
        if ( isdefined( ent.droppedweapon ) )
        {
            ent.droppedweapon notify( #"death" );
            
            if ( ent.droppedweapon utility::function_de1f80d93273abf5() )
            {
                ent.droppedweapon freescriptable();
            }
            else
            {
                ent.droppedweapon delete();
            }
            
            ent.droppedweapon = undefined;
        }
    }
}

// Namespace zm_livingworld
// Params 1, eflags: 0x4
// Checksum 0x680e3ce8, Offset: 0x988d
// Size: 0x7f
function private function_f4387e8267b53253( ent )
{
    ent val::reset( "living_world", "death" );
    ent val::reset( "living_world", "damage" );
    
    if ( !ent livingworld_is_zombie() )
    {
        function_7668bbd3077aa119( ent, ent.origin + anglestoforward( ent.angles ), undefined, 1 );
        return;
    }
    
    function_7668bbd3077aa119( ent, ent.origin, undefined, 1 );
}

// Namespace zm_livingworld
// Params 3, eflags: 0x4
// Checksum 0xd76e572c, Offset: 0x9914
// Size: 0x11f
function private function_6e5fd0fe4f204c8e( asmname, statename, ent )
{
    ent endon( #"death" );
    self endon( #"aivsai_ended" );
    self endon( #"cancel_encounter" );
    ent.var_fe5b48e832bc76f4.target utility::waittill_any( "death", "entitydeleted" );
    ent unlink();
    
    if ( ent.var_fe5b48e832bc76f4.b_victim )
    {
        ent.var_fe5b48e832bc76f4.b_survive = !ent asm::asm_eventfired( asmname, "melee_interact" );
        
        if ( !ent.var_fe5b48e832bc76f4.b_survive )
        {
            if ( !ent asm::asm_eventfired( asmname, "death_ragdoll_delayed" ) )
            {
                thread function_f4387e8267b53253( ent );
            }
            
            return;
        }
    }
    
    function_27163a1fce7f8c1c( ent, 0 );
    self.scene_root scene::cleanup();
    self.var_47ea6ee6b1f5f5b7 = 1;
    ent.var_fe5b48e832bc76f4.b_abort = 1;
}

// Namespace zm_livingworld
// Params 2
// Checksum 0xfb95a0c, Offset: 0x9a3b
// Size: 0x260
function function_9dda21dad29b2066( note, livingworldstruct )
{
    ent = self;
    ent endon( #"death" );
    livingworldstruct endon( #"aivsai_ended" );
    livingworldstruct endon( #"cancel_encounter" );
    
    if ( note == "sync" )
    {
        if ( !ent.var_fe5b48e832bc76f4.b_abort && isalive( ent.var_fe5b48e832bc76f4.target ) )
        {
            ent unlink();
            ent.var_fe5b48e832bc76f4.target unlink();
            ent linktoblendtotag( ent.var_fe5b48e832bc76f4.target, "tag_sync", 1, 1 );
        }
        
        return;
    }
    
    if ( note == "unsync" )
    {
        ent unlink();
        
        if ( isalive( ent.var_fe5b48e832bc76f4.target ) )
        {
            ent.var_fe5b48e832bc76f4.target unlink();
            ent.var_fe5b48e832bc76f4.target animmode( "zonly_physics" );
        }
        
        ent animmode( "zonly_physics" );
        
        if ( !ent.var_fe5b48e832bc76f4.b_victim )
        {
            ent notify( #"hash_b18bfc100d1db042" );
            ent endon( #"hash_b18bfc100d1db042" );
            ent utility::ent_flag_wait( "anim_ended" );
            return note;
        }
        
        return;
    }
    
    if ( note == "melee_interact" )
    {
        ent val::set( "living_world", "death", 0 );
        ent val::set( "living_world", "damage", 0 );
        ent function_7f8988ce63c1623d( 0 );
        ent val::set( "living_world", "collide_with_ai_allies", 0 );
        ent.var_fe5b48e832bc76f4.b_survive = 0;
        ent.var_fd5c989cd241b6c4 = 1;
        ent dodamage( ent.health - 1, ent.origin, ent );
        waitframe();
        ent.var_f2bc035a31b7e81b function_3e06225ab3320460( ent, 1 );
        return;
    }
    
    if ( note == "weapon_drop" )
    {
        function_3e307dbfd237ea2f();
        return;
    }
    
    if ( note == "melee_death" )
    {
        return note;
    }
}

// Namespace zm_livingworld
// Params 0, eflags: 0x4
// Checksum 0x80bffe1, Offset: 0x9ca3
// Size: 0xcb
function private function_3e307dbfd237ea2f()
{
    if ( livingworld_is_zombie() || !isalive( self ) )
    {
        return;
    }
    
    shared::dropallaiweapons();
    
    if ( isdefined( level.gametypebundle ) && level.gametypebundle.var_d7bbf0445f1389c9 )
    {
        return;
    }
    
    if ( !self.alreadydroppedweapon && isdefined( level.var_b6c3ca068782a9cb ) && isdefined( level.var_3836af4596707c8c ) )
    {
        self.alreadydroppedweapon = 1;
        itembundle = loot_drops::function_1fa69e8c7540c2af();
        var_32273be465dc12ff = { #droppos:self.origin, #dropquantity:undefined, #droplist:"zm_t10_items_default_droplist" };
        thread [[ level.var_3836af4596707c8c ]]( itembundle, var_32273be465dc12ff );
    }
}

// Namespace zm_livingworld
// Params 0, eflags: 0x4
// Checksum 0x8a65e420, Offset: 0x9d76
// Size: 0x1ba
function private function_d7e6facba03842e4()
{
    self endon( #"death" );
    self endon( #"hash_30d11728ec87ccb" );
    self.cancel_str = undefined;
    function_a96567b410cccb4();
    self.isplaying = undefined;
    self.var_b409a727ea4063cc = undefined;
    self.var_47ea6ee6b1f5f5b7 = 1;
    self notify( #"cancel_encounter" );
    function_99602bdbb9406b23( self );
    
    if ( isdefined( self.encounterstruct.scenebundle ) && ( self.var_67c31f2a94afd9b1 || self.var_c2d5815a88c24edd ) )
    {
        ents = self.scene_root scene::get_entities();
        
        if ( !ents.size )
        {
            ents = self.scene_ents[ "actors" ];
        }
        else
        {
            self.scene_root scene::stop();
            self.scene_root scene::cleanup();
        }
    }
    else
    {
        ents = function_548a067eccee7343();
    }
    
    foreach ( ent in ents )
    {
        if ( !isai( ent ) || !isalive( ent ) )
        {
            continue;
        }
        
        throttle::throttle_wait_in_queue( level.livingworldthrottle, ent );
        ent.nocorpse = 1;
        function_7668bbd3077aa119( ent, undefined, undefined, 1 );
    }
    
    if ( self.idle_func_vars.b_cleanup_props )
    {
        function_5acaf1d18c245a8f( self );
    }
}

// Namespace zm_livingworld
// Params 0
// Checksum 0xc26e34f0, Offset: 0x9f38
// Size: 0x1c
function function_a96567b410cccb4()
{
    childthread function_1324849c2661e78b();
    childthread function_652271f57eb80523();
    utility::ent_flag_wait( "cancel_encounter" );
}

// Namespace zm_livingworld
// Params 0, eflags: 0x4
// Checksum 0x6f00f0a5, Offset: 0x9f5c
// Size: 0x33
function private function_1324849c2661e78b()
{
    self endon( #"cancel_encounter" );
    self.cancel_str = level utility::waittill_any_in_array_return( self.var_3920f827ef511acd );
    utility::ent_flag_set( "cancel_encounter" );
}

// Namespace zm_livingworld
// Params 0, eflags: 0x4
// Checksum 0xbb6cdaf3, Offset: 0x9f97
// Size: 0x33
function private function_652271f57eb80523()
{
    self endon( #"cancel_encounter" );
    self.cancel_str = level utility::flag_wait_any_array_return( self.var_3920f827ef511acd );
    utility::ent_flag_set( "cancel_encounter" );
}

// Namespace zm_livingworld
// Params 1, eflags: 0x4
// Checksum 0x876f3d58, Offset: 0x9fd2
// Size: 0x1df
function private function_24d9d7857807eb51( ent )
{
    self endon( #"cancel_encounter" );
    level endon( #"game_ended" );
    self endon( #"death" );
    
    if ( isdefined( self.action_func_vars.var_60cdbd3a22149cf7 ) && !isarray( self.action_func_vars.var_60cdbd3a22149cf7 ) )
    {
        self.action_func_vars.var_60cdbd3a22149cf7 = [ self.action_func_vars.var_60cdbd3a22149cf7 ];
    }
    
    if ( isdefined( self.action_func_vars.var_60cdbd3a22149cf7 ) && arraycontains( self.action_func_vars.var_60cdbd3a22149cf7, ent ) )
    {
        ent.var_fd5c989cd241b6c4 = 1;
        var_33493bb2b8e5bc33 = 1;
    }
    
    ent utility::ent_flag_waitopen_any( "scene_ent_playing_anim" );
    ent utility::ent_flag_set( "anim_ended" );
    ent notify( #"anim_ended" );
    utility::ent_flag_set( "any_ent_scene_ended" );
    utility::ent_flag_set( "encounter_over" );
    
    if ( !isalive( ent ) || ent.var_fd5c989cd241b6c4 && !var_33493bb2b8e5bc33 || !isdefined( self.action_func_vars.var_60cdbd3a22149cf7 ) )
    {
        return;
    }
    
    if ( !arraycontains( self.action_func_vars.var_60cdbd3a22149cf7, ent ) )
    {
        return;
    }
    
    ent.b_cleanup_no_respawn = 1;
    ent.var_f654ebe2aeab29f7 = 1;
    ent.noragdoll = 1;
    ent.disabledeathorient = 1;
    ent.var_fd5c989cd241b6c4 = 1;
    ent val::set( "living_world", "allow_dismember", 0 );
    function_7668bbd3077aa119( ent, undefined, undefined, 1 );
}

// Namespace zm_livingworld
// Params 2
// Checksum 0xf4ec13b4, Offset: 0xa1b9
// Size: 0x379
function function_81a561e9fdd18c94( sparams, livingworldstruct )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    
    if ( self.livingworldstruct != livingworldstruct )
    {
        return;
    }
    
    if ( sparams.entity utility::ent_flag( "ent_scene_death_anim_playing" ) )
    {
        return;
    }
    
    if ( isplayer( sparams.eattacker ) )
    {
        sweapon = sparams.objweapon ?? sparams.sweapon;
        sparams.entity events::function_92b70ecfc2f8e086( sparams.entity, sparams.eattacker, sparams.einflictor, sparams.smeansofdeath, sweapon, sparams.vpoint, undefined, sparams.entity.kiastring );
        sparams.entity zm_damage::update_kills( sparams.eattacker, sparams.einflictor, sweapon, sparams.smeansofdeath );
        
        if ( isai( sparams.entity ) )
        {
            sparams.entity events::zm_event_on_ai_killed( sparams );
            sparams.entity val::set( "living_world", "allow_give_point", 0 );
        }
        
        sparams.var_769b3a755c2cec3c = 1;
        sparams.entity callback::callback( "on_living_world_prop_zombie_killed", sparams );
    }
    
    sparams.entity utility::ent_flag_set( "ent_scene_death_anim_playing" );
    sparams.entity notify( #"ent_scene_death_anim_playing" );
    sparams.entity.var_2fc3a5fb762afb6e = 1;
    var_23935e08a0028d72 = [ sparams.entity ];
    sparams.entity val::set( "living_world", "show_healthbar", 0 );
    var_e281e21ab3250ccd = arraycombine( self.livingworldstruct.var_58e6c0d1fd24de83, sparams.var_1874a1a2711b696d );
    
    foreach ( object in var_e281e21ab3250ccd )
    {
        entity = object.entity ?? object;
        entity utility::ent_flag_set( "ent_scene_death_anim_playing" );
        entity notify( #"ent_scene_death_anim_playing" );
        entity.var_2fc3a5fb762afb6e = 1;
        entity val::set( "living_world", "show_healthbar", 0 );
        var_23935e08a0028d72[ var_23935e08a0028d72.size ] = entity;
        
        if ( self.livingworldstruct.var_58e6c0d1fd24de83.size && arraycontains( self.livingworldstruct.var_58e6c0d1fd24de83, entity ) )
        {
            successful = self.livingworldstruct function_bfff922493583b30( "death", 1 );
        }
    }
    
    level notify( #"highvis_reload_outline", undefined, var_23935e08a0028d72 );
    livingworldstruct utility::ent_flag_set( "any_ent_scene_died" );
    livingworldstruct notify( #"any_ent_scene_died" );
}

// Namespace zm_livingworld
// Params 2
// Checksum 0x292c9a24, Offset: 0xa53a
// Size: 0x4fb
function livingworld_on_ai_killed( sparams, var_650afee77554228c )
{
    if ( !self.is_living_world_ai )
    {
        return;
    }
    
    livingworldstruct = var_650afee77554228c;
    
    if ( !function_1d0b3d1864dce638( livingworldstruct ) )
    {
        return;
    }
    
    sparams.livingworldstruct = livingworldstruct;
    callback::callback( "on_zm_living_world_ai_killed", sparams );
    
    if ( isdefined( self.var_4c7d7e0b37ebeecd ) )
    {
        destroynavobstacle( self.var_4c7d7e0b37ebeecd );
        self.var_4c7d7e0b37ebeecd = undefined;
    }
    
    encounter_ai = livingworldstruct function_548a067eccee7343();
    var_e6c50b4ff51fb50 = function_46f9072493651dc9( encounter_ai );
    
    if ( var_e6c50b4ff51fb50.size < 1 )
    {
        var_fdc30d1f223e04f7 = livingworldstruct.script_scenescriptbundle ?? livingworldstruct.script_string;
        livingworldstruct callback::callback( var_fdc30d1f223e04f7 + "_over", sparams );
        livingworldstruct utility::ent_flag_set( "encounter_over" );
        livingworldstruct utility::ent_flag_set( "all_ai_encounter_died" );
        livingworldstruct notify( #"hash_c23c813b3c21d863" );
        
        if ( !livingworldstruct.action_func_vars.var_aacbe22211b4a5db )
        {
            livingworldstruct function_4cd7c660bedf807a( "1" );
        }
    }
    
    level._livingworld_info.var_90fad1f7b6fa1ff0 = arrayremove( level._livingworld_info.var_90fad1f7b6fa1ff0, self );
    
    if ( livingworldstruct.var_4e0eb39dc8466ea7 )
    {
        if ( livingworldstruct utility::ent_flag( "encounter_over" ) )
        {
            return;
        }
        
        livingworldstruct.var_8cdfbe729ebfdd80 = arrayremove( livingworldstruct.var_8cdfbe729ebfdd80, self );
        livingworldstruct.var_b9dc955e2a0cb75f = arrayremove( livingworldstruct.var_b9dc955e2a0cb75f, self );
        var_8cdfbe729ebfdd80 = livingworldstruct.var_8cdfbe729ebfdd80;
        var_b9dc955e2a0cb75f = livingworldstruct.var_b9dc955e2a0cb75f;
        
        if ( var_8cdfbe729ebfdd80.size && var_b9dc955e2a0cb75f.size )
        {
            foreach ( enemyspawned in var_b9dc955e2a0cb75f )
            {
                if ( !isdefined( enemyspawned.favoriteenemy ) )
                {
                    enemyspawned.favoriteenemy = utility::array_random( var_8cdfbe729ebfdd80 );
                }
            }
            
            foreach ( enemyspawned in var_8cdfbe729ebfdd80 )
            {
                if ( !isdefined( enemyspawned.favoriteenemy ) )
                {
                    enemyspawned.favoriteenemy = utility::array_random( var_b9dc955e2a0cb75f );
                }
            }
        }
        else
        {
            livingworldstruct callback::callback( livingworldstruct.encounterstruct.stringid + "_over", sparams );
            livingworldstruct utility::ent_flag_set( "encounter_over" );
            
            if ( var_b9dc955e2a0cb75f.size > 0 )
            {
                foreach ( zombie in var_b9dc955e2a0cb75f )
                {
                    livingworldstruct thread function_8ad951a9ce2ac4e5( zombie );
                }
            }
            
            if ( var_8cdfbe729ebfdd80.size > 0 )
            {
                foreach ( human in var_8cdfbe729ebfdd80 )
                {
                    livingworldstruct thread function_8ad951a9ce2ac4e5( human );
                }
            }
        }
        
        return;
    }
    
    livingworldstruct.var_91a9a93891a58803 = livingworldstruct function_1b5b7623688beb63( livingworldstruct.var_2d6cf50c52a5088b );
    
    if ( isdefined( livingworldstruct.var_91a9a93891a58803 ) )
    {
        function_8eee74786bedf399( livingworldstruct );
    }
    
    livingworldstruct.var_8c6f41d30c002ae3 = livingworldstruct function_1b5b7623688beb63( livingworldstruct.var_a6f080feb7f474bb );
    
    if ( isdefined( livingworldstruct.var_8c6f41d30c002ae3 ) )
    {
        level notify( livingworldstruct.script_scenescriptbundle + "_cancel_living_world_encounter_" + livingworldstruct.origin );
    }
    
    livingworldstruct.scene_ents[ "actors" ] = arrayremove( livingworldstruct.scene_ents[ "actors" ], self );
    
    if ( !utility::ent_flag( "ent_scene_death_anim_playing" ) && self.idle_func_vars.b_cleanup_props )
    {
        function_5acaf1d18c245a8f( livingworldstruct );
    }
}

// Namespace zm_livingworld
// Params 2
// Checksum 0xd2e8a3d7, Offset: 0xaa3d
// Size: 0x16b
function function_39c6b614d4d298fa( sparams, livingworldstruct )
{
    if ( !function_1d0b3d1864dce638( livingworldstruct ) )
    {
        return;
    }
    
    if ( !livingworldstruct.isplaying || utility::ent_flag( "anim_ended" ) )
    {
        return;
    }
    
    if ( self.noragdoll || self.var_fd5c989cd241b6c4 )
    {
        return;
    }
    
    if ( asm::asm_eventfired( self.asmname, "death_ragdoll_delayed" ) )
    {
        return;
    }
    
    if ( isdefined( self.last_dmg_struct.vdir ) )
    {
        if ( isdefined( self.var_fe5b48e832bc76f4.target ) )
        {
            zombie = self.var_fe5b48e832bc76f4.target;
            vdir = vectornormalize( self.origin - zombie.origin );
        }
        
        if ( !isdefined( vdir ) )
        {
            vdir = self.last_dmg_struct.vdir;
        }
        
        damagelocation = self.last_dmg_struct.shitloc == "none" ? "torso_upper" : self.damagelocation;
        sparams.body startragdollfromimpact( damagelocation, vdir );
        return;
    }
    
    sparams.body = self getcorpseentity();
    sparams.body startragdoll();
}

// Namespace zm_livingworld
// Params 1, eflags: 0x4
// Checksum 0x922a1c7e, Offset: 0xabb0
// Size: 0x49
function private function_8eee74786bedf399( livingworldstruct )
{
    if ( livingworldstruct.isplaying )
    {
        return;
    }
    
    function_99602bdbb9406b23( livingworldstruct );
    livingworldstruct.var_3cd2eba2b7ff6812 = istrue( livingworldstruct.var_d474e24ade45d4ce );
    livingworldstruct notify( #"hash_75df6a939e8d6845" );
}

// Namespace zm_livingworld
// Params 1, eflags: 0x4
// Checksum 0xd14660d8, Offset: 0xac01
// Size: 0x140
function private function_1b5b7623688beb63( ents )
{
    if ( !isdefined( ents ) )
    {
        return;
    }
    
    foreach ( scenarios in ents )
    {
        foreach ( scenario in scenarios )
        {
            scenario_check = 0;
            
            for ( i = 0; i < scenario.size ; i++ )
            {
                ent = scenario[ i ];
                
                if ( !isalive( ent ) || ent.health <= 1 )
                {
                    scenario_check++;
                }
            }
            
            if ( scenario_check === scenario.size )
            {
                return scenario;
            }
        }
    }
}

// Namespace zm_livingworld
// Params 2
// Checksum 0xd8bfaecd, Offset: 0xad4a
// Size: 0x1c6
function function_a60d472038498618( sparams, livingworldstruct )
{
    if ( self.var_f2bc035a31b7e81b != livingworldstruct )
    {
        return;
    }
    
    level endon( #"game_ended" );
    
    if ( isdefined( self.var_13d60e5f54c6db7 ) )
    {
        alignmentinfo = self.var_13d60e5f54c6db7;
        entity = sparams.body;
        
        if ( isent( alignmentinfo.alignent ) && entity != alignmentinfo.alignent )
        {
            entity unlink();
            entity.origin = self.origin;
            entity.angles = self.angles;
            entity enablelinkto();
            
            if ( !entity isragdoll() )
            {
                if ( isdefined( alignmentinfo.aligntag ) )
                {
                    if ( alignmentinfo.var_f35d0dd7130d5eea )
                    {
                        entity linktomoveoffset( alignmentinfo.alignent, alignmentinfo.aligntag, ( 0, 0, 0 ), ( 0, 0, 0 ) );
                    }
                    else
                    {
                        entity linktomoveoffset( alignmentinfo.alignent, alignmentinfo.aligntag );
                    }
                }
                else
                {
                    entity linktomoveoffset( alignmentinfo.alignent );
                }
            }
        }
        else
        {
            entity.origin = self.origin;
            entity.angles = self.angles;
        }
    }
    
    sparams.body waittill( #"corpse_deleted", position );
    
    if ( livingworldstruct.idle_func_vars.b_cleanup_props )
    {
        function_5acaf1d18c245a8f( livingworldstruct );
    }
}

// Namespace zm_livingworld
// Params 2
// Checksum 0xfd272c1f, Offset: 0xaf18
// Size: 0x18a
function function_2976dc572653be5e( idle_func_vars = init_idle_func_vars(), action_func_vars = init_action_func_vars() )
{
    lw_ents = function_548a067eccee7343();
    
    foreach ( ent in lw_ents )
    {
        if ( !isalive( ent ) || !isagent( ent ) )
        {
            continue;
        }
        
        if ( !self.isplaying )
        {
            if ( ent livingworld_is_zombie() )
            {
                if ( idle_func_vars.var_e62b2e161f3ee23d )
                {
                    thread function_f583b71d8e3080fd( ent, idle_func_vars.var_4ed3b0d48d08c39 );
                }
            }
            
            if ( isdefined( idle_func_vars.var_4fbad4584ac0f3d0 ) )
            {
                ent function_66dc8b6ae969f66d( idle_func_vars.var_4fbad4584ac0f3d0 );
            }
            
            if ( idle_func_vars.b_allow_dismember )
            {
                ent val::reset( "living_world", "allow_dismember" );
            }
        }
        else if ( isdefined( action_func_vars.var_4fbad4584ac0f3d0 ) )
        {
            ent function_66dc8b6ae969f66d( action_func_vars.var_4fbad4584ac0f3d0 );
        }
        
        if ( idle_func_vars.b_no_eye_glow )
        {
            ent val::set( "living_world", "toggle_eye_glow", self.isplaying );
        }
    }
}

// Namespace zm_livingworld
// Params 7
// Checksum 0xbfeeb5be, Offset: 0xb0aa
// Size: 0xb0
function init_idle_func_vars( var_e62b2e161f3ee23d, var_4ed3b0d48d08c39 = 250, var_4fbad4584ac0f3d0, b_cleanup_props = 1, b_no_eye_glow, b_allow_dismember, var_aacbe22211b4a5db )
{
    idle_func_vars = { #var_aacbe22211b4a5db:var_aacbe22211b4a5db, #b_allow_dismember:b_allow_dismember, #b_no_eye_glow:b_no_eye_glow, #b_cleanup_props:b_cleanup_props, #var_4fbad4584ac0f3d0:var_4fbad4584ac0f3d0, #var_4ed3b0d48d08c39:var_4ed3b0d48d08c39, #var_e62b2e161f3ee23d:var_e62b2e161f3ee23d };
    return idle_func_vars;
}

// Namespace zm_livingworld
// Params 9
// Checksum 0xbe08f7b9, Offset: 0xb163
// Size: 0xcf
function init_action_func_vars( custom_move_speed, var_4fbad4584ac0f3d0, var_e06192d7cc86631, var_60cdbd3a22149cf7, var_22a8df214305f621, var_1c10b8fee43e668 = 50, var_b93ffef3fae6de08, var_c091d20360c631b2, var_aacbe22211b4a5db )
{
    action_func_vars = { #var_aacbe22211b4a5db:var_aacbe22211b4a5db, #var_c091d20360c631b2:var_c091d20360c631b2, #var_b93ffef3fae6de08:var_b93ffef3fae6de08, #var_1c10b8fee43e668:var_1c10b8fee43e668, #var_22a8df214305f621:var_22a8df214305f621, #var_60cdbd3a22149cf7:var_60cdbd3a22149cf7, #var_e06192d7cc86631:var_e06192d7cc86631, #var_4fbad4584ac0f3d0:var_4fbad4584ac0f3d0, #custom_move_speed:custom_move_speed };
    return action_func_vars;
}

// Namespace zm_livingworld
// Params 2
// Checksum 0xc6928735, Offset: 0xb23b
// Size: 0x216
function function_f583b71d8e3080fd( ent, lookat_dist )
{
    if ( !isalive( ent ) || !isai( ent ) )
    {
        return;
    }
    
    ent endon( #"anim_ended" );
    ent endon( #"death" );
    self endon( #"cancel_encounter" );
    level endon( #"game_ended" );
    var_8a129ef1e3c8fc67 = isdefined( self.height ) ? ent.origin + ( 0, 0, int( self.height * -1 ) ) : ent.origin;
    
    if ( !isdefined( self.lookattrigger ) )
    {
        self.lookattrigger = spawn( "noent_volume_trigger_radius", var_8a129ef1e3c8fc67, 0, lookat_dist, lookat_dist );
    }
    
    ent function_28b54d425ee6f778( "player, enemy, random_directions", "prohibit" );
    ent function_f90a9bf2ca30fdea( "player, enemy, random_directions", "prohibit" );
    ent waittill( #"lookat" );
    var_19282c47393405be = undefined;
    
    while ( isalive( ent ) && !self.var_c0993ffe04a4ad27 )
    {
        self.lookattrigger waittill( #"trigger", triggerent );
        
        if ( isplayer( triggerent ) )
        {
            closest_player = function_47c86977a18df38b( level.players, ent.origin, lookat_dist );
            
            if ( isdefined( closest_player ) )
            {
                if ( isdefined( var_19282c47393405be ) && closest_player != var_19282c47393405be )
                {
                    ent ai_lookat::disablelookatentity( var_19282c47393405be );
                }
                
                ent ai_lookat::enablelookatentity( closest_player );
                var_19282c47393405be = closest_player;
                ent function_28b54d425ee6f778( "player, enemy, random_directions", "neutral" );
                ent function_f90a9bf2ca30fdea( "player, enemy, random_directions", "neutral" );
            }
            
            wait 1;
            continue;
        }
        
        if ( isdefined( var_19282c47393405be ) && distancesquared( var_19282c47393405be.origin, ent.origin ) > squared( lookat_dist ) )
        {
            ent ai_lookat::disablelookatentity( var_19282c47393405be );
            var_19282c47393405be = undefined;
            ent function_28b54d425ee6f778( "player, enemy, random_directions", "prohibit" );
            ent function_f90a9bf2ca30fdea( "player, enemy, random_directions", "prohibit" );
        }
    }
}

// Namespace zm_livingworld
// Params 2
// Checksum 0x1b9cdf72, Offset: 0xb459
// Size: 0xb2
function function_67a0dafadded5989( ent, movespeed )
{
    ent endon( #"death" );
    
    if ( !ent function_159f1fa4c098a1e8() )
    {
        return;
    }
    
    if ( isdefined( level.var_3c6a4eee7184de4e ) )
    {
        ent thread [[ level.var_3c6a4eee7184de4e ]]();
        return;
    }
    
    if ( level utility::flag( "rampage_inducer_activated" ) )
    {
        ent thread zombie_utils::function_a8ce00e0448cb6f0( "sprint", "rampage_inducer", 25 );
        return;
    }
    
    if ( isdefined( movespeed ) )
    {
        ent thread zombie_utils::function_a8ce00e0448cb6f0( movespeed, "living_world", 10002 );
        return;
    }
    
    movespeed = zm_round_spawning::function_6211dbc10409aa10();
    ent thread zombie_utils::function_a8ce00e0448cb6f0( movespeed, "zm_round_spawning", 1 );
    ent thread zm_round_spawning::function_34fc35b31cc5777a( movespeed );
}

// Namespace zm_livingworld
// Params 0
// Checksum 0x8228c855, Offset: 0xb513
// Size: 0x34, Type: bool
function function_159f1fa4c098a1e8()
{
    for ( i = 0; i < 5 ; i++ )
    {
        if ( self.animsetname === self getbasearchetype() )
        {
            return true;
        }
        
        waitframe();
    }
    
    return false;
}

// Namespace zm_livingworld
// Params 5
// Checksum 0xdb186a08, Offset: 0xb550
// Size: 0x152
function function_fbbc42d14f371113( n_chance_dismember, var_c23a2bef26438963, var_77fa987b6b84d1b2 = [], var_624dfccf2cb92d56 = 2, var_6d535f67aee41549 = 0 )
{
    if ( !self.var_f2bc035a31b7e81b.isplaying )
    {
        wait 1;
    }
    
    for ( i = 0; i < var_624dfccf2cb92d56 + 1 ; i++ )
    {
        chance = i == 0 ? n_chance_dismember : var_c23a2bef26438963;
        
        if ( !utility::percent_chance( chance ) )
        {
            return;
        }
        
        foreach ( dismember_part, dismember_func in level._livingworld_info.var_5fdeb72e7240c31c )
        {
            if ( var_77fa987b6b84d1b2.size > 0 && arraycontains( var_77fa987b6b84d1b2, dismember_part ) )
            {
                continue;
            }
            
            if ( dismember_part == "head" )
            {
                self [[ dismember_func ]]( var_6d535f67aee41549 );
            }
            else
            {
                self [[ dismember_func ]]();
            }
            
            break;
        }
    }
}

// Namespace zm_livingworld
// Params 1, eflags: 0x4
// Checksum 0x7c0807d, Offset: 0xb6aa
// Size: 0x8e
function private function_25a74db025a58ccb( var_7dddc60e0205506b )
{
    var_a26713baa15e6174 = self.encounterstruct.scenebundle ?? self.encounterstruct.stringid;
    
    if ( isdefined( var_7dddc60e0205506b ) )
    {
        var_a26713baa15e6174 += var_7dddc60e0205506b;
    }
    
    script_func = level._livingworld_info.script_funcs[ var_a26713baa15e6174 ];
    
    if ( isdefined( script_func ) )
    {
        self thread [[ script_func ]]();
        return;
    }
    
    if ( isdefined( var_7dddc60e0205506b ) )
    {
        return;
    }
    
    assertmsg( "<dev string:x2c9>" );
}

/#

    // Namespace zm_livingworld
    // Params 0, eflags: 0x4
    // Checksum 0xb0a4f90c, Offset: 0xb740
    // Size: 0x1d5, Type: dev
    function private livingworld_init_debug()
    {
        level._livingworld_info.s_debug = spawnstruct();
        level._livingworld_info.s_debug.var_68ec6e14dfd0bb10 = 1;
        level._livingworld_info.s_debug.var_11221f8f083da643 = 6;
        level._livingworld_info.s_debug.var_9223bb63ba63157f = 30;
        devgui::function_9082edeb5db93280( "<dev string:x33d>" );
        devgui::function_cd4e263c1f3018ae( "<dev string:x34e>", "<dev string:x371>", &function_e6a0bdd5a44b51e2, 0 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x38a>", "<dev string:x3ab>", &function_e6a0bdd5a44b51e2, 0 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x3c6>", "<dev string:x3eb>", &function_e6a0bdd5a44b51e2, 0 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x406>", "<dev string:x42d>", &function_e6a0bdd5a44b51e2, 0 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x44a>", "<dev string:x46f>", &function_e6a0bdd5a44b51e2, 0 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x48e>", "<dev string:x4b7>", &function_e6a0bdd5a44b51e2, 0 );
        devgui::add_devgui_func( "<dev string:x4d6>", "<dev string:x503>", &function_65bf8e3351126797, 0, 1 );
        devgui::add_devgui_func( "<dev string:x516>", "<dev string:x543>", &function_13e80e427ca38aba, 0, 2 );
        devgui::add_devgui_func( "<dev string:x556>", "<dev string:x56c>", &function_e9a46932006a831b, 1 );
        devgui::add_devgui_func( "<dev string:x57e>", "<dev string:x59c>", &function_bfeab7d357aae994, 1 );
        devgui::add_devgui_func( "<dev string:x5b6>", "<dev string:x5d6>", &function_b3c1b6b25aa6c12b, 1 );
        devgui::function_77df7fe7dd273e10();
        devgui::function_9082edeb5db93280( "<dev string:x5ea>" );
        devgui::function_cd4e263c1f3018ae( "<dev string:x605>", "<dev string:x624>", &clear_all_lw, 0 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x643>", "<dev string:x650>", &clear_all_lw, 0 );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace zm_livingworld
    // Params 1, eflags: 0x4
    // Checksum 0x336d4859, Offset: 0xb91d
    // Size: 0x13d, Type: dev
    function private clear_all_lw( var_d5776f4006084051 )
    {
        foreach ( livingworldstruct in level._livingworld_info.livingworldstructs )
        {
            if ( utility::string_to_bool( var_d5776f4006084051[ 0 ] ) )
            {
                if ( livingworldstruct.script_forcespawn )
                {
                    continue;
                }
                
                if ( isdefined( level._livingworld_info.script_funcs[ "<dev string:x663>" ] ) )
                {
                    [[ level._livingworld_info.script_funcs[ "<dev string:x663>" ] ]]( var_d5776f4006084051 );
                }
            }
            
            if ( isdefined( livingworldstruct.script_scenescriptbundle ) )
            {
                level notify( livingworldstruct.script_scenescriptbundle + "<dev string:x670>" + livingworldstruct.origin );
                continue;
            }
            
            level notify( livingworldstruct.encounterstruct.stringid + "<dev string:x670>" + livingworldstruct.origin );
        }
    }

    // Namespace zm_livingworld
    // Params 1, eflags: 0x4
    // Checksum 0xa535a15f, Offset: 0xba62
    // Size: 0x13a, Type: dev
    function private function_e6a0bdd5a44b51e2( params )
    {
        b_spawned_info = params[ 0 ] ? utility::string_to_bool( params[ 0 ] ) : undefined;
        is_next_page = params[ 1 ];
        
        if ( isdefined( is_next_page ) )
        {
            if ( !level utility::flag( "<dev string:x690>" ) )
            {
                iprintlnbold( "<dev string:x6a1>" );
                return;
            }
            
            is_next_page = int( is_next_page );
            var_68ec6e14dfd0bb10 = level._livingworld_info.s_debug.var_68ec6e14dfd0bb10;
            var_68ec6e14dfd0bb10 += is_next_page ? 1 : -1;
            max_num_pages = level._livingworld_info.livingworldstructs.size / level._livingworld_info.s_debug.var_9223bb63ba63157f;
            max_num_pages = ceil( max_num_pages );
            clamp( var_68ec6e14dfd0bb10, 1, max_num_pages );
            
            if ( var_68ec6e14dfd0bb10 < 1 )
            {
                iprintlnbold( "<dev string:x6d1>" );
                return;
            }
            
            if ( var_68ec6e14dfd0bb10 > max_num_pages )
            {
                iprintlnbold( "<dev string:x6fb>" );
                return;
            }
            
            level._livingworld_info.s_debug.var_68ec6e14dfd0bb10 = var_68ec6e14dfd0bb10;
        }
        
        level thread function_31b22c337581b306( params );
    }

    // Namespace zm_livingworld
    // Params 1, eflags: 0x4
    // Checksum 0x42264c21, Offset: 0xbba4
    // Size: 0xb0, Type: dev
    function private function_31b22c337581b306( params )
    {
        setdvarifuninitialized( @"hash_ee119ecc3a6bd2c9", 1.25 );
        b_spawned_info = params[ 0 ] ? utility::string_to_bool( params[ 0 ] ) : undefined;
        is_next_page = params[ 1 ];
        
        if ( isdefined( is_next_page ) )
        {
            level notify( #"hash_cc07663f3e7d77ae" );
            level endon( #"hash_cc07663f3e7d77ae" );
        }
        else if ( level utility::flag( "<dev string:x690>" ) )
        {
            level utility::flag_clear( "<dev string:x690>" );
            level notify( #"hash_cc07663f3e7d77ae" );
            return;
        }
        
        level utility::flag_set( "<dev string:x690>" );
        level thread function_1a8ac638a3c0d509( b_spawned_info );
    }

    // Namespace zm_livingworld
    // Params 1, eflags: 0x4
    // Checksum 0x85145b0b, Offset: 0xbc5c
    // Size: 0x3e7, Type: dev
    function private function_1a8ac638a3c0d509( b_spawned_info )
    {
        level endon( #"hash_cc07663f3e7d77ae" );
        indent_size = level._livingworld_info.s_debug.var_11221f8f083da643;
        max_show = level._livingworld_info.s_debug.var_9223bb63ba63157f;
        var_e64b0ca442751c2f = level._livingworld_info.s_debug.var_68ec6e14dfd0bb10 * max_show;
        var_e6281aa4424ef341 = var_e64b0ca442751c2f - max_show;
        
        while ( true )
        {
            var_78d6606d597fb76e = 0;
            var_cd9f3bc1391b449f = 0;
            var_22dafd082c991c76 = 0;
            var_de5239ddc354072d = 0;
            
            foreach ( lw_struct in level._livingworld_info.livingworldstructs )
            {
                if ( b_spawned_info )
                {
                    if ( !isdefined( lw_struct.var_b409a727ea4063cc ) )
                    {
                        continue;
                    }
                }
                else if ( isdefined( lw_struct.var_b409a727ea4063cc ) )
                {
                    continue;
                }
                
                stringid = lw_struct.script_string ?? lw_struct.script_scenescriptbundle;
                var_c320d92a36781f14 = tolower( getprojectname() );
                var_319c560c51eba1e = var_c320d92a36781f14 + "<dev string:x71c>";
                
                if ( issubstr( stringid, var_319c560c51eba1e ) )
                {
                    stringid = removesubstr( stringid, var_319c560c51eba1e );
                }
                
                var_78d6606d597fb76e = int( max( var_78d6606d597fb76e, stringid.size ) );
                state = lw_struct.state ?? "<dev string:x732>";
                var_22dafd082c991c76 = int( max( var_22dafd082c991c76, state.size ) );
                var_cd9f3bc1391b449f = int( max( var_cd9f3bc1391b449f, lw_struct.zone.script_zone_name.size ) );
                org = string( lw_struct.origin );
                var_de5239ddc354072d = int( max( var_de5239ddc354072d, org.size ) );
                var_be558c4e6c515d8f = int( max( var_78d6606d597fb76e, var_cd9f3bc1391b449f + indent_size ) );
                var_56b7561ca27ea4c9 = int( max( var_22dafd082c991c76, var_de5239ddc354072d ) );
            }
            
            level debug::function_298a6c4895b8935d( ( 800, 100, 0 ) );
            
            for ( i = 0; i < level._livingworld_info.livingworldstructs.size ; i++ )
            {
                if ( i < var_e6281aa4424ef341 || i > var_e64b0ca442751c2f )
                {
                    continue;
                }
                
                lw_struct = level._livingworld_info.livingworldstructs[ i ];
                
                if ( b_spawned_info )
                {
                    if ( !isdefined( lw_struct.var_b409a727ea4063cc ) )
                    {
                        continue;
                    }
                }
                else if ( isdefined( lw_struct.var_b409a727ea4063cc ) )
                {
                    continue;
                }
                
                function_d1d17dc435a3cd00( lw_struct, var_be558c4e6c515d8f, var_56b7561ca27ea4c9 );
            }
            
            max_num_pages = level._livingworld_info.livingworldstructs.size / level._livingworld_info.s_debug.var_9223bb63ba63157f;
            max_num_pages = ceil( max_num_pages );
            text = "<dev string:x733>" + level._livingworld_info.s_debug.var_68ec6e14dfd0bb10 + "<dev string:x73b>" + max_num_pages;
            text_scale = getdvarfloat( @"hash_ee119ecc3a6bd2c9" );
            text_color = ( 1, 1, 1 );
            level debug::function_ce323c1a383e915( text, text_color, text_scale );
            level debug::function_9de8db536c079b2d();
            waitframe();
        }
    }

    // Namespace zm_livingworld
    // Params 3, eflags: 0x4
    // Checksum 0x3f1b4010, Offset: 0xc04b
    // Size: 0x232, Type: dev
    function private function_d1d17dc435a3cd00( lw_struct, var_be558c4e6c515d8f, var_56b7561ca27ea4c9 )
    {
        indent_size = level._livingworld_info.s_debug.var_11221f8f083da643;
        var_430947b6c1e8dedd = function_fdddb5882e80bc5a( indent_size, 0 );
        located_zone = lw_struct.zone.script_zone_name;
        var_430947b6c1e8dedd += located_zone;
        var_430947b6c1e8dedd += function_fdddb5882e80bc5a( var_be558c4e6c515d8f - indent_size, located_zone.size );
        var_430947b6c1e8dedd += "<dev string:x73f>";
        org = string( lw_struct.origin );
        var_430947b6c1e8dedd += lw_struct.origin;
        var_430947b6c1e8dedd += function_fdddb5882e80bc5a( var_56b7561ca27ea4c9 - indent_size, org.size );
        stringid = lw_struct.script_string ?? lw_struct.script_scenescriptbundle;
        var_c320d92a36781f14 = tolower( getprojectname() );
        var_319c560c51eba1e = var_c320d92a36781f14 + "<dev string:x71c>";
        
        if ( issubstr( stringid, var_319c560c51eba1e ) )
        {
            stringid = removesubstr( stringid, var_319c560c51eba1e );
        }
        
        text = stringid;
        line_offset = function_b01a135275dc4983( var_be558c4e6c515d8f, located_zone.size );
        text += function_fdddb5882e80bc5a( line_offset + var_be558c4e6c515d8f, stringid.size );
        text += "<dev string:x73f>";
        state = lw_struct.state ?? "<dev string:x732>";
        text += state;
        text += function_fdddb5882e80bc5a( var_56b7561ca27ea4c9, state.size );
        text += "<dev string:x73f>";
        
        if ( isdefined( lw_struct.var_102b4c59fb321c29 ) )
        {
            text_color = lw_struct.isplaying ? ( 0, 1, 0 ) : ( 1, 1, 0 );
        }
        else
        {
            text_color = ( 1, 0, 0 );
        }
        
        text_scale = getdvarfloat( @"hash_ee119ecc3a6bd2c9" );
        level debug::function_ce323c1a383e915( text, text_color, text_scale );
        level debug::function_ce323c1a383e915( var_430947b6c1e8dedd, text_color, text_scale );
    }

    // Namespace zm_livingworld
    // Params 2, eflags: 0x4
    // Checksum 0x3631f2da, Offset: 0xc285
    // Size: 0x53, Type: dev
    function private function_fdddb5882e80bc5a( max_len, var_85f86ffffd4faf7 )
    {
        text = "<dev string:x732>";
        
        for ( i = 0; i < max_len - var_85f86ffffd4faf7 + 1 ; i++ )
        {
            text += "<dev string:x743>";
        }
        
        return text;
    }

    // Namespace zm_livingworld
    // Params 2, eflags: 0x4
    // Checksum 0xc0206e65, Offset: 0xc2e0
    // Size: 0x4a, Type: dev
    function private function_b01a135275dc4983( line_len, var_85f86ffffd4faf7 )
    {
        match_offset = 0;
        indent_size = 6;
        
        if ( var_85f86ffffd4faf7 + indent_size > line_len )
        {
            match_offset = var_85f86ffffd4faf7 + indent_size - line_len;
        }
        
        return match_offset + 1;
    }

    // Namespace zm_livingworld
    // Params 0, eflags: 0x4
    // Checksum 0xf9021a5d, Offset: 0xc332
    // Size: 0x5d, Type: dev
    function private function_65bf8e3351126797()
    {
        setdvarifuninitialized( @"hash_ee119ecc3a6bd2c9", 1.25 );
        scale = getdvarfloat( @"hash_ee119ecc3a6bd2c9" );
        scale += 0.25;
        scale = clamp( scale, 0.25, 3.75 );
        setdvar( @"hash_ee119ecc3a6bd2c9", scale );
    }

    // Namespace zm_livingworld
    // Params 0, eflags: 0x4
    // Checksum 0x311677d, Offset: 0xc397
    // Size: 0x5d, Type: dev
    function private function_13e80e427ca38aba()
    {
        setdvarifuninitialized( @"hash_ee119ecc3a6bd2c9", 1.25 );
        scale = getdvarfloat( @"hash_ee119ecc3a6bd2c9" );
        scale -= 0.25;
        scale = clamp( scale, 0.25, 3.75 );
        setdvar( @"hash_ee119ecc3a6bd2c9", scale );
    }

    // Namespace zm_livingworld
    // Params 0, eflags: 0x4
    // Checksum 0x44f7e432, Offset: 0xc3fc
    // Size: 0x17e, Type: dev
    function private function_e9a46932006a831b()
    {
        var_cf580a90fe9cec4d = ( 0, 0, 5 );
        
        while ( true )
        {
            foreach ( lw_struct in level._livingworld_info.livingworldstructs )
            {
                stringid = lw_struct.script_string ?? lw_struct.script_scenescriptbundle;
                var_c320d92a36781f14 = tolower( getprojectname() );
                var_319c560c51eba1e = var_c320d92a36781f14 + "<dev string:x71c>";
                
                if ( issubstr( stringid, var_319c560c51eba1e ) )
                {
                    stringid = removesubstr( stringid, var_319c560c51eba1e );
                }
                
                if ( isdefined( lw_struct.var_b409a727ea4063cc ) )
                {
                    print3d( lw_struct.origin + var_cf580a90fe9cec4d, stringid + "<dev string:x745>" + lw_struct.origin, ( 0, 1, 0 ), 1, 0.5 );
                    continue;
                }
                
                print3d( lw_struct.origin, stringid + "<dev string:x745>" + lw_struct.origin, ( 1, 0, 0 ), 1, 0.5 );
            }
            
            waitframe();
        }
    }

    // Namespace zm_livingworld
    // Params 0, eflags: 0x4
    // Checksum 0x8802f65c, Offset: 0xc582
    // Size: 0x143, Type: dev
    function private function_bfeab7d357aae994()
    {
        var_cf580a90fe9cec4d = ( 0, 0, 5 );
        
        while ( true )
        {
            foreach ( lw_struct in level._livingworld_info.livingworldstructs )
            {
                if ( isdefined( lw_struct.var_b409a727ea4063cc ) )
                {
                    stringid = lw_struct.script_string ?? lw_struct.script_scenescriptbundle;
                    var_c320d92a36781f14 = tolower( getprojectname() );
                    var_319c560c51eba1e = var_c320d92a36781f14 + "<dev string:x71c>";
                    
                    if ( issubstr( stringid, var_319c560c51eba1e ) )
                    {
                        stringid = removesubstr( stringid, var_319c560c51eba1e );
                    }
                    
                    print3d( lw_struct.origin + var_cf580a90fe9cec4d, stringid + "<dev string:x745>" + lw_struct.origin, ( 0, 1, 0 ), 1, 0.5 );
                }
            }
            
            waitframe();
        }
    }

    // Namespace zm_livingworld
    // Params 0, eflags: 0x4
    // Checksum 0x118f150, Offset: 0xc6cd
    // Size: 0x220, Type: dev
    function private function_b3c1b6b25aa6c12b()
    {
        while ( true )
        {
            var_8e51d99478263b21 = utility::get_array_of_closest( level.players[ 0 ].origin, level._livingworld_info.livingworldstructs, undefined, 3 );
            
            foreach ( lw_struct in var_8e51d99478263b21 )
            {
                if ( isdefined( lw_struct.var_b409a727ea4063cc ) && ( isdefined( lw_struct.radius ) || isdefined( lw_struct.info_structs[ "<dev string:x748>" ] ) ) )
                {
                    range_struct = undefined;
                    
                    if ( isdefined( lw_struct.info_structs[ "<dev string:x748>" ] ) && isdefined( lw_struct.info_structs[ "<dev string:x748>" ][ 0 ].radius ) )
                    {
                        range_struct = lw_struct.info_structs[ "<dev string:x748>" ][ 0 ];
                    }
                    
                    if ( !isdefined( range_struct ) )
                    {
                        range_struct = lw_struct;
                    }
                    
                    ang_perc = int( range_struct.script_angle_max ?? 33 );
                    thread utility::function_dc36010b2b55e552( range_struct.origin, range_struct.radius, ang_perc, ( 1, 1, 1 ), 1, 0, 1 );
                    trigger_height = range_struct.origin[ 2 ] + ( range_struct.height ?? range_struct.radius );
                    cylinder_end = ( range_struct.origin[ 0 ], range_struct.origin[ 1 ], trigger_height );
                    thread debug::cylinder( range_struct.origin, cylinder_end, range_struct.radius, ( 1, 1, 1 ), 0.1 );
                }
            }
            
            waitframe();
        }
    }

#/
