// script_204f4a51c6fa63c6  (hash_204f4a51c6fa63c6.gscc) (size: 428 Bytes / 0x1ac / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xb9cb7049 (3117117513)
// size ...... 428 (0x1ac)
// includes .. 1   (offset: 0x198)
// strings ... 1   (offset: 0x1a0)
// dev strs .. 0   (offset: 0x1ac)
// exports ... 3   (offset: 0xe8)
// cseg ...... 0x78 + 0x70 (0xe8)
// imports ... 2   (offset: 0x160)
// animtree1 . 0   (offset: 0x1ac)
// animtree2 . 0   (offset: 0x1ac)
#using scripts\common\callbacks;

#namespace specialty_faster_weapon_swap;

// Namespace specialty_faster_weapon_swap
// Params 0, eflags: 0x5
// Checksum 0x20661faf, Offset: 0x96
// Size: 0x18
function private autoexec preinit()
{
    level callback::add( #"register_perk", &function_2ecf673200977e89 );
}

// Namespace specialty_faster_weapon_swap
// Params 1, eflags: 0x4
// Checksum 0x39cab5f7, Offset: 0xb6
// Size: 0x32
function private function_2ecf673200977e89( params )
{
    if ( isdefined( params.var_a2358848c4408242 ) )
    {
        level [[ params.var_a2358848c4408242 ]]( "specialty_faster_weapon_swap", undefined, undefined, [] );
    }
}

