// scripts\mp\common\utility\join_team_aggregator.gsc  (hash_60e83c26eb0cc317.gscc) (size: 988 Bytes / 0x3dc / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x170cb6d (24169325)
// size ...... 988 (0x3dc)
// includes .. 0   (offset: 0x3c0)
// strings ... 2   (offset: 0x3c0)
// dev strs .. 0   (offset: 0x3dc)
// exports ... 5   (offset: 0x2bc)
// cseg ...... 0x74 + 0x248 (0x2bc)
// imports ... 2   (offset: 0x384)
// animtree1 . 0   (offset: 0x3dc)
// animtree2 . 0   (offset: 0x3dc)
#namespace join_team_aggregator;

// Namespace join_team_aggregator
// Params 1
// Checksum 0x35e3c72f, Offset: 0x92
// Size: 0xbc
function onplayerjointeam( player )
{
    thread onplayerjointeamnospectator( player );
    
    if ( isdefined( level.onjointeamcallbacks ) )
    {
        foreach ( callback in level.onjointeamcallbacks )
        {
            self [[ callback ]]( player );
        }
    }
    
    level notify( #"player_joined_team", player );
    level notify( player.team + "_new_member" );
}

// Namespace join_team_aggregator
// Params 1
// Checksum 0xc0152aaf, Offset: 0x156
// Size: 0x39
function registeronplayerjointeamcallback( callback )
{
    if ( !isdefined( level.onjointeamcallbacks ) )
    {
        level.onjointeamcallbacks = [];
    }
    
    level.onjointeamcallbacks[ level.onjointeamcallbacks.size ] = callback;
}

// Namespace join_team_aggregator
// Params 1
// Checksum 0x64ee12cf, Offset: 0x197
// Size: 0xe4
function onplayerjointeamnospectator( player )
{
    player notify( #"hash_c4c3867ada721e30" );
    
    if ( player.sessionstate == "spectator" )
    {
        player endon( #"death_or_disconnect" );
        player endon( #"hash_c4c3867ada721e30" );
        
        while ( player.sessionstate == "spectator" )
        {
            waitframe();
        }
    }
    
    if ( isdefined( level.onjointeamnospectatorcallbacks ) )
    {
        foreach ( callback in level.onjointeamnospectatorcallbacks )
        {
            self [[ callback ]]( player );
        }
    }
}

// Namespace join_team_aggregator
// Params 1
// Checksum 0xb0579fe7, Offset: 0x283
// Size: 0x39
function registeronplayerjointeamnospectatorcallback( callback )
{
    if ( !isdefined( level.onjointeamnospectatorcallbacks ) )
    {
        level.onjointeamnospectatorcallbacks = [];
    }
    
    level.onjointeamnospectatorcallbacks[ level.onjointeamnospectatorcallbacks.size ] = callback;
}

