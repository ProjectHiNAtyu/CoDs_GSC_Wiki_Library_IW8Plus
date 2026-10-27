// script_280dc039c2034409  (hash_280dc039c2034409.gscc) (size: 884 Bytes / 0x374 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x45cf7b29 (1171225385)
// size ...... 884 (0x374)
// includes .. 3   (offset: 0x338)
// strings ... 3   (offset: 0x350)
// dev strs .. 0   (offset: 0x374)
// exports ... 5   (offset: 0x1c4)
// cseg ...... 0xab + 0x119 (0x1c4)
// imports ... 6   (offset: 0x28c)
// animtree1 . 0   (offset: 0x374)
// animtree2 . 0   (offset: 0x374)
#using script_54a05cbb2455bc6f;
#using scripts\common\system;
#using scripts\mp\zm\ztron\ztron_weapon;

#namespace namespace_b6f334c605f497c4;

// Namespace namespace_b6f334c605f497c4
// Params 0, eflags: 0x5
// Checksum 0x16d84cfd, Offset: 0xc9
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_a2338caf50340c33", #"ztron_fate", undefined, &init );
}

// Namespace namespace_b6f334c605f497c4
// Params 0
// Checksum 0xad880ac, Offset: 0xf2
// Size: 0x2d
function init()
{
    ztron_fate::function_4b268a9ddf9d18b4( 1, #"hash_f04621e0e56a064c", &activate, &deactivate, "ztron_fate_rock_firepower", "ztron_fate_fury", "dx_zm_ztr4_anno_anz4_d4fatefrpw" );
}

// Namespace namespace_b6f334c605f497c4
// Params 1
// Checksum 0x24131e80, Offset: 0x127
// Size: 0x5a
function activate( loadgame )
{
    self.ztron.default_weapon_bundle = %"hash_38aaa6806435d580";
    self.ztron.var_ab917cce8153980e += 1;
    ztron_weapon::takeweaponpack();
}

// Namespace namespace_b6f334c605f497c4
// Params 0
// Checksum 0xfa8d16f0, Offset: 0x189
// Size: 0x3b
function deactivate()
{
    self.ztron.default_weapon_bundle = %"hash_28daa78760241031";
    self.ztron.var_ab917cce8153980e = 0;
    ztron_weapon::takeweaponpack();
}

