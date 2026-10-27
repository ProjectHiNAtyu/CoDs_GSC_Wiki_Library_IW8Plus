// scripts\mp\common\utility\teams.gsc  (hash_194f8050b4a6d3a1.gscc) (size: 15884 Bytes / 0x3e0c / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x147b34ba (343618746)
// size ...... 15884 (0x3e0c)
// includes .. 8   (offset: 0x37fc)
// strings ... 69  (offset: 0x383c)
// dev strs .. 13  (offset: 0x3d1c)
// exports ... 49  (offset: 0x2918)
// cseg ...... 0x7ad + 0x216b (0x2918)
// imports ... 56  (offset: 0x30c0)
// animtree1 . 0   (offset: 0x3e0c)
// animtree2 . 0   (offset: 0x3e0c)
#using scripts\common\script;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\team_utility;
#using scripts\mp\factions;
#using scripts\mp\gameinstance;
#using scripts\mp\playerlogic;

#namespace teams;

// Namespace teams
// Params 2
// Checksum 0x2f84785b, Offset: 0x7cb
// Size: 0x24, Type: bool
function function_b00ab7e503f33379( team, property )
{
    return isdefined( level.teamdata[ team ][ property ] );
}

// Namespace teams
// Params 2
// Checksum 0xddb79627, Offset: 0x7f8
// Size: 0x83
function getteamdata( team, property )
{
    var_7237854e3be197ca = level.teamdata[ team ][ property ];
    
    if ( isdefined( var_7237854e3be197ca ) )
    {
        return var_7237854e3be197ca;
    }
    
    assert( isdefined( level.teamdata[ team ] ), "<dev string:x24>" + team + "<dev string:x3e>" );
    assert( function_8f3d2f6628601447( team, property ), "<dev string:x24>" + team + "<dev string:x41>" + property + "<dev string:x44>" );
}

// Namespace teams
// Params 3
// Checksum 0x7846c5f, Offset: 0x884
// Size: 0x61
function setteamdata( team, property, value )
{
    assert( isdefined( level.teamdata[ team ] ), "<dev string:x24>" + team + "<dev string:x44>" );
    assert( isdefined( value ), "<dev string:x46>" );
    level.teamdata[ team ][ property ] = value;
}

// Namespace teams
// Params 2
// Checksum 0x4f29b401, Offset: 0x8ed
// Size: 0x6e
function function_7a3e8000e37ae33f( team, property )
{
    assert( isdefined( level.teamdata[ team ] ), "<dev string:x24>" + team + "<dev string:x44>" );
    assert( function_8f3d2f6628601447( team, property ), "<dev string:x24>" + team + "<dev string:x41>" + property + "<dev string:x44>" );
    level.teamdata[ team ][ property ] = undefined;
}

// Namespace teams
// Params 3
// Checksum 0x674caf61, Offset: 0x963
// Size: 0x99
function modifyteamdata( team, property, value )
{
    assert( isdefined( level.teamdata[ team ] ), "<dev string:x24>" + team + "<dev string:x44>" );
    assert( function_8f3d2f6628601447( team, property ), "<dev string:x24>" + team + "<dev string:x41>" + property + "<dev string:x44>" );
    assert( isdefined( value ), "<dev string:x46>" );
    level.teamdata[ team ][ property ] += value;
}

// Namespace teams
// Params 2
// Checksum 0x4843a186, Offset: 0xa04
// Size: 0x47, Type: bool
function function_8f3d2f6628601447( team, property )
{
    assert( isdefined( level.teamdata[ team ] ), "<dev string:x24>" + team + "<dev string:x44>" );
    return isdefined( level.teamdata[ team ][ property ] );
}

// Namespace teams
// Params 1
// Checksum 0xb5c5cb89, Offset: 0xa54
// Size: 0x19, Type: bool
function function_72dd2533aa375cb8( team )
{
    return isdefined( level.teamdata[ team ] );
}

// Namespace teams
// Params 3
// Checksum 0xced20122, Offset: 0xa76
// Size: 0xce
function addplayertoteam( player, team, var_cba797a7110d6a43 )
{
    assert( !arraycontains( level.teamdata[ team ][ "<dev string:x68>" ], player ), "<dev string:x70>" );
    level.teamdata[ team ][ "teamCount" ]++;
    level.teamdata[ team ][ "players" ][ level.teamdata[ team ][ "players" ].size ] = player;
    
    /#
        if ( level.teamdata[ team ][ "<dev string:x68>" ].size != level.teamdata[ team ][ "<dev string:xaa>" ] )
        {
            assertmsg( "<dev string:xb4>" );
        }
    #/
    
    if ( var_cba797a7110d6a43 )
    {
        addtoteamlives( player, team, undefined, "addPlayerToTeam" );
    }
}

// Namespace teams
// Params 2
// Checksum 0xa23183e6, Offset: 0xb4c
// Size: 0xb1
function removeplayerfromteam( player, team )
{
    assert( arraycontains( level.teamdata[ team ][ "<dev string:x68>" ], player ), "<dev string:xe4>" );
    level.teamdata[ team ][ "teamCount" ]--;
    level.teamdata[ team ][ "players" ] = arrayremove( level.teamdata[ team ][ "players" ], player );
    
    /#
        if ( level.teamdata[ team ][ "<dev string:x68>" ].size != level.teamdata[ team ][ "<dev string:xaa>" ] )
        {
            assertmsg( "<dev string:xb4>" );
        }
    #/
}

// Namespace teams
// Params 4
// Checksum 0xc25b6eb2, Offset: 0xc05
// Size: 0x1f2
function addtoteamlives( player, team, var_68e08a7602d95dd9, context = "?" )
{
    assert( isdefined( player.connecttime ) );
    
    if ( function_367247675ec0211e( player, team, context ) )
    {
        level.teamdata[ team ][ "aliveCount" ]++;
        level.teamdata[ team ][ "alivePlayers" ][ level.teamdata[ team ][ "alivePlayers" ].size ] = player;
    }
    
    if ( level.multiteambased )
    {
        level.teamdata[ team ][ "deathEvent" ] = 0;
    }
    
    validatealivecount( "add", team, player, context );
    
    if ( isdefined( level.modeaddtoteamlives ) )
    {
        [[ level.modeaddtoteamlives ]]( player, team, context );
    }
    
    if ( game_utility_mp::lpcfeaturegated() )
    {
        return;
    }
    
    if ( var_68e08a7602d95dd9 && team_utility::isgameplayteam( team ) )
    {
        foreach ( player in level.teamdata[ team ][ "players" ] )
        {
            player playlocalsound( "mp_bodycount_tick_positive" );
        }
        
        enemies = getenemyplayers( team );
        
        foreach ( player in enemies )
        {
            player playlocalsound( "mp_bodycount_tick_negative" );
        }
    }
}

// Namespace teams
// Params 3
// Checksum 0x3f573469, Offset: 0xdff
// Size: 0x14c, Type: bool
function function_367247675ec0211e( player, team, context )
{
    found = arraycontains( level.teamdata[ team ][ "alivePlayers" ], player );
    
    if ( found )
    {
        message = "[alivePlayers] Attempt to add duplicated player to alivePlayers array.";
        aliveplayers = level.teamdata[ team ][ "alivePlayers" ].size;
        alivecount = level.teamdata[ team ][ "aliveCount" ];
        dlog_recordevent( "dlog_event_alive_count_mismatch", [ "alive_players", aliveplayers, "alive_count", alivecount, "event", message, "team", team, "player_xuid", isdefined( player ) ? player getxuid() : "", "player_name", player.name ] );
        message = message + " name    =" + player.name + " team    =" + team + " context =" + context;
        assertmsg( message );
        logstring( message );
        return false;
    }
    
    return true;
}

// Namespace teams
// Params 4
// Checksum 0x59e89992, Offset: 0xf54
// Size: 0x22d
function removefromteamlives( player, team, var_68e08a7602d95dd9, context = "?" )
{
    if ( function_7b688c5a736fe0ec( player, team, context ) )
    {
        level.teamdata[ team ][ "aliveCount" ]--;
        level.teamdata[ team ][ "alivePlayers" ] = arrayremove( level.teamdata[ team ][ "alivePlayers" ], player );
    }
    
    validatealivecount( "remove", team, player, context );
    
    if ( isdefined( level.moderemovefromteamlives ) )
    {
        [[ level.moderemovefromteamlives ]]( player, team, context );
    }
    
    var_a203168df4e14fd7 = getdvarint( @"hash_dfd8480d3b3afa08", 0 );
    
    if ( var_a203168df4e14fd7 > 0 && function_d301e967593ece1b( team ) > var_a203168df4e14fd7 )
    {
        var_68e08a7602d95dd9 = 0;
    }
    
    if ( var_68e08a7602d95dd9 && team_utility::isgameplayteam( team ) )
    {
        var_98077cdff3557af4 = "mp_bodycount_tick_negative";
        var_6c2bedf88c75e10 = "mp_bodycount_tick_positive";
        
        if ( level.teamdata[ team ][ "aliveCount" ] == 1 )
        {
            var_98077cdff3557af4 = "mp_bodycount_tick_negative_final";
            var_6c2bedf88c75e10 = "mp_bodycount_tick_positive_final";
        }
        
        foreach ( player in level.teamdata[ team ][ "players" ] )
        {
            player playlocalsound( var_98077cdff3557af4 );
        }
        
        if ( !game_utility_mp::lpcfeaturegated() )
        {
            enemies = getenemyplayers( team );
            
            foreach ( player in enemies )
            {
                player playlocalsound( var_6c2bedf88c75e10 );
            }
        }
    }
}

// Namespace teams
// Params 3
// Checksum 0x2e2bc6a, Offset: 0x1189
// Size: 0x70, Type: bool
function function_7b688c5a736fe0ec( player, team, context )
{
    if ( level.teamdata[ team ][ "aliveCount" ] <= 0 )
    {
        function_8725b5388ba88b85( player, team, context );
        return false;
    }
    else if ( !arraycontains( level.teamdata[ team ][ "alivePlayers" ], player ) )
    {
        function_4d0709e0da861383( player, team, context );
        return false;
    }
    
    return true;
}

// Namespace teams
// Params 3, eflags: 0x4
// Checksum 0x7ab9943e, Offset: 0x1202
// Size: 0x80
function private function_8725b5388ba88b85( player, team, context )
{
    if ( !isdefined( player.connecttime ) )
    {
        message = "[alivePlayers] Attempt to remove a player that did not fully connect yet. (aliveCount<=0)";
        var_21e7b6f2026e4f70 = 1;
    }
    else if ( !player.hasspawned )
    {
        message = "[alivePlayers] Attempt to remove a player that did not actually spawn yet. (aliveCount<=0)";
        var_21e7b6f2026e4f70 = 1;
    }
    else
    {
        message = "[alivePlayers] Attempt to remove a player, but aliveCount<=0.";
    }
    
    function_3a9bfa9f703e74b2( player, team, context, message, var_21e7b6f2026e4f70 );
}

// Namespace teams
// Params 3, eflags: 0x4
// Checksum 0x5cebde81, Offset: 0x128a
// Size: 0x80
function private function_4d0709e0da861383( player, team, context )
{
    if ( !isdefined( player.connecttime ) )
    {
        message = "[alivePlayers] Attempt to remove a player that did not fully connect yet.";
        var_21e7b6f2026e4f70 = 1;
    }
    else if ( !player.hasspawned )
    {
        message = "[alivePlayers] Attempt to remove a player that did not actually spawn yet.";
        var_21e7b6f2026e4f70 = 1;
    }
    else
    {
        message = "[alivePlayers] Attempt to remove a player which is not in alivePlayers array.";
    }
    
    function_3a9bfa9f703e74b2( player, team, context, message, var_21e7b6f2026e4f70 );
}

// Namespace teams
// Params 5, eflags: 0x4
// Checksum 0xc8b60422, Offset: 0x1312
// Size: 0x132
function private function_3a9bfa9f703e74b2( player, team, context, message, var_21e7b6f2026e4f70 )
{
    aliveplayers = level.teamdata[ team ][ "alivePlayers" ].size ?? 0;
    alivecount = level.teamdata[ team ][ "aliveCount" ] ?? 0;
    dlog_recordevent( "dlog_event_alive_count_mismatch", [ "alive_players", aliveplayers, "alive_count", alivecount, "event", message, "team", team, "player_xuid", isdefined( player ) ? player getxuid() : "", "player_name", player.name ] );
    message = message + " name    =" + player.name + " team    =" + team + " context =" + context;
    logstring( message );
    
    if ( !var_21e7b6f2026e4f70 )
    {
        assertmsg( message );
    }
}

// Namespace teams
// Params 4
// Checksum 0x8b1e4763, Offset: 0x144c
// Size: 0x45e
function validatealivecount( eventtype, team, player, context )
{
    assert( isdefined( team ) );
    assert( isdefined( player ) );
    runfixup = getdvarint( @"scr_alive_count_fix", 1 );
    
    if ( !isdefined( context ) )
    {
        context = "?";
    }
    
    var_9405223fffd00a10 = 0;
    var_bac81e996e14b892 = 0;
    
    if ( isdefined( eventtype ) )
    {
        if ( eventtype == "disconnect" || eventtype == "extract" )
        {
            var_9405223fffd00a10 = arraycontains( level.teamdata[ team ][ "alivePlayers" ], player );
            
            if ( var_9405223fffd00a10 && runfixup )
            {
                player playerlogic::removefromalivecount( 1, "validateAliveCount" );
            }
        }
        else if ( eventtype == "add" )
        {
            var_f97f7abcad48843b = arrayremoveduplicates( level.teamdata[ team ][ "alivePlayers" ] );
            
            if ( var_f97f7abcad48843b.size < level.teamdata[ team ][ "alivePlayers" ].size )
            {
                var_bac81e996e14b892 = 1;
                eventtype += " duplicate";
            }
            
            var_2e0da82d93b15224 = function_5713d46873b29625( level.teamdata[ team ][ "alivePlayers" ] );
            
            if ( var_2e0da82d93b15224.size < level.teamdata[ team ][ "alivePlayers" ].size )
            {
                context += " undefined";
            }
        }
    }
    
    if ( !isdefined( player.var_24be19543bc8efc ) )
    {
        player.var_24be19543bc8efc = "start";
    }
    
    aliveplayers = level.teamdata[ team ][ "alivePlayers" ].size;
    alivecount = level.teamdata[ team ][ "aliveCount" ];
    
    if ( aliveplayers != alivecount || var_9405223fffd00a10 || var_bac81e996e14b892 )
    {
        message = "";
        
        if ( var_bac81e996e14b892 )
        {
            message = "WARNING: Duplicate players in alive player array! context=" + context + " history=" + player.var_24be19543bc8efc;
            script::demoforcesre( message );
        }
        else if ( var_9405223fffd00a10 )
        {
            message = "WARNING: player in alive array after disconnect! context=" + context + " history=" + player.var_24be19543bc8efc;
            script::demoforcesre( message );
        }
        else
        {
            message = "WARNING: alivePlayers and aliveCount are out of sync! context=" + context + " history=" + player.var_24be19543bc8efc;
            message += "; alive_players: " + aliveplayers;
            message += "; alive_count: " + alivecount;
            message += "; event: " + eventtype;
            message += "; team: " + team;
            message += "; player_xuid: " + ( isdefined( player ) ? player getxuid() : "" );
            message += "; player_name: " + player.name;
            var_672b0dffa61112e7 = getdvarint( @"hash_2b1c389284b21136", 1 );
            
            if ( var_672b0dffa61112e7 )
            {
                script::function_2e2007575f92910d( message );
            }
        }
        
        assertmsg( message );
        dlog_recordevent( "dlog_event_alive_count_mismatch", [ "alive_players", aliveplayers, "alive_count", alivecount, "event", eventtype, "team", team, "player_xuid", isdefined( player ) ? player getxuid() : "", "player_name", player.name ] );
        
        if ( runfixup )
        {
            level.teamdata[ team ][ "alivePlayers" ] = arrayremoveduplicates( level.teamdata[ team ][ "alivePlayers" ] );
            level.teamdata[ team ][ "aliveCount" ] = level.teamdata[ team ][ "alivePlayers" ].size;
            [[ level.updategameevents ]]();
        }
    }
    
    if ( alivecount == 0 )
    {
        foreach ( p in level.teamdata[ team ][ "players" ] )
        {
            p notify( #"no_teammates_alive" );
        }
    }
}

// Namespace teams
// Params 2
// Checksum 0x6ddf22d8, Offset: 0x18b2
// Size: 0x45
function getteamcount( team, aliveonly )
{
    if ( aliveonly )
    {
        return level.teamdata[ team ][ "alivePlayers" ].size;
    }
    
    return level.teamdata[ team ][ "players" ].size;
}

// Namespace teams
// Params 1
// Checksum 0xf0090653, Offset: 0x18ff
// Size: 0xd4
function function_d301e967593ece1b( team )
{
    players = level.teamdata[ team ][ "players" ];
    
    if ( game_utility_mp::getgametypenumlives() )
    {
        count = 0;
        
        foreach ( player in players )
        {
            if ( player::isreallyalive( player ) || player.pers[ "lives" ] > 0 )
            {
                count++;
            }
        }
        
        return count;
    }
    
    return players.size;
}

// Namespace teams
// Params 2
// Checksum 0x710d117f, Offset: 0x19db
// Size: 0xd4
function getfriendlyplayers( testteam, aliveonly )
{
    if ( aliveonly )
    {
        friends = [];
        
        foreach ( player in level.teamdata[ testteam ][ "alivePlayers" ] )
        {
            if ( isalive( player ) && !isdefined( player.fauxdead ) )
            {
                friends[ friends.size ] = player;
            }
        }
        
        return friends;
    }
    
    return level.teamdata[ testteam ][ "players" ];
}

// Namespace teams
// Params 3
// Checksum 0xa79edecb, Offset: 0x1ab8
// Size: 0x2a
function function_44f7118a75adcad8( testteam, origin, radius )
{
    return getplayersinradius( origin, radius, undefined, undefined, undefined, testteam );
}

// Namespace teams
// Params 2
// Checksum 0xc03d4d84, Offset: 0x1aeb
// Size: 0x43
function getenemyplayers( testteam, aliveonly = 0 )
{
    if ( level.multimatch ?? gameinstance::is_enabled() )
    {
        return gameinstance::get_instance_enemies( testteam, aliveonly );
    }
    
    return getenemyplayersbuiltin( aliveonly, testteam );
}

// Namespace teams
// Params 1
// Checksum 0x219ad017, Offset: 0x1b37
// Size: 0x19, Type: bool
function function_f4df3d3d69adab39( testteam )
{
    return getenemyplayers( testteam, 1 ).size > 0;
}

// Namespace teams
// Params 0
// Checksum 0xf91112dc, Offset: 0x1b59
// Size: 0x12, Type: bool
function squadasteamenabled()
{
    return getdvarint( @"hash_61be9f6a05f64523", 0 ) != 0;
}

// Namespace teams
// Params 3
// Checksum 0xda84db6, Offset: 0x1b74
// Size: 0x60
function function_d032b36d01bbbab3( team, squadindex, aliveonly )
{
    if ( squadasteamenabled() )
    {
        return getsquadmates( team, squadindex, aliveonly );
    }
    
    if ( aliveonly )
    {
        return level.teamdata[ team ][ "alivePlayers" ];
    }
    
    return level.teamdata[ team ][ "players" ];
}

// Namespace teams
// Params 3
// Checksum 0x22191166, Offset: 0x1bdc
// Size: 0xf3
function getsquadmates( testteam, testsquadindex, aliveonly )
{
    if ( function_19884deb93dc0d0b( testteam, testsquadindex ) )
    {
        if ( aliveonly )
        {
            squadmates = [];
            
            foreach ( player in level.squaddata[ testteam ][ testsquadindex ].players )
            {
                if ( player::isreallyalive( player ) )
                {
                    squadmates[ squadmates.size ] = player;
                }
            }
            
            return squadmates;
        }
        else
        {
            return level.squaddata[ testteam ][ testsquadindex ].players;
        }
    }
    
    return getfriendlyplayers( testteam, aliveonly );
}

// Namespace teams
// Params 1
// Checksum 0xe23a1c22, Offset: 0x1cd8
// Size: 0x28
function function_bf897b798fb184b7( player )
{
    return function_19884deb93dc0d0b( player.team, player.sessionsquadid );
}

// Namespace teams
// Params 1
// Checksum 0xdf25a2da, Offset: 0x1d09
// Size: 0x28
function function_72b89edf6b47c40a( player )
{
    return getsquaddata( player.team, player.sessionsquadid );
}

// Namespace teams
// Params 2
// Checksum 0x7b235226, Offset: 0x1d3a
// Size: 0x1f, Type: bool
function function_19884deb93dc0d0b( team, squadindex )
{
    return isdefined( getsquaddata( team, squadindex ) );
}

// Namespace teams
// Params 2
// Checksum 0x37acfbfe, Offset: 0x1d62
// Size: 0x23
function getsquaddata( team, squadindex )
{
    return level.squaddata[ team ][ squadindex ];
}

// Namespace teams
// Params 2
// Checksum 0x1dc228a4, Offset: 0x1d8e
// Size: 0xad
function getenemycount( testteam, aliveonly )
{
    count = 0;
    enemyteams = team_utility::getenemyteams( testteam );
    
    foreach ( team in enemyteams )
    {
        count += getteamcount( team, istrue( aliveonly ) );
    }
    
    return count;
}

// Namespace teams
// Params 1
// Checksum 0xc6c400a9, Offset: 0x1e44
// Size: 0xa7, Type: bool
function function_f2b980a5ef176703( team )
{
    if ( !isdefined( team ) )
    {
        return false;
    }
    
    var_a3ec3f8a322ccc96 = game_utility::getgametype() == "dmz";
    var_4081b8b1191c67e2 = team == "team_hundred_ninety_four" || team == "team_hundred_ninety_two" || team == "team_hundred_ninety_three" || team == "team_hundred_ninety_four" || team == "team_hundred_ninety_five" || team == "team_hundred_ninety_six" || team == "team_hundred_ninety_seven" || team == "team_hundred_ninety_eight" || team == "team_hundred_ninety_nine";
    return var_a3ec3f8a322ccc96 && var_4081b8b1191c67e2;
}

// Namespace teams
// Params 1
// Checksum 0xfff5396e, Offset: 0x1ef4
// Size: 0x47, Type: bool
function function_4890199ce55e3939( team )
{
    if ( !isdefined( team ) )
    {
        return false;
    }
    
    var_56043d66c29080bc = game_utility::getgametype() == "ob";
    var_4081b8b1191c67e2 = team == "team_hundred_ninety";
    return var_56043d66c29080bc && var_4081b8b1191c67e2;
}

// Namespace teams
// Params 1
// Checksum 0x4422cfae, Offset: 0x1f44
// Size: 0x20, Type: bool
function function_4081b8b1191c67e2( team )
{
    return function_f2b980a5ef176703( team ) || function_4890199ce55e3939( team );
}

// Namespace teams
// Params 1
// Checksum 0x35d2df2c, Offset: 0x1f6d
// Size: 0x10
function getfaction( team )
{
    return game[ team ];
}

// Namespace teams
// Params 1
// Checksum 0x2b0a4476, Offset: 0x1f86
// Size: 0x1a5
function function_a5c04e4d6a5cc5d3( teamref )
{
    bundle = factions::function_65475e03edad0e6( level.teamdata[ teamref ][ "teamFaction" ] );
    game[ teamref ] = bundle.ref;
    
    if ( !isdefined( level.teamdata[ teamref ][ "teamName" ] ) )
    {
        level.teamdata[ teamref ][ "teamName" ] = bundle.name;
    }
    
    if ( !isdefined( level.teamdata[ teamref ][ "shortName" ] ) )
    {
        level.teamdata[ teamref ][ "shortName" ] = bundle.shortname;
    }
    
    if ( !isdefined( level.teamdata[ teamref ][ "teamIcon" ] ) )
    {
        level.teamdata[ teamref ][ "teamIcon" ] = bundle.var_ef7e3ab9ae5a35d0;
    }
    
    if ( !isdefined( level.teamdata[ teamref ][ "headIcon" ] ) )
    {
        level.teamdata[ teamref ][ "headIcon" ] = bundle.headicon;
    }
    
    if ( !isdefined( level.teamdata[ teamref ][ "soundInfix" ] ) )
    {
        level.teamdata[ teamref ][ "soundInfix" ] = bundle.var_c0ff6a29595ee4da;
    }
    
    if ( !isdefined( level.teamdata[ teamref ][ "customizationInfix" ] ) )
    {
        level.teamdata[ teamref ][ "customizationInfix" ] = bundle.customizationInfix;
    }
    
    if ( !isdefined( level.teamdata[ teamref ][ "superFaction" ] ) )
    {
        level.teamdata[ teamref ][ "superFaction" ] = bundle.var_163b6409eaa0ac00;
    }
}

// Namespace teams
// Params 1
// Checksum 0xa3821dbe, Offset: 0x2133
// Size: 0x6e
function getteamname( teamref )
{
    if ( !isdefined( level.teamdata[ teamref ][ "teamName" ] ) )
    {
        faction = getfaction( teamref );
        level.teamdata[ teamref ][ "teamName" ] = factions::function_65475e03edad0e6( faction ).name;
    }
    
    return level.teamdata[ teamref ][ "teamName" ];
}

// Namespace teams
// Params 1
// Checksum 0x8f147905, Offset: 0x21aa
// Size: 0x6e
function getteamshortname( teamref )
{
    if ( !isdefined( level.teamdata[ teamref ][ "shortName" ] ) )
    {
        faction = getfaction( teamref );
        level.teamdata[ teamref ][ "shortName" ] = factions::function_65475e03edad0e6( faction ).shortname;
    }
    
    return level.teamdata[ teamref ][ "shortName" ];
}

// Namespace teams
// Params 1
// Checksum 0x47346ae5, Offset: 0x2221
// Size: 0x6e
function getteamicon( teamref )
{
    if ( !isdefined( level.teamdata[ teamref ][ "teamIcon" ] ) )
    {
        faction = getfaction( teamref );
        level.teamdata[ teamref ][ "teamIcon" ] = factions::function_65475e03edad0e6( faction ).var_ef7e3ab9ae5a35d0;
    }
    
    return level.teamdata[ teamref ][ "teamIcon" ];
}

// Namespace teams
// Params 1
// Checksum 0xd0081c6e, Offset: 0x2298
// Size: 0x6e
function getteamheadicon( teamref )
{
    if ( !isdefined( level.teamdata[ teamref ][ "headIcon" ] ) )
    {
        faction = getfaction( teamref );
        level.teamdata[ teamref ][ "headIcon" ] = factions::function_65475e03edad0e6( faction ).headicon;
    }
    
    return level.teamdata[ teamref ][ "headIcon" ];
}

// Namespace teams
// Params 1
// Checksum 0x35aa27a6, Offset: 0x230f
// Size: 0x6e
function getteamvoiceinfix( teamref )
{
    if ( !isdefined( level.teamdata[ teamref ][ "soundInfix" ] ) )
    {
        faction = getfaction( teamref );
        level.teamdata[ teamref ][ "soundInfix" ] = factions::function_65475e03edad0e6( faction ).var_c0ff6a29595ee4da;
    }
    
    return level.teamdata[ teamref ][ "soundInfix" ];
}

// Namespace teams
// Params 1
// Checksum 0xe70d1a7c, Offset: 0x2386
// Size: 0x9a
function function_1f6fdae0bcdd5de1( teamref )
{
    factionbundle = factions::function_65475e03edad0e6( level.teamdata[ teamref ][ "teamFaction" ] );
    
    if ( factionbundle.var_3d3e96ae1761bfd4 )
    {
        var_7237854e3be197ca = level.var_6149c575df2880e6[ factionbundle.var_3d3e96ae1761bfd4 ];
        
        if ( isdefined( var_7237854e3be197ca ) )
        {
            return var_7237854e3be197ca;
        }
        
        bundle = getscriptbundle( factionbundle.var_3d3e96ae1761bfd4 );
        level.var_6149c575df2880e6[ factionbundle.var_3d3e96ae1761bfd4 ] = bundle;
        return bundle;
    }
}

// Namespace teams
// Params 1
// Checksum 0x344336c9, Offset: 0x2428
// Size: 0x6e
function getcustomizationprefix( teamref )
{
    if ( !isdefined( level.teamdata[ teamref ][ "customizationInfix" ] ) )
    {
        faction = getfaction( teamref );
        level.teamdata[ teamref ][ "customizationInfix" ] = factions::function_65475e03edad0e6( faction ).customizationInfix;
    }
    
    return level.teamdata[ teamref ][ "customizationInfix" ];
}

// Namespace teams
// Params 1
// Checksum 0x3b46bf06, Offset: 0x249f
// Size: 0x6e
function function_9d9e01cee9e21a3a( teamref )
{
    if ( !isdefined( level.teamdata[ teamref ][ "superFaction" ] ) )
    {
        faction = getfaction( teamref );
        level.teamdata[ teamref ][ "superFaction" ] = factions::function_65475e03edad0e6( faction ).var_163b6409eaa0ac00;
    }
    
    return level.teamdata[ teamref ][ "superFaction" ];
}

// Namespace teams
// Params 1
// Checksum 0xe28a8497, Offset: 0x2516
// Size: 0x298
function getteamfactionsfrommap( teamref )
{
    mapbundle = getmapscriptbundle();
    mapfaction = undefined;
    var_9666b85a60a27aab = %"hash_6a3e9234e0d7e26d";
    
    if ( !isdefined( level.teamdata[ teamref ][ "teamFaction" ] ) )
    {
        if ( isdefined( mapbundle ) && !isbrgamemode() )
        {
            switch ( teamref )
            {
                case #"hash_7c2d091e6337bf54":
                    mapfaction = mapbundle.team1faction;
                    break;
                case #"hash_5f54b9bf7583687f":
                    mapfaction = mapbundle.team2faction;
                    break;
                case #"hash_11f9d28d306ceab7":
                    mapfaction = mapbundle.team3faction;
                    break;
                case #"hash_de35e9ca17933bf1":
                    mapfaction = mapbundle.team4faction;
                    break;
                case #"hash_ec4dd0ca1ec42f41":
                    mapfaction = mapbundle.team5faction;
                    break;
                case #"hash_cb45d282427f65a7":
                    mapfaction = mapbundle.team6faction;
                    break;
                case #"hash_8a9d4436c70ae70a":
                    mapfaction = mapbundle.team7faction;
                    break;
                case #"hash_ef370c26555cab94":
                    mapfaction = mapbundle.team8faction;
                    break;
                case #"hash_8d23b0993c08e541":
                    mapfaction = mapbundle.var_b2d0841e5fd9076;
                    break;
                case #"hash_e32cf9824f75eaf8":
                    mapfaction = mapbundle.var_c001b4c17fb4082a;
                    break;
                default:
                    mapfaction = mapbundle.team2faction;
                    break;
            }
            
            if ( !isdefined( mapfaction ) || mapfaction == "" )
            {
                println( "<dev string:x11f>" + teamref + "<dev string:x12c>" + level.mapname );
                mapfaction = var_9666b85a60a27aab;
            }
            
            level.teamdata[ teamref ][ "teamFaction" ] = mapfaction;
        }
        else
        {
            println( "<dev string:x151>" + level.mapname );
            projectscriptbundle = getprojectscriptbundle();
            
            if ( teamref == "allies" )
            {
                level.teamdata[ teamref ][ "teamFaction" ] = projectscriptbundle.var_4f9ccf29999eeeff;
            }
            else
            {
                level.teamdata[ teamref ][ "teamFaction" ] = projectscriptbundle.var_3dbff451234b4f52;
            }
            
            if ( !isdefined( level.teamdata[ teamref ][ "teamFaction" ] ) )
            {
                level.teamdata[ teamref ][ "teamFaction" ] = var_9666b85a60a27aab;
            }
        }
    }
    
    return level.teamdata[ teamref ][ "teamFaction" ];
}

// Namespace teams
// Params 0
// Checksum 0x3252be48, Offset: 0x27b7
// Size: 0x10
function getcustomgametypeteammax()
{
    return getmatchrulesdata( "commonOption", "teamCount" );
}

// Namespace teams
// Params 0
// Checksum 0x1ea54d7b, Offset: 0x27d0
// Size: 0x98
function calculatenumteamswithplayers()
{
    numteamswithplayers = 0;
    
    foreach ( team in level.teamdata )
    {
        if ( team[ "players" ].size > 0 )
        {
            numteamswithplayers++;
        }
    }
    
    level.numteamswithplayers = numteamswithplayers;
}

// Namespace teams
// Params 1
// Checksum 0x1f662c02, Offset: 0x2870
// Size: 0xa7
function getteamindex( team )
{
    if ( !isstring( team ) )
    {
        team = team.team;
    }
    
    if ( isdefined( team ) )
    {
        foreach ( index, teamname in level.allteamnamelist )
        {
            if ( team == teamname )
            {
                return index;
            }
        }
    }
    
    return 0;
}

