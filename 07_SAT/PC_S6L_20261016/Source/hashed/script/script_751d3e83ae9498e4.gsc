// script_751d3e83ae9498e4  (hash_751d3e83ae9498e4.gscc) (size: 419 Bytes / 0x1a3 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x1f4ab62a (524989994)
// size ...... 419 (0x1a3)
// includes .. 1   (offset: 0x18f)
// strings ... 1   (offset: 0x197)
// dev strs .. 0   (offset: 0x1a3)
// exports ... 3   (offset: 0xdf)
// cseg ...... 0x6f + 0x70 (0xdf)
// imports ... 2   (offset: 0x157)
// animtree1 . 0   (offset: 0x1a3)
// animtree2 . 0   (offset: 0x1a3)
#using scripts\common\callbacks;

#namespace specialty_gpsjammer;

// Namespace specialty_gpsjammer
// Params 0, eflags: 0x1
// Checksum 0x332fd6e6, Offset: 0x8d
// Size: 0x18
function autoexec preinit()
{
    level callback::add( #"register_perk", &registerspecialty );
}

// Namespace specialty_gpsjammer
// Params 1
// Checksum 0x5022298e, Offset: 0xad
// Size: 0x32
function registerspecialty( params )
{
    if ( isdefined( params.var_a2358848c4408242 ) )
    {
        level [[ params.var_a2358848c4408242 ]]( "specialty_gpsjammer", undefined, undefined, [] );
    }
}

