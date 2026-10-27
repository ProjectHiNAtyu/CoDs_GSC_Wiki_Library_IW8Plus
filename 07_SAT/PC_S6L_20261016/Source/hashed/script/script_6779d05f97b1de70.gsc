// script_6779d05f97b1de70  (hash_6779d05f97b1de70.gscc) (size: 416 Bytes / 0x1a0 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x69b4dfa4 (1773461412)
// size ...... 416 (0x1a0)
// includes .. 1   (offset: 0x18c)
// strings ... 1   (offset: 0x194)
// dev strs .. 0   (offset: 0x1a0)
// exports ... 3   (offset: 0xdc)
// cseg ...... 0x6f + 0x6d (0xdc)
// imports ... 2   (offset: 0x154)
// animtree1 . 0   (offset: 0x1a0)
// animtree2 . 0   (offset: 0x1a0)
#using scripts\common\callbacks;

#namespace specialty_quickswap;

// Namespace specialty_quickswap
// Params 0, eflags: 0x1
// Checksum 0x1ee6c076, Offset: 0x8d
// Size: 0x18
function autoexec preinit()
{
    level callback::add( #"register_perk", &registerspecialty );
}

// Namespace specialty_quickswap
// Params 1
// Checksum 0x7deb3f32, Offset: 0xad
// Size: 0x2f
function registerspecialty( params )
{
    if ( isdefined( params.var_a2358848c4408242 ) )
    {
        level [[ params.var_a2358848c4408242 ]]( "specialty_quickswap" );
    }
}

