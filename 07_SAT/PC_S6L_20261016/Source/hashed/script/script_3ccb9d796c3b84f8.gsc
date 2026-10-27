// script_3ccb9d796c3b84f8  (hash_3ccb9d796c3b84f8.gscc) (size: 427 Bytes / 0x1ab / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x21e25f82 (568483714)
// size ...... 427 (0x1ab)
// includes .. 1   (offset: 0x197)
// strings ... 1   (offset: 0x19f)
// dev strs .. 0   (offset: 0x1ab)
// exports ... 3   (offset: 0xe7)
// cseg ...... 0x77 + 0x70 (0xe7)
// imports ... 2   (offset: 0x15f)
// animtree1 . 0   (offset: 0x1ab)
// animtree2 . 0   (offset: 0x1ab)
#using scripts\common\callbacks;

#namespace specialty_onehanded_plating;

// Namespace specialty_onehanded_plating
// Params 0, eflags: 0x1
// Checksum 0x1540a709, Offset: 0x95
// Size: 0x18
function autoexec preinit()
{
    level callback::add( #"register_perk", &registerspecialty );
}

// Namespace specialty_onehanded_plating
// Params 1
// Checksum 0x764d5861, Offset: 0xb5
// Size: 0x32
function registerspecialty( params )
{
    if ( isdefined( params.var_bf34439fc0ca3cec ) )
    {
        level [[ params.var_bf34439fc0ca3cec ]]( "specialty_onehanded_plating", undefined, undefined, [] );
    }
}

