// scripts\mp\scoreboard.gsc  (hash_16617de231bf5280.gscc) (size: 10607 Bytes / 0x296f / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x319d1224 (832377380)
// size ...... 10607 (0x296f)
// includes .. 8   (offset: 0x2163)
// strings ... 73  (offset: 0x21a3)
// dev strs .. 33  (offset: 0x2727)
// exports ... 7   (offset: 0x1ae3)
// cseg ...... 0x402 + 0x16e1 (0x1ae3)
// imports ... 33  (offset: 0x1bfb)
// animtree1 . 0   (offset: 0x296f)
// animtree2 . 0   (offset: 0x296f)
#using script_7cab86232cdd30ba;
#using scripts\common\progression_utility;
#using scripts\common\utility;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\team_utility;
#using scripts\mp\common\utility\teams;
#using scripts\mp\gamelogic;

#namespace scoreboard;

// Namespace scoreboard
// Params 0
// Checksum 0xb8d77490, Offset: 0x420
// Size: 0x82
function processlobbyscoreboards()
{
    processmatchscoreboardinfo();
    
    foreach ( player in level.players )
    {
        processcommonplayerdataforplayer( player );
    }
}

// Namespace scoreboard
// Params 0
// Checksum 0x267f813f, Offset: 0x4aa
// Size: 0x655
function processmatchscoreboardinfo()
{
    if ( level.multiteambased )
    {
        buildscoreboardtype( "multiteam" );
        
        foreach ( player in level.players )
        {
            player setplayerdata( "common", "round", "scoreboardType", "multiteam" );
        }
        
        alliesscore = getteamscore( "allies" );
        axisscore = getteamscore( "axis" );
        team3score = getteamscore( "team_three" );
        bestteams = function_e8bed8b1d717999e();
        
        if ( getdvarint( @"online_mp_clientmatchdata_enabled" ) != 0 )
        {
            setclientmatchdata( "alliesScore", alliesscore );
            setclientmatchdata( "axisScore", axisscore );
            setclientmatchdata( "team3Score", team3score );
            
            if ( bestteams.size >= 2 )
            {
                setclientmatchdata( "bestTeams", 0, bestteams[ 0 ] );
                setclientmatchdata( "bestTeams", 1, bestteams[ 1 ] );
            }
            
            setclientmatchdata( "scoreProgressLimit", getomnvar( "ui_scorelimit" ) );
            setclientmatchdata( "alliesKills", -1 );
            setclientmatchdata( "alliesDeaths", -1 );
        }
        
        return;
    }
    
    if ( level.teambased )
    {
        alliesscore = getteamscore( "allies" );
        axisscore = getteamscore( "axis" );
        kills = 0;
        deaths = 0;
        
        foreach ( player in level.players )
        {
            if ( isdefined( player.pers[ "team" ] ) && player.pers[ "team" ] == "allies" )
            {
                kills += player.pers[ "kills" ];
                deaths += player.pers[ "deaths" ];
            }
        }
        
        winner = "tie";
        
        if ( game_utility_mp::inovertime() )
        {
            if ( game_utility_mp::istimetobeatrulegametype() )
            {
                if ( game[ "timeToBeatTeam" ] == "none" )
                {
                    if ( getdvarint( @"online_mp_clientmatchdata_enabled" ) != 0 )
                    {
                        setclientmatchdata( "alliesTTB", 0 );
                        setclientmatchdata( "axisTTB", 0 );
                    }
                    
                    winner = "tie";
                }
                else
                {
                    if ( "allies" == game[ "timeToBeatTeam" ] )
                    {
                        alliesscore++;
                    }
                    else
                    {
                        axisscore++;
                    }
                    
                    if ( getdvarint( @"online_mp_clientmatchdata_enabled" ) != 0 )
                    {
                        setclientmatchdata( "alliesTTB", "allies" == game[ "timeToBeatTeam" ] ? game[ "timeToBeat" ] : game[ "timeToBeatOld" ] );
                        setclientmatchdata( "axisTTB", "axis" == game[ "timeToBeatTeam" ] ? game[ "timeToBeat" ] : game[ "timeToBeatOld" ] );
                    }
                    
                    winner = game[ "timeToBeatTeam" ];
                }
            }
            else if ( game_utility_mp::isscoretobeatrulegametype() )
            {
            }
        }
        else if ( alliesscore == axisscore )
        {
            winner = "tie";
        }
        else if ( alliesscore > axisscore )
        {
            winner = "allies";
        }
        else
        {
            winner = "axis";
        }
        
        if ( getdvarint( @"online_mp_clientmatchdata_enabled" ) != 0 )
        {
            setclientmatchdata( "alliesScore", alliesscore );
            setclientmatchdata( "axisScore", axisscore );
            setclientmatchdata( "scoreProgressLimit", getomnvar( "ui_scorelimit" ) );
            setclientmatchdata( "alliesKills", kills );
            setclientmatchdata( "alliesDeaths", deaths );
        }
        
        if ( winner == "tie" )
        {
            buildscoreboardtype( "allies" );
            buildscoreboardtype( "axis" );
            
            foreach ( player in level.players )
            {
                player_pers_team = player.pers[ "team" ];
                
                if ( !isdefined( player_pers_team ) )
                {
                    continue;
                }
                
                if ( player_pers_team == "spectator" || player_pers_team == "codcaster" )
                {
                    player setplayerdata( "common", "round", "scoreboardType", "allies" );
                    continue;
                }
                
                player setplayerdata( "common", "round", "scoreboardType", player_pers_team );
            }
        }
        else
        {
            buildscoreboardtype( winner );
            
            foreach ( player in level.players )
            {
                player setplayerdata( "common", "round", "scoreboardType", winner );
            }
        }
        
        return;
    }
    
    buildscoreboardtype( "neutral" );
    
    foreach ( player in level.players )
    {
        player setplayerdata( "common", "round", "scoreboardType", "neutral" );
    }
    
    if ( getdvarint( @"online_mp_clientmatchdata_enabled" ) != 0 )
    {
        setclientmatchdata( "alliesScore", -1 );
        setclientmatchdata( "axisScore", -1 );
        setclientmatchdata( "scoreProgressLimit", getomnvar( "ui_scorelimit" ) );
        setclientmatchdata( "alliesKills", -1 );
        setclientmatchdata( "alliesDeaths", -1 );
    }
}

// Namespace scoreboard
// Params 1
// Checksum 0x7c9841a9, Offset: 0xb07
// Size: 0x1e2
function processcommonplayerdataforplayer( player )
{
    var_2e968dba33cd6d79 = player.pers[ "summary" ];
    
    if ( isdefined( var_2e968dba33cd6d79 ) )
    {
        player setplayerdata( "common", "round", "totalXp", var_2e968dba33cd6d79[ "xp" ] );
        player setplayerdata( "common", "round", "scoreXp", var_2e968dba33cd6d79[ "score" ] );
        player setplayerdata( "common", "round", "challengeXp", var_2e968dba33cd6d79[ "challenge" ] );
        player setplayerdata( "common", "round", "matchXp", var_2e968dba33cd6d79[ "match" ] );
        player setplayerdata( "common", "round", "miscXp", var_2e968dba33cd6d79[ "misc" ] );
        player setplayerdata( "common", "round", "medalXp", var_2e968dba33cd6d79[ "medal" ] );
        player setplayerdata( "common", "common_entitlement_xp", var_2e968dba33cd6d79[ "bonusXP" ] );
    }
    
    var_5211a9a127c514b9 = player.pers[ "aarData" ];
    
    if ( isdefined( var_5211a9a127c514b9 ) )
    {
        player setplayerdata( "common", "round", "aarData", "combat_xp", var_5211a9a127c514b9[ "combat_xp" ] );
        player setplayerdata( "common", "round", "aarData", "support_xp", var_5211a9a127c514b9[ "support_xp" ] );
        player setplayerdata( "common", "round", "aarData", "strategy_xp", var_5211a9a127c514b9[ "strategy_xp" ] );
        player setplayerdata( "common", "round", "aarData", "logistics_xp", var_5211a9a127c514b9[ "logistics_xp" ] );
        player setplayerdata( "common", "round", "aarData", "recon_xp", var_5211a9a127c514b9[ "recon_xp" ] );
        player setplayerdata( "common", "round", "aarData", "use_featured_operator_skin_xp", var_5211a9a127c514b9[ "use_featured_operator_skin_xp" ] );
    }
}

// Namespace scoreboard
// Params 0
// Checksum 0xd4948b4c, Offset: 0xcf1
// Size: 0x8ab
function setplayerscoreboardinfo()
{
    if ( getdvarint( @"online_mp_clientmatchdata_enabled" ) == 0 )
    {
        return;
    }
    
    scoreboardplayercount = getclientmatchdata( "scoreboardPlayerCount" );
    
    if ( scoreboardplayercount < 200 )
    {
        utility::callsharedfunc( #"gametype", #"hash_344ee3ce3711e38c" );
        score = self.pers[ "score" ];
        
        if ( isdefined( score ) )
        {
            setclientmatchdata( "players", self.clientmatchdataid, "score", score );
            println( "<dev string:x24>" + self.name + "<dev string:x32>" + self.clientmatchdataid + "<dev string:x34>" + score );
        }
        
        kills = self.pers[ "kills" ];
        
        if ( isdefined( kills ) )
        {
            setclientmatchdata( "players", self.clientmatchdataid, "kills", kills );
            println( "<dev string:x24>" + self.name + "<dev string:x32>" + self.clientmatchdataid + "<dev string:x40>" + kills );
        }
        
        if ( game_utility::getgametype() == "dm" || game_utility::getgametype() == "gun" )
        {
            assists = self.assists;
        }
        else
        {
            assists = self.pers[ "assists" ] ?? 0;
        }
        
        setclientmatchdata( "players", self.clientmatchdataid, "assists", assists );
        println( "<dev string:x24>" + self.name + "<dev string:x32>" + self.clientmatchdataid + "<dev string:x4c>" + assists );
        deaths = self.pers[ "deaths" ];
        
        if ( isdefined( deaths ) )
        {
            setclientmatchdata( "players", self.clientmatchdataid, "deaths", deaths );
            println( "<dev string:x24>" + self.name + "<dev string:x32>" + self.clientmatchdataid + "<dev string:x5a>" + deaths );
        }
        
        team = self.pers[ "team" ];
        
        if ( isdefined( team ) )
        {
            setclientmatchdata( "players", self.clientmatchdataid, "team", team );
            println( "<dev string:x24>" + self.name + "<dev string:x32>" + self.clientmatchdataid + "<dev string:x67>" + team );
            faction = game[ team ];
            
            if ( isdefined( faction ) )
            {
                setclientmatchdata( "players", self.clientmatchdataid, "faction", faction );
                println( "<dev string:x24>" + self.name + "<dev string:x32>" + self.clientmatchdataid + "<dev string:x72>" + faction );
            }
        }
        
        extrascore0 = self.pers[ "extrascore0" ];
        
        if ( isdefined( extrascore0 ) )
        {
            setclientmatchdata( "players", self.clientmatchdataid, "extrascore0", extrascore0 );
            println( "<dev string:x24>" + self.name + "<dev string:x32>" + self.clientmatchdataid + "<dev string:x80>" + extrascore0 );
        }
        
        extrascore1 = self.pers[ "extrascore1" ];
        
        if ( isdefined( extrascore1 ) )
        {
            setclientmatchdata( "players", self.clientmatchdataid, "extrascore1", extrascore1 );
            println( "<dev string:x24>" + self.name + "<dev string:x32>" + self.clientmatchdataid + "<dev string:x92>" + extrascore1 );
        }
        
        extrascore2 = self.pers[ "extrascore2" ];
        
        if ( isdefined( extrascore2 ) )
        {
            setclientmatchdata( "players", self.clientmatchdataid, "extrascore2", extrascore2 );
            println( "<dev string:x24>" + self.name + "<dev string:x32>" + self.clientmatchdataid + "<dev string:xa4>" + extrascore2 );
        }
        
        extrascore3 = self.pers[ "extrascore3" ];
        
        if ( isdefined( extrascore3 ) )
        {
            setclientmatchdata( "players", self.clientmatchdataid, "extrascore3", extrascore3 );
            println( "<dev string:x24>" + self.name + "<dev string:x32>" + self.clientmatchdataid + "<dev string:xb6>" + extrascore3 );
        }
        
        extrascore4 = self.pers[ "extrascore4" ];
        
        if ( isdefined( extrascore4 ) )
        {
            setclientmatchdata( "players", self.clientmatchdataid, "extrascore4", extrascore4 );
            println( "<dev string:x24>" + self.name + "<dev string:x32>" + self.clientmatchdataid + "<dev string:xc8>" + extrascore4 );
        }
        
        extrascore5 = self.pers[ "extrascore5" ];
        
        if ( isdefined( extrascore5 ) )
        {
            setclientmatchdata( "players", self.clientmatchdataid, "extrascore5", extrascore5 );
            println( "<dev string:x24>" + self.name + "<dev string:x32>" + self.clientmatchdataid + "<dev string:xda>" + extrascore5 );
        }
        
        timeplayed = self.timeplayed[ "total" ];
        
        if ( isdefined( timeplayed ) )
        {
            setclientmatchdata( "players", self.clientmatchdataid, "timeplayed", timeplayed );
            println( "<dev string:x24>" + self.name + "<dev string:x32>" + self.clientmatchdataid + "<dev string:xec>" + timeplayed );
        }
        
        if ( isdefined( self.pers[ "rank" ] ) && isdefined( self.pers[ "rankxp" ] ) )
        {
            rank = progression_utility::getrank();
            setclientmatchdata( "players", self.clientmatchdataid, "rank", rank );
            println( "<dev string:x24>" + self.name + "<dev string:x32>" + self.clientmatchdataid + "<dev string:xfd>" + rank );
        }
        
        if ( isdefined( self.pers[ "prestige" ] ) )
        {
            prestige = player_progression_achievements::getprestige() ?? 0;
            setclientmatchdata( "players", self.clientmatchdataid, "prestige", prestige );
            println( "<dev string:x24>" + self.name + "<dev string:x32>" + self.clientmatchdataid + "<dev string:x108>" + prestige );
        }
        
        if ( level.gamemodebundle.var_ef398d9e813bb617 )
        {
            objectivescore = self.pers[ "objectivescore" ];
            
            if ( isdefined( objectivescore ) )
            {
                setclientmatchdata( "players", self.clientmatchdataid, "objectivescore", objectivescore );
                println( "<dev string:x24>" + self.name + "<dev string:x32>" + self.clientmatchdataid + "<dev string:x117>" + objectivescore );
            }
        }
        
        if ( isbrgamemode() )
        {
            if ( getdvarint( @"hash_3858ec934530a99c", 0 ) )
            {
                var_980c24122fde5a88 = [];
                
                if ( utility::issharedfuncdefined( #"br", #"hash_665b0dffeda837cd" ) )
                {
                    var_980c24122fde5a88 = [[ utility::getsharedfunc( #"br", #"hash_665b0dffeda837cd" ) ]]( self );
                }
                
                assert( var_980c24122fde5a88.size < 5 );
                
                for ( i = 0; i < var_980c24122fde5a88.size ; i++ )
                {
                    var_8efefcbb9da52469 = "extrascore" + i;
                    setclientmatchdata( "players", self.clientmatchdataid, var_8efefcbb9da52469, var_980c24122fde5a88[ i ] );
                    println( "<dev string:x24>" + self.name + "<dev string:x32>" + self.clientmatchdataid + "<dev string:x12c>" + var_8efefcbb9da52469 + "<dev string:x130>" + var_980c24122fde5a88[ i ] );
                }
            }
            
            utility::callsharedfunc( #"gametype", #"packclientmatchdata" );
        }
        
        println( "<dev string:x134>" + scoreboardplayercount );
        
        if ( !isdefined( self.overwritematchdata ) )
        {
            scoreboardplayercount++;
        }
        
        setclientmatchdata( "scoreboardPlayerCount", scoreboardplayercount );
        println( "<dev string:x15b>" + scoreboardplayercount );
        maxplayercount = getdvarint( @"party_maxplayers", 0 );
        setclientmatchdata( "maxPlayerCount", maxplayercount );
        return;
    }
    
    println( "<dev string:x182>" + scoreboardplayercount + "<dev string:x1c5>" );
}

// Namespace scoreboard
// Params 2
// Checksum 0x9f90834, Offset: 0x15a4
// Size: 0x6d
function computescoreboardslot( team, index )
{
    if ( team == "none" )
    {
        return ( 0 + index );
    }
    
    if ( team == "neutral" )
    {
        return ( 200 + index );
    }
    
    if ( team == "allies" )
    {
        return ( 400 + index );
    }
    
    if ( team == "axis" )
    {
        return ( 600 + index );
    }
    
    if ( team == "multiteam" )
    {
        return ( 800 + index );
    }
    
    return 0;
}

// Namespace scoreboard
// Params 1
// Checksum 0xb47e4ce9, Offset: 0x161a
// Size: 0x4c9
function buildscoreboardtype( team )
{
    if ( getdvarint( @"online_mp_clientmatchdata_enabled" ) == 0 )
    {
        return;
    }
    
    assert( team == "<dev string:x1c7>" || team == "<dev string:x1ce>" || team == "<dev string:x1d3>" || team == "<dev string:x1db>" );
    println( "<dev string:x1e5>" + team + "<dev string:x1c5>" );
    
    if ( team == "multiteam" || game_utility::getgametype() == "clash" || teams::squadasteamenabled() )
    {
        index = 0;
        
        foreach ( teamname in level.teamnamelist )
        {
            teammembers = undefined;
            
            if ( isdefined( level.placement ) )
            {
                teammembers = level.placement[ teamname ];
            }
            
            if ( !isdefined( teammembers ) )
            {
                teammembers = teams::getteamdata( teamname, "players" );
            }
            
            foreach ( player in teammembers )
            {
                if ( isdefined( player ) && isdefined( player.clientmatchdataid ) )
                {
                    gamelogic_mp::assignclientmatchdataid( player );
                    setclientmatchdata( "scoreboards", computescoreboardslot( team, index ), player.clientmatchdataid );
                    println( "<dev string:x207>" + team + "<dev string:x222>" + index + "<dev string:x222>" + player.clientmatchdataid + "<dev string:x225>" );
                }
                
                index++;
            }
        }
        
        return;
    }
    
    if ( team == "neutral" )
    {
        index = 0;
        
        foreach ( player in level.placement[ "all" ] )
        {
            if ( isdefined( player.clientmatchdataid ) )
            {
                setclientmatchdata( "scoreboards", computescoreboardslot( team, index ), player.clientmatchdataid );
                println( "<dev string:x207>" + team + "<dev string:x222>" + index + "<dev string:x222>" + player.clientmatchdataid + "<dev string:x225>" );
            }
            
            index++;
        }
        
        return;
    }
    
    otherteam = team_utility::getotherteam( team );
    index = 0;
    
    foreach ( player in level.placement[ team ] )
    {
        if ( isdefined( player.clientmatchdataid ) )
        {
            setclientmatchdata( "scoreboards", computescoreboardslot( team, index ), player.clientmatchdataid );
            println( "<dev string:x207>" + team + "<dev string:x222>" + index + "<dev string:x222>" + player.name + "<dev string:x32>" + player.clientmatchdataid + "<dev string:x227>" );
        }
        
        index++;
    }
    
    foreach ( player in level.placement[ otherteam ] )
    {
        if ( isdefined( player.clientmatchdataid ) )
        {
            setclientmatchdata( "scoreboards", computescoreboardslot( team, index ), player.clientmatchdataid );
            println( "<dev string:x207>" + team + "<dev string:x222>" + index + "<dev string:x222>" + player.name + "<dev string:x32>" + player.clientmatchdataid + "<dev string:x227>" );
        }
        
        index++;
    }
}

