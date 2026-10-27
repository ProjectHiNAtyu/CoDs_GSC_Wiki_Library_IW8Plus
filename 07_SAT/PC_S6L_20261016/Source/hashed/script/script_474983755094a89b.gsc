// script_474983755094a89b  (hash_474983755094a89b.gscc) (size: 428 Bytes / 0x1ac / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xd772b641 (3614619201)
// size ...... 428 (0x1ac)
// includes .. 1   (offset: 0x198)
// strings ... 1   (offset: 0x1a0)
// dev strs .. 0   (offset: 0x1ac)
// exports ... 3   (offset: 0xe8)
// cseg ...... 0x78 + 0x70 (0xe8)
// imports ... 2   (offset: 0x160)
// animtree1 . 0   (offset: 0x1ac)
// animtree2 . 0   (offset: 0x1ac)
#using scripts\common\callbacks;

#namespace specialty_fastcrouchmovement;

// Namespace specialty_fastcrouchmovement
// Params 0, eflags: 0x1
// Checksum 0x74da14c, Offset: 0x96
// Size: 0x18
function autoexec preinit()
{
    level callback::add( #"register_perk", &registerspecialty );
}

// Namespace specialty_fastcrouchmovement
// Params 1
// Checksum 0x64405e24, Offset: 0xb6
// Size: 0x32
function registerspecialty( params )
{
    if ( isdefined( params.var_bf34439fc0ca3cec ) )
    {
        level [[ params.var_bf34439fc0ca3cec ]]( "specialty_fastcrouchmovement", undefined, undefined, [] );
    }
}

