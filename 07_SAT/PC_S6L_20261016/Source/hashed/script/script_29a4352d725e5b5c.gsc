// script_29a4352d725e5b5c  (hash_29a4352d725e5b5c.gscc) (size: 422 Bytes / 0x1a6 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xe539faf8 (3845782264)
// size ...... 422 (0x1a6)
// includes .. 1   (offset: 0x192)
// strings ... 1   (offset: 0x19a)
// dev strs .. 0   (offset: 0x1a6)
// exports ... 3   (offset: 0xe2)
// cseg ...... 0x75 + 0x6d (0xe2)
// imports ... 2   (offset: 0x15a)
// animtree1 . 0   (offset: 0x1a6)
// animtree2 . 0   (offset: 0x1a6)
#using scripts\common\callbacks;

#namespace specialty_shrapnel_resist;

// Namespace specialty_shrapnel_resist
// Params 0, eflags: 0x1
// Checksum 0xd0355c02, Offset: 0x93
// Size: 0x18
function autoexec preinit()
{
    level callback::add( #"register_perk", &registerspecialty );
}

// Namespace specialty_shrapnel_resist
// Params 1
// Checksum 0xb338a346, Offset: 0xb3
// Size: 0x2f
function registerspecialty( params )
{
    if ( isdefined( params.var_bf34439fc0ca3cec ) )
    {
        level [[ params.var_bf34439fc0ca3cec ]]( "specialty_shrapnel_resist" );
    }
}

