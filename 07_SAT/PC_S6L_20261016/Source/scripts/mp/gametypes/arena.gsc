// scripts\mp\gametypes\arena.gsc  (hash_3686609f08f20087.gscc) (size: 145832 Bytes / 0x239a8 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x3a113f64 (974208868)
// size ...... 145832 (0x239a8)
// includes .. 61  (offset: 0x1ff90)
// strings ... 731 (offset: 0x20178)
// dev strs .. 65  (offset: 0x2364c)
// exports ... 245 (offset: 0x17ed8)
// cseg ...... 0x34c5 + 0x14a13 (0x17ed8)
// imports ... 649 (offset: 0x1a520)
// animtree1 . 0   (offset: 0x239a8)
// animtree2 . 0   (offset: 0x239a8)
#using script_382bf8d77c4fd348;
#using script_3bdadfff7554ceba;
#using script_5adc0ee463b8a974;
#using script_6800334345ed1df0;
#using scripts\common\callback_sequence;
#using scripts\common\callbacks;
#using scripts\common\gameplay_sound_fx;
#using scripts\common\max_heap;
#using scripts\common\telemetry_utils;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\common\weapon;
#using scripts\mp\analyticslog;
#using scripts\mp\battlechatter_mp;
#using scripts\mp\class;
#using scripts\mp\codcaster_utils;
#using scripts\mp\common\equipment\smoke_grenade;
#using scripts\mp\common\gameobjects\gameobjects_common;
#using scripts\mp\common\gameobjects\gameobjects_shared;
#using scripts\mp\common\utility\debug_utility;
#using scripts\mp\common\utility\dialog;
#using scripts\mp\common\utility\dialog_utility;
#using scripts\mp\common\utility\dvars;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\inventory_utility;
#using scripts\mp\common\utility\loot;
#using scripts\mp\common\utility\outline;
#using scripts\mp\common\utility\perk;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\stats;
#using scripts\mp\common\utility\team_utility;
#using scripts\mp\common\utility\teams;
#using scripts\mp\common\utility\trigger;
#using scripts\mp\equipment;
#using scripts\mp\events;
#using scripts\mp\flags;
#using scripts\mp\gameinstance;
#using scripts\mp\gamelogic;
#using scripts\mp\gameobjects;
#using scripts\mp\gamescore;
#using scripts\mp\gametypes\arena_alt;
#using scripts\mp\gametypes\common;
#using scripts\mp\gametypes\obj_dogtag;
#using scripts\mp\gametypes\obj_dom;
#using scripts\mp\globallogic;
#using scripts\mp\hostmigration;
#using scripts\mp\hud_message;
#using scripts\mp\hud_util;
#using scripts\mp\objectiveiconstates;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\persistence;
#using scripts\mp\playerhealth;
#using scripts\mp\rank;
#using scripts\mp\spawnlogic;
#using scripts\mp\spawnscoring;
#using scripts\mp\spectating;
#using scripts\mp\squads;
#using scripts\mp\teams;

#namespace arena;

// Namespace arena
// Params 0, eflags: 0x5
// Checksum 0xc2793516, Offset: 0x34e3
// Size: 0x42
function private autoexec init()
{
    setdvarifuninitialized( @"hash_5916a9a91e74215d", 0, 0, 1 );
    level.arena = spawnstruct();
    level.arena.var_91bebe9b68b5f92f = getdvarint( @"hash_5916a9a91e74215d" );
}

// Namespace arena
// Params 0
// Checksum 0xcc2cfb62, Offset: 0x352d
// Size: 0x787
function main()
{
    game[ "isLaunchChunk" ] = getdvarint( @"hash_61939eb22f175afa", 0 ) != 0;
    
    if ( getdvar( @"g_mapname" ) == "mp_background" )
    {
        return;
    }
    
    globallogic::init();
    globallogic::setupcallbacks();
    level.carryflag_starts = [];
    cyberemptriggers = getentarray( "cyber_emp_pickup_trig", #targetname );
    
    foreach ( trig in cyberemptriggers )
    {
        level.carryflag_starts[ level.carryflag_starts.size ] = trig.origin;
    }
    
    level.var_219bddd738fb224 = ( 0, 0, 0 );
    primaryflags = getentarray( "flag_primary", #targetname );
    
    foreach ( flag in primaryflags )
    {
        if ( flag.script_label == "_b" )
        {
            level.var_219bddd738fb224 = flag.origin;
            break;
        }
    }
    
    if ( level.carryflag_starts.size == 0 )
    {
        level.carryflag_starts[ level.carryflag_starts.size ] = level.var_219bddd738fb224;
    }
    
    if ( game[ "isLaunchChunk" ] )
    {
        arena_alt::main();
        return;
    }
    
    level.initializematchrules = &initializematchrules;
    [[ level.initializematchrules ]]();
    level thread game_utility_mp::reinitializematchrulesonmigration();
    updategametypedvars();
    callback::add( #"player_spawned", &onspawnplayer );
    callback::add( #"player_death", &onplayerkilled );
    callback::add( #"round_ended", &onroundended );
    
    if ( isdefined( level.gametypebundle.var_ae100eea97c7fcc7[ #"hash_14bb716c4b77c45a" ] ) )
    {
        gunfight_ot_flag_init_struct = { #manual_drop:1, #var_7f4958ce4e4277c3:#"hash_bb332da19f9944df", #capture_segment_count:1, #var_333d3689d793bcc7:0, #use_time_seconds:0, #var_c68e9f43ed9cc918:#"hash_a1360b18943e920", #var_d7c90dc73c1dcba8:( 0, 0, 0 ), #objective_icon_offset:( 0, 0, 0 ), #angles:( 0, 0, 0 ), #origin:( 0, 0, 0 ) };
        gunfight_ot_flag_init_struct.use_time_seconds = level.flagcapturetime;
        var_36671917263a4dfc = [ &function_728d9ac776e1504, &function_c93981e411e9f4d4 ];
        gameobjects_common::function_22117b1fd559026f( #"gunfight_ot_flag", gunfight_ot_flag_init_struct, var_36671917263a4dfc );
    }
    else
    {
        game_utility_mp::clean_up_entities( [ game_utility::getgametype(), "dom" ] );
    }
    
    level.teambased = 1;
    level.objectivebased = 1;
    level.overridetimelimitclock = 10;
    level.onplayerconnect = &onplayerconnect;
    level.ontimelimit = &ontimelimit;
    level.onstartgametype = &onstartgametype;
    level.getspawnpoint = &getspawnpoint;
    level.onplayerdamaged = &onplayerdamaged;
    level.onnormaldeath = &onnormaldeath;
    level.ondeadevent = &ondeadevent;
    level.ontimelimitot = &ontimelimitot;
    level.var_e4b03a4f3e97879c = &function_6a54a1b3d25c4413;
    level.var_813f2ea1f9452bdb = &function_bfd7c2041520319b;
    level.snowballfight = getdvarint( @"hash_6c1b43f9065ddf4d", 0 );
    level.ononeleftevent = &ononeleftevent;
    level.allowlatecomers = 0;
    
    if ( game_utility_mp::matchmakinggame() )
    {
        teamsize = getdvarint( @"party_maxplayers", 4 ) / 2;
        level.requiredplayercountoveride = 1;
        level.requiredplayercount[ "allies" ] = teamsize;
        level.requiredplayercount[ "axis" ] = teamsize;
    }
    else
    {
        teamsize = 2;
        level.requiredplayercountoveride = 1;
        level.requiredplayercount[ "allies" ] = teamsize;
        level.requiredplayercount[ "axis" ] = teamsize;
    }
    
    if ( !game_utility_mp::iswinbytworulegametype() )
    {
        level.skipdefendersadvantage = 1;
    }
    
    if ( !isnormalloadouts() )
    {
        level.disablecopycatloadout = 1;
        setomnvar( "ui_killcam_copycat", 0 );
        level.bypassclasschoicefunc = &class::alwaysgamemodeclass;
    }
    else
    {
        level.disablecopycatloadout = undefined;
    }
    
    level.arenaknivesout = getknivesoutsetting();
    
    if ( level.arenaknivesout )
    {
        level.gamemodeoverridemeleeviewkickscale = 0.5;
        level.gamemodeoverriderestockrechargeperupdate = 0.05;
    }
    
    if ( level.snowballfight )
    {
        level.alwayssnowfight = getdvarint( @"scr_always_snowfight", 0 );
        
        if ( level.alwayssnowfight )
        {
            level.practiceround = 0;
        }
        else
        {
            level.practiceround = 1;
        }
    }
    
    level.usedspawnposone[ "allies" ] = 0;
    level.usedspawnpostwo[ "allies" ] = 0;
    level.usedspawnposthree[ "allies" ] = 0;
    level.usedspawnposone[ "axis" ] = 0;
    level.usedspawnpostwo[ "axis" ] = 0;
    level.usedspawnposthree[ "axis" ] = 0;
    setomnvar( "ui_arena_primaryVariantID", -1 );
    setomnvar( "ui_arena_secondaryVariantID", -1 );
    
    /#
        level thread function_314cda4bacff3255();
    #/
    
    if ( !getdvarint( @"ui_team_gunfight", 0 ) )
    {
        namespace_a60e6d7e4e2fbfbf::function_9c34b2b20eea4249( 2 );
    }
    else
    {
        namespace_a60e6d7e4e2fbfbf::function_9c34b2b20eea4249( 6 );
    }
    
    if ( !isdefined( game[ "arenaTeamSize" ] ) )
    {
        game[ "arenaTeamSize" ] = 2;
    }
    
    utility::registersharedfunc( #"arena", #"randomize_loadouts", &randomize_loadouts );
    
    if ( level.projectbundle.var_786bc1b37b3f67fa )
    {
        utility::registersharedfunc( #"player", #"hash_c631568a218d88a6", &get_player_operator );
        utility::registersharedfunc( #"player", #"hash_3f6034cbc65791c3", &get_player_operator_skin );
    }
    
    /#
        utility::registersharedfunc( #"arena", #"hash_a2c6c6b047059003", isdefined( level.gametypebundle.var_ae100eea97c7fcc7[ #"hash_14bb716c4b77c45a" ] ) ? &function_5d3f61394e192bb6 : &enableotflag );
        utility::registersharedfunc( #"arena", #"hash_4b2010a7914e3680", isdefined( level.gametypebundle.var_ae100eea97c7fcc7[ #"hash_14bb716c4b77c45a" ] ) ? &function_e3f5506cb1b0fdb : &disableotflag );
    #/
}

// Namespace arena
// Params 0
// Checksum 0x6832fadb, Offset: 0x3cbc
// Size: 0xa7
function function_938e44e19a0f97e0()
{
    locs = utility::getstructarray( "weapon_pickup", "targetname" );
    
    foreach ( loc in locs )
    {
        if ( loc.script_label == "pball" )
        {
            level.var_b58f39dc2c39694f = loc;
            break;
        }
    }
}

// Namespace arena
// Params 0
// Checksum 0x2749a327, Offset: 0x3d6b
// Size: 0x2c3
function initializematchrules()
{
    game_utility_mp::setcommonrulesfrommatchrulesdata();
    setdynamicdvar( @"hash_fe52b762617b4156", getmatchrulesdata( "arenaData", "prematchLoadoutPreviewSeconds" ) );
    setdynamicdvar( @"scr_arena_arenaloadouts", getmatchrulesdata( "arenaData", "arenaLoadouts" ) );
    setdynamicdvar( @"scr_arena_loadoutchangeround", getmatchrulesdata( "arenaData", "loadoutChangeRound" ) );
    setdynamicdvar( @"scr_arena_switchspawns", getmatchrulesdata( "arenaData", "switchSpawns" ) );
    setdynamicdvar( @"scr_arena_wincondition", getmatchrulesdata( "arenaData", "winCondition" ) );
    setdynamicdvar( @"scr_arena_objmodifier", getmatchrulesdata( "arenaData", "objModifier" ) );
    setdynamicdvar( @"hash_c4dd1397da8407be", getmatchrulesdata( "arenaData", "overtimeFlag" ) );
    setdynamicdvar( @"scr_arena_flagcapturetime", getmatchrulesdata( "arenaData", "flagCaptureTime" ) );
    setdynamicdvar( @"hash_ca4cdfbc3778abed", getmatchrulesdata( "arenaData", "flagHoldTimer" ) );
    setdynamicdvar( @"hash_bc7f17452d7d2bc4", getmatchrulesdata( "arenaData", "flagActivationDelay" ) );
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
    setdynamicdvar( @"hash_ce087f3b0e67c668", getmatchrulesdata( "arenaData", "arenaAttachments" ) );
    setdynamicdvar( @"hash_193cc5a02ee3d815", getmatchrulesdata( "arenaData", "arenaSuper" ) );
    level.var_43115a12911d7740 = getmatchrulesdata( "arenaData", "enableGunfightPerks" );
    level.enable_gunfight_loadouts = getmatchrulesdata( "arenaData", "enableGunfightLoadouts" );
    assert( istrue( level.var_43115a12911d7740 ) == level.enable_gunfight_loadouts, "<dev string:x24>" );
}

// Namespace arena
// Params 0
// Checksum 0x8c39a5cc, Offset: 0x4036
// Size: 0xf96
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
    
    if ( level.gametypebundle.prototype == #"hash_1c3f2a3b8cd77509" )
    {
        if ( function_4042d2fbe6237835( #"hash_1c3f2a3b8cd77509" ) )
        {
            level.gametypebundle.prototype = undefined;
        }
        else
        {
            level.var_e1d4b8532f2bf85c = !isdefined( game[ "roundsPlayed" ] ) || game[ "roundsPlayed" ] == 0;
        }
    }
    
    hud_message::function_e369cd82a03687e0();
    initspawns();
    
    if ( level.snowballfight )
    {
        function_938e44e19a0f97e0();
    }
    
    if ( !level.enable_gunfight_loadouts )
    {
        function_64e30c7714b9a8e9();
        function_d49af0499dd7b945();
        function_63136acc886670a1();
    }
    
    if ( game[ "roundsPlayed" ] == 0 )
    {
        game[ "roundWinStreak" ] = 0;
    }
    
    thread adjustroundendtimer();
    thread waittooverridegraceperiod();
    var_ca13767a2e804e4f = 1;
    
    if ( level.snowballfight )
    {
        if ( !level.alwayssnowfight && game[ "roundsPlayed" ] == 0 && game[ "practiceRound" ] )
        {
            level.extratime = 30;
            game[ "didSnowFight" ] = 1;
            level.arenaloadouts = 3;
            var_ca13767a2e804e4f = 0;
        }
        else if ( level.alwayssnowfight )
        {
            level.arenaloadouts = 3;
            var_ca13767a2e804e4f = 0;
        }
        
        level.snowfx[ "vanish" ] = loadfxasset( "vfx_core_impacts_small_snowhit" );
        level.snowfx[ "screen" ] = loadfxasset( "vfx_iw8_weap_impact_snowball_scrn" );
        snowballfight();
    }
    
    if ( var_ca13767a2e804e4f )
    {
        if ( israndomloadouts() )
        {
            if ( level.enable_gunfight_loadouts )
            {
                cache_gunfight_loadouts();
            }
            
            thread updaterandomloadout();
        }
        else if ( ispickuploadouts() )
        {
            if ( !isdefined( game[ "roundsPlayed" ] ) || game[ "roundsPlayed" ] == 0 )
            {
                level.startweapon.weapon = getrandomweaponforweapontier( level.startweapon.weapon );
                level.arenaweapont1.weapon = getrandomweaponforweapontier( level.arenaweapont1.weapon );
                level.arenaweapont2.weapon = getrandomweaponforweapontier( level.arenaweapont2.weapon );
                level.arenaweapont3.weapon = getrandomweaponforweapontier( level.arenaweapont3.weapon );
                level.arenaweapont4.weapon = getrandomweaponforweapontier( level.arenaweapont4.weapon );
                level.arenaweapont5.weapon = getrandomweaponforweapontier( level.arenaweapont5.weapon );
                level.arenaweapont6.weapon = getrandomweaponforweapontier( level.arenaweapont6.weapon );
                level.arenaweapont7.weapon = getrandomweaponforweapontier( level.arenaweapont7.weapon );
                level.arenaweapont8.weapon = getrandomweaponforweapontier( level.arenaweapont8.weapon );
                level.startweapon.variantid = function_aaf3c5e13b8de8fd( level.startweapon.weapon );
                level.arenaweapont1.variantid = function_aaf3c5e13b8de8fd( level.arenaweapont1.weapon );
                level.arenaweapont2.variantid = function_aaf3c5e13b8de8fd( level.arenaweapont2.weapon );
                level.arenaweapont3.variantid = function_aaf3c5e13b8de8fd( level.arenaweapont3.weapon );
                level.arenaweapont4.variantid = function_aaf3c5e13b8de8fd( level.arenaweapont4.weapon );
                level.arenaweapont5.variantid = function_aaf3c5e13b8de8fd( level.arenaweapont5.weapon );
                level.arenaweapont6.variantid = function_aaf3c5e13b8de8fd( level.arenaweapont6.weapon );
                level.arenaweapont7.variantid = function_aaf3c5e13b8de8fd( level.arenaweapont7.weapon );
                level.arenaweapont8.variantid = function_aaf3c5e13b8de8fd( level.arenaweapont8.weapon );
            }
            else if ( level.loadoutchangeround == 0 || !should_change_loadouts() )
            {
                level.startweapon.weapon = game[ "startWeapon" ][ "weapon" ];
                level.arenaweapont1.weapon = game[ "arenaWeaponT1" ][ "weapon" ];
                level.arenaweapont2.weapon = game[ "arenaWeaponT2" ][ "weapon" ];
                level.arenaweapont3.weapon = game[ "arenaWeaponT3" ][ "weapon" ];
                level.arenaweapont4.weapon = game[ "arenaWeaponT4" ][ "weapon" ];
                level.arenaweapont5.weapon = game[ "arenaWeaponT5" ][ "weapon" ];
                level.arenaweapont6.weapon = game[ "arenaWeaponT6" ][ "weapon" ];
                level.arenaweapont7.weapon = game[ "arenaWeaponT7" ][ "weapon" ];
                level.arenaweapont8.weapon = game[ "arenaWeaponT8" ][ "weapon" ];
                level.startweapon.variantid = game[ "startWeapon" ][ "variantID" ];
                level.arenaweapont1.variantid = game[ "arenaWeaponT1" ][ "variantID" ];
                level.arenaweapont2.variantid = game[ "arenaWeaponT2" ][ "variantID" ];
                level.arenaweapont3.variantid = game[ "arenaWeaponT3" ][ "variantID" ];
                level.arenaweapont4.variantid = game[ "arenaWeaponT4" ][ "variantID" ];
                level.arenaweapont5.variantid = game[ "arenaWeaponT5" ][ "variantID" ];
                level.arenaweapont6.variantid = game[ "arenaWeaponT6" ][ "variantID" ];
                level.arenaweapont7.variantid = game[ "arenaWeaponT7" ][ "variantID" ];
                level.arenaweapont8.variantid = game[ "arenaWeaponT8" ][ "variantID" ];
            }
            else if ( should_change_loadouts() )
            {
                level.startweapon.weapon = getrandomweaponforweapontier( level.startweapon.weapon );
                level.arenaweapont1.weapon = getrandomweaponforweapontier( level.arenaweapont1.weapon );
                level.arenaweapont2.weapon = getrandomweaponforweapontier( level.arenaweapont2.weapon );
                level.arenaweapont3.weapon = getrandomweaponforweapontier( level.arenaweapont3.weapon );
                level.arenaweapont4.weapon = getrandomweaponforweapontier( level.arenaweapont4.weapon );
                level.arenaweapont5.weapon = getrandomweaponforweapontier( level.arenaweapont5.weapon );
                level.arenaweapont6.weapon = getrandomweaponforweapontier( level.arenaweapont6.weapon );
                level.arenaweapont7.weapon = getrandomweaponforweapontier( level.arenaweapont7.weapon );
                level.arenaweapont8.weapon = getrandomweaponforweapontier( level.arenaweapont8.weapon );
                level.startweapon.variantid = function_aaf3c5e13b8de8fd( level.startweapon.weapon );
                level.arenaweapont1.variantid = function_aaf3c5e13b8de8fd( level.arenaweapont1.weapon );
                level.arenaweapont2.variantid = function_aaf3c5e13b8de8fd( level.arenaweapont2.weapon );
                level.arenaweapont3.variantid = function_aaf3c5e13b8de8fd( level.arenaweapont3.weapon );
                level.arenaweapont4.variantid = function_aaf3c5e13b8de8fd( level.arenaweapont4.weapon );
                level.arenaweapont5.variantid = function_aaf3c5e13b8de8fd( level.arenaweapont5.weapon );
                level.arenaweapont6.variantid = function_aaf3c5e13b8de8fd( level.arenaweapont6.weapon );
                level.arenaweapont7.variantid = function_aaf3c5e13b8de8fd( level.arenaweapont7.weapon );
                level.arenaweapont8.variantid = function_aaf3c5e13b8de8fd( level.arenaweapont8.weapon );
            }
            
            game[ "startWeapon" ][ "weapon" ] = level.startweapon.weapon;
            game[ "arenaWeaponT1" ][ "weapon" ] = level.arenaweapont1.weapon;
            game[ "arenaWeaponT2" ][ "weapon" ] = level.arenaweapont2.weapon;
            game[ "arenaWeaponT3" ][ "weapon" ] = level.arenaweapont3.weapon;
            game[ "arenaWeaponT4" ][ "weapon" ] = level.arenaweapont4.weapon;
            game[ "arenaWeaponT5" ][ "weapon" ] = level.arenaweapont5.weapon;
            game[ "arenaWeaponT6" ][ "weapon" ] = level.arenaweapont6.weapon;
            game[ "arenaWeaponT7" ][ "weapon" ] = level.arenaweapont7.weapon;
            game[ "arenaWeaponT8" ][ "weapon" ] = level.arenaweapont8.weapon;
            game[ "startWeapon" ][ "variantID" ] = level.startweapon.variantid;
            game[ "arenaWeaponT1" ][ "variantID" ] = level.arenaweapont1.variantid;
            game[ "arenaWeaponT2" ][ "variantID" ] = level.arenaweapont2.variantid;
            game[ "arenaWeaponT3" ][ "variantID" ] = level.arenaweapont3.variantid;
            game[ "arenaWeaponT4" ][ "variantID" ] = level.arenaweapont4.variantid;
            game[ "arenaWeaponT5" ][ "variantID" ] = level.arenaweapont5.variantid;
            game[ "arenaWeaponT6" ][ "variantID" ] = level.arenaweapont6.variantid;
            game[ "arenaWeaponT7" ][ "variantID" ] = level.arenaweapont7.variantid;
            game[ "arenaWeaponT8" ][ "variantID" ] = level.arenaweapont8.variantid;
            level.lethaldelay = 0;
            defineplayerloadout();
            
            if ( !level.snowballfight )
            {
                initweaponmap();
                thread setupweapons();
            }
        }
        else if ( isgungameloadouts() )
        {
            level.blockweapondrops = 1;
            thread updatearenagungameloadout( 0 );
        }
        else if ( isrvsgungameloadouts() )
        {
            level.blockweapondrops = 1;
            thread updatearenagungameloadout( 1 );
        }
    }
    
    if ( !isnormalloadouts() )
    {
        buildloadoutsforweaponstreaming();
    }
    
    setupwaypointicons();
    seticonnames();
    
    if ( isdefined( level.gametypebundle.var_ae100eea97c7fcc7[ #"hash_14bb716c4b77c45a" ] ) )
    {
        if ( istrue( level.game_objects.var_5f329cd264226f08 ) )
        {
            utility::flag_wait( "cs_gameobjects_constructed" );
        }
        else
        {
            utility::flag_wait( "gameobject_system_post_init" );
            function_950268979eebe9ef();
            waitframe();
        }
    }
    else
    {
        switch ( level.objmodifier )
        {
            case 1:
                level setupendzones();
                break;
            case 2:
                level function_67e32f0a4915fe73();
                break;
            default:
                break;
        }
        
        if ( level.overtimeflag > 0 && !function_46ca224400b02341() )
        {
            level thread spawngameendflagzone();
        }
    }
    
    updatetournamentroundtime( gamelogic_mp::gettimeremaining(), 0 );
    
    if ( !flags::gameflag( "prematch_done" ) )
    {
        level thread outlineenemyplayers();
        level thread removeenemyoutlines();
    }
}

// Namespace arena
// Params 0
// Checksum 0x3d918169, Offset: 0x4fd4
// Size: 0x24
function waittooverridegraceperiod()
{
    flags::gameflagwait( "prematch_done" );
    level.overrideingraceperiod = 1;
    level.ingraceperiod = 5;
}

// Namespace arena
// Params 0
// Checksum 0x14a4b15d, Offset: 0x5000
// Size: 0x6f
function function_6a54a1b3d25c4413()
{
    var_cd24a0144448ee0c = 0;
    
    if ( game[ "roundsPlayed" ] == 0 )
    {
        var_cd24a0144448ee0c = 0;
    }
    else if ( !game_utility_mp::iswinbytworulegametype() && ( game[ "finalRound" ] == 1 || game[ "matchPoint" ] == 1 ) )
    {
        var_cd24a0144448ee0c = 1;
    }
    else if ( isdefined( game[ "roundsPlayed" ] ) && game[ "roundsPlayed" ] % 2 == 0 )
    {
        var_cd24a0144448ee0c = 1;
    }
    
    return var_cd24a0144448ee0c;
}

// Namespace arena
// Params 0
// Checksum 0xf9ab104, Offset: 0x5078
// Size: 0x1af
function function_bfd7c2041520319b()
{
    var_4f5682e5ceeda333 = 0;
    dialogref = undefined;
    
    if ( game[ "roundsPlayed" ] == 0 )
    {
        var_4f5682e5ceeda333 = 0;
    }
    else if ( !game_utility_mp::iswinbytworulegametype() && game[ "finalRound" ] == 1 )
    {
        var_4f5682e5ceeda333 = 1;
    }
    else if ( !game_utility_mp::iswinbytworulegametype() && game[ "matchPoint" ] == 1 )
    {
        foreach ( entry in level.teamnamelist )
        {
            roundswon = game_utility_mp::getroundswon( entry );
            
            if ( roundswon == level.winlimit - 1 )
            {
                matchpointteam = entry;
                break;
            }
        }
        
        if ( self.team === matchpointteam )
        {
            dialogref = #"boost_winning_matchpoint";
        }
        else
        {
            dialogref = #"boost_losing_matchpoint";
        }
        
        var_4f5682e5ceeda333 = 1;
    }
    else if ( isdefined( game[ "roundsPlayed" ] ) && game[ "roundsPlayed" ] % 6 == 0 )
    {
        dialogref = #"boost_genericround";
        var_cd24a0144448ee0c = 1;
    }
    else if ( isdefined( game[ "roundsPlayed" ] ) && game[ "roundsPlayed" ] % 2 == 0 )
    {
        var_cd24a0144448ee0c = 1;
    }
    
    if ( dialog_utility::dialogueexists( dialogref, self.team ) )
    {
        dialog::leaderdialogonplayer( dialogref, "introboost" );
        var_cd24a0144448ee0c = 1;
    }
    
    return var_4f5682e5ceeda333;
}

// Namespace arena
// Params 0
// Checksum 0x1c9de8ae, Offset: 0x5230
// Size: 0x34
function adjustroundendtimer()
{
    if ( level.gametypebundle.prototype == #"hash_1c3f2a3b8cd77509" )
    {
        return;
    }
    
    wait 1;
    level.roundenddelay = 4;
}

// Namespace arena
// Params 0
// Checksum 0x9378832, Offset: 0x526c
// Size: 0x435
function updategametypedvars()
{
    common::updatecommongametypedvars();
    
    if ( obj_dogtag::dogtagsenabled() )
    {
        level.dogtagallyonusecb = &dogtagallyonusecb;
        level.dogtagenemyonusecb = &dogtagenemyonusecb;
    }
    
    level.arenaloadouts = dvars::dvarintvalue( "arenaLoadouts", 1, 1, 17 );
    level.loadoutchangeround = dvars::dvarintvalue( "loadoutChangeRound", 3, 0, 5 );
    level.switchspawns = dvars::dvarintvalue( "switchSpawns", 1, 0, 1 );
    level.wincondition = dvars::dvarintvalue( "winCondition", 1, 0, 2 );
    level.var_9eccdafcc2cf5d18 = dvars::dvarintvalue( "winStreakCamos", 0, 0, 1 );
    setomnvar( "ui_arena_loadout_type", level.arenaloadouts );
    setomnvar( "ui_wincondition", level.wincondition );
    level.objmodifier = dvars::dvarintvalue( "objModifier", 0, 0, 4 );
    
    if ( !function_46ca224400b02341() )
    {
        setomnvar( "ui_single_flag_loc", -3 );
    }
    
    level.overtimeflag = dvars::dvarfloatvalue( "overtimeFlag", 10, 0, 30 );
    
    if ( level.overtimeflag > 0 )
    {
        level.ontimelimitgraceperiod = level.overtimeflag;
        level.currenttimelimitdelay = 0;
        level.canprocessot = 1;
        level.var_cfa9868bde941db1 = int( ( level.ontimelimitgraceperiod - level.currenttimelimitdelay ) * 1000 );
    }
    
    level.flagcapturetime = dvars::dvarfloatvalue( "flagCaptureTime", 3, 0, 30 );
    level.flagholdtimer = dvars::dvarfloatvalue( "flagHoldTimer", 5, 0, 30 );
    level.flagactivationdelay = dvars::dvarfloatvalue( "flagActivationDelay", 15, 0, 30 );
    level.tacticaltimemod = dvars::dvarfloatvalue( "tacticalTimeMod", 2.5, 0.5, 5 );
    level.startweapon = spawnstruct();
    level.arenaweapont1 = spawnstruct();
    level.arenaweapont2 = spawnstruct();
    level.arenaweapont3 = spawnstruct();
    level.arenaweapont4 = spawnstruct();
    level.arenaweapont5 = spawnstruct();
    level.arenaweapont6 = spawnstruct();
    level.arenaweapont7 = spawnstruct();
    level.arenaweapont8 = spawnstruct();
    level.startweapon.weapon = getdvar( @"scr_arena_startweapon", "none" );
    level.arenaweapont1.weapon = getdvar( @"scr_arena_weapontier1", "iw9_pi_golf17" );
    level.arenaweapont2.weapon = getdvar( @"scr_arena_weapontier2", "iw9_sh_mike1014" );
    level.arenaweapont3.weapon = getdvar( @"scr_arena_weapontier3", "iw9_sm_mpapa5" );
    level.arenaweapont4.weapon = getdvar( @"scr_arena_weapontier4", "iw9_ar_mike4" );
    level.arenaweapont5.weapon = getdvar( @"scr_arena_weapontier5", "iw9_sn_alpha50" );
    level.arenaweapont6.weapon = getdvar( @"scr_arena_weapontier6", "equip_frag" );
    level.arenaweapont7.weapon = getdvar( @"scr_arena_weapontier7", "equip_concussion" );
    level.arenaweapont8.weapon = getdvar( @"scr_arena_weapontier8", "equip_adrenaline" );
    level.arenapickupattachments = getdvarint( @"hash_ce087f3b0e67c668", 0 );
    
    if ( level.arenaloadouts == 1 )
    {
        level.allowperks = 1;
    }
    
    level.arenasuper = getdvar( @"hash_193cc5a02ee3d815", "none" );
    
    if ( level.arenasuper == "none" )
    {
        setomnvar( "ui_disable_fieldupgrades", 1 );
    }
    
    level.var_7bba467bb097f040 = getdvarint( @"hash_3f64b5787462cd52", 1 );
    function_b907c5102bc35b1e( 0 );
}

// Namespace arena
// Params 0
// Checksum 0xa77900bd, Offset: 0x56a9
// Size: 0x922
function initspawns()
{
    spawnlogic::function_6dbabb72223a4bca();
    spawnkey = spawnlogic::function_d5c160a4110b573e();
    level.var_f1086140706e9fff = spawnlogic::function_5cf82e30c52a895d( spawnkey );
    
    if ( level.var_f1086140706e9fff )
    {
        valuekeys = [ "one", "two", "three", "four", "five", "six", "seven", "eight", "nine", "ten" ];
        var_540375a0f1234755 = [ #"one_attacker", #"two_attacker", #"three_attacker", #"four_attacker", #"five_attacker", #"six_attacker", #"seven_attacker", #"eight_attacker", #"nine_attacker", #"ten_attacker" ];
        var_72ec1c4fb7641fd9 = [ #"one_defender", #"two_defender", #"three_defender", #"four_defender", #"five_defender", #"six_defender", #"seven_defender", #"eight_defender", #"nine_defender", #"ten_defender" ];
        
        if ( level.multimatch ?? gameinstance::is_enabled() )
        {
            valuekeys = [ "one", "two", "three" ];
            var_540375a0f1234755 = [ #"one_attacker", #"two_attacker", #"three_attacker" ];
            var_72ec1c4fb7641fd9 = [ #"one_defender", #"two_defender", #"three_defender" ];
            
            foreach ( team in gameinstance::function_e934bda31466d491() )
            {
                instanceid = gameinstance::get_instance_id( team );
                var_4125b1e306ae4f9d = [];
                
                foreach ( key in var_540375a0f1234755 )
                {
                    var_4125b1e306ae4f9d[ var_4125b1e306ae4f9d.size ] = hashcat( key, instanceid );
                }
                
                spawnlogic::function_1a2e309f5ceed01c( #"start", hashcat( #"primary_attackers", instanceid ), var_4125b1e306ae4f9d, spawnkey, spawnlogic::function_61ba521db28762a7(), valuekeys, team, 1, instanceid );
            }
            
            foreach ( team in gameinstance::function_46849ab004145bad() )
            {
                instanceid = gameinstance::get_instance_id( team );
                var_4125b1e306ae4f9d = [];
                
                foreach ( key in var_72ec1c4fb7641fd9 )
                {
                    var_4125b1e306ae4f9d[ var_4125b1e306ae4f9d.size ] = hashcat( key, instanceid );
                }
                
                spawnlogic::function_1a2e309f5ceed01c( #"start", hashcat( #"primary_defenders", instanceid ), var_4125b1e306ae4f9d, spawnkey, spawnlogic::function_3a5e3efa19e5df47(), valuekeys, team, 1, instanceid );
            }
            
            foreach ( instance in gameinstance::function_1d3a8144ddb36029() )
            {
                if ( isdefined( instance.attackers ) )
                {
                    spawnlogic::function_2e4fbfaa2e5bf603( #"start_one", hashcat( #"one_attacker", instance.id ) );
                    spawnlogic::function_2e4fbfaa2e5bf603( #"start_two", hashcat( #"two_attacker", instance.id ) );
                    spawnlogic::function_2e4fbfaa2e5bf603( #"start_three", hashcat( #"three_attacker", instance.id ) );
                }
                
                if ( isdefined( instance.defenders ) )
                {
                    spawnlogic::function_2e4fbfaa2e5bf603( #"start_one", hashcat( #"one_defender", instance.id ) );
                    spawnlogic::function_2e4fbfaa2e5bf603( #"start_two", hashcat( #"two_defender", instance.id ) );
                    spawnlogic::function_2e4fbfaa2e5bf603( #"start_three", hashcat( #"three_defender", instance.id ) );
                }
            }
        }
        else
        {
            spawnlogic::function_1a2e309f5ceed01c( #"start", #"primary_attackers", var_540375a0f1234755, spawnkey, spawnlogic::function_61ba521db28762a7(), valuekeys, game[ "attackers" ], 1 );
            spawnlogic::function_1a2e309f5ceed01c( #"start", #"primary_defenders", var_72ec1c4fb7641fd9, spawnkey, spawnlogic::function_3a5e3efa19e5df47(), valuekeys, game[ "defenders" ], 1 );
            spawnlogic::function_2e4fbfaa2e5bf603( #"start_one", #"one_attacker" );
            spawnlogic::function_2e4fbfaa2e5bf603( #"start_one", #"one_defender" );
            spawnlogic::function_2e4fbfaa2e5bf603( #"start_two", #"two_attacker" );
            spawnlogic::function_2e4fbfaa2e5bf603( #"start_two", #"two_defender" );
            spawnlogic::function_2e4fbfaa2e5bf603( #"start_three", #"three_attacker" );
            spawnlogic::function_2e4fbfaa2e5bf603( #"start_three", #"three_defender" );
            spawnlogic::function_2e4fbfaa2e5bf603( #"start_four", #"four_attacker" );
            spawnlogic::function_2e4fbfaa2e5bf603( #"start_four", #"four_defender" );
            spawnlogic::function_2e4fbfaa2e5bf603( #"start_five", #"five_attacker" );
            spawnlogic::function_2e4fbfaa2e5bf603( #"start_five", #"five_defender" );
            spawnlogic::function_2e4fbfaa2e5bf603( #"start_six", #"six_attacker" );
            spawnlogic::function_2e4fbfaa2e5bf603( #"start_six", #"six_defender" );
            spawnlogic::function_2e4fbfaa2e5bf603( #"start_seven", #"seven_attacker" );
            spawnlogic::function_2e4fbfaa2e5bf603( #"start_seven", #"seven_defender" );
            spawnlogic::function_2e4fbfaa2e5bf603( #"start_eight", #"eight_attacker" );
            spawnlogic::function_2e4fbfaa2e5bf603( #"start_eight", #"eight_defender" );
            spawnlogic::function_2e4fbfaa2e5bf603( #"start_nine", #"nine_attacker" );
            spawnlogic::function_2e4fbfaa2e5bf603( #"start_nine", #"nine_defender" );
            spawnlogic::function_2e4fbfaa2e5bf603( #"start_ten", #"ten_attacker" );
            spawnlogic::function_2e4fbfaa2e5bf603( #"start_ten", #"ten_defender" );
        }
    }
    else
    {
        var_f98cbc84b814b759 = spawnlogic::getspawnpointarray( "mp_arena_spawn_allies_start" );
        var_e52ab5709cd555a4 = spawnlogic::getspawnpointarray( "mp_arena_spawn_axis_start" );
        
        if ( var_f98cbc84b814b759.size > 0 || var_e52ab5709cd555a4.size > 0 )
        {
            spawnlogic::function_9bd2654564d3372d( #"start", #"start_attackers", "mp_arena_spawn_allies_start", game[ "attackers" ], 1 );
            spawnlogic::function_9bd2654564d3372d( #"start", #"start_defenders", "mp_arena_spawn_axis_start", game[ "defenders" ], 1 );
        }
        else
        {
            spawnlogic::function_9bd2654564d3372d( #"start", #"start_attackers", "mp_sd_spawn_attacker", game[ "attackers" ], 1 );
            spawnlogic::function_9bd2654564d3372d( #"start", #"start_defenders", "mp_sd_spawn_defender", game[ "defenders" ], 1 );
        }
    }
    
    spawnlogic::finalizemap();
}

// Namespace arena
// Params 1
// Checksum 0x5611bcc9, Offset: 0x5fd3
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
                assert( s.script_noteworthy != "<dev string:x84>", "<dev string:x86>" );
            }
            
            if ( !found_2 )
            {
                found_2 = s.script_noteworthy == "2";
            }
            else
            {
                assert( s.script_noteworthy != "<dev string:xc4>", "<dev string:xc6>" );
            }
            
            if ( !found_3 )
            {
                found_3 = s.script_noteworthy == "3";
                level.hasthreespawns = 1;
            }
            else
            {
                assert( s.script_noteworthy != "<dev string:x104>", "<dev string:x106>" );
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

// Namespace arena
// Params 0
// Checksum 0x4ccf4065, Offset: 0x61bd
// Size: 0x45
function getspawnpoint()
{
    spawnlogic::setactivespawnlogic( #"start" );
    spawnsetgroup = function_fcc67953cfed2de();
    return spawnlogic::getspawnpoint( self, self.pers[ "team" ], spawnsetgroup, #"start" );
}

// Namespace arena
// Params 1
// Checksum 0xad0151cf, Offset: 0x620b
// Size: 0x135
function function_1ff893c18f0db36b( player )
{
    if ( !isdefined( level.playerspawnindex ) )
    {
        level.playerspawnindex = [];
    }
    
    if ( !isdefined( level.playerspawnindex[ player.team ] ) )
    {
        level.playerspawnindex[ player.team ] = [];
    }
    
    if ( isdefined( player.pers[ "arena_spawn_index" ] ) && !isdefined( level.playerspawnindex[ player.team ][ player.pers[ "arena_spawn_index" ] ] ) )
    {
        level.playerspawnindex[ player.team ][ player.pers[ "arena_spawn_index" ] ] = player;
        return player.pers[ "arena_spawn_index" ];
    }
    
    for ( index = 0; true ; index++ )
    {
        if ( !isdefined( level.playerspawnindex[ player.team ][ index ] ) )
        {
            break;
        }
    }
    
    level.playerspawnindex[ player.team ][ index ] = player;
    player.pers[ "arena_spawn_index" ] = index;
}

// Namespace arena
// Params 0
// Checksum 0xd0ad2d29, Offset: 0x6348
// Size: 0x173
function function_fcc67953cfed2de()
{
    var_699bb4a5a20088ee = #"start";
    
    if ( !level.var_f1086140706e9fff )
    {
        return var_699bb4a5a20088ee;
    }
    
    spawnkeys = [ #"start_one", #"start_two", #"start_three", #"start_four", #"start_five", #"start_six", #"start_seven", #"start_eight", #"start_nine", #"start_ten" ];
    function_1ff893c18f0db36b( self );
    teamsize = teams::getteamcount( self.pers[ "team" ] );
    
    if ( game[ "arenaTeamSize" ] < teamsize )
    {
        game[ "arenaTeamSize" ] = teamsize;
    }
    
    size_mod = minint( game[ "arenaTeamSize" ], spawnkeys.size );
    index = self.pers[ "arena_spawn_index" ] % size_mod;
    
    if ( level.switchspawns && level.roundswitch > 0 )
    {
        index = ( self.pers[ "arena_spawn_index" ] + int( floor( game[ "roundsPlayed" ] / level.roundswitch ) ) ) % size_mod;
    }
    
    return spawnkeys[ index ];
}

// Namespace arena
// Params 2
// Checksum 0x48d6318f, Offset: 0x64c4
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

// Namespace arena
// Params 2
// Checksum 0x147e007a, Offset: 0x65df
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
    
    assert( var_1b638c7202eecb86 == 1, "<dev string:x144>" );
}

// Namespace arena
// Params 2
// Checksum 0x148ee4b0, Offset: 0x66c2
// Size: 0xa5
function function_afc3a8bf32418bdc( spawnpoints, spawnnoteworthy )
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
            return spawnpoint;
        }
    }
}

// Namespace arena
// Params 1
// Checksum 0x539fa163, Offset: 0x676f
// Size: 0x134
function function_7946398a26be01a0( spawnpoints )
{
    color = ( 0, 0, 0 );
    
    foreach ( s in spawnpoints )
    {
        if ( isdefined( s.script_noteworthy ) )
        {
            if ( s.script_noteworthy == "1" )
            {
                color = ( 1, 0, 0 );
            }
            else if ( s.script_noteworthy == "2" )
            {
                color = ( 0, 1, 0 );
            }
            else if ( s.script_noteworthy == "3" )
            {
                color = ( 0, 0, 1 );
            }
            else
            {
                color = ( 1, 1, 1 );
            }
            
            thread debug_utility::drawsphere( s.origin, 32, 20, color );
        }
    }
}

// Namespace arena
// Params 1
// Checksum 0x944eb417, Offset: 0x68ab
// Size: 0x167
function onplayerconnect( player )
{
    if ( level.allowkillstreaks )
    {
        level.allowkillstreaks = 0;
    }
    
    player.arenadamage = 0;
    player stats::setextrascore0( player.pers[ "captures" ] ?? 0, "captures" );
    player stats::setextrascore1( player.pers[ "damage" ] ?? 0, "damage" );
    player stats::setextrascore2( player.pers[ "objTime" ] ?? 0, "objTime" );
    
    if ( !isnormalloadouts() )
    {
        level.denyclasschoice = 1;
        player class::function_e84a99f0f4904c66();
        
        if ( israndomloadouts() )
        {
            player.pers[ "gamemodeLoadout" ] = game[ "arenaRandomLoadout" ][ game[ "arenaRandomLoadoutIndex" ] ];
        }
        else if ( ispickuploadouts() )
        {
            player.pers[ "gamemodeLoadout" ] = level.var_c72b61d4740c82eb;
        }
        else if ( isgungameloadouts() || isrvsgungameloadouts() )
        {
            player.pers[ "gamemodeLoadout" ] = game[ "arenaRandomLoadout" ][ getgungameloadoutindex( player ) ];
            
            if ( game[ "roundsPlayed" ] == 0 )
            {
                player setenemyloadoutomnvars();
            }
        }
    }
    
    if ( !isnormalloadouts() )
    {
        player common::updatehighpriorityweapons();
    }
}

// Namespace arena
// Params 1
// Checksum 0x5cc4a3ac, Offset: 0x6a1a
// Size: 0x63
function onspawnplayer( spawndata )
{
    thread onspawnfinished();
    level notify( #"spawned_player" );
    thread updatematchstatushintonspawn();
    
    if ( level.alwayssnowfight )
    {
        perk::giveperk( "specialty_fastoffhand" );
        perk::giveperk( "specialty_pitcher" );
    }
    
    squads::updatesquadomnvars( self.team, self.sessionsquadid );
}

// Namespace arena
// Params 0
// Checksum 0x968cc327, Offset: 0x6a85
// Size: 0x170
function onspawnfinished()
{
    self endon( #"death_or_disconnect" );
    
    if ( game[ "practiceRound" ] || level.alwayssnowfight )
    {
        thread snowballmeleewatcher();
    }
    
    thread damagewatcher();
    
    if ( !isnormalloadouts() )
    {
        runarenaloadoutrulesonplayer( self );
    }
    
    if ( level.arenaknivesout )
    {
        perk::giveperk( "specialty_quickswap" );
        perk::giveperk( "specialty_fastoffhand" );
    }
    
    if ( level.var_43115a12911d7740 )
    {
        perk::giveperk( "specialty_gunfight_perks" );
        
        if ( !self.var_fc168ade79795bd3 )
        {
            callback::add( #"equipment_ammo_set", &function_523209503e5f2b1f );
            self.var_fc168ade79795bd3 = 1;
        }
    }
    
    wait 0.1;
    self.hasarenaspawned = 1;
    wait 0.15;
    thread function_f9184d0f6553de10( self );
    
    if ( !flags::gameflag( "prematch_done" ) && game[ "roundsPlayed" ] == 0 )
    {
        var_5f65d2cd09e84b2f = level.overtimeflag > 0;
        var_83d525f2782f3d16 = level.matchcountdowntime > 5;
        var_671ebe5ded6b1412 = !level.var_f1f1f28ea8c0f26b;
        
        if ( var_5f65d2cd09e84b2f && var_83d525f2782f3d16 && var_671ebe5ded6b1412 )
        {
            if ( !self issplitscreenplayer() || self issplitscreenplayerprimary() )
            {
                dialog::leaderdialogonplayer( "obj_indepth", "introboost" );
            }
        }
        
        level utility::waittill_any( "prematch_done", "removeArenaOutlines" );
    }
}

// Namespace arena
// Params 1, eflags: 0x4
// Checksum 0x6164a138, Offset: 0x6bfd
// Size: 0xe7
function private function_f9184d0f6553de10( player )
{
    assert( isdefined( player ) );
    level endon( #"game_ended" );
    player endon( #"death_or_disconnect" );
    
    if ( level.gametypebundle.prototype != #"hash_1c3f2a3b8cd77509" )
    {
        if ( !flags::gameflag( "prematch_done" ) && game[ "roundsPlayed" ] == 0 )
        {
            level utility::waittill_any( "prematch_done", "removeArenaOutlines" );
        }
    }
    else
    {
        flags::function_2f3408423ccc9b2e( "prematch_started" );
        waitframe();
        
        if ( isdefined( level.matchcountdowntime ) )
        {
            var_9e7444a19f86fbb0 = getdvarint( @"hash_fe52b762617b4156", 3 );
            wait_time = 1 + level.matchcountdowntime - var_9e7444a19f86fbb0;
            
            if ( wait_time > 0 )
            {
                wait wait_time;
            }
        }
    }
    
    player setclientomnvar( "ui_player_notify_loadout", 1 );
}

// Namespace arena
// Params 15
// Checksum 0x6acc6bf4, Offset: 0x6cec
// Size: 0x16c
function onplayerdamaged( einflictor, eattacker, victim, idamage, idflags, smeansofdeath, objweapon, var_ca02bfdd611a56f4, vpoint, vdir, shitloc, psoffsettime, modelindex, partname, lightarmordamage )
{
    if ( eattacker != victim && eattacker.team != victim.team && isplayer( eattacker ) )
    {
        if ( level.snowballfight && ( objweapon.basename == "snowball_mp" || objweapon.basename == "pball_mp" ) )
        {
            playfxontagforclients( level.snowfx[ "screen" ], victim, "tag_eye", victim );
        }
        
        if ( idamage >= var_ca02bfdd611a56f4 )
        {
            idamage = var_ca02bfdd611a56f4;
        }
        
        eattacker.arenadamage += idamage;
        eattacker persistence::statsetchild( "round", "damage", eattacker.pers[ "damage" ] );
        eattacker stats::setextrascore1( eattacker.pers[ "damage" ] );
    }
}

// Namespace arena
// Params 0
// Checksum 0xcd6bd7ef, Offset: 0x6e60
// Size: 0x13a
function damagewatcher()
{
    self notify( #"hash_dfd3548992b59d9e" );
    self endon( #"hash_dfd3548992b59d9e" );
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    
    while ( true )
    {
        playerhealth::function_284cd76924b8c5ae( self );
        
        if ( self.iscapturing )
        {
            objflag = undefined;
            
            if ( function_155840b442af403f() )
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

// Namespace arena
// Params 6
// Checksum 0x15abafb3, Offset: 0x6fa2
// Size: 0xaa
function onnormaldeath( victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon )
{
    attacker stats::setextrascore3( attacker.pers[ "longestStreak" ], "longeststreak" );
    common::oncommonnormaldeath( victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon );
    
    if ( !isnormalloadouts() )
    {
        if ( isbot( victim ) )
        {
            victim.classcallback = "gamemode";
        }
    }
    
    if ( game_utility_mp::getgamestate( attacker ) == "postgame" )
    {
        attacker.finalkill = 1;
    }
}

// Namespace arena
// Params 1
// Checksum 0x748e1a60, Offset: 0x7054
// Size: 0x1b6
function onplayerkilled( deathdata )
{
    attacker = deathdata.attacker;
    objweapon = deathdata.objweapon;
    squads::updatesquadomnvars( self.team, self.sessionsquadid );
    
    if ( !isnormalloadouts() )
    {
        if ( isbot( self ) )
        {
            self.classcallback = "gamemode";
        }
    }
    
    if ( attacker && ( objweapon.basename == "snowball_mp" || objweapon.basename == "pball_mp" ) )
    {
        attacker thread points::function_aa3f27bc29d005fc( #"snowball_kill" );
    }
    
    attacker thread checkallowspectating();
    
    if ( attacker === deathdata.victim || !attacker.team )
    {
        return;
    }
    
    if ( !isdefined( level.var_609f1ff9bcce608 ) )
    {
        level.var_609f1ff9bcce608 = [];
    }
    
    if ( !isdefined( level.var_609f1ff9bcce608[ attacker.team ] ) )
    {
        level.var_609f1ff9bcce608[ attacker.team ] = 0;
    }
    
    level.var_609f1ff9bcce608[ attacker.team ]++;
    
    if ( !level.var_d1c15ddca9a7d432[ attacker.team ] )
    {
        level.var_d1c15ddca9a7d432[ attacker.team ] = attacker;
        level.var_cf5f3af980e4414[ attacker.team ] = 1;
        return;
    }
    
    if ( level.var_d1c15ddca9a7d432[ attacker.team ] != attacker )
    {
        level.var_cf5f3af980e4414[ attacker.team ] = 0;
    }
}

// Namespace arena
// Params 1
// Checksum 0xab7f7035, Offset: 0x7212
// Size: 0x1f8
function onroundended( data )
{
    winningteam = data.winner;
    
    if ( team_utility::isgameplayteam( winningteam ) && level.gametypebundle.var_30e9ab369c7f0667 && level.var_1167332792c1a743 )
    {
        var_fbe028ff7b394a11 = level.gametypebundle.var_30e9ab369c7f0667 * 1000;
        rounddurationms = gettime() - level.var_1167332792c1a743;
        teamkills = level.var_609f1ff9bcce608[ winningteam ];
        var_4c93334cb2d61018 = level.var_3b46ffe37c501c23[ team_utility::getotherteam( winningteam ) ];
        var_3dcdfb5c5bdf0db2 = teamkills == var_4c93334cb2d61018 && var_4c93334cb2d61018 == 2 && rounddurationms <= var_fbe028ff7b394a11;
        
        if ( var_3dcdfb5c5bdf0db2 )
        {
            playersonteam = teams::getteamdata( data.winner, "players" );
            
            if ( isdefined( playersonteam ) )
            {
                foreach ( player in playersonteam )
                {
                    player thread points::doscoreevent( #"gunfight_quick_rnd" );
                }
            }
        }
    }
    
    var_3164a797f488b393 = level.var_d1c15ddca9a7d432[ winningteam ];
    var_b68340956639a591 = teamkills == var_4c93334cb2d61018 && var_4c93334cb2d61018 == 2 && var_3164a797f488b393 && level.var_cf5f3af980e4414[ winningteam ];
    
    if ( var_b68340956639a591 )
    {
        var_3164a797f488b393 thread points::doscoreevent( #"gunfight_double" );
    }
    
    level.var_609f1ff9bcce608 = undefined;
    level.var_d1c15ddca9a7d432 = undefined;
    level.var_cf5f3af980e4414 = undefined;
}

// Namespace arena
// Params 0
// Checksum 0xf61254d9, Offset: 0x7412
// Size: 0xa7
function checkallowspectating()
{
    waitframe();
    update = 0;
    
    if ( level.multimatch ?? gameinstance::is_enabled() )
    {
        update = 0;
    }
    else
    {
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
    }
    
    if ( update )
    {
        spectating::updatespectatesettings();
    }
}

// Namespace arena
// Params 1
// Checksum 0x5f1b0b92, Offset: 0x74c1
// Size: 0x120
function ontimelimit( instance )
{
    if ( level.gameended )
    {
        return;
    }
    
    updatetournamentroundtime( gamelogic_mp::gettimeremaining(), 3 );
    
    if ( function_46ca224400b02341() )
    {
        carrier = gameobjects_shared::carryobject_get_carrier( level.var_9eb82d89b62a76fa );
        carryteam = carrier.team ?? "neutral";
        
        if ( carryteam != "neutral" && carryteam != "none" )
        {
            level thread gamelogic_mp::endgame( carryteam, game[ "end_reason" ][ "ko_flag_win" ], game[ "end_reason" ][ "ko_flag_loss" ] );
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
        
        return;
    }
    
    if ( level.wincondition == 1 )
    {
        checkliveswinner( instance );
        return;
    }
    
    if ( level.wincondition == 2 )
    {
        checkhealthwinner( instance );
        return;
    }
    
    checkhealthwinner( instance );
}

// Namespace arena
// Params 0
// Checksum 0xbf4daece, Offset: 0x75e9
// Size: 0x93
function ontimelimitot()
{
    if ( function_46ca224400b02341() )
    {
        carrier = gameobjects_shared::carryobject_get_carrier( level.var_9eb82d89b62a76fa );
        carryteam = carrier.team ?? "neutral";
        
        if ( carryteam != "neutral" && carryteam != "none" )
        {
            level thread gamelogic_mp::endgame( carryteam, game[ "end_reason" ][ "ko_flag_win" ], game[ "end_reason" ][ "ko_flag_loss" ] );
        }
    }
    
    updatetournamentroundtime( gamelogic_mp::gettimeremaining(), 1 );
    level thread startotmechanics();
}

// Namespace arena
// Params 1
// Checksum 0x87c9a4e1, Offset: 0x7684
// Size: 0x14c
function checkliveswinner( instance )
{
    team = "allies";
    otherteam = "axis";
    
    if ( level.multimatch ?? gameinstance::is_enabled() )
    {
        teams = gameinstance::get_instance_teams( instance.id );
        team = teams[ 0 ];
        otherteam = teams[ 1 ];
    }
    
    if ( teams::getteamdata( team, "aliveCount" ) > teams::getteamdata( otherteam, "aliveCount" ) )
    {
        game[ "dialog" ][ "round_success" ] = "gamestate_win_health";
        game[ "dialog" ][ "round_failure" ] = "gamestate_lost_health";
        thread arena_endgame( team, game[ "end_reason" ][ "arena_time_lives_win" ], game[ "end_reason" ][ "arena_time_lives_loss" ], undefined, undefined, instance );
        return;
    }
    
    if ( teams::getteamdata( otherteam, "aliveCount" ) > teams::getteamdata( team, "aliveCount" ) )
    {
        game[ "dialog" ][ "round_success" ] = "gamestate_win_health";
        game[ "dialog" ][ "round_failure" ] = "gamestate_lost_health";
        thread arena_endgame( otherteam, game[ "end_reason" ][ "arena_time_lives_win" ], game[ "end_reason" ][ "arena_time_lives_loss" ], undefined, undefined, instance );
        return;
    }
    
    checkhealthwinner( instance );
}

// Namespace arena
// Params 1
// Checksum 0x76de35a1, Offset: 0x77d8
// Size: 0x37d
function checkhealthwinner( instance )
{
    team = "allies";
    otherteam = "axis";
    
    if ( level.multimatch ?? gameinstance::is_enabled() )
    {
        teams = gameinstance::get_instance_teams( instance.id );
        team = teams[ 0 ];
        otherteam = teams[ 1 ];
    }
    
    teamhealth = teams::function_ca2fe741546df07d( team );
    var_c7bd7b241815c997 = isdefined( otherteam ) ? teams::function_ca2fe741546df07d( otherteam ) : 0;
    
    if ( teamhealth < var_c7bd7b241815c997 )
    {
        game[ "dialog" ][ "round_success" ] = "gamestate_win_health";
        game[ "dialog" ][ "round_failure" ] = "gamestate_lost_health";
        thread arena_endgame( otherteam, game[ "end_reason" ][ "arena_time_health_win" ], game[ "end_reason" ][ "arena_time_health_loss" ], undefined, undefined, instance );
        return;
    }
    
    if ( var_c7bd7b241815c997 < teamhealth )
    {
        game[ "dialog" ][ "round_success" ] = "gamestate_win_health";
        game[ "dialog" ][ "round_failure" ] = "gamestate_lost_health";
        thread arena_endgame( team, game[ "end_reason" ][ "arena_time_health_win" ], game[ "end_reason" ][ "arena_time_health_loss" ], undefined, undefined, instance );
        return;
    }
    
    if ( level.multimatch ?? gameinstance::is_enabled() )
    {
        game[ "roundsTied" ][ team ]++;
        
        if ( isdefined( otherteam ) )
        {
            game[ "roundsTied" ][ otherteam ]++;
        }
        
        thread arena_endgame( "tie", game[ "end_reason" ][ "time_limit_reached" ], undefined, undefined, undefined, instance );
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
                
                if ( !isdefined( game[ "roundsTied" ][ team ] ) )
                {
                    game[ "roundsTied" ][ team ] = 1;
                }
                else
                {
                    game[ "roundsTied" ][ team ]++;
                }
                
                if ( !isdefined( game[ "roundsTied" ][ otherteam ] ) )
                {
                    game[ "roundsTied" ][ otherteam ] = 1;
                }
                else
                {
                    game[ "roundsTied" ][ otherteam ]++;
                }
                
                if ( game[ "roundsTied" ][ team ] >= 2 || game[ "roundsTied" ][ otherteam ] >= 2 )
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
            if ( !isdefined( game[ "roundsTied" ][ team ] ) )
            {
                game[ "roundsTied" ][ team ] = 1;
            }
            else
            {
                game[ "roundsTied" ][ team ]++;
            }
            
            if ( !isdefined( game[ "roundsTied" ][ otherteam ] ) )
            {
                game[ "roundsTied" ][ otherteam ] = 1;
            }
            else
            {
                game[ "roundsTied" ][ otherteam ]++;
            }
            
            game[ "canScoreOnTie" ] = game[ "roundsTied" ][ team ] >= 2 || game[ "roundsTied" ][ otherteam ] >= 2;
            
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

// Namespace arena
// Params 2
// Checksum 0xbcf6a113, Offset: 0x7b5d
// Size: 0x5d
function ondeadevent( team, instance )
{
    if ( level.ingraceperiod )
    {
        return;
    }
    
    if ( team_utility::isgameplayteam( team ) )
    {
        winner = team_utility::getotherteam( team );
        level thread arena_endgame( winner, game[ "end_reason" ][ "mp_faction_eliminated" ], undefined, undefined, undefined, instance );
    }
}

// Namespace arena
// Params 1
// Checksum 0x7d3d9737, Offset: 0x7bc2
// Size: 0x51d
function checkshouldallowtradekilltie( winningteam )
{
    livescount = [];
    
    foreach ( entry in level.teamnamelist )
    {
        livescount[ entry ] = 0;
    }
    
    foreach ( player in level.players )
    {
        if ( !player.hasspawned || player.team == "spectator" || player.team == "codcaster" )
        {
            continue;
        }
        
        livescount[ player.team ] += player.pers[ "lives" ];
    }
    
    hasalivecount = 0;
    
    foreach ( entry in level.teamnamelist )
    {
        if ( teams::getteamdata( entry, "aliveCount" ) )
        {
            hasalivecount = 1;
            break;
        }
    }
    
    haslivescount = 0;
    
    foreach ( count in livescount )
    {
        if ( count )
        {
            haslivescount = 1;
            break;
        }
    }
    
    if ( !hasalivecount && !haslivescount )
    {
        return "tie";
    }
    
    foreach ( entry in level.teamnamelist )
    {
        println( "<dev string:x1a4>" + entry + "<dev string:x1aa>" + teams::getteamdata( entry, "<dev string:x1b9>" ) );
        
        if ( !teams::getteamdata( entry, "aliveCount" ) && !livescount[ entry ] )
        {
            println( "<dev string:x1c4>" + entry );
            
            if ( level.multiteambased )
            {
                if ( !teams::getteamdata( entry, "deathEvent" ) && teams::getteamdata( entry, "hasSpawned" ) )
                {
                    teams::setteamdata( entry, "deathEvent", 1 );
                    return winningteam;
                }
                
                continue;
            }
            
            return winningteam;
        }
    }
    
    foreach ( entry in level.teamnamelist )
    {
        oneleft = teams::getteamdata( entry, "aliveCount" ) == 1;
        
        if ( oneleft )
        {
            teammatelives = 0;
            return_val = undefined;
            players = teams::getteamdata( entry, "players" );
            
            foreach ( player in players )
            {
                if ( !isalive( player ) )
                {
                    teammatelives += player.pers[ "lives" ];
                }
            }
            
            if ( teammatelives == 0 )
            {
                if ( !teams::getteamdata( entry, "oneLeft" ) && gettime() > teams::getteamdata( entry, "oneLeftTime" ) + 5000 )
                {
                    teams::setteamdata( entry, "oneLeftTime", gettime() );
                    teams::setteamdata( entry, "oneLeft", 1 );
                    
                    if ( players.size > 1 )
                    {
                        return winningteam;
                    }
                }
            }
            
            continue;
        }
        
        teams::setteamdata( entry, "oneLeft", 0 );
    }
    
    return winningteam;
}

// Namespace arena
// Params 6
// Checksum 0xa7975eb8, Offset: 0x80e8
// Size: 0x119
function arena_endgame( winningteam, endreasontext, endreasontextloss, nukedetonated, var_de9b655923cddf60, instance )
{
    if ( level.arena.skipendgame )
    {
        return;
    }
    
    if ( winningteam != "tie" )
    {
        if ( level.nukeinfo.incoming )
        {
            return;
        }
        
        waittillframeend();
        winningteam = checkshouldallowtradekilltie( winningteam );
    }
    
    if ( isgungameloadouts() || isrvsgungameloadouts() )
    {
        level setenemyloadoutomnvarsatmatchend( winningteam );
    }
    
    if ( !( level.multimatch ?? gameinstance::is_enabled() ) && winningteam != "tie" )
    {
        otherteam = team_utility::getotherteam( winningteam );
        game[ "roundsTied" ][ winningteam ] = 0;
        game[ "roundsTied" ][ otherteam ] = 0;
    }
    
    if ( level.multimatch ?? gameinstance::is_enabled() )
    {
        gameinstance::function_3979f6a43aa329b( instance, winningteam, endreasontext );
        return;
    }
    
    thread gamelogic_mp::endgame( winningteam, endreasontext, endreasontextloss, nukedetonated, var_de9b655923cddf60 );
}

// Namespace arena
// Params 1
// Checksum 0x3db475b7, Offset: 0x8209
// Size: 0xb9
function runarenaloadoutrulesonplayer( player )
{
    swaploadout = 0;
    
    if ( ispickuploadouts() )
    {
        if ( game[ "roundsPlayed" ] == 0 )
        {
            wait 0.1;
        }
        else
        {
            wait 0.25;
        }
    }
    
    if ( level.var_9eccdafcc2cf5d18 )
    {
        player.pers[ "gamemodeLoadout" ][ "loadoutPrimaryCamo" ] = function_405aca5a71fa95c4( player.pers[ "team" ] );
        player.pers[ "gamemodeLoadout" ][ "loadoutSecondaryCamo" ] = function_405aca5a71fa95c4( player.pers[ "team" ] );
        swaploadout = 1;
    }
    
    if ( swaploadout )
    {
        player class::swaploadout();
    }
}

// Namespace arena
// Params 0
// Checksum 0xbaaa2024, Offset: 0x82ca
// Size: 0x2a9
function buildloadoutsforweaponstreaming()
{
    level.loadweapons = [];
    
    if ( ispickuploadouts() )
    {
        if ( level.startweapon.weapon == "none" || issubstr( level.startweapon.weapon, "equip" ) )
        {
            newweaponobj = level.defaultfist;
            newweapon = getcompleteweaponname( newweaponobj );
        }
        else
        {
            rootname = weapon::getweaponrootname( level.startweapon.weapon );
            attachments = [];
            camoname = "camo_none";
            reticleindex = "none";
            variantid = undefined;
            attachmentids = undefined;
            cosmeticattachment = undefined;
            stickers = undefined;
            
            if ( ispickupblueprintloadouts() )
            {
                newweaponobj = build_weapon_configuration( rootname, undefined, camoname, reticleindex, level.startweapon.variantid, attachmentids, cosmeticattachment, stickers );
            }
            else
            {
                newweaponobj = build_weapon_configuration( rootname, attachments, camoname, reticleindex, variantid, attachmentids, cosmeticattachment, stickers );
            }
            
            newweapon = getcompleteweaponname( newweaponobj );
        }
        
        level.loadweapons[ level.loadweapons.size ] = newweaponobj;
        return;
    }
    
    primaries = [];
    secondaries = [];
    loadout = game[ "arenaRandomLoadout" ][ game[ "arenaRandomLoadoutIndex" ] ];
    primary = loadout[ "loadoutPrimary" ];
    secondary = loadout[ "loadoutSecondary" ];
    
    if ( primary && primary != "none" )
    {
        primaries[ primaries.size ] = function_5f5c496d052a4eab( primary, loadout );
    }
    
    if ( secondary && secondary != "none" )
    {
        secondaries[ secondaries.size ] = function_5f5c496d052a4eab( secondary, loadout );
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
        
        if ( nextprimary && nextprimary != "none" )
        {
            primaries[ primaries.size ] = function_5f5c496d052a4eab( nextprimary, nextloadout );
        }
        
        if ( nextsecondary && nextsecondary != "none" )
        {
            secondaries[ secondaries.size ] = function_5f5c496d052a4eab( nextsecondary, nextloadout );
        }
    }
    
    level.loadweapons = arraycombine( primaries, secondaries );
}

// Namespace arena
// Params 2, eflags: 0x4
// Checksum 0x53c2a903, Offset: 0x857b
// Size: 0x155
function private function_5f5c496d052a4eab( weaponname, loadout )
{
    slotstring = undefined;
    
    if ( weaponname == loadout[ "loadoutPrimary" ] )
    {
        slotstring = "loadoutPrimary";
    }
    else if ( weaponname == loadout[ "loadoutSecondary" ] )
    {
        slotstring = "loadoutSecondary";
    }
    
    assert( isdefined( slotstring ), "<dev string:x20e>" + weaponname + "<dev string:x225>" );
    rootname = weapon::getweaponrootname( loadout[ slotstring ] );
    variantid = loadout[ slotstring + "VariantID" ];
    
    if ( function_7edf0599605cd8ec() )
    {
        weaponobject = weapon::giveweaponblueprint( rootname, variantid );
        return getcompleteweaponname( weaponobject );
    }
    
    attachments = [];
    
    for ( i = 0; i <= 5 ; i++ )
    {
        concat = i;
        
        if ( i == 0 )
        {
            concat = "";
        }
        
        attachment = loadout[ slotstring + "Attachment" + concat ];
        
        if ( attachment != "none" )
        {
            attachments[ attachments.size ] = attachment;
        }
    }
    
    camoname = loadout[ slotstring + "Camo" ];
    reticleindex = loadout[ slotstring + "Reticle" ];
    weaponobject = build_weapon_configuration( rootname, attachments, camoname, reticleindex, variantid );
    return getcompleteweaponname( weaponobject );
}

// Namespace arena
// Params 0
// Checksum 0xe1d8c2f8, Offset: 0x86d9
// Size: 0xc2
function setupblueprintpickupweapons()
{
    level.arenaweapont1 = buildblueprintpickupweapon( level.arenaweapont1 );
    level.arenaweapont2 = buildblueprintpickupweapon( level.arenaweapont2 );
    level.arenaweapont3 = buildblueprintpickupweapon( level.arenaweapont3 );
    level.arenaweapont4 = buildblueprintpickupweapon( level.arenaweapont4 );
    level.arenaweapont5 = buildblueprintpickupweapon( level.arenaweapont5 );
    level.arenaweapont6 = buildblueprintpickupweapon( level.arenaweapont6 );
    level.arenaweapont7 = buildblueprintpickupweapon( level.arenaweapont7 );
    level.arenaweapont8 = buildblueprintpickupweapon( level.arenaweapont8 );
}

// Namespace arena
// Params 1
// Checksum 0x36936318, Offset: 0x87a3
// Size: 0x10f
function buildblueprintpickupweapon( weapontierstruct )
{
    weapontierstruct.weapon = weapontierstruct.weapon;
    
    if ( !issubstr( weapontierstruct.weapon, "equip" ) && weapontierstruct.weapon != "none" )
    {
        attachments = [];
        camoname = "camo_none";
        reticleindex = "none";
        variantid = weapontierstruct.variantid;
        attachmentids = undefined;
        cosmeticattachment = undefined;
        stickers = [];
        stickers[ 0 ] = "sticker_none";
        stickers[ 1 ] = "sticker_none";
        stickers[ 2 ] = "sticker_none";
        stickers[ 3 ] = "sticker_none";
        stickers[ 4 ] = "sticker_none";
        weapontierstruct.weaponobj = build_weapon_configuration( weapontierstruct.weapon, undefined, undefined, undefined, variantid, undefined, undefined, undefined, utility::function_2a082dafe6f4bd5b() );
    }
    
    return weapontierstruct;
}

// Namespace arena
// Params 0
// Checksum 0xd51a8a91, Offset: 0x88bb
// Size: 0xda
function setupstartweaponsattachments()
{
    level.startweapon = setupweaponattachmentoverrides( level.startweapon );
    level.arenaweapont1 = setupweaponattachmentoverrides( level.arenaweapont1 );
    level.arenaweapont2 = setupweaponattachmentoverrides( level.arenaweapont2 );
    level.arenaweapont3 = setupweaponattachmentoverrides( level.arenaweapont3 );
    level.arenaweapont4 = setupweaponattachmentoverrides( level.arenaweapont4 );
    level.arenaweapont5 = setupweaponattachmentoverrides( level.arenaweapont5 );
    level.arenaweapont6 = setupweaponattachmentoverrides( level.arenaweapont6 );
    level.arenaweapont7 = setupweaponattachmentoverrides( level.arenaweapont7 );
    level.arenaweapont8 = setupweaponattachmentoverrides( level.arenaweapont8 );
}

// Namespace arena
// Params 1
// Checksum 0x8156b600, Offset: 0x899d
// Size: 0xcc
function setupweaponattachmentoverrides( weapontierstruct )
{
    weapontierstruct.weapon = weapontierstruct.weapon;
    
    if ( !issubstr( weapontierstruct.weapon, "equip" ) && weapontierstruct.weapon != "none" )
    {
        attachments = [];
        camoname = "camo_none";
        reticleindex = "none";
        variantid = undefined;
        rootname = weapon::getweaponrootname( weapontierstruct.weapon );
        attachments = getarenapickupattachmentoverrides( rootname + "_mp" );
        weapontierstruct.weaponobj = build_weapon_configuration( rootname, attachments, camoname, reticleindex, variantid );
    }
    
    return weapontierstruct;
}

// Namespace arena
// Params 1
// Checksum 0x9292f074, Offset: 0x8a72
// Size: 0x3b
function getattachmentoverride( weapon )
{
    rootname = weapon::getweaponrootname( weapon );
    attachments = getarenapickupattachmentoverrides( rootname + "_mp" );
    return attachments[ 0 ];
}

// Namespace arena
// Params 0
// Checksum 0x9ea35e33, Offset: 0x8ab6
// Size: 0x665
function defineplayerloadout()
{
    attachments = [];
    attachments[ 0 ] = "none";
    attachments[ 1 ] = "none";
    attachments[ 2 ] = "none";
    attachments[ 3 ] = "none";
    attachments[ 4 ] = "none";
    camoname = "none";
    reticleindex = "none";
    variantid = 0;
    attachmentids = undefined;
    cosmeticattachment = undefined;
    stickers = [];
    stickers[ 0 ] = "sticker_none";
    stickers[ 1 ] = "sticker_none";
    stickers[ 2 ] = "sticker_none";
    stickers[ 3 ] = "sticker_none";
    stickers[ 4 ] = "sticker_none";
    perks = [ "specialty_blastshield" ];
    primaryequipment = getdvarint( @"hash_54d1fe2061337821", 0 ) ? "equip_snowball" : "none";
    secondaryequipment = "none";
    
    if ( isdefined( level.startweapon.weapon ) && level.startweapon.weapon != "none" && !issubstr( level.startweapon.weapon, "equip" ) )
    {
        primary = weapon::getweaponrootname( level.startweapon.weapon );
        
        if ( ispickupblueprintloadouts() )
        {
            variantid = level.startweapon.variantid;
        }
        
        if ( level.arenapickupattachments > 0 )
        {
            attachments[ 0 ] = getattachmentoverride( level.startweapon.weapon );
        }
    }
    else
    {
        primary = "none";
        
        if ( issubstr( level.startweapon.weapon, "equip" ) )
        {
            if ( isthrowingknifeequipment( level.startweapon.weapon ) )
            {
                perks[ perks.size ] = "specialty_extra_deadly";
                
                if ( level.arenaknivesout )
                {
                    perks[ perks.size ] = "specialty_restock";
                    
                    if ( level.arenaknivesout == 2 )
                    {
                        primary = "iw9_knife";
                    }
                }
            }
            
            slot = equipment_mp::getdefaultslot( level.startweapon.weapon );
            
            if ( slot == "primary" )
            {
                primaryequipment = level.startweapon.weapon;
            }
            else
            {
                secondaryequipment = level.startweapon.weapon;
            }
        }
    }
    
    if ( level.allowsupers )
    {
        mapname = game_utility::getmapname();
        
        if ( issubstr( mapname, "mp_m_" ) && mapname != "mp_m_speed" )
        {
            level.arenasuper = fixupsupersandtacticalsforgunfightmaps();
        }
    }
    else
    {
        level.arenasuper = "none";
        setomnvar( "ui_disable_fieldupgrades", 1 );
    }
    
    level.var_c72b61d4740c82eb[ "loadoutArchetype" ] = "archetype_assault";
    level.var_c72b61d4740c82eb[ "loadoutPrimary" ] = primary;
    level.var_c72b61d4740c82eb[ "loadoutPrimaryAttachment" ] = attachments[ 0 ];
    level.var_c72b61d4740c82eb[ "loadoutPrimaryAttachment2" ] = attachments[ 1 ];
    level.var_c72b61d4740c82eb[ "loadoutPrimaryAttachment3" ] = attachments[ 2 ];
    level.var_c72b61d4740c82eb[ "loadoutPrimaryAttachment4" ] = attachments[ 3 ];
    level.var_c72b61d4740c82eb[ "loadoutPrimaryAttachment5" ] = attachments[ 4 ];
    level.var_c72b61d4740c82eb[ "loadoutPrimaryCamo" ] = camoname;
    level.var_c72b61d4740c82eb[ "loadoutPrimaryCosmeticAttachment" ] = cosmeticattachment;
    level.var_c72b61d4740c82eb[ "loadoutPrimaryReticle" ] = reticleindex;
    level.var_c72b61d4740c82eb[ "loadoutPrimarySticker2" ] = stickers[ 2 ];
    level.var_c72b61d4740c82eb[ "loadoutPrimarySticker" ] = stickers[ 0 ];
    level.var_c72b61d4740c82eb[ "loadoutPrimarySticker1" ] = stickers[ 1 ];
    level.var_c72b61d4740c82eb[ "loadoutPrimarySticker3" ] = stickers[ 3 ];
    level.var_c72b61d4740c82eb[ "loadoutPrimarySticker4" ] = stickers[ 4 ];
    level.var_c72b61d4740c82eb[ "loadoutPrimaryVariantID" ] = variantid;
    level.var_c72b61d4740c82eb[ "loadoutSecondary" ] = "none";
    level.var_c72b61d4740c82eb[ "loadoutSecondaryAttachment" ] = "none";
    level.var_c72b61d4740c82eb[ "loadoutSecondaryAttachment2" ] = "none";
    level.var_c72b61d4740c82eb[ "loadoutSecondaryAttachment3" ] = "none";
    level.var_c72b61d4740c82eb[ "loadoutSecondaryAttachment4" ] = "none";
    level.var_c72b61d4740c82eb[ "loadoutSecondaryAttachment5" ] = "none";
    level.var_c72b61d4740c82eb[ "loadoutSecondaryCamo" ] = "none";
    level.var_c72b61d4740c82eb[ "loadoutSecondaryReticle" ] = "none";
    level.var_c72b61d4740c82eb[ "loadoutSecondarySticker" ] = "sticker_none";
    level.var_c72b61d4740c82eb[ "loadoutSecondarySticker1" ] = "sticker_none";
    level.var_c72b61d4740c82eb[ "loadoutSecondarySticker2" ] = "sticker_none";
    level.var_c72b61d4740c82eb[ "loadoutSecondarySticker3" ] = "sticker_none";
    level.var_c72b61d4740c82eb[ "loadoutSecondarySticker4" ] = "sticker_none";
    level.var_c72b61d4740c82eb[ "loadoutSecondaryVariantID" ] = -1;
    level.var_c72b61d4740c82eb[ "loadoutMeleeSlot" ] = "none";
    level.var_c72b61d4740c82eb[ "loadoutEquipmentPrimary" ] = primaryequipment;
    level.var_c72b61d4740c82eb[ "loadoutEquipmentSecondary" ] = secondaryequipment;
    level.var_c72b61d4740c82eb[ "loadoutStreakType" ] = "assault";
    level.var_c72b61d4740c82eb[ "loadoutKillstreak1" ] = "none";
    level.var_c72b61d4740c82eb[ "loadoutKillstreak2" ] = "none";
    level.var_c72b61d4740c82eb[ "loadoutKillstreak3" ] = "none";
    level.var_c72b61d4740c82eb[ "loadoutSuper" ] = "none";
    level.var_c72b61d4740c82eb[ "loadoutFieldUpgrade1" ] = level.arenasuper;
    level.var_c72b61d4740c82eb[ "loadoutFieldUpgrade2" ] = "none";
    level.var_c72b61d4740c82eb[ "loadoutPerks" ] = perks;
    level.var_c72b61d4740c82eb[ "loadoutGesture" ] = "playerData";
    level.var_c72b61d4740c82eb[ "loadoutExecution" ] = "playerData";
}

// Namespace arena
// Params 1
// Checksum 0x867841b1, Offset: 0x9123
// Size: 0x95e
function function_405aca5a71fa95c4( teamname )
{
    camoname = "none";
    
    if ( !isdefined( teamname ) || teamname != "allies" && teamname != "axis" || teamname != game[ "previousWinningTeam" ] )
    {
        return camoname;
    }
    
    camos = [ "camo_a_01", "camo_b_01", "camo_c_01", "camo_d_01", "camo_e_01", "camo_f_01", "camo_g_01", "camo_h_01", "camo_i_01", "camo_j_01", "camo_k_01", "camo_l_01", "camo_m_01", "camo_n_01", "camo_o_01", "camo_p_01", "camo_r_01", "camo_comp_01", "camo_a_02", "camo_b_02", "camo_c_02", "camo_d_02", "camo_e_02", "camo_f_02", "camo_g_02", "camo_h_02", "camo_i_02", "camo_j_02", "camo_k_02", "camo_l_02", "camo_m_02", "camo_n_02", "camo_o_02", "camo_p_02", "camo_r_02", "camo_comp_02", "camo_a_03", "camo_b_03", "camo_c_03", "camo_d_03", "camo_e_03", "camo_f_03", "camo_g_03", "camo_h_03", "camo_i_03", "camo_j_03", "camo_k_03", "camo_l_03", "camo_m_03", "camo_n_03", "camo_o_03", "camo_p_03", "camo_comp_03", "camo_a_04", "camo_b_04", "camo_c_04", "camo_d_04", "camo_e_04", "camo_f_04", "camo_g_04", "camo_h_04", "camo_i_04", "camo_j_04", "camo_k_04", "camo_l_04", "camo_m_04", "camo_n_04", "camo_o_04", "camo_p_04", "camo_comp_04", "camo_a_05", "camo_b_05", "camo_c_05", "camo_d_05", "camo_e_05", "camo_f_05", "camo_g_05", "camo_h_05", "camo_i_05", "camo_j_05", "camo_k_05", "camo_l_05", "camo_m_05", "camo_n_05", "camo_o_05", "camo_p_05", "camo_a_06", "camo_b_06", "camo_c_06", "camo_d_06", "camo_e_06", "camo_f_06", "camo_g_06", "camo_h_06", "camo_i_06", "camo_j_06", "camo_k_06", "camo_l_06", "camo_m_06", "camo_n_06", "camo_o_06", "camo_p_06", "camo_a_07", "camo_b_07", "camo_c_07", "camo_d_07", "camo_e_07", "camo_f_07", "camo_g_07", "camo_h_07", "camo_i_07", "camo_j_07", "camo_k_07", "camo_l_07", "camo_m_07", "camo_n_07", "camo_o_07", "camo_p_07", "camo_a_08", "camo_b_08", "camo_c_08", "camo_d_08", "camo_e_08", "camo_f_08", "camo_g_08", "camo_h_08", "camo_i_08", "camo_j_08", "camo_k_08", "camo_l_08", "camo_m_08", "camo_n_08", "camo_o_08", "camo_p_08", "camo_a_09", "camo_b_09", "camo_c_09", "camo_d_09", "camo_e_09", "camo_f_09", "camo_g_09", "camo_h_09", "camo_i_09", "camo_j_09", "camo_k_09", "camo_l_09", "camo_m_09", "camo_n_09", "camo_o_09", "camo_a_10", "camo_b_10", "camo_c_10", "camo_d_10", "camo_e_10", "camo_f_10", "camo_g_10", "camo_h_10", "camo_i_10", "camo_j_10", "camo_k_10", "camo_l_10", "camo_m_10", "camo_n_10", "camo_o_10", "camo_a_11", "camo_b_11", "camo_c_11", "camo_d_11", "camo_e_11", "camo_f_11", "camo_g_11", "camo_h_11", "camo_i_11", "camo_j_11", "camo_k_11", "camo_l_11", "camo_m_11", "camo_n_11", "camo_o_11", "camo_a_12", "camo_b_12", "camo_c_12", "camo_d_12", "camo_e_12", "camo_f_12", "camo_g_12", "camo_h_12", "camo_i_12", "camo_j_12", "camo_k_12", "camo_l_12", "camo_m_12", "camo_n_12", "camo_o_12", "camo_a_13", "camo_b_13", "camo_c_13", "camo_d_13", "camo_e_13", "camo_f_13", "camo_g_13", "camo_h_13", "camo_i_13", "camo_j_13", "camo_k_13", "camo_l_13", "camo_m_13", "camo_n_13", "camo_o_13", "camo_a_14", "camo_b_14", "camo_c_14", "camo_d_14", "camo_e_14", "camo_f_14", "camo_g_14", "camo_h_14", "camo_i_14", "camo_j_14", "camo_k_14", "camo_l_14", "camo_m_14", "camo_n_14", "camo_o_14", "camo_a_15", "camo_b_15", "camo_c_15", "camo_d_15", "camo_e_15", "camo_f_15", "camo_g_15", "camo_h_15", "camo_i_15", "camo_j_15", "camo_k_15", "camo_l_15", "camo_m_15", "camo_n_15" ];
    
    if ( game[ "roundWinStreak" ] > 5 )
    {
        camoname = "camo_comp_04";
    }
    else
    {
        switch ( game[ "roundWinStreak" ] )
        {
            case 1:
                camoname = utility::array_random( camos );
                break;
            case 2:
                camoname = "camo_comp_01";
                break;
            case 3:
                camoname = "camo_comp_02";
                break;
            case 4:
                camoname = "camo_comp_03";
                break;
            case 5:
                camoname = "camo_comp_04";
                break;
            default:
                break;
        }
    }
    
    return camoname;
}

// Namespace arena
// Params 0
// Checksum 0x676099de, Offset: 0x9a8a
// Size: 0x101
function updaterandomloadout()
{
    if ( level.enable_gunfight_loadouts )
    {
        return;
    }
    
    if ( israndomloadouts() )
    {
        /#
            if ( getdvarint( @"hash_b665ceb14dabc0ed", -1 ) != -1 )
            {
                game[ "<dev string:x259>" ] = randomize_loadouts();
                game[ "<dev string:x26c>" ] = 0;
                return;
            }
        #/
        
        if ( game[ "roundsPlayed" ] == 0 )
        {
            if ( game[ "practiceRound" ] )
            {
                game[ "arenaRandomLoadout" ] = randomize_loadouts();
                game[ "arenaRandomLoadoutIndex" ] = 0;
            }
            else if ( !isdefined( game[ "practiceRound" ] ) || game[ "didSnowFight" ] )
            {
                if ( game[ "didSnowFight" ] )
                {
                    game[ "didSnowFight" ] = undefined;
                }
                
                game[ "arenaRandomLoadout" ] = randomize_loadouts();
                game[ "arenaRandomLoadoutIndex" ] = 0;
            }
            
            return;
        }
        
        if ( level.loadoutchangeround != 0 )
        {
            if ( should_change_loadouts() )
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

// Namespace arena
// Params 3
// Checksum 0xcbddcc4d, Offset: 0x9b93
// Size: 0x342
function function_6220187e61c1d47( var_bac7eef33ecb76cf, var_c90a8edf99dc52e9, var_871d3bf1107923be )
{
    classtables = [];
    loadouttypes = var_bac7eef33ecb76cf ?? [];
    weapontypes = var_c90a8edf99dc52e9 ?? [];
    projects = var_871d3bf1107923be ?? [];
    
    if ( loadouttypes.size == 0 )
    {
        if ( israndomblueprintsloadouts() )
        {
            loadouttypes[ loadouttypes.size ] = "arena_blueprints_class_table";
        }
        else
        {
            loadouttypes[ loadouttypes.size ] = "arena_class_table";
        }
    }
    
    if ( weapontypes.size == 0 )
    {
        var_acd8f03b501e87b3 = !israndomarloadouts() && !israndomsmgloadouts() && !israndomlmgloadouts() && !israndompistolloadouts() && !israndomshotgunloadouts() && !israndomsniperloadouts() && !function_ad8b8fa721fa6c8c();
        
        if ( var_acd8f03b501e87b3 || israndomarloadouts() )
        {
            weapontypes[ weapontypes.size ] = "ar";
        }
        
        if ( var_acd8f03b501e87b3 || israndomsmgloadouts() )
        {
            weapontypes[ weapontypes.size ] = "smg";
        }
        
        if ( var_acd8f03b501e87b3 || israndomlmgloadouts() )
        {
            weapontypes[ weapontypes.size ] = "lmg";
        }
        
        if ( var_acd8f03b501e87b3 || israndompistolloadouts() )
        {
            weapontypes[ weapontypes.size ] = "pistol";
        }
        
        if ( var_acd8f03b501e87b3 || israndomshotgunloadouts() )
        {
            weapontypes[ weapontypes.size ] = "shotgun";
        }
        
        if ( var_acd8f03b501e87b3 || israndomsniperloadouts() )
        {
            weapontypes[ weapontypes.size ] = "sniper";
        }
        
        if ( function_ad8b8fa721fa6c8c() )
        {
            weapontypes[ weapontypes.size ] = "me";
        }
    }
    
    if ( projects.size == 0 )
    {
        projects[ projects.size ] = "iw9_mp";
    }
    
    foreach ( loadouttype in loadouttypes )
    {
        foreach ( weapontype in weapontypes )
        {
            foreach ( project in projects )
            {
                classtablename = function_5d044133536d0766( "_", [ loadouttype, weapontype, project ] );
                classtablename = function_5d044133536d0766( ":", [ "classtable", classtablename ] );
                classtablebundle = getscriptbundle( classtablename );
                classtables[ classtables.size ] = classtablebundle;
                assert( isdefined( classtablebundle ), "<dev string:x284>" );
            }
        }
    }
    
    return classtables;
}

// Namespace arena
// Params 0
// Checksum 0x876c8b0b, Offset: 0x9ede
// Size: 0x1ac
function function_5a85540822dd168a()
{
    classtables = [];
    var_acd8f03b501e87b3 = isnormalloadouts() || israndomloadouts();
    weapontypes[ #"ar" ] = israndomarloadouts();
    weapontypes[ #"smg" ] = israndomsmgloadouts();
    weapontypes[ #"lmg" ] = israndomlmgloadouts();
    weapontypes[ #"pistol" ] = israndompistolloadouts();
    weapontypes[ #"shotgun" ] = israndomshotgunloadouts();
    weapontypes[ #"sniper" ] = israndomsniperloadouts();
    weapontypes[ #"me" ] = function_ad8b8fa721fa6c8c();
    var_51b719d5f13179ff = level.gametypebundle.var_14a374941dd4696c;
    
    foreach ( loadoutentry in var_51b719d5f13179ff )
    {
        if ( !isdefined( loadoutentry.bundle ) )
        {
            continue;
        }
        
        if ( !weapontypes[ loadoutentry.weapon_type ] && !var_acd8f03b501e87b3 )
        {
            continue;
        }
        
        classtablexhash = hashcat( %"classtable:", loadoutentry.bundle );
        classtablebundle = getscriptbundle( classtablexhash );
        assert( isdefined( classtablebundle ), "<dev string:x284>" );
        classtables[ classtables.size ] = classtablebundle;
    }
    
    return classtables;
}

// Namespace arena
// Params 1
// Checksum 0xa0587fe5, Offset: 0xa093
// Size: 0x561
function function_4ba1689208fa4c96( loadoutstruct )
{
    loadoutscriptbundle = getscriptbundle( "classtableentry:" + loadoutstruct.entry );
    loadout = [];
    loadout[ "loadoutPrimary" ] = loadoutscriptbundle.primaryweapon.weapon;
    loadout[ "loadoutPrimaryAttachment" ] = !israndomnoattachmentloadouts() ? loadoutscriptbundle.primaryweapon.attachment1 : "none";
    loadout[ "loadoutPrimaryAttachment1" ] = !israndomnoattachmentloadouts() ? loadoutscriptbundle.primaryweapon.attachment2 : "none";
    loadout[ "loadoutPrimaryAttachment2" ] = !israndomnoattachmentloadouts() ? loadoutscriptbundle.primaryweapon.attachment3 : "none";
    loadout[ "loadoutPrimaryAttachment3" ] = !israndomnoattachmentloadouts() ? loadoutscriptbundle.primaryweapon.attachment4 : "none";
    loadout[ "loadoutPrimaryAttachment4" ] = !israndomnoattachmentloadouts() ? loadoutscriptbundle.primaryweapon.attachment5 : "none";
    loadout[ "loadoutPrimaryAttachment5" ] = !israndomnoattachmentloadouts() ? loadoutscriptbundle.primaryweapon.attachment6 : "none";
    loadout[ "loadoutPrimaryCamo" ] = loadoutscriptbundle.primaryweapon.camo;
    loadout[ "loadoutPrimaryReticle" ] = loadoutscriptbundle.primaryweapon.reticle;
    loadout[ "loadoutPrimaryVariantID" ] = israndomblueprintsloadouts() || israndomcustomblueprintsloadouts() ? loadoutscriptbundle.primaryweapon.variantid : 0;
    loadout[ "loadoutSecondary" ] = loadoutscriptbundle.secondaryweapon.weapon;
    loadout[ "loadoutSecondaryAttachment" ] = !israndomnoattachmentloadouts() ? loadoutscriptbundle.secondaryweapon.attachment1 : "none";
    loadout[ "loadoutSecondaryAttachment1" ] = !israndomnoattachmentloadouts() ? loadoutscriptbundle.secondaryweapon.attachment2 : "none";
    loadout[ "loadoutSecondaryAttachment2" ] = !israndomnoattachmentloadouts() ? loadoutscriptbundle.secondaryweapon.attachment3 : "none";
    loadout[ "loadoutSecondaryAttachment3" ] = !israndomnoattachmentloadouts() ? loadoutscriptbundle.secondaryweapon.attachment4 : "none";
    loadout[ "loadoutSecondaryAttachment4" ] = !israndomnoattachmentloadouts() ? loadoutscriptbundle.secondaryweapon.attachment5 : "none";
    loadout[ "loadoutSecondaryCamo" ] = loadoutscriptbundle.secondaryweapon.camo;
    loadout[ "loadoutSecondaryReticle" ] = loadoutscriptbundle.secondaryweapon.reticle;
    loadout[ "loadoutSecondaryVariantID" ] = israndomblueprintsloadouts() || israndomcustomblueprintsloadouts() ? loadoutscriptbundle.primaryweapon.variantid : 0;
    loadout[ "loadoutEquipmentPrimary" ] = loadoutscriptbundle.equipment.primary;
    loadout[ "loadoutEquipmentSecondary" ] = loadoutscriptbundle.equipment.secondary;
    loadout[ "loadoutExtraEquipmentPrimary" ] = loadoutscriptbundle.extrapower.primary;
    loadout[ "loadoutExtraEquipmentSecondary" ] = loadoutscriptbundle.extrapower.secondary;
    
    if ( level.allowsupers )
    {
        mapname = game_utility::getmapname();
        
        if ( issubstr( mapname, "mp_m_" ) && mapname != "mp_m_speed" )
        {
            fixupsupersandtacticalsforgunfightmaps();
        }
    }
    
    loadout[ "loadoutFieldUpgrade1" ] = level.arenasuper;
    loadout[ "loadoutFieldUpgrade2" ] = "none";
    loadout[ "loadoutPerks" ] = [];
    loadout[ "loadoutPerks" ][ 0 ] = loadoutscriptbundle.perks.perk1 != "specialty_null" ? loadoutscriptbundle.perks.perk1 : "none";
    loadout[ "loadoutPerks" ][ 1 ] = loadoutscriptbundle.perks.perk2 != "specialty_null" ? loadoutscriptbundle.perks.perk2 : "none";
    loadout[ "loadoutPerks" ][ 2 ] = loadoutscriptbundle.perks.perk3 != "specialty_null" ? loadoutscriptbundle.perks.perk3 : "none";
    loadout[ "loadoutGesture" ] = "playerData";
    loadout[ "loadoutExecution" ] = "playerData";
    
    if ( game_utility::getgametype() == "arena" )
    {
        if ( loadout[ "loadoutPrimaryVariantID" ] != 0 )
        {
            setomnvar( "ui_arena_primaryVariantID", loadout[ "loadoutPrimaryVariantID" ] );
        }
        
        if ( loadout[ "loadoutSecondaryVariantID" ] != 0 )
        {
            setomnvar( "ui_arena_secondaryVariantID", loadout[ "loadoutPrimaryVariantID" ] );
        }
    }
    
    return loadout;
}

// Namespace arena
// Params 0
// Checksum 0xd8f00b35, Offset: 0xa5fd
// Size: 0x10a
function initweaponmap()
{
    level.baseraritymap = [];
    level.baseraritymap[ level.arenaweapont1.weapon ] = 0;
    level.baseraritymap[ level.arenaweapont2.weapon ] = 1;
    level.baseraritymap[ level.arenaweapont3.weapon ] = 2;
    level.baseraritymap[ level.arenaweapont4.weapon ] = 3;
    level.baseraritymap[ level.arenaweapont5.weapon ] = 4;
    level.baseraritymap[ level.arenaweapont6.weapon ] = 5;
    level.baseraritymap[ level.arenaweapont7.weapon ] = 6;
    level.baseraritymap[ level.arenaweapont8.weapon ] = 0;
}

// Namespace arena
// Params 1
// Checksum 0x6bea4ef6, Offset: 0xa70f
// Size: 0xae
function getblueprintforpickupweapon( weapon )
{
    if ( ispickupblueprintloadouts() && !issubstr( weapon, "equip" ) && weapon != "none" )
    {
        table = level.classtablename;
        classidx = 0;
        tablerootname = "";
        rootname = weapon::getweaponrootname( weapon );
        numloadouts = class::function_868832c7872f848e( table );
        
        while ( classidx < numloadouts )
        {
            tablerootname = class::table_getweapon( table, classidx, 0 );
            
            if ( rootname == tablerootname )
            {
                break;
            }
            
            classidx++;
        }
        
        return 0;
    }
    
    return 0;
}

// Namespace arena
// Params 0
// Checksum 0x54b464ce, Offset: 0xa7c5
// Size: 0x265
function setupweapons()
{
    locs = utility::getstructarray( "weapon_pickup", "targetname" );
    assert( locs.size > 0, "<dev string:x2c5>" );
    
    if ( level.arenapickupattachments != 0 )
    {
        setupstartweaponsattachments();
    }
    else if ( ispickupblueprintloadouts() )
    {
        setupblueprintpickupweapons();
    }
    
    foreach ( loc in locs )
    {
        /#
            debugspawnweapon = getdvar( @"hash_e7ea6273ed7f950f", "<dev string:x321>" );
            
            if ( debugspawnweapon != "<dev string:x321>" )
            {
                var_739596a1dec27fd7 = spawnstruct();
                var_739596a1dec27fd7.weapon = debugspawnweapon;
                var_739596a1dec27fd7.variantid = -1;
                spawnweapon( loc, var_739596a1dec27fd7 );
                continue;
            }
        #/
        
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

// Namespace arena
// Params 0
// Checksum 0xf1404ed5, Offset: 0xaa32
// Size: 0xfd
function getrandomspawnweapon()
{
    weaponlist = level.allweapons;
    
    if ( isdefined( weaponlist ) && weaponlist.size > 0 )
    {
        newweapon = "";
        data = undefined;
        
        for ( loopcount = 0; true ; loopcount++ )
        {
            weapon = utility::array_random( weaponlist );
            
            if ( !issubstr( weapon, "equip" ) )
            {
                rootname = weapon::getweaponrootname( weapon );
            }
            else
            {
                rootname = weapon;
            }
            
            if ( loopcount > weaponlist.size )
            {
                level.selectedweapons[ rootname ] = 1;
                newweapon = weapon;
                
                for ( i = 0; i < level.allweapons.size ; i++ )
                {
                    if ( level.allweapons[ weapon ] == newweapon )
                    {
                        break;
                    }
                }
                
                break;
            }
        }
        
        return newweapon;
    }
    
    assertmsg( "<dev string:x322>" );
    return "none";
}

// Namespace arena
// Params 1
// Checksum 0x6cebbd77, Offset: 0xab37
// Size: 0x67
function getarenapickupattachmentoverrides( weapon )
{
    attachments = [];
    
    if ( level.arenapickupattachments == 1 )
    {
        if ( weaponclass( weapon ) == "sniper" || weaponclass( weapon ) == "dmr" )
        {
            attachments[ attachments.size ] = "scope";
        }
    }
    
    if ( attachments.size == 0 )
    {
        attachments[ attachments.size ] = "none";
    }
    
    return attachments;
}

// Namespace arena
// Params 3
// Checksum 0x4db1e056, Offset: 0xaba7
// Size: 0x5e9
function spawnweapon( loc, weaponstruct, var_6a329e8324470fb1 )
{
    if ( isdefined( var_6a329e8324470fb1 ) )
    {
        weapontier = weaponstruct;
    }
    else
    {
        weapontier = weaponstruct.weapon;
    }
    
    if ( weapontier == "none" )
    {
        return;
    }
    
    loc = function_8b9f48ea2a56e60f( loc );
    loc = function_bafceaf37beed82f( loc, weapontier );
    
    if ( loc.script_noteworthy == "wall" || loc.script_label == "snowball" )
    {
    }
    else
    {
        tracestart = loc.origin + ( 0, 0, 16 );
        traceend = loc.origin + ( 0, 0, -16 );
        trace = trace::ray_trace( tracestart, traceend, undefined, trace::create_default_contents( 1 ) );
        
        if ( trace[ "fraction" ] < 1 )
        {
            snappos = trace[ "position" ] + ( 0, 0, 2 );
        }
    }
    
    equipmentinfo = function_a12fa9194f151302( weapontier );
    
    if ( isdefined( equipmentinfo ) )
    {
        if ( level.snowballfight && weapontier == "equip_snowball" )
        {
            snowtype = "pyramid";
            equipmentmodel = "decor_snowball_pyramid_01";
            
            if ( !isplayer( loc ) && loc.script_label == "6" && !level.pickedpball )
            {
                level.pickedpball = 1;
                weapontier = "equip_pball";
                snowtype = "pball";
                equipmentmodel = "weapon_wm_snowball_urine";
            }
            
            if ( weapontier == "equip_pball" )
            {
                equipmentinfo = function_a12fa9194f151302( weapontier );
            }
            
            if ( !isdefined( snappos ) )
            {
                snappos = loc.origin;
            }
            
            equipment = spawn( "script_model", snappos );
            equipment setmodel( equipmentmodel );
            
            /#
                if ( weapontier == "<dev string:x336>" )
                {
                    level thread showpball( equipment );
                }
            #/
        }
        else
        {
            equipment = spawn( "script_model", loc.origin );
            equipment setmodel( equipmentinfo.worldmodel );
        }
        
        userange = 96;
        hintdisplayrange = 96;
        
        /#
            if ( getdvarint( @"hash_16a5fe0ac78e7780", 0 ) == 1 )
            {
                hintdisplayrange = 128;
            }
        #/
        
        equipmenthinticon = equipment getequipmenthinticon( weapontier );
        equipment.equipment = weapontier;
        equipment.equiptype = equipmentinfo.equiptype;
        equipment.angles = loc.angles;
        
        if ( level.snowballfight && isdefined( snowtype ) && snowtype == "pyramid" )
        {
        }
        else
        {
            equipment.angles += ( 0, 0, 90 );
        }
        
        equipment makeusable();
        equipment sethinttag( "tag_origin" );
        equipment setcursorhint( "HINT_BUTTON" );
        equipment sethinticon( equipmentinfo.icon );
        equipment setuseholdduration( "duration_short" );
        equipment setusehideprogressbar( 1 );
        equipment sethintstring( equipmentinfo.pickupstring );
        equipment setusepriority( 0 );
        equipment sethintdisplayrange( hintdisplayrange );
        equipment sethintdisplayfov( 120 );
        equipment setuserange( userange );
        equipment setusefov( 210 );
        equipment sethintonobstruction( "hide" );
        equipment thread outlineequipmentwatchplayerprox( weapontier );
        equipment.proxtrigger = spawn( "trigger_radius", equipment.origin, 0, 32, 32 );
        
        if ( level.snowballfight && isdefined( snowtype ) )
        {
            equipment thread watchsnowballpickup( loc, snowtype );
        }
        else
        {
            equipment thread itemproxtriggerthink();
            equipment thread watchequipmentpickup();
        }
        
        equipment.targetname = "dropped_equipment";
        return;
    }
    
    if ( ispickupblueprintloadouts() )
    {
        objweapon = weaponstruct.weaponobj;
    }
    else
    {
        rootname = weapon::getweaponrootname( weapontier );
        attachments = getarenapickupattachmentoverrides( rootname + "_mp" );
        objweapon = build_weapon_configuration( rootname, attachments, "camo_none", "none", -1 );
    }
    
    weaponname = getcompleteweaponname( objweapon );
    weapon = spawn( "weapon_" + weaponname, loc.origin, 17 );
    weapon.targetname = "dropped_weapon";
    weapon.objweapon = objweapon;
    weapon.angles = loc.angles;
    weapon sethintdisplayrange( 96 );
    weapon setuserange( 96 );
    weapon setuseholdduration( "duration_short" );
    weapon setusefov( 210 );
    
    if ( loc.script_noteworthy == "wall" )
    {
        forward = anglestoright( loc.angles );
        delta = vectornormalize( forward ) * 30;
        tracestart = loc.origin + delta + ( 0, 0, 16 );
        traceend = loc.origin + delta + ( 0, 0, -100 );
        trace = trace::ray_trace( tracestart, traceend, undefined, trace::create_default_contents( 1 ) );
        tracepos = loc.origin;
        
        if ( trace[ "fraction" ] < 1 )
        {
            tracepos = trace[ "position" ];
        }
        
        weapon.bot_pickup_origin = tracepos;
    }
    
    manageweaponstartingammo( weapon, weaponname );
    weapon thread outlinewatchplayerprox();
    weapon thread watchpickup();
}

/#

    // Namespace arena
    // Params 1
    // Checksum 0x672872fe, Offset: 0xb198
    // Size: 0x6c, Type: dev
    function showpball( model )
    {
        model endon( #"entitydeleted" );
        
        while ( !isdefined( level.player ) )
        {
            waitframe();
        }
        
        while ( true )
        {
            line( model.origin, level.player.origin, ( 1, 1, 1 ), 1, 0, 1 );
            waitframe();
        }
    }

#/

// Namespace arena
// Params 2, eflags: 0x4
// Checksum 0x50e90cda, Offset: 0xb20c
// Size: 0x545
function private function_bafceaf37beed82f( loc, weaponname )
{
    assert( isdefined( loc ) );
    assert( weaponname );
    
    switch ( weaponname )
    {
        case #"hash_25ac81b822cf0c9f":
            if ( isdefined( loc.script_noteworthy ) && loc.script_noteworthy == "wall" || isdefined( loc.var_8d2bc841d9879d97 ) && loc.var_8d2bc841d9879d97 == "wall" )
            {
                loc.angles += ( 0, 90, 0 );
            }
            else
            {
                loc.angles += ( 90, 0, 0 );
            }
            
            break;
        case #"hash_3995658e01f4fac1":
            if ( isdefined( loc.script_noteworthy ) && loc.script_noteworthy == "wall" || isdefined( loc.var_8d2bc841d9879d97 ) && loc.var_8d2bc841d9879d97 == "wall" )
            {
                loc.angles += ( 270, 0, 0 );
            }
            else
            {
                loc.angles += ( 0, 0, 90 );
            }
            
            break;
        case #"hash_4320d77f90725183":
            if ( isdefined( loc.script_noteworthy ) && loc.script_noteworthy == "wall" || isdefined( loc.var_8d2bc841d9879d97 ) && loc.var_8d2bc841d9879d97 == "wall" )
            {
                loc.angles += ( 0, 90, 0 );
            }
            else
            {
                loc.angles += ( 180, 180, 0 );
            }
            
            break;
        case #"hash_2354208d9af64220":
            if ( isdefined( loc.script_noteworthy ) && loc.script_noteworthy == "wall" || isdefined( loc.var_8d2bc841d9879d97 ) && loc.var_8d2bc841d9879d97 == "wall" )
            {
                loc.angles += ( 0, 180, 0 );
            }
            else
            {
                loc.angles += ( 0, 0, 90 );
            }
            
            break;
        case #"hash_4b4a6458f00d9319":
            if ( isdefined( loc.script_noteworthy ) && loc.script_noteworthy == "wall" || isdefined( loc.var_8d2bc841d9879d97 ) && loc.var_8d2bc841d9879d97 == "wall" )
            {
                loc.angles += ( 270, 270, 0 );
            }
            else
            {
                loc.angles += ( 0, 0, 90 );
            }
            
            break;
        case #"hash_9ba0a6ff6081954e":
            if ( isdefined( loc.script_noteworthy ) && loc.script_noteworthy == "wall" || isdefined( loc.var_8d2bc841d9879d97 ) && loc.var_8d2bc841d9879d97 == "wall" )
            {
                loc.angles += ( 0, 90, 0 );
            }
            
            break;
        case #"hash_8d9ae5e5dd390b4b":
            if ( isdefined( loc.script_noteworthy ) && loc.script_noteworthy == "wall" || isdefined( loc.var_8d2bc841d9879d97 ) && loc.var_8d2bc841d9879d97 == "wall" )
            {
                loc.angles += ( 0, 0, 90 );
            }
            else
            {
                loc.angles += ( 0, 0, 90 );
            }
            
            break;
        case #"hash_f85c7f2de2371beb":
            if ( isdefined( loc.script_noteworthy ) && loc.script_noteworthy == "wall" || isdefined( loc.var_8d2bc841d9879d97 ) && loc.var_8d2bc841d9879d97 == "wall" )
            {
                loc.angles += ( 0, -90, 0 );
            }
            else
            {
                loc.angles += ( -90, 0, 0 );
            }
            
            break;
        default:
            break;
    }
    
    return loc;
}

// Namespace arena
// Params 1, eflags: 0x4
// Checksum 0x7f3c31a4, Offset: 0xb75a
// Size: 0x6db
function private function_8b9f48ea2a56e60f( loc )
{
    assert( isdefined( loc ) );
    
    switch ( level.mapname )
    {
        case #"hash_564958ec86b5937":
            if ( loc.script_label == "1" )
            {
                if ( distance( loc.origin, ( -11, -889, 32 ) ) < 10 )
                {
                    loc.origin += ( 15, 0, 0 );
                }
                else if ( distance( loc.origin, ( 125, 1158, 49 ) ) < 10 )
                {
                    loc.origin += ( 7, 0, 0 );
                }
                else if ( distance( loc.origin, ( -181, 1159, 34 ) ) < 10 )
                {
                    loc.origin += ( 7, 0, 0 );
                }
                else if ( distance( loc.origin, ( 545, 379, 53 ) ) < 10 )
                {
                    loc.origin += ( 0, -0.5, 0 );
                }
            }
            else if ( loc.script_label == "2" )
            {
                if ( distance( loc.origin, ( -412, -618, 52 ) ) < 10 )
                {
                    loc.origin += ( -10, 0, 1 );
                }
            }
            else if ( loc.script_label == "6" && distance( loc.origin, ( -313.261, 486, 54.9829 ) ) < 10 )
            {
                loc.origin += ( 0, 0, -1 );
            }
            else if ( loc.script_label == "7" )
            {
                if ( distance( loc.origin, ( -47, -637, 48 ) ) < 10 )
                {
                    loc.angles += ( 0, 180, 0 );
                }
                else if ( distance( loc.origin, ( 112, -516, 63 ) ) < 10 )
                {
                    loc.angles += ( 0, 90, 0 );
                }
                else if ( distance( loc.origin, ( -89, -371, 56 ) ) < 10 )
                {
                    loc.origin += ( 0, 0, -1 );
                }
            }
            else if ( loc.script_label == "8" && distance( loc.origin, ( 328, -1078, 52 ) ) < 10 )
            {
                loc.angles += ( 0, 270, 0 );
            }
            
            break;
        case #"hash_61f7356a42e47c76":
            if ( loc.script_label == "6" )
            {
                if ( distance( loc.origin, ( -256, -1152, -62 ) ) < 10 )
                {
                    loc.origin += ( 0, 0, -2 );
                }
                else if ( distance( loc.origin, ( 128, 128, -62 ) ) < 10 )
                {
                    loc.origin += ( 0, 0, -2 );
                }
            }
            
            break;
        case #"hash_f7a3e0a896bc04b":
            if ( loc.script_label == "1" )
            {
                if ( distance( loc.origin, ( -72, -737, -141.5 ) ) < 10 )
                {
                    loc.origin += ( 10, 0, 1 );
                }
                else if ( distance( loc.origin, ( -49, -715, -141.5 ) ) < 10 )
                {
                    loc.origin += ( -15, -5, 1 );
                }
                else if ( distance( loc.origin, ( -894, 273, -141.5 ) ) < 10 )
                {
                    loc.origin += ( 15, -25, -1 );
                }
                else if ( distance( loc.origin, ( -911, 243, -141.5 ) ) < 10 )
                {
                    loc.origin += ( 30, -20, -1 );
                }
            }
            else if ( loc.script_label == "6" )
            {
                if ( distance( loc.origin, ( -223.5, -588, -145 ) ) < 10 )
                {
                    loc.origin += ( 0, 0, 2 );
                }
                else if ( distance( loc.origin, ( -606.5, 156, -145 ) ) < 10 )
                {
                    loc.origin += ( 3, -25, -1 );
                }
            }
            else if ( loc.script_label == "7" )
            {
                if ( distance( loc.origin, ( -229.5, 152, -145 ) ) < 10 )
                {
                    loc.origin += ( 0, -5, -1 );
                }
                else if ( distance( loc.origin, ( -740.5, -561, -147 ) ) < 10 )
                {
                    loc.origin += ( 0, 0, 1 );
                }
            }
            
            break;
        default:
            break;
    }
    
    return loc;
}

// Namespace arena
// Params 1
// Checksum 0x8fa389ba, Offset: 0xbe3e
// Size: 0x34
function getequipmenthinticon( weapon )
{
    table = "mp/arenaGGWeapons.csv";
    icon = tablelookup( table, 0, weapon, 3 );
    return icon;
}

// Namespace arena
// Params 2
// Checksum 0xb6aab4cd, Offset: 0xbe7b
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

// Namespace arena
// Params 0
// Checksum 0x409c6a06, Offset: 0xbf27
// Size: 0x151
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
    
    player gameplay_sound_fx::playlocalsoundfx( #"arena_equipment_pickup" );
    clearweaponoutlines();
    self makeunusable();
    self delete();
}

// Namespace arena
// Params 1
// Checksum 0x40f01e95, Offset: 0xc080
// Size: 0x1d
function checkpickupequiptypeammocount( player )
{
    return player equipment_mp::getequipmentammo( self.equipment );
}

// Namespace arena
// Params 1
// Checksum 0x27e48e13, Offset: 0xc0a6
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

// Namespace arena
// Params 1
// Checksum 0x22a2f025, Offset: 0xc0ec
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

// Namespace arena
// Params 1
// Checksum 0x6016b55f, Offset: 0xc135
// Size: 0x18
function dropoldequipinplace( equipment )
{
    spawnweapon( self, equipment, 1 );
}

// Namespace arena
// Params 0
// Checksum 0x840f3d84, Offset: 0xc155
// Size: 0x6e
function watchpickup()
{
    self endon( #"death" );
    self waittill( #"trigger", player, droppeditem );
    clearweaponoutlines();
    
    if ( isdefined( droppeditem ) )
    {
        droppeditem sethintdisplayrange( 96 );
        droppeditem setuserange( 96 );
        droppeditem setuseholdduration( "duration_short" );
        droppeditem thread outlinewatchplayerprox();
        droppeditem thread watchpickup();
    }
}

// Namespace arena
// Params 0
// Checksum 0xa243370f, Offset: 0xc1cb
// Size: 0x1f8
function itemproxtriggerthink()
{
    level endon( #"game_ended" );
    self endon( #"deleted" );
    self endon( #"death" );
    equipref = undefined;
    
    while ( true )
    {
        wait 0.05;
        self.proxtrigger waittill( #"trigger", player );
        
        if ( !player::isreallyalive( player ) )
        {
            continue;
        }
        
        if ( player.inlaststand )
        {
            continue;
        }
        
        if ( !isdefined( player.initialized_gameobject_vars ) )
        {
            continue;
        }
        
        if ( !gameobjects::proxtriggerlos( player ) )
        {
            continue;
        }
        
        equipref = player equipment_mp::getcurrentequipment( self.equiptype );
        hasmaxammo = 0;
        issameequip = checkissameequip( player );
        var_e6c9ee5a655526f3 = checkcurrentequiptypeammocount( player );
        equipref = player equipment_mp::getcurrentequipment( self.equiptype );
        
        if ( isdefined( equipref ) && !issameequip && var_e6c9ee5a655526f3 > 0 )
        {
            continue;
        }
        
        equipammo = checkpickupequiptypeammocount( player );
        var_a8a89389d81bf9a4 = player equipment_mp::getequipmentmaxammo( self.equipment );
        
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
        
        if ( issameequip && hasmaxammo )
        {
            continue;
        }
        
        if ( !isdefined( equipref ) || isdefined( equipref ) && !issameequip && var_e6c9ee5a655526f3 == 0 )
        {
            player equipment_mp::giveequipment( self.equipment, self.equiptype );
        }
        
        if ( level.snowballfight )
        {
            player gameplay_sound_fx::playlocalsoundfx( #"snowball_pickup" );
        }
        else
        {
            player gameplay_sound_fx::playlocalsoundfx( #"arena_equipment_pickup" );
        }
        
        clearweaponoutlines();
        self makeunusable();
        self delete();
    }
}

// Namespace arena
// Params 1
// Checksum 0x47abb98a, Offset: 0xc3cb
// Size: 0x2a
function updatearenagungameloadout( reversegg )
{
    if ( game[ "roundsPlayed" ] == 0 )
    {
        cachearenagungameloadouts( reversegg );
        game[ "arenaRandomLoadoutIndex" ] = 0;
    }
}

// Namespace arena
// Params 1
// Checksum 0xcf897580, Offset: 0xc3fd
// Size: 0x14a
function cachearenagungameloadouts( reversegg )
{
    loadouts = [];
    classtables = [];
    
    if ( level.gametypebundle.var_8ae861913d1c7284 )
    {
        classtables = function_5a85540822dd168a();
    }
    else
    {
        classtables = function_6220187e61c1d47();
    }
    
    foreach ( classtable in classtables )
    {
        foreach ( loadout in classtable.classlist )
        {
            loadouts[ loadouts.size ] = function_4ba1689208fa4c96( loadout );
        }
    }
    
    game[ "arenaRandomLoadout" ] = reversegg ? arrayreverse( loadouts ) : loadouts;
}

// Namespace arena
// Params 0
// Checksum 0x739646a, Offset: 0xc54f
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

// Namespace arena
// Params 1
// Checksum 0xa27e2ffb, Offset: 0xc760
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

// Namespace arena
// Params 2
// Checksum 0x75c3b6c0, Offset: 0xc7de
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

// Namespace arena
// Params 1
// Checksum 0xced07e25, Offset: 0xc895
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

// Namespace arena
// Params 0
// Checksum 0xe180b60d, Offset: 0xcb4e
// Size: 0x225
function spawngameendflagzone()
{
    arenaflag = getentarray( "flag_arena", #targetname );
    
    if ( !isdefined( arenaflag[ 0 ] ) && getdvarint( @"hash_2e5cbfbbbbae7cc", 0 ) )
    {
        arenaflag = function_42cccb77453cbbfa();
    }
    
    if ( !isdefined( arenaflag[ 0 ] ) )
    {
        assertmsg( "<dev string:x342>" );
        return;
    }
    
    level.arenaflag = arenaflag[ 0 ];
    trigger = arenaflag[ 0 ];
    trigger.objectivekey = "_a";
    trigger.iconname = "_a";
    arenaflag = obj_dom::setupobjective( trigger, "neutral", undefined, 1 );
    arenaflag.onuse = &arenaflag_onuse;
    arenaflag.onbeginuse = &arenaflag_onusebegin;
    arenaflag.onenduse = &arenaflag_onuseend;
    arenaflag.onuseupdate = &arenaflag_onuseupdate;
    arenaflag.oncontested = &arenaflag_oncontested;
    arenaflag.onuncontested = &arenaflag_onuncontested;
    arenaflag.isarena = 1;
    arenaflag gameobjects::pinobjiconontriggertouch();
    arenaflag.id = "domFlag";
    arenaflag.scriptable delete();
    arenaflag gameobjects::setcapturebehavior( "persistent" );
    arenaflag.ignorestomp = 1;
    level.objectives[ arenaflag.objectivekey ] = arenaflag;
    level.arenaflag = arenaflag;
    
    if ( arenaflag.flagmodel isscriptable() )
    {
        arenaflag.flagmodel setscriptablepartstate( "flag", "idle" );
    }
    
    waitframe();
    level.arenaflag gameobjects::requestid( 1, 1, undefined, 0, 0 );
    level.arenaflag.visibleteam = "any";
    level.arenaflag gameobjects::setobjectivestatusicons( "icon_waypoint_ot" );
    
    if ( !flags::gameflag( "prematch_done" ) )
    {
        level.arenaflag thread deleteotpreview();
        level thread showflagoutline();
        return;
    }
    
    disableotflag();
}

// Namespace arena
// Params 0
// Checksum 0x9b7559b5, Offset: 0xcd7b
// Size: 0xa3
function function_42cccb77453cbbfa()
{
    arenaflags = getentarray( "flag_primary", #targetname );
    
    foreach ( ent in arenaflags )
    {
        if ( ent.script_label == "_b" )
        {
            return [ ent ];
        }
    }
}

// Namespace arena
// Params 0
// Checksum 0xc35faba1, Offset: 0xce27
// Size: 0x63
function showflagoutline()
{
    waitframe();
    
    if ( isdefined( level.arenaflag.flagmodel ) )
    {
        level.arenaflag.flagmodel.outlinedid = outline::outlineenableforall( level.arenaflag.flagmodel, "hudoutline_gunfight_ot_flag", "level_script" );
    }
    
    level thread removeflagoutlineongameend();
}

// Namespace arena
// Params 1
// Checksum 0x4163096d, Offset: 0xce92
// Size: 0x74
function function_b907c5102bc35b1e( var_bac46cd9ef72db23 )
{
    if ( level.multimatch ?? gameinstance::is_enabled() )
    {
        return;
    }
    
    if ( level.gametypebundle.var_fe9c2aec69150509 )
    {
        setomnvar( "ui_match_timer_stopped", istrue( var_bac46cd9ef72db23 ) );
        var_8e53865a49dd5fd6 = var_bac46cd9ef72db23 ? gettime() + level.var_cfa9868bde941db1 : 0;
        setomnvar( "ui_overtime_flag_time", var_8e53865a49dd5fd6 );
    }
}

// Namespace arena
// Params 1
// Checksum 0x2a7680d2, Offset: 0xcf0e
// Size: 0x161
function arenaflag_onusebegin( player )
{
    player.iscapturing = 1;
    level.canprocessot = 0;
    ownerteam = gameobjects::getownerteam();
    function_b907c5102bc35b1e( 1 );
    
    if ( ownerteam == "neutral" )
    {
        if ( gameobjects::function_e17a356e69f57699( player ) )
        {
            player.owner setclientomnvar( "ui_objective_pinned_text_param", 1 );
        }
        else
        {
            player setclientomnvar( "ui_objective_pinned_text_param", 1 );
        }
    }
    
    self.neutralizing = level.flagneutralization && ownerteam != "neutral";
    self.playertouching = 1;
    
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

// Namespace arena
// Params 4
// Checksum 0x835016a9, Offset: 0xd077
// Size: 0x139
function arenaflag_onuseupdate( team, progress, change, capplayer )
{
    ownerteam = gameobjects::getownerteam();
    
    if ( progress > 0.05 && change && !self.didstatusnotify )
    {
        if ( ownerteam == "neutral" )
        {
            if ( level.flagcapturetime > 0.05 )
            {
                dialog::statusdialog( #"hash_931f49400c6822ca", team );
                otherteam = team_utility::getotherteam( team );
                dialog::statusdialog( #"hash_a9d7782d101676b2", otherteam );
            }
        }
        else if ( level.flagcapturetime > 0.05 )
        {
            dialog::statusdialog( #"hash_a9d7782d101676b2", ownerteam );
            dialog::statusdialog( #"hash_931f49400c6822ca", team );
        }
        
        self.didstatusnotify = 1;
    }
    
    if ( !self.stalemate && !self.capblocked && progress < 1 && !level.gameended && !game_utility_mp::isanymlgmatch() )
    {
        function_80dba07e9b128115( progress, team );
    }
}

// Namespace arena
// Params 3
// Checksum 0x22356068, Offset: 0xd1b8
// Size: 0xe4
function arenaflag_onuseend( team, player, success )
{
    level.canprocessot = 1;
    self.didstatusnotify = 0;
    function_b907c5102bc35b1e( 0 );
    
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

// Namespace arena
// Params 1
// Checksum 0x934cdb59, Offset: 0xd2a4
// Size: 0x1b3
function arenaflag_onuse( credit_player )
{
    level.canprocessot = 1;
    team = credit_player.team;
    oldteam = gameobjects::getownerteam();
    otherteam = team_utility::getotherteam( team );
    objidpoolmanager::objective_set_progress( self.objidnum, 0 );
    objidpoolmanager::objective_show_progress( self.objidnum, 0 );
    self.capturetime = gettime();
    self.neutralized = 0;
    dialog::statusdialog( #"hash_374b997e0afc0c5a", otherteam );
    dialog::statusdialog( #"hash_a8b07df3a5d608b9", team );
    gameplay_sound_fx::function_e319dc8e16c85fcb( #"arena_flag_captured", teams::getteamdata( team, "players" ) );
    gameplay_sound_fx::function_e319dc8e16c85fcb( #"hash_60ba4a1ebe112a5e", teams::getteamdata( otherteam, "players" ) );
    obj_dom::dompoint_setcaptured( team, credit_player );
    
    if ( !self.neutralized )
    {
        if ( isdefined( level.onobjectivecomplete ) )
        {
            [[ level.onobjectivecomplete ]]( "dompoint", self.objectivekey, credit_player, team, oldteam, self );
        }
        
        credit_player stats::setextrascore0( credit_player.pers[ "captures" ] );
        self.firstcapture = 0;
    }
    
    credit_player thread points::doscoreevent( #"gunfight_capture" );
    game[ "dialog" ][ "round_success" ] = "gamestate_win_capture";
    game[ "dialog" ][ "round_failure" ] = "gamestate_lost_capture";
    level thread arena_endgame( credit_player.team, game[ "end_reason" ][ "arena_otflag_completed" ], game[ "end_reason" ][ "arena_otflag_failed" ] );
}

// Namespace arena
// Params 0
// Checksum 0x6c9957f, Offset: 0xd45f
// Size: 0x70
function arenaflag_oncontested()
{
    gameobjects::setobjectivestatusicons( level.iconcontested );
    objidpoolmanager::objective_set_progress_team( self.objidnum, undefined );
    thread obj_dom::updateflagstate( "contested", 0 );
    level thread forcegameendcontesttimeout();
    level.arenaflag thread oncontested_playsoundatpos( level.arenaflag.flagmodel.origin, #"arena_zone_contested", 3 );
}

// Namespace arena
// Params 1
// Checksum 0x3e70bd21, Offset: 0xd4d7
// Size: 0x10f
function arenaflag_onuncontested( lastclaimteam )
{
    ownerteam = gameobjects::getownerteam();
    
    if ( ownerteam == "neutral" )
    {
        if ( lastclaimteam != "none" )
        {
            objidpoolmanager::objective_set_progress_team( self.objidnum, lastclaimteam );
        }
        else if ( isdefined( self.lastprogressteam ) )
        {
            objidpoolmanager::objective_set_progress_team( self.objidnum, self.lastprogressteam );
        }
    }
    else
    {
        objidpoolmanager::objective_set_progress_team( self.objidnum, team_utility::getotherteam( ownerteam ) );
    }
    
    if ( lastclaimteam == "none" || ownerteam == "neutral" )
    {
        gameobjects::setobjectivestatusicons( level.iconneutral );
        self.didstatusnotify = 0;
    }
    else
    {
        gameobjects::setobjectivestatusicons( level.icondefend, level.iconcapture );
    }
    
    level.arenaflag thread onuncontested_playsoundatpos( level.arenaflag.flagmodel.origin, #"hash_fecf3dcc49e3c000", 3 );
}

// Namespace arena
// Params 0
// Checksum 0x1e23d811, Offset: 0xd5ee
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

// Namespace arena
// Params 0
// Checksum 0x23a6f4a4, Offset: 0xd676
// Size: 0xce
function enableotflag()
{
    if ( !isdefined( level.arenaflag ) )
    {
        assertmsg( "<dev string:x362>" );
        return;
    }
    
    if ( !isdefined( level.arenaflag.objidnum ) )
    {
        level.arenaflag gameobjects::requestid( 1, 1, undefined, 0, 0 );
    }
    
    level.arenaflag gameobjects::setobjectivestatusicons( level.iconneutral );
    level.arenaflag gameobjects::enableobject();
    level.arenaflag gameobjects::allowuse( "enemy" );
    level.arenaflag.flagmodel show();
    level thread showflagoutline();
    level.arenaflag.flagmodel gameplay_sound_fx::function_760dbc73d1362ab9( #"arena_flag_spawned" );
}

// Namespace arena
// Params 0
// Checksum 0xfdb07027, Offset: 0xd74c
// Size: 0x8a
function disableotflag()
{
    if ( !isdefined( level.arenaflag ) )
    {
        assertmsg( "<dev string:x362>" );
        return;
    }
    
    level.arenaflag gameobjects::allowuse( "none" );
    level.arenaflag gameobjects::disableobject();
    
    if ( isdefined( level.arenaflag.scriptable ) )
    {
        level.arenaflag.scriptable delete();
    }
    
    level.arenaflag.flagmodel hide();
}

// Namespace arena
// Params 0
// Checksum 0x9f629d27, Offset: 0xd7de
// Size: 0x67
function removeflagoutlineongameend()
{
    level waittill( #"game_ended" );
    
    if ( isdefined( level.arenaflag.flagmodel.outlinedid ) )
    {
        outline::outlinedisable( level.arenaflag.flagmodel.outlinedid, level.arenaflag.flagmodel );
    }
}

// Namespace arena
// Params 0
// Checksum 0xed79fc43, Offset: 0xd84d
// Size: 0x15
function deleteotpreview()
{
    flags::gameflagwait( "prematch_done" );
    disableotflag();
}

// Namespace arena
// Params 0
// Checksum 0x11643706, Offset: 0xd86a
// Size: 0x141
function setupendzones()
{
    if ( level.mapname == "mp_shipment" )
    {
        level.attackerendzone = getentarray( "flag_goal_defender", #targetname );
        level.defenderendzone = getentarray( "flag_goal_attackers", #targetname );
    }
    else
    {
        level.attackerendzone = getentarray( "flag_goal_attacker", #targetname );
        level.defenderendzone = getentarray( "flag_goal_defender", #targetname );
    }
    
    level.attackerendzone = level.attackerendzone[ 0 ] createendzone( game[ "attackers" ] );
    level.defenderendzone = level.defenderendzone[ 0 ] createendzone( game[ "defenders" ] );
    level.arena.endzoneflags[ game[ "attackers" ] ] = level.attackerendzone;
    level.arena.endzoneflags[ game[ "defenders" ] ] = level.defenderendzone;
    level.objectives[ "_b" ] = level.attackerendzone;
    level.objectives[ "_c" ] = level.defenderendzone;
}

// Namespace arena
// Params 1
// Checksum 0xab5f63f, Offset: 0xd9b3
// Size: 0x49a
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
    
    if ( isdefined( self.objectivekey ) )
    {
        objectivekey = self.objectivekey;
    }
    else if ( self.targetname == "flag_goal_attacker" )
    {
        objectivekey = "_b";
    }
    else
    {
        objectivekey = "_c";
    }
    
    iconname = undefined;
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
    endzone.firstcapture = 1;
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

// Namespace arena
// Params 1
// Checksum 0xb4caa20d, Offset: 0xde56
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
        gameobjects::setobjectivestatusicons( level.iconlosingendzone, level.icontakingendzone );
    }
}

// Namespace arena
// Params 3
// Checksum 0x890869f3, Offset: 0xdf86
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

// Namespace arena
// Params 1
// Checksum 0x6227f9e2, Offset: 0xe02b
// Size: 0x12a
function endzone_onuse( credit_player )
{
    level.canprocessot = 1;
    team = credit_player.team;
    oldteam = gameobjects::getownerteam();
    otherteam = team_utility::getotherteam( team );
    objidpoolmanager::objective_set_progress( self.objidnum, 0 );
    objidpoolmanager::objective_show_progress( self.objidnum, 0 );
    self.capturetime = gettime();
    self.neutralized = 0;
    gameplay_sound_fx::function_e319dc8e16c85fcb( #"arena_flag_captured", teams::getteamdata( team, "players" ) );
    gameplay_sound_fx::function_e319dc8e16c85fcb( #"hash_60ba4a1ebe112a5e", teams::getteamdata( otherteam, "players" ) );
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

// Namespace arena
// Params 0
// Checksum 0x758a17d1, Offset: 0xe15d
// Size: 0x23
function endzone_oncontested()
{
    gameobjects::setobjectivestatusicons( level.iconcontestendzone );
    objidpoolmanager::objective_set_progress_team( self.objidnum, undefined );
}

// Namespace arena
// Params 1
// Checksum 0xdbf7530a, Offset: 0xe188
// Size: 0x42
function endzone_onuncontested( lastclaimteam )
{
    ownerteam = gameobjects::getownerteam();
    gameobjects::setobjectivestatusicons( level.icondefendendzone, level.iconcaptureendzone );
    self.processot = 1;
}

// Namespace arena
// Params 2
// Checksum 0x144cc79e, Offset: 0xe1d2
// Size: 0x15b
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
    credit_player stats::setextrascore0( credit_player.pers[ "extrascore0" ] + 1 );
    
    if ( isdefined( level.matchrecording_logevent ) )
    {
        [[ level.matchrecording_logevent ]]( self.logid, undefined, self.logeventflag, self.visuals[ 0 ].origin[ 0 ], self.visuals[ 0 ].origin[ 1 ], gettime(), team == "allies" ? 1 : 2 );
    }
    
    analyticslog::logevent_gameobject( self.analyticslogtype, self.analyticslogid, self.visuals[ 0 ].origin, -1, "captured_" + team );
}

// Namespace arena
// Params 1
// Checksum 0x4bafca7, Offset: 0xe335
// Size: 0x27
function endzone_stompprogressreward( player )
{
    player thread rank::function_d2aa8986c506e985( #"defend" );
    player events::function_a7d373228760063b();
}

// Namespace arena
// Params 0
// Checksum 0x66e6a0f1, Offset: 0xe364
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

// Namespace arena
// Params 2
// Checksum 0x11539f14, Offset: 0xe3b1
// Size: 0x265
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
            
            assert( isint( 1 ) || isfloat( 1 ), "<dev string:x37f>" );
            
            if ( isdefined( player.pers[ "captures" ] ) )
            {
                player.pers[ "captures" ] = player.pers[ "captures" ] + 1;
            }
        }
        
        player persistence::statsetchild( "round", "captures", player.pers[ "captures" ] );
        player thread rank::function_d2aa8986c506e985( #"capture" );
        player thread points::doscoreevent( #"mode_dom_secure" );
        player thread smoke_grenade::function_99543ad5d551cdb5();
        wait 0.05;
    }
}

// Namespace arena
// Params 0
// Checksum 0x38123d1e, Offset: 0xe61e
// Size: 0x32a
function startotmechanics()
{
    level.canprocessot = 1;
    
    if ( level.overtimeflag > 0 && !function_46ca224400b02341() )
    {
        game[ "dialog" ][ "overtime" ] = "gamestate_overtime_flagspawn";
    }
    
    if ( isdefined( level.gametypebundle.var_ae100eea97c7fcc7[ #"hash_14bb716c4b77c45a" ] ) )
    {
        if ( function_155840b442af403f() )
        {
            foreach ( objective in level.arena.endzoneflags )
            {
                gameobjects_shared::deactivate( objective );
            }
        }
        
        if ( level.arena.overtime_flags )
        {
            foreach ( overtime_flag in level.arena.overtime_flags )
            {
                gameobjects_shared::activate( overtime_flag );
                thread shouldplayerovertimedialog( overtime_flag );
            }
        }
    }
    else
    {
        if ( function_155840b442af403f() )
        {
            foreach ( objective in level.objectives )
            {
                if ( objective.objectivekey != "_a" )
                {
                    objective deleteendzone();
                }
            }
        }
        
        if ( isdefined( level.arenaflag ) )
        {
            enableotflag();
        }
        
        level thread shouldplayerovertimedialog( level.arenaflag );
    }
    
    codcaster_utils::function_3038b6eafc46c037( 10, "free" );
    
    if ( level.snowballfight )
    {
        foreach ( player in level.players )
        {
            if ( isalive( player ) )
            {
                equipment = player equipment_mp::getcurrentequipment( "primary" );
                
                if ( equipment == "equip_snowball" )
                {
                    player equipment_mp::incrementequipmentammo( "equip_snowball", 10 );
                    continue;
                }
                
                if ( !isdefined( equipment ) )
                {
                    player equipment_mp::giveequipment( "equip_snowball", "primary" );
                    player equipment_mp::incrementequipmentammo( "equip_snowball", 10 );
                }
            }
        }
    }
}

// Namespace arena
// Params 1
// Checksum 0x9025a14e, Offset: 0xe950
// Size: 0xeb
function shouldplayerovertimedialog( overtime_flag )
{
    if ( gameobjects_shared::is_in_use( overtime_flag ) )
    {
        return;
    }
    
    instance_id = gameobjects_common::get_instance_id( overtime_flag );
    
    foreach ( player in game_utility_mp::function_4b15b7eb1dc364e7( instance_id ) )
    {
        if ( player issplitscreenplayer() && !player issplitscreenplayerprimary() )
        {
            continue;
        }
        
        if ( level.gametypebundle.namekey == "arena_melee" )
        {
            player dialog::leaderdialogonplayer( "overtime_melee" );
            continue;
        }
        
        player dialog::leaderdialogonplayer( "overtime" );
    }
}

// Namespace arena
// Params 0
// Checksum 0x29b3b98b, Offset: 0xea43
// Size: 0x7a
function deleteendzone()
{
    self notify( #"monitor_flag_control" );
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

// Namespace arena
// Params 0
// Checksum 0x883f4194, Offset: 0xeac5
// Size: 0x95
function function_67e32f0a4915fe73()
{
    level.var_58ca4c57804f591b = "neutral";
    level.flagmodel[ "allies" ] = "ctf_game_flag_west";
    level.flagbase[ "allies" ] = "ctf_game_flag_base";
    level.carryflag[ "allies" ] = "prop_ctf_game_flag_west";
    level.flagmodel[ "axis" ] = "ctf_game_flag_east";
    level.flagbase[ "axis" ] = "ctf_game_flag_base";
    level.carryflag[ "axis" ] = "prop_ctf_game_flag_east";
    createflagstart();
}

// Namespace arena
// Params 0
// Checksum 0xea098751, Offset: 0xeb62
// Size: 0xab
function createflagstart()
{
    level.carryflag_starts = arrayrandomize( level.carryflag_starts );
    tracestart = level.carryflag_starts[ 0 ] + ( 0, 0, 64 );
    traceend = level.carryflag_starts[ 0 ] + ( 0, 0, -64 );
    trace = trace::ray_trace( tracestart, traceend, undefined, trace::create_default_contents( 1 ) );
    level.carryflag_starts[ 0 ] = trace[ "position" ];
    level.var_9eb82d89b62a76fa = function_fca3214cffef874a( "allies" );
    level thread flaglockedtimer();
}

// Namespace arena
// Params 0
// Checksum 0xb8322883, Offset: 0xec15
// Size: 0x173
function flaglockedtimer()
{
    if ( !flags::gameflag( "prematch_done" ) )
    {
        level.var_82aad3725f4dd637.objectiveicon gameobjects::setvisibleteam( "none" );
        level utility::waittill_any( "prematch_done", "start_mode_setup" );
        level.var_82aad3725f4dd637.objectiveicon gameobjects::setvisibleteam( "any" );
    }
    
    if ( level.flagactivationdelay )
    {
        flags::gameflagwait( "prematch_done" );
        level.var_82aad3725f4dd637.objectiveicon thread gameobjects::function_d7321ef757ecefd7( level.flagactivationdelay );
        wait level.flagactivationdelay;
        level.var_82aad3725f4dd637.objectiveicon gameobjects::setobjectivestatusallicons( level.iconcaptureflag, level.iconcaptureflag, level.mlgiconfullflag );
        level.var_9eb82d89b62a76fa.trigger utility::trigger_on();
        
        foreach ( team in level.teamnamelist )
        {
            dialog::leaderdialog( "obj_generic_capture", team );
        }
    }
}

// Namespace arena
// Params 1
// Checksum 0x49d12053, Offset: 0xed90
// Size: 0x483
function function_fca3214cffef874a( team )
{
    level.pickuptime = 0;
    level.returntime = 0;
    radius = 32;
    trigger = spawn( "trigger_radius", level.carryflag_starts[ 0 ], 0, radius, 128 );
    visuals = [];
    visuals[ 0 ] = spawn( "script_model", level.carryflag_starts[ 0 ] );
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
    teamflag.firstpickup = 1;
    teamflag.onpickup = &onpickup;
    teamflag.onpickupfailed = &onpickup;
    teamflag.ondrop = &ondrop;
    teamflag.onreset = &onreset;
    teamflag.objectivekey = "carry_flag";
    level.objectives[ teamflag.objectivekey ] = teamflag;
    
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
    
    level.var_82aad3725f4dd637 = function_288e400c77cf12c6( team, teamflag );
    return teamflag;
}

// Namespace arena
// Params 2
// Checksum 0x2063728e, Offset: 0xf21c
// Size: 0x143
function function_288e400c77cf12c6( team, teamflag )
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

// Namespace arena
// Params 1
// Checksum 0xee2a73f0, Offset: 0xf368
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

// Namespace arena
// Params 1
// Checksum 0xbc46a98b, Offset: 0xf3af
// Size: 0x15, Type: bool
function flagpickupchecks( player )
{
    return !player vehicle::is_in_vehicle();
}

// Namespace arena
// Params 3
// Checksum 0xf8d0f55a, Offset: 0xf3cd
// Size: 0x427
function onpickup( player, playervo, defused )
{
    self notify( #"picked_up" );
    player notify( #"obj_picked_up" );
    level.var_82aad3725f4dd637.objectiveicon gameobjects::setvisibleteam( "none" );
    level.var_9eb82d89b62a76fa.currentcarrier = player;
    player thread awardobjtimeforcarrier();
    ownerteam = gameobjects::getownerteam();
    gameobjects::setownerteam( player.team );
    team = player.pers[ "team" ];
    level.var_58ca4c57804f591b = team;
    
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
        
        assert( isint( 1 ) || isfloat( 1 ), "<dev string:x37f>" );
        
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
    gameplay_sound_fx::function_e319dc8e16c85fcb( #"hash_871eee86e8c71bd6", teams::getteamdata( team, "players" ) );
    gameplay_sound_fx::function_e319dc8e16c85fcb( #"hash_3acd69035d5d6789", teams::getteamdata( otherteam, "players" ) );
    
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
    
    if ( level.flagholdtimer > 0 )
    {
        thread function_ab8ce9ad38ec2979( team );
    }
}

// Namespace arena
// Params 0
// Checksum 0x2d3f88b3, Offset: 0xf7fc
// Size: 0x9
function returnflag()
{
    gameobjects::returnhome();
}

// Namespace arena
// Params 1
// Checksum 0xcf9647a2, Offset: 0xf80d
// Size: 0x2c6
function ondrop( player )
{
    self notify( #"dropped" );
    player notify( #"obj_dropped" );
    
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
    
    level.var_9eb82d89b62a76fa.currentcarrier = undefined;
    level.var_58ca4c57804f591b = "neutral";
    
    if ( isdefined( player ) )
    {
        player updatematchstatushintonnoflag();
    }
    
    gameobjects::setownerteam( "neutral" );
    team = self.droppedteam;
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
        
        if ( level.codcasterenabled )
        {
            player setgametypevip( 0 );
        }
    }
    
    gameplay_sound_fx::function_e319dc8e16c85fcb( #"hash_f811939a6bb36815", teams::getteamdata( otherteam, "players" ) );
    
    if ( !level.gameended )
    {
        dialog::leaderdialog( #"enemy_flag_dropped", team_utility::getotherteam( self.droppedteam ), "status" );
        dialog::leaderdialog( #"flag_dropped", self.droppedteam, "status" );
    }
    
    if ( level.idleresettime > 0 )
    {
        thread returnaftertime();
    }
    
    if ( level.flagholdtimer > 0 )
    {
        setomnvar( "ui_obj_timer_stopped", 1 );
        setomnvar( "ui_obj_timer", 0 );
        setomnvar( "ui_obj_progress", 0 );
    }
}

// Namespace arena
// Params 0
// Checksum 0xd46af786, Offset: 0xfadb
// Size: 0x72
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
    
    gameplay_sound_fx::function_e319dc8e16c85fcb( #"hash_f811939a6bb36815", level.players );
    gameobjects::returnhome();
}

// Namespace arena
// Params 0
// Checksum 0x674742d0, Offset: 0xfb55
// Size: 0x175
function onreset()
{
    level.var_9eb82d89b62a76fa.currentcarrier = undefined;
    
    if ( isdefined( level.var_9eb82d89b62a76fa.portable_radar ) )
    {
        level.var_9eb82d89b62a76fa.portable_radar clearportableradar();
        level.var_9eb82d89b62a76fa.portable_radar delete();
    }
    
    if ( isdefined( self.droppedteam ) )
    {
        gameobjects::setownerteam( self.droppedteam );
    }
    
    team = gameobjects::getownerteam();
    otherteam = team_utility::getotherteam( team );
    gameobjects::allowcarry( "any" );
    gameobjects::setvisibleteam( "none" );
    gameobjects::setobjectivestatusicons( level.iconescort, level.iconkill );
    level.var_82aad3725f4dd637.objectiveicon gameobjects::setvisibleteam( "any" );
    
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

// Namespace arena
// Params 0
// Checksum 0xa5e43c6f, Offset: 0xfcd2
// Size: 0x58
function attachflag()
{
    updatematchstatushintonhasflag();
    otherteam = team_utility::getotherteam( self.pers[ "team" ] );
    self attach( level.carryflag[ otherteam ], "tag_stowed_back3", 1 );
    self.carryflag = level.carryflag[ otherteam ];
}

// Namespace arena
// Params 0
// Checksum 0xc0e7c013, Offset: 0xfd32
// Size: 0x20
function detachflag()
{
    self detach( self.carryflag, "tag_stowed_back3" );
    self.carryflag = undefined;
}

// Namespace arena
// Params 0
// Checksum 0xcb30b135, Offset: 0xfd5a
// Size: 0x12
function updatematchstatushintonnoflag()
{
    hud_message::function_ef4318a0090caa0f( #"single_flag_cap" );
}

// Namespace arena
// Params 0
// Checksum 0xe5846598, Offset: 0xfd74
// Size: 0x12
function updatematchstatushintonhasflag()
{
    hud_message::function_ef4318a0090caa0f( #"single_flag_cap" );
}

// Namespace arena
// Params 1
// Checksum 0x544d1e68, Offset: 0xfd8e
// Size: 0x1d0
function awardobjtimeforcarrier( team )
{
    level endon( #"game_ended" );
    level.var_9eb82d89b62a76fa endon( #"dropped" );
    level.var_9eb82d89b62a76fa endon( #"reset" );
    level notify( #"hash_3dd8bdadd0b92d2f" );
    level endon( #"hash_3dd8bdadd0b92d2f" );
    
    while ( !level.gameended )
    {
        wait 1;
        hostmigration::waittillhostmigrationdone();
        
        if ( !level.gameended )
        {
            flagcarrier = level.var_9eb82d89b62a76fa.carrier;
            
            if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( flagcarrier ) ) )
            {
                if ( isdefined( flagcarrier.leaderboarddata[ "objTime" ] ) )
                {
                    flagcarrier.leaderboarddata[ "objTime" ] = flagcarrier.leaderboarddata[ "objTime" ] + 1;
                }
                
                if ( isdefined( level.leaderboardfunc[ "objTime" ] ) )
                {
                    [[ level.leaderboardfunc[ "objTime" ] ]]( flagcarrier, 1 );
                }
                
                assert( isint( 1 ) || isfloat( 1 ), "<dev string:x37f>" );
                
                if ( isdefined( flagcarrier.pers[ "objTime" ] ) )
                {
                    flagcarrier.pers[ "objTime" ] = flagcarrier.pers[ "objTime" ] + 1;
                }
            }
            
            flagcarrier persistence::statsetchild( "round", "objTime", flagcarrier.pers[ "objTime" ] );
            flagcarrier stats::setextrascore2( flagcarrier.pers[ "objTime" ] );
            flagcarrier gamescore::giveplayerscore( #"hash_98bfd8d29c56bc08", 10 );
        }
    }
}

// Namespace arena
// Params 1
// Checksum 0x47af1eb, Offset: 0xff66
// Size: 0x7c
function function_ab8ce9ad38ec2979( team )
{
    flagholdtimer = int( gettime() + level.flagholdtimer * 1000 );
    setomnvar( "ui_obj_timer", flagholdtimer );
    setomnvar( "ui_obj_progress", 1 );
    setomnvar( "ui_objective_timer_stopped", 0 );
    level thread hud_message::notifyteam( "flag_force_hold_fr", "flag_force_hold_en", team );
    thread function_3e4b4452849903f2( level.flagholdtimer );
    thread function_8e15013a54c45cbb();
}

// Namespace arena
// Params 1
// Checksum 0x1751845d, Offset: 0xffea
// Size: 0x64
function function_3e4b4452849903f2( flagholdtimer )
{
    level.var_9eb82d89b62a76fa endon( #"dropped" );
    currentprogress = flagholdtimer;
    
    while ( !level.gameended )
    {
        setomnvar( "ui_obj_progress", currentprogress / flagholdtimer );
        currentprogress -= level.framedurationseconds;
        wait level.framedurationseconds;
    }
}

// Namespace arena
// Params 0
// Checksum 0x7217365e, Offset: 0x10056
// Size: 0x7b
function function_8e15013a54c45cbb()
{
    level endon( #"game_ended" );
    self endon( #"dropped" );
    hostmigration::waitlongdurationwithgameendtimeupdate( level.flagholdtimer );
    self notify( #"hold_timer_elapsed" );
    self.currentcarrier notify( #"obj_hold_timer_elapsed" );
    level thread gamelogic_mp::endgame( level.var_9eb82d89b62a76fa gameobjects::getownerteam(), game[ "end_reason" ][ "ko_flag_hold_win" ], game[ "end_reason" ][ "ko_flag_hold_loss" ] );
}

// Namespace arena
// Params 1
// Checksum 0x54f6ad, Offset: 0x100d9
// Size: 0x30
function dogtagallyonusecb( player )
{
    player.health = player.maxhealth;
    player notify( #"healed" );
}

// Namespace arena
// Params 1
// Checksum 0x99b1254b, Offset: 0x10111
// Size: 0x30
function dogtagenemyonusecb( player )
{
    player.health = player.maxhealth;
    player notify( #"healed" );
}

// Namespace arena
// Params 0
// Checksum 0xcce5536e, Offset: 0x10149
// Size: 0x1dc
function outlineenemyplayers()
{
    level endon( #"prematch_done" );
    level endon( #"removeArenaOutlines" );
    
    while ( true )
    {
        level waittill( #"player_joined_team", var_f02ce0c042e284d4 );
        waitframe();
        instance_players = game_utility_mp::function_4b15b7eb1dc364e7( var_f02ce0c042e284d4.instanceid );
        
        foreach ( player in instance_players )
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
            
            foreach ( p in instance_players )
            {
                if ( p != player && p.team != player.team )
                {
                    if ( isdefined( player.outlinedenemies ) )
                    {
                        outline::outlinedisable( player.outlinedenemies, player );
                    }
                    
                    player.outlinedenemies = outline::outlineenableforteam( player, p.team, "hudoutline_gunfight_players", "level_script" );
                    break;
                }
            }
        }
    }
}

// Namespace arena
// Params 0
// Checksum 0xe85a631a, Offset: 0x1032d
// Size: 0xcd
function removeenemyoutlines()
{
    thread notifyremoveoutlines();
    flags::gameflagwait( "prematch_done" );
    
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

// Namespace arena
// Params 0
// Checksum 0x9798969f, Offset: 0x10402
// Size: 0xdd
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
    level.var_1167332792c1a743 = gettime();
    axisplayers = teams::getteamdata( "axis", "players" );
    alliesplayers = teams::getteamdata( "allies", "players" );
    level.var_3b46ffe37c501c23[ "axis" ] = axisplayers.size;
    level.var_3b46ffe37c501c23[ "allies" ] = alliesplayers.size;
    level notify( #"removeArenaOutlines" );
}

// Namespace arena
// Params 1
// Checksum 0x334a9093, Offset: 0x104e7
// Size: 0x1ac
function outlineequipmentwatchplayerprox( equipname )
{
    self endon( #"death" );
    self endon( #"trigger" );
    self.outlinedplayers = [];
    basescore = level.baseraritymap[ equipname ];
    outlineasset = getoutlineasset( basescore, equipname );
    
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

// Namespace arena
// Params 0
// Checksum 0xa55aad2f, Offset: 0x1069b
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

// Namespace arena
// Params 2
// Checksum 0xa421c947, Offset: 0x10863
// Size: 0x13c
function getoutlineasset( basescore = 0, equipname )
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
    
    if ( level.snowballfight && isdefined( equipname ) && equipname == "equip_pball" )
    {
        outlineasset = "outline_depth_yellow";
    }
    
    return outlineasset;
}

// Namespace arena
// Params 0
// Checksum 0xa51606a4, Offset: 0x109a8
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

// Namespace arena
// Params 0
// Checksum 0x5eb74231, Offset: 0x10a39
// Size: 0x1e
function updatematchstatushintonspawn()
{
    level endon( #"game_ended" );
    hud_message::function_ef4318a0090caa0f( #"kill" );
}

// Namespace arena
// Params 0
// Checksum 0xe4e2cd4d, Offset: 0x10a5f
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

// Namespace arena
// Params 0
// Checksum 0xd1d3f278, Offset: 0x10b81
// Size: 0x335
function setupwaypointicons()
{
    gamelogic_mp::setwaypointiconinfo( "waypoint_taking_endzone", 0, "friendly", "MP_INGAME_ONLY/OBJ_TAKING_CAPS", "icon_waypoint_flag", 0 );
    gamelogic_mp::setwaypointiconinfo( "waypoint_losing_endzone", 0, "enemy", "MP_INGAME_ONLY/OBJ_LOSING_CAPS", "icon_waypoint_flag", 0 );
    gamelogic_mp::setwaypointiconinfo( "waypoint_contesting_endzone", 0, "contest", "MP_INGAME_ONLY/OBJ_CONTESTED_CAPS", "icon_waypoint_flag", 0 );
    gamelogic_mp::setwaypointiconinfo( "waypoint_capture_endzone", 0, "enemy", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_flag", 0 );
    gamelogic_mp::setwaypointiconinfo( "waypoint_defend_endzone", 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_flag", 0 );
    gamelogic_mp::setwaypointiconinfo( "icon_waypoint_dom_a", 0, "friendly", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_overtime", 0 );
    gamelogic_mp::setwaypointiconinfo( "waypoint_taking_a", 0, "neutral", "MP_INGAME_ONLY/OBJ_TAKING_CAPS", "icon_waypoint_overtime", 1 );
    gamelogic_mp::setwaypointiconinfo( "waypoint_capture_a", 0, "enemy", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_overtime", 0 );
    gamelogic_mp::setwaypointiconinfo( "waypoint_defend_a", 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_overtime", 0 );
    gamelogic_mp::setwaypointiconinfo( "waypoint_defending_a", 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFENDING_CAPS", "icon_waypoint_overtime", 0 );
    gamelogic_mp::setwaypointiconinfo( "waypoint_blocking_a", 0, "friendly", "MP_INGAME_ONLY/OBJ_BLOCKING_CAPS", "icon_waypoint_overtime", 0 );
    gamelogic_mp::setwaypointiconinfo( "waypoint_blocked_a", 0, "friendly", "MP_INGAME_ONLY/OBJ_BLOCKED_CAPS", "icon_waypoint_overtime", 0 );
    gamelogic_mp::setwaypointiconinfo( "waypoint_losing_a", 0, "neutral", "MP_INGAME_ONLY/OBJ_LOSING_CAPS", "icon_waypoint_overtime", 1 );
    gamelogic_mp::setwaypointiconinfo( "waypoint_captureneutral_a", 0, "neutral", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_overtime", 0 );
    gamelogic_mp::setwaypointiconinfo( "waypoint_contested_a", 0, "contest", "MP_INGAME_ONLY/OBJ_CONTESTED_CAPS", "icon_waypoint_overtime", 1 );
    gamelogic_mp::setwaypointiconinfo( "waypoint_dom_target_a", 0, "neutral", "MP_INGAME_ONLY/OBJ_TARGET_CAPS", "icon_waypoint_overtime", 0 );
    gamelogic_mp::setwaypointiconinfo( "icon_waypoint_target_a", 0, "neutral", "MP_INGAME_ONLY/OBJ_TARGET_CAPS", "icon_waypoint_overtime", 0 );
    gamelogic_mp::setwaypointiconinfo( "icon_waypoint_ot_a", 0, "neutral", "MP_INGAME_ONLY/OBJ_OTFLAGLOC_CAPS", "icon_waypoint_overtime", 0 );
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

// Namespace arena
// Params 0
// Checksum 0x38d2e90c, Offset: 0x10ebe
// Size: 0xe, Type: bool
function isnormalloadouts()
{
    return level.arenaloadouts == 1;
}

// Namespace arena
// Params 0
// Checksum 0x103a10b9, Offset: 0x10ed5
// Size: 0x72, Type: bool
function israndomloadouts()
{
    return level.arenaloadouts == 2 || israndomarloadouts() || israndomsmgloadouts() || israndompistolloadouts() || israndomshotgunloadouts() || israndomsniperloadouts() || israndomlmgloadouts() || israndomblueprintsloadouts() || israndomcustomblueprintsloadouts() || israndomnoattachmentloadouts() || function_ad8b8fa721fa6c8c();
}

// Namespace arena
// Params 0
// Checksum 0x79f23025, Offset: 0x10f50
// Size: 0x1e, Type: bool
function ispickuploadouts()
{
    return level.arenaloadouts == 3 || level.arenaloadouts == 14;
}

// Namespace arena
// Params 0
// Checksum 0x52ede3e8, Offset: 0x10f77
// Size: 0xe, Type: bool
function isgungameloadouts()
{
    return level.arenaloadouts == 4;
}

// Namespace arena
// Params 0
// Checksum 0xe142177b, Offset: 0x10f8e
// Size: 0xe, Type: bool
function isrvsgungameloadouts()
{
    return level.arenaloadouts == 5;
}

// Namespace arena
// Params 0
// Checksum 0xcd075b21, Offset: 0x10fa5
// Size: 0xe, Type: bool
function israndomarloadouts()
{
    return level.arenaloadouts == 7;
}

// Namespace arena
// Params 0
// Checksum 0x83127442, Offset: 0x10fbc
// Size: 0xe, Type: bool
function israndomsmgloadouts()
{
    return level.arenaloadouts == 8;
}

// Namespace arena
// Params 0
// Checksum 0x39270bed, Offset: 0x10fd3
// Size: 0xe, Type: bool
function israndompistolloadouts()
{
    return level.arenaloadouts == 9;
}

// Namespace arena
// Params 0
// Checksum 0x3b56bb52, Offset: 0x10fea
// Size: 0xe, Type: bool
function israndomshotgunloadouts()
{
    return level.arenaloadouts == 10;
}

// Namespace arena
// Params 0
// Checksum 0x1de35759, Offset: 0x11001
// Size: 0xe, Type: bool
function israndomsniperloadouts()
{
    return level.arenaloadouts == 11;
}

// Namespace arena
// Params 0
// Checksum 0xbe1c444b, Offset: 0x11018
// Size: 0xe, Type: bool
function israndomlmgloadouts()
{
    return level.arenaloadouts == 12;
}

// Namespace arena
// Params 0
// Checksum 0xb4d1242c, Offset: 0x1102f
// Size: 0xe, Type: bool
function israndomblueprintsloadouts()
{
    return level.arenaloadouts == 13;
}

// Namespace arena
// Params 0
// Checksum 0xb40df927, Offset: 0x11046
// Size: 0xe, Type: bool
function ispickupblueprintloadouts()
{
    return level.arenaloadouts == 14;
}

// Namespace arena
// Params 0
// Checksum 0x9a2edac0, Offset: 0x1105d
// Size: 0xe, Type: bool
function israndomcustomblueprintsloadouts()
{
    return level.arenaloadouts == 15;
}

// Namespace arena
// Params 0
// Checksum 0xad9140f6, Offset: 0x11074
// Size: 0xe, Type: bool
function israndomnoattachmentloadouts()
{
    return level.arenaloadouts == 16;
}

// Namespace arena
// Params 0
// Checksum 0x510ff4cf, Offset: 0x1108b
// Size: 0xe, Type: bool
function function_ad8b8fa721fa6c8c()
{
    return level.arenaloadouts == 17;
}

// Namespace arena
// Params 0
// Checksum 0x97c09bf8, Offset: 0x110a2
// Size: 0x1c, Type: bool
function function_7edf0599605cd8ec()
{
    return israndomblueprintsloadouts() || ispickupblueprintloadouts() || israndomcustomblueprintsloadouts();
}

// Namespace arena
// Params 0
// Checksum 0x7cc266c2, Offset: 0x110c7
// Size: 0xd, Type: bool
function function_f4bb6d2c7bf0d49b()
{
    return level.objmodifier == 0;
}

// Namespace arena
// Params 0
// Checksum 0x6fa82acb, Offset: 0x110dd
// Size: 0xe, Type: bool
function function_155840b442af403f()
{
    return level.objmodifier == 1;
}

// Namespace arena
// Params 0
// Checksum 0x94aa249c, Offset: 0x110f4
// Size: 0xe, Type: bool
function function_46ca224400b02341()
{
    return level.objmodifier == 2;
}

// Namespace arena
// Params 0
// Checksum 0xae120f6c, Offset: 0x1110b
// Size: 0x38
function snowballfight()
{
    if ( game[ "practiceRound" ] || level.alwayssnowfight )
    {
        level.lethaldelay = 0;
        defineplayerloadout();
    }
    
    initweaponmap();
    thread setupsnowballs();
}

// Namespace arena
// Params 0
// Checksum 0x3061e1f9, Offset: 0x1114b
// Size: 0x336
function setupsnowballs()
{
    level.arenaweapont1.weapon = "equip_snowball";
    
    if ( !level.alwayssnowfight && !game[ "practiceRound" ] )
    {
        level.arenaweapont1.weapon = utility::cointoss() ? level.arenaweapont1.weapon : "equip_snowball";
        level.arenaweapont2.weapon = utility::cointoss() ? level.arenaweapont2.weapon : "equip_snowball";
        level.arenaweapont3.weapon = utility::cointoss() ? level.arenaweapont3.weapon : "equip_snowball";
        level.arenaweapont4.weapon = utility::cointoss() ? level.arenaweapont4.weapon : "equip_snowball";
        level.arenaweapont5.weapon = utility::cointoss() ? level.arenaweapont5.weapon : "equip_snowball";
        level.arenaweapont6.weapon = utility::cointoss() ? level.arenaweapont6.weapon : "equip_snowball";
        level.arenaweapont7.weapon = utility::cointoss() ? level.arenaweapont7.weapon : "equip_snowball";
        level.arenaweapont8.weapon = utility::cointoss() ? level.arenaweapont8.weapon : "equip_snowball";
    }
    
    level.pickedpball = 0;
    
    if ( !getdvarint( @"scr_snowball_pile_enabled", 0 ) )
    {
        locs = utility::getstructarray( "weapon_pickup", "targetname" );
        assert( locs.size > 0, "<dev string:x2c5>" );
        
        if ( isdefined( level.var_b58f39dc2c39694f ) )
        {
            level.var_b58f39dc2c39694f.script_label = "6";
            spawnweapon( level.var_b58f39dc2c39694f, level.arenaweapont1 );
            locs = arrayremove( locs, level.var_b58f39dc2c39694f );
        }
        
        foreach ( loc in locs )
        {
            if ( loc.script_label == "snowball" || game[ "practiceRound" ] || level.arenaloadouts != 3 )
            {
                spawnweapon( loc, level.arenaweapont1 );
            }
        }
    }
}

// Namespace arena
// Params 2
// Checksum 0x3073cbea, Offset: 0x11489
// Size: 0x271
function watchsnowballpickup( loc, snowtype )
{
    self endon( #"death" );
    self waittill( #"trigger", player, droppeditem );
    hasmaxammo = 0;
    issameequip = checkissameequip( player );
    equipammo = checkpickupequiptypeammocount( player );
    
    if ( self.equipment == "equip_snowball" )
    {
        var_a8a89389d81bf9a4 = 9;
    }
    else
    {
        var_a8a89389d81bf9a4 = 1;
    }
    
    var_e6c9ee5a655526f3 = checkcurrentequiptypeammocount( player );
    snowammo = 1;
    
    switch ( snowtype )
    {
        case #"hash_8c759484936e9b6d":
            snowammo = 10;
            break;
        case #"hash_b8a39a6acfe440c7":
            snowammo = 5;
            break;
        case #"hash_66c094dee1aed032":
            snowammo = 1;
            break;
        default:
            snowammo = 1;
            break;
    }
    
    if ( issameequip )
    {
        if ( equipammo == var_a8a89389d81bf9a4 )
        {
            hasmaxammo = 1;
        }
    }
    
    if ( issameequip && !hasmaxammo )
    {
        player equipment_mp::incrementequipmentammo( self.equipment, snowammo );
    }
    else if ( var_e6c9ee5a655526f3 && !issameequip && !isplayer( loc ) )
    {
        player dropoldequipinplace( player equipment_mp::getcurrentequipment( self.equiptype ) );
    }
    
    if ( !issameequip )
    {
        player equipment_mp::giveequipment( self.equipment, self.equiptype );
        
        if ( self.equipment == "equip_snowball" && !hasmaxammo )
        {
            player equipment_mp::incrementequipmentammo( self.equipment, snowammo );
        }
        else if ( self.equipment == "equip_pball" )
        {
            player equipment_mp::setequipmentammo( self.equipment, snowammo );
        }
    }
    
    if ( issameequip && hasmaxammo )
    {
        player iprintlnbold( &"mp_ingame_only/equipment_maxed" );
        thread watchsnowballpickup( loc, snowtype );
        return;
    }
    
    player gameplay_sound_fx::playlocalsoundfx( #"snowball_pickup" );
    playfx( level.snowfx[ "vanish" ], self.origin );
    clearweaponoutlines();
    
    if ( !isplayer( loc ) && snowtype != "pball" )
    {
        level thread waitthenrespawnsnowballs( loc );
    }
    
    self makeunusable();
    self delete();
}

// Namespace arena
// Params 1
// Checksum 0xf6d31b61, Offset: 0x11702
// Size: 0x4c
function waitthenrespawnsnowballs( loc )
{
    level endon( #"game_ended" );
    wait 15;
    playfx( level.snowfx[ "vanish" ], loc.origin );
    spawnweapon( loc, level.arenaweapont1 );
}

// Namespace arena
// Params 0
// Checksum 0x6e9c6372, Offset: 0x11756
// Size: 0x29
function snowballmeleewatcher()
{
    self endon( #"death_or_disconnect" );
    level flags::gameflagwait( "prematch_done" );
    wait 1;
    
    if ( self )
    {
        self allowmelee( 0 );
    }
}

// Namespace arena
// Params 0
// Checksum 0xe66ad1ce, Offset: 0x11787
// Size: 0x12a
function getknivesoutsetting()
{
    if ( game_utility_mp::matchmakinggame() )
    {
        return getdvarint( @"scr_arena_knivesout", 0 );
    }
    else if ( isthrowingknifeequipment( level.arenaweapont1.weapon ) && isthrowingknifeequipment( level.arenaweapont2.weapon ) && isthrowingknifeequipment( level.arenaweapont3.weapon ) && isthrowingknifeequipment( level.arenaweapont4.weapon ) && isthrowingknifeequipment( level.arenaweapont5.weapon ) && isthrowingknifeequipment( level.arenaweapont6.weapon ) && isthrowingknifeequipment( level.arenaweapont7.weapon ) && isthrowingknifeequipment( level.arenaweapont8.weapon ) )
    {
        if ( isthrowingknifeequipment( level.startweapon.weapon ) )
        {
            return 2;
        }
        else
        {
            return 1;
        }
    }
    
    return 0;
}

// Namespace arena
// Params 1
// Checksum 0x749f8cc4, Offset: 0x118ba
// Size: 0x37
function isthrowingknifeequipment( weapon )
{
    if ( weapon == "equip_throwing_knife" || weapon == "equip_throwing_knife_fire" || weapon == "equip_throwing_knife_electric" )
    {
        return 1;
    }
    
    return 0;
}

// Namespace arena
// Params 0
// Checksum 0xae96d33e, Offset: 0x118f9
// Size: 0x6e
function fixupsupersandtacticalsforgunfightmaps()
{
    switch ( level.arenasuper )
    {
        case #"hash_699e6c3e460adde4":
        case #"hash_7266a252f51150e9":
        case #"hash_ac520bae8aaba66b":
            level.arenasuper = "super_ammo_drop";
            break;
        default:
            level.arenasuper = "none";
            break;
    }
    
    return level.arenasuper;
}

// Namespace arena
// Params 2
// Checksum 0x46761e9d, Offset: 0x11970
// Size: 0x88
function function_80dba07e9b128115( progress, team )
{
    if ( !isdefined( self.lastsfxplayedtime ) )
    {
        self.lastsfxplayedtime = gettime();
    }
    
    if ( self.lastsfxplayedtime + 995 < gettime() )
    {
        self.lastsfxplayedtime = gettime();
        progress = int( floor( progress * 10 ) );
        var_8eb35fb703d61a67 = "shared_obj_capturing_tick_0" + progress;
        self.visuals[ 0 ] gameplay_sound_fx::function_6dac8db778849e61( var_8eb35fb703d61a67, team );
    }
}

// Namespace arena
// Params 3
// Checksum 0x88107247, Offset: 0x11a00
// Size: 0x4e
function oncontested_playsoundatpos( posorigin, soundref, timer )
{
    if ( !isdefined( self.contestedbool ) )
    {
        gameplay_sound_fx::function_28103d3430792dce( posorigin, soundref );
        self.contestedbool = 1;
        wait timer;
        self.contestedbool = undefined;
    }
}

// Namespace arena
// Params 3
// Checksum 0xa473babe, Offset: 0x11a56
// Size: 0x4e
function onuncontested_playsoundatpos( posorigin, soundref, timer )
{
    if ( !isdefined( self.uncontestedbool ) )
    {
        gameplay_sound_fx::function_28103d3430792dce( posorigin, soundref );
        self.uncontestedbool = 1;
        wait timer;
        self.uncontestedbool = undefined;
    }
}

// Namespace arena
// Params 1, eflags: 0x4
// Checksum 0x3adf6a65, Offset: 0x11aac
// Size: 0x776
function private function_a12fa9194f151302( equipmentname )
{
    if ( isdefined( equipmentname ) )
    {
        switch ( equipmentname )
        {
            case #"hash_25ac81b822cf0c9f":
                equipmentinfo = spawnstruct();
                equipmentinfo.pickupstring = &"mp_ingame_only/pickup_stim";
                equipmentinfo.icon = "hud_icon_equipment_stim";
                equipmentinfo.worldmodel = "offhand_1h_wm_stim_v0";
                equipmentinfo.equiptype = "secondary";
                return equipmentinfo;
            case #"hash_3995658e01f4fac1":
                equipmentinfo = spawnstruct();
                equipmentinfo.pickupstring = &"mp_ingame_only/pickup_atmine";
                equipmentinfo.icon = "hud_icon_equipment_at_mine";
                equipmentinfo.worldmodel = "offhand_2h_wm_proximity_mine_v0";
                equipmentinfo.equiptype = "primary";
                return equipmentinfo;
            case #"hash_e156752cb79526e8":
                equipmentinfo = spawnstruct();
                equipmentinfo.pickupstring = &"mp_ingame_only/pickup_bunkerbuster";
                equipmentinfo.icon = "hud_icon_equipment_bunker_buster";
                equipmentinfo.worldmodel = "offhand_2h_wm_bunker_buster_v0";
                equipmentinfo.equiptype = "primary";
                return equipmentinfo;
            case #"hash_4320d77f90725183":
                equipmentinfo = spawnstruct();
                equipmentinfo.pickupstring = &"mp_ingame_only/pickup_c4";
                equipmentinfo.icon = "hud_icon_equipment_c4";
                equipmentinfo.worldmodel = "offhand_2h_wm_c4_v0";
                equipmentinfo.equiptype = "primary";
                return equipmentinfo;
            case #"hash_2354208d9af64220":
                equipmentinfo = spawnstruct();
                equipmentinfo.pickupstring = &"mp_ingame_only/pickup_claymore";
                equipmentinfo.icon = "hud_icon_equipment_claymore";
                equipmentinfo.worldmodel = "offhand_2h_wm_claymore_v0";
                equipmentinfo.equiptype = "primary";
                return equipmentinfo;
            case #"hash_5fca4943a78ace9c":
                equipmentinfo = spawnstruct();
                equipmentinfo.pickupstring = &"mp_ingame_only/pickup_stun";
                equipmentinfo.icon = "hud_icon_equipment_stun";
                equipmentinfo.worldmodel = "offhand_1h_wm_grenade_concussion_v0";
                equipmentinfo.equiptype = "secondary";
                return equipmentinfo;
            case #"hash_15d06a7d7efafe8":
                equipmentinfo = spawnstruct();
                equipmentinfo.pickupstring = &"mp_ingame_only/pickup_decoy";
                equipmentinfo.icon = "hud_icon_equipment_decoy";
                equipmentinfo.worldmodel = "offhand_1h_wm_grenade_decoy_v0";
                equipmentinfo.equiptype = "secondary";
                return equipmentinfo;
            case #"hash_5a562592c930b7d6":
                equipmentinfo = spawnstruct();
                equipmentinfo.pickupstring = &"mp_ingame_only/pickup_flash";
                equipmentinfo.icon = "hud_icon_equipment_flash";
                equipmentinfo.worldmodel = "offhand_1h_wm_grenade_flash_v0";
                equipmentinfo.equiptype = "secondary";
                return equipmentinfo;
            case #"hash_8c7819f0a3fbd1e0":
                equipmentinfo = spawnstruct();
                equipmentinfo.pickupstring = &"mp_ingame_only/pickup_frag";
                equipmentinfo.icon = "hud_icon_equipment_frag";
                equipmentinfo.worldmodel = "offhand_2h_wm_grenade_frag_v0";
                equipmentinfo.equiptype = "primary";
                return equipmentinfo;
            case #"hash_4b4a6458f00d9319":
                equipmentinfo = spawnstruct();
                equipmentinfo.pickupstring = &"mp_ingame_only/pickup_hb_sensor";
                equipmentinfo.icon = "hud_icon_equipment_hb_sensor";
                equipmentinfo.worldmodel = "offhand_1h_wm_tablet_v0";
                equipmentinfo.equiptype = "secondary";
                return equipmentinfo;
            case #"hash_142a787e36d7d7ce":
                equipmentinfo = spawnstruct();
                equipmentinfo.pickupstring = &"mp_ingame_only/pickup_molotov";
                equipmentinfo.icon = "hud_icon_equipment_molotov";
                equipmentinfo.worldmodel = "offhand_2h_wm_molotov_v0";
                equipmentinfo.equiptype = "primary";
                return equipmentinfo;
            case #"hash_d3a6dc7f9c517e66":
            case #"hash_f0907f858c134cb4":
                equipmentinfo = spawnstruct();
                equipmentinfo.pickupstring = &"mp_ingame_only/pickup_semtex";
                equipmentinfo.icon = "hud_icon_equipment_semtex";
                equipmentinfo.worldmodel = "offhand_2h_wm_grenade_semtex_v0";
                equipmentinfo.equiptype = "primary";
                return equipmentinfo;
            case #"hash_8df9cfc147eb2d86":
                equipmentinfo = spawnstruct();
                equipmentinfo.pickupstring = &"mp_ingame_only/pickup_shock_stick";
                equipmentinfo.icon = "hud_icon_equipment_shock_stick";
                equipmentinfo.worldmodel = "offhand_1h_wm_shock_stick_v0";
                equipmentinfo.equiptype = "secondary";
                return equipmentinfo;
            case #"hash_fb6b649176cec75d":
                equipmentinfo = spawnstruct();
                equipmentinfo.pickupstring = &"mp_ingame_only/pickup_smoke";
                equipmentinfo.icon = "hud_icon_equipment_smoke";
                equipmentinfo.worldmodel = "offhand_1h_wm_grenade_smoke_v0";
                equipmentinfo.equiptype = "secondary";
                return equipmentinfo;
            case #"hash_4f62b5fa00ecd075":
                equipmentinfo = spawnstruct();
                equipmentinfo.pickupstring = &"mp_ingame_only/pickup_snapshot";
                equipmentinfo.icon = "hud_icon_equipment_snapshot";
                equipmentinfo.worldmodel = "offhand_1h_wm_grenade_snapshot_v0";
                equipmentinfo.equiptype = "secondary";
                return equipmentinfo;
            case #"hash_de4641ddbc44a7ba":
                equipmentinfo = spawnstruct();
                equipmentinfo.pickupstring = &"mp_ingame_only/pickup_thermite";
                equipmentinfo.icon = "hud_icon_equipment_thermite";
                equipmentinfo.worldmodel = "offhand_2h_wm_grenade_thermite_v0";
                equipmentinfo.equiptype = "primary";
                return equipmentinfo;
            case #"hash_9ba0a6ff6081954e":
                equipmentinfo = spawnstruct();
                equipmentinfo.pickupstring = &"mp_ingame_only/pickup_tknife";
                equipmentinfo.icon = "hud_icon_equipment_throwing_knife";
                equipmentinfo.worldmodel = "offhand_2h_wm_throwing_knife_v0";
                equipmentinfo.equiptype = "primary";
                return equipmentinfo;
            case #"hash_61206775eae1c854":
                equipmentinfo = spawnstruct();
                equipmentinfo.pickupstring = &"mp_ingame_only/pickup_tstar";
                equipmentinfo.icon = "hud_icon_equipment_shuriken";
                equipmentinfo.worldmodel = "offhand_2h_wm_throw_star_v0";
                equipmentinfo.equiptype = "primary";
                return equipmentinfo;
            case #"hash_3923e5c5f4d1f90a":
                equipmentinfo = spawnstruct();
                equipmentinfo.pickupstring = &"mp_ingame_only/snowball_pickup";
                equipmentinfo.icon = "hud_icon_equipment_snowball";
                equipmentinfo.worldmodel = "decor_snowball_pyramid_01";
                equipmentinfo.equiptype = "primary";
                return equipmentinfo;
            case #"hash_3e0c07b5bc9dac1":
                equipmentinfo = spawnstruct();
                equipmentinfo.pickupstring = &"mp_ingame_only/pball_pickup";
                equipmentinfo.icon = "hud_icon_equipment_snowball_pball";
                equipmentinfo.worldmodel = "weapon_wm_snowball_urine";
                equipmentinfo.equiptype = "primary";
                return equipmentinfo;
        }
    }
}

// Namespace arena
// Params 0, eflags: 0x4
// Checksum 0x5ffe1df5, Offset: 0x1222b
// Size: 0x54
function private getweaponcategories()
{
    return [ "ar", "br", "dm", "lm", "me", "pi", "sh", "sm", "sn" ];
}

// Namespace arena
// Params 1, eflags: 0x4
// Checksum 0xeabb8afb, Offset: 0x12288
// Size: 0x14e
function private function_d4aa6fa64de797b8( weaponcategory )
{
    if ( isdefined( weaponcategory ) )
    {
        switch ( weaponcategory )
        {
            case #"hash_d4f05e450448c3ec":
            case #"hash_fa18d2f6bd57925a":
                return "ar";
            case #"hash_747e7494f126391f":
            case #"hash_fa21c4f6bd5e3815":
                return "br";
            case #"hash_f4b0076c03d93738":
            case #"hash_fa0ed9f6bd4f4e9a":
                return "dm";
            case #"hash_339227cb650975db":
                return "lethal";
            case #"hash_2f2d546c2247838f":
            case #"hash_fa27b9f6bd62a3f2":
                return "lm";
            case #"hash_719417cb1de832b6":
            case #"hash_fa4dbdf6bd80bf52":
                return "pi";
            case #"hash_690c0d6a821b42e":
            case #"hash_fa50b4f6bd82efbe":
                return "sh";
            case #"hash_900cb96c552c5e8e":
            case #"hash_fa50b9f6bd82f79d":
                return "sm";
            case #"hash_6191aaef9f922f96":
            case #"hash_fa50b6f6bd82f2e4":
                return "sn";
            case #"hash_850999d7864fa3b4":
                return "tactical";
            case #"hash_40a94c5d9e4e265b":
            case #"hash_fa24ddf6bd609e07":
                return "me";
        }
    }
}

// Namespace arena
// Params 1, eflags: 0x4
// Checksum 0xd64a4480, Offset: 0x123df
// Size: 0xaa
function private getrandomweaponforweapontier( weapontier )
{
    if ( issubstr( weapontier, "rand" ) )
    {
        if ( weapontier == "random" )
        {
            return getrandomweapon();
        }
        
        tokens = strtok( weapontier, "_", 1 );
        assert( isdefined( tokens ) && tokens.size == 2 && tokens[ 0 ] == "<dev string:x3a5>", "<dev string:x3aa>" + weapontier );
        weaponcategory = function_d4aa6fa64de797b8( tokens[ 1 ] );
        assert( isdefined( weaponcategory ), "<dev string:x3cc>" + weaponcategory + "<dev string:x3ed>" + weapontier );
        return getrandomweaponfromcategory( weaponcategory );
    }
    
    return weapontier;
}

// Namespace arena
// Params 0, eflags: 0x4
// Checksum 0x55004300, Offset: 0x12492
// Size: 0x22
function private getrandomweapon()
{
    weaponcategory = utility::array_random( getweaponcategories() );
    return getrandomweaponfromcategory( weaponcategory );
}

// Namespace arena
// Params 1, eflags: 0x4
// Checksum 0x4e6ead32, Offset: 0x124bd
// Size: 0x54
function private getrandomweaponfromcategory( weaponcategory )
{
    if ( !isdefined( game[ "arenaWeaponCategories" ] ) )
    {
        return "none";
    }
    
    if ( !isdefined( game[ "arenaWeaponCategories" ][ weaponcategory ] ) || game[ "arenaWeaponCategories" ][ weaponcategory ].size == 0 )
    {
        return "none";
    }
    
    return utility::array_random( game[ "arenaWeaponCategories" ][ weaponcategory ] );
}

// Namespace arena
// Params 1
// Checksum 0x50e394cb, Offset: 0x1251a
// Size: 0x6c
function function_aaf3c5e13b8de8fd( weaponname )
{
    if ( !isdefined( game[ "arenaWeapons" ][ weaponname ] ) )
    {
        return -1;
    }
    
    if ( game[ "arenaWeapons" ][ weaponname ].blueprints.size > 0 )
    {
        randomblueprint = utility::array_random( game[ "arenaWeapons" ][ weaponname ].blueprints );
        return randomblueprint.id;
    }
    
    return -1;
}

// Namespace arena
// Params 0, eflags: 0x4
// Checksum 0x92d54729, Offset: 0x1258f
// Size: 0x1cb
function private function_64e30c7714b9a8e9()
{
    if ( !isdefined( game[ "arenaWeaponCategories" ] ) )
    {
        game[ "arenaWeaponCategories" ] = [];
    }
    
    game[ "arenaWeaponCategories" ][ "lethal" ] = [];
    game[ "arenaWeaponCategories" ][ "tactical" ] = [];
    var_1b8e56f52638af34 = getscriptbundle( level.gametypebundle.var_4941ac4294e15924 );
    assert( isdefined( var_1b8e56f52638af34 ), "<dev string:x405>" );
    
    if ( isdefined( var_1b8e56f52638af34 ) )
    {
        foreach ( equipment in var_1b8e56f52638af34.equipmentlist )
        {
            game[ "arenaWeaponCategories" ][ "lethal" ][ game[ "arenaWeaponCategories" ][ "lethal" ].size ] = equipment.equipmentname;
        }
    }
    
    var_addd5e76eabe4aef = getscriptbundle( level.gametypebundle.var_b2dde5b3b7a1e427 );
    assert( isdefined( var_addd5e76eabe4aef ), "<dev string:x449>" );
    
    if ( isdefined( var_addd5e76eabe4aef ) )
    {
        foreach ( equipment in var_addd5e76eabe4aef.equipmentlist )
        {
            game[ "arenaWeaponCategories" ][ "tactical" ][ game[ "arenaWeaponCategories" ][ "tactical" ].size ] = equipment.equipmentname;
        }
    }
}

// Namespace arena
// Params 0
// Checksum 0x7af7f935, Offset: 0x12762
// Size: 0x1ca
function function_d49af0499dd7b945()
{
    if ( !isdefined( game[ "arenaWeaponCategories" ] ) )
    {
        game[ "arenaWeaponCategories" ] = [];
    }
    
    weaponcategories = getweaponcategories();
    projectname = tolower( getprojectname() ) + "_mp";
    
    foreach ( weaponcategory in weaponcategories )
    {
        game[ "arenaWeaponCategories" ][ weaponcategory ] = [];
        weapontablename = function_5d044133536d0766( "_", [ "arena_weapon_table", weaponcategory, projectname ] );
        var_e6825b4c331d235a = getscriptbundle( hashcat( %"hash_6946961762bbe55b", weapontablename ) );
        assert( isdefined( var_e6825b4c331d235a ), "<dev string:x48f>" + weapontablename );
        
        if ( !isdefined( var_e6825b4c331d235a ) )
        {
            continue;
        }
        
        foreach ( weapon in var_e6825b4c331d235a.weaponlist )
        {
            weaponrootname = function_f424665635ab4667( weapon.var_5ad69c22bb14c14a );
            
            if ( isdefined( weaponrootname ) && weaponrootname != "none" )
            {
                game[ "arenaWeaponCategories" ][ weaponcategory ][ game[ "arenaWeaponCategories" ][ weaponcategory ].size ] = weaponrootname;
            }
        }
    }
}

// Namespace arena
// Params 0, eflags: 0x4
// Checksum 0x91e7d907, Offset: 0x12934
// Size: 0x28e
function private function_63136acc886670a1()
{
    weaponcategories = [];
    var_facaa3659c0101a3 = !israndomarloadouts() && !israndomsmgloadouts() && !israndomlmgloadouts() && !israndompistolloadouts() && !israndomshotgunloadouts() && !israndomsniperloadouts() && !function_ad8b8fa721fa6c8c();
    
    if ( var_facaa3659c0101a3 || israndomarloadouts() )
    {
        weaponcategories[ weaponcategories.size ] = "ar";
        weaponcategories[ weaponcategories.size ] = "br";
    }
    
    if ( var_facaa3659c0101a3 || israndomsmgloadouts() )
    {
        weaponcategories[ weaponcategories.size ] = "sm";
    }
    
    if ( var_facaa3659c0101a3 || israndomlmgloadouts() )
    {
        weaponcategories[ weaponcategories.size ] = "lm";
    }
    
    if ( var_facaa3659c0101a3 || israndompistolloadouts() )
    {
        weaponcategories[ weaponcategories.size ] = "pi";
    }
    
    if ( var_facaa3659c0101a3 || israndomshotgunloadouts() )
    {
        weaponcategories[ weaponcategories.size ] = "sh";
    }
    
    if ( var_facaa3659c0101a3 || israndomsniperloadouts() )
    {
        weaponcategories[ weaponcategories.size ] = "sn";
        weaponcategories[ weaponcategories.size ] = "dm";
    }
    
    if ( function_ad8b8fa721fa6c8c() )
    {
        weaponcategories[ weaponcategories.size ] = "me";
    }
    
    projectname = tolower( getprojectname() ) + "_mp";
    
    foreach ( weaponcategory in weaponcategories )
    {
        classtablename = function_5d044133536d0766( "_", [ "arena_class_table", weaponcategory, projectname ] );
        classtablebundle = getscriptbundle( hashcat( %"hash_2e0802494805f439", classtablename ) );
        assert( isdefined( classtablebundle ), "<dev string:x4cb>" + classtablename );
        
        if ( !isdefined( classtablebundle ) )
        {
            continue;
        }
        
        foreach ( class in classtablebundle.classlist )
        {
            function_523f3f12c562746d( class.classtableentry, weaponcategory );
        }
    }
}

// Namespace arena
// Params 1, eflags: 0x4
// Checksum 0xe9e5efef, Offset: 0x12bca
// Size: 0x334
function private function_f424665635ab4667( var_5ad69c22bb14c14a )
{
    assert( isdefined( level.weaponmapdata ), "<dev string:x506>" );
    
    if ( !isdefined( level.weaponmapdata ) )
    {
        return "none";
    }
    
    if ( !isdefined( var_5ad69c22bb14c14a ) || var_5ad69c22bb14c14a == "" )
    {
        return "none";
    }
    
    var_f3f7b87f53ee8602 = getscriptbundle( hashcat( %"hash_318bec5c5fa0dd65", var_5ad69c22bb14c14a ) );
    assert( isdefined( var_f3f7b87f53ee8602 ), "<dev string:x52a>" + var_5ad69c22bb14c14a );
    
    if ( !isdefined( var_f3f7b87f53ee8602 ) )
    {
        return "none";
    }
    
    if ( ( var_f3f7b87f53ee8602.var_6dd648c0a8d6e2c2 & level.arena.var_91bebe9b68b5f92f ) != level.arena.var_91bebe9b68b5f92f )
    {
        return "none";
    }
    
    if ( !isdefined( game[ "arenaWeapons" ] ) )
    {
        game[ "arenaWeapons" ] = [];
    }
    else if ( isdefined( game[ "arenaWeapons" ][ var_f3f7b87f53ee8602.rootname ] ) )
    {
        return var_f3f7b87f53ee8602.rootname;
    }
    
    game[ "arenaWeapons" ][ var_f3f7b87f53ee8602.rootname ] = spawnstruct();
    game[ "arenaWeapons" ][ var_f3f7b87f53ee8602.rootname ].rootname = var_f3f7b87f53ee8602.rootname;
    game[ "arenaWeapons" ][ var_f3f7b87f53ee8602.rootname ].blueprints = [];
    
    if ( function_7edf0599605cd8ec() )
    {
        blueprints = getweaponblueprintnames( level.weaponmapdata[ var_f3f7b87f53ee8602.rootname ].assetname );
        
        foreach ( blueprintname, blueprintid in blueprints )
        {
            foreach ( allowedblueprint in var_f3f7b87f53ee8602.blueprintlist )
            {
                if ( allowedblueprint.blueprintname == blueprintname )
                {
                    blueprintindex = game[ "arenaWeapons" ][ var_f3f7b87f53ee8602.rootname ].blueprints.size;
                    game[ "arenaWeapons" ][ var_f3f7b87f53ee8602.rootname ].blueprints[ blueprintindex ] = spawnstruct();
                    game[ "arenaWeapons" ][ var_f3f7b87f53ee8602.rootname ].blueprints[ blueprintindex ].name = blueprintname;
                    game[ "arenaWeapons" ][ var_f3f7b87f53ee8602.rootname ].blueprints[ blueprintindex ].id = blueprintid;
                }
            }
        }
    }
    
    return var_f3f7b87f53ee8602.rootname;
}

// Namespace arena
// Params 2, eflags: 0x4
// Checksum 0x828888d6, Offset: 0x12f07
// Size: 0x58d
function private function_523f3f12c562746d( classtableentry, weaponcategory )
{
    if ( !isdefined( classtableentry ) )
    {
        return;
    }
    
    classtableentrybundle = getscriptbundle( hashcat( %"hash_7af4f547630fa97", classtableentry ) );
    assert( isdefined( classtableentrybundle ), "<dev string:x56c>" + classtableentry );
    
    if ( !isdefined( classtableentrybundle ) )
    {
        return;
    }
    
    if ( !function_ad8b8fa721fa6c8c() )
    {
        allowattachments = !israndomnoattachmentloadouts() && !israndomblueprintsloadouts();
        var_7164818b802f69bf = function_f424665635ab4667( classtableentrybundle.primaryweapon.var_5ad69c22bb14c14a );
        
        if ( !isdefined( var_7164818b802f69bf ) || var_7164818b802f69bf == "none" )
        {
            return;
        }
        
        var_7a3873d28921fe2f = function_f424665635ab4667( classtableentrybundle.secondaryweapon.var_5ad69c22bb14c14a );
        
        if ( !isdefined( var_7a3873d28921fe2f ) || var_7a3873d28921fe2f == "none" )
        {
            return;
        }
    }
    
    if ( level.tertiaryweaponslotenabled )
    {
        var_f20a18d4656a078f = function_f424665635ab4667( classtableentrybundle.tertiaryWeapon.var_5ad69c22bb14c14a );
    }
    
    if ( function_7edf0599605cd8ec() )
    {
        if ( !isdefined( game[ "arenaWeapons" ][ var_7164818b802f69bf ].blueprints ) || game[ "arenaWeapons" ][ var_7164818b802f69bf ].blueprints.size == 0 )
        {
            return;
        }
        
        if ( var_7a3873d28921fe2f != "none" && ( !isdefined( game[ "arenaWeapons" ][ var_7a3873d28921fe2f ].blueprints ) || game[ "arenaWeapons" ][ var_7a3873d28921fe2f ].blueprints.size == 0 ) )
        {
            return;
        }
    }
    
    loadout = [];
    loadout[ "loadoutPrimary" ] = var_7164818b802f69bf;
    loadout[ "loadoutPrimaryAttachment" ] = allowattachments ? classtableentrybundle.primaryweapon.attachment1 : "none";
    loadout[ "loadoutPrimaryAttachment1" ] = allowattachments ? classtableentrybundle.primaryweapon.attachment2 : "none";
    loadout[ "loadoutPrimaryAttachment2" ] = allowattachments ? classtableentrybundle.primaryweapon.attachment3 : "none";
    loadout[ "loadoutPrimaryAttachment3" ] = allowattachments ? classtableentrybundle.primaryweapon.attachment4 : "none";
    loadout[ "loadoutPrimaryAttachment4" ] = allowattachments ? classtableentrybundle.primaryweapon.attachment5 : "none";
    loadout[ "loadoutPrimaryAttachment5" ] = allowattachments ? classtableentrybundle.primaryweapon.attachment6 : "none";
    loadout[ "loadoutPrimaryCamo" ] = classtableentrybundle.primaryweapon.camo;
    loadout[ "loadoutPrimaryReticle" ] = classtableentrybundle.primaryweapon.reticle;
    loadout[ "loadoutPrimaryVariantID" ] = function_aaf3c5e13b8de8fd( var_7164818b802f69bf );
    loadout[ "loadoutSecondary" ] = var_7a3873d28921fe2f;
    loadout[ "loadoutSecondaryAttachment" ] = allowattachments ? classtableentrybundle.secondaryweapon.attachment1 : "none";
    loadout[ "loadoutSecondaryAttachment1" ] = allowattachments ? classtableentrybundle.secondaryweapon.attachment2 : "none";
    loadout[ "loadoutSecondaryAttachment2" ] = allowattachments ? classtableentrybundle.secondaryweapon.attachment3 : "none";
    loadout[ "loadoutSecondaryAttachment3" ] = allowattachments ? classtableentrybundle.secondaryweapon.attachment4 : "none";
    loadout[ "loadoutSecondaryAttachment4" ] = allowattachments ? classtableentrybundle.secondaryweapon.attachment5 : "none";
    loadout[ "loadoutSecondaryAttachment5" ] = allowattachments ? classtableentrybundle.secondaryweapon.attachment6 : "none";
    loadout[ "loadoutSecondaryCamo" ] = classtableentrybundle.secondaryweapon.camo;
    loadout[ "loadoutSecondaryReticle" ] = classtableentrybundle.secondaryweapon.reticle;
    loadout[ "loadoutSecondaryVariantID" ] = function_aaf3c5e13b8de8fd( var_7a3873d28921fe2f );
    loadout[ "loadoutEquipmentPrimary" ] = classtableentrybundle.equipment1;
    loadout[ "loadoutEquipmentSecondary" ] = classtableentrybundle.equipment2;
    loadout[ "loadoutFieldUpgrade1" ] = classtableentrybundle.fieldupgrade1;
    loadout[ "loadoutFieldUpgrade2" ] = classtableentrybundle.fieldupgrade2;
    loadout[ "loadoutGesture" ] = "playerdata";
    loadout[ "loadoutExecution" ] = "playerdata";
    
    if ( !isdefined( loadout[ "loadoutPerks" ] ) )
    {
        loadout[ "loadoutPerks" ] = [];
    }
    
    loadout[ "loadoutPerks" ][ loadout[ "loadoutPerks" ].size ] = classtableentrybundle.perk1;
    loadout[ "loadoutPerks" ][ loadout[ "loadoutPerks" ].size ] = classtableentrybundle.perk2;
    loadout[ "loadoutPerks" ][ loadout[ "loadoutPerks" ].size ] = classtableentrybundle.perk3;
    loadout[ "loadoutPerks" ][ loadout[ "loadoutPerks" ].size ] = classtableentrybundle.perk4;
    
    if ( level.tertiaryweaponslotenabled )
    {
        loadout[ "loadoutTertiary" ] = var_f20a18d4656a078f;
    }
    
    if ( !isdefined( game[ "arenaLoadouts" ] ) )
    {
        game[ "arenaLoadouts" ] = [];
    }
    
    if ( !isdefined( game[ "arenaLoadouts" ][ weaponcategory ] ) )
    {
        game[ "arenaLoadouts" ][ weaponcategory ] = [];
    }
    
    game[ "arenaLoadouts" ][ weaponcategory ][ game[ "arenaLoadouts" ][ weaponcategory ].size ] = loadout;
}

// Namespace arena
// Params 0, eflags: 0xc
// Checksum 0xc6a7acee, Offset: 0x1349c
// Size: 0x9f
function private function_950268979eebe9ef()
{
    self notify( #"hash_277a3db57bf3e6c" );
    self endon( #"hash_277a3db57bf3e6c" );
    level endon( #"game_ended" );
    waittillframeend();
    utility::flag_wait( "scriptables_ready" );
    
    switch ( level.objmodifier )
    {
        case 1:
            function_5e2c094bd04a88d4();
            break;
        case 2:
            function_22720620ff546268();
            break;
        default:
            break;
    }
    
    if ( level.overtimeflag > 0 && !function_46ca224400b02341() )
    {
        thread function_7ff0f563afc5d10e();
    }
}

// Namespace arena
// Params 0, eflags: 0x4
// Checksum 0xaabf8784, Offset: 0x13543
// Size: 0x1f2
function private function_7ff0f563afc5d10e()
{
    trigger_map = gameobjects_common::function_73270cee679463ed( "gunfight_ot_flag" );
    
    if ( trigger_map.size == 0 )
    {
        assertmsg( "<dev string:x5ad>" );
        return;
    }
    
    foreach ( trigger_list in trigger_map )
    {
        if ( trigger_list.size != 3 )
        {
            assertmsg( "<dev string:x5e8>" );
            
            if ( trigger_list.size == 0 )
            {
                continue;
            }
        }
        
        trigger = utility::array_random( trigger_list );
        var_24290c36e2cab388 = { #manual_drop:1, #var_7f4958ce4e4277c3:#"hash_bb332da19f9944df", #capture_segment_count:1, #var_333d3689d793bcc7:0, #use_time_seconds:0, #var_c68e9f43ed9cc918:#"hash_a1360b18943e920", #var_d7c90dc73c1dcba8:( 0, 0, 0 ), #objective_icon_offset:( 0, 0, 0 ), #angles:( 0, 0, 0 ), #origin:( 0, 0, 0 ) };
        var_24290c36e2cab388.origin = trigger.origin;
        var_24290c36e2cab388.angles = trigger.angles;
        var_24290c36e2cab388.use_time_seconds = level.flagcapturetime;
        var_24290c36e2cab388.var_333d3689d793bcc7 = level.flagcapturetime;
        gameobjects_common::initialize_game_object( trigger.targetname, var_24290c36e2cab388, trigger, &function_728d9ac776e1504 );
    }
}

// Namespace arena
// Params 1, eflags: 0x4
// Checksum 0x483bbf75, Offset: 0x1373d
// Size: 0x39
function private function_c93981e411e9f4d4( game_object_struct_array )
{
    assert( game_object_struct_array.size == 3, "<dev string:x620>" + game_object_struct_array.size + "<dev string:x647>" );
    return [ utility::array_random( game_object_struct_array ) ];
}

// Namespace arena
// Params 1, eflags: 0x4
// Checksum 0xd1332e0e, Offset: 0x1377f
// Size: 0x3a3
function private function_728d9ac776e1504( gameobject )
{
    assert( isdefined( gameobject ) );
    gameobjectorigin = gameobjects_shared::get_origin( gameobject );
    gameobject.objectiveid = objidpoolmanager::requestobjectiveid();
    objidpoolmanager::function_7736d86e518e223( gameobject.objectiveid );
    objidpoolmanager::update_objective_position( gameobject.objectiveid, gameobjectorigin );
    objidpoolmanager::update_objective_state( gameobject.objectiveid, "current" );
    function_fe778b0c2ed6058b( gameobject );
    game_object_origin = gameobjects_common::get_origin( gameobject );
    trace_start = game_object_origin + ( 0, 0, 64 );
    trace_end = game_object_origin + ( 0.1, 0, -1024 );
    trace_contents = trace::create_solid_ai_contents( 1 );
    trace_result = trace::ray_trace( trace_start, trace_end, undefined, trace_contents );
    gameobject.visuals = spawn( "script_model", trace_result[ "position" ] );
    gameobject.visuals.angles = gameobjects_common::function_63e25df7cfbb206f( gameobject );
    
    if ( isdefined( level.gametypebundle.var_b8108e132d830f23.var_834f51977cd32b4c ) )
    {
        gameobject.visuals setmodel( level.gametypebundle.var_b8108e132d830f23.var_834f51977cd32b4c );
    }
    
    gameobject.visuals show();
    captureflag::function_dfdb63cdb68b35ec( gameobject );
    game_utility_mp::add_gametype_objective( gameobject );
    
    if ( !isdefined( level.arena.overtime_flags ) )
    {
        level.arena.overtime_flags = [];
    }
    
    level.arena.overtime_flags[ gameobjects_shared::get_objective_key( gameobject ) ] = gameobject;
    gameobject callback::function_dc654a4d4126a928( #"hash_92c01688276809dc", #"hash_6947ec89a1af6d69", &function_f0501e82421208a9 );
    gameobject callback::function_dc654a4d4126a928( #"hash_89cf712b23a4d7b5", #"hash_6947ec89a1af6d69", &function_628a8a903077c7de );
    gameobject callback::function_dc654a4d4126a928( #"hash_358d33b2497e2ce3", #"hash_6947ec89a1af6d69", &function_9b6f2c5340458c2f );
    gameobject callback::function_dc654a4d4126a928( #"hash_5d939c5f097361e9", #"hash_6947ec89a1af6d69", &function_9b87693ddd8e1ec3 );
    gameobject callback::function_dc654a4d4126a928( #"hash_3c955b1e6fcd76eb", #"hash_6947ec89a1af6d69", &function_52f1f035cbb1b87e );
    gameobject callback::function_dc654a4d4126a928( #"hash_45277be78cb54c51", #"hash_6947ec89a1af6d69", &function_1e120d5a63902b1c );
    gameobject callback::function_dc654a4d4126a928( #"hash_47fedf1df6eafa30", #"hash_6947ec89a1af6d69", &function_846d4a77ef6d4f2a );
    gameobject callback::function_dc654a4d4126a928( #"hash_3aba7df6443df11d", #"hash_6947ec89a1af6d69", &function_d6c6fc6889a41ead );
    gameobject callback::function_dc654a4d4126a928( #"hash_2e3e0663aecb6f19", #"hash_6947ec89a1af6d69", &function_818e6e28492adc9 );
    gameobject callback::function_dc654a4d4126a928( #"hash_29eede2365f9349a", #"hash_6947ec89a1af6d69", &function_7b04749e1e846dd6 );
    gameobject callback::function_dc654a4d4126a928( #"hash_a836ce9ab43d9e2", #"hash_6947ec89a1af6d69", &function_aa34c9cf4a4e2daa );
    gameobject callback::function_dc654a4d4126a928( #"hash_300ad54dcc9beab1", #"hash_6947ec89a1af6d69", &function_1d0c87881d9dfbc9 );
    gameobject callback::function_dc654a4d4126a928( #"hash_629949853fbabab8", #"hash_6947ec89a1af6d69", &function_63d55845afa9e20 );
    gameobject thread function_994c08b6c92a5f05( gameobject );
    gameobject thread function_67af198c3fb977fc( gameobject );
    gameobject thread function_e5e4f7e9a99bda2( gameobject );
}

// Namespace arena
// Params 0, eflags: 0x4
// Checksum 0xd4c9502e, Offset: 0x13b2a
// Size: 0x9c
function private function_5d3f61394e192bb6()
{
    if ( isdefined( level.arena.overtime_flags ) )
    {
        foreach ( overtime_flag in level.arena.overtime_flags )
        {
            gameobjects_shared::activate( overtime_flag );
        }
    }
}

// Namespace arena
// Params 0, eflags: 0x4
// Checksum 0x34ffa0ab, Offset: 0x13bce
// Size: 0xa6
function private function_e3f5506cb1b0fdb()
{
    if ( isdefined( level.arena.overtime_flags ) )
    {
        foreach ( overtime_flag in level.arena.overtime_flags )
        {
            gameobjects_shared::deactivate( overtime_flag );
            overtime_flag thread function_e5e4f7e9a99bda2( overtime_flag );
        }
    }
}

// Namespace arena
// Params 1, eflags: 0xc
// Checksum 0x8c3b544, Offset: 0x13c7c
// Size: 0xf9
function private function_994c08b6c92a5f05( gameobject )
{
    self notify( #"hash_507b6deb7677aa2d" );
    self endon( #"hash_507b6deb7677aa2d" );
    level endon( #"game_ended" );
    
    if ( !flags::gameflag( "prematch_done" ) )
    {
        instanceid = gameobjects_common::get_instance_id( gameobject );
        teams = game_utility_mp::function_cd6aa714027fb767( instanceid );
        gameobject.visuals.outlineid = outline::function_6901ecad424487e8( gameobject.visuals, teams, "hudoutline_gunfight_ot_flag", "level_script" );
        flags::gameflagwait( "prematch_done" );
    }
    
    if ( isdefined( gameobject.visuals.outlineid ) )
    {
        outline::outlinedisable( gameobject.visuals.outlineid, gameobject.visuals );
        gameobject.visuals.outlineid = undefined;
    }
}

// Namespace arena
// Params 1, eflags: 0xc
// Checksum 0x23638482, Offset: 0x13d7d
// Size: 0x182
function private function_67af198c3fb977fc( gameobject )
{
    self notify( #"hash_abfacb0ec4a2e3cb" );
    self endon( #"hash_abfacb0ec4a2e3cb" );
    level endon( #"game_ended" );
    flags::function_b0491bb92d5acbb6( "match_ending_clock_sound_begin" );
    instanceid = gameobjects_common::get_instance_id( gameobject );
    teamnamelist = game_utility_mp::function_cd6aa714027fb767( instanceid );
    gameobject.visuals.outlineid = outline::function_6901ecad424487e8( gameobject.visuals, teamnamelist, "hudoutline_gunfight_ot_flag", "level_script" );
    
    foreach ( teamname in teamnamelist )
    {
        objidpoolmanager::objective_teammask_addtomask( gameobject.objectiveid, teamname );
    }
    
    function_fe778b0c2ed6058b( gameobject );
    time_remaining_ms = gamelogic_mp::gettimeremaining();
    thread function_12cc43a5b6293509( gameobject.objectiveid, time_remaining_ms );
    wait time_remaining_ms * 0.001;
    outline::outlinedisable( gameobject.visuals.outlineid, gameobject.visuals );
    gameobject.visuals.outlineid = undefined;
}

// Namespace arena
// Params 1, eflags: 0xc
// Checksum 0x29969415, Offset: 0x13f07
// Size: 0xe0
function private function_e5e4f7e9a99bda2( gameobject )
{
    self notify( #"hash_ca134275d41cf5f0" );
    self endon( #"hash_ca134275d41cf5f0" );
    level endon( #"game_ended" );
    gameobjecttrigger = gameobjects_shared::get_trigger( gameobject );
    gameobject.notificationtrigger = spawn( "noent_volume_trigger_radius", gameobjecttrigger.origin, 0, gameobjecttrigger.radius, gameobjecttrigger.height );
    gameobject.notificationtrigger utility::trigger_on();
    trigger::makeenterexittrigger( gameobject.notificationtrigger, &function_5c9ea423a0e036b );
    gameobject waittill( #"hash_c32a7c783a8e1483" );
    gameobject.notificationtrigger utility::trigger_off();
    waitframe();
    gameobject.notificationtrigger delete();
    gameobject.notificationtrigger = undefined;
}

// Namespace arena
// Params 2, eflags: 0x4
// Checksum 0x7e73647c, Offset: 0x13fef
// Size: 0x3a
function private function_5c9ea423a0e036b( player, trigger )
{
    assert( isdefined( player ) && isdefined( trigger ) );
    player hud_message::showerrormessage( %"hash_8d0f19defe08a7f", 1 );
}

// Namespace arena
// Params 2, eflags: 0x4
// Checksum 0xcf93c84e, Offset: 0x14031
// Size: 0x93
function private function_12cc43a5b6293509( objective_id, time_ms )
{
    level endon( #"game_ended" );
    current_time_ms = 0;
    var_5cfdc51756a8db0 = 1 / time_ms;
    objidpoolmanager::objective_show_progress( objective_id, 1 );
    
    while ( current_time_ms < time_ms )
    {
        current_time_ms += level.frameduration;
        progress_fraction = current_time_ms * var_5cfdc51756a8db0;
        objidpoolmanager::objective_set_progress( objective_id, 1 - min( progress_fraction, 1 ) );
        waitframe();
    }
    
    objidpoolmanager::objective_show_progress( objective_id, 0 );
}

// Namespace arena
// Params 1, eflags: 0x4
// Checksum 0xb202a3dd, Offset: 0x140cc
// Size: 0xfb
function private function_f0501e82421208a9( params )
{
    assert( isdefined( params ) );
    gameobject = params.game_object;
    instanceid = params.instance_id;
    gameobject notify( #"hash_c32a7c783a8e1483" );
    
    foreach ( teamname in game_utility_mp::function_cd6aa714027fb767( instanceid ) )
    {
        objidpoolmanager::objective_teammask_addtomask( gameobject.objectiveid, teamname );
    }
    
    function_fe778b0c2ed6058b( gameobject );
    shouldplayerovertimedialog( gameobject );
    gameobjects_shared::get_trigger( gameobject ) gameplay_sound_fx::function_760dbc73d1362ab9( #"arena_flag_spawned" );
}

// Namespace arena
// Params 1, eflags: 0x4
// Checksum 0x964d544a, Offset: 0x141cf
// Size: 0x80
function private function_628a8a903077c7de( params )
{
    assert( isdefined( params ) );
    gameobject = params.game_object;
    
    if ( isdefined( gameobject.visuals.outlineid ) )
    {
        outline::outlinedisable( gameobject.visuals.outlineid, gameobject.visuals );
    }
    
    objidpoolmanager::function_7736d86e518e223( gameobject.objectiveid );
}

// Namespace arena
// Params 1, eflags: 0x4
// Checksum 0xea3c4af, Offset: 0x14257
// Size: 0x58
function private function_9b6f2c5340458c2f( params )
{
    assert( isdefined( params ) );
    level.currenttimelimitdelay = 0;
    setomnvar( "ui_overtime_timer", 1 );
    end_time_ms = int( gettime() + level.overtimeflag * 1000 );
    gamelogic_mp::pausetimer( end_time_ms );
}

// Namespace arena
// Params 1, eflags: 0x4
// Checksum 0xa55fde33, Offset: 0x142b7
// Size: 0x64
function private function_9b87693ddd8e1ec3( params )
{
    assert( isdefined( params ) );
    gameobject = params.game_object;
    gameobject.didstatusnotify = 0;
    end_time_ms = int( gettime() + level.overtimeflag * 1000 );
    gamelogic_mp::resumetimer( end_time_ms );
}

// Namespace arena
// Params 1, eflags: 0x4
// Checksum 0xdac7b710, Offset: 0x14323
// Size: 0x62
function private function_52f1f035cbb1b87e( params )
{
    assert( isdefined( params ) );
    gameobject = params.game_object;
    player = params.player;
    objidpoolmanager::objective_pin_player( gameobject.objectiveid, player );
    objidpoolmanager::function_b3b969f2930890eb( 2, player );
}

// Namespace arena
// Params 1, eflags: 0x4
// Checksum 0x8ee83d03, Offset: 0x1438d
// Size: 0x61
function private function_1e120d5a63902b1c( params )
{
    assert( isdefined( params ) );
    gameobject = params.game_object;
    player = params.player;
    objidpoolmanager::objective_unpin_player( gameobject.objectiveid, player );
    objidpoolmanager::function_b3b969f2930890eb( 0, player );
}

// Namespace arena
// Params 1, eflags: 0x4
// Checksum 0xde942e19, Offset: 0x143f6
// Size: 0x160
function private function_846d4a77ef6d4f2a( params )
{
    assert( isdefined( params ) );
    gameobject = params.game_object;
    claimteam = params.claim_team_name;
    progress = params.progress;
    objidpoolmanager::objective_set_progress( gameobject.objectiveid, progress );
    
    if ( !level.gameended && !game_utility_mp::isanymlgmatch() )
    {
        currenttime = gettime();
        
        if ( !isdefined( gameobject.lastsfxplayedtime ) )
        {
            gameobject.lastsfxplayedtime = currenttime;
        }
        
        if ( gameobject.lastsfxplayedtime + 995 < currenttime )
        {
            gameobject.lastsfxplayedtime = currenttime;
            sfxalias = "shared_obj_capturing_tick_0" + int( progress * 10 );
            gameobjects_shared::get_trigger( gameobject ) gameplay_sound_fx::function_6dac8db778849e61( sfxalias, claimteam );
        }
    }
    
    if ( !gameobject.didstatusnotify )
    {
        if ( gameobjects_shared::get_use_time_seconds( gameobject ) > 0.05 )
        {
            otherteam = team_utility::getotherteam( claimteam );
            dialog::statusdialog( #"hash_931f49400c6822ca", claimteam );
            dialog::statusdialog( #"hash_a9d7782d101676b2", otherteam );
        }
        
        gameobject.didstatusnotify = 1;
    }
}

// Namespace arena
// Params 1, eflags: 0x4
// Checksum 0xd4dc2435, Offset: 0x1455e
// Size: 0x114
function private function_d6c6fc6889a41ead( params )
{
    assert( isdefined( params ) );
    gameobject = params.game_object;
    teamname = params.team_name;
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
}

// Namespace arena
// Params 1, eflags: 0x4
// Checksum 0xdae57da5, Offset: 0x1467a
// Size: 0xfe
function private function_818e6e28492adc9( params )
{
    assert( isdefined( params ) );
    gameobject = params.game_object;
    teamname = params.team_name;
    teamhash = teamname == "all" || teamname == "tie" ? #"hash_a1360b18943e920" : game_utility_mp::is_attacker_team( teamname ) ? #"hash_7118f9343873352b" : game_utility_mp::is_defender_team( teamname ) ? #"hash_ce911e3bbe99421f" : teamname == "none" || teamname == "neutral" ? #"hash_bb332da19f9944df" : undefined;
    
    if ( teamhash == #"hash_7118f9343873352b" || teamhash == #"hash_ce911e3bbe99421f" )
    {
        objidpoolmanager::update_objective_ownerteam( gameobject.objectiveid, teamname );
    }
    
    function_fe778b0c2ed6058b( gameobject );
}

// Namespace arena
// Params 1, eflags: 0x4
// Checksum 0xb9e09f97, Offset: 0x14780
// Size: 0x13b
function private function_7b04749e1e846dd6( params )
{
    assert( isdefined( params ) );
    gameobject = params.game_object;
    teamname = params.team_name;
    teamhash = teamname == "all" || teamname == "tie" ? #"hash_a1360b18943e920" : game_utility_mp::is_attacker_team( teamname ) ? #"hash_7118f9343873352b" : game_utility_mp::is_defender_team( teamname ) ? #"hash_ce911e3bbe99421f" : teamname == "none" || teamname == "neutral" ? #"hash_bb332da19f9944df" : undefined;
    
    if ( teamhash == #"hash_7118f9343873352b" || teamhash == #"hash_ce911e3bbe99421f" )
    {
        objidpoolmanager::objective_show_progress( gameobject.objectiveid, 1 );
        objidpoolmanager::objective_set_progress_team( gameobject.objectiveid, teamname );
    }
    else
    {
        objidpoolmanager::objective_show_progress( gameobject.objectiveid, 0 );
        objidpoolmanager::objective_set_progress_team( gameobject.objectiveid, undefined );
    }
    
    function_fe778b0c2ed6058b( gameobject );
}

// Namespace arena
// Params 1, eflags: 0x4
// Checksum 0x85d8cf19, Offset: 0x148c3
// Size: 0x1c4
function private function_aa34c9cf4a4e2daa( params )
{
    assert( isdefined( params ) );
    gameobject = params.game_object;
    team = params.team_name;
    var_3d152e00ebf9f46d = params.var_dbd0d4c325a7ae15;
    var_380e1341c05f576b = params.var_2b03add3a518dea6;
    instanceid = params.instance_id;
    level.canprocessot = 1;
    function_e3c56a05b0ec8f2( gameobject, team );
    otherteam = team_utility::getotherteam( team );
    dialog::statusdialog( #"hash_a8b07df3a5d608b9", team );
    dialog::statusdialog( #"hash_374b997e0afc0c5a", otherteam );
    gameplay_sound_fx::function_e319dc8e16c85fcb( #"arena_flag_captured", teams::getteamdata( team, "players" ) );
    gameplay_sound_fx::function_e319dc8e16c85fcb( #"hash_60ba4a1ebe112a5e", teams::getteamdata( otherteam, "players" ) );
    game[ "dialog" ][ "round_success" ] = "gamestate_win_capture";
    game[ "dialog" ][ "round_failure" ] = "gamestate_lost_capture";
    winreason = game[ "end_reason" ][ "arena_otflag_completed" ];
    lossreason = game[ "end_reason" ][ "arena_otflag_failed" ];
    instance = undefined;
    
    if ( level.multimatch ?? gameinstance::is_enabled() )
    {
        instancedata = gameinstance::function_1d3a8144ddb36029();
        instance = instancedata[ instanceid ];
    }
    
    thread arena_endgame( team, winreason, lossreason, 0, undefined, instance );
    level notify( #"arena_overtime_flag_captured", gameobject.objective_key );
    gameobject notify( #"arena_overtime_flag_captured" );
}

// Namespace arena
// Params 1, eflags: 0x4
// Checksum 0x69b92bbe, Offset: 0x14a8f
// Size: 0xd9
function private function_1d0c87881d9dfbc9( params )
{
    assert( isdefined( params ) );
    gameobject = params.game_object;
    objidpoolmanager::update_objective_sethot( gameobject.objectiveid, 1 );
    
    if ( !isdefined( level.arena.var_5d763679686d0227 ) )
    {
        level.arena.var_5d763679686d0227 = 0;
    }
    
    currenttime = gettime();
    
    if ( level.arena.var_5d763679686d0227 < currenttime )
    {
        origin = gameobjects_shared::get_origin( gameobject );
        gameplay_sound_fx::function_28103d3430792dce( origin, #"arena_zone_contested" );
        level.arena.var_5d763679686d0227 = currenttime + 3000;
    }
    
    thread forcegameendcontesttimeout();
}

// Namespace arena
// Params 1, eflags: 0x4
// Checksum 0x5ed0a89b, Offset: 0x14b70
// Size: 0x119
function private function_63d55845afa9e20( params )
{
    assert( isdefined( params ) );
    gameobject = params.game_object;
    objidpoolmanager::update_objective_sethot( gameobject.objectiveid, 0 );
    owningteam = gameobjects_shared::function_623b07f4735aecb2( gameobject );
    lastclaimteam = gameobjects_shared::function_b94c7e25e2a759f7( gameobject );
    
    if ( owningteam == "none" || lastclaimteam == "none" )
    {
        gameobject.didstatusnotify = 0;
    }
    
    if ( !isdefined( level.arena.var_9269d8edf41adf0 ) )
    {
        level.arena.var_9269d8edf41adf0 = 0;
    }
    
    currenttime = gettime();
    
    if ( level.arena.var_9269d8edf41adf0 < currenttime )
    {
        gameobjectorigin = gameobjects_shared::get_origin( gameobject );
        gameplay_sound_fx::function_28103d3430792dce( gameobjectorigin, #"hash_fecf3dcc49e3c000" );
        level.arena.var_9269d8edf41adf0 = currenttime + 3000;
    }
}

// Namespace arena
// Params 0, eflags: 0x4
// Checksum 0xc8256b9b, Offset: 0x14c91
// Size: 0x2be
function private function_5e2c094bd04a88d4()
{
    attackertriggers = getentarray( "gunfight_attacker_flag", #targetname );
    defendertriggers = getentarray( "gunfight_defender_flag", #targetname );
    
    if ( !isdefined( attackertriggers[ 0 ] ) )
    {
        assertmsg( "<dev string:x653>" );
        return;
    }
    
    if ( !isdefined( defendertriggers[ 0 ] ) )
    {
        assertmsg( "<dev string:x682>" );
        return;
    }
    
    attackers_init_struct = { #manual_drop:1, #var_7f4958ce4e4277c3:#"hash_bb332da19f9944df", #capture_segment_count:1, #var_333d3689d793bcc7:0, #use_time_seconds:0, #var_c68e9f43ed9cc918:#"hash_a1360b18943e920", #var_d7c90dc73c1dcba8:( 0, 0, 0 ), #objective_icon_offset:( 0, 0, 0 ), #angles:( 0, 0, 0 ), #origin:( 0, 0, 0 ) };
    attackers_init_struct.origin = attackertriggers[ 0 ].origin;
    attackers_init_struct.angles = attackertriggers[ 0 ].angles;
    attackers_init_struct.use_time_seconds = level.flagcapturetime;
    attackers_init_struct.var_7f4958ce4e4277c3 = #"hash_7118f9343873352b";
    gameobjects_common::initialize_game_object( attackertriggers[ 0 ].targetname, attackers_init_struct, attackertriggers[ 0 ], &function_941fa12326e5d916 );
    defenders_init_struct = { #manual_drop:1, #var_7f4958ce4e4277c3:#"hash_bb332da19f9944df", #capture_segment_count:1, #var_333d3689d793bcc7:0, #use_time_seconds:0, #var_c68e9f43ed9cc918:#"hash_a1360b18943e920", #var_d7c90dc73c1dcba8:( 0, 0, 0 ), #objective_icon_offset:( 0, 0, 0 ), #angles:( 0, 0, 0 ), #origin:( 0, 0, 0 ) };
    defenders_init_struct.origin = defendertriggers[ 0 ].origin;
    defenders_init_struct.angles = defendertriggers[ 0 ].angles;
    defenders_init_struct.use_time_seconds = level.flagcapturetime;
    defenders_init_struct.var_7f4958ce4e4277c3 = #"hash_ce911e3bbe99421f";
    gameobjects_common::initialize_game_object( defendertriggers[ 0 ].targetname, defenders_init_struct, defendertriggers[ 0 ], &function_941fa12326e5d916 );
}

// Namespace arena
// Params 1, eflags: 0x4
// Checksum 0x7faef0f0, Offset: 0x14f57
// Size: 0x34e
function private function_941fa12326e5d916( gameobject )
{
    assert( isdefined( gameobject ) );
    gameobjectorigin = gameobjects_shared::get_origin( gameobject );
    owningteam = gameobjects_shared::function_623b07f4735aecb2( gameobject );
    gameobject.objectiveid = objidpoolmanager::requestobjectiveid();
    objidpoolmanager::objective_playermask_hidefromall( gameobject.objectiveid );
    objidpoolmanager::update_objective_ownerteam( gameobject.objectiveid, owningteam );
    objidpoolmanager::update_objective_position( gameobject.objectiveid, gameobjectorigin );
    objidpoolmanager::update_objective_state( gameobject.objectiveid, "current" );
    function_fe778b0c2ed6058b( gameobject );
    var_e6c78e49dbaf02ce = utility::drop_to_ground( gameobjectorigin, 64, -1024 );
    gameobjecttrigger = gameobjects_shared::get_trigger( gameobject );
    gameobject.visuals = spawn( "script_model", var_e6c78e49dbaf02ce );
    gameobject.visuals.angles = gameobjecttrigger.angles;
    function_e3c56a05b0ec8f2( gameobject, owningteam );
    
    if ( !isdefined( level.arena.endzoneflags ) )
    {
        level.arena.endzoneflags = [];
    }
    
    level.arena.endzoneflags[ owningteam ] = gameobject;
    
    if ( !isdefined( level.objectives ) )
    {
        level.objectives = [];
    }
    
    level.objectives[ gameobject.objective_key ] = gameobject;
    gameobject callback::function_dc654a4d4126a928( #"hash_92c01688276809dc", #"hash_6947ec89a1af6d69", &function_4e21cc9698f5fb9f );
    gameobject callback::function_dc654a4d4126a928( #"hash_89cf712b23a4d7b5", #"hash_6947ec89a1af6d69", &function_2a6dea42fd958afc );
    gameobject callback::function_dc654a4d4126a928( #"hash_358d33b2497e2ce3", #"hash_6947ec89a1af6d69", &function_475946506e20ed19 );
    gameobject callback::function_dc654a4d4126a928( #"hash_5d939c5f097361e9", #"hash_6947ec89a1af6d69", &function_22afd37d961d3bb1 );
    gameobject callback::function_dc654a4d4126a928( #"hash_3c955b1e6fcd76eb", #"hash_6947ec89a1af6d69", &function_761601670e405c3c );
    gameobject callback::function_dc654a4d4126a928( #"hash_45277be78cb54c51", #"hash_6947ec89a1af6d69", &function_c119a620a9960a46 );
    gameobject callback::function_dc654a4d4126a928( #"hash_47fedf1df6eafa30", #"hash_6947ec89a1af6d69", &function_6661e289e21fdfc8 );
    gameobject callback::function_dc654a4d4126a928( #"hash_3aba7df6443df11d", #"hash_6947ec89a1af6d69", &function_f991bd9003624b07 );
    gameobject callback::function_dc654a4d4126a928( #"hash_2e3e0663aecb6f19", #"hash_6947ec89a1af6d69", &function_b836dad1ee4858cf );
    gameobject callback::function_dc654a4d4126a928( #"hash_29eede2365f9349a", #"hash_6947ec89a1af6d69", &function_3b63b07e48baad18 );
    gameobject callback::function_dc654a4d4126a928( #"hash_a836ce9ab43d9e2", #"hash_6947ec89a1af6d69", &function_a80707d7e625b978 );
    gameobject callback::function_dc654a4d4126a928( #"hash_300ad54dcc9beab1", #"hash_6947ec89a1af6d69", &function_26b5c03905161e83 );
    gameobject callback::function_dc654a4d4126a928( #"hash_629949853fbabab8", #"hash_6947ec89a1af6d69", &function_881df324ded4f826 );
    gameobject callback::function_dc654a4d4126a928( #"hash_a4277d17a7a228c9", #"hash_6947ec89a1af6d69", &function_28b0dc5ca4d8e578 );
    gameobjects_shared::activate( gameobject );
}

// Namespace arena
// Params 1, eflags: 0x4
// Checksum 0xfc93e7bc, Offset: 0x152ad
// Size: 0x59
function private function_4e21cc9698f5fb9f( params )
{
    assert( isdefined( params ) );
    gameobject = params.game_object;
    gameobject.visuals show();
    function_fe778b0c2ed6058b( gameobject );
    objidpoolmanager::objective_playermask_showtoall( gameobject.objectiveid );
}

// Namespace arena
// Params 1, eflags: 0x4
// Checksum 0xaa6687e8, Offset: 0x1530e
// Size: 0x50
function private function_2a6dea42fd958afc( params )
{
    assert( isdefined( params ) );
    gameobject = params.game_object;
    gameobject.visuals hide();
    objidpoolmanager::objective_playermask_hidefromall( gameobject.objectiveid );
}

// Namespace arena
// Params 1, eflags: 0x4
// Checksum 0xe4ab2bd1, Offset: 0x15366
// Size: 0x21
function private function_475946506e20ed19( params )
{
    assert( isdefined( params ) );
    level.canprocessot = 0;
}

// Namespace arena
// Params 1, eflags: 0x4
// Checksum 0x812425fa, Offset: 0x1538f
// Size: 0x22
function private function_22afd37d961d3bb1( params )
{
    assert( isdefined( params ) );
    level.canprocessot = 1;
}

// Namespace arena
// Params 1, eflags: 0x4
// Checksum 0x94f833f3, Offset: 0x153b9
// Size: 0x62
function private function_761601670e405c3c( params )
{
    assert( isdefined( params ) );
    gameobject = params.game_object;
    player = params.player;
    objidpoolmanager::objective_pin_player( gameobject.objectiveid, player );
    objidpoolmanager::function_b3b969f2930890eb( 2, player );
}

// Namespace arena
// Params 1, eflags: 0x4
// Checksum 0x70d1b23a, Offset: 0x15423
// Size: 0x61
function private function_c119a620a9960a46( params )
{
    assert( isdefined( params ) );
    gameobject = params.gameobject;
    player = params.player;
    objidpoolmanager::objective_unpin_player( gameobject.objectiveid, player );
    objidpoolmanager::function_b3b969f2930890eb( 0, player );
}

// Namespace arena
// Params 3, eflags: 0x4
// Checksum 0xd34c227e, Offset: 0x1548c
// Size: 0x49
function private function_6661e289e21fdfc8( gameobject, claimteam, progress )
{
    assert( isdefined( gameobject ) && isdefined( claimteam ) && isdefined( progress ) );
    objidpoolmanager::objective_set_progress( gameobject.objectiveid, progress );
}

// Namespace arena
// Params 1, eflags: 0x4
// Checksum 0xed91a873, Offset: 0x154dd
// Size: 0x114
function private function_f991bd9003624b07( params )
{
    assert( isdefined( params ) );
    gameobject = params.game_object;
    teamname = params.team_name;
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
}

// Namespace arena
// Params 1, eflags: 0x4
// Checksum 0x4563d48c, Offset: 0x155f9
// Size: 0xfe
function private function_b836dad1ee4858cf( params )
{
    assert( isdefined( params ) );
    gameobject = params.game_object;
    teamname = params.team_name;
    teamhash = teamname == "all" || teamname == "tie" ? #"hash_a1360b18943e920" : game_utility_mp::is_attacker_team( teamname ) ? #"hash_7118f9343873352b" : game_utility_mp::is_defender_team( teamname ) ? #"hash_ce911e3bbe99421f" : teamname == "none" || teamname == "neutral" ? #"hash_bb332da19f9944df" : undefined;
    
    if ( teamhash == #"hash_7118f9343873352b" || teamhash == #"hash_ce911e3bbe99421f" )
    {
        objidpoolmanager::update_objective_ownerteam( gameobject.objectiveid, teamname );
    }
    
    function_fe778b0c2ed6058b( gameobject );
}

// Namespace arena
// Params 1, eflags: 0x4
// Checksum 0x52ac84b6, Offset: 0x156ff
// Size: 0x13b
function private function_3b63b07e48baad18( params )
{
    assert( isdefined( params ) );
    gameobject = params.game_object;
    teamname = params.team_name;
    teamhash = teamname == "all" || teamname == "tie" ? #"hash_a1360b18943e920" : game_utility_mp::is_attacker_team( teamname ) ? #"hash_7118f9343873352b" : game_utility_mp::is_defender_team( teamname ) ? #"hash_ce911e3bbe99421f" : teamname == "none" || teamname == "neutral" ? #"hash_bb332da19f9944df" : undefined;
    
    if ( teamhash == #"hash_7118f9343873352b" || teamhash == #"hash_ce911e3bbe99421f" )
    {
        objidpoolmanager::objective_show_progress( gameobject.objectiveid, 1 );
        objidpoolmanager::objective_set_progress_team( gameobject.objectiveid, teamname );
    }
    else
    {
        objidpoolmanager::objective_show_progress( gameobject.objectiveid, 0 );
        objidpoolmanager::objective_set_progress_team( gameobject.objectiveid, undefined );
    }
    
    function_fe778b0c2ed6058b( gameobject );
}

// Namespace arena
// Params 1, eflags: 0x4
// Checksum 0x28cd608e, Offset: 0x15842
// Size: 0x140
function private function_a80707d7e625b978( params )
{
    assert( isdefined( params ) );
    gameobject = params.game_object;
    team = params.team_name;
    var_3d152e00ebf9f46d = params.var_dbd0d4c325a7ae15;
    var_380e1341c05f576b = params.var_2b03add3a518dea6;
    level.canprocessot = 1;
    otherteam = team_utility::getotherteam( team );
    gameplay_sound_fx::function_e319dc8e16c85fcb( #"arena_flag_captured", teams::getteamdata( team, "players" ) );
    gameplay_sound_fx::function_e319dc8e16c85fcb( #"hash_60ba4a1ebe112a5e", teams::getteamdata( otherteam, "players" ) );
    var_afaf5a82e343815a = arraycombine( [ var_3d152e00ebf9f46d ], var_380e1341c05f576b );
    thread giveflagcapturexp( var_afaf5a82e343815a, var_3d152e00ebf9f46d );
    var_3d152e00ebf9f46d stats::setextrascore0( var_3d152e00ebf9f46d.pers[ "extrascore0" ] + 1 );
    thread arena_endgame( team, game[ "end_reason" ][ "objective_completed" ], undefined, 0, 2 );
    level notify( #"arena_endzone_flag_captured", gameobject.objective_key );
    gameobject notify( #"arena_endzone_flag_captured" );
}

// Namespace arena
// Params 1, eflags: 0x4
// Checksum 0xd2e34d26, Offset: 0x1598a
// Size: 0x42
function private function_26b5c03905161e83( params )
{
    assert( isdefined( params ) );
    gameobject = params.game_object;
    objidpoolmanager::update_objective_sethot( gameobject.objectiveid, 1 );
}

// Namespace arena
// Params 1, eflags: 0x4
// Checksum 0x6c5388c0, Offset: 0x159d4
// Size: 0x41
function private function_881df324ded4f826( params )
{
    assert( isdefined( params ) );
    gameobject = params.game_object;
    objidpoolmanager::update_objective_sethot( gameobject.objectiveid, 0 );
}

// Namespace arena
// Params 1, eflags: 0x4
// Checksum 0x16e95358, Offset: 0x15a1d
// Size: 0xc5
function private function_28b0dc5ca4d8e578( params )
{
    assert( isdefined( params ) );
    gameobject = params.game_object;
    var_afaf5a82e343815a = params.var_3fb67f294d22fb9a;
    
    foreach ( player in var_afaf5a82e343815a )
    {
        player rank::function_d2aa8986c506e985( #"defend" );
        player events::function_a7d373228760063b();
    }
}

// Namespace arena
// Params 0, eflags: 0x4
// Checksum 0xde669864, Offset: 0x15aea
// Size: 0x305
function private function_22720620ff546268()
{
    triggersa = getentarray( "cyber_emp_pickup_trig", #targetname );
    triggerorigins = [];
    
    foreach ( trigger in triggersa )
    {
        triggerorigins[ triggerorigins.size ] = trigger.origin;
    }
    
    if ( triggerorigins.size == 0 )
    {
        triggersb = getentarray( "domflag", #targetname );
        triggeroriginb = ( 0, 0, 0 );
        
        foreach ( trigger in triggersb )
        {
            if ( trigger.script_label == "_b" )
            {
                triggeroriginb = trigger.origin;
                break;
            }
        }
        
        triggerorigins[ triggerorigins.size ] = triggeroriginb;
    }
    
    if ( triggerorigins.size == 0 )
    {
        assertmsg( "<dev string:x6b1>" );
        return;
    }
    
    triggerorigins = arrayrandomize( triggerorigins );
    tracestart = triggerorigins[ 0 ] + ( 0, 0, 64 );
    traceend = triggerorigins[ 0 ] + ( 0, 0, -64 );
    contents = trace::create_default_contents( 1 );
    trace = trace::ray_trace( tracestart, traceend, undefined, contents );
    trigger = spawn( "trigger_radius", trace[ "position" ], 0, 32, 128 );
    trigger.script_label = "arena_carry_flag";
    var_24290c36e2cab388 = { #manual_drop:1, #var_7f4958ce4e4277c3:#"hash_bb332da19f9944df", #capture_segment_count:1, #var_333d3689d793bcc7:0, #use_time_seconds:0, #var_c68e9f43ed9cc918:#"hash_a1360b18943e920", #var_d7c90dc73c1dcba8:( 0, 0, 0 ), #objective_icon_offset:( 0, 0, 0 ), #angles:( 0, 0, 0 ), #origin:( 0, 0, 0 ) };
    var_24290c36e2cab388.origin = trigger.origin;
    var_24290c36e2cab388.angles = trigger.angles;
    gameobjects_common::initialize_game_object( trigger.targetname, var_24290c36e2cab388, trigger, &function_31e148d5058f25ca );
}

// Namespace arena
// Params 1, eflags: 0x4
// Checksum 0x6377f2f, Offset: 0x15df7
// Size: 0xb9
function private function_31e148d5058f25ca( gameobject )
{
    assert( isdefined( gameobject ) );
    level.var_9eb82d89b62a76fa = gameobject;
    
    if ( !isdefined( level.objectives ) )
    {
        level.objectives = [];
    }
    
    level.objectives[ gameobject.objective_key ] = gameobject;
    gameobject callback::function_dc654a4d4126a928( #"hash_249e26f937238db4", #"hash_6947ec89a1af6d69", &function_7de2b0b2ea6117bf );
    gameobject callback::function_dc654a4d4126a928( #"hash_a21546ba725310a2", #"hash_6947ec89a1af6d69", &function_2c2eb7a3c424791c );
    gameobject callback::function_dc654a4d4126a928( #"hash_754b791c5072837b", #"hash_6947ec89a1af6d69", &function_9c796cfacb9348e6 );
    gameobjects_shared::activate( gameobject );
}

// Namespace arena
// Params 2, eflags: 0xc
// Checksum 0xd8e1748c, Offset: 0x15eb8
// Size: 0x2f7
function private function_148b78c98ffdfcd3( gameobject, player )
{
    self notify( #"hash_e91728b053eb8184" );
    self endon( #"hash_e91728b053eb8184" );
    assert( isdefined( gameobject ) && isdefined( player ) );
    level endon( #"game_ended" );
    player endon( #"death_or_disconnect" );
    currenttime = gettime() * 0.001;
    var_cfaedd8aaf6e8ae7 = currenttime + 1;
    flagholdtime = level.flagholdtimer ?? 0;
    
    if ( flagholdtime > 0 )
    {
        setomnvar( "ui_obj_timer", int( flagholdtime * 1000 ) );
        setomnvar( "ui_obj_progress", 1 );
        setomnvar( "ui_obj_timer_stopped", 0 );
        hud_message::notifyteam( "flag_force_hold_fr", "flag_force_hold_en", player.team );
    }
    
    while ( true )
    {
        if ( level.gameended )
        {
            break;
        }
        
        carrier = gameobjects_shared::carryobject_get_carrier( gameobject );
        
        if ( carrier != player )
        {
            break;
        }
        
        if ( var_cfaedd8aaf6e8ae7 <= currenttime )
        {
            if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( player ) ) )
            {
                if ( isdefined( player.leaderboarddata[ "objTime" ] ) )
                {
                    player.leaderboarddata[ "objTime" ] = player.leaderboarddata[ "objTime" ] + 1;
                }
                
                if ( isdefined( level.leaderboardfunc[ "objTime" ] ) )
                {
                    [[ level.leaderboardfunc[ "objTime" ] ]]( player, 1 );
                }
                
                assert( isint( 1 ) || isfloat( 1 ), "<dev string:x37f>" );
                
                if ( isdefined( player.pers[ "objTime" ] ) )
                {
                    player.pers[ "objTime" ] = player.pers[ "objTime" ] + 1;
                }
            }
            
            player stats::setextrascore2( player.pers[ "objTime" ] );
            player persistence::statsetchild( "round", "objTime", player.pers[ "objTime" ] );
            player gamescore::giveplayerscore( #"hash_98bfd8d29c56bc08", 10 );
            var_cfaedd8aaf6e8ae7 = currenttime + 1;
        }
        
        if ( isdefined( level.flagholdtimer ) )
        {
            setomnvar( "ui_obj_progress", flagholdtime / level.flagholdtimer );
            flagholdtime -= level.framedurationseconds;
        }
        
        if ( flagholdtime <= 0 )
        {
            winreason = game[ "end_reason" ][ "ko_flag_hold_win" ];
            lossreason = game[ "end_reason" ][ "ko_flag_hold_loss" ];
            thread arena_endgame( player.team, winreason, lossreason );
            level notify( #"arena_carry_flag_hold_time_elapsed", gameobject.objective_key );
            gameobject notify( #"arena_carry_flag_hold_time_elapsed" );
            break;
        }
        
        waitframe();
    }
}

// Namespace arena
// Params 1, eflags: 0x4
// Checksum 0x9e113232, Offset: 0x161b7
// Size: 0x31a
function private function_7de2b0b2ea6117bf( params )
{
    assert( isdefined( params ) );
    gameobject = params.game_object;
    player = params.player;
    var_40b478732ed59e4b = params.team_first_pickup;
    forcepickup = params.force_pickup;
    thread function_148b78c98ffdfcd3( gameobject, player );
    
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
        
        assert( isint( 1 ) || isfloat( 1 ), "<dev string:x37f>" );
        
        if ( isdefined( player.pers[ "pickups" ] ) )
        {
            player.pers[ "pickups" ] = player.pers[ "pickups" ] + 1;
        }
    }
    
    lastcarrier = gameobjects_shared::function_855bff02ac882f59( gameobject );
    
    if ( lastcarrier != player )
    {
        player points::doscoreevent( #"flag_grab" );
    }
    
    switch ( player.team )
    {
        case #"hash_5f54b9bf7583687f":
            player attach( "prop_ctf_game_flag_west", "tag_stowed_back3" );
            break;
        case #"hash_7c2d091e6337bf54":
            player attach( "prop_ctf_game_flag_east", "tag_stowed_back3" );
            break;
    }
    
    if ( level.codcasterenabled )
    {
        player setgametypevip( 1 );
    }
    
    otherteam = team_utility::getotherteam( player.team );
    gameplay_sound_fx::function_e319dc8e16c85fcb( #"hash_871eee86e8c71bd6", teams::getteamdata( player.team, "players" ) );
    gameplay_sound_fx::function_e319dc8e16c85fcb( #"hash_3acd69035d5d6789", teams::getteamdata( otherteam, "players" ) );
    
    if ( !level.gameended )
    {
        dialog::leaderdialog( "enemy_flag_taken", player.team );
        dialog::leaderdialog( "flag_getback", otherteam );
    }
    
    hud_util::teamplayercardsplash( "callout_flagpickup", player );
    player hud_message::showsplash( "flagpickup" );
    player setclientomnvar( "ui_flag_player_hud_icon", 1 );
    telemetrydata = spawnstruct();
    telemetrydata.player = player;
    telemetrydata.eventname = "pickup";
    telemetrydata.position = player.origin;
    telemetry_utils::function_af2d366f9522f76f( "callback_on_game_event", telemetrydata );
    level notify( #"arena_carry_flag_picked_up", gameobject.objective_key );
    gameobject notify( #"arena_carry_flag_picked_up" );
}

// Namespace arena
// Params 1, eflags: 0x4
// Checksum 0xa93d75ed, Offset: 0x164d9
// Size: 0x191
function private function_2c2eb7a3c424791c( params )
{
    assert( isdefined( params ) );
    gameobject = params.game_object;
    player = params.player;
    
    switch ( player.team )
    {
        case #"hash_5f54b9bf7583687f":
            player detach( "prop_ctf_game_flag_west", "tag_stowed_back3" );
            break;
        case #"hash_7c2d091e6337bf54":
            player detach( "prop_ctf_game_flag_east", "tag_stowed_back3" );
            break;
    }
    
    if ( level.codcasterenabled )
    {
        player setgametypevip( 0 );
    }
    
    otherteam = team_utility::getotherteam( player.team );
    gameplay_sound_fx::function_e319dc8e16c85fcb( #"hash_f811939a6bb36815", teams::getteamdata( otherteam, "players" ) );
    
    if ( !level.gameended )
    {
        dialog::leaderdialog( "flag_dropped", player.team, "status" );
        dialog::leaderdialog( "enemy_flag_dropped", otherteam, "status" );
    }
    
    player hud_message::function_ef4318a0090caa0f( #"single_flag_cap" );
    
    if ( level.flagholdtimer > 0 )
    {
        setomnvar( "ui_obj_timer", 0 );
        setomnvar( "ui_obj_progress", 0 );
        setomnvar( "ui_obj_timer_stopped", 1 );
    }
    
    player setclientomnvar( "ui_flag_player_hud_icon", 0 );
    level notify( #"arena_carry_flag_dropped", gameobject.objective_key );
    gameobject notify( #"arena_carry_flag_dropped" );
}

// Namespace arena
// Params 1, eflags: 0x4
// Checksum 0x3f011dec, Offset: 0x16672
// Size: 0xd2
function private function_9c796cfacb9348e6( params )
{
    assert( isdefined( params ) );
    gameobject = params.game_object;
    
    foreach ( team in level.teamnamelist )
    {
        gameplay_sound_fx::function_6dac8db778849e61( #"hash_f811939a6bb36815", team );
    }
    
    level notify( #"arena_carry_flag_returned_home", gameobject.objective_key );
    gameobject notify( #"arena_carry_flag_returned_home" );
}

// Namespace arena
// Params 1, eflags: 0x4
// Checksum 0xc4eac42a, Offset: 0x1674c
// Size: 0x143
function private function_fe778b0c2ed6058b( gameobject )
{
    if ( !gameobjects_shared::is_activated( gameobject ) )
    {
        namespace_1cdb218d68ef13f6::set_objective_icon_state( gameobject.objectiveid, #"hash_9735c7784a4fb3ae" );
        return;
    }
    
    var_4a7cd465ff58f423 = namespace_277c922f0d0dc523::get_claim_team_hash( gameobject );
    var_543da7845de195ab = namespace_277c922f0d0dc523::function_9b71aa2788e21706( gameobject );
    var_92274902a4720e10 = namespace_277c922f0d0dc523::function_a33241bbed7a745d( gameobject );
    
    if ( var_543da7845de195ab == #"hash_a1360b18943e920" )
    {
        namespace_1cdb218d68ef13f6::set_objective_icon_state( gameobject.objectiveid, #"flag_contested" );
        return;
    }
    
    if ( var_543da7845de195ab == #"hash_bb332da19f9944df" || var_4a7cd465ff58f423 == #"hash_bb332da19f9944df" )
    {
        namespace_1cdb218d68ef13f6::set_objective_icon_state( gameobject.objectiveid, #"flag_idle" );
        return;
    }
    
    if ( var_543da7845de195ab != var_4a7cd465ff58f423 )
    {
        namespace_1cdb218d68ef13f6::set_objective_icon_state( gameobject.objectiveid, #"hash_539be8fb439cd022" );
        return;
    }
    
    if ( var_92274902a4720e10 == #"hash_bb332da19f9944df" )
    {
        namespace_1cdb218d68ef13f6::set_objective_icon_state( gameobject.objectiveid, #"flag_defending" );
        return;
    }
    
    namespace_1cdb218d68ef13f6::set_objective_icon_state( gameobject.objectiveid, #"flag_clearing" );
}

// Namespace arena
// Params 2, eflags: 0x4
// Checksum 0x2691ecd2, Offset: 0x16897
// Size: 0x1fd
function private function_e3c56a05b0ec8f2( game_object, team_name )
{
    if ( !istrue( isdefined( team_name == "all" || team_name == "tie" ? #"hash_a1360b18943e920" : game_utility_mp::is_attacker_team( team_name ) ? #"hash_7118f9343873352b" : game_utility_mp::is_defender_team( team_name ) ? #"hash_ce911e3bbe99421f" : team_name == "none" || team_name == "neutral" ? #"hash_bb332da19f9944df" : undefined ) ) )
    {
        assertmsg( "<dev string:x6f0>" + "<dev string:x6ff>" + team_name + "<dev string:x723>" + "<dev string:x725>" + game_object.name_hash + "<dev string:x734>" );
        logstring( "[GAME OBJECT] " + "ASSERT: " + "Invalid game object use team name '" + team_name + "'" + " { name_hash: " + game_object.name_hash + " }" );
    }
    
    if ( game_utility_mp::is_attacker_team( team_name ) )
    {
        if ( isdefined( level.gametypebundle.var_b8108e132d830f23.var_bf1a4751387ea118 ) )
        {
            game_object.visuals setmodel( level.gametypebundle.var_b8108e132d830f23.var_bf1a4751387ea118 );
        }
        
        return;
    }
    
    if ( game_utility_mp::is_defender_team( team_name ) )
    {
        if ( isdefined( level.gametypebundle.var_b8108e132d830f23.defenderflagmodel ) )
        {
            game_object.visuals setmodel( level.gametypebundle.var_b8108e132d830f23.defenderflagmodel );
        }
        
        return;
    }
    
    if ( isdefined( level.gametypebundle.var_b8108e132d830f23.var_834f51977cd32b4c ) )
    {
        game_object.visuals setmodel( level.gametypebundle.var_b8108e132d830f23.var_834f51977cd32b4c );
    }
}

// Namespace arena
// Params 1, eflags: 0x4
// Checksum 0x9650b72d, Offset: 0x16a9c
// Size: 0x275
function private function_33f70c8f18078c34( loadout_struct )
{
    out_struct = [];
    out_struct[ "loadoutPrimary" ] = loadout_struct.primary_weapon.var_7068c97ad157148;
    out_struct[ "loadoutPrimaryAttachment" ] = loadout_struct.primary_weapon.attachments[ 0 ];
    out_struct[ "loadoutPrimaryAttachment1" ] = loadout_struct.primary_weapon.attachments[ 1 ];
    out_struct[ "loadoutPrimaryAttachment2" ] = loadout_struct.primary_weapon.attachments[ 2 ];
    out_struct[ "loadoutPrimaryAttachment3" ] = loadout_struct.primary_weapon.attachments[ 3 ];
    out_struct[ "loadoutPrimaryAttachment4" ] = loadout_struct.primary_weapon.attachments[ 4 ];
    out_struct[ "loadoutPrimaryAttachment5" ] = loadout_struct.primary_weapon.attachments[ 5 ];
    out_struct[ "loadoutPrimaryCamo" ] = "camo_none";
    out_struct[ "loadoutPrimaryReticle" ] = "none";
    out_struct[ "loadoutPrimaryVariantID" ] = -1;
    out_struct[ "loadoutSecondary" ] = loadout_struct.secondary_weapon.var_7068c97ad157148;
    out_struct[ "loadoutSecondaryAttachment" ] = loadout_struct.secondary_weapon.attachments[ 0 ];
    out_struct[ "loadoutSecondaryAttachment1" ] = loadout_struct.secondary_weapon.attachments[ 1 ];
    out_struct[ "loadoutSecondaryAttachment2" ] = loadout_struct.secondary_weapon.attachments[ 2 ];
    out_struct[ "loadoutSecondaryAttachment3" ] = loadout_struct.secondary_weapon.attachments[ 3 ];
    out_struct[ "loadoutSecondaryAttachment4" ] = loadout_struct.secondary_weapon.attachments[ 4 ];
    out_struct[ "loadoutSecondaryAttachment5" ] = loadout_struct.secondary_weapon.attachments[ 5 ];
    out_struct[ "loadoutSecondaryCamo" ] = "camo_none";
    out_struct[ "loadoutSecondaryReticle" ] = "none";
    out_struct[ "loadoutSecondaryVariantID" ] = -1;
    out_struct[ "loadoutEquipmentPrimary" ] = loadout_struct.lethal_equipment_name;
    out_struct[ "loadoutEquipmentSecondary" ] = loadout_struct.tactical_equipment_name;
    out_struct[ "loadoutFieldUpgrade1" ] = "none";
    out_struct[ "loadoutFieldUpgrade2" ] = "none";
    out_struct[ "loadoutGesture" ] = "playerdata";
    out_struct[ "loadoutExecution" ] = "playerdata";
    return out_struct;
}

// Namespace arena
// Params 0, eflags: 0x4
// Checksum 0xd9ff6464, Offset: 0x16d1a
// Size: 0x2c2
function private cache_gunfight_loadouts()
{
    if ( !isdefined( game[ "arenaRandomLoadout" ] ) )
    {
        loadout_list = {};
        var_d47530f451155fac = !israndomarloadouts() && !israndomsmgloadouts() && !israndomlmgloadouts() && !israndompistolloadouts() && !israndomshotgunloadouts() && !israndomsniperloadouts();
        loadouts_needed = 1;
        var_a550a1c617f1deeb = int( level.winlimit * 2 - 1 );
        var_a9e52d8fb899eef6 = gunfight_loadouts::get_weapon_category_count();
        
        if ( level.loadoutchangeround > 0 )
        {
            loadouts_needed = int( var_a550a1c617f1deeb / level.loadoutchangeround );
        }
        
        if ( var_d47530f451155fac )
        {
            loadout_list = gunfight_loadouts::get_randomized_loadouts( min( loadouts_needed, var_a9e52d8fb899eef6 ) );
        }
        else if ( israndomarloadouts() )
        {
            loadout_list = gunfight_loadouts::get_randomized_loadouts( loadouts_needed, #"weapon_assault" );
        }
        else if ( israndomsmgloadouts() )
        {
            loadout_list = gunfight_loadouts::get_randomized_loadouts( loadouts_needed, #"weapon_smg" );
        }
        else if ( israndomlmgloadouts() )
        {
            loadout_list = gunfight_loadouts::get_randomized_loadouts( loadouts_needed, #"weapon_lmg" );
        }
        else if ( israndompistolloadouts() )
        {
            loadout_list = gunfight_loadouts::get_randomized_loadouts( loadouts_needed, #"weapon_pistol" );
        }
        else if ( israndomshotgunloadouts() )
        {
            loadout_list = gunfight_loadouts::get_randomized_loadouts( loadouts_needed, #"weapon_shotgun" );
        }
        else if ( israndomsniperloadouts() )
        {
            loadout_list = gunfight_loadouts::get_randomized_loadouts( loadouts_needed, #"weapon_sniper" );
        }
        
        if ( loadouts_needed > var_a9e52d8fb899eef6 )
        {
            loadout_index = 0;
            max_loadout_index = loadout_list.size;
            
            while ( loadout_list.size < max( loadouts_needed, var_a550a1c617f1deeb ) - 1 )
            {
                loadout_list[ loadout_list.size ] = loadout_list[ loadout_index ];
                loadout_index++;
                
                if ( loadout_index == max_loadout_index )
                {
                    loadout_index = 0;
                }
            }
        }
        
        foreach ( loadout_struct in loadout_list )
        {
            if ( !isdefined( game[ "arenaRandomLoadout" ] ) )
            {
                game[ "arenaRandomLoadout" ] = [];
            }
            
            game[ "arenaRandomLoadout" ][ game[ "arenaRandomLoadout" ].size ] = function_33f70c8f18078c34( loadout_struct );
        }
    }
    
    if ( game[ "roundsPlayed" ] == 0 || level.loadoutchangeround == 0 )
    {
        game[ "arenaRandomLoadoutIndex" ] = 0;
    }
    else
    {
        if ( should_change_loadouts() )
        {
            game[ "arenaRandomLoadoutIndex" ]++;
        }
        
        if ( game[ "arenaRandomLoadoutIndex" ] == game[ "arenaRandomLoadout" ].size )
        {
            game[ "arenaRandomLoadoutIndex" ] = 0;
        }
    }
    
    log_weapon_configurations();
}

// Namespace arena
// Params 0, eflags: 0x4
// Checksum 0xbf1faa0c, Offset: 0x16fe4
// Size: 0x16f
function private log_weapon_configurations()
{
    loadout_map = game[ "arenaRandomLoadout" ][ game[ "arenaRandomLoadoutIndex" ] ];
    primary_weapon_string = loadout_map[ "loadoutPrimary" ];
    secondary_weapon_string = loadout_map[ "loadoutSecondary" ];
    var_e30cb1eecd27de53 = "loadoutPrimaryAttachment";
    var_2a530ec5a72d8203 = "loadoutSecondaryAttachment";
    
    for ( i = 0; i < 6 ; i++ )
    {
        var_a0fef48c59af7fe5 = var_e30cb1eecd27de53;
        var_16ade1cf0fa26435 = var_2a530ec5a72d8203;
        
        if ( i > 0 )
        {
            var_a0fef48c59af7fe5 += i;
            var_16ade1cf0fa26435 += i;
        }
        
        if ( loadout_map[ var_a0fef48c59af7fe5 ] && loadout_map[ var_a0fef48c59af7fe5 ] != "none" )
        {
            primary_weapon_string += "+" + loadout_map[ var_a0fef48c59af7fe5 ];
        }
        
        if ( loadout_map[ var_16ade1cf0fa26435 ] && loadout_map[ var_16ade1cf0fa26435 ] != "none" )
        {
            secondary_weapon_string += "+" + loadout_map[ var_16ade1cf0fa26435 ];
        }
    }
    
    logstring( "[GUNFIGHT] " + "arena::log_weapon_configurations" + ": " + "Primary weapon     => " + primary_weapon_string );
    logstring( "[GUNFIGHT] " + "arena::log_weapon_configurations" + ": " + "Secondary weapon   => " + secondary_weapon_string );
    logstring( "[GUNFIGHT] " + "arena::log_weapon_configurations" + ": " + "Lethal equipment   => " + loadout_map[ "loadoutEquipmentPrimary" ] );
    logstring( "[GUNFIGHT] " + "arena::log_weapon_configurations" + ": " + "Tactical equipment => " + loadout_map[ "loadoutEquipmentSecondary" ] );
}

// Namespace arena
// Params 0, eflags: 0x4
// Checksum 0x418336e8, Offset: 0x1715b
// Size: 0x308
function private randomize_loadouts()
{
    var_7ddad6a2a8b2e3e3 = 0;
    cooldown_queue_size = 0;
    
    foreach ( loadout_array in game[ "arenaLoadouts" ] )
    {
        var_7ddad6a2a8b2e3e3 += loadout_array.size;
        cooldown_queue_size++;
    }
    
    var_29b4cbefc005dcd6 = getdvarint( @"hash_b77364959bed6834", 0 );
    
    if ( var_29b4cbefc005dcd6 > 0 )
    {
        cooldown_queue_size = var_29b4cbefc005dcd6;
    }
    
    weapon_categories = getweaponcategories();
    weapon_categories = arrayrandomize( weapon_categories );
    categories_to_remove = [];
    
    foreach ( var_fed5411ea4689cc7 in weapon_categories )
    {
        if ( !isdefined( game[ "arenaLoadouts" ][ var_fed5411ea4689cc7 ] ) )
        {
            categories_to_remove[ categories_to_remove.size ] = var_fed5411ea4689cc7;
            continue;
        }
        
        var_9903bc162ff277a2 = game[ "arenaLoadouts" ][ var_fed5411ea4689cc7 ].size;
        max_heap::push( #"hash_5c30529d22f41a52", var_fed5411ea4689cc7, var_9903bc162ff277a2 );
    }
    
    foreach ( var_fed5411ea4689cc7 in categories_to_remove )
    {
        weapon_categories = arrayremove( weapon_categories, var_fed5411ea4689cc7 );
    }
    
    var_5a66aec5c083cd9a = [];
    loadouts_array = arraycopy( game[ "arenaLoadouts" ] );
    var_1dffeecdd95b6b65 = utility::queue_create( cooldown_queue_size );
    
    while ( var_5a66aec5c083cd9a.size < var_7ddad6a2a8b2e3e3 )
    {
        if ( utility::queue_isfull( var_1dffeecdd95b6b65 ) || max_heap::is_empty( #"hash_5c30529d22f41a52" ) )
        {
            var_fed5411ea4689cc7 = utility::queue_peek( var_1dffeecdd95b6b65 );
            
            if ( !isdefined( var_fed5411ea4689cc7 ) )
            {
                break;
            }
            
            utility::queue_dequeue( var_1dffeecdd95b6b65 );
            max_heap::push( #"hash_5c30529d22f41a52", var_fed5411ea4689cc7, loadouts_array[ var_fed5411ea4689cc7 ].size );
        }
        
        var_fed5411ea4689cc7 = max_heap::pop( #"hash_5c30529d22f41a52" );
        random_index = 0;
        
        if ( loadouts_array[ var_fed5411ea4689cc7 ].size > 1 )
        {
            random_index = randomint( loadouts_array[ var_fed5411ea4689cc7 ].size );
        }
        
        loadout = loadouts_array[ var_fed5411ea4689cc7 ][ random_index ];
        loadouts_array[ var_fed5411ea4689cc7 ][ random_index ] = undefined;
        
        if ( isint( random_index ) )
        {
            function_cdc669dbc8ea2101( loadouts_array[ var_fed5411ea4689cc7 ] );
        }
        
        if ( !isdefined( var_5a66aec5c083cd9a ) )
        {
            var_5a66aec5c083cd9a = [];
        }
        
        var_5a66aec5c083cd9a[ var_5a66aec5c083cd9a.size ] = loadout;
        utility::queue_enqueue( var_1dffeecdd95b6b65, var_fed5411ea4689cc7 );
        
        if ( loadouts_array[ var_fed5411ea4689cc7 ].size == 0 )
        {
            loadouts_array[ var_fed5411ea4689cc7 ] = arraycopy( game[ "arenaLoadouts" ][ var_fed5411ea4689cc7 ] );
        }
    }
    
    return var_5a66aec5c083cd9a;
}

// Namespace arena
// Params 11, eflags: 0x4
// Checksum 0x36b0eaeb, Offset: 0x1746c
// Size: 0x131
function private build_weapon_configuration( var_7068c97ad157148, attachment_list, camo_name, var_cf3ac544f32edb69, var_eb9f90c52851b4d9, var_b564bd3528c99aaa, cosmetic_attachment_name, sticker_list, has_nvgs, var_2c9f85941400eb46, is_custom_weapon )
{
    weapon_object = weapon::buildweapon( var_7068c97ad157148, attachment_list, camo_name, var_cf3ac544f32edb69, var_eb9f90c52851b4d9, var_b564bd3528c99aaa, cosmetic_attachment_name, sticker_list, has_nvgs, var_2c9f85941400eb46, is_custom_weapon );
    
    /#
        foreach ( attachment_name in attachment_list )
        {
            if ( attachment_name == "<dev string:x737>" )
            {
                continue;
            }
            
            assert( arraycontains( weapon_object.attachments, attachment_name ), "<dev string:x73c>" + attachment_name + "<dev string:x74f>" + var_7068c97ad157148 + "<dev string:x75d>" );
        }
    #/
    
    return weapon_object;
}

// Namespace arena
// Params 0, eflags: 0x4
// Checksum 0x24800f64, Offset: 0x175a6
// Size: 0x5c, Type: bool
function private should_change_loadouts()
{
    if ( !isdefined( game[ "roundsPlayed" ] ) || game[ "roundsPlayed" ] == 0 )
    {
        return false;
    }
    
    if ( !isdefined( level.loadoutchangeround ) )
    {
        return false;
    }
    
    if ( level.multimatch ?? gameinstance::is_enabled() )
    {
        return gameinstance::function_472f835355b3cd1c();
    }
    
    return game[ "roundsPlayed" ] % level.loadoutchangeround == 0;
}

// Namespace arena
// Params 1, eflags: 0x4
// Checksum 0x2d019dd9, Offset: 0x1760b
// Size: 0x39, Type: bool
function private function_5e124ab7e49b58b3( params )
{
    if ( game_utility_mp::waslastround() )
    {
        return false;
    }
    
    if ( level.multimatch ?? gameinstance::is_enabled() )
    {
        return gameinstance::function_2c23a0e05668ac9d();
    }
    
    return should_change_loadouts();
}

// Namespace arena
// Params 1, eflags: 0x4
// Checksum 0xc3f90342, Offset: 0x1764d
// Size: 0x42
function private function_523209503e5f2b1f( params )
{
    if ( !isdefined( self.var_4966ac91e830beb3 ) )
    {
        self.var_4966ac91e830beb3 = [];
    }
    
    self.var_4966ac91e830beb3[ self.var_4966ac91e830beb3.size ] = params.ref;
}

// Namespace arena
// Params 1, eflags: 0x4
// Checksum 0xd4d92431, Offset: 0x17697
// Size: 0x37
function private ononeleftevent( team )
{
    lastplayer = game_utility_mp::getlastlivingplayer( team );
    lastplayer.laststanding = 1;
    lastplayer thread givelastonteamwarning();
}

// Namespace arena
// Params 0, eflags: 0x4
// Checksum 0x9b29f246, Offset: 0x176d6
// Size: 0x9e
function private givelastonteamwarning()
{
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    level thread battlechatter_mp::trysaylocalsound( self, #"bc_status_inform_last_one" );
    otherteam = team_utility::getotherteam( self.pers[ "team" ] );
    level thread hud_util::teamplayercardsplash( "last_teammate_alive_callout", self, self.pers[ "team" ] );
    level thread hud_util::teamplayercardsplash( "last_enemy_alive_callout", self, otherteam );
    level notify( #"last_alive", self );
    codcaster_utils::function_3038b6eafc46c037( 3, self.team, self getentitynumber() );
}

// Namespace arena
// Params 1, eflags: 0x4
// Checksum 0x4eb9c880, Offset: 0x1777c
// Size: 0x68
function private get_player_operator( class )
{
    loadout_index = self getplayerdata( level.var_6f9b00680ed002d8, "favoriteLoadoutIndex" );
    loot_id = self getplayerdata( self.loadoutdata, #"loadouts", loadout_index, #"selectedoperator", #"operatorlootid" );
    return loot::function_f54ecb89dfab8e8c( loot_id );
}

// Namespace arena
// Params 1, eflags: 0x4
// Checksum 0xdf5c73af, Offset: 0x177ed
// Size: 0x68
function private get_player_operator_skin( class )
{
    loadout_index = self getplayerdata( level.var_6f9b00680ed002d8, "favoriteLoadoutIndex" );
    loot_id = self getplayerdata( self.loadoutdata, #"loadouts", loadout_index, #"selectedoperator", #"skinlootid" );
    return loot::function_f54ecb89dfab8e8c( loot_id );
}

/#

    // Namespace arena
    // Params 0, eflags: 0x4
    // Checksum 0x635dd327, Offset: 0x1785e
    // Size: 0x225, Type: dev
    function private function_314cda4bacff3255()
    {
        level endon( #"game_ended" );
        setdvar( @"hash_886f8f08dbf3df5f", "<dev string:x321>" );
        
        while ( true )
        {
            waitframe();
            dvarvalue = getdvar( @"hash_886f8f08dbf3df5f" );
            
            if ( dvarvalue == "<dev string:x321>" )
            {
                continue;
            }
            
            setdvar( @"hash_886f8f08dbf3df5f", "<dev string:x321>" );
            tokens = strtok( dvarvalue, "<dev string:x75f>" );
            
            if ( !isdefined( tokens ) || tokens.size == 0 )
            {
                continue;
            }
            
            command = tokens[ 0 ];
            arglist = utility::array_slice( tokens, 1 );
            player = level.players[ 0 ];
            
            if ( !isdefined( player ) )
            {
                continue;
            }
            
            switch ( command )
            {
                case #"hash_358fc11dad418a55":
                    if ( arglist.size == 0 )
                    {
                        player notify( #"hash_28a13730ea30ed8b" );
                    }
                    else if ( arglist.size < 1 || int( arglist[ 0 ] ) < 1 )
                    {
                        iprintlnbold( "<dev string:x773>" );
                    }
                    else
                    {
                        thread function_cb775f1d3b325e75( player, int( arglist[ 0 ] ) );
                    }
                    
                    break;
                case #"hash_9d9755ce454b0010":
                    if ( arglist.size == 0 )
                    {
                        player notify( #"hash_f0a7571d1dba3c32" );
                        player notify( #"hash_8cf03021311ba657" );
                    }
                    else if ( arglist.size < 1 || int( arglist[ 0 ] ) < 1 )
                    {
                        iprintlnbold( "<dev string:x7b4>" );
                    }
                    else
                    {
                        thread function_3a61fc852980a683( player, int( arglist[ 0 ] ) );
                    }
                    
                    break;
                case #"hash_4db5d4970492f541":
                    if ( arglist.size == 0 )
                    {
                        player notify( #"hash_8cf03021311ba657" );
                    }
                    else if ( arglist.size < 2 || arglist[ 0 ] == "<dev string:x321>" || int( arglist[ 1 ] ) < 1 )
                    {
                        iprintlnbold( "<dev string:x7fe>" );
                    }
                    else
                    {
                        thread function_e02e3cecb832cd18( player, arglist[ 0 ], int( arglist[ 1 ] ) );
                    }
                    
                    break;
                default:
                    iprintlnbold( "<dev string:x83e>" + command );
                    break;
            }
        }
    }

    // Namespace arena
    // Params 2, eflags: 0x4
    // Checksum 0x451ab99c, Offset: 0x17a8b
    // Size: 0x143, Type: dev
    function private function_cb775f1d3b325e75( player, timeinterval )
    {
        level endon( #"game_ended" );
        player endon( #"death_or_disconnect" );
        player notify( #"hash_28a13730ea30ed8b" );
        player endon( #"hash_28a13730ea30ed8b" );
        
        if ( !isdefined( game[ "<dev string:x259>" ] ) )
        {
            utility::error( "<dev string:x850>" );
            return;
        }
        
        level.perks_suppressasserts = 1;
        thread function_a27f07d4e84afc98( player, "<dev string:x883>", player.pers[ "<dev string:x89f>" ] );
        
        foreach ( loadout in game[ "<dev string:x259>" ] )
        {
            player.pers[ "<dev string:x89f>" ] = loadout;
            player class::giveloadout( player.team, "<dev string:x8af>" );
            wait timeinterval;
        }
        
        player notify( #"hash_28a13730ea30ed8b" );
        level.perks_suppressasserts = 0;
    }

    // Namespace arena
    // Params 2, eflags: 0x4
    // Checksum 0x1e8afe6c, Offset: 0x17bd6
    // Size: 0xe8, Type: dev
    function private function_3a61fc852980a683( player, timeinterval )
    {
        level endon( #"game_ended" );
        player endon( #"death_or_disconnect" );
        player notify( #"hash_f0a7571d1dba3c32" );
        player endon( #"hash_f0a7571d1dba3c32" );
        
        if ( !isdefined( game[ "<dev string:x8b8>" ] ) )
        {
            utility::error( "<dev string:x8c5>" );
            return;
        }
        
        foreach ( weapon in game[ "<dev string:x8b8>" ] )
        {
            function_e02e3cecb832cd18( player, weapon.rootname, timeinterval );
        }
    }

    // Namespace arena
    // Params 3, eflags: 0x4
    // Checksum 0xd5d8d000, Offset: 0x17cc6
    // Size: 0x141, Type: dev
    function private function_e02e3cecb832cd18( player, weaponname, timeinterval )
    {
        level endon( #"game_ended" );
        player endon( #"death_or_disconnect" );
        player notify( #"hash_8cf03021311ba657" );
        player endon( #"hash_8cf03021311ba657" );
        
        if ( !isdefined( game[ "<dev string:x8b8>" ] ) )
        {
            utility::error( "<dev string:x913>" );
            return;
        }
        
        weapon = game[ "<dev string:x8b8>" ][ weaponname ];
        
        if ( !isdefined( weapon ) )
        {
            utility::error( "<dev string:x964>" );
            return;
        }
        
        primaryweaponobject = player.primaryweaponobj;
        player inventory_utility::_takeweapon( primaryweaponobject );
        thread function_985a99c4b354ecfc( player, "<dev string:x997>", primaryweaponobject );
        
        for ( i = 0; i < weapon.blueprints.size ; i++ )
        {
            weaponobject = weapon::giveweaponblueprint( weaponname, weapon.blueprints[ i ].id );
            player inventory_utility::_giveweapon( weaponobject );
            player inventory_utility::_switchtoweaponimmediate( weaponobject );
            wait timeinterval;
            player inventory_utility::_takeweapon( weaponobject );
        }
        
        player notify( #"hash_8cf03021311ba657" );
    }

    // Namespace arena
    // Params 3, eflags: 0x4
    // Checksum 0xc9fd944f, Offset: 0x17e0f
    // Size: 0x6d, Type: dev
    function private function_a27f07d4e84afc98( player, notifystring, loadout )
    {
        level endon( #"game_ended" );
        player endon( #"death_or_disconnect" );
        player waittill( notifystring );
        player.pers[ "<dev string:x89f>" ] = loadout;
        player class::giveloadout( player.team, "<dev string:x8af>" );
    }

    // Namespace arena
    // Params 3, eflags: 0x4
    // Checksum 0x30dbde7a, Offset: 0x17e84
    // Size: 0x54, Type: dev
    function private function_985a99c4b354ecfc( player, notifystring, weaponobject )
    {
        level endon( #"game_ended" );
        player endon( #"death_or_disconnect" );
        player waittill( notifystring );
        player inventory_utility::_giveweapon( weaponobject );
        player inventory_utility::_switchtoweaponimmediate( weaponobject );
    }

#/
