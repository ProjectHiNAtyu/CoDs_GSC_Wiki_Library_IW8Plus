// scripts\common\ai\aitypes\zombie_deathworm\zombie_deathworm_spittle.gsc  (hash_399536471bc64afc.gscc) (size: 267 Bytes / 0x10b / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xad4dc47f (2907554943)
// size ...... 267 (0x10b)
// includes .. 0   (offset: 0x10b)
// strings ... 0   (offset: 0x10b)
// dev strs .. 0   (offset: 0x10b)
// exports ... 2   (offset: 0xbb)
// cseg ...... 0x58 + 0x63 (0xbb)
// imports ... 0   (offset: 0x10b)
// animtree1 . 0   (offset: 0x10b)
// animtree2 . 0   (offset: 0x10b)
#namespace zombie_deathworm_spittle;

// Namespace zombie_deathworm_spittle
// Params 1
// Checksum 0x775b74b2, Offset: 0x76
// Size: 0x44
function shouldspittle( taskid )
{
    if ( self.disable_spittle )
    {
        return anim.failure;
    }
    
    if ( self.var_89e47b7d790b5459 <= 1 )
    {
        return anim.success;
    }
    
    return anim.failure;
}

