// script_58e5cff0219fc479  (hash_58e5cff0219fc479.gscc) (size: 432 Bytes / 0x1b0 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x8f450928 (2403666216)
// size ...... 432 (0x1b0)
// includes .. 1   (offset: 0x19c)
// strings ... 1   (offset: 0x1a4)
// dev strs .. 0   (offset: 0x1b0)
// exports ... 3   (offset: 0xec)
// cseg ...... 0x7c + 0x70 (0xec)
// imports ... 2   (offset: 0x164)
// animtree1 . 0   (offset: 0x1b0)
// animtree2 . 0   (offset: 0x1b0)
#using scripts\common\callbacks;

#namespace specialty_hip_fire_spread_reduce;

// Namespace specialty_hip_fire_spread_reduce
// Params 0, eflags: 0x5
// Checksum 0xf502d816, Offset: 0x9a
// Size: 0x18
function private autoexec preinit()
{
    level callback::add( #"register_perk", &function_74e3998a4d75f11d );
}

// Namespace specialty_hip_fire_spread_reduce
// Params 1, eflags: 0x4
// Checksum 0x3ad8767a, Offset: 0xba
// Size: 0x32
function private function_74e3998a4d75f11d( params )
{
    if ( isdefined( params.var_a2358848c4408242 ) )
    {
        level [[ params.var_a2358848c4408242 ]]( "specialty_hip_fire_spread_reduce", undefined, undefined, [] );
    }
}

