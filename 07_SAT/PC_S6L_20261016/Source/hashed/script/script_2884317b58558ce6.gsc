// script_2884317b58558ce6  (hash_2884317b58558ce6.gscc) (size: 3023 Bytes / 0xbcf / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x859a0d9a (2241465754)
// size ...... 3023 (0xbcf)
// includes .. 9   (offset: 0xa83)
// strings ... 19  (offset: 0xacb)
// dev strs .. 0   (offset: 0xbcf)
// exports ... 12  (offset: 0x5e3)
// cseg ...... 0x173 + 0x470 (0x5e3)
// imports ... 25  (offset: 0x7c3)
// animtree1 . 0   (offset: 0xbcf)
// animtree2 . 0   (offset: 0xbcf)
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\zm\ztron\ztron_arena;
#using scripts\mp\zm\ztron\ztron_bonus_room;
#using scripts\mp\zm\ztron\ztron_challenge;
#using scripts\mp\zm\ztron\ztron_enemy;
#using scripts\mp\zm\ztron\ztron_main;
#using scripts\mp\zm\ztron\ztron_slayer;
#using scripts\mp\zm\ztron\ztron_weather;

#namespace ztron_arena_graveyard;

// Namespace ztron_arena_graveyard
// Params 0, eflags: 0x5
// Checksum 0x530ca4b0, Offset: 0x191
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"graveyard", undefined, &arena_init, undefined );
}

// Namespace ztron_arena_graveyard
// Params 0
// Checksum 0xe4ac05de, Offset: 0x1b2
// Size: 0x9
function arena_init()
{
    thread arena_init_internal();
}

// Namespace ztron_arena_graveyard
// Params 0
// Checksum 0x1a9e8f36, Offset: 0x1c3
// Size: 0x61
function arena_init_internal()
{
    waittillframeend();
    ztron_arena::function_c61881897b87656d( "graveyard", &graveyard_init, &graveyard_shutdown );
    ztron_challenge::registerchallenge( "graveyard", "graveyard", &graveyard_challenge, &function_bfbc3b4f7a1b1487, 1, &function_2f9b4f78cc8c492a );
    
    if ( level.ztron.var_371903e5801e0e08 )
    {
        ztron_arena::function_37c3ad87b4c84a3f( "graveyard", 40, 4 );
    }
}

// Namespace ztron_arena_graveyard
// Params 0
// Checksum 0x755ff5f5, Offset: 0x22c
// Size: 0x21
function graveyard_challenge()
{
    level.ztron.var_cd3b78b45db638d8 = ztron_enemy::function_96eea0d09d5640d1( "ravager" );
}

// Namespace ztron_arena_graveyard
// Params 0
// Checksum 0x7b8761dc, Offset: 0x255
// Size: 0x15
function function_bfbc3b4f7a1b1487()
{
    level.ztron.var_cd3b78b45db638d8 = undefined;
}

// Namespace ztron_arena_graveyard
// Params 0
// Checksum 0x78773c6e, Offset: 0x272
// Size: 0x4a
function function_2f9b4f78cc8c492a()
{
    chance = 15;
    
    if ( level.ztron.var_371903e5801e0e08 )
    {
        chance = 7;
    }
    
    if ( randomint( 100 ) < chance )
    {
        return level.ztron.var_cd3b78b45db638d8;
    }
}

// Namespace ztron_arena_graveyard
// Params 0
// Checksum 0xe6d5e95, Offset: 0x2c5
// Size: 0x42
function graveyard_init()
{
    ztron_weather::function_c66678f1a8379c69( "graveyard", "Wetness", 10, "round_about_to_start" );
    ztron_weather::function_c66678f1a8379c69( "graveyard", "Snow", 15, "round_about_to_start" );
    level thread graveyard_special_event();
    level thread function_de2bd5cb01e66839();
}

// Namespace ztron_arena_graveyard
// Params 0
// Checksum 0xf9e5b1dc, Offset: 0x30f
// Size: 0x7e
function graveyard_shutdown()
{
    level.ztron.var_d5a46a191654f0dd = undefined;
    
    if ( level.ztron.var_371903e5801e0e08 )
    {
        level.ztron.var_bdbf6cf2011e0b2d = ztron_arena::function_973956bb5a6e60f7( "ritual" ).id;
        level.ztron.var_a58d52a0faa75a57[ level.ztron.var_a58d52a0faa75a57.size ] = 0;
    }
}

// Namespace ztron_arena_graveyard
// Params 0
// Checksum 0xe39afbb5, Offset: 0x395
// Size: 0xa8
function graveyard_special_event()
{
    level endon( #"ztron_game_is_over", #"arena_deactivated", #"arena_completed" );
    
    while ( true )
    {
        level waittill( #"round_about_to_start" );
        level.ztron.var_d5a46a191654f0dd = [ "top", "right", "bottom" ];
        
        if ( level.ztron.arena_rounds_left == 2 )
        {
            ztron_bonus_room::function_b018ee630661e155( "shadow_vault" );
            level.ztron.var_d5a46a191654f0dd = [ "left" ];
        }
    }
}

// Namespace ztron_arena_graveyard
// Params 0
// Checksum 0x6f9a6fda, Offset: 0x445
// Size: 0xad
function function_bb30483e4f1d47fe()
{
    level endon( #"ztron_game_is_over" );
    level utility::flag_set( "arena_hold_teleporter" );
    
    if ( !level.ztron.var_95d8c7a469393957 )
    {
        level.ztron.var_3678ff7453f3c5cf = "slayer_arena_activated";
        level waittill( #"hash_824e1ffce3b44832" );
        level notify( #"kill_teleporter" );
    }
    else
    {
        level.ztron.var_3678ff7453f3c5cf = "slayer_intro_done";
        level waittill( #"slayer_intro_done" );
        level.ztron.var_3678ff7453f3c5cf = undefined;
    }
    
    level utility::flag_clear( "arena_hold_teleporter" );
}

// Namespace ztron_arena_graveyard
// Params 0
// Checksum 0x45e79b36, Offset: 0x4fa
// Size: 0xe9
function function_de2bd5cb01e66839()
{
    if ( level.ztron.blitzmode )
    {
        return;
    }
    
    if ( level.ztron.var_95d8c7a469393957 )
    {
        level.ztron.var_d0972e445894306d = 1200;
        return;
    }
    
    level endon( #"ztron_game_is_over", #"arena_deactivated", #"arena_completed" );
    note = level utility::waittill_any_return( "teleporter_being_opened" );
    level thread function_bb30483e4f1d47fe();
    level thread ztron_slayer::function_1485aa63334f37b0( "prototype", "graveyard" );
    level waittill( #"slayer_intro_done" );
    
    if ( level.ztron.cabinetmode && getdvarint( @"hash_9681219e9d760ed8", 1 ) == 1 )
    {
        thread ztron_main::endgame( "tie", game[ "end_reason" ][ "round_limit_reached" ] );
    }
}

