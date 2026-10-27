// script_58a03977f9a0abda  (hash_58a03977f9a0abda.gscc) (size: 659 Bytes / 0x293 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x3e46495c (1044793692)
// size ...... 659 (0x293)
// includes .. 1   (offset: 0x27f)
// strings ... 1   (offset: 0x287)
// dev strs .. 0   (offset: 0x293)
// exports ... 5   (offset: 0x147)
// cseg ...... 0x75 + 0xd2 (0x147)
// imports ... 4   (offset: 0x20f)
// animtree1 . 0   (offset: 0x293)
// animtree2 . 0   (offset: 0x293)
#using scripts\common\callbacks;

#namespace specialty_longer_bleedout;

// Namespace specialty_longer_bleedout
// Params 0, eflags: 0x5
// Checksum 0x4eae64d9, Offset: 0x93
// Size: 0x18
function private autoexec preinit()
{
    level callback::add( #"register_perk", &function_96dc08f4e8f2d042 );
}

// Namespace specialty_longer_bleedout
// Params 1, eflags: 0x4
// Checksum 0x315211bd, Offset: 0xb3
// Size: 0x3a
function private function_96dc08f4e8f2d042( params )
{
    if ( isdefined( params.var_bf34439fc0ca3cec ) )
    {
        level [[ params.var_bf34439fc0ca3cec ]]( "specialty_longer_bleedout", &setspecialty, &unsetspecialty, [] );
    }
}

// Namespace specialty_longer_bleedout
// Params 0, eflags: 0x4
// Checksum 0x42a661a, Offset: 0xf5
// Size: 0x30
function private setspecialty()
{
    player = self;
    player.var_18f4ebec6ae0c1db = player.var_9842326056fd7207.var_18f4ebec6ae0c1db;
}

// Namespace specialty_longer_bleedout
// Params 0, eflags: 0x4
// Checksum 0x717ba036, Offset: 0x12d
// Size: 0x1a
function private unsetspecialty()
{
    player = self;
    player.var_18f4ebec6ae0c1db = undefined;
}

