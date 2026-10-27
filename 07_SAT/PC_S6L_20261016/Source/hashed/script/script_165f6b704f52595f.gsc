// script_165f6b704f52595f  (hash_165f6b704f52595f.gscc) (size: 451 Bytes / 0x1c3 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x28f72ae8 (687287016)
// size ...... 451 (0x1c3)
// includes .. 1   (offset: 0x1ab)
// strings ... 1   (offset: 0x1b3)
// dev strs .. 0   (offset: 0x1c3)
// exports ... 3   (offset: 0xfb)
// cseg ...... 0x6d + 0x8e (0xfb)
// imports ... 2   (offset: 0x173)
// animtree1 . 0   (offset: 0x1c3)
// animtree2 . 0   (offset: 0x1c3)
#using scripts\common\callbacks;

#namespace specialty_brawler;

// Namespace specialty_brawler
// Params 0, eflags: 0x1
// Checksum 0xa050ad80, Offset: 0x8b
// Size: 0x18
function autoexec preinit()
{
    level callback::add( #"register_perk", &registerspecialty );
}

// Namespace specialty_brawler
// Params 1
// Checksum 0x77458533, Offset: 0xab
// Size: 0x50
function registerspecialty( params )
{
    bundle = level.perkbundles[ "specialty_brawler" ];
    
    if ( !bundle )
    {
        return;
    }
    
    if ( params.var_bf34439fc0ca3cec )
    {
        level [[ params.var_bf34439fc0ca3cec ]]( "specialty_brawler" );
    }
}

