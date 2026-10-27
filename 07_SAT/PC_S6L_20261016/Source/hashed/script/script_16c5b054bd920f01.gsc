// script_16c5b054bd920f01  (hash_16c5b054bd920f01.gscc) (size: 429 Bytes / 0x1ad / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xc34b9970 (3276511600)
// size ...... 429 (0x1ad)
// includes .. 1   (offset: 0x199)
// strings ... 1   (offset: 0x1a1)
// dev strs .. 0   (offset: 0x1ad)
// exports ... 3   (offset: 0xe9)
// cseg ...... 0x79 + 0x70 (0xe9)
// imports ... 2   (offset: 0x161)
// animtree1 . 0   (offset: 0x1ad)
// animtree2 . 0   (offset: 0x1ad)
#using scripts\common\callbacks;

#namespace specialty_faster_crouch_prone;

// Namespace specialty_faster_crouch_prone
// Params 0, eflags: 0x5
// Checksum 0xda8fd899, Offset: 0x97
// Size: 0x18
function private autoexec preinit()
{
    level callback::add( #"register_perk", &function_b3e5e26595e24a92 );
}

// Namespace specialty_faster_crouch_prone
// Params 1, eflags: 0x4
// Checksum 0x528d377b, Offset: 0xb7
// Size: 0x32
function private function_b3e5e26595e24a92( params )
{
    if ( isdefined( params.var_a2358848c4408242 ) )
    {
        level [[ params.var_a2358848c4408242 ]]( "specialty_faster_crouch_prone", undefined, undefined, [] );
    }
}

