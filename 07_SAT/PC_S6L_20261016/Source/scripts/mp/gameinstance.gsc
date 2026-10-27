// scripts\mp\gameinstance.gsc  (hash_096c87e3da36868b.gscc) (size: 21790 Bytes / 0x551e / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x4c70d804 (1282463748)
// size ...... 21790 (0x551e)
// includes .. 12  (offset: 0x5026)
// strings ... 44  (offset: 0x5086)
// dev strs .. 30  (offset: 0x539e)
// exports ... 40  (offset: 0x3dee)
// cseg ...... 0x2f9 + 0x3af5 (0x3dee)
// imports ... 89  (offset: 0x442e)
// animtree1 . 0   (offset: 0x551e)
// animtree2 . 0   (offset: 0x551e)
#using scripts\common\callbacks;
#using scripts\mp\action_park_utility;
#using scripts\mp\common\utility\dialog;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\join_team_aggregator;
#using scripts\mp\common\utility\team_utility;
#using scripts\mp\common\utility\teams;
#using scripts\mp\flags;
#using scripts\mp\gamelogic;
#using scripts\mp\gamescore;
#using scripts\mp\spectating;

#namespace gameinstance;

// Namespace gameinstance
// Params 0
// Checksum 0x336a996b, Offset: 0x317
// Size: 0x101
function initialize()
{
    flags::levelflaginit( "gaminstanceDataSet", 0 );
    level.multimatch = getdvarint( @"hash_9a5ef3002dc6cd74", 0 ) == 1;
    
    if ( !level.multimatch )
    {
        return;
    }
    
    join_team_aggregator::registeronplayerjointeamcallback( &onplayerjoinedteam );
    callback::add( #"register_team_data", &function_44627a4291f7af8d );
    
    if ( !isdefined( game[ #"hash_1416f96bd943bf3c" ] ) )
    {
        var_e47c1e39ba32f717 = spawnstruct();
        game[ #"hash_1416f96bd943bf3c" ] = var_e47c1e39ba32f717;
    }
    
    var_e47c1e39ba32f717 = game[ #"hash_1416f96bd943bf3c" ];
    var_e47c1e39ba32f717.instancedata = [];
    var_e47c1e39ba32f717.var_d902799e0338c9b8 = [];
    var_e47c1e39ba32f717.var_dbae5446cc6c991 = [];
    var_e47c1e39ba32f717.attackerteams = [];
    var_e47c1e39ba32f717.defenderteams = [];
    var_e47c1e39ba32f717.var_48b1210015962d20 = [];
    
    if ( !isdefined( game[ "roundsPlayedWithLoadouts" ] ) )
    {
        game[ "roundsPlayedWithLoadouts" ] = 0;
        return;
    }
    
    game[ "roundsPlayedWithLoadouts" ]++;
}

// Namespace gameinstance
// Params 1
// Checksum 0x98f27ce2, Offset: 0x420
// Size: 0x34f
function function_44627a4291f7af8d( params )
{
    var_e47c1e39ba32f717 = game[ #"hash_1416f96bd943bf3c" ];
    function_20f2b05bfee06390();
    var_4cf458cfd1b92eb8 = action_park_utility::get_combo_index();
    
    foreach ( currentinstance, teams in game[ #"tournamentdata" ].instanceteams[ var_4cf458cfd1b92eb8 ] )
    {
        if ( !isdefined( var_e47c1e39ba32f717.instancedata[ currentinstance ] ) )
        {
            var_e47c1e39ba32f717.instancedata[ currentinstance ] = spawnstruct();
        }
        
        var_e47c1e39ba32f717.instancedata[ currentinstance ].id = currentinstance;
        var_e47c1e39ba32f717.instancedata[ currentinstance ].teams = [];
        var_e47c1e39ba32f717.instancedata[ currentinstance ].teamswithplayers = [];
        var_e47c1e39ba32f717.instancedata[ currentinstance ].winner = undefined;
        var_e47c1e39ba32f717.instancedata[ currentinstance ].endreason = undefined;
        var_e47c1e39ba32f717.instancedata[ currentinstance ].state = "playing";
        var_e47c1e39ba32f717.var_48b1210015962d20[ var_e47c1e39ba32f717.var_48b1210015962d20.size ] = game[ #"tournamentdata" ].var_2839de8289c4150e[ var_4cf458cfd1b92eb8 ][ currentinstance ];
        
        foreach ( team in teams )
        {
            var_e47c1e39ba32f717.instancedata[ currentinstance ].teams[ var_e47c1e39ba32f717.instancedata[ currentinstance ].teams.size ] = team;
            var_e47c1e39ba32f717.var_d902799e0338c9b8[ team ] = currentinstance;
            switchedsides = game[ "switchedsides" ] ? 1 : 0;
            relativeteam = var_e47c1e39ba32f717.instancedata[ currentinstance ].teams.size % 2 == switchedsides ? "defenders" : "attackers";
            var_e47c1e39ba32f717.var_dbae5446cc6c991[ team ] = relativeteam;
            
            if ( relativeteam == "attackers" )
            {
                var_e47c1e39ba32f717.instancedata[ currentinstance ].attackers = team;
                var_e47c1e39ba32f717.attackerteams[ var_e47c1e39ba32f717.attackerteams.size ] = team;
                continue;
            }
            
            var_e47c1e39ba32f717.instancedata[ currentinstance ].defenders = team;
            var_e47c1e39ba32f717.defenderteams[ var_e47c1e39ba32f717.defenderteams.size ] = team;
        }
    }
    
    flags::levelflagset( "gaminstanceDataSet" );
    
    /#
        level thread function_cc40ed56a71295b3();
        level thread function_46b75adffc1481c1();
    #/
}

// Namespace gameinstance
// Params 1
// Checksum 0x41b0d4e9, Offset: 0x777
// Size: 0x89
function onplayerjoinedteam( player )
{
    if ( !team_utility::isgameplayteam( player.team ) )
    {
        return;
    }
    
    player.instanceid = get_instance_id( player.team );
    
    if ( !game[ "eliminated" ][ player.team ] )
    {
        enemyteam = team_utility::getotherteam( player.team );
    }
    
    player.var_3d082e06b9339948 = enemyteam ?? "none";
}

// Namespace gameinstance
// Params 0
// Checksum 0x397c290f, Offset: 0x808
// Size: 0x31
function is_enabled()
{
    if ( !isdefined( level.multimatch ) )
    {
        level.multimatch = getdvarint( @"hash_9a5ef3002dc6cd74", 0 ) == 1;
    }
    
    return level.multimatch;
}

// Namespace gameinstance
// Params 0
// Checksum 0x2815f29e, Offset: 0x842
// Size: 0x17
function function_1d3a8144ddb36029()
{
    return game[ #"hash_1416f96bd943bf3c" ].instancedata;
}

// Namespace gameinstance
// Params 1
// Checksum 0xf2750ffc, Offset: 0x862
// Size: 0x24
function get_instance_id( team )
{
    return game[ #"hash_1416f96bd943bf3c" ].var_d902799e0338c9b8[ team ];
}

// Namespace gameinstance
// Params 1
// Checksum 0xe8896f8b, Offset: 0x88f
// Size: 0x2e
function get_instance_teams( instanceid )
{
    return game[ #"hash_1416f96bd943bf3c" ].instancedata[ instanceid ].teams;
}

// Namespace gameinstance
// Params 1
// Checksum 0xd8e5957, Offset: 0x8c6
// Size: 0x38
function get_instance_arena( instanceid )
{
    currentroundindex = action_park_utility::get_combo_index();
    return game[ #"tournamentdata" ].var_2839de8289c4150e[ currentroundindex ][ instanceid ];
}

// Namespace gameinstance
// Params 2
// Checksum 0xfd5698f0, Offset: 0x907
// Size: 0x51
function get_instance_enemies( testteam, aliveonly = 0 )
{
    enemyteam = team_utility::getotherteam( testteam );
    
    if ( aliveonly )
    {
        return teams::getteamdata( enemyteam, "alivePlayers" );
    }
    
    return teams::getteamdata( enemyteam, "players" );
}

// Namespace gameinstance
// Params 1
// Checksum 0x19e31763, Offset: 0x961
// Size: 0xcd
function get_instance_players( instanceid )
{
    instancedata = game[ #"hash_1416f96bd943bf3c" ].instancedata[ instanceid ];
    assert( isdefined( instancedata ) );
    players = [];
    
    foreach ( team in instancedata.teams )
    {
        players = arraycombine( players, teams::getteamdata( team, "players" ) );
    }
    
    return players;
}

// Namespace gameinstance
// Params 0
// Checksum 0x662b4f4e, Offset: 0xa37
// Size: 0x17
function function_e934bda31466d491()
{
    return game[ #"hash_1416f96bd943bf3c" ].attackerteams;
}

// Namespace gameinstance
// Params 0
// Checksum 0xac2820f7, Offset: 0xa57
// Size: 0x17
function function_46849ab004145bad()
{
    return game[ #"hash_1416f96bd943bf3c" ].defenderteams;
}

// Namespace gameinstance
// Params 1
// Checksum 0x9d977b92, Offset: 0xa77
// Size: 0x2e
function get_instance_attackers( instance_id )
{
    return game[ #"hash_1416f96bd943bf3c" ].instancedata[ instance_id ].attackers;
}

// Namespace gameinstance
// Params 1
// Checksum 0x9d977b92, Offset: 0xaae
// Size: 0x2e
function get_instance_defenders( instance_id )
{
    return game[ #"hash_1416f96bd943bf3c" ].instancedata[ instance_id ].defenders;
}

// Namespace gameinstance
// Params 0
// Checksum 0x52585dc5, Offset: 0xae5
// Size: 0x17
function get_active_arenas()
{
    return game[ #"hash_1416f96bd943bf3c" ].var_48b1210015962d20;
}

// Namespace gameinstance
// Params 1
// Checksum 0xa9f97614, Offset: 0xb05
// Size: 0x3a
function function_33e89da81bb07592( instanceid )
{
    game[ #"hash_1416f96bd943bf3c" ].instancedata[ instanceid ].completed = 1;
    spectating::updatespectatesettings( instanceid );
}

// Namespace gameinstance
// Params 1
// Checksum 0xd0213a18, Offset: 0xb47
// Size: 0x2f, Type: bool
function is_instance_complete( instanceid )
{
    return istrue( game[ #"hash_1416f96bd943bf3c" ].instancedata[ instanceid ].completed );
}

// Namespace gameinstance
// Params 0
// Checksum 0x556974fc, Offset: 0xb7f
// Size: 0x92, Type: bool
function function_22af978e6bfea368()
{
    foreach ( instance in game[ #"hash_1416f96bd943bf3c" ].instancedata )
    {
        if ( !isdefined( instance.winner ) )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace gameinstance
// Params 0
// Checksum 0x7e9a74c4, Offset: 0xc1a
// Size: 0x15, Type: bool
function function_472f835355b3cd1c()
{
    return game[ "roundsPlayedWithLoadouts" ] % level.loadoutchangeround == 0;
}

// Namespace gameinstance
// Params 0
// Checksum 0xc58a5210, Offset: 0xc38
// Size: 0x121, Type: bool
function function_2c23a0e05668ac9d()
{
    foreach ( instance in game[ #"hash_1416f96bd943bf3c" ].instancedata )
    {
        opponenteliminated = 0;
        
        foreach ( team in instance.teams )
        {
            if ( game[ "eliminated" ][ team ] )
            {
                opponenteliminated = 1;
                break;
            }
        }
        
        if ( !opponenteliminated )
        {
            return false;
        }
    }
    
    game[ "roundsPlayedWithLoadouts" ] = -1;
    return true;
}

// Namespace gameinstance
// Params 1
// Checksum 0x6940e564, Offset: 0xd62
// Size: 0x2e
function get_instance_game_state( instanceid )
{
    return game[ #"hash_1416f96bd943bf3c" ].instancedata[ instanceid ].state;
}

// Namespace gameinstance
// Params 2
// Checksum 0x686ec2ae, Offset: 0xd99
// Size: 0x39
function set_instance_game_state( state, instanceid )
{
    game[ #"hash_1416f96bd943bf3c" ].instancedata[ instanceid ].state = state;
}

// Namespace gameinstance
// Params 1
// Checksum 0xac9bdc96, Offset: 0xdda
// Size: 0x2e
function function_65b79de0e13026ab( instanceid )
{
    return game[ #"hash_1416f96bd943bf3c" ].instancedata[ instanceid ].teamswithplayers;
}

// Namespace gameinstance
// Params 2
// Checksum 0x8c224c9d, Offset: 0xe11
// Size: 0x28b
function check_score_limit( team, allowtie )
{
    instance = game[ #"hash_1416f96bd943bf3c" ].var_d902799e0338c9b8[ team ];
    assert( isdefined( instance ) );
    instancedata = game[ #"hash_1416f96bd943bf3c" ].instancedata[ instance ];
    assert( isdefined( instancedata ) );
    function_1934f293a39cf093( team );
    scorelimittext = "score_limit_reached";
    
    if ( isdefined( level.var_28acb43c77eacf08 ) )
    {
        scorelimittext = level.var_28acb43c77eacf08;
    }
    
    if ( allowtie )
    {
        level notify( "roundEnd_CheckScoreLimit_" + instance );
        level endon( "roundEnd_CheckScoreLimit_" + instance );
        waitframe();
    }
    
    if ( level.roundscorelimit > 0 )
    {
        var_38a598c9ed7fae70 = [];
        
        foreach ( entry in instancedata.teams )
        {
            if ( game[ "teamScores" ][ entry ] >= level.roundscorelimit )
            {
                var_38a598c9ed7fae70[ var_38a598c9ed7fae70.size ] = entry;
            }
        }
        
        if ( var_38a598c9ed7fae70.size > 0 )
        {
            if ( var_38a598c9ed7fae70.size > 1 )
            {
                highestscore = 0;
                highestteam = undefined;
                highesttied = 0;
                
                foreach ( entry in var_38a598c9ed7fae70 )
                {
                    teamscore = game[ "teamScores" ][ entry ];
                    
                    if ( !isdefined( highestteam ) )
                    {
                        highestscore = teamscore;
                        highestteam = entry;
                        highesttied = 0;
                        continue;
                    }
                    
                    if ( teamscore > highestscore )
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
                    function_3979f6a43aa329b( instance, "tie", game[ "end_reason" ][ scorelimittext ] );
                }
                else
                {
                    function_3979f6a43aa329b( instance, highestteam, game[ "end_reason" ][ scorelimittext ] );
                }
                
                return;
            }
            
            function_3979f6a43aa329b( instance, var_38a598c9ed7fae70[ 0 ], game[ "end_reason" ][ scorelimittext ] );
        }
    }
}

// Namespace gameinstance
// Params 1
// Checksum 0xb60c8f4c, Offset: 0x10a4
// Size: 0x207
function function_1934f293a39cf093( team )
{
    assert( isdefined( team ) );
    
    if ( level.roundscorelimit <= 0 || level.objectivebased )
    {
        return;
    }
    
    if ( level.scorelimitoverride )
    {
        return;
    }
    
    if ( !level.teambased )
    {
        return;
    }
    
    shouldnotify = 0;
    
    if ( isdefined( level.checkcustomclosetoscorelimit ) )
    {
        shouldnotify = [[ level.checkcustomclosetoscorelimit ]]( team );
    }
    else if ( game_utility::gettimepassed() > 45000 )
    {
        shouldnotify = gamelogic_mp::estimatedtimetillscorelimit( team ) < 0.5;
    }
    
    instance = game[ #"hash_1416f96bd943bf3c" ].var_d902799e0338c9b8[ team ];
    instancedata = game[ #"hash_1416f96bd943bf3c" ].instancedata[ instance ];
    
    if ( !isdefined( instancedata.playedmatchendingsoon ) )
    {
        instancedata.playedmatchendingsoon = 0;
    }
    
    if ( !isdefined( instancedata.didhalfscorevoboost ) )
    {
        instancedata.didhalfscorevoboost = 0;
    }
    
    if ( !instancedata.playedmatchendingsoon && shouldnotify )
    {
        instancedata.playedmatchendingsoon = 1;
        level notify( #"match_ending_soon", "score" );
    }
    
    if ( !level.playedmatchendingsoon && !canplayhalfwayvo( team ) )
    {
        if ( getteamscore( team ) >= int( level.scorelimit * level.currentround - level.scorelimit / 2 ) )
        {
            dialog::leaderdialog( #"halfway_friendly_score", team, "status" );
            level callback::callback( #"music_event", { #team:team, #event_type:#"midpoint" } );
            enemyteam = team_utility::getotherteam( team );
            dialog::leaderdialog( #"halfway_enemy_score", enemyteam, "status" );
            level.didhalfscorevoboost = 1;
        }
    }
}

// Namespace gameinstance
// Params 1
// Checksum 0x112391a, Offset: 0x12b3
// Size: 0x90
function canplayhalfwayvo( team )
{
    instance = game[ #"hash_1416f96bd943bf3c" ].var_d902799e0338c9b8[ team ];
    instancedata = game[ #"hash_1416f96bd943bf3c" ].instancedata[ instance ];
    
    if ( !isdefined( instancedata.didhalfscorevoboost ) )
    {
        instancedata.didhalfscorevoboost = 0;
    }
    
    if ( instancedata.didhalfscorevoboost )
    {
        return 0;
    }
    
    return level.gametypebundle.var_638603c9f126398e;
}

// Namespace gameinstance
// Params 3
// Checksum 0x5dc1f1c3, Offset: 0x134c
// Size: 0x5a
function function_3979f6a43aa329b( instance, winner, endreason )
{
    if ( isdefined( instance.winner ) )
    {
        return;
    }
    
    instance.winner = winner;
    instance.endreason = endreason;
    level thread gamelogic_mp::endgame( winner, endreason, undefined, undefined, undefined, instance );
}

// Namespace gameinstance
// Params 1
// Checksum 0x8bf5e862, Offset: 0x13ae
// Size: 0xb55
function updategameevents( canforfeit )
{
    canforfeit = 1;
    
    foreach ( instance in game[ #"hash_1416f96bd943bf3c" ].instancedata )
    {
        if ( instance.completed )
        {
            continue;
        }
        
        participantplayers = get_instance_players( instance.id );
        participantteams = get_instance_teams( instance.id );
        instance.teamswithplayers = [];
        
        foreach ( team in participantteams )
        {
            teamcount = teams::getteamdata( team, "teamCount" );
            
            if ( teamcount && !game[ "eliminated" ][ team ] )
            {
                instance.teamswithplayers[ instance.teamswithplayers.size ] = team;
            }
        }
        
        if ( flags::gameflag( "prematch_done" ) )
        {
            if ( instance.state == "playing" && instance.teamswithplayers.size == 1 )
            {
                function_3979f6a43aa329b( instance, "bye_round", game[ "end_reason" ][ "advance_to_next_round" ] );
                continue;
            }
        }
        
        if ( instance.teamswithplayers.size == 1 && ( level.br_debugsolotest || !isbrgamemode() && !isdmzgamemode() ) && !level.var_edec83ec6da8ff87 )
        {
            continue;
        }
        
        if ( !game_utility_mp::getgametypenumlives() && !game_utility_mp::ismutationgamemode() && !level.disablespawning )
        {
            continue;
        }
        
        if ( !game_utility_mp::gamehasstarted() )
        {
            continue;
        }
        
        if ( level.ingraceperiod && !isdefined( level.overrideingraceperiod ) )
        {
            continue;
        }
        
        if ( level.teambased )
        {
            livescount = [];
            
            foreach ( entry in participantteams )
            {
                livescount[ entry ] = 0;
            }
            
            var_ee1c174ea76190d2 = [];
            
            foreach ( player in participantplayers )
            {
                if ( isbot( player ) && !player.hasspawned )
                {
                    var_ee1c174ea76190d2[ player.team ] = 1;
                }
                
                if ( !player.hasspawned || player.team == "spectator" || player.team == "codcaster" || player.team == "free" )
                {
                    continue;
                }
                
                livescount[ player.team ] += player.pers[ "lives" ];
            }
            
            if ( level.disablespawning )
            {
                foreach ( entry in participantteams )
                {
                    livescount[ entry ] = 0;
                }
            }
            
            hasalivecount = 0;
            teamsalive = participantteams.size;
            
            foreach ( entry in participantteams )
            {
                if ( teams::getteamdata( entry, "aliveCount" ) )
                {
                    hasalivecount = 1;
                    break;
                }
                
                teamsalive--;
            }
            
            haslivescount = 0;
            
            foreach ( count in livescount )
            {
                if ( count )
                {
                    haslivescount = 1;
                    break;
                }
            }
            
            if ( !hasalivecount && !haslivescount )
            {
                if ( level.postgameexfil && level.gameended )
                {
                    level notify( #"exfil_continue_game_end" );
                }
                
                if ( level.nukeinfo.incoming )
                {
                    continue;
                }
                
                [[ level.ondeadevent ]]( "all", instance );
                continue;
            }
            
            foreach ( entry in participantteams )
            {
                if ( !teams::getteamdata( entry, "aliveCount" ) && !livescount[ entry ] )
                {
                    if ( level.var_edec83ec6da8ff87 )
                    {
                        if ( teamsalive > 0 )
                        {
                            continue;
                        }
                    }
                    
                    if ( var_ee1c174ea76190d2[ entry ] )
                    {
                        continue;
                    }
                    
                    if ( level.postgameexfil && level.gameended )
                    {
                        level notify( #"exfil_continue_game_end" );
                    }
                    
                    if ( !level.skipondeadevent )
                    {
                        if ( level.nukeinfo.incoming )
                        {
                            continue;
                        }
                        
                        [[ level.ondeadevent ]]( entry, instance );
                    }
                }
            }
            
            foreach ( entry in participantteams )
            {
                var_ebfcf7b2dc2973a0 = teams::getteamdata( entry, "aliveCount" );
                
                if ( var_ebfcf7b2dc2973a0 == 1 || var_ebfcf7b2dc2973a0 == 2 || game_utility_mp::getbasegametype() == "control" )
                {
                    teammatelives = 0;
                    players = teams::getteamdata( entry, "players" );
                    aliveplayers = [];
                    
                    foreach ( player in players )
                    {
                        if ( !isalive( player ) )
                        {
                            teammatelives += player.pers[ "lives" ];
                            continue;
                        }
                        
                        aliveplayers[ aliveplayers.size ] = player;
                    }
                    
                    if ( var_ebfcf7b2dc2973a0 != 1 )
                    {
                        teams::setteamdata( entry, "oneLeft", 0 );
                    }
                    
                    var_c14b7e0b2afb198a = 0;
                    var_79fefc8c98a60f55 = game_utility_mp::getbasegametype();
                    
                    if ( var_79fefc8c98a60f55 == "control" )
                    {
                        livescount = teams::getteamdata( entry, "livesCount" );
                        alivecount = teams::getteamdata( entry, "aliveCount" );
                        total_lives = livescount + alivecount;
                        
                        if ( total_lives == 1 && level.numteamlives != 0 )
                        {
                            var_c14b7e0b2afb198a = 1;
                        }
                    }
                    else if ( var_79fefc8c98a60f55 == "prop" )
                    {
                        var_c14b7e0b2afb198a = teammatelives == 0 && entry != game[ "attackers" ];
                    }
                    else if ( teammatelives == 0 )
                    {
                        var_c14b7e0b2afb198a = 1;
                    }
                    
                    if ( var_c14b7e0b2afb198a )
                    {
                        if ( var_ebfcf7b2dc2973a0 == 1 && !teams::getteamdata( entry, "oneLeft" ) && gettime() > teams::getteamdata( entry, "oneLeftTime" ) + 5000 )
                        {
                            teams::setteamdata( entry, "oneLeftTime", gettime() );
                            teams::setteamdata( entry, "oneLeft", 1 );
                            
                            if ( players.size > 1 )
                            {
                                if ( !level.multiteambased )
                                {
                                    lastplayer = game_utility_mp::getlastlivingplayer( entry );
                                    lastplayer dialog::leaderdialogonplayer( #"friendly_last_alive", "status" );
                                    otherteam = team_utility::getotherteam( entry );
                                    dialog::leaderdialog( #"enemy_last_alive", otherteam, "status" );
                                }
                                
                                [[ level.ononeleftevent ]]( entry );
                            }
                        }
                    }
                    
                    continue;
                }
                
                teams::setteamdata( entry, "oneLeft", 0 );
            }
            
            continue;
        }
        
        livescount = 0;
        
        foreach ( player in participantplayers )
        {
            if ( player.team == "spectator" || player.team == "codcaster" )
            {
                continue;
            }
            
            livescount += player.pers[ "lives" ];
        }
        
        alivecounttotal = 0;
        
        foreach ( entry in participantteams )
        {
            alivecounttotal += teams::getteamdata( entry, "aliveCount" );
        }
        
        if ( !alivecounttotal && !livescount )
        {
            if ( level.nukeinfo.incoming )
            {
                return;
            }
            
            return [[ level.ondeadevent ]]( "all" );
        }
        
        liveplayers = game_utility_mp::getpotentiallivingplayers();
        
        if ( liveplayers.size == 1 )
        {
            return [[ level.ononeleftevent ]]( "all" );
        }
    }
}

// Namespace gameinstance
// Params 0
// Checksum 0x97fd0580, Offset: 0x1f0b
// Size: 0xff
function timelimitthread()
{
    level endon( #"game_ended" );
    prevtimepassed = game_utility::gettimepassed();
    
    while ( !level.gameended )
    {
        waittillframeend();
        
        foreach ( instance in game[ #"hash_1416f96bd943bf3c" ].instancedata )
        {
            if ( instance.state == "playing" )
            {
                thread checktimelimit( prevtimepassed, instance );
            }
        }
        
        prevtimepassed = game_utility::gettimepassed();
        
        if ( isdefined( level.starttime ) )
        {
            if ( gamelogic_mp::gettimeremaining() < 3000 || level.forceotlogictorun )
            {
                waitframe();
                continue;
            }
        }
        
        wait 1;
    }
}

// Namespace gameinstance
// Params 2
// Checksum 0xe9f5944c, Offset: 0x2012
// Size: 0x46b
function checktimelimit( prevtimepassed, instance )
{
    if ( level.timelimitoverride )
    {
        return;
    }
    
    if ( instance.state != "playing" )
    {
        setgameendtime( 0 );
        return;
    }
    
    gamelogic_mp::runjiprules();
    
    if ( game_utility_mp::gettimelimit() <= 0 )
    {
        if ( isdefined( level.starttime ) )
        {
            setgameendtime( level.starttime );
            return;
        }
        
        setgameendtime( 0 );
        return;
    }
    
    if ( !flags::gameflag( "prematch_done" ) )
    {
        setgameendtime( 0 );
        return;
    }
    
    if ( !isdefined( level.starttime ) )
    {
        return;
    }
    
    if ( level.timerstopped )
    {
        return;
    }
    
    timeleft = gamelogic_mp::gettimeremaining();
    participantplayers = get_instance_players( instance.id );
    setgameendtime( gettime() + int( timeleft ) );
    var_9546989e041b3a3f = istrue( level.ontimelimitgraceperiod );
    
    if ( timeleft > 0 && !isdefined( level.forceotlogictorun ) )
    {
        if ( var_9546989e041b3a3f )
        {
            if ( flags::levelflag( "over_time_entered" ) )
            {
                flags::levelflagclear( "over_time_entered" );
            }
            
            if ( level.setallclientomnvarot )
            {
                setomnvarforallclients( "ui_overtime_timer_show", 0 );
            }
            else
            {
                setomnvar( "ui_overtime_timer_show", 0 );
            }
        }
        
        if ( !isdefined( instance.var_f50bca4128052a2e ) && isdefined( level.initialtimelimit ) && level.initialtimelimit > 180 && int( timeleft / 1000 ) < int( level.initialtimelimit / 2 ) )
        {
            instance.var_f50bca4128052a2e = 1;
            function_bb2339fb210b8667( instance );
        }
        
        return;
    }
    
    if ( var_9546989e041b3a3f )
    {
        flags::gameflagset( "overtime_started" );
        
        if ( !isdefined( level.overtimetotal ) )
        {
            level.overtimetotal = 0;
        }
        else
        {
            level.overtimetotal += level.frameduration;
        }
        
        if ( isdefined( level.ontimelimitot ) )
        {
            [[ level.ontimelimitot ]]();
            level.ontimelimitot = undefined;
        }
        
        if ( level.canprocessot )
        {
            level.currenttimelimitdelay += level.framedurationseconds;
        }
        else
        {
            level.currenttimelimitdelay = 0;
        }
        
        progress = clamp( 1 - level.currenttimelimitdelay / level.ontimelimitgraceperiod, 0, 1 );
        
        if ( level.currenttimelimitdelay < level.ontimelimitgraceperiod )
        {
            if ( level.setallclientomnvarot )
            {
                if ( !isdefined( level.forcehideottimer ) )
                {
                    foreach ( player in participantplayers )
                    {
                        setomnvarforallclients( "ui_overtime_timer_show", 1 );
                        setomnvarforallclients( "ui_overtime_timer", progress );
                    }
                }
            }
            else
            {
                setomnvar( "ui_overtime_timer_show", 1 );
                setomnvar( "ui_overtime_timer", progress );
                setgameendtime( gettime() + int( ( level.ontimelimitgraceperiod - level.currenttimelimitdelay ) * 1000 ) );
            }
            
            if ( game_utility::getgametype() == "champion" )
            {
                setomnvar( "ui_overtime_time", gettime() + ( level.ontimelimitgraceperiod - level.currenttimelimitdelay ) * 1000 );
            }
            else
            {
                setomnvar( "ui_overtime_time", gettime() + level.ontimelimitgraceperiod * 1000 );
            }
        }
        else
        {
            if ( level.setallclientomnvarot )
            {
                setomnvarforallclients( "ui_overtime_timer_show", 0 );
                setomnvarforallclients( "ui_overtime_timer", progress );
            }
            else
            {
                setomnvar( "ui_overtime_timer_show", 0 );
                setomnvar( "ui_overtime_timer", progress );
            }
            
            if ( game_utility::getgametype() == "champion" )
            {
                setomnvar( "ui_overtime_time", gettime() );
            }
            else
            {
                setomnvar( "ui_overtime_time", gettime() + level.ontimelimitgraceperiod * 1000 );
            }
        }
        
        if ( level.currenttimelimitdelay < level.ontimelimitgraceperiod )
        {
            return;
        }
    }
    
    [[ level.ontimelimit ]]( instance );
}

// Namespace gameinstance
// Params 1
// Checksum 0x4ecd2fc8, Offset: 0x2485
// Size: 0xc2
function function_bb2339fb210b8667( instance )
{
    if ( level.teambased )
    {
        if ( game_utility_mp::inovertime() || game_utility_mp::intimetobeat() )
        {
            if ( game_utility_mp::isscoretobeatrulegametype() )
            {
                score = game[ "overtimeProgress" ] + game[ "overtimeProgressFrac" ];
                winner = game_utility_mp::setscoretobeat( game[ "attackers" ], score * 60 );
            }
            else if ( game_utility_mp::istimetobeatvalid() )
            {
                winner = game[ "timeToBeatTeam" ];
            }
        }
        else
        {
            winner = gamescore::gethighestscoringteam( instance );
        }
        
        if ( winner != "tie" )
        {
            level thread function_3d337afee42972e3( winner );
        }
        
        return;
    }
    
    winningplayer = gamescore::gethighestscoringplayer();
    level thread function_3d337afee42972e3( winningplayer );
}

// Namespace gameinstance
// Params 1
// Checksum 0x25d194c0, Offset: 0x254f
// Size: 0x102
function function_3d337afee42972e3( winner )
{
    if ( !isdefined( winner ) )
    {
        return;
    }
    
    if ( !isplayer( winner ) )
    {
        dialog::leaderdialog( #"halfway_friendly_time", winner, "status" );
        dialog::leaderdialog( #"halfway_enemy_time", team_utility::getotherteam( winner ), "status" );
        return;
    }
    
    if ( isdefined( winner ) )
    {
        winner thread dialog::leaderdialogonplayer( #"halfway_friendly_time" );
    }
    
    losingplayers = gamescore::getlosingplayers();
    
    foreach ( player in losingplayers )
    {
        if ( player == winner )
        {
            continue;
        }
        
        player thread dialog::leaderdialogonplayer( #"halfway_enemy_time" );
    }
}

// Namespace gameinstance
// Params 0
// Checksum 0xd8eefe94, Offset: 0x2659
// Size: 0x8ef
function function_20f2b05bfee06390()
{
    if ( !isdefined( game[ "roundsLost" ] ) )
    {
        foreach ( entry in level.teamnamelist )
        {
            game[ "roundsLost" ][ entry ] = 0;
            game[ "roundsTied" ][ entry ] = 0;
            game[ "eliminated" ][ entry ] = 0;
            game[ "byeRounds" ][ entry ] = 0;
        }
    }
    
    if ( !isdefined( game[ #"tournamentdata" ] ) )
    {
        data = spawnstruct();
        data.instanceteams = [];
        data.var_2839de8289c4150e = [];
        data.var_95b6628f01c7720e = [];
        data.var_f3a0b084415d4a5e = [];
        data.var_8105752b09eee18f = getdvarint( @"hash_ce672cf6f6db033e", 1 );
        data.var_a83bd5cc60a532ba = getdvarint( @"hash_b49f7939bf6fc0da", 0 );
        
        foreach ( entry in level.teamnamelist )
        {
            data.var_95b6628f01c7720e[ entry ] = [];
            data.var_f3a0b084415d4a5e[ entry ] = [];
            
            foreach ( opponent in level.teamnamelist )
            {
                if ( entry == opponent )
                {
                    continue;
                }
                
                data.var_f3a0b084415d4a5e[ entry ][ opponent ] = 0;
            }
        }
        
        data.roundlosslimit = getdvarint( @"hash_7fa800d933b647c2", 3 );
        game[ #"tournamentdata" ] = data;
    }
    else
    {
        data = game[ #"tournamentdata" ];
    }
    
    roundindex = action_park_utility::get_combo_index();
    
    if ( isdefined( data.instanceteams[ roundindex ] ) )
    {
        return;
    }
    else
    {
        data.instanceteams[ roundindex ] = [];
        data.var_2839de8289c4150e[ roundindex ] = [];
    }
    
    participatingteams = [];
    
    foreach ( team in level.teamnamelist )
    {
        if ( !game[ "eliminated" ][ team ] )
        {
            participatingteams[ participatingteams.size ] = team;
            
            if ( game[ #"tournamentdata" ].var_8105752b09eee18f )
            {
                game[ "roundsLost" ][ team ] = 0;
            }
        }
    }
    
    if ( game[ #"tournamentdata" ].var_a83bd5cc60a532ba && participatingteams.size == 2 )
    {
        foreach ( team in participatingteams )
        {
            game[ "roundsLost" ][ team ] = 0;
        }
    }
    
    var_fb7d0b48a255033e = 1;
    
    if ( var_fb7d0b48a255033e )
    {
        instancecount = int( ceil( participatingteams.size / 2 ) );
        
        if ( !isdefined( data.instanceteams[ roundindex ] ) )
        {
            data.instanceteams[ roundindex ] = [];
        }
        
        var_3660e8960271bfbc = function_9cf399964293aeca( participatingteams );
        
        for ( instanceid = 0; instanceid < instancecount ; instanceid++ )
        {
            if ( !isdefined( data.instanceteams[ roundindex ][ instanceid ] ) )
            {
                data.instanceteams[ roundindex ][ instanceid ] = [];
            }
            
            currentteam = var_3660e8960271bfbc[ 0 ];
            var_d82b4b18cc2f950d = var_3660e8960271bfbc;
            var_d82b4b18cc2f950d = arrayremove( var_d82b4b18cc2f950d, currentteam );
            var_b5ae1895e5296e07 = function_56667adf9bff22a2( data.var_f3a0b084415d4a5e[ currentteam ], var_d82b4b18cc2f950d );
            data.instanceteams[ roundindex ][ instanceid ][ data.instanceteams[ roundindex ][ instanceid ].size ] = currentteam;
            opponentteam = undefined;
            
            if ( isdefined( var_b5ae1895e5296e07[ 0 ] ) )
            {
                opponentteam = var_b5ae1895e5296e07[ 0 ];
            }
            
            if ( isdefined( opponentteam ) )
            {
                data.var_f3a0b084415d4a5e[ currentteam ][ opponentteam ]++;
                data.var_f3a0b084415d4a5e[ opponentteam ][ currentteam ]++;
                data.instanceteams[ roundindex ][ instanceid ][ data.instanceteams[ roundindex ][ instanceid ].size ] = opponentteam;
                var_3660e8960271bfbc = arrayremove( var_3660e8960271bfbc, opponentteam );
            }
            else
            {
                game[ "byeRounds" ][ currentteam ]++;
            }
            
            var_3660e8960271bfbc = arrayremove( var_3660e8960271bfbc, currentteam );
        }
    }
    
    var_e2512648aacbcf6b = [];
    
    foreach ( instance, teams in data.instanceteams[ roundindex ] )
    {
        if ( !isdefined( var_e2512648aacbcf6b[ instance ] ) )
        {
            var_e2512648aacbcf6b[ instance ] = [];
        }
        
        foreach ( team in teams )
        {
            var_e2512648aacbcf6b[ instance ] = arraycombineunique( var_e2512648aacbcf6b[ instance ], data.var_95b6628f01c7720e[ team ] );
        }
        
        if ( var_e2512648aacbcf6b[ instance ].size == game[ #"action_park_utility" ].labels.size )
        {
            var_e2512648aacbcf6b[ instance ] = [];
        }
    }
    
    var_61d9f90f0d601210 = [];
    highest = -1;
    best = -1;
    
    while ( var_61d9f90f0d601210.size < var_e2512648aacbcf6b.size )
    {
        foreach ( instance, arenas in var_e2512648aacbcf6b )
        {
            if ( arraycontains( var_61d9f90f0d601210, instance ) )
            {
                continue;
            }
            
            count = arenas.size;
            
            if ( count > highest )
            {
                highest = count;
                best = instance;
            }
        }
        
        var_61d9f90f0d601210[ var_61d9f90f0d601210.size ] = best;
        highest = -1;
    }
    
    var_4a84591a2c4b537b = [];
    
    for ( i = 0; i < var_61d9f90f0d601210.size ; i++ )
    {
        instance = var_61d9f90f0d601210[ i ];
        arenas = var_e2512648aacbcf6b[ instance ];
        
        if ( isdefined( data.var_2839de8289c4150e[ roundindex ][ instance ] ) )
        {
            continue;
        }
        
        foreach ( arenaindex, arenaname in game[ #"action_park_utility" ].labels )
        {
            if ( !var_4a84591a2c4b537b[ arenaindex ] && !arraycontains( arenas, arenaindex ) )
            {
                data.var_2839de8289c4150e[ roundindex ][ instance ] = arenaindex;
                
                foreach ( team in data.instanceteams[ roundindex ][ instance ] )
                {
                    data.var_95b6628f01c7720e[ team ][ data.var_95b6628f01c7720e[ team ].size ] = arenaindex;
                }
                
                var_4a84591a2c4b537b[ arenaindex ] = 1;
                break;
            }
        }
    }
}

// Namespace gameinstance
// Params 1
// Checksum 0x3e952f48, Offset: 0x2f50
// Size: 0xf3
function function_9cf399964293aeca( var_f716796da8e83c56 )
{
    for ( outarray = []; outarray.size < var_f716796da8e83c56.size ; outarray = arraycombine( outarray, bestteams ) )
    {
        bestteams = [];
        bestcount = undefined;
        
        foreach ( team in var_f716796da8e83c56 )
        {
            if ( arraycontains( outarray, team ) )
            {
                continue;
            }
            
            count = game[ "byeRounds" ][ team ];
            
            if ( !isdefined( bestcount ) || count >= bestcount )
            {
                if ( count > bestcount )
                {
                    bestteams = [];
                }
                
                bestcount = count;
                bestteams[ bestteams.size ] = team;
            }
        }
    }
    
    return outarray;
}

// Namespace gameinstance
// Params 2
// Checksum 0xba8b3bdb, Offset: 0x304c
// Size: 0x15f
function function_56667adf9bff22a2( var_f716796da8e83c56, var_d82b4b18cc2f950d )
{
    outarray = [];
    
    foreach ( team, count in var_f716796da8e83c56 )
    {
        if ( !arraycontains( var_d82b4b18cc2f950d, team ) )
        {
            var_f716796da8e83c56[ team ] = undefined;
            
            if ( isint( team ) )
            {
                function_cdc669dbc8ea2101( var_f716796da8e83c56 );
            }
        }
    }
    
    while ( outarray.size < var_f716796da8e83c56.size )
    {
        opponents = [];
        bestcount = undefined;
        
        foreach ( team, count in var_f716796da8e83c56 )
        {
            if ( arraycontains( outarray, team ) )
            {
                continue;
            }
            
            if ( !isdefined( bestcount ) || count <= bestcount )
            {
                if ( count < bestcount )
                {
                    opponents = [];
                }
                
                bestcount = count;
                opponents[ opponents.size ] = team;
            }
        }
        
        outarray = arraycombine( outarray, opponents );
    }
    
    return outarray;
}

// Namespace gameinstance
// Params 1
// Checksum 0x6f5fd25e, Offset: 0x31b4
// Size: 0x4f
function function_68947b684b21c63a( team )
{
    if ( !isdefined( team ) )
    {
        return;
    }
    
    game[ "roundsLost" ][ team ]++;
    
    if ( game[ "roundsLost" ][ team ] == game[ #"tournamentdata" ].roundlosslimit )
    {
        game[ "eliminated" ][ team ] = 1;
    }
}

// Namespace gameinstance
// Params 0
// Checksum 0x8b7a10ca, Offset: 0x320b
// Size: 0x9a, Type: bool
function function_ff882ffea0747336()
{
    teamsremaining = 0;
    
    foreach ( team in level.teamnamelist )
    {
        if ( !game[ "eliminated" ][ team ] )
        {
            teamsremaining++;
            
            if ( teamsremaining > 1 )
            {
                return false;
            }
        }
    }
    
    return true;
}

/#

    // Namespace gameinstance
    // Params 0
    // Checksum 0xd16213c5, Offset: 0x32ae
    // Size: 0x333, Type: dev
    function function_cc40ed56a71295b3()
    {
        wait 5;
        
        while ( true )
        {
            foreach ( instance in game[ #"hash_1416f96bd943bf3c" ].instancedata )
            {
                spawnset = level.spawnglobals.spawnsets[ hashcat( #"hash_1e696c158c9a3795", instance.id ) ];
                
                foreach ( spawn in spawnset.spawnpoints )
                {
                    print3d( spawn.origin, "<dev string:x24>" + instance.id + "<dev string:x26>" + instance.attackers, ( 1, 0, 0 ), 1, 1, 1000, 1 );
                }
                
                spawnset = level.spawnglobals.spawnsets[ hashcat( #"hash_7d6286d39a08d82d", instance.id ) ];
                
                foreach ( spawn in spawnset.spawnpoints )
                {
                    print3d( spawn.origin, "<dev string:x24>" + instance.id + "<dev string:x32>" + instance.defenders, ( 0, 0, 1 ), 1, 1, 1000, 1 );
                }
                
                spawnset = level.spawnglobals.spawnsets[ hashcat( #"hash_644d887195259852", instance.id ) ];
                
                foreach ( spawn in spawnset.spawnpoints )
                {
                    print3d( spawn.origin, "<dev string:x24>" + instance.id + "<dev string:x3e>", ( 0, 1, 0 ), 1, 1, 1000, 1 );
                }
            }
            
            wait 1;
        }
    }

    // Namespace gameinstance
    // Params 0
    // Checksum 0x51c6b78d, Offset: 0x35e9
    // Size: 0x805, Type: dev
    function function_46b75adffc1481c1()
    {
        stepy = 25;
        
        while ( true )
        {
            if ( getdvarint( @"hash_4839a0559718f849", 0 ) == 0 )
            {
                waitframe();
                continue;
            }
            
            scale = 1.5;
            startx = 400;
            starty = 100;
            linecount = 1;
            teamcount = 0;
            printtoscreen2d( startx, starty + stepy * linecount, "<dev string:x48>", ( 1, 1, 1 ), scale );
            linecount++;
            
            foreach ( team in level.teamnamelist )
            {
                var_d99f29607f6de171 = game[ "<dev string:x5e>" ][ team ] ?? 0;
                var_1eb0dc4071530bbd = game[ "<dev string:x68>" ][ team ] ?? 0;
                var_b131e57fdc5c0d09 = game[ "<dev string:x73>" ] - var_d99f29607f6de171 - var_1eb0dc4071530bbd;
                eliminated = game[ "<dev string:x80>" ][ team ] ?? 0;
                color = eliminated ? ( 1, 0, 0 ) : ( 1, 1, 1 );
                printtoscreen2d( startx, starty + stepy * linecount, team + "<dev string:x8b>" + var_d99f29607f6de171 + "<dev string:x8d>" + var_1eb0dc4071530bbd + "<dev string:x90>" + var_b131e57fdc5c0d09 + "<dev string:x93>", color, scale );
                linecount++;
            }
            
            linecount++;
            printtoscreen2d( startx, starty + stepy * linecount, "<dev string:x95>", ( 1, 1, 1 ), scale );
            linecount++;
            
            foreach ( opponentindex, data in game[ #"tournamentdata" ].instanceteams )
            {
                printtoscreen2d( startx, starty + stepy * linecount, "<dev string:xa2>" + opponentindex, ( 1, 1, 1 ), scale );
                linecount++;
                
                foreach ( teams in game[ #"tournamentdata" ].instanceteams[ opponentindex ] )
                {
                    mapname = getxhashsourcename( game[ #"action_park_utility" ].labels[ game[ #"tournamentdata" ].var_95b6628f01c7720e[ teams[ 0 ] ][ opponentindex ] ] );
                    vsstring = "<dev string:xa9>";
                    
                    foreach ( count, team in teams )
                    {
                        vsstring += team;
                        
                        if ( count == 0 )
                        {
                            vsstring += "<dev string:xaa>";
                        }
                        
                        if ( teams.size == 1 )
                        {
                            vsstring += "<dev string:xaf>";
                        }
                    }
                    
                    printtoscreen2d( startx, starty + stepy * linecount, "<dev string:x24>" + mapname + "<dev string:xb9>" + vsstring, ( 1, 1, 1 ), scale );
                    linecount++;
                }
            }
            
            startx += 600;
            starty = 200;
            
            foreach ( instance in game[ #"hash_1416f96bd943bf3c" ].instancedata )
            {
                linecount = 1;
                color = instance.completed ? ( 0, 1, 0 ) : ( 1, 1, 0 );
                mapname = getxhashsourcename( action_park_utility::get_combo_label( get_instance_arena( instance.id ) ) );
                printtoscreen2d( startx, starty + stepy * linecount, "<dev string:xbc>" + instance.id + "<dev string:xc7>" + mapname, color, scale );
                linecount++;
                printtoscreen2d( startx, starty + stepy * linecount, "<dev string:xd0>" + instance.state + "<dev string:xd8>" + ( instance.winner ?? "<dev string:xa9>" ) + "<dev string:xe4>" + ( instance.endreason ?? "<dev string:xa9>" ), ( 1, 1, 1 ), scale );
                linecount++;
                
                foreach ( team in instance.teams )
                {
                    color = game[ #"hash_1416f96bd943bf3c" ].var_dbae5446cc6c991[ team ] == "<dev string:xf3>" ? ( 1, 0, 0 ) : ( 0, 0, 1 );
                    printtoscreen2d( startx, starty + stepy * linecount, team + "<dev string:xfd>" + ( game[ "<dev string:x101>" ][ team ] ?? 0 ), color, scale );
                    linecount++;
                    
                    foreach ( player in level.teamdata[ team ][ "<dev string:x10c>" ] )
                    {
                        healthfull = player.health == player.maxhealth;
                        dead = !isalive( player );
                        
                        if ( healthfull )
                        {
                            color = ( 0, 1, 0 );
                        }
                        else if ( dead )
                        {
                            color = ( 1, 0, 0 );
                        }
                        else
                        {
                            frac = player.health / player.maxhealth;
                            color = vectorlerp( ( 1, 0, 0 ), ( 1, 1, 0 ), frac );
                        }
                        
                        printtoscreen2d( startx + 25, starty + stepy * linecount, "<dev string:x24>" + player getentitynumber() + "<dev string:x114>" + player.health + "<dev string:x117>" + player.name, color, scale );
                        linecount++;
                        print3d( player.origin + ( 0, 0, 60 ), team, ( 1, 1, 1 ), 1, 0.5, undefined, 1 );
                    }
                }
                
                starty = starty + stepy * linecount + 50;
                teamcount++;
                
                if ( teamcount == 4 )
                {
                    teamcount = 0;
                    startx += 200;
                    starty = 200;
                }
            }
            
            waitframe();
        }
    }

#/
