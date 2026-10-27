// script_4be763b5d72cb9e0  (hash_4be763b5d72cb9e0.gscc) (size: 2331 Bytes / 0x91b / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x3d973ee3 (1033322211)
// size ...... 2331 (0x91b)
// includes .. 8   (offset: 0x8a3)
// strings ... 4   (offset: 0x8e3)
// dev strs .. 0   (offset: 0x91b)
// exports ... 8   (offset: 0x557)
// cseg ...... 0xd6 + 0x481 (0x557)
// imports ... 18  (offset: 0x697)
// animtree1 . 0   (offset: 0x91b)
// animtree2 . 0   (offset: 0x91b)
#using script_3940e26d28ff3a75;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\zm\ztron\ztron_item;
#using scripts\mp\zm\ztron\ztron_main;
#using scripts\mp\zm\ztron\ztron_meta_progression;
#using scripts\mp\zm\ztron\ztron_slayer;
#using scripts\mp\zm\ztron\ztron_sound;

#namespace namespace_79ba78308411d12d;

// Namespace namespace_79ba78308411d12d
// Params 0, eflags: 0x5
// Checksum 0xbaa5b0fe, Offset: 0xf4
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_13450acf303c37aa", #"ztron_item", undefined, &init );
}

// Namespace namespace_79ba78308411d12d
// Params 0
// Checksum 0xecca6236, Offset: 0x11d
// Size: 0x6d
function init()
{
    ztron_item::function_5844a9c240f7dc8d( #"timepiece", #"use", &use );
    ztron_item::function_5844a9c240f7dc8d( #"timepiece", #"hash_3836c356bfe5bc30", &function_2c983537c15e53e7 );
    ztron_item::function_5844a9c240f7dc8d( #"timepiece", #"postspawnitem", &handlespawned );
    ztron_sound::function_4ac735395b173fe( "ztron_pickup_timepiece_OS", "evt_ztron_pickup_timepiece_consumed" );
}

// Namespace namespace_79ba78308411d12d
// Params 1, eflags: 0x4
// Checksum 0xa5c92ac8, Offset: 0x192
// Size: 0x1c8
function private use( params )
{
    item = params.scriptable;
    player = params.player;
    
    if ( item.inuse )
    {
        return;
    }
    
    if ( level.ztron.blitzmode )
    {
        if ( level.ztron.timepiecescollected >= 5 )
        {
            return;
        }
        
        ztron_sound::ztron_playsound( "ztron_pickup_timepiece_OS", item.origin );
        playfx( utility::getfx( "ztron_fall_hundred_winning" ), item.origin );
        level thread namespace_8898f05447e219f9::function_14c306bcc0c9e83f( undefined, item.origin );
        level.ztron.timepiecescollected++;
        player.ztron.blitzmode.timepiecescollected++;
        item.collected = 1;
        function_f9394471f59c77e1( item.pipindex, 2 );
        
        if ( level.ztron.metaenabled )
        {
            if ( level.ztron.meta.timepiecesspawned && level.ztron.timepiecescollected == 5 )
            {
                level namespace_4f98d1d7dc3196d::function_f7216127c5e1d966( 1 );
            }
        }
    }
    
    if ( ztron_main::function_4da200e9b8d58a3c() == 5 )
    {
        ztron_sound::ztron_playsound( "ztron_pickup_timepiece_OS", player.origin );
        item ztron_slayer::timepiececollected( player );
        endpos = player.origin + ( 0, 0, 2000 );
    }
    
    item ztron_item::function_f580915d21ddba69( player, endpos );
}

// Namespace namespace_79ba78308411d12d
// Params 1, eflags: 0x4
// Checksum 0x9e7b04da, Offset: 0x362
// Size: 0x1c
function private function_2c983537c15e53e7( params )
{
    params.cleanupdisabled = 1;
    return params;
}

// Namespace namespace_79ba78308411d12d
// Params 2, eflags: 0x4
// Checksum 0xef94f440, Offset: 0x387
// Size: 0xd4
function private handlespawned( item, params )
{
    item.origin += ( 0, 0, 12 );
    
    if ( level.ztron.blitzmode )
    {
        item.pipindex = level.ztron.var_a72e8e079aa93eae;
        level.ztron.var_a72e8e079aa93eae++;
        function_f9394471f59c77e1( item.pipindex, 1 );
    }
    
    if ( level.ztron.metaenabled )
    {
        level.ztron.meta.timepiecesspawned++;
    }
    
    item thread function_84071e36a4c99c84();
}

// Namespace namespace_79ba78308411d12d
// Params 0, eflags: 0x4
// Checksum 0x49614751, Offset: 0x463
// Size: 0x44
function private function_84071e36a4c99c84()
{
    self waittill( #"death" );
    
    if ( level.ztron.blitzmode )
    {
        if ( !self.collected )
        {
            function_f9394471f59c77e1( self.pipindex, 3 );
        }
    }
}

// Namespace namespace_79ba78308411d12d
// Params 2, eflags: 0x4
// Checksum 0x4042537f, Offset: 0x4af
// Size: 0xa8
function private function_f9394471f59c77e1( pipindex, newstate )
{
    if ( pipindex < 0 || pipindex >= 5 )
    {
        return;
    }
    
    shift = pipindex * 2;
    oldstate = level.ztron.var_9bacf7922735dc6f >> shift & 3;
    level.ztron.var_9bacf7922735dc6f = level.ztron.var_9bacf7922735dc6f - ( oldstate << shift ) + ( newstate << shift );
    setomnvar( "ui_ztron_blitz_pip_state", level.ztron.var_9bacf7922735dc6f );
}

