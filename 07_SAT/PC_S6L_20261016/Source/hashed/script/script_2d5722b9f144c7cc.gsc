// script_2d5722b9f144c7cc  (hash_2d5722b9f144c7cc.gscc) (size: 1368 Bytes / 0x558 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xe9ac6005 (3920388101)
// size ...... 1368 (0x558)
// includes .. 6   (offset: 0x528)
// strings ... 0   (offset: 0x558)
// dev strs .. 0   (offset: 0x558)
// exports ... 5   (offset: 0x30c)
// cseg ...... 0x58 + 0x2b4 (0x30c)
// imports ... 12  (offset: 0x3d4)
// animtree1 . 0   (offset: 0x558)
// animtree2 . 0   (offset: 0x558)
#using scripts\common\system;
#using scripts\mp\zm\ztron\ztron_item;
#using scripts\mp\zm\ztron\ztron_main;
#using scripts\mp\zm\ztron\ztron_player_utility;
#using scripts\mp\zm\ztron\ztron_slayer;
#using scripts\mp\zm\ztron\ztron_telemetry;

#namespace namespace_63b88cc190f156d9;

// Namespace namespace_63b88cc190f156d9
// Params 0, eflags: 0x5
// Checksum 0x927f59e8, Offset: 0x76
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_d0579b6c2d584ae0", #"ztron_item", undefined, &init );
}

// Namespace namespace_63b88cc190f156d9
// Params 0
// Checksum 0xca63ac4c, Offset: 0x9f
// Size: 0x3e
function init()
{
    ztron_item::function_5844a9c240f7dc8d( #"coin", #"use", &usecoin );
    ztron_item::function_5844a9c240f7dc8d( #"coin", #"hash_3836c356bfe5bc30", &function_2c983537c15e53e7 );
}

// Namespace namespace_63b88cc190f156d9
// Params 1, eflags: 0x4
// Checksum 0x45f4fe2c, Offset: 0xe5
// Size: 0x1e5
function private usecoin( params )
{
    item = params.scriptable;
    player = params.player;
    
    if ( item.inuse )
    {
        return;
    }
    
    if ( !level.ztron.var_95d8c7a469393957 )
    {
        if ( ztron_main::function_4da200e9b8d58a3c() == 5 )
        {
            item ztron_slayer::moneycollected( player );
        }
        
        value = level.ztron.itemdef.var_b11ecf08d3e95264 ?? 100;
        player ztron_player_utility::function_8e1155bcebb3b7b3( value, 1 );
        value >>= 2;
        
        foreach ( teammate in level.players )
        {
            if ( teammate == player )
            {
                continue;
            }
            
            teammate ztron_player_utility::function_8e1155bcebb3b7b3( value, undefined, undefined, 1 );
        }
    }
    
    if ( isdefined( player ) )
    {
        player ztron_telemetry::pickupcoin();
    }
    
    if ( isdefined( level.ztron.var_51d579634a79a25d ) )
    {
        self [[ level.ztron.var_51d579634a79a25d ]]();
    }
    
    if ( level.ztron.itemdef.var_be17ae156fe0470 )
    {
        endpos = player.origin + ( 0, 0, 2000 );
    }
    
    if ( level.ztron.itemdef.var_363004e0d6f9130b )
    {
        return;
    }
    
    item ztron_item::function_f580915d21ddba69( player, endpos );
}

// Namespace namespace_63b88cc190f156d9
// Params 1, eflags: 0x4
// Checksum 0xa8a8ebbb, Offset: 0x2d2
// Size: 0x39
function private function_2c983537c15e53e7( params )
{
    if ( level.ztron.var_95d8c7a469393957 )
    {
        params.var_6ad11e1ce5f9ee38 = %"itemspawnentry:ztron_item_gold_bar";
    }
    
    return params;
}

