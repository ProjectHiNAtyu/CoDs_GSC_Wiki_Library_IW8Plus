// script_2f7d03e5ad3c9cad  (hash_2f7d03e5ad3c9cad.gscc) (size: 458 Bytes / 0x1ca / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x96e4c902 (2531576066)
// size ...... 458 (0x1ca)
// includes .. 1   (offset: 0x1b2)
// strings ... 1   (offset: 0x1ba)
// dev strs .. 0   (offset: 0x1ca)
// exports ... 3   (offset: 0x102)
// cseg ...... 0x74 + 0x8e (0x102)
// imports ... 2   (offset: 0x17a)
// animtree1 . 0   (offset: 0x1ca)
// animtree2 . 0   (offset: 0x1ca)
#using scripts\common\callbacks;

#namespace specialty_engineer_bongo;

// Namespace specialty_engineer_bongo
// Params 0, eflags: 0x1
// Checksum 0xb193b424, Offset: 0x92
// Size: 0x18
function autoexec preinit()
{
    level callback::add( #"register_perk", &registerspecialty );
}

// Namespace specialty_engineer_bongo
// Params 1
// Checksum 0xbbbacb1, Offset: 0xb2
// Size: 0x50
function registerspecialty( params )
{
    bundle = level.perkbundles[ "specialty_engineer_bongo" ];
    
    if ( !bundle )
    {
        return;
    }
    
    if ( params.var_bf34439fc0ca3cec )
    {
        level [[ params.var_bf34439fc0ca3cec ]]( "specialty_engineer_bongo" );
    }
}

