// scripts\mp\zm\globallogic.gsc  (hash_2e781d07aab11f1f.gscc) (size: 6251 Bytes / 0x186b / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xcdfef90c (3456039180)
// size ...... 6251 (0x186b)
// includes .. 21  (offset: 0x16eb)
// strings ... 16  (offset: 0x1793)
// dev strs .. 1   (offset: 0x185f)
// exports ... 12  (offset: 0xb47)
// cseg ...... 0x145 + 0xa02 (0xb47)
// imports ... 84  (offset: 0xd27)
// animtree1 . 0   (offset: 0x186b)
// animtree2 . 0   (offset: 0x186b)
#using scripts\common\callbacks;
#using scripts\common\damage_effects;
#using scripts\common\game_utility;
#using scripts\common\utility;
#using scripts\mp\agents\agent_utility;
#using scripts\mp\class;
#using scripts\mp\common\utility\damage;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\stats;
#using scripts\mp\common\utility\weapon;
#using scripts\mp\damage;
#using scripts\mp\dev;
#using scripts\mp\gametypes\common;
#using scripts\mp\hostmigration;
#using scripts\mp\matchrecording;
#using scripts\mp\mp_agent_damage;
#using scripts\mp\playerlogic;
#using scripts\mp\spawnlogic;
#using scripts\mp\teams;
#using scripts\mp\weapons;
#using scripts\mp\zm\gamelogic;

#namespace globallogic;

// Namespace globallogic
// Params 0
// Checksum 0xcfded833, Offset: 0x163
// Size: 0x322
function init()
{
    class::init();
    level.leanthread = getdvarint( @"scr_runlean_playerthread_count", 0 ) == 1;
    level.script = tolower( getdvar( @"g_mapname" ) );
    level.gametype = getgametypenamekey();
    level.codcasterenabled = iscodcasterenabled();
    level.systemlink = getdvarint( @"systemlink", 0 ) == 1;
    level.splitscreen = issplitscreen();
    level.onlinegame = getdvarint( @"onlinegame" );
    level.rankedmatch = level.onlinegame && !getdvarint( @"xblive_privatematch" ) || getdvarint( @"force_ranking" );
    level.matchmakingmatch = level.onlinegame && !getdvarint( @"xblive_privatematch" );
    level.playerxpenabled = level.matchmakingmatch || getdvarint( @"force_challenges" );
    level.weaponxpenabled = level.playerxpenabled;
    level.challengesallowed = level.playerxpenabled || getdvarint( @"force_challenges" );
    level.enforceantiboosting = level.playerxpenabled || level.weaponxpenabled || level.challengesallowed;
    level.onlinestatsenabled = 0;
    level.var_cc0c7bf608489ed8 = level.rankedmatch;
    level.leagueplaymatch = getdvarint( @"online_matchmaking_is_league_play" );
    level.var_309e3d9dac389de6 = getdvarint( @"online_matchmaking_is_league_play_br" );
    level.var_29b966035bd23252 = level.gametypebundle.var_482de5aa696344bc;
    level.var_1ca6e1d1e2be7825 = level.gametypebundle.disableachievements;
    level.starttimeutcseconds = getsystemtime();
    level.disablespawncamera = 1;
    stats::setplayerdatagroups();
    level callback::add( #"register_team_data", &function_fed950ba91b95eca );
    level.teambased = 0;
    println( "<dev string:x24>" + gettime() );
    level.objectivebased = 0;
    level.endgameontimelimit = 1;
    level.showingfinalkillcam = 0;
    level.tispawndelay = getdvarint( @"scr_tispawndelay", 5 );
    level.halftimetype = "halftime";
    level.lastscorestatustime = 0;
    level.waswinning = "none";
    level.lastslowprocessframe = 0;
    level.postroundtime = 4.5;
    level.ai_starting_health = [];
    
    if ( utility::issharedfuncdefined( #"seasonalevents", #"init" ) )
    {
        level utility::callsharedfunc( #"seasonalevents", #"init" );
    }
    
    registerdvars();
    
    /#
        if ( getdvarint( @"hash_ff213c5a6a5e05e4", 0 ) == 1 )
        {
            thread function_58cb0ace0cb9d3bb();
        }
    #/
    
    class::function_3ffe6bf4c4104c66();
}

// Namespace globallogic
// Params 0
// Checksum 0x6b74e5b0, Offset: 0x48d
// Size: 0x69
function endmatchonhostdisconnect()
{
    level endon( #"game_ended" );
    
    for ( ;; )
    {
        level waittill( #"connected", player );
        
        if ( player ishost() )
        {
            host = player;
            break;
        }
    }
    
    host waittill( #"disconnect" );
    thread gamelogic_zm::endgame( "draw", game[ "end_reason" ][ "host_ended_game" ] );
}

/#

    // Namespace globallogic
    // Params 0
    // Checksum 0x30a22b58, Offset: 0x4fe
    // Size: 0x38, Type: dev
    function function_58cb0ace0cb9d3bb()
    {
        wait 1;
        
        while ( level.players.size < 1 )
        {
            wait 0.5;
        }
        
        wait 0.5;
        level notify( #"game_ended" );
        exitlevel();
    }

#/

// Namespace globallogic
// Params 0
// Checksum 0xc30fb2ee, Offset: 0x53e
// Size: 0xe3
function registerdvars()
{
    if ( getdvarint( @"hash_e6afce2cf5cf7515" ) != 1 )
    {
        setomnvar( "ui_nuke_end_milliseconds", 0 );
    }
    
    setdvar( @"scr_force_team", "allies" );
    setdvar( @"ui_danger_team", "" );
    setdvar( @"ui_inhostmigration", 0 );
    setdvar( @"compassmaxrange", 1750 );
    var_af7b684de166577d = getdvarint( @"scr_force_thirdperson", 0 );
    
    switch ( var_af7b684de166577d )
    {
        case 0:
        case 2:
        case 3:
            level.forcethirdperson = 0;
            break;
        case 1:
            level.forcethirdperson = 1;
            break;
    }
    
    registerfalldamagedvars();
    function_e4725b747d6d9d69();
}

// Namespace globallogic
// Params 0
// Checksum 0x4e6bdcc4, Offset: 0x629
// Size: 0xfa
function registerfalldamagedvars()
{
    if ( game_utility_mp::function_166654fc96d0736a() )
    {
        setdvar( @"bg_falldamageminheight", getdvarint( @"scr_submap_falldamageminheight", 225 ) );
        setdvar( @"bg_falldamagemaxheight", getdvarint( @"scr_submap_falldamagemaxheight", 560 ) );
        setdvar( @"bg_softlandingminheight", getdvarint( @"scr_submap_softlandingminheight", 225 ) );
        setdvar( @"bg_softlandingmaxheight", getdvarint( @"scr_submap_softlandingmaxheight", 560 ) );
        return;
    }
    
    setdvar( @"bg_falldamageminheight", getdvarint( @"scr_core_falldamageminheight", 225 ) );
    setdvar( @"bg_falldamagemaxheight", getdvarint( @"scr_core_falldamagemaxheight", 375 ) );
    setdvar( @"bg_softlandingminheight", getdvarint( @"scr_core_softlandingminheight", 225 ) );
    setdvar( @"bg_softlandingmaxheight", getdvarint( @"scr_core_softlandingmaxheight", 375 ) );
}

// Namespace globallogic
// Params 0
// Checksum 0x3dae0216, Offset: 0x72b
// Size: 0x22
function function_e4725b747d6d9d69()
{
    setdvar( @"lui_show_turret_overheat", 1 );
    setdvar( @"bg_turretoverheatreset", 1 );
}

// Namespace globallogic
// Params 0
// Checksum 0x8bd93695, Offset: 0x755
// Size: 0x17e
function setupcallbacks()
{
    setdefaultcallbacks();
    common::setupcommoncallbacks();
    level.getspawnpoint = &utility::empty_init_func;
    level.onspawnplayer = &common::onspawnplayercommon;
    level.onplayerkilledcommon = &common::onplayerkilledcommon;
    level.onrespawndelay = &utility::empty_init_func;
    level.ontimelimit = &gamelogic_zm::default_ontimelimit;
    level.onhalftime = &gamelogic_zm::default_onhalftime;
    level.ondeadevent = &gamelogic_zm::default_ondeadevent;
    level.ononeleftevent = &gamelogic_zm::default_ononeleftevent;
    level.onprecachegametype = &utility::empty_init_func;
    level.onstartgametype = &onstartgametype;
    level.onplayerkilled = &utility::empty_init_func;
    
    if ( !game_utility_mp::lpcfeaturegated() )
    {
        level.matchrecording_init = &matchrecording::init;
    }
    
    level.weaponmapfunc = &weapon::mapweapon;
    level.initagentscriptvariables = &agent_utility::initagentscriptvariables;
    level.setagentteam = &agent_utility::set_agent_team;
    level.agentvalidateattacker = &damage::_validateattacker;
    level.agentfunc = &agent_utility::agentfunc;
    level.addtocharactersarray = &game_utility_common::addtocharactersarray;
    level.prematchallowfunc = &playerlogic::playerprematchallow;
    level.updategameevents = &gamelogic_zm::updategameevents;
    level.updatetimerpausedness = &gamelogic_zm::updatetimerpausedness;
    level.matchstarttimer = &gamelogic_zm::matchstarttimer;
    level.var_871c7d9fbeeb5187 = &gamelogic_zm::function_871c7d9fbeeb5187;
    
    if ( getbuildversion() != "SHIP" )
    {
        level.devinit = &dev_mp::init;
    }
    
    mp_agent_damage::register_ai_damage_callbacks();
}

// Namespace globallogic
// Params 0
// Checksum 0xc7190d3b, Offset: 0x8db
// Size: 0x12f
function setdefaultcallbacks()
{
    level.callbackstartgametype = &gamelogic_zm::callback_startgametype;
    level.callbackplayeractive = &playerlogic::callback_playeractive;
    level.callbackplayerconnect = &playerlogic::callback_playerconnect;
    level.callbackplayerdisconnect = &playerlogic::callback_playerdisconnect;
    level.callbackplayerdamage = &damage::callback_playerdamage;
    level.callbackplayerdamageeffects = &damage_effects::callback_playerdamageeffects;
    level.callbackplayerimpaled = &damage::callback_playerimpaled;
    level.var_8f62eac141f8bdb6 = &damage::function_42649d6d0a964fbd;
    level.callbackplayerkilled = &damage::callback_playerkilled;
    level.callbackplayerlaststand = &damage::callback_playerlaststand;
    level.callbackplayermigrated = &playerlogic::callback_playermigrated;
    level.var_c6a23d27f33a948c = &weapons::function_6831567befa159a1;
    level.callbackhostmigration = &hostmigration::callback_hostmigration;
    level.callbackfinishweaponchange = &weapons::callback_finishweaponchange;
    level.callbackspawnpointprecalc = &spawnlogic::codecallbackhandler_spawnpointprecalc;
    level.callbackspawnpointscore = &spawnlogic::codecallbackhandler_spawnpointscore;
    level.callbackspawnpointcritscore = &spawnlogic::codecallbackhandler_spawnpointcritscore;
    level.var_4524771918fe585f = &playerlogic::callback_playerconnectrejoin;
    level.var_880cfcfec57ca836 = &playerlogic::function_eb57164fee20f297;
    level.var_16eab40d8f2ae445 = &playerlogic::function_b69d00f730747014;
    callback::add( #"hash_bfe74b2130bdd498", &playerlogic::function_d748b5fff3953d0c );
}

// Namespace globallogic
// Params 1, eflags: 0x4
// Checksum 0x4902d699, Offset: 0xa12
// Size: 0x49
function private function_fed950ba91b95eca( params )
{
    level.teamnamelist = [ "axis", "allies", "team_two_hundred" ];
    teams::initteamdata( "allies" );
    teams::initteamdata( "team_two_hundred" );
}

// Namespace globallogic
// Params 0
// Checksum 0x7e0b9ab3, Offset: 0xa63
// Size: 0x9b
function onstartgametype()
{
    if ( getdvarint( @"hash_742caa13b3c2e685" ) )
    {
        return;
    }
    
    spawnlogic::setactivespawnlogic( #"default" );
    spawnlogic::function_6dbabb72223a4bca();
    spawnlogic::function_9bd2654564d3372d( #"start", #"start_attackers", "mp_tdm_spawn_allies_start", game[ "attackers" ] );
    spawnlogic::function_9bd2654564d3372d( #"start", #"start_defenders", "mp_tdm_spawn_axis_start", game[ "defenders" ], 1 );
    spawnlogic::function_17e08e497a9b4136( #"primary", #"primary", "mp_tdm_spawn" );
    spawnlogic::finalizemap();
}

/#

    // Namespace globallogic
    // Params 2
    // Checksum 0x4ea00b11, Offset: 0xb06
    // Size: 0x41, Type: dev
    function debugline( start, end )
    {
        for ( i = 0; i < 50 ; i++ )
        {
            line( start, end );
            wait 0.05;
        }
    }

#/
