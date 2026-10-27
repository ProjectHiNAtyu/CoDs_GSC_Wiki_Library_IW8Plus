// scripts\mp\gamestaterestore.gsc  (hash_60dd02bec5783ecd.gscc) (size: 5656 Bytes / 0x1618 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xe70e3a2f (3876469295)
// size ...... 5656 (0x1618)
// includes .. 6   (offset: 0x13a0)
// strings ... 18  (offset: 0x13d0)
// dev strs .. 12  (offset: 0x1580)
// exports ... 14  (offset: 0xe20)
// cseg ...... 0x168 + 0xcb8 (0xe20)
// imports ... 26  (offset: 0x1050)
// animtree1 . 0   (offset: 0x1618)
// animtree2 . 0   (offset: 0x1618)
#using scripts\common\utility;
#using scripts\mp\codcaster_utils;
#using scripts\mp\codcasterclientmatchdata;
#using scripts\mp\common\killstreaks\killstreaks;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\gamelogic;

#namespace gamestaterestore;

// Namespace gamestaterestore
// Params 0
// Checksum 0x9c28bb2c, Offset: 0x186
// Size: 0x8d
function setupcallbacks()
{
    println( "<dev string:x24>" );
    
    if ( getdvarint( @"hash_7dfc9d99d9c1ff2f", 0 ) == 0 )
    {
        return;
    }
    
    println( "<dev string:x3d>" );
    
    if ( isdefined( game[ "gameStateRestore" ] ) && game[ "gameStateRestore" ].enabled )
    {
        println( "<dev string:x5d>" );
        
        if ( !isdefined( level.onplayerconnectcallbacks ) )
        {
            level.onplayerconnectcallbacks = [];
        }
        
        level.onplayerconnectcallbacks[ level.onplayerconnectcallbacks.size ] = &gamestaterestore_onplayerconnect;
    }
}

// Namespace gamestaterestore
// Params 0
// Checksum 0xc19cca00, Offset: 0x21b
// Size: 0x3f
function gamestaterestore_onplayerconnect()
{
    if ( getdvarint( @"hash_7dfc9d99d9c1ff2f", 0 ) == 0 )
    {
        return;
    }
    
    println( "<dev string:x7f>" );
    
    if ( game[ "gameStateRestore" ].enabled )
    {
        thread restorestate( self );
    }
}

// Namespace gamestaterestore
// Params 1
// Checksum 0x11ec6836, Offset: 0x262
// Size: 0xf5
function restorestate( player )
{
    if ( getdvarint( @"hash_7dfc9d99d9c1ff2f", 0 ) == 0 )
    {
        return;
    }
    
    self waittill( #"giveloadout" );
    println( "<dev string:x92>" );
    gamestatedata = game[ "gameStateRestore" ];
    
    foreach ( playerdata in gamestatedata.players )
    {
        if ( playerdata.identifier != self.name )
        {
            continue;
        }
        
        restoreplayerstats( self, playerdata );
        clearplayerstate( self.name );
        break;
    }
}

// Namespace gamestaterestore
// Params 1
// Checksum 0xcf0b2126, Offset: 0x360
// Size: 0xbd
function clearplayerstate( playername )
{
    if ( getdvarint( @"hash_7dfc9d99d9c1ff2f", 0 ) == 0 )
    {
        return;
    }
    
    println( "<dev string:xa6>" );
    
    for ( i = 0; i < game[ "gameStateRestore" ].players.size ; i++ )
    {
        if ( game[ "gameStateRestore" ].players[ i ].identifier == playername )
        {
            game[ "gameStateRestore" ].players[ i ] = undefined;
            break;
        }
    }
    
    if ( game[ "gameStateRestore" ].players.size <= 0 )
    {
        game[ "gameStateRestore" ].enabled = 0;
    }
}

// Namespace gamestaterestore
// Params 0
// Checksum 0x52d2a29d, Offset: 0x425
// Size: 0x3b
function function_1be32ecf97c6b7ee()
{
    if ( getdvarint( @"hash_7dfc9d99d9c1ff2f", 0 ) == 0 )
    {
        return;
    }
    
    println( "<dev string:xbf>" );
    game[ "gameStateRestore" ] = codcaster_utils::function_dc73e47345f148f3();
    game[ "gameStateRestoreAlreadyUsed" ] = 1;
}

// Namespace gamestaterestore
// Params 1
// Checksum 0xac948153, Offset: 0x468
// Size: 0xc5
function getlifeid( playername )
{
    if ( getdvarint( @"hash_7dfc9d99d9c1ff2f", 0 ) == 0 )
    {
        return 0;
    }
    
    gamestatedata = game[ "gameStateRestore" ];
    
    foreach ( playerdata in gamestatedata.players )
    {
        if ( playerdata.identifier != playername )
        {
            continue;
        }
        
        return playerdata.deaths;
    }
    
    return 0;
}

// Namespace gamestaterestore
// Params 0
// Checksum 0x3b80cd3b, Offset: 0x536
// Size: 0xc3
function restoreteamscores()
{
    if ( getdvarint( @"hash_7dfc9d99d9c1ff2f", 0 ) == 0 )
    {
        return;
    }
    
    if ( !isdefined( game[ "gameStateRestore" ] ) || !game[ "gameStateRestore" ].enabled )
    {
        return;
    }
    
    println( "<dev string:xd6>" );
    gamestate = game[ "gameStateRestore" ];
    function_974d88eeb6c0ace9( gamestate );
    game[ "roundsPlayed" ] = gamestate.team1score + gamestate.team2score;
    
    if ( game[ "roundsPlayed" ] / level.roundswitch % 2 == 1 )
    {
        game[ "switchedsides" ] = 1;
    }
    
    function_67db8f9ad62df99d( gamestate );
    println( "<dev string:xf0>" );
    level thread gamelogic_mp::callbackserverstart();
}

// Namespace gamestaterestore
// Params 1
// Checksum 0xbf6203d1, Offset: 0x601
// Size: 0x9a
function function_974d88eeb6c0ace9( gamestate )
{
    game[ "roundsWon" ][ "allies" ] = gamestate.team1score;
    game[ "roundsWon" ][ "axis" ] = gamestate.team2score;
    game[ "teamScores" ][ "allies" ] = gamestate.team1score;
    game[ "teamScores" ][ "axis" ] = gamestate.team2score;
    setteamscore( "allies", gamestate.team1score );
    setteamscore( "axis", gamestate.team2score );
}

// Namespace gamestaterestore
// Params 1
// Checksum 0x2f8840a8, Offset: 0x6a3
// Size: 0x97
function function_67db8f9ad62df99d( gamestate )
{
    attacking_team = game[ "attackers" ];
    defending_team = game[ "defenders" ];
    
    if ( game_utility::getgametype() == "control" )
    {
        game[ "segment_captures" ][ attacking_team ] = gamestate.var_3fb15af86e0419a5;
        game[ "segment_captures" ][ defending_team ] = gamestate.var_83efbf121a15d016;
    }
    
    game[ "match_kills" ][ attacking_team ] = gamestate.team1kills;
    game[ "match_kills" ][ defending_team ] = gamestate.team2kills;
}

// Namespace gamestaterestore
// Params 2
// Checksum 0xd2e9ed9a, Offset: 0x742
// Size: 0x303
function restoreplayerstats( player, playerdata )
{
    if ( getdvarint( @"hash_7dfc9d99d9c1ff2f", 0 ) == 0 )
    {
        return;
    }
    
    if ( !isdefined( game[ "gameStateRestore" ] ) || !game[ "gameStateRestore" ].enabled )
    {
        return;
    }
    
    println( "<dev string:x10b>" );
    player.kills = playerdata.kills;
    
    if ( !isdefined( player.pers[ "kills" ] ) )
    {
        player.pers[ "kills" ] = 0;
    }
    
    if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( player ) ) )
    {
        if ( isdefined( player.leaderboarddata[ "kills" ] ) )
        {
            player.leaderboarddata[ "kills" ] = player.leaderboarddata[ "kills" ] + player.kills;
        }
        
        if ( isdefined( level.leaderboardfunc[ "kills" ] ) )
        {
            [[ level.leaderboardfunc[ "kills" ] ]]( player, player.kills );
        }
        
        assert( isint( player.kills ) || isfloat( player.kills ), "<dev string:x126>" );
        
        if ( isdefined( player.pers[ "kills" ] ) )
        {
            player.pers[ "kills" ] = player.pers[ "kills" ] + player.kills;
        }
    }
    
    player.deaths = playerdata.deaths;
    
    if ( !isdefined( player.pers[ "deaths" ] ) )
    {
        player.pers[ "deaths" ] = 0;
    }
    
    if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( player ) ) )
    {
        if ( isdefined( player.leaderboarddata[ "deaths" ] ) )
        {
            player.leaderboarddata[ "deaths" ] = player.leaderboarddata[ "deaths" ] + player.deaths;
        }
        
        if ( isdefined( level.leaderboardfunc[ "deaths" ] ) )
        {
            [[ level.leaderboardfunc[ "deaths" ] ]]( player, player.deaths );
        }
        
        assert( isint( player.deaths ) || isfloat( player.deaths ), "<dev string:x126>" );
        
        if ( isdefined( player.pers[ "deaths" ] ) )
        {
            player.pers[ "deaths" ] = player.pers[ "deaths" ] + player.deaths;
        }
    }
    
    restorekillstreaks( player, playerdata );
    restorefieldupgrade( player, playerdata );
}

// Namespace gamestaterestore
// Params 2
// Checksum 0x83c6be02, Offset: 0xa4d
// Size: 0x2dc
function restorekillstreaks( player, playerdata )
{
    if ( getdvarint( @"hash_7dfc9d99d9c1ff2f", 0 ) == 0 )
    {
        return;
    }
    
    println( "<dev string:x14c>" + player.name );
    
    if ( playerdata.killstreaksprogress < 0 )
    {
        playerdata.killstreaksprogress = 0;
    }
    
    var_b90fd7dd9a80818a = playerdata.killstreaksprogress;
    player.pers[ "cur_kill_streak" ] = var_b90fd7dd9a80818a;
    
    if ( !isdefined( player.pers[ "streakPoints" ] ) )
    {
        player.pers[ "streakPoints" ] = 0;
    }
    
    if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( player ) ) )
    {
        if ( isdefined( player.leaderboarddata[ "streakPoints" ] ) )
        {
            player.leaderboarddata[ "streakPoints" ] = player.leaderboarddata[ "streakPoints" ] + var_b90fd7dd9a80818a;
        }
        
        if ( isdefined( level.leaderboardfunc[ "streakPoints" ] ) )
        {
            [[ level.leaderboardfunc[ "streakPoints" ] ]]( player, var_b90fd7dd9a80818a );
        }
        
        assert( isint( var_b90fd7dd9a80818a ) || isfloat( var_b90fd7dd9a80818a ), "<dev string:x126>" );
        
        if ( isdefined( player.pers[ "streakPoints" ] ) )
        {
            player.pers[ "streakPoints" ] = player.pers[ "streakPoints" ] + var_b90fd7dd9a80818a;
        }
    }
    
    player codcasterclientmatchdata::function_2c4d0484259644c5( 6, var_b90fd7dd9a80818a );
    player codcasterclientmatchdata::function_2c4d0484259644c5( 7, var_b90fd7dd9a80818a );
    player.lifeid = player.deaths;
    player.pers[ "deaths" ] = player.lifeid;
    player killstreaks::givestreakpoints( #"kill", var_b90fd7dd9a80818a );
    
    for ( slotnumber = 1; slotnumber <= 3 ; slotnumber++ )
    {
        streak = playerdata.killstreaks[ slotnumber - 1 ];
        streakused = streak.used;
        streakearned = streak.earned;
        streakinslot = player killstreaks::getkillstreakinslot( slotnumber );
        
        if ( isdefined( streakinslot ) && isdefined( streakinslot.streakname ) )
        {
            streakcost = player killstreaks::calcstreakcost( streakinslot.streakname );
            
            if ( streakused )
            {
                streakinslot.available = -1;
            }
            else if ( streakearned || streakcost <= var_b90fd7dd9a80818a )
            {
                streakinslot.available = 1;
            }
            
            player killstreaks::function_916fe8d6a4485ef7( slotnumber, streakinslot.available );
        }
    }
}

// Namespace gamestaterestore
// Params 2
// Checksum 0x2e530290, Offset: 0xd31
// Size: 0x72
function function_207dfed5b9b3c04( player, playerdata )
{
    var_fff95328f91232e2 = player.super.staticdata.pointsneeded;
    percentageprogress = playerdata.fieldupgrade.progress;
    var_9844747ca9a8f1e = percentageprogress * var_fff95328f91232e2 / 100;
    return var_9844747ca9a8f1e;
}

// Namespace gamestaterestore
// Params 2
// Checksum 0x14863a34, Offset: 0xdac
// Size: 0x74
function restorefieldupgrade( player, playerdata )
{
    if ( getdvarint( @"hash_7dfc9d99d9c1ff2f", 0 ) == 0 )
    {
        return;
    }
    
    if ( playerdata.fieldupgrade.progress )
    {
        var_3768e5b61a85564c = function_207dfed5b9b3c04( player, playerdata );
        player [[ utility::getsharedfunc( #"supers", #"givesuperpoints" ) ]]( var_3768e5b61a85564c );
    }
}

