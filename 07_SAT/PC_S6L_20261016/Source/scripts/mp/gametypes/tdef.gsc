// scripts\mp\gametypes\tdef.gsc  (hash_32d76cdc43b36b71.gscc) (size: 27462 Bytes / 0x6b46 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x12dcac71 (316451953)
// size ...... 27462 (0x6b46)
// includes .. 30  (offset: 0x6116)
// strings ... 121 (offset: 0x6206)
// dev strs .. 1   (offset: 0x6b22)
// exports ... 51  (offset: 0x427e)
// cseg ...... 0x938 + 0x3946 (0x427e)
// imports ... 180 (offset: 0x4a76)
// animtree1 . 0   (offset: 0x6b46)
// animtree2 . 0   (offset: 0x6b46)
#using scripts\common\callbacks;
#using scripts\common\telemetry_utils;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\mp\codcaster_utils;
#using scripts\mp\common\utility\dialog;
#using scripts\mp\common\utility\dvars;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\print;
#using scripts\mp\common\utility\sound;
#using scripts\mp\common\utility\stats;
#using scripts\mp\common\utility\team_utility;
#using scripts\mp\events;
#using scripts\mp\flags;
#using scripts\mp\gamelogic;
#using scripts\mp\gameobjects;
#using scripts\mp\gamescore;
#using scripts\mp\gametypes\common;
#using scripts\mp\globallogic;
#using scripts\mp\hostmigration;
#using scripts\mp\hud_message;
#using scripts\mp\hud_util;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\persistence;
#using scripts\mp\rank;
#using scripts\mp\spawnlogic;

#namespace tdef;

// Namespace tdef
// Params 0
// Checksum 0x9a99cc24, Offset: 0x956
// Size: 0x349
function main()
{
    if ( getdvar( @"g_mapname" ) == "mp_background" )
    {
        return;
    }
    
    globallogic::init();
    globallogic::setupcallbacks();
    level.defenderflag_starts = [];
    cyberemptriggers = getentarray( "cyber_emp_pickup_trig", #targetname );
    
    foreach ( trig in cyberemptriggers )
    {
        level.defenderflag_starts[ level.defenderflag_starts.size ] = trig.origin;
    }
    
    level.defenderflag_bflagstart = ( 0, 0, 0 );
    primaryflags = getentarray( "flag_primary", #targetname );
    
    foreach ( flag in primaryflags )
    {
        if ( flag.script_label == "_b" )
        {
            level.defenderflag_bflagstart = flag.origin;
            break;
        }
    }
    
    allowed[ 0 ] = game_utility::getgametype();
    allowed[ 1 ] = "tdm";
    gameobjects::main( allowed );
    level.initializematchrules = &initializematchrules;
    [[ level.initializematchrules ]]();
    level thread game_utility_mp::reinitializematchrulesonmigration();
    level.carrierarmor = 100;
    updategametypedvars();
    callback::add( #"hash_244314ef9125e636", &function_8314535b81f548e );
    level.teambased = 1;
    level.onstartgametype = &onstartgametype;
    level.onplayerconnect = &onplayerconnect;
    level.getspawnpoint = &getspawnpoint;
    level.onrespawndelay = &getrespawndelay;
    level.checkcustomclosetoscorelimit = &checkcustomclosetoscorelimit;
    level.defenderflagreset = 1;
    level.defenderflagbases = [];
    level.scorefrozenuntil = 0;
    level.defenderflagpickupscorefrozen = 0;
    
    if ( game_utility::function_d3f8957534dc62af() )
    {
        game[ "dialog" ][ "gametype" ] = "iw9_tdef_mode_uktl_tdt1";
    }
    else
    {
        game[ "dialog" ][ "gametype" ] = "gametype_defender";
    }
    
    game[ "strings" ][ "overtime_hint" ] = &"mp/first_blood";
    game[ "dialog" ][ "flag_dropped" ] = "ourblitzflag_drop";
    game[ "dialog" ][ "flag_returned" ] = "ourflag_return";
    game[ "dialog" ][ "flag_getback" ] = "ourblitzflag_getback";
    game[ "dialog" ][ "enemy_flag_taken" ] = "ourblitzflag_taken";
    game[ "dialog" ][ "enemy_flag_dropped" ] = "enemyblitzflag_drop";
    game[ "dialog" ][ "enemy_flag_returned" ] = "ourblitzflag_return";
    setomnvar( "ui_single_flag_loc", -2 );
}

// Namespace tdef
// Params 0
// Checksum 0x3e87bfc4, Offset: 0xca7
// Size: 0x184
function initializematchrules()
{
    game_utility_mp::setcommonrulesfrommatchrulesdata();
    setdynamicdvar( @"hash_1cc0d66c46db96d6", getmatchrulesdata( "tdefData", "ppkTeamNoFlag" ) );
    setdynamicdvar( @"hash_1aa7e0f1a1007031", getmatchrulesdata( "tdefData", "ppkTeamWithFlag" ) );
    setdynamicdvar( @"hash_c896b59425076b7c", getmatchrulesdata( "tdefData", "ppkFlagCarrier" ) );
    setdynamicdvar( @"hash_b5878f8ab2eaa223", getmatchrulesdata( "tdefData", "scoringTime" ) );
    setdynamicdvar( @"hash_db9cb11c88c0328d", getmatchrulesdata( "tdefData", "scorePerTick" ) );
    setdynamicdvar( @"hash_b61c1981eeaad777", getmatchrulesdata( "tdefData", "carrierBonusTime" ) );
    setdynamicdvar( @"hash_48eda09982a74dac", getmatchrulesdata( "tdefData", "carrierBonusScore" ) );
    setdynamicdvar( @"hash_c429e9dec8a0dc33", getmatchrulesdata( "tdefData", "spawnDelay" ) );
    setdynamicdvar( @"hash_53c09e0944fb50da", getmatchrulesdata( "tdefData", "flagActivationDelay" ) );
    setdynamicdvar( @"hash_8e6448164d6909cb", getmatchrulesdata( "carryData", "possessionResetCondition" ) );
    setdynamicdvar( @"hash_92904d1a8261b677", getmatchrulesdata( "carryData", "possessionResetTime" ) );
    setdynamicdvar( @"scr_tdef_showenemycarrier", getmatchrulesdata( "carryData", "showEnemyCarrier" ) );
    setdynamicdvar( @"scr_tdef_idleresettime", getmatchrulesdata( "carryData", "idleResetTime" ) );
    setdynamicdvar( @"scr_tdef_promode", 0 );
}

// Namespace tdef
// Params 0
// Checksum 0x2981d924, Offset: 0xe33
// Size: 0x134
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
        game_utility_mp::setobjectivetext( entry, &"objectives/tdef" );
        
        if ( level.splitscreen )
        {
            game_utility_mp::setobjectivescoretext( entry, &"objectives/tdef" );
        }
        else
        {
            game_utility_mp::setobjectivescoretext( entry, &"objectives/tdef_score" );
        }
        
        game_utility_mp::setobjectivehinttext( entry, &"objectives/tdef_attacker_hint" );
    }
    
    initspawns();
    tdef();
}

// Namespace tdef
// Params 0
// Checksum 0xc80089f8, Offset: 0xf6f
// Size: 0x14e
function updategametypedvars()
{
    common::updatecommongametypedvars();
    level.ppkteamnoflag = dvars::dvarintvalue( "ppkTeamNoFlag", 50, 0, 250 );
    level.ppkteamwithflag = dvars::dvarintvalue( "ppkTeamWithFlag", 100, 0, 250 );
    level.ppkflagcarrier = dvars::dvarintvalue( "ppkFlagCarrier", 250, 0, 250 );
    level.scoringtime = dvars::dvarfloatvalue( "scoringTime", 1, 1, 10 );
    level.scorepertick = dvars::dvarintvalue( "scorePerTick", 1, 1, 25 );
    level.carrierbonustime = dvars::dvarfloatvalue( "carrierBonusTime", 4, 0, 10 );
    level.carrierbonusscore = dvars::dvarintvalue( "carrierBonusScore", 25, 0, 250 );
    level.spawndelay = dvars::dvarfloatvalue( "spawnDelay", 60, 0, 60 );
    level.flagactivationdelay = dvars::dvarfloatvalue( "flagActivationDelay", 10, 0, 30 );
    level.possessionresetcondition = dvars::dvarintvalue( "possessionResetCondition", 0, 0, 2 );
    level.possessionresettime = dvars::dvarfloatvalue( "possessionResetTime", 0, 0, 150 );
    level.idleresettime = dvars::dvarfloatvalue( "idleResetTime", 15, 0, 60 );
    level.showenemycarrier = dvars::dvarintvalue( "showEnemyCarrier", 5, 0, 6 );
}

// Namespace tdef
// Params 0
// Checksum 0x602a2548, Offset: 0x10c5
// Size: 0x14b
function initspawns()
{
    spawnlogic::function_6dbabb72223a4bca();
    spawnlogic::setactivespawnlogic( #"default" );
    spawnlogic::addstartspawnpoints( "mp_tdm_spawn_allies_start" );
    spawnlogic::addstartspawnpoints( "mp_tdm_spawn_axis_start" );
    spawnlogic::addspawnpointslegacy( "allies", "mp_tdm_spawn" );
    spawnlogic::addspawnpointslegacy( "allies", "mp_tdm_spawn_secondary", 1, 1 );
    spawnlogic::addspawnpointslegacy( "axis", "mp_tdm_spawn" );
    spawnlogic::addspawnpointslegacy( "axis", "mp_tdm_spawn_secondary", 1, 1 );
    spawns = spawnlogic::getspawnpointarray( "mp_tdm_spawn" );
    spawnssecondary = spawnlogic::getspawnpointarray( "mp_tdm_spawn_secondary" );
    spawnlogic::registerspawnset( #"primary", spawns );
    spawnlogic::registerspawnset( #"fallback", spawnssecondary );
    spawnlogic::finalizemap();
    
    foreach ( spawnpoint in level.spawnpoints )
    {
        calculatespawndisttodefenderflagstart( spawnpoint );
    }
}

// Namespace tdef
// Params 1
// Checksum 0xc7e918e8, Offset: 0x1218
// Size: 0x8b
function calculatespawndisttodefenderflagstart( spawnpoint )
{
    spawnpoint.scriptdata.distsqtodefenderflagstart = undefined;
    dist = distance( spawnpoint.origin, level.defenderflag_starts[ 0 ] );
    
    if ( dist < 0 )
    {
        dist = distance2dsquared( spawnpoint.origin, level.defenderflag_starts[ 0 ] );
    }
    else
    {
        dist *= dist;
    }
    
    spawnpoint.scriptdata.distsqtodefenderflagstart = dist;
}

// Namespace tdef
// Params 0
// Checksum 0x52d399ee, Offset: 0x12ab
// Size: 0x11c
function getspawnpoint()
{
    spawnteam = self.pers[ "team" ];
    
    if ( game[ "switchedsides" ] )
    {
        spawnteam = team_utility::getotherteam( spawnteam );
    }
    
    if ( spawnlogic::shoulduseteamstartspawn() )
    {
        spawnpoints = spawnlogic::getspawnpointarray( "mp_tdm_spawn_" + spawnteam + "_start" );
        spawnpoint = spawnlogic::getspawnpoint_startspawn( spawnpoints );
    }
    else
    {
        var_5604c97df7f05c1b = [];
        var_5604c97df7f05c1b[ "defenderFlagPosition" ] = level.defenderflag.visuals[ 0 ].origin;
        
        if ( isdefined( level.defenderflag.carrier ) )
        {
            var_5604c97df7f05c1b[ "activeCarrierPosition" ] = level.defenderflag.carrier.origin;
        }
        else
        {
            var_5604c97df7f05c1b[ "activeCarrierPosition" ] = var_5604c97df7f05c1b[ "defenderFlagPosition" ];
        }
        
        var_5604c97df7f05c1b[ "avoidDefenderFlagDeadZoneDistSq" ] = 1000000;
        spawnpoint = spawnlogic::getspawnpointlegacy( self, spawnteam, #"primary", #"fallback", undefined, var_5604c97df7f05c1b );
    }
    
    return spawnpoint;
}

// Namespace tdef
// Params 0
// Checksum 0x2d06ce9, Offset: 0x13d0
// Size: 0xfe
function tdef()
{
    level.flagmodel[ "allies" ] = "ctf_game_flag_west";
    level.flagbase[ "allies" ] = "ctf_game_flag_base";
    level.carryflag[ "allies" ] = "prop_ctf_game_flag_west";
    level.flagmodel[ "axis" ] = "ctf_game_flag_east";
    level.flagbase[ "axis" ] = "ctf_game_flag_base";
    level.carryflag[ "axis" ] = "prop_ctf_game_flag_east";
    setupwaypointicons();
    level.iconescort = "waypoint_escort_flag";
    level.iconkill = "waypoint_ctf_kill";
    level.iconcaptureflag = "waypoint_take_flag";
    level.icondefendflag = "waypoint_defend_flag";
    level.iconreturnflag = "waypoint_recover_flag";
    level.mlgiconemptyflag = "waypoint_mlg_empty_flag";
    level.mlgiconfullflag = "waypoint_mlg_full_flag";
    level.icontarget = "waypoint_target";
    createflagstart();
}

// Namespace tdef
// Params 0
// Checksum 0xca6ba957, Offset: 0x14d6
// Size: 0xec
function setupwaypointicons()
{
    gamelogic_mp::setwaypointiconinfo( "waypoint_ctf_kill", 2, "enemy", "MP_INGAME_ONLY/OBJ_KILL_CAPS", "icon_waypoint_kill", 0 );
    gamelogic_mp::setwaypointiconinfo( "waypoint_recover_flag", 0, "neutral", "MP_INGAME_ONLY/OBJ_RECOVER_CAPS", "icon_waypoint_flag", 0 );
    gamelogic_mp::setwaypointiconinfo( "waypoint_escort_flag", 2, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_flag", 0 );
    gamelogic_mp::setwaypointiconinfo( "waypoint_take_flag", 0, "neutral", "MP_INGAME_ONLY/OBJ_TAKE_CAPS", "icon_waypoint_flag", 0 );
    gamelogic_mp::setwaypointiconinfo( "waypoint_defend_flag", 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_flag", 0 );
    gamelogic_mp::setwaypointiconinfo( "waypoint_target", 0, "neutral", "MP_INGAME_ONLY/OBJ_TARGET_CAPS", "icon_waypoint_locked", 0 );
    gamelogic_mp::setwaypointiconinfo( "waypoint_mlg_empty_flag", 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "codcaster_icon_waypoint_ctf_empty", 0 );
    gamelogic_mp::setwaypointiconinfo( "waypoint_mlg_full_flag", 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "codcaster_icon_waypoint_ctf_full", 0 );
}

// Namespace tdef
// Params 0
// Checksum 0x31b19e7a, Offset: 0x15ca
// Size: 0xab
function createflagstart()
{
    level.defenderflag_starts = arrayrandomize( level.defenderflag_starts );
    tracestart = level.defenderflag_starts[ 0 ] + ( 0, 0, 64 );
    traceend = level.defenderflag_starts[ 0 ] + ( 0, 0, -64 );
    trace = trace::ray_trace( tracestart, traceend, undefined, trace::create_default_contents( 1 ) );
    level.defenderflag_starts[ 0 ] = trace[ "position" ];
    level.defenderflag = createteamdefenderflag( "allies" );
    level thread flaglockedtimer();
}

// Namespace tdef
// Params 0
// Checksum 0xab865c4, Offset: 0x167d
// Size: 0x173
function flaglockedtimer()
{
    if ( !flags::gameflag( "prematch_done" ) )
    {
        level.defenderflagbase.objectiveicon gameobjects::setvisibleteam( "none" );
        level utility::waittill_any( "prematch_done", "start_mode_setup" );
        level.defenderflagbase.objectiveicon gameobjects::setvisibleteam( "any" );
    }
    
    if ( level.flagactivationdelay )
    {
        flags::gameflagwait( "prematch_done" );
        level.defenderflagbase.objectiveicon thread gameobjects::function_d7321ef757ecefd7( level.flagactivationdelay );
        wait level.flagactivationdelay;
        level.defenderflagbase.objectiveicon gameobjects::setobjectivestatusallicons( level.iconcaptureflag, level.iconcaptureflag, level.mlgiconfullflag );
        level.defenderflag.trigger utility::trigger_on();
        
        foreach ( team in level.teamnamelist )
        {
            dialog::leaderdialog( "obj_generic_capture", team );
        }
    }
}

// Namespace tdef
// Params 1
// Checksum 0x88469106, Offset: 0x17f8
// Size: 0x44c
function createteamdefenderflag( team )
{
    level.pickuptime = 0;
    level.returntime = 0;
    radius = 32;
    trigger = spawn( "trigger_radius", level.defenderflag_starts[ 0 ], 0, radius, 128 );
    visuals = [];
    visuals[ 0 ] = spawn( "script_model", level.defenderflag_starts[ 0 ] );
    visuals[ 0 ] setmodel( level.flagmodel[ team ] );
    visuals[ 0 ] setasgametypeobjective();
    visuals[ 0 ] setteaminhuddatafromteamname( team );
    carryteam = "neutral";
    teamflag = gameobjects::createcarryobject( carryteam, trigger, visuals, ( 0, 0, 85 ) );
    teamflag gameobjects::allowcarry( "any" );
    teamflag gameobjects::setteamusetime( "friendly", level.pickuptime );
    teamflag gameobjects::setteamusetime( "enemy", level.returntime );
    teamflag gameobjects::setvisibleteam( "none" );
    teamflag gameobjects::setobjectivestatusallicons( level.iconescort, level.iconkill, level.mlgiconfullflag );
    teamflag objidpoolmanager::objective_set_play_intro( teamflag.objidnum, 0 );
    teamflag objidpoolmanager::objective_set_play_outro( teamflag.objidnum, 0 );
    teamflag gameobjects::registercarryobjectpickupcheck( &flagpickupchecks );
    teamflag.allowweapons = 1;
    teamflag.onpickup = &onpickup;
    teamflag.onpickupfailed = &onpickup;
    teamflag.ondrop = &ondrop;
    teamflag.onreset = &onreset;
    
    if ( isdefined( level.showenemycarrier ) )
    {
        switch ( level.showenemycarrier )
        {
            case 0:
                teamflag.objidpingfriendly = 1;
                teamflag.objidpingenemy = 0;
                teamflag.objpingdelay = 60;
                break;
            case 1:
                teamflag.objidpingfriendly = 0;
                teamflag.objidpingenemy = 0;
                teamflag.objpingdelay = 0.05;
                break;
            case 2:
                teamflag.objidpingfriendly = 1;
                teamflag.objidpingenemy = 0;
                teamflag.objpingdelay = 1;
                break;
            case 3:
                teamflag.objidpingfriendly = 1;
                teamflag.objidpingenemy = 0;
                teamflag.objpingdelay = 1.5;
                break;
            case 4:
                teamflag.objidpingfriendly = 1;
                teamflag.objidpingenemy = 0;
                teamflag.objpingdelay = 2;
                break;
            case 5:
                teamflag.objidpingfriendly = 1;
                teamflag.objidpingenemy = 0;
                teamflag.objpingdelay = 3;
                break;
            case 6:
                teamflag.objidpingfriendly = 1;
                teamflag.objidpingenemy = 0;
                teamflag.objpingdelay = 4;
                break;
        }
        
        pingobjid = objidpoolmanager::requestobjectiveid( 99 );
        teamflag.pingobjidnum = pingobjid;
        objidpoolmanager::objective_add_objective( pingobjid, "done", teamflag.origin );
        objidpoolmanager::objective_set_play_intro( pingobjid, 0 );
        objidpoolmanager::objective_set_play_outro( pingobjid, 0 );
        teamflag gameobjects::setvisibleteam( "none", pingobjid );
        objective_setownerteam( pingobjid, team );
        teamflag gameobjects::setobjectivestatusallicons( level.iconescort, level.iconkill, level.mlgiconfullflag, pingobjid );
    }
    else
    {
        teamflag.objidpingfriendly = 1;
        teamflag.objidpingenemy = 0;
        teamflag.objpingdelay = 3;
    }
    
    level.defenderflagbase = createteamdefenderflagbase( team, teamflag );
    return teamflag;
}

// Namespace tdef
// Params 1
// Checksum 0x5b3af1a3, Offset: 0x1c4d
// Size: 0x15, Type: bool
function flagpickupchecks( player )
{
    return !player vehicle::is_in_vehicle();
}

// Namespace tdef
// Params 2
// Checksum 0x95e6d712, Offset: 0x1c6b
// Size: 0x143
function createteamdefenderflagbase( team, teamflag )
{
    flagbaseorigin = teamflag.visuals[ 0 ].origin;
    teamflagbase = spawn( "script_model", flagbaseorigin );
    teamflagbase setmodel( level.flagbase[ team ] );
    teamflagbase.ownerteam = "neutral";
    teamflagbase setasgametypeobjective();
    teamflagbase setteaminhuddatafromteamname( team );
    teamflagbase.objectiveicon = gameobjects::createobjidobject( flagbaseorigin, "neutral", ( 0, 0, 85 ), undefined, "any", 0 );
    teamflagbase.objectiveicon gameobjects::setvisibleteam( "any" );
    
    if ( level.flagactivationdelay )
    {
        teamflag.trigger utility::trigger_off();
        teamflagbase.objectiveicon gameobjects::setobjectivestatusallicons( level.icontarget, level.icontarget, level.mlgiconfullflag );
    }
    else
    {
        teamflagbase.objectiveicon gameobjects::setobjectivestatusallicons( level.iconcaptureflag, level.iconcaptureflag, level.mlgiconfullflag );
    }
    
    return teamflagbase;
}

// Namespace tdef
// Params 1
// Checksum 0x135b24a7, Offset: 0x1db7
// Size: 0x3f
function setteaminhuddatafromteamname( teamname )
{
    if ( teamname == "axis" )
    {
        self setteaminhuddata( 1 );
        return;
    }
    
    if ( teamname == "allies" )
    {
        self setteaminhuddata( 2 );
        return;
    }
    
    self setteaminhuddata( 0 );
}

// Namespace tdef
// Params 3
// Checksum 0x6f068cef, Offset: 0x1dfe
// Size: 0x408
function onpickup( player, playervo, defused )
{
    self notify( #"picked_up" );
    player notify( #"obj_picked_up" );
    level.defenderflagbase.objectiveicon gameobjects::setvisibleteam( "none" );
    level.defenderflag.currentcarrier = player;
    player thread awardobjtimeforcarrier();
    
    if ( level.scorepertick > 0 )
    {
        level.defenderflag thread awardcapturepoints( player.team );
    }
    else
    {
        player thread flagattachradar();
    }
    
    gameobjects::setownerteam( player.team );
    team = player.pers[ "team" ];
    
    if ( team == "allies" )
    {
        otherteam = "axis";
    }
    else
    {
        otherteam = "allies";
    }
    
    player attachflag();
    
    if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( player ) ) )
    {
        if ( isdefined( player.leaderboarddata[ "pickups" ] ) )
        {
            player.leaderboarddata[ "pickups" ] = player.leaderboarddata[ "pickups" ] + 1;
        }
        
        if ( isdefined( level.leaderboardfunc[ "pickups" ] ) )
        {
            [[ level.leaderboardfunc[ "pickups" ] ]]( player, 1 );
        }
        
        assert( isint( 1 ) || isfloat( 1 ), "<dev string:x24>" );
        
        if ( isdefined( player.pers[ "pickups" ] ) )
        {
            player.pers[ "pickups" ] = player.pers[ "pickups" ] + 1;
        }
    }
    
    if ( self.ownerteam == "allies" )
    {
        setomnvar( "ui_single_flag_loc", player getentitynumber() );
    }
    else
    {
        setomnvar( "ui_single_flag_loc", player getentitynumber() );
    }
    
    player setclientomnvar( "ui_flag_player_hud_icon", 1 );
    
    if ( isdefined( level.showenemycarrier ) )
    {
        if ( level.showenemycarrier == 0 )
        {
            gameobjects::setvisibleteam( "none" );
        }
        else
        {
            gameobjects::setvisibleteam( "friendly" );
            objective_state( self.pingobjidnum, "current" );
            gameobjects::updatecompassicon( "enemy", self.pingobjidnum );
            objective_icon( self.pingobjidnum, "icon_waypoint_kill" );
            objective_setbackground( self.pingobjidnum, 2 );
            objidpoolmanager::function_4b37488488e7d007( self.pingobjidnum, 1 );
            objidpoolmanager::update_objective_setfriendlylabel( self.pingobjidnum, "MP_INGAME_ONLY/OBJ_DEFEND_CAPS" );
            objidpoolmanager::update_objective_setenemylabel( self.pingobjidnum, "MP_INGAME_ONLY/OBJ_KILL_CAPS" );
            objective_setownerteam( self.pingobjidnum, team );
        }
    }
    
    gameobjects::setobjectivestatusallicons( level.iconescort, level.iconkill, level.mlgiconfullflag );
    print::printandsoundoneveryone( team, otherteam, undefined, undefined, "mp_obj_taken", "mp_enemy_obj_taken", player );
    
    if ( !level.gameended )
    {
        dialog::leaderdialog( "enemy_flag_taken", team );
        dialog::leaderdialog( "flag_getback", otherteam );
    }
    
    thread hud_util::teamplayercardsplash( "callout_flagpickup", player );
    player thread hud_message::showsplash( "flagpickup" );
    
    if ( self.previouscarrier != player )
    {
        player thread points::doscoreevent( #"flag_grab" );
    }
    
    telemetry_data = spawnstruct();
    telemetry_data.player = player;
    telemetry_data.eventname = "pickup";
    telemetry_data.position = player.origin;
    telemetry_utils::function_af2d366f9522f76f( "callback_on_game_event", telemetry_data );
    self.previouscarrier = player;
    
    if ( level.codcasterenabled )
    {
        player setgametypevip( 1 );
    }
}

// Namespace tdef
// Params 0
// Checksum 0xca43d09b, Offset: 0x220e
// Size: 0x9
function returnflag()
{
    gameobjects::returnhome();
}

// Namespace tdef
// Params 1
// Checksum 0x942ffef4, Offset: 0x221f
// Size: 0x27a
function ondrop( player )
{
    if ( isdefined( player.leaving_team ) )
    {
        self.droppedteam = player.leaving_team;
        player.leaving_team = undefined;
    }
    else if ( !isdefined( player ) )
    {
        self.droppedteam = self.ownerteam;
    }
    else
    {
        self.droppedteam = player.team;
    }
    
    level.defenderflag.currentcarrier = undefined;
    
    if ( isdefined( player ) )
    {
        player updatematchstatushintonnoflag();
    }
    
    gameobjects::setownerteam( "neutral" );
    otherteam = team_utility::getotherteam( self.droppedteam );
    gameobjects::allowcarry( "any" );
    gameobjects::setvisibleteam( "any" );
    objective_state( self.pingobjidnum, "done" );
    
    if ( level.returntime >= 0 )
    {
        gameobjects::setobjectivestatusallicons( level.iconreturnflag, level.iconreturnflag, level.mlgiconfullflag );
    }
    else
    {
        gameobjects::setobjectivestatusallicons( level.iconreturnflag, level.iconreturnflag, level.mlgiconfullflag );
        objidpoolmanager::function_4b37488488e7d007( self.objidnum, 1 );
    }
    
    if ( self.ownerteam == "allies" )
    {
        setomnvar( "ui_single_flag_loc", -1 );
    }
    else
    {
        setomnvar( "ui_single_flag_loc", -1 );
    }
    
    if ( isdefined( player ) )
    {
        player setclientomnvar( "ui_flag_player_hud_icon", 0 );
    }
    
    if ( isdefined( player ) )
    {
        if ( !player::isreallyalive( player ) )
        {
            player.carryobject.previouscarrier = undefined;
        }
        
        if ( isdefined( player.carryflag ) )
        {
            player detachflag();
        }
        
        print::printandsoundoneveryone( otherteam, "none", undefined, undefined, "iw9_mp_ui_objective_lost", "", player );
        
        if ( level.codcasterenabled )
        {
            player setgametypevip( 0 );
        }
    }
    else
    {
        sound::playsoundonplayers( "iw9_mp_ui_objective_lost", otherteam );
    }
    
    if ( !level.gameended )
    {
        dialog::leaderdialog( "enemy_flag_dropped", team_utility::getotherteam( self.droppedteam ), "status" );
        dialog::leaderdialog( "flag_dropped", self.droppedteam, "status" );
    }
    
    if ( level.spawndelay > 5 )
    {
        thread forcespawnplayers();
    }
    
    if ( level.idleresettime > 0 )
    {
        thread returnaftertime();
    }
}

// Namespace tdef
// Params 0
// Checksum 0xa8ee8e91, Offset: 0x24a1
// Size: 0xd5
function returnaftertime()
{
    self endon( #"picked_up" );
    currentwaittime = 0;
    
    while ( currentwaittime < level.idleresettime )
    {
        waitframe();
        
        if ( self.claimteam == "none" )
        {
            currentwaittime += level.framedurationseconds;
        }
    }
    
    foreach ( team in level.teamnamelist )
    {
        sound::playsoundonplayers( "iw9_mp_ui_objective_lost", team );
    }
    
    gameobjects::returnhome();
}

// Namespace tdef
// Params 0
// Checksum 0x4908272e, Offset: 0x257e
// Size: 0x151
function onreset()
{
    level.defenderflag.currentcarrier = undefined;
    
    if ( isdefined( level.defenderflag.portable_radar ) )
    {
        level.defenderflag.portable_radar clearportableradar();
        level.defenderflag.portable_radar delete();
    }
    
    if ( isdefined( self.droppedteam ) )
    {
        gameobjects::setownerteam( self.droppedteam );
    }
    
    gameobjects::allowcarry( "any" );
    gameobjects::setvisibleteam( "none" );
    gameobjects::setobjectivestatusicons( level.iconescort, level.iconkill );
    level.defenderflagbase.objectiveicon gameobjects::setvisibleteam( "any" );
    
    if ( !level.gameended )
    {
        dialog::leaderdialog( "enemy_flag_returned", team_utility::getotherteam( self.droppedteam ), "status" );
        dialog::leaderdialog( "enemy_flag_returned", self.droppedteam, "status" );
    }
    
    self.droppedteam = undefined;
    
    if ( self.ownerteam == "allies" )
    {
        setomnvar( "ui_single_flag_loc", -2 );
    }
    else
    {
        setomnvar( "ui_single_flag_loc", -2 );
    }
    
    self.previouscarrier = undefined;
}

// Namespace tdef
// Params 0
// Checksum 0x42986447, Offset: 0x26d7
// Size: 0x58
function attachflag()
{
    updatematchstatushintonhasflag();
    otherteam = team_utility::getotherteam( self.pers[ "team" ] );
    self attach( level.carryflag[ otherteam ], "tag_stowed_back3", 1 );
    self.carryflag = level.carryflag[ otherteam ];
}

// Namespace tdef
// Params 0
// Checksum 0x3d969744, Offset: 0x2737
// Size: 0x20
function detachflag()
{
    self detach( self.carryflag, "tag_stowed_back3" );
    self.carryflag = undefined;
}

// Namespace tdef
// Params 0
// Checksum 0x2c4ce91d, Offset: 0x275f
// Size: 0x12
function updatematchstatushintonnoflag()
{
    hud_message::function_ef4318a0090caa0f( #"single_flag_cap" );
}

// Namespace tdef
// Params 0
// Checksum 0x2f83db0, Offset: 0x2779
// Size: 0x12
function updatematchstatushintonhasflag()
{
    hud_message::function_ef4318a0090caa0f( #"single_flag_cap" );
}

// Namespace tdef
// Params 1
// Checksum 0x34391abb, Offset: 0x2793
// Size: 0x66, Type: bool
function checkcustomclosetoscorelimit( team )
{
    assert( isdefined( team ) );
    checkroundlimit = 10;
    var_a6f903ff6a32f2a9 = 20;
    var_d262c35ec7ded597 = level.roundscorelimit - getteamscore( team );
    
    if ( var_d262c35ec7ded597 <= ( game[ "finalRound" ] ? var_a6f903ff6a32f2a9 : checkroundlimit ) )
    {
        return true;
    }
    
    return false;
}

// Namespace tdef
// Params 1
// Checksum 0xa1442eca, Offset: 0x2802
// Size: 0x296
function awardobjtimeforcarrier( team )
{
    level endon( #"game_ended" );
    level.defenderflag endon( #"dropped" );
    level.defenderflag endon( #"reset" );
    level notify( #"hash_3dd8bdadd0b92d2f" );
    level endon( #"hash_3dd8bdadd0b92d2f" );
    
    while ( !level.gameended )
    {
        wait 1;
        hostmigration::waittillhostmigrationdone();
        
        if ( !level.gameended )
        {
            if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( level.defenderflag.carrier ) ) )
            {
                if ( isdefined( level.defenderflag.carrier.leaderboarddata[ "objTime" ] ) )
                {
                    level.defenderflag.carrier.leaderboarddata[ "objTime" ] = level.defenderflag.carrier.leaderboarddata[ "objTime" ] + 1;
                }
                
                if ( isdefined( level.leaderboardfunc[ "objTime" ] ) )
                {
                    [[ level.leaderboardfunc[ "objTime" ] ]]( level.defenderflag.carrier, 1 );
                }
                
                assert( isint( 1 ) || isfloat( 1 ), "<dev string:x24>" );
                
                if ( isdefined( level.defenderflag.carrier.pers[ "objTime" ] ) )
                {
                    level.defenderflag.carrier.pers[ "objTime" ] = level.defenderflag.carrier.pers[ "objTime" ] + 1;
                }
            }
            
            level.defenderflag.carrier persistence::statsetchild( "round", "objTime", level.defenderflag.carrier.pers[ "objTime" ] );
            level.defenderflag.carrier stats::setextrascore0( level.defenderflag.carrier.pers[ "objTime" ] );
            level.defenderflag.carrier gamescore::giveplayerscore( #"hash_98bfd8d29c56bc08", 10 );
        }
    }
}

// Namespace tdef
// Params 1
// Checksum 0xcdd124d8, Offset: 0x2aa0
// Size: 0x155
function flagattachradar( radarteam )
{
    level endon( #"game_ended" );
    level.defenderflag endon( #"dropped" );
    level.defenderflag endon( #"reset" );
    level notify( #"hash_320e8bacd2dc8c11" );
    level endon( #"hash_320e8bacd2dc8c11" );
    
    if ( isdefined( level.defenderflag.portable_radar ) )
    {
        level.defenderflag.portable_radar clearportableradar();
        level.defenderflag.portable_radar delete();
    }
    
    if ( !isdefined( radarteam ) )
    {
        radarteam = self.team;
    }
    
    radarowner = getflagradarowner( radarteam );
    portable_radar = spawn( "script_model", level.defenderflag.visuals[ 0 ].origin );
    portable_radar.team = team_utility::getotherteam( radarteam );
    portable_radar.owner = radarowner;
    portable_radar makeportableradar( radarowner );
    level.defenderflag.portable_radar = portable_radar;
    level.defenderflag thread flagradarmover();
    level.defenderflag thread flagwatchradarownerlost();
}

// Namespace tdef
// Params 1
// Checksum 0xcda0456, Offset: 0x2bfd
// Size: 0x122
function getflagradarowner( team )
{
    level endon( #"game_ended" );
    self endon( #"dropped" );
    level endon( #"hash_320e8bacd2dc8c11" );
    var_e4318645b664dbf5 = 0;
    
    while ( true )
    {
        if ( level.teamswithplayers.size == 1 && game[ "state" ] == "playing" )
        {
            var_e4318645b664dbf5 = 1;
        }
        else
        {
            if ( var_e4318645b664dbf5 )
            {
                wait 15;
            }
            
            otherteam = team_utility::getotherteam( team );
            var_e4318645b664dbf5 = 0;
            
            foreach ( player in level.players )
            {
                if ( isalive( player ) && player.pers[ "team" ] == otherteam )
                {
                    return player;
                }
            }
        }
        
        wait 0.05;
    }
}

// Namespace tdef
// Params 0
// Checksum 0x6e251585, Offset: 0x2d27
// Size: 0x69
function flagradarmover()
{
    level endon( #"game_ended" );
    self endon( #"dropped" );
    self.portable_radar endon( #"death" );
    level endon( #"hash_320e8bacd2dc8c11" );
    
    for ( ;; )
    {
        self.portable_radar moveto( self.currentcarrier.origin, 0.05 );
        wait 0.05;
    }
}

// Namespace tdef
// Params 0
// Checksum 0xe846ab20, Offset: 0x2d98
// Size: 0x8d
function flagwatchradarownerlost()
{
    level endon( #"game_ended" );
    self endon( #"dropped" );
    radarteam = self.portable_radar.team;
    radarteam = team_utility::getotherteam( radarteam );
    self.portable_radar.owner utility::waittill_any( "disconnect", "joined_team", "joined_spectators" );
    self.portable_radar clearportableradar();
    self.portable_radar = undefined;
    flagattachradar( radarteam );
}

// Namespace tdef
// Params 0
// Checksum 0xaf64132f, Offset: 0x2e2d
// Size: 0x6e
function getrespawndelay()
{
    ownerteam = level.defenderflag gameobjects::getownerteam();
    
    if ( isdefined( ownerteam ) )
    {
        if ( self.pers[ "team" ] == ownerteam )
        {
            if ( !isdefined( level.spawndelay ) || level.spawndelay <= 0 )
            {
                return;
            }
            
            if ( self.ignorerespawndelay )
            {
                return 0;
            }
            
            return level.spawndelay;
        }
    }
}

// Namespace tdef
// Params 0
// Checksum 0x1faed60c, Offset: 0x2ea3
// Size: 0x8b
function forcespawnplayers()
{
    players = level.players;
    
    for ( i = 0; i < players.size ; i++ )
    {
        player = players[ i ];
        
        if ( !isdefined( player ) || player.fauxdead && player utility::isusingremote() || isalive( player ) && !player.fauxdead )
        {
            continue;
        }
        
        player notify( #"force_spawn" );
        waitframe();
    }
}

// Namespace tdef
// Params 1
// Checksum 0xcbb747dd, Offset: 0x2f36
// Size: 0x15
function onplayerconnect( player )
{
    thread onplayerspawned( player );
}

// Namespace tdef
// Params 1
// Checksum 0xf4b09b4, Offset: 0x2f53
// Size: 0x80
function onplayerspawned( player )
{
    while ( true )
    {
        player waittill( #"spawned" );
        player.ignorerespawndelay = undefined;
        player setclientomnvar( "ui_flag_player_hud_icon", 0 );
        player stats::setextrascore0( player.pers[ "objTime" ] ?? 0, "objTime" );
        player stats::setextrascore1( player.pers[ "defends" ] ?? 0, "defends" );
    }
}

// Namespace tdef
// Params 1
// Checksum 0xcdb8fc55, Offset: 0x2fdb
// Size: 0x81d
function function_8314535b81f548e( deathdata )
{
    einflictor = deathdata.inflictor;
    victim = deathdata.victim;
    attacker = deathdata.attacker;
    killid = deathdata.lifeid;
    
    if ( !isplayer( attacker ) || attacker == victim )
    {
        if ( isdefined( victim.carryflag ) )
        {
            victim detachflag();
            victim.ignorerespawndelay = 1;
        }
        
        return;
    }
    
    score = level.ppkteamnoflag;
    assert( isdefined( score ) );
    
    if ( isdefined( level.defenderflag ) && level.defenderflag gameobjects::getownerteam() == attacker.pers[ "team" ] )
    {
        if ( isdefined( level.defenderflag.carrier ) && attacker != level.defenderflag.carrier )
        {
            level.defenderflag.carrier thread rank::scoreeventpopup( #"carrier_bonus" );
            points = rank::getscoreinfovalue( #"carrier_bonus" );
            gamescore::giveplayerscore( #"carrier_bonus", points, victim );
            level.defenderflag.carrier thread rank::giverankxp( #"carrier_bonus", points );
            attacker thread rank::scoreeventpopup( #"kill_bonus" );
            points = rank::getscoreinfovalue( #"kill_bonus" );
            gamescore::giveplayerscore( #"kill_bonus", points, victim );
            attacker thread rank::giverankxp( #"kill_bonus", points );
        }
        
        score = level.ppkteamwithflag;
    }
    else if ( isdefined( victim.carryflag ) )
    {
        score = level.ppkflagcarrier;
    }
    
    attacker gamescore::giveteamscoreforobjective( attacker.pers[ "team" ], score );
    gaveaward = 0;
    attackerpos = attacker.origin;
    attackerisinflictor = 0;
    
    if ( isdefined( einflictor ) )
    {
        attackerpos = einflictor.origin;
        attackerisinflictor = einflictor == attacker;
    }
    
    killid = deathdata.lifeid;
    
    if ( isplayer( attacker ) && attacker.pers[ "team" ] != victim.pers[ "team" ] )
    {
        if ( isdefined( attacker.carryflag ) && attackerisinflictor )
        {
            attacker thread rank::scoreeventpopup( #"carrier_kill" );
            attacker thread points::doscoreevent( #"mode_ctf_kill_with_flag" );
            gaveaward = 1;
        }
        
        if ( isdefined( victim.carryflag ) )
        {
            attacker thread points::doscoreevent( #"mode_ctf_kill_carrier" );
            
            if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( attacker ) ) )
            {
                if ( isdefined( attacker.leaderboarddata[ "carrierKills" ] ) )
                {
                    attacker.leaderboarddata[ "carrierKills" ] = attacker.leaderboarddata[ "carrierKills" ] + 1;
                }
                
                if ( isdefined( level.leaderboardfunc[ "carrierKills" ] ) )
                {
                    [[ level.leaderboardfunc[ "carrierKills" ] ]]( attacker, 1 );
                }
                
                assert( isint( 1 ) || isfloat( 1 ), "<dev string:x24>" );
                
                if ( isdefined( attacker.pers[ "carrierKills" ] ) )
                {
                    attacker.pers[ "carrierKills" ] = attacker.pers[ "carrierKills" ] + 1;
                }
            }
            
            attacker thread hud_message::showsplash( "killed_carrier" );
            
            if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( attacker ) ) )
            {
                if ( isdefined( attacker.leaderboarddata[ "defends" ] ) )
                {
                    attacker.leaderboarddata[ "defends" ] = attacker.leaderboarddata[ "defends" ] + 1;
                }
                
                if ( isdefined( level.leaderboardfunc[ "defends" ] ) )
                {
                    [[ level.leaderboardfunc[ "defends" ] ]]( attacker, 1 );
                }
                
                assert( isint( 1 ) || isfloat( 1 ), "<dev string:x24>" );
                
                if ( isdefined( attacker.pers[ "defends" ] ) )
                {
                    attacker.pers[ "defends" ] = attacker.pers[ "defends" ] + 1;
                }
            }
            
            attacker persistence::statsetchild( "round", "defends", attacker.pers[ "defends" ] );
            thread utility::trycall( level.matchdata_logvictimkillevent, killid, "carrying" );
            codcaster_utils::function_3038b6eafc46c037( 20, attacker.team, attacker getentitynumber() );
            gaveaward = 1;
        }
        
        if ( !gaveaward )
        {
            awardassault = 0;
            awarddefense = 0;
            flagcheck = distsquaredcheck( attackerpos, victim.origin, level.defenderflag.curorigin );
            
            if ( flagcheck )
            {
                if ( level.defenderflag.ownerteam == victim.team )
                {
                    awardassault = 1;
                }
                else
                {
                    awarddefense = 1;
                }
            }
            
            if ( awardassault )
            {
                attacker thread rank::function_d2aa8986c506e985( #"assault" );
                attacker events::function_58da673c1c3fc9f2();
                thread utility::trycall( level.matchdata_logvictimkillevent, killid, "defending" );
                
                if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( attacker ) ) )
                {
                    if ( isdefined( attacker.leaderboarddata[ "assaults" ] ) )
                    {
                        attacker.leaderboarddata[ "assaults" ] = attacker.leaderboarddata[ "assaults" ] + 1;
                    }
                    
                    if ( isdefined( level.leaderboardfunc[ "assaults" ] ) )
                    {
                        [[ level.leaderboardfunc[ "assaults" ] ]]( attacker, 1 );
                    }
                    
                    assert( isint( 1 ) || isfloat( 1 ), "<dev string:x24>" );
                    
                    if ( isdefined( attacker.pers[ "assaults" ] ) )
                    {
                        attacker.pers[ "assaults" ] = attacker.pers[ "assaults" ] + 1;
                    }
                }
            }
            else if ( awarddefense )
            {
                attacker thread rank::function_d2aa8986c506e985( #"defend" );
                attacker events::function_20a5f572df6afd43();
                
                if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( attacker ) ) )
                {
                    if ( isdefined( attacker.leaderboarddata[ "defends" ] ) )
                    {
                        attacker.leaderboarddata[ "defends" ] = attacker.leaderboarddata[ "defends" ] + 1;
                    }
                    
                    if ( isdefined( level.leaderboardfunc[ "defends" ] ) )
                    {
                        [[ level.leaderboardfunc[ "defends" ] ]]( attacker, 1 );
                    }
                    
                    assert( isint( 1 ) || isfloat( 1 ), "<dev string:x24>" );
                    
                    if ( isdefined( attacker.pers[ "defends" ] ) )
                    {
                        attacker.pers[ "defends" ] = attacker.pers[ "defends" ] + 1;
                    }
                }
                
                attacker persistence::statsetchild( "round", "defends", attacker.pers[ "defends" ] );
                thread utility::trycall( level.matchdata_logvictimkillevent, killid, "assaulting" );
            }
        }
    }
    
    if ( isdefined( victim.carryflag ) )
    {
        victim detachflag();
        victim.ignorerespawndelay = 1;
    }
}

// Namespace tdef
// Params 3
// Checksum 0x3b0fb4d1, Offset: 0x3800
// Size: 0x61
function distsquaredcheck( attackerpos, victimpos, checkpos )
{
    attackerdistsq = distancesquared( checkpos, attackerpos );
    victimdistsq = distancesquared( checkpos, victimpos );
    
    if ( attackerdistsq < 90000 || victimdistsq < 90000 )
    {
        return 1;
    }
    
    return 0;
}

// Namespace tdef
// Params 0
// Checksum 0x3e6638ca, Offset: 0x3869
// Size: 0x54
function carriergivescore()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    level.defenderflag endon( #"dropped" );
    level.defenderflag endon( #"reset" );
    
    while ( true )
    {
        wait level.carrierbonustime;
    }
}

// Namespace tdef
// Params 1
// Checksum 0xfc46a4b3, Offset: 0x38c5
// Size: 0x2f1
function awardcapturepoints( team )
{
    level endon( #"game_ended" );
    level.defenderflag endon( #"dropped" );
    level.defenderflag endon( #"reset" );
    level notify( #"awardcapturepointsrunning" );
    level endon( #"awardcapturepointsrunning" );
    
    if ( level.carrierbonusscore > 0 )
    {
        level.defenderflag.carrier thread carriergivescore();
    }
    
    seconds = level.scoringtime;
    score = level.scorepertick;
    
    while ( !level.gameended )
    {
        wait seconds;
        hostmigration::waittillhostmigrationdone();
        
        if ( !level.gameended )
        {
            gamescore::giveteamscoreforobjective( team, score, 0 );
            
            if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( level.defenderflag.carrier ) ) )
            {
                if ( isdefined( level.defenderflag.carrier.leaderboarddata[ "objTime" ] ) )
                {
                    level.defenderflag.carrier.leaderboarddata[ "objTime" ] = level.defenderflag.carrier.leaderboarddata[ "objTime" ] + 1;
                }
                
                if ( isdefined( level.leaderboardfunc[ "objTime" ] ) )
                {
                    [[ level.leaderboardfunc[ "objTime" ] ]]( level.defenderflag.carrier, 1 );
                }
                
                assert( isint( 1 ) || isfloat( 1 ), "<dev string:x24>" );
                
                if ( isdefined( level.defenderflag.carrier.pers[ "objTime" ] ) )
                {
                    level.defenderflag.carrier.pers[ "objTime" ] = level.defenderflag.carrier.pers[ "objTime" ] + 1;
                }
            }
            
            level.defenderflag.carrier persistence::statsetchild( "round", "objTime", level.defenderflag.carrier.pers[ "objTime" ] );
            level.defenderflag.carrier stats::setextrascore0( level.defenderflag.carrier.pers[ "objTime" ] );
            level.defenderflag.carrier gamescore::giveplayerscore( #"hash_98bfd8d29c56bc08", 10 );
        }
    }
}

// Namespace tdef
// Params 0
// Checksum 0xdbd0eaa2, Offset: 0x3bbe
// Size: 0x48
function function_3a8a1ef3d08777ea()
{
    level.defenderflagtime = level.possessionresettime;
    level.var_ec8fd72c0af44fce = 1;
    level.var_ff6b08d33b9d81b5 = 0;
    
    if ( isdefined( level.possessionresetcondition ) && level.possessionresetcondition != 0 )
    {
    }
}

// Namespace tdef
// Params 0
// Checksum 0xf8f99362, Offset: 0x3c0e
// Size: 0x2a
function createhudelems()
{
    level endon( #"game_ended" );
    flags::gameflagwait( "prematch_done" );
    updatetimers( "neutral", 1, 1 );
}

// Namespace tdef
// Params 4
// Checksum 0x57a93fb0, Offset: 0x3c40
// Size: 0x12e
function updatetimers( ownerteam, stoptimer, resethome, resetpossession )
{
    if ( !level.possessionresetcondition )
    {
        return;
    }
    
    timeoverride = undefined;
    displaytime = 1000 * level.possessionresettime;
    
    if ( resethome )
    {
        if ( level.flagactivationdelay && !level.defenderflagreset )
        {
            displaytime = 1000 * level.flagactivationdelay;
        }
    }
    
    if ( resethome || resetpossession )
    {
        level.defenderflagtime = level.possessionresettime;
        level.defenderflagendtime = int( gettime() + displaytime );
    }
    else
    {
        level.defenderflagendtime = int( gettime() + 1000 * level.defenderflagtime );
    }
    
    setomnvar( "ui_hardpoint_timer", level.defenderflagendtime );
    
    if ( displaytime > 0 && ( resetpossession || !stoptimer && level.var_ec8fd72c0af44fce ) )
    {
        level.defenderflag thread defenderflagruntimer( ownerteam, timeoverride );
    }
    
    if ( stoptimer )
    {
        level pausedefenderflagtimer();
    }
}

// Namespace tdef
// Params 2
// Checksum 0x8da79905, Offset: 0x3d76
// Size: 0x65
function defenderflagruntimer( ownerteam, timeoverride )
{
    level endon( #"game_ended" );
    level endon( #"reset" );
    level endon( #"hash_93e70b56f3d42269" );
    level notify( #"defenderflagruntimer" );
    level endon( #"defenderflagruntimer" );
    level.var_ec8fd72c0af44fce = 0;
    function_d4c30fb0936a1885( ownerteam, timeoverride );
}

// Namespace tdef
// Params 2
// Checksum 0x4cba02e8, Offset: 0x3de3
// Size: 0x7f
function function_d4c30fb0936a1885( ownerteam, timeoverride )
{
    level endon( #"game_ended" );
    level endon( #"hash_93e70b56f3d42269" );
    var_706b83b036d3d887 = timeoverride ?? int( level.defenderflagtime * 1000 + gettime() );
    level function_3afbb8159b1dc025( timeoverride );
    thread watchtimerpause();
    level thread handlehostmigration( var_706b83b036d3d887 );
    function_e886470369a38487( level.defenderflagtime );
}

// Namespace tdef
// Params 1
// Checksum 0x1bb72eb2, Offset: 0x3e6a
// Size: 0xcf
function function_e886470369a38487( duration )
{
    level endon( #"game_ended" );
    level endon( #"hash_93e70b56f3d42269" );
    
    if ( duration == 0 )
    {
        return;
    }
    
    assert( duration > 0 );
    starttime = gettime();
    endtime = gettime() + duration * 1000;
    
    while ( gettime() < endtime )
    {
        function_3ff2f5d19c1cf4f4( ( endtime - gettime() ) / 1000 );
        
        while ( isdefined( level.hostmigrationtimer ) )
        {
            endtime += 1000;
            setgameendtime( int( endtime ) );
            wait 1;
        }
    }
    
    while ( isdefined( level.hostmigrationtimer ) )
    {
        endtime += 1000;
        setgameendtime( int( endtime ) );
        wait 1;
    }
    
    return gettime() - starttime;
}

// Namespace tdef
// Params 1
// Checksum 0xca8bb471, Offset: 0x3f42
// Size: 0x41
function function_3ff2f5d19c1cf4f4( duration )
{
    level endon( #"game_ended" );
    level endon( #"hash_93e70b56f3d42269" );
    
    if ( isdefined( level.hostmigrationtimer ) )
    {
        return;
    }
    
    level endon( #"host_migration_begin" );
    wait duration;
}

// Namespace tdef
// Params 1
// Checksum 0x5c7c1e33, Offset: 0x3f8b
// Size: 0x9a
function handlehostmigration( var_706b83b036d3d887 )
{
    level endon( #"game_ended" );
    level endon( #"disconnect" );
    level waittill( #"host_migration_begin" );
    setomnvar( "ui_objective_timer_stopped", 1 );
    timepassed = hostmigration::waittillhostmigrationdone();
    
    if ( !level.var_ff6b08d33b9d81b5 )
    {
        setomnvar( "ui_objective_timer_stopped", 0 );
    }
    
    if ( timepassed > 0 )
    {
        setomnvar( "ui_hardpoint_timer", level.defenderflagendtime + timepassed );
        return;
    }
    
    setomnvar( "ui_hardpoint_timer", level.defenderflagendtime );
}

// Namespace tdef
// Params 0
// Checksum 0x96543a0b, Offset: 0x402d
// Size: 0x170
function watchtimerpause()
{
    level endon( #"game_ended" );
    level notify( #"hash_513e4d2ea18e8884" );
    level endon( #"hash_513e4d2ea18e8884" );
    var_d66cfac23c2a777f = 0;
    var_a1800dfc9287f27e = undefined;
    
    while ( level.defenderflagtime > 0 && !level.var_ec8fd72c0af44fce )
    {
        currenttime = gettime();
        
        if ( !var_d66cfac23c2a777f && level.defenderflagtime < 10 )
        {
            foreach ( entry in level.teamnamelist )
            {
            }
            
            var_d66cfac23c2a777f = 1;
        }
        
        if ( isdefined( level.defenderflag.carrier ) && level.defenderflagtime < 5 )
        {
            if ( !isdefined( var_a1800dfc9287f27e ) || currenttime > var_a1800dfc9287f27e + 1000 )
            {
                var_a1800dfc9287f27e = currenttime;
            }
        }
        
        dt = 0.05;
        wait dt;
        level.defenderflagtime -= dt;
    }
    
    if ( level.var_ec8fd72c0af44fce )
    {
        level notify( #"hash_93e70b56f3d42269" );
    }
}

// Namespace tdef
// Params 1
// Checksum 0x21f1706c, Offset: 0x41a5
// Size: 0x96
function function_dfa513509d55f70e( timeoverride )
{
    shouldbestopped = level.var_ec8fd72c0af44fce || isdefined( level.hostmigrationtimer );
    
    if ( !flags::gameflag( "prematch_done" ) )
    {
        shouldbestopped = 0;
    }
    
    if ( !level.var_ff6b08d33b9d81b5 && shouldbestopped )
    {
        level.var_ff6b08d33b9d81b5 = 1;
        setomnvar( "ui_objective_timer_stopped", 1 );
        return;
    }
    
    if ( level.var_ff6b08d33b9d81b5 && !shouldbestopped )
    {
        level.var_ff6b08d33b9d81b5 = 0;
        setomnvar( "ui_objective_timer_stopped", 0 );
    }
}

// Namespace tdef
// Params 0
// Checksum 0x616e8efc, Offset: 0x4243
// Size: 0x14
function pausedefenderflagtimer()
{
    level.var_ec8fd72c0af44fce = 1;
    function_dfa513509d55f70e();
}

// Namespace tdef
// Params 1
// Checksum 0x9a4dd8b8, Offset: 0x425f
// Size: 0x1f
function function_3afbb8159b1dc025( timeoverride )
{
    level.var_ec8fd72c0af44fce = 0;
    function_dfa513509d55f70e( timeoverride );
}

