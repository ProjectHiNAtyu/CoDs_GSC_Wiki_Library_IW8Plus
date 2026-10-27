// scripts\common\ai\aitypes\zombie_deathworm\zombie_deathworm_head_banger.gsc  (hash_455788953224682f.gscc) (size: 595 Bytes / 0x253 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xbd9eddc9 (3181305289)
// size ...... 595 (0x253)
// includes .. 1   (offset: 0x24b)
// strings ... 0   (offset: 0x253)
// dev strs .. 0   (offset: 0x253)
// exports ... 2   (offset: 0x16f)
// cseg ...... 0x58 + 0x117 (0x16f)
// imports ... 5   (offset: 0x1bf)
// animtree1 . 0   (offset: 0x253)
// animtree2 . 0   (offset: 0x253)
#using scripts\common\ai\aitypes\zombie_deathworm\zombie_deathworm_arena;

#namespace zombie_deathworm_head_banger;

// Namespace zombie_deathworm_head_banger
// Params 1
// Checksum 0x6e2dcaef, Offset: 0x76
// Size: 0xf8
function shouldheadbanger( taskid )
{
    target = self.enemy;
    
    if ( !isalive( target ) )
    {
        return anim.failure;
    }
    
    if ( abs( target.origin[ 2 ] - self.origin[ 2 ] ) > 100 )
    {
        return anim.failure;
    }
    
    if ( !self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.enableheadbanger )
    {
        return anim.failure;
    }
    
    closest_tacpoint = findclosesttacpoint( target.origin );
    
    if ( isdefined( closest_tacpoint ) )
    {
        var_60aa9b3c1e06d816 = function_f1f8a8f5f26409b5( closest_tacpoint );
        
        if ( var_60aa9b3c1e06d816 < 1000 )
        {
            return anim.failure;
        }
    }
    
    if ( zombie_deathworm::function_c1592b3e647c3368( target.origin ) )
    {
        return anim.failure;
    }
    
    return anim.success;
}

