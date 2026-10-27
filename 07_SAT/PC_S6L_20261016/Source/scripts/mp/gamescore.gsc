// scripts\mp\gamescore.gsc  (hash_267a69c97e3c6c7c.gscc) (size: 27690 Bytes / 0x6c2a / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x59cd9e69 (1506647657)
// size ...... 27690 (0x6c2a)
// includes .. 27  (offset: 0x6522)
// strings ... 53  (offset: 0x65fa)
// dev strs .. 17  (offset: 0x6b52)
// exports ... 57  (offset: 0x4b96)
// cseg ...... 0x3cf + 0x47c7 (0x4b96)
// imports ... 126 (offset: 0x547e)
// animtree1 . 0   (offset: 0x6c2a)
// animtree2 . 0   (offset: 0x6c2a)
#using scripts\common\callbacks;
#using scripts\common\script;
#using scripts\common\telemetry_utils;
#using scripts\common\utility;
#using scripts\common\weapon;
#using scripts\mp\challenges;
#using scripts\mp\common\utility\dialog;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\gameplay_telemetry_utils;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\rejoin_utility;
#using scripts\mp\common\utility\team_utility;
#using scripts\mp\common\utility\teams;
#using scripts\mp\common\utility\weapon;
#using scripts\mp\common\utility\weapon_utility;
#using scripts\mp\damage;
#using scripts\mp\flags;
#using scripts\mp\gameinstance;
#using scripts\mp\gamelogic;
#using scripts\mp\gameplay_telemetry;
#using scripts\mp\persistence;
#using scripts\mp\playerstats_interface;
#using scripts\mp\rank;
#using scripts\mp\weaponrank;

#namespace gamescore;

// Namespace gamescore
// Params 1
// Checksum 0xc67c7b, Offset: 0x3ed
// Size: 0x1af
function gethighestscoringteam( instance )
{
    highestscore = 0;
    highestteam = undefined;
    highesttied = 0;
    teams = [];
    
    if ( level.multimatch ?? gameinstance::is_enabled() )
    {
        if ( isdefined( instance ) )
        {
            teams = instance.teams;
        }
        else
        {
            foreach ( instance in gameinstance::function_1d3a8144ddb36029() )
            {
                if ( isdefined( instance.winner ) )
                {
                    continue;
                }
                
                teams = arraycombine( teams, instance.teams );
            }
        }
    }
    else
    {
        teams = level.teamnamelist;
    }
    
    foreach ( entry in teams )
    {
        teamscore = game[ "teamScores" ][ entry ];
        
        if ( !isdefined( highestteam ) || teamscore > highestscore )
        {
            highestscore = teamscore;
            highestteam = entry;
            highesttied = 0;
            continue;
        }
        
        if ( teamscore == highestscore )
        {
            highesttied = 1;
        }
    }
    
    if ( highesttied )
    {
        return "tie";
    }
    
    return highestteam;
}

// Namespace gamescore
// Params 1
// Checksum 0x27c7824b, Offset: 0x5a4
// Size: 0xdc
function gethighestscore( ignoreteam )
{
    highestscore = 0;
    highestteam = undefined;
    
    foreach ( entry in level.teamnamelist )
    {
        if ( entry == ignoreteam )
        {
            continue;
        }
        
        teamscore = game[ "teamScores" ][ entry ];
        
        if ( !isdefined( highestteam ) || teamscore > highestscore )
        {
            highestscore = teamscore;
            highestteam = entry;
        }
    }
    
    return [ highestteam, game[ "teamScores" ][ highestteam ] ];
}

// Namespace gamescore
// Params 0
// Checksum 0xf206ca6a, Offset: 0x689
// Size: 0xe7
function updateteamscoreplacements()
{
    level notify( #"updateteamscoreplacement" );
    level endon( #"updateteamscoreplacement" );
    waittillframeend();
    teamssorted = tablesort( game[ "teamScores" ], 1 );
    currentscore = undefined;
    place = 0;
    
    foreach ( team in teamssorted )
    {
        score = game[ "teamScores" ][ team ];
        
        if ( !isdefined( currentscore ) || score < currentscore )
        {
            currentscore = score;
            place++;
        }
        
        game[ "teamPlacements" ][ team ] = place;
    }
}

// Namespace gamescore
// Params 0
// Checksum 0xd410b26f, Offset: 0x778
// Size: 0x9
function getteamscoreplacements()
{
    return game[ "teamPlacements" ];
}

// Namespace gamescore
// Params 2
// Checksum 0x23936383, Offset: 0x78a
// Size: 0x2c, Type: bool
function compareteamscores( left, right )
{
    return left.score > right.score;
}

// Namespace gamescore
// Params 0
// Checksum 0x4266d738, Offset: 0x7bf
// Size: 0x2f
function gethighestscoringplayer()
{
    updateplacement();
    
    if ( !level.placement[ "all" ].size )
    {
        return;
    }
    
    return level.placement[ "all" ][ 0 ];
}

// Namespace gamescore
// Params 1
// Checksum 0x4c205a, Offset: 0x7f7
// Size: 0x203, Type: bool
function function_495db9d10bdbdfbb( targetrank )
{
    if ( !isdefined( level.placement[ "all" ] ) || level.placement[ "all" ].size <= 0 )
    {
        return false;
    }
    
    players = level.placement[ "all" ];
    betterscores = 0;
    
    if ( level.var_702ea1a2fc683e54 )
    {
        playerkills = getplayerkills( self );
        
        foreach ( other in players )
        {
            if ( getplayerkills( other ) > playerkills )
            {
                betterscores++;
            }
        }
    }
    else if ( level.var_b9f5b44894d6b0f3 )
    {
        playerscore = function_c4e9c0d93ad95905( self );
        
        foreach ( other in players )
        {
            if ( function_c4e9c0d93ad95905( other ) > playerscore )
            {
                betterscores++;
            }
        }
    }
    else
    {
        playerscore = getplayerscore( self );
        
        foreach ( other in players )
        {
            if ( getplayerscore( other ) > playerscore )
            {
                betterscores++;
            }
        }
    }
    
    return betterscores < targetrank;
}

// Namespace gamescore
// Params 0
// Checksum 0xbd843058, Offset: 0xa03
// Size: 0x91
function function_c5118def88a4bf90()
{
    if ( level.var_620407c02e27532a )
    {
        return level.var_620407c02e27532a;
    }
    
    var_246199732bf07d17 = function_7243d45b5d82f431( level.players, #objectivescore, 1 );
    level.var_620407c02e27532a = var_246199732bf07d17[ 0 ];
    
    if ( var_246199732bf07d17[ 1 ].objectivescore > 0 )
    {
        level.var_f3b7fd0d1b9f700a = var_246199732bf07d17[ 1 ];
    }
    
    if ( var_246199732bf07d17[ 2 ].objectivescore > 0 )
    {
        level.var_96f53e2b6f96db91 = var_246199732bf07d17[ 2 ];
    }
    
    return level.var_620407c02e27532a;
}

// Namespace gamescore
// Params 0
// Checksum 0x6c1565d4, Offset: 0xa9d
// Size: 0x63, Type: bool
function ishighestscoringplayertied()
{
    if ( level.placement[ "all" ].size > 1 )
    {
        firstscore = getplayerscore( level.placement[ "all" ][ 0 ] );
        secondscore = getplayerscore( level.placement[ "all" ][ 1 ] );
        return ( firstscore == secondscore );
    }
    
    return false;
}

// Namespace gamescore
// Params 0
// Checksum 0x5505e66b, Offset: 0xb09
// Size: 0x147
function getlosingplayers()
{
    losingplayers = [];
    
    if ( isdefined( level.var_29c1e82ec1325523 ) )
    {
        foreach ( player in level.players )
        {
            if ( ![[ level.var_29c1e82ec1325523 ]]( player ) )
            {
                losingplayers[ losingplayers.size ] = player;
            }
        }
    }
    else
    {
        updateplacement();
        players = level.placement[ "all" ];
        
        foreach ( player in players )
        {
            if ( player == level.placement[ "all" ][ 0 ] )
            {
                continue;
            }
            
            losingplayers[ losingplayers.size ] = player;
        }
    }
    
    return losingplayers;
}

// Namespace gamescore
// Params 5
// Checksum 0x8f6c8ece, Offset: 0xc59
// Size: 0x69b
function giveplayerscore( event, points, victim, objweapon, eventinfo )
{
    if ( level.gameended )
    {
        isvalidevent = 0;
        
        if ( isarray( event ) )
        {
            if ( isnumber( level.gameendtime ) )
            {
                if ( event[ 1 ] <= level.gameendtime )
                {
                    isvalidevent = 1;
                    event = event[ 0 ];
                }
            }
        }
        else if ( isdefined( event ) )
        {
            isvalidevent = 1;
        }
        
        if ( !isvalidevent )
        {
            return;
        }
    }
    else if ( isarray( event ) )
    {
        event = event[ 0 ];
    }
    
    if ( level.ignorescoring )
    {
        var_bbbdde8daf7862 = 1;
        var_42c077b88db74a9c = isbrgamemode() && !flags::gameflag( "prematch_done" );
        
        if ( var_42c077b88db74a9c )
        {
            var_bbbdde8daf7862 = 0;
        }
        
        if ( var_bbbdde8daf7862 )
        {
            return;
        }
    }
    
    if ( !level.teambased && level.roundscorelimit > 1 )
    {
        if ( game_utility_mp::issimultaneouskillenabled() )
        {
            if ( level.var_702ea1a2fc683e54 )
            {
                if ( self.pers[ "kills" ] > level.roundscorelimit )
                {
                    return;
                }
            }
            else if ( level.var_b9f5b44894d6b0f3 )
            {
                if ( self.pers[ "extrascore5" ] > level.roundscorelimit )
                {
                    return;
                }
            }
            else if ( self.pers[ "score" ] >= level.roundscorelimit )
            {
                return;
            }
        }
        else
        {
            foreach ( player in level.players )
            {
                if ( level.var_702ea1a2fc683e54 )
                {
                    if ( player.pers[ "kills" ] > level.roundscorelimit )
                    {
                        return;
                    }
                    
                    continue;
                }
                
                if ( level.var_b9f5b44894d6b0f3 )
                {
                    if ( player.pers[ "extrascore5" ] > level.roundscorelimit )
                    {
                        return;
                    }
                    
                    continue;
                }
                
                if ( player.pers[ "score" ] >= level.roundscorelimit )
                {
                    return;
                }
            }
        }
    }
    
    player = self;
    
    if ( isdefined( self.owner ) && !isbot( self ) )
    {
        player = self.owner;
    }
    
    if ( !isplayer( player ) )
    {
        return;
    }
    
    originalpoints = points;
    
    if ( isdefined( level.onplayerscore ) )
    {
        points = [[ level.onplayerscore ]]( event, player, points, victim, eventinfo );
    }
    
    if ( points == 0 )
    {
        return;
    }
    
    if ( points > 0 )
    {
        challenges::function_fd33e53ba9311bd4( player, points, event );
    }
    
    if ( rank::function_3df8217e471be8f7( event ) )
    {
        player.objectivescore = int( max( player.pers[ "objectivescore" ] + points, 0 ) );
        player.pers[ "objectivescore" ] = player.objectivescore;
        
        if ( level.gamemodebundle.var_ef398d9e813bb617 )
        {
            self setplayerdata( level.var_6f9b00680ed002d8, "objectivescore", player.objectivescore );
        }
    }
    
    if ( isdefined( level.sharedfuncs[ #"gametype" ][ #"hash_ca3a60c41e2523bd" ] ) )
    {
        player [[ level.sharedfuncs[ #"gametype" ][ #"hash_ca3a60c41e2523bd" ] ]]( event, points );
    }
    
    player.pers[ "score" ] = int( max( player.pers[ "score" ] + points, 0 ) );
    
    if ( level.var_931ca47cc298f7af == #"display_score" )
    {
        shouldpopup = 1;
        popuppoints = originalpoints;
        
        if ( level.var_23730bd6be76cb84 )
        {
            if ( self.var_e111789bdf9bcbda.var_1478d6a5815e4bf5 )
            {
                popuppoints += self.var_e111789bdf9bcbda.objectivekillpoints ?? 0;
            }
            else if ( self.var_e111789bdf9bcbda.isobjectivekill && !self.var_e111789bdf9bcbda.var_6f5494110caa9950 )
            {
                if ( !isdefined( self.var_e111789bdf9bcbda.objectivekillpoints ) )
                {
                    self.var_e111789bdf9bcbda.objectivekillpoints = 0;
                }
                
                self.var_e111789bdf9bcbda.objectivekillpoints += originalpoints;
                self.var_e111789bdf9bcbda.var_6f5494110caa9950 = 1;
                shouldpopup = 0;
            }
        }
        
        if ( shouldpopup )
        {
            player points::displayscoreeventpoints( popuppoints, event );
        }
    }
    
    player playerstats_interface::addtoplayerstat( int( originalpoints ), "matchStats", "score" );
    assert( isdefined( level.gamemodebundle.maxclientscore ), "<dev string:x24>" );
    maxscore = level.gamemodebundle.maxclientscore;
    
    if ( isdefined( maxscore ) )
    {
        var_a35b3876ed6e8741 = player.pers[ "score" ];
        
        if ( var_a35b3876ed6e8741 > maxscore )
        {
            player.pers[ "score" ] = maxscore;
            var_a35b3876ed6e8741 = maxscore;
        }
        
        player.score = var_a35b3876ed6e8741;
    }
    
    if ( !level.var_e1fd4528aac1d956 && level.gametypebundle.var_d7fdfcde8fad3fc4 )
    {
        player challenges::function_dfbecfc4b862a692();
    }
    
    player persistence::statsetchild( "round", "score", player.score );
    player gamelogic_mp::checkplayerscorelimitsoon();
    player thread gamelogic_mp::checkscorelimit();
    player script::bufferednotify( "earned_score_buffered", points );
    telemetry_utils::function_af2d366f9522f76f( "callback_player_score_event", { #points:points, #scoreevent:event, #player:player } );
    player callback::callback( #"hash_d06b059fdd983fc3", { #objweapon:objweapon, #victim:victim, #points:points, #event:event } );
    spm = player gameplay_telemetry_utils::function_8f71c8ffb480ebc3();
    player gameplay_telemetry::function_f98fbe3bbb2ed9f1( "inStatSPM", 1, spm );
}

// Namespace gamescore
// Params 2
// Checksum 0x8ca686a8, Offset: 0x12fc
// Size: 0x7b
function setplayerscore( player, score )
{
    if ( !isnumber( score ) )
    {
        assertmsg( "<dev string:x59>" + score );
        return;
    }
    
    if ( score == player.pers[ "score" ] )
    {
        return;
    }
    
    if ( score < 0 )
    {
        return;
    }
    
    player.pers[ "score" ] = score;
    player.score = score;
    player thread gamelogic_mp::checkscorelimit();
}

// Namespace gamescore
// Params 1
// Checksum 0x65d0a351, Offset: 0x137f
// Size: 0x25
function getplayerscore( player = self )
{
    return player.pers[ "score" ];
}

// Namespace gamescore
// Params 1
// Checksum 0xe9682c96, Offset: 0x13ad
// Size: 0x25
function function_78736ecffb73080c( player = self )
{
    return player.pers[ "objectivescore" ];
}

// Namespace gamescore
// Params 1
// Checksum 0x24ff4194, Offset: 0x13db
// Size: 0x25
function function_28debfd611d37dfb( player = self )
{
    return player.pers[ "objTime" ];
}

// Namespace gamescore
// Params 1, eflags: 0x4
// Checksum 0x5cc074e0, Offset: 0x1409
// Size: 0x25
function private function_c4e9c0d93ad95905( player = self )
{
    return player.pers[ "extrascore5" ];
}

// Namespace gamescore
// Params 1, eflags: 0x4
// Checksum 0x65d0a355, Offset: 0x1437
// Size: 0x25
function private getplayerkills( player = self )
{
    return player.pers[ "kills" ];
}

// Namespace gamescore
// Params 1
// Checksum 0x9990f612, Offset: 0x1465
// Size: 0xb7
function function_8a6aa766879b2b53( team )
{
    sorted = [];
    
    if ( level.teambased )
    {
        assert( team_utility::isgameplayteam( team ) );
        players = level.teamdata[ team ][ "players" ];
        sorted = arraysort( players, undefined, &sortbyscore );
    }
    else
    {
        players = level.players;
        
        if ( level.var_702ea1a2fc683e54 )
        {
            sorted = arraysort( players, undefined, &function_dce9f49cf9bffb7c );
        }
        else if ( level.var_b9f5b44894d6b0f3 )
        {
            sorted = arraysort( players, undefined, &function_cd8f871d531b23d9 );
        }
        else
        {
            sorted = arraysort( players, undefined, &sortbyscore );
        }
    }
    
    return sorted;
}

// Namespace gamescore
// Params 2
// Checksum 0xe25253b0, Offset: 0x1525
// Size: 0x26, Type: bool
function sortbyscore( lhs, rhs )
{
    return getplayerscore( lhs ) > getplayerscore( rhs );
}

// Namespace gamescore
// Params 2
// Checksum 0xb8d23346, Offset: 0x1554
// Size: 0x26, Type: bool
function function_cd8f871d531b23d9( lhs, rhs )
{
    return function_c4e9c0d93ad95905( lhs ) > function_c4e9c0d93ad95905( rhs );
}

// Namespace gamescore
// Params 2
// Checksum 0xffac5b40, Offset: 0x1583
// Size: 0x26, Type: bool
function function_dce9f49cf9bffb7c( lhs, rhs )
{
    return getplayerkills( lhs ) > getplayerkills( rhs );
}

// Namespace gamescore
// Params 0
// Checksum 0x5516a0c6, Offset: 0x15b2
// Size: 0x6d
function checkffascorejip()
{
    if ( !game_utility_mp::matchmakinggame() )
    {
        return;
    }
    
    if ( level.nojip )
    {
        return;
    }
    
    if ( level.roundscorelimit > 0 )
    {
        scorepercentage = self.score / level.roundscorelimit * 100;
        
        if ( scorepercentage > level.scorepercentagecutoff )
        {
            setnojipscore( 1, 1 );
            level.nojip = 1;
        }
    }
}

// Namespace gamescore
// Params 2
// Checksum 0x906e5047, Offset: 0x1627
// Size: 0x116
function updaterecentscoringpulse( team, score )
{
    self notify( "updateRecentScoringPulse_" + team );
    self endon( "updateRecentScoringPulse_" + team );
    level endon( #"game_ended" );
    
    if ( !isdefined( level.var_de33dcc2866f7000 ) )
    {
        level.var_de33dcc2866f7000 = [];
    }
    
    if ( !isdefined( level.var_de33dcc2866f7000[ team ] ) )
    {
        level.var_de33dcc2866f7000[ team ] = 0;
    }
    
    level.var_de33dcc2866f7000[ team ] += score;
    var_4a989d9cecc633 = level.gametypebundle.teamscorepulse.var_d359d585bb5db829;
    
    if ( level.var_de33dcc2866f7000[ team ] >= var_4a989d9cecc633 )
    {
        setomnvar( "ui_pulse_" + team, 1 );
    }
    
    timethreshold = level.gametypebundle.teamscorepulse.var_beee749509bc2318;
    wait timethreshold;
    level.var_de33dcc2866f7000[ team ] = 0;
    setomnvar( "ui_pulse_" + team, 0 );
}

// Namespace gamescore
// Params 6
// Checksum 0x48d35184, Offset: 0x1745
// Size: 0x38d
function giveteamscoreforobjective( team, score, allowtie, scoreevent, skipdialog, var_b24ab0ef98745bd8 )
{
    if ( game_utility_mp::cantiebysimultaneouskill() )
    {
        allowtie = 1;
    }
    
    if ( !isdefined( allowtie ) )
    {
        allowtie = 0;
    }
    
    if ( level.gameended && !allowtie )
    {
        return;
    }
    
    if ( level.ignorescoring )
    {
        return;
    }
    
    if ( !team_utility::isgameplayteam( team ) )
    {
        return;
    }
    
    if ( level.dontendonscore && getteamscore( team ) >= level.scorelimit )
    {
        return;
    }
    
    if ( allowtie )
    {
        if ( level.roundscorelimit > 1 && game[ "teamScores" ][ team ] >= level.roundscorelimit )
        {
            return;
        }
    }
    else if ( level.roundscorelimit > 1 && !level.dontendonscore )
    {
        foreach ( entry in level.teamnamelist )
        {
            if ( game[ "teamScores" ][ entry ] >= level.roundscorelimit )
            {
                return;
            }
        }
    }
    
    pulseenabled = isdefined( level.gametypebundle.teamscorepulse ) && level.gametypebundle.teamscorepulse.var_f53f83ff5ce80085;
    
    if ( pulseenabled )
    {
        thread updaterecentscoringpulse( team, score );
    }
    
    setteamscore( team, getteamscore( team ) + score, allowtie );
    level notify( #"update_team_score", team, getteamscore( team ) );
    
    if ( isdefined( level.onteamscore ) )
    {
        [[ level.onteamscore ]]( team, getteamscore( team ), scoreevent );
    }
    
    if ( isdefined( var_b24ab0ef98745bd8 ) )
    {
        winningteam = var_b24ab0ef98745bd8;
    }
    else
    {
        winningteam = calculatewinningteam( allowtie );
    }
    
    if ( !skipdialog )
    {
        playscorestatusdialog( winningteam, allowtie, level.waswinning );
    }
    
    if ( winningteam != "none" && winningteam != "tie" )
    {
        level.waswinning = winningteam;
        teamscore = getteamscore( winningteam );
        scorelimit = level.roundscorelimit;
        
        if ( teamscore == 0 || scorelimit == 0 )
        {
            return;
        }
        
        scorepercentage = teamscore / scorelimit * 100;
        
        if ( !game_utility_mp::isroundbased() && isdefined( level.nojip ) && !level.nojip )
        {
            if ( !level.gametypebundle.var_dc9908e56ab8c95d && scorepercentage > level.scorepercentagecutoff )
            {
                setnojipscore( 1, 1 );
                level.nojip = 1;
            }
        }
    }
    
    if ( isdefined( level.callbacks[ #"hash_a37384ae9852bf80" ] ) || isdefined( level.callbacks[ #"hash_a37384ae9852bf80" ] ) )
    {
        var_ce192dd7023f4bc8 = { #winningteam:winningteam, #allowtie:allowtie, #teamscore:teamscore, #team:team };
        level callback::callback( #"hash_a37384ae9852bf80", var_ce192dd7023f4bc8 );
    }
}

// Namespace gamescore
// Params 6
// Checksum 0xac966daa, Offset: 0x1ada
// Size: 0x391
function function_5b307c617e2bdbb1( team, score, allowtie, scoreevent, skipdialog, var_b24ab0ef98745bd8 )
{
    if ( game_utility_mp::cantiebysimultaneouskill() )
    {
        allowtie = 1;
    }
    
    if ( !isdefined( allowtie ) )
    {
        allowtie = 0;
    }
    
    if ( level.gameended && !allowtie )
    {
        return;
    }
    
    if ( level.ignorescoring )
    {
        return;
    }
    
    if ( !team_utility::isgameplayteam( team ) )
    {
        return;
    }
    
    if ( level.dontendonscore && getteamscore( team ) >= level.scorelimit )
    {
        return;
    }
    
    if ( allowtie )
    {
        if ( level.roundscorelimit > 1 && game[ "teamScores" ][ team ] >= level.roundscorelimit )
        {
            return;
        }
    }
    else if ( level.roundscorelimit > 1 && !level.dontendonscore )
    {
        foreach ( entry in level.teamnamelist )
        {
            if ( game[ "teamScores" ][ entry ] >= level.roundscorelimit )
            {
                return;
            }
        }
    }
    
    pulseenabled = isdefined( level.gametypebundle.teamscorepulse ) && level.gametypebundle.teamscorepulse.var_f53f83ff5ce80085;
    
    if ( pulseenabled )
    {
        thread updaterecentscoringpulse( team, score * -1 );
    }
    
    setteamscore( team, getteamscore( team ) - score, allowtie );
    level notify( #"update_team_score", team, getteamscore( team ) );
    
    if ( isdefined( level.onteamscore ) )
    {
        [[ level.onteamscore ]]( team, getteamscore( team ), scoreevent );
    }
    
    if ( isdefined( var_b24ab0ef98745bd8 ) )
    {
        winningteam = var_b24ab0ef98745bd8;
    }
    else
    {
        winningteam = calculatewinningteam( allowtie );
    }
    
    if ( !skipdialog )
    {
        playscorestatusdialog( winningteam, allowtie, level.waswinning );
    }
    
    if ( winningteam != "none" && winningteam != "tie" )
    {
        level.waswinning = winningteam;
        teamscore = getteamscore( winningteam );
        scorelimit = level.roundscorelimit;
        
        if ( teamscore == 0 || scorelimit == 0 )
        {
            return;
        }
        
        scorepercentage = teamscore / scorelimit * 100;
        
        if ( !game_utility_mp::isroundbased() && isdefined( level.nojip ) && !level.nojip )
        {
            if ( !level.gametypebundle.var_dc9908e56ab8c95d && scorepercentage > level.scorepercentagecutoff )
            {
                setnojipscore( 1, 1 );
                level.nojip = 1;
            }
        }
    }
    
    if ( isdefined( level.callbacks[ #"hash_a37384ae9852bf80" ] ) || isdefined( level.callbacks[ #"hash_a37384ae9852bf80" ] ) )
    {
        var_ce192dd7023f4bc8 = { #winningteam:winningteam, #allowtie:allowtie, #teamscore:teamscore, #team:team };
        level callback::callback( #"hash_a37384ae9852bf80", var_ce192dd7023f4bc8 );
    }
}

// Namespace gamescore
// Params 3
// Checksum 0xf7aa6cb2, Offset: 0x1e73
// Size: 0x157
function playscorestatusdialog( winningteam, allowtie, waswinning )
{
    if ( !level.splitscreen && winningteam != waswinning && gettime() - level.lastscorestatustime > 5000 && game_utility_mp::getscorelimit() != 1 )
    {
        if ( isdefined( level.delayleadtakendialog ) )
        {
            level thread playleadtakendialog( allowtie );
            return;
        }
        
        if ( winningteam == "none" && waswinning != "none" )
        {
            foreach ( team in level.teamnamelist )
            {
                dialog::leaderdialog( #"lead_tied", team, "status" );
            }
            
            return;
        }
        
        level.lastscorestatustime = gettime();
        dialog::leaderdialog( #"lead_taken", winningteam, "status" );
        
        if ( waswinning != "none" )
        {
            dialog::leaderdialog( #"lead_lost", waswinning, "status" );
        }
    }
}

// Namespace gamescore
// Params 1
// Checksum 0x1a5af736, Offset: 0x1fd2
// Size: 0x180
function playleadtakendialog( allowtie )
{
    wait level.delayleadtakendialog;
    level.lastscorestatustime = gettime();
    winningteam = calculatewinningteam( allowtie );
    
    if ( winningteam == "none" && level.waswinning != "none" )
    {
        foreach ( team in level.teamnamelist )
        {
            dialog::leaderdialog( #"lead_tied", team, "status" );
        }
        
        return;
    }
    
    dialog::leaderdialog( #"lead_taken", winningteam, "status" );
    
    foreach ( entry in level.teamnamelist )
    {
        if ( entry != winningteam )
        {
            dialog::leaderdialog( #"lead_lost", entry, "status" );
        }
    }
}

// Namespace gamescore
// Params 1
// Checksum 0x1a214aca, Offset: 0x215a
// Size: 0x16e
function calculatewinningteam( allowtie )
{
    assert( level.teambased == 1 );
    teams_list = level.teamnamelist;
    
    if ( !isdefined( level.waswinning ) )
    {
        level.waswinning = "none";
    }
    
    winning_team = "none";
    winning_score = 0;
    
    if ( level.waswinning != "none" )
    {
        winning_team = level.waswinning;
        winning_score = game[ "teamScores" ][ level.waswinning ];
    }
    
    /#
        var_e888c3fea5a7c9c1 = 1;
    #/
    
    foreach ( teamname in teams_list )
    {
        if ( teamname == level.waswinning )
        {
            continue;
        }
        
        if ( game[ "teamScores" ][ teamname ] > winning_score )
        {
            winning_team = teamname;
            winning_score = game[ "teamScores" ][ teamname ];
            
            /#
                var_e888c3fea5a7c9c1 = 1;
            #/
            
            continue;
        }
        
        if ( game[ "teamScores" ][ teamname ] == winning_score )
        {
            /#
                var_e888c3fea5a7c9c1 += 1;
            #/
            
            winning_team = "none";
        }
    }
    
    return winning_team;
}

// Namespace gamescore
// Params 3
// Checksum 0x7d01eadf, Offset: 0x22d1
// Size: 0x86
function setteamscore( team, teamscore, allowtie )
{
    if ( teamscore < 0 )
    {
        teamscore = 0;
    }
    
    if ( teamscore == game[ "teamScores" ][ team ] )
    {
        return;
    }
    
    game[ "teamScores" ][ team ] = teamscore;
    updateteamscore( team );
    
    if ( !level.dontendonscore )
    {
        if ( level.multimatch ?? gameinstance::is_enabled() )
        {
            gameinstance::check_score_limit( team, allowtie );
            return;
        }
        
        thread gamelogic_mp::roundend_checkscorelimit( team, allowtie );
    }
}

// Namespace gamescore
// Params 1
// Checksum 0x7e1e36a4, Offset: 0x235f
// Size: 0x118
function updateteamscore( team )
{
    assert( level.teambased );
    teamscore = 0;
    
    if ( level.multimatch ?? gameinstance::is_enabled() )
    {
        teamscore = game[ #"tournamentdata" ].roundlosslimit - game[ "roundsLost" ][ team ];
    }
    else if ( level.gametypebundle.scoringstrategy == #"teamscores" || level.gametypebundle.scoringstrategy == #"teamhealth" )
    {
        teamscore = getteamscore( team );
    }
    else if ( level.gametypebundle.scoringstrategy == #"roundswon" )
    {
        teamscore = game[ "roundsWon" ][ team ];
    }
    else
    {
        assert( 0, "<dev string:x81>" + level.gametypebundle.scoringstrategy );
    }
    
    setteamscore( team, int( teamscore ) );
    level thread updateteamscoreplacements();
}

// Namespace gamescore
// Params 1
// Checksum 0x904b43b1, Offset: 0x247f
// Size: 0x210
function updatetotalteamscore( team )
{
    assert( level.teambased );
    
    if ( !isdefined( game[ "totalScore" ] ) )
    {
        game[ "totalScore" ] = [];
        
        foreach ( entry in level.teamnamelist )
        {
            game[ "totalScore" ][ entry ] = 0;
        }
    }
    
    switch ( level.gametypebundle.scoringstrategy )
    {
        case #"roundswon":
            game[ "teamScores" ][ team ] = game[ "roundsWon" ][ team ];
            break;
        case #"teamscores":
        case #"teamhealth":
            if ( game_utility_mp::inovertime() && !level.var_b0149cef1f44aaed )
            {
                game[ "teamScores" ][ team ] = game[ "preOvertimeScore" ][ team ] + game[ "overtimeScore" ][ team ] + game[ "teamScores" ][ team ];
            }
            else if ( game_utility_mp::resetscoreonroundstart() )
            {
                game[ "totalScore" ][ team ] = game[ "totalScore" ][ team ] + game[ "teamScores" ][ team ];
                game[ "teamScores" ][ team ] = game[ "totalScore" ][ team ];
            }
            
            break;
        default:
            assertmsg( "<dev string:xa0>" + level.gametypebundle.scoringstrategy );
            break;
    }
    
    if ( level.multimatch ?? gameinstance::is_enabled() )
    {
        game[ "teamScores" ][ team ] = game[ #"tournamentdata" ].roundlosslimit - game[ "roundsLost" ][ team ];
    }
    
    setteamscore( team, int( game[ "teamScores" ][ team ] ) );
}

// Namespace gamescore
// Params 0
// Checksum 0x45ba2195, Offset: 0x2697
// Size: 0x360
function updateovertimescore()
{
    if ( level.var_b0149cef1f44aaed )
    {
        return;
    }
    
    if ( game[ "overtimeRoundsPlayed" ] == 0 )
    {
        if ( !isdefined( game[ "preOvertimeScore" ] ) )
        {
            game[ "preOvertimeScore" ] = [];
            
            foreach ( entry in level.teamnamelist )
            {
                game[ "preOvertimeScore" ][ entry ] = 0;
            }
        }
        
        foreach ( entry in level.teamnamelist )
        {
            game[ "preOvertimeScore" ][ entry ] = game[ "teamScores" ][ entry ] + game[ "totalScore" ][ entry ];
        }
    }
    
    if ( !isdefined( game[ "overtimeScore" ] ) )
    {
        game[ "overtimeScore" ] = [];
        
        foreach ( entry in level.teamnamelist )
        {
            game[ "overtimeScore" ][ entry ] = 0;
        }
    }
    
    foreach ( entry in level.teamnamelist )
    {
        game[ "overtimeScore" ][ entry ] = game[ "overtimeScore" ][ entry ] + game[ "teamScores" ][ entry ] - game[ "preOvertimeScore" ][ entry ];
    }
    
    if ( !game_utility_mp::iswinbytworulegametype() )
    {
        game[ "teamScores" ][ game[ "attackers" ] ] = 0;
        setteamscore( game[ "attackers" ], 0 );
        game[ "teamScores" ][ game[ "defenders" ] ] = 0;
        setteamscore( game[ "defenders" ], 0 );
        
        if ( game_utility_mp::istimetobeatvalid() && game[ "timeToBeatTeam" ] == game[ "attackers" ] )
        {
            game[ "teamScores" ][ game[ "attackers" ] ] = game[ "timeToBeatScore" ];
            updateteamscore( game[ "attackers" ] );
            game[ "overtimeScore" ][ game[ "attackers" ] ] = game[ "overtimeScore" ][ game[ "attackers" ] ] - game[ "timeToBeatScore" ];
        }
        
        if ( game_utility_mp::istimetobeatvalid() && game[ "timeToBeatTeam" ] == game[ "defenders" ] )
        {
            game[ "teamScores" ][ game[ "defenders" ] ] = game[ "timeToBeatScore" ];
            updateteamscore( game[ "defenders" ] );
            game[ "overtimeScore" ][ game[ "defenders" ] ] = game[ "overtimeScore" ][ game[ "defenders" ] ] - game[ "timeToBeatScore" ];
        }
    }
}

// Namespace gamescore
// Params 1
// Checksum 0x44372ba7, Offset: 0x29ff
// Size: 0x2b
function getteamscore( team )
{
    if ( !isdefined( game[ "teamScores" ][ team ] ) )
    {
        return 0;
    }
    
    return int( game[ "teamScores" ][ team ] );
}

// Namespace gamescore
// Params 1
// Checksum 0x47dd856a, Offset: 0x2a33
// Size: 0x9c
function function_c9e7a345331fe1c6( squad )
{
    squadscore = 0;
    
    foreach ( player in squad.players )
    {
        squadscore += getplayerscore( player );
    }
    
    return int( squadscore );
}

// Namespace gamescore
// Params 0
// Checksum 0xbca86d4, Offset: 0x2ad8
// Size: 0x106
function removedisconnectedplayerfromplacement()
{
    if ( !isdefined( level.placement[ "all" ] ) )
    {
        return;
    }
    
    numplayers = level.placement[ "all" ].size;
    found = 0;
    
    for ( i = 0; i < numplayers ; i++ )
    {
        if ( level.placement[ "all" ][ i ] == self )
        {
            found = 1;
        }
        
        if ( found )
        {
            level.placement[ "all" ][ i ] = level.placement[ "all" ][ i + 1 ];
        }
    }
    
    if ( !found )
    {
        return;
    }
    
    level.placement[ "all" ][ numplayers - 1 ] = undefined;
    assert( level.placement[ "<dev string:xbb>" ].size == numplayers - 1 );
    
    if ( level.teambased )
    {
        participatingteams = game_utility_mp::function_cd6aa714027fb767( self.team );
        updateteamplacement( participatingteams );
    }
}

// Namespace gamescore
// Params 2
// Checksum 0x5c3e7e56, Offset: 0x2be6
// Size: 0x2a1
function updateplacement( players, teams )
{
    if ( isdefined( level.placement[ "all" ] ) && isdefined( level.placementtime ) && level.placementtime == gettime() )
    {
        return;
    }
    
    if ( !isdefined( players ) )
    {
        players = level.players;
    }
    
    if ( !isdefined( teams ) )
    {
        teams = level.teamnamelist;
    }
    
    placement = [];
    level.placementtime = gettime();
    
    if ( isdefined( level.var_29c1e82ec1325523 ) )
    {
        return;
    }
    
    foreach ( player in players )
    {
        if ( isdefined( player.connectedpostgame ) )
        {
            continue;
        }
        
        playerteam = player.pers[ "team" ];
        
        if ( playerteam == "spectator" || playerteam == "codcaster" || playerteam == "none" )
        {
            continue;
        }
        
        if ( isdefined( level.lastplayerwins ) )
        {
            if ( player == level.lastplayerwins )
            {
                player.lastplayerwins = 1;
            }
            else
            {
                player.lastplayerwins = 0;
            }
        }
        
        placement[ placement.size ] = player;
    }
    
    if ( placement.size > 0 )
    {
        if ( isdefined( level.lastplayerwins ) )
        {
            level.placement[ "all" ] = function_7243d45b5d82f431( placement, #lastplayerwins, 1, #score, 1, #deaths, 0 );
        }
        else if ( level.var_702ea1a2fc683e54 )
        {
            level.placement[ "all" ] = function_7243d45b5d82f431( placement, #kills, 1, #deaths, 0 );
        }
        else if ( level.var_b9f5b44894d6b0f3 )
        {
            level.placement[ "all" ] = function_7243d45b5d82f431( placement, #extrascore5, 1, #deaths, 0 );
        }
        else
        {
            level.placement[ "all" ] = function_7243d45b5d82f431( placement, #score, 1, #deaths, 0 );
        }
    }
    else
    {
        level.placement[ "all" ] = [];
    }
    
    if ( level.teambased )
    {
        updateteamplacement( teams );
    }
}

// Namespace gamescore
// Params 1
// Checksum 0x58c521a5, Offset: 0x2e8f
// Size: 0x77
function function_ca38b93f32c7b685( player )
{
    if ( !isdefined( level.placement[ "all" ] ) )
    {
        return -1;
    }
    
    for ( i = 0; i < level.placement[ "all" ].size ; i++ )
    {
        placementplayer = level.placement[ "all" ][ i ];
        
        if ( player == placementplayer )
        {
            return ( i + 1 );
        }
    }
    
    return -1;
}

// Namespace gamescore
// Params 1
// Checksum 0xa4397904, Offset: 0x2f0f
// Size: 0x149
function updateteamplacement( teams )
{
    assert( level.teambased );
    
    foreach ( entry in teams )
    {
        level.placement[ entry ] = [];
    }
    
    foreach ( player in level.placement[ "all" ] )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        team = player.pers[ "team" ];
        level.placement[ team ][ level.placement[ team ].size ] = player;
    }
}

// Namespace gamescore
// Params 4
// Checksum 0xfd10b82e, Offset: 0x3060
// Size: 0x42
function processassist( killedplayer, objweapon, bonusmagnitude, damage )
{
    if ( isdefined( level.assists_disabled ) )
    {
        return;
    }
    
    processassist_regularmp( killedplayer, objweapon, bonusmagnitude, damage );
}

// Namespace gamescore
// Params 4
// Checksum 0x391e020d, Offset: 0x30aa
// Size: 0x90c
function processassist_regularmp( killedplayer, objweapon, bonusmagnitude, damage )
{
    self endon( #"disconnect" );
    killedplayer endon( #"disconnect" );
    
    if ( isagent( self ) )
    {
        return;
    }
    
    if ( objweapon.basename == "white_phosphorus_proj_mp" )
    {
        return;
    }
    
    if ( !isdefined( bonusmagnitude ) )
    {
        bonusmagnitude = 0;
    }
    
    eventtime = gettime();
    var_67a0ce58a8449913 = isagent( killedplayer );
    var_8cbc90174584ebb7 = isbot( killedplayer );
    var_ea59c9adbd586004 = isai( killedplayer );
    victimteam = undefined;
    
    if ( var_67a0ce58a8449913 )
    {
        victimteam = killedplayer.team;
    }
    else
    {
        victimteam = killedplayer.pers[ "team" ];
    }
    
    victimorigin = killedplayer.origin;
    attackerdata = killedplayer.attackerdata[ self.guid ];
    var_94c8c18325092537 = { #var_475c778a68b2acec:attackerdata.attackerent.var_43e842120378ce83[ killedplayer.guid ], #var_797fc84e38cc569a:player::isplayerads() };
    assert( isdefined( attackerdata ) );
    var_3e5becaa3a32aa4d = attackerdata.var_2a11f150d0e7dca4 > 0;
    wait 0.05;
    script::waittillslowprocessallowed();
    var_1e074d485eb927a7 = self.pers[ "team" ];
    
    if ( !team_utility::isgameplayteam( var_1e074d485eb927a7 ) )
    {
        return;
    }
    
    if ( var_1e074d485eb927a7 == victimteam && level.teambased )
    {
        return;
    }
    
    if ( level.gamemodebundle.var_2fc669d4ccb1f63e )
    {
        if ( !isdefined( self.var_9b5953146269e8f8 ) )
        {
            self.var_9b5953146269e8f8 = 0;
        }
        
        self.var_9b5953146269e8f8++;
        function_8bac4c78118c9526( var_8cbc90174584ebb7 );
        thread points::doscoreevent( #"elimination_assist", objweapon, undefined, undefined, killedplayer );
        callback::callback( #"elimination_assist", { #victim:killedplayer, #attackerweaponobj:objweapon } );
        thread challenges::function_3ef859e4837f4249( killedplayer, self, objweapon, undefined, var_94c8c18325092537 );
        statsweapon = weapon_utility::function_8097c50c526bd683( objweapon );
        gameplay_telemetry::function_3b8d40426c725ea0( "weap_kills", statsweapon.basename, 3 );
        weapkills = self.pers[ "weap_kills" ][ statsweapon.basename ] ?? 0;
        weapdeaths = self.pers[ "weap_deaths" ][ statsweapon.basename ] ?? 0;
        weaponkd = weapkills / max( weapdeaths, 1 );
        gameplay_telemetry::function_83a6a8db9fcbb065( "weap_kdratio", statsweapon.basename, 3, weaponkd, 0 );
        self.pers[ "telemetry" ].eliminations++;
        thread gamelogic_mp::threadedsetweaponstatbyname( objweapon, 1, "eliminations", killedplayer );
        
        if ( !self.pers[ "ignoreWeaponMatchBonus" ] && ( weapon::iscacprimaryweapon( objweapon ) || weapon::iscacsecondaryweapon( objweapon ) ) )
        {
            if ( !isdefined( self.pers[ "weaponMatchBonusKills" ] ) )
            {
                self.pers[ "weaponMatchBonusKills" ] = 1;
            }
            else
            {
                self.pers[ "weaponMatchBonusKills" ]++;
            }
            
            if ( self.pers[ "weaponMatchBonusKills" ] > weaponrank::getgametypekillspermatchmaximum() )
            {
                self.pers[ "ignoreWeaponMatchBonus" ] = 1;
                self.pers[ "weaponMatchBonusKills" ] = undefined;
                self.pers[ "killsPerWeapon" ] = undefined;
            }
        }
    }
    else if ( level.gamemodebundle.var_e8db2c40ab74d2e4 )
    {
        if ( level.gamemodebundle.var_137e949ff01c2fa2 )
        {
            if ( damage < level.gamemodebundle.var_e6bbecce83b2e9d7 )
            {
                return;
            }
            
            if ( damage < level.gamemodebundle.var_26d540835272ec44 )
            {
                var_74f2e2f922a030e1 = level.gamemodebundle.var_26d540835272ec44;
            }
            else
            {
                var_74f2e2f922a030e1 = damage - damage % 10;
            }
            
            thread points::doscoreevent( #"assist", objweapon, var_74f2e2f922a030e1, undefined, killedplayer );
        }
        else
        {
            thread points::doscoreevent( #"assist", objweapon, undefined, undefined, killedplayer );
        }
        
        function_8bac4c78118c9526( var_8cbc90174584ebb7 );
        thread challenges::function_3ef859e4837f4249( killedplayer, self, objweapon, undefined, var_94c8c18325092537 );
    }
    else
    {
        pointsoverride = undefined;
        xpoverride = undefined;
        event = #"assist";
        
        if ( !level.teambased )
        {
            event = #"assist_ffa";
        }
        
        points = rank::getscoreinfovalue( event );
        xp = rank::getscoreinfoxp( event );
        
        if ( isdefined( points ) && isdefined( xp ) )
        {
            if ( !level.teambased )
            {
                xpoverride = xp + xp * bonusmagnitude;
                pointsoverride = points + points * bonusmagnitude;
                thread points::doscoreevent( #"assist_ffa", objweapon, pointsoverride, xpoverride );
            }
            else
            {
                xpoverride = xp + xp * bonusmagnitude;
                pointsoverride = points + points * bonusmagnitude;
                thread points::doscoreevent( [ #"assist", eventtime ], objweapon, pointsoverride, xpoverride );
            }
            
            callback::callback( #"player_kill_assist", { #weaponobj:objweapon, #attacker:self } );
        }
        
        if ( isdefined( self.perks[ "specialty_killer_assistant" ] ) )
        {
            if ( !isdefined( self.perks[ "specialty_killstreak_to_scorestreak" ] ) )
            {
                if ( self.var_25d4504104dd20c9[ "assists" ] == self.var_c9f6aba8d1d626a8 )
                {
                    if ( !weapon::iskillstreakweapon( objweapon ) && !weapon::issuperweapon( objweapon ) && isdefined( self.perks[ "specialty_killer_assistant" ] ) )
                    {
                        thread points::givestreakpointswithtext( #"assist_killer", objweapon, 1 );
                        thread points::doscoreevent( #"assist_killer", objweapon );
                    }
                }
            }
            else if ( !weapon::iskillstreakweapon( objweapon ) && !weapon::issuperweapon( objweapon ) && isdefined( self.perks[ "specialty_killer_assistant" ] ) )
            {
                thread points::doscoreevent( #"assist_killer", objweapon );
            }
            
            self notify( #"assist_killer" );
        }
        
        if ( !var_67a0ce58a8449913 )
        {
            function_8bac4c78118c9526( var_8cbc90174584ebb7 );
            script::bufferednotify( "assist_buffered", self.modifiers );
            additionalparams = undefined;
            
            if ( !getdvarint( @"hash_dda9d67c21b0f4b4", 0 ) )
            {
                additionalparams = [];
                additionalparams[ #"attacked_before_downed" ] = var_3e5becaa3a32aa4d;
            }
            
            thread challenges::function_3ef859e4837f4249( killedplayer, self, objweapon, additionalparams );
        }
    }
    
    suspiciouskill = 0;
    suspiciousdown = 0;
    
    if ( utility::issharedfuncdefined( #"game", #"hash_e9102cee294e5077" ) )
    {
        [ suspiciouskill, suspiciousdown ] = utility::callsharedfunc( #"game", #"hash_e9102cee294e5077", killedplayer, killedplayer.laststandattacker );
    }
    
    if ( suspiciouskill <= 0 && suspiciousdown <= 0 )
    {
        if ( getdvarint( @"hash_dda9d67c21b0f4b4", 0 ) )
        {
            if ( isdefined( level.var_38896f7c8ea269da ) )
            {
                self [[ level.var_38896f7c8ea269da ]]( "assist", killedplayer );
            }
        }
        else if ( isdefined( level.var_38896f7c8ea269da ) && var_3e5becaa3a32aa4d )
        {
            self [[ level.var_38896f7c8ea269da ]]( "assist", killedplayer );
        }
    }
    
    if ( level.teambased )
    {
        nearplayers = utility::playersinsphere( self.origin, 300 );
        
        foreach ( player in nearplayers )
        {
            if ( self.team != player.team || self == player )
            {
                continue;
            }
            
            if ( !player::isreallyalive( player ) )
            {
                continue;
            }
            
            self.modifiers[ "buddy_kill" ] = 1;
            break;
        }
    }
    
    var_6c2c150894af98a9 = self getplayermovementstate();
    level callback::callback( #"hash_6c71d319dc089c27", { #var_6c2c150894af98a9:var_6c2c150894af98a9, #isprimary:weapon::isprimaryweapon( objweapon ), #victim:killedplayer, #iskillstreak:weapon::iskillstreakweapon( objweapon ), #objweapon:objweapon, #attacker:self, #event:#"hash_44cee0689be43248" } );
}

// Namespace gamescore
// Params 1
// Checksum 0xed6ee499, Offset: 0x39be
// Size: 0x1e0
function function_8bac4c78118c9526( var_8cbc90174584ebb7 )
{
    var_f583596cffdeda3d = self;
    
    if ( !game_utility::function_245a95d184375f25() )
    {
        var_f583596cffdeda3d playerstats_interface::addtoplayerstat( 1, "combatStats", "assists" );
    }
    
    if ( isdefined( var_f583596cffdeda3d.pers ) && var_f583596cffdeda3d.pers[ "assists" ] < 999 )
    {
        if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( var_f583596cffdeda3d ) ) )
        {
            if ( isdefined( var_f583596cffdeda3d.leaderboarddata[ "assists" ] ) )
            {
                var_f583596cffdeda3d.leaderboarddata[ "assists" ] = var_f583596cffdeda3d.leaderboarddata[ "assists" ] + 1;
            }
            
            if ( isdefined( level.leaderboardfunc[ "assists" ] ) )
            {
                [[ level.leaderboardfunc[ "assists" ] ]]( var_f583596cffdeda3d, 1 );
            }
            
            assert( isint( 1 ) || isfloat( 1 ), "<dev string:xbf>" );
            
            if ( isdefined( var_f583596cffdeda3d.pers[ "assists" ] ) )
            {
                var_f583596cffdeda3d.pers[ "assists" ] = var_f583596cffdeda3d.pers[ "assists" ] + 1;
            }
        }
        
        if ( var_8cbc90174584ebb7 )
        {
            if ( !isdefined( var_f583596cffdeda3d.pers[ "telemetry" ].bot_assists ) )
            {
                var_f583596cffdeda3d.pers[ "telemetry" ].bot_assists = 0;
            }
            
            var_f583596cffdeda3d.pers[ "telemetry" ].bot_assists++;
        }
        
        var_f583596cffdeda3d.assists = var_f583596cffdeda3d.pers[ "assists" ];
        var_f583596cffdeda3d persistence::statsetchild( "round", "assists", var_f583596cffdeda3d.assists, level.ignorekdrstats );
    }
}

// Namespace gamescore
// Params 1
// Checksum 0x6854cb10, Offset: 0x3ba6
// Size: 0x23
function processshieldassist( killedplayer )
{
    if ( isdefined( level.assists_disabled ) )
    {
        return;
    }
    
    processshieldassist_regularmp( killedplayer );
}

// Namespace gamescore
// Params 1
// Checksum 0x383a5c98, Offset: 0x3bd1
// Size: 0x251
function processshieldassist_regularmp( killedplayer )
{
    self endon( #"disconnect" );
    killedplayer endon( #"disconnect" );
    wait 0.05;
    script::waittillslowprocessallowed();
    
    if ( !team_utility::isgameplayteam( self.pers[ "team" ] ) )
    {
        return;
    }
    
    if ( self.pers[ "team" ] == killedplayer.pers[ "team" ] )
    {
        return;
    }
    
    thread points::doscoreevent( #"shield_assist" );
    
    if ( !game_utility::function_245a95d184375f25() )
    {
        playerstats_interface::addtoplayerstat( 1, "combatStats", "assists" );
    }
    
    if ( self.pers[ "assists" ] < 998 )
    {
        if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( self ) ) )
        {
            if ( isdefined( self.leaderboarddata[ "assists" ] ) )
            {
                self.leaderboarddata[ "assists" ] = self.leaderboarddata[ "assists" ] + 1;
            }
            
            if ( isdefined( level.leaderboardfunc[ "assists" ] ) )
            {
                [[ level.leaderboardfunc[ "assists" ] ]]( self, 1 );
            }
            
            assert( isint( 1 ) || isfloat( 1 ), "<dev string:xbf>" );
            
            if ( isdefined( self.pers[ "assists" ] ) )
            {
                self.pers[ "assists" ] = self.pers[ "assists" ] + 1;
            }
        }
        
        self.assists = self.pers[ "assists" ];
        persistence::statsetchild( "round", "assists", self.assists, level.ignorekdrstats );
    }
    
    assistweapon = self getcurrentweapon();
    
    if ( isdefined( killedplayer.attackerdata[ self.guid ] ) )
    {
        attackerdata = killedplayer.attackerdata[ self.guid ];
        
        if ( isdefined( attackerdata.objweapon ) )
        {
            assistweapon = attackerdata.objweapon;
        }
    }
    
    thread challenges::function_3ef859e4837f4249( killedplayer, self, assistweapon );
    
    if ( isdefined( level.var_38896f7c8ea269da ) )
    {
        self [[ level.var_38896f7c8ea269da ]]( "assist" );
    }
}

// Namespace gamescore
// Params 0
// Checksum 0xd24f9b4a, Offset: 0x3e2a
// Size: 0x22
function initassisttrackers()
{
    self notify( #"hash_524b32f68d901135" );
    self.buffedbyplayers = [];
    self.debuffedbyplayers = [];
}

// Namespace gamescore
// Params 3
// Checksum 0xc9fe425, Offset: 0x3e54
// Size: 0xa7
function trackdebuffassist( attacker, victim, weapon )
{
    if ( game_utility_mp::runleanthreadmode() )
    {
        return;
    }
    
    assert( isdefined( victim.debuffedbyplayers ), "<dev string:xe5>" );
    
    if ( !isdefined( victim.debuffedbyplayers[ weapon ] ) )
    {
        victim.debuffedbyplayers[ weapon ] = [];
    }
    
    if ( !isdefined( victim.debuffedbyplayers[ weapon ][ attacker getentitynumber() ] ) )
    {
        victim.debuffedbyplayers[ weapon ][ attacker getentitynumber() ] = 0;
    }
    
    victim.debuffedbyplayers[ weapon ][ attacker getentitynumber() ]++;
}

// Namespace gamescore
// Params 3
// Checksum 0x6e880f80, Offset: 0x3f03
// Size: 0x161
function untrackdebuffassist( attacker, victim, weapon )
{
    if ( game_utility_mp::runleanthreadmode() )
    {
        return;
    }
    
    assert( isdefined( victim.debuffedbyplayers ), "<dev string:x12d>" );
    
    if ( isdefined( attacker ) )
    {
        if ( isdefined( victim.debuffedbyplayers[ weapon ][ attacker getentitynumber() ] ) )
        {
            victim.debuffedbyplayers[ weapon ][ attacker getentitynumber() ]--;
            assert( victim.debuffedbyplayers[ weapon ][ attacker getentitynumber() ] >= 0, "<dev string:x177>" );
            canremove = 1;
            
            foreach ( value in victim.debuffedbyplayers[ weapon ] )
            {
                if ( value > 0 )
                {
                    canremove = 0;
                    break;
                }
            }
            
            if ( canremove && isdefined( weapon ) && isdefined( victim.debuffedbyplayers ) )
            {
                victim.debuffedbyplayers[ weapon ] = undefined;
            }
            
            return;
        }
        
        assertmsg( "<dev string:x177>" );
    }
}

// Namespace gamescore
// Params 4
// Checksum 0xfbe89f83, Offset: 0x406c
// Size: 0x7d
function trackdebuffassistfortime( attacker, victim, weapon, duration )
{
    if ( game_utility_mp::runleanthreadmode() )
    {
        return;
    }
    
    victim endon( #"hash_524b32f68d901135" );
    victim endon( #"disconnect" );
    attacker endon( #"disconnect" );
    level endon( #"game_ended" );
    trackdebuffassist( attacker, victim, weapon );
    wait duration;
    untrackdebuffassist( attacker, victim, weapon );
}

// Namespace gamescore
// Params 2
// Checksum 0x49bbd06e, Offset: 0x40f1
// Size: 0xe2, Type: bool
function isdebuffedbyweapon( victim, weapon )
{
    if ( game_utility_mp::runleanthreadmode() )
    {
        return false;
    }
    
    assert( isdefined( victim.debuffedbyplayers ), "<dev string:x1b5>" );
    
    if ( isdefined( victim.debuffedbyplayers[ weapon ] ) )
    {
        foreach ( playerentitynumber, debuffcount in victim.debuffedbyplayers[ weapon ] )
        {
            if ( debuffcount <= 0 )
            {
                continue;
            }
            
            if ( !isdefined( level.playersbyentitynumber[ playerentitynumber ] ) )
            {
                continue;
            }
            
            return true;
        }
    }
    
    return false;
}

// Namespace gamescore
// Params 3
// Checksum 0xca8c46ac, Offset: 0x41dc
// Size: 0x91, Type: bool
function isdebuffedbyweaponandplayer( attacker, victim, weapon )
{
    if ( game_utility_mp::runleanthreadmode() )
    {
        return false;
    }
    
    assert( isdefined( victim.debuffedbyplayers ), "<dev string:x1fe>" );
    
    if ( !isdefined( victim.debuffedbyplayers[ weapon ] ) )
    {
        return false;
    }
    
    if ( !isdefined( victim.debuffedbyplayers[ weapon ][ attacker getentitynumber() ] ) )
    {
        return false;
    }
    
    if ( victim.debuffedbyplayers[ weapon ][ attacker getentitynumber() ] <= 0 )
    {
        return false;
    }
    
    return true;
}

// Namespace gamescore
// Params 2
// Checksum 0x3f94618f, Offset: 0x4276
// Size: 0x105
function getdebuffattackersbyweapon( victim, weapon )
{
    if ( game_utility_mp::runleanthreadmode() )
    {
        return;
    }
    
    assert( isdefined( victim.debuffedbyplayers ), "<dev string:x250>" );
    debuffattackers = [];
    
    if ( isplayer( victim ) )
    {
        if ( isdefined( victim.debuffedbyplayers[ weapon ] ) )
        {
            foreach ( playerentitynumber, debuffcount in victim.debuffedbyplayers[ weapon ] )
            {
                if ( debuffcount <= 0 )
                {
                    continue;
                }
                
                if ( !isdefined( level.playersbyentitynumber[ playerentitynumber ] ) )
                {
                    continue;
                }
                
                debuffattackers[ debuffattackers.size ] = level.playersbyentitynumber[ playerentitynumber ];
            }
        }
    }
    
    return debuffattackers;
}

// Namespace gamescore
// Params 3
// Checksum 0x1a58f4a, Offset: 0x4384
// Size: 0xae
function trackbuffassist( player, teammate, weapon )
{
    if ( game_utility_mp::runleanthreadmode() )
    {
        return;
    }
    
    assert( isdefined( teammate.buffedbyplayers ), "<dev string:x2a1>" );
    
    if ( player != teammate )
    {
        if ( !isdefined( teammate.buffedbyplayers[ weapon ] ) )
        {
            teammate.buffedbyplayers[ weapon ] = [];
        }
        
        if ( !isdefined( teammate.buffedbyplayers[ weapon ][ player getentitynumber() ] ) )
        {
            teammate.buffedbyplayers[ weapon ][ player getentitynumber() ] = 0;
        }
        
        teammate.buffedbyplayers[ weapon ][ player getentitynumber() ]++;
    }
}

// Namespace gamescore
// Params 3
// Checksum 0x1efdd54b, Offset: 0x443a
// Size: 0xc1
function untrackbuffassist( player, teammate, weapon )
{
    if ( game_utility_mp::runleanthreadmode() )
    {
        return;
    }
    
    assert( isdefined( teammate.buffedbyplayers ), "<dev string:x2e7>" );
    
    if ( isdefined( teammate ) )
    {
        if ( isdefined( teammate.buffedbyplayers[ weapon ][ player getentitynumber() ] ) )
        {
            teammate.buffedbyplayers[ weapon ][ player getentitynumber() ]--;
            assert( teammate.buffedbyplayers[ weapon ][ player getentitynumber() ] >= 0, "<dev string:x32f>" );
            return;
        }
        
        assert( teammate.buffedbyplayers[ weapon ][ player getentitynumber() ] >= 0, "<dev string:x32f>" );
    }
}

// Namespace gamescore
// Params 4
// Checksum 0x16cf918b, Offset: 0x4503
// Size: 0x7d
function trackbuffassistfortime( player, teammate, weapon, duration )
{
    if ( game_utility_mp::runleanthreadmode() )
    {
        return;
    }
    
    teammate endon( #"hash_524b32f68d901135" );
    teammate endon( #"disconnect" );
    player endon( #"disconnect" );
    level endon( #"game_ended" );
    trackbuffassist( player, teammate, weapon );
    wait duration;
    untrackbuffassist( player, teammate, weapon );
}

// Namespace gamescore
// Params 2
// Checksum 0xd5c23827, Offset: 0x4588
// Size: 0x389
function awardbuffdebuffassists( attacker, victim )
{
    if ( game_utility_mp::runleanthreadmode() )
    {
        return;
    }
    
    pendingassists = [];
    assert( isdefined( victim.debuffedbyplayers ), "<dev string:x369>" );
    
    foreach ( weaponlist in victim.debuffedbyplayers )
    {
        foreach ( playerentitynumber, debuffcount in weaponlist )
        {
            if ( debuffcount <= 0 )
            {
                continue;
            }
            
            player = level.playersbyentitynumber[ playerentitynumber ];
            
            if ( isdefined( player ) && player.team != "spectator" && player.team != "codcaster" && player player_utility::isenemy( victim ) )
            {
                index = player.guid;
                
                if ( !isdefined( pendingassists[ index ] ) )
                {
                    pendingassists[ index ] = player;
                }
            }
        }
    }
    
    assert( isdefined( attacker.buffedbyplayers ), "<dev string:x3b5>" );
    
    foreach ( weaponlist in attacker.buffedbyplayers )
    {
        foreach ( playerentitynumber, buffcount in weaponlist )
        {
            if ( buffcount <= 0 )
            {
                continue;
            }
            
            player = level.playersbyentitynumber[ playerentitynumber ];
            
            if ( isdefined( player ) && player.team != "spectator" && player.team != "codcaster" && player player_utility::isenemy( victim ) )
            {
                index = player.guid;
                
                if ( !isdefined( pendingassists[ index ] ) )
                {
                    pendingassists[ index ] = player;
                }
            }
        }
    }
    
    foreach ( index, player in pendingassists )
    {
        if ( !( isdefined( victim.attackerdata ) && isdefined( victim.attackerdata[ player.guid ] ) ) )
        {
            damage::addattacker( victim, player, undefined, nullweapon(), 0, undefined, undefined, "none", undefined, "MOD_UNKNOWN" );
        }
    }
}

// Namespace gamescore
// Params 2
// Checksum 0x25c3cbf0, Offset: 0x4919
// Size: 0x1fb
function function_6260e53553c84dbf( victim, var_380e1341c05f576b )
{
    attacker = self;
    
    if ( isdefined( attacker.team ) )
    {
        teamplayers = "alivePlayers";
        
        if ( getdvarint( @"hash_c74a54cb044e2e9a", 1 ) )
        {
            teamplayers = "players";
        }
        
        attackersquad = teams::getteamdata( attacker.team, teamplayers );
        
        if ( isdefined( var_380e1341c05f576b ) )
        {
            if ( !isarray( var_380e1341c05f576b ) )
            {
                var_380e1341c05f576b = [ var_380e1341c05f576b ];
            }
            
            if ( getdvarint( @"hash_dda9d67c21b0f4b4", 0 ) )
            {
                attackersquad = arrayremove( attackersquad, var_380e1341c05f576b );
            }
            else
            {
                var_4ba378561e12db52 = [];
                
                foreach ( var_30fcb423957c4d9a in var_380e1341c05f576b )
                {
                    if ( isdefined( var_30fcb423957c4d9a.guid ) )
                    {
                        attackerdata = victim.attackerdata[ var_30fcb423957c4d9a.guid ];
                        
                        if ( attackerdata.var_2a11f150d0e7dca4 > 0 )
                        {
                            var_4ba378561e12db52[ var_4ba378561e12db52.size ] = var_30fcb423957c4d9a;
                        }
                    }
                }
                
                attackersquad = arrayremove( attackersquad, var_4ba378561e12db52 );
            }
        }
        
        foreach ( squadmate in attackersquad )
        {
            if ( squadmate rejoin_utility::function_e421863f0f4de34() && level.var_d07d9cc2df831431 )
            {
                continue;
            }
            
            squadmate function_95bd35d2bd07d736( attacker, victim );
        }
    }
}

// Namespace gamescore
// Params 3
// Checksum 0x3250d0ea, Offset: 0x4b1c
// Size: 0x7a
function function_95bd35d2bd07d736( attacker, victim, team )
{
    var_6b51ffd26be91dd7 = self;
    
    if ( var_6b51ffd26be91dd7 != attacker )
    {
        if ( isdefined( team ) && var_6b51ffd26be91dd7.team != team )
        {
            return;
        }
        
        var_6b51ffd26be91dd7 thread challenges::function_42d341f05ad740f7( victim, var_6b51ffd26be91dd7, attacker );
        
        if ( isdefined( level.var_38896f7c8ea269da ) )
        {
            var_6b51ffd26be91dd7 [[ level.var_38896f7c8ea269da ]]( "unassisted", victim );
        }
    }
}

