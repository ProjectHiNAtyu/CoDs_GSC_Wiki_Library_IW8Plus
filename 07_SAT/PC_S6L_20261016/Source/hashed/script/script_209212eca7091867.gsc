// script_209212eca7091867  (hash_209212eca7091867.gscc) (size: 418 Bytes / 0x1a2 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xfc6ecfff (4235120639)
// size ...... 418 (0x1a2)
// includes .. 1   (offset: 0x18e)
// strings ... 1   (offset: 0x196)
// dev strs .. 0   (offset: 0x1a2)
// exports ... 3   (offset: 0xde)
// cseg ...... 0x71 + 0x6d (0xde)
// imports ... 2   (offset: 0x156)
// animtree1 . 0   (offset: 0x1a2)
// animtree2 . 0   (offset: 0x1a2)
#using scripts\common\callbacks;

#namespace specialty_coldblooded;

// Namespace specialty_coldblooded
// Params 0, eflags: 0x1
// Checksum 0xd9cb3283, Offset: 0x8f
// Size: 0x18
function autoexec preinit()
{
    level callback::add( #"register_perk", &registerspecialty );
}

// Namespace specialty_coldblooded
// Params 1
// Checksum 0xbac6cdc7, Offset: 0xaf
// Size: 0x2f
function registerspecialty( params )
{
    if ( isdefined( params.var_a2358848c4408242 ) )
    {
        level [[ params.var_a2358848c4408242 ]]( "specialty_coldblooded" );
    }
}

