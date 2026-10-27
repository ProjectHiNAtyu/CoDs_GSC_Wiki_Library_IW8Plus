// scripts\common\ai\aitypes\zombie_deathworm\zombie_deathworm_snake_bite.gsc  (hash_2dbcefdbba9b4522.gscc) (size: 355 Bytes / 0x163 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x57a3737f (1470329727)
// size ...... 355 (0x163)
// includes .. 1   (offset: 0x15b)
// strings ... 0   (offset: 0x163)
// dev strs .. 0   (offset: 0x163)
// exports ... 2   (offset: 0xd3)
// cseg ...... 0x58 + 0x7b (0xd3)
// imports ... 2   (offset: 0x123)
// animtree1 . 0   (offset: 0x163)
// animtree2 . 0   (offset: 0x163)
#using scripts\common\ai\aitypes\zombie_deathworm\zombie_deathworm_arena;

#namespace zombie_deathworm_snake_bite;

// Namespace zombie_deathworm_snake_bite
// Params 1
// Checksum 0xbdff1ce3, Offset: 0x76
// Size: 0x5c
function shouldsnakebite( taskid )
{
    target = self.enemy;
    
    if ( !isalive( target ) )
    {
        return anim.failure;
    }
    
    if ( namespace_473bdc208d3e708a::function_c1592b3e647c3368( target.origin ) )
    {
        return anim.failure;
    }
    
    return anim.success;
}

