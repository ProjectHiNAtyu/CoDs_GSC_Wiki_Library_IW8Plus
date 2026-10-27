// scripts\mp\zombie_weapon_modifiers.gsc  (hash_7a6923c1e0709252.gscc) (size: 610 Bytes / 0x262 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x9f86f9f1 (2676423153)
// size ...... 610 (0x262)
// includes .. 1   (offset: 0x22a)
// strings ... 4   (offset: 0x232)
// dev strs .. 0   (offset: 0x262)
// exports ... 3   (offset: 0x17a)
// cseg ...... 0xbb + 0xbf (0x17a)
// imports ... 2   (offset: 0x1f2)
// animtree1 . 0   (offset: 0x262)
// animtree2 . 0   (offset: 0x262)
#using scripts\common\system;

#namespace zombie_weapon_modifiers;

// Namespace zombie_weapon_modifiers
// Params 0, eflags: 0x5
// Checksum 0x4e9f566d, Offset: 0xd9
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"hash_d0df44637968b505", undefined, &init, undefined );
}

// Namespace zombie_weapon_modifiers
// Params 0, eflags: 0x4
// Checksum 0xa8d5d062, Offset: 0xfa
// Size: 0x80
function private init()
{
    if ( !isdefined( level.var_ef6fc50ff40f47a8 ) )
    {
        level.var_ef6fc50ff40f47a8 = [];
    }
    
    level.var_ef6fc50ff40f47a8[ level.var_ef6fc50ff40f47a8.size ] = "t10_pi_p13_usugar9_mp";
    level.var_ef6fc50ff40f47a8[ level.var_ef6fc50ff40f47a8.size ] = "t10_sn_p08_ultiger_mp";
    level.var_ef6fc50ff40f47a8[ level.var_ef6fc50ff40f47a8.size ] = "t10_la_p18_stisaac_mp";
    level.var_ef6fc50ff40f47a8[ level.var_ef6fc50ff40f47a8.size ] = "t10_ar_p05_rmary2_mp";
}

