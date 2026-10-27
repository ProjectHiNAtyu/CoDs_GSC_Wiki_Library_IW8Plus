// script_37348f9db32d9aef  (hash_37348f9db32d9aef.gscc) (size: 419 Bytes / 0x1a3 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x8e639545 (2388890949)
// size ...... 419 (0x1a3)
// includes .. 1   (offset: 0x18f)
// strings ... 1   (offset: 0x197)
// dev strs .. 0   (offset: 0x1a3)
// exports ... 3   (offset: 0xdf)
// cseg ...... 0x72 + 0x6d (0xdf)
// imports ... 2   (offset: 0x157)
// animtree1 . 0   (offset: 0x1a3)
// animtree2 . 0   (offset: 0x1a3)
#using scripts\common\callbacks;

#namespace specialty_shock_resist;

// Namespace specialty_shock_resist
// Params 0, eflags: 0x1
// Checksum 0x6c261b63, Offset: 0x90
// Size: 0x18
function autoexec preinit()
{
    level callback::add( #"register_perk", &registerspecialty );
}

// Namespace specialty_shock_resist
// Params 1
// Checksum 0xf2be427, Offset: 0xb0
// Size: 0x2f
function registerspecialty( params )
{
    if ( isdefined( params.var_bf34439fc0ca3cec ) )
    {
        level [[ params.var_bf34439fc0ca3cec ]]( "specialty_shock_resist" );
    }
}

