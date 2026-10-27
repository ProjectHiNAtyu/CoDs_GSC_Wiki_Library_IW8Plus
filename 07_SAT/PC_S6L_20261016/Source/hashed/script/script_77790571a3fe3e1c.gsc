// script_77790571a3fe3e1c  (hash_77790571a3fe3e1c.gscc) (size: 432 Bytes / 0x1b0 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xf2fca37e (4076643198)
// size ...... 432 (0x1b0)
// includes .. 1   (offset: 0x19c)
// strings ... 1   (offset: 0x1a4)
// dev strs .. 0   (offset: 0x1b0)
// exports ... 3   (offset: 0xec)
// cseg ...... 0x7c + 0x70 (0xec)
// imports ... 2   (offset: 0x164)
// animtree1 . 0   (offset: 0x1b0)
// animtree2 . 0   (offset: 0x1b0)
#using scripts\common\callbacks;

#namespace specialty_faster_tactical_lethal_deploy;

// Namespace specialty_faster_tactical_lethal_deploy
// Params 0, eflags: 0x5
// Checksum 0x11c2d33f, Offset: 0x9a
// Size: 0x18
function private autoexec preinit()
{
    level callback::add( #"register_perk", &function_2e4387b1280cc3a9 );
}

// Namespace specialty_faster_tactical_lethal_deploy
// Params 1, eflags: 0x4
// Checksum 0xb954c1f7, Offset: 0xba
// Size: 0x32
function private function_2e4387b1280cc3a9( params )
{
    if ( isdefined( params.var_a2358848c4408242 ) )
    {
        level [[ params.var_a2358848c4408242 ]]( "specialty_faster_tactical_lethal", undefined, undefined, [] );
    }
}

