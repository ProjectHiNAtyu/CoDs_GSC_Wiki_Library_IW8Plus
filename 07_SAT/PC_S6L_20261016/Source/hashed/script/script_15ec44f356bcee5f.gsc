// script_15ec44f356bcee5f  (hash_15ec44f356bcee5f.gscc) (size: 850 Bytes / 0x352 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x995969d (160798365)
// size ...... 850 (0x352)
// includes .. 4   (offset: 0x316)
// strings ... 2   (offset: 0x336)
// dev strs .. 0   (offset: 0x352)
// exports ... 4   (offset: 0x17a)
// cseg ...... 0x86 + 0xf4 (0x17a)
// imports ... 9   (offset: 0x21a)
// animtree1 . 0   (offset: 0x352)
// animtree2 . 0   (offset: 0x352)
#using scripts\common\system;
#using scripts\mp\zm\ztron\ztron_item;
#using scripts\mp\zm\ztron\ztron_sound;
#using scripts\mp\zm\ztron\ztron_weapon;

#namespace ztron_item_ammo;

// Namespace ztron_item_ammo
// Params 0, eflags: 0x5
// Checksum 0x56ed93ff, Offset: 0xa4
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"ztron_item_ammo", #"ztron_item", undefined, &init );
}

// Namespace ztron_item_ammo
// Params 0
// Checksum 0x38301b11, Offset: 0xcd
// Size: 0x31
function init()
{
    ztron_item::function_5844a9c240f7dc8d( #"ammo", #"use", &useammo );
    ztron_sound::function_4ac735395b173fe( "ammo_box_OS", "fly_npc_raygun_reload_close" );
}

// Namespace ztron_item_ammo
// Params 1
// Checksum 0x3094c930, Offset: 0x106
// Size: 0x74
function useammo( params )
{
    player = params.player;
    itemdata = ztron_item::function_998f2b10462afbf4( params.bundle );
    player ztron_weapon::function_951f0c703dffc47( 1, itemdata.duration );
    player ztron_weapon::function_601fc4d0362f327b();
    ztron_sound::ztron_playsound( "ammo_box_OS", player.origin );
}

