// scripts\mp\destructibles\actions\respawn.gsc  (hash_4b1229c86835ba0c.gscc) (size: 268 Bytes / 0x10c / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xf58c7487 (4119622791)
// size ...... 268 (0x10c)
// includes .. 1   (offset: 0x104)
// strings ... 0   (offset: 0x10c)
// dev strs .. 0   (offset: 0x10c)
// exports ... 2   (offset: 0x98)
// cseg ...... 0x58 + 0x40 (0x98)
// imports ... 1   (offset: 0xe8)
// animtree1 . 0   (offset: 0x10c)
// animtree2 . 0   (offset: 0x10c)
#using scripts\mp\destructibles\destructibles;

#namespace respawn;

// Namespace respawn
// Params 1
// Checksum 0x53366490, Offset: 0x76
// Size: 0x22
function execute( params )
{
    level waittill( params.eventnotify );
    destructible::spawn();
}

