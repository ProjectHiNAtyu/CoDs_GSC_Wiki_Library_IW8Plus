// script_2a881e038d1e38a4  (hash_2a881e038d1e38a4.gscc) (size: 435 Bytes / 0x1b3 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xdb5b44ab (3680191659)
// size ...... 435 (0x1b3)
// includes .. 1   (offset: 0x19f)
// strings ... 1   (offset: 0x1a7)
// dev strs .. 0   (offset: 0x1b3)
// exports ... 3   (offset: 0xef)
// cseg ...... 0x7f + 0x70 (0xef)
// imports ... 2   (offset: 0x167)
// animtree1 . 0   (offset: 0x1b3)
// animtree2 . 0   (offset: 0x1b3)
#using scripts\common\callbacks;

#namespace specialty_fire_delay_sliding_reduce;

// Namespace specialty_fire_delay_sliding_reduce
// Params 0, eflags: 0x5
// Checksum 0x39b67a55, Offset: 0x9d
// Size: 0x18
function private autoexec preinit()
{
    level callback::add( #"register_perk", &function_92a0fdbb6df89f42 );
}

// Namespace specialty_fire_delay_sliding_reduce
// Params 1, eflags: 0x4
// Checksum 0xb94163ae, Offset: 0xbd
// Size: 0x32
function private function_92a0fdbb6df89f42( params )
{
    if ( isdefined( params.var_a2358848c4408242 ) )
    {
        level [[ params.var_a2358848c4408242 ]]( "specialty_fire_delay_sliding_reduce", undefined, undefined, [] );
    }
}

