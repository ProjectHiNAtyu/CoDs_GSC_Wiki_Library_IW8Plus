// scripts\mp\globallogic.gsc  (hash_3fa219ad83e2cebb.gscc) (size: 7007 Bytes / 0x1b5f / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xaa048249 (2852422217)
// size ...... 7007 (0x1b5f)
// includes .. 25  (offset: 0x19bb)
// strings ... 14  (offset: 0x1a83)
// dev strs .. 3   (offset: 0x1b3b)
// exports ... 12  (offset: 0xd7f)
// cseg ...... 0x129 + 0xc56 (0xd7f)
// imports ... 87  (offset: 0xf5f)
// animtree1 . 0   (offset: 0x1b5f)
// animtree2 . 0   (offset: 0x1b5f)
#using scripts\common\callbacks;
#using scripts\common\damage;
#using scripts\common\damage_effects;
#using scripts\common\game_utility;
#using scripts\common\utility;
#using scripts\mp\agents\agent_utility;
#using scripts\mp\class;
#using scripts\mp\common\utility\damage;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\stats;
#using scripts\mp\common\utility\weapon;
#using scripts\mp\damage;
#using scripts\mp\dev;
#using scripts\mp\flags;
#using scripts\mp\gamelogic;
#using scripts\mp\gamestaterestore;
#using scripts\mp\gametypes\common;
#using scripts\mp\hostmigration;
#using scripts\mp\interaction;
#using scripts\mp\matchrecording;
#using scripts\mp\mp_agent_damage;
#using scripts\mp\playerlogic;
#using scripts\mp\spawnlogic;
#using scripts\mp\weapons;

#namespace globallogic;

// Namespace globallogic
// Params 0
// Checksum 0xe24d675a, Offset: 0x147
// Size: 0x49a
function init()
{
    class::init();
    println( "<dev string:x24>" );
    
    if ( getdvarint( @"hash_7dfc9d99d9c1ff2f", 0 ) == 1 )
    {
        println( "<dev string:x2f>" );
        gamestaterestore::function_1be32ecf97c6b7ee();
        
        if ( isdefined( game[ "gameStateRestore" ] ) && game[ "gameStateRestore" ].gametime == 0 )
        {
            game[ "gameStateRestore" ].enabled = 0;
        }
        
        gamestaterestore::setupcallbacks();
    }
    
    level.leanthread = getdvarint( @"scr_runlean_playerthread_count", 0 ) == 1;
    level.script = tolower( getdvar( @"g_mapname" ) );
    level.gametype = game_utility::getgametype();
    level.systemlink = getdvarint( @"systemlink", 0 ) == 1;
    level.var_ac98e7cc4b10cb11 = level.gamemodebundle.var_ac98e7cc4b10cb11;
    level.var_47dc93bc4166ba18 = level.gamemodebundle.var_47dc93bc4166ba18;
    
    if ( level.var_ac98e7cc4b10cb11 )
    {
        level.var_ac98e7cc4b10cb11 = !getmatchrulesdata( "commonOption", "disableOverclocks" );
    }
    
    level.codcasterenabled = iscodcasterenabled();
    level.playermaxhealth = getdvarint( @"scr_player_maxhealth" );
    level.splitscreen = issplitscreen();
    level.onlinegame = getdvarint( @"onlinegame" );
    level.forcerankxp = getdvarint( @"force_ranking", 0 ) == 1;
    level.rankedmatch = level.onlinegame && !getdvarint( @"xblive_privatematch" ) || level.forcerankxp;
    level.matchmakingmatch = level.onlinegame && !getdvarint( @"xblive_privatematch" );
    level.playerxpenabled = level.matchmakingmatch || getdvarint( @"force_challenges" );
    level.weaponxpenabled = level.playerxpenabled;
    level.challengesallowed = level.playerxpenabled || getdvarint( @"force_challenges" );
    level.enforceantiboosting = level.playerxpenabled || level.weaponxpenabled || level.challengesallowed;
    level.onlinestatsenabled = level.rankedmatch && !level.gametypebundle.var_119fa79f106f9634;
    level.var_42440e0ca1525e31 = level.gametypebundle.var_119fa79f106f9634;
    level.leagueplaymatch = level.rankedmatch && getdvarint( @"online_matchmaking_is_league_play" );
    
    /#
        level.leagueplaymatch = level.leagueplaymatch || getdvarint( @"scr_force_leagueplay", 0 );
    #/
    
    level.var_309e3d9dac389de6 = level.rankedmatch && getdvarint( @"online_matchmaking_is_league_play_br" );
    level.var_7f85d8c232d790ed = level.var_309e3d9dac389de6 && game_utility::getgametype() == "resurgence";
    level.var_29b966035bd23252 = level.gametypebundle.var_482de5aa696344bc;
    level.var_1ca6e1d1e2be7825 = level.gametypebundle.disableachievements;
    level.starttimeutcseconds = getsystemtime();
    stats::setplayerdatagroups();
    level.teambased = 0;
    println( "<dev string:x5a>" + gettime() );
    level.objectivebased = 0;
    level.endgameontimelimit = 1;
    level.showingfinalkillcam = 0;
    level.tispawndelay = getdvarint( @"scr_tispawndelay", 5 );
    level.halftimetype = "halftime";
    level.lastscorestatustime = 0;
    level.waswinning = "none";
    level.lastslowprocessframe = 0;
    level.postroundtime = 4.5;
    registerdvars();
    
    /#
        if ( getdvarint( @"hash_ff213c5a6a5e05e4", 0 ) == 1 )
        {
            thread function_58cb0ace0cb9d3bb();
        }
    #/
    
    class::function_3ffe6bf4c4104c66();
    class::function_1e64c4417c67cfa4();
    level interaction::init_interaction();
    
    if ( utility::issharedfuncdefined( #"seasonalevents", #"init" ) )
    {
        level utility::callsharedfunc( #"seasonalevents", #"init" );
    }
    
    level notify( #"hash_d4f457172265279c" );
}

// Namespace globallogic
// Params 0
// Checksum 0xdf10dff, Offset: 0x5e9
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
    thread gamelogic_mp::endgame( "draw", game[ "end_reason" ][ "host_ended_game" ] );
}

/#

    // Namespace globallogic
    // Params 0
    // Checksum 0x30a22b58, Offset: 0x65a
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
// Checksum 0x44f0ed8c, Offset: 0x69a
// Size: 0x124
function registerdvars()
{
    if ( getdvarint( @"hash_e6afce2cf5cf7515" ) != 1 )
    {
        setomnvar( "ui_nuke_end_milliseconds", 0 );
    }
    
    setdvar( @"ui_danger_team", "" );
    setdvar( @"ui_inhostmigration", 0 );
    var_5f283f68b23c4c3a = 1750;
    var_f0ad92c8d266fe75 = level.gamemodebundle.minimapmaxrange;
    
    if ( var_f0ad92c8d266fe75 > 0 )
    {
        var_5f283f68b23c4c3a = var_f0ad92c8d266fe75;
    }
    
    setdvar( @"compassmaxrange", var_5f283f68b23c4c3a );
    setdvar( @"hash_687f6fe472201df1", 1 );
    setdvar( @"hash_4e5b353bf84974a9", 1 );
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
// Checksum 0xc6710792, Offset: 0x7c6
// Size: 0x15a
function registerfalldamagedvars()
{
    if ( game_utility_mp::function_166654fc96d0736a() )
    {
        if ( getdvarint( @"bg_bristotallynormal", 0 ) )
        {
            setdvar( @"bg_falldamageminheight", 100000000 );
            setdvar( @"bg_falldamagemaxheight", 100000001 );
            setdvar( @"bg_softlandingminheight", 100000000 );
            setdvar( @"bg_softlandingmaxheight", 100000001 );
        }
        else
        {
            setdvar( @"bg_falldamageminheight", getdvarint( @"scr_submap_falldamageminheight", 225 ) );
            setdvar( @"bg_falldamagemaxheight", getdvarint( @"scr_submap_falldamagemaxheight", 560 ) );
            setdvar( @"bg_softlandingminheight", getdvarint( @"scr_submap_softlandingminheight", 225 ) );
            setdvar( @"bg_softlandingmaxheight", getdvarint( @"scr_submap_softlandingmaxheight", 560 ) );
        }
        
        return;
    }
    
    setdvar( @"bg_falldamageminheight", getdvarint( @"scr_core_falldamageminheight", 225 ) );
    setdvar( @"bg_falldamagemaxheight", getdvarint( @"scr_core_falldamagemaxheight", 375 ) );
    setdvar( @"bg_softlandingminheight", getdvarint( @"scr_core_softlandingminheight", 225 ) );
    setdvar( @"bg_softlandingmaxheight", getdvarint( @"scr_core_softlandingmaxheight", 375 ) );
}

// Namespace globallogic
// Params 0
// Checksum 0x3dae0216, Offset: 0x928
// Size: 0x22
function function_e4725b747d6d9d69()
{
    setdvar( @"lui_show_turret_overheat", 1 );
    setdvar( @"bg_turretoverheatreset", 1 );
}

// Namespace globallogic
// Params 1, eflags: 0x4
// Checksum 0x8bb54a71, Offset: 0x952
// Size: 0xc
function private do_nothing( params )
{
    
}

// Namespace globallogic
// Params 0
// Checksum 0xae670340, Offset: 0x966
// Size: 0x1c1
function setupcallbacks()
{
    setdefaultcallbacks();
    common::setupcommoncallbacks();
    level.getspawnpoint = &utility::empty_init_func;
    level.onspawnplayer = &common::onspawnplayercommon;
    level.onplayerkilledcommon = &common::onplayerkilledcommon;
    level.onrespawndelay = &utility::empty_init_func;
    level.ontimelimit = &gamelogic_mp::default_ontimelimit;
    level.onhalftime = &gamelogic_mp::default_onhalftime;
    level.ondeadevent = &gamelogic_mp::default_ondeadevent;
    level.ononeleftevent = &gamelogic_mp::default_ononeleftevent;
    level.onprecachegametype = &utility::empty_init_func;
    level.onstartgametype = &utility::empty_init_func;
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
    level.var_1d67c3e48637c5d6 = &agent_utility::function_1d67c3e48637c5d6;
    level.addtocharactersarray = &game_utility_common::addtocharactersarray;
    
    if ( level.gametypebundle.noprematch )
    {
        level.prematchallowfunc = &do_nothing;
    }
    else
    {
        level.prematchallowfunc = &playerlogic::playerprematchallow;
    }
    
    level.updategameevents = &gamelogic_mp::updategameevents;
    level.updatetimerpausedness = &gamelogic_mp::updatetimerpausedness;
    level.matchstarttimer = &gamelogic_mp::matchstarttimer;
    level.spawnintermission = &gamelogic_mp::spawnintermission_default;
    level.var_871c7d9fbeeb5187 = &gamelogic_mp::function_871c7d9fbeeb5187;
    
    if ( getbuildversion() != "SHIP" )
    {
        level.devinit = &dev_mp::init;
    }
    
    mp_agent_damage::register_ai_damage_callbacks();
}

// Namespace globallogic
// Params 0
// Checksum 0xeee97c03, Offset: 0xb2f
// Size: 0x13d
function setdefaultcallbacks()
{
    level.callbackstartgametype = &gamelogic_mp::callback_startgametype;
    level.callbackplayeractive = &playerlogic::callback_playeractive;
    level.callbackplayerconnect = &playerlogic::callback_playerconnect;
    level.callbackplayerdisconnect = &playerlogic::callback_playerdisconnect;
    level.callbackplayerdamage = &damage::callback_playerdamage;
    level.callbackplayerdamagescore = &damage::callback_playerdamagescore;
    level.callbackplayerdamageeffects = &damage_effects::callback_playerdamageeffects;
    level.callbackplayerimpaled = &damage::callback_playerimpaled;
    level.var_8f62eac141f8bdb6 = &damage::function_42649d6d0a964fbd;
    level.callbackplayerkilled = &damage::callback_playerkilled;
    level.callbackplayerlaststand = &damage::callback_playerlaststand;
    level.callbackplayermigrated = &playerlogic::callback_playermigrated;
    level.callbackhostmigration = &hostmigration::callback_hostmigration;
    level.var_c6a23d27f33a948c = &weapons::function_6831567befa159a1;
    level.callbackfinishweaponchange = &weapons::callback_finishweaponchange;
    level.callbackspawnpointprecalc = &spawnlogic::codecallbackhandler_spawnpointprecalc;
    level.callbackspawnpointscore = &spawnlogic::codecallbackhandler_spawnpointscore;
    level.callbackspawnpointcritscore = &spawnlogic::codecallbackhandler_spawnpointcritscore;
    level.var_4524771918fe585f = &playerlogic::callback_playerconnectrejoin;
    level.var_880cfcfec57ca836 = &playerlogic::function_eb57164fee20f297;
    level.var_16eab40d8f2ae445 = &playerlogic::function_b69d00f730747014;
    callback::add( #"hash_bfe74b2130bdd498", &playerlogic::function_d748b5fff3953d0c );
}

/#

    // Namespace globallogic
    // Params 2
    // Checksum 0x4ea00b11, Offset: 0xc74
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

// Namespace globallogic/event_c91584356d5d4265
// Params 0, eflags: 0x20
// Checksum 0x7f299ab3, Offset: 0xcbd
// Size: 0xc2
function event_handler[event_c91584356d5d4265] function_a8aa6906b5ff9d68()
{
    if ( flags::gameflagexists( "prematch_started" ) && flags::gameflagexists( "prematch_done" ) )
    {
        if ( flags::gameflag( "prematch_done" ) )
        {
            function_a3c0c640dcc68f63( #"hash_f72e90bffc0cd444", #"prematch done" );
        }
        else if ( flags::gameflag( "prematch_started" ) )
        {
            function_a3c0c640dcc68f63( #"hash_f72e90bffc0cd444", #"hash_9594f2e07a51c046" );
        }
        else
        {
            function_a3c0c640dcc68f63( #"hash_f72e90bffc0cd444", #"hash_b5ae7a6b849639af" );
        }
    }
    
    function_a3c0c640dcc68f63( #"hash_70dc2ff233910ed6", game_utility_mp::getgamestate() ?? #"undefined" );
    function_a3c0c640dcc68f63( #"hash_9a6c33bd4ddc8690", level.fixedspawnbots.size ?? 0 );
}

