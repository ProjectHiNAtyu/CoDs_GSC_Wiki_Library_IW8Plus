// script_6177f34bb65f7160  (hash_6177f34bb65f7160.gscc) (size: 424 Bytes / 0x1a8 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xacbb5848 (2897958984)
// size ...... 424 (0x1a8)
// includes .. 1   (offset: 0x194)
// strings ... 1   (offset: 0x19c)
// dev strs .. 0   (offset: 0x1a8)
// exports ... 3   (offset: 0xe4)
// cseg ...... 0x74 + 0x70 (0xe4)
// imports ... 2   (offset: 0x15c)
// animtree1 . 0   (offset: 0x1a8)
// animtree2 . 0   (offset: 0x1a8)
#using scripts\common\callbacks;

#namespace specialty_streak_wrapper;

// Namespace specialty_streak_wrapper
// Params 0, eflags: 0x1
// Checksum 0x676f7ff9, Offset: 0x92
// Size: 0x18
function autoexec preinit()
{
    level callback::add( #"register_perk", &registerspecialty );
}

// Namespace specialty_streak_wrapper
// Params 1
// Checksum 0x4628091, Offset: 0xb2
// Size: 0x32
function registerspecialty( params )
{
    if ( isdefined( params.var_bf34439fc0ca3cec ) )
    {
        level [[ params.var_bf34439fc0ca3cec ]]( "specialty_streak_wrapper", undefined, undefined, [] );
    }
}

