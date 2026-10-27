// scripts\common\ai\aitypes\shared\zombie\zombie_traverse.gsc  (hash_610d4a9bb9b2d531.gscc) (size: 346 Bytes / 0x15a / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xf098f878 (4036556920)
// size ...... 346 (0x15a)
// includes .. 1   (offset: 0x152)
// strings ... 0   (offset: 0x15a)
// dev strs .. 0   (offset: 0x15a)
// exports ... 3   (offset: 0xbe)
// cseg ...... 0x58 + 0x66 (0xbe)
// imports ... 1   (offset: 0x136)
// animtree1 . 0   (offset: 0x15a)
// animtree2 . 0   (offset: 0x15a)
#using scripts\common\ai;

#namespace zombie_traverse;

// Namespace zombie_traverse
// Params 2
// Checksum 0x45b807e5, Offset: 0x76
// Size: 0x35
function function_505ff2ffa492ab41( taskid, params )
{
    if ( !self.var_a4d7ad445f64c817 )
    {
        return anim.failure;
    }
    
    return anim.running;
}

// Namespace zombie_traverse
// Params 0
// Checksum 0xc0e9aee5, Offset: 0xb4
// Size: 0x9
function is_traversing()
{
    return ai::is_doing_traversal( self );
}

