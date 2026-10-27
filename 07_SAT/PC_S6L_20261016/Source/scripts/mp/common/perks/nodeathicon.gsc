// scripts\mp\common\perks\nodeathicon.gsc  (hash_3cf1e5c69326d440.gscc) (size: 418 Bytes / 0x1a2 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x9e8c3c30 (2659990576)
// size ...... 418 (0x1a2)
// includes .. 1   (offset: 0x18e)
// strings ... 1   (offset: 0x196)
// dev strs .. 0   (offset: 0x1a2)
// exports ... 3   (offset: 0xde)
// cseg ...... 0x71 + 0x6d (0xde)
// imports ... 2   (offset: 0x156)
// animtree1 . 0   (offset: 0x1a2)
// animtree2 . 0   (offset: 0x1a2)
#using scripts\common\callbacks;

#namespace nodeathicon;

// Namespace nodeathicon
// Params 0, eflags: 0x5
// Checksum 0xd6138c85, Offset: 0x8f
// Size: 0x18
function private autoexec preinit()
{
    level callback::add( #"register_perk", &function_faa7ba7d7f8b9ff7 );
}

// Namespace nodeathicon
// Params 1
// Checksum 0xb9353025, Offset: 0xaf
// Size: 0x2f
function function_faa7ba7d7f8b9ff7( params )
{
    if ( isdefined( params.var_bf34439fc0ca3cec ) )
    {
        level [[ params.var_bf34439fc0ca3cec ]]( "specialty_nodeathicon" );
    }
}

