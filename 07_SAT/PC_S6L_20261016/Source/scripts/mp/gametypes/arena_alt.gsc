// scripts\mp\gametypes\arena_alt.gsc  (hash_03d918dd819f36df.gscc) (size: 66748 Bytes / 0x104bc / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x48d7f28e (1222111886)
// size ...... 66748 (0x104bc)
// includes .. 41  (offset: 0xe588)
// strings ... 368 (offset: 0xe6d0)
// dev strs .. 27  (offset: 0x10350)
// exports ... 122 (offset: 0xa5cc)
// cseg ...... 0x1be9 + 0x89e3 (0xa5cc)
// imports ... 342 (offset: 0xb8dc)
// animtree1 . 0   (offset: 0x104bc)
// animtree2 . 0   (offset: 0x104bc)
#using scripts\common\telemetry_utils;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\weapon;
#using scripts\mp\analyticslog;
#using scripts\mp\bots\bots;
#using scripts\mp\bots\bots_util;
#using scripts\mp\class;
#using scripts\mp\common\equipment\smoke_grenade;
#using scripts\mp\common\utility\dialog;
#using scripts\mp\common\utility\dvars;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\inventory_utility;
#using scripts\mp\common\utility\outline;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\print;
#using scripts\mp\common\utility\stats;
#using scripts\mp\common\utility\team_utility;
#using scripts\mp\common\utility\teams;
#using scripts\mp\common\utility\weapon;
#using scripts\mp\damage;
#using scripts\mp\equipment;
#using scripts\mp\events;
#using scripts\mp\flags;
#using scripts\mp\gamelogic;
#using scripts\mp\gameobjects;
#using scripts\mp\gamescore;
#using scripts\mp\gametypes\arena;
#using scripts\mp\gametypes\common;
#using scripts\mp\gametypes\obj_dogtag;
#using scripts\mp\gametypes\obj_dom;
#using scripts\mp\hud_message;
#using scripts\mp\hud_util;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\persistence;
#using scripts\mp\playerhealth;
#using scripts\mp\spawnlogic;
#using scripts\mp\spawnscoring;
#using scripts\mp\spectating;
#using scripts\mp\teams;

#namespace arena_alt;

// Namespace arena_alt
// Params 0
// Checksum 0x184b91f6, Offset: 0x1c07
// Size: 0x9ca
function main()
{
    setdvar( @"scr_game_matchstarttime", 10 );
    
    /#
        setdevdvarifuninitialized( @"hash_52b2904136c93f2b", -1 );
        
        if ( !isdefined( game[ "<dev string:x24>" ] ) )
        {
            game[ "<dev string:x24>" ] = -1;
        }
        
        level thread bootcampmodewatcher();
    #/
    
    level.bots_gametype_handles_class_choice = 1;
    
    if ( !isdefined( game[ "launchChunkRuleSet" ] ) )
    {
        game[ "launchChunkWinner" ] = 0;
        game[ "launchChunkRuleSet" ] = 0;
        game[ "prevLaunchChunkRuleSet" ] = 0;
        game[ "wasHostAliveAtRoundEnd" ] = 1;
        game[ "matchStartRequiresInput" ] = 1;
    }
    else if ( game[ "launchChunkWinner" ] == 1 )
    {
        game[ "launchChunkWinner" ] = 0;
        game[ "prevLaunchChunkRuleSet" ] = game[ "launchChunkRuleSet" ];
        game[ "launchChunkRuleSet" ]++;
        level.resetstats = 1;
        game[ "matchStartRequiresInput" ] = 1;
    }
    
    /#
        if ( game[ "<dev string:x24>" ] != -1 )
        {
            game[ "<dev string:x35>" ] = 0;
            game[ "<dev string:x47>" ] = int( clamp( game[ "<dev string:x24>" ] - 1, 0, 3 ) );
            game[ "<dev string:x5e>" ] = game[ "<dev string:x24>" ];
            level.resetstats = 1;
            game[ "<dev string:x71>" ] = 1;
        }
    #/
    
    if ( game[ "launchChunkRuleSet" ] > 3 )
    {
        game[ "launchChunkRuleSet" ] = 0;
    }
    
    setdvar( @"camera_allow3rdspectate", 0 );
    thread launchchunkbotspawning();
    level.setinitialbotdifficulties = 1;
    
    switch ( game[ "launchChunkRuleSet" ] )
    {
        case 0:
            if ( !isdefined( game[ "lc_intro_zero" ] ) )
            {
                game[ "lc_intro_zero" ] = 1;
                game[ "dialog" ][ "lc_intro" ] = "lc_ffa_first";
            }
            else if ( game[ "lc_intro_zero" ] == 1 )
            {
                game[ "lc_intro_zero" ] = 2;
                game[ "dialog" ][ "lc_intro" ] = "lc_ffa_second";
            }
            else
            {
                game[ "dialog" ][ "lc_intro" ] = "lc_ffa_third";
            }
            
            setomnvar( "ui_round_hint_override_attackers", 1 );
            setomnvar( "ui_round_hint_override_defenders", 1 );
            dvars::setoverridewatchdvar( "timelimit", 180 );
            dvars::setoverridewatchdvar( "numlives", 0 );
            dvars::setoverridewatchdvar( "roundlimit", 1 );
            dvars::setoverridewatchdvar( "winlimit", 1 );
            dvars::setoverridewatchdvar( "scorelimit", 15 );
            waitthensethealthregentweakable( 6 );
            setdvar( dvars::function_1165fde71640a2d1( "pointsPerKill" ), 1 );
            setdvar( dvars::function_1165fde71640a2d1( "dogtags" ), 0 );
            setdvar( dvars::function_1165fde71640a2d1( "lethalDelay" ), 0 );
            level.scoreconfirm = 0;
            level.scoredeny = 0;
            break;
        case 1:
            if ( !isdefined( game[ "lc_intro_one" ] ) )
            {
                game[ "lc_intro_one" ] = 1;
                game[ "dialog" ][ "lc_intro" ] = "lc_arena_first";
            }
            else if ( game[ "lc_intro_one" ] == 1 )
            {
                game[ "lc_intro_one" ] = 2;
                game[ "dialog" ][ "lc_intro" ] = "lc_arena_second";
            }
            else
            {
                game[ "dialog" ][ "lc_intro" ] = "lc_arena_third";
            }
            
            setomnvar( "ui_round_hint_override_attackers", 0 );
            setomnvar( "ui_round_hint_override_defenders", 0 );
            dvars::setoverridewatchdvar( "timelimit", 40 );
            dvars::setoverridewatchdvar( "numlives", 1 );
            dvars::setoverridewatchdvar( "roundlimit", 0 );
            dvars::setoverridewatchdvar( "winlimit", 6 );
            dvars::setoverridewatchdvar( "scorelimit", 6 );
            waitthensethealthregentweakable( 0 );
            setdvar( dvars::function_1165fde71640a2d1( "pointsPerKill" ), 0 );
            setdvar( dvars::function_1165fde71640a2d1( "dogtags" ), 0 );
            setdvar( dvars::function_1165fde71640a2d1( "lethalDelay" ), 5 );
            level.overridetimelimitclock = 10;
            level.setinitialbotdifficulties = 0;
            break;
        case 2:
            if ( !isdefined( game[ "lc_intro_two" ] ) )
            {
                game[ "lc_intro_two" ] = 1;
                game[ "dialog" ][ "lc_intro" ] = "lc_pos_first";
            }
            else if ( game[ "lc_intro_two" ] == 1 )
            {
                game[ "lc_intro_two" ] = 2;
                game[ "dialog" ][ "lc_intro" ] = "lc_pos_second";
            }
            else
            {
                game[ "dialog" ][ "lc_intro" ] = "lc_pos_third";
            }
            
            setomnvar( "ui_round_hint_override_attackers", 0 );
            setomnvar( "ui_round_hint_override_defenders", 0 );
            dvars::setoverridewatchdvar( "timelimit", 40 );
            dvars::setoverridewatchdvar( "numlives", 1 );
            dvars::setoverridewatchdvar( "roundlimit", 0 );
            dvars::setoverridewatchdvar( "winlimit", 6 );
            dvars::setoverridewatchdvar( "scorelimit", 6 );
            waitthensethealthregentweakable( 0 );
            setdvar( dvars::function_1165fde71640a2d1( "pointsPerKill" ), 0 );
            setdvar( dvars::function_1165fde71640a2d1( "dogtags" ), 0 );
            setdvar( dvars::function_1165fde71640a2d1( "lethalDelay" ), 5 );
            level.overridetimelimitclock = 10;
            level.setinitialbotdifficulties = 0;
            break;
        case 3:
            if ( !isdefined( game[ "lc_intro_three" ] ) )
            {
                game[ "lc_intro_three" ] = 1;
                game[ "dialog" ][ "lc_intro" ] = "lc_conf_first";
            }
            else if ( game[ "lc_intro_three" ] == 1 )
            {
                game[ "lc_intro_three" ] = 2;
                game[ "dialog" ][ "lc_intro" ] = "lc_conf_second";
            }
            else
            {
                game[ "dialog" ][ "lc_intro" ] = "lc_conf_third";
            }
            
            setomnvar( "ui_round_hint_override_attackers", 2 );
            setomnvar( "ui_round_hint_override_defenders", 2 );
            dvars::setoverridewatchdvar( "timelimit", 180 );
            dvars::setoverridewatchdvar( "numlives", 0 );
            dvars::setoverridewatchdvar( "roundlimit", 1 );
            dvars::setoverridewatchdvar( "winlimit", 1 );
            dvars::setoverridewatchdvar( "scorelimit", 20 );
            waitthensethealthregentweakable( 6 );
            setdvar( dvars::function_1165fde71640a2d1( "pointsPerKill" ), 0 );
            setdvar( dvars::function_1165fde71640a2d1( "dogtags" ), 1 );
            setdvar( dvars::function_1165fde71640a2d1( "lethalDelay" ), 0 );
            level.scoreconfirm = 1;
            level.scoredeny = 0;
            break;
        default:
            break;
    }
    
    updategametypedvars();
    
    if ( israndompreviewloadouts() )
    {
        level.ispreviewbuild = 1;
        level.previewbuildfirstallies = 1;
        level.previewbuildfirstaxis = 1;
    }
    
    setdvar( @"party_maxplayers", 4 );
    level.teambased = 1;
    level.objectivebased = 1;
    level.ontimelimit = &ontimelimit;
    level.onstartgametype = &onstartgametype;
    level.onplayerconnect = &onplayerconnect;
    level.getspawnpoint = &getspawnpoint;
    level.onplayerdamaged = &onplayerdamaged;
    level.onnormaldeath = &onnormaldeath;
    level.onplayerkilled = &onplayerkilled;
    level.modeonspawnplayer = &onspawnplayer;
    level.ondeadevent = &ondeadevent;
    level.ontimelimitot = &ontimelimitot;
    level.droplaunchchunkbots = &droplaunchchunkbots;
    level.modifyplayerdamage = &damage::gamemodemodifyplayerdamage;
    level.allowlatecomers = 0;
    
    if ( !game_utility_mp::iswinbytworulegametype() )
    {
        level.skipdefendersadvantage = 1;
    }
    
    level.disablecopycatloadout = 1;
    setomnvar( "ui_killcam_copycat", 0 );
    level.bypassclasschoicefunc = &class::alwaysgamemodeclass;
    game[ "dialog" ][ "gametype" ] = "iw9_gnft_mode_uktl_gfnm";
    
    if ( ispickuploadouts() && !isdefined( game[ "roundsPlayed" ] ) )
    {
        game[ "dialog" ][ "offense_obj" ] = "boost_arena_pickups";
        game[ "dialog" ][ "defense_obj" ] = "boost_arena_pickups";
    }
    else if ( level.objmodifier == 1 && !isdefined( game[ "roundsPlayed" ] ) )
    {
        game[ "dialog" ][ "offense_obj" ] = "boost_arena_objective";
        game[ "dialog" ][ "defense_obj" ] = "boost_arena_objective";
    }
    else
    {
        game[ "dialog" ][ "offense_obj" ] = "iw9_gnft_mode_uktl_gfbo";
        game[ "dialog" ][ "defense_obj" ] = "iw9_gnft_mode_uktl_gfbo";
    }
    
    game[ "dialog" ][ "obj_indepth" ] = "boost_arena_indepth";
    game[ "dialog" ][ "securing_a" ] = "iw9_gnft_mode_uktl_gfsg";
    game[ "dialog" ][ "secured_a" ] = "iw9_gnft_mode_uktl_gfsd";
    game[ "dialog" ][ "losing_a" ] = "iw9_gnft_mode_uktl_gflg";
    game[ "dialog" ][ "lost_a" ] = "iw9_gnft_mode_uktl_gflt";
    game[ "dialog" ][ "round_success" ] = "round_win";
    game[ "dialog" ][ "round_failure" ] = "round_lose";
    game[ "dialog" ][ "mission_success" ] = "gamestate_win";
    game[ "dialog" ][ "mission_failure" ] = "gamestate_lost";
    level.usedspawnposone = 0;
    level.usedspawnpostwo = 0;
    level.usedspawnposthree = 0;
    hud_message::function_e369cd82a03687e0();
    setomnvar( "ui_arena_primaryVariantID", -1 );
    setomnvar( "ui_arena_secondaryVariantID", -1 );
    
    if ( game[ "launchChunkRuleSet" ] == 0 )
    {
        game[ "dialog" ][ "gametype" ] = "gametype_ffa";
        game[ "dialog" ][ "boost" ] = "boost_tdm";
        game[ "dialog" ][ "offense_obj" ] = "boost_tdm";
        game[ "dialog" ][ "defense_obj" ] = "boost_tdm";
        return;
    }
    
    if ( game[ "launchChunkRuleSet" ] == 3 )
    {
        game[ "dialog" ][ "gametype" ] = "gametype_killconfirmed";
        game[ "dialog" ][ "boost" ] = "boost_killconfirmed";
        game[ "dialog" ][ "offense_obj" ] = "boost_killconfirmed";
        game[ "dialog" ][ "defense_obj" ] = "boost_killconfirmed";
        game[ "dialog" ][ "kill_confirmed" ] = "kill_confirmed";
    }
}

// Namespace arena_alt
// Params 1
// Checksum 0xb7042d4f, Offset: 0x25d9
// Size: 0x17
function waitthensethealthregentweakable( healthregendelay )
{
    level.healthregendelay = healthregendelay;
}

// Namespace arena_alt
// Params 0
// Checksum 0x9b7868c4, Offset: 0x25f8
// Size: 0x94
function launchchunkbotspawning()
{
    level waittill( #"spawned_player" );
    
    switch ( game[ "launchChunkRuleSet" ] )
    {
        case 0:
            level.launchchunkfreespawn = 0;
            break;
        case 1:
            level.launchchunkfreespawn = 1;
            break;
        case 2:
            level.launchchunkfreespawn = 1;
            break;
        case 3:
            level.launchchunkfreespawn = 1;
            break;
        default:
            break;
    }
}

// Namespace arena_alt
// Params 0
// Checksum 0xd1a6d54c, Offset: 0x2694
// Size: 0x1e5
function initializematchrules()
{
    game_utility_mp::setcommonrulesfrommatchrulesdata();
    setdynamicdvar( @"scr_arena_arenaloadouts", getmatchrulesdata( "arenaData", "arenaLoadouts" ) );
    setdynamicdvar( @"scr_arena_loadoutchangeround", getmatchrulesdata( "arenaData", "loadoutChangeRound" ) );
    setdynamicdvar( @"scr_arena_switchspawns", getmatchrulesdata( "arenaData", "switchSpawns" ) );
    setdynamicdvar( @"scr_arena_wincondition", getmatchrulesdata( "arenaData", "winCondition" ) );
    setdynamicdvar( @"scr_arena_objmodifier", getmatchrulesdata( "arenaData", "objModifier" ) );
    setdynamicdvar( @"scr_arena_spawnflag", getmatchrulesdata( "arenaData", "spawnFlag" ) );
    setdynamicdvar( @"scr_arena_flagcapturetime", getmatchrulesdata( "domData", "flagCaptureTime" ) );
    setdynamicdvar( @"scr_arena_tacticaltimemod", getmatchrulesdata( "arenaData", "tacticalTimeMod" ) );
    setdynamicdvar( @"scr_arena_startweapon", getmatchrulesdata( "arenaData", "startWeapon" ) );
    setdynamicdvar( @"scr_arena_weapontier1", getmatchrulesdata( "arenaData", "weaponTier1" ) );
    setdynamicdvar( @"scr_arena_weapontier2", getmatchrulesdata( "arenaData", "weaponTier2" ) );
    setdynamicdvar( @"scr_arena_weapontier3", getmatchrulesdata( "arenaData", "weaponTier3" ) );
    setdynamicdvar( @"scr_arena_weapontier4", getmatchrulesdata( "arenaData", "weaponTier4" ) );
    setdynamicdvar( @"scr_arena_weapontier5", getmatchrulesdata( "arenaData", "weaponTier5" ) );
    setdynamicdvar( @"scr_arena_weapontier6", getmatchrulesdata( "arenaData", "weaponTier6" ) );
    setdynamicdvar( @"scr_arena_weapontier7", getmatchrulesdata( "arenaData", "weaponTier7" ) );
    setdynamicdvar( @"scr_arena_weapontier8", getmatchrulesdata( "arenaData", "weaponTier8" ) );
}

// Namespace arena_alt
// Params 0
// Checksum 0x7bd51435, Offset: 0x2881
// Size: 0x2ee
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
    
    initspawns();
    thread adjustroundendtimer();
    thread waittooverridegraceperiod();
    
    if ( israndomloadouts() || israndompreviewloadouts() || israndomalphaloadouts() )
    {
        thread updaterandomloadout();
    }
    else if ( ispickuploadouts() )
    {
        level.lethaldelay = 0;
        defineplayerloadout();
        initweaponmap();
        thread setupweapons();
    }
    else if ( isgungameloadouts() )
    {
        level.blockweapondrops = 1;
        thread arena::updatearenagungameloadout( 0 );
    }
    else if ( isrvsgungameloadouts() )
    {
        level.blockweapondrops = 1;
        thread arena::updatearenagungameloadout( 1 );
    }
    
    buildloadoutsforweaponstreaming();
    setupwaypointicons();
    seticonnames();
    
    if ( level.objmodifier == 1 )
    {
        level setupendzones();
    }
    
    ispreview = 0;
    
    switch ( game[ "launchChunkRuleSet" ] )
    {
        case 0:
            break;
        case 1:
            if ( !flags::gameflag( "prematch_done" ) && game[ "roundsPlayed" ] == 0 )
            {
                ispreview = 1;
            }
            
            break;
        case 2:
            break;
        case 3:
            break;
        default:
            break;
    }
    
    level thread arena::spawngameendflagzone();
    updatetournamentroundtime( gamelogic_mp::gettimeremaining(), 0 );
    
    if ( !flags::gameflag( "prematch_done" ) )
    {
        if ( game[ "roundsPlayed" ] == 0 )
        {
            if ( game[ "launchChunkRuleSet" ] == 0 && game[ "prevLaunchChunkRuleSet" ] != 3 )
            {
                level thread outlineenemyplayerslaunchchunk();
            }
            else
            {
                level thread outlineenemyplayers();
                level thread removeenemyoutlines();
            }
        }
    }
    
    setdvar( @"scr_disableperks", 1 );
}

// Namespace arena_alt
// Params 0
// Checksum 0x69e225f4, Offset: 0x2b77
// Size: 0x31
function droplaunchchunkbots()
{
    if ( game[ "chunkBotsSpawned" ] )
    {
        game[ "chunkBotsSpawned" ] = 0;
        bots::drop_bots( 1, "allies" );
        bots::drop_bots( 1, "axis" );
    }
}

// Namespace arena_alt
// Params 0
// Checksum 0xae5618fe, Offset: 0x2bb0
// Size: 0x4d
function tryspawnlaunchchunkbots()
{
    if ( game[ "chunkBotsSpawned" ] )
    {
        return;
    }
    
    level thread bots::spawn_bots( 1, "allies", undefined, undefined, "spawned_allies", "recruit" );
    level thread bots::spawn_bots( 1, "axis", undefined, undefined, "spawned_enemies", "recruit" );
    game[ "chunkBotsSpawned" ] = 1;
}

// Namespace arena_alt
// Params 0
// Checksum 0x78305999, Offset: 0x2c05
// Size: 0x24
function waittooverridegraceperiod()
{
    flags::gameflagwait( "prematch_done" );
    level.overrideingraceperiod = 1;
    level.ingraceperiod = 5;
}

// Namespace arena_alt
// Params 0
// Checksum 0xc8f4268f, Offset: 0x2c31
// Size: 0x13
function adjustroundendtimer()
{
    wait 1;
    level.roundenddelay = 4;
}

// Namespace arena_alt
// Params 0
// Checksum 0xefc818f3, Offset: 0x2c4c
// Size: 0x660
function updategametypedvars()
{
    common::updatecommongametypedvars();
    
    if ( game[ "launchChunkRuleSet" ] == 3 )
    {
        level.dogtagallyonusecb = &dogtagallyonusecbconf;
        level.dogtagenemyonusecb = &dogtagenemyonusecbconf;
    }
    else if ( obj_dogtag::dogtagsenabled() )
    {
        level.dogtagallyonusecb = &dogtagallyonusecb;
        level.dogtagenemyonusecb = &dogtagenemyonusecb;
    }
    
    level.arenaloadouts = 2;
    level.loadoutchangeround = dvars::dvarintvalue( "loadoutChangeRound", 3, 0, 5 );
    level.switchspawns = dvars::dvarintvalue( "switchSpawns", 1, 0, 1 );
    level.wincondition = dvars::dvarintvalue( "winCondition", 1, 0, 2 );
    setomnvar( "ui_arena_loadout_type", level.arenaloadouts );
    setomnvar( "ui_wincondition", level.wincondition );
    level.objmodifier = dvars::dvarintvalue( "objModifier", 0, 0, 1 );
    level.spawnflag = dvars::dvarintvalue( "spawnFlag", 0, 0, 1 );
    
    if ( game[ "launchChunkRuleSet" ] != 1 && game[ "launchChunkRuleSet" ] != 2 )
    {
        level.spawnflag = 0;
    }
    else if ( level.spawnflag )
    {
        level.ontimelimitgraceperiod = 10;
        level.currenttimelimitdelay = 0;
        level.canprocessot = 1;
    }
    
    level.tacticaltimemod = dvars::dvarfloatvalue( "tacticalTimeMod", 2.5, 0.5, 5 );
    level.startweapon = getdvar( @"scr_arena_startweapon", "none" );
    level.arenaweapont1 = getdvar( @"scr_arena_weapontier1", "iw8_pi_golf21_mp" );
    level.arenaweapont2 = getdvar( @"scr_arena_weapontier2", "iw8_sh_dpapa12_mp" );
    level.arenaweapont3 = getdvar( @"scr_arena_weapontier3", "iw8_sm_mpapa5_mp" );
    level.arenaweapont4 = getdvar( @"scr_arena_weapontier4", "iw8_ar_mike4_mp" );
    level.arenaweapont5 = getdvar( @"scr_arena_weapontier5", "iw8_sn_alpha50_mp" );
    level.arenaweapont6 = getdvar( @"scr_arena_weapontier6", "equip_frag" );
    level.arenaweapont7 = getdvar( @"scr_arena_weapontier7", "equip_concussion" );
    level.arenaweapont8 = getdvar( @"scr_arena_weapontier8", "equip_adrenaline" );
    
    if ( game[ "launchChunkRuleSet" ] == 2 )
    {
        level.arenaloadouts = 3;
        level.loadoutchangeround = 3;
        level.startweapon = "none";
        level.arenaweapont1 = "rand_pistol";
        level.arenaweapont2 = "random";
        level.arenaweapont3 = "rand_smg";
        level.arenaweapont4 = "rand_assault";
        level.arenaweapont5 = "rand_sniper";
        level.arenaweapont6 = "rand_lethal";
        level.arenaweapont7 = "rand_tactical";
        level.arenaweapont8 = "random";
        level thread botpickuphack();
    }
    
    if ( ispickuploadouts() )
    {
        function_22a3a367a2650a98();
        
        if ( !isdefined( game[ "roundsPlayed" ] ) || game[ "roundsPlayed" ] == 0 )
        {
            level.startweapon = getrandomweaponforweapontier( level.startweapon );
            level.arenaweapont1 = getrandomweaponforweapontier( level.arenaweapont1 );
            level.arenaweapont2 = getrandomweaponforweapontier( level.arenaweapont2 );
            level.arenaweapont3 = getrandomweaponforweapontier( level.arenaweapont3 );
            level.arenaweapont4 = getrandomweaponforweapontier( level.arenaweapont4 );
            level.arenaweapont5 = getrandomweaponforweapontier( level.arenaweapont5 );
            level.arenaweapont6 = getrandomweaponforweapontier( level.arenaweapont6 );
            level.arenaweapont7 = getrandomweaponforweapontier( level.arenaweapont7 );
            level.arenaweapont8 = getrandomweaponforweapontier( level.arenaweapont8 );
        }
        else if ( level.loadoutchangeround == 0 || game[ "roundsPlayed" ] % level.loadoutchangeround != 0 )
        {
            level.startweapon = game[ "startWeapon" ];
            level.arenaweapont1 = game[ "arenaWeaponT1" ];
            level.arenaweapont2 = game[ "arenaWeaponT2" ];
            level.arenaweapont3 = game[ "arenaWeaponT3" ];
            level.arenaweapont4 = game[ "arenaWeaponT4" ];
            level.arenaweapont5 = game[ "arenaWeaponT5" ];
            level.arenaweapont6 = game[ "arenaWeaponT6" ];
            level.arenaweapont7 = game[ "arenaWeaponT7" ];
            level.arenaweapont8 = game[ "arenaWeaponT8" ];
        }
        else if ( game[ "roundsPlayed" ] % level.loadoutchangeround == 0 )
        {
            level.startweapon = getrandomweaponforweapontier( level.startweapon );
            level.arenaweapont1 = getrandomweaponforweapontier( level.arenaweapont1 );
            level.arenaweapont2 = getrandomweaponforweapontier( level.arenaweapont2 );
            level.arenaweapont3 = getrandomweaponforweapontier( level.arenaweapont3 );
            level.arenaweapont4 = getrandomweaponforweapontier( level.arenaweapont4 );
            level.arenaweapont5 = getrandomweaponforweapontier( level.arenaweapont5 );
            level.arenaweapont6 = getrandomweaponforweapontier( level.arenaweapont6 );
            level.arenaweapont7 = getrandomweaponforweapontier( level.arenaweapont7 );
            level.arenaweapont8 = getrandomweaponforweapontier( level.arenaweapont8 );
        }
        
        game[ "startWeapon" ] = level.startweapon;
        game[ "arenaWeaponT1" ] = level.arenaweapont1;
        game[ "arenaWeaponT2" ] = level.arenaweapont2;
        game[ "arenaWeaponT3" ] = level.arenaweapont3;
        game[ "arenaWeaponT4" ] = level.arenaweapont4;
        game[ "arenaWeaponT5" ] = level.arenaweapont5;
        game[ "arenaWeaponT6" ] = level.arenaweapont6;
        game[ "arenaWeaponT7" ] = level.arenaweapont7;
        game[ "arenaWeaponT8" ] = level.arenaweapont8;
    }
}

// Namespace arena_alt
// Params 1
// Checksum 0xbec4820d, Offset: 0x32b4
// Size: 0x3c
function getrandomweaponforweapontier( weapontier )
{
    if ( issubstr( weapontier, "rand" ) )
    {
        if ( weapontier == "random" )
        {
            weapontier = getrandomspawnweapon();
        }
        else
        {
            weapontier = function_95b533a3974a91c( weapontier );
        }
    }
    
    return weapontier;
}

// Namespace arena_alt
// Params 0
// Checksum 0xa0a923f0, Offset: 0x32f9
// Size: 0x1e0
function initspawns()
{
    spawnlogic::function_6dbabb72223a4bca();
    spawnlogic::setactivespawnlogic( #"start" );
    var_f98cbc84b814b759 = spawnlogic::getspawnpointarray( "mp_arena_spawn_allies_start" );
    var_e52ab5709cd555a4 = spawnlogic::getspawnpointarray( "mp_arena_spawn_axis_start" );
    arenaspawns = spawnlogic::getspawnpointarray( "mp_arena_spawn" );
    
    if ( var_f98cbc84b814b759.size > 0 || var_e52ab5709cd555a4.size > 0 )
    {
        spawnlogic::addstartspawnpoints( "mp_arena_spawn_allies_start" );
        spawnlogic::addstartspawnpoints( "mp_arena_spawn_axis_start" );
        level.alliesstartspawn = "mp_arena_spawn_allies_start";
        level.axisstartspawn = "mp_arena_spawn_axis_start";
        
        /#
            validatespawns( "<dev string:x89>" );
            validatespawns( "<dev string:xa5>" );
        #/
    }
    else
    {
        spawnlogic::addstartspawnpoints( "mp_sd_spawn_attacker" );
        spawnlogic::addstartspawnpoints( "mp_sd_spawn_defender" );
        level.alliesstartspawn = "mp_sd_spawn_attacker";
        level.axisstartspawn = "mp_sd_spawn_defender";
        
        /#
            validatespawns( "<dev string:xbf>" );
            validatespawns( "<dev string:xd4>" );
        #/
    }
    
    if ( arenaspawns.size > 0 )
    {
        spawnlogic::addspawnpointslegacy( "allies", "mp_arena_spawn" );
        spawnlogic::addspawnpointslegacy( "axis", "mp_arena_spawn" );
        level.spawntype = "mp_arena_spawn";
    }
    else
    {
        arenaspawns = spawnlogic::getspawnpointarray( "mp_tdm_spawn" );
        
        if ( arenaspawns.size > 0 )
        {
            spawnlogic::addspawnpointslegacy( "allies", "mp_tdm_spawn" );
            spawnlogic::addspawnpointslegacy( "axis", "mp_tdm_spawn" );
            level.spawntype = "mp_tdm_spawn";
        }
        else
        {
            level.alwaysusestartspawns = 1;
        }
    }
    
    if ( !level.alwaysusestartspawns )
    {
        spawnlogic::registerspawnset( #"primary", level.spawntype );
        spawnlogic::registerspawnset( #"fallback", level.spawntype );
    }
    
    spawnlogic::finalizemap();
}

// Namespace arena_alt
// Params 1
// Checksum 0x468e6652, Offset: 0x34e1
// Size: 0x1e2
function validatespawns( spawnpointname )
{
    found_1 = 0;
    found_2 = 0;
    found_3 = 0;
    assign_noteworthy = 0;
    spawnpoints = spawnlogic::getspawnpointarray( spawnpointname );
    
    foreach ( s in spawnpoints )
    {
        if ( isdefined( s.script_noteworthy ) )
        {
            if ( !found_1 )
            {
                found_1 = s.script_noteworthy == "1";
            }
            else
            {
                assert( s.script_noteworthy != "<dev string:xe9>", "<dev string:xeb>" );
            }
            
            if ( !found_2 )
            {
                found_2 = s.script_noteworthy == "2";
            }
            else
            {
                assert( s.script_noteworthy != "<dev string:x129>", "<dev string:x12b>" );
            }
            
            if ( !found_3 )
            {
                found_3 = s.script_noteworthy == "3";
                level.hasthreespawns = 1;
            }
            else
            {
                assert( s.script_noteworthy != "<dev string:x169>", "<dev string:x16b>" );
            }
            
            continue;
        }
        
        if ( assign_noteworthy == 0 )
        {
            s.script_noteworthy = "1";
            assign_noteworthy++;
            continue;
        }
        
        if ( assign_noteworthy == 1 )
        {
            s.script_noteworthy = "2";
            assign_noteworthy++;
            continue;
        }
        
        if ( assign_noteworthy == 2 )
        {
            s.script_noteworthy = "3";
            assign_noteworthy++;
            level.hasthreespawns = 1;
        }
    }
}

// Namespace arena_alt
// Params 0
// Checksum 0x543e033a, Offset: 0x36cb
// Size: 0x591
function getspawnpoint()
{
    spawnpoint = undefined;
    spawnpointname = level.axisstartspawn;
    var_b1d9e95e9e5d7048 = 0;
    var_c9f716afc911f724 = 0;
    
    if ( self.pers[ "team" ] == game[ "attackers" ] )
    {
        spawnpointname = level.alliesstartspawn;
    }
    
    if ( spawnlogic::shoulduseteamstartspawn() || level.alwaysusestartspawns || isintournament() )
    {
        spawnpoints = spawnlogic::getspawnpointarray( spawnpointname );
        assert( spawnpoints.size );
        
        if ( level.switchspawns && game[ "roundsPlayed" ] > 0 )
        {
            var_a42dcb9b957e3148 = teams::getteamcount( self.pers[ "team" ] );
            
            if ( var_a42dcb9b957e3148 > 3 )
            {
                foreach ( player in teams::getteamdata( self.pers[ "team" ], "players" ) )
                {
                    if ( isdefined( player.pers[ "arena_spawn_pos" ] ) )
                    {
                        player.pers[ "arena_spawn_pos" ] = "0";
                    }
                }
                
                var_c9f716afc911f724 = 1;
            }
        }
        
        if ( level.switchspawns && game[ "roundsPlayed" ] > 0 && !var_c9f716afc911f724 )
        {
            if ( self.pers[ "arena_spawn_pos" ] == "1" )
            {
                self.pers[ "arena_spawn_pos" ] = "2";
            }
            else if ( teams::getteamcount( self.pers[ "team" ], 0 ) == 3 && level.hasthreespawns && self.pers[ "arena_spawn_pos" ] == "2" )
            {
                self.pers[ "arena_spawn_pos" ] = "3";
            }
            else if ( self.pers[ "arena_spawn_pos" ] == "3" )
            {
                self.pers[ "arena_spawn_pos" ] = "1";
            }
            else
            {
                self.pers[ "arena_spawn_pos" ] = "1";
            }
            
            spawnpoint = getswitchside_spawnpoint( spawnpoints, self.pers[ "arena_spawn_pos" ] );
        }
        
        if ( !isdefined( spawnpoint ) )
        {
            if ( self.switching_teams_arena && isdefined( self.pers[ "arena_spawn_pos" ] ) )
            {
                cleanupspawn_scriptnoteworthy();
                spawnpoint = getspawnpoint_startspawn( spawnpoints );
                self.switching_teams_arena = undefined;
            }
            else
            {
                spawnpoint = getspawnpoint_startspawn( spawnpoints );
            }
            
            if ( !isdefined( spawnpoint ) )
            {
                var_a42dcb9b957e3148 = teams::getteamcount( self.pers[ "team" ] );
                
                if ( var_a42dcb9b957e3148 > 3 )
                {
                    buddyspawnplayer = undefined;
                    
                    foreach ( player in teams::getteamdata( self.pers[ "team" ], "players" ) )
                    {
                        if ( isdefined( player.pers[ "arena_spawn_pos" ] ) )
                        {
                            if ( level.usedspawnposone == 1 && level.usedspawnposone == 1 && level.usedspawnposthree == 1 )
                            {
                                level.usedspawnposone = 0;
                                level.usedspawnpostwo = 0;
                                level.usedspawnposthree = 0;
                            }
                            
                            if ( player.pers[ "arena_spawn_pos" ] == "1" && level.usedspawnposone == 0 )
                            {
                                level.usedspawnposone++;
                                buddyspawnplayer = player;
                                break;
                            }
                            
                            if ( player.pers[ "arena_spawn_pos" ] == "2" && level.usedspawnpostwo == 0 )
                            {
                                level.usedspawnpostwo++;
                                buddyspawnplayer = player;
                                break;
                            }
                            
                            if ( player.pers[ "arena_spawn_pos" ] == "3" && level.usedspawnposthree == 0 )
                            {
                                level.usedspawnposthree++;
                                buddyspawnplayer = player;
                                break;
                            }
                            
                            level.usedspawnposone++;
                            buddyspawnplayer = player;
                            break;
                        }
                    }
                    
                    if ( isdefined( buddyspawnplayer ) )
                    {
                        spawnpoint = spawnscoring::findteammatebuddyspawn( buddyspawnplayer );
                        var_b1d9e95e9e5d7048 = 1;
                    }
                }
            }
            
            if ( level.switchspawns && game[ "roundsPlayed" ] == 0 && !var_b1d9e95e9e5d7048 )
            {
                assert( isdefined( spawnpoint.script_noteworthy ) && ( spawnpoint.script_noteworthy == "<dev string:xe9>" || spawnpoint.script_noteworthy == "<dev string:x129>" || spawnpoint.script_noteworthy == "<dev string:x169>" ) );
                self.pers[ "arena_spawn_pos" ] = spawnpoint.script_noteworthy;
            }
        }
    }
    else
    {
        spawnlogic::activatespawnset( #"primary" );
        spawnpoint = spawnlogic::getspawnpointlegacy( self, self.pers[ "team" ], #"primary", #"fallback" );
    }
    
    return spawnpoint;
}

// Namespace arena_alt
// Params 0
// Checksum 0xce4011b9, Offset: 0x3c65
// Size: 0x25c
function cleanupspawn_scriptnoteworthy()
{
    otherteam = team_utility::getotherteam( self.pers[ "team" ] );
    
    if ( otherteam == game[ "attackers" ] )
    {
        spawnpointname = level.alliesstartspawn;
        var_4579c9e04b409f85 = level.axisstartspawn;
    }
    else
    {
        spawnpointname = level.axisstartspawn;
        var_4579c9e04b409f85 = level.alliesstartspawn;
    }
    
    var_c2e89f5b3a03dfab = spawnlogic::getspawnpointarray( spawnpointname );
    assert( var_c2e89f5b3a03dfab.size );
    
    foreach ( s in var_c2e89f5b3a03dfab )
    {
        if ( s.script_noteworthy == self.pers[ "arena_spawn_pos" ] )
        {
            s.selected = 0;
        }
    }
    
    var_c2e89f5b3a03dfab = spawnlogic::getspawnpointarray( var_4579c9e04b409f85 );
    assert( var_c2e89f5b3a03dfab.size );
    
    foreach ( s in var_c2e89f5b3a03dfab )
    {
        foreach ( player in teams::getteamdata( self.pers[ "team" ], "players" ) )
        {
            if ( player != self && isdefined( player.pers[ "arena_spawn_pos" ] ) && s.script_noteworthy != player.pers[ "arena_spawn_pos" ] )
            {
                s.selected = 0;
            }
        }
    }
}

// Namespace arena_alt
// Params 2
// Checksum 0xd77e97f, Offset: 0x3ec9
// Size: 0x112
function getspawnpoint_startspawn( spawnpoints, onlyunselected )
{
    if ( !isdefined( spawnpoints ) )
    {
        return;
    }
    
    bestspawn = undefined;
    spawnpoints = spawnscoring::checkdynamicspawns( spawnpoints );
    
    foreach ( spawnpoint in spawnpoints )
    {
        if ( !isdefined( spawnpoint.selected ) )
        {
            continue;
        }
        
        if ( spawnpoint.selected )
        {
            continue;
        }
        
        if ( spawnpoint.script_noteworthy == "1" )
        {
            bestspawn = spawnpoint;
            break;
        }
        else if ( spawnpoint.script_noteworthy == "2" )
        {
            bestspawn = spawnpoint;
            break;
        }
        
        bestspawn = spawnpoint;
    }
    
    if ( isdefined( bestspawn ) )
    {
        bestspawn.selected = 1;
    }
    
    return bestspawn;
}

// Namespace arena_alt
// Params 2
// Checksum 0x35536c0d, Offset: 0x3fe4
// Size: 0xda
function getswitchside_spawnpoint( spawnpoints, spawnnoteworthy )
{
    if ( !isdefined( spawnpoints ) )
    {
        return;
    }
    
    var_1b638c7202eecb86 = 0;
    
    foreach ( spawnpoint in spawnpoints )
    {
        if ( spawnpoint.script_noteworthy == spawnnoteworthy )
        {
            if ( spawnpoint.selected )
            {
                var_1b638c7202eecb86 = 1;
                continue;
            }
            
            spawnpoint.selected = 1;
            return spawnpoint;
        }
    }
    
    assert( var_1b638c7202eecb86 == 1, "<dev string:x1a9>" );
}

// Namespace arena_alt
// Params 1
// Checksum 0xfeb353d7, Offset: 0x40c7
// Size: 0x15f
function onplayerconnect( player )
{
    level.bots_gametype_handles_class_choice = 1;
    
    if ( level.resetstats )
    {
        player resetpersstats();
    }
    
    player.arenadamage = 0;
    player stats::setextrascore0( player.pers[ "damage" ] ?? 0, "damage" );
    player class::function_e84a99f0f4904c66();
    player setclientomnvar( "ui_launch_chunk_phase", 0 );
    
    if ( !game[ "chunkFirstAssigned" ] )
    {
        player.pers[ "gamemodeLoadout" ] = level.chunkloadouts[ 3 ];
        game[ "chunkFirstAssigned" ] = 1;
    }
    else if ( israndomloadouts() || israndompreviewloadouts() || israndomalphaloadouts() )
    {
        player.pers[ "gamemodeLoadout" ] = game[ "arenaRandomLoadout" ][ game[ "arenaRandomLoadoutIndex" ] ];
    }
    else if ( ispickuploadouts() )
    {
        player.pers[ "gamemodeLoadout" ] = level.arena_loadouts[ "axis" ];
    }
    
    if ( level.switchspawns && !isdefined( player.pers[ "arena_spawn_pos" ] ) )
    {
        player.pers[ "arena_spawn_pos" ] = "0";
    }
    
    player thread teams::onjoinedteam();
    player common::updatehighpriorityweapons();
}

// Namespace arena_alt
// Params 0
// Checksum 0x5a428de4, Offset: 0x422e
// Size: 0x136
function resetpersstats()
{
    self.pers[ "score" ] = 0;
    self.pers[ "kills" ] = 0;
    self.pers[ "deaths" ] = 0;
    self.pers[ "suicides" ] = 0;
    self.pers[ "headshots" ] = 0;
    self.pers[ "assists" ] = 0;
    self.pers[ "captures" ] = 0;
    self.pers[ "confirmed" ] = 0;
    self.pers[ "denied" ] = 0;
    self.pers[ "extrascore0" ] = 0;
    self.pers[ "extrascore1" ] = 0;
    self.pers[ "extrascore2" ] = 0;
    self.pers[ "damage" ] = 0;
    self.pers[ "gamemodeScore" ] = 0;
    self.score = 0;
    self.kills = 0;
    self.deaths = 0;
    self.assists = 0;
    self.extrascore0 = 0;
    self.extrascore1 = 0;
    self.extrascore2 = 0;
}

// Namespace arena_alt
// Params 1
// Checksum 0x72287702, Offset: 0x436c
// Size: 0x26
function onspawnplayer( revivespawn )
{
    thread onspawnfinished();
    level notify( #"spawned_player" );
    thread updatematchstatushintonspawn();
}

// Namespace arena_alt
// Params 0
// Checksum 0x86b1875c, Offset: 0x439a
// Size: 0x29
function hackthread()
{
    self notifyonplayercommand( "hack_notify", "+gostand" );
    self notifyonplayercommand( "hack_notify", "+usereload" );
    thread hackwatcher();
}

// Namespace arena_alt
// Params 0
// Checksum 0xa9e25d47, Offset: 0x43cb
// Size: 0x6f
function hackwatcher()
{
    level endon( #"game_ended" );
    self waittill( #"hack_notify" );
    self notify( #"luinotifyserver", "class_select", 2 );
    level notify( #"hash_c2ba6f5e09e6a9a0" );
    self setclientomnvar( "ui_launch_chunk_phase", 0 );
    game[ "matchStartRequiresInput" ] = 0;
    self notifyonplayercommandremove( "hack_notify", "+gostand" );
    self notifyonplayercommandremove( "hack_notify", "+usereload" );
}

// Namespace arena_alt
// Params 0
// Checksum 0xad295091, Offset: 0x4442
// Size: 0x3e6
function onspawnfinished()
{
    self endon( #"death_or_disconnect" );
    
    /#
        if ( getdvarint( @"hash_d657640801ffcf07", 0 ) == 1 )
        {
            game[ "<dev string:x71>" ] = 0;
            level notify( #"hash_c2ba6f5e09e6a9a0" );
        }
    #/
    
    if ( game[ "matchStartRequiresInput" ] && !isbot( self ) )
    {
        foreach ( entry in level.teamnamelist )
        {
            level.requiredplayercount[ entry ] = 0;
        }
        
        self setclientomnvar( "ui_launch_chunk_phase", game[ "launchChunkRuleSet" ] + 1 );
        self setclientomnvar( "ui_open_menu_from_script", 3 );
        wait 2;
        self setclientomnvar( "ui_launch_chunk_phase", 5 );
        thread hackthread();
        
        while ( true )
        {
            self waittill( #"luinotifyserver", msg, value );
            
            if ( msg == "class_select" )
            {
                break;
            }
        }
        
        level notify( #"hash_c2ba6f5e09e6a9a0" );
        self setclientomnvar( "ui_launch_chunk_phase", 0 );
        game[ "matchStartRequiresInput" ] = 0;
        dialog::leaderdialogonplayer( "lc_intro", "lc_intro" );
    }
    
    thread damagewatcher();
    self waittill( #"giveloadout" );
    runarenaloadoutrulesonplayer();
    wait 0.1;
    self.hasarenaspawned = 1;
    
    if ( isbot( self ) )
    {
        if ( !isdefined( game[ "chunkBotsDifficulty" ] ) )
        {
            botpersonality = "camper";
            game[ "chunkBotsDifficulty" ] = "recruit";
        }
        else
        {
            var_d99263d85b98f7db = randomint( 3 );
            
            switch ( var_d99263d85b98f7db )
            {
                case 0:
                default:
                    botpersonality = "camper";
                    break;
                case 1:
                    botpersonality = "run_and_gun";
                    break;
                case 2:
                    botpersonality = "cqb";
                    break;
            }
            
            difficulties = [ "recruit", "regular", "hardened", "veteran" ];
            difficultyindex = 0;
            
            if ( isdefined( game[ "chunkBotsDifficulty" ] ) )
            {
                for ( i = 0; i < difficulties.size ; i++ )
                {
                    if ( game[ "chunkBotsDifficulty" ] == difficulties[ i ] )
                    {
                        difficultyindex = i;
                        break;
                    }
                }
                
                if ( !level.setinitialbotdifficulties && ( game[ "launchChunkRuleSet" ] == 1 || game[ "launchChunkRuleSet" ] == 2 ) )
                {
                    if ( !isbot( self ) )
                    {
                        if ( game[ "previousWinningTeam" ] == self.team && game[ "wasHostAliveAtRoundEnd" ] )
                        {
                            if ( difficultyindex < difficulties.size - 1 )
                            {
                                difficultyindex++;
                            }
                        }
                        else if ( difficultyindex > 0 )
                        {
                            difficultyindex--;
                        }
                    }
                    
                    game[ "chunkBotsDifficulty" ] = difficulties[ difficultyindex ];
                    level.setinitialbotdifficulties = 1;
                }
            }
        }
        
        /#
            iprintlnbold( "<dev string:x209>" + game[ "<dev string:x21a>" ] );
        #/
        
        bots_util_mp::bot_set_difficulty( game[ "chunkBotsDifficulty" ] );
        bots_util_mp::bot_set_personality( botpersonality );
    }
    
    wait 0.15;
    
    if ( !flags::gameflag( "prematch_done" ) && game[ "roundsPlayed" ] == 0 )
    {
        if ( level.spawnflag && isdefined( level.matchcountdowntime ) && level.matchcountdowntime > 5 )
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

// Namespace arena_alt
// Params 14
// Checksum 0x69787090, Offset: 0x4830
// Size: 0xf5
function onplayerdamaged( einflictor, eattacker, victim, idamage, idflags, smeansofdeath, objweapon, var_ca02bfdd611a56f4, vpoint, vdir, shitloc, psoffsettime, modelindex, partname )
{
    if ( eattacker != victim && isplayer( eattacker ) )
    {
        if ( idamage >= var_ca02bfdd611a56f4 )
        {
            idamage = var_ca02bfdd611a56f4;
        }
        
        eattacker.arenadamage += idamage;
        eattacker persistence::statsetchild( "round", "damage", eattacker.pers[ "damage" ] );
        eattacker stats::setextrascore0( eattacker.pers[ "damage" ] );
    }
}

// Namespace arena_alt
// Params 0
// Checksum 0x7e19c839, Offset: 0x492d
// Size: 0x14a
function damagewatcher()
{
    self notify( #"hash_dfd3548992b59d9e" );
    self endon( #"hash_dfd3548992b59d9e" );
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    self.totaldamagetaken = 0;
    
    while ( true )
    {
        playerhealth::function_284cd76924b8c5ae( self );
        
        if ( self.iscapturing )
        {
            objflag = undefined;
            
            if ( level.objmodifier == 1 )
            {
                if ( self.team == game[ "defenders" ] )
                {
                    level.attackerendzone.curprogress = 50;
                    level.attackerendzone.teamprogress[ self.team ] = 50;
                    objflag = level.attackerendzone;
                }
                else if ( self.team == game[ "attackers" ] )
                {
                    level.defenderendzone.curprogress = 50;
                    level.defenderendzone.teamprogress[ self.team ] = 50;
                    objflag = level.defenderendzone;
                }
                
                objidpoolmanager::objective_set_progress( objflag.objidnum, objflag.curprogress / objflag.usetime );
            }
        }
    }
}

// Namespace arena_alt
// Params 6
// Checksum 0xad97a826, Offset: 0x4a7f
// Size: 0x370
function onnormaldeath( victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon )
{
    common::oncommonnormaldeath( victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon );
    
    if ( isbot( victim ) )
    {
        victim.classcallback = "gamemode";
    }
    
    if ( game_utility_mp::getgamestate( attacker ) == "postgame" )
    {
        attacker.finalkill = 1;
    }
    
    if ( game[ "launchChunkRuleSet" ] == 0 || game[ "launchChunkRuleSet" ] == 3 )
    {
        if ( isbot( attacker ) )
        {
            if ( attacker.kills % 4 == 0 || !isbot( victim ) )
            {
                difficulties = [ "recruit", "regular", "hardened", "veteran" ];
                difficultyindex = 0;
                difficulty = attacker botgetdifficulty();
                
                if ( difficulty == "recruit" )
                {
                    difficultyindex = 0;
                }
                else if ( difficulty == "regular" )
                {
                    difficultyindex = 0;
                }
                else if ( difficulty == "hardened" )
                {
                    difficultyindex = 1;
                }
                else if ( difficulty == "veteran" )
                {
                    difficultyindex = 2;
                }
                
                attacker bots_util_mp::bot_set_difficulty( difficulties[ difficultyindex ] );
                game[ "chunkBotsDifficulty" ] = difficulties[ difficultyindex ];
                
                /#
                    iprintlnbold( "<dev string:x209>" + attacker.name + "<dev string:x22e>" + difficulties[ difficultyindex ] );
                #/
            }
        }
        
        if ( isbot( victim ) )
        {
            if ( victim.deaths % 2 == 0 )
            {
                difficulties = [ "recruit", "regular", "hardened", "veteran" ];
                difficultyindex = 0;
                difficulty = victim botgetdifficulty();
                
                if ( difficulty == "recruit" )
                {
                    difficultyindex = 1;
                }
                else if ( difficulty == "regular" )
                {
                    difficultyindex = 2;
                }
                else if ( difficulty == "hardened" )
                {
                    difficultyindex = 3;
                }
                else if ( difficulty == "veteran" )
                {
                    difficultyindex = 3;
                }
                
                victim bots_util_mp::bot_set_difficulty( difficulties[ difficultyindex ] );
                game[ "chunkBotsDifficulty" ] = difficulties[ difficultyindex ];
                
                /#
                    iprintlnbold( "<dev string:x209>" + victim.name + "<dev string:x23e>" + difficulties[ difficultyindex ] );
                #/
            }
        }
        
        if ( victim.deaths % 3 == 0 )
        {
            game[ "arenaRandomLoadoutIndex" ]++;
            
            if ( game[ "arenaRandomLoadoutIndex" ] == game[ "arenaRandomLoadout" ].size )
            {
                game[ "arenaRandomLoadoutIndex" ] = 0;
            }
            
            victim.pers[ "gamemodeLoadout" ] = game[ "arenaRandomLoadout" ][ game[ "arenaRandomLoadoutIndex" ] ];
        }
        
        return;
    }
    
    if ( !isbot( victim ) )
    {
        timeremaining = gamelogic_mp::gettimeremaining();
        
        if ( timeremaining > 35000 )
        {
            difficulties = [ "recruit", "regular", "hardened", "veteran" ];
            difficultyindex = 0;
            difficulty = game[ "chunkBotsDifficulty" ];
            
            if ( difficulty == "recruit" )
            {
                difficultyindex = 0;
            }
            else if ( difficulty == "regular" )
            {
                difficultyindex = 0;
            }
            else if ( difficulty == "hardened" )
            {
                difficultyindex = 1;
            }
            else if ( difficulty == "veteran" )
            {
                difficultyindex = 1;
            }
            
            game[ "chunkBotsDifficulty" ] = difficulties[ difficultyindex ];
            
            /#
                iprintlnbold( "<dev string:x24e>" + difficulties[ difficultyindex ] );
            #/
        }
    }
}

// Namespace arena_alt
// Params 10
// Checksum 0x96dbb317, Offset: 0x4df7
// Size: 0x7a
function onplayerkilled( einflictor, attacker, idamage, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, deathanimduration, killid )
{
    if ( isbot( self ) )
    {
        self.classcallback = "gamemode";
    }
    
    thread checkallowspectating();
}

// Namespace arena_alt
// Params 0
// Checksum 0xbfafe79c, Offset: 0x4e79
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

// Namespace arena_alt
// Params 0
// Checksum 0x812470f7, Offset: 0x4f0d
// Size: 0x81
function ontimelimit()
{
    updatetournamentroundtime( gamelogic_mp::gettimeremaining(), 3 );
    
    if ( game[ "launchChunkRuleSet" ] == 0 || game[ "launchChunkRuleSet" ] == 3 )
    {
        gamelogic_mp::default_ontimelimit();
    }
    else if ( level.wincondition == 1 )
    {
        checkliveswinner();
    }
    else if ( level.wincondition == 2 )
    {
        checkhealthwinner();
    }
    else
    {
        checkhealthwinner();
    }
    
    if ( game[ "launchChunkRuleSet" ] != 3 )
    {
        level tryspawnlaunchchunkbots();
    }
}

// Namespace arena_alt
// Params 0
// Checksum 0x87f475ac, Offset: 0x4f96
// Size: 0x38
function ontimelimitot()
{
    updatetournamentroundtime( gamelogic_mp::gettimeremaining(), 1 );
    runovertime = 1;
    
    if ( game_utility_mp::getgametypenumlives() == 0 )
    {
        runovertime = 0;
    }
    
    if ( runovertime )
    {
        level thread startotmechanics();
    }
}

// Namespace arena_alt
// Params 0
// Checksum 0x2975f324, Offset: 0x4fd6
// Size: 0xef
function checkliveswinner()
{
    if ( teams::getteamdata( "allies", "aliveCount" ) > teams::getteamdata( "axis", "aliveCount" ) )
    {
        game[ "dialog" ][ "round_success" ] = "gamestate_win_health";
        game[ "dialog" ][ "round_failure" ] = "gamestate_lost_health";
        thread arena_endgame( "allies", game[ "end_reason" ][ "arena_time_lives_win" ], game[ "end_reason" ][ "arena_time_lives_loss" ] );
        return;
    }
    
    if ( teams::getteamdata( "axis", "aliveCount" ) > teams::getteamdata( "allies", "aliveCount" ) )
    {
        game[ "dialog" ][ "round_success" ] = "gamestate_win_health";
        game[ "dialog" ][ "round_failure" ] = "gamestate_lost_health";
        thread arena_endgame( "axis", game[ "end_reason" ][ "arena_time_lives_win" ], game[ "end_reason" ][ "arena_time_lives_loss" ] );
        return;
    }
    
    checkhealthwinner();
}

// Namespace arena_alt
// Params 0
// Checksum 0x7799eae9, Offset: 0x50cd
// Size: 0x125
function checkhealthwinner()
{
    axishealth = teams::function_ca2fe741546df07d( "axis" );
    allieshealth = teams::function_ca2fe741546df07d( "allies" );
    
    if ( axishealth < allieshealth )
    {
        game[ "dialog" ][ "round_success" ] = "gamestate_win_health";
        game[ "dialog" ][ "round_failure" ] = "gamestate_lost_health";
        thread arena_endgame( "allies", game[ "end_reason" ][ "arena_time_health_win" ], game[ "end_reason" ][ "arena_time_health_loss" ] );
        return;
    }
    
    if ( allieshealth < axishealth )
    {
        game[ "dialog" ][ "round_success" ] = "gamestate_win_health";
        game[ "dialog" ][ "round_failure" ] = "gamestate_lost_health";
        thread arena_endgame( "axis", game[ "end_reason" ][ "arena_time_health_win" ], game[ "end_reason" ][ "arena_time_health_loss" ] );
        return;
    }
    
    if ( game_utility_mp::matchmakinggame() )
    {
        betterteam = gamelogic_mp::getbetterteam();
        thread gamelogic_mp::endgame( betterteam, game[ "end_reason" ][ "time_limit_reached" ] );
        return;
    }
    
    thread arena_endgame( "tie", game[ "end_reason" ][ "time_limit_reached" ] );
}

// Namespace arena_alt
// Params 1
// Checksum 0x646bfb1c, Offset: 0x51fa
// Size: 0x61
function ondeadevent( team )
{
    if ( team == game[ "attackers" ] )
    {
        level thread arena_endgame( game[ "defenders" ], game[ "end_reason" ][ "mp_faction_eliminated" ] );
        return;
    }
    
    if ( team == game[ "defenders" ] )
    {
        level thread arena_endgame( game[ "attackers" ], game[ "end_reason" ][ "mp_faction_eliminated" ] );
    }
}

// Namespace arena_alt
// Params 1
// Checksum 0xecdac11f, Offset: 0x5263
// Size: 0xc
function ontimelimitdeadevent( team )
{
    
}

// Namespace arena_alt
// Params 5
// Checksum 0x30a3209c, Offset: 0x5277
// Size: 0x120
function arena_endgame( winningteam, endreasontext, endreasontextloss, nukedetonated, var_de9b655923cddf60 )
{
    if ( isgungameloadouts() || isrvsgungameloadouts() )
    {
        level setenemyloadoutomnvarsatmatchend( winningteam );
    }
    
    hostplayer = undefined;
    
    foreach ( player in level.players )
    {
        if ( !isbot( player ) )
        {
            hostplayer = player;
        }
    }
    
    if ( isdefined( hostplayer ) && !isalive( hostplayer ) )
    {
        game[ "wasHostAliveAtRoundEnd" ] = 0;
    }
    else
    {
        game[ "wasHostAliveAtRoundEnd" ] = 1;
    }
    
    thread gamelogic_mp::endgame( winningteam, endreasontext, endreasontextloss, nukedetonated, var_de9b655923cddf60 );
    
    if ( game[ "launchChunkRuleSet" ] != 3 )
    {
        level thread tryspawnlaunchchunkbots();
    }
}

// Namespace arena_alt
// Params 0
// Checksum 0x1e1d3a0b, Offset: 0x539f
// Size: 0xd9
function runarenaloadoutrulesonplayer()
{
    if ( israndomloadouts() || israndompreviewloadouts() || israndomalphaloadouts() )
    {
        if ( israndompreviewloadouts() || israndomalphaloadouts() )
        {
            if ( self.pers[ "gamemodeLoadout" ][ "loadoutSecondary" ] == "none" )
            {
                inventory_utility::_takeweapon( "iw9_me_fists_mp" );
            }
        }
        
        return;
    }
    
    if ( ispickuploadouts() )
    {
        self.equipment = [];
        
        if ( game[ "roundsPlayed" ] == 0 )
        {
            wait 0.1;
        }
        else
        {
            wait 0.25;
        }
        
        if ( issubstr( level.startweapon, "equip" ) )
        {
            equipment_mp::giveequipment( level.startweapon, equipment_mp::getdefaultslot( level.startweapon ) );
        }
        
        if ( level.takefists )
        {
            inventory_utility::_takeweapon( "iw9_me_fists_mp" );
        }
    }
}

// Namespace arena_alt
// Params 0
// Checksum 0x8ce83833, Offset: 0x5480
// Size: 0x231
function buildloadoutsforweaponstreaming()
{
    level.loadweapons = [];
    level.takefists = 0;
    
    if ( ispickuploadouts() )
    {
        if ( level.startweapon == "none" )
        {
            newweaponobj = level.defaultfist;
            newweapon = getcompleteweaponname( newweaponobj );
        }
        else if ( issubstr( level.startweapon, "equip" ) )
        {
            newweaponobj = level.defaultfist;
            newweapon = getcompleteweaponname( newweaponobj );
        }
        else
        {
            rootname = weapon::getweaponrootname( level.startweapon );
            attachments = [];
            newweaponobj = weapon::buildweapon( rootname, attachments, "camo_none", "none", -1 );
            newweapon = getcompleteweaponname( newweaponobj );
            level.takefists = 1;
        }
        
        level.newweaponname = newweapon;
        level.loadweapons[ level.loadweapons.size ] = newweaponobj;
        return;
    }
    
    primaries = [];
    secondaries = [];
    loadout = game[ "arenaRandomLoadout" ][ game[ "arenaRandomLoadoutIndex" ] ];
    primary = loadout[ "loadoutPrimary" ];
    secondary = loadout[ "loadoutSecondary" ];
    
    if ( primary != "none" )
    {
        primaries[ primaries.size ] = buildprimaries( primary, loadout );
    }
    
    if ( secondary != "none" )
    {
        secondaries[ secondaries.size ] = buildsecondaries( secondary, loadout );
    }
    
    if ( level.loadoutchangeround != 0 )
    {
        nextloadoutindex = game[ "arenaRandomLoadoutIndex" ] + 1;
        
        if ( game[ "arenaRandomLoadoutIndex" ] == game[ "arenaRandomLoadout" ].size - 1 )
        {
            nextloadoutindex = 0;
        }
        
        nextloadout = game[ "arenaRandomLoadout" ][ nextloadoutindex ];
        nextprimary = nextloadout[ "loadoutPrimary" ];
        nextsecondary = nextloadout[ "loadoutSecondary" ];
        
        if ( nextprimary != "none" )
        {
            primaries[ primaries.size ] = buildprimaries( nextprimary, nextloadout );
        }
        
        if ( nextsecondary != "none" )
        {
            secondaries[ secondaries.size ] = buildsecondaries( nextsecondary, nextloadout );
        }
    }
    
    level.loadweapons = arraycombine( primaries, secondaries );
}

// Namespace arena_alt
// Params 2
// Checksum 0xb937569a, Offset: 0x56b9
// Size: 0xd5
function buildprimaries( primary, loadout )
{
    allattachments = [];
    
    for ( i = 1; i < 6 ; i++ )
    {
        concat = i;
        
        if ( i == 1 )
        {
            concat = "";
        }
        
        attachment = loadout[ "loadoutPrimaryAttachment" + concat ];
        
        if ( attachment != "none" )
        {
            allattachments[ allattachments.size ] = attachment;
        }
    }
    
    rootname = weapon::getweaponrootname( primary );
    camoname = "camo_none";
    reticleindex = "none";
    newweaponobject = weapon::buildweapon( rootname, allattachments, camoname, reticleindex );
    newweapon = getcompleteweaponname( newweaponobject );
    return newweapon;
}

// Namespace arena_alt
// Params 2
// Checksum 0x3184747c, Offset: 0x5797
// Size: 0xd5
function buildsecondaries( secondary, loadout )
{
    allattachments = [];
    
    for ( i = 1; i < 5 ; i++ )
    {
        concat = i;
        
        if ( i == 1 )
        {
            concat = "";
        }
        
        attachment = loadout[ "loadoutSecondaryAttachment" + concat ];
        
        if ( attachment != "none" )
        {
            allattachments[ allattachments.size ] = attachment;
        }
    }
    
    camoname = "camo_none";
    reticleindex = "none";
    rootname = weapon::getweaponrootname( secondary );
    newweaponobject = weapon::buildweapon( rootname, allattachments, camoname, reticleindex );
    newweapon = getcompleteweaponname( newweaponobject );
    return newweapon;
}

// Namespace arena_alt
// Params 0
// Checksum 0xa4c5bf7f, Offset: 0x5875
// Size: 0x2f4
function defineplayerloadout()
{
    if ( isdefined( level.startweapon ) && level.startweapon != "none" && !issubstr( level.startweapon, "equip" ) )
    {
        primary = weapon::getweaponrootname( level.startweapon );
    }
    else
    {
        primary = "none";
    }
    
    level.arena_loadouts[ "default" ][ "loadoutArchetype" ] = "archetype_assault";
    level.arena_loadouts[ "default" ][ "loadoutPrimary" ] = primary;
    level.arena_loadouts[ "default" ][ "loadoutPrimaryAttachment" ] = "none";
    level.arena_loadouts[ "default" ][ "loadoutPrimaryAttachment2" ] = "none";
    level.arena_loadouts[ "default" ][ "loadoutPrimaryCamo" ] = "none";
    level.arena_loadouts[ "default" ][ "loadoutPrimaryReticle" ] = "none";
    level.arena_loadouts[ "default" ][ "loadoutSecondary" ] = "none";
    level.arena_loadouts[ "default" ][ "loadoutSecondaryAttachment" ] = "none";
    level.arena_loadouts[ "default" ][ "loadoutSecondaryAttachment2" ] = "none";
    level.arena_loadouts[ "default" ][ "loadoutSecondaryCamo" ] = "none";
    level.arena_loadouts[ "default" ][ "loadoutSecondaryReticle" ] = "none";
    level.arena_loadouts[ "default" ][ "loadoutMeleeSlot" ] = level.laststandweapon;
    level.arena_loadouts[ "default" ][ "loadoutEquipmentPrimary" ] = "none";
    level.arena_loadouts[ "default" ][ "loadoutEquipmentSecondary" ] = "none";
    level.arena_loadouts[ "default" ][ "loadoutStreakType" ] = "assault";
    level.arena_loadouts[ "default" ][ "loadoutKillstreak1" ] = "none";
    level.arena_loadouts[ "default" ][ "loadoutKillstreak2" ] = "none";
    level.arena_loadouts[ "default" ][ "loadoutKillstreak3" ] = "none";
    level.arena_loadouts[ "default" ][ "loadoutSuper" ] = "none";
    level.arena_loadouts[ "default" ][ "loadoutPerks" ] = [ "specialty_blastshield" ];
    level.arena_loadouts[ "default" ][ "loadoutGesture" ] = "playerData";
    level.arena_loadouts[ "default" ][ "loadoutExecution" ] = "playerData";
    level.arena_loadouts[ "allies" ] = level.arena_loadouts[ "default" ];
    level.arena_loadouts[ "axis" ] = level.arena_loadouts[ "default" ];
}

// Namespace arena_alt
// Params 0
// Checksum 0xea489da3, Offset: 0x5b71
// Size: 0xe3
function updaterandomloadout()
{
    if ( israndomloadouts() || israndompreviewloadouts() || israndomalphaloadouts() )
    {
        /#
            if ( getdvarint( @"hash_b665ceb14dabc0ed", -1 ) != 0 )
            {
                cacherandomloadouts();
                game[ "<dev string:x26d>" ] = 0;
                return;
            }
        #/
        
        if ( game[ "roundsPlayed" ] == 0 )
        {
            if ( game[ "practiceRound" ] )
            {
                cacherandomloadouts();
                game[ "arenaRandomLoadoutIndex" ] = 0;
            }
            else if ( !isdefined( game[ "practiceRound" ] ) )
            {
                cacherandomloadouts();
                game[ "arenaRandomLoadoutIndex" ] = 0;
            }
            
            return;
        }
        
        if ( level.loadoutchangeround != 0 )
        {
            if ( game[ "roundsPlayed" ] % level.loadoutchangeround == 0 )
            {
                game[ "arenaRandomLoadoutIndex" ]++;
            }
            
            if ( game[ "arenaRandomLoadoutIndex" ] == game[ "arenaRandomLoadout" ].size )
            {
                game[ "arenaRandomLoadoutIndex" ] = 0;
            }
            
            return;
        }
        
        game[ "arenaRandomLoadoutIndex" ] = 0;
    }
}

// Namespace arena_alt
// Params 0
// Checksum 0x319dd938, Offset: 0x5c5c
// Size: 0x152
function cacherandomloadouts()
{
    game[ "arenaRandomLoadout" ] = [];
    level.chunkloadouts = [];
    classtables = arena::function_6220187e61c1d47( [ "arena_alt_class_table" ] );
    
    foreach ( classtable in classtables )
    {
        foreach ( loadout in classtable.classlist )
        {
            level.chunkloadouts[ level.chunkloadouts.size ] = arena::function_4ba1689208fa4c96( loadout );
        }
    }
    
    loadouts = level.chunkloadouts;
    loadouts = arenaloadouts_select( loadouts, 99 );
    game[ "arenaRandomLoadout" ] = arrayrandomize( loadouts );
}

// Namespace arena_alt
// Params 2
// Checksum 0xc9af3ff7, Offset: 0x5db6
// Size: 0x1f5
function updateloadoutarray( table, classindex )
{
    loadoutarray = [];
    loadoutarray[ "loadoutPrimary" ] = class::table_getweapon( table, classindex, 0 );
    wildcard = class::function_6e209ed6e2db2b0b( table, classindex );
    maxprimaryattachments = weapon::getmaxprimaryattachments( wildcard );
    
    for ( attachmentindex = 0; attachmentindex < maxprimaryattachments ; attachmentindex++ )
    {
        attachstring = class::getattachmentloadoutstring( attachmentindex, #"primary" );
        loadoutarray[ attachstring ] = class::table_getweaponattachment( table, classindex, 0, attachmentindex );
    }
    
    loadoutarray[ "loadoutPrimaryCamo" ] = class::table_getweaponcamo( table, classindex, 0 );
    loadoutarray[ "loadoutPrimaryReticle" ] = class::table_getweaponreticle( table, classindex, 0 );
    loadoutarray[ "loadoutSecondary" ] = class::table_getweapon( table, classindex, 1 );
    maxsecondaryattachments = weapon::getmaxsecondaryattachments( wildcard );
    
    for ( attachmentindex = 0; attachmentindex < maxsecondaryattachments ; attachmentindex++ )
    {
        attachstring = class::getattachmentloadoutstring( attachmentindex, #"secondary" );
        loadoutarray[ attachstring ] = class::table_getweaponattachment( table, classindex, 1, attachmentindex );
    }
    
    loadoutarray[ "loadoutSecondaryCamo" ] = class::table_getweaponcamo( table, classindex, 1 );
    loadoutarray[ "loadoutSecondaryReticle" ] = class::table_getweaponreticle( table, classindex, 1 );
    loadoutarray[ "loadoutEquipmentPrimary" ] = class::table_getequipmentprimary( table, classindex );
    loadoutarray[ "loadoutExtraEquipmentPrimary" ] = class::table_getextraequipmentprimary( table, classindex );
    loadoutarray[ "loadoutEquipmentSecondary" ] = class::table_getequipmentsecondary( table, classindex );
    loadoutarray[ "loadoutExtraEquipmentSecondary" ] = class::table_getextraequipmentsecondary( table, classindex );
    loadoutarray[ "loadoutPerks" ] = [];
    
    for ( i = 0; i < 3 ; i++ )
    {
        perk = class::table_getperk( table, classindex, i );
        
        if ( perk != "specialty_null" )
        {
            loadoutarray[ "loadoutPerks" ][ loadoutarray[ "loadoutPerks" ].size ] = perk;
        }
    }
    
    loadoutarray[ "loadoutGesture" ] = "playerData";
    loadoutarray[ "loadoutExecution" ] = "playerData";
    return loadoutarray;
}

// Namespace arena_alt
// Params 2
// Checksum 0xe368a2b1, Offset: 0x5fb4
// Size: 0x82
function arenaloadouts_select( loadouts, count )
{
    classes = [];
    selectedloadouts = [];
    
    for ( num = 0; num < count && loadouts.size > 0 ; num++ )
    {
        selectedloadouts[ selectedloadouts.size ] = loadouts[ randomint( loadouts.size ) ];
        var_3be37e68ae048b5b = selectedloadouts[ selectedloadouts.size - 1 ][ "loadoutPrimary" ];
        loadouts = arenaloadouts_removeclass( loadouts, var_3be37e68ae048b5b );
    }
    
    return selectedloadouts;
}

// Namespace arena_alt
// Params 2
// Checksum 0xffc75502, Offset: 0x603f
// Size: 0xc2
function arenaloadouts_removeclass( loadouts, var_3be37e68ae048b5b )
{
    filtered = [];
    group = arenaloadouts_getweapongroup( var_3be37e68ae048b5b );
    
    foreach ( loadout in loadouts )
    {
        currgroup = arenaloadouts_getweapongroup( loadout[ "loadoutPrimary" ] );
        
        if ( group != currgroup )
        {
            filtered[ filtered.size ] = loadout;
        }
    }
    
    return filtered;
}

// Namespace arena_alt
// Params 1
// Checksum 0x93288a7f, Offset: 0x610a
// Size: 0x46
function arenaloadouts_getweapongroup( rootweapon )
{
    group = "none";
    
    if ( rootweapon != "none" )
    {
        group = weapon::getweapongroup( rootweapon );
        
        if ( group == "weapon_dmr" )
        {
            group = "weapon_sniper";
        }
    }
    
    return group;
}

// Namespace arena_alt
// Params 0
// Checksum 0xc15fb1d7, Offset: 0x6159
// Size: 0xc9
function function_22a3a367a2650a98()
{
    level.weaponcategories = [];
    level.allweapons = [];
    
    for ( row = 0; true ; row++ )
    {
        tablename = "mp/arenaGGWeapons_alt.csv";
        categoryname = tablelookupbyrow( tablename, row, 4 );
        
        if ( categoryname == "" )
        {
            break;
        }
        
        if ( !isdefined( level.weaponcategories[ categoryname ] ) )
        {
            level.weaponcategories[ categoryname ] = [];
        }
        
        data = [];
        data[ "weapon" ] = tablelookupbyrow( tablename, row, 0 );
        level.weaponcategories[ categoryname ][ level.weaponcategories[ categoryname ].size ] = data;
        level.allweapons[ level.allweapons.size ] = data;
    }
}

// Namespace arena_alt
// Params 1
// Checksum 0xa241026e, Offset: 0x622a
// Size: 0x111
function function_95b533a3974a91c( categoryname )
{
    weaponlist = level.weaponcategories[ categoryname ];
    
    if ( isdefined( weaponlist ) && weaponlist.size > 0 )
    {
        newweapon = "";
        data = undefined;
        
        for ( loopcount = 0; true ; loopcount++ )
        {
            index = randomintrange( 0, weaponlist.size );
            data = weaponlist[ index ];
            rootname = weapon::getweaponrootname( data[ "weapon" ] );
            
            if ( loopcount > weaponlist.size )
            {
                level.selectedweapons[ rootname ] = 1;
                newweapon = data[ "weapon" ];
                
                for ( i = 0; i < level.weaponcategories[ categoryname ].size ; i++ )
                {
                    if ( level.weaponcategories[ categoryname ][ i ][ "weapon" ] == newweapon )
                    {
                        break;
                    }
                }
                
                break;
            }
        }
        
        return newweapon;
    }
    
    assertmsg( "<dev string:x285>" + categoryname );
    return "none";
}

// Namespace arena_alt
// Params 0
// Checksum 0x9d51d3c5, Offset: 0x6343
// Size: 0xba
function initweaponmap()
{
    level.baseraritymap = [];
    level.baseraritymap[ level.arenaweapont1 ] = 0;
    level.baseraritymap[ level.arenaweapont2 ] = 1;
    level.baseraritymap[ level.arenaweapont3 ] = 2;
    level.baseraritymap[ level.arenaweapont4 ] = 3;
    level.baseraritymap[ level.arenaweapont5 ] = 4;
    level.baseraritymap[ level.arenaweapont6 ] = 5;
    level.baseraritymap[ level.arenaweapont7 ] = 6;
    level.baseraritymap[ level.arenaweapont8 ] = 0;
}

// Namespace arena_alt
// Params 0
// Checksum 0x68530f9b, Offset: 0x6405
// Size: 0x1dc
function setupweapons()
{
    locs = utility::getstructarray( "weapon_pickup", "targetname" );
    assert( locs.size > 0, "<dev string:x2a3>" );
    
    foreach ( loc in locs )
    {
        if ( loc.script_label == "1" )
        {
            spawnweapon( loc, level.arenaweapont1 );
            continue;
        }
        
        if ( loc.script_label == "2" )
        {
            spawnweapon( loc, level.arenaweapont2 );
            continue;
        }
        
        if ( loc.script_label == "3" )
        {
            spawnweapon( loc, level.arenaweapont3 );
            continue;
        }
        
        if ( loc.script_label == "4" )
        {
            spawnweapon( loc, level.arenaweapont4 );
            continue;
        }
        
        if ( loc.script_label == "5" )
        {
            spawnweapon( loc, level.arenaweapont5 );
            continue;
        }
        
        if ( loc.script_label == "6" )
        {
            spawnweapon( loc, level.arenaweapont6 );
            continue;
        }
        
        if ( loc.script_label == "7" )
        {
            spawnweapon( loc, level.arenaweapont7 );
            continue;
        }
        
        if ( loc.script_label == "8" )
        {
            spawnweapon( loc, level.arenaweapont8 );
        }
    }
}

// Namespace arena_alt
// Params 0
// Checksum 0xc4a43344, Offset: 0x65e9
// Size: 0x11d
function getrandomspawnweapon()
{
    weaponlist = level.allweapons;
    
    if ( isdefined( weaponlist ) && weaponlist.size > 0 )
    {
        newweapon = "";
        data = undefined;
        
        for ( loopcount = 0; true ; loopcount++ )
        {
            index = randomintrange( 0, weaponlist.size );
            data = weaponlist[ index ];
            
            if ( !issubstr( data[ "weapon" ], "equip" ) )
            {
                rootname = weapon::getweaponrootname( data[ "weapon" ] );
            }
            else
            {
                rootname = data[ "weapon" ];
            }
            
            if ( loopcount > weaponlist.size )
            {
                level.selectedweapons[ rootname ] = 1;
                newweapon = data[ "weapon" ];
                
                for ( i = 0; i < level.allweapons.size ; i++ )
                {
                    if ( level.allweapons[ i ][ "weapon" ] == newweapon )
                    {
                        break;
                    }
                }
                
                break;
            }
        }
        
        return newweapon;
    }
    
    assertmsg( "<dev string:x2ff>" );
    return "none";
}

// Namespace arena_alt
// Params 2
// Checksum 0x17773838, Offset: 0x670e
// Size: 0x3ea
function spawnweapon( loc, weapontier )
{
    if ( weapontier == "none" )
    {
        return;
    }
    
    tracestart = loc.origin + ( 0, 0, 32 );
    traceend = loc.origin + ( 0, 0, -32 );
    trace = trace::ray_trace( tracestart, traceend, undefined, trace::create_default_contents( 1 ) );
    snappos = fixuppickuporigin( loc );
    
    if ( trace[ "fraction" ] < 1 )
    {
        snappos = trace[ "position" ] + ( 0, 0, 2 );
    }
    
    equipmentmodel = getequipmentmodel( weapontier );
    
    if ( equipmentmodel != "" )
    {
        equipment = spawn( "script_model", snappos );
        equipment setmodel( equipmentmodel );
        
        if ( isdefined( loc.angles ) )
        {
            if ( weapontier == "equip_claymore" || weapontier == "equip_at_mine" || weapontier == "equip_trophy" )
            {
                if ( loc.script_noteworthy == "wall" )
                {
                    equipment.angles = ( 270, loc.angles[ 1 ], 90 );
                }
                else
                {
                    equipment.angles = ( 0, loc.angles[ 1 ], 0 );
                }
            }
            else if ( weapontier == "equip_c4" )
            {
                if ( loc.script_noteworthy == "wall" )
                {
                    equipment.angles = ( 180, loc.angles[ 1 ], 180 );
                }
                else
                {
                    equipment.angles = ( 0, loc.angles[ 1 ], 90 );
                }
            }
            else
            {
                equipment.angles = ( 0, 90, 0 );
                equipment.origin += ( 0, 0, 2 );
            }
        }
        else
        {
            equipment.angles = ( 0, 0, 90 );
        }
        
        userange = 128;
        equipmenthintstring = equipment getequipmenthintstring( weapontier );
        equipmenthinticon = equipment getequipmenthinticon( weapontier );
        equipment.equipment = weapontier;
        equipment makeusable();
        equipment sethinttag( "tag_origin" );
        equipment setcursorhint( "HINT_BUTTON" );
        equipment sethinticon( equipmenthinticon );
        equipment setuseholdduration( "duration_none" );
        equipment setusehideprogressbar( 1 );
        equipment sethintstring( equipmenthintstring );
        equipment setusepriority( 0 );
        equipment sethintdisplayrange( userange );
        equipment sethintdisplayfov( 120 );
        equipment setuserange( userange );
        equipment setusefov( 360 );
        equipment sethintonobstruction( "hide" );
        equipment thread outlineequipmentwatchplayerprox( equipmentmodel, weapontier );
        equipment thread watchequipmentpickup();
        return;
    }
    
    rootname = undefined;
    rootname = weapon::getweaponrootname( weapontier );
    attachments = [];
    userange = 128;
    objweapon = weapon::buildweapon( rootname, attachments, "camo_none", "none", -1 );
    weaponname = getcompleteweaponname( objweapon );
    weapon = spawn( "weapon_" + weaponname, snappos, 17 );
    weapon sethintdisplayrange( userange );
    weapon setuserange( userange );
    manageweaponstartingammo( weapon, weaponname );
    
    if ( isdefined( loc.angles ) )
    {
        weapon.angles = loc.angles;
    }
    else
    {
        weapon.angles = ( 0, 0, 90 );
    }
    
    weapon thread outlinewatchplayerprox();
    weapon thread watchpickup();
}

// Namespace arena_alt
// Params 1
// Checksum 0x1ea3a76d, Offset: 0x6b00
// Size: 0xba
function fixuppickuporigin( loc )
{
    if ( loc.script_label == "3" && distance( loc.origin, ( -488.2, -399.9, 54.25 ) ) < 10 )
    {
        loc.origin = ( -488.2, -409.9, 54.25 );
    }
    else if ( loc.script_label == "5" && distance( loc.origin, ( 657.3, 644.6, 56 ) ) < 10 )
    {
        loc.origin = ( 665.3, 644.6, 56 );
    }
    
    return loc.origin;
}

// Namespace arena_alt
// Params 1
// Checksum 0x78fdef43, Offset: 0x6bc3
// Size: 0x142
function getequipmentmodel( weapon )
{
    switch ( weapon )
    {
        case #"hash_8c7819f0a3fbd1e0":
            return "offhand_wm_grenade_mike67";
        case #"hash_d3a6dc7f9c517e66":
        case #"hash_f0907f858c134cb4":
            return "offhand_wm_grenade_semtex";
        case #"hash_4320d77f90725183":
            return "offhand_wm_c4";
        case #"hash_2354208d9af64220":
            return "offhand_wm_claymore_held";
        case #"hash_3995658e01f4fac1":
            return "offhand_wm_at_mine";
        case #"hash_9ba0a6ff6081954e":
            return "weapon_wm_me_soscar_knife_offhand_thrown";
        case #"hash_142a787e36d7d7ce":
            return "offhand_wm_molotov";
        case #"hash_de4641ddbc44a7ba":
            return "offhand_wm_grenade_semtex";
        case #"hash_5a562592c930b7d6":
            return "offhand_wm_grenade_flash";
        case #"hash_4f62b5fa00ecd075":
            return "offhand_wm_grenade_snapshot_mp";
        case #"hash_fb6b649176cec75d":
            return "offhand_wm_grenade_smoke";
        case #"hash_5fca4943a78ace9c":
            return "offhand_wm_grenade_concussion";
        case #"hash_c848458cca24d656":
            return "offhand_wm_trophy_system";
        case #"hash_15d06a7d7efafe8":
            return "offhand_wm_grenade_decoy";
        case #"hash_25ac81b822cf0c9f":
            return "offhand_wm_stim";
        default:
            return "";
    }
}

// Namespace arena_alt
// Params 1
// Checksum 0xae286803, Offset: 0x6d0d
// Size: 0x250
function getequipmenthintstring( weapon )
{
    switch ( weapon )
    {
        case #"hash_8c7819f0a3fbd1e0":
            self.equiptype = "primary";
            return &"mp_ingame_only/pickup_frag";
        case #"hash_d3a6dc7f9c517e66":
        case #"hash_f0907f858c134cb4":
            self.equiptype = "primary";
            return &"mp_ingame_only/pickup_semtex";
        case #"hash_4320d77f90725183":
            self.equiptype = "primary";
            return &"mp_ingame_only/pickup_c4";
        case #"hash_2354208d9af64220":
            self.equiptype = "primary";
            return &"mp_ingame_only/pickup_claymore";
        case #"hash_3995658e01f4fac1":
            self.equiptype = "primary";
            return &"mp_ingame_only/pickup_atmine";
        case #"hash_9ba0a6ff6081954e":
            self.equiptype = "primary";
            return &"mp_ingame_only/pickup_tknife";
        case #"hash_142a787e36d7d7ce":
            self.equiptype = "primary";
            return &"mp_ingame_only/pickup_molotov";
        case #"hash_de4641ddbc44a7ba":
            self.equiptype = "primary";
            return &"mp_ingame_only/pickup_thermite";
        case #"hash_5a562592c930b7d6":
            self.equiptype = "secondary";
            return &"mp_ingame_only/pickup_flash";
        case #"hash_4f62b5fa00ecd075":
            self.equiptype = "secondary";
            return &"mp_ingame_only/pickup_snapshot";
        case #"hash_fb6b649176cec75d":
            self.equiptype = "secondary";
            return &"mp_ingame_only/pickup_smoke";
        case #"hash_5fca4943a78ace9c":
            self.equiptype = "secondary";
            return &"mp_ingame_only/pickup_stun";
        case #"hash_c848458cca24d656":
            self.equiptype = "secondary";
            return &"mp_ingame_only/pickup_trophy_system";
        case #"hash_15d06a7d7efafe8":
            self.equiptype = "secondary";
            return &"mp_ingame_only/pickup_decoy";
        case #"hash_25ac81b822cf0c9f":
            self.equiptype = "secondary";
            return &"mp_ingame_only/pickup_stim";
        default:
            return "";
    }
}

// Namespace arena_alt
// Params 1
// Checksum 0xae8ee5cd, Offset: 0x6f65
// Size: 0x34
function getequipmenthinticon( weapon )
{
    table = "mp/arenaGGWeapons.csv";
    icon = tablelookup( table, 0, weapon, 3 );
    return icon;
}

// Namespace arena_alt
// Params 2
// Checksum 0x9787d8ba, Offset: 0x6fa2
// Size: 0xa4
function manageweaponstartingammo( weapon, weaponname )
{
    mag = weaponclipsize( weaponname );
    stockadd = 0;
    
    if ( level.magcount != 3 )
    {
        noammo = !level.magcount;
        
        if ( noammo )
        {
            mag = 0;
            stockadd = 0;
        }
        else
        {
            stockadd = level.magcount - 1;
        }
        
        if ( level.magcount == 7 )
        {
            stockadd = weaponmaxammo( weaponname );
        }
        else
        {
            stockadd = mag * stockadd;
        }
    }
    else
    {
        stockadd = mag * 2;
    }
    
    weapon itemweaponsetammo( mag, stockadd );
}

// Namespace arena_alt
// Params 0
// Checksum 0x9b714cfb, Offset: 0x704e
// Size: 0x14b
function watchequipmentpickup()
{
    self endon( #"death" );
    self waittill( #"trigger", player, droppeditem );
    hasmaxammo = 0;
    issameequip = checkissameequip( player );
    equipammo = checkpickupequiptypeammocount( player );
    var_a8a89389d81bf9a4 = player equipment_mp::getequipmentmaxammo( self.equipment );
    var_e6c9ee5a655526f3 = checkcurrentequiptypeammocount( player );
    
    if ( issameequip )
    {
        if ( equipammo == var_a8a89389d81bf9a4 )
        {
            hasmaxammo = 1;
        }
    }
    
    if ( issameequip && !hasmaxammo )
    {
        player equipment_mp::incrementequipmentammo( self.equipment, 1 );
    }
    else if ( var_e6c9ee5a655526f3 && !issameequip )
    {
        player dropoldequipinplace( player equipment_mp::getcurrentequipment( self.equiptype ) );
    }
    
    if ( !issameequip )
    {
        player equipment_mp::giveequipment( self.equipment, self.equiptype );
    }
    
    if ( issameequip && hasmaxammo )
    {
        player iprintlnbold( &"mp_ingame_only/equipment_maxed" );
        thread watchequipmentpickup();
        return;
    }
    
    player playlocalsound( "scavenger_pack_pickup" );
    clearweaponoutlines();
    self makeunusable();
    self delete();
}

// Namespace arena_alt
// Params 1
// Checksum 0x551c665, Offset: 0x71a1
// Size: 0x1d
function checkpickupequiptypeammocount( player )
{
    return player equipment_mp::getequipmentammo( self.equipment );
}

// Namespace arena_alt
// Params 1
// Checksum 0x624556e3, Offset: 0x71c7
// Size: 0x3e
function checkcurrentequiptypeammocount( player )
{
    equipref = player equipment_mp::getcurrentequipment( self.equiptype );
    
    if ( isdefined( equipref ) )
    {
        return player equipment_mp::getequipmentammo( equipref );
    }
    
    return 0;
}

// Namespace arena_alt
// Params 1
// Checksum 0x670328d5, Offset: 0x720d
// Size: 0x41
function checkissameequip( player )
{
    equipref = player equipment_mp::getcurrentequipment( self.equiptype );
    
    if ( isdefined( equipref ) )
    {
        return ( self.equipment == equipref );
    }
    
    return 0;
}

// Namespace arena_alt
// Params 1
// Checksum 0x413bd93b, Offset: 0x7256
// Size: 0x16
function dropoldequipinplace( equipment )
{
    spawnweapon( self, equipment );
}

// Namespace arena_alt
// Params 0
// Checksum 0x3c8de7b7, Offset: 0x7274
// Size: 0x50
function watchpickup()
{
    self endon( #"death" );
    self waittill( #"trigger", player, droppeditem );
    clearweaponoutlines();
    
    if ( isdefined( droppeditem ) )
    {
        droppeditem thread outlinewatchplayerprox();
        droppeditem thread watchpickup();
    }
}

// Namespace arena_alt
// Params 0
// Checksum 0xeb15a07f, Offset: 0x72cc
// Size: 0x209
function setenemyloadoutomnvars()
{
    enemyplayer = undefined;
    
    if ( !isdefined( self.pers[ "team" ] ) )
    {
        otherteam = "allies";
    }
    else
    {
        otherteam = team_utility::getotherteam( self.pers[ "team" ] );
    }
    
    foreach ( player in level.players )
    {
        if ( player.team == otherteam )
        {
            enemyplayer = player;
            break;
        }
    }
    
    if ( !isdefined( enemyplayer ) )
    {
        enemyplayer = self;
    }
    
    table = "mp/arenaGGWeapons.csv";
    self setclientomnvar( "ui_arena_en_primary", -1 );
    self setclientomnvar( "ui_arena_en_secondary", -1 );
    self setclientomnvar( "ui_arena_en_lethal", -1 );
    self setclientomnvar( "ui_arena_en_tactical", -1 );
    primary = int( tablelookup( table, 0, enemyplayer.pers[ "gamemodeLoadout" ][ "loadoutPrimary" ], 1 ) );
    self setclientomnvar( "ui_arena_en_primary", primary );
    secondary = int( tablelookup( table, 0, enemyplayer.pers[ "gamemodeLoadout" ][ "loadoutSecondary" ], 1 ) );
    self setclientomnvar( "ui_arena_en_secondary", secondary );
    lethal = int( tablelookup( table, 0, enemyplayer.pers[ "gamemodeLoadout" ][ "loadoutEquipmentPrimary" ], 1 ) );
    self setclientomnvar( "ui_arena_en_lethal", lethal );
    tactical = int( tablelookup( table, 0, enemyplayer.pers[ "gamemodeLoadout" ][ "loadoutEquipmentSecondary" ], 1 ) );
    self setclientomnvar( "ui_arena_en_tactical", tactical );
}

// Namespace arena_alt
// Params 1
// Checksum 0x8353438c, Offset: 0x74dd
// Size: 0x75
function getgungameloadoutindex( player )
{
    playerloadoutindex = 0;
    
    if ( game[ "roundsPlayed" ] == 0 )
    {
        playerloadoutindex = 0;
    }
    else if ( isgungameloadouts() )
    {
        playerloadoutindex = game[ "roundsWon" ][ player.pers[ "team" ] ];
    }
    else
    {
        playerloadoutindex = game[ "roundsWon" ][ team_utility::getotherteam( player.pers[ "team" ] ) ];
    }
    
    return playerloadoutindex;
}

// Namespace arena_alt
// Params 2
// Checksum 0x54eedab7, Offset: 0x755b
// Size: 0xae
function getgungameloadoutomnvarindex( player, winningteam )
{
    playerloadoutindex = 0;
    
    if ( isgungameloadouts() )
    {
        playerloadoutindex = game[ "roundsWon" ][ player.pers[ "team" ] ];
        
        if ( winningteam == player.pers[ "team" ] )
        {
            playerloadoutindex += 1;
        }
    }
    else
    {
        playerloadoutindex = game[ "roundsWon" ][ team_utility::getotherteam( player.pers[ "team" ] ) ];
        
        if ( winningteam == team_utility::getotherteam( player.pers[ "team" ] ) )
        {
            playerloadoutindex += 1;
        }
    }
    
    return playerloadoutindex;
}

// Namespace arena_alt
// Params 1
// Checksum 0xeffd1252, Offset: 0x7612
// Size: 0x2b1
function setenemyloadoutomnvarsatmatchend( winningteam )
{
    foreach ( player in level.players )
    {
        enemyplayer = undefined;
        
        if ( !isdefined( player.pers[ "team" ] ) )
        {
            otherteam = "allies";
        }
        else
        {
            otherteam = team_utility::getotherteam( player.pers[ "team" ] );
        }
        
        foreach ( p in level.players )
        {
            if ( p.team == otherteam )
            {
                enemyplayer = p;
                break;
            }
        }
        
        if ( !isdefined( enemyplayer ) )
        {
            enemyplayer = player;
        }
        
        enemyplayer.pers[ "gamemodeLoadout" ] = game[ "arenaRandomLoadout" ][ getgungameloadoutomnvarindex( enemyplayer, winningteam ) ];
        table = "mp/arenaGGWeapons.csv";
        player setclientomnvar( "ui_arena_en_primary", -1 );
        player setclientomnvar( "ui_arena_en_secondary", -1 );
        player setclientomnvar( "ui_arena_en_lethal", -1 );
        player setclientomnvar( "ui_arena_en_tactical", -1 );
        primary = int( tablelookup( table, 0, enemyplayer.pers[ "gamemodeLoadout" ][ "loadoutPrimary" ], 1 ) );
        player setclientomnvar( "ui_arena_en_primary", primary );
        secondary = int( tablelookup( table, 0, enemyplayer.pers[ "gamemodeLoadout" ][ "loadoutSecondary" ], 1 ) );
        player setclientomnvar( "ui_arena_en_secondary", secondary );
        lethal = int( tablelookup( table, 0, enemyplayer.pers[ "gamemodeLoadout" ][ "loadoutEquipmentPrimary" ], 1 ) );
        player setclientomnvar( "ui_arena_en_lethal", lethal );
        tactical = int( tablelookup( table, 0, enemyplayer.pers[ "gamemodeLoadout" ][ "loadoutEquipmentSecondary" ], 1 ) );
        player setclientomnvar( "ui_arena_en_tactical", tactical );
    }
}

// Namespace arena_alt
// Params 0
// Checksum 0x88fae5a, Offset: 0x78cb
// Size: 0x236
function spawngameendflagzone()
{
    arenaflag = getentarray( "flag_arena", #targetname );
    
    if ( !isdefined( arenaflag[ 0 ] ) )
    {
        assertmsg( "<dev string:x313>" );
        return;
    }
    
    level.arenaflag = arenaflag[ 0 ];
    trigger = arenaflag[ 0 ];
    
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
    arenaflag.onuse = &arenaflag_onuse;
    arenaflag.onbeginuse = &arenaflag_onusebegin;
    arenaflag.onenduse = &arenaflag_onuseend;
    arenaflag.onuseupdate = &arenaflag_onuseupdate;
    arenaflag.oncontested = &arenaflag_oncontested;
    arenaflag.isarena = 1;
    arenaflag gameobjects::pinobjiconontriggertouch();
    arenaflag.id = "domFlag";
    arenaflag.scriptable delete();
    arenaflag gameobjects::setcapturebehavior( "persistent" );
    arenaflag.ignorestomp = 1;
    level.objectives[ arenaflag.objectivekey ] = arenaflag;
    level.arenaflag = arenaflag;
    waitframe();
    level.arenaflag gameobjects::requestid( 1, 1, undefined, 0, 0 );
    level.arenaflag.visibleteam = "any";
    level.arenaflag gameobjects::setobjectivestatusicons( "icon_waypoint_ot" );
    
    if ( !flags::gameflag( "prematch_done" ) )
    {
        level.arenaflag thread arena::deleteotpreview();
        level thread arena::showflagoutline();
        return;
    }
    
    level.arenaflag arena::disableotflag();
}

// Namespace arena_alt
// Params 0
// Checksum 0x1effb9de, Offset: 0x7b09
// Size: 0x70
function showflagoutline()
{
    waitframe();
    
    if ( isdefined( level.arenaflag ) && isdefined( level.arenaflag.flagmodel ) )
    {
        level.arenaflag.flagmodel.outlinedid = outline::outlineenableforall( level.arenaflag.flagmodel, "outline_nodepth_orange", "level_script" );
    }
    
    level thread removeflagoutlineongameend();
}

// Namespace arena_alt
// Params 1
// Checksum 0xa1ccb12a, Offset: 0x7b81
// Size: 0x128
function arenaflag_onusebegin( player )
{
    player.iscapturing = 1;
    level.canprocessot = 0;
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
    
    usetime = level.flagneutralization ? level.flagcapturetime * 0.5 : level.flagcapturetime;
    gameobjects::setusetime( usetime );
    
    if ( level.capturedecay )
    {
        thread gameobjects::useobjectdecay( player.team );
    }
    
    if ( usetime > 0 )
    {
        self.prevownerteam = team_utility::getotherteam( player.team );
        obj_dom::updateflagcapturestate( player.team );
        gameobjects::setobjectivestatusicons( level.icontaking, level.iconlosing );
    }
}

// Namespace arena_alt
// Params 4
// Checksum 0x9d5a23cc, Offset: 0x7cb1
// Size: 0x107
function arenaflag_onuseupdate( team, progress, change, capplayer )
{
    ownerteam = gameobjects::getownerteam();
    
    if ( progress > 0.05 && change && !self.didstatusnotify )
    {
        if ( ownerteam == "neutral" )
        {
            if ( level.flagcapturetime > 0.05 )
            {
                dialog::statusdialog( "securing" + self.objectivekey, team );
                otherteam = team_utility::getotherteam( team );
                dialog::statusdialog( "losing" + self.objectivekey, otherteam );
            }
        }
        else if ( level.flagcapturetime > 0.05 )
        {
            dialog::statusdialog( "losing" + self.objectivekey, ownerteam );
            dialog::statusdialog( "securing" + self.objectivekey, team );
        }
        
        self.didstatusnotify = 1;
    }
}

// Namespace arena_alt
// Params 3
// Checksum 0xb14fb9fe, Offset: 0x7dc0
// Size: 0xdc
function arenaflag_onuseend( team, player, success )
{
    level.canprocessot = 1;
    self.didstatusnotify = 0;
    
    if ( success )
    {
        objidpoolmanager::objective_show_progress( self.objidnum, 0 );
    }
    
    if ( isplayer( player ) )
    {
        player.iscapturing = 0;
        player setclientomnvar( "ui_objective_pinned_text_param", 0 );
    }
    
    ownerteam = gameobjects::getownerteam();
    
    if ( ownerteam == "neutral" )
    {
        gameobjects::setobjectivestatusicons( level.iconneutral );
        thread obj_dom::updateflagstate( "idle", 0 );
    }
    else
    {
        gameobjects::setobjectivestatusicons( level.icondefend, level.iconcapture );
        thread obj_dom::updateflagstate( ownerteam, 0 );
    }
    
    if ( !success )
    {
        self.neutralized = 0;
    }
}

// Namespace arena_alt
// Params 1
// Checksum 0xa926e67c, Offset: 0x7ea4
// Size: 0x14f
function arenaflag_onuse( credit_player )
{
    level.canprocessot = 1;
    team = credit_player.team;
    oldteam = gameobjects::getownerteam();
    otherteam = team_utility::getotherteam( team );
    self.capturetime = gettime();
    self.neutralized = 0;
    dialog::statusdialog( "lost" + self.objectivekey, otherteam );
    dialog::statusdialog( "secured" + self.objectivekey, team );
    thread print::printandsoundoneveryone( team, otherteam, undefined, undefined, "mp_dom_flag_captured", "mp_dom_flag_lost", credit_player );
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
    level thread arena_endgame( credit_player.team, game[ "end_reason" ][ "arena_otflag_completed" ], game[ "end_reason" ][ "arena_otflag_failed" ] );
}

// Namespace arena_alt
// Params 0
// Checksum 0x1ef19845, Offset: 0x7ffb
// Size: 0x38
function arenaflag_oncontested()
{
    gameobjects::setobjectivestatusicons( level.iconcontested );
    objidpoolmanager::objective_set_progress_team( self.objidnum, undefined );
    thread obj_dom::updateflagstate( "contested", 0 );
    level thread forcegameendcontesttimeout();
}

// Namespace arena_alt
// Params 0
// Checksum 0x5b8200e1, Offset: 0x803b
// Size: 0x80
function forcegameendcontesttimeout()
{
    level notify( #"hash_488b9b75c6bd2397" );
    level endon( #"hash_488b9b75c6bd2397" );
    level endon( #"game_ended" );
    
    if ( !isdefined( level.ottimecontested ) )
    {
        level.ottimecontested = 0;
    }
    
    while ( level.ottimecontested < 5000 )
    {
        wait level.framedurationseconds;
        level.ottimecontested += level.frameduration;
    }
    
    level.canprocessot = 1;
}

// Namespace arena_alt
// Params 0
// Checksum 0x6e733686, Offset: 0x80c3
// Size: 0x3e
function disableotflag()
{
    gameobjects::allowuse( "none" );
    gameobjects::disableobject();
    
    if ( isdefined( self.scriptable ) )
    {
        self.scriptable delete();
    }
    
    self.flagmodel hide();
}

// Namespace arena_alt
// Params 0
// Checksum 0x26353529, Offset: 0x8109
// Size: 0x74
function removeflagoutlineongameend()
{
    level waittill( #"game_ended" );
    
    if ( isdefined( level.arenaflag ) && isdefined( level.arenaflag.flagmodel.outlinedid ) )
    {
        outline::outlinedisable( level.arenaflag.flagmodel.outlinedid, level.arenaflag.flagmodel );
    }
}

// Namespace arena_alt
// Params 0
// Checksum 0x5c18fbfd, Offset: 0x8185
// Size: 0x1b
function deleteotpreview()
{
    level utility::waittill_any( "prematch_done", "start_mode_setup" );
    disableotflag();
}

// Namespace arena_alt
// Params 0
// Checksum 0x755da572, Offset: 0x81a8
// Size: 0xc0
function setupendzones()
{
    level.attackerendzone = getentarray( "flag_goal_attacker", #targetname );
    level.defenderendzone = getentarray( "flag_goal_defender", #targetname );
    level.attackerendzone = level.attackerendzone[ 0 ] createendzone( game[ "attackers" ] );
    level.defenderendzone = level.defenderendzone[ 0 ] createendzone( game[ "defenders" ] );
    level.objectives = [];
    level.objectives[ level.objectives.size ] = level.attackerendzone;
    level.objectives[ level.objectives.size ] = level.defenderendzone;
}

// Namespace arena_alt
// Params 1
// Checksum 0x95015c91, Offset: 0x8270
// Size: 0x4b0
function createendzone( team )
{
    if ( isdefined( self.target ) )
    {
        visuals[ 0 ] = getent( self.target, #targetname );
    }
    else
    {
        visuals[ 0 ] = spawn( "script_model", self.origin );
        visuals[ 0 ].angles = self.angles;
    }
    
    level.flagcapturetime = dvars::dvarfloatvalue( "flagCaptureTime", 10, 0, 30 );
    
    if ( isdefined( self.objectivekey ) )
    {
        objectivekey = self.objectivekey;
    }
    else
    {
        objectivekey = self.script_label;
    }
    
    if ( isdefined( self.iconname ) )
    {
        iconname = self.iconname;
    }
    else
    {
        iconname = self.script_label;
    }
    
    endzone = gameobjects::createuseobject( team, self, visuals, ( 0, 0, 100 ) );
    endzone.team = team;
    endzone.ownerteam = team;
    endzone gameobjects::setobjectivestatusicons( level.icondefendendzone, level.iconcaptureendzone );
    endzone gameobjects::allowuse( "enemy" );
    endzone gameobjects::cancontestclaim( 1 );
    endzone gameobjects::setusetime( level.flagcapturetime );
    endzone.onuse = &endzone_onuse;
    endzone.onbeginuse = &endzone_onusebegin;
    endzone.onenduse = &endzone_onuseend;
    endzone.oncontested = &endzone_oncontested;
    endzone.onuncontested = &endzone_onuncontested;
    endzone.isarena = 1;
    endzone gameobjects::pinobjiconontriggertouch();
    endzone.id = "domFlag";
    
    if ( isdefined( level.capturetype ) )
    {
        endzone gameobjects::setcapturebehavior( getcapturetype() );
    }
    
    endzone.objectivekey = objectivekey;
    endzone.iconname = iconname;
    endzone gameobjects::setvisibleteam( "any" );
    endzone.stompprogressreward = &endzone_stompprogressreward;
    endzone.nousebar = 1;
    endzone.claimgracetime = level.flagcapturetime * 1000;
    tracestart = visuals[ 0 ].origin + ( 0, 0, 32 );
    traceend = visuals[ 0 ].origin + ( 0, 0, -32 );
    contentoverride = trace::create_contents( 1, 1, 1, 1, 0, 1, 1 );
    ignoreents = [];
    trace = trace::ray_trace( tracestart, traceend, ignoreents, contentoverride );
    endzone.baseeffectpos = trace[ "position" ];
    upangles = vectortoangles( trace[ "normal" ] );
    endzone.baseeffectforward = anglestoforward( upangles );
    scriptable = spawn( "script_model", endzone.baseeffectpos );
    scriptable setmodel( "dom_flag_scriptable" );
    scriptable.angles = generateaxisanglesfromforwardvector( endzone.baseeffectforward, scriptable.angles );
    endzone.scriptable = scriptable;
    endzone.vfxnamemod = "";
    
    if ( isdefined( endzone.trigger.radius ) )
    {
        if ( endzone.trigger.radius == 160 )
        {
            endzone.vfxnamemod = "_160";
        }
        else if ( endzone.trigger.radius == 90 )
        {
            endzone.vfxnamemod = "_90";
        }
        else if ( endzone.trigger.radius == 315 )
        {
            endzone.vfxnamemod = "_300";
        }
        else if ( endzone.trigger.radius != 120 )
        {
            endzone.noscriptable = 1;
        }
    }
    
    endzone.flagmodel = spawn( "script_model", endzone.baseeffectpos );
    endzone.flagmodel setmodel( "military_dom_flag_neutral" );
    endzone.outlineent = endzone.flagmodel;
    return endzone;
}

// Namespace arena_alt
// Params 1
// Checksum 0x95e7ce7a, Offset: 0x8729
// Size: 0x128
function endzone_onusebegin( player )
{
    player.iscapturing = 1;
    level.canprocessot = 0;
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
    
    usetime = level.flagneutralization ? level.flagcapturetime * 0.5 : level.flagcapturetime;
    gameobjects::setusetime( usetime );
    
    if ( level.capturedecay )
    {
        thread gameobjects::useobjectdecay( player.team );
    }
    
    if ( usetime > 0 )
    {
        self.prevownerteam = team_utility::getotherteam( player.team );
        obj_dom::updateflagcapturestate( player.team );
        gameobjects::setobjectivestatusicons( level.icontakingendzone, level.iconlosingendzone );
    }
}

// Namespace arena_alt
// Params 3
// Checksum 0xcca9b103, Offset: 0x8859
// Size: 0x9d
function endzone_onuseend( team, player, success )
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
    
    ownerteam = gameobjects::getownerteam();
    gameobjects::setobjectivestatusicons( level.icondefendendzone, level.iconcaptureendzone );
    
    if ( !success )
    {
        self.neutralized = 0;
    }
}

// Namespace arena_alt
// Params 1
// Checksum 0x69a45da7, Offset: 0x88fe
// Size: 0xe6
function endzone_onuse( credit_player )
{
    level.canprocessot = 1;
    team = credit_player.team;
    oldteam = gameobjects::getownerteam();
    otherteam = team_utility::getotherteam( team );
    self.capturetime = gettime();
    self.neutralized = 0;
    thread print::printandsoundoneveryone( team, otherteam, undefined, undefined, "mp_dom_flag_captured", "mp_dom_flag_lost", credit_player );
    endzone_setcaptured( team, credit_player );
    
    if ( !self.neutralized )
    {
        if ( isdefined( level.onobjectivecomplete ) )
        {
            [[ level.onobjectivecomplete ]]( "dompoint", self.objectivekey, credit_player, team, oldteam, self );
        }
    }
    
    level thread arena_endgame( credit_player.team, game[ "end_reason" ][ "objective_completed" ], undefined, 0, 2 );
}

// Namespace arena_alt
// Params 0
// Checksum 0x302bcf21, Offset: 0x89ec
// Size: 0x23
function endzone_oncontested()
{
    gameobjects::setobjectivestatusicons( level.iconcontestendzone );
    objidpoolmanager::objective_set_progress_team( self.objidnum, undefined );
}

// Namespace arena_alt
// Params 1
// Checksum 0x9e568bfa, Offset: 0x8a17
// Size: 0x42
function endzone_onuncontested( lastclaimteam )
{
    ownerteam = gameobjects::getownerteam();
    gameobjects::setobjectivestatusicons( level.icondefendendzone, level.iconcaptureendzone );
    self.processot = 1;
}

// Namespace arena_alt
// Params 2
// Checksum 0xce6ab82e, Offset: 0x8a61
// Size: 0x13e
function endzone_setcaptured( team, credit_player )
{
    gameobjects::setownerteam( team );
    self notify( #"capture", credit_player );
    self notify( #"assault", credit_player );
    gameobjects::setobjectivestatusicons( level.icondefendendzone, level.iconcaptureendzone );
    self.neutralized = 0;
    
    if ( self.touchlist[ team ].size == 0 )
    {
        self.touchlist = self.oldtouchlist;
    }
    
    thread giveflagcapturexp( self.touchlist[ team ], credit_player );
    
    if ( isdefined( level.matchrecording_logevent ) )
    {
        [[ level.matchrecording_logevent ]]( self.logid, undefined, self.logeventflag, self.visuals[ 0 ].origin[ 0 ], self.visuals[ 0 ].origin[ 1 ], gettime(), team == "allies" ? 1 : 2 );
    }
    
    analyticslog::logevent_gameobject( self.analyticslogtype, self.analyticslogid, self.visuals[ 0 ].origin, -1, "captured_" + team );
}

// Namespace arena_alt
// Params 1
// Checksum 0x153d3f38, Offset: 0x8ba7
// Size: 0x15
function endzone_stompprogressreward( player )
{
    player events::function_a7d373228760063b();
}

// Namespace arena_alt
// Params 0
// Checksum 0x23477801, Offset: 0x8bc4
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

// Namespace arena_alt
// Params 2
// Checksum 0x79f6b9cc, Offset: 0x8c11
// Size: 0x253
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
            
            assert( isint( 1 ) || isfloat( 1 ), "<dev string:x333>" );
            
            if ( isdefined( player.pers[ "captures" ] ) )
            {
                player.pers[ "captures" ] = player.pers[ "captures" ] + 1;
            }
        }
        
        player persistence::statsetchild( "round", "captures", player.pers[ "captures" ] );
        player thread points::doscoreevent( #"mode_dom_secure" );
        player thread smoke_grenade::function_99543ad5d551cdb5();
        wait 0.05;
    }
}

// Namespace arena_alt
// Params 0
// Checksum 0x16760385, Offset: 0x8e6c
// Size: 0x1f1
function startotmechanics()
{
    if ( level.objmodifier == 1 )
    {
        foreach ( objective in level.objectives )
        {
            objective deleteendzone();
        }
    }
    
    level.canprocessot = 1;
    
    if ( !isdefined( level.arenaflag.objidnum ) )
    {
        level.arenaflag gameobjects::requestid( 1, 1, undefined, 0, 0 );
    }
    
    level.arenaflag gameobjects::setobjectivestatusicons( level.iconneutral );
    level.arenaflag gameobjects::enableobject();
    level.arenaflag gameobjects::allowuse( "enemy" );
    level.arenaflag.flagmodel show();
    
    if ( level.spawnflag )
    {
        game[ "dialog" ][ "overtime" ] = "gamestate_overtime_flagspawn";
    }
    
    foreach ( player in level.players )
    {
        if ( player issplitscreenplayer() && !player issplitscreenplayerprimary() )
        {
            continue;
        }
        
        player dialog::leaderdialogonplayer( "overtime" );
    }
    
    level.arenaflag.flagmodel playsound( "flag_spawned" );
    level thread showflagoutline();
}

// Namespace arena_alt
// Params 0
// Checksum 0x833348fd, Offset: 0x9065
// Size: 0x6e
function deleteendzone()
{
    gameobjects::allowuse( "none" );
    gameobjects::setvisibleteam( "none" );
    gameobjects::releaseid();
    self.trigger = undefined;
    self notify( #"deleted" );
    self.visibleteam = "none";
    
    if ( isdefined( self.scriptable ) )
    {
        self.scriptable delete();
    }
    
    self.flagmodel delete();
}

// Namespace arena_alt
// Params 1
// Checksum 0xcc7ab4e3, Offset: 0x90db
// Size: 0xc
function dogtagallyonusecb( player )
{
    
}

// Namespace arena_alt
// Params 1
// Checksum 0xdc10fdbb, Offset: 0x90ef
// Size: 0x30
function dogtagenemyonusecb( player )
{
    player.health = player.maxhealth;
    player notify( #"healed" );
}

// Namespace arena_alt
// Params 0
// Checksum 0xd985b482, Offset: 0x9127
// Size: 0x1c5
function outlineenemyplayers()
{
    level endon( #"prematch_done" );
    level endon( #"removeArenaOutlines" );
    
    while ( true )
    {
        level waittill( #"spawned_player" );
        waitframe();
        
        foreach ( player in level.players )
        {
            entnum = player getentitynumber();
            
            if ( !isdefined( player.outlinedenemies ) )
            {
                if ( !isdefined( level.activeoutlines ) )
                {
                    level.activeoutlines = 1;
                }
                else
                {
                    level.activeoutlines++;
                }
            }
            
            foreach ( p in level.players )
            {
                if ( p != player && p.team != player.team )
                {
                    if ( isdefined( player.outlinedenemies ) )
                    {
                        outline::outlinedisable( player.outlinedenemies, player );
                    }
                    
                    player.outlinedenemies = outline::outlineenableforteam( player, p.team, "outline_nodepth_orange", "level_script" );
                    break;
                }
            }
        }
    }
}

// Namespace arena_alt
// Params 0
// Checksum 0x1333c1ae, Offset: 0x92f4
// Size: 0x1c5
function outlineenemyplayerslaunchchunk()
{
    level endon( #"game_ended" );
    level endon( #"removeArenaOutlines" );
    
    while ( true )
    {
        level waittill( #"spawned_player" );
        waitframe();
        
        foreach ( player in level.players )
        {
            entnum = player getentitynumber();
            
            if ( !isdefined( player.outlinedenemies ) )
            {
                if ( !isdefined( level.activeoutlines ) )
                {
                    level.activeoutlines = 1;
                }
                else
                {
                    level.activeoutlines++;
                }
            }
            
            foreach ( p in level.players )
            {
                if ( p != player && p.team != player.team )
                {
                    if ( isdefined( player.outlinedenemies ) )
                    {
                        outline::outlinedisable( player.outlinedenemies, player );
                    }
                    
                    player.outlinedenemies = outline::outlineenableforteam( player, p.team, "outline_nodepth_orange", "level_script" );
                    break;
                }
            }
        }
    }
}

// Namespace arena_alt
// Params 0
// Checksum 0x44bdfdb5, Offset: 0x94c1
// Size: 0xd3
function removeenemyoutlines()
{
    thread notifyremoveoutlines();
    level utility::waittill_any( "prematch_done", "removeArenaOutlines" );
    
    foreach ( player in level.players )
    {
        entnum = player getentitynumber();
        
        if ( isdefined( player.outlinedenemies ) )
        {
            level.activeoutlines--;
            outline::outlinedisable( player.outlinedenemies, player );
            player.outlinedenemies = undefined;
        }
    }
}

// Namespace arena_alt
// Params 0
// Checksum 0xdb980117, Offset: 0x959c
// Size: 0x76
function notifyremoveoutlines()
{
    level endon( #"prematch_done" );
    level waittill( #"match_start_real_countdown" );
    
    if ( level.prematchperiodend > 5 )
    {
        time = int( max( level.prematchperiodend - 5, 5 ) );
    }
    else
    {
        time = int( max( level.prematchperiodend - 2, 2 ) );
    }
    
    wait time;
    level notify( #"removeArenaOutlines" );
}

// Namespace arena_alt
// Params 2
// Checksum 0x44b90ec7, Offset: 0x961a
// Size: 0x1b4
function outlineequipmentwatchplayerprox( equipmentmodel, equipname )
{
    self endon( #"death" );
    self endon( #"trigger" );
    self.outlinedplayers = [];
    basescore = level.baseraritymap[ equipname ];
    outlineasset = getoutlineasset( basescore );
    
    while ( true )
    {
        foreach ( player in level.players )
        {
            if ( isdefined( player.hasarenaspawned ) )
            {
                dist = distance2dsquared( self.origin, player.origin );
                entnum = player getentitynumber();
                
                if ( dist < 490000 )
                {
                    if ( !isdefined( self.outlinedplayers[ entnum ] ) )
                    {
                        if ( !isdefined( level.activeoutlines ) )
                        {
                            level.activeoutlines = 1;
                        }
                        else
                        {
                            level.activeoutlines++;
                        }
                        
                        self.outlinedplayers[ entnum ] = outline::outlineenableforplayer( self, player, outlineasset, "level_script" );
                    }
                    
                    continue;
                }
                
                if ( isdefined( self.outlinedplayers[ entnum ] ) )
                {
                    level.activeoutlines--;
                    outline::outlinedisable( self.outlinedplayers[ entnum ], self );
                    self.outlinedplayers[ entnum ] = undefined;
                }
            }
        }
        
        waitframe();
    }
}

// Namespace arena_alt
// Params 0
// Checksum 0x8477c158, Offset: 0x97d6
// Size: 0x1c0
function outlinewatchplayerprox()
{
    self endon( #"death" );
    self endon( #"trigger" );
    self.outlinedplayers = [];
    rootname = weapon::getweaponrootname( self.objweapon );
    basescore = level.baseraritymap[ rootname + "_mp" ];
    outlineasset = getoutlineasset( basescore );
    
    while ( true )
    {
        foreach ( player in level.players )
        {
            if ( isdefined( player.hasarenaspawned ) )
            {
                dist = distance2dsquared( self.origin, player.origin );
                entnum = player getentitynumber();
                
                if ( dist < 490000 )
                {
                    if ( !isdefined( self.outlinedplayers[ entnum ] ) )
                    {
                        if ( !isdefined( level.activeoutlines ) )
                        {
                            level.activeoutlines = 1;
                        }
                        else
                        {
                            level.activeoutlines++;
                        }
                        
                        self.outlinedplayers[ entnum ] = outline::outlineenableforplayer( self, player, outlineasset, "level_script" );
                    }
                    
                    continue;
                }
                
                if ( isdefined( self.outlinedplayers[ entnum ] ) )
                {
                    level.activeoutlines--;
                    outline::outlinedisable( self.outlinedplayers[ entnum ], self );
                    self.outlinedplayers[ entnum ] = undefined;
                }
            }
        }
        
        waitframe();
    }
}

// Namespace arena_alt
// Params 1
// Checksum 0xeec79337, Offset: 0x999e
// Size: 0x10d
function getoutlineasset( basescore = 0 )
{
    outlineasset = "white";
    score = int( min( basescore, 8 ) );
    
    switch ( score )
    {
        case 0:
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
        case 5:
            outlineasset = "outline_depth_yellow";
            break;
        case 6:
            outlineasset = "outline_depth_blue";
            break;
        case 7:
            outlineasset = "outline_depth_green";
            break;
        case 8:
            outlineasset = "outline_depth_red";
            break;
    }
    
    return outlineasset;
}

// Namespace arena_alt
// Params 0
// Checksum 0xdf7b0431, Offset: 0x9ab4
// Size: 0x89
function clearweaponoutlines()
{
    foreach ( value in self.outlinedplayers )
    {
        level.activeoutlines--;
        outline::outlinedisable( value, self );
        value = undefined;
    }
}

// Namespace arena_alt
// Params 0
// Checksum 0x6bfd3bbc, Offset: 0x9b45
// Size: 0x250
function selflookatfriendly()
{
    level endon( #"prematch_ended" );
    teammate = undefined;
    startlook = 0;
    
    while ( level.matchcountdowntime > 5 )
    {
        alive = teams::getfriendlyplayers( self.team, 1 );
        
        if ( alive.size > 1 )
        {
            startlook = 1;
            break;
        }
        
        waitframe();
    }
    
    if ( startlook )
    {
        normalangles = self.angles;
        count = 0;
        teammates = teams::getteamdata( self.team, "players" );
        
        foreach ( t in teammates )
        {
            if ( t != self )
            {
                teammate = t;
            }
        }
        
        teammatedir = teammate.origin - self.origin;
        selfdir = self.origin - teammate.origin;
        var_b199f4ee66f1d5de = anglestoright( self.angles );
        selfdot = vectordot( var_b199f4ee66f1d5de, teammatedir );
        lookleft = 0;
        lookright = 0;
        
        if ( selfdot < 0 )
        {
            lerpangles = 85;
            lookleft = 1;
        }
        else
        {
            lerpangles = -90;
            lookright = 1;
        }
        
        if ( isdefined( teammate ) )
        {
            if ( lookleft )
            {
                if ( !isbot( self ) )
                {
                    wait 0.5;
                    
                    if ( self.currentweapon.basename != "none" )
                    {
                        self forceplaygestureviewmodel( "ges_crush_turnleft" );
                    }
                }
            }
            else if ( !isbot( self ) )
            {
                wait 0.5;
                
                if ( self.currentweapon.basename != "none" )
                {
                    self forceplaygestureviewmodel( "ges_crush_turnright" );
                }
            }
            
            wait 3;
            player::_freezecontrols( 0 );
        }
        else
        {
            player::_freezecontrols( 0 );
        }
        
        return;
    }
    
    player::_freezecontrols( 0 );
}

// Namespace arena_alt
// Params 0
// Checksum 0x1b169ac1, Offset: 0x9d9d
// Size: 0x1e
function updatematchstatushintonspawn()
{
    level endon( #"game_ended" );
    hud_message::function_ef4318a0090caa0f( #"kill" );
}

// Namespace arena_alt
// Params 0
// Checksum 0x9f624a8d, Offset: 0x9dc3
// Size: 0x9c
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
}

// Namespace arena_alt
// Params 0
// Checksum 0xbee758e, Offset: 0x9e67
// Size: 0x24b
function setupwaypointicons()
{
    gamelogic_mp::setwaypointiconinfo( "waypoint_taking_endzone", 0, "contest", "MP_INGAME_ONLY/OBJ_TAKING_CAPS", "icon_waypoint_flag", 0 );
    gamelogic_mp::setwaypointiconinfo( "waypoint_losing_endzone", 0, "contest", "MP_INGAME_ONLY/OBJ_LOSING_CAPS", "icon_waypoint_flag", 0 );
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
    gamelogic_mp::setwaypointiconinfo( "icon_waypoint_ot_a", 0, "neutral", "MP_INGAME_ONLY/OBJ_OTFLAGLOC_CAPS", "icon_waypoint_overtime", 0 );
    gamelogic_mp::setwaypointiconinfo( "waypoint_dogtags", 1, "enemy", "", "ui_icon_minimap_tags", 0 );
    gamelogic_mp::setwaypointiconinfo( "waypoint_dogtags_friendly", 1, "friendly", "", "ui_icon_minimap_tags", 0 );
}

// Namespace arena_alt
// Params 0
// Checksum 0xb03f2a06, Offset: 0xa0ba
// Size: 0xe, Type: bool
function israndomloadouts()
{
    return level.arenaloadouts == 2;
}

// Namespace arena_alt
// Params 0
// Checksum 0x6b067ce8, Offset: 0xa0d1
// Size: 0xe, Type: bool
function ispickuploadouts()
{
    return level.arenaloadouts == 3;
}

// Namespace arena_alt
// Params 0
// Checksum 0x174c3b18, Offset: 0xa0e8
// Size: 0xe, Type: bool
function isgungameloadouts()
{
    return level.arenaloadouts == 4;
}

// Namespace arena_alt
// Params 0
// Checksum 0xa4e3cf8b, Offset: 0xa0ff
// Size: 0xe, Type: bool
function isrvsgungameloadouts()
{
    return level.arenaloadouts == 5;
}

// Namespace arena_alt
// Params 0
// Checksum 0x78d0495d, Offset: 0xa116
// Size: 0xe, Type: bool
function israndompreviewloadouts()
{
    return level.arenaloadouts == 6;
}

// Namespace arena_alt
// Params 0
// Checksum 0x2d58f371, Offset: 0xa12d
// Size: 0xe, Type: bool
function israndomalphaoneloadouts()
{
    return level.arenaloadouts == 7;
}

// Namespace arena_alt
// Params 0
// Checksum 0xee1a904d, Offset: 0xa144
// Size: 0xe, Type: bool
function israndomalphatwoloadouts()
{
    return level.arenaloadouts == 8;
}

// Namespace arena_alt
// Params 0
// Checksum 0x5d780cdc, Offset: 0xa15b
// Size: 0xe, Type: bool
function israndomalphathreeloadouts()
{
    return level.arenaloadouts == 9;
}

// Namespace arena_alt
// Params 0
// Checksum 0x2fd0b763, Offset: 0xa172
// Size: 0xe, Type: bool
function israndomalphafourloadouts()
{
    return level.arenaloadouts == 10;
}

// Namespace arena_alt
// Params 0
// Checksum 0xe4f3e99a, Offset: 0xa189
// Size: 0xe, Type: bool
function israndomalphafiveloadouts()
{
    return level.arenaloadouts == 11;
}

// Namespace arena_alt
// Params 0
// Checksum 0x4515ef1, Offset: 0xa1a0
// Size: 0x60
function israndomalphaloadouts()
{
    switch ( level.arenaloadouts )
    {
        case 7:
        case 8:
        case 9:
        case 10:
        case 11:
            return 1;
        default:
            return 0;
    }
}

// Namespace arena_alt
// Params 1
// Checksum 0x875e652b, Offset: 0xa208
// Size: 0x39
function dogtagallyonusecbconf( player )
{
    if ( isplayer( player ) )
    {
        player gamescore::giveteamscoreforobjective( player.pers[ "team" ], level.scoredeny, 0 );
    }
}

// Namespace arena_alt
// Params 1
// Checksum 0xf597fc0e, Offset: 0xa249
// Size: 0x4c
function dogtagenemyonusecbconf( player )
{
    if ( isplayer( player ) )
    {
        player dialog::leaderdialogonplayer( "kill_confirmed", undefined, undefined, undefined, 4 );
    }
    
    player gamescore::giveteamscoreforobjective( player.pers[ "team" ], level.scoreconfirm, 0 );
}

// Namespace arena_alt
// Params 0
// Checksum 0x85fe6ebc, Offset: 0xa29d
// Size: 0x183
function botpickuphack()
{
    level endon( #"game_ended" );
    wait 1;
    flags::gameflagwait( "prematch_done" );
    wait 1;
    
    while ( true )
    {
        foreach ( player in level.players )
        {
            if ( isbot( player ) )
            {
                rootname = weapon::getweaponrootname( level.arenaweapont1 );
                attachments = [];
                newweaponobj = weapon::buildweapon( rootname, attachments, "camo_none", "none", -1 );
                newweapon = getcompleteweaponname( newweaponobj );
                player inventory_utility::_giveweapon( newweapon );
                player inventory_utility::_switchtoweapon( newweaponobj );
            }
        }
        
        break;
    }
    
    foreach ( player in level.players )
    {
        if ( isbot( player ) )
        {
            player thread fakepickups();
        }
    }
}

// Namespace arena_alt
// Params 0
// Checksum 0x3ad914e, Offset: 0xa428
// Size: 0xe6
function fakepickups()
{
    while ( true )
    {
        wait 1;
        
        if ( self.currentprimaryweapon.basename != "iw8_pi_decho_mp" && self.currentprimaryweapon.basename != "iw8_pi_mike1911_mp" && self.currentprimaryweapon.basename != "iw9_me_fists_mp" && self.currentprimaryweapon.basename != "none" )
        {
            wait 3;
        }
        
        if ( !self attackbuttonpressed() && !self isreloading() && !self usebuttonpressed() )
        {
            self botpressbutton( "use", 0.5 );
            continue;
        }
        
        wait 0.5;
        
        if ( !self attackbuttonpressed() && !self isreloading() && !self usebuttonpressed() )
        {
            self botpressbutton( "use", 0.5 );
        }
    }
}

// Namespace arena_alt
// Params 0
// Checksum 0xf11ef6c5, Offset: 0xa516
// Size: 0xb6
function bootcampmodewatcher()
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        modevalue = getdvarint( @"hash_52b2904136c93f2b" );
        
        if ( modevalue != -1 )
        {
            timelimit = 3;
            level.starttime = gettime();
            gamemode = dvars::function_1165fde71640a2d1( "timelimit" );
            level.watchdvars[ gamemode ].value = timelimit;
            level.overridewatchdvars[ gamemode ] = timelimit;
            
            /#
                setdevdvar( gamemode, timelimit );
            #/
            
            game[ "bootCampOverride" ] = modevalue;
            
            /#
                setdevdvar( @"hash_52b2904136c93f2b", -1 );
            #/
        }
        
        wait 1;
    }
}

