// scripts\mp\br\gametypes\br_gulag.gsc  (hash_12e9f63dac5ec9fe.gscc) (size: 149980 Bytes / 0x249dc / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xd0a43fc3 (3500425155)
// size ...... 149980 (0x249dc)
// includes .. 84  (offset: 0x223c4)
// strings ... 491 (offset: 0x22664)
// dev strs .. 82  (offset: 0x24578)
// exports ... 303 (offset: 0x186b0)
// cseg ...... 0x2f3e + 0x15772 (0x186b0)
// imports ... 839 (offset: 0x1b608)
// animtree1 . 0   (offset: 0x249dc)
// animtree2 . 0   (offset: 0x249dc)
#using script_130d36f66baea3af;
#using script_16ea1b94f0f381b3;
#using script_3cb3908b3094b567;
#using script_47dfdc6ed6920774;
#using script_68bfedf2ed730bd;
#using script_6962ddc481c4af49;
#using scripts\common\bots\bots_util;
#using scripts\common\callbacks;
#using scripts\common\damage_effects;
#using scripts\common\script;
#using scripts\common\scriptable;
#using scripts\common\throttle;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\weapon;
#using scripts\mp\armor;
#using scripts\mp\br\gametypes\br;
#using scripts\mp\br\gametypes\br_ai_gulag;
#using scripts\mp\br\gametypes\br_analytics;
#using scripts\mp\br\gametypes\br_c130;
#using scripts\mp\br\gametypes\br_contract_manager;
#using scripts\mp\br\gametypes\br_dom_gulag;
#using scripts\mp\br\gametypes\br_dom_quest;
#using scripts\mp\br\gametypes\br_gametype_resurgence;
#using scripts\mp\br\gametypes\br_gametypes;
#using scripts\mp\br\gametypes\br_infils_legacy;
#using scripts\mp\br\gametypes\br_killstreaks;
#using scripts\mp\br\gametypes\br_large_gulag;
#using scripts\mp\br\gametypes\br_pickups;
#using scripts\mp\br\gametypes\br_plunder;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\br\gametypes\br_spawnrespawn;
#using scripts\mp\br\gametypes\br_spectate;
#using scripts\mp\br\gametypes\br_supply_drops_common;
#using scripts\mp\br\gametypes\br_twotwo_gulag;
#using scripts\mp\br\gametypes\br_utility;
#using scripts\mp\br\gametypes\br_vip_quest;
#using scripts\mp\br\gametypes\br_weapons;
#using scripts\mp\calloutmarkerping;
#using scripts\mp\challenges;
#using scripts\mp\class;
#using scripts\mp\codcaster_utils;
#using scripts\mp\codcasterclientmatchdata;
#using scripts\mp\common\equipment\molotov;
#using scripts\mp\common\utility\damage;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\inventory_utility;
#using scripts\mp\common\utility\lower_message;
#using scripts\mp\common\utility\lui_game_event_aggregator;
#using scripts\mp\common\utility\outline;
#using scripts\mp\common\utility\perk;
#using scripts\mp\common\utility\pickups_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\teams;
#using scripts\mp\currency;
#using scripts\mp\deathicons;
#using scripts\mp\equipment;
#using scripts\mp\execution;
#using scripts\mp\flags;
#using scripts\mp\gamelogic;
#using scripts\mp\gameobjects;
#using scripts\mp\gametypes\obj_dom;
#using scripts\mp\gestures;
#using scripts\mp\hud;
#using scripts\mp\hud_message;
#using scripts\mp\hud_util;
#using scripts\mp\laststand;
#using scripts\mp\loot\common_inventory;
#using scripts\mp\loot\common_item;
#using scripts\mp\loot\common_item_ammo;
#using scripts\mp\loot\common_item_currency;
#using scripts\mp\loot\common_item_gulag_token;
#using scripts\mp\loot\common_item_redeploy_token;
#using scripts\mp\loot\common_item_weapon;
#using scripts\mp\music_br;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\outofbounds;
#using scripts\mp\playerhealth;
#using scripts\mp\playerlogic;
#using scripts\mp\spectating;
#using scripts\mp\weapons;

#namespace br_gulag;

// Namespace br_gulag
// Params 0
// Checksum 0x79e930ca, Offset: 0x2f5c
// Size: 0x9fa
function initgulag()
{
    level.respawncircleinterppct = getdvarfloat( @"hash_ba0a30562f3b3d2", 0.75 );
    
    if ( !level.usegulag )
    {
        return;
    }
    
    if ( br_gametypes::isfeaturedisabled( #"gulag" ) )
    {
        level.usegulag = 0;
        return;
    }
    
    setomnvar( "ui_gulag_state", 1 );
    setomnvar( "ui_gulag_show_closing_state", 0 );
    level.gulag = {};
    level.gulag.arenaflag = getdvarint( @"scr_br_fc_flag", 0 );
    level.gulag.maxplayers = getmaxplayers();
    level.gulag.maxuses = getdvarint( @"scr_br_fc_max_uses", 1 );
    level.gulag.endonshutdown = getdvarint( @"hash_a208c2044d682252", 3 );
    level.gulag.var_57fe56d04634639a = getdvarint( @"scr_br_fc_max_queue_size", 2 );
    level.gulag.onekillwin = getdvarint( @"hash_87f668a2b16e5a88", 0 );
    level.gulag.multiarena = getdvarint( @"hash_29b4dd2fcb154cc9", 1 );
    level.gulag.planerespawn = getdvarint( @"hash_86ce8bb55042030d", 0 );
    level.gulag.introcinematic = getdvarint( @"hash_1acebad8080ce298", 1 );
    level.gulag.outrocinematic = getdvarint( @"hash_adea9f7a92ca117d", 0 );
    level.gulag.var_f0e376124326d6f6 = getdvarint( @"hash_7ea3ac91f30ce5a5", 17000 );
    level.gulag.usecellspawns = getdvarint( @"hash_9fa493a57b8993fb", 1 );
    level.gulag.usefloorrocks = getdvarint( @"hash_b962f2b08f7dafc7", 0 );
    level.gulag.spawnloot = getdvarint( @"hash_1db2120552a886e9", 0 );
    level.gulag.lethaldelay = getdvarint( @"hash_133cbace5a3c90bd", 3 );
    level.gulag.streamtimeout = getdvarint( @"hash_901c31aaa4eee907", 9 );
    level.gulag.numarmorhealth = utility::function_edc4cc03e9e60b3e( @"hash_abe2e86213098021", 0, level.gametypebundle.var_3006353f8eaf36b );
    level.gulag.matchsize = getdvarint( @"hash_2ebff4c1f3d778e0", 2 );
    level.gulag.var_68477f8a49b62826 = getdvarint( @"hash_e7819166ffa65760", 0 );
    level.gulag.var_8298e7c5cc1de463 = getdvarfloat( @"hash_81b659c0585a8952", 7 );
    level.gulag.var_e4c82af12e81450 = getdvarint( @"hash_283378c11c27c32c", 1 );
    level.gulag.var_97519a5bc9e36000 = getdvarint( @"hash_25f058368af3bc5a", 400 );
    level.gulag.var_3f3865d50f194eb6 = getdvarint( @"hash_ea64fff27301195a", 200 );
    level.gulag.var_731eed23c5932ff8 = getdvarint( @"hash_edfa133b5822a2e8", 400 );
    level.gulag.var_f75f7a662856c392 = getdvarint( @"hash_590ae68d2c03b69b", 5 );
    level.gulag.gulagRockDisabled = getmatchrulesdata( "brData", "gulagRockDisabled" ) ?? 0;
    level.gulag.var_252f2b813896be36 = getmatchrulesdata( "brData", "gulagRefillRocksMatchStart" );
    level.gulag.circledisable = getmatchrulesdata( "brData", "gulagCircleDisable" );
    level.gulag.preloadcinematic = getdvarint( @"hash_9086d17110b3195b", 1 );
    level.gulag.var_75c78a7ce3beec92 = getdvarint( @"hash_39b3dfa0d177879d", 10 );
    level.gulag.var_afcf7128589ec970 = getdvarint( @"hash_3e29e5df72de48b6", 1 ) == 1;
    level.gulag.selfbuyback = getmatchrulesdata( "brData", "gulagSelfBuyBack" ) ?? 0;
    level.gulag.allowmeatshield = getdvarint( @"hash_5a12500c373dca7b", 0 );
    level.gulag.giveloadoutontimeout = getdvarint( @"hash_e0b0ef543336d54e", 1 );
    level.gulag.var_12d1f7b5512cf6b3 = getdvarint( @"hash_d7d06a89b08a92d5", 1 ) == 1;
    level.gulag.playergivearenaloadoutthrottle = throttle::throttle_initialize( "gulag_playerGiveArenaLoadout_throttle", undefined, undefined, 2 );
    level.gulag.var_d4b7a6e283d75b94 = utility::function_d2db822aceef856a( getdvar( @"hash_e60a0d6d28bd32bd", "1.0,0.7,0.5,0.45,0.45,0.45,0.45,0.45,0.45,0.45" ), "," );
    level.gulag.var_6d372bcc606f75c6 = getdvarint( @"hash_6a2122328d714d86", 0 ) == 1;
    
    if ( level.gulag.selfbuyback )
    {
        br_gametypes::disablefeature( #"hash_856067c342f8f1a5" );
        callback::add( "currency_add", &function_23d985122d459b84 );
        callback::add( "currency_sub", &function_23d985122d459b84 );
        callback::add( "currency_set", &function_23d985122d459b84 );
        utility::registersharedfunc( #"gametype", #"hash_1de385892cb526fe", &function_22f8c99de57084aa );
        level.gulag.var_263efc3083ecff0a = getdvarint( @"hash_57b22a1f6d0f90b5", 1 );
        level.gulag.var_813d58fe9ee7f840 = getdvarint( @"hash_e739d73c83f0da31", 30 );
        setomnvar( o"ui_br_resurgence_respawn_enabled", 1 );
    }
    
    if ( namespace_a8afdcd7738e364e::function_3d1f225aa0b4d926( "gulagGetMatchDuration" ) )
    {
        level.gulag.timelimit = namespace_a8afdcd7738e364e::function_2af099d01df1a89c( "gulagGetMatchDuration" );
    }
    else
    {
        level.gulag.timelimit = getdvarfloat( @"hash_8be34599dfa102b8", 15 );
    }
    
    _setdomflagiconinfo( "waypoint_captureneutral", "neutral", "MP_BR_INGAME/DOM_CAPTURE", 0 );
    _setdomflagiconinfo( "waypoint_capture", "enemy", "MP_BR_INGAME/DOM_CAPTURE", 0 );
    _setdomflagiconinfo( "waypoint_defend", "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", 0 );
    _setdomflagiconinfo( "waypoint_defending", "friendly", "MP_INGAME_ONLY/OBJ_DEFENDING_CAPS", 0 );
    _setdomflagiconinfo( "waypoint_contested", "contest", "MP_INGAME_ONLY/OBJ_CONTESTED_CAPS", 1 );
    _setdomflagiconinfo( "waypoint_taking", "friendly", "MP_INGAME_ONLY/OBJ_CAPTURING_CAPS", 1 );
    _setdomflagiconinfo( "waypoint_losing", "enemy", "MP_INGAME_ONLY/OBJ_CAPTURING_CAPS", 1 );
    level.gulag.laststandplayers = [];
    
    if ( level.gulag.arenaflag )
    {
        br_dom_quest::setupdom();
    }
    
    namespace_e3920327cb54c3db::function_47f365ba09943ac5();
    namespace_c2403cc64e8875c4::init();
    level.gulag.arenas = gulaggetarenas();
    
    if ( level.gulag.arenas.size == 0 )
    {
        println( "<dev string:x24>" );
        level.usegulag = 0;
        return;
    }
    
    if ( bots_util::function_deef484b5b3a3977() )
    {
        thread function_1b93f50c147596db( level.gulag.arenas );
    }
    
    gulaggesturesinit();
    gulaginitloadouts();
    
    if ( level.gulag.introcinematic )
    {
        lui_game_event_aggregator::registeronluieventcallback( &playercinematiccompletecallback );
    }
    
    if ( level.gulag.usefloorrocks )
    {
        scriptable::scriptable_addusedcallbackbypart( "brloot_rock", &rockused );
    }
    
    level.gulag.betting = getdvarint( @"hash_3fb4b54c096217", 0 );
    
    if ( level.gulag.betting )
    {
        assert( isdefined( level.br_plunder_enabled ), "<dev string:x3b>" );
        
        if ( !level.br_plunder_enabled )
        {
            level.gulag.betting = 0;
        }
    }
    
    foreach ( arena in level.gulag.arenas )
    {
        level thread monitorgulag( arena );
    }
    
    thread spawnac130();
    initvo();
    level.gamemodemolotovfunc = &recordmolotov;
    level thread function_6b69f4e276fc711e();
    level notify( #"initialized_gulag" );
    
    if ( getdvarint( @"hash_7c8a1462d79fd5e6", 1 ) )
    {
        br::function_44274c8d804a57fd( &function_1fdcc0241fac48d7 );
        br::function_c4ab1bb15d73f6e( &function_fac19430e6801944 );
    }
    
    /#
        utility::registersharedfunc( #"gulag", #"hash_92c69cebc395b9e7", &runcommand );
    #/
}

// Namespace br_gulag
// Params 0
// Checksum 0x97c9a96f, Offset: 0x395e
// Size: 0x6b, Type: bool
function function_6f00d8d1ea49f999()
{
    return level.br_prematchstarted && !level.gulag.shutdown && !self.br_iseliminated && level.gulag.selfbuyback > 0 && self.plundercount >= level.gulag.selfbuyback;
}

// Namespace br_gulag
// Params 1
// Checksum 0x7b3c2b07, Offset: 0x39d2
// Size: 0x83
function function_23d985122d459b84( data )
{
    if ( function_6f00d8d1ea49f999() )
    {
        if ( !br_public::hasrespawntoken() )
        {
            item_redeploy_token::function_190ce3e2e0f50a8a();
            
            if ( !data.info.skipsplash )
            {
                thread hud_message::showsplash( "br_inflation_respawn_token_granted" );
            }
        }
        
        return;
    }
    
    if ( br_public::hasrespawntoken() )
    {
        item_redeploy_token::function_16ab0a48337237ef();
        
        if ( !data.info.skipsplash )
        {
            thread hud_message::showsplash( "br_inflation_respawn_token_lost" );
        }
    }
}

// Namespace br_gulag
// Params 2, eflags: 0x4
// Checksum 0xd1219afe, Offset: 0x3a5d
// Size: 0x14f
function private function_22f8c99de57084aa( sponsor, tokenused )
{
    var_7237854e3be197ca = sponsor;
    
    if ( isdefined( var_7237854e3be197ca ) )
    {
        return var_7237854e3be197ca;
    }
    
    self.tokenused = tokenused;
    
    if ( !tokenused )
    {
        return;
    }
    
    respawndelay = level.gulag.var_813d58fe9ee7f840 ?? 0;
    
    if ( respawndelay <= 0 )
    {
        return 1;
    }
    
    if ( level.gulag.var_263efc3083ecff0a )
    {
        var_e1a9eed87f0c7851 = function_e7b6a060e65e4abf();
        
        if ( var_e1a9eed87f0c7851.size > 0 )
        {
            foreach ( player in var_e1a9eed87f0c7851 )
            {
                player.var_ad882e8f12cd3d2a = 0;
            }
            
            return 1;
        }
    }
    
    showrespawntimer( respawndelay );
    self.var_ad882e8f12cd3d2a = respawndelay;
    function_94ac6882af8c06c();
    self.var_ad882e8f12cd3d2a = 0;
    self notify( #"hash_ed25060c573844a0" );
    thread function_69a6f0ec858af897();
    hiderespawntimer();
    return 1;
}

// Namespace br_gulag
// Params 0, eflags: 0x4
// Checksum 0x26027ba9, Offset: 0x3bb5
// Size: 0xc2
function private function_e7b6a060e65e4abf()
{
    var_e1a9eed87f0c7851 = [];
    players = teams::getteamdata( self.team, "players" );
    
    foreach ( player in players )
    {
        if ( isalive( player ) || player.currentlyrespawning )
        {
            return [];
        }
        
        if ( player item_redeploy_token::function_6932ae7663f88c8e() )
        {
            var_e1a9eed87f0c7851[ var_e1a9eed87f0c7851.size ] = player;
        }
    }
    
    return var_e1a9eed87f0c7851;
}

// Namespace br_gulag
// Params 0, eflags: 0x4
// Checksum 0xf18c9d7e, Offset: 0x3c80
// Size: 0x45
function private function_94ac6882af8c06c()
{
    while ( self.var_ad882e8f12cd3d2a > 0 )
    {
        br_public::updatebrscoreboardstat( "respawnInSeconds", self.var_ad882e8f12cd3d2a );
        br_gametype_resurgence::function_6f6222b4837d3c31( self.var_ad882e8f12cd3d2a );
        wait 1;
        self.var_ad882e8f12cd3d2a--;
    }
}

// Namespace br_gulag
// Params 1, eflags: 0x4
// Checksum 0x93360ade, Offset: 0x3ccd
// Size: 0x24
function private showrespawntimer( timer )
{
    br_gametype_resurgence::function_12b97810099f2b4d();
    br_gametype_resurgence::function_6f6222b4837d3c31( timer );
    br_gametype_resurgence::function_dd217918caad1c89( undefined );
}

// Namespace br_gulag
// Params 0, eflags: 0x4
// Checksum 0xc3022727, Offset: 0x3cf9
// Size: 0x19
function private hiderespawntimer()
{
    br_gametype_resurgence::function_e9f3e6b5a7d226b0();
    br_gametype_resurgence::function_6f6222b4837d3c31( 0 );
    br_gametype_resurgence::function_dd217918caad1c89( undefined );
}

// Namespace br_gulag
// Params 0, eflags: 0x4
// Checksum 0x13c11df7, Offset: 0x3d1a
// Size: 0x30
function private function_69a6f0ec858af897()
{
    self endon( #"disconnect" );
    self.currentlyrespawning = 1;
    self waittill( #"spawned" );
    self.currentlyrespawning = undefined;
}

// Namespace br_gulag
// Params 2
// Checksum 0x245e8e9f, Offset: 0x3d52
// Size: 0x32, Type: bool
function function_236cb42d1fd363a4( instance, player )
{
    if ( !player.gulagarena )
    {
        return false;
    }
    
    return !instance.gulagascender;
}

// Namespace br_gulag
// Params 6
// Checksum 0x5d4a9396, Offset: 0x3d8d
// Size: 0x7e
function function_1fdcc0241fac48d7( instance, player, edgeindex, isvertical, isinverted, isgoingup )
{
    if ( function_236cb42d1fd363a4( instance, player ) )
    {
        s = spawnstruct();
        s.type = "HINT_NOBUTTON";
        s.string = &"";
        return s;
    }
}

// Namespace br_gulag
// Params 4
// Checksum 0x9d34ef1d, Offset: 0x3e14
// Size: 0x35
function function_fac19430e6801944( instance, player, edgeindex, isinverted )
{
    if ( function_236cb42d1fd363a4( instance, player ) )
    {
        return 0;
    }
}

// Namespace br_gulag
// Params 0
// Checksum 0x74e39861, Offset: 0x3e52
// Size: 0x10a
function function_a76cab32d240aeb1()
{
    if ( !level.usegulag )
    {
        return;
    }
    
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    
    while ( true )
    {
        if ( isdefined( level.gulag.arenas ) && level.gulag.arenas.size > 0 )
        {
            bestdistance = 2000;
            arena = undefined;
            
            for ( i = 0; i < level.gulag.arenas.size ; i++ )
            {
                dist = distance( self.origin, level.gulag.arenas[ i ].origin );
                
                if ( dist < bestdistance )
                {
                    arena = level.gulag.arenas[ i ];
                    bestdistance = dist;
                }
            }
            
            function_96b42f64454b09d9( arena );
        }
        
        waitframe();
    }
}

// Namespace br_gulag
// Params 1
// Checksum 0x8208b40a, Offset: 0x3f64
// Size: 0x282
function function_96b42f64454b09d9( arena )
{
    if ( !isdefined( arena ) || arena.jailedplayers.size == 0 && arena.arenaplayers.size == 0 )
    {
        self setclientomnvar( "ui_gulag", 0 );
        return;
    }
    
    if ( arena.arenaplayers.size == 0 )
    {
        if ( arena.jailedplayers.size == 1 )
        {
            self setclientomnvar( "ui_br_gulag_match_state", 0 );
            self setclientomnvar( "ui_br_gulag_match_end_time", arena.jailedplayers[ 0 ].jailtimeoutend );
        }
    }
    else
    {
        if ( isdefined( arena.fightover ) && !arena.fightover && arena.time > 0 )
        {
            time = arena.time;
            
            if ( !arena.overtime )
            {
                overtimelength = getovertimelength();
                time -= overtimelength;
            }
            
            self setclientomnvar( "ui_br_gulag_match_end_time", gettime() + int( time * 1000 ) );
        }
        else
        {
            self setclientomnvar( "ui_br_gulag_match_end_time", 0 );
        }
        
        arenastate = arena.arenaplayers[ 0 ] getclientomnvar( "ui_br_gulag_match_state" );
        
        if ( arenastate )
        {
            self setclientomnvar( "ui_br_gulag_match_state", arenastate );
        }
        
        packedval = 0;
        omnvarcount = 0;
        var_6674c6f33f937c56 = 4;
        
        for ( i = 0; i < var_6674c6f33f937c56 ; i++ )
        {
            p = arena.arenaplayers[ i ];
            
            if ( !isdefined( p ) || !p br_public::isplayerinorgoingtogulag() )
            {
                playerentnum = 0;
            }
            else
            {
                playerentnum = p getentitynumber() + 1;
            }
            
            playerentnummax = 255;
            assert( playerentnum >= 0 && playerentnum <= playerentnummax );
            packedval += ( int( playerentnum ) & playerentnummax ) << omnvarcount;
            omnvarcount += 8;
        }
        
        self setclientomnvar( "ui_br_twotwo_gulag_players", packedval );
    }
    
    self setclientomnvar( "ui_gulag", 1 );
    self setclientomnvar( "ui_br_gulag_data", arena.omnvardata[ "ui_br_gulag_data" ] );
    self setclientomnvar( "ui_br_gulag_data_2", arena.omnvardata[ "ui_br_gulag_data_2" ] );
    self setclientomnvar( "ui_overtime_timer_show", istrue( arena.overtime ) );
}

// Namespace br_gulag
// Params 4
// Checksum 0x9d6f3a54, Offset: 0x41ee
// Size: 0x72
function _setdomflagiconinfo( name, colors, string, pulses )
{
    level.waypointcolors[ name ] = colors;
    level.waypointbgtype[ name ] = 15;
    level.waypointstring[ name ] = string;
    level.waypointshader[ name ] = "ui_mp_br_mapmenu_icon_gulag_overtime_objective";
    level.waypointpulses[ name ] = pulses;
}

// Namespace br_gulag
// Params 0
// Checksum 0x9aea3b9a, Offset: 0x4268
// Size: 0x155
function initvo()
{
    assert( isdefined( game[ "<dev string:x77>" ] ) );
    game[ "dialog" ][ "gulag_spawn" ] = "gula_wzan_spaw";
    game[ "dialog" ][ "gulag_spawn_rules" ] = "gula_wzan_spru";
    game[ "dialog" ][ "gulag_objective" ] = "bjcv_wzan_gulg";
    game[ "dialog" ][ "gulag_jailer_match_start" ] = "fght_jalr_gums";
    game[ "dialog" ][ "gulag_next" ] = "gula_wzan_next";
    game[ "dialog" ][ "gulag_win" ] = "gula_wzan_winn";
    game[ "dialog" ][ "gulag_lose" ] = "lose_wzan_gulg";
    game[ "dialog" ][ "gulag_teammate_gulag" ] = "tmmg_wzan_gulg";
    game[ "dialog" ][ "gulag_teammate_lose" ] = "tmls_wzan_gulg";
    game[ "dialog" ][ "gulag_teammate_win" ] = "tmwn_wzan_gulg";
    game[ "dialog" ][ "gulag_gulag_active" ] = "glgc_wzan_gulg";
    game[ "dialog" ][ "gulag_gulag_close" ] = "glgl_wzan_gulg";
    game[ "dialog" ][ "gulag_noenemy" ] = "noen_wzan_gulg";
    game[ "dialog" ][ "gulag_timeout" ] = "noen_wzan_gulg";
    game[ "dialog" ][ "gulag_buyback" ] = "pblc_wzan_jbgn";
    game[ "dialog" ][ "gulag_taunt" ] = "gulag_taunt";
    game[ "dialog" ][ "gulag_obj_wait" ] = "gulag_obj_wait";
}

// Namespace br_gulag
// Params 0
// Checksum 0xbaf2f63c, Offset: 0x43c5
// Size: 0x1e3
function gulaggetarenas()
{
    if ( br_public::isbrpracticemode() )
    {
        arenas = utility::getstructarray( "gulag_tutorial", "targetname" );
    }
    else
    {
        arenas = utility::getstructarray( level.var_56c3cc3dc37f1728.name == "" ? "gulag" : level.var_56c3cc3dc37f1728.targetname, "targetname" );
        var_271c02f2dad96ed7 = function_8cab7c26339d3d8d( "addArenas" );
        arenas = arraycombine( arenas, var_271c02f2dad96ed7 );
        var_d77e74df8588a283 = strtok( level.var_56c3cc3dc37f1728.var_c9c0296199422168, " " );
        var_22a1e479e8af9073 = [];
        
        for ( i = 0; i < var_d77e74df8588a283.size ; i++ )
        {
            gulagarena = arenas[ int( var_d77e74df8588a283[ i ] ) ];
            
            if ( isdefined( gulagarena ) )
            {
                var_22a1e479e8af9073[ var_22a1e479e8af9073.size ] = gulagarena;
            }
        }
        
        if ( var_22a1e479e8af9073.size > 0 )
        {
            arenas = arrayremove( arenas, var_22a1e479e8af9073 );
        }
        
        foreach ( arena in arenas )
        {
            if ( !isdefined( arena.sortvalue ) )
            {
                arena.sortvalue = randomfloat( 1 );
            }
        }
        
        arenas = function_7243d45b5d82f431( arenas, #sortvalue, 4 );
    }
    
    assert( arenas.size <= 7 );
    
    for ( i = 0; i < arenas.size ; i++ )
    {
        arena = arenas[ i ];
        arena.gulagindex = i;
        setuparena( arena );
    }
    
    return arenas;
}

// Namespace br_gulag
// Params 1
// Checksum 0xbfa38b2c, Offset: 0x45b1
// Size: 0x4fb
function setuparena( arena )
{
    arena.jailspawns = [];
    arena.fightspawns = [];
    arena.var_ab8beb4f1b7ec139 = [];
    arena.cellspawns = [];
    arena.gates = [];
    arena.floor = [];
    arena.weapons = [];
    arena.molotovs = [];
    arena.ladders = [];
    arena.jailedplayers = [];
    arena.arenaplayers = [];
    arena.matches = [];
    arena.loadingplayers = [];
    arena.fightover = 1;
    arena.forceovertime = 0;
    arena.omnvardata = [];
    arena.omnvardata[ "ui_br_gulag_players_1" ] = 0;
    arena.omnvardata[ "ui_br_gulag_data" ] = 0;
    arena.omnvardata[ "ui_br_gulag_data_2" ] = 0;
    lootstructs = [];
    targets = utility::getstructarray( arena.target, "targetname" );
    
    foreach ( target in targets )
    {
        switch ( target.script_noteworthy )
        {
            case #"hash_7795f5ce133c2aae":
                arena.jailspawns[ arena.jailspawns.size ] = target;
                break;
            case #"hash_2d60493ff70a79d2":
                if ( isdefined( level.var_23794c5a17fb2074 ) && arraycontains( level.var_23794c5a17fb2074, target ) )
                {
                    break;
                }
                
                arena.jailspawns[ arena.jailspawns.size ] = target;
                break;
            case #"hash_680cb8553134f314":
            case #"hash_89b3b99a604040e9":
                arena.fightspawns[ arena.fightspawns.size ] = target;
                break;
            case #"hash_bcf82a1e0521cfb8":
                arena.var_ab8beb4f1b7ec139[ arena.var_ab8beb4f1b7ec139.size ] = target;
                break;
            case #"hash_99c5fed5ed50013d":
                arena.cellspawns[ arena.cellspawns.size ] = target;
                break;
            case #"hash_eac77ef68b59d2f1":
                arena.center = target.origin;
                break;
            case #"hash_23b613c06cb62972":
            case #"hash_9430ae82e6671e2a":
                arena.spectatepoint = target;
                break;
            case #"hash_37cf2c9f8f6fdf6b":
                arena.var_39a6aba5bc47a4b = target;
                break;
            case #"hash_9f76add5f792d77c":
                arena.var_db8b40804defedb = target.origin;
                arena.var_31f430f8486e17d5 = target.radius;
                break;
            case #"hash_36513b0bfd48916c":
                arena.ladders[ arena.ladders.size ] = target;
                break;
            case #"hash_bc66aa0932b21762":
                lootstructs[ lootstructs.size ] = target;
                break;
        }
    }
    
    if ( !isdefined( arena.center ) )
    {
        arena.center = getgulagcenter( arena );
    }
    
    if ( getdvarint( @"hash_f76a1354fc64e33a", 1 ) > 0 )
    {
        arena.fightspawns = arraysort( arena.fightspawns, undefined, &comparescriptindexobscuredspawns );
    }
    else
    {
        arena.fightspawns = function_7243d45b5d82f431( arena.fightspawns, #script_index, 0 );
    }
    
    foreach ( cellspawn in arena.cellspawns )
    {
        setupcellspawn( arena, cellspawn );
    }
    
    arena.cellspawns = function_7243d45b5d82f431( arena.cellspawns, #script_index, 0 );
    spawnrocks( arena );
    
    if ( level.gulag.arenaflag )
    {
        setupdomendflag( arena );
    }
    
    function_c35096fb12f26591( "setupArena", arena );
}

// Namespace br_gulag
// Params 0
// Checksum 0x1958288a, Offset: 0x4ab4
// Size: 0x13b
function gulaggesturesinit()
{
    level.gulag.gestures_enabled = getdvarint( @"hash_299ae8c08206178", 0 );
    
    if ( !level.gulag.gestures_enabled )
    {
        return;
    }
    
    level.gulag.gestures = [];
    level.gulag.gestures[ "fc_gesture_neg" ] = [ "iw8_ges_plyr_gesture_crush", "iw8_ges_plyr_gesture_rally", "iw8_ges_plyr_gesture_revive" ];
    level.gulag.gestures[ "fc_gesture_pos" ] = [ "iw8_ges_plyr_gesture_doubletime", "iw8_ges_plyr_gesture_hold", "iw8_ges_plyr_gesture_ok", "iw8_ges_plyr_gesture_thumbs_up" ];
    level.gulag.gesturesounds[ "fc_gesture_neg" ] = [ "tmp_gulag_gesture_neg_crush", "tmp_gulag_gesture_neg_rally", "tmp_gulag_gesture_neg_revive" ];
    level.gulag.gesturesounds[ "fc_gesture_pos" ] = [ "tmp_gulag_gesture_pos_doubletime", "tmp_gulag_gesture_pos_hold", "tmp_gulag_gesture_pos_ok", "tmp_gulag_gesture_pos_thumbs_up" ];
}

// Namespace br_gulag
// Params 0
// Checksum 0xb12a3d37, Offset: 0x4bf7
// Size: 0x57
function getmaxplayers()
{
    maxplayers = int( clamp( getdvarint( @"scr_br_fc_max_players", 2 ), 2, 2 ) );
    
    if ( maxplayers % 2 != 0 )
    {
        maxplayers -= 1;
    }
    
    if ( namespace_a8afdcd7738e364e::function_3d1f225aa0b4d926( "gulagGetMaxPlayers" ) )
    {
        maxplayers = namespace_a8afdcd7738e364e::function_2af099d01df1a89c( "gulagGetMaxPlayers" );
    }
    
    return maxplayers;
}

// Namespace br_gulag
// Params 2
// Checksum 0x19d65d96, Offset: 0x4c57
// Size: 0x83, Type: bool
function comparescriptindexobscuredspawns( left, right )
{
    if ( left.script_index == 4 )
    {
        return true;
    }
    else if ( left.script_index == 5 )
    {
        return true;
    }
    else if ( right.script_index == 4 )
    {
        return false;
    }
    else if ( right.script_index == 5 )
    {
        return false;
    }
    
    return left.script_index < right.script_index;
}

// Namespace br_gulag
// Params 3
// Checksum 0xeec103ec, Offset: 0x4ce3
// Size: 0x6f
function copystructwithoffset( struct, offset, script_index )
{
    next = spawnstruct();
    next.origin = struct.origin + offset;
    next.angles = struct.angles;
    next.script_index = script_index;
    return next;
}

// Namespace br_gulag
// Params 1
// Checksum 0xdce84d6a, Offset: 0x4d5b
// Size: 0xdf
function getgulagcenter( arena )
{
    averagepos = ( 0, 0, 0 );
    
    if ( isdefined( arena ) && isdefined( arena.fightspawns ) && arena.fightspawns.size > 0 )
    {
        foreach ( struct in arena.fightspawns )
        {
            averagepos += struct.origin;
        }
        
        averagepos /= arena.fightspawns.size;
    }
    
    return averagepos;
}

// Namespace br_gulag
// Params 1
// Checksum 0x4fffc33d, Offset: 0x4e43
// Size: 0xb6, Type: bool
function playerismatchedplayerready( arena )
{
    if ( playerismatchpending( arena ) )
    {
        nextmatch = arena.matches[ 0 ];
        
        foreach ( player in nextmatch )
        {
            if ( player == self )
            {
                continue;
            }
            
            if ( isplayerloading( player, arena ) )
            {
                return false;
            }
        }
        
        return true;
    }
    
    return false;
}

// Namespace br_gulag
// Params 1
// Checksum 0x5d8a3168, Offset: 0x4f02
// Size: 0xa2, Type: bool
function playerismatchpending( arena )
{
    if ( ismatchpending( arena ) )
    {
        nextmatch = arena.matches[ 0 ];
        
        foreach ( player in nextmatch )
        {
            if ( player == self )
            {
                return true;
            }
        }
    }
    
    return false;
}

// Namespace br_gulag
// Params 1
// Checksum 0xbda6adf, Offset: 0x4fad
// Size: 0x65
function ismatchpending( arena )
{
    if ( arena.matches.size == 0 )
    {
        return 0;
    }
    
    nextmatch = arena.matches[ 0 ];
    
    if ( namespace_a8afdcd7738e364e::function_3d1f225aa0b4d926( "gulagIsMatchPending" ) )
    {
        return namespace_a8afdcd7738e364e::function_2af099d01df1a89c( "gulagIsMatchPending", nextmatch, arena );
    }
    else if ( nextmatch.size < 2 )
    {
        return 0;
    }
    
    return 1;
}

// Namespace br_gulag
// Params 1
// Checksum 0x51e2222d, Offset: 0x501b
// Size: 0x156, Type: bool
function isfightready( arena )
{
    if ( !ismatchpending( arena ) )
    {
        return false;
    }
    
    nextmatch = arena.matches[ 0 ];
    
    foreach ( player in nextmatch )
    {
        if ( level.gulag.var_68477f8a49b62826 )
        {
            logstring( "[GULAG DEBUG] : Player " + player.clientid + " is being checked for isFightReady step 1. Time : " + gettime() + ". Player enterGulagWait : " + istrue( player.entergulagwait ) + " Player jailed : " + istrue( player.jailed ) + " . Player waiting area timer : " + istrue( player.var_640dc06094860255 ) + " . Number of players in the queue for gulag are : " + arena.matches.size + " ." );
        }
        
        if ( player.entergulagwait || !player.jailed )
        {
            return false;
        }
        
        if ( isdefined( player.var_640dc06094860255 ) )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace br_gulag
// Params 1
// Checksum 0xba11aa66, Offset: 0x517a
// Size: 0x105
function function_4ab647b9eba0c9ff( arena )
{
    if ( !namespace_a8afdcd7738e364e::function_373b8665fd6de550() || getdvarint( @"hash_abbfd88d4515a08c", 1 ) == 0 )
    {
        return;
    }
    
    if ( arena.fightover && arena.arenaplayers.size > 0 )
    {
        arena.arenaplayers = function_5713d46873b29625( arena.arenaplayers );
        
        foreach ( player in arena.arenaplayers )
        {
            if ( !player.gulag )
            {
                arena.arenaplayers = arrayremove( arena.arenaplayers, player );
            }
        }
    }
}

// Namespace br_gulag
// Params 1
// Checksum 0xcd2cfc4a, Offset: 0x5287
// Size: 0x181
function gulagfixuparena( arena )
{
    var_e5649e832980a15d = 5000;
    
    if ( !isdefined( arena.nextfixupcheckms ) )
    {
        arena.nextfixupcheckms = gettime() + var_e5649e832980a15d;
        return;
    }
    
    if ( gettime() > arena.nextfixupcheckms )
    {
        arena.jailedplayers = function_5713d46873b29625( arena.jailedplayers );
        updatematchqueuepositions( arena );
        function_4ab647b9eba0c9ff( arena );
        
        if ( arena.gulagindex == 0 )
        {
            level.gulag.laststandplayers = function_5713d46873b29625( level.gulag.laststandplayers );
            
            foreach ( player in level.gulag.laststandplayers )
            {
                if ( !player.inlaststand )
                {
                    level.gulag.laststandplayers = arrayremove( level.gulag.laststandplayers, player );
                }
            }
        }
        
        arena.nextfixupcheckms = gettime() + var_e5649e832980a15d;
    }
}

// Namespace br_gulag
// Params 1
// Checksum 0xa989382c, Offset: 0x5410
// Size: 0x42
function function_c2ad80fb44599224( arena )
{
    arena.jailedplayers = function_5713d46873b29625( arena.jailedplayers );
    arena.arenaplayers = function_5713d46873b29625( arena.arenaplayers );
}

// Namespace br_gulag
// Params 1
// Checksum 0x5833d04a, Offset: 0x545a
// Size: 0x34c
function monitorgulag( arena )
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        gulagfixuparena( arena );
        
        if ( level.br_prematchstarted )
        {
            if ( level.gulag.shutdown )
            {
                if ( arena.loadingplayers.size != 0 )
                {
                    arena utility::waittill_notify_or_timeout( "loadingPlayersEmpty", level.gulag.var_f0e376124326d6f6 );
                }
                
                if ( level.gulag.endonshutdown == 1 )
                {
                    foreach ( player in arena.jailedplayers )
                    {
                        function_d1e9259bf9b9055( player, "br_gulag::monitorgulag", "Release player due to SHUTDOWN_TYPE_KILL. gulagIndex=" + arena.gulagindex );
                        player.gulagloser = 1;
                        player kill();
                    }
                    
                    arena.shutdown = 1;
                }
                else if ( level.gulag.endonshutdown == 2 )
                {
                    thread dojailbreak( arena );
                }
                else if ( level.gulag.endonshutdown == 3 && ( arena.shutdown || !ismatchpending( arena ) && !anyplayersinlaststandhold() ) )
                {
                    foreach ( player in arena.jailedplayers )
                    {
                        function_d1e9259bf9b9055( player, "br_gulag::monitorgulag", "Release player due to SHUTDOWN_TYPE_FINISH_UP. gulagIndex=" + arena.gulagindex );
                        
                        if ( isalive( player ) )
                        {
                            player playergulagarenaready();
                            thread gulagvictory( arena, player, 1, 0, "shutdown" );
                            function_61fa022bebce175d( player, "Shutdown", 0 );
                        }
                    }
                    
                    thread function_3d1e73c34a5e1113();
                    
                    if ( getdvarint( @"hash_7aad3ab9fa557f5a", 0 ) )
                    {
                        logstring( "[GULAG DEBUG] : gulag shutdown! Ending monitoring thread for arena index " + function_f02c63b99c9614c9( level.gulag.arenas, arena ) );
                    }
                    
                    arena.shutdown = 1;
                }
                
                if ( arena.shutdown )
                {
                    return;
                }
            }
            
            /#
                if ( getdvarint( @"hash_8c0da1f3585f4602", 0 ) > 0 )
                {
                    print3d( level.gulag.arenas[ 0 ].center, "<dev string:x7e>" );
                    waitframe();
                    continue;
                }
            #/
            
            if ( isgulagpaused() )
            {
                waitframe();
                continue;
            }
            
            if ( isfightready( arena ) )
            {
                if ( br_dom_gulag::function_bf5c033346d6e717() )
                {
                    level thread beginnewindividualfight( arena );
                }
                else
                {
                    beginnewfight( arena );
                }
            }
            else
            {
                setjailtimeouthud( arena );
            }
        }
        
        waitframe();
    }
}

// Namespace br_gulag
// Params 1
// Checksum 0x1f89bb03, Offset: 0x57ae
// Size: 0x30
function pausegulag( bpaused )
{
    if ( !level.usegulag )
    {
        return;
    }
    
    level.gulag.paused = bpaused;
}

// Namespace br_gulag
// Params 0
// Checksum 0x5a998d2e, Offset: 0x57e6
// Size: 0x22, Type: bool
function isgulagpaused()
{
    return level.usegulag && level.gulag.paused;
}

// Namespace br_gulag
// Params 0
// Checksum 0x6ee60f92, Offset: 0x5811
// Size: 0xbe, Type: bool
function areanygulagfightsactive()
{
    if ( !level.usegulag )
    {
        return false;
    }
    
    foreach ( arena in level.gulag.arenas )
    {
        if ( namespace_a8afdcd7738e364e::function_373b8665fd6de550() )
        {
            if ( arena.arenaplayers.size > 0 )
            {
                return true;
            }
            
            continue;
        }
        
        if ( !arena.fightover )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace br_gulag
// Params 0
// Checksum 0x8b7f1ee1, Offset: 0x58d8
// Size: 0x33
function jailbreakeventplayer()
{
    if ( isalive( self ) )
    {
        gulagvictory( self.arena, self, 1, 1, "jailbreakEvent", getdvarint( @"hash_417fa679fc1b2448", 1 ) );
    }
}

// Namespace br_gulag
// Params 1
// Checksum 0xe41f5c6, Offset: 0x5913
// Size: 0x57
function circletimer( circleindex )
{
    if ( level.usegulag && !level.gulag.shutdown )
    {
        gulagclosedcircleindex = getgulagclosedcircleindex();
        
        if ( circleindex >= gulagclosedcircleindex )
        {
            shutdowngulag( "circle_index", circleindex );
        }
    }
}

// Namespace br_gulag
// Params 3
// Checksum 0x55f0bf40, Offset: 0x5972
// Size: 0x278
function shutdowngulag( reason, reason_count, skipsplashes )
{
    if ( !level.usegulag || level.gulag.shutdown )
    {
        return;
    }
    
    setomnvar( "ui_gulag_state", 0 );
    setomnvar( "ui_gulag_show_closing_state", 2 );
    level.gulag.shutdown = 1;
    endonshutdown = level.gulag.endonshutdown ?? "";
    function_d1e9259bf9b9055( undefined, "br_gulag::shutdowngulag", "level.gulag.endOnShutdown=" + endonshutdown + " reason=" + ( reason ?? "" ) + " reason_count=" + ( reason_count ?? "" ) + " skipSplashes=" + ( skipsplashes ?? "" ) );
    br_analytics::function_4e78ec287f90302a();
    
    if ( isdefined( level.var_d15d8e645776c167 ) && utility::issharedfuncdefined( #"teamassim", #"permanentlydisableassim" ) )
    {
        [[ utility::getsharedfunc( #"teamassim", #"permanentlydisableassim" ) ]]();
    }
    
    thread makeac130flyaway();
    function_73eb6cab8995dec4();
    
    if ( !skipsplashes )
    {
        foreach ( player in level.players )
        {
            player function_7abd54fd7ecadd95();
            
            if ( player.inlaststand )
            {
                level.gulag.laststandplayers[ level.gulag.laststandplayers.size ] = player;
                function_d1e9259bf9b9055( player, "br_gulag::shutdowngulag", "player in laststand when gulag shutdown." );
                continue;
            }
            
            if ( !isalive( player ) || player.gulag )
            {
                continue;
            }
            
            player playergulagdonesplash();
            player function_a7357f7a8eb52832();
        }
    }
    
    codcaster_utils::function_3038b6eafc46c037( 1 );
    level notify( #"gulag_closed" );
    dlog_recordevent( "dlog_event_br_gulag_shutdown", [ "reason", reason, "reason_count", reason_count ] );
    level thread function_460f2e71da0fd96b();
}

// Namespace br_gulag
// Params 0
// Checksum 0xd364ed13, Offset: 0x5bf2
// Size: 0x38b
function function_460f2e71da0fd96b()
{
    level endon( #"game_ended" );
    
    if ( !isdefined( level.gulag.arenas ) || level.gulag.arenas.size == 0 )
    {
        return;
    }
    
    utility::flag_wait( "br_final_circle" );
    arenaorigins = [];
    
    foreach ( arena in level.gulag.arenas )
    {
        arenaorigins[ arenaorigins.size ] = arena.origin;
    }
    
    foreach ( player in level.players )
    {
        if ( !isdefined( player ) || !isalive( player ) )
        {
            continue;
        }
        
        foreach ( arenaorigin in arenaorigins )
        {
            if ( distance( player.origin, arenaorigin ) <= 1400 )
            {
                player dlog_recordplayerevent( "dlog_event_br_gulag_players_stuck", [ "player_x", player.origin[ 0 ] ?? 0, "player_y", player.origin[ 1 ] ?? 0, "player_z", player.origin[ 2 ] ?? 0, "player_team", player.team ?? "", "is_player_jailed", istrue( player.jailed ), "is_player_arena", istrue( player.gulagarena ), "is_player_enter_gulag_wait", istrue( player.entergulagwait ), "player_waiting_timer", player.var_640dc06094860255 ?? -1, "current_arena_index", player.arena.index ?? -1, "current_arena_match_size", player.arena.matchsize ?? -1, "playlist_id", getplaylistid(), "playlist_name", getplaylistname(), "circle_index", level.br_circleindex ?? -1, "map_name", level.mapname ?? "unknown" ] );
            }
        }
    }
}

// Namespace br_gulag
// Params 0
// Checksum 0xd6896159, Offset: 0x5f85
// Size: 0x25a
function function_7abd54fd7ecadd95()
{
    var_491cb736156db05d = 0;
    var_af2ca4413724fd8b = 0;
    flareconverted = 0;
    totalrefund = 0;
    
    if ( level.commonitem.respawntokenclosewithgulag && br_public::hasrespawntoken() && level.gulag.var_97519a5bc9e36000 > 0 )
    {
        var_491cb736156db05d = 1;
        totalrefund += level.gulag.var_97519a5bc9e36000 * item_redeploy_token::function_e63583d1a42b616c();
        item_redeploy_token::function_16ab0a48337237ef( 1 );
    }
    
    if ( level.commonitem.var_7dc8a97db7af6e3 && level.gulag.var_3f3865d50f194eb6 > 0 )
    {
        if ( item_gulag_token::function_322bfd131afa413e() )
        {
            item_gulag_token::function_10b12e3b4eaa98df();
            var_af2ca4413724fd8b = 1;
            totalrefund += level.gulag.var_3f3865d50f194eb6;
        }
    }
    
    if ( level.commonitem.var_7dc8a97db7af6e3 && checkgulagusecount() && level.gulag.var_3f3865d50f194eb6 > 0 )
    {
        var_af2ca4413724fd8b = 1;
        totalrefund += level.gulag.var_3f3865d50f194eb6;
    }
    
    if ( level.br_pickups.var_96b038460797c6cd && level.gulag.var_731eed23c5932ff8 > 0 )
    {
        common_inventory::function_563eb2695c39cc43( "brloot_super_reinforcement_flare" );
        totalrefund += level.gulag.var_731eed23c5932ff8;
        flareconverted = 1;
    }
    
    if ( var_491cb736156db05d && var_af2ca4413724fd8b )
    {
        lower_message::setlowermessageomnvar( "br_redeployGulag_conversion", undefined, level.gulag.var_f75f7a662856c392 );
    }
    else if ( var_491cb736156db05d )
    {
        lower_message::setlowermessageomnvar( "br_redeploy_conversion", undefined, level.gulag.var_f75f7a662856c392 );
    }
    else if ( var_af2ca4413724fd8b )
    {
        lower_message::setlowermessageomnvar( "br_gulag_conversion", undefined, level.gulag.var_f75f7a662856c392 );
    }
    
    if ( flareconverted )
    {
        lower_message::setlowermessageomnvar( "br_reinforcement_flare_conversion", undefined, level.gulag.var_f75f7a662856c392 );
    }
    
    if ( totalrefund > 0 )
    {
        currency::add_currency_amount( "cash", totalrefund );
        item_currency::function_b3dc7865b2c24da2( totalrefund );
    }
}

// Namespace br_gulag
// Params 0
// Checksum 0x6286af0d, Offset: 0x61e7
// Size: 0x104
function function_73eb6cab8995dec4()
{
    var_4a92d10dd260ff4f = getlootscriptablearray( "brloot_redeploy_token", undefined );
    var_4e19f9dc5ab3d939 = getlootscriptablearray( "brloot_gulag_token", undefined );
    
    foreach ( lootitem in var_4a92d10dd260ff4f )
    {
        common_item::function_869d7676e359a627( lootitem );
    }
    
    foreach ( lootitem in var_4e19f9dc5ab3d939 )
    {
        common_item::function_869d7676e359a627( lootitem );
    }
}

// Namespace br_gulag
// Params 0
// Checksum 0x1967dbcb, Offset: 0x62f3
// Size: 0x18, Type: bool
function anyplayersinlaststandhold()
{
    return level.gulag.laststandplayers.size > 0;
}

// Namespace br_gulag
// Params 0
// Checksum 0xa429456f, Offset: 0x6314
// Size: 0x41
function playerinlaststandhold()
{
    if ( !level.usegulag || !level.gulag.shutdown )
    {
        return 0;
    }
    
    return arraycontains( level.gulag.laststandplayers, self );
}

// Namespace br_gulag
// Params 1
// Checksum 0x7fd6480c, Offset: 0x635e
// Size: 0x9d, Type: bool
function gulaglaststandholdremove( player )
{
    if ( level.gulag.shutdown && anyplayersinlaststandhold() )
    {
        if ( isdefined( player ) && player playerinlaststandhold() )
        {
            level.gulag.laststandplayers = arrayremove( level.gulag.laststandplayers, player );
            return true;
        }
        else
        {
            level.gulag.laststandplayers = function_5713d46873b29625( level.gulag.laststandplayers );
        }
    }
    
    return false;
}

// Namespace br_gulag
// Params 1
// Checksum 0x7cbf2a31, Offset: 0x6404
// Size: 0x3f
function onplayerdisconnect( player )
{
    if ( !level.usegulag )
    {
        return;
    }
    
    gulaglaststandholdremove( player );
    
    if ( namespace_a8afdcd7738e364e::function_3d1f225aa0b4d926( "gulagOnPlayerDisconnect" ) )
    {
        player namespace_a8afdcd7738e364e::function_2af099d01df1a89c( "gulagOnPlayerDisconnect" );
    }
}

// Namespace br_gulag
// Params 1
// Checksum 0x1200ffc, Offset: 0x644b
// Size: 0x30
function playerexitlaststand( revived )
{
    if ( !level.usegulag )
    {
        return;
    }
    
    if ( revived )
    {
        if ( gulaglaststandholdremove( self ) )
        {
            playergulagdonesplash();
        }
    }
}

// Namespace br_gulag
// Params 0
// Checksum 0xaa87ab25, Offset: 0x6483
// Size: 0xb6
function getgulagclosedcircleindex()
{
    if ( !level.usegulag )
    {
        return 0;
    }
    
    if ( !( isdefined( level.br_level ) && isdefined( level.br_level.br_circledelaytimes ) ) )
    {
        return 0;
    }
    
    offset = level.br_level.br_movingcirclegulagcloseoffset ?? 0;
    
    if ( namespace_a8afdcd7738e364e::function_3d1f225aa0b4d926( "gulagGetClosedCircleIndex" ) )
    {
        return namespace_a8afdcd7738e364e::function_2af099d01df1a89c( "gulagGetClosedCircleIndex", offset );
    }
    
    return level.br_level.br_circledelaytimes.size - 1 - getdvarint( @"scr_br_fc_circle_disable", level.gulag.circledisable ) - offset;
}

// Namespace br_gulag
// Params 0
// Checksum 0xed8dc063, Offset: 0x6541
// Size: 0x3e
function setupgulagtimer()
{
    var_2687aca5dc3c5f0e = gettimetogulagclosed();
    endtimems = gettime() + var_2687aca5dc3c5f0e * 1000;
    setomnvar( "ui_gulag_timer", endtimems );
    thread showclosingmessage( var_2687aca5dc3c5f0e );
}

// Namespace br_gulag
// Params 1
// Checksum 0x28f2e3d7, Offset: 0x6587
// Size: 0x63
function showclosingmessage( var_2687aca5dc3c5f0e )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    var_14b802c91d537f6a = getdvarint( @"hash_bf9aaa13e23f04ae", 90 );
    var_f35ad8436e2d6a92 = var_2687aca5dc3c5f0e - var_14b802c91d537f6a;
    
    if ( 0 < var_f35ad8436e2d6a92 )
    {
        wait var_f35ad8436e2d6a92;
        setomnvar( "ui_gulag_show_closing_state", 1 );
    }
}

// Namespace br_gulag
// Params 0
// Checksum 0xb042c184, Offset: 0x65f2
// Size: 0xc0
function gettimetogulagclosed()
{
    time = 0;
    
    if ( isdefined( level.br_level ) && isdefined( level.br_level.br_circlecenters ) )
    {
        gulagclosedcircleindex = level.brgametype.var_98f0526861c88ad2 ?? getgulagclosedcircleindex();
        
        for ( circleindex = 0; circleindex < gulagclosedcircleindex ; circleindex++ )
        {
            timedelay = level.br_level.br_circledelaytimes[ circleindex ];
            timeclose = level.br_level.br_circleclosetimes[ circleindex ];
            time = time + timedelay + timeclose;
        }
    }
    
    return int( time );
}

// Namespace br_gulag
// Params 0
// Checksum 0xe7b3b340, Offset: 0x66bb
// Size: 0x61
function playergulagdonesplash()
{
    if ( self.gulagdone )
    {
        return;
    }
    
    self.gulagdone = 1;
    
    if ( getdvarint( @"scr_br_gulag_closed_improvement_splash", 1 ) == 1 )
    {
        thread hud_message::showsplash( "br_gulag_closed_improvement" );
    }
    else
    {
        br_killstreaks::dangernotifyplayer( self, "gulag_closed", 3 );
    }
    
    thread br_public::brleaderdialogplayer( "gulag_gulag_close", self, undefined, undefined, 2 );
}

// Namespace br_gulag
// Params 1
// Checksum 0xaa217984, Offset: 0x6724
// Size: 0x2c7
function dojailbreak( arena )
{
    if ( arena.jailedplayers.size == 0 )
    {
        arena.shutdown = 1;
        return;
    }
    
    arena.isjailbreak = 1;
    arena.arenaplayers = function_5713d46873b29625( arena.jailedplayers );
    jailbreaktimerwait( arena );
    loadoutindex = getloadoutindex();
    
    foreach ( player in arena.arenaplayers )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        function_d1e9259bf9b9055( player, "br_gulag::dojailbreak", "Release player due to SHUTDOWN_TYPE_JAILBREAK. gulagIndex=" + arena.gulagindex );
        player thread gulagplayerwatchfordeath( arena );
        player initplayerarena( arena, 1, loadoutindex, "doJailBreak" );
        
        if ( level.gulag.gestures_enabled && !isbot( player ) )
        {
            player playergulaggesturesdisable();
        }
        
        if ( getdvarint( @"hash_3ceaf2c0c66c3dc2", 0 ) > 0 && arena.arenaplayers.size > 0 )
        {
            player hudoutlinedisableforclients( arena.arenaplayers );
        }
    }
    
    playsoundatpos( arena.center, "evt_br_gulag_round_start_buzzer" );
    arena.fightover = 0;
    
    if ( !isoneteamleft( arena ) )
    {
        arena.time = level.gulag.timelimit;
        updatematchtimerhud( arena, arena.time );
        waittillgulagmatchend( arena, 0 );
    }
    else
    {
        arena.time = 8;
        updatematchtimerhud( arena, arena.time );
        wait arena.time;
    }
    
    foreach ( player in arena.arenaplayers )
    {
        if ( isdefined( player ) && isdefined( player.gulagjailbreakhud ) )
        {
            player.gulagjailbreakhud destroy();
        }
    }
    
    handleendarena( arena );
    arena.shutdown = 1;
}

// Namespace br_gulag
// Params 1
// Checksum 0x7cb6b20d, Offset: 0x69f3
// Size: 0x209
function jailbreaktimerwait( arena )
{
    foreach ( player in arena.arenaplayers )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        player thread hud_message::showsplash( "br_gulag_jail_break" );
        
        if ( getdvarint( @"hash_3ceaf2c0c66c3dc2", 0 ) > 0 )
        {
            player hudoutlineenableforclients( arena.arenaplayers, "outline_nodepth_red" );
        }
    }
    
    wait 3;
    
    foreach ( player in arena.arenaplayers )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        player playeraddjailbreaktimer();
    }
    
    gulagcountdowntimer( arena, 0 );
    
    foreach ( player in arena.arenaplayers )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        player setclientomnvar( "ui_match_start_countdown", 0 );
        player setclientomnvar( "ui_match_in_progress", 1 );
        
        if ( isdefined( player ) && isdefined( player.gulagjailbreakhud ) )
        {
            player.gulagjailbreakhud.label = &"mp/br_gulag_jailbreak";
        }
    }
}

// Namespace br_gulag
// Params 0
// Checksum 0x19035c2f, Offset: 0x6c04
// Size: 0x52
function playeraddjailbreaktimer()
{
    self.gulagjailbreakhud = hud_util::createfontstring( "default", 2 );
    self.gulagjailbreakhud hud_util::setpoint( "CENTER", "CENTER", 0, -150 );
    self.gulagjailbreakhud.label = &"mp/br_gulag_jailbreak_in";
}

// Namespace br_gulag
// Params 1
// Checksum 0xadd71dd3, Offset: 0x6c5e
// Size: 0x78
function resetequipment( arena )
{
    if ( !level.gulag.spawnloot )
    {
        return;
    }
    
    for ( i = 0; i < arena.weapons.size ; i++ )
    {
        weapon = arena.weapons[ i ];
        weapon setscriptablepartstate( weapon.part, "visible" );
    }
}

// Namespace br_gulag
// Params 1
// Checksum 0x76c04c2a, Offset: 0x6cde
// Size: 0x38
function validateplayers( arena )
{
    if ( br_ai_gulag::function_9917cd1dd03477c6() )
    {
        return ( arena.arenaplayers.size >= 1 );
    }
    
    return arena.arenaplayers.size >= 2;
}

// Namespace br_gulag
// Params 1
// Checksum 0x9d1ff621, Offset: 0x6d1e
// Size: 0xb0
function function_a4d3918e27175852( players )
{
    level endon( #"game_ended" );
    var_69ccc83b50980b8c = 0;
    
    while ( !var_69ccc83b50980b8c )
    {
        waitframe();
        var_69ccc83b50980b8c = 1;
        
        foreach ( player in players )
        {
            if ( isdefined( player ) && player isinexecutionvictim() )
            {
                var_69ccc83b50980b8c = 0;
                break;
            }
        }
    }
}

// Namespace br_gulag
// Params 1
// Checksum 0x94f18935, Offset: 0x6dd6
// Size: 0x38a
function beginnewindividualfight( arena )
{
    level endon( #"game_ended" );
    arena endon( #"hash_6c9030906c04e6a4" );
    arena.fightover = 0;
    resetequipment( arena );
    resetarenaomnvardata( arena );
    println( "<dev string:x8b>" );
    var_bf1b801d86348e74 = popnextmatch( arena );
    arena.arenaplayers = arraycombineunique( arena.arenaplayers, var_bf1b801d86348e74 );
    
    if ( level.gulag.var_68477f8a49b62826 )
    {
        logstring( "[GULAG DEBUG] : Player " + var_bf1b801d86348e74[ 0 ].clientid + " is starting new individual fight step 1. Time : " + gettime() + ". Number of players in the queue for gulag are : " + arena.matches.size + " ." );
    }
    
    loadoutindex = getloadoutindex();
    function_a4d3918e27175852( var_bf1b801d86348e74 );
    
    foreach ( p in var_bf1b801d86348e74 )
    {
        arena.jailedplayers = arrayremove( arena.jailedplayers, p );
        function_61fa022bebce175d( p, "Match Starting", 0 );
        p notify( #"beginNewFight" );
        
        if ( level.gulag.var_68477f8a49b62826 )
        {
            logstring( "[GULAG DEBUG] : Player " + p.clientid + " is starting new individual fight step 2. Time : " + gettime() + ". Number of players in the queue for gulag are : " + arena.matches.size + " ." );
        }
        
        p thread gulagplayerwatchfordeath( arena );
        p thread initplayerarena( arena, 0, loadoutindex, "beginNewIndividualFight" );
        p playergulagarenaready();
        p thread playershowarenastartobjectivetext();
        p thread br_dom_gulag::function_4c2f480385011ff4( arena );
        p thread function_7f2ae74dcc18e04f( function_92cc22b2a7acc8c9() );
        p thread individualwaittillgulagmatchend( arena, level.gulag.timelimit );
        
        if ( level.gulag.var_68477f8a49b62826 )
        {
            logstring( "[GULAG DEBUG] : Player " + p.clientid + " is starting new individual fight step 3. Time : " + gettime() + ". Number of players in the queue for gulag are : " + arena.matches.size + " ." );
        }
    }
    
    br_public::brleaderdialog( "gulag_objective", 0, var_bf1b801d86348e74 );
    _updatematchtimerhudinternal( var_bf1b801d86348e74, level.gulag.timelimit );
    
    foreach ( p in arena.jailedplayers )
    {
        if ( !isdefined( p ) )
        {
            continue;
        }
        
        p.gulagposition--;
        
        if ( level.gulag.var_68477f8a49b62826 )
        {
            logstring( "[GULAG DEBUG] : Player " + p.clientid + " completed new individual fight step 4 and is being removed from jailedPlayers. Time : " + gettime() + ". Number of players in the queue for gulag are : " + arena.matches.size + " ." );
        }
    }
}

// Namespace br_gulag
// Params 1
// Checksum 0xe9a8842e, Offset: 0x7168
// Size: 0x96b
function beginnewfight( arena )
{
    level endon( #"game_ended" );
    arena endon( #"hash_6c9030906c04e6a4" );
    arena.forceovertime = 0;
    arena.fightover = 0;
    resetequipment( arena );
    resetarenaomnvardata( arena );
    println( "<dev string:x8b>" );
    nextmatch = arena.matches[ 0 ];
    
    if ( function_15f647eb2e20af01( nextmatch, arena ) )
    {
        arena.arenaplayers = function_434571a670506102( arena );
        arena.var_a8bbf2a2aedca4c9 = arrayremove( arena.var_a8bbf2a2aedca4c9, arena.arenaplayers );
        
        if ( namespace_a8afdcd7738e364e::function_3d1f225aa0b4d926( "setGulagJailTimeoutVariation" ) )
        {
            namespace_a8afdcd7738e364e::function_2af099d01df1a89c( "setGulagJailTimeoutVariation", arena );
        }
        
        foreach ( p in arena.jailedplayers )
        {
            if ( p getclientomnvar( "ui_br_bink_overlay_state" ) == 5 )
            {
                p br_spawnrespawn::function_24b79e9319c6f02f();
            }
        }
    }
    else
    {
        arena.arenaplayers = popnextmatch( arena );
        
        if ( isdefined( arena.var_a8bbf2a2aedca4c9 ) )
        {
            foreach ( p in arena.arenaplayers )
            {
                if ( !isdefined( p ) )
                {
                    continue;
                }
                
                index = function_f02c63b99c9614c9( arena.var_a8bbf2a2aedca4c9, p );
                
                if ( isdefined( index ) )
                {
                    arena.var_a8bbf2a2aedca4c9 = arrayremove( arena.var_a8bbf2a2aedca4c9, p );
                }
            }
        }
        
        if ( namespace_a8afdcd7738e364e::function_3d1f225aa0b4d926( "unsetGulagJailTimeoutVariation" ) )
        {
            namespace_a8afdcd7738e364e::function_2af099d01df1a89c( "unsetGulagJailTimeoutVariation", arena );
        }
    }
    
    var_e72e0691781ed8aa = 0;
    
    foreach ( i, p in arena.arenaplayers )
    {
        if ( isdefined( p ) )
        {
            p.gulagposition = 0;
            arena.jailedplayers = arrayremove( arena.jailedplayers, p );
            function_61fa022bebce175d( p, "Begin Fight", 0 );
        }
        
        if ( !isdefined( p ) )
        {
            var_e72e0691781ed8aa = 1;
            continue;
        }
        
        if ( p.gulag == 0 || p.jailed == 0 || p.gulagarena == 1 )
        {
            script::demoforcesre( "Player: " + p.name + " - invalid for gulag - p.gulag = " + p.gulag + ", p.jailed = " + p.jailed + ", p.gulagArena = " + p.gulagarena );
            var_e72e0691781ed8aa = 1;
            continue;
        }
        
        println( "<dev string:xa0>" + p.name );
        p.fighterindex = i;
        p notify( #"beginNewFight" );
        
        if ( p.var_1bf57f0f71752039 )
        {
            if ( level.var_789f2cd3b152609.var_a1239fdc0f87e39 )
            {
                foreach ( enemyai in function_8e8b213809f3c0ef( "gulag" ) )
                {
                    enemyai hudoutlinedisableforclient( p );
                }
            }
            
            p.var_1bf57f0f71752039 = undefined;
            p setclientomnvar( "ui_rcd_controls", 0 );
            p cameraunlink();
        }
    }
    
    if ( namespace_a8afdcd7738e364e::function_3d1f225aa0b4d926( "setGulagVariationTeams" ) )
    {
        arena namespace_a8afdcd7738e364e::function_2af099d01df1a89c( "setGulagVariationTeams" );
    }
    
    foreach ( player in arena.jailedplayers )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        player.gulagposition--;
        
        if ( !level.gulag.gulagRockDisabled && level.gulag.var_252f2b813896be36 )
        {
            if ( !br_ai_gulag::function_43645d97a69e494f() || br_ai_gulag::function_f97a5a833d374932() )
            {
                if ( br_twotwo_gulag::function_a826a6e753a74909() )
                {
                    player equipment_mp::giveequipment( "equip_rock", "primary" );
                    player equipment_mp::setequipmentammo( "equip_rock", 5 );
                    continue;
                }
                
                player setweaponammoclip( "rock_mp", 5 );
            }
        }
    }
    
    if ( var_e72e0691781ed8aa )
    {
        function_c2ad80fb44599224( arena );
        
        if ( !validateplayers( arena ) )
        {
            if ( namespace_a8afdcd7738e364e::function_373b8665fd6de550() )
            {
                br_twotwo_gulag::function_894ca085b2cab257( arena, "br_twotwo_gulag_win", 0 );
            }
            
            handleendarena( arena, undefined, 1 );
            return;
        }
    }
    
    betinfo = startbetting( arena, arena.arenaplayers );
    
    if ( getdvarint( @"hash_30c3e9d4f1f094cf", 0 ) )
    {
        thread manageoutlines( arena, arena.arenaplayers, betinfo );
    }
    
    assert( !usecellspawns( arena ) || arena.arenaplayers.size <= 2 );
    function_c35096fb12f26591( "beginNewFight", arena );
    arena.arenaspawncounter = 0;
    loadoutindex = getloadoutindex();
    function_a4d3918e27175852( arena.arenaplayers );
    
    foreach ( player in arena.arenaplayers )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        if ( namespace_a8afdcd7738e364e::function_3d1f225aa0b4d926( "gulagWatchPlayerDeath" ) )
        {
            player thread namespace_a8afdcd7738e364e::function_2af099d01df1a89c( "gulagWatchPlayerDeath", arena );
        }
        else
        {
            player thread gulagplayerwatchfordeath( arena, betinfo );
        }
        
        player thread initplayerarena( arena, 0, loadoutindex, "beginNewFight" );
    }
    
    if ( namespace_a8afdcd7738e364e::function_373b8665fd6de550() && !level.var_56c3cc3dc37f1728.var_10cdd335a32170b6 )
    {
        arena thread function_6780024006eb9962();
    }
    
    thread watchlethaldelay( arena );
    
    if ( namespace_a8afdcd7738e364e::function_3d1f225aa0b4d926( "prepGulagArena" ) )
    {
        level thread namespace_a8afdcd7738e364e::function_2af099d01df1a89c( "prepGulagArena", arena );
    }
    
    wait 2;
    
    if ( !validateplayers( arena ) )
    {
        if ( namespace_a8afdcd7738e364e::function_373b8665fd6de550() )
        {
            br_twotwo_gulag::function_894ca085b2cab257( arena, "br_twotwo_gulag_win", 0 );
        }
        
        handleendarena( arena, betinfo, 1 );
        return;
    }
    
    updatearenaomnvarplayers( arena );
    
    if ( !namespace_a8afdcd7738e364e::function_373b8665fd6de550() )
    {
        updatearenaomnvardata( arena );
    }
    
    function_bc6aa264f5495083( "showStartSplash", arena );
    result = gulagcountdowntimer( arena, 1, betinfo );
    
    if ( !result )
    {
        return;
    }
    
    thread function_bc6aa264f5495083( "toggleLadderEscape", [ arena, 1 ] );
    endbetting( arena, betinfo );
    
    foreach ( player in arena.arenaplayers )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        player playergulagarenaready();
        player thread playershowarenastartobjectivetext();
    }
    
    if ( namespace_a8afdcd7738e364e::function_3d1f225aa0b4d926( "startGulagSequence" ) )
    {
        level thread namespace_a8afdcd7738e364e::function_2af099d01df1a89c( "startGulagSequence", arena );
    }
    
    thread startfightvo( arena );
    wait getdvarfloat( @"hash_61f7016b7e176b11", 0.8 );
    arena.time = level.gulag.timelimit;
    updatematchtimerhud( arena, arena.time );
    utility::callsharedfunc( #"bots", #"acceleratebotsgulagmatch", arena );
    gulag_accelerateheadlessmatch( arena );
    waittillgulagmatchend( arena, 1 );
    handleendarena( arena, betinfo );
    
    if ( !isfightready( arena ) )
    {
        updateplayeromnvarsallmatches( arena );
    }
}

// Namespace br_gulag
// Params 1
// Checksum 0xd276f295, Offset: 0x7adb
// Size: 0xe6
function gulag_accelerateheadlessmatch( arena )
{
    assert( arena.arenaplayers.size == 2, "<dev string:xc0>" );
    
    foreach ( player in arena.arenaplayers )
    {
        if ( !player isplayerheadless() )
        {
            return;
        }
    }
    
    if ( isdefined( arena.arenaplayers[ 0 ] ) )
    {
        function_d1e9259bf9b9055( arena.arenaplayers[ 0 ], "br_gulag::gulag_accelerateheadlessmatch", "forcibly killed to accelerate a gulag match between headless players." );
        arena.arenaplayers[ 0 ] kill();
    }
}

// Namespace br_gulag
// Params 1
// Checksum 0x45458fd0, Offset: 0x7bc9
// Size: 0x13b
function function_434571a670506102( arena )
{
    foreach ( player in arena.var_a8bbf2a2aedca4c9 )
    {
        teammate = player;
        
        foreach ( p in arena.var_a8bbf2a2aedca4c9 )
        {
            if ( player == p )
            {
                continue;
            }
            
            if ( player.team == p.team )
            {
                continue;
            }
            
            validmatch = [ teammate, p ];
            return validmatch;
        }
    }
}

// Namespace br_gulag
// Params 2
// Checksum 0x5e90e6e0, Offset: 0x7d0c
// Size: 0x75
function function_15f647eb2e20af01( nextmatch, arena )
{
    if ( level.var_56c3cc3dc37f1728.var_3ea0609623948110 && nextmatch.size < getmaxplayers() && isdefined( arena.var_a8bbf2a2aedca4c9 ) && arena.var_a8bbf2a2aedca4c9.size >= level.var_56c3cc3dc37f1728.var_517186cbf8977f33 )
    {
        return 1;
    }
    
    return 0;
}

// Namespace br_gulag
// Params 1
// Checksum 0xf01d2536, Offset: 0x7d89
// Size: 0xbd
function watchlethaldelay( arena )
{
    arena endon( #"fight_over" );
    arena endon( #"matchended" );
    level endon( #"game_ended" );
    
    if ( level.gulag.lethaldelay <= 0 )
    {
        return;
    }
    
    arena.lethaldelaystarttime = gettime();
    arena.lethaldelayendtime = arena.lethaldelaystarttime + level.gulag.lethaldelay * 1000 + function_92cc22b2a7acc8c9() * 1000 + 2000;
    
    while ( gettime() < arena.lethaldelayendtime )
    {
        waitframe();
    }
    
    arena notify( #"lethal_delay_end" );
}

// Namespace br_gulag
// Params 1
// Checksum 0x4025a59e, Offset: 0x7e4e
// Size: 0xfa
function watchlethaldelayplayer( arena )
{
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    
    if ( level.gulag.lethaldelay == 0 )
    {
        return;
    }
    
    if ( !isai( self ) )
    {
        self notifyonplayercommand( "lethal_attempt_gulag", "+frag" );
        self notifyonplayercommand( "lethal_attempt_gulag", "+smoke" );
    }
    
    val::set( "watchLethalDelayPlayer", "equipment_primary", 0 );
    val::set( "watchLethalDelayPlayer", "equipment_secondary", 0 );
    self setclientomnvar( "ui_br_gulag_lethal_delay", 1 );
    watchlethaldelayfeedbackplayer( arena, self );
    self setclientomnvar( "ui_br_gulag_lethal_delay", 0 );
    val::reset_all( "watchLethalDelayPlayer" );
    self playlocalsound( "ui_restock_lethals" );
    self setclientomnvar( "ui_recharge_notify", 2 );
    
    if ( !isai( self ) )
    {
        self notifyonplayercommandremove( "lethal_attempt_gulag", "+frag" );
        self notifyonplayercommandremove( "lethal_attempt_gulag", "+smoke" );
    }
}

// Namespace br_gulag
// Params 2
// Checksum 0xd8754c00, Offset: 0x7f50
// Size: 0xb1
function watchlethaldelayfeedbackplayer( arena, player )
{
    level endon( #"game_ended" );
    arena endon( #"matchended" );
    arena endon( #"fight_over" );
    arena endon( #"lethal_delay_end" );
    
    while ( true )
    {
        self waittill( #"lethal_attempt_gulag" );
        
        if ( isdefined( arena.lethaldelayendtime ) )
        {
            n = ( arena.lethaldelayendtime - gettime() ) / 1000;
            n = int( max( 0, ceil( n ) ) );
            player hud_message::showerrormessage( %"mp/lethals_unavailable_for_n", n );
        }
    }
}

// Namespace br_gulag
// Params 1
// Checksum 0xcccf9de5, Offset: 0x8009
// Size: 0x124
function startfightvo( arena )
{
    arena endon( #"matchended" );
    playsoundatpos( arena.center, "evt_br_gulag_round_start_buzzer" );
    wait 2;
    
    foreach ( player in arena.jailedplayers )
    {
        if ( player player::isinkillcam() && getdvarint( @"hash_927e056bbc3b9f3e", 1 ) == 1 )
        {
            continue;
        }
        
        br_public::brleaderdialogplayer( "gulag_gulag_active", player, 0 );
        
        if ( player.gulagposition <= 1 )
        {
            br_public::brleaderdialogplayer( "gulag_next", player, 0, undefined, undefined, undefined, "dx_br_jpbm_" );
            continue;
        }
        
        if ( player.gulagposition == 2 )
        {
            br_public::brleaderdialogplayer( "gulag_taunt", player, 0 );
        }
    }
    
    wait 3;
}

// Namespace br_gulag
// Params 0
// Checksum 0xe74c513d, Offset: 0x8135
// Size: 0x2a
function playershowarenastartobjectivetext()
{
    self endon( #"disconnect" );
    self setclientomnvar( "ui_objective_text", 0 );
    wait 3;
    self setclientomnvar( "ui_objective_text", -1 );
}

// Namespace br_gulag
// Params 4
// Checksum 0x98534984, Offset: 0x8167
// Size: 0x7f
function handleonekillwin( arena, victim, attacker, betinfo )
{
    if ( isplayer( attacker ) && victim != attacker && isalive( attacker ) && arraycontains( arena.arenaplayers, attacker ) )
    {
        thread gulagvictory( arena, attacker, 0, 0, "winner" );
        payoutbet( betinfo, attacker, 1 );
    }
    
    payoutbet( betinfo, victim, 0 );
}

// Namespace br_gulag
// Params 3
// Checksum 0x2fa33a81, Offset: 0x81ee
// Size: 0x4a
function manageoutlines( arena, fighters, betinfo )
{
    manageoutlineactive( arena, fighters, betinfo );
    
    if ( level.gulag.onekillwin )
    {
        return;
    }
    
    manageoutlinecleanup( arena, fighters );
}

// Namespace br_gulag
// Params 1
// Checksum 0x4ef5c70b, Offset: 0x8240
// Size: 0x38
function manageoutlineswatchplayersaddedtojail( arena )
{
    arena endon( #"fight_over" );
    
    while ( true )
    {
        arena waittill( #"hash_ba48c1041cfb8604" );
        updateoutlines( arena );
    }
}

// Namespace br_gulag
// Params 3
// Checksum 0xa3d2247, Offset: 0x8280
// Size: 0x1e9
function manageoutlineactive( arena, fighters, betinfo )
{
    arena endon( #"fight_over" );
    thread manageoutlineswatchplayersaddedtojail( arena );
    
    while ( true )
    {
        if ( arena.jailedplayers.size )
        {
            showtoplayers = function_5713d46873b29625( arena.jailedplayers );
            
            foreach ( fighter in fighters )
            {
                if ( !isdefined( fighter ) )
                {
                    continue;
                }
                
                fighter hudoutlineenableforclients( showtoplayers, "outline_nodepth_white" );
            }
        }
        
        if ( isdefined( betinfo ) )
        {
            foreach ( bet in betinfo.bets )
            {
                if ( !isdefined( bet.owner ) )
                {
                    continue;
                }
                
                var_be2b3a1b69bc89af = betinfo.bettingopen ? bet.playerfocus : bet.playerbeton;
                
                if ( var_be2b3a1b69bc89af != -1 )
                {
                    focusent = betinfo.fighters[ var_be2b3a1b69bc89af ];
                    
                    if ( isdefined( focusent ) )
                    {
                        focusent hudoutlineenableforclient( bet.owner, "outline_nodepth_green" );
                    }
                }
            }
        }
        
        arena waittill( #"update_outlines" );
    }
}

// Namespace br_gulag
// Params 2
// Checksum 0xad2bf0cb, Offset: 0x8471
// Size: 0xb1
function manageoutlinecleanup( arena, fighters )
{
    players = function_5713d46873b29625( arena.jailedplayers );
    
    if ( !players.size )
    {
        return;
    }
    
    foreach ( fighter in fighters )
    {
        if ( !isdefined( fighter ) )
        {
            continue;
        }
        
        fighter hudoutlinedisableforclients( players );
    }
}

// Namespace br_gulag
// Params 1
// Checksum 0xfbf984c8, Offset: 0x852a
// Size: 0x19
function updateoutlines( arena )
{
    arena notify( #"update_outlines" );
}

// Namespace br_gulag
// Params 0
// Checksum 0xb7fe000d, Offset: 0x854b
// Size: 0x5d
function playergulagarenaready()
{
    playerstartarenasetcontrols( 1, "playerGulagArenaReady" );
    self setclientomnvar( "ui_br_infil_started", 1 );
    self setclientomnvar( "ui_match_start_countdown", 0 );
    self setclientomnvar( "ui_match_in_progress", 1 );
    
    if ( level.gulag.gestures_enabled && !isbot( self ) )
    {
        playergulaggesturesdisable();
    }
}

// Namespace br_gulag
// Params 1
// Checksum 0xf25818bb, Offset: 0x85b0
// Size: 0x8b
function function_7f2ae74dcc18e04f( countdowntime )
{
    player = self;
    player endon( #"disconnect" );
    level endon( #"game_ended" );
    
    while ( countdowntime > 0 )
    {
        player setclientomnvar( "ui_match_in_progress", 0 );
        player setclientomnvar( "ui_match_start_countdown", countdowntime );
        countdowntime -= 1;
        wait 1;
    }
    
    player setclientomnvar( "ui_match_in_progress", 1 );
    player setclientomnvar( "ui_match_start_countdown", countdowntime );
    player setclientomnvar( "ui_br_gulag_match_state", 2 );
}

// Namespace br_gulag
// Params 3
// Checksum 0x320e217, Offset: 0x8643
// Size: 0x1e8, Type: bool
function gulagcountdowntimer( arena, var_1422a7b5caf5a506, betinfo )
{
    timer = function_92cc22b2a7acc8c9();
    
    while ( timer > 0 )
    {
        /#
            if ( getdvarint( @"hash_8c0da1f3585f4602", 0 ) > 0 )
            {
                print3d( level.gulag.arenas[ 0 ].center, "<dev string:x7e>" );
                waitframe();
                continue;
            }
        #/
        
        foreach ( player in arena.arenaplayers )
        {
            player setclientomnvar( "ui_match_in_progress", 0 );
            player setclientomnvar( "ui_match_start_countdown", timer );
            player setclientomnvar( "ui_br_gulag_match_state", 1 );
        }
        
        timer -= 1;
        wait 1;
        
        if ( var_1422a7b5caf5a506 && !validateplayers( arena ) )
        {
            if ( namespace_a8afdcd7738e364e::function_373b8665fd6de550() )
            {
                br_twotwo_gulag::function_894ca085b2cab257( arena, "br_twotwo_gulag_win", 0 );
            }
            
            handleendarena( arena, betinfo, 1 );
            return false;
        }
    }
    
    foreach ( player in arena.arenaplayers )
    {
        player setclientomnvar( "ui_br_gulag_match_state", 2 );
    }
    
    /#
        while ( getdvarint( @"hash_9d81822f2c8a6e56", 0 ) )
        {
            waitframe();
        }
    #/
    
    return true;
}

// Namespace br_gulag
// Params 1
// Checksum 0xc209f77a, Offset: 0x8834
// Size: 0x89
function function_edf3f4e351ed204a( timeleft )
{
    player = self;
    level endon( #"game_ended" );
    player endon( #"individualwaittillgulagmatchend" );
    player endon( #"gulag_end" );
    player endon( #"death_or_disconnect" );
    wait timeleft;
    timeleft = 10;
    clocksoundalias = gamelogic_mp::getclocksoundaliasfortimeleft( timeleft );
    
    while ( timeleft > 0 )
    {
        if ( !isdefined( player ) )
        {
            return;
        }
        
        player playlocalsound( clocksoundalias );
        timeleft -= 1;
        wait 1;
    }
}

// Namespace br_gulag
// Params 3
// Checksum 0x260d0752, Offset: 0x88c5
// Size: 0xb5
function gulagmatchclocksounds( arena, timeleft, overtimelength )
{
    arena endon( #"matchended" );
    
    while ( timeleft > 0 )
    {
        /#
            if ( getdvarint( @"hash_8c0da1f3585f4602", 0 ) > 0 )
            {
                waitframe();
                continue;
            }
        #/
        
        if ( level.gameended )
        {
            return;
        }
        
        timeleftclock = timeleft;
        
        if ( !arena.overtime )
        {
            timeleftclock -= overtimelength;
        }
        
        if ( timeleftclock <= 10 )
        {
            clocksoundalias = gamelogic_mp::getclocksoundaliasfortimeleft( timeleftclock );
            doclocksound( arena, clocksoundalias );
        }
        
        if ( timeleft > 1 )
        {
            timeleft -= 1;
        }
        
        wait 1;
    }
}

// Namespace br_gulag
// Params 2
// Checksum 0x85734dc0, Offset: 0x8982
// Size: 0x111
function doclocksound( arena, clocksoundalias )
{
    foreach ( player in arena.jailedplayers )
    {
        if ( isdefined( player ) )
        {
            player playlocalsound( clocksoundalias, undefined, 1 );
        }
    }
    
    foreach ( player in arena.arenaplayers )
    {
        if ( isdefined( player ) )
        {
            player playlocalsound( clocksoundalias, undefined, 1 );
        }
    }
}

// Namespace br_gulag
// Params 0
// Checksum 0xcc096ab2, Offset: 0x8a9b
// Size: 0x42
function getovertimelength()
{
    if ( namespace_a8afdcd7738e364e::function_28a656fdb9ac6cff( "gulagOvertime" ) )
    {
        return 0;
    }
    
    if ( namespace_a8afdcd7738e364e::function_3d1f225aa0b4d926( "gulagGetOvertimeLength" ) )
    {
        return namespace_a8afdcd7738e364e::function_2af099d01df1a89c( "gulagGetOvertimeLength" );
    }
    
    return getdvarfloat( @"scr_br_fc_overtime", 15 );
}

// Namespace br_gulag
// Params 0
// Checksum 0x10dd3afd, Offset: 0x8ae5
// Size: 0x2f
function function_92cc22b2a7acc8c9()
{
    if ( namespace_a8afdcd7738e364e::function_3d1f225aa0b4d926( "gulagGetCountdownLength" ) )
    {
        return namespace_a8afdcd7738e364e::function_2af099d01df1a89c( "gulagGetCountdownLength" );
    }
    
    return getdvarint( @"hash_fb05c5f6825931d", 3 );
}

// Namespace br_gulag
// Params 2
// Checksum 0x996b9b18, Offset: 0x8b1c
// Size: 0x97
function individualwaittillgulagmatchend( arena, waittime )
{
    player = self;
    player endon( #"game_ended" );
    player notify( #"individualwaittillgulagmatchend" );
    player endon( #"individualwaittillgulagmatchend" );
    player endon( #"gulag_end" );
    player endon( #"death" );
    
    if ( br_dom_gulag::function_bf5c033346d6e717() )
    {
        player utility::waittill_notify_or_timeout( "gulag_done_with_camera_sequence", 8 );
    }
    
    player thread function_edf3f4e351ed204a( waittime - 10 );
    wait waittime;
    player thread gulagplayerlost( arena );
}

// Namespace br_gulag
// Params 2
// Checksum 0xf79348d5, Offset: 0x8bbb
// Size: 0x4df
function waittillgulagmatchend( arena, dokill )
{
    overtimelength = getovertimelength();
    arena.time += overtimelength;
    thread gulagmatchclocksounds( arena, arena.time, overtimelength );
    
    while ( true )
    {
        /#
            if ( getdvarint( @"hash_8c0da1f3585f4602", 0 ) > 0 )
            {
                print3d( level.gulag.arenas[ 0 ].center, "<dev string:x7e>" );
                waitframe();
                continue;
            }
        #/
        
        if ( !isanyonealive( arena ) || isoneteamleft( arena ) )
        {
            break;
        }
        
        arena.time -= level.framedurationseconds;
        
        if ( arena.forceovertime )
        {
            arena.time = overtimelength;
            updatematchtimerhud( arena, arena.time );
        }
        
        function_c35096fb12f26591( "gulagWaittillOvertime", [ arena, overtimelength ] );
        overtimeenabled = !namespace_a8afdcd7738e364e::function_28a656fdb9ac6cff( "gulagOvertime" );
        var_d5ff8f0f082947db = namespace_a8afdcd7738e364e::function_373b8665fd6de550();
        var_7979487e1eae1b7a = var_d5ff8f0f082947db && overtimeenabled;
        var_9a42ddbb325829c7 = !arena.overtime && arena.time <= overtimelength;
        
        if ( ( var_7979487e1eae1b7a || !var_d5ff8f0f082947db ) && var_9a42ddbb325829c7 )
        {
            arena.forceovertime = 0;
            arena.overtime = 1;
            
            if ( namespace_a8afdcd7738e364e::function_3d1f225aa0b4d926( "gulagOvertimeStart" ) )
            {
                arena thread namespace_a8afdcd7738e364e::function_2af099d01df1a89c( "gulagOvertimeStart" );
            }
            
            if ( !function_bc6aa264f5495083( "overtimeStart", arena ) )
            {
                if ( !arena.var_9576da3ce98f4497 && level.gulag.arenaflag && arena.arenaplayers.size <= 2 )
                {
                    arena.dom.arenaflag arenaflag_setenabled( 1 );
                    arena.dom.arenaflag arenaflag_setvisible( arena, 1 );
                    arena.dom.arenaflag.flagmodel playsoundonmovingent( "flag_spawned" );
                }
            }
            
            foreach ( player in arena.arenaplayers )
            {
                if ( !isdefined( player ) )
                {
                    continue;
                }
                
                player setclientomnvar( "ui_br_gulag_match_state", 3 );
                player setclientomnvar( "ui_br_gulag_match_end_time", gettime() + int( arena.time * 1000 ) );
            }
        }
        
        if ( arena.overtime )
        {
            progress = clamp( arena.time / overtimelength, 0, 1 );
            setovertimeomnvarprogress( arena, progress );
        }
        
        if ( arena.time <= 0 )
        {
            if ( !function_bc6aa264f5495083( "overtimeWait", arena ) )
            {
                waittillarenaplayersnotcapturing( arena );
            }
            
            if ( dokill )
            {
                foreach ( player in arena.arenaplayers )
                {
                    if ( !isdefined( player ) )
                    {
                        continue;
                    }
                    
                    if ( namespace_a8afdcd7738e364e::function_373b8665fd6de550() && player.var_7c3c15d7e28575d )
                    {
                        continue;
                    }
                    
                    println( "<dev string:xe3>" + player.name + "<dev string:x11b>" + player getentitynumber() );
                    player setclientomnvar( "ui_br_gulag_match_state", 6 );
                    player thread gulagplayerlost( arena, undefined, 1 );
                    music_br::function_f9d258715af63e80( player );
                    player clearclienttriggeraudiozone( 2 );
                    
                    if ( isstring( "" ) && "" != "" && soundexists( "" ) )
                    {
                        player playsoundtoplayer( "", player );
                    }
                }
            }
            
            break;
        }
        
        if ( br_ai_gulag::function_43645d97a69e494f() && arena.arenaplayers.size <= 0 )
        {
            break;
        }
        
        waitframe();
    }
    
    arena notify( #"matchended" );
}

// Namespace br_gulag
// Params 1
// Checksum 0x468e2924, Offset: 0x90a2
// Size: 0x97
function waittillarenaplayersnotcapturing( arena )
{
    while ( level.gulag.arenaflag && isdefined( arena.dom.arenaflag.claimteam ) && arena.dom.arenaflag.claimteam != "none" && !arena.dom.arenaflag.stalemate )
    {
        waitframe();
    }
}

// Namespace br_gulag
// Params 1
// Checksum 0xc95e7649, Offset: 0x9141
// Size: 0x8b, Type: bool
function isanyonealive( arena )
{
    foreach ( player in arena.arenaplayers )
    {
        if ( isalive( player ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace br_gulag
// Params 1
// Checksum 0xdc6641dc, Offset: 0x91d5
// Size: 0xd8
function isoneteamleft( arena )
{
    if ( namespace_a8afdcd7738e364e::function_3d1f225aa0b4d926( "gulagIsOneTeamLeft" ) )
    {
        return namespace_a8afdcd7738e364e::function_2af099d01df1a89c( "gulagIsOneTeamLeft" );
    }
    
    teamleft = undefined;
    
    foreach ( player in arena.arenaplayers )
    {
        if ( isalive( player ) )
        {
            if ( !isdefined( teamleft ) )
            {
                teamleft = player.team;
                continue;
            }
            
            if ( teamleft != player.team )
            {
                return 0;
            }
        }
    }
    
    return 1;
}

// Namespace br_gulag
// Params 6
// Checksum 0xe511a8d1, Offset: 0x92b6
// Size: 0x266
function handleendarena( arena, betinfo, endedearly, forredeploy, analyticsevent, sponsor )
{
    arena notify( #"fight_over" );
    arena.fightover = 1;
    
    if ( !isdefined( analyticsevent ) )
    {
        analyticsevent = "winner";
    }
    
    endbetting( arena, betinfo );
    updatematchtimerhud( arena, 0 );
    winner = undefined;
    
    foreach ( player in arena.arenaplayers )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        if ( isalive( player ) )
        {
            winner = player;
            
            if ( endedearly )
            {
                winner playergulagarenaready();
            }
            
            if ( !namespace_a8afdcd7738e364e::function_373b8665fd6de550() )
            {
                if ( isdefined( sponsor ) && player.team == sponsor.team )
                {
                    thread gulagvictory( arena, player, 0, 0, analyticsevent, 0, sponsor, forredeploy );
                }
                else
                {
                    thread gulagvictory( arena, player, 0, 0, "winner" );
                }
            }
        }
        
        if ( level.gulag.var_6d372bcc606f75c6 )
        {
            val::reset( "PlayerArena", "health_regen" );
        }
    }
    
    if ( level.gulag.arenaflag )
    {
        arena.dom.arenaflag arenaflag_setenabled( 0 );
    }
    
    payoutremainingbets( winner, betinfo );
    function_c35096fb12f26591( "handleEndArena", arena );
    wait function_933c89106a2241d4();
    
    if ( !namespace_a8afdcd7738e364e::function_28a656fdb9ac6cff( "gulagOvertime" ) )
    {
        arena.overtime = 0;
        arena.forceovertime = 0;
    }
    
    if ( level.gulag.arenaflag )
    {
        arena.dom.arenaflag arenaflag_setvisible( arena, 0 );
    }
    
    cleanuparenamolotovs( arena );
    function_bc6aa264f5495083( "toggleLadderEscape", [ arena, 0 ] );
    wait function_4291ded821599a6();
}

// Namespace br_gulag
// Params 2
// Checksum 0x4c84729b, Offset: 0x9524
// Size: 0x18a
function playerpulloutofgulagwin( sponsor, analyticsevent )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    
    if ( !isdefined( self.arena ) )
    {
        return;
    }
    
    arena = self.arena;
    
    if ( self.wasingulag )
    {
        self notify( #"pull_out_of_gulag" );
        
        if ( !isalive( self ) )
        {
            thread playergulagautowin( "playerPullOutOfGulagWin", sponsor );
            return;
        }
        else if ( self.br_iseliminated )
        {
            br_utility::unmarkplayeraseliminated( self, "playerPullOutOfGulagWin" );
            level thread br::updateplayerandteamcountui();
        }
    }
    else if ( self.gulagarena )
    {
        if ( !arena.fightover )
        {
            if ( namespace_a8afdcd7738e364e::function_373b8665fd6de550() )
            {
                br_twotwo_gulag::function_894ca085b2cab257( arena, "br_twotwo_gulag_win", 0 );
            }
            
            wait 5.5;
            arena notify( #"matchended" );
            arena notify( #"hash_6c9030906c04e6a4" );
            thread handleendarena( arena, undefined, 1, 1, analyticsevent, sponsor );
        }
        
        return;
    }
    else
    {
        self endon( #"gulag_end" );
        arena.jailedplayers = arrayremove( arena.jailedplayers, self );
        function_61fa022bebce175d( self, "Pulled Out", 0 );
        updatematchqueuepositions( arena );
        
        if ( self.gulag && !self.jailed )
        {
            self waittill( #"gulag_start" );
        }
    }
    
    thread gulagvictory( arena, self, 1, 0, analyticsevent, 0, sponsor, 1 );
}

// Namespace br_gulag
// Params 1
// Checksum 0x2365964a, Offset: 0x96b6
// Size: 0x99
function getnextjailspawn( arena )
{
    if ( br_dom_gulag::function_bf5c033346d6e717() )
    {
        return arena.var_39a6aba5bc47a4b;
    }
    
    if ( isdefined( arena.jailspawncounter ) )
    {
        arena.jailspawncounter++;
        
        if ( arena.jailspawncounter == arena.jailspawns.size )
        {
            arena.jailspawncounter = 0;
        }
    }
    else
    {
        arena.jailspawncounter = 0;
    }
    
    spawnpt = arena.jailspawns[ arena.jailspawncounter ];
    return spawnpt;
}

// Namespace br_gulag
// Params 1
// Checksum 0x883db145, Offset: 0x9758
// Size: 0x255
function outlinewatchplayerprox( outlinecolorcode )
{
    self endon( #"death" );
    self endon( #"trigger" );
    self.outlinedplayers = [];
    
    switch ( outlinecolorcode )
    {
        case 0:
        default:
            outlineasset = "outline_depth_white";
            break;
        case 1:
            outlineasset = "outline_depth_green";
            break;
        case 2:
            outlineasset = "outline_depth_cyan";
            break;
        case 3:
            outlineasset = "outline_depth_red";
            break;
        case 4:
            outlineasset = "outline_depth_orange";
            break;
    }
    
    while ( true )
    {
        players = utility::playersinsphere( self.origin, 2000 );
        var_4aefa8d119cb0182 = arrayremove( level.players, players );
        
        foreach ( player in players )
        {
            dist = distancesquared( self.origin, player.origin );
            entnum = player getentitynumber();
            
            if ( !isdefined( self.outlinedplayers[ entnum ] ) )
            {
                self.outlinedplayers[ entnum ] = outline::outlineenableforplayer( self, player, outlineasset, "level_script" );
            }
        }
        
        foreach ( player in var_4aefa8d119cb0182 )
        {
            entnum = player getentitynumber();
            
            if ( isdefined( self.outlinedplayers[ entnum ] ) )
            {
                outline::outlinedisable( self.outlinedplayers[ entnum ], self );
                self.outlinedplayers[ entnum ] = undefined;
            }
        }
        
        waitframe();
    }
}

// Namespace br_gulag
// Params 0
// Checksum 0x70ae8765, Offset: 0x99b5
// Size: 0x50, Type: bool
function function_b31a927d9159eb86()
{
    if ( !level.usegulag )
    {
        return true;
    }
    
    if ( !namespace_a974e4dd85555bc2::function_12030517f4bdcb8e() && ( br_public::isplayeringulag() || br_public::function_4bbd58f4f9043df3() ) )
    {
        return false;
    }
    
    if ( self.gulag && !self.gulagloading )
    {
        return false;
    }
    
    return true;
}

// Namespace br_gulag
// Params 1
// Checksum 0x168d24f, Offset: 0x9a0e
// Size: 0x55, Type: bool
function gulagstreamlocationstart( streamorigin )
{
    if ( ( isbot( self ) || self isplayerheadless() ) && !self.longgulagstream )
    {
        return false;
    }
    
    if ( getdvarint( @"hash_723a4b3ac39bc3e2", 0 ) )
    {
        return false;
    }
    
    self setallstreamloaddist( 10000 );
    self setadditionalstreamposuntilcleared( streamorigin );
    return true;
}

// Namespace br_gulag
// Params 0
// Checksum 0x61e9d14, Offset: 0x9a6c
// Size: 0x65
function gulagstreamlocationwait()
{
    if ( !self.longgulagstream )
    {
        self endon( #"hash_846818f7ae4f16b7" );
        thread gulagstreamlocationwaittimeout( level.gulag.streamtimeout );
        
        while ( !self isadditionalstreamposready() )
        {
            waitframe();
        }
        
        self notify( #"hash_846818f7ae4f16b7" );
        return;
    }
    
    wait level.gulag.streamtimeout;
}

// Namespace br_gulag
// Params 1
// Checksum 0xd4da81ae, Offset: 0x9ad9
// Size: 0x33
function gulagstreamlocationwaittimeout( timelimit )
{
    self endon( #"disconnect" );
    self endon( #"hash_846818f7ae4f16b7" );
    wait timelimit;
    self notify( #"hash_846818f7ae4f16b7" );
}

// Namespace br_gulag
// Params 0
// Checksum 0x1e4c1fc9, Offset: 0x9b14
// Size: 0x14
function gulagstreamlocationend()
{
    self clearadditionalstreampos();
    self notify( #"hash_846818f7ae4f16b7" );
}

// Namespace br_gulag
// Params 2
// Checksum 0xf2b75fbd, Offset: 0x9b30
// Size: 0x48
function addloadingplayer( arena, player )
{
    player.entergulagwait = 1;
    arena.loadingplayers[ arena.loadingplayers.size ] = player;
    thread addloadingplayerdisconnectwatch( arena, player );
}

// Namespace br_gulag
// Params 2
// Checksum 0x4cd8b8be, Offset: 0x9b80
// Size: 0x3a
function addloadingplayerdisconnectwatch( arena, player )
{
    player endon( #"hash_e446745f659fde7e" );
    player waittill( #"disconnect" );
    thread removeloadingplayer( arena, player );
}

// Namespace br_gulag
// Params 2
// Checksum 0xfc77c22a, Offset: 0x9bc2
// Size: 0x81
function removeloadingplayer( arena, player )
{
    player notify( #"hash_e446745f659fde7e" );
    
    if ( isdefined( player ) )
    {
        arena.loadingplayers = arrayremove( arena.loadingplayers, player );
    }
    else
    {
        arena.loadingplayers = function_5713d46873b29625( arena.loadingplayers );
    }
    
    if ( arena.loadingplayers.size == 0 )
    {
        arena notify( #"loadingPlayersEmpty" );
    }
}

// Namespace br_gulag
// Params 2
// Checksum 0xcdf2c0fd, Offset: 0x9c4b
// Size: 0x26
function isplayerloading( player, arena )
{
    return arraycontains( arena.loadingplayers, player );
}

// Namespace br_gulag
// Params 1
// Checksum 0x236bfb44, Offset: 0x9c7a
// Size: 0x2f
function entergulag( player )
{
    player notify( #"enter_gulag" );
    player.entergulagwait = 0;
    deathicons::hidedeathicon( player );
}

// Namespace br_gulag
// Params 1
// Checksum 0x3ad15545, Offset: 0x9cb1
// Size: 0x28
function entergulagwait( player )
{
    if ( player.entergulagwait )
    {
        player waittill( #"enter_gulag" );
    }
}

// Namespace br_gulag
// Params 1
// Checksum 0x55966e92, Offset: 0x9ce1
// Size: 0x4ae
function playergetnextarena( overridearenas )
{
    arenas = overridearenas ?? level.gulag.arenas;
    var_43ee6a728032df30 = getdvarint( @"hash_8bdee07fa09e810a", -1 );
    
    if ( var_43ee6a728032df30 > -1 )
    {
        return level.gulag.arenas[ var_43ee6a728032df30 ];
    }
    
    if ( !level.gulag.multiarena )
    {
        return function_164f7b989c5be26b( overridearenas );
    }
    
    if ( isdefined( self.var_43ee6a728032df30 ) )
    {
        arena = level.gulag.arenas[ self.var_43ee6a728032df30 ];
        
        if ( isdefined( arena ) )
        {
            self.var_43ee6a728032df30 = undefined;
            return arena;
        }
    }
    
    bestarena = undefined;
    besttime = undefined;
    
    foreach ( arena in arenas )
    {
        if ( !isarenaenabled( arena, self ) )
        {
            continue;
        }
        
        foreach ( match in arena.matches )
        {
            if ( match.size == 1 && isdefined( match[ 0 ] ) && match[ 0 ].team != self.team && ( !isdefined( bestarena ) || match[ 0 ].jailtime < besttime ) )
            {
                bestarena = arena;
                besttime = match[ 0 ].jailtime;
            }
        }
    }
    
    var_7237854e3be197ca = bestarena;
    
    if ( isdefined( var_7237854e3be197ca ) )
    {
        return var_7237854e3be197ca;
    }
    
    var_f61fe25352466f3 = [];
    
    for ( i = 0; i < arenas.size ; i++ )
    {
        arena = level.gulag.arenas[ i ];
        
        if ( !isarenaenabled( arena, self ) )
        {
            continue;
        }
        
        if ( arena.matches.size > 0 && arena.matches.size < level.gulag.var_57fe56d04634639a )
        {
            var_f61fe25352466f3[ var_f61fe25352466f3.size ] = arena;
        }
    }
    
    if ( var_f61fe25352466f3.size > 0 )
    {
        foreach ( arena in var_f61fe25352466f3 )
        {
            foreach ( match in arena.matches )
            {
                foreach ( player in match )
                {
                    if ( isdefined( player ) && player.team == self.team )
                    {
                        return arena;
                    }
                }
            }
        }
        
        arena = var_f61fe25352466f3[ randomint( var_f61fe25352466f3.size ) ];
        return arena;
    }
    
    bestarena = undefined;
    bestqueue = undefined;
    
    for ( i = 0; i < arenas.size ; i++ )
    {
        arena = level.gulag.arenas[ i ];
        
        if ( !isarenaenabled( arena, self ) )
        {
            continue;
        }
        
        if ( arena.matches.size == 0 )
        {
            return arena;
        }
        
        if ( !isdefined( bestqueue ) || arena.matches.size < bestqueue )
        {
            bestarena = arena;
            bestqueue = arena.matches.size;
        }
    }
    
    return bestarena;
}

// Namespace br_gulag
// Params 2
// Checksum 0x3210e3e6, Offset: 0xa198
// Size: 0x2d
function isarenaenabled( arena, player )
{
    return function_fcc683fdbcf6af70( "isArenaEnabled", [ arena, player ] );
}

// Namespace br_gulag
// Params 1
// Checksum 0x97f05c24, Offset: 0xa1ce
// Size: 0x77
function function_164f7b989c5be26b( overridearenas )
{
    arenas = overridearenas ?? level.gulag.arenas;
    
    for ( i = 0; i < arenas.size ; i++ )
    {
        arena = arenas[ i ];
        
        if ( !isarenaenabled( arena, self ) )
        {
            continue;
        }
        
        return arena;
    }
    
    assertmsg( "<dev string:x127>" );
}

// Namespace br_gulag
// Params 1
// Checksum 0x1ab7e1a9, Offset: 0xa24e
// Size: 0x84
function function_70336e6d7f6b43c( overridearenas )
{
    arenas = overridearenas ?? level.gulag.arenas;
    
    for ( i = 0; i < arenas.size ; i++ )
    {
        arena = arenas[ i ];
        
        if ( !isarenaenabled( arena, self ) )
        {
            continue;
        }
        
        if ( !arena.fightover )
        {
            continue;
        }
        
        return arena;
    }
    
    return function_164f7b989c5be26b( overridearenas );
}

// Namespace br_gulag
// Params 1
// Checksum 0xf9013f70, Offset: 0xa2db
// Size: 0xaa
function function_eb595854335a8ead( match )
{
    player = self;
    allycounter = 0;
    
    foreach ( participant in match )
    {
        if ( participant.team == player.team )
        {
            allycounter++;
        }
    }
    
    return allycounter;
}

// Namespace br_gulag
// Params 2
// Checksum 0x9dde48f3, Offset: 0xa38e
// Size: 0xf4, Type: bool
function isplayermatched( arena, player )
{
    if ( player.gulagposition == 0 )
    {
        return true;
    }
    
    if ( !ismatchpending( arena ) )
    {
        if ( level.gulag.var_68477f8a49b62826 )
        {
            logstring( "[GULAG DEBUG] : Player " + player.clientid + " did not have a match pending. Time : " + gettime() + ". Number of players in the queue for gulag are : " + arena.matches.size + " ." );
        }
        
        return false;
    }
    
    matchindex = player.gulagposition - 1;
    var_352e10b3311b7adf = level.gulag.matchsize - 1;
    
    if ( matchindex >= 0 && isdefined( arena.matches[ matchindex ] ) && arena.matches[ matchindex ].size > var_352e10b3311b7adf )
    {
        return true;
    }
    
    return false;
}

// Namespace br_gulag
// Params 1
// Checksum 0x70cd9117, Offset: 0xa48b
// Size: 0xd1
function setjailtimeouthud( arena )
{
    foreach ( player in arena.jailedplayers )
    {
        if ( !isplayermatched( arena, player ) && isdefined( player.jailtimeoutend ) && !isdefined( player.jailtimeouthud ) )
        {
            player setclientomnvar( "ui_br_gulag_match_end_time", player.jailtimeoutend );
            player.jailtimeouthud = 1;
        }
    }
}

// Namespace br_gulag
// Params 1
// Checksum 0xddb322c6, Offset: 0xa564
// Size: 0x2c
function playerclearjailtimeouthud( arena )
{
    self.jailtimeoutend = undefined;
    self.jailtimeouthud = undefined;
    self setclientomnvar( "ui_br_gulag_match_end_time", 0 );
}

// Namespace br_gulag
// Params 1
// Checksum 0x8b83f35b, Offset: 0xa598
// Size: 0x24d
function playerjailtimeout( arena )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    self endon( #"hash_62527c7fe087add5" );
    self endon( #"gulag_end" );
    
    if ( namespace_a8afdcd7738e364e::function_3d1f225aa0b4d926( "gulagJailTimeout" ) )
    {
        delaytime = namespace_a8afdcd7738e364e::function_2af099d01df1a89c( "gulagJailTimeout" );
    }
    else
    {
        delaytime = getdvarint( @"hash_e5f703a38f6e8043", 95 );
    }
    
    if ( namespace_a8afdcd7738e364e::function_3d1f225aa0b4d926( "gulagLeftoverJailTimeout" ) )
    {
        leftovertime = namespace_a8afdcd7738e364e::function_2af099d01df1a89c( "gulagLeftoverJailTimeout" );
    }
    else
    {
        leftovertime = 0;
    }
    
    if ( delaytime <= 0 )
    {
        return;
    }
    
    timertime = delaytime + leftovertime;
    
    if ( isdefined( level.br_circle.circleindex ) )
    {
        timerscalar = level.gulag.var_d4b7a6e283d75b94[ level.br_circle.circleindex ] ?? level.gulag.var_d4b7a6e283d75b94[ 0 ];
        timertime *= timerscalar;
        leftovertime *= timerscalar;
        delaytime *= timerscalar;
    }
    
    self.jailtimeoutend = int( gettime() + timertime * 1000 );
    wait delaytime;
    
    if ( namespace_a8afdcd7738e364e::function_3d1f225aa0b4d926( "onGulagJailTimeout" ) )
    {
        thread namespace_a8afdcd7738e364e::function_2af099d01df1a89c( "onGulagJailTimeout", arena, self );
    }
    
    wait leftovertime;
    
    if ( isplayermatched( arena, self ) )
    {
        matchtimetowait = self.gulagposition * ( level.gulag.timelimit + getovertimelength() + function_92cc22b2a7acc8c9() + 2 + function_933c89106a2241d4() + function_4291ded821599a6() + 1 );
        timeout = gettime() + matchtimetowait * 1000;
        
        while ( timeout > gettime() && isplayermatched( arena, self ) )
        {
            waitframe();
        }
    }
    
    while ( isgulagpaused() )
    {
        waitframe();
    }
    
    while ( self isinexecutionvictim() )
    {
        waitframe();
    }
    
    analyticsevent = "timeout";
    
    if ( namespace_a8afdcd7738e364e::function_373b8665fd6de550() )
    {
        analyticsevent = "br_twotwo_gulag_win_jail_timeout";
    }
    
    if ( level.gulag.giveloadoutontimeout )
    {
        playergivearenaloadout( arena, 0 );
    }
    
    thread gulagvictory( arena, self, 1, 0, analyticsevent );
}

// Namespace br_gulag
// Params 0
// Checksum 0xad1d3330, Offset: 0xa7ed
// Size: 0x46
function function_a7357f7a8eb52832()
{
    player = self;
    
    if ( !isdefined( player.gulaguses ) )
    {
        player.gulaguses = 0;
    }
    
    canusegulag = player function_f3e1e2a67d51fba8();
    player br_public::function_99e432af35c80c99( canusegulag );
}

// Namespace br_gulag
// Params 2
// Checksum 0xcc962396, Offset: 0xa83b
// Size: 0xbef
function initplayerjail( waitforentergulag, skipcinematic )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    self endon( #"gulag_end" );
    self endon( #"jailbreak_respawn" );
    currenttime = gettime();
    self.jailtime = currenttime;
    self.gulagloser = undefined;
    
    if ( br_ai_gulag::function_43645d97a69e494f() )
    {
        self.var_640dc06094860255 = currenttime;
    }
    
    br_analytics::branalytics_gulagstart( self, waitforentergulag ? "default" : "debug" );
    
    if ( level.gulag.var_68477f8a49b62826 )
    {
        logstring( "[GULAG DEBUG] : Player " + self.clientid + " passes jail entrance step 01. Time : " + gettime() + " ." );
    }
    
    if ( !skipcinematic && level.gulag.preloadcinematic )
    {
        playerpreloadintrocinematic();
    }
    else
    {
        br_spawnrespawn::function_1d2f70d591e967bc();
    }
    
    var_2c28015ccfad992d = undefined;
    forceoverride = undefined;
    overridearenas = function_bc6aa264f5495083( "overrideArenas" );
    
    if ( isdefined( overridearenas ) )
    {
        var_2c28015ccfad992d = overridearenas[ 0 ];
        forceoverride = overridearenas[ 1 ];
    }
    
    if ( namespace_a8afdcd7738e364e::function_373b8665fd6de550() )
    {
        arena = namespace_a974e4dd85555bc2::gulag_playergetnextarena( var_2c28015ccfad992d, forceoverride );
    }
    else
    {
        arena = playergetnextarena( overridearenas );
    }
    
    self.arena = arena;
    
    if ( isdefined( arena.gulagindex ) )
    {
        var_faf5403ac8f37737 = arena.gulagindex + 1;
        codcasterclientmatchdata::function_ee35d29284860183( 23, var_faf5403ac8f37737 );
    }
    
    if ( !arraycontains( arena.jailedplayers, self ) )
    {
        arena notify( #"hash_ba48c1041cfb8604", self );
        arena.jailedplayers[ arena.jailedplayers.size ] = self;
        function_61fa022bebce175d( self, "Init Jail", 1 );
        function_d1e9259bf9b9055( self, "br_gulag::initplayerjail", "Entered 2F. gulagIndex=" + arena.gulagindex + " waitForEnterGulag=" + ( waitforentergulag ?? "" ) + " skipCinematic=" + ( skipcinematic ?? "" ) );
    }
    
    if ( br_large_gulag::function_983d14712c4c519f() && arena.arenaplayers.size > 0 )
    {
        foreach ( p in arena.arenaplayers )
        {
            namespace_a974e4dd85555bc2::function_59a96018edc0b5f3( p );
        }
    }
    
    playergulaghud( arena );
    thread playerwatchdisconnect( arena );
    updatematchqueuepositions( arena );
    
    if ( level.gulag.var_68477f8a49b62826 )
    {
        logstring( "[GULAG DEBUG] : Player " + self.clientid + " enters jail entrance step 02. Time : " + gettime() + ". Player in next gulag position : " + arena.matches[ 0 ][ 0 ].clientid + " . Number of players in the queue for gulag are : " + arena.matches.size + " ." );
    }
    
    addloadingplayer( arena, self );
    gulaglaststandholdremove( self );
    
    if ( !isdefined( self.gulaguses ) )
    {
        self.gulaguses = 0;
    }
    
    self.gulaguses++;
    function_a7357f7a8eb52832();
    
    if ( br_twotwo_gulag::function_a826a6e753a74909() )
    {
        if ( namespace_a974e4dd85555bc2::function_64591ecc14010927( arena ) && level.var_56c3cc3dc37f1728.patroltier < 4 )
        {
            var_6afdf41affc369e9 = "gulagspectators" + arena.gulagindex;
            
            if ( !threatbiasgroupexists( var_6afdf41affc369e9 ) )
            {
                createthreatbiasgroup( var_6afdf41affc369e9 );
            }
            
            self setthreatbiasgroup( var_6afdf41affc369e9 );
        }
        
        br_twotwo_gulag::function_7939ee650777e992( arena );
        br_twotwo_gulag::function_1724513d4cc94f24( arena );
    }
    
    setplayervargulag( 1 );
    setplayervargulagarena( 0 );
    setplayeringulagjailextrainfo( 1 );
    setplayergulagindex( arena );
    
    if ( isdefined( level.checkforlaststandwipe ) )
    {
        [[ level.checkforlaststandwipe ]]( self );
    }
    
    spawnpt = getnextjailspawn( arena );
    spawnorigin = getgroundposition( spawnpt.origin, 12 );
    spawnangles = ( 0, 0, 0 );
    
    if ( isdefined( spawnpt.angles ) )
    {
        spawnangles = spawnpt.angles;
    }
    
    waitforstream = gulagstreamlocationstart( spawnorigin );
    self.gulagloading = 1;
    self.streampoint = spawnstruct();
    self.streampoint.origin = spawnorigin;
    self.streampoint.angles = spawnangles;
    
    if ( waitforentergulag )
    {
        entergulagwait( self );
    }
    else
    {
        entergulag( self );
    }
    
    if ( level.gulag.var_68477f8a49b62826 )
    {
        logstring( "[GULAG DEBUG] : Player " + self.clientid + " enters jail entrance step 03. Time : " + gettime() + ". Player passed enterGulagWait. Number of players in the queue for gulag are : " + arena.matches.size + " ." );
    }
    
    outofbounds::enableoobimmunity( self );
    br_contract_manager::onplayerentergulag();
    br_supply_drops_common::function_7839510c13750e83();
    level callback::callback( #"hash_c15c682d6a5dcae0", { #player:self } );
    self.ignoreafkcheck = 1;
    
    if ( br_public::isbrpracticemode() )
    {
        self notify( #"hash_41e096b73fce25ee" );
    }
    
    if ( !skipcinematic )
    {
        playerplayintrocinematic();
    }
    
    spectators = br_spectate::function_ff10813f2a7bd19c();
    
    if ( spectators.size > 0 )
    {
        foreach ( client in spectators )
        {
            client thread br_spectate::function_a4859c8e69b83edf( 5, "gulagSceneFin" );
        }
    }
    
    if ( waitforstream )
    {
        br::spawnintermission( spawnorigin + ( 0, 0, 100 ), self.angles );
        spectating::setdisabled();
        gulagstreamlocationstart( spawnorigin );
        gulagstreamlocationwait();
    }
    
    utility::callsharedfunc( #"gametype", #"hash_efbc8d88b844bbcc" );
    
    /#
        while ( getdvarint( @"scr_br_hold_in_gulag", 0 ) == 2 )
        {
            self.gulagholding = 1;
            waitframe();
        }
    #/
    
    if ( level.gulag.var_68477f8a49b62826 )
    {
        logstring( "[GULAG DEBUG] : Player " + self.clientid + " enters jail entrance step 04. Time : " + gettime() + ". Player passed gulag stream location. Number of players in the queue for gulag are : " + arena.matches.size + " ." );
    }
    
    class::loadout_emptycacheofloadout( "gamemode" );
    self.pers[ "gamemodeLoadout" ] = level.gulag.jailloadout;
    self.class = "gamemode";
    self.forcespawnangles = spawnangles;
    self.forcespawnorigin = spawnorigin;
    self.reviver = undefined;
    self.var_1be091ba55db848e = "gulag_spawning";
    playerlogic::spawnplayer( undefined, 0 );
    execution::_clearexecution();
    self setclientomnvar( "ui_gulag", 1 );
    self.streampoint = undefined;
    self.gulagloading = 0;
    self allowwalljump( 0 );
    
    if ( namespace_a8afdcd7738e364e::function_3d1f225aa0b4d926( "gulagJailRockAmount" ) )
    {
        namespace_a8afdcd7738e364e::function_2af099d01df1a89c( "gulagJailRockAmount" );
    }
    
    armor::givestartingarmor( 0, 0 );
    br_spawnrespawn::resetplayermovespeedscale();
    
    if ( br_ai_gulag::function_43645d97a69e494f() )
    {
        self.gulagplayerstate = 0;
        br_ai_gulag::function_c92eb1ca0d9165d();
    }
    
    if ( waitforstream )
    {
        gulagstreamlocationend();
    }
    
    if ( spectators.size > 0 )
    {
        foreach ( client in spectators )
        {
            client notify( #"gulagSceneFin" );
        }
    }
    
    if ( !skipcinematic )
    {
        playershowskippromptcinematic();
        playerwaittillcinematiccomplete( currenttime );
    }
    
    self setplayerangles( ( 0, self.angles[ 1 ], 0 ) );
    
    /#
        while ( getdvarint( @"scr_br_hold_in_gulag", 0 ) == 1 )
        {
            waitframe();
        }
    #/
    
    self setclientomnvar( "ui_br_infil_started", 1 );
    var_affe8d1e12da4ea2 = arena.fightover && playerismatchedplayerready( arena ) && !isgulagpaused();
    
    if ( !var_affe8d1e12da4ea2 )
    {
        br_spawnrespawn::function_24b79e9319c6f02f();
    }
    
    if ( namespace_a8afdcd7738e364e::function_3d1f225aa0b4d926( "gulag_startWaitingStartTime" ) )
    {
        namespace_a8afdcd7738e364e::function_2af099d01df1a89c( "gulag_startWaitingStartTime" );
    }
    
    gulagloadingtextclear();
    function_c35096fb12f26591( "jailEnter", arena );
    
    if ( level.gulag.betting )
    {
        gulagplunder = 3;
        
        if ( isdefined( self.plundercountondeath ) )
        {
            gulagplunder = int( max( gulagplunder, int( self.plundercountondeath / 2 ) ) );
        }
        
        br_plunder::playersetplundercount( gulagplunder );
    }
    
    if ( !var_affe8d1e12da4ea2 && !skipcinematic )
    {
        br_public::brleaderdialogplayer( "gulag_spawn", self, 0, undefined, undefined, undefined, "dx_br_jpbm_" );
    }
    
    teamplayers = teams::function_d032b36d01bbbab3( self.team, self.sessionsquadid, 1 );
    
    if ( isdefined( teamplayers ) && teamplayers.size > 0 )
    {
        foreach ( teammate in teamplayers )
        {
            if ( !isdefined( teammate ) )
            {
                continue;
            }
            
            if ( teammate != self )
            {
                teammate thread hud_message::showsplash( "br_gulag_teammate_in", undefined, self );
                br_public::brleaderdialogplayer( "gulag_teammate_gulag", teammate, undefined, undefined, 2 );
            }
        }
    }
    
    if ( !self.jailed )
    {
        println( "<dev string:x139>" + self.name + "<dev string:x15a>" + self.class );
        setplayervargulagjail( 1 );
        perk::blockperkfunction( "specialty_scavenger" );
    }
    
    removeloadingplayer( arena, self );
    br_weapons::br_ammo_player_clear();
    br::resetplayerinventory( !isbot( self ) );
    
    if ( level.gulag.gestures_enabled && !isbot( self ) )
    {
        thread playergulaggestures();
    }
    
    playerstartjailsetcontrols( 0 );
    
    if ( arena.overtime && level.gulag.arenaflag )
    {
        arena.dom.arenaflag thread arenaflag_setvisibleplayer( 1, self );
    }
    
    thread playerjailtimeout( arena );
    thread playerjailwaitvo( arena );
    function_28b55336e9c7a4f2();
    self notify( #"gulag_start", var_affe8d1e12da4ea2 );
    
    if ( level.gulag.var_12d1f7b5512cf6b3 )
    {
        self.pers[ "distTrackingPassedOrResetTime" ] = mp_afk::function_a10af3f5e26c28da();
    }
    
    if ( level.gulag.var_68477f8a49b62826 )
    {
        logstring( "[GULAG DEBUG] : Player " + self.clientid + " enters jail entrance step 05. Time : " + gettime() + ". Player is fully in the gulag jail. Number of players in the queue for gulag are : " + arena.matches.size + " ." );
    }
}

// Namespace br_gulag
// Params 1
// Checksum 0x3a6affe, Offset: 0xb432
// Size: 0x59
function playerjailwaitvo( arena )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    self endon( #"hash_62527c7fe087add5" );
    self endon( #"gulag_end" );
    wait 5;
    
    if ( ismatchpending( arena ) )
    {
        return;
    }
    
    br_public::brleaderdialogplayer( "gulag_obj_wait", self, 0 );
}

// Namespace br_gulag
// Params 1
// Checksum 0xe9e7c671, Offset: 0xb493
// Size: 0x20
function playerstartjailsetcontrols( enable )
{
    if ( enable )
    {
        self enableoffhandthrowback();
        return;
    }
    
    self disableoffhandthrowback();
}

// Namespace br_gulag
// Params 0
// Checksum 0x35637704, Offset: 0xb4bb
// Size: 0x1da
function playergulaggestures()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    self endon( #"disconnect" );
    self endon( #"hash_c13c5e8f53d1192d" );
    self enableoffhandweapons();
    self allowfire( 0 );
    self allowads( 0 );
    self notifyonplayercommand( "fc_gesture_neg", "+attack" );
    self notifyonplayercommand( "fc_gesture_pos", "+speed_throw" );
    gestureindex = 0;
    
    while ( true )
    {
        gesture_type = utility::waittill_any_return( "fc_gesture_neg", "fc_gesture_pos" );
        
        if ( self isgestureplaying() || self isswitchingweapon() || self isreloading() || self ismantling() || self isthrowinggrenade() || self israisingweapon() || self ismeleeing() )
        {
            continue;
        }
        
        if ( getdvarint( @"hash_f66218d4c610a345", 0 ) > 0 )
        {
            if ( gestureindex >= level.gulag.gestures[ gesture_type ].size )
            {
                gestureindex = 0;
            }
            
            gesturesoundalias = level.gulag.gesturesounds[ gesture_type ][ gestureindex ];
            gestureweaponname = level.gulag.gestures[ gesture_type ][ gestureindex ];
            gestureindex++;
        }
        else
        {
            gestureindex = randomint( level.gulag.gestures[ gesture_type ].size );
            gesturesoundalias = level.gulag.gesturesounds[ gesture_type ][ gestureindex ];
            gestureweaponname = level.gulag.gestures[ gesture_type ][ gestureindex ];
        }
        
        if ( gesturesoundalias )
        {
            self playsound( gesturesoundalias );
        }
        
        gestureweapon = makeweapon( gestureweaponname );
        
        if ( isdefined( gestureweapon ) && !isnullweapon( gestureweapon ) )
        {
            gestures::watchradialgesture( gestureweapon );
        }
    }
}

// Namespace br_gulag
// Params 0
// Checksum 0x95a0bd26, Offset: 0xb69d
// Size: 0x3e
function playergulaggesturesdisable()
{
    self notify( #"hash_c13c5e8f53d1192d" );
    self notifyonplayercommandremove( "fc_gesture_neg", "+attack" );
    self notifyonplayercommandremove( "fc_gesture_pos", "+speed_throw" );
    self allowfire( 1 );
    self allowads( 1 );
}

// Namespace br_gulag
// Params 0
// Checksum 0x403e27cb, Offset: 0xb6e3
// Size: 0x54
function gulagloadingtext()
{
    text = hud_util::createfontstring( "default", 1.5 );
    text hud_util::setpoint( "CENTER", "CENTER", 0, -100 );
    text.label = &"mp/br_gulag_travel";
    self.gulagloadingtext = text;
}

// Namespace br_gulag
// Params 0
// Checksum 0xc941bf04, Offset: 0xb73f
// Size: 0x1d
function gulagloadingtextclear()
{
    if ( isdefined( self.gulagloadingtext ) )
    {
        self.gulagloadingtext destroy();
    }
}

// Namespace br_gulag
// Params 4
// Checksum 0x864d868, Offset: 0xb764
// Size: 0x7f5
function initplayerarena( arena, skipspawn, loadoutindex, debugreason )
{
    if ( level.gulag.var_68477f8a49b62826 )
    {
        logstring( "[GULAG DEBUG] : Player " + self.clientid + " passed arena entrance step 00.5. Time : " + gettime() + ". Screen fade to black. Number of players in the queue for gulag are : " + arena.matches.size + " ." );
    }
    
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    self notify( #"hash_62527c7fe087add5" );
    
    if ( player::isinlaststand( self ) )
    {
        laststand::exit( "last_stand_self_revive" );
    }
    
    assert( self.sessionstate != "<dev string:x163>" );
    println( "<dev string:x16d>" + self.name );
    function_d1e9259bf9b9055( self, "br_gulag::initplayerarena", "Entered 1F. gulagIndex=" + arena.gulagindex + " skipSpawn=" + ( skipspawn ?? "" ) + " loadoutIndex=" + ( loadoutindex ?? "" ) + " debugReason=" + ( debugreason ?? "" ) );
    br_weapons::br_ammo_player_clear();
    br::resetplayerinventory();
    
    if ( br_ai_gulag::function_43645d97a69e494f() )
    {
        self.gulagplayerstate = 1;
        br_ai_gulag::function_c92eb1ca0d9165d();
    }
    
    self setvelocity( ( 0, 0, 0 ) );
    self allowprone( 0 );
    self allowcrouch( 0 );
    playerstartjailsetcontrols( 1 );
    playerstartarenasetcontrols( 0, "initPlayerArena_" + ( debugreason ?? "" ) );
    playerclearjailtimeouthud( arena );
    val::set( "PlayerArena", "equipment_primary", 0 );
    val::set( "PlayerArena", "equipment_secondary", 0 );
    self allowwalljump( 0 );
    thread playerhealthomnvarwatcher( arena );
    
    if ( skipspawn )
    {
        playertakeawayrock( arena );
        setplayervargulagjail( 0 );
        setplayervargulagarena( 1 );
        playergivearenaloadout( arena, loadoutindex );
        
        if ( level.gulag.lethaldelay > 0 )
        {
            thread watchlethaldelayplayer( arena );
        }
        
        return;
    }
    
    if ( !namespace_a8afdcd7738e364e::function_373b8665fd6de550() || !level.var_56c3cc3dc37f1728.var_d9ea32e83b0db25c )
    {
        br_public::brleaderdialogplayer( "gulag_spawn_rules", self, 0, undefined, undefined, undefined, "dx_br_jpbm_" );
    }
    
    fadetime = 2;
    blackscreenup = br_spawnrespawn::playeriscinematiclayeron();
    
    if ( !blackscreenup )
    {
        thread br_spawnrespawn::fadeoutin( fadetime );
    }
    
    thread br_spawnrespawn::fadeoutinspectatorsofplayer( fadetime );
    
    if ( level.gulag.var_68477f8a49b62826 )
    {
        logstring( "[GULAG DEBUG] : Player " + self.clientid + " passed arena entrance step 01. Time : " + gettime() + ". Screen fade to black. Number of players in the queue for gulag are : " + arena.matches.size + " ." );
    }
    
    wait 1;
    
    if ( level.gulag.var_68477f8a49b62826 )
    {
        logstring( "[GULAG DEBUG] : Player " + self.clientid + " passed arena entrance step 02. Time : " + gettime() + ". Passed wait 1 after screen fade to black. Number of players in the queue for gulag are : " + arena.matches.size + " ." );
    }
    
    playertakeawayrock( arena );
    playergivearenaloadout( arena, loadoutindex );
    playerstartarenasetcontrols( 0, "initPlayerArena_postloadout_" + ( debugreason ?? "" ) );
    
    if ( namespace_a8afdcd7738e364e::function_373b8665fd6de550() )
    {
        br::playerexecutionsdisable();
    }
    
    thread playertimedinvunerable( 3 );
    
    if ( level.gulag.var_6d372bcc606f75c6 )
    {
        val::set( "PlayerArena", "health_regen", 0 );
    }
    
    if ( getdvarint( @"hash_4e5ffa31f07112ca", 0 ) == 1 )
    {
        level.gulag.lethaldelay = 0;
        thread function_4c234c9fbc265274( arena );
    }
    
    if ( level.gulag.lethaldelay > 0 )
    {
        thread watchlethaldelayplayer( arena );
    }
    
    if ( level.gulag.var_68477f8a49b62826 )
    {
        logstring( "[GULAG DEBUG] : Player " + self.clientid + " passed arena entrance step 03. Time : " + gettime() + ". Number of players in the queue for gulag are : " + arena.matches.size + " ." );
    }
    
    if ( !( namespace_a8afdcd7738e364e::function_373b8665fd6de550() && !level.var_56c3cc3dc37f1728.var_10cdd335a32170b6 ) || br_dom_gulag::function_bf5c033346d6e717() )
    {
        if ( br_dom_gulag::function_bf5c033346d6e717() )
        {
            arenaspawner = function_1cf5a2e1ff943d15( arena );
        }
        else
        {
            arenaspawner = getnextarenaspawn( arena );
        }
        
        spawnorigin = getgroundposition( arenaspawner.origin, 1 );
        spawnangles = arenaspawner.angles;
        
        if ( !isdefined( arenaspawner.angles ) )
        {
            spawnangles = ( 0, 0, 0 );
        }
        
        br_spawnrespawn::function_4a36121aa04feff4( spawnorigin, spawnangles );
    }
    
    if ( level.gulag.var_68477f8a49b62826 )
    {
        logstring( "[GULAG DEBUG] : Player " + self.clientid + " passed arena entrance step 04. Time : " + gettime() + ". Passed teleport to gulag. Number of players in the queue for gulag are : " + arena.matches.size + " ." );
    }
    
    setplayervargulagjail( 0 );
    setplayervargulagarena( 1 );
    self.health = self.maxhealth;
    
    if ( !function_bc6aa264f5495083( "setArmorHealth", arena ) )
    {
        assert( isdefined( level.gulag.numarmorhealth ) );
        armor::setarmorhealth( level.gulag.numarmorhealth );
    }
    
    if ( getdvarint( @"hash_3ceaf2c0c66c3dc2", 0 ) > 0 )
    {
        self hudoutlineenableforclients( arena.arenaplayers, "outline_nodepth_red" );
    }
    
    blackscreenup = br_spawnrespawn::playeriscinematiclayeron();
    
    if ( blackscreenup )
    {
        br_spawnrespawn::function_24b79e9319c6f02f();
    }
    
    if ( br_dom_gulag::function_bf5c033346d6e717() )
    {
        thread br_dom_gulag::gulagdom_matchstartcamerasequence( arena );
    }
    
    wait 1;
    
    if ( level.gulag.var_68477f8a49b62826 )
    {
        logstring( "[GULAG DEBUG] : Player " + self.clientid + " passed arena entrance step 05. Time : " + gettime() + ". Start Camera sequence started 1 second ago. Number of players in the queue for gulag are : " + arena.matches.size + " . Player in gulag? : " + self.gulag + " ." );
    }
    
    if ( namespace_a8afdcd7738e364e::function_3d1f225aa0b4d926( "gulag_initPlayerArena" ) )
    {
        namespace_a8afdcd7738e364e::function_2af099d01df1a89c( "gulag_initPlayerArena" );
    }
    
    self allowprone( 1 );
    self allowcrouch( 1 );
    wait function_92cc22b2a7acc8c9() - 1;
    self.skydive_spawnprotection = undefined;
    self notify( #"skydive_remove_spawn_protection" );
    
    if ( namespace_a8afdcd7738e364e::function_373b8665fd6de550() )
    {
        br::playerexecutionsenable();
    }
    
    if ( !level.gulag.allowmeatshield )
    {
        self function_3181733c19782bcc( 0 );
        self function_134cd2c60d3a7edf( 0 );
    }
    
    if ( namespace_a8afdcd7738e364e::function_373b8665fd6de550() && level.var_56c3cc3dc37f1728.var_55e4d43596a9b8c9 )
    {
        thread namespace_a974e4dd85555bc2::function_61271384688bce9d( "gulag_jailer_match_start", arena );
    }
    
    if ( level.gulag.var_68477f8a49b62826 )
    {
        logstring( "[GULAG DEBUG] : Player " + self.clientid + " passed arena entrance step 06. Time : " + gettime() + ". Right before countdown. Number of players in the queue for gulag are : " + arena.matches.size + " . Player in gulag? : " + self.gulag + " ." );
    }
    
    wait 1;
    
    if ( level.gulag.var_68477f8a49b62826 )
    {
        logstring( "[GULAG DEBUG] : Player " + self.clientid + " passed arena entrance step 07. Time : " + gettime() + ". Player is fully in gulag. Number of players in the queue for gulag are : " + arena.matches.size + " . Player in gulag? : " + self.gulag + " ." );
    }
    
    if ( getdvarint( @"hash_3ceaf2c0c66c3dc2", 0 ) > 0 && arena.arenaplayers.size > 0 )
    {
        self hudoutlinedisableforclients( arena.arenaplayers );
    }
}

// Namespace br_gulag
// Params 0
// Checksum 0xe7c03704, Offset: 0xbf61
// Size: 0x1d5
function function_6780024006eb9962()
{
    arena = self;
    arena waittill( #"hash_db5aa30961fe1dba" );
    spawnplayerone = arena.fightspawns[ 0 ];
    spawnplayertwo = arena.fightspawns[ 1 ];
    spawnplayerthree = arena.fightspawns[ 2 ];
    spawnplayerfour = arena.fightspawns[ 3 ];
    
    if ( distance2d( spawnplayerone.origin, spawnplayerthree.origin ) > 150 )
    {
        logstring( "[GULAG] Bad gulag spawns for spawns : 1 & 3" );
        spawnplayerthree = arena function_7ca6789b153bbe34( spawnplayerone );
    }
    
    if ( distance2d( spawnplayertwo.origin, spawnplayerfour.origin ) > 150 )
    {
        logstring( "[GULAG] Bad gulag spawns for spawns : 2 & 4" );
        spawnplayerfour = arena function_7ca6789b153bbe34( spawnplayertwo );
    }
    
    var_8355f64ae9b79ebb = 0;
    var_1906e241a481a489 = 0;
    
    foreach ( p in arena.arenaplayers )
    {
        if ( p.twotwoteam == 1 )
        {
            if ( var_8355f64ae9b79ebb == 0 )
            {
                p function_eb288bd69e1bd0e0( spawnplayerone );
                var_8355f64ae9b79ebb++;
            }
            else
            {
                p function_eb288bd69e1bd0e0( spawnplayerthree );
                var_8355f64ae9b79ebb++;
            }
            
            continue;
        }
        
        if ( var_1906e241a481a489 == 0 )
        {
            p function_eb288bd69e1bd0e0( spawnplayertwo );
            var_1906e241a481a489++;
            continue;
        }
        
        p function_eb288bd69e1bd0e0( spawnplayerfour );
        var_1906e241a481a489++;
    }
    
    arena notify( #"hash_15fc7d39ad1974ea" );
}

// Namespace br_gulag
// Params 1
// Checksum 0x3071b5f8, Offset: 0xc13e
// Size: 0x81
function function_eb288bd69e1bd0e0( var_494aa46a804004ae )
{
    player = self;
    spawnorigin = getgroundposition( var_494aa46a804004ae.origin, 1 );
    spawnangles = var_494aa46a804004ae.angles;
    
    if ( !isdefined( var_494aa46a804004ae.angles ) )
    {
        spawnangles = ( 0, 0, 0 );
    }
    
    player br_spawnrespawn::function_4a36121aa04feff4( spawnorigin, spawnangles );
    player.var_c9936bbb7d91d9e = spawnorigin;
}

// Namespace br_gulag
// Params 1
// Checksum 0xb441ebff, Offset: 0xc1c7
// Size: 0xc4
function function_7ca6789b153bbe34( usedspawnpoint )
{
    arena = self;
    newspawnpoint = undefined;
    
    foreach ( spawnpoint in arena.fightspawns )
    {
        if ( spawnpoint == usedspawnpoint )
        {
            continue;
        }
        
        if ( distance2d( usedspawnpoint.origin, spawnpoint.origin ) < 150 )
        {
            newspawnpoint = spawnpoint;
        }
    }
    
    return newspawnpoint;
}

// Namespace br_gulag
// Params 2
// Checksum 0xc5861c52, Offset: 0xc294
// Size: 0x9e
function playerstartarenasetcontrols( enable, debugreason )
{
    if ( enable )
    {
        self notify( #"hash_3c65536e19f7395b" );
        self allowmelee( 1 );
        self allowmovement( 1 );
        self enableusability();
        self enableoffhandweapons();
        self allowads( 1 );
        self allowfire( 1 );
    }
    else
    {
        thread function_7e68de3008687714();
        self allowmelee( 0 );
        self allowmovement( 0 );
        self disableusability();
        self disableoffhandweapons();
        self allowads( 0 );
        self allowfire( 0 );
    }
    
    function_cbb2b688a1afe748( self, "playerStartArenaSetControls_" + ( debugreason ?? "" ), enable );
}

// Namespace br_gulag
// Params 0
// Checksum 0xf9693ef6, Offset: 0xc33a
// Size: 0x68
function function_7e68de3008687714()
{
    player = self;
    player notify( #"hash_3c65536e19f7395b" );
    player endon( #"hash_3c65536e19f7395b" );
    player endon( #"disconnect" );
    level endon( #"game_ended" );
    
    if ( !getdvarint( @"hash_d52a96b093650da", 1 ) )
    {
        return;
    }
    
    while ( isdefined( player ) )
    {
        player allowmovement( 0 );
        waitframe();
    }
}

// Namespace br_gulag
// Params 1
// Checksum 0xa5546b39, Offset: 0xc3aa
// Size: 0xc3
function getnextarenaspawn( arena )
{
    if ( !isdefined( arena.arenaspawncounter ) )
    {
        arena.arenaspawncounter = 0;
    }
    
    spawnpt = undefined;
    spawnsize = 0;
    
    if ( usecellspawns( arena ) )
    {
        spawnpt = arena.cellspawns[ arena.arenaspawncounter ];
        spawnsize = arena.cellspawns.size;
    }
    else
    {
        spawnpt = arena.fightspawns[ arena.arenaspawncounter ];
        spawnsize = arena.fightspawns.size;
    }
    
    arena.arenaspawncounter++;
    arena.arenaspawncounter %= spawnsize;
    return spawnpt;
}

// Namespace br_gulag
// Params 1
// Checksum 0x4d343757, Offset: 0xc476
// Size: 0x2c
function function_1cf5a2e1ff943d15( arena )
{
    spawnpt = function_fcf5007b80798d19( arena );
    arena thread function_78dc7f0f152cd84e( spawnpt );
    return spawnpt;
}

// Namespace br_gulag
// Params 1
// Checksum 0xc4e821b0, Offset: 0xc4ab
// Size: 0x325
function function_fcf5007b80798d19( arena )
{
    player = self;
    
    if ( !isdefined( arena.var_78dc7f0f152cd84e ) )
    {
        arena.var_78dc7f0f152cd84e = [];
    }
    
    player.var_49d21abc4829e837 = 9999;
    arena.var_d112ad2736a94538 = [];
    
    for ( i = 0; i < arena.fightspawns.size ; i++ )
    {
        arena.var_d112ad2736a94538[ i ] = 0;
        
        if ( isdefined( arena.ai_agents ) )
        {
            foreach ( agent in arena.ai_agents )
            {
                distanceagent = distance2d( arena.fightspawns[ i ].origin, agent.origin );
                
                if ( distanceagent < player.var_49d21abc4829e837 )
                {
                    player.var_49d21abc4829e837 = distanceagent;
                }
                
                arena.var_d112ad2736a94538[ i ] += distanceagent * 1.1;
            }
        }
        
        if ( isdefined( arena.arenaplayers ) )
        {
            foreach ( p in arena.arenaplayers )
            {
                distanceagent = distance2d( arena.fightspawns[ i ].origin, p.origin );
                
                if ( distanceagent < player.var_49d21abc4829e837 )
                {
                    player.var_49d21abc4829e837 = distanceagent;
                }
                
                arena.var_d112ad2736a94538[ i ] += distanceagent;
            }
        }
    }
    
    var_3b22f41fe66b6f2b = 0;
    var_c69b729cda88b89a = 0;
    
    for ( i = 0; i < arena.fightspawns.size ; i++ )
    {
        if ( arena.var_d112ad2736a94538[ i ] >= arena.var_d112ad2736a94538[ var_3b22f41fe66b6f2b ] )
        {
            if ( !arraycontains( arena.var_78dc7f0f152cd84e, arena.fightspawns[ i ] ) )
            {
                var_3b22f41fe66b6f2b = i;
                var_c69b729cda88b89a = 1;
            }
        }
    }
    
    if ( var_c69b729cda88b89a )
    {
        var_6f4cf213a8941445 = arena.fightspawns[ var_3b22f41fe66b6f2b ];
    }
    else
    {
        randomindex = randomint( arena.fightspawns.size );
        var_6f4cf213a8941445 = arena.fightspawns[ randomindex ];
    }
    
    return var_6f4cf213a8941445;
}

// Namespace br_gulag
// Params 1
// Checksum 0xbbc57f4e, Offset: 0xc7d9
// Size: 0x79
function function_78dc7f0f152cd84e( var_c6feba96bd15f3dc )
{
    arena = self;
    level endon( #"game_ended" );
    arena.var_78dc7f0f152cd84e[ arena.var_78dc7f0f152cd84e.size ] = var_c6feba96bd15f3dc;
    wait level.gulag.var_8298e7c5cc1de463;
    
    if ( !isdefined( var_c6feba96bd15f3dc ) )
    {
        return;
    }
    
    arena.var_78dc7f0f152cd84e = arrayremove( arena.var_78dc7f0f152cd84e, var_c6feba96bd15f3dc );
}

// Namespace br_gulag
// Params 1
// Checksum 0x31d9373d, Offset: 0xc85a
// Size: 0x4c
function playertimedinvunerable( timeout )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    self.plotarmor = 1;
    utility::waittill_any_timeout_no_endon_death( timeout, "death", "gulagRespawn" );
    self.plotarmor = undefined;
}

// Namespace br_gulag
// Params 0
// Checksum 0x3607e0ad, Offset: 0xc8ae
// Size: 0xbd
function function_28b55336e9c7a4f2()
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    playerclientnum = self getplayerclientnum();
    
    if ( isdefined( playerclientnum ) && isdefined( level.codcasters ) )
    {
        foreach ( codcaster in level.codcasters )
        {
            if ( codcaster function_4b6b10419be69ea5( playerclientnum ) )
            {
                codcaster clearpredictedstreampos();
            }
        }
    }
}

// Namespace br_gulag
// Params 10
// Checksum 0x4782c301, Offset: 0xc973
// Size: 0x69e
function gulagvictory( arena, winner, var_14fa66b4662751f0, var_14492e6381be5546, analyticsevent, gulagskipped, sponsor, forredeploy, freezeplayercontrols, var_d8b630278b0f4d88 )
{
    level endon( #"game_ended" );
    winner endon( #"death_or_disconnect" );
    
    if ( !isdefined( gulagskipped ) )
    {
        gulagskipped = 0;
    }
    
    function_d1e9259bf9b9055( winner, "br_gulag::gulagvictory", "gulagIndex=" + arena.gulagindex + " wasKickedOut=" + ( var_14fa66b4662751f0 ?? "" ) + " wasJailbreakEvent=" + ( var_14492e6381be5546 ?? "" ) + " analyticsEvent=" + ( analyticsevent ?? "" ) + " gulagSkipped=" + gulagskipped + " forRedeploy=" + ( forredeploy ?? "" ) + " freezePlayerControls=" + ( freezeplayercontrols ?? "" ) + " wasGulagbreakEvent=" + ( var_d8b630278b0f4d88 ?? "" ) );
    freezemovement = analyticsevent == "br_twotwo_gulag_win_flag" || analyticsevent == "br_twotwo_gulag_win_ladder_escape";
    winner function_4eb2799a37ebf4c2( freezemovement );
    winner codcasterclientmatchdata::function_ee35d29284860183( 23, 0 );
    
    foreach ( player in arena.arenaplayers )
    {
        player codcasterclientmatchdata::function_ee35d29284860183( 23, 0 );
        
        if ( arena.arenaplayers[ 0 ] == winner )
        {
            player setclientomnvar( "ui_br_gulag_match_state", 4 );
            continue;
        }
        
        player setclientomnvar( "ui_br_gulag_match_state", 5 );
    }
    
    winner function_e43f5ac84783f619();
    winner playerclearjailtimeouthud();
    winner thread playertimedinvunerable( 5 );
    
    if ( namespace_a8afdcd7738e364e::function_373b8665fd6de550() )
    {
        winner disableexecutionattack();
        winner disableexecutionvictim();
    }
    
    if ( br_twotwo_gulag::function_a826a6e753a74909() && namespace_a8afdcd7738e364e::function_3d1f225aa0b4d926( "gulagWinSequence" ) )
    {
        winner namespace_a8afdcd7738e364e::function_2af099d01df1a89c( "gulagWinSequence", arena, analyticsevent );
    }
    
    if ( !var_14fa66b4662751f0 && !var_14492e6381be5546 && !gulagskipped && !forredeploy && !var_d8b630278b0f4d88 )
    {
        winner thread points::doscoreevent( #"br_gulag_score" );
    }
    
    winner function_bc6aa264f5495083( "overrideRespawnArmor", arena );
    winner.gulagloser = 0;
    teamplayers = teams::function_d032b36d01bbbab3( winner.team, winner.sessionsquadid, 1 );
    
    if ( isdefined( teamplayers ) && teamplayers.size > 0 )
    {
        foreach ( teammate in teamplayers )
        {
            if ( !isdefined( teammate ) )
            {
                continue;
            }
            
            if ( teammate != winner )
            {
                teammate thread hud_message::showsplash( "br_gulag_teammate_out", undefined, winner );
                thread br_public::brleaderdialogplayer( "gulag_teammate_win", teammate, undefined, undefined, 2 );
            }
        }
    }
    
    reason = "";
    
    if ( isdefined( analyticsevent ) )
    {
        reason = analyticsevent;
    }
    
    println( "<dev string:x18e>" + winner.name + "<dev string:x1aa>" + reason );
    
    if ( !var_14492e6381be5546 && !gulagskipped && !forredeploy && !var_d8b630278b0f4d88 )
    {
        winner thread br_spawnrespawn::triggerrespawnoverlay( 3 );
    }
    
    if ( var_14fa66b4662751f0 )
    {
        if ( !var_14492e6381be5546 && !var_d8b630278b0f4d88 )
        {
            if ( analyticsevent == "timeout" )
            {
                br_public::brleaderdialogplayer( "gulag_timeout", winner, 0 );
            }
            else
            {
                br_public::brleaderdialogplayer( "gulag_noenemy", winner, 0 );
            }
        }
        
        arena.jailedplayers = arrayremove( arena.jailedplayers, winner );
        function_61fa022bebce175d( winner, "Kicked Out", 0 );
        updatematchqueuepositions( arena );
    }
    else
    {
        winnerdialog = function_bc6aa264f5495083( "getWinnerDialogOverride", arena ) ?? "gulag_win";
        br_public::brleaderdialogplayer( winnerdialog, winner, 0, undefined, undefined, undefined, "dx_br_jpbm_" );
    }
    
    music_br::function_4a82360c26e13c11( winner );
    
    if ( isstring( "" ) && "" != "" && soundexists( "" ) )
    {
        winner playsoundtoplayer( "", winner );
    }
    
    if ( level.gulag.onekillwin && ( arena.isjailbreak || level.gulag.maxplayers > 2 ) )
    {
        winner player_utility::function_dbe5a52a6654a982();
        winner player_utility::function_9d378d725bb4831e( "br_gulag::gulagVictory()" );
    }
    
    winner br_public::updatebrscoreboardstat( "isRespawning", 1 );
    streamtimeout = br_public::getdefaultstreamhinttimeoutms() / 1000;
    spawnpoint = winner br_spawnrespawn::playergetrespawnpoint( 0, streamtimeout );
    winner.var_a477f50bf8df2b90 = spawnpoint.origin;
    streamorigin = winner br_spawnrespawn::playerprestreamrespawnorigin( spawnpoint );
    
    if ( br_ai_gulag::function_43645d97a69e494f() )
    {
        winner.var_3b5387aafed2f5 = undefined;
        winner.var_640dc06094860255 = undefined;
    }
    
    wait function_933c89106a2241d4();
    
    if ( level.gulag.arenaflag )
    {
        arena.dom.arenaflag thread arenaflag_setvisibleplayer( 0, winner );
    }
    
    winner clearclienttriggeraudiozone( 2 );
    winner br_spawnrespawn::function_1d2f70d591e967bc( 1 );
    wait 1;
    winner function_bcac5f8ace98a749();
    winner playerstartjailsetcontrols( 1 );
    winner playerstartarenasetcontrols( 1, "gulagVictory" );
    winner br_spawnrespawn::function_45fa421c1d07d98d( 0 );
    winner setstance( "stand" );
    
    if ( var_14fa66b4662751f0 && player::isinlaststand( winner ) )
    {
        winner notify( #"last_stand_revived" );
    }
    
    winner function_a8ece89e0c7e96dd();
    
    if ( namespace_a8afdcd7738e364e::function_3d1f225aa0b4d926( "gulagGiveAIKillRewards" ) )
    {
        winner thread namespace_a8afdcd7738e364e::function_2af099d01df1a89c( "gulagGiveAIKillRewards" );
    }
    
    winner thread gulag_getplayerstatewait( 10 );
    winner gulagwinnerrespawn( gulagskipped, analyticsevent, spawnpoint, 1, streamorigin, undefined, sponsor, var_14492e6381be5546, forredeploy, undefined, var_d8b630278b0f4d88, undefined, arena );
    winner.var_a477f50bf8df2b90 = undefined;
    br_spectate::function_8f4a7afb87136937( winner );
}

// Namespace br_gulag
// Params 0
// Checksum 0xecdc7c18, Offset: 0xd019
// Size: 0x33
function function_933c89106a2241d4()
{
    if ( namespace_a8afdcd7738e364e::function_3d1f225aa0b4d926( "gulagGetVictoryWait" ) )
    {
        waittime = namespace_a8afdcd7738e364e::function_2af099d01df1a89c( "gulagGetVictoryWait" );
    }
    else
    {
        waittime = 2;
    }
    
    return waittime;
}

// Namespace br_gulag
// Params 0
// Checksum 0xc9ac0a04, Offset: 0xd055
// Size: 0x33
function function_4291ded821599a6()
{
    if ( namespace_a8afdcd7738e364e::function_3d1f225aa0b4d926( "gulagGetPostVictoryWait" ) )
    {
        postwaittime = namespace_a8afdcd7738e364e::function_2af099d01df1a89c( "gulagGetPostVictoryWait" );
    }
    else
    {
        postwaittime = 1;
    }
    
    return postwaittime;
}

// Namespace br_gulag
// Params 2
// Checksum 0x446216ec, Offset: 0xd091
// Size: 0x8a
function gulagplayerwatchfordeath( arena, betinfo )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    self endon( #"gulag_end" );
    self endon( #"gulag_auto_win" );
    self waittill( #"death", attacker );
    
    if ( level.gulag.onekillwin )
    {
        handleonekillwin( arena, self, attacker, betinfo );
    }
    
    thread gulagplayerlost( arena );
}

// Namespace br_gulag
// Params 3
// Checksum 0x708d0e64, Offset: 0xd123
// Size: 0x378
function gulagplayerlost( arena, var_b54d2b5056f188e8, var_2711918a5aa35d96 )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    self endon( #"pull_out_of_gulag" );
    self endon( #"gulag_auto_win" );
    self.var_6aebb152eede315c = 1;
    
    if ( namespace_a8afdcd7738e364e::function_373b8665fd6de550() )
    {
        self disableexecutionattack();
        self disableexecutionvictim();
    }
    
    self dropoffascender();
    function_d1e9259bf9b9055( self, "br_gulag::gulagplayerlost", "gulagIndex=" + arena.gulagindex + " reasonGulagLost=" + ( var_b54d2b5056f188e8 ?? "" ) + " lostToOvertime=" + ( var_2711918a5aa35d96 ?? "" ) );
    
    if ( function_bc6aa264f5495083( "playerLost", arena ) )
    {
        return;
    }
    
    if ( isalive( self ) )
    {
        self.plotarmor = 1;
        function_4eb2799a37ebf4c2();
    }
    
    if ( namespace_a8afdcd7738e364e::function_3d1f225aa0b4d926( "gulagLostOverlay" ) )
    {
        namespace_a8afdcd7738e364e::function_2af099d01df1a89c( "gulagLostOverlay", self, var_b54d2b5056f188e8 );
    }
    else
    {
        thread br_spectate::triggereliminatedoverlay();
    }
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    function_e43f5ac84783f619();
    
    if ( namespace_a8afdcd7738e364e::function_3d1f225aa0b4d926( "gulagHandleLossInfiniteEarly" ) )
    {
        thread namespace_a8afdcd7738e364e::function_2af099d01df1a89c( "gulagHandleLossInfiniteEarly", arena );
        return;
    }
    
    if ( self.gulagloser )
    {
        return;
    }
    
    self.gulagloser = 1;
    
    if ( !namespace_a8afdcd7738e364e::function_373b8665fd6de550() || var_2711918a5aa35d96 )
    {
        self.spectatepoint = arena.spectatepoint;
        playersetwasingulag( 1 );
    }
    
    if ( br_ai_gulag::function_43645d97a69e494f() )
    {
        self.gulagplayerstate = 3;
        br_ai_gulag::function_c92eb1ca0d9165d();
    }
    
    music_br::function_f9d258715af63e80( self );
    
    if ( isstring( "" ) && "" != "" && soundexists( "" ) )
    {
        self playsoundtoplayer( "", self );
    }
    
    br_utility::markplayeraseliminated( self, "gulagPlayerLost" );
    level thread br::updateplayerandteamcountui();
    br_public::brleaderdialogplayer( "gulag_lose", self, 0, 1 );
    br_public::brleaderdialogteamexcludeplayer( "gulag_teammate_lose", self.team, self, 0, 0 );
    
    if ( namespace_a8afdcd7738e364e::function_3d1f225aa0b4d926( "gulagLoseSequence" ) )
    {
        namespace_a8afdcd7738e364e::function_2af099d01df1a89c( "gulagLoseSequence", arena, var_b54d2b5056f188e8 );
    }
    
    wait function_933c89106a2241d4();
    callondeadevent = 0;
    
    if ( isalive( self ) )
    {
        if ( !br_gametypes::isfeaturedisabled( #"teamspectate" ) )
        {
            br_spectate::migratespectators( self, undefined, 1 );
        }
        
        br_spawnrespawn::function_1d2f70d591e967bc();
        wait 1;
        function_bcac5f8ace98a749();
        
        if ( !br_gametypes::isfeaturedisabled( #"teamspectate" ) )
        {
            br_spectate::migratespectators( self, undefined, 1 );
        }
        
        if ( isalive( self ) )
        {
            deathdata = spawnstruct();
            deathdata.origin = self.origin;
            deathdata.angles = self.angles;
            deathdata.attacker = self.lastattacker;
            self.health = 0;
            self notify( #"death" );
            self notify( #"death_or_disconnect" );
            codcasterclientmatchdata::function_ee35d29284860183( 23, 0 );
            callondeadevent = !isdefined( level.activeteams[ self.team ] );
            br_spectate::spawnspectator( deathdata, 1, 1 );
            playerlogic::removefromalivecount( 0, "gulagPlayerLost" );
        }
        
        br_spawnrespawn::function_24b79e9319c6f02f();
    }
    
    gulagleave();
    
    if ( namespace_a8afdcd7738e364e::function_3d1f225aa0b4d926( "gulagHandleLossInfiniteLate" ) )
    {
        thread namespace_a8afdcd7738e364e::function_2af099d01df1a89c( "gulagHandleLossInfiniteLate", arena );
    }
    
    if ( callondeadevent )
    {
        function_9eac425535266b33();
    }
}

// Namespace br_gulag
// Params 1
// Checksum 0xc1bbfe71, Offset: 0xd4a3
// Size: 0x3b
function function_4eb2799a37ebf4c2( freezemovement = 0 )
{
    if ( getdvarint( @"hash_4c5741468fcb94c1", 0 ) )
    {
        freezemovement = 1;
    }
    
    utility::function_d5a54acde3e473ca( freezemovement );
    utility::function_c13d09bc414864cb( 1 );
}

// Namespace br_gulag
// Params 0
// Checksum 0xce6072dd, Offset: 0xd4e6
// Size: 0x12
function function_bcac5f8ace98a749()
{
    utility::function_d5a54acde3e473ca( 0 );
    utility::function_c13d09bc414864cb( 0 );
}

// Namespace br_gulag
// Params 0
// Checksum 0xd4755634, Offset: 0xd500
// Size: 0x94
function function_9eac425535266b33()
{
    player = self;
    teamplayers = level.teamdata[ player.team ][ "players" ];
    
    if ( isdefined( teamplayers ) )
    {
        for ( i = 0; i < teamplayers.size ; i++ )
        {
            if ( !isdefined( teamplayers[ i ] ) )
            {
                continue;
            }
            
            if ( isalive( teamplayers[ i ] ) || teamplayers[ i ].gulag )
            {
                return;
            }
        }
        
        [[ level.ondeadevent ]]( player.team );
    }
}

// Namespace br_gulag
// Params 1
// Checksum 0x9f74e33c, Offset: 0xd59c
// Size: 0x57
function playersetwasingulag( value )
{
    if ( level.usegulag )
    {
        if ( value )
        {
            self.wasingulag = value;
            self setclientomnvar( "ui_gulag", value );
        }
        else
        {
            self.wasingulag = undefined;
            self setclientomnvar( "ui_gulag", 0 );
        }
        
        setplayeringulagarenaextrainfo( value );
    }
}

// Namespace br_gulag
// Params 0
// Checksum 0x5dc44010, Offset: 0xd5fb
// Size: 0x55
function playerspawningasspectator()
{
    if ( level.usegulag && self.wasingulag && teams::function_d032b36d01bbbab3( self.team, self.sessionsquadid ).size > 0 && !namespace_a8afdcd7738e364e::function_373b8665fd6de550() )
    {
        br_public::brleaderdialogplayer( "gulag_buyback", self, 0, 1 );
    }
}

// Namespace br_gulag
// Params 2
// Checksum 0xb6764a0b, Offset: 0xd658
// Size: 0x55
function recordmolotov( grenade, player )
{
    if ( player.gulagarena )
    {
        arena = player.arena;
        arena.molotovs[ arena.molotovs.size ] = grenade;
    }
}

// Namespace br_gulag
// Params 1
// Checksum 0xe2874fb3, Offset: 0xd6b5
// Size: 0x9a
function cleanuparenamolotovs( arena )
{
    foreach ( molotov in arena.molotovs )
    {
        if ( isdefined( molotov ) )
        {
            thread molotov::molotov_cleanup_pool( molotov );
        }
    }
    
    arena.molotovs = [];
}

// Namespace br_gulag
// Params 0
// Checksum 0x1057f8ae, Offset: 0xd757
// Size: 0xf1
function function_e43f5ac84783f619()
{
    self notify( #"gulag_end" );
    self setthreatbiasgroup();
    weapons::deleteplacedequipment();
    arena = self.arena;
    
    if ( arena )
    {
        arena.jailedplayers = function_5713d46873b29625( arena.jailedplayers );
        
        if ( arena.jailedplayers.size > 0 && getdvarint( @"hash_30c3e9d4f1f094cf", 0 ) )
        {
            self hudoutlinedisableforclients( arena.jailedplayers );
        }
        
        arena.arenaplayers = function_5713d46873b29625( arena.arenaplayers );
        
        if ( arena.arenaplayers.size > 0 && getdvarint( @"hash_3ceaf2c0c66c3dc2", 0 ) > 0 )
        {
            self hudoutlinedisableforclients( arena.arenaplayers );
        }
        
        arena.arenaplayers = arrayremove( arena.arenaplayers, self );
    }
}

// Namespace br_gulag
// Params 0
// Checksum 0xede5922d, Offset: 0xd850
// Size: 0x107
function gulagleave()
{
    arena = self.arena;
    self clearclienttriggeraudiozone( 2 );
    
    if ( level.gulag.arenaflag && arena )
    {
        arena.dom.arenaflag thread arenaflag_setvisibleplayer( 0, self );
    }
    
    challenges::function_a85672e6a703a837( self, 0 );
    
    if ( arena )
    {
        br_analytics::branalytics_gulagend( self, "loser", arena );
    }
    
    calloutmarkerping::function_5a33bcee47519dd6();
    playerdestroyhud( arena );
    self.plotarmor = undefined;
    self.arena = undefined;
    setplayervargulag( 0 );
    setplayervargulagarena( 0 );
    setplayervargulagjail( 0 );
    self allowwalljump( 1 );
    self.var_6aebb152eede315c = undefined;
    
    if ( !level.gulag.allowmeatshield )
    {
        self function_3181733c19782bcc( 1 );
        self function_134cd2c60d3a7edf( 1 );
    }
    
    level callback::callback( #"hash_438552ad6e5b08a0", { #player:self } );
}

// Namespace br_gulag
// Params 13
// Checksum 0x52bfbd11, Offset: 0xd95f
// Size: 0xc6
function gulagwinnerrespawn( gulagskipped, analyticsevent, spawnpoint, skipsplash, streamorigin, var_b006b462cca49b6e, sponsor, var_ec22479f7c93f2e0, forredeploy, dontsplash, var_7bf158c6738dc0ea, var_661e41f0d85ba58c, arena )
{
    onrespawnoverlay = undefined;
    
    if ( !skipsplash )
    {
        onrespawnoverlay = 7;
    }
    
    respawnstruct = function_3cbf7cd6bf743875( gulagskipped, analyticsevent, var_b006b462cca49b6e, sponsor, var_ec22479f7c93f2e0, forredeploy, dontsplash, undefined, onrespawnoverlay, var_7bf158c6738dc0ea, var_661e41f0d85ba58c, arena );
    self.var_1be091ba55db848e = analyticsevent;
    br_spawnrespawn::br_respawn( spawnpoint, streamorigin, respawnstruct );
}

// Namespace br_gulag
// Params 12
// Checksum 0xf65a7d7b, Offset: 0xda2d
// Size: 0x19f
function function_3cbf7cd6bf743875( gulagskipped, analyticsevent, var_b006b462cca49b6e, sponsor, var_ec22479f7c93f2e0, forredeploy, dontsplash, var_4b2efbbf9066123b, onrespawnoverlay, var_7bf158c6738dc0ea, var_661e41f0d85ba58c, arena )
{
    rs = br_spawnrespawn::function_1ecfc7c6647ddf97( &playerrespawngulagcleanup, "veh_br_gulag_redeploy_flyby", var_b006b462cca49b6e );
    rs br_spawnrespawn::function_ffd4cf4c20eae881( &function_a6d4bc475356a63b );
    rs br_spawnrespawn::function_ecc6ed28c3fae86b( &function_7b207573e442b79, var_4b2efbbf9066123b );
    rs br_spawnrespawn::function_b9b32e1004a183cb( undefined, onrespawnoverlay );
    rs br_spawnrespawn::function_7275e4fc001d486a( &gulagpostrespawn );
    rs.optparams.gulagskipped = gulagskipped;
    rs.optparams.analyticsevent = analyticsevent;
    rs.optparams.sponsor = sponsor;
    rs.optparams.var_ec22479f7c93f2e0 = var_ec22479f7c93f2e0;
    rs.optparams.forredeploy = forredeploy;
    rs.optparams.dontsplash = dontsplash;
    rs.optparams.var_7bf158c6738dc0ea = var_7bf158c6738dc0ea;
    rs.optparams.var_661e41f0d85ba58c = var_661e41f0d85ba58c;
    rs.optparams.arena = arena;
    return rs;
}

// Namespace br_gulag
// Params 1
// Checksum 0x57001103, Offset: 0xdbd5
// Size: 0x29a
function function_7b207573e442b79( optparams )
{
    println( "<dev string:x1b6>" + self.name );
    optparams.var_d3db5a42f7b59936 = self.platecarrierlevel;
    
    if ( !optparams.gulagskipped && !optparams.forredeploy )
    {
        if ( !optparams.var_ec22479f7c93f2e0 )
        {
            challenges::function_a85672e6a703a837( self, 1 );
            
            if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( self ) ) )
            {
                if ( isdefined( self.leaderboarddata[ "gulagWins" ] ) )
                {
                    self.leaderboarddata[ "gulagWins" ] = self.leaderboarddata[ "gulagWins" ] + 1;
                }
                
                if ( isdefined( level.leaderboardfunc[ "gulagWins" ] ) )
                {
                    [[ level.leaderboardfunc[ "gulagWins" ] ]]( self, 1 );
                }
                
                assert( isint( 1 ) || isfloat( 1 ), "<dev string:x1db>" );
                
                if ( isdefined( self.pers[ "gulagWins" ] ) )
                {
                    self.pers[ "gulagWins" ] = self.pers[ "gulagWins" ] + 1;
                }
            }
            
            self.endmatchstats[ "gulagWinsThisMatch" ] = ( self.endmatchstats[ "gulagWinsThisMatch" ] ?? 0 ) + 1;
        }
    }
    
    if ( isdefined( optparams.analyticsevent ) )
    {
        br_analytics::branalytics_gulagend( self, optparams.analyticsevent, optparams.arena );
    }
    
    playersetwasingulag( 0 );
    self.jailtime = undefined;
    
    if ( self.arena && ( level.gulag.shutdown && level.gulag.giveloadoutontimeout || optparams.analyticsevent == "vip" || optparams.analyticsevent == "debug" ) )
    {
        playergivearenaloadout( self.arena, 0 );
    }
    
    playertakeawayrock( self.arena );
    gulagwinnerloadout( optparams.gulagskipped );
    function_e43f5ac84783f619();
    gulagleave();
    respawndone = 0;
    
    if ( isdefined( level.gulag ) && level.gulag.planerespawn )
    {
        playerrespawngulagcleanup( optparams );
        br_spawnrespawn::function_e61300d028a4bd67();
        playersetupac130();
        respawndone = 1;
    }
    
    return respawndone;
}

// Namespace br_gulag
// Params 1
// Checksum 0xb40eb292, Offset: 0xde78
// Size: 0x49, Type: bool
function function_a6d4bc475356a63b( optparams )
{
    if ( self.spectatinggulag )
    {
        self.spectatinggulag = undefined;
        self setclientdvar( @"voice_proximity_enemy_client", 1 );
    }
    
    self.plotarmor = undefined;
    self.c130 = undefined;
    return true;
}

// Namespace br_gulag
// Params 1
// Checksum 0x616f25a, Offset: 0xdeca
// Size: 0x20e
function gulagpostrespawn( optparams )
{
    gametype = game_utility::getgametype();
    
    if ( gametype == "truckwar" && !optparams.forredeploy )
    {
        var_e906a5d396e9a3ce = "br_gulag_winner_redeploy_mogulag";
        var_3e4c4a7a8cc4f7b9 = undefined;
    }
    else if ( gametype == "dmz" || gametype == "plunder" || gametype == "kingslayer" || gametype == "risk" )
    {
        var_e906a5d396e9a3ce = "br_gulag_winner_redeploy_mogulag";
        var_3e4c4a7a8cc4f7b9 = undefined;
    }
    else if ( gametype == "br_buyback" )
    {
        var_e906a5d396e9a3ce = "br_inflation_gulag_winner_redeploy";
        var_3e4c4a7a8cc4f7b9 = undefined;
    }
    else if ( optparams.var_ec22479f7c93f2e0 )
    {
        var_e906a5d396e9a3ce = "br_gulag_jailbreak_redeploy";
        var_3e4c4a7a8cc4f7b9 = undefined;
    }
    else if ( optparams.var_7bf158c6738dc0ea )
    {
        var_e906a5d396e9a3ce = "br_gulag_winner_redeploy";
        var_3e4c4a7a8cc4f7b9 = undefined;
    }
    else if ( ( optparams.gulagskipped || optparams.forredeploy ) && !optparams.var_661e41f0d85ba58c && isdefined( optparams.sponsor ) )
    {
        var_e906a5d396e9a3ce = "br_gulag_kiosk_redeploy";
        var_3e4c4a7a8cc4f7b9 = optparams.sponsor;
    }
    else
    {
        if ( isdefined( level.gulag ) && !level.gulag.shutdown && checkgulagusecount() )
        {
            if ( namespace_a8afdcd7738e364e::function_373b8665fd6de550() )
            {
                var_e906a5d396e9a3ce = "br_gulag_winner_redeploy";
            }
            else
            {
                var_e906a5d396e9a3ce = "br_gulag_winner_redeploy_mogulag";
            }
        }
        else
        {
            var_e906a5d396e9a3ce = "br_gulag_winner_redeploy";
        }
        
        var_3e4c4a7a8cc4f7b9 = undefined;
    }
    
    if ( !optparams.dontsplash )
    {
        thread hud_message::showsplash( var_e906a5d396e9a3ce, undefined, var_3e4c4a7a8cc4f7b9 );
    }
    
    if ( isdefined( level.gulag ) && level.gulag.shutdown && !self.gulagdone )
    {
        wait 2;
        
        if ( !isdefined( self ) )
        {
            return;
        }
        
        playergulagdonesplash();
    }
    
    if ( optparams.var_661e41f0d85ba58c )
    {
        br_utility::unmarkplayeraseliminated( self, "gulagPostRespawn" );
        level thread br::updateplayerandteamcountui();
    }
}

// Namespace br_gulag
// Params 1
// Checksum 0xa233723c, Offset: 0xe0e0
// Size: 0xc6
function playerrespawngulagcleanup( optparams )
{
    self notify( #"gulagRespawn" );
    molotov::molotov_clear_burning();
    
    if ( getdvarint( @"hash_3e7ee8bdf6ce5f54", 0 ) == 0 )
    {
        self.hasspawnweapons = 0;
    }
    
    function_c35096fb12f26591( "respawnCleanup", self );
    self.health = self.maxhealth;
    damage_effects::onexitdeathsdoor( 1 );
    
    if ( !optparams.gulagskipped )
    {
        val::set( "isRespawning", "player_for_spawn_logic", 0 );
        self setclientomnvar( "ui_gulag", 0 );
        br_public::updatebrscoreboardstat( "isRespawning", 0 );
        
        if ( isdefined( self.arena ) )
        {
            removeloadingplayer( self.arena, self );
        }
        
        self.arena = undefined;
    }
}

// Namespace br_gulag
// Params 1
// Checksum 0xed676a8a, Offset: 0xe1ae
// Size: 0x1e2
function gulagwinnerloadout( gulagskipped )
{
    if ( isdefined( self.arena ) )
    {
        var_167d31e0da40edbb = istrue( self.arena.var_167d31e0da40edbb );
    }
    
    keepgulaggun = namespace_a8afdcd7738e364e::function_373b8665fd6de550() && !var_167d31e0da40edbb || getdvarint( @"hash_7ad0617cfa893a28", 0 );
    var_1cb8e9c1cb54b103 = level.br_allowloadout && !level.br_allowloadoutonlyinprelobby;
    var_3334ac1ce36a41e9 = !gulagskipped;
    
    if ( keepgulaggun && var_3334ac1ce36a41e9 && !var_1cb8e9c1cb54b103 )
    {
        return gulagwinnerremembergunandammo();
    }
    
    if ( var_167d31e0da40edbb )
    {
        self.gulagtableloadout = 1;
        self.var_9cf9df8119f31d8b = 1;
        self.var_2578f5c7d1480acd = self.arena.var_6cea0cedadce6cac.winnerloadouts;
        self.var_b9c55fdc2a9fdfc1 = self.arena.var_6cea0cedadce6cac.winnerloadoutindex;
        return;
    }
    
    var_68a9edb9997f9d09 = getdvarint( @"hash_f97d261e2f377ad9", 1 ) != 0 && getdvarint( @"hash_943f7c30bd8b86e8", -1 ) > -1;
    
    if ( isdefined( level.br_standard_loadout ) || var_68a9edb9997f9d09 )
    {
        self.gulagtableloadout = 1;
        return;
    }
    
    self.gulagtableloadout = 0;
    
    if ( namespace_a8afdcd7738e364e::function_373b8665fd6de550() || getdvarint( @"hash_7ad0617cfa893a28", 0 ) != 0 || self.keepgulaggun )
    {
        gulagwinnerremembergunandammo();
        return;
    }
    
    if ( isdefined( level.br_standard_loadout ) || getdvarint( @"hash_f97d261e2f377ad9", 1 ) != 0 && getdvarint( @"hash_943f7c30bd8b86e8", -1 ) > -1 )
    {
        self.gulagtableloadout = 1;
    }
}

// Namespace br_gulag
// Params 0
// Checksum 0xc67b5f24, Offset: 0xe398
// Size: 0xe2
function gulagwinnerrestoreloadout()
{
    if ( !level.usegulag && !br_gametypes::isfeaturedisabled( #"hash_b371d9c9c0a6f2f3" ) )
    {
        return 0;
    }
    
    if ( level.var_891db96300e47e39 )
    {
        return 0;
    }
    
    keepgulaggun = namespace_a8afdcd7738e364e::function_373b8665fd6de550() && !self.var_9cf9df8119f31d8b || getdvarint( @"hash_7ad0617cfa893a28", 0 );
    var_5cde0110c24a9b27 = !self.gulagloser;
    
    if ( keepgulaggun && var_5cde0110c24a9b27 )
    {
        return gulagwinnerrestoregunandammo();
    }
    
    var_68a9edb9997f9d09 = getdvarint( @"hash_f97d261e2f377ad9", 1 ) && getdvarint( @"hash_943f7c30bd8b86e8", -1 ) > -1;
    
    if ( isdefined( level.br_standard_loadout ) || var_68a9edb9997f9d09 || self.var_9cf9df8119f31d8b )
    {
        return gulagwinnertableloadout();
    }
    
    return 0;
}

// Namespace br_gulag
// Params 2
// Checksum 0xcf120310, Offset: 0xe483
// Size: 0xa7
function function_20fafb378c414052( allprimaries, filterarray )
{
    filteredprimaries = [];
    
    foreach ( primary in allprimaries )
    {
        if ( !arraycontains( filterarray, primary.basename ) )
        {
            filteredprimaries[ filteredprimaries.size ] = primary;
        }
    }
    
    return filteredprimaries;
}

// Namespace br_gulag
// Params 0
// Checksum 0xc8622ec2, Offset: 0xe533
// Size: 0x1ad
function gulagwinnerremembergunandammo()
{
    self.br_gulagguncurrent = self getcurrentprimaryweapon();
    self.br_gulagweapons = [];
    self.br_gulagammo = [];
    weaponslots = [ #"primary_0", #"primary_1", #"tertiary_0" ];
    
    foreach ( weaponslot in weaponslots )
    {
        weaponobj = item_weapon::function_e7484276ad85f220( weaponslot );
        self.br_gulagweapons[ weaponslot ] = weaponobj;
        self.br_gulagammo[ weaponslot ] = 2;
    }
    
    self.br_gulagequipment = [];
    
    foreach ( slot, equipref in self.equipment )
    {
        self.br_gulagequipment[ slot ] = equipref;
        ammo = 0;
        
        if ( namespace_a8afdcd7738e364e::function_373b8665fd6de550() )
        {
            ammo = equipment_mp::getequipmentammo( equipref );
        }
        else
        {
            ammo = equipment_mp::getequipmentstartammo( equipref );
        }
        
        self.br_gulagammo[ equipref ] = ammo;
    }
}

// Namespace br_gulag
// Params 0
// Checksum 0x1daf2c26, Offset: 0xe6e8
// Size: 0x33f, Type: bool
function gulagwinnerrestoregunandammo()
{
    if ( isdefined( self.br_gulagweapons ) && isdefined( self.br_gulagequipment ) && isdefined( self.br_gulagammo ) )
    {
        var_dd279d6ce6e6943d = namespace_a8afdcd7738e364e::function_373b8665fd6de550() || getdvarint( @"hash_8d1efd0a32e32222", 0 );
        
        if ( var_dd279d6ce6e6943d && self.br_gulagweapons.size < 1 )
        {
            self.gulagtableloadout = 1;
            gulagwinnertableloadout();
            return false;
        }
        
        self takeallweapons();
        br_weapons::br_ammo_player_clear();
        self.equipment[ "primary" ] = undefined;
        self.equipment[ "secondary" ] = undefined;
        self.equipment[ "health" ] = undefined;
        self.equipment[ "super" ] = undefined;
        loadoutstruct = class::loadout_getclassstruct();
        loadoutstruct = class::loadout_updateclass( loadoutstruct, "gamemode" );
        loadoutstruct.loadoutprimaryobject = self.br_gulagweapons[ #"primary_0" ];
        loadoutstruct.loadoutsecondaryobject = self.br_gulagweapons[ #"primary_1" ];
        loadoutstruct.var_9dcef9a8722c3abb = self.br_gulagweapons[ #"tertiary_0" ];
        loadoutstruct.loadoutequipmentprimary = self.br_gulagequipment[ "primary" ] ?? "none";
        loadoutstruct.loadoutequipmentsecondary = self.br_gulagequipment[ "secondary" ] ?? "none";
        class::preloadandqueueclassstruct( loadoutstruct, 1, 1 );
        class::giveloadout( self.team, "gamemode", 0, 0, undefined, 1, 1 );
        
        foreach ( slotname, weaponobj in self.br_gulagweapons )
        {
            var_e83765ccc7677f19 = self.br_gulagammo[ slotname ] ?? 0;
            
            if ( var_e83765ccc7677f19 > 0 )
            {
                item_ammo::function_46e5ccf39665fcf4( weaponobj, 0, 0, 0, undefined, var_e83765ccc7677f19 );
            }
        }
        
        foreach ( slot, equipref in self.br_gulagequipment )
        {
            equipment_mp::giveequipment( equipref, slot );
            equipment_mp::setequipmentammo( equipref, self.br_gulagammo[ equipref ] ?? 0 );
        }
        
        if ( isdefined( self.br_gulagguncurrent ) )
        {
            self switchtoweaponimmediate( self.br_gulagguncurrent );
        }
        
        if ( isdefined( self.executionref ) )
        {
            execution::_giveexecution( self.executionref );
        }
        
        self.br_gulaggun = undefined;
        self.br_gulagammo = undefined;
        self.br_gulagoffhands = undefined;
        self.br_gulagguncurrent = undefined;
        return true;
    }
    
    return false;
}

// Namespace br_gulag
// Params 0
// Checksum 0x24e91e6d, Offset: 0xea30
// Size: 0x1b1, Type: bool
function gulagwinnertableloadout()
{
    if ( self.gulagtableloadout )
    {
        if ( self.var_9cf9df8119f31d8b )
        {
            loadoutindex = self.var_b9c55fdc2a9fdfc1;
        }
        else
        {
            loadoutindex = getdvarint( @"hash_943f7c30bd8b86e8", -1 );
        }
        
        if ( loadoutindex > -1 )
        {
            if ( isdefined( self.var_2578f5c7d1480acd ) )
            {
                tablename = "classtable:" + self.var_2578f5c7d1480acd;
                gamemodeloadout = br::initstandardloadout( tablename, loadoutindex );
                self.pers[ "gamemodeLoadout" ] = gamemodeloadout;
            }
            else
            {
                self.pers[ "gamemodeLoadout" ] = level.gulagloadouts[ loadoutindex ];
            }
        }
        else
        {
            self.pers[ "gamemodeLoadout" ] = level.br_standard_loadout;
        }
        
        self.class = "gamemode";
        self.prevweaponobj = undefined;
        self.var_8cf9648fae56099c = undefined;
        struct = class::loadout_getclassstruct();
        struct = class::loadout_updateclass( struct, "gamemode" );
        class::preloadandqueueclassstruct( struct, 1, 1 );
        class::giveloadout( self.team, "gamemode", 0, 0, undefined, 1 );
        self givestartammo( struct.loadoutprimaryobject );
        
        if ( isdefined( struct.loadoutsecondaryobject ) )
        {
            self givestartammo( struct.loadoutsecondaryobject );
        }
        
        br::givelaststandifneeded( self );
        self notify( #"ammo_update" );
        thread br::br_displayperkinfo();
        self.gulagtableloadout = undefined;
        self.var_9cf9df8119f31d8b = undefined;
        self.var_2578f5c7d1480acd = undefined;
        self.var_b9c55fdc2a9fdfc1 = undefined;
        return true;
    }
    
    return false;
}

// Namespace br_gulag
// Params 1
// Checksum 0x29b5d3a6, Offset: 0xebea
// Size: 0x61
function popnextmatch( arena )
{
    nextmatch = arena.matches[ 0 ];
    arena.matches[ 0 ] = undefined;
    function_cdc669dbc8ea2101( arena.matches );
    
    if ( namespace_a8afdcd7738e364e::function_3d1f225aa0b4d926( "gulagOrderArenaPlayers" ) )
    {
        nextmatch = namespace_a8afdcd7738e364e::function_2af099d01df1a89c( "gulagOrderArenaPlayers", nextmatch );
    }
    
    return nextmatch;
}

// Namespace br_gulag
// Params 0
// Checksum 0xaf4d38de, Offset: 0xec54
// Size: 0x50, Type: bool
function checkgulagusecount()
{
    if ( level.gulag.maxuses >= 0 )
    {
        playerusecount = self.gulaguses ?? 0;
        
        if ( playerusecount >= level.gulag.maxuses )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace br_gulag
// Params 0
// Checksum 0x9dfb9d62, Offset: 0xecad
// Size: 0x133
function function_8f1d6e8e7dd58a42()
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    self endon( #"gulag_end" );
    self endon( #"jailbreak_respawn" );
    playerclientnum = self getplayerclientnum();
    
    if ( isdefined( playerclientnum ) && isdefined( level.codcasters ) )
    {
        var_86d650f9e4f1d98d = namespace_a8afdcd7738e364e::function_373b8665fd6de550();
        
        foreach ( codcaster in level.codcasters )
        {
            if ( codcaster function_4b6b10419be69ea5( playerclientnum ) )
            {
                if ( var_86d650f9e4f1d98d )
                {
                    arena = namespace_a974e4dd85555bc2::gulag_playergetnextarena();
                }
                else
                {
                    arena = playergetnextarena();
                }
                
                spawnpt = getnextjailspawn( arena );
                spawnorigin = getgroundposition( spawnpt.origin, 12 );
                codcaster predictstreamposuntilcleared( spawnorigin );
            }
        }
    }
}

// Namespace br_gulag
// Params 0
// Checksum 0x2444eb36, Offset: 0xede8
// Size: 0x194, Type: bool
function trygulagspawn()
{
    println( "<dev string:x201>" + self.name + "<dev string:x15a>" + self.class );
    
    if ( !self.br_infilstarted || !flags::gameflag( "prematch_done" ) )
    {
        return false;
    }
    
    if ( self.arena.goagain )
    {
        return true;
    }
    
    if ( self.gulag )
    {
        return false;
    }
    
    if ( br_public::hasrespawntoken() && !namespace_9d8e359c3b1041e5::respawntokendisabledsharedfunc() )
    {
        context = "tryGulagSpawn";
        
        if ( level.gulag.selfbuyback > 0 )
        {
            context = "self_buyback";
            currency::function_b5fe1e05c892a7f3( "cash", level.gulag.selfbuyback, "gulag_self_buyback", { #skipsplash:1 } );
        }
        
        thread playergulagautowin( context, undefined, 1, 1 );
        
        if ( level.gulag.var_afcf7128589ec970 )
        {
            level thread br_contract_manager::utilflare_shootflare( self.origin, "revive" );
        }
        
        return true;
    }
    
    if ( !function_f3e1e2a67d51fba8() )
    {
        return false;
    }
    
    if ( level.gulag.shutdown && !playerinlaststandhold() )
    {
        return false;
    }
    
    if ( getdvarint( @"hash_4d250e4873e1753e", 0 ) )
    {
        return false;
    }
    
    if ( self.gulagloser && !br_public::function_70c1f4b75530023f() )
    {
        return false;
    }
    
    item_gulag_token::function_10b12e3b4eaa98df();
    thread function_8f1d6e8e7dd58a42();
    thread initplayerjail( 1 );
    return true;
}

// Namespace br_gulag
// Params 1
// Checksum 0x5ee49079, Offset: 0xef85
// Size: 0xbd, Type: bool
function function_f3e1e2a67d51fba8( var_f540ef0897f43424 )
{
    if ( !self.br_infilstarted || !flags::gameflag( "prematch_done" ) )
    {
        return false;
    }
    
    if ( var_f540ef0897f43424 && self.gulag )
    {
        return true;
    }
    else if ( self.gulag )
    {
        return false;
    }
    
    if ( !level.usegulag )
    {
        return false;
    }
    
    if ( level.gulag.shutdown && !playerinlaststandhold() )
    {
        return false;
    }
    
    if ( getdvarint( @"hash_4d250e4873e1753e", 0 ) )
    {
        return false;
    }
    
    if ( !checkgulagusecount() && !br_public::function_70c1f4b75530023f() )
    {
        return false;
    }
    
    if ( self.extracted )
    {
        return false;
    }
    
    return true;
}

// Namespace br_gulag
// Params 1
// Checksum 0x988647ca, Offset: 0xf04b
// Size: 0xe1
function playergulaghud( arena )
{
    self setclientomnvar( "ui_match_start_countdown", 0 );
    self setclientomnvar( "ui_is_exfil_countdown", 0 );
    
    if ( isdefined( arena.fightover ) && !arena.fightover )
    {
        playersetgulagdataomnvar( arena );
    }
    
    if ( isdefined( arena.fightover ) && !arena.fightover && arena.time > 0 )
    {
        time = arena.time;
        
        if ( !arena.overtime )
        {
            overtimelength = getovertimelength();
            time -= overtimelength;
        }
        
        self setclientomnvar( "ui_br_gulag_match_end_time", gettime() + int( time * 1000 ) );
        return;
    }
    
    self setclientomnvar( "ui_br_gulag_match_end_time", 0 );
}

// Namespace br_gulag
// Params 2
// Checksum 0x55f9cd23, Offset: 0xf134
// Size: 0x3d
function updatematchtimerhud( arena, time )
{
    _updatematchtimerhudinternal( arena.arenaplayers, time );
    _updatematchtimerhudinternal( arena.jailedplayers, time );
}

// Namespace br_gulag
// Params 2
// Checksum 0xd3025f0b, Offset: 0xf179
// Size: 0xd3
function _updatematchtimerhudinternal( players, time )
{
    foreach ( player in players )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        if ( br_dom_gulag::function_bf5c033346d6e717() )
        {
            player utility::waittill_notify_or_timeout( "gulag_done_with_camera_sequence", 8 );
        }
        
        if ( time > 0 )
        {
            player setclientomnvar( "ui_br_gulag_match_end_time", gettime() + int( time * 1000 ) );
            continue;
        }
        
        player setclientomnvar( "ui_br_gulag_match_end_time", 0 );
    }
}

// Namespace br_gulag
// Params 1
// Checksum 0xd4041c5b, Offset: 0xf254
// Size: 0x3b3
function updatematchqueuepositions( arena )
{
    matchsize = level.gulag.matchsize;
    
    while ( matchsize <= level.gulag.maxplayers )
    {
        matches = [];
        
        foreach ( player in arena.jailedplayers )
        {
            if ( !isdefined( player ) )
            {
                continue;
            }
            
            var_f67f2b633eeb875b = 0;
            
            foreach ( matchindex, match in matches )
            {
                if ( match.size >= matchsize )
                {
                    continue;
                }
                
                var_c6aef3c6cfb09fde = 0;
                
                if ( namespace_a8afdcd7738e364e::function_373b8665fd6de550() )
                {
                    var_cd9b803b84c3188c = player function_eb595854335a8ead( match );
                    
                    if ( var_cd9b803b84c3188c >= level.var_56c3cc3dc37f1728.var_58ba4ec2b88f9ae2 )
                    {
                        var_c6aef3c6cfb09fde = 1;
                    }
                }
                else
                {
                    foreach ( matchplayer in match )
                    {
                        if ( matchplayer.team == player.team )
                        {
                            var_c6aef3c6cfb09fde = 1;
                            break;
                        }
                    }
                }
                
                if ( !var_c6aef3c6cfb09fde )
                {
                    var_f67f2b633eeb875b = 1;
                    player.gulagposition = matchindex + 1;
                    matches[ matchindex ][ matches[ matchindex ].size ] = player;
                    break;
                }
            }
            
            if ( !var_f67f2b633eeb875b )
            {
                player.gulagposition = matches.size + 1;
                matches[ matches.size ] = [ player ];
            }
        }
        
        arena.matches = matches;
        
        if ( matches.size <= level.gulag.var_57fe56d04634639a )
        {
            break;
        }
        
        matchsize += level.gulag.matchsize;
    }
    
    if ( arena.matches.size > 0 && utility::issharedfuncdefined( #"teamassim", #"isenabled" ) && [[ utility::getsharedfunc( #"teamassim", #"isenabled" ) ]]() && utility::issharedfuncdefined( #"teamassim", #"disableplayer" ) )
    {
        nextmatch = arena.matches[ 0 ];
        
        foreach ( player in nextmatch )
        {
            [[ utility::getsharedfunc( #"teamassim", #"disableplayer" ) ]]( player, "br_gulag" );
        }
    }
    
    updatearenaomnvarplayers( arena );
}

// Namespace br_gulag
// Params 1
// Checksum 0xd5eefdf3, Offset: 0xf60f
// Size: 0x10c
function playerwatchdisconnect( arena )
{
    self endon( #"gulag_end" );
    self waittill( #"death_or_disconnect" );
    
    if ( isdefined( self ) && self.gulagarena )
    {
        return;
    }
    
    if ( isdefined( self ) )
    {
        if ( self.gulagarena )
        {
            arena.arenaplayers = arrayremove( arena.arenaplayers, self );
        }
        else if ( self.jailed )
        {
            arena.jailedplayers = arrayremove( arena.jailedplayers, self );
            function_61fa022bebce175d( self, "Disconnect", 0 );
        }
        
        if ( isdefined( arena.var_a8bbf2a2aedca4c9 ) )
        {
            if ( arraycontains( arena.var_a8bbf2a2aedca4c9, self ) )
            {
                arena.var_a8bbf2a2aedca4c9 = arrayremove( arena.var_a8bbf2a2aedca4c9, self );
            }
        }
        
        playerdestroyhud( arena );
    }
    else
    {
        function_c2ad80fb44599224( arena );
    }
    
    updatematchqueuepositions( arena );
    
    if ( br_twotwo_gulag::function_a826a6e753a74909() )
    {
        br_twotwo_gulag::function_c637cdd44e4fb704( arena );
    }
}

// Namespace br_gulag
// Params 1
// Checksum 0x35859656, Offset: 0xf723
// Size: 0x4c
function playerdestroyhud( arena )
{
    self setclientomnvar( "ui_br_gulag_match_end_time", 0 );
    
    if ( isdefined( arena ) )
    {
        playercleargulagomnvars( arena );
    }
    
    if ( isdefined( self.gulagjailbreakhud ) )
    {
        self.gulagjailbreakhud destroy();
    }
    
    self.gulagloadoutindex = undefined;
}

// Namespace br_gulag
// Params 1
// Checksum 0x8152ee73, Offset: 0xf777
// Size: 0x68
function setplayervargulag( value )
{
    if ( self.gulag === value )
    {
        return;
    }
    
    if ( value )
    {
        level.var_bb25c34ae28e413f++;
    }
    else if ( isdefined( self.gulag ) )
    {
        level.var_bb25c34ae28e413f--;
    }
    
    self.gulag = value;
    self notify( #"br_gulag_in_gulag_changed" );
    level notify( #"hash_7f6b2a7b2d05df3e" );
}

// Namespace br_gulag
// Params 1
// Checksum 0xc9da9e2f, Offset: 0xf7e7
// Size: 0x4a
function setplayervargulagarena( value )
{
    if ( isdefined( self.gulagarena ) && self.gulagarena == value )
    {
        return;
    }
    
    setplayeringulagarenaextrainfo( value );
    self.gulagarena = value;
    level notify( #"hash_7f6b2a7b2d05df3e" );
}

// Namespace br_gulag
// Params 1
// Checksum 0x31c6139, Offset: 0xf839
// Size: 0x45
function setplayeringulagarenaextrainfo( value )
{
    if ( value )
    {
        self.game_extrainfo |= 65536;
        return;
    }
    
    self.game_extrainfo &= ~65536;
}

// Namespace br_gulag
// Params 1
// Checksum 0xf28b1c9e, Offset: 0xf886
// Size: 0x4a
function setplayervargulagjail( value )
{
    if ( isdefined( self.jailed ) && self.jailed == value )
    {
        return;
    }
    
    setplayeringulagjailextrainfo( value );
    self.jailed = value;
    level notify( #"hash_7f6b2a7b2d05df3e" );
}

// Namespace br_gulag
// Params 1
// Checksum 0x40ed06e1, Offset: 0xf8d8
// Size: 0x41
function setplayeringulagjailextrainfo( value )
{
    if ( value )
    {
        self.game_extrainfo |= 32768;
        return;
    }
    
    self.game_extrainfo &= ~32768;
}

// Namespace br_gulag
// Params 1
// Checksum 0x1d9ce70d, Offset: 0xf921
// Size: 0xae
function setplayergulagindex( arena )
{
    if ( arena.gulagindex > 7 )
    {
        return;
    }
    
    bitwidth = 3;
    bitoffset = 3;
    mask = ( 1 << bitwidth ) - 1;
    shiftedvalue = ( arena.gulagindex & mask ) << bitoffset;
    invertedmask = ~( mask << bitoffset );
    prevvalue = self.game_extrainfo;
    cleanedbase = prevvalue & invertedmask;
    repackedvalue = cleanedbase + shiftedvalue;
    self.game_extrainfo = repackedvalue;
}

// Namespace br_gulag
// Params 2
// Checksum 0x3596be54, Offset: 0xf9d7
// Size: 0x72
function startbetting( arena, fighters )
{
    if ( !level.gulag.betting )
    {
        return;
    }
    
    betinfo = spawnstruct();
    betinfo.fighters = fighters;
    betinfo.bets = [];
    betinfo.bettingopen = 1;
    betinfo thread show_betting_to_players( arena );
    return betinfo;
}

// Namespace br_gulag
// Params 1
// Checksum 0xe8193e5e, Offset: 0xfa52
// Size: 0xdc
function show_betting_to_players( arena )
{
    self endon( #"end_betting" );
    
    while ( true )
    {
        bettingplayers = getbettingplayers( arena, self );
        
        foreach ( player in bettingplayers )
        {
            if ( isbot( player ) )
            {
                continue;
            }
            
            if ( isdefined( self.bets[ player.guid ] ) )
            {
                continue;
            }
            
            thread showbettinghud( arena, player );
        }
        
        arena waittill( #"hash_ba48c1041cfb8604" );
    }
}

// Namespace br_gulag
// Params 2
// Checksum 0x21771967, Offset: 0xfb36
// Size: 0x270
function showbettinghud( arena, player )
{
    self endon( #"end_betting" );
    bet = spawnstruct();
    bet.owner = player;
    self.bets[ player.guid ] = bet;
    focusxoffset = 10;
    focusyoffset = 0;
    bet.hudfocusname = player hud_util::createfontstring( "default", 1.2 );
    bet.hudfocusname hud_util::setpoint( "LEFT", "CENTER", focusxoffset, focusyoffset );
    bet.hudfocusname.label = &"";
    bet.hudfocusname.alpha = 0;
    var_5d93b87fbaa1b465 = 5;
    var_51f01fdedef768da = -50;
    bet.hudavailable = player hud_util::createfontstring( "default", 1.2 );
    bet.hudavailable hud_util::setpoint( "LEFT", "LEFT", var_5d93b87fbaa1b465, var_51f01fdedef768da );
    bet.hudavailable.label = &"mp/br_gulag_bet_available";
    bet.hudavailable hud::fontpulseinit();
    bet.hudbetonplayer = player hud_util::createfontstring( "default", 1.5 );
    bet.hudbetonplayer hud_util::setpoint( "LEFT", "LEFT", var_5d93b87fbaa1b465, var_51f01fdedef768da + 25 );
    bet.hudbetonplayer.label = &"";
    bet.hudammount = player hud_util::createfontstring( "default", 1.5 );
    bet.hudammount hud_util::setpoint( "LEFT", "LEFT", var_5d93b87fbaa1b465, var_51f01fdedef768da + 40 );
    bet.hudammount.label = &"mp/br_gulag_bet_ammount";
    bet.playerbeton = -1;
    bet.playerfocus = -1;
    bet.ammount = 0;
    updatebethud( bet );
    thread updatebetplayerfocus( arena, bet );
    thread watchbetplaced( bet );
}

// Namespace br_gulag
// Params 2
// Checksum 0xbf096038, Offset: 0xfdae
// Size: 0x1b0
function updatebetplayerfocus( arena, bet )
{
    self endon( #"end_betting" );
    bet.owner endon( #"disconnect" );
    mindot = 0.9;
    
    while ( true )
    {
        playerfocus = -1;
        bestdot = -1;
        ownereye = bet.owner geteye();
        ownerdir = anglestoforward( bet.owner getplayerangles() );
        
        foreach ( i, fighter in self.fighters )
        {
            if ( !isdefined( fighter ) )
            {
                continue;
            }
            
            fighterorigin = fighter.origin + ( 0, 0, 30 );
            var_888c45e985970942 = vectornormalize( fighterorigin - ownereye );
            fighterdot = vectordot( ownerdir, var_888c45e985970942 );
            
            if ( fighterdot < mindot || fighterdot < bestdot )
            {
                continue;
            }
            
            playerfocus = i;
            bestdot = fighterdot;
        }
        
        if ( playerfocus != bet.playerfocus )
        {
            bet.playerfocus = playerfocus;
            updateoutlines( arena );
            updatebethud( bet );
        }
        
        wait 0.05;
    }
}

// Namespace br_gulag
// Params 1
// Checksum 0x48f9e870, Offset: 0xff66
// Size: 0xa8
function watchbetclear( bet )
{
    self endon( #"end_betting" );
    bet.owner endon( #"disconnect" );
    notifystring = "betClear";
    thread notifyonplayercommandbetting( bet.owner, notifystring, "+weapnext" );
    
    while ( true )
    {
        bet.owner waittill( notifystring );
        
        if ( bet.playerbeton == -1 )
        {
            continue;
        }
        
        bet.ammount = 0;
        bet.playerbeton = -1;
        updatebethud( bet );
    }
}

// Namespace br_gulag
// Params 1
// Checksum 0x9974399f, Offset: 0x10016
// Size: 0x142
function watchbetplaced( bet )
{
    self endon( #"end_betting" );
    bet.owner endon( #"disconnect" );
    notifystring = "betPlaced";
    thread notifyonplayercommandbetting( bet.owner, notifystring, "+usereload" );
    
    while ( true )
    {
        bet.owner waittill( notifystring );
        
        if ( bet.playerfocus == -1 )
        {
            if ( bet.playerbeton == -1 )
            {
                continue;
            }
            
            desiredbet = 0;
        }
        else if ( bet.playerbeton == -1 )
        {
            desiredbet = 1;
        }
        else if ( bet.playerbeton == bet.playerfocus )
        {
            desiredbet = bet.ammount + 1;
        }
        else
        {
            desiredbet = 1;
        }
        
        if ( desiredbet > bet.owner currency::get_currency_amount( "cash" ) )
        {
            betchangefail( bet );
            continue;
        }
        
        bet.ammount = desiredbet;
        bet.playerbeton = bet.playerfocus;
        updatebethud( bet );
    }
}

// Namespace br_gulag
// Params 3
// Checksum 0x186d2b1a, Offset: 0x10160
// Size: 0x43
function notifyonplayercommandbetting( player, notifystr, cmdstr )
{
    player notifyonplayercommand( notifystr, cmdstr );
    self waittill( #"end_betting" );
    
    if ( isdefined( player ) )
    {
        player notifyonplayercommandremove( notifystr, cmdstr );
    }
}

// Namespace br_gulag
// Params 1
// Checksum 0xb69413d7, Offset: 0x101ab
// Size: 0x3e
function betchangefail( bet )
{
    bet.owner playlocalsound( "fly_pickup_deny" );
    bet.hudavailable thread hud::fontpulse( bet.owner );
}

// Namespace br_gulag
// Params 1
// Checksum 0x6da246f8, Offset: 0x101f1
// Size: 0x38d
function updatebethud( bet )
{
    var_8311661764d54ba2 = 1000;
    bet.hudavailable setvalue( ( bet.owner currency::get_currency_amount( "cash" ) - bet.ammount ) * var_8311661764d54ba2 );
    
    if ( bet.playerbeton != -1 )
    {
        fighterent = self.fighters[ bet.playerbeton ];
        
        if ( isdefined( fighterent ) )
        {
            bet.hudbetonplayer setplayernamestring( fighterent );
            bet.hudbetonplayer.alpha = 1;
        }
        else
        {
            bet.hudbetonplayer.alpha = 0;
        }
    }
    else
    {
        bet.hudbetonplayer.alpha = 0;
    }
    
    if ( bet.ammount > 0 )
    {
        bet.hudammount setvalue( bet.ammount * var_8311661764d54ba2 );
        bet.hudammount.alpha = 1;
    }
    else
    {
        bet.hudammount.alpha = 0;
    }
    
    if ( bet.playerbeton != -1 )
    {
        if ( bet.playerfocus == bet.playerbeton )
        {
            bet.hudfocusname.alpha = 1;
            bet.hudfocusname.label = &"mp/br_gulag_focus_bet_increase";
            bet.hudfocusname settext( &"" );
        }
        else if ( bet.playerfocus != -1 )
        {
            bet.hudfocusname.alpha = 1;
            bet.hudfocusname.label = &"mp/br_gulag_focus_bet_change";
            fighterent = self.fighters[ bet.playerfocus ];
            
            if ( isdefined( fighterent ) )
            {
                bet.hudfocusname setplayernamestring( fighterent );
            }
        }
        else
        {
            assert( bet.playerfocus == -1 );
            bet.hudfocusname.alpha = 1;
            bet.hudfocusname.label = &"mp/br_gulag_focus_bet_clear";
            bet.hudfocusname settext( &"" );
        }
        
        return;
    }
    
    if ( bet.playerfocus != -1 )
    {
        bet.hudfocusname.alpha = 1;
        bet.hudfocusname.label = &"mp/br_gulag_focus_bet";
        fighterent = self.fighters[ bet.playerfocus ];
        
        if ( isdefined( fighterent ) )
        {
            bet.hudfocusname setplayernamestring( fighterent );
        }
        
        return;
    }
    
    assert( bet.playerfocus == -1 );
    bet.hudfocusname.alpha = 0;
    bet.hudfocusname.label = &"";
}

// Namespace br_gulag
// Params 2
// Checksum 0x6c21dcf4, Offset: 0x10586
// Size: 0xf5
function cleanupbethud( bet, delaytime )
{
    bet notify( #"hash_cc3c7b17c6e3b4ff" );
    
    if ( isdefined( delaytime ) )
    {
        bet endon( #"hash_cc3c7b17c6e3b4ff" );
        wait delaytime;
    }
    
    huds = [ bet.hudbetonplayer, bet.hudammount, bet.hudavailable, bet.hudfocusname ];
    
    foreach ( hud in huds )
    {
        if ( isdefined( hud ) )
        {
            hud destroy();
        }
    }
}

// Namespace br_gulag
// Params 4
// Checksum 0xb90ca30b, Offset: 0x10683
// Size: 0x50
function watchbetbutton( bet, player, notifystr, index )
{
    self endon( #"end_betting" );
    
    while ( true )
    {
        player waittill( notifystr );
        bet notify( #"betPlaced", index );
    }
}

// Namespace br_gulag
// Params 2
// Checksum 0xf35fa76, Offset: 0x106db
// Size: 0x192
function endbetting( arena, betinfo )
{
    if ( !isdefined( betinfo ) || !betinfo.bettingopen )
    {
        return;
    }
    
    betinfo notify( #"end_betting" );
    betinfo.bettingopen = 0;
    
    foreach ( bet in betinfo.bets )
    {
        huds = [ bet.hudavailable, bet.hudfocusname ];
        
        if ( bet.playerbeton == -1 )
        {
            huds[ huds.size ] = bet.hudbetonplayer;
            huds[ huds.size ] = bet.hudammount;
        }
        
        foreach ( hud in huds )
        {
            if ( isdefined( hud ) )
            {
                hud destroy();
            }
        }
    }
    
    updateoutlines( arena );
}

// Namespace br_gulag
// Params 2
// Checksum 0xe7d21311, Offset: 0x10875
// Size: 0x110
function payoutremainingbets( winner, betinfo )
{
    if ( !isdefined( betinfo ) )
    {
        return;
    }
    
    winnerindex = -1;
    
    if ( isdefined( winner ) )
    {
        winnerindex = winner.fighterindex;
    }
    
    foreach ( bet in betinfo.bets )
    {
        if ( bet.playerbeton != -1 && isdefined( bet.owner ) && !bet.paidout )
        {
            iswinner = bet.playerbeton == winnerindex;
            _completebet( betinfo, bet, iswinner );
        }
        
        thread cleanupbethud( bet, 2.5 );
    }
}

// Namespace br_gulag
// Params 3
// Checksum 0xc3334048, Offset: 0x1098d
// Size: 0x21b
function _completebet( betinfo, bet, iswinner )
{
    wincolor = ( 0, 1, 0 );
    losecolor = ( 1, 0, 0 );
    bet.paidout = 1;
    
    if ( iswinner )
    {
        bet.owner br_plunder::playersetplundercount( bet.owner currency::get_currency_amount( "cash" ) + bet.ammount );
        bet.hudbetonplayer.color = wincolor;
        bet.hudbetonplayer.label = &"mp/br_gulag_bet_fighter_name_winner";
        bet.hudammount.color = wincolor;
        bet.hudammount.label = &"mp/br_gulag_bet_ammount_won";
    }
    else
    {
        bet.hudbetonplayer.color = losecolor;
        bet.hudbetonplayer.label = &"mp/br_gulag_bet_fighter_name_loser";
        bet.hudammount.color = losecolor;
        bet.hudammount.label = &"mp/br_gulag_bet_ammount_lost";
        
        if ( isalive( bet.owner ) )
        {
            var_7e8cd265f905b7a0 = bet.owner currency::get_currency_amount( "cash" ) - bet.ammount;
            assert( var_7e8cd265f905b7a0 >= 0 );
            var_7e8cd265f905b7a0 = int( max( 0, var_7e8cd265f905b7a0 ) );
            bet.owner br_plunder::playersetplundercount( var_7e8cd265f905b7a0 );
        }
    }
    
    fighterent = betinfo.fighters[ bet.playerfocus ];
    
    if ( isdefined( fighterent ) )
    {
        fighterent hudoutlinedisableforclient( bet.owner );
    }
}

// Namespace br_gulag
// Params 2
// Checksum 0xf14f0ee0, Offset: 0x10bb0
// Size: 0xbe
function getbettingplayers( arena, betinfo )
{
    bettingplayers = arena.jailedplayers;
    
    if ( level.gulag.betting > 1 )
    {
        foreach ( fighter in betinfo.fighters )
        {
            bettingplayers[ bettingplayers.size ] = fighter;
        }
    }
    
    return bettingplayers;
}

// Namespace br_gulag
// Params 3
// Checksum 0x1b2454a8, Offset: 0x10c77
// Size: 0xeb
function payoutbet( betinfo, player, iswinner )
{
    if ( !isdefined( betinfo ) )
    {
        return;
    }
    
    foreach ( bet in betinfo.bets )
    {
        if ( bet.playerbeton == player.fighterindex && isdefined( bet.owner ) && !bet.paidout )
        {
            _completebet( betinfo, bet, iswinner );
            thread cleanupbethud( bet, 2.5 );
        }
    }
}

// Namespace br_gulag
// Params 1
// Checksum 0x821978ef, Offset: 0x10d6a
// Size: 0x6d
function rock_used( grenade )
{
    arena = self.arena;
    grenade utility::waittill_notify_or_timeout( "missile_stuck", 4 );
    wait 2;
    
    if ( isdefined( grenade ) )
    {
        grenade delete();
    }
    
    if ( level.usegulag && level.gulag.usefloorrocks )
    {
        spawnrock( arena );
    }
}

// Namespace br_gulag
// Params 1
// Checksum 0x5a729ec2, Offset: 0x10ddf
// Size: 0x230
function spawnrocks( arena )
{
    arena.rocks = [];
    gulagscriptables = getentitylessscriptablearray( arena.target, #targetname );
    
    foreach ( scriptable in gulagscriptables )
    {
        if ( scriptable.type == "brloot_rock" )
        {
            arena.rocks[ arena.rocks.size ] = scriptable;
        }
    }
    
    if ( arena.rocks.size == 0 || !level.gulag.usefloorrocks )
    {
        for ( i = 0; i < arena.rocks.size ; i++ )
        {
            rock = arena.rocks[ i ];
            
            if ( rock getscriptableparthasstate( "brloot_rock", "hidden" ) )
            {
                rock setscriptablepartstate( "brloot_rock", "hidden" );
            }
        }
        
        return;
    }
    
    var_4eefc2a61151141c = getdvarint( @"hash_557a54e530663166", 20 );
    
    if ( arena.rocks.size < var_4eefc2a61151141c )
    {
        var_4eefc2a61151141c = arena.rocks.size;
    }
    
    arena.rocks = arrayrandomize( arena.rocks );
    arena.rockcounter = var_4eefc2a61151141c;
    disablerocks = getdvarint( @"hash_983b34df705745ce", 1 ) == 0;
    
    for ( i = 0; i < arena.rocks.size ; i++ )
    {
        rock = arena.rocks[ i ];
        rock.arena = arena;
        
        if ( i >= var_4eefc2a61151141c || disablerocks )
        {
            rock setscriptablepartstate( "brloot_rock", "hidden" );
        }
    }
}

// Namespace br_gulag
// Params 6
// Checksum 0x9f35b11b, Offset: 0x11017
// Size: 0xbd
function rockused( rock, part, state, player, bautouse, usestring )
{
    if ( !( isdefined( rock ) && isdefined( player ) ) )
    {
        return;
    }
    
    assert( part == "<dev string:x217>" );
    rockweap = makeweapon( "rock_mp" );
    
    if ( player hasweapon( rockweap ) && player getammocount( rockweap ) > 0 )
    {
        return;
    }
    
    rock setscriptablepartstate( "brloot_rock", "hidden" );
    player thread pickups::playerplaypickupanim();
    player equipment_mp::giveequipment( "equip_rock", "primary" );
    player playlocalsound( "br_rock_pickup" );
}

// Namespace br_gulag
// Params 1
// Checksum 0xf2cb9a52, Offset: 0x110dc
// Size: 0x9b
function spawnrock( arena )
{
    if ( arena.shutdown || arena.rocks.size == 0 )
    {
        return;
    }
    
    rock = arena.rocks[ arena.rockcounter ];
    
    if ( isdefined( rock ) )
    {
        rock setscriptablepartstate( "brloot_rock", "visible" );
        arena.rockcounter++;
        
        if ( arena.rockcounter >= arena.rocks.size )
        {
            arena.rockcounter = 0;
        }
    }
}

// Namespace br_gulag
// Params 1
// Checksum 0x83d30b05, Offset: 0x1117f
// Size: 0x58
function playertakeawayrock( arena )
{
    rockweap = makeweapon( "rock_mp" );
    
    if ( self hasweapon( rockweap ) )
    {
        self takeweapon( rockweap );
        self clearaccessory();
        
        if ( level.gulag.usefloorrocks )
        {
            spawnrock( arena );
        }
    }
}

// Namespace br_gulag
// Params 3
// Checksum 0xbf569f5a, Offset: 0x111df
// Size: 0x149
function gettangentoncirclefrompoint( circlecenter, circleradius, point )
{
    xp = point[ 0 ] - circlecenter[ 0 ];
    yp = point[ 1 ] - circlecenter[ 1 ];
    r = circleradius;
    xp2 = xp * xp;
    yp2 = yp * yp;
    r2 = r * r;
    c = xp2 + yp2 - r2;
    tangentpoint = undefined;
    var_99f21768f5496b7b = 1;
    
    if ( c > 0 )
    {
        x = ( r2 * xp - r * yp * sqrt( xp2 + yp2 - r2 ) ) / ( xp2 + yp2 );
        y = ( r2 * yp + r * xp * sqrt( xp2 + yp2 - r2 ) ) / ( xp2 + yp2 );
        tangentpoint = ( x, y, point[ 2 ] ) + ( circlecenter[ 0 ], circlecenter[ 1 ], 0 );
    }
    else
    {
        var_4278c80fb249e205 = vectornormalize( ( xp, yp, 0 ) );
        p = circlecenter + var_4278c80fb249e205 * circleradius;
        tangentpoint = ( p[ 0 ], p[ 1 ], point[ 2 ] );
        var_99f21768f5496b7b = 0;
    }
    
    return [ tangentpoint, var_99f21768f5496b7b ];
}

// Namespace br_gulag
// Params 0
// Checksum 0xd03b6f10, Offset: 0x11331
// Size: 0x324
function spawnac130()
{
    if ( !level.gulag.planerespawn )
    {
        return;
    }
    
    level waittill( #"prematch_started" );
    
    if ( !level.br_infils_disabled )
    {
        wait 10;
    }
    
    startpt = undefined;
    circleradius = undefined;
    
    if ( isdefined( level.br_ac130 ) )
    {
        startpt = level.br_ac130.startpt;
    }
    else
    {
        c130pathstruct = br_c130::createtestc130path();
        startpt = c130pathstruct.startpt;
    }
    
    if ( isdefined( level.br_circle ) && isdefined( level.br_circle.safecircleent ) )
    {
        circleradius = level.br_circle.safecircleent.origin[ 2 ];
    }
    else
    {
        circleradius = level.br_level.br_circleradii[ 0 ];
    }
    
    circleradius -= 100;
    [ endpt, var_99f21768f5496b7b ] = gettangentoncirclefrompoint( level.br_level.br_mapcenter, circleradius, startpt );
    dist = 0;
    time = 0;
    
    if ( var_99f21768f5496b7b )
    {
        dist = distance( startpt, endpt );
        time = dist / br_c130::getc130speed();
    }
    
    linkerorg = ( level.br_level.br_mapcenter[ 0 ], level.br_level.br_mapcenter[ 1 ], startpt[ 2 ] );
    level.gulag.ac130linker = spawn( "script_model", linkerorg );
    level.gulag.ac130linker setmodel( "tag_origin" );
    level.gulag.ac130linker.radius = circleradius;
    level.gulag.ac130 = br_c130::gunship_spawn( startpt, endpt, time, 0, &ac130handlemovement );
    level.gulag.ac130 thread ac130setupanim();
    level.gulag.ac130.riders = [];
    
    if ( time <= 0 )
    {
        var_7426babf63602628 = endpt - level.br_level.br_mapcenter;
        dirnorm = vectornormalize( ( var_7426babf63602628[ 0 ], var_7426babf63602628[ 1 ], 0 ) );
        angles = vectortoangles( dirnorm );
        level.gulag.ac130 unlink();
        level.gulag.ac130.angles = ( 0, angles[ 1 ] + 90, 0 );
        level.gulag.ac130.origin = endpt;
        level.gulag.ac130 thread ac130linkandspin();
    }
}

// Namespace br_gulag
// Params 0
// Checksum 0xd1909578, Offset: 0x1165d
// Size: 0x4b
function ac130setupanim()
{
    animstruct = spawnstruct();
    self.animstruct = animstruct;
    animstruct.movingc130 = self;
    br_infils_legacy::spawnplayerpositionparentent( animstruct, self );
    br_infils_legacy::spawnplayerpositionent( animstruct, "j_prop_1" );
    br_infils_legacy::playac130infilloopanims( animstruct );
}

// Namespace br_gulag
// Params 2
// Checksum 0xab0f88a5, Offset: 0x116b0
// Size: 0x54
function ac130handlemovement( movedestination, movetime )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    self playloopsound( "br_ac130_lp" );
    
    if ( movetime > 0 )
    {
        self moveto( movedestination, movetime, 0, 0 );
        wait movetime;
    }
    
    thread ac130linkandspin();
}

// Namespace br_gulag
// Params 0
// Checksum 0x2865972, Offset: 0x1170c
// Size: 0xda
function ac130linkandspin()
{
    self notify( #"hash_2e237fac9cda74a4" );
    self endon( #"hash_2e237fac9cda74a4" );
    level.gulag.ac130linker endon( #"death" );
    var_d4416ba88a94007f = 6.28318;
    linearspeed = br_c130::getc130speed();
    circleradius = level.gulag.ac130linker.radius;
    time = var_d4416ba88a94007f * circleradius / linearspeed;
    self linkto( level.gulag.ac130linker, "tag_origin" );
    
    if ( time <= 0 )
    {
        return;
    }
    
    for ( ;; )
    {
        level.gulag.ac130linker rotateyaw( 360, time );
        wait time;
    }
}

// Namespace br_gulag
// Params 0
// Checksum 0x28899aba, Offset: 0x117ee
// Size: 0xa1
function waittillallarenasshutdown()
{
    var_1a2f426b1e393a97 = level.gulag.arenas.size;
    
    if ( !level.gulag.multiarena )
    {
        var_1a2f426b1e393a97 = 1;
    }
    
    for ( ;; )
    {
        running = 0;
        
        for ( i = 0; i < var_1a2f426b1e393a97 ; i++ )
        {
            arena = level.gulag.arenas[ i ];
            
            if ( !arena.shutdown )
            {
                running = 1;
                break;
            }
        }
        
        if ( !running )
        {
            return;
        }
        
        waitframe();
    }
}

// Namespace br_gulag
// Params 0
// Checksum 0x46c8d21b, Offset: 0x11897
// Size: 0x28e
function makeac130flyaway()
{
    if ( !level.gulag.planerespawn )
    {
        return;
    }
    
    waittillallarenasshutdown();
    wait getdvarint( @"hash_8780b8778180d47c", 15 );
    waittillframeend();
    
    foreach ( player in level.gulag.ac130.riders )
    {
        if ( isdefined( player ) )
        {
            player.jumptype = "solo";
            player notify( #"halo_kick_c130" );
        }
    }
    
    while ( level.gulag.ac130.riders.size > 0 )
    {
        waitframe();
    }
    
    startpt = level.gulag.ac130.origin;
    pathdir = anglestoforward( level.gulag.ac130.angles );
    pathradius = level.br_level.br_circleradii[ 0 ] * 2;
    endpt = startpt + pathdir * pathradius;
    endpt += pathdir * br_c130::getc130speed();
    dist = distance( startpt, endpt );
    time = dist / br_c130::getc130speed();
    level.gulag.ac130 notify( #"hash_2e237fac9cda74a4" );
    level.gulag.ac130 unlink();
    level.gulag.ac130 moveto( endpt, time, 0, 0 );
    wait time;
    br_public::cleanac130struct( level.gulag.ac130.animstruct );
    
    if ( isdefined( level.gulag.ac130 ) )
    {
        level.gulag.ac130 delete();
    }
    
    if ( isdefined( level.gulag.ac130linker ) )
    {
        level.gulag.ac130linker delete();
    }
}

// Namespace br_gulag
// Params 2
// Checksum 0x6b9af018, Offset: 0x11b2d
// Size: 0x210
function transitioncircle( newradius, waittime )
{
    if ( !level.gulag.planerespawn )
    {
        return;
    }
    
    if ( !( isdefined( level.gulag.ac130 ) && isdefined( level.gulag.ac130linker ) ) )
    {
        return;
    }
    
    neworigin = ( level.br_circle.safecircleent.origin[ 0 ], level.br_circle.safecircleent.origin[ 1 ], level.gulag.ac130linker.origin[ 2 ] );
    newradius -= 100;
    
    if ( level.gulag.ac130linker.radius != newradius )
    {
        dirtocenter = vectornormalize( level.gulag.ac130linker.origin - level.gulag.ac130.origin );
        centerstart = level.gulag.ac130.origin + dirtocenter * newradius;
        level.gulag.ac130 unlink();
        level.gulag.ac130linker.origin = centerstart;
        level.gulag.ac130linker.radius = newradius;
        level.gulag.ac130linker dontinterpolate();
        level.gulag.ac130 thread ac130linkandspin();
    }
    
    level.gulag.ac130linker moveto( neworigin, waittime );
    wait waittime;
}

// Namespace br_gulag
// Params 0
// Checksum 0x823ccf2b, Offset: 0x11d45
// Size: 0xd5
function playersetupac130()
{
    self.infilanimindex = 1;
    self.isjumpmaster = 0;
    br_infils_legacy::playerlinktopositionent( level.gulag.ac130.animstruct );
    thread br_infils_legacy::playerplayinfilloopanim( level.gulag.ac130.animstruct );
    thread playerputinc130( level.gulag.ac130 );
    br_infils_legacy::playersetupcontrolsforinfil( 1 );
    thread playerac130cleanup();
    thread playerautodeployaftertime();
    thread playerspawnprotectionac130();
    level.gulag.ac130.riders[ level.gulag.ac130.riders.size ] = self;
}

// Namespace br_gulag
// Params 1
// Checksum 0x3d78f4f2, Offset: 0x11e22
// Size: 0x66
function playerputinc130( c130 )
{
    self.angles = c130.angles;
    thread listenjump( c130 );
    thread br_c130::listenkick( c130, 0 );
    self.c130 = level.gulag.ac130;
    self.br_infil_type = "c130";
    thread br_c130::orbitcam( c130 );
}

// Namespace br_gulag
// Params 1
// Checksum 0x883bdfb1, Offset: 0x11e90
// Size: 0x75
function listenjump( c130 )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    self endon( #"cancel_c130" );
    self endon( #"br_jump" );
    self.redeployenabled = 0;
    utility::waittill_any( "halo_jump_c130", "halo_jump_solo_c130" );
    self.jumptype = "solo";
    thread br_c130::leaveplane( c130, 0, self getplayerangles(), 0 );
}

// Namespace br_gulag
// Params 0
// Checksum 0x454df36d, Offset: 0x11f0d
// Size: 0x3c
function playerspawnprotectionac130()
{
    self endon( #"death_or_disconnect" );
    self.plotarmor = 1;
    br_c130::setplayervarinrespawnc130( 1 );
    waittillplayerdoneskydivingac130( self );
    self.plotarmor = undefined;
    br_c130::setplayervarinrespawnc130( 0 );
}

// Namespace br_gulag
// Params 1
// Checksum 0x18d8b513, Offset: 0x11f51
// Size: 0x49
function waittillplayerdoneskydivingac130( player )
{
    player endon( #"hash_c40dcee027ae8978" );
    thread _waittillplayerdoneskydivingac130timeout( player );
    player waittill( #"infil_jump_done" );
    
    while ( !player isparachuting() && !player isonground() )
    {
        waitframe();
    }
}

// Namespace br_gulag
// Params 1
// Checksum 0x52e652fe, Offset: 0x11fa2
// Size: 0x4b
function _waittillplayerdoneskydivingac130timeout( player )
{
    player endon( #"death_or_disconnect" );
    player utility::waittill_any_timeout( getdvarint( @"hash_8780b8778180d47c", 15 ), "halo_kick_c130", "halo_jump_solo_c130" );
    wait 15;
    player notify( #"hash_c40dcee027ae8978" );
}

// Namespace br_gulag
// Params 0
// Checksum 0xa67459e6, Offset: 0x11ff5
// Size: 0x68
function playerautodeployaftertime()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    self endon( #"disconnect" );
    self endon( #"cancel_c130" );
    self endon( #"br_jump" );
    wait getdvarint( @"hash_8780b8778180d47c", 15 );
    self.jumptype = "solo";
    self notify( #"halo_kick_c130" );
}

// Namespace br_gulag
// Params 0
// Checksum 0x376d31a2, Offset: 0x12065
// Size: 0xd3
function playerac130cleanup()
{
    level endon( #"game_ended" );
    utility::waittill_any( "disconnect", "death", "cancel_c130", "infil_jump_done" );
    
    if ( !isdefined( level.gulag.ac130.riders ) )
    {
        return;
    }
    
    if ( isdefined( self ) )
    {
        level.gulag.ac130.riders = arrayremove( level.gulag.ac130.riders, self );
        return;
    }
    
    level.gulag.ac130.riders = function_5713d46873b29625( level.gulag.ac130.riders );
}

// Namespace br_gulag
// Params 10
// Checksum 0x23738eb1, Offset: 0x12140
// Size: 0x363
function playergulagautowin( context, sponsor, tokenused, var_350c06308cd3d7e3, var_ec22479f7c93f2e0, var_32ae392479866916, var_7bf158c6738dc0ea, var_fc49d709b55e5de7, var_574bfd1851c0264b, var_91eaeba508b003a5 )
{
    player = self;
    level endon( #"game_ended" );
    player endon( #"disconnect" );
    player notify( #"gulag_auto_win" );
    level endon( #"cancel_respawn" );
    
    if ( player.respawningfromtoken )
    {
        return;
    }
    
    if ( br_twotwo_gulag::function_a826a6e753a74909() && namespace_a8afdcd7738e364e::function_3d1f225aa0b4d926( "gulagWinSequence" ) )
    {
        if ( !isdefined( var_fc49d709b55e5de7 ) )
        {
            var_fc49d709b55e5de7 = "br_twotwo_gulag_win";
        }
        
        player namespace_a8afdcd7738e364e::function_2af099d01df1a89c( "gulagWinSequence", self.arena, var_fc49d709b55e5de7 );
    }
    
    player.respawningfromtoken = 1;
    player.var_9132049fb3d1b450 = tokenused;
    player.respawnpoint = var_574bfd1851c0264b;
    gametyperesult = utility::callsharedfunc( #"gametype", #"hash_1de385892cb526fe", sponsor, tokenused );
    [ var_313fb092441483ee, analyticsevent ] = player br_spawnrespawn::playerhandlesponsor( sponsor, player.var_9132049fb3d1b450, var_ec22479f7c93f2e0, var_350c06308cd3d7e3, var_32ae392479866916, context );
    var_17f3151ec6647b00 = undefined;
    
    if ( !gametyperesult )
    {
        var_17f3151ec6647b00 = 1;
    }
    
    var_4b2efbbf9066123b = undefined;
    
    if ( !isdefined( sponsor ) && !var_350c06308cd3d7e3 )
    {
        var_4b2efbbf9066123b = 4;
    }
    
    if ( context == "kioskRevivePlayer" )
    {
        br_public::brleaderdialogplayer( "gulag_buyback", self, 0, 1 );
    }
    
    gulagskipped = 1;
    var_b006b462cca49b6e = 1;
    respawnstruct = function_3cbf7cd6bf743875( gulagskipped, analyticsevent, var_b006b462cca49b6e, var_313fb092441483ee, var_ec22479f7c93f2e0, undefined, var_91eaeba508b003a5, var_4b2efbbf9066123b, undefined, var_7bf158c6738dc0ea, tokenused );
    player.var_1be091ba55db848e = context ?? "gulag_auto_win";
    br_spawnrespawn::br_doingrespawn( var_17f3151ec6647b00, respawnstruct, player.respawnpoint );
    
    if ( isdefined( level.gulag.arenas ) && ( context == "jailbreak" || context == "phoenix" ) )
    {
        foreach ( arena in level.gulag.arenas )
        {
            if ( arraycontains( arena.jailedplayers, self ) )
            {
                arena.jailedplayers = arrayremove( arena.jailedplayers, self );
                break;
            }
        }
        
        player.placementstatsset = undefined;
        player.processlobbydataforclient = undefined;
        player.brbonusxpallowed = undefined;
        player.br_spectatorinitialized = undefined;
        player setclientomnvar( "ui_br_player_position", 155 );
        player setclientomnvar( "ui_br_squad_eliminated_active", 0 );
        player setclientomnvar( "ui_round_end_title", 0 );
        player setclientomnvar( "ui_round_end_reason", 0 );
    }
}

// Namespace br_gulag
// Params 0
// Checksum 0x6a77e68e, Offset: 0x124ab
// Size: 0x23
function gulaginitloadouts()
{
    level.gulag.jailloadout = creategulagjailloadout();
    function_8eecf8354e7a0b83();
}

// Namespace br_gulag
// Params 0
// Checksum 0xaea30e7e, Offset: 0x124d6
// Size: 0x194
function creategulagjailloadout()
{
    loadout = [];
    loadout[ "loadoutArchetype" ] = "archetype_assault";
    loadout[ "loadoutPrimary" ] = weapon::getweaponrootname( level.defaultfist );
    loadout[ "loadoutPrimaryAttachment" ] = "none";
    loadout[ "loadoutPrimaryAttachment2" ] = "none";
    loadout[ "loadoutPrimaryCamo" ] = "none";
    loadout[ "loadoutPrimaryReticle" ] = "none";
    loadout[ "loadoutSecondary" ] = "none";
    loadout[ "loadoutSecondaryAttachment" ] = "none";
    loadout[ "loadoutSecondaryAttachment2" ] = "none";
    loadout[ "loadoutSecondaryCamo" ] = "none";
    loadout[ "loadoutSecondaryReticle" ] = "none";
    loadout[ "loadoutMeleeSlot" ] = "none";
    
    if ( !br_ai_gulag::function_43645d97a69e494f() || br_ai_gulag::function_f97a5a833d374932() )
    {
        primaryequipment = "equip_rock";
        
        if ( isdefined( level.var_5a2fc0b77a98b634 ) )
        {
            primaryequipment = level.var_5a2fc0b77a98b634;
        }
        
        loadout[ "loadoutEquipmentPrimary" ] = primaryequipment;
    }
    else
    {
        loadout[ "loadoutEquipmentPrimary" ] = "none";
    }
    
    loadout[ "loadoutEquipmentSecondary" ] = "none";
    loadout[ "loadoutStreakType" ] = "assault";
    loadout[ "loadoutKillstreak1" ] = "none";
    loadout[ "loadoutKillstreak2" ] = "none";
    loadout[ "loadoutKillstreak3" ] = "none";
    loadout[ "loadoutSuper" ] = "super_br_extract";
    loadout[ "loadoutPerks" ] = [ "specialty_null" ];
    loadout[ "loadoutGesture" ] = "playerData";
    loadout[ "loadoutExecution" ] = "none";
    loadout[ #"disablebackuppistol" ] = 1;
    return loadout;
}

// Namespace br_gulag
// Params 0
// Checksum 0x444eefdd, Offset: 0x12673
// Size: 0x158
function function_8eecf8354e7a0b83()
{
    level.gulagloadouts = [];
    level.gulagloadouttable = choosegulagloadouttable();
    
    if ( getdvar( @"hash_6ef30f04f9851a88", "" ) != "" )
    {
        debugloadouts = strtok( getdvar( @"hash_6ef30f04f9851a88" ), " " );
        intloadouts = [];
        
        for ( debugindex = 0; debugindex < debugloadouts.size ; debugindex++ )
        {
            intloadouts[ intloadouts.size ] = int( debugloadouts[ intloadouts.size ] );
        }
        
        var_2f4e6505b731029a = intloadouts.size;
        
        for ( classindex = 0; classindex < var_2f4e6505b731029a ; classindex++ )
        {
            level.gulagloadouts[ level.gulagloadouts.size ] = creategulagarenaloadout( intloadouts[ classindex ] );
            assert( level.gulagloadouts[ level.gulagloadouts.size ][ "<dev string:x223>" ] != "<dev string:x232>", "<dev string:x233>" );
        }
    }
    else
    {
        var_2f4e6505b731029a = class::function_868832c7872f848e( level.gulagloadouttable ) - 1;
        
        for ( classindex = 0; classindex < var_2f4e6505b731029a ; classindex++ )
        {
            level.gulagloadouts[ level.gulagloadouts.size ] = creategulagarenaloadout( classindex );
        }
    }
    
    if ( getdvarint( @"bg_weaponautograboptionsenabled", 0 ) )
    {
        br_pickups::function_5deb3a9e5c2a953f();
    }
}

// Namespace br_gulag
// Params 0
// Checksum 0xbbb0f22c, Offset: 0x127d3
// Size: 0x11f
function choosegulagloadouttable()
{
    tablenum = 1;
    classtables = class::function_8cc2758f17a3d70a( #"gulag" );
    var_158c9933ae9554ae = randomint( 1337 ) + 1;
    
    if ( var_158c9933ae9554ae == 1337 )
    {
        tablenum = 0;
    }
    else
    {
        tablenum = getdvarint( @"hash_a828e8ac5187f4d4", 0 );
        
        if ( tablenum == 0 )
        {
            tablecheck = randomint( 100 ) + 1;
            
            if ( tablecheck > 90 )
            {
                tablenum = 4;
            }
            else if ( tablecheck > 65 )
            {
                tablenum = 2;
            }
            else if ( tablecheck > 40 )
            {
                tablenum = 3;
            }
            else
            {
                tablenum = 1;
            }
        }
    }
    
    if ( isdefined( level.gametypebundle.var_14a374941dd4696c[ tablenum ].bundle ) )
    {
        loadouttable = level.gametypebundle.var_14a374941dd4696c[ tablenum ].bundle;
    }
    
    if ( !isdefined( loadouttable ) )
    {
        assertmsg( "<dev string:x27c>" + tablenum + "<dev string:x2b6>" );
        loadouttable = level.classtablename;
    }
    
    return loadouttable;
}

// Namespace br_gulag
// Params 1
// Checksum 0xd454cb0b, Offset: 0x128fb
// Size: 0x53a
function creategulagarenaloadout( classindex )
{
    loadout[ "loadoutArchetype" ] = "archetype_assault";
    loadout[ "loadoutPrimary" ] = class::table_getitem( level.gulagloadouttable, classindex ).primaryweapon.weapon;
    loadout[ "loadoutPrimaryAttachment" ] = class::table_getitem( level.gulagloadouttable, classindex ).primaryweapon.attachment1;
    loadout[ "loadoutPrimaryAttachment2" ] = class::table_getitem( level.gulagloadouttable, classindex ).primaryweapon.attachment2;
    loadout[ "loadoutPrimaryAttachment3" ] = class::table_getitem( level.gulagloadouttable, classindex ).primaryweapon.attachment3;
    loadout[ "loadoutPrimaryAttachment4" ] = class::table_getitem( level.gulagloadouttable, classindex ).primaryweapon.attachment4;
    loadout[ "loadoutPrimaryAttachment5" ] = class::table_getitem( level.gulagloadouttable, classindex ).primaryweapon.attachment5;
    loadout[ "loadoutPrimaryCamo" ] = class::table_getitem( level.gulagloadouttable, classindex ).primaryweapon.camo;
    loadout[ "loadoutPrimaryReticle" ] = class::table_getitem( level.gulagloadouttable, classindex ).primaryweapon.reticle;
    loadout[ "loadoutSecondary" ] = class::table_getitem( level.gulagloadouttable, classindex ).secondaryweapon.weapon;
    loadout[ "loadoutSecondaryAttachment" ] = class::table_getitem( level.gulagloadouttable, classindex ).secondaryweapon.attachment1;
    loadout[ "loadoutSecondaryAttachment2" ] = class::table_getitem( level.gulagloadouttable, classindex ).secondaryweapon.attachment2;
    loadout[ "loadoutSecondaryAttachment3" ] = class::table_getitem( level.gulagloadouttable, classindex ).secondaryweapon.attachment3;
    loadout[ "loadoutSecondaryAttachment4" ] = class::table_getitem( level.gulagloadouttable, classindex ).secondaryweapon.attachment4;
    loadout[ "loadoutSecondaryAttachment5" ] = class::table_getitem( level.gulagloadouttable, classindex ).secondaryweapon.attachment5;
    loadout[ "loadoutSecondaryCamo" ] = class::table_getitem( level.gulagloadouttable, classindex ).secondaryweapon.camo;
    loadout[ "loadoutSecondaryReticle" ] = class::table_getitem( level.gulagloadouttable, classindex ).secondaryweapon.reticle;
    loadout[ "loadoutTertiary" ] = class::table_getitem( level.gulagloadouttable, classindex ).tertiaryWeapon.weapon;
    loadout[ "loadoutTertiaryCamo" ] = class::table_getitem( level.gulagloadouttable, classindex ).tertiaryWeapon.camo;
    loadout[ "loadoutTertiaryReticle" ] = class::table_getitem( level.gulagloadouttable, classindex ).tertiaryWeapon.reticle;
    loadout[ "loadoutMeleeSlot" ] = "none";
    loadout[ "loadoutEquipmentPrimary" ] = class::table_getitem( level.gulagloadouttable, classindex ).equipment.primary;
    loadout[ "loadoutEquipmentSecondary" ] = class::table_getitem( level.gulagloadouttable, classindex ).equipment.secondary;
    loadout[ "loadoutStreakType" ] = "assault";
    loadout[ "loadoutKillstreak1" ] = "none";
    loadout[ "loadoutKillstreak2" ] = "none";
    loadout[ "loadoutKillstreak3" ] = "none";
    loadout[ "loadoutSuper" ] = "super_br_extract";
    loadout[ "loadoutPerks" ] = [ class::table_getitem( level.gulagloadouttable, classindex ).perks.perk1, class::table_getitem( level.gulagloadouttable, classindex ).perks.perk2, class::table_getitem( level.gulagloadouttable, classindex ).perks.perk3, class::table_getitem( level.gulagloadouttable, classindex ).extraperks.perk1, class::table_getitem( level.gulagloadouttable, classindex ).extraperks.perk2, class::table_getitem( level.gulagloadouttable, classindex ).extraperks.perk3 ];
    loadout[ "loadoutGesture" ] = "playerData";
    loadout[ "tableColumn" ] = classindex;
    return loadout;
}

// Namespace br_gulag
// Params 2
// Checksum 0x2dd6ea4c, Offset: 0x12e3e
// Size: 0x2e7
function playergivearenaloadout( arena, loadoutindex )
{
    if ( getdvarint( @"hash_f97d261e2f377ad9", 1 ) == 0 )
    {
        return;
    }
    
    throttle::throttle_wait_in_queue( level.gulag.playergivearenaloadoutthrottle, self );
    
    if ( function_bc6aa264f5495083( "getArenaLoadout", arena ) )
    {
    }
    else if ( namespace_a8afdcd7738e364e::function_3d1f225aa0b4d926( "getArenaLoadout" ) )
    {
        self.pers[ "gamemodeLoadout" ] = namespace_a8afdcd7738e364e::function_2af099d01df1a89c( "getArenaLoadout", arena );
    }
    else
    {
        self.pers[ "gamemodeLoadout" ] = level.gulagloadouts[ loadoutindex ];
        checkforarenaloadoutoverride( loadoutindex );
    }
    
    self.class = "gamemode";
    self.prevweaponobj = undefined;
    self.var_8cf9648fae56099c = undefined;
    
    /#
        if ( getdvarint( @"hash_9144df4be848d0b7", 1 ) )
        {
            if ( isdefined( self.values ) )
            {
                allowmovementvalues = self.values[ "<dev string:x2e8>" ];
                
                if ( isdefined( allowmovementvalues ) )
                {
                    foreach ( value in allowmovementvalues )
                    {
                        if ( isdefined( value ) && isdefined( value.value ) && isdefined( value.str_id ) )
                        {
                            function_cbb2b688a1afe748( self, "<dev string:x2f7>" + value.str_id, value.value );
                        }
                    }
                }
            }
        }
    #/
    
    struct = class::loadout_getclassstruct();
    struct = class::loadout_updateclass( struct, "gamemode", 1 );
    class::preloadandqueueclassstruct( struct, 1, 1 );
    giveloadoutoptions = { #throttle:getdvarint( @"hash_2921299c7a1e73cb", 1 ) };
    class::giveloadout( self.team, "gamemode", 0, 0, undefined, undefined, undefined, undefined, giveloadoutoptions );
    
    if ( function_e0c6f0f4b4c6f556( "shouldGiveMaxAmmoPrimary", arena ) )
    {
        self givemaxammo( struct.loadoutprimaryobject );
    }
    else
    {
        self givestartammo( struct.loadoutprimaryobject );
    }
    
    if ( isdefined( struct.loadoutsecondaryobject ) )
    {
        if ( function_e0c6f0f4b4c6f556( "shouldGiveMaxAmmoSecondary", arena ) )
        {
            self givemaxammo( struct.loadoutsecondaryobject );
        }
        else
        {
            self givestartammo( struct.loadoutsecondaryobject );
        }
    }
    
    if ( !namespace_a8afdcd7738e364e::function_3d1f225aa0b4d926( "getArenaLoadout" ) )
    {
        self.gulagloadoutindex = level.gulagloadouts[ loadoutindex ][ "tableColumn" ];
        playersetomnvargulag( arena, "loadoutRow", self.gulagloadoutindex );
    }
}

// Namespace br_gulag
// Params 1
// Checksum 0xec7a455, Offset: 0x1312d
// Size: 0x277
function checkforarenaloadoutoverride( loadoutindex )
{
    if ( getdvarint( @"scr_br_alt_mode_gg", 0 ) )
    {
        switch ( loadoutindex )
        {
            case 0:
                primary = "iw8_pi_decho";
                break;
            case 1:
                primary = "iw8_pi_cpapa";
                break;
            case 2:
                primary = "iw8_pi_decho";
                break;
            case 3:
                primary = "iw8_pi_cpapa";
                break;
            case 4:
                primary = "iw8_pi_decho";
                break;
            case 5:
                primary = "iw8_pi_cpapa";
                break;
            case 6:
                primary = "iw8_pi_decho";
                break;
            case 7:
                primary = "iw8_pi_cpapa";
                break;
            case 8:
                primary = "iw8_pi_decho";
                break;
            case 9:
            default:
                primary = "iw8_pi_cpapa";
                break;
        }
        
        self.pers[ "gamemodeLoadout" ][ "loadoutPrimary" ] = primary;
        self.pers[ "gamemodeLoadout" ][ "loadoutPrimaryAttachment" ] = "none";
        self.pers[ "gamemodeLoadout" ][ "loadoutPrimaryAttachment2" ] = "none";
        self.pers[ "gamemodeLoadout" ][ "loadoutPrimaryAttachment3" ] = "none";
        self.pers[ "gamemodeLoadout" ][ "loadoutPrimaryAttachment4" ] = "none";
        self.pers[ "gamemodeLoadout" ][ "loadoutPrimaryAttachment5" ] = "none";
        self.pers[ "gamemodeLoadout" ][ "loadoutSecondary" ] = "none";
        self.pers[ "gamemodeLoadout" ][ "loadoutSecondaryAttachment" ] = "none";
        self.pers[ "gamemodeLoadout" ][ "loadoutSecondaryAttachment2" ] = "none";
        self.pers[ "gamemodeLoadout" ][ "loadoutSecondaryAttachment3" ] = "none";
        self.pers[ "gamemodeLoadout" ][ "loadoutSecondaryAttachment4" ] = "none";
        self.pers[ "gamemodeLoadout" ][ "loadoutSecondaryAttachment5" ] = "none";
        self.pers[ "gamemodeLoadout" ][ "loadoutPerks" ] = [ "specialty_null" ];
    }
}

// Namespace br_gulag
// Params 0
// Checksum 0x9a50ef48, Offset: 0x133ac
// Size: 0xd6
function getloadoutindex()
{
    if ( getdvarint( @"hash_f97d261e2f377ad9", 1 ) == 0 )
    {
        return;
    }
    
    overrideindex = getdvarint( @"hash_4f38b76441d4b900", -1 );
    
    if ( overrideindex > -1 && overrideindex < level.gulagloadouts.size )
    {
        return overrideindex;
    }
    
    if ( getdvar( @"hash_6ef30f04f9851a88", "" ) != "" )
    {
        if ( !isdefined( level.gulagloadoutindex ) || level.gulagloadoutindex >= level.gulagloadouts.size )
        {
            level.gulagloadoutindex = 0;
        }
        
        index = level.gulagloadoutindex;
        level.gulagloadoutindex += 1;
    }
    else
    {
        index = randomint( level.gulagloadouts.size );
    }
    
    return index;
}

// Namespace br_gulag
// Params 1
// Checksum 0x33d0efe2, Offset: 0x1348b
// Size: 0x10b
function function_4c234c9fbc265274( arena )
{
    arena endon( #"fight_over" );
    arena endon( #"matchended" );
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    oldtimelimit = level.gulag.timelimit;
    level.gulag.timelimit = 180;
    iprintln( "Loadout verification starting in 3 seconds." );
    wait 3;
    iprintln( "Verification start!" );
    
    for ( testindex = 0; testindex < level.gulagloadouts.size ; testindex++ )
    {
        iprintln( "Loadout: " + testindex );
        playergivearenaloadout( arena, testindex );
        wait 5;
        inventory_utility::_switchtoweapon( self.secondaryweapon );
        wait 4;
    }
    
    playergivearenaloadout( arena, 0 );
    level.gulag.timelimit = oldtimelimit;
    iprintln( "Verification done!" );
}

// Namespace br_gulag
// Params 1
// Checksum 0x29e122d1, Offset: 0x1359e
// Size: 0x2d6
function setupdomendflag( arena )
{
    if ( br_ai_gulag::function_43645d97a69e494f() )
    {
        flaglocation = getgroundposition( arena.center + ( 0, 530, 0 ), 1 );
        
        if ( isdefined( arena.var_db8b40804defedb ) )
        {
            flaglocation = getgroundposition( arena.var_db8b40804defedb, 1 );
        }
        
        domradius = getdvarint( @"scr_br_fc_flag_radius", 450 );
        groundorg = flaglocation;
    }
    else if ( br_twotwo_gulag::function_a826a6e753a74909() )
    {
        flaglocation = getgroundposition( arena.center, 1 );
        
        if ( isdefined( arena.var_db8b40804defedb ) )
        {
            flaglocation = getgroundposition( arena.var_db8b40804defedb, 1 );
        }
        
        domradius = arena.var_31f430f8486e17d5 ?? getdvarint( @"scr_br_fc_flag_radius", 82 );
        groundorg = flaglocation;
    }
    else
    {
        domradius = getdvarint( @"scr_br_fc_flag_radius", 50 );
        groundorg = getgroundposition( arena.center, 1 );
    }
    
    arena.dom = spawnstruct();
    arena.dom.trigger = spawn( "trigger_radius", groundorg, 0, int( domradius ), int( level.br_domheight ) );
    arena.dom.trigger.objectivekey = "_a";
    arenaflag = obj_dom::setupobjective( arena.dom.trigger, "neutral", undefined, 1 );
    arenaflag.onuse = &arenaflag_onuse;
    arenaflag.onbeginuse = &arenaflag_onusebegin;
    arenaflag.onenduse = &arenaflag_onuseend;
    arenaflag.onuseupdate = &arenaflag_onuseupdate;
    arenaflag.oncontested = &arenaflag_oncontested;
    arenaflag.onuncontested = &arenaflag_onuncontested;
    arenaflag.isarena = 1;
    arenaflag gameobjects::pinobjiconontriggertouch();
    arenaflag.id = "domFlag";
    
    if ( br_ai_gulag::function_43645d97a69e494f() )
    {
        arenaflag gameobjects::setcapturebehavior( "all_teams_dom_together" );
    }
    else
    {
        arenaflag gameobjects::setcapturebehavior( "persistent" );
    }
    
    arenaflag.scriptable delete();
    arenaflag.ignorestomp = 1;
    arenaflag gameobjects::requestid( 0, 1, undefined, 0, 0 );
    arenaflag.visibilitymanuallycontrolled = 1;
    arenaflag arenaflag_setenabled( 0 );
    arenaflag arenaflag_setvisible( arena, 0 );
    arenaflag.arena = arena;
    arena.dom.arenaflag = arenaflag;
}

// Namespace br_gulag
// Params 1
// Checksum 0xc3686719, Offset: 0x1387c
// Size: 0xb4
function domgulagsounds( arena )
{
    wait 1;
    
    if ( isdefined( arena ) && isdefined( arena.dom ) && isdefined( arena.dom.arenaflag ) && isdefined( arena.dom.arenaflag.flagmodel ) )
    {
        if ( isstring( "" ) && "" != "" && soundexists( "" ) )
        {
            arena.dom.arenaflag.flagmodel playloopsound( "" );
        }
    }
}

// Namespace br_gulag
// Params 1
// Checksum 0xf0f133d7, Offset: 0x13938
// Size: 0x53
function arenaflag_setenabled( enable )
{
    if ( enable )
    {
        gameobjects::allowuse( "any" );
        self.trigger utility::trigger_on();
        return;
    }
    
    gameobjects::allowuse( "none" );
    self.trigger utility::trigger_off();
    gameobjects::resetcaptureprogress();
}

// Namespace br_gulag
// Params 4
// Checksum 0x3ce098e, Offset: 0x13993
// Size: 0xc1
function arenaflag_setvisible( arena, enable, preview, skipunpin )
{
    self notify( #"hash_ea5ae498af7e1ff1" );
    
    if ( enable )
    {
        icon = "waypoint_captureneutral";
        
        if ( preview )
        {
            icon = level.iconovertime;
        }
        
        thread arenaflag_objectiveshow( arena );
        thread gameobjects::setobjectivestatusicons( icon );
        thread gameobjects::setownerteam( "neutral" );
        thread obj_dom::updateflagstate( "idle", 0, "none" );
        self.flagmodel show();
        thread arenaflag_showflagoutline( arena, 1 );
        
        if ( !preview )
        {
            setovertimeomnvarenabled( arena, 1 );
        }
        
        return;
    }
    
    thread arenaflag_setvisibledisableinternal( arena, preview, skipunpin );
}

// Namespace br_gulag
// Params 3
// Checksum 0x30f78026, Offset: 0x13a5c
// Size: 0x9a
function arenaflag_setvisibledisableinternal( arena, preview, skipunpin )
{
    self endon( #"hash_ea5ae498af7e1ff1" );
    
    if ( !skipunpin )
    {
        objective_setpinned( self.objidnum, 0 );
        wait 1;
    }
    
    function_c2ad80fb44599224( arena );
    thread arenaflag_showflagoutline( arena, 0 );
    thread arenaflag_objectivehide( skipunpin );
    thread obj_dom::updateflagstate( "off", 0, "none" );
    self.flagmodel hide( 1 );
    
    if ( !preview )
    {
        setovertimeomnvarenabled( arena, 0 );
        setovertimeomnvarprogress( arena, 0 );
    }
}

// Namespace br_gulag
// Params 2
// Checksum 0x29874f87, Offset: 0x13afe
// Size: 0x82
function arenaflag_setvisibleplayer( enable, player )
{
    player endon( #"death_or_disconnect" );
    
    if ( enable )
    {
        player setclientomnvar( "ui_overtime_timer_show", 1 );
        objective_addclienttomask( self.objidnum, player );
    }
    else
    {
        objective_unpinforclient( self.objidnum, player );
        wait 1;
        player setclientomnvar( "ui_overtime_timer_show", 0 );
        objective_removeclientfrommask( self.objidnum, player );
    }
    
    thread arenaflag_showflagoutlineplayer( enable, player );
}

// Namespace br_gulag
// Params 2
// Checksum 0x4c4e0f25, Offset: 0x13b88
// Size: 0x33
function arenaflag_previewflag( arena, time )
{
    thread arenaflag_setvisible( arena, 1, 1 );
    wait time;
    thread arenaflag_setvisible( arena, 0, 1, 1 );
}

// Namespace br_gulag
// Params 1
// Checksum 0xdba4bc54, Offset: 0x13bc3
// Size: 0x122
function arenaflag_objectiveshow( arena )
{
    objective_removeallfrommask( self.objidnum );
    
    foreach ( player in arena.jailedplayers )
    {
        objective_addclienttomask( self.objidnum, player );
    }
    
    foreach ( player in arena.arenaplayers )
    {
        objective_addclienttomask( self.objidnum, player );
    }
    
    objective_showtoplayersinmask( self.objidnum );
}

// Namespace br_gulag
// Params 1
// Checksum 0x99a3c86d, Offset: 0x13ced
// Size: 0x37
function arenaflag_objectivehide( skipunpin )
{
    objective_setshowprogress( self.objidnum, 0 );
    objective_removeallfrommask( self.objidnum );
    objective_showtoplayersinmask( self.objidnum );
}

// Namespace br_gulag
// Params 2
// Checksum 0x65dac202, Offset: 0x13d2c
// Size: 0xe4
function arenaflag_showflagoutline( arena, enable )
{
    if ( enable )
    {
        if ( arena.jailedplayers.size > 0 )
        {
            self.flagmodel hudoutlineenableforclients( arena.jailedplayers, "outline_nodepth_orange" );
        }
        
        if ( arena.arenaplayers.size > 0 )
        {
            self.flagmodel hudoutlineenableforclients( arena.arenaplayers, "outline_nodepth_orange" );
            self.flagmodel setentityhudoutlinedata( 1, "team_hundred_fifty_one" );
        }
        
        return;
    }
    
    if ( arena.jailedplayers.size > 0 )
    {
        self.flagmodel hudoutlinedisableforclients( arena.jailedplayers );
    }
    
    if ( arena.arenaplayers.size > 0 )
    {
        self.flagmodel hudoutlinedisableforclients( arena.arenaplayers );
    }
}

// Namespace br_gulag
// Params 2
// Checksum 0x150f5301, Offset: 0x13e18
// Size: 0x42
function arenaflag_showflagoutlineplayer( enable, player )
{
    if ( enable )
    {
        self.flagmodel hudoutlineenableforclient( player, "outline_nodepth_orange" );
        return;
    }
    
    self.flagmodel hudoutlinedisableforclient( player );
}

// Namespace br_gulag
// Params 1
// Checksum 0xe1fb4a15, Offset: 0x13e62
// Size: 0x1e4
function arenaflag_onusebegin( player )
{
    if ( br_ai_gulag::function_43645d97a69e494f() )
    {
        flag_capture_time = getdvarfloat( @"scr_br_fc_flag_capture_time", 12 );
    }
    else if ( br_twotwo_gulag::function_a826a6e753a74909() )
    {
        flag_capture_time = getdvarfloat( @"scr_br_fc_flag_capture_time", 4 );
    }
    else
    {
        flag_capture_time = getdvarfloat( @"scr_br_fc_flag_capture_time", 3 );
    }
    
    player.iscapturing = 1;
    ownerteam = gameobjects::getownerteam();
    
    if ( ownerteam == "neutral" )
    {
        player setclientomnvar( "ui_objective_pinned_text_param", 1 );
    }
    
    self.neutralizing = level.flagneutralization && ownerteam != "neutral";
    
    if ( !self.neutralized )
    {
        self.didstatusnotify = 0;
    }
    
    usetime = flag_capture_time;
    gameobjects::setusetime( usetime );
    
    if ( level.capturedecay )
    {
        thread gameobjects::useobjectdecay( player.team );
    }
    
    if ( usetime > 0 )
    {
        foreach ( arenaplayer in self.arena.arenaplayers )
        {
            if ( arenaplayer != player && arenaplayer.team != player.team )
            {
                self.prevownerteam = arenaplayer.team;
                break;
            }
        }
        
        obj_dom::updateflagcapturestate( player.team );
        gameobjects::setobjectivestatusicons( "waypoint_losing", "waypoint_taking" );
    }
}

// Namespace br_gulag
// Params 4
// Checksum 0x8eb96f57, Offset: 0x1404e
// Size: 0x51
function arenaflag_onuseupdate( team, progress, change, capplayer )
{
    if ( progress > 0.05 && change && !self.didstatusnotify )
    {
        self.didstatusnotify = 1;
    }
}

// Namespace br_gulag
// Params 3
// Checksum 0x7ab5fcd5, Offset: 0x140a7
// Size: 0xf4
function arenaflag_onuseend( team, player, success )
{
    if ( br_ai_gulag::function_43645d97a69e494f() && isdefined( player ) && success )
    {
        player thread hud_message::showsplash( "br_ai_gulag_overtime_end" );
    }
    
    self.didstatusnotify = 0;
    
    if ( success )
    {
        objidpoolmanager::objective_show_progress( self.objidnum, 0 );
    }
    
    if ( isplayer( player ) )
    {
        player.iscapturing = 0;
        player setclientomnvar( "ui_objective_pinned_text_param", 0 );
        player.ui_dom_securing = undefined;
    }
    
    ownerteam = gameobjects::getownerteam();
    
    if ( ownerteam == "neutral" )
    {
        gameobjects::setobjectivestatusicons( "waypoint_captureneutral" );
        thread obj_dom::updateflagstate( "idle", 0 );
    }
    else
    {
        gameobjects::setobjectivestatusicons( "waypoint_defend", "waypoint_capture" );
        thread obj_dom::updateflagstate( ownerteam, 0 );
    }
    
    if ( !success )
    {
        self.neutralized = 0;
    }
}

// Namespace br_gulag
// Params 2
// Checksum 0x51e83c3a, Offset: 0x141a3
// Size: 0x15a
function arenaflag_setcaptured( team, credit_player )
{
    gameobjects::setownerteam( team );
    self notify( #"capture", credit_player );
    self notify( #"assault", credit_player );
    gameobjects::setobjectivestatusicons( "waypoint_defending", "waypoint_capture" );
    self.neutralized = 0;
    thread obj_dom::updateflagstate( team, 0, team );
    
    if ( self.touchlist[ team ].size == 0 && isdefined( self.oldtouchlist ) )
    {
        self.touchlist = self.oldtouchlist;
    }
    
    foreach ( arenaplayer in self.arena.arenaplayers )
    {
        if ( arenaplayer != credit_player && arenaplayer.team != team && isdefined( self.assisttouchlist[ arenaplayer.team ] ) )
        {
            self.assisttouchlist[ arenaplayer.team ] = [];
            break;
        }
    }
}

// Namespace br_gulag
// Params 1
// Checksum 0x4eddfda3, Offset: 0x14305
// Size: 0x160
function arenaflag_onuse( credit_player )
{
    team = credit_player.team;
    self.capturetime = gettime();
    self.neutralized = 0;
    arenaflag_setcaptured( team, credit_player );
    
    if ( !self.neutralized && !br_ai_gulag::function_43645d97a69e494f() )
    {
        foreach ( player in self.arena.arenaplayers )
        {
            if ( isalive( player ) && player.team != team )
            {
                if ( namespace_a8afdcd7738e364e::function_373b8665fd6de550() )
                {
                    player thread gulagplayerlost( self.arena, "br_twotwo_gulag_lost_flag", 1 );
                    continue;
                }
                
                player thread gulagplayerlost( self.arena );
            }
        }
        
        thread handleendarena( self.arena );
        
        if ( namespace_a8afdcd7738e364e::function_373b8665fd6de550() )
        {
            credit_player br_twotwo_gulag::gulagtwotwo_victorysequence( self.arena, "br_twotwo_gulag_win_flag" );
        }
        
        self.firstcapture = 0;
    }
}

// Namespace br_gulag
// Params 0
// Checksum 0xeb5577c0, Offset: 0x1446d
// Size: 0x2c
function arenaflag_oncontested()
{
    gameobjects::setobjectivestatusicons( "waypoint_contested" );
    objidpoolmanager::objective_set_progress_team( self.objidnum, undefined );
    thread obj_dom::updateflagstate( "contested", 0 );
}

// Namespace br_gulag
// Params 1
// Checksum 0x9999b5b5, Offset: 0x144a1
// Size: 0x3f
function arenaflag_onuncontested( team )
{
    if ( team == "none" || team == "neutral" )
    {
        return;
    }
    
    gameobjects::setobjectivestatusicons( "waypoint_defend", "waypoint_capture" );
    thread obj_dom::updateflagstate( team, 0 );
}

// Namespace br_gulag
// Params 2
// Checksum 0x9d12f9e9, Offset: 0x144e8
// Size: 0x2f7
function getarenaomnvarbitpackinginfo( dataref, value )
{
    bitoffset = 0;
    bitwidth = 0;
    var_48646764f8a928fa = "";
    
    switch ( dataref )
    {
        case #"hash_f5d0ab7e55587e1d":
            [ bitoffset, bitwidth, var_48646764f8a928fa ] = [ 0, 8, "ui_br_gulag_players_1" ];
            value += 1;
            break;
        case #"hash_f5d0aa7e55587c8a":
            [ bitoffset, bitwidth, var_48646764f8a928fa ] = [ 8, 8, "ui_br_gulag_players_1" ];
            value += 1;
            break;
        case #"hash_622ca631d10c4370":
            [ bitoffset, bitwidth, var_48646764f8a928fa ] = [ 16, 8, "ui_br_gulag_players_1" ];
            value += 1;
            break;
        case #"hash_622ca731d10c4503":
            [ bitoffset, bitwidth, var_48646764f8a928fa ] = [ 24, 8, "ui_br_gulag_players_1" ];
            value += 1;
            break;
        case #"hash_e89fe3aac33c10c9":
            [ bitoffset, bitwidth, var_48646764f8a928fa ] = [ 0, 8, "ui_br_gulag_data" ];
            value += 1;
            break;
        case #"hash_848cf681a543f242":
            [ bitoffset, bitwidth, var_48646764f8a928fa ] = [ 8, 9, "ui_br_gulag_data" ];
            break;
        case #"hash_848cf781a543f3d5":
            [ bitoffset, bitwidth, var_48646764f8a928fa ] = [ 17, 9, "ui_br_gulag_data" ];
            break;
        case #"hash_5c1524af3bb7c4b5":
            [ bitoffset, bitwidth, var_48646764f8a928fa ] = [ 0, 8, "ui_br_gulag_data_2" ];
            break;
        case #"hash_5c1523af3bb7c322":
            [ bitoffset, bitwidth, var_48646764f8a928fa ] = [ 8, 8, "ui_br_gulag_data_2" ];
            break;
        default:
            if ( !namespace_a8afdcd7738e364e::function_373b8665fd6de550() )
            {
                assertmsg( "<dev string:x30b>" + dataref + "<dev string:x321>" );
            }
            
            break;
    }
    
    return [ bitoffset, bitwidth, var_48646764f8a928fa, value ];
}

// Namespace br_gulag
// Params 5
// Checksum 0xab44b916, Offset: 0x147e8
// Size: 0xa8
function packarenaomnvardata( arena, var_48646764f8a928fa, value, bitoffset, bitwidth )
{
    mask = ( 1 << bitwidth ) - 1;
    shiftedvalue = ( value & mask ) << bitoffset;
    invertedmask = ~( mask << bitoffset );
    prevvalue = arena.omnvardata[ var_48646764f8a928fa ];
    cleanedbase = prevvalue & invertedmask;
    repackedvalue = cleanedbase + shiftedvalue;
    arena.omnvardata[ var_48646764f8a928fa ] = repackedvalue;
}

// Namespace br_gulag
// Params 3
// Checksum 0xfea732cf, Offset: 0x14898
// Size: 0x8b
function setarenaomnvar( arena, dataref, value )
{
    assert( isstring( dataref ) );
    [ bitoffset, bitwidth, var_48646764f8a928fa, value ] = getarenaomnvarbitpackinginfo( dataref, value );
    
    if ( var_48646764f8a928fa == "" )
    {
        return;
    }
    
    packarenaomnvardata( arena, var_48646764f8a928fa, value, bitoffset, bitwidth );
}

// Namespace br_gulag
// Params 3
// Checksum 0x831ea564, Offset: 0x1492b
// Size: 0x45
function setarenaomnvarplayertype( arena, dataref, player )
{
    entnum = -1;
    
    if ( isdefined( player ) )
    {
        entnum = player getentitynumber();
    }
    
    setarenaomnvar( arena, dataref, entnum );
}

// Namespace br_gulag
// Params 3
// Checksum 0x5c77ebdf, Offset: 0x14978
// Size: 0x49
function setarenaomnvarhealthtype( arena, dataref, player )
{
    health = 0;
    
    if ( isdefined( player ) )
    {
        health = player.health;
    }
    
    setarenaomnvar( arena, dataref, health );
}

// Namespace br_gulag
// Params 3
// Checksum 0x4b887489, Offset: 0x149c9
// Size: 0x46
function function_78a4f85efd04b789( arena, dataref, player )
{
    armor = player ? player armor::getarmorhealth() : 0;
    setarenaomnvar( arena, dataref, armor );
}

// Namespace br_gulag
// Params 1
// Checksum 0xee7911c, Offset: 0x14a17
// Size: 0x1f0
function updatearenaomnvarplayers( arena )
{
    arena.omnvardata[ "ui_br_gulag_players_1" ] = 0;
    
    if ( !namespace_a8afdcd7738e364e::function_373b8665fd6de550() )
    {
        assert( level.gulag.maxplayers == 2 );
    }
    
    for ( i = 0; i < level.gulag.maxplayers ; i++ )
    {
        player = arena.arenaplayers[ i ];
        setarenaomnvarplayertype( arena, "playerArena" + i, player );
    }
    
    nextmatch = arena.matches[ 0 ];
    
    if ( !isdefined( nextmatch ) )
    {
        nextmatch = [];
    }
    
    setarenaomnvarplayertype( arena, "playerJail0", nextmatch[ 0 ] );
    setarenaomnvarplayertype( arena, "playerJail1", nextmatch[ 1 ] );
    arenaparticipants = arraycombine( arena.jailedplayers, arena.arenaplayers );
    
    foreach ( player in arenaparticipants )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        player setclientomnvar( "ui_br_gulag_players_1", arena.omnvardata[ "ui_br_gulag_players_1" ] );
        queueposition = player.gulagposition ?? 0;
        var_d9274fc21720d875 = !isplayermatched( arena, player ) && queueposition != 0;
        
        if ( var_d9274fc21720d875 )
        {
            player setclientomnvar( "ui_br_gulag_match_state", 0 );
        }
        
        repackedvalue = var_d9274fc21720d875 | queueposition << 1;
        player setclientomnvar( "ui_br_gulag_queue_position", repackedvalue );
    }
}

// Namespace br_gulag
// Params 1
// Checksum 0x80ba3517, Offset: 0x14c0f
// Size: 0x44
function playersetgulagdataomnvar( arena )
{
    self setclientomnvar( "ui_br_gulag_data", arena.omnvardata[ "ui_br_gulag_data" ] );
    self setclientomnvar( "ui_br_gulag_data_2", arena.omnvardata[ "ui_br_gulag_data_2" ] );
}

// Namespace br_gulag
// Params 1
// Checksum 0x5366a28, Offset: 0x14c5b
// Size: 0x1a5
function updatearenaomnvardata( arena )
{
    resetarenaomnvardata( arena );
    
    if ( !namespace_a8afdcd7738e364e::function_373b8665fd6de550() )
    {
        assert( level.gulag.maxplayers == 2 );
    }
    
    for ( i = 0; i < level.gulag.maxplayers ; i++ )
    {
        player = arena.arenaplayers[ i ];
        
        if ( isdefined( player ) )
        {
            setarenaomnvarhealthtype( arena, "playerHealth" + i, player );
            function_78a4f85efd04b789( arena, "playerArmor" + i, player );
        }
    }
    
    foreach ( player in arena.jailedplayers )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        player playersetgulagdataomnvar( arena );
    }
    
    foreach ( player in arena.arenaplayers )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        player playersetarenaomnvarwithloadout( arena );
    }
}

// Namespace br_gulag
// Params 1
// Checksum 0x5c21ae27, Offset: 0x14e08
// Size: 0x32
function resetarenaomnvardata( arena )
{
    arena.omnvardata[ "ui_br_gulag_data" ] = 0;
    arena.omnvardata[ "ui_br_gulag_data_2" ] = 0;
}

// Namespace br_gulag
// Params 1
// Checksum 0x75bbcb7e, Offset: 0x14e42
// Size: 0x6c
function playersetarenaomnvarwithloadout( arena )
{
    if ( !isdefined( self.gulagloadoutindex ) )
    {
        self setclientomnvar( "ui_br_gulag_data", arena.omnvardata[ "ui_br_gulag_data" ] );
    }
    else
    {
        playersetomnvargulag( arena, "loadoutRow", self.gulagloadoutindex );
    }
    
    self setclientomnvar( "ui_br_gulag_data_2", arena.omnvardata[ "ui_br_gulag_data_2" ] );
}

// Namespace br_gulag
// Params 3
// Checksum 0x19caa46c, Offset: 0x14eb6
// Size: 0x98
function playersetomnvargulag( arena, dataref, value )
{
    assert( isplayer( self ) );
    assert( isstring( dataref ) );
    [ bitoffset, bitwidth, var_48646764f8a928fa, value ] = getarenaomnvarbitpackinginfo( dataref, value );
    
    if ( var_48646764f8a928fa == "" )
    {
        return;
    }
    
    playerpackdataintogulagomnvar( arena, var_48646764f8a928fa, value, bitoffset, bitwidth );
}

// Namespace br_gulag
// Params 5
// Checksum 0x3605bf93, Offset: 0x14f56
// Size: 0xa1
function playerpackdataintogulagomnvar( arena, var_48646764f8a928fa, value, bitoffset, bitwidth )
{
    mask = ( 1 << bitwidth ) - 1;
    shiftedvalue = ( value & mask ) << bitoffset;
    invertedmask = ~( mask << bitoffset );
    prevvalue = arena.omnvardata[ var_48646764f8a928fa ];
    cleanedbase = prevvalue & invertedmask;
    repackedvalue = cleanedbase + shiftedvalue;
    self setclientomnvar( var_48646764f8a928fa, repackedvalue );
}

// Namespace br_gulag
// Params 1
// Checksum 0xed263d24, Offset: 0x14fff
// Size: 0x1e
function updateplayeromnvarsallmatches( arena )
{
    updatearenaomnvarplayers( arena );
    updatearenaomnvardata( arena );
}

// Namespace br_gulag
// Params 1
// Checksum 0x5a151d2, Offset: 0x15025
// Size: 0xc8
function playercleargulagomnvars( arena )
{
    omnvarrefs = getarraykeys( arena.omnvardata );
    
    foreach ( var_48646764f8a928fa in omnvarrefs )
    {
        self setclientomnvar( var_48646764f8a928fa, 0 );
    }
    
    self setclientomnvar( "ui_overtime_timer", 0 );
    self setclientomnvar( "ui_overtime_timer_show", 0 );
    self setclientomnvar( "ui_match_start_countdown", 0 );
    self setclientomnvar( "ui_match_in_progress", 1 );
}

// Namespace br_gulag
// Params 2
// Checksum 0xc11fa140, Offset: 0x150f5
// Size: 0x11f
function setovertimeomnvarprogress( arena, progress )
{
    foreach ( player in arena.arenaplayers )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        player setclientomnvar( "ui_overtime_timer", progress );
    }
    
    foreach ( player in arena.jailedplayers )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        player setclientomnvar( "ui_overtime_timer", progress );
    }
}

// Namespace br_gulag
// Params 2
// Checksum 0xc88fb38, Offset: 0x1521c
// Size: 0x13d
function setovertimeomnvarenabled( arena, enabled )
{
    if ( isdefined( arena.arenaplayers ) )
    {
        foreach ( player in arena.arenaplayers )
        {
            if ( !isdefined( player ) )
            {
                continue;
            }
            
            player setclientomnvar( "ui_overtime_timer_show", enabled );
        }
    }
    
    if ( isdefined( arena.jailedplayers ) )
    {
        foreach ( player in arena.jailedplayers )
        {
            if ( !isdefined( player ) )
            {
                continue;
            }
            
            player setclientomnvar( "ui_overtime_timer_show", enabled );
        }
    }
}

// Namespace br_gulag
// Params 1
// Checksum 0x37691844, Offset: 0x15361
// Size: 0x87
function playerhealthomnvarwatcher( arena )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    self endon( #"gulag_end" );
    
    if ( !namespace_a8afdcd7738e364e::function_373b8665fd6de550() )
    {
        assert( arena.arenaplayers[ 0 ] == self || arena.arenaplayers[ 1 ] == self );
    }
    
    for ( ;; )
    {
        updatearenaomnvardata( arena );
        
        if ( self.health <= 0 )
        {
            return;
        }
        
        function_7a4a123fabe4e41a();
    }
}

// Namespace br_gulag
// Params 0
// Checksum 0xe5dd8b23, Offset: 0x153f0
// Size: 0x16
function function_7a4a123fabe4e41a()
{
    self endon( #"armor_health_update" );
    playerhealth::function_284cd76924b8c5ae( self );
}

// Namespace br_gulag
// Params 0
// Checksum 0x8d247077, Offset: 0x1540e
// Size: 0xe2
function function_6906a05d206f72ec()
{
    cinematicname = "";
    mapinfo = level.mapinfobundle ?? getmapscriptbundle();
    
    if ( mapinfo.var_288bedb0f3df96c1 )
    {
        cinematicname = mapinfo.var_288bedb0f3df96c1;
    }
    else if ( level.var_56c3cc3dc37f1728.name == "gulag_twotwo" )
    {
        if ( game_utility::function_36de887ad1f5532e() )
        {
            cinematicname = "gulag_enter_delta";
        }
        else if ( game_utility::function_d2460960855e0301() || level.mapname == "mp_br_mechanics" || level.mapname == "mp_wz2_mechanics" )
        {
            cinematicname = "wz_br_cer_gulag_s1";
        }
        else if ( level.mapname == "mp_saw_avalon" )
        {
            cinematicname = "saw_br_gulag_s3";
        }
        else
        {
            cinematicname = "mp_donetsk_gulag_intro";
        }
    }
    else
    {
        cinematicname = "mp_donetsk_gulag_intro";
    }
    
    return cinematicname;
}

// Namespace br_gulag
// Params 1
// Checksum 0x5ece96d0, Offset: 0x154f9
// Size: 0x72
function playerpreloadintrocinematic( var_b8ec1162e580ca8d )
{
    if ( level.gulag.introcinematic && !isbot( self ) )
    {
        if ( isdefined( var_b8ec1162e580ca8d ) )
        {
            self preloadcinematicforplayer( var_b8ec1162e580ca8d );
        }
        else
        {
            cinematicname = function_6906a05d206f72ec();
            self preloadcinematicforplayer( cinematicname );
        }
    }
    
    /#
        while ( getdvarint( @"scr_br_hold_preload", 0 ) == 1 )
        {
            waitframe();
        }
    #/
}

// Namespace br_gulag
// Params 0
// Checksum 0x7e50eaae, Offset: 0x15573
// Size: 0x92
function playerplayintrocinematic()
{
    if ( level.gulag.introcinematic && !isbot( self ) )
    {
        self setclientomnvar( "ui_br_bink_overlay_state", 1 );
        music_br::function_7373b0c330e6519( self );
        
        if ( level.gulag.preloadcinematic )
        {
            self function_8683380408d3d654( 0 );
        }
        else
        {
            cinematicname = function_6906a05d206f72ec();
            self playcinematicforplayer( cinematicname );
        }
        
        self.playinggulagbink = 1;
        level notify( #"hash_7f6b2a7b2d05df3e" );
        return;
    }
    
    gulagloadingtext();
}

// Namespace br_gulag
// Params 0
// Checksum 0x7a9f0c0e, Offset: 0x1560d
// Size: 0x69
function function_a8ece89e0c7e96dd()
{
    if ( level.gulag.outrocinematic && !isbot( self ) )
    {
        if ( level.var_56c3cc3dc37f1728.name == "gulag_twotwo" )
        {
            self setclientomnvar( "ui_br_bink_overlay_state", 10 );
            music_br::function_9b0c03ce19bdfe20( self );
            self playcinematicforplayer( "gulag_exit" );
            playerwaittillcinematiccomplete( gettime() );
        }
    }
}

// Namespace br_gulag
// Params 0
// Checksum 0x3941a7, Offset: 0x1567e
// Size: 0xf
function playershowskippromptcinematic()
{
    self setclientomnvar( "ui_br_bink_overlay_state", 2 );
}

// Namespace br_gulag
// Params 1
// Checksum 0x4d798733, Offset: 0x15695
// Size: 0x9a
function playerwaittillcinematiccomplete( starttime )
{
    if ( level.gulag.introcinematic && !isbot( self ) && !self isplayerheadless() )
    {
        player::_freezecontrols( 1, undefined, "gulagCinematic" );
        cinematicskipped = _playerwaittillcinematiccompleteinternal( starttime );
        
        if ( !isdefined( cinematicskipped ) )
        {
            cinematicskipped = 0;
        }
        
        player::_freezecontrols( 0, 0, "gulagCinematic" );
        self setclientomnvar( "ui_br_bink_overlay_state", 5 );
        
        if ( cinematicskipped )
        {
            self stopcinematicforplayer( cinematicskipped );
        }
        
        self.playinggulagbink = undefined;
        br_spawnrespawn::function_24b79e9319c6f02f();
    }
}

// Namespace br_gulag
// Params 1
// Checksum 0xf1a4d34f, Offset: 0x15737
// Size: 0x58, Type: bool
function _playerwaittillcinematiccompleteinternal( starttime )
{
    self endon( #"bink_complete" );
    
    while ( gettime() - starttime < level.gulag.var_f0e376124326d6f6 )
    {
        if ( self crouchbuttonpressed() || self usebuttonpressed() || self jumpbuttonpressed() )
        {
            return true;
        }
        
        waitframe();
    }
    
    return false;
}

// Namespace br_gulag
// Params 2
// Checksum 0xafb03e8c, Offset: 0x15798
// Size: 0x2c
function playercinematiccompletecallback( channel, val )
{
    if ( channel == "bink_complete" )
    {
        self notify( #"bink_complete" );
    }
}

// Namespace br_gulag
// Params 2
// Checksum 0x251dc9a8, Offset: 0x157cc
// Size: 0x1a3
function setupcellspawn( arena, cellspawnstruct )
{
    if ( !level.gulag.usecellspawns )
    {
        return;
    }
    
    if ( !isdefined( cellspawnstruct.target ) )
    {
        level.gulag.usecellspawns = !getdvarint( @"hash_4b3b1cb4e4a60edc", 0 );
        return;
    }
    
    doors = getentarray( cellspawnstruct.target, #targetname );
    
    if ( doors.size > 1 )
    {
        level.gulag.usecellspawns = 0;
        return;
    }
    
    cellspawnstruct.door = getent( cellspawnstruct.target, #targetname );
    
    if ( isdefined( cellspawnstruct.door ) )
    {
        cellspawnstruct.door.closed = 1;
        clip = getent( cellspawnstruct.door.target, #targetname );
        clip delete();
        dirslide = anglestoforward( cellspawnstruct.door.angles );
        cellspawnstruct.door.closepos = cellspawnstruct.door.origin;
        cellspawnstruct.door.openpos = cellspawnstruct.door.origin + dirslide * 60;
    }
    
    return cellspawnstruct;
}

// Namespace br_gulag
// Params 1
// Checksum 0xeef67031, Offset: 0x15978
// Size: 0x100
function gulag_getplayerstatewait( waittime )
{
    player = self;
    player endon( #"disconnect" );
    level endon( #"game_ended" );
    
    if ( getdvarint( @"hash_9ae23fa804cbfdd7", 0 ) == 0 )
    {
        return;
    }
    
    if ( !isdefined( waittime ) )
    {
        waittime = 0;
    }
    
    wait waittime;
    
    if ( isdefined( player ) )
    {
        if ( isdefined( player.name ) )
        {
            playername = player.name;
        }
        else
        {
            playername = "";
        }
        
        if ( isdefined( player.gulagarena ) )
        {
            var_80a3610a0bfa8650 = player.gulagarena;
        }
        else
        {
            var_80a3610a0bfa8650 = "";
        }
        
        if ( isdefined( player.gulag ) )
        {
            playergulag = player.gulag;
        }
        else
        {
            playergulag = "";
        }
        
        logstring( "[gulag_getPlayerStateWait] Player " + playername + " has .gulagArena : " + var_80a3610a0bfa8650 + " and .gulag : " + playergulag );
    }
}

// Namespace br_gulag
// Params 1
// Checksum 0x7b3fec5b, Offset: 0x15a80
// Size: 0x31, Type: bool
function usecellspawns( arena )
{
    return level.gulag.usecellspawns && arena.cellspawns.size > 0;
}

// Namespace br_gulag
// Params 2
// Checksum 0xa1e6e903, Offset: 0x15aba
// Size: 0x4f
function function_c8f7b364fdc4f2d2( name, func )
{
    if ( !isdefined( level.gulagoverrides ) )
    {
        level.gulagoverrides = [];
    }
    
    assert( !isdefined( level.gulagoverrides[ name ] ) );
    level.gulagoverrides[ name ] = func;
}

// Namespace br_gulag
// Params 2
// Checksum 0x4a663f3e, Offset: 0x15b11
// Size: 0x4d
function function_bc6aa264f5495083( name, args )
{
    if ( !isdefined( level.gulagoverrides ) )
    {
        return;
    }
    
    func = level.gulagoverrides[ name ];
    
    if ( !isdefined( func ) )
    {
        return;
    }
    
    return function_2503d1772307a488( func, args );
}

// Namespace br_gulag
// Params 2
// Checksum 0x3dd4bceb, Offset: 0x15b67
// Size: 0x71
function function_9d1513fbb2a21c4f( name, func )
{
    if ( !isdefined( level.var_3cd0214f9b8cdd05 ) )
    {
        level.var_3cd0214f9b8cdd05 = [];
    }
    
    if ( !isdefined( level.var_3cd0214f9b8cdd05[ name ] ) )
    {
        level.var_3cd0214f9b8cdd05[ name ] = [];
    }
    
    count = level.var_3cd0214f9b8cdd05[ name ].size;
    level.var_3cd0214f9b8cdd05[ name ][ count ] = func;
}

// Namespace br_gulag
// Params 2
// Checksum 0x4697cf6d, Offset: 0x15be0
// Size: 0x9a
function function_c35096fb12f26591( name, args )
{
    funcs = function_af2d5e37b20b4952( name );
    
    foreach ( func in funcs )
    {
        thread function_2503d1772307a488( func, args );
    }
}

// Namespace br_gulag
// Params 3
// Checksum 0xc9db666f, Offset: 0x15c82
// Size: 0xe8
function function_2503d1772307a488( func, args = [], var_b710e60d15be6446 )
{
    if ( !isarray( args ) )
    {
        args = [ args ];
    }
    
    assert( args.size <= 4 );
    
    /#
        time = gettime();
    #/
    
    if ( args.size == 4 )
    {
        return [[ func ]]( args[ 0 ], args[ 1 ], args[ 2 ], args[ 3 ] );
    }
    else if ( args.size == 3 )
    {
        return [[ func ]]( args[ 0 ], args[ 1 ], args[ 2 ] );
    }
    else if ( args.size == 2 )
    {
        return [[ func ]]( args[ 0 ], args[ 1 ] );
    }
    else if ( args.size == 1 )
    {
        return [[ func ]]( args[ 0 ] );
    }
    else if ( args.size == 0 )
    {
        return [[ func ]]();
    }
    
    assert( !var_b710e60d15be6446 || time == gettime() );
}

// Namespace br_gulag
// Params 2
// Checksum 0x6b46a7a7, Offset: 0x15d72
// Size: 0xce
function function_8cab7c26339d3d8d( name, args )
{
    funcs = function_af2d5e37b20b4952( name );
    results = [];
    
    foreach ( func in funcs )
    {
        result = function_2503d1772307a488( func, args, 1 );
        
        if ( isarray( result ) )
        {
            results = arraycombine( results, result );
            continue;
        }
        
        results[ results.size ] = result;
    }
    
    return results;
}

// Namespace br_gulag
// Params 2
// Checksum 0x3be3cfcf, Offset: 0x15e49
// Size: 0x20
function function_e0c6f0f4b4c6f556( name, args )
{
    return function_657ef6f4c281b2ec( name, args, 1 );
}

// Namespace br_gulag
// Params 2
// Checksum 0x2c97275f, Offset: 0x15e72
// Size: 0x1f
function function_fcc683fdbcf6af70( name, args )
{
    return function_657ef6f4c281b2ec( name, args, 0 );
}

// Namespace br_gulag
// Params 3
// Checksum 0x5b0b1bd4, Offset: 0x15e9a
// Size: 0xbb
function function_657ef6f4c281b2ec( name, args, testbool )
{
    funcs = function_af2d5e37b20b4952( name );
    
    foreach ( func in funcs )
    {
        result = function_2503d1772307a488( func, args, 1 );
        
        if ( result == testbool )
        {
            return testbool;
        }
    }
    
    return !testbool;
}

// Namespace br_gulag
// Params 1
// Checksum 0x1f365a71, Offset: 0x15f5e
// Size: 0x3f
function function_af2d5e37b20b4952( name )
{
    if ( !isdefined( level.var_3cd0214f9b8cdd05 ) )
    {
        return [];
    }
    
    funcs = level.var_3cd0214f9b8cdd05[ name ];
    
    if ( !isdefined( funcs ) )
    {
        return [];
    }
    
    return funcs;
}

// Namespace br_gulag
// Params 0
// Checksum 0xaace2faf, Offset: 0x15fa6
// Size: 0x1aa
function function_6b69f4e276fc711e()
{
    infinitemode = getdvarint( @"hash_4a4190cc7599dc5f", 0 );
    
    if ( !infinitemode )
    {
        return;
    }
    
    level.br_debugsolotest = 1;
    level.gulag.maxuses = -1;
    level.skydive_spawnprotectionactive = 0;
    level.br_infils_disabled = 1;
    level.prematchperiodend = 0;
    level.br_circle_disabled = 1;
    flags::gameflagwait( "prematch_done" );
    flags::gameflagset( "br_ready_to_jump" );
    wait 2;
    
    while ( true )
    {
        foreach ( player in level.players )
        {
            if ( infinitemode == 2 && player == level.player )
            {
                continue;
            }
            
            if ( !player.br_infilstarted )
            {
                continue;
            }
            
            if ( !isdefined( player.spawntime ) || gettime() - player.spawntime <= 100 )
            {
                continue;
            }
            
            if ( player.var_6bf2654d1381210a )
            {
                continue;
            }
            
            if ( player br_public::isplayerinorgoingtogulag() )
            {
                continue;
            }
            
            if ( player br_public::iseligibleforteamrevive() )
            {
                level thread function_a53f534b36b2ea56( player );
                continue;
            }
            
            if ( isalive( player ) )
            {
                player damage::_suicide( 0 );
                wait 0.5;
                break;
            }
        }
        
        waitframe();
    }
}

// Namespace br_gulag
// Params 1
// Checksum 0x3e220231, Offset: 0x16158
// Size: 0x82
function function_a53f534b36b2ea56( player )
{
    player.var_6bf2654d1381210a = 1;
    player.gulagloser = 0;
    
    if ( utility::issharedfuncdefined( #"gametype", #"kioskreviveplayer" ) )
    {
        player utility::callsharedfunc( #"gametype", #"kioskreviveplayer", player, 0 );
    }
    else
    {
        player playergulagautowin( "kioskRevivePlayer", player, 0 );
    }
    
    wait 1;
    player.var_6bf2654d1381210a = undefined;
}

// Namespace br_gulag
// Params 1, eflags: 0x4
// Checksum 0xaa1a367c, Offset: 0x161e2
// Size: 0xa8
function private function_1b93f50c147596db( arenas )
{
    level endon( #"game_ended" );
    flags::function_2f3408423ccc9b2e( "prematch_done" );
    
    foreach ( arena in arenas )
    {
        function_5db0de9cca120ff9( arena.gulagindex, arena.jailspawns );
    }
}

// Namespace br_gulag
// Params 3
// Checksum 0x45ef305b, Offset: 0x16292
// Size: 0x75
function function_cbb2b688a1afe748( player, debugreason, var_73375da1949b73a9 )
{
    /#
        if ( getdvarint( @"hash_9144df4be848d0b7", 1 ) )
        {
            logstring( "<dev string:x34c>" + ( player.name ?? "<dev string:x232>" ) + "<dev string:x376>" + player.clientid + "<dev string:x37d>" + debugreason + "<dev string:x388>" + var_73375da1949b73a9 );
        }
    #/
}

// Namespace br_gulag
// Params 3
// Checksum 0xb9d5c6cd, Offset: 0x1630f
// Size: 0x81
function function_61fa022bebce175d( player, reason, entering )
{
    if ( getdvarint( @"hash_62b35c4bae3c1f16", 0 ) )
    {
        logstring( "[GULAG DEBUG] : Jailed player " + ( entering ? "entering" : "exitting" ) + " - player: " + ( player.name ?? "" ) + ", id: " + player.clientid + ", reason: " + reason );
    }
}

// Namespace br_gulag
// Params 3
// Checksum 0xbe84c1e4, Offset: 0x16398
// Size: 0xd1
function function_d1e9259bf9b9055( player, functionname = "undefined", message = "" )
{
    if ( getdvarint( @"hash_2f39786ca1dfea1b", 1 ) )
    {
        if ( isplayer( player ) )
        {
            name = player.name ?? "";
            id = player.entnum ?? utility::get_entity_number( player );
            logstring( "[GULAG] " + functionname + ": " + message + " name=" + name + " id=" + id );
            return;
        }
        
        logstring( "[GULAG] " + functionname + ": " + message );
    }
}

// Namespace br_gulag
// Params 0
// Checksum 0x4ad4734c, Offset: 0x16471
// Size: 0x1dc
function function_3d1e73c34a5e1113()
{
    if ( !getdvarint( @"hash_7aad3ab9fa557f5a", 0 ) )
    {
        return;
    }
    
    level notify( #"hash_abdc01a8244e2e5f" );
    level endon( #"hash_abdc01a8244e2e5f" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        wait 1;
        var_d6ffe637cd55f6c = 1;
        
        foreach ( arena in level.gulag.arenas )
        {
            if ( !arena.fightover || !arena.shutdown )
            {
                var_d6ffe637cd55f6c = 0;
            }
        }
        
        if ( var_d6ffe637cd55f6c )
        {
            break;
        }
    }
    
    wait 10;
    
    foreach ( player in level.players )
    {
        if ( !isalive( player ) )
        {
            continue;
        }
        
        if ( player br_public::isplayerinorgoingtogulag() )
        {
            arenaindex = -1;
            
            if ( isdefined( player.arena ) )
            {
                arenaindex = function_f02c63b99c9614c9( level.gulag.arenas, arena );
            }
            
            script::demoforcesre( "Player " + ( player.name ?? "???" ) + " in gulag after shutdown. Arena index " + arenaindex );
        }
    }
}

/#

    // Namespace br_gulag
    // Params 1
    // Checksum 0xf3ad3394, Offset: 0x16655
    // Size: 0x3b2, Type: dev
    function runcommand( args )
    {
        if ( args.size == 0 )
        {
            return;
        }
        
        command = args[ 0 ];
        
        if ( command == "<dev string:x39c>" )
        {
            function_f01b3373d2cc3743();
            return;
        }
        
        if ( !level.usegulag )
        {
            return;
        }
        
        if ( command == "<dev string:x3a9>" )
        {
            debugwarptojail();
            return;
        }
        
        if ( command == "<dev string:x3b3>" )
        {
            debugwarptojailsingle();
            return;
        }
        
        if ( command == "<dev string:x3c4>" )
        {
            debugresetguns();
            return;
        }
        
        if ( command == "<dev string:x3cf>" )
        {
            debugfakeduel();
            return;
        }
        
        if ( command == "<dev string:x3d9>" )
        {
            debugfakewinner();
            return;
        }
        
        if ( command == "<dev string:x3e5>" )
        {
            debugshutdown();
            return;
        }
        
        if ( command == "<dev string:x3ee>" )
        {
            function_445e2495ccc6db26();
            setdevdvar( @"scr_gulag_rock", 0 );
            return;
        }
        
        if ( command == "<dev string:x3f3>" )
        {
            foreach ( arena in level.gulag.arenas )
            {
                updateplayeromnvarsallmatches( arena );
            }
            
            setdevdvar( @"hash_2f29e85b9ff6eddc", 0 );
            return;
        }
        
        if ( command == "<dev string:x3fc>" )
        {
            thread function_d3639dee80feb4d5( args );
            return;
        }
        
        if ( command == "<dev string:x409>" )
        {
            thread debugmatches( args );
            return;
        }
        
        if ( command == "<dev string:x417>" )
        {
            thread function_2204a1496abc043e( args );
            return;
        }
        
        if ( command == "<dev string:x426>" )
        {
            host = gamelogic_mp::gethostplayer();
            host setclientomnvar( "<dev string:x436>", 1 );
            host playcinematicforplayer( "<dev string:x44f>" );
            setdvar( @"hash_da200314926d462c", 0 );
            return;
        }
        
        if ( command == "<dev string:x466>" )
        {
            host = gamelogic_mp::gethostplayer();
            host setclientomnvar( "<dev string:x436>", 0 );
            host stopcinematicforplayer();
            setdvar( @"hash_76bb2f96ffd637c8", 0 );
            return;
        }
        
        if ( command == "<dev string:x475>" )
        {
            level.gulag.maxuses = 1;
            
            foreach ( player in level.players )
            {
                player.gulaguses = 1;
                
                if ( player br_public::function_70c1f4b75530023f() && !player br_public::function_b648dc1bd1363daf() )
                {
                    item_gulag_token::function_10b12e3b4eaa98df();
                }
                
                player function_a7357f7a8eb52832();
            }
            
            return;
        }
        
        if ( command == "<dev string:x484>" )
        {
            level.gulag.maxuses = 1;
            
            foreach ( player in level.players )
            {
                player.gulaguses = 0;
                player function_a7357f7a8eb52832();
            }
        }
    }

    // Namespace br_gulag
    // Params 1
    // Checksum 0x812b841f, Offset: 0x16a0f
    // Size: 0x279, Type: dev
    function function_dd778b6d408dc370( arenanum )
    {
        function_a7a89b91a190326b();
        
        if ( arenanum >= level.gulag.arenas.size )
        {
            return;
        }
        
        arena = level.gulag.arenas[ arenanum ];
        matchdebug = level.gulag.matchdebug;
        
        if ( !arena.isjailbreak )
        {
            matchdebug.arenastring setdevtext( "<dev string:x495>" + arenanum + "<dev string:x49c>" );
        }
        else
        {
            matchdebug.arenastring setdevtext( "<dev string:x495>" + arenanum + "<dev string:x4a5>" );
        }
        
        if ( !arena.isjailbreak )
        {
            if ( arena.arenaplayers.size > 0 )
            {
                matchdebug.currentstring.alpha = 1;
                
                for ( playerindex = 0; playerindex < matchdebug.playerstrings.size ; playerindex++ )
                {
                    if ( isdefined( arena.arenaplayers[ playerindex ] ) )
                    {
                        matchdebug.playerstrings[ playerindex ] setplayernamestring( arena.arenaplayers[ playerindex ] );
                        matchdebug.playerstrings[ playerindex ].alpha = 1;
                    }
                }
            }
        }
        else
        {
            matchdebug.currentstring.alpha = 1;
        }
        
        for ( matchindex = 0; matchindex < matchdebug.matches.size ; matchindex++ )
        {
            match = matchdebug.matches[ matchindex ];
            
            if ( matchindex < arena.matches.size )
            {
                match.debugstring.alpha = 1;
                
                for ( playerindex = 0; playerindex < match.playerstrings.size ; playerindex++ )
                {
                    if ( playerindex < arena.matches[ matchindex ].size )
                    {
                        match.playerstrings[ playerindex ] setplayernamestring( arena.matches[ matchindex ][ playerindex ] );
                        match.playerstrings[ playerindex ].alpha = 1;
                        
                        if ( arena.isjailbreak )
                        {
                            match.debugstring.alpha = 0;
                        }
                    }
                }
            }
        }
    }

    // Namespace br_gulag
    // Params 0
    // Checksum 0x76b94f8b, Offset: 0x16c90
    // Size: 0x3ad, Type: dev
    function function_2802432cf192ae9f()
    {
        var_e8b7b0e4c5f35f9c = 8;
        var_249f860272ff2f61 = 170;
        var_5748cd097165e332 = 40;
        const_offset_y = 15;
        const_font_size = 0.75;
        yline = 0;
        level.gulag.matchdebug = spawnstruct();
        matchdebug = level.gulag.matchdebug;
        matchdebug.arenastring = createserverfontstring( "<dev string:x4b0>", const_font_size );
        matchdebug.arenastring hud_util::setpoint( "<dev string:x4b8>", "<dev string:x4b8>", var_249f860272ff2f61, var_5748cd097165e332 + yline * const_offset_y );
        matchdebug.arenastring setdevtext( "<dev string:x4c1>" );
        matchdebug.arenastring.color = ( 1, 1, 0 );
        matchdebug.arenastring.alpha = 1;
        yline++;
        matchdebug.currentstring = createserverfontstring( "<dev string:x4b0>", const_font_size );
        matchdebug.currentstring hud_util::setpoint( "<dev string:x4b8>", "<dev string:x4b8>", var_249f860272ff2f61, var_5748cd097165e332 + yline * const_offset_y );
        matchdebug.currentstring setdevtext( "<dev string:x4d1>" );
        matchdebug.currentstring.color = ( 0, 1, 0 );
        matchdebug.currentstring.alpha = 1;
        yline++;
        matchdebug.playerstrings = [];
        
        for ( playerindex = 0; playerindex < 2 ; playerindex++ )
        {
            matchdebug.playerstrings[ playerindex ] = createserverfontstring( "<dev string:x4b0>", const_font_size );
            matchdebug.playerstrings[ playerindex ] hud_util::setpoint( "<dev string:x4b8>", "<dev string:x4b8>", var_249f860272ff2f61, var_5748cd097165e332 + yline * const_offset_y );
            matchdebug.playerstrings[ playerindex ] setdevtext( "<dev string:x4df>" + playerindex );
            matchdebug.playerstrings[ playerindex ].alpha = 1;
            yline++;
        }
        
        matchdebug.matches = [];
        
        for ( matchindex = 0; matchindex < var_e8b7b0e4c5f35f9c ; matchindex++ )
        {
            matchdebug.matches[ matchindex ] = spawnstruct();
            match = matchdebug.matches[ matchindex ];
            match.debugstring = createserverfontstring( "<dev string:x4b0>", const_font_size );
            match.debugstring hud_util::setpoint( "<dev string:x4b8>", "<dev string:x4b8>", var_249f860272ff2f61, var_5748cd097165e332 + yline * const_offset_y );
            match.debugstring setdevtext( "<dev string:x4e7>" + matchindex + 1 );
            match.debugstring.color = ( 0, 1, 0 );
            match.debugstring.alpha = 1;
            yline++;
            match.playerstrings = [];
            
            for ( playerindex = 0; playerindex < 2 ; playerindex++ )
            {
                match.playerstrings[ playerindex ] = createserverfontstring( "<dev string:x4b0>", const_font_size );
                match.playerstrings[ playerindex ] hud_util::setpoint( "<dev string:x4b8>", "<dev string:x4b8>", var_249f860272ff2f61, var_5748cd097165e332 + yline * const_offset_y );
                match.playerstrings[ playerindex ].alpha = 1;
                yline++;
            }
        }
    }

    // Namespace br_gulag
    // Params 0
    // Checksum 0xc4079ea6, Offset: 0x17045
    // Size: 0x106, Type: dev
    function function_28914cc0c961b4bd()
    {
        matchdebug = level.gulag.matchdebug;
        matchdebug.arenastring destroy();
        matchdebug.currentstring destroy();
        
        for ( playerindex = 0; playerindex < matchdebug.playerstrings.size ; playerindex++ )
        {
            matchdebug.playerstrings[ playerindex ] destroy();
        }
        
        for ( matchindex = 0; matchindex < matchdebug.matches.size ; matchindex++ )
        {
            match = matchdebug.matches[ matchindex ];
            match.debugstring destroy();
            
            for ( playerindex = 0; playerindex < match.playerstrings.size ; playerindex++ )
            {
                match.playerstrings[ playerindex ] destroy();
            }
        }
        
        level.gulag.matchdebug = undefined;
    }

    // Namespace br_gulag
    // Params 0
    // Checksum 0x6a198cac, Offset: 0x17153
    // Size: 0xff, Type: dev
    function function_a7a89b91a190326b()
    {
        matchdebug = level.gulag.matchdebug;
        matchdebug.currentstring.alpha = 0;
        
        for ( playerindex = 0; playerindex < matchdebug.playerstrings.size ; playerindex++ )
        {
            matchdebug.playerstrings[ playerindex ].alpha = 0;
        }
        
        for ( matchindex = 0; matchindex < matchdebug.matches.size ; matchindex++ )
        {
            match = matchdebug.matches[ matchindex ];
            match.debugstring.alpha = 0;
            
            for ( playerindex = 0; playerindex < match.playerstrings.size ; playerindex++ )
            {
                match.playerstrings[ playerindex ].alpha = 0;
            }
        }
    }

    // Namespace br_gulag
    // Params 2
    // Checksum 0x67ffecfa, Offset: 0x1725a
    // Size: 0xfc, Type: dev
    function createserverfontstring( font, fontscale )
    {
        fontelem = newhudelem();
        fontelem.elemtype = "<dev string:x4ee>";
        fontelem.font = font;
        fontelem.fontscale = fontscale;
        fontelem.basefontscale = fontscale;
        fontelem.x = 0;
        fontelem.y = 0;
        fontelem.width = 0;
        fontelem.height = int( level.fontheight * fontscale );
        fontelem.xoffset = 0;
        fontelem.yoffset = 0;
        fontelem.children = [];
        fontelem hud_util::setparent( level.uiparent );
        fontelem.hidden = 0;
        fontelem.archived = 0;
        return fontelem;
    }

    // Namespace br_gulag
    // Params 0
    // Checksum 0xdf6439e6, Offset: 0x1735e
    // Size: 0x88, Type: dev
    function function_445e2495ccc6db26()
    {
        foreach ( player in level.players )
        {
            player equipment_mp::giveequipment( "<dev string:x4f3>", "<dev string:x4fe>" );
        }
    }

    // Namespace br_gulag
    // Params 0
    // Checksum 0xb4912080, Offset: 0x173ee
    // Size: 0x9b, Type: dev
    function debugfakewinner()
    {
        host = gamelogic_mp::gethostplayer();
        
        if ( isdefined( host ) )
        {
            if ( !isdefined( host.arena ) )
            {
                if ( namespace_a8afdcd7738e364e::function_373b8665fd6de550() )
                {
                    arena = host namespace_a974e4dd85555bc2::gulag_playergetnextarena();
                }
                else
                {
                    arena = host playergetnextarena();
                }
                
                host.arena = arena;
            }
            
            if ( isalive( host ) && !host br_public::isplayerinorgoingtogulag() )
            {
                host thread playerpulloutofgulagwin( host, "<dev string:x506>" );
                return;
            }
            
            host thread br_vip_quest::vip_respawnplayer( host, host, "<dev string:x506>" );
        }
    }

    // Namespace br_gulag
    // Params 0
    // Checksum 0x602ad69a, Offset: 0x17491
    // Size: 0x81, Type: dev
    function function_f01b3373d2cc3743()
    {
        host = gamelogic_mp::gethostplayer();
        
        if ( isdefined( host ) && !isalive( host ) )
        {
            teammates = level.teamdata[ host.team ][ "<dev string:x50c>" ];
            
            if ( teammates.size > 0 )
            {
                teammate = teammates[ 0 ];
                teammate br_pickups::addrespawntoken( 1 );
                host playergulagautowin( "<dev string:x519>", teammate, 1, 1 );
            }
        }
    }

    // Namespace br_gulag
    // Params 0
    // Checksum 0xe5753efe, Offset: 0x1751a
    // Size: 0x1cb, Type: dev
    function debugfakeduel()
    {
        host = gamelogic_mp::gethostplayer();
        
        if ( isdefined( host ) )
        {
            host setplayervargulagjail( 0 );
            enemy = getbot( host, 1 );
            
            if ( isdefined( enemy ) )
            {
                enemy setplayervargulagjail( 0 );
                host thread initplayerjail();
                enemy thread initplayerjail();
                return;
            }
        }
        
        players = [];
        counter = 0;
        
        foreach ( entry in level.teamnamelist )
        {
            squadindices = br_public::function_ec36cf40e2b38aa6( entry );
            
            for ( i = 0; i < squadindices.size ; i++ )
            {
                squadindex = squadindices[ i ];
                teamplayers = teams::function_d032b36d01bbbab3( entry, squadindex );
                
                foreach ( teamplayer in teamplayers )
                {
                    players[ counter ] = teamplayer;
                    teamplayer setplayervargulagjail( 0 );
                    counter++;
                    break;
                }
            }
            
            if ( counter == 2 )
            {
                break;
            }
        }
        
        players[ 0 ] thread initplayerjail();
        players[ 1 ] thread initplayerjail();
    }

    // Namespace br_gulag
    // Params 2
    // Checksum 0x2da09c5, Offset: 0x176ed
    // Size: 0xed, Type: dev
    function getbot( host, oppositeteam )
    {
        foreach ( player in level.players )
        {
            if ( !isalive( player ) )
            {
                continue;
            }
            
            if ( isbot( player ) || istestclient( player ) )
            {
                if ( !oppositeteam && player.team == host.team || oppositeteam && player.team != host.team )
                {
                    return player;
                }
            }
        }
    }

    // Namespace br_gulag
    // Params 0
    // Checksum 0xae6e2c64, Offset: 0x177e2
    // Size: 0x88, Type: dev
    function debugresetguns()
    {
        foreach ( arena in level.gulag.arenas )
        {
            resetequipment( arena );
        }
    }

    // Namespace br_gulag
    // Params 1
    // Checksum 0x1c64cf6f, Offset: 0x17872
    // Size: 0x1c, Type: dev
    function debugshutdown( type )
    {
        shutdowngulag( "<dev string:x506>", 0 );
    }

    // Namespace br_gulag
    // Params 1
    // Checksum 0xf9a4dee7, Offset: 0x17896
    // Size: 0x107, Type: dev
    function debugwarptojail( single )
    {
        host = gamelogic_mp::gethostplayer();
        
        foreach ( player in level.players )
        {
            if ( player == host )
            {
                continue;
            }
            
            if ( player.jailed || player.gulagarena )
            {
                continue;
            }
            
            if ( player::isreallyalive( player ) )
            {
                player initplayerjail();
                
                if ( single )
                {
                    return;
                }
            }
        }
        
        if ( player::isreallyalive( host ) && !host.jailed && !host.gulagarena )
        {
            host initplayerjail();
        }
    }

    // Namespace br_gulag
    // Params 0
    // Checksum 0x8195540f, Offset: 0x179a5
    // Size: 0xaf, Type: dev
    function debugwarptojailsingle()
    {
        host = gamelogic_mp::gethostplayer();
        
        if ( !isdefined( host ) )
        {
            debugwarptojail( 1 );
            return;
        }
        
        start = host geteye();
        dir = anglestoforward( host getplayerangles() );
        end = start + 8000 * dir;
        trace = trace::_bullet_trace( start, end, 1, host );
        
        if ( isplayer( trace[ "<dev string:x52a>" ] ) && player::isreallyalive( trace[ "<dev string:x52a>" ] ) )
        {
            player = trace[ "<dev string:x52a>" ];
            player initplayerjail();
        }
    }

    // Namespace br_gulag
    // Params 1
    // Checksum 0x79ba73fc, Offset: 0x17a5c
    // Size: 0xab, Type: dev
    function function_d3639dee80feb4d5( args )
    {
        if ( args.size < 2 )
        {
            return;
        }
        
        level.gulag.var_2bad2701dd405b14 = int( args[ 1 ] );
        
        if ( level.gulag.var_2bad2701dd405b14 > -1 && !level.gulag.var_d3639dee80feb4d5 )
        {
            debugmatches( args );
            return;
        }
        
        if ( level.gulag.var_2bad2701dd405b14 == -1 && level.gulag.var_d3639dee80feb4d5 )
        {
            debugmatches( args );
        }
    }

    // Namespace br_gulag
    // Params 1
    // Checksum 0x99d7b6e3, Offset: 0x17b0f
    // Size: 0x4d5, Type: dev
    function debugmatches( args )
    {
        if ( !isdefined( level.gulag.arenas ) )
        {
            return;
        }
        
        if ( !level.gulag.var_d3639dee80feb4d5 )
        {
            level.gulag.var_d3639dee80feb4d5 = 1;
        }
        else
        {
            level notify( #"hash_5dee09ec4774b9c6" );
            level.gulag.var_d3639dee80feb4d5 = undefined;
            return;
        }
        
        level endon( #"hash_5dee09ec4774b9c6" );
        
        while ( true )
        {
            foreach ( arenaindex, arena in level.gulag.arenas )
            {
                foreach ( index, player in arena.arenaplayers )
                {
                    print3d( player.origin + ( 0, 0, 50 ), string( index ), ( 0, 1, 0 ) );
                }
                
                foreach ( index, player in arena.jailedplayers )
                {
                    print3d( player.origin + ( 0, 0, 50 ), string( index ) );
                }
                
                print3d( arena.center, string( arenaindex ), ( 1, 1, 0 ), 1, 2 );
            }
            
            if ( level.gulag.var_2bad2701dd405b14 > -1 )
            {
                if ( !isdefined( level.gulag.matchdebug ) )
                {
                    function_2802432cf192ae9f();
                }
                else
                {
                    function_dd778b6d408dc370( level.gulag.var_2bad2701dd405b14 );
                }
            }
            else if ( isdefined( level.gulag.matchdebug ) )
            {
                function_28914cc0c961b4bd();
            }
            
            finish = getdvarvector( @"hash_fc389672a33645f", ( 0, -1, -1 ) );
            var_aaea2ce667de37ec = int( finish[ 0 ] );
            
            if ( var_aaea2ce667de37ec < level.gulag.arenas.size )
            {
                arena = level.gulag.arenas[ var_aaea2ce667de37ec ];
                
                if ( finish[ 1 ] > -1 && finish[ 2 ] > -1 && finish[ 1 ] < arena.arenaplayers.size && finish[ 2 ] < arena.arenaplayers.size )
                {
                    winner = arena.arenaplayers[ int( finish[ 1 ] ) ];
                    loser = arena.arenaplayers[ int( finish[ 2 ] ) ];
                    loser dodamage( loser.health, winner.origin, winner, winner );
                    setdvar( @"hash_fc389672a33645f", ( 0, -1, -1 ) );
                }
            }
            
            finish = getdvarvector( @"hash_6d211b3196fa7e4b", ( 0, -1, -1 ) );
            var_aaea2ce667de37ec = int( finish[ 0 ] );
            
            if ( var_aaea2ce667de37ec < level.gulag.arenas.size )
            {
                arena = level.gulag.arenas[ var_aaea2ce667de37ec ];
                
                if ( finish[ 1 ] > -1 && finish[ 2 ] > -1 && finish[ 1 ] < arena.arenaplayers.size && finish[ 2 ] < arena.arenaplayers.size )
                {
                    winner = arena.arenaplayers[ int( finish[ 1 ] ) ];
                    loser = arena.arenaplayers[ int( finish[ 2 ] ) ];
                    winner setorigin( arena.center );
                    setdvar( @"hash_6d211b3196fa7e4b", ( 0, -1, -1 ) );
                }
            }
            
            waitframe();
        }
    }

    // Namespace br_gulag
    // Params 1
    // Checksum 0x777100ad, Offset: 0x17fec
    // Size: 0x6c4, Type: dev
    function function_2204a1496abc043e( args )
    {
        if ( level.gulag.var_d33e95245fa76e10 )
        {
            foreach ( hud in level.gulag.var_d33e95245fa76e10 )
            {
                hud destroy();
            }
            
            level.gulag.var_d33e95245fa76e10 = undefined;
            level notify( #"hash_247e0607f249823c" );
            return;
        }
        else
        {
            const_offset_x = 110;
            const_x_start = 20;
            const_y_start = 120;
            
            foreach ( i, arena in level.gulag.arenas )
            {
                hud = createserverfontstring( "<dev string:x4b0>", 0.75 );
                hud hud_util::setpoint( "<dev string:x4b8>", "<dev string:x4b8>", const_x_start + i * const_offset_x, const_y_start );
                hud setdevtext( "<dev string:x531>" );
                level.gulag.var_d33e95245fa76e10[ i ] = hud;
            }
        }
        
        text_color_black = "<dev string:x536>";
        text_color_red = "<dev string:x539>";
        text_color_green = "<dev string:x53c>";
        text_color_yellow = "<dev string:x53f>";
        text_color_blue = "<dev string:x542>";
        text_color_cyan = "<dev string:x545>";
        text_color_magenta = "<dev string:x548>";
        text_color_white = "<dev string:x54b>";
        level endon( #"hash_247e0607f249823c" );
        
        while ( true )
        {
            anychanges = 0;
            
            foreach ( i, arena in level.gulag.arenas )
            {
                text = text_color_yellow + "<dev string:x495>" + i;
                
                if ( arena.overtime )
                {
                    text += "<dev string:x54e>";
                }
                
                if ( arena.isjailbreak )
                {
                    text += "<dev string:x55a>";
                }
                
                text += "<dev string:x567>" + text_color_green + "<dev string:x4d1>";
                arenacount = 0;
                
                foreach ( player in arena.arenaplayers )
                {
                    healthfrac = player.health / player.maxhealth;
                    armorfrac = 0;
                    
                    if ( isdefined( player.armorhealth ) && player.maxarmorhealth > 0 )
                    {
                        armorfrac = player.armorhealth / player.maxarmorhealth;
                    }
                    
                    var_396b4db1506786d9 = player.name + "<dev string:x569>" + player.team + "<dev string:x56b>";
                    var_6a0d0fb4bc40a150 = var_396b4db1506786d9.size;
                    
                    if ( healthfrac < 1 )
                    {
                        redindex = minint( int( ceil( var_6a0d0fb4bc40a150 * healthfrac ) ), var_6a0d0fb4bc40a150 - 1 );
                        var_396b4db1506786d9 = getsubstr( var_396b4db1506786d9, 0, redindex ) + text_color_red + getsubstr( var_396b4db1506786d9, redindex, var_6a0d0fb4bc40a150 );
                    }
                    else if ( armorfrac > 0 )
                    {
                        blueindex = int( ceil( var_6a0d0fb4bc40a150 * armorfrac ) );
                        var_396b4db1506786d9 = text_color_cyan + getsubstr( var_396b4db1506786d9, 0, blueindex ) + text_color_white + getsubstr( var_396b4db1506786d9, blueindex, var_6a0d0fb4bc40a150 );
                    }
                    
                    text += "<dev string:x56d>" + text_color_white + var_396b4db1506786d9;
                    arenacount++;
                }
                
                while ( arenacount < 2 )
                {
                    text += "<dev string:x567>";
                    arenacount++;
                }
                
                foreach ( j, match in arena.matches )
                {
                    text += "<dev string:x567>" + text_color_green + "<dev string:x4e7>" + j;
                    
                    foreach ( player in match )
                    {
                        text += "<dev string:x56d>" + text_color_white + player.name + "<dev string:x569>" + player.team + "<dev string:x56b>";
                    }
                }
                
                hud = level.gulag.var_d33e95245fa76e10[ i ];
                
                if ( hud.debugtext != text )
                {
                    anychanges = 1;
                    hud.debugtext = text;
                }
            }
            
            if ( anychanges )
            {
                level.gulag.var_d33e95245fa76e10[ 0 ] clearalltextafterhudelem();
                
                foreach ( hud in level.gulag.var_d33e95245fa76e10 )
                {
                    hud setdevtext( hud.debugtext );
                }
            }
            
            waitframe();
        }
    }

#/
