// script_157ace9a0dd26923  (hash_157ace9a0dd26923.gscc) (size: 424 Bytes / 0x1a8 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x7c445515 (2084853013)
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

#namespace specialty_tracker_jammer;

// Namespace specialty_tracker_jammer
// Params 0, eflags: 0x1
// Checksum 0xd438b648, Offset: 0x92
// Size: 0x18
function autoexec preinit()
{
    level callback::add( #"register_perk", &registerspecialty );
}

// Namespace specialty_tracker_jammer
// Params 1
// Checksum 0xb7354920, Offset: 0xb2
// Size: 0x32
function registerspecialty( params )
{
    if ( isdefined( params.var_a2358848c4408242 ) )
    {
        level [[ params.var_a2358848c4408242 ]]( "specialty_tracker_jammer", undefined, undefined, [] );
    }
}

