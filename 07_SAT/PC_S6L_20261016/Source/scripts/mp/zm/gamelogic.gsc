// scripts\mp\zm\gamelogic.gsc  (hash_44cd18225e55c2ac.gscc) (size: 131971 Bytes / 0x20383 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x5917998d (1494718861)
// size ...... 131971 (0x20383)
// includes .. 137 (offset: 0x1c357)
// strings ... 725 (offset: 0x1c79f)
// dev strs .. 95  (offset: 0x1fec3)
// exports ... 191 (offset: 0x149fb)
// cseg ...... 0x3714 + 0x112e7 (0x149fb)
// imports ... 651 (offset: 0x167d3)
// animtree1 . 0   (offset: 0x20383)
// animtree2 . 0   (offset: 0x20383)
#using script_13131f7e98f45305;
#using script_13f607f4b5c51bc4;
#using script_3cb3908b3094b567;
#using script_57ac6bb18662ff27;
#using scripts\common\callbacks;
#using scripts\common\dof;
#using scripts\common\feature_init;
#using scripts\common\focus;
#using scripts\common\script;
#using scripts\common\shellshock_utility;
#using scripts\common\targetmarkergroups;
#using scripts\common\telemetry;
#using scripts\common\telemetry_utils;
#using scripts\common\ui;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle;
#using scripts\common\vehicle_ai;
#using scripts\common\weapon;
#using scripts\common\whizby;
#using scripts\mp\accolades;
#using scripts\mp\ammorestock;
#using scripts\mp\analyticslog;
#using scripts\mp\armor;
#using scripts\mp\awards;
#using scripts\mp\battlechatter_mp;
#using scripts\mp\bots\bots;
#using scripts\mp\bots\bots_loadout;
#using scripts\mp\bounty;
#using scripts\mp\br\gametypes\br;
#using scripts\mp\br\gametypes\br_pickups;
#using scripts\mp\br\gametypes\br_plunder;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\brclientmatchdata;
#using scripts\mp\brmatchdata;
#using scripts\mp\callouts;
#using scripts\mp\challenges;
#using scripts\mp\class;
#using scripts\mp\clientmatchdata;
#using scripts\mp\common\killstreaks\init;
#using scripts\mp\common\killstreaks\killstreaks;
#using scripts\mp\common\perks\perkpackage;
#using scripts\mp\common\perks\perks;
#using scripts\mp\common\utility\connect_event_aggregator;
#using scripts\mp\common\utility\dialog;
#using scripts\mp\common\utility\disconnect_event_aggregator;
#using scripts\mp\common\utility\dvars;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\inventory;
#using scripts\mp\common\utility\killstreak;
#using scripts\mp\common\utility\lower_message;
#using scripts\mp\common\utility\lui_game_event_aggregator;
#using scripts\mp\common\utility\musicbank_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\player_frame_update_aggregator;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\print;
#using scripts\mp\common\utility\sound;
#using scripts\mp\common\utility\team_utility;
#using scripts\mp\common\utility\teams;
#using scripts\mp\common\utility\trigger;
#using scripts\mp\common\utility\weapon;
#using scripts\mp\common\utility\weapon_utility;
#using scripts\mp\damage;
#using scripts\mp\damagefeedback;
#using scripts\mp\deathicons;
#using scripts\mp\door;
#using scripts\mp\emote;
#using scripts\mp\emp_debuff;
#using scripts\mp\ent_manager;
#using scripts\mp\entityheadicons;
#using scripts\mp\equipment;
#using scripts\mp\events;
#using scripts\mp\execution;
#using scripts\mp\final_killcam;
#using scripts\mp\flags;
#using scripts\mp\flashpoint;
#using scripts\mp\gamelogic;
#using scripts\mp\gameobjects;
#using scripts\mp\gamescore;
#using scripts\mp\gametypes\common;
#using scripts\mp\gestures;
#using scripts\mp\gestures_mp;
#using scripts\mp\hostmigration;
#using scripts\mp\hud;
#using scripts\mp\hud_message;
#using scripts\mp\hud_util;
#using scripts\mp\infilexfil\infilexfil;
#using scripts\mp\init_shared_funcs;
#using scripts\mp\juggernaut;
#using scripts\mp\killcam;
#using scripts\mp\laststand;
#using scripts\mp\lightarmor;
#using scripts\mp\load;
#using scripts\mp\loot;
#using scripts\mp\matchdata;
#using scripts\mp\matchstats;
#using scripts\mp\menus;
#using scripts\mp\mtx_weapon;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\outline;
#using scripts\mp\outofbounds;
#using scripts\mp\overlord;
#using scripts\mp\persistence;
#using scripts\mp\playercards;
#using scripts\mp\playerhealth;
#using scripts\mp\playerlogic;
#using scripts\mp\playerstats_interface;
#using scripts\mp\potg;
#using scripts\mp\rank;
#using scripts\mp\scoreboard;
#using scripts\mp\scripted_weapons;
#using scripts\mp\sentientpoolmanager;
#using scripts\mp\serversettings;
#using scripts\mp\shellshock;
#using scripts\mp\spawncamera;
#using scripts\mp\spawnlogic;
#using scripts\mp\spawnselection;
#using scripts\mp\spectating;
#using scripts\mp\sprays;
#using scripts\mp\squads;
#using scripts\mp\stat_limits;
#using scripts\mp\supers;
#using scripts\mp\talking_gun;
#using scripts\mp\teamrevive;
#using scripts\mp\teams;
#using scripts\mp\turret;
#using scripts\mp\weaponrank;
#using scripts\mp\weapons;
#using scripts\mp\zm\events;
#using scripts\mp\zm\points;
#using scripts\mp\zm\systems\zm_telemetry;
#using scripts\mp\zm\zm_player;
#using scripts\mp\zm\zm_playerstats;
#using scripts\mp\zm\zm_utility;

#namespace gamelogic_zm;

// Namespace gamelogic_zm
// Params 1
// Checksum 0x46e1e43b, Offset: 0x3732
// Size: 0x1df
function onforfeit( team )
{
    if ( isdefined( level.forfeitinprogress ) )
    {
        return;
    }
    
    level endon( #"abort_forfeit" );
    level thread forfeitwaitforabort();
    level.forfeitinprogress = 1;
    level.canprocessot = 0;
    
    if ( !level.teambased && level.players.size > 1 )
    {
        wait 10;
    }
    else
    {
        wait 1.05;
    }
    
    level.forfeit_aborted = 0;
    forfeit_delay = 20;
    matchforfeittimer( forfeit_delay );
    endreason = &"";
    
    if ( !isdefined( team ) )
    {
        endreason = game[ "end_reason" ][ "players_forfeited" ];
        winner = level.players[ 0 ];
    }
    else
    {
        if ( team == "allies" )
        {
            endreason = game[ "end_reason" ][ "spetsnaz_forfeited" ];
        }
        else
        {
            endreason = game[ "end_reason" ][ "marines_forfeited" ];
        }
        
        winner = team;
    }
    
    level.forcedend = 1;
    
    if ( isplayer( winner ) )
    {
        logstring( "forfeit, win: " + winner getxuid() + "(" + winner.name + ")" );
    }
    else
    {
        logstring( "forfeit, win: " + winner );
        
        foreach ( entry in level.teamnamelist )
        {
            logstring( entry + ":" + game[ "teamScores" ][ entry ] );
        }
    }
    
    thread endgame( winner, endreason );
}

// Namespace gamelogic_zm
// Params 0
// Checksum 0x1f155132, Offset: 0x3919
// Size: 0xe9
function forfeitwaitforabort()
{
    level endon( #"game_ended" );
    
    if ( getdvarfloat( @"scr_disable_forfeit_ship" ) == 1 )
    {
        level.disableforfeit = 1;
        level notify( #"abort_forfeit" );
    }
    else
    {
        level waittill( #"abort_forfeit" );
    }
    
    level.forfeit_aborted = 1;
    level.canprocessot = 1;
    
    foreach ( p in level.players )
    {
        p setclientomnvar( "ui_match_start_countdown", 0 );
        p setclientomnvar( "ui_match_in_progress", 1 );
    }
}

// Namespace gamelogic_zm
// Params 1
// Checksum 0xcc308b92, Offset: 0x3a0a
// Size: 0x168
function matchforfeittimer_internal( counttime )
{
    waittillframeend();
    level endon( #"hash_5f22342470264edc" );
    
    while ( counttime > 0 && !level.gameended && !level.forfeit_aborted && !level.ingraceperiod )
    {
        foreach ( p in level.players )
        {
            p setclientomnvar( "ui_match_start_countdown", counttime );
            p setclientomnvar( "ui_match_in_progress", 0 );
        }
        
        counttime--;
        hostmigration::waitlongdurationwithhostmigrationpause( 1 );
    }
    
    foreach ( p in level.players )
    {
        p setclientomnvar( "ui_match_start_countdown", 0 );
        p setclientomnvar( "ui_match_in_progress", 1 );
    }
}

// Namespace gamelogic_zm
// Params 1
// Checksum 0xe4a3684d, Offset: 0x3b7a
// Size: 0x42
function matchforfeittimer( duration )
{
    level notify( #"hash_5f22342470264edc" );
    counttime = int( duration );
    setomnvar( "ui_match_start_text", "opponent_forfeiting_in" );
    matchforfeittimer_internal( counttime );
}

// Namespace gamelogic_zm
// Params 1
// Checksum 0x74a40bbe, Offset: 0x3bc4
// Size: 0x441
function default_ondeadevent( team )
{
    logstring( "team eliminated: " + team );
    
    if ( isbrgamemode() )
    {
        foreach ( player in teams::getteamdata( team, "players" ) )
        {
            result = undefined;
            
            if ( player.pers[ "hasDoneAnyCombat" ] || player.pers[ "participation" ] )
            {
                result = "eliminated";
            }
            
            eventparams = [];
            function_b7a1afe79c577a08( player, eventparams );
            player game_utility::stopkeyearning( result, eventparams );
        }
        
        playerendmatch();
    }
    
    if ( team == "all" )
    {
        logstring( "tie" );
        
        foreach ( entry in level.teamnamelist )
        {
            logstring( entry + ": " + game[ "teamScores" ][ entry ] );
        }
        
        if ( level.teambased )
        {
            thread endgame( "tie", game[ "end_reason" ][ "tie" ] );
        }
        else
        {
            thread endgame( undefined, game[ "end_reason" ][ "tie" ] );
        }
        
        return;
    }
    
    enemyteams = team_utility::getenemyteams( team );
    livescount = [];
    
    foreach ( entry in enemyteams )
    {
        livescount[ entry ] = 0;
    }
    
    if ( !level.disablespawning )
    {
        foreach ( entry in enemyteams )
        {
            foreach ( player in teams::getteamdata( entry, "players" ) )
            {
                if ( !player.hasspawned )
                {
                    continue;
                }
                
                livescount[ entry ] += player.pers[ "lives" ];
            }
        }
    }
    
    remainingteams = [];
    
    foreach ( entry in enemyteams )
    {
        if ( teams::getteamdata( entry, "aliveCount" ) || livescount[ entry ] )
        {
            remainingteams[ remainingteams.size ] = entry;
        }
    }
    
    var_760bf54d2dd70c96 = 1;
    
    if ( isdefined( level.var_760bf54d2dd70c96 ) )
    {
        var_760bf54d2dd70c96 = [[ level.var_760bf54d2dd70c96 ]]();
    }
    
    if ( remainingteams.size == 1 && !br::function_ee15a28564f11e4e() && var_760bf54d2dd70c96 )
    {
        thread endgame( remainingteams[ 0 ], game[ "end_reason" ][ "enemies_eliminated" ], game[ "end_reason" ][ "br_eliminated" ] );
    }
}

// Namespace gamelogic_zm
// Params 1
// Checksum 0x5176f207, Offset: 0x400d
// Size: 0x8b, Type: bool
function default_ononeleftevent( team )
{
    if ( level.teambased )
    {
        assert( arraycontains( level.teamnamelist, team ) );
        lastplayer = game_utility_mp::getlastlivingplayer( team );
        
        if ( isdefined( lastplayer ) )
        {
            lastplayer thread givelastonteamwarning();
        }
    }
    else
    {
        lastplayer = game_utility_mp::getlastlivingplayer();
        logstring( "last one alive, win: " + lastplayer.name );
        thread endgame( lastplayer, game[ "end_reason" ][ "enemies_eliminated" ] );
    }
    
    return true;
}

// Namespace gamelogic_zm
// Params 2
// Checksum 0x68d513bb, Offset: 0x40a1
// Size: 0x357
function roundend_checkscorelimit( team, allowtie )
{
    checkteamscorelimitsoon( team );
    
    if ( allowtie )
    {
        level notify( #"hash_9e97b0b976383856" );
        level endon( #"hash_9e97b0b976383856" );
        waitframe();
    }
    
    wingamebytype = game_utility_mp::getwingamebytype();
    
    if ( game_utility_mp::inovertime() || game_utility_mp::intimetobeat() )
    {
        if ( game_utility_mp::istimetobeatrulegametype() )
        {
            if ( game_utility_mp::settimetobeat( team ) )
            {
                foreach ( player in level.players )
                {
                    player setclientomnvar( "ui_friendly_time_to_beat", player.team == game[ "timeToBeatTeam" ] ? game[ "timeToBeat" ] : game[ "timeToBeatOld" ] );
                    player setclientomnvar( "ui_enemy_time_to_beat", player.team != game[ "timeToBeatTeam" ] ? game[ "timeToBeat" ] : game[ "timeToBeatOld" ] );
                }
                
                thread endgame( team, game[ "end_reason" ][ "score_limit_reached" ] );
            }
        }
        else if ( game_utility_mp::isscoretobeatrulegametype() )
        {
        }
        else
        {
            thread endgame( team, game[ "end_reason" ][ "score_limit_reached" ] );
        }
        
        return;
    }
    
    if ( level.roundscorelimit > 0 )
    {
        var_38a598c9ed7fae70 = [];
        
        foreach ( entry in level.teamnamelist )
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
                    thread endgame( "tie", game[ "end_reason" ][ "score_limit_reached" ] );
                }
                else
                {
                    thread endgame( highestteam, game[ "end_reason" ][ "score_limit_reached" ] );
                }
                
                return;
            }
            
            thread endgame( var_38a598c9ed7fae70[ 0 ], game[ "end_reason" ][ "score_limit_reached" ] );
        }
    }
}

// Namespace gamelogic_zm
// Params 0
// Checksum 0x2ebcd7ff, Offset: 0x4400
// Size: 0x17b
function default_ontimelimit()
{
    winner = "tie";
    
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
            winner = gamescore::gethighestscoringteam();
        }
        
        logstring( "time limit, win: " + winner );
        
        foreach ( entry in level.teamnamelist )
        {
            logstring( entry + ":" + game[ "teamScores" ][ entry ] );
        }
    }
    else
    {
        winner = gamescore::gethighestscoringplayer();
        
        if ( gamescore::ishighestscoringplayertied() )
        {
            winner = "tie";
        }
        
        if ( isplayer( winner ) )
        {
            logstring( "time limit, win: " + winner.name );
        }
        else
        {
            logstring( "time limit, tie" );
        }
    }
    
    thread endgame( winner, game[ "end_reason" ][ "time_limit_reached" ] );
}

// Namespace gamelogic_zm
// Params 0
// Checksum 0x796dd5e2, Offset: 0x4583
// Size: 0x28
function default_onhalftime()
{
    winner = undefined;
    thread endgame( "halftime", game[ "end_reason" ][ "time_limit_reached" ] );
}

// Namespace gamelogic_zm
// Params 1
// Checksum 0x659fdb67, Offset: 0x45b3
// Size: 0x290
function forceend( reason )
{
    if ( level.hostforcedend || level.forcedend )
    {
        return;
    }
    
    gamescore::updateplacement();
    
    if ( level.teambased )
    {
        foreach ( entry in level.teamnamelist )
        {
            gamescore::updatetotalteamscore( entry );
        }
    }
    
    winner = undefined;
    
    if ( level.teambased )
    {
        winner = gamescore::gethighestscoringteam();
        logstring( "host ended game, win: " + winner );
        
        foreach ( entry in level.teamnamelist )
        {
            logstring( entry + ":" + game[ "teamScores" ][ entry ] );
        }
    }
    else
    {
        winner = gamescore::gethighestscoringplayer();
        
        if ( isdefined( winner ) )
        {
            logstring( "host ended game, win: " + winner.name );
        }
        else
        {
            logstring( "host ended game, tie" );
        }
    }
    
    level.forcedend = 1;
    level.hostforcedend = 1;
    
    if ( level.splitscreen )
    {
        endstring = game[ "end_reason" ][ "ended_game" ];
    }
    else
    {
        endstring = game[ "end_reason" ][ "host_ended_game" ];
    }
    
    if ( reason == 2 )
    {
        if ( level.teambased )
        {
            if ( winner == "allies" )
            {
                endreason = game[ "end_reason" ][ "spetsnaz_forfeited" ];
            }
            else
            {
                endreason = game[ "end_reason" ][ "marines_forfeited" ];
            }
        }
        else
        {
            endreason = game[ "end_reason" ][ "players_forfeited" ];
        }
    }
    
    if ( reason == 77 )
    {
        endstring = game[ "end_reason" ][ "save_and_end_game" ];
    }
    
    if ( reason == 78 )
    {
        endstring = game[ "end_reason" ][ "server_quit" ];
    }
    
    if ( reason == 82 )
    {
        endstring = game[ "end_reason" ][ "cursed_mode_validation_failed" ];
    }
    
    level notify( #"force_end" );
    thread endgame( winner, endstring );
}

// Namespace gamelogic_zm
// Params 1
// Checksum 0xc059815b, Offset: 0x484b
// Size: 0x1c4
function onscorelimit( allowtie )
{
    scoretext = game[ "end_reason" ][ "score_limit_reached" ];
    winner = "tie";
    
    if ( level.teambased )
    {
        winner = gamescore::calculatewinningteam();
        
        if ( winner == "none" )
        {
            winner = "tie";
        }
        
        logstring( "scorelimit, win: " + winner );
        
        foreach ( entry in level.teamnamelist )
        {
            logstring( entry + ":" + game[ "teamScores" ][ entry ] );
        }
    }
    else
    {
        winner = gamescore::gethighestscoringplayer();
        
        if ( allowtie && gamescore::ishighestscoringplayertied() )
        {
            winner = "tie";
        }
        
        if ( isplayer( winner ) )
        {
            logstring( "scorelimit, win: " + winner.name );
        }
        else
        {
            logstring( "scorelimit, tie" );
        }
        
        nukecost = winner killstreaks::calcstreakcost( "nuke" );
        
        if ( game_utility_mp::getscorelimit() == nukecost && winner.pers[ "cur_kill_streak" ] == nukecost )
        {
            level.modescorewinner = winner;
            level.starttime = gettime();
            level.discardtime = 0;
            level.timerpausetime = 0;
            level.timelimit = 30;
            level.dontendonscore = 1;
            return;
        }
    }
    
    thread endgame( winner, scoretext );
    return 1;
}

// Namespace gamelogic_zm
// Params 0
// Checksum 0x367cf86d, Offset: 0x4a18
// Size: 0x932
function updategameevents()
{
    totalplayers = 0;
    level.teamswithplayers = [];
    
    foreach ( team in level.teamnamelist )
    {
        teamcount = teams::getteamdata( team, "teamCount" );
        totalplayers += teamcount;
        
        if ( teamcount )
        {
            level.teamswithplayers[ level.teamswithplayers.size ] = team;
        }
    }
    
    if ( game_utility_mp::matchmakinggame() && !flags::gameflag( "prematch_done" ) )
    {
        return;
    }
    
    if ( level.teamswithplayers.size == 1 && ( level.br_debugsolotest || !isbrgamemode() ) )
    {
        return;
    }
    
    if ( !game_utility_mp::getgametypenumlives() && !level.disablespawning )
    {
        return;
    }
    
    if ( !game_utility_mp::gamehasstarted() )
    {
        return;
    }
    
    if ( level.ingraceperiod && !isdefined( level.overrideingraceperiod ) )
    {
        return;
    }
    
    if ( level.teambased )
    {
        livescount = [];
        
        foreach ( entry in level.teamnamelist )
        {
            livescount[ entry ] = 0;
        }
        
        foreach ( player in level.players )
        {
            if ( !player.hasspawned || player.team == "spectator" || player.team == "codcaster" || player.team == "free" )
            {
                continue;
            }
            
            livescount[ player.team ] += player.pers[ "lives" ];
        }
        
        if ( level.disablespawning )
        {
            foreach ( entry in level.teamnamelist )
            {
                livescount[ entry ] = 0;
            }
        }
        
        hasalivecount = 0;
        
        foreach ( entry in level.teamnamelist )
        {
            if ( teams::getteamdata( entry, "aliveCount" ) )
            {
                hasalivecount = 1;
                break;
            }
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
                return;
            }
            
            return [[ level.ondeadevent ]]( "all" );
        }
        
        foreach ( entry in level.teamnamelist )
        {
            if ( !teams::getteamdata( entry, "aliveCount" ) && !livescount[ entry ] )
            {
                if ( level.postgameexfil && level.gameended )
                {
                    level notify( #"exfil_continue_game_end" );
                }
                
                if ( !level.skipondeadevent )
                {
                    if ( level.nukeinfo.incoming )
                    {
                        return;
                    }
                    
                    if ( level.multiteambased )
                    {
                        if ( !teams::getteamdata( entry, "deathEvent" ) && teams::getteamdata( entry, "hasSpawned" ) )
                        {
                            teams::setteamdata( entry, "deathEvent", 1 );
                            [[ level.ondeadevent ]]( entry );
                        }
                        
                        continue;
                    }
                    
                    return [[ level.ondeadevent ]]( entry );
                }
            }
        }
        
        foreach ( entry in level.teamnamelist )
        {
            var_ebfcf7b2dc2973a0 = teams::getteamdata( entry, "aliveCount" );
            
            if ( var_ebfcf7b2dc2973a0 == 1 || var_ebfcf7b2dc2973a0 == 2 )
            {
                teammatelives = 0;
                return_val = undefined;
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
                
                if ( teammatelives == 0 )
                {
                    if ( var_ebfcf7b2dc2973a0 == 1 && !teams::getteamdata( entry, "oneLeft" ) && gettime() > teams::getteamdata( entry, "oneLeftTime" ) + 5000 )
                    {
                        teams::setteamdata( entry, "oneLeftTime", gettime() );
                        teams::setteamdata( entry, "oneLeft", 1 );
                        
                        if ( players.size > 1 )
                        {
                            [[ level.ononeleftevent ]]( entry );
                        }
                    }
                }
                
                continue;
            }
            
            teams::setteamdata( entry, "oneLeft", 0 );
        }
        
        return;
    }
    
    livescount = 0;
    
    foreach ( player in level.players )
    {
        if ( player.team == "spectator" || player.team == "codcaster" )
        {
            continue;
        }
        
        livescount += player.pers[ "lives" ];
    }
    
    alivecounttotal = 0;
    
    foreach ( entry in level.teamnamelist )
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

// Namespace gamelogic_zm
// Params 1
// Checksum 0x7bbf2798, Offset: 0x5352
// Size: 0x83
function timelimitclock_intermission( waittime )
{
    setgameendtime( gettime() + int( waittime * 1000 ) );
    clockobject = spawn( "script_origin", ( 0, 0, 0 ) );
    clockobject.targetname = "timeLimitClock_Intermission";
    clockobject hide();
    
    if ( waittime >= 10 )
    {
        wait waittime - 10;
    }
    
    for ( ;; )
    {
        clockobject playsound( "ui_mp_timer_countdown" );
        wait 1;
    }
}

// Namespace gamelogic_zm
// Params 1
// Checksum 0x8c6fda59, Offset: 0x53dd
// Size: 0x300
function waitforplayers( maxtime )
{
    starttime = gettime();
    
    if ( game[ "isLaunchChunk" ] )
    {
        mintime = 0;
    }
    else if ( maxtime > 5 )
    {
        mintime = gettime() + getdvarint( @"min_wait_for_players" ) * 1000;
    }
    else
    {
        mintime = 0;
    }
    
    var_627995efe61b41ed = max( 1, level.connectingplayers / 2 );
    
    if ( game_utility::getgametype() == "dmz" )
    {
        var_627995efe61b41ed = level.connectingplayers;
    }
    
    flags::gameflagwait( "infil_setup_complete" );
    var_40e70d93a0b15d56 = 0;
    var_b28be27adc82e9e6 = 0;
    
    while ( true )
    {
        if ( game[ "roundsPlayed" ] )
        {
            break;
        }
        
        var_7433b73c8a47652c = level.maxplayercount;
        var_1eb7b19bd246a0ad = getstreamedinplayercount();
        
        if ( !var_40e70d93a0b15d56 )
        {
            if ( var_1eb7b19bd246a0ad > 0 )
            {
                starttime = gettime();
                var_40e70d93a0b15d56 = 1;
            }
            else
            {
                waitframe();
                continue;
            }
        }
        
        curtime = gettime();
        var_2bae312abacccbd2 = var_7433b73c8a47652c >= var_627995efe61b41ed;
        var_65957518390e3d2a = 0;
        
        if ( isdefined( level.var_65957518390e3d2a ) )
        {
            var_65957518390e3d2a = [[ level.var_65957518390e3d2a ]]();
        }
        else
        {
            var_65957518390e3d2a = var_1eb7b19bd246a0ad >= var_627995efe61b41ed;
        }
        
        if ( var_65957518390e3d2a )
        {
            foreach ( entry in level.teamnamelist )
            {
                if ( !checkrequiredteamcount( entry ) )
                {
                    var_2bae312abacccbd2 = 0;
                    break;
                }
            }
        }
        
        foreach ( entry in level.teamnamelist )
        {
            if ( !checkrequiredteamstreamcount( entry ) )
            {
                if ( game_utility::getgametype() == "arena" && !var_b28be27adc82e9e6 )
                {
                    setomnvar( "ui_match_start_text", "waiting_for_teams" );
                }
                
                var_65957518390e3d2a = 0;
                break;
            }
        }
        
        endtime = starttime + level.prematchperiod * 1000 - 200;
        
        if ( flags::gameflag( "infil_will_run" ) )
        {
            if ( var_65957518390e3d2a && curtime > mintime || curtime > endtime )
            {
                break;
            }
        }
        else if ( var_65957518390e3d2a && var_2bae312abacccbd2 && curtime > mintime || curtime > endtime )
        {
            break;
        }
        
        waitframe();
    }
    
    /#
        totaltime = gettime() - starttime;
        println( "<dev string:x24>" + totaltime + "<dev string:x3d>" );
    #/
}

// Namespace gamelogic_zm
// Params 0
// Checksum 0x3e3a91df, Offset: 0x56e5
// Size: 0x96
function getstreamedinplayercount()
{
    count = 0;
    
    foreach ( player in level.players )
    {
        if ( player.pers[ "streamSyncComplete" ] )
        {
            count++;
        }
    }
    
    return count;
}

// Namespace gamelogic_zm
// Params 1
// Checksum 0x1173ee54, Offset: 0x5784
// Size: 0x26, Type: bool
function checkrequiredteamcount( team )
{
    return teams::getteamdata( team, "hasSpawned" ) >= level.requiredplayercount[ team ];
}

// Namespace gamelogic_zm
// Params 1
// Checksum 0xe0819e88, Offset: 0x57b3
// Size: 0xbe, Type: bool
function checkrequiredteamstreamcount( team )
{
    count = 0;
    
    foreach ( player in level.players )
    {
        if ( player.team == team && player.pers[ "streamSyncComplete" ] )
        {
            count++;
        }
    }
    
    return count >= level.requiredplayercount[ team ];
}

// Namespace gamelogic_zm
// Params 1, eflags: 0x4
// Checksum 0x64674723, Offset: 0x587a
// Size: 0x4d
function private function_9e05c84b21ef7c5b( matchdelay )
{
    if ( getdvarint( @"hash_58a3206e3fd256a0", 0 ) != 0 )
    {
        return matchdelay;
    }
    
    var_e3c31db8827a0158 = level.var_725e93363e456224;
    
    if ( var_e3c31db8827a0158 > 0 )
    {
        level.var_725e93363e456224 = undefined;
        return var_e3c31db8827a0158;
    }
    
    return matchdelay;
}

// Namespace gamelogic_zm
// Params 0
// Checksum 0x14806134, Offset: 0x58d0
// Size: 0x41a
function prematchperiod()
{
    level endon( #"game_ended" );
    
    if ( !isdefined( level.connectingplayers ) )
    {
        level.connectingplayers = getdvarint( @"party_partyplayercountnum" );
    }
    
    if ( getdvarint( @"scr_live_lobby", 0 ) == 1 && !level.skipprematch )
    {
        game[ "inLiveLobby" ] = 1;
        
        if ( getdvarint( @"scr_enable_dev_livelobby_overrides", 0 ) == 1 )
        {
            level thread watchdevoverridematchstart();
        }
        
        level thread watchforminplayersmatchstart();
        level waittill( #"start_prematch" );
        setdvar( @"scr_live_lobby", 0 );
        game[ "inLiveLobby" ] = 0;
        game[ "liveLobbyCompleted" ] = 1;
        matchdelay = 30;
        
        if ( isbrgamemode() )
        {
            matchdelay = getmatchrulesdata( "brData", "preMatchStartTimer" );
        }
        
        /#
            if ( getdvarfloat( @"scr_match_timer", 0 ) > 0 )
            {
                matchdelay = getdvarfloat( @"scr_match_timer", 0 );
            }
            
            if ( getdvarfloat( @"hash_1c528462a5c6a55d", 0 ) > 0 )
            {
                spawnselectdelay = getdvarfloat( @"hash_1c528462a5c6a55d", 0 );
            }
        #/
        
        if ( isbrgamemode() && level.var_57b1cd68a632646d )
        {
            matchdelay = getmatchrulesdata( "brData", "preMatchStartTimer" );
        }
        
        level.allowprematchdamage = 0;
        matchdelay = function_9e05c84b21ef7c5b( matchdelay );
        level livelobbymatchstarttimer( "match_starting_in", matchdelay );
        level notify( #"start_prematch" );
        level.prematchperiod = 0;
        game[ "blockJIP" ] = 1;
    }
    else if ( !level.skipprematch )
    {
        if ( isbrgamemode() )
        {
            minplayers = getdvarint( @"br_minplayers" );
            
            if ( minplayers != 0 )
            {
                level thread brwatchforminplayersmatchstart();
                level waittill( #"start_prematch" );
                
                /#
                    var_7ae128606f35d684 = 0;
                    
                    while ( level.bot_spawn_in_progress )
                    {
                        var_7ae128606f35d684 = 1;
                        waitframe();
                    }
                    
                    foreach ( player in level.players )
                    {
                        if ( !isdefined( player ) )
                        {
                            continue;
                        }
                        
                        if ( isbot( player ) || istestclient( player ) )
                        {
                            while ( isdefined( player ) && !player.hasspawned )
                            {
                                waitframe();
                            }
                        }
                    }
                    
                    if ( var_7ae128606f35d684 )
                    {
                        wait 1;
                    }
                #/
            }
            
            matchdelay = 15;
            
            /#
                if ( getdvarfloat( @"scr_match_timer", 0 ) > 0 )
                {
                    matchdelay = getdvarfloat( @"scr_match_timer", 0 );
                }
            #/
            
            level.allowprematchdamage = 0;
            
            if ( isbrgamemode() )
            {
                if ( game_utility::getgametype() != "dmz" )
                {
                    level.allowprematchdamage = 1;
                }
                
                if ( level.var_57b1cd68a632646d )
                {
                    matchdelay = getmatchrulesdata( "brData", "preMatchStartTimer" );
                }
            }
            
            matchdelay = function_9e05c84b21ef7c5b( matchdelay );
            level livelobbymatchstarttimer( "match_starting_in", matchdelay );
        }
    }
    
    /#
        if ( level.mapname == "<dev string:x54>" && !game_utility_mp::isprophuntgametype() )
        {
            level thread givebmodevloadouts();
        }
    #/
    
    if ( level.skipprematch )
    {
        while ( !level.players.size )
        {
            waitframe();
        }
    }
    
    if ( game[ "matchStartRequiresInput" ] )
    {
        level waittill( #"hash_c2ba6f5e09e6a9a0" );
    }
    
    if ( game[ "blockJIP" ] )
    {
        setnojipscore( 1, 1 );
        setnojiptime( 1, 1 );
        level.nojip = 1;
    }
    
    level notify( #"prematch_started" );
    updatetournamentroundtime( gettimeremaining(), 2 );
    level.prematchstarted = 1;
    
    if ( level.prematchperiodend > 0 )
    {
        matchstarttimerwaitforplayers();
    }
    else
    {
        matchstarttimerskip();
    }
    
    hostmigration::waittillhostmigrationdone();
    updatetournamentroundtime( gettimeremaining(), 0 );
    
    if ( game[ "state" ] != "playing" )
    {
        return;
    }
}

// Namespace gamelogic_zm
// Params 0
// Checksum 0x59cd6aa0, Offset: 0x5cf2
// Size: 0x1c, Type: bool
function inprematch()
{
    return !level.skipprematch && !flags::gameflag( "graceperiod_done" );
}

// Namespace gamelogic_zm
// Params 0
// Checksum 0x3065307b, Offset: 0x5d17
// Size: 0x9b
function givebmodevloadouts()
{
    wait 3;
    
    if ( isdefined( level.parachuterestoreweaponscb ) )
    {
        foreach ( player in level.players )
        {
            if ( player::isreallyalive( player ) )
            {
                player [[ level.parachuterestoreweaponscb ]]();
            }
        }
    }
}

// Namespace gamelogic_zm
// Params 0
// Checksum 0x707bd72a, Offset: 0x5dba
// Size: 0x118
function graceperiod()
{
    level endon( #"game_ended" );
    
    if ( !isdefined( game[ "clientActive" ] ) )
    {
        while ( getactiveclientcount() == 0 )
        {
            waitframe();
        }
        
        game[ "clientActive" ] = 1;
    }
    
    while ( level.ingraceperiod > 0 )
    {
        wait 1;
        level.ingraceperiod--;
    }
    
    level notify( #"grace_period_ending" );
    waitframe();
    flags::gameflagset( "graceperiod_done" );
    level.ingraceperiod = 0;
    
    if ( game[ "state" ] != "playing" )
    {
        return;
    }
    
    if ( game_utility_mp::getgametypenumlives() )
    {
        players = level.players;
        
        for ( i = 0; i < players.size ; i++ )
        {
            player = players[ i ];
            
            if ( !player.hasspawned && player.sessionteam != "spectator" && !isalive( player ) )
            {
                player.statusicon = "hud_status_dead";
            }
        }
    }
    
    level thread [[ level.updategameevents ]]();
}

// Namespace gamelogic_zm
// Params 2
// Checksum 0x1ba1a1bc, Offset: 0x5eda
// Size: 0x1a1
function sethasdonecombat( player, newhasdonecombat )
{
    if ( newhasdonecombat && !player.hasdonecombat )
    {
        class::disableclassswapallowed();
    }
    
    player.hasdonecombat = newhasdonecombat;
    
    if ( isbrgamemode() && !flags::gameflag( "prematch_done" ) )
    {
        return;
    }
    
    if ( newhasdonecombat && !player.pers[ "hasDoneAnyCombat" ] )
    {
        player.pers[ "hasDoneAnyCombat" ] = 1;
        
        if ( isbrgamemode() )
        {
            if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( player ) ) )
            {
                if ( isdefined( player.leaderboarddata[ "gamesPlayed" ] ) )
                {
                    player.leaderboarddata[ "gamesPlayed" ] = player.leaderboarddata[ "gamesPlayed" ] + 1;
                }
                
                if ( isdefined( level.leaderboardfunc[ "gamesPlayed" ] ) )
                {
                    [[ level.leaderboardfunc[ "gamesPlayed" ] ]]( player, 1 );
                }
                
                assert( isint( 1 ) || isfloat( 1 ), "<dev string:x64>" );
                
                if ( isdefined( player.pers[ "gamesPlayed" ] ) )
                {
                    player.pers[ "gamesPlayed" ] = player.pers[ "gamesPlayed" ] + 1;
                }
            }
        }
        
        if ( isdefined( player.pers[ "hasMatchLoss" ] ) && player.pers[ "hasMatchLoss" ] )
        {
            return;
        }
        
        gamelogic_mp::updatelossstats( player );
    }
}

// Namespace gamelogic_zm
// Params 1
// Checksum 0xe03b73f9, Offset: 0x6083
// Size: 0x1a0
function updatewinstats( winner )
{
    println( "<dev string:x8a>" + winner getentitynumber() );
    
    if ( !winner game_utility_mp::onlinestatsenabled() )
    {
        println( "<dev string:xa6>" );
        return;
    }
    
    if ( !winner.pers[ "hasDoneAnyCombat" ] )
    {
        println( "<dev string:xd2>" );
        return;
    }
    
    if ( winner.pers[ "recordedLoss" ] )
    {
        winner playerstats_interface::addtoplayerstat( -1, "matchStats", "losses" );
    }
    
    /#
        println( "<dev string:x102>" + winner playerstats_interface::getplayerstat( "<dev string:x113>", "<dev string:x11e>" ) );
        println( "<dev string:x123>" + winner playerstats_interface::getplayerstat( "<dev string:x113>", "<dev string:x11e>" ) );
        println( "<dev string:x13b>" );
    #/
    
    winner playerstats_interface::addtoplayerstat( 1, "matchStats", "wins" );
    println( "<dev string:x123>" + winner playerstats_interface::getplayerstat( "<dev string:x113>", "<dev string:x11e>" ) );
    winner playerstats_interface::addtoplayerstat( 1, "matchStats", "currentWinStreak" );
    winner playerstats_interface::addtoplayerstat( 1, "modeRecords", game_utility::getgametype() );
    cur_win_streak = winner playerstats_interface::getplayerstat( "matchStats", "currentWinStreak" );
    
    if ( cur_win_streak > winner playerstats_interface::getplayerstat( "bestStats", "longestWinStreak" ) )
    {
        winner playerstats_interface::setplayerstat( cur_win_streak, "bestStats", "longestWinStreak" );
    }
    
    winner persistence::statsetchild( "round", "win", 1 );
    winner persistence::statsetchild( "round", "loss", 0 );
}

// Namespace gamelogic_zm
// Params 1
// Checksum 0x25fde0cd, Offset: 0x622b
// Size: 0xa3
function updatelossstats( loser )
{
    if ( !loser game_utility_mp::onlinestatsenabled() )
    {
        return;
    }
    
    if ( !loser.pers[ "hasDoneAnyCombat" ] )
    {
        return;
    }
    
    loser.pers[ "hasMatchLoss" ] = 1;
    
    if ( !self.joinedinprogress )
    {
        loser playerstats_interface::addtoplayerstat( 1, "matchStats", "losses" );
        loser.pers[ "recordedLoss" ] = 1;
    }
    
    loser playerstats_interface::addtoplayerstat( 1, "matchStats", "gamesPlayed" );
    loser persistence::statsetchild( "round", "loss", 1 );
}

// Namespace gamelogic_zm
// Params 1
// Checksum 0x530de3b6, Offset: 0x62d6
// Size: 0x95
function updatetiestats( loser )
{
    if ( !loser game_utility_mp::onlinestatsenabled() )
    {
        return;
    }
    
    if ( !loser.pers[ "hasDoneAnyCombat" ] )
    {
        return;
    }
    
    if ( loser.pers[ "recordedLoss" ] )
    {
        loser playerstats_interface::addtoplayerstat( -1, "matchStats", "losses" );
        loser playerstats_interface::setplayerstat( 0, "matchStats", "currentWinStreak" );
    }
    
    loser playerstats_interface::addtoplayerstat( 1, "matchStats", "ties" );
    loser persistence::statsetchild( "round", "loss", 0 );
}

// Namespace gamelogic_zm
// Params 1
// Checksum 0x89762981, Offset: 0x6373
// Size: 0x4d0
function updatewinlossstats( winner )
{
    println( "<dev string:x15f>" );
    
    if ( game_utility_mp::privatematch() )
    {
        println( "<dev string:x179>" );
        return;
    }
    
    if ( !game_utility_mp::waslastround() )
    {
        println( "<dev string:x1a7>" );
        return;
    }
    
    level.processedwinloss = 1;
    players = level.players;
    updateplayercombatstatus();
    
    if ( !isdefined( winner ) || isstring( winner ) && winner == "tie" )
    {
        println( "<dev string:x1d2>" );
        
        foreach ( player in level.players )
        {
            if ( isdefined( player.connectedpostgame ) )
            {
                continue;
            }
            
            if ( level.hostforcedend && player ishost() )
            {
                player playerstats_interface::setplayerstat( 0, "matchStats", "currentWinStreak" );
                continue;
            }
            
            updatetiestats( player );
        }
    }
    else if ( isplayer( winner ) )
    {
        println( "<dev string:x203>" );
        
        if ( level.hostforcedend && winner ishost() )
        {
            winner playerstats_interface::setplayerstat( 0, "matchStats", "currentWinStreak" );
            return;
        }
        
        if ( game_utility::getgametype() == "zm_rb_battle" )
        {
            updatewinstats( winner );
        }
        else if ( isdefined( level.lastplayerwins ) )
        {
            updatewinstats( level.placement[ "all" ][ 0 ] );
        }
        else
        {
            for ( pidx = 0; pidx < min( level.placement[ "all" ].size, 3 ) ; pidx++ )
            {
                updatewinstats( level.placement[ "all" ][ pidx ] );
            }
        }
    }
    else if ( isstring( winner ) )
    {
        println( "<dev string:x228>" + winner + "<dev string:x24f>" );
        
        foreach ( player in level.players )
        {
            println( "<dev string:x251>" + player getentitynumber() + "<dev string:x26f>" + player.name + "<dev string:x272>" );
            
            if ( isdefined( player.connectedpostgame ) )
            {
                println( "<dev string:x274>" );
                continue;
            }
            
            if ( level.hostforcedend && player ishost() )
            {
                println( "<dev string:x2ad>" );
                player playerstats_interface::setplayerstat( 0, "matchStats", "currentWinStreak" );
                continue;
            }
            
            if ( winner == "tie" )
            {
                println( "<dev string:x303>" );
                updatetiestats( player );
                continue;
            }
            
            if ( player.pers[ "team" ] == winner )
            {
                println( "<dev string:x332>" );
                updatewinstats( player );
                continue;
            }
            
            println( "<dev string:x36e>" );
            
            if ( player.pers[ "recordedLoss" ] )
            {
                println( "<dev string:x3a3>" );
                player playerstats_interface::setplayerstat( 0, "matchStats", "currentWinStreak" );
            }
        }
    }
    
    println( "<dev string:x3c8>" );
    
    foreach ( player in level.players )
    {
        println( "<dev string:x251>" + player getentitynumber() );
        
        if ( !isdefined( player ) || !player game_utility_mp::onlinestatsenabled() )
        {
            println( "<dev string:x3ee>" );
            continue;
        }
        
        if ( isai( player ) )
        {
            println( "<dev string:x420>" );
            continue;
        }
        
        wins = player playerstats_interface::getplayerstat( "matchStats", "wins" );
        println( "<dev string:x44b>" + wins );
        
        if ( wins >= 5 )
        {
            println( "<dev string:x467>" );
            player giveachievement( "MP_ACHIEVEMENT_1" );
        }
    }
}

// Namespace gamelogic_zm
// Params 0
// Checksum 0xa3fa8e55, Offset: 0x684b
// Size: 0xe7
function updateplayercombatstatus()
{
    if ( !game_utility::isinfectedgametype() )
    {
        return;
    }
    
    foreach ( player in level.players )
    {
        if ( player.sessionstate == "spectator" && !player.spectatekillcam )
        {
            continue;
        }
        
        if ( player.pers[ "hasDoneAnyCombat" ] )
        {
            continue;
        }
        
        if ( player.team == "axis" )
        {
            continue;
        }
        
        player sethasdonecombat( player, 1 );
    }
}

// Namespace gamelogic_zm
// Params 1
// Checksum 0xb417a910, Offset: 0x693a
// Size: 0x6d
function freezeplayerforroundend( delay )
{
    self endon( #"disconnect" );
    lower_message::setlowermessageomnvar( "clear_lower_msg" );
    lower_message::clearlowermessages();
    
    if ( !isdefined( delay ) )
    {
        delay = level.framedurationseconds;
    }
    
    wait delay;
    val::group_set( "gameEndFreeze", 0 );
    
    if ( self isonground() || self isonladder() )
    {
        self allowmovement( 0 );
        return;
    }
    
    gameendfreezemovement();
}

// Namespace gamelogic_zm
// Params 0
// Checksum 0xb16166a, Offset: 0x69af
// Size: 0x53
function gameendfreezemovement()
{
    timecheck = 0;
    
    while ( timecheck < 1 )
    {
        if ( !self isonground() )
        {
            timecheck += level.framedurationseconds;
        }
        else
        {
            self allowmovement( 0 );
            break;
        }
        
        wait level.framedurationseconds;
    }
    
    self allowmovement( 0 );
}

// Namespace gamelogic_zm
// Params 2
// Checksum 0xb923a026, Offset: 0x6a0a
// Size: 0x4aa
function updatematchbonusscores( winner, var_c51215b779b5fe59 )
{
    if ( !game[ "timePassed" ] )
    {
        return;
    }
    
    if ( !game_utility_mp::matchmakinggame() )
    {
        return;
    }
    
    if ( !game_utility_mp::gettimelimit() || level.forcedend )
    {
        gamelength = game_utility::gettimepassed() / 1000;
        gamelength = min( gamelength, 7200 );
    }
    else
    {
        gamelength = game_utility_mp::gettimelimit();
    }
    
    if ( function_598b3aad1aa54a90() )
    {
        if ( winner != "tie" && !var_c51215b779b5fe59 )
        {
            setwinningteam( winner );
        }
        
        foreach ( player in level.players )
        {
            if ( !player )
            {
                continue;
            }
            
            if ( var_c51215b779b5fe59 && player != var_c51215b779b5fe59 )
            {
                continue;
            }
            
            if ( isdefined( player.connectedpostgame ) )
            {
                continue;
            }
            
            if ( !player game_utility_mp::rankingenabled() )
            {
                continue;
            }
            
            if ( player.timeplayed[ "total" ] < 1 || player.pers[ "participation" ] < 1 )
            {
                continue;
            }
            
            if ( level.hostforcedend && player ishost() )
            {
                continue;
            }
            
            if ( !player.pers[ "hasDoneAnyCombat" ] )
            {
                continue;
            }
            
            if ( player.matchbonus && player.matchbonus > 0 )
            {
                continue;
            }
            
            if ( winner == "tie" )
            {
                playerscore = player calculatematchbonus( #"tie", gamelength );
                player thread givematchbonus( "tie", playerscore );
                player.matchbonus = playerscore;
            }
            else if ( player.pers[ "team" ] == winner )
            {
                playerscore = player calculatematchbonus( #"win", gamelength );
                player thread givematchbonus( "win", playerscore );
                player.matchbonus = playerscore;
            }
            else if ( team_utility::isgameplayteam( player.pers[ "team" ] ) && player.pers[ "team" ] != winner )
            {
                playerscore = player calculatematchbonus( #"loss", gamelength );
                player thread givematchbonus( "loss", playerscore );
                player.matchbonus = playerscore;
            }
            
            player calculateweaponmatchbonus( gamelength );
        }
        
        return;
    }
    
    winnerresult = #"win";
    loserresult = #"loss";
    
    if ( !isdefined( winner ) )
    {
        winnerresult = #"tie";
        loserresult = #"tie";
    }
    
    foreach ( player in level.players )
    {
        if ( isdefined( player.connectedpostgame ) )
        {
            continue;
        }
        
        if ( player.timeplayed[ "total" ] < 1 || player.pers[ "participation" ] < 1 )
        {
            continue;
        }
        
        if ( !player.pers[ "hasDoneAnyCombat" ] )
        {
            continue;
        }
        
        if ( game_utility::getgametype() == "zm_rb_battle" )
        {
            iswinner = isplayer( winner ) && player == winner;
        }
        else
        {
            iswinner = 0;
            
            for ( pidx = 0; pidx < min( level.placement[ "all" ].size, 3 ) ; pidx++ )
            {
                if ( level.placement[ "all" ][ pidx ] != player )
                {
                    continue;
                }
                
                iswinner = 1;
            }
        }
        
        if ( iswinner )
        {
            playerscore = player calculatematchbonus( winnerresult, gamelength );
            player thread givematchbonus( "win", playerscore );
            player.matchbonus = playerscore;
        }
        else
        {
            playerscore = player calculatematchbonus( loserresult, gamelength );
            player thread givematchbonus( "loss", playerscore );
            player.matchbonus = playerscore;
        }
        
        player calculateweaponmatchbonus( gamelength );
    }
}

// Namespace gamelogic_zm
// Params 2
// Checksum 0x505b9786, Offset: 0x6ebc
// Size: 0xa4
function calculatematchbonus( matchresult, gamelength )
{
    matchbonusbaseline = 400;
    var_7c09bc0d59b4c13b = gamelength / 60;
    var_3bd52e459f2bddca = rank::function_7a4898caf286e53( matchresult );
    participationpercent = clamp( self.timeplayed[ "total" ] / gamelength, 0, 1 );
    modescalar = rank::function_d2b057b6b822181f();
    matchbonus = int( matchbonusbaseline * var_3bd52e459f2bddca * var_7c09bc0d59b4c13b * participationpercent * modescalar );
    matchbonus = int( min( matchbonus, 50000 ) );
    return matchbonus;
}

// Namespace gamelogic_zm
// Params 2
// Checksum 0xc4bcf987, Offset: 0x6f69
// Size: 0x106
function givematchbonus( scoretype, score )
{
    self endon( #"disconnect" );
    
    if ( isbrgamemode() && game_utility::getgametype() != "plunder" && game_utility::getgametype() != "kingslayer" )
    {
        return;
    }
    
    utility::waittill_any_ents( level, "give_match_bonus", self, "give_match_bonus" );
    msg = "giveMatchBonus: player " + self.name + " scoreType = " + scoretype + ", score = " + score;
    logstring( msg );
    println( msg );
    rank::giverankxp( getxhash( scoretype ), score, undefined, 1, 1 );
    
    if ( scoretype == "win" )
    {
        thread points::doscoreevent( #"match_complete_win" );
        return;
    }
    
    assert( scoretype == "<dev string:x48d>" || scoretype == "<dev string:x491>", "<dev string:x496>" + scoretype + "<dev string:x4c3>" );
    thread points::doscoreevent( #"match_complete" );
}

// Namespace gamelogic_zm
// Params 1
// Checksum 0x964de180, Offset: 0x7077
// Size: 0x348
function calculateweaponmatchbonus( gamelength )
{
    if ( self.pers[ "ignoreWeaponMatchBonus" ] || !isdefined( self.pers[ "killsPerWeapon" ] ) )
    {
        return;
    }
    
    killsperminavg = weaponrank::getgametypekillsperhouravg() / 60;
    var_7c09bc0d59b4c13b = gamelength / 60;
    var_33b2d2521b7e3b4d = int( killsperminavg * var_7c09bc0d59b4c13b );
    killincrement = int( 50 );
    participationpercent = self.timeplayed[ "total" ] / gamelength;
    var_661789fba8fe1d4b = killincrement * participationpercent;
    var_f4fe56c128ea7b5f = int( var_33b2d2521b7e3b4d * var_661789fba8fe1d4b );
    var_f4fe56c128ea7b5f -= int( self.pers[ "weaponMatchBonusKills" ] * var_661789fba8fe1d4b );
    
    if ( var_f4fe56c128ea7b5f <= 0 )
    {
        return;
    }
    
    totaldiff = 0;
    
    foreach ( data in self.pers[ "killsPerWeapon" ] )
    {
        totaldiff += var_33b2d2521b7e3b4d - data.killcount;
    }
    
    if ( totaldiff <= 0 )
    {
        return;
    }
    
    foreach ( weaponkey, data in self.pers[ "killsPerWeapon" ] )
    {
        ratio = ( var_33b2d2521b7e3b4d - data.killcount ) / totaldiff;
        xpgain = int( var_f4fe56c128ea7b5f * ratio );
        rank::incrankxp( 0, data, xpgain, "WeaponMatchBonus" );
        
        foreach ( var_e9144fc349a13b59, datastruct in self.pers[ "matchdataWeaponStats" ] )
        {
            if ( issubstr( var_e9144fc349a13b59, weaponkey ) )
            {
                if ( isdefined( datastruct.stats[ "kills" ] ) && data.killcount > 0 )
                {
                    specificratio = ratio * datastruct.stats[ "kills" ] / data.killcount;
                    xpgain = int( var_f4fe56c128ea7b5f * specificratio );
                    
                    if ( isdefined( datastruct.stats[ "xp_earned" ] ) )
                    {
                        datastruct.stats[ "xp_earned" ] = datastruct.stats[ "xp_earned" ] + xpgain;
                        continue;
                    }
                    
                    datastruct.stats[ "xp_earned" ] = xpgain;
                }
            }
        }
    }
}

// Namespace gamelogic_zm
// Params 1
// Checksum 0x81502076, Offset: 0x73c7
// Size: 0x98
function setxenonranks( winner )
{
    foreach ( player in level.players )
    {
        _setplayerteamrank( player );
        player.pers[ "xenonRankSet" ] = 0;
    }
}

// Namespace gamelogic_zm
// Params 2
// Checksum 0x2963d14, Offset: 0x7467
// Size: 0x41d
function _setplayerteamrank( player, teamplacement )
{
    if ( !isdefined( player ) )
    {
        return;
    }
    
    if ( !( isdefined( player.kills ) && isdefined( player.deaths ) ) )
    {
        println( "<dev string:x4c5>" );
        return;
    }
    
    if ( player.pers[ "xenonRankSet" ] )
    {
        return;
    }
    
    player.pers[ "xenonRankSet" ] = 1;
    
    if ( game_utility::getgametype() == "arena" )
    {
        if ( 1 > player.timeplayed[ "total" ] )
        {
            return;
        }
        
        if ( !isdefined( player.arenadamage ) )
        {
            return;
        }
        
        damage = player.arenadamage;
        println( "<dev string:x4ec>" + damage );
        function_871c7d9fbeeb5187( player, player.clientid, damage );
        return;
    }
    
    if ( game_utility_mp::isteamplacementsbmmmode() )
    {
        if ( !isdefined( teamplacement ) )
        {
            teamplacement = player.teamplacement ?? 0;
        }
        
        playerscore = 1000 - teamplacement;
        function_871c7d9fbeeb5187( player, player.clientid, playerscore );
        return;
    }
    
    if ( level.gamemodebundle.var_7de6c88bff8ba673 )
    {
        operatorkills = player.kills ?? 0;
        agentkills = player.agentkills ?? 0;
        downs = player.pers[ "downs" ] ?? 0;
        deaths = player.deaths ?? 0;
        suicides = player.pers[ "suicides" ] ?? 0;
        var_bf178ebef939e188 = player mp_afk::function_a10af3f5e26c28da() / 60 ?? 1;
        
        if ( var_bf178ebef939e188 == 0 )
        {
            var_bf178ebef939e188 = 1;
        }
        
        operatorkd = ( operatorkills - downs + deaths - suicides ) / var_bf178ebef939e188;
        agentkd = ( agentkills - downs + deaths - suicides ) / var_bf178ebef939e188;
        operatorweight = getdvarfloat( @"hash_9cdadf8cf57f485e", 0.75 );
        agentweight = getdvarfloat( @"hash_f4a4d4df91cf9f67", 0.25 );
        rank = operatorkd * operatorweight + agentkd * agentweight;
        println( "<dev string:x4f4>" + rank );
        println( "<dev string:x564>" + operatorweight + "<dev string:x5ad>" + operatorkills + "<dev string:x5c0>" + downs + "<dev string:x5c3>" + deaths + "<dev string:x5c5>" + suicides + "<dev string:x5c7>" + var_bf178ebef939e188 + "<dev string:x5cb>" );
        println( "<dev string:x5cd>" + agentweight + "<dev string:x613>" + agentkills + "<dev string:x5c0>" + downs + "<dev string:x5c3>" + deaths + "<dev string:x5c5>" + suicides + "<dev string:x5c7>" + var_bf178ebef939e188 + "<dev string:x5cb>" );
        function_871c7d9fbeeb5187( player, player.clientid, rank );
        return;
    }
    
    var_9acfc5169ae0e036 = getdvarint( @"hash_9e2f598909a3fc6e", 0 );
    
    if ( var_9acfc5169ae0e036 > player.timeplayed[ "total" ] )
    {
        return;
    }
    
    suicides = 0;
    
    if ( getdvarint( @"hash_8613ee8086b0e0f6" ) == 1 )
    {
        suicides = player.pers[ "suicides" ];
    }
    
    kd = ( player.kills - player.deaths - suicides ) / player.timeplayed[ "total" ] / 60;
    println( "<dev string:x62c>" + player.kills + "<dev string:x66a>" + player.deaths + "<dev string:x670>" + suicides + "<dev string:x674>" + player.timeplayed[ "<dev string:x67a>" ] / 60 + "<dev string:x680>" + kd );
    function_871c7d9fbeeb5187( player, player.clientid, kd );
}

// Namespace gamelogic_zm
// Params 3
// Checksum 0xc0c280ee, Offset: 0x788c
// Size: 0x46
function function_871c7d9fbeeb5187( player, clientid, matchrating )
{
    if ( getdvarint( @"hash_37cfe0ddf6b3688d" ) == 1 )
    {
        function_5d0687b8bf2ede74( player );
        return;
    }
    
    setplayerteamrank( player, clientid, matchrating );
}

// Namespace gamelogic_zm
// Params 1, eflags: 0x4
// Checksum 0x6039c21, Offset: 0x78da
// Size: 0x36
function private function_8fbbd8a58c312650( player )
{
    highestRound = int( player getplayerdata( level.var_6f9b00680ed002d8, "highestRound" ) ?? 0 );
    return highestRound;
}

// Namespace gamelogic_zm
// Params 1, eflags: 0x4
// Checksum 0xf560b670, Offset: 0x7919
// Size: 0x42
function private function_fabdbc494e0490d( player )
{
    zm_telemetry::function_31af6ca7b959eeec( player );
    var_e1b7556b914d1c1d = player.pers[ "telemetry" ].var_d6e5bf2becd1494e ?? 0;
    return var_e1b7556b914d1c1d;
}

// Namespace gamelogic_zm
// Params 1
// Checksum 0x91dbfffe, Offset: 0x7964
// Size: 0x3d6
function function_5d0687b8bf2ede74( player )
{
    highestroundcompleted = function_8fbbd8a58c312650( player );
    var_e1b7556b914d1c1d = function_fabdbc494e0490d( player );
    kills = player.pers[ "telemetry" ].kills ?? 0;
    assists = player.pers[ "telemetry" ].assists ?? 0;
    matchscore = player.total_score_earned ?? 0;
    var_f5a3a64a85c67b07 = int( utility::function_6f5d2e1f1ff70482( matchdata::gettimefrommatchstart( gettime() ) ) );
    var_d5fae0af5a48ab79 = { #var_5ef43d0cf7fd8bc6:0, #var_e900b6946dbb92c4:0, #var_a557f4f0f8b9ecb8:0, #var_c21798ce8e67dfa3:0, #var_2aed29b7ba07e00:0, #var_2aaec9b7b9cc157:0, #var_7f175bf198634a3d:0, #var_fcbda4eab7d9d7e:0, #var_3189b1f0a3edaf7f:0, #var_f8fc11c99b8755af:0, #var_59f1c41391663d10:0, #var_8ce90ef5b75f2d7e:0, #var_9359c2243c30d49c:0, #var_a3133284802455d0:0, #var_22963c270e4fa91b:0, #var_95ff8828b48f7488:0, #var_95fa8228b4893e7f:0, #var_67ba0985cd034fa5:0, #var_61e71b180ee55c46:0, #var_16e07f84d4ee7607:0, #var_5f8e875848a77937:0, #var_87e695fc50c7dec8:0, #var_422b4e79ade46b69:0, #var_4fc9a8d910ecb825:0, #var_b87d1f8daf10b113:0, #var_fc27b34d1b92ec52:0, #var_adccd0c097d8d869:0, #var_adbedec097c8afae:0, #var_1b1d6c8d3c84254a:0, #var_d255e71de562f929:0, #var_2bbd8a8e033fc164:0, #var_109b973ec23b496a:0, #var_9a90ea7b5fbdcb2f:0, #distancetraveled:0, #var_4ff7763d676f151c:0, #var_ce5329d11e92e90c:0, #var_f5a3a64a85c67b07:var_f5a3a64a85c67b07, #highestroundcompleted:highestroundcompleted, #var_e1b7556b914d1c1d:var_e1b7556b914d1c1d, #startinground:0, #matchscore:matchscore, #suicides:0, #friendlyfiredamage:0, #killstreaksused:0, #var_655e32d79c747afa:0, #shots:0, #teamplacement:0, #var_5eae1bf92490ef9:0, #var_13e6ba69727f881f:0, #var_92e8a7e8670aede9:0, #var_c9dc028690f1e8a1:0, #var_26c55ecfe31a4b9d:0, #var_95900a14a5d761d3:0, #var_7356ff6ae2982a85:0, #var_6de0d7e2975c3a6d:0, #var_f27689c9a42bcd00:0, #var_3f4e632a389f8a6:0, #var_2af598ab16749d14:0, #var_a0edfab0a487349c:0, #var_36030654a890442b:0, #var_13ea8e76b21e95f0:assists, #var_30ddd6ea93d133b7:0, #var_e4f5d3de3e26044e:0, #var_73e8269680835e15:kills, #var_6a3e5a9c18ab8213:0, #var_eb55c6b490696ab8:0, #var_b22acbe9c93eaaff:0, #var_27ab804f3ee34416:0, #var_f1ae3e0b0641a26d:0, #var_c7eceb42f8412f02:0, #playerkillassists:0, #playerheadshots:0, #playerhits:0, #playerkills:0 };
    team = player.team ?? "allies";
    function_b2975c6a3a5ce961( player, team, var_d5fae0af5a48ab79 );
}

// Namespace gamelogic_zm
// Params 1
// Checksum 0x568ae9b8, Offset: 0x7d42
// Size: 0x2ed
function checktimelimit( prevtimepassed )
{
    if ( isdefined( level.timelimitoverride ) && level.timelimitoverride )
    {
        return;
    }
    
    if ( game[ "state" ] != "playing" )
    {
        setgameendtime( 0 );
        return;
    }
    
    runjiprules();
    
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
    
    timeleft = gettimeremaining();
    setgameendtime( gettime() + int( timeleft ) );
    var_9546989e041b3a3f = istrue( level.ontimelimitgraceperiod );
    
    if ( timeleft > 0 && !isdefined( level.forceotlogictorun ) )
    {
        if ( var_9546989e041b3a3f )
        {
            if ( level.setallclientomnvarot )
            {
                setomnvarforallclients( "ui_overtime_timer_show", 0 );
                return;
            }
            
            setomnvar( "ui_overtime_timer_show", 0 );
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
                    setomnvarforallclients( "ui_overtime_timer_show", 1 );
                }
                
                setomnvarforallclients( "ui_overtime_timer", progress );
            }
            else
            {
                setomnvar( "ui_overtime_timer_show", 1 );
                setomnvar( "ui_overtime_timer", progress );
            }
            
            setomnvar( "ui_overtime_time", gettime() + level.ontimelimitgraceperiod * 1000 );
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
            
            setomnvar( "ui_overtime_time", gettime() + level.ontimelimitgraceperiod * 1000 );
        }
        
        if ( level.currenttimelimitdelay < level.ontimelimitgraceperiod )
        {
            return;
        }
    }
    
    [[ level.ontimelimit ]]();
}

// Namespace gamelogic_zm
// Params 0
// Checksum 0x78e56002, Offset: 0x8037
// Size: 0x1e
function enableovertimegameplay()
{
    level.ontimelimitgraceperiod = 5;
    level.currenttimelimitdelay = 0;
}

// Namespace gamelogic_zm
// Params 0
// Checksum 0xd227961f, Offset: 0x805d
// Size: 0x175
function runjiprules()
{
    if ( !level.matchmakingmatch )
    {
        return;
    }
    
    if ( !isdefined( level.nojip ) )
    {
        level.nojip = 0;
    }
    
    if ( !level.nojip )
    {
        if ( game_utility_mp::isroundbased() && !level.nojip )
        {
            switch ( game_utility::getgametype() )
            {
                case #"hash_4b8799075d3a89b8":
                case #"hash_f4a9126c03d3385b":
                    disablejip = checkdomjiprules();
                    break;
                case #"hash_53825b446469ac4c":
                case #"hash_5ff8e011d5b9d1c8":
                case #"hash_e2e043391c7c9074":
                case #"hash_eb5e5f470e0c1dc2":
                case #"hash_fa37b7f6bd6f6cbf":
                case #"hash_fa50b0f6bd82e972":
                case #"hash_fa50baf6bd82f930":
                    disablejip = function_699824bc984443db();
                    break;
                case #"hash_1a5d186c17c00d3c":
                    disablejip = checkctfjiprules();
                    break;
                case #"hash_fa0ed2f6bd4f4395":
                    disablejip = checkddjiprules();
                    break;
                default:
                    disablejip = checkdefaultjiprules();
                    break;
            }
            
            if ( disablejip )
            {
                setnojipscore( 1, 1 );
                setnojiptime( 1, 1 );
                level.nojip = 1;
            }
            
            return;
        }
        
        if ( game_utility_mp::gettimepassedpercentage() > level.timepercentagecutoff )
        {
            setnojiptime( 1, 1 );
            level.nojip = 1;
        }
    }
}

// Namespace gamelogic_zm
// Params 0
// Checksum 0x321e21db, Offset: 0x81da
// Size: 0x9d, Type: bool
function checkdomjiprules()
{
    if ( !game_utility_mp::isfirstround() )
    {
        foreach ( entry in level.teamnamelist )
        {
            if ( getteamscoreint( entry ) > 150 )
            {
                return true;
            }
        }
        
        if ( game_utility_mp::gettimepassedpercentage() > 75 )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace gamelogic_zm
// Params 0
// Checksum 0xbbf68842, Offset: 0x8280
// Size: 0x13c, Type: bool
function function_699824bc984443db()
{
    var_95b0ae5ea76bfb8b = 3;
    
    switch ( game_utility::getgametype() )
    {
        case #"hash_fa50b0f6bd82e972":
        case #"hash_fa50baf6bd82f930":
            var_95b0ae5ea76bfb8b = 3;
            break;
        case #"hash_53825b446469ac4c":
            var_95b0ae5ea76bfb8b = 2;
            break;
        case #"hash_eb5e5f470e0c1dc2":
            var_95b0ae5ea76bfb8b = 3;
            break;
        case #"hash_5ff8e011d5b9d1c8":
            var_95b0ae5ea76bfb8b = 3;
            break;
        case #"hash_fa37b7f6bd6f6cbf":
            var_95b0ae5ea76bfb8b = 3;
            break;
        case #"hash_e2e043391c7c9074":
            var_95b0ae5ea76bfb8b = 2;
            break;
        default:
            var_95b0ae5ea76bfb8b = 3;
            break;
    }
    
    if ( game_utility_mp::isanymlgmatch() )
    {
        var_95b0ae5ea76bfb8b = 5;
    }
    
    foreach ( entry in level.teamnamelist )
    {
        if ( game_utility_mp::getroundswon( entry ) >= var_95b0ae5ea76bfb8b )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace gamelogic_zm
// Params 0
// Checksum 0x904bab20, Offset: 0x83c5
// Size: 0xfe, Type: bool
function checkctfjiprules()
{
    if ( !game_utility_mp::isfirstround() )
    {
        if ( game_utility_mp::gettimepassedpercentage() > level.timepercentagecutoff )
        {
            return true;
        }
    }
    
    lowestscore = undefined;
    highestscore = undefined;
    
    foreach ( entry in level.teamnamelist )
    {
        teamscore = getteamscoreint( entry );
        
        if ( !isdefined( lowestscore ) || teamscore < lowestscore )
        {
            lowestscore = teamscore;
        }
        
        if ( !isdefined( highestscore ) || teamscore > highestscore )
        {
            highestscore = teamscore;
        }
    }
    
    delta = abs( highestscore - lowestscore );
    
    if ( delta > 10 )
    {
        return true;
    }
    
    return false;
}

// Namespace gamelogic_zm
// Params 0
// Checksum 0xeeaa4e88, Offset: 0x84cc
// Size: 0x96, Type: bool
function checkddjiprules()
{
    var_f62a4e80620c6ec8 = 0;
    
    foreach ( entry in level.teamnamelist )
    {
        var_f62a4e80620c6ec8 += game_utility_mp::getroundswon( entry );
    }
    
    if ( var_f62a4e80620c6ec8 >= 2 )
    {
        return true;
    }
    
    return false;
}

// Namespace gamelogic_zm
// Params 0
// Checksum 0x4a6aba1b, Offset: 0x856b
// Size: 0x22, Type: bool
function checkdefaultjiprules()
{
    if ( game_utility_mp::nextroundisfinalround() )
    {
        if ( game_utility_mp::gettimepassedpercentage() > level.timepercentagecutoff )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace gamelogic_zm
// Params 1
// Checksum 0xe2508081, Offset: 0x8596
// Size: 0x1a
function getteamscoreint( team )
{
    return int( game[ "teamScores" ][ team ] );
}

// Namespace gamelogic_zm
// Params 0
// Checksum 0x346945cf, Offset: 0x85b9
// Size: 0x13
function gettimeremaining()
{
    return game_utility_mp::gettimelimit() * 1000 - game_utility::gettimepassed();
}

// Namespace gamelogic_zm
// Params 0
// Checksum 0xef51d0f4, Offset: 0x85d5
// Size: 0x24
function gettimeremainingpercentage()
{
    timelimit = game_utility_mp::gettimelimit() * 1000;
    return ( timelimit - game_utility::gettimepassed() ) / timelimit;
}

// Namespace gamelogic_zm
// Params 1
// Checksum 0xce706bd5, Offset: 0x8602
// Size: 0x228
function checkteamscorelimitsoon( team )
{
    assert( isdefined( team ) );
    
    if ( level.roundscorelimit <= 0 || game_utility_mp::isobjectivebased() )
    {
        return;
    }
    
    if ( isdefined( level.scorelimitoverride ) && level.scorelimitoverride )
    {
        return;
    }
    
    if ( game_utility::getgametype() == "jugg" )
    {
        return;
    }
    
    if ( !level.teambased )
    {
        return;
    }
    
    shouldnotify = 0;
    
    if ( shouldcheckcustomclosetoscorelimit() )
    {
        shouldnotify = closetoscorelimit( team );
    }
    else if ( game_utility::getgametype() == "arm" )
    {
        closetoscore = closetoscorelimit( team );
        var_b810e1344f4b7a8e = gettimeremaining() < game_utility_mp::gettimelimit() * 0.075;
        shouldnotify = closetoscore || var_b810e1344f4b7a8e;
    }
    else if ( game_utility::gettimepassed() > 45000 )
    {
        shouldnotify = estimatedtimetillscorelimit( team ) < 0.5;
    }
    
    if ( !isdefined( level.playedmatchendingsoon ) )
    {
        level.playedmatchendingsoon = 0;
    }
    
    if ( !level.playedmatchendingsoon && shouldnotify )
    {
        level.playedmatchendingsoon = 1;
        level notify( #"match_ending_soon", "score" );
    }
    
    if ( !level.playedmatchendingsoon && game_utility_mp::canplayhalfwayvo() )
    {
        if ( getteamscore( team ) >= int( level.scorelimit * level.currentround - level.scorelimit / 2 ) )
        {
            dialog::leaderdialog( "halfway_friendly_score", team, "status" );
            enemyteams = team_utility::getenemyteams( team );
            
            foreach ( entry in enemyteams )
            {
                dialog::leaderdialog( "halfway_enemy_score", entry, "status" );
            }
            
            level.didhalfscorevoboost = 1;
        }
    }
}

// Namespace gamelogic_zm
// Params 0
// Checksum 0x2c99bb6e, Offset: 0x8832
// Size: 0x51
function shouldcheckcustomclosetoscorelimit()
{
    switch ( game_utility::getgametype() )
    {
        case #"hash_ca6516c10db2c95":
        case #"hash_3a17de6e294210d2":
        case #"hash_ea061d29bbd1f237":
        case #"hash_f4a9126c03d3385b":
            return 1;
        default:
            return 0;
    }
}

// Namespace gamelogic_zm
// Params 0
// Checksum 0x3aaa69a7, Offset: 0x888b
// Size: 0xca
function checkplayerscorelimitsoon()
{
    if ( level.roundscorelimit <= 0 || game_utility_mp::isobjectivebased() )
    {
        return;
    }
    
    if ( level.teambased )
    {
        return;
    }
    
    if ( game_utility::gettimepassed() < 60000 )
    {
        return;
    }
    
    if ( game_utility_mp::matchmakinggame() && isdefined( level.nojip ) && !level.nojip && !game_utility::isinfectedgametype() )
    {
        gamescore::checkffascorejip();
    }
    
    if ( game_utility::getgametype() == "gun" )
    {
        if ( self.score == 14 )
        {
            level notify( #"match_ending_soon", "score" );
        }
        
        return;
    }
    
    timeleft = estimatedtimetillscorelimit();
    
    if ( timeleft < 2 )
    {
        level notify( #"match_ending_soon", "score" );
    }
}

// Namespace gamelogic_zm
// Params 1
// Checksum 0x3bfc2daf, Offset: 0x895d
// Size: 0x169
function checkscorelimit( allowtie )
{
    if ( game_utility_mp::cantiebysimultaneouskill() )
    {
        allowtie = 1;
    }
    
    if ( allowtie )
    {
        if ( isplayer( self ) && !level.teambased && self.score >= level.roundscorelimit )
        {
            level.scorelimitreached = 1;
        }
        
        level notify( #"hash_125e998245029686" );
        level endon( #"hash_125e998245029686" );
        waitframe();
    }
    
    if ( game_utility_mp::isobjectivebased() )
    {
        return 0;
    }
    
    if ( isdefined( level.scorelimitoverride ) && level.scorelimitoverride )
    {
        return 0;
    }
    
    if ( game[ "state" ] != "playing" )
    {
        return 0;
    }
    
    if ( level.roundscorelimit <= 0 )
    {
        return 0;
    }
    
    if ( level.teambased )
    {
        limitreached = 0;
        
        for ( i = 0; i < level.teamnamelist.size ; i++ )
        {
            if ( game[ "teamScores" ][ level.teamnamelist[ i ] ] >= level.roundscorelimit )
            {
                limitreached = 1;
            }
        }
        
        if ( !limitreached )
        {
            return 0;
        }
    }
    else
    {
        if ( !isplayer( self ) )
        {
            return 0;
        }
        
        if ( self.score < level.roundscorelimit && !level.scorelimitreached )
        {
            return 0;
        }
    }
    
    if ( !level.dontendonscore )
    {
        return onscorelimit( allowtie );
    }
}

// Namespace gamelogic_zm
// Params 0
// Checksum 0xb0999d0, Offset: 0x8ace
// Size: 0x47
function updategametypedvars()
{
    level endon( #"game_ended" );
    
    while ( game[ "state" ] == "playing" )
    {
        if ( isdefined( level.starttime ) )
        {
            if ( gettimeremaining() < 3000 )
            {
                wait 0.1;
                continue;
            }
        }
        
        wait 1;
    }
}

// Namespace gamelogic_zm
// Params 0
// Checksum 0x8f2b5273, Offset: 0x8b1d
// Size: 0x10b
function matchstarttimerwaitforplayers()
{
    if ( utility::issharedfuncdefined( #"gametype", #"infilsequence" ) )
    {
        setomnvar( "ui_in_infil", 3 );
    }
    
    if ( !isbrgamemode() )
    {
        thread matchstarttimer( "match_starting_in", level.prematchperiod + level.prematchperiodend );
    }
    
    level thread prematchcountdownnotify();
    waitforplayers( level.prematchperiod );
    
    if ( level.prematchperiodend > 0 && !isdefined( level.hostmigrationtimer ) )
    {
        adjusted_time = level.prematchperiodend;
        level notify( #"match_start_real_countdown", adjusted_time );
        
        if ( !flags::gameflag( "infil_will_run" ) && game[ "roundsPlayed" ] == 0 && !game_utility::isarenamap() && game_utility::getgametype() != "dmz" )
        {
            level thread showmapchyron();
        }
        
        thread matchstarttimer( "match_starting_in", adjusted_time );
        thread prematchcountdownnotify( adjusted_time );
        level waittill( #"matchstarttimer_done" );
    }
}

// Namespace gamelogic_zm
// Params 0
// Checksum 0xc071bd15, Offset: 0x8c30
// Size: 0x2c
function showmapchyron()
{
    setomnvar( "ui_in_infil", 1 );
    level utility::waittill_notify_or_timeout( "matchStartTimer_done", 8 );
    setomnvar( "ui_in_infil", -1 );
}

// Namespace gamelogic_zm
// Params 1
// Checksum 0x150692ff, Offset: 0x8c64
// Size: 0x60
function prematchcountdownnotify( timeoverride )
{
    level notify( #"hash_8e8adfecbf7bea8b" );
    level endon( #"hash_8e8adfecbf7bea8b" );
    
    if ( isdefined( timeoverride ) )
    {
        wait max( timeoverride - 5, 0 );
    }
    else
    {
        wait max( level.prematchperiod + level.prematchperiodend - 5, 0 );
    }
    
    flags::gameflagset( "prematch_countdown" );
}

// Namespace gamelogic_zm
// Params 1
// Checksum 0xc5fad566, Offset: 0x8ccc
// Size: 0x75
function startmodeobjidnotify( time )
{
    self notify( #"startobjid" );
    self endon( #"startobjid" );
    
    if ( game_utility::getgametype() == "sd" )
    {
        notifytime = 6;
    }
    else
    {
        notifytime = 5;
    }
    
    if ( time > notifytime )
    {
        time -= notifytime;
        max( time, 0 );
        wait time;
    }
    else
    {
        wait 0.5;
    }
    
    level notify( #"start_mode_setup" );
}

// Namespace gamelogic_zm
// Params 2
// Checksum 0x2bed1674, Offset: 0x8d49
// Size: 0x1b2
function matchstarttimer( type, duration )
{
    self notify( #"hash_af7e9bbaadca5367" );
    self endon( #"hash_af7e9bbaadca5367" );
    level notify( #"match_start_timer_beginning" );
    println( "<dev string:x684>" + type + "<dev string:x696>" + duration + "<dev string:x69c>" );
    counttime = int( duration );
    level thread startmodeobjidnotify( counttime );
    
    if ( counttime >= 2 )
    {
        setomnvar( "ui_match_start_text", type );
        matchstarttimerperplayer_internal( counttime );
    }
    
    visionsetnaked( "", 0 );
    level notify( #"matchstarttimer_done" );
    println( "<dev string:x684>" + type + "<dev string:x6a5>" );
    
    if ( game_utility::function_d3f8957534dc62af() || level.testrandomrealismclients )
    {
        foreach ( player in level.players )
        {
            if ( level.testrandomrealismclients )
            {
                if ( !isdefined( player.isrealismenabled ) )
                {
                    if ( utility::cointoss() )
                    {
                        player setclientomnvar( "ui_realism_hud", 0 );
                        player setclientomnvar( "ui_realism_hud", 1 );
                        player.isrealismenabled = 1;
                    }
                }
                
                continue;
            }
            
            player setclientomnvar( "ui_realism_hud", 0 );
            player setclientomnvar( "ui_realism_hud", 1 );
        }
    }
}

// Namespace gamelogic_zm
// Params 1
// Checksum 0xefd0d382, Offset: 0x8f03
// Size: 0x16e
function matchstarttimerperplayer_internal( counttime )
{
    waittillframeend();
    level endon( #"match_start_timer_beginning" );
    mincounttime = undefined;
    
    foreach ( entry in level.teamnamelist )
    {
        adjustedtime = int( counttime );
        childthread teamstarttimer( entry, adjustedtime );
        
        if ( !isdefined( mincounttime ) || mincounttime < adjustedtime )
        {
            mincounttime = adjustedtime;
        }
    }
    
    extrateams = [ "spectator", "codcaster" ];
    
    foreach ( entry in extrateams )
    {
        adjustedtime = int( counttime );
        childthread teamstarttimer( entry, adjustedtime );
        
        if ( !isdefined( mincounttime ) || mincounttime < adjustedtime )
        {
            mincounttime = adjustedtime;
        }
    }
    
    childthread clearvisionsettimer( mincounttime );
    wait mincounttime;
}

// Namespace gamelogic_zm
// Params 2
// Checksum 0x32cecdd6, Offset: 0x9079
// Size: 0x1f4
function teamstarttimer( team, counttime )
{
    level endon( #"match_start_timer_beginning" );
    level.matchcountdowntime = counttime;
    
    if ( !level.gameended )
    {
        if ( isbrgamemode() )
        {
            thread br_public::prematchmusic( team );
            thread br_public::prematchdialog( team );
            
            if ( game_utility::getgametype() != "dmz" )
            {
                thread br_public::applyprematchplotarmor();
            }
        }
        
        while ( counttime > 0 && !level.gameended )
        {
            teamarray = teams::getteamdata( team, "players" );
            
            foreach ( player in teamarray )
            {
                if ( counttime <= 80 )
                {
                    player setclientomnvar( "ui_match_start_countdown", counttime );
                    player setclientomnvar( "ui_match_in_progress", 0 );
                }
            }
            
            counttime--;
            level.matchcountdowntime = counttime;
            wait 1;
        }
        
        level.matchcountdowntime = undefined;
        
        if ( getdvarint( @"hash_5cf9f783b9a4ed7b", 1 ) == 0 )
        {
            teamarray = teams::getteamdata( team, "players" );
            
            foreach ( player in teamarray )
            {
                playerlogic::clearprematchlook( player );
                player player::_freezecontrols( 0, 1 );
                player setclientomnvar( "ui_match_start_countdown", -1 );
                player setclientomnvar( "ui_match_in_progress", 1 );
            }
        }
    }
}

// Namespace gamelogic_zm
// Params 1
// Checksum 0xde84aba0, Offset: 0x9275
// Size: 0x38
function clearvisionsettimer( counttime )
{
    while ( counttime > 0 && !level.gameended )
    {
        counttime--;
        wait 1;
    }
    
    visionsetnaked( "", 0 );
}

// Namespace gamelogic_zm
// Params 0
// Checksum 0xb70ce161, Offset: 0x92b5
// Size: 0xd
function matchstarttimerskip()
{
    visionsetnaked( "", 0 );
}

// Namespace gamelogic_zm
// Params 1
// Checksum 0x9be80577, Offset: 0x92ca
// Size: 0x13f
function onroundswitch( overtime )
{
    if ( !isdefined( game[ "switchedsides" ] ) )
    {
        game[ "switchedsides" ] = 0;
    }
    
    if ( overtime )
    {
        level.halftimetype = "overtime";
        
        if ( game_utility_mp::islastwinbytwo() )
        {
            aheadteam = getbetterteam();
            
            if ( aheadteam != game[ "defenders" ] )
            {
                game[ "switchedsides" ] = !game[ "switchedsides" ];
                level.switchedsides = 1;
            }
            else
            {
                level.switchedsides = undefined;
            }
        }
        else
        {
            game[ "switchedsides" ] = !game[ "switchedsides" ];
            level.switchedsides = 1;
        }
        
        return;
    }
    
    if ( level.skipdefendersadvantage )
    {
        game[ "switchedsides" ] = !game[ "switchedsides" ];
        level.switchedsides = 1;
        return;
    }
    
    if ( shouldgivedefendersadvantage() )
    {
        aheadteam = getbetterteam();
        
        if ( aheadteam != game[ "defenders" ] )
        {
            game[ "switchedsides" ] = !game[ "switchedsides" ];
            level.switchedsides = 1;
        }
        else
        {
            level.switchedsides = undefined;
        }
        
        return;
    }
    
    level.halftimetype = "halftime";
    game[ "switchedsides" ] = !game[ "switchedsides" ];
    level.switchedsides = 1;
}

// Namespace gamelogic_zm
// Params 0
// Checksum 0xae3e1dc8, Offset: 0x9411
// Size: 0x3a, Type: bool
function shouldgivedefendersadvantage()
{
    return game[ "roundsWon" ][ "allies" ] == level.winlimit - 1 && game[ "roundsWon" ][ "axis" ] == level.winlimit - 1;
}

// Namespace gamelogic_zm
// Params 1
// Checksum 0xa63cb6ff, Offset: 0x9454
// Size: 0x73, Type: bool
function checkroundswitch( overtime )
{
    if ( !level.teambased )
    {
        return false;
    }
    
    if ( !level.roundswitch )
    {
        return false;
    }
    
    assert( game[ "<dev string:x6ab>" ] > 0 );
    
    if ( function_b9887a158b0b67ad() )
    {
        if ( function_5a68a06033b800ed() )
        {
            return true;
        }
    }
    else if ( game[ "roundsPlayed" ] % level.roundswitch == 0 || overtime )
    {
        return true;
    }
    
    return false;
}

// Namespace gamelogic_zm
// Params 0
// Checksum 0x804d489b, Offset: 0x94d0
// Size: 0x57
function function_b9887a158b0b67ad()
{
    switch ( level.gametype )
    {
        case #"hash_5ff8e011d5b9d1c8":
            if ( level.roundswitch == 2 && getdvarint( @"scr_arena_loadoutchangeround", 2 ) == 2 )
            {
                return 1;
            }
            
            return 0;
        default:
            return 0;
    }
}

// Namespace gamelogic_zm
// Params 0
// Checksum 0xfb774a69, Offset: 0x952f
// Size: 0x49
function function_5a68a06033b800ed()
{
    switch ( level.gametype )
    {
        case #"hash_5ff8e011d5b9d1c8":
            if ( game[ "roundsPlayed" ] % level.roundswitch == 1 )
            {
                return 1;
            }
            
            return 0;
        default:
            return 0;
    }
}

// Namespace gamelogic_zm
// Params 0
// Checksum 0x4d961ce6, Offset: 0x9580
// Size: 0xcd
function timeuntilroundend()
{
    if ( level.gameended )
    {
        timepassed = ( gettime() - level.gameendtime ) / 1000;
        timeremaining = level.postroundtime - timepassed;
        
        if ( timeremaining < 0 )
        {
            return 0;
        }
        
        return timeremaining;
    }
    
    if ( game_utility_mp::gettimelimit() <= 0 )
    {
        return;
    }
    
    if ( !isdefined( level.starttime ) )
    {
        return;
    }
    
    tl = game_utility_mp::gettimelimit();
    timepassed = ( gettime() - level.starttime ) / 1000;
    timeremaining = level.discardtime / 1000 + game_utility_mp::gettimelimit() - timepassed;
    
    if ( isdefined( level.timepaused ) )
    {
        timeremaining += level.timepaused;
    }
    
    return timeremaining + level.postroundtime;
}

// Namespace gamelogic_zm
// Params 0
// Checksum 0x6576ca9f, Offset: 0x9656
// Size: 0x121
function freegameplayhudelems()
{
    if ( isdefined( self.perkicon ) )
    {
        if ( isdefined( self.perkicon[ 0 ] ) )
        {
            self.perkicon[ 0 ] hud_util::destroyelem();
            self.perkname[ 0 ] hud_util::destroyelem();
        }
        
        if ( isdefined( self.perkicon[ 1 ] ) )
        {
            self.perkicon[ 1 ] hud_util::destroyelem();
            self.perkname[ 1 ] hud_util::destroyelem();
        }
        
        if ( isdefined( self.perkicon[ 2 ] ) )
        {
            self.perkicon[ 2 ] hud_util::destroyelem();
            self.perkname[ 2 ] hud_util::destroyelem();
        }
    }
    
    self notify( #"perks_hidden" );
    
    if ( !level.doeomcombat )
    {
        self.lowermessage hud_util::destroyelem();
        self.lowertimer hud_util::destroyelem();
    }
    
    if ( isdefined( self.proxbar ) )
    {
        self.proxbar hud_util::destroyelem();
    }
    
    if ( isdefined( self.proxbartext ) )
    {
        self.proxbartext hud_util::destroyelem();
    }
}

// Namespace gamelogic_zm
// Params 0
// Checksum 0x2fe9f5dc, Offset: 0x977f
// Size: 0x49
function gethostplayer()
{
    players = getentarray( "player", #classname );
    
    for ( index = 0; index < players.size ; index++ )
    {
        if ( players[ index ] ishost() )
        {
            return players[ index ];
        }
    }
}

// Namespace gamelogic_zm
// Params 0
// Checksum 0xf0714c44, Offset: 0x97d0
// Size: 0x3f, Type: bool
function hostidledout()
{
    hostplayer = gethostplayer();
    
    if ( isdefined( hostplayer ) && !hostplayer.hasspawned && !isdefined( hostplayer.selectedclass ) )
    {
        return true;
    }
    
    return false;
}

// Namespace gamelogic_zm
// Params 2
// Checksum 0x5fca0194, Offset: 0x9818
// Size: 0xf4
function roundendwait( defaultdelay, matchbonus )
{
    if ( !level.doeomcombat )
    {
        wait level.postgamehitmarkerwaittime + 0.1;
        setomnvarforallclients( "post_game_state", 2 );
    }
    
    foreach ( player in level.players )
    {
        player thread game_utility_mp::setuipostgamefade( 0 );
    }
    
    if ( !matchbonus )
    {
        wait defaultdelay;
    }
    else
    {
        wait defaultdelay / 2;
        level notify( #"give_match_bonus" );
        wait defaultdelay / 2;
    }
    
    setomnvarforallclients( "post_game_state", 1 );
    level notify( #"round_end_finished" );
}

// Namespace gamelogic_zm
// Params 1
// Checksum 0xdf21c383, Offset: 0x9914
// Size: 0x13
function roundenddof( time )
{
    player::setdof_spectator();
}

// Namespace gamelogic_zm
// Params 6
// Checksum 0x2cb3c385, Offset: 0x992f
// Size: 0x7f
function setwaypointiconinfo( name, bgtype, teamrelative, string, icon, pulses )
{
    level.waypointcolors[ name ] = teamrelative;
    level.waypointbgtype[ name ] = bgtype;
    level.waypointstring[ name ] = string;
    level.waypointshader[ name ] = icon;
    level.waypointpulses[ name ] = pulses;
}

// Namespace gamelogic_zm
// Params 0
// Checksum 0xf6e4fff2, Offset: 0x99b6
// Size: 0x128a
function initwaypointbackgrounds()
{
    var_e1a478a31edb8885 = 0;
    
    switch ( game_utility::getgametype() )
    {
        case #"hash_ca6516c10db2c95":
        case #"hash_53825b446469ac4c":
        case #"hash_63fb0ba698c46db3":
        case #"hash_8c758b84936e8d42":
        case #"hash_99a69534b169e838":
        case #"hash_f4a9126c03d3385b":
        case #"hash_fa21b5f6bd5e2078":
            setwaypointiconinfo( "icon_waypoint_dom_a", var_e1a478a31edb8885, "neutral", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_a", 0 );
            setwaypointiconinfo( "icon_waypoint_dom_b", var_e1a478a31edb8885, "neutral", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_b", 0 );
            setwaypointiconinfo( "icon_waypoint_dom_c", var_e1a478a31edb8885, "neutral", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_c", 0 );
            setwaypointiconinfo( "icon_waypoint_dom_d", var_e1a478a31edb8885, "neutral", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_d", 0 );
            setwaypointiconinfo( "icon_waypoint_dom_e", var_e1a478a31edb8885, "neutral", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_e", 0 );
            setwaypointiconinfo( "icon_waypoint_dom_f", var_e1a478a31edb8885, "neutral", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_f", 0 );
            setwaypointiconinfo( "icon_waypoint_dom_g", var_e1a478a31edb8885, "neutral", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_g", 0 );
            setwaypointiconinfo( "icon_waypoint_dom_h", var_e1a478a31edb8885, "neutral", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_h", 0 );
            setwaypointiconinfo( "icon_waypoint_dom_i", var_e1a478a31edb8885, "neutral", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_i", 0 );
            setwaypointiconinfo( "waypoint_taking_a", var_e1a478a31edb8885, "friendly", "MP_INGAME_ONLY/OBJ_TAKING_CAPS", "icon_waypoint_dom_a", 1 );
            setwaypointiconinfo( "waypoint_taking_b", var_e1a478a31edb8885, "friendly", "MP_INGAME_ONLY/OBJ_TAKING_CAPS", "icon_waypoint_dom_b", 1 );
            setwaypointiconinfo( "waypoint_taking_c", var_e1a478a31edb8885, "friendly", "MP_INGAME_ONLY/OBJ_TAKING_CAPS", "icon_waypoint_dom_c", 1 );
            setwaypointiconinfo( "waypoint_taking_d", var_e1a478a31edb8885, "friendly", "MP_INGAME_ONLY/OBJ_TAKING_CAPS", "icon_waypoint_dom_d", 1 );
            setwaypointiconinfo( "waypoint_taking_e", var_e1a478a31edb8885, "friendly", "MP_INGAME_ONLY/OBJ_TAKING_CAPS", "icon_waypoint_dom_e", 1 );
            setwaypointiconinfo( "waypoint_taking_f", var_e1a478a31edb8885, "friendly", "MP_INGAME_ONLY/OBJ_TAKING_CAPS", "icon_waypoint_dom_f", 1 );
            setwaypointiconinfo( "waypoint_taking_g", var_e1a478a31edb8885, "friendly", "MP_INGAME_ONLY/OBJ_TAKING_CAPS", "icon_waypoint_dom_g", 1 );
            setwaypointiconinfo( "waypoint_taking_h", var_e1a478a31edb8885, "friendly", "MP_INGAME_ONLY/OBJ_TAKING_CAPS", "icon_waypoint_dom_h", 1 );
            setwaypointiconinfo( "waypoint_taking_i", var_e1a478a31edb8885, "friendly", "MP_INGAME_ONLY/OBJ_TAKING_CAPS", "icon_waypoint_dom_i", 1 );
            setwaypointiconinfo( "waypoint_capture_a", var_e1a478a31edb8885, "enemy", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_a", 0 );
            setwaypointiconinfo( "waypoint_capture_b", var_e1a478a31edb8885, "enemy", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_b", 0 );
            setwaypointiconinfo( "waypoint_capture_c", var_e1a478a31edb8885, "enemy", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_c", 0 );
            setwaypointiconinfo( "waypoint_capture_d", var_e1a478a31edb8885, "enemy", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_d", 0 );
            setwaypointiconinfo( "waypoint_capture_e", var_e1a478a31edb8885, "enemy", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_e", 0 );
            setwaypointiconinfo( "waypoint_capture_f", var_e1a478a31edb8885, "enemy", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_f", 0 );
            setwaypointiconinfo( "waypoint_capture_g", var_e1a478a31edb8885, "enemy", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_g", 0 );
            setwaypointiconinfo( "waypoint_capture_h", var_e1a478a31edb8885, "enemy", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_h", 0 );
            setwaypointiconinfo( "waypoint_capture_i", var_e1a478a31edb8885, "enemy", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_i", 0 );
            setwaypointiconinfo( "waypoint_defend_a", var_e1a478a31edb8885, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_dom_a", 0 );
            setwaypointiconinfo( "waypoint_defend_b", var_e1a478a31edb8885, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_dom_b", 0 );
            setwaypointiconinfo( "waypoint_defend_c", var_e1a478a31edb8885, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_dom_c", 0 );
            setwaypointiconinfo( "waypoint_defend_d", var_e1a478a31edb8885, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_dom_d", 0 );
            setwaypointiconinfo( "waypoint_defend_e", var_e1a478a31edb8885, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_dom_e", 0 );
            setwaypointiconinfo( "waypoint_defend_f", var_e1a478a31edb8885, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_dom_f", 0 );
            setwaypointiconinfo( "waypoint_defend_g", var_e1a478a31edb8885, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_dom_g", 0 );
            setwaypointiconinfo( "waypoint_defend_h", var_e1a478a31edb8885, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_dom_h", 0 );
            setwaypointiconinfo( "waypoint_defend_i", var_e1a478a31edb8885, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_dom_i", 0 );
            setwaypointiconinfo( "waypoint_defending_a", var_e1a478a31edb8885, "friendly", "MP_INGAME_ONLY/OBJ_DEFENDING_CAPS", "icon_waypoint_dom_a", 0 );
            setwaypointiconinfo( "waypoint_defending_b", var_e1a478a31edb8885, "friendly", "MP_INGAME_ONLY/OBJ_DEFENDING_CAPS", "icon_waypoint_dom_b", 0 );
            setwaypointiconinfo( "waypoint_defending_c", var_e1a478a31edb8885, "friendly", "MP_INGAME_ONLY/OBJ_DEFENDING_CAPS", "icon_waypoint_dom_c", 0 );
            setwaypointiconinfo( "waypoint_defending_d", var_e1a478a31edb8885, "friendly", "MP_INGAME_ONLY/OBJ_DEFENDING_CAPS", "icon_waypoint_dom_d", 0 );
            setwaypointiconinfo( "waypoint_defending_e", var_e1a478a31edb8885, "friendly", "MP_INGAME_ONLY/OBJ_DEFENDING_CAPS", "icon_waypoint_dom_e", 0 );
            setwaypointiconinfo( "waypoint_defending_f", var_e1a478a31edb8885, "friendly", "MP_INGAME_ONLY/OBJ_DEFENDING_CAPS", "icon_waypoint_dom_f", 0 );
            setwaypointiconinfo( "waypoint_defending_g", var_e1a478a31edb8885, "friendly", "MP_INGAME_ONLY/OBJ_DEFENDING_CAPS", "icon_waypoint_dom_g", 0 );
            setwaypointiconinfo( "waypoint_defending_h", var_e1a478a31edb8885, "friendly", "MP_INGAME_ONLY/OBJ_DEFENDING_CAPS", "icon_waypoint_dom_h", 0 );
            setwaypointiconinfo( "waypoint_defending_i", var_e1a478a31edb8885, "friendly", "MP_INGAME_ONLY/OBJ_DEFENDING_CAPS", "icon_waypoint_dom_i", 0 );
            setwaypointiconinfo( "waypoint_blocking_a", var_e1a478a31edb8885, "friendly", "MP_INGAME_ONLY/OBJ_BLOCKING_CAPS", "icon_waypoint_dom_a", 1 );
            setwaypointiconinfo( "waypoint_blocking_b", var_e1a478a31edb8885, "friendly", "MP_INGAME_ONLY/OBJ_BLOCKING_CAPS", "icon_waypoint_dom_b", 1 );
            setwaypointiconinfo( "waypoint_blocking_c", var_e1a478a31edb8885, "friendly", "MP_INGAME_ONLY/OBJ_BLOCKING_CAPS", "icon_waypoint_dom_c", 1 );
            setwaypointiconinfo( "waypoint_blocking_d", var_e1a478a31edb8885, "friendly", "MP_INGAME_ONLY/OBJ_BLOCKING_CAPS", "icon_waypoint_dom_d", 1 );
            setwaypointiconinfo( "waypoint_blocking_e", var_e1a478a31edb8885, "friendly", "MP_INGAME_ONLY/OBJ_BLOCKING_CAPS", "icon_waypoint_dom_e", 1 );
            setwaypointiconinfo( "waypoint_blocking_f", var_e1a478a31edb8885, "friendly", "MP_INGAME_ONLY/OBJ_BLOCKING_CAPS", "icon_waypoint_dom_f", 1 );
            setwaypointiconinfo( "waypoint_blocking_g", var_e1a478a31edb8885, "friendly", "MP_INGAME_ONLY/OBJ_BLOCKING_CAPS", "icon_waypoint_dom_g", 1 );
            setwaypointiconinfo( "waypoint_blocking_h", var_e1a478a31edb8885, "friendly", "MP_INGAME_ONLY/OBJ_BLOCKING_CAPS", "icon_waypoint_dom_h", 1 );
            setwaypointiconinfo( "waypoint_blocking_i", var_e1a478a31edb8885, "friendly", "MP_INGAME_ONLY/OBJ_BLOCKING_CAPS", "icon_waypoint_dom_i", 1 );
            setwaypointiconinfo( "waypoint_blocked_a", var_e1a478a31edb8885, "friendly", "MP_INGAME_ONLY/OBJ_BLOCKED_CAPS", "icon_waypoint_dom_a", 1 );
            setwaypointiconinfo( "waypoint_blocked_b", var_e1a478a31edb8885, "friendly", "MP_INGAME_ONLY/OBJ_BLOCKED_CAPS", "icon_waypoint_dom_b", 1 );
            setwaypointiconinfo( "waypoint_blocked_c", var_e1a478a31edb8885, "friendly", "MP_INGAME_ONLY/OBJ_BLOCKED_CAPS", "icon_waypoint_dom_c", 1 );
            setwaypointiconinfo( "waypoint_blocked_d", var_e1a478a31edb8885, "friendly", "MP_INGAME_ONLY/OBJ_BLOCKED_CAPS", "icon_waypoint_dom_d", 1 );
            setwaypointiconinfo( "waypoint_blocked_e", var_e1a478a31edb8885, "friendly", "MP_INGAME_ONLY/OBJ_BLOCKED_CAPS", "icon_waypoint_dom_e", 1 );
            setwaypointiconinfo( "waypoint_blocked_f", var_e1a478a31edb8885, "friendly", "MP_INGAME_ONLY/OBJ_BLOCKED_CAPS", "icon_waypoint_dom_f", 1 );
            setwaypointiconinfo( "waypoint_blocked_g", var_e1a478a31edb8885, "friendly", "MP_INGAME_ONLY/OBJ_BLOCKED_CAPS", "icon_waypoint_dom_g", 1 );
            setwaypointiconinfo( "waypoint_blocked_h", var_e1a478a31edb8885, "friendly", "MP_INGAME_ONLY/OBJ_BLOCKED_CAPS", "icon_waypoint_dom_h", 1 );
            setwaypointiconinfo( "waypoint_blocked_i", var_e1a478a31edb8885, "friendly", "MP_INGAME_ONLY/OBJ_BLOCKED_CAPS", "icon_waypoint_dom_i", 1 );
            setwaypointiconinfo( "waypoint_losing_a", var_e1a478a31edb8885, "enemy", "MP_INGAME_ONLY/OBJ_LOSING_CAPS", "icon_waypoint_dom_a", 1 );
            setwaypointiconinfo( "waypoint_losing_b", var_e1a478a31edb8885, "enemy", "MP_INGAME_ONLY/OBJ_LOSING_CAPS", "icon_waypoint_dom_b", 1 );
            setwaypointiconinfo( "waypoint_losing_c", var_e1a478a31edb8885, "enemy", "MP_INGAME_ONLY/OBJ_LOSING_CAPS", "icon_waypoint_dom_c", 1 );
            setwaypointiconinfo( "waypoint_losing_d", var_e1a478a31edb8885, "enemy", "MP_INGAME_ONLY/OBJ_LOSING_CAPS", "icon_waypoint_dom_d", 1 );
            setwaypointiconinfo( "waypoint_losing_e", var_e1a478a31edb8885, "enemy", "MP_INGAME_ONLY/OBJ_LOSING_CAPS", "icon_waypoint_dom_e", 1 );
            setwaypointiconinfo( "waypoint_losing_f", var_e1a478a31edb8885, "enemy", "MP_INGAME_ONLY/OBJ_LOSING_CAPS", "icon_waypoint_dom_f", 1 );
            setwaypointiconinfo( "waypoint_losing_g", var_e1a478a31edb8885, "enemy", "MP_INGAME_ONLY/OBJ_LOSING_CAPS", "icon_waypoint_dom_g", 1 );
            setwaypointiconinfo( "waypoint_losing_h", var_e1a478a31edb8885, "enemy", "MP_INGAME_ONLY/OBJ_LOSING_CAPS", "icon_waypoint_dom_h", 1 );
            setwaypointiconinfo( "waypoint_losing_i", var_e1a478a31edb8885, "enemy", "MP_INGAME_ONLY/OBJ_LOSING_CAPS", "icon_waypoint_dom_i", 1 );
            setwaypointiconinfo( "waypoint_captureneutral_a", var_e1a478a31edb8885, "neutral", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_a", 0 );
            setwaypointiconinfo( "waypoint_captureneutral_b", var_e1a478a31edb8885, "neutral", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_b", 0 );
            setwaypointiconinfo( "waypoint_captureneutral_c", var_e1a478a31edb8885, "neutral", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_c", 0 );
            setwaypointiconinfo( "waypoint_captureneutral_d", var_e1a478a31edb8885, "neutral", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_d", 0 );
            setwaypointiconinfo( "waypoint_captureneutral_e", var_e1a478a31edb8885, "neutral", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_e", 0 );
            setwaypointiconinfo( "waypoint_captureneutral_f", var_e1a478a31edb8885, "neutral", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_f", 0 );
            setwaypointiconinfo( "waypoint_captureneutral_g", var_e1a478a31edb8885, "neutral", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_g", 0 );
            setwaypointiconinfo( "waypoint_captureneutral_h", var_e1a478a31edb8885, "neutral", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_h", 0 );
            setwaypointiconinfo( "waypoint_captureneutral_i", var_e1a478a31edb8885, "neutral", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_i", 0 );
            setwaypointiconinfo( "waypoint_contested_a", var_e1a478a31edb8885, "contest", "MP_INGAME_ONLY/OBJ_CONTESTED_CAPS", "icon_waypoint_dom_a", 1 );
            setwaypointiconinfo( "waypoint_contested_b", var_e1a478a31edb8885, "contest", "MP_INGAME_ONLY/OBJ_CONTESTED_CAPS", "icon_waypoint_dom_b", 1 );
            setwaypointiconinfo( "waypoint_contested_c", var_e1a478a31edb8885, "contest", "MP_INGAME_ONLY/OBJ_CONTESTED_CAPS", "icon_waypoint_dom_c", 1 );
            setwaypointiconinfo( "waypoint_contested_d", var_e1a478a31edb8885, "contest", "MP_INGAME_ONLY/OBJ_CONTESTED_CAPS", "icon_waypoint_dom_d", 1 );
            setwaypointiconinfo( "waypoint_contested_e", var_e1a478a31edb8885, "contest", "MP_INGAME_ONLY/OBJ_CONTESTED_CAPS", "icon_waypoint_dom_e", 1 );
            setwaypointiconinfo( "waypoint_contested_f", var_e1a478a31edb8885, "contest", "MP_INGAME_ONLY/OBJ_CONTESTED_CAPS", "icon_waypoint_dom_f", 1 );
            setwaypointiconinfo( "waypoint_contested_g", var_e1a478a31edb8885, "contest", "MP_INGAME_ONLY/OBJ_CONTESTED_CAPS", "icon_waypoint_dom_g", 1 );
            setwaypointiconinfo( "waypoint_contested_h", var_e1a478a31edb8885, "contest", "MP_INGAME_ONLY/OBJ_CONTESTED_CAPS", "icon_waypoint_dom_h", 1 );
            setwaypointiconinfo( "waypoint_contested_i", var_e1a478a31edb8885, "contest", "MP_INGAME_ONLY/OBJ_CONTESTED_CAPS", "icon_waypoint_dom_i", 1 );
            setwaypointiconinfo( "waypoint_dom_target_a", var_e1a478a31edb8885, "neutral", "MP_INGAME_ONLY/OBJ_TARGET_CAPS", "icon_waypoint_dom_a", 0 );
            setwaypointiconinfo( "waypoint_dom_target_b", var_e1a478a31edb8885, "neutral", "MP_INGAME_ONLY/OBJ_TARGET_CAPS", "icon_waypoint_dom_b", 0 );
            setwaypointiconinfo( "waypoint_dom_target_c", var_e1a478a31edb8885, "neutral", "MP_INGAME_ONLY/OBJ_TARGET_CAPS", "icon_waypoint_dom_c", 0 );
            setwaypointiconinfo( "waypoint_dom_target_d", var_e1a478a31edb8885, "neutral", "MP_INGAME_ONLY/OBJ_TARGET_CAPS", "icon_waypoint_dom_d", 0 );
            setwaypointiconinfo( "waypoint_dom_target_e", var_e1a478a31edb8885, "neutral", "MP_INGAME_ONLY/OBJ_TARGET_CAPS", "icon_waypoint_dom_e", 0 );
            setwaypointiconinfo( "waypoint_dom_target_f", var_e1a478a31edb8885, "neutral", "MP_INGAME_ONLY/OBJ_TARGET_CAPS", "icon_waypoint_dom_f", 0 );
            setwaypointiconinfo( "waypoint_dom_target_g", var_e1a478a31edb8885, "neutral", "MP_INGAME_ONLY/OBJ_TARGET_CAPS", "icon_waypoint_dom_g", 0 );
            setwaypointiconinfo( "waypoint_dom_target_h", var_e1a478a31edb8885, "neutral", "MP_INGAME_ONLY/OBJ_TARGET_CAPS", "icon_waypoint_dom_h", 0 );
            setwaypointiconinfo( "waypoint_dom_target_i", var_e1a478a31edb8885, "neutral", "MP_INGAME_ONLY/OBJ_TARGET_CAPS", "icon_waypoint_dom_i", 0 );
            setwaypointiconinfo( "waypoint_clearing_a", var_e1a478a31edb8885, "friendly", "MP_INGAME_ONLY/OBJ_CLEARING_CAPS", "icon_waypoint_dom_a", 1 );
            setwaypointiconinfo( "waypoint_clearing_b", var_e1a478a31edb8885, "friendly", "MP_INGAME_ONLY/OBJ_CLEARING_CAPS", "icon_waypoint_dom_b", 1 );
            setwaypointiconinfo( "waypoint_clearing_c", var_e1a478a31edb8885, "friendly", "MP_INGAME_ONLY/OBJ_CLEARING_CAPS", "icon_waypoint_dom_c", 1 );
            setwaypointiconinfo( "waypoint_clearing_d", var_e1a478a31edb8885, "friendly", "MP_INGAME_ONLY/OBJ_CLEARING_CAPS", "icon_waypoint_dom_d", 1 );
            setwaypointiconinfo( "waypoint_clearing_e", var_e1a478a31edb8885, "friendly", "MP_INGAME_ONLY/OBJ_CLEARING_CAPS", "icon_waypoint_dom_e", 1 );
            setwaypointiconinfo( "waypoint_clearing_f", var_e1a478a31edb8885, "friendly", "MP_INGAME_ONLY/OBJ_CLEARING_CAPS", "icon_waypoint_dom_f", 1 );
            setwaypointiconinfo( "waypoint_clearing_g", var_e1a478a31edb8885, "friendly", "MP_INGAME_ONLY/OBJ_CLEARING_CAPS", "icon_waypoint_dom_g", 1 );
            setwaypointiconinfo( "waypoint_clearing_h", var_e1a478a31edb8885, "friendly", "MP_INGAME_ONLY/OBJ_CLEARING_CAPS", "icon_waypoint_dom_h", 1 );
            setwaypointiconinfo( "waypoint_clearing_i", var_e1a478a31edb8885, "friendly", "MP_INGAME_ONLY/OBJ_CLEARING_CAPS", "icon_waypoint_dom_i", 1 );
            setwaypointiconinfo( "waypoint_reinforcing_a", var_e1a478a31edb8885, "friendly", "MP_INGAME_ONLY/OBJ_REINFORCING_CAPS", "icon_waypoint_dom_a", 1 );
            setwaypointiconinfo( "waypoint_reinforcing_b", var_e1a478a31edb8885, "friendly", "MP_INGAME_ONLY/OBJ_REINFORCING_CAPS", "icon_waypoint_dom_b", 1 );
            setwaypointiconinfo( "waypoint_reinforcing_c", var_e1a478a31edb8885, "friendly", "MP_INGAME_ONLY/OBJ_REINFORCING_CAPS", "icon_waypoint_dom_c", 1 );
            setwaypointiconinfo( "waypoint_reinforcing_d", var_e1a478a31edb8885, "friendly", "MP_INGAME_ONLY/OBJ_REINFORCING_CAPS", "icon_waypoint_dom_d", 1 );
            setwaypointiconinfo( "waypoint_reinforcing_e", var_e1a478a31edb8885, "friendly", "MP_INGAME_ONLY/OBJ_REINFORCING_CAPS", "icon_waypoint_dom_e", 1 );
            setwaypointiconinfo( "waypoint_reinforcing_f", var_e1a478a31edb8885, "friendly", "MP_INGAME_ONLY/OBJ_REINFORCING_CAPS", "icon_waypoint_dom_f", 1 );
            setwaypointiconinfo( "waypoint_reinforcing_g", var_e1a478a31edb8885, "friendly", "MP_INGAME_ONLY/OBJ_REINFORCING_CAPS", "icon_waypoint_dom_g", 1 );
            setwaypointiconinfo( "waypoint_reinforcing_h", var_e1a478a31edb8885, "friendly", "MP_INGAME_ONLY/OBJ_REINFORCING_CAPS", "icon_waypoint_dom_h", 1 );
            setwaypointiconinfo( "waypoint_reinforcing_i", var_e1a478a31edb8885, "friendly", "MP_INGAME_ONLY/OBJ_REINFORCING_CAPS", "icon_waypoint_dom_i", 1 );
            break;
        case #"hash_fa0ed2f6bd4f4395":
        case #"hash_fa50b0f6bd82e972":
            setwaypointiconinfo( "waypoint_bomb", 2, "neutral", "MP_INGAME_ONLY/OBJ_BOMB_CAPS", "icon_waypoint_bomb", 1 );
            setwaypointiconinfo( "icon_waypoint_escort_bomb", 1, "neutral", "MP_INGAME_ONLY/OBJ_ESCORT_CAPS", "icon_waypoint_bomb", 0 );
            setwaypointiconinfo( "waypoint_target_a", 0, "enemy", "MP_INGAME_ONLY/OBJ_TARGET_CAPS", "icon_waypoint_dom_a", 0 );
            setwaypointiconinfo( "waypoint_target_b", 0, "enemy", "MP_INGAME_ONLY/OBJ_TARGET_CAPS", "icon_waypoint_dom_b", 0 );
            setwaypointiconinfo( "waypoint_bomb_defusing_a", 0, "enemy", "MP_INGAME_ONLY/OBJ_DEFUSING_CAPS", "icon_waypoint_dom_a", 0 );
            setwaypointiconinfo( "waypoint_bomb_defusing_b", 0, "enemy", "MP_INGAME_ONLY/OBJ_DEFUSING_CAPS", "icon_waypoint_dom_b", 0 );
            setwaypointiconinfo( "waypoint_bomb_planting_a", 0, "enemy", "MP_INGAME_ONLY/OBJ_PLANTING_CAPS", "icon_waypoint_dom_a", 0 );
            setwaypointiconinfo( "waypoint_bomb_planting_b", 0, "enemy", "MP_INGAME_ONLY/OBJ_PLANTING_CAPS", "icon_waypoint_dom_b", 0 );
            setwaypointiconinfo( "waypoint_defuse_a", 0, "enemy", "MP_INGAME_ONLY/OBJ_DEFUSE_CAPS", "icon_waypoint_bomb", 0 );
            setwaypointiconinfo( "waypoint_defuse_b", 0, "enemy", "MP_INGAME_ONLY/OBJ_DEFUSE_CAPS", "icon_waypoint_bomb", 0 );
            setwaypointiconinfo( "waypoint_bomb_defend_a", 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_bomb", 0 );
            setwaypointiconinfo( "waypoint_bomb_defend_b", 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_bomb", 0 );
            setwaypointiconinfo( "waypoint_defend_a", 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_dom_a", 0 );
            setwaypointiconinfo( "waypoint_defend_b", 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_dom_b", 0 );
            setwaypointiconinfo( "waypoint_defend_c", 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_dom_c", 0 );
            setwaypointiconinfo( "waypoint_defend_d", 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_dom_d", 0 );
            setwaypointiconinfo( "waypoint_defend_e", 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_dom_e", 0 );
            setwaypointiconinfo( "waypoint_defuse_nt_a", 0, "enemy", "", "icon_waypoint_bomb", 0 );
            setwaypointiconinfo( "waypoint_defuse_nt_b", 0, "enemy", "", "icon_waypoint_bomb", 0 );
            setwaypointiconinfo( "waypoint_bomb_defend_nt_a", 0, "friendly", "", "icon_waypoint_bomb", 0 );
            setwaypointiconinfo( "waypoint_bomb_defend_nt_b", 0, "friendly", "", "icon_waypoint_bomb", 0 );
            break;
        case #"hash_214e6c6c1b43ae4a":
        case #"hash_fa34c5f6bd6d4432":
            setwaypointiconinfo( "hq_destroy", 0, "enemy", "MP_INGAME_ONLY/OBJ_DESTROY_CAPS", "icon_waypoint_hq", 0 );
            setwaypointiconinfo( "hq_defend", 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_hq", 0 );
            setwaypointiconinfo( "hq_defending", 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFENDING_CAPS", "icon_waypoint_hq", 0 );
            setwaypointiconinfo( "hq_neutral", 0, "neutral", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_hq", 0 );
            setwaypointiconinfo( "hq_contested", 0, "contest", "MP_INGAME_ONLY/OBJ_CONTESTED_CAPS", "icon_waypoint_hq", 0 );
            setwaypointiconinfo( "hq_losing", 0, "enemy", "MP_INGAME_ONLY/OBJ_LOSING_CAPS", "icon_waypoint_hq", 0 );
            setwaypointiconinfo( "hq_target", 0, "neutral", "MP_INGAME_ONLY/OBJ_TARGET_CAPS", "icon_waypoint_locked", 0 );
            setwaypointiconinfo( "hq_taking", 0, "friendly", "MP_INGAME_ONLY/OBJ_DESTROYING_CAPS", "icon_waypoint_hq", 0 );
        default:
            break;
    }
    
    setwaypointiconinfo( "waypoint_dogtags", 1, "enemy", "", "hud_icon_minimap_misc_dog_tag", 0 );
    setwaypointiconinfo( "waypoint_dogtags_friendly", 1, "friendly", "", "hud_icon_minimap_misc_dog_tag", 0 );
    setwaypointiconinfo( "icon_waypoint_locked", 0, "neutral", "MP_INGAME_ONLY/OBJ_LOCKED_CAPS", "icon_waypoint_locked", 0 );
    setwaypointiconinfo( "waypoint_capture_kill", 0, "enemy", "MP_INGAME_ONLY/OBJ_KILL_CAPS", "icon_waypoint_kill", 0 );
    setwaypointiconinfo( "waypoint_escort", 0, "friendly", "MP_INGAME_ONLY/OBJ_ESCORT_CAPS", "icon_waypoint_escort", 0 );
}

// Namespace gamelogic_zm
// Params 1
// Checksum 0x9bbf61a9, Offset: 0xac48
// Size: 0x420
function function_ace7db126cc8ad37( clientnumvalue )
{
    println( "<dev string:x6b8>" );
    
    if ( isdefined( clientnumvalue ) )
    {
        foreach ( player in level.players )
        {
            if ( !isdefined( player ) )
            {
                continue;
            }
            
            playerclientnum = player getentitynumber();
            selectedplayer = player;
            
            if ( playerclientnum == clientnumvalue )
            {
                println( "<dev string:x6f6>" + clientnumvalue + "<dev string:x729>" + playerclientnum + "<dev string:x746>" + player.name );
                playerarray = teams::getteamdata( player.team, "players" );
                
                if ( player issplitscreenplayer() && !player issplitscreenplayerprimary() )
                {
                    selectedplayer = player getothersplitscreenplayer();
                }
                
                if ( isdefined( selectedplayer.var_acecf5cb67174177 ) )
                {
                    selectedplayer.var_acecf5cb67174177 = !selectedplayer.var_acecf5cb67174177;
                }
                else
                {
                    selectedplayer.var_acecf5cb67174177 = 1;
                }
                
                hostxuid = teams::getteamdata( player.team, "playagainHostXuid" );
                playerxuid = selectedplayer getxuid();
                
                if ( selectedplayer.var_acecf5cb67174177 )
                {
                    if ( hostxuid == "0" )
                    {
                        println( "<dev string:x75d>" + clientnumvalue + "<dev string:x746>" + player.name + "<dev string:x789>" + playerxuid );
                        teams::setteamdata( player.team, "playagainHostXuid", playerxuid );
                    }
                }
                else if ( hostxuid == playerxuid )
                {
                    println( "<dev string:x75d>" + clientnumvalue + "<dev string:x746>" + player.name + "<dev string:x7b7>" );
                    var_5bd2874599492120 = "0";
                    
                    foreach ( teammate in playerarray )
                    {
                        if ( isdefined( teammate ) && !isbot( teammate ) && teammate issplitscreenplayerprimary() )
                        {
                            var_5bd2874599492120 = teammate getxuid();
                            break;
                        }
                    }
                    
                    teams::setteamdata( player.team, "playagainHostXuid", var_5bd2874599492120 );
                }
                
                if ( game_utility_mp::matchmakinggame() )
                {
                    if ( isdefined( player ) && player isfireteamleader() )
                    {
                        var_3e817a98a127314a = player getfireteammembers();
                        
                        foreach ( member in var_3e817a98a127314a )
                        {
                            if ( !isdefined( member ) )
                            {
                                continue;
                            }
                            
                            memberclientnum = member getentitynumber();
                            
                            if ( memberclientnum != playerclientnum )
                            {
                                if ( isdefined( member.var_acecf5cb67174177 ) )
                                {
                                    member.var_acecf5cb67174177 = !member.var_acecf5cb67174177;
                                }
                                else
                                {
                                    member.var_acecf5cb67174177 = 1;
                                }
                                
                                foreach ( teammate in playerarray )
                                {
                                    if ( isdefined( teammate ) )
                                    {
                                    }
                                }
                            }
                        }
                    }
                }
                
                break;
            }
        }
    }
}

// Namespace gamelogic_zm
// Params 0
// Checksum 0x781112c7, Offset: 0xb071
// Size: 0x25f
function function_38ce20e801f80a51()
{
    println( "<dev string:x7fb>" );
    hostidx = 0;
    
    if ( !game_utility_mp::privatematch() && !br_public::isbrpracticemode() )
    {
        var_31ecc5b1a09db555 = [];
        
        foreach ( player in level.players )
        {
            if ( !isdefined( player ) )
            {
                continue;
            }
            
            if ( isdefined( player.var_acecf5cb67174177 ) && player.var_acecf5cb67174177 )
            {
                playerteam = player.team;
                playerteamchecked = 0;
                var_51240cbf02b1fd29 = var_31ecc5b1a09db555.size;
                
                for ( index = 0; index < var_51240cbf02b1fd29 ; index++ )
                {
                    if ( var_31ecc5b1a09db555[ index ] == playerteam )
                    {
                        playerteamchecked = 1;
                    }
                }
                
                if ( !playerteamchecked )
                {
                    var_31ecc5b1a09db555[ var_51240cbf02b1fd29 ] = playerteam;
                    teamarray = teams::getteamdata( playerteam, "players" );
                    var_ab0ad112547e58de = [];
                    playagainhostxuid = teams::getteamdata( playerteam, "playagainHostXuid" );
                    
                    foreach ( player in teamarray )
                    {
                        if ( !isdefined( player ) )
                        {
                            continue;
                        }
                        
                        println( "<dev string:x823>" + player.name + "<dev string:x848>" + player.team );
                        
                        if ( isdefined( player.var_acecf5cb67174177 ) && player.var_acecf5cb67174177 )
                        {
                            println( "<dev string:x85d>" + player.name + "<dev string:x848>" + player.team + "<dev string:x895>" + playagainhostxuid );
                            var_ab0ad112547e58de[ var_ab0ad112547e58de.size ] = player;
                        }
                    }
                    
                    playagain( var_ab0ad112547e58de );
                    waitframe();
                }
            }
        }
    }
}

// Namespace gamelogic_zm
// Params 0
// Checksum 0xe548a43d, Offset: 0xb2d8
// Size: 0x1bb7
function callback_startgametype()
{
    load::main();
    
    if ( !isdefined( game[ "roundsPlayed" ] ) )
    {
        if ( analyticsstreamerislogfilestreamingenabled() )
        {
            analyticsstreamerlogfilestartstream();
        }
        
        game[ "matchHasMoreThan1Player" ] = 0;
        game[ "numPlayersConsideredPlaying" ] = 0;
    }
    
    flags::gameflaginit( "prematch_done", 0 );
    flags::gameflaginit( "prematch_fade_done", 0 );
    flags::gameflaginit( "prematch_countdown", 0 );
    flags::gameflaginit( "graceperiod_done", 0 );
    flags::gameflaginit( "loadout_selected", 0 );
    flags::gameflaginit( "infil_setup_complete", 0 );
    flags::gameflaginit( "infil_will_run", 0 );
    flags::gameflaginit( "infil_started", 0 );
    flags::gameflaginit( "overtime_started", 0 );
    flags::gameflaginit( "loadout_setup_complete", 0 );
    flags::gameflaginit( "loadout_will_run", 0 );
    flags::gameflaginit( "loadout_started", 0 );
    flags::levelflaginit( "round_over", 0 );
    flags::levelflaginit( "game_over", 0 );
    flags::levelflaginit( "block_notifies", 0 );
    flags::levelflaginit( "post_game_level_event_active", 0 );
    flags::levelflaginit( "final_killcam_preloaded", 0 );
    level.prematchperiod = 0;
    level.prematchperiodend = 0;
    level.postgamenotifies = 0;
    level.intermission = 0;
    setdvar( @"bg_bulletsusemaxdamageminrange", istrue( level.noweaponfalloff ) );
    setdvar( @"bg_piggybackarmoronnvg", istrue( level.armoronweaponswitchlongpress ) );
    
    if ( game_utility_mp::matchmakinggame() )
    {
        setdvar( @"ismatchmakinggame", 1 );
    }
    else
    {
        setdvar( @"ismatchmakinggame", 0 );
    }
    
    level thread initwaypointbackgrounds();
    
    if ( !isdefined( game[ "gamestarted" ] ) )
    {
        game[ "clientid" ] = 0;
        game[ "truncated_killcams" ] = 0;
        game[ "life_count" ] = 0;
        
        if ( !( isdefined( game[ "attackers" ] ) && isdefined( game[ "defenders" ] ) ) )
        {
            thread utility::error( "No attackers or defenders team defined in level .gsc." );
        }
        
        if ( !isdefined( game[ "attackers" ] ) )
        {
            game[ "attackers" ] = "allies";
        }
        
        if ( !isdefined( game[ "defenders" ] ) )
        {
            game[ "defenders" ] = "axis";
        }
        
        if ( !isdefined( game[ "state" ] ) )
        {
            game[ "state" ] = "playing";
        }
        
        game[ "strings" ][ "press_to_spawn" ] = &"mp/press_to_spawn";
        game[ "strings" ][ "spawn_next_round" ] = &"mp/spawn_next_round";
        game[ "strings" ][ "spawn_flag_wait" ] = &"mp/spawn_flag_wait";
        game[ "strings" ][ "spawn_point_capture_wait" ] = &"mp/spawn_point_capture_wait";
        game[ "strings" ][ "spawn_revive_wait" ] = &"mp/spawn_revive_wait";
        game[ "strings" ][ "spawn_revive_wait_bleedout" ] = &"mp/spawn_revive_wait_bleedout";
        game[ "strings" ][ "spawn_revive_remote" ] = &"mp/spawn_revive_remote";
        game[ "strings" ][ "spawn_tag_wait" ] = &"mp/spawn_tag_wait";
        game[ "strings" ][ "waiting_to_spawn" ] = &"mp/waiting_to_spawn";
        game[ "strings" ][ "next_team_spawn" ] = &"mp/next_team_spawn";
        game[ "strings" ][ "match_starting" ] = &"mp/match_starting";
        game[ "strings" ][ "change_class" ] = &"mp/change_class_next_spawn";
        game[ "strings" ][ "revive_class" ] = &"mp/change_class_next_round";
        game[ "strings" ][ "change_rig" ] = &"lua_menu_mp/change_rig_next_spawn";
        game[ "strings" ][ "must_select_loadout_to_spawn" ] = &"mp_ingame_only/select_loadout_to_spawn";
        game[ "strings" ][ "select_spawn" ] = &"mp/select_spawn";
        game[ "strings" ][ "down_give_up" ] = &"mp/down_give_up";
        level lower_message::function_78d25b1b58140bc9();
        game[ "colors" ][ "black" ] = ( 0, 0, 0 );
        game[ "colors" ][ "white" ] = ( 1, 1, 1 );
        game[ "colors" ][ "grey" ] = ( 0.5, 0.5, 0.5 );
        game[ "colors" ][ "cyan" ] = ( 0.35, 0.7, 0.9 );
        game[ "colors" ][ "orange" ] = ( 0.9, 0.6, 0 );
        game[ "colors" ][ "blue" ] = ( 0.2, 0.3, 0.7 );
        game[ "colors" ][ "red" ] = ( 0.75, 0.25, 0.25 );
        game[ "colors" ][ "green" ] = ( 0.25, 0.75, 0.25 );
        game[ "colors" ][ "yellow" ] = ( 0.65, 0.65, 0 );
        game[ "colors" ][ "friendly" ] = ( 0.258824, 0.639216, 0.87451 );
        game[ "colors" ][ "enemy" ] = ( 0.929412, 0.231373, 0.141176 );
        game[ "colors" ][ "contest" ] = ( 1, 0.858824, 0 );
        game[ "colors" ][ "neutral" ] = ( 1, 1, 1 );
        [[ level.onprecachegametype ]]();
        setdvarifuninitialized( @"min_wait_for_players", 5 );
        
        if ( !level.splitscreen )
        {
            level.prematchperiod = getmatchrulesdata( "commonOption", "gracePeriod" );
            level.prematchperiodend = getmatchrulesdata( "commonOption", "matchStartTime" );
        }
        
        if ( function_697873d10bd047e4() )
        {
            setnojipscore( 1, 1 );
            setnojiptime( 1, 1 );
        }
        else
        {
            setnojipscore( 0, 1 );
            setnojiptime( 0, 1 );
        }
    }
    else
    {
        setdvarifuninitialized( @"min_wait_for_players", 5 );
        
        if ( !level.splitscreen )
        {
            level.prematchperiodend = getmatchrulesdata( "commonOption", "roundStartTime" );
        }
    }
    
    if ( !isdefined( game[ "allies" ] ) )
    {
        game[ "allies" ] = "SAS";
    }
    
    if ( !isdefined( game[ "axis" ] ) )
    {
        game[ "axis" ] = "RUSF";
    }
    
    if ( !isdefined( game[ "team_three" ] ) )
    {
        game[ "team_three" ] = "USMC";
    }
    
    if ( !isdefined( game[ "team_four" ] ) )
    {
        game[ "team_four" ] = "SABF";
    }
    
    if ( !isdefined( game[ "team_five" ] ) )
    {
        game[ "team_five" ] = "SAS";
    }
    
    if ( !isdefined( game[ "team_six" ] ) )
    {
        game[ "team_six" ] = "RUSF";
    }
    
    if ( !isdefined( game[ "status" ] ) )
    {
        game[ "status" ] = "normal";
    }
    
    setdvar( @"ui_overtime", game_utility_mp::inovertime() );
    
    if ( !isdefined( game[ "timePassed" ] ) )
    {
        game[ "timePassed" ] = 0;
    }
    
    if ( !isdefined( game[ "roundsPlayed" ] ) )
    {
        game[ "roundsPlayed" ] = 0;
    }
    
    if ( !isdefined( game[ "overtimeRoundsPlayed" ] ) )
    {
        game[ "overtimeRoundsPlayed" ] = 0;
    }
    
    if ( !isdefined( game[ "matchPoint" ] ) )
    {
        game[ "matchPoint" ] = 0;
    }
    
    if ( !isdefined( game[ "finalRound" ] ) )
    {
        game[ "finalRound" ] = 0;
    }
    
    if ( !isdefined( game[ "previousWinningTeam" ] ) )
    {
        game[ "previousWinningTeam" ] = "";
    }
    
    setomnvar( "ui_last_round", game[ "finalRound" ] );
    
    if ( !isdefined( game[ "roundsWon" ] ) )
    {
        game[ "roundsWon" ] = [];
    }
    
    if ( !isdefined( game[ "teamScores" ] ) )
    {
        game[ "teamScores" ] = [];
    }
    
    if ( !isdefined( game[ "timeToBeat" ] ) )
    {
        game[ "timeToBeat" ] = 0;
    }
    
    if ( !isdefined( game[ "timeToBeatOld" ] ) )
    {
        game[ "timeToBeatOld" ] = 0;
    }
    
    if ( !isdefined( game[ "timeToBeatTeam" ] ) )
    {
        game[ "timeToBeatTeam" ] = "none";
    }
    
    if ( !isdefined( game[ "timeToBeatScore" ] ) )
    {
        game[ "timeToBeatScore" ] = 0;
    }
    
    if ( !isdefined( game[ "timeToBeatScoreOld" ] ) )
    {
        game[ "timeToBeatScoreOld" ] = 0;
    }
    
    level.currentclientmatchdataid = 0;
    level.var_4b2b40aa966ef5a = [];
    level.gameended = 0;
    level.forcedend = 0;
    level.hostforcedend = 0;
    level.tier1modeenabled = game_utility_mp::matchmakinggame() && getdvarint( @"hash_5cb1583c77415743", 0 );
    setdvarifuninitialized( @"debug_stopafkcheck", 0 );
    
    /#
        setdvar( @"debug_stopafkcheck", 0 );
    #/
    
    setdvarifuninitialized( @"hash_e32ebdbb97a1ec4e", 0 );
    level.testrandomrealismclients = getdvarint( @"hash_596700a25033a832", 0 ) == 1;
    level.disablepersonalnuke = game_utility_mp::isanymlgmatch();
    
    if ( level.tier1modeenabled )
    {
        setomnvar( "ui_realism_mode", 1 );
        
        if ( !isbrgamemode() )
        {
            level.modifyplayerdamage = &damage::gamemodemodifyplayerdamage;
        }
        
        setdvar( @"jump_slowdownenable", 1 );
        setdvar( @"sprintleap_enabled", 0 );
    }
    
    if ( game_utility::function_d3f8957534dc62af() )
    {
        logstring( "game modifier: tier 1 mode" );
    }
    else if ( game_utility::function_ae97372c83da7acc() )
    {
        logstring( "game modifier: hardcore mode" );
    }
    
    level.thirdpersonmode = getmatchrulesdata( "commonOption", "thirdPerson" );
    level.diehardmode = getdvarint( @"scr_diehard" );
    level.casualscorestreaks = getmatchrulesdata( "commonOption", "casualScoreStreaks" );
    level.wrapkillstreaks = getmatchrulesdata( "commonOption", "wrapKillstreaks" );
    
    if ( !isdefined( level.crankedbombtimer ) )
    {
        level.crankedbombtimer = getmatchrulesdata( "commonOption", "crankedBombTimer" );
    }
    
    level.supportcranked = getmatchrulesdata( "commonOption", "crankedBombTimer" ) > 0 ? 1 : 0;
    
    if ( !level.teambased )
    {
        level.diehardmode = 0;
    }
    
    if ( level.diehardmode )
    {
        logstring( "game mode: diehard" );
    }
    
    level.matchrules_damagemultiplier = getmatchrulesdata( "commonOption", "damageMultiplier" );
    level.matchrules_vampirism = getmatchrulesdata( "commonOption", "vampirism" );
    
    if ( level.matchrules_vampirism )
    {
        level.modifyplayerdamage = &damage::gamemodemodifyplayerdamage;
    }
    
    level.finalkillcamtype = potg::function_754f8cbf0dd72c21();
    
    if ( level.finalkillcamtype == 2 )
    {
        level.skipfinalkillcam = 1;
    }
    
    level.allowkillstreaks = getmatchrulesdata( "commonOption", "allowKillstreaks" );
    level.roundretainstreaks = getmatchrulesdata( "commonOption", "roundRetainStreaks" );
    level.roundretainstreakprog = getmatchrulesdata( "commonOption", "roundRetainStreakProg" );
    level.deathretainstreaks = getmatchrulesdata( "commonOption", "deathRetainStreaks" );
    level.allowperks = getmatchrulesdata( "commonOption", "allowPerks" );
    level.allowsupers = getmatchrulesdata( "commonOption", "allowSupers" );
    level.superfastchargerate = getmatchrulesdata( "commonOption", "superFastChargeRate" );
    level.superpointsmod = getmatchrulesdata( "commonOption", "superPointsMod" );
    level.spawnprotectiontimer = getmatchrulesdata( "commonOption", "spawnProtectionTimer" );
    level.lethaldelay = getmatchrulesdata( "commonOption", "equipmentDelay" );
    level.equipmentmatchstartshieldms = getmatchrulesdata( "commonOption", "equipmentMSProtect" ) * 1000;
    level.magcount = getmatchrulesdata( "commonOption", "magCount" );
    level.practiceround = getmatchrulesdata( "commonOption", "practiceRound" );
    level.postgameexfil = getmatchrulesdata( "commonOption", "postGameExfil" );
    level.exfilactivetimer = getmatchrulesdata( "commonOption", "exfilActiveTimer" );
    level.exfilextracttimer = getmatchrulesdata( "commonOption", "exfilExtractTimer" );
    level.useammorestocklocs = dvars::getoverridedvarfloatexceptmatchrulesvalues( hashcat( @"scr_", game_utility::getgametype(), "_useAmmoRestockLocs" ), @"scr_game_useammorestocklocs" );
    level.spectate3rdallowed = dvars::getoverridedvarintexceptmatchrulesvalues( dvars::function_1165fde71640a2d1( "allow3rdspectate" ), @"scr_game_allow3rdspectate" );
    setdvar( @"camera_allow3rdspectate", level.spectate3rdallowed );
    teamrevive::init();
    level.minimaponbydefault = ( getdvarint( @"scr_game_enableminimap" ) != 0 || getdvarint( @"hash_bc802deb1ff2a842" ) != 0 ) && !game[ "isLaunchChunk" ];
    currentgametype = game_utility::getgametype();
    level.radarhideshots = dvars::getoverridedvarintexceptmatchrulesvalues( dvars::function_1165fde71640a2d1( "radarHidePings" ), @"scr_game_radarhidepings" );
    setomnvar( "ui_compass_hide_weapon_pings_minimap", level.radarhideshots );
    level.navbarhideshots = dvars::getoverridedvarintexceptmatchrulesvalues( dvars::function_1165fde71640a2d1( "navBarHidePings" ), @"scr_game_navbarhidepings" );
    setomnvar( "ui_compass_hide_weapon_pings_navbar", level.navbarhideshots );
    level.navbarhideenemies = dvars::getoverridedvarintexceptmatchrulesvalues( dvars::function_1165fde71640a2d1( "navBarHideEnemy" ), @"scr_game_navbarhideenemy" );
    setomnvar( "ui_compass_hide_enemy_navbar", level.navbarhideenemies );
    level.disablesupersprint = getmatchrulesdata( "commonOption", "disableSuperSprint" );
    level.disablemount = getmatchrulesdata( "commonOption", "disableMount" );
    level.disablebattlechatter = getmatchrulesdata( "commonOption", "disableBattleChatter" );
    level.disableannouncer = getmatchrulesdata( "commonOption", "disableAnnouncer" );
    level.scoremod = [];
    level.scoremod[ "kill" ] = getmatchrulesdata( "commonOption", "pointsPerKill" );
    level.scoremod[ "death" ] = getmatchrulesdata( "commonOption", "pointsPerDeath" );
    level.scoremod[ "headshot" ] = getmatchrulesdata( "commonOption", "pointsHeadshotBonus" );
    level.scoremod[ "kskill" ] = getmatchrulesdata( "commonOption", "pointsPerKSKill" );
    
    if ( level.practiceround && !isdefined( game[ "practiceRound" ] ) )
    {
        game[ "practiceRound" ] = 1;
        level.roundretainstreaks = 0;
        level.roundretainstreakprog = 0;
        level.ignorescoring = 1;
    }
    
    if ( !isdefined( game[ "gameLength" ] ) )
    {
        game[ "gameLength" ] = 0;
    }
    
    setomnvar( "ui_match_timer_hidden", 1 );
    isarenamap = game_utility::isarenamap();
    level.allowkillstreaks = !isarenamap;
    level.allowsupers = !isarenamap;
    setomnvar( "ui_disable_killstreaks", istrue( isarenamap ) );
    setomnvar( "ui_disable_fieldupgrades", istrue( isarenamap ) );
    level.disablecopycatloadout = 1;
    setomnvar( "ui_killcam_copycat", 0 );
    game_utility::getlocaleid();
    level.timelimit = game_utility_mp::function_82e3606d184524fe();
    level.scorelimit = getmatchrulesdata( "commonOption", "scoreLimit" );
    level.roundlimit = getmatchrulesdata( "commonOption", "roundLimit" );
    level.winlimit = getmatchrulesdata( "commonOption", "winLimit" );
    level.numlives = getmatchrulesdata( "commonOption", "numLives" );
    level.roundswitch = getmatchrulesdata( "commonOption", "roundSwitch" );
    setdvar( @"ui_timelimit", level.timelimit );
    
    /#
        println( "<dev string:x8a2>" );
        println( "<dev string:x8af>" );
        println( "<dev string:x8d5>" + level.script );
        println( "<dev string:x8ec>" + game_utility::getgametype() );
        println( "<dev string:x903>" + game_utility::function_ae97372c83da7acc() );
        println( "<dev string:x91a>" + game_utility::function_d3f8957534dc62af() );
        println( "<dev string:x931>" + level.diehardmode );
        println( "<dev string:x948>" + level.thirdpersonmode );
        println( "<dev string:x95f>" + level.forcethirdperson );
        println( "<dev string:x976>" + game[ "<dev string:x6ab>" ] );
        println( "<dev string:x98d>" + level.scorelimit );
        println( "<dev string:x9a4>" + level.roundlimit );
        println( "<dev string:x9bb>" + level.winlimit );
        println( "<dev string:x9d2>" + level.timelimit );
        println( "<dev string:x9e9>" + level.numlives );
        println( "<dev string:xa00>" + level.roundswitch );
        println( "<dev string:x8af>" );
    #/
    
    level.usestartspawns = 1;
    level thread infilexfil::infil_init();
    lui_game_event_aggregator::init();
    connect_event_aggregator::init();
    player_frame_update_aggregator::init();
    namespace_6107ae6ec81b3c5c::init();
    ent_manager::init();
    playerlogic::init();
    game_utility::initchallengeandeventglobals();
    level.maxallowedteamkills = getmatchrulesdata( "commonOption", "ffPunishLimit" );
    callback::callback( #"init_shared_func", {} );
    thread namespace_c1ad58c9f2d22230::init();
    utility::registersharedfunc( #"killstreak_shared", #"assigntargetmarkers", &zm_utility::killstreak_assigntargetmarkers );
    utility::registersharedfunc( #"player", #"hash_d2fd0fbf6b6b308c", &function_c8bc6a4c81fc7661 );
    thread teams::init();
    squads::init();
    player_utility::initdismembermentlist();
    game_utility::values_init();
    thread shellshock_utility::init();
    thread game_utility::game_utility_init();
    thread playerhealth::init();
    thread killcam::init();
    thread final_killcam::initfinalkillcam();
    level.var_6a98fcae23c2e606 = 1;
    mtx_weapon::function_f877fea1e7d31f31();
    thread challenges::init();
    dialog::initstatusdialog();
    
    if ( isbrgamemode() )
    {
        thread battlechatter_mp::init();
    }
    else if ( !game_utility_mp::runleanthreadmode() )
    {
        thread battlechatter_mp::init();
    }
    else
    {
        level.battlechatterenabled = 0;
    }
    
    thread namespace_cef36d7634533c06::init_dialogue();
    
    if ( !game_utility_mp::runleanthreadmode() )
    {
        thread persistence::init();
    }
    
    thread stat_limits::init();
    thread rank::init();
    thread playercards::init();
    thread menus::init();
    thread hud::init();
    thread serversettings::init();
    thread weapons::init();
    thread outline::init();
    thread shellshock::init();
    thread deathicons::init();
    thread damagefeedback::damagefeedback_init();
    thread lightarmor::init();
    thread gameobjects::init();
    thread spectating::init();
    thread spawnlogic::init();
    
    if ( isbrgamemode() )
    {
        thread brmatchdata::init();
        thread brclientmatchdata::init();
    }
    else
    {
        thread matchdata::init();
        thread clientmatchdata::init();
    }
    
    thread awards::init();
    thread playerlogic::initsegmentstats();
    thread perks::init();
    
    if ( !game[ "isLaunchChunk" ] )
    {
        thread vehicle::init();
        thread vehicle_ai::init();
        thread init::init();
        thread perks::initspecialistkillstreaks();
    }
    
    thread zm_player::init_shared_funcs();
    thread events::init();
    thread points::init();
    thread telemetry::init();
    thread events::events_init();
    
    if ( !game_utility_mp::runleanthreadmode() )
    {
        thread whizby::init();
    }
    
    thread analyticslog::init();
    
    if ( !game[ "isLaunchChunk" ] )
    {
        thread loot_mp::init();
        thread supers_mp::init();
        thread supers_mp::watchsuperdelay();
    }
    
    thread callouts::init();
    thread bounty::init();
    thread allow_weapon_mp_init();
    thread ismp_init();
    thread gestures::init();
    thread gestures_mp::init_mp();
    thread execution::execution_init();
    thread sentientpoolmanager::init();
    thread objidpoolmanager::init();
    thread emote::emote_init();
    thread sprays::sprays_init();
    thread scripted_weapons::init();
    
    if ( getdvarint( @"hash_40b282d1a9805a68", 1 ) )
    {
        thread talking_gun::init();
    }
    
    if ( threatbiasgroupexists( "Lethal_Static" ) )
    {
        setthreatbiasignoreall( "Lethal_Static" );
    }
    
    if ( threatbiasgroupexists( "Tactical_Static" ) )
    {
        setthreatbiasignoreall( "Tactical_Static" );
    }
    
    if ( !game[ "isLaunchChunk" ] )
    {
        thread turret::init();
    }
    
    thread laststand::init();
    thread equipment_mp::init();
    thread matchstats::init();
    thread zm_playerstats::init();
    thread focus::init();
    
    if ( !game[ "isLaunchChunk" ] )
    {
        thread outofbounds::initoob();
        thread targetmarkergroups::init();
    }
    
    thread potg::init();
    thread trigger::triggerutilityinit();
    thread entityheadicons::init();
    
    if ( !game[ "isLaunchChunk" ] )
    {
        thread spawnselection::init();
        thread spawncamera::init();
        thread juggernaut::init();
        thread door::door_dynamic_setup();
        thread flashpoint::init();
        thread emp_debuff::emp_debuff_init();
    }
    
    thread hud_message::init();
    level.allowreviveweapons = getmatchrulesdata( "commonOption", "reviveUseWeapon" );
    val::group_register( "reviveShoot", [ "weapon_switch", "offhand_weapons", "gesture", "killstreaks", "supers", "ads", "reload", "autoreload" ] );
    val::group_register( "gameEndFreeze", [ "usability", "ads", "fire", "weapon_switch", "offhand_weapons", "offhand_primary_weapons", "offhand_secondary_weapons", "killstreaks", "supers", "allow_jump", "sprint", "stance_change", "melee" ] );
    thread accolades::init();
    thread ammorestock::init();
    
    if ( getdvarint( @"scr_game_allow_loot" ) == 1 )
    {
        br_pickups::br_pickups_init();
        br_plunder::init();
    }
    
    level armor::init();
    level overlord::init();
    level bots_loadout::init();
    var_ce9a10e19d9bc0a0 = level.var_bff21c0484526cca;
    
    if ( isdefined( var_ce9a10e19d9bc0a0 ) )
    {
        thread [[ var_ce9a10e19d9bc0a0 ]]();
    }
    
    var_ce9a10e19d9bc0a0 = level.var_3eb8011b836083fd;
    
    if ( isdefined( var_ce9a10e19d9bc0a0 ) )
    {
        thread [[ var_ce9a10e19d9bc0a0 ]]();
    }
    
    if ( level.teambased )
    {
        foreach ( team in level.teamnamelist )
        {
            if ( !isdefined( game[ "roundsWon" ][ team ] ) )
            {
                game[ "roundsWon" ][ team ] = 0;
            }
            
            if ( !isdefined( game[ "teamScores" ][ team ] ) )
            {
                game[ "teamScores" ][ team ] = 0;
            }
        }
    }
    
    if ( game[ "status" ] != "overtime" && game[ "status" ] != "halftime" )
    {
        if ( !( game[ "roundsPlayed" ] > 0 && level.gametypebundle.scoringstrategy == #"teamscores" ) )
        {
            game[ "teamScores" ][ "allies" ] = 0;
            game[ "teamScores" ][ "axis" ] = 0;
        }
    }
    
    setomnvar( "ui_in_overtime_round", game[ "status" ] == "overtime" );
    game[ "gamestarted" ] = 1;
    level.currentround = game[ "roundsPlayed" ] + 1;
    level.maxplayercount = 0;
    level.activeplayers = [];
    
    foreach ( entry in level.teamnamelist )
    {
        level.wavedelay[ entry ] = 0;
        level.lastwave[ entry ] = 0;
        level.waveplayerspawnindex[ entry ] = 0;
        level.aliveplayers[ entry ] = [];
        
        if ( !level.requiredplayercountoveride )
        {
            level.requiredplayercount[ entry ] = 0;
        }
    }
    
    setomnvar( "ui_scorelimit", 0 );
    setdvar( @"ui_allow_teamchange", 1 );
    
    if ( !game[ "isLaunchChunk" ] )
    {
        setomnvar( "ui_round_hint_override_attackers", 0 );
        setomnvar( "ui_round_hint_override_defenders", 0 );
    }
    
    if ( game_utility_mp::getgametypenumlives() )
    {
        setdvar( @"g_deadchat", 0 );
    }
    else
    {
        setdvar( @"g_deadchat", 1 );
    }
    
    updatewavespawndelay();
    level.graceperiod = 15;
    level.ingraceperiod = level.graceperiod;
    
    if ( !isdefined( level.roundenddelay ) )
    {
        level.roundenddelay = 6;
    }
    
    level.playovertime = 0;
    level.finalroundenddelay = 3;
    level.halftimeroundenddelay = 3;
    level.postgamehitmarkerwaittime = 0.25;
    
    if ( game[ "isLaunchChunk" ] )
    {
        setomnvar( "ui_current_round", level.currentround );
    }
    else if ( level.roundlimit != 1 )
    {
        setomnvar( "ui_current_round", level.currentround );
    }
    
    if ( level.scorelimit == 1 )
    {
        level.roundscorelimit = 1;
        level.totalscorelimit = level.winlimit;
    }
    else
    {
        level.roundscorelimit = level.scorelimit * ( game[ "roundsPlayed" ] + 1 );
        level.totalscorelimit = level.scorelimit * level.roundlimit;
    }
    
    if ( game_utility_mp::resetscoreonroundstart() )
    {
        level.roundscorelimit = level.scorelimit;
        level.totalscorelimit = level.scorelimit;
        game[ "teamScores" ][ game[ "attackers" ] ] = 0;
        setteamscore( game[ "attackers" ], 0 );
        game[ "teamScores" ][ game[ "defenders" ] ] = 0;
        setteamscore( game[ "defenders" ], 0 );
    }
    
    if ( game_utility_mp::isovertimesupportedgametype() && game_utility_mp::inovertime() )
    {
        gamescore::updateovertimescore();
    }
    
    if ( level.teambased )
    {
        foreach ( entry in level.teamnamelist )
        {
            gamescore::updateteamscore( entry );
        }
    }
    
    thread updateuiscorelimit();
    level notify( #"update_scorelimit" );
    
    if ( isdefined( level.matchrecording_init ) )
    {
        level thread [[ level.matchrecording_init ]]();
    }
    
    if ( getdvarint( @"scr_allow_custom_loadouts", 0 ) == 0 || game_utility_mp::function_f24635ef11e449d1() )
    {
        setomnvar( "ui_only_default_loadouts", 1 );
    }
    
    level.var_a4851fe642803397 = 0;
    
    if ( utility::issharedfuncdefined( #"display_transition", #"using_new_transitions" ) )
    {
        level.var_a4851fe642803397 = [[ utility::getsharedfunc( #"display_transition", #"using_new_transitions" ) ]]();
    }
    
    common::commononstartgametype();
    [[ level.onstartgametype ]]();
    level utility::flag_set( "onStartGameTypeFinished" );
    level thread common::onplayerconnectcommon();
    disconnect_event_aggregator::registerondisconnecteventcallback( &function_442747bb1b929abf );
    level.scorepercentagecutoff = dvars::function_13909a5327c395b9( "score_percentage_cut_off", 70 );
    level.timepercentagecutoff = dvars::function_13909a5327c395b9( "time_percentage_cut_off", 70 );
    
    /#
        setdvarifuninitialized( @"hash_ff657c87711b0cd6", 1 );
        
        if ( getdvarint( @"hash_ff657c87711b0cd6", 1 ) )
        {
            level.scorepercentagecutoff = 100;
            level.timepercentagecutoff = 100;
        }
    #/
    
    /#
        thread [[ level.devinit ]]();
        level thread dof::function_55904422b4033469();
    #/
    
    if ( getdvar( @"dedicated" ) == "dedicated LAN server" || getdvar( @"dedicated" ) == "dedicated internet server" )
    {
        thread verifydedicatedconfiguration();
    }
    
    thread startgame();
    level thread dvars::updatewatcheddvars();
    level thread updateleaderboardstatscontinuous();
    level thread removepatchablecollision_delayed();
    level utility::flag_set( "StartGameTypeCallbackFinished" );
    feature_init::in_play_limits_init();
    
    if ( level.gametypebundle.var_af34edb6af361a99 )
    {
        level thread gamelogic_mp::timelimitthread();
    }
}

// Namespace gamelogic_zm
// Params 0
// Checksum 0x309e4345, Offset: 0xce97
// Size: 0xb3
function updatewavespawndelay()
{
    wavedelay = getmatchrulesdata( "commonOption", "waveRespawnDelay" );
    
    if ( wavedelay )
    {
        foreach ( entry in level.teamnamelist )
        {
            level.wavedelay[ entry ] = wavedelay;
            level.lastwave[ entry ] = 0;
        }
        
        level thread gamelogic_mp::wavespawntimer();
    }
}

// Namespace gamelogic_zm
// Params 0
// Checksum 0x5ab0b898, Offset: 0xcf52
// Size: 0x64
function verifydedicatedconfiguration()
{
    for ( ;; )
    {
        if ( level.rankedmatch )
        {
            exitlevel( 0 );
        }
        
        if ( !getdvarint( @"xblive_privatematch" ) )
        {
            exitlevel( 0 );
        }
        
        if ( getdvar( @"dedicated" ) != "dedicated LAN server" && getdvar( @"dedicated" ) != "dedicated internet server" )
        {
            exitlevel( 0 );
        }
        
        wait 5;
    }
}

// Namespace gamelogic_zm
// Params 0
// Checksum 0x88160d8e, Offset: 0xcfbe
// Size: 0x2b1
function updateuiscorelimit()
{
    for ( ;; )
    {
        level utility::waittill_any( "update_scorelimit", "update_winlimit" );
        
        if ( game_utility_mp::inovertime() || game_utility_mp::intimetobeat() )
        {
            if ( game_utility_mp::istimetobeatrulegametype() )
            {
                foreach ( player in level.players )
                {
                    player setclientomnvar( "ui_friendly_time_to_beat", player.team == game[ "timeToBeatTeam" ] ? game[ "timeToBeat" ] : game[ "timeToBeatOld" ] );
                    player setclientomnvar( "ui_enemy_time_to_beat", player.team != game[ "timeToBeatTeam" ] ? game[ "timeToBeat" ] : game[ "timeToBeatOld" ] );
                }
                
                setomnvar( "ui_scorelimit", game_utility_mp::istimetobeatvalid() ? game[ "timeToBeatScore" ] : 1 );
            }
            else if ( game_utility_mp::isscoretobeatrulegametype() )
            {
                foreach ( player in level.players )
                {
                    player setclientomnvar( "ui_friendly_time_to_beat", player.team == game[ "timeToBeatTeam" ] ? game[ "timeToBeat" ] : game[ "timeToBeatOld" ] );
                    player setclientomnvar( "ui_enemy_time_to_beat", player.team != game[ "timeToBeatTeam" ] ? game[ "timeToBeat" ] : game[ "timeToBeatOld" ] );
                }
                
                setomnvar( "ui_scorelimit", game_utility_mp::istimetobeatvalid() ? game[ "timeToBeatScore" ] : 1 );
            }
            else if ( game_utility_mp::iswinbytworulegametype() )
            {
                defenderscore = game[ "roundsWon" ][ game[ "defenders" ] ];
                attackerscore = game[ "roundsWon" ][ game[ "attackers" ] ];
                targetscore = 0;
                
                if ( defenderscore == attackerscore )
                {
                    targetscore = defenderscore + 2;
                }
                else if ( defenderscore > attackerscore )
                {
                    targetscore = defenderscore + 1;
                }
                else
                {
                    targetscore = attackerscore + 1;
                }
                
                setomnvar( "ui_scorelimit", targetscore );
            }
            else
            {
                usenormalscorelimit();
            }
            
            continue;
        }
        
        usenormalscorelimit();
    }
}

// Namespace gamelogic_zm
// Params 0
// Checksum 0xca378cac, Offset: 0xd277
// Size: 0x68
function usenormalscorelimit()
{
    if ( !game_utility_mp::isroundbased() || !game_utility_mp::isobjectivebased() || level.gametypebundle.scoringstrategy == #"teamscores" )
    {
        setomnvar( "ui_scorelimit", level.totalscorelimit );
        thread checkscorelimit();
        return;
    }
    
    setomnvar( "ui_scorelimit", level.winlimit );
}

// Namespace gamelogic_zm
// Params 0
// Checksum 0x4811c26, Offset: 0xd2e7
// Size: 0xce
function playtickingsound()
{
    self endon( #"death" );
    self endon( #"stop_ticking" );
    level endon( #"game_ended" );
    time = level.bombtimer;
    
    if ( isdefined( level.defusetime ) )
    {
        var_2ea459ffd911b71c = level.defusetime + 1;
    }
    else
    {
        var_2ea459ffd911b71c = 6;
    }
    
    while ( true )
    {
        if ( time > 15 )
        {
            self playsound( "ui_mp_suitcasebomb_timer" );
            time -= 1;
            wait 1;
        }
        else if ( time > var_2ea459ffd911b71c )
        {
            self playsound( "ui_mp_suitcasebomb_timer_urgent" );
            time -= 1;
            wait 1;
        }
        else
        {
            self playsound( "ui_mp_timer_countdown_half_sec" );
            time -= 0.5;
            wait 0.5;
        }
        
        hostmigration::waittillhostmigrationdone();
    }
}

// Namespace gamelogic_zm
// Params 0
// Checksum 0xddfcf156, Offset: 0xd3bd
// Size: 0xe
function stoptickingsound()
{
    self notify( #"stop_ticking" );
}

// Namespace gamelogic_zm
// Params 1
// Checksum 0x881bb617, Offset: 0xd3d3
// Size: 0x59
function getclocksoundaliasfortimeleft( timeleft )
{
    if ( timeleft > 20 )
    {
        return "ui_mp_timer_countdown";
    }
    
    if ( timeleft > 10 )
    {
        return "ui_mp_timer_countdown_10";
    }
    
    if ( timeleft > 5 )
    {
        return "ui_mp_timer_countdown_half_sec";
    }
    
    if ( timeleft > 1.5 )
    {
        return "ui_mp_timer_countdown_quarter_sec";
    }
    
    return "ui_mp_timer_countdown_1";
}

// Namespace gamelogic_zm
// Params 0
// Checksum 0xfc7bc, Offset: 0xd434
// Size: 0x307
function timelimitclock()
{
    level endon( #"hash_7ddc80b0350bfe28" );
    waitframe();
    
    if ( game_utility_mp::gettimelimit() == 0 )
    {
        return;
    }
    
    if ( level.gametypebundle.var_9771c12412cfda3c )
    {
        return;
    }
    
    clockobject = spawn( "script_origin", ( 0, 0, 0 ) );
    clockobject.targetname = "timeLimitClock";
    clockobject hide();
    playedsixty = istrue( level.gametypebundle.var_289a32dd1165804b );
    playedthirty = istrue( level.gametypebundle.var_db6c1348c43ba48e );
    playedtimesup = istrue( level.gametypebundle.var_dc242792c4693773 );
    var_da7d6f58b406a71f = game_utility_mp::isanymlgmatch() ? 5 : 2;
    
    while ( game[ "state" ] == "playing" )
    {
        if ( !level.timerstopped && game_utility_mp::gettimelimit() && !level.bombsplanted )
        {
            timeleft = gettimeremaining() / 1000;
            timeleftint = int( timeleft + 0.5 );
            var_ee6b9cea37d55528 = 0;
            
            if ( var_da7d6f58b406a71f == 2 && timeleftint % 2 == 1 )
            {
                var_ee6b9cea37d55528 = 1;
            }
            
            if ( !playedsixty && ( var_ee6b9cea37d55528 == 1 && timeleftint == 61 || var_ee6b9cea37d55528 == 0 && timeleftint == 60 ) )
            {
                level namespace_cef36d7634533c06::matchendingsoonleaderdialog( "timesup_sixty" );
                level notify( #"match_ending_soon", "time" );
                playedsixty = 1;
            }
            else if ( !playedthirty && ( var_ee6b9cea37d55528 == 1 && timeleftint == 31 || var_ee6b9cea37d55528 == 0 && timeleftint == 30 ) )
            {
                level namespace_cef36d7634533c06::matchendingsoonleaderdialog( "timesup_thirty" );
                playedtimesup = level namespace_cef36d7634533c06::matchendingsoonleaderdialog( "timesup" );
                level notify( #"match_ending_soon", "time" );
                playedthirty = 1;
            }
            else if ( !playedsixty && !playedthirty && !playedtimesup && timeleftint >= 30 && timeleftint <= 45 )
            {
                playedtimesup = level namespace_cef36d7634533c06::matchendingsoonleaderdialog( "timesup" );
                level notify( #"match_ending_soon", "time" );
            }
            
            if ( timeleftint <= 10 || timeleftint <= 30 && timeleftint % var_da7d6f58b406a71f == var_ee6b9cea37d55528 )
            {
                if ( !playedtimesup && timeleftint <= 10 )
                {
                    playedtimesup = level namespace_cef36d7634533c06::matchendingsoonleaderdialog( "timesup", timeleftint );
                }
                
                level notify( #"match_ending_very_soon" );
                var_1e4609f489ec0c25 = 1;
                
                if ( timeleftint == 0 )
                {
                    break;
                }
                
                if ( level.overridetimelimitclock < timeleftint )
                {
                    var_1e4609f489ec0c25 = 0;
                }
                
                if ( var_1e4609f489ec0c25 )
                {
                    clocksoundalias = getclocksoundaliasfortimeleft( timeleft );
                    clockobject playsound( clocksoundalias );
                }
            }
            
            if ( timeleft - floor( timeleft ) >= 0.05 )
            {
                wait timeleft - floor( timeleft );
                continue;
            }
        }
        
        wait 1;
    }
}

// Namespace gamelogic_zm
// Params 0
// Checksum 0x24aa4d10, Offset: 0xd743
// Size: 0x45
function shouldmodelognotify()
{
    switch ( game_utility::getgametype() )
    {
        case #"hash_5ff8e011d5b9d1c8":
        case #"hash_eb5e5f470e0c1dc2":
        case #"hash_fa50b0f6bd82e972":
            return 1;
        default:
            return 0;
    }
}

// Namespace gamelogic_zm
// Params 0
// Checksum 0x1ae130d0, Offset: 0xd790
// Size: 0x5b
function stoptimer()
{
    if ( utility::issharedfuncdefined( #"zm", #"hash_24d8662fc27b441c" ) )
    {
        level [[ utility::getsharedfunc( #"zm", #"hash_24d8662fc27b441c" ) ]]();
    }
    else
    {
        level waittill( #"end_round_logic" );
    }
    
    level.timerstoppedforgamemode = 1;
    updatetimerpausedness();
}

// Namespace gamelogic_zm
// Params 0
// Checksum 0xe690dfdc, Offset: 0xd7f3
// Size: 0x1a3
function gametimer()
{
    level endon( #"game_ended", #"end_round_logic" );
    
    if ( isdefined( game[ "startTimeFromMatchStart" ] ) )
    {
        level.starttimefrommatchstart = game[ "startTimeFromMatchStart" ];
    }
    
    if ( utility::issharedfuncdefined( #"zm", #"wait_begin_round_logic" ) )
    {
        level [[ utility::getsharedfunc( #"zm", #"wait_begin_round_logic" ) ]]();
    }
    else if ( utility::flag_exist( "begin_round_logic" ) )
    {
        utility::flag_wait( "begin_round_logic" );
    }
    
    level.starttime = gettime();
    level.discardtime = 0;
    level.overtimetotal = 0;
    setomnvar( "ui_match_start_timestamp", level.starttime );
    thread stoptimer();
    
    if ( !isdefined( game[ "startTimeFromMatchStart" ] ) )
    {
        game[ "startTimeFromMatchStart" ] = gettime();
        level.starttimefrommatchstart = gettime();
        telemetry_utils::function_af2d366f9522f76f( "callback_match_start" );
        utility::trycall( level.var_f7a04b1f813c1246 );
    }
    
    if ( isdefined( game[ "roundMillisecondsAlreadyPassed" ] ) )
    {
        level.starttime -= game[ "roundMillisecondsAlreadyPassed" ];
        game[ "roundMillisecondsAlreadyPassed" ] = undefined;
    }
    
    if ( game[ "roundsPlayed" ] < 24 )
    {
        setmatchdata( "utcRoundStartTimeSeconds", game[ "roundsPlayed" ], getsystemtime() );
    }
    
    prevtime = gettime();
    
    while ( game[ "state" ] == "playing" )
    {
        if ( !level.timerstopped )
        {
            game[ "timePassed" ] = game[ "timePassed" ] + gettime() - prevtime;
        }
        
        prevtime = gettime();
        wait 1;
    }
}

// Namespace gamelogic_zm
// Params 1
// Checksum 0x2730113, Offset: 0xd99e
// Size: 0x159
function updatetimerpausedness( var_c1fc8c35cb70cabd )
{
    shouldbestopped = level.timerstoppedforgamemode || isdefined( level.hostmigrationtimer );
    
    if ( !level.timerstopped && shouldbestopped )
    {
        level.timerstopped = 1;
        level.timerpausetime = gettime();
        timeleft = gettimeremaining();
        
        if ( isdefined( var_c1fc8c35cb70cabd ) )
        {
            setgameendtime( int( var_c1fc8c35cb70cabd ) );
        }
        else
        {
            setgameendtime( gettime() + int( timeleft ) );
        }
        
        setomnvar( "ui_match_timer_stopped", 1 );
        return;
    }
    
    if ( level.timerstopped && !shouldbestopped )
    {
        level.timerstopped = 0;
        var_596edc95cf1e9e7c = gettime() - level.timerpausetime;
        
        if ( !isdefined( level.discardtime ) )
        {
            level.discardtime = 0;
        }
        
        level.discardtime += var_596edc95cf1e9e7c;
        
        if ( !isdefined( game[ "discardTime" ] ) )
        {
            game[ "discardTime" ] = 0;
        }
        
        game[ "discardTime" ] = game[ "discardTime" ] + var_596edc95cf1e9e7c;
        timeleft = gettimeremaining();
        
        if ( isdefined( var_c1fc8c35cb70cabd ) )
        {
            setgameendtime( int( var_c1fc8c35cb70cabd ) );
        }
        else
        {
            setgameendtime( gettime() + int( timeleft ) );
        }
        
        setomnvar( "ui_match_timer_stopped", 0 );
    }
}

// Namespace gamelogic_zm
// Params 1
// Checksum 0x30c34524, Offset: 0xdaff
// Size: 0x2d
function pausetimer( gameovertime )
{
    if ( !level.timerstoppedforgamemode )
    {
        level.timerstoppedforgamemode = 1;
        updatetimerpausedness( gameovertime );
    }
}

// Namespace gamelogic_zm
// Params 1
// Checksum 0x6ad0b012, Offset: 0xdb34
// Size: 0x2b
function resumetimer( gameovertime )
{
    if ( level.timerstoppedforgamemode )
    {
        level.timerstoppedforgamemode = 0;
        updatetimerpausedness( gameovertime );
    }
}

// Namespace gamelogic_zm
// Params 0
// Checksum 0x93c98eee, Offset: 0xdb67
// Size: 0x14
function prematchover()
{
    level callback::callback( #"prematch_done", {} );
}

// Namespace gamelogic_zm
// Params 0
// Checksum 0x9c8f7b13, Offset: 0xdb83
// Size: 0x196
function startgame()
{
    setslowmotion( 1, 1, 0 );
    thread gametimer();
    level.timerstopped = 0;
    level.timerstoppedforgamemode = 0;
    setomnvar( "ui_prematch_period", 1 );
    prematchperiod();
    prematchover();
    thread analyticslog::logevent_sendplayerindexdata();
    
    if ( getdvarint( @"hash_5cf9f783b9a4ed7b", 1 ) == 1 )
    {
        foreach ( player in level.players )
        {
            playerlogic::clearprematchlook( player );
            player player::_freezecontrols( 0, 1 );
            player setclientomnvar( "ui_match_start_countdown", -1 );
            player setclientomnvar( "ui_match_in_progress", 1 );
        }
    }
    
    flags::gameflagset( "prematch_done" );
    level notify( #"prematch_over" );
    setomnvar( "ui_prematch_period", 0 );
    updatetimerpausedness();
    timelimit = game_utility_mp::gettimelimit();
    
    if ( timelimit > 0 )
    {
        level thread waitthenshowtimer();
    }
    else
    {
        setomnvar( "ui_match_timer_hidden", 1 );
    }
    
    cleanpatchablecollision();
    thread timelimitclock();
    thread graceperiod();
    
    if ( getdvarint( @"party_maxplayers", 0 ) > 30 )
    {
        setdvar( @"hash_a85ba82ffd9faefe", 1 );
    }
    
    thread analyticslog::function_e5f7408aa3efeea2();
}

// Namespace gamelogic_zm
// Params 0
// Checksum 0x7d7c29f7, Offset: 0xdd21
// Size: 0x1f
function waitthenshowtimer()
{
    setomnvar( "ui_match_timer_hidden", 1 );
    wait 0.25;
    setomnvar( "ui_match_timer_hidden", 0 );
}

// Namespace gamelogic_zm
// Params 0
// Checksum 0x23cbd34e, Offset: 0xdd48
// Size: 0x334
function cleanpatchablecollision()
{
    patch = [];
    patch[ 0 ] = getent( "clip32x32x8", #targetname );
    patch[ 1 ] = getent( "clip32x32x128", #targetname );
    patch[ 2 ] = getent( "clip64x64x256", #targetname );
    patch[ 3 ] = getent( "clip32x32x32", #targetname );
    patch[ 4 ] = getent( "clip64x64x128", #targetname );
    patch[ 5 ] = getent( "clip64x64x64", #targetname );
    patch[ 6 ] = getent( "clip64x64x8", #targetname );
    patch[ 7 ] = getent( "clip128x128x256", #targetname );
    patch[ 8 ] = getent( "clip128x128x128", #targetname );
    patch[ 9 ] = getent( "clip128x128x8", #targetname );
    patch[ 10 ] = getent( "clip256x256x256", #targetname );
    patch[ 11 ] = getent( "clip256x256x128", #targetname );
    patch[ 12 ] = getent( "clip256x256x8", #targetname );
    patch[ 13 ] = getent( "clip512x512x8", #targetname );
    patch[ 14 ] = getent( "clip32x32x256", #targetname );
    patch[ 15 ] = getent( "player32x32x8", #targetname );
    patch[ 16 ] = getent( "player32x32x32", #targetname );
    patch[ 17 ] = getent( "player32x32x128", #targetname );
    patch[ 18 ] = getent( "player32x32x256", #targetname );
    patch[ 19 ] = getent( "player64x64x256", #targetname );
    patch[ 20 ] = getent( "player64x64x128", #targetname );
    patch[ 21 ] = getent( "player64x64x64", #targetname );
    patch[ 22 ] = getent( "player64x64x8", #targetname );
    patch[ 23 ] = getent( "player128x128x256", #targetname );
    patch[ 24 ] = getent( "player128x128x128", #targetname );
    patch[ 25 ] = getent( "player128x128x8", #targetname );
    patch[ 26 ] = getent( "player256x256x256", #targetname );
    patch[ 27 ] = getent( "player256x256x128", #targetname );
    patch[ 28 ] = getent( "player256x256x8", #targetname );
    patch[ 29 ] = getent( "player512x512x8", #targetname );
    
    foreach ( p in patch )
    {
        if ( isdefined( p ) )
        {
            p delete();
        }
    }
}

// Namespace gamelogic_zm
// Params 0
// Checksum 0x4cb05468, Offset: 0xe084
// Size: 0x101
function wavespawntimer()
{
    level endon( #"game_ended" );
    level notify( #"hash_d70674257c3f98b0" );
    level endon( #"hash_d70674257c3f98b0" );
    
    while ( game[ "state" ] == "playing" )
    {
        time = gettime();
        
        foreach ( entry in level.teamnamelist )
        {
            if ( time - level.lastwave[ entry ] > level.wavedelay[ entry ] * 1000 )
            {
                level notify( "wave_respawn_" + entry );
                level.lastwave[ entry ] = time;
                level.waveplayerspawnindex[ entry ] = 0;
            }
        }
        
        waitframe();
    }
}

// Namespace gamelogic_zm
// Params 0
// Checksum 0x47c3f669, Offset: 0xe18d
// Size: 0x49
function wavetimerwatcher()
{
    level endon( #"hash_d70674257c3f98b0" );
    
    while ( true )
    {
        utility::waittill_any( "wave_respawn_allies", "wave_respawn_axis" );
        setomnvar( "ui_hardpoint_timer", gettime() + 1000 * level.wavedelay[ "allies" ] );
    }
}

// Namespace gamelogic_zm
// Params 0
// Checksum 0x8aad9a8b, Offset: 0xe1de
// Size: 0x29c
function getbetterteam()
{
    kills = [];
    deaths = [];
    
    foreach ( entry in level.teamnamelist )
    {
        kills[ entry ] = 0;
        deaths[ entry ] = 0;
    }
    
    foreach ( player in level.players )
    {
        team = player.pers[ "team" ];
        
        if ( team_utility::isgameplayteam( team ) )
        {
            kills[ team ] += player.kills;
            deaths[ team ] += player.deaths;
        }
    }
    
    highestkillcount = undefined;
    var_f5641148ab29742b = undefined;
    var_463e1c482a62d000 = 0;
    lowestdeathcount = undefined;
    var_fa789b63b33786f7 = undefined;
    var_bf440e638763b91c = 0;
    
    foreach ( entry in level.teamnamelist )
    {
        killcount = kills[ entry ];
        
        if ( !isdefined( highestkillcount ) || killcount > highestkillcount )
        {
            highestkillcount = killcount;
            var_f5641148ab29742b = entry;
            var_463e1c482a62d000 = 0;
        }
        else if ( highestkillcount == killcount )
        {
            var_463e1c482a62d000 = 1;
        }
        
        deathcount = deaths[ entry ];
        
        if ( !isdefined( lowestdeathcount ) || deathcount < lowestdeathcount )
        {
            lowestdeathcount = deathcount;
            var_fa789b63b33786f7 = entry;
            var_bf440e638763b91c = 0;
            continue;
        }
        
        if ( lowestdeathcount == deathcount )
        {
            var_bf440e638763b91c = 1;
        }
    }
    
    if ( !var_463e1c482a62d000 )
    {
        return var_f5641148ab29742b;
    }
    
    if ( !var_bf440e638763b91c )
    {
        return var_fa789b63b33786f7;
    }
    
    randomidx = randomint( level.teamnamelist.size );
    return level.teamnamelist[ randomidx ];
}

// Namespace gamelogic_zm
// Params 1
// Checksum 0xc515e02d, Offset: 0xe483
// Size: 0x51
function rankedmatchupdates( winner )
{
    if ( game_utility_mp::matchmakinggame() )
    {
        setxenonranks();
        
        if ( hostidledout() )
        {
            level.hostforcedend = 1;
            logstring( "host idled out" );
            endlobby();
        }
        
        updatematchbonusscores( winner );
    }
    
    updatewinlossstats( winner );
}

// Namespace gamelogic_zm
// Params 3
// Checksum 0xf48ffe73, Offset: 0xe4dc
// Size: 0x19d
function displayroundend( winner, endreasontext, endreasontextloss )
{
    if ( !level.doeomcombat && level.gametypebundle.scoringstrategy == #"teamscores" && game[ "finalRound" ] == 0 )
    {
        winner = "roundend";
    }
    
    level.roundendextramessage = 0;
    
    if ( !game_utility_mp::waslastround() && game_utility::getgametype() == "arena" && !game[ "practiceRound" ] )
    {
        if ( checkroundswitch( level.playovertime ) )
        {
            level.roundendextramessage = game[ "round_end_exmsg" ][ "switching_sides" ];
        }
    }
    
    if ( game_utility_mp::waslastround() && game_utility_mp::iswinbytworulegametype() && game_utility_mp::function_1c242e9b72b23687() )
    {
        winner = "tie";
        endreasontext = game[ "end_reason" ][ "win_by_two_tie" ];
        endreasontextloss = game[ "end_reason" ][ "win_by_two_tie" ];
    }
    
    foreach ( player in level.players )
    {
        if ( function_598b3aad1aa54a90() )
        {
            player thread hud_message::teamoutcomenotify( winner, 1, endreasontext, endreasontextloss, level.roundendextramessage );
            continue;
        }
        
        player thread hud_message::outcomenotify( winner, 1, endreasontext, endreasontextloss );
    }
}

// Namespace gamelogic_zm
// Params 3
// Checksum 0x835c080e, Offset: 0xe681
// Size: 0x117
function displaygameend( winner, endreasontext, endreasontextloss )
{
    if ( endreasontext != game[ "end_reason" ][ "server_quit" ] )
    {
        setomnvar( "ui_match_over", 1 );
    }
    
    if ( game_utility_mp::waslastround() && game_utility_mp::iswinbytworulegametype() && game_utility_mp::function_1c242e9b72b23687() )
    {
        winner = "tie";
        endreasontext = game[ "end_reason" ][ "win_by_two_tie" ];
        endreasontextloss = game[ "end_reason" ][ "win_by_two_tie" ];
    }
    
    foreach ( player in level.players )
    {
        if ( function_598b3aad1aa54a90() )
        {
            player thread hud_message::teamoutcomenotify( winner, 0, endreasontext, endreasontextloss );
            continue;
        }
        
        player thread hud_message::outcomenotify( winner, 0, endreasontext, endreasontextloss );
    }
}

// Namespace gamelogic_zm
// Params 0
// Checksum 0x8ce3f1, Offset: 0xe7a0
// Size: 0x23a
function displayroundswitch()
{
    level notify( #"spawning_intermission" );
    intermissionspawnpointoverride = getintermissionspawnpointoverride();
    
    foreach ( player in level.players )
    {
        player thread playerlogic::spawnintermission( intermissionspawnpointoverride );
    }
    
    switchtype = level.halftimetype;
    
    if ( switchtype == "halftime" )
    {
        if ( level.roundlimit )
        {
            if ( game[ "roundsPlayed" ] * 2 == level.roundlimit )
            {
                switchtype = "halftime";
            }
            else
            {
                switchtype = "intermission";
            }
        }
        else
        {
            switchtype = "intermission";
        }
    }
    
    level notify( #"round_switch", switchtype );
    endreason = 0;
    
    if ( game[ "finalRound" ] == 1 )
    {
        switchtype = "final_round";
    }
    else if ( game[ "matchPoint" ] == 1 )
    {
        switchtype = "match_point";
        
        if ( game_utility_mp::iswinbytworulegametype() && game[ "roundsWon" ][ "allies" ] == game[ "roundsWon" ][ "axis" ] )
        {
            switchtype = "win_by_two";
        }
    }
    
    if ( isdefined( level.switchedsides ) )
    {
        endreason = game[ "end_reason" ][ "switching_sides" ];
        level.roundendextramessage = 0;
        
        if ( switchtype != "final_round" && switchtype != "match_point" )
        {
            switchtype = "switching_sides";
        }
    }
    
    foreach ( player in level.players )
    {
        player thread hud_message::teamoutcomenotify( switchtype, 1, endreason, endreason, level.roundendextramessage );
    }
    
    roundendwait( level.halftimeroundenddelay, 0 );
}

// Namespace gamelogic_zm
// Params 4
// Checksum 0x544e2371, Offset: 0xe9e2
// Size: 0x1d2
function freezeallplayers( delay = 0, var_d91f34a9d05b470d, var_859130a57b5e5819, slowmotion = 0 )
{
    if ( delay > 0 && slowmotion )
    {
        thread slowmotionendofgame( delay );
    }
    
    thread sendgameendedfrozennotify( delay );
    
    foreach ( player in level.players )
    {
        player enableplayerbreathsystem( 0 );
        player thread freezeplayerforroundend( delay );
        player thread roundenddof( 4 );
        player freegameplayhudelems();
        player setclientdvars( @"cg_everyonehearseveryone", 1, @"cg_drawspectatormessages", 0 );
        
        if ( isdefined( var_d91f34a9d05b470d ) && isdefined( var_859130a57b5e5819 ) )
        {
            if ( var_d91f34a9d05b470d == @"cg_fovscale" && player issplitscreenplayer() )
            {
                player setclientdvars( var_d91f34a9d05b470d, 0.75 );
            }
            
            player setclientdvars( var_d91f34a9d05b470d, var_859130a57b5e5819 );
        }
    }
    
    if ( isdefined( level.agentarray ) )
    {
        foreach ( agent in level.agentarray )
        {
            agent player::_freezecontrols( 1, undefined, "freezeAllPlayers" );
        }
    }
}

// Namespace gamelogic_zm
// Params 1
// Checksum 0xf59c9d1e, Offset: 0xebbc
// Size: 0x25
function endofroundvisionset( delay )
{
    if ( delay > 0 )
    {
        wait delay;
    }
    
    visionsetfadetoblack( "bw", 0.75 );
}

// Namespace gamelogic_zm
// Params 1
// Checksum 0xd02dba4a, Offset: 0xebe9
// Size: 0x41
function slowmotionendofgame( delay )
{
    setslowmotion( 1, 0.4, delay );
    setendofroundsoundtimescalefactor();
    hostmigration::waitlongdurationwithhostmigrationpause( delay );
    setslowmotion( 1, 1, 0 );
    resetsoundtimescalefactor();
}

// Namespace gamelogic_zm
// Params 1
// Checksum 0x61b9e6fa, Offset: 0xec32
// Size: 0x1b
function sendgameendedfrozennotify( delay )
{
    wait delay;
    level notify( #"game_ended_frozen" );
}

// Namespace gamelogic_zm
// Params 0
// Checksum 0xdeed60c4, Offset: 0xec55
// Size: 0x3b
function restart()
{
    if ( isdefined( level.onmaprestart ) )
    {
        [[ level.onmaprestart ]]();
    }
    
    level notify( #"restarting" );
    game[ "state" ] = "playing";
    map_restart( 1 );
}

// Namespace gamelogic_zm
// Params 5
// Checksum 0xdd364d0f, Offset: 0xec98
// Size: 0x162
function endgame( winner, endreasontext, endreasontextloss, nukedetonated, var_de9b655923cddf60 )
{
    level notify( #"start_game_ended" );
    callback::callback( #"start_game_ended" );
    level musicbank_utility::function_5aca66c390aa347d( level.players, #"gameover" );
    
    foreach ( player in level.players )
    {
        if ( level.var_e292d4a613019a9 > 0 )
        {
            player utility::delaycallendon( level.var_e292d4a613019a9, "disconnect", &setsoundsubmix, "cer_zm_rbz_endgame" );
            continue;
        }
        
        player setsoundsubmix( "cer_zm_rbz_endgame" );
    }
    
    level.endgamewinner = winner;
    
    if ( isdefined( level.modescorewinner ) )
    {
        winner = level.modescorewinner;
    }
    
    if ( isdefined( level.endgame ) )
    {
        [[ level.endgame ]]( winner, endreasontext );
        return;
    }
    
    endgame_regularmp( winner, endreasontext, endreasontextloss, nukedetonated, var_de9b655923cddf60 );
}

// Namespace gamelogic_zm
// Params 5
// Checksum 0xa53c9b3b, Offset: 0xee02
// Size: 0x55d
function endgame_regularmp( winner, endreasontext, endreasontextloss, nukedetonated = 0, var_de9b655923cddf60 )
{
    if ( !isbrgamemode() && level.gameended )
    {
        return;
    }
    
    if ( game[ "roundsPlayed" ] < 24 )
    {
        setmatchdata( "utcRoundEndTimeSeconds", game[ "roundsPlayed" ], getsystemtime() );
    }
    
    utility::trycall( level.matchdata_onroundend );
    skipscoring = 0;
    
    if ( level.hostforcedend || level.forcedend )
    {
        skipscoring = 1;
    }
    
    if ( game_utility_mp::inovertime() )
    {
        if ( game[ "overtimeRoundsPlayed" ] == 0 )
        {
            setmatchdata( "firstOvertimeRoundIndex", game[ "roundsPlayed" ] );
        }
        
        if ( !skipscoring )
        {
            game[ "overtimeRoundsPlayed" ]++;
        }
    }
    
    if ( function_598b3aad1aa54a90() )
    {
        if ( team_utility::isgameplayteam( winner ) )
        {
            if ( !skipscoring )
            {
                if ( isdefined( var_de9b655923cddf60 ) )
                {
                    game[ "roundsWon" ][ winner ] = game[ "roundsWon" ][ winner ] + var_de9b655923cddf60;
                }
                else
                {
                    game[ "roundsWon" ][ winner ]++;
                }
            }
            
            if ( !isdefined( level.finalkillcam_winner ) )
            {
                level.finalkillcam_winner = winner;
            }
        }
        else
        {
            if ( winner == "tie" && shouldmodescoreonties() )
            {
                foreach ( entry in level.teamnamelist )
                {
                    game[ "roundsWon" ][ entry ]++;
                }
            }
            
            if ( !isdefined( level.finalkillcam_winner ) )
            {
                level.finalkillcam_winner = "none";
            }
        }
        
        if ( !game[ "practiceRound" ] )
        {
            foreach ( entry in level.teamnamelist )
            {
                gamescore::updateteamscore( entry );
            }
            
            if ( game_utility_mp::isroundbased() && game[ "roundsPlayed" ] < 24 && game_utility::getgametype() != "koth" )
            {
                setmatchdata( "alliesRoundScore", game[ "roundsPlayed" ], getteamscore( "allies" ) );
                setmatchdata( "axisRoundScore", game[ "roundsPlayed" ], getteamscore( "axis" ) );
            }
        }
    }
    else
    {
        if ( isplayer( winner ) && !skipscoring )
        {
            if ( !isdefined( game[ "roundsWon" ][ winner.guid ] ) )
            {
                game[ "roundsWon" ][ winner.guid ] = 0;
            }
            
            game[ "roundsWon" ][ winner.guid ]++;
        }
        
        if ( !isdefined( level.finalkillcam_winner ) && level.finalkillcamenabled )
        {
            if ( !isdefined( winner ) || isstring( winner ) && ( winner == "tie" || winner == "none" ) )
            {
                level.finalkillcam_winner = "none";
            }
            else
            {
                level.finalkillcam_winner = winner.guid;
            }
        }
    }
    
    gamescore::updateplacement();
    
    if ( !skipscoring )
    {
        game[ "roundsPlayed" ]++;
    }
    
    level.playovertime = game_utility_mp::shouldplayovertime();
    
    if ( game_utility_mp::nextroundisfinalround() )
    {
        game[ "finalRound" ] = 1;
    }
    else if ( game_utility_mp::nextroundismatchpoint() )
    {
        game[ "matchPoint" ] = 1;
    }
    
    if ( isdefined( winner ) && game_utility_mp::waslastround() )
    {
        winner = checkmodeoverridetie( winner );
    }
    
    level.ctfnukeended = nukedetonated && game_utility::getgametype() == "ctf";
    
    if ( isdefined( winner ) && level.ctfnukeended )
    {
        otherteam = winner == "allies" ? "axis" : "allies";
        game[ "roundsWon" ][ winner ] = 1;
        game[ "roundsWon" ][ otherteam ] = 0;
        game[ "teamScores" ][ winner ] = 1;
        game[ "teamScores" ][ otherteam ] = 0;
        setteamscore( winner, 1 );
        setteamscore( otherteam, 0 );
    }
    
    processgameend = endgame_endround( winner, endreasontext, endreasontextloss, nukedetonated );
    
    foreach ( player in level.players )
    {
        if ( !isbot( player ) && isdefined( player.team ) && player.team != "spectator" && player.team != "codcaster" )
        {
            logendofround( player );
        }
    }
    
    if ( processgameend && game_utility_mp::waslastround() )
    {
        endgame_endgame( winner, endreasontext, endreasontextloss, nukedetonated );
    }
}

// Namespace gamelogic_zm
// Params 0
// Checksum 0x73fd8096, Offset: 0xf367
// Size: 0xa, Type: bool
function shouldmodescoreonties()
{
    return istrue( game[ "canScoreOnTie" ] );
}

// Namespace gamelogic_zm
// Params 1
// Checksum 0x910425fd, Offset: 0xf37a
// Size: 0xc2
function checkmodeoverridetie( winner )
{
    var_24265de0351e4987 = shouldmodescoreonties() && winner == "tie";
    ctftie = game_utility::getgametype() == "ctf" && winner == "tie" && !level.winrule;
    
    if ( var_24265de0351e4987 || ctftie )
    {
        gamescore::updatetotalteamscore( "axis" );
        gamescore::updatetotalteamscore( "allies" );
        alliesscore = getteamscore( "allies" );
        axisscore = getteamscore( "axis" );
        
        if ( alliesscore != axisscore )
        {
            winner = alliesscore > axisscore ? "allies" : "axis";
        }
    }
    
    return winner;
}

// Namespace gamelogic_zm
// Params 0
// Checksum 0xd2367fc8, Offset: 0xf445
// Size: 0x19b
function endgame_showkillcam()
{
    if ( level.nukeinfo.detonated )
    {
        return;
    }
    
    if ( level.brdisablefinalkillcam )
    {
        return;
    }
    
    if ( getdvarint( @"hash_166b51bf7450fc22", 0 ) == 1 )
    {
        return;
    }
    
    if ( level.skipfinalkillcam )
    {
        return;
    }
    
    flags::levelflagwait( "final_killcam_preloaded" );
    
    if ( level.finalkillcamenabled )
    {
        doingkillcam = isdefined( level.finalkillcam_winner );
        
        if ( doingkillcam )
        {
            doingkillcam = level final_killcam::dofinalkillcam();
        }
        
        if ( isdefined( doingkillcam ) && !doingkillcam )
        {
            postroundfadenokillcam();
        }
        
        return;
    }
    
    if ( level.potgenabled )
    {
        potgscene = potg::getcurpotgscene();
        
        if ( isdefined( potgscene.primaryentity ) )
        {
            foreach ( player in level.players )
            {
                if ( !player iscodcaster() )
                {
                    continue;
                }
                
                player setclientomnvar( "ui_killcam_killedby_health_ratio", potgscene.playerhealthratio );
            }
            
            level final_killcam::dopotgkillcam();
        }
        else
        {
            level.finalkillcamenabled = 1;
            doingkillcam = level final_killcam::dofinalkillcam();
            
            if ( isdefined( doingkillcam ) && !doingkillcam )
            {
                postroundfadenokillcam();
            }
        }
        
        return;
    }
    
    assertmsg( "<dev string:xa17>" );
}

// Namespace gamelogic_zm
// Params 0
// Checksum 0x329bf19f, Offset: 0xf5e8
// Size: 0xf4
function postroundfadenokillcam()
{
    foreach ( player in level.players )
    {
        if ( isbot( player ) )
        {
            continue;
        }
        
        if ( level.gametype == "arena" )
        {
            player setclientomnvar( "post_game_state", 1 );
        }
        else if ( level.gametype == "zm_rb" || level.gametype == "zm_grief" )
        {
            player setclientomnvar( "post_game_state", 5 );
        }
        else
        {
            player setclientomnvar( "post_game_state", 2 );
        }
        
        player thread predictandclearintermissionstreaming();
    }
    
    wait 0.5;
}

// Namespace gamelogic_zm
// Params 0
// Checksum 0x3a9e8f1f, Offset: 0xf6e4
// Size: 0x4e
function predictandclearintermissionstreaming()
{
    self endon( #"disconnect" );
    intermissionloc = playerlogic::getspectatepoint();
    self predictstreamposuntilcleared( intermissionloc.origin );
    
    while ( self.sessionstate != "intermission" )
    {
        waitframe();
    }
    
    waitframe();
    self clearpredictedstreampos();
}

// Namespace gamelogic_zm
// Params 1
// Checksum 0xaa553a4a, Offset: 0xf73a
// Size: 0x3f
function setgameendflagsandnotifies( winner )
{
    game[ "state" ] = "postgame";
    level notify( #"game_ended", winner );
    flags::levelflagset( "game_over" );
    flags::levelflagset( "block_notifies" );
}

// Namespace gamelogic_zm
// Params 1
// Checksum 0xe03d405a, Offset: 0xf781
// Size: 0x39
function function_442747bb1b929abf( player )
{
    deadliest_weapon_ai::function_c588b98a77b1e36a( player, level.var_6f9b00680ed002d8 );
    function_f8889f49a761d327( player );
    function_aef8211f6eecb301( player );
    common::onplayerdisconnectcommon( player );
}

// Namespace gamelogic_zm
// Params 1
// Checksum 0xc42d48ef, Offset: 0xf7c2
// Size: 0x44
function endgame_luidecisionreceived( value )
{
    if ( isdefined( value ) )
    {
        if ( value == 1 || value == 2 )
        {
            level._waitforlui = 0;
            level._luidecision = value;
            level notify( #"hash_997055096957f13c" );
        }
    }
}

// Namespace gamelogic_zm
// Params 4
// Checksum 0x31d2974c, Offset: 0xf80e
// Size: 0x9af, Type: bool
function endgame_endround( winner, endreasontext, endreasontextloss, nukedetonated )
{
    level.gameendtime = gettime();
    level.gameended = 1;
    level.ingraceperiod = 0;
    level.doeomcombat = 0;
    
    if ( !isdefined( winner ) )
    {
        if ( game_utility_mp::isroundbased() )
        {
            level.forcedend = 1;
        }
        
        return true;
    }
    
    if ( getdvarint( @"scr_eom_combat" ) )
    {
        if ( game_utility_mp::waslastround() && game_utility::getgametype() != "arena" )
        {
            level.doeomcombat = 1;
        }
    }
    
    updateleaderboardstats();
    waitframe();
    gamescore::updateplacement();
    level.recordfinalkillcam = 0;
    level.ignorescoring = 1;
    thread potg::onroundended( winner );
    thread final_killcam::preloadfinalkillcam();
    level notify( #"hash_7ddc80b0350bfe28" );
    
    if ( game_utility_mp::isteamreviveenabled() )
    {
        thread teamrevive::function_e0b166703b9fff08();
    }
    
    if ( game_utility_mp::waslastround() )
    {
        level notify( #"hash_fd59437961aec2ea", winner );
        
        if ( level.postgameexfil && !level.forcedend )
        {
            if ( winner != "tie" )
            {
                level waittill( #"exfil_continue_game_end" );
            }
        }
    }
    else
    {
        level notify( #"round_end_music", winner );
    }
    
    if ( level.doeomcombat )
    {
        if ( level.docmdoutro )
        {
            thread waitforhitmarkerspostgame();
            setgameendflagsandnotifies( winner );
            level waittill( #"hash_65e35697cd95016e" );
            setomnvarforallclients( "post_game_state", 2 );
            
            foreach ( player in level.players )
            {
                if ( level.teambased )
                {
                    player thread hud_message::teamoutcomenotify( winner, 0, endreasontext, endreasontextloss );
                    continue;
                }
                
                player thread hud_message::outcomenotify( winner, 0, endreasontext, endreasontextloss );
            }
            
            freezeallplayers( 3, @"cg_fovscale", 1, 1 );
            hostmigration::waitlongdurationwithhostmigrationpause( 3 );
        }
        else if ( isbrgamemode() )
        {
            thread eomcombatwaitforhitmarkersanddelaystartpostgameui( winner, endreasontext, endreasontextloss );
            game[ "state" ] = "postgame";
            level notify( #"game_ended", winner );
            flags::levelflagset( "game_over" );
            flags::levelflagset( "block_notifies" );
            waitframe();
        }
        else
        {
            thread eomcombatwaitforhitmarkersanddelaystartpostgameui( winner, endreasontext, endreasontextloss );
            freezeallplayers( 2.5, @"cg_fovscale", 1, 1 );
            hostmigration::waitlongdurationwithhostmigrationpause( 2.5 );
            setgameendflagsandnotifies( winner );
            waitframe();
        }
        
        foreach ( player in level.players )
        {
            if ( endreasontext != game[ "end_reason" ][ "server_quit" ] )
            {
                player setclientdvar( @"ui_opensummary", 1 );
            }
            
            if ( game_utility_mp::wasonlyround() || game_utility_mp::waslastround() )
            {
                player killstreaks::clearkillstreaks();
                player bounty::playerresetbountystreak();
            }
            
            player setclientomnvar( "ui_match_in_progress", 0 );
        }
    }
    else
    {
        thread waitforhitmarkerspostgame();
        setgameendflagsandnotifies( winner );
        waitframe();
        
        foreach ( player in level.players )
        {
            if ( endreasontext != game[ "end_reason" ][ "server_quit" ] )
            {
                player setclientdvar( @"ui_opensummary", 1 );
            }
            
            if ( ( game_utility_mp::wasonlyround() || game_utility_mp::waslastround() ) && !game[ "isLaunchChunk" ] )
            {
                player killstreaks::clearkillstreaks();
                player bounty::playerresetbountystreak();
            }
            
            player setclientomnvar( "ui_match_in_progress", 0 );
        }
        
        freezeallplayers( 1, @"cg_fovscale", 1, 0 );
    }
    
    setgameendtime( 0 );
    thread analyticslog::logevent_sendplayerindexdata();
    
    if ( level.var_98dc8a7195ec7c4b ?? analyticslog::function_c0d649dd2c6fbce5() )
    {
        analyticslog::analyticsstorespawndata();
    }
    
    clearmatchhasmorethan1playervariablesonroundend();
    
    if ( isdefined( level.matchrecording_dump ) )
    {
        [[ level.matchrecording_dump ]]();
    }
    
    rankedmatchupdates( winner );
    setdvar( @"g_deadchat", 1 );
    setdvar( @"ui_allow_teamchange", 0 );
    
    /#
        sendscriptusageanalysisdata( 1, 1 );
    #/
    
    foreach ( player in level.players )
    {
        player class::loadout_clearperks();
    }
    
    if ( game[ "practiceRound" ] && !level.forcedend )
    {
        game[ "roundsPlayed" ] = 0;
        
        foreach ( team in level.teamnamelist )
        {
            game[ "roundsWon" ][ team ] = 0;
            game[ "teamScores" ][ team ] = 0;
        }
        
        winner = "tie";
        endreasontext = game[ "end_reason" ][ "practice_round_over" ];
    }
    
    displayroundend( winner, endreasontext, endreasontextloss );
    level thread endofroundvisionset( level.roundenddelay - 1 );
    roundendwait( level.roundenddelay, 1 );
    level notify( #"game_cleanup" );
    endgame_showkillcam();
    setslowmotion( 1, 1, 0 );
    resetsoundtimescalefactor();
    
    if ( game[ "practiceRound" ] && !level.forcedend )
    {
        game[ "practiceRound" ] = 0;
        
        if ( level.allowsupers && !game_utility_mp::runleanthreadmode() )
        {
            foreach ( player in level.players )
            {
                player supers_mp::clearsuper();
                player perkpackage::perkpackage_reset();
            }
        }
        
        flags::levelflagclear( "block_notifies" );
        restart();
        return false;
    }
    else
    {
        if ( level.teambased )
        {
            foreach ( entry in level.teamnamelist )
            {
                gamescore::updatetotalteamscore( entry );
            }
        }
        
        if ( !game_utility_mp::wasonlyround() )
        {
            if ( !game_utility_mp::waslastround() )
            {
                if ( level.playovertime )
                {
                    winner = "overtime";
                    game[ "status" ] = "overtime";
                }
                
                flags::levelflagclear( "block_notifies" );
                shouldswitchsides = checkroundswitch( level.playovertime );
                
                if ( shouldswitchsides )
                {
                    onroundswitch( level.playovertime );
                }
                
                if ( shouldswitchsides || game[ "finalRound" ] == 1 || game[ "matchPoint" ] == 1 )
                {
                    shoulddisplayroundswitch = 1;
                    
                    if ( game_utility::getgametype() == "arena" )
                    {
                        if ( game_utility_mp::shouldplaywinbytwo() )
                        {
                        }
                        else if ( game[ "matchPoint" ] == 1 && !game[ "displayedMatchPoint" ] )
                        {
                            game[ "displayedMatchPoint" ] = 1;
                        }
                        else if ( game[ "finalRound" ] != 1 )
                        {
                            shoulddisplayroundswitch = 0;
                        }
                    }
                    
                    if ( shoulddisplayroundswitch )
                    {
                        displayroundswitch();
                    }
                }
                
                foreach ( player in level.players )
                {
                    player.pers[ "stats" ] = player.stats;
                    
                    if ( isalive( player ) && isdefined( player.matchdatalifeindex ) )
                    {
                        player utility::trycall( level.var_57b96262c7666f9b, player.matchdatalifeindex, undefined, undefined, "MOD_ROUND_ENDED", "none", undefined, undefined );
                    }
                }
                
                restart();
                return false;
            }
            
            if ( !level.forcedend )
            {
                endreasontext = updateroundendreasontext( winner );
            }
        }
    }
    
    return true;
}

// Namespace gamelogic_zm
// Params 2
// Checksum 0x1dfb6f36, Offset: 0x101c6
// Size: 0x14c
function tacopsroundendwait( defaultdelay, matchbonus )
{
    notifiesdone = 0;
    
    while ( !notifiesdone )
    {
        players = level.players;
        notifiesdone = 1;
        
        foreach ( player in players )
        {
            if ( !player hud_message::isdoingsplash() )
            {
                continue;
            }
            
            notifiesdone = 0;
        }
        
        wait 0.5;
    }
    
    foreach ( player in level.players )
    {
        player thread game_utility_mp::setuipostgamefade( 0 );
    }
    
    wait defaultdelay;
    setomnvarforallclients( "post_game_state", 1 );
    level notify( #"round_end_finished" );
}

// Namespace gamelogic_zm
// Params 2
// Checksum 0xe79e8dc3, Offset: 0x1031a
// Size: 0x2c, Type: bool
function compare_player_score( left, right )
{
    return left.score >= right.score;
}

// Namespace gamelogic_zm
// Params 4
// Checksum 0x9a35f068, Offset: 0x1034f
// Size: 0x836
function endgame_endgame( winner, endreasontext, endreasontextloss, nukedetonated )
{
    canceljoins();
    setnojipscore( 1, 1 );
    setnojiptime( 1, 1 );
    
    if ( br_public::isbrpracticemode() && !level.forcedend )
    {
        level._waitforlui = 1;
        level ui::lui_registercallback( "exit_squad_eliminated", &endgame_luidecisionreceived );
    }
    
    if ( game_utility_mp::matchmakinggame() )
    {
        requestgamelobbyremainintact();
    }
    
    if ( !level.processedwinloss && ( level.forfeitinprogress || level.forcedend ) )
    {
        updatewinlossstats( winner );
    }
    
    checkforpersonalbests();
    updatespmstats();
    persistence::writebestscores();
    level notify( #"hash_5b8a8903d2af7a11" );
    updateleaderboardstats();
    level accolades::evaluateallaccolades();
    level notify( #"spawning_intermission" );
    intermissionspawnpointoverride = getintermissionspawnpointoverride();
    
    foreach ( player in level.players )
    {
        player thread game_utility_mp::setuipostgamefade( 0 );
        
        if ( !isdefined( level.modespawnendofgame ) || !player [[ level.modespawnendofgame ]]() )
        {
            player thread playerlogic::spawnintermission( intermissionspawnpointoverride );
        }
    }
    
    if ( nukedetonated && !level.nukeinfo.cancelled )
    {
        player::_visionsetnaked( level.nukeinfo.visionset, 0 );
        visionsetfadetoblack( "", 0.75 );
    }
    else
    {
        player::_visionsetnaked( "", 0 );
        visionsetfadetoblack( "", 0.75 );
    }
    
    displaygameend( winner, endreasontext, endreasontextloss );
    flags::levelflagclear( "block_notifies" );
    level.intermission = 1;
    zm_player::invalidate_all_players();
    
    if ( endreasontext != game[ "end_reason" ][ "server_quit" ] )
    {
        setomnvarforallclients( "post_game_state", 5 );
    }
    
    if ( endreasontext == game[ "end_reason" ][ "ended_game" ] || endreasontext == game[ "end_reason" ][ "host_ended_game" ] )
    {
        setomnvarforallclients( "ui_br_squad_eliminated_active", 1 );
        
        foreach ( player in level.players )
        {
            player playlocalsound( #"hash_38bb00fcb53eb873" );
        }
    }
    
    roundendwait( level.postroundtime, 1 );
    
    if ( !isbrgamemode() || game_utility::getgametype() == "dmz" || game_utility::getgametype() == "plunder" || game_utility::getgametype() == "kingslayer" || game_utility_mp::isprophuntgametype() )
    {
        processlobbydata();
    }
    
    if ( level.teambased )
    {
        if ( team_utility::isgameplayteam( winner ) )
        {
            setmatchdata( "victor", winner );
            topplayers = arraysort( teams::getteamdata( winner, "players" ), undefined, &compare_player_score );
        }
        else
        {
            setmatchdata( "victor", "none" );
            topplayers = level.placement[ "all" ];
        }
        
        setmatchdata( "alliesScore", getteamscore( "allies" ) );
        setmatchdata( "axisScore", getteamscore( "axis" ) );
    }
    else
    {
        setmatchdata( "victor", "none" );
        topplayers = level.placement[ "all" ];
    }
    
    playerendmatch();
    level callback::callback( #"game_ended", { #winner:winner } );
    
    foreach ( player in level.players )
    {
        telemetry_utils::function_c54601d44e7b8e8a( player );
        player setplayerdata( "common", "round", "endReasonTextIndex", endreasontext );
        eventparams = [];
        function_b7a1afe79c577a08( player, eventparams );
        player game_utility::stopkeyearning( winner, eventparams );
        params = spawnstruct();
        params.player = player;
        params.endreason = endreasontext;
        params.winner = winner;
        level callback::callback( "player_match_end", params );
        
        if ( isalive( player ) && isdefined( player.matchdatalifeindex ) )
        {
            player utility::trycall( level.var_57b96262c7666f9b, player.matchdatalifeindex, undefined, undefined, "MOD_GAME_ENDED", "none", undefined, undefined );
        }
        
        player utility::trycall( level.matchdata_logplayerdata );
    }
    
    utility::trycall( level.matchdata_recordrecentlyplayeddata );
    sendendofmatchdata( endreasontext );
    function_e4456500a1573b18();
    
    foreach ( player in level.players )
    {
        player.pers[ "stats" ] = player.stats;
    }
    
    if ( game[ "isLaunchChunk" ] )
    {
        wait 1;
    }
    else if ( !nukedetonated && !level.postgamenotifies )
    {
        if ( !game_utility_mp::wasonlyround() )
        {
            wait 6;
        }
        else
        {
            wait min( 5, 4 + level.postgamenotifies );
        }
    }
    else
    {
        wait min( 10, 4 + level.postgamenotifies );
    }
    
    settournamentwinner( winner );
    setomnvarforallclients( "post_game_state", 1 );
    flags::levelflagwaitopen( "post_game_level_event_active" );
    
    if ( game[ "isLaunchChunk" ] )
    {
        flags::levelflagclear( "block_notifies" );
        game[ "launchChunkWinner" ] = 1;
        game[ "timePassed" ] = 0;
        game[ "roundsPlayed" ] = 0;
        game[ "overtimeRoundsPlayed" ] = 0;
        game[ "matchPoint" ] = 0;
        game[ "finalRound" ] = 0;
        game[ "gamestarted" ] = undefined;
        game[ "previousWinningTeam" ] = "";
        
        foreach ( team in level.teamnamelist )
        {
            game[ "roundsWon" ][ team ] = 0;
            game[ "teamScores" ][ team ] = 0;
            setteamscore( team, int( 0 ) );
        }
        
        if ( game[ "launchChunkRuleSet" ] == 3 )
        {
            if ( isdefined( level.droplaunchchunkbots ) )
            {
                level [[ level.droplaunchchunkbots ]]();
            }
            
            wait 1;
        }
        
        if ( !level.hostforcedend && !level.forcedend )
        {
            restart();
            return 0;
        }
    }
    
    level notify( #"exitlevel_called" );
    
    if ( br_public::isbrpracticemode() && isdefined( level._luidecision ) && level._luidecision == 2 )
    {
        bots::drop_bots( 1, level.player.team );
        gamelogic_mp::restart();
        return;
    }
    
    exitlevel( 0 );
}

// Namespace gamelogic_zm
// Params 2
// Checksum 0xaef67002, Offset: 0x10b8d
// Size: 0x4d
function function_b7a1afe79c577a08( player, eventparams )
{
    if ( utility::issharedfuncdefined( #"hash_7305513195fadf7e", #"hash_134d493924be6c4" ) )
    {
        eventparams = utility::callsharedfunc( #"hash_7305513195fadf7e", #"hash_134d493924be6c4", player, eventparams );
    }
}

// Namespace gamelogic_zm
// Params 1
// Checksum 0xd9e33f06, Offset: 0x10be2
// Size: 0xb6
function sendendofmatchdata( endreasontext )
{
    if ( !isdefined( level.endofmatchdatasent ) )
    {
        zm_telemetry::zm_telemetry_match_end( endreasontext );
        
        if ( getdvarint( @"online_matchdata_enabled" ) != 0 )
        {
            setmatchdata( "host", level.hostname );
            
            if ( game_utility_mp::matchmakinggame() )
            {
                setmatchdata( "playlistVersion", getplaylistversion() );
                setmatchdata( "playlistID", getplaylistid() );
                setmatchdata( "playlist_name", getplaylistname() );
                setmatchdata( "isDedicated", isdedicatedserver() );
                setmatchdata( "party_maxplayers", getdvarint( @"party_maxplayers", 0 ) );
            }
            
            onmatchend();
            sendmatchdata();
        }
    }
    
    level.endofmatchdatasent = 1;
}

// Namespace gamelogic_zm
// Params 1
// Checksum 0x933527ff, Offset: 0x10ca0
// Size: 0xa9
function settournamentwinner( winner )
{
    if ( !isdefined( winner ) )
    {
        return;
    }
    
    if ( !function_598b3aad1aa54a90() )
    {
        dotournamentendgame( winner );
        return;
    }
    else if ( winner != "allies" && winner != "axis" )
    {
        numallies = teams::getteamdata( "allies", "players" );
        numaxis = teams::getteamdata( "axis", "players" );
        
        if ( numallies.size == 0 )
        {
            winner = "axis";
        }
        else if ( numaxis.size == 0 )
        {
            winner = "allies";
        }
        else
        {
            winner = getbetterteam();
        }
    }
    
    dotournamentendgame( winner );
}

// Namespace gamelogic_zm
// Params 0
// Checksum 0x91292c83, Offset: 0x10d51
// Size: 0x24
function waitforhitmarkerspostgame()
{
    wait level.postgamehitmarkerwaittime;
    level notify( #"hash_bd6935872ca1b8ee" );
    setomnvarforallclients( "post_game_state", 1 );
}

// Namespace gamelogic_zm
// Params 3
// Checksum 0x705b4af3, Offset: 0x10d7d
// Size: 0x117
function eomcombatwaitforhitmarkersanddelaystartpostgameui( winner, endreasontext, endreasontextloss )
{
    wait level.postgamehitmarkerwaittime;
    level notify( #"hash_bd6935872ca1b8ee" );
    
    if ( endreasontext != game[ "end_reason" ][ "server_quit" ] )
    {
        if ( issubstr( level.gametype, "zm_" ) )
        {
            setomnvarforallclients( "post_game_state", 5 );
        }
        else if ( !isbrgamemode() )
        {
            setomnvarforallclients( "post_game_state", 2 );
        }
    }
    
    foreach ( player in level.players )
    {
        if ( function_598b3aad1aa54a90() )
        {
            player thread hud_message::teamoutcomenotify( winner, 0, endreasontext, endreasontextloss );
            continue;
        }
        
        player thread hud_message::outcomenotify( winner, 0, endreasontext, endreasontextloss );
    }
}

// Namespace gamelogic_zm
// Params 0
// Checksum 0xd6b52c3b, Offset: 0x10e9c
// Size: 0x15e
function getintermissionspawnpointoverride()
{
    spawnpoint = undefined;
    
    switch ( level.mapname )
    {
        case #"hash_a62df42a13dad323":
            spawnpoint = spawnstruct();
            spawnpoint.origin = ( 1478, -3039, 981 );
            spawnpoint.angles = ( 388.74, 144.97, 0 );
            break;
        case #"hash_81c63d549bea3339":
            spawnpoint = spawnstruct();
            spawnpoint.origin = ( 1835, 1347, 749 );
            spawnpoint.angles = ( 361, 224, 0 );
            break;
        case #"hash_8eb456b9e1d842c7":
            spawnpoint = spawnstruct();
            spawnpoint.origin = ( -871, -1578, 458 );
            spawnpoint.angles = ( 6, 65, 0 );
            break;
    }
    
    if ( game_utility::getgametype() == "brtdm" )
    {
        spawnpoint = spawnstruct();
        spawnpoint.origin = level.brtdm_config.spectatepoint.origin;
        spawnpoint.angles = level.brtdm_config.spectatepoint.angles;
    }
    
    return spawnpoint;
}

// Namespace gamelogic_zm
// Params 1
// Checksum 0xa72fa7f9, Offset: 0x11003
// Size: 0x220
function eomcamerapullout( delay )
{
    if ( delay > 0 )
    {
        wait delay;
    }
    
    foreach ( player in level.players )
    {
        if ( !player player::isreallyalive() )
        {
            continue;
        }
        
        player val::set( "eomCameraPullOut", "ads", 0 );
        startpos = player geteye() + ( 0, 0, 1 ) * 100 + anglestoforward( player.angles ) * -100;
        cameraent = spawn( "script_model", startpos );
        cameraent setmodel( "tag_origin" );
        cameraent.angles = player.angles;
        player.spawncameraent = cameraent;
        targetpos = player geteye();
        targetangles = player.angles;
        aerialpos = startpos + ( 0, 0, 5000 );
        aerialpos += anglestoforward( targetangles ) * -100;
        player cameralinkto( player.spawncameraent, "tag_origin", 1, 1 );
        player.spawncameraent moveto( aerialpos, 5, 4, 0.1 );
        fwd = vectornormalize( targetpos - cameraent.origin );
        goalangles = script::vectortoanglessafe( fwd, ( 0, 0, 1 ) );
        player.spawncameraent.angles = goalangles;
        player thread lookatplayerupdate( targetangles );
        wait 2;
        player visionsetnakedforplayer( "respawn_camera", 2 );
    }
}

// Namespace gamelogic_zm
// Params 1
// Checksum 0x73c6a285, Offset: 0x1122b
// Size: 0x96
function lookatplayerupdate( initialangle )
{
    self endon( #"disconnect" );
    self endon( #"hash_78d3c66679c43e4" );
    
    while ( true )
    {
        targetpos = self geteye();
        fwd = vectornormalize( targetpos - self.spawncameraent.origin );
        goalangles = script::vectortoanglessafe( fwd, ( 0, 0, 1 ) );
        self.spawncameraent rotateto( goalangles, 0.75 );
        waitframe();
    }
}

// Namespace gamelogic_zm
// Params 1
// Checksum 0x609137d9, Offset: 0x112c9
// Size: 0xa8
function updateroundendreasontext( winner )
{
    if ( !level.teambased )
    {
        return 1;
    }
    
    if ( level.gametypebundle.scoringstrategy == #"teamscores" )
    {
        if ( game_utility_mp::hitscorelimit() )
        {
            return game[ "end_reason" ][ "score_limit_reached" ];
        }
        
        if ( game_utility_mp::hittimelimit() )
        {
            return game[ "end_reason" ][ "time_limit_reached" ];
        }
    }
    else if ( game_utility_mp::hitroundlimit() )
    {
        return game[ "end_reason" ][ "round_limit_reached" ];
    }
    
    if ( game_utility_mp::hitwinlimit() )
    {
        return game[ "end_reason" ][ "score_limit_reached" ];
    }
    
    return game[ "end_reason" ][ "objective_completed" ];
}

// Namespace gamelogic_zm
// Params 1
// Checksum 0xcbed7714, Offset: 0x1137a
// Size: 0xaf
function estimatedtimetillscorelimit( team )
{
    assert( isplayer( self ) || isdefined( team ) );
    
    if ( level.gametypebundle.scoringstrategy != #"teamscores" )
    {
        scoreperminute = getscoreperminute( team );
        scoreremaining = getscoreremaining( team );
        var_bc0480f444894cac = 999999;
        
        if ( scoreperminute )
        {
            var_bc0480f444894cac = scoreremaining / scoreperminute;
        }
        
        return var_bc0480f444894cac;
    }
    
    scoreperminute = getscoreperminute( team );
    scoreremaining = getscoreperminute( team );
    var_bc0480f444894cac = 999999;
    
    if ( scoreperminute )
    {
        var_bc0480f444894cac = scoreremaining / scoreperminute;
    }
    
    return var_bc0480f444894cac;
}

// Namespace gamelogic_zm
// Params 1
// Checksum 0x5b19a1db, Offset: 0x11431
// Size: 0xeb, Type: bool
function closetoscorelimit( team )
{
    assert( isplayer( self ) || isdefined( team ) );
    checkroundlimit = 10;
    var_a6f903ff6a32f2a9 = 20;
    scorelimit = level.roundscorelimit;
    
    switch ( game_utility::getgametype() )
    {
        case #"hash_3a17de6e294210d2":
        case #"hash_f4a9126c03d3385b":
            var_a6f903ff6a32f2a9 = 20;
            break;
        case #"hash_ea061d29bbd1f237":
            var_a6f903ff6a32f2a9 = 10;
        case #"hash_ca6516c10db2c95":
            var_a6f903ff6a32f2a9 = scorelimit * 0.1;
            break;
        default:
            break;
    }
    
    teamscore = getteamscore( team );
    var_d262c35ec7ded597 = scorelimit - teamscore;
    
    if ( var_d262c35ec7ded597 <= ( game[ "finalRound" ] ? var_a6f903ff6a32f2a9 : checkroundlimit ) )
    {
        return true;
    }
    
    return false;
}

// Namespace gamelogic_zm
// Params 1
// Checksum 0xb92fda8c, Offset: 0x11525
// Size: 0x6a
function getscoreperminute( team )
{
    assert( isplayer( self ) || isdefined( team ) );
    minutespassed = game_utility::gettimepassed() / 60000 + 0.0001;
    
    if ( isplayer( self ) )
    {
        scoreperminute = self.score / minutespassed;
    }
    else
    {
        scoreperminute = getteamscore( team ) / minutespassed;
    }
    
    return scoreperminute;
}

// Namespace gamelogic_zm
// Params 1
// Checksum 0x71550005, Offset: 0x11598
// Size: 0x63
function getscoreremaining( team )
{
    assert( isplayer( self ) || isdefined( team ) );
    scorelimit = level.roundscorelimit;
    
    if ( isplayer( self ) )
    {
        scoreremaining = scorelimit - self.score;
    }
    else
    {
        scoreremaining = scorelimit - getteamscore( team );
    }
    
    return scoreremaining;
}

// Namespace gamelogic_zm
// Params 1
// Checksum 0x676ef970, Offset: 0x11604
// Size: 0xa7
function getscoreperminuteroundbased( team )
{
    scorelimit = level.roundscorelimit;
    
    if ( !game[ "switchedsides" ] )
    {
        scorelimit /= 2;
        minutespassed = game_utility::gettimepassed() / 60000 + 0.0001;
        scoreperminute = getteamscore( team ) / minutespassed;
    }
    else
    {
        scorelimit = int( scorelimit / 2 );
        minutespassed = game_utility::gettimepassed() / 60000 + 0.0001;
        teamscore = getteamscore( team );
        
        if ( teamscore >= scorelimit )
        {
            scoreperminute = ( teamscore - scorelimit ) / minutespassed;
        }
        else
        {
            return 0;
        }
    }
    
    return scoreperminute;
}

// Namespace gamelogic_zm
// Params 0
// Checksum 0xe5986495, Offset: 0x116b4
// Size: 0xfa
function givelastonteamwarning()
{
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    player::waittillrecoveredhealth( 3 );
    level thread battlechatter_mp::trysaylocalsound( self, #"bc_status_inform_last_one" );
    thread hud_util::teamplayercardsplash( #"last_teammate_alive_callout", self, self.pers[ "team" ] );
    
    foreach ( teamname in level.teamnamelist )
    {
        if ( self.pers[ "team" ] != teamname )
        {
            thread hud_util::teamplayercardsplash( #"last_enemy_alive_callout", self, teamname );
        }
    }
    
    level notify( #"last_alive", self );
}

// Namespace gamelogic_zm
// Params 1
// Checksum 0xdd51b88, Offset: 0x117b6
// Size: 0x73
function function_aef8211f6eecb301( player )
{
    processlobbydataforclient( player );
    
    if ( getdvarint( @"online_mp_clientmatchdata_enabled" ) != 0 )
    {
        if ( game_utility_mp::matchmakinggame() && !game_utility_mp::privatematch() )
        {
            setclientmatchdata( "isPublicMatch", 1 );
        }
        else
        {
            setclientmatchdata( "isPublicMatch", 0 );
        }
    }
    
    scoreboard::processlobbyscoreboards();
    
    if ( getdvarint( @"online_mp_clientmatchdata_enabled" ) != 0 )
    {
        sendclientmatchdata();
    }
}

// Namespace gamelogic_zm
// Params 1
// Checksum 0x40df2dce, Offset: 0x11831
// Size: 0xee
function processlobbydata( var_b31c15eccd48f95a )
{
    foreach ( player in level.players )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        processlobbydataforclient( player, var_b31c15eccd48f95a );
    }
    
    if ( getdvarint( @"online_mp_clientmatchdata_enabled" ) != 0 )
    {
        if ( game_utility_mp::matchmakinggame() && !game_utility_mp::privatematch() )
        {
            setclientmatchdata( "isPublicMatch", 1 );
        }
        else
        {
            setclientmatchdata( "isPublicMatch", 0 );
        }
    }
    
    scoreboard::processlobbyscoreboards();
    
    if ( getdvarint( @"online_mp_clientmatchdata_enabled" ) != 0 )
    {
        sendclientmatchdata();
    }
}

// Namespace gamelogic_zm
// Params 1
// Checksum 0x4925c9a, Offset: 0x11927
// Size: 0x116
function assignclientmatchdataid( player )
{
    if ( isdefined( player ) && !isdefined( player.clientmatchdataid ) )
    {
        if ( isdefined( level.var_4b2b40aa966ef5a[ player.guid ] ) )
        {
            println( "<dev string:xa71>" + player.guid + "<dev string:xa95>" + level.var_4b2b40aa966ef5a[ player.guid ] );
            player.clientmatchdataid = level.var_4b2b40aa966ef5a[ player.guid ];
            player.overwritematchdata = 1;
            return;
        }
        
        player.clientmatchdataid = level.currentclientmatchdataid;
        level.var_4b2b40aa966ef5a[ player.guid ] = player.clientmatchdataid;
        level.currentclientmatchdataid++;
        println( "<dev string:xa71>" + player.guid + "<dev string:xab9>" + level.var_4b2b40aa966ef5a[ player.guid ] );
    }
}

// Namespace gamelogic_zm
// Params 2
// Checksum 0xe3658723, Offset: 0x11a45
// Size: 0x1f5
function processlobbydataforclient( player, var_b31c15eccd48f95a )
{
    if ( !var_b31c15eccd48f95a )
    {
        if ( player.processlobbydataforclient )
        {
            return;
        }
        
        player.processlobbydataforclient = 1;
    }
    
    assignclientmatchdataid( player );
    playername = player.name;
    
    if ( getdvarint( @"online_mp_clientmatchdata_enabled" ) != 0 )
    {
        setclientmatchdata( "players", player.clientmatchdataid, "clanTag", player getclantag() );
        setclientmatchdata( "players", player.clientmatchdataid, "xuidHigh", player getxuidhigh() );
        setclientmatchdata( "players", player.clientmatchdataid, "xuidLow", player getxuidlow() );
        setclientmatchdata( "players", player.clientmatchdataid, "isBot", isbot( player ) );
        setclientmatchdata( "players", player.clientmatchdataid, "uniqueClientId", player.clientid );
        setclientmatchdata( "players", player.clientmatchdataid, "username", playername );
        
        if ( player function_787b88bd6601ec4a() )
        {
            setclientmatchdata( "players", player.clientmatchdataid, "platform", "ps4" );
        }
        else if ( player function_71b99fed77af9be5() )
        {
            setclientmatchdata( "players", player.clientmatchdataid, "platform", "xb3" );
        }
        else if ( player ispcplayer() )
        {
            setclientmatchdata( "players", player.clientmatchdataid, "platform", "bnet" );
        }
        else
        {
            setclientmatchdata( "players", player.clientmatchdataid, "platform", "none" );
        }
    }
    
    player setplayerdata( "common", "round", "clientMatchIndex", player.clientmatchdataid );
    player scoreboard::setplayerscoreboardinfo();
}

// Namespace gamelogic_zm
// Params 4
// Checksum 0xff859d35, Offset: 0x11c42
// Size: 0x61
function trackleaderboarddeathstats( attacker, victim, objweapon, smeansofdeath )
{
    victim thread threadedsetweaponstatbyname( objweapon, 1, "deaths" );
    victim thread threadedsetweaponstatbyname( objweapon, distancesquared( attacker.origin, victim.origin ), "cumulative_death_distance_sq" );
}

// Namespace gamelogic_zm
// Params 4
// Checksum 0x135039b6, Offset: 0x11cab
// Size: 0x178
function trackattackerleaderboarddeathstats( attacker, victim, sweapon, smeansofdeath )
{
    if ( isplayer( attacker ) )
    {
        if ( smeansofdeath != "MOD_FALLING" && smeansofdeath != "MOD_BUMP" )
        {
            if ( smeansofdeath == "MOD_MELEE" && issubstr( sweapon, "tactical" ) )
            {
                attacker utility::trycall( level.matchdata_logattachmentstat, "tactical", "kills", 1, sweapon );
                attacker utility::trycall( level.matchdata_logattachmentstat, "tactical", "hits", 1, sweapon );
                return;
            }
            
            if ( smeansofdeath == "MOD_MELEE" && !weapon_utility::isriotshield( sweapon ) && !weapon_utility::isknifeonly( sweapon ) && !weapon::isakimbomeleeweapon( sweapon ) && !weapon::function_33e74163843b348e( sweapon ) )
            {
                attacker utility::trycall( level.matchdata_logattachmentstat, "none", "kills", 1, sweapon );
                attacker utility::trycall( level.matchdata_logattachmentstat, "none", "hits", 1, sweapon );
                return;
            }
            
            attacker thread threadedsetweaponstatbyname( sweapon, 1, "kills" );
            attacker thread threadedsetweaponstatbyname( sweapon, distancesquared( attacker.origin, victim.origin ), "cumulative_kill_distance_sq" );
        }
        
        if ( smeansofdeath == "MOD_HEAD_SHOT" )
        {
            attacker thread threadedsetweaponstatbyname( sweapon, 1, "headShots" );
        }
    }
}

// Namespace gamelogic_zm
// Params 3
// Checksum 0xb45bf0, Offset: 0x11e2b
// Size: 0x3e0
function setweaponstat( weapon, incvalue, statname )
{
    if ( !incvalue )
    {
        return;
    }
    
    objweapon = utility::function_64003742d8f5c781( weapon );
    
    if ( !isdefined( objweapon ) )
    {
        return;
    }
    
    objweapon = weapon_utility::function_5ba4049e1c74f6a8( objweapon );
    
    if ( weapon::ispickedupweapon( objweapon ) )
    {
        return;
    }
    
    weaponname = objweapon.basename;
    weapongroup = weapon::getweapongroup( objweapon );
    variantid = getweaponvariantindex( objweapon );
    
    if ( weapongroup == "super" )
    {
        shouldtracksuperweaponstats = supers_mp::shouldtracksuperweaponstats( objweapon );
        
        if ( isdefined( shouldtracksuperweaponstats ) && !shouldtracksuperweaponstats )
        {
            return;
        }
    }
    
    if ( weapongroup == "killstreak" || weapongroup == "other" && weaponname != "trophy_mp" || weapongroup == "other" && weaponname != "player_trophy_system_mp" || weapongroup == "other" && weaponname != "super_trophy_mp" )
    {
        return;
    }
    
    if ( weapon::isenvironmentweapon( objweapon ) )
    {
        return;
    }
    
    if ( weapongroup == "weapon_grenade" || weapongroup == "weapon_explosive" || weaponname == "trophy_mp" || weaponname == "forcepush_mp" )
    {
        weaponname = script::strip_suffix( weaponname, "_mp" );
        persistence::incrementweaponstat( weaponname, statname, incvalue );
        telemetry_data = spawnstruct();
        telemetry_data.weaponname = weaponname;
        telemetry_data.fullweaponname = getcompleteweaponname( objweapon );
        telemetry_data.statname = statname;
        telemetry_data.incvalue = incvalue;
        telemetry_data.variantid = variantid;
        telemetry_utils::function_af2d366f9522f76f( "callback_update_weapon_stats", telemetry_data );
        return;
    }
    
    if ( !isdefined( self.trackingweapon ) )
    {
        self.trackingweapon = objweapon;
    }
    
    if ( objweapon != self.trackingweapon )
    {
        persistence::updateweaponbufferedstats();
        self.trackingweapon = objweapon;
    }
    
    switch ( statname )
    {
        case #"hash_1f658b3efcf092d2":
            self.trackingweaponshots++;
            break;
        case #"hash_7b99e54a94aa5fb":
            self.trackingweaponhits++;
            break;
        case #"hash_297da132d2f8bf70":
            self.trackingweaponheadshots++;
            break;
        case #"hash_f459561578093b3e":
            self.trackingweaponkills++;
            break;
        case #"hash_406d7407b0a31c77":
            self.var_1f7d642d4c800754++;
            break;
    }
    
    if ( statname == "deaths" )
    {
        /#
            if ( getdvarint( @"g_debugdamage" ) )
            {
                println( "<dev string:xabf>" );
            }
        #/
        
        altattachment = undefined;
        weaponrootname = weapon::getweaponrootname( objweapon );
        
        if ( !weapon::iscacprimaryweapon( weaponrootname ) && !weapon::iscacsecondaryweapon( weaponrootname ) )
        {
            return;
        }
        
        attachments = getweaponattachments( objweapon );
        persistence::incrementweaponstat( weaponrootname, statname, incvalue );
        telemetry_data = spawnstruct();
        telemetry_data.weaponname = weaponrootname;
        telemetry_data.fullweaponname = getcompleteweaponname( objweapon );
        telemetry_data.statname = "deaths";
        telemetry_data.incvalue = incvalue;
        telemetry_data.variantid = variantid;
        telemetry_utils::function_af2d366f9522f76f( "callback_update_weapon_stats", telemetry_data );
        
        foreach ( attachment in attachments )
        {
            utility::trycall( level.matchdata_logattachmentstat, attachment, statname, incvalue, objweapon );
        }
    }
}

// Namespace gamelogic_zm
// Params 3
// Checksum 0x30ecabe6, Offset: 0x12213
// Size: 0xd4
function setinflictorstat( einflictor, eattacker, sweapon )
{
    if ( !isdefined( eattacker ) )
    {
        return;
    }
    
    if ( !isdefined( einflictor ) )
    {
        eattacker setweaponstat( sweapon, 1, "hits" );
        return;
    }
    
    if ( !isdefined( einflictor.playeraffectedarray ) )
    {
        einflictor.playeraffectedarray = [];
    }
    
    foundnewplayer = 1;
    
    for ( i = 0; i < einflictor.playeraffectedarray.size ; i++ )
    {
        if ( einflictor.playeraffectedarray[ i ] == self )
        {
            foundnewplayer = 0;
            break;
        }
    }
    
    if ( foundnewplayer )
    {
        einflictor.playeraffectedarray[ einflictor.playeraffectedarray.size ] = self;
        eattacker setweaponstat( sweapon, 1, "hits" );
    }
}

// Namespace gamelogic_zm
// Params 3
// Checksum 0x30a15483, Offset: 0x122ef
// Size: 0x36
function threadedsetweaponstatbyname( objweapon, incvalue, statname )
{
    self endon( #"disconnect" );
    waittillframeend();
    setweaponstat( objweapon, incvalue, statname );
}

// Namespace gamelogic_zm
// Params 0
// Checksum 0x9c84c50b, Offset: 0x1232d
// Size: 0x85
function updatespmstats()
{
    foreach ( player in level.players )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        function_390d913e65520bec( player );
    }
}

// Namespace gamelogic_zm
// Params 1
// Checksum 0x5809db1, Offset: 0x123ba
// Size: 0x219
function function_390d913e65520bec( player )
{
    if ( player game_utility_mp::onlinestatsenabled( "zm" ) )
    {
        spm = getmatchspm( player );
        actualscore = level.teambased ? player.score : player.pers[ "gamemodeScore" ];
        var_6f9b00680ed002d8 = level.var_6f9b00680ed002d8 ?? %"mp";
        globalspm = player getplayerdata( var_6f9b00680ed002d8, "globalSPM" );
        gamesplayed = player playerstats_interface::getplayerstat( "matchStats", "gamesPlayed", undefined, undefined, undefined, "zm" );
        globalspm *= gamesplayed - 1;
        var_aea20424b7be7257 = spm;
        
        if ( gamesplayed > 0 )
        {
            var_aea20424b7be7257 = ( globalspm + spm ) / gamesplayed;
        }
        
        player setplayerdata( var_6f9b00680ed002d8, "globalSPM", int( var_aea20424b7be7257 ) );
        gametypeindex = getgametypeindex( game_utility::getgametype() );
        maxgamemodescorehistory = 5;
        maxgamemodes = 32;
        
        if ( gametypeindex >= 0 && gametypeindex < maxgamemodes )
        {
            for ( i = 0; i < 4 ; i++ )
            {
                prev = player getplayerdata( var_6f9b00680ed002d8, "gameModeHistory", i + 1 );
                player setplayerdata( var_6f9b00680ed002d8, "gameModeHistory", i, prev );
            }
            
            player setplayerdata( var_6f9b00680ed002d8, "gameModeHistory", 4, game_utility::getgametype() );
            scoreindex = player getplayerdata( var_6f9b00680ed002d8, "gameModeScoreHistory", gametypeindex, "index" );
            player setplayerdata( var_6f9b00680ed002d8, "gameModeScoreHistory", gametypeindex, "scores", scoreindex, int( spm ) );
            player setplayerdata( var_6f9b00680ed002d8, "gameModeScoreHistory", gametypeindex, "actualScores", scoreindex, int( actualscore ) );
            player setplayerdata( var_6f9b00680ed002d8, "gameModeScoreHistory", gametypeindex, "gameMode", game_utility::getgametype() );
            scoreindex = ( scoreindex + 1 ) % maxgamemodescorehistory;
            player setplayerdata( var_6f9b00680ed002d8, "gameModeScoreHistory", gametypeindex, "index", scoreindex );
        }
    }
}

// Namespace gamelogic_zm
// Params 1
// Checksum 0x538b3d92, Offset: 0x125db
// Size: 0x4af
function function_f8889f49a761d327( player )
{
    if ( player game_utility_mp::onlinestatsenabled( "zm" ) )
    {
        if ( !player.var_3ed25ea600729b93 )
        {
            game_type = game_utility::getgametype();
            map_name = game_utility::getmapname();
            roundkills = player.kills ?? 0;
            rounddeaths = player.deaths ?? 0;
            roundxp = player.pers[ "summary" ][ "xp" ];
            roundreached = zm_utility::get_round_number();
            roundexfil = player.pers[ "telemetry" ].exfil_success ?? 0;
            var_7f0f5b440e73ef7d = player zm_telemetry::is_join_later_rounds();
            bestkills = player playerstats_interface::getplayerstat( "mapStats", map_name, "modeStats", game_type, "killsInAMatch", "zm" );
            mostdeaths = player playerstats_interface::getplayerstat( "mapStats", map_name, "modeStats", game_type, "deathsInAMatch", "zm" );
            mostxp = player playerstats_interface::getplayerstat( "mapStats", map_name, "modeStats", game_type, "xpInAMatch", "zm" );
            bestround = player playerstats_interface::getplayerstat( "mapStats", map_name, "modeStats", game_type, "highestRound", "zm" );
            mostexfils = player playerstats_interface::getplayerstat( "mapStats", map_name, "modeStats", game_type, "exfils", "zm" );
            
            if ( roundkills > bestkills )
            {
                player playerstats_interface::setplayerstat( roundkills, "mapStats", map_name, "modeStats", game_type, "killsInAMatch", "zm" );
            }
            
            if ( rounddeaths > mostdeaths )
            {
                player playerstats_interface::setplayerstat( rounddeaths, "mapStats", map_name, "modeStats", game_type, "deathsInAMatch", "zm" );
            }
            
            if ( roundxp > mostxp )
            {
                player playerstats_interface::setplayerstat( roundxp, "mapStats", map_name, "modeStats", game_type, "xpInAMatch", "zm" );
            }
            
            if ( !var_7f0f5b440e73ef7d && roundreached > bestround )
            {
                player playerstats_interface::setplayerstat( roundreached, "mapStats", map_name, "modeStats", game_type, "highestRound", "zm" );
            }
            
            if ( roundexfil )
            {
                player playerstats_interface::setplayerstat( mostexfils + 1, "mapStats", map_name, "modeStats", game_type, "exfils", "zm" );
            }
            
            bestspm = player getplayerdata( "mp", "bestSPM", "score" );
            bestkd = player getplayerdata( "mp", "bestKD", "score" );
            kd = roundkills;
            
            if ( rounddeaths > 1 )
            {
                kd /= rounddeaths;
            }
            
            kd = int( kd * 1000 );
            
            if ( kd > bestkd )
            {
                player setplayerdata( "mp", "bestKD", "score", kd );
                player setplayerdata( "mp", "bestKD", "time", getsystemtime() );
            }
            
            spm = getmatchspm( player );
            
            if ( spm > bestspm )
            {
                player setplayerdata( "mp", "bestSPM", "score", int( spm ) );
                player setplayerdata( "mp", "bestSPM", "time", getsystemtime() );
            }
        }
        
        roundsReached = zm_utility::get_round_number();
        var_bea34a9efeb8e0ed = player.pers[ "telemetry" ].special_eliminations;
        var_d456619564bfb4a1 = player.pers[ "telemetry" ].elite_eliminations;
        
        if ( isdefined( level.var_21108d67c072f793 ) )
        {
            var_bea34a9efeb8e0ed = [[ level.var_21108d67c072f793 ]]( player );
        }
        
        if ( isdefined( level.var_8fa6e09410dcd137 ) )
        {
            var_d456619564bfb4a1 = [[ level.var_8fa6e09410dcd137 ]]( player );
        }
        
        lastStandCount = 0;
        
        if ( isdefined( player.last_stand_count ) )
        {
            lastStandCount = player.last_stand_count;
        }
        
        var_6f9b00680ed002d8 = level.var_6f9b00680ed002d8;
        player setplayerdata( var_6f9b00680ed002d8, "aarData", "statsData", "roundsReached", roundsReached );
        player setplayerdata( var_6f9b00680ed002d8, "aarData", "statsData", "specialsEliminated", var_bea34a9efeb8e0ed );
        player setplayerdata( var_6f9b00680ed002d8, "aarData", "statsData", "elitesEliminated", var_d456619564bfb4a1 );
        player setplayerdata( var_6f9b00680ed002d8, "aarData", "statsData", "downs", lastStandCount );
    }
}

// Namespace gamelogic_zm
// Params 0
// Checksum 0x7636dac2, Offset: 0x12a92
// Size: 0x85
function checkforpersonalbests()
{
    foreach ( player in level.players )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        function_f8889f49a761d327( player );
    }
}

// Namespace gamelogic_zm
// Params 0
// Checksum 0xa0e249b8, Offset: 0x12b1f
// Size: 0x15, Type: bool
function allowleaderboardstatsupdates()
{
    return level.onlinestatsenabled && isleaderboardsupportedmode();
}

// Namespace gamelogic_zm
// Params 0
// Checksum 0x744f470d, Offset: 0x12b3d
// Size: 0xac
function updateleaderboardstatscontinuous()
{
    level endon( #"game_ended" );
    level endon( #"hash_5b8a8903d2af7a11" );
    
    if ( !allowleaderboardstatsupdates() )
    {
        return;
    }
    
    for ( playerindex = 0; true ; playerindex++ )
    {
        while ( !isdefined( level.players ) || level.players.size == 0 )
        {
            waitframe();
        }
        
        if ( playerindex >= level.players.size )
        {
            playerindex = 0;
        }
        
        player = level.players[ playerindex ];
        
        if ( !isdefined( player ) || isai( player ) )
        {
            waitframe();
            continue;
        }
        
        player updateplayerleaderboardstatsinternal();
        wait 0.1;
    }
}

// Namespace gamelogic_zm
// Params 0
// Checksum 0x78613918, Offset: 0x12bf1
// Size: 0x9a
function updateleaderboardstats()
{
    if ( !allowleaderboardstatsupdates() )
    {
        return;
    }
    
    foreach ( player in level.players )
    {
        if ( !isdefined( player ) || isai( player ) )
        {
            continue;
        }
        
        player updateplayerleaderboardstatsinternal();
    }
}

// Namespace gamelogic_zm
// Params 0
// Checksum 0x3e6a22b7, Offset: 0x12c93
// Size: 0x24
function updateplayerleaderboardstats()
{
    if ( !allowleaderboardstatsupdates() )
    {
        return;
    }
    
    if ( !isdefined( self ) || isai( self ) )
    {
        return;
    }
    
    updateplayerleaderboardstatsinternal();
}

// Namespace gamelogic_zm
// Params 0
// Checksum 0xc34fd765, Offset: 0x12cbf
// Size: 0x1c1, Type: bool
function isleaderboardsupportedmode()
{
    if ( game_utility::function_ae97372c83da7acc() )
    {
        modestring = "hc_";
    }
    else
    {
        modestring = "";
    }
    
    modestring += game_utility::getgametype();
    
    switch ( modestring )
    {
        case #"hash_ca6516c10db2c95":
        case #"hash_1a5d186c17c00d3c":
        case #"hash_1aac086c17fe5ccb":
        case #"hash_1b1eecd3863a50cf":
        case #"hash_2946b34dbd2b86c6":
        case #"hash_53825b446469ac4c":
        case #"hash_5ff8e011d5b9d1c8":
        case #"hash_61ac7a98039e2d86":
        case #"hash_6efb0f59a62300fb":
        case #"hash_7485fa6c474ec865":
        case #"hash_8c758b84936e8d42":
        case #"hash_9424bbb71eb7d064":
        case #"hash_a93dacd349d98a99":
        case #"hash_aac44b0b52bacb8e":
        case #"hash_aada280b52cbdd96":
        case #"hash_ab00240b52e9ec5e":
        case #"hash_b9458959b10637f8":
        case #"hash_dd5b900f435d3f36":
        case #"hash_ddd385f0a27d71bb":
        case #"hash_ea061d29bbd1f237":
        case #"hash_eb5e5f470e0c1dc2":
        case #"hash_ec24570718a340f5":
        case #"hash_f4a9126c03d3385b":
        case #"hash_f55ec3d372444a79":
        case #"hash_fa0ed2f6bd4f4395":
        case #"hash_fa0ed9f6bd4f4e9a":
        case #"hash_fa34c5f6bd6d4432":
        case #"hash_fa50b0f6bd82e972":
        case #"hash_fa50baf6bd82f930":
        case #"hash_fa7b69e7b63430d3":
        case #"hash_fb5b5e6c07253005":
            return true;
        default:
            return false;
    }
    
    return false;
}

// Namespace gamelogic_zm
// Params 0
// Checksum 0x6ee622df, Offset: 0x12e89
// Size: 0x7f1
function updateplayerleaderboardstatsinternal()
{
    modestring = undefined;
    
    if ( game_utility::function_ae97372c83da7acc() )
    {
        modestring = "hc_";
    }
    else
    {
        modestring = "";
    }
    
    modestring += game_utility::getgametype();
    modescore = level.teambased ? self.score : self.leaderboarddata[ "gamemodeScore" ];
    incrementleaderboardstat( "score", modestring, modescore );
    timeplayed = persistence::statgetchildbuffered( "round", "timePlayed", 0 );
    incrementleaderboardstat( "timePlayed", modestring, timeplayed );
    incrementleaderboardstat( "kills", modestring, self.leaderboarddata[ "kills" ] );
    incrementleaderboardstat( "deaths", modestring, self.leaderboarddata[ "deaths" ] );
    
    if ( isbrgamemode() )
    {
        incrementleaderboardstat( "downs", modestring, self.leaderboarddata[ "downs" ] );
        incrementleaderboardstat( "contracts", modestring, self.leaderboarddata[ "contracts" ] );
        incrementleaderboardstat( "wins", modestring, self.leaderboarddata[ "wins" ] );
        incrementleaderboardstat( "topFive", modestring, self.leaderboarddata[ "topFive" ] );
        incrementleaderboardstat( "topTen", modestring, self.leaderboarddata[ "topTen" ] );
        incrementleaderboardstat( "topTwentyFive", modestring, self.leaderboarddata[ "topTwentyFive" ] );
        incrementleaderboardstat( "gamesPlayed", modestring, self.leaderboarddata[ "gamesPlayed" ] );
        incrementleaderboardstat( "revives", modestring, self.leaderboarddata[ "rescues" ] );
        incrementleaderboardstat( "cash", modestring, self.leaderboarddata[ "cash" ] );
        incrementleaderboardstat( "eliteStarted", modestring, self.leaderboarddata[ "eliteStarted" ] );
        incrementleaderboardstat( "eliteCompleted", modestring, self.leaderboarddata[ "eliteCompleted" ] );
        incrementleaderboardstat( "eliteBlocked", modestring, self.leaderboarddata[ "eliteBlocked" ] );
        incrementleaderboardstat( "secondaryVictories", modestring, self.leaderboarddata[ "secondaryVictories" ] );
        incrementleaderboardstat( "weaponCaseExfils", modestring, self.leaderboarddata[ "weaponCaseExfils" ] );
        incrementleaderboardstat( "weaponCaseWins", modestring, self.leaderboarddata[ "weaponCaseWins" ] );
        return;
    }
    
    switch ( game_utility::getgametype() )
    {
        case #"hash_7485fa6c474ec865":
            incrementleaderboardstat( "assists", modestring, self.leaderboarddata[ "assists" ] );
            break;
        case #"hash_5ff8e011d5b9d1c8":
            incrementleaderboardstat( "damage", modestring, self.leaderboarddata[ "damage" ] );
            incrementleaderboardstat( "assists", modestring, self.leaderboarddata[ "assists" ] );
            break;
        case #"hash_ca6516c10db2c95":
            incrementleaderboardstat( "captures", modestring, self.leaderboarddata[ "captures" ] );
            incrementleaderboardstat( "defends", modestring, self.leaderboarddata[ "defends" ] );
            break;
        case #"hash_eb5e5f470e0c1dc2":
            incrementleaderboardstat( "revives", modestring, self.leaderboarddata[ "rescues" ] );
            incrementleaderboardstat( "plants", modestring, self.leaderboarddata[ "plants" ] );
            break;
        case #"hash_fa0ed9f6bd4f4e9a":
            updateleaderboardstatmaximum( "streak", modestring, self.leaderboarddata[ "killChains" ] );
            break;
        case #"hash_f4a9126c03d3385b":
            incrementleaderboardstat( "captures", modestring, self.leaderboarddata[ "captures" ] );
            incrementleaderboardstat( "defends", modestring, self.leaderboarddata[ "defends" ] );
            break;
        case #"hash_fa50b0f6bd82e972":
            incrementleaderboardstat( "plants", modestring, self.leaderboarddata[ "plants" ] );
            incrementleaderboardstat( "defuses", modestring, self.leaderboarddata[ "defuses" ] );
            break;
        case #"hash_ea061d29bbd1f237":
            incrementleaderboardstat( "confirms", modestring, self.leaderboarddata[ "confirmed" ] );
            incrementleaderboardstat( "denies", modestring, self.leaderboarddata[ "denied" ] );
            break;
        case #"hash_fa34c5f6bd6d4432":
            incrementleaderboardstat( "captures", modestring, self.leaderboarddata[ "captures" ] );
            incrementleaderboardstat( "defends", modestring, self.leaderboarddata[ "defends" ] );
            break;
        case #"hash_6efb0f59a62300fb":
            incrementleaderboardstat( "objTime", modestring, self.leaderboarddata[ "objTime" ] );
            incrementleaderboardstat( "defends", modestring, self.leaderboarddata[ "defends" ] );
            break;
        case #"hash_1a5d186c17c00d3c":
            incrementleaderboardstat( "captures", modestring, self.leaderboarddata[ "captures" ] );
            incrementleaderboardstat( "returns", modestring, self.leaderboarddata[ "returns" ] );
            break;
        case #"hash_fa50baf6bd82f930":
            incrementleaderboardstat( "plants", modestring, self.leaderboarddata[ "plants" ] );
            incrementleaderboardstat( "rescues", modestring, self.leaderboarddata[ "rescues" ] );
            break;
        case #"hash_53825b446469ac4c":
            incrementleaderboardstat( "captures", modestring, self.leaderboarddata[ "captures" ] );
            incrementleaderboardstat( "revives", modestring, self.leaderboarddata[ "rescues" ] );
            break;
        case #"hash_ec24570718a340f5":
            incrementleaderboardstat( "banks", modestring, self.leaderboarddata[ "confirmed" ] );
            incrementleaderboardstat( "denies", modestring, self.leaderboarddata[ "denied" ] );
            break;
        case #"hash_b9458959b10637f8":
            incrementleaderboardstat( "time", modestring, self.pers[ "extrascore0" ] );
            incrementleaderboardstat( "infected", modestring, self.leaderboarddata[ "killsAsInfected" ] );
            break;
        case #"hash_fb5b5e6c07253005":
            incrementleaderboardstat( "stabs", modestring, self.leaderboarddata[ "stabs" ] );
            incrementleaderboardstat( "setBacks", modestring, self.leaderboarddata[ "setbacks" ] );
            break;
        case #"hash_dd5b900f435d3f36":
            incrementleaderboardstat( "objTime", modestring, self.leaderboarddata[ "objTime" ] );
            incrementleaderboardstat( "defends", modestring, self.leaderboarddata[ "defends" ] );
            break;
        case #"hash_1aac086c17fe5ccb":
            incrementleaderboardstat( "assists", modestring, self.leaderboarddata[ "assists" ] );
            incrementleaderboardstat( "captures", modestring, self.leaderboarddata[ "captures" ] );
            incrementleaderboardstat( "defends", modestring, self.leaderboarddata[ "defends" ] );
            break;
        case #"hash_8c758b84936e8d42":
            incrementleaderboardstat( "banks", modestring, self.leaderboarddata[ "confirmed" ] );
            incrementleaderboardstat( "denies", modestring, self.leaderboarddata[ "denied" ] );
            break;
    }
}

// Namespace gamelogic_zm
// Params 3
// Checksum 0xa3a17725, Offset: 0x13682
// Size: 0xaf
function incrementleaderboardstat( stat, modestring, matchvalue )
{
    if ( !isdefined( self.leaderboardstartvalues ) )
    {
        self.leaderboardstartvalues = [];
    }
    
    if ( !isdefined( self.leaderboardstartvalues[ stat ] ) )
    {
        self.leaderboardstartvalues[ stat ] = self getplayerdata( "mp", "playerStats", "modeStats", modestring, stat );
    }
    
    var_44be59e96f74419e = int( max( self.leaderboardstartvalues[ stat ] + matchvalue, self.leaderboardstartvalues[ stat ] ) );
    self setplayerdata( "mp", "playerStats", "modeStats", modestring, stat, var_44be59e96f74419e );
}

// Namespace gamelogic_zm
// Params 3
// Checksum 0x88a55df3, Offset: 0x13739
// Size: 0x61
function updateleaderboardstatmaximum( stat, modestring, var_75b2fafbaa142fb1 )
{
    var_4595b4b85ef28e93 = self getplayerdata( "mp", "playerStats", "modeStats", modestring, stat );
    
    if ( var_75b2fafbaa142fb1 > var_4595b4b85ef28e93 )
    {
        self setplayerdata( "mp", "playerStats", "modeStats", modestring, stat, var_75b2fafbaa142fb1 );
    }
}

// Namespace gamelogic_zm
// Params 1
// Checksum 0x3f4dba39, Offset: 0x137a2
// Size: 0x7e
function getmatchspm( player )
{
    spm = level.teambased ? player.score : player.pers[ "gamemodeScore" ];
    seconds = player persistence::statgetchildbuffered( "round", "timePlayed", 0 );
    
    if ( seconds > 0 )
    {
        minutes = seconds / 60;
        spm /= minutes;
    }
    
    return spm;
}

// Namespace gamelogic_zm
// Params 1
// Checksum 0x7dcf0d21, Offset: 0x13829
// Size: 0x47, Type: bool
function isvalidbestweapon( rootname )
{
    group = weapon::getweapongroup( rootname );
    return rootname && !weapon::iskillstreakweapon( rootname ) && group != "killstreak" && group != "other";
}

// Namespace gamelogic_zm
// Params 0
// Checksum 0x7d8bbde5, Offset: 0x13879
// Size: 0x2
function function_155aab5762043bb7()
{
    
}

// Namespace gamelogic_zm
// Params 1
// Checksum 0xaefca97b, Offset: 0x13883
// Size: 0x83
function allow_weapon_mp( bool )
{
    self notify( #"hash_ae137792a5f878e2" );
    
    if ( bool )
    {
        if ( isdefined( self.allowweaponcache ) && !self hasweapon( self.allowweaponcache ) && !killstreak::isjuggernaut() && !self.inlaststand )
        {
            inventory::switchtolastweapon();
        }
        
        self.allowweaponcache = undefined;
        return;
    }
    
    self.allowweaponcache = self.lastnormalweaponobj;
    thread watchinvalidweaponswitchduringdisableweapon();
}

// Namespace gamelogic_zm
// Params 0
// Checksum 0xa3f1098e, Offset: 0x1390e
// Size: 0x10
function allow_weapon_mp_init()
{
    level.allow_weapon_mp = &allow_weapon_mp;
}

// Namespace gamelogic_zm
// Params 0
// Checksum 0xae2e203f, Offset: 0x13926
// Size: 0x52
function watchinvalidweaponswitchduringdisableweapon()
{
    self endon( #"death" );
    self endon( #"disconnect" );
    self endon( #"hash_ae137792a5f878e2" );
    
    while ( true )
    {
        self waittill( #"weapon_switch_invalid", invalidweapon );
        self.allowweaponcache = invalidweapon;
    }
}

// Namespace gamelogic_zm
// Params 0
// Checksum 0x28d48ff8, Offset: 0x13980
// Size: 0xd
function ismp_init()
{
    level.ismp = 1;
}

// Namespace gamelogic_zm
// Params 1
// Checksum 0xb5707784, Offset: 0x13995
// Size: 0x5b
function function_7c36a49f06eb0cde( maxplayers )
{
    minplayers = getdvarint( @"live_lobby_minplayers_start" );
    
    if ( minplayers > maxplayers )
    {
        println( "<dev string:xacc>" + minplayers + "<dev string:xafb>" + maxplayers );
        setdvar( @"live_lobby_minplayers_start", maxplayers );
        minplayers = maxplayers;
    }
    
    return minplayers;
}

// Namespace gamelogic_zm
// Params 0
// Checksum 0xdef52714, Offset: 0x139f9
// Size: 0x11c
function watchforminplayersmatchstart()
{
    level endon( #"start_prematch" );
    var_203857c33952b85d = getdvarint( @"hash_5e1370f70979f8b", 1 );
    lobbystarttime = gettime();
    lobbycurrtime = lobbystarttime;
    maxplayers = getdvarint( @"party_maxplayers" );
    minplayers = function_7c36a49f06eb0cde( maxplayers );
    
    if ( minplayers != 0 )
    {
        while ( true )
        {
            if ( level.devoverridematchstart )
            {
                break;
            }
            
            var_f45803a2a6bbf870 = ( lobbycurrtime - lobbystarttime ) / 1000;
            var_81284df95fc81aba = getdvarint( @"live_lobby_max_time", 300 );
            
            if ( var_81284df95fc81aba > 0 && var_f45803a2a6bbf870 >= var_81284df95fc81aba )
            {
                break;
            }
            
            if ( var_f45803a2a6bbf870 <= getdvarint( @"hash_738a4f27bfac1d24", 15 ) )
            {
                if ( getactiveclientcount( 0 ) >= function_7c36a49f06eb0cde( maxplayers ) )
                {
                    break;
                }
            }
            else if ( getactiveclientcount( var_203857c33952b85d ) >= function_7c36a49f06eb0cde( maxplayers ) )
            {
                break;
            }
            
            waitframe();
            lobbycurrtime = gettime();
        }
    }
    
    level notify( #"start_prematch" );
}

// Namespace gamelogic_zm
// Params 0
// Checksum 0xd9e819d3, Offset: 0x13b1d
// Size: 0x46
function brwatchforminplayersmatchstart()
{
    level endon( #"start_prematch" );
    
    while ( level.players.size < getdvarint( @"br_minplayers" ) || level.devoverridematchstart )
    {
        waitframe();
    }
    
    level notify( #"start_prematch" );
}

// Namespace gamelogic_zm
// Params 0
// Checksum 0xad8ab989, Offset: 0x13b6b
// Size: 0x1b7
function watchdevoverridematchstart()
{
    level.startbuttons = [];
    starttriggers = getentarray( "start_lobby_trigger", #targetname );
    level thread waitforoverridematchstartdvar();
    level thread waitforoverridematchstartnotify();
    
    if ( starttriggers.size == 0 )
    {
        level thread waitforinitialplayerloadspawnflag();
        return;
    }
    
    foreach ( trigger in starttriggers )
    {
        if ( isdefined( trigger.target ) )
        {
            visuals[ 0 ] = getent( trigger.target, #targetname );
        }
        else
        {
            visuals[ 0 ] = spawn( "script_model", trigger.origin );
            visuals[ 0 ].angles = trigger.angles;
        }
        
        startbutton = gameobjects::createuseobject( "neutral", trigger, visuals, ( 0, 0, 64 ), undefined, 1 );
        startbutton gameobjects::allowuse( "any" );
        startbutton.id = "use";
        startbutton.trigger setuseprioritymax();
        startbutton gameobjects::setusetime( 3 );
        startbutton gameobjects::setusehinttext( &"mp_ingame_only/hold_to_start_game" );
        startbutton.onuse = &startbutton_onuse;
        level.startbuttons[ level.startbuttons.size ] = startbutton;
    }
}

// Namespace gamelogic_zm
// Params 0
// Checksum 0x709d418b, Offset: 0x13d2a
// Size: 0x377
function waitforinitialplayerloadspawnflag()
{
    level endon( #"game_ended" );
    level endon( #"start_prematch" );
    level waittill( #"connected", player );
    player waittill( #"giveloadout" );
    waitframe();
    visuals[ 0 ] = spawn( "script_model", player.origin );
    trigger = visuals[ 0 ];
    visuals[ 0 ] setmodel( "tag_origin" );
    useteam = "any";
    usetime = 3;
    org = ( 31983, -35229, -458 );
    trigger.team = "neutral";
    level.startbuttons[ 0 ] = gameobjects::createholduseobject( useteam, trigger, visuals, ( 0, 0, 0 ) );
    level.startbuttons[ 0 ].curorigin = org;
    level.startbuttons[ 0 ].trigger.origin = org;
    level.startbuttons[ 0 ].visuals[ 0 ].origin = org;
    level.startbuttons[ 0 ].trigger makeusable();
    level.startbuttons[ 0 ].ownerteam = trigger.team;
    level.startbuttons[ 0 ].trigger.owner = level.players[ 0 ];
    level.startbuttons[ 0 ].interactteam = "any";
    level.startbuttons[ 0 ].curprogress = 0;
    level.startbuttons[ 0 ].userate = 1;
    level.startbuttons[ 0 ].id = "use";
    level.startbuttons[ 0 ].exclusiveuse = 0;
    level.startbuttons[ 0 ].exclusiveclaim = 1;
    level.startbuttons[ 0 ].skiptouching = 1;
    level.startbuttons[ 0 ].skipminimapids = 1;
    level.startbuttons[ 0 ].trigger setcursorhint( "HINT_NOICON" );
    level.startbuttons[ 0 ].trigger setusehideprogressbar( 1 );
    level.startbuttons[ 0 ].trigger sethintstring( &"mp_ingame_only/hold_to_start_game" );
    level.startbuttons[ 0 ].trigger setuseprioritymax();
    level.startbuttons[ 0 ].onuse = &startbutton_onuse;
    level.startbuttons[ 0 ].flagmodel = spawn( "script_model", org );
    level.startbuttons[ 0 ].flagmodel setmodel( "prop_flag_neutral" );
    level.startbuttons[ 0 ].usabilitytrigger = spawn( "trigger_radius", org, 0, 32, 128 );
    level.startbuttons[ 0 ] gameobjects::setusetime( usetime );
}

// Namespace gamelogic_zm
// Params 0
// Checksum 0xb434026d, Offset: 0x140a9
// Size: 0x55
function waitforoverridematchstartdvar()
{
    level endon( #"game_ended" );
    level endon( #"hash_e033cf5eebc8b249" );
    
    /#
        setdevdvarifuninitialized( @"hash_a2aaa37f176aa49", 0 );
    #/
    
    while ( true )
    {
        if ( getdvarint( @"hash_a2aaa37f176aa49", 0 ) )
        {
            dev_forcelivelobbystart();
            break;
        }
        
        wait 0.5;
    }
}

// Namespace gamelogic_zm
// Params 0
// Checksum 0xe316c720, Offset: 0x14106
// Size: 0x45
function waitforoverridematchstartnotify()
{
    level endon( #"game_ended" );
    level endon( #"hash_e033cf5eebc8b249" );
    level waittill( #"forcematchstart", var_e3c31db8827a0158 );
    level.var_725e93363e456224 = var_e3c31db8827a0158;
    dev_forcelivelobbystart();
}

// Namespace gamelogic_zm
// Params 1
// Checksum 0x5e3cf5ae, Offset: 0x14153
// Size: 0x20
function startbutton_onuse( player )
{
    player setclientomnvar( "ui_securing", 0 );
    dev_forcelivelobbystart();
}

// Namespace gamelogic_zm
// Params 0
// Checksum 0xb93bddf, Offset: 0x1417b
// Size: 0x17c
function dev_forcelivelobbystart()
{
    level thread sound::playsoundonplayers( "mp_dom_flag_captured" );
    
    foreach ( team in level.teamnamelist )
    {
        print::teamhudtutorialmessage( "MP_INGAME_ONLY/GAME_FORCE_STARTED", team, 10 );
    }
    
    setdvar( @"br_minplayers", 1 );
    setdvar( @"live_lobby_minplayers_start", 1 );
    level notify( #"start_prematch" );
    
    foreach ( button in level.startbuttons )
    {
        button gameobjects::allowuse( "none" );
        button.trigger = undefined;
        button.visibleteam = "none";
        button.flagmodel delete();
        button notify( #"deleted" );
    }
    
    level notify( #"hash_e033cf5eebc8b249" );
}

// Namespace gamelogic_zm
// Params 0
// Checksum 0xacb89c28, Offset: 0x142ff
// Size: 0xf1
function livelobbyrestart()
{
    level.gameendtime = gettime();
    level.gameended = 1;
    level.ingraceperiod = 0;
    level.doeomcombat = 0;
    game[ "blockJIP" ] = 1;
    waitframe();
    setgameendflagsandnotifies( undefined );
    waitframe();
    setgameendtime( 0 );
    thread analyticslog::logevent_sendplayerindexdata();
    
    if ( level.var_98dc8a7195ec7c4b ?? analyticslog::function_c0d649dd2c6fbce5() )
    {
        analyticslog::analyticsstorespawndata();
    }
    
    if ( isdefined( level.matchrecording_dump ) )
    {
        [[ level.matchrecording_dump ]]();
    }
    
    setdvar( @"g_deadchat", 1 );
    setdvar( @"ui_allow_teamchange", 0 );
    
    /#
        sendscriptusageanalysisdata( 1, 1 );
    #/
    
    livelobbyroundendwait( 1, 1 );
    level notify( #"game_cleanup" );
    setslowmotion( 1, 0.4, 3 );
    resetsoundtimescalefactor();
    flags::levelflagclear( "block_notifies" );
    restart();
}

// Namespace gamelogic_zm
// Params 2
// Checksum 0x610ebbf4, Offset: 0x143f8
// Size: 0x9e
function livelobbyroundendwait( defaultdelay, matchbonus )
{
    foreach ( player in level.players )
    {
        player thread game_utility_mp::setuipostgamefade( 0 );
    }
    
    wait defaultdelay;
    level notify( #"round_end_finished" );
}

// Namespace gamelogic_zm
// Params 2
// Checksum 0xf2e36302, Offset: 0x1449e
// Size: 0x77
function livelobbymatchstarttimer( type, duration )
{
    self notify( #"hash_af7e9bbaadca5367" );
    self endon( #"hash_af7e9bbaadca5367" );
    level notify( #"match_start_timer_beginning" );
    counttime = int( duration );
    
    if ( counttime >= 2 )
    {
        setomnvar( "ui_match_start_text", type );
        matchstarttimerperplayer_internal( counttime );
    }
    
    visionsetnaked( "", 0 );
}

// Namespace gamelogic_zm
// Params 0
// Checksum 0xed7898df, Offset: 0x1451d
// Size: 0x14
function clearmatchhasmorethan1playervariablesonroundend()
{
    game[ "numPlayersConsideredPlaying" ] = 0;
    game[ "matchHasMoreThan1Player" ] = 0;
}

// Namespace gamelogic_zm
// Params 0
// Checksum 0x7ae39da4, Offset: 0x14539
// Size: 0x98
function updatematchhasmorethan1playeromnvaronplayersfirstspawn()
{
    var_110bbb86ea77f42c = game[ "matchHasMoreThan1Player" ];
    game[ "numPlayersConsideredPlaying" ]++;
    
    if ( !game[ "matchHasMoreThan1Player" ] )
    {
        if ( game[ "numPlayersConsideredPlaying" ] > 1 )
        {
            game[ "matchHasMoreThan1Player" ] = 1;
        }
    }
    
    if ( game[ "matchHasMoreThan1Player" ] )
    {
        if ( !var_110bbb86ea77f42c )
        {
            for ( i = 0; i < level.players.size ; i++ )
            {
                level.players[ i ] setclientomnvar( "match_has_more_than_1_player", 1 );
            }
            
            return;
        }
        
        self setclientomnvar( "match_has_more_than_1_player", 1 );
    }
}

// Namespace gamelogic_zm
// Params 0
// Checksum 0x9d513b70, Offset: 0x145d9
// Size: 0x85
function updatematchhasmorethan1playeromnvaronplayerdisconnect()
{
    var_110bbb86ea77f42c = game[ "matchHasMoreThan1Player" ];
    game[ "numPlayersConsideredPlaying" ]--;
    
    if ( game[ "matchHasMoreThan1Player" ] )
    {
        if ( game[ "numPlayersConsideredPlaying" ] <= 1 )
        {
            game[ "matchHasMoreThan1Player" ] = 0;
        }
    }
    
    if ( !game[ "matchHasMoreThan1Player" ] )
    {
        if ( var_110bbb86ea77f42c )
        {
            for ( i = 0; i < level.players.size ; i++ )
            {
                level.players[ i ] setclientomnvar( "match_has_more_than_1_player", 0 );
            }
        }
    }
}

// Namespace gamelogic_zm
// Params 0
// Checksum 0x375b9942, Offset: 0x14666
// Size: 0x14f
function removepatchablecollision_delayed()
{
    wait 10;
    var_c9dd889ed0e5fc94 = [];
    var_c9dd889ed0e5fc94[ 1 ] = "tactical_ladder_col";
    var_c9dd889ed0e5fc94[ 2 ] = "clip8x8x256";
    var_c9dd889ed0e5fc94[ 3 ] = "player8x8x256";
    var_c9dd889ed0e5fc94[ 4 ] = "ladderMetal264";
    var_c9dd889ed0e5fc94[ 5 ] = "ladderWood192";
    var_c9dd889ed0e5fc94[ 6 ] = "ladderMetal192";
    var_c9dd889ed0e5fc94[ 7 ] = "mount128";
    var_c9dd889ed0e5fc94[ 8 ] = "mount64";
    var_c9dd889ed0e5fc94[ 9 ] = "mount32";
    var_c9dd889ed0e5fc94[ 10 ] = "mount256";
    var_c9dd889ed0e5fc94[ 11 ] = "ladderWood264";
    var_c9dd889ed0e5fc94[ 12 ] = "nosight256x256x8";
    var_c9dd889ed0e5fc94[ 13 ] = "nosight128x128x8";
    var_c9dd889ed0e5fc94[ 14 ] = "mountCorner128";
    var_c9dd889ed0e5fc94[ 15 ] = "mantle256";
    var_c9dd889ed0e5fc94[ 16 ] = "mantle128";
    var_c9dd889ed0e5fc94[ 17 ] = "mantle64";
    var_c9dd889ed0e5fc94[ 18 ] = "mantle32";
    var_c9dd889ed0e5fc94[ 19 ] = "stairsHalfFlight128";
    var_c9dd889ed0e5fc94[ 20 ] = "stairsFullFlight128";
    
    foreach ( name in var_c9dd889ed0e5fc94 )
    {
        game_utility::removematchingents_bykey( name, "targetname" );
    }
}

// Namespace gamelogic_zm
// Params 0
// Checksum 0xf1129241, Offset: 0x147bd
// Size: 0x4
function getbrendsplashpostgamestate()
{
    return 8;
}

// Namespace gamelogic_zm
// Params 1
// Checksum 0x54beafdc, Offset: 0x147ca
// Size: 0x141
function logendofround( player )
{
    if ( !( isdefined( player ) && isdefined( player.team ) ) )
    {
        return;
    }
    
    if ( !level.teambased || level.multiteambased )
    {
        return;
    }
    
    time_from_match_start = matchdata::gettimefrommatchstart( gettime() );
    playerteam = player.team;
    enemyteam = level.teamnamelist[ 0 ];
    
    if ( playerteam == enemyteam )
    {
        enemyteam = level.teamnamelist[ 1 ];
    }
    
    playerteamscore = getteamscore( playerteam );
    enemyteamscore = getteamscore( enemyteam );
    rounddamage = 0;
    
    if ( isdefined( player.damagethisround ) )
    {
        rounddamage = player.damagethisround;
    }
    
    player dlog_recordplayerevent( "dlog_event_end_of_round", [ "time_from_match_start", time_from_match_start, "player_team_name", playerteam, "enemy_team_name", enemyteam, "player_team_score", playerteamscore, "enemy_team_score", enemyteamscore, "damage_this_round", rounddamage ] );
}

// Namespace gamelogic_zm
// Params 0
// Checksum 0x87a653d4, Offset: 0x14913
// Size: 0x2f
function setendofroundsoundtimescalefactor()
{
    if ( !isdefined( level.endround_timescalefactor ) )
    {
        soundsettimescalefactorfromtable( "zm_t10_end_of_round" );
        level.endround_timescalefactor = 1;
        level.reset_timescalefactor = undefined;
    }
}

// Namespace gamelogic_zm
// Params 0
// Checksum 0x10ac9c06, Offset: 0x1494a
// Size: 0x42
function resetsoundtimescalefactor()
{
    if ( !isdefined( level.reset_timescalefactor ) )
    {
        soundsettimescalefactorfromtable( "reset" );
        level.endround_timescalefactor = undefined;
        level.nukeinfo.timescalefactor = undefined;
        level.reset_timescalefactor = 1;
    }
}

// Namespace gamelogic_zm
// Params 1
// Checksum 0xf3dafc3b, Offset: 0x14994
// Size: 0x43
function function_c8bc6a4c81fc7661( player )
{
    if ( player game_utility_mp::onlinestatsenabled( "zm" ) && player hasplayerdata() )
    {
        player playerstats_interface::addtoplayerstat( 1, "matchStats", "gamesPlayed", undefined, undefined, undefined, "zm" );
    }
}

// Namespace gamelogic_zm
// Params 0, eflags: 0x4
// Checksum 0x547b593f, Offset: 0x149df
// Size: 0x1b, Type: bool
function private function_598b3aad1aa54a90()
{
    return level.teambased && game_utility::getgametype() != "zm_rb_battle";
}

