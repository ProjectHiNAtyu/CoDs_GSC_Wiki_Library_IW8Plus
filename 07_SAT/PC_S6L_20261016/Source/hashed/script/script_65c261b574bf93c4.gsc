// script_65c261b574bf93c4  (hash_65c261b574bf93c4.gscc) (size: 1098 Bytes / 0x44a / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xd8c1aaf7 (3636570871)
// size ...... 1098 (0x44a)
// includes .. 2   (offset: 0x426)
// strings ... 1   (offset: 0x436)
// dev strs .. 0   (offset: 0x44a)
// exports ... 8   (offset: 0x1f6)
// cseg ...... 0x6b + 0x18b (0x1f6)
// imports ... 8   (offset: 0x336)
// animtree1 . 0   (offset: 0x44a)
// animtree2 . 0   (offset: 0x44a)
#using script_2fe74ee229c972c3;
#using scripts\common\utility;

#namespace skill_mega_jump_upgrade;

// Namespace skill_mega_jump_upgrade
// Params 0, eflags: 0x1
// Checksum 0xdb0c2e37, Offset: 0x89
// Size: 0x17
function autoexec main()
{
    shared_skills::function_b667da63ece9b966( #"mega_jump_upgrade", &init );
}

// Namespace skill_mega_jump_upgrade
// Params 0
// Checksum 0xc68a3fea, Offset: 0xa8
// Size: 0x8c
function init()
{
    utility::registersharedfunc( #"mega_jump_upgrade", #"ongiveskill", &on_give_skill );
    utility::registersharedfunc( #"mega_jump_upgrade", #"hash_4aa03f4559ac50a5", &function_c51f1692ecb73bfe );
    utility::registersharedfunc( "super_mega_jump", #"hash_8017d0662b5d464", &get_jump_velocity );
    utility::registersharedfunc( "super_mega_jump", #"hash_2c5f615801de8fc3", &function_c1587fb7d00e2cdf );
    utility::registersharedfunc( "super_mega_jump", #"hash_424e162a1e8fa5fe", &function_ba461e1d65def6be );
}

// Namespace skill_mega_jump_upgrade
// Params 1, eflags: 0x4
// Checksum 0xe18ad68a, Offset: 0x13c
// Size: 0x23, Type: bool
function private on_give_skill( skill_bundle )
{
    self.var_7d9d8f21bc818c04 = { #bundle:skill_bundle };
    return true;
}

// Namespace skill_mega_jump_upgrade
// Params 1, eflags: 0x4
// Checksum 0x427a1e14, Offset: 0x168
// Size: 0x16
function private function_c51f1692ecb73bfe( skill_bundle )
{
    self.var_7d9d8f21bc818c04 = undefined;
}

// Namespace skill_mega_jump_upgrade
// Params 0, eflags: 0x4
// Checksum 0xcc79c75a, Offset: 0x186
// Size: 0x1f
function private get_jump_velocity()
{
    return self.var_7d9d8f21bc818c04.bundle.var_aab01d404eb4ddfb;
}

// Namespace skill_mega_jump_upgrade
// Params 0, eflags: 0x4
// Checksum 0x8848ea16, Offset: 0x1ae
// Size: 0x1f
function private function_c1587fb7d00e2cdf()
{
    return self.var_7d9d8f21bc818c04.bundle.var_ff431d50b6c6b634;
}

// Namespace skill_mega_jump_upgrade
// Params 0, eflags: 0x4
// Checksum 0x85eb460c, Offset: 0x1d6
// Size: 0x1f
function private function_ba461e1d65def6be()
{
    return self.var_7d9d8f21bc818c04.bundle.var_e643affe5bc52e35;
}

