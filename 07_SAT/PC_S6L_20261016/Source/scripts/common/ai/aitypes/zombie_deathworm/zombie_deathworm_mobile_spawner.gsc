// scripts\common\ai\aitypes\zombie_deathworm\zombie_deathworm_mobile_spawner.gsc  (hash_0cf305a2ff563078.gscc) (size: 345 Bytes / 0x159 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x1319b593 (320451987)
// size ...... 345 (0x159)
// includes .. 0   (offset: 0x159)
// strings ... 0   (offset: 0x159)
// dev strs .. 0   (offset: 0x159)
// exports ... 2   (offset: 0x109)
// cseg ...... 0x58 + 0xb1 (0x109)
// imports ... 0   (offset: 0x159)
// animtree1 . 0   (offset: 0x159)
// animtree2 . 0   (offset: 0x159)
#namespace zombie_deathworm_mobile_spawner;

// Namespace zombie_deathworm_mobile_spawner
// Params 1
// Checksum 0x8c311d6, Offset: 0x76
// Size: 0x92
function function_10a42d423853dab1( taskid )
{
    if ( !self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_39960d450ee3baa1 )
    {
        return anim.failure;
    }
    
    if ( self.var_87f2acda8758bab9 <= 1 )
    {
        return anim.success;
    }
    
    var_4912869f02b165bf = [[ self.var_24610c747736231e ]]();
    
    if ( var_4912869f02b165bf >= 7 && self.var_87f2acda8758bab9 <= 3 )
    {
        return anim.success;
    }
    
    return anim.failure;
}

