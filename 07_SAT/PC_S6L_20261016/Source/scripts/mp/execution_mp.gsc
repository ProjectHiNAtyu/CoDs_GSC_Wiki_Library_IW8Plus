// scripts\mp\execution_mp.gsc  (hash_70e69a9871881054.gscc) (size: 551 Bytes / 0x227 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x9d0e3cef (2634956015)
// size ...... 551 (0x227)
// includes .. 3   (offset: 0x20f)
// strings ... 0   (offset: 0x227)
// dev strs .. 0   (offset: 0x227)
// exports ... 2   (offset: 0xeb)
// cseg ...... 0x58 + 0x93 (0xeb)
// imports ... 7   (offset: 0x13b)
// animtree1 . 0   (offset: 0x227)
// animtree2 . 0   (offset: 0x227)
#using scripts\common\callbacks;
#using scripts\mp\common\utility\game;
#using scripts\mp\execution;

#namespace execution_mp;

// Namespace execution_mp
// Params 0
// Checksum 0xa7f5f027, Offset: 0x76
// Size: 0x75
function execution_mp_init()
{
    callback::add( #"player_on_ladder_begin", &execution::function_883b362fffe1de4f );
    callback::add( #"player_on_ladder_end", &execution::function_b003bfce85514f07 );
    callback::add( #"player_spawned", &execution::playerspawned );
    
    if ( !game_utility_mp::lpcfeaturegated() )
    {
        callback::add( #"hash_1bf3199fda4b9841", &execution::function_74d200e78e2d431f );
        callback::add( #"hash_48d4e39d6de3f7f1", &execution::function_e164d947deb2d497 );
    }
}

