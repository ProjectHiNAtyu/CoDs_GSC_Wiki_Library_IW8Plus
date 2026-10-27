// script_3d6f835fcca13b45  (hash_3d6f835fcca13b45.gscc) (size: 1934 Bytes / 0x78e / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xe23b891e (3795552542)
// size ...... 1934 (0x78e)
// includes .. 6   (offset: 0x732)
// strings ... 3   (offset: 0x762)
// dev strs .. 0   (offset: 0x78e)
// exports ... 5   (offset: 0x422)
// cseg ...... 0xb2 + 0x370 (0x422)
// imports ... 20  (offset: 0x4ea)
// animtree1 . 0   (offset: 0x78e)
// animtree2 . 0   (offset: 0x78e)
#using script_4ce55cfc81c444ad;
#using scripts\common\system;
#using scripts\mp\zm\ztron\ztron_item;
#using scripts\mp\zm\ztron\ztron_main;
#using scripts\mp\zm\ztron\ztron_player_utility;
#using scripts\mp\zm\ztron\ztron_sound;

#namespace ztron_item_gem_umbrella;

// Namespace ztron_item_gem_umbrella
// Params 0, eflags: 0x5
// Checksum 0x381fc957, Offset: 0xd0
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_12b47d6f145219b2", #"ztron_item", undefined, &init );
}

// Namespace ztron_item_gem_umbrella
// Params 0
// Checksum 0x10215540, Offset: 0xf9
// Size: 0x31
function init()
{
    ztron_item::function_5844a9c240f7dc8d( #"gem_umbrella", #"use", &use );
    ztron_sound::function_4ac735395b173fe( "gem_thunder_OS", "evt_ztron_pickup_umbrella_gem_storm" );
}

// Namespace ztron_item_gem_umbrella
// Params 1
// Checksum 0x77198829, Offset: 0x132
// Size: 0x53
function use( params )
{
    player = params.player;
    itemdata = ztron_item::function_998f2b10462afbf4( params.bundle );
    level thread gemshower( player, itemdata.duration );
}

// Namespace ztron_item_gem_umbrella
// Params 2
// Checksum 0x2a1d9601, Offset: 0x18d
// Size: 0x295
function gemshower( player, duration )
{
    level endon( #"ztron_game_is_over" );
    dropspots = [];
    baseorigin = spawnstruct();
    baseorigin.origin = player.origin;
    player ztron_dialog::function_927bb94feca983e8( getxhash( "ztron_item_gem_umbrella_group" ) );
    timetowait = player ztron_player_utility::function_10777122eee28fa8( duration );
    dropspots[ dropspots.size ] = baseorigin;
    
    if ( ztron_main::function_4da200e9b8d58a3c() == 1 )
    {
        dropspots[ dropspots.size ] = level.ztron.active_arena.center;
        dropspots = arraycombine( dropspots, level.ztron.active_arena.lootspots );
        dropspots = arraycombine( dropspots, level.ztron.active_arena.safespots );
    }
    
    var_d53b02e1a7214a70 = dropspots[ randomint( dropspots.size ) ].origin + ( 0, 0, 1200 );
    
    foreach ( player in level.players )
    {
        player playloopsound( "evt_ztron_pickup_umbrella_gem_storm" );
    }
    
    wait 1;
    var_d53b02e1a7214a70 = dropspots[ randomint( dropspots.size ) ].origin + ( 0, 0, 1200 );
    ztron_item::function_d0a061baefd87906( var_d53b02e1a7214a70, randomintrange( 5, 10 ), 100 );
    timeleft = gettime() + timetowait * 1000;
    
    while ( timeleft > gettime() )
    {
        var_d53b02e1a7214a70 = dropspots[ randomint( dropspots.size ) ].origin + ( 0, 0, 1200 );
        ztron_item::function_d0a061baefd87906( var_d53b02e1a7214a70, 1, 100 );
        wait 1;
    }
    
    foreach ( player in level.players )
    {
        player stoploopsound( "evt_ztron_pickup_umbrella_gem_storm" );
    }
}

