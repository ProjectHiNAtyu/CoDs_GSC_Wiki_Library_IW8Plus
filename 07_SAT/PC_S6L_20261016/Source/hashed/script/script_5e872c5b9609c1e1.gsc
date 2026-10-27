// script_5e872c5b9609c1e1  (hash_5e872c5b9609c1e1.gscc) (size: 429 Bytes / 0x1ad / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x9319827c (2467922556)
// size ...... 429 (0x1ad)
// includes .. 1   (offset: 0x199)
// strings ... 1   (offset: 0x1a1)
// dev strs .. 0   (offset: 0x1ad)
// exports ... 3   (offset: 0xe9)
// cseg ...... 0x7c + 0x6d (0xe9)
// imports ... 2   (offset: 0x161)
// animtree1 . 0   (offset: 0x1ad)
// animtree2 . 0   (offset: 0x1ad)
#using scripts\common\callbacks;

#namespace specialty_fastreload_via_loadout;

// Namespace specialty_fastreload_via_loadout
// Params 0, eflags: 0x1
// Checksum 0xfb03b844, Offset: 0x9a
// Size: 0x18
function autoexec preinit()
{
    level callback::add( #"register_perk", &registerspecialty );
}

// Namespace specialty_fastreload_via_loadout
// Params 1
// Checksum 0x980e4700, Offset: 0xba
// Size: 0x2f
function registerspecialty( params )
{
    if ( isdefined( params.var_a2358848c4408242 ) )
    {
        level [[ params.var_a2358848c4408242 ]]( "specialty_fastreload_via_loadout" );
    }
}

