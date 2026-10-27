// script_3aea532e8da6b592  (hash_3aea532e8da6b592.gscc) (size: 1075 Bytes / 0x433 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x38e305d (59650141)
// size ...... 1075 (0x433)
// includes .. 4   (offset: 0x3fb)
// strings ... 2   (offset: 0x41b)
// dev strs .. 0   (offset: 0x433)
// exports ... 5   (offset: 0x21b)
// cseg ...... 0x85 + 0x196 (0x21b)
// imports ... 10  (offset: 0x2e3)
// animtree1 . 0   (offset: 0x433)
// animtree2 . 0   (offset: 0x433)
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\zm\ztron\ztron_bonus_room;
#using scripts\mp\zm\ztron\ztron_item;

#namespace namespace_203db82c159500a7;

// Namespace namespace_203db82c159500a7
// Params 0, eflags: 0x5
// Checksum 0x1a63bc1d, Offset: 0xa3
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"hash_2fb7de801b209af4", undefined, undefined, &init );
}

// Namespace namespace_203db82c159500a7
// Params 0
// Checksum 0xc0722454, Offset: 0xc4
// Size: 0xa
function init()
{
    level thread function_9288225f201b79f9();
}

// Namespace namespace_203db82c159500a7
// Params 0
// Checksum 0x4299765f, Offset: 0xd6
// Size: 0xb4
function function_9288225f201b79f9()
{
    level utility::flag_wait( "ztron_bonus_room_initialized" );
    var_a8d8980c65b4b0de = ztron_bonus_room::function_98dedbfc79dc3572( "boom_room" );
    
    if ( var_a8d8980c65b4b0de.size > 0 )
    {
        foreach ( room in var_a8d8980c65b4b0de )
        {
            room.var_6a5f366ee6f9f320 = 1;
            room.setupcallback = &function_4af481739ac3ab43;
        }
    }
}

// Namespace namespace_203db82c159500a7
// Params 1
// Checksum 0x9fd4b994, Offset: 0x192
// Size: 0x89
function function_4af481739ac3ab43( room )
{
    level endon( #"ztron_game_is_over", #"bonus_room_expired", #"bonus_room_exit_taken" );
    level waittill( #"hash_9d2492f7742c7564" );
    boomcount = ( level.players.size - 1 ) * 3 + 4;
    var_1d7772be903c1baa = arrayrandomize( room.var_8260f0f996dc9927 );
    var_1d7772be903c1baa = utility::array_slice( var_1d7772be903c1baa, 0, boomcount + 1 );
    room ztron_item::function_6607be6e510e8f54( var_1d7772be903c1baa );
}

