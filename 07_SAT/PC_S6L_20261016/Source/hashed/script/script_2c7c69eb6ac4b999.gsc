// script_2c7c69eb6ac4b999  (hash_2c7c69eb6ac4b999.gscc) (size: 299 Bytes / 0x12b)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x841362cf (2215862991)
// size ...... 299 (0x12b)
// includes .. 0   (offset: 0x12b)
// strings ... 0   (offset: 0x12b)
// dev strs .. 0   (offset: 0x12b)
// exports ... 2   (offset: 0xa3)
// cseg ...... 0x58 + 0x4b (0xa3)
// imports ... 2   (offset: 0xf3)
// animtree1 . 0   (offset: 0x12b)
// animtree2 . 0   (offset: 0x12b)
#namespace squad;

// Namespace squad
// Params 1
// Checksum 0xd580d47f, Offset: 0x76
// Size: 0x2c
function function_996c0da2e8fc48ea( aiarray )
{
    squadid = function_f0047461b4eb2369();
    
    if ( isdefined( squadid ) )
    {
        aijoinsquad( squadid, aiarray );
    }
    
    return squadid;
}

