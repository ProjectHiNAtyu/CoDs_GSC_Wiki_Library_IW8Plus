// script_46cb30e57b976e29  (hash_46cb30e57b976e29.gscc) (size: 524 Bytes / 0x20c / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x60ec7292 (1626108562)
// size ...... 524 (0x20c)
// includes .. 1   (offset: 0x1e0)
// strings ... 3   (offset: 0x1e8)
// dev strs .. 0   (offset: 0x20c)
// exports ... 3   (offset: 0x130)
// cseg ...... 0xae + 0x82 (0x130)
// imports ... 2   (offset: 0x1a8)
// animtree1 . 0   (offset: 0x20c)
// animtree2 . 0   (offset: 0x20c)
#using scripts\common\callbacks;

#namespace specialty_hustle;

// Namespace specialty_hustle
// Params 0, eflags: 0x1
// Checksum 0xfb379358, Offset: 0xcc
// Size: 0x18
function autoexec preinit()
{
    level callback::add( #"register_perk", &registerspecialty );
}

// Namespace specialty_hustle
// Params 1
// Checksum 0x7aeb6f5e, Offset: 0xec
// Size: 0x44
function registerspecialty( params )
{
    if ( isdefined( params.var_bf34439fc0ca3cec ) )
    {
        level [[ params.var_bf34439fc0ca3cec ]]( "specialty_hustle", undefined, undefined, [ "specialty_supersprint_enhanced", "specialty_fastcrouchmovement" ] );
    }
}

