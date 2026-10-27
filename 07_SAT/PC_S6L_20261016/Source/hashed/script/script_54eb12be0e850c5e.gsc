// script_54eb12be0e850c5e  (hash_54eb12be0e850c5e.gscc) (size: 1467 Bytes / 0x5bb / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xf929c26 (261266470)
// size ...... 1467 (0x5bb)
// includes .. 5   (offset: 0x567)
// strings ... 3   (offset: 0x58f)
// dev strs .. 0   (offset: 0x5bb)
// exports ... 10  (offset: 0x24f)
// cseg ...... 0x89 + 0x1c6 (0x24f)
// imports ... 14  (offset: 0x3df)
// animtree1 . 0   (offset: 0x5bb)
// animtree2 . 0   (offset: 0x5bb)
#using scripts\common\system;
#using scripts\mp\zm\ztron\ztron_arena;
#using scripts\mp\zm\ztron\ztron_bonus_room;
#using scripts\mp\zm\ztron\ztron_challenge;
#using scripts\mp\zm\ztron\ztron_enemy;

#namespace ztron_arena_firebase;

// Namespace ztron_arena_firebase
// Params 0, eflags: 0x5
// Checksum 0x6abc2f69, Offset: 0xa7
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"firebase", undefined, &arena_init, undefined );
}

// Namespace ztron_arena_firebase
// Params 0
// Checksum 0xe82429e5, Offset: 0xc8
// Size: 0x9
function arena_init()
{
    thread arena_init_internal();
}

// Namespace ztron_arena_firebase
// Params 0
// Checksum 0x2fcdb1c3, Offset: 0xd9
// Size: 0x3b
function arena_init_internal()
{
    waittillframeend();
    ztron_arena::function_c61881897b87656d( "firebase", &firebase_init, &firebase_shutdown );
    ztron_challenge::registerchallenge( "firebase", "firebase", &firebase_challenge, &function_a0799fdf9dfb17ab, 1, &function_6d4265735593cba6 );
}

// Namespace ztron_arena_firebase
// Params 0
// Checksum 0x8dbe9333, Offset: 0x11c
// Size: 0xa
function firebase_init()
{
    level thread firebase_special_event();
}

// Namespace ztron_arena_firebase
// Params 0
// Checksum 0x26562b62, Offset: 0x12e
// Size: 0x72
function firebase_special_event()
{
    level endon( #"ztron_game_is_over", #"arena_deactivated", #"arena_completed" );
    
    while ( true )
    {
        level waittill( #"round_about_to_start" );
        
        if ( level.ztron.arena_rounds_left == 2 && !level.ztron.var_95d8c7a469393957 )
        {
            ztron_bonus_room::function_b018ee630661e155( "side_scroller2" );
        }
    }
}

// Namespace ztron_arena_firebase
// Params 0
// Checksum 0x4eaba995, Offset: 0x1a8
// Size: 0xe
function firebase_shutdown()
{
    self notify( #"firebase_shutdown" );
}

// Namespace ztron_arena_firebase
// Params 0
// Checksum 0x9549a4c0, Offset: 0x1be
// Size: 0x21
function firebase_challenge()
{
    level.ztron.var_cd3b78b45db638d8 = ztron_enemy::function_96eea0d09d5640d1( "barreler_zombie" );
}

// Namespace ztron_arena_firebase
// Params 0
// Checksum 0x7b6a8bb, Offset: 0x1e7
// Size: 0x15
function function_a0799fdf9dfb17ab()
{
    level.ztron.var_cd3b78b45db638d8 = undefined;
}

// Namespace ztron_arena_firebase
// Params 0
// Checksum 0xb3ceedf6, Offset: 0x204
// Size: 0x4a
function function_6d4265735593cba6()
{
    chance = 35;
    
    if ( level.ztron.var_371903e5801e0e08 )
    {
        chance = 20;
    }
    
    if ( randomint( 100 ) < chance )
    {
        return level.ztron.var_cd3b78b45db638d8;
    }
}

