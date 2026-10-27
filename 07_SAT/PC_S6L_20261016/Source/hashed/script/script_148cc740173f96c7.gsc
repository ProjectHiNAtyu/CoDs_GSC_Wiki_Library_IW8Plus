// script_148cc740173f96c7  (hash_148cc740173f96c7.gscc) (size: 424 Bytes / 0x1a8 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xc6e98d9f (3337194911)
// size ...... 424 (0x1a8)
// includes .. 1   (offset: 0x194)
// strings ... 1   (offset: 0x19c)
// dev strs .. 0   (offset: 0x1a8)
// exports ... 3   (offset: 0xe4)
// cseg ...... 0x74 + 0x70 (0xe4)
// imports ... 2   (offset: 0x15c)
// animtree1 . 0   (offset: 0x1a8)
// animtree2 . 0   (offset: 0x1a8)
#using scripts\common\callbacks;

#namespace specialty_faster_plating;

// Namespace specialty_faster_plating
// Params 0, eflags: 0x5
// Checksum 0xb2c0ec5e, Offset: 0x92
// Size: 0x18
function private autoexec preinit()
{
    level callback::add( #"register_perk", &function_ee86515d6422cdd1 );
}

// Namespace specialty_faster_plating
// Params 1, eflags: 0x4
// Checksum 0x2fffe3fc, Offset: 0xb2
// Size: 0x32
function private function_ee86515d6422cdd1( params )
{
    if ( isdefined( params.var_bf34439fc0ca3cec ) )
    {
        level [[ params.var_bf34439fc0ca3cec ]]( "specialty_faster_plating", undefined, undefined, [] );
    }
}

