// scripts\mp\br\gametypes\br_spectate.gsc  (hash_6a17e01ba790f073.gscc) (size: 22066 Bytes / 0x5632 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x9aac5236 (2594984502)
// size ...... 22066 (0x5632)
// includes .. 22  (offset: 0x520a)
// strings ... 61  (offset: 0x52ba)
// dev strs .. 0   (offset: 0x5632)
// exports ... 48  (offset: 0x378a)
// cseg ...... 0x850 + 0x2f3a (0x378a)
// imports ... 145 (offset: 0x3f0a)
// animtree1 . 0   (offset: 0x5632)
// animtree2 . 0   (offset: 0x5632)
#using script_16ea1b94f0f381b3;
#using script_26ccbfe3954cacf4;
#using script_6962ddc481c4af49;
#using script_be7da0439d09064;
#using scripts\common\script;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\mp\bots\bots_gametype_super_shared;
#using scripts\mp\br\gametypes\br_gametypes;
#using scripts\mp\br\gametypes\br_gulag;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\br\gametypes\br_spawnrespawn;
#using scripts\mp\br\gametypes\br_twotwo_gulag;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\lower_message;
#using scripts\mp\common\utility\lui_game_event_aggregator;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\team_utility;
#using scripts\mp\common\utility\teams;
#using scripts\mp\flags;
#using scripts\mp\loot\common_item_redeploy_token;
#using scripts\mp\playerlogic;

#namespace br_spectate;

// Namespace br_spectate
// Params 0
// Checksum 0x1485d80c, Offset: 0x86e
// Size: 0x4f
function spectate_init()
{
    lui_game_event_aggregator::registeronluieventcallback( &function_4cd177d9c1251d54 );
    level.var_f60e4d1d3340da00 = trace::create_contents( 0, 1, 1, 1, 0, 0, 1, 1, 0, 0, 0, 1 );
    level.var_4e15f625dca7ae4 = trace::create_contents( 0, 1, 1, 1, 0, 0, 1, 0, 0, 0, 0, 1 );
}

// Namespace br_spectate
// Params 0
// Checksum 0xe7cd25d5, Offset: 0x8c5
// Size: 0x9
function initplayer()
{
    playerclearspectatekillchainsystem();
}

// Namespace br_spectate
// Params 1
// Checksum 0x75b4434a, Offset: 0x8d6
// Size: 0x30
function function_eb549f5bc7846054( defaultval )
{
    skipbot = defaultval;
    
    /#
        skipbot = getdvarint( @"hash_4ce07ca6680c1333", skipbot );
    #/
    
    return skipbot;
}

// Namespace br_spectate
// Params 0
// Checksum 0x50bc816f, Offset: 0x90f
// Size: 0x36
function function_f60269abe1b22d3c()
{
    if ( utility::issharedfuncdefined( #"gametype", #"hash_a4eabcdb5f3aac07" ) )
    {
        return utility::getsharedfunc( #"gametype", #"hash_a4eabcdb5f3aac07" );
    }
}

// Namespace br_spectate
// Params 4
// Checksum 0xe71a8ff1, Offset: 0x94d
// Size: 0x3d4
function getbestspectatecandidate( victim, attacker, var_64f5eb8ec3abbe7b, var_aca6ea91e0117adf )
{
    playertospectate = undefined;
    skipbots = function_eb549f5bc7846054( 1 );
    var_4684bb6938a2a4dc = function_f60269abe1b22d3c();
    
    if ( utility::issharedfuncdefined( #"gametype", #"hash_730736e67a16d49f" ) )
    {
        playertospectate = utility::callsharedfunc( #"gametype", #"hash_730736e67a16d49f", victim, attacker );
        
        if ( isvalidspectatetarget( playertospectate, var_4684bb6938a2a4dc ) )
        {
            return playertospectate;
        }
    }
    
    if ( victim.gulag && namespace_a8afdcd7738e364e::function_373b8665fd6de550() && !var_64f5eb8ec3abbe7b )
    {
        arenateammate = br_twotwo_gulag::function_c92e709d1093b140( victim );
        
        if ( isbot( arenateammate ) && skipbots )
        {
            arenateammate = undefined;
        }
        
        if ( isvalidspectatetarget( arenateammate, var_4684bb6938a2a4dc ) )
        {
            return arenateammate;
        }
    }
    
    if ( isdefined( victim.nextplayertospectate ) && isvalidspectatetarget( victim.nextplayertospectate, var_4684bb6938a2a4dc ) )
    {
        playertospectate = victim.nextplayertospectate;
        victim.nextplayertospectate = undefined;
    }
    
    if ( !isvalidspectatetarget( playertospectate, var_4684bb6938a2a4dc ) )
    {
        playertospectate = victim br_spawnrespawn::playergetbestrespawnteammate( undefined, undefined, 1, skipbots );
    }
    
    if ( !isvalidspectatetarget( playertospectate, var_4684bb6938a2a4dc ) && isdefined( victim.team ) )
    {
        friendlies = teams::getfriendlyplayers( victim.team );
        playertospectate = function_6b01b638404dd110( victim, friendlies, var_aca6ea91e0117adf );
    }
    
    if ( !isvalidspectatetarget( playertospectate, var_4684bb6938a2a4dc ) && isplayer( attacker ) )
    {
        attackerteam = attacker.team;
        victimteam = victim.team;
        
        if ( !( isdefined( attackerteam ) && isdefined( victimteam ) ) || attackerteam != victimteam )
        {
            if ( isalive( attacker ) && !attacker.gulag && !attacker.inlaststand && ( !isbot( attacker ) || !skipbots ) )
            {
                playertospectate = attacker;
            }
            else if ( isdefined( attackerteam ) )
            {
                teammates = teams::getfriendlyplayers( attackerteam );
                playertospectate = function_6b01b638404dd110( victim, teammates );
            }
        }
    }
    
    if ( !isvalidspectatetarget( playertospectate, var_4684bb6938a2a4dc ) && isplayer( attacker ) && attacker != victim )
    {
        playertospectate = getnextspectatecandidatefromchain( attacker );
    }
    
    if ( !isvalidspectatetarget( playertospectate, var_4684bb6938a2a4dc ) )
    {
        playertospectate = function_6b01b638404dd110( victim, level.players );
    }
    
    if ( !isvalidspectatetarget( playertospectate, var_4684bb6938a2a4dc ) )
    {
        playertospectate = function_308b65a4f0831abb( victim );
    }
    
    if ( !isvalidspectatetarget( playertospectate, var_4684bb6938a2a4dc ) && level.players.size > 1 && !level.gameended && !level.var_c0a7fb1318a30c82 )
    {
        numeliminated = 0;
        
        foreach ( player in level.players )
        {
            if ( !isdefined( player ) )
            {
                continue;
            }
            
            if ( player.br_iseliminated && player isconnected() )
            {
                numeliminated++;
            }
        }
        
        if ( numeliminated != level.players.size && !level.var_342e7eb825a2d111 )
        {
            script::demoforcesre( "getBestSpectateCandidate - no valid player found among " + level.players.size + " players with " + numeliminated + " eliminated players" );
        }
    }
    
    if ( isvalidspectatetarget( playertospectate, var_4684bb6938a2a4dc ) )
    {
        return playertospectate;
    }
}

// Namespace br_spectate
// Params 1
// Checksum 0x732353a, Offset: 0xd2a
// Size: 0xb9
function function_308b65a4f0831abb( victim )
{
    var_f0fb703a8085c806 = undefined;
    
    foreach ( bot in level.players )
    {
        if ( bot != victim && function_8d5b6d1d98d8d289( bot ) )
        {
            if ( !bot manager::function_5c79ebe77f7d0528() )
            {
                return bot;
            }
            
            if ( !isdefined( var_f0fb703a8085c806 ) )
            {
                var_f0fb703a8085c806 = bot;
            }
        }
    }
    
    return var_f0fb703a8085c806;
}

// Namespace br_spectate
// Params 1
// Checksum 0xf41a5b96, Offset: 0xdec
// Size: 0x4c, Type: bool
function function_8d5b6d1d98d8d289( player )
{
    if ( !isdefined( player ) )
    {
        return false;
    }
    
    if ( player manager::isuibot() )
    {
        return false;
    }
    
    if ( !bots_gametype_super_shared::isaliveplayer( player ) )
    {
        return false;
    }
    
    if ( player.inblackroom )
    {
        return false;
    }
    
    return !player.br_iseliminated;
}

// Namespace br_spectate
// Params 1
// Checksum 0xbaa8cb44, Offset: 0xe41
// Size: 0xb0
function getnextspectatecandidatefromchain( player )
{
    var_4684bb6938a2a4dc = function_f60269abe1b22d3c();
    playerschecked = [];
    skipbots = function_eb549f5bc7846054( 1 );
    count = 0;
    
    for ( candidate = player; isdefined( candidate ) && ( skipbots && isbot( candidate ) || !isvalidspectatetarget( candidate, var_4684bb6938a2a4dc ) ) ; candidate = candidate playergetspectatingplayer() )
    {
        count++;
        entnum = candidate getentitynumber();
        
        if ( count >= 150 || isdefined( playerschecked[ entnum ] ) )
        {
            return;
        }
        
        playerschecked[ entnum ] = candidate;
    }
    
    return candidate;
}

// Namespace br_spectate
// Params 3
// Checksum 0x1bc8c9f0, Offset: 0xefa
// Size: 0x1a1
function function_6b01b638404dd110( victim, players, var_aca6ea91e0117adf )
{
    skipbots = function_eb549f5bc7846054( 1 );
    playertospectate = undefined;
    candidates = [];
    var_8d06be174b4a0d0d = [];
    var_8d06bb174b4a0674 = [];
    var_4684bb6938a2a4dc = function_f60269abe1b22d3c();
    
    foreach ( player in players )
    {
        if ( !isdefined( player ) || skipbots && isbot( player ) || !isvalidspectatetarget( player, var_4684bb6938a2a4dc ) || var_aca6ea91e0117adf && player == victim )
        {
            continue;
        }
        
        if ( player.gulag )
        {
            var_8d06be174b4a0d0d[ var_8d06be174b4a0d0d.size ] = player;
            continue;
        }
        
        if ( player.inlaststand )
        {
            var_8d06bb174b4a0674[ var_8d06bb174b4a0674.size ] = player;
            continue;
        }
        
        candidates[ candidates.size ] = player;
    }
    
    if ( candidates.size > 0 )
    {
        randomindex = randomint( candidates.size );
        playertospectate = candidates[ randomindex ];
    }
    
    if ( !isdefined( playertospectate ) && var_8d06be174b4a0d0d.size > 0 )
    {
        randomindex = randomint( var_8d06be174b4a0d0d.size );
        playertospectate = var_8d06be174b4a0d0d[ randomindex ];
    }
    
    if ( !isdefined( playertospectate ) && var_8d06bb174b4a0674.size > 0 )
    {
        randomindex = randomint( var_8d06bb174b4a0674.size );
        playertospectate = var_8d06bb174b4a0674[ randomindex ];
    }
    
    return playertospectate;
}

// Namespace br_spectate
// Params 2
// Checksum 0xbf115215, Offset: 0x10a4
// Size: 0xe3
function isvalidspectatetarget( player, var_4684bb6938a2a4dc )
{
    if ( isdefined( var_4684bb6938a2a4dc ) )
    {
        return [[ var_4684bb6938a2a4dc ]]( player );
    }
    
    if ( !isdefined( player ) )
    {
        return 0;
    }
    
    if ( player.br_iseliminated )
    {
        return 0;
    }
    
    if ( player.extracted || player.var_8ef52d653dbeb62e )
    {
        return 0;
    }
    
    if ( player.disconnecting )
    {
        return 0;
    }
    
    if ( !isalive( player ) && ( !player.gulag || player.gulagarena && !player br_public::function_200f54779296445e() || player.aetherisland ) && ( !function_92ff0a112732e783( player ) || !getdvarint( @"hash_3b1f3bc20658aba1", 0 ) && player.var_ad882e8f12cd3d2a > 0 ) )
    {
        return 0;
    }
    
    return 1;
}

// Namespace br_spectate
// Params 1
// Checksum 0xb8fdc934, Offset: 0x1190
// Size: 0xb8
function function_bbd17501369f5227( point )
{
    result = trace::ray_trace( point + ( 0, 0, 15 ), point + ( 0, 0, 100 ), [], level.var_f60e4d1d3340da00 );
    
    if ( result[ "fraction" ] == 0 )
    {
        result = trace::ray_trace( point + ( 0, 0, 15 ), point + ( 0, 0, 100 ), [], level.var_4e15f625dca7ae4 );
    }
    
    position = result[ "position" ];
    
    if ( result[ "fraction" ] < 1 )
    {
        position -= ( 0, 0, 1 );
    }
    
    return position;
}

// Namespace br_spectate
// Params 1
// Checksum 0x32672ee3, Offset: 0x1251
// Size: 0xcf
function spawnintermissionatplayer( player )
{
    spawnpoint = spawnstruct();
    
    if ( isdefined( player ) && isdefined( player.spectatepoint ) )
    {
        spawnpoint = player.spectatepoint;
        player.spectatepoint = undefined;
    }
    else if ( isdefined( player ) )
    {
        spawnpoint.origin = function_bbd17501369f5227( player.origin );
        spawnpoint.angles = player.angles;
    }
    else
    {
        spawnpoint.origin = function_bbd17501369f5227( self.origin );
        spawnpoint.angles = self.angles;
    }
    
    playerlogic::spawnintermission( spawnpoint, undefined, 0 );
    self.intermissionfrozen = 1;
}

// Namespace br_spectate
// Params 1, eflags: 0x4
// Checksum 0x763c821d, Offset: 0x1328
// Size: 0x94
function private deletecamonleave( camera )
{
    self notify( #"deletecamonleave" );
    self endon( #"deletecamonleave" );
    team = self.team;
    
    if ( !isdefined( team ) )
    {
        return;
    }
    
    self waittill( #"disconnect" );
    
    if ( level.teamdata[ team ][ "players" ].size > 0 )
    {
        return;
    }
    
    if ( isdefined( level.var_edb349a0183d32de[ team ] ) )
    {
        level.var_edb349a0183d32de[ team ] delete();
        level.var_edb349a0183d32de[ team ] = undefined;
    }
}

// Namespace br_spectate
// Params 1
// Checksum 0xaa33669f, Offset: 0x13c4
// Size: 0x1d0
function function_e0f574e347de642f( var_349acf3cccd1fbca )
{
    if ( !isdefined( level.var_edb349a0183d32de ) )
    {
        level.var_edb349a0183d32de = [];
    }
    
    cament = undefined;
    
    if ( isdefined( level.var_edb349a0183d32de[ self.team ] ) )
    {
        cament = level.var_edb349a0183d32de[ self.team ];
    }
    else
    {
        cament = spawn( "script_model", self.origin + ( 0, 0, 50 ) );
        cament setmodel( "tag_origin" );
        cament.angles = self.angles;
        level.var_edb349a0183d32de[ self.team ] = cament;
    }
    
    if ( player::isreallyalive( self ) )
    {
        self cameralinkto( cament, "tag_origin" );
    }
    
    players = level.teamdata[ self.team ][ "players" ];
    
    if ( players.size > 0 )
    {
        foreach ( player in players )
        {
            if ( isdefined( player ) )
            {
                if ( var_349acf3cccd1fbca && ( !player::isreallyalive( player ) || isdefined( player ) && player.extracted ) && !utility::callsharedfunc( #"pleaforhelp", #"hash_6bdb63dc7be5ea5f", player ) )
                {
                    player cameralinkto( cament, "tag_origin" );
                }
                
                player thread deletecamonleave( cament );
            }
        }
        
        return;
    }
    
    thread deletecamonleave( cament );
}

// Namespace br_spectate
// Params 3
// Checksum 0x630aec39, Offset: 0x159c
// Size: 0x168
function spawnspectator( deathdata, finaldeath, skipoverlay )
{
    self endon( #"gulag_auto_win" );
    
    if ( br_public::istutorial() )
    {
        return;
    }
    
    if ( utility::callsharedfunc( #"gametype", #"hash_c2dfd8ff5ef46afb" ) )
    {
        return;
    }
    
    if ( self.squadwiped && level.var_b05cefe0c59dde7f )
    {
        self.br_spectatorinitialized = 1;
        self notify( #"br_spectatorInitialized" );
        return;
    }
    
    victim = self;
    victim spawnintermissionatplayer( victim );
    thread br_gulag::playerspawningasspectator();
    
    if ( !skipoverlay )
    {
        victim thread triggereliminatedoverlay();
    }
    
    attacker = undefined;
    
    if ( isdefined( deathdata ) )
    {
        attacker = deathdata.attacker;
    }
    
    if ( br_gametypes::isfeaturedisabled( #"teamspectate" ) )
    {
        return;
    }
    
    playertospectate = getbestspectatecandidate( victim, attacker );
    
    if ( isdefined( playertospectate ) )
    {
        assignspectatortospectateplayer( victim, playertospectate );
    }
    else
    {
        logstring( "[ spawnSpectator ] spectator not found for player:" + victim.name + " ... this player will not be set to out-of-gulag in forcePlayerSpectateTarget()" );
    }
    
    if ( !victim.br_spectatorinitialized )
    {
        victim notify( #"br_spectatorInitialized" );
        victim.br_spectatorinitialized = 1;
    }
    
    if ( isdefined( level.var_5e5ae35d1b932ce ) )
    {
        victim [[ level.var_5e5ae35d1b932ce ]]( 1 );
    }
}

// Namespace br_spectate
// Params 0
// Checksum 0xd094307b, Offset: 0x170c
// Size: 0x7f
function function_2c588bd77c1f5270()
{
    player = self;
    canplayerspectategulag = undefined;
    
    if ( namespace_a8afdcd7738e364e::function_3d1f225aa0b4d926( "canPlayerSpectateGulag" ) )
    {
        canplayerspectategulag = namespace_a8afdcd7738e364e::function_2af099d01df1a89c( "canPlayerSpectateGulag" );
    }
    
    if ( canplayerspectategulag )
    {
        var_45eb56c9ef8c83a2 = undefined;
        
        if ( namespace_a8afdcd7738e364e::function_3d1f225aa0b4d926( "shouldPlayerSpectateGulag" ) )
        {
            var_45eb56c9ef8c83a2 = namespace_a8afdcd7738e364e::function_2af099d01df1a89c( "shouldPlayerSpectateGulag" );
            
            if ( var_45eb56c9ef8c83a2 )
            {
                if ( namespace_a8afdcd7738e364e::function_3d1f225aa0b4d926( "gulagSpectatorWatchMatchOver" ) )
                {
                    namespace_a8afdcd7738e364e::function_2af099d01df1a89c( "gulagSpectatorWatchMatchOver" );
                }
            }
        }
    }
}

// Namespace br_spectate
// Params 0
// Checksum 0x963f8803, Offset: 0x1793
// Size: 0xc3
function triggereliminatedoverlay()
{
    self endon( #"disconnect" );
    self endon( #"br_team_fully_eliminated" );
    livingteammates = [];
    
    if ( team_utility::isgameplayteam( self.team ) )
    {
        livingteammates = teams::getfriendlyplayers( self.team, 1 );
    }
    
    if ( livingteammates.size > 0 )
    {
        canshow = utility::callsharedfunc( #"gametype", #"hash_787878f1f37fb59c" ) ?? 1;
        
        if ( canshow )
        {
            thread setbuybackpingmessage();
            thread function_a0601414e078f206();
            wait 0.25;
            self setclientomnvar( "ui_br_end_game_splash_type", 5 );
            wait 1;
            self setclientomnvar( "ui_br_end_game_splash_type", 0 );
        }
        
        return;
    }
    
    self setclientomnvar( "ui_requestRedeployButton_state", -1 );
}

// Namespace br_spectate
// Params 0
// Checksum 0x3af22a5e, Offset: 0x185e
// Size: 0x3b
function function_a0601414e078f206()
{
    utility::waittill_any_return( "disconnect", "br_team_fully_eliminated", "started_spawnPlayer", "gulag_auto_win" );
    
    if ( isdefined( self ) )
    {
        self setclientomnvar( "ui_requestRedeployButton_state", -1 );
        lower_message::setlowermessageomnvar( "clear_lower_msg" );
    }
}

// Namespace br_spectate
// Params 0
// Checksum 0x3b43bd5e, Offset: 0x18a1
// Size: 0x24e
function setbuybackpingmessage()
{
    self endon( #"disconnect" );
    self endon( #"br_team_fully_eliminated" );
    self endon( #"started_spawnplayer" );
    self endon( #"gulag_auto_win" );
    
    if ( !br_gametypes::isfeatureenabled( #"hash_7a655b41b7ab5262" ) )
    {
        if ( !level.br_plunder_enabled || level.var_b05cefe0c59dde7f )
        {
            return;
        }
    }
    
    if ( game_utility::getgametype() != "plunder" )
    {
        waittillspectating( self );
        
        if ( br_public::isrespawningfromtoken( self ) )
        {
            return;
        }
        
        var_b285089c38aa0cc4 = getdvarint( @"hash_fd0a280901f0aa8c", 10 );
        lower_message::setlowermessageomnvar( "br_ping_nearest_supply" );
        self setclientomnvar( "ui_requestRedeployButton_state", 0 );
        
        while ( true )
        {
            waittillframeend();
            
            if ( self.playertospectate.gulag || !br_public::iseligibleforteamrevive() )
            {
                lower_message::setlowermessageomnvar( "clear_lower_msg" );
                self setclientomnvar( "ui_requestRedeployButton_state", -1 );
                utility::waittill_any_return( "br_spectator_end_forced_spectator", "playertospectate_set", "spectating_cycle", "spectated_player_wins_gulag", "br_gulag_in_gulag_changed" );
                continue;
            }
            
            lower_message::setlowermessageomnvar( "br_ping_nearest_supply" );
            self setclientomnvar( "ui_requestRedeployButton_state", 0 );
            msg = utility::waittill_any_return( "buybackRequested", "br_spectator_end_forced_spectator", "playertospectate_set", "spectating_cycle", "death" );
            
            if ( msg == "buybackRequested" )
            {
                lower_message::setlowermessageomnvar( "clear_lower_msg" );
                endtime = gettime() + var_b285089c38aa0cc4 * 1000;
                self setclientomnvar( "ui_requestRedeployButton_state", int( max( endtime, 0 ) ) );
                
                foreach ( teammate in level.teamdata[ self.team ][ "alivePlayers" ] )
                {
                    if ( !isdefined( teammate ) )
                    {
                        continue;
                    }
                    
                    if ( teammate != self && !teammate.gulag )
                    {
                        teammate br_ftue_popups::ftue_triggertip( "br_ftue_buyback" );
                    }
                }
                
                wait var_b285089c38aa0cc4;
            }
        }
    }
}

// Namespace br_spectate
// Params 0
// Checksum 0xf9c0ed18, Offset: 0x1af7
// Size: 0x79
function playerclearspectatekillchainsystem()
{
    self.prestreamingspectatetarget = undefined;
    self.nextplayertospectate = undefined;
    function_a5f457d39083c7c0( undefined );
    
    if ( self.intermissionfrozen )
    {
        if ( !getdvarint( @"hash_8117734e3e0f8be5", 0 ) )
        {
            player::_freezecontrols( 0, undefined, "spawnIntermission" );
        }
        
        self.intermissionfrozen = undefined;
    }
    
    self setclientomnvar( "ui_show_spectateHud", -1 );
    self notify( #"hash_af35ef2135d18b5f" );
    self notify( #"hash_894098e2406f3857" );
}

// Namespace br_spectate
// Params 0
// Checksum 0xfad14a6c, Offset: 0x1b78
// Size: 0x6b
function playerspawnintermissionifneeded()
{
    player = self;
    
    if ( player.sessionstate != "intermission" )
    {
        previousplayertospectate = player playergetspectatingplayer();
        
        if ( isdefined( previousplayertospectate ) && previousplayertospectate.wasingulag )
        {
            player br_gulag::playersetwasingulag( 1 );
            level notify( #"hash_7f6b2a7b2d05df3e" );
        }
        
        player spawnintermissionatplayer( previousplayertospectate );
    }
}

// Namespace br_spectate
// Params 1
// Checksum 0x683fc8b9, Offset: 0x1beb
// Size: 0x4af
function forceplayerspectatetarget( playertospectate )
{
    if ( level.brspawnplayersending )
    {
        return;
    }
    
    player = self;
    level endon( #"hash_bcd7948d1417bc21" );
    player endon( #"disconnect" );
    player notify( #"hash_af35ef2135d18b5f" );
    player endon( #"hash_af35ef2135d18b5f" );
    player.prestreamingspectatetarget = 1;
    spectatelog( player, "forcePlayerSpectateTarget1 - playerToSpectate = ", playertospectate );
    player playerspawnintermissionifneeded();
    
    if ( !isplayer( playertospectate ) || !isalive( playertospectate ) && !isdefined( playertospectate.streampoint ) )
    {
        if ( level.gameended || level.players.size == 1 )
        {
            player setclientomnvar( "ui_show_spectateHud", player getentitynumber() );
            player.prestreamingspectatetarget = undefined;
            return;
        }
        
        playertospectate = getbestspectatecandidate( player );
        
        if ( !isdefined( playertospectate ) )
        {
            player setclientomnvar( "ui_show_spectateHud", player getentitynumber() );
            player.prestreamingspectatetarget = undefined;
            return;
        }
    }
    
    playertospectate endon( #"disconnect" );
    spectatetargetentnum = playertospectate getentitynumber();
    player function_a5f457d39083c7c0( playertospectate );
    player setclientomnvar( "ui_show_spectateHud", spectatetargetentnum );
    player setadditionalstreamloaddist( 0 );
    streamorigin = playertospectate.origin;
    
    if ( isdefined( playertospectate.streampoint ) )
    {
        streamorigin = playertospectate.streampoint.origin;
        player setadditionalstreamposuntilcleared( streamorigin );
    }
    else
    {
        player setadditionalstreamposuntilcleared( streamorigin, 0, playertospectate );
    }
    
    player loadcustomizationplayerview( playertospectate );
    weapons = playertospectate getweaponslistprimaries();
    player loadweaponsforplayer( weapons, 1 );
    waitframe();
    var_5a98e4e186c5e740 = getdvarint( @"hash_8f060c92b126a91b", 2500 );
    var_c62f8cc73278cdcd = getdvarint( @"hash_ceb0792519b8eea2", 500 );
    var_ab077b2546a5468e = getdvarint( @"hash_ff561f8c33f431ba", 9000 );
    nextpositionupdate = gettime() + var_c62f8cc73278cdcd;
    timeout = gettime() + var_ab077b2546a5468e;
    
    while ( isdefined( player ) && ( !player isadditionalstreamposready() || isdefined( playertospectate ) && !player hasloadedcustomizationplayerview( playertospectate ) || !player hasloadedviewweapons( weapons ) ) && gettime() < timeout )
    {
        if ( isdefined( playertospectate ) && !isdefined( playertospectate.streampoint ) && gettime() > nextpositionupdate )
        {
            distsq = distance2dsquared( playertospectate.origin, streamorigin );
            
            if ( !isdefined( distsq ) )
            {
                if ( !isdefined( streamorigin ) )
                {
                    logstring( "Log this in IW9-428811: streamOrigin was undefined" );
                }
                else if ( !isdefined( playertospectate.origin ) )
                {
                    logstring( "Log this in IW9-428811: playerToSpectate.origin was undefined" );
                }
                else
                {
                    logstring( "Log this in IW9-428811: Inputs were defined. Error exists in BGScr_Distance2DSquared. Inputs: " + playertospectate.origin + " and " + streamorigin );
                }
            }
            
            if ( distsq > var_5a98e4e186c5e740 )
            {
                streamorigin = playertospectate.origin;
                player setadditionalstreamposuntilcleared( streamorigin, 0, playertospectate );
                nextpositionupdate = gettime() + var_c62f8cc73278cdcd;
            }
        }
        
        if ( isdefined( level.brwinnerscircle ) && [[ level.brwinnerscircle.var_41b10fd9fb1a88d3 ]]( player ) )
        {
            player setclientomnvar( "ui_show_spectateHud", -1 );
            player clearadditionalstreampos();
            player.prestreamingspectatetarget = undefined;
            return;
        }
        
        waitframe();
    }
    
    spectatelog( player, "forcePlayerSpectateTarget2 - playerToSpectate = ", playertospectate );
    
    /#
        debugwaittime = getdvarfloat( @"hash_2c879521333c4987", 0 );
        
        if ( debugwaittime > 0 )
        {
            wait debugwaittime;
        }
    #/
    
    var_c044f1d106e95c6c = getdvarint( @"hash_ceb0792519b8eea2", 2000 );
    timeout = gettime() + var_ab077b2546a5468e;
    var_7ae62165182c2ce6 = 0;
    
    while ( ( isdefined( playertospectate.streampoint ) || !isalive( playertospectate ) || playertospectate.gulag && !playertospectate.jailed ) && gettime() < timeout )
    {
        if ( gettime() > var_7ae62165182c2ce6 )
        {
            player setadditionalstreamposuntilcleared( streamorigin );
            var_7ae62165182c2ce6 = gettime() + var_c044f1d106e95c6c;
        }
        
        waitframe();
    }
    
    spectatelog( player, "forcePlayerSpectateTarget3 - playerToSpectate = ", playertospectate );
    
    if ( isdefined( playertospectate ) )
    {
        player playerforcespectatorclientwait( playertospectate );
    }
    
    player thread playermonitorspectatorcycle();
    player clearadditionalstreampos();
    
    if ( player.wasingulag )
    {
        player br_gulag::playersetwasingulag( 0 );
        level notify( #"hash_7f6b2a7b2d05df3e" );
    }
    
    self notify( #"force_spectate_done" );
    spectatelog( player, "forcePlayerSpectateTargetDone - playerToSpectate = ", playertospectate );
}

// Namespace br_spectate
// Params 0
// Checksum 0x5931ee5e, Offset: 0x20a2
// Size: 0x4a
function function_63784c69e96a161c()
{
    self endon( #"disconnect" );
    self endon( #"hash_ab0234dbcc755765" );
    var_7c72b28cca2850d2 = getdvarfloat( @"hash_62ec5192ac74d3f4", 9 );
    
    if ( var_7c72b28cca2850d2 <= 0 )
    {
        return;
    }
    
    wait var_7c72b28cca2850d2;
    thread br_spawnrespawn::playercinematicfadeout();
}

// Namespace br_spectate
// Params 1
// Checksum 0x9ad1ce08, Offset: 0x20f4
// Size: 0x1da
function playerforcespectatorclientwait( playertospectate )
{
    player = self;
    spectatelog( player, "playerForceSpectatorClientWait - playerToSpectate = ", playertospectate );
    
    if ( isdefined( playertospectate ) && !playertospectate br_spawnrespawn::playeriscinematicblacklayeron() )
    {
        player thread br_spawnrespawn::playercinematicfadeout();
    }
    else if ( !player br_spawnrespawn::playeriscinematicblacklayeron() )
    {
        player br_spawnrespawn::playercinematicfadein();
        player thread function_63784c69e96a161c();
        wait 0.5;
    }
    
    spectatelog( player, "playerForceSpectatorClientWait2 - playerToSpectate = ", playertospectate );
    
    if ( player.intermissionfrozen )
    {
        if ( !getdvarint( @"hash_8117734e3e0f8be5", 0 ) )
        {
            player player::_freezecontrols( 0, undefined, "spawnIntermission" );
        }
        
        player.intermissionfrozen = undefined;
    }
    
    var_4684bb6938a2a4dc = function_f60269abe1b22d3c();
    spectatetargetentnum = undefined;
    
    if ( isdefined( playertospectate ) )
    {
        spectatetargetentnum = playertospectate getentitynumber();
        player player::updatesessionstate( "spectator" );
        player.forcespectatorclient = spectatetargetentnum;
        
        if ( player.intermissionfrozen )
        {
            player player::_freezecontrols( 0, undefined, "spawnIntermission" );
            player.intermissionfrozen = undefined;
        }
        
        player setallstreamloaddist( 0 );
        player setclientomnvar( "ui_show_spectateHud", -1 );
        var_1de9893345dfa786 = player getspectatingplayer();
        
        while ( !isdefined( var_1de9893345dfa786 ) || spectatetargetentnum != var_1de9893345dfa786 getentitynumber() )
        {
            waitframe();
            var_1de9893345dfa786 = player getspectatingplayer();
            
            if ( !isdefined( playertospectate ) || !isvalidspectatetarget( playertospectate, var_4684bb6938a2a4dc ) )
            {
                break;
            }
        }
        
        spectatelog( player, "playerForceSpectatorClientWaitDone- playerToSpectate = ", playertospectate );
    }
    
    player notify( #"br_spectator_end_forced_spectator" );
    player.forcespectatorclient = -1;
    
    if ( isdefined( playertospectate ) && isvalidspectatetarget( playertospectate, var_4684bb6938a2a4dc ) )
    {
        player spectateclientnum( spectatetargetentnum, 1 );
    }
    
    player.prestreamingspectatetarget = undefined;
}

// Namespace br_spectate
// Params 2
// Checksum 0xea67c065, Offset: 0x22d6
// Size: 0x6d
function function_4cd177d9c1251d54( channel, otherclientnum )
{
    player = self;
    
    if ( !isdefined( otherclientnum ) )
    {
        return;
    }
    
    if ( channel == "br_spectate_player" )
    {
        var_4684bb6938a2a4dc = function_f60269abe1b22d3c();
        otherplayer = playerlogic::getplayerfromclientnum( otherclientnum );
        
        if ( isvalidspectatetarget( otherplayer, var_4684bb6938a2a4dc ) )
        {
            player spectateclientnum( otherclientnum, 1 );
        }
    }
}

// Namespace br_spectate
// Params 2
// Checksum 0x70c63c4, Offset: 0x234b
// Size: 0x109
function assignspectatortospectateplayer( spectator, playertospectate )
{
    spectatelog( spectator, "assignSpectatorToSpectatePlayer - playerToSpectate = ", playertospectate );
    
    if ( getdvarint( @"hash_5df0fed95481409d", 1 ) )
    {
        spectator player::_freezecontrols( 0, undefined, "spawnIntermission" );
    }
    
    result = utility::callsharedfunc( #"gametype", #"hash_4b655b34a0f3fcce", spectator, playertospectate );
    
    if ( result )
    {
        return;
    }
    
    assert( isdefined( playertospectate ) || level.players.size == 1 || level.gameended );
    spectator allowspectateteam( "freelook", 0 );
    spectator allowspectateteam( "none", 0 );
    spectator allowspectateallteams( getdvarint( @"hash_87720d5ec286812b", 0 ) );
    
    if ( level.teambased && isdefined( playertospectate ) )
    {
        spectator allowspectateteam( playertospectate.team, 1 );
    }
    
    spectator thread forceplayerspectatetarget( playertospectate );
    self notify( #"playertospectate_set" );
}

// Namespace br_spectate
// Params 0
// Checksum 0x1d8a4215, Offset: 0x245c
// Size: 0x1b9
function playermonitorspectatorcycle()
{
    self notify( #"hash_894098e2406f3857" );
    self endon( #"hash_894098e2406f3857" );
    self endon( #"hash_af35ef2135d18b5f" );
    self endon( #"disconnect" );
    self endon( #"started_spawnplayer" );
    self endon( #"br_winners_circle_start" );
    var_4684bb6938a2a4dc = function_f60269abe1b22d3c();
    
    while ( true )
    {
        self waittill( #"spectating_cycle_start", playertospectate );
        
        if ( !isdefined( playertospectate ) )
        {
            continue;
        }
        
        if ( self.gulagarena && !self.var_7c3c15d7e28575d && namespace_a8afdcd7738e364e::function_373b8665fd6de550() )
        {
            spectatingplayer = self getspectatingplayer();
            
            if ( isdefined( spectatingplayer ) )
            {
                self.forcespectatorclient = spectatingplayer getentitynumber();
                continue;
            }
        }
        
        if ( playertospectate br_spawnrespawn::playeriscinematicblacklayeron() )
        {
            br_spawnrespawn::playercinematicfadein();
        }
        
        success = playerwaittillspectatecycle( playertospectate );
        testplayer = self getspectatingplayer();
        
        if ( !success || !isdefined( testplayer ) )
        {
            stopspectateplayer( self getentitynumber(), 1 );
            
            if ( isvalidspectatetarget( self.playertospectate, var_4684bb6938a2a4dc ) )
            {
                playerforcespectatorclientwait( self.playertospectate );
            }
            else
            {
                playertospectate = getbestspectatecandidate( self );
                
                if ( isdefined( playertospectate ) )
                {
                    if ( !playertospectate br_spawnrespawn::playeriscinematicblacklayeron() )
                    {
                        thread br_spawnrespawn::playercinematicfadeout();
                    }
                    
                    assignspectatortospectateplayer( self, playertospectate );
                }
            }
            
            continue;
        }
        
        function_a5f457d39083c7c0( playertospectate );
        
        if ( testplayer != playertospectate )
        {
            function_a5f457d39083c7c0( testplayer );
        }
        
        if ( self.playertospectate br_spawnrespawn::playeriscinematicblacklayeron() )
        {
            if ( !br_spawnrespawn::playeriscinematicblacklayeron() )
            {
                br_spawnrespawn::playercinematicfadein();
            }
            
            continue;
        }
        
        thread br_spawnrespawn::playercinematicfadeout();
    }
}

// Namespace br_spectate
// Params 1
// Checksum 0xbe6d8ea1, Offset: 0x261d
// Size: 0x28, Type: bool
function playerwaittillspectatecycle( playertospectate )
{
    playertospectate endon( #"death_or_disconnect" );
    self waittill( #"spectating_cycle" );
    return true;
}

// Namespace br_spectate
// Params 0
// Checksum 0xff06501, Offset: 0x264e
// Size: 0x5d
function playergetspectatingplayer()
{
    if ( !self.spectatekillcam )
    {
        spectatingplayer = self getspectatingplayer();
        var_7237854e3be197ca = spectatingplayer;
        
        if ( isdefined( var_7237854e3be197ca ) )
        {
            return var_7237854e3be197ca;
        }
    }
    
    var_7237854e3be197ca = self.nextplayertospectate;
    
    if ( isdefined( var_7237854e3be197ca ) )
    {
        return var_7237854e3be197ca;
    }
    
    var_7237854e3be197ca = self.playertospectate;
    
    if ( isdefined( var_7237854e3be197ca ) )
    {
        return var_7237854e3be197ca;
    }
}

// Namespace br_spectate
// Params 1
// Checksum 0x9cebc96f, Offset: 0x26b4
// Size: 0x69
function function_a5f457d39083c7c0( playertospectate )
{
    self endon( #"disconnect" );
    
    if ( self.playertospectate == playertospectate )
    {
        return;
    }
    
    if ( playertospectate == self )
    {
        return;
    }
    
    if ( isdefined( self.playertospectate ) )
    {
        self.playertospectate function_1450227f6667863c( self );
    }
    
    self.playertospectate = playertospectate;
    
    if ( isdefined( playertospectate ) )
    {
        playertospectate function_d0bceea04164146b( self );
    }
}

// Namespace br_spectate
// Params 1
// Checksum 0xe9aca077, Offset: 0x2725
// Size: 0x41
function function_d0bceea04164146b( spectator )
{
    if ( !isdefined( spectator ) )
    {
        return;
    }
    
    if ( !isdefined( self.spectators ) )
    {
        self.spectators = [];
    }
    
    self.spectators[ self.spectators.size ] = spectator;
}

// Namespace br_spectate
// Params 1
// Checksum 0x7226f842, Offset: 0x276e
// Size: 0x49
function function_1450227f6667863c( spectator )
{
    if ( !isdefined( spectator ) )
    {
        return;
    }
    
    if ( isdefined( self.spectators ) && self.spectators.size > 0 )
    {
        self.spectators = arrayremove( self.spectators, spectator );
    }
}

// Namespace br_spectate
// Params 2
// Checksum 0x2df78b40, Offset: 0x27bf
// Size: 0x45
function function_a4859c8e69b83edf( timeout, finishfade )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    br_spawnrespawn::function_1d2f70d591e967bc();
    utility::waittill_any_timeout( timeout, finishfade );
    br_spawnrespawn::function_24b79e9319c6f02f();
}

// Namespace br_spectate
// Params 0
// Checksum 0x3856a3a, Offset: 0x280c
// Size: 0xde
function function_ff10813f2a7bd19c()
{
    player = self;
    playerlist = [];
    spectators = player getexclusivespectators();
    
    if ( spectators.size > 0 )
    {
        foreach ( viewer in spectators )
        {
            if ( !isdefined( viewer.team ) )
            {
                continue;
            }
            
            if ( viewer.team == "spectator" || viewer.team == "codcaster" )
            {
                playerlist[ playerlist.size ] = viewer;
            }
        }
    }
    
    return playerlist;
}

// Namespace br_spectate
// Params 1
// Checksum 0xcb2439ca, Offset: 0x28f3
// Size: 0x285
function getspectatorsofplayer( targetplayer )
{
    spectatorlist = [];
    
    if ( isdefined( targetplayer ) && isdefined( level ) )
    {
        var_4684bb6938a2a4dc = function_f60269abe1b22d3c();
        var_cc98c68b40315264 = getdvarint( @"hash_4a1041cd63914aa2", 1 );
        
        if ( var_cc98c68b40315264 )
        {
            var_832b0b8496f87b75 = [];
            
            foreach ( spectator in targetplayer.spectators )
            {
                if ( !isdefined( spectator ) )
                {
                    var_832b0b8496f87b75[ var_832b0b8496f87b75.size ] = spectator;
                    continue;
                }
                
                if ( isvalidspectatetarget( spectator, var_4684bb6938a2a4dc ) )
                {
                    var_832b0b8496f87b75[ var_832b0b8496f87b75.size ] = spectator;
                    continue;
                }
                
                if ( !spectator.br_spectatorinitialized )
                {
                    var_832b0b8496f87b75[ var_832b0b8496f87b75.size ] = spectator;
                    continue;
                }
                
                spectatingplayer = spectator playergetspectatingplayer();
                
                if ( !isdefined( spectatingplayer ) )
                {
                    continue;
                }
                
                if ( spectatingplayer == targetplayer )
                {
                    spectatorlist[ spectatorlist.size ] = spectator;
                    continue;
                }
                
                var_832b0b8496f87b75[ var_832b0b8496f87b75.size ] = spectator;
            }
            
            foreach ( var_7a4e81198a5b9fce in var_832b0b8496f87b75 )
            {
                targetplayer.spectators = arrayremove( targetplayer.spectators, var_7a4e81198a5b9fce );
            }
        }
        else
        {
            foreach ( player in level.players )
            {
                if ( !isdefined( player ) )
                {
                    continue;
                }
                
                if ( isvalidspectatetarget( player, var_4684bb6938a2a4dc ) )
                {
                    continue;
                }
                
                if ( !player.br_spectatorinitialized )
                {
                    continue;
                }
                
                spectatingplayer = player playergetspectatingplayer();
                
                if ( !isdefined( spectatingplayer ) )
                {
                    continue;
                }
                
                if ( spectatingplayer == targetplayer )
                {
                    spectatorlist[ spectatorlist.size ] = player;
                }
            }
        }
    }
    
    return spectatorlist;
}

// Namespace br_spectate
// Params 1, eflags: 0x4
// Checksum 0xfc801e20, Offset: 0x2b81
// Size: 0xb8, Type: bool
function private function_fcd75202904ceb5f( team )
{
    players = teams::getteamdata( team, "players" );
    
    foreach ( player in players )
    {
        if ( isalive( player ) )
        {
            continue;
        }
        
        if ( player item_redeploy_token::function_6932ae7663f88c8e() && player.var_ad882e8f12cd3d2a > 0 )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace br_spectate
// Params 1, eflags: 0x4
// Checksum 0x210dae40, Offset: 0x2c42
// Size: 0xa5, Type: bool
function private function_46aca900adac5d60( team )
{
    players = teams::getteamdata( team, "players" );
    
    foreach ( player in players )
    {
        if ( isalive( player ) || isvalidspectatetarget( player ) )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace br_spectate
// Params 1, eflags: 0x4
// Checksum 0x34f73c98, Offset: 0x2cf0
// Size: 0x19, Type: bool
function private function_bc0b1042d7bd6093( player )
{
    return player.var_ad882e8f12cd3d2a > 0;
}

// Namespace br_spectate
// Params 1
// Checksum 0x5def6141, Offset: 0x2d12
// Size: 0x3c
function function_bdad21149533089f( playertospectate )
{
    self endon( #"disconnect" );
    playertospectate endon( #"disconnect" );
    
    while ( player::isinkillcam() )
    {
        waitframe();
    }
    
    assignspectatortospectateplayer( self, playertospectate );
}

// Namespace br_spectate
// Params 1
// Checksum 0x5ab2cc8a, Offset: 0x2d56
// Size: 0xcc
function function_716fddf4830ea0cb( playertospectate )
{
    playertospectate endon( #"disconnect" );
    
    while ( !isalive( playertospectate ) )
    {
        waitframe();
    }
    
    players = teams::getteamdata( playertospectate.team, "players" );
    
    foreach ( player in players )
    {
        if ( !isalive( player ) && player != playertospectate )
        {
            player thread function_bdad21149533089f( playertospectate );
        }
    }
}

// Namespace br_spectate
// Params 3
// Checksum 0xe3a86d00, Offset: 0x2e2a
// Size: 0x51b
function migratespectators( victim, attacker, wasdeath )
{
    if ( !flags::gameflag( "prematch_done" ) )
    {
        return;
    }
    
    if ( utility::callsharedfunc( #"gametype", #"hash_57d3aeb33dfd0b1e" ) )
    {
        return;
    }
    
    spectatelog( victim, "migrateSpectators - start - wasDeath = " + wasdeath + ", attacker = ", attacker );
    
    if ( getdvarint( @"hash_64e79dc58b74c186", 1 ) && function_fcd75202904ceb5f( victim.team ) && function_46aca900adac5d60( victim.team ) )
    {
        spectatelog( victim, "migrateSpectators - anyPlayersInRespawnTokenDelay and isTeamInvalidToSpectate, wasDeath = " + wasdeath );
        
        if ( !wasdeath )
        {
            victim setspectatedefaults( function_bbd17501369f5227( victim.origin ), victim.angles );
        }
        
        victimspectators = getspectatorsofplayer( victim );
        
        foreach ( spectator in victimspectators )
        {
            spectator setspectatedefaults( function_bbd17501369f5227( victim.origin ), victim.angles );
        }
        
        utility::callsharedfunc( #"gametype", #"hash_7441ed4c82dce578", victim, attacker, wasdeath );
        return;
    }
    
    if ( wasdeath && function_92ff0a112732e783( victim ) && ( !getdvarint( @"hash_64e79dc58b74c186", 1 ) || !function_fcd75202904ceb5f( victim.team ) ) || victim br_public::function_200f54779296445e() )
    {
        spectatelog( victim, "migrateSpectators - isRespawningFromRespawnToken, wasDeath = " + wasdeath );
        victimspectators = getspectatorsofplayer( victim );
        
        foreach ( spectator in victimspectators )
        {
            if ( getdvarint( @"hash_64e79dc58b74c186", 1 ) || getdvarint( @"hash_3b1f3bc20658aba1", 0 ) )
            {
                spectator setspectatedefaults( function_bbd17501369f5227( victim.origin ), victim.angles );
                continue;
            }
            
            spectator thread playerlogic::spawnspectator( function_bbd17501369f5227( victim.origin ), victim.angles );
        }
        
        return;
    }
    
    var_4684bb6938a2a4dc = function_f60269abe1b22d3c();
    playertospectate = getbestspectatecandidate( victim, attacker, undefined, 1 );
    
    if ( !getdvarint( @"hash_3b1f3bc20658aba1", 0 ) && !getdvarint( @"hash_64e79dc58b74c186", 1 ) && playertospectate.team != victim.team && function_fcd75202904ceb5f( victim.team ) )
    {
        spectatelog( victim, "migrateSpectators - token delay with not correct team, wasDeath = " + wasdeath );
        victimspectators = getspectatorsofplayer( victim );
        
        foreach ( spectator in victimspectators )
        {
            spectator thread playerlogic::spawnspectator( function_bbd17501369f5227( victim.origin ), victim.angles );
        }
        
        return;
    }
    
    if ( wasdeath && !victim.gulag )
    {
        victim.nextplayertospectate = playertospectate;
    }
    
    if ( !isvalidspectatetarget( playertospectate, var_4684bb6938a2a4dc ) )
    {
        spectatelog( victim, "migrateSpectators - isValidSpectateTarget, wasDeath = " + wasdeath );
        
        if ( level.var_b05cefe0c59dde7f && getdvarint( @"hash_9204e47e241583a1", 1 ) == 1 )
        {
            if ( isdefined( victim ) && isdefined( victim.team ) )
            {
                players = level.teamdata[ victim.team ][ "players" ];
                
                if ( players.size > 0 )
                {
                    foreach ( player in players )
                    {
                        if ( isvalidspectatetarget( player, var_4684bb6938a2a4dc ) )
                        {
                            updateexistingspectatorsofvictim( victim, player );
                            return;
                        }
                    }
                }
                
                victim function_e0f574e347de642f( 1 );
            }
        }
        
        return;
    }
    
    updateexistingspectatorsofvictim( victim, playertospectate );
}

// Namespace br_spectate
// Params 2
// Checksum 0xfb2f9e35, Offset: 0x334d
// Size: 0x17e
function updateexistingspectatorsofvictim( victim, playertospectate )
{
    victimspectators = getspectatorsofplayer( victim );
    
    foreach ( spectator in victimspectators )
    {
        spectatelog( spectator, "updateExistingSpectatorsOfVictim - playerToSpectate = ", playertospectate );
        
        if ( namespace_a8afdcd7738e364e::function_373b8665fd6de550() && spectator.gulagarena )
        {
            altplayertospectate = getbestspectatecandidate( spectator, undefined, 1 );
            
            if ( isdefined( altplayertospectate ) && spectator.team == altplayertospectate.team )
            {
                assignspectatortospectateplayer( spectator, altplayertospectate );
                continue;
            }
        }
        
        if ( isdefined( playertospectate ) && victim.team == spectator.team && playertospectate.team != victim.team && isdefined( victim.streampoint ) )
        {
            assignspectatortospectateplayer( spectator, victim );
            continue;
        }
        
        if ( isdefined( spectator.nextplayertospectate ) )
        {
            spectator.nextplayertospectate = playertospectate;
            continue;
        }
        
        assignspectatortospectateplayer( spectator, playertospectate );
    }
}

// Namespace br_spectate
// Params 1
// Checksum 0x4868788c, Offset: 0x34d3
// Size: 0x54
function waittillspectating( player )
{
    while ( player.sessionstate != "intermission" )
    {
        waitframe();
    }
    
    while ( player.sessionstate == "intermission" )
    {
        waitframe();
    }
    
    while ( player.sessionstate != "spectator" )
    {
        waitframe();
    }
}

// Namespace br_spectate
// Params 1
// Checksum 0xac374777, Offset: 0x352f
// Size: 0x35, Type: bool
function function_92ff0a112732e783( player )
{
    return isdefined( player ) && ( player br_public::hasrespawntoken() && !namespace_9d8e359c3b1041e5::respawntokendisabledsharedfunc() || player.respawningfromtoken );
}

// Namespace br_spectate
// Params 1
// Checksum 0x2014abd8, Offset: 0x356d
// Size: 0x9e
function function_8f4a7afb87136937( winner )
{
    spectators = getspectatorsofplayer( winner );
    
    foreach ( spectator in spectators )
    {
        if ( isalliedsentient( spectator, winner ) )
        {
            spectator notify( #"spectated_player_wins_gulag" );
        }
    }
}

// Namespace br_spectate
// Params 0
// Checksum 0xa4169047, Offset: 0x3613
// Size: 0x9b
function function_dfc58be5f4bd9aae()
{
    spectators = getspectatorsofplayer( self );
    
    foreach ( spectator in spectators )
    {
        spectator setspectatedefaults( function_bbd17501369f5227( self.origin ), self.angles );
    }
}

// Namespace br_spectate
// Params 3
// Checksum 0x88c39f18, Offset: 0x36b6
// Size: 0xd4
function spectatelog( player, msg, player2 )
{
    if ( getdvarint( @"hash_7e850dd9a35660d2", 1 ) )
    {
        name = player.testname ?? player.name;
        str = "SPECTATE DEBUG: " + gettime() + " - " + name + " - " + player.team + " - " + msg;
        
        if ( player2 )
        {
            name2 = player2.testname ?? player2.name;
            str += name2 + " - " + player2.team;
        }
        
        logstring( str );
    }
}

