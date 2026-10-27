// script_1798c2c9f28258c4  (hash_1798c2c9f28258c4.gscc) (size: 421 Bytes / 0x1a5 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x250160a7 (620847271)
// size ...... 421 (0x1a5)
// includes .. 1   (offset: 0x191)
// strings ... 1   (offset: 0x199)
// dev strs .. 0   (offset: 0x1a5)
// exports ... 3   (offset: 0xe1)
// cseg ...... 0x71 + 0x70 (0xe1)
// imports ... 2   (offset: 0x159)
// animtree1 . 0   (offset: 0x1a5)
// animtree2 . 0   (offset: 0x1a5)
#using scripts\common\callbacks;

#namespace specialty_tracker_pro;

// Namespace specialty_tracker_pro
// Params 0, eflags: 0x1
// Checksum 0x738e3ee5, Offset: 0x8f
// Size: 0x18
function autoexec preinit()
{
    level callback::add( #"register_perk", &registerspecialty );
}

// Namespace specialty_tracker_pro
// Params 1
// Checksum 0x1083c18d, Offset: 0xaf
// Size: 0x32
function registerspecialty( params )
{
    if ( isdefined( params.var_a2358848c4408242 ) )
    {
        level [[ params.var_a2358848c4408242 ]]( "specialty_tracker_pro", undefined, undefined, [] );
    }
}

