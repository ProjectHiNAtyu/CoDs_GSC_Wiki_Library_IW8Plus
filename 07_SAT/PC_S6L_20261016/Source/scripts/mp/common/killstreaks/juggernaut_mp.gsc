// scripts\mp\common\killstreaks\juggernaut_mp.gsc  (hash_11307d2756aa1530.gscc) (size: 776 Bytes / 0x308 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x1922af5a (421703514)
// size ...... 776 (0x308)
// includes .. 5   (offset: 0x2d0)
// strings ... 1   (offset: 0x2f8)
// dev strs .. 0   (offset: 0x308)
// exports ... 4   (offset: 0x168)
// cseg ...... 0x66 + 0x102 (0x168)
// imports ... 7   (offset: 0x208)
// animtree1 . 0   (offset: 0x308)
// animtree2 . 0   (offset: 0x308)
#using scripts\common\callbacks;
#using scripts\mp\common\gameobjects\gameobjects_common;
#using scripts\mp\common\killstreaks\juggernaut;
#using scripts\mp\common\killstreaks\killstreaks;
#using scripts\mp\hud_message;

#namespace juggernaut_mp;

// Namespace juggernaut_mp
// Params 0
// Checksum 0x2453c379, Offset: 0x84
// Size: 0x51
function init()
{
    if ( !isdefined( level.killstreaksetups[ "juggernaut" ] ) )
    {
        killstreaks::registerkillstreak( "juggernaut", &juggernaut::tryusejuggernautfromstruct );
        callback::add( #"player_spawned", &jugg_registeronplayerspawncallback );
        callback::add( #"hash_dff7cb7b68f75deb", &function_83b7c3c81cbe9a3c );
    }
}

// Namespace juggernaut_mp
// Params 1
// Checksum 0x238a5b59, Offset: 0xdd
// Size: 0xc
function jugg_registeronplayerspawncallback( function )
{
    
}

// Namespace juggernaut_mp
// Params 1, eflags: 0x4
// Checksum 0x4fa5b44b, Offset: 0xf1
// Size: 0x76, Type: bool
function private function_83b7c3c81cbe9a3c( params )
{
    game_object = params.game_object;
    player = params.player;
    
    if ( !player.isjuggernaut || gameobjects_common::get_type_hash( game_object ) != #"gameobject_type_carry_object" )
    {
        return true;
    }
    
    player hud_message::showerrormessage( %"killstreaks/jugg_cannot_be_picked_up", undefined, 5 );
    return false;
}

