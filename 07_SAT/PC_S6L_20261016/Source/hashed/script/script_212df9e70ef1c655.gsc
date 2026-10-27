// script_212df9e70ef1c655  (hash_212df9e70ef1c655.gscc) (size: 419 Bytes / 0x1a3 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x842c9c70 (2217516144)
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

#namespace specialty_grenadier;

// Namespace specialty_grenadier
// Params 0, eflags: 0x1
// Checksum 0x50337314, Offset: 0x8d
// Size: 0x18
function autoexec preinit()
{
    level callback::add( #"register_perk", &registerperk );
}

// Namespace specialty_grenadier
// Params 1
// Checksum 0x11fda1e1, Offset: 0xad
// Size: 0x32
function registerperk( params )
{
    if ( isdefined( params.var_bf34439fc0ca3cec ) )
    {
        level [[ params.var_bf34439fc0ca3cec ]]( "specialty_grenadier", undefined, undefined, [] );
    }
}

