// script_54e4350d99b04e54  (hash_54e4350d99b04e54.gscc) (size: 594 Bytes / 0x252 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xc2caf5f4 (3268081140)
// size ...... 594 (0x252)
// includes .. 1   (offset: 0x23e)
// strings ... 1   (offset: 0x246)
// dev strs .. 0   (offset: 0x252)
// exports ... 5   (offset: 0x106)
// cseg ...... 0x7a + 0x8c (0x106)
// imports ... 4   (offset: 0x1ce)
// animtree1 . 0   (offset: 0x252)
// animtree2 . 0   (offset: 0x252)
#using scripts\common\callbacks;

#namespace specialty_faster_mantle_scalar;

// Namespace specialty_faster_mantle_scalar
// Params 0, eflags: 0x5
// Checksum 0x9a149123, Offset: 0x98
// Size: 0x18
function private autoexec preinit()
{
    level callback::add( #"register_perk", &function_a10eeba48fafb34f );
}

// Namespace specialty_faster_mantle_scalar
// Params 1, eflags: 0x4
// Checksum 0x6a4a97c9, Offset: 0xb8
// Size: 0x3a
function private function_a10eeba48fafb34f( params )
{
    if ( isdefined( params.var_a2358848c4408242 ) )
    {
        level [[ params.var_a2358848c4408242 ]]( "specialty_faster_mantle_scalar", &setspecialty, &unsetspecialty, [] );
    }
}

// Namespace specialty_faster_mantle_scalar
// Params 0, eflags: 0x4
// Checksum 0xb2f4759b, Offset: 0xfa
// Size: 0x2
function private setspecialty()
{
    
}

// Namespace specialty_faster_mantle_scalar
// Params 0, eflags: 0x4
// Checksum 0x8243c1f5, Offset: 0x104
// Size: 0x2
function private unsetspecialty()
{
    
}

