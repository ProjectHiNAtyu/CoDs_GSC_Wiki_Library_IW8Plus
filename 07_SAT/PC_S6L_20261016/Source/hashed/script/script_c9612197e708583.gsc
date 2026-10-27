// script_c9612197e708583  (hash_0c9612197e708583.gscc) (size: 417 Bytes / 0x1a1 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x7c5ed9db (2086590939)
// size ...... 417 (0x1a1)
// includes .. 1   (offset: 0x18d)
// strings ... 1   (offset: 0x195)
// dev strs .. 0   (offset: 0x1a1)
// exports ... 3   (offset: 0xdd)
// cseg ...... 0x6d + 0x70 (0xdd)
// imports ... 2   (offset: 0x155)
// animtree1 . 0   (offset: 0x1a1)
// animtree2 . 0   (offset: 0x1a1)
#using scripts\common\callbacks;

#namespace specialty_veteran;

// Namespace specialty_veteran
// Params 0, eflags: 0x1
// Checksum 0xc63ba327, Offset: 0x8b
// Size: 0x18
function autoexec preinit()
{
    level callback::add( #"register_perk", &registerperk );
}

// Namespace specialty_veteran
// Params 1
// Checksum 0x87f571d2, Offset: 0xab
// Size: 0x32
function registerperk( params )
{
    if ( isdefined( params.var_bf34439fc0ca3cec ) )
    {
        level [[ params.var_bf34439fc0ca3cec ]]( "specialty_veteran", undefined, undefined, [] );
    }
}

