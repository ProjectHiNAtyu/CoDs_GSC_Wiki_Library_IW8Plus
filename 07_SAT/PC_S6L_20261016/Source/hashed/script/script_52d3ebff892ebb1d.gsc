// script_52d3ebff892ebb1d  (hash_52d3ebff892ebb1d.gscc) (size: 664 Bytes / 0x298 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x507e4efe (1350455038)
// size ...... 664 (0x298)
// includes .. 2   (offset: 0x288)
// strings ... 0   (offset: 0x298)
// dev strs .. 0   (offset: 0x298)
// exports ... 4   (offset: 0x15c)
// cseg ...... 0x58 + 0x104 (0x15c)
// imports ... 5   (offset: 0x1fc)
// animtree1 . 0   (offset: 0x298)
// animtree2 . 0   (offset: 0x298)
#using scripts\common\system;
#using scripts\mp\zm\ztron\ztron_item;

#namespace namespace_72e35e02912230d8;

// Namespace namespace_72e35e02912230d8
// Params 0, eflags: 0x5
// Checksum 0xc134014e, Offset: 0x76
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_c083561ab61b029b", #"ztron_item", undefined, &init );
}

// Namespace namespace_72e35e02912230d8
// Params 0
// Checksum 0xdf100fd9, Offset: 0x9f
// Size: 0x20
function init()
{
    ztron_item::function_5844a9c240f7dc8d( #"money", #"use", &usemoney );
}

// Namespace namespace_72e35e02912230d8
// Params 1, eflags: 0x4
// Checksum 0xdd982a02, Offset: 0xc7
// Size: 0x95
function private usemoney( params )
{
    item = params.scriptable;
    player = params.player;
    
    if ( item.inuse )
    {
        return;
    }
    
    if ( level.ztron.itemdef.var_be17ae156fe0470 )
    {
        endpos = player.origin + ( 0, 0, 2000 );
    }
    
    item ztron_item::function_f580915d21ddba69( player, endpos );
}

