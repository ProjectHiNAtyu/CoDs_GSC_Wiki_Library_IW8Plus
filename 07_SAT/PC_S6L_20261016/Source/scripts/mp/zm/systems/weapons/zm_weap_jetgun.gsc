// scripts\mp\zm\systems\weapons\zm_weap_jetgun.gsc  (hash_4d97ac2023114888.gscc) (size: 433 Bytes / 0x1b1 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x9a0ffd86 (2584739206)
// size ...... 433 (0x1b1)
// includes .. 3   (offset: 0x199)
// strings ... 0   (offset: 0x1b1)
// dev strs .. 0   (offset: 0x1b1)
// exports ... 3   (offset: 0xb1)
// cseg ...... 0x58 + 0x59 (0xb1)
// imports ... 4   (offset: 0x129)
// animtree1 . 0   (offset: 0x1b1)
// animtree2 . 0   (offset: 0x1b1)
#using scripts\common\system;
#using scripts\mp\ammo_cache;
#using scripts\mp\common\weapons\weap_jetgun;

#namespace zm_weap_jetgun;

// Namespace zm_weap_jetgun
// Params 0, eflags: 0x5
// Checksum 0x67bada43, Offset: 0x76
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"zm_weap_jetgun", undefined, &init, undefined );
}

// Namespace zm_weap_jetgun
// Params 0
// Checksum 0x33fedc05, Offset: 0x97
// Size: 0x1a
function init()
{
    weap_jetgun::init();
    level ammo_cache::function_a3aebb9fda9f2bef( level.jetgun_weapon_basename );
}

