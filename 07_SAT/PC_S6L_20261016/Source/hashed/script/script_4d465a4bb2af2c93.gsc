// script_4d465a4bb2af2c93  (hash_4d465a4bb2af2c93.gscc) (size: 835 Bytes / 0x343 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x29c54515 (700794133)
// size ...... 835 (0x343)
// includes .. 4   (offset: 0x307)
// strings ... 2   (offset: 0x327)
// dev strs .. 0   (offset: 0x343)
// exports ... 4   (offset: 0x1a3)
// cseg ...... 0x86 + 0x11d (0x1a3)
// imports ... 7   (offset: 0x243)
// animtree1 . 0   (offset: 0x343)
// animtree2 . 0   (offset: 0x343)
#using script_31ee2a173f3499b7;
#using scripts\common\system;
#using scripts\mp\zm\ztron\ztron_item;
#using scripts\mp\zm\ztron\ztron_sound;

#namespace ztron_item_armor_vest;

// Namespace ztron_item_armor_vest
// Params 0, eflags: 0x5
// Checksum 0xa3d1500c, Offset: 0xa4
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"ztron_item_armor_vest", #"ztron_item", undefined, &init );
}

// Namespace ztron_item_armor_vest
// Params 0
// Checksum 0xb4b973fb, Offset: 0xcd
// Size: 0x31
function init()
{
    ztron_item::function_5844a9c240f7dc8d( #"armor_vest", #"use", &use );
    ztron_sound::function_4ac735395b173fe( "armor_vestL1_OS", "evt_ztron_armorvest_get" );
}

// Namespace ztron_item_armor_vest
// Params 1
// Checksum 0xfa56aa47, Offset: 0x106
// Size: 0x9d
function use( params )
{
    if ( level.ztron.var_95d8c7a469393957 )
    {
        return;
    }
    
    player = params.player;
    player.ztron.var_4095e0b1332ea87 = 1;
    player.ztron.var_6fe8ea86c8758aec = player.ztron.var_4095e0b1332ea87;
    player ztron_ui::function_38a72e402dc87ace();
    ztron_sound::ztron_playsound( "armor_vestL1_OS", player.origin );
}

