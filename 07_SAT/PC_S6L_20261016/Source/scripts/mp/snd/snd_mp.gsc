// scripts\mp\snd\snd_mp.gsc  (hash_2f100efac3c1624b.gscc) (size: 389 Bytes / 0x185 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x868101d9 (2256601561)
// size ...... 389 (0x185)
// includes .. 1   (offset: 0x171)
// strings ... 0   (offset: 0x179)
// dev strs .. 1   (offset: 0x179)
// exports ... 2   (offset: 0xb1)
// cseg ...... 0x58 + 0x59 (0xb1)
// imports ... 4   (offset: 0x101)
// animtree1 . 0   (offset: 0x185)
// animtree2 . 0   (offset: 0x185)
#using scripts\common\snd\snd;

#namespace snd_mp;

// Namespace snd_mp
// Params 0, eflags: 0x1
// Checksum 0x720139eb, Offset: 0x76
// Size: 0x3b
function autoexec function_e68d5d41d89cdefa()
{
    assert( !isstruct( level.snd ), "<dev string:x24>" );
    snd::init();
    level.snd.fnplaysoundonmovingent = &playsoundonmovingent;
}

