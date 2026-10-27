// scripts\mp\br\gametypes\br_publicevent_jailbreak.gsc  (hash_5f03ca93f3e8ec7d.gscc) (size: 6255 Bytes / 0x186f / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xdd8fe0de (3717193950)
// size ...... 6255 (0x186f)
// includes .. 8   (offset: 0x167b)
// strings ... 32  (offset: 0x16bb)
// dev strs .. 0   (offset: 0x186f)
// exports ... 16  (offset: 0xee7)
// cseg ...... 0x308 + 0xbdf (0xee7)
// imports ... 42  (offset: 0x1167)
// animtree1 . 0   (offset: 0x186f)
// animtree2 . 0   (offset: 0x186f)
#using script_68bfedf2ed730bd;
#using script_6962ddc481c4af49;
#using scripts\common\utility;
#using scripts\mp\br\gametypes\br_gametypes;
#using scripts\mp\br\gametypes\br_gulag;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\br\gametypes\br_publicevents;
#using scripts\mp\br\gametypes\br_twotwo_gulag;

#namespace br_publicevent_jailbreak;

// Namespace br_publicevent_jailbreak
// Params 0, eflags: 0x1
// Checksum 0xf9677cc1, Offset: 0x326
// Size: 0x17
function autoexec main()
{
    br_publicevents::function_54d95495df246a2b( %"jailbreak", &init );
}

// Namespace br_publicevent_jailbreak
// Params 1
// Checksum 0x53e4444f, Offset: 0x345
// Size: 0x50
function init( eventinfo )
{
    eventinfo.validatefunc = &validatefunc;
    eventinfo.activatefunc = &activatefunc;
    eventinfo.waitfunc = &waitfunc;
    eventinfo.postinitfunc = &postinitfunc;
}

// Namespace br_publicevent_jailbreak
// Params 0
// Checksum 0xac7065aa, Offset: 0x39d
// Size: 0x74
function postinitfunc()
{
    game[ "dialog" ][ "public_events_jailbreak_incoming_active" ] = "pblc_wzan_jbwr";
    game[ "dialog" ][ "public_events_jailbreak_incoming_active_alt" ] = "pblc_wzan_jbwr";
    game[ "dialog" ][ "public_events_jailbreak_now_active" ] = "pblc_wzan_jbct";
    game[ "dialog" ][ "public_events_jailbreak_now_active_alt" ] = "pblc_wzan_jbct";
    game[ "dialog" ][ "public_events_jailbreak_now_gulag" ] = "pblc_wzan_jbgn";
    game[ "dialog" ][ "public_events_jailbreak_now_spectate" ] = "pblc_wzan_jbsn";
}

// Namespace br_publicevent_jailbreak
// Params 0
// Checksum 0x9350fe64, Offset: 0x419
// Size: 0x3a, Type: bool
function validatefunc()
{
    isonelife = !br_gametypes::isfeaturedisabled( #"onelife" );
    hasgulag = istrue( level.usegulag );
    return isonelife || hasgulag;
}

// Namespace br_publicevent_jailbreak
// Params 0
// Checksum 0x3c159c62, Offset: 0x45c
// Size: 0x23
function waitfunc()
{
    level endon( #"cancel_public_event" );
    eventstarttime = calculateeventstarttime();
    wait eventstarttime;
}

// Namespace br_publicevent_jailbreak
// Params 0
// Checksum 0x6f8795d2, Offset: 0x487
// Size: 0xe2
function activatefunc()
{
    level endon( #"game_ended" );
    pauseallgulagfights( 1 );
    waitforgulagfightstocomplete();
    br_publicevents::showsplashtoall( "br_pe_jailbreak_incoming" );
    playjailbreakvo( "incoming" );
    eventduration = getdvarfloat( @"scr_br_pe_jailbreak_duration", 30 );
    eventendtime = gettime() + eventduration * 1000;
    setomnvar( "ui_publicevent_timer_type", 2 );
    setomnvar( "ui_publicevent_timer", eventendtime );
    wait eventduration;
    br_publicevents::showsplashtoall( "br_pe_jailbreak_active" );
    playjailbreakvo( "now" );
    setomnvar( "ui_publicevent_timer_type", 0 );
    wait 1;
    playerlist = respawnplayers();
    level thread forcestopwaitforgulagtoempty();
    function_1f7d99f802aea4e4( playerlist );
    level notify( #"hash_edf2e0c2586d0e50" );
    pauseallgulagfights( 0 );
}

// Namespace br_publicevent_jailbreak
// Params 0
// Checksum 0x95d56651, Offset: 0x571
// Size: 0x84
function forcestopwaitforgulagtoempty()
{
    if ( !getdvarint( @"hash_50e4237b891b5501", 1 ) )
    {
        return;
    }
    
    level endon( #"game_ended" );
    level endon( #"hash_edf2e0c2586d0e50" );
    waittime = 10;
    
    if ( isdefined( level.gulag ) && isdefined( level.gulag.var_75c78a7ce3beec92 ) )
    {
        waittime = level.gulag.var_75c78a7ce3beec92;
    }
    
    wait waittime;
    level notify( #"forcestopwaitforgulagtoempty" );
}

// Namespace br_publicevent_jailbreak
// Params 0
// Checksum 0xad6411ac, Offset: 0x5fd
// Size: 0x51
function calculateeventstarttime()
{
    minstarttime = getdvarfloat( @"scr_br_pe_jailbreak_starttime_min", 795 );
    maxstarttime = getdvarfloat( @"scr_br_pe_jailbreak_starttime_max", 1110 );
    
    if ( maxstarttime > minstarttime )
    {
        return randomfloatrange( minstarttime, maxstarttime );
    }
    
    return minstarttime;
}

// Namespace br_publicevent_jailbreak
// Params 1
// Checksum 0x1c36191b, Offset: 0x656
// Size: 0x15
function pauseallgulagfights( var_b9da3c3bd917e62b )
{
    br_gulag::pausegulag( var_b9da3c3bd917e62b );
}

// Namespace br_publicevent_jailbreak
// Params 0
// Checksum 0x80398a8, Offset: 0x673
// Size: 0x2a
function waitforgulagfightstocomplete()
{
    level endon( #"game_ended" );
    wait 1;
    
    while ( true )
    {
        if ( !br_gulag::areanygulagfightsactive() )
        {
            break;
        }
        
        waitframe();
    }
}

// Namespace br_publicevent_jailbreak
// Params 1
// Checksum 0x5c0ba330, Offset: 0x6a5
// Size: 0xca
function function_1f7d99f802aea4e4( playerlist )
{
    level endon( #"game_ended" );
    level endon( #"forcestopwaitforgulagtoempty" );
    
    if ( br_gametypes::isfeaturedisabled( #"gulag" ) )
    {
        return;
    }
    
    gulagempty = 0;
    
    while ( !gulagempty )
    {
        gulagempty = 1;
        
        foreach ( p in playerlist )
        {
            if ( p br_public::isplayerinorgoingtogulag() )
            {
                gulagempty = 0;
                break;
            }
        }
        
        waitframe();
    }
}

// Namespace br_publicevent_jailbreak
// Params 1
// Checksum 0x24fdce90, Offset: 0x777
// Size: 0x218
function buildrespawnlist( var_f5457b2113554e6c )
{
    respawnplayers = [];
    var_9d58fe3be5c94410 = isdefined( level.gulag );
    var_ba4fa95834d0c4ce = isdefined( level.uibotmanager );
    
    foreach ( entry in level.teamnamelist )
    {
        if ( entry == "spectator" || entry == "codcaster" )
        {
            continue;
        }
        
        if ( var_f5457b2113554e6c )
        {
            hasaliveplayers = level.teamdata[ entry ][ "teamCount" ] > 0;
        }
        else
        {
            hasaliveplayers = level.teamdata[ entry ][ "aliveCount" ] > 0;
        }
        
        if ( !hasaliveplayers && var_ba4fa95834d0c4ce && level.teamdata[ entry ][ "UIBotCount" ] > 0 )
        {
            hasaliveplayers = 1;
        }
        
        if ( hasaliveplayers )
        {
            foreach ( player in level.teamdata[ entry ][ "players" ] )
            {
                var_37dd7dcaf606bf15 = var_9d58fe3be5c94410 && player br_public::isplayerinorgoingtogulag();
                
                if ( !isalive( player ) && !var_37dd7dcaf606bf15 )
                {
                    respawnplayers[ respawnplayers.size ] = player;
                    continue;
                }
                
                if ( isalive( player ) && var_37dd7dcaf606bf15 )
                {
                    respawnplayers[ respawnplayers.size ] = player;
                    continue;
                }
                
                if ( namespace_a8afdcd7738e364e::function_373b8665fd6de550() && !isalive( player ) && var_37dd7dcaf606bf15 )
                {
                    respawnplayers[ respawnplayers.size ] = player;
                }
            }
        }
    }
    
    return respawnplayers;
}

// Namespace br_publicevent_jailbreak
// Params 0
// Checksum 0xaa0abd0c, Offset: 0x998
// Size: 0x1e0
function respawnplayer()
{
    self endon( #"disconnect" );
    
    if ( isdefined( level.brwinnerscircle ) && [[ level.brwinnerscircle.var_41b10fd9fb1a88d3 ]]( self ) )
    {
        self [[ level.brwinnerscircle.deactivateimmediate ]]();
    }
    
    self.pers[ "telemetry" ].is_early_disconnect = 1;
    isingulag = isalive( self ) && isdefined( level.gulag ) && !level.gulag.shutdown && br_public::isplayerinorgoingtogulag();
    
    if ( isingulag )
    {
        thread br_gulag::jailbreakeventplayer();
    }
    else
    {
        thread br_gulag::playergulagautowin( "jailbreak", undefined, undefined, 1, 1 );
    }
    
    self notify( #"jailbreak_respawn" );
    
    if ( namespace_a8afdcd7738e364e::function_373b8665fd6de550() )
    {
        arena = namespace_a974e4dd85555bc2::function_bc8c8f723d5d7be8( self );
        
        if ( !isdefined( arena ) )
        {
            arena = namespace_a974e4dd85555bc2::function_b137a10652cd5cd6( self );
        }
        
        if ( isdefined( arena ) )
        {
            if ( arraycontains( arena.arenaplayers, self ) )
            {
                arena.arenaplayers = arrayremove( arena.arenaplayers, self );
            }
            else if ( arraycontains( arena.jailedplayers, self ) )
            {
                arena.jailedplayers = arrayremove( arena.jailedplayers, self );
            }
            
            if ( isdefined( arena.var_a8bbf2a2aedca4c9 ) )
            {
                if ( arraycontains( arena.var_a8bbf2a2aedca4c9, self ) )
                {
                    arena.var_a8bbf2a2aedca4c9 = arrayremove( arena.var_a8bbf2a2aedca4c9, self );
                }
            }
            
            br_gulag::playerdestroyhud( arena );
            br_gulag::updatematchqueuepositions( arena );
            
            if ( br_twotwo_gulag::function_a826a6e753a74909() )
            {
                br_twotwo_gulag::function_c637cdd44e4fb704( arena );
            }
        }
    }
    
    waitframe();
    self setclientomnvar( "ui_br_squad_eliminated_active", 0 );
    self setclientomnvar( "ui_show_tac_map", 0 );
}

// Namespace br_publicevent_jailbreak
// Params 0
// Checksum 0x3faba118, Offset: 0xb80
// Size: 0xc1
function respawnplayers()
{
    level endon( #"game_ended" );
    var_f5457b2113554e6c = getdvarint( @"hash_c622900a5fa1e2c6", 1 );
    playerlist = buildrespawnlist( var_f5457b2113554e6c );
    
    foreach ( player in playerlist )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        player thread respawnplayer();
    }
    
    level.var_5aaf221daf42f53c = undefined;
    return playerlist;
}

// Namespace br_publicevent_jailbreak
// Params 1
// Checksum 0x33901f4, Offset: 0xc4a
// Size: 0x29d
function playjailbreakvo( aliasname )
{
    activeplayers = [];
    gulagplayers = [];
    spectateplayers = [];
    var_8fa435c114d34294 = isdefined( level.gulag ) && !level.gulag.shutdown;
    var_f5457b2113554e6c = getdvarint( @"hash_c622900a5fa1e2c6", 1 );
    
    foreach ( entry in level.teamnamelist )
    {
        hasaliveplayers = level.teamdata[ entry ][ "aliveCount" ] > 0;
        
        if ( var_f5457b2113554e6c )
        {
            hasaliveplayers = level.teamdata[ entry ][ "teamCount" ] > 0;
        }
        
        if ( hasaliveplayers )
        {
            foreach ( player in level.teamdata[ entry ][ "players" ] )
            {
                var_37dd7dcaf606bf15 = var_8fa435c114d34294 && player br_public::isplayerinorgoingtogulag();
                
                if ( !isalive( player ) && !var_37dd7dcaf606bf15 )
                {
                    spectateplayers[ spectateplayers.size ] = player;
                    continue;
                }
                
                if ( isalive( player ) && var_37dd7dcaf606bf15 )
                {
                    gulagplayers[ gulagplayers.size ] = player;
                    continue;
                }
                
                if ( isalive( player ) )
                {
                    activeplayers[ activeplayers.size ] = player;
                }
            }
        }
    }
    
    if ( activeplayers.size > 0 )
    {
        activesuffix = utility::cointoss() ? "_active" : "_active_alt";
        br_public::brleaderdialog( "public_events_jailbreak_" + aliasname + activesuffix, 0, activeplayers, 1, 1 );
    }
    
    if ( gulagplayers.size > 0 )
    {
        gulagsuffix = "_gulag";
        br_public::brleaderdialog( "public_events_jailbreak_" + aliasname + gulagsuffix, 0, gulagplayers, 1, 1 );
    }
    
    if ( spectateplayers.size > 0 )
    {
        spectatesuffix = "_spectate";
        br_public::brleaderdialog( "public_events_jailbreak_" + aliasname + spectatesuffix, 0, spectateplayers, 1, 1 );
    }
}

