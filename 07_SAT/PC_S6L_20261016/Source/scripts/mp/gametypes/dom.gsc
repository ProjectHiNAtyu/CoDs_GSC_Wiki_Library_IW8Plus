// scripts\mp\gametypes\dom.gsc  (hash_2dc3a143158cec7c.gscc) (size: 59562 Bytes / 0xe8aa / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x5e224ba3 (1579305891)
// size ...... 59562 (0xe8aa)
// includes .. 52  (offset: 0xd99e)
// strings ... 165 (offset: 0xdb3e)
// dev strs .. 26  (offset: 0xe712)
// exports ... 105 (offset: 0x98ce)
// cseg ...... 0xc5e + 0x8c70 (0x98ce)
// imports ... 375 (offset: 0xa936)
// animtree1 . 0   (offset: 0xe8aa)
// animtree2 . 0   (offset: 0xe8aa)
#using script_382bf8d77c4fd348;
#using script_6800334345ed1df0;
#using scripts\common\callback_sequence;
#using scripts\common\callbacks;
#using scripts\common\gameplay_sound_fx;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\weapon;
#using scripts\mp\action_park_utility;
#using scripts\mp\agents\agent_utils;
#using scripts\mp\ai_behavior;
#using scripts\mp\ai_mp_controller;
#using scripts\mp\bots\bots;
#using scripts\mp\challenges;
#using scripts\mp\codcasterclientmatchdata;
#using scripts\mp\common\equipment\smoke_grenade;
#using scripts\mp\common\gameobjects\gameobjects_common;
#using scripts\mp\common\gameobjects\gameobjects_shared;
#using scripts\mp\common\utility\audio_utility;
#using scripts\mp\common\utility\dialog;
#using scripts\mp\common\utility\dialog_utility;
#using scripts\mp\common\utility\dvars;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\stats;
#using scripts\mp\common\utility\team_utility;
#using scripts\mp\common\utility\teams;
#using scripts\mp\events;
#using scripts\mp\flags;
#using scripts\mp\gameinstance;
#using scripts\mp\gamelogic;
#using scripts\mp\gameobjects;
#using scripts\mp\gamescore;
#using scripts\mp\gametypes\bradley_spawner;
#using scripts\mp\gametypes\common;
#using scripts\mp\gametypes\koth;
#using scripts\mp\gametypes\obj_dom;
#using scripts\mp\globallogic;
#using scripts\mp\hostmigration;
#using scripts\mp\hud_message;
#using scripts\mp\hud_util;
#using scripts\mp\matchdata;
#using scripts\mp\objectiveiconstates;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\persistence;
#using scripts\mp\rank;
#using scripts\mp\spawncamera;
#using scripts\mp\spawnfactor;
#using scripts\mp\spawnlogic;
#using scripts\mp\spawnselection;

#namespace dom;

// Namespace dom
// Params 0, eflags: 0x5
// Checksum 0xfa5d9b89, Offset: 0xc7c
// Size: 0xb
function private autoexec __autoexec__()
{
    game[ "dom" ] = {};
}

// Namespace dom
// Params 0
// Checksum 0xfb04937d, Offset: 0xc8f
// Size: 0x3a5
function main()
{
    logstring( "[DOM] Dom main" );
    
    if ( getdvar( @"g_mapname" ) == "mp_background" )
    {
        return;
    }
    
    globallogic::init();
    globallogic::setupcallbacks();
    level.dominationdata = game_utility_mp::function_4b7180ed8c2e9742( "gametypebundle_dom" );
    level.usestrongholdhills = dvars::dvarintvalue( "useStrongholdHills", 0, 0, 1 );
    level.initializematchrules = &initializematchrules;
    [[ level.initializematchrules ]]();
    level thread game_utility_mp::reinitializematchrulesonmigration();
    updategametypedvars();
    callback::add( #"player_spawned", &onspawnplayer );
    callback::add( #"hash_244314ef9125e636", &function_8314535b81f548e );
    level.teambased = 1;
    level.onstartgametype = &onstartgametype;
    level.onplayerconnect = &onplayerconnect;
    level.getspawnpoint = &getspawnpoint;
    level.lastcaptime = gettime();
    level.onobjectivecomplete = &onflagcapture;
    level.onmaprestart = &function_714ea0cd90e374f;
    level.var_813f2ea1f9452bdb = &function_bf5ce447871fe026;
    level.var_6acc53d8aaa7d1e3 = &function_420eaefd3e54cba9;
    level.var_c18eb83275e643e7 = &function_c18eb83275e643e7;
    level.checkcustomclosetoscorelimit = &checkcustomclosetoscorelimit;
    level.var_e56cac0580f1c92c = level.flagcapturetime * 0.5;
    
    if ( utility::issharedfuncdefined( #"hash_12eb2ef3dcc95127", #"hash_4adc6144c2cf7283" ) )
    {
        utility::callsharedfunc( #"hash_12eb2ef3dcc95127", #"hash_4adc6144c2cf7283" );
    }
    else if ( level.numflagsscoreonkill > 0 )
    {
        level.teamscoresonkill = [];
        level.onnormaldeath = &onnormaldeath;
    }
    
    /#
        level.domflag_setneutral = &obj_dom::domflag_setneutral;
        level.dompoint_setcaptured = &obj_dom::dompoint_setcaptured;
        level.onflagcapture = &onflagcapture;
    #/
    
    if ( isdefined( level.gametypebundle.var_ae100eea97c7fcc7[ #"hash_14bb716c4b77c45a" ] ) )
    {
        var_24290c36e2cab388 = { #manual_drop:1, #var_7f4958ce4e4277c3:#"hash_bb332da19f9944df", #capture_segment_count:1, #var_333d3689d793bcc7:0, #use_time_seconds:0, #var_c68e9f43ed9cc918:#"hash_a1360b18943e920", #var_d7c90dc73c1dcba8:( 0, 0, 0 ), #objective_icon_offset:( 0, 0, 0 ), #angles:( 0, 0, 0 ), #origin:( 0, 0, 0 ) };
        var_24290c36e2cab388.use_time_seconds = level.flagcapturetime;
        var_24290c36e2cab388.var_333d3689d793bcc7 = level.var_e56cac0580f1c92c;
        level function_15998450eea7cbc7();
        
        if ( level.var_6d9bd8977e47e1a8 == "domflag" )
        {
            gameobjects_common::function_22117b1fd559026f( "domflag", var_24290c36e2cab388, &function_b9c14b5797567dc7 );
        }
    }
    else
    {
        if ( level.usestrongholdhills )
        {
            allowed[ 0 ] = "hardpoint";
        }
        else
        {
            allowed[ 0 ] = game_utility::getgametype();
        }
        
        if ( game_utility::function_ae97372c83da7acc() )
        {
            allowed[ 0 ] = game_utility_mp::getbasegametype();
        }
        
        gameobjects::main( allowed );
    }
    
    level.var_40cd999d911308e0 = &game_utility_mp::function_abefb3841cda328e;
    level.var_e16ef107a3dd572b = &game_utility_mp::function_90ed3e9fed444ef5;
    level.var_40ab710579539b1 = &game_utility_mp::function_daab43ec23b14d5c;
    
    if ( getgametypenamekey() == "dom_sg" )
    {
        level thread function_5b9514e060bb4725();
    }
    
    level.playholdtwovo = 0;
}

// Namespace dom
// Params 0
// Checksum 0xa9f77ba8, Offset: 0x103c
// Size: 0x1b
function function_5b9514e060bb4725()
{
    level endon( #"game_ended" );
    waittillframeend();
    audio_utility::snd_transient_load( "mp_gametype_stopgo_t10" );
}

// Namespace dom
// Params 0
// Checksum 0xd9015c00, Offset: 0x105f
// Size: 0x27f
function initializematchrules()
{
    game_utility_mp::setcommonrulesfrommatchrulesdata();
    level.blockcapdisabled = getmatchrulesdata( "domData", "flagblockcapdisabled" ) ?? 0;
    level.flagcapturetime = getmatchrulesdata( "domData", "flagCaptureTime" ) ?? 10;
    level.flagdecaytime = getmatchrulesdata( "domData", "flagDecayTime" ) ?? 0;
    level.flagreinforcement = getmatchrulesdata( "domData", "flagReinforcement" ) ?? 0;
    level.flagmodelhidden = getmatchrulesdata( "domData", "flagModelHidden" ) ?? 0;
    level.flagneutralization = getmatchrulesdata( "domData", "flagNeutralization" ) ?? 0;
    level.flagsrequiredtoscore = getmatchrulesdata( "domData", "flagsRequiredToScore" ) ?? 1;
    level.numflagsscoreonkill = getmatchrulesdata( "domData", "numFlagsScoreOnKill" ) ?? 0;
    level.objectivescaler = getmatchrulesdata( "domData", "objScalar" ) ?? 4;
    level.pointsperflag = getmatchrulesdata( "domData", "pointsPerFlag" ) ?? 1;
    level.pointsperreinforcedflag = getmatchrulesdata( "domData", "pointsPerReinforcedFlag" ) ?? 0;
    level.reinforcementstompscalar = getmatchrulesdata( "domData", "reinforcementStompScalar" ) ?? 1;
    level.shufflehillroundcount = getmatchrulesdata( "domData", "shuffleHillRoundCount" ) ?? 2;
    level.strongholdscoreallcapincrement = getmatchrulesdata( "domData", "strongholdScoreAllCapIncrement" ) ?? 2;
    level.strongholdscoreincrement = getmatchrulesdata( "domData", "strongholdScoreIncrement" ) ?? 1;
    level.strongholdscoreinterval = getmatchrulesdata( "domData", "strongholdScoreInterval" ) ?? 1;
    level.usestrongholdscoring = getmatchrulesdata( "domData", "useStrongholdScoring" ) ?? 0;
    level.precappoints = getmatchrulesdata( "siegeData", "preCapPoints" ) ?? 0;
    level.capturetype = getmatchrulesdata( "captureData", "captureType" ) ?? 1;
    level.capturedecay = getmatchrulesdata( "captureData", "captureDecay" ) ?? 1;
    level.disablemajoritycapprogress = getmatchrulesdata( "controlData", "disableMajorityCapProgress" ) ?? 0;
    
    if ( utility::issharedfuncdefined( #"hash_12eb2ef3dcc95127", #"hash_f06070ee61d480db" ) )
    {
        utility::callsharedfunc( #"hash_12eb2ef3dcc95127", #"hash_f06070ee61d480db" );
    }
}

// Namespace dom
// Params 0
// Checksum 0x7a41f0e0, Offset: 0x12e6
// Size: 0x8e
function seticonnames()
{
    level.icontarget = "waypoint_dom_target";
    level.iconneutral = "waypoint_captureneutral";
    level.iconcapture = "waypoint_capture";
    level.icondefend = "waypoint_defend";
    level.icondefending = "waypoint_defending";
    level.iconcontested = "waypoint_contested";
    level.icontaking = "waypoint_taking";
    level.iconlosing = "waypoint_losing";
    level.iconclearing = "waypoint_clearing";
    level.iconreinforcing = "waypoint_reinforcing";
}

// Namespace dom
// Params 1
// Checksum 0xb53b5d51, Offset: 0x137c
// Size: 0x7d
function function_37ea0cadc6e9022a( objkey )
{
    switch ( objkey )
    {
        case #"hash_fac2c5f6bddd49bd":
            return 3;
        case #"hash_fac2c2f6bddd4504":
            return 5;
        case #"hash_fac2c3f6bddd4697":
            return 7;
        case #"hash_fac2c0f6bddd41de":
            return 8;
        case #"hash_fac2c1f6bddd4371":
            return 9;
        case #"hash_fac2bef6bddd3eb8":
            return 25;
        default:
            return;
    }
}

// Namespace dom
// Params 1
// Checksum 0x69917be6, Offset: 0x1401
// Size: 0x6d
function function_ecc6f580f99fa4f4( objkey )
{
    switch ( objkey )
    {
        case #"hash_fac2c5f6bddd49bd":
            return 0;
        case #"hash_fac2c2f6bddd4504":
            return 1;
        case #"hash_fac2c3f6bddd4697":
            return 2;
        case #"hash_fac2c0f6bddd41de":
            return 3;
        case #"hash_fac2c1f6bddd4371":
            return 4;
        default:
            return;
    }
}

// Namespace dom
// Params 0
// Checksum 0x1f2f7c5f, Offset: 0x1476
// Size: 0xce
function function_15998450eea7cbc7()
{
    gameobjectsbundle = game_utility_mp::function_4b7180ed8c2e9742( #"hash_14bb716c4b77c45a" );
    
    foreach ( gameobjectdef in gameobjectsbundle.list )
    {
        if ( gameobjectdef.variant_type == "Types_CaptureZoneDefinition" )
        {
            level.var_6d9bd8977e47e1a8 = gameobjectdef.variant_object.var_80258cc5fb500cc8;
            return;
        }
    }
    
    level.var_6d9bd8977e47e1a8 = "domflag";
}

// Namespace dom
// Params 0
// Checksum 0xa13635e1, Offset: 0x154c
// Size: 0x36d
function setwaypoints()
{
    var_e1a478a31edb8885 = 0;
    
    foreach ( objectivekey, obj in level.objectives )
    {
        iconid = function_37ea0cadc6e9022a( objectivekey );
        iconimage = "icon_waypoint_dom" + objectivekey;
        var_58d1e2130b069e62 = function_ecc6f580f99fa4f4( objectivekey );
        
        if ( isdefined( level.gametypebundle ) && isdefined( level.gametypebundle.var_f4393a5b1d902a05 ) && isdefined( level.gametypebundle.var_f4393a5b1d902a05[ var_58d1e2130b069e62 ].objectiveicon ) && level.gametypebundle.var_f4393a5b1d902a05[ var_58d1e2130b069e62 ].objectiveicon != %"" )
        {
            iconimage = level.gametypebundle.var_f4393a5b1d902a05[ var_58d1e2130b069e62 ].objectiveicon;
        }
        
        gamelogic_mp::setwaypointiconinfo( "icon_waypoint_dom" + objectivekey, var_e1a478a31edb8885, "neutral", &"MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", iconimage, 0, iconid );
        gamelogic_mp::setwaypointiconinfo( "waypoint_taking" + objectivekey, var_e1a478a31edb8885, "friendly", &"MP_INGAME_ONLY/OBJ_CAPTURING_CAPS", iconimage, 1, iconid );
        gamelogic_mp::setwaypointiconinfo( "waypoint_capture" + objectivekey, var_e1a478a31edb8885, "enemy", &"MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", iconimage, 0, iconid );
        gamelogic_mp::setwaypointiconinfo( "waypoint_defend" + objectivekey, var_e1a478a31edb8885, "friendly", &"MP_INGAME_ONLY/OBJ_DEFEND_CAPS", iconimage, 0, iconid );
        gamelogic_mp::setwaypointiconinfo( "waypoint_defending" + objectivekey, var_e1a478a31edb8885, "friendly", &"MP_INGAME_ONLY/OBJ_DEFENDING_CAPS", iconimage, 0, iconid );
        gamelogic_mp::setwaypointiconinfo( "waypoint_blocking" + objectivekey, var_e1a478a31edb8885, "friendly", &"MP_INGAME_ONLY/OBJ_BLOCKING_CAPS", iconimage, 1, iconid );
        gamelogic_mp::setwaypointiconinfo( "waypoint_blocked" + objectivekey, var_e1a478a31edb8885, "friendly", &"MP_INGAME_ONLY/OBJ_BLOCKED_CAPS", iconimage, 1, iconid );
        gamelogic_mp::setwaypointiconinfo( "waypoint_losing" + objectivekey, var_e1a478a31edb8885, "enemy", &"MP_INGAME_ONLY/OBJ_LOSING_CAPS", iconimage, 1, iconid );
        gamelogic_mp::setwaypointiconinfo( "waypoint_captureneutral" + objectivekey, var_e1a478a31edb8885, "neutral", &"MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", iconimage, 0, iconid );
        gamelogic_mp::setwaypointiconinfo( "waypoint_contested" + objectivekey, var_e1a478a31edb8885, "contest", &"MP_INGAME_ONLY/OBJ_CONTESTED_CAPS", iconimage, 1, iconid );
        gamelogic_mp::setwaypointiconinfo( "waypoint_dom_target" + objectivekey, var_e1a478a31edb8885, "neutral", &"MP_INGAME_ONLY/OBJ_TARGET_CAPS", iconimage, 0, iconid );
        gamelogic_mp::setwaypointiconinfo( "waypoint_clearing" + objectivekey, var_e1a478a31edb8885, "friendly", &"MP_INGAME_ONLY/OBJ_CLEARING_CAPS", iconimage, 1, iconid );
        gamelogic_mp::setwaypointiconinfo( "waypoint_reinforcing" + objectivekey, var_e1a478a31edb8885, "friendly", &"MP_INGAME_ONLY/OBJ_REINFORCING_CAPS", iconimage, 1, iconid );
        gamelogic_mp::setwaypointiconinfo( "waypoint_locked" + objectivekey, var_e1a478a31edb8885, "neutral", &"MP_INGAME_ONLY/OBJ_LOCKED_CAPS", "icon_waypoint_locked", 0, iconid );
    }
    
    gamelogic_mp::setwaypointiconinfo( "icon_waypoint_dom_captured", var_e1a478a31edb8885, "codcaster", "", "esports_codcaster_minimap_checkmark", 0, 11 );
}

// Namespace dom
// Params 0
// Checksum 0x27cf6d77, Offset: 0x18c1
// Size: 0x259
function onstartgametype()
{
    logstring( "[DOM] Dom start gametype" );
    
    foreach ( entry in level.teamnamelist )
    {
        if ( isdefined( level.teamscoresonkill ) )
        {
            level.teamscoresonkill[ entry ] = level.precappoints >= level.numflagsscoreonkill && level.precappoints >= level.flagsrequiredtoscore;
        }
        
        game_utility_mp::setobjectivetext( entry, &"objectives/dom" );
        
        if ( level.splitscreen )
        {
            game_utility_mp::setobjectivescoretext( entry, &"objectives/dom" );
        }
        else
        {
            game_utility_mp::setobjectivescoretext( entry, &"objectives/dom_score" );
        }
        
        game_utility_mp::setobjectivehinttext( entry, &"objectives/dom_hint" );
    }
    
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
    
    initspawns();
    
    if ( isdefined( level.gametypebundle.var_ae100eea97c7fcc7[ #"hash_14bb716c4b77c45a" ] ) )
    {
        utility::flag_wait( "gameobject_system_post_init" );
        
        if ( istrue( level.game_objects.var_5f329cd264226f08 ) )
        {
            logstring( "[DOM] Constructing CS game objects" );
            utility::flag_wait( "cs_gameobjects_constructed" );
        }
        else
        {
            function_641684784f5044ff();
            waitframe();
        }
    }
    
    thread domflags();
    
    if ( !function_d1e292f023f6cfc9() )
    {
        thread updatedomscores();
    }
    
    seticonnames();
    setwaypoints();
    
    /#
        thread function_7f317007253a6058();
        thread removedompoint();
        thread placedompoint();
    #/
    
    bradley_spawner::inittankspawns();
    
    if ( utility::issharedfuncdefined( #"hash_12eb2ef3dcc95127", #"hash_96b2e1747e0de2c3" ) )
    {
        utility::callsharedfunc( #"hash_12eb2ef3dcc95127", #"hash_96b2e1747e0de2c3" );
    }
}

// Namespace dom
// Params 0
// Checksum 0xebce43db, Offset: 0x1b22
// Size: 0x4b, Type: bool
function function_bf5ce447871fe026()
{
    if ( level.scoremod[ "kill" ] > 0 && dialog_utility::dialogueexists( #"boost_groundwar", self.team ) )
    {
        dialog::leaderdialogonplayer( #"boost_groundwar", "introboost" );
        return true;
    }
    
    return false;
}

// Namespace dom
// Params 1
// Checksum 0x4d5e6514, Offset: 0x1b76
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

// Namespace dom
// Params 0
// Checksum 0x1154d968, Offset: 0x1be5
// Size: 0x3d
function updategametypedvars()
{
    common::updatecommongametypedvars();
    
    if ( utility::issharedfuncdefined( #"hash_12eb2ef3dcc95127", #"hash_af791a0f7c476717" ) )
    {
        utility::callsharedfunc( #"hash_12eb2ef3dcc95127", #"hash_af791a0f7c476717" );
    }
}

// Namespace dom
// Params 0
// Checksum 0x8f3baefb, Offset: 0x1c2a
// Size: 0x272
function initspawns()
{
    spawnlogic::setactivespawnlogic( #"default" );
    spawnlogic::function_6dbabb72223a4bca();
    spawnkey = spawnlogic::function_d5c160a4110b573e();
    
    if ( spawnlogic::function_5cf82e30c52a895d( spawnkey ) )
    {
        spawnlogic::function_3a25709674572ad6( #"start", #"start_attackers", spawnkey, spawnlogic::function_61ba521db28762a7(), game[ "attackers" ], 1 );
        spawnlogic::function_3a25709674572ad6( #"start", #"start_defenders", spawnkey, spawnlogic::function_3a5e3efa19e5df47(), game[ "defenders" ], 1 );
        spawnlogic::function_67ed482196f59838( #"fallback", #"fallback", spawnkey, "fallback", 1 );
        valuekeys = [ "zoneA", "zoneB", "zoneC", "zoneD", "zoneE" ];
        listkeys = [ #"zonea", #"zoneb", #"zonec", #"zoned", #"zonee" ];
        spawnlogic::function_7249b22d6697ea46( #"primary", #"primary", listkeys, spawnkey, "spawn", valuekeys );
    }
    else
    {
        spawnlogic::function_9bd2654564d3372d( #"start", #"start_attackers", "mp_dom_spawn_allies_start", game[ "attackers" ] );
        spawnlogic::function_9bd2654564d3372d( #"start", #"start_defenders", "mp_dom_spawn_axis_start", game[ "defenders" ] );
        spawnlogic::function_17e08e497a9b4136( #"primary", #"primary", "mp_dom_spawn" );
        spawnlogic::function_17e08e497a9b4136( #"fallback", #"fallback", "mp_dom_spawn_secondary", 1 );
    }
    
    if ( spawnselection::function_fc43ecf617088f49() )
    {
        level.gamemodestartspawnpointnames = [];
        level.gamemodestartspawnpointnames[ game[ "attackers" ] ] = "mp_dom_spawn_allies_start";
        level.gamemodestartspawnpointnames[ game[ "defenders" ] ] = "mp_dom_spawn_axis_start";
        level.gamemodespawnpointnames = [];
        level.gamemodespawnpointnames[ game[ "attackers" ] ] = "mp_dom_spawn";
        level.gamemodespawnpointnames[ game[ "defenders" ] ] = "mp_dom_spawn";
    }
    
    level.var_c76086bc0fa0cdfa = spawnfactor::usingfactor( "preferDomPoints" );
    spawnlogic::finalizemap();
}

// Namespace dom
// Params 0
// Checksum 0xb96c3d13, Offset: 0x1ea4
// Size: 0xa4
function getspawnpoint()
{
    if ( level.var_c76086bc0fa0cdfa )
    {
        spawnteam = self.pers[ "team" ];
        teamdompoints = getteamdompoints( spawnteam );
        enemyteam = team_utility::getotherteam( spawnteam );
        var_1aeb62419a4ccf2d = getteamdompoints( enemyteam );
        flaggroups = getpreferreddompoints( teamdompoints, var_1aeb62419a4ccf2d, spawnteam, enemyteam );
        var_5604c97df7f05c1b = spawnfactor::function_6ee12c1c8b06235e( flaggroups[ "preferred" ], flaggroups[ "secondary" ] );
        return spawnlogic::function_3f9d5fcfb93d4190( self, var_5604c97df7f05c1b );
    }
    
    return spawnlogic::function_3f9d5fcfb93d4190( self );
}

// Namespace dom
// Params 1
// Checksum 0x349550f1, Offset: 0x1f51
// Size: 0xa9
function getteamdompoints( team )
{
    teamdompoints = [];
    
    foreach ( dompoint in level.objectives )
    {
        owningteam = gameobjects_shared::function_623b07f4735aecb2( dompoint );
        
        if ( owningteam == team )
        {
            teamdompoints[ teamdompoints.size ] = dompoint;
        }
    }
    
    return teamdompoints;
}

// Namespace dom
// Params 4
// Checksum 0x61ea25b1, Offset: 0x2003
// Size: 0x2da
function getpreferreddompoints( teamdompoints, var_1aeb62419a4ccf2d, team, enemyteam )
{
    var_be29eb2f2717d482 = [];
    
    if ( teamdompoints.size == level.objectives.size )
    {
        enemyspawnflag = level.bestspawnflag[ enemyteam ];
        
        foreach ( flag in teamdompoints )
        {
            if ( flag != enemyspawnflag )
            {
                var_be29eb2f2717d482[ var_be29eb2f2717d482.size ] = flag;
            }
        }
    }
    else if ( teamdompoints.size > 0 )
    {
        foreach ( flag in teamdompoints )
        {
            var_be29eb2f2717d482[ var_be29eb2f2717d482.size ] = flag;
        }
    }
    else if ( teamdompoints.size == 0 )
    {
        var_8ba8b04fdd001d1c = level.bestspawnflag[ team ];
        
        if ( var_1aeb62419a4ccf2d.size > 0 && var_1aeb62419a4ccf2d.size < level.objectives.size )
        {
            if ( isdefined( level.gametypebundle.var_ae100eea97c7fcc7[ #"hash_14bb716c4b77c45a" ] ) )
            {
                var_8ba8b04fdd001d1c = function_d82fa675e7fef8dd( team, undefined );
            }
            else
            {
                var_8ba8b04fdd001d1c = obj_dom::getunownedflagneareststart( team );
            }
        }
        
        var_be29eb2f2717d482[ var_be29eb2f2717d482.size ] = var_8ba8b04fdd001d1c;
    }
    
    preferreddompoints = 0;
    secondarydompoints = 0;
    
    foreach ( flag in var_be29eb2f2717d482 )
    {
        claimteam = gameobjects_shared::function_d071a38f7d43555a( flag );
        
        if ( claimteam == "none" )
        {
            preferreddompoints |= flag.spawnflagid;
            continue;
        }
        
        secondarydompoints |= flag.spawnflagid;
    }
    
    if ( preferreddompoints & 1 && preferreddompoints & 2 )
    {
        preferreddompoints |= 32;
    }
    
    if ( preferreddompoints & 4 && preferreddompoints & 2 )
    {
        preferreddompoints |= 64;
    }
    
    if ( preferreddompoints & 1 && preferreddompoints & 4 )
    {
        preferreddompoints |= 128;
    }
    
    flaggroups = [];
    flaggroups[ "preferred" ] = preferreddompoints;
    flaggroups[ "secondary" ] = secondarydompoints;
    return flaggroups;
}

// Namespace dom
// Params 1
// Checksum 0xeec63e20, Offset: 0x22e6
// Size: 0x84
function function_f50657ad4f7ae9f6( objectivekey )
{
    switch ( objectivekey )
    {
        case #"hash_fac2c5f6bddd49bd":
            return #"zonea";
        case #"hash_fac2c2f6bddd4504":
            return #"zoneb";
        case #"hash_fac2c3f6bddd4697":
            return #"zonec";
        case #"hash_fac2c0f6bddd41de":
            return #"zoned";
        case #"hash_fac2c1f6bddd4371":
            return #"zonee";
    }
}

// Namespace dom
// Params 0
// Checksum 0x1e9c46cf, Offset: 0x2373
// Size: 0x40
function function_1ddaa0d7494f5ae3()
{
    spawn_set = function_f50657ad4f7ae9f6( self.objectivekey );
    spawn_points = spawnlogic::getspawnset( spawn_set );
    
    if ( spawn_points.size )
    {
        self.spawnset = spawn_set;
    }
}

// Namespace dom
// Params 0
// Checksum 0x9d6acebb, Offset: 0x23bb
// Size: 0x4d
function function_b2690b27d6bc7526()
{
    self.influencerkeys[ "owner" ] = #"gametype_dom_owner_team";
    self.influencerkeys[ "other" ] = #"gametype_dom_other_team";
    self.influencerkeys[ "neutral" ] = #"gametype_dom_other_team";
}

// Namespace dom
// Params 0
// Checksum 0x861739d2, Offset: 0x2410
// Size: 0xb84
function domflags()
{
    if ( isdefined( level.gametypebundle.var_ae100eea97c7fcc7[ #"hash_14bb716c4b77c45a" ] ) )
    {
        spawngroup = spawnlogic::function_1f5152a92aada360( #"start" ) ? #"start" : #"primary";
        spawn_attackers = spawnlogic::function_f89ebff0bfb8555( spawngroup, game[ "attackers" ] );
        spawn_defenders = spawnlogic::function_f89ebff0bfb8555( spawngroup, game[ "defenders" ] );
        level.startpos[ game[ "attackers" ] ] = spawn_attackers[ 0 ].origin;
        level.startpos[ game[ "defenders" ] ] = spawn_defenders[ 0 ].origin;
        level.bestspawnflag = [];
        level.bestspawnflag[ game[ "attackers" ] ] = function_d82fa675e7fef8dd( game[ "attackers" ], undefined );
        level.bestspawnflag[ game[ "defenders" ] ] = function_d82fa675e7fef8dd( game[ "defenders" ], level.bestspawnflag[ game[ "attackers" ] ] );
        flagsetup();
        
        if ( !flags::gameflag( "prematch_done" ) )
        {
            level utility::waittill_any( "prematch_done", "start_mode_setup" );
        }
        
        foreach ( flag in level.objectives )
        {
            function_49148839963426f0( flag );
            function_b108a7e40cb063c1( flag );
        }
        
        if ( level.codcasterenabled )
        {
            thread updatetriggerforcodcaster();
        }
        
        /#
            thread domdebug();
        #/
        
        return;
    }
    
    primaryflags = [];
    secondaryflags = [];
    level.changenumdomflags = 0;
    
    if ( level.usestrongholdhills )
    {
        allflags = koth::getzonearray( "hardpoint_zone" );
        
        if ( !isdefined( game[ "strongholdFlagKeys" ] ) || level.shufflehillroundcount > 0 && game[ "roundsPlayed" ] % level.shufflehillroundcount == 0 )
        {
            tempflags = allflags;
            
            if ( isdefined( game[ "strongholdFlagKeys" ] ) )
            {
                removecount = randomintrange( 0, tempflags.size - game[ "strongholdFlagKeys" ].size );
                
                while ( removecount > 0 )
                {
                    randomflag = game[ "strongholdFlagKeys" ][ randomint( game[ "strongholdFlagKeys" ].size ) ];
                    game[ "strongholdFlagKeys" ] = arrayremove( game[ "strongholdFlagKeys" ], randomflag );
                    
                    foreach ( hill in tempflags )
                    {
                        if ( hill.script_label == randomflag )
                        {
                            tempflags = arrayremove( tempflags, hill );
                            removecount--;
                            break;
                        }
                    }
                }
            }
            
            var_10c53a5fcf934ea9 = [];
            allyhills = utility::get_array_of_closest( spawncamera::getstartspawnavg( "allies", "mp_dom_spawn_allies_start" ), tempflags, undefined, 2 );
            randomflag = allyhills[ randomint( allyhills.size ) ];
            tempflags = arrayremove( tempflags, randomflag );
            var_10c53a5fcf934ea9[ 0 ] = randomflag.script_label;
            axishills = utility::get_array_of_closest( spawncamera::getstartspawnavg( "axis", "mp_dom_spawn_axis_start" ), tempflags, undefined, 2 );
            randomflag = axishills[ randomint( axishills.size ) ];
            tempflags = arrayremove( tempflags, randomflag );
            var_10c53a5fcf934ea9[ 2 ] = randomflag.script_label;
            randomflag = tempflags[ randomint( tempflags.size ) ];
            tempflags = arrayremove( tempflags, randomflag );
            var_10c53a5fcf934ea9[ 1 ] = randomflag.script_label;
            game[ "strongholdFlagKeys" ] = var_10c53a5fcf934ea9;
        }
        
        flagnames = [ "_a", "_b", "_c", "_d", "_e" ];
        flagindex = 0;
        selectedflags = [];
        
        for ( i = 0; i < game[ "strongholdFlagKeys" ].size ; i++ )
        {
            hillkey = game[ "strongholdFlagKeys" ][ i ];
            
            foreach ( zone in allflags )
            {
                if ( hillkey != zone.script_label )
                {
                    continue;
                }
                
                key = flagnames[ flagindex ];
                zone.script_label = key;
                zone.objectivekey = key;
                selectedflags[ selectedflags.size ] = zone;
                flagindex++;
                break;
            }
        }
        
        primaryflags = selectedflags;
        level.changenumdomflags = getdvarint( @"scr_dom_flagcount", 3 );
    }
    else
    {
        if ( isdefined( game_utility::getlocaleid() ) )
        {
            var_b720e108ea382ac0 = getentarray( "flag_primary", #targetname );
            
            foreach ( flag in var_b720e108ea382ac0 )
            {
                if ( flag.script_noteworthy == level.localeid )
                {
                    primaryflags[ primaryflags.size ] = flag;
                    continue;
                }
                
                flag delete();
            }
        }
        else
        {
            level.changenumdomflags = getdvarint( @"scr_dom_flagcount", 0 );
            primaryflags = getentarray( "flag_primary", #targetname );
        }
        
        secondaryflags = getentarray( "flag_secondary", #targetname );
    }
    
    if ( primaryflags.size + secondaryflags.size < 2 )
    {
        assertmsg( "<dev string:x24>" );
        return;
    }
    
    if ( level.changenumdomflags == 3 )
    {
        setomnvar( "ui_num_dom_flags", level.changenumdomflags );
    }
    else
    {
        setomnvar( "ui_num_dom_flags", primaryflags.size );
    }
    
    triggers = arraycombine( primaryflags, secondaryflags );
    
    if ( level.changenumdomflags == 3 )
    {
        foreach ( trigger in triggers )
        {
            trigger remapdomtriggerscriptlabel();
        }
    }
    
    foreach ( trigger in triggers )
    {
        if ( !level.usestrongholdhills && level.changenumdomflags == 3 )
        {
            if ( trigger.script_label == "_d" || trigger.script_label == "_e" )
            {
                continue;
            }
        }
        
        modifytriggerlocation( trigger );
        domflag = obj_dom::setupobjective( trigger, undefined, 1, 1 );
        domflag thread domchevrons( trigger.target, trigger.script_label );
        level.objectives[ domflag.objectivekey ] = domflag;
    }
    
    level thread function_d81dd7553e80be6f( level.objectives.size );
    spawngroup = spawnlogic::function_1f5152a92aada360( #"start" ) ? #"start" : #"primary";
    spawn_attackers = spawnlogic::function_f89ebff0bfb8555( spawngroup, game[ "attackers" ] );
    spawn_defenders = spawnlogic::function_f89ebff0bfb8555( spawngroup, game[ "defenders" ] );
    level.startpos[ game[ "attackers" ] ] = spawn_attackers[ 0 ].origin;
    level.startpos[ game[ "defenders" ] ] = spawn_defenders[ 0 ].origin;
    level.bestspawnflag = [];
    level.bestspawnflag[ game[ "attackers" ] ] = obj_dom::getunownedflagneareststart( game[ "attackers" ], undefined );
    level.bestspawnflag[ game[ "defenders" ] ] = obj_dom::getunownedflagneareststart( game[ "defenders" ], level.bestspawnflag[ game[ "attackers" ] ] );
    flagsetup();
    thread modifieddefendradiussetup();
    
    if ( !flags::gameflag( "prematch_done" ) )
    {
        level utility::waittill_any( "prematch_done", "start_mode_setup" );
    }
    
    foreach ( flag in level.objectives )
    {
        reservedobjid = obj_dom::getreservedobjid( flag.objectivekey );
        flag gameobjects::requestid( 1, 1, reservedobjid, undefined, undefined, undefined );
        function_ca1cc2938b2b4271( flag.objidnum, flag.trigger );
        flag.onplayerenter = &onplayerenter;
        flag.onplayerexit = &onplayerexit;
        flag.onuse = &dompoint_onuse;
        flag.onbeginuse = &dom_onbeginuse;
        flag.onuseupdate = &obj_dom::dompoint_onuseupdate;
        flag.onenduse = &dom_onenduse;
        flag.oncontested = &dom_oncontested;
        flag.onuncontested = &dom_onuncontested;
        flag.onunoccupied = &dom_onunoccupied;
        flag.oncleared = &obj_dom::function_759196e1bdad8cfc;
        flag.ondecayed = &obj_dom::function_759196e1bdad8cfc;
        flag.onpinnedstate = &dom_onpinnedstate;
        flag.onunpinnedstate = &dom_onunpinnedstate;
        flag.stompprogressreward = &onstompprogressreward;
        flag gameobjects::setobjectivestatusicons( level.icondefend, level.icontarget );
        flag gameobjects::setvisibleteam( "any" );
        flag function_1ddaa0d7494f5ae3();
        flag function_b2690b27d6bc7526();
        flag obj_dom::domflag_setneutral();
    }
    
    gameplay_sound_fx::function_e319dc8e16c85fcb( #"dom_flag_spawned", level.players );
    
    if ( level.precappoints )
    {
        thread obj_dom::precap();
    }
    
    if ( level.codcasterenabled )
    {
        thread updatetriggerforcodcaster();
    }
    
    /#
        thread domdebug();
    #/
}

// Namespace dom
// Params 1
// Checksum 0x945c3cc1, Offset: 0x2f9c
// Size: 0x58
function function_d81dd7553e80be6f( objectivescount )
{
    level endon( #"game_ended" );
    flags::gameflaginit( "chevrons_ready", 0 );
    
    for ( i = 0; i < objectivescount ; i++ )
    {
        level waittill( #"hash_974d2f2e651a7162" );
    }
    
    flags::gameflagset( "chevrons_ready" );
}

// Namespace dom
// Params 1
// Checksum 0x6c69b5d7, Offset: 0x2ffc
// Size: 0x4e
function onstompprogressreward( player )
{
    var_3d152e00ebf9f46d = player.owner ?? player;
    obj_dom::dompoint_stompprogressreward( var_3d152e00ebf9f46d );
    var_3d152e00ebf9f46d stats::setextrascore2( var_3d152e00ebf9f46d.pers[ "extrascore2" ] + 1 );
}

// Namespace dom
// Params 2
// Checksum 0xe9688453, Offset: 0x3052
// Size: 0x107
function domchevrons( target, label )
{
    if ( !level.gametypebundle.var_204e7aa6b9e01102 )
    {
        return;
    }
    
    wait 1;
    othervisuals = getentitylessscriptablearray( target, #targetname );
    chevrons = [];
    
    foreach ( visual in othervisuals )
    {
        index = chevrons.size;
        chevrons[ index ] = visual;
        chevrons[ index ].numchevrons = 1;
    }
    
    self.chevrons = chevrons;
    set_chevron_state( "idle" );
    level notify( #"hash_974d2f2e651a7162" );
}

// Namespace dom
// Params 1
// Checksum 0x299c97ba, Offset: 0x3161
// Size: 0x117
function set_chevron_state( state )
{
    self notify( #"hash_5706c314c0934327" );
    self endon( #"hash_5706c314c0934327" );
    
    if ( !level.gametypebundle.var_204e7aa6b9e01102 )
    {
        return;
    }
    
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

// Namespace dom
// Params 0
// Checksum 0x1d610cc0, Offset: 0x3280
// Size: 0xfc
function update_chevrons()
{
    if ( !level.gametypebundle.var_204e7aa6b9e01102 )
    {
        return;
    }
    
    owningteam = gameobjects_shared::function_623b07f4735aecb2( self );
    claimteam = gameobjects_shared::function_d071a38f7d43555a( self );
    iscontested = gameobjects_shared::function_3d275bfdb7872815( self );
    isunoccupied = claimteam == "none";
    
    if ( owningteam == game[ "attackers" ] )
    {
        thread set_chevron_state( game[ "attackers" ] );
    }
    else if ( owningteam == game[ "defenders" ] )
    {
        thread set_chevron_state( game[ "defenders" ] );
    }
    else if ( isunoccupied || owningteam == "none" )
    {
        thread set_chevron_state( "idle" );
    }
    
    if ( iscontested )
    {
        thread set_chevron_state( "contested" );
    }
    else if ( !isunoccupied && !level.gametypebundle.var_f2e17118451564d8 )
    {
        thread set_chevron_state( claimteam );
    }
    
    function_c18eb83275e643e7();
}

// Namespace dom
// Params 0
// Checksum 0x4630a680, Offset: 0x3385
// Size: 0x83
function function_c18eb83275e643e7()
{
    if ( self.objidnum )
    {
        luaindex = self.objidnum + 1;
    }
    else
    {
        objective_key = gameobjects_shared::get_objective_key( self );
        luaindex = obj_dom::getreservedobjid( objective_key ) + 1;
    }
    
    setomnvar( "ui_axis_player_count_zone_" + luaindex, gameobjects_common::function_de2f4638a165d21c( self, #"hash_7118f9343873352b" ).size );
    setomnvar( "ui_allies_player_count_zone_" + luaindex, gameobjects_common::function_de2f4638a165d21c( self, #"hash_ce911e3bbe99421f" ).size );
}

// Namespace dom
// Params 1
// Checksum 0x296df23a, Offset: 0x3410
// Size: 0x7c
function onplayerenter( player )
{
    player.var_c36e159445e2a48b = 0;
    player.var_b87cafbca06df20f = 1;
    
    if ( isdefined( self.callbacks[ #"hash_af5376dd4fc03b8f" ] ) || isdefined( level.callbacks[ #"hash_af5376dd4fc03b8f" ] ) )
    {
        callback::callback( #"hash_af5376dd4fc03b8f", { #zone:self, #enterplayer:player } );
    }
}

// Namespace dom
// Params 1
// Checksum 0xc88b5532, Offset: 0x3494
// Size: 0x76
function onplayerexit( player )
{
    player.var_c36e159445e2a48b = undefined;
    player.var_b87cafbca06df20f = undefined;
    player events::function_b49819835545fb9();
    
    if ( isdefined( self.callbacks[ #"hash_dcaaf3c8d874eeab" ] ) || isdefined( level.callbacks[ #"hash_dcaaf3c8d874eeab" ] ) )
    {
        callback::callback( #"hash_dcaaf3c8d874eeab", { #exitplayer:player } );
    }
}

// Namespace dom
// Params 1
// Checksum 0xe93e5bdf, Offset: 0x3512
// Size: 0x8a
function dom_onbeginuse( player )
{
    obj_dom::dompoint_onusebegin( player );
    update_chevrons();
    
    if ( self.visuals[ 0 ] )
    {
        otherteam = team_utility::getotherteam( player.team );
        self.visuals[ 0 ] thread gameplay_sound_fx::function_6dac8db778849e61( #"hash_2b7ca3c7589e557c", otherteam );
        self.visuals[ 0 ] thread gameplay_sound_fx::function_6dac8db778849e61( #"hash_ff7787699401171f", player.team );
    }
}

// Namespace dom
// Params 3
// Checksum 0xf3516079, Offset: 0x35a4
// Size: 0x4a
function dom_onenduse( team, player, success )
{
    obj_dom::dompoint_onuseend( team, player, success );
    
    if ( success )
    {
        thread set_chevron_state( player.team );
        return;
    }
    
    update_chevrons();
}

// Namespace dom
// Params 0
// Checksum 0xc0971c9b, Offset: 0x35f6
// Size: 0x10
function dom_oncontested()
{
    obj_dom::dompoint_oncontested();
    update_chevrons();
}

// Namespace dom
// Params 1
// Checksum 0x4354cc91, Offset: 0x360e
// Size: 0x26
function dom_onuncontested( lastclaimteam )
{
    obj_dom::dompoint_onuncontested( lastclaimteam );
    utility::delaythread( 0.05, &update_chevrons );
}

// Namespace dom
// Params 0
// Checksum 0xde22cc74, Offset: 0x363c
// Size: 0x10
function dom_onunoccupied()
{
    obj_dom::dompoint_onunoccupied();
    update_chevrons();
}

// Namespace dom
// Params 1
// Checksum 0x2f48a929, Offset: 0x3654
// Size: 0x1c
function dom_onpinnedstate( player )
{
    obj_dom::dompoint_onpinnedstate( player );
    update_chevrons();
}

// Namespace dom
// Params 1
// Checksum 0xe8f09ff4, Offset: 0x3678
// Size: 0x1c
function dom_onunpinnedstate( player )
{
    obj_dom::dompoint_onunpinnedstate( player );
    update_chevrons();
}

// Namespace dom
// Params 1
// Checksum 0x1986e406, Offset: 0x369c
// Size: 0xb7
function modifytriggerlocation( trigger )
{
    switch ( level.mapname )
    {
        case #"hash_d8bbcfc499e70e6f":
            switch ( trigger.script_label )
            {
                case #"hash_fac2c5f6bddd49bd":
                    trigger.origin = ( 983, 303, 110 );
                    break;
                case #"hash_fac2c2f6bddd4504":
                    trigger.origin = ( -1064, -525, 110 );
                    break;
                case #"hash_fac2c3f6bddd4697":
                    trigger.origin = ( -1605, -2298, 60 );
                    break;
            }
            
            break;
    }
}

// Namespace dom
// Params 0
// Checksum 0x4f72176d, Offset: 0x375b
// Size: 0xf6
function remapdomtriggerscriptlabel()
{
    if ( level.mapname == "mp_aniyah" || level.mapname == "mp_aniyah_pm" )
    {
        if ( self.script_label == "_e" && !isdefined( self.remappedscriptlabel ) )
        {
            self.script_label = "_c";
            self.remappedscriptlabel = 1;
        }
        else if ( self.script_label == "_c" && !isdefined( self.remappedscriptlabel ) )
        {
            self.script_label = "_e";
            self.remappedscriptlabel = 1;
        }
        
        return;
    }
    
    if ( level.mapname == "mp_rust" )
    {
        if ( self.script_label == "_a" )
        {
            self.script_label = "_b";
            return;
        }
        
        if ( self.script_label == "_b" )
        {
            self.script_label = "_a";
        }
    }
}

// Namespace dom
// Params 0
// Checksum 0x9da4ad4b, Offset: 0x3859
// Size: 0x4c7
function updatedomscores()
{
    level endon( #"game_ended" );
    level waittill( #"prematch_done" );
    
    if ( !isdefined( level.scoretick ) )
    {
        level.scoretick = [];
    }
    
    while ( !level.gameended )
    {
        waittime = 5;
        
        if ( level.usestrongholdscoring )
        {
            waittime = level.strongholdscoreinterval;
        }
        
        timeleft = gamelogic_mp::gettimeremaining();
        
        if ( timeleft < 5000 && timeleft > 0 )
        {
            waittime = timeleft / 1000;
        }
        
        wait waittime;
        hostmigration::waittillhostmigrationdone();
        domflags = getowneddomflags();
        
        foreach ( entry in level.teamnamelist )
        {
            level.scoretick[ entry ] = 0;
        }
        
        if ( domflags.size )
        {
            if ( level.dominationdata.dominationscoring == "Stronghold" )
            {
                foreach ( team in level.teamnamelist )
                {
                    if ( isdefined( level.gametypebundle.var_ae100eea97c7fcc7[ #"hash_14bb716c4b77c45a" ] ) )
                    {
                        var_d9425977785add8f = captureflag::function_ae0c1c2a2553b7d( team, istrue( level.usestrongholdscoring ) );
                    }
                    else
                    {
                        var_d9425977785add8f = obj_dom::getteamflagcount( team, level.usestrongholdscoring );
                    }
                    
                    if ( var_d9425977785add8f == level.objectives.size )
                    {
                        level.scoretick[ team ] = level.strongholdscoreallcapincrement;
                        continue;
                    }
                    
                    if ( var_d9425977785add8f >= level.flagsrequiredtoscore )
                    {
                        level.scoretick[ team ] = level.strongholdscoreincrement;
                    }
                }
            }
            else if ( level.dominationdata.dominationscoring == "OnePointPerFlag" )
            {
                foreach ( domflag in domflags )
                {
                    team = gameobjects_shared::function_623b07f4735aecb2( domflag );
                    assert( team_utility::isgameplayteam( team ) );
                    
                    if ( isdefined( level.gametypebundle.var_ae100eea97c7fcc7[ #"hash_14bb716c4b77c45a" ] ) )
                    {
                        var_d9425977785add8f = captureflag::function_ae0c1c2a2553b7d( team, 0 );
                    }
                    else
                    {
                        var_d9425977785add8f = obj_dom::getteamflagcount( team );
                    }
                    
                    if ( var_d9425977785add8f >= level.flagsrequiredtoscore )
                    {
                        level.scoretick[ team ] += level.pointsperflag;
                        
                        if ( domflag.reinforced && isdefined( level.pointsperreinforcedflag ) )
                        {
                            level.scoretick[ team ] += level.pointsperreinforcedflag;
                        }
                    }
                }
            }
            else if ( level.dominationdata.dominationscoring == "OnePerMoreFlagsThanEnemy" )
            {
                if ( function_4042d2fbe6237835( #"hash_c3e69e2731944a96" ) )
                {
                    level.dominationdata.dominationscoring = "OnePointPerFlag";
                    continue;
                }
                
                if ( isdefined( level.gametypebundle.var_ae100eea97c7fcc7[ #"hash_14bb716c4b77c45a" ] ) )
                {
                    axiscount = captureflag::function_ae0c1c2a2553b7d( "axis", 0 );
                    alliescount = captureflag::function_ae0c1c2a2553b7d( "allies", 0 );
                }
                else
                {
                    axiscount = obj_dom::getteamflagcount( "axis" );
                    alliescount = obj_dom::getteamflagcount( "allies" );
                }
                
                if ( axiscount > alliescount )
                {
                    level.scoretick[ "axis" ] = axiscount - alliescount;
                }
                else if ( alliescount > axiscount )
                {
                    level.scoretick[ "allies" ] = alliescount - axiscount;
                }
            }
            else
            {
                assert( 0, "<dev string:x85>" + level.dominationdata.dominationscoring );
            }
        }
        
        updatescores();
        checkendgame( domflags.size );
    }
}

// Namespace dom
// Params 0
// Checksum 0xd6b37ec7, Offset: 0x3d28
// Size: 0x16f
function updatescores()
{
    teamshitscorelimit = [];
    
    foreach ( entry in level.teamnamelist )
    {
        targetscore = game[ "teamScores" ][ entry ] + level.scoretick[ entry ];
        
        if ( targetscore >= level.roundscorelimit )
        {
            teamshitscorelimit[ teamshitscorelimit.size ] = entry;
        }
    }
    
    if ( teamshitscorelimit.size == 1 )
    {
        level.scoretick[ teamshitscorelimit[ 0 ] ] = level.roundscorelimit - game[ "teamScores" ][ teamshitscorelimit[ 0 ] ];
    }
    
    foreach ( entry in level.teamnamelist )
    {
        if ( level.scoretick[ entry ] > 0 )
        {
            gamescore::giveteamscoreforobjective( entry, level.scoretick[ entry ], 1, undefined );
        }
    }
}

// Namespace dom
// Params 1
// Checksum 0xb55b5d70, Offset: 0x3e9f
// Size: 0x18a
function checkendgame( var_f6426b7d6a770ffe )
{
    timesincelastcap = gettime() - level.lastcaptime;
    
    if ( game_utility_mp::matchmakinggame() && var_f6426b7d6a770ffe < 2 && timesincelastcap > 120000 )
    {
        level.forcedend = 1;
        thread gamelogic_mp::endgame( "none", game[ "end_reason" ][ "dom_force_end" ] );
        return;
    }
    
    if ( level.objectives.size == 3 && level.playholdtwovo && timesincelastcap > 30000 )
    {
        foreach ( entry in level.teamnamelist )
        {
            if ( isdefined( level.gametypebundle.var_ae100eea97c7fcc7[ #"hash_14bb716c4b77c45a" ] ) )
            {
                flagcount = captureflag::function_ae0c1c2a2553b7d( entry, 0 );
            }
            else
            {
                flagcount = obj_dom::getteamflagcount( entry );
            }
            
            if ( flagcount == 2 )
            {
                otherteam = team_utility::getotherteam( entry );
                dialog::statusdialog( #"enemy_captured_2", otherteam );
                dialog::statusdialog( #"friendly_captured_2", entry );
                level.playholdtwovo = 0;
                break;
            }
        }
    }
}

// Namespace dom
// Params 1
// Checksum 0xf95c1c87, Offset: 0x4031
// Size: 0x2fb
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
    
    if ( !isplayer( attacker ) || attacker.team == victim.team )
    {
        return;
    }
    
    if ( isdefined( objweapon ) && weapon::iskillstreakweapon( objweapon.basename ) )
    {
        return;
    }
    
    if ( isdefined( level.gametypebundle.var_ae100eea97c7fcc7[ #"hash_14bb716c4b77c45a" ] ) )
    {
        victim function_f82a470d9b7f1c39( einflictor, attacker, idamage, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, deathanimduration, killid );
        
        foreach ( gameobject in level.objectives )
        {
            if ( victim function_dad8f52162d4d891( gameobject, attacker.origin, victim.origin ) )
            {
                attacker stats::setextrascore1( attacker.pers[ "extrascore1" ] + 1 );
                break;
            }
        }
        
        return;
    }
    
    victim obj_dom::awardgenericmedals( einflictor, attacker, idamage, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, deathanimduration, killid );
    
    foreach ( flag in level.objectives )
    {
        eithertouching = obj_dom::distsquaredcheck( flag.trigger, attacker.origin, victim.origin );
        
        if ( eithertouching )
        {
            attacker stats::setextrascore1( attacker.pers[ "extrascore1" ] + 1 );
            break;
        }
    }
}

// Namespace dom
// Params 6
// Checksum 0x7a431c36, Offset: 0x4334
// Size: 0x60
function onnormaldeath( victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon )
{
    if ( level.teamscoresonkill[ attacker.team ] )
    {
        common::oncommonnormaldeath( victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon );
    }
}

// Namespace dom
// Params 0
// Checksum 0x4a35eaed, Offset: 0x439c
// Size: 0xa1
function getowneddomflags()
{
    domflags = [];
    
    foreach ( domflag in level.objectives )
    {
        if ( gameobjects_shared::function_c4931586039098d6( domflag ) && isdefined( domflag.capturetime ) )
        {
            domflags[ domflags.size ] = domflag;
        }
    }
    
    return domflags;
}

// Namespace dom
// Params 0
// Checksum 0x544ee2d, Offset: 0x4446
// Size: 0x9
function getflagteam()
{
    return gameobjects_shared::function_623b07f4735aecb2( self );
}

// Namespace dom
// Params 0
// Checksum 0xb6e810e, Offset: 0x4458
// Size: 0x2d8
function flagsetup()
{
    /#
        setdevdvarifuninitialized( @"scr_domdebug", "<dev string:xac>" );
    #/
    
    if ( level.objectives.size < 3 )
    {
        assertmsg( "<dev string:xae>" );
        logstring( "[DOM] Failed to construct at least 3 domflags!" );
    }
    
    foreach ( objectivekey, domflag in level.objectives )
    {
        domflag.spawnflagid = getflagspawnidforobjectivekey( objectivekey );
    }
    
    spawnpoints = level.spawnpoints;
    
    if ( level.var_c76086bc0fa0cdfa && !action_park_utility::is_enabled() )
    {
        foreach ( spawnpoint in spawnpoints )
        {
            spawnpoint.scriptdata.domflagassignments = getspawnpointflagassignment( spawnpoint );
        }
    }
    
    foreach ( domflag in level.objectives )
    {
        matchtimems = matchdata::function_47550968a937b67e( gettime() );
        dlog_recordevent( "dlog_event_mp_objective_status", [ "key", domflag.objectivekey, "match_time_ms", matchtimems, "is_active", 1 ] );
        dlog_recordevent( "dlog_event_mp_objective_move", [ "pos_x", domflag.navmeshpos[ 0 ], "pos_y", domflag.navmeshpos[ 1 ], "key", domflag.objectivekey, "match_time_ms", matchtimems ] );
        dlog_recordevent( "dlog_event_mp_objective_ownership_changed", [ "key", domflag.objectivekey, "team", "neutral", "match_time_ms", matchtimems ] );
    }
}

// Namespace dom
// Params 1
// Checksum 0xf6c7f8ae, Offset: 0x4738
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

// Namespace dom
// Params 1
// Checksum 0xf4efdc2d, Offset: 0x47a2
// Size: 0xd4
function getspawnpointflagassignment( spawnpoint )
{
    if ( game_utility::isarenamap() )
    {
        if ( spawnpoint.script_noteworthy == "1" || spawnpoint.script_noteworthy == "2" || spawnpoint.script_noteworthy == "3" )
        {
            spawnpoint.script_noteworthy = "";
        }
    }
    
    if ( isdefined( spawnpoint.script_noteworthy ) && spawnpoint.script_noteworthy != "" )
    {
        if ( !isdefined( game_utility::getlocaleid() ) )
        {
            var_7237854e3be197ca = parseflagassignmentstring( spawnpoint.script_noteworthy );
            
            if ( isdefined( var_7237854e3be197ca ) )
            {
                return var_7237854e3be197ca;
            }
        }
    }
    
    return findnearestdompoint( spawnpoint.origin ).spawnflagid;
}

// Namespace dom
// Params 1
// Checksum 0x5192c89e, Offset: 0x487f
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
            assertmsg( "<dev string:xd9>" + stringvalue + "<dev string:x10b>" );
            break;
    }
}

// Namespace dom
// Params 1
// Checksum 0x210812e9, Offset: 0x4966
// Size: 0xca
function function_eac831db102ec430( pos )
{
    bestdompoint = undefined;
    bestdist = 1e+08;
    
    foreach ( dompoint in level.objectives )
    {
        origin = gameobjects_shared::get_origin( dompoint );
        dist = distance2dsquared( origin, pos );
        
        if ( dist < bestdist )
        {
            bestdompoint = dompoint;
            dist = bestdist;
        }
    }
    
    return bestdompoint;
}

// Namespace dom
// Params 1
// Checksum 0x17f009db, Offset: 0x4a39
// Size: 0x232
function findnearestdompoint( pos )
{
    /#
        if ( !isnavmeshloaded() )
        {
            return function_eac831db102ec430( pos );
        }
    #/
    
    navmeshpoints = [];
    
    foreach ( dompoint in level.objectives )
    {
        origin = gameobjects_shared::get_origin( dompoint );
        dompoint.navmeshpos = getclosestpointonnavmesh( origin );
        navmeshpoints[ navmeshpoints.size ] = dompoint.navmeshpos;
    }
    
    var_a33a56db6de8c0f = findclosestpointbyapproxpathdist( navmeshpoints, getclosestpointonnavmesh( pos ) );
    nearestdompoint = undefined;
    
    if ( !isdefined( var_a33a56db6de8c0f ) )
    {
        nearestdist = undefined;
        
        foreach ( dompoint in level.objectives )
        {
            origin = gameobjects_shared::get_origin( dompoint );
            dist = distancesquared( origin, pos );
            
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

// Namespace dom
// Params 0
// Checksum 0xf5b2e1a7, Offset: 0x4c74
// Size: 0xb0
function modifieddefendradiussetup()
{
    if ( level.mapname == "mp_frontier" )
    {
        foreach ( objective in level.objectives )
        {
            if ( objective.objectivekey == "_b" )
            {
                objective.trigger.modifieddefendcheck = 1;
            }
        }
    }
}

/#

    // Namespace dom
    // Params 0
    // Checksum 0x42ed21fa, Offset: 0x4d2c
    // Size: 0x68c, Type: dev
    function domdebug()
    {
        spawnpoints = spawnlogic::function_f89ebff0bfb8555( #"primary", "<dev string:x14d>" );
        fallbacks = spawnlogic::function_f89ebff0bfb8555( #"fallback", "<dev string:x14d>" );
        spawnpoints = arraycombine( spawnpoints, fallbacks );
        ispathdataavailable = spawnlogic::ispathdataavailable();
        heightoffsetlines = ( 0, 0, 12 );
        heightoffsetnames = ( 0, 0, 64 );
        colors = [];
        colors[ 1 ] = ( 1, 0, 0 );
        colors[ 2 ] = ( 0, 1, 0 );
        colors[ 4 ] = ( 0, 0, 1 );
        colors[ 8 ] = ( 1, 1, 1 );
        colors[ 16 ] = ( 0, 0, 0 );
        colors[ 32 ] = ( 1, 1, 0 );
        colors[ 64 ] = ( 0, 1, 1 );
        colors[ 128 ] = ( 1, 0, 1 );
        
        while ( true )
        {
            if ( getdvarint( @"scr_domdebug" ) != 1 )
            {
                wait 1;
                continue;
            }
            
            while ( true )
            {
                if ( getdvarint( @"scr_domdebug" ) != 1 )
                {
                    break;
                }
                
                if ( !isdefined( level.players[ 0 ] ) )
                {
                    waitframe();
                    continue;
                }
                
                endpoints = [];
                endpoints[ 1 ] = [ level.objectives[ "<dev string:x152>" ] ];
                endpoints[ 2 ] = [ level.objectives[ "<dev string:x155>" ] ];
                endpoints[ 4 ] = [ level.objectives[ "<dev string:x158>" ] ];
                endpoints[ 8 ] = [ level.objectives[ "<dev string:x15b>" ] ];
                endpoints[ 16 ] = [ level.objectives[ "<dev string:x15e>" ] ];
                endpoints[ 32 ] = [ level.objectives[ "<dev string:x152>" ], level.objectives[ "<dev string:x155>" ] ];
                endpoints[ 64 ] = [ level.objectives[ "<dev string:x158>" ], level.objectives[ "<dev string:x155>" ] ];
                endpoints[ 128 ] = [ level.objectives[ "<dev string:x152>" ], level.objectives[ "<dev string:x158>" ] ];
                
                foreach ( spawnpoint in spawnpoints )
                {
                    spawnpointdata = spawnpoint.scriptdata;
                    
                    if ( !isdefined( spawnpointdata.domflagassignments ) )
                    {
                        continue;
                    }
                    
                    if ( !isdefined( spawnpointdata.nodearrays ) )
                    {
                        spawnpointdata.nodearrays = [];
                    }
                    
                    if ( ispathdataavailable )
                    {
                        foreach ( endpoint in endpoints[ spawnpoint.scriptdata.domflagassignments ] )
                        {
                            if ( !isdefined( spawnpointdata.nodearrays[ endpoint.spawnflagid ] ) )
                            {
                                spawnpointdata.nodearrays[ endpoint.spawnflagid ] = level.players[ 0 ] findpath( spawnpoint.origin, endpoint.curorigin );
                            }
                            
                            if ( !isdefined( spawnpointdata.nodearrays[ endpoint.spawnflagid ] ) || spawnpointdata.nodearrays[ endpoint.spawnflagid ].size == 0 )
                            {
                                continue;
                            }
                            
                            color = colors[ spawnpoint.scriptdata.domflagassignments ];
                            line( spawnpoint.origin + heightoffsetlines, spawnpointdata.nodearrays[ endpoint.spawnflagid ][ 0 ] + heightoffsetlines, color );
                            
                            for ( i = 0; i < spawnpointdata.nodearrays[ endpoint.spawnflagid ].size - 1 ; i++ )
                            {
                                line( spawnpointdata.nodearrays[ endpoint.spawnflagid ][ i ] + heightoffsetlines, spawnpointdata.nodearrays[ endpoint.spawnflagid ][ i + 1 ] + heightoffsetlines, color );
                            }
                        }
                        
                        continue;
                    }
                    
                    foreach ( endpoint in endpoints[ spawnpoint.scriptdata.domflagassignments ] )
                    {
                        line( endpoint.curorigin + heightoffsetlines, spawnpoint.origin + heightoffsetlines, ( 0.2, 0.2, 0.6 ) );
                    }
                }
                
                foreach ( flaglocation in level.objectives )
                {
                    if ( flaglocation == level.bestspawnflag[ "<dev string:x161>" ] )
                    {
                        print3d( flaglocation.trigger.origin + heightoffsetnames, "<dev string:x168>" );
                    }
                    
                    if ( flaglocation == level.bestspawnflag[ "<dev string:x14d>" ] )
                    {
                        print3d( flaglocation.trigger.origin + heightoffsetnames, "<dev string:x17f>" );
                    }
                }
                
                waitframe();
            }
        }
    }

#/

// Namespace dom
// Params 1
// Checksum 0xf37797c1, Offset: 0x53c0
// Size: 0x13
function onspawnplayer( spawndata )
{
    thread updatematchstatushintonspawn();
}

// Namespace dom
// Params 0
// Checksum 0x5a456b4f, Offset: 0x53db
// Size: 0x54
function updatecpm()
{
    if ( !isdefined( self.cpm ) )
    {
        self.numcaps = 0;
        self.cpm = 0;
    }
    
    self.numcaps++;
    
    if ( game_utility_mp::getminutespassed() < 1 )
    {
        return;
    }
    
    self.cpm = self.numcaps / game_utility_mp::getminutespassed();
}

// Namespace dom
// Params 0
// Checksum 0xf56ee331, Offset: 0x5437
// Size: 0x1d
function getcapxpscale()
{
    if ( self.cpm < 4 )
    {
        return 1;
    }
    
    return 0.25;
}

// Namespace dom
// Params 1
// Checksum 0xce4fd8a0, Offset: 0x545c
// Size: 0x4b
function onplayerconnect( player )
{
    player thread onplayerspawned();
    
    if ( utility::issharedfuncdefined( #"hash_12eb2ef3dcc95127", #"hash_786092b78d9f50d0" ) )
    {
        utility::callsharedfunc( #"hash_12eb2ef3dcc95127", #"hash_786092b78d9f50d0", player );
    }
}

// Namespace dom
// Params 1
// Checksum 0xb334b3a0, Offset: 0x54af
// Size: 0x8a
function onplayerspawned( params )
{
    self endon( #"disconnect" );
    
    while ( true )
    {
        self waittill( #"spawned" );
        stats::setextrascore0( self.pers[ "captures" ] ?? 0, "captures" );
        stats::setextrascore1( self.pers[ "defends" ] ?? 0, "defends" );
        stats::setextrascore2( self.pers[ "extrascore2" ] ?? 0, "clears" );
    }
}

// Namespace dom
// Params 1
// Checksum 0xf7d130c3, Offset: 0x5541
// Size: 0xc3, Type: bool
function function_ac0c369c81a33806( ownerteam )
{
    foreach ( flag in level.objectives )
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

// Namespace dom
// Params 6
// Checksum 0xe675212e, Offset: 0x560d
// Size: 0x373
function onflagcapture( objectivetype, label, credit_player, team, oldteam, flagobj )
{
    assert( team != "<dev string:x194>" );
    otherteam = team_utility::getotherteam( team );
    allflagscaptured = obj_dom::getteamflagcount( team ) == level.objectives.size;
    var_d64a5f75a8ae9938 = allflagscaptured ? #"dom_flag_captured_all" : #"dom_flag_captured";
    var_ec9f18f23b5e8565 = allflagscaptured ? #"dom_flag_lost_all" : #"dom_flag_lost";
    
    if ( getprojectname() == "ZUL" )
    {
        flagobj.visuals[ 0 ] thread gameplay_sound_fx::function_6dac8db778849e61( var_d64a5f75a8ae9938, team );
        flagobj.visuals[ 0 ] thread gameplay_sound_fx::function_6dac8db778849e61( var_ec9f18f23b5e8565, otherteam );
    }
    else
    {
        gameplay_sound_fx::function_e319dc8e16c85fcb( var_d64a5f75a8ae9938, teams::getteamdata( team, "players" ) );
        gameplay_sound_fx::function_e319dc8e16c85fcb( var_ec9f18f23b5e8565, teams::getteamdata( otherteam, "players" ) );
    }
    
    credit_player codcasterclientmatchdata::function_8ecc753b54a5740f( 15, 1 );
    
    if ( obj_dom::getteamflagcount( team ) < level.objectives.size )
    {
        dialog::statusdialog( hashcat( #"secured", self.var_98076e259d94a508 ?? self.objectivekey ), team );
        
        if ( oldteam == "neutral" )
        {
            if ( isdefined( level.objectives ) && level.objectives.size == 5 && ( self.objectivekey == "_c" || self.objectivekey == "_d" ) || self.objectivekey == "_b" )
            {
                dialog::statusdialog( hashcat( #"lost", self.var_98076e259d94a508 ?? self.objectivekey ), otherteam );
            }
        }
        else
        {
            dialog::statusdialog( hashcat( #"lost", self.var_98076e259d94a508 ?? self.objectivekey ), otherteam );
        }
        
        if ( level.teamdata[ team ][ "allFlagsCaptured" ] )
        {
            level.teamdata[ team ][ "allFlagsCaptured" ] = undefined;
            level notify( #"hash_a15cb8497519e582" );
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
        
        if ( !isdefined( level.teamdata[ team ][ "alreadyEarnedAllFlagsCaptured" ] ) )
        {
            level.teamdata[ team ][ "allFlagsCaptured" ] = 1;
            level thread function_af17520188493b28( team );
        }
    }
    
    if ( obj_dom::getteamflagcount( otherteam ) < level.objectives.size && level.teamdata[ otherteam ][ "allFlagsCaptured" ] )
    {
        level.teamdata[ otherteam ][ "allFlagsCaptured" ] = undefined;
        level notify( #"hash_a15cb8497519e582" );
    }
    
    if ( level.var_26957a14f92507d )
    {
        function_26957a14f92507d( team );
    }
}

// Namespace dom
// Params 1, eflags: 0x4
// Checksum 0xef7209d9, Offset: 0x5988
// Size: 0x10b
function private function_af17520188493b28( team )
{
    if ( level.gametypebundle.var_dd17746c5b82ea88 )
    {
        level endon( #"game_ended", #"hash_a15cb8497519e582" );
        wait level.gametypebundle.var_dd17746c5b82ea88;
    }
    
    profilestart();
    
    if ( level.teamdata[ team ][ "allFlagsCaptured" ] )
    {
        foreach ( player in level.teamdata[ team ][ "players" ] )
        {
            challenges::function_b33c8c97a78773a9( player );
        }
        
        level.teamdata[ team ][ "allFlagsCaptured" ] = undefined;
        level.teamdata[ team ][ "alreadyEarnedAllFlagsCaptured" ] = 1;
    }
    
    profilestop();
}

// Namespace dom
// Params 1
// Checksum 0x33f9a93, Offset: 0x5a9b
// Size: 0xd8
function dompoint_onuse( credit_player )
{
    obj_dom::dompoint_onuse( credit_player, credit_player.team );
    
    if ( isdefined( level.teamscoresonkill ) )
    {
        foreach ( team in level.teamnamelist )
        {
            var_d9425977785add8f = obj_dom::getteamflagcount( team );
            level.teamscoresonkill[ team ] = var_d9425977785add8f >= level.numflagsscoreonkill && var_d9425977785add8f >= level.flagsrequiredtoscore;
        }
    }
}

// Namespace dom
// Params 0
// Checksum 0xf6533004, Offset: 0x5b7b
// Size: 0x9
function function_714ea0cd90e374f()
{
    codcasterclientmatchdata::function_1340113cb5a43c2c();
}

/#

    // Namespace dom
    // Params 0
    // Checksum 0x474f5ff0, Offset: 0x5b8c
    // Size: 0xa4, Type: dev
    function function_7f317007253a6058()
    {
        self endon( #"game_ended" );
        
        while ( true )
        {
            if ( getdvarint( @"scr_give_score_allies" ) != 0 )
            {
                gamescore::giveteamscoreforobjective( "<dev string:x161>", getdvarint( @"scr_give_score_allies" ), 1 );
                break;
            }
            else if ( getdvarint( @"scr_give_score_axis" ) != 0 )
            {
                gamescore::giveteamscoreforobjective( "<dev string:x14d>", getdvarint( @"scr_give_score_axis" ), 1 );
                break;
            }
            
            wait 1;
        }
        
        setdevdvar( @"scr_give_score_allies", 0 );
        setdevdvar( @"scr_give_score_axis", 0 );
        thread function_7f317007253a6058();
    }

    // Namespace dom
    // Params 0
    // Checksum 0x4ed2b172, Offset: 0x5c38
    // Size: 0x1e0, Type: dev
    function removedompoint()
    {
        self endon( #"game_ended" );
        
        while ( true )
        {
            if ( getdvar( @"hash_6ce167f2cdc8ef7c", "<dev string:x19c>" ) != "<dev string:x19c>" )
            {
                flaglabel = getdvar( @"hash_6ce167f2cdc8ef7c", "<dev string:x19c>" );
                
                foreach ( domflag in level.objectives )
                {
                    if ( isdefined( domflag.objectivekey ) && domflag.objectivekey == flaglabel )
                    {
                        domflag gameobjects::allowuse( "<dev string:x19d>" );
                        domflag.trigger = undefined;
                        domflag notify( #"deleted" );
                        domflag.visibleteam = "<dev string:x19d>";
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
                
                setdynamicdvar( @"hash_6ce167f2cdc8ef7c", "<dev string:x19c>" );
            }
            
            wait 1;
        }
    }

    // Namespace dom
    // Params 0
    // Checksum 0xd4be3501, Offset: 0x5e20
    // Size: 0x483, Type: dev
    function placedompoint()
    {
        self endon( #"game_ended" );
        
        while ( true )
        {
            if ( getdvar( @"hash_29d45d6822a1cf6d", "<dev string:x19c>" ) != "<dev string:x19c>" )
            {
                flaglabel = getdvar( @"hash_29d45d6822a1cf6d", "<dev string:x19c>" );
                zone = spawnstruct();
                zone.origin = level.players[ 0 ].origin;
                zone.angles = level.players[ 0 ].angles;
                trigger = spawn( "<dev string:x1a2>", zone.origin, 0, 120, 128 );
                zone.trigger = trigger;
                zone.trigger.script_label = flaglabel;
                zone.ownerteam = "<dev string:x194>";
                tracestart = zone.origin + ( 0, 0, 32 );
                traceend = zone.origin + ( 0, 0, -32 );
                trace = trace::ray_trace( tracestart, traceend, undefined, trace::create_default_contents( 1 ) );
                zone.origin = trace[ "<dev string:x1b1>" ];
                zone.upangles = vectortoangles( trace[ "<dev string:x1ba>" ] );
                zone.forward = anglestoforward( zone.upangles );
                zone.right = anglestoright( zone.upangles );
                zone.visuals[ 0 ] = spawn( "<dev string:x1c1>", zone.origin );
                zone.visuals[ 0 ].angles = zone.angles;
                domflag = gameobjects::createuseobject( "<dev string:x194>", zone.trigger, zone.visuals, ( 0, 0, 100 ) );
                domflag gameobjects::allowuse( "<dev string:x1ce>" );
                domflag gameobjects::setusetime( 10 );
                
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
                domflag gameobjects::setvisibleteam( "<dev string:x1d4>" );
                domflag.onuse = &dompoint_onuse;
                domflag.onbeginuse = &obj_dom::dompoint_onusebegin;
                domflag.onuseupdate = &obj_dom::dompoint_onuseupdate;
                domflag.onenduse = &obj_dom::dompoint_onuseend;
                domflag.nousebar = 1;
                domflag.id = "<dev string:x1d8>";
                domflag.firstcapture = 1;
                domflag.claimgracetime = 10000;
                domflag.decayrate = 50;
                tracestart = zone.visuals[ 0 ].origin + ( 0, 0, 32 );
                traceend = zone.visuals[ 0 ].origin + ( 0, 0, -32 );
                contentoverride = trace::create_contents( 1, 1, 1, 1, 0, 1, 1 );
                ignoreents = [];
                trace = trace::ray_trace( tracestart, traceend, ignoreents, contentoverride );
                domflag.baseeffectpos = trace[ "<dev string:x1b1>" ];
                upangles = vectortoangles( trace[ "<dev string:x1ba>" ] );
                domflag.baseeffectforward = anglestoforward( upangles );
                domflag obj_dom::initializematchrecording();
                domflag thread obj_dom::domflag_setneutral();
                level.objectives[ domflag.objectivekey ] = domflag;
                setdynamicdvar( @"hash_29d45d6822a1cf6d", "<dev string:x19c>" );
            }
            
            wait 1;
        }
    }

#/

// Namespace dom
// Params 0
// Checksum 0x92c2431a, Offset: 0x62ab
// Size: 0x1e
function updatematchstatushintonspawn()
{
    level endon( #"game_ended" );
    hud_message::function_ef4318a0090caa0f( #"dom_cap_defend" );
}

// Namespace dom
// Params 0
// Checksum 0xc61b9c7e, Offset: 0x62d1
// Size: 0x18b
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

// Namespace dom
// Params 1
// Checksum 0xbc5684a1, Offset: 0x6464
// Size: 0x2a9
function function_26957a14f92507d( team )
{
    budgetname = team + "_agents";
    totalspawned = ai_mp_controller::function_62448bd2c6f12ae9( budgetname );
    var_7a6d859df4c2ee8 = level.var_d95835502ec96520 - totalspawned;
    
    if ( var_7a6d859df4c2ee8 <= 0 )
    {
        return;
    }
    
    numagents = getdvarint( @"hash_3ac57a7fbbfe5cf8", 1 );
    
    if ( numagents > 0 )
    {
        for ( i = 0; i < numagents ; i++ )
        {
            type = ai_mp_controller::function_3a4bd0fc4d6012b0();
            aitype = ai_mp_controller::function_b86341658788836c();
            agent = ai_mp_controller::ai_mp_requestspawnagent( aitype, self.trigger.origin + function_298cda781b802839( i ), ( 0, 0, 0 ), "medium", budgetname, "domAgents", budgetname, team );
            
            if ( isdefined( agent ) )
            {
                agent thread common::function_7c3197fc1ba5824( agent, team );
                agent thread ai_behavior::behavior_combatRushOrigin( agent, self.trigger.origin );
                
                if ( team == "allies" )
                {
                    agent agent_utils::overrideagentsettings( "body_mp_eastern_geist_1_1_lod1", "head_mp_eastern_bale_1_1" );
                    continue;
                }
                
                agent agent_utils::overrideagentsettings( "body_spetsnaz_cqc", "head_spetsnaz_cqc" );
            }
        }
    }
    
    if ( getdvarint( @"hash_b50a927a2e0e0a5d", 1 ) == 1 )
    {
        if ( self.objectivekey == "_b" )
        {
            var_b6933894644e835a = getdvarint( @"hash_2c76d4f86fd341de", 1 );
            
            if ( var_b6933894644e835a > 0 )
            {
                for ( i = 0; i < var_b6933894644e835a ; i++ )
                {
                    agent = ai_mp_controller::ai_mp_requestspawnagent( "enemy_mp_jugg_base", self.trigger.origin, ( 0, 0, 0 ), "absolute", budgetname, "jugg", budgetname, team );
                    
                    if ( isdefined( agent ) )
                    {
                        agent thread common::function_7c3197fc1ba5824( agent, team );
                        agent thread ai_behavior::behavior_combatRushOrigin( agent, self.trigger.origin );
                    }
                }
            }
        }
        
        return;
    }
    
    var_b6933894644e835a = getdvarint( @"hash_2c76d4f86fd341de", 0 );
    
    if ( var_b6933894644e835a > 0 )
    {
        for ( i = 0; i < var_b6933894644e835a ; i++ )
        {
            agent = ai_mp_controller::ai_mp_requestspawnagent( "enemy_mp_jugg_base", self.trigger.origin, ( 0, 0, 0 ), "absolute", budgetname, "jugg", budgetname, team );
            
            if ( isdefined( agent ) )
            {
                agent thread common::function_7c3197fc1ba5824( agent, team );
                agent thread ai_behavior::behavior_combatRushOrigin( agent, self.trigger.origin );
            }
        }
    }
}

// Namespace dom
// Params 1
// Checksum 0x32c2b66f, Offset: 0x6715
// Size: 0x8b
function function_298cda781b802839( spawnindex )
{
    offset = ( 0, 0, 0 );
    
    if ( spawnindex == 0 )
    {
        offset = ( 32, 0, 0 );
    }
    else if ( spawnindex == 1 )
    {
        offset = ( 0, 32, 0 );
    }
    else if ( spawnindex == 2 )
    {
        offset = ( 32, 32, 0 );
    }
    else if ( spawnindex == 3 )
    {
        offset = ( -32, 0, 0 );
    }
    
    return offset;
}

// Namespace dom
// Params 2
// Checksum 0x88b1e9a4, Offset: 0x67a9
// Size: 0x70
function function_420eaefd3e54cba9( ownerteam, lastclaimteam )
{
    if ( ownerteam != "neutral" && self.ownerteam == ownerteam )
    {
        gameobjects::setobjectivestatusicons( level.icondefend, level.iconcapture );
        return;
    }
    
    if ( lastclaimteam != "none" )
    {
        gameobjects::setobjectivestatusicons( level.iconlosing, level.icontaking );
    }
}

// Namespace dom
// Params 0, eflags: 0x4
// Checksum 0xe93ff08b, Offset: 0x6821
// Size: 0x60a
function private function_759bc5823c6a5d3e()
{
    level.changenumdomflags = 0;
    primarytriggers = [];
    secondarytriggers = [];
    
    if ( level.usestrongholdhills )
    {
        triggers = getentarray( "hardpoint_zone", #targetname );
        
        if ( !isdefined( game[ "strongholdFlagKeys" ] ) || level.shufflehillroundcount > 0 && game[ "roundsPlayed" ] % level.shufflehillroundcount == 0 )
        {
            temptriggers = triggers;
            
            if ( isdefined( game[ "strongholdFlagKeys" ] ) )
            {
                removecount = randomintrange( 0, temptriggers.size - game[ "strongholdFlagKeys" ] );
                
                while ( removecount > 0 )
                {
                    randomtrigger = game[ "strongholdFlagKeys" ][ randomint( game[ "strongholdFlagKeys" ].size ) ];
                    game[ "strongholdFlagKeys" ] = arrayremove( game[ "strongholdFlagKeys" ], randomtrigger );
                    
                    foreach ( trigger in temptriggers )
                    {
                        if ( trigger.script_label == randomtrigger )
                        {
                            temptriggers = arrayremove( temptriggers, trigger );
                            removecount--;
                            break;
                        }
                    }
                }
            }
            
            alliestriggers = utility::get_array_of_closest( spawncamera::getstartspawnavg( "allies", "mp_dom_spawn_allies_start" ), temptriggers, undefined, 2 );
            randomtrigger = alliestriggers[ randomint( alliestriggers.size ) ];
            temptriggers = arrayremove( temptriggers, randomtrigger );
            game[ "strongholdFlagKeys" ][ 0 ] = randomtrigger.script_label;
            axistriggers = utility::get_array_of_closest( spawncamera::getstartspawnavg( "axis", "mp_dom_spawn_axis_start" ), temptriggers, undefined, 2 );
            randomtrigger = axistriggers[ randomint( axistriggers.size ) ];
            temptriggers = arrayremove( temptriggers, randomtrigger );
            game[ "strongholdFlagKeys" ][ 2 ] = randomtrigger.script_label;
            randomtrigger = temptriggers[ randomint( temptriggers.size ) ];
            temptriggers = arrayremove( temptriggers, randomtrigger );
            game[ "strongholdFlagKeys" ][ 1 ] = randomtrigger.script_label;
        }
        
        objectivekeys = [ "_a", "_b", "_c", "_d", "_e" ];
        objectivekeyindex = 0;
        
        foreach ( objectivekey in game[ "strongholdFlagKeys" ] )
        {
            foreach ( trigger in triggers )
            {
                if ( trigger.script_label != objectivekey )
                {
                    continue;
                }
                
                trigger.script_label = objectivekeys[ objectivekeyindex ];
                primarytriggers[ primarytriggers.size ] = trigger;
                objectivekeyindex++;
                break;
            }
        }
        
        level.changenumdomflags = getdvarint( @"scr_dom_flagcount", 3 );
    }
    else
    {
        triggers = getentarray( level.var_6d9bd8977e47e1a8, #targetname );
        secondarytriggers = getentarray( "flag_secondary", #targetname );
        
        if ( isdefined( game_utility::getlocaleid() ) )
        {
            foreach ( trigger in triggers )
            {
                if ( trigger.script_noteworthy == level.localeid )
                {
                    primarytriggers[ primarytriggers.size ] = trigger;
                    continue;
                }
                
                trigger delete();
            }
        }
        else
        {
            primarytriggers = triggers;
            level.changenumdomflags = getdvarint( @"scr_dom_flagcount", 0 );
        }
    }
    
    triggers = arraycombine( primarytriggers, secondarytriggers );
    sortedtriggers = [];
    
    foreach ( trigger in triggers )
    {
        index = obj_dom::getreservedobjid( trigger.script_label );
        sortedtriggers[ index ] = trigger;
    }
    
    triggers = sortedtriggers;
    
    if ( triggers.size < 2 )
    {
        assertmsg( "<dev string:x24>" );
        logstring( "[DOM] Not enough domination flags found in level! Perhaps you picked a localeID that was NOT set up" );
        return;
    }
    
    if ( level.changenumdomflags == 3 )
    {
        setomnvar( "ui_num_dom_flags", level.changenumdomflags );
    }
    else
    {
        setomnvar( "ui_num_dom_flags", primarytriggers.size );
    }
    
    foreach ( trigger in triggers )
    {
        if ( level.changenumdomflags == 3 )
        {
            if ( !level.usestrongholdhills )
            {
                if ( trigger.script_label == "_d" || trigger.script_label == "_e" )
                {
                    triggers = arrayremove( triggers, trigger );
                }
            }
        }
    }
    
    return triggers;
}

// Namespace dom
// Params 0, eflags: 0x4
// Checksum 0x55f427f7, Offset: 0x6e34
// Size: 0x215
function private function_641684784f5044ff()
{
    logstring( "[DOM] Constructing compiled game objects" );
    triggers = function_759bc5823c6a5d3e();
    var_427e930d7c73b9ff = [];
    
    if ( level.usestrongholdhills )
    {
        var_427e930d7c73b9ff = [ "hardpoint" ];
    }
    else if ( game_utility::function_ae97372c83da7acc() )
    {
        var_427e930d7c73b9ff = [ game_utility_mp::getbasegametype() ];
    }
    else if ( function_d1e292f023f6cfc9() )
    {
        var_427e930d7c73b9ff = [ "dom" ];
    }
    else
    {
        var_427e930d7c73b9ff = [ game_utility::getgametype() ];
    }
    
    game_utility_mp::clean_up_entities( var_427e930d7c73b9ff );
    
    foreach ( trigger in triggers )
    {
        var_24290c36e2cab388 = { #manual_drop:1, #var_7f4958ce4e4277c3:#"hash_bb332da19f9944df", #capture_segment_count:1, #var_333d3689d793bcc7:0, #use_time_seconds:0, #var_c68e9f43ed9cc918:#"hash_a1360b18943e920", #var_d7c90dc73c1dcba8:( 0, 0, 0 ), #objective_icon_offset:( 0, 0, 0 ), #angles:( 0, 0, 0 ), #origin:( 0, 0, 0 ) };
        var_24290c36e2cab388.origin = trigger.origin;
        var_24290c36e2cab388.angles = trigger.angles;
        var_24290c36e2cab388.use_time_seconds = level.flagcapturetime;
        var_24290c36e2cab388.var_333d3689d793bcc7 = level.var_e56cac0580f1c92c;
        gameobjects_common::initialize_game_object( trigger.targetname, var_24290c36e2cab388, trigger, &function_b9c14b5797567dc7 );
    }
}

// Namespace dom
// Params 2
// Checksum 0x7d07621f, Offset: 0x7051
// Size: 0x365
function function_b9c14b5797567dc7( gameobject, ignore_omnvar )
{
    assert( isdefined( gameobject ) );
    objectivekey = gameobjects_common::get_objective_key( gameobject );
    logstring( "[DOM] Game object constructed " + objectivekey );
    var_441b8d5f798c04a7 = gameobjects_common::get_objective_icon_offset( gameobject );
    var_624f6f859b8f2906 = gameobjects_common::get_origin( gameobject ) + var_441b8d5f798c04a7;
    gameobject.objectiveid = objidpoolmanager::requestobjectiveid();
    objidpoolmanager::objective_playermask_showtoall( gameobject.objectiveid );
    objidpoolmanager::objective_show_progress( gameobject.objectiveid, 1, 0 );
    objidpoolmanager::update_objective_position( gameobject.objectiveid, var_624f6f859b8f2906 );
    objidpoolmanager::update_objective_state( gameobject.objectiveid, "active" );
    gameobject thread function_f761898ef7e3450e( gameobject );
    function_fe778b0c2ed6058b( gameobject );
    captureflag::function_dfdb63cdb68b35ec( gameobject );
    trigger = gameobjects_shared::get_trigger( gameobject );
    
    if ( trigger && level.gametypebundle.var_204e7aa6b9e01102 )
    {
        gameobject thread domchevrons( trigger.target, trigger.script_label );
    }
    
    if ( !ignore_omnvar )
    {
        setomnvar( "ui_domflag" + objectivekey, gameobject.objectiveid );
    }
    
    game_utility_mp::add_gametype_objective( gameobject );
    gameobject callback::function_dc654a4d4126a928( #"hash_358d33b2497e2ce3", #"hash_6947ec89a1af6d69", &function_c793d15c3620056c );
    gameobject callback::function_dc654a4d4126a928( #"hash_5d939c5f097361e9", #"hash_6947ec89a1af6d69", &function_4aa2250c2e6c7f76 );
    gameobject callback::function_dc654a4d4126a928( #"hash_3c955b1e6fcd76eb", #"hash_6947ec89a1af6d69", &function_2631224efd1f6911 );
    gameobject callback::function_dc654a4d4126a928( #"hash_45277be78cb54c51", #"hash_6947ec89a1af6d69", &function_ee97f39f8c833909 );
    gameobject callback::function_dc654a4d4126a928( #"hash_47fedf1df6eafa30", #"hash_6947ec89a1af6d69", &function_a032ec7891f06137 );
    gameobject callback::function_dc654a4d4126a928( #"hash_a1e02ee2cc2ad28e", #"hash_6947ec89a1af6d69", &function_c25e59fc8ef48a75 );
    gameobject callback::function_dc654a4d4126a928( #"hash_3aba7df6443df11d", #"hash_6947ec89a1af6d69", &function_6ae8043c442bc880 );
    gameobject callback::function_dc654a4d4126a928( #"hash_2e3e0663aecb6f19", #"hash_6947ec89a1af6d69", &function_94c657c31ff66192 );
    gameobject callback::function_dc654a4d4126a928( #"hash_29eede2365f9349a", #"hash_6947ec89a1af6d69", &function_5456332977be02a1 );
    gameobject callback::function_dc654a4d4126a928( #"hash_33ab895f04e4eec9", #"hash_6947ec89a1af6d69", &function_7b51e2f669c8a21c );
    gameobject callback::function_dc654a4d4126a928( #"hash_a836ce9ab43d9e2", #"hash_6947ec89a1af6d69", &function_89d9426bf32e34b1 );
    gameobject callback::function_dc654a4d4126a928( #"hash_300ad54dcc9beab1", #"hash_6947ec89a1af6d69", &function_b487436a852b8ebc );
    gameobject callback::function_dc654a4d4126a928( #"hash_629949853fbabab8", #"hash_6947ec89a1af6d69", &function_88f750dd837992d9 );
    gameobject callback::function_dc654a4d4126a928( #"hash_e3206e8d5d3df1e3", #"hash_6947ec89a1af6d69", &function_9820a08ebba73154 );
    gameobject callback::function_dc654a4d4126a928( #"hash_a4277d17a7a228c9", #"hash_6947ec89a1af6d69", &function_4b1caf561945689b );
    gameobject callback::function_dc654a4d4126a928( #"hash_ae8f0f5e3b866b53", #"hash_6947ec89a1af6d69", &function_f7ad8a4ab703b229 );
    gameobjects_common::activate( gameobject );
}

// Namespace dom
// Params 1, eflags: 0x4
// Checksum 0xc7e5a01d, Offset: 0x73be
// Size: 0x43
function private function_c793d15c3620056c( params )
{
    assert( isdefined( params ) );
    gameobject = params.game_object;
    objidpoolmanager::objective_show_progress( gameobject.objectiveid, 1, 0 );
}

// Namespace dom
// Params 1, eflags: 0x4
// Checksum 0xa78c46a5, Offset: 0x7409
// Size: 0x56
function private function_4aa2250c2e6c7f76( params )
{
    assert( isdefined( params ) );
    gameobject = params.game_object;
    var_a1d5f513371e4fd2 = gameobjects_shared::function_7ed0697b0eea44f8( gameobject );
    objidpoolmanager::objective_show_progress( gameobject.objectiveid, istrue( var_a1d5f513371e4fd2 ), 0 );
}

// Namespace dom
// Params 1, eflags: 0x4
// Checksum 0xecb1e6c6, Offset: 0x7467
// Size: 0x78
function private function_2631224efd1f6911( params )
{
    assert( isdefined( params ) );
    gameobject = params.game_object;
    player = params.player;
    player.var_c36e159445e2a48b = 0;
    objidpoolmanager::objective_pin_player( gameobject.objectiveid, player );
    objidpoolmanager::function_b3b969f2930890eb( 2, player );
    gameobject update_chevrons();
}

// Namespace dom
// Params 1, eflags: 0x4
// Checksum 0x2745ca0d, Offset: 0x74e7
// Size: 0x75
function private function_ee97f39f8c833909( params )
{
    assert( isdefined( params ) );
    gameobject = params.game_object;
    player = params.player;
    player.var_c36e159445e2a48b = undefined;
    objidpoolmanager::objective_unpin_player( gameobject.objectiveid, player );
    objidpoolmanager::function_b3b969f2930890eb( 0, player );
    gameobject update_chevrons();
}

// Namespace dom
// Params 1, eflags: 0x4
// Checksum 0xd478db68, Offset: 0x7564
// Size: 0x2e5
function private function_a032ec7891f06137( params )
{
    assert( isdefined( params ) );
    gameobject = params.game_object;
    claimteam = params.claim_team_name;
    progress = params.progress;
    instanceid = params.instance_id;
    objidpoolmanager::objective_set_progress( gameobject.objectiveid, progress );
    currenttime = gettime();
    
    if ( !level.gameended && !game_utility_mp::isanymlgmatch() )
    {
        if ( !isdefined( gameobject.lastsfxplayedtime ) )
        {
            gameobject.lastsfxplayedtime = currenttime;
        }
        
        if ( gameobject.lastsfxplayedtime + 995 < currenttime )
        {
            gameobject.lastsfxplayedtime = currenttime;
            sfxalias = "shared_obj_capturing_tick_0" + int( floor( progress * 10 ) );
            gameobject.visuals gameplay_sound_fx::function_6dac8db778849e61( sfxalias, claimteam );
        }
    }
    
    if ( !gameobject.didstatusnotify && !level.var_4a5de2a2eae8e2b0 )
    {
        if ( gameobjects_shared::get_use_time_seconds( gameobject ) > 0.05 )
        {
            owningteam = gameobjects_shared::function_623b07f4735aecb2( gameobject );
            
            if ( owningteam == "none" )
            {
                dialog::statusdialog( hashcat( #"securing", gameobject.objective_key ), claimteam );
                var_3d64f5747cc7629d = game_utility_mp::get_gametype_objectives( instanceid );
                var_b2b6bae7f24d97f4 = var_3d64f5747cc7629d.size == 3 && !level.ingraceperiod;
                var_f9fa407a53254866 = var_3d64f5747cc7629d.size == 5 && ( gameobject.objective_key == "_b" || gameobject.objective_key == "_c" || gameobject.objective_key == "_d" );
                
                if ( var_b2b6bae7f24d97f4 || var_f9fa407a53254866 )
                {
                    otherteam = team_utility::getotherteam( claimteam );
                    dialog::statusdialog( hashcat( #"losing", gameobject.objective_key ), otherteam );
                }
            }
            else if ( owningteam != claimteam )
            {
                var_56dd2b153c7e8453 = function_416df059ecaa6370( claimteam );
                var_33a2a9c55ab5588 = var_56dd2b153c7e8453 ? #"securing_all" : hashcat( #"securing", gameobject.objective_key );
                var_118f7c6f75034a00 = var_56dd2b153c7e8453 ? #"losing_all" : hashcat( #"losing", gameobject.objective_key );
                dialog::statusdialog( var_33a2a9c55ab5588, claimteam );
                dialog::statusdialog( var_118f7c6f75034a00, owningteam );
            }
        }
        
        gameobject.didstatusnotify = 1;
    }
}

// Namespace dom
// Params 1, eflags: 0x4
// Checksum 0x239519e2, Offset: 0x7851
// Size: 0x6c
function private function_c25e59fc8ef48a75( params )
{
    assert( isdefined( params ) );
    gameobject = params.game_object;
    var_3d152e00ebf9f46d = params.var_dbd0d4c325a7ae15;
    var_380e1341c05f576b = params.var_2b03add3a518dea6;
    objidpoolmanager::objective_show_progress( gameobject.objectiveid, 0, 0 );
}

// Namespace dom
// Params 1, eflags: 0x4
// Checksum 0xf62f2272, Offset: 0x78c5
// Size: 0x11d
function private function_6ae8043c442bc880( params )
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
    gameobject update_chevrons();
}

// Namespace dom
// Params 1, eflags: 0x4
// Checksum 0xb7c374b6, Offset: 0x79ea
// Size: 0x11d
function private function_94c657c31ff66192( params )
{
    assert( isdefined( params ) );
    gameobject = params.game_object;
    teamname = params.team_name;
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
    gameobject update_chevrons();
}

// Namespace dom
// Params 1, eflags: 0x4
// Checksum 0x884e83a8, Offset: 0x7b0f
// Size: 0x11d
function private function_5456332977be02a1( params )
{
    assert( isdefined( params ) );
    gameobject = params.game_object;
    teamname = params.team_name;
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
    gameobject update_chevrons();
}

// Namespace dom
// Params 1, eflags: 0x4
// Checksum 0x5f08140b, Offset: 0x7c34
// Size: 0x14e
function private function_7b51e2f669c8a21c( params )
{
    assert( isdefined( params ) );
    gameobject = params.game_object;
    teamname = params.team_name;
    var_3d152e00ebf9f46d = params.var_dbd0d4c325a7ae15;
    var_380e1341c05f576b = params.var_2b03add3a518dea6;
    function_70d9106ee4ee7de7( gameobject, var_3d152e00ebf9f46d, 0 );
    
    foreach ( var_30fcb423957c4d9a in var_380e1341c05f576b )
    {
        function_70d9106ee4ee7de7( gameobject, var_30fcb423957c4d9a, 1 );
    }
    
    lastowningteam = gameobjects_shared::function_55c8ebe2dd649ae5( gameobject );
    gameplay_sound_fx::function_6dac8db778849e61( #"dom_flag_neutralized_friendly", var_3d152e00ebf9f46d.team );
    gameplay_sound_fx::function_6dac8db778849e61( #"dom_flag_neutralized_enemy", lastowningteam );
    level notify( #"dom_flag_neutralized", gameobject.objective_key );
    gameobject notify( #"dom_flag_neutralized" );
}

// Namespace dom
// Params 1, eflags: 0x4
// Checksum 0x34969772, Offset: 0x7d8a
// Size: 0x48d
function private function_89d9426bf32e34b1( params )
{
    assert( isdefined( params ) );
    gameobject = params.game_object;
    team = params.team_name;
    var_3d152e00ebf9f46d = params.var_dbd0d4c325a7ae15;
    var_380e1341c05f576b = params.var_2b03add3a518dea6;
    instanceid = params.instance_id;
    level.playholdtwovo = 1;
    gameobject.capturetime = gettime();
    otherteam = team_utility::getotherteam( team );
    teamflagcount = captureflag::function_ae0c1c2a2553b7d( team, 0 );
    var_c1b7d65faf530406 = captureflag::function_ae0c1c2a2553b7d( otherteam, 0 );
    var_3d64f5747cc7629d = game_utility_mp::get_gametype_objectives( instanceid );
    
    if ( !isdefined( level.teamscoresonkill ) )
    {
        level.teamscoresonkill[ team ] = teamflagcount >= level.numflagsscoreonkill && teamflagcount >= level.flagsrequiredtoscore;
        level.teamscoresonkill[ otherteam ] = var_c1b7d65faf530406 >= level.numflagsscoreonkill && var_c1b7d65faf530406 >= level.flagsrequiredtoscore;
    }
    
    if ( !isagent( var_3d152e00ebf9f46d ) || bots::function_e8c1a1cd1aaa5f82( var_3d152e00ebf9f46d ) )
    {
        hud_util::teamplayercardsplash( "callout_securedposition" + gameobject.objective_key, var_3d152e00ebf9f46d );
    }
    
    function_e1e9267b0fce374b( gameobject, var_3d152e00ebf9f46d );
    function_a76fd5e4a4f8281e( gameobject, var_3d152e00ebf9f46d, 0 );
    
    foreach ( var_30fcb423957c4d9a in var_380e1341c05f576b )
    {
        function_e1e9267b0fce374b( gameobject, var_30fcb423957c4d9a );
        function_a76fd5e4a4f8281e( gameobject, var_30fcb423957c4d9a, 1 );
    }
    
    if ( level.usestrongholdscoring )
    {
        if ( teamflagcount == level.flagsrequiredtoscore )
        {
            dialog::statusdialog( #"friendly_scoring", team );
            dialog::statusdialog( #"enemy_scoring", otherteam );
        }
    }
    
    var_3d152e00ebf9f46d codcasterclientmatchdata::function_8ecc753b54a5740f( 15, 1 );
    
    if ( teamflagcount < var_3d64f5747cc7629d.size )
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
    
    var_d64a5f75a8ae9938 = teamflagcount == var_3d64f5747cc7629d.size ? #"dom_flag_captured_all" : #"dom_flag_captured";
    var_ec9f18f23b5e8565 = teamflagcount == var_3d64f5747cc7629d.size ? #"dom_flag_lost_all" : #"dom_flag_lost";
    gameplay_sound_fx::function_e319dc8e16c85fcb( var_d64a5f75a8ae9938, teams::getteamdata( team, "players" ) );
    gameplay_sound_fx::function_e319dc8e16c85fcb( var_ec9f18f23b5e8565, teams::getteamdata( otherteam, "players" ) );
    
    if ( function_d1e292f023f6cfc9() )
    {
        gamescore::giveteamscoreforobjective( var_3d152e00ebf9f46d.team, 1, 1, undefined );
        objidpoolmanager::returnobjectiveid( gameobject.objectiveid );
        gameobjects_shared::deactivate( gameobject );
    }
    
    level notify( #"dom_flag_captured", gameobject.objective_key );
    gameobject notify( #"dom_flag_captured" );
    var_3d152e00ebf9f46d notify( #"player_zone_captured", gameobject.objective_key );
    gameobject thread set_chevron_state( team );
}

// Namespace dom
// Params 1, eflags: 0x4
// Checksum 0x358603b3, Offset: 0x821f
// Size: 0x19c
function private function_b487436a852b8ebc( params )
{
    assert( isdefined( params ) );
    gameobject = params.game_object;
    objidpoolmanager::update_objective_sethot( gameobject.objectiveid, 1 );
    
    if ( !isdefined( game[ "dom" ].var_5d763679686d0227 ) )
    {
        game[ "dom" ].var_5d763679686d0227 = 0;
    }
    
    currenttime = gettime();
    objective_key = gameobjects_shared::get_objective_key( gameobject );
    var_27906a41998083f3 = function_8cfc872a120fd13c();
    announcer_vo = var_27906a41998083f3 ? #"contested_all" : hashcat( #"contested", objective_key );
    
    foreach ( team_name in level.teamnamelist )
    {
        dialog::statusdialog( announcer_vo, team_name );
    }
    
    if ( game[ "dom" ].var_5d763679686d0227 < currenttime )
    {
        gameobjectorigin = gameobjects_shared::get_origin( gameobject );
        gameplay_sound_fx::function_28103d3430792dce( gameobjectorigin, #"dom_flag_contested" );
        game[ "dom" ].var_5d763679686d0227 = currenttime + 3000;
    }
    
    gameobject thread set_chevron_state( "contested" );
}

// Namespace dom
// Params 1, eflags: 0x4
// Checksum 0xb448e6d6, Offset: 0x83c3
// Size: 0x141
function private function_88f750dd837992d9( params )
{
    assert( isdefined( params ) );
    gameobject = params.game_object;
    objidpoolmanager::update_objective_sethot( gameobject.objectiveid, 0 );
    
    if ( gameobjects_shared::function_7ed0697b0eea44f8( gameobject ) )
    {
        objidpoolmanager::objective_show_progress( gameobject.objectiveid, 1, 0 );
    }
    
    owningteam = gameobjects_shared::function_623b07f4735aecb2( gameobject );
    lastclaimteam = gameobjects_shared::function_b94c7e25e2a759f7( gameobject );
    
    if ( lastclaimteam == "none" || owningteam == "none" )
    {
        gameobject.didstatusnotify = undefined;
    }
    
    if ( !isdefined( game[ "dom" ].var_b286385cbd912509 ) )
    {
        game[ "dom" ].var_b286385cbd912509 = 0;
    }
    
    currenttime = gettime();
    
    if ( game[ "dom" ].var_b286385cbd912509 < currenttime )
    {
        trigger = gameobjects_shared::get_trigger( gameobject );
        gameplay_sound_fx::function_28103d3430792dce( trigger.origin, #"dom_flag_uncontested" );
        game[ "dom" ].var_b286385cbd912509 = currenttime + 3000;
    }
    
    gameobject update_chevrons();
}

// Namespace dom
// Params 1, eflags: 0x4
// Checksum 0x9b257f61, Offset: 0x850c
// Size: 0x47
function private function_9820a08ebba73154( params )
{
    assert( isdefined( params ) );
    gameobject = params.game_object;
    gameobject.didstatusnotify = undefined;
    gameobject thread set_chevron_state( "idle" );
}

// Namespace dom
// Params 1, eflags: 0x4
// Checksum 0x462e5180, Offset: 0x855b
// Size: 0xe3
function private function_4b1caf561945689b( params )
{
    assert( isdefined( params ) );
    gameobject = params.game_object;
    var_afaf5a82e343815a = params.var_3fb67f294d22fb9a;
    
    foreach ( player in var_afaf5a82e343815a )
    {
        function_a0a44b051aa5b4e2( gameobject, player );
        player stats::setextrascore2( player.pers[ "extrascore2" ] + 1 );
    }
    
    gameplay_sound_fx::function_e319dc8e16c85fcb( #"hash_c2dafde3d41b7bf7", var_afaf5a82e343815a );
}

// Namespace dom
// Params 1, eflags: 0x4
// Checksum 0xe07b385f, Offset: 0x8646
// Size: 0x1e
function private function_f7ad8a4ab703b229( params )
{
    function_fe778b0c2ed6058b( params.game_object );
}

// Namespace dom
// Params 1, eflags: 0xc
// Checksum 0x1644d04f, Offset: 0x866c
// Size: 0x67
function private function_f761898ef7e3450e( gameobject )
{
    self notify( #"hash_63fe7812c70f83de" );
    self endon( #"hash_63fe7812c70f83de" );
    level endon( #"game_ended" );
    flags::function_2f3408423ccc9b2e( "prematch_done" );
    objidpoolmanager::objective_set_play_intro( gameobject.objectiveid, 1 );
    objidpoolmanager::update_objective_state( gameobject.objectiveid, "current" );
}

// Namespace dom
// Params 10, eflags: 0x4
// Checksum 0xb7872c6d, Offset: 0x86db
// Size: 0x6d0
function private function_f82a470d9b7f1c39( einflictor, attacker, idamage, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, deathanimduration, killid )
{
    if ( isagent( attacker ) )
    {
        return;
    }
    
    if ( !( isdefined( attacker ) && isdefined( self ) ) )
    {
        return;
    }
    
    if ( !( isdefined( attacker.team ) && isdefined( self.team ) ) )
    {
        return;
    }
    
    if ( !attacker player_utility::isenemy( self ) )
    {
        return;
    }
    
    var_61293d73c097c1c = 0;
    awardedassault = 0;
    awardeddefend = 0;
    victim = self;
    victimorigin = victim.origin;
    attackerorigin = attacker.origin;
    
    if ( isdefined( einflictor ) )
    {
        attackerposition = einflictor.origin;
    }
    
    instanceid = gameinstance::get_instance_id( victim.team );
    
    foreach ( gameobject in game_utility_mp::get_gametype_objectives( instanceid ) )
    {
        if ( !gameobjects_shared::is_activated( gameobject ) )
        {
            continue;
        }
        
        owningteam = gameobjects_shared::function_623b07f4735aecb2( gameobject );
        var_3585c67984f0d918 = gameobjects_common::function_6057f2c78ba2b3a2( gameobject, attacker );
        var_9b43c11c6592a807 = gameobjects_common::function_6057f2c78ba2b3a2( gameobject, victim );
        
        if ( var_3585c67984f0d918 )
        {
            if ( owningteam == attacker.team )
            {
                if ( isdefined( attacker.var_c36e159445e2a48b ) )
                {
                    attacker.var_c36e159445e2a48b++;
                    
                    if ( attacker.var_c36e159445e2a48b == 5 )
                    {
                        attacker thread events::function_d4fd7d540188e407();
                    }
                }
            }
            else if ( !level.scoreeventglobals.var_d25fb6c0265395c5 )
            {
                attacker points::function_aa3f27bc29d005fc( #"capture_kill" );
                awardedassault = 1;
            }
        }
        
        if ( owningteam == "none" )
        {
            if ( var_3585c67984f0d918 || var_9b43c11c6592a807 )
            {
                claimteam = gameobjects_shared::function_d071a38f7d43555a( gameobject );
                
                if ( claimteam == victim.team )
                {
                    if ( !awardedassault )
                    {
                        attacker rank::function_d2aa8986c506e985( #"assault" );
                        attacker events::function_58da673c1c3fc9f2();
                        utility::trycall( level.matchdata_logattackerkillevent, killid, "assaulting" );
                        awardedassault = 1;
                        continue;
                    }
                }
                else if ( claimteam == attacker.team )
                {
                    if ( !awardeddefend )
                    {
                        attacker rank::function_d2aa8986c506e985( #"defend", gameobject.objective_key );
                        attacker events::function_20a5f572df6afd43( { #extraparam:gameobject.objective_key } );
                        
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
                            
                            assert( isint( 1 ) || isfloat( 1 ), "<dev string:x1e0>" );
                            
                            if ( isdefined( attacker.pers[ "defends" ] ) )
                            {
                                attacker.pers[ "defends" ] = attacker.pers[ "defends" ] + 1;
                            }
                        }
                        
                        attacker persistence::statsetchild( "round", "defends", attacker.pers[ "defends" ] );
                        attacker stats::setextrascore1( attacker.pers[ "defends" ] );
                        utility::trycall( level.matchdata_logattackerkillevent, killid, "defending" );
                        awardeddefend = 1;
                        continue;
                    }
                }
            }
            
            continue;
        }
        
        if ( owningteam != attacker.team )
        {
            if ( !awardedassault )
            {
                if ( var_3585c67984f0d918 || !level.scoreeventglobals.var_4c03945aaec4f6b7 && function_dad8f52162d4d891( gameobject, attacker.origin, victim.origin ) )
                {
                    attacker rank::function_d2aa8986c506e985( #"assault" );
                    attacker events::function_58da673c1c3fc9f2();
                    
                    if ( var_9b43c11c6592a807 )
                    {
                        attacker thread events::function_f3b6ddfecdb144fa( gameobject.objective_key );
                    }
                    
                    utility::trycall( level.matchdata_logattackerkillevent, killid, "assaulting" );
                    awardedassault = 1;
                    continue;
                }
            }
            
            continue;
        }
        
        if ( !awardeddefend )
        {
            if ( var_9b43c11c6592a807 || !level.scoreeventglobals.var_4c03945aaec4f6b7 && function_dad8f52162d4d891( gameobject, attacker.origin, victim.origin ) )
            {
                attacker rank::function_d2aa8986c506e985( #"defend", gameobject.objective_key );
                attacker events::function_20a5f572df6afd43( { #extraparam:gameobject.objective_key } );
                
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
                    
                    assert( isint( 1 ) || isfloat( 1 ), "<dev string:x1e0>" );
                    
                    if ( isdefined( attacker.pers[ "defends" ] ) )
                    {
                        attacker.pers[ "defends" ] = attacker.pers[ "defends" ] + 1;
                    }
                }
                
                attacker persistence::statsetchild( "round", "defends", attacker.pers[ "defends" ] );
                attacker stats::setextrascore1( attacker.pers[ "defends" ] );
                utility::trycall( level.matchdata_logattackerkillevent, killid, "defending" );
                awardeddefend = 1;
            }
        }
    }
}

// Namespace dom
// Params 3
// Checksum 0x790057c0, Offset: 0x8db3
// Size: 0x8b
function function_70d9106ee4ee7de7( gameobject, player, isassist )
{
    assert( isdefined( gameobject ) && isdefined( player ) && isdefined( isassist ) );
    
    if ( bots::function_e8c1a1cd1aaa5f82( player ) )
    {
        player rank::function_d2aa8986c506e985( #"neutralized_capture_bot" );
        player points::doscoreevent( #"mode_dom_neutralized_capture_bot" );
        return;
    }
    
    player rank::function_d2aa8986c506e985( #"neutralized" );
    player points::doscoreevent( #"mode_dom_neutralized" );
}

// Namespace dom
// Params 2
// Checksum 0xe0ac6ed6, Offset: 0x8e46
// Size: 0xd6
function function_e1e9267b0fce374b( gameobject, player )
{
    assert( isdefined( gameobject ) && isdefined( player ) );
    
    if ( !isdefined( player.leaderboarddata[ "captures" ] ) )
    {
        player.leaderboarddata[ "captures" ] = 0;
    }
    
    if ( !isdefined( player.pers[ "captures" ] ) )
    {
        player.pers[ "captures" ] = 0;
    }
    
    player.leaderboarddata[ "captures" ]++;
    player.pers[ "captures" ]++;
    player persistence::statsetchild( "round", "captures", player.pers[ "captures" ] );
    player stats::setextrascore0( player.pers[ "captures" ] );
}

// Namespace dom
// Params 3
// Checksum 0xe07e2799, Offset: 0x8f24
// Size: 0x1d8
function function_a76fd5e4a4f8281e( gameobject, player, isassist )
{
    assert( isdefined( gameobject ) && isdefined( player ) && isdefined( isassist ) );
    
    if ( isassist && !level.gamemodebundle.var_9a091b8fbf3b4e70 )
    {
        if ( bots::function_e8c1a1cd1aaa5f82( player ) )
        {
            player points::doscoreevent( #"capture_assist_capture_bot" );
            return;
        }
        
        player rank::function_d2aa8986c506e985( #"capture_assist" );
        player points::doscoreevent( #"mode_dom_secure_assist" );
        return;
    }
    
    lastowningteam = gameobjects_shared::function_55c8ebe2dd649ae5( gameobject );
    
    if ( lastowningteam == "none" )
    {
        if ( gameobject.objective_key == "_b" )
        {
            if ( bots::function_e8c1a1cd1aaa5f82( player ) )
            {
                player points::doscoreevent( #"neutral_b_capture_capture_bot" );
            }
            else
            {
                player rank::function_d2aa8986c506e985( #"neutral_b_capture", gameobject.objective_key );
                player points::doscoreevent( #"mode_dom_secure_b" );
                player smoke_grenade::function_99543ad5d551cdb5();
            }
        }
        else if ( bots::function_e8c1a1cd1aaa5f82( player ) )
        {
            player points::doscoreevent( #"neutral_capture_capture_bot" );
        }
        else
        {
            player rank::function_d2aa8986c506e985( #"neutral_capture", gameobject.objective_key );
            player points::doscoreevent( #"mode_dom_secure_neutral" );
            player smoke_grenade::function_99543ad5d551cdb5();
        }
        
        return;
    }
    
    if ( bots::function_e8c1a1cd1aaa5f82( player ) )
    {
        player points::doscoreevent( #"capture_capture_bot" );
        return;
    }
    
    player rank::function_d2aa8986c506e985( #"capture", gameobject.objective_key );
    player points::doscoreevent( #"mode_dom_secure" );
    player smoke_grenade::function_99543ad5d551cdb5();
}

// Namespace dom
// Params 2
// Checksum 0xc585d359, Offset: 0x9104
// Size: 0x99
function function_a0a44b051aa5b4e2( gameobject, player )
{
    assert( isdefined( gameobject ) && isdefined( player ) );
    
    if ( bots::function_e8c1a1cd1aaa5f82( player ) )
    {
        player points::doscoreevent( #"obj_prog_defend_capture_bot" );
        return;
    }
    
    player events::function_a7d373228760063b();
    objectivekey = gameobjects_shared::get_objective_key( gameobject );
    
    if ( player.defenderskilled[ objectivekey ] > 1 )
    {
        player points::doscoreevent( #"hash_d0f5c98414382d61" );
        player.defenderskilled[ objectivekey ] = 0;
    }
}

// Namespace dom
// Params 3, eflags: 0x4
// Checksum 0x8771dadc, Offset: 0x91a5
// Size: 0xa0, Type: bool
function private function_dad8f52162d4d891( gameobject, attackerorigin, victimorigin )
{
    assert( isdefined( gameobject ) && isdefined( attackerorigin ) && isdefined( victimorigin ) );
    origin = gameobjects_shared::get_origin( gameobject );
    var_bf527c1dac7b6503 = distancesquared( origin, attackerorigin );
    var_46d2631e2ffc1956 = distancesquared( origin, victimorigin );
    
    if ( var_bf527c1dac7b6503 <= 90000 || var_46d2631e2ffc1956 <= 90000 )
    {
        return ( attackerorigin[ 2 ] - origin[ 2 ] < 100 || victimorigin[ 2 ] - origin[ 2 ] < 100 );
    }
    
    return false;
}

// Namespace dom
// Params 2, eflags: 0x4
// Checksum 0x6f33ea4, Offset: 0x924e
// Size: 0x130
function private function_d82fa675e7fef8dd( team, excludedflag )
{
    assert( isdefined( team ) );
    bestflag = undefined;
    bestdistancesquared = undefined;
    instanceid = gameinstance::get_instance_id( team );
    
    foreach ( gameobject in game_utility_mp::get_gametype_objectives( instanceid ) )
    {
        if ( namespace_277c922f0d0dc523::function_79ed8dd2c414e8ed( gameobject ) )
        {
            continue;
        }
        
        if ( isdefined( excludedflag ) && gameobject.objective_key == excludedflag.objective_key )
        {
            continue;
        }
        
        objectiveorigin = gameobjects_shared::get_origin( gameobject );
        distancesquared = distancesquared( objectiveorigin, level.startpos[ team ] );
        
        if ( !isdefined( bestflag ) || distancesquared < bestdistancesquared )
        {
            bestdistancesquared = distancesquared;
            bestflag = gameobject;
        }
    }
    
    return bestflag;
}

// Namespace dom
// Params 1, eflags: 0x4
// Checksum 0x36884452, Offset: 0x9387
// Size: 0xf7
function private function_49148839963426f0( gameobject )
{
    assert( isdefined( gameobject ) );
    spawnset = undefined;
    
    switch ( gameobject.objective_key )
    {
        case #"hash_fac2c5f6bddd49bd":
            spawnset = #"zonea";
            break;
        case #"hash_fac2c2f6bddd4504":
            spawnset = #"zoneb";
            break;
        case #"hash_fac2c3f6bddd4697":
            spawnset = #"zonec";
            break;
        case #"hash_fac2c0f6bddd41de":
            spawnset = #"zoned";
            break;
        case #"hash_fac2c1f6bddd4371":
            spawnset = #"zonee";
            break;
        default:
            break;
    }
    
    spawnpoints = spawnlogic::getspawnset( spawnset );
    
    if ( isdefined( spawnpoints ) && spawnpoints.size > 0 )
    {
        gameobject.spawnset = spawnset;
    }
}

// Namespace dom
// Params 1, eflags: 0x4
// Checksum 0x66db9b68, Offset: 0x9486
// Size: 0x68
function private function_b108a7e40cb063c1( gameobject )
{
    assert( isdefined( gameobject ) );
    gameobject.influencerkeys[ "owner" ] = #"gametype_dom_owner_team";
    gameobject.influencerkeys[ "other" ] = #"gametype_dom_other_team";
    gameobject.influencerkeys[ "neutral" ] = #"gametype_dom_other_team";
}

// Namespace dom
// Params 1, eflags: 0x4
// Checksum 0x2b7e9f03, Offset: 0x94f6
// Size: 0x287
function private function_fe778b0c2ed6058b( gameobject )
{
    assert( isdefined( gameobject ) );
    var_4a7cd465ff58f423 = namespace_277c922f0d0dc523::get_claim_team_hash( gameobject );
    var_543da7845de195ab = namespace_277c922f0d0dc523::function_9b71aa2788e21706( gameobject );
    var_92274902a4720e10 = namespace_277c922f0d0dc523::function_a33241bbed7a745d( gameobject );
    
    if ( var_4a7cd465ff58f423 == #"hash_a1360b18943e920" )
    {
        if ( gameobject.overcap_index > 0 )
        {
            statehash = hashcat( #"flag_contested", gameobjects_shared::get_objective_key( gameobject ), gameobject.overcap_index );
        }
        else
        {
            statehash = hashcat( #"flag_contested", gameobjects_shared::get_objective_key( gameobject ) );
        }
        
        namespace_1cdb218d68ef13f6::set_objective_icon_state( gameobject.objectiveid, statehash );
        return;
    }
    
    if ( var_543da7845de195ab == #"hash_bb332da19f9944df" || var_4a7cd465ff58f423 == #"hash_bb332da19f9944df" )
    {
        if ( gameobject.overcap_index > 0 )
        {
            statehash = hashcat( #"flag_idle", gameobjects_shared::get_objective_key( gameobject ), gameobject.overcap_index );
        }
        else
        {
            statehash = hashcat( #"flag_idle", gameobjects_shared::get_objective_key( gameobject ) );
        }
        
        namespace_1cdb218d68ef13f6::set_objective_icon_state( gameobject.objectiveid, statehash );
        return;
    }
    
    if ( var_543da7845de195ab != var_4a7cd465ff58f423 )
    {
        if ( gameobject.overcap_index > 0 )
        {
            statehash = hashcat( #"hash_539be8fb439cd022", gameobjects_shared::get_objective_key( gameobject ), gameobject.overcap_index );
        }
        else
        {
            statehash = hashcat( #"hash_539be8fb439cd022", gameobjects_shared::get_objective_key( gameobject ) );
        }
        
        namespace_1cdb218d68ef13f6::set_objective_icon_state( gameobject.objectiveid, statehash );
        return;
    }
    
    if ( var_92274902a4720e10 == #"hash_bb332da19f9944df" )
    {
        if ( gameobject.overcap_index > 0 )
        {
            statehash = hashcat( #"flag_defending", gameobjects_shared::get_objective_key( gameobject ), gameobject.overcap_index );
        }
        else
        {
            statehash = hashcat( #"flag_defending", gameobjects_shared::get_objective_key( gameobject ) );
        }
        
        namespace_1cdb218d68ef13f6::set_objective_icon_state( gameobject.objectiveid, statehash );
        return;
    }
    
    if ( gameobject.overcap_index > 0 )
    {
        statehash = hashcat( #"flag_clearing", gameobjects_shared::get_objective_key( gameobject ), gameobject.overcap_index );
    }
    else
    {
        statehash = hashcat( #"flag_clearing", gameobjects_shared::get_objective_key( gameobject ) );
    }
    
    namespace_1cdb218d68ef13f6::set_objective_icon_state( gameobject.objectiveid, statehash );
}

// Namespace dom
// Params 1, eflags: 0x4
// Checksum 0x5b070592, Offset: 0x9785
// Size: 0x99, Type: bool
function private function_416df059ecaa6370( team_name )
{
    foreach ( game_object in level.objectives )
    {
        claim_team_name = gameobjects_shared::function_d071a38f7d43555a( game_object );
        
        if ( team_name != claim_team_name )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace dom
// Params 0, eflags: 0x4
// Checksum 0x6b0114a0, Offset: 0x9827
// Size: 0x82, Type: bool
function private function_8cfc872a120fd13c()
{
    foreach ( game_object in level.objectives )
    {
        if ( !gameobjects_shared::function_3d275bfdb7872815( game_object ) )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace dom
// Params 0, eflags: 0x4
// Checksum 0x8914201a, Offset: 0x98b2
// Size: 0x1b, Type: bool
function private function_d1e292f023f6cfc9()
{
    return level.dominationdata.dominationscoring == "LockoutScoring";
}

