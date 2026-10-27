// script_4583f2d477dd9afe  (hash_4583f2d477dd9afe.gscc) (size: 418 Bytes / 0x1a2 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xc9435637 (3376633399)
// size ...... 418 (0x1a2)
// includes .. 1   (offset: 0x18e)
// strings ... 1   (offset: 0x196)
// dev strs .. 0   (offset: 0x1a2)
// exports ... 3   (offset: 0xde)
// cseg ...... 0x6e + 0x70 (0xde)
// imports ... 2   (offset: 0x156)
// animtree1 . 0   (offset: 0x1a2)
// animtree2 . 0   (offset: 0x1a2)
#using scripts\common\callbacks;

#namespace specialty_tempered;

// Namespace specialty_tempered
// Params 0, eflags: 0x1
// Checksum 0xfd05d25d, Offset: 0x8c
// Size: 0x18
function autoexec preinit()
{
    level callback::add( #"register_perk", &registerperk );
}

// Namespace specialty_tempered
// Params 1
// Checksum 0xbccb00a8, Offset: 0xac
// Size: 0x32
function registerperk( params )
{
    if ( isdefined( params.var_bf34439fc0ca3cec ) )
    {
        level [[ params.var_bf34439fc0ca3cec ]]( "specialty_tempered", undefined, undefined, [] );
    }
}

