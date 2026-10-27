// script_3b902fe25f75aa8d  (hash_3b902fe25f75aa8d.gscc) (size: 417 Bytes / 0x1a1 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xfa323290 (4197593744)
// size ...... 417 (0x1a1)
// includes .. 1   (offset: 0x18d)
// strings ... 1   (offset: 0x195)
// dev strs .. 0   (offset: 0x1a1)
// exports ... 3   (offset: 0xdd)
// cseg ...... 0x6d + 0x70 (0xdd)
// imports ... 2   (offset: 0x155)
// animtree1 . 0   (offset: 0x1a1)
// animtree2 . 0   (offset: 0x1a1)
#using scripts\common\callbacks;

#namespace specialty_restock;

// Namespace specialty_restock
// Params 0, eflags: 0x1
// Checksum 0x3658504f, Offset: 0x8b
// Size: 0x18
function autoexec preinit()
{
    level callback::add( #"register_perk", &function_6a21be1544039dc5 );
}

// Namespace specialty_restock
// Params 1
// Checksum 0xddca3de4, Offset: 0xab
// Size: 0x32
function function_6a21be1544039dc5( params )
{
    if ( isdefined( params.var_bf34439fc0ca3cec ) )
    {
        level [[ params.var_bf34439fc0ca3cec ]]( "specialty_restock", undefined, undefined, [] );
    }
}

