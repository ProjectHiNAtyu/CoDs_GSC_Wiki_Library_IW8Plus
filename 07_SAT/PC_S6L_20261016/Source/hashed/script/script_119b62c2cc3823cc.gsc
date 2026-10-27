// script_119b62c2cc3823cc  (hash_119b62c2cc3823cc.gscc) (size: 423 Bytes / 0x1a7 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xdc012e44 (3691064900)
// size ...... 423 (0x1a7)
// includes .. 1   (offset: 0x193)
// strings ... 1   (offset: 0x19b)
// dev strs .. 0   (offset: 0x1a7)
// exports ... 3   (offset: 0xe3)
// cseg ...... 0x73 + 0x70 (0xe3)
// imports ... 2   (offset: 0x15b)
// animtree1 . 0   (offset: 0x1a7)
// animtree2 . 0   (offset: 0x1a7)
#using scripts\common\callbacks;

#namespace specialty_sprintoffhand;

// Namespace specialty_sprintoffhand
// Params 0, eflags: 0x1
// Checksum 0x486f0b27, Offset: 0x91
// Size: 0x18
function autoexec preinit()
{
    level callback::add( #"register_perk", &registerspecialty );
}

// Namespace specialty_sprintoffhand
// Params 1
// Checksum 0x2b62f44f, Offset: 0xb1
// Size: 0x32
function registerspecialty( params )
{
    if ( isdefined( params.var_a2358848c4408242 ) )
    {
        level [[ params.var_a2358848c4408242 ]]( "specialty_sprintoffhand", undefined, undefined, [] );
    }
}

