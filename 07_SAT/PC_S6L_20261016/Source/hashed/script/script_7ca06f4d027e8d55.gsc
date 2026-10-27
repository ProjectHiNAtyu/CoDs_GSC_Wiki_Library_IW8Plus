// script_7ca06f4d027e8d55  (hash_7ca06f4d027e8d55.gscc) (size: 3495 Bytes / 0xda7 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x72c7de3f (1925701183)
// size ...... 3495 (0xda7)
// includes .. 10  (offset: 0xc97)
// strings ... 14  (offset: 0xce7)
// dev strs .. 0   (offset: 0xda7)
// exports ... 14  (offset: 0x6f3)
// cseg ...... 0x13a + 0x5b9 (0x6f3)
// imports ... 31  (offset: 0x923)
// animtree1 . 0   (offset: 0xda7)
// animtree2 . 0   (offset: 0xda7)
#using script_cc7edad3d14d7bf;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\zm\ztron\ztron_arena;
#using scripts\mp\zm\ztron\ztron_bonus_room;
#using scripts\mp\zm\ztron\ztron_challenge;
#using scripts\mp\zm\ztron\ztron_enemy;
#using scripts\mp\zm\ztron\ztron_slayer;
#using scripts\mp\zm\ztron\ztron_utility;
#using scripts\mp\zm\ztron\ztron_vfx;

#namespace ztron_arena_homestead;

// Namespace ztron_arena_homestead
// Params 0, eflags: 0x5
// Checksum 0xd575e34b, Offset: 0x158
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"homestead", undefined, &arena_init, undefined );
}

// Namespace ztron_arena_homestead
// Params 0
// Checksum 0xfb7a6ac2, Offset: 0x179
// Size: 0x9
function arena_init()
{
    thread arena_init_internal();
}

// Namespace ztron_arena_homestead
// Params 0
// Checksum 0x80d83858, Offset: 0x18a
// Size: 0x62
function arena_init_internal()
{
    waittillframeend();
    ztron_arena::function_c61881897b87656d( "homestead", &homestead_init, &homestead_shutdown );
    ztron_challenge::registerchallenge( "homestead", "homestead", &homestead_challenge, &function_2663fc1404e347a, 1, &function_ff7484a0ad49755b );
    
    if ( !level.ztron.var_371903e5801e0e08 )
    {
        ztron_arena::function_37c3ad87b4c84a3f( "homestead", 46, 8 );
    }
}

// Namespace ztron_arena_homestead
// Params 0
// Checksum 0xe2ebe88c, Offset: 0x1f4
// Size: 0x60
function homestead_init()
{
    level.ztron.var_19104e5e9d7f256a = &function_b8ca4a67e46eaaa6;
    ztron_util::slickclipsave();
    thread slickclipwatch();
    ztron_enemy::function_35cd7cda9fbadf39( "pole_zombie", "ztron_difficulty_new_ai_pole_hauler" );
    level thread homestead_special_event();
    
    if ( level.ztron.var_371903e5801e0e08 )
    {
        level thread function_56eac2e5991e92e4();
    }
}

// Namespace ztron_arena_homestead
// Params 0
// Checksum 0x17d03ee6, Offset: 0x25c
// Size: 0x6b
function homestead_shutdown()
{
    ztron_util::slickcliprestore();
    
    if ( isdefined( level.ztron.weather.currentfx ) )
    {
        level.ztron.weather.currentfx = ztron_vfx::stopfx( level.ztron.weather.currentfx );
    }
}

// Namespace ztron_arena_homestead
// Params 0
// Checksum 0x94ba6de, Offset: 0x2cf
// Size: 0xe6
function homestead_special_event()
{
    level endon( #"ztron_game_is_over", #"arena_deactivated", #"arena_completed" );
    
    while ( true )
    {
        level waittill( #"round_about_to_start" );
        waittillframeend();
        level.ztron.var_d5a46a191654f0dd = [ "top", "bottom", "left" ];
        
        if ( level.ztron.arena_rounds_left == 2 )
        {
            if ( level.ztron.var_371903e5801e0e08 )
            {
                ztron_bonus_room::function_b018ee630661e155( "fall_100" );
                level.ztron.var_d5a46a191654f0dd = [ "right" ];
                continue;
            }
            
            if ( !level.ztron.var_95d8c7a469393957 )
            {
                ztron_bonus_room::function_b018ee630661e155( ztron_bonus_room::function_cc95fac45228eccd() );
            }
        }
    }
}

// Namespace ztron_arena_homestead
// Params 0
// Checksum 0x35b3df57, Offset: 0x3bd
// Size: 0x161
function slickclipwatch()
{
    self notify( #"hash_e78a030a9f46fef1" );
    self endon( #"hash_e78a030a9f46fef1" );
    level endon( #"ztron_game_is_over", #"arena_deactivated", #"arena_completed" );
    var_aa0cce5602cde086 = level.ztron.weather.var_aa0cce5602cde086[ "Snow" ];
    
    while ( true )
    {
        level waittill( #"round_about_to_start" );
        
        if ( randomint( 100 ) < 40 )
        {
            level.ztron.weather.currentfx = ztron_vfx::function_574a3236c59da7d8( "ztron_weather_" + var_aa0cce5602cde086.type, level.ztron.active_arena.center.origin );
        }
        
        ztron_util::slickclipsetup();
        level waittill( #"arena_round_leaving" );
        
        if ( isdefined( level.ztron.weather.currentfx ) )
        {
            level.ztron.weather.currentfx = ztron_vfx::stopfx( level.ztron.weather.currentfx );
        }
        
        ztron_util::slickcliprestore();
    }
}

// Namespace ztron_arena_homestead
// Params 0
// Checksum 0x6f4e6d2, Offset: 0x526
// Size: 0x21
function homestead_challenge()
{
    level.ztron.var_cd3b78b45db638d8 = ztron_enemy::function_96eea0d09d5640d1( "pole_zombie" );
}

// Namespace ztron_arena_homestead
// Params 0
// Checksum 0x166e65f7, Offset: 0x54f
// Size: 0x15
function function_2663fc1404e347a()
{
    level.ztron.var_cd3b78b45db638d8 = undefined;
}

// Namespace ztron_arena_homestead
// Params 0
// Checksum 0xa3839060, Offset: 0x56c
// Size: 0x57
function function_ff7484a0ad49755b()
{
    if ( ztron_hazard_electric_pole::function_52058b3337155884() >= 40 )
    {
        return;
    }
    
    chance = 10;
    
    if ( level.ztron.var_371903e5801e0e08 )
    {
        chance = 5;
    }
    
    if ( randomint( 100 ) < chance )
    {
        return level.ztron.var_cd3b78b45db638d8;
    }
}

// Namespace ztron_arena_homestead
// Params 0
// Checksum 0xdbf0d8eb, Offset: 0x5cc
// Size: 0x41
function function_702545b3c5f5a0b1()
{
    level endon( #"ztron_game_is_over" );
    level utility::flag_set( "arena_hold_teleporter" );
    level waittill( #"hash_824e1ffce3b44832" );
    level notify( #"kill_teleporter" );
    level utility::flag_clear( "arena_hold_teleporter" );
}

// Namespace ztron_arena_homestead
// Params 0
// Checksum 0xcdf9520f, Offset: 0x615
// Size: 0x7d
function function_56eac2e5991e92e4()
{
    if ( level.ztron.blitzmode )
    {
        return;
    }
    
    level endon( #"ztron_game_is_over" );
    note = level utility::waittill_any_return( "teleporter_being_opened" );
    level.ztron.var_3678ff7453f3c5cf = "slayer_arena_activated";
    level thread function_702545b3c5f5a0b1();
    level thread ztron_slayer::function_1485aa63334f37b0( "gamma", "homestead" );
    level waittill( #"slayer_intro_done" );
}

// Namespace ztron_arena_homestead
// Params 1, eflags: 0x4
// Checksum 0x6b96629f, Offset: 0x69a
// Size: 0x59
function private function_b8ca4a67e46eaaa6( mode )
{
    switch ( mode )
    {
        case 1:
            return 0.8;
        case 2:
            return 1.1;
        case 3:
            return 1.7;
        default:
            return;
    }
}

