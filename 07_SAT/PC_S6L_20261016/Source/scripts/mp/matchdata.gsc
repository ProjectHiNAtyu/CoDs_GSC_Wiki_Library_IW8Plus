// scripts\mp\matchdata.gsc  (hash_6fefaca85ccc3691.gscc) (size: 8570 Bytes / 0x217a / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x4f62297c (1331833212)
// size ...... 8570 (0x217a)
// includes .. 9   (offset: 0x1db6)
// strings ... 56  (offset: 0x1dfe)
// dev strs .. 5   (offset: 0x213e)
// exports ... 23  (offset: 0x127e)
// cseg ...... 0x3d5 + 0xea9 (0x127e)
// imports ... 64  (offset: 0x1616)
// animtree1 . 0   (offset: 0x217a)
// animtree2 . 0   (offset: 0x217a)
#using scripts\common\progression_utility;
#using scripts\common\utility;
#using scripts\common\weapon;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\weapon;
#using scripts\mp\gamelogic;
#using scripts\mp\rank;
#using scripts\mp\weaponrank;

#namespace matchdata;

// Namespace matchdata
// Params 0
// Checksum 0x434d0b66, Offset: 0x3f3
// Size: 0x226
function init()
{
    if ( getdvarint( @"online_matchdata_enabled" ) != 0 && !isdefined( game[ "gamestarted" ] ) )
    {
        function_93240747a1cb691e();
        setmatchdata( "commonMatchData", "map", level.script );
        
        if ( game_utility::function_ae97372c83da7acc() )
        {
            tmp = game_utility::getgametype() + " hc";
            setmatchdata( "commonMatchData", "gametype", tmp );
        }
        else
        {
            setmatchdata( "commonMatchData", "gametype", game_utility::getgametype() );
        }
        
        setmatchdata( "commonMatchData", "build_version", getbuildversion() );
        setmatchdata( "commonMatchData", "build_number", getbuildnumber() );
        setmatchdata( "commonMatchData", "is_private_match", game_utility_mp::privatematch() );
        setmatchdata( "firstOvertimeRoundIndex", -1 );
        
        if ( game_utility_mp::ismlgmatch() )
        {
            setmatchdata( "codESportsRules", 1 );
        }
    }
    
    if ( getdvarint( @"online_matchdata_enabled" ) != 0 )
    {
        if ( isbrgamemode() )
        {
            level.maxlogclients = 200;
        }
        else
        {
            level.maxlogclients = 30;
        }
    }
    else
    {
        level.maxlogclients = 0;
    }
    
    level.maxlives = 475;
    level.maxnamelength = 26;
    level.maxgameevents = 250;
    level.maxkillstreaks = 64;
    level.maxkillstreaksavailable = 64;
    level.maxnumchallengesperplayer = 10;
    level.maxnumawardsperplayer = 10;
    level.maxsupersavailable = 50;
    level.maxsupersactivated = 50;
    level.maxsupersexpired = 50;
    level.matchdata_onroundend = &onroundend;
    level.matchdata_logkillstreakevent = &logkillstreakevent;
    level.matchdata_logattackerkillevent = &logattackerkillevent;
    level.matchdata_logvictimkillevent = &logvictimkillevent;
    level.matchdata_logmultikill = &logmultikill;
    level.matchdata_logplayerdata = &logplayerdata;
    level.matchdata_recordrecentlyplayeddata = &recordrecentlyplayeddata;
    level.matchdata_buildweaponrootlist = &weapon::buildweaponrootlist;
    level.matchdata_logchallenge = &logchallenge;
    level.matchdata_logaward = &logaward;
    level thread endofgamesummarylogger();
}

// Namespace matchdata
// Params 0
// Checksum 0xe9addb97, Offset: 0x621
// Size: 0x68
function onroundend()
{
    level.endtimeutcseconds = getsystemtime();
    setmatchdata( "commonMatchData", "utc_end_time_s", level.endtimeutcseconds );
    setmatchdata( "commonMatchData", "player_count_end", level.players.size );
    setmatchdata( "globalPlayerXpModifier", int( rank::getglobalrankxpmultiplier() ) );
    setmatchdata( "globalWeaponXpModifier", int( weaponrank::getglobalweaponrankxpmultiplier() ) );
}

// Namespace matchdata
// Params 0
// Checksum 0x2a37010f, Offset: 0x691
// Size: 0x2c
function getmatchstarttimeutc()
{
    if ( getdvarint( @"online_matchdata_enabled" ) == 0 )
    {
        return level.starttimeutcseconds;
    }
    
    return getmatchdata( "commonMatchData", "utc_start_time_s" );
}

// Namespace matchdata
// Params 0
// Checksum 0xc86489df, Offset: 0x6c6
// Size: 0x2c
function getmatchendtimeutc()
{
    if ( getdvarint( @"online_matchdata_enabled" ) == 0 )
    {
        return level.endtimeutcseconds;
    }
    
    return getmatchdata( "commonMatchData", "utc_end_time_s" );
}

// Namespace matchdata
// Params 1
// Checksum 0xf0074def, Offset: 0x6fb
// Size: 0x47
function gettimefrommatchstart( basetime )
{
    timefrom = basetime;
    
    if ( isdefined( level.starttimefrommatchstart ) )
    {
        timefrom -= level.starttimefrommatchstart;
        
        if ( timefrom < 0 )
        {
            timefrom = 0;
        }
    }
    else
    {
        timefrom = 0;
    }
    
    return timefrom;
}

// Namespace matchdata
// Params 1
// Checksum 0x1da4fed0, Offset: 0x74b
// Size: 0x43
function function_47550968a937b67e( basetime )
{
    timefrom = basetime;
    
    if ( isdefined( game[ "startTimeFromMatchStart" ] ) )
    {
        timefrom -= game[ "startTimeFromMatchStart" ];
        
        if ( timefrom < 0 )
        {
            timefrom = 0;
        }
    }
    else
    {
        timefrom = 0;
    }
    
    return timefrom;
}

// Namespace matchdata
// Params 2
// Checksum 0x90c9febd, Offset: 0x797
// Size: 0x22
function logkillstreakevent( event, position )
{
    println( "<dev string:x24>" );
}

// Namespace matchdata
// Params 2
// Checksum 0x4c4064ab, Offset: 0x7c1
// Size: 0x22
function logattackerkillevent( lifeid, eventref )
{
    println( "<dev string:x71>" );
}

// Namespace matchdata
// Params 2
// Checksum 0x1c396917, Offset: 0x7eb
// Size: 0x22
function logvictimkillevent( lifeid, eventref )
{
    println( "<dev string:xdc>" );
}

// Namespace matchdata
// Params 2
// Checksum 0x43f9299c, Offset: 0x815
// Size: 0x22
function logmultikill( lifeid, multikillcount )
{
    println( "<dev string:x145>" );
}

// Namespace matchdata
// Params 0
// Checksum 0x798d9fe1, Offset: 0x83f
// Size: 0x59
function monitorweaponfire()
{
    self endon( #"death_or_disconnect" );
    
    while ( true )
    {
        self waittill( #"begin_firing" );
        thread monitorweaponfiretime();
        weaponobj = self.lastdroppableweaponobj;
        weaponobj = weapon::mapweapon( weaponobj );
        thread gamelogic_mp::threadedsetweaponstatbyname( weaponobj, 1, "trigger_pulls" );
    }
}

// Namespace matchdata
// Params 0
// Checksum 0x88ac394f, Offset: 0x8a0
// Size: 0x51
function monitorweaponfiretime()
{
    self endon( #"disconnect" );
    self.lastweaponfiretimestart = gettime();
    self notify( #"hash_e4a084059c35a660" );
    self endon( #"hash_e4a084059c35a660" );
    utility::waittill_any( "end_firing", "death" );
    self.lastweaponfiretimeend = gettime();
}

// Namespace matchdata
// Params 0
// Checksum 0xd39edd23, Offset: 0x8f9
// Size: 0x132
function ctgs_recordmatchstats()
{
    if ( !game_utility_mp::onlinestatsenabled() )
    {
        return;
    }
    
    if ( !game_utility_mp::rankingenabled() )
    {
        return;
    }
    
    if ( !self hasplayerdata() )
    {
        return;
    }
    
    gamemode = game_utility::getgametype();
    kills = self.pers[ "kills" ];
    deaths = self.pers[ "deaths" ];
    headshots = self.pers[ "headshots" ];
    assists = self.pers[ "assists" ];
    suicides = self.pers[ "suicides" ];
    score = self.pers[ "score" ];
    rankxp = rank::getrankxp();
    rank = progression_utility::getrankforxp( rankxp );
    timejoined = self.pers[ "telemetry" ].utc_connect_time_s;
    timeplayed = getsystemtime() - timejoined;
    self ctgsreportusermatchstats( gamemode, kills, deaths, headshots, assists, suicides, score, rank, timeplayed );
}

// Namespace matchdata
// Params 1
// Checksum 0x35a4b7b4, Offset: 0xa33
// Size: 0x387
function logplayerdata( disconnectreason )
{
    if ( !isvalidclient( self ) )
    {
        return;
    }
    
    ctgs_recordmatchstats();
    self sendclientnetworktelemetry();
    self sendcollectedclientanticheatdata();
    
    if ( isbrgamemode() )
    {
        return;
    }
    
    shots = 0;
    hits = 0;
    
    foreach ( datastruct in self.pers[ "matchdataWeaponStats" ] )
    {
        var_94aede646cebd2fb = 0;
        var_870dd3794e5989b8 = 0;
        vardeaths = 0;
        varheadshots = 0;
        varhits = 0;
        varkills = 0;
        var_f65c04dd6e632638 = 0;
        varshots = 0;
        vartimeused = 0;
        vardamage = 0;
        varfriendlydamage = 0;
        
        if ( isenumvaluevalid( "common", "LoadoutWeapon", datastruct.weapon ) )
        {
            var_94aede646cebd2fb = self getplayerdata( level.loadoutsgroup, "squadMembers", "weapon_xp", datastruct.weapon );
        }
        
        foreach ( statname, value in datastruct.stats )
        {
            if ( statname == "deaths" )
            {
                vardeaths += value;
            }
            
            if ( statname == "headshots" )
            {
                varheadshots += value;
            }
            
            if ( statname == "hits" )
            {
                varhits += value;
                hits += value;
            }
            
            if ( statname == "ads_kills" )
            {
                var_f65c04dd6e632638 += value;
            }
            
            if ( statname == "kills" )
            {
                varkills += value;
            }
            
            if ( statname == "shots" )
            {
                varshots += value;
                shots += value;
            }
            
            if ( statname == "xp_earned" )
            {
                var_870dd3794e5989b8 += value;
            }
            
            if ( statname == "damage" )
            {
                vardamage += value;
            }
            
            if ( statname == "friendly_fire_damage" )
            {
                varfriendlydamage += value;
            }
        }
        
        self dlog_recordplayerevent( "dlog_event_mp_player_weapon_stats", [ "weapon", datastruct.weapon, "variant_id", datastruct.variantid, "loadout_index", datastruct.loadoutindex, "starting_weapon_xp", var_94aede646cebd2fb, "xp_earned", var_870dd3794e5989b8, "deaths", vardeaths, "headshots", varheadshots, "hits", varhits, "kills", varkills, "ads_kills", var_f65c04dd6e632638, "shots", varshots, "timeUsed", vartimeused, "damage", vardamage, "friendly_fire_damage", varfriendlydamage ] );
    }
}

// Namespace matchdata
// Params 0
// Checksum 0x3e6eb55f, Offset: 0xdc2
// Size: 0xaf
function endofgamesummarylogger()
{
    level waittill( #"game_ended", winner );
    
    if ( level.var_42440e0ca1525e31 )
    {
        return;
    }
    
    foreach ( player in level.players )
    {
        wait 0.05;
        
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        function_5a1951caa8fc2b02( player );
    }
}

// Namespace matchdata
// Params 1
// Checksum 0x27af0ad4, Offset: 0xe79
// Size: 0x1a1
function function_5a1951caa8fc2b02( player )
{
    if ( isdefined( player.challengescompleted ) )
    {
        player setplayerdata( "common", "round", "challengeNumCompleted", player.challengescompleted.size );
    }
    else
    {
        player setplayerdata( "common", "round", "challengeNumCompleted", 0 );
    }
    
    for ( i = 0; i < 20 ; i++ )
    {
        if ( isdefined( player.challengescompleted[ i ] ) && player.challengescompleted[ i ] != "ch_prestige" && !issubstr( player.challengescompleted[ i ], "_daily" ) && !issubstr( player.challengescompleted[ i ], "_weekly" ) )
        {
            player setplayerdata( "common", "round", "challengesCompleted", i, player.challengescompleted[ i ] );
            continue;
        }
        
        player setplayerdata( "common", "round", "challengesCompleted", i, "ch_none" );
    }
    
    current_map = tolower( getdvar( @"g_mapname" ) );
    gametype = level.gametypebundle.var_fb4d0268626c6d18 ? level.gametypebundle.namekey : game_utility_mp::getbasegametype();
    player setplayerdata( "common", "round", "gameMode", gametype );
    player setplayerdata( "common", "round", "map", current_map );
}

// Namespace matchdata
// Params 0
// Checksum 0x4d63dc2e, Offset: 0x1022
// Size: 0x102
function recordrecentlyplayeddata()
{
    if ( game_utility_mp::matchmakinggame() )
    {
        currentmap = tolower( getdvar( @"g_mapname" ) );
        
        foreach ( player in level.players )
        {
            for ( i = 4; i > 0 ; i-- )
            {
                map = player getplayerdata( level.var_6f9b00680ed002d8, "mapsPlayed", i - 1 );
                player setplayerdata( level.var_6f9b00680ed002d8, "mapsPlayed", i, map );
            }
            
            player setplayerdata( level.var_6f9b00680ed002d8, "mapsPlayed", 0, currentmap );
        }
    }
}

// Namespace matchdata
// Params 1
// Checksum 0xba421742, Offset: 0x112c
// Size: 0x40, Type: bool
function isvalidclient( client )
{
    if ( game[ "isLaunchChunk" ] )
    {
        return false;
    }
    
    if ( !isdefined( client ) )
    {
        return false;
    }
    else if ( isagent( client ) )
    {
        return false;
    }
    else if ( !isplayer( client ) )
    {
        return false;
    }
    
    return true;
}

// Namespace matchdata
// Params 1
// Checksum 0x990dc7a5, Offset: 0x1175
// Size: 0x32
function canlogclient( client )
{
    if ( isvalidclient( client ) )
    {
        return ( client.clientid < level.maxlogclients );
    }
    
    return 0;
}

// Namespace matchdata
// Params 1
// Checksum 0x6f1be7c4, Offset: 0x11af
// Size: 0x18, Type: bool
function canloglife( lifeid )
{
    return lifeid < level.maxlives;
}

// Namespace matchdata
// Params 2
// Checksum 0xb96fd9f4, Offset: 0x11d0
// Size: 0x22
function logchallenge( challengename, tier )
{
    println( "<dev string:x168>" );
}

// Namespace matchdata
// Params 1
// Checksum 0x7c83714a, Offset: 0x11fa
// Size: 0x84
function logaward( awardname )
{
    if ( !isvalidclient( self ) )
    {
        return;
    }
    
    if ( isbot( self ) || istestclient( self ) || isai( self ) )
    {
        return;
    }
    
    time_ms = gettimefrommatchstart( gettime() );
    
    if ( isxhash( awardname ) )
    {
        awardname = getxhashhexname( awardname );
    }
    
    self dlog_recordplayerevent( "dlog_event_player_award", [ "time_ms_from_match_start", time_ms, "award", awardname ] );
}

