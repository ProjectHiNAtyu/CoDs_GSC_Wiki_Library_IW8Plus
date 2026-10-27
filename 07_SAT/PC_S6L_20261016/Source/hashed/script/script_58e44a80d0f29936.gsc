// script_58e44a80d0f29936  (hash_58e44a80d0f29936.gscc) (size: 293 Bytes / 0x125 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xf72ad533 (4146779443)
// size ...... 293 (0x125)
// includes .. 2   (offset: 0x115)
// strings ... 0   (offset: 0x125)
// dev strs .. 0   (offset: 0x125)
// exports ... 2   (offset: 0x8d)
// cseg ...... 0x58 + 0x35 (0x8d)
// imports ... 2   (offset: 0xdd)
// animtree1 . 0   (offset: 0x125)
// animtree2 . 0   (offset: 0x125)
#using scripts\common\killstreaks\killstreak_shared;
#using scripts\mp\common\killstreaks\gunship;

#namespace t10_gunship;

// Namespace t10_gunship
// Params 0, eflags: 0x5
// Checksum 0x8b08362e, Offset: 0x76
// Size: 0x17
function private autoexec main()
{
    killstreak_shared::registerkillstreakinitfunction( #"gunship", &gunship::init );
}

