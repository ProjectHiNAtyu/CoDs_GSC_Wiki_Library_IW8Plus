// script_668c968755b583bd  (hash_668c968755b583bd.gscc) (size: 579 Bytes / 0x243 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x58816452 (1484874834)
// size ...... 579 (0x243)
// includes .. 2   (offset: 0x21b)
// strings ... 2   (offset: 0x22b)
// dev strs .. 0   (offset: 0x243)
// exports ... 4   (offset: 0x10b)
// cseg ...... 0x8b + 0x80 (0x10b)
// imports ... 4   (offset: 0x1ab)
// animtree1 . 0   (offset: 0x243)
// animtree2 . 0   (offset: 0x243)
#using scripts\common\system;
#using scripts\common\utility;

#namespace namespace_6d21cd8fcfa0bd2b;

// Namespace namespace_6d21cd8fcfa0bd2b
// Params 0, eflags: 0x5
// Checksum 0x1ac0d9bd, Offset: 0xa9
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"hash_9b1416741ee00586", undefined, undefined, &init );
}

// Namespace namespace_6d21cd8fcfa0bd2b
// Params 0
// Checksum 0x750d278a, Offset: 0xca
// Size: 0xa
function init()
{
    level thread post_init();
}

// Namespace namespace_6d21cd8fcfa0bd2b
// Params 0
// Checksum 0xfea29e01, Offset: 0xdc
// Size: 0x2f
function post_init()
{
    level utility::flag_wait( "ruby_boss_fight_complete" );
    level.var_9881b011f1094b24 = #"r_mod_unlock_ruby";
    level.var_23850f4ef56baf27 = "r_mod_unlocked_ruby";
}

