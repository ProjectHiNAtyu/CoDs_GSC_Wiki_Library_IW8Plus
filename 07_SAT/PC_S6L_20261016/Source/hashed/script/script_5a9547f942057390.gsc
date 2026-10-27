// script_5a9547f942057390  (hash_5a9547f942057390.gscc) (size: 553 Bytes / 0x229 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xc4260845 (3290826821)
// size ...... 553 (0x229)
// includes .. 1   (offset: 0x1f1)
// strings ... 4   (offset: 0x1f9)
// dev strs .. 0   (offset: 0x229)
// exports ... 3   (offset: 0x141)
// cseg ...... 0xb6 + 0x8b (0x141)
// imports ... 2   (offset: 0x1b9)
// animtree1 . 0   (offset: 0x229)
// animtree2 . 0   (offset: 0x229)
#using scripts\common\callbacks;

#namespace specialty_eod;

// Namespace specialty_eod
// Params 0, eflags: 0x1
// Checksum 0x124bd80f, Offset: 0xd4
// Size: 0x18
function autoexec preinit()
{
    level callback::add( #"register_perk", &registerspecialty );
}

// Namespace specialty_eod
// Params 1
// Checksum 0x5c367f56, Offset: 0xf4
// Size: 0x4d
function registerspecialty( params )
{
    if ( isdefined( params.var_bf34439fc0ca3cec ) )
    {
        level [[ params.var_bf34439fc0ca3cec ]]( "specialty_eod", undefined, undefined, [ "specialty_blastshield", "specialty_throwback", "specialty_shrapnel_resist" ] );
    }
}

