// script_2725b7fdde5fbbd3  (hash_2725b7fdde5fbbd3.gscc) (size: 452 Bytes / 0x1c4 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x11ea2ddc (300559836)
// size ...... 452 (0x1c4)
// includes .. 1   (offset: 0x1ac)
// strings ... 1   (offset: 0x1b4)
// dev strs .. 0   (offset: 0x1c4)
// exports ... 3   (offset: 0xfc)
// cseg ...... 0x6e + 0x8e (0xfc)
// imports ... 2   (offset: 0x174)
// animtree1 . 0   (offset: 0x1c4)
// animtree2 . 0   (offset: 0x1c4)
#using scripts\common\callbacks;

#namespace specialty_mobility;

// Namespace specialty_mobility
// Params 0, eflags: 0x1
// Checksum 0x776608f0, Offset: 0x8c
// Size: 0x18
function autoexec preinit()
{
    level callback::add( #"register_perk", &registerspecialty );
}

// Namespace specialty_mobility
// Params 1
// Checksum 0x168df21f, Offset: 0xac
// Size: 0x50
function registerspecialty( params )
{
    bundle = level.perkbundles[ "specialty_mobility" ];
    
    if ( !bundle )
    {
        return;
    }
    
    if ( params.var_bf34439fc0ca3cec )
    {
        level [[ params.var_bf34439fc0ca3cec ]]( "specialty_mobility" );
    }
}

