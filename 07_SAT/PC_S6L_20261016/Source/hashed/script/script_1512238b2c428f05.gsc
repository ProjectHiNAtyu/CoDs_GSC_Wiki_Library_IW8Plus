// script_1512238b2c428f05  (hash_1512238b2c428f05.gscc) (size: 2681 Bytes / 0xa79 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x3b70cfa4 (997248932)
// size ...... 2681 (0xa79)
// includes .. 8   (offset: 0x97d)
// strings ... 14  (offset: 0x9bd)
// dev strs .. 0   (offset: 0xa79)
// exports ... 12  (offset: 0x54d)
// cseg ...... 0x12f + 0x41e (0x54d)
// imports ... 21  (offset: 0x72d)
// animtree1 . 0   (offset: 0xa79)
// animtree2 . 0   (offset: 0xa79)
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\zm\ztron\ztron_arena;
#using scripts\mp\zm\ztron\ztron_bonus_room;
#using scripts\mp\zm\ztron\ztron_challenge;
#using scripts\mp\zm\ztron\ztron_enemy;
#using scripts\mp\zm\ztron\ztron_slayer;
#using scripts\mp\zm\ztron\ztron_weather;

#namespace ztron_arena_melting;

// Namespace ztron_arena_melting
// Params 0, eflags: 0x5
// Checksum 0x939c0c21, Offset: 0x14d
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"melting", undefined, &arena_init, undefined );
}

// Namespace ztron_arena_melting
// Params 0
// Checksum 0x6c08110, Offset: 0x16e
// Size: 0x9
function arena_init()
{
    thread arena_init_internal();
}

// Namespace ztron_arena_melting
// Params 0
// Checksum 0xefd179ef, Offset: 0x17f
// Size: 0x3b
function arena_init_internal()
{
    waittillframeend();
    ztron_arena::function_c61881897b87656d( "melting", &melting_init, &melting_shutdown );
    ztron_challenge::registerchallenge( "melting", "melting", &melting_challenge, &function_9e61ec460c9e09d6, 1, &function_cbfbb3eccfd8051f );
}

// Namespace ztron_arena_melting
// Params 0
// Checksum 0x68ce9e93, Offset: 0x1c2
// Size: 0x2a
function melting_init()
{
    ztron_weather::function_c66678f1a8379c69( "melting", "Snow", 5, "round_about_to_start" );
    level thread melting_special_event();
    level thread function_d635346ff928f948();
}

// Namespace ztron_arena_melting
// Params 0
// Checksum 0xe7795f4, Offset: 0x1f4
// Size: 0xad
function function_8d8e2b4553427315()
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

// Namespace ztron_arena_melting
// Params 0
// Checksum 0x41edea37, Offset: 0x2a9
// Size: 0x92
function function_d635346ff928f948()
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
    
    level endon( #"ztron_game_is_over" );
    note = level utility::waittill_any_return( "teleporter_being_opened" );
    level thread function_8d8e2b4553427315();
    level thread ztron_slayer::function_1485aa63334f37b0( "gamma", "melting" );
    level waittill( #"slayer_intro_done" );
}

// Namespace ztron_arena_melting
// Params 0
// Checksum 0x197a87d2, Offset: 0x343
// Size: 0xa9
function melting_special_event()
{
    level endon( #"ztron_game_is_over", #"arena_deactivated", #"arena_completed" );
    
    while ( true )
    {
        level waittill( #"round_about_to_start" );
        waittillframeend();
        level.ztron.var_d5a46a191654f0dd = [ "top", "right", "left" ];
        
        if ( level.ztron.arena_rounds_left == 2 )
        {
            ztron_bonus_room::function_b018ee630661e155( "fall_100" );
            level.ztron.var_d5a46a191654f0dd = [ "bottom" ];
        }
    }
}

// Namespace ztron_arena_melting
// Params 0
// Checksum 0x2267881, Offset: 0x3f4
// Size: 0x2
function melting_shutdown()
{
    
}

// Namespace ztron_arena_melting
// Params 0
// Checksum 0x575b8337, Offset: 0x3fe
// Size: 0x73
function melting_challenge()
{
    level.ztron.var_cd3b78b45db638d8 = ztron_enemy::function_96eea0d09d5640d1( "elder_disciple" );
    level.ztron.var_37084fa69046d3b4 = 4;
    level.ztron.challenge_delay = gettime() + 10000;
    level.ztron.var_cd3b78b45db638d8.var_e95772ef2aa376a0 = 1;
}

// Namespace ztron_arena_melting
// Params 0
// Checksum 0x5aea7f7c, Offset: 0x479
// Size: 0x45
function function_9e61ec460c9e09d6()
{
    level.ztron.var_cd3b78b45db638d8.var_e95772ef2aa376a0 = undefined;
    level.ztron.var_cd3b78b45db638d8 = undefined;
    level.ztron.var_37084fa69046d3b4 = undefined;
}

// Namespace ztron_arena_melting
// Params 0
// Checksum 0x60f040c6, Offset: 0x4c6
// Size: 0x86
function function_cbfbb3eccfd8051f()
{
    time = gettime();
    
    if ( level.ztron.var_37084fa69046d3b4 > 0 && time > level.ztron.challenge_delay )
    {
        level.ztron.challenge_delay = time + 15000;
        level.ztron.var_37084fa69046d3b4--;
        return level.ztron.var_cd3b78b45db638d8;
    }
}

