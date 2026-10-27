// script_2312b19ca81c20ca  (hash_2312b19ca81c20ca.gscc) (size: 458 Bytes / 0x1ca / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xf6b3fa45 (4138990149)
// size ...... 458 (0x1ca)
// includes .. 1   (offset: 0x1b2)
// strings ... 1   (offset: 0x1ba)
// dev strs .. 0   (offset: 0x1ca)
// exports ... 3   (offset: 0x102)
// cseg ...... 0x72 + 0x90 (0x102)
// imports ... 2   (offset: 0x17a)
// animtree1 . 0   (offset: 0x1ca)
// animtree2 . 0   (offset: 0x1ca)
#using scripts\common\callbacks;

#namespace specialty_twoprimaries;

// Namespace specialty_twoprimaries
// Params 0, eflags: 0x1
// Checksum 0xe1f2dbf7, Offset: 0x90
// Size: 0x18
function autoexec preinit()
{
    level callback::add( #"register_perk", &registerspecialty );
}

// Namespace specialty_twoprimaries
// Params 1
// Checksum 0xaca1838a, Offset: 0xb0
// Size: 0x52
function registerspecialty( params )
{
    bundle = level.perkbundles[ "specialty_twoprimaries" ];
    
    if ( !isdefined( bundle ) )
    {
        return;
    }
    
    if ( isdefined( params.var_a2358848c4408242 ) )
    {
        level [[ params.var_a2358848c4408242 ]]( "specialty_twoprimaries" );
    }
}

