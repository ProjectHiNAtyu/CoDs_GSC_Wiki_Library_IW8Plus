// script_40e362932d009418  (hash_40e362932d009418.gscc) (size: 459 Bytes / 0x1cb / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xa9d8755c (2849535324)
// size ...... 459 (0x1cb)
// includes .. 1   (offset: 0x1b3)
// strings ... 1   (offset: 0x1bb)
// dev strs .. 0   (offset: 0x1cb)
// exports ... 3   (offset: 0x103)
// cseg ...... 0x75 + 0x8e (0x103)
// imports ... 2   (offset: 0x17b)
// animtree1 . 0   (offset: 0x1cb)
// animtree2 . 0   (offset: 0x1cb)
#using scripts\common\callbacks;

#namespace specialty_outlander_bongo;

// Namespace specialty_outlander_bongo
// Params 0, eflags: 0x1
// Checksum 0xfa4c1625, Offset: 0x93
// Size: 0x18
function autoexec preinit()
{
    level callback::add( #"register_perk", &registerspecialty );
}

// Namespace specialty_outlander_bongo
// Params 1
// Checksum 0x2062b1f4, Offset: 0xb3
// Size: 0x50
function registerspecialty( params )
{
    bundle = level.perkbundles[ "specialty_outlander_bongo" ];
    
    if ( !bundle )
    {
        return;
    }
    
    if ( params.var_bf34439fc0ca3cec )
    {
        level [[ params.var_bf34439fc0ca3cec ]]( "specialty_outlander_bongo" );
    }
}

