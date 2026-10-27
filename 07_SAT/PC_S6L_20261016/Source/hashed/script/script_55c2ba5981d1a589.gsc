// script_55c2ba5981d1a589  (hash_55c2ba5981d1a589.gscc) (size: 566 Bytes / 0x236 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x5424cd6d (1411698029)
// size ...... 566 (0x236)
// includes .. 1   (offset: 0x1fe)
// strings ... 4   (offset: 0x206)
// dev strs .. 0   (offset: 0x236)
// exports ... 3   (offset: 0x14e)
// cseg ...... 0xc3 + 0x8b (0x14e)
// imports ... 2   (offset: 0x1c6)
// animtree1 . 0   (offset: 0x236)
// animtree2 . 0   (offset: 0x236)
#using scripts\common\callbacks;

#namespace specialty_fast_hands;

// Namespace specialty_fast_hands
// Params 0, eflags: 0x1
// Checksum 0xd6077034, Offset: 0xe1
// Size: 0x18
function autoexec preinit()
{
    level callback::add( #"register_perk", &registerspecialty );
}

// Namespace specialty_fast_hands
// Params 1
// Checksum 0x127b9a48, Offset: 0x101
// Size: 0x4d
function registerspecialty( params )
{
    if ( isdefined( params.var_bf34439fc0ca3cec ) )
    {
        level [[ params.var_bf34439fc0ca3cec ]]( "specialty_fast_hands", undefined, undefined, [ "specialty_quickswap", "specialty_throwback", "specialty_throwback_extrafusetime" ] );
    }
}

