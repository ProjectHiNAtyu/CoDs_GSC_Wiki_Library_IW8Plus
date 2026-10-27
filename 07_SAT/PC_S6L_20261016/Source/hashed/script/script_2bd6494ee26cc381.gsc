// script_2bd6494ee26cc381  (hash_2bd6494ee26cc381.gscc) (size: 1420 Bytes / 0x58c / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x608290e6 (1619169510)
// size ...... 1420 (0x58c)
// includes .. 2   (offset: 0x558)
// strings ... 2   (offset: 0x568)
// dev strs .. 0   (offset: 0x58c)
// exports ... 10  (offset: 0x298)
// cseg ...... 0x89 + 0x20f (0x298)
// imports ... 10  (offset: 0x428)
// animtree1 . 0   (offset: 0x58c)
// animtree2 . 0   (offset: 0x58c)
#using script_2fe74ee229c972c3;
#using scripts\common\utility;

#namespace skill_cradle_gas_grenade_upgrade;

// Namespace skill_cradle_gas_grenade_upgrade
// Params 0, eflags: 0x1
// Checksum 0x5c932819, Offset: 0xa7
// Size: 0x17
function autoexec main()
{
    shared_skills::function_b667da63ece9b966( #"cradle_gas_grenade_upgrade", &init );
}

// Namespace skill_cradle_gas_grenade_upgrade
// Params 0
// Checksum 0x4cf0451b, Offset: 0xc6
// Size: 0xc0
function init()
{
    utility::registersharedfunc( #"cradle_gas_grenade_upgrade", #"ongiveskill", &on_give_skill );
    utility::registersharedfunc( #"cradle_gas_grenade_upgrade", #"hash_4aa03f4559ac50a5", &function_c51f1692ecb73bfe );
    utility::registersharedfunc( "equip_gas_grenade", #"hash_6ab81a5a8df063b1", &function_f6b1775fdb1ea792 );
    utility::registersharedfunc( "equip_gas_grenade", #"hash_3999244ea26d60b1", &function_6eae97a071effbf1 );
    utility::registersharedfunc( "equip_gas_grenade", #"hash_95fcd19aa80083b2", &function_89da6494ddb6748b );
    utility::registersharedfunc( "super_cradle_gas_grenade", #"hash_8921a2c5511486bf", &function_631b24a9c036ca2e );
    utility::registersharedfunc( "super_cradle_gas_grenade", #"hash_bbbc4a1e00d68ab5", &function_5c253152f713ce38 );
}

// Namespace skill_cradle_gas_grenade_upgrade
// Params 1, eflags: 0x4
// Checksum 0xc55c34c9, Offset: 0x18e
// Size: 0x23, Type: bool
function private on_give_skill( skill_bundle )
{
    self.var_9b5a7b5461d92a0c = { #bundle:skill_bundle };
    return true;
}

// Namespace skill_cradle_gas_grenade_upgrade
// Params 1, eflags: 0x4
// Checksum 0x66acfc57, Offset: 0x1ba
// Size: 0x16
function private function_c51f1692ecb73bfe( skill_bundle )
{
    self.var_9b5a7b5461d92a0c = undefined;
}

// Namespace skill_cradle_gas_grenade_upgrade
// Params 0, eflags: 0x4
// Checksum 0xe044db3f, Offset: 0x1d8
// Size: 0x1f
function private function_f6b1775fdb1ea792()
{
    return self.var_9b5a7b5461d92a0c.bundle.var_3d25bebacd72faf5;
}

// Namespace skill_cradle_gas_grenade_upgrade
// Params 0, eflags: 0x4
// Checksum 0xd4d11007, Offset: 0x200
// Size: 0x1f
function private function_6eae97a071effbf1()
{
    return self.var_9b5a7b5461d92a0c.bundle.var_3773c65a5f3f2df6;
}

// Namespace skill_cradle_gas_grenade_upgrade
// Params 0, eflags: 0x4
// Checksum 0xa2a9b017, Offset: 0x228
// Size: 0x1f
function private function_89da6494ddb6748b()
{
    return self.var_9b5a7b5461d92a0c.bundle.var_b4242293466549ed;
}

// Namespace skill_cradle_gas_grenade_upgrade
// Params 0, eflags: 0x4
// Checksum 0xcef964f1, Offset: 0x250
// Size: 0x1f
function private function_631b24a9c036ca2e()
{
    return self.var_9b5a7b5461d92a0c.bundle.var_bb3614286810c4ac;
}

// Namespace skill_cradle_gas_grenade_upgrade
// Params 0, eflags: 0x4
// Checksum 0x7c46307a, Offset: 0x278
// Size: 0x1f
function private function_5c253152f713ce38()
{
    return self.var_9b5a7b5461d92a0c.bundle.var_a7305a59c043d722;
}

