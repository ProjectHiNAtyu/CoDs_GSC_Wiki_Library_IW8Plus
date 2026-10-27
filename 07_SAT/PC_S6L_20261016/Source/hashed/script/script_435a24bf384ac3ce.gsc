// script_435a24bf384ac3ce  (hash_435a24bf384ac3ce.gscc) (size: 415 Bytes / 0x19f / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x360d3847 (906836039)
// size ...... 415 (0x19f)
// includes .. 1   (offset: 0x18b)
// strings ... 1   (offset: 0x193)
// dev strs .. 0   (offset: 0x19f)
// exports ... 3   (offset: 0xdb)
// cseg ...... 0x6e + 0x6d (0xdb)
// imports ... 2   (offset: 0x153)
// animtree1 . 0   (offset: 0x19f)
// animtree2 . 0   (offset: 0x19f)
#using scripts\common\callbacks;

#namespace specialty_blindeye;

// Namespace specialty_blindeye
// Params 0, eflags: 0x1
// Checksum 0x64ab1436, Offset: 0x8c
// Size: 0x18
function autoexec preinit()
{
    level callback::add( #"register_perk", &registerspecialty );
}

// Namespace specialty_blindeye
// Params 1
// Checksum 0x7a6eb72, Offset: 0xac
// Size: 0x2f
function registerspecialty( params )
{
    if ( isdefined( params.var_a2358848c4408242 ) )
    {
        level [[ params.var_a2358848c4408242 ]]( "specialty_blindeye" );
    }
}

