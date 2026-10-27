// scripts\mp\common\killstreaks\uav_bigmap_mp.gsc  (hash_6074448812f6d443.gscc) (size: 315 Bytes / 0x13b / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xef4bbcbd (4014718141)
// size ...... 315 (0x13b)
// includes .. 2   (offset: 0x11f)
// strings ... 1   (offset: 0x12f)
// dev strs .. 0   (offset: 0x13b)
// exports ... 2   (offset: 0x97)
// cseg ...... 0x66 + 0x31 (0x97)
// imports ... 2   (offset: 0xe7)
// animtree1 . 0   (offset: 0x13b)
// animtree2 . 0   (offset: 0x13b)
#using scripts\mp\common\killstreaks\killstreaks;
#using scripts\mp\common\killstreaks\uav_bigmap;

#namespace uav_bigmap_mp;

// Namespace uav_bigmap_mp
// Params 0
// Checksum 0xc5af02fc, Offset: 0x84
// Size: 0x13
function init()
{
    killstreaks::registerkillstreak( "uav_bigmap", &uav_bigmap::function_752a6b34640a086b );
}

