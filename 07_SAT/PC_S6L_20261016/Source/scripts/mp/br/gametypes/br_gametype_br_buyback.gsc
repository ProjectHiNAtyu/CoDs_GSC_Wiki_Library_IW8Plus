// scripts\mp\br\gametypes\br_gametype_br_buyback.gsc  (hash_5276744b4f6a38c1.gscc) (size: 7897 Bytes / 0x1ed9 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xadaee60c (2913920524)
// size ...... 7897 (0x1ed9)
// includes .. 21  (offset: 0x1ce5)
// strings ... 15  (offset: 0x1d8d)
// dev strs .. 11  (offset: 0x1e51)
// exports ... 28  (offset: 0xedd)
// cseg ...... 0x1cb + 0xd12 (0xedd)
// imports ... 82  (offset: 0x133d)
// animtree1 . 0   (offset: 0x1ed9)
// animtree2 . 0   (offset: 0x1ed9)
#using scripts\common\callbacks;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\mp\br\gametypes\br;
#using scripts\mp\br\gametypes\br_dev;
#using scripts\mp\br\gametypes\br_gametype_resurgence;
#using scripts\mp\br\gametypes\br_gametypes;
#using scripts\mp\br\gametypes\br_gulag;
#using scripts\mp\br\gametypes\br_killstreaks;
#using scripts\mp\br\gametypes\br_pickups;
#using scripts\mp\br\gametypes\br_plunder;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\br\gametypes\br_quest_util;
#using scripts\mp\common\utility\audio_utility;
#using scripts\mp\common\utility\connect_event_aggregator;
#using scripts\mp\common\utility\disconnect_event_aggregator;
#using scripts\mp\common\utility\lower_message;
#using scripts\mp\events;
#using scripts\mp\flags;
#using scripts\mp\hud_message;
#using scripts\mp\loot\common_item_redeploy_token;

#namespace br_gametype_br_buyback;

// Namespace br_gametype_br_buyback
// Params 0
// Checksum 0x23987068, Offset: 0x1e9
// Size: 0x17
function main()
{
    level.var_dd10333ade220938 = &init;
    br::main();
}

// Namespace br_gametype_br_buyback
// Params 0
// Checksum 0x6c6ccd41, Offset: 0x208
// Size: 0x21e
function init()
{
    setdvarifuninitialized( @"scr_br_alt_mode_inflation_cost", 400 );
    level.br_alt_mode_inflation = spawnstruct();
    level.br_alt_mode_inflation.disabled = 0;
    level.br_alt_mode_inflation.cost = getdvarint( @"scr_br_alt_mode_inflation_cost", 400 );
    level.br_alt_mode_inflation.drop_percent = getdvarfloat( @"scr_br_alt_mode_inflation_drop_percent", 0.4 );
    level.br_alt_mode_inflation.drop_max = getdvarint( @"scr_br_alt_mode_inflation_drop_max", -1 );
    level.br_alt_mode_inflation.end_circle = getdvarint( @"scr_br_alt_mode_inflation_end_circle", 5 );
    level.br_alt_mode_inflation.respawn_delay = getdvarfloat( @"scr_br_alt_mode_inflation_respawn_delay", 10 );
    utility::registersharedfunc( #"gametype", #"hash_c58d6a4317d0041e", &playerdropplunderondeath );
    utility::registersharedfunc( #"gametype", #"circletimer", &circletimer );
    utility::registersharedfunc( #"gametype", #"hash_734dfff09080996f", &postplunder );
    utility::registersharedfunc( #"gametype", #"markplayeraseliminatedonkilled", &markplayeraseliminatedonkilled );
    utility::registersharedfunc( #"gametype", #"hash_1de385892cb526fe", &playergulagautowinwait );
    utility::registersharedfunc( #"gametype", #"triggerrespawnoverlay", &triggerrespawnoverlay );
    
    if ( !getdvarint( @"scr_br_alt_mode_inflation_gulag", 0 ) )
    {
        br_gametypes::disablefeature( #"gulag" );
    }
    
    br_gametypes::disablefeature( #"hash_856067c342f8f1a5" );
    thread initcallbacks();
    initsound();
    level.var_557ca452c24fc971 = &spectatorrespawntimer;
    level.brgametype.var_98f0526861c88ad2 = level.br_alt_mode_inflation.end_circle;
    
    /#
        thread inflation_devgui();
    #/
}

// Namespace br_gametype_br_buyback
// Params 0
// Checksum 0x5e1cbda5, Offset: 0x42e
// Size: 0x51
function onstartgametype()
{
    if ( getdvarint( @"hash_2f7e5613ceba7ab3", 1 ) )
    {
        splash_table = hud_message::getsplashtablename();
        events::function_9b13e8fe0c7de907( #"inflation_plunder_lost", splash_table );
    }
    
    if ( getdvarint( @"hash_124cacedf61fac57", 1 ) )
    {
        thread function_d441184c27d1424d();
    }
}

// Namespace br_gametype_br_buyback
// Params 0
// Checksum 0xf36b22d0, Offset: 0x487
// Size: 0x9b
function function_d441184c27d1424d()
{
    level endon( #"game_ended" );
    flags::gameflagwait( "prematch_done" );
    flags::gameflagwait( "prematch_fade_done" );
    
    while ( level.br_circle.circleindex < 0 )
    {
        waitframe();
    }
    
    totaltime = br_gulag::gettimetogulagclosed();
    totaltimems = int( totaltime * 1000 );
    starttimems = gettime();
    var_95ad0500abb003ce = starttimems + totaltimems;
    thread function_499aac7ddca79ac5( var_95ad0500abb003ce );
    wait totaltime;
    setomnvar( "ui_resurgence_respawn_end_time", 0 );
}

// Namespace br_gametype_br_buyback
// Params 1
// Checksum 0xf35d5cbb, Offset: 0x52a
// Size: 0x28
function function_499aac7ddca79ac5( var_95ad0500abb003ce )
{
    setomnvarforallclients( "ui_br_resurgence_will_disable", 1 );
    setomnvar( "ui_resurgence_respawn_end_time", int( var_95ad0500abb003ce ) );
}

// Namespace br_gametype_br_buyback
// Params 0
// Checksum 0x98adef1f, Offset: 0x55a
// Size: 0x2f
function initcallbacks()
{
    callback::add( #"player_spawned", &onplayerspawned );
    connect_event_aggregator::registeronconnectcallback( &onplayerconnect );
    disconnect_event_aggregator::registerondisconnecteventcallback( &onplayerdisconnect );
}

// Namespace br_gametype_br_buyback
// Params 0, eflags: 0x4
// Checksum 0xd0b33c81, Offset: 0x591
// Size: 0xe
function private initsound()
{
    thread audio_utility::snd_transient_load( "mp_gametype_buyback" );
}

// Namespace br_gametype_br_buyback
// Params 0
// Checksum 0x4fedcf1f, Offset: 0x5a7
// Size: 0x35
function onplayerconnect()
{
    callback::add( "currency_add", &postplunder );
    callback::add( "currency_sub", &postplunder );
    callback::add( "currency_set", &postplunder );
}

// Namespace br_gametype_br_buyback
// Params 1
// Checksum 0xb81bd8ed, Offset: 0x5e4
// Size: 0x3f
function onplayerdisconnect( player )
{
    callback::remove( "currency_add", &postplunder );
    callback::remove( "currency_sub", &postplunder );
    callback::remove( "currency_set", &postplunder );
}

// Namespace br_gametype_br_buyback
// Params 1
// Checksum 0x2dfe6fca, Offset: 0x62b
// Size: 0x13
function onplayerspawned( params )
{
    updaterespawnstatus();
}

// Namespace br_gametype_br_buyback
// Params 0
// Checksum 0x497fb41b, Offset: 0x646
// Size: 0x52, Type: bool
function playercanbuyrespawn()
{
    return level.br_prematchstarted && !self.br_iseliminated && !level.br_alt_mode_inflation.disabled && self.plundercount >= level.br_alt_mode_inflation.cost;
}

// Namespace br_gametype_br_buyback
// Params 2
// Checksum 0xf6b78658, Offset: 0x6a1
// Size: 0x121
function playerdropplunderondeath( dropstruct, attacker )
{
    if ( !isdefined( self ) )
    {
        return;
    }
    
    var_7e8cd265f905b7a0 = self.plundercount;
    
    if ( self.respawningfromtoken )
    {
        var_7e8cd265f905b7a0 -= level.br_alt_mode_inflation.cost;
        
        if ( var_7e8cd265f905b7a0 < 0 )
        {
            var_7e8cd265f905b7a0 = 0;
        }
    }
    
    if ( !isdefined( var_7e8cd265f905b7a0 ) || var_7e8cd265f905b7a0 < 0 )
    {
        var_7e8cd265f905b7a0 = 0;
    }
    
    var_f8cbc86c55703cf4 = int( var_7e8cd265f905b7a0 * level.br_alt_mode_inflation.drop_percent );
    var_7e8cd265f905b7a0 -= var_f8cbc86c55703cf4;
    
    if ( var_7e8cd265f905b7a0 < 0 )
    {
        var_7e8cd265f905b7a0 = 0;
    }
    
    br_plunder::playersetplundercount( var_7e8cd265f905b7a0, getsetplundercountdatanosplash() );
    
    if ( level.br_alt_mode_inflation.drop_max >= 0 )
    {
        var_f8cbc86c55703cf4 = int( min( level.br_alt_mode_inflation.drop_max, var_f8cbc86c55703cf4 ) );
    }
    
    if ( level.minplunderdropondeath >= 0 )
    {
        var_f8cbc86c55703cf4 = int( max( level.minplunderdropondeath, var_f8cbc86c55703cf4 ) );
    }
    
    if ( var_f8cbc86c55703cf4 > 0 )
    {
        br_plunder::dropcondensedplunder( var_f8cbc86c55703cf4, dropstruct );
    }
    
    return 1;
}

// Namespace br_gametype_br_buyback
// Params 1
// Checksum 0x947017cf, Offset: 0x7cb
// Size: 0x10e, Type: bool
function circletimer( circleindex )
{
    if ( !circleindex )
    {
        br_gulag::setupgulagtimer();
    }
    
    endcircle = level.br_alt_mode_inflation.end_circle;
    
    if ( !level.br_alt_mode_inflation.disabled && circleindex >= endcircle )
    {
        level.br_alt_mode_inflation.disabled = 1;
        setomnvar( "ui_gulag_timer", 0 );
        
        foreach ( player in level.players )
        {
            if ( !isalive( player ) )
            {
                continue;
            }
            
            player updaterespawnstatus( 0 );
            br_killstreaks::dangernotifyplayer( player, "cash_deploy_closed", 3 );
        }
    }
    
    return false;
}

// Namespace br_gametype_br_buyback
// Params 1
// Checksum 0x99aa760d, Offset: 0x8e2
// Size: 0x35
function postplunder( data )
{
    skipsplash = 0;
    
    if ( isdefined( data ) )
    {
        skipsplash = data.skipsplash;
    }
    
    updaterespawnstatus( skipsplash );
}

// Namespace br_gametype_br_buyback
// Params 1
// Checksum 0x6d958f01, Offset: 0x91f
// Size: 0x5f
function updaterespawnstatus( skipsplash )
{
    if ( playercanbuyrespawn() )
    {
        if ( !br_public::hasrespawntoken() )
        {
            br_pickups::addrespawntoken( 1 );
            
            if ( !skipsplash )
            {
                thread hud_message::showsplash( "br_inflation_respawn_token_granted" );
            }
        }
        
        return;
    }
    
    if ( br_public::hasrespawntoken() )
    {
        item_redeploy_token::function_16ab0a48337237ef();
        
        if ( !skipsplash )
        {
            thread hud_message::showsplash( "br_inflation_respawn_token_lost" );
        }
    }
}

// Namespace br_gametype_br_buyback
// Params 1
// Checksum 0x25fe8b93, Offset: 0x986
// Size: 0x6e
function function_78c98827d248f06b( timer )
{
    br_gametype_resurgence::function_12b97810099f2b4d();
    br_gametype_resurgence::function_6f6222b4837d3c31( timer );
    br_gametype_resurgence::function_dd217918caad1c89( undefined );
    
    while ( timer > 0 )
    {
        if ( isalive( self ) )
        {
            timer = 0;
        }
        else
        {
            br_gametype_resurgence::function_6f6222b4837d3c31( timer );
        }
        
        wait 1;
        timer--;
    }
    
    br_gametype_resurgence::function_e9f3e6b5a7d226b0();
    br_gametype_resurgence::function_6f6222b4837d3c31( 0 );
    br_gametype_resurgence::function_dd217918caad1c89( undefined );
    self setclientomnvar( "ui_br_alt_mode_inflation_respawn_state", 0 );
}

// Namespace br_gametype_br_buyback
// Params 1
// Checksum 0xed87ae5f, Offset: 0x9fc
// Size: 0x3a
function showrespawntimer( timer )
{
    waittillframeend();
    lower_message::setlowermessageomnvar( "waiting_to_spawn", int( gettime() + timer * 1000 ) );
    br_gulag::setplayeringulagjailextrainfo( 1 );
    hiderespawntimer( timer );
}

// Namespace br_gametype_br_buyback
// Params 1
// Checksum 0x789ddecb, Offset: 0xa3e
// Size: 0x41
function hiderespawntimer( waittime )
{
    self endon( #"disconnect" );
    
    if ( isdefined( waittime ) )
    {
        wait waittime;
    }
    
    self notify( #"inflation_hide_timer" );
    br_gulag::setplayeringulagjailextrainfo( 0 );
    lower_message::setlowermessageomnvar( "clear_lower_msg" );
}

// Namespace br_gametype_br_buyback
// Params 0
// Checksum 0xb8d3004a, Offset: 0xa87
// Size: 0x22
function getsetplundercountdatanosplash()
{
    data = spawnstruct();
    data.skipsplash = 1;
    return data;
}

// Namespace br_gametype_br_buyback
// Params 0
// Checksum 0x1ebde84f, Offset: 0xab2
// Size: 0x3, Type: bool
function markplayeraseliminatedonkilled()
{
    return false;
}

// Namespace br_gametype_br_buyback
// Params 1
// Checksum 0xfecc34a9, Offset: 0xabe
// Size: 0x77
function spectatorrespawntimer( victim )
{
    self notify( #"spectatorrespawntimer" );
    self endon( #"spectatorrespawntimer" );
    self endon( #"disconnect" );
    
    if ( level.br_alt_mode_inflation.respawn_delay )
    {
        respawndelay = level.br_alt_mode_inflation.respawn_delay;
        thread function_672a9eb1f3d7bea5( victim );
        showrespawntimer( respawndelay );
    }
}

// Namespace br_gametype_br_buyback
// Params 1
// Checksum 0x39e6fe5e, Offset: 0xb3d
// Size: 0x52
function function_672a9eb1f3d7bea5( victim )
{
    self endon( #"spectatorrespawntimer" );
    self endon( #"disconnect" );
    victim endon( #"spawned_player" );
    self endon( #"inflation_hide_timer" );
    victim waittill( #"disconnect" );
    thread hiderespawntimer();
}

// Namespace br_gametype_br_buyback
// Params 2
// Checksum 0xfcea60e5, Offset: 0xb97
// Size: 0x65, Type: bool
function playergulagautowinwait( sponsor, tokenused )
{
    if ( !isdefined( sponsor ) )
    {
        respawndelay = level.br_alt_mode_inflation.respawn_delay;
        
        if ( respawndelay )
        {
            thread showrespawntimer( respawndelay );
            self.respawndelay = respawndelay;
            wait respawndelay;
            self.respawndelay = 0;
            return true;
        }
    }
    
    return false;
}

// Namespace br_gametype_br_buyback
// Params 1
// Checksum 0xd0473de8, Offset: 0xc05
// Size: 0xe, Type: bool
function triggerrespawnoverlay( overlaytype )
{
    return true;
}

/#

    // Namespace br_gametype_br_buyback
    // Params 0
    // Checksum 0xca9a031a, Offset: 0xc1c
    // Size: 0x9b, Type: dev
    function inflation_devgui()
    {
        br_dev::registerhandlecommand( &handledevcommand_inflation );
        debughud = "<dev string:x24>";
        thread br_quest_util::adddebugcommanddelayed( debughud + "<dev string:x48>" );
        thread br_quest_util::adddebugcommanddelayed( debughud + "<dev string:x82>" );
        
        for ( i = 0; i < 5 ; i++ )
        {
            thread br_quest_util::adddebugcommanddelayed( debughud + "<dev string:xc2>" + i + "<dev string:xcf>" + i + "<dev string:xf0>" );
            thread br_quest_util::adddebugcommanddelayed( debughud + "<dev string:xf3>" + i + "<dev string:x103>" + i + "<dev string:xf0>" );
        }
    }

    // Namespace br_gametype_br_buyback
    // Params 1
    // Checksum 0x1206a2a9, Offset: 0xcbf
    // Size: 0x18b, Type: dev
    function function_50734a1f6f7f0a0f( args )
    {
        target = undefined;
        
        if ( args[ 0 ] == "<dev string:x127>" )
        {
            looker = undefined;
            
            foreach ( player in level.players )
            {
                if ( player isplayerheadless() )
                {
                    continue;
                }
                
                if ( isbot( player ) )
                {
                    continue;
                }
                
                looker = player;
                break;
            }
            
            if ( !isdefined( looker ) )
            {
                return;
            }
            
            tracestart = looker geteye();
            traceend = tracestart + anglestoforward( looker getplayerangles() ) * 100000;
            tracecontents = trace::create_character_contents();
            trace = trace::ray_trace( tracestart, traceend, looker, tracecontents );
            target = trace[ "<dev string:x12f>" ];
            color = ( 1, 0, 0 );
            
            if ( isdefined( target ) )
            {
                color = ( 0, 1, 0 );
            }
            
            sphere( trace[ "<dev string:x136>" ], 10, color, 0, 20 );
        }
        else
        {
            entnum = int( args[ 0 ] );
            target = level.players[ entnum ];
        }
        
        return target;
    }

    // Namespace br_gametype_br_buyback
    // Params 2
    // Checksum 0xe578f844, Offset: 0xe52
    // Size: 0x8b, Type: dev
    function handledevcommand_inflation( command, args )
    {
        switch ( command )
        {
            case #"hash_158e32183cf66266":
                target = function_50734a1f6f7f0a0f( args );
                
                if ( isdefined( target ) )
                {
                    target kill();
                }
                
                break;
            case #"hash_4bb95b0621e981e8":
                target = function_50734a1f6f7f0a0f( args );
                
                if ( isdefined( target ) )
                {
                    target br_plunder::playerplunderpickup( 100 );
                }
                
                break;
            default:
                break;
        }
    }

#/
