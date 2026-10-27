// script_694db67ec659152b  (hash_694db67ec659152b.gscc) (size: 421 Bytes / 0x1a5 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x8491fae2 (2224159458)
// size ...... 421 (0x1a5)
// includes .. 1   (offset: 0x191)
// strings ... 1   (offset: 0x199)
// dev strs .. 0   (offset: 0x1a5)
// exports ... 3   (offset: 0xe1)
// cseg ...... 0x74 + 0x6d (0xe1)
// imports ... 2   (offset: 0x159)
// animtree1 . 0   (offset: 0x1a5)
// animtree2 . 0   (offset: 0x1a5)
#using scripts\common\callbacks;

#namespace specialty_noscopeoutline;

// Namespace specialty_noscopeoutline
// Params 0, eflags: 0x1
// Checksum 0x5f35774d, Offset: 0x92
// Size: 0x18
function autoexec preinit()
{
    level callback::add( #"register_perk", &registerspecialty );
}

// Namespace specialty_noscopeoutline
// Params 1
// Checksum 0x3c388809, Offset: 0xb2
// Size: 0x2f
function registerspecialty( params )
{
    if ( isdefined( params.var_a2358848c4408242 ) )
    {
        level [[ params.var_a2358848c4408242 ]]( "specialty_noscopeoutline" );
    }
}

