// script_278c9983b3134de8  (hash_278c9983b3134de8.gscc) (size: 1516 Bytes / 0x5ec / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x2082abe6 (545434598)
// size ...... 1516 (0x5ec)
// includes .. 4   (offset: 0x5bc)
// strings ... 1   (offset: 0x5dc)
// dev strs .. 0   (offset: 0x5ec)
// exports ... 7   (offset: 0x2d4)
// cseg ...... 0x77 + 0x25d (0x2d4)
// imports ... 16  (offset: 0x3ec)
// animtree1 . 0   (offset: 0x5ec)
// animtree2 . 0   (offset: 0x5ec)
#using script_4ce55cfc81c444ad;
#using scripts\common\system;
#using scripts\mp\zm\ztron\ztron_item;
#using scripts\mp\zm\ztron\ztron_score;

#namespace ztron_item_extra_life;

// Namespace ztron_item_extra_life
// Params 0, eflags: 0x5
// Checksum 0xe7cd362e, Offset: 0x95
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"ztron_item_extra_life", #"ztron_item", undefined, &init );
}

// Namespace ztron_item_extra_life
// Params 0
// Checksum 0xbb79c124, Offset: 0xbe
// Size: 0x7a
function init()
{
    ztron_item::function_5844a9c240f7dc8d( #"extra_life", #"use", &function_9da06168ef7bffeb );
    ztron_item::function_5844a9c240f7dc8d( #"extra_life", #"canautouse", &canautouse );
    ztron_item::function_5844a9c240f7dc8d( #"extra_life", #"hash_87300e1dbd3aa856", &function_ba65311de1bc3d5b );
    ztron_item::function_5844a9c240f7dc8d( #"extra_life", #"hash_bf9815990d609ba5", &function_2fe762114e5874a6 );
}

// Namespace ztron_item_extra_life
// Params 1, eflags: 0x4
// Checksum 0x88342c6c, Offset: 0x140
// Size: 0x3e, Type: bool
function private canautouse( params )
{
    return !isdefined( params.scriptable.owner ) || params.scriptable.owner == self;
}

// Namespace ztron_item_extra_life
// Params 1, eflags: 0x4
// Checksum 0xc3bdbe1f, Offset: 0x187
// Size: 0x32, Type: bool
function private function_ba65311de1bc3d5b( params )
{
    curlives = ztron_score::function_4f2852a8848fa4ce();
    maxlives = ztron_score::getmaxlives();
    return curlives < maxlives;
}

// Namespace ztron_item_extra_life
// Params 1, eflags: 0x4
// Checksum 0xc8a65f14, Offset: 0x1c2
// Size: 0xe0
function private function_9da06168ef7bffeb( params )
{
    item = params.scriptable;
    
    if ( item.owner == self )
    {
        ztron_score::givelives();
        ztron_dialog::function_927bb94feca983e8( getxhash( "ztron_item_extra_life_group" ) );
    }
    else
    {
        foreach ( player in level.players )
        {
            player ztron_score::givelives();
            player ztron_dialog::function_927bb94feca983e8( getxhash( "ztron_item_extra_life_group" ) );
        }
    }
    
    item thread ztron_item::function_f580915d21ddba69( self );
}

// Namespace ztron_item_extra_life
// Params 1, eflags: 0x4
// Checksum 0x7ec1cf7, Offset: 0x2aa
// Size: 0x29
function private function_2fe762114e5874a6( player )
{
    return isdefined( self.owner ) ? player.var_6f2c4e98502eac9b : player;
}

