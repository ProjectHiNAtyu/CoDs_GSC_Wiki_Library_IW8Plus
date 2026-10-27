// scripts\mp\leagueplay.gsc  (hash_629a97c763e17711.gscc) (size: 21243 Bytes / 0x52fb / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x3600d9e1 (906025441)
// size ...... 21243 (0x52fb)
// includes .. 15  (offset: 0x4d73)
// strings ... 75  (offset: 0x4deb)
// dev strs .. 3   (offset: 0x52d3)
// exports ... 44  (offset: 0x353f)
// cseg ...... 0x8c4 + 0x2c7b (0x353f)
// imports ... 128 (offset: 0x3c1f)
// animtree1 . 0   (offset: 0x52fb)
// animtree2 . 0   (offset: 0x52fb)
#using script_3cb3908b3094b567;
#using scripts\common\ae_utility;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\mp\challenges;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\rejoin_utility;
#using scripts\mp\common\utility\team_utility;
#using scripts\mp\common\utility\teams;
#using scripts\mp\flags;
#using scripts\mp\forfeit;
#using scripts\mp\gamelogic;
#using scripts\mp\gamescore;
#using scripts\mp\playerachievements;
#using scripts\mp\teams;

#namespace leagueplay;

// Namespace leagueplay
// Params 0
// Checksum 0x566d45bc, Offset: 0x8e2
// Size: 0x2e3
function init()
{
    if ( !level.leagueplaymatch )
    {
        return;
    }
    
    rejoin_utility::function_d60b587d531ea116( &ondisconnect );
    rejoin_utility::function_70467cdf042579e5( &function_2d040a0be85f080c );
    rejoin_utility::function_68642548b18c49c8( &function_f25fa63a85c02b0e );
    level.var_9daab46fe497e39f = &function_b73bdbcb4acc91f4;
    
    if ( getdvarint( @"hash_cc7585605afb255a", 0 ) )
    {
        level.var_f5c49cf37c68f91c = &function_f5c49cf37c68f91c;
        level.var_5bbfdd7562b793 = &leagueplayafk;
        level.afkdisttimethreshold = getdvarint( @"hash_2ea000db61daba7b", 30 );
        level.var_ae60efb8868dc896 = level.gametypebundle.var_de40626b694232a0 ?? getdvarfloat( @"hash_444f3c8b2a24404e", 35 );
        level thread function_e49a7aff6c8f6342( level.var_ae60efb8868dc896 );
    }
    
    level.var_246204351eddbb14 = getdvarint( @"hash_b5256fb3f4ed76af", 0 );
    level.var_7a59fd0cc9c295fb = getdvarint( @"hash_a94c6ed8a414196", 0 );
    level.var_dcf885e37114a02f = getdvarint( @"hash_95bde55f2b298c10", 15 );
    level.var_d8d0b6786cf440a0 = getdvarint( @"hash_39a4321fe6754375", 50 );
    level.leagueplaymatchcancelled = 0;
    level.leagueid = function_77b8881d5d9b6e08();
    level.var_4f18117edb5d349d = function_98844aa83146c438();
    level.leaguegametype = getmatchmakinggametype();
    level.leagueplaytype = 0;
    
    if ( !isdefined( level.var_4f18117edb5d349d ) )
    {
        level.var_4f18117edb5d349d = 0;
    }
    
    level.var_38c66eeb1ff15642 = "none";
    level.var_4aa00295f34bae97 = &forfeit_match;
    
    if ( game_utility_mp::isroundbased() && isdefined( level.gametypebundle.var_f822a8e4d5d55a1 ) )
    {
        level callback::add( #"round_ended", &onroundended );
    }
    else if ( isdefined( level.gametypebundle.var_26d49105cbe6daf3 ) )
    {
        level.onteamscore = &function_9a5f319df570cea6;
    }
    
    requiredplayers = 4;
    
    if ( isusingmatchrulesdata() )
    {
        requiredplayers = getmatchrulesdata( "commonOption", "squadSize" );
    }
    
    level.requiredplayercountoveride = 1;
    level.requiredplayercount[ "allies" ] = requiredplayers;
    level.requiredplayercount[ "axis" ] = requiredplayers;
    level.var_d0ec159c9006f135 = getdvarint( @"hash_f0ad3b38c4166ee", 150 );
    level.var_92336756f4268acc = 1;
    forfeit::init( "lp_vote_to_forfeit" );
    level thread onconnect();
    level thread ongameplaying();
    var_a0b888b256fed7b0 = int( tablelookup( "mp/leagueplay_config.csv", 0, "ladderPointsPlacement", 1 ) );
    level.leagueplayseason = function_56063b1401b23270();
    function_a8c0cb82c403560c( var_a0b888b256fed7b0 );
    level sdutils_init();
    utility::registersharedfunc( #"hash_3ac9ab20c49792f2", #"hash_ccd8bef4e302e3ce", &sdutils_onsdachievementinfofetched );
    function_a14deb691144654e();
}

// Namespace leagueplay
// Params 0
// Checksum 0xba9c052e, Offset: 0xbcd
// Size: 0x1d, Type: bool
function function_5dc1d8035af10f15()
{
    return game[ "roundsPlayed" ] >= level.gametypebundle.var_f822a8e4d5d55a1;
}

// Namespace leagueplay
// Params 1
// Checksum 0x5968f4ec, Offset: 0xbf3
// Size: 0x22, Type: bool
function function_e8cddf66952715be( score )
{
    return score >= level.gametypebundle.var_26d49105cbe6daf3;
}

// Namespace leagueplay
// Params 1
// Checksum 0x2982f47e, Offset: 0xc1e
// Size: 0x93
function function_a92c105542467746( player )
{
    if ( isdefined( player ) )
    {
        player function_992b15c0c63c38ec( 1 );
        return;
    }
    
    foreach ( player in level.players )
    {
        player function_992b15c0c63c38ec( 1 );
    }
}

// Namespace leagueplay
// Params 1
// Checksum 0x70060ee1, Offset: 0xcb9
// Size: 0x1d
function onroundended( data )
{
    if ( function_5dc1d8035af10f15() )
    {
        function_a92c105542467746( undefined );
    }
}

// Namespace leagueplay
// Params 1
// Checksum 0xa7b379df, Offset: 0xcde
// Size: 0x1d
function function_3d5db98217b22bf7( data )
{
    if ( function_5dc1d8035af10f15() )
    {
        function_a92c105542467746( self );
    }
}

// Namespace leagueplay
// Params 3
// Checksum 0xe2f60d8c, Offset: 0xd03
// Size: 0x31
function function_9a5f319df570cea6( team, score, scoreevent )
{
    if ( function_e8cddf66952715be( score ) )
    {
        function_a92c105542467746( undefined );
    }
}

// Namespace leagueplay
// Params 3
// Checksum 0x44a19b3a, Offset: 0xd3c
// Size: 0x31
function function_bbcadfa3d540ac38( team, score, scoreevent )
{
    if ( function_e8cddf66952715be( score ) )
    {
        function_a92c105542467746( self );
    }
}

// Namespace leagueplay
// Params 1
// Checksum 0x938f9dbd, Offset: 0xd75
// Size: 0x60
function function_992b15c0c63c38ec( var_7a42dc35fd9796ee = 0 )
{
    var_80d6fcf6ec58b102 = self.pers[ "LPAllowLeave" ] ? 2 : 3;
    
    if ( var_7a42dc35fd9796ee )
    {
        var_80d6fcf6ec58b102 = 0;
    }
    
    if ( getdvarint( @"leagueplay_forfeit_enabled", 1 ) )
    {
        self setclientomnvar( "ui_leagueplay_allow_quit", var_80d6fcf6ec58b102 );
    }
}

// Namespace leagueplay
// Params 0
// Checksum 0xceaedfaf, Offset: 0xddd
// Size: 0x16f
function onconnect()
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        level waittill( #"connected", player );
        
        if ( level.leagueplaymatchcancelled )
        {
            logstring( "leagueplay::onConnect(): player connected but match is cancelled. Ignore" );
            continue;
        }
        
        if ( !isplayer( player ) || isbot( player ) )
        {
            logstring( "leagueplay::onConnect(): bot player connected. Ignore" );
            continue;
        }
        
        xuid = player getxuid();
        logstring( "leagueplay::onConnect(): Player " + xuid + " connected" );
        
        if ( !function_c503b9ecdb626de7( player ) || !function_a0f876f63749f85b( xuid ) )
        {
            player function_a05e0b1d2b3361a9();
            player function_2600cf39ab944202();
        }
        
        if ( getdvarint( @"hash_9f92cca10b7a72e6", 1 ) )
        {
            player function_51a06cc9021b07bd();
        }
        
        player function_992b15c0c63c38ec();
        
        if ( game_utility_mp::isroundbased() && isdefined( level.gametypebundle.var_f822a8e4d5d55a1 ) )
        {
            player function_3d5db98217b22bf7( undefined );
            continue;
        }
        
        if ( isdefined( level.gametypebundle.var_26d49105cbe6daf3 ) )
        {
            team1score = gamescore::getteamscore( level.teamnamelist[ 0 ] );
            team2score = gamescore::getteamscore( level.teamnamelist[ 1 ] );
            player function_bbcadfa3d540ac38( undefined, team1score, undefined );
            player function_bbcadfa3d540ac38( undefined, team2score, undefined );
        }
    }
}

// Namespace leagueplay
// Params 1
// Checksum 0x28e8d545, Offset: 0xf54
// Size: 0xf3
function function_7e444ea0b1951e2c( aeeventname )
{
    leagueseason = function_366e3fa5964379cc();
    gamemode = challenges::getchallengegamemode();
    eventparams = [];
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"leagueplay_is_disconnect" ) ] = 0;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"leagueplay_match_id" ) ] = getonlinematchid();
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"leagueplay_lobby_id" ) ] = getlobbyid();
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"leagueplay_gametype" ) ] = level.leaguegametype;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"gamemode" ) ] = gamemode;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"leagueplay_rejoin_enabled" ) ] = rejoin_utility::function_5ed88373949103a8() && function_8cb4891672cca914();
    
    if ( leagueseason > -1 )
    {
        eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"leagueplay_event_season" ) ] = leagueseason;
    }
    
    return eventparams;
}

// Namespace leagueplay
// Params 1
// Checksum 0xc13a7bfa, Offset: 0x1050
// Size: 0x1bc
function function_2d040a0be85f080c( player )
{
    if ( level.leagueplaymatchcancelled )
    {
        return;
    }
    
    if ( !isplayer( player ) || isbot( player ) )
    {
        return;
    }
    
    player.afktime = 0;
    player function_2600cf39ab944202();
    player.pers[ "leaguePlayDisconnected" ] = 0;
    xuid = player getxuid();
    
    if ( function_c503b9ecdb626de7( player ) && function_a0f876f63749f85b( xuid ) )
    {
        teammates = teams::getteamdata( player.team, "players" );
        completeteam = 1;
        
        foreach ( teammate in teammates )
        {
            teammatexuid = teammate getxuid();
            logstring( "LeaguePlay: Checking user: " + teammatexuid );
            
            if ( teammate.pers[ "leaguePlayDisconnected" ] == 1 )
            {
                logstring( "LeaguePlay: Incomplete team, skipping loss forgiveness changes due to" + teammatexuid + " still disconnected" );
                completeteam = 0;
                break;
            }
        }
        
        if ( completeteam )
        {
            player function_7a532ed8a715c1aa( level.var_d8d0b6786cf440a0 );
        }
        
        function_13a19bb674a8aa90( xuid );
        aeeventname = #"connection_update";
        aeeventid = ae_utility::function_8645a430dc4bffb9( aeeventname );
        eventparams = function_7e444ea0b1951e2c( aeeventname );
        player function_2e45314624fdfdb8( aeeventid, eventparams );
    }
}

// Namespace leagueplay
// Params 2
// Checksum 0x588e54e7, Offset: 0x1214
// Size: 0x57a
function ondisconnect( player, aeeventname )
{
    if ( level.leagueplaymatchcompleted || level.leagueplaymatchcancelled )
    {
        return;
    }
    
    if ( !isplayer( player ) || isbot( player ) )
    {
        return;
    }
    
    if ( !( isdefined( player ) && isdefined( player.team ) ) )
    {
        return;
    }
    
    if ( !isdefined( player.pers[ "leaguePlayInit" ] ) || player.pers[ "leaguePlayInit" ] == 0 )
    {
        return;
    }
    
    if ( !isdefined( player.pers[ "leaguePlayDisconnected" ] ) || player.pers[ "leaguePlayDisconnected" ] == 1 )
    {
        return;
    }
    
    if ( !flags::gameflag( "prematch_done" ) || !level.var_40efa4e4e9e53208 && function_7ada2a254528e2ce() )
    {
        level.var_40efa4e4e9e53208 = 1;
    }
    
    srpenalty = 0;
    ladderpenalty = 0;
    ladderpointsloss = int( tablelookup( "mp/leagueplay_config.csv", 0, "ladderPointsLoss", 1 ) );
    disconnectreason = 0;
    playercounts = teams::countplayers();
    xuid = player getxuid();
    
    if ( isdefined( playercounts[ player.team ] ) && playercounts[ player.team ] == 3 )
    {
        ladderpenalty = int( tablelookup( "mp/leagueplay_config.csv", 0, "ladderPenaltyFirstLeave", 1 ) );
        disconnectreason = 1;
    }
    else
    {
        ladderpenalty = int( tablelookup( "mp/leagueplay_config.csv", 0, "ladderPenaltyAdditionalLeave", 1 ) );
        disconnectreason = 2;
    }
    
    if ( player.var_3693a4c7e6bdc44 )
    {
        disconnectreason = 3;
    }
    else if ( player.var_3ac39ef107e8744a )
    {
        disconnectreason = 7;
    }
    else if ( gamelogic_mp::inprematch() )
    {
        disconnectreason = 9;
    }
    
    if ( disconnectreason != 0 )
    {
        logstring( "LeaguePlay: Triggering match end for disconnecting player xuid " + xuid );
        function_b71f0a89a1a0c1a8( player );
    }
    
    if ( getdvarint( @"leagueplay_enable_loss_forgiveness", 0 ) )
    {
        var_db9d8a1f9cdb8604 = disconnectreason == 1;
        var_db9d8a1f9cdb8604 = var_db9d8a1f9cdb8604 || disconnectreason == 3;
        var_db9d8a1f9cdb8604 = var_db9d8a1f9cdb8604 || disconnectreason == 7;
        
        if ( var_db9d8a1f9cdb8604 )
        {
            player function_7a532ed8a715c1aa( 100 );
        }
    }
    
    squadmembers = [];
    
    if ( level.matchmakingmatch )
    {
        squadmembers = player getfireteammembers();
    }
    
    foreach ( ent in level.players )
    {
        if ( ent == player )
        {
            continue;
        }
        
        if ( ent.team == player.team && isplayer( ent ) )
        {
            if ( arraycontains( squadmembers, ent ) )
            {
                ent setclientomnvar( "ui_leagueplay_allow_quit", 0 );
            }
            else
            {
                ent setclientomnvar( "ui_leagueplay_allow_quit", 2 );
            }
            
            ent.pers[ "LPAllowLeave" ] = 1;
        }
    }
    
    winningteam = gamescore::calculatewinningteam( 1 );
    var_e878f41fc7928bd9 = 2;
    
    if ( winningteam != "none" && winningteam != "tie" )
    {
        if ( player.team == winningteam )
        {
            var_e878f41fc7928bd9 = 3;
        }
        else
        {
            var_e878f41fc7928bd9 = 1;
        }
    }
    
    canforfeit = 0;
    
    if ( player getclientomnvar( "ui_leagueplay_allow_quit" ) == 0 )
    {
        canforfeit = 1;
    }
    
    if ( getdvarint( @"hash_797d1de488817fc8", 1 ) && !function_7ada2a254528e2ce() )
    {
        function_a92c105542467746();
    }
    
    function_bffb10951d6b69d3( xuid, ladderpenalty, 1 );
    player.pers[ "leaguePlayDisconnected" ] = 1;
    player.afktime = 0;
    player function_2600cf39ab944202();
    leagueseason = function_366e3fa5964379cc();
    gamemode = challenges::getchallengegamemode();
    eventparams = [];
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"leagueplay_is_disconnect" ) ] = 1;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"leagueplay_match_id" ) ] = getonlinematchid();
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"leagueplay_lobby_id" ) ] = getlobbyid();
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"disconnect_reason" ) ] = disconnectreason;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"leagueplay_ladder_penalty" ) ] = -1 * ( ladderpointsloss + ladderpenalty );
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"leagueplay_sr_penalty" ) ] = srpenalty;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"rejoin_expiry" ) ] = rejoin_utility::function_b47f0ab881878ae5();
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"leagueplay_gametype" ) ] = level.leaguegametype;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"gamemode" ) ] = gamemode;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"leagueplay_rejoin_enabled" ) ] = rejoin_utility::function_5ed88373949103a8() && function_8cb4891672cca914();
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"hash_ea246f944fe314f2" ) ] = var_e878f41fc7928bd9;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"hash_d2afd17c1fbdc573" ) ] = canforfeit;
    
    if ( leagueseason > -1 )
    {
        eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"leagueplay_event_season" ) ] = leagueseason;
    }
    
    return eventparams;
}

// Namespace leagueplay
// Params 1
// Checksum 0xec1eca89, Offset: 0x1797
// Size: 0x22
function function_f25fa63a85c02b0e( aeeventname )
{
    eventparams = function_7e444ea0b1951e2c( aeeventname );
    return eventparams;
}

// Namespace leagueplay
// Params 0
// Checksum 0xa3ba6417, Offset: 0x17c2
// Size: 0x4a
function ongameplaying()
{
    level endon( #"game_ended" );
    
    if ( !flags::gameflag( "prematch_done" ) )
    {
        flags::gameflagwait( "prematch_done" );
    }
    
    function_cbcbf7b6cdd6b8b7();
    
    if ( !game_utility_mp::isroundbased() || game_utility_mp::isfirstround() )
    {
        level thread match_cancelling();
    }
}

// Namespace leagueplay
// Params 1
// Checksum 0xbb0362de, Offset: 0x1814
// Size: 0x14d
function function_7a532ed8a715c1aa( forgivenesslevel )
{
    player = self;
    playerxuid = player getxuid();
    teammates = teams::getteamdata( player.team, "players" );
    
    foreach ( teammate in teammates )
    {
        teammatexuid = teammate getxuid();
        
        if ( playerxuid != teammatexuid )
        {
            if ( isdefined( teammate.pers[ "subpartyIndex" ] ) )
            {
                if ( teammate.pers[ "subpartyIndex" ] != -1 && teammate.pers[ "subpartyIndex" ] != player.pers[ "subpartyIndex" ] )
                {
                    logstring( "LeaguePlay: due to user: " + playerxuid + " disconnecting, setting forgiveness to " + forgivenesslevel + " for user " + teammatexuid );
                    teammate.pers[ "forgiveness_level" ] = forgivenesslevel;
                }
            }
        }
    }
}

// Namespace leagueplay
// Params 0
// Checksum 0xdfa87022, Offset: 0x1969
// Size: 0xaf
function match_cancelling()
{
    if ( !isdefined( level.var_7a59fd0cc9c295fb ) || level.var_7a59fd0cc9c295fb <= 0 )
    {
        return;
    }
    
    level endon( #"game_ended" );
    
    while ( function_7ada2a254528e2ce() )
    {
        if ( level.var_40efa4e4e9e53208 )
        {
            level.var_59cffb353d98bc10 = 1;
            setomnvarforallclients( "ui_leagueplay_allow_quit", 1 );
            thread gamelogic_mp::function_d441498194756fb2( level.var_dcf885e37114a02f * 1000 );
            wait level.var_dcf885e37114a02f;
            cancel_match();
            return;
        }
        
        wait 1;
    }
    
    if ( getdvarint( @"hash_22eddf44003baf9", 0 ) != 0 && function_8cb4891672cca914() )
    {
        setdvar( @"hash_925f7dceb8e6205e", 1 );
    }
}

// Namespace leagueplay
// Params 0
// Checksum 0xa0bd4b50, Offset: 0x1a20
// Size: 0x20, Type: bool
function function_b73bdbcb4acc91f4()
{
    if ( level.var_59cffb353d98bc10 && !level.leagueplaymatchcancelled )
    {
        return true;
    }
    
    return false;
}

// Namespace leagueplay
// Params 0
// Checksum 0x557e3809, Offset: 0x1a49
// Size: 0x41, Type: bool
function function_7ada2a254528e2ce()
{
    return isdefined( level.starttime ) && ( !game_utility_mp::isroundbased() || game_utility_mp::isfirstround() ) && ( gettime() - level.starttime ) / 1000 < level.var_7a59fd0cc9c295fb;
}

// Namespace leagueplay
// Params 0
// Checksum 0xc544b12e, Offset: 0x1a93
// Size: 0x1f
function function_a14deb691144654e()
{
    setnojipscore( 1, 1 );
    setnojiptime( 1, 1 );
    level.nojip = 1;
}

// Namespace leagueplay
// Params 1
// Checksum 0x5c479084, Offset: 0x1aba
// Size: 0x37, Type: bool
function function_c503b9ecdb626de7( player )
{
    if ( isdefined( player.pers[ "leaguePlayInit" ] ) )
    {
        return ( player.pers[ "leaguePlayInit" ] == 1 );
    }
    
    return false;
}

// Namespace leagueplay
// Params 0
// Checksum 0x6c7e2e54, Offset: 0x1afa
// Size: 0x1f5
function function_a05e0b1d2b3361a9()
{
    player = self;
    
    if ( !isplayer( player ) || isbot( player ) )
    {
        return;
    }
    
    if ( player.pers[ "leaguePlayInit" ] == 1 )
    {
        return;
    }
    
    xuid = player getxuid();
    player.pers[ "subpartyIndex" ] = function_d85967e8d031a0a8( xuid );
    logstring( "LeaguePlay: initializing subparty index to: " + player.pers[ "subpartyIndex" ] + " for xuid: " + xuid );
    var_a6f1fcf27fb87cd4 = 0;
    var_949ea0fc58769397 = 0;
    player.pers[ "leaguePlayOnLadder" ] = 0;
    player.pers[ "leaguePlayDisconnected" ] = 0;
    
    if ( function_366e3fa5964379cc() > -1 )
    {
        var_949ea0fc58769397 = player getplayerdata( level.var_6f9b00680ed002d8, "leaguePlayData", level.leagueplaytype, "season", level.leagueplayseason, "pmatches" ) == getdvarint( @"hash_fd4d1a68a9daff4d", 5 ) - 1;
        var_1547aadd86bc341b = player getplayerdata( level.var_6f9b00680ed002d8, "leaguePlayData", level.leagueplaytype, "season", level.leagueplayseason, "pmatches" ) >= getdvarint( @"hash_fd4d1a68a9daff4d", 5 );
        player.pers[ "leaguePlayOnLadder" ] = player getplayerdata( level.var_6f9b00680ed002d8, "leaguePlayData", level.leagueplaytype, "league_id" ) == level.leagueid;
        
        if ( var_1547aadd86bc341b && !player.pers[ "leaguePlayOnLadder" ] )
        {
            var_a6f1fcf27fb87cd4 = 1;
        }
    }
    
    player function_964197d86128a797();
    leagueplayonplayerconnect( xuid, var_a6f1fcf27fb87cd4, player.pers[ "leaguePlayOnLadder" ], var_949ea0fc58769397 );
    player.pers[ "leaguePlayInit" ] = 1;
}

// Namespace leagueplay
// Params 1
// Checksum 0x3c0345df, Offset: 0x1cf7
// Size: 0x20
function forfeit_match( forfeitteam )
{
    level.var_38c66eeb1ff15642 = forfeitteam;
    forfeitmatchend( forfeitteam );
}

// Namespace leagueplay
// Params 1
// Checksum 0xc9dc60b7, Offset: 0x1d1f
// Size: 0x2c
function forfeitmatchend( forfeitteam )
{
    winner = team_utility::getotherteam( forfeitteam );
    level thread gamelogic_mp::onforfeit( winner, 1 );
}

// Namespace leagueplay
// Params 1
// Checksum 0x77f97691, Offset: 0x1d53
// Size: 0x43
function function_e49a7aff6c8f6342( waittime )
{
    level endon( #"game_ended" );
    flags::function_2f3408423ccc9b2e( "prematch_done" );
    wait waittime;
    level.afkdisttimethreshold = level.afkthresholds.var_f21903a24e3d5816;
}

// Namespace leagueplay
// Params 0
// Checksum 0x12cf5009, Offset: 0x1d9e
// Size: 0x9
function function_f5c49cf37c68f91c()
{
    function_2600cf39ab944202();
}

// Namespace leagueplay
// Params 0
// Checksum 0x19c7167f, Offset: 0x1daf
// Size: 0x2c
function function_2600cf39ab944202()
{
    self.pers[ "passedAFKTime" ] = gettime();
    self.pers[ "distTrackingPassedOrResetTime" ] = mp_afk::function_a10af3f5e26c28da();
}

// Namespace leagueplay
// Params 0
// Checksum 0xe57e3bee, Offset: 0x1de3
// Size: 0x3f
function leagueplayafk()
{
    if ( mp_afk::dontconsiderafk() || !function_594406b27dae6f9d( self ) || rejoin_utility::function_e421863f0f4de34() )
    {
        function_2600cf39ab944202();
        mp_afk::function_a710eba86b2e3782( self, "default", 0, 0 );
        return;
    }
    
    mp_afk::checkforafk();
}

// Namespace leagueplay
// Params 0
// Checksum 0x84c62ac6, Offset: 0x1e2a
// Size: 0xf0
function cancel_match()
{
    level.matchcancelled = 1;
    level.leagueplaymatchcancelled = 1;
    level.var_46b9986eed75f973 = 0;
    level.no_winners_circle = 1;
    level.skipfinalkillcam = 1;
    
    if ( getdvarint( @"online_mp_clientmatchdata_enabled" ) != 0 )
    {
        foreach ( player in level.players )
        {
            player function_964197d86128a797();
        }
    }
    
    gamescore::updateplacement();
    gamelogic_mp::processlobbydata();
    level thread gamelogic_mp::forceend();
    
    if ( !flags::gameflag( "prematch_done" ) )
    {
        match_end( undefined );
    }
}

// Namespace leagueplay
// Params 0
// Checksum 0xeb6ae19f, Offset: 0x1f22
// Size: 0x53
function function_964197d86128a797()
{
    player = self;
    
    if ( !isdefined( player ) )
    {
        return;
    }
    
    if ( !isdefined( player.clientmatchdataid ) )
    {
        gamelogic_mp::assignclientmatchdataid( player );
    }
    
    setclientmatchdata( "players", player.clientmatchdataid, "leaguePlayMatchCancelled", level.leagueplaymatchcancelled );
}

// Namespace leagueplay
// Params 0
// Checksum 0xcd558df9, Offset: 0x1f7d
// Size: 0x1c
function function_366e3fa5964379cc()
{
    if ( level.leagueplayseason >= 0 )
    {
        return level.leagueplayseason;
    }
    
    return -1;
}

// Namespace leagueplay
// Params 1
// Checksum 0x115aa00e, Offset: 0x1fa2
// Size: 0xae
function get_match_result( winner )
{
    player = self;
    
    if ( !isdefined( winner ) )
    {
        return 2;
    }
    
    if ( level.teambased )
    {
        if ( team_utility::isgameplayteam( winner ) )
        {
            if ( isdefined( player.team ) )
            {
                if ( player.team == winner )
                {
                    if ( level.var_38c66eeb1ff15642 != "none" )
                    {
                        return 5;
                    }
                    
                    return 3;
                }
                else
                {
                    if ( player.team == level.var_38c66eeb1ff15642 )
                    {
                        return 4;
                    }
                    
                    return 1;
                }
            }
            
            return;
        }
        
        if ( isstring( winner ) && winner == "tie" )
        {
            return 2;
        }
    }
}

// Namespace leagueplay
// Params 1
// Checksum 0xe15193ff, Offset: 0x2059
// Size: 0x83
function function_7e4eec36aa56819( ladderpointsbonuspoolstep )
{
    player = self;
    bonuspool = player getplayerdata( level.var_6f9b00680ed002d8, "leaguePlayData", level.leagueplaytype, "bonuspool" );
    var_d942420985677271 = bonuspool - ladderpointsbonuspoolstep;
    
    if ( var_d942420985677271 >= 0 )
    {
        player getplayerdata( level.var_6f9b00680ed002d8, "leaguePlayData", level.leagueplaytype, "bonuspool", var_d942420985677271 );
        return ladderpointsbonuspoolstep;
    }
    
    return 0;
}

// Namespace leagueplay
// Params 1
// Checksum 0x2cc96a66, Offset: 0x20e5
// Size: 0x83, Type: bool
function function_594406b27dae6f9d( player )
{
    if ( !isplayer( player ) || isbot( player ) )
    {
        return false;
    }
    
    if ( !isdefined( player.pers[ "leaguePlayInit" ] ) || player.pers[ "leaguePlayInit" ] == 0 )
    {
        return false;
    }
    
    if ( !isdefined( player.pers[ "leaguePlayDisconnected" ] ) || player.pers[ "leaguePlayDisconnected" ] == 1 )
    {
        return false;
    }
    
    return true;
}

// Namespace leagueplay
// Params 0
// Checksum 0xc76142a4, Offset: 0x2171
// Size: 0xf0
function sdutils_init()
{
    if ( !getdvarint( @"hash_9f92cca10b7a72e6", 1 ) )
    {
        return;
    }
    
    var_2d424d92893ae18f = getdvarint( @"hash_27a8c31fb0a05714", 0 );
    
    if ( var_2d424d92893ae18f > 0 )
    {
        level.var_976fbe4cd7a13c4c = var_2d424d92893ae18f;
        logstring( "leagueplay::sdUtils_init(): using dvar override, caching SD achievement ID: " + var_2d424d92893ae18f );
        return;
    }
    
    var_d414d7929c7dff16 = [ 0, 0, 53799, 53800, 53801, 53802, 53803 ];
    leagueseason = function_366e3fa5964379cc();
    
    if ( leagueseason < 0 || leagueseason >= var_d414d7929c7dff16.size )
    {
        level.var_976fbe4cd7a13c4c = 0;
        logstring( "leagueplay::sdUtils_init(): season " + leagueseason + " out of bounds, caching SD achievement ID: 0" );
        return;
    }
    
    level.var_976fbe4cd7a13c4c = var_d414d7929c7dff16[ leagueseason ];
    logstring( "leagueplay::sdUtils_init(): caching SD achievement ID: " + level.var_976fbe4cd7a13c4c + ", season: " + leagueseason );
}

// Namespace leagueplay
// Params 0
// Checksum 0xadc6180a, Offset: 0x2269
// Size: 0x2f
function function_51a06cc9021b07bd()
{
    if ( !isdefined( level.var_976fbe4cd7a13c4c ) || level.var_976fbe4cd7a13c4c == 0 )
    {
        return;
    }
    
    self function_fdf029c4be6546a3( level.var_976fbe4cd7a13c4c );
}

// Namespace leagueplay
// Params 2
// Checksum 0x8fe05b36, Offset: 0x22a0
// Size: 0x16e
function sdutils_onsdachievementinfofetched( achievementid, progressdata )
{
    if ( !getdvarint( @"hash_9f92cca10b7a72e6", 1 ) )
    {
        return;
    }
    
    if ( !isdefined( level.var_976fbe4cd7a13c4c ) || level.var_976fbe4cd7a13c4c == 0 )
    {
        return;
    }
    
    if ( achievementid != level.var_976fbe4cd7a13c4c )
    {
        return;
    }
    
    sr_id = playerachievements::function_a550b9c75bcbee5e( "sr" );
    p_games_left_id = playerachievements::function_a550b9c75bcbee5e( "p_games_left" );
    sr = 0;
    var_4764d5ce2c5d60bc = 0;
    var_7fbffdf27416196d = 0;
    
    for ( index = 0; index < progressdata.progress_values.size ; index++ )
    {
        progress_id = progressdata.progress_values[ index ].progress_id;
        progress = progressdata.progress_values[ index ].progress;
        
        if ( sr_id == progress_id )
        {
            sr = progress;
            continue;
        }
        
        if ( p_games_left_id == progress_id )
        {
            var_4764d5ce2c5d60bc = progress;
        }
    }
    
    var_7fbffdf27416196d = var_4764d5ce2c5d60bc > 0;
    xuid = self getxuid();
    logstring( "leagueplay::sdUtils_onSDAchievementInfoFetched(): caching SR: " + sr + ", isPlayerUnplaced: " + var_7fbffdf27416196d + " for xuid: " + xuid );
    self.var_199adc82603cc27 = sr;
    self.var_1f46f3b9077ee65a = var_4764d5ce2c5d60bc;
}

// Namespace leagueplay
// Params 3
// Checksum 0x904dcf9d, Offset: 0x2416
// Size: 0x2e1
function function_3471c996009bd0e4( var_bf56c9de19be5dce, var_d08247375811baf, matchcancelled )
{
    var_88e8cbda9ce533 = [];
    var_33fc32c280013316 = [];
    var_3cf8e6a2a3ea2056 = [];
    var_995f3dd454346d95 = [];
    var_ab36ebc25e2157aa = [];
    var_711491a7d7d067ff = [];
    
    foreach ( player in level.players )
    {
        if ( !function_594406b27dae6f9d( player ) )
        {
            continue;
        }
        
        if ( isdefined( player.team ) )
        {
            playerscore = 0;
            
            if ( !matchcancelled && isdefined( player.pers[ "score" ] ) )
            {
                playerscore = player.pers[ "score" ];
            }
            
            playersr = player.var_199adc82603cc27 ?? -1;
            playerunplaced = ( player.var_1f46f3b9077ee65a ?? 0 ) > 0;
            assert( player.team == var_bf56c9de19be5dce || player.team == var_d08247375811baf, "<dev string:x24>" );
            
            if ( player.team == var_bf56c9de19be5dce )
            {
                assert( var_88e8cbda9ce533.size < 4, "<dev string:x59>" );
                
                if ( var_88e8cbda9ce533.size < 4 )
                {
                    var_88e8cbda9ce533[ var_88e8cbda9ce533.size ] = playerscore;
                    var_3cf8e6a2a3ea2056[ var_3cf8e6a2a3ea2056.size ] = playersr;
                    var_ab36ebc25e2157aa[ var_ab36ebc25e2157aa.size ] = playerunplaced;
                    player.pers[ "leaguePlayPlayerNumber" ] = var_88e8cbda9ce533.size;
                    player.pers[ "leaguePlayPlayerTeamId" ] = 1;
                }
                
                continue;
            }
            
            if ( player.team == var_d08247375811baf )
            {
                assert( var_33fc32c280013316.size < 4, "<dev string:x59>" );
                
                if ( var_33fc32c280013316.size < 4 )
                {
                    var_33fc32c280013316[ var_33fc32c280013316.size ] = playerscore;
                    var_995f3dd454346d95[ var_995f3dd454346d95.size ] = playersr;
                    var_711491a7d7d067ff[ var_711491a7d7d067ff.size ] = playerunplaced;
                    player.pers[ "leaguePlayPlayerNumber" ] = var_33fc32c280013316.size;
                    player.pers[ "leaguePlayPlayerTeamId" ] = 2;
                }
            }
        }
    }
    
    level.teamdata[ var_bf56c9de19be5dce ][ "player_scores" ] = var_88e8cbda9ce533;
    level.teamdata[ var_d08247375811baf ][ "player_scores" ] = var_33fc32c280013316;
    level.teamdata[ var_bf56c9de19be5dce ][ "player_srs" ] = var_3cf8e6a2a3ea2056;
    level.teamdata[ var_d08247375811baf ][ "player_srs" ] = var_995f3dd454346d95;
    level.teamdata[ var_bf56c9de19be5dce ][ "player_unplaced" ] = var_ab36ebc25e2157aa;
    level.teamdata[ var_d08247375811baf ][ "player_unplaced" ] = var_711491a7d7d067ff;
}

// Namespace leagueplay
// Params 1
// Checksum 0xc8e43e2f, Offset: 0x26ff
// Size: 0x2b3
function function_b71f0a89a1a0c1a8( player )
{
    leagueseason = function_366e3fa5964379cc();
    gamemode = challenges::getchallengegamemode();
    lobbyid = getlobbyid();
    matchid = getonlinematchid();
    ladderpointswin = int( tablelookup( "mp/leagueplay_config.csv", 0, "ladderPointsWin", 1 ) );
    ladderpointsloss = int( tablelookup( "mp/leagueplay_config.csv", 0, "ladderPointsLoss", 1 ) );
    ladderpointsbonuspoolstep = int( tablelookup( "mp/leagueplay_config.csv", 0, "ladderPointsBonusPoolStep", 1 ) );
    var_927372d73961eaaa = getdvarint( @"hash_74b99125b3898193", 86400 );
    xuid = player getxuid();
    matchresult = 1;
    addedtoladder = function_6d2d203a546c0a3f( xuid );
    onladder = player.pers[ "leaguePlayOnLadder" ];
    
    if ( isdefined( level.leagueid ) && isdefined( matchresult ) && leagueseason > -1 )
    {
        aeeventname = #"leagueplay_end_game";
        aeeventid = ae_utility::function_8645a430dc4bffb9( aeeventname );
        eventparams = [];
        eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"leagueplay_league_id" ) ] = level.leagueid;
        eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"leagueplay_match_result" ) ] = matchresult;
        eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"leagueplay_added_to_ladder" ) ] = addedtoladder;
        eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"leagueplay_on_ladder" ) ] = onladder;
        eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"leagueplay_event_season" ) ] = leagueseason;
        eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"leagueplay_match_id" ) ] = matchid;
        eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"leagueplay_lobby_id" ) ] = lobbyid;
        eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"leagueplay_event_type" ) ] = level.var_4f18117edb5d349d;
        eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"leagueplay_hot_streak_cooldown_s" ) ] = var_927372d73961eaaa;
        eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"leagueplay_at_match_end" ) ] = 0;
        eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"leagueplay_gametype" ) ] = level.leaguegametype;
        eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"gamemode" ) ] = gamemode;
        eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"leagueplay_is_disconnect" ) ] = 1;
        eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"leagueplay_rejoin_enabled" ) ] = rejoin_utility::function_5ed88373949103a8() && function_8cb4891672cca914();
        player function_2e45314624fdfdb8( aeeventid, eventparams );
    }
}

// Namespace leagueplay
// Params 6
// Checksum 0x279d89eb, Offset: 0x29ba
// Size: 0x3c8
function send_end_game_event( winner, leagueseason, matchcancelled, gamemode, lobbyid, matchid )
{
    logstring( "leagueplay::send_end_game_event(): leagueID=" + level.leagueid + ", season=" + leagueseason + ", matchCancelled=" + matchcancelled + ", gameMode=" + gamemode + ", lobbyID=" + lobbyid + ", matchID=" + matchid );
    ladderpointswin = int( tablelookup( "mp/leagueplay_config.csv", 0, "ladderPointsWin", 1 ) );
    ladderpointsloss = int( tablelookup( "mp/leagueplay_config.csv", 0, "ladderPointsLoss", 1 ) );
    ladderpointsbonuspoolstep = int( tablelookup( "mp/leagueplay_config.csv", 0, "ladderPointsBonusPoolStep", 1 ) );
    var_927372d73961eaaa = getdvarint( @"hash_74b99125b3898193", 86400 );
    
    foreach ( player in level.players )
    {
        xuid = player getxuid();
        
        if ( !function_594406b27dae6f9d( player ) )
        {
            logstring( "leagueplay::send_end_game_event(): skipping player " + xuid + " because not valid connected player" );
            continue;
        }
        
        matchresult = player get_match_result( winner );
        addedtoladder = function_6d2d203a546c0a3f( xuid );
        onladder = player.pers[ "leaguePlayOnLadder" ];
        
        if ( matchcancelled )
        {
            matchresult = 0;
        }
        else if ( isdefined( matchresult ) && ( onladder || addedtoladder ) )
        {
            if ( matchresult == 3 )
            {
                var_34fc0225a43700cc = 0;
                
                if ( onladder )
                {
                    var_34fc0225a43700cc = player function_7e4eec36aa56819( ladderpointsbonuspoolstep );
                }
                
                function_bffb10951d6b69d3( xuid, ladderpointswin + var_34fc0225a43700cc );
            }
            else if ( matchresult == 1 )
            {
                function_bffb10951d6b69d3( xuid, ladderpointsloss );
            }
        }
        
        if ( isdefined( level.leagueid ) && isdefined( matchresult ) && leagueseason > -1 )
        {
            aeeventname = #"leagueplay_end_game";
            aeeventid = ae_utility::function_8645a430dc4bffb9( aeeventname );
            eventparams = [];
            eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"leagueplay_league_id" ) ] = level.leagueid;
            eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"leagueplay_match_result" ) ] = matchresult;
            eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"leagueplay_added_to_ladder" ) ] = addedtoladder;
            eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"leagueplay_on_ladder" ) ] = onladder;
            eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"leagueplay_event_season" ) ] = leagueseason;
            eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"leagueplay_match_id" ) ] = matchid;
            eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"leagueplay_lobby_id" ) ] = lobbyid;
            eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"leagueplay_event_type" ) ] = level.var_4f18117edb5d349d;
            eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"leagueplay_hot_streak_cooldown_s" ) ] = var_927372d73961eaaa;
            eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"leagueplay_at_match_end" ) ] = 1;
            eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"leagueplay_gametype" ) ] = level.leaguegametype;
            eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"gamemode" ) ] = gamemode;
            eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"leagueplay_rejoin_enabled" ) ] = rejoin_utility::function_5ed88373949103a8() && function_8cb4891672cca914();
            player function_2e45314624fdfdb8( aeeventid, eventparams );
        }
    }
}

// Namespace leagueplay
// Params 6
// Checksum 0xfff7f5e9, Offset: 0x2d8a
// Size: 0x5e3
function send_match_end_data_event( winner, leagueseason, matchcancelled, gamemode, lobbyid, matchid )
{
    assert( level.teamnamelist.size == 2, "<dev string:x99>" );
    logstring( "leagueplay::send_match_end_data_event(): leagueID=" + level.leagueid + ", season=" + leagueseason + ", matchCancelled=" + matchcancelled + ", gameMode=" + gamemode + ", lobbyID=" + lobbyid + ", matchID=" + matchid );
    var_a984ce4e8f83a3fd = matchcancelled ? 0 : getteamscore( level.teamnamelist[ 0 ] );
    var_caf5a5c651ddc55e = matchcancelled ? 0 : getteamscore( level.teamnamelist[ 1 ] );
    var_bf56c9de19be5dce = level.teamnamelist[ 0 ];
    var_d08247375811baf = level.teamnamelist[ 1 ];
    var_c2ae372bc87c68a7 = [ #"hash_dcad780ba22c8ea6", #"hash_f4a570d3522835ef", #"hash_9639e93ddf4bc3d0", #"hash_fee33f060394e069" ];
    var_4c23c072f5c71546 = [ #"hash_f910d81a6e1f1637", #"hash_c286519c333e2ee", #"hash_33f686a1811c313d", #"hash_8f581c68a7c0671c" ];
    var_dea785ee77615986 = [ #"hash_3a0705a6048cc71d", #"hash_3b2dabab2b88a076", #"hash_1269bdb6766921eb", #"hash_3c57b3bcd60acdec" ];
    var_337be95343643f21 = [ #"hash_68afa40c4dcb66de", #"hash_918f9e0103037485", #"hash_904ce3fbdbeefe78", #"hash_98a89e360598d98f" ];
    function_3471c996009bd0e4( var_bf56c9de19be5dce, var_d08247375811baf, matchcancelled );
    
    foreach ( player in level.players )
    {
        xuid = player getxuid();
        
        if ( !function_594406b27dae6f9d( player ) )
        {
            logstring( "leagueplay::send_match_end_data_event(): skipping player " + xuid + " because not valid connected player" );
            continue;
        }
        
        matchresult = player get_match_result( winner );
        
        if ( matchcancelled )
        {
            matchresult = 0;
        }
        
        if ( isdefined( level.leagueid ) && isdefined( matchresult ) && leagueseason > -1 )
        {
            aeeventname = #"leagueplay_match_end_data";
            aeeventid = ae_utility::function_8645a430dc4bffb9( aeeventname );
            var_2d0e0f2d06f5ea08 = player.var_199adc82603cc27 ?? -1;
            eventparams = [];
            eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"hash_c6faee819a867495" ) ] = var_a984ce4e8f83a3fd;
            eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"hash_96d1d860c7841fd0" ) ] = var_caf5a5c651ddc55e;
            eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"leagueplay_match_result" ) ] = matchresult;
            eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"leagueplay_player_number" ) ] = player.pers[ "leaguePlayPlayerNumber" ];
            eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"leagueplay_player_team_id" ) ] = player.pers[ "leaguePlayPlayerTeamId" ];
            eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"leagueplay_event_season" ) ] = leagueseason;
            eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"leagueplay_match_id" ) ] = matchid;
            eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"leagueplay_lobby_id" ) ] = lobbyid;
            eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"leagueplay_forgiveness_level" ) ] = player.pers[ "forgiveness_level" ];
            eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"leagueplay_gametype" ) ] = level.leaguegametype;
            eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"gamemode" ) ] = gamemode;
            
            for ( i = 0; i < level.teamdata[ var_bf56c9de19be5dce ][ "player_scores" ].size ; i++ )
            {
                eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, var_c2ae372bc87c68a7[ i ] ) ] = level.teamdata[ var_bf56c9de19be5dce ][ "player_scores" ][ i ];
            }
            
            for ( i = 0; i < level.teamdata[ var_d08247375811baf ][ "player_scores" ].size ; i++ )
            {
                eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, var_4c23c072f5c71546[ i ] ) ] = level.teamdata[ var_d08247375811baf ][ "player_scores" ][ i ];
            }
            
            for ( i = 0; i < level.teamdata[ var_bf56c9de19be5dce ][ "player_srs" ].size ; i++ )
            {
                var_422c87be40a90fe8 = level.teamdata[ var_bf56c9de19be5dce ][ "player_srs" ][ i ];
                var_7fbffdf27416196d = level.teamdata[ var_bf56c9de19be5dce ][ "player_unplaced" ][ i ];
                
                if ( var_7fbffdf27416196d )
                {
                    var_422c87be40a90fe8 = var_2d0e0f2d06f5ea08;
                }
                
                if ( var_422c87be40a90fe8 >= 0 )
                {
                    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, var_dea785ee77615986[ i ] ) ] = var_422c87be40a90fe8;
                }
            }
            
            for ( i = 0; i < level.teamdata[ var_d08247375811baf ][ "player_srs" ].size ; i++ )
            {
                var_422c87be40a90fe8 = level.teamdata[ var_d08247375811baf ][ "player_srs" ][ i ];
                var_7fbffdf27416196d = level.teamdata[ var_d08247375811baf ][ "player_unplaced" ][ i ];
                
                if ( var_7fbffdf27416196d )
                {
                    var_422c87be40a90fe8 = var_2d0e0f2d06f5ea08;
                }
                
                if ( var_422c87be40a90fe8 >= 0 )
                {
                    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, var_337be95343643f21[ i ] ) ] = var_422c87be40a90fe8;
                }
            }
            
            player function_2e45314624fdfdb8( aeeventid, eventparams );
        }
    }
}

// Namespace leagueplay
// Params 0
// Checksum 0x3ad237e9, Offset: 0x3375
// Size: 0x8a
function function_e32909289b55c286()
{
    foreach ( player in level.players )
    {
        if ( !function_594406b27dae6f9d( player ) )
        {
            continue;
        }
        
        challenges::function_21b5f21603591966( player );
    }
}

// Namespace leagueplay
// Params 1
// Checksum 0x19eba89f, Offset: 0x3407
// Size: 0x138
function match_end( winner )
{
    level.leagueplaymatchcompleted = 1;
    
    if ( !level.leagueplaymatchcancelled )
    {
        level.gameended = 1;
        
        if ( !level.gameendtime )
        {
            level.gameendtime = gettime();
        }
    }
    
    leagueseason = function_366e3fa5964379cc();
    matchcancelled = istrue( level.leagueplaymatchcancelled );
    gamemode = challenges::getchallengegamemode();
    lobbyid = getlobbyid();
    matchid = getonlinematchid();
    logstring( "leagueplay::match_end(): winner=" + winner + ", leagueID=" + level.leagueid + ", season=" + leagueseason + ", matchCancelled=" + matchcancelled + ", gameMode=" + gamemode + ", lobbyID=" + lobbyid + ", matchID=" + matchid );
    send_end_game_event( winner, leagueseason, matchcancelled, gamemode, lobbyid, matchid );
    
    if ( getdvarint( @"hash_7772f1a61464003f", 1 ) )
    {
        logstring( "leagueplay::match_end(): sending match end data event" );
        send_match_end_data_event( winner, leagueseason, matchcancelled, gamemode, lobbyid, matchid );
    }
    else
    {
        logstring( "leagueplay::match_end(): skipping send_match_end_data_event because leagueplay_use_new_sr_pipeline is disabled" );
    }
    
    function_e32909289b55c286();
    leagueplayendmatch();
}

