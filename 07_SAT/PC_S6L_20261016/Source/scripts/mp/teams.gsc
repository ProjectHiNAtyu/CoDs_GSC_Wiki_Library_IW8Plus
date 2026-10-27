// scripts\mp\teams.gsc  (hash_18a132aeee23136e.gscc) (size: 30864 Bytes / 0x7890 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x56d19c32 (1456577586)
// size ...... 30864 (0x7890)
// includes .. 26  (offset: 0x6820)
// strings ... 283 (offset: 0x68f0)
// dev strs .. 19  (offset: 0x77ac)
// exports ... 47  (offset: 0x4c18)
// cseg ...... 0x16d2 + 0x3546 (0x4c18)
// imports ... 177 (offset: 0x5370)
// animtree1 . 0   (offset: 0x7890)
// animtree2 . 0   (offset: 0x7890)
#using scripts\common\callbacks;
#using scripts\common\throttle;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\mp\analyticslog;
#using scripts\mp\common\killstreaks\uav;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\join_team_aggregator;
#using scripts\mp\common\utility\outline;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\common\utility\squad_utility;
#using scripts\mp\common\utility\team_utility;
#using scripts\mp\common\utility\teams;
#using scripts\mp\emote;
#using scripts\mp\execution;
#using scripts\mp\flags;
#using scripts\mp\gameinstance;
#using scripts\mp\hostmigration;
#using scripts\mp\hud_message;
#using scripts\mp\menus;
#using scripts\mp\operator;
#using scripts\mp\persistence;
#using scripts\mp\playerstats_interface;
#using scripts\mp\sprays;

#namespace teams;

// Namespace teams
// Params 0
// Checksum 0xb5312c3, Offset: 0x16f0
// Size: 0xc39
function init()
{
    utility::registersharedfunc( #"customization", #"getoperatorcustomization", &operator::getoperatorcustomization );
    utility::registersharedfunc( #"customization", #"setcharactermodels", &setcharactermodels );
    utility::registersharedfunc( #"teams", #"hash_a6e0072a35670d1a", &function_128d91e02cacedfb );
    level.teambalance = getdvarint( @"scr_teambalance" );
    level.maxclients = getmaxclients();
    allteams = [ "free", "axis", "allies", "team_three", "team_four", "team_five", "team_six", "team_seven", "team_eight", "team_nine", "team_ten", "team_eleven", "team_twelve", "team_thirteen", "team_fourteen", "team_fifteen", "team_sixteen", "team_seventeen", "team_eighteen", "team_nineteen", "team_twenty", "team_twenty_one", "team_twenty_two", "team_twenty_three", "team_twenty_four", "team_twenty_five", "team_twenty_six", "team_twenty_seven", "team_twenty_eight", "team_twenty_nine", "team_thirty", "team_thirty_one", "team_thirty_two", "team_thirty_three", "team_thirty_four", "team_thirty_five", "team_thirty_six", "team_thirty_seven", "team_thirty_eight", "team_thirty_nine", "team_forty", "team_forty_one", "team_forty_two", "team_forty_three", "team_forty_four", "team_forty_five", "team_forty_six", "team_forty_seven", "team_forty_eight", "team_forty_nine", "team_fifty", "team_fifty_one", "team_fifty_two", "team_fifty_three", "team_fifty_four", "team_fifty_five", "team_fifty_six", "team_fifty_seven", "team_fifty_eight", "team_fifty_nine", "team_sixty", "team_sixty_one", "team_sixty_two", "team_sixty_three", "team_sixty_four", "team_sixty_five", "team_sixty_six", "team_sixty_seven", "team_sixty_eight", "team_sixty_nine", "team_seventy", "team_seventy_one", "team_seventy_two", "team_seventy_three", "team_seventy_four", "team_seventy_five", "team_seventy_six", "team_seventy_seven", "team_seventy_eight", "team_seventy_nine", "team_eighty", "team_eighty_one", "team_eighty_two", "team_eighty_three", "team_eighty_four", "team_eighty_five", "team_eighty_six", "team_eighty_seven", "team_eighty_eight", "team_eighty_nine", "team_ninety", "team_ninety_one", "team_ninety_two", "team_ninety_three", "team_ninety_four", "team_ninety_five", "team_ninety_six", "team_ninety_seven", "team_ninety_eight", "team_ninety_nine", "team_hundred", "team_hundred_one", "team_hundred_two", "team_hundred_three", "team_hundred_four", "team_hundred_five", "team_hundred_six", "team_hundred_seven", "team_hundred_eight", "team_hundred_nine", "team_hundred_ten", "team_hundred_eleven", "team_hundred_twelve", "team_hundred_thirteen", "team_hundred_fourteen", "team_hundred_fifteen", "team_hundred_sixteen", "team_hundred_seventeen", "team_hundred_eightteen", "team_hundred_nineteen", "team_hundred_twenty", "team_hundred_twenty_one", "team_hundred_twenty_two", "team_hundred_twenty_three", "team_hundred_twenty_four", "team_hundred_twenty_five", "team_hundred_twenty_six", "team_hundred_twenty_seven", "team_hundred_twenty_eight", "team_hundred_twenty_nine", "team_hundred_thirty", "team_hundred_thirty_one", "team_hundred_thirty_two", "team_hundred_thirty_three", "team_hundred_thirty_four", "team_hundred_thirty_five", "team_hundred_thirty_six", "team_hundred_thirty_seven", "team_hundred_thirty_eight", "team_hundred_thirty_nine", "team_hundred_forty", "team_hundred_forty_one", "team_hundred_forty_two", "team_hundred_forty_three", "team_hundred_forty_four", "team_hundred_forty_five", "team_hundred_forty_six", "team_hundred_forty_seven", "team_hundred_forty_eight", "team_hundred_forty_nine", "team_hundred_fifty", "team_hundred_fifty_one", "team_hundred_fifty_two", "team_hundred_fifty_three", "team_hundred_fifty_four", "team_hundred_fifty_five", "team_hundred_fifty_six", "team_hundred_fifty_seven", "team_hundred_fifty_eight", "team_hundred_fifty_nine", "team_hundred_sixty", "team_hundred_sixty_one", "team_hundred_sixty_two", "team_hundred_sixty_three", "team_hundred_sixty_four", "team_hundred_sixty_five", "team_hundred_sixty_six", "team_hundred_sixty_seven", "team_hundred_sixty_eight", "team_hundred_sixty_nine", "team_hundred_seventy", "team_hundred_seventy_one", "team_hundred_seventy_two", "team_hundred_seventy_three", "team_hundred_seventy_four", "team_hundred_seventy_five", "team_hundred_seventy_six", "team_hundred_seventy_seven", "team_hundred_seventy_eight", "team_hundred_seventy_nine", "team_hundred_eighty", "team_hundred_eighty_one", "team_hundred_eighty_two", "team_hundred_eighty_three", "team_hundred_eighty_four", "team_hundred_eighty_five", "team_hundred_eighty_six", "team_hundred_eighty_seven", "team_hundred_eighty_eight", "team_hundred_eighty_nine", "team_hundred_ninety", "team_hundred_ninety_one", "team_hundred_ninety_two", "team_hundred_ninety_three", "team_hundred_ninety_four", "team_hundred_ninety_five", "team_hundred_ninety_six", "team_hundred_ninety_seven", "team_hundred_ninety_eight", "team_hundred_ninety_nine", "team_two_hundred", "spectator", "codcaster", "civilian", "team_big_map_agent" ];
    level.allteamnamelist = allteams;
    combatteams = [ "axis", "allies" ];
    
    if ( getdvarint( @"hash_5dabea153bf14a41", 0 ) == 1 )
    {
        combatteams = [ "axis" ];
    }
    
    var_dcdb4fd1b72cca98 = [ "SAS", "RUSF", "USMC", "SABF" ];
    activeteamcount = getcustomgametypeteammax();
    level.maxteamsize = getmatchrulesdata( "commonOption", "teamSize" );
    var_85450e5253bbb484 = 1;
    var_25a82ff2b43de35d = -1;
    
    if ( activeteamcount >= 3 )
    {
        for ( i = 3; i < activeteamcount + var_85450e5253bbb484 ; i++ )
        {
            combatteams[ combatteams.size ] = level.allteamnamelist[ i ];
            
            if ( !isdefined( game[ level.allteamnamelist[ i ] ] ) )
            {
                game[ level.allteamnamelist[ i ] ] = var_dcdb4fd1b72cca98[ ( i + var_25a82ff2b43de35d ) % var_dcdb4fd1b72cca98.size ];
            }
        }
    }
    
    level.teamnamelist = combatteams;
    level.multiteambased = level.teamnamelist.size > 2 || getdvarint( @"hash_2c78e7cf8d058302", 0 ) == 1 || squadasteamenabled();
    level.teamdata = [];
    level.var_227b8a3a9c083621 = 0;
    level.activeteams = level.teamnamelist;
    level.var_fc71e82557e9a9c2 = 0;
    level.var_bb25c34ae28e413f = 0;
    
    if ( level.gamemodebundle.var_e60511c1f8343a1d == #"core_mp" )
    {
        initteamdata( "codcaster" );
        initteamdata( "spectator" );
        var_a5bb1e1bb2bb879f = ( activeteamcount > 0 ? activeteamcount : level.maxclients ) + 1;
        
        foreach ( team in allteams )
        {
            initteamdata( team );
            var_a5bb1e1bb2bb879f--;
            
            if ( var_a5bb1e1bb2bb879f <= 0 )
            {
                break;
            }
        }
    }
    else
    {
        foreach ( team in allteams )
        {
            initteamdata( team );
        }
    }
    
    level callback::callback( #"register_team_data" );
    
    foreach ( team in combatteams )
    {
        getteamfactionsfrommap( team );
        function_a5c04e4d6a5cc5d3( team );
    }
    
    level.teambased = activeteamcount > 1 || getdvarint( @"hash_6bfddbbc0765d353", 0 ) == 1;
    
    if ( !level.teambased )
    {
        setteammode( "ffa" );
    }
    
    setdvar( @"ui_numteams", level.teamnamelist.size );
    
    if ( getmatchrulesdata( "commonOption", "radarAlwaysOn" ) > 1 && level.teambased )
    {
        level thread uav::function_76ded778d105259d( undefined, 1 );
    }
    
    callback::add( #"player_spawned", &onplayerspawned );
    join_team_aggregator::registeronplayerjointeamcallback( &onjoinedteam );
    level thread onplayerconnect();
    callback::add( #"prematch_done", &trackplayedtime );
    operator::function_99f3495eb915fb96();
    initnightvisionheadoverrides();
    wait 0.15;
    level thread updateplayertimes();
    level thread finalizeplayertimes();
    
    if ( level.teambased )
    {
        level thread updateteambalance();
    }
    
    /#
        level thread devmonitoroperatorcustomizationprint();
        level thread debugprintteams();
    #/
    
    utility::registersharedfunc( #"teams", #"hash_37e3c17230e1ac5f", &function_4081b8b1191c67e2 );
}

// Namespace teams
// Params 1
// Checksum 0x69a12a7d, Offset: 0x2331
// Size: 0x14f
function initteamdata( team )
{
    level.teamdata[ team ] = [];
    level.teamdata[ team ][ "players" ] = [];
    level.teamdata[ team ][ "alivePlayers" ] = [];
    level.teamdata[ team ][ "teamCount" ] = 0;
    level.teamdata[ team ][ "aliveCount" ] = 0;
    level.teamdata[ team ][ "livesCount" ] = 0;
    level.teamdata[ team ][ "hasSpawned" ] = 0;
    level.teamdata[ team ][ "oneLeftTime" ] = 0;
    level.teamdata[ team ][ "twoLeft" ] = 0;
    level.teamdata[ team ][ "oneLeft" ] = 0;
    level.teamdata[ team ][ "noRespawns" ] = 0;
    level.teamdata[ team ][ "playagainHostXuid" ] = "0";
    
    if ( level.multiteambased )
    {
        level.teamdata[ team ][ "deathEvent" ] = 0;
    }
    
    if ( isdefined( level.uibotmanager ) )
    {
        level.teamdata[ team ][ "UIBotCount" ] = 0;
        level.teamdata[ team ][ "UnlockedUIBotCount" ] = 0;
    }
}

// Namespace teams
// Params 0
// Checksum 0xdbc2a4f0, Offset: 0x2488
// Size: 0xe5
function onplayerconnect()
{
    for ( ;; )
    {
        level waittill( #"connected", player );
        player.timeplayed = [];
        player.timeplayed[ "game" ] = 0;
        player.timeplayed[ "total" ] = 0;
        player.timeplayed[ "missionTeam" ] = 0;
        player.timeplayed[ "other" ] = 0;
        player.timeplayed[ "gulag" ] = 0;
        player.timeplayed[ "resurgenceRespawn" ] = 0;
        player.timeplayed[ "infil" ] = 0;
        
        if ( !isdefined( player.pers[ "timeDead" ] ) )
        {
            player.pers[ "timeDead" ] = 0;
        }
        
        player function_ba48cfa27567909e();
        player function_38bc136ca0eed214();
    }
}

// Namespace teams
// Params 1
// Checksum 0x9bcc0b20, Offset: 0x2575
// Size: 0x15
function onjoinedteam( player )
{
    player updateteamtime();
}

// Namespace teams
// Params 1
// Checksum 0x838f49cb, Offset: 0x2592
// Size: 0x2c
function onjoinedspectators( player )
{
    if ( isdefined( player.pers ) )
    {
        player.pers[ "teamTime" ] = undefined;
    }
}

// Namespace teams
// Params 1
// Checksum 0xb80c4c9e, Offset: 0x25c6
// Size: 0x160
function trackplayedtime( params )
{
    level endon( #"game_ended" );
    
    if ( isbrgamemode() )
    {
        var_25cf1390286dec2a = 2;
    }
    else
    {
        var_25cf1390286dec2a = 1;
    }
    
    var_800ec7f2af0f5cb = 1000 * var_25cf1390286dec2a;
    frameduration = level.frameduration;
    var_508d69692d3b2918 = floor( var_800ec7f2af0f5cb / frameduration );
    wait 1;
    
    while ( !level.gameended )
    {
        players = level.players;
        var_d075e30679df368f = ceil( players.size / var_508d69692d3b2918 );
        playersupdated = 0;
        framesprocessed = 0;
        
        foreach ( player in players )
        {
            if ( isdefined( player ) )
            {
                player trackplayedtimeupdate( var_25cf1390286dec2a );
                playersupdated++;
                
                if ( playersupdated >= var_d075e30679df368f )
                {
                    playersupdated = 0;
                    framesprocessed++;
                    waitframe();
                }
            }
        }
        
        waittime = max( 0, var_800ec7f2af0f5cb - framesprocessed * frameduration ) / 1000;
        wait waittime;
    }
}

// Namespace teams
// Params 1, eflags: 0x4
// Checksum 0xb3c3122c, Offset: 0x272e
// Size: 0x236
function private trackplayedtimeupdate( var_25cf1390286dec2a )
{
    assert( isdefined( self ) );
    
    if ( isdefined( self.pers[ "telemetry" ] ) )
    {
        if ( !isdefined( self.pers[ "telemetry" ].var_66d40dcc3e2ce088 ) )
        {
            self.pers[ "telemetry" ].var_66d40dcc3e2ce088 = 0;
        }
        
        self.pers[ "telemetry" ].var_66d40dcc3e2ce088 = self.pers[ "telemetry" ].var_66d40dcc3e2ce088 + var_25cf1390286dec2a;
    }
    
    if ( isdefined( self.timeplayed ) && isdefined( self.sessionteam ) )
    {
        self.timeplayed[ "game" ] = self.timeplayed[ "game" ] + var_25cf1390286dec2a;
        
        if ( !level.teambased || team_utility::isgameplayteam( self.sessionteam ) )
        {
            self.timeplayed[ "total" ] = self.timeplayed[ "total" ] + var_25cf1390286dec2a;
            self.timeplayed[ "missionTeam" ] = self.timeplayed[ "missionTeam" ] + var_25cf1390286dec2a;
            
            if ( !player::isreallyalive( self ) )
            {
                if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( self ) ) )
                {
                    if ( isdefined( self.leaderboarddata[ "timeDead" ] ) )
                    {
                        self.leaderboarddata[ "timeDead" ] = self.leaderboarddata[ "timeDead" ] + var_25cf1390286dec2a;
                    }
                    
                    if ( isdefined( level.leaderboardfunc[ "timeDead" ] ) )
                    {
                        [[ level.leaderboardfunc[ "timeDead" ] ]]( self, var_25cf1390286dec2a );
                    }
                    
                    assert( isint( var_25cf1390286dec2a ) || isfloat( var_25cf1390286dec2a ), "<dev string:x24>" );
                    
                    if ( isdefined( self.pers[ "timeDead" ] ) )
                    {
                        self.pers[ "timeDead" ] = self.pers[ "timeDead" ] + var_25cf1390286dec2a;
                    }
                }
            }
        }
    }
    
    if ( self.var_90534cd58b6798f9 > 0 )
    {
        self.var_90534cd58b6798f9 -= var_25cf1390286dec2a;
    }
}

// Namespace teams
// Params 0
// Checksum 0x2853bc62, Offset: 0x296c
// Size: 0x9e
function updateplayertimes()
{
    level endon( #"game_ended" );
    var_76190fd14c32bdcc = throttle::function_ac02df3f2e81cbab( "updatePlayerTimes", getdvarint( @"hash_7f2f3b192958dfae", 20 ), undefined, 2 );
    
    while ( true )
    {
        throttle::function_706ed379a3746335( var_76190fd14c32bdcc );
        
        for ( playerindex = 0; playerindex < level.players.size ; playerindex++ )
        {
            hostmigration::waittillhostmigrationdone();
            player = level.players[ playerindex ];
            
            if ( isdefined( player ) )
            {
                player updateplayedtime();
            }
            
            throttle::function_1302aa73badc74f0( var_76190fd14c32bdcc );
        }
    }
}

// Namespace teams
// Params 0
// Checksum 0x547d6a07, Offset: 0x2a12
// Size: 0xad
function finalizeplayertimes()
{
    while ( !level.gameended )
    {
        wait 2;
    }
    
    foreach ( player in level.players )
    {
        player updateplayedtime();
        
        if ( !game_utility_mp::runleanthreadmode() )
        {
            player persistence::writebufferedstats();
            player persistence::updateweaponbufferedstats();
        }
    }
}

// Namespace teams
// Params 0
// Checksum 0x46d4bc4b, Offset: 0x2ac7
// Size: 0x91
function updateplayedtime()
{
    if ( isai( self ) )
    {
        return;
    }
    
    playerstats_interface::addtoplayerstatbuffered( self.timeplayed[ "game" ], "matchStats", "timePlayedTotal" );
    persistence::stataddchildbuffered( "round", "timePlayed", self.timeplayed[ "game" ], 1 );
    callback::callback( #"player_update_played_time", {} );
    
    if ( game_utility_mp::getgamestate( self ) == "postgame" )
    {
        return;
    }
    
    self.timeplayed[ "game" ] = 0;
    self.timeplayed[ "missionTeam" ] = 0;
}

// Namespace teams
// Params 0
// Checksum 0x773ff8f9, Offset: 0x2b60
// Size: 0x27
function updateteamtime()
{
    if ( game_utility_mp::getgamestate( self ) != "playing" )
    {
        return;
    }
    
    self.pers[ "teamTime" ] = gettime();
}

// Namespace teams
// Params 0
// Checksum 0x2619d11, Offset: 0x2b8f
// Size: 0x46
function updateteambalancedvar()
{
    for ( ;; )
    {
        teambalance = getdvarint( @"scr_teambalance" );
        
        if ( level.teambalance != teambalance )
        {
            level.teambalance = getdvarint( @"scr_teambalance" );
        }
        
        wait 1;
    }
}

// Namespace teams
// Params 0
// Checksum 0x3a8467cd, Offset: 0x2bdd
// Size: 0xdd
function updateteambalance()
{
    level thread updateteambalancedvar();
    wait 0.15;
    
    if ( level.teambalance && game_utility_mp::isroundbased() )
    {
        if ( isdefined( game[ "BalanceTeamsNextRound" ] ) )
        {
            hud_message::showerrormessagetoallplayers( %"mp/autobalance_next_round" );
        }
        
        level waittill( #"restarting" );
        
        if ( isdefined( game[ "BalanceTeamsNextRound" ] ) )
        {
            level balanceteams();
            game[ "BalanceTeamsNextRound" ] = undefined;
        }
        else if ( !getteambalance() )
        {
            game[ "BalanceTeamsNextRound" ] = 1;
        }
        
        return;
    }
    
    level endon( #"game_ended" );
    
    for ( ;; )
    {
        if ( level.teambalance )
        {
            if ( !getteambalance() )
            {
                hud_message::showerrormessagetoallplayers( %"mp/autobalance_seconds", 15 );
                wait 15;
                
                if ( !getteambalance() )
                {
                    level balanceteams();
                }
            }
            
            wait 59;
        }
        
        wait 1;
    }
}

// Namespace teams
// Params 0
// Checksum 0x8becba13, Offset: 0x2cc2
// Size: 0x10a
function getteambalance()
{
    team[ "allies" ] = 0;
    team[ "axis" ] = 0;
    players = level.players;
    
    for ( i = 0; i < players.size ; i++ )
    {
        if ( isdefined( players[ i ].pers[ "team" ] ) && players[ i ].pers[ "team" ] == "allies" )
        {
            team[ "allies" ]++;
            continue;
        }
        
        if ( isdefined( players[ i ].pers[ "team" ] ) && players[ i ].pers[ "team" ] == "axis" )
        {
            team[ "axis" ]++;
        }
    }
    
    if ( team[ "allies" ] > team[ "axis" ] + level.teambalance || team[ "axis" ] > team[ "allies" ] + level.teambalance )
    {
        return 0;
    }
    
    return 1;
}

// Namespace teams
// Params 0
// Checksum 0x10c559ef, Offset: 0x2dd4
// Size: 0x2dd
function balanceteams()
{
    iprintlnbold( game[ "strings" ][ "autobalance" ] );
    alliedplayers = [];
    axisplayers = [];
    players = level.players;
    
    for ( i = 0; i < players.size ; i++ )
    {
        if ( !isdefined( players[ i ].pers[ "teamTime" ] ) )
        {
            continue;
        }
        
        if ( isdefined( players[ i ].pers[ "team" ] ) && players[ i ].pers[ "team" ] == "allies" )
        {
            alliedplayers[ alliedplayers.size ] = players[ i ];
            continue;
        }
        
        if ( isdefined( players[ i ].pers[ "team" ] ) && players[ i ].pers[ "team" ] == "axis" )
        {
            axisplayers[ axisplayers.size ] = players[ i ];
        }
    }
    
    mostrecent = undefined;
    
    while ( alliedplayers.size > axisplayers.size + 1 || axisplayers.size > alliedplayers.size + 1 )
    {
        if ( alliedplayers.size > axisplayers.size + 1 )
        {
            for ( j = 0; j < alliedplayers.size ; j++ )
            {
                if ( isdefined( alliedplayers[ j ].dont_auto_balance ) )
                {
                    continue;
                }
                
                if ( !isdefined( mostrecent ) )
                {
                    mostrecent = alliedplayers[ j ];
                    continue;
                }
                
                if ( alliedplayers[ j ].pers[ "teamTime" ] > mostrecent.pers[ "teamTime" ] )
                {
                    mostrecent = alliedplayers[ j ];
                }
            }
            
            mostrecent [[ level.onteamselection ]]( "axis" );
        }
        else if ( axisplayers.size > alliedplayers.size + 1 )
        {
            for ( j = 0; j < axisplayers.size ; j++ )
            {
                if ( isdefined( axisplayers[ j ].dont_auto_balance ) )
                {
                    continue;
                }
                
                if ( !isdefined( mostrecent ) )
                {
                    mostrecent = axisplayers[ j ];
                    continue;
                }
                
                if ( axisplayers[ j ].pers[ "teamTime" ] > mostrecent.pers[ "teamTime" ] )
                {
                    mostrecent = axisplayers[ j ];
                }
            }
            
            mostrecent [[ level.onteamselection ]]( "allies" );
        }
        
        mostrecent = undefined;
        alliedplayers = [];
        axisplayers = [];
        players = level.players;
        
        for ( i = 0; i < players.size ; i++ )
        {
            if ( isdefined( players[ i ].pers[ "team" ] ) && players[ i ].pers[ "team" ] == "allies" )
            {
                alliedplayers[ alliedplayers.size ] = players[ i ];
                continue;
            }
            
            if ( isdefined( players[ i ].pers[ "team" ] ) && players[ i ].pers[ "team" ] == "axis" )
            {
                axisplayers[ axisplayers.size ] = players[ i ];
            }
        }
    }
}

// Namespace teams
// Params 2
// Checksum 0xcd16038b, Offset: 0x30b9
// Size: 0x15
function playermodelforweapon( weapon, secondary )
{
    
}

// Namespace teams
// Params 2
// Checksum 0xdbdf9882, Offset: 0x30d6
// Size: 0x16e
function countplayers( var_66933a12fdd7c8ce = 1, ignorefriendlies = 0 )
{
    player_counts = [];
    
    for ( i = 0; i < level.teamnamelist.size ; i++ )
    {
        player_counts[ level.teamnamelist[ i ] ] = 0;
    }
    
    for ( i = 0; i < level.players.size ; i++ )
    {
        if ( ignorefriendlies && !player_utility::isenemy( level.players[ i ] ) )
        {
            continue;
        }
        
        if ( var_66933a12fdd7c8ce && level.players[ i ] == self )
        {
            continue;
        }
        
        if ( level.players[ i ].pers[ "team" ] == "spectator" )
        {
            continue;
        }
        
        if ( level.players[ i ].pers[ "team" ] == "codcaster" )
        {
            continue;
        }
        
        if ( isdefined( level.players[ i ].pers[ "team" ] ) )
        {
            assert( isdefined( player_counts[ level.players[ i ].pers[ "<dev string:x4a>" ] ] ) );
            player_counts[ level.players[ i ].pers[ "team" ] ]++;
        }
    }
    
    return player_counts;
}

// Namespace teams
// Params 0
// Checksum 0xf95ef062, Offset: 0x324d
// Size: 0x92
function function_128d91e02cacedfb()
{
    var_1226075bc9a19037 = countplayers( 1, 1 );
    var_83f234cc0e221932 = 0;
    
    foreach ( playercount in var_1226075bc9a19037 )
    {
        var_83f234cc0e221932 += playercount;
    }
    
    return var_83f234cc0e221932;
}

// Namespace teams
// Params 0
// Checksum 0x49b52516, Offset: 0x32e8
// Size: 0x8f
function function_68e0cbebe37134f()
{
    var_c6a26db16d5db50c = countplayers( 0 );
    activeplayers = 0;
    
    foreach ( playercount in var_c6a26db16d5db50c )
    {
        activeplayers += playercount;
    }
    
    return activeplayers;
}

// Namespace teams
// Params 1
// Checksum 0x43cda03e, Offset: 0x3380
// Size: 0x38, Type: bool
function function_1786864431d538bd( headmodelname )
{
    return headmodelname == "head_c_jup_mp_price_16b" || headmodelname == "head_c_jup_mp_ghost_16b" || headmodelname == "head_c_jup_mp_soap_14b" || headmodelname == "head_c_jup_mp_farah_13b";
}

// Namespace teams
// Params 1
// Checksum 0xa150b494, Offset: 0x33c1
// Size: 0x38, Type: bool
function function_8bf74811bcd0de19( headmodelname )
{
    return headmodelname == "head_c_jup_mp_price_16c" || headmodelname == "head_c_jup_mp_ghost_16c" || headmodelname == "head_c_jup_mp_soap_14c" || headmodelname == "head_c_jup_mp_farah_13c";
}

// Namespace teams
// Params 2
// Checksum 0x73197861, Offset: 0x3402
// Size: 0x50
function function_7c810013ad96976( var_64f5ced297bdc4b2, headmodelname )
{
    if ( getdvarint( @"hash_4753586a2ac8718f", 0 ) == 1 )
    {
        if ( function_1786864431d538bd( headmodelname ) )
        {
            return "body_c_jup_mp_voxel_medium_head";
        }
        else if ( function_8bf74811bcd0de19( headmodelname ) )
        {
            return "body_c_jup_mp_voxel_large_head";
        }
    }
    
    return var_64f5ced297bdc4b2;
}

// Namespace teams
// Params 3
// Checksum 0xa437deb3, Offset: 0x345b
// Size: 0x9d
function setcharactermodels( bodymodelname, headmodelname, viewmodelname )
{
    if ( isdefined( self.headmodel ) )
    {
        self detach( self.headmodel );
        self.headmodel = undefined;
    }
    
    if ( !isagent( self ) )
    {
        bodymodelname = self getcustomizationbody();
        bodymodelname = function_7c810013ad96976( bodymodelname, headmodelname );
        headmodelname = self getcustomizationhead();
        viewmodelname = self getcustomizationviewmodel();
    }
    
    self setmodel( bodymodelname );
    self setviewmodel( viewmodelname );
    
    if ( isdefined( headmodelname ) )
    {
        self attach( headmodelname, "", 1 );
        self.headmodel = headmodelname;
    }
}

// Namespace teams
// Params 0
// Checksum 0x9176a0ac, Offset: 0x3500
// Size: 0x69
function getcustomization()
{
    if ( isdefined( self.operatorcustomization ) )
    {
        return [ "head":self.operatorcustomization.head, "body":self.operatorcustomization.body ];
    }
    
    data = operator::getoperatorcustomization();
    return [ "head":data[ 1 ], "body":data[ 0 ] ];
}

// Namespace teams
// Params 0
// Checksum 0xcd881fb9, Offset: 0x3572
// Size: 0x80
function setmodelfromcustomization()
{
    assert( isdefined( self ) );
    assert( isplayer( self ) );
    operator::function_44f7d464da13e4f6( self.operatorcustomization.operatorref, self.operatorcustomization.skinref );
    bodymodelname = self getcustomizationbody();
    headmodelname = self getcustomizationhead();
    viewmodelname = self getcustomizationviewmodel();
    setcharactermodels( bodymodelname, headmodelname, viewmodelname );
}

// Namespace teams
// Params 0
// Checksum 0x82ea7d59, Offset: 0x35fa
// Size: 0x1b0
function setupplayermodel()
{
    if ( !isdefined( self.operatorcustomization ) )
    {
        println( "<dev string:x4f>" );
        operator::createoperatorcustomization();
    }
    
    setcharactermodels( self.operatorcustomization.defaultbody, self.operatorcustomization.defaulthead, self.operatorcustomization.defaultvm );
    
    if ( isdefined( self.operatorcustomization.suit ) && self.operatorcustomization.suit != "" )
    {
        player::_setsuit( self.operatorcustomization.suit );
    }
    
    if ( isdefined( self.operatorcustomization.reactiveoperator ) )
    {
        self function_184d7ec010cfaa92( self.operatorcustomization.reactiveoperator );
    }
    
    execution::_giveexecution( self.operatorcustomization.execution );
    execution::function_dd3185c009bb4693( "rex_execution_itsrainingmen" );
    
    if ( !isagent( self ) && !isbot( self ) && !isdefined( self.emotecustomization ) )
    {
        self.emotecustomization = emote::create_customization();
    }
    
    emote::giveemotes( self.emotecustomization );
    sprays::function_437b5f4224c76e05();
    
    if ( isdefined( self.operatorcustomization.parachute ) )
    {
        self setparachute( self.operatorcustomization.parachute );
    }
    
    if ( isdefined( self.operatorcustomization.contrail ) )
    {
        self setcontrail( self.operatorcustomization.contrail );
    }
}

/#

    // Namespace teams
    // Params 0
    // Checksum 0xdcd2bd6d, Offset: 0x37b2
    // Size: 0xba, Type: dev
    function playerconnectedtest()
    {
        if ( getdvarint( @"hash_ff213c5a6a5e05e4", 0 ) == 1 )
        {
            return;
        }
        
        level endon( #"exitlevel_called" );
        
        for ( ;; )
        {
            foreach ( player in level.players )
            {
                player getplayerdata( "<dev string:xba>", "<dev string:xc1>", "<dev string:xcf>", "<dev string:xdb>" );
            }
            
            wait 0.05;
        }
    }

    // Namespace teams
    // Params 1
    // Checksum 0x6209f1fc, Offset: 0x3874
    // Size: 0x31a, Type: dev
    function function_84495c37fb60e2c( operatorskin )
    {
        if ( !isxhashasset( operatorskin ) )
        {
            println( "<dev string:xde>" );
            return;
        }
        
        if ( !isbot( self ) )
        {
            println( "<dev string:xfc>" );
            return;
        }
        
        operatorref = operator::function_30f20ce375c4ee40( operatorskin );
        
        if ( !isdefined( operatorref ) )
        {
            println( "<dev string:x146>" );
            return;
        }
        
        self function_16332a7775f10aa9();
        self.operatorcustomization = undefined;
        operatorcustomization = spawnstruct();
        operatorcustomization.operatorref = operatorref;
        operatorcustomization.skinref = operatorskin;
        operatorcustomization.reactiveoperator = operator::getreactiveoperator( operatorskin );
        operatorcustomization.skinlootid = operator::function_c203df33ce95f84c( operatorskin );
        operatorcustomization.gender = operator::getoperatorgender( operatorref );
        operatorcustomization.voice = operator::getoperatorvoice( operatorref );
        operatorcustomization.clothtype = operator::function_b1788ccf1b3c0ae9( operatorskin );
        operatorcustomization.geartype = operator::function_d633420b529828e8( operatorskin );
        operatorcustomization.superfaction = operator::getoperatorsuperfaction( operatorref );
        operatorcustomization.execution = operator::function_4308bc9472e8e835();
        operatorcustomization.parachute = operator::function_e6885d5990982272();
        operatorcustomization.contrail = operator::function_4202dbfeb87e9ddb();
        operatorcustomization.dialogset = operator::function_bc6d8ad64545fc57( operatorref, operatorskin );
        
        if ( utility::issharedfuncdefined( #"bodysize", #"hash_db91c8d9ee604746" ) )
        {
            operatorcustomization.suit = utility::callsharedfunc( #"bodysize", #"hash_db91c8d9ee604746", operatorref );
        }
        else
        {
            operatorcustomization.suit = utility::function_f825237e0eda5adf( "<dev string:x16d>" );
        }
        
        operatorcustomization.rebuild = 0;
        operatorcustomization.chroma = operator::function_54b61a935e8d6ed2();
        self.operatorcustomization = operatorcustomization;
        customization = operator::getoperatorcustomization();
        body = customization[ 0 ];
        head = customization[ 1 ];
        viewmodel = customization[ 2 ];
        self function_d8a8c316c2436b4b( operatorskin, 1 );
        operator::function_44f7d464da13e4f6( operatorref, operatorskin );
        var_c44293a24579c8fb = self getcustomizationbody();
        var_65385198cd46487d = self getcustomizationhead();
        var_1595237faa50b3e8 = self getcustomizationviewmodel();
        
        if ( !level.projectbundle.var_672cd1b066200001 )
        {
            self setoperatorchroma( operatorcustomization.chroma );
        }
        
        self.operatorcustomization.body = body;
        self.operatorcustomization.defaultbody = var_c44293a24579c8fb;
        self.operatorcustomization.head = head;
        self.operatorcustomization.defaulthead = var_65385198cd46487d;
        self.operatorcustomization.vm = viewmodel;
        self.operatorcustomization.defaultvm = var_1595237faa50b3e8;
    }

#/

// Namespace teams
// Params 1
// Checksum 0x3e84f706, Offset: 0x3b96
// Size: 0x199
function getjointeampermissions( team )
{
    teamcount = 0;
    botcount = 0;
    players = level.players;
    
    for ( i = 0; i < players.size ; i++ )
    {
        player = players[ i ];
        
        if ( isdefined( player.pers[ "team" ] ) && player.pers[ "team" ] == team )
        {
            teamcount++;
            
            if ( isbot( player ) || istestclient( player ) )
            {
                botcount++;
            }
        }
    }
    
    if ( level.maxteamsize == 0 || teamcount < level.maxteamsize )
    {
        return 1;
    }
    
    if ( game_utility::getgametype() == "vip" && isagent( self ) )
    {
        return 1;
    }
    
    if ( botcount > 0 )
    {
        return 1;
    }
    
    if ( !game_utility_mp::matchmakinggame() )
    {
        return 1;
    }
    
    if ( level.gametypebundle.var_f5242bb1aa8222f8 )
    {
        return 1;
    }
    
    if ( game_utility_mp::function_de2aaa741c2234e7() )
    {
        return 1;
    }
    
    if ( isdefined( level.gametypebundle ) && level.gametypebundle.var_801e3fb6106e0ed2 )
    {
        return 1;
    }
    
    println( "<dev string:x16e>" + team + "<dev string:x196>" );
    analyticslog::function_89f9be132e3bd721( self );
    
    if ( self ishost() )
    {
        wait 1.5;
    }
    
    kick( self getentitynumber(), &"exe/playerkicked_invalidteam" );
    return 0;
}

// Namespace teams
// Params 1
// Checksum 0x3ad48837, Offset: 0x3d37
// Size: 0x79
function onplayerspawned( params )
{
    if ( !isdefined( self.pers[ "timePlayedOnFirstSpawn" ] ) )
    {
        self.pers[ "timePlayedOnFirstSpawn" ] = persistence::statgetchildbuffered( "round", "timePlayed" );
    }
    
    if ( getdvarint( @"scr_team_outlines", 0 ) == 1 && !game_utility_mp::runleanthreadmode() )
    {
        if ( squad_utility::issquadmode() )
        {
            thread outlinesquad_apply();
            return;
        }
        
        thread outlinefriendly_apply();
    }
}

// Namespace teams
// Params 0
// Checksum 0x90e55e11, Offset: 0x3db8
// Size: 0xbe
function outlinefriendly_apply()
{
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    
    if ( !level.teambased )
    {
        return;
    }
    
    if ( getdvarint( @"scr_friendly_outlines", 1 ) == 0 )
    {
        return;
    }
    
    if ( game_utility::function_d3f8957534dc62af() )
    {
        return;
    }
    
    if ( flags::gameflag( "infil_will_run" ) && !flags::gameflag( "prematch_done" ) )
    {
        level waittill( #"prematch_over" );
    }
    
    outlineasset = utility::isnightmap() ? "outline_ally_night" : "outline_ally";
    outlineid = outline::outlineenableforteam( self, self.team, outlineasset, "level_script" );
    thread outlinefriendly_remove( outlineid );
}

// Namespace teams
// Params 1
// Checksum 0xebed3de, Offset: 0x3e7e
// Size: 0x33
function outlinefriendly_remove( outlineid )
{
    level endon( #"game_ended" );
    utility::waittill_any( "death_or_disconnect", "joined_team" );
    outline::outlinedisable( outlineid, self );
}

// Namespace teams
// Params 0
// Checksum 0xe8aaf743, Offset: 0x3eb9
// Size: 0xd1
function outlinesquad_apply()
{
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    
    if ( game_utility_mp::runleanthreadmode() )
    {
        return;
    }
    
    if ( !level.teambased )
    {
        return;
    }
    
    if ( getdvarint( @"scr_squad_outlines", 1 ) == 0 )
    {
        return;
    }
    
    if ( game_utility::function_d3f8957534dc62af() )
    {
        return;
    }
    
    if ( flags::gameflag( "infil_will_run" ) && !flags::gameflag( "prematch_done" ) )
    {
        level waittill( #"prematch_over" );
    }
    
    outlineasset = utility::isnightmap() ? "outline_squad_night" : "outline_squad";
    outlineid = outline::outlineenableforsquad( self, self.team, self.sessionsquadid, outlineasset, "level_script" );
    thread outlinesquad_remove( outlineid );
}

// Namespace teams
// Params 1
// Checksum 0x6d3fe649, Offset: 0x3f92
// Size: 0x38
function outlinesquad_remove( outlineid )
{
    level endon( #"game_ended" );
    utility::waittill_any( "death_or_disconnect", "joined_team", "joined_squad" );
    outline::outlinedisable( outlineid, self );
}

// Namespace teams
// Params 0
// Checksum 0x9b90eb6f, Offset: 0x3fd2
// Size: 0x11c
function initnightvisionheadoverrides()
{
    if ( !utility::function_2a082dafe6f4bd5b() )
    {
        return;
    }
    
    level.nvgheadoverrides = [];
    
    foreach ( skinref in operator::function_27f5412663e0a09() )
    {
        head = operator::function_115f78fb5f506daa( skinref );
        nvgup = operator::function_4dcee1262a4ab410( skinref );
        nvgdown = operator::function_5c6e83213643805( skinref );
        
        if ( !isdefined( head ) || head == %"" )
        {
            break;
        }
        
        if ( nvgup != %"" )
        {
            level.nvgheadoverrides[ head ][ "up" ] = nvgup;
        }
        
        if ( nvgdown != %"" )
        {
            level.nvgheadoverrides[ head ][ "down" ] = nvgdown;
        }
    }
}

// Namespace teams
// Params 0
// Checksum 0x2628053b, Offset: 0x40f6
// Size: 0x148
function initheadlessoperatorcustomization()
{
    if ( isdefined( level.headlessoperatorcustomization ) )
    {
        return;
    }
    
    level.headlessoperatorcustomization = [];
    
    foreach ( skinref in operator::function_27f5412663e0a09() )
    {
        if ( operator::function_82781d300aee973e( skinref ) != "" )
        {
            operatorref = operator::function_30f20ce375c4ee40( skinref );
            
            if ( !isdefined( level.headlessoperatorcustomization[ operatorref ] ) )
            {
                level.headlessoperatorcustomization[ operatorref ][ "skinRefs" ] = [];
                level.headlessoperatorcustomization[ operatorref ][ "curIndex" ] = 0;
                level.headlessoperatorcustomization[ operatorref ][ "maxIndex" ] = 0;
            }
            
            level.headlessoperatorcustomization[ operatorref ][ "skinRefs" ][ level.headlessoperatorcustomization[ operatorref ][ "skinRefs" ].size ] = skinref;
            level.headlessoperatorcustomization[ operatorref ][ "maxIndex" ] = level.headlessoperatorcustomization[ operatorref ][ "maxIndex" ] + 1;
        }
    }
}

// Namespace teams
// Params 0
// Checksum 0x2bb776c4, Offset: 0x4246
// Size: 0xa5
function getplayerlookattarget()
{
    startpos = self geteye();
    viewangles = self getplayerangles();
    fwd = anglestoforward( viewangles );
    endpos = startpos + fwd * 10000;
    playercontent = [ "physicscontents_characterproxy" ];
    var_e1c801cb433b89d0 = physics_createcontents( playercontent );
    playertrace = trace::sphere_trace( startpos, endpos, 5, self, var_e1c801cb433b89d0, 0 );
    traceent = playertrace[ "entity" ];
    
    if ( isplayer( traceent ) )
    {
        return traceent;
    }
    
    return;
}

/#

    // Namespace teams
    // Params 0
    // Checksum 0x9837f735, Offset: 0x42f3
    // Size: 0x154, Type: dev
    function devmonitoroperatorcustomizationprint()
    {
        if ( getdvarint( @"nodebug", 0 ) >= 1 )
        {
            return;
        }
        
        setdevdvar( @"hash_a61d9425dd087ddf", 0 );
        setdevdvar( @"hash_e71bf09704d58aad", 0 );
        
        while ( true )
        {
            waitframe();
            players = [];
            
            if ( getdvarint( @"hash_a61d9425dd087ddf", 0 ) != 0 )
            {
                operator::function_99f3495eb915fb96();
                
                /#
                    setdevdvar( @"hash_e71bf09704d58aad", 0 );
                #/
                
                players = level.players;
            }
            
            if ( getdvarint( @"hash_e71bf09704d58aad", 0 ) != 0 )
            {
                operator::function_99f3495eb915fb96();
                
                /#
                    setdevdvar( @"hash_a61d9425dd087ddf", 0 );
                #/
                
                target = level.players[ 0 ] getplayerlookattarget();
                
                if ( !isdefined( target ) )
                {
                    continue;
                }
                
                players[ 0 ] = target;
            }
            
            if ( players.size > 0 )
            {
                foreach ( player in players )
                {
                    player printcustomization();
                }
            }
        }
    }

#/

// Namespace teams
// Params 0
// Checksum 0xba97dcd4, Offset: 0x444f
// Size: 0xaf
function printcustomization()
{
    if ( !team_utility::isgameplayteam( self.team ) )
    {
        return;
    }
    
    skincustomization = operator::getoperatorcustomization();
    
    /#
        print3d( self.origin + ( 0, 0, 40 ), "<dev string:x1f9>" + getxhashsourcename( skincustomization[ 0 ] ), ( 1, 1, 1 ), 1, 0.5 );
    #/
    
    /#
        print3d( self.origin + ( 0, 0, 60 ), "<dev string:x200>" + getxhashsourcename( skincustomization[ 1 ] ), ( 1, 1, 1 ), 1, 0.5 );
    #/
}

// Namespace teams
// Params 0
// Checksum 0x67c8a75e, Offset: 0x4506
// Size: 0x12c
function persistantgametypeteamassign()
{
    team = undefined;
    count = 1;
    
    if ( level.onlinegame )
    {
        fireteammembers = self getfireteammembers();
        count = fireteammembers.size;
        
        if ( isdefined( fireteammembers ) && fireteammembers.size > 0 )
        {
            foreach ( member in fireteammembers )
            {
                if ( isdefined( member ) && team_utility::isgameplayteam( member.team ) )
                {
                    team = member.team;
                    self.teamstarttime = member.teamstarttime;
                    break;
                }
            }
        }
    }
    
    if ( !isdefined( team ) )
    {
        team = findavailableteam( count );
    }
    
    assert( isdefined( team ) );
    
    if ( !isdefined( self.teamstarttime ) )
    {
        self.teamstarttime = gettime();
    }
    
    thread menus::setteam( team );
}

// Namespace teams
// Params 1
// Checksum 0xbe3e1093, Offset: 0x463a
// Size: 0x124
function findavailableteam( count = 1 )
{
    team = undefined;
    
    foreach ( entry in level.teamnamelist )
    {
        teamcount = getteamcount( entry );
        available = level.maxteamsize - teamcount;
        
        if ( available < count )
        {
            continue;
        }
        
        if ( teamcount > 0 )
        {
            teamplayers = getteamdata( entry, "players" );
            
            if ( isdefined( teamplayers[ 0 ].teamstarttime ) && gettime() > teamplayers[ 0 ].teamstarttime + 300000 )
            {
                continue;
            }
        }
        
        team = entry;
        break;
    }
    
    assert( isdefined( team ) );
    return team;
}

// Namespace teams
// Params 0
// Checksum 0x20ba3a51, Offset: 0x4767
// Size: 0x8e
function function_fc8bf4b0a548b5b4()
{
    teamcount = 0;
    
    foreach ( teamdata in level.teamdata )
    {
        if ( teamdata[ "teamCount" ] > 0 )
        {
            teamcount++;
        }
    }
    
    return teamcount;
}

// Namespace teams
// Params 0
// Checksum 0xdfcab9cd, Offset: 0x47fe
// Size: 0x8e
function function_18d385169c56c91a()
{
    teamcount = 0;
    
    foreach ( teamdata in level.teamdata )
    {
        if ( teamdata[ "aliveCount" ] > 0 )
        {
            teamcount++;
        }
    }
    
    return teamcount;
}

// Namespace teams
// Params 0
// Checksum 0xcff43003, Offset: 0x4895
// Size: 0x23
function getactiveteamcount()
{
    if ( getdvarint( @"hash_f0c6ae2c0c06dc57", 0 ) )
    {
        return function_18d385169c56c91a();
    }
    
    return level.var_227b8a3a9c083621;
}

// Namespace teams
// Params 1
// Checksum 0x30c399ba, Offset: 0x48c1
// Size: 0xc6
function function_ca2fe741546df07d( team )
{
    if ( !( isdefined( team ) && isdefined( level.teamdata[ team ][ "players" ] ) ) )
    {
        return;
    }
    
    var_a6513b89dda8e099 = 0;
    
    foreach ( player in getteamdata( team, "players" ) )
    {
        if ( player::isreallyalive( player ) )
        {
            var_a6513b89dda8e099 += player.health;
        }
    }
    
    return var_a6513b89dda8e099;
}

/#

    // Namespace teams
    // Params 0
    // Checksum 0xae3f7786, Offset: 0x4990
    // Size: 0x288, Type: dev
    function debugprintteams()
    {
        stepy = 25;
        
        while ( true )
        {
            if ( getdvarint( @"scr_debug_teams", 0 ) == 0 )
            {
                waitframe();
                continue;
            }
            
            if ( isdefined( level.teamdata ) )
            {
                startx = 400;
                starty = 200;
                linecount = 1;
                teamcount = 0;
                
                foreach ( team in level.teamnamelist )
                {
                    linecount = 1;
                    
                    if ( level.multimatch ?? gameinstance::is_enabled() )
                    {
                        instanceid = gameinstance::get_instance_id( team );
                        printtoscreen2d( startx, starty + stepy * linecount, "<dev string:x207>" + instanceid + "<dev string:x209>" + team, ( 1, 1, 1 ), 1 );
                    }
                    else
                    {
                        printtoscreen2d( startx, starty + stepy * linecount, "<dev string:x211>" + team, ( 1, 1, 1 ), 1 );
                    }
                    
                    linecount++;
                    
                    foreach ( player in level.teamdata[ team ][ "<dev string:x218>" ] )
                    {
                        color = ( 1, 1, 1 );
                        
                        if ( player.squadassignedfromlobby )
                        {
                            color = ( 0, 1, 0 );
                        }
                        
                        printtoscreen2d( startx + 25, starty + stepy * linecount, player.name, color, 1 );
                        linecount++;
                        print3d( player.origin + ( 0, 0, 60 ), team, ( 1, 1, 1 ), 1, 0.5 );
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
            }
            
            waitframe();
        }
    }

#/
