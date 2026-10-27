// script_6bd5de6a1d58bba6  (hash_6bd5de6a1d58bba6.gscc) (size: 3592 Bytes / 0xe08 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x2e64832a (778339114)
// size ...... 3592 (0xe08)
// includes .. 9   (offset: 0xce0)
// strings ... 16  (offset: 0xd28)
// dev strs .. 0   (offset: 0xe08)
// exports ... 13  (offset: 0x78c)
// cseg ...... 0x17c + 0x610 (0x78c)
// imports ... 30  (offset: 0x994)
// animtree1 . 0   (offset: 0xe08)
// animtree2 . 0   (offset: 0xe08)
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\zm\ztron\ztron_arena;
#using scripts\mp\zm\ztron\ztron_bonus_room;
#using scripts\mp\zm\ztron\ztron_challenge;
#using scripts\mp\zm\ztron\ztron_enemy;
#using scripts\mp\zm\ztron\ztron_main;
#using scripts\mp\zm\ztron\ztron_slayer;
#using scripts\mp\zm\ztron\ztron_weather;

#namespace ztron_arena_nuketown;

// Namespace ztron_arena_nuketown
// Params 0, eflags: 0x5
// Checksum 0xfa657974, Offset: 0x19a
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"nuketown", undefined, &arena_init, undefined );
}

// Namespace ztron_arena_nuketown
// Params 0
// Checksum 0xb1a35880, Offset: 0x1bb
// Size: 0x9
function arena_init()
{
    thread arena_init_internal();
}

// Namespace ztron_arena_nuketown
// Params 0
// Checksum 0x70adc082, Offset: 0x1cc
// Size: 0x62
function arena_init_internal()
{
    waittillframeend();
    ztron_arena::function_c61881897b87656d( "nuketown", &nuketown_init, &nuketown_shutdown );
    ztron_challenge::registerchallenge( "nuketown", "nuketown", &nuketown_challenge, &function_20dcb59d4c1a8813, 1, &function_e7f38b624777440e );
    
    if ( !level.ztron.var_371903e5801e0e08 )
    {
        ztron_arena::function_37c3ad87b4c84a3f( "nuketown", 46, 8 );
    }
}

// Namespace ztron_arena_nuketown
// Params 0
// Checksum 0x1c458f2d, Offset: 0x236
// Size: 0x1e4
function nuketown_init()
{
    ztron_weather::function_c66678f1a8379c69( "nuketown", "Snow", 15, "round_about_to_start" );
    ztron_enemy::function_35cd7cda9fbadf39( "mannequin", "ztron_difficulty_new_ai_mannequin" );
    level.ztron.var_19104e5e9d7f256a = &function_b8ca4a67e46eaaa6;
    level thread nuketown_special_event();
    
    if ( level.ztron.var_371903e5801e0e08 )
    {
        level thread function_dcfc5fcfae20d0ad();
    }
    
    level waittill( #"round_about_to_start" );
    var_a320a5e1b2b0ec6c = level.ztron.arena_rounds_left == 4;
    
    if ( var_a320a5e1b2b0ec6c )
    {
        level.ztron.mannequinchallenge = 1;
        level.ztron.var_3e4860b8fe3e171 = 0;
        var_d33127d36fecf768 = utility::getstructarray( "nuketown_inplace_spot", "targetname" );
        
        if ( var_d33127d36fecf768.size > 0 )
        {
            var_71c2b26838e90f44 = ztron_enemy::function_96eea0d09d5640d1( "mannequin" );
            
            foreach ( spawnspot in var_d33127d36fecf768 )
            {
                ztron_enemy::function_77e1bf43b991b4a( var_71c2b26838e90f44, 1, spawnspot.origin, 0, undefined, level.players[ 0 ], undefined, level.ztron.active_arena, undefined, -1, 1, 1 );
                
                if ( level.ztron.var_371903e5801e0e08 )
                {
                    level.ztron.var_3e4860b8fe3e171++;
                }
            }
        }
    }
    
    level.ztron.mannequinchallenge = 0;
}

// Namespace ztron_arena_nuketown
// Params 0
// Checksum 0x366c12bc, Offset: 0x422
// Size: 0x6b
function nuketown_shutdown()
{
    if ( level.ztron.var_371903e5801e0e08 )
    {
        level.ztron.var_bdbf6cf2011e0b2d = ztron_arena::function_973956bb5a6e60f7( "ritual" ).id;
        level.ztron.var_a58d52a0faa75a57[ level.ztron.var_a58d52a0faa75a57.size ] = 0;
    }
}

// Namespace ztron_arena_nuketown
// Params 0
// Checksum 0x41936c, Offset: 0x495
// Size: 0x5a
function nuketown_special_event()
{
    level endon( #"ztron_game_is_over", #"arena_deactivated", #"arena_completed" );
    
    while ( true )
    {
        level waittill( #"round_about_to_start" );
        
        if ( level.ztron.arena_rounds_left == 2 )
        {
            ztron_bonus_room::function_b018ee630661e155( "nuke_vault" );
        }
    }
}

// Namespace ztron_arena_nuketown
// Params 0
// Checksum 0xd304200e, Offset: 0x4f7
// Size: 0x41
function function_108896ccc7f72b32()
{
    level endon( #"ztron_game_is_over" );
    level utility::flag_set( "arena_hold_teleporter" );
    level waittill( #"hash_824e1ffce3b44832" );
    level notify( #"kill_teleporter" );
    level utility::flag_clear( "arena_hold_teleporter" );
}

// Namespace ztron_arena_nuketown
// Params 0
// Checksum 0x3fe761e5, Offset: 0x540
// Size: 0xd4
function function_dcfc5fcfae20d0ad()
{
    if ( level.ztron.blitzmode )
    {
        return;
    }
    
    level endon( #"ztron_game_is_over", #"arena_deactivated", #"arena_completed" );
    note = level utility::waittill_any_return( "teleporter_being_opened" );
    level.ztron.var_3678ff7453f3c5cf = "slayer_arena_activated";
    level thread function_108896ccc7f72b32();
    level thread ztron_slayer::function_1485aa63334f37b0( "prototype", "nuketown" );
    level waittill( #"slayer_intro_done" );
    
    if ( level.ztron.cabinetmode && getdvarint( @"hash_9681219e9d760ed8", 1 ) == 1 )
    {
        thread ztron_main::endgame( "tie", game[ "end_reason" ][ "round_limit_reached" ] );
    }
}

// Namespace ztron_arena_nuketown
// Params 0
// Checksum 0xb4fb3e69, Offset: 0x61c
// Size: 0xb1
function nuketown_challenge()
{
    level endon( #"arena_completed", #"ztron_game_is_over" );
    level.ztron.var_cd3b78b45db638d8 = ztron_enemy::function_96eea0d09d5640d1( "mannequin" );
    
    if ( level.ztron.var_371903e5801e0e08 && level.ztron.var_3e4860b8fe3e171 )
    {
        level.ztron.var_91517987ca332e2a += level.ztron.var_3e4860b8fe3e171;
    }
    
    level.ztron.var_3e4860b8fe3e171 = undefined;
}

// Namespace ztron_arena_nuketown
// Params 1, eflags: 0x4
// Checksum 0xa8a19102, Offset: 0x6d5
// Size: 0x47
function private function_b8ca4a67e46eaaa6( mode )
{
    switch ( mode )
    {
        case 1:
            return 0.65;
        case 2:
            return 1.2;
        default:
            return;
    }
}

// Namespace ztron_arena_nuketown
// Params 0
// Checksum 0x476c1d53, Offset: 0x724
// Size: 0x15
function function_20dcb59d4c1a8813()
{
    level.ztron.var_cd3b78b45db638d8 = undefined;
}

// Namespace ztron_arena_nuketown
// Params 0
// Checksum 0x47486e8a, Offset: 0x741
// Size: 0x4a
function function_e7f38b624777440e()
{
    chance = 20;
    
    if ( level.ztron.var_371903e5801e0e08 )
    {
        chance = 6;
    }
    
    if ( randomint( 100 ) < chance )
    {
        return level.ztron.var_cd3b78b45db638d8;
    }
}

