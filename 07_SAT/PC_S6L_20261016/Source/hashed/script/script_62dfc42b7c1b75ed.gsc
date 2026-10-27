// script_62dfc42b7c1b75ed  (hash_62dfc42b7c1b75ed.gscc) (size: 1510 Bytes / 0x5e6 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x4924631d (1227121437)
// size ...... 1510 (0x5e6)
// includes .. 4   (offset: 0x59e)
// strings ... 2   (offset: 0x5be)
// dev strs .. 1   (offset: 0x5da)
// exports ... 6   (offset: 0x372)
// cseg ...... 0x8e + 0x2e4 (0x372)
// imports ... 11  (offset: 0x462)
// animtree1 . 0   (offset: 0x5e6)
// animtree2 . 0   (offset: 0x5e6)
#using script_31ee2a173f3499b7;
#using scripts\common\system;
#using scripts\mp\zm\ztron\ztron_item;
#using scripts\mp\zm\ztron\ztron_sound;

#namespace ztron_item_armor_plate;

// Namespace ztron_item_armor_plate
// Params 0, eflags: 0x5
// Checksum 0x3ab8bd6c, Offset: 0xac
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"ztron_item_armor_plate", #"ztron_item", undefined, &init );
}

// Namespace ztron_item_armor_plate
// Params 0
// Checksum 0x92dd3408, Offset: 0xd5
// Size: 0x6d
function init()
{
    ztron_item::function_5844a9c240f7dc8d( #"armor_plate", #"use", &use );
    ztron_item::function_5844a9c240f7dc8d( #"armor_plate", #"canautouse", &canautouse );
    ztron_item::function_5844a9c240f7dc8d( #"armor_plate", #"hash_2dbdd4400cffa8b8", &canitemspawn );
    ztron_sound::function_4ac735395b173fe( "armopr_plate_pickup_OS", "evt_ztron_armorplate_get" );
}

// Namespace ztron_item_armor_plate
// Params 1
// Checksum 0x83b9e807, Offset: 0x14a
// Size: 0xcb, Type: bool
function canitemspawn( params )
{
    foreach ( player in level.players )
    {
        if ( player.ztron.var_4095e0b1332ea87 == 0 )
        {
            continue;
        }
        
        if ( player.ztron.var_6fe8ea86c8758aec < player.ztron.var_4095e0b1332ea87 )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace ztron_item_armor_plate
// Params 1
// Checksum 0xb38ae2b4, Offset: 0x21e
// Size: 0x89, Type: bool
function canautouse( params )
{
    if ( level.ztron.var_95d8c7a469393957 )
    {
        return false;
    }
    
    player = params.player;
    
    if ( player.ztron.var_4095e0b1332ea87 == 0 )
    {
        return false;
    }
    
    if ( player.ztron.var_6fe8ea86c8758aec == player.ztron.var_4095e0b1332ea87 )
    {
        return false;
    }
    
    return true;
}

// Namespace ztron_item_armor_plate
// Params 1
// Checksum 0x82be283d, Offset: 0x2b0
// Size: 0xc2
function use( params )
{
    if ( level.ztron.var_95d8c7a469393957 )
    {
        return;
    }
    
    player = params.player;
    assert( player.ztron.var_4095e0b1332ea87 > 0, "<dev string:x24>" );
    
    if ( player.ztron.var_6fe8ea86c8758aec < player.ztron.var_4095e0b1332ea87 )
    {
        player.ztron.var_6fe8ea86c8758aec++;
        ztron_sound::ztron_playsound( "armopr_plate_pickup_OS", player.origin );
        player ztron_ui::function_38a72e402dc87ace();
    }
}

