// script_1bf904ab8eb756a9  (hash_1bf904ab8eb756a9.gscc) (size: 454 Bytes / 0x1c6 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x7ce42223 (2095325731)
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

#namespace specialty_squad_link;

// Namespace specialty_squad_link
// Params 0, eflags: 0x1
// Checksum 0xa14bce0b, Offset: 0x8e
// Size: 0x18
function autoexec preinit()
{
    level callback::add( #"register_perk", &registerspecialty );
}

// Namespace specialty_squad_link
// Params 1
// Checksum 0xde2ac395, Offset: 0xae
// Size: 0x50
function registerspecialty( params )
{
    bundle = level.perkbundles[ "specialty_squad_link" ];
    
    if ( !bundle )
    {
        return;
    }
    
    if ( params.var_bf34439fc0ca3cec )
    {
        level [[ params.var_bf34439fc0ca3cec ]]( "specialty_squad_link" );
    }
}

