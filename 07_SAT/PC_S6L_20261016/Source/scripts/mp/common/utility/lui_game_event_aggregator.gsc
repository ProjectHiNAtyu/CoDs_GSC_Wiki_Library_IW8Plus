// scripts\mp\common\utility\lui_game_event_aggregator.gsc  (hash_76a9469bdb2c8bb1.gscc) (size: 1088 Bytes / 0x440 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x8763cb22 (2271464226)
// size ...... 1088 (0x440)
// includes .. 0   (offset: 0x428)
// strings ... 1   (offset: 0x428)
// dev strs .. 0   (offset: 0x440)
// exports ... 6   (offset: 0x2c0)
// cseg ...... 0x63 + 0x25d (0x2c0)
// imports ... 4   (offset: 0x3b0)
// animtree1 . 0   (offset: 0x440)
// animtree2 . 0   (offset: 0x440)
#namespace lui_game_event_aggregator;

// Namespace lui_game_event_aggregator
// Params 0
// Checksum 0x5d7d8ff7, Offset: 0x81
// Size: 0xa
function init()
{
    level thread onplayerconnect();
}

// Namespace lui_game_event_aggregator
// Params 0
// Checksum 0x4cfff0be, Offset: 0x93
// Size: 0x3a
function onplayerconnect()
{
    function_78b4de56e3c7923a();
    level notify( #"lui_game_event_aggregator_initialized" );
    
    for ( ;; )
    {
        level waittill( #"connected", player );
        player thread onplayerconnected();
    }
}

// Namespace lui_game_event_aggregator
// Params 2
// Checksum 0x33239b1a, Offset: 0xd5
// Size: 0x61
function registeronluieventcallback( callback, channel = "__all__" )
{
    function_78b4de56e3c7923a();
    
    if ( !isdefined( level.var_9398dff023585316[ channel ] ) )
    {
        level.var_9398dff023585316[ channel ] = [];
    }
    
    level.var_9398dff023585316[ channel ][ level.var_9398dff023585316[ channel ].size ] = callback;
}

// Namespace lui_game_event_aggregator
// Params 0
// Checksum 0xc54ae21b, Offset: 0x13e
// Size: 0x13f
function onplayerconnected()
{
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    
    for ( ;; )
    {
        self waittill( #"luinotifyserver", channel, val );
        
        if ( isdefined( level.var_9398dff023585316[ channel ] ) )
        {
            foreach ( callback in level.var_9398dff023585316[ channel ] )
            {
                self [[ callback ]]( channel, val );
            }
        }
        
        foreach ( callback in level.var_9398dff023585316[ "__all__" ] )
        {
            self [[ callback ]]( channel, val );
        }
    }
}

// Namespace lui_game_event_aggregator
// Params 0
// Checksum 0x9de64f6b, Offset: 0x285
// Size: 0x3b
function function_78b4de56e3c7923a()
{
    if ( !isdefined( level.var_9398dff023585316 ) )
    {
        level.var_9398dff023585316 = [];
    }
    
    if ( !isdefined( level.var_9398dff023585316[ "__all__" ] ) )
    {
        level.var_9398dff023585316[ "__all__" ] = [];
    }
}

