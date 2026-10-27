// script_2f8b7b6d4bade450  (hash_2f8b7b6d4bade450.gscc) (size: 481 Bytes / 0x1e1 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x68f8f136 (1761145142)
// size ...... 481 (0x1e1)
// includes .. 1   (offset: 0x1cd)
// strings ... 1   (offset: 0x1d5)
// dev strs .. 0   (offset: 0x1e1)
// exports ... 3   (offset: 0x101)
// cseg ...... 0x7e + 0x83 (0x101)
// imports ... 3   (offset: 0x179)
// animtree1 . 0   (offset: 0x1e1)
// animtree2 . 0   (offset: 0x1e1)
#using scripts\common\callbacks;

#namespace specialty_sliding_ads_speed_reduce;

// Namespace specialty_sliding_ads_speed_reduce
// Params 0, eflags: 0x5
// Checksum 0x35349cb1, Offset: 0x9c
// Size: 0x2b
function private autoexec preinit()
{
    level callback::add( #"register_perk", &function_e30ce4fdc42670d4 );
    setdvar( @"hash_f6007dad9d1c506e", 1.3 );
}

// Namespace specialty_sliding_ads_speed_reduce
// Params 1, eflags: 0x4
// Checksum 0x4dc1bdb2, Offset: 0xcf
// Size: 0x32
function private function_e30ce4fdc42670d4( params )
{
    if ( isdefined( params.var_a2358848c4408242 ) )
    {
        level [[ params.var_a2358848c4408242 ]]( "specialty_sliding_ads_speed_reduce", undefined, undefined, [] );
    }
}

