// script_15501a5730b81d52  (hash_15501a5730b81d52.gscc) (size: 1627 Bytes / 0x65b / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xc0f6c14 (202337300)
// size ...... 1627 (0x65b)
// includes .. 6   (offset: 0x5cf)
// strings ... 6   (offset: 0x5ff)
// dev strs .. 0   (offset: 0x65b)
// exports ... 10  (offset: 0x297)
// cseg ...... 0xa9 + 0x1ee (0x297)
// imports ... 15  (offset: 0x427)
// animtree1 . 0   (offset: 0x65b)
// animtree2 . 0   (offset: 0x65b)
#using scripts\common\system;
#using scripts\mp\zm\ztron\ztron_arena;
#using scripts\mp\zm\ztron\ztron_bonus_room;
#using scripts\mp\zm\ztron\ztron_challenge;
#using scripts\mp\zm\ztron\ztron_enemy;
#using scripts\mp\zm\ztron\ztron_weather;

#namespace ztron_arena_motel;

// Namespace ztron_arena_motel
// Params 0, eflags: 0x5
// Checksum 0xa2be39b8, Offset: 0xc7
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"motel", undefined, &arena_init, undefined );
}

// Namespace ztron_arena_motel
// Params 0
// Checksum 0xccdef81a, Offset: 0xe8
// Size: 0x9
function arena_init()
{
    thread arena_init_internal();
}

// Namespace ztron_arena_motel
// Params 0
// Checksum 0xa94e414c, Offset: 0xf9
// Size: 0x3b
function arena_init_internal()
{
    waittillframeend();
    ztron_arena::function_c61881897b87656d( "motel", &motel_init, &motel_shutdown );
    ztron_challenge::registerchallenge( "motel", "motel", &motel_challenge, &function_828ff22d78f6300f, 1, &function_da6bf194b11235f2 );
}

// Namespace ztron_arena_motel
// Params 0
// Checksum 0xe4edf052, Offset: 0x13c
// Size: 0x21
function motel_challenge()
{
    level.ztron.var_cd3b78b45db638d8 = ztron_enemy::function_96eea0d09d5640d1( "mangler" );
}

// Namespace ztron_arena_motel
// Params 0
// Checksum 0x51424afd, Offset: 0x165
// Size: 0x15
function function_828ff22d78f6300f()
{
    level.ztron.var_cd3b78b45db638d8 = undefined;
}

// Namespace ztron_arena_motel
// Params 0
// Checksum 0xaa91b38f, Offset: 0x182
// Size: 0x4a
function function_da6bf194b11235f2()
{
    chance = 2;
    
    if ( level.ztron.var_371903e5801e0e08 )
    {
        chance = 1;
    }
    
    if ( randomint( 100 ) < chance )
    {
        return level.ztron.var_cd3b78b45db638d8;
    }
}

// Namespace ztron_arena_motel
// Params 0
// Checksum 0xae0ca26c, Offset: 0x1d5
// Size: 0x72
function motel_special_event()
{
    level endon( #"ztron_game_is_over", #"arena_deactivated", #"arena_completed" );
    
    while ( true )
    {
        level waittill( #"round_about_to_start" );
        
        if ( level.ztron.arena_rounds_left == 2 && !level.ztron.var_95d8c7a469393957 )
        {
            ztron_bonus_room::function_b018ee630661e155( "side_scroller3" );
        }
    }
}

// Namespace ztron_arena_motel
// Params 0
// Checksum 0xa8d95650, Offset: 0x24f
// Size: 0x3e
function motel_init()
{
    ztron_weather::function_c66678f1a8379c69( "motel", "Snow", 5, "round_about_to_start", 12 );
    ztron_weather::function_c66678f1a8379c69( "motel", "Wetness", 5, "round_about_to_start", 12 );
    level thread motel_special_event();
}

// Namespace ztron_arena_motel
// Params 0
// Checksum 0x97a31ea4, Offset: 0x295
// Size: 0x2
function motel_shutdown()
{
    
}

