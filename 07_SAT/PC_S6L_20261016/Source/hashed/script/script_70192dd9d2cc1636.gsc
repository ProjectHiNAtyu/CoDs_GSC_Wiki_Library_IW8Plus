// script_70192dd9d2cc1636  (hash_70192dd9d2cc1636.gscc) (size: 454 Bytes / 0x1c6 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xdff39640 (3757282880)
// size ...... 454 (0x1c6)
// includes .. 1   (offset: 0x1ae)
// strings ... 1   (offset: 0x1b6)
// dev strs .. 0   (offset: 0x1c6)
// exports ... 3   (offset: 0xfe)
// cseg ...... 0x70 + 0x8e (0xfe)
// imports ... 2   (offset: 0x176)
// animtree1 . 0   (offset: 0x1c6)
// animtree2 . 0   (offset: 0x1c6)
#using scripts\common\callbacks;

#namespace specialty_iron_lungs;

// Namespace specialty_iron_lungs
// Params 0, eflags: 0x1
// Checksum 0xc985521d, Offset: 0x8e
// Size: 0x18
function autoexec preinit()
{
    level callback::add( #"register_perk", &registerspecialty );
}

// Namespace specialty_iron_lungs
// Params 1
// Checksum 0xc61a37da, Offset: 0xae
// Size: 0x50
function registerspecialty( params )
{
    bundle = level.perkbundles[ "specialty_iron_lungs" ];
    
    if ( !bundle )
    {
        return;
    }
    
    if ( params.var_bf34439fc0ca3cec )
    {
        level [[ params.var_bf34439fc0ca3cec ]]( "specialty_iron_lungs" );
    }
}

