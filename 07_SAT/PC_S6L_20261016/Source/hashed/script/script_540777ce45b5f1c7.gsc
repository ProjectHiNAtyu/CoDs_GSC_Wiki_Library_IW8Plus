// script_540777ce45b5f1c7  (hash_540777ce45b5f1c7.gscc) (size: 436 Bytes / 0x1b4 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xeeb372f0 (4004737776)
// size ...... 436 (0x1b4)
// includes .. 1   (offset: 0x1a0)
// strings ... 1   (offset: 0x1a8)
// dev strs .. 0   (offset: 0x1b4)
// exports ... 3   (offset: 0xf0)
// cseg ...... 0x80 + 0x70 (0xf0)
// imports ... 2   (offset: 0x168)
// animtree1 . 0   (offset: 0x1b4)
// animtree2 . 0   (offset: 0x1b4)
#using scripts\common\callbacks;

#namespace specialty_ping_attacker_on_laststand;

// Namespace specialty_ping_attacker_on_laststand
// Params 0, eflags: 0x1
// Checksum 0xdde7d091, Offset: 0x9e
// Size: 0x18
function autoexec preinit()
{
    level callback::add( #"register_perk", &registerspecialty );
}

// Namespace specialty_ping_attacker_on_laststand
// Params 1
// Checksum 0xbeea2ff9, Offset: 0xbe
// Size: 0x32
function registerspecialty( params )
{
    if ( isdefined( params.var_bf34439fc0ca3cec ) )
    {
        level [[ params.var_bf34439fc0ca3cec ]]( "specialty_ping_attacker_on_laststand", undefined, undefined, [] );
    }
}

