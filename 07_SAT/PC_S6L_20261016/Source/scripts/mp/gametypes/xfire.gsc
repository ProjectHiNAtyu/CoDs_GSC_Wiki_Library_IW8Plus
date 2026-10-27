// scripts\mp\gametypes\xfire.gsc  (hash_5bf38ad0e3e6aeb8.gscc) (size: 23016 Bytes / 0x59e8 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x62d5d3b5 (1658180533)
// size ...... 23016 (0x59e8)
// includes .. 30  (offset: 0x4e80)
// strings ... 150 (offset: 0x4f70)
// dev strs .. 4   (offset: 0x59ac)
// exports ... 39  (offset: 0x35d8)
// cseg ...... 0xd0f + 0x28c9 (0x35d8)
// imports ... 153 (offset: 0x3bf0)
// animtree1 . 0   (offset: 0x59e8)
// animtree2 . 0   (offset: 0x59e8)
#using script_3bdadfff7554ceba;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\mp\bots\bots;
#using scripts\mp\common\utility\damage;
#using scripts\mp\common\utility\debug;
#using scripts\mp\common\utility\dialog;
#using scripts\mp\common\utility\disconnect_event_aggregator;
#using scripts\mp\common\utility\dvars;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\print;
#using scripts\mp\common\utility\team_utility;
#using scripts\mp\common\utility\teams;
#using scripts\mp\damage;
#using scripts\mp\events;
#using scripts\mp\flags;
#using scripts\mp\gamelogic;
#using scripts\mp\gameobjects;
#using scripts\mp\gametypes\arena;
#using scripts\mp\gametypes\bradley_spawner;
#using scripts\mp\gametypes\common;
#using scripts\mp\gametypes\obj_dom;
#using scripts\mp\globallogic;
#using scripts\mp\hud_message;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\spawnlogic;
#using scripts\mp\spectating;

#namespace xfire;

// Namespace xfire
// Params 0
// Checksum 0x890c131d, Offset: 0xd2d
// Size: 0x305
function main()
{
    if ( getdvar( @"g_mapname" ) == "mp_background" )
    {
        return;
    }
    
    globallogic::init();
    globallogic::setupcallbacks();
    allowed[ 0 ] = game_utility::getgametype();
    gameobjects::main( allowed );
    level.initializematchrules = &initializematchrules;
    [[ level.initializematchrules ]]();
    level thread game_utility_mp::reinitializematchrulesonmigration();
    updategametypedvars();
    level.ontimelimit = &ontimelimit;
    level.teambased = 1;
    level.onstartgametype = &onstartgametype;
    level.getspawnpoint = &getspawnpoint;
    level.onnormaldeath = &onnormaldeath;
    level.onplayerkilled = &onplayerkilled;
    level.modeonspawnplayer = &onspawnplayer;
    level.onplayerconnect = &onplayerconnect;
    level.ontimelimitot = &ontimelimitot;
    level.checkforlaststandwipe = &xfire_checkforlaststandwipe;
    level.objectivebased = 1;
    level.overridetimelimitclock = 15;
    
    if ( !getdvarint( @"hash_d398d397afae6d0", 0 ) )
    {
        level.allowlatecomers = 0;
    }
    
    game[ "dialog" ][ "gametype" ] = "dx_mp_mcut_mode_t141_name";
    
    if ( game_utility::function_d3f8957534dc62af() )
    {
        game[ "dialog" ][ "gametype" ] = "hc_" + game[ "dialog" ][ "gametype" ];
    }
    else if ( level.forcethirdperson )
    {
        game[ "dialog" ][ "gametype" ] = "thirdp_" + game[ "dialog" ][ "gametype" ];
    }
    
    game[ "dialog" ][ "boost" ] = "iw9_mtdm_mode_uktl_bost";
    game[ "dialog" ][ "offense_obj" ] = "iw9_mtdm_mode_uktl_bost";
    game[ "dialog" ][ "defense_obj" ] = "iw9_mtdm_mode_uktl_bost";
    game[ "dialog" ][ "team_eliminated" ] = "dx_mp_mcut_mode_t141_telm";
    hud_message::function_e369cd82a03687e0();
    
    if ( game_utility_mp::matchmakinggame() )
    {
        level.shouldgamelobbyremainintact = &shouldgamelobbyremainintact;
    }
    
    level thread outlinemultiteam();
    namespace_a60e6d7e4e2fbfbf::function_9c34b2b20eea4249( 3 );
    namespace_a60e6d7e4e2fbfbf::function_654398669848ca76( [ "allies", "axis", "team_three" ] );
    level.var_6e5750bc280a95dc = 0;
    level.var_d30790bd1daefad5 = 0;
    level.var_c9c131a041796786 = 0;
    setomnvar( "ui_cutthroat_num_reviving_team_1", 0 );
    setomnvar( "ui_cutthroat_num_reviving_team_2", 0 );
    setomnvar( "ui_cutthroat_num_reviving_team_3", 0 );
    level.var_4e8e29cfe8ef37d7 = 0;
    level.var_1d69db637f5dd116 = 0;
    level.var_3b80f5dc06da38e5 = 0;
    setomnvar( "ui_cutthroat_num_downed_team_1", 0 );
    setomnvar( "ui_cutthroat_num_downed_team_2", 0 );
    setomnvar( "ui_cutthroat_num_downed_team_3", 0 );
    callback::add( #"player_laststand", &function_e0893a969443e61d );
    callback::add( #"player_laststand_exit", &function_a6c97d841e5c9801 );
    callback::add( #"player_laststand_revive_start", &function_efd2167e7472f820 );
    callback::add( #"hash_bca297ef8a461ca2", &function_4adc8ecb32cc78c1 );
}

// Namespace xfire
// Params 1
// Checksum 0xd7ad35d8, Offset: 0x103a
// Size: 0x18
function onplayerconnect( player )
{
    disconnect_event_aggregator::registerondisconnecteventcallback( &onplayerdisconnect );
}

// Namespace xfire
// Params 1
// Checksum 0xfc5e3da, Offset: 0x105a
// Size: 0xc
function onplayerdisconnect( player )
{
    
}

// Namespace xfire
// Params 0
// Checksum 0x5bb8172e, Offset: 0x106e
// Size: 0x34
function initializematchrules()
{
    game_utility_mp::setcommonrulesfrommatchrulesdata();
    setdynamicdvar( @"scr_war_promode", 0 );
    setdynamicdvar( @"scr_xfire_wincondition", getmatchrulesdata( "arenaData", "winCondition" ) );
}

// Namespace xfire
// Params 0
// Checksum 0x1e897d29, Offset: 0x10aa
// Size: 0x17d
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
    
    foreach ( entry in level.teamnamelist )
    {
        game_utility_mp::setobjectivetext( entry, &"objectives/war" );
        
        if ( level.splitscreen )
        {
            game_utility_mp::setobjectivescoretext( entry, &"objectives/war" );
        }
        else
        {
            game_utility_mp::setobjectivescoretext( entry, &"objectives/war_score" );
        }
        
        game_utility_mp::setobjectivehinttext( entry, &"objectives/war_hint" );
    }
    
    if ( isdefined( level.initspawnsoverridefunc ) )
    {
        [[ level.initspawnsoverridefunc ]]();
    }
    else
    {
        initspawns();
    }
    
    setupwaypointicons();
    seticonnames();
    thread arena::waittooverridegraceperiod();
    bradley_spawner::inittankspawns();
    level thread spawngameendflagzone( 1 );
    
    /#
        if ( false )
        {
            function_3d2f6adc4704da26();
        }
    #/
}

// Namespace xfire
// Params 0
// Checksum 0xb4ffa76b, Offset: 0x122f
// Size: 0xb8
function updategametypedvars()
{
    common::updatecommongametypedvars();
    level.overtimeflag = dvars::dvarfloatvalue( "overtimeFlag", 10, 0, 30 );
    
    if ( level.overtimeflag > 0 )
    {
        level.ontimelimitgraceperiod = level.overtimeflag;
        level.currenttimelimitdelay = 0;
        level.canprocessot = 1;
    }
    
    level.wincondition = dvars::dvarintvalue( "winCondition", 1, 0, 2 );
    setomnvar( "ui_wincondition", level.wincondition );
    level.objmodifier = dvars::dvarintvalue( "objModifier", 0, 0, 4 );
    level.flagcapturetime = dvars::dvarfloatvalue( "flagCaptureTime", 3, 0, 30 );
}

// Namespace xfire
// Params 0
// Checksum 0xc1cbed74, Offset: 0x12ef
// Size: 0x148
function initspawns()
{
    spawnlogic::function_6dbabb72223a4bca();
    spawnlogic::setactivespawnlogic( #"default" );
    spawnlogic::addstartspawnpoints( "mp_tdm_spawn_allies_start" );
    spawnlogic::addstartspawnpoints( "mp_tdm_spawn_axis_start" );
    spawnlogic::addspawnpointslegacy( game[ "attackers" ], "mp_tdm_spawn_allies_start" );
    spawnlogic::addspawnpointslegacy( game[ "defenders" ], "mp_tdm_spawn_axis_start" );
    attackers = spawnlogic::getspawnpointarray( "mp_tdm_spawn_allies_start" );
    defenders = spawnlogic::getspawnpointarray( "mp_tdm_spawn_axis_start" );
    spawnlogic::registerspawnset( #"start_attackers", attackers );
    spawnlogic::registerspawnset( #"start_defenders", defenders );
    spawnlogic::addspawnpointslegacy( "allies", "mp_tdm_spawn" );
    spawnlogic::addspawnpointslegacy( "axis", "mp_tdm_spawn" );
    spawnlogic::addspawnpointslegacy( "allies", "mp_tdm_spawn_secondary", 1, 1 );
    spawnlogic::addspawnpointslegacy( "axis", "mp_tdm_spawn_secondary", 1, 1 );
    spawns = spawnlogic::getspawnpointarray( "mp_tdm_spawn" );
    spawnssecondary = spawnlogic::getspawnpointarray( "mp_tdm_spawn_secondary" );
    spawnlogic::registerspawnset( #"primary", spawns );
    spawnlogic::registerspawnset( #"fallback", spawnssecondary );
    spawnlogic::finalizemap();
}

// Namespace xfire
// Params 0
// Checksum 0xd3858266, Offset: 0x143f
// Size: 0x1ef
function getspawnpoint()
{
    spawnteam = self.pers[ "team" ];
    
    if ( !isdefined( level.var_cb02295cc7eccd8c ) )
    {
        level.var_cb02295cc7eccd8c = [];
    }
    
    if ( !isdefined( level.var_cb02295cc7eccd8c[ spawnteam ] ) )
    {
        level.var_cb02295cc7eccd8c[ spawnteam ] = [];
    }
    
    teams_shifted = level.teamnamelist;
    
    for ( i = 0; i < game[ "roundsPlayed" ] ; i++ )
    {
        teams_shifted[ teams_shifted.size ] = teams_shifted[ 0 ];
        teams_shifted = utility::array_slice( teams_shifted, 1, level.teamnamelist.size + 1 );
    }
    
    teams_key = [];
    
    foreach ( index, team in level.teamnamelist )
    {
        teams_key[ team ] = teams_shifted[ index ];
    }
    
    spawns = getspawnarray( "mp_xfire_spawn_" + teams_key[ spawnteam ] + "_start" );
    
    foreach ( spawner in spawns )
    {
        if ( isdefined( level.var_cb02295cc7eccd8c[ spawnteam ][ spawner.index ] ) )
        {
            continue;
        }
        
        level.var_cb02295cc7eccd8c[ spawnteam ][ spawner.index ] = spawner;
        return spawner;
    }
    
    return utility::array_random( spawns );
}

// Namespace xfire
// Params 1
// Checksum 0xce5bd3ec, Offset: 0x1637
// Size: 0x2f0
function spawngameendflagzone( ispreview )
{
    arenaflag = getentarray( "flag_xfire", #targetname );
    arenaflagindex = randomint( arenaflag.size );
    gamelogic_mp::setwaypointiconinfo( "icon_waypoint_locked", 0, "neutral", "MP_INGAME_ONLY/OBJ_LOCKED_CAPS", "icon_waypoint_locked", 0, undefined );
    gamelogic_mp::setwaypointiconinfo( "icon_waypoint_ot", 0, "neutral", "MP_INGAME_ONLY/OBJ_OTFLAGLOC_CAPS", "icon_waypoint_overtime", 0 );
    
    if ( !isdefined( arenaflag[ arenaflagindex ] ) )
    {
        assertmsg( "<dev string:x24>" );
        return;
    }
    
    level.arenaflag = arenaflag[ arenaflagindex ];
    trigger = arenaflag[ arenaflagindex ];
    
    if ( isdefined( trigger.target ) )
    {
        visuals[ 0 ] = getent( trigger.target, #targetname );
    }
    else
    {
        visuals[ 0 ] = spawn( "script_model", trigger.origin );
        visuals[ 0 ].angles = trigger.angles;
    }
    
    trigger.objectivekey = "_a";
    trigger.iconname = "_a";
    arenaflag = obj_dom::setupobjective( trigger, "neutral", undefined, 1 );
    arenaflag.iconname = "";
    arenaflag.onuse = &function_dcda5232cc5c9423;
    arenaflag.onbeginuse = &arena::arenaflag_onusebegin;
    arenaflag.onenduse = &arena::arenaflag_onuseend;
    arenaflag.onuseupdate = &arena::arenaflag_onuseupdate;
    arenaflag.oncontested = &arena::arenaflag_oncontested;
    arenaflag.onuncontested = &arena::arenaflag_onuncontested;
    arenaflag.isarena = 1;
    arenaflag gameobjects::pinobjiconontriggertouch();
    arenaflag.id = "domFlag";
    arenaflag.scriptable delete();
    arenaflag gameobjects::setcapturebehavior( "persistent" );
    arenaflag.ignorestomp = 1;
    level.objectives[ arenaflag.objectivekey ] = arenaflag;
    level.arenaflag = arenaflag;
    level thread function_4795458aff7815ea();
    
    if ( ispreview )
    {
        wait 0.1;
        level.arenaflag gameobjects::requestid( 1, 1, undefined, 0, 0 );
        level.arenaflag.visibleteam = "any";
        level.arenaflag gameobjects::setobjectivestatusicons( "icon_waypoint_locked" );
        level.arenaflag gameobjects::enableobject();
        level.arenaflag gameobjects::allowuse( "none" );
        level.arenaflag.flagmodel show();
        return;
    }
    
    level.arenaflag gameobjects::requestid( 1, 1, undefined, 0, 0 );
    level.arenaflag arena::disableotflag();
}

// Namespace xfire
// Params 0
// Checksum 0xa477afdd, Offset: 0x192f
// Size: 0x29
function function_4795458aff7815ea()
{
    flags::gameflagwait( "prematch_done" );
    level.arenaflag thread gameobjects::function_d7321ef757ecefd7( dvars::getwatcheddvar( "timeLimit" ) );
}

// Namespace xfire
// Params 0
// Checksum 0xdd34f95d, Offset: 0x1960
// Size: 0xb9
function enableotflag()
{
    while ( !flags::gameflag( "prematch_done" ) )
    {
        waitframe();
    }
    
    level.arenaflag.iconname = "_a";
    level thread arena::shouldplayerovertimedialog();
    level thread arena::showflagoutline();
    level.arenaflag gameobjects::setobjectivestatusicons( level.iconneutral );
    level.arenaflag gameobjects::allowuse( "enemy" );
    level notify( #"ot_enabled" );
    level.arenaflag.flagmodel playsound( "jup_shared_zone_spawned" );
    level callback::callback( #"music_event", { #event_type:#"overtime" } );
}

// Namespace xfire
// Params 1
// Checksum 0xc6823f0f, Offset: 0x1a21
// Size: 0x1b3
function function_dcda5232cc5c9423( credit_player )
{
    level.canprocessot = 1;
    team = credit_player.pers[ "team" ];
    oldteam = gameobjects::getownerteam();
    otherteam1 = team_utility::getotherteam( team );
    otherteam2 = team_utility::getenemyteams( team )[ 1 ];
    objidpoolmanager::objective_set_progress( self.objidnum, 0 );
    objidpoolmanager::objective_show_progress( self.objidnum, 0 );
    self.capturetime = gettime();
    self.neutralized = 0;
    dialog::statusdialog( "lost" + self.objectivekey, otherteam1 );
    dialog::statusdialog( "lost" + self.objectivekey, otherteam2 );
    dialog::statusdialog( "secured" + self.objectivekey, team );
    thread print::printandsoundoneveryone( team, otherteam1, undefined, undefined, "mp_dom_flag_captured", "mp_dom_flag_lost", credit_player );
    thread print::printandsoundoneveryone( team, otherteam2, undefined, undefined, "mp_dom_flag_captured", "mp_dom_flag_lost", credit_player );
    obj_dom::dompoint_setcaptured( team, credit_player );
    
    if ( !self.neutralized )
    {
        if ( isdefined( level.onobjectivecomplete ) )
        {
            [[ level.onobjectivecomplete ]]( "dompoint", self.objectivekey, credit_player, team, oldteam, self );
        }
        
        self.firstcapture = 0;
    }
    
    game[ "dialog" ][ "round_success" ] = "gamestate_win_capture";
    game[ "dialog" ][ "round_failure" ] = "gamestate_lost_capture";
    level thread gamelogic_mp::endgame( team, game[ "end_reason" ][ "arena_otflag_completed" ], game[ "end_reason" ][ "arena_otflag_failed" ] );
}

// Namespace xfire
// Params 1
// Checksum 0xd37f37a0, Offset: 0x1bdc
// Size: 0x58
function onspawnplayer( revivespawn )
{
    hud_message::function_ef4318a0090caa0f( #"kill" );
    thread onspawnfinished();
    
    if ( getdvarint( @"hash_d398d397afae6d0", 0 ) && game[ "roundsPlayed" ] == 0 )
    {
        level thread function_2c1290dd9f35cbf( self.pers[ "team" ] );
    }
}

// Namespace xfire
// Params 0
// Checksum 0xe044dc6e, Offset: 0x1c3c
// Size: 0xb6
function onspawnfinished()
{
    self endon( #"death_or_disconnect" );
    thread damagewatcher();
    wait 0.1;
    self.hasarenaspawned = 1;
    wait 0.15;
    
    if ( !flags::gameflag( "prematch_done" ) && game[ "roundsPlayed" ] == 0 )
    {
        if ( level.overtimeflag > 0 && isdefined( level.matchcountdowntime ) && level.matchcountdowntime > 5 )
        {
            if ( !self issplitscreenplayer() || self issplitscreenplayerprimary() )
            {
                dialog::leaderdialogonplayer( "obj_indepth", "introboost" );
            }
        }
        
        level utility::waittill_any( "prematch_done", "removeArenaOutlines" );
    }
    
    self setclientomnvar( "ui_player_notify_loadout", 1 );
}

// Namespace xfire
// Params 0
// Checksum 0x3dda3f4a, Offset: 0x1cfa
// Size: 0x3c
function damagewatcher()
{
    self notify( #"hash_dfd3548992b59d9e" );
    self endon( #"hash_dfd3548992b59d9e" );
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    self.totaldamagetaken = 0;
}

// Namespace xfire
// Params 1
// Checksum 0x543ea920, Offset: 0x1d3e
// Size: 0xc9
function function_2c1290dd9f35cbf( playerteam )
{
    if ( level.var_fcde802b49ec9e9b )
    {
        return;
    }
    
    level.var_fcde802b49ec9e9b = 1;
    
    foreach ( team in [ "allies", "axis", "team_three" ] )
    {
        count = 3;
        
        if ( team == playerteam )
        {
            count = 2;
        }
        
        level thread bots::spawn_bots( count, team );
    }
}

// Namespace xfire
// Params 0
// Checksum 0x9c820bb1, Offset: 0x1e0f
// Size: 0x1ad
function outlinemultiteam()
{
    while ( !isdefined( level.players ) )
    {
        waitframe();
    }
    
    while ( !flags::gameflag( "prematch_done" ) )
    {
        foreach ( player in level.players )
        {
            foreach ( other in level.players )
            {
                if ( player.pers[ "team" ] == other.pers[ "team" ] )
                {
                    continue;
                }
                
                player hudoutlineenableforclient( other, "outline_nodepth_orange" );
            }
        }
        
        wait 0.5;
    }
    
    foreach ( player in level.players )
    {
        player hudoutlinedisable();
    }
}

// Namespace xfire
// Params 6
// Checksum 0x393ade8b, Offset: 0x1fc4
// Size: 0x48
function onnormaldeath( victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon )
{
    common::oncommonnormaldeath( victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon );
}

// Namespace xfire
// Params 10
// Checksum 0x66b3e8fc, Offset: 0x2014
// Size: 0x1d1
function onplayerkilled( einflictor, attacker, idamage, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, deathanimduration, lifeid )
{
    attackerplayers = teams::getteamdata( attacker.pers[ "team" ], "players" );
    victimplayers = teams::getteamdata( self.pers[ "team" ], "players" );
    
    foreach ( player in victimplayers )
    {
        if ( self == player )
        {
            continue;
        }
        
        if ( player::isreallyalive( player ) && !player.inlaststand )
        {
            return;
        }
    }
    
    thread checkallowspectating( self.pers[ "team" ] );
    
    if ( level.var_d047d06c40c582a5 )
    {
        return;
    }
    
    level.var_d047d06c40c582a5 = 1;
    
    foreach ( player in attackerplayers )
    {
        player dialog::leaderdialogonplayer( "team_eliminated" );
    }
}

// Namespace xfire
// Params 1
// Checksum 0xe26139a1, Offset: 0x21ed
// Size: 0x2c
function checkallowspectating( eliminatedteam )
{
    level.spectateoverride[ eliminatedteam ].allowenemyspectate = 1;
    spectating::updatespectatesettings();
}

// Namespace xfire
// Params 2
// Checksum 0x5ad85ecf, Offset: 0x2221
// Size: 0x507
function xfire_checkforlaststandwipe( victim, islaststanddeath )
{
    if ( isdefined( level.incheckforlaststandwipe ) )
    {
        return 0;
    }
    
    level.incheckforlaststandwipe = 1;
    var_3e6fac9889bb0679 = [];
    killedvictim = 0;
    var_ce91be58a32283ac = [];
    var_8585a2af43d8149d = [];
    
    foreach ( entry in level.teamnamelist )
    {
        var_4de07b1b1d430047 = 1;
        var_3e6fac9889bb0679 = [];
        var_12e379a62ae10c55 = 0;
        
        foreach ( player in level.teamdata[ entry ][ "alivePlayers" ] )
        {
            if ( islaststanddeath && isdefined( victim ) && victim == player )
            {
                var_12e379a62ae10c55 = 1;
                continue;
            }
            
            isinlaststand = player.inlaststand || isdefined( victim ) && victim == player;
            
            if ( isinlaststand )
            {
                var_3e6fac9889bb0679[ var_3e6fac9889bb0679.size ] = player;
                continue;
            }
            
            var_4de07b1b1d430047 = 0;
            break;
        }
        
        if ( var_4de07b1b1d430047 && ( var_3e6fac9889bb0679.size > 0 || islaststanddeath && var_12e379a62ae10c55 ) )
        {
            attackers = [];
            
            foreach ( var_2f2e3e7373fe30f6 in var_3e6fac9889bb0679 )
            {
                if ( isdefined( var_2f2e3e7373fe30f6.laststandattacker ) && !arraycontains( attackers, var_2f2e3e7373fe30f6.laststandattacker ) )
                {
                    var_2f2e3e7373fe30f6.laststandattacker.wipeweapon = var_2f2e3e7373fe30f6.var_a54cf862f580156;
                    attackers[ attackers.size ] = var_2f2e3e7373fe30f6.laststandattacker;
                }
                
                if ( isdefined( victim ) && victim == var_2f2e3e7373fe30f6 )
                {
                    killedvictim = 1;
                }
                
                var_2f2e3e7373fe30f6 notify( #"squad_wipe_death" );
                var_2f2e3e7373fe30f6.squadwiped = 1;
                var_2f2e3e7373fe30f6 damage::_suicide( 0 );
            }
            
            if ( islaststanddeath && isdefined( victim ) && isdefined( victim.laststandattacker ) && !arraycontains( attackers, victim.laststandattacker ) )
            {
                attackers[ attackers.size ] = victim.laststandattacker;
            }
            
            foreach ( attacker in attackers )
            {
                if ( isdefined( attacker.team ) && !isdefined( var_8585a2af43d8149d[ attacker.team ] ) )
                {
                    var_8585a2af43d8149d[ attacker.team ] = 1;
                    attackerteammates = level.teamdata[ attacker.team ][ "alivePlayers" ];
                    
                    foreach ( attackerteammate in attackerteammates )
                    {
                        attackerteammate thread events::killeventtextpopup( #"team_wiped", 0 );
                        attackerteammate thread points::doscoreevent( #"team_wiped", attackerteammate.wipeweapon );
                    }
                    
                    wipeweapon = self.var_a54cf862f580156;
                    
                    if ( !isdefined( wipeweapon ) )
                    {
                        if ( isdefined( victim ) && isdefined( victim.laststandattacker ) )
                        {
                            wipeweapon = victim.laststandattacker.currentweapon;
                        }
                        else
                        {
                            wipeweapon = attacker.currentweapon;
                        }
                    }
                }
                
                attacker.wipeweapon = undefined;
                
                if ( !isdefined( var_ce91be58a32283ac[ attacker.team ] ) && !damage::function_193057578506a224() )
                {
                }
            }
            
            callback::callback( #"on_squad_wiped", { #attackers:attackers } );
        }
    }
    
    level.incheckforlaststandwipe = undefined;
    return killedvictim;
}

// Namespace xfire
// Params 0
// Checksum 0x5ec373a1, Offset: 0x2731
// Size: 0xda
function ontimelimit()
{
    if ( level.gameended )
    {
        return;
    }
    
    updatetournamentroundtime( gamelogic_mp::gettimeremaining(), 3 );
    
    if ( arena::function_46ca224400b02341() )
    {
        if ( level.var_58ca4c57804f591b != "neutral" )
        {
            level thread gamelogic_mp::endgame( level.var_58ca4c57804f591b, game[ "end_reason" ][ "ko_flag_win" ], game[ "end_reason" ][ "ko_flag_loss" ] );
        }
        else if ( level.wincondition == 1 )
        {
            arena::checkliveswinner();
        }
        else if ( level.wincondition == 2 )
        {
            checkhealthwinner();
        }
        else
        {
            checkhealthwinner();
        }
        
        return;
    }
    
    if ( level.wincondition == 1 )
    {
        arena::checkliveswinner();
        return;
    }
    
    if ( level.wincondition == 2 )
    {
        checkhealthwinner();
        return;
    }
    
    checkhealthwinner();
}

// Namespace xfire
// Params 0
// Checksum 0xc668774a, Offset: 0x2813
// Size: 0x1c0
function checkhealthwinner()
{
    winningteam = getwinningteam();
    
    if ( isdefined( winningteam ) )
    {
        game[ "dialog" ][ "round_success" ] = "gamestate_win_health";
        game[ "dialog" ][ "round_failure" ] = "gamestate_lost_health";
        thread arena_endgame( winningteam, game[ "end_reason" ][ "arena_time_health_win" ], game[ "end_reason" ][ "arena_time_health_loss" ] );
        return;
    }
    
    if ( game_utility_mp::matchmakinggame() )
    {
        if ( isintournament() )
        {
            game[ "canScoreOnTie" ] = 1;
            
            if ( game[ "finalRound" ] == 1 )
            {
                game[ "canScoreOnTie" ] = 0;
                
                if ( !isdefined( game[ "roundsTied" ] ) )
                {
                    game[ "roundsTied" ] = 1;
                }
                else
                {
                    game[ "roundsTied" ]++;
                }
                
                if ( game[ "roundsTied" ] >= 2 )
                {
                    betterteam = gamelogic_mp::getbetterteam();
                    thread gamelogic_mp::endgame( betterteam, game[ "end_reason" ][ "arena_tournament_tie_win" ], game[ "end_reason" ][ "arena_tournament_tie_loss" ] );
                }
                else
                {
                    thread arena_endgame( "tie", game[ "end_reason" ][ "time_limit_reached" ] );
                }
            }
            else
            {
                thread arena_endgame( "tie", game[ "end_reason" ][ "cyber_tie" ] );
            }
        }
        else
        {
            if ( !isdefined( game[ "roundsTied" ] ) )
            {
                game[ "roundsTied" ] = 1;
            }
            else
            {
                game[ "roundsTied" ]++;
            }
            
            game[ "canScoreOnTie" ] = game[ "roundsTied" ] >= 2;
            
            if ( game[ "canScoreOnTie" ] )
            {
                thread arena_endgame( "tie", game[ "end_reason" ][ "cyber_tie" ] );
            }
            else
            {
                thread arena_endgame( "tie", game[ "end_reason" ][ "time_limit_reached" ] );
            }
        }
        
        return;
    }
    
    thread arena_endgame( "tie", game[ "end_reason" ][ "time_limit_reached" ] );
}

// Namespace xfire
// Params 0
// Checksum 0x74cf778d, Offset: 0x29db
// Size: 0x48
function getwinningteam()
{
    teams = level.teamnamelist;
    teams = arraysort( teams, undefined, &compare_team_score );
    var_7572456b3d52cf9a = function_46b1987cf649fece();
    
    if ( var_7572456b3d52cf9a[ teams[ 0 ] ] == var_7572456b3d52cf9a[ teams[ 1 ] ] )
    {
        return;
    }
    
    return teams[ 0 ];
}

// Namespace xfire
// Params 2
// Checksum 0xee093168, Offset: 0x2a2c
// Size: 0x30, Type: bool
function compare_team_score( left, right )
{
    var_7572456b3d52cf9a = function_46b1987cf649fece();
    return var_7572456b3d52cf9a[ left ] >= var_7572456b3d52cf9a[ right ];
}

// Namespace xfire
// Params 0
// Checksum 0xc7bb4ac4, Offset: 0x2a65
// Size: 0x44
function function_46b1987cf649fece()
{
    var_7572456b3d52cf9a = [];
    var_7572456b3d52cf9a[ "axis" ] = level.axishealth;
    var_7572456b3d52cf9a[ "allies" ] = level.allieshealth;
    var_7572456b3d52cf9a[ "team_three" ] = level.var_153e3cbbcdc91e6f;
    return var_7572456b3d52cf9a;
}

// Namespace xfire
// Params 5
// Checksum 0xcdf0b7a0, Offset: 0x2ab2
// Size: 0x52
function arena_endgame( winningteam, endreasontext, endreasontextloss, nukedetonated, var_de9b655923cddf60 )
{
    if ( winningteam != "tie" )
    {
        game[ "roundsTied" ] = 0;
    }
    
    thread gamelogic_mp::endgame( winningteam, endreasontext, endreasontextloss, nukedetonated, var_de9b655923cddf60 );
}

// Namespace xfire
// Params 0
// Checksum 0xd682bfb9, Offset: 0x2b0c
// Size: 0xa
function ontimelimitot()
{
    level thread enableotflag();
}

/#

    // Namespace xfire
    // Params 0
    // Checksum 0xfdfa4081, Offset: 0x2b1e
    // Size: 0x282, Type: dev
    function function_3d2f6adc4704da26()
    {
        wait 5;
        ents = getentarray( "<dev string:x44>", #script_noteworthy );
        
        foreach ( ent in ents )
        {
            thread debug::drawsphere( ent.origin, 64, 1000, ( 0, 1, 0 ) );
        }
        
        ents = getentarray( "<dev string:x4f>", #script_noteworthy );
        
        foreach ( ent in ents )
        {
            thread debug::drawsphere( ent.origin, 64, 1000, ( 0, 1, 0 ) );
        }
        
        structs = utility::getstructarray( "<dev string:x44>", "<dev string:x62>" );
        
        foreach ( struct in structs )
        {
            thread debug::drawsphere( struct.origin, 64, 1000, ( 0, 1, 0 ) );
        }
        
        structs = utility::getstructarray( "<dev string:x4f>", "<dev string:x62>" );
        
        foreach ( struct in structs )
        {
            thread debug::drawsphere( struct.origin, 64, 1000, ( 0, 1, 0 ) );
        }
    }

#/

// Namespace xfire
// Params 0
// Checksum 0xf3664fca, Offset: 0x2da8
// Size: 0x4d, Type: bool
function shouldgamelobbyremainintact()
{
    axisscore = int( game[ "teamScores" ][ "axis" ] );
    alliesscore = int( game[ "teamScores" ][ "allies" ] );
    differential = axisscore - alliesscore;
    return differential < 10;
}

// Namespace xfire
// Params 0
// Checksum 0x7510f206, Offset: 0x2dfe
// Size: 0x11a
function seticonnames()
{
    level.iconcaptureendzone = "waypoint_capture_endzone";
    level.icondefendendzone = "waypoint_defend_endzone";
    level.iconcontestendzone = "waypoint_contesting_endzone";
    level.icontakingendzone = "waypoint_taking_endzone";
    level.iconlosingendzone = "waypoint_losing_endzone";
    level.iconneutral = "waypoint_captureneutral";
    level.iconcapture = "waypoint_capture";
    level.icondefend = "waypoint_defend";
    level.iconcontested = "waypoint_contested";
    level.icontaking = "waypoint_taking";
    level.iconlosing = "waypoint_losing";
    level.icondefending = "waypoint_defending";
    level.iconescort = "waypoint_escort_flag";
    level.iconkill = "waypoint_ctf_kill";
    level.iconcaptureflag = "waypoint_take_flag";
    level.icondefendflag = "waypoint_defend_flag";
    level.iconreturnflag = "waypoint_recover_flag";
    level.mlgiconemptyflag = "waypoint_mlg_empty_flag";
    level.mlgiconfullflag = "waypoint_mlg_full_flag";
    level.icontarget = "waypoint_target";
}

// Namespace xfire
// Params 0
// Checksum 0xb970889c, Offset: 0x2f20
// Size: 0x336
function setupwaypointicons()
{
    gamelogic_mp::setwaypointiconinfo( "waypoint_taking_endzone", 0, "friendly", "MP_INGAME_ONLY/OBJ_TAKING_CAPS", "icon_waypoint_flag", 0 );
    gamelogic_mp::setwaypointiconinfo( "waypoint_losing_endzone", 0, "enemy", "MP_INGAME_ONLY/OBJ_LOSING_CAPS", "icon_waypoint_flag", 0 );
    gamelogic_mp::setwaypointiconinfo( "waypoint_contesting_endzone", 0, "contest", "MP_INGAME_ONLY/OBJ_CONTESTED_CAPS", "icon_waypoint_flag", 0 );
    gamelogic_mp::setwaypointiconinfo( "waypoint_capture_endzone", 0, "enemy", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_flag", 0 );
    gamelogic_mp::setwaypointiconinfo( "waypoint_defend_endzone", 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_flag", 0 );
    gamelogic_mp::setwaypointiconinfo( "icon_waypoint_dom_a", 0, "friendly", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_overtime", 0 );
    gamelogic_mp::setwaypointiconinfo( "waypoint_taking_a", 0, "friendly", "MP_INGAME_ONLY/OBJ_TAKING_CAPS", "icon_waypoint_overtime", 1 );
    gamelogic_mp::setwaypointiconinfo( "waypoint_capture_a", 0, "enemy", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_overtime", 0 );
    gamelogic_mp::setwaypointiconinfo( "waypoint_defend_a", 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_overtime", 0 );
    gamelogic_mp::setwaypointiconinfo( "waypoint_defending_a", 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFENDING_CAPS", "icon_waypoint_overtime", 0 );
    gamelogic_mp::setwaypointiconinfo( "waypoint_blocking_a", 0, "friendly", "MP_INGAME_ONLY/OBJ_BLOCKING_CAPS", "icon_waypoint_overtime", 0 );
    gamelogic_mp::setwaypointiconinfo( "waypoint_blocked_a", 0, "friendly", "MP_INGAME_ONLY/OBJ_BLOCKED_CAPS", "icon_waypoint_overtime", 0 );
    gamelogic_mp::setwaypointiconinfo( "waypoint_losing_a", 0, "enemy", "MP_INGAME_ONLY/OBJ_LOSING_CAPS", "icon_waypoint_overtime", 1 );
    gamelogic_mp::setwaypointiconinfo( "waypoint_captureneutral_a", 0, "neutral", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_overtime", 0 );
    gamelogic_mp::setwaypointiconinfo( "waypoint_contested_a", 0, "contest", "MP_INGAME_ONLY/OBJ_CONTESTED_CAPS", "icon_waypoint_overtime", 1 );
    gamelogic_mp::setwaypointiconinfo( "waypoint_dom_target_a", 0, "neutral", "MP_INGAME_ONLY/OBJ_TARGET_CAPS", "icon_waypoint_overtime", 0 );
    gamelogic_mp::setwaypointiconinfo( "icon_waypoint_target_a", 0, "neutral", "MP_INGAME_ONLY/OBJ_TARGET_CAPS", "icon_waypoint_overtime", 0 );
    gamelogic_mp::setwaypointiconinfo( "icon_waypoint_ot_a", 1, "neutral", "MP_INGAME_ONLY/OBJ_OTFLAGLOC_CAPS", "icon_waypoint_overtime", 0 );
    gamelogic_mp::setwaypointiconinfo( "waypoint_dogtags", 1, "enemy", "", "ui_icon_minimap_tags", 0 );
    gamelogic_mp::setwaypointiconinfo( "waypoint_dogtags_friendly", 1, "friendly", "", "ui_icon_minimap_tags", 0 );
    gamelogic_mp::setwaypointiconinfo( "waypoint_ctf_kill", 2, "enemy", "MP_INGAME_ONLY/OBJ_KILL_CAPS", "icon_waypoint_kill", 0 );
    gamelogic_mp::setwaypointiconinfo( "waypoint_recover_flag", 0, "neutral", "MP_INGAME_ONLY/OBJ_RECOVER_CAPS", "icon_waypoint_flag", 0 );
    gamelogic_mp::setwaypointiconinfo( "waypoint_escort_flag", 2, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_flag", 0 );
    gamelogic_mp::setwaypointiconinfo( "waypoint_take_flag", 0, "neutral", "MP_INGAME_ONLY/OBJ_TAKE_CAPS", "icon_waypoint_flag", 0 );
    gamelogic_mp::setwaypointiconinfo( "waypoint_defend_flag", 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_flag", 0 );
    gamelogic_mp::setwaypointiconinfo( "waypoint_target", 0, "neutral", "MP_INGAME_ONLY/OBJ_TARGET_CAPS", "icon_waypoint_locked", 0 );
    gamelogic_mp::setwaypointiconinfo( "waypoint_mlg_empty_flag", 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "codcaster_icon_waypoint_ctf_empty", 0 );
    gamelogic_mp::setwaypointiconinfo( "waypoint_mlg_full_flag", 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "codcaster_icon_waypoint_ctf_full", 0 );
}

// Namespace xfire
// Params 1, eflags: 0x4
// Checksum 0x56093ca2, Offset: 0x325e
// Size: 0x2b
function private function_e0893a969443e61d( params )
{
    setcutthroatdownomnvar( self.team, 1 );
    self setclientomnvar( "ui_cutthroat_player_state", 1 );
}

// Namespace xfire
// Params 1, eflags: 0x4
// Checksum 0x4c05e320, Offset: 0x3291
// Size: 0x8a
function private function_a6c97d841e5c9801( params )
{
    if ( !isdefined( self ) )
    {
        return;
    }
    
    var_856110657494c104 = self getclientomnvar( "ui_cutthroat_player_state" );
    
    if ( var_856110657494c104 == 1 )
    {
        setcutthroatdownomnvar( self.team, -1 );
    }
    else if ( var_856110657494c104 == 2 )
    {
        setcutthroatrevivingomnvar( self.team, -1 );
    }
    
    if ( params.revived )
    {
        self setclientomnvar( "ui_cutthroat_player_state", 0 );
        return;
    }
    
    self setclientomnvar( "ui_cutthroat_player_state", 3 );
}

// Namespace xfire
// Params 1, eflags: 0x4
// Checksum 0xc6435f54, Offset: 0x3323
// Size: 0x5b
function private function_efd2167e7472f820( params )
{
    var_856110657494c104 = self getclientomnvar( "ui_cutthroat_player_state" );
    
    if ( var_856110657494c104 != 2 )
    {
        self setclientomnvar( "ui_cutthroat_player_state", 2 );
        setcutthroatrevivingomnvar( self.team, 1 );
        setcutthroatdownomnvar( self.team, -1 );
    }
}

// Namespace xfire
// Params 1, eflags: 0x4
// Checksum 0x1286c12f, Offset: 0x3386
// Size: 0x9c
function private function_4adc8ecb32cc78c1( params )
{
    var_856110657494c104 = self getclientomnvar( "ui_cutthroat_player_state" );
    
    if ( var_856110657494c104 == 2 )
    {
        setcutthroatrevivingomnvar( self.team, -1 );
        
        if ( params.result == "use_hold_think_fail" )
        {
            self setclientomnvar( "ui_cutthroat_player_state", 1 );
            setcutthroatdownomnvar( self.team, 1 );
            return;
        }
        
        if ( params.revived )
        {
            self setclientomnvar( "ui_cutthroat_player_state", 0 );
            return;
        }
        
        self setclientomnvar( "ui_cutthroat_player_state", 3 );
    }
}

// Namespace xfire
// Params 2, eflags: 0x4
// Checksum 0x6db243b3, Offset: 0x342a
// Size: 0xd3
function private setcutthroatdownomnvar( team, changeval )
{
    if ( team == "axis" )
    {
        level.var_4e8e29cfe8ef37d7 += changeval;
        setomnvar( "ui_cutthroat_num_downed_team_1", level.var_4e8e29cfe8ef37d7 );
        return;
    }
    
    if ( team == "allies" )
    {
        level.var_1d69db637f5dd116 += changeval;
        setomnvar( "ui_cutthroat_num_downed_team_2", level.var_1d69db637f5dd116 );
        return;
    }
    
    if ( team == "team_three" )
    {
        level.var_3b80f5dc06da38e5 += changeval;
        setomnvar( "ui_cutthroat_num_downed_team_3", level.var_3b80f5dc06da38e5 );
        return;
    }
    
    hud_message::showerrormessage( "setCutthroatDownOmnvar: invalid team" + self.team + " passed through" );
}

// Namespace xfire
// Params 2, eflags: 0x4
// Checksum 0xf7b15e21, Offset: 0x3505
// Size: 0xd3
function private setcutthroatrevivingomnvar( team, changeval )
{
    if ( team == "axis" )
    {
        level.var_6e5750bc280a95dc += changeval;
        setomnvar( "ui_cutthroat_num_reviving_team_1", level.var_6e5750bc280a95dc );
        return;
    }
    
    if ( team == "allies" )
    {
        level.var_d30790bd1daefad5 += changeval;
        setomnvar( "ui_cutthroat_num_reviving_team_2", level.var_d30790bd1daefad5 );
        return;
    }
    
    if ( team == "team_three" )
    {
        level.var_c9c131a041796786 += changeval;
        setomnvar( "ui_cutthroat_num_reviving_team_3", level.var_c9c131a041796786 );
        return;
    }
    
    hud_message::showerrormessage( "setCutthroatRevivingOmnvar : invalid team" + self.team + " passed through" );
}

