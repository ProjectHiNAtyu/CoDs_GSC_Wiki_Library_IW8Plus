// scripts\mp\gamelogic.gsc  (hash_184c00af74e45f30.gscc) (size: 196373 Bytes / 0x2ff15 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x638d7bf4 (1670216692)
// size ...... 196373 (0x2ff15)
// includes .. 160 (offset: 0x2ac85)
// strings ... 872 (offset: 0x2b185)
// dev strs .. 118 (offset: 0x2f91d)
// exports ... 263 (offset: 0x207f5)
// cseg ...... 0x48a3 + 0x1bf52 (0x207f5)
// imports ... 826 (offset: 0x2310d)
// animtree1 . 0   (offset: 0x2ff15)
// animtree2 . 0   (offset: 0x2ff15)
#using script_13131f7e98f45305;
#using script_13f607f4b5c51bc4;
#using script_26ccbfe3954cacf4;
#using script_3cb3908b3094b567;
#using script_72af5a878a9d3397;
#using scripts\common\active_env\active_env;
#using scripts\common\active_env\arcwire;
#using scripts\common\bots\bots_util;
#using scripts\common\callbacks;
#using scripts\common\dof;
#using scripts\common\feature_init;
#using scripts\common\focus;
#using scripts\common\gameplay_sound_fx;
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
#using scripts\mp\action_park_utility;
#using scripts\mp\ammorestock;
#using scripts\mp\analyticslog;
#using scripts\mp\armor;
#using scripts\mp\awards;
#using scripts\mp\battlechatter_mp;
#using scripts\mp\bots\bots;
#using scripts\mp\bots\bots_loadout;
#using scripts\mp\bounty;
#using scripts\mp\br\gametypes\br;
#using scripts\mp\br\gametypes\br_circle;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\brclientmatchdata;
#using scripts\mp\brmatchdata;
#using scripts\mp\callouts;
#using scripts\mp\challenges;
#using scripts\mp\class;
#using scripts\mp\clientmatchdata;
#using scripts\mp\codcaster_utils;
#using scripts\mp\common\killstreaks\init;
#using scripts\mp\common\killstreaks\killstreaks;
#using scripts\mp\common\perks\perkpackage;
#using scripts\mp\common\perks\perks;
#using scripts\mp\common\utility\audio_utility;
#using scripts\mp\common\utility\connect_event_aggregator;
#using scripts\mp\common\utility\dialog;
#using scripts\mp\common\utility\disconnect_event_aggregator;
#using scripts\mp\common\utility\drop_event_aggregator;
#using scripts\mp\common\utility\dvars;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\inventory;
#using scripts\mp\common\utility\killstreak;
#using scripts\mp\common\utility\killstreak_utility;
#using scripts\mp\common\utility\loot;
#using scripts\mp\common\utility\lower_message;
#using scripts\mp\common\utility\lui_game_event_aggregator;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\player_frame_update_aggregator;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\print;
#using scripts\mp\common\utility\rejoin_utility;
#using scripts\mp\common\utility\sound;
#using scripts\mp\common\utility\team_utility;
#using scripts\mp\common\utility\teams;
#using scripts\mp\common\utility\trigger;
#using scripts\mp\common\utility\weapon;
#using scripts\mp\common\utility\weapon_utility;
#using scripts\mp\common\weapons\gun_shield;
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
#using scripts\mp\gameinstance;
#using scripts\mp\gameobjects;
#using scripts\mp\gameplay_telemetry;
#using scripts\mp\gamescore;
#using scripts\mp\gamestaterestore;
#using scripts\mp\gametypes\common;
#using scripts\mp\gametypes\control;
#using scripts\mp\gametypes\jup_wager;
#using scripts\mp\gametypes\wm_ending;
#using scripts\mp\gestures;
#using scripts\mp\gestures_mp;
#using scripts\mp\hostmigration;
#using scripts\mp\hud;
#using scripts\mp\hud_message;
#using scripts\mp\hud_popup;
#using scripts\mp\hud_util;
#using scripts\mp\infilexfil\infilexfil;
#using scripts\mp\init_shared_funcs;
#using scripts\mp\juggernaut;
#using scripts\mp\killcam;
#using scripts\mp\laststand;
#using scripts\mp\leagueplay;
#using scripts\mp\leagueplay_br;
#using scripts\mp\lightarmor;
#using scripts\mp\load;
#using scripts\mp\loot;
#using scripts\mp\matchdata;
#using scripts\mp\matchstats;
#using scripts\mp\meatshield;
#using scripts\mp\menus;
#using scripts\mp\mtx_weapon;
#using scripts\mp\music_br;
#using scripts\mp\music_mp;
#using scripts\mp\objectiveiconstates;
#using scripts\mp\outline;
#using scripts\mp\outofbounds;
#using scripts\mp\overlord;
#using scripts\mp\persistence;
#using scripts\mp\personal_bests;
#using scripts\mp\playeranimset;
#using scripts\mp\playercards;
#using scripts\mp\playerhealth;
#using scripts\mp\playerlogic;
#using scripts\mp\playerstats;
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
#using scripts\mp\stamina;
#using scripts\mp\stance;
#using scripts\mp\stat_limits;
#using scripts\mp\supers;
#using scripts\mp\talking_gun;
#using scripts\mp\teamrevive;
#using scripts\mp\teams;
#using scripts\mp\telemetry_esports;
#using scripts\mp\telemetry_mp;
#using scripts\mp\turret;
#using scripts\mp\weaponrank;
#using scripts\mp\weapons;

#namespace gamelogic_mp;

// Namespace gamelogic_mp
// Params 2
// Checksum 0x5b389b85, Offset: 0x48c1
// Size: 0x1ea
function onforfeit( winner, forceforfeit = 0 )
{
    if ( isdefined( level.forfeitinprogress ) )
    {
        return;
    }
    
    if ( level.gameended && getdvarint( @"hash_a31479e5f79fe7c8", 0 ) == 1 )
    {
        function_377e8e8e8bec6a2d( winner );
        return;
    }
    
    if ( !forceforfeit )
    {
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
    }
    
    outcome = function_a8d9392b3b02d483( winner );
    winner = outcome.winner;
    endreason = outcome.endreason;
    level.forcedend = 1;
    
    if ( isdefined( winner ) )
    {
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
    }
    
    thread endgame( winner, endreason );
}

// Namespace gamelogic_mp
// Params 0
// Checksum 0x795ef4b9, Offset: 0x4ab3
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

// Namespace gamelogic_mp
// Params 1, eflags: 0x4
// Checksum 0x4f1edfed, Offset: 0x4ba4
// Size: 0xda
function private function_a8d9392b3b02d483( winnerteam )
{
    if ( !isdefined( winnerteam ) )
    {
        return { #endreason:game[ "end_reason" ][ "players_forfeited" ], #winner:level.players[ 0 ] };
    }
    
    forfeitteam = team_utility::getotherteam( winnerteam );
    
    if ( level.leagueplaymatch )
    {
        game[ "roundsWon" ][ winnerteam ] = game_utility_mp::isroundbased() ? game_utility_mp::getscorelimit() : 1;
        game[ "roundsWon" ][ forfeitteam ] = 0;
        game[ "teamScores" ][ winnerteam ] = game_utility_mp::getscorelimit();
        game[ "teamScores" ][ forfeitteam ] = 0;
        setteamscore( winnerteam, 1 );
        setteamscore( forfeitteam, 0 );
    }
    
    return { #endreason:game[ "end_reason" ][ "mp_faction_forfeited" ], #winner:winnerteam };
}

// Namespace gamelogic_mp
// Params 1, eflags: 0x4
// Checksum 0xeef2ab00, Offset: 0x4c87
// Size: 0x5e
function private function_377e8e8e8bec6a2d( winnerteam )
{
    level.forfeitinprogress = 1;
    level.forfeitend = 1;
    outcome = function_a8d9392b3b02d483( winnerteam );
    level.var_163c315e088122d6 = outcome.winner;
    level.var_554d86d70af1ffce = outcome.endreason;
}

// Namespace gamelogic_mp
// Params 1
// Checksum 0xccfec656, Offset: 0x4ced
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

// Namespace gamelogic_mp
// Params 1
// Checksum 0x82e8cdc6, Offset: 0x4e5d
// Size: 0x42
function matchforfeittimer( duration )
{
    level notify( #"hash_5f22342470264edc" );
    counttime = int( duration );
    setomnvar( "ui_match_start_text", "opponent_forfeiting_in" );
    matchforfeittimer_internal( counttime );
}

// Namespace gamelogic_mp
// Params 2
// Checksum 0x70c61832, Offset: 0x4ea7
// Size: 0x52e
function default_ondeadevent( team, instance )
{
    logstring( "team eliminated: " + team );
    
    if ( isbrgamemode() )
    {
        if ( team == "all" )
        {
            players = level.players;
        }
        else
        {
            players = teams::getteamdata( team, "players" );
        }
        
        foreach ( player in players )
        {
            result = undefined;
            
            if ( player.pers[ "hasDoneAnyCombat" ] || player.pers[ "participation" ] )
            {
                result = "eliminated";
            }
            
            player game_utility::stopkeyearning( result );
        }
        
        playerendmatch();
        
        if ( team != "all" )
        {
            function_4de8ebf078bc3ed4( team );
        }
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
            thread endgame( "tie", game[ "end_reason" ][ "tie" ], undefined, undefined, undefined, instance );
        }
        else
        {
            thread endgame( undefined, game[ "end_reason" ][ "tie" ], undefined, undefined, undefined, instance );
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
    
    var_760bf54d2dd70c96 = 1;
    
    if ( isdefined( level.var_760bf54d2dd70c96 ) )
    {
        var_760bf54d2dd70c96 = [[ level.var_760bf54d2dd70c96 ]]();
    }
    
    if ( var_760bf54d2dd70c96 && !br::function_ee15a28564f11e4e() )
    {
        var_add96e3cb8b3c493 = undefined;
        
        foreach ( entry in enemyteams )
        {
            alivecount = teams::getteamdata( entry, "aliveCount" );
            assert( alivecount >= 0 );
            uibotcount = 0;
            
            if ( isdefined( level.uibotmanager ) )
            {
                uibotcount = teams::getteamdata( entry, "UIBotCount" );
                assert( uibotcount >= 0 );
            }
            
            if ( alivecount > 0 || uibotcount > 0 || livescount[ entry ] )
            {
                if ( var_add96e3cb8b3c493 )
                {
                    var_add96e3cb8b3c493 = undefined;
                    break;
                }
                
                var_add96e3cb8b3c493 = entry;
            }
        }
        
        if ( var_add96e3cb8b3c493 )
        {
            var_de9b655923cddf60 = undefined;
            
            if ( utility::issharedfuncdefined( #"game", #"hash_1a06dc3d90104f3c" ) )
            {
                data = spawnstruct();
                data.var_1881bb7f4bea9e23 = team;
                var_de9b655923cddf60 = utility::callsharedfunc( #"game", #"hash_1a06dc3d90104f3c", data );
            }
            
            thread endgame( var_add96e3cb8b3c493, game[ "end_reason" ][ "enemies_eliminated" ], game[ "end_reason" ][ "br_eliminated" ], undefined, var_de9b655923cddf60, instance );
        }
    }
}

// Namespace gamelogic_mp
// Params 1
// Checksum 0xf3ddf18a, Offset: 0x53dd
// Size: 0x8c, Type: bool
function default_ononeleftevent( team )
{
    if ( level.teambased )
    {
        assert( arraycontains( level.teamnamelist, team ) );
        lastplayer = game_utility_mp::getlastlivingplayer( team );
        
        if ( isdefined( lastplayer ) )
        {
            lastplayer thread givelastonteamwarning( team );
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

// Namespace gamelogic_mp
// Params 2
// Checksum 0xff930a8, Offset: 0x5472
// Size: 0x3da
function roundend_checkscorelimit( team, allowtie )
{
    checkteamscorelimitsoon( team );
    scorelimittext = "score_limit_reached";
    
    if ( isdefined( level.var_28acb43c77eacf08 ) )
    {
        scorelimittext = level.var_28acb43c77eacf08;
    }
    
    if ( allowtie )
    {
        level notify( #"hash_9e97b0b976383856" );
        level endon( #"hash_9e97b0b976383856" );
        waitframe();
    }
    
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
                
                if ( level.codcasterenabled )
                {
                    codcaster_utils::function_c2c643e0ac6e6a6( game[ "timeToBeatTeam" ], game[ "timeToBeat" ], game[ "timeToBeatOld" ] );
                }
                
                thread endgame( team, game[ "end_reason" ][ scorelimittext ] );
            }
        }
        else if ( !game_utility_mp::isscoretobeatrulegametype() )
        {
            thread endgame( team, game[ "end_reason" ][ scorelimittext ] );
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
                    if ( isdefined( level.onscorelimit ) )
                    {
                        [[ level.onscorelimit ]]( "tie" );
                    }
                    
                    thread endgame( "tie", game[ "end_reason" ][ scorelimittext ] );
                }
                else
                {
                    if ( isdefined( level.onscorelimit ) )
                    {
                        [[ level.onscorelimit ]]( highestteam );
                    }
                    
                    thread endgame( highestteam, game[ "end_reason" ][ scorelimittext ] );
                }
                
                return;
            }
            
            if ( isdefined( level.onscorelimit ) )
            {
                [[ level.onscorelimit ]]( var_38a598c9ed7fae70[ 0 ] );
            }
            
            thread endgame( var_38a598c9ed7fae70[ 0 ], game[ "end_reason" ][ scorelimittext ] );
        }
    }
}

// Namespace gamelogic_mp
// Params 1
// Checksum 0xa93c6c8, Offset: 0x5854
// Size: 0x1d6
function default_ontimelimit( instance )
{
    winner = "tie";
    
    if ( level.teambased )
    {
        if ( level.multimatch ?? gameinstance::is_enabled() )
        {
            winner = gamescore::gethighestscoringteam( instance );
        }
        else if ( game_utility_mp::inovertime() || game_utility_mp::intimetobeat() )
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
    
    if ( level.multimatch ?? gameinstance::is_enabled() )
    {
        gameinstance::function_3979f6a43aa329b( instance, winner, game[ "end_reason" ][ "time_limit_reached" ] );
        return;
    }
    
    thread endgame( winner, game[ "end_reason" ][ "time_limit_reached" ] );
}

// Namespace gamelogic_mp
// Params 0
// Checksum 0x13d01046, Offset: 0x5a32
// Size: 0x1b
function default_onhalftime()
{
    thread endgame( "halftime", game[ "end_reason" ][ "time_limit_reached" ] );
}

// Namespace gamelogic_mp
// Params 0, eflags: 0x4
// Checksum 0xabad8b6f, Offset: 0x5a55
// Size: 0x12, Type: bool
function private function_70eddf2e71057cf2()
{
    return getdvarint( @"hash_f50b51911b176e13", 0 ) != 0;
}

// Namespace gamelogic_mp
// Params 0
// Checksum 0xa6cfacd7, Offset: 0x5a70
// Size: 0x12a
function forceendgamewhennohumanthread()
{
    if ( function_70eddf2e71057cf2() )
    {
        return;
    }
    
    level endon( #"game_ended" );
    function_4ad33b3d76915952();
    
    while ( true )
    {
        hashuman = 0;
        
        foreach ( player in level.players )
        {
            if ( isdefined( player ) && !isai( player ) )
            {
                hashuman = 1;
                break;
            }
        }
        
        if ( hashuman )
        {
            wait 1;
            continue;
        }
        
        if ( isdefined( level.uibotmanager ) )
        {
            level.uibotmanager.var_9d03093deceb509e = 1;
        }
        
        endgamemethod = -1;
        reason = "Force end game due to no human player exists";
        logstring( "[KEY_MOMENT] forceEndGameWhenNoHumanThread. endGameMethod=" + endgamemethod + " reason=" + reason );
        namespace_ddca46d216b096e2::debuglogforceendgame( endgamemethod );
        thread forceend();
        return;
    }
}

// Namespace gamelogic_mp
// Params 0
// Checksum 0x2cb46693, Offset: 0x5ba2
// Size: 0xb0
function function_4ad33b3d76915952()
{
    if ( function_70eddf2e71057cf2() )
    {
        return;
    }
    
    foreach ( player in level.players )
    {
        if ( isdefined( player ) && !isai( player ) )
        {
            return;
        }
    }
    
    while ( true )
    {
        level waittill( #"player_spawned", player );
        
        if ( !isai( player ) )
        {
            return;
        }
    }
}

// Namespace gamelogic_mp
// Params 1
// Checksum 0xc0c056d8, Offset: 0x5c5a
// Size: 0x258
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
            endstring = game[ "end_reason" ][ "mp_faction_forfeited" ];
        }
        else
        {
            endstring = game[ "end_reason" ][ "players_forfeited" ];
        }
    }
    else if ( level.leagueplaymatch && level.leagueplaymatchcancelled )
    {
        winner = "tie";
        endstring = game[ "end_reason" ][ "lp_match_cancelled" ];
    }
    
    level notify( #"hash_28f73a27711fb4a6" );
    thread endgame( winner, endstring );
}

// Namespace gamelogic_mp
// Params 2
// Checksum 0xa81f7f28, Offset: 0x5eba
// Size: 0x1f9
function onscorelimit( allowtie, var_ce4196fe4973e4c4 )
{
    scoretext = var_ce4196fe4973e4c4 ?? game[ "end_reason" ][ "score_limit_reached" ];
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
        
        nukecost = killstreak_utility::function_e88d91359aa0273();
        
        if ( game_utility_mp::getscorelimit() == nukecost && winner.pers[ "cur_kill_streak" ] == nukecost )
        {
            level.modescorewinner = winner;
            level.starttime = gettime();
            level.discardtime = 0;
            
            if ( !isdefined( game[ "discardTime" ] ) )
            {
                game[ "discardTime" ] = 0;
            }
            
            level.timerpausetime = 0;
            level.timelimit = 30;
            level.dontendonscore = 1;
            return;
        }
    }
    
    if ( isdefined( level.onscorelimit ) )
    {
        [[ level.onscorelimit ]]( winner );
    }
    
    thread endgame( winner, scoretext );
    return 1;
}

// Namespace gamelogic_mp
// Params 0
// Checksum 0x508af86d, Offset: 0x60bc
// Size: 0xcb3
function updategameevents()
{
    if ( game_utility_mp::matchmakinggame() && !flags::gameflag( "prematch_done" ) )
    {
        return;
    }
    
    canforfeit = game_utility_mp::matchmakinggame() && !level.disableforfeit && !game_utility::function_36ce69a7be195555();
    
    if ( level.multimatch ?? gameinstance::is_enabled() )
    {
        gameinstance::updategameevents( canforfeit );
        return;
    }
    
    level.teamswithplayers = [];
    
    foreach ( team in level.teamnamelist )
    {
        teamcount = teams::getteamdata( team, "teamCount" );
        
        if ( teamcount )
        {
            level.teamswithplayers[ level.teamswithplayers.size ] = team;
        }
    }
    
    if ( !level.ingraceperiod )
    {
        if ( level.teambased )
        {
            if ( canforfeit && level.teamswithplayers.size == 1 && game_utility_mp::getgamestate() == "playing" )
            {
                thread onforfeit( level.teamswithplayers[ 0 ] );
                return;
            }
            else if ( level.teamswithplayers.size == 0 )
            {
                level.forcedend = 1;
                thread endgame( "none", game[ "end_reason" ][ "ended_game" ] );
                return;
            }
            else if ( level.teamswithplayers.size > 1 )
            {
                level.forfeitinprogress = undefined;
                level notify( #"abort_forfeit" );
            }
        }
        else
        {
            playercount = 0;
            
            foreach ( entry in level.teamnamelist )
            {
                playercount += teams::getteamdata( entry, "teamCount" );
            }
            
            if ( canforfeit && playercount == 1 && level.maxplayercount > 1 )
            {
                thread onforfeit();
                return;
            }
            else if ( playercount == 0 )
            {
                level.forcedend = 1;
                thread endgame( "none", game[ "end_reason" ][ "ended_game" ] );
                return;
            }
            else if ( playercount > 1 )
            {
                level.forfeitinprogress = undefined;
                level notify( #"abort_forfeit" );
            }
        }
    }
    
    if ( level.teamswithplayers.size == 1 && ( level.br_debugsolotest || !isbrgamemode() && !isdmzgamemode() ) && !level.var_edec83ec6da8ff87 )
    {
        return;
    }
    
    if ( !game_utility_mp::getgametypenumlives() && !game_utility_mp::ismutationgamemode() && !level.disablespawning )
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
        
        var_ee1c174ea76190d2 = [];
        
        foreach ( player in level.players )
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
            foreach ( entry in level.teamnamelist )
            {
                livescount[ entry ] = 0;
            }
        }
        
        hasalivecount = 0;
        teamsalive = level.teamnamelist.size;
        
        foreach ( entry in level.teamnamelist )
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
                return;
            }
            
            return [[ level.ondeadevent ]]( "all" );
        }
        
        foreach ( entry in level.teamnamelist )
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
                                
                                if ( lastplayer )
                                {
                                    lastplayer dialog::leaderdialogonplayer( #"friendly_last_alive", "status" );
                                    otherteam = team_utility::getotherteam( entry );
                                    dialog::leaderdialog( #"enemy_last_alive", otherteam, "status" );
                                }
                            }
                            
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

// Namespace gamelogic_mp
// Params 1
// Checksum 0x7b716a5c, Offset: 0x6d77
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

// Namespace gamelogic_mp
// Params 3
// Checksum 0x32b05e72, Offset: 0x6e02
// Size: 0x4c6
function waitforplayers( maxtime, var_4c66032dc3e31956, waitforallplayers )
{
    level.connectingplayers = getdvarint( @"party_partyplayercountnum" );
    initialtime = gettime();
    println( "<dev string:x24>" + initialtime );
    
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
    
    var_4a72f9b97ba70321 = getdvarint( @"hash_5c86f55062c7e7b5", 5 ) * 1000;
    var_b0ac90383df2b0d7 = 0;
    
    if ( waitforallplayers )
    {
        var_627995efe61b41ed = max( 1, level.connectingplayers );
    }
    else
    {
        var_627995efe61b41ed = max( 1, level.connectingplayers / 2 );
    }
    
    if ( game_utility::getgametype() == "dmz" || game_utility::getgametype() == "ob" )
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
            var_83c243d7b01abc8d = level.var_83c243d7b01abc8d || game_utility::function_245a95d184375f25() || action_park_utility::is_enabled();
            
            if ( !var_83c243d7b01abc8d )
            {
                break;
            }
        }
        
        var_7433b73c8a47652c = level.maxplayercount;
        var_1eb7b19bd246a0ad = function_6171c4b9a767c102();
        curtime = gettime();
        
        if ( !var_40e70d93a0b15d56 )
        {
            if ( function_70eddf2e71057cf2() )
            {
                starttime = gettime();
                var_40e70d93a0b15d56 = 1;
            }
            else if ( var_1eb7b19bd246a0ad.size > 0 )
            {
                if ( var_b0ac90383df2b0d7 == 0 )
                {
                    var_b0ac90383df2b0d7 = gettime();
                }
                
                var_88435e2e9549f77e = 0;
                
                foreach ( player in var_1eb7b19bd246a0ad )
                {
                    if ( !isbot( player ) && !istestclient( player ) && !player isplayerheadless() )
                    {
                        var_88435e2e9549f77e++;
                        break;
                    }
                }
                
                if ( var_88435e2e9549f77e > 0 || curtime > var_b0ac90383df2b0d7 + var_4a72f9b97ba70321 )
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
            else
            {
                waitframe();
                continue;
            }
        }
        
        var_2bae312abacccbd2 = var_7433b73c8a47652c >= var_627995efe61b41ed;
        var_65957518390e3d2a = 0;
        
        if ( isdefined( level.var_65957518390e3d2a ) )
        {
            var_65957518390e3d2a = [[ level.var_65957518390e3d2a ]]();
        }
        else
        {
            var_65957518390e3d2a = var_1eb7b19bd246a0ad.size >= var_627995efe61b41ed;
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
        
        if ( flags::gameflag( "infil_will_run" ) || var_4c66032dc3e31956 )
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
        curtime = gettime();
        starttime = starttime ?? 0;
        humanwaittime = var_b0ac90383df2b0d7 - initialtime;
        println( "<dev string:x44>" + humanwaittime + "<dev string:x5d>" );
        totaltime = curtime - starttime;
        println( "<dev string:x44>" + totaltime + "<dev string:x7d>" );
    #/
}

// Namespace gamelogic_mp
// Params 2
// Checksum 0x41dfd240, Offset: 0x72d0
// Size: 0x6a2
function function_8c940255f9dd0487( duration, var_4c66032dc3e31956 )
{
    if ( game[ "roundsPlayed" ] )
    {
        return;
    }
    
    starttime = gettime();
    endtime = starttime + duration * 1000;
    mintime = gettime() + getdvarint( @"min_wait_for_players" ) * 1000;
    var_627995efe61b41ed = level.requiredplayercount[ "allies" ] + level.requiredplayercount[ "axis" ];
    var_40e70d93a0b15d56 = 0;
    cancelmatch = 0;
    loadoutsforced = 0;
    
    /#
        lastprinttime = 0;
        printinterval = 3000;
    #/
    
    if ( getdvarint( @"hash_e7fd1773dcd3056b", 0 ) && var_4c66032dc3e31956 )
    {
        var_627995efe61b41ed -= getdvarint( @"hash_e7fd1773dcd3056b", 0 );
    }
    
    logstring( "waitForPlayersLeaguePlay: start time at " + starttime );
    logstring( "waitForPlayersLeaguePlay: end time at " + endtime );
    logstring( "waitForPlayersLeaguePlay: min time is " + mintime );
    logstring( "waitForPlayersLeaguePlay: useStreamedPlayers " + var_4c66032dc3e31956 );
    logstring( "waitForPlayersLeaguePlay: waiting for " + var_627995efe61b41ed + " players" );
    logstring( "waitForPlayersLeaguePlay: allies team require " + level.requiredplayercount[ "allies" ] + " players" );
    logstring( "waitForPlayersLeaguePlay: axis team require " + level.requiredplayercount[ "axis" ] + " players" );
    
    while ( true )
    {
        curtime = gettime();
        var_7433b73c8a47652c = level.maxplayercount;
        var_1eb7b19bd246a0ad = getstreamedinplayercount();
        var_fcf3001fd909b47 = function_e7209f8dffc02993();
        
        /#
            minplayeroverride = getdvarint( @"hash_ff21533b32af5cbb" );
            
            if ( minplayeroverride > 0 )
            {
                var_fcf3001fd909b47 = var_627995efe61b41ed;
            }
        #/
        
        if ( !var_40e70d93a0b15d56 )
        {
            if ( var_1eb7b19bd246a0ad > 0 )
            {
                starttime = gettime();
                var_40e70d93a0b15d56 = 1;
                
                if ( getdvarint( @"hash_5886df61b04d3129", 0 ) )
                {
                    break;
                }
            }
            else
            {
                /#
                    if ( curtime - lastprinttime > printinterval )
                    {
                        println( "<dev string:x94>" + var_1eb7b19bd246a0ad + "<dev string:xaf>" );
                        lastprinttime = curtime;
                    }
                #/
                
                waitframe();
                continue;
            }
        }
        
        var_2bae312abacccbd2 = var_7433b73c8a47652c >= var_627995efe61b41ed;
        var_1850a9749b8a371a = var_1eb7b19bd246a0ad >= var_627995efe61b41ed;
        
        /#
            if ( curtime - lastprinttime > printinterval )
            {
                alliescount = 0;
                axiscount = 0;
                undefinedcount = 0;
                
                foreach ( player in level.players )
                {
                    if ( !isdefined( player.team ) )
                    {
                        undefinedcount++;
                        continue;
                    }
                    
                    if ( player.team == "<dev string:xcb>" )
                    {
                        alliescount++;
                        continue;
                    }
                    
                    if ( player.team == "<dev string:xd2>" )
                    {
                        axiscount++;
                    }
                }
                
                println( "<dev string:x94>" + alliescount + "<dev string:xd7>" );
                println( "<dev string:x94>" + axiscount + "<dev string:xef>" );
                println( "<dev string:x94>" + undefinedcount + "<dev string:x105>" );
            }
        #/
        
        if ( var_1850a9749b8a371a )
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
        
        if ( var_4c66032dc3e31956 && var_1850a9749b8a371a && curtime > mintime )
        {
            logstring( "waitForPlayersLeaguePlay: we have enough player streamed in" );
            break;
        }
        else if ( var_2bae312abacccbd2 && curtime > mintime )
        {
            logstring( "waitForPlayersLeaguePlay: we have enough player spawned in" );
            break;
        }
        
        if ( !var_4c66032dc3e31956 && getdvarint( @"hash_5886df61b04d3129", 0 ) == 0 && !level.var_59cffb353d98bc10 && getactiveclientcount( 1 ) < var_627995efe61b41ed )
        {
            level.var_59cffb353d98bc10 = 1;
            setomnvarforallclients( "ui_leagueplay_allow_quit", 1 );
            thread function_d441498194756fb2( endtime - curtime );
        }
        
        if ( getdvarint( @"hash_24397da1535aec25", 1 ) && var_7433b73c8a47652c == var_fcf3001fd909b47 && var_fcf3001fd909b47 < var_627995efe61b41ed )
        {
            cancelmatch = 1;
            logstring( "waitForPlayersLeaguePlay: connected player count (" + var_fcf3001fd909b47 + ") less than number to wait for. Cancelling match." );
            break;
        }
        
        if ( curtime > endtime )
        {
            cancelmatch = 1;
            logstring( "waitForPlayersLeaguePlay: time limit of " + level.var_246204351eddbb14 + " seconds has passed. Cancelling match." );
            break;
        }
        
        if ( !var_4c66032dc3e31956 && !loadoutsforced && curtime + level.prematchperiodend * 1000 > endtime )
        {
            foreach ( player in level.players )
            {
                if ( player.waitingtoselectclass )
                {
                    fav_loadout_index = player getplayerdata( level.var_6f9b00680ed002d8, "favoriteLoadoutIndex" );
                    loadout_index = fav_loadout_index ?? 0;
                    player notify( #"loadout_class_selected", loadout_index );
                    player setclientomnvar( "ui_open_menu_from_script", -1 );
                }
            }
            
            loadoutsforced = 1;
        }
        
        /#
            if ( curtime - lastprinttime > printinterval )
            {
                println( "<dev string:x94>" + var_1eb7b19bd246a0ad + "<dev string:xaf>" );
                println( "<dev string:x94>" + var_7433b73c8a47652c + "<dev string:x120>" );
                println( "<dev string:x94>" + var_fcf3001fd909b47 + "<dev string:x136>" );
                lastprinttime = curtime;
            }
        #/
        
        waitframe();
    }
    
    totaltime = gettime() - starttime;
    logstring( "waitForPlayersLeaguePlay: waited " + totaltime + "ms for players to join" );
    logstring( "waitForPlayersLeaguePlay: " + var_1eb7b19bd246a0ad + " players finished streaming" );
    logstring( "waitForPlayersLeaguePlay: " + var_7433b73c8a47652c + " players have spawned" );
    logstring( "waitForPlayersLeaguePlay: " + var_fcf3001fd909b47 + " players have connected to lobby" );
    
    if ( getdvarint( @"hash_c03a546c561f9ef", 0 ) || var_4c66032dc3e31956 )
    {
        return;
    }
    
    if ( cancelmatch )
    {
        leagueplay::cancel_match();
    }
}

// Namespace gamelogic_mp
// Params 0
// Checksum 0x382daec8, Offset: 0x797a
// Size: 0xb7
function function_6171c4b9a767c102()
{
    streamedplayers = [];
    
    if ( isdefined( level.players ) && level.players.size > 0 )
    {
        foreach ( player in level.players )
        {
            if ( player.pers[ "streamSyncComplete" ] )
            {
                streamedplayers[ streamedplayers.size ] = player;
            }
        }
    }
    
    return streamedplayers;
}

// Namespace gamelogic_mp
// Params 0
// Checksum 0x18ba9fe6, Offset: 0x7a3a
// Size: 0xa3
function getstreamedinplayercount()
{
    count = 0;
    
    if ( isdefined( level.players ) )
    {
        foreach ( player in level.players )
        {
            if ( player.pers[ "streamSyncComplete" ] )
            {
                count++;
            }
        }
    }
    
    return count;
}

// Namespace gamelogic_mp
// Params 1
// Checksum 0x995d1b79, Offset: 0x7ae6
// Size: 0xdc
function function_378afcd17c8b5f9e( team )
{
    requiredcount = level.requiredplayercount[ team ];
    teamplayercount = 0;
    
    foreach ( player in level.players )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        if ( player.team != team )
        {
            continue;
        }
        
        if ( player isplayerheadless() )
        {
            continue;
        }
        
        teamplayercount++;
    }
    
    if ( teamplayercount > 0 )
    {
        requiredcount = min( requiredcount, teamplayercount );
    }
    
    return requiredcount;
}

// Namespace gamelogic_mp
// Params 1
// Checksum 0x9635358d, Offset: 0x7bcb
// Size: 0x22, Type: bool
function checkrequiredteamcount( team )
{
    return teams::getteamdata( team, "hasSpawned" ) >= function_378afcd17c8b5f9e( team );
}

// Namespace gamelogic_mp
// Params 1
// Checksum 0x67c7457d, Offset: 0x7bf6
// Size: 0xc6, Type: bool
function checkrequiredteamstreamcount( team )
{
    count = 0;
    requiredcount = function_378afcd17c8b5f9e( team );
    
    foreach ( player in level.players )
    {
        if ( player.team == team && player.pers[ "streamSyncComplete" ] )
        {
            count++;
        }
    }
    
    return count >= requiredcount;
}

// Namespace gamelogic_mp
// Params 1
// Checksum 0x8f669f, Offset: 0x7cc5
// Size: 0x47
function function_f4d9c5d39f80cd1d( timesec )
{
    if ( !isdefined( game[ #"prematch_period_stall" ] ) )
    {
        game[ #"prematch_period_stall" ] = timesec;
    }
    
    if ( timesec > game[ #"prematch_period_stall" ] )
    {
        game[ #"prematch_period_stall" ] = timesec;
    }
}

// Namespace gamelogic_mp
// Params 0, eflags: 0x4
// Checksum 0x894f3e5a, Offset: 0x7d14
// Size: 0x1d
function private function_999c110e1849c6a6()
{
    wait game[ #"prematch_period_stall" ] ?? 0;
    game[ #"prematch_period_stall" ] = undefined;
}

// Namespace gamelogic_mp
// Params 1, eflags: 0x4
// Checksum 0x22ce2a8, Offset: 0x7d39
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

// Namespace gamelogic_mp
// Params 0
// Checksum 0x94c1ee6, Offset: 0x7d8f
// Size: 0x46c
function prematchperiod()
{
    level endon( #"game_ended" );
    function_999c110e1849c6a6();
    
    if ( getdvarint( @"scr_live_lobby", 0 ) == 1 && !level.skipprematch )
    {
        game[ "inLiveLobby" ] = 1;
        
        if ( getdvarint( @"scr_enable_dev_livelobby_overrides", 0 ) == 1 )
        {
            level thread watchdevoverridematchstart();
        }
        
        level thread watchforminplayersmatchstart();
        level thread function_7ca6619790ebb4f2();
        
        if ( !level.gametypebundle.var_2b935b38d320d8d )
        {
            function_dae95804f9ac598();
        }
        
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
        #/
        
        level.allowprematchdamage = 0;
        
        if ( isbrgamemode() )
        {
            if ( !level.var_1b5acf96f4b833d5 )
            {
                level.allowprematchdamage = 1;
            }
            
            level thread br_public::br_delaynojip();
        }
        
        matchdelay = function_9e05c84b21ef7c5b( matchdelay );
        level livelobbymatchstarttimer( "match_starting_in", matchdelay );
        logstring( "[PREMATCH_DEBUG] " + "gamelogic_mp::prematchperiod" + ": " + "start_prematch notify (second notify after liveLobbyMatchStartTimer, matchDelay=" + matchdelay + ")" );
        level notify( #"start_prematch" );
        level.prematchperiod = 0;
        game[ "blockJIP" ] = 1;
        
        if ( isbrgamemode() )
        {
            level thread personal_bests::function_89f89d7adb07dcc0();
        }
        
        if ( level.gametypebundle.var_2b935b38d320d8d )
        {
            function_dae95804f9ac598();
        }
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
                
                if ( isbrgamemode() )
                {
                    level thread personal_bests::function_89f89d7adb07dcc0();
                }
                
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
                level.allowprematchdamage = 1;
            }
            
            matchdelay = function_9e05c84b21ef7c5b( matchdelay );
            level livelobbymatchstarttimer( "match_starting_in", matchdelay );
        }
    }
    
    if ( level.skipprematch )
    {
        while ( !level.players.size )
        {
            waitframe();
        }
        
        /#
            level.prematchperiodend = getdvarint( @"hash_befab5d3b543da43", level.prematchperiodend );
        #/
    }
    
    action_park_utility::function_e7058081c059c262();
    
    if ( game[ "matchStartRequiresInput" ] )
    {
        level waittill( #"hash_c2ba6f5e09e6a9a0" );
    }
    
    if ( game[ "blockJIP" ] )
    {
        function_a14deb691144654e();
    }
    
    if ( level.leagueplaymatchcancelled )
    {
        return;
    }
    
    level notify( #"prematch_started" );
    println( "<dev string:x157>" );
    
    if ( level.br_allowloadoutonlyinprelobby )
    {
        level.parachuterestoreweaponscb = &br::nakeddrop;
    }
    
    updatetournamentroundtime( gettimeremaining(), 2 );
    level.prematchstarted = 1;
    
    if ( level.gametypebundle.noprematch )
    {
        level.prematchperiodend = 0;
        flags::gameflagset( "prematch_started" );
    }
    
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
}

// Namespace gamelogic_mp
// Params 0
// Checksum 0xc8faa756, Offset: 0x8203
// Size: 0xcc
function function_dae95804f9ac598()
{
    if ( !game_utility_mp::privatematch() )
    {
        if ( getdvarint( @"hash_22eddf44003baf9", 0 ) != 0 && function_8cb4891672cca914() )
        {
            println( "<dev string:x180>" );
            setdvar( @"hash_925f7dceb8e6205e", 1 );
            rejoin_utility::function_bf028e9e4a180ae7( 1 );
        }
        else
        {
            println( "<dev string:x1b9>" );
            setdvar( @"hash_925f7dceb8e6205e", 0 );
        }
        
        return;
    }
    
    if ( getdvarint( @"hash_22eddf44003baf9", 0 ) != 0 && getdvarint( @"online_privatematch_rejoin_allowed", 0 ) != 0 )
    {
        println( "<dev string:x1f3>" );
        setdvar( @"hash_15dc0d6798e4bdd8", 1 );
        setdvar( @"hash_925f7dceb8e6205e", 1 );
        rejoin_utility::function_bf028e9e4a180ae7( 1 );
    }
}

// Namespace gamelogic_mp
// Params 2
// Checksum 0xe07e2e1c, Offset: 0x82d7
// Size: 0x42
function function_a14deb691144654e( var_94fc0bd1df1e42b0 = 1, var_20a3ec0f6a03631b = 1 )
{
    setnojipscore( var_94fc0bd1df1e42b0, var_20a3ec0f6a03631b );
    setnojiptime( var_94fc0bd1df1e42b0, var_20a3ec0f6a03631b );
    level.nojip = 1;
}

// Namespace gamelogic_mp
// Params 0
// Checksum 0xbed64c74, Offset: 0x8321
// Size: 0x1b, Type: bool
function inprematch()
{
    return !( flags::gameflag( "prematch_done" ) || level.skipprematch );
}

// Namespace gamelogic_mp
// Params 0
// Checksum 0xfbeaf1fc, Offset: 0x8345
// Size: 0x12e
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
    
    if ( !game_utility_mp::isfirstround() )
    {
        level thread [[ level.updategameevents ]]();
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
    
    if ( game_utility_mp::getgamestate() != "playing" )
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

// Namespace gamelogic_mp
// Params 2
// Checksum 0x507d58e0, Offset: 0x847b
// Size: 0x1f2
function sethasdonecombat( player, newhasdonecombat )
{
    if ( !isdefined( player ) )
    {
        return;
    }
    
    if ( !isdefined( player.hasdoneanycombat ) )
    {
        player.hasdoneanycombat = player.pers[ "hasDoneAnyCombat" ];
    }
    
    if ( newhasdonecombat )
    {
        player class::disableclassswapallowed();
        player class::function_e441c383fc2c59c9();
    }
    
    player.hasdonecombat = newhasdonecombat;
    
    if ( isbrgamemode() && !flags::gameflag( "prematch_done" ) )
    {
        return;
    }
    
    if ( !player.hasdoneanycombat && newhasdonecombat )
    {
        player.pers[ "hasDoneAnyCombat" ] = 1;
        player.hasdoneanycombat = 1;
        
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
            
            assert( isint( 1 ) || isfloat( 1 ), "<dev string:x260>" );
            
            if ( isdefined( player.pers[ "gamesPlayed" ] ) )
            {
                player.pers[ "gamesPlayed" ] = player.pers[ "gamesPlayed" ] + 1;
            }
        }
        
        if ( player.pers[ "hasMatchLoss" ] )
        {
            return;
        }
        
        updatelossstats( player );
        
        if ( utility::issharedfuncdefined( #"player", #"hash_d2fd0fbf6b6b308c" ) )
        {
            [[ utility::getsharedfunc( #"player", #"hash_d2fd0fbf6b6b308c" ) ]]( player );
        }
    }
}

// Namespace gamelogic_mp
// Params 1
// Checksum 0xbc5fa794, Offset: 0x8675
// Size: 0x280
function updatewinstats( winner )
{
    println( "<dev string:x286>" + winner getentitynumber() );
    
    if ( !winner game_utility_mp::onlinestatsenabled() )
    {
        println( "<dev string:x2a2>" );
        return;
    }
    
    if ( !winner.pers[ "hasDoneAnyCombat" ] )
    {
        println( "<dev string:x2ce>" );
        return;
    }
    
    if ( winner.pers[ "recordedLoss" ] )
    {
        winner playerstats_interface::addtoplayerstat( -1, "matchStats", "losses" );
    }
    
    if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( winner ) ) )
    {
        if ( isdefined( winner.leaderboarddata[ "wins" ] ) )
        {
            winner.leaderboarddata[ "wins" ] = winner.leaderboarddata[ "wins" ] + 1;
        }
        
        if ( isdefined( level.leaderboardfunc[ "wins" ] ) )
        {
            [[ level.leaderboardfunc[ "wins" ] ]]( winner, 1 );
        }
        
        assert( isint( 1 ) || isfloat( 1 ), "<dev string:x260>" );
        
        if ( isdefined( winner.pers[ "wins" ] ) )
        {
            winner.pers[ "wins" ] = winner.pers[ "wins" ] + 1;
        }
    }
    
    /#
        println( "<dev string:x2fe>" + winner playerstats_interface::getplayerstat( "<dev string:x30f>", "<dev string:x31a>" ) );
        println( "<dev string:x31f>" + winner playerstats_interface::getplayerstat( "<dev string:x30f>", "<dev string:x31a>" ) );
        println( "<dev string:x337>" );
    #/
    
    winner playerstats_interface::addtoplayerstat( 1, "matchStats", "wins" );
    println( "<dev string:x31f>" + winner playerstats_interface::getplayerstat( "<dev string:x30f>", "<dev string:x31a>" ) );
    winner playerstats_interface::addtoplayerstat( 1, "matchStats", "currentWinStreak" );
    winner playerstats_interface::addtoplayerstat( 1, "modeRecords", game_utility_mp::getbasegametype() );
    cur_win_streak = winner playerstats_interface::getplayerstat( "matchStats", "currentWinStreak" );
    
    if ( cur_win_streak > winner playerstats_interface::getplayerstat( "bestStats", "longestWinStreak" ) )
    {
        winner playerstats_interface::setplayerstat( cur_win_streak, "bestStats", "longestWinStreak" );
    }
    
    winner persistence::statsetchild( "round", "win", 1 );
    winner persistence::statsetchild( "round", "loss", 0 );
}

// Namespace gamelogic_mp
// Params 1
// Checksum 0x2533ad09, Offset: 0x88fd
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

// Namespace gamelogic_mp
// Params 1
// Checksum 0x53c3ae72, Offset: 0x89a8
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

// Namespace gamelogic_mp
// Params 1
// Checksum 0x4da8a998, Offset: 0x8a45
// Size: 0x4cb
function updatewinlossstats( winner )
{
    println( "<dev string:x35b>" );
    gametype = game_utility::getgametype();
    
    if ( gametype == #"training_course" || gametype == #"br_training_course" )
    {
        println( "<dev string:x375>" );
        return;
    }
    
    if ( game_utility_mp::privatematch() )
    {
        println( "<dev string:x3a8>" );
        return;
    }
    
    if ( !game_utility_mp::waslastround() )
    {
        println( "<dev string:x3d6>" );
        return;
    }
    
    level.processedwinloss = 1;
    players = level.players;
    updateplayercombatstatus();
    
    if ( !isdefined( winner ) || isstring( winner ) && winner == "tie" )
    {
        println( "<dev string:x401>" );
        
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
        
        return;
    }
    
    if ( isplayer( winner ) )
    {
        println( "<dev string:x432>" );
        
        if ( level.hostforcedend && winner ishost() )
        {
            winner playerstats_interface::setplayerstat( 0, "matchStats", "currentWinStreak" );
            return;
        }
        
        if ( isdefined( level.lastplayerwins ) || players.size <= 3 )
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
        
        return;
    }
    
    if ( isstring( winner ) )
    {
        println( "<dev string:x457>" + winner + "<dev string:x47e>" );
        
        foreach ( player in level.players )
        {
            println( "<dev string:x480>" + player getentitynumber() + "<dev string:x49e>" + player.name + "<dev string:x4a1>" );
            
            if ( isdefined( player.connectedpostgame ) )
            {
                println( "<dev string:x4a3>" );
                continue;
            }
            
            if ( level.hostforcedend && player ishost() )
            {
                println( "<dev string:x4dc>" );
                player playerstats_interface::setplayerstat( 0, "matchStats", "currentWinStreak" );
                continue;
            }
            
            if ( winner == "tie" )
            {
                println( "<dev string:x532>" );
                updatetiestats( player );
                continue;
            }
            
            if ( player.pers[ "team" ] == winner )
            {
                println( "<dev string:x561>" );
                updatewinstats( player );
                continue;
            }
            
            println( "<dev string:x59d>" );
            
            if ( player.pers[ "recordedLoss" ] )
            {
                if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( player ) ) )
                {
                    if ( isdefined( player.leaderboarddata[ "losses" ] ) )
                    {
                        player.leaderboarddata[ "losses" ] = player.leaderboarddata[ "losses" ] + 1;
                    }
                    
                    if ( isdefined( level.leaderboardfunc[ "losses" ] ) )
                    {
                        [[ level.leaderboardfunc[ "losses" ] ]]( player, 1 );
                    }
                    
                    assert( isint( 1 ) || isfloat( 1 ), "<dev string:x260>" );
                    
                    if ( isdefined( player.pers[ "losses" ] ) )
                    {
                        player.pers[ "losses" ] = player.pers[ "losses" ] + 1;
                    }
                }
                
                println( "<dev string:x5d2>" );
                player playerstats_interface::setplayerstat( 0, "matchStats", "currentWinStreak" );
            }
        }
    }
}

// Namespace gamelogic_mp
// Params 0
// Checksum 0xc5b12bde, Offset: 0x8f18
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

// Namespace gamelogic_mp
// Params 1
// Checksum 0xb4d9e4df, Offset: 0x9007
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
    
    thread gameendfreezemovement();
}

// Namespace gamelogic_mp
// Params 0
// Checksum 0x1ed1f70a, Offset: 0x907c
// Size: 0x5f
function gameendfreezemovement()
{
    self endon( #"disconnect" );
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

// Namespace gamelogic_mp
// Params 0, eflags: 0x4
// Checksum 0x943eb1f7, Offset: 0x90e3
// Size: 0x88
function private function_71f9252f6b4e4ace()
{
    var_9e59b71521f715ed = game[ "startTimeFromMatchStart" ];
    
    if ( !isdefined( var_9e59b71521f715ed ) )
    {
        return 0;
    }
    
    var_6fadf940ff392a8a = game[ "discardTime" ] ?? level.discardtime;
    
    if ( !isdefined( var_6fadf940ff392a8a ) )
    {
        return 0;
    }
    
    var_4c6014e58574496e = level.timerstopped ? level.timerpausetime : gettime();
    
    if ( !isdefined( var_4c6014e58574496e ) )
    {
        return 0;
    }
    
    return var_4c6014e58574496e - var_9e59b71521f715ed - var_6fadf940ff392a8a - ( level.overtimetotal ?? 0 );
}

// Namespace gamelogic_mp
// Params 0, eflags: 0x4
// Checksum 0xb91f874a, Offset: 0x9174
// Size: 0x25
function private function_a79e9b7a40127c01()
{
    var_9e59b71521f715ed = game[ "startTimeFromMatchStart" ];
    
    if ( !isdefined( var_9e59b71521f715ed ) )
    {
        return 0;
    }
    
    return gettime() - var_9e59b71521f715ed;
}

// Namespace gamelogic_mp
// Params 1
// Checksum 0xbf05f30a, Offset: 0x91a2
// Size: 0x120
function updatematchbonusscores( winner )
{
    if ( !game[ "timePassed" ] )
    {
        return;
    }
    
    if ( isbrgamemode() && game_utility::getgametype() != "plunder" && game_utility::getgametype() != "kingslayer" )
    {
        return;
    }
    
    checkparticipation = !level.gametypebundle.var_7e94307492c03eb8;
    var_dc4204acc01fd6b4 = 1;
    var_7e54fe9ca6118ef8 = 1;
    
    /#
        if ( getdvarint( @"hash_8e3eb6fc1df7304f", 0 ) > 0 )
        {
            var_dc4204acc01fd6b4 = 0;
            var_7e54fe9ca6118ef8 = 0;
        }
    #/
    
    if ( var_dc4204acc01fd6b4 && !game_utility_mp::matchmakinggame() )
    {
        return;
    }
    
    if ( !game_utility_mp::gettimelimit() || level.forcedend )
    {
        gamelength = function_71f9252f6b4e4ace() / 1000;
        gamelength = min( gamelength, 1200 );
    }
    else
    {
        gamelength = function_a79e9b7a40127c01() / 1000;
    }
    
    if ( level.teambased )
    {
        function_79f6867b8094f35c( gamelength, winner, var_7e54fe9ca6118ef8, checkparticipation );
    }
    else
    {
        function_b722a78ffd30ba83( gamelength, isdefined( winner ), var_7e54fe9ca6118ef8, checkparticipation );
    }
    
    level notify( #"give_match_bonus" );
}

// Namespace gamelogic_mp
// Params 4
// Checksum 0x3c7f1754, Offset: 0x92ca
// Size: 0x26f
function function_79f6867b8094f35c( gamelength, winner, var_1dd988cb13d8ed5b, checkparticipation )
{
    foreach ( player in level.players )
    {
        if ( level.var_5e94a673782a6314 )
        {
            assertmsg( "<dev string:x5f7>" );
        }
        
        var_65d5e1c37d85972e = 0;
        
        if ( var_1dd988cb13d8ed5b )
        {
            if ( player.connectedpostgame )
            {
                var_65d5e1c37d85972e = 1;
            }
            
            if ( !player game_utility_mp::rankingenabled() )
            {
                var_65d5e1c37d85972e = 1;
            }
            
            if ( player.timeplayed[ "total" ] < 1 )
            {
                var_65d5e1c37d85972e = 1;
            }
            
            if ( checkparticipation && player.pers[ "participation" ] < 1 )
            {
                var_65d5e1c37d85972e = 1;
            }
            
            if ( level.hostforcedend && player ishost() )
            {
                var_65d5e1c37d85972e = 1;
            }
            
            if ( checkparticipation && !player.pers[ "hasDoneAnyCombat" ] )
            {
                var_65d5e1c37d85972e = 1;
            }
            
            if ( player.matchbonusgranted )
            {
                var_65d5e1c37d85972e = 1;
            }
        }
        
        if ( var_65d5e1c37d85972e )
        {
            continue;
        }
        
        if ( isdefined( winner ) )
        {
            playerteam = player.pers[ "team" ];
            
            if ( winner == "tie" )
            {
                playerscore = player calculatematchbonus( #"tie", gamelength );
                player givematchbonus( "tie", playerscore );
                player.matchbonus = playerscore;
            }
            else if ( playerteam == winner )
            {
                playerscore = player calculatematchbonus( #"win", gamelength );
                player givematchbonus( "win", playerscore );
                player.matchbonus = playerscore;
            }
            else if ( isdefined( playerteam ) && team_utility::isgameplayteam( playerteam ) && playerteam != winner )
            {
                playerscore = player calculatematchbonus( #"loss", gamelength );
                player givematchbonus( "loss", playerscore );
                player.matchbonus = playerscore;
            }
        }
        
        player calculateweaponmatchbonus( gamelength );
    }
}

// Namespace gamelogic_mp
// Params 4
// Checksum 0xeadf24b1, Offset: 0x9541
// Size: 0x2ad
function function_b722a78ffd30ba83( gamelength, var_dbf9fd0e253c620b, var_7e54fe9ca6118ef8, checkparticipation )
{
    winnerresult = var_dbf9fd0e253c620b ? #"win" : #"tie";
    loserresult = var_dbf9fd0e253c620b ? #"loss" : #"tie";
    
    foreach ( player in level.players )
    {
        if ( player.connectedpostgame )
        {
            continue;
        }
        
        iswinner = 0;
        var_65d5e1c37d85972e = 0;
        
        if ( level.var_5e94a673782a6314 )
        {
            bonusresult = [[ level.var_5e94a673782a6314 ]]( player );
            
            switch ( bonusresult )
            {
                case 1:
                    iswinner = 1;
                    break;
                case 2:
                    break;
                case 0:
                    var_65d5e1c37d85972e = 1;
                    break;
                default:
                    assertmsg( "<dev string:x647>" );
                    var_65d5e1c37d85972e = 1;
                    break;
            }
        }
        else
        {
            if ( var_7e54fe9ca6118ef8 )
            {
                if ( player.timeplayed[ "total" ] < 1 )
                {
                    var_65d5e1c37d85972e = 1;
                }
                
                if ( checkparticipation && player.pers[ "participation" ] < 1 )
                {
                    var_65d5e1c37d85972e = 1;
                }
                
                if ( checkparticipation && !player.pers[ "hasDoneAnyCombat" ] )
                {
                    var_65d5e1c37d85972e = 1;
                }
            }
            
            for ( index = 0; index < min( level.placement[ "all" ].size, 3 ) ; index++ )
            {
                if ( level.placement[ "all" ][ index ] != player )
                {
                    continue;
                }
                
                iswinner = 1;
            }
        }
        
        if ( var_65d5e1c37d85972e )
        {
            continue;
        }
        
        if ( iswinner )
        {
            playerscore = player calculatematchbonus( winnerresult, gamelength );
            player givematchbonus( "win", playerscore );
            player.matchbonus = playerscore;
        }
        else
        {
            playerscore = player calculatematchbonus( loserresult, gamelength );
            player givematchbonus( "loss", playerscore );
            player.matchbonus = playerscore;
        }
        
        player calculateweaponmatchbonus( gamelength );
    }
}

// Namespace gamelogic_mp
// Params 2
// Checksum 0x3db5c06, Offset: 0x97f6
// Size: 0x150
function calculatematchbonus( matchresult, gamelength )
{
    if ( !gamelength || gamelength == 0 )
    {
        return 0;
    }
    
    var_9f8ead27d4440432 = self.pers[ "firstConnectTime" ] ?? 0;
    
    if ( var_9f8ead27d4440432 < game[ "startTimeFromMatchStart" ] )
    {
        var_9f8ead27d4440432 = game[ "startTimeFromMatchStart" ];
    }
    
    participationendtime = gettime();
    
    if ( isdefined( level.var_578fa1a580a1bc21 ) )
    {
        var_e5ba5598c947e829 = self [[ level.var_578fa1a580a1bc21 ]]();
        
        if ( var_e5ba5598c947e829 > var_9f8ead27d4440432 )
        {
            participationendtime = var_e5ba5598c947e829;
        }
    }
    
    participationlength = ( participationendtime - var_9f8ead27d4440432 ) / 1000;
    matchbonusbaseline = dvars::function_13909a5327c395b9( "matchbonus_baseline", 400 );
    var_7c09bc0d59b4c13b = gamelength / 60;
    var_3bd52e459f2bddca = rank::function_7a4898caf286e53( matchresult );
    participationscalar = participationlength / gamelength;
    participationscalar = clamp( participationscalar, 0, 1 );
    modescalar = rank::function_d2b057b6b822181f();
    skillscalar = rank::function_28e9293b720556a5();
    matchbonus = int( matchbonusbaseline * var_3bd52e459f2bddca * var_7c09bc0d59b4c13b * participationscalar * modescalar * skillscalar );
    matchbonus = int( min( matchbonus, 32000 ) );
    return matchbonus;
}

// Namespace gamelogic_mp
// Params 2
// Checksum 0x321b9f69, Offset: 0x994f
// Size: 0xc4
function givematchbonus( scoretype, score )
{
    if ( getdvarint( @"hash_1f9e52c91272c80d", 1 ) == 0 )
    {
        return;
    }
    
    thread rank::giverankxp( getxhash( scoretype ), score, undefined, 1, 1, 1 );
    
    if ( scoretype == "win" )
    {
        thread points::doscoreevent( #"match_complete_win", undefined, undefined, undefined, undefined, undefined, 1, undefined, undefined, undefined, { #var_ef32324b503188b8:1 } );
        return;
    }
    
    assert( scoretype == "<dev string:x662>" || scoretype == "<dev string:x666>", "<dev string:x66b>" + scoretype + "<dev string:x698>" );
    thread points::doscoreevent( #"match_complete", undefined, undefined, undefined, undefined, undefined, 1, undefined, undefined, undefined, { #var_ef32324b503188b8:1 } );
}

// Namespace gamelogic_mp
// Params 1
// Checksum 0xe18cb63c, Offset: 0x9a1b
// Size: 0x388
function calculateweaponmatchbonus( gamelength )
{
    if ( getdvarint( @"hash_f80c5403193b015f", 1 ) == 0 )
    {
        return;
    }
    
    if ( self.pers[ "ignoreWeaponMatchBonus" ] || !isdefined( self.pers[ "killsPerWeapon" ] ) )
    {
        return;
    }
    
    killsperminavg = weaponrank::getgametypekillsperhouravg() / 60;
    var_7c09bc0d59b4c13b = gamelength / 60;
    var_33b2d2521b7e3b4d = int( killsperminavg * var_7c09bc0d59b4c13b );
    killincrement = ( level.scoreeventglobals.var_59914a10567f0747 ?? 100 ) * 0.5 * ( level.var_bf6e0b80d2cc59ae ?? 1 );
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
        rank::incrankxp( 0, data, xpgain, getxhash( "WeaponMatchBonus" ) );
        
        foreach ( var_e9144fc349a13b59, datastruct in self.pers[ "weaponStats" ] )
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

// Namespace gamelogic_mp
// Params 0
// Checksum 0x57ee8359, Offset: 0x9dab
// Size: 0xb1
function givexponplayerdisconnect()
{
    if ( !getdvarint( @"hash_6cc8d7e3629ed2be", 1 ) )
    {
        return;
    }
    
    if ( !isdefined( self ) || isbot( self ) || istestclient( self ) )
    {
        return;
    }
    
    if ( !game[ "timePassed" ] )
    {
        return;
    }
    
    if ( !( game_utility_mp::matchmakinggame() || getdvarint( @"force_challenges", 0 ) ) )
    {
        return;
    }
    
    matchbonustype = #"loss";
    gamelength = function_71f9252f6b4e4ace() / 1000;
    xpbonus = calculatematchbonus( matchbonustype, gamelength );
    forceimmediate = 1;
    rank::giverankxp( matchbonustype, xpbonus, undefined, 1, forceimmediate, 1 );
}

// Namespace gamelogic_mp
// Params 1
// Checksum 0xe71b85fd, Offset: 0x9e64
// Size: 0x98
function setxenonranks( winner )
{
    foreach ( player in level.players )
    {
        _setplayerteamrank( player );
        player.pers[ "xenonRankSet" ] = 0;
    }
}

// Namespace gamelogic_mp
// Params 2
// Checksum 0x76bdce8e, Offset: 0x9f04
// Size: 0xbd
function function_13cdb0b37a8886ae( player, var_960eaff095be7ab6 )
{
    playerteam = player.team;
    
    if ( isdefined( var_960eaff095be7ab6 ) )
    {
        player.pers[ "telemetry" ].teamplacement = var_960eaff095be7ab6;
        return;
    }
    
    if ( level.teambased )
    {
        var_a0b344e4bcfef8c8 = game[ "teamPlacements" ][ playerteam ];
        player.pers[ "telemetry" ].teamplacement = var_a0b344e4bcfef8c8;
        return;
    }
    
    player.pers[ "telemetry" ].teamplacement = gamescore::function_ca38b93f32c7b685( player ) ?? -1;
}

// Namespace gamelogic_mp
// Params 2
// Checksum 0x79a257cd, Offset: 0x9fc9
// Size: 0x472
function _setplayerteamrank( player, teamplacement )
{
    if ( !isdefined( player ) )
    {
        return;
    }
    
    if ( !( isdefined( player.kills ) && isdefined( player.deaths ) ) )
    {
        println( "<dev string:x69a>" );
        return;
    }
    
    if ( player.pers[ "xenonRankSet" ] )
    {
        return;
    }
    
    player.pers[ "xenonRankSet" ] = 1;
    
    if ( game_utility::getgametype() == "arena" )
    {
        if ( player.pers[ "telemetry" ].var_66d40dcc3e2ce088 < 1 )
        {
            return;
        }
        
        if ( !isdefined( player.arenadamage ) )
        {
            return;
        }
        
        damage = player.arenadamage;
        println( "<dev string:x6c1>" + damage );
        function_13cdb0b37a8886ae( player, teamplacement );
        function_871c7d9fbeeb5187( player, player.clientid, damage );
        return;
    }
    
    if ( game_utility_mp::isteamplacementsbmmmode() )
    {
        if ( !isdefined( teamplacement ) )
        {
            teamplacement = player.teamplacement ?? 1;
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
        println( "<dev string:x6c9>" + rank );
        println( "<dev string:x6d1>" + operatorweight + "<dev string:x71a>" + operatorkills + "<dev string:x72d>" + downs + "<dev string:x730>" + deaths + "<dev string:x732>" + suicides + "<dev string:x734>" + var_bf178ebef939e188 + "<dev string:x738>" );
        println( "<dev string:x73a>" + agentweight + "<dev string:x780>" + agentkills + "<dev string:x72d>" + downs + "<dev string:x730>" + deaths + "<dev string:x732>" + suicides + "<dev string:x734>" + var_bf178ebef939e188 + "<dev string:x738>" );
        function_871c7d9fbeeb5187( player, player.clientid, rank );
        return;
    }
    
    var_9acfc5169ae0e036 = getdvarint( @"hash_9e2f598909a3fc6e", 0 );
    
    if ( player.pers[ "telemetry" ].var_66d40dcc3e2ce088 < var_9acfc5169ae0e036 && !level.leagueplaymatch )
    {
        return;
    }
    
    suicides = 0;
    
    if ( getdvarint( @"hash_8613ee8086b0e0f6" ) == 1 )
    {
        suicides = player.pers[ "suicides" ];
    }
    
    var_3545ec6b8f013124 = player.timeplayed[ "total" ] / 60;
    matchrating = 0;
    
    if ( var_3545ec6b8f013124 > 0 )
    {
        matchrating = ( player.kills - player.deaths - suicides ) / var_3545ec6b8f013124;
    }
    
    println( "<dev string:x799>" + player.kills + "<dev string:x7d7>" + player.deaths + "<dev string:x7dd>" + suicides + "<dev string:x7e1>" + player.timeplayed[ "<dev string:x7e7>" ] / 60 + "<dev string:x7ed>" + matchrating );
    function_13cdb0b37a8886ae( player, teamplacement );
    function_871c7d9fbeeb5187( player, player.clientid, matchrating );
}

// Namespace gamelogic_mp
// Params 3
// Checksum 0xa6892565, Offset: 0xa443
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

// Namespace gamelogic_mp
// Params 1
// Checksum 0xbe8fb9f1, Offset: 0xa491
// Size: 0xa8c
function function_5d0687b8bf2ede74( player )
{
    var_550e311930e29d9a = player.pers[ "telemetry" ].var_66d40dcc3e2ce088 ?? 0;
    var_196c7bb98449cefe = player.pers[ "timeDead" ] ?? 0;
    var_18bb6dc97c1b52c5 = var_550e311930e29d9a - var_196c7bb98449cefe;
    
    if ( var_18bb6dc97c1b52c5 < 1 )
    {
        return;
    }
    
    telemetry_stats = player.pers[ "telemetry" ];
    var_3662cc13cbfcc812 = player.pers[ "deaths" ] ?? 0;
    suicides = player.pers[ "suicides" ] ?? 0;
    var_98a5205ed62c93d = telemetry_stats.var_98a5205ed62c93d ?? 0;
    var_e3103b223b34ee91 = telemetry_stats.var_e3103b223b34ee91 ?? 0;
    non_player_deaths = suicides + var_98a5205ed62c93d + var_e3103b223b34ee91;
    deaths_by_player = var_3662cc13cbfcc812 - non_player_deaths;
    var_a4ab28765af143b8 = player.pers[ "headshots" ] ?? 0;
    player_headshots = var_a4ab28765af143b8 - telemetry_stats.bot_headshots;
    totalassists = player.pers[ "assists" ] ?? 0;
    player_assists = totalassists - telemetry_stats.bot_assists;
    
    if ( player.disconnecting )
    {
        disconnect_time = getsystemtime();
    }
    
    eliminatedstate = 0;
    
    if ( isbrgamemode() )
    {
        var_5a91d8c6c620f983 = player.br_iseliminated;
        
        if ( var_5a91d8c6c620f983 )
        {
            teamplacement = player.pers[ "telemetry" ].teamplacement;
            
            if ( !isdefined( teamplacement ) )
            {
                var_5e76c5b22e789fc2 = 0;
                
                foreach ( teammate in level.teamdata[ player.team ][ "players" ] )
                {
                    if ( teammate == player )
                    {
                        continue;
                    }
                    
                    if ( isdefined( teammate ) && !teammate.br_iseliminated )
                    {
                        var_5e76c5b22e789fc2 = 1;
                        break;
                    }
                }
                
                eliminatedstate = var_5e76c5b22e789fc2 ? 1 : 2;
            }
            else
            {
                eliminatedstate = 2;
            }
        }
    }
    
    var_d5fae0af5a48ab79 = { #var_5ef43d0cf7fd8bc6:telemetry_stats.var_defc700e2a933403[ "other" ] ?? 0, #var_e900b6946dbb92c4:telemetry_stats.var_defc700e2a933403[ "launcher" ] ?? 0, #var_a557f4f0f8b9ecb8:telemetry_stats.var_defc700e2a933403[ "lmg" ] ?? 0, #var_c21798ce8e67dfa3:telemetry_stats.var_defc700e2a933403[ "pistol" ] ?? 0, #var_2aed29b7ba07e00:telemetry_stats.var_defc700e2a933403[ "br" ] ?? 0, #var_2aaec9b7b9cc157:telemetry_stats.var_defc700e2a933403[ "ar" ] ?? 0, #var_7f175bf198634a3d:telemetry_stats.var_defc700e2a933403[ "smg" ] ?? 0, #var_fcbda4eab7d9d7e:telemetry_stats.var_defc700e2a933403[ "shotgun" ] ?? 0, #var_3189b1f0a3edaf7f:telemetry_stats.var_defc700e2a933403[ "dmr" ] ?? 0, #var_f8fc11c99b8755af:telemetry_stats.var_defc700e2a933403[ "sniper" ] ?? 0, #var_59f1c41391663d10:telemetry_stats.var_defc700e2a933403[ "melee" ] ?? 0, #var_e7cc8ff1376c6fd:telemetry_stats.var_aedba93c9726c98f[ "other" ] ?? 0, #var_cb3185a8e7ab3b9:telemetry_stats.var_aedba93c9726c98f[ "launcher" ] ?? 0, #var_343dca6ca9078877:telemetry_stats.var_aedba93c9726c98f[ "lmg" ] ?? 0, #var_b9c15b5d3b9b82be:telemetry_stats.var_aedba93c9726c98f[ "pistol" ] ?? 0, #var_7c550e520a92a3ed:telemetry_stats.var_aedba93c9726c98f[ "br" ] ?? 0, #var_7c47fc520a8467d2:telemetry_stats.var_aedba93c9726c98f[ "ar" ] ?? 0, #var_9923f6c8a105ac6:telemetry_stats.var_aedba93c9726c98f[ "smg" ] ?? 0, #var_d0fb74b0ccad58ed:telemetry_stats.var_aedba93c9726c98f[ "shotgun" ] ?? 0, #var_a80b0d6cfdd192b0:telemetry_stats.var_aedba93c9726c98f[ "dmr" ] ?? 0, #var_d6acc32f01c4d64e:telemetry_stats.var_aedba93c9726c98f[ "sniper" ] ?? 0, #var_564ee38233cb19a3:telemetry_stats.var_aedba93c9726c98f[ "melee" ] ?? 0, #var_422b4e79ade46b69:telemetry_stats.var_61c7f7fc343e033b[ "other" ] ?? 0, #var_4fc9a8d910ecb825:telemetry_stats.var_61c7f7fc343e033b[ "launcher" ] ?? 0, #var_b87d1f8daf10b113:telemetry_stats.var_61c7f7fc343e033b[ "lmg" ] ?? 0, #var_fc27b34d1b92ec52:telemetry_stats.var_61c7f7fc343e033b[ "pistol" ] ?? 0, #var_adccd0c097d8d869:telemetry_stats.var_61c7f7fc343e033b[ "br" ] ?? 0, #var_adbedec097c8afae:telemetry_stats.var_61c7f7fc343e033b[ "ar" ] ?? 0, #var_1b1d6c8d3c84254a:telemetry_stats.var_61c7f7fc343e033b[ "smg" ] ?? 0, #var_d255e71de562f929:telemetry_stats.var_61c7f7fc343e033b[ "shotgun" ] ?? 0, #var_2bbd8a8e033fc164:telemetry_stats.var_61c7f7fc343e033b[ "dmr" ] ?? 0, #var_109b973ec23b496a:telemetry_stats.var_61c7f7fc343e033b[ "sniper" ] ?? 0, #var_9a90ea7b5fbdcb2f:telemetry_stats.var_61c7f7fc343e033b[ "melee" ] ?? 0, #var_9493faa76a8d91c8:0, #distancetraveled:int( player.pers[ "totalDistTraveled" ] ?? 0 ), #eliminatedstate:eliminatedstate, #var_4ff7763d676f151c:disconnect_time ?? 0, #var_ce5329d11e92e90c:var_18bb6dc97c1b52c5, #var_f5a3a64a85c67b07:var_550e311930e29d9a, #highestroundcompleted:0, #var_e1b7556b914d1c1d:0, #startinground:0, #matchscore:player.pers[ "score" ] ?? 0, #suicides:suicides ?? 0, #friendlyfiredamage:int( telemetry_stats.var_aaefe63e2908cf61 ?? 0 ), #killstreaksused:telemetry_stats.killstreaks_used ?? 0, #var_655e32d79c747afa:player.pers[ "longestStreak" ] ?? 0, #shots:player.pers[ "shotsFired" ] ?? 0, #teamplacement:telemetry_stats.teamplacement ?? 0, #var_5eae1bf92490ef9:telemetry_stats.var_522a9bfd5c6f728 ?? 0, #var_13e6ba69727f881f:telemetry_stats.var_e3103b223b34ee91 ?? 0, #var_92e8a7e8670aede9:int( 0 ), #var_c9dc028690f1e8a1:int( 0 ), #var_26c55ecfe31a4b9d:telemetry_stats.var_90ab4e486d171e04 ?? 0, #var_95900a14a5d761d3:telemetry_stats.var_98a5205ed62c93d ?? 0, #var_7356ff6ae2982a85:int( telemetry_stats.var_ed8397fa350b0793 ?? 0 ), #var_6de0d7e2975c3a6d:int( telemetry_stats.var_10c1b854abd32824 ?? 0 ), #var_f27689c9a42bcd00:telemetry_stats.var_d0d338af214b4950 ?? 0, #var_3f4e632a389f8a6:deaths_by_player ?? 0, #var_2af598ab16749d14:int( telemetry_stats.var_596bc72160ba30dd ?? 0 ), #var_a0edfab0a487349c:int( telemetry_stats.var_af5fee48115acc2c ?? 0 ), #var_36030654a890442b:telemetry_stats.agent_killstreak_kills ?? 0, #var_13ea8e76b21e95f0:0 ?? 0, #var_30ddd6ea93d133b7:0 ?? 0, #var_e4f5d3de3e26044e:telemetry_stats.agent_hits ?? 0, #var_73e8269680835e15:telemetry_stats.agent_kills ?? 0, #var_6a3e5a9c18ab8213:telemetry_stats.bot_killstreak_kills ?? 0, #var_eb55c6b490696ab8:telemetry_stats.bot_assists ?? 0, #var_b22acbe9c93eaaff:telemetry_stats.bot_headshots ?? 0, #var_27ab804f3ee34416:telemetry_stats.bot_hits ?? 0, #var_f1ae3e0b0641a26d:telemetry_stats.bot_kills ?? 0, #var_c7eceb42f8412f02:telemetry_stats.player_killstreak_kills ?? 0, #playerkillassists:player_assists ?? 0, #playerheadshots:player_headshots ?? 0, #playerhits:telemetry_stats.player_hits ?? 0, #playerkills:telemetry_stats.var_feae33f052d5f171 ?? 0 };
    
    if ( isbot( player ) )
    {
        var_d5fae0af5a48ab79.botdifficulty = player function_b82b86a30d32c1a7();
    }
    
    if ( getdvarint( @"hash_5ce3657bc4920adc", 1 ) == 1 )
    {
        var_d5fae0af5a48ab79.playerkillevents = telemetry_stats.playerkillevents ?? [];
    }
    
    function_b2975c6a3a5ce961( player, player.team, var_d5fae0af5a48ab79 );
}

// Namespace gamelogic_mp
// Params 1
// Checksum 0xbb20e1a4, Offset: 0xaf25
// Size: 0x3cb
function checktimelimit( prevtimepassed )
{
    if ( isdefined( level.timelimitoverride ) && level.timelimitoverride )
    {
        return;
    }
    
    if ( game_utility_mp::getgamestate() != "playing" )
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
        
        if ( !isdefined( level.var_f50bca4128052a2e ) && isdefined( level.initialtimelimit ) && level.initialtimelimit > 180 && int( timeleft / 1000 ) < int( level.initialtimelimit / 2 ) )
        {
            level.var_f50bca4128052a2e = 1;
            level thread function_bb2339fb210b8667();
        }
        
        return;
    }
    else if ( game_utility::getgametype() == "wm" && timeleft <= 0 && !flags::levelflag( "over_time_entered" ) )
    {
        hud_util::showsplashtoall( "wm_last_chance" );
        flags::levelflagset( "over_time_entered" );
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
                    setomnvarforallclients( "ui_overtime_timer", progress );
                }
            }
            else
            {
                setomnvar( "ui_overtime_timer_show", 1 );
                setomnvar( "ui_overtime_timer", progress );
                setgameendtime( gettime() + int( ( level.ontimelimitgraceperiod - level.currenttimelimitdelay ) * 1000 ) );
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

// Namespace gamelogic_mp
// Params 0
// Checksum 0xa4079b55, Offset: 0xb2f8
// Size: 0xb6
function function_bb2339fb210b8667()
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
            winner = gamescore::gethighestscoringteam();
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

// Namespace gamelogic_mp
// Params 1
// Checksum 0x4b0308b, Offset: 0xb3b6
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

// Namespace gamelogic_mp
// Params 0
// Checksum 0x782b2dc6, Offset: 0xb4c0
// Size: 0x1e
function enableovertimegameplay()
{
    level.ontimelimitgraceperiod = 5;
    level.currenttimelimitdelay = 0;
}

// Namespace gamelogic_mp
// Params 0
// Checksum 0x4a59b7b8, Offset: 0xb4e6
// Size: 0x182
function runjiprules()
{
    if ( !level.matchmakingmatch )
    {
        return;
    }
    
    if ( !level.nojip )
    {
        if ( level.gametypebundle.jipdisabled )
        {
            function_a14deb691144654e();
            return;
        }
        else if ( level.gametypebundle.var_dc9908e56ab8c95d )
        {
            if ( function_7642d039d413d595() )
            {
                function_a14deb691144654e();
            }
            
            return;
        }
        
        if ( game_utility_mp::isroundbased() )
        {
            switch ( game_utility::getgametype() )
            {
                case #"hash_4b8799075d3a89b8":
                case #"hash_f4a9126c03d3385b":
                    disablejip = checkdomjiprules();
                    break;
                case #"hash_53825b446469ac4c":
                case #"hash_5ff8e011d5b9d1c8":
                case #"hash_aac44b0b52bacb8e":
                case #"hash_e2e043391c7c9074":
                case #"hash_eb5e5f470e0c1dc2":
                case #"hash_fa37b7f6bd6f6cbf":
                case #"hash_fa50b0f6bd82e972":
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
                function_a14deb691144654e();
            }
            
            return;
        }
        
        if ( function_ea3193bcc9a30786( level.timepercentagecutoff ) )
        {
            setnojiptime( 1, 1 );
            level.nojip = 1;
        }
    }
}

// Namespace gamelogic_mp
// Params 0
// Checksum 0x1352ee29, Offset: 0xb670
// Size: 0x240, Type: bool
function function_7642d039d413d595()
{
    if ( level.gametypebundle.var_175137ae77d2422b )
    {
        if ( game_utility_mp::isfirstround() )
        {
            return false;
        }
    }
    
    if ( isdefined( level.gametypebundle.var_65f731afa6d64fdf ) )
    {
        var_a56ad9428ae01809 = getdvarint( @"hash_afb8eb12a2ece48a", 0 );
        scorecutoff = var_a56ad9428ae01809 > 0 ? var_a56ad9428ae01809 : level.gametypebundle.var_65f731afa6d64fdf;
        
        if ( function_b1a9a234a7a76f1e( scorecutoff ) )
        {
            return true;
        }
    }
    
    if ( isdefined( level.gametypebundle.var_2f9c535d8f37c369 ) )
    {
        var_b12113b804068a29 = getdvarint( @"hash_2ecbc3aed451bd4a", 0 );
        expirationround = var_b12113b804068a29 > 0 ? var_b12113b804068a29 : level.gametypebundle.var_2f9c535d8f37c369;
        
        if ( function_db245ae6e72118f1( expirationround ) )
        {
            return true;
        }
    }
    
    if ( isdefined( level.gametypebundle.var_fdff576459a2f1c4 ) )
    {
        var_75640f741e30f925 = getdvarint( @"hash_a2736d3b786399ea", 0 );
        var_ed351e6dc09ddf58 = var_75640f741e30f925 > 0 ? var_75640f741e30f925 : level.gametypebundle.var_fdff576459a2f1c4;
        
        if ( function_8be7fdc5e35b01e4( var_ed351e6dc09ddf58 ) )
        {
            return true;
        }
    }
    
    if ( isdefined( level.gametypebundle.var_d7d0651fcbeb06c8 ) )
    {
        var_bd4f02257296a1e2 = getdvarint( @"hash_d7969b1260e7e5df", 0 );
        var_6f485c09e0edc9e7 = var_bd4f02257296a1e2 > 0 ? var_bd4f02257296a1e2 : level.gametypebundle.var_d7d0651fcbeb06c8;
        
        if ( function_1538e5718fe0e7e7( var_6f485c09e0edc9e7 ) )
        {
            return true;
        }
    }
    
    checktime = !( level.gametypebundle.var_93fc3fc34f979c02 && !game_utility_mp::nextroundisfinalround() );
    
    if ( checktime )
    {
        var_b8daa473ab082b96 = getdvarint( @"hash_3c6eda16f97f7685", 0 );
        var_83bf88352af4ec6b = var_b8daa473ab082b96 > 0 ? var_b8daa473ab082b96 : level.gametypebundle.var_a40313fa8b8d7ebd;
        
        if ( function_ea3193bcc9a30786( var_83bf88352af4ec6b ?? 70 ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace gamelogic_mp
// Params 1
// Checksum 0xfed59719, Offset: 0xb8b9
// Size: 0x1d, Type: bool
function function_db245ae6e72118f1( var_e650796b8d13c9ad )
{
    if ( game[ "roundsPlayed" ] >= var_e650796b8d13c9ad )
    {
        return true;
    }
    
    return false;
}

// Namespace gamelogic_mp
// Params 1
// Checksum 0x28abc5d, Offset: 0xb8df
// Size: 0x1b0, Type: bool
function function_1538e5718fe0e7e7( var_ee163acc6271ccf7 )
{
    lowestscore = undefined;
    highestscore = undefined;
    
    if ( level.teambased )
    {
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
    }
    else
    {
        foreach ( player in level.players )
        {
            if ( !isdefined( lowestscore ) || player.score < lowestscore )
            {
                lowestscore = player.score;
            }
            
            if ( !isdefined( highestscore ) || player.score > highestscore )
            {
                highestscore = player.score;
            }
        }
    }
    
    delta = abs( highestscore - lowestscore );
    
    if ( delta >= var_ee163acc6271ccf7 )
    {
        return true;
    }
    
    return false;
}

// Namespace gamelogic_mp
// Params 1
// Checksum 0x3c1f1da6, Offset: 0xba98
// Size: 0x8e, Type: bool
function function_8be7fdc5e35b01e4( var_ed351e6dc09ddf58 )
{
    foreach ( entry in level.teamnamelist )
    {
        if ( game_utility_mp::getroundswon( entry ) >= var_ed351e6dc09ddf58 )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace gamelogic_mp
// Params 1
// Checksum 0x4a292eab, Offset: 0xbb2f
// Size: 0x11f, Type: bool
function function_b1a9a234a7a76f1e( var_88a4d9997be94cce )
{
    if ( level.teambased )
    {
        foreach ( entry in level.teamnamelist )
        {
            if ( getteamscoreint( entry ) >= var_88a4d9997be94cce )
            {
                return true;
            }
        }
    }
    else
    {
        foreach ( player in level.players )
        {
            if ( player.score >= var_88a4d9997be94cce )
            {
                return true;
            }
        }
    }
    
    return false;
}

// Namespace gamelogic_mp
// Params 1
// Checksum 0x388b72db, Offset: 0xbc57
// Size: 0x15, Type: bool
function function_ea3193bcc9a30786( var_96d8769fab16fbe )
{
    return game_utility_mp::gettimepassedpercentage() >= var_96d8769fab16fbe;
}

// Namespace gamelogic_mp
// Params 0
// Checksum 0x54558450, Offset: 0xbc75
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

// Namespace gamelogic_mp
// Params 0
// Checksum 0x2f2698d9, Offset: 0xbd1b
// Size: 0x13c, Type: bool
function function_699824bc984443db()
{
    var_95b0ae5ea76bfb8b = 3;
    
    switch ( game_utility::getgametype() )
    {
        case #"hash_aac44b0b52bacb8e":
        case #"hash_fa50b0f6bd82e972":
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

// Namespace gamelogic_mp
// Params 0
// Checksum 0x9085e6e4, Offset: 0xbe60
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

// Namespace gamelogic_mp
// Params 0
// Checksum 0xee64034c, Offset: 0xbf67
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

// Namespace gamelogic_mp
// Params 0
// Checksum 0x4aa4f7df, Offset: 0xc006
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

// Namespace gamelogic_mp
// Params 1
// Checksum 0x841b250a, Offset: 0xc031
// Size: 0x1a
function getteamscoreint( team )
{
    return int( game[ "teamScores" ][ team ] );
}

// Namespace gamelogic_mp
// Params 0
// Checksum 0x77673fbc, Offset: 0xc054
// Size: 0x3b
function gettimeremaining()
{
    var_1f29a5f42a3ac296 = 0;
    
    if ( isdefined( level.var_1f29a5f42a3ac296 ) )
    {
        var_1f29a5f42a3ac296 = level.var_1f29a5f42a3ac296;
    }
    
    return game_utility_mp::gettimelimit() * 1000 - game_utility::gettimepassed() - var_1f29a5f42a3ac296;
}

// Namespace gamelogic_mp
// Params 0
// Checksum 0xa1502341, Offset: 0xc098
// Size: 0x2c
function gettimeremainingpercentage()
{
    timelimit = game_utility_mp::gettimelimit() * 1000;
    
    if ( !timelimit )
    {
        return 0;
    }
    
    return ( timelimit - game_utility::gettimepassed() ) / timelimit;
}

// Namespace gamelogic_mp
// Params 0
// Checksum 0x7b9572c6, Offset: 0xc0cd
// Size: 0x23, Type: bool
function function_73dde611c43b49d1()
{
    percentremaining = gettimeremainingpercentage();
    
    if ( percentremaining <= 0 )
    {
        return false;
    }
    
    return true;
}

// Namespace gamelogic_mp
// Params 1
// Checksum 0x2927252, Offset: 0xc0f9
// Size: 0x20d
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
            dialog::leaderdialog( #"halfway_friendly_score", team, "status" );
            level callback::callback( #"music_event", { #team:team, #event_type:#"midpoint" } );
            enemyteams = team_utility::getenemyteams( team );
            
            foreach ( entry in enemyteams )
            {
                dialog::leaderdialog( #"halfway_enemy_score", entry, "status" );
            }
            
            level.didhalfscorevoboost = 1;
        }
    }
}

// Namespace gamelogic_mp
// Params 0
// Checksum 0xf8d50014, Offset: 0xc30e
// Size: 0xbb
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
    
    if ( !level.gametypebundle.var_dc9908e56ab8c95d )
    {
        gamescore::checkffascorejip();
    }
    
    if ( isdefined( level.checkcustomclosetoscorelimit ) )
    {
        shouldnotify = self [[ level.checkcustomclosetoscorelimit ]]();
        
        if ( shouldnotify )
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

// Namespace gamelogic_mp
// Params 1
// Checksum 0x8d581a08, Offset: 0xc3d1
// Size: 0x1c8
function checkscorelimit( allowtie )
{
    if ( !( level.gametypebundle.var_b1bd0e61615b72fe ?? 1 ) )
    {
        return 0;
    }
    
    if ( game_utility_mp::cantiebysimultaneouskill() )
    {
        allowtie = 1;
    }
    
    playerscore = self.score;
    
    if ( level.var_702ea1a2fc683e54 )
    {
        playerscore = self.pers[ "kills" ];
    }
    else if ( level.var_b9f5b44894d6b0f3 )
    {
        playerscore = self.pers[ "extrascore5" ];
    }
    
    if ( allowtie )
    {
        if ( isplayer( self ) && !level.teambased && playerscore >= level.roundscorelimit )
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
    
    if ( game_utility_mp::getgamestate() != "playing" )
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
        
        if ( playerscore < level.roundscorelimit && !level.scorelimitreached )
        {
            return 0;
        }
    }
    
    if ( !level.dontendonscore )
    {
        return onscorelimit( allowtie );
    }
}

// Namespace gamelogic_mp
// Params 0
// Checksum 0x25a67ccb, Offset: 0xc5a1
// Size: 0x46
function updategametypedvars()
{
    level endon( #"game_ended" );
    
    while ( game_utility_mp::getgamestate() == "playing" )
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

// Namespace gamelogic_mp
// Params 0
// Checksum 0x9263829f, Offset: 0xc5ef
// Size: 0x2f6
function matchstarttimerwaitforplayers()
{
    if ( utility::issharedfuncdefined( #"gametype", #"infilsequence" ) )
    {
        if ( !level.var_fd20745a67b1343c )
        {
            setomnvar( "ui_in_infil", 3 );
        }
    }
    
    if ( level.leagueplaymatch )
    {
        function_8c940255f9dd0487( level.var_246204351eddbb14, 1 );
        level thread prematchcountdownnotify();
    }
    else
    {
        if ( !isbrgamemode() )
        {
            thread matchstarttimer( "match_starting_in", level.prematchperiod + level.prematchperiodend );
        }
        
        level thread prematchcountdownnotify();
        
        if ( !isdefined( level.var_30952fa9dbaf1e04 ) )
        {
            level.var_30952fa9dbaf1e04 = getdvarint( @"hash_f88ece8f8ae0a7ca", 0 );
        }
        
        waitforplayers( level.prematchperiod, 0, istrue( level.var_30952fa9dbaf1e04 ) );
    }
    
    if ( level.prematchperiodend > 0 && !isdefined( level.hostmigrationtimer ) )
    {
        adjusted_time = level.prematchperiodend;
        
        /#
            if ( flags::gameflag( "<dev string:x7f1>" ) || flags::gameflag( "<dev string:x800>" ) )
            {
                var_96d0774b98756f11 = getdvarint( @"hash_a2cc0a7c5d5a5948", 2000 );
                stablems = 200;
                starttime = gettime();
                var_ef38d4528a973539 = level.players.size;
                stabletime = gettime();
                
                while ( true )
                {
                    elapsed = gettime() - starttime;
                    
                    if ( elapsed >= var_96d0774b98756f11 )
                    {
                        println( "<dev string:x811>" + elapsed + "<dev string:x842>" + level.players.size );
                        break;
                    }
                    
                    if ( level.players.size != var_ef38d4528a973539 )
                    {
                        var_ef38d4528a973539 = level.players.size;
                        stabletime = gettime();
                    }
                    else if ( gettime() - stabletime >= stablems )
                    {
                        println( "<dev string:x850>" + level.players.size + "<dev string:x880>" + elapsed + "<dev string:x890>" );
                        break;
                    }
                    
                    waitframe();
                }
            }
        #/
        
        level notify( #"match_start_real_countdown", adjusted_time );
        
        if ( level.leagueplaymatch )
        {
            var_676937e320b802b2 = level.prematchperiod * 2 + adjusted_time;
            level.leagueplayloadingcomplete = 1;
            level notify( #"leagueplayloadingcomplete" );
            setomnvar( "ui_mp_extended_load_screen", 0 );
            setomnvar( "ui_match_start_text", "waiting_for_players" );
            function_8c940255f9dd0487( var_676937e320b802b2, 0 );
            level.var_59cffb353d98bc10 = 0;
        }
        
        if ( !flags::gameflag( "infil_will_run" ) && game[ "roundsPlayed" ] == 0 && !game_utility::isarenamap() && game_utility::getgametype() != "dmz" )
        {
            level thread showmapchyron();
        }
        
        flags::gameflagset( "prematch_started" );
        thread matchstarttimer( "match_starting_in", adjusted_time );
        thread prematchcountdownnotify( adjusted_time );
        level waittill( #"matchstarttimer_done" );
    }
}

// Namespace gamelogic_mp
// Params 0
// Checksum 0xa15607e0, Offset: 0xc8ed
// Size: 0x39
function showmapchyron()
{
    if ( level.var_8afd2d97bc4003e4 )
    {
        return;
    }
    
    setomnvar( "ui_in_infil", 1 );
    level utility::waittill_notify_or_timeout( "matchStartTimer_done", 8 );
    setomnvar( "ui_in_infil", -1 );
}

// Namespace gamelogic_mp
// Params 1
// Checksum 0x15c8df3b, Offset: 0xc92e
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

// Namespace gamelogic_mp
// Params 1
// Checksum 0xece3c07, Offset: 0xc996
// Size: 0x75
function startmodeobjidnotify( time )
{
    self notify( #"startobjid" );
    self endon( #"startobjid" );
    
    if ( game_utility_mp::getbasegametype() == "sd" )
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

// Namespace gamelogic_mp
// Params 2
// Checksum 0x2fcb174c, Offset: 0xca13
// Size: 0x175
function matchstarttimer( type, duration )
{
    self notify( #"hash_af7e9bbaadca5367" );
    self endon( #"hash_af7e9bbaadca5367" );
    level notify( #"match_start_timer_beginning" );
    counttime = int( duration );
    level thread startmodeobjidnotify( counttime );
    setomnvar( "ui_match_start_text", type );
    matchstarttimerperplayer_internal( counttime );
    visionsetnaked( "", 0 );
    level notify( #"matchstarttimer_done" );
    
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

// Namespace gamelogic_mp
// Params 1
// Checksum 0xb4de9c03, Offset: 0xcb90
// Size: 0x186
function matchstarttimerperplayer_internal( counttime )
{
    waittillframeend();
    level endon( #"match_start_timer_beginning" );
    level endon( #"hash_eb8195ab6900b9b7" );
    mincounttime = int( counttime );
    level.matchcountdowntime = level.var_60d7e6e603923650 ?? mincounttime;
    
    if ( isbrgamemode() && !level.istrainingcourse )
    {
        thread br_public::applyprematchplotarmor( mincounttime );
        thread music_br::function_1a27a248097165ef( level.players );
    }
    
    foreach ( entry in level.teamnamelist )
    {
        childthread teamstarttimer( entry, mincounttime );
    }
    
    extrateams = [ "spectator", "codcaster" ];
    
    foreach ( entry in extrateams )
    {
        childthread teamstarttimer( entry, mincounttime );
    }
    
    childthread clearvisionsettimer( mincounttime );
    wait mincounttime;
}

// Namespace gamelogic_mp
// Params 2
// Checksum 0xc9ce1bda, Offset: 0xcd1e
// Size: 0x304
function teamstarttimer( team, counttime )
{
    level endon( #"match_start_timer_beginning" );
    level endon( #"hash_eb8195ab6900b9b7" );
    
    if ( !level.gameended )
    {
        isbrgamemode = isbrgamemode();
        
        if ( isbrgamemode )
        {
            thread br_public::prematchdialog( team );
        }
        
        var_63d1211d339bc7aa = !isbrgamemode && level.teambased && team != "spectator" && team != "codcaster" && getdvarint( @"hash_be73a4d94209c1e6" ) == 0;
        
        if ( var_63d1211d339bc7aa )
        {
            subfactionanimend = 5;
        }
        
        while ( counttime > 0 && !level.gameended )
        {
            teamarray = teams::getteamdata( team, "players" );
            
            if ( var_63d1211d339bc7aa )
            {
                var_ecc55bbf2d1a172c = counttime <= 8 && counttime >= subfactionanimend;
            }
            
            foreach ( player in teamarray )
            {
                if ( counttime <= 80 && !player.b_hide_ui_match_start_countdown )
                {
                    if ( var_63d1211d339bc7aa )
                    {
                        player setclientomnvar( "ui_show_subfaction_splash", var_ecc55bbf2d1a172c );
                    }
                    
                    player setclientomnvar( "ui_match_start_countdown", counttime );
                    player setclientomnvar( "ui_match_in_progress", 0 );
                }
            }
            
            counttime--;
            level.matchcountdowntime = counttime;
            
            if ( counttime <= 4 && !isdefined( level.playedstartingmusic ) )
            {
                level notify( #"prematch_music" );
            }
            
            wait 1;
            newcounttime = codcaster_utils::function_df0a55c77c9df04f( 1, counttime * 1000 );
            
            if ( newcounttime > 0 && counttime <= 10 )
            {
                if ( !flags::gameflag( "prematch_done" ) )
                {
                    newcounttime = 10;
                }
                
                counttime = newcounttime;
            }
        }
        
        codcaster_utils::esportsresumetimer();
        level.matchcountdowntime = undefined;
        teamarray = teams::getteamdata( team, "players" );
        roundsplayed = game[ "roundsPlayed" ];
        
        foreach ( player in teamarray )
        {
            playerlogic::clearprematchlook( player );
            player player::_freezecontrols( 0, 1 );
            
            if ( roundsplayed == 0 )
            {
                player setclientomnvar( "ui_match_start_objective", 1 );
            }
            
            player setclientomnvar( "ui_match_start_countdown", -1 );
            player setclientomnvar( "ui_match_in_progress", 1 );
        }
        
        flags::gameflagset( "prematch_values_reset" );
    }
}

// Namespace gamelogic_mp
// Params 2
// Checksum 0x69e7b588, Offset: 0xd02a
// Size: 0x10f
function function_d441498194756fb2( timems, stringoverride )
{
    level notify( #"hash_eb8195ab6900b9b7" );
    level endon( #"hash_eb8195ab6900b9b7" );
    timerstring = "match_cancelling_in";
    
    if ( isdefined( stringoverride ) )
    {
        timerstring = stringoverride;
    }
    
    setomnvar( "ui_match_start_text", timerstring );
    counttime = int( timems / 1000 );
    waittillframeend();
    
    while ( counttime > 0 && level.var_59cffb353d98bc10 )
    {
        foreach ( p in level.players )
        {
            p setclientomnvar( "ui_match_start_countdown", counttime );
            p setclientomnvar( "ui_match_in_progress", 0 );
        }
        
        counttime--;
        wait 1;
    }
}

// Namespace gamelogic_mp
// Params 1
// Checksum 0xb8cf0e2b, Offset: 0xd141
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

// Namespace gamelogic_mp
// Params 0
// Checksum 0x65a07d73, Offset: 0xd181
// Size: 0x19
function matchstarttimerskip()
{
    visionsetnaked( "", 0 );
    level notify( #"match_start_timer_skip" );
}

// Namespace gamelogic_mp
// Params 1
// Checksum 0xad8f9849, Offset: 0xd1a2
// Size: 0x157
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
    
    if ( shouldgivedefendersadvantage() && !level.gametypebundle.var_67a208701ee70f7 )
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

// Namespace gamelogic_mp
// Params 0
// Checksum 0xaef0500c, Offset: 0xd301
// Size: 0x3a, Type: bool
function shouldgivedefendersadvantage()
{
    return game[ "roundsWon" ][ "allies" ] == level.winlimit - 1 && game[ "roundsWon" ][ "axis" ] == level.winlimit - 1;
}

// Namespace gamelogic_mp
// Params 1
// Checksum 0xc0771374, Offset: 0xd344
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
    
    assert( game[ "<dev string:x894>" ] > 0 );
    
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

// Namespace gamelogic_mp
// Params 0
// Checksum 0x1ef5e837, Offset: 0xd3c0
// Size: 0x8f
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
        case #"hash_fa50b0f6bd82e972":
            if ( level.gametypebundle.var_67a208701ee70f7 && game[ "roundsPlayed" ] >= 8 )
            {
                return 1;
            }
            else
            {
                return 0;
            }
        default:
            return 0;
    }
}

// Namespace gamelogic_mp
// Params 0
// Checksum 0x34a028a, Offset: 0xd457
// Size: 0x81
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
        case #"hash_fa50b0f6bd82e972":
            if ( level.gametypebundle.var_67a208701ee70f7 && game[ "roundsPlayed" ] >= 8 )
            {
                return 1;
            }
            else
            {
                return 0;
            }
        default:
            return 0;
    }
}

// Namespace gamelogic_mp
// Params 0
// Checksum 0xb57ad422, Offset: 0xd4e0
// Size: 0xd8
function timeuntilroundend()
{
    if ( level.gameended )
    {
        gameendtime = level.gameendtime ?? gettime();
        timepassed = ( gettime() - gameendtime ) / 1000;
        timeremaining = level.postroundtime - timepassed;
        
        if ( timeremaining < 0 )
        {
            return 0;
        }
        
        return timeremaining;
    }
    
    tl = game_utility_mp::gettimelimit();
    
    if ( tl <= 0 )
    {
        return;
    }
    
    if ( !isdefined( level.starttime ) )
    {
        return;
    }
    
    timepassed = ( gettime() - level.starttime ) / 1000;
    timeremaining = level.discardtime / 1000 + tl - timepassed;
    
    if ( isdefined( level.timepaused ) )
    {
        timeremaining += level.timepaused;
    }
    
    return timeremaining + level.postroundtime;
}

// Namespace gamelogic_mp
// Params 0
// Checksum 0x65b8875b, Offset: 0xd5c1
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

// Namespace gamelogic_mp
// Params 1
// Checksum 0x969fbeb, Offset: 0xd6ea
// Size: 0x5c
function gethostplayer( fallback )
{
    players = getentarray( "player", #classname );
    
    for ( index = 0; index < players.size ; index++ )
    {
        if ( players[ index ] ishost() )
        {
            return players[ index ];
        }
    }
    
    if ( fallback )
    {
        return players[ 0 ];
    }
}

// Namespace gamelogic_mp
// Params 1
// Checksum 0x8af0f3f4, Offset: 0xd74e
// Size: 0x93, Type: bool
function function_45db3a140da5f4b1( ignoreplayer )
{
    foreach ( player in level.players )
    {
        if ( isbot( player ) )
        {
            continue;
        }
        
        if ( player != ignoreplayer )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace gamelogic_mp
// Params 0
// Checksum 0x963ae9cf, Offset: 0xd7ea
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

// Namespace gamelogic_mp
// Params 3
// Checksum 0xb1807e28, Offset: 0xd832
// Size: 0xa7
function function_a5e413a9477c6ea4( var_17c1c3aad8597da2, skippedplayer, instance )
{
    participantplayers = game_utility_mp::function_4b15b7eb1dc364e7( instance );
    
    foreach ( player in participantplayers )
    {
        player setclientomnvar( "post_game_state", var_17c1c3aad8597da2 );
    }
}

// Namespace gamelogic_mp
// Params 3
// Checksum 0xc7cc8167, Offset: 0xd8e1
// Size: 0x207
function roundendwait( defaultdelay, skippedplayer, instance )
{
    participantplayers = game_utility_mp::function_4b15b7eb1dc364e7( instance );
    
    if ( !level.doeomcombat )
    {
        wait level.postgamehitmarkerwaittime + 0.1;
        
        foreach ( player in participantplayers )
        {
            player setclientomnvar( "post_game_state", 2 );
        }
    }
    
    codcasterdelay = 0;
    
    foreach ( player in participantplayers )
    {
        player thread game_utility_mp::setuipostgamefade( 0 );
        
        if ( player iscodcaster() )
        {
            codcasterdelay = level.var_e3c3286caf6ae8b8;
        }
    }
    
    if ( level.displayroundswitch )
    {
        foreach ( player in participantplayers )
        {
            fadedelay = defaultdelay;
            
            if ( player iscodcaster() )
            {
                fadedelay += codcasterdelay;
            }
            
            fadedelay -= 0.5;
            player thread game_utility_mp::setuipostgamefade( 1, fadedelay );
        }
    }
    
    wait defaultdelay;
    wait codcasterdelay;
    function_a5e413a9477c6ea4( 1, skippedplayer, instance );
    level notify( #"round_end_finished" );
}

// Namespace gamelogic_mp
// Params 1
// Checksum 0xdfef8e47, Offset: 0xdaf0
// Size: 0x13
function roundenddof( time )
{
    player::setdof_spectator();
}

// Namespace gamelogic_mp
// Params 7
// Checksum 0x9b0c7328, Offset: 0xdb0b
// Size: 0x96
function setwaypointiconinfo( name, bgtype, teamrelative, string, icon, pulses, iconid )
{
    level.waypointcolors[ name ] = teamrelative;
    level.waypointbgtype[ name ] = bgtype;
    level.waypointstring[ name ] = string;
    level.waypointshader[ name ] = icon;
    level.waypointpulses[ name ] = pulses;
    level.var_144d9d8ca44ad231[ name ] = iconid;
}

// Namespace gamelogic_mp
// Params 2
// Checksum 0xb12e0b8a, Offset: 0xdba9
// Size: 0x23
function function_e2716c6f000db813( name, ignore )
{
    level.var_60c872155059942b[ name ] = ignore;
}

// Namespace gamelogic_mp
// Params 0
// Checksum 0xb6cbe2f7, Offset: 0xdbd4
// Size: 0x2469
function initwaypointbackgrounds()
{
    var_e1a478a31edb8885 = 0;
    var_45a7e91db67d0eed = 1;
    
    switch ( game_utility::getgametype() )
    {
        case #"hash_3e42b59314efb6d":
        case #"hash_566231b2d32896cb":
            var_45a7e91db67d0eed = 0;
        case #"hash_1e4846dca3ccf38":
        case #"hash_4cb5825e78aaa8c":
        case #"hash_ca6516c10db2c95":
        case #"hash_1b1eecd3863a50cf":
        case #"hash_2f5af599c5c220d3":
        case #"hash_3ae8dcf2840c03a0":
        case #"hash_53825b446469ac4c":
        case #"hash_63fb0ba698c46db3":
        case #"hash_7f9c384a34cc392f":
        case #"hash_99a69534b169e838":
        case #"hash_a1313b745c17c07e":
        case #"hash_d62e8de2ff636388":
        case #"hash_d82d642e83fb9772":
        case #"hash_f25c018be2dd3f5f":
        case #"hash_fa44d9f6bd7a2fa1":
            setwaypointiconinfo( "icon_waypoint_dom_a", var_e1a478a31edb8885, "neutral", &"MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_a", 0, var_45a7e91db67d0eed ? 3 : undefined );
            setwaypointiconinfo( "icon_waypoint_dom_b", var_e1a478a31edb8885, "neutral", &"MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_b", 0, var_45a7e91db67d0eed ? 5 : undefined );
            setwaypointiconinfo( "icon_waypoint_dom_c", var_e1a478a31edb8885, "neutral", &"MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_c", 0, var_45a7e91db67d0eed ? 7 : undefined );
            setwaypointiconinfo( "icon_waypoint_dom_d", var_e1a478a31edb8885, "neutral", &"MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_d", 0, undefined );
            setwaypointiconinfo( "icon_waypoint_dom_e", var_e1a478a31edb8885, "neutral", &"MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_e", 0, undefined );
            setwaypointiconinfo( "icon_waypoint_dom_f", var_e1a478a31edb8885, "neutral", &"MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_f", 0, undefined );
            setwaypointiconinfo( "icon_waypoint_dom_g", var_e1a478a31edb8885, "neutral", &"MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_g", 0, undefined );
            setwaypointiconinfo( "icon_waypoint_dom_h", var_e1a478a31edb8885, "neutral", &"MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_h", 0, undefined );
            setwaypointiconinfo( "icon_waypoint_dom_i", var_e1a478a31edb8885, "neutral", &"MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_i", 0, undefined );
            setwaypointiconinfo( "waypoint_taking_a", var_e1a478a31edb8885, "friendly", &"MP_INGAME_ONLY/OBJ_TAKING_CAPS", "icon_waypoint_dom_a", 1, var_45a7e91db67d0eed ? 3 : undefined );
            setwaypointiconinfo( "waypoint_taking_b", var_e1a478a31edb8885, "friendly", &"MP_INGAME_ONLY/OBJ_TAKING_CAPS", "icon_waypoint_dom_b", 1, var_45a7e91db67d0eed ? 5 : undefined );
            setwaypointiconinfo( "waypoint_taking_c", var_e1a478a31edb8885, "friendly", &"MP_INGAME_ONLY/OBJ_TAKING_CAPS", "icon_waypoint_dom_c", 1, var_45a7e91db67d0eed ? 7 : undefined );
            setwaypointiconinfo( "waypoint_taking_d", var_e1a478a31edb8885, "friendly", &"MP_INGAME_ONLY/OBJ_TAKING_CAPS", "icon_waypoint_dom_d", 1, undefined );
            setwaypointiconinfo( "waypoint_taking_e", var_e1a478a31edb8885, "friendly", &"MP_INGAME_ONLY/OBJ_TAKING_CAPS", "icon_waypoint_dom_e", 1, undefined );
            setwaypointiconinfo( "waypoint_taking_f", var_e1a478a31edb8885, "friendly", &"MP_INGAME_ONLY/OBJ_TAKING_CAPS", "icon_waypoint_dom_f", 1, undefined );
            setwaypointiconinfo( "waypoint_taking_g", var_e1a478a31edb8885, "friendly", &"MP_INGAME_ONLY/OBJ_TAKING_CAPS", "icon_waypoint_dom_g", 1, undefined );
            setwaypointiconinfo( "waypoint_taking_h", var_e1a478a31edb8885, "friendly", &"MP_INGAME_ONLY/OBJ_TAKING_CAPS", "icon_waypoint_dom_h", 1, undefined );
            setwaypointiconinfo( "waypoint_taking_i", var_e1a478a31edb8885, "friendly", &"MP_INGAME_ONLY/OBJ_TAKING_CAPS", "icon_waypoint_dom_i", 1, undefined );
            setwaypointiconinfo( "waypoint_capture_a", var_e1a478a31edb8885, "enemy", &"MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_a", 0, var_45a7e91db67d0eed ? 3 : undefined );
            setwaypointiconinfo( "waypoint_capture_b", var_e1a478a31edb8885, "enemy", &"MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_b", 0, var_45a7e91db67d0eed ? 5 : undefined );
            setwaypointiconinfo( "waypoint_capture_c", var_e1a478a31edb8885, "enemy", &"MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_c", 0, var_45a7e91db67d0eed ? 7 : undefined );
            setwaypointiconinfo( "waypoint_capture_d", var_e1a478a31edb8885, "enemy", &"MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_d", 0, undefined );
            setwaypointiconinfo( "waypoint_capture_e", var_e1a478a31edb8885, "enemy", &"MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_e", 0, undefined );
            setwaypointiconinfo( "waypoint_capture_f", var_e1a478a31edb8885, "enemy", &"MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_f", 0, undefined );
            setwaypointiconinfo( "waypoint_capture_g", var_e1a478a31edb8885, "enemy", &"MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_g", 0, undefined );
            setwaypointiconinfo( "waypoint_capture_h", var_e1a478a31edb8885, "enemy", &"MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_h", 0, undefined );
            setwaypointiconinfo( "waypoint_capture_i", var_e1a478a31edb8885, "enemy", &"MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_i", 0, undefined );
            setwaypointiconinfo( "waypoint_defend_a", var_e1a478a31edb8885, "friendly", &"MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_dom_a", 0, var_45a7e91db67d0eed ? 3 : undefined );
            setwaypointiconinfo( "waypoint_defend_b", var_e1a478a31edb8885, "friendly", &"MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_dom_b", 0, var_45a7e91db67d0eed ? 5 : undefined );
            setwaypointiconinfo( "waypoint_defend_c", var_e1a478a31edb8885, "friendly", &"MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_dom_c", 0, var_45a7e91db67d0eed ? 7 : undefined );
            setwaypointiconinfo( "waypoint_defend_d", var_e1a478a31edb8885, "friendly", &"MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_dom_d", 0, undefined );
            setwaypointiconinfo( "waypoint_defend_e", var_e1a478a31edb8885, "friendly", &"MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_dom_e", 0, undefined );
            setwaypointiconinfo( "waypoint_defend_f", var_e1a478a31edb8885, "friendly", &"MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_dom_f", 0, undefined );
            setwaypointiconinfo( "waypoint_defend_g", var_e1a478a31edb8885, "friendly", &"MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_dom_g", 0, undefined );
            setwaypointiconinfo( "waypoint_defend_h", var_e1a478a31edb8885, "friendly", &"MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_dom_h", 0, undefined );
            setwaypointiconinfo( "waypoint_defend_i", var_e1a478a31edb8885, "friendly", &"MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_dom_i", 0, undefined );
            setwaypointiconinfo( "waypoint_defending_a", var_e1a478a31edb8885, "friendly", &"MP_INGAME_ONLY/OBJ_DEFENDING_CAPS", "icon_waypoint_dom_a", 0, var_45a7e91db67d0eed ? 3 : undefined );
            setwaypointiconinfo( "waypoint_defending_b", var_e1a478a31edb8885, "friendly", &"MP_INGAME_ONLY/OBJ_DEFENDING_CAPS", "icon_waypoint_dom_b", 0, var_45a7e91db67d0eed ? 5 : undefined );
            setwaypointiconinfo( "waypoint_defending_c", var_e1a478a31edb8885, "friendly", &"MP_INGAME_ONLY/OBJ_DEFENDING_CAPS", "icon_waypoint_dom_c", 0, var_45a7e91db67d0eed ? 7 : undefined );
            setwaypointiconinfo( "waypoint_defending_d", var_e1a478a31edb8885, "friendly", &"MP_INGAME_ONLY/OBJ_DEFENDING_CAPS", "icon_waypoint_dom_d", 0, undefined );
            setwaypointiconinfo( "waypoint_defending_e", var_e1a478a31edb8885, "friendly", &"MP_INGAME_ONLY/OBJ_DEFENDING_CAPS", "icon_waypoint_dom_e", 0, undefined );
            setwaypointiconinfo( "waypoint_defending_f", var_e1a478a31edb8885, "friendly", &"MP_INGAME_ONLY/OBJ_DEFENDING_CAPS", "icon_waypoint_dom_f", 0, undefined );
            setwaypointiconinfo( "waypoint_defending_g", var_e1a478a31edb8885, "friendly", &"MP_INGAME_ONLY/OBJ_DEFENDING_CAPS", "icon_waypoint_dom_g", 0, undefined );
            setwaypointiconinfo( "waypoint_defending_h", var_e1a478a31edb8885, "friendly", &"MP_INGAME_ONLY/OBJ_DEFENDING_CAPS", "icon_waypoint_dom_h", 0, undefined );
            setwaypointiconinfo( "waypoint_defending_i", var_e1a478a31edb8885, "friendly", &"MP_INGAME_ONLY/OBJ_DEFENDING_CAPS", "icon_waypoint_dom_i", 0, undefined );
            setwaypointiconinfo( "waypoint_blocking_a", var_e1a478a31edb8885, "friendly", &"MP_INGAME_ONLY/OBJ_BLOCKING_CAPS", "icon_waypoint_dom_a", 1, var_45a7e91db67d0eed ? 3 : undefined );
            setwaypointiconinfo( "waypoint_blocking_b", var_e1a478a31edb8885, "friendly", &"MP_INGAME_ONLY/OBJ_BLOCKING_CAPS", "icon_waypoint_dom_b", 1, var_45a7e91db67d0eed ? 5 : undefined );
            setwaypointiconinfo( "waypoint_blocking_c", var_e1a478a31edb8885, "friendly", &"MP_INGAME_ONLY/OBJ_BLOCKING_CAPS", "icon_waypoint_dom_c", 1, var_45a7e91db67d0eed ? 7 : undefined );
            setwaypointiconinfo( "waypoint_blocking_d", var_e1a478a31edb8885, "friendly", &"MP_INGAME_ONLY/OBJ_BLOCKING_CAPS", "icon_waypoint_dom_d", 1, undefined );
            setwaypointiconinfo( "waypoint_blocking_e", var_e1a478a31edb8885, "friendly", &"MP_INGAME_ONLY/OBJ_BLOCKING_CAPS", "icon_waypoint_dom_e", 1, undefined );
            setwaypointiconinfo( "waypoint_blocking_f", var_e1a478a31edb8885, "friendly", &"MP_INGAME_ONLY/OBJ_BLOCKING_CAPS", "icon_waypoint_dom_f", 1, undefined );
            setwaypointiconinfo( "waypoint_blocking_g", var_e1a478a31edb8885, "friendly", &"MP_INGAME_ONLY/OBJ_BLOCKING_CAPS", "icon_waypoint_dom_g", 1, undefined );
            setwaypointiconinfo( "waypoint_blocking_h", var_e1a478a31edb8885, "friendly", &"MP_INGAME_ONLY/OBJ_BLOCKING_CAPS", "icon_waypoint_dom_h", 1, undefined );
            setwaypointiconinfo( "waypoint_blocking_i", var_e1a478a31edb8885, "friendly", &"MP_INGAME_ONLY/OBJ_BLOCKING_CAPS", "icon_waypoint_dom_i", 1, undefined );
            setwaypointiconinfo( "waypoint_blocked_a", var_e1a478a31edb8885, "friendly", &"MP_INGAME_ONLY/OBJ_BLOCKED_CAPS", "icon_waypoint_dom_a", 1, var_45a7e91db67d0eed ? 3 : undefined );
            setwaypointiconinfo( "waypoint_blocked_b", var_e1a478a31edb8885, "friendly", &"MP_INGAME_ONLY/OBJ_BLOCKED_CAPS", "icon_waypoint_dom_b", 1, var_45a7e91db67d0eed ? 5 : undefined );
            setwaypointiconinfo( "waypoint_blocked_c", var_e1a478a31edb8885, "friendly", &"MP_INGAME_ONLY/OBJ_BLOCKED_CAPS", "icon_waypoint_dom_c", 1, var_45a7e91db67d0eed ? 7 : undefined );
            setwaypointiconinfo( "waypoint_blocked_d", var_e1a478a31edb8885, "friendly", &"MP_INGAME_ONLY/OBJ_BLOCKED_CAPS", "icon_waypoint_dom_d", 1, undefined );
            setwaypointiconinfo( "waypoint_blocked_e", var_e1a478a31edb8885, "friendly", &"MP_INGAME_ONLY/OBJ_BLOCKED_CAPS", "icon_waypoint_dom_e", 1, undefined );
            setwaypointiconinfo( "waypoint_blocked_f", var_e1a478a31edb8885, "friendly", &"MP_INGAME_ONLY/OBJ_BLOCKED_CAPS", "icon_waypoint_dom_f", 1, undefined );
            setwaypointiconinfo( "waypoint_blocked_g", var_e1a478a31edb8885, "friendly", &"MP_INGAME_ONLY/OBJ_BLOCKED_CAPS", "icon_waypoint_dom_g", 1, undefined );
            setwaypointiconinfo( "waypoint_blocked_h", var_e1a478a31edb8885, "friendly", &"MP_INGAME_ONLY/OBJ_BLOCKED_CAPS", "icon_waypoint_dom_h", 1, undefined );
            setwaypointiconinfo( "waypoint_blocked_i", var_e1a478a31edb8885, "friendly", &"MP_INGAME_ONLY/OBJ_BLOCKED_CAPS", "icon_waypoint_dom_i", 1, undefined );
            setwaypointiconinfo( "waypoint_losing_a", var_e1a478a31edb8885, "enemy", &"MP_INGAME_ONLY/OBJ_LOSING_CAPS", "icon_waypoint_dom_a", 1, var_45a7e91db67d0eed ? 3 : undefined );
            setwaypointiconinfo( "waypoint_losing_b", var_e1a478a31edb8885, "enemy", &"MP_INGAME_ONLY/OBJ_LOSING_CAPS", "icon_waypoint_dom_b", 1, var_45a7e91db67d0eed ? 5 : undefined );
            setwaypointiconinfo( "waypoint_losing_c", var_e1a478a31edb8885, "enemy", &"MP_INGAME_ONLY/OBJ_LOSING_CAPS", "icon_waypoint_dom_c", 1, var_45a7e91db67d0eed ? 7 : undefined );
            setwaypointiconinfo( "waypoint_losing_d", var_e1a478a31edb8885, "enemy", &"MP_INGAME_ONLY/OBJ_LOSING_CAPS", "icon_waypoint_dom_d", 1, undefined );
            setwaypointiconinfo( "waypoint_losing_e", var_e1a478a31edb8885, "enemy", &"MP_INGAME_ONLY/OBJ_LOSING_CAPS", "icon_waypoint_dom_e", 1, undefined );
            setwaypointiconinfo( "waypoint_losing_f", var_e1a478a31edb8885, "enemy", &"MP_INGAME_ONLY/OBJ_LOSING_CAPS", "icon_waypoint_dom_f", 1, undefined );
            setwaypointiconinfo( "waypoint_losing_g", var_e1a478a31edb8885, "enemy", &"MP_INGAME_ONLY/OBJ_LOSING_CAPS", "icon_waypoint_dom_g", 1, undefined );
            setwaypointiconinfo( "waypoint_losing_h", var_e1a478a31edb8885, "enemy", &"MP_INGAME_ONLY/OBJ_LOSING_CAPS", "icon_waypoint_dom_h", 1, undefined );
            setwaypointiconinfo( "waypoint_losing_i", var_e1a478a31edb8885, "enemy", &"MP_INGAME_ONLY/OBJ_LOSING_CAPS", "icon_waypoint_dom_i", 1, undefined );
            setwaypointiconinfo( "waypoint_captureneutral_a", var_e1a478a31edb8885, "neutral", &"MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_a", 0, var_45a7e91db67d0eed ? 3 : undefined );
            setwaypointiconinfo( "waypoint_captureneutral_b", var_e1a478a31edb8885, "neutral", &"MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_b", 0, var_45a7e91db67d0eed ? 5 : undefined );
            setwaypointiconinfo( "waypoint_captureneutral_c", var_e1a478a31edb8885, "neutral", &"MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_c", 0, var_45a7e91db67d0eed ? 7 : undefined );
            setwaypointiconinfo( "waypoint_captureneutral_d", var_e1a478a31edb8885, "neutral", &"MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_d", 0, undefined );
            setwaypointiconinfo( "waypoint_captureneutral_e", var_e1a478a31edb8885, "neutral", &"MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_e", 0, undefined );
            setwaypointiconinfo( "waypoint_captureneutral_f", var_e1a478a31edb8885, "neutral", &"MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_f", 0, undefined );
            setwaypointiconinfo( "waypoint_captureneutral_g", var_e1a478a31edb8885, "neutral", &"MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_g", 0, undefined );
            setwaypointiconinfo( "waypoint_captureneutral_h", var_e1a478a31edb8885, "neutral", &"MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_h", 0, undefined );
            setwaypointiconinfo( "waypoint_captureneutral_i", var_e1a478a31edb8885, "neutral", &"MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_i", 0, undefined );
            setwaypointiconinfo( "waypoint_contested_a", var_e1a478a31edb8885, "contest", &"MP_INGAME_ONLY/OBJ_CONTESTED_CAPS", "icon_waypoint_dom_a", 1, var_45a7e91db67d0eed ? 3 : undefined );
            setwaypointiconinfo( "waypoint_contested_b", var_e1a478a31edb8885, "contest", &"MP_INGAME_ONLY/OBJ_CONTESTED_CAPS", "icon_waypoint_dom_b", 1, var_45a7e91db67d0eed ? 5 : undefined );
            setwaypointiconinfo( "waypoint_contested_c", var_e1a478a31edb8885, "contest", &"MP_INGAME_ONLY/OBJ_CONTESTED_CAPS", "icon_waypoint_dom_c", 1, var_45a7e91db67d0eed ? 7 : undefined );
            setwaypointiconinfo( "waypoint_contested_d", var_e1a478a31edb8885, "contest", &"MP_INGAME_ONLY/OBJ_CONTESTED_CAPS", "icon_waypoint_dom_d", 1, undefined );
            setwaypointiconinfo( "waypoint_contested_e", var_e1a478a31edb8885, "contest", &"MP_INGAME_ONLY/OBJ_CONTESTED_CAPS", "icon_waypoint_dom_e", 1, undefined );
            setwaypointiconinfo( "waypoint_contested_f", var_e1a478a31edb8885, "contest", &"MP_INGAME_ONLY/OBJ_CONTESTED_CAPS", "icon_waypoint_dom_f", 1, undefined );
            setwaypointiconinfo( "waypoint_contested_g", var_e1a478a31edb8885, "contest", &"MP_INGAME_ONLY/OBJ_CONTESTED_CAPS", "icon_waypoint_dom_g", 1, undefined );
            setwaypointiconinfo( "waypoint_contested_h", var_e1a478a31edb8885, "contest", &"MP_INGAME_ONLY/OBJ_CONTESTED_CAPS", "icon_waypoint_dom_h", 1, undefined );
            setwaypointiconinfo( "waypoint_contested_i", var_e1a478a31edb8885, "contest", &"MP_INGAME_ONLY/OBJ_CONTESTED_CAPS", "icon_waypoint_dom_i", 1, undefined );
            setwaypointiconinfo( "waypoint_dom_target_a", var_e1a478a31edb8885, "neutral", &"MP_INGAME_ONLY/OBJ_TARGET_CAPS", "icon_waypoint_dom_a", 0, var_45a7e91db67d0eed ? 3 : undefined );
            setwaypointiconinfo( "waypoint_dom_target_b", var_e1a478a31edb8885, "neutral", &"MP_INGAME_ONLY/OBJ_TARGET_CAPS", "icon_waypoint_dom_b", 0, var_45a7e91db67d0eed ? 5 : undefined );
            setwaypointiconinfo( "waypoint_dom_target_c", var_e1a478a31edb8885, "neutral", &"MP_INGAME_ONLY/OBJ_TARGET_CAPS", "icon_waypoint_dom_c", 0, var_45a7e91db67d0eed ? 7 : undefined );
            setwaypointiconinfo( "waypoint_dom_target_d", var_e1a478a31edb8885, "neutral", &"MP_INGAME_ONLY/OBJ_TARGET_CAPS", "icon_waypoint_dom_d", 0, undefined );
            setwaypointiconinfo( "waypoint_dom_target_e", var_e1a478a31edb8885, "neutral", &"MP_INGAME_ONLY/OBJ_TARGET_CAPS", "icon_waypoint_dom_e", 0, undefined );
            setwaypointiconinfo( "waypoint_dom_target_f", var_e1a478a31edb8885, "neutral", &"MP_INGAME_ONLY/OBJ_TARGET_CAPS", "icon_waypoint_dom_f", 0, undefined );
            setwaypointiconinfo( "waypoint_dom_target_g", var_e1a478a31edb8885, "neutral", &"MP_INGAME_ONLY/OBJ_TARGET_CAPS", "icon_waypoint_dom_g", 0, undefined );
            setwaypointiconinfo( "waypoint_dom_target_h", var_e1a478a31edb8885, "neutral", &"MP_INGAME_ONLY/OBJ_TARGET_CAPS", "icon_waypoint_dom_h", 0, undefined );
            setwaypointiconinfo( "waypoint_dom_target_i", var_e1a478a31edb8885, "neutral", &"MP_INGAME_ONLY/OBJ_TARGET_CAPS", "icon_waypoint_dom_i", 0, undefined );
            setwaypointiconinfo( "waypoint_clearing_a", var_e1a478a31edb8885, "friendly", &"MP_INGAME_ONLY/OBJ_CLEARING_CAPS", "icon_waypoint_dom_a", 1, var_45a7e91db67d0eed ? 3 : undefined );
            setwaypointiconinfo( "waypoint_clearing_b", var_e1a478a31edb8885, "friendly", &"MP_INGAME_ONLY/OBJ_CLEARING_CAPS", "icon_waypoint_dom_b", 1, var_45a7e91db67d0eed ? 5 : undefined );
            setwaypointiconinfo( "waypoint_clearing_c", var_e1a478a31edb8885, "friendly", &"MP_INGAME_ONLY/OBJ_CLEARING_CAPS", "icon_waypoint_dom_c", 1, var_45a7e91db67d0eed ? 7 : undefined );
            setwaypointiconinfo( "waypoint_clearing_d", var_e1a478a31edb8885, "friendly", &"MP_INGAME_ONLY/OBJ_CLEARING_CAPS", "icon_waypoint_dom_d", 1, undefined );
            setwaypointiconinfo( "waypoint_clearing_e", var_e1a478a31edb8885, "friendly", &"MP_INGAME_ONLY/OBJ_CLEARING_CAPS", "icon_waypoint_dom_e", 1, undefined );
            setwaypointiconinfo( "waypoint_clearing_f", var_e1a478a31edb8885, "friendly", &"MP_INGAME_ONLY/OBJ_CLEARING_CAPS", "icon_waypoint_dom_f", 1, undefined );
            setwaypointiconinfo( "waypoint_clearing_g", var_e1a478a31edb8885, "friendly", &"MP_INGAME_ONLY/OBJ_CLEARING_CAPS", "icon_waypoint_dom_g", 1, undefined );
            setwaypointiconinfo( "waypoint_clearing_h", var_e1a478a31edb8885, "friendly", &"MP_INGAME_ONLY/OBJ_CLEARING_CAPS", "icon_waypoint_dom_h", 1, undefined );
            setwaypointiconinfo( "waypoint_clearing_i", var_e1a478a31edb8885, "friendly", &"MP_INGAME_ONLY/OBJ_CLEARING_CAPS", "icon_waypoint_dom_i", 1, undefined );
            setwaypointiconinfo( "waypoint_reinforcing_a", var_e1a478a31edb8885, "friendly", &"MP_INGAME_ONLY/OBJ_REINFORCING_CAPS", "icon_waypoint_dom_a", 1, var_45a7e91db67d0eed ? 3 : undefined );
            setwaypointiconinfo( "waypoint_reinforcing_b", var_e1a478a31edb8885, "friendly", &"MP_INGAME_ONLY/OBJ_REINFORCING_CAPS", "icon_waypoint_dom_b", 1, var_45a7e91db67d0eed ? 5 : undefined );
            setwaypointiconinfo( "waypoint_reinforcing_c", var_e1a478a31edb8885, "friendly", &"MP_INGAME_ONLY/OBJ_REINFORCING_CAPS", "icon_waypoint_dom_c", 1, var_45a7e91db67d0eed ? 7 : undefined );
            setwaypointiconinfo( "waypoint_reinforcing_d", var_e1a478a31edb8885, "friendly", &"MP_INGAME_ONLY/OBJ_REINFORCING_CAPS", "icon_waypoint_dom_d", 1, undefined );
            setwaypointiconinfo( "waypoint_reinforcing_e", var_e1a478a31edb8885, "friendly", &"MP_INGAME_ONLY/OBJ_REINFORCING_CAPS", "icon_waypoint_dom_e", 1, undefined );
            setwaypointiconinfo( "waypoint_reinforcing_f", var_e1a478a31edb8885, "friendly", &"MP_INGAME_ONLY/OBJ_REINFORCING_CAPS", "icon_waypoint_dom_f", 1, undefined );
            setwaypointiconinfo( "waypoint_reinforcing_g", var_e1a478a31edb8885, "friendly", &"MP_INGAME_ONLY/OBJ_REINFORCING_CAPS", "icon_waypoint_dom_g", 1, undefined );
            setwaypointiconinfo( "waypoint_reinforcing_h", var_e1a478a31edb8885, "friendly", &"MP_INGAME_ONLY/OBJ_REINFORCING_CAPS", "icon_waypoint_dom_h", 1, undefined );
            setwaypointiconinfo( "waypoint_reinforcing_i", var_e1a478a31edb8885, "friendly", &"MP_INGAME_ONLY/OBJ_REINFORCING_CAPS", "icon_waypoint_dom_i", 1, undefined );
            setwaypointiconinfo( "waypoint_locked_a", var_e1a478a31edb8885, "neutral", &"MP_INGAME_ONLY/OBJ_TARGET_CAPS", "icon_waypoint_locked", 0, var_45a7e91db67d0eed ? 3 : undefined );
            setwaypointiconinfo( "waypoint_locked_b", var_e1a478a31edb8885, "neutral", &"MP_INGAME_ONLY/OBJ_TARGET_CAPS", "icon_waypoint_locked", 0, var_45a7e91db67d0eed ? 5 : undefined );
            setwaypointiconinfo( "waypoint_locked_c", var_e1a478a31edb8885, "neutral", &"MP_INGAME_ONLY/OBJ_TARGET_CAPS", "icon_waypoint_locked", 0, var_45a7e91db67d0eed ? 7 : undefined );
            setwaypointiconinfo( "waypoint_locked_d", var_e1a478a31edb8885, "neutral", &"MP_INGAME_ONLY/OBJ_TARGET_CAPS", "icon_waypoint_locked", 0, undefined );
            setwaypointiconinfo( "waypoint_locked_e", var_e1a478a31edb8885, "neutral", &"MP_INGAME_ONLY/OBJ_TARGET_CAPS", "icon_waypoint_locked", 0, undefined );
            setwaypointiconinfo( "waypoint_locked_f", var_e1a478a31edb8885, "neutral", &"MP_INGAME_ONLY/OBJ_TARGET_CAPS", "icon_waypoint_locked", 0, undefined );
            setwaypointiconinfo( "waypoint_locked_g", var_e1a478a31edb8885, "neutral", &"MP_INGAME_ONLY/OBJ_TARGET_CAPS", "icon_waypoint_locked", 0, undefined );
            setwaypointiconinfo( "waypoint_locked_h", var_e1a478a31edb8885, "neutral", &"MP_INGAME_ONLY/OBJ_TARGET_CAPS", "icon_waypoint_locked", 0, undefined );
            setwaypointiconinfo( "waypoint_locked_i", var_e1a478a31edb8885, "neutral", &"MP_INGAME_ONLY/OBJ_TARGET_CAPS", "icon_waypoint_locked", 0, undefined );
            setwaypointiconinfo( "icon_waypoint_dom_captured", var_e1a478a31edb8885, "codcaster", "", "esports_codcaster_minimap_checkmark", 0, 11 );
            break;
        case #"hash_514cd9d568e312b0":
        case #"hash_aac44b0b52bacb8e":
        case #"hash_dd217fc2f74cbcdd":
        case #"hash_fa0ed2f6bd4f4395":
        case #"hash_fa50b0f6bd82e972":
            setwaypointiconinfo( "waypoint_bomb", 2, "friendly", &"mp_ingame_only/obj_bomb_caps", "icon_waypoint_bomb", 1, 15 );
            setwaypointiconinfo( "icon_waypoint_escort_bomb", 2, "neutral", &"MP_INGAME_ONLY/OBJ_ESCORT_CAPS", "icon_waypoint_bomb", 0, 10 );
            setwaypointiconinfo( "codcaster_enemy_escort_bomb", 1, "enemy", &"MP_INGAME_ONLY/OBJ_TARGET_CAPS", "icon_waypoint_bomb", 0, 10 );
            setwaypointiconinfo( "waypoint_target_a", 0, "enemy", &"MP_INGAME_ONLY/OBJ_TARGET_CAPS", "icon_waypoint_dom_a", 0, 3 );
            setwaypointiconinfo( "waypoint_target_b", 0, "enemy", &"MP_INGAME_ONLY/OBJ_TARGET_CAPS", "icon_waypoint_dom_b", 0, 5 );
            setwaypointiconinfo( "waypoint_bomb_defusing_a", 0, "enemy", &"mp_ingame_only/obj_defusing_caps", "icon_waypoint_dom_a", 0, 4 );
            setwaypointiconinfo( "waypoint_bomb_defusing_b", 0, "enemy", &"mp_ingame_only/obj_defusing_caps", "icon_waypoint_dom_b", 0, 6 );
            setwaypointiconinfo( "waypoint_bomb_planting_a", 0, "enemy", &"mp_ingame_only/obj_planting_caps", "icon_waypoint_dom_a", 0, 3 );
            setwaypointiconinfo( "waypoint_bomb_planting_b", 0, "enemy", &"mp_ingame_only/obj_planting_caps", "icon_waypoint_dom_b", 0, 5 );
            setwaypointiconinfo( "waypoint_defuse_a", 0, "enemy", &"MP_INGAME_ONLY/OBJ_DEFUSE_CAPS", "icon_waypoint_bomb", 0, 4 );
            setwaypointiconinfo( "waypoint_defuse_b", 0, "enemy", &"MP_INGAME_ONLY/OBJ_DEFUSE_CAPS", "icon_waypoint_bomb", 0, 6 );
            
            if ( level.gamemodebundle.var_4dc63b2cff079d78 )
            {
                setwaypointiconinfo( "waypoint_bomb_defend_a", 0, "friendly", &"mp_ingame_only/obj_protect_caps", "icon_waypoint_dom_a", 0, 4 );
                setwaypointiconinfo( "waypoint_bomb_defend_b", 0, "friendly", &"mp_ingame_only/obj_protect_caps", "icon_waypoint_dom_b", 0, 6 );
            }
            else
            {
                setwaypointiconinfo( "waypoint_bomb_defend_a", 0, "friendly", &"MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_dom_a", 0, 4 );
                setwaypointiconinfo( "waypoint_bomb_defend_b", 0, "friendly", &"MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_dom_b", 0, 6 );
            }
            
            setwaypointiconinfo( "waypoint_defend_a", 0, "friendly", &"MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_dom_a", 0, 3 );
            setwaypointiconinfo( "waypoint_defend_b", 0, "friendly", &"MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_dom_b", 0, 5 );
            setwaypointiconinfo( "waypoint_defend_c", 0, "friendly", &"MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_dom_c", 0, 7 );
            setwaypointiconinfo( "waypoint_defend_d", 0, "friendly", &"MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_dom_d", 0, 8 );
            setwaypointiconinfo( "waypoint_defend_e", 0, "friendly", &"MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_dom_e", 0, 9 );
            setwaypointiconinfo( "waypoint_defuse_nt_a", 0, "enemy", "", "icon_waypoint_dom_a", 0, 4 );
            setwaypointiconinfo( "waypoint_defuse_nt_b", 0, "enemy", "", "icon_waypoint_dom_b", 0, 6 );
            setwaypointiconinfo( "waypoint_bomb_defend_nt_a", 0, "friendly", "", "icon_waypoint_dom_a", 0, 4 );
            setwaypointiconinfo( "waypoint_bomb_defend_nt_b", 0, "friendly", "", "icon_waypoint_dom_b", 0, 6 );
            setwaypointiconinfo( "waypoint_locked_a", 0, "enemy", &"MP_INGAME_ONLY/OBJ_LOCKED_CAPS", "icon_waypoint_dom_a", 0, 3 );
            setwaypointiconinfo( "waypoint_locked_b", 0, "enemy", &"MP_INGAME_ONLY/OBJ_LOCKED_CAPS", "icon_waypoint_dom_b", 0, 5 );
            setwaypointiconinfo( "waypoint_locked_c", 0, "enemy", &"MP_INGAME_ONLY/OBJ_LOCKED_CAPS", "icon_waypoint_dom_c", 0, 7 );
            setwaypointiconinfo( "waypoint_locked_d", 0, "enemy", &"MP_INGAME_ONLY/OBJ_LOCKED_CAPS", "icon_waypoint_dom_d", 0, 8 );
            setwaypointiconinfo( "waypoint_locked_e", 0, "enemy", &"MP_INGAME_ONLY/OBJ_LOCKED_CAPS", "icon_waypoint_dom_e", 0, 9 );
            break;
        case #"hash_681e57e53a02403":
            setwaypointiconinfo( "waypoint_target_a", 0, "enemy", &"MP_INGAME_ONLY/OBJ_TARGET_CAPS", "ui_rex_icon_obj_site", 0, 3 );
            setwaypointiconinfo( "waypoint_target_b", 0, "enemy", &"MP_INGAME_ONLY/OBJ_TARGET_CAPS", "ui_rex_icon_obj_site", 0, 5 );
            setwaypointiconinfo( "waypoint_bomb_defusing_a", 0, "enemy", &"mp_ingame_only/obj_defusing_caps", "ui_rex_icon_obj_site", 0, 3 );
            setwaypointiconinfo( "waypoint_bomb_defusing_b", 0, "enemy", &"mp_ingame_only/obj_defusing_caps", "ui_rex_icon_obj_site", 0, 6 );
            setwaypointiconinfo( "waypoint_bomb_planting_a", 0, "enemy", &"mp_ingame_only/obj_planting_caps", "ui_rex_icon_obj_site", 0, 3 );
            setwaypointiconinfo( "waypoint_bomb_planting_b", 0, "enemy", &"mp_ingame_only/obj_planting_caps", "ui_rex_icon_obj_site", 0, 5 );
            setwaypointiconinfo( "waypoint_defuse_a", 0, "enemy", &"MP_INGAME_ONLY/OBJ_DEFUSE_CAPS", "ui_rex_icon_obj_bomb_ca", 0, 4 );
            setwaypointiconinfo( "waypoint_defuse_b", 0, "enemy", &"MP_INGAME_ONLY/OBJ_DEFUSE_CAPS", "ui_rex_icon_obj_bomb_ca", 0, 6 );
            setwaypointiconinfo( "waypoint_bomb_defend_a", 0, "friendly", &"mp_ingame_only/obj_protect_caps", "ui_rex_icon_obj_site", 0, 4 );
            setwaypointiconinfo( "waypoint_bomb_defend_b", 0, "friendly", &"mp_ingame_only/obj_protect_caps", "ui_rex_icon_obj_site", 0, 6 );
            setwaypointiconinfo( "waypoint_defend_a", 0, "friendly", &"MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "ui_rex_icon_obj_site", 0, 3 );
            setwaypointiconinfo( "waypoint_defend_b", 0, "friendly", &"MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "ui_rex_icon_obj_site", 0, 5 );
            setwaypointiconinfo( "waypoint_defuse_nt_a", 0, "enemy", "", "ui_rex_icon_obj_bomb_ca", 0, 4 );
            setwaypointiconinfo( "waypoint_defuse_nt_b", 0, "enemy", "", "ui_rex_icon_obj_bomb_ca", 0, 6 );
            setwaypointiconinfo( "waypoint_bomb_defend_nt_a", 0, "friendly", "", "ui_rex_icon_obj_bomb_ca", 0, 4 );
            setwaypointiconinfo( "waypoint_bomb_defend_nt_b", 0, "friendly", "", "ui_rex_icon_obj_bomb_ca", 0, 6 );
            setwaypointiconinfo( "waypoint_locked_a", 0, "enemy", &"MP_INGAME_ONLY/OBJ_LOCKED_CAPS", "ui_rex_icon_obj_site", 0, 3 );
            setwaypointiconinfo( "waypoint_locked_b", 0, "enemy", &"MP_INGAME_ONLY/OBJ_LOCKED_CAPS", "ui_rex_icon_obj_site", 0, 5 );
            break;
        case #"hash_9a6f07d0214a87db":
            setwaypointiconinfo( "waypoint_defend_a", 0, "friendly", &"MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_dom_a", 0, undefined );
            setwaypointiconinfo( "waypoint_defend_b", 0, "friendly", &"MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_dom_b", 0, undefined );
            setwaypointiconinfo( "waypoint_defend_c", 0, "friendly", &"MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_dom_c", 0, undefined );
            setwaypointiconinfo( "waypoint_defend_d", 0, "friendly", &"MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_dom_d", 0, undefined );
            setwaypointiconinfo( "waypoint_defend_e", 0, "friendly", &"MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_dom_e", 0, undefined );
            setwaypointiconinfo( "waypoint_defend_f", 0, "friendly", &"MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_dom_f", 0, undefined );
            setwaypointiconinfo( "waypoint_target_a", 0, "enemy", &"MP_INGAME_ONLY/OBJ_TARGET_CAPS", "icon_waypoint_dom_a", 0, undefined );
            setwaypointiconinfo( "waypoint_target_b", 0, "enemy", &"MP_INGAME_ONLY/OBJ_TARGET_CAPS", "icon_waypoint_dom_b", 0, undefined );
            setwaypointiconinfo( "waypoint_target_c", 0, "enemy", &"MP_INGAME_ONLY/OBJ_TARGET_CAPS", "icon_waypoint_dom_c", 0, undefined );
            setwaypointiconinfo( "waypoint_target_d", 0, "enemy", &"MP_INGAME_ONLY/OBJ_TARGET_CAPS", "icon_waypoint_dom_d", 0, undefined );
            setwaypointiconinfo( "waypoint_target_e", 0, "enemy", &"MP_INGAME_ONLY/OBJ_TARGET_CAPS", "icon_waypoint_dom_e", 0, undefined );
            setwaypointiconinfo( "waypoint_target_f", 0, "enemy", &"MP_INGAME_ONLY/OBJ_TARGET_CAPS", "icon_waypoint_dom_f", 0, undefined );
            setwaypointiconinfo( "waypoint_bomb_planting_a", 0, "enemy", &"mp_ingame_only/obj_planting_caps", "icon_waypoint_dom_a", 0, undefined );
            setwaypointiconinfo( "waypoint_bomb_planting_b", 0, "enemy", &"mp_ingame_only/obj_planting_caps", "icon_waypoint_dom_b", 0, undefined );
            setwaypointiconinfo( "waypoint_bomb_planting_c", 0, "enemy", &"mp_ingame_only/obj_planting_caps", "icon_waypoint_dom_c", 0, undefined );
            setwaypointiconinfo( "waypoint_bomb_planting_d", 0, "enemy", &"mp_ingame_only/obj_planting_caps", "icon_waypoint_dom_d", 0, undefined );
            setwaypointiconinfo( "waypoint_bomb_planting_e", 0, "enemy", &"mp_ingame_only/obj_planting_caps", "icon_waypoint_dom_e", 0, undefined );
            setwaypointiconinfo( "waypoint_bomb_planting_f", 0, "enemy", &"mp_ingame_only/obj_planting_caps", "icon_waypoint_dom_f", 0, undefined );
            setwaypointiconinfo( "waypoint_defuse_a", 0, "enemy", &"MP_INGAME_ONLY/OBJ_DEFUSE_CAPS", "icon_waypoint_dom_a", 0, undefined );
            setwaypointiconinfo( "waypoint_defuse_b", 0, "enemy", &"MP_INGAME_ONLY/OBJ_DEFUSE_CAPS", "icon_waypoint_dom_b", 0, undefined );
            setwaypointiconinfo( "waypoint_defuse_c", 0, "enemy", &"MP_INGAME_ONLY/OBJ_DEFUSE_CAPS", "icon_waypoint_dom_c", 0, undefined );
            setwaypointiconinfo( "waypoint_defuse_d", 0, "enemy", &"MP_INGAME_ONLY/OBJ_DEFUSE_CAPS", "icon_waypoint_dom_d", 0, undefined );
            setwaypointiconinfo( "waypoint_defuse_e", 0, "enemy", &"MP_INGAME_ONLY/OBJ_DEFUSE_CAPS", "icon_waypoint_dom_e", 0, undefined );
            setwaypointiconinfo( "waypoint_defuse_f", 0, "enemy", &"MP_INGAME_ONLY/OBJ_DEFUSE_CAPS", "icon_waypoint_dom_f", 0, undefined );
            setwaypointiconinfo( "waypoint_bomb_defusing_a", 0, "friendly", &"mp_ingame_only/obj_defusing_caps", "icon_waypoint_dom_a", 0, undefined );
            setwaypointiconinfo( "waypoint_bomb_defusing_b", 0, "friendly", &"mp_ingame_only/obj_defusing_caps", "icon_waypoint_dom_b", 0, undefined );
            setwaypointiconinfo( "waypoint_bomb_defusing_c", 0, "friendly", &"mp_ingame_only/obj_defusing_caps", "icon_waypoint_dom_c", 0, undefined );
            setwaypointiconinfo( "waypoint_bomb_defusing_d", 0, "friendly", &"mp_ingame_only/obj_defusing_caps", "icon_waypoint_dom_d", 0, undefined );
            setwaypointiconinfo( "waypoint_bomb_defusing_e", 0, "friendly", &"mp_ingame_only/obj_defusing_caps", "icon_waypoint_dom_e", 0, undefined );
            setwaypointiconinfo( "waypoint_bomb_defusing_f", 0, "friendly", &"mp_ingame_only/obj_defusing_caps", "icon_waypoint_dom_f", 0, undefined );
            setwaypointiconinfo( "waypoint_bomb_defend_nt_a", 0, "enemy", "", "icon_waypoint_dom_a", 0, undefined );
            setwaypointiconinfo( "waypoint_bomb_defend_nt_b", 0, "enemy", "", "icon_waypoint_dom_b", 0, undefined );
            setwaypointiconinfo( "waypoint_bomb_defend_nt_c", 0, "enemy", "", "icon_waypoint_dom_c", 0, undefined );
            setwaypointiconinfo( "waypoint_bomb_defend_nt_d", 0, "enemy", "", "icon_waypoint_dom_d", 0, undefined );
            setwaypointiconinfo( "waypoint_bomb_defend_nt_e", 0, "enemy", "", "icon_waypoint_dom_e", 0, undefined );
            setwaypointiconinfo( "waypoint_bomb_defend_nt_f", 0, "enemy", "", "icon_waypoint_dom_f", 0, undefined );
            setwaypointiconinfo( "waypoint_defuse_nt_a", 0, "friendly", "", "icon_waypoint_dom_a", 0, undefined );
            setwaypointiconinfo( "waypoint_defuse_nt_b", 0, "friendly", "", "icon_waypoint_dom_b", 0, undefined );
            setwaypointiconinfo( "waypoint_defuse_nt_c", 0, "friendly", "", "icon_waypoint_dom_c", 0, undefined );
            setwaypointiconinfo( "waypoint_defuse_nt_d", 0, "friendly", "", "icon_waypoint_dom_d", 0, undefined );
            setwaypointiconinfo( "waypoint_defuse_nt_e", 0, "friendly", "", "icon_waypoint_dom_e", 0, undefined );
            setwaypointiconinfo( "waypoint_defuse_nt_f", 0, "friendly", "", "icon_waypoint_dom_f", 0, undefined );
            setwaypointiconinfo( "waypoint_locked_a", 0, "enemy", &"MP_INGAME_ONLY/OBJ_LOCKED_CAPS", "icon_waypoint_dom_a", 0, undefined );
            setwaypointiconinfo( "waypoint_locked_b", 0, "enemy", &"MP_INGAME_ONLY/OBJ_LOCKED_CAPS", "icon_waypoint_dom_b", 0, undefined );
            setwaypointiconinfo( "waypoint_locked_c", 0, "enemy", &"MP_INGAME_ONLY/OBJ_LOCKED_CAPS", "icon_waypoint_dom_c", 0, undefined );
            setwaypointiconinfo( "waypoint_locked_d", 0, "enemy", &"MP_INGAME_ONLY/OBJ_LOCKED_CAPS", "icon_waypoint_dom_d", 0, undefined );
            setwaypointiconinfo( "waypoint_locked_e", 0, "enemy", &"MP_INGAME_ONLY/OBJ_LOCKED_CAPS", "icon_waypoint_dom_e", 0, undefined );
            setwaypointiconinfo( "waypoint_locked_f", 0, "enemy", &"MP_INGAME_ONLY/OBJ_LOCKED_CAPS", "icon_waypoint_dom_f", 0, undefined );
            break;
        case #"hash_214e6c6c1b43ae4a":
        case #"hash_aada280b52cbdd96":
        case #"hash_c7f4420f385eeb3d":
            setwaypointiconinfo( "hq_destroy", 0, "enemy", &"mp_ingame_only/obj_destroy_caps", "icon_waypoint_hq", 0, 1 );
            setwaypointiconinfo( "hq_defend", 0, "friendly", &"MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_hq", 0, 1 );
            setwaypointiconinfo( "hq_defending", 0, "friendly", &"MP_INGAME_ONLY/OBJ_DEFENDING_CAPS", "icon_waypoint_hq", 0, 1 );
            setwaypointiconinfo( "hq_neutral", 0, "neutral", &"MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_hq", 0, 1 );
            setwaypointiconinfo( "hq_contested", 0, "contest", &"MP_INGAME_ONLY/OBJ_CONTESTED_CAPS", "icon_waypoint_hq", 0, 1 );
            setwaypointiconinfo( "hq_losing", 0, "enemy", &"MP_INGAME_ONLY/OBJ_LOSING_CAPS", "icon_waypoint_hq", 0, 1 );
            setwaypointiconinfo( "hq_target", 0, "neutral", &"MP_INGAME_ONLY/OBJ_TARGET_CAPS", "icon_waypoint_locked", 0, 2 );
            setwaypointiconinfo( "hq_taking", 0, "friendly", &"mp_ingame_only/obj_destroying_caps", "icon_waypoint_hq", 0, 1 );
        case #"hash_c065cef60f38490a":
            setwaypointiconinfo( "carepackage_incoming", 1, "neutral", &"mp_ingame_only/incoming_obj_caps", "hud_icon_killstreak_carepackage", 0, undefined );
            setwaypointiconinfo( "carepackage", 1, "neutral", "", "hud_icon_killstreak_carepackage", 0, undefined );
            break;
        default:
            break;
    }
    
    if ( game_utility::getgametype() == "conf_v" )
    {
        setwaypointiconinfo( "waypoint_dogtags", 1, "enemy", "", "hud_icon_minimap_vial", 0, 15 );
        setwaypointiconinfo( "waypoint_dogtags_friendly", 1, "friendly", "", "hud_icon_minimap_vial", 0, 15 );
    }
    else if ( game_utility::getgametype() == "multi" )
    {
        tag_icon = level.var_93532ab90ccea78c.var_a0a37d3d8457a5f6;
        setwaypointiconinfo( "waypoint_dogtags", 1, "enemy", "", tag_icon, 0, 15 );
        setwaypointiconinfo( "waypoint_dogtags_friendly", 1, "friendly", "", tag_icon, 0, 15 );
    }
    else
    {
        setwaypointiconinfo( "waypoint_dogtags", 1, "enemy", "", level.gametypebundle.var_39a67d9c50b480c4 ?? "hud_icon_minimap_misc_dog_tag", 0, 15 );
        setwaypointiconinfo( "waypoint_dogtags_friendly", 1, "friendly", "", level.gametypebundle.var_7583d2a92ccb905d ?? "hud_icon_minimap_misc_dog_tag", 0, 15 );
    }
    
    function_e2716c6f000db813( "waypoint_dogtags", 1 );
    function_e2716c6f000db813( "waypoint_dogtags_friendly", 1 );
    setwaypointiconinfo( "icon_waypoint_locked", 0, "neutral", "MP_INGAME_ONLY/OBJ_LOCKED_CAPS", "icon_waypoint_locked", 0, undefined );
    setwaypointiconinfo( "waypoint_capture_kill", 0, "enemy", "MP_INGAME_ONLY/OBJ_KILL_CAPS", "icon_waypoint_kill", 0, undefined );
    setwaypointiconinfo( "waypoint_escort", 2, "friendly", "MP_INGAME_ONLY/OBJ_ESCORT_CAPS", "icon_waypoint_escort", 0, undefined );
}

// Namespace gamelogic_mp
// Params 1
// Checksum 0x9bcbee6e, Offset: 0x10045
// Size: 0x441
function function_ace7db126cc8ad37( clientnumvalue )
{
    println( "<dev string:x8a1>" );
    
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
            player.pers[ "telemetry" ].match_end_selection = "Play Again with Squad";
            
            if ( playerclientnum == clientnumvalue )
            {
                println( "<dev string:x8df>" + clientnumvalue + "<dev string:x912>" + playerclientnum + "<dev string:x92f>" + player.name );
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
                        println( "<dev string:x946>" + clientnumvalue + "<dev string:x92f>" + player.name + "<dev string:x972>" + playerxuid );
                        teams::setteamdata( player.team, "playagainHostXuid", playerxuid );
                    }
                }
                else if ( hostxuid == playerxuid )
                {
                    println( "<dev string:x946>" + clientnumvalue + "<dev string:x92f>" + player.name + "<dev string:x9a0>" );
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

// Namespace gamelogic_mp
// Params 0
// Checksum 0xde63735c, Offset: 0x1048f
// Size: 0x254
function function_38ce20e801f80a51()
{
    println( "<dev string:x9e4>" );
    
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
                        
                        println( "<dev string:xa0c>" + player.name + "<dev string:xa31>" + player.team );
                        
                        if ( isdefined( player.var_acecf5cb67174177 ) && player.var_acecf5cb67174177 )
                        {
                            println( "<dev string:xa46>" + player.name + "<dev string:xa31>" + player.team + "<dev string:xa7e>" + playagainhostxuid );
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

// Namespace gamelogic_mp
// Params 0
// Checksum 0xebbe7da8, Offset: 0x106eb
// Size: 0x1a2
function function_660b7766ecc7584a()
{
    if ( !isbrgamemode() )
    {
        return;
    }
    
    playerposition = 0;
    
    while ( true )
    {
        endgamesplash = getdvarint( @"hash_4f6750c34be606ee" );
        
        if ( isdefined( level.players[ 0 ] ) )
        {
            playerposition = level.players[ 0 ] getclientomnvar( "ui_br_player_position" );
        }
        
        switch ( endgamesplash )
        {
            case 1:
                if ( playerposition != 1 )
                {
                    level.players[ 0 ] setclientomnvar( "ui_br_player_position", 1 );
                    wait 8;
                    level.players[ 0 ] setclientomnvar( "ui_br_player_position", 150 );
                }
                
                break;
            case 2:
                if ( playerposition != 4 )
                {
                    level.players[ 0 ] setclientomnvar( "ui_br_player_position", 4 );
                    wait 8;
                    level.players[ 0 ] setclientomnvar( "ui_br_player_position", 5 );
                }
                
                break;
            case 3:
                if ( playerposition != 22 )
                {
                    level.players[ 0 ] setclientomnvar( "ui_br_player_position", 22 );
                    wait 8;
                    level.players[ 0 ] setclientomnvar( "ui_br_player_position", 150 );
                }
                
                break;
            case 4:
                if ( playerposition != 15 )
                {
                    level.players[ 0 ] setclientomnvar( "ui_br_player_position", 15 );
                    wait 8;
                    level.players[ 0 ] setclientomnvar( "ui_br_player_position", 150 );
                }
                
                break;
            default:
                break;
        }
        
        waitframe();
    }
}

// Namespace gamelogic_mp
// Params 1
// Checksum 0xb1a1be8, Offset: 0x10895
// Size: 0x34
function function_ba3bd7c6c3177ee3( params )
{
    thread function_f5a8814c00abb81b();
    params.waitmsg = "round_based_fade_up";
    params.keepui = 1;
    return params;
}

// Namespace gamelogic_mp
// Params 0
// Checksum 0x580229e8, Offset: 0x108d2
// Size: 0x3b
function function_f5a8814c00abb81b()
{
    self endon( #"disconnect" );
    fadetime = getdvarfloat( @"hash_e13bff48d7059619", 1 );
    wait fadetime;
    self notify( #"round_based_fade_up" );
}

// Namespace gamelogic_mp
// Params 0
// Checksum 0x7e5b0a04, Offset: 0x10915
// Size: 0x120
function function_3a91911ed72cb8e6()
{
    flags::gameflaginit( "prematch_started", 0 );
    flags::gameflaginit( "prematch_done", 0 );
    flags::gameflaginit( "prematch_fade_done", 0 );
    flags::gameflaginit( "prematch_cleanup_done", 0 );
    flags::gameflaginit( "prematch_countdown", 0 );
    flags::gameflaginit( "graceperiod_done", 0 );
    flags::gameflaginit( "prematch_values_reset", 0 );
    flags::gameflaginit( "intro_boost_vo_done", 0 );
    flags::gameflaginit( "infil_setup_complete", 0 );
    flags::gameflaginit( "infil_will_run", 0 );
    flags::gameflaginit( "infil_started", 0 );
    flags::gameflaginit( "infil_animatic_complete", 0 );
    flags::gameflaginit( "overtime_started", 0 );
    flags::gameflaginit( "loadout_setup_complete", 0 );
    flags::gameflaginit( "loadout_will_run", 0 );
    flags::gameflaginit( "loadout_started", 0 );
    flags::levelflaginit( "round_over", 0 );
    flags::levelflaginit( "game_over", 0 );
    flags::levelflaginit( "block_notifies", 0 );
    flags::levelflaginit( "post_game_level_event_active", 0 );
    flags::levelflaginit( "final_killcam_preloaded", 0 );
    flags::levelflaginit( "over_time_entered", 0 );
}

// Namespace gamelogic_mp
// Params 0
// Checksum 0xed163c63, Offset: 0x10a3d
// Size: 0xb67
function function_b148d5ad482ae283()
{
    if ( !isdefined( level.var_376a6cf0ec67d7d0 ) )
    {
        level.var_376a6cf0ec67d7d0 = &infilexfil::function_f8f1a7c7ae375f58;
    }
    
    if ( !isdefined( level.var_7cb9fe30089f39e0 ) )
    {
        level.var_7cb9fe30089f39e0 = &function_ba3bd7c6c3177ee3;
    }
    
    level.prematchperiod = 0;
    level.prematchperiodend = 0;
    level.postgamenotifies = 0;
    level.intermission = 0;
    level.var_e3c3286caf6ae8b8 = getdvarfloat( @"hash_cba7d6083c9553b8" );
    setdvar( @"bg_bulletsusemaxdamageminrange", istrue( level.noweaponfalloff ) );
    
    if ( getmatchrulesdata( "commonOption", "allowArmor" ) == 1 )
    {
        if ( !isdefined( level.armoronweaponswitchlongpress ) )
        {
            level.armoronweaponswitchlongpress = 1;
        }
    }
    
    setdvar( @"bg_piggybackarmoronnvg", istrue( level.armoronweaponswitchlongpress ) );
    
    if ( game_utility_mp::matchmakinggame() )
    {
        setdvar( @"ismatchmakinggame", 1 );
    }
    else
    {
        setdvar( @"ismatchmakinggame", 0 );
    }
    
    if ( !isdefined( game[ "attackers_hash" ] ) )
    {
        game[ "attackers_hash" ] = getxhash( game[ "attackers" ] );
    }
    
    if ( !isdefined( game[ "defenders_hash" ] ) )
    {
        game[ "defenders_hash" ] = getxhash( game[ "defenders" ] );
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
        game[ "team_four" ] = "ZVIR";
    }
    
    if ( !isdefined( game[ "team_five" ] ) )
    {
        game[ "team_five" ] = "ICORPS";
    }
    
    if ( !isdefined( game[ "team_six" ] ) )
    {
        game[ "team_six" ] = "GRP9";
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
    
    if ( !isdefined( game[ "roundWinStreak" ] ) )
    {
        game[ "roundWinStreak" ] = 0;
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
    
    setomnvar( "ui_team_attackers", game[ "attackers" ] );
    setomnvar( "ui_team_defenders", game[ "defenders" ] );
    level.currentclientmatchdataid = 0;
    level.gameended = 0;
    level.forcedend = 0;
    level.hostforcedend = 0;
    setdvarifuninitialized( @"debug_stopafkcheck", 0 );
    
    /#
        setdvar( @"debug_stopafkcheck", 0 );
    #/
    
    setdvarifuninitialized( @"hash_e32ebdbb97a1ec4e", 0 );
    level.disablepersonalnuke = game_utility_mp::isanymlgmatch() || level.gamemodebundle.var_172a8c731ff6350a;
    level.thirdpersonmode = getmatchrulesdata( "commonOption", "thirdPerson" );
    level.diehardmode = getdvarint( @"scr_diehard" );
    level.casualscorestreaks = getmatchrulesdata( "commonOption", "casualScoreStreaks" );
    level.wrapkillstreaks = getmatchrulesdata( "commonOption", "wrapKillstreaks" );
    
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
    level.enableperkpackages = getmatchrulesdata( "commonOption", "enablePerkPackages" );
    level.allowsupers = getmatchrulesdata( "commonOption", "allowSupers" );
    level.superfastchargerate = getmatchrulesdata( "commonOption", "superFastChargeRate" );
    level.superpointsmod = getmatchrulesdata( "commonOption", "superPointsMod" );
    level.spawnprotectiontimer = getmatchrulesdata( "commonOption", "spawnProtectionTimer" );
    level.lethaldelay = getmatchrulesdata( "commonOption", "equipmentDelay" );
    level.equipmentmatchstartshieldms = getmatchrulesdata( "commonOption", "equipmentMSProtect" ) * 1000;
    level.magcount = getmatchrulesdata( "commonOption", "magCount" );
    level.startingEquipmentCount = getmatchrulesdata( "commonOption", "startingEquipmentCount" );
    level.practiceround = getmatchrulesdata( "commonOption", "practiceRound" );
    level.postgameexfil = getmatchrulesdata( "commonOption", "postGameExfil" );
    level.exfilactivetimer = getmatchrulesdata( "commonOption", "exfilActiveTimer" );
    level.exfilextracttimer = getmatchrulesdata( "commonOption", "exfilExtractTimer" );
    level.useammorestocklocs = getmatchrulesdata( "commonOption", "useAmmoRestockLocs" );
    level.agentskillstreakcount = dvars::getoverridedvarfloatexceptmatchrulesvalues( dvars::function_1165fde71640a2d1( "agent_kills_killstreak_count" ), @"scr_game_agent_kills_killstreak_count" );
    level.spectate3rdallowed = getmatchrulesdata( "commonOption", "spectate3rdAllowed" );
    setdvar( @"camera_allow3rdspectate", level.spectate3rdallowed );
    level.tempv_enabled = getdvarint( @"scr_temp_v_enabled", 0 ) || game_utility::getgametype() == "conf_v";
    level.minimaponbydefault = ( getmatchrulesdata( "commonOption", "enableMinimap" ) != 0 || getdvarint( @"hash_bc802deb1ff2a842" ) != 0 ) && !game[ "isLaunchChunk" ] && !game_utility::function_ae97372c83da7acc();
    level.radarhideshots = getmatchrulesdata( "commonOption", "radarHideShots" );
    setomnvar( "ui_compass_hide_weapon_pings_minimap", level.radarhideshots );
    level.navbarhideshots = getmatchrulesdata( "commonOption", "compassHidePings" );
    setomnvar( "ui_compass_hide_weapon_pings_navbar", level.navbarhideshots );
    level.navbarhideenemies = getmatchrulesdata( "commonOption", "compassHideEnemy" );
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
    
    if ( getdvarint( @"hash_ac31997b109b6bc5", 0 ) == 1 )
    {
        game[ "attackers" ] = "axis";
        game[ "defenders" ] = "allies";
    }
    
    setomnvar( "ui_match_timer_hidden", 1 );
    isarenamap = game_utility::isarenamap();
    
    if ( !game_utility::function_c564dc42fbb871d5() || isarenamap )
    {
        level.allowkillstreaks = 0;
        setomnvar( "ui_disable_killstreaks", 1 );
    }
    else
    {
        setomnvar( "ui_disable_killstreaks", 0 );
    }
    
    if ( !game_utility::function_cd3e55b03ffd725e() || isarenamap )
    {
        level.allowsupers = 0;
        setomnvar( "ui_disable_fieldupgrades", 1 );
    }
    else
    {
        setomnvar( "ui_disable_fieldupgrades", 0 );
    }
    
    level.disablecopycatloadout = 1;
    setomnvar( "ui_killcam_copycat", 0 );
    game_utility::getlocaleid();
    level.timelimit = game_utility_mp::function_82e3606d184524fe();
    level.initialtimelimit = level.timelimit;
    level.scorelimit = getmatchrulesdata( "commonOption", "scoreLimit" );
    level.useScoreLimitAsTotal = getmatchrulesdata( "commonOption", "useScoreLimitAsTotal" );
    level.roundlimit = getmatchrulesdata( "commonOption", "roundLimit" );
    level.winlimit = getmatchrulesdata( "commonOption", "winLimit" );
    
    if ( !isdefined( level.numlives ) )
    {
        level.numlives = game_utility_mp::getgametypenumlives();
    }
    
    level.roundswitch = getmatchrulesdata( "commonOption", "roundSwitch" );
    
    /#
        overridescorelimit = getdvarint( @"hash_d65e0555efa83c07", -1 );
        
        if ( overridescorelimit >= 0 )
        {
            level.scorelimit = overridescorelimit;
        }
    #/
    
    setdvar( @"ui_timelimit", level.timelimit );
    level.usestartspawns = 1;
    level.var_2b4cdfe0899a031e = getmatchrulesdata( "commonOption", "ffPunishDamageLimit" );
    level.var_547db1b350d23351 = getmatchrulesdata( "commonOption", "ffKickDamageLimit" );
    level.maxallowedteamkills = getmatchrulesdata( "commonOption", "ffPunishLimit" );
    level.var_a24986eef7cbb20f = 1;
    level.var_a4851fe642803397 = 0;
    
    if ( utility::issharedfuncdefined( #"display_transition", #"using_new_transitions" ) )
    {
        level.var_a4851fe642803397 = [[ utility::getsharedfunc( #"display_transition", #"using_new_transitions" ) ]]();
    }
    
    setdvarifuninitialized( @"hash_9c4c6f9cf6cd83ba", 4 );
    
    if ( getdvarint( @"hash_8d24aaf260fa641c", 0 ) == 1 )
    {
        level.var_9f50122980b82252 = 1;
    }
}

// Namespace gamelogic_mp
// Params 0
// Checksum 0x3be8accb, Offset: 0x115ac
// Size: 0x452
function function_6a80f58ba3de51ec()
{
    if ( analyticsstreamerislogfilestreamingenabled() )
    {
        analyticsstreamerlogfilestartstream();
    }
    
    game[ "matchHasMoreThan1Player" ] = 0;
    game[ "numPlayersConsideredPlaying" ] = 0;
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
    
    if ( !isdefined( game_utility_mp::getgamestate() ) )
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
    setdvarifuninitialized( @"hash_5bc62526996eaa55", 0 );
    
    if ( !level.splitscreen )
    {
        level.prematchperiod = getmatchrulesdata( "commonOption", "gracePeriod" );
        level.prematchperiodend = getmatchrulesdata( "commonOption", "matchStartTime" );
        
        /#
            level.prematchperiodend = getdvarint( @"scr_game_matchstarttime", level.prematchperiodend ?? 0 );
            level.prematchperiodend = getdvarint( @"scr_dev_matchstarttime", level.prematchperiodend );
        #/
    }
    
    if ( function_697873d10bd047e4() )
    {
        setnojipscore( 1, 1 );
        setnojiptime( 1, 1 );
        return;
    }
    
    setnojipscore( 0, 1 );
    setnojiptime( 0, 1 );
}

// Namespace gamelogic_mp
// Params 0
// Checksum 0x4f5e3779, Offset: 0x11a06
// Size: 0x58
function function_d35a692a215578b5()
{
    setdvarifuninitialized( @"min_wait_for_players", 5 );
    
    if ( !level.splitscreen )
    {
        level.prematchperiodend = getmatchrulesdata( "commonOption", "roundStartTime" );
        
        /#
            level.prematchperiodend = getdvarint( @"hash_968ede9a5f2aebce", level.prematchperiodend );
        #/
    }
}

// Namespace gamelogic_mp
// Params 0
// Checksum 0xc2f6e093, Offset: 0x11a66
// Size: 0x26
function function_7796492cde897c45()
{
    function_b148d5ad482ae283();
    
    if ( !isdefined( game[ "gamestarted" ] ) )
    {
        function_6a80f58ba3de51ec();
        return;
    }
    
    function_d35a692a215578b5();
}

// Namespace gamelogic_mp
// Params 0
// Checksum 0x5b1c6c27, Offset: 0x11a94
// Size: 0x60f
function function_37da3ed57ee2daa7()
{
    teamrevive::init();
    level thread infilexfil::infil_init();
    lui_game_event_aggregator::init();
    connect_event_aggregator::init();
    player_frame_update_aggregator::init();
    namespace_6107ae6ec81b3c5c::init();
    drop_event_aggregator::init();
    ent_manager::init();
    playerlogic::init();
    game_utility::initchallengeandeventglobals();
    callback::callback( #"init_shared_func", {} );
    thread namespace_c1ad58c9f2d22230::init();
    gameinstance::initialize();
    thread teams::init();
    squads::init();
    player_utility::initdismembermentlist();
    game_utility::values_init();
    thread shellshock_utility::init();
    thread game_utility::game_utility_init();
    thread playerhealth::init();
    thread challenges::init();
    thread killcam::init();
    thread final_killcam::initfinalkillcam();
    mtx_weapon::function_f877fea1e7d31f31();
    dialog::initstatusdialog();
    
    if ( !level.gametypebundle.var_91a883607641d8a7 )
    {
        dialog::function_d030b7dd67fd809f();
    }
    
    if ( isbrgamemode() || isdmzgamemode() )
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
    
    thread namespace_cef36d7634533c06::init();
    
    if ( isbrgamemode() )
    {
        thread music_br::init();
    }
    else if ( game_utility::getgametype() != "ob" )
    {
        thread music_mp::init();
    }
    
    thread persistence::init();
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
    
    if ( level.gamemodebundle.var_618bf0d8d38f029f || getdvarint( @"hash_3b9b18884f3557a8" ) )
    {
        if ( utility::issharedfuncdefined( #"hybrid_lens", #"init" ) )
        {
            utility::callsharedfunc( #"hybrid_lens", #"init" );
        }
    }
    
    thread namespace_1cdb218d68ef13f6::init();
    
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
    thread points::initpoints();
    thread playerlogic::initsegmentstats();
    rejoin_utility::main();
    thread personal_bests::init();
    
    if ( level.leagueplaymatch )
    {
        leagueplay::init();
    }
    
    if ( level.var_309e3d9dac389de6 )
    {
        leagueplay_br::init();
    }
    
    thread perks::init();
    feature_init::in_play_limits_init();
    
    if ( !game[ "isLaunchChunk" ] )
    {
        thread vehicle::init();
        thread vehicle_ai::init();
        thread init::init();
        thread perks::initspecialistkillstreaks();
    }
    
    if ( !level.disablescoreevents )
    {
        thread events::events_init();
    }
    
    if ( !game_utility_mp::runleanthreadmode() || level.gamemodebundle.var_49aaa9409a44488 )
    {
        thread whizby::init();
    }
    
    thread telemetry::init();
    thread analyticslog::init();
    thread telemetry_mp::init();
    thread telemetry_esports::init();
    thread stamina::init();
    thread stance::init();
    thread gun_shield::init();
    level armor::init();
    
    if ( !game[ "isLaunchChunk" ] )
    {
        if ( level.droparmorondeath )
        {
            thread loot::init();
        }
        
        thread loot_mp::init();
        thread supers_mp::init();
        thread supers_mp::watchsuperdelay();
    }
    
    thread callouts::init();
    thread bounty::init();
    thread allow_weapon_mp_init();
    thread ismp_init();
    level.players thread function_660b7766ecc7584a();
    thread gestures::init();
    thread gestures_mp::init_mp();
    thread execution::execution_init();
    thread emote::emote_init();
    thread sentientpoolmanager::init();
    thread jup_wager::init();
    thread sprays::sprays_init();
    thread scripted_weapons::init();
    thread talking_gun::init();
    
    if ( !game[ "isLaunchChunk" ] )
    {
        thread turret::init();
    }
    
    thread laststand::init();
    thread equipment_mp::init();
    thread matchstats::init();
    thread playerstats::init();
    
    if ( getdvarint( @"hash_81a618a6e6973ed3", 0 ) == 1 )
    {
        thread playeranimset::init();
    }
    
    if ( isdefined( level.skills_init ) )
    {
        [[ level.skills_init ]]();
    }
    
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
        thread door::init_sliding_doors();
        thread door::garage_door_init();
        thread flashpoint::init();
        thread emp_debuff::emp_debuff_init();
        thread active_env::init_active_env();
        thread arcwire::init_arcwire();
    }
    
    thread hud_message::init();
    thread hud_popup::init();
    level.allowreviveweapons = getmatchrulesdata( "commonOption", "reviveUseWeapon" );
    val::group_register( "reviveShoot", [ "weapon_switch", "offhand_weapons", "gesture", "killstreaks", "supers", "ads", "reload", "autoreload" ] );
    val::group_register( "gameEndFreeze", [ "usability", "ads", "fire", "weapon_switch", "offhand_weapons", "offhand_primary_weapons", "offhand_secondary_weapons", "killstreaks", "supers", "allow_jump", "sprint", "stance_change", "melee" ] );
    thread accolades::init();
    thread ammorestock::init();
    thread meatshield::init();
    level overlord::init();
    level bots_loadout::init();
    level thread trigger::init_gesture_triggers();
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
}

// Namespace gamelogic_mp
// Params 0
// Checksum 0x48ed2b45, Offset: 0x120ab
// Size: 0x1f8
function function_6c633222fd39cedd()
{
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
                if ( level.gametypebundle.scoringstrategy == #"teamhealth" )
                {
                    game[ "teamScores" ][ team ] = level.gametypebundle.var_48e52f34b664929f;
                    continue;
                }
                
                game[ "teamScores" ][ team ] = 0;
            }
        }
    }
    
    if ( game[ "status" ] != "overtime" && game[ "status" ] != "halftime" )
    {
        if ( ( game[ "roundsPlayed" ] == 0 || level.gametypebundle.scoringstrategy == #"roundswon" ) && game_utility_mp::resetscoreonroundstart() )
        {
            game[ "teamScores" ][ "allies" ] = 0;
            game[ "teamScores" ][ "axis" ] = 0;
        }
        
        if ( level.multimatch ?? gameinstance::is_enabled() )
        {
            foreach ( team in level.teamnamelist )
            {
                game[ "teamScores" ][ team ] = 0;
                setteamscore( team, 0 );
            }
        }
    }
}

// Namespace gamelogic_mp
// Params 0
// Checksum 0xa821d38c, Offset: 0x122ab
// Size: 0x78c
function callback_startgametype()
{
    load::main();
    callback::add( #"player_connect", &onplayerconnect );
    function_3a91911ed72cb8e6();
    function_7796492cde897c45();
    level thread initwaypointbackgrounds();
    
    /#
        println( "<dev string:xa8b>" );
        println( "<dev string:xa98>" );
        println( "<dev string:xabe>" + level.script );
        println( "<dev string:xad5>" + game_utility::getgametype() );
        println( "<dev string:xaec>" + game_utility::function_ae97372c83da7acc() );
        println( "<dev string:xb03>" + game_utility::function_d3f8957534dc62af() );
        println( "<dev string:xb1a>" + level.diehardmode );
        println( "<dev string:xb2c>" + level.thirdpersonmode );
        println( "<dev string:xb43>" + level.forcethirdperson );
        println( "<dev string:xb5a>" + game[ "<dev string:x894>" ] );
        println( "<dev string:xb6c>" + level.scorelimit );
        println( "<dev string:xb83>" + level.roundlimit );
        println( "<dev string:xb9a>" + level.winlimit );
        println( "<dev string:xbb1>" + level.timelimit );
        println( "<dev string:xbc8>" + level.numlives );
        println( "<dev string:xbdf>" + level.roundswitch );
        println( "<dev string:xa98>" );
    #/
    
    if ( game_utility::function_d3f8957534dc62af() )
    {
        logstring( "game modifier: tier 1 mode" );
    }
    else if ( game_utility::function_ae97372c83da7acc() )
    {
        logstring( "game modifier: hardcore mode" );
    }
    
    function_37da3ed57ee2daa7();
    function_6c633222fd39cedd();
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
    else if ( level.useScoreLimitAsTotal )
    {
        level.roundscorelimit = level.scorelimit;
        level.totalscorelimit = level.scorelimit;
    }
    else
    {
        level.roundscorelimit = level.scorelimit * ( game[ "roundsPlayed" ] + 1 );
        level.totalscorelimit = level.scorelimit * level.roundlimit;
    }
    
    if ( getdvarint( @"hash_7dfc9d99d9c1ff2f", 0 ) == 1 )
    {
        gamestaterestore::restoreteamscores();
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
    
    if ( getdvarint( @"scr_allow_custom_loadouts", 0 ) == 0 || game_utility_mp::function_f24635ef11e449d1() && !game_utility_mp::function_57f7c589ea92d695() && !game_utility_mp::ismutationgamemode() || game_utility_mp::isjuggermoshgamemode() )
    {
        setomnvar( "ui_only_default_loadouts", 1 );
    }
    
    common::commononstartgametype();
    [[ level.onstartgametype ]]();
    level utility::flag_set( "onStartGameTypeFinished" );
    function_712829905bfc0897();
    level thread common::onplayerconnectcommon();
    disconnect_event_aggregator::registerondisconnecteventcallback( &common::onplayerdisconnectcommon );
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
    
    if ( getbuildversion() != "SHIP" )
    {
        thread [[ level.devinit ]]();
    }
    
    /#
        level thread dof::function_55904422b4033469();
    #/
    
    if ( getdvar( @"dedicated" ) == "dedicated LAN server" || getdvar( @"dedicated" ) == "dedicated internet server" )
    {
        thread verifydedicatedconfiguration();
    }
    
    codcaster_utils::function_df0a55c77c9df04f( 0, 0 );
    
    if ( level.gametypebundle.var_1a434cf2bf29237 ?? 1 )
    {
        thread startgame();
    }
    
    level thread dvars::updatewatcheddvars();
    
    if ( !level.istacops && ( level.gametypebundle.var_af34edb6af361a99 ?? 1 ) )
    {
        if ( level.multimatch ?? gameinstance::is_enabled() )
        {
            level thread gameinstance::timelimitthread();
        }
        else
        {
            level thread timelimitthread();
        }
    }
    
    level thread updateleaderboardstatscontinuous();
    level thread removepatchablecollision_delayed();
    level utility::flag_set( "StartGameTypeCallbackFinished" );
    
    if ( game_utility_mp::isfirstround() )
    {
        level thread callbackserverstart();
    }
}

// Namespace gamelogic_mp
// Params 0
// Checksum 0x2d440d6a, Offset: 0x12a3f
// Size: 0x2e
function callbackserverstart()
{
    if ( getdvarint( @"hash_830d682c147b23bb", 0 ) > 0 )
    {
        level waittill( #"telemetry_init" );
    }
    
    telemetry_utils::function_af2d366f9522f76f( "callback_server_start" );
}

// Namespace gamelogic_mp
// Params 1, eflags: 0x4
// Checksum 0xd6757de8, Offset: 0x12a75
// Size: 0x39
function private onplayerconnect( params )
{
    if ( !isdefined( self.pers[ "firstConnectTime" ] ) )
    {
        self.pers[ "firstConnectTime" ] = gettime();
    }
    
    thread game_utility_mp::function_72eee44b5c341138();
}

// Namespace gamelogic_mp
// Params 0
// Checksum 0x13d2d20c, Offset: 0x12ab6
// Size: 0x178
function updatewavespawndelay()
{
    wavedelay = getmatchrulesdata( "commonOption", "waveRespawnDelay" );
    var_30a09c48d9ff8196 = level.respawndelaytype == 1;
    
    if ( wavedelay || var_30a09c48d9ff8196 )
    {
        if ( !var_30a09c48d9ff8196 )
        {
            foreach ( entry in level.teamnamelist )
            {
                level.wavedelay[ entry ] = wavedelay;
                level.lastwave[ entry ] = 0;
            }
        }
        else
        {
            if ( !game[ "switchedsides" ] )
            {
                level.wavedelay[ game[ "attackers" ] ] = level.attackersrespawndelay;
                level.wavedelay[ game[ "defenders" ] ] = level.defendersrespawndelay;
            }
            else
            {
                level.wavedelay[ game[ "attackers" ] ] = level.defendersrespawndelay;
                level.wavedelay[ game[ "defenders" ] ] = level.attackersrespawndelay;
            }
            
            level.lastwave[ game[ "attackers" ] ] = 0;
            level.lastwave[ game[ "defenders" ] ] = 0;
        }
        
        level thread wavespawntimer();
    }
}

// Namespace gamelogic_mp
// Params 0
// Checksum 0x5a7ef55c, Offset: 0x12c36
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

// Namespace gamelogic_mp
// Params 0
// Checksum 0x41edb984, Offset: 0x12ca2
// Size: 0x8d
function timelimitthread()
{
    level endon( #"game_ended" );
    prevtimepassed = game_utility::gettimepassed();
    
    while ( game_utility_mp::getgamestate() == "playing" )
    {
        waittillframeend();
        thread checktimelimit( prevtimepassed );
        prevtimepassed = game_utility::gettimepassed();
        
        if ( isdefined( level.starttime ) )
        {
            timeremaining = gettimeremaining();
            
            if ( 0 < timeremaining && timeremaining < gettimeremaining() < 3000 || level.forceotlogictorun )
            {
                waitframe();
                continue;
            }
        }
        
        wait 1;
    }
}

// Namespace gamelogic_mp
// Params 0
// Checksum 0x2a751c3f, Offset: 0x12d37
// Size: 0x2d9
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
                
                if ( level.codcasterenabled )
                {
                    codcaster_utils::function_c2c643e0ac6e6a6( game[ "timeToBeatTeam" ], game[ "timeToBeat" ], game[ "timeToBeatOld" ] );
                }
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

// Namespace gamelogic_mp
// Params 0
// Checksum 0x259ac436, Offset: 0x13018
// Size: 0xad
function usenormalscorelimit()
{
    if ( level.gametypebundle.scoringstrategy == #"teamscores" || level.gametypebundle.scoringstrategy == #"teamhealth" )
    {
        setomnvar( "ui_scorelimit", level.totalscorelimit );
        thread checkscorelimit();
        return;
    }
    
    limit = level.winlimit;
    
    if ( level.multimatch ?? gameinstance::is_enabled() )
    {
        limit = game[ #"tournamentdata" ].roundlosslimit;
    }
    
    setomnvar( "ui_scorelimit", limit );
}

// Namespace gamelogic_mp
// Params 1
// Checksum 0xa6e833d7, Offset: 0x130cd
// Size: 0x190
function playtickingsound( bombtimer )
{
    self endon( #"death" );
    self endon( #"stop_ticking" );
    level endon( #"game_ended" );
    
    if ( !isdefined( bombtimer ) )
    {
        bombtimer = level.bombtimer;
    }
    
    if ( isdefined( level.defusetime ) )
    {
        var_2ea459ffd911b71c = level.defusetime;
    }
    else
    {
        var_2ea459ffd911b71c = 5;
    }
    
    while ( true )
    {
        if ( bombtimer > 10 )
        {
            if ( game_utility::getgametype() == "counter" )
            {
                level thread gameplay_sound_fx::function_28103d3430792dce( self.origin, #"hash_bee533f2fd66e100" );
            }
            else
            {
                gameplay_sound_fx::function_760dbc73d1362ab9( #"hash_b1e89997a839781a" );
            }
            
            bombtimer -= 1;
            wait 1;
        }
        else if ( bombtimer > var_2ea459ffd911b71c )
        {
            if ( game_utility::getgametype() == "counter" )
            {
                level thread gameplay_sound_fx::function_28103d3430792dce( self.origin, #"hash_21da1ec6fcf62e08" );
            }
            else
            {
                gameplay_sound_fx::function_760dbc73d1362ab9( #"hash_e0e8fdef8a33d6e" );
            }
            
            bombtimer -= 1;
            wait 1;
        }
        else
        {
            if ( game_utility::getgametype() == "counter" )
            {
                level thread gameplay_sound_fx::function_28103d3430792dce( self.origin, #"hash_6461695c5ef5d858" );
            }
            else if ( level.gametypebundle.var_9ca785371433244c && bombtimer == 0 )
            {
                gameplay_sound_fx::function_760dbc73d1362ab9( #"hash_9b3ced02c5581bf0" );
            }
            else
            {
                gameplay_sound_fx::function_760dbc73d1362ab9( #"hash_b33848e3da3f5d46" );
            }
            
            bombtimer -= 1;
            wait 1;
        }
        
        hostmigration::waittillhostmigrationdone();
    }
}

// Namespace gamelogic_mp
// Params 1
// Checksum 0x72e98cd8, Offset: 0x13265
// Size: 0xe4
function playtickingsound_3d( bombtimer )
{
    self endon( #"death" );
    self endon( #"stop_ticking" );
    level endon( #"game_ended" );
    
    if ( !isdefined( bombtimer ) )
    {
        bombtimer = level.bombtimer;
    }
    
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
        if ( bombtimer > 15 )
        {
            gameplay_sound_fx::function_760dbc73d1362ab9( #"hash_b1e89997a839781a" );
            bombtimer -= 1;
            wait 1;
        }
        else if ( bombtimer > var_2ea459ffd911b71c )
        {
            gameplay_sound_fx::function_760dbc73d1362ab9( #"hash_e0e8fdef8a33d6e" );
            bombtimer -= 1;
            wait 1;
        }
        else
        {
            gameplay_sound_fx::function_760dbc73d1362ab9( #"hash_b33848e3da3f5d46" );
            bombtimer -= 0.5;
            wait 0.5;
        }
        
        hostmigration::waittillhostmigrationdone();
    }
}

// Namespace gamelogic_mp
// Params 0
// Checksum 0xfc4e24c3, Offset: 0x13351
// Size: 0x37
function stoptickingsound()
{
    if ( !level.gametypebundle.var_9ca785371433244c )
    {
        self notify( #"stop_ticking" );
        return;
    }
    
    wait 1;
    self notify( #"stop_ticking" );
}

// Namespace gamelogic_mp
// Params 1
// Checksum 0x88d5fbd3, Offset: 0x13390
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

// Namespace gamelogic_mp
// Params 0
// Checksum 0x23612909, Offset: 0x133f1
// Size: 0x381
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
    var_65387e163622c128 = istrue( level.gametypebundle.var_dc242792c4693773 );
    var_a23b335e0e78092c = istrue( level.gametypebundle.var_457019a36d53cb19 );
    var_9e080ba1c5c74c61 = istrue( level.gametypebundle.var_457016a36d53c480 );
    var_da7d6f58b406a71f = game_utility_mp::isanymlgmatch() ? 5 : 2;
    
    while ( game_utility_mp::getgamestate() == "playing" )
    {
        if ( !level.timerstopped && game_utility_mp::gettimelimit() && !level.bombsplanted && !level.var_ff4e747081084eca && !level.var_89a304fc199d7919 )
        {
            timeleft = max( gettimeremaining(), 0 ) * 0.001;
            timeleftint = int( timeleft + 0.5 );
            var_ee6b9cea37d55528 = 0;
            
            if ( var_da7d6f58b406a71f == 2 && timeleftint % 2 == 1 )
            {
                var_ee6b9cea37d55528 = 1;
            }
            
            if ( !playedsixty && ( var_ee6b9cea37d55528 == 1 && timeleftint == 61 || var_ee6b9cea37d55528 == 0 && timeleftint == 60 ) )
            {
                level namespace_cef36d7634533c06::matchendingsoonleaderdialog( "timesup_sixty", timeleftint );
                level notify( #"match_ending_soon", "time" );
                playedsixty = 1;
            }
            else if ( !playedthirty && ( var_ee6b9cea37d55528 == 1 && timeleftint == 31 || var_ee6b9cea37d55528 == 0 && timeleftint == 30 ) )
            {
                level namespace_cef36d7634533c06::matchendingsoonleaderdialog( "timesup_thirty", timeleftint );
                level notify( #"match_ending_soon", "time" );
                playedthirty = 1;
            }
            else if ( !var_65387e163622c128 )
            {
                if ( var_ee6b9cea37d55528 == 1 && timeleftint == 11 || var_ee6b9cea37d55528 == 0 && timeleftint == 10 )
                {
                    level namespace_cef36d7634533c06::matchendingsoonleaderdialog( "timesup_ten", timeleftint );
                    var_65387e163622c128 = 1;
                }
                else if ( var_ee6b9cea37d55528 == 1 && timeleftint <= 2 || var_ee6b9cea37d55528 == 0 && timeleftint <= 1 )
                {
                    level namespace_cef36d7634533c06::matchendingsoonleaderdialog( "timesup", timeleftint );
                    var_65387e163622c128 = 1;
                }
            }
            
            if ( !var_9e080ba1c5c74c61 && timeleftint <= 10 || !var_a23b335e0e78092c && timeleftint <= 30 && timeleftint % var_da7d6f58b406a71f == var_ee6b9cea37d55528 )
            {
                level notify( #"match_ending_very_soon" );
                
                if ( timeleftint == 0 )
                {
                    break;
                }
                
                if ( !isdefined( level.overridetimelimitclock ) || level.overridetimelimitclock >= timeleftint )
                {
                    flags::levelflaginit( "match_ending_clock_sound_begin", 1 );
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

// Namespace gamelogic_mp
// Params 0
// Checksum 0x3d4803d0, Offset: 0x1377a
// Size: 0x1fa
function gametimer()
{
    level endon( #"game_ended" );
    
    if ( isdefined( game[ "startTimeFromMatchStart" ] ) )
    {
        level.starttimefrommatchstart = game[ "startTimeFromMatchStart" ];
    }
    
    if ( function_4b1ae19a1c251bb8() && getdvarint( @"hash_49bbeacaa2e89deb", 0 ) != 0 )
    {
        level.discardtime = 0;
    }
    
    level waittill( #"prematch_over" );
    level.starttime = gettime();
    level.discardtime = 0;
    level.overtimetotal = 0;
    
    if ( !isdefined( game[ "startTimeFromMatchStart" ] ) )
    {
        game[ "startTimeFromMatchStart" ] = gettime();
        level.starttimefrommatchstart = gettime();
        telemetry_utils::function_af2d366f9522f76f( "callback_match_start" );
    }
    
    if ( isdefined( game[ "roundMillisecondsAlreadyPassed" ] ) )
    {
        level.starttime -= game[ "roundMillisecondsAlreadyPassed" ];
        game[ "roundMillisecondsAlreadyPassed" ] = undefined;
    }
    
    if ( game[ "roundsPlayed" ] < 24 )
    {
        setmatchdata( "utcRoundStartTimeSeconds", game[ "roundsPlayed" ], getsystemtime() );
        
        if ( game_utility::function_245a95d184375f25() )
        {
            setomnvar( "ui_round_start_time", getsystemtime() );
        }
    }
    
    telemetry_utils::function_af2d366f9522f76f( "callback_round_start" );
    
    if ( telemetry_utils::function_7ffb9ee91a85ee0d( "callback_player_round_start" ) )
    {
        foreach ( player in level.players )
        {
            telemetry_utils::function_af2d366f9522f76f( "callback_player_round_start", player );
        }
    }
    
    prevtime = gettime();
    
    while ( game_utility_mp::getgamestate() == "playing" )
    {
        if ( !level.timerstopped )
        {
            game[ "timePassed" ] = game[ "timePassed" ] + gettime() - prevtime;
        }
        
        prevtime = gettime();
        wait 1;
    }
}

// Namespace gamelogic_mp
// Params 1
// Checksum 0x983ce3ce, Offset: 0x1397c
// Size: 0x16c
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
        
        setomnvar( "ui_match_timer_stop_time", level.timerpausetime );
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

// Namespace gamelogic_mp
// Params 1
// Checksum 0x5688e0af, Offset: 0x13af0
// Size: 0x2d
function pausetimer( gameovertime )
{
    if ( !level.timerstoppedforgamemode )
    {
        level.timerstoppedforgamemode = 1;
        updatetimerpausedness( gameovertime );
    }
}

// Namespace gamelogic_mp
// Params 1
// Checksum 0xc9b1599, Offset: 0x13b25
// Size: 0x2b
function resumetimer( gameovertime )
{
    if ( level.timerstoppedforgamemode )
    {
        level.timerstoppedforgamemode = 0;
        updatetimerpausedness( gameovertime );
    }
}

// Namespace gamelogic_mp
// Params 0
// Checksum 0xeb753b20, Offset: 0x13b58
// Size: 0x109
function prematchover()
{
    thread analyticslog::logevent_sendplayerindexdata();
    telemetry_utils::function_af2d366f9522f76f( "callback_prematch_over" );
    flags::gameflagset( "prematch_done" );
    level notify( #"prematch_over" );
    setomnvar( "ui_prematch_period", 0 );
    level callback::callback( #"prematch_done", {} );
    level.starttime_prematchdone = gettime();
    
    if ( getdvarint( @"hash_fb998921154c2e20", 0 ) > 0 )
    {
        thread sretest();
    }
    
    foreach ( player in level.players )
    {
        player damage::resetattackerlist();
    }
    
    if ( bots_util::function_deef484b5b3a3977() )
    {
        level.var_6a8e88d5a8429194.botprematchdone = 1;
    }
}

// Namespace gamelogic_mp
// Params 0
// Checksum 0xc98d7179, Offset: 0x13c69
// Size: 0x10a
function startgame()
{
    level endon( #"game_ended" );
    thread function_22d6c00d46cf311c();
    setslowmotion( 1, 1, 0 );
    thread gametimer();
    level.timerstopped = 0;
    level.timerstoppedforgamemode = 0;
    setomnvar( "ui_prematch_period", 1 );
    prematchperiod();
    prematchover();
    level notify( #"hash_c3aaac3672761740" );
    updatetimerpausedness();
    timelimit = game_utility_mp::gettimelimit();
    
    if ( timelimit > 0 && !game_utility::function_d3f8957534dc62af() )
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
    
    if ( level.codcasterenabled && getdvarint( @"hash_2745598e35a47913", 0 ) == 1 )
    {
        thread codcaster_utils::function_b068a61a9ecf1f47();
    }
}

// Namespace gamelogic_mp
// Params 0
// Checksum 0x80a387fe, Offset: 0x13d7b
// Size: 0xee
function sretest()
{
    level endon( #"game_ended" );
    startms = gettime();
    intervalms = getdvarint( @"hash_fb998921154c2e20", 0 );
    delayms = getdvarint( @"hash_f616cd1a71e75502", 0 );
    durationms = getdvarint( @"hash_28217dab10f4cb47", 0 );
    var_ad4dec14c1395c84 = 0;
    println( "<dev string:xbf6>" );
    
    while ( game_utility_mp::getgamestate() == "playing" )
    {
        waitframe();
        timems = gettime();
        
        if ( timems - startms < delayms )
        {
            continue;
        }
        
        if ( durationms > 0 && timems - startms > delayms + durationms )
        {
            break;
        }
        
        while ( timems - startms - delayms > intervalms * var_ad4dec14c1395c84 )
        {
            var_ad4dec14c1395c84 += 1;
            function_7d4bea2cbb2ece27();
        }
    }
    
    println( "<dev string:xc0e>" );
}

// Namespace gamelogic_mp
// Params 0
// Checksum 0x91f1de90, Offset: 0x13e71
// Size: 0x2c
function waitthenshowtimer()
{
    setomnvar( "ui_match_timer_hidden", 1 );
    wait 0.25;
    
    if ( !level.var_a4f3d2c6830fb589 )
    {
        setomnvar( "ui_match_timer_hidden", 0 );
    }
}

// Namespace gamelogic_mp
// Params 0
// Checksum 0x458076c5, Offset: 0x13ea5
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

// Namespace gamelogic_mp
// Params 0
// Checksum 0xeb42cdc4, Offset: 0x141e1
// Size: 0x15e
function wavespawntimer()
{
    level endon( #"game_ended" );
    level notify( #"hash_d70674257c3f98b0" );
    level endon( #"hash_d70674257c3f98b0" );
    
    while ( game_utility_mp::getgamestate() == "playing" )
    {
        time = gettime();
        
        foreach ( entry in level.teamnamelist )
        {
            if ( time - level.lastwave[ entry ] > level.wavedelay[ entry ] * 1000 )
            {
                level notify( "wave_respawn_" + entry );
                level.lastwave[ entry ] = time;
                level.waveplayerspawnindex[ entry ] = 0;
                setomnvar( "ui_wave_respawn_time", int( gettime() + level.wavedelay[ entry ] * 1000 ) );
            }
            
            frac = 1 - ( time - level.lastwave[ entry ] ) / level.wavedelay[ entry ] * 1000;
            setomnvar( "ui_wave_respawn_percent", frac );
        }
        
        waitframe();
    }
}

// Namespace gamelogic_mp
// Params 1
// Checksum 0x9d179fff, Offset: 0x14347
// Size: 0x21
function function_d585b898a1e5ade0( team )
{
    return ( gettime() - level.lastwave[ team ] ) / 1000;
}

// Namespace gamelogic_mp
// Params 0
// Checksum 0x470dbbad, Offset: 0x14371
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

// Namespace gamelogic_mp
// Params 0
// Checksum 0x28069959, Offset: 0x143c2
// Size: 0x2a3
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
        
        if ( isdefined( team ) && team_utility::isgameplayteam( team ) )
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

// Namespace gamelogic_mp
// Params 1
// Checksum 0xc25e520a, Offset: 0x1466e
// Size: 0x76
function rankedmatchupdates( winner )
{
    if ( game_utility_mp::matchmakinggame() )
    {
        if ( getdvarint( @"hash_5bc62526996eaa55", 0 ) )
        {
            setxenonranks();
        }
        else if ( game_utility_mp::wasonlyround() || game_utility_mp::waslastround() )
        {
            setxenonranks();
        }
        
        if ( hostidledout() )
        {
            level.hostforcedend = 1;
            logstring( "host idled out" );
            endlobby();
        }
    }
    
    updatewinlossstats( winner );
}

// Namespace gamelogic_mp
// Params 4
// Checksum 0xd151aa3a, Offset: 0x146ec
// Size: 0x1fb
function displayroundend( winner, endreasontext, endreasontextloss, instance )
{
    if ( level.var_86bbc7d0be1ace54 )
    {
        thread function_ca8f6fb4cdb3f3da( winner );
    }
    
    if ( !level.doeomcombat && level.gametypebundle.scoringstrategy == #"teamscores" && game[ "finalRound" ] == 0 && !level.forcehalftime )
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
    
    participantplayers = game_utility_mp::function_4b15b7eb1dc364e7( instance );
    
    foreach ( player in participantplayers )
    {
        if ( isalive( player ) )
        {
            player thread weapons::savetogglescopestates();
            player thread weapons::savealtstates();
            player thread weapons::function_7cc000a4d4bc9a60();
        }
        
        if ( level.teambased )
        {
            player thread hud_message::teamoutcomenotify( winner, 1, endreasontext, endreasontextloss, level.roundendextramessage );
            continue;
        }
        
        player thread hud_message::outcomenotify( winner, 1, endreasontext, endreasontextloss );
    }
}

// Namespace gamelogic_mp
// Params 4
// Checksum 0xd5f22ec2, Offset: 0x148ef
// Size: 0x11b
function displaygameend( winner, endreasontext, endreasontextloss, instance )
{
    setomnvar( "ui_match_over", 1 );
    
    if ( game_utility_mp::waslastround() && game_utility_mp::iswinbytworulegametype() && game_utility_mp::function_1c242e9b72b23687() )
    {
        winner = "tie";
        endreasontext = game[ "end_reason" ][ "win_by_two_tie" ];
        endreasontextloss = game[ "end_reason" ][ "win_by_two_tie" ];
    }
    
    participantplayers = game_utility_mp::function_4b15b7eb1dc364e7( instance );
    
    foreach ( player in participantplayers )
    {
        if ( level.teambased )
        {
            player thread hud_message::teamoutcomenotify( winner, 0, endreasontext, endreasontextloss );
            continue;
        }
        
        player thread hud_message::outcomenotify( winner, 0, endreasontext, endreasontextloss );
    }
}

// Namespace gamelogic_mp
// Params 1
// Checksum 0xf9ceaed0, Offset: 0x14a12
// Size: 0xbe
function function_ca8f6fb4cdb3f3da( winner )
{
    if ( winner == game[ "attackers" ] && isdefined( level.var_fd297edbe8c67992 ) )
    {
        audio_utility::snd_transient_load( level.var_fd297edbe8c67992 );
        wait 45;
        audio_utility::snd_transient_unload( level.var_fd297edbe8c67992 );
        return;
    }
    
    if ( winner == game[ "defenders" ] && isdefined( level.var_4e7709390e0f9fae ) )
    {
        audio_utility::snd_transient_load( level.var_4e7709390e0f9fae );
        wait 45;
        audio_utility::snd_transient_unload( level.var_4e7709390e0f9fae );
        return;
    }
    
    if ( isdefined( level.var_fd297edbe8c67992 ) )
    {
        audio_utility::snd_transient_load( level.var_fd297edbe8c67992 );
        wait 45;
        audio_utility::snd_transient_unload( level.var_fd297edbe8c67992 );
    }
}

// Namespace gamelogic_mp
// Params 1
// Checksum 0xa623e1b5, Offset: 0x14ad8
// Size: 0x3a2
function displayroundswitch( instance )
{
    level notify( #"spawning_intermission" );
    intermissionspawnpointoverride = getintermissionspawnpointoverride();
    
    foreach ( player in level.players )
    {
        player thread playerlogic::spawnintermission( intermissionspawnpointoverride );
    }
    
    switchtype = level.halftimetype;
    level.displayroundswitch = 1;
    
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
        
        switchtype = level.var_2c3e193d00dbfcea ? level.var_2c3e193d00dbfcea : switchtype;
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
    
    if ( level.teambased )
    {
        foreach ( player in level.players )
        {
            player thread hud_message::teamoutcomenotify( switchtype, 1, endreason, endreason, level.roundendextramessage );
        }
    }
    
    if ( switchtype == "final_round" && game_utility_mp::getbasegametype() == "control" )
    {
        if ( !level.var_a4851fe642803397 )
        {
            roundendwait( level.roundenddelay, undefined, instance );
        }
        
        wait level.postgamehitmarkerwaittime;
        [ defendingteam, reason ] = control::function_71395ff3b4abe35d();
        axisdefending = defendingteam == "axis" ? 1 : 0;
        setomnvar( "ui_control_axis_defending", axisdefending );
        game[ "axis_defending" ] = axisdefending;
        
        foreach ( player in level.players )
        {
            player thread hud_message::teamoutcomenotify( "switching_sides", 1, reason, reason, 0 );
        }
    }
    
    if ( !level.var_a4851fe642803397 )
    {
        roundendwait( level.halftimeroundenddelay, undefined, instance );
    }
}

// Namespace gamelogic_mp
// Params 0
// Checksum 0xa8886259, Offset: 0x14e82
// Size: 0xce
function function_ccf999439b21d96b()
{
    endreason = game[ "round_end" ][ "next_round" ];
    winner = "next_round";
    
    foreach ( player in level.players )
    {
        if ( level.teambased )
        {
            player thread hud_message::teamoutcomenotify( winner, 1, endreason, endreason, level.roundendextramessage );
            continue;
        }
        
        player thread hud_message::outcomenotify( winner, 1, endreason, endreason );
    }
}

// Namespace gamelogic_mp
// Params 5
// Checksum 0xf8470f90, Offset: 0x14f58
// Size: 0x1e4
function freezeallplayers( delay = 0, var_d91f34a9d05b470d, var_859130a57b5e5819, slowmotion = 0, playerarray )
{
    if ( delay > 0 && slowmotion )
    {
        thread slowmotionendofgame( delay );
    }
    
    thread sendgameendedfrozennotify( delay );
    
    if ( !isdefined( playerarray ) )
    {
        playerarray = level.players;
    }
    
    foreach ( player in playerarray )
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

// Namespace gamelogic_mp
// Params 1
// Checksum 0x93d73895, Offset: 0x15144
// Size: 0x25
function endofroundvisionset( delay )
{
    if ( delay > 0 )
    {
        wait delay;
    }
    
    visionsetfadetoblack( "bw", 0.75 );
}

// Namespace gamelogic_mp
// Params 1
// Checksum 0xd0e3f78e, Offset: 0x15171
// Size: 0x41
function slowmotionendofgame( delay )
{
    setslowmotion( 1, 0.4, delay );
    setendofroundsoundtimescalefactor();
    hostmigration::waitlongdurationwithhostmigrationpause( delay );
    setslowmotion( 1, 1, 0 );
    resetsoundtimescalefactor();
}

// Namespace gamelogic_mp
// Params 0
// Checksum 0x2639a8ad, Offset: 0x151ba
// Size: 0x2f
function setendofroundsoundtimescalefactor()
{
    if ( !isdefined( level.endround_timescalefactor ) )
    {
        soundsettimescalefactorfromtable( "end_of_round" );
        level.endround_timescalefactor = 1;
        level.reset_timescalefactor = undefined;
    }
}

// Namespace gamelogic_mp
// Params 0
// Checksum 0x76e7398d, Offset: 0x151f1
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

// Namespace gamelogic_mp
// Params 1
// Checksum 0x6177ab3e, Offset: 0x1523b
// Size: 0x1b
function sendgameendedfrozennotify( delay )
{
    wait delay;
    level notify( #"game_ended_frozen" );
}

// Namespace gamelogic_mp
// Params 0
// Checksum 0x8f749286, Offset: 0x1525e
// Size: 0xce
function restart()
{
    if ( isdefined( level.onmaprestart ) )
    {
        [[ level.onmaprestart ]]();
    }
    
    level notify( #"restarting" );
    
    if ( level.multimatch ?? gameinstance::is_enabled() )
    {
        foreach ( instance in gameinstance::function_1d3a8144ddb36029() )
        {
            instance.state = "playing";
        }
    }
    
    game[ "state" ] = "playing";
    map_restart( 1 );
}

// Namespace gamelogic_mp
// Params 0
// Checksum 0x326b7a6e, Offset: 0x15334
// Size: 0xcb
function function_f98ee4b0e937d98e()
{
    if ( !function_53609df45841c88c() )
    {
        return;
    }
    
    summary = spawnstruct();
    function_319e294205292afa( summary );
    
    foreach ( player in level.players )
    {
        if ( !isplayer( player ) || isbot( player ) )
        {
            continue;
        }
        
        playerstats = playerlogic::function_6721fb96f1931666( player );
        
        if ( !isdefined( playerstats ) )
        {
            continue;
        }
        
        player function_86664f2af70d102e( playerstats );
    }
}

// Namespace gamelogic_mp
// Params 0
// Checksum 0x9f740ad, Offset: 0x15407
// Size: 0x1a
function function_22d6c00d46cf311c()
{
    level endon( #"game_ended" );
    function_4ad33b3d76915952();
    function_b753f568794337cf();
}

// Namespace gamelogic_mp
// Params 6
// Checksum 0x7c49883b, Offset: 0x15429
// Size: 0x245
function endgame( winner, endreasontext, endreasontextloss, nukedetonated, var_de9b655923cddf60, instance )
{
    if ( isdefined( level.var_9daab46fe497e39f ) )
    {
        shouldskip = [[ level.var_9daab46fe497e39f ]]();
        
        if ( shouldskip )
        {
            return;
        }
    }
    
    if ( isdefined( level.callbacks[ #"hash_47bd32b09a74f83f" ] ) || isdefined( level.callbacks[ #"hash_47bd32b09a74f83f" ] ) )
    {
        endgameparams = { #instance:instance, #var_de9b655923cddf60:var_de9b655923cddf60, #nukedetonated:nukedetonated, #endreasontextloss:endreasontextloss, #endreasontext:endreasontext, #winner:winner };
        level callback::callback( #"hash_47bd32b09a74f83f", endgameparams );
        
        if ( endgameparams.var_3c7ef276ad41c284 )
        {
            return;
        }
    }
    
    participantplayers = game_utility_mp::function_4b15b7eb1dc364e7( instance );
    function_8f79511f61eee5ec();
    level notify( #"start_game_ended" );
    level.endgamewinner = winner;
    
    if ( isdefined( level.modescorewinner ) )
    {
        winner = level.modescorewinner;
    }
    
    if ( getdvarint( @"hash_d87f39111295023c", 0 ) )
    {
        if ( game_utility_mp::waslastround() )
        {
            foreach ( player in participantplayers )
            {
                telemetry_utils::function_c54601d44e7b8e8a( player );
            }
            
            if ( !level.dlog_event_mp_server_match_end_sent )
            {
                level.dlog_event_mp_server_match_end_sent = 1;
                telemetry_data = spawnstruct();
                telemetry_data.winner = winner;
                telemetry_utils::function_af2d366f9522f76f( "callback_match_end", telemetry_data );
            }
        }
    }
    
    if ( isdefined( level.endgame ) )
    {
        [[ level.endgame ]]( winner, endreasontext, nukedetonated );
        return;
    }
    
    endgame_regularmp( winner, endreasontext, endreasontextloss, nukedetonated, var_de9b655923cddf60, undefined, undefined, instance );
}

// Namespace gamelogic_mp
// Params 8
// Checksum 0x5e612e1, Offset: 0x15676
// Size: 0x897
function endgame_regularmp( winner, endreasontext, endreasontextloss, nukedetonated = 0, var_de9b655923cddf60, var_962506261010d8d6, skippedplayer, instance )
{
    if ( !isbrgamemode() && level.gameended )
    {
        return;
    }
    
    if ( game[ "roundsPlayed" ] < 24 )
    {
        setmatchdata( "utcRoundEndTimeSeconds", game[ "roundsPlayed" ], getsystemtime() );
    }
    
    if ( game_utility::function_245a95d184375f25() )
    {
        setomnvar( "ui_round_end_time", getsystemtime() );
    }
    
    utility::trycall( level.matchdata_onroundend );
    level.var_d3b87493843ea3b1 = 1;
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
    
    participantplayers = game_utility_mp::function_4b15b7eb1dc364e7( instance );
    participantteams = game_utility_mp::function_cd6aa714027fb767( instance );
    
    if ( level.teambased )
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
                
                if ( level.multimatch ?? gameinstance::is_enabled() )
                {
                    gameinstance::function_68947b684b21c63a( team_utility::getotherteam( winner ) );
                }
            }
            
            if ( !isdefined( level.finalkillcam_winner ) )
            {
                level.finalkillcam_winner = winner;
            }
        }
        else
        {
            if ( !skipscoring && isdefined( winner ) && winner == "tie" && shouldmodescoreonties() )
            {
                foreach ( entry in participantteams )
                {
                    if ( isarray( var_962506261010d8d6 ) && isdefined( var_962506261010d8d6[ entry ] ) )
                    {
                        game[ "roundsWon" ][ entry ] = game[ "roundsWon" ][ entry ] + var_962506261010d8d6[ entry ];
                        continue;
                    }
                    
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
            foreach ( entry in participantteams )
            {
                gamescore::updateteamscore( entry );
            }
            
            if ( !( level.multimatch ?? gameinstance::is_enabled() ) )
            {
                if ( game_utility_mp::isroundbased() && game[ "roundsPlayed" ] < 24 && game_utility_mp::getbasegametype() != "koth" )
                {
                    setmatchdata( "alliesRoundScore", game[ "roundsPlayed" ], getteamscore( "allies" ) );
                    setmatchdata( "axisRoundScore", game[ "roundsPlayed" ], getteamscore( "axis" ) );
                }
            }
        }
    }
    else
    {
        if ( isplayer( winner ) && !skipscoring )
        {
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
    
    gamescore::updateplacement( participantplayers, participantteams );
    
    if ( !skipscoring )
    {
        if ( level.multimatch ?? gameinstance::is_enabled() )
        {
            if ( !level.var_2ffab987737b9ffc )
            {
                level.var_2ffab987737b9ffc = 1;
                game[ "roundsPlayed" ]++;
            }
        }
        else
        {
            game[ "roundsPlayed" ]++;
        }
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
    
    if ( game_utility_mp::matchmakinggame() && level.teambased && isdefined( winner ) && team_utility::isgameplayteam( winner ) && winner != "tie" )
    {
        setwinningteam( winner );
    }
    
    if ( game_utility_mp::wasonlyround() || game_utility_mp::waslastround() )
    {
        updatematchbonusscores( winner );
        function_b54112164c257231();
        
        foreach ( player in participantplayers )
        {
            player gameplay_telemetry::function_3e91d2222fa2419f( 1 );
            player game_utility::stopkeyearning( winner );
        }
    }
    
    if ( level.var_a4851fe642803397 )
    {
        processgameend = endgame_endround( winner, endreasontext, endreasontextloss, nukedetonated, instance );
    }
    else
    {
        processgameend = endgame_endround_old( winner, endreasontext, endreasontextloss, nukedetonated, skippedplayer, instance );
    }
    
    foreach ( player in participantplayers )
    {
        if ( !isbot( player ) && isdefined( player.team ) && player.team != "spectator" && player.team != "codcaster" )
        {
            logendofround( player );
        }
    }
    
    if ( level.multimatch ?? gameinstance::is_enabled() )
    {
        if ( processgameend == 1 )
        {
            gameinstance::function_33e89da81bb07592( instance.id );
            processgameend = gameinstance::function_22af978e6bfea368();
        }
        else
        {
            foreach ( player in participantplayers )
            {
                player spectating::setspectatepermissions();
                player thread playerlogic::spawnspectator( player.origin + ( 0, 0, 60 ), player.angles );
            }
        }
    }
    
    if ( processgameend && game_utility_mp::waslastround() )
    {
        if ( level.var_163c315e088122d6 )
        {
            winner = level.var_163c315e088122d6;
            endreasontext = level.var_554d86d70af1ffce;
            level.var_163c315e088122d6 = undefined;
            level.var_554d86d70af1ffce = undefined;
        }
        
        telemetry_data = spawnstruct();
        telemetry_data.winner = winner;
        telemetry_data.endreason = endreasontext;
        telemetry_utils::function_af2d366f9522f76f( "callback_match_end", telemetry_data );
        
        if ( level.var_5ff7b9a9c2f49f93 )
        {
            function_2ef33c883417c9a1( winner, endreasontext, endreasontextloss, nukedetonated, level.var_a4851fe642803397, skippedplayer, instance );
            return;
        }
        
        endgame_endgame( winner, endreasontext, endreasontextloss, nukedetonated, level.var_a4851fe642803397, skippedplayer, instance );
    }
}

// Namespace gamelogic_mp
// Params 0
// Checksum 0x7333cd52, Offset: 0x15f15
// Size: 0xa, Type: bool
function shouldmodescoreonties()
{
    return istrue( game[ "canScoreOnTie" ] );
}

// Namespace gamelogic_mp
// Params 1
// Checksum 0xf74f8076, Offset: 0x15f28
// Size: 0xc2
function checkmodeoverridetie( winner )
{
    var_5cfaecf4f87b0cfd = shouldmodescoreonties() && winner == "tie";
    ctftie = game_utility::getgametype() == "ctf" && winner == "tie" && !level.winrule;
    
    if ( var_5cfaecf4f87b0cfd || ctftie )
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

// Namespace gamelogic_mp
// Params 0
// Checksum 0xd9fd43c, Offset: 0x15ff3
// Size: 0xe5
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
    
    if ( level.var_86bbc7d0be1ace54 )
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
    
    if ( level.players.size == 0 )
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
        
        logstring( "^5 END MATCH FLOW -- Doing final kill instead of POTG because level.finalKillcamEnabled is true." );
        return;
    }
    
    if ( level.potgenabled )
    {
        function_1ea9f29924371f6d();
        return;
    }
    
    assertmsg( "<dev string:xc23>" );
}

// Namespace gamelogic_mp
// Params 0
// Checksum 0xd1f00326, Offset: 0x160e0
// Size: 0x116
function function_1ea9f29924371f6d()
{
    potgscene = potg::getcurpotgscene();
    dopotg = isdefined( potgscene.primaryentity );
    
    if ( dopotg )
    {
        if ( getpotgduration() == 0 )
        {
            assertmsg( "<dev string:xc7d>" );
            var_e0eb2de1f26dd073 = 1;
        }
        
        if ( var_e0eb2de1f26dd073 )
        {
            if ( getdvarint( @"hash_55861856df794323", 0 ) != 0 )
            {
                dopotg = 0;
            }
        }
    }
    
    if ( dopotg )
    {
        potginfo = potg::getfinalpotginfo();
        level final_killcam::dopotgkillcam( potginfo );
        
        if ( isdefined( potginfo ) && isdefined( potginfo.potgscene ) )
        {
            level callback::callback( #"hash_6c71d319dc089c27", { #potgscene:potginfo.potgscene, #event:#"hash_cda961d5172beeff" } );
        }
        
        return;
    }
    
    level.finalkillcamenabled = 1;
    doingkillcam = level final_killcam::dofinalkillcam();
    
    if ( isdefined( doingkillcam ) && !doingkillcam )
    {
        postroundfadenokillcam();
    }
    
    logstring( "^5[POTG] END MATCH FLOW -- Skipping POTG and enabled final killcam due to bad data in the final POTG scene." );
}

// Namespace gamelogic_mp
// Params 0
// Checksum 0x5876aeb0, Offset: 0x161fe
// Size: 0xeb
function postroundfadenokillcam()
{
    foreach ( player in level.players )
    {
        if ( !isdefined( player ) || isbot( player ) )
        {
            continue;
        }
        
        if ( level.gametype == "arena" )
        {
            player setclientomnvar( "post_game_state", 1 );
        }
        else if ( isdefined( level.var_40457022b646ec93 ) )
        {
            player setclientomnvar( "post_game_state", level.var_40457022b646ec93 );
        }
        else
        {
            player setclientomnvar( "post_game_state", 2 );
        }
        
        player thread predictandclearintermissionstreaming();
    }
    
    wait 0.5;
}

// Namespace gamelogic_mp
// Params 0
// Checksum 0x3a50c2db, Offset: 0x162f1
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

// Namespace gamelogic_mp
// Params 3
// Checksum 0xaa365edb, Offset: 0x16347
// Size: 0x85
function setgameendflagsandnotifies( winner, instance, allinstancescomplete = 1 )
{
    if ( level.multimatch ?? gameinstance::is_enabled() )
    {
        instance.state = "postgame";
    }
    
    if ( allinstancescomplete )
    {
        game[ "state" ] = "postgame";
        level notify( #"game_ended", winner );
        flags::levelflagset( "game_over" );
        flags::levelflagset( "block_notifies" );
    }
}

// Namespace gamelogic_mp
// Params 1
// Checksum 0xc4e3052b, Offset: 0x163d4
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

// Namespace gamelogic_mp
// Params 6
// Checksum 0xa6b83782, Offset: 0x16420
// Size: 0x115d, Type: bool
function endgame_endround_old( winner, endreasontext, endreasontextloss, nukedetonated, skippedplayer, instance )
{
    allinstancescomplete = 1;
    participantplayers = game_utility_mp::function_4b15b7eb1dc364e7( instance );
    participantteams = game_utility_mp::function_cd6aa714027fb767( instance );
    
    if ( level.multimatch ?? gameinstance::is_enabled() )
    {
        gameinstance::function_33e89da81bb07592( instance.id );
        allinstancescomplete = gameinstance::function_22af978e6bfea368();
        
        if ( allinstancescomplete )
        {
            level.gameendtime = gettime();
            level.gameended = 1;
        }
    }
    else
    {
        level.gameendtime = gettime();
        level.gameended = 1;
    }
    
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
        if ( level.multimatch ?? gameinstance::is_enabled() )
        {
        }
        else if ( game_utility_mp::waslastround() && game_utility::getgametype() != "arena" )
        {
            level.doeomcombat = 1;
        }
    }
    
    updateleaderboardstats( participantplayers );
    waitframe();
    gamescore::updateplacement( participantplayers, participantteams );
    level.recordfinalkillcam = 0;
    level.ignorescoring = 1;
    
    if ( allinstancescomplete )
    {
        thread potg::onroundended( winner );
        
        if ( level.potgenabled && potg::shouldskippotg() == 0 )
        {
            flags::function_2f3408423ccc9b2e( "potg_finalized" );
            potginfo = potg::getfinalpotginfo();
            potg::hintlocation( potginfo );
            
            if ( isdefined( potginfo.spectateentity ) )
            {
                if ( potginfo.spectateentity player::isreallyalive() )
                {
                    potginfo.spectateentity stopliveragdoll();
                }
                
                level.var_c998633bab11f3f8 = 1;
                potginfo.spectateentity val::set( "POTG_INVULNERABILITY", "damage", 0 );
                outofbounds::enableoobimmunity( potginfo.spectateentity );
            }
        }
        
        thread final_killcam::preloadfinalkillcam();
        
        if ( isdefined( level.winners_circle ) && isdefined( level.winners_circle.hint ) )
        {
            thread [[ level.winners_circle.hint ]]();
        }
    }
    
    level notify( #"hash_7ddc80b0350bfe28" );
    
    if ( game_utility_mp::isteamreviveenabled() )
    {
        thread teamrevive::function_e0b166703b9fff08( participantteams );
    }
    
    lastround = game_utility_mp::waslastround();
    level callback::callback( #"round_end_music", { #participantteams:participantteams, #participantplayers:participantplayers, #winner:winner, #lastround:lastround } );
    level.var_c9483c125e3413d8 = 0;
    
    if ( lastround )
    {
        if ( allinstancescomplete )
        {
            level thread setendofroundsoundtimescalefactor();
        }
        
        if ( game_utility_mp::matchmakinggame() )
        {
            if ( getdvarint( @"hash_d9b8563acb5ea299", 0 ) != 0 )
            {
                if ( getdvarint( @"hash_8465b31049c6168d", 0 ) == 1 )
                {
                    requestgamelobbyremainintact();
                }
                else if ( getdvarint( @"hash_8465b31049c6168d", 0 ) == 2 )
                {
                    function_d378787432c08bd5();
                }
                else if ( getdvarint( @"hash_8465b31049c6168d", 0 ) == 3 )
                {
                    level.var_c9483c125e3413d8 = requestgamelobbyremainintact();
                }
                else if ( getdvarint( @"hash_8465b31049c6168d", 0 ) == 4 )
                {
                    level.var_c9483c125e3413d8 = function_d378787432c08bd5();
                }
                
                function_be39e483f8eec5cc( level.var_c9483c125e3413d8 );
            }
        }
        
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
            thread waitforhitmarkerspostgame( participantplayers );
            setgameendflagsandnotifies( winner, instance );
            level waittill( #"hash_65e35697cd95016e" );
            
            foreach ( player in participantplayers )
            {
                if ( !isdefined( player ) )
                {
                    continue;
                }
                
                player setclientomnvar( "post_game_state", 2 );
            }
            
            foreach ( player in participantplayers )
            {
                if ( !isdefined( player ) )
                {
                    continue;
                }
                
                if ( level.teambased )
                {
                    player thread hud_message::teamoutcomenotify( winner, 0, endreasontext, endreasontextloss );
                    continue;
                }
                
                player thread hud_message::outcomenotify( winner, 0, endreasontext, endreasontextloss );
            }
            
            freezeallplayers( 3, @"cg_fovscale", 1, 1, participantplayers );
            hostmigration::waitlongdurationwithhostmigrationpause( 3 );
        }
        else if ( isbrgamemode() )
        {
            thread eomcombatwaitforhitmarkersanddelaystartpostgameui( winner, endreasontext, endreasontextloss, participantplayers );
            game[ "state" ] = "postgame";
            level notify( #"game_ended", winner );
            flags::levelflagset( "game_over" );
            flags::levelflagset( "block_notifies" );
            waitframe();
        }
        else
        {
            thread eomcombatwaitforhitmarkersanddelaystartpostgameui( winner, endreasontext, endreasontextloss, participantplayers );
            freezeallplayers( 2.5, @"cg_fovscale", 1, 1 );
            hostmigration::waitlongdurationwithhostmigrationpause( 2.5 );
            setgameendflagsandnotifies( winner, instance );
            waitframe();
        }
        
        foreach ( player in participantplayers )
        {
            if ( !isdefined( player ) )
            {
                continue;
            }
            
            player setclientdvar( @"ui_opensummary", 1 );
            
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
        thread waitforhitmarkerspostgame( participantplayers );
        setgameendflagsandnotifies( winner, instance, allinstancescomplete );
        waitframe();
        
        foreach ( player in participantplayers )
        {
            if ( !isdefined( player ) )
            {
                continue;
            }
            
            player setclientdvar( @"ui_opensummary", 1 );
            
            if ( ( game_utility_mp::wasonlyround() || game_utility_mp::waslastround() ) && !game[ "isLaunchChunk" ] )
            {
                player killstreaks::clearkillstreaks();
                player bounty::playerresetbountystreak();
            }
            
            player setclientomnvar( "ui_match_in_progress", 0 );
        }
        
        freezeallplayers( 1, @"cg_fovscale", 1, 0, participantplayers );
    }
    
    if ( allinstancescomplete )
    {
        setgameendtime( 0 );
    }
    
    game[ "gameLength" ] = game[ "gameLength" ] + game_utility_mp::getroundlength();
    level callback::callback( #"round_ended", { #winner:winner, #lastround:lastround } );
    
    if ( lastround )
    {
        level callback::callback( #"game_ended", { #winner:winner } );
        level callback::callback( #"hash_6c71d319dc089c27", { #winner:winner, #event:#"on_game_end_mp" } );
    }
    
    thread analyticslog::logevent_sendplayerindexdata();
    
    if ( level.var_98dc8a7195ec7c4b ?? analyticslog::function_c0d649dd2c6fbce5() )
    {
        analyticslog::analyticsstorespawndata();
    }
    
    telemetry_data = spawnstruct();
    telemetry_data.end_reason = endreasontext;
    telemetry_data.winner = winner;
    telemetry_utils::function_af2d366f9522f76f( "callback_round_end", telemetry_data );
    
    if ( telemetry_utils::function_7ffb9ee91a85ee0d( "callback_player_round_end" ) )
    {
        foreach ( player in participantplayers )
        {
            if ( !isdefined( player ) )
            {
                continue;
            }
            
            telemetry_data = spawnstruct();
            telemetry_data.player = player;
            telemetry_data.winner = winner;
            telemetry_utils::function_af2d366f9522f76f( "callback_player_round_end", telemetry_data );
        }
    }
    
    clearmatchhasmorethan1playervariablesonroundend();
    
    if ( isdefined( level.matchrecording_dump ) )
    {
        [[ level.matchrecording_dump ]]();
    }
    
    rankedmatchupdates( winner );
    
    if ( allinstancescomplete )
    {
        setdvar( @"g_deadchat", 1 );
        setdvar( @"ui_allow_teamchange", 0 );
        action_park_utility::try_cycle_next_combo();
    }
    
    /#
        sendscriptusageanalysisdata( 1, 1 );
    #/
    
    foreach ( player in participantplayers )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        player class::loadout_clearperks();
        player.deathsdoor = 0;
    }
    
    if ( game[ "practiceRound" ] && !level.forcedend )
    {
        game[ "roundsPlayed" ] = 0;
        
        foreach ( team in participantteams )
        {
            game[ "roundsWon" ][ team ] = 0;
            game[ "teamScores" ][ team ] = 0;
        }
        
        winner = "tie";
        endreasontext = game[ "end_reason" ][ "practice_round_over" ];
    }
    
    var_c416ea5639a44510 = 1;
    
    if ( var_c416ea5639a44510 )
    {
        displayroundend( winner, endreasontext, endreasontextloss, instance );
        level thread endofroundvisionset( level.roundenddelay - 1 );
    }
    
    if ( level.teambased )
    {
        foreach ( entry in participantteams )
        {
            gamescore::updatetotalteamscore( entry );
        }
    }
    
    if ( game_utility_mp::waslastround() && getdvarint( @"hash_ddca91c62c50ce54", 0 ) == 1 )
    {
        function_c4ee57017a483fd( winner, skippedplayer );
    }
    
    if ( !( level.multimatch ?? gameinstance::is_enabled() ) && allinstancescomplete && level.potgenabled && potg::shouldskippotg() == 0 )
    {
        potginfo = potg::getfinalpotginfo();
        
        if ( isdefined( potginfo.spectateentity ) )
        {
            respawningplayers = [];
            
            foreach ( player in level.players )
            {
                if ( !player::isreallyalive( player ) && !player.inspawncamera )
                {
                    player playerlogic::spawnplayer( 0, 1 );
                    respawningplayers[ respawningplayers.size ] = player;
                }
            }
            
            if ( respawningplayers.size > 0 )
            {
                waittime = level.framedurationseconds * ( respawningplayers.size + 1 );
                wait waittime;
                maxwaittime = gettime() + 2000;
                
                while ( gettime() < maxwaittime )
                {
                    allplayersalive = 1;
                    
                    foreach ( player in respawningplayers )
                    {
                        if ( isdefined( player ) && !player::isreallyalive( player ) )
                        {
                            allplayersalive = 0;
                            break;
                        }
                    }
                    
                    if ( allplayersalive )
                    {
                        break;
                    }
                    
                    waitframe();
                }
            }
            
            if ( !player::isreallyalive( potginfo.spectateentity ) )
            {
                while ( !player::isreallyalive( potginfo.spectateentity ) )
                {
                    waitframe();
                }
            }
        }
    }
    
    if ( level.gametypebundle.var_c6dba97e65cd67ce )
    {
        level thread function_cf73e197342891cc( instance );
    }
    
    roundendwait( level.roundenddelay, skippedplayer, instance );
    level notify( #"game_cleanup" );
    
    if ( !( level.multimatch ?? gameinstance::is_enabled() ) && allinstancescomplete )
    {
        endgame_showkillcam();
    }
    
    if ( level.var_86bbc7d0be1ace54 )
    {
        wm_ending::function_dca7aa9f3fa57193( winner );
    }
    
    if ( !( level.multimatch ?? gameinstance::is_enabled() ) && allinstancescomplete )
    {
        setslowmotion( 1, 1, 0 );
        resetsoundtimescalefactor();
    }
    
    if ( game[ "practiceRound" ] && !level.forcedend )
    {
        game[ "practiceRound" ] = 0;
        
        if ( level.allowsupers && !game_utility_mp::runleanthreadmode() )
        {
            foreach ( player in participantplayers )
            {
                player supers_mp::clearsuper();
                player perkpackage::perkpackage_reset();
            }
        }
        
        flags::levelflagclear( "block_notifies" );
        restart();
        return false;
    }
    else if ( allinstancescomplete )
    {
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
                        displayroundswitch( instance );
                    }
                }
                
                foreach ( player in level.players )
                {
                    player.pers[ "stats" ] = player.stats;
                    
                    if ( player::isreallyalive( player ) && isdefined( player.pers[ "telemetry" ] ) && isdefined( player.pers[ "telemetry" ].life ) && isdefined( player.pers[ "telemetry" ].life.life_index ) )
                    {
                        deathdata = spawnstruct();
                        deathdata.victim = player;
                        deathdata.attacker = undefined;
                        deathdata.meansofdeath = "MOD_ROUND_ENDED";
                        deathdata.weaponfullstring = "none";
                        telemetry_utils::function_af2d366f9522f76f( "callback_player_death", deathdata );
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
    
    if ( ( level.multimatch ?? gameinstance::is_enabled() ) && !allinstancescomplete )
    {
        return false;
    }
    
    return true;
}

// Namespace gamelogic_mp
// Params 1
// Checksum 0x6cfecb22, Offset: 0x17586
// Size: 0xa8
function function_cf73e197342891cc( instance )
{
    wait level.roundenddelay - 0.5;
    participantplayers = game_utility_mp::function_4b15b7eb1dc364e7( instance );
    
    foreach ( player in participantplayers )
    {
        level thread game_utility::fadetoblackforplayer( player, 1, 0.25 );
    }
}

// Namespace gamelogic_mp
// Params 1, eflags: 0x4
// Checksum 0x478a5e66, Offset: 0x17636
// Size: 0x10e
function private function_3a15ebe55864b591( var_db2e4f7359b10381 )
{
    wasonlyround = game_utility_mp::wasonlyround();
    waslastround = game_utility_mp::waslastround();
    islaunchchunk = var_db2e4f7359b10381 ? !game[ "isLaunchChunk" ] : 1;
    var_2fa6ef0d48c6ba7d = !level.leagueplaymatchcancelled;
    
    foreach ( player in level.players )
    {
        player setclientdvar( @"ui_opensummary", var_2fa6ef0d48c6ba7d );
        
        if ( ( wasonlyround || waslastround ) && islaunchchunk )
        {
            player killstreaks::clearkillstreaks();
            player bounty::playerresetbountystreak();
        }
        
        player setclientomnvar( "ui_match_in_progress", 0 );
    }
}

// Namespace gamelogic_mp
// Params 0
// Checksum 0xee7635ec, Offset: 0x1774c
// Size: 0x14f
function function_23b981423fbd4d94()
{
    foreach ( player in level.players )
    {
        player.pers[ "stats" ] = player.stats;
        
        if ( player::isreallyalive( player ) && isdefined( player.pers[ "telemetry" ] ) && isdefined( player.pers[ "telemetry" ].life ) && isdefined( player.pers[ "telemetry" ].life.life_index ) )
        {
            deathdata = spawnstruct();
            deathdata.victim = player;
            deathdata.attacker = undefined;
            deathdata.meansofdeath = "MOD_ROUND_ENDED";
            deathdata.weaponfullstring = "none";
            telemetry_utils::function_af2d366f9522f76f( "callback_player_death", deathdata );
        }
    }
}

// Namespace gamelogic_mp
// Params 5
// Checksum 0x4d97bb07, Offset: 0x178a3
// Size: 0x754, Type: bool
function endgame_endround( winner, endreasontext, endreasontextloss, nukedetonated, instance )
{
    participantplayers = game_utility_mp::function_4b15b7eb1dc364e7( instance );
    participantteams = game_utility_mp::function_cd6aa714027fb767( instance );
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
        
        if ( !level.teambased )
        {
            level.forcedend = 1;
            game[ "state" ] = "postgame";
            flags::levelflagset( "game_over" );
            flags::levelflagset( "block_notifies" );
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
    
    updateleaderboardstats( participantplayers );
    waitframe();
    gamescore::updateplacement();
    level.recordfinalkillcam = 0;
    level.ignorescoring = 1;
    thread potg::onroundended( winner );
    
    if ( level.potgenabled && potg::shouldskippotg() == 0 )
    {
        flags::function_2f3408423ccc9b2e( "potg_finalized" );
    }
    
    thread final_killcam::preloadfinalkillcam();
    
    if ( isdefined( level.winners_circle ) && isdefined( level.winners_circle.hint ) )
    {
        thread [[ level.winners_circle.hint ]]();
    }
    
    level notify( #"hash_7ddc80b0350bfe28" );
    
    if ( game_utility_mp::isteamreviveenabled() )
    {
        thread teamrevive::function_e0b166703b9fff08();
    }
    
    lastround = game_utility_mp::waslastround();
    level callback::callback( #"round_end_music", { #participantteams:participantteams, #participantplayers:participantplayers, #winner:winner, #lastround:lastround } );
    level.var_c9483c125e3413d8 = 0;
    
    if ( lastround )
    {
        level thread setendofroundsoundtimescalefactor();
        
        if ( game_utility_mp::matchmakinggame() )
        {
            if ( getdvarint( @"hash_d9b8563acb5ea299", 0 ) != 0 )
            {
                if ( getdvarint( @"hash_8465b31049c6168d", 0 ) == 1 )
                {
                    requestgamelobbyremainintact();
                }
                else if ( getdvarint( @"hash_8465b31049c6168d", 0 ) == 2 )
                {
                    function_d378787432c08bd5();
                }
                else if ( getdvarint( @"hash_8465b31049c6168d", 0 ) == 3 )
                {
                    level.var_c9483c125e3413d8 = requestgamelobbyremainintact();
                }
                else if ( getdvarint( @"hash_8465b31049c6168d", 0 ) == 4 )
                {
                    level.var_c9483c125e3413d8 = function_d378787432c08bd5();
                }
                
                function_be39e483f8eec5cc( level.var_c9483c125e3413d8 );
            }
        }
        
        if ( level.postgameexfil && !level.forcedend )
        {
            if ( winner != "tie" )
            {
                level waittill( #"exfil_continue_game_end" );
            }
        }
    }
    
    if ( level.doeomcombat )
    {
        if ( isbrgamemode() )
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
            setgameendflagsandnotifies( winner );
        }
        
        function_3a15ebe55864b591( 0 );
    }
    else
    {
        thread waitforhitmarkerspostgame( level.players );
        setgameendflagsandnotifies( winner );
        waitframe();
        function_3a15ebe55864b591( 1 );
    }
    
    setgameendtime( 0 );
    game[ "gameLength" ] = game[ "gameLength" ] + game_utility_mp::getroundlength();
    thread analyticslog::logevent_sendplayerindexdata();
    
    if ( level.var_98dc8a7195ec7c4b ?? analyticslog::function_c0d649dd2c6fbce5() )
    {
        analyticslog::analyticsstorespawndata();
    }
    
    level callback::callback( #"round_ended", { #winner:winner, #lastround:lastround } );
    
    if ( lastround )
    {
        level callback::callback( #"game_ended", { #winner:winner } );
        level callback::callback( #"hash_6c71d319dc089c27", { #winner:winner, #event:#"on_game_end_mp" } );
    }
    
    telemetry_data = spawnstruct();
    telemetry_data.end_reason = endreasontext;
    telemetry_data.winner = winner;
    telemetry_utils::function_af2d366f9522f76f( "callback_round_end", telemetry_data );
    
    if ( telemetry_utils::function_7ffb9ee91a85ee0d( "callback_player_round_end" ) )
    {
        foreach ( player in level.players )
        {
            telemetry_data = spawnstruct();
            telemetry_data.player = player;
            telemetry_data.winner = winner;
            telemetry_utils::function_af2d366f9522f76f( "callback_player_round_end", telemetry_data );
        }
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
        if ( !lastround && !level.potgenabled )
        {
            player class::loadout_clearperks();
        }
        
        player.deathsdoor = 0;
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
    
    if ( utility::issharedfuncdefined( #"display_transition", #"hash_52e073a8a81a3b48" ) )
    {
        outcome = spawnstruct();
        outcome.winner = winner;
        outcome.end_reason = endreasontext;
        outcome.end_reason_loss = endreasontextloss;
        outcome.isround = 1;
        [[ utility::getsharedfunc( #"display_transition", #"hash_52e073a8a81a3b48" ) ]]( outcome );
    }
    
    level notify( #"game_cleanup" );
    return true;
}

// Namespace gamelogic_mp
// Params 1
// Checksum 0xfbb5f62d, Offset: 0x18000
// Size: 0x164
function tacopsroundendwait( defaultdelay )
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
    
    codcasterdelay = 0;
    
    foreach ( player in level.players )
    {
        player thread game_utility_mp::setuipostgamefade( 0 );
        
        if ( player iscodcaster() )
        {
            codcasterdelay = level.var_e3c3286caf6ae8b8;
        }
    }
    
    wait defaultdelay + codcasterdelay;
    setomnvarforallclients( "post_game_state", 1 );
    level notify( #"round_end_finished" );
}

// Namespace gamelogic_mp
// Params 2
// Checksum 0xe750c007, Offset: 0x1816c
// Size: 0x2c, Type: bool
function compare_player_score( left, right )
{
    return left.score >= right.score;
}

// Namespace gamelogic_mp
// Params 7
// Checksum 0x25ef0887, Offset: 0x181a1
// Size: 0xe69
function endgame_endgame( winner, endreasontext, endreasontextloss, nukedetonated, var_fd814d00e85a1673, skippedplayer, instance )
{
    canceljoins();
    setnojipscore( 1, 1 );
    setnojiptime( 1, 1 );
    
    if ( br_public::isbrpracticemode() && !level.forcedend )
    {
        level._waitforlui = 1;
        level ui::lui_registercallback( "exit_squad_eliminated", &endgame_luidecisionreceived );
    }
    
    if ( !level.processedwinloss && ( level.forfeitinprogress || level.forcedend ) )
    {
        updatewinlossstats( winner );
    }
    
    checkforpersonalbests();
    updatespmstats();
    persistence::writebestscores();
    level notify( #"hash_5b8a8903d2af7a11" );
    participantplayers = game_utility_mp::function_4b15b7eb1dc364e7( instance );
    updateleaderboardstats( participantplayers );
    level accolades::evaluateallaccolades();
    setomnvar( "ui_winning_team", teams::getteamindex( winner ) );
    
    if ( var_fd814d00e85a1673 )
    {
        if ( utility::issharedfuncdefined( #"display_transition", #"display_match_end" ) )
        {
            outcome = spawnstruct();
            outcome.winner = winner;
            outcome.end_reason = endreasontext;
            outcome.end_reason_loss = endreasontextloss;
            outcome.isround = 0;
            
            if ( level.forfeitend )
            {
                outcome.forfeit = 1;
            }
            
            [[ utility::getsharedfunc( #"display_transition", #"display_match_end" ) ]]( outcome );
        }
    }
    else
    {
        if ( isdefined( level.winners_circle ) )
        {
            level.doing_winners_circle = [[ level.winners_circle.init ]]( winner );
        }
        else
        {
            level.doing_winners_circle = 0;
        }
        
        if ( !level.doing_winners_circle && !isdefined( level.brwinnerscircle ) )
        {
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
        }
    }
    
    if ( nukedetonated && isdefined( level.nukeinfo.visionset ) && !level.nukeinfo.cancelled )
    {
        player::_visionsetnaked( level.nukeinfo.visionset, 0 );
        visionsetfadetoblack( "", 0.75 );
    }
    else
    {
        player::_visionsetnaked( "", 0 );
        visionsetfadetoblack( "", 0.75 );
    }
    
    if ( !var_fd814d00e85a1673 )
    {
        displaygameend( winner, endreasontext, endreasontextloss, instance );
    }
    
    flags::levelflagclear( "block_notifies" );
    rejoin_utility::rejoin_matchend();
    
    if ( level.leagueplaymatch )
    {
        leagueplay::match_end( winner );
    }
    
    level.intermission = 1;
    
    if ( !var_fd814d00e85a1673 )
    {
        if ( !level.doing_winners_circle )
        {
            if ( isbrgamemode() )
            {
                br_circle::hidedangercircle();
                setomnvarforallclients( "ui_br_transition_type", 0 );
                
                if ( function_96b019969ae0c827() )
                {
                    setomnvarforallclients( "post_game_state", 14 );
                }
                
                if ( !br_public::isbrpracticemode() )
                {
                    var_7b2b170c769c51d0 = function_4f6c05a3c1a9ab54();
                    wait var_7b2b170c769c51d0;
                }
            }
            else
            {
                if ( level._waitforlui )
                {
                    level waittill( #"hash_997055096957f13c" );
                }
                
                level.postroundtime = 0;
            }
        }
    }
    
    if ( !isbrgamemode() || game_utility::getgametype() == "dmz" || game_utility::getgametype() == "plunder" || game_utility::getgametype() == "kingslayer" || game_utility_mp::isprophuntgametype() )
    {
        processlobbydata();
    }
    
    if ( !var_fd814d00e85a1673 )
    {
        if ( level.doing_winners_circle )
        {
            setomnvarforallclients( "post_game_state", 6 );
            wait 0.1;
            [[ level.winners_circle.start ]]( winner );
            level waittill( #"winners_circle_end" );
            [[ level.winners_circle.end ]]();
        }
        else
        {
            level notify( #"winners_circle_skipped" );
        }
        
        if ( level.gametype == "free_run_evo" || level.gametype == "free_run" )
        {
            wait 3;
        }
        
        if ( function_66c4e07170b20b12() )
        {
            setomnvarforallclients( "ui_scoreboard_enabled", 1 );
            setomnvarforallclients( "post_game_state", 5 );
            level.postroundtime = 4.5;
        }
        
        if ( !isbrgamemode() )
        {
            if ( level.doing_winners_circle )
            {
                foreach ( player in level.players )
                {
                    player thread game_utility_mp::setuipostgamefade( 0 );
                }
                
                wait 0.3;
                setomnvarforallclients( "post_game_state", 1 );
                level notify( #"round_end_finished" );
            }
            else
            {
                roundendwait( level.postroundtime, undefined, instance );
            }
        }
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
    
    foreach ( player in level.players )
    {
        telemetry_utils::function_c54601d44e7b8e8a( player );
        
        if ( !isdefined( endreasontext ) )
        {
            /#
                iprintlnbold( "<dev string:xcd8>" );
            #/
            
            endreasontext = game[ "end_reason" ][ "objective_completed" ];
        }
        
        player setplayerdata( "common", "round", "endReasonTextIndex", endreasontext );
        
        if ( isalive( player ) && isdefined( player.pers[ "telemetry" ] ) && isdefined( player.pers[ "telemetry" ].life ) && isdefined( player.pers[ "telemetry" ].life.life_index ) )
        {
            deathdata = spawnstruct();
            deathdata.victim = player;
            deathdata.attacker = undefined;
            deathdata.meansofdeath = "MOD_GAME_ENDED";
            deathdata.weaponfullstring = "none";
            telemetry_utils::function_af2d366f9522f76f( "callback_player_death", deathdata );
        }
        
        topplayercount = int( min( 3, topplayers.size ) );
        topplayerstatus = 0;
        
        for ( i = 0; i < topplayercount ; i++ )
        {
            if ( player == topplayers[ i ] )
            {
                topplayerstatus = 1;
            }
        }
        
        if ( level.teambased )
        {
            if ( team_utility::isgameplayteam( winner ) )
            {
                if ( isdefined( player.team ) )
                {
                    if ( player.team == winner )
                    {
                        player.pers[ "match_outcome" ] = "win";
                        function_3b5c3561b2cfc173( player, 1 );
                    }
                    else
                    {
                        player.pers[ "match_outcome" ] = "loss";
                        function_3b5c3561b2cfc173( player, 0 );
                    }
                }
            }
            else if ( !isdefined( winner ) || isstring( winner ) && winner == "tie" )
            {
                player.pers[ "match_outcome" ] = "tie";
            }
        }
        else if ( isplayer( winner ) )
        {
            if ( isdefined( level.lastplayerwins ) )
            {
                if ( player == level.placement[ "all" ][ 0 ] )
                {
                    player.pers[ "match_outcome" ] = "win";
                }
                else
                {
                    player.pers[ "match_outcome" ] = "loss";
                }
            }
            else if ( topplayerstatus )
            {
                player.pers[ "match_outcome" ] = "win";
                function_3b5c3561b2cfc173( player, 1 );
            }
            else
            {
                player.pers[ "match_outcome" ] = "loss";
                function_3b5c3561b2cfc173( player, 0 );
            }
        }
        else if ( !isdefined( winner ) || isstring( winner ) && winner == "tie" )
        {
            player.pers[ "match_outcome" ] = "tie";
            function_3b5c3561b2cfc173( player, 0 );
        }
        
        if ( player game_utility_mp::onlinestatsenabled() )
        {
            player setplayerdata( level.var_6f9b00680ed002d8, "playerStats", "comparisonSeason", getdvarint( @"current_season" ) );
            elapsedtime = int( game_utility_mp::getsecondspassed() );
            
            foreach ( scope in [ "lifetimeStats", "seasonalStats" ] )
            {
                oldval = 0;
                
                if ( player hasplayerdata() )
                {
                    oldval = player getplayerdata( level.var_6f9b00680ed002d8, "playerStats", scope, game_utility_mp::function_299e53027853be11(), "timeSpent" );
                }
                
                player setplayerdata( level.var_6f9b00680ed002d8, "playerStats", scope, game_utility_mp::function_299e53027853be11(), "timeSpent", oldval + elapsedtime );
            }
        }
        
        player utility::trycall( level.matchdata_logplayerdata );
    }
    
    telemetry_utils::function_af2d366f9522f76f( "callback_server_exit_level" );
    utility::trycall( level.matchdata_recordrecentlyplayeddata );
    onmatchend();
    sendendofmatchdata();
    function_3dfd6efd8f531d2f();
    function_e4456500a1573b18();
    
    foreach ( player in level.players )
    {
        player.pers[ "stats" ] = player.stats;
    }
    
    function_f98ee4b0e937d98e();
    
    if ( game[ "isLaunchChunk" ] )
    {
        wait 1;
    }
    else if ( !nukedetonated && !level.postgamenotifies )
    {
        if ( isdefined( level.doing_winners_circle ) && !level.doing_winners_circle && !function_653635091e4975a9() )
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
    }
    else
    {
        wait min( 10, 4 + level.postgamenotifies );
    }
    
    telemetry_mp::function_b0f4fb2573fbd1dd();
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
    
    if ( !level.var_ee74e8eed7f0fe09 )
    {
        level notify( #"exitlevel_called" );
    }
    
    if ( br_public::isbrpracticemode() && isdefined( level._luidecision ) && level._luidecision == 2 )
    {
        bots::drop_bots( 1, level.player.team );
        restart();
        return;
    }
    
    if ( level.var_ee74e8eed7f0fe09 )
    {
        var_ad8d8f9ab93c632 = getdvarfloat( @"hash_7fda7fc9ae065797", 30 );
        wait var_ad8d8f9ab93c632;
        level notify( #"exitlevel_called" );
        exitlevel( 0 );
        return;
    }
    
    exitlevel( 0 );
}

// Namespace gamelogic_mp
// Params 7
// Checksum 0xc9705714, Offset: 0x19012
// Size: 0x6f8
function function_2ef33c883417c9a1( winner, endreasontext, endreasontextloss, nukedetonated, var_fd814d00e85a1673, skippedplayer, instance )
{
    canceljoins();
    setnojipscore( 1, 1 );
    setnojiptime( 1, 1 );
    
    if ( br_public::isbrpracticemode() && !level.forcedend )
    {
        level._waitforlui = 1;
        level ui::lui_registercallback( "exit_squad_eliminated", &endgame_luidecisionreceived );
    }
    
    setomnvar( "ui_winning_team", teams::getteamindex( winner ) );
    
    if ( var_fd814d00e85a1673 )
    {
        if ( utility::issharedfuncdefined( #"display_transition", #"display_match_end" ) )
        {
            outcome = spawnstruct();
            outcome.winner = winner;
            outcome.end_reason = endreasontext;
            outcome.end_reason_loss = endreasontextloss;
            outcome.isround = 0;
            [[ utility::getsharedfunc( #"display_transition", #"display_match_end" ) ]]( outcome );
        }
    }
    else
    {
        if ( isdefined( level.winners_circle ) )
        {
            level.doing_winners_circle = [[ level.winners_circle.init ]]( winner );
        }
        else
        {
            level.doing_winners_circle = 0;
        }
        
        if ( !level.doing_winners_circle )
        {
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
        }
    }
    
    if ( nukedetonated && isdefined( level.nukeinfo.visionset ) && !level.nukeinfo.cancelled )
    {
        player::_visionsetnaked( level.nukeinfo.visionset, 0 );
        visionsetfadetoblack( "", 0.75 );
    }
    else
    {
        player::_visionsetnaked( "", 0 );
        visionsetfadetoblack( "", 0.75 );
    }
    
    if ( !var_fd814d00e85a1673 )
    {
        displaygameend( winner, endreasontext, endreasontextloss, instance );
    }
    
    flags::levelflagclear( "block_notifies" );
    rejoin_utility::rejoin_matchend();
    level.intermission = 1;
    
    if ( !var_fd814d00e85a1673 )
    {
        if ( !level.doing_winners_circle )
        {
            if ( isbrgamemode() )
            {
                br_circle::hidedangercircle();
                setomnvarforallclients( "ui_br_transition_type", 0 );
                
                if ( function_96b019969ae0c827() )
                {
                    setomnvarforallclients( "post_game_state", 14 );
                }
                
                if ( !br_public::isbrpracticemode() )
                {
                    var_7b2b170c769c51d0 = function_4f6c05a3c1a9ab54();
                    wait var_7b2b170c769c51d0;
                }
            }
            else
            {
                if ( level._waitforlui )
                {
                    level waittill( #"hash_997055096957f13c" );
                }
                
                level.postroundtime = 0;
            }
        }
    }
    
    if ( !var_fd814d00e85a1673 )
    {
        if ( level.doing_winners_circle )
        {
            setomnvarforallclients( "post_game_state", 6 );
            wait 0.1;
            [[ level.winners_circle.start ]]( winner );
            level waittill( #"winners_circle_end" );
            [[ level.winners_circle.end ]]();
        }
        else
        {
            level notify( #"winners_circle_skipped" );
        }
        
        if ( function_66c4e07170b20b12() )
        {
            setomnvarforallclients( "ui_scoreboard_enabled", 1 );
            setomnvarforallclients( "post_game_state", 5 );
        }
        
        if ( !isbrgamemode() )
        {
            if ( level.doing_winners_circle )
            {
                foreach ( player in level.players )
                {
                    player thread game_utility_mp::setuipostgamefade( 0 );
                }
                
                wait 0.3;
                setomnvarforallclients( "post_game_state", 1 );
                level notify( #"round_end_finished" );
            }
            else
            {
                roundendwait( level.postroundtime, undefined, instance );
            }
        }
    }
    
    if ( game[ "isLaunchChunk" ] )
    {
        wait 1;
    }
    else
    {
        elapsedtime = ( gettime() - level.var_2962ee10b87011ad ) / 1000;
        waittime = 5 - elapsedtime;
        
        if ( waittime > 0 )
        {
            wait waittime;
        }
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
    
    if ( !level.var_ee74e8eed7f0fe09 )
    {
        level notify( #"exitlevel_called" );
    }
    
    if ( br_public::isbrpracticemode() && isdefined( level._luidecision ) && level._luidecision == 2 )
    {
        bots::drop_bots( 1, level.player.team );
        restart();
        return;
    }
    
    if ( level.var_ee74e8eed7f0fe09 )
    {
        var_ad8d8f9ab93c632 = getdvarfloat( @"hash_7fda7fc9ae065797", 30 );
        wait var_ad8d8f9ab93c632;
        level notify( #"exitlevel_called" );
        exitlevel( 0 );
        return;
    }
    
    exitlevel( 0 );
}

// Namespace gamelogic_mp
// Params 3
// Checksum 0x7f99da51, Offset: 0x19712
// Size: 0x6fc
function function_c4ee57017a483fd( winner, endreasontext, skippedplayer )
{
    if ( level.var_5ff7b9a9c2f49f93 )
    {
        return;
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
    
    if ( level.leagueplaymatch )
    {
        leagueplay::match_end( winner );
    }
    
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
    
    foreach ( player in level.players )
    {
        telemetry_utils::function_c54601d44e7b8e8a( player );
        
        if ( !isdefined( endreasontext ) )
        {
            /#
                iprintlnbold( "<dev string:xcd8>" );
            #/
            
            endreasontext = game[ "end_reason" ][ "objective_completed" ];
        }
        
        player setplayerdata( "common", "round", "endReasonTextIndex", endreasontext );
        
        if ( isalive( player ) && isdefined( player.pers[ "telemetry" ] ) && isdefined( player.pers[ "telemetry" ].life ) && isdefined( player.pers[ "telemetry" ].life.life_index ) )
        {
            deathdata = spawnstruct();
            deathdata.victim = player;
            deathdata.attacker = undefined;
            deathdata.meansofdeath = "MOD_GAME_ENDED";
            deathdata.weaponfullstring = "none";
            telemetry_utils::function_af2d366f9522f76f( "callback_player_death", deathdata );
        }
        
        topplayercount = int( min( 3, topplayers.size ) );
        topplayerstatus = 0;
        
        for ( i = 0; i < topplayercount ; i++ )
        {
            if ( player == topplayers[ i ] )
            {
                topplayerstatus = 1;
            }
        }
        
        if ( level.teambased )
        {
            if ( team_utility::isgameplayteam( winner ) )
            {
                if ( isdefined( player.team ) )
                {
                    if ( player.team == winner )
                    {
                        player.pers[ "match_outcome" ] = "win";
                        function_3b5c3561b2cfc173( player, 1 );
                    }
                    else
                    {
                        player.pers[ "match_outcome" ] = "loss";
                        function_3b5c3561b2cfc173( player, 0 );
                    }
                }
            }
            else if ( !isdefined( winner ) || isstring( winner ) && winner == "tie" )
            {
                player.pers[ "match_outcome" ] = "tie";
            }
        }
        else if ( isplayer( winner ) )
        {
            if ( isdefined( level.lastplayerwins ) )
            {
                if ( player == level.placement[ "all" ][ 0 ] )
                {
                    player.pers[ "match_outcome" ] = "win";
                }
                else
                {
                    player.pers[ "match_outcome" ] = "loss";
                }
            }
            else if ( topplayerstatus )
            {
                player.pers[ "match_outcome" ] = "win";
                function_3b5c3561b2cfc173( player, 1 );
            }
            else
            {
                player.pers[ "match_outcome" ] = "loss";
                function_3b5c3561b2cfc173( player, 0 );
            }
        }
        else if ( !isdefined( winner ) || isstring( winner ) && winner == "tie" )
        {
            player.pers[ "match_outcome" ] = "tie";
            function_3b5c3561b2cfc173( player, 0 );
        }
        
        if ( player game_utility_mp::onlinestatsenabled() )
        {
            player setplayerdata( level.var_6f9b00680ed002d8, "playerStats", "comparisonSeason", getdvarint( @"current_season" ) );
            elapsedtime = int( game_utility_mp::getsecondspassed() );
            
            foreach ( scope in [ "lifetimeStats", "seasonalStats" ] )
            {
                oldval = 0;
                
                if ( player hasplayerdata() )
                {
                    oldval = player getplayerdata( level.var_6f9b00680ed002d8, "playerStats", scope, game_utility_mp::function_299e53027853be11(), "timeSpent" );
                }
                
                player setplayerdata( level.var_6f9b00680ed002d8, "playerStats", scope, game_utility_mp::function_299e53027853be11(), "timeSpent", oldval + elapsedtime );
            }
        }
        
        player utility::trycall( level.matchdata_logplayerdata );
    }
    
    telemetry_utils::function_af2d366f9522f76f( "callback_server_exit_level" );
    utility::trycall( level.matchdata_recordrecentlyplayeddata );
    onmatchend();
    sendendofmatchdata();
    function_3dfd6efd8f531d2f();
    function_e4456500a1573b18();
    
    foreach ( player in level.players )
    {
        player.pers[ "stats" ] = player.stats;
    }
    
    function_f98ee4b0e937d98e();
    level.var_5ff7b9a9c2f49f93 = 1;
    level.var_2962ee10b87011ad = gettime();
}

// Namespace gamelogic_mp
// Params 1
// Checksum 0xe9fd0168, Offset: 0x19e16
// Size: 0x5d
function spawnintermission_default( isendgame )
{
    player = self;
    intermissionspawnpointoverride = getintermissionspawnpointoverride();
    player thread game_utility_mp::setuipostgamefade( 0 );
    
    if ( !isdefined( level.modespawnendofgame ) || !player [[ level.modespawnendofgame ]]() )
    {
        player thread playerlogic::spawnintermission( intermissionspawnpointoverride );
    }
}

// Namespace gamelogic_mp
// Params 0
// Checksum 0x5204d8be, Offset: 0x19e7b
// Size: 0x42, Type: bool
function function_96b019969ae0c827()
{
    skipaar = isdefined( level.gametypebundle ) ? istrue( level.gametypebundle.skipaar ) : 0;
    skipaar = skipaar || function_653635091e4975a9();
    return !skipaar;
}

// Namespace gamelogic_mp
// Params 0
// Checksum 0x66b9f8f7, Offset: 0x19ec6
// Size: 0x57, Type: bool
function function_66c4e07170b20b12()
{
    if ( getdvarint( @"hash_f95ff237d1524382" ) == 1 )
    {
        return false;
    }
    
    var_77e34bb7a29b3c03 = isdefined( level.gametypebundle ) ? istrue( level.gametypebundle.var_77e34bb7a29b3c03 ) : 0;
    var_77e34bb7a29b3c03 = var_77e34bb7a29b3c03 || function_653635091e4975a9();
    return !var_77e34bb7a29b3c03;
}

// Namespace gamelogic_mp
// Params 0
// Checksum 0x3359cc6d, Offset: 0x19f26
// Size: 0x44
function function_4f6c05a3c1a9ab54()
{
    waittime = 25;
    
    if ( getdvarint( @"lui_ingame_play_again_enabled", 0 ) == 1 )
    {
        waittime = 25;
    }
    else if ( getdvarint( @"hash_e94e38873c94b670", 0 ) == 1 )
    {
        waittime = 0;
    }
    
    return waittime;
}

// Namespace gamelogic_mp
// Params 0
// Checksum 0x2cca9ad4, Offset: 0x19f73
// Size: 0xa3
function sendendofmatchdata()
{
    if ( !isdefined( level.endofmatchdatasent ) )
    {
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
            
            function_e1ff05fb311cd40();
            sendmatchdata();
        }
    }
    
    level.endofmatchdatasent = 1;
}

// Namespace gamelogic_mp
// Params 1
// Checksum 0x67084fb0, Offset: 0x1a01e
// Size: 0xac
function settournamentwinner( winner )
{
    if ( !isdefined( winner ) )
    {
        return;
    }
    
    if ( !level.teambased )
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

// Namespace gamelogic_mp
// Params 1
// Checksum 0x71326d9f, Offset: 0x1a0d2
// Size: 0xa4
function waitforhitmarkerspostgame( participantplayers )
{
    wait level.postgamehitmarkerwaittime;
    
    foreach ( player in participantplayers )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        player notify( #"hash_bd6935872ca1b8ee" );
        player setclientomnvar( "post_game_state", 1 );
    }
}

// Namespace gamelogic_mp
// Params 4
// Checksum 0x7518f27f, Offset: 0x1a17e
// Size: 0x155
function eomcombatwaitforhitmarkersanddelaystartpostgameui( winner, endreasontext, endreasontextloss, participantplayers )
{
    wait level.postgamehitmarkerwaittime;
    
    foreach ( player in participantplayers )
    {
        player notify( #"hash_bd6935872ca1b8ee" );
    }
    
    if ( !isbrgamemode() && game_utility::getgametype() != "ob" )
    {
        setomnvarforallclients( "post_game_state", 2 );
    }
    
    foreach ( player in participantplayers )
    {
        if ( level.teambased )
        {
            player thread hud_message::teamoutcomenotify( winner, 0, endreasontext, endreasontextloss );
            continue;
        }
        
        player thread hud_message::outcomenotify( winner, 0, endreasontext, endreasontextloss );
    }
}

// Namespace gamelogic_mp
// Params 0
// Checksum 0xd67b61ff, Offset: 0x1a2db
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

// Namespace gamelogic_mp
// Params 1
// Checksum 0xc609c66b, Offset: 0x1a442
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

// Namespace gamelogic_mp
// Params 1
// Checksum 0x158d070e, Offset: 0x1a66a
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

// Namespace gamelogic_mp
// Params 1
// Checksum 0x605f7a1d, Offset: 0x1a708
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

// Namespace gamelogic_mp
// Params 1
// Checksum 0x7c2db6dc, Offset: 0x1a7b9
// Size: 0x86
function estimatedtimetillscorelimit( team )
{
    assert( isplayer( self ) || isdefined( team ) );
    scoreperminute = getscoreperminute( team );
    scoreremaining = scoreperminute;
    
    if ( level.gametypebundle.scoringstrategy == #"teamscores" )
    {
        scoreremaining = getscoreremaining( team );
    }
    
    var_bc0480f444894cac = 999999;
    
    if ( scoreperminute )
    {
        var_bc0480f444894cac = scoreremaining / scoreperminute;
    }
    
    return var_bc0480f444894cac;
}

// Namespace gamelogic_mp
// Params 1
// Checksum 0x7d01310d, Offset: 0x1a848
// Size: 0x70
function getscoreperminute( team )
{
    assert( isplayer( self ) || isdefined( team ) );
    minutespassed = game_utility::gettimepassed() / 60000 + 0.0001;
    
    if ( isdefined( team ) )
    {
        scoreperminute = getteamscore( team ) / minutespassed;
    }
    else if ( isplayer( self ) )
    {
        scoreperminute = self.score / minutespassed;
    }
    
    return scoreperminute;
}

// Namespace gamelogic_mp
// Params 1
// Checksum 0xb57beb84, Offset: 0x1a8c1
// Size: 0x69
function getscoreremaining( team )
{
    assert( isplayer( self ) || isdefined( team ) );
    scorelimit = level.roundscorelimit;
    
    if ( isdefined( team ) )
    {
        scoreremaining = scorelimit - getteamscore( team );
    }
    else if ( isplayer( self ) )
    {
        scoreremaining = scorelimit - self.score;
    }
    
    return scoreremaining;
}

// Namespace gamelogic_mp
// Params 1
// Checksum 0x6e95431f, Offset: 0x1a933
// Size: 0x10f
function givelastonteamwarning( team )
{
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    player::waittillrecoveredhealth( 3 );
    level thread battlechatter_mp::trysaylocalsound( self, #"bc_status_inform_last_one" );
    thread hud_util::teamplayercardsplash( #"last_teammate_alive_callout", self, self.pers[ "team" ] );
    participantteams = game_utility_mp::function_cd6aa714027fb767( team );
    
    foreach ( teamname in participantteams )
    {
        if ( self.pers[ "team" ] != teamname )
        {
            thread hud_util::teamplayercardsplash( #"last_enemy_alive_callout", self, teamname );
        }
    }
    
    level notify( #"last_alive", self );
}

// Namespace gamelogic_mp
// Params 0
// Checksum 0x477ca44e, Offset: 0x1aa4a
// Size: 0xe3
function processlobbydata()
{
    foreach ( player in level.players )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        processlobbydataforclient( player );
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

// Namespace gamelogic_mp
// Params 1
// Checksum 0x64bd3cb9, Offset: 0x1ab35
// Size: 0x42
function assignclientmatchdataid( player )
{
    if ( isdefined( player ) && !isdefined( player.clientmatchdataid ) )
    {
        player.clientmatchdataid = level.currentclientmatchdataid;
        level.currentclientmatchdataid++;
    }
}

// Namespace gamelogic_mp
// Params 1
// Checksum 0xe3abcacb, Offset: 0x1ab7f
// Size: 0x1e6
function processlobbydataforclient( player )
{
    if ( player.processlobbydataforclient )
    {
        return;
    }
    
    player.processlobbydataforclient = 1;
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

// Namespace gamelogic_mp
// Params 4
// Checksum 0x52ea23eb, Offset: 0x1ad6d
// Size: 0x82
function trackleaderboarddeathstats( attacker, victim, weaponobj, smeansofdeath )
{
    if ( victim.var_e3b23da2a73823c5 == victim.lifeid )
    {
        return;
    }
    
    victim thread threadedsetweaponstatbyname( weaponobj, 1, "deaths", attacker, attacker );
    victim thread threadedsetweaponstatbyname( weaponobj, distancesquared( attacker.origin, victim.origin ), "cumulative_death_distance_sq", undefined, attacker );
}

// Namespace gamelogic_mp
// Params 4
// Checksum 0xb5d37afe, Offset: 0x1adf7
// Size: 0x163
function trackattackerleaderboarddeathstats( attacker, victim, weaponobj, smeansofdeath )
{
    if ( !isplayer( attacker ) )
    {
        return;
    }
    
    if ( !isdefined( smeansofdeath ) || smeansofdeath.size <= 0 )
    {
        assertmsg( "<dev string:xd14>" );
        return;
    }
    
    if ( !isdefined( weaponobj ) )
    {
        assertmsg( "<dev string:xd82>" );
        return;
    }
    
    if ( !isdefined( victim ) )
    {
        assertmsg( "<dev string:xdd9>" );
        return;
    }
    
    if ( !isdefined( attacker ) )
    {
        assertmsg( "<dev string:xe2d>" );
        return;
    }
    
    if ( smeansofdeath != "MOD_FALLING" && smeansofdeath != "MOD_BUMP" )
    {
        if ( attacker.modifiers[ "ads" ] )
        {
            attacker thread threadedsetweaponstatbyname( weaponobj, 1, "ads_kills", victim );
        }
        
        victim thread threadedsetweaponstatbyname( weaponobj, 1, "killed_by", undefined, attacker );
        
        if ( !attacker stat_limits::function_608486f90656f2f7( #"limitkills" ) )
        {
            attacker thread threadedsetweaponstatbyname( weaponobj, 1, "kills" );
            attacker thread threadedsetweaponstatbyname( weaponobj, distancesquared( attacker.origin, victim.origin ), "cumulative_kill_distance_sq" );
        }
    }
    
    if ( smeansofdeath == "MOD_HEAD_SHOT" )
    {
        if ( !attacker stat_limits::function_608486f90656f2f7( #"limitheadshots" ) )
        {
            attacker thread threadedsetweaponstatbyname( weaponobj, 1, "headShots", victim );
        }
    }
}

// Namespace gamelogic_mp
// Params 6
// Checksum 0xe7351bfc, Offset: 0x1af62
// Size: 0x943
function setweaponstat( objweapon, incvalue, statname, otherent, var_f0889f83354fbbc1, stattime )
{
    if ( !isweapon( objweapon ) )
    {
        assertmsg( "<dev string:xe83>" );
        return;
    }
    
    if ( !incvalue )
    {
        return;
    }
    
    if ( game[ "inLiveLobby" ] && getdvarint( @"hash_1b5abaf35dfdb4e4", 1 ) == 1 )
    {
        return;
    }
    
    weaponowner = var_f0889f83354fbbc1 ?? self;
    objweapon = weaponowner weapon_utility::function_8097c50c526bd683( objweapon );
    
    if ( !objweapon )
    {
        return;
    }
    
    weaponname = weapon::function_170e300815e9c1a2( objweapon );
    weapongroup = weapon::function_820c0dca2415bd8( objweapon );
    
    if ( !isdefined( stattime ) )
    {
        stattime = gettime();
    }
    
    var_1e16d16e6da8beb5 = supers_mp::shouldtracksuperweaponstats( objweapon );
    
    if ( weapongroup == "super" && !var_1e16d16e6da8beb5 )
    {
        return;
    }
    
    equipmenttype = weapon::getequipmenttype( objweapon );
    
    if ( var_1e16d16e6da8beb5 || equipmenttype == "lethal" || equipmenttype == "tactical" || equipmenttype == "super" )
    {
        telemetryname = telemetry_mp::function_730ff856cab87e50( objweapon );
        telemetry_data = { #stattime:stattime, #weaponobj:objweapon, #variantid:getweaponvariantindex( objweapon ), #statupdates:[ { #value:incvalue, #name:statname } ], #fullweaponname:getcompleteweaponname( objweapon ), #weaponname:telemetryname };
        telemetry_utils::function_af2d366f9522f76f( "callback_update_weapon_stats", telemetry_data );
        return;
    }
    
    switch ( weapongroup )
    {
        case #"hash_1cac65e1b8bf24a7":
            return;
        case #"hash_f4cd588fc5c3d2d5":
            if ( weaponname == "trophy_mp" || weaponname == "player_trophy_system_mp" || weaponname == "super_trophy_mp" )
            {
                break;
            }
            
            return;
    }
    
    if ( weapon::function_d991bdc544c7f2d0( objweapon ) )
    {
        return;
    }
    
    if ( weapongroup == "weapon_grenade" || weapongroup == "weapon_explosive" || weaponname == "trophy_mp" || weaponname == "forcepush_mp" )
    {
        weaponname = telemetry_mp::function_730ff856cab87e50( objweapon );
        persistence::incrementweaponstat( weaponname, statname, incvalue );
        telemetry_data = { #stattime:stattime, #weaponobj:objweapon, #variantid:getweaponvariantindex( objweapon ), #statupdates:[ { #value:incvalue, #name:statname } ], #fullweaponname:getcompleteweaponname( objweapon ), #weaponname:weaponname };
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
            if ( !isdefined( self.trackingweaponshots ) )
            {
                self.trackingweaponshots = 0;
            }
            
            self.trackingweaponshots += incvalue;
            break;
        case #"hash_7b99e54a94aa5fb":
            if ( !isdefined( self.trackingweaponhits ) )
            {
                self.trackingweaponhits = 0;
            }
            
            self.trackingweaponhits += incvalue;
            break;
        case #"hash_dae69d0191cb02b2":
            if ( !isdefined( self.var_77b59ab1404a0872 ) )
            {
                self.var_77b59ab1404a0872 = 0;
            }
            
            self.var_77b59ab1404a0872 += incvalue;
            break;
        case #"hash_f75b5b7a407db7e3":
            if ( !isdefined( self.var_38684cb7c7a05b60 ) )
            {
                self.var_38684cb7c7a05b60 = 0;
            }
            
            self.var_38684cb7c7a05b60 += incvalue;
            break;
        case #"hash_87751d453d03d993":
            if ( !isdefined( self.var_655c1270d315c9a8 ) )
            {
                self.var_655c1270d315c9a8 = 0;
            }
            
            self.var_655c1270d315c9a8 += incvalue;
            break;
        case #"hash_297da132d2f8bf70":
            if ( !isdefined( self.trackingweaponheadshots ) )
            {
                self.trackingweaponheadshots = 0;
            }
            
            self.trackingweaponheadshots += incvalue;
            
            if ( function_3cf5f3b66eae204( otherent ) )
            {
                if ( !isdefined( self.var_48bf7a228963280d ) )
                {
                    self.var_48bf7a228963280d = 0;
                }
                
                self.var_48bf7a228963280d += incvalue;
            }
            
            break;
        case #"hash_abcbd371534e7e1b":
            if ( !isdefined( self.var_8c892d21d6227ddb ) )
            {
                self.var_8c892d21d6227ddb = 0;
            }
            
            self.var_8c892d21d6227ddb += incvalue;
            break;
        case #"hash_14c0eea23e1cfd58":
            if ( !isdefined( self.var_48bf7a228963280d ) )
            {
                self.var_48bf7a228963280d = 0;
            }
            
            self.var_48bf7a228963280d += incvalue;
            break;
        case #"hash_f459561578093b3e":
            if ( !isdefined( self.trackingweaponkills ) )
            {
                self.trackingweaponkills = 0;
            }
            
            self.trackingweaponkills += incvalue;
            break;
        case #"hash_a377b3b24ceadd7b":
            if ( !isdefined( self.var_17c0a67973679fd8 ) )
            {
                self.var_17c0a67973679fd8 = 0;
            }
            
            if ( self.var_17c0a67973679fd8 < incvalue )
            {
                self.var_17c0a67973679fd8 = incvalue;
            }
            
            break;
        case #"hash_779aab8f25e1b0fc":
            if ( !isdefined( self.var_ed67e52e3be84bcb ) )
            {
                self.var_ed67e52e3be84bcb = 0;
            }
            
            self.var_ed67e52e3be84bcb += incvalue;
            break;
        case #"hash_c6aeb56e94904c0b":
            if ( !isdefined( self.var_97afcbecea9343e1 ) )
            {
                self.var_97afcbecea9343e1 = 0;
            }
            
            self.var_97afcbecea9343e1 += incvalue;
            break;
        case #"hash_59e2404294c76110":
            if ( !isdefined( self.var_1901feb9ec03fa48 ) )
            {
                self.var_1901feb9ec03fa48 = 0;
            }
            
            self.var_1901feb9ec03fa48 += incvalue;
            break;
        case #"hash_3048c056f67df635":
            if ( !isdefined( self.var_3d9c1e478d260918 ) )
            {
                self.var_3d9c1e478d260918 = 0;
            }
            
            self.var_3d9c1e478d260918 += incvalue;
            break;
        case #"hash_406d7407b0a31c77":
            if ( !isdefined( self.var_1f7d642d4c800754 ) )
            {
                self.var_1f7d642d4c800754 = 0;
            }
            
            self.var_1f7d642d4c800754 += incvalue;
            
            if ( function_3cf5f3b66eae204( otherent ) )
            {
                if ( !isdefined( self.var_892432a7fb907fad ) )
                {
                    self.var_892432a7fb907fad = 0;
                }
                
                self.var_892432a7fb907fad += incvalue;
            }
            
            break;
        case #"hash_9c5319f6e55cbcfc":
            if ( !isdefined( self.var_d6bcc84e968f49af ) )
            {
                self.var_d6bcc84e968f49af = 0;
            }
            
            self.var_d6bcc84e968f49af += incvalue;
            break;
        case #"hash_72d0fd0488636e3f":
            if ( !isdefined( self.var_892432a7fb907fad ) )
            {
                self.var_892432a7fb907fad = 0;
            }
            
            self.var_892432a7fb907fad += incvalue;
            break;
        case #"hash_88d1683fbcbbc7fa":
            if ( function_351c6af5e30ecb52( otherent ) )
            {
                if ( !isdefined( self.var_eb7aa67c9c73afa3 ) )
                {
                    self.var_eb7aa67c9c73afa3 = 0;
                }
                
                self.var_eb7aa67c9c73afa3 += incvalue;
            }
            else if ( function_3cf5f3b66eae204( otherent ) )
            {
                if ( !isdefined( self.var_2efef3452acc56d9 ) )
                {
                    self.var_2efef3452acc56d9 = 0;
                }
                
                self.var_2efef3452acc56d9 += incvalue;
            }
            
            break;
        case #"hash_1cc8a923a608c2a0":
            if ( !isdefined( self.var_fb38f1647fe83da2 ) )
            {
                self.var_fb38f1647fe83da2 = 0;
            }
            
            self.var_fb38f1647fe83da2 += incvalue;
            
            if ( function_351c6af5e30ecb52( otherent ) )
            {
                if ( !isdefined( self.var_1f24eff063aba231 ) )
                {
                    self.var_1f24eff063aba231 = 0;
                }
                
                self.var_1f24eff063aba231 += incvalue;
            }
            else if ( function_3cf5f3b66eae204( otherent ) )
            {
                if ( !isdefined( self.var_bf843bd07d4eb60f ) )
                {
                    self.var_bf843bd07d4eb60f = 0;
                }
                
                self.var_bf843bd07d4eb60f += incvalue;
            }
            
            break;
    }
    
    if ( statname == "deaths" )
    {
        /#
            if ( getdvarint( @"g_debugdamage" ) )
            {
                println( "<dev string:xedd>" );
            }
        #/
        
        if ( !weapon::iscacprimaryweapongroup( weapongroup ) && !weapon::iscacsecondaryweapongroup( weapongroup, objweapon ) )
        {
            return;
        }
        
        persistence::incrementweaponstat( weaponname, statname, incvalue );
        telemetry_data = { #stattime:stattime, #weaponobj:objweapon, #variantid:getweaponvariantindex( objweapon ), #statupdates:[ { #value:incvalue, #name:statname } ], #fullweaponname:getcompleteweaponname( objweapon ), #weaponname:weaponname };
        telemetry_utils::function_af2d366f9522f76f( "callback_update_weapon_stats", telemetry_data );
    }
}

// Namespace gamelogic_mp
// Params 3
// Checksum 0x3022e622, Offset: 0x1b8ad
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

// Namespace gamelogic_mp
// Params 5
// Checksum 0xda9b3477, Offset: 0x1b989
// Size: 0x112
function threadedsetweaponstatbyname( objweapon, incvalue, statname, otherent, var_f0889f83354fbbc1 )
{
    if ( level.gametypebundle.var_11c0145627e4a53 == #"hash_16a4c2b6f68453e0" )
    {
        if ( !isdefined( self.var_b09de8f470aea0a3 ) )
        {
            self.var_b09de8f470aea0a3 = [];
        }
        
        self.var_b09de8f470aea0a3[ self.var_b09de8f470aea0a3.size ] = { #stattime:gettime(), #var_f0889f83354fbbc1:var_f0889f83354fbbc1, #otherent:otherent, #statname:statname, #incvalue:incvalue, #objweapon:objweapon };
        
        if ( self.var_b09de8f470aea0a3.size >= 50 )
        {
            thread function_f3283484b2a18180( arraycopy( self.var_b09de8f470aea0a3 ) );
            self.var_b09de8f470aea0a3 = undefined;
            return;
        }
        
        thread function_9e80b0f7ec84b141();
        return;
    }
    
    self endon( #"disconnect" );
    waittillframeend();
    setweaponstat( objweapon, incvalue, statname, otherent, var_f0889f83354fbbc1 );
}

// Namespace gamelogic_mp
// Params 0
// Checksum 0x6e3c1c5d, Offset: 0x1baa3
// Size: 0x7b
function function_9e80b0f7ec84b141()
{
    self notify( #"hash_dcdcdb0836e99a74" );
    self endon( #"hash_dcdcdb0836e99a74" );
    self endon( #"disconnect" );
    
    do
    {
        waitframe();
        waittillframeend();
        var_5dea8c6374f5a67c = 0;
        
        if ( script::function_7cae34dfec48a6d1() )
        {
            var_881054c6b24926ed = function_8fc063681724727f();
            
            if ( level.var_28b0b95d6825011 == var_881054c6b24926ed || level.var_a97ce32d4d2a2f7a == var_881054c6b24926ed )
            {
                var_5dea8c6374f5a67c = 1;
            }
        }
    }
    while ( var_5dea8c6374f5a67c );
    
    function_28cc3d3131293c27();
}

// Namespace gamelogic_mp
// Params 0
// Checksum 0xf750d5c4, Offset: 0x1bb26
// Size: 0x104
function function_28cc3d3131293c27()
{
    profilestart();
    function_1d44f32bbd313a67( #"hash_3ae28d7f332a9cf", self.var_b09de8f470aea0a3.size ?? 0 );
    function_1d44f32bbd313a67( #"hash_e7fe899e243e81c3", self.entnum ?? utility::get_entity_number( self ) );
    
    foreach ( stat in self.var_b09de8f470aea0a3 )
    {
        setweaponstat( stat.objweapon, stat.incvalue, stat.statname, stat.otherent, stat.var_f0889f83354fbbc1, stat.stattime );
    }
    
    self.var_b09de8f470aea0a3 = undefined;
    profilestop();
}

// Namespace gamelogic_mp
// Params 1
// Checksum 0xf3c7baf2, Offset: 0x1bc32
// Size: 0x6f
function function_f3283484b2a18180( var_b09de8f470aea0a3 )
{
    self endon( #"disconnect" );
    
    do
    {
        waitframe();
        waittillframeend();
        var_5dea8c6374f5a67c = 0;
        
        if ( script::function_7cae34dfec48a6d1() )
        {
            var_881054c6b24926ed = function_8fc063681724727f();
            
            if ( level.var_28b0b95d6825011 == var_881054c6b24926ed || level.var_a97ce32d4d2a2f7a == var_881054c6b24926ed )
            {
                var_5dea8c6374f5a67c = 1;
            }
        }
    }
    while ( var_5dea8c6374f5a67c );
    
    function_ca86854a4f4d99c8( var_b09de8f470aea0a3 );
}

// Namespace gamelogic_mp
// Params 1
// Checksum 0x21368221, Offset: 0x1bca9
// Size: 0xf6
function function_ca86854a4f4d99c8( var_b09de8f470aea0a3 )
{
    profilestart();
    function_1d44f32bbd313a67( #"hash_aba2649a1d44f4c3", var_b09de8f470aea0a3.size ?? 0 );
    function_1d44f32bbd313a67( #"hash_e7fe899e243e81c3", self.entnum ?? utility::get_entity_number( self ) );
    
    foreach ( stat in var_b09de8f470aea0a3 )
    {
        setweaponstat( stat.objweapon, stat.incvalue, stat.statname, stat.otherent, stat.var_f0889f83354fbbc1, stat.stattime );
    }
    
    profilestop();
}

// Namespace gamelogic_mp
// Params 1
// Checksum 0xc464d5fb, Offset: 0x1bda7
// Size: 0x31
function function_fedabfd5bacce096( otherent )
{
    if ( !isdefined( otherent ) )
    {
        return 0;
    }
    
    if ( isagent( otherent ) )
    {
        return 2;
    }
    else if ( isplayer( otherent ) )
    {
        return 1;
    }
    
    return 0;
}

// Namespace gamelogic_mp
// Params 1
// Checksum 0xbbcfaee9, Offset: 0x1bde1
// Size: 0x25, Type: bool
function function_351c6af5e30ecb52( ent )
{
    type = function_fedabfd5bacce096( ent );
    return type == 2;
}

// Namespace gamelogic_mp
// Params 1
// Checksum 0x8bbcec39, Offset: 0x1be0f
// Size: 0x25, Type: bool
function function_3cf5f3b66eae204( ent )
{
    type = function_fedabfd5bacce096( ent );
    return type == 1;
}

// Namespace gamelogic_mp
// Params 0, eflags: 0x4
// Checksum 0xea8ea386, Offset: 0x1be3d
// Size: 0x27, Type: bool
function private function_58a3543a94ea5af6()
{
    return getdvarint( @"hash_612a84314e9af80", 0 ) && !isbrgamemode() && !level.istrainingcourse;
}

// Namespace gamelogic_mp
// Params 0
// Checksum 0xc3686e3, Offset: 0x1be6d
// Size: 0x9d
function updatespmstats()
{
    foreach ( player in level.players )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        if ( !isbrgamemode() || !player.disconnecting )
        {
            player function_93ec47a6ed4b516b();
        }
    }
}

// Namespace gamelogic_mp
// Params 0
// Checksum 0xb8863148, Offset: 0x1bf12
// Size: 0x294
function function_93ec47a6ed4b516b()
{
    player = self;
    
    if ( player game_utility_mp::onlinestatsenabled() || game_utility_mp::privatematch() )
    {
        spm = getmatchspm( player );
        actualscore = level.teambased ? player.score : player.pers[ "gamemodeScore" ];
        globalspm = player getplayerdata( level.var_6f9b00680ed002d8, "globalSPM" );
        gamesplayed = player playerstats_interface::getplayerstat( "matchStats", "gamesPlayed" );
        
        if ( isdefined( gamesplayed ) )
        {
            globalspm *= gamesplayed - 1;
        }
        
        var_aea20424b7be7257 = spm;
        
        if ( gamesplayed > 0 )
        {
            var_aea20424b7be7257 = ( globalspm + spm ) / gamesplayed;
        }
        
        player setplayerdata( level.var_6f9b00680ed002d8, "globalSPM", int( var_aea20424b7be7257 ) );
        gametypeindex = getgametypeindex( game_utility::getgametype() );
        maxgamemodescorehistory = 5;
        maxgamemodes = 64;
        
        if ( gametypeindex >= 0 && gametypeindex < maxgamemodes )
        {
            for ( i = 0; i < 4 ; i++ )
            {
                prev = player getplayerdata( level.var_6f9b00680ed002d8, "gameModeHistory", i + 1 );
                player setplayerdata( level.var_6f9b00680ed002d8, "gameModeHistory", i, prev );
            }
            
            player setplayerdata( level.var_6f9b00680ed002d8, "gameModeHistory", 4, game_utility_mp::getbasegametype() );
            scoreindex = player getplayerdata( level.var_6f9b00680ed002d8, "gameModeScoreHistory", gametypeindex, "index" );
            player setplayerdata( level.var_6f9b00680ed002d8, "gameModeScoreHistory", gametypeindex, "scores", scoreindex, int( spm ) );
            player setplayerdata( level.var_6f9b00680ed002d8, "gameModeScoreHistory", gametypeindex, "actualScores", scoreindex, int( actualscore ) );
            player setplayerdata( level.var_6f9b00680ed002d8, "gameModeScoreHistory", gametypeindex, "gameMode", game_utility_mp::getbasegametype() );
            scoreindex = ( scoreindex + 1 ) % maxgamemodescorehistory;
            player setplayerdata( level.var_6f9b00680ed002d8, "gameModeScoreHistory", gametypeindex, "index", scoreindex );
        }
        
        if ( function_58a3543a94ea5af6() )
        {
            var_459bfe88d10ca05e = allowleaderboardstatsupdates() ? function_d3ef7f0843f51d2a() : "unsupported";
            player setplayerdata( level.var_6f9b00680ed002d8, "playerStats", "lastPlayedGameType", var_459bfe88d10ca05e );
        }
    }
}

// Namespace gamelogic_mp
// Params 0
// Checksum 0x97a5946a, Offset: 0x1c1ae
// Size: 0x28f
function checkforpersonalbests()
{
    foreach ( player in level.players )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        if ( player game_utility_mp::onlinestatsenabled() )
        {
            roundkills = player getplayerdata( "common", "round", "kills" );
            rounddeaths = player getplayerdata( "common", "round", "deaths" );
            roundxp = player.pers[ "summary" ][ "xp" ];
            bestkills = player playerstats_interface::getplayerstat( "bestStats", "killsInAMatch" );
            mostdeaths = player playerstats_interface::getplayerstat( "bestStats", "deathsInAMatch" );
            mostxp = player playerstats_interface::getplayerstat( "bestStats", "xpInAMatch" );
            bestspm = player getplayerdata( level.var_6f9b00680ed002d8, "bestSPM", "score" );
            bestkd = player getplayerdata( level.var_6f9b00680ed002d8, "bestKD", "score" );
            
            if ( roundkills > bestkills )
            {
                player playerstats_interface::setplayerstat( roundkills, "bestStats", "killsInAMatch" );
            }
            
            if ( roundxp > mostxp )
            {
                player playerstats_interface::setplayerstat( roundxp, "bestStats", "xpInAMatch" );
            }
            
            if ( rounddeaths > mostdeaths )
            {
                player playerstats_interface::setplayerstat( rounddeaths, "bestStats", "deathsInAMatch" );
            }
            
            kd = roundkills;
            
            if ( rounddeaths > 1 )
            {
                kd /= rounddeaths;
            }
            
            kd = int( kd * 1000 );
            
            if ( kd > bestkd )
            {
                player setplayerdata( level.var_6f9b00680ed002d8, "bestKD", "score", kd );
                player setplayerdata( level.var_6f9b00680ed002d8, "bestKD", "time", getsystemtime() );
            }
            
            spm = getmatchspm( player );
            
            if ( spm > bestspm )
            {
                player setplayerdata( level.var_6f9b00680ed002d8, "bestSPM", "score", int( spm ) );
                player setplayerdata( level.var_6f9b00680ed002d8, "bestSPM", "time", getsystemtime() );
            }
        }
    }
}

// Namespace gamelogic_mp
// Params 0
// Checksum 0xc6a9ec33, Offset: 0x1c445
// Size: 0x15, Type: bool
function allowleaderboardstatsupdates()
{
    return level.onlinestatsenabled && isleaderboardsupportedmode();
}

// Namespace gamelogic_mp
// Params 0
// Checksum 0x1204e286, Offset: 0x1c463
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

// Namespace gamelogic_mp
// Params 1
// Checksum 0x3f091b54, Offset: 0x1c517
// Size: 0x9d
function updateleaderboardstats( players )
{
    if ( !allowleaderboardstatsupdates() )
    {
        return;
    }
    
    foreach ( player in players )
    {
        if ( !isdefined( player ) || isai( player ) )
        {
            continue;
        }
        
        player updateplayerleaderboardstatsinternal();
    }
}

// Namespace gamelogic_mp
// Params 0
// Checksum 0x5821873c, Offset: 0x1c5bc
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

// Namespace gamelogic_mp
// Params 0
// Checksum 0x55b2907b, Offset: 0x1c5e8
// Size: 0xc6
function function_d3ef7f0843f51d2a()
{
    if ( level.isFaceOffMode )
    {
        modestring = level.gametypebundle.namekey;
    }
    else if ( game_utility::function_ae97372c83da7acc() )
    {
        modestring = "hc_" + game_utility::getgametype();
    }
    else
    {
        modestring = game_utility::getgametype();
    }
    
    var_468e48be55e13ca5 = game_utility::function_ae97372c83da7acc() || level.isFaceOffMode || level.gametypebundle.var_468e48be55e13ca5;
    
    if ( function_58a3543a94ea5af6() && var_468e48be55e13ca5 && modestring != level.gametypebundle.namekey )
    {
        modestring = level.gametypebundle.namekey;
    }
    
    return modestring;
}

// Namespace gamelogic_mp
// Params 0
// Checksum 0x3874e3e2, Offset: 0x1c6b7
// Size: 0x292, Type: bool
function isleaderboardsupportedmode()
{
    if ( isbrgamemode() )
    {
        return true;
    }
    
    modestring = function_d3ef7f0843f51d2a();
    
    switch ( modestring )
    {
        case #"hash_3e42b59314efb6d":
        case #"hash_7e89154a96f625d":
        case #"hash_ca6516c10db2c95":
        case #"hash_1a5d186c17c00d3c":
        case #"hash_1aac086c17fe5ccb":
        case #"hash_1b1eecd3863a50cf":
        case #"hash_1e3194fd705af366":
        case #"hash_2297324c970a219c":
        case #"hash_22cc394c97337aa8":
        case #"hash_2873897e24561329":
        case #"hash_2946b34dbd2b86c6":
        case #"hash_4e47eb6c32f5b165":
        case #"hash_53825b446469ac4c":
        case #"hash_566231b2d32896cb":
        case #"hash_5ff8e011d5b9d1c8":
        case #"hash_61ac7a98039e2d86":
        case #"hash_6ba8ca4fdff59c99":
        case #"hash_6efb0f59a62300fb":
        case #"hash_7485fa6c474ec865":
        case #"hash_78ebb3b7ce8f864f":
        case #"hash_7c11ceb253d4cc3c":
        case #"hash_7e2c0391c4f7bf7d":
        case #"hash_7f9c384a34cc392f":
        case #"hash_9424bbb71eb7d064":
        case #"hash_9b7597ae8b9b3555":
        case #"hash_a93dacd349d98a99":
        case #"hash_aac44b0b52bacb8e":
        case #"hash_aada280b52cbdd96":
        case #"hash_ab00240b52e9ec5e":
        case #"hash_ac1b1563dfa2e485":
        case #"hash_b9458959b10637f8":
        case #"hash_c153fdd356f522e1":
        case #"hash_d4d6f491f1c704bf":
        case #"hash_dc6f4bf9685bd592":
        case #"hash_dd5b900f435d3f36":
        case #"hash_dede5b91f7b860c3":
        case #"hash_defd23d9056cfb17":
        case #"hash_ea061d29bbd1f237":
        case #"hash_eb5e5f470e0c1dc2":
        case #"hash_ec24570718a340f5":
        case #"hash_ec72fd25bbbac99e":
        case #"hash_f4a9126c03d3385b":
        case #"hash_f55ec3d372444a79":
        case #"hash_fa0ed2f6bd4f4395":
        case #"hash_fa0ed9f6bd4f4e9a":
        case #"hash_fa2ae2f6bd652314":
        case #"hash_fa34c5f6bd6d4432":
        case #"hash_fa50b0f6bd82e972":
        case #"hash_fa7b69e7b63430d3":
        case #"hash_fb5b5e6c07253005":
            return true;
        default:
            return false;
    }
    
    return false;
}

// Namespace gamelogic_mp
// Params 0
// Checksum 0xa42ec8ee, Offset: 0x1c952
// Size: 0x14, Type: bool
function function_a054d2386f2ced38()
{
    return getdvarint( @"hash_352e55529cbf4dae", 1 ) == 1;
}

// Namespace gamelogic_mp
// Params 0
// Checksum 0xc9249e93, Offset: 0x1c96f
// Size: 0x20
function function_c8f5736e0ad9354b()
{
    while ( isdefined( self.c130 ) )
    {
        waitframe();
    }
    
    self waittill( #"parachute_complete" );
}

// Namespace gamelogic_mp
// Params 1
// Checksum 0xffda6779, Offset: 0x1c997
// Size: 0x60, Type: bool
function function_8f165bf1d7e138c4( revivespawn )
{
    shouldgiveloadout = utility::callsharedfunc( #"game", #"hash_3ef49aa390bb5bdf" );
    
    if ( isdefined( shouldgiveloadout ) && !shouldgiveloadout )
    {
        return false;
    }
    
    if ( revivespawn && !level.gametypebundle.var_18ec1daf4ddeb508 )
    {
        return false;
    }
    
    return true;
}

// Namespace gamelogic_mp
// Params 0
// Checksum 0x71475eea, Offset: 0x1ca00
// Size: 0x41, Type: bool
function function_323a8653c264b72f()
{
    if ( !isbrgamemode() )
    {
        return false;
    }
    
    if ( !isbot( self ) )
    {
        return false;
    }
    
    if ( level.skipprematchdropspawn )
    {
        return false;
    }
    
    if ( level.parachuterestoreweaponscb == &br::nakeddrop )
    {
        return !inprematch();
    }
    
    return true;
}

// Namespace gamelogic_mp
// Params 3
// Checksum 0xe529b903, Offset: 0x1ca4a
// Size: 0x126
function incrementleaderboardstat( stat, modestring, matchvalue = 0 )
{
    if ( !isdefined( self.leaderboardstartvalues ) )
    {
        self.leaderboardstartvalues = [];
    }
    
    if ( !isdefined( self.var_2761215ec87fba6a ) )
    {
        self.var_2761215ec87fba6a = [];
    }
    
    if ( !( self.var_2761215ec87fba6a[ stat ] === matchvalue ) )
    {
        if ( function_58a3543a94ea5af6() )
        {
            leaderboardvalue = 0;
        }
        else
        {
            leaderboardvalue = self getplayerdata( level.var_6f9b00680ed002d8, #"playerstats", #"modestats", modestring, stat );
        }
        
        if ( !isdefined( self.leaderboardstartvalues[ stat ] ) )
        {
            self.leaderboardstartvalues[ stat ] = leaderboardvalue;
        }
        
        var_b3ffdbbcdd658a1b = self.leaderboardstartvalues[ stat ];
        
        if ( matchvalue > 0 )
        {
            if ( function_58a3543a94ea5af6() )
            {
                var_b3ffdbbcdd658a1b = matchvalue;
            }
            else
            {
                var_b3ffdbbcdd658a1b += matchvalue;
            }
        }
        
        self setplayerdata( level.var_6f9b00680ed002d8, #"playerstats", #"modestats", modestring, stat, var_b3ffdbbcdd658a1b );
        self.var_2761215ec87fba6a[ stat ] = matchvalue;
    }
}

// Namespace gamelogic_mp
// Params 0
// Checksum 0xe554617, Offset: 0x1cb78
// Size: 0x1e7a
function updateplayerleaderboardstatsinternal()
{
    modestring = function_d3ef7f0843f51d2a();
    
    if ( isbrgamemode() )
    {
        switch ( game_utility::getgametype() )
        {
            case #"hash_59b8e9d05b31ff9":
            case #"hash_16dd223e5a8b22c8":
            case #"hash_343d3f3f77c83350":
            case #"hash_5e0a8ff36bce5106":
            case #"hash_7e740e691d49b6c0":
            case #"hash_bfabc434c59611fa":
            case #"":
            case #"hash_dddecc2751311914":
            case #"hash_de72a7b26718020e":
            case #"hash_f4afff6c03d92aa0":
            case #"hash_fa21c4f6bd5e3815":
                break;
            case #"hash_3c1c1566d7b3b870":
                break;
            default:
                return;
        }
    }
    
    if ( !isdefined( self.leaderboardstartvalues ) )
    {
        self.leaderboardstartvalues = [];
    }
    
    if ( !isdefined( self.var_2761215ec87fba6a ) )
    {
        self.var_2761215ec87fba6a = [];
    }
    
    if ( !( self.var_2761215ec87fba6a[ "gamesPlayed" ] === self.leaderboarddata[ "gamesPlayed" ] ) )
    {
        if ( function_58a3543a94ea5af6() )
        {
            leaderboardvalue = 0;
        }
        else
        {
            leaderboardvalue = self getplayerdata( level.var_6f9b00680ed002d8, #"playerstats", #"modestats", modestring, "gamesPlayed" );
        }
        
        if ( !isdefined( self.leaderboardstartvalues[ "gamesPlayed" ] ) )
        {
            self.leaderboardstartvalues[ "gamesPlayed" ] = leaderboardvalue;
        }
        
        var_b3ffdbbcdd658a1b = self.leaderboardstartvalues[ "gamesPlayed" ];
        
        if ( self.leaderboarddata[ "gamesPlayed" ] > 0 )
        {
            if ( function_58a3543a94ea5af6() )
            {
                var_b3ffdbbcdd658a1b = self.leaderboarddata[ "gamesPlayed" ];
            }
            else
            {
                var_b3ffdbbcdd658a1b += self.leaderboarddata[ "gamesPlayed" ];
            }
        }
        
        self setplayerdata( level.var_6f9b00680ed002d8, #"playerstats", #"modestats", modestring, "gamesPlayed", var_b3ffdbbcdd658a1b );
        self.var_2761215ec87fba6a[ "gamesPlayed" ] = self.leaderboarddata[ "gamesPlayed" ];
    }
    
    if ( !( self.var_2761215ec87fba6a[ "wins" ] === self.leaderboarddata[ "wins" ] ) )
    {
        if ( function_58a3543a94ea5af6() )
        {
            leaderboardvalue = 0;
        }
        else
        {
            leaderboardvalue = self getplayerdata( level.var_6f9b00680ed002d8, #"playerstats", #"modestats", modestring, "wins" );
        }
        
        if ( !isdefined( self.leaderboardstartvalues[ "wins" ] ) )
        {
            self.leaderboardstartvalues[ "wins" ] = leaderboardvalue;
        }
        
        var_b3ffdbbcdd658a1b = self.leaderboardstartvalues[ "wins" ];
        
        if ( self.leaderboarddata[ "wins" ] > 0 )
        {
            if ( function_58a3543a94ea5af6() )
            {
                var_b3ffdbbcdd658a1b = self.leaderboarddata[ "wins" ];
            }
            else
            {
                var_b3ffdbbcdd658a1b += self.leaderboarddata[ "wins" ];
            }
        }
        
        self setplayerdata( level.var_6f9b00680ed002d8, #"playerstats", #"modestats", modestring, "wins", var_b3ffdbbcdd658a1b );
        self.var_2761215ec87fba6a[ "wins" ] = self.leaderboarddata[ "wins" ];
    }
    
    if ( function_58a3543a94ea5af6() )
    {
        if ( !( self.var_2761215ec87fba6a[ "losses" ] === self.leaderboarddata[ "losses" ] ) )
        {
            if ( function_58a3543a94ea5af6() )
            {
                leaderboardvalue = 0;
            }
            else
            {
                leaderboardvalue = self getplayerdata( level.var_6f9b00680ed002d8, #"playerstats", #"modestats", modestring, "losses" );
            }
            
            if ( !isdefined( self.leaderboardstartvalues[ "losses" ] ) )
            {
                self.leaderboardstartvalues[ "losses" ] = leaderboardvalue;
            }
            
            var_b3ffdbbcdd658a1b = self.leaderboardstartvalues[ "losses" ];
            
            if ( self.leaderboarddata[ "losses" ] > 0 )
            {
                if ( function_58a3543a94ea5af6() )
                {
                    var_b3ffdbbcdd658a1b = self.leaderboarddata[ "losses" ];
                }
                else
                {
                    var_b3ffdbbcdd658a1b += self.leaderboarddata[ "losses" ];
                }
            }
            
            self setplayerdata( level.var_6f9b00680ed002d8, #"playerstats", #"modestats", modestring, "losses", var_b3ffdbbcdd658a1b );
            self.var_2761215ec87fba6a[ "losses" ] = self.leaderboarddata[ "losses" ];
        }
    }
    
    modescore = level.teambased ? self.score : self.leaderboarddata[ "gamemodeScore" ];
    
    if ( !( self.var_2761215ec87fba6a[ "score" ] === modescore ) )
    {
        if ( function_58a3543a94ea5af6() )
        {
            leaderboardvalue = 0;
        }
        else
        {
            leaderboardvalue = self getplayerdata( level.var_6f9b00680ed002d8, #"playerstats", #"modestats", modestring, "score" );
        }
        
        if ( !isdefined( self.leaderboardstartvalues[ "score" ] ) )
        {
            self.leaderboardstartvalues[ "score" ] = leaderboardvalue;
        }
        
        var_b3ffdbbcdd658a1b = self.leaderboardstartvalues[ "score" ];
        
        if ( modescore > 0 )
        {
            if ( function_58a3543a94ea5af6() )
            {
                var_b3ffdbbcdd658a1b = modescore;
            }
            else
            {
                var_b3ffdbbcdd658a1b += modescore;
            }
        }
        
        self setplayerdata( level.var_6f9b00680ed002d8, #"playerstats", #"modestats", modestring, "score", var_b3ffdbbcdd658a1b );
        self.var_2761215ec87fba6a[ "score" ] = modescore;
    }
    
    timeplayed = persistence::statgetchildbuffered( "round", "timePlayed", 0 );
    
    if ( !( self.var_2761215ec87fba6a[ "timePlayed" ] === timeplayed ) )
    {
        if ( function_58a3543a94ea5af6() )
        {
            leaderboardvalue = 0;
        }
        else
        {
            leaderboardvalue = self getplayerdata( level.var_6f9b00680ed002d8, #"playerstats", #"modestats", modestring, "timePlayed" );
        }
        
        if ( !isdefined( self.leaderboardstartvalues[ "timePlayed" ] ) )
        {
            self.leaderboardstartvalues[ "timePlayed" ] = leaderboardvalue;
        }
        
        var_b3ffdbbcdd658a1b = self.leaderboardstartvalues[ "timePlayed" ];
        
        if ( timeplayed > 0 )
        {
            if ( function_58a3543a94ea5af6() )
            {
                var_b3ffdbbcdd658a1b = timeplayed;
            }
            else
            {
                var_b3ffdbbcdd658a1b += timeplayed;
            }
        }
        
        self setplayerdata( level.var_6f9b00680ed002d8, #"playerstats", #"modestats", modestring, "timePlayed", var_b3ffdbbcdd658a1b );
        self.var_2761215ec87fba6a[ "timePlayed" ] = timeplayed;
    }
    
    if ( !( self.var_2761215ec87fba6a[ "kills" ] === self.leaderboarddata[ "kills" ] ) )
    {
        if ( function_58a3543a94ea5af6() )
        {
            leaderboardvalue = 0;
        }
        else
        {
            leaderboardvalue = self getplayerdata( level.var_6f9b00680ed002d8, #"playerstats", #"modestats", modestring, "kills" );
        }
        
        if ( !isdefined( self.leaderboardstartvalues[ "kills" ] ) )
        {
            self.leaderboardstartvalues[ "kills" ] = leaderboardvalue;
        }
        
        var_b3ffdbbcdd658a1b = self.leaderboardstartvalues[ "kills" ];
        
        if ( self.leaderboarddata[ "kills" ] > 0 )
        {
            if ( function_58a3543a94ea5af6() )
            {
                var_b3ffdbbcdd658a1b = self.leaderboarddata[ "kills" ];
            }
            else
            {
                var_b3ffdbbcdd658a1b += self.leaderboarddata[ "kills" ];
            }
        }
        
        self setplayerdata( level.var_6f9b00680ed002d8, #"playerstats", #"modestats", modestring, "kills", var_b3ffdbbcdd658a1b );
        self.var_2761215ec87fba6a[ "kills" ] = self.leaderboarddata[ "kills" ];
    }
    
    if ( !( self.var_2761215ec87fba6a[ "deaths" ] === self.leaderboarddata[ "deaths" ] ) )
    {
        if ( function_58a3543a94ea5af6() )
        {
            leaderboardvalue = 0;
        }
        else
        {
            leaderboardvalue = self getplayerdata( level.var_6f9b00680ed002d8, #"playerstats", #"modestats", modestring, "deaths" );
        }
        
        if ( !isdefined( self.leaderboardstartvalues[ "deaths" ] ) )
        {
            self.leaderboardstartvalues[ "deaths" ] = leaderboardvalue;
        }
        
        var_b3ffdbbcdd658a1b = self.leaderboardstartvalues[ "deaths" ];
        
        if ( self.leaderboarddata[ "deaths" ] > 0 )
        {
            if ( function_58a3543a94ea5af6() )
            {
                var_b3ffdbbcdd658a1b = self.leaderboarddata[ "deaths" ];
            }
            else
            {
                var_b3ffdbbcdd658a1b += self.leaderboarddata[ "deaths" ];
            }
        }
        
        self setplayerdata( level.var_6f9b00680ed002d8, #"playerstats", #"modestats", modestring, "deaths", var_b3ffdbbcdd658a1b );
        self.var_2761215ec87fba6a[ "deaths" ] = self.leaderboarddata[ "deaths" ];
    }
    
    if ( isbrgamemode() )
    {
        if ( !( self.var_2761215ec87fba6a[ "downs" ] === self.leaderboarddata[ "downs" ] ) )
        {
            if ( function_58a3543a94ea5af6() )
            {
                leaderboardvalue = 0;
            }
            else
            {
                leaderboardvalue = self getplayerdata( level.var_6f9b00680ed002d8, #"playerstats", #"modestats", modestring, "downs" );
            }
            
            if ( !isdefined( self.leaderboardstartvalues[ "downs" ] ) )
            {
                self.leaderboardstartvalues[ "downs" ] = leaderboardvalue;
            }
            
            var_b3ffdbbcdd658a1b = self.leaderboardstartvalues[ "downs" ];
            
            if ( self.leaderboarddata[ "downs" ] > 0 )
            {
                if ( function_58a3543a94ea5af6() )
                {
                    var_b3ffdbbcdd658a1b = self.leaderboarddata[ "downs" ];
                }
                else
                {
                    var_b3ffdbbcdd658a1b += self.leaderboarddata[ "downs" ];
                }
            }
            
            self setplayerdata( level.var_6f9b00680ed002d8, #"playerstats", #"modestats", modestring, "downs", var_b3ffdbbcdd658a1b );
            self.var_2761215ec87fba6a[ "downs" ] = self.leaderboarddata[ "downs" ];
        }
        
        if ( !( self.var_2761215ec87fba6a[ "contracts" ] === self.leaderboarddata[ "contracts" ] ) )
        {
            if ( function_58a3543a94ea5af6() )
            {
                leaderboardvalue = 0;
            }
            else
            {
                leaderboardvalue = self getplayerdata( level.var_6f9b00680ed002d8, #"playerstats", #"modestats", modestring, "contracts" );
            }
            
            if ( !isdefined( self.leaderboardstartvalues[ "contracts" ] ) )
            {
                self.leaderboardstartvalues[ "contracts" ] = leaderboardvalue;
            }
            
            var_b3ffdbbcdd658a1b = self.leaderboardstartvalues[ "contracts" ];
            
            if ( self.leaderboarddata[ "contracts" ] > 0 )
            {
                if ( function_58a3543a94ea5af6() )
                {
                    var_b3ffdbbcdd658a1b = self.leaderboarddata[ "contracts" ];
                }
                else
                {
                    var_b3ffdbbcdd658a1b += self.leaderboarddata[ "contracts" ];
                }
            }
            
            self setplayerdata( level.var_6f9b00680ed002d8, #"playerstats", #"modestats", modestring, "contracts", var_b3ffdbbcdd658a1b );
            self.var_2761215ec87fba6a[ "contracts" ] = self.leaderboarddata[ "contracts" ];
        }
        
        if ( !( self.var_2761215ec87fba6a[ "topFive" ] === self.leaderboarddata[ "topFive" ] ) )
        {
            if ( function_58a3543a94ea5af6() )
            {
                leaderboardvalue = 0;
            }
            else
            {
                leaderboardvalue = self getplayerdata( level.var_6f9b00680ed002d8, #"playerstats", #"modestats", modestring, "topFive" );
            }
            
            if ( !isdefined( self.leaderboardstartvalues[ "topFive" ] ) )
            {
                self.leaderboardstartvalues[ "topFive" ] = leaderboardvalue;
            }
            
            var_b3ffdbbcdd658a1b = self.leaderboardstartvalues[ "topFive" ];
            
            if ( self.leaderboarddata[ "topFive" ] > 0 )
            {
                if ( function_58a3543a94ea5af6() )
                {
                    var_b3ffdbbcdd658a1b = self.leaderboarddata[ "topFive" ];
                }
                else
                {
                    var_b3ffdbbcdd658a1b += self.leaderboarddata[ "topFive" ];
                }
            }
            
            self setplayerdata( level.var_6f9b00680ed002d8, #"playerstats", #"modestats", modestring, "topFive", var_b3ffdbbcdd658a1b );
            self.var_2761215ec87fba6a[ "topFive" ] = self.leaderboarddata[ "topFive" ];
        }
        
        if ( !( self.var_2761215ec87fba6a[ "topTen" ] === self.leaderboarddata[ "topTen" ] ) )
        {
            if ( function_58a3543a94ea5af6() )
            {
                leaderboardvalue = 0;
            }
            else
            {
                leaderboardvalue = self getplayerdata( level.var_6f9b00680ed002d8, #"playerstats", #"modestats", modestring, "topTen" );
            }
            
            if ( !isdefined( self.leaderboardstartvalues[ "topTen" ] ) )
            {
                self.leaderboardstartvalues[ "topTen" ] = leaderboardvalue;
            }
            
            var_b3ffdbbcdd658a1b = self.leaderboardstartvalues[ "topTen" ];
            
            if ( self.leaderboarddata[ "topTen" ] > 0 )
            {
                if ( function_58a3543a94ea5af6() )
                {
                    var_b3ffdbbcdd658a1b = self.leaderboarddata[ "topTen" ];
                }
                else
                {
                    var_b3ffdbbcdd658a1b += self.leaderboarddata[ "topTen" ];
                }
            }
            
            self setplayerdata( level.var_6f9b00680ed002d8, #"playerstats", #"modestats", modestring, "topTen", var_b3ffdbbcdd658a1b );
            self.var_2761215ec87fba6a[ "topTen" ] = self.leaderboarddata[ "topTen" ];
        }
        
        if ( !( self.var_2761215ec87fba6a[ "topTwentyFive" ] === self.leaderboarddata[ "topTwentyFive" ] ) )
        {
            if ( function_58a3543a94ea5af6() )
            {
                leaderboardvalue = 0;
            }
            else
            {
                leaderboardvalue = self getplayerdata( level.var_6f9b00680ed002d8, #"playerstats", #"modestats", modestring, "topTwentyFive" );
            }
            
            if ( !isdefined( self.leaderboardstartvalues[ "topTwentyFive" ] ) )
            {
                self.leaderboardstartvalues[ "topTwentyFive" ] = leaderboardvalue;
            }
            
            var_b3ffdbbcdd658a1b = self.leaderboardstartvalues[ "topTwentyFive" ];
            
            if ( self.leaderboarddata[ "topTwentyFive" ] > 0 )
            {
                if ( function_58a3543a94ea5af6() )
                {
                    var_b3ffdbbcdd658a1b = self.leaderboarddata[ "topTwentyFive" ];
                }
                else
                {
                    var_b3ffdbbcdd658a1b += self.leaderboarddata[ "topTwentyFive" ];
                }
            }
            
            self setplayerdata( level.var_6f9b00680ed002d8, #"playerstats", #"modestats", modestring, "topTwentyFive", var_b3ffdbbcdd658a1b );
            self.var_2761215ec87fba6a[ "topTwentyFive" ] = self.leaderboarddata[ "topTwentyFive" ];
        }
        
        if ( !( self.var_2761215ec87fba6a[ "revives" ] === self.leaderboarddata[ "rescues" ] ) )
        {
            if ( function_58a3543a94ea5af6() )
            {
                leaderboardvalue = 0;
            }
            else
            {
                leaderboardvalue = self getplayerdata( level.var_6f9b00680ed002d8, #"playerstats", #"modestats", modestring, "revives" );
            }
            
            if ( !isdefined( self.leaderboardstartvalues[ "revives" ] ) )
            {
                self.leaderboardstartvalues[ "revives" ] = leaderboardvalue;
            }
            
            var_b3ffdbbcdd658a1b = self.leaderboardstartvalues[ "revives" ];
            
            if ( self.leaderboarddata[ "rescues" ] > 0 )
            {
                if ( function_58a3543a94ea5af6() )
                {
                    var_b3ffdbbcdd658a1b = self.leaderboarddata[ "rescues" ];
                }
                else
                {
                    var_b3ffdbbcdd658a1b += self.leaderboarddata[ "rescues" ];
                }
            }
            
            self setplayerdata( level.var_6f9b00680ed002d8, #"playerstats", #"modestats", modestring, "revives", var_b3ffdbbcdd658a1b );
            self.var_2761215ec87fba6a[ "revives" ] = self.leaderboarddata[ "rescues" ];
        }
        
        if ( !( self.var_2761215ec87fba6a[ "cash" ] === self.leaderboarddata[ "cash" ] ) )
        {
            if ( function_58a3543a94ea5af6() )
            {
                leaderboardvalue = 0;
            }
            else
            {
                leaderboardvalue = self getplayerdata( level.var_6f9b00680ed002d8, #"playerstats", #"modestats", modestring, "cash" );
            }
            
            if ( !isdefined( self.leaderboardstartvalues[ "cash" ] ) )
            {
                self.leaderboardstartvalues[ "cash" ] = leaderboardvalue;
            }
            
            var_b3ffdbbcdd658a1b = self.leaderboardstartvalues[ "cash" ];
            
            if ( self.leaderboarddata[ "cash" ] > 0 )
            {
                if ( function_58a3543a94ea5af6() )
                {
                    var_b3ffdbbcdd658a1b = self.leaderboarddata[ "cash" ];
                }
                else
                {
                    var_b3ffdbbcdd658a1b += self.leaderboarddata[ "cash" ];
                }
            }
            
            self setplayerdata( level.var_6f9b00680ed002d8, #"playerstats", #"modestats", modestring, "cash", var_b3ffdbbcdd658a1b );
            self.var_2761215ec87fba6a[ "cash" ] = self.leaderboarddata[ "cash" ];
        }
        
        if ( !( self.var_2761215ec87fba6a[ "eliteStarted" ] === self.leaderboarddata[ "eliteStarted" ] ) )
        {
            if ( function_58a3543a94ea5af6() )
            {
                leaderboardvalue = 0;
            }
            else
            {
                leaderboardvalue = self getplayerdata( level.var_6f9b00680ed002d8, #"playerstats", #"modestats", modestring, "eliteStarted" );
            }
            
            if ( !isdefined( self.leaderboardstartvalues[ "eliteStarted" ] ) )
            {
                self.leaderboardstartvalues[ "eliteStarted" ] = leaderboardvalue;
            }
            
            var_b3ffdbbcdd658a1b = self.leaderboardstartvalues[ "eliteStarted" ];
            
            if ( self.leaderboarddata[ "eliteStarted" ] > 0 )
            {
                if ( function_58a3543a94ea5af6() )
                {
                    var_b3ffdbbcdd658a1b = self.leaderboarddata[ "eliteStarted" ];
                }
                else
                {
                    var_b3ffdbbcdd658a1b += self.leaderboarddata[ "eliteStarted" ];
                }
            }
            
            self setplayerdata( level.var_6f9b00680ed002d8, #"playerstats", #"modestats", modestring, "eliteStarted", var_b3ffdbbcdd658a1b );
            self.var_2761215ec87fba6a[ "eliteStarted" ] = self.leaderboarddata[ "eliteStarted" ];
        }
        
        if ( !( self.var_2761215ec87fba6a[ "eliteCompleted" ] === self.leaderboarddata[ "eliteCompleted" ] ) )
        {
            if ( function_58a3543a94ea5af6() )
            {
                leaderboardvalue = 0;
            }
            else
            {
                leaderboardvalue = self getplayerdata( level.var_6f9b00680ed002d8, #"playerstats", #"modestats", modestring, "eliteCompleted" );
            }
            
            if ( !isdefined( self.leaderboardstartvalues[ "eliteCompleted" ] ) )
            {
                self.leaderboardstartvalues[ "eliteCompleted" ] = leaderboardvalue;
            }
            
            var_b3ffdbbcdd658a1b = self.leaderboardstartvalues[ "eliteCompleted" ];
            
            if ( self.leaderboarddata[ "eliteCompleted" ] > 0 )
            {
                if ( function_58a3543a94ea5af6() )
                {
                    var_b3ffdbbcdd658a1b = self.leaderboarddata[ "eliteCompleted" ];
                }
                else
                {
                    var_b3ffdbbcdd658a1b += self.leaderboarddata[ "eliteCompleted" ];
                }
            }
            
            self setplayerdata( level.var_6f9b00680ed002d8, #"playerstats", #"modestats", modestring, "eliteCompleted", var_b3ffdbbcdd658a1b );
            self.var_2761215ec87fba6a[ "eliteCompleted" ] = self.leaderboarddata[ "eliteCompleted" ];
        }
        
        if ( !( self.var_2761215ec87fba6a[ "eliteBlocked" ] === self.leaderboarddata[ "eliteBlocked" ] ) )
        {
            if ( function_58a3543a94ea5af6() )
            {
                leaderboardvalue = 0;
            }
            else
            {
                leaderboardvalue = self getplayerdata( level.var_6f9b00680ed002d8, #"playerstats", #"modestats", modestring, "eliteBlocked" );
            }
            
            if ( !isdefined( self.leaderboardstartvalues[ "eliteBlocked" ] ) )
            {
                self.leaderboardstartvalues[ "eliteBlocked" ] = leaderboardvalue;
            }
            
            var_b3ffdbbcdd658a1b = self.leaderboardstartvalues[ "eliteBlocked" ];
            
            if ( self.leaderboarddata[ "eliteBlocked" ] > 0 )
            {
                if ( function_58a3543a94ea5af6() )
                {
                    var_b3ffdbbcdd658a1b = self.leaderboarddata[ "eliteBlocked" ];
                }
                else
                {
                    var_b3ffdbbcdd658a1b += self.leaderboarddata[ "eliteBlocked" ];
                }
            }
            
            self setplayerdata( level.var_6f9b00680ed002d8, #"playerstats", #"modestats", modestring, "eliteBlocked", var_b3ffdbbcdd658a1b );
            self.var_2761215ec87fba6a[ "eliteBlocked" ] = self.leaderboarddata[ "eliteBlocked" ];
        }
        
        if ( !( self.var_2761215ec87fba6a[ "secondaryVictories" ] === self.leaderboarddata[ "secondaryVictories" ] ) )
        {
            if ( function_58a3543a94ea5af6() )
            {
                leaderboardvalue = 0;
            }
            else
            {
                leaderboardvalue = self getplayerdata( level.var_6f9b00680ed002d8, #"playerstats", #"modestats", modestring, "secondaryVictories" );
            }
            
            if ( !isdefined( self.leaderboardstartvalues[ "secondaryVictories" ] ) )
            {
                self.leaderboardstartvalues[ "secondaryVictories" ] = leaderboardvalue;
            }
            
            var_b3ffdbbcdd658a1b = self.leaderboardstartvalues[ "secondaryVictories" ];
            
            if ( self.leaderboarddata[ "secondaryVictories" ] > 0 )
            {
                if ( function_58a3543a94ea5af6() )
                {
                    var_b3ffdbbcdd658a1b = self.leaderboarddata[ "secondaryVictories" ];
                }
                else
                {
                    var_b3ffdbbcdd658a1b += self.leaderboarddata[ "secondaryVictories" ];
                }
            }
            
            self setplayerdata( level.var_6f9b00680ed002d8, #"playerstats", #"modestats", modestring, "secondaryVictories", var_b3ffdbbcdd658a1b );
            self.var_2761215ec87fba6a[ "secondaryVictories" ] = self.leaderboarddata[ "secondaryVictories" ];
        }
        
        if ( !( self.var_2761215ec87fba6a[ "weaponCaseExfils" ] === self.leaderboarddata[ "weaponCaseExfils" ] ) )
        {
            if ( function_58a3543a94ea5af6() )
            {
                leaderboardvalue = 0;
            }
            else
            {
                leaderboardvalue = self getplayerdata( level.var_6f9b00680ed002d8, #"playerstats", #"modestats", modestring, "weaponCaseExfils" );
            }
            
            if ( !isdefined( self.leaderboardstartvalues[ "weaponCaseExfils" ] ) )
            {
                self.leaderboardstartvalues[ "weaponCaseExfils" ] = leaderboardvalue;
            }
            
            var_b3ffdbbcdd658a1b = self.leaderboardstartvalues[ "weaponCaseExfils" ];
            
            if ( self.leaderboarddata[ "weaponCaseExfils" ] > 0 )
            {
                if ( function_58a3543a94ea5af6() )
                {
                    var_b3ffdbbcdd658a1b = self.leaderboarddata[ "weaponCaseExfils" ];
                }
                else
                {
                    var_b3ffdbbcdd658a1b += self.leaderboarddata[ "weaponCaseExfils" ];
                }
            }
            
            self setplayerdata( level.var_6f9b00680ed002d8, #"playerstats", #"modestats", modestring, "weaponCaseExfils", var_b3ffdbbcdd658a1b );
            self.var_2761215ec87fba6a[ "weaponCaseExfils" ] = self.leaderboarddata[ "weaponCaseExfils" ];
        }
        
        if ( !( self.var_2761215ec87fba6a[ "weaponCaseWins" ] === self.leaderboarddata[ "weaponCaseWins" ] ) )
        {
            if ( function_58a3543a94ea5af6() )
            {
                leaderboardvalue = 0;
            }
            else
            {
                leaderboardvalue = self getplayerdata( level.var_6f9b00680ed002d8, #"playerstats", #"modestats", modestring, "weaponCaseWins" );
            }
            
            if ( !isdefined( self.leaderboardstartvalues[ "weaponCaseWins" ] ) )
            {
                self.leaderboardstartvalues[ "weaponCaseWins" ] = leaderboardvalue;
            }
            
            var_b3ffdbbcdd658a1b = self.leaderboardstartvalues[ "weaponCaseWins" ];
            
            if ( self.leaderboarddata[ "weaponCaseWins" ] > 0 )
            {
                if ( function_58a3543a94ea5af6() )
                {
                    var_b3ffdbbcdd658a1b = self.leaderboarddata[ "weaponCaseWins" ];
                }
                else
                {
                    var_b3ffdbbcdd658a1b += self.leaderboarddata[ "weaponCaseWins" ];
                }
            }
            
            self setplayerdata( level.var_6f9b00680ed002d8, #"playerstats", #"modestats", modestring, "weaponCaseWins", var_b3ffdbbcdd658a1b );
            self.var_2761215ec87fba6a[ "weaponCaseWins" ] = self.leaderboarddata[ "weaponCaseWins" ];
        }
        
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
        case #"hash_973d1db8b6644466":
            incrementleaderboardstat( "assists", modestring, self.leaderboarddata[ "assists" ] );
            incrementleaderboardstat( "hvtKills", modestring, self.leaderboarddata[ "hvtKills" ] );
        case #"hash_ca6516c10db2c95":
        case #"hash_7f9c384a34cc392f":
            incrementleaderboardstat( "captures", modestring, self.leaderboarddata[ "captures" ] );
            incrementleaderboardstat( "defends", modestring, self.leaderboarddata[ "defends" ] );
            break;
        case #"hash_eb5e5f470e0c1dc2":
            incrementleaderboardstat( "revives", modestring, self.leaderboarddata[ "rescues" ] );
            incrementleaderboardstat( "plants", modestring, self.leaderboarddata[ "plants" ] );
            break;
        case #"hash_7e89154a96f625d":
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
        case #"hash_ec72fd25bbbac99e":
            incrementleaderboardstat( "objTime", modestring, self.leaderboarddata[ "objTime" ] );
            incrementleaderboardstat( "defends", modestring, self.leaderboarddata[ "defends" ] );
            break;
        case #"hash_1a5d186c17c00d3c":
            incrementleaderboardstat( "captures", modestring, self.leaderboarddata[ "captures" ] );
            incrementleaderboardstat( "returns", modestring, self.leaderboarddata[ "returns" ] );
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
        case #"hash_681e57e53a02403":
            incrementleaderboardstat( "plants", modestring, self.leaderboarddata[ "plants" ] );
            incrementleaderboardstat( "defuses", modestring, self.leaderboarddata[ "defuses" ] );
            break;
        case #"hash_4e47eb6c32f5b165":
            incrementleaderboardstat( "hvtKills", modestring, self.leaderboarddata[ "hvtKills" ] );
            incrementleaderboardstat( "assists", modestring, self.leaderboarddata[ "assists" ] );
            break;
        case #"hash_1e3194fd705af366":
            incrementleaderboardstat( "time", modestring, self.leaderboarddata[ "time" ] );
            incrementleaderboardstat( "placement", modestring, self.leaderboarddata[ "placement" ] );
            break;
        case #"hash_dc6f4bf9685bd592":
            incrementleaderboardstat( "captures", modestring, self.leaderboarddata[ "captures" ] );
            incrementleaderboardstat( "confirms", modestring, self.leaderboarddata[ "confirms" ] );
            break;
        case #"hash_6ba8ca4fdff59c99":
            incrementleaderboardstat( "overcharge_count", modestring, self.pers[ "extrascore0" ] );
            incrementleaderboardstat( "sabattack_obj_kill_count", modestring, self.pers[ "extrascore1" ] );
            break;
        case #"hash_3e42b59314efb6d":
        case #"hash_566231b2d32896cb":
            incrementleaderboardstat( "objectives_completed", modestring, self.pers[ "extrascore0" ] );
            incrementleaderboardstat( "top_squad_kills", modestring, self.pers[ "extrascore1" ] );
            break;
        case #"hash_7c11ceb253d4cc3c":
            incrementleaderboardstat( "stabs", modestring, self.pers[ "extrascore0" ] );
            incrementleaderboardstat( "setBacks", modestring, self.pers[ "extrascore1" ] );
            break;
    }
}

// Namespace gamelogic_mp
// Params 3
// Checksum 0x886b1037, Offset: 0x1e9fa
// Size: 0x69
function updateleaderboardstatmaximum( stat, modestring, var_75b2fafbaa142fb1 )
{
    var_4595b4b85ef28e93 = self getplayerdata( level.var_6f9b00680ed002d8, "playerStats", "modeStats", modestring, stat );
    
    if ( var_75b2fafbaa142fb1 > var_4595b4b85ef28e93 )
    {
        self setplayerdata( level.var_6f9b00680ed002d8, "playerStats", "modeStats", modestring, stat, var_75b2fafbaa142fb1 );
    }
}

// Namespace gamelogic_mp
// Params 1
// Checksum 0x3f83f7fd, Offset: 0x1ea6b
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

// Namespace gamelogic_mp
// Params 1
// Checksum 0x7d0140e5, Offset: 0x1eaf2
// Size: 0x47, Type: bool
function isvalidbestweapon( rootname )
{
    group = weapon::getweapongroup( rootname );
    return rootname && !weapon::iskillstreakweapon( rootname ) && group != "killstreak" && group != "other";
}

// Namespace gamelogic_mp
// Params 0
// Checksum 0x6339cc40, Offset: 0x1eb42
// Size: 0x2
function function_c0a1ca74a4089b63()
{
    
}

// Namespace gamelogic_mp
// Params 1
// Checksum 0x68bc7160, Offset: 0x1eb4c
// Size: 0x75
function allow_weapon_mp( bool )
{
    self notify( #"hash_ae137792a5f878e2" );
    
    if ( bool )
    {
        if ( isdefined( self.allowweaponcache ) && !self hasweapon( self.allowweaponcache ) && !killstreak::isjuggernaut() )
        {
            inventory::switchtolastweapon();
        }
        
        self.allowweaponcache = undefined;
        return;
    }
    
    self.allowweaponcache = self.lastnormalweaponobj;
    thread watchinvalidweaponswitchduringdisableweapon();
}

// Namespace gamelogic_mp
// Params 0
// Checksum 0xc5baac05, Offset: 0x1ebc9
// Size: 0x10
function allow_weapon_mp_init()
{
    level.allow_weapon_mp = &allow_weapon_mp;
}

// Namespace gamelogic_mp
// Params 0
// Checksum 0xaee06dfb, Offset: 0x1ebe1
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

// Namespace gamelogic_mp
// Params 0
// Checksum 0x281ac23c, Offset: 0x1ec3b
// Size: 0xd
function ismp_init()
{
    level.ismp = 1;
}

// Namespace gamelogic_mp
// Params 1
// Checksum 0xd33bd20f, Offset: 0x1ec50
// Size: 0x5b
function function_7c36a49f06eb0cde( maxplayers )
{
    minplayers = getdvarint( @"live_lobby_minplayers_start" );
    
    if ( minplayers > maxplayers )
    {
        println( "<dev string:xeea>" + minplayers + "<dev string:xf19>" + maxplayers );
        setdvar( @"live_lobby_minplayers_start", maxplayers );
        minplayers = maxplayers;
    }
    
    return minplayers;
}

// Namespace gamelogic_mp
// Params 0
// Checksum 0xf65ea928, Offset: 0x1ecb4
// Size: 0x1f
function function_7ca6619790ebb4f2()
{
    level endon( #"game_ended" );
    flags::gameflagwait( "prematch_done" );
    prematchdone();
}

// Namespace gamelogic_mp
// Params 0
// Checksum 0x3afd394, Offset: 0x1ecdb
// Size: 0x3b7
function watchforminplayersmatchstart()
{
    level endon( #"start_prematch" );
    var_203857c33952b85d = getdvarint( @"hash_5e1370f70979f8b", 1 );
    lobbystarttime = gettime();
    lobbycurrtime = lobbystarttime;
    maxplayers = getdvarint( @"party_maxplayers" );
    minplayers = function_7c36a49f06eb0cde( maxplayers );
    var_c3a0b39a7f4bb769 = getdvarint( @"hash_961774a7c9cf5b66", 0 );
    
    if ( var_c3a0b39a7f4bb769 > maxplayers )
    {
        println( "<dev string:xf1e>" + var_c3a0b39a7f4bb769 + "<dev string:xf57>" + maxplayers + "<dev string:x738>" );
        var_c3a0b39a7f4bb769 = maxplayers;
    }
    
    logstring( "[PREMATCH_DEBUG] " + "gamelogic_mp::watchforminplayersmatchstart" + ": " + "started: lobbyStartTime=" + lobbystarttime + " maxPlayers=" + maxplayers + " minPlayers=" + minplayers + " minPlayersAfterTimeout=" + var_c3a0b39a7f4bb769 + " considerLoadingClients=" + var_203857c33952b85d );
    
    if ( minplayers != 0 )
    {
        while ( true )
        {
            if ( level.devoverridematchstart )
            {
                logstring( "[PREMATCH_DEBUG] " + "gamelogic_mp::watchforminplayersmatchstart" + ": " + "BREAK: devOverrideMatchStart is true" );
                break;
            }
            
            if ( getdvarint( @"hash_51aa9c88bb0c1224", 1 ) == 1 && level.var_309e3d9dac389de6 )
            {
                logstring( "[PREMATCH_DEBUG] " + "gamelogic_mp::watchforminplayersmatchstart" + ": " + "waiting for leagueplay_br_backfill_closed" );
                level waittill( #"leagueplay_br_backfill_closed" );
                logstring( "[PREMATCH_DEBUG] " + "gamelogic_mp::watchforminplayersmatchstart" + ": " + "BREAK: leagueplay_br_backfill_closed received" );
                break;
            }
            
            var_f45803a2a6bbf870 = ( lobbycurrtime - lobbystarttime ) / 1000;
            var_81284df95fc81aba = getdvarint( @"live_lobby_max_time", 300 );
            
            if ( var_81284df95fc81aba > 0 && var_f45803a2a6bbf870 >= var_81284df95fc81aba )
            {
                if ( var_c3a0b39a7f4bb769 == 0 || var_c3a0b39a7f4bb769 <= function_f9f1941e6be76346( 1, var_203857c33952b85d ) )
                {
                    logstring( "[PREMATCH_DEBUG] " + "gamelogic_mp::watchforminplayersmatchstart" + ": " + "BREAK: timeout reached. secondsInLobby=" + var_f45803a2a6bbf870 + " maxSecondsInLobby=" + var_81284df95fc81aba + " minPlayersAfterTimeout=" + var_c3a0b39a7f4bb769 + " playerAndUIBotCount=" + function_f9f1941e6be76346( 1, var_203857c33952b85d ) + " GetActiveClientCount(" + var_203857c33952b85d + ")=" + getactiveclientcount( istrue( var_203857c33952b85d ) ) + " GetUIBotsCount=" + manager::function_6f7e22d4e6adac55() );
                    break;
                }
            }
            
            if ( var_f45803a2a6bbf870 <= getdvarint( @"hash_738a4f27bfac1d24", 15 ) )
            {
                if ( function_f9f1941e6be76346( 1, 0 ) >= function_7c36a49f06eb0cde( maxplayers ) )
                {
                    logstring( "[PREMATCH_DEBUG] " + "gamelogic_mp::watchforminplayersmatchstart" + ": " + "BREAK: grace period player count met. secondsInLobby=" + var_f45803a2a6bbf870 + " gracePlayerCount=" + function_f9f1941e6be76346( 1, 0 ) + " minPlayers=" + function_7c36a49f06eb0cde( maxplayers ) + " GetActiveClientCount(false)=" + getactiveclientcount( 0 ) + " GetUIBotsCount=" + manager::function_6f7e22d4e6adac55() );
                    break;
                }
            }
            else if ( function_f9f1941e6be76346( 1, var_203857c33952b85d ) >= function_7c36a49f06eb0cde( maxplayers ) )
            {
                logstring( "[PREMATCH_DEBUG] " + "gamelogic_mp::watchforminplayersmatchstart" + ": " + "BREAK: post-grace player count met. secondsInLobby=" + var_f45803a2a6bbf870 + " postGracePlayerCount=" + function_f9f1941e6be76346( 1, var_203857c33952b85d ) + " minPlayers=" + function_7c36a49f06eb0cde( maxplayers ) + " GetActiveClientCount(" + var_203857c33952b85d + ")=" + getactiveclientcount( istrue( var_203857c33952b85d ) ) + " GetUIBotsCount=" + manager::function_6f7e22d4e6adac55() );
                break;
            }
            
            if ( isdefined( level.var_c21a63e88747885e ) )
            {
                [[ level.var_c21a63e88747885e ]]( var_81284df95fc81aba, var_f45803a2a6bbf870 );
            }
            
            waitframe();
            lobbycurrtime = gettime();
        }
    }
    
    waitframe();
    logstring( "[PREMATCH_DEBUG] " + "gamelogic_mp::watchforminplayersmatchstart" + ": " + "start_prematch notify. lobbyCurrTime=" + gettime() + " lobbyStartTime=" + lobbystarttime + " minPlayers=" + minplayers );
    level notify( #"start_prematch" );
}

// Namespace gamelogic_mp
// Params 0
// Checksum 0xa812fd17, Offset: 0x1f09a
// Size: 0x94
function brwatchforminplayersmatchstart()
{
    level endon( #"start_prematch" );
    
    while ( function_f9f1941e6be76346( 0 ) < getdvarint( @"br_minplayers" ) || level.devoverridematchstart )
    {
        waitframe();
    }
    
    waitframe();
    logstring( "[PREMATCH_DEBUG] " + "gamelogic_mp::brwatchforminplayersmatchstart" + ": " + "start_prematch notify. playerAndUIBotCount=" + function_f9f1941e6be76346( 0 ) + " br_minplayers=" + getdvarint( @"br_minplayers" ) + " devOverrideMatchStart=" + ( level.devoverridematchstart ?? "undefined" ) );
    level notify( #"start_prematch" );
}

// Namespace gamelogic_mp
// Params 2, eflags: 0x4
// Checksum 0xf99e5d92, Offset: 0x1f136
// Size: 0x4c
function private function_f9f1941e6be76346( var_98247b75e96845cf, var_203857c33952b85d )
{
    playercount = 0;
    
    if ( var_98247b75e96845cf )
    {
        playercount = getactiveclientcount( istrue( var_203857c33952b85d ) );
    }
    else
    {
        playercount = level.players.size;
    }
    
    playercount += manager::function_6f7e22d4e6adac55();
    return playercount;
}

// Namespace gamelogic_mp
// Params 0
// Checksum 0x21bf96b7, Offset: 0x1f18b
// Size: 0x1d3
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
        
        if ( !isdefined( startbutton ) )
        {
            continue;
        }
        
        startbutton gameobjects::allowuse( "any" );
        startbutton.id = "use";
        
        if ( startbutton.trigger isusable() )
        {
            startbutton.trigger setuseprioritymax();
            startbutton gameobjects::setusehinttext( &"mp_ingame_only/hold_to_start_game" );
        }
        
        startbutton gameobjects::setusetime( 3 );
        startbutton.onuse = &startbutton_onuse;
        level.startbuttons[ level.startbuttons.size ] = startbutton;
    }
}

// Namespace gamelogic_mp
// Params 0
// Checksum 0x16d6e400, Offset: 0x1f366
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

// Namespace gamelogic_mp
// Params 0
// Checksum 0xd27fa7e6, Offset: 0x1f6e5
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

// Namespace gamelogic_mp
// Params 0
// Checksum 0x855d62ab, Offset: 0x1f742
// Size: 0x45
function waitforoverridematchstartnotify()
{
    level endon( #"game_ended" );
    level endon( #"hash_e033cf5eebc8b249" );
    level waittill( #"forcematchstart", var_e3c31db8827a0158 );
    level.var_725e93363e456224 = var_e3c31db8827a0158;
    dev_forcelivelobbystart();
}

// Namespace gamelogic_mp
// Params 1
// Checksum 0x5ef2b86a, Offset: 0x1f78f
// Size: 0x20
function startbutton_onuse( player )
{
    player setclientomnvar( "ui_securing", 0 );
    dev_forcelivelobbystart();
}

// Namespace gamelogic_mp
// Params 0
// Checksum 0xd64abfe6, Offset: 0x1f7b7
// Size: 0x1d3
function dev_forcelivelobbystart()
{
    level thread sound::playsoundonplayers( "mp_dom_flag_captured" );
    
    foreach ( team in level.teamnamelist )
    {
        print::teamhudtutorialmessage( &"mp_ingame_only/game_force_started", team, 10 );
    }
    
    setdvar( @"br_minplayers", 1 );
    setdvar( @"live_lobby_minplayers_start", 1 );
    logstring( "[PREMATCH_DEBUG] " + "gamelogic_mp::dev_forcelivelobbystart" + ": " + "start_prematch notify" );
    level notify( #"start_prematch" );
    
    foreach ( button in level.startbuttons )
    {
        if ( !isdefined( button ) )
        {
            continue;
        }
        
        button gameobjects::allowuse( "none" );
        
        if ( isdefined( button.trigger ) )
        {
            button.trigger = undefined;
        }
        
        if ( isdefined( button.visibleteam ) )
        {
            button.visibleteam = "none";
        }
        
        if ( isdefined( button.flagmodel ) )
        {
            button.flagmodel delete();
        }
        
        button notify( #"deleted" );
    }
    
    level notify( #"hash_e033cf5eebc8b249" );
}

// Namespace gamelogic_mp
// Params 0
// Checksum 0x65f964e9, Offset: 0x1f992
// Size: 0xf9
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
    level.compassshowenemies = 0;
    
    /#
        sendscriptusageanalysisdata( 1, 1 );
    #/
    
    livelobbyroundendwait( 1 );
    level notify( #"game_cleanup" );
    setslowmotion( 1, 0.4, 3 );
    resetsoundtimescalefactor();
    flags::levelflagclear( "block_notifies" );
    restart();
}

// Namespace gamelogic_mp
// Params 1
// Checksum 0xd3f3a822, Offset: 0x1fa93
// Size: 0xb6
function livelobbyroundendwait( defaultdelay )
{
    codcasterdelay = 0;
    
    foreach ( player in level.players )
    {
        player thread game_utility_mp::setuipostgamefade( 0 );
        
        if ( player iscodcaster() )
        {
            codcasterdelay = level.var_e3c3286caf6ae8b8;
        }
    }
    
    wait defaultdelay + codcasterdelay;
    level notify( #"round_end_finished" );
}

// Namespace gamelogic_mp
// Params 2
// Checksum 0x440c99e7, Offset: 0x1fb51
// Size: 0x90
function livelobbymatchstarttimer( type, duration )
{
    self notify( #"hash_af7e9bbaadca5367" );
    self endon( #"hash_af7e9bbaadca5367" );
    level endon( #"hash_eb8195ab6900b9b7" );
    level notify( #"match_start_timer_beginning" );
    
    if ( level.var_59cffb353d98bc10 )
    {
        return;
    }
    
    counttime = int( duration );
    
    if ( counttime >= 2 )
    {
        setomnvar( "ui_match_start_text", type );
        matchstarttimerperplayer_internal( counttime );
    }
    
    visionsetnaked( "", 0 );
}

// Namespace gamelogic_mp
// Params 0
// Checksum 0xedb6d51b, Offset: 0x1fbe9
// Size: 0x14
function clearmatchhasmorethan1playervariablesonroundend()
{
    game[ "numPlayersConsideredPlaying" ] = 0;
    game[ "matchHasMoreThan1Player" ] = 0;
}

// Namespace gamelogic_mp
// Params 0
// Checksum 0x7a2dd060, Offset: 0x1fc05
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

// Namespace gamelogic_mp
// Params 0
// Checksum 0xfb1a9efb, Offset: 0x1fca5
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

// Namespace gamelogic_mp
// Params 0
// Checksum 0x30f8109f, Offset: 0x1fd32
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

// Namespace gamelogic_mp
// Params 0
// Checksum 0xf1dcdf85, Offset: 0x1fe89
// Size: 0x4
function getbrendsplashpostgamestate()
{
    return 8;
}

// Namespace gamelogic_mp
// Params 1
// Checksum 0x5470e218, Offset: 0x1fe96
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

// Namespace gamelogic_mp
// Params 0
// Checksum 0xd37aedfe, Offset: 0x1ffdf
// Size: 0x98
function function_1a9bd0d0b91259c7()
{
    humancount = 0;
    partymembers = getpartyinfo();
    
    foreach ( memberinfo in partymembers )
    {
        if ( !memberinfo.isai )
        {
            humancount++;
        }
    }
    
    return humancount;
}

// Namespace gamelogic_mp
// Params 0
// Checksum 0x5f572019, Offset: 0x20080
// Size: 0x8c
function function_9b0ce2cae7905e81()
{
    humancount = 0;
    
    foreach ( player in level.players )
    {
        if ( !isai( player ) )
        {
            humancount++;
        }
    }
    
    return humancount;
}

// Namespace gamelogic_mp
// Params 0
// Checksum 0x71bb9548, Offset: 0x20115
// Size: 0x62
function function_712829905bfc0897()
{
    if ( !isdefined( game[ "attackers" ] ) )
    {
        setomnvar( "ui_attacking_team", 0 );
    }
    
    if ( game[ "attackers" ] == "axis" )
    {
        setomnvar( "ui_attacking_team", 1 );
        return;
    }
    
    if ( game[ "attackers" ] == "allies" )
    {
        setomnvar( "ui_attacking_team", 2 );
        return;
    }
    
    setomnvar( "ui_attacking_team", 0 );
}

// Namespace gamelogic_mp
// Params 1
// Checksum 0x104d880f, Offset: 0x2017f
// Size: 0x16d
function function_a7f2ba55c82bfa95( inplayer )
{
    var_a4850452f8aa90da = getdvarint( @"hash_a8f4c9a06bff4b76", 1000 );
    var_e494183ba40d94f2 = getdvarint( @"hash_4906b1516f388c3b", 240 );
    
    if ( !isdefined( inplayer ) || isbot( inplayer ) || istestclient( inplayer ) )
    {
        return;
    }
    
    if ( !game[ "timePassed" ] )
    {
        return;
    }
    
    if ( !( game_utility_mp::matchmakinggame() || getdvarint( @"force_challenges" ) ) )
    {
        return;
    }
    
    if ( isdefined( level.startofxptime ) )
    {
        timeplayed = ( gettime() - level.startofxptime ) / 1000;
    }
    else
    {
        timeplayed = inplayer persistence::statgetchildbuffered( "round", "timePlayed", 0 );
    }
    
    if ( inplayer utility::callsharedfunc( #"seasonalevents", #"hash_36af605dbc36f0c" ) && timeplayed >= var_e494183ba40d94f2 )
    {
        if ( utility::issharedfuncdefined( #"rank", #"giverankxp" ) && !inplayer.var_84f9878aa35f4aba )
        {
            inplayer [[ utility::getsharedfunc( #"rank", #"giverankxp" ) ]]( #"fieldrep_operatorskin", var_a4850452f8aa90da, undefined, 1, 1, 1 );
            inplayer.pers[ "aarData" ][ "use_featured_operator_skin_xp" ] = var_a4850452f8aa90da;
            inplayer.var_84f9878aa35f4aba = 1;
        }
    }
}

// Namespace gamelogic_mp
// Params 1
// Checksum 0xa2277bf1, Offset: 0x202f4
// Size: 0x75
function function_20d0c6298aea98fb( player )
{
    gametype = game_utility::getgametype();
    
    if ( isdefined( gametype ) && ( gametype == "koth_horde" || gametype == "br" || gametype == "ob" ) )
    {
        if ( isplayer( player ) )
        {
            player function_5c85f761416b126a( gametype );
            return;
        }
        
        utility::array_thread( level.players, &function_5c85f761416b126a, gametype );
    }
}

// Namespace gamelogic_mp
// Params 1
// Checksum 0xad6ec767, Offset: 0x20371
// Size: 0x1cd
function function_5c85f761416b126a( gametype )
{
    player = self;
    
    if ( isdefined( player.pers[ "telemetry" ] ) && player.pers[ "telemetry" ].var_ad2cbba54cf5fcbf )
    {
        return;
    }
    
    telemetry_data = spawnstruct();
    telemetry_data.player = undefined;
    telemetry_data.playlistid = -1;
    telemetry_data.mode = "undefined";
    telemetry_data.sub_mode = "undefined";
    telemetry_data.bones_zombies = 0;
    telemetry_data.skulls_armored_zombies = 0;
    telemetry_data.skulls_hellhounds = 0;
    telemetry_data.skulls_mimics = 0;
    telemetry_data.player = player;
    telemetry_data.playlistid = getplaylistid();
    telemetry_data.mode = gametype;
    telemetry_data.sub_mode = game_utility::getgametype();
    
    if ( isdefined( player.bone_count ) )
    {
        telemetry_data.bones_zombies = player.bone_count;
    }
    
    if ( isdefined( player.var_a9de332c7a0b8c9a ) )
    {
        telemetry_data.skulls_armored_zombies = player.var_a9de332c7a0b8c9a;
    }
    
    if ( isdefined( player.var_61b9f39f5785a14f ) )
    {
        telemetry_data.skulls_hellhounds = player.var_61b9f39f5785a14f;
    }
    
    if ( isdefined( player.var_a2e399cc18a8d139 ) )
    {
        telemetry_data.skulls_mimics = player.var_a2e399cc18a8d139;
    }
    
    player.pers[ "telemetry" ].var_ad2cbba54cf5fcbf = 1;
    telemetry_utils::function_af2d366f9522f76f( "callback_the_hunt_eom", telemetry_data );
}

// Namespace gamelogic_mp
// Params 2
// Checksum 0x47d340b1, Offset: 0x20546
// Size: 0xc5
function function_3b5c3561b2cfc173( player, iswinningplayer )
{
    ismpmode = 1;
    
    if ( isbrgamemode() || game_utility::getgametype() == "dmz" || game_utility::getgametype() == "plunder" || game_utility::getgametype() == "kingslayer" || game_utility_mp::isprophuntgametype() )
    {
        ismpmode = 0;
    }
    
    if ( ismpmode )
    {
        var_17d5b99f8b54ee82 = 0;
        
        if ( iswinningplayer )
        {
            var_17d5b99f8b54ee82 += 1;
        }
        
        if ( gamescore::gethighestscoringplayer() == player )
        {
            var_17d5b99f8b54ee82 += 1;
        }
        
        if ( var_17d5b99f8b54ee82 > 0 )
        {
            challenges::function_5c810516c9ac1b45( player, var_17d5b99f8b54ee82 );
        }
        
        player.pers[ "telemetry" ].var_bd01ba2a79bcab95 = var_17d5b99f8b54ee82;
    }
}

// Namespace gamelogic_mp
// Params 0, eflags: 0x4
// Checksum 0x378b7b5d, Offset: 0x20613
// Size: 0x119
function private function_b54112164c257231()
{
    if ( !level.players.size )
    {
        return;
    }
    
    level.var_397f51ba9948c3c6 = -1;
    level.mostelims = -1;
    
    foreach ( player in level.players )
    {
        if ( !player )
        {
            continue;
        }
        
        player assignedr();
        
        if ( player.pers[ "EDR" ] > level.var_397f51ba9948c3c6 )
        {
            level.var_397f51ba9948c3c6 = player.pers[ "EDR" ];
        }
        
        if ( player.pers[ "elims" ] > level.mostelims )
        {
            level.mostelims = player.pers[ "elims" ];
        }
    }
}

// Namespace gamelogic_mp
// Params 0, eflags: 0x4
// Checksum 0xdb4ef8d9, Offset: 0x20734
// Size: 0xc1
function private assignedr()
{
    var_f78140643fdcdab0 = 0;
    
    if ( isdefined( self.pers[ "kills" ] ) && isdefined( self.pers[ "assists" ] ) && isdefined( self.pers[ "deaths" ] ) )
    {
        elims = self.pers[ "kills" ] + self.pers[ "assists" ];
        self.pers[ "elims" ] = elims;
        var_2860779fcb735aae = max( self.pers[ "deaths" ], 1 );
        var_f78140643fdcdab0 = int( elims / var_2860779fcb735aae * 100 );
    }
    
    self.pers[ "EDR" ] = var_f78140643fdcdab0;
}

