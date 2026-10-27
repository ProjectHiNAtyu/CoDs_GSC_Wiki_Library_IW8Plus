// script_2031aebdf2f128fc  (hash_2031aebdf2f128fc.gscc) (size: 416 Bytes / 0x1a0 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x633e392b (1665022251)
// size ...... 416 (0x1a0)
// includes .. 1   (offset: 0x18c)
// strings ... 1   (offset: 0x194)
// dev strs .. 0   (offset: 0x1a0)
// exports ... 3   (offset: 0xdc)
// cseg ...... 0x6c + 0x70 (0xdc)
// imports ... 2   (offset: 0x154)
// animtree1 . 0   (offset: 0x1a0)
// animtree2 . 0   (offset: 0x1a0)
#using scripts\common\callbacks;

#namespace specialty_gungho;

// Namespace specialty_gungho
// Params 0, eflags: 0x1
// Checksum 0x5bf60883, Offset: 0x8a
// Size: 0x18
function autoexec preinit()
{
    level callback::add( #"register_perk", &registerperk );
}

// Namespace specialty_gungho
// Params 1
// Checksum 0x1a38da76, Offset: 0xaa
// Size: 0x32
function registerperk( params )
{
    if ( isdefined( params.var_a2358848c4408242 ) )
    {
        level [[ params.var_a2358848c4408242 ]]( "specialty_gungho", undefined, undefined, [] );
    }
}

