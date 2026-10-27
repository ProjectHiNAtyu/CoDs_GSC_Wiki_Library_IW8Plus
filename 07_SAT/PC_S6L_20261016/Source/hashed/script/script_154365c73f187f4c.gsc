// script_154365c73f187f4c  (hash_154365c73f187f4c.gscc) (size: 520 Bytes / 0x208 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xc3f5855e (3287647582)
// size ...... 520 (0x208)
// includes .. 1   (offset: 0x1dc)
// strings ... 3   (offset: 0x1e4)
// dev strs .. 0   (offset: 0x208)
// exports ... 3   (offset: 0x12c)
// cseg ...... 0xaa + 0x82 (0x12c)
// imports ... 2   (offset: 0x1a4)
// animtree1 . 0   (offset: 0x208)
// animtree2 . 0   (offset: 0x208)
#using scripts\common\callbacks;

#namespace specialty_focus;

// Namespace specialty_focus
// Params 0, eflags: 0x1
// Checksum 0xfd7a09c7, Offset: 0xc8
// Size: 0x18
function autoexec preinit()
{
    level callback::add( #"register_perk", &registerspecialty );
}

// Namespace specialty_focus
// Params 1
// Checksum 0x831d9195, Offset: 0xe8
// Size: 0x44
function registerspecialty( params )
{
    if ( isdefined( params.var_bf34439fc0ca3cec ) )
    {
        level [[ params.var_bf34439fc0ca3cec ]]( "specialty_focus", undefined, undefined, [ "specialty_viewkick_override", "specialty_improvedholdbreath" ] );
    }
}

