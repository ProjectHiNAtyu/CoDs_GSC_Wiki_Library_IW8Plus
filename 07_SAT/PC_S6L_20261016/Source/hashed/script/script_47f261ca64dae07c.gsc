// script_47f261ca64dae07c  (hash_47f261ca64dae07c.gscc) (size: 654 Bytes / 0x28e / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x33f819e5 (871897573)
// size ...... 654 (0x28e)
// includes .. 3   (offset: 0x252)
// strings ... 3   (offset: 0x26a)
// dev strs .. 0   (offset: 0x28e)
// exports ... 4   (offset: 0x126)
// cseg ...... 0x86 + 0xa0 (0x126)
// imports ... 5   (offset: 0x1c6)
// animtree1 . 0   (offset: 0x28e)
// animtree2 . 0   (offset: 0x28e)
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\zm\gametypes\zm_rb_r_mod;

#namespace namespace_4c827640809f31c8;

// Namespace namespace_4c827640809f31c8
// Params 0, eflags: 0x5
// Checksum 0x37357b88, Offset: 0xa4
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"hash_713b0a039301f3df", undefined, undefined, &init );
}

// Namespace namespace_4c827640809f31c8
// Params 0
// Checksum 0xd51973e6, Offset: 0xc5
// Size: 0xa
function init()
{
    level thread post_init();
}

// Namespace namespace_4c827640809f31c8
// Params 0
// Checksum 0xd757e84e, Offset: 0xd7
// Size: 0x4f
function post_init()
{
    level waittill( #"firefly_boss_fight_complete" );
    level.var_d55f004bd25138f1 = utility::getstruct( "r_t_unlock", "targetname" );
    level.var_9881b011f1094b24 = #"r_mod_unlock";
    level.var_23850f4ef56baf27 = "r_mod_unlocked";
    zm_rb_r_mod::function_2d620be90b9d8657();
}

