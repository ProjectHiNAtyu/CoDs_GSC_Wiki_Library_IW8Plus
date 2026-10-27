// scripts\mp\gametypes\control.gsc  (hash_108faf3dabbc3e99.gscc) (size: 54469 Bytes / 0xd4c5 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xd334fa63 (3543464547)
// size ...... 54469 (0xd4c5)
// includes .. 44  (offset: 0xc5a5)
// strings ... 160 (offset: 0xc705)
// dev strs .. 22  (offset: 0xd38d)
// exports ... 92  (offset: 0x89d1)
// cseg ...... 0xbf8 + 0x7dd9 (0x89d1)
// imports ... 349 (offset: 0x9831)
// animtree1 . 0   (offset: 0xd4c5)
// animtree2 . 0   (offset: 0xd4c5)
#using script_382bf8d77c4fd348;
#using scripts\common\callback_sequence;
#using scripts\common\callbacks;
#using scripts\common\gameplay_sound_fx;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\mp\battlechatter_mp;
#using scripts\mp\bots\bots;
#using scripts\mp\codcaster_utils;
#using scripts\mp\codcasterclientmatchdata;
#using scripts\mp\common\gameobjects\gameobjects_common;
#using scripts\mp\common\gameobjects\gameobjects_shared;
#using scripts\mp\common\utility\dialog;
#using scripts\mp\common\utility\dvars;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\stats;
#using scripts\mp\common\utility\team_utility;
#using scripts\mp\common\utility\teams;
#using scripts\mp\damage;
#using scripts\mp\events;
#using scripts\mp\flags;
#using scripts\mp\gameinstance;
#using scripts\mp\gamelogic;
#using scripts\mp\gameobjects;
#using scripts\mp\gamescore;
#using scripts\mp\gametypes\bradley_spawner;
#using scripts\mp\gametypes\common;
#using scripts\mp\gametypes\dom;
#using scripts\mp\gametypes\hq;
#using scripts\mp\gametypes\obj_dom;
#using scripts\mp\gestures;
#using scripts\mp\globallogic;
#using scripts\mp\hud_message;
#using scripts\mp\hud_util;
#using scripts\mp\matchdata;
#using scripts\mp\objectiveiconstates;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\persistence;
#using scripts\mp\playerlogic;
#using scripts\mp\rank;
#using scripts\mp\spawnlogic;

#namespace control;

// Namespace control
// Params 0
// Checksum 0x248eb902, Offset: 0xc16
// Size: 0x233
function main()
{
    if ( getdvar( @"g_mapname" ) == "mp_background" )
    {
        return;
    }
    
    globallogic::init();
    globallogic::setupcallbacks();
    allowed[ 0 ] = game_utility::getgametype();
    
    if ( game_utility::function_d3f8957534dc62af() )
    {
        allowed[ 0 ] = game_utility_mp::getbasegametype();
    }
    
    if ( game_utility::function_7cceeebf2891ed68() || level.leagueplaymatch )
    {
        allowed[ 0 ] = game_utility_mp::getbasegametype();
    }
    
    gameobjects::main( allowed );
    level.initializematchrules = &initializematchrules;
    [[ level.initializematchrules ]]();
    level thread game_utility_mp::reinitializematchrulesonmigration();
    update_gametype_dvars();
    callback::add( #"player_disconnect", &onplayerdisconnect );
    callback::add( #"player_spawned", &onspawnplayer );
    callback::add( #"hash_244314ef9125e636", &function_8314535b81f548e );
    level.updatealiveomnvars = &function_5aad2954b2488d1;
    level.onstartgametype = &control_onstartgametype;
    level.onplayerconnect = &control_onplayerconnect;
    level.getspawnpoint = &control_getspawnpoint;
    level.ononeleftevent = &control_ononeleftevent;
    level.disablespawningforplayerfunc = &function_2d689f01dd4d3abd;
    level.onobjectivecomplete = &function_90157b9728a6c497;
    level.ontimelimit = &control_ontimelimit;
    level.onmaprestart = &function_a09efcf05470a3a0;
    level.gamemodegesturecalloutassign = &function_9bd49188af67a5b4;
    level.gamemodegesturecalloutverify = &function_e5dc2d9d332f830;
    level.var_6acc53d8aaa7d1e3 = &function_e3581038ff640b3a;
    level.var_c18eb83275e643e7 = &function_c18eb83275e643e7;
    level.var_40cd999d911308e0 = &game_utility_mp::function_abefb3841cda328e;
    level.var_e16ef107a3dd572b = &game_utility_mp::function_90ed3e9fed444ef5;
    level.var_40ab710579539b1 = &game_utility_mp::function_daab43ec23b14d5c;
    level.playholdtwovo = 0;
    level.objectivebased = 1;
    level.teambased = 1;
    level.disablebuddyspawn = 1;
    level.lastcaptime = gettime();
    level.nosuspensemusic = 1;
    level.var_7b18d7f69313853a = 1;
    
    if ( level.numflagsscoreonkill > 0 )
    {
        level.teamscoresonkill = [];
        level.onnormaldeath = &onnormaldeath;
    }
}

// Namespace control
// Params 0
// Checksum 0x69322ee3, Offset: 0xe51
// Size: 0x23c
function initializematchrules()
{
    game_utility_mp::setcommonrulesfrommatchrulesdata();
    level.blockcapdisabled = getmatchrulesdata( "domData", "flagblockcapdisabled" );
    setdynamicdvar( dvars::function_1165fde71640a2d1( "flagCaptureTime" ), getmatchrulesdata( "domData", "flagCaptureTime" ) );
    setdynamicdvar( dvars::function_1165fde71640a2d1( "flagsRequiredToScore" ), getmatchrulesdata( "domData", "flagsRequiredToScore" ) );
    setdynamicdvar( dvars::function_1165fde71640a2d1( "pointsPerFlag" ), getmatchrulesdata( "domData", "pointsPerFlag" ) );
    setdynamicdvar( dvars::function_1165fde71640a2d1( "flagNeutralization" ), getmatchrulesdata( "domData", "flagNeutralization" ) );
    setdynamicdvar( dvars::function_1165fde71640a2d1( "numFlagsScoreOnKill" ), getmatchrulesdata( "domData", "numFlagsScoreOnKill" ) );
    setdynamicdvar( dvars::function_1165fde71640a2d1( "objScalar" ), getmatchrulesdata( "domData", "objScalar" ) );
    setdynamicdvar( dvars::function_1165fde71640a2d1( "preCapPoints" ), getmatchrulesdata( "siegeData", "preCapPoints" ) );
    setdynamicdvar( dvars::function_1165fde71640a2d1( "captureType" ), getmatchrulesdata( "captureData", "captureType" ) );
    setdynamicdvar( dvars::function_1165fde71640a2d1( "captureDecay" ), getmatchrulesdata( "captureData", "captureDecay" ) );
    setdynamicdvar( dvars::function_1165fde71640a2d1( "disableMajorityCapProgress" ), getmatchrulesdata( "controlData", "disableMajorityCapProgress" ) );
    setdynamicdvar( dvars::function_1165fde71640a2d1( "useSegments" ), getmatchrulesdata( "controlData", "useSegments" ) );
    setdynamicdvar( dvars::function_1165fde71640a2d1( "suicideTeamKillLowersLives" ), getmatchrulesdata( "controlData", "suicideTeamKillLowersLives" ) );
    setdynamicdvar( dvars::function_1165fde71640a2d1( "captureExtraTime" ), getmatchrulesdata( "controlData", "captureExtraTime" ) );
    setdynamicdvar( dvars::function_1165fde71640a2d1( "pauseTime" ), getmatchrulesdata( "kothData", "pauseTime" ) );
    setdynamicdvar( dvars::function_1165fde71640a2d1( "numTeamLives" ), getmatchrulesdata( "controlData", "numTeamLives" ) );
    setdynamicdvar( dvars::function_1165fde71640a2d1( "overtimeDefenders" ), getmatchrulesdata( "controlData", "overtimeDefenders" ) );
    setdynamicdvar( dvars::function_1165fde71640a2d1( "segmentCaptureExtraTime" ), getmatchrulesdata( "controlData", "segmentCaptureExtraTime" ) );
    setdynamicdvar( dvars::function_1165fde71640a2d1( "numCaptureSegments" ), getmatchrulesdata( "controlData", "numCaptureSegments" ) );
}

// Namespace control
// Params 0
// Checksum 0x49f5401d, Offset: 0x1095
// Size: 0x72
function set_icon_names()
{
    level.iconneutral = "waypoint_captureneutral";
    level.iconcapture = "waypoint_capture";
    level.icondefend = "waypoint_defend";
    level.icondefending = "waypoint_defending";
    level.iconcontested = "waypoint_contested";
    level.icontaking = "waypoint_taking";
    level.iconlosing = "waypoint_losing";
    level.iconclearing = "waypoint_clearing";
}

// Namespace control
// Params 0
// Checksum 0xe243c519, Offset: 0x110f
// Size: 0x3b7
function control_onstartgametype()
{
    attacking_team = game[ "attackers" ];
    defending_team = game[ "defenders" ];
    level.teamdata[ attacking_team ][ "livesCount" ] = level.numteamlives;
    level.teamdata[ defending_team ][ "livesCount" ] = level.numteamlives;
    level.teamdata[ attacking_team ][ "controlUILivesCount" ] = level.teamdata[ attacking_team ][ "livesCount" ];
    level.teamdata[ defending_team ][ "controlUILivesCount" ] = level.teamdata[ defending_team ][ "livesCount" ];
    set_icon_names();
    
    foreach ( entry in level.teamnamelist )
    {
        if ( isdefined( level.teamscoresonkill ) )
        {
            level.teamscoresonkill[ entry ] = level.precappoints >= level.numflagsscoreonkill && level.precappoints >= level.flagsrequiredtoscore;
        }
        
        if ( entry == attacking_team )
        {
            game_utility_mp::setobjectivetext( entry, &"objectives/control_attacker" );
        }
        else
        {
            game_utility_mp::setobjectivetext( entry, &"objectives/control_defender" );
        }
        
        if ( level.splitscreen )
        {
            game_utility_mp::setobjectivescoretext( entry, &"objectives/control" );
        }
        else
        {
            game_utility_mp::setobjectivescoretext( entry, &"objectives/control_score" );
        }
        
        if ( entry == attacking_team )
        {
            game_utility_mp::setobjectivehinttext( entry, &"objectives/control_attacker_hint" );
            continue;
        }
        
        game_utility_mp::setobjectivehinttext( entry, &"objectives/control_defender_hint" );
    }
    
    setclientnamemode( "auto_change" );
    
    if ( !isdefined( game[ "match_kills" ] ) )
    {
        game[ "match_kills" ][ defending_team ] = 0;
        game[ "match_kills" ][ attacking_team ] = 0;
    }
    
    if ( !isdefined( game[ "segment_captures" ] ) )
    {
        game[ "segment_captures" ][ defending_team ] = 0;
        game[ "segment_captures" ][ attacking_team ] = 0;
        codcaster_utils::function_eddb7bc4ce563395( 0, defending_team );
        codcaster_utils::function_eddb7bc4ce563395( 0, attacking_team );
    }
    
    if ( !isdefined( game[ "switchedsides" ] ) )
    {
        game[ "switchedsides" ] = 0;
    }
    
    if ( level.overtimedefenders != 0 && game[ "roundsWon" ][ defending_team ] == level.winlimit - 1 && game[ "roundsWon" ][ attacking_team ] == level.winlimit - 1 )
    {
        [ bestteam, reason ] = function_71395ff3b4abe35d();
        
        if ( bestteam == game[ "attackers" ] )
        {
            game[ "attackers" ] = defending_team;
            game[ "defenders" ] = attacking_team;
        }
    }
    else if ( game[ "switchedsides" ] )
    {
        game[ "attackers" ] = defending_team;
        game[ "defenders" ] = attacking_team;
    }
    
    level init_spawns();
    
    /#
        thread function_7f317007253a6058();
        thread removedompoint();
        thread placedompoint();
    #/
    
    bradley_spawner::inittankspawns();
    level.var_764eb1e7a422f321 = 0;
    level.var_764eb4e7a422f9ba = 0;
    level.teamdata[ attacking_team ][ "uncountedDeaths" ] = 0;
    level.teamdata[ defending_team ][ "uncountedDeaths" ] = 0;
    thread function_5ced1b53990218d1();
    
    if ( isdefined( level.gametypebundle.var_ae100eea97c7fcc7[ #"hash_14bb716c4b77c45a" ] ) )
    {
        thread function_950268979eebe9ef();
        return;
    }
    
    thread setup_control_zones();
}

// Namespace control
// Params 0
// Checksum 0x3445eb32, Offset: 0x14ce
// Size: 0x26
function function_5ced1b53990218d1()
{
    if ( !flags::gameflag( "prematch_done" ) )
    {
        level waittill( #"prematch_done" );
    }
    
    level function_18b90a2be8797f0d();
}

// Namespace control
// Params 0
// Checksum 0xbe19e39, Offset: 0x14fc
// Size: 0x1cf
function update_gametype_dvars()
{
    common::updatecommongametypedvars();
    level.flagcapturetime = dvars::dvarfloatvalue( "flagCaptureTime", 60, 0, 120 );
    level.captureextratime = dvars::dvarfloatvalue( "captureExtraTime", 60, 30, 300 );
    level.disablemajoritycapprogress = dvars::dvarintvalue( "disableMajorityCapProgress", 1, 0, 1 );
    level.objectivescaler = dvars::dvarfloatvalue( "objScalar", 4, 1, 10 );
    level.suicideteamkilllowerslives = dvars::dvarintvalue( "suicideTeamKillLowersLives", 0, 0, 1 );
    level.numteamlives = dvars::dvarintvalue( "numTeamLives", 30, 0, 100 );
    level.overtimedefenders = dvars::dvarintvalue( "overtimeDefenders", 2, 0, 2 );
    level.pausetimer = dvars::dvarintvalue( "pauseTime", 1, 0, 1 );
    level.usesegments = dvars::dvarintvalue( "useSegments", 1, 0, 1 );
    level.flagsrequiredtoscore = dvars::dvarintvalue( "flagsRequiredToScore", 2, 1, 3 );
    level.pointsperflag = dvars::dvarintvalue( "pointsPerFlag", 1, 1, 300 );
    level.flagneutralization = dvars::dvarintvalue( "flagNeutralization", 0, 0, 1 );
    level.precappoints = dvars::dvarintvalue( "preCapPoints", 1, 0, 1 );
    level.capturedecay = dvars::dvarintvalue( "captureDecay", 1, 0, 1 );
    level.capturetype = dvars::dvarintvalue( "captureType", 1, 0, 3 );
    level.numflagsscoreonkill = dvars::dvarintvalue( "numFlagsScoreOnKill", 2, 0, 3 );
    level.capturesegments = dvars::dvarintvalue( "numCaptureSegments", 3, 0, 5 );
    level.segmentcaptureextratime = dvars::dvarfloatvalue( "segmentCaptureExtraTime", 10, 0, 60 );
}

// Namespace control
// Params 0
// Checksum 0x4dcc6f9c, Offset: 0x16d3
// Size: 0x34f
function init_spawns()
{
    spawnlogic::setactivespawnlogic( #"default" );
    spawnlogic::function_6dbabb72223a4bca();
    spawnkey = spawnlogic::function_d5c160a4110b573e();
    
    if ( spawnlogic::function_5cf82e30c52a895d( spawnkey ) )
    {
        spawnlogic::function_3a25709674572ad6( #"start", #"start_attackers", spawnkey, spawnlogic::function_61ba521db28762a7(), game[ "attackers" ], 1 );
        spawnlogic::function_3a25709674572ad6( #"start", #"start_defenders", spawnkey, spawnlogic::function_3a5e3efa19e5df47(), game[ "defenders" ], 1 );
        spawnlogic::function_3a25709674572ad6( #"fallback", #"fallback_attackers", spawnkey, "fallback_attacker", game[ "attackers" ], 1 );
        spawnlogic::function_3a25709674572ad6( #"fallback", #"fallback_defenders", spawnkey, "fallback_defender", game[ "defenders" ], 1 );
        valuekeys = [ "zoneA_uncaptured", "zoneA_captured", "zoneB_uncaptured", "zoneB_captured" ];
        var_540375a0f1234755 = [ #"zonea_uncaptured_attackers", #"zonea_captured_attackers", #"zoneb_uncaptured_attackers", #"zoneb_captured_attackers" ];
        var_72ec1c4fb7641fd9 = [ #"zonea_uncaptured_defenders", #"zonea_captured_defenders", #"zoneb_uncaptured_defenders", #"zoneb_captured_defenders" ];
        spawnlogic::function_1a2e309f5ceed01c( "holding", #"primary_attackers", var_540375a0f1234755, spawnkey, "attacker", valuekeys, game[ "attackers" ] );
        spawnlogic::function_1a2e309f5ceed01c( "holding", #"primary_defenders", var_72ec1c4fb7641fd9, spawnkey, "defender", valuekeys, game[ "defenders" ] );
        spawnlogic::function_2e4fbfaa2e5bf603( #"primary", #"primary_attackers" );
        spawnlogic::function_2e4fbfaa2e5bf603( #"primary", #"primary_defenders" );
        spawnlogic::function_2e4fbfaa2e5bf603( #"primary", #"zonea_uncaptured_attackers" );
        spawnlogic::function_2e4fbfaa2e5bf603( #"primary", #"zoneb_uncaptured_attackers" );
        spawnlogic::function_2e4fbfaa2e5bf603( #"primary", #"zonea_uncaptured_defenders" );
        spawnlogic::function_2e4fbfaa2e5bf603( #"primary", #"zoneb_uncaptured_defenders" );
    }
    else
    {
        spawnlogic::function_9bd2654564d3372d( #"start", #"start_attackers", "mp_control_spawn_attacker_start", "allies", 1 );
        spawnlogic::function_9bd2654564d3372d( #"start", #"start_defenders", "mp_control_spawn_defender_start", "axis", 1 );
        spawnlogic::function_9bd2654564d3372d( #"primary", #"primary_attackers", "mp_control_spawn_attacker", "allies" );
        spawnlogic::function_9bd2654564d3372d( #"primary", #"primary_defenders", "mp_control_spawn_defender", "axis" );
        spawnlogic::function_9bd2654564d3372d( #"fallback", #"fallback_attackers", "mp_control_spawn_attacker_secondary", "allies", 1 );
        spawnlogic::function_9bd2654564d3372d( #"fallback", #"fallback_defenders", "mp_control_spawn_defender_secondary", "axis", 1 );
    }
    
    spawnlogic::finalizemap();
}

// Namespace control
// Params 0
// Checksum 0x13e4efea, Offset: 0x1a2a
// Size: 0x9
function control_getspawnpoint()
{
    return spawnlogic::function_3f9d5fcfb93d4190( self );
}

// Namespace control
// Params 0
// Checksum 0x733e6d51, Offset: 0x1a3c
// Size: 0x51a
function setup_control_zones()
{
    primaryzones = [];
    
    if ( isdefined( game_utility::getlocaleid() ) )
    {
        var_ede98a848e4e46f0 = getentarray( "control_zone", #targetname );
        
        foreach ( zone in var_ede98a848e4e46f0 )
        {
            if ( zone.script_noteworthy == level.localeid )
            {
                primaryzones[ primaryzones.size ] = zone;
                continue;
            }
            
            if ( isdefined( zone.target ) )
            {
                primaryzones[ primaryzones.size ] = zone;
                continue;
            }
            
            assertmsg( "<dev string:x24>" );
            zone delete();
        }
    }
    else
    {
        var_ede98a848e4e46f0 = getentarray( "control_zone", #targetname );
        
        foreach ( zone in var_ede98a848e4e46f0 )
        {
            primaryzones[ primaryzones.size ] = zone;
        }
    }
    
    if ( primaryzones.size != 2 )
    {
        assertmsg( "<dev string:x63>" );
        return;
    }
    
    setomnvar( "ui_num_dom_flags", primaryzones.size );
    triggers = [];
    
    for ( index = 0; index < primaryzones.size ; index++ )
    {
        triggers[ triggers.size ] = primaryzones[ index ];
    }
    
    foreach ( trigger in triggers )
    {
        control_zone = function_efe6f881a4488dcb( trigger, game[ "defenders" ], 1, 0 );
        control_zone thread setup_control_chevrons( trigger.target, trigger.script_label );
        level.objectives[ control_zone.objectivekey ] = control_zone;
    }
    
    /#
        function_24d85ab346bf7ad9();
    #/
    
    spawn_attackers_start = spawnlogic::getspawnpointarray( "mp_control_spawn_attacker_start" );
    spawn_defenders_start = spawnlogic::getspawnpointarray( "mp_control_spawn_defender_start" );
    
    if ( isdefined( spawn_attackers_start[ 0 ] ) )
    {
        level.startpos[ "allies" ] = spawn_attackers_start[ 0 ].origin;
    }
    else
    {
        level.startpos[ "allies" ] = level.startspawnavg[ "allies" ];
    }
    
    if ( isdefined( spawn_defenders_start[ 0 ] ) )
    {
        level.startpos[ "axis" ] = spawn_defenders_start[ 0 ].origin;
    }
    else
    {
        level.startpos[ "axis" ] = level.startspawnavg[ "axis" ];
    }
    
    level.bestspawnflag = [];
    level.bestspawnflag[ "allies" ] = obj_dom::getunownedflagneareststart( "allies", undefined );
    level.bestspawnflag[ "axis" ] = obj_dom::getunownedflagneareststart( "axis", level.bestspawnflag[ "allies" ] );
    
    if ( level.codcasterenabled )
    {
        thread updatetriggerforcodcaster();
    }
    
    foreach ( control_zone in level.objectives )
    {
        matchtimems = matchdata::function_47550968a937b67e( gettime() );
        dlog_recordevent( "dlog_event_mp_objective_status", [ "key", control_zone.objectivekey, "match_time_ms", matchtimems, "is_active", 1 ] );
        dlog_recordevent( "dlog_event_mp_objective_move", [ "pos_x", control_zone.curorigin[ 0 ], "pos_y", control_zone.curorigin[ 1 ], "key", control_zone.objectivekey, "match_time_ms", matchtimems ] );
        control_zone obj_dom::setflagcaptured( game[ "defenders" ], "neutral", undefined, 1 );
        dlog_recordevent( "dlog_event_mp_objective_ownership_changed", [ "key", control_zone.objectivekey, "team", game[ "defenders" ], "match_time_ms", matchtimems ] );
    }
}

// Namespace control
// Params 5
// Checksum 0x58262d18, Offset: 0x1f5e
// Size: 0x734
function function_efe6f881a4488dcb( trigger, team, var_ee9ac91f30ff8e1, skipobjid, showoncompass )
{
    flagui_pos = trigger.origin;
    use_ground_trace = 1;
    var_12890dd289175b09 = getentarray( "control_flagui", #script_noteworthy );
    
    foreach ( point in var_12890dd289175b09 )
    {
        if ( point.script_linkname == trigger.script_linkname )
        {
            flagui_pos = point.origin;
            use_ground_trace = 0;
            point delete();
        }
    }
    
    tracestart = flagui_pos + ( 0, 0, 64 );
    traceend = flagui_pos + ( 0, 0, -64 );
    contentoverride = trace::create_contents( 1, 1, 1, 1, 0, 1, 1 );
    ignoreents = [];
    trace = trace::ray_trace( tracestart, traceend, ignoreents, contentoverride );
    
    if ( use_ground_trace )
    {
        flagui_pos = trace[ "position" ] + ( 0, 0, 72 );
    }
    
    visuals = [];
    visuals[ 0 ] = spawn( "script_model", flagui_pos );
    visuals[ 0 ].angles = ( 0, 0, 0 );
    
    if ( !isdefined( level.flagcapturetime ) )
    {
        level.flagcapturetime = dvars::dvarfloatvalue( @"flagcapturetime", 60, 0, 60 );
    }
    
    if ( !isdefined( level.flagcapturemintime ) )
    {
        level.flagcapturetimemin = dvars::dvarfloatvalue( "flagCaptureTimeMin", 0, 0, 30 );
    }
    
    if ( !isdefined( level.var_e56cac0580f1c92c ) )
    {
        level.var_e56cac0580f1c92c = level.flagcapturetime * 0.5;
    }
    
    if ( isdefined( trigger.objectivekey ) )
    {
        objectivekey = trigger.objectivekey;
    }
    else
    {
        objectivekey = trigger.script_label;
    }
    
    if ( isdefined( trigger.iconname ) )
    {
        iconname = trigger.iconname;
    }
    else
    {
        iconname = trigger.script_label;
    }
    
    if ( var_ee9ac91f30ff8e1 )
    {
        reservedobjid = obj_dom::getreservedobjid( objectivekey );
    }
    else
    {
        reservedobjid = undefined;
    }
    
    if ( !isdefined( team ) )
    {
        team = "neutral";
    }
    
    var_441b8d5f798c04a7 = flagui_pos - trigger.origin;
    
    if ( isdefined( trigger.target ) )
    {
        var_b6a962ec973ce64d = utility::getstruct( trigger.target, "targetname" );
        
        if ( isdefined( var_b6a962ec973ce64d ) )
        {
            var_441b8d5f798c04a7 = var_b6a962ec973ce64d.origin - trigger.origin;
        }
    }
    
    control_zone = gameobjects::createuseobject( team, trigger, visuals, var_441b8d5f798c04a7, reservedobjid, skipobjid, showoncompass );
    control_zone gameobjects::cancontestclaim( 1 );
    control_zone gameobjects::setusetime( level.flagcapturetime );
    function_ca1cc2938b2b4271( reservedobjid, trigger );
    control_zone gameobjects::allowuse( "any" );
    
    if ( isdefined( level.capturetype ) )
    {
        control_zone gameobjects::setcapturebehavior( obj_dom::getcapturetype() );
    }
    
    control_zone.objectivekey = objectivekey;
    control_zone.iconname = iconname;
    control_zone.var_c95f5d841e441c5b = 1;
    
    if ( !skipobjid )
    {
        control_zone gameobjects::setvisibleteam( "any" );
        control_zone.onplayerenter = &onplayerenter;
        control_zone.onplayerexit = &onplayerexit;
        control_zone.onuse = &control_onuse;
        control_zone.onbeginuse = &control_onbeginuse;
        control_zone.onuseupdate = &obj_dom::dompoint_onuseupdate;
        control_zone.onenduse = &control_onenduse;
        control_zone.oncontested = &control_oncontested;
        control_zone.onuncontested = &control_onuncontested;
        control_zone.onunoccupied = &control_onunoccupied;
        control_zone.onpinnedstate = &control_onpinnedstate;
        control_zone.onunpinnedstate = &control_onunpinnedstate;
        control_zone.stompprogressreward = &onstompprogressreward;
        control_zone.var_c054f1da22a3a72a = &function_a2eed2aa2ff4c34c;
        objective_setminimapiconsize( control_zone.objidnum, "icon_regular" );
    }
    
    control_zone.nousebar = 1;
    control_zone.id = "domFlag";
    control_zone.claimgracetime = level.flagcapturetime * 1000;
    control_zone.firstcapture = 0;
    control_zone gameobjects::pinobjiconontriggertouch();
    offset = obj_dom::checkmapoffsets( control_zone );
    control_zone.baseeffectpos = trace[ "position" ] + offset;
    upangles = vectortoangles( trace[ "normal" ] );
    modifiedupangles = obj_dom::checkmapfxangles( control_zone, upangles );
    control_zone.baseeffectforward = anglestoforward( modifiedupangles );
    control_zone.vfxnamemod = "";
    control_zone.noscriptable = 1;
    control_zone obj_dom::initializematchrecording();
    control_zone.spawnset = [];
    control_zone.spawnset[ #"uncaptured_defenders" ] = control_zone function_f6cf25f9c109edf5( [ #"zonea_uncaptured_defenders", #"zoneb_uncaptured_defenders", #"zoneb_uncaptured_defenders", #"zoneb_uncaptured_defenders", #"zoneb_uncaptured_defenders" ] );
    control_zone.spawnset[ #"uncaptured_attackers" ] = control_zone function_f6cf25f9c109edf5( [ #"zonea_uncaptured_attackers", #"zoneb_uncaptured_attackers", #"zoneb_uncaptured_attackers", #"zoneb_uncaptured_attackers", #"zoneb_uncaptured_attackers" ] );
    control_zone.spawnset[ #"captured_defenders" ] = control_zone function_f6cf25f9c109edf5( [ #"zonea_captured_defenders", #"zoneb_captured_defenders", #"zoneb_captured_defenders", #"zoneb_captured_defenders", #"zoneb_captured_defenders" ] );
    control_zone.spawnset[ #"captured_attackers" ] = control_zone function_f6cf25f9c109edf5( [ #"zonea_captured_attackers", #"zoneb_captured_attackers", #"zoneb_captured_attackers", #"zoneb_captured_attackers", #"zoneb_captured_attackers" ] );
    return control_zone;
}

// Namespace control
// Params 0
// Checksum 0x8fd19a50, Offset: 0x269b
// Size: 0x63
function function_c18eb83275e643e7()
{
    zone = self;
    luaindex = zone.objidnum + 1;
    setomnvar( "ui_axis_player_count_zone_" + luaindex, zone.numtouching[ "axis" ] );
    setomnvar( "ui_allies_player_count_zone_" + luaindex, zone.numtouching[ "allies" ] );
}

// Namespace control
// Params 1
// Checksum 0x2f25f43a, Offset: 0x2706
// Size: 0x27
function onplayerenter( player )
{
    player.var_c36e159445e2a48b = 0;
    player.var_b87cafbca06df20f = 1;
}

// Namespace control
// Params 1
// Checksum 0x59778665, Offset: 0x2735
// Size: 0x2b
function onplayerexit( player )
{
    player.var_c36e159445e2a48b = undefined;
    player.var_b87cafbca06df20f = undefined;
    player events::function_b49819835545fb9();
}

// Namespace control
// Params 2
// Checksum 0x3139bcd2, Offset: 0x2768
// Size: 0xcf
function control_onuse( credit_player, team )
{
    obj_dom::dompoint_onuse( credit_player, team );
    
    if ( isdefined( level.teamscoresonkill ) )
    {
        foreach ( team in level.teamnamelist )
        {
            var_d9425977785add8f = obj_dom::getteamflagcount( team );
            level.teamscoresonkill[ team ] = var_d9425977785add8f >= level.numflagsscoreonkill && var_d9425977785add8f >= level.flagsrequiredtoscore;
        }
    }
}

// Namespace control
// Params 1
// Checksum 0x91e14a5e, Offset: 0x283f
// Size: 0xde
function control_onbeginuse( player )
{
    if ( level.pausetimer && self.ownerteam != player.team && !self.var_dfc20331de7b5040 )
    {
        self.var_dfc20331de7b5040 = 1;
        gamelogic_mp::pausetimer();
    }
    
    obj_dom::dompoint_onusebegin( player );
    update_chevrons();
    
    if ( self.numtouching[ player.team ] < 2 && self.mostnumtouchingteam == player.team )
    {
        if ( self.allowcapture == 1 )
        {
            self.trigger playsoundtoteam( "mp_cer_control_capturing_positive", player.team );
            self.trigger playsoundtoteam( "mp_cer_control_capturing_negative", self.prevownerteam );
        }
    }
}

// Namespace control
// Params 3
// Checksum 0xd2c0aa6f, Offset: 0x2925
// Size: 0x19a
function control_onenduse( team, player, success )
{
    obj_dom::dompoint_onuseend( team, player, success );
    
    if ( success )
    {
        thread set_chevron_state( "off" );
        spawnlogic::function_2e4fbfaa2e5bf603( #"primary", self.spawnset[ #"captured_defenders" ] );
        spawnlogic::function_2e4fbfaa2e5bf603( #"primary", self.spawnset[ #"captured_attackers" ] );
        
        if ( !isdefined( self.spawninfluencers ) )
        {
            self.spawninfluencers = [];
        }
        
        if ( spawnlogic::useablespawnset( self.spawnset[ #"uncaptured_defenders" ] ) )
        {
            influencer = spawnlogic::addspawninfluencer( #"hash_d841f6b057ed9349", self.trigger.origin );
            spawnlogic::influencersetspawnpointlist( influencer, self.spawnset[ #"uncaptured_defenders" ] );
            self.spawninfluencers[ self.spawninfluencers.size ] = influencer;
        }
        
        if ( spawnlogic::useablespawnset( self.spawnset[ #"uncaptured_attackers" ] ) )
        {
            influencer = spawnlogic::addspawninfluencer( #"hash_6f9203c430f48d09", self.trigger.origin );
            spawnlogic::influencersetspawnpointlist( influencer, self.spawnset[ #"uncaptured_attackers" ] );
            self.spawninfluencers[ self.spawninfluencers.size ] = influencer;
        }
        
        /#
            function_24d85ab346bf7ad9();
        #/
        
        return;
    }
    
    update_chevrons();
}

// Namespace control
// Params 0
// Checksum 0xd72214fd, Offset: 0x2ac7
// Size: 0x260
function control_oncontested()
{
    if ( level.pausetimer )
    {
        self.var_dfc20331de7b5040 = 1;
        gamelogic_mp::pausetimer();
    }
    
    obj_dom::dompoint_oncontested();
    update_chevrons();
    defender = gameobjects::getownerteam();
    attackers = team_utility::getenemyteams( defender );
    
    if ( isdefined( self.objectivekey ) )
    {
        level.objectives[ self.objectivekey ].contested = 1;
    }
    
    numcontested = 0;
    
    foreach ( zone in level.objectives )
    {
        if ( zone.contested )
        {
            numcontested++;
        }
    }
    
    if ( numcontested == 0 )
    {
        return;
    }
    
    if ( level.objectives.size > 1 && numcontested == level.objectives.size )
    {
        dialog::statusdialog( #"contest_defender_all", defender );
        
        foreach ( enemyteam in attackers )
        {
            dialog::statusdialog( #"contest_attacker_all", enemyteam );
        }
        
        return;
    }
    
    dialog::statusdialog( hashcat( #"contest_defender", self.objectivekey ), defender );
    
    foreach ( enemyteam in attackers )
    {
        dialog::statusdialog( hashcat( #"contest_attacker", self.objectivekey ), enemyteam );
    }
}

// Namespace control
// Params 1
// Checksum 0x6d5b485f, Offset: 0x2d2f
// Size: 0x8e
function control_onuncontested( lastclaimteam )
{
    if ( self.ownerteam == lastclaimteam )
    {
        self.var_dfc20331de7b5040 = 0;
        
        if ( !function_d54721b242020b13( self ) )
        {
            gamelogic_mp::resumetimer();
        }
    }
    
    obj_dom::dompoint_onuncontested( lastclaimteam );
    utility::delaythread( 0.05, &update_chevrons );
    
    if ( isdefined( self.objectivekey ) )
    {
        level.objectives[ self.objectivekey ].contested = 0;
    }
    
    objidpoolmanager::update_objective_sethot( self.objidnum, 0 );
}

// Namespace control
// Params 0
// Checksum 0x3ce31c9c, Offset: 0x2dc5
// Size: 0x65
function control_onunoccupied()
{
    self.var_dfc20331de7b5040 = 0;
    
    if ( !function_d54721b242020b13( self ) && !level.var_17ebe57584c369c9 )
    {
        gamelogic_mp::resumetimer();
    }
    
    obj_dom::dompoint_onunoccupied();
    update_chevrons();
    
    if ( flags::gameflag( "prematch_done" ) )
    {
        playsoundatpos( self.trigger.origin, "uin_cer_common_ingame_zone_neutral_ping_3d" );
    }
}

// Namespace control
// Params 1
// Checksum 0x2f861041, Offset: 0x2e32
// Size: 0xd9
function control_onpinnedstate( player )
{
    obj_dom::dompoint_onpinnedstate( player );
    
    if ( self.numtouching[ self.ownerteam ] && !self.stalemate )
    {
        if ( self.ownerteam == player.team )
        {
            if ( self.numtouching[ player.team ] < 2 && self.mostnumtouchingteam == player.team )
            {
                if ( self.allowcapture == 1 )
                {
                    self.trigger playsoundtoteam( "mp_cer_control_defending_positive", self.ownerteam );
                    self.trigger playsoundtoteam( "mp_cer_control_defending_negative", team_utility::getotherteam( self.ownerteam ) );
                }
            }
        }
    }
    
    update_chevrons();
}

// Namespace control
// Params 1
// Checksum 0x1f30096, Offset: 0x2f13
// Size: 0x13
function control_onunpinnedstate( player )
{
    update_chevrons();
}

// Namespace control
// Params 1
// Checksum 0xea816e81, Offset: 0x2f2e
// Size: 0x32
function onstompprogressreward( player )
{
    obj_dom::dompoint_stompprogressreward( player );
    player stats::setextrascore2( player.pers[ "extrascore2" ] + 1 );
}

// Namespace control
// Params 2
// Checksum 0x79854c9a, Offset: 0x2f68
// Size: 0x1a6
function setup_control_chevrons( target, label )
{
    wait 1;
    othervisuals = getentitylessscriptablearray( target, #targetname );
    othervisuals = removechevronsfromarray( othervisuals, label );
    othervisuals = postshipmodifychevrons( othervisuals, label );
    chevrons = [];
    
    foreach ( visual in othervisuals )
    {
        index = chevrons.size;
        chevrons[ index ] = visual;
        chevrons[ index ].numchevrons = 1;
        
        if ( isdefined( visual.script_noteworthy ) )
        {
            if ( visual.script_noteworthy == "2" )
            {
                chevrons[ index ].numchevrons = 2;
            }
            else if ( visual.script_noteworthy == "3" )
            {
                chevrons[ index ].numchevrons = 3;
            }
            else if ( visual.script_noteworthy == "4" )
            {
                chevrons[ index ].numchevrons = 4;
            }
        }
        
        if ( isdefined( visual.numchevrons ) )
        {
            chevrons[ index ].numchevrons = visual.numchevrons;
        }
    }
    
    self.chevrons = chevrons;
    set_chevron_state( "idle" );
}

// Namespace control
// Params 2
// Checksum 0xbb481b1f, Offset: 0x3116
// Size: 0x376
function removechevronsfromarray( othervisuals, label )
{
    var_98c9d5bd477d820b = [];
    
    switch ( level.mapname )
    {
        case #"hash_dfa04d97b4cc9b44":
            var_98c9d5bd477d820b[ "_a" ] = [ ( -8705.1, 41410.1, 262.553 ), ( -8789.1, 41434.1, 267.825 ), ( -8843.1, 41446.1, 266.31 ), ( -8915.9, 41987.1, 267.008 ), ( -8867.9, 42003.1, 266.841 ), ( -8703.9, 41957.1, 257.841 ), ( -8582.9, 41925.1, 257.841 ), ( -8458.9, 41892.1, 257.841 ), ( -8340.1, 41574.9, 257.841 ), ( -8985.69, 41784.7, 266.233 ) ];
            var_98c9d5bd477d820b[ "_b" ] = [ ( -7198, 43939, 261 ), ( -7440, 43669, 256 ), ( -6924.37, 43159.2, 262.694 ), ( -7237.4, 43784.4, 269.851 ), ( -7209.91, 43870, 267.73 ), ( -7188.96, 43931.1, 265.13 ), ( -7291.54, 43763.5, 257.326 ), ( -6795.05, 43444.3, 247.059 ), ( -6820.03, 43382.4, 238.789 ), ( -6845.69, 43287.7, 253.317 ), ( -6871.27, 43206.3, 271.569 ) ];
            break;
        case #"hash_85e9d22b30423202":
            var_98c9d5bd477d820b[ "_a" ] = [ ( -13759, -9636, 51 ) ];
            break;
        default:
            break;
    }
    
    if ( isdefined( var_98c9d5bd477d820b[ label ] ) )
    {
        foreach ( removalpoint in var_98c9d5bd477d820b[ label ] )
        {
            bestfit = spawnstruct();
            bestfit.visual = undefined;
            bestfit.distancesquared = undefined;
            
            foreach ( visual in othervisuals )
            {
                distancesquared = distancesquared( removalpoint, visual.origin );
                
                if ( distancesquared > 400 )
                {
                    continue;
                }
                
                if ( !isdefined( bestfit.distancesquared ) || distancesquared < bestfit.distancesquared )
                {
                    bestfit.visual = visual;
                    bestfit.distancesquared = distancesquared;
                }
            }
            
            if ( isdefined( bestfit.visual ) )
            {
                othervisuals = arrayremove( othervisuals, bestfit.visual );
            }
        }
    }
    
    return othervisuals;
}

// Namespace control
// Params 2
// Checksum 0xb1c3be3f, Offset: 0x3495
// Size: 0x533
function postshipmodifychevrons( othervisuals, label )
{
    newchevrons = [];
    
    switch ( level.mapname )
    {
        case #"hash_dfa04d97b4cc9b44":
            newchevrons[ "_a" ] = [];
            newchevrons[ "_a" ][ 0 ] = [ ( -8705.1, 41410.1, 268 ), ( 0, 74, 0 ) ];
            newchevrons[ "_a" ][ 1 ] = [ ( -8789.1, 41434.1, 270 ), ( 0, 74, 0 ) ];
            newchevrons[ "_a" ][ 2 ] = [ ( -8843.1, 41446.1, 270 ), ( 0, 74, 0 ) ];
            newchevrons[ "_a" ][ 3 ] = [ ( -8936.38, 41990.3, 282 ), ( 0, 344, 0 ) ];
            newchevrons[ "_a" ][ 4 ] = [ ( -8875.08, 42015.3, 288.024 ), ( 0, 255, 0 ) ];
            newchevrons[ "_a" ][ 5 ] = [ ( -8702.42, 41972.5, 277.812 ), ( 0, 255, 0 ) ];
            newchevrons[ "_a" ][ 6 ] = [ ( -8582.16, 41936.6, 277.812 ), ( 0, 255, 0 ) ];
            newchevrons[ "_a" ][ 7 ] = [ ( -8456, 41902, 280 ), ( 0, 255, 0 ) ];
            newchevrons[ "_a" ][ 8 ] = [ ( -8328.93, 41577.2, 258.001 ), ( 0, 164, 0 ) ];
            newchevrons[ "_a" ][ 9 ] = [ ( -8984.06, 41783.8, 266.233 ), ( 0, 344, 0 ) ];
            newchevrons[ "_b" ] = [];
            newchevrons[ "_b" ][ 0 ] = [ ( -7268.6, 43247.6, 302.314 ), ( 0, 75, 0 ) ];
            newchevrons[ "_b" ][ 1 ] = [ ( -7417.31, 43277.5, 310.182 ), ( 0, 75, 0 ) ];
            newchevrons[ "_b" ][ 2 ] = [ ( -7489.92, 43298.4, 320.182 ), ( 0, 75, 0 ) ];
            newchevrons[ "_b" ][ 3 ] = [ ( -6936.37, 43155.1, 261.456 ), ( 0, 75, 0 ) ];
            newchevrons[ "_b" ][ 4 ] = [ ( -7237.4, 43784.4, 269.851 ), ( 0, 340, 0 ) ];
            newchevrons[ "_b" ][ 5 ] = [ ( -7209.91, 43870, 267.73 ), ( 0, 340, 0 ) ];
            newchevrons[ "_b" ][ 6 ] = [ ( -7188.96, 43931.1, 265.13 ), ( 0, 340, 0 ) ];
            newchevrons[ "_b" ][ 7 ] = [ ( -7291.54, 43763.5, 257.326 ), ( 0, 253, 0 ) ];
            newchevrons[ "_b" ][ 8 ] = [ ( -6795.05, 43444.3, 247.059 ), ( 0, 160, 0 ) ];
            newchevrons[ "_b" ][ 9 ] = [ ( -6820.03, 43382.4, 238.789 ), ( 0, 160, 0 ) ];
            newchevrons[ "_b" ][ 10 ] = [ ( -6843.79, 43311.7, 245.027 ), ( 0, 160, 0 ) ];
            newchevrons[ "_b" ][ 11 ] = [ ( -6863.11, 43221.2, 271.244 ), ( 0, 160, 0 ) ];
            newchevrons[ "_b" ][ 12 ] = [ ( -6882.7, 43159.3, 268.085 ), ( 0, 160, 0 ) ];
            break;
    }
    
    if ( isdefined( newchevrons[ label ] ) )
    {
        modifiedvisuals = [];
        
        foreach ( entry in newchevrons[ label ] )
        {
            origin = entry[ 0 ];
            angles = entry[ 1 ];
            scriptable = spawnscriptable( "hardpoint_chevron", origin, angles );
            modifiedvisuals[ modifiedvisuals.size ] = scriptable;
        }
        
        othervisuals = arraycombine( othervisuals, modifiedvisuals );
    }
    
    return othervisuals;
}

// Namespace control
// Params 1
// Checksum 0x9a5166c1, Offset: 0x39d1
// Size: 0xff
function set_chevron_state( state )
{
    self notify( #"hash_4b8378ba629fc7e4" );
    self endon( #"hash_4b8378ba629fc7e4" );
    
    while ( !isdefined( self.chevrons ) )
    {
        waitframe();
    }
    
    var_1a5d8528edba5ab0 = "chevron_";
    
    foreach ( chevron in self.chevrons )
    {
        for ( i = 0; i < chevron.numchevrons ; i++ )
        {
            chevron setscriptablepartstate( var_1a5d8528edba5ab0 + i + ( level.gametypebundle.var_45b9f58d54501ba6 ?? "" ), state );
        }
    }
}

// Namespace control
// Params 0
// Checksum 0xd464a51e, Offset: 0x3ad8
// Size: 0x1c7
function update_chevrons()
{
    if ( isdefined( level.gametypebundle.var_ae100eea97c7fcc7[ #"hash_14bb716c4b77c45a" ] ) )
    {
        claimteamname = gameobjects_shared::function_d071a38f7d43555a( self );
        var_4a7cd465ff58f423 = claimteamname == "all" || claimteamname == "tie" ? #"hash_a1360b18943e920" : game_utility_mp::is_attacker_team( claimteamname ) ? #"hash_7118f9343873352b" : game_utility_mp::is_defender_team( claimteamname ) ? #"hash_ce911e3bbe99421f" : claimteamname == "none" || claimteamname == "neutral" ? #"hash_bb332da19f9944df" : undefined;
        
        if ( self.segmentupdate >= level.capturesegments || self.ownerteam == game[ "attackers" ] )
        {
            thread set_chevron_state( "off" );
        }
        else if ( claimteamname == #"all" || claimteamname == #"tie" )
        {
            thread set_chevron_state( "contested" );
        }
        else if ( claimteamname == #"none" )
        {
            thread set_chevron_state( "idle" );
        }
        else
        {
            thread set_chevron_state( claimteamname );
        }
        
        return;
    }
    
    if ( self.segmentupdate >= level.capturesegments || self.ownerteam == game[ "attackers" ] )
    {
        thread set_chevron_state( "off" );
        return;
    }
    
    if ( self.stalemate )
    {
        thread set_chevron_state( "contested" );
        return;
    }
    
    if ( self.isunoccupied )
    {
        thread set_chevron_state( "idle" );
        return;
    }
    
    thread set_chevron_state( self.mostnumtouchingteam );
}

// Namespace control
// Params 1
// Checksum 0x1c74b03e, Offset: 0x3ca7
// Size: 0x305
function function_8314535b81f548e( deathdata )
{
    einflictor = deathdata.inflictor;
    attacker = deathdata.attacker;
    victim = deathdata.victim;
    idamage = deathdata.damage;
    smeansofdeath = deathdata.meansofdeath;
    objweapon = deathdata.objweapon;
    vdir = deathdata.direction_vec;
    shitloc = deathdata.hitloc;
    psoffsettime = deathdata.psoffsettime;
    deathanimduration = deathdata.deathanimduration;
    killid = deathdata.lifeid;
    
    if ( isplayer( attacker ) && attacker != victim && attacker.team != victim.team )
    {
        livescount = teams::getteamdata( victim.team, "controlUILivesCount" );
        teamcount = teams::getteamdata( victim.team, "teamCount" );
        
        if ( livescount - 1 == teamcount )
        {
            codcaster_utils::function_3038b6eafc46c037( 24, victim.team );
        }
        
        if ( !level.ignorescoring )
        {
            function_9d8795cdad6c46ee( attacker, victim );
        }
        
        victim obj_dom::awardgenericmedals( einflictor, attacker, idamage, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, deathanimduration, killid );
    }
    
    currentteam = victim.team;
    issuicide = victim damage::issuicide( einflictor, attacker, smeansofdeath, objweapon );
    isteamkill = victim damage::isteamkill( einflictor, attacker );
    
    if ( isdefined( victim.joining_team ) && victim.joining_team != "spectator" )
    {
        currentteam = team_utility::getotherteam( victim.joining_team );
    }
    
    if ( ( issuicide || isteamkill ) && !level.suicideteamkilllowerslives && !victim.switching_teams )
    {
        if ( teams::getteamdata( currentteam, "noRespawns" ) )
        {
            victim thread playerlogic::spawnclient();
        }
        
        level thread function_eab3882e7f666e70( victim, currentteam );
        return;
    }
    
    game[ "match_kills" ][ team_utility::getotherteam( currentteam ) ]++;
    victim function_3051ed96cb1122ee( victim, currentteam, attacker );
    
    if ( attacker != victim )
    {
        total_lives_left = get_lives( currentteam, 1 );
        
        if ( total_lives_left < 3 )
        {
            if ( !isdefined( attacker.jokerkillcount ) )
            {
                attacker.jokerkillcount = 0;
            }
            
            attacker.jokerkillcount++;
            
            if ( total_lives_left == 0 && attacker.jokerkillcount == 3 )
            {
                attacker thread points::doscoreevent( #"mode_sd_control_joker" );
            }
        }
    }
}

// Namespace control
// Params 2
// Checksum 0xefe57f6f, Offset: 0x3fb4
// Size: 0x165
function function_9d8795cdad6c46ee( killer, victim )
{
    if ( isplayer( killer ) && killer != victim && killer.team != victim.team )
    {
        var_d74427248f992d2d = killer.team == game[ "attackers" ];
        
        if ( var_d74427248f992d2d )
        {
            killer codcasterclientmatchdata::function_8ecc753b54a5740f( 10, 1 );
        }
        else
        {
            killer codcasterclientmatchdata::function_8ecc753b54a5740f( 9, 1 );
        }
        
        foreach ( zone in level.objectives )
        {
            if ( !isdefined( zone.trigger ) )
            {
                continue;
            }
            
            if ( var_d74427248f992d2d )
            {
                var_b7f02f7ff6c3cdf3 = killer istouching( zone.trigger );
                
                if ( var_b7f02f7ff6c3cdf3 )
                {
                    killer codcasterclientmatchdata::function_8ecc753b54a5740f( 11, 1 );
                }
                
                continue;
            }
            
            var_53718de17ea4f0a2 = victim istouching( zone.trigger );
            
            if ( var_53718de17ea4f0a2 )
            {
                killer codcasterclientmatchdata::function_8ecc753b54a5740f( 11, 1 );
            }
        }
    }
}

// Namespace control
// Params 3
// Checksum 0xa0313039, Offset: 0x4121
// Size: 0x162
function function_3051ed96cb1122ee( player, affectedteam, attacker )
{
    if ( !teams::getteamdata( affectedteam, "noRespawns" ) && teams::getteamdata( affectedteam, "livesCount" ) == 0 )
    {
        function_1f8f65d459a3e726( affectedteam );
    }
    
    level.teamdata[ affectedteam ][ "controlUILivesCount" ]--;
    level function_18b90a2be8797f0d();
    total_lives_left = get_lives( affectedteam, 1 );
    teamcount = teams::getteamdata( affectedteam, "teamCount" );
    
    if ( isdefined( attacker ) && attacker != player && total_lives_left <= 3 )
    {
        if ( get_lives( attacker.team, 1 ) == 1 )
        {
            events::function_f49e24ff9e0db53d( attacker, player );
        }
    }
    
    if ( total_lives_left == 0 && level.numteamlives != 0 || teamcount == 0 )
    {
        if ( isdefined( attacker ) )
        {
            attacker thread points::doscoreevent( #"hash_e35b1029889d836c" );
        }
        
        otherteam = team_utility::getotherteam( affectedteam );
        
        if ( otherteam == game[ "attackers" ] )
        {
            level.var_f49b7901d4911e49 = 1;
        }
        
        events::function_8a990b3daa34d46a( otherteam, affectedteam );
        level thread gamelogic_mp::endgame( otherteam, game[ "end_reason" ][ "enemies_eliminated" ], game[ "end_reason" ][ "friendlies_eliminated" ] );
        codcasterclientmatchdata::function_d6aea11d2e9ba521();
    }
}

// Namespace control
// Params 1
// Checksum 0x1fc60451, Offset: 0x428b
// Size: 0x29
function control_ononeleftevent( team )
{
    lastplayer = game_utility_mp::getlastlivingplayer( team );
    lastplayer thread control_givelastonteamwarning();
}

// Namespace control
// Params 0
// Checksum 0xa32f14e3, Offset: 0x42bc
// Size: 0x98
function control_givelastonteamwarning()
{
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    player::waittillrecoveredhealth( 3 );
    level thread battlechatter_mp::trysaylocalsound( self, #"bc_status_inform_last_one" );
    otherteam = team_utility::getotherteam( self.pers[ "team" ] );
    level thread hud_util::teamplayercardsplash( #"last_teammate_alive_callout", self, self.pers[ "team" ] );
    level thread hud_util::teamplayercardsplash( #"last_enemy_alive_callout", self, otherteam );
    level notify( #"last_alive", self );
}

// Namespace control
// Params 1
// Checksum 0x50758a3f, Offset: 0x435c
// Size: 0xec
function function_cae49d4fbe5ead63( team )
{
    if ( game_utility::gettimepassed() < 5000 )
    {
        return;
    }
    
    players = teams::getteamdata( team, "players" );
    
    foreach ( player in players )
    {
        player thread hq::showrespawnwarningmessage();
    }
    
    dialog::statusdialog( #"hash_ce1711c9a564bc94", team, "lives" );
    other_team = team_utility::getotherteam( player.team );
    dialog::statusdialog( #"hash_5fa6004235953645", other_team, "lives" );
}

// Namespace control
// Params 6
// Checksum 0xe28f738a, Offset: 0x4450
// Size: 0x68
function onnormaldeath( victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon )
{
    if ( level.teamscoresonkill[ attacker.team ] )
    {
        common::oncommonnormaldeath( victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon );
    }
    
    level function_18b90a2be8797f0d();
}

// Namespace control
// Params 0
// Checksum 0xddf36a9d, Offset: 0x44c0
// Size: 0x8
function getflagteam()
{
    return gameobjects::getownerteam();
}

// Namespace control
// Params 0
// Checksum 0xe90a383b, Offset: 0x44d1
// Size: 0x13d
function function_abe6dad0d90f599b()
{
    /#
        setdevdvarifuninitialized( @"scr_domdebug", "<dev string:xa7>" );
    #/
    
    foreach ( controlzone in level.objectives )
    {
        controlzone.spawnflagid = getflagspawnidforobjectivekey( controlzone.objectivekey );
    }
    
    spawnpoints = level.spawnpoints;
    
    foreach ( spawnpoint in spawnpoints )
    {
        spawnpoint.scriptdata.domflagassignments = getspawnpointflagassignment( spawnpoint );
    }
}

// Namespace control
// Params 1
// Checksum 0x2756bfe7, Offset: 0x4616
// Size: 0x61
function getflagspawnidforobjectivekey( objectivekey )
{
    switch ( objectivekey )
    {
        case #"hash_fac2c5f6bddd49bd":
            return 1;
        case #"hash_fac2c2f6bddd4504":
            return 2;
        case #"hash_fac2c3f6bddd4697":
            return 4;
        case #"hash_fac2c0f6bddd41de":
            return 8;
        case #"hash_fac2c1f6bddd4371":
            return 16;
    }
}

// Namespace control
// Params 1
// Checksum 0x29c81433, Offset: 0x4680
// Size: 0xf3
function getspawnpointflagassignment( spawnpoint )
{
    if ( game_utility::isarenamap() )
    {
        if ( spawnpoint.script_noteworthy == "1" || spawnpoint.script_noteworthy == "2" || spawnpoint.script_noteworthy == "3" )
        {
            spawnpoint.script_noteworthy = "";
        }
    }
    
    if ( isdefined( spawnpoint.script_noteworthy ) && spawnpoint.script_noteworthy != "" && spawnpoint.script_noteworthy != "6v6" && spawnpoint.script_noteworthy != "10v10" )
    {
        var_7237854e3be197ca = parseflagassignmentstring( spawnpoint.script_noteworthy );
        
        if ( isdefined( var_7237854e3be197ca ) )
        {
            return var_7237854e3be197ca;
        }
    }
    
    return findnearestdompoint( spawnpoint.origin ).spawnflagid;
}

// Namespace control
// Params 1
// Checksum 0x80038fd7, Offset: 0x477c
// Size: 0xdf
function parseflagassignmentstring( stringvalue )
{
    stringvalue = tolower( stringvalue );
    
    switch ( stringvalue )
    {
        case #"hash_31103fbc01bd840c":
            return 1;
        case #"hash_311042bc01bd88c5":
            return 2;
        case #"hash_311041bc01bd8732":
            return 4;
        case #"hash_31103cbc01bd7f53":
            return 8;
        case #"hash_31103bbc01bd7dc0":
            return 16;
        case #"hash_fa18c2f6bd57792a":
        case #"hash_fa21b1f6bd5e1a2c":
            return 32;
        case #"hash_fa1ecaf6bd5c02f0":
        case #"hash_fa21b3f6bd5e1d52":
            return 64;
        case #"hash_fa18c3f6bd577abd":
        case #"hash_fa1ecdf6bd5c07a9":
            return 128;
        default:
            assertmsg( "<dev string:xa9>" + stringvalue + "<dev string:xdf>" );
            break;
    }
}

// Namespace control
// Params 1
// Checksum 0xe3ceae34, Offset: 0x4863
// Size: 0x23d
function findnearestdompoint( pos )
{
    /#
        if ( !isnavmeshloaded() )
        {
            return dom::function_eac831db102ec430( pos );
        }
    #/
    
    navmeshpoints = [];
    
    foreach ( dompoint in level.objectives )
    {
        dompoint.navmeshpos = getclosestpointonnavmesh( dompoint.trigger.origin );
        navmeshpoints[ navmeshpoints.size ] = dompoint.navmeshpos;
    }
    
    var_a33a56db6de8c0f = findclosestpointbyapproxpathdist( navmeshpoints, getclosestpointonnavmesh( pos ) );
    nearestdompoint = undefined;
    
    if ( !isdefined( var_a33a56db6de8c0f ) )
    {
        nearestdist = undefined;
        
        foreach ( dompoint in level.objectives )
        {
            dist = distancesquared( dompoint.trigger.origin, pos );
            
            if ( !isdefined( nearestdompoint ) || dist < nearestdist )
            {
                nearestdompoint = dompoint;
                nearestdist = dist;
            }
        }
    }
    else
    {
        foreach ( dompoint in level.objectives )
        {
            if ( distance2dsquared( dompoint.navmeshpos, var_a33a56db6de8c0f ) < 1 )
            {
                nearestdompoint = dompoint;
                break;
            }
        }
        
        assert( isdefined( nearestdompoint ) );
    }
    
    return nearestdompoint;
}

// Namespace control
// Params 1
// Checksum 0x605684ea, Offset: 0x4aa9
// Size: 0x65
function onspawnplayer( spawndata )
{
    thread updatematchstatushintonspawn();
    
    if ( teams::getteamdata( self.team, "livesCount" ) == 0 && teams::getteamdata( self.team, "noRespawns" ) == 0 && level.numteamlives != 0 )
    {
        function_1f8f65d459a3e726( self.team );
    }
}

// Namespace control
// Params 2
// Checksum 0x6f1642c3, Offset: 0x4b16
// Size: 0x5c, Type: bool
function function_2d689f01dd4d3abd( player, revivespawn )
{
    if ( teams::getteamdata( player.team, "noRespawns" ) && player.team != "none" && player.team != "spectator" )
    {
        return true;
    }
    
    return false;
}

// Namespace control
// Params 1
// Checksum 0x7ebdaea7, Offset: 0x4b7b
// Size: 0x15
function control_onplayerconnect( player )
{
    player thread onplayerspawned();
}

// Namespace control
// Params 1
// Checksum 0x8146cba7, Offset: 0x4b98
// Size: 0x28
function onplayerdisconnect( params )
{
    if ( player::isreallyalive( self ) )
    {
        function_3051ed96cb1122ee( self, self.team, undefined );
    }
}

// Namespace control
// Params 2
// Checksum 0xd83ef596, Offset: 0x4bc8
// Size: 0x67
function function_eab3882e7f666e70( player, currentteam )
{
    level.teamdata[ currentteam ][ "uncountedDeaths" ]++;
    player.uncounteddeath = 1;
    player utility::waittill_any( "spawned", "disconnect" );
    level.teamdata[ currentteam ][ "uncountedDeaths" ]--;
    player.uncounteddeath = undefined;
}

// Namespace control
// Params 0
// Checksum 0x28bbef4e, Offset: 0x4c37
// Size: 0x3ba
function function_18b90a2be8797f0d()
{
    attackersalivecount = teams::getteamdata( "allies", "aliveCount" );
    defendersalivecount = teams::getteamdata( "axis", "aliveCount" );
    
    if ( level.numteamlives == 0 )
    {
        setomnvar( "ui_allies_alive", teams::getteamdata( "allies", "teamCount" ) );
        setomnvar( "ui_axis_alive", teams::getteamdata( "axis", "teamCount" ) );
        setomnvar( "ui_allies_lives_remaining", teams::getteamdata( "allies", "teamCount" ) );
        setomnvar( "ui_axis_lives_remaining", teams::getteamdata( "axis", "teamCount" ) );
        return;
    }
    else if ( attackersalivecount > level.numteamlives || defendersalivecount > level.numteamlives )
    {
        var_9c81f0eee229adb2 = attackersalivecount > defendersalivecount ? attackersalivecount : defendersalivecount;
        function_fc7a52f4d4032ae2( "allies", var_9c81f0eee229adb2 );
        function_fc7a52f4d4032ae2( "axis", var_9c81f0eee229adb2 );
        level.numteamlives = var_9c81f0eee229adb2;
    }
    
    setomnvar( "ui_allies_alive", get_lives( "allies", 1 ) );
    setomnvar( "ui_axis_alive", get_lives( "axis", 1 ) );
    setomnvar( "ui_allies_lives_remaining", get_lives( "allies", 1 ) );
    setomnvar( "ui_axis_lives_remaining", get_lives( "axis", 1 ) );
    var_a93ce3abf473b242 = level.teamdata[ "allies" ][ "teamCount" ];
    
    if ( teams::getteamdata( "allies", "livesCount" ) <= 10 && !level.var_764eb1e7a422f321 && level.numteamlives - var_a93ce3abf473b242 > 10 )
    {
        dialog::statusdialog( #"hash_c466c50af843beed", "allies", "lives" );
        dialog::statusdialog( #"hash_ede927938d622c2e", "axis", "lives" );
        level.var_764eb1e7a422f321 = 1;
    }
    
    var_ca46b02457bf6e22 = level.teamdata[ "axis" ][ "teamCount" ];
    
    if ( teams::getteamdata( "axis", "livesCount" ) <= 10 && !level.var_764eb4e7a422f9ba && level.numteamlives - var_ca46b02457bf6e22 > 10 )
    {
        dialog::statusdialog( #"hash_c466c50af843beed", "axis", "lives" );
        dialog::statusdialog( #"hash_ede927938d622c2e", "allies", "lives" );
        level.var_764eb4e7a422f9ba = 1;
    }
    
    foreach ( player in level.players )
    {
        if ( !team_utility::isgameplayteam( player.team ) || game[ "eliminated" ][ player.team ] )
        {
            continue;
        }
        
        player setclientomnvar( "ui_friendly_alive", get_lives( player.team, 1 ) );
        player setclientomnvar( "ui_friendly_team_size", teams::getteamcount( player.team ) );
        enemyteam = team_utility::getotherteam( player.team );
        
        if ( isdefined( enemyteam ) )
        {
            player setclientomnvar( "ui_enemy_alive", get_lives( enemyteam, 1 ) );
            player setclientomnvar( "ui_enemy_team_size", teams::getteamcount( enemyteam ) );
        }
    }
}

// Namespace control
// Params 2
// Checksum 0x9b1aa0f9, Offset: 0x4ff9
// Size: 0xf0
function function_fc7a52f4d4032ae2( team_name, var_157b222b41e61688 )
{
    alivecount = teams::getteamdata( team_name, "aliveCount" );
    livescount = teams::getteamdata( team_name, "livesCount" );
    uicount = teams::getteamdata( team_name, "controlUILivesCount" );
    
    if ( var_157b222b41e61688 < uicount || var_157b222b41e61688 < alivecount + livescount )
    {
        assertmsg( "<dev string:x121>" + team_name );
        return;
    }
    
    if ( alivecount + livescount < var_157b222b41e61688 )
    {
        var_79f52678a11f3abc = var_157b222b41e61688 - alivecount + livescount;
        level.teamdata[ team_name ][ "livesCount" ] = level.teamdata[ team_name ][ "livesCount" ] + var_79f52678a11f3abc;
        level.teamdata[ team_name ][ "noRespawns" ] = 0;
    }
    
    if ( uicount != var_157b222b41e61688 )
    {
        level.teamdata[ team_name ][ "controlUILivesCount" ] = var_157b222b41e61688;
    }
}

// Namespace control
// Params 0
// Checksum 0x8894583f, Offset: 0x50f1
// Size: 0xa
function function_5aad2954b2488d1()
{
    level function_18b90a2be8797f0d();
}

// Namespace control
// Params 2
// Checksum 0xcadaad35, Offset: 0x5103
// Size: 0x86
function get_lives( team, internal_count )
{
    total_lives = undefined;
    
    if ( internal_count )
    {
        total_lives = level.teamdata[ team ][ "controlUILivesCount" ];
    }
    else
    {
        livescount = teams::getteamdata( team, "livesCount" );
        alivecount = teams::getteamdata( team, "aliveCount" );
        total_lives = livescount + alivecount;
    }
    
    if ( !isdefined( total_lives ) || total_lives < 0 )
    {
        total_lives = 0;
    }
    
    return total_lives;
}

// Namespace control
// Params 1
// Checksum 0x5120d410, Offset: 0x5192
// Size: 0x73
function onplayerspawned( player )
{
    self endon( #"disconnect" );
    
    while ( true )
    {
        self waittill( #"spawned" );
        stats::setextrascore0( self.pers[ "damage" ] ?? 0, "damage" );
        stats::setextrascore1( self.pers[ "segmentCaptures" ] ?? 0, "segmentCaptures" );
        level function_18b90a2be8797f0d();
    }
}

// Namespace control
// Params 6
// Checksum 0x59fc409f, Offset: 0x520d
// Size: 0x4cc
function function_90157b9728a6c497( objectivetype, label, credit_player, team, oldteam, flagobj )
{
    level.usestartspawns = 0;
    assert( team != "<dev string:x152>" );
    game[ "segment_captures" ][ team ]++;
    codcaster_utils::function_eddb7bc4ce563395( game[ "segment_captures" ][ team ], team );
    credit_player = gameobjects::function_96e1d4c0c873649( credit_player );
    
    foreach ( struct in self.touchlist[ team ] )
    {
        player = struct.player;
        function_2ad7125bd77df7b0( player );
    }
    
    otherteam = team_utility::getotherteam( team );
    allflagscaptured = obj_dom::getteamflagcount( team ) == level.objectives.size;
    soundref = allflagscaptured ? #"control_flag_captured_all" : #"control_flag_captured";
    soundref_otherteam = allflagscaptured ? #"control_flag_lost_all" : #"control_flag_lost";
    gameplay_sound_fx::function_e319dc8e16c85fcb( soundref, teams::getteamdata( team, "players" ) );
    gameplay_sound_fx::function_e319dc8e16c85fcb( soundref_otherteam, teams::getteamdata( otherteam, "players" ) );
    
    if ( !allflagscaptured )
    {
        dialog::statusdialog( hashcat( #"secured", self.objectivekey ), team );
        
        if ( oldteam == "neutral" )
        {
            if ( isdefined( level.objectives ) && level.objectives.size == 5 && ( self.objectivekey == "_c" || self.objectivekey == "_d" ) || self.objectivekey == "_b" )
            {
                dialog::statusdialog( hashcat( #"lost", self.objectivekey ), team );
            }
        }
        else
        {
            dialog::statusdialog( hashcat( #"lost", self.objectivekey ), otherteam );
        }
    }
    else
    {
        dialog::statusdialog( #"gamestate_domwinning", team );
        dialog::statusdialog( #"gamestate_domlosing", otherteam );
    }
    
    if ( !isdefined( level.var_3be9a1b658ae8cda ) )
    {
        level.var_3be9a1b658ae8cda = 0;
    }
    
    level.var_3be9a1b658ae8cda++;
    setomnvar( "ui_objective_destroyed" + self.objectivekey, 1 );
    
    if ( level.var_3be9a1b658ae8cda == level.objectives.size - 1 )
    {
        dialog::statusdialog( #"attack_last_flag", team, "finale" );
        dialog::statusdialog( #"defend_last_flag", otherteam, "finale" );
        level callback::callback( #"music_event", { #event_type:#"control_point_captured" } );
    }
    
    if ( level.var_3be9a1b658ae8cda == level.objectives.size )
    {
        events::function_8a990b3daa34d46a( game[ "attackers" ], game[ "defenders" ] );
        level thread gamelogic_mp::endgame( game[ "attackers" ], game[ "end_reason" ][ "control_allzones_win" ], game[ "end_reason" ][ "control_allzones_loss" ] );
        codcasterclientmatchdata::function_d6aea11d2e9ba521();
    }
    else
    {
        flagobj.var_dfc20331de7b5040 = 0;
        otherflag = arrayremove( level.objectives, flagobj )[ 0 ];
        
        if ( !otherflag.var_dfc20331de7b5040 )
        {
            gamelogic_mp::resumetimer();
        }
        
        if ( level.segmentcaptureextratime > 0 )
        {
            thread function_7be446c06a37ae01( level.segmentcaptureextratime, istrue( otherflag.var_dfc20331de7b5040 ) );
        }
        else
        {
            thread function_7be446c06a37ae01( level.captureextratime, istrue( otherflag.var_dfc20331de7b5040 ) );
        }
    }
    
    capturedwaypoint = gameobjects::function_200f451ac659e0f3( flagobj.curorigin, flagobj.offset3d, 1, 0 );
    capturedwaypoint gameobjects::setobjectivestatusicons( "icon_waypoint_dom_captured" );
    level.var_5fd5d93fc6b912ba[ label ] = capturedwaypoint;
    dlog_recordevent( "dlog_event_mp_objective_ownership_changed", [ "key", flagobj.objectivekey, "team", team, "match_time_ms", matchdata::function_47550968a937b67e( gettime() ) ] );
    obj_dom::removeobjective( flagobj );
    function_ca30be9f04600a82( flagobj.objidnum );
}

// Namespace control
// Params 3
// Checksum 0xf0f60f9d, Offset: 0x56e1
// Size: 0x19e
function function_a2eed2aa2ff4c34c( team, capplayer, segment )
{
    otherteam = team_utility::getotherteam( team );
    capplayer = gameobjects::function_96e1d4c0c873649( capplayer );
    
    if ( self.segmentupdate != level.capturesegments )
    {
        game[ "segment_captures" ][ team ]++;
        
        foreach ( struct in self.touchlist[ team ] )
        {
            if ( isplayer( struct.player ) )
            {
                struct.player thread points::doscoreevent( #"hash_abab8433567988da" );
                function_2ad7125bd77df7b0( struct.player );
            }
        }
        
        codcaster_utils::function_eddb7bc4ce563395( game[ "segment_captures" ][ team ], team );
    }
    
    if ( segment < level.capturesegments )
    {
        gameplay_sound_fx::function_e319dc8e16c85fcb( #"control_win_section", teams::getteamdata( team, "players" ) );
        gameplay_sound_fx::function_e319dc8e16c85fcb( #"control_lose_section", teams::getteamdata( otherteam, "players" ) );
    }
    
    pause_timer = segment != level.capturesegments;
    
    if ( level.segmentcaptureextratime > 0 )
    {
        thread function_7be446c06a37ae01( level.segmentcaptureextratime, pause_timer );
    }
}

// Namespace control
// Params 2
// Checksum 0x5e1483e8, Offset: 0x5887
// Size: 0xb9
function function_7be446c06a37ae01( time, pause_game )
{
    if ( level.timelimit == 0 )
    {
        return;
    }
    
    if ( !isdefined( level.extratime ) )
    {
        level.extratime = 0;
    }
    
    level.extratime += time;
    timeremaining = gamelogic_mp::gettimeremaining();
    gamelogic_mp::resumetimer( level.extratime + timeremaining );
    
    if ( hasomnvar( o"ui_match_extra_time" ) )
    {
        setomnvar( o"ui_match_extra_time", int( level.extratime ) );
    }
    
    waitframe();
    
    if ( level.pausetimer && pause_game )
    {
        gamelogic_mp::pausetimer();
    }
}

// Namespace control
// Params 0
// Checksum 0xa67cf4f6, Offset: 0x5948
// Size: 0x317, Type: bool
function function_9bd49188af67a5b4()
{
    startpos = self geteye();
    viewangles = self getplayerangles();
    fwd = anglestoforward( viewangles );
    mindot = cos( 10 );
    maxdistsq = 250000;
    bestdot = undefined;
    bestent = undefined;
    closestdistsq = undefined;
    closestent = undefined;
    
    foreach ( ent in level.objectives )
    {
        totarget = vectornormalize( ent.trigger.origin - startpos );
        dot = vectordot( fwd, totarget );
        distsq = distancesquared( ent.trigger.origin, startpos );
        
        if ( !isdefined( bestdot ) || bestdot < dot )
        {
            bestdot = dot;
            bestent = ent;
        }
        
        if ( !isdefined( closestdistsq ) || closestdistsq > distsq )
        {
            closestdistsq = distsq;
            closestent = ent;
        }
    }
    
    msg = undefined;
    event = undefined;
    
    if ( bestdot > mindot )
    {
        ent = bestent;
        objectivename = getsubstr( ent.objectivekey, 1, 2 );
        
        if ( ent.ownerteam == "neutral" )
        {
            msg = self.name + ": Capture " + objectivename + "!";
            event = "capture";
        }
        else if ( ent.ownerteam == self.team )
        {
            msg = self.name + ": Defend  " + objectivename + "!";
            event = "defend";
        }
        else
        {
            msg = self.name + ": Assault " + objectivename + "!";
            event = "assault";
        }
    }
    else if ( closestdistsq < maxdistsq )
    {
        ent = closestent;
        objectivename = getsubstr( ent.objectivekey, 1, 2 );
        
        if ( ent.ownerteam == "neutral" )
        {
            msg = self.name + ": Capture " + objectivename + "!";
            event = "capture";
        }
        else if ( ent.ownerteam == self.team )
        {
            msg = self.name + ": Defend  " + objectivename + "!";
            event = "defend";
        }
        else
        {
            msg = self.name + ": Assault " + objectivename + "!";
            event = "assault";
        }
    }
    
    if ( isdefined( ent ) )
    {
        thread gestures::applygamemodecallout( ent, msg, event );
    }
    
    return isdefined( ent );
}

// Namespace control
// Params 2
// Checksum 0x964aefd9, Offset: 0x5c68
// Size: 0xaf
function function_e5dc2d9d332f830( event, player )
{
    giveconfirm = 0;
    
    switch ( event )
    {
        case #"hash_7f5ae40133d322a1":
            if ( player.team == self.team )
            {
                giveconfirm = 1;
            }
            
            break;
        case #"hash_8b567e450ad3ae21":
            if ( player.team == self.team )
            {
                giveconfirm = 1;
            }
            
            break;
        case #"hash_d4f05e450448c3ec":
            if ( player.team == self.team )
            {
                giveconfirm = 1;
            }
            
            break;
    }
    
    return giveconfirm;
}

// Namespace control
// Params 1
// Checksum 0x35ecf981, Offset: 0x5d20
// Size: 0xc0, Type: bool
function function_d54721b242020b13( excludedflag )
{
    if ( !isdefined( level.objectives ) )
    {
        return false;
    }
    
    var_21450e1099027f64 = level.objectives;
    
    if ( isdefined( excludedflag ) )
    {
        var_21450e1099027f64 = arrayremove( var_21450e1099027f64, excludedflag );
    }
    
    foreach ( objective in level.objectives )
    {
        if ( objective.var_dfc20331de7b5040 )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace control
// Params 0
// Checksum 0x646cb3f8, Offset: 0x5de9
// Size: 0x4d
function updatematchstatushintonspawn()
{
    level endon( #"game_ended" );
    
    if ( self.team == game[ "attackers" ] )
    {
        hud_message::function_ef4318a0090caa0f( #"control_attack_zones" );
    }
    else
    {
        hud_message::function_ef4318a0090caa0f( #"control_defend_zones" );
    }
    
    level function_18b90a2be8797f0d();
}

// Namespace control
// Params 0
// Checksum 0xc99252bc, Offset: 0x5e3e
// Size: 0x19e
function updatetriggerforcodcaster()
{
    level endon( #"game_ended" );
    level waittill( #"prematch_done" );
    
    while ( !level.gameended )
    {
        foreach ( player in level.players )
        {
            mlgpoint = 0;
            
            foreach ( dompoint in level.objectives )
            {
                if ( !isdefined( dompoint.trigger ) )
                {
                    continue;
                }
                
                if ( player istouching( dompoint.trigger ) && isalive( player ) )
                {
                    mlgpoint = obj_dom::getreservedobjid( dompoint.objectivekey ) + 1;
                    break;
                }
            }
            
            if ( player.mlgpoint != mlgpoint )
            {
                player setmlgdominationpoint( mlgpoint );
                player.mlgpoint = mlgpoint;
                player setgametypevip( 1 );
            }
            
            if ( mlgpoint == 0 )
            {
                player setgametypevip( 0 );
            }
        }
        
        waitframe();
    }
}

// Namespace control
// Params 0
// Checksum 0x6b1d28b9, Offset: 0x5fe4
// Size: 0x53
function control_ontimelimit()
{
    if ( !isdefined( level.var_d95b674c4a3e8f05 ) )
    {
        events::function_8a990b3daa34d46a( game[ "defenders" ], game[ "attackers" ] );
        level thread gamelogic_mp::endgame( game[ "defenders" ], game[ "end_reason" ][ "time_limit_reached" ] );
        codcasterclientmatchdata::function_d6aea11d2e9ba521();
        level.var_d95b674c4a3e8f05 = 1;
    }
}

// Namespace control
// Params 0
// Checksum 0xadf193d9, Offset: 0x603f
// Size: 0x9
function function_a09efcf05470a3a0()
{
    codcasterclientmatchdata::function_1340113cb5a43c2c();
}

// Namespace control
// Params 1
// Checksum 0x9afac2b4, Offset: 0x6050
// Size: 0x130
function function_1f8f65d459a3e726( team )
{
    teams::setteamdata( team, "noRespawns", 1 );
    
    if ( !isdefined( level.var_c6b02af9c0f45ca2 ) )
    {
        level.var_c6b02af9c0f45ca2 = [];
    }
    
    level.var_c6b02af9c0f45ca2[ team ] = gettime();
    setomnvar( "ui_" + team + "_no_respawn", 1 );
    
    foreach ( player in level.players )
    {
        if ( !team_utility::isgameplayteam( player.team ) || game[ "eliminated" ][ player.team ] )
        {
            continue;
        }
        
        if ( player.team == team )
        {
            player setclientomnvar( "ui_friendly_no_respawn", 1 );
            continue;
        }
        
        player setclientomnvar( "ui_enemy_no_respawn", 1 );
    }
    
    function_cae49d4fbe5ead63( team );
}

// Namespace control
// Params 0
// Checksum 0xe4470473, Offset: 0x6188
// Size: 0x150
function function_71395ff3b4abe35d()
{
    attacking_team = game[ "attackers" ];
    defending_team = game[ "defenders" ];
    
    if ( level.overtimedefenders == 2 )
    {
        if ( game[ "segment_captures" ][ attacking_team ] > game[ "segment_captures" ][ defending_team ] )
        {
            return [ attacking_team, game[ "end_reason" ][ "team_defending_most_segments" ] ];
        }
        else if ( game[ "segment_captures" ][ defending_team ] > game[ "segment_captures" ][ attacking_team ] )
        {
            return [ defending_team, game[ "end_reason" ][ "team_defending_most_segments" ] ];
        }
    }
    
    totalkills[ attacking_team ] = game[ "match_kills" ][ attacking_team ];
    totalkills[ defending_team ] = game[ "match_kills" ][ defending_team ];
    
    if ( totalkills[ attacking_team ] > totalkills[ defending_team ] )
    {
        return [ attacking_team, game[ "end_reason" ][ "team_defending_most_kills" ] ];
    }
    
    if ( totalkills[ defending_team ] > totalkills[ attacking_team ] )
    {
        return [ defending_team, game[ "end_reason" ][ "team_defending_most_kills" ] ];
    }
    
    if ( randomint( 2 ) == 0 )
    {
        return [ attacking_team, game[ "end_reason" ][ "team_defending" ] ];
    }
    
    return [ defending_team, game[ "end_reason" ][ "team_defending" ] ];
}

// Namespace control
// Params 1
// Checksum 0x47c116af, Offset: 0x62e0
// Size: 0x12a
function function_2ad7125bd77df7b0( player )
{
    if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( player ) ) )
    {
        if ( isdefined( player.leaderboarddata[ "segmentCaptures" ] ) )
        {
            player.leaderboarddata[ "segmentCaptures" ] = player.leaderboarddata[ "segmentCaptures" ] + 1;
        }
        
        if ( isdefined( level.leaderboardfunc[ "segmentCaptures" ] ) )
        {
            [[ level.leaderboardfunc[ "segmentCaptures" ] ]]( player, 1 );
        }
        
        assert( isint( 1 ) || isfloat( 1 ), "<dev string:x15a>" );
        
        if ( isdefined( player.pers[ "segmentCaptures" ] ) )
        {
            player.pers[ "segmentCaptures" ] = player.pers[ "segmentCaptures" ] + 1;
        }
    }
    
    player persistence::statsetchild( "round", "segmentCaptures", player.pers[ "segmentCaptures" ] );
    player stats::setextrascore1( player.pers[ "segmentCaptures" ] );
}

// Namespace control
// Params 2
// Checksum 0xcae2b4b9, Offset: 0x6412
// Size: 0x5c
function function_e3581038ff640b3a( ownerteam, lastclaimteam )
{
    if ( ownerteam != "neutral" )
    {
        if ( ownerteam != lastclaimteam )
        {
            gameobjects::setobjectivestatusicons( level.icondefend, level.icontaking );
            return;
        }
        
        gameobjects::setobjectivestatusicons( level.icondefending, level.iconcapture );
    }
}

// Namespace control
// Params 1
// Checksum 0xb089d10b, Offset: 0x6476
// Size: 0x82
function function_f6cf25f9c109edf5( array )
{
    switch ( self.objectivekey )
    {
        case #"hash_fac2c5f6bddd49bd":
            return array[ 0 ];
        case #"hash_fac2c2f6bddd4504":
            return array[ 1 ];
        case #"hash_fac2c3f6bddd4697":
            return array[ 2 ];
        case #"hash_fac2c0f6bddd41de":
            return array[ 3 ];
        case #"hash_fac2c1f6bddd4371":
            return array[ 4 ];
        default:
            return array[ 4 ];
    }
}

/#

    // Namespace control
    // Params 0
    // Checksum 0xe8b6a409, Offset: 0x6500
    // Size: 0x22b, Type: dev
    function function_24d85ab346bf7ad9()
    {
        activesets = [];
        activesets[ activesets.size ] = spawnlogic::function_d60214213fe813d( #"primary_attackers" );
        activesets[ activesets.size ] = spawnlogic::function_d60214213fe813d( #"primary_defenders" );
        
        foreach ( zone in level.objectives )
        {
            if ( spawnlogic::useablespawnset( zone.spawnset[ #"uncaptured_defenders" ] ) )
            {
                activesets[ activesets.size ] = spawnlogic::function_d60214213fe813d( zone.spawnset[ #"uncaptured_defenders" ] );
            }
            
            if ( spawnlogic::useablespawnset( zone.spawnset[ #"uncaptured_attackers" ] ) )
            {
                activesets[ activesets.size ] = spawnlogic::function_d60214213fe813d( zone.spawnset[ #"uncaptured_attackers" ] );
            }
        }
        
        foreach ( zone in level.objectives )
        {
            if ( spawnlogic::function_75a5a3a1041468f6( #"primary", zone.spawnset[ #"captured_defenders" ] ) )
            {
                activesets[ activesets.size ] = spawnlogic::function_d60214213fe813d( zone.spawnset[ #"captured_defenders" ] );
            }
            
            if ( spawnlogic::function_75a5a3a1041468f6( #"primary", zone.spawnset[ #"captured_attackers" ] ) )
            {
                activesets[ activesets.size ] = spawnlogic::function_d60214213fe813d( zone.spawnset[ #"captured_attackers" ] );
            }
        }
        
        if ( activesets.size )
        {
            function_b5d53613b3891230( activesets );
        }
    }

    // Namespace control
    // Params 0
    // Checksum 0x1afce491, Offset: 0x6733
    // Size: 0xa4, Type: dev
    function function_7f317007253a6058()
    {
        self endon( #"game_ended" );
        
        while ( true )
        {
            if ( getdvarint( @"scr_give_score_allies" ) != 0 )
            {
                gamescore::giveteamscoreforobjective( "<dev string:x180>", getdvarint( @"scr_give_score_allies" ), 1 );
                break;
            }
            else if ( getdvarint( @"scr_give_score_axis" ) != 0 )
            {
                gamescore::giveteamscoreforobjective( "<dev string:x187>", getdvarint( @"scr_give_score_axis" ), 1 );
                break;
            }
            
            wait 1;
        }
        
        setdevdvar( @"scr_give_score_allies", 0 );
        setdevdvar( @"scr_give_score_axis", 0 );
        thread function_7f317007253a6058();
    }

    // Namespace control
    // Params 0
    // Checksum 0x13610a13, Offset: 0x67df
    // Size: 0x1e0, Type: dev
    function removedompoint()
    {
        self endon( #"game_ended" );
        
        while ( true )
        {
            if ( getdvar( @"hash_6ce167f2cdc8ef7c", "<dev string:x18c>" ) != "<dev string:x18c>" )
            {
                flaglabel = getdvar( @"hash_6ce167f2cdc8ef7c", "<dev string:x18c>" );
                
                foreach ( domflag in level.objectives )
                {
                    if ( isdefined( domflag.objectivekey ) && domflag.objectivekey == flaglabel )
                    {
                        domflag gameobjects::allowuse( "<dev string:x18d>" );
                        domflag.trigger = undefined;
                        domflag notify( #"deleted" );
                        domflag.visibleteam = "<dev string:x18d>";
                        domflag gameobjects::setobjectivestatusicons( undefined );
                        tempflags = [];
                        
                        foreach ( objective in level.objectives )
                        {
                            if ( objective.objectivekey != flaglabel )
                            {
                                tempflags[ objective.objectivekey ] = objective;
                            }
                        }
                        
                        level.objectives = tempflags;
                        break;
                    }
                }
                
                setdynamicdvar( @"hash_6ce167f2cdc8ef7c", "<dev string:x18c>" );
            }
            
            wait 1;
        }
    }

    // Namespace control
    // Params 0
    // Checksum 0xb43da9fa, Offset: 0x69c7
    // Size: 0x482, Type: dev
    function placedompoint()
    {
        self endon( #"game_ended" );
        
        while ( true )
        {
            if ( getdvar( @"hash_29d45d6822a1cf6d", "<dev string:x18c>" ) != "<dev string:x18c>" )
            {
                flaglabel = getdvar( @"hash_29d45d6822a1cf6d", "<dev string:x18c>" );
                zone = spawnstruct();
                zone.origin = level.players[ 0 ].origin;
                zone.angles = level.players[ 0 ].angles;
                trigger = spawn( "<dev string:x192>", zone.origin, 0, 120, 128 );
                zone.trigger = trigger;
                zone.trigger.script_label = flaglabel;
                zone.ownerteam = "<dev string:x152>";
                tracestart = zone.origin + ( 0, 0, 32 );
                traceend = zone.origin + ( 0, 0, -32 );
                trace = trace::ray_trace( tracestart, traceend, undefined, trace::create_default_contents( 1 ) );
                zone.origin = trace[ "<dev string:x1a1>" ];
                zone.upangles = vectortoangles( trace[ "<dev string:x1aa>" ] );
                zone.forward = anglestoforward( zone.upangles );
                zone.right = anglestoright( zone.upangles );
                zone.visuals[ 0 ] = spawn( "<dev string:x1b1>", zone.origin );
                zone.visuals[ 0 ].angles = zone.angles;
                domflag = gameobjects::createuseobject( "<dev string:x152>", zone.trigger, zone.visuals, ( 0, 0, 100 ) );
                domflag gameobjects::allowuse( "<dev string:x1be>" );
                domflag gameobjects::setusetime( 60 );
                
                if ( isdefined( trigger.objectivekey ) )
                {
                    domflag.objectivekey = trigger.objectivekey;
                }
                else
                {
                    domflag.objectivekey = domflag gameobjects::getlabel();
                }
                
                if ( isdefined( trigger.iconname ) )
                {
                    domflag.iconname = trigger.iconname;
                }
                else
                {
                    domflag.iconname = domflag gameobjects::getlabel();
                }
                
                domflag gameobjects::setobjectivestatusicons( level.icondefend, level.iconneutral );
                domflag gameobjects::setvisibleteam( "<dev string:x1c4>" );
                domflag.onuse = &control_onuse;
                domflag.onbeginuse = &control_onbeginuse;
                domflag.onuseupdate = &obj_dom::dompoint_onuseupdate;
                domflag.onenduse = &control_onenduse;
                domflag.nousebar = 1;
                domflag.id = "<dev string:x1c8>";
                domflag.firstcapture = 0;
                domflag.claimgracetime = 10000;
                domflag.decayrate = 50;
                tracestart = zone.visuals[ 0 ].origin + ( 0, 0, 32 );
                traceend = zone.visuals[ 0 ].origin + ( 0, 0, -32 );
                contentoverride = trace::create_contents( 1, 1, 1, 1, 0, 1, 1 );
                ignoreents = [];
                trace = trace::ray_trace( tracestart, traceend, ignoreents, contentoverride );
                domflag.baseeffectpos = trace[ "<dev string:x1a1>" ];
                upangles = vectortoangles( trace[ "<dev string:x1aa>" ] );
                domflag.baseeffectforward = anglestoforward( upangles );
                domflag obj_dom::initializematchrecording();
                domflag thread obj_dom::domflag_setneutral();
                level.objectives[ domflag.objectivekey ] = domflag;
                setdynamicdvar( @"hash_29d45d6822a1cf6d", "<dev string:x18c>" );
            }
            
            wait 1;
        }
    }

#/

// Namespace control
// Params 0, eflags: 0x4
// Checksum 0x30e01fb4, Offset: 0x6e51
// Size: 0x1f1
function private function_950268979eebe9ef()
{
    utility::flag_wait( "scriptables_ready" );
    level.var_a651d0dfc0132aae = getentarray( "control_zone", #targetname );
    
    foreach ( zone in level.var_a651d0dfc0132aae )
    {
        var_24290c36e2cab388 = { #manual_drop:1, #var_7f4958ce4e4277c3:#"hash_bb332da19f9944df", #capture_segment_count:1, #var_333d3689d793bcc7:0, #use_time_seconds:0, #var_c68e9f43ed9cc918:#"hash_a1360b18943e920", #var_d7c90dc73c1dcba8:( 0, 0, 0 ), #objective_icon_offset:( 0, 0, 0 ), #angles:( 0, 0, 0 ), #origin:( 0, 0, 0 ) };
        var_24290c36e2cab388.origin = zone.origin;
        var_24290c36e2cab388.angles = zone.angles;
        var_24290c36e2cab388.use_time_seconds = level.flagcapturetime;
        var_24290c36e2cab388.capture_segment_count = level.capturesegments;
        var_24290c36e2cab388.var_7f4958ce4e4277c3 = #"hash_ce911e3bbe99421f";
        gameobjects_common::initialize_game_object( zone.targetname, var_24290c36e2cab388, zone, &function_b9c14b5797567dc7 );
    }
    
    setomnvar( "ui_num_dom_flags", level.var_a651d0dfc0132aae.size );
    utility::flag_set( "game_objects_ready" );
}

// Namespace control
// Params 1, eflags: 0x4
// Checksum 0xcd6ccf80, Offset: 0x704a
// Size: 0x3dd
function private function_b9c14b5797567dc7( gameobject )
{
    assert( isdefined( gameobject ) );
    gameobject.objectivekey = gameobjects_shared::get_objective_key( gameobject );
    gameobject.trigger = gameobjects_shared::get_trigger( gameobject );
    gameobject.objectiveid = objidpoolmanager::requestobjectiveid();
    gameobject.segmentupdate = 0;
    objidpoolmanager::objective_playermask_showtoall( gameobject.objectiveid );
    objidpoolmanager::update_objective_ownerteam( gameobject.objectiveid, gameobjects_shared::function_623b07f4735aecb2( gameobject ) );
    objidpoolmanager::update_objective_position( gameobject.objectiveid, gameobjects_shared::get_origin( gameobject ) );
    objidpoolmanager::update_objective_state( gameobject.objectiveid, "active" );
    namespace_1cdb218d68ef13f6::set_objective_icon_state( gameobject.objectiveid, hashcat( #"flag_idle", gameobject.objective_key ) );
    gameobject thread function_f761898ef7e3450e( gameobject );
    assert( gameobject.objectivekey == "<dev string:x1d0>" || gameobject.objectivekey == "<dev string:x1d3>", "<dev string:x1d6>" );
    game_utility_mp::add_gametype_objective( gameobject );
    
    foreach ( zone in level.var_a651d0dfc0132aae )
    {
        if ( zone.script_label == gameobject.objectivekey )
        {
            gameobject thread setup_control_chevrons( zone.target, zone.script_label );
            gameobject.origin = zone.origin;
        }
    }
    
    gameobject callback::function_dc654a4d4126a928( #"hash_358d33b2497e2ce3", #"hash_6947ec89a1af6d69", &function_e96c5c5f5993d949 );
    gameobject callback::function_dc654a4d4126a928( #"hash_358d33b2497e2ce3", #"hash_6947ec89a1af6d69", &function_bdc4de214eb09521 );
    gameobject callback::function_dc654a4d4126a928( #"hash_3c955b1e6fcd76eb", #"hash_6947ec89a1af6d69", &function_8f8e85238efdbf8c );
    gameobject callback::function_dc654a4d4126a928( #"hash_45277be78cb54c51", #"hash_6947ec89a1af6d69", &function_ae1bffde6e7ed216 );
    gameobject callback::function_dc654a4d4126a928( #"hash_47fedf1df6eafa30", #"hash_6947ec89a1af6d69", &function_2ad60af661721fb8 );
    gameobject callback::function_dc654a4d4126a928( #"hash_a1e02ee2cc2ad28e", #"hash_6947ec89a1af6d69", &function_1508b58907decc66 );
    gameobject callback::function_dc654a4d4126a928( #"hash_3aba7df6443df11d", #"hash_6947ec89a1af6d69", &function_8e6258ae907e8db7 );
    gameobject callback::function_dc654a4d4126a928( #"hash_2e3e0663aecb6f19", #"hash_6947ec89a1af6d69", &function_1e99aed9991263ff );
    gameobject callback::function_dc654a4d4126a928( #"hash_29eede2365f9349a", #"hash_6947ec89a1af6d69", &function_c0ec8706842a83c8 );
    gameobject callback::function_dc654a4d4126a928( #"hash_a836ce9ab43d9e2", #"hash_6947ec89a1af6d69", &function_45a20a3b39444f28 );
    gameobject callback::function_dc654a4d4126a928( #"hash_300ad54dcc9beab1", #"hash_6947ec89a1af6d69", &function_9acdc709565aebf3 );
    gameobject callback::function_dc654a4d4126a928( #"hash_629949853fbabab8", #"hash_6947ec89a1af6d69", &function_472dbd6f1c991276 );
    gameobject callback::function_dc654a4d4126a928( #"hash_e3206e8d5d3df1e3", #"hash_6947ec89a1af6d69", &function_db39f974ab87e671 );
    gameobject callback::function_dc654a4d4126a928( #"hash_a4277d17a7a228c9", #"hash_6947ec89a1af6d69", &function_133817afb6ef5f08 );
    gameobject callback::function_dc654a4d4126a928( #"hash_2daf3ace91057e84", #"hash_6947ec89a1af6d69", &function_305be078ea275cd1 );
    gameobjects_shared::activate( gameobject );
    gameobject update_chevrons();
}

// Namespace control
// Params 1, eflags: 0x4
// Checksum 0x880841c2, Offset: 0x742f
// Size: 0x43
function private function_e96c5c5f5993d949( var_4eabed30987cefe0 )
{
    gameobject = var_4eabed30987cefe0.game_object;
    assert( isdefined( gameobject ) );
    objidpoolmanager::objective_show_progress( gameobject.objectiveid, 1, 0 );
}

// Namespace control
// Params 1, eflags: 0x4
// Checksum 0x9d5da0e5, Offset: 0x747a
// Size: 0x56
function private function_bdc4de214eb09521( var_4eabed30987cefe0 )
{
    gameobject = var_4eabed30987cefe0.game_object;
    assert( isdefined( gameobject ) );
    var_a1d5f513371e4fd2 = gameobjects_shared::function_7ed0697b0eea44f8( gameobject );
    objidpoolmanager::objective_show_progress( gameobject.objectiveid, istrue( var_a1d5f513371e4fd2 ), 0 );
}

// Namespace control
// Params 1, eflags: 0x4
// Checksum 0x119b4f8c, Offset: 0x74d8
// Size: 0xeb
function private function_8f8e85238efdbf8c( var_4eabed30987cefe0 )
{
    gameobject = var_4eabed30987cefe0.game_object;
    player = var_4eabed30987cefe0.player;
    assert( isdefined( gameobject ) && isdefined( player ) );
    player.var_c36e159445e2a48b = 0;
    
    if ( level.pausetimer && gameobject.ownerteam != player.team && !gameobject.var_dfc20331de7b5040 )
    {
        gameobject.var_dfc20331de7b5040 = 1;
        gamelogic_mp::pausetimer();
    }
    
    objidpoolmanager::objective_pin_player( gameobject.objectiveid, player );
    objidpoolmanager::function_b3b969f2930890eb( 2, player );
    namespace_1cdb218d68ef13f6::set_objective_icon_state( gameobject.objectiveid, hashcat( #"hash_539be8fb439cd022", gameobject.objective_key ) );
}

// Namespace control
// Params 1, eflags: 0x4
// Checksum 0xe710fb06, Offset: 0x75cb
// Size: 0x72
function private function_ae1bffde6e7ed216( var_4eabed30987cefe0 )
{
    gameobject = var_4eabed30987cefe0.game_object;
    player = var_4eabed30987cefe0.player;
    assert( isdefined( gameobject ) && isdefined( player ) );
    player.var_c36e159445e2a48b = undefined;
    objidpoolmanager::objective_unpin_player( gameobject.objectiveid, player );
    objidpoolmanager::function_b3b969f2930890eb( 0, player );
}

// Namespace control
// Params 1, eflags: 0x4
// Checksum 0xfd1f475b, Offset: 0x7645
// Size: 0x2eb
function private function_2ad60af661721fb8( var_4eabed30987cefe0 )
{
    gameobject = var_4eabed30987cefe0.game_object;
    claimteam = var_4eabed30987cefe0.claim_team_name;
    instanceid = var_4eabed30987cefe0.instance_id;
    objidpoolmanager::objective_set_progress( gameobject.objectiveid, var_4eabed30987cefe0.progress );
    objidpoolmanager::objective_set_show_progress( gameobject.objectiveid, 1 );
    currenttime = gettime();
    otherteam = team_utility::getotherteam( claimteam );
    
    if ( !level.gameended && !game_utility_mp::isanymlgmatch() )
    {
        if ( !isdefined( gameobject.lastsfxplayedtime ) )
        {
            gameobject.lastsfxplayedtime = currenttime;
        }
        
        if ( gameobject.lastsfxplayedtime + 995 < currenttime )
        {
            gameobject.lastsfxplayedtime = currenttime;
            sfxalias = "shared_obj_capturing_tick_0" + int( floor( var_4eabed30987cefe0.progress * 10 ) );
            gameobjects_shared::get_trigger( gameobject ) gameplay_sound_fx::function_6dac8db778849e61( sfxalias, claimteam );
            trigger = gameobjects_shared::get_trigger( gameobject );
            
            if ( !isent( trigger ) )
            {
                gameplay_sound_fx::function_e319dc8e16c85fcb( sfxalias, teams::getteamdata( claimteam, "players" ) );
            }
            else
            {
                trigger gameplay_sound_fx::function_6dac8db778849e61( sfxalias, claimteam, undefined, trigger );
            }
        }
    }
    
    if ( !gameobject.didstatusnotify && !level.var_4a5de2a2eae8e2b0 )
    {
        if ( gameobjects_shared::get_use_time_seconds( gameobject ) > 0.05 )
        {
            owningteam = gameobjects_shared::function_623b07f4735aecb2( gameobject );
            
            if ( owningteam == "none" )
            {
                dialog::statusdialog( hashcat( #"secured", gameobject.objective_key ), claimteam );
                var_3d64f5747cc7629d = game_utility_mp::get_gametype_objectives( instanceid );
                var_b2b6bae7f24d97f4 = var_3d64f5747cc7629d.size == 3 && !level.ingraceperiod;
                var_f9fa407a53254866 = var_3d64f5747cc7629d.size == 5 && ( gameobject.objective_key == "_b" || gameobject.objective_key == "_c" || gameobject.objective_key == "_d" );
                
                if ( var_b2b6bae7f24d97f4 || var_f9fa407a53254866 )
                {
                    otherteam = team_utility::getotherteam( claimteam );
                    dialog::statusdialog( hashcat( #"lost", gameobject.objective_key ), otherteam );
                }
            }
            else if ( owningteam != claimteam )
            {
                dialog::statusdialog( hashcat( #"secured", gameobject.objective_key ), claimteam );
                dialog::statusdialog( hashcat( #"lost", gameobject.objective_key ), owningteam );
            }
        }
        
        gameobject.didstatusnotify = 1;
    }
}

// Namespace control
// Params 1, eflags: 0x4
// Checksum 0x93ed3bfe, Offset: 0x7938
// Size: 0x41
function private function_ccb9e256b37cc978( var_4eabed30987cefe0 )
{
    gameobject = var_4eabed30987cefe0.game_object;
    gameobject.segmentupdate = level.capturesegments;
    gameobject update_chevrons();
}

// Namespace control
// Params 1, eflags: 0x4
// Checksum 0xafc4555b, Offset: 0x7981
// Size: 0x78
function private function_1508b58907decc66( var_4eabed30987cefe0 )
{
    gameobject = var_4eabed30987cefe0.game_object;
    var_3d152e00ebf9f46d = var_4eabed30987cefe0.var_dbd0d4c325a7ae15;
    var_380e1341c05f576b = var_4eabed30987cefe0.var_2b03add3a518dea6;
    assert( isdefined( gameobject ) && isdefined( var_3d152e00ebf9f46d ) && isdefined( var_380e1341c05f576b ) );
    objidpoolmanager::objective_show_progress( gameobject.objectiveid, 0, 0 );
}

// Namespace control
// Params 1, eflags: 0x4
// Checksum 0x6246eea6, Offset: 0x7a01
// Size: 0x123
function private function_8e6258ae907e8db7( var_4eabed30987cefe0 )
{
    gameobject = var_4eabed30987cefe0.game_object;
    teamname = var_4eabed30987cefe0.team_name;
    assert( isdefined( gameobject ) && isdefined( teamname ) );
    teamhash = teamname == "all" || teamname == "tie" ? #"hash_a1360b18943e920" : game_utility_mp::is_attacker_team( teamname ) ? #"hash_7118f9343873352b" : game_utility_mp::is_defender_team( teamname ) ? #"hash_ce911e3bbe99421f" : teamname == "none" || teamname == "neutral" ? #"hash_bb332da19f9944df" : undefined;
    
    if ( teamhash == #"hash_7118f9343873352b" || teamhash == #"hash_ce911e3bbe99421f" )
    {
        objidpoolmanager::function_84651f3f2873ee19( gameobject.objectiveid, teamname );
    }
    else
    {
        objidpoolmanager::function_84651f3f2873ee19( gameobject.objectiveid, undefined );
    }
    
    function_fe778b0c2ed6058b( gameobject );
    gameobject update_chevrons();
}

// Namespace control
// Params 1, eflags: 0x4
// Checksum 0x71ab174c, Offset: 0x7b2c
// Size: 0x11a
function private function_1e99aed9991263ff( var_4eabed30987cefe0 )
{
    gameobject = var_4eabed30987cefe0.game_object;
    teamname = var_4eabed30987cefe0.team_name;
    assert( isdefined( gameobject ) && isdefined( teamname ) );
    teamhash = teamname == "all" || teamname == "tie" ? #"hash_a1360b18943e920" : game_utility_mp::is_attacker_team( teamname ) ? #"hash_7118f9343873352b" : game_utility_mp::is_defender_team( teamname ) ? #"hash_ce911e3bbe99421f" : teamname == "none" || teamname == "neutral" ? #"hash_bb332da19f9944df" : undefined;
    
    if ( teamhash == #"hash_7118f9343873352b" || teamhash == #"hash_ce911e3bbe99421f" )
    {
        objidpoolmanager::update_objective_ownerteam( gameobject.objectiveid, teamname );
    }
    else
    {
        objidpoolmanager::update_objective_ownerteam( gameobject.objectiveid, undefined );
    }
    
    function_fe778b0c2ed6058b( gameobject );
}

// Namespace control
// Params 1, eflags: 0x4
// Checksum 0x5d1030e3, Offset: 0x7c4e
// Size: 0x11a
function private function_c0ec8706842a83c8( var_4eabed30987cefe0 )
{
    gameobject = var_4eabed30987cefe0.game_object;
    teamname = var_4eabed30987cefe0.team_name;
    assert( isdefined( gameobject ) && isdefined( teamname ) );
    teamhash = teamname == "all" || teamname == "tie" ? #"hash_a1360b18943e920" : game_utility_mp::is_attacker_team( teamname ) ? #"hash_7118f9343873352b" : game_utility_mp::is_defender_team( teamname ) ? #"hash_ce911e3bbe99421f" : teamname == "none" || teamname == "neutral" ? #"hash_bb332da19f9944df" : undefined;
    
    if ( teamhash == #"hash_7118f9343873352b" || teamhash == #"hash_ce911e3bbe99421f" )
    {
        objidpoolmanager::objective_set_progress_team( gameobject.objectiveid, teamname );
    }
    else
    {
        objidpoolmanager::objective_set_progress_team( gameobject.objectiveid, undefined );
    }
    
    function_fe778b0c2ed6058b( gameobject );
}

// Namespace control
// Params 1, eflags: 0x4
// Checksum 0x98181974, Offset: 0x7d70
// Size: 0x3da
function private function_45a20a3b39444f28( var_4eabed30987cefe0 )
{
    gameobject = var_4eabed30987cefe0.game_object;
    team = var_4eabed30987cefe0.team_name;
    var_3d152e00ebf9f46d = var_4eabed30987cefe0.var_dbd0d4c325a7ae15;
    instanceid = var_4eabed30987cefe0.instance_id;
    level.playholdtwovo = 1;
    gameobject.capturetime = gettime();
    otherteam = team_utility::getotherteam( team );
    
    if ( !isdefined( level.var_3be9a1b658ae8cda ) )
    {
        level.var_3be9a1b658ae8cda = 0;
    }
    
    level.var_3be9a1b658ae8cda++;
    var_3d64f5747cc7629d = game_utility_mp::get_gametype_objectives( instanceid );
    
    if ( !isagent( var_3d152e00ebf9f46d ) || bots::function_e8c1a1cd1aaa5f82( var_3d152e00ebf9f46d ) )
    {
        hud_util::teamplayercardsplash( "callout_securedposition" + gameobject.objective_key, var_3d152e00ebf9f46d );
    }
    
    if ( level.var_3be9a1b658ae8cda < var_3d64f5747cc7629d.size )
    {
        dialog::statusdialog( hashcat( #"secured", gameobject.objective_key ), team );
        
        if ( gameobjects_shared::function_55c8ebe2dd649ae5( gameobject ) == "none" )
        {
            if ( var_3d64f5747cc7629d.size == 5 && ( gameobject.objective_key == "_c" || gameobject.objective_key == "_d" ) || gameobject.objective_key == "_b" )
            {
                dialog::statusdialog( hashcat( #"lost", gameobject.objective_key ), otherteam );
            }
        }
        else
        {
            dialog::statusdialog( hashcat( #"lost", gameobject.objective_key ), otherteam );
        }
    }
    else
    {
        level callback::callback( #"music_event", { #team:team, #event_type:#"dominating" } );
        dialog::statusdialog( #"gamestate_domwinning", team );
        
        if ( function_ac0c369c81a33806( team ) )
        {
            dialog::statusdialog( #"hash_155f070f08f4a32", otherteam );
        }
        else
        {
            dialog::statusdialog( #"gamestate_domlosing", otherteam );
        }
    }
    
    level notify( #"dom_flag_captured", gameobject.objective_key );
    gameobject notify( #"dom_flag_captured" );
    var_3d152e00ebf9f46d notify( #"player_zone_captured", gameobject.objective_key );
    objidpoolmanager::function_a55b645deb36be18( gameobject.objectiveid );
    allflagscaptured = level.var_3be9a1b658ae8cda == var_3d64f5747cc7629d.size;
    soundref = allflagscaptured ? #"control_flag_captured_all" : #"control_flag_captured";
    soundref_otherteam = allflagscaptured ? #"control_flag_lost_all" : #"control_flag_lost";
    gameplay_sound_fx::function_e319dc8e16c85fcb( soundref, teams::getteamdata( team, "players" ) );
    gameplay_sound_fx::function_e319dc8e16c85fcb( soundref_otherteam, teams::getteamdata( otherteam, "players" ) );
    
    if ( allflagscaptured )
    {
        level thread gamelogic_mp::endgame( game[ "attackers" ], game[ "end_reason" ][ "control_allzones_win" ], game[ "end_reason" ][ "control_allzones_loss" ] );
        codcasterclientmatchdata::function_d6aea11d2e9ba521();
    }
    else
    {
        otherflag = arrayremove( var_3d64f5747cc7629d, gameobject )[ 0 ];
        
        if ( !otherflag.var_dfc20331de7b5040 )
        {
            gamelogic_mp::resumetimer();
        }
        
        if ( level.segmentcaptureextratime > 0 )
        {
            thread function_7be446c06a37ae01( level.segmentcaptureextratime, istrue( otherflag.var_dfc20331de7b5040 ) );
        }
        else
        {
            thread function_7be446c06a37ae01( level.captureextratime, istrue( otherflag.var_dfc20331de7b5040 ) );
        }
    }
    
    setomnvar( "ui_objective_destroyed" + gameobject.objective_key, 1 );
    gameobjects_shared::deactivate( gameobject );
}

// Namespace control
// Params 1, eflags: 0x4
// Checksum 0x6bb292f9, Offset: 0x8152
// Size: 0x63
function private function_9acdc709565aebf3( var_4eabed30987cefe0 )
{
    gameobject = var_4eabed30987cefe0.game_object;
    assert( isdefined( gameobject ) );
    objidpoolmanager::update_objective_sethot( gameobject.objectiveid, 1 );
    
    if ( level.pausetimer )
    {
        gameobject.var_dfc20331de7b5040 = 1;
        gamelogic_mp::pausetimer();
    }
}

// Namespace control
// Params 1, eflags: 0x4
// Checksum 0x61f96c92, Offset: 0x81bd
// Size: 0xcb
function private function_472dbd6f1c991276( var_4eabed30987cefe0 )
{
    gameobject = var_4eabed30987cefe0.game_object;
    assert( isdefined( gameobject ) );
    objidpoolmanager::update_objective_sethot( gameobject.objectiveid, 0 );
    
    if ( gameobjects_shared::function_7ed0697b0eea44f8( gameobject ) )
    {
        objidpoolmanager::objective_show_progress( gameobject.objectiveid, 1, 0 );
    }
    
    owningteam = gameobjects_shared::function_623b07f4735aecb2( gameobject );
    lastclaimteam = gameobjects_shared::function_b94c7e25e2a759f7( gameobject );
    
    if ( gameobject.ownerteam == lastclaimteam )
    {
        if ( !function_d54721b242020b13( gameobject ) )
        {
            gamelogic_mp::resumetimer();
        }
    }
    
    if ( lastclaimteam == "none" || owningteam == "none" )
    {
        gameobject.didstatusnotify = undefined;
    }
}

// Namespace control
// Params 1, eflags: 0x4
// Checksum 0x11cf0129, Offset: 0x8290
// Size: 0xbd
function private function_db39f974ab87e671( var_4eabed30987cefe0 )
{
    gameobject = var_4eabed30987cefe0.game_object;
    assert( isdefined( gameobject ) );
    namespace_1cdb218d68ef13f6::set_objective_icon_state( gameobject.objectiveid, hashcat( #"flag_idle", gameobject.objective_key ) );
    
    if ( function_d54721b242020b13( gameobject ) && !level.var_17ebe57584c369c9 )
    {
        gamelogic_mp::resumetimer();
        gameobject.var_dfc20331de7b5040 = 0;
    }
    
    if ( flags::gameflag( "prematch_done" ) )
    {
        playsoundatpos( gameobject.trigger.origin, "uin_cer_common_ingame_zone_neutral_ping_3d" );
    }
    
    gameobject.didstatusnotify = undefined;
}

// Namespace control
// Params 1, eflags: 0x4
// Checksum 0x6742e14e, Offset: 0x8355
// Size: 0x1cc
function private function_133817afb6ef5f08( var_4eabed30987cefe0 )
{
    gameobject = var_4eabed30987cefe0.game_object;
    var_afaf5a82e343815a = var_4eabed30987cefe0.var_3fb67f294d22fb9a;
    assert( isdefined( gameobject ) && isdefined( var_afaf5a82e343815a ) );
    
    foreach ( player in var_afaf5a82e343815a )
    {
        if ( gameobjects::function_e17a356e69f57699( player ) )
        {
            player.owner thread points::doscoreevent( #"obj_prog_defend_capture_bot" );
            continue;
        }
        
        if ( isdefined( player ) )
        {
            player events::function_a7d373228760063b();
            objectivekey = gameobjects_shared::get_objective_key( gameobject );
            
            if ( isdefined( self.entnum ) && player.defenderskilled[ objectivekey ] >= 2 )
            {
                player thread points::doscoreevent( #"hash_d0f5c98414382d61" );
                player.defenderskilled[ objectivekey ] = 0;
            }
        }
    }
    
    foreach ( player in var_afaf5a82e343815a )
    {
        player stats::setextrascore2( player.pers[ "extrascore2" ] + 1 );
    }
    
    gameplay_sound_fx::function_e319dc8e16c85fcb( #"hash_5125eb00c212d734", var_afaf5a82e343815a );
}

// Namespace control
// Params 1, eflags: 0x4
// Checksum 0x549ce88c, Offset: 0x8529
// Size: 0x144
function private function_305be078ea275cd1( var_4eabed30987cefe0 )
{
    gameobject = var_4eabed30987cefe0.game_object;
    var_3d152e00ebf9f46d = var_4eabed30987cefe0.var_dbd0d4c325a7ae15;
    var_2b03add3a518dea6 = var_4eabed30987cefe0.var_2b03add3a518dea6;
    assert( isdefined( gameobject ) && isdefined( var_3d152e00ebf9f46d ) );
    otherteam = team_utility::getotherteam( var_4eabed30987cefe0.team_name );
    var_e167f15b13adfcee = [ var_3d152e00ebf9f46d ];
    gameplay_sound_fx::function_e319dc8e16c85fcb( #"control_win_section", var_e167f15b13adfcee );
    gameplay_sound_fx::function_e319dc8e16c85fcb( #"control_win_section", var_2b03add3a518dea6 );
    gameplay_sound_fx::function_e319dc8e16c85fcb( #"control_lose_section", teams::getteamdata( otherteam, "players" ) );
    function_abfb45ee739c5197( var_3d152e00ebf9f46d );
    
    foreach ( player in var_2b03add3a518dea6 )
    {
        function_abfb45ee739c5197( player );
    }
}

// Namespace control
// Params 1, eflags: 0x4
// Checksum 0x15c7caef, Offset: 0x8675
// Size: 0x17e
function private function_fe778b0c2ed6058b( gameobject )
{
    assert( isdefined( gameobject ) );
    var_4a7cd465ff58f423 = namespace_277c922f0d0dc523::get_claim_team_hash( gameobject );
    var_543da7845de195ab = namespace_277c922f0d0dc523::function_9b71aa2788e21706( gameobject );
    var_92274902a4720e10 = namespace_277c922f0d0dc523::function_a33241bbed7a745d( gameobject );
    
    if ( var_543da7845de195ab == #"hash_a1360b18943e920" )
    {
        statehash = hashcat( #"flag_contested", gameobjects_shared::get_objective_key( gameobject ) );
        namespace_1cdb218d68ef13f6::set_objective_icon_state( gameobject.objectiveid, statehash );
        return;
    }
    
    if ( var_543da7845de195ab == #"hash_bb332da19f9944df" || var_4a7cd465ff58f423 == #"hash_bb332da19f9944df" )
    {
        statehash = hashcat( #"flag_idle", gameobjects_shared::get_objective_key( gameobject ) );
        namespace_1cdb218d68ef13f6::set_objective_icon_state( gameobject.objectiveid, statehash );
        return;
    }
    
    if ( var_543da7845de195ab != var_4a7cd465ff58f423 )
    {
        statehash = hashcat( #"hash_539be8fb439cd022", gameobjects_shared::get_objective_key( gameobject ) );
        namespace_1cdb218d68ef13f6::set_objective_icon_state( gameobject.objectiveid, statehash );
        return;
    }
    
    if ( var_92274902a4720e10 == #"hash_bb332da19f9944df" )
    {
        statehash = hashcat( #"flag_defending", gameobjects_shared::get_objective_key( gameobject ) );
        namespace_1cdb218d68ef13f6::set_objective_icon_state( gameobject.objectiveid, statehash );
        return;
    }
    
    statehash = hashcat( #"flag_clearing", gameobjects_shared::get_objective_key( gameobject ) );
    namespace_1cdb218d68ef13f6::set_objective_icon_state( gameobject.objectiveid, statehash );
}

// Namespace control
// Params 1, eflags: 0x4
// Checksum 0xbd63986d, Offset: 0x87fb
// Size: 0x8a
function private function_abfb45ee739c5197( var_3d152e00ebf9f46d )
{
    var_3d152e00ebf9f46d thread rank::scoreeventpopup( #"segment_captured" );
    var_3d152e00ebf9f46d notify( #"segment_captured" );
    self.segmentupdate += 1;
    
    if ( gameobjects::function_e17a356e69f57699( var_3d152e00ebf9f46d ) )
    {
        var_3d152e00ebf9f46d.owner setclientomnvar( "ui_segment_captured", self.segmentupdate );
    }
    else
    {
        var_3d152e00ebf9f46d setclientomnvar( "ui_segment_captured", self.segmentupdate );
    }
    
    function_2ad7125bd77df7b0( var_3d152e00ebf9f46d );
}

// Namespace control
// Params 1
// Checksum 0xd9ce0e52, Offset: 0x888d
// Size: 0xd4, Type: bool
function function_ac0c369c81a33806( ownerteam )
{
    instanceid = gameinstance::get_instance_id( ownerteam );
    
    foreach ( flag in game_utility_mp::get_gametype_objectives( instanceid ) )
    {
        var_f58beca35e97756d = gameobjects_shared::function_623b07f4735aecb2( flag );
        var_18faa633a2aa073d = gameobjects_shared::function_55c8ebe2dd649ae5( flag );
        
        if ( var_f58beca35e97756d != ownerteam || var_18faa633a2aa073d != "neutral" && var_18faa633a2aa073d != "none" )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace control
// Params 1, eflags: 0xc
// Checksum 0xc7d59706, Offset: 0x896a
// Size: 0x67
function private function_f761898ef7e3450e( gameobject )
{
    self notify( #"hash_fad0cfb6fc46f5fb" );
    self endon( #"hash_fad0cfb6fc46f5fb" );
    level endon( #"game_ended" );
    flags::function_2f3408423ccc9b2e( "prematch_done" );
    objidpoolmanager::objective_set_play_intro( gameobject.objectiveid, 1 );
    objidpoolmanager::update_objective_state( gameobject.objectiveid, "current" );
}

