// scripts\common\ai\aitypes\shared\zombie\zombie_pain.gsc  (hash_4a772174526029cf.gscc) (size: 313 Bytes / 0x139 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x2123bf5e (555990878)
// size ...... 313 (0x139)
// includes .. 1   (offset: 0x125)
// strings ... 1   (offset: 0x12d)
// dev strs .. 0   (offset: 0x139)
// exports ... 2   (offset: 0xb9)
// cseg ...... 0x63 + 0x56 (0xb9)
// imports ... 1   (offset: 0x109)
// animtree1 . 0   (offset: 0x139)
// animtree2 . 0   (offset: 0x139)
#using scripts\common\utility;

#namespace zombie_pain;

// Namespace zombie_pain
// Params 2
// Checksum 0x1a2ea90, Offset: 0x81
// Size: 0x37
function function_3f56867e574958e9( taskid, params )
{
    if ( !utility::ent_flag( "in_pain" ) )
    {
        return anim.failure;
    }
    
    return anim.success;
}

