// scripts\mp\common\weapons\underbarrel.gsc  (hash_32480f6e847aa788.gscc) (size: 431 Bytes / 0x1af / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x937d63e2 (2474468322)
// size ...... 431 (0x1af)
// includes .. 0   (offset: 0x1af)
// strings ... 0   (offset: 0x1af)
// dev strs .. 0   (offset: 0x1af)
// exports ... 4   (offset: 0xf3)
// cseg ...... 0x58 + 0x9b (0xf3)
// imports ... 1   (offset: 0x193)
// animtree1 . 0   (offset: 0x1af)
// animtree2 . 0   (offset: 0x1af)
#namespace underbarrel;

// Namespace underbarrel
// Params 2
// Checksum 0xaed59ae8, Offset: 0x76
// Size: 0x45
function function_ad8d55243cf37b5b( var_999d006505f44d71, callbackfn )
{
    if ( !isdefined( level.var_a62610653347fd8d ) )
    {
        level.var_a62610653347fd8d = [];
    }
    
    if ( !isdefined( callbackfn ) )
    {
        callbackfn = &function_81a7b68207304f08;
    }
    
    level.var_a62610653347fd8d[ var_999d006505f44d71 ] = callbackfn;
}

// Namespace underbarrel
// Params 1
// Checksum 0x74bc6397, Offset: 0xc3
// Size: 0x26
function function_c4e95594ac422588( var_999d006505f44d71 )
{
    if ( isdefined( level.var_a62610653347fd8d ) )
    {
        return level.var_a62610653347fd8d[ var_999d006505f44d71 ];
    }
}

// Namespace underbarrel
// Params 0
// Checksum 0xfc34c8f9, Offset: 0xf1
// Size: 0x2
function function_81a7b68207304f08()
{
    
}

