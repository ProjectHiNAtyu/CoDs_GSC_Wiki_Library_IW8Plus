// scripts\common\concussion_utility.gsc  (hash_588f0d30a20975f5.gscc) (size: 256 Bytes / 0x100 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xcad5c9a0 (3403008416)
// size ...... 256 (0x100)
// includes .. 0   (offset: 0x100)
// strings ... 0   (offset: 0x100)
// dev strs .. 0   (offset: 0x100)
// exports ... 2   (offset: 0x94)
// cseg ...... 0x58 + 0x3c (0x94)
// imports ... 1   (offset: 0xe4)
// animtree1 . 0   (offset: 0x100)
// animtree2 . 0   (offset: 0x100)
#namespace concussion_utility;

// Namespace concussion_utility
// Params 1
// Checksum 0xaf384e7a, Offset: 0x76
// Size: 0x1d
function calculateinterruptdelay( duration )
{
    return max( 0, duration - 2.6 ) * 1000;
}

