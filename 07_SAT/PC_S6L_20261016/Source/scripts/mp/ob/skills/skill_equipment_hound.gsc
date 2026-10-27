// scripts\mp\ob\skills\skill_equipment_hound.gsc  (hash_6721366d03c29ac0.gscc) (size: 752 Bytes / 0x2f0 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x696bcb4e (1768672078)
// size ...... 752 (0x2f0)
// includes .. 2   (offset: 0x2d4)
// strings ... 1   (offset: 0x2e4)
// dev strs .. 0   (offset: 0x2f0)
// exports ... 5   (offset: 0x160)
// cseg ...... 0x63 + 0xfd (0x160)
// imports ... 6   (offset: 0x228)
// animtree1 . 0   (offset: 0x2f0)
// animtree2 . 0   (offset: 0x2f0)
#using script_2fe74ee229c972c3;
#using scripts\common\utility;

#namespace skill_equipment_hound;

// Namespace skill_equipment_hound
// Params 0, eflags: 0x5
// Checksum 0xc14d14b8, Offset: 0x81
// Size: 0x17
function private autoexec main()
{
    shared_skills::function_b667da63ece9b966( #"equipment_hound", &init );
}

// Namespace skill_equipment_hound
// Params 0, eflags: 0x4
// Checksum 0x854b41b9, Offset: 0xa0
// Size: 0x3e
function private init()
{
    utility::registersharedfunc( #"equipment_hound", #"ongiveskill", &on_give_skill );
    utility::registersharedfunc( #"equipment_hound", #"hash_4aa03f4559ac50a5", &function_c51f1692ecb73bfe );
}

// Namespace skill_equipment_hound
// Params 1, eflags: 0x4
// Checksum 0x72c84b47, Offset: 0xe6
// Size: 0x65, Type: bool
function private on_give_skill( skill_bundle )
{
    bonusmaxammo = skill_bundle.var_8d571cf6a37e03f3;
    reloadslot = skill_bundle.var_3eabafc7f68cc2c8;
    utility::callsharedfunc( #"skills", #"hash_2fd3deb81c953c81", #"equipment_hound", bonusmaxammo, "primary", reloadslot );
    return true;
}

// Namespace skill_equipment_hound
// Params 1, eflags: 0x4
// Checksum 0x86d82ecc, Offset: 0x154
// Size: 0xc
function private function_c51f1692ecb73bfe( skill_bundle )
{
    
}

