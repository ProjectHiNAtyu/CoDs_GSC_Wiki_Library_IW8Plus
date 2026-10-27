// script_747233989e7e890d  (hash_747233989e7e890d.gscc) (size: 395 Bytes / 0x18b / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x39a802ac (967312044)
// size ...... 395 (0x18b)
// includes .. 1   (offset: 0x177)
// strings ... 1   (offset: 0x17f)
// dev strs .. 0   (offset: 0x18b)
// exports ... 3   (offset: 0xc7)
// cseg ...... 0x63 + 0x64 (0xc7)
// imports ... 2   (offset: 0x13f)
// animtree1 . 0   (offset: 0x18b)
// animtree2 . 0   (offset: 0x18b)
#using scripts\asm\asm;

#namespace namespace_e35cf5e19cb4a348;

// Namespace namespace_e35cf5e19cb4a348
// Params 0
// Checksum 0x50be8b7c, Offset: 0x81
// Size: 0x9
function function_51e38bfee277eed1()
{
    thread manage_puke();
}

// Namespace namespace_e35cf5e19cb4a348
// Params 0, eflags: 0x4
// Checksum 0x263194ac, Offset: 0x92
// Size: 0x35
function private manage_puke()
{
    self endon( #"death" );
    self endon( #"puke_end" );
    asm::function_7256f5ba459c840b( "puke_in" );
    wait 3;
    self notify( #"puke_zombies" );
}

