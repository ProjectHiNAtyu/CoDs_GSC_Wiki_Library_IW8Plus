// scripts\mp\leagueplay_br.gsc  (hash_697b7ae06ba9b28c.gscc) (size: 32838 Bytes / 0x8046 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xb303db44 (3003374404)
// size ...... 32838 (0x8046)
// includes .. 13  (offset: 0x7826)
// strings ... 99  (offset: 0x788e)
// dev strs .. 41  (offset: 0x7e46)
// exports ... 61  (offset: 0x57c6)
// cseg ...... 0xf07 + 0x48bf (0x57c6)
// imports ... 159 (offset: 0x614e)
// animtree1 . 0   (offset: 0x8046)
// animtree2 . 0   (offset: 0x8046)
#using scripts\common\ae_utility;
#using scripts\common\utility;
#using scripts\mp\br\gametypes\br;
#using scripts\mp\challenges;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\rejoin_utility;
#using scripts\mp\common\utility\teams;
#using scripts\mp\flags;
#using scripts\mp\gamelogic;
#using scripts\mp\gamescore;
#using scripts\mp\playerachievements;
#using scripts\mp\rank;
#using scripts\mp\teams;

#namespace leagueplay_br;

// Namespace leagueplay_br
// Params 0
// Checksum 0xcef6a4c3, Offset: 0xf25
// Size: 0x3a4
function init()
{
    if ( !level.var_309e3d9dac389de6 )
    {
        return;
    }
    
    rejoin_utility::function_d60b587d531ea116( &ondisconnect );
    rejoin_utility::function_70467cdf042579e5( &function_2d040a0be85f080c );
    rejoin_utility::function_833ae7f0f564dbc1( &function_54cc746f7ad4b08a );
    level.var_246204351eddbb14 = getdvarint( @"hash_b5256fb3f4ed76af", 0 );
    level.var_7a59fd0cc9c295fb = getdvarint( @"hash_a94c6ed8a414196", 0 );
    level.var_945d2c29ab5743a1 = getdvarint( @"leagueplay_wait_for_players_s", 50 );
    level.var_2a1c2ca4b438f84a = getdvarint( @"live_lobby_minplayers_start", 0 );
    level.var_8de06ad448eee278 = getdvarint( @"max_time_to_backfill_s", 50 );
    level.var_50d320049979faa4 = getdvarint( @"hash_683c426d1ee9a40b", 3 );
    level.minplayersbeforedisband = getdvarint( @"minplayers_before_disband", 99 );
    level.var_15bca072e6eafdd5 = getdvarint( @"max_vsps_during_backfill", 150 );
    level.var_2efde9eff50b0385 = getmatchrulesdata( "commonOption", "teamSize" );
    level.var_821d674c0b433bd3 = getdvarint( @"wz_leagueplay_hide_sr_widget_on_spectate_team", 0 );
    level.var_feb65de320ce36d5 = getdvarint( @"hash_437738f209d2d423", 3 );
    level.var_44a441b8aa147be = getdvarint( @"hash_60b4cba061f32311", 0 ) != 0;
    leagueplaydata = level.gametypebundle.leagueplaydata;
    srtriggers = getscriptbundle( level.var_44a441b8aa147be ? leagueplaydata.var_e52c792ba5a5d89f : leagueplaydata.srtriggers );
    level.var_75c5c71dd0761200 = getdvarint( srtriggers.var_ee4034c243870a47, 0 );
    var_3ec262477a0ee51b = function_9c8bb146e5e7b9f2( srtriggers );
    level.var_1903e23485def131 = getdvarint( var_3ec262477a0ee51b.var_ebb4b50a8507c6e1, var_3ec262477a0ee51b.var_ce5c9d0378cd0494 );
    rank::registerscoreinfo( #"shield_assist", #"value", 25 );
    level.leagueplaymatchcancelled = 0;
    level.leagueid = function_77b8881d5d9b6e08();
    level.var_4f18117edb5d349d = function_98844aa83146c438();
    level.leaguegametype = getmatchmakinggametype();
    level.leagueplaytype = level.var_7f85d8c232d790ed ? 2 : 1;
    level.var_66b6ced16e22b45f = 0;
    
    if ( !isdefined( level.var_4f18117edb5d349d ) )
    {
        level.var_4f18117edb5d349d = 0;
    }
    
    if ( isusingmatchrulesdata() )
    {
        requiredplayers = getmatchrulesdata( "commonOption", "squadSize" );
    }
    
    level sdutils_init();
    utility::registersharedfunc( #"leagueplay", #"getskilldivisiontier", &function_806f8c2692238219 );
    utility::registersharedfunc( #"leagueplay", #"hash_de8b19a1bca1e95b", &function_8e883539e67cd13d );
    utility::registersharedfunc( #"leagueplay", #"hash_ccd8bef4e302e3ce", &sdutils_onsdachievementinfofetched );
    level thread onconnect();
    level thread ongameplaying();
    var_a0b888b256fed7b0 = int( tablelookup( "mp/leagueplay_config.csv", 0, "ladderPointsPlacement", 1 ) );
    level.leagueplayseason = function_56063b1401b23270();
    
    if ( getdvarint( @"hash_3438d68f1f0e7c0a", 1 ) && level.var_309e3d9dac389de6 )
    {
        level.var_38896f7c8ea269da = &function_30021a5c73f85182;
        level.onplayerkilledcallback = &function_4736ad281ce0b9ee;
        level.var_bbd722ce00189d4f = &function_819d9e136ca8a19e;
        level.var_5e5ae35d1b932ce = &function_ce2029450ffad3d8;
        level function_66f7b9b26d8e205a();
    }
    
    level thread function_8ac1007b6376fae8();
    level thread trackprematch();
}

// Namespace leagueplay_br
// Params 0
// Checksum 0xb05b7192, Offset: 0x12d1
// Size: 0x38
function prematchperiod()
{
    level endon( #"game_ended" );
    
    if ( !level.skipprematch )
    {
        level waittill( #"start_prematch" );
        level thread function_e38b7eb25d8fb8f1();
        level thread function_cac3d8a05c116261();
    }
}

// Namespace leagueplay_br
// Params 0
// Checksum 0x3b9bf9a3, Offset: 0x1311
// Size: 0xe8
function onconnect()
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        level waittill( #"connected", player );
        
        if ( level.leagueplaymatchcancelled )
        {
            return;
        }
        
        if ( !isplayer( player ) || isbot( player ) )
        {
            continue;
        }
        
        xuid = player getxuid();
        
        if ( !function_c503b9ecdb626de7( player ) )
        {
            player function_a05e0b1d2b3361a9();
        }
        
        if ( getdvarint( @"hash_7e8b150c928a062f", 0 ) )
        {
            player match_start();
            player function_51a06cc9021b07bd();
        }
        
        var_80d6fcf6ec58b102 = player.pers[ "LPAllowLeave" ] ? 2 : 3;
        player setclientomnvar( "ui_leagueplay_allow_quit", var_80d6fcf6ec58b102 );
        player setclientomnvar( "ui_league_play_br_can_leave_with_party", 0 );
        player setclientomnvar( "ui_anti_teaming_detected", 0 );
    }
}

// Namespace leagueplay_br
// Params 1
// Checksum 0x32b9e06e, Offset: 0x1401
// Size: 0x324
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
    
    player.pers[ "leaguePlayDisconnected" ] = 0;
    player.pers[ "leaguePlayMatchCompleted" ] = 0;
    xuid = player getxuid();
    
    if ( function_c503b9ecdb626de7( player ) )
    {
        squadmates = teams::getteamdata( player.team, "players" );
        completesquad = 1;
        
        foreach ( squadmate in squadmates )
        {
            squadmatexuid = squadmate getxuid();
            logstring( "LeaguePlay: Checking user: " + squadmatexuid );
            
            if ( squadmate.pers[ "leaguePlayDisconnected" ] == 1 )
            {
                logstring( "LeaguePlay: Incomplete squad, skipping loss forgiveness changes due to" + squadmatexuid + " still disconnected" );
                completesquad = 0;
                break;
            }
        }
        
        if ( completesquad )
        {
            player function_9d60100a8b22a41d( 0 );
        }
        
        leagueseason = function_366e3fa5964379cc();
        gamemode = challenges::getchallengegamemode();
        aeeventname = #"connection_update";
        aeeventid = ae_utility::function_8645a430dc4bffb9( aeeventname );
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
        
        player function_2e45314624fdfdb8( aeeventid, eventparams );
        
        foreach ( ent in level.players )
        {
            if ( ent.team == player.team && isplayer( ent ) )
            {
                ent setclientomnvar( "ui_leagueplay_allow_quit", 3 );
                ent.pers[ "LPAllowLeave" ] = 0;
            }
        }
    }
}

// Namespace leagueplay_br
// Params 2
// Checksum 0x40ac0498, Offset: 0x172d
// Size: 0x71e
function ondisconnect( player, aeeventname )
{
    if ( !isdefined( player ) )
    {
        logstring( "LeaguePlay: Skipping disconnect penalty due to undefined player parameter" );
        return;
    }
    
    xuid = player getxuid();
    
    if ( !isdefined( xuid ) )
    {
        logstring( "LeaguePlay: Skipping disconnect penalty due to undefined xuid" );
        return;
    }
    
    if ( !isplayer( player ) || isbot( player ) )
    {
        logstring( "LeaguePlay: Skipping disconnect penalty due to not being a player, or a bot, xuid " + xuid );
        return;
    }
    
    if ( player.pers[ "leaguePlayMatchCompleted" ] || level.leagueplaymatchcancelled || level.gameended )
    {
        logstring( "LeaguePlay: Skipping disconnect penalty due to game already ended, xuid " + xuid );
        return;
    }
    
    if ( !isdefined( player.team ) )
    {
        logstring( "LeaguePlay: Skipping disconnect penalty due to undefined team, xuid " + xuid );
        return;
    }
    
    if ( !isdefined( player.pers[ "leaguePlayInit" ] ) || player.pers[ "leaguePlayInit" ] == 0 )
    {
        logstring( "LeaguePlay: Skipping disconnect penalty due to not being initialized, xuid " + xuid );
        return;
    }
    
    squadmembers = [];
    
    if ( level.matchmakingmatch )
    {
        squadmembers = player getfireteammembers();
    }
    
    foreach ( ent in level.players )
    {
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
    
    disconnectreason = 0;
    playercounts = teams::countplayers();
    var_c9af7ebf58a31f3b = player getclientomnvar( "ui_league_play_br_leave_penalty_timer" );
    xuid = player getxuid();
    
    if ( isdefined( playercounts[ player.team ] ) && playercounts[ player.team ] == level.var_2efde9eff50b0385 - 1 )
    {
        disconnectreason = 1;
    }
    else
    {
        disconnectreason = 2;
    }
    
    if ( isdefined( player.var_3693a4c7e6bdc44 ) && player.var_3693a4c7e6bdc44 )
    {
        disconnectreason = 3;
    }
    else if ( isdefined( player.var_3ac39ef107e8744a ) && player.var_3ac39ef107e8744a )
    {
        disconnectreason = 7;
    }
    else if ( player.pers[ "leaguePlayIncompleteSquad" ] )
    {
        logstring( "LeaguePlay: Sending unpenalized disconnect due to incomplete squad kick, xuid " + xuid );
        disconnectreason = 13;
    }
    else if ( isdefined( player.pers[ "leaguePlayActivityPartyKick" ] ) )
    {
        logstring( "LeaguePlay: Skipping unpenalized disconnect due to incomplete activity party kick, xuid " + xuid );
        disconnectreason = 13;
    }
    else if ( gamelogic_mp::inprematch() )
    {
        disconnectreason = 9;
        
        if ( getdvarint( @"hash_6aad2f4df487c409", 1 ) && isdefined( player.pers[ "subpartyIndex" ] ) && player.pers[ "subpartyIndex" ] != -1 )
        {
            playerxuid = player getxuid();
            squadmates = teams::getteamdata( player.team, "players" );
            
            foreach ( squadmate in squadmates )
            {
                if ( playerxuid != squadmate getxuid() )
                {
                    if ( isdefined( squadmate.pers[ "subpartyIndex" ] ) && squadmate.pers[ "subpartyIndex" ] != -1 && squadmate.pers[ "subpartyIndex" ] == player.pers[ "subpartyIndex" ] )
                    {
                        logstring( "LeaguePlay: Marking client for kick, xuid: " + squadmate getxuid() + " ( subpartyId: " + squadmate.pers[ "subpartyIndex" ] + " ) due to disconnected activity party member in prematch" );
                        squadmate.pers[ "leaguePlayActivityPartyKick" ] = 0;
                    }
                }
            }
        }
    }
    else if ( var_c9af7ebf58a31f3b == 0 )
    {
        disconnectreason = 12;
    }
    
    if ( !gamelogic_mp::inprematch() && disconnectreason != 9 && disconnectreason != 13 )
    {
        placement = challenges::function_9cfa1e7b6e5d8ce7() + 1;
        
        if ( getdvarint( @"hash_da00458ff3dcc382", 0 ) && isdefined( player.teamplacement ) )
        {
            placement = player.teamplacement;
        }
        
        is_disconnect = !( player.squadwiped && br::function_1f2e8fad0c533e2d( player.team ) == 0 );
        logstring( "LeaguePlay: Triggering match end for disconnecting(" + is_disconnect + ") player xuid " + xuid );
        match_end( placement, 0, is_disconnect );
    }
    
    if ( player.squadwiped )
    {
        logstring( "LeaguePlay: Skipping disconnect penalty due to player squad wiped, xuid " + xuid );
        return;
    }
    
    if ( br::function_1f2e8fad0c533e2d( player.team ) == 0 )
    {
        logstring( "LeaguePlay: Skipping disconnect penalty due to player squad eliminated, xuid " + xuid );
        return;
    }
    
    if ( getdvarint( @"leagueplay_enable_loss_forgiveness", 0 ) )
    {
        var_db9d8a1f9cdb8604 = disconnectreason == 1;
        var_db9d8a1f9cdb8604 = var_db9d8a1f9cdb8604 || disconnectreason == 3;
        var_db9d8a1f9cdb8604 = var_db9d8a1f9cdb8604 || disconnectreason == 7;
        
        if ( var_db9d8a1f9cdb8604 )
        {
            player function_9d60100a8b22a41d( 100 );
        }
    }
    
    player.pers[ "leaguePlayDisconnected" ] = 1;
    logstring( "LeaguePlay: Disconnection for user " + xuid + " ( subpartyId: " + player.pers[ "subpartyIndex" ] + " ) with reason: " + disconnectreason );
    leagueseason = function_366e3fa5964379cc();
    gamemode = challenges::getchallengegamemode();
    eventparams = [];
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"leagueplay_is_disconnect" ) ] = 1;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"leagueplay_match_id" ) ] = getonlinematchid();
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"leagueplay_lobby_id" ) ] = getlobbyid();
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"disconnect_reason" ) ] = disconnectreason;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"rejoin_expiry" ) ] = rejoin_utility::function_b47f0ab881878ae5();
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"leagueplay_gametype" ) ] = level.leaguegametype;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"gamemode" ) ] = gamemode;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"leagueplay_rejoin_enabled" ) ] = rejoin_utility::function_5ed88373949103a8() && function_8cb4891672cca914();
    
    if ( leagueseason > -1 )
    {
        eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"leagueplay_event_season" ) ] = leagueseason;
    }
    
    return eventparams;
}

// Namespace leagueplay_br
// Params 2
// Checksum 0xbd87d3e4, Offset: 0x1e54
// Size: 0x55, Type: bool
function function_54cc746f7ad4b08a( player, var_b5a798314313c162 )
{
    if ( var_b5a798314313c162 == 2 || var_b5a798314313c162 == 14 )
    {
        var_c9af7ebf58a31f3b = player getclientomnvar( "ui_league_play_br_leave_penalty_timer" );
        
        if ( var_c9af7ebf58a31f3b == 0 && level.var_d71feeda79e7a947 )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace leagueplay_br
// Params 0
// Checksum 0x6878c10a, Offset: 0x1eb2
// Size: 0xf3
function ongameplaying()
{
    level endon( #"game_ended" );
    level thread prematchperiod();
    utility::flag_wait( "br_prematchEnded" );
    
    if ( level.leagueplaymatchcancelled )
    {
        return;
    }
    
    if ( getdvarint( @"hash_3438d68f1f0e7c0a", 1 ) && level.var_309e3d9dac389de6 )
    {
        thread function_510c9e09ce0a2b3e();
    }
    
    function_3942d98fc53f802d( "on_game_playing" );
    
    if ( !getdvarint( @"hash_7e8b150c928a062f", 0 ) )
    {
        foreach ( player in level.players )
        {
            player match_start();
        }
        
        function_8e883539e67cd13d();
    }
}

// Namespace leagueplay_br
// Params 1
// Checksum 0x30490850, Offset: 0x1fad
// Size: 0x14d
function function_9d60100a8b22a41d( forgivenesslevel )
{
    player = self;
    playerxuid = player getxuid();
    squadmates = teams::getteamdata( player.team, "players" );
    
    foreach ( squadmate in squadmates )
    {
        squadmatexuid = squadmate getxuid();
        
        if ( playerxuid != squadmatexuid )
        {
            if ( isdefined( squadmate.pers[ "subpartyIndex" ] ) )
            {
                if ( squadmate.pers[ "subpartyIndex" ] != -1 && squadmate.pers[ "subpartyIndex" ] != player.pers[ "subpartyIndex" ] )
                {
                    logstring( "LeaguePlay: due to user: " + playerxuid + " disconnecting, setting forgiveness to " + forgivenesslevel + " for user " + squadmatexuid );
                    squadmate.pers[ "forgiveness_level" ] = forgivenesslevel;
                }
            }
        }
    }
}

// Namespace leagueplay_br
// Params 0
// Checksum 0x89f5b8ac, Offset: 0x2102
// Size: 0x31
function trackprematch()
{
    if ( level.skipprematch )
    {
        return;
    }
    
    level.isprematch = 1;
    level waittill( #"prematch_done" );
    level.isprematch = 0;
}

// Namespace leagueplay_br
// Params 1
// Checksum 0xbedf7a3c, Offset: 0x213b
// Size: 0x2ab
function function_3942d98fc53f802d( string )
{
    /#
        if ( getdvarint( @"hash_1b391677375c45cd", 1 ) == 0 )
        {
            return;
        }
        
        logstring( "<dev string:x24>" );
        logstring( "<dev string:x30>" + string + "<dev string:x3e>" );
        logstring( "<dev string:x4a>" );
        logstring( "<dev string:x62>" + level.var_2a1c2ca4b438f84a );
        logstring( "<dev string:x96>" + getdvarint( @"br_minplayers", 1 ) );
        logstring( "<dev string:xca>" + getdvarint( @"hash_42b032b7e139b113", 1 ) );
        logstring( "<dev string:xfe>" + getdvarint( @"hash_520364dd384db9e7", 1 ) );
        logstring( "<dev string:x132>" + level.var_8de06ad448eee278 );
        logstring( "<dev string:x166>" + level.var_945d2c29ab5743a1 );
        logstring( "<dev string:x24>" );
        logstring( "<dev string:x19a>" );
        logstring( "<dev string:x1bb>" + level.players.size );
        logstring( "<dev string:x1ef>" + gamelogic_mp::getstreamedinplayercount() );
        logstring( "<dev string:x223>" + function_8ec59691ae5ff60c() );
        logstring( "<dev string:x24>" );
        logstring( "<dev string:x257>" );
        teamindex = 0;
        
        foreach ( teamname in level.teamnamelist )
        {
            players = teams::getteamdata( teamname, "<dev string:x275>" );
            playerindex = 0;
            
            foreach ( player in players )
            {
                logstring( "<dev string:x27d>" + teamindex + "<dev string:x297>" + playerindex + "<dev string:x2a4>" + player getxuid() + "<dev string:x2af>" + player.pers[ "<dev string:x2c1>" ] + "<dev string:x2cf>" + player.pers[ "<dev string:x2e0>" ] );
                playerindex += 1;
            }
            
            if ( players.size > 0 )
            {
                logstring( "<dev string:x24>" );
            }
            
            teamindex += 1;
        }
    #/
}

// Namespace leagueplay_br
// Params 0
// Checksum 0x460eb182, Offset: 0x23ee
// Size: 0x189
function function_613abac28dffe547()
{
    if ( getdvarint( @"hash_520364dd384db9e7", 1 ) == 1 )
    {
        foreach ( team in level.teamnamelist )
        {
            teamcount = teams::getteamdata( team, "teamCount" );
            
            if ( teamcount != level.var_2efde9eff50b0385 )
            {
                players = teams::getteamdata( team, "players" );
                
                foreach ( player in players )
                {
                    player dlog_recordplayerevent( "dlog_event_br_lp_kick", [ "reason", "Kicked due to incomplete squad" ] );
                    logstring( "LeaguePlay: Kicking " + player getxuid() + " due to incomplete squad" );
                    player.pers[ "leaguePlayIncompleteSquad" ] = 1;
                    kick( player getentitynumber(), &"exe/playerkicked_incompletesquad" );
                }
            }
        }
    }
}

// Namespace leagueplay_br
// Params 0
// Checksum 0x9bd36f47, Offset: 0x257f
// Size: 0x41
function function_cac3d8a05c116261()
{
    level endon( #"game_ended" );
    level endon( #"prematch_done" );
    
    if ( getdvarint( @"hash_f5c6c9de0d50a94a", 1 ) == 0 )
    {
        return;
    }
    
    while ( true )
    {
        function_613abac28dffe547();
        wait 3;
    }
}

// Namespace leagueplay_br
// Params 0
// Checksum 0xe68f0192, Offset: 0x25c8
// Size: 0x2ec
function function_8ac1007b6376fae8()
{
    level endon( #"game_ended" );
    level endon( #"prematch_started" );
    logstring( "LeaguePlay: waiting for players to stream in" );
    waitforplayers();
    logstring( "LeaguePlay: done waiting for players to stream in" );
    
    if ( getdvarint( @"hash_4e03166c385327ee", 1 ) == 1 )
    {
        timeout = gettime() + level.var_8de06ad448eee278 * 1000;
        
        while ( gettime() < timeout )
        {
            numvsps = function_8ec59691ae5ff60c();
            
            if ( numvsps >= level.var_2a1c2ca4b438f84a )
            {
                if ( getdvarint( @"hash_17699fe04fac9749", 1 ) == 1 )
                {
                    logstring( "LeaguePlay: live_lobby_minplayers_start ( " + level.var_2a1c2ca4b438f84a + " ) requirement satisfied" );
                    break;
                }
                else if ( getdvarint( @"hash_efba2ae3c5b484c7", 1 ) == 1 )
                {
                    if ( numvsps >= level.var_15bca072e6eafdd5 )
                    {
                        logstring( "LeaguePlay: max_vsps_during_backfill requirement satisfied" );
                        break;
                    }
                }
            }
            
            foreach ( player in level.players )
            {
                if ( player.pers[ "leaguePlayActivityPartyKick" ] == 0 )
                {
                    player dlog_recordplayerevent( "dlog_event_br_lp_kick", [ "reason", "Activity party kick" ] );
                    logstring( "LeaguePlay: kicking player xuid: " + player getxuid() + " since they've been marked for activity party kick" );
                    player.pers[ "leaguePlayActivityPartyKick" ] = 1;
                    kick( player getentitynumber(), &"exe/playerkicked_incompletesquad" );
                }
            }
            
            if ( isdefined( level.players ) && level.players.size < level.minplayersbeforedisband )
            {
                if ( getdvarint( @"hash_42b032b7e139b113", 1 ) == 1 )
                {
                    dlog_recordevent( "dlog_event_br_lp_match_cancel", [ "reason", "Player count dropped below minplayersBeforeDisband while backfilling", "player_count", level.players.size, "min_players", level.minplayersbeforedisband ] );
                    logstring( "LeaguePlay: cancel match due to player count(" + level.players.size + ") dropping below disband threshold(" + level.minplayersbeforedisband + ")" );
                    thread cancel_match();
                    return;
                }
            }
            
            wait level.var_50d320049979faa4;
        }
    }
    
    logstring( "LeaguePlay: closing join in progress" );
    function_3942d98fc53f802d( "join in progress closed" );
    function_a14deb691144654e();
    function_613abac28dffe547();
    logstring( "LeaguePlay: kicked incomplete players if there were any, notifying that backfill closed" );
    
    if ( getdvarint( @"hash_51aa9c88bb0c1224", 1 ) == 1 )
    {
        level notify( #"leagueplay_br_backfill_closed" );
    }
}

// Namespace leagueplay_br
// Params 0
// Checksum 0x14fb1f4a, Offset: 0x28bc
// Size: 0xce
function function_8ec59691ae5ff60c()
{
    var_d809f3e4a8f4dfc = getdvarint( @"hash_52c2d6ea6600d2aa", -1 );
    
    if ( var_d809f3e4a8f4dfc >= 0 )
    {
        return var_d809f3e4a8f4dfc;
    }
    
    numvsps = 0;
    
    foreach ( team in level.teamnamelist )
    {
        teamcount = teams::getteamdata( team, "teamCount" );
        
        if ( teamcount == level.var_2efde9eff50b0385 )
        {
            numvsps += teamcount;
        }
    }
    
    return numvsps;
}

// Namespace leagueplay_br
// Params 0
// Checksum 0xdcad66c9, Offset: 0x2993
// Size: 0x1f
function function_a14deb691144654e()
{
    setnojipscore( 1, 1 );
    setnojiptime( 1, 1 );
    level.nojip = 1;
}

// Namespace leagueplay_br
// Params 0
// Checksum 0xdc09cd58, Offset: 0x29ba
// Size: 0x7e
function waitforplayers()
{
    starttime = gettime();
    endtime = starttime + level.var_945d2c29ab5743a1 * 1000;
    
    while ( true )
    {
        curtime = gettime();
        var_1eb7b19bd246a0ad = gamelogic_mp::getstreamedinplayercount();
        var_1850a9749b8a371a = var_1eb7b19bd246a0ad >= level.minplayersbeforedisband + 4;
        
        if ( var_1850a9749b8a371a || curtime > endtime )
        {
            break;
        }
        
        wait 1;
    }
}

// Namespace leagueplay_br
// Params 0
// Checksum 0x28cb0c9e, Offset: 0x2a40
// Size: 0xd5
function function_e38b7eb25d8fb8f1()
{
    level endon( #"game_ended" );
    level endon( #"prematch_done" );
    
    if ( getdvarint( @"hash_42b032b7e139b113", 1 ) == 0 )
    {
        return;
    }
    
    minplayers = getdvarint( @"br_minplayers", 1 );
    
    while ( function_8ec59691ae5ff60c() >= minplayers )
    {
        wait 1;
    }
    
    dlog_recordevent( "dlog_event_br_lp_match_cancel", [ "reason", "Low VSP count in prematch", "player_count", level.players.size, "min_players", minplayers ] );
    
    /#
        numvsps = function_8ec59691ae5ff60c();
        logstring( "<dev string:x2f3>" + numvsps + "<dev string:x321>" + minplayers + "<dev string:x341>" );
    #/
    
    thread cancel_match();
}

// Namespace leagueplay_br
// Params 0
// Checksum 0xcf8ed874, Offset: 0x2b1d
// Size: 0x1c9
function function_2016316708f14845()
{
    if ( level.var_66b6ced16e22b45f )
    {
        return;
    }
    
    foreach ( player in level.players )
    {
        if ( isdefined( player ) && player rejoin_utility::function_e421863f0f4de34() && player rejoin_utility::function_8572dd98c6c59dc4() )
        {
            logstring( "LeaguePlay: calling setLobbyNotRejoinable to rollback penalty due to squads dropping below rejoinable threshold" );
            leagueseason = function_366e3fa5964379cc();
            gamemode = challenges::getchallengegamemode();
            aeeventname = #"connection_update";
            aeeventid = ae_utility::function_8645a430dc4bffb9( aeeventname );
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
            
            player rejoin_utility::setlobbynotrejoinable( 0, 1, aeeventname, eventparams );
        }
    }
    
    level.var_66b6ced16e22b45f = 1;
}

// Namespace leagueplay_br
// Params 1
// Checksum 0xaf6f1f83, Offset: 0x2cee
// Size: 0x1cb
function function_566a3530d661827c( team )
{
    teamplayers = teams::getteamdata( team, "players" );
    
    foreach ( player in teamplayers )
    {
        if ( isdefined( player ) && player rejoin_utility::function_e421863f0f4de34() && player rejoin_utility::function_8572dd98c6c59dc4() )
        {
            logstring( "LeaguePlay: calling setLobbyNotRejoinable to rollback penalty due to no teammates being alive" );
            leagueseason = function_366e3fa5964379cc();
            gamemode = challenges::getchallengegamemode();
            aeeventname = #"connection_update";
            aeeventid = ae_utility::function_8645a430dc4bffb9( aeeventname );
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
            
            player rejoin_utility::setlobbynotrejoinable( 0, 1, aeeventname, eventparams );
        }
    }
}

// Namespace leagueplay_br
// Params 1
// Checksum 0x45ae4763, Offset: 0x2ec1
// Size: 0x37, Type: bool
function function_c503b9ecdb626de7( player )
{
    if ( isdefined( player.pers[ "leaguePlayInit" ] ) )
    {
        return ( player.pers[ "leaguePlayInit" ] == 1 );
    }
    
    return false;
}

// Namespace leagueplay_br
// Params 0
// Checksum 0xc6689922, Offset: 0x2f01
// Size: 0xe8
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
    player.pers[ "sr" ] = player getplayerdata( level.var_6f9b00680ed002d8, "leaguePlayData", level.leagueplaytype, "season", level.leagueplayseason, "sr" );
    player function_964197d86128a797();
    player.pers[ "leaguePlayInit" ] = 1;
}

// Namespace leagueplay_br
// Params 0
// Checksum 0xfde8a8f3, Offset: 0x2ff1
// Size: 0x175
function cancel_match()
{
    level endon( #"game_ended" );
    warningtime = getdvarfloat( @"hash_d8ed8c2fccd1d9b1", 30 );
    
    if ( warningtime > 0 )
    {
        level.var_59cffb353d98bc10 = 1;
        thread gamelogic_mp::function_d441498194756fb2( warningtime * 1000, "match_cancelling_in_squads" );
    }
    
    setomnvar( "ui_prematch_period", 0 );
    level.leagueplaymatchcancelled = 1;
    level.var_46b9986eed75f973 = 0;
    level.brdisablefinalkillcam = 1;
    wait warningtime;
    
    if ( getdvarint( @"online_mp_clientmatchdata_enabled" ) != 0 )
    {
        foreach ( player in level.players )
        {
            player function_964197d86128a797();
        }
    }
    
    if ( !getdvarint( @"hash_b42271f0cb794f9e", 1 ) )
    {
        gamescore::updateplacement();
        gamelogic_mp::processlobbydata();
    }
    else if ( getdvarint( @"online_mp_clientmatchdata_enabled" ) != 0 )
    {
        sendclientmatchdata();
    }
    
    if ( !flags::gameflag( "prematch_done" ) )
    {
        force_match_end();
        wait 1;
        level notify( #"exitlevel_called" );
        exitlevel( 0 );
        return;
    }
    
    level thread gamelogic_mp::forceend();
}

// Namespace leagueplay_br
// Params 0
// Checksum 0x77162d65, Offset: 0x316e
// Size: 0x4b
function function_964197d86128a797()
{
    player = self;
    
    if ( !isdefined( player.clientmatchdataid ) )
    {
        gamelogic_mp::assignclientmatchdataid( player );
    }
    
    setclientmatchdata( "players", player.clientmatchdataid, "leaguePlayMatchCancelled", level.leagueplaymatchcancelled );
}

// Namespace leagueplay_br
// Params 0
// Checksum 0xd4bc5a4b, Offset: 0x31c1
// Size: 0x1c
function function_366e3fa5964379cc()
{
    if ( level.leagueplayseason >= 0 )
    {
        return level.leagueplayseason;
    }
    
    return -1;
}

// Namespace leagueplay_br
// Params 2
// Checksum 0x4065976, Offset: 0x31e6
// Size: 0x33
function get_match_result( placement, matchcancelled )
{
    if ( matchcancelled )
    {
        return 0;
    }
    
    if ( !isdefined( placement ) )
    {
        return 2;
    }
    
    if ( placement == 1 )
    {
        return 3;
    }
    
    return 1;
}

// Namespace leagueplay_br
// Params 0
// Checksum 0xfccef784, Offset: 0x3222
// Size: 0x209
function match_start()
{
    player = self;
    
    if ( !isplayer( player ) || isbot( player ) )
    {
        return;
    }
    
    if ( !isdefined( player.pers[ "leaguePlayInit" ] ) || player.pers[ "leaguePlayInit" ] == 0 )
    {
        return;
    }
    
    if ( player.pers[ "leaguePlayDisconnected" ] )
    {
        return;
    }
    
    lobbyid = getlobbyid();
    matchid = getonlinematchid();
    leagueseason = function_366e3fa5964379cc();
    gamemode = challenges::getchallengegamemode();
    
    if ( isdefined( level.leagueid ) && leagueseason > -1 )
    {
        aeeventname = #"leagueplay_start_game";
        aeeventid = ae_utility::function_8645a430dc4bffb9( aeeventname );
        eventparams = [];
        eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"leagueplay_league_id" ) ] = level.leagueid;
        eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"leagueplay_event_season" ) ] = leagueseason;
        eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"leagueplay_match_id" ) ] = matchid;
        eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"leagueplay_lobby_id" ) ] = lobbyid;
        eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"leagueplay_event_type" ) ] = level.var_4f18117edb5d349d;
        eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"leagueplay_gametype" ) ] = level.leaguegametype;
        eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"gamemode" ) ] = gamemode;
        eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"leagueplay_match_sr_version" ) ] = level.var_75c5c71dd0761200;
        eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"leagueplay_match_sr_cap" ) ] = level.var_1903e23485def131;
        
        if ( utility::issharedfuncdefined( #"challenges", #"reportchallengeuserserializedeventwrapper" ) )
        {
            utility::callsharedfunc( #"challenges", #"reportchallengeuserserializedeventwrapper", aeeventid, eventparams );
        }
    }
}

// Namespace leagueplay_br
// Params 3
// Checksum 0x46591fc1, Offset: 0x3433
// Size: 0x3ba
function match_end( placement, at_match_end, is_disconnect )
{
    player = self;
    xuid = player getxuid();
    
    if ( !isdefined( placement ) )
    {
        placement = 0;
    }
    
    if ( !isdefined( at_match_end ) )
    {
        logstring( "LeaguePlay: Skipping match_end due to undefined at_match_end for xuid " + xuid );
        return;
    }
    
    if ( !isplayer( player ) || isbot( player ) )
    {
        logstring( "LeaguePlay: Skipping match_end due to entity not being a player." );
        return;
    }
    
    if ( !isdefined( player.pers[ "leaguePlayInit" ] ) || player.pers[ "leaguePlayInit" ] == 0 )
    {
        logstring( "LeaguePlay: Skipping match_end due to leaguePlayInit not being set for xuid " + xuid );
        return;
    }
    
    if ( player.pers[ "leaguePlayMatchCompleted" ] )
    {
        logstring( "LeaguePlay: Skipping match_end since it has already been sent for xuid " + xuid );
        return;
    }
    
    player.pers[ "leaguePlayMatchCompleted" ] = 1;
    matchcancelled = istrue( level.leagueplaymatchcancelled );
    leagueseason = function_366e3fa5964379cc();
    gamemode = challenges::getchallengegamemode();
    lobbyid = getlobbyid();
    matchid = getonlinematchid();
    var_927372d73961eaaa = getdvarint( @"hash_74b99125b3898193", 86400 );
    forgiveness_level = player.pers[ "forgiveness_level" ];
    
    if ( !isdefined( forgiveness_level ) )
    {
        forgiveness_level = 0;
    }
    
    matchresult = player get_match_result( placement, matchcancelled );
    
    if ( !isdefined( level.leagueid ) )
    {
        logstring( "LeaguePlay: Skipping match end event due to invalid league ID for user " + xuid );
        return;
    }
    
    if ( !isdefined( matchresult ) )
    {
        logstring( "LeaguePlay: Skipping match end event due to invalid match result for user " + xuid );
        return;
    }
    
    if ( leagueseason <= -1 )
    {
        logstring( "LeaguePlay: Skipping match end event due to invalid league season for user " + xuid );
        return;
    }
    
    aeeventname = #"leagueplay_end_game";
    aeeventid = ae_utility::function_8645a430dc4bffb9( aeeventname );
    eventparams = [];
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"leagueplay_league_id" ) ] = level.leagueid;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"leagueplay_match_result" ) ] = matchresult;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"leagueplay_event_season" ) ] = leagueseason;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"leagueplay_match_id" ) ] = matchid;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"leagueplay_lobby_id" ) ] = lobbyid;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"leagueplay_event_type" ) ] = level.var_4f18117edb5d349d;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"leagueplay_hot_streak_cooldown_s" ) ] = var_927372d73961eaaa;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"leagueplay_at_match_end" ) ] = at_match_end;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"leagueplay_gametype" ) ] = level.leaguegametype;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"gamemode" ) ] = gamemode;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"leagueplay_forgiveness_level" ) ] = forgiveness_level;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"leagueplay_placement" ) ] = placement;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"leagueplay_is_disconnect" ) ] = is_disconnect;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"leagueplay_rejoin_enabled" ) ] = rejoin_utility::function_5ed88373949103a8() && function_8cb4891672cca914();
    
    if ( getdvarint( @"hash_6c80c23763bc8efb", 0 ) )
    {
        player thread function_3d1127590137c947( eventparams );
        return;
    }
    
    if ( utility::issharedfuncdefined( #"challenges", #"reportchallengeuserserializedeventwrapper" ) )
    {
        player utility::callsharedfunc( #"challenges", #"reportchallengeuserserializedeventwrapper", "80", eventparams );
    }
    
    thread challenges::function_21b5f21603591966( self );
}

// Namespace leagueplay_br
// Params 1
// Checksum 0xe5e32d51, Offset: 0x37f5
// Size: 0x7b
function function_3d1127590137c947( reportvalues )
{
    var_6532087ad4fd0378 = getdvarfloat( @"hash_743498c38d8aa460", 2 );
    utility::waittill_any_timeout( var_6532087ad4fd0378, "disconnect" );
    
    if ( utility::issharedfuncdefined( #"challenges", #"reportchallengeuserserializedeventwrapper" ) )
    {
        utility::callsharedfunc( #"challenges", #"reportchallengeuserserializedeventwrapper", "80", reportvalues );
    }
    
    thread challenges::function_21b5f21603591966( self );
}

// Namespace leagueplay_br
// Params 0
// Checksum 0xf1d8131b, Offset: 0x3878
// Size: 0x34b
function force_match_end()
{
    level.gameended = 1;
    level.leagueplaymatchcompleted = 1;
    matchcancelled = istrue( level.leagueplaymatchcancelled );
    leagueseason = function_366e3fa5964379cc();
    gamemode = challenges::getchallengegamemode();
    lobbyid = getlobbyid();
    matchid = getonlinematchid();
    var_927372d73961eaaa = getdvarint( @"hash_74b99125b3898193", 86400 );
    
    foreach ( player in level.players )
    {
        if ( !isplayer( player ) || isbot( player ) )
        {
            continue;
        }
        
        if ( !isdefined( player.pers[ "leaguePlayInit" ] ) || player.pers[ "leaguePlayInit" ] == 0 )
        {
            continue;
        }
        
        if ( player.pers[ "leaguePlayDisconnected" ] )
        {
            continue;
        }
        
        placement = 0;
        matchresult = player get_match_result( undefined, matchcancelled );
        
        if ( isdefined( level.leagueid ) && isdefined( matchresult ) && leagueseason > -1 )
        {
            aeeventname = #"leagueplay_end_game";
            aeeventid = ae_utility::function_8645a430dc4bffb9( aeeventname );
            eventparams = [];
            eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"leagueplay_league_id" ) ] = level.leagueid;
            eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"leagueplay_match_result" ) ] = matchresult;
            eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"leagueplay_event_season" ) ] = leagueseason;
            eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"leagueplay_match_id" ) ] = matchid;
            eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"leagueplay_lobby_id" ) ] = lobbyid;
            eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"leagueplay_event_type" ) ] = level.var_4f18117edb5d349d;
            eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"leagueplay_hot_streak_cooldown_s" ) ] = var_927372d73961eaaa;
            eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"leagueplay_at_match_end" ) ] = 1;
            eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"leagueplay_gametype" ) ] = level.leaguegametype;
            eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"gamemode" ) ] = gamemode;
            eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"leagueplay_forgiveness_level" ) ] = 100;
            eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"leagueplay_placement" ) ] = placement;
            eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"leagueplay_is_disconnect" ) ] = 0;
            eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"leagueplay_rejoin_enabled" ) ] = rejoin_utility::function_5ed88373949103a8() && function_8cb4891672cca914();
            
            if ( utility::issharedfuncdefined( #"challenges", #"reportchallengeuserserializedeventwrapper" ) )
            {
                player utility::callsharedfunc( #"challenges", #"reportchallengeuserserializedeventwrapper", aeeventid, eventparams );
            }
        }
    }
}

// Namespace leagueplay_br
// Params 0
// Checksum 0x9ffdb22b, Offset: 0x3bcb
// Size: 0x153
function sdutils_init()
{
    if ( isdefined( level.skilldivisions ) )
    {
        return;
    }
    
    level.skilldivisions = [];
    leagueplaydata = level.gametypebundle.leagueplaydata;
    leagueplaybundle = getscriptbundle( leagueplaydata.leagueplaybundle );
    assert( isdefined( leagueplaybundle ), "<dev string:x343>" );
    var_6a390d039900bd83 = 0;
    
    foreach ( skilldivision in leagueplaybundle.divisions )
    {
        var_5dbe46bb15d345f0 = getscriptbundle( skilldivision.bundle );
        
        if ( !isdefined( var_5dbe46bb15d345f0 ) )
        {
            /#
                logstring( "<dev string:x377>" + getxhashsourcename( var_5dbe46bb15d345f0 ) + "<dev string:x3a6>" );
            #/
            
            continue;
        }
        
        var_6a390d039900bd83 += var_5dbe46bb15d345f0.var_f4eef4db2e0157d0;
        level.skilldivisions[ level.skilldivisions.size ] = var_6a390d039900bd83;
    }
    
    level.var_976fbe4cd7a13c4c = level function_514533dd9d83b8b5( leagueplaybundle );
}

// Namespace leagueplay_br
// Params 1
// Checksum 0xd658d8bf, Offset: 0x3d26
// Size: 0xbe
function function_514533dd9d83b8b5( leagueplaybundle )
{
    var_2d424d92893ae18f = getdvarint( @"hash_a5b867e2e1c006a4", 0 );
    
    if ( var_2d424d92893ae18f > 0 )
    {
        return var_2d424d92893ae18f;
    }
    
    if ( !isdefined( leagueplaybundle ) )
    {
        return 0;
    }
    
    var_d414d7929c7dff16 = level.leagueplaytype == 2 ? leagueplaybundle.var_b89ea899f5c96b78 : leagueplaybundle.var_3c22cb2a15dc8cb6;
    
    if ( !isarray( var_d414d7929c7dff16 ) || var_d414d7929c7dff16.size == 0 )
    {
        return 0;
    }
    
    leagueplayseason = function_56063b1401b23270();
    var_3a688787cc4a3854 = leagueplayseason - 1;
    var_3a688787cc4a3854 = int( clamp( var_3a688787cc4a3854, 0, var_d414d7929c7dff16.size - 1 ) );
    return var_d414d7929c7dff16[ var_3a688787cc4a3854 ].achievementid;
}

// Namespace leagueplay_br
// Params 1
// Checksum 0x888253fc, Offset: 0x3ded
// Size: 0x64
function function_8542c13b4773ba7e( divisiontier )
{
    if ( !isdefined( level.skilldivisions ) )
    {
        return 0;
    }
    
    division = 0;
    
    for ( divisionindex = 0; divisionindex < level.skilldivisions.size ; divisionindex++ )
    {
        division = divisionindex;
        
        if ( divisiontier <= level.skilldivisions[ divisionindex ] )
        {
            break;
        }
    }
    
    return division;
}

// Namespace leagueplay_br
// Params 0
// Checksum 0xc6d57176, Offset: 0x3e5a
// Size: 0x1a
function function_808c5b4689d20db5()
{
    if ( !isdefined( self.skilldivision ) )
    {
        return;
    }
    
    return self.skilldivision;
}

// Namespace leagueplay_br
// Params 0
// Checksum 0x6ad44435, Offset: 0x3e7d
// Size: 0x1a
function function_806f8c2692238219()
{
    if ( !isdefined( self.skilldivisiontier ) )
    {
        return;
    }
    
    return self.skilldivisiontier;
}

// Namespace leagueplay_br
// Params 0
// Checksum 0xd9f083f6, Offset: 0x3ea0
// Size: 0x56
function function_8e883539e67cd13d()
{
    if ( !isdefined( level.players ) || level.players.size == 0 )
    {
        return;
    }
    
    if ( !isdefined( level.var_976fbe4cd7a13c4c ) || level.var_976fbe4cd7a13c4c == 0 )
    {
        return;
    }
    
    function_6e150ba45a6aa08( level.players, level.var_976fbe4cd7a13c4c );
}

// Namespace leagueplay_br
// Params 0
// Checksum 0xa9a3aefb, Offset: 0x3efe
// Size: 0x2f
function function_51a06cc9021b07bd()
{
    if ( !isdefined( level.var_976fbe4cd7a13c4c ) || level.var_976fbe4cd7a13c4c == 0 )
    {
        return;
    }
    
    self function_fdf029c4be6546a3( level.var_976fbe4cd7a13c4c );
}

// Namespace leagueplay_br
// Params 2
// Checksum 0x422b730d, Offset: 0x3f35
// Size: 0x136
function sdutils_onsdachievementinfofetched( achievementid, progressdata )
{
    if ( !isdefined( level.var_976fbe4cd7a13c4c ) || level.var_976fbe4cd7a13c4c == 0 )
    {
        return;
    }
    
    if ( achievementid != level.var_976fbe4cd7a13c4c )
    {
        return;
    }
    
    sd_id = playerachievements::function_a550b9c75bcbee5e( "sd" );
    sr_id = playerachievements::function_a550b9c75bcbee5e( "sr" );
    sd_tier = 0;
    sr = 0;
    
    for ( index = 0; index < progressdata.progress_values.size ; index++ )
    {
        progress_id = progressdata.progress_values[ index ].progress_id;
        
        if ( sd_id == progress_id )
        {
            sd_tier = progressdata.progress_values[ index ].progress;
            continue;
        }
        
        if ( sr_id == progress_id )
        {
            sr = progressdata.progress_values[ index ].progress;
        }
    }
    
    self.skilldivisiontier = sd_tier;
    self.skilldivision = function_8542c13b4773ba7e( sd_tier );
    self.var_fefcd9e884b5e8f6 = sr;
}

// Namespace leagueplay_br
// Params 1
// Checksum 0x4a29f2bb, Offset: 0x4073
// Size: 0x10b
function function_9c8bb146e5e7b9f2( var_e3850607516aa5c6 )
{
    assert( isdefined( var_e3850607516aa5c6 ), "<dev string:x3b2>" );
    var_f91803de226fc24a = undefined;
    
    foreach ( var_dfcc88b53561eac3 in var_e3850607516aa5c6.var_7649b1c07c144c86 )
    {
        bundleversion = var_dfcc88b53561eac3.version ?? 0;
        
        if ( bundleversion == level.var_75c5c71dd0761200 )
        {
            var_f91803de226fc24a = var_dfcc88b53561eac3;
            break;
        }
        
        var_612cc58760b848d1 = isdefined( var_f91803de226fc24a ) && isdefined( var_f91803de226fc24a.version ) ? var_f91803de226fc24a.version : 0;
        
        if ( !isdefined( var_f91803de226fc24a ) || bundleversion > var_612cc58760b848d1 )
        {
            var_f91803de226fc24a = var_dfcc88b53561eac3;
        }
    }
    
    return var_f91803de226fc24a;
}

// Namespace leagueplay_br
// Params 0
// Checksum 0x410bca2a, Offset: 0x4187
// Size: 0x55e
function function_66f7b9b26d8e205a()
{
    if ( isdefined( level.var_c32d8f56a923f130 ) )
    {
        return;
    }
    
    leagueplaydata = level.gametypebundle.leagueplaydata;
    var_dd4787f7dd562dfb = getscriptbundle( level.var_44a441b8aa147be ? leagueplaydata.var_e52c792ba5a5d89f : leagueplaydata.srtriggers );
    var_f91803de226fc24a = function_9c8bb146e5e7b9f2( var_dd4787f7dd562dfb );
    
    if ( !isdefined( var_f91803de226fc24a ) )
    {
        return;
    }
    
    level.var_c32d8f56a923f130 = spawnstruct();
    level.var_c32d8f56a923f130.var_b9a3d33aa6d2dd99 = [];
    level.var_c32d8f56a923f130.var_b9a3d33aa6d2dd99[ 0 ] = [];
    level.var_c32d8f56a923f130.var_b9a3d33aa6d2dd99[ 1 ] = [];
    
    foreach ( triggertype in var_f91803de226fc24a.triggers )
    {
        scorestruct = spawnstruct();
        scorestruct.var_e6ee6c02fc16d8a8 = [];
        scorestruct.srvalue = [];
        scorestruct.var_1abac0f6b369e042 = 0;
        scorestruct.var_1a97aaf6b3436828 = 0;
        
        foreach ( trigger in triggertype.triggers )
        {
            teamsremaining = trigger.var_e6ee6c02fc16d8a8;
            
            if ( !isdefined( teamsremaining ) )
            {
                teamsremaining = 0;
            }
            
            scorestruct.var_e6ee6c02fc16d8a8[ scorestruct.var_e6ee6c02fc16d8a8.size ] = teamsremaining;
            srval = trigger.sr;
            
            if ( !isdefined( srval ) )
            {
                srval = 0;
            }
            
            scorestruct.srvalue[ scorestruct.srvalue.size ] = srval;
            
            if ( isdefined( trigger.var_684051e9750c76b6 ) )
            {
                scorestruct.var_1abac0f6b369e042 = minint( scorestruct.var_1abac0f6b369e042, trigger.var_684051e9750c76b6 );
                scorestruct.var_1a97aaf6b3436828 = maxint( scorestruct.var_1a97aaf6b3436828, trigger.var_684051e9750c76b6 );
            }
        }
        
        if ( triggertype.triggername == #"placement" )
        {
            scorestruct.srvalue = function_3a7fce4b9166920d( scorestruct.srvalue );
            level.var_c32d8f56a923f130.var_b9a3d33aa6d2dd99[ 0 ][ 3 ] = scorestruct;
            var_bcf759f93df70bb3 = level.var_c32d8f56a923f130.var_b9a3d33aa6d2dd99[ 0 ][ 3 ].var_e6ee6c02fc16d8a8.size - 1;
            level.var_c32d8f56a923f130.var_df5fd0151e4e2fce = var_bcf759f93df70bb3;
            continue;
        }
        
        if ( triggertype.triggername == #"kill" )
        {
            level.var_c32d8f56a923f130.var_b9a3d33aa6d2dd99[ 0 ][ 0 ] = scorestruct;
            continue;
        }
        
        if ( triggertype.triggername == #"assist" )
        {
            level.var_c32d8f56a923f130.var_b9a3d33aa6d2dd99[ 0 ][ 1 ] = scorestruct;
            continue;
        }
        
        if ( triggertype.triggername == #"unassisted" )
        {
            level.var_c32d8f56a923f130.var_b9a3d33aa6d2dd99[ 0 ][ 2 ] = scorestruct;
            continue;
        }
        
        if ( triggertype.triggername == #"hash_ef097012a2e82b40" )
        {
            level.var_c32d8f56a923f130.var_b9a3d33aa6d2dd99[ 1 ][ 0 ] = scorestruct;
            continue;
        }
        
        if ( triggertype.triggername == #"hash_ca2f644dd8ec2e25" )
        {
            level.var_c32d8f56a923f130.var_b9a3d33aa6d2dd99[ 1 ][ 1 ] = scorestruct;
            continue;
        }
        
        if ( triggertype.triggername == #"hash_e9c9447bebc21117" )
        {
            level.var_c32d8f56a923f130.var_b9a3d33aa6d2dd99[ 1 ][ 2 ] = scorestruct;
        }
    }
    
    leagueplaydata = level.gametypebundle.leagueplaydata;
    var_91d8186c1678fa30 = getscriptbundle( level.var_44a441b8aa147be ? leagueplaydata.var_aca622fbd45954d : leagueplaydata.var_91d8186c1678fa30 );
    level.var_c32d8f56a923f130.var_b9a3d33aa6d2dd99[ 0 ][ 4 ] = function_864f45dfb511b31e( var_91d8186c1678fa30 );
    
    if ( function_37c8f788d4b9eb8c() )
    {
        var_c26394a9d5a70d7d = getscriptbundle( level.var_44a441b8aa147be ? leagueplaydata.var_882f361a4a111578 : leagueplaydata.var_c26394a9d5a70d7d );
        level.var_c32d8f56a923f130.var_b9a3d33aa6d2dd99[ 0 ][ 5 ] = function_864f45dfb511b31e( var_c26394a9d5a70d7d );
    }
}

// Namespace leagueplay_br
// Params 1
// Checksum 0x97ee3ee9, Offset: 0x46ed
// Size: 0x191
function function_864f45dfb511b31e( var_70dcef49b6aa63da )
{
    assert( isdefined( var_70dcef49b6aa63da ), "<dev string:x3d9>" );
    var_bbaa41f45835afcf = spawnstruct();
    var_bbaa41f45835afcf.beginsr = [];
    var_bbaa41f45835afcf.endsr = [];
    var_bbaa41f45835afcf.penaltyvalue = [];
    assert( isdefined( var_70dcef49b6aa63da.fees ), "<dev string:x401>" );
    index = 0;
    
    foreach ( var_4775937cadb7fa47 in var_70dcef49b6aa63da.fees )
    {
        beginsr = 0;
        endsr = 0;
        fee = 0;
        
        if ( isdefined( var_4775937cadb7fa47.beginsr ) )
        {
            beginsr = var_4775937cadb7fa47.beginsr;
        }
        
        if ( isdefined( var_4775937cadb7fa47.endsr ) )
        {
            endsr = var_4775937cadb7fa47.endsr;
        }
        
        if ( isdefined( var_4775937cadb7fa47.fee ) )
        {
            fee = var_4775937cadb7fa47.fee;
        }
        
        var_bbaa41f45835afcf.beginsr[ index ] = beginsr;
        var_bbaa41f45835afcf.endsr[ index ] = endsr;
        var_bbaa41f45835afcf.penaltyvalue[ index ] = fee;
        index++;
    }
    
    return var_bbaa41f45835afcf;
}

// Namespace leagueplay_br
// Params 1
// Checksum 0xf7ddc982, Offset: 0x4887
// Size: 0x67
function function_3a7fce4b9166920d( valuearray )
{
    newarray = [];
    
    for ( index = 0; index < valuearray.size ; index++ )
    {
        if ( index == valuearray.size - 1 )
        {
            newarray[ index ] = valuearray[ index ];
            break;
        }
        
        difference = valuearray[ index ] - valuearray[ index + 1 ];
        newarray[ index ] = difference;
    }
    
    return newarray;
}

// Namespace leagueplay_br
// Params 2
// Checksum 0x4ed72e1, Offset: 0x48f7
// Size: 0x105
function function_30021a5c73f85182( var_d2582f81d4be0c2, optionalarg )
{
    assert( isdefined( var_d2582f81d4be0c2 ), "<dev string:x446>" );
    player = self;
    
    if ( gamelogic_mp::inprematch() )
    {
        return;
    }
    
    if ( var_d2582f81d4be0c2 == "kill" )
    {
        player function_eb99300c499635cb( 0, optionalarg );
        return;
    }
    
    if ( var_d2582f81d4be0c2 == "assist" )
    {
        player function_eb99300c499635cb( 1, optionalarg );
        return;
    }
    
    if ( var_d2582f81d4be0c2 == "unassisted" )
    {
        player function_eb99300c499635cb( 2, optionalarg );
        return;
    }
    
    if ( var_d2582f81d4be0c2 == "placement" )
    {
        function_90ec197533705d5( 0, optionalarg );
        return;
    }
    
    if ( var_d2582f81d4be0c2 == "deploymentfee" )
    {
        player function_eb99300c499635cb( 4 );
        return;
    }
    
    if ( var_d2582f81d4be0c2 == "deathfee" )
    {
        player function_eb99300c499635cb( 5 );
        return;
    }
    
    if ( var_d2582f81d4be0c2 == "suspiciouskill" )
    {
        player function_eb99300c499635cb( 6 );
        return;
    }
    
    assertmsg( "<dev string:x478>" + var_d2582f81d4be0c2 + "<dev string:x492>" );
}

// Namespace leagueplay_br
// Params 2
// Checksum 0xf68236b, Offset: 0x4a04
// Size: 0xbc
function function_7ecf96173a234d69( srtype, var_100e6c14b8e52131 )
{
    valuestruct = function_2c0399136e4917a( srtype, 0 );
    assert( isdefined( valuestruct.var_e6ee6c02fc16d8a8 ), "<dev string:x4aa>" );
    maxtier = valuestruct.var_e6ee6c02fc16d8a8.size - 1;
    var_e6ee6c02fc16d8a8 = challenges::function_9cfa1e7b6e5d8ce7();
    
    if ( srtype != 3 && isdefined( var_100e6c14b8e52131 ) )
    {
        var_e6ee6c02fc16d8a8 = function_819d9e136ca8a19e( var_e6ee6c02fc16d8a8, var_100e6c14b8e52131 );
    }
    
    for ( tierindex = 0; tierindex <= maxtier ; tierindex++ )
    {
        if ( var_e6ee6c02fc16d8a8 > valuestruct.var_e6ee6c02fc16d8a8[ tierindex ] )
        {
            continue;
        }
        
        return tierindex;
    }
    
    return maxtier;
}

// Namespace leagueplay_br
// Params 2
// Checksum 0x3f027189, Offset: 0x4ac9
// Size: 0x4f
function function_3c728cf343b9d99f( victim, attacker )
{
    var_ae23128f7a22e814 = victim function_808c5b4689d20db5();
    var_743ca34395a0af95 = attacker function_808c5b4689d20db5();
    
    if ( !isdefined( var_ae23128f7a22e814 ) )
    {
        var_ae23128f7a22e814 = 0;
    }
    
    if ( !isdefined( var_743ca34395a0af95 ) )
    {
        var_743ca34395a0af95 = 0;
    }
    
    return var_ae23128f7a22e814 - var_743ca34395a0af95;
}

// Namespace leagueplay_br
// Params 2
// Checksum 0x3c6c58, Offset: 0x4b21
// Size: 0xcc
function function_1e7b6554037b9108( srtype, var_100e6c14b8e52131 )
{
    assert( isdefined( level.var_c32d8f56a923f130 ), "<dev string:x4da>" );
    player = self;
    
    if ( srtype == 3 )
    {
        return function_738ba9ce161df321( srtype, level.var_c32d8f56a923f130.var_df5fd0151e4e2fce );
    }
    
    if ( function_4aa1af3ede46e19( srtype ) )
    {
        return player function_3429974112e3eb7d( srtype );
    }
    
    if ( srtype == 6 )
    {
        return 0;
    }
    
    tierindex = function_7ecf96173a234d69( srtype, var_100e6c14b8e52131 );
    divisiondelta = function_3c728cf343b9d99f( var_100e6c14b8e52131, self );
    tieradjustment = function_738ba9ce161df321( srtype, tierindex );
    var_54fef620e718e9b6 = function_d7c2bfb00044c8ab( srtype, divisiondelta );
    return tieradjustment + var_54fef620e718e9b6;
}

// Namespace leagueplay_br
// Params 2
// Checksum 0xf530eb9a, Offset: 0x4bf6
// Size: 0x51
function function_738ba9ce161df321( srtype, tierindex )
{
    valuestruct = function_2c0399136e4917a( srtype, 0 );
    assert( isdefined( valuestruct.srvalue ), "<dev string:x517>" );
    return valuestruct.srvalue[ tierindex ];
}

// Namespace leagueplay_br
// Params 2
// Checksum 0x3b5f53c8, Offset: 0x4c50
// Size: 0x80
function function_d7c2bfb00044c8ab( srtype, divisiondelta )
{
    valuestruct = function_2c0399136e4917a( srtype, 1 );
    assert( isdefined( valuestruct.srvalue ), "<dev string:x517>" );
    divisiondelta = int( clamp( divisiondelta, valuestruct.var_1abac0f6b369e042, valuestruct.var_1a97aaf6b3436828 ) );
    return valuestruct.srvalue[ divisiondelta - valuestruct.var_1abac0f6b369e042 ];
}

// Namespace leagueplay_br
// Params 2
// Checksum 0xe14bab0e, Offset: 0x4cd9
// Size: 0x44
function function_2c0399136e4917a( srtype, adjustmenttype )
{
    assert( isdefined( level.var_c32d8f56a923f130 ), "<dev string:x53a>" );
    return level.var_c32d8f56a923f130.var_b9a3d33aa6d2dd99[ adjustmenttype ][ srtype ];
}

// Namespace leagueplay_br
// Params 0
// Checksum 0xe45a7075, Offset: 0x4d26
// Size: 0x15, Type: bool
function function_37c8f788d4b9eb8c()
{
    if ( game_utility::getgametype() == "resurgence" )
    {
        return true;
    }
    
    return false;
}

// Namespace leagueplay_br
// Params 1
// Checksum 0x85a21faa, Offset: 0x4d44
// Size: 0x155
function function_3429974112e3eb7d( var_15b3975ca3c6e555 )
{
    player = self;
    assert( function_4aa1af3ede46e19( var_15b3975ca3c6e555 ), "<dev string:x57f>" + var_15b3975ca3c6e555 );
    playersr = player.pers[ "sr" ] ?? 0;
    playersr = player.var_fefcd9e884b5e8f6 ?? playersr;
    
    if ( player.var_fb4db865ceda089e != playersr )
    {
        player.var_e4a38d39571eb3a3 = undefined;
        player.var_fb4db865ceda089e = playersr;
    }
    else if ( isdefined( player.var_e4a38d39571eb3a3[ var_15b3975ca3c6e555 ] ) )
    {
        return player.var_e4a38d39571eb3a3[ var_15b3975ca3c6e555 ];
    }
    
    var_bbaa41f45835afcf = function_2c0399136e4917a( var_15b3975ca3c6e555, 0 );
    var_7e880f08e8017533 = var_bbaa41f45835afcf.penaltyvalue[ var_bbaa41f45835afcf.penaltyvalue.size - 1 ];
    
    for ( index = var_bbaa41f45835afcf.penaltyvalue.size - 1; index >= 0 ; index-- )
    {
        if ( playersr >= var_bbaa41f45835afcf.beginsr[ index ] )
        {
            var_7e880f08e8017533 = var_bbaa41f45835afcf.penaltyvalue[ index ];
            break;
        }
    }
    
    returnvalue = -1 * var_7e880f08e8017533;
    player.var_8b9195ce45857e88[ var_15b3975ca3c6e555 ] = returnvalue;
    return returnvalue;
}

// Namespace leagueplay_br
// Params 0
// Checksum 0x44f982ea, Offset: 0x4ea2
// Size: 0xb9
function function_510c9e09ce0a2b3e()
{
    level endon( #"game_ended" );
    flags::gameflagwait( "prematch_done" );
    wait 20;
    allplayers = br::function_aa0fbbd622092c4e();
    
    foreach ( player in level.players )
    {
        player [[ level.var_38896f7c8ea269da ]]( "deploymentfee" );
    }
    
    function_90ec197533705d5( 1 );
}

// Namespace leagueplay_br
// Params 1
// Checksum 0xa0cf05c4, Offset: 0x4f63
// Size: 0x1a, Type: bool
function function_4aa1af3ede46e19( srtype )
{
    return srtype == 4 || srtype == 5;
}

// Namespace leagueplay_br
// Params 2
// Checksum 0xe908bf30, Offset: 0x4f86
// Size: 0x8d
function function_90ec197533705d5( forceupdate, eliminatedteam )
{
    assert( isdefined( level.var_c32d8f56a923f130 ), "<dev string:x53a>" );
    
    if ( isdefined( eliminatedteam ) )
    {
        function_23bae8dce1323c76( eliminatedteam, 1 );
    }
    
    tierindex = function_7ecf96173a234d69( 3 );
    
    if ( tierindex < level.var_c32d8f56a923f130.var_df5fd0151e4e2fce || forceupdate )
    {
        level.var_c32d8f56a923f130.var_df5fd0151e4e2fce = tierindex;
        thread function_b6dd9b418798fb5();
    }
}

// Namespace leagueplay_br
// Params 0
// Checksum 0x5338fcd4, Offset: 0x501b
// Size: 0xaa
function function_b6dd9b418798fb5()
{
    level endon( #"game_ended" );
    assert( isdefined( level.var_c32d8f56a923f130 ), "<dev string:x5c1>" );
    waitframe();
    allactiveplayers = br::function_aa0fbbd622092c4e();
    
    foreach ( player in allactiveplayers )
    {
        player function_eb99300c499635cb( 3 );
    }
}

// Namespace leagueplay_br
// Params 2
// Checksum 0xa0892ab5, Offset: 0x50cd
// Size: 0xfa
function function_bf6eabd56b1369e2( var_380e1341c05f576b, victim )
{
    attacker = self;
    level endon( #"game_ended" );
    
    if ( isdefined( attacker.team ) )
    {
        attackersquad = teams::getteamdata( attacker.team, "players" );
        
        if ( isdefined( var_380e1341c05f576b ) )
        {
            if ( !isarray( var_380e1341c05f576b ) )
            {
                var_380e1341c05f576b = [ var_380e1341c05f576b ];
            }
            
            attackersquad = arrayremove( attackersquad, var_380e1341c05f576b );
        }
        
        foreach ( squadmate in attackersquad )
        {
            if ( squadmate != attacker )
            {
                squadmate function_eb99300c499635cb( 2, victim );
            }
        }
    }
}

// Namespace leagueplay_br
// Params 2
// Checksum 0xb30985d5, Offset: 0x51cf
// Size: 0xa1
function function_23bae8dce1323c76( team, hidden )
{
    players = teams::getteamdata( team, "players" );
    
    foreach ( player in players )
    {
        player function_ce2029450ffad3d8( hidden, 1 );
    }
}

// Namespace leagueplay_br
// Params 2
// Checksum 0x4939563e, Offset: 0x5278
// Size: 0x45
function function_ce2029450ffad3d8( hidden, forcetoggle )
{
    player = self;
    
    if ( !forcetoggle && !level.var_821d674c0b433bd3 )
    {
        return;
    }
    
    player setclientomnvar( "ui_br_skillrank_widget_hidden", hidden );
}

// Namespace leagueplay_br
// Params 2
// Checksum 0x4ca90f67, Offset: 0x52c5
// Size: 0x318
function function_eb99300c499635cb( srtype, optionalarg )
{
    if ( !level.var_309e3d9dac389de6 )
    {
        return;
    }
    
    player = self;
    
    if ( !isdefined( player.var_447c055bb7b91c9e ) )
    {
        player.var_447c055bb7b91c9e = 0;
    }
    
    if ( !isdefined( player.var_7ad638e8cc46fb40 ) )
    {
        player.var_7ad638e8cc46fb40 = 0;
    }
    
    if ( !isdefined( player.var_4dd0b246ada1731b ) )
    {
        player.var_4dd0b246ada1731b = 0;
    }
    
    var_2b7b22938092bf44 = player function_1e7b6554037b9108( srtype, optionalarg );
    var_d90fb9db3601bed0 = 0;
    var_9aa9597cb8fac559 = srtype == 6;
    
    if ( ( srtype == 0 || srtype == 1 || srtype == 2 ) && level.var_1903e23485def131 > 0 )
    {
        if ( player.var_4dd0b246ada1731b + var_2b7b22938092bf44 >= level.var_1903e23485def131 )
        {
            var_2b7b22938092bf44 = level.var_1903e23485def131 - player.var_4dd0b246ada1731b;
            
            if ( !isdefined( player.var_c07839d47034c609 ) )
            {
                player.var_c07839d47034c609 = 0;
            }
            
            if ( player.var_c07839d47034c609 < level.var_feb65de320ce36d5 )
            {
                /#
                    player iprintln( &"mp_br_ingame/kill_sr_limit" );
                #/
                
                var_d90fb9db3601bed0 = 1;
                player.var_c07839d47034c609++;
            }
        }
        
        player.var_4dd0b246ada1731b += var_2b7b22938092bf44;
    }
    
    if ( var_2b7b22938092bf44 == 0 && !var_d90fb9db3601bed0 && !var_9aa9597cb8fac559 )
    {
        return;
    }
    
    if ( srtype == 4 )
    {
        player.var_7ad638e8cc46fb40 = var_2b7b22938092bf44;
    }
    
    if ( level.var_44a441b8aa147be == 0 )
    {
        player.var_447c055bb7b91c9e = int( max( player.var_447c055bb7b91c9e + var_2b7b22938092bf44, player.var_7ad638e8cc46fb40 ) );
    }
    else
    {
        player.var_447c055bb7b91c9e += var_2b7b22938092bf44;
    }
    
    var_c8b886ed0623a263 = player.var_447c055bb7b91c9e < 0;
    var_fe774a366988810a = var_2b7b22938092bf44 < 0;
    packedvalue = 0;
    maxvalue = 268435455;
    bitspacked = 0;
    packedvalue += ( int( abs( player.var_447c055bb7b91c9e ) ) & maxvalue ) << bitspacked;
    bitspacked += 10;
    packedvalue += ( int( var_c8b886ed0623a263 ) & maxvalue ) << bitspacked;
    bitspacked += 1;
    packedvalue += ( int( abs( var_2b7b22938092bf44 ) ) & maxvalue ) << bitspacked;
    bitspacked += 8;
    packedvalue += ( int( var_fe774a366988810a ) & maxvalue ) << bitspacked;
    bitspacked += 1;
    packedvalue += ( int( level.var_c32d8f56a923f130.var_df5fd0151e4e2fce ) & maxvalue ) << bitspacked;
    bitspacked += 4;
    packedvalue += ( int( srtype ) & maxvalue ) << bitspacked;
    bitspacked += 3;
    packedvalue += ( int( var_d90fb9db3601bed0 ) & maxvalue ) << bitspacked;
    player setclientomnvar( "ui_br_skillrank_widget_data", packedvalue );
}

// Namespace leagueplay_br
// Params 2
// Checksum 0xf3eeb371, Offset: 0x55e5
// Size: 0x19d
function function_4736ad281ce0b9ee( attacker, var_53387a1f0a9c7454 )
{
    victim = self;
    
    if ( isdefined( attacker ) )
    {
        suspiciouskill = 0;
        suspiciousdown = 0;
        
        if ( utility::issharedfuncdefined( #"game", #"hash_e9102cee294e5077" ) )
        {
            [ suspiciouskill, suspiciousdown ] = attacker utility::callsharedfunc( #"game", #"hash_e9102cee294e5077", victim, victim.laststandattacker );
        }
        
        if ( suspiciouskill <= 0 && suspiciousdown <= 0 )
        {
            if ( var_53387a1f0a9c7454 )
            {
                attacker gamescore::function_8bac4c78118c9526( isbot( victim ) );
                
                if ( isdefined( level.var_38896f7c8ea269da ) )
                {
                    attacker [[ level.var_38896f7c8ea269da ]]( "assist", victim );
                }
            }
            else
            {
                if ( isdefined( level.var_38896f7c8ea269da ) )
                {
                    attacker [[ level.var_38896f7c8ea269da ]]( "kill", victim );
                }
                
                var_380e1341c05f576b = victim.attackers;
                
                if ( victim.var_4b4aee614c039b )
                {
                    var_380e1341c05f576b[ var_380e1341c05f576b.size ] = self.lastattackedshieldplayer;
                }
                
                attacker gamescore::function_6260e53553c84dbf( victim, var_380e1341c05f576b );
            }
        }
        else if ( isdefined( level.var_38896f7c8ea269da ) && !isdefined( attacker.var_deafbd98c00998be ) )
        {
            attacker [[ level.var_38896f7c8ea269da ]]( "suspiciouskill", victim );
            attacker.var_deafbd98c00998be = 1;
        }
    }
    
    if ( function_37c8f788d4b9eb8c() )
    {
        victim [[ level.var_38896f7c8ea269da ]]( "deathfee" );
    }
}

// Namespace leagueplay_br
// Params 2
// Checksum 0x367da683, Offset: 0x578a
// Size: 0x3b
function function_819d9e136ca8a19e( squadsremaining, victim )
{
    if ( isdefined( victim ) && br::function_1f2e8fad0c533e2d( victim.team ) == 0 )
    {
        squadsremaining += 1;
    }
    
    return squadsremaining;
}

