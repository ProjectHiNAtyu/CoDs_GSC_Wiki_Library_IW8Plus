// script_518df3687150f20  (hash_0518df3687150f20.gscc) (size: 660 Bytes / 0x294 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x6ce543df (1826964447)
// size ...... 660 (0x294)
// includes .. 1   (offset: 0x244)
// strings ... 6   (offset: 0x24c)
// dev strs .. 0   (offset: 0x294)
// exports ... 3   (offset: 0x194)
// cseg ...... 0xf7 + 0x9d (0x194)
// imports ... 2   (offset: 0x20c)
// animtree1 . 0   (offset: 0x294)
// animtree2 . 0   (offset: 0x294)
#using scripts\common\callbacks;

#namespace specialty_covert_ops;

// Namespace specialty_covert_ops
// Params 0, eflags: 0x1
// Checksum 0x9db5dbb6, Offset: 0x115
// Size: 0x18
function autoexec preinit()
{
    level callback::add( #"register_perk", &registerspecialty );
}

// Namespace specialty_covert_ops
// Params 1
// Checksum 0xa31791fb, Offset: 0x135
// Size: 0x5f
function registerspecialty( params )
{
    if ( isdefined( params.var_bf34439fc0ca3cec ) )
    {
        level [[ params.var_bf34439fc0ca3cec ]]( "specialty_covert_ops", undefined, undefined, [ "specialty_blindeye", "specialty_noscopeoutline", "specialty_coldblooded", "specialty_noplayertarget", "specialty_sixth_sense_immune" ] );
    }
}

