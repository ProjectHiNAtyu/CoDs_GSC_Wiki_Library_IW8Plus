// script_7927d097fe81d6b0  (hash_7927d097fe81d6b0.gscc) (size: 431 Bytes / 0x1af / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x44047299 (1141142169)
// size ...... 431 (0x1af)
// includes .. 1   (offset: 0x19b)
// strings ... 1   (offset: 0x1a3)
// dev strs .. 0   (offset: 0x1af)
// exports ... 3   (offset: 0xeb)
// cseg ...... 0x7e + 0x6d (0xeb)
// imports ... 2   (offset: 0x163)
// animtree1 . 0   (offset: 0x1af)
// animtree2 . 0   (offset: 0x1af)
#using scripts\common\callbacks;

#namespace specialty_tertiary_allow_launchers;

// Namespace specialty_tertiary_allow_launchers
// Params 0, eflags: 0x1
// Checksum 0xb0190fc6, Offset: 0x9c
// Size: 0x18
function autoexec preinit()
{
    level callback::add( #"register_perk", &function_54f3bd14c452b911 );
}

// Namespace specialty_tertiary_allow_launchers
// Params 1, eflags: 0x4
// Checksum 0x916306fc, Offset: 0xbc
// Size: 0x2f
function private function_54f3bd14c452b911( params )
{
    if ( isdefined( params.var_bf34439fc0ca3cec ) )
    {
        level [[ params.var_bf34439fc0ca3cec ]]( "specialty_tertiary_allow_launchers" );
    }
}

