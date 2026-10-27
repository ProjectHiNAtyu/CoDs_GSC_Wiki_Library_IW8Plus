// script_6f7b0a15d9d0eaed  (hash_6f7b0a15d9d0eaed.gscc) (size: 453 Bytes / 0x1c5 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x1728d987 (388553095)
// size ...... 453 (0x1c5)
// includes .. 1   (offset: 0x1ad)
// strings ... 1   (offset: 0x1b5)
// dev strs .. 0   (offset: 0x1c5)
// exports ... 3   (offset: 0xfd)
// cseg ...... 0x6f + 0x8e (0xfd)
// imports ... 2   (offset: 0x175)
// animtree1 . 0   (offset: 0x1c5)
// animtree2 . 0   (offset: 0x1c5)
#using scripts\common\callbacks;

#namespace specialty_awareness;

// Namespace specialty_awareness
// Params 0, eflags: 0x1
// Checksum 0xf3c7abba, Offset: 0x8d
// Size: 0x18
function autoexec preinit()
{
    level callback::add( #"register_perk", &registerspecialty );
}

// Namespace specialty_awareness
// Params 1
// Checksum 0xafe0fb01, Offset: 0xad
// Size: 0x50
function registerspecialty( params )
{
    bundle = level.perkbundles[ "specialty_awareness" ];
    
    if ( !bundle )
    {
        return;
    }
    
    if ( params.var_bf34439fc0ca3cec )
    {
        level [[ params.var_bf34439fc0ca3cec ]]( "specialty_awareness" );
    }
}

