// script_31c9376e30df21f9  (hash_31c9376e30df21f9.gscc) (size: 1750 Bytes / 0x6d6 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xb56013fa (3042972666)
// size ...... 1750 (0x6d6)
// includes .. 5   (offset: 0x64e)
// strings ... 8   (offset: 0x676)
// dev strs .. 0   (offset: 0x6d6)
// exports ... 8   (offset: 0x32e)
// cseg ...... 0xfd + 0x231 (0x32e)
// imports ... 17  (offset: 0x46e)
// animtree1 . 0   (offset: 0x6d6)
// animtree2 . 0   (offset: 0x6d6)
#using script_4ce55cfc81c444ad;
#using scripts\common\callbacks;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\zm\ztron\ztron_bonus_room;

#namespace namespace_26d6f64818f55f1c;

// Namespace namespace_26d6f64818f55f1c
// Params 0, eflags: 0x5
// Checksum 0x87a63d1b, Offset: 0x11b
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"hash_e1acea5fc1a3b107", undefined, undefined, &init );
}

// Namespace namespace_26d6f64818f55f1c
// Params 0
// Checksum 0x4dd32dcb, Offset: 0x13c
// Size: 0xa
function init()
{
    level thread function_ac078535c7a1e24a();
}

// Namespace namespace_26d6f64818f55f1c
// Params 0
// Checksum 0x24295470, Offset: 0x14e
// Size: 0x37
function function_ac078535c7a1e24a()
{
    level utility::flag_wait( "ztron_bonus_room_initialized" );
    room = ztron_bonus_room::function_3397393d2126b3fb( "plunder" );
    room.setupcallback = &poppysetup;
}

// Namespace namespace_26d6f64818f55f1c
// Params 1, eflags: 0x4
// Checksum 0x860f083a, Offset: 0x18d
// Size: 0x3f
function private onplayerspawned( params )
{
    player = params.player;
    player ztron_bonus_room::function_85a66f6a1d0a37ba( level.ztron.var_8a9067aa4cd65369 );
}

// Namespace namespace_26d6f64818f55f1c
// Params 1
// Checksum 0xe135b214, Offset: 0x1d4
// Size: 0xa9
function poppysetup( room )
{
    level endon( #"ztron_game_is_over", #"bonus_room_expired", #"bonus_room_exit_taken" );
    level waittill( #"hash_9d2492f7742c7564" );
    struct = utility::getstruct( "poppy_portrait_bubble", "targetname" );
    
    if ( isdefined( struct ) )
    {
        poppy = utility::function_1808878d1c511ce8( struct.origin, struct.angles );
    }
    
    level callback::add( #"player_spawned", &onplayerspawned );
    room thread roomcleanup( poppy );
    room thread function_7e37ba0caa64dc6d( poppy );
}

// Namespace namespace_26d6f64818f55f1c
// Params 1, eflags: 0x4
// Checksum 0x4b8282b1, Offset: 0x285
// Size: 0x51
function private roomcleanup( poppy )
{
    result = level utility::waittill_any_return( "bonus_room_expired", "ztron_game_is_over", "bonus_room_exit_taken" );
    level callback::remove( #"player_spawned", &onplayerspawned );
    
    if ( isdefined( poppy ) )
    {
        poppy delete();
    }
}

// Namespace namespace_26d6f64818f55f1c
// Params 1, eflags: 0x4
// Checksum 0xa66e92e1, Offset: 0x2de
// Size: 0x50
function private function_7e37ba0caa64dc6d( poppy )
{
    level endon( #"ztron_game_is_over", #"bonus_room_expired", #"bonus_room_exit_taken" );
    
    while ( isdefined( poppy ) )
    {
        level waittill( #"item_picked_up" );
        poppy ztron_dialog::function_7e3f6329d9afcdc1( "poppy_woof", 1 );
    }
}

