// script_460b83bfb8581b5f  (hash_460b83bfb8581b5f.gscc) (size: 420 Bytes / 0x1a4 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x689d0a9a (1755122330)
// size ...... 420 (0x1a4)
// includes .. 1   (offset: 0x190)
// strings ... 1   (offset: 0x198)
// dev strs .. 0   (offset: 0x1a4)
// exports ... 3   (offset: 0xe0)
// cseg ...... 0x70 + 0x70 (0xe0)
// imports ... 2   (offset: 0x158)
// animtree1 . 0   (offset: 0x1a4)
// animtree2 . 0   (offset: 0x1a4)
#using scripts\common\callbacks;

#namespace specialty_bomb_squad;

// Namespace specialty_bomb_squad
// Params 0, eflags: 0x1
// Checksum 0x59663a72, Offset: 0x8e
// Size: 0x18
function autoexec preinit()
{
    level callback::add( #"register_perk", &registerperk );
}

// Namespace specialty_bomb_squad
// Params 1
// Checksum 0x18a8e887, Offset: 0xae
// Size: 0x32
function registerperk( params )
{
    if ( isdefined( params.var_bf34439fc0ca3cec ) )
    {
        level [[ params.var_bf34439fc0ca3cec ]]( "specialty_bomb_squad", undefined, undefined, [] );
    }
}

