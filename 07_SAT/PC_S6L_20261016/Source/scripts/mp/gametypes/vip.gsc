// scripts\mp\gametypes\vip.gsc  (hash_02201d91547828c3.gscc) (size: 22984 Bytes / 0x59c8 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x208e4161 (546193761)
// size ...... 22984 (0x59c8)
// includes .. 34  (offset: 0x5194)
// strings ... 109 (offset: 0x52a4)
// dev strs .. 1   (offset: 0x59bc)
// exports ... 41  (offset: 0x364c)
// cseg ...... 0x7fb + 0x2e51 (0x364c)
// imports ... 174 (offset: 0x3cb4)
// animtree1 . 0   (offset: 0x59c8)
// animtree2 . 0   (offset: 0x59c8)
#using scripts\common\bots\bots_util;
#using scripts\common\telemetry_utils;
#using scripts\common\trace;
#using scripts\mp\agents\agent_common;
#using scripts\mp\agents\agent_utility;
#using scripts\mp\analyticslog;
#using scripts\mp\bots\bots_util;
#using scripts\mp\br\gametypes\br_extract_chopper;
#using scripts\mp\common\equipment\smoke_grenade;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\inventory_utility;
#using scripts\mp\common\utility\outline;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\print;
#using scripts\mp\common\utility\stats;
#using scripts\mp\common\utility\team_utility;
#using scripts\mp\common\utility\teams;
#using scripts\mp\common\utility\usability;
#using scripts\mp\events;
#using scripts\mp\flags;
#using scripts\mp\gamelogic;
#using scripts\mp\gameobjects;
#using scripts\mp\gametypes\common;
#using scripts\mp\gametypes\obj_dom;
#using scripts\mp\gametypes\sd;
#using scripts\mp\globallogic;
#using scripts\mp\hud_message;
#using scripts\mp\hud_util;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\persistence;
#using scripts\mp\rank;
#using scripts\mp\spawnlogic;
#using scripts\mp\spectating;

#namespace vip;

// Namespace vip
// Params 0
// Checksum 0x13610b94, Offset: 0x819
// Size: 0x147
function main()
{
    if ( getdvar( @"g_mapname" ) == "mp_background" )
    {
        return;
    }
    
    globallogic::init();
    globallogic::setupcallbacks();
    allowed[ 0 ] = game_utility::getgametype();
    allowed[ 1 ] = "sd";
    allowed[ 2 ] = "bombzone";
    allowed[ 3 ] = "dom";
    gameobjects::main( allowed );
    level.initializematchrules = &initializematchrules;
    [[ level.initializematchrules ]]();
    level thread game_utility_mp::reinitializematchrulesonmigration();
    level.teambased = 1;
    level.objectivebased = 1;
    updategametypedvars();
    level.onstartgametype = &onstartgametype;
    level.getspawnpoint = &getspawnpoint;
    level.modeonspawnplayer = &onspawnplayer;
    level.onnormaldeath = &onnormaldeath;
    level.onplayerkilled = &onplayerkilled;
    level.ondeadevent = &ondeadevent;
    game[ "dialog" ][ "gametype" ] = "gametype_defender";
    game[ "dialog" ][ "offense_obj" ] = "hint_killall";
    game[ "dialog" ][ "defense_obj" ] = "hint_killall";
    level._effect[ "vfx_smk_signal" ] = loadfxasset( "vfx_requests_mp_gameplay_smoke_signal" );
}

// Namespace vip
// Params 0
// Checksum 0x2d2f98c3, Offset: 0x968
// Size: 0x18
function initializematchrules()
{
    game_utility_mp::setcommonrulesfrommatchrulesdata();
    setdynamicdvar( @"scr_vip_promode", 0 );
}

// Namespace vip
// Params 0
// Checksum 0x58bacddc, Offset: 0x988
// Size: 0x9
function updategametypedvars()
{
    common::updatecommongametypedvars();
}

// Namespace vip
// Params 0
// Checksum 0x542f2f40, Offset: 0x999
// Size: 0x149
function onstartgametype()
{
    setclientnamemode( "auto_change" );
    
    if ( !isdefined( game[ "switchedsides" ] ) )
    {
        game[ "switchedsides" ] = 0;
    }
    
    if ( game[ "switchedsides" ] )
    {
        oldattackers = game[ "attackers" ];
        olddefenders = game[ "defenders" ];
        game[ "attackers" ] = olddefenders;
        game[ "defenders" ] = oldattackers;
    }
    
    game_utility_mp::setobjectivetext( "allies", &"objectives/vip" );
    game_utility_mp::setobjectivetext( "axis", &"objectives/vip" );
    
    if ( level.splitscreen )
    {
        game_utility_mp::setobjectivescoretext( "allies", &"objectives/vip" );
        game_utility_mp::setobjectivescoretext( "axis", &"objectives/vip" );
    }
    else
    {
        game_utility_mp::setobjectivescoretext( "allies", &"objectives/vip_score" );
        game_utility_mp::setobjectivescoretext( "axis", &"objectives/vip_score" );
    }
    
    game_utility_mp::setobjectivehinttext( "allies", &"objectives/vip_hint" );
    game_utility_mp::setobjectivehinttext( "axis", &"objectives/vip_hint" );
    initspawns();
    level.hostagestates = [];
    level.hostagecarrystates = [];
    seticonnames();
    thread waittoprocess();
    level thread votimeendingsoon();
}

// Namespace vip
// Params 0
// Checksum 0x3dc3f871, Offset: 0xaea
// Size: 0x56
function waittoprocess()
{
    level endon( #"game_end" );
    level endon( #"waitskipped" );
    level thread extractionzone();
    level thread spawnvip();
    level thread createthreatbiasgroups();
    flags::gameflagwait( "prematch_done" );
    flags::gameflagwait( "graceperiod_done" );
    self notify( #"gracecomplete" );
}

// Namespace vip
// Params 0
// Checksum 0x497a7cdf, Offset: 0xb48
// Size: 0x28
function initspawns()
{
    spawnlogic::function_6dbabb72223a4bca();
    spawnlogic::addstartspawnpoints( "mp_sd_spawn_attacker" );
    spawnlogic::addstartspawnpoints( "mp_sd_spawn_defender" );
    spawnlogic::finalizemap();
}

// Namespace vip
// Params 0
// Checksum 0x2ab57414, Offset: 0xb78
// Size: 0x65
function getspawnpoint()
{
    spawnpointname = "mp_sd_spawn_defender";
    
    if ( self.pers[ "team" ] == game[ "attackers" ] )
    {
        spawnpointname = "mp_sd_spawn_attacker";
    }
    
    spawnpoints = spawnlogic::getspawnpointarray( spawnpointname );
    assert( spawnpoints.size );
    spawnpoint = spawnlogic::getspawnpoint_startspawn( spawnpoints );
    return spawnpoint;
}

// Namespace vip
// Params 0
// Checksum 0x740174a3, Offset: 0xbe6
// Size: 0x80
function seticonnames()
{
    level.iconrecover = "waypoint_recover_vip";
    level.iconescort = "waypoint_escort_vip";
    level.iconextract = "waypoint_extract_vip";
    level.icontakingextract = "waypoint_taking_extract";
    level.iconlosingextract = "waypoint_losing_extract";
    level.iconcontestingextract = "waypoint_contesting_extract";
    level.icondefendextract = "waypoint_defend_extract";
    level.iconcaptureextract = "waypoint_capture_extract";
    level.iconstoppingextract = "waypoint_stopping_extract";
}

// Namespace vip
// Params 1
// Checksum 0xd6d6b5e4, Offset: 0xc6e
// Size: 0x78
function onspawnplayer( revivespawn )
{
    self.isvip = 0;
    self.usingobj = undefined;
    level notify( #"spawned_player" );
    hud_message::function_ef4318a0090caa0f( #"hide_match_hint" );
    self setthreatbiasgroup( self.team );
    thread updatematchstatushintonspawn();
    
    if ( isdefined( level.vip ) )
    {
        level.vip.trigger enableplayeruse( self );
    }
}

// Namespace vip
// Params 6
// Checksum 0xa94f98a8, Offset: 0xcee
// Size: 0xa3
function onnormaldeath( victim, attacker, lifeid, smeansofdeath, objweapon, iskillstreakweapon )
{
    score = rank::getscoreinfovalue( #"kill" );
    assert( isdefined( score ) );
    
    if ( isdefined( victim.isvip ) && victim.isvip )
    {
        level thread vip_endgame( game[ "attackers" ], &"mp_eliminated_vip" );
        attacker.finalkill = 1;
    }
}

// Namespace vip
// Params 10
// Checksum 0x2080218c, Offset: 0xd99
// Size: 0x64
function onplayerkilled( einflictor, attacker, idamage, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, deathanimduration, killid )
{
    thread checkallowspectating();
}

// Namespace vip
// Params 0
// Checksum 0x5cfec98c, Offset: 0xe05
// Size: 0x93
function ontimelimit()
{
    if ( game[ "status" ] == "overtime" )
    {
        winner = "forfeit";
    }
    else if ( game[ "teamScores" ][ "allies" ] == game[ "teamScores" ][ "axis" ] )
    {
        winner = "overtime";
    }
    else if ( game[ "teamScores" ][ "axis" ] > game[ "teamScores" ][ "allies" ] )
    {
        winner = "axis";
    }
    else
    {
        winner = "allies";
    }
    
    thread gamelogic_mp::endgame( winner, game[ "end_reason" ][ "time_limit_reached" ] );
}

// Namespace vip
// Params 0
// Checksum 0x9e18960c, Offset: 0xea0
// Size: 0x8c
function checkallowspectating()
{
    waitframe();
    update = 0;
    
    if ( !teams::getteamdata( game[ "attackers" ], "aliveCount" ) )
    {
        level.spectateoverride[ game[ "attackers" ] ].allowenemyspectate = 1;
        update = 1;
    }
    
    if ( !teams::getteamdata( game[ "defenders" ], "aliveCount" ) )
    {
        level.spectateoverride[ game[ "defenders" ] ].allowenemyspectate = 1;
        update = 1;
    }
    
    if ( update )
    {
        spectating::updatespectatesettings();
    }
}

// Namespace vip
// Params 1
// Checksum 0x45dc8a8c, Offset: 0xf34
// Size: 0x61
function ondeadevent( team )
{
    if ( team == game[ "attackers" ] )
    {
        level thread vip_endgame( game[ "defenders" ], game[ "end_reason" ][ "mp_faction_eliminated" ] );
        return;
    }
    
    if ( team == game[ "defenders" ] )
    {
        level thread vip_endgame( game[ "attackers" ], game[ "end_reason" ][ "mp_faction_eliminated" ] );
    }
}

// Namespace vip
// Params 2
// Checksum 0x5fd80cf7, Offset: 0xf9d
// Size: 0x1f
function vip_endgame( winningteam, endreasontext )
{
    thread gamelogic_mp::endgame( winningteam, endreasontext );
}

// Namespace vip
// Params 0
// Checksum 0x30103f21, Offset: 0xfc4
// Size: 0x554
function extractionzone()
{
    triggers = getentarray( "bombzone", #targetname );
    triggers = sd::removebombzonec( triggers );
    level.objectives = [];
    exfilteam = game[ "attackers" ];
    
    foreach ( trigger in triggers )
    {
        visuals[ 0 ] = spawn( "script_model", trigger.origin );
        visuals[ 0 ].angles = ( 0, 270, 0 );
        visuals[ 0 ].team = exfilteam;
        visuals[ 0 ].visibleteam = "any";
        visuals[ 0 ].ownerteam = exfilteam;
        visuals[ 0 ].type = "";
        exfilgoaltrigger = spawn( "trigger_radius", trigger.origin, 0, 120, 80 );
        exfilgoaltrigger.team = exfilteam;
        contentoverride = trace::create_contents( 0, 1, 1, 0, 0, 1, 1 );
        ignoreents = [];
        trace = trace::ray_trace( visuals[ 0 ].origin + ( 0, 0, 20 ), visuals[ 0 ].origin - ( 0, 0, 4000 ), ignoreents, contentoverride, 0 );
        
        if ( isplayer( trace[ "entity" ] ) )
        {
            trace[ "entity" ] = undefined;
        }
        
        if ( isdefined( trace ) )
        {
            tempangle = randomfloat( 360 );
            droporigin = trace[ "position" ];
            
            if ( isdefined( self.visualgroundoffset ) )
            {
                droporigin += self.visualgroundoffset;
            }
            
            forward = ( cos( tempangle ), sin( tempangle ), 0 );
            forward = vectornormalize( forward - trace[ "normal" ] * vectordot( forward, trace[ "normal" ] ) );
            visuals[ 0 ].origin = droporigin;
            visuals[ 0 ] setmodel( "cop_marker_scriptable" );
            visuals[ 0 ] setscriptablepartstate( "marker", "red" );
            visuals[ 0 ] playloopsound( "mp_flare_burn_lp" );
        }
        
        level.flagcapturetime = 0.05;
        
        if ( isdefined( exfilgoaltrigger.objectivekey ) )
        {
            objectivekey = exfilgoaltrigger.objectivekey;
        }
        else
        {
            objectivekey = exfilgoaltrigger.script_label;
        }
        
        if ( isdefined( exfilgoaltrigger.iconname ) )
        {
            iconname = exfilgoaltrigger.iconname;
        }
        else
        {
            iconname = exfilgoaltrigger.script_label;
        }
        
        exfilgoaltrigger = gameobjects::createuseobject( exfilteam, exfilgoaltrigger, visuals, ( 0, 0, 100 ) );
        exfilgoaltrigger.team = exfilteam;
        exfilgoaltrigger.ownerteam = game[ "defenders" ];
        exfilgoaltrigger.ownerteamcaps = 1;
        exfilgoaltrigger.origin = exfilgoaltrigger.curorigin;
        exfilgoaltrigger gameobjects::allowuse( "enemy" );
        exfilgoaltrigger gameobjects::cancontestclaim( 1 );
        exfilgoaltrigger gameobjects::setusetime( level.flagcapturetime );
        exfilgoaltrigger.onuse = &extractzone_onuse;
        exfilgoaltrigger.onbeginuse = &extractzone_onusebegin;
        exfilgoaltrigger.onenduse = &extractzone_onuseend;
        exfilgoaltrigger.oncontested = &extractzone_oncontested;
        exfilgoaltrigger.onuncontested = &extractzone_onuncontested;
        exfilgoaltrigger gameobjects::pinobjiconontriggertouch();
        exfilgoaltrigger.id = "domFlag";
        exfilgoaltrigger.extractionactive = 0;
        exfilgoaltrigger gameobjects::setcapturebehavior( "normal" );
        exfilgoaltrigger.objectivekey = objectivekey;
        exfilgoaltrigger.iconname = iconname;
        exfilgoaltrigger gameobjects::setvisibleteam( "any" );
        exfilgoaltrigger.stompprogressreward = &extractzone_stompprogressreward;
        exfilgoaltrigger.nousebar = 1;
        exfilgoaltrigger.id = "domFlag";
        exfilgoaltrigger.claimgracetime = level.flagcapturetime * 1000;
        exfilgoaltrigger gameobjects::setobjectivestatusicons( level.icondefendextract, level.iconcaptureextract );
        waitframe();
    }
    
    entities = getentarray();
    
    foreach ( entity in entities )
    {
        var_3b94f5ad6ab4ac53 = entity.script_gameobjectname;
        
        if ( isdefined( var_3b94f5ad6ab4ac53 ) )
        {
            if ( var_3b94f5ad6ab4ac53 == "bombzone" )
            {
                entity delete();
            }
        }
    }
}

// Namespace vip
// Params 1
// Checksum 0x351f3775, Offset: 0x1520
// Size: 0xf7
function extractzone_onusebegin( player )
{
    player.iscapturing = 1;
    level.canprocessot = 0;
    ownerteam = gameobjects::getownerteam();
    self.neutralizing = level.flagneutralization && ownerteam != "neutral";
    
    if ( !self.neutralized )
    {
        self.didstatusnotify = 0;
    }
    
    if ( level.capturedecay )
    {
        thread gameobjects::useobjectdecay( player.team );
    }
    
    self.prevownerteam = team_utility::getotherteam( player.team );
    obj_dom::updateflagcapturestate( player.team );
    
    if ( ownerteam == game[ "attackers" ] )
    {
        gameobjects::setobjectivestatusicons( level.iconstoppingextract, level.iconlosingextract );
        return;
    }
    
    gameobjects::setobjectivestatusicons( level.iconlosingextract, level.icontakingextract );
}

// Namespace vip
// Params 3
// Checksum 0xb575b245, Offset: 0x161f
// Size: 0xde
function extractzone_onuseend( team, player, success )
{
    level.canprocessot = 1;
    
    if ( success )
    {
        objidpoolmanager::objective_show_progress( self.objidnum, 0 );
    }
    
    if ( isplayer( player ) )
    {
        player.iscapturing = 0;
        player setclientomnvar( "ui_objective_pinned_text_param", 0 );
    }
    
    if ( !success )
    {
        self.neutralized = 0;
        ownerteam = gameobjects::getownerteam();
        
        if ( ownerteam == game[ "attackers" ] )
        {
            if ( self.extractionactive )
            {
                gameobjects::setobjectivestatusicons( "icon_waypoint_active_exfil", "icon_waypoint_prevent_exfil" );
            }
            else
            {
                gameobjects::setobjectivestatusicons( "icon_waypoint_waitfor_exfil", "icon_waypoint_prevent_exfil" );
            }
            
            return;
        }
        
        gameobjects::setobjectivestatusicons( level.icondefendextract, level.iconcaptureextract );
    }
}

// Namespace vip
// Params 1
// Checksum 0xd9196a36, Offset: 0x1705
// Size: 0x114
function extractzone_onuse( credit_player )
{
    level.canprocessot = 1;
    team = credit_player.team;
    oldteam = gameobjects::getownerteam();
    self.capturetime = gettime();
    self.neutralized = 0;
    extractzone_setcaptured( team, credit_player );
    
    if ( !self.neutralized )
    {
        if ( isdefined( level.onobjectivecomplete ) )
        {
            [[ level.onobjectivecomplete ]]( "dompoint", self.objectivekey, credit_player, team, oldteam, self );
        }
    }
    
    if ( team == game[ "attackers" ] )
    {
        playfxontag( level._effect[ "vfx_smk_signal" ], self.visuals[ 0 ], "tag_origin" );
        playannouncerbattlechatter( team, "extract_littlebird_start_a_friendly", 20 );
        credit_player vipextract( self );
        return;
    }
    
    stopfxontag( level._effect[ "vfx_smk_signal" ], self.visuals[ 0 ], "tag_origin" );
    self.extractionactive = 0;
}

// Namespace vip
// Params 0
// Checksum 0x483ec96e, Offset: 0x1821
// Size: 0x23
function extractzone_oncontested()
{
    gameobjects::setobjectivestatusicons( level.iconcontestingextract );
    objidpoolmanager::objective_set_progress_team( self.objidnum, undefined );
}

// Namespace vip
// Params 1
// Checksum 0x58474ce3, Offset: 0x184c
// Size: 0x6d
function extractzone_onuncontested( lastclaimteam )
{
    if ( self.ownerteam == game[ "attackers" ] )
    {
        if ( self.extractionactive )
        {
            gameobjects::setobjectivestatusicons( "icon_waypoint_active_exfil", "icon_waypoint_prevent_exfil" );
        }
        else
        {
            gameobjects::setobjectivestatusicons( "icon_waypoint_waitfor_exfil", "icon_waypoint_prevent_exfil" );
        }
        
        return;
    }
    
    gameobjects::setobjectivestatusicons( level.icondefendextract, level.iconcaptureextract );
}

// Namespace vip
// Params 2
// Checksum 0xb2e23def, Offset: 0x18c1
// Size: 0x1cc
function extractzone_setcaptured( team, credit_player )
{
    gameobjects::setownerteam( team );
    
    if ( self.ownerteam == game[ "attackers" ] )
    {
        gameobjects::setusetime( 5 );
        gameobjects::setobjectivestatusicons( "icon_waypoint_waitfor_exfil", "icon_waypoint_prevent_exfil" );
    }
    else
    {
        gameobjects::setusetime( 0.05 );
        gameobjects::setobjectivestatusicons( level.icondefendextract, level.iconcaptureextract );
        
        foreach ( heli in self.choppers )
        {
            heli notify( #"bugout" );
            heli notify( #"hash_98bcf0401001ea22" );
            arrayremove( self.choppers, heli );
            self.choppers = [];
            heli thread br_extract_chopper::littlebirdleave();
        }
        
        playannouncerbattlechatter( game[ "attackers" ], "extract_littlebird_leaving_a_friendly", 10 );
    }
    
    self notify( #"capture", credit_player );
    self notify( #"assault", credit_player );
    self.neutralized = 0;
    
    if ( self.touchlist[ team ].size == 0 )
    {
        self.touchlist = self.oldtouchlist;
    }
    
    thread giveflagcapturexp( self.touchlist[ team ], credit_player );
    analyticslog::logevent_gameobject( self.analyticslogtype, self.analyticslogid, self.visuals[ 0 ].origin, -1, "captured_" + team );
}

// Namespace vip
// Params 1
// Checksum 0xa6b5de35, Offset: 0x1a95
// Size: 0x15
function extractzone_stompprogressreward( player )
{
    player events::function_a7d373228760063b();
}

// Namespace vip
// Params 0
// Checksum 0x2f00991, Offset: 0x1ab2
// Size: 0x44
function getcapturetype()
{
    capturetype = "normal";
    
    if ( level.capturetype == 2 )
    {
        capturetype = "neutralize";
    }
    else if ( level.capturetype == 3 )
    {
        capturetype = "persistent";
    }
    
    return capturetype;
}

// Namespace vip
// Params 2
// Checksum 0x5cfae366, Offset: 0x1aff
// Size: 0x272
function giveflagcapturexp( touchlist, credit_player )
{
    level endon( #"game_ended" );
    first_player = credit_player;
    
    if ( isdefined( first_player.owner ) )
    {
        first_player = first_player.owner;
    }
    
    level.lastcaptime = gettime();
    
    if ( isplayer( first_player ) )
    {
        level thread hud_util::teamplayercardsplash( "callout_securedposition", first_player );
        telemetry_data = spawnstruct();
        telemetry_data.player = first_player;
        telemetry_data.eventname = "capture";
        telemetry_data.position = first_player.origin;
        telemetry_utils::function_af2d366f9522f76f( "callback_on_game_event", telemetry_data );
    }
    
    players_touching = getarraykeys( touchlist );
    
    for ( index = 0; index < players_touching.size ; index++ )
    {
        player = touchlist[ players_touching[ index ] ].player;
        
        if ( isdefined( player.owner ) )
        {
            player = player.owner;
        }
        
        if ( !isplayer( player ) )
        {
            continue;
        }
        
        if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( player ) ) )
        {
            if ( isdefined( player.leaderboarddata[ "captures" ] ) )
            {
                player.leaderboarddata[ "captures" ] = player.leaderboarddata[ "captures" ] + 1;
            }
            
            if ( isdefined( level.leaderboardfunc[ "captures" ] ) )
            {
                [[ level.leaderboardfunc[ "captures" ] ]]( player, 1 );
            }
            
            assert( isint( 1 ) || isfloat( 1 ), "<dev string:x24>" );
            
            if ( isdefined( player.pers[ "captures" ] ) )
            {
                player.pers[ "captures" ] = player.pers[ "captures" ] + 1;
            }
        }
        
        player persistence::statsetchild( "round", "captures", player.pers[ "captures" ] );
        player stats::setextrascore0( player.pers[ "captures" ], "captures" );
        player thread points::doscoreevent( #"mode_dom_secure" );
        player thread smoke_grenade::function_99543ad5d551cdb5();
        wait 0.05;
    }
}

// Namespace vip
// Params 1
// Checksum 0xf7323acb, Offset: 0x1d79
// Size: 0xc9
function vipextract( heliextractzone )
{
    heli = br_extract_chopper::spawnextractchopper( heliextractzone, heliextractzone.origin );
    
    if ( !isdefined( heliextractzone.choppers ) )
    {
        heliextractzone.choppers = [];
    }
    
    heliextractzone.choppers[ heliextractzone.choppers.size ] = heli;
    self iprintlnbold( "Extraction copter en route!" );
    heli.extractzone = heliextractzone;
    heli.extractteam = self.team;
    heliextractzone.curorigin = heliextractzone.origin;
    heliextractzone.offset3d = ( 0, 0, 30 );
    heliextractzone thread extracttriggerwatcher( heli );
}

// Namespace vip
// Params 1
// Checksum 0xef43882, Offset: 0x1e4a
// Size: 0x153
function extracttriggerwatcher( heli )
{
    level endon( #"game_ended" );
    heli endon( #"bugout" );
    heli waittill( #"hash_98bcf0401001ea22" );
    self.extractionactive = 1;
    playannouncerbattlechatter( heli.extractteam, "extract_littlebird_close_a_friendly", 10 );
    
    if ( self.stalemate )
    {
        gameobjects::setobjectivestatusicons( level.iconcontestingextract );
    }
    else
    {
        gameobjects::setobjectivestatusicons( "icon_waypoint_active_exfil", "icon_waypoint_prevent_exfil" );
    }
    
    while ( true )
    {
        self.trigger waittill( #"trigger", player );
        
        if ( !self.stalemate )
        {
            if ( player.isagentvip && self.numtouching[ game[ "defenders" ] ] == 0 )
            {
                level thread vip_endgame( player.team, game[ "end_reason" ][ "objective_completed" ] );
                break;
            }
            
            if ( player.team == self.team && isdefined( player.carryobject ) )
            {
                level thread vip_endgame( player.team, game[ "end_reason" ][ "objective_completed" ] );
                break;
            }
        }
    }
}

// Namespace vip
// Params 0
// Checksum 0x3e09e00f, Offset: 0x1fa5
// Size: 0x90
function createthreatbiasgroups()
{
    waitframe();
    createthreatbiasgroup( "vip" );
    
    foreach ( team in level.teamnamelist )
    {
        createthreatbiasgroup( team );
        setignoremegroup( team, "vip" );
    }
}

// Namespace vip
// Params 0
// Checksum 0xd5cf26a7, Offset: 0x203d
// Size: 0x375
function spawnvip()
{
    level endon( #"game_ended" );
    wait 2;
    bombtrigger = getent( "sd_bomb_pickup_trig", #targetname );
    agent = undefined;
    spawnloc = undefined;
    level.allowhvtspawn = 1;
    
    while ( !isdefined( agent ) )
    {
        agent = agent_common::connectnewagent( "player", game[ "attackers" ] );
        
        if ( isdefined( agent ) )
        {
            spawnloc = bombtrigger.origin;
            bombtrigger delete();
            agent thread [[ agent agent_utility::agentfunc( "spawn" ) ]]( spawnloc, ( 0, 0, 0 ) );
            nearestnode = agent getnearestnode();
            agent setorigin( nearestnode.origin );
            agent.team = game[ "attackers" ];
            agent bots_util_mp::bot_set_difficulty( "recruit" );
            agent.outlineid = outline::outlineenableforteam( agent, agent.team, "outline_nodepth_green", "lowest" );
            agent.nocorpse = 1;
            agent.isdowned = 0;
            agent.isagentvip = 1;
            trigger = spawn( "script_model", agent.origin + ( 0, 0, 30 ) );
            trigger.team = game[ "attackers" ];
            trigger.destination = agent.origin;
            trigger linkto( agent );
            trigger usability::maketeamusable( trigger.team );
            trigger sethintstring( &"mp/hold_to_escort_vip" );
            trigger setusepriority( -4 );
            agent.trigger = trigger;
            agent.ownerteam = trigger.team;
            agent.interactteam = "friendly";
            agent.requireslos = 1;
            agent.exclusiveuse = 0;
            agent.curprogress = 0;
            agent.usetime = 0;
            agent.userate = 1;
            agent.id = "care_package";
            agent.skiptouching = 1;
            agent.onuse = &agent_onuse;
            agent thread gameobjects::useobjectusethink();
            agent.trackedobject = agent gameobjects::createtrackedobject( agent, ( 0, 0, 70 ) );
            agent.trackedobject.objidpingfriendly = 0;
            agent.trackedobject.objidpingenemy = 0;
            agent.trackedobject.objpingdelay = 0.05;
            agent.trackedobject.visibleteam = "friendly";
            agent.invulnerable = 1;
            agent.trackedobject gameobjects::setobjectivestatusicons( level.iconescort );
            continue;
        }
        
        waitframe();
    }
    
    agent setthreatbiasgroup( "vip" );
    agent thread hvtclearmove( spawnloc );
    agent thread hvtdeathwatcher();
    agent takeallweapons();
    waitframe();
    agent inventory_utility::_giveweapon( level.defaultfist, undefined, undefined, 1 );
    level.vip = agent;
}

// Namespace vip
// Params 1
// Checksum 0x939e6866, Offset: 0x23ba
// Size: 0x51
function hvtclearmove( spawnloc )
{
    self botsetscriptgoal( spawnloc, 20, "critical" );
    result = bots_util::bot_waittill_goal_or_fail();
    
    while ( !isdefined( self.tetherplayer ) )
    {
        self botsetflag( "disable_movement", 1 );
        wait 0.1;
    }
}

// Namespace vip
// Params 1
// Checksum 0x8d93b252, Offset: 0x2413
// Size: 0x82
function agent_onuse( player )
{
    print::printboldonteam( "HVT is following " + player.name, player.team );
    self.following = 1;
    self.usetime = 1000;
    thread followplayer( player );
    player thread watchownerdeath( self );
    self.trigger usability::maketeamusable( self.team );
    self.trigger disableplayeruse( player );
}

// Namespace vip
// Params 1
// Checksum 0x27291079, Offset: 0x249d
// Size: 0x216
function followplayer( player )
{
    self endon( #"game_ended" );
    self.tetherplayer = player;
    level.tetherplayer = player;
    self botsetflag( "disable_movement", 0 );
    level thread hud_message::updatematchstatushintforallplayers( player.team, #"vip_extract", #"vip_stop_extract", level.tetherplayer, #"vip_escort" );
    
    while ( isdefined( self.tetherplayer ) )
    {
        tetherstance = self.tetherplayer getstance();
        self botsetstance( tetherstance );
        
        if ( self.tetherplayer issprinting() )
        {
            self botsetflag( "cautious", 0 );
            self botsetflag( "force_sprint", 1 );
        }
        else
        {
            self botsetflag( "force_sprint", 0 );
            self botsetflag( "cautious", 1 );
        }
        
        if ( distance2dsquared( self.tetherplayer.origin, self.origin ) < 10000 )
        {
            level.vipdist = distance2dsquared( self.tetherplayer.origin, self.origin );
        }
        else if ( distance2dsquared( self.tetherplayer.origin, self.origin ) > 10000 )
        {
            level.vipdist = distance2dsquared( self.tetherplayer.origin, self.origin );
            goalnode = self getclosestreachablepointonnavmesh( self.tetherplayer.origin );
            
            /#
                sphere( goalnode, 32, ( 0, 1, 0 ), 1, 50 );
            #/
            
            if ( isdefined( goalnode ) )
            {
                self botsetpathingstyle( "sneak" );
                self botsetscriptgoal( goalnode, 32, "tactical" );
                pathresult = bots_util::bot_waittill_goal_or_fail( 3 );
                
                if ( pathresult == "goal" )
                {
                }
            }
        }
        
        wait 0.15;
    }
    
    level.tetherplayer = undefined;
}

// Namespace vip
// Params 1
// Checksum 0x96d330ea, Offset: 0x26bb
// Size: 0x86
function watchownerdeath( vip )
{
    self endon( #"game_ended" );
    vip endon( #"tether_swap" );
    self waittill( #"death" );
    vip.following = 0;
    vip.usetime = 0;
    vip.tetherplayer = undefined;
    level.tetherplayer = undefined;
    level thread hud_message::updatematchstatushintforallplayers( vip.team, #"vip_secure", #"vip_stop_extract" );
}

// Namespace vip
// Params 0
// Checksum 0x55cd268a, Offset: 0x2749
// Size: 0xbd
function hvtdeathwatcher()
{
    self endon( #"game_ended" );
    self endon( #"hvt_timeout" );
    self waittill( #"death" );
    self.trackedobject gameobjects::releaseid();
    self.trigger usability::setallunusable();
    level.hostages[ 0 ] = spawnhostage( self.origin, self.team, 1 );
    level.hostages[ 0 ].outlineid = outline::outlineenableforteam( level.hostages[ 0 ].body, level.hostages[ 0 ].team, "outline_nodepth_cyan", "killstreak_personal" );
}

// Namespace vip
// Params 0
// Checksum 0x6f2d5c8f, Offset: 0x280e
// Size: 0x1a2
function updatematchstatushintonspawn()
{
    level endon( #"game_ended" );
    level flags::gameflagwait( "prematch_done" );
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    if ( isdefined( level.vip ) )
    {
        if ( isdefined( level.tetherplayer ) )
        {
            if ( level.tetherplayer.team == self.team )
            {
                if ( level.tetherplayer == self )
                {
                    hud_message::function_ef4318a0090caa0f( #"vip_escort" );
                }
                else
                {
                    hud_message::function_ef4318a0090caa0f( #"vip_extract" );
                }
            }
            else
            {
                hud_message::function_ef4318a0090caa0f( #"vip_stop_extract" );
            }
        }
        else if ( level.vip.team == self.team )
        {
            hud_message::function_ef4318a0090caa0f( #"vip_secure" );
        }
        else
        {
            hud_message::function_ef4318a0090caa0f( #"vip_stop_extract" );
        }
        
        return;
    }
    
    if ( isdefined( level.hostagecarrier ) )
    {
        if ( level.hostagecarrier.team == self.team )
        {
            if ( level.hostagecarrier == self )
            {
                hud_message::function_ef4318a0090caa0f( #"vip_carry" );
            }
            else
            {
                hud_message::function_ef4318a0090caa0f( #"vip_extract" );
            }
        }
        else
        {
            hud_message::function_ef4318a0090caa0f( #"vip_stop_extract" );
        }
        
        return;
    }
    
    if ( level.hostages[ 0 ].team == self.team )
    {
        hud_message::function_ef4318a0090caa0f( #"vip_secure" );
        return;
    }
    
    hud_message::function_ef4318a0090caa0f( #"vip_stop_extract" );
}

// Namespace vip
// Params 3
// Checksum 0x1eeb013f, Offset: 0x29b8
// Size: 0xfc
function playannouncerbattlechatter( team, soundname, suffix )
{
    level endon( #"game_ended" );
    faction = "ustl";
    soundalias = "dx_mpa_" + faction + "_" + soundname + "_" + suffix;
    
    if ( soundexists( soundalias ) )
    {
        foreach ( player in level.players )
        {
            if ( player.team == team )
            {
                player queuedialogforplayer( #"queue1", soundalias, soundname, 2 );
            }
        }
    }
}

// Namespace vip
// Params 0
// Checksum 0xb2a422a4, Offset: 0x2abc
// Size: 0x30
function votimeendingsoon()
{
    level endon( #"game_ended" );
    level waittill( #"match_ending_very_soon" );
    playannouncerbattlechatter( game[ "attackers" ], "extract_littlebird_leaving_soon_a_friendly", 10 );
}

// Namespace vip
// Params 3
// Checksum 0xb7910e63, Offset: 0x2af4
// Size: 0x524
function spawnhostage( spawnpt, var_50cc15233bf656e4, showicon = 1 )
{
    if ( game_utility::getgametype() == "vip" )
    {
        var_50cc15233bf656e4 = game[ "attackers" ];
        var_24ee58da36249a14 = "body_opforce_london_terrorist_1_2";
        var_74647ed34c67176f = "head_male_bc_03";
    }
    else
    {
        var_50cc15233bf656e4 = "neutral";
        var_24ee58da36249a14 = "body_mp_western_fireteam_west_ar_1_1_lod1";
        var_74647ed34c67176f = "head_mp_western_fireteam_west_ar_1_1";
    }
    
    hostage = spawn( "script_model", spawnpt );
    hostagebase = spawn( "script_model", spawnpt );
    hostagehead = spawn( "script_model", spawnpt );
    hostagebase setmodel( var_24ee58da36249a14 );
    hostagehead setmodel( var_74647ed34c67176f );
    hostagehead linkto( hostagebase, "j_neck", ( -9, 1, 0 ), ( 0, 0, 0 ) );
    hostagebase linkto( hostage, "", ( 0, 0, -48 ), ( 0, 0, 0 ) );
    trigger = spawn( "script_model", spawnpt );
    trigger.team = var_50cc15233bf656e4;
    trigger.destination = spawnpt;
    hostage.trigger = trigger;
    trigger linkto( hostage );
    hostage.trigger makeusable();
    hostage.body = hostagebase;
    hostage.head = hostagehead;
    hostage = drophostage( undefined, hostage, spawnpt, 1 );
    hostage.teamscored[ "allies" ] = 0;
    hostage.teamscored[ "axis" ] = 0;
    hostage.wasindent = 0;
    hostage.requireslos = 1;
    hostage.setdropped = &drophostage;
    hostage.team = var_50cc15233bf656e4;
    hostage.usehostagedrop = 1;
    hostage.ownerteam = var_50cc15233bf656e4;
    hostage.interactteam = var_50cc15233bf656e4 == "neutral" ? "any" : "friendly";
    hostage.exclusiveuse = 0;
    hostage.curprogress = 0;
    hostage.usetime = game_utility::getgametype() == "cmd" ? 500 : 0;
    hostage.userate = 1;
    hostage.id = "care_package";
    hostage.skiptouching = 1;
    hostage thread gameobjects::useobjectusethink();
    attachobj = spawn( "script_model", spawnpt );
    attachobj linkto( hostage );
    hostage.attachobj = attachobj;
    
    if ( var_50cc15233bf656e4 == "neutral" )
    {
        var_9128fc0e0ed1d40b = "any";
        visibleteam = "any";
    }
    else
    {
        var_9128fc0e0ed1d40b = "friendly";
        visibleteam = "friendly";
    }
    
    if ( game_utility::getgametype() != "cmd" && showicon )
    {
        hostage.trackedobject = hostage gameobjects::createtrackedobject( attachobj, ( 0, 0, 0 ) );
        hostage.trackedobject.objidpingfriendly = 0;
        hostage.trackedobject.objidpingenemy = 1;
        hostage.trackedobject.objpingdelay = 2;
        hostage.trackedobject gameobjects::allowcarry( var_9128fc0e0ed1d40b );
        hostage.trackedobject gameobjects::setownerteam( hostage.ownerteam );
        hostage.trackedobject gameobjects::setobjectivestatusicons( level.iconrecover, level.iconrecover );
        hostage.trackedobject.cancontestclaim = 1;
        hostage.trackedobject.stalemate = 0;
        hostage.trackedobject.wasstalemate = 1;
        hostage.trackedobject gameobjects::setvisibleteam( visibleteam );
    }
    
    if ( isdefined( hostage.trackedobject ) )
    {
        hostage.trackedobject gameobjects::allowcarry( var_50cc15233bf656e4 );
        hostage.trackedobject gameobjects::setownerteam( var_50cc15233bf656e4 );
        hostage.trackedobject gameobjects::setobjectivestatusicons( level.iconrecover, level.iconrecover );
        
        if ( game_utility::getgametype() == "btm" || game_utility::getgametype() == "arm" || game_utility::getgametype() == "conflict" )
        {
            hostage.trackedobject.cancontestclaim = 1;
            hostage.trackedobject.stalemate = 0;
            hostage.trackedobject.wasstalemate = 1;
        }
        
        hostage.trackedobject gameobjects::setvisibleteam( visibleteam );
    }
    
    return hostage;
}

// Namespace vip
// Params 5
// Checksum 0x801c9532, Offset: 0x3021
// Size: 0x598
function drophostage( player, hostage, position, spawndrop, waittime )
{
    self notify( #"gameobject_deleted" );
    
    if ( !isdefined( player ) )
    {
        player = self.carrier;
    }
    
    if ( !isdefined( position ) )
    {
        position = self.curorigin;
    }
    
    if ( !isdefined( hostage ) )
    {
        hostage = self;
    }
    
    hostage notify( #"dropped" );
    
    if ( isdefined( hostage.trackedobject ) )
    {
        hostage.trackedobject.carrier = hostage.attachobj;
        hostage.trackedobject gameobjects::setobjectivestatusicons( level.iconrecover, level.iconrecover );
        
        if ( game_utility::getgametype() != "cmd" && game_utility::getgametype() != "btm" || game_utility::getgametype() == "arm" || game_utility::getgametype() == "conflict" )
        {
        }
    }
    
    if ( isdefined( level.hostagegoalent ) )
    {
        level.hostagegoalent gameobjects::setvisibleteam( "none" );
        level.hostagegoalent gameobjects::releaseid();
    }
    
    if ( game_utility::getgametype() == "btm" && isdefined( level.vipextractzones ) )
    {
        level.vipextractzones[ player.team ].goalent gameobjects::setvisibleteam( "none" );
    }
    
    hostage.carried = 0;
    droppt = position;
    hostage unlink();
    droppt = isnavmeshloaded() ? getclosestpointonnavmesh( position ) : position;
    hostage.origin = getphysicspointaboutnavmesh( droppt ) + ( 0, 0, 2 );
    hostage.angles = ( 0, hostage.angles[ 1 ], 0 );
    
    if ( !isdefined( spawndrop ) && isdefined( hostage.useobj ) )
    {
        hostage.useobj.origin = hostage.origin;
    }
    
    if ( isdefined( player ) )
    {
        player.carryobject = undefined;
        
        foreach ( hstg in level.hostages )
        {
            if ( hstg != hostage )
            {
                hstg enableplayeruse( player );
            }
        }
    }
    
    if ( isdefined( hostage.wmhostage ) )
    {
        hostage.wmhostage unlink();
        hostage.wmhostage.head delete();
        hostage.wmhostage delete();
        hostage.wmhostage = undefined;
    }
    
    if ( isdefined( waittime ) )
    {
        wait waittime;
    }
    
    if ( isdefined( player ) && isdefined( player.hostagecarried ) )
    {
        player.hostagecarried.body show();
        player.hostagecarried.head show();
        player.hostagecarried = undefined;
    }
    else
    {
        hostage.body show();
        hostage.head show();
    }
    
    hostage.trigger makeusable();
    
    if ( isdefined( waittime ) )
    {
    }
    
    level.hostagecarrier = undefined;
    
    if ( game_utility::getgametype() == "vip" )
    {
        foreach ( player in level.players )
        {
            if ( player.team != hostage.trigger.team )
            {
                hostage.trigger disableplayeruse( player );
                hostage.trigger hidefromplayer( player );
            }
        }
        
        hostage.trigger sethintstring( &"mp/hold_to_pickup_vip" );
        level thread hud_message::updatematchstatushintforallplayers( hostage.team, #"vip_secure", #"vip_stop_extract" );
    }
    else if ( game_utility::getgametype() == "btm" )
    {
        hostage.trigger sethintstring( &"mp/hold_to_pickup_vip" );
        level thread hud_message::updatematchstatushintforallplayers( hostage.team, #"vip_secure", #"vip_stop_extract" );
    }
    else
    {
        hostage.trigger sethintstring( &"mp/hold_to_pickup_hostage" );
    }
    
    hostage setusepriority( -4 );
    
    if ( isdefined( hostage.curobjid ) )
    {
        objective_setownerteam( hostage.curobjid, "neutral" );
    }
    
    if ( isdefined( hostage.body ) )
    {
        hostage.body linkto( hostage, "", ( 0, 0, 0 ), ( 0, 0, 0 ) );
        hostage.body scriptmodelplayanimdeltamotion( "hm_grnd_civ_react02_idle07" );
    }
    
    return hostage;
}

// Namespace vip
// Params 1
// Checksum 0x6080ebaf, Offset: 0x35c2
// Size: 0x89
function getphysicspointaboutnavmesh( pt )
{
    contents = trace::create_contents( undefined, 1, 1, undefined, undefined, undefined, undefined );
    var_51967c121bcf18a3 = physics_raycast( pt + ( 0, 0, 48 ), pt - ( 0, 0, 48 ), contents, undefined, 0, "physicsquery_closest" );
    hit = var_51967c121bcf18a3.size > 0;
    
    if ( hit )
    {
        hitpos = var_51967c121bcf18a3[ 0 ][ "position" ];
        return hitpos;
    }
    
    return pt;
}

