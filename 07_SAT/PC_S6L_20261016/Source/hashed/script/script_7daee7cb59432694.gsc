// script_7daee7cb59432694  (hash_7daee7cb59432694.gscc) (size: 455 Bytes / 0x1c7 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x6c68598d (1818777997)
// size ...... 455 (0x1c7)
// includes .. 1   (offset: 0x1af)
// strings ... 1   (offset: 0x1b7)
// dev strs .. 0   (offset: 0x1c7)
// exports ... 3   (offset: 0xff)
// cseg ...... 0x71 + 0x8e (0xff)
// imports ... 2   (offset: 0x177)
// animtree1 . 0   (offset: 0x1c7)
// animtree2 . 0   (offset: 0x1c7)
#using scripts\common\callbacks;

#namespace specialty_medic_bongo;

// Namespace specialty_medic_bongo
// Params 0, eflags: 0x1
// Checksum 0xcc18281c, Offset: 0x8f
// Size: 0x18
function autoexec preinit()
{
    level callback::add( #"register_perk", &registerspecialty );
}

// Namespace specialty_medic_bongo
// Params 1
// Checksum 0x8cafb618, Offset: 0xaf
// Size: 0x50
function registerspecialty( params )
{
    bundle = level.perkbundles[ "specialty_medic_bongo" ];
    
    if ( !bundle )
    {
        return;
    }
    
    if ( params.var_bf34439fc0ca3cec )
    {
        level [[ params.var_bf34439fc0ca3cec ]]( "specialty_medic_bongo" );
    }
}

