// script_319953486b4868c4  (hash_319953486b4868c4.gscc) (size: 1009 Bytes / 0x3f1 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x18a800a7 (413663399)
// size ...... 1009 (0x3f1)
// includes .. 4   (offset: 0x39d)
// strings ... 4   (offset: 0x3bd)
// dev strs .. 0   (offset: 0x3f1)
// exports ... 4   (offset: 0x1fd)
// cseg ...... 0xef + 0x10e (0x1fd)
// imports ... 9   (offset: 0x29d)
// animtree1 . 0   (offset: 0x3f1)
// animtree2 . 0   (offset: 0x3f1)
#using scripts\common\system;
#using scripts\mp\zm\ztron\ztron_item;
#using scripts\mp\zm\ztron\ztron_slayer;
#using scripts\mp\zm\ztron\ztron_sound;

#namespace namespace_3cb183e19990aa91;

// Namespace namespace_3cb183e19990aa91
// Params 0, eflags: 0x5
// Checksum 0xf2034c82, Offset: 0x10d
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_202c6c8edaa2f4b2", #"ztron_item", undefined, &init );
}

// Namespace namespace_3cb183e19990aa91
// Params 0
// Checksum 0x28a9bf0e, Offset: 0x136
// Size: 0x42
function init()
{
    ztron_item::function_5844a9c240f7dc8d( #"slayer_portal", #"use", &useslayerportal );
    ztron_sound::function_4ac735395b173fe( "slayer_portal_activated_OS", "evt_ztron_magichat_portal_portal_spawn" );
    ztron_sound::function_4ac735395b173fe( "slayer_portal_item_activated_OS", "evt_ztron_magichat_portal_portal_despawn" );
}

// Namespace namespace_3cb183e19990aa91
// Params 1, eflags: 0x4
// Checksum 0xb95d69f0, Offset: 0x180
// Size: 0x7d
function private useslayerportal( params )
{
    if ( level.ztron.slayer_portal_item == self )
    {
        level.ztron.slayer_portal_item = undefined;
    }
    
    if ( !level thread ztron_slayer::function_4c1646f3b0364ef4() )
    {
        return;
    }
    
    ztron_sound::ztron_playsound( "slayer_portal_item_activated_OS", self.origin );
    tplocation = getgroundposition( self.origin, 10 );
    level thread ztron_slayer::openslayerportal( tplocation );
}

