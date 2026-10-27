// script_28580d94b5dbbb8b  (hash_28580d94b5dbbb8b.gscc) (size: 554 Bytes / 0x22a / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xffca6e98 (4291456664)
// size ...... 554 (0x22a)
// includes .. 1   (offset: 0x1f2)
// strings ... 4   (offset: 0x1fa)
// dev strs .. 0   (offset: 0x22a)
// exports ... 3   (offset: 0x142)
// cseg ...... 0xb7 + 0x8b (0x142)
// imports ... 2   (offset: 0x1ba)
// animtree1 . 0   (offset: 0x22a)
// animtree2 . 0   (offset: 0x22a)
#using scripts\common\callbacks;

#namespace specialty_tactical_recon;

// Namespace specialty_tactical_recon
// Params 0, eflags: 0x1
// Checksum 0x52ae4487, Offset: 0xd5
// Size: 0x18
function autoexec preinit()
{
    level callback::add( #"register_perk", &registerspecialty );
}

// Namespace specialty_tactical_recon
// Params 1
// Checksum 0x9ba47061, Offset: 0xf5
// Size: 0x4d
function registerspecialty( params )
{
    if ( isdefined( params.var_bf34439fc0ca3cec ) )
    {
        level [[ params.var_bf34439fc0ca3cec ]]( "specialty_tactical_recon", undefined, undefined, [ "specialty_engineer", "specialty_markequipment", "specialty_hack" ] );
    }
}

