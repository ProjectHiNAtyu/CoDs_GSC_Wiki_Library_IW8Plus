// scripts\mp\gametypes\jugg_mosh.gsc  (hash_368c8ef99587dfe3.gscc) (size: 793 Bytes / 0x319 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xccd81c26 (3436715046)
// size ...... 793 (0x319)
// includes .. 3   (offset: 0x2f5)
// strings ... 1   (offset: 0x30d)
// dev strs .. 0   (offset: 0x319)
// exports ... 5   (offset: 0x14d)
// cseg ...... 0x72 + 0xdb (0x14d)
// imports ... 8   (offset: 0x215)
// animtree1 . 0   (offset: 0x319)
// animtree2 . 0   (offset: 0x319)
#using scripts\common\callbacks;
#using scripts\mp\common\killstreaks\juggernaut;
#using scripts\mp\common\utility\connect_event_aggregator;

#namespace jugg_mosh;

// Namespace jugg_mosh
// Params 0
// Checksum 0x26399d63, Offset: 0x90
// Size: 0x23
function init()
{
    connect_event_aggregator::registeronconnectcallback( &onplayerconnect );
    callback::add( #"player_spawned", &onplayerspawned );
}

// Namespace jugg_mosh
// Params 0
// Checksum 0xf0e793d9, Offset: 0xbb
// Size: 0x18
function onplayerconnect()
{
    player = self;
    player thread function_37487fea3df2b612();
}

// Namespace jugg_mosh
// Params 0
// Checksum 0x13666fe9, Offset: 0xdb
// Size: 0x33
function function_37487fea3df2b612()
{
    player = self;
    player endon( #"death_or_disconnect" );
    
    while ( true )
    {
        player iprintlnbold( "juggermosh - remove me" );
        wait 2;
    }
}

// Namespace jugg_mosh
// Params 1
// Checksum 0x15df3305, Offset: 0x116
// Size: 0x37
function onplayerspawned( params )
{
    /#
        if ( getdvarint( @"hash_672437747e65ed17", 0 ) )
        {
            return;
        }
    #/
    
    player = self;
    player thread juggernaut::activatejugg();
}

