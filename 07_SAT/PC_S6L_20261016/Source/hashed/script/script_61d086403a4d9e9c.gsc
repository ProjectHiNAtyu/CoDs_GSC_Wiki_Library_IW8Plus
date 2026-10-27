// script_61d086403a4d9e9c  (hash_61d086403a4d9e9c.gscc) (size: 589 Bytes / 0x24d / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x11d0b779 (298891129)
// size ...... 589 (0x24d)
// includes .. 1   (offset: 0x239)
// strings ... 1   (offset: 0x241)
// dev strs .. 0   (offset: 0x24d)
// exports ... 5   (offset: 0x101)
// cseg ...... 0x75 + 0x8c (0x101)
// imports ... 4   (offset: 0x1c9)
// animtree1 . 0   (offset: 0x24d)
// animtree2 . 0   (offset: 0x24d)
#using scripts\common\callbacks;

#namespace specialty_fast_reviver_25;

// Namespace specialty_fast_reviver_25
// Params 0, eflags: 0x5
// Checksum 0xcf401c6d, Offset: 0x93
// Size: 0x18
function private autoexec preinit()
{
    level callback::add( #"register_perk", &function_3f74064a5ef5ee06 );
}

// Namespace specialty_fast_reviver_25
// Params 1, eflags: 0x4
// Checksum 0x91397c1d, Offset: 0xb3
// Size: 0x3a
function private function_3f74064a5ef5ee06( params )
{
    if ( isdefined( params.var_bf34439fc0ca3cec ) )
    {
        level [[ params.var_bf34439fc0ca3cec ]]( "specialty_fast_reviver_25", &setspecialty, &unsetspecialty, [] );
    }
}

// Namespace specialty_fast_reviver_25
// Params 0, eflags: 0x4
// Checksum 0x4e48a18b, Offset: 0xf5
// Size: 0x2
function private setspecialty()
{
    
}

// Namespace specialty_fast_reviver_25
// Params 0, eflags: 0x4
// Checksum 0x7eff15e5, Offset: 0xff
// Size: 0x2
function private unsetspecialty()
{
    
}

