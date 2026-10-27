// script_63b0c9f1c5ca4521  (hash_63b0c9f1c5ca4521.gscc) (size: 614 Bytes / 0x266 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x4bb3549 (79377737)
// size ...... 614 (0x266)
// includes .. 2   (offset: 0x256)
// strings ... 0   (offset: 0x266)
// dev strs .. 0   (offset: 0x266)
// exports ... 5   (offset: 0xfe)
// cseg ...... 0x58 + 0xa6 (0xfe)
// imports ... 5   (offset: 0x1c6)
// animtree1 . 0   (offset: 0x266)
// animtree2 . 0   (offset: 0x266)
#using script_2fe74ee229c972c3;
#using scripts\common\utility;

#namespace skill_monkey_bomb_upgrade;

// Namespace skill_monkey_bomb_upgrade
// Params 0, eflags: 0x1
// Checksum 0xfd44ab45, Offset: 0x76
// Size: 0x17
function autoexec main()
{
    shared_skills::function_b667da63ece9b966( #"monkey_bomb_upgrade", &init );
}

// Namespace skill_monkey_bomb_upgrade
// Params 0
// Checksum 0x752c2591, Offset: 0x95
// Size: 0x3e
function init()
{
    utility::registersharedfunc( #"monkey_bomb_upgrade", #"ongiveskill", &on_give_skill );
    utility::registersharedfunc( #"monkey_bomb_upgrade", #"hash_4aa03f4559ac50a5", &function_c51f1692ecb73bfe );
}

// Namespace skill_monkey_bomb_upgrade
// Params 1, eflags: 0x4
// Checksum 0x5f7ee4ac, Offset: 0xdb
// Size: 0xe, Type: bool
function private on_give_skill( skill_bundle )
{
    return true;
}

// Namespace skill_monkey_bomb_upgrade
// Params 1, eflags: 0x4
// Checksum 0x76bf4ae0, Offset: 0xf2
// Size: 0xc
function private function_c51f1692ecb73bfe( skill_bundle )
{
    
}

