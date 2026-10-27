// scripts\mp\ob\skills\skill_fall_damage_reduction.gsc  (hash_5f499cd1fc64e574.gscc) (size: 645 Bytes / 0x285 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x9a057e47 (2584051271)
// size ...... 645 (0x285)
// includes .. 2   (offset: 0x275)
// strings ... 0   (offset: 0x285)
// dev strs .. 0   (offset: 0x285)
// exports ... 5   (offset: 0x11d)
// cseg ...... 0x58 + 0xc5 (0x11d)
// imports ... 5   (offset: 0x1e5)
// animtree1 . 0   (offset: 0x285)
// animtree2 . 0   (offset: 0x285)
#using script_2fe74ee229c972c3;
#using scripts\common\utility;

#namespace fall_damage_reduction;

// Namespace fall_damage_reduction
// Params 0, eflags: 0x1
// Checksum 0x898268ce, Offset: 0x76
// Size: 0x17
function autoexec main()
{
    shared_skills::function_b667da63ece9b966( #"fall_damage_reduction", &init );
}

// Namespace fall_damage_reduction
// Params 0
// Checksum 0xca277967, Offset: 0x95
// Size: 0x3e
function init()
{
    utility::registersharedfunc( #"fall_damage_reduction", #"ongiveskill", &on_give_skill );
    utility::registersharedfunc( #"fall_damage_reduction", #"hash_4aa03f4559ac50a5", &function_c51f1692ecb73bfe );
}

// Namespace fall_damage_reduction
// Params 1
// Checksum 0xa11dd1e0, Offset: 0xdb
// Size: 0x23, Type: bool
function on_give_skill( skill_bundle )
{
    self.var_3bf56b2cb4cf6514 = { #bundle:skill_bundle };
    return true;
}

// Namespace fall_damage_reduction
// Params 1
// Checksum 0x2ed197e, Offset: 0x107
// Size: 0x16
function function_c51f1692ecb73bfe( skill_bundle )
{
    self.var_3bf56b2cb4cf6514 = undefined;
}

