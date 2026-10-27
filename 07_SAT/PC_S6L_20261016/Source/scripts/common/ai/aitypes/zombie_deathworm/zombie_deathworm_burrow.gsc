// scripts\common\ai\aitypes\zombie_deathworm\zombie_deathworm_burrow.gsc  (hash_0c8989eecda77f6a.gscc) (size: 443 Bytes / 0x1bb / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x22def08 (36564744)
// size ...... 443 (0x1bb)
// includes .. 0   (offset: 0x1bb)
// strings ... 0   (offset: 0x1bb)
// dev strs .. 0   (offset: 0x1bb)
// exports ... 3   (offset: 0x127)
// cseg ...... 0x58 + 0xcf (0x127)
// imports ... 1   (offset: 0x19f)
// animtree1 . 0   (offset: 0x1bb)
// animtree2 . 0   (offset: 0x1bb)
#namespace zombie_deathworm_burrow;

// Namespace zombie_deathworm_burrow
// Params 1
// Checksum 0x2a985096, Offset: 0x76
// Size: 0x44
function function_10fbebbd3b84aa3e( taskid )
{
    self.var_7e46b2ec66222b8e = function_46f9072493651dc9( self.var_7e46b2ec66222b8e );
    
    if ( self.var_7e46b2ec66222b8e.size > 0 )
    {
        return anim.success;
    }
    
    return anim.failure;
}

// Namespace zombie_deathworm_burrow
// Params 1
// Checksum 0xaee7c59f, Offset: 0xc3
// Size: 0x63
function function_4bf7c598a5bc40f7( taskid )
{
    last_health_perc = self.var_c6cd6511556ae4e4 ?? 1;
    var_7df6a590dfd9d111 = self.health / self.maxhealth;
    
    if ( last_health_perc - var_7df6a590dfd9d111 >= 0.2 )
    {
        return anim.success;
    }
    
    return anim.failure;
}

