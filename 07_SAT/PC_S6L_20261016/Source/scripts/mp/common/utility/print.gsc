// scripts\mp\common\utility\print.gsc  (hash_2d110487966779fc.gscc) (size: 4273 Bytes / 0x10b1 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x9d5e7248 (2640212552)
// size ...... 4273 (0x10b1)
// includes .. 1   (offset: 0xf99)
// strings ... 10  (offset: 0xfa1)
// dev strs .. 8   (offset: 0x104d)
// exports ... 14  (offset: 0xa95)
// cseg ...... 0x9c + 0x9f9 (0xa95)
// imports ... 22  (offset: 0xcc5)
// animtree1 . 0   (offset: 0x10b1)
// animtree2 . 0   (offset: 0x10b1)
#using scripts\mp\common\utility\teams;

#namespace print;

// Namespace print
// Params 2
// Checksum 0x8d579a34, Offset: 0xba
// Size: 0xa1
function printonteam( printstring, team )
{
    foreach ( player in level.players )
    {
        if ( player.team != team )
        {
            continue;
        }
        
        player iprintln( printstring );
    }
}

// Namespace print
// Params 2
// Checksum 0xa83283a3, Offset: 0x163
// Size: 0x95
function printboldonteam( text, team )
{
    assert( isdefined( level.players ) );
    
    for ( i = 0; i < level.players.size ; i++ )
    {
        player = level.players[ i ];
        
        if ( isdefined( player.pers[ "team" ] ) && player.pers[ "team" ] == team )
        {
            player iprintlnbold( text );
        }
    }
}

// Namespace print
// Params 3
// Checksum 0x321a44cb, Offset: 0x200
// Size: 0x9f
function printboldonteamarg( text, team, arg )
{
    assert( isdefined( level.players ) );
    
    for ( i = 0; i < level.players.size ; i++ )
    {
        player = level.players[ i ];
        
        if ( isdefined( player.pers[ "team" ] ) && player.pers[ "team" ] == team )
        {
            player iprintlnbold( text, arg );
        }
    }
}

// Namespace print
// Params 3
// Checksum 0xa053ee7f, Offset: 0x2a7
// Size: 0x9f
function printonteamarg( text, team, arg )
{
    assert( isdefined( level.players ) );
    
    for ( i = 0; i < level.players.size ; i++ )
    {
        player = level.players[ i ];
        
        if ( isdefined( player.pers[ "team" ] ) && player.pers[ "team" ] == team )
        {
            player iprintln( text, arg );
        }
    }
}

// Namespace print
// Params 2
// Checksum 0x5e7b3c68, Offset: 0x34e
// Size: 0x93
function printonplayers( text, team )
{
    players = level.players;
    
    for ( i = 0; i < players.size ; i++ )
    {
        if ( isdefined( team ) )
        {
            if ( isdefined( players[ i ].pers[ "team" ] ) && players[ i ].pers[ "team" ] == team )
            {
                players[ i ] iprintln( text );
            }
            
            continue;
        }
        
        players[ i ] iprintln( text );
    }
}

// Namespace print
// Params 7
// Checksum 0xcd3834, Offset: 0x3e9
// Size: 0x233
function printandsoundoneveryone( team, otherteam, printfriendly, printenemy, soundfriendly, soundenemy, printarg )
{
    shoulddosounds = isdefined( soundfriendly );
    shoulddoenemysounds = 0;
    
    if ( isdefined( soundenemy ) )
    {
        assert( shoulddosounds );
        shoulddoenemysounds = 1;
    }
    
    if ( level.splitscreen || !shoulddosounds )
    {
        for ( i = 0; i < level.players.size ; i++ )
        {
            player = level.players[ i ];
            playerteam = player.team;
            
            if ( isdefined( playerteam ) && isdefined( printarg ) )
            {
                if ( playerteam == team && isdefined( printfriendly ) )
                {
                    player iprintln( printfriendly, printarg );
                    continue;
                }
                
                if ( playerteam == otherteam && isdefined( printenemy ) )
                {
                    player iprintln( printenemy, printarg );
                }
            }
        }
        
        if ( shoulddosounds )
        {
            assert( level.splitscreen );
            level.players[ 0 ] playlocalsound( soundfriendly );
        }
        
        return;
    }
    
    assert( shoulddosounds );
    
    if ( shoulddoenemysounds )
    {
        for ( i = 0; i < level.players.size ; i++ )
        {
            player = level.players[ i ];
            playerteam = player.team;
            
            if ( isdefined( playerteam ) )
            {
                if ( playerteam == team )
                {
                    if ( isdefined( printfriendly ) )
                    {
                        player iprintln( printfriendly, printarg );
                    }
                    
                    player playlocalsound( soundfriendly );
                    continue;
                }
                
                if ( playerteam == otherteam )
                {
                    if ( isdefined( printenemy ) )
                    {
                        player iprintln( printenemy, printarg );
                    }
                    
                    player playlocalsound( soundenemy );
                }
            }
        }
        
        return;
    }
    
    for ( i = 0; i < level.players.size ; i++ )
    {
        player = level.players[ i ];
        playerteam = player.team;
        
        if ( isdefined( playerteam ) )
        {
            if ( playerteam == team )
            {
                if ( isdefined( printfriendly ) )
                {
                    player iprintln( printfriendly, printarg );
                }
                
                player playlocalsound( soundfriendly );
                continue;
            }
            
            if ( playerteam == otherteam )
            {
                if ( isdefined( printenemy ) )
                {
                    player iprintln( printenemy, printarg );
                }
            }
        }
    }
}

// Namespace print
// Params 3
// Checksum 0xe97c973c, Offset: 0x624
// Size: 0xad
function printandsoundonteam( team, printstring, soundalias )
{
    foreach ( player in level.players )
    {
        if ( player.team != team )
        {
            continue;
        }
        
        player printandsoundonplayer( printstring, soundalias );
    }
}

// Namespace print
// Params 2
// Checksum 0xc455389d, Offset: 0x6d9
// Size: 0x25
function printandsoundonplayer( printstring, soundalias )
{
    self iprintln( printstring );
    self playlocalsound( soundalias );
}

/#

    // Namespace print
    // Params 2
    // Checksum 0x773f9b4b, Offset: 0x706
    // Size: 0xab, Type: dev
    function printgameaction( msg, player )
    {
        if ( getdvarint( @"hash_dd6678cdc48d6adf", 0 ) == 1 )
        {
            return;
        }
        
        playerstring = "<dev string:x24>";
        
        if ( isdefined( player ) )
        {
            if ( isplayer( player ) )
            {
                playerstring = "<dev string:x25>" + player getentitynumber() + "<dev string:x27>" + player.name + "<dev string:x29>";
            }
            else
            {
                playerstring = "<dev string:x25>" + player getentitynumber() + "<dev string:x2c>";
            }
        }
        
        println( "<dev string:x2e>" + playerstring + msg + "<dev string:x33>" + gettime() + "<dev string:x36>" );
    }

#/

// Namespace print
// Params 3
// Checksum 0x2e9577fb, Offset: 0x7b9
// Size: 0xaf
function teamhudtutorialmessage( msg, team, time )
{
    if ( !teams::getteamdata( team, "teamCount" ) )
    {
        return;
    }
    
    foreach ( player in teams::getteamdata( team, "players" ) )
    {
        player thread tutorialprint( msg, time );
    }
}

// Namespace print
// Params 3
// Checksum 0x18623fac, Offset: 0x870
// Size: 0x51
function tutorialprint( msg, time, optional_state )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    
    if ( !isdefined( optional_state ) )
    {
        optional_state = 1;
    }
    
    self sethudtutorialmessage( msg, optional_state );
    wait time;
    self clearhudtutorialmessage();
}

// Namespace print
// Params 1
// Checksum 0x3cc450cd, Offset: 0x8c9
// Size: 0x168
function getformattedtimestamp( overriddenmilliseconds )
{
    if ( isdefined( overriddenmilliseconds ) )
    {
        milliseconds = overriddenmilliseconds;
    }
    else
    {
        milliseconds = gettime();
    }
    
    hours = int( milliseconds * 2.77778e-07 );
    milliseconds -= hours * 3600000;
    minutes = int( milliseconds * 1.66667e-05 );
    milliseconds -= minutes * 60000;
    seconds = int( milliseconds * 0.001 );
    milliseconds -= seconds * 1000;
    hourtext = undefined;
    
    if ( hours < 10 )
    {
        hourtext = "00" + hours;
    }
    else if ( hours < 100 )
    {
        hourtext = "0" + hours;
    }
    else
    {
        hourtext = string( hours );
    }
    
    minutetext = minutes < 10 ? "0" + minutes : string( minutes );
    secondtext = seconds < 10 ? "0" + seconds : string( seconds );
    mstext = undefined;
    
    if ( milliseconds < 10 )
    {
        mstext = "00" + milliseconds;
    }
    else if ( milliseconds < 100 )
    {
        mstext = "0" + milliseconds;
    }
    else
    {
        mstext = string( milliseconds );
    }
    
    return hourtext + ":" + minutetext + ":" + secondtext + ":" + mstext;
}

// Namespace print
// Params 2
// Checksum 0xf57f0e6f, Offset: 0xa3a
// Size: 0x5b
function datalogprint( message, tag )
{
    if ( !analyticsstreamerislogfilestreamingenabled() )
    {
        return;
    }
    
    text = "";
    
    if ( isdefined( tag ) )
    {
        text += "<" + tag + "> ";
    }
    
    text += message + "\n";
    analyticsstreamerlogfilewritetobuffer( text );
}

