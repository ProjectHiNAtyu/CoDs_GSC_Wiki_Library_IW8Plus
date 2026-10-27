// script_761851bfa1514c9e  (hash_761851bfa1514c9e.gscc) (size: 446 Bytes / 0x1be / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xa71f3ffb (2803843067)
// size ...... 446 (0x1be)
// includes .. 1   (offset: 0x1a6)
// strings ... 1   (offset: 0x1ae)
// dev strs .. 0   (offset: 0x1be)
// exports ... 3   (offset: 0xf6)
// cseg ...... 0x71 + 0x85 (0xf6)
// imports ... 2   (offset: 0x16e)
// animtree1 . 0   (offset: 0x1be)
// animtree2 . 0   (offset: 0x1be)
#using scripts\common\callbacks;

#namespace specialty_nodeathicon;

// Namespace specialty_nodeathicon
// Params 0, eflags: 0x1
// Checksum 0xa6df4505, Offset: 0x8f
// Size: 0x18
function autoexec preinit()
{
    level callback::add( #"register_perk", &registerspecialty );
}

// Namespace specialty_nodeathicon
// Params 1
// Checksum 0x1fbd109e, Offset: 0xaf
// Size: 0x47
function registerspecialty( params )
{
    if ( isdefined( params.var_bf34439fc0ca3cec ) && !isdefined( level.scriptperks[ "specialty_nodeathicon" ] ) )
    {
        level [[ params.var_bf34439fc0ca3cec ]]( "specialty_nodeathicon", undefined, undefined, [] );
    }
}

