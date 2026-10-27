// scripts\mp\common\killstreaks\assault_drone_mp.gsc  (hash_7543504db9674cd8.gscc) (size: 318 Bytes / 0x13e / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x13b8b4de (330872030)
// size ...... 318 (0x13e)
// includes .. 2   (offset: 0x122)
// strings ... 1   (offset: 0x132)
// dev strs .. 0   (offset: 0x13e)
// exports ... 2   (offset: 0x9a)
// cseg ...... 0x69 + 0x31 (0x9a)
// imports ... 2   (offset: 0xea)
// animtree1 . 0   (offset: 0x13e)
// animtree2 . 0   (offset: 0x13e)
#using scripts\mp\common\killstreaks\helper_drone;
#using scripts\mp\common\killstreaks\killstreaks;

#namespace assault_drone_mp;

// Namespace assault_drone_mp
// Params 0
// Checksum 0x9574e5fb, Offset: 0x87
// Size: 0x13
function assaultdrone_init()
{
    killstreaks::registerkillstreak( "assault_drone", &helper_drone::tryusehelperdronefromstruct );
}

