// scripts\mp\common\utility\connect_event_aggregator.gsc  (hash_0a195974d0e328b0.gscc) (size: 686 Bytes / 0x2ae / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x43e66031 (1139171377)
// size ...... 686 (0x2ae)
// includes .. 0   (offset: 0x2ae)
// strings ... 0   (offset: 0x2ae)
// dev strs .. 0   (offset: 0x2ae)
// exports ... 5   (offset: 0x192)
// cseg ...... 0x58 + 0x13a (0x192)
// imports ... 3   (offset: 0x25a)
// animtree1 . 0   (offset: 0x2ae)
// animtree2 . 0   (offset: 0x2ae)
#namespace connect_event_aggregator;

// Namespace connect_event_aggregator
// Params 0
// Checksum 0x773571cb, Offset: 0x76
// Size: 0xa
function init()
{
    level thread onplayerconnect();
}

// Namespace connect_event_aggregator
// Params 0
// Checksum 0x820850f2, Offset: 0x88
// Size: 0x3d
function onplayerconnect()
{
    if ( !isdefined( level.onplayerconnectcallbacks ) )
    {
        level.onplayerconnectcallbacks = [];
    }
    
    for ( ;; )
    {
        level waittill( #"connected", player );
        player thread onplayerconnected();
    }
}

// Namespace connect_event_aggregator
// Params 1
// Checksum 0x6bc8498b, Offset: 0xcd
// Size: 0x39
function registeronconnectcallback( callback )
{
    if ( !isdefined( level.onplayerconnectcallbacks ) )
    {
        level.onplayerconnectcallbacks = [];
    }
    
    level.onplayerconnectcallbacks[ level.onplayerconnectcallbacks.size ] = callback;
}

// Namespace connect_event_aggregator
// Params 0
// Checksum 0x898f694d, Offset: 0x10e
// Size: 0x84
function onplayerconnected()
{
    self endon( #"disconnect" );
    
    foreach ( callback in level.onplayerconnectcallbacks )
    {
        self [[ callback ]]();
    }
}

