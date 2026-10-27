// script_643e40f6bb84e331  (hash_643e40f6bb84e331.gscc) (size: 425 Bytes / 0x1a9 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x33d27c5d (869432413)
// size ...... 425 (0x1a9)
// includes .. 1   (offset: 0x195)
// strings ... 1   (offset: 0x19d)
// dev strs .. 0   (offset: 0x1a9)
// exports ... 3   (offset: 0xe5)
// cseg ...... 0x78 + 0x6d (0xe5)
// imports ... 2   (offset: 0x15d)
// animtree1 . 0   (offset: 0x1a9)
// animtree2 . 0   (offset: 0x1a9)
#using scripts\common\callbacks;

#namespace specialty_improvedholdbreath;

// Namespace specialty_improvedholdbreath
// Params 0, eflags: 0x1
// Checksum 0xe3b9f1a4, Offset: 0x96
// Size: 0x18
function autoexec preinit()
{
    level callback::add( #"register_perk", &registerspecialty );
}

// Namespace specialty_improvedholdbreath
// Params 1
// Checksum 0x80b40ee0, Offset: 0xb6
// Size: 0x2f
function registerspecialty( params )
{
    if ( isdefined( params.var_a2358848c4408242 ) )
    {
        level [[ params.var_a2358848c4408242 ]]( "specialty_improvedholdbreath" );
    }
}

