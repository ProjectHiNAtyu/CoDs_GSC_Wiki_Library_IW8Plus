// script_68772d09d079b27  (hash_068772d09d079b27.gscc) (size: 442 Bytes / 0x1ba / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xf9fe3125 (4194185509)
// size ...... 442 (0x1ba)
// includes .. 1   (offset: 0x1a6)
// strings ... 1   (offset: 0x1ae)
// dev strs .. 0   (offset: 0x1ba)
// exports ... 3   (offset: 0xf6)
// cseg ...... 0x86 + 0x70 (0xf6)
// imports ... 2   (offset: 0x16e)
// animtree1 . 0   (offset: 0x1ba)
// animtree2 . 0   (offset: 0x1ba)
#using scripts\common\callbacks;

#namespace specialty_subsequent_jump_slowdown_disable;

// Namespace specialty_subsequent_jump_slowdown_disable
// Params 0, eflags: 0x5
// Checksum 0xf491ca2b, Offset: 0xa4
// Size: 0x18
function private autoexec preinit()
{
    level callback::add( #"register_perk", &function_6f13a1c90bb20645 );
}

// Namespace specialty_subsequent_jump_slowdown_disable
// Params 1, eflags: 0x4
// Checksum 0xa271dabd, Offset: 0xc4
// Size: 0x32
function private function_6f13a1c90bb20645( params )
{
    if ( isdefined( params.var_a2358848c4408242 ) )
    {
        level [[ params.var_a2358848c4408242 ]]( "specialty_subsequent_jump_slowdown_disable", undefined, undefined, [] );
    }
}

