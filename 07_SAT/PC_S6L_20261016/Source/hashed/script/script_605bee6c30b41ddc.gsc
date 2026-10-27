// script_605bee6c30b41ddc  (hash_605bee6c30b41ddc.gscc) (size: 552 Bytes / 0x228 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x9151288e (2438015118)
// size ...... 552 (0x228)
// includes .. 1   (offset: 0x1f0)
// strings ... 4   (offset: 0x1f8)
// dev strs .. 0   (offset: 0x228)
// exports ... 3   (offset: 0x140)
// cseg ...... 0xb5 + 0x8b (0x140)
// imports ... 2   (offset: 0x1b8)
// animtree1 . 0   (offset: 0x228)
// animtree2 . 0   (offset: 0x228)
#using scripts\common\callbacks;

#namespace specialty_warhead;

// Namespace specialty_warhead
// Params 0, eflags: 0x1
// Checksum 0xec6e7fc6, Offset: 0xd3
// Size: 0x18
function autoexec preinit()
{
    level callback::add( #"register_perk", &registerspecialty );
}

// Namespace specialty_warhead
// Params 1
// Checksum 0xba16ba68, Offset: 0xf3
// Size: 0x4d
function registerspecialty( params )
{
    if ( isdefined( params.var_bf34439fc0ca3cec ) )
    {
        level [[ params.var_bf34439fc0ca3cec ]]( "specialty_warhead", undefined, undefined, [ "specialty_quickswap", "specialty_fastreload", "specialty_fastoffhand" ] );
    }
}

