// scripts\mp\br\gametypes\br_gametype_prop.gsc  (hash_3cfeb79dbb96e640.gscc) (size: 46439 Bytes / 0xb567 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x7094b548 (1888793928)
// size ...... 46439 (0xb567)
// includes .. 35  (offset: 0xa98b)
// strings ... 147 (offset: 0xaaa3)
// dev strs .. 10  (offset: 0xb4eb)
// exports ... 119 (offset: 0x7283)
// cseg ...... 0xafd + 0x6786 (0x7283)
// imports ... 296 (offset: 0x851b)
// animtree1 . 0   (offset: 0xb567)
// animtree2 . 0   (offset: 0xb567)
#using scripts\common\callbacks;
#using scripts\common\game_utility;
#using scripts\common\math;
#using scripts\common\utility;
#using scripts\mp\br\gametypes\br;
#using scripts\mp\br\gametypes\br_gametypes;
#using scripts\mp\br\gametypes\br_infils_legacy;
#using scripts\mp\br\gametypes\br_infils_util;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\br\gametypes\br_weapons;
#using scripts\mp\class;
#using scripts\mp\common\equipment\concussion_grenade;
#using scripts\mp\common\utility\disconnect_event_aggregator;
#using scripts\mp\common\utility\dvars;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\team_utility;
#using scripts\mp\damage;
#using scripts\mp\damagefeedback;
#using scripts\mp\equipment;
#using scripts\mp\final_killcam;
#using scripts\mp\flags;
#using scripts\mp\gamelogic;
#using scripts\mp\gamescore;
#using scripts\mp\hud_util;
#using scripts\mp\menus;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\playerlogic;
#using scripts\mp\rank;
#using scripts\mp\spectating;
#using scripts\mp\vehicles\vehicle_occupancy_mp;
#using scripts\mp\weapons;

#namespace br_gametype_prop;

// Namespace br_gametype_prop
// Params 0, eflags: 0x1
// Checksum 0xf2142d46, Offset: 0xb1b
// Size: 0x19
function autoexec main()
{
    if ( game_utility::getgametype() != "prop" )
    {
        return;
    }
    
    init();
}

// Namespace br_gametype_prop
// Params 0
// Checksum 0x9caf7d8f, Offset: 0xb3c
// Size: 0x469
function init()
{
    level.ph = spawnstruct();
    level.ph.settings = spawnstruct();
    level.ph.settings.prophidetime = getdvarint( @"hash_8e4a062e9af4ef42", 30 );
    level.ph.settings.propwhistletime = getdvarint( @"hash_8f11dd5f31d2b118", 30 );
    level.ph.settings.propchangecount = getdvarint( @"hash_924023ccb1db8a0c", 2 );
    level.ph.settings.propnumflashes = getdvarint( @"hash_5435ebb8d269f904", 1 );
    level.ph.settings.propnumclones = getdvarint( @"hash_713207d4c9a03261", 3 );
    level.ph.settings.propspeedscale = getdvarfloat( @"hash_ea1dfd714873e898", 1.4 );
    level.ph.settings.modetype = getdvarint( @"hash_7c5e401a3acc5cdd", 0 );
    level.ph.settings.numhunters = getdvarint( @"hash_da976e06b127dadd", 20 );
    level.ph.settings.numpropsperarea = getdvarint( @"hash_77b7a4ad4851900a", 30 );
    
    if ( level.ph.settings.modetype == 1 )
    {
        level.objectivebased = 1;
        level.checkforovertime = &ph_checkforovertime;
        level.getgamewinnerfunc = &getgamewinnerprop;
        level.gametyperoundendscoresetomnvar = &gametyperoundendscoresetomnvar;
    }
    
    level.isprophunt = 1;
    level.allowlatecomers = 1;
    level.autoassignlowteamconsistent = 1;
    level.disablespawningforplayerfunc = &disablespawningforplayer;
    level.checkunscoredspawnpoint = &checkunscoredspawnpoint;
    utility::registersharedfunc( #"gametype", #"hash_e1a48c13a7e1e696", &onstartgametype );
    utility::registersharedfunc( #"gametype", #"hash_f35ff151066da2df", &gamemodemodifyplayerdamage );
    utility::registersharedfunc( #"gametype", #"hash_a407cc94ad2c6279", &onplayerconnect );
    utility::registersharedfunc( #"gametype", #"hash_673db8bb5562ee19", &playerskiplootpickup );
    utility::registersharedfunc( #"gametype", #"onplayerkilled", &onplayerkilled );
    utility::registersharedfunc( #"gametype", #"hash_efbc8d88b844bbcc", &playerprespawngulagjail );
    utility::registersharedfunc( #"gametype", #"playernakeddroploadout", &playernakeddroploadout );
    utility::registersharedfunc( #"gametype", #"hash_d157d0fecf23e86b", &getinfilplayers );
    utility::registersharedfunc( #"gametype", #"droponplayerdeath", &droponplayerdeath );
    br_gametypes::disablefeature( #"plundersites" );
    br_gametypes::disablefeature( #"hash_56a2d01019099833" );
    br_gametypes::disablefeature( #"onelife" );
    br_gametypes::disablefeature( #"hash_ee46d235dcd7bb0" );
    br_gametypes::disablefeature( #"armor" );
    br_gametypes::disablefeature( #"hash_1d015a3890edfd10" );
    callback::add( #"hash_bca0fca284613568", &function_2786fa8e2c98141a );
    level.ph.locationcircles = [];
    level.ph.proplist = [];
    
    /#
        level.ph.propindex = [];
    #/
    
    level.ph.abilities = [ "FLASH", "CLONE" ];
    level thread overridecountdownmusic();
    level thread initpostmain();
    game[ "attackers" ] = "allies";
    game[ "defenders" ] = "axis";
}

// Namespace br_gametype_prop
// Params 0
// Checksum 0xfe3effec, Offset: 0xfad
// Size: 0x16b
function initpostmain()
{
    waittillframeend();
    level.onsuicidedeath = &onsuicidedeath;
    level.onnormaldeath = &onnormaldeath;
    level.onspawnplayer = &onspawnplayer;
    level.ononeleftevent = &ononeleftevent;
    level.ontimelimit = &ontimelimit;
    level.ondeadevent = &ondeadevent;
    level.bypassclasschoicefunc = &phclass;
    level.onplayerjointeam = &onplayerjointeam;
    disconnect_event_aggregator::registerondisconnecteventcallback( &onplayerdisconnect );
    rank::registerscoreinfo( #"still_alive", #"value", 50 );
    rank::registerscoreinfo( #"still_alive_medium_bonus", #"value", 50 );
    rank::registerscoreinfo( #"still_alive_large_bonus", #"value", 100 );
    rank::registerscoreinfo( #"still_alive_extra_large_bonus", #"value", 150 );
    rank::registerscoreinfo( #"clone_destroyed", #"value", 50 );
    rank::registerscoreinfo( #"clone_was_destroyed", #"value", 10 );
    utility::registersharedfunc( #"vehicle_occupancy", #"onEnterVehicle", &vehicle_occupancy_mp_onentervehicle );
    utility::registersharedfunc( #"vehicle_occupancy", #"onExitVehicle", &vehicle_occupancy_mp_onexitvehicle );
    populateproplist();
    initpropcircles();
}

// Namespace br_gametype_prop
// Params 0
// Checksum 0x784c5ae4, Offset: 0x1120
// Size: 0x2b
function overridecountdownmusic()
{
    while ( !isdefined( game[ "music" ][ "match_ending_soon" ] ) )
    {
        waitframe();
    }
    
    game[ "music" ][ "match_ending_soon" ] = "prop_countdown";
}

// Namespace br_gametype_prop
// Params 1
// Checksum 0x8801c7a4, Offset: 0x1153
// Size: 0x33
function onplayerconnect( player )
{
    if ( !isdefined( player.pers[ "propSeconds" ] ) )
    {
        player.pers[ "propSeconds" ] = 0;
    }
}

// Namespace br_gametype_prop
// Params 0
// Checksum 0x278c4a71, Offset: 0x118e
// Size: 0x2f9
function onstartgametype()
{
    if ( level.ph.settings.modetype == 1 )
    {
        if ( [[ level.checkforovertime ]]() )
        {
            game[ "status" ] = "overtime";
            setdvar( @"ui_overtime", 1 );
            setdvar( @"overtimetimelimit", 3.5 );
        }
        
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
        else
        {
            level.prematchperiod = 30;
        }
    }
    
    setspecialloadouts();
    setclientnamemode( "manual_change" );
    game_utility_mp::setobjectivetext( game[ "attackers" ], &"objectives_ph/attacker" );
    game_utility_mp::setobjectivetext( game[ "defenders" ], &"objectives_ph/defender" );
    game_utility_mp::setobjectivescoretext( game[ "attackers" ], &"objectives_ph/attacker_score" );
    game_utility_mp::setobjectivescoretext( game[ "defenders" ], &"objectives_ph/defender_score" );
    game_utility_mp::setobjectivehinttext( game[ "attackers" ], &"objectives_ph/attacker_hint" );
    game_utility_mp::setobjectivehinttext( game[ "defenders" ], &"objectives_ph/defender_hint" );
    
    if ( level.ph.settings.modetype == 1 )
    {
        var_eb934ea312f6fb4 = game[ "roundsPlayed" ] % 4 == 2 || game[ "roundsPlayed" ] % 4 == 3;
        
        if ( var_eb934ea312f6fb4 )
        {
            game[ "switchedsides" ] = !game[ "switchedsides" ];
            game[ "switchedsides" ] = !game[ "switchedsides" ];
        }
    }
    
    level._effect[ "propFlash" ] = loadfxasset( "vfx_core_mp_equip_concussion_grenade" );
    level._effect[ "propDeathFX" ] = loadfxasset( "vfx_iw9_core_equip_claymore_trigger" );
    
    if ( !isdefined( game[ "propScore" ] ) )
    {
        game[ "propScore" ] = [];
        game[ "propScore" ][ "allies" ] = 0;
        game[ "propScore" ][ "axis" ] = 0;
    }
    
    if ( !isdefined( game[ "propSurvivalTime" ] ) )
    {
        game[ "propSurvivalTime" ] = [];
        game[ "propSurvivalTime" ][ "allies" ] = 0;
        game[ "propSurvivalTime" ][ "axis" ] = 0;
    }
    
    if ( !isdefined( game[ "hunterKillTime" ] ) )
    {
        game[ "hunterKillTime" ] = [];
        game[ "hunterKillTime" ][ "allies" ] = 0;
        game[ "hunterKillTime" ][ "axis" ] = 0;
    }
    
    flags::gameflaginit( "props_hide_over", 0 );
    flags::gameflaginit( "props_hide_start", 0 );
    level thread setuproundstarthud();
    level thread propspectating();
    level thread monitortimers();
    level thread deleteallglass();
    level thread setphteamscores();
    level thread stillalivexp();
    level thread tracktimealive();
    level thread startpropcirclelogic();
}

// Namespace br_gametype_prop
// Params 6
// Checksum 0x93471410, Offset: 0x148f
// Size: 0xa4
function onnormaldeath( victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon )
{
    propgiveteamscore( attacker.pers[ "team" ] );
    
    if ( game[ "state" ] == "postgame" && game[ "teamScores" ][ attacker.team ] > game[ "teamScores" ][ level.otherteam[ attacker.team ] ] )
    {
        attacker.finalkill = 1;
    }
}

// Namespace br_gametype_prop
// Params 1
// Checksum 0xeae4938a, Offset: 0x153b
// Size: 0xab
function onsuicidedeath( victim )
{
    if ( victim playerlogic::mayspawn() )
    {
        return;
    }
    
    otherteam = team_utility::getenemyteams( victim.pers[ "team" ] );
    
    foreach ( team in otherteam )
    {
        propgiveteamscore( team );
    }
}

// Namespace br_gametype_prop
// Params 1
// Checksum 0x5672933c, Offset: 0x15ee
// Size: 0x40
function propgiveteamscore( team )
{
    if ( team != game[ "attackers" ] )
    {
        return;
    }
    
    level gamescore::giveteamscoreforobjective( team, 1, 1 );
    game[ "propScore" ][ team ] = game[ "propScore" ][ team ] + 1;
}

// Namespace br_gametype_prop
// Params 2
// Checksum 0x256cd956, Offset: 0x1636
// Size: 0x1cc
function getgamewinnerprop( finalroundwinner, var_8f283ad4a5d849e7 )
{
    if ( !isstring( finalroundwinner ) )
    {
        return finalroundwinner;
    }
    
    gamewinner = finalroundwinner;
    
    if ( level.gameended )
    {
        winevent = "roundsWon";
        
        if ( isdefined( level.winbycaptures ) && level.winbycaptures )
        {
            winevent = "teamScores";
        }
        
        level.proptiebreaker = "none";
        
        if ( game[ winevent ][ "allies" ] == game[ winevent ][ "axis" ] )
        {
            level.proptiebreaker = "kills";
            
            if ( game[ "propScore" ][ "axis" ] == game[ "propScore" ][ "allies" ] )
            {
                level.proptiebreaker = "time";
                
                if ( game[ "hunterKillTime" ][ "axis" ] == game[ "hunterKillTime" ][ "allies" ] )
                {
                    level.proptiebreaker = "tie";
                    gamewinner = "tie";
                }
                else if ( game[ "hunterKillTime" ][ "axis" ] < game[ "hunterKillTime" ][ "allies" ] )
                {
                    gamewinner = "axis";
                }
                else
                {
                    gamewinner = "allies";
                }
            }
            else if ( game[ "propScore" ][ "axis" ] > game[ "propScore" ][ "allies" ] )
            {
                gamewinner = "axis";
            }
            else
            {
                gamewinner = "allies";
            }
            
            if ( gamewinner != "tie" )
            {
                level thread givephteamscore( gamewinner );
            }
        }
        else if ( game[ winevent ][ "axis" ] > game[ winevent ][ "allies" ] )
        {
            gamewinner = "axis";
        }
        else
        {
            gamewinner = "allies";
        }
    }
    
    if ( var_8f283ad4a5d849e7 && ( gamewinner == "allies" || gamewinner == "axis" ) )
    {
        ph_setfinalkillcamwinner( gamewinner );
    }
    
    return gamewinner;
}

// Namespace br_gametype_prop
// Params 0
// Checksum 0x8db672f5, Offset: 0x180b
// Size: 0x135
function getemptyloadout()
{
    emptyloadout = [];
    emptyloadout[ "loadoutArchetype" ] = "archetype_assault";
    emptyloadout[ "loadoutPrimary" ] = "none";
    emptyloadout[ "loadoutPrimaryAttachment" ] = "none";
    emptyloadout[ "loadoutPrimaryAttachment2" ] = "none";
    emptyloadout[ "loadoutPrimaryCamo" ] = "none";
    emptyloadout[ "loadoutPrimaryReticle" ] = "none";
    emptyloadout[ "loadoutSecondary" ] = "none";
    emptyloadout[ "loadoutSecondaryAttachment" ] = "none";
    emptyloadout[ "loadoutSecondaryAttachment2" ] = "none";
    emptyloadout[ "loadoutSecondaryCamo" ] = "none";
    emptyloadout[ "loadoutSecondaryReticle" ] = "none";
    emptyloadout[ "loadoutMeleeSlot" ] = level.defaultfist.var_1616e6fbba9a722d;
    emptyloadout[ "loadoutEquipmentPrimary" ] = "none";
    emptyloadout[ "loadoutEquipmentSecondary" ] = "none";
    emptyloadout[ "loadoutStreakType" ] = "assault";
    emptyloadout[ "loadoutKillstreak1" ] = "none";
    emptyloadout[ "loadoutKillstreak2" ] = "none";
    emptyloadout[ "loadoutKillstreak3" ] = "none";
    emptyloadout[ "loadoutSuper" ] = "super_ammo_drop";
    emptyloadout[ "loadoutPerks" ] = [ "specialty_null" ];
    emptyloadout[ "loadoutGesture" ] = "playerData";
    return emptyloadout;
}

// Namespace br_gametype_prop
// Params 0
// Checksum 0xb8436eff, Offset: 0x1949
// Size: 0xea
function setspecialloadouts()
{
    defenderteam = game[ "defenders" ];
    level.ph_loadouts[ defenderteam ] = getemptyloadout();
    attackerteam = game[ "attackers" ];
    level.ph_loadouts[ attackerteam ] = getemptyloadout();
    level.ph_loadouts[ attackerteam ][ "loadoutPrimary" ] = "iw8_ar_akilo47";
    level.ph_loadouts[ attackerteam ][ "loadoutPrimaryAttachment" ] = "xmags";
    level.ph_loadouts[ attackerteam ][ "loadoutPrimaryAttachment2" ] = "laser";
    level.ph_loadouts[ attackerteam ][ "loadoutSecondary" ] = "iw8_pi_mike1911";
    level.ph_loadouts[ attackerteam ][ "loadoutEquipmentSecondary" ] = "equip_concussion";
    level.ph_loadouts[ attackerteam ][ "loadoutPerks" ] = [ "specialty_restock", "specialty_hustle" ];
}

// Namespace br_gametype_prop
// Params 0
// Checksum 0x22b8c20e, Offset: 0x1a3b
// Size: 0x8e
function phclass()
{
    self.pers[ "class" ] = "gamemode";
    self.pers[ "lastClass" ] = "";
    self.pers[ "gamemodeLoadout" ] = level.ph_loadouts[ self.pers[ "team" ] ];
    self.class = self.pers[ "class" ];
    self.lastclass = self.pers[ "lastClass" ];
    return self.class;
}

// Namespace br_gametype_prop
// Params 0
// Checksum 0xe06a708f, Offset: 0x1ad2
// Size: 0x15
function propspectating()
{
    level endon( #"game_ended" );
    spectating::updatespectatesettings();
}

// Namespace br_gametype_prop
// Params 1
// Checksum 0x9478de5f, Offset: 0x1aef
// Size: 0x3a
function whistlestarttimer( duration )
{
    level notify( #"hash_d81d4ff3d0fa766c" );
    counttime = int( duration );
    
    if ( counttime >= 0 )
    {
        thread whistlestarttimer_internal( counttime );
    }
}

// Namespace br_gametype_prop
// Params 1
// Checksum 0x318bdc7, Offset: 0x1b31
// Size: 0x4f
function whistlestarttimer_internal( counttime )
{
    level endon( #"hash_d81d4ff3d0fa766c" );
    waittillframeend();
    
    while ( counttime > 0 && !level.gameended )
    {
        setomnvar( "ui_ph_whistle_countdown", counttime );
        counttime--;
        wait 1;
    }
    
    setomnvar( "ui_ph_whistle_countdown", counttime );
}

// Namespace br_gametype_prop
// Params 0
// Checksum 0x3ada7345, Offset: 0x1b88
// Size: 0x4, Type: bool
function useprophudserver()
{
    return true;
}

// Namespace br_gametype_prop
// Params 0
// Checksum 0xc030e56c, Offset: 0x1b95
// Size: 0x54f
function setuproundstarthud()
{
    if ( useprophudserver() && level.ph.settings.prophidetime > 0 )
    {
        level.ph.countdowntimer = hud_util::createservertimer( "default", 1.4 );
        level.ph.countdowntimer hud_util::setpoint( "CENTER", undefined, 0, 50 );
        level.ph.countdowntimer.label = &"mp_ph/starts_in";
        level.ph.countdowntimer.alpha = 0;
        level.ph.countdowntimer.archived = 0;
        level.ph.countdowntimer.hidewheninmenu = 1;
        level.ph.countdowntimer.sort = 1;
    }
    
    if ( useprophudserver() )
    {
        level.ph.whistletimer = hud_util::createservertimer( "default", 0.9 );
        level.ph.whistletimer.x = -6;
        level.ph.whistletimer.y = 2;
        level.ph.whistletimer.alignx = "right";
        level.ph.whistletimer.aligny = "top";
        level.ph.whistletimer.horzalign = "right_adjustable";
        level.ph.whistletimer.vertalign = "top_adjustable";
        level.ph.whistletimer.label = &"mp_ph/whistle_in";
        level.ph.whistletimer.alpha = 0;
        level.ph.whistletimer.archived = 1;
        level.ph.whistletimer.hidewheninmenu = 1;
        level.ph.whistletimer settimer( 120 );
    }
    else
    {
        whistlestarttimer( 120 );
    }
    
    if ( useprophudserver() )
    {
        level.whistling = createserverfontstring( "default", 1 );
        level.whistling.label = &"mp_ph/whistling";
        level.whistling.x = -5;
        level.whistling.y = 2;
        level.whistling.alignx = "right";
        level.whistling.aligny = "top";
        level.whistling.horzalign = "right_adjustable";
        level.whistling.vertalign = "top_adjustable";
        level.whistling.archived = 1;
        level.whistling.alpha = 0;
        level.whistling.glowalpha = 0.2;
        level.whistling.hidewheninmenu = 0;
    }
    
    if ( useprophudserver() )
    {
        if ( !isdefined( level.elim_hud ) )
        {
            level.elim_hud = [];
        }
        
        level.elim_hud = createserverfontstring( "default", 0.9 );
        level.elim_hud.label = &"mp_ph/alive";
        level.elim_hud setvalue( 0 );
        level.elim_hud.x = -5;
        level.elim_hud.y = 14;
        level.elim_hud.alignx = "right";
        level.elim_hud.aligny = "top";
        level.elim_hud.horzalign = "right_adjustable";
        level.elim_hud.vertalign = "top_adjustable";
        level.elim_hud.archived = 1;
        level.elim_hud.fontscale = 1;
        level.elim_hud.alpha = 1;
        level.elim_hud.glowalpha = 0;
        level.elim_hud.hidewheninmenu = 0;
        level thread eliminatedhudmonitor();
    }
}

// Namespace br_gametype_prop
// Params 2
// Checksum 0xc1d8e691, Offset: 0x20ec
// Size: 0xf8
function createserverfontstring( font, fontscale )
{
    fontelem = newhudelem();
    fontelem.elemtype = "font";
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

// Namespace br_gametype_prop
// Params 0
// Checksum 0x16cf1e86, Offset: 0x21ed
// Size: 0x5c
function eliminatedhudmonitor()
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        props = get_alive_nonspecating_players( game[ "defenders" ] );
        level.elim_hud setvalue( props.size );
        level utility::waittill_any( "player_spawned", "playerCountChanged", "propCountChanged", "playerDisconnected" );
    }
}

// Namespace br_gametype_prop
// Params 1
// Checksum 0xe414dabf, Offset: 0x2251
// Size: 0xd8
function get_alive_nonspecating_players( team )
{
    var_c3b8108c7ad12ae1 = [];
    
    foreach ( player in level.players )
    {
        if ( isalive( player ) && ( !isdefined( player.sessionstate ) || player.sessionstate == "playing" ) )
        {
            if ( !isdefined( team ) || player.team == team )
            {
                var_c3b8108c7ad12ae1[ var_c3b8108c7ad12ae1.size ] = player;
            }
        }
    }
    
    return var_c3b8108c7ad12ae1;
}

// Namespace br_gametype_prop
// Params 1
// Checksum 0x4ea3b55e, Offset: 0x2332
// Size: 0x4b
function onplayerdisconnect( player )
{
    level notify( #"playerdisconnected" );
    
    if ( isdefined( player.proplocationindex ) )
    {
        player propremovefromlocation();
        return;
    }
    
    if ( isdefined( player.propcircleindex ) )
    {
        player propremovefromcircle();
    }
}

// Namespace br_gametype_prop
// Params 2
// Checksum 0xd2b00eab, Offset: 0x2385
// Size: 0x2c
function kickplayer( player, reason )
{
    if ( isbot( player ) )
    {
        return;
    }
    
    kick( player getentitynumber(), reason );
}

// Namespace br_gametype_prop
// Params 0
// Checksum 0x7a9aab3e, Offset: 0x23b9
// Size: 0x57, Type: bool
function weaponusagecheck()
{
    msg = utility::waittill_any_return( "weapon_fired", "sprint_begin", "specialGrenade", "end_weapon_check_usage" );
    
    if ( msg == "end_weapon_check_usage" )
    {
        if ( self.hashitplayer )
        {
            return true;
        }
        
        kickplayer( self, &"EXE/PLAYERKICKED_INACTIVE" );
        return false;
    }
    
    return true;
}

// Namespace br_gametype_prop
// Params 2
// Checksum 0xfc8aec20, Offset: 0x2419
// Size: 0xbe, Type: bool
function positioncheck( time, radius )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    
    if ( !isdefined( time ) )
    {
        time = 45;
    }
    
    if ( !isdefined( radius ) )
    {
        radius = 300;
    }
    
    checkedposition = self.origin;
    passeddistance = squared( radius );
    var_8f504a54e2c6c27e = 0;
    
    for ( i = 0; i < time ; i++ )
    {
        if ( !var_8f504a54e2c6c27e )
        {
            moveddistance = distancesquared( checkedposition, self.origin );
            
            if ( moveddistance >= passeddistance )
            {
                var_8f504a54e2c6c27e = 1;
            }
        }
        
        wait 1;
    }
    
    if ( var_8f504a54e2c6c27e )
    {
        return true;
    }
    
    return false;
}

// Namespace br_gametype_prop
// Params 0
// Checksum 0xb66db0e5, Offset: 0x24e0
// Size: 0xe
function waittillhuntersdrop()
{
    flags::gameflagwait( "br_ready_to_jump" );
}

// Namespace br_gametype_prop
// Params 0
// Checksum 0xff91539f, Offset: 0x24f6
// Size: 0x9d
function startcheck()
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self.doingcheck = 1;
    waittillhuntersdrop();
    childthread weaponusagecheck();
    
    if ( !positioncheck( 45, 300 ) )
    {
        if ( self.hashitplayer )
        {
            return;
        }
        
        kickplayer( self, &"EXE/PLAYERKICKED_INACTIVE" );
        return;
    }
    
    if ( !positioncheck( 75, 150 ) )
    {
        if ( self.hashitplayer )
        {
            return;
        }
        
        kickplayer( self, &"EXE/PLAYERKICKED_INACTIVE" );
        return;
    }
    
    wait 30;
    self notify( #"end_weapon_check_usage" );
}

// Namespace br_gametype_prop
// Params 1
// Checksum 0x6e0593ee, Offset: 0x259b
// Size: 0x1e1
function onspawnplayer( revivespawn )
{
    br::onspawnplayer();
    self.breathingstoptime = 0;
    
    if ( playerisprop() )
    {
        self.skipcorpse = 1;
        self.overrideweaponspeed_speedscale = level.ph.settings.propspeedscale;
        
        if ( !isdefined( self.abilityleft ) )
        {
            self.abilityleft = 0;
        }
        
        if ( !isdefined( self.clonesleft ) )
        {
            self.clonesleft = 0;
        }
        
        if ( !isdefined( self.pers[ "ability" ] ) )
        {
            self.pers[ "ability" ] = 0;
        }
        
        self.currentability = level.ph.abilities[ self.pers[ "ability" ] ];
        self.isangleoffset = 0;
        changecount = int( level.ph.settings.propchangecount );
        abilitycount = undefined;
        clonecount = undefined;
        
        if ( isdefined( self.spawnedonce ) && isdefined( self.changesleft ) )
        {
            changecount = self.changesleft;
            abilitycount = self.abilityleft;
            clonecount = self.clonesleft;
        }
        
        thread handleprop();
    }
    else
    {
        self.skipcorpse = undefined;
        self.abilityleft = undefined;
        self.clonesleft = undefined;
        self.overrideweaponspeed_speedscale = undefined;
        
        if ( !isdefined( self.thrownspecialcount ) )
        {
            self.thrownspecialcount = 0;
        }
        
        thread givecustomloadout();
        var_b338f03c794ac04 = 1;
        
        /#
            var_b338f03c794ac04 = 0;
        #/
        
        if ( var_b338f03c794ac04 && !isdefined( self.doingcheck ) )
        {
            thread startcheck();
        }
    }
    
    self.spawnedonce = 1;
}

// Namespace br_gametype_prop
// Params 0
// Checksum 0x94ab5265, Offset: 0x2784
// Size: 0x276
function monitortimers()
{
    level endon( #"game_ended" );
    flags::gameflagwait( "props_hide_start" );
    
    if ( useprophudserver() )
    {
        if ( level.ph.settings.prophidetime > 0 )
        {
            level.ph.countdowntimer settimer( level.ph.settings.prophidetime );
            level.ph.countdowntimer.alpha = 1;
        }
        
        level.ph.whistletimer settimer( level.ph.settings.propwhistletime + level.ph.settings.prophidetime );
        level.ph.whistletimer.alpha = 1;
    }
    else if ( level.ph.settings.prophidetime > 0 || level.ph.settings.propwhistletime > 0 )
    {
        whistlestarttimer( level.ph.settings.propwhistletime + level.ph.settings.prophidetime );
    }
    
    if ( level.ph.settings.prophidetime > 0 )
    {
        wait level.ph.settings.prophidetime;
    }
    
    flags::gameflagset( "props_hide_over" );
    
    if ( useprophudserver() )
    {
        level.ph.whistletimer.alpha = 1;
        
        if ( level.ph.settings.prophidetime > 0 )
        {
            level.ph.countdowntimer.alpha = 0;
        }
    }
    
    if ( level.ph.settings.propwhistletime > 0 )
    {
        propwhistle();
    }
}

// Namespace br_gametype_prop
// Params 0
// Checksum 0xae43b87, Offset: 0x2a02
// Size: 0xda
function handleprop()
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self waittill( #"giveloadout" );
    self allowprone( 0 );
    self allowsprint( 0 );
    weapons::updatemovespeedscale();
    self disableweaponpickup();
    self takeallweapons();
    self allowspectateteam( game[ "attackers" ], 1 );
    player_utility::function_dbe5a52a6654a982();
    player_utility::function_9d378d725bb4831e( "br_gametype_prop::handleProp()" );
    class::loadout_giveperk( "specialty_quieter" );
    assert( !isdefined( self.prop ) );
    thread setupprop();
    thread setupdamage();
    thread propwatchdeath();
    thread propwatchcleanupondisconnect();
    thread propwatchcleanuponroundend();
    thread propwatchprematchsettings();
    self.prop thread highlighttoteam( game[ "defenders" ], "outline_nodepth_cyan", self );
    self.concussionimmune = undefined;
}

// Namespace br_gametype_prop
// Params 1
// Checksum 0xba7294b8, Offset: 0x2ae4
// Size: 0x84
function getthirdpersonrangeforsize( propsize )
{
    switch ( propsize )
    {
        case 50:
            return 120;
        case 100:
            return 150;
        case 250:
            return 180;
        case 450:
            return 260;
        case 550:
            return 320;
        default:
            assertmsg( "<dev string:x24>" + propsize );
            break;
    }
    
    return 120;
}

// Namespace br_gametype_prop
// Params 1
// Checksum 0x57600534, Offset: 0x2b71
// Size: 0x80
function getthirdpersonheightoffsetforsize( propsize )
{
    switch ( propsize )
    {
        case 50:
            return -30;
        case 100:
            return -20;
        case 250:
            return 0;
        case 450:
            return 20;
        case 550:
            return 40;
        default:
            assertmsg( "<dev string:x24>" + propsize );
            break;
    }
    
    return 0;
}

// Namespace br_gametype_prop
// Params 0
// Checksum 0x40d1e9b9, Offset: 0x2bfa
// Size: 0x15f
function applyxyzoffset()
{
    if ( !isdefined( self.prop.xyzoffset ) )
    {
        return;
    }
    
    self.prop.angles = self.angles;
    forward = anglestoforward( self.prop.angles ) * self.prop.xyzoffset[ 0 ];
    right = anglestoright( self.prop.angles ) * self.prop.xyzoffset[ 1 ];
    up = anglestoup( self.prop.angles ) * self.prop.xyzoffset[ 2 ];
    self.prop.origin += forward;
    self.prop.origin += right;
    self.prop.origin += up;
}

// Namespace br_gametype_prop
// Params 0
// Checksum 0x18c7bdd4, Offset: 0x2d61
// Size: 0x7e
function applyanglesoffset()
{
    if ( !isdefined( self.prop.anglesoffset ) )
    {
        return;
    }
    
    self.prop.angles = self.angles;
    self.prop.angles += self.prop.anglesoffset;
    self.isangleoffset = 1;
}

// Namespace br_gametype_prop
// Params 0
// Checksum 0x30de5377, Offset: 0x2de7
// Size: 0xf1
function gettimeremaining()
{
    time = 0;
    
    if ( isdefined( level.br_level ) && isdefined( level.br_level.br_circlecenters ) )
    {
        for ( circleindex = 0; circleindex < level.br_level.br_circledelaytimes.size ; circleindex++ )
        {
            timedelay = level.br_level.br_circledelaytimes[ circleindex ];
            timeclose = level.br_level.br_circleclosetimes[ circleindex ];
            time = time + timedelay + timeclose;
        }
        
        time *= 1000;
        timepassed = gettime() - level.ph.settings.whistlestarttime;
        time -= timepassed;
        
        if ( time < 0 )
        {
            time = 0;
        }
    }
    
    return int( time );
}

// Namespace br_gametype_prop
// Params 0
// Checksum 0x7586961d, Offset: 0x2ee1
// Size: 0x3ce
function propwhistle()
{
    level endon( #"game_ended" );
    level.ph.settings.whistlestarttime = gettime();
    time = gettime();
    whistletime = level.ph.settings.propwhistletime * 1000;
    var_3ccabbe7c697604e = 20000;
    var_d654c6d0f7847abf = var_3ccabbe7c697604e;
    var_ee80bfd33e3e9c0a = 500;
    endgamegraceperiod = 5000;
    whistlecount = 0;
    var_8791c28e4acb387a = getentarray( "minimap_corner", #targetname )[ 0 ].origin;
    wait level.ph.settings.propwhistletime;
    
    if ( !useprophudserver() )
    {
        setomnvar( "ui_war_active_sector", 0 );
    }
    
    while ( true )
    {
        if ( time + whistletime - var_ee80bfd33e3e9c0a < gettime() )
        {
            whistlecount++;
            sortedplayers = sortbydistance( level.players, var_8791c28e4acb387a );
            
            foreach ( player in sortedplayers )
            {
                if ( !isdefined( player ) )
                {
                    continue;
                }
                
                if ( useprophudserver() )
                {
                    level.ph.whistletimer.alpha = 0;
                    level.whistling.alpha = 0.6;
                }
                
                if ( player playerisprop() && isalive( player ) )
                {
                    if ( useprophudserver() )
                    {
                        level.whistling.alpha = 1;
                        level.whistling fadeovertime( 0.75 );
                        level.whistling.alpha = 0.6;
                    }
                    
                    playsoundatpos( player.origin + ( 0, 0, 60 ), "prop_whistle" );
                    wait 1.5;
                }
            }
            
            if ( !useprophudserver() )
            {
                setomnvar( "ui_war_active_sector", 2 );
            }
            
            time = gettime();
            
            if ( whistlecount % 2 == 0 )
            {
                whistletime = max( whistletime - 5000, var_3ccabbe7c697604e );
            }
            
            if ( var_d654c6d0f7847abf >= gettimeremaining() - endgamegraceperiod )
            {
                if ( useprophudserver() )
                {
                    level.whistling.alpha = 0;
                }
                
                return;
            }
            else
            {
                if ( var_d654c6d0f7847abf * 2 + getteamplayersalive( game[ "defenders" ] ) * 2500 >= gettimeremaining() - endgamegraceperiod )
                {
                    if ( useprophudserver() )
                    {
                        level.ph.whistletimer.label = &"mp_ph/final_whistle";
                    }
                    else
                    {
                        setomnvar( "ui_war_active_sector", 1 );
                    }
                    
                    var_d654c6d0f7847abf += getteamplayersalive( game[ "defenders" ] ) * 2500;
                }
                
                if ( useprophudserver() )
                {
                    level.ph.whistletimer settimer( int( whistletime / 1000 ) );
                }
                else
                {
                    whistlestarttimer( int( whistletime / 1000 ) );
                }
                
                if ( useprophudserver() )
                {
                    level.whistling.alpha = 0;
                    level.ph.whistletimer.alpha = 1;
                }
            }
        }
        
        wait 0.5;
    }
}

// Namespace br_gametype_prop
// Params 1
// Checksum 0x58ee2abf, Offset: 0x32b7
// Size: 0xcc
function getlivingplayersonteam( team )
{
    players = [];
    
    foreach ( player in level.participants )
    {
        if ( !isdefined( player.team ) )
        {
            continue;
        }
        
        if ( player::isreallyalive( player ) && game_utility_common::isteamparticipant( player ) && player.team == team )
        {
            players[ players.size ] = player;
        }
    }
    
    return players;
}

// Namespace br_gametype_prop
// Params 0
// Checksum 0x36f0a9a1, Offset: 0x338c
// Size: 0x18
function createpropspeclist()
{
    self.spectatableprops = getlivingplayersonteam( game[ "defenders" ] );
}

// Namespace br_gametype_prop
// Params 0
// Checksum 0x6e29897, Offset: 0x33ac
// Size: 0x64
function setupdamage()
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    wait 0.5;
    self.prop.skipignoredamage = 1;
    self.prop thread damage::monitordamage( self.prop.health, "standard", undefined, &damagewatch );
}

// Namespace br_gametype_prop
// Params 1
// Checksum 0x65203406, Offset: 0x3418
// Size: 0x15a, Type: bool
function damagewatch( damagedata )
{
    if ( !isdefined( damagedata.attacker ) )
    {
        return false;
    }
    
    if ( !isdefined( self.owner ) )
    {
        return false;
    }
    
    if ( isplayer( damagedata.attacker ) )
    {
        if ( damagedata.attacker.pers[ "team" ] == self.owner.pers[ "team" ] )
        {
            return false;
        }
        
        damagedata.attacker thread damagefeedback::updatedamagefeedback( "standard" );
        
        if ( damagedata.objweapon.basename == "concussion_grenade_mp" )
        {
            inflictor = spawnstruct();
            inflictor.origin = damagedata.point;
            self.owner thread concussion_grenade::applyconcussion( inflictor, damagedata.attacker );
            
            if ( self.owner.lock )
            {
            }
        }
    }
    
    self.owner dodamage( damagedata.damage, damagedata.point, damagedata.attacker, damagedata.inflictor, damagedata.meansofdeath, damagedata.objweapon );
    return false;
}

// Namespace br_gametype_prop
// Params 0
// Checksum 0x159f4f6c, Offset: 0x357b
// Size: 0x31
function propcleanup()
{
    thread propcleanupdelayed( [ self.prop, self.propanchor, self.propent ] );
}

// Namespace br_gametype_prop
// Params 1
// Checksum 0x754f7851, Offset: 0x35b4
// Size: 0xef
function propcleanupdelayed( propents )
{
    foreach ( prop in propents )
    {
        if ( isdefined( prop ) )
        {
            prop unlink();
        }
    }
    
    waitframe();
    
    foreach ( prop in propents )
    {
        if ( isdefined( prop ) )
        {
            prop delete();
        }
    }
}

// Namespace br_gametype_prop
// Params 0
// Checksum 0x7e10f2a1, Offset: 0x36ab
// Size: 0xdf
function propwatchdeath()
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    self.deathnoise = "prop_death";
    self.propdeathfx = "propDeathFX";
    self waittill( #"death" );
    corpse = self.body;
    playsoundatpos( self.prop.origin + ( 0, 0, 4 ), self.deathnoise );
    playfx( utility::getfx( self.propdeathfx ), self.prop.origin + ( 0, 0, 4 ) );
    
    if ( isdefined( corpse ) )
    {
        corpse delete();
    }
    
    propcleanup();
    self setcamerathirdperson( 0 );
    playersetispropgameextrainfo( 0 );
}

// Namespace br_gametype_prop
// Params 0
// Checksum 0x4edc79f4, Offset: 0x3792
// Size: 0xed
function propwatchcleanupondisconnect()
{
    self notify( #"hash_d5ffe386d728cba" );
    self endon( #"hash_d5ffe386d728cba" );
    level endon( #"game_ended" );
    self waittill( #"disconnect" );
    
    foreach ( player in level.players )
    {
        if ( player.propspectating && isdefined( player.spectatingthisplayer ) && self == player.spectatingthisplayer )
        {
            player notify( #"hash_37d0803fbf7b52e0" );
        }
    }
    
    propcleanup();
    propclonecleanup();
}

// Namespace br_gametype_prop
// Params 0
// Checksum 0x62350f57, Offset: 0x3887
// Size: 0x4f
function propwatchcleanuponroundend()
{
    self notify( #"propwatchdeleteroundend" );
    self endon( #"propwatchdeleteroundend" );
    self endon( #"disconnect" );
    level waittill( #"game_ended" );
    utility::waittill_notify_or_timeout( "end_killcam", 5 );
    propcleanup();
    propclonecleanup();
}

// Namespace br_gametype_prop
// Params 0
// Checksum 0x74bc6d8d, Offset: 0x38de
// Size: 0x8c
function propclonecleanup()
{
    if ( isdefined( self.propclones ) )
    {
        foreach ( clone in self.propclones )
        {
            if ( isdefined( clone ) )
            {
                clone delete();
            }
        }
    }
}

// Namespace br_gametype_prop
// Params 0
// Checksum 0xec833d4e, Offset: 0x3972
// Size: 0x7b
function cleanupallclones()
{
    foreach ( player in level.players )
    {
        player propclonecleanup();
    }
}

// Namespace br_gametype_prop
// Params 0
// Checksum 0x6e1b2eb, Offset: 0x39f5
// Size: 0x34
function propwatchprematchsettings()
{
    self endon( #"death_or_disconnect" );
    self endon( #"joined_team" );
    self endon( #"joined_spectators" );
    self allowprone( 0 );
    self allowsprint( 0 );
}

// Namespace br_gametype_prop
// Params 0
// Checksum 0xaf1878cc, Offset: 0x3a31
// Size: 0x1b
function deleteallglass()
{
    level endon( #"game_ended" );
    level waittill( #"prematch_over" );
}

// Namespace br_gametype_prop
// Params 0
// Checksum 0xb8875f86, Offset: 0x3a54
// Size: 0x13b
function organizeproplist()
{
    foreach ( locationkey, locationlist in level.ph.proplist )
    {
        if ( locationkey != "any" )
        {
            foreach ( sizekey, sizelist in level.ph.proplist[ "any" ] )
            {
                level.ph.proplist[ locationkey ][ sizekey ] = arraycombine( level.ph.proplist[ locationkey ][ sizekey ], sizelist );
            }
        }
    }
}

// Namespace br_gametype_prop
// Params 1
// Checksum 0x7b4a1350, Offset: 0x3b97
// Size: 0xf5
function randgetpropsizetoallocate( locationname )
{
    proplist = level.ph.proplist[ locationname ];
    weight_xsmall = 10 * isdefined( proplist[ 50 ] );
    weight_small = 30 * isdefined( proplist[ 100 ] );
    weight_medium = 40 * isdefined( proplist[ 250 ] );
    weight_large = 20 * isdefined( proplist[ 450 ] );
    weight_xlarge = 10 * isdefined( proplist[ 550 ] );
    randomrange = weight_xsmall + weight_small + weight_medium + weight_large + weight_xlarge;
    randomval = randomint( randomrange );
    
    if ( randomval < weight_xsmall )
    {
        return 50;
    }
    
    randomval -= weight_xsmall;
    
    if ( randomval < weight_small )
    {
        return 100;
    }
    
    randomval -= weight_small;
    
    if ( randomval < weight_medium )
    {
        return 250;
    }
    
    randomval -= weight_medium;
    
    if ( randomval < weight_large )
    {
        return 450;
    }
    
    randomval -= weight_large;
    return 550;
}

// Namespace br_gametype_prop
// Params 1
// Checksum 0xe0fdf14b, Offset: 0x3c95
// Size: 0x1e7
function getnextprop( player )
{
    locationname = player propgetlocation();
    proplist = level.ph.proplist[ locationname ];
    var_d1d1ed8175f26c7f = randgetpropsizetoallocate( locationname );
    var_13225a292f46ee52 = getarraykeys( proplist );
    var_13225a292f46ee52 = arrayrandomize( var_13225a292f46ee52 );
    propsizes = [ var_d1d1ed8175f26c7f ];
    
    foreach ( size in var_13225a292f46ee52 )
    {
        if ( size != var_d1d1ed8175f26c7f )
        {
            propsizes[ propsizes.size ] = size;
        }
    }
    
    prop = undefined;
    
    for ( i = 0; i < propsizes.size ; i++ )
    {
        size = propsizes[ i ];
        
        if ( !isdefined( proplist[ size ] ) || !proplist[ size ].size )
        {
            continue;
        }
        
        var_c5a542ee78d57add = arrayrandomize( proplist[ size ] );
        
        for ( j = 0; j < var_c5a542ee78d57add.size ; j++ )
        {
            prop = var_c5a542ee78d57add[ j ];
            propused = 0;
            
            if ( isdefined( player.usedprops ) && player.usedprops.size )
            {
                for ( index = 0; index < player.usedprops.size ; index++ )
                {
                    if ( prop.modelname == player.usedprops[ index ].modelname )
                    {
                        propused = 1;
                        break;
                    }
                }
            }
            
            if ( !propused )
            {
                return prop;
            }
        }
    }
    
    return prop;
}

// Namespace br_gametype_prop
// Params 0
// Checksum 0x7ea5adff, Offset: 0x3e85
// Size: 0x311
function populateproplist()
{
    mapname = game_utility::getmapname();
    var_d320d22e65fb158a = "mp/" + mapname + "_ph.csv";
    numrows = 0;
    
    if ( tableexists( var_d320d22e65fb158a ) )
    {
        numrows = tablelookupgetnumrows( var_d320d22e65fb158a );
        
        for ( rowindex = 0; rowindex < numrows ; rowindex++ )
        {
            type = tablelookupbyrow( var_d320d22e65fb158a, rowindex, 0 );
            
            if ( type == "prop" )
            {
                modelname = tablelookupbyrow( var_d320d22e65fb158a, rowindex, 1 );
                propsizetext = tablelookupbyrow( var_d320d22e65fb158a, rowindex, 2 );
                offsetx = int( tablelookupbyrow( var_d320d22e65fb158a, rowindex, 3 ) );
                offsety = int( tablelookupbyrow( var_d320d22e65fb158a, rowindex, 4 ) );
                offsetz = int( tablelookupbyrow( var_d320d22e65fb158a, rowindex, 5 ) );
                rotationx = int( tablelookupbyrow( var_d320d22e65fb158a, rowindex, 6 ) );
                rotationy = int( tablelookupbyrow( var_d320d22e65fb158a, rowindex, 7 ) );
                rotationz = int( tablelookupbyrow( var_d320d22e65fb158a, rowindex, 8 ) );
                propheight = tablelookupbyrow( var_d320d22e65fb158a, rowindex, 9 );
                proprange = tablelookupbyrow( var_d320d22e65fb158a, rowindex, 10 );
                location = tablelookupbyrow( var_d320d22e65fb158a, rowindex, 11 );
                
                if ( location == "" )
                {
                    location = "any";
                }
                
                offset = undefined;
                
                if ( isdefined( offsetx ) && isdefined( offsety ) && isdefined( offsetz ) )
                {
                    offset = ( offsetx, offsety, offsetz );
                }
                
                rotation = undefined;
                
                if ( isdefined( rotationx ) && isdefined( rotationy ) && isdefined( rotationz ) )
                {
                    rotation = ( rotationx, rotationy, rotationz );
                }
                
                propsize = getpropsize( propsizetext );
                
                if ( !isdefined( propheight ) || propheight == "" )
                {
                    propheight = getthirdpersonheightoffsetforsize( propsize );
                }
                else
                {
                    propheight = int( propheight );
                }
                
                if ( !isdefined( proprange ) || proprange == "" )
                {
                    proprange = getthirdpersonrangeforsize( propsize );
                }
                else
                {
                    proprange = int( proprange );
                }
                
                addproptolist( modelname, propsize, offset, rotation, propsizetext, propheight, proprange, location );
                continue;
            }
            
            if ( type == "loc" )
            {
                location = tablelookupbyrow( var_d320d22e65fb158a, rowindex, 11 );
                xcoord = int( tablelookupbyrow( var_d320d22e65fb158a, rowindex, 12 ) );
                ycoord = int( tablelookupbyrow( var_d320d22e65fb158a, rowindex, 13 ) );
                radius = int( tablelookupbyrow( var_d320d22e65fb158a, rowindex, 14 ) );
                initlocationcircle( location, xcoord, ycoord, radius );
                continue;
            }
            
            assertmsg( "<dev string:x33>" + "<dev string:x57>" + "<dev string:x5b>" + "<dev string:x60>" );
        }
    }
    
    if ( numrows == 0 )
    {
        addproptolist( "tag_origin", 250, ( 0, 0, 0 ), ( 0, 0, 0 ), "medium", getthirdpersonheightoffsetforsize( 250 ), getthirdpersonrangeforsize( 250 ), "any" );
    }
    
    organizeproplist();
}

// Namespace br_gametype_prop
// Params 0
// Checksum 0xe21c9128, Offset: 0x419e
// Size: 0x2a1
function setupprop()
{
    propinfo = self.propinfo;
    
    if ( !isdefined( propinfo ) )
    {
        propinfo = getnextprop( self );
    }
    
    self.propanchor = spawn( "script_model", self.origin );
    self.propanchor.targetname = "propAnchor";
    self.propanchor linkto( self );
    self.propent = spawn( "script_model", self.origin );
    self.propent setmodel( "generic_prop_raven_x3" );
    self.propent.targetname = "propEnt";
    self.propent linkto( self.propanchor );
    self.prop = spawn( "script_model", self.propent.origin );
    self.prop.targetname = "prop";
    self.prop setmodel( propinfo.modelname );
    self.prop setcandamage( 1 );
    self.prop.xyzoffset = propinfo.xyzoffset;
    self.prop.anglesoffset = propinfo.anglesoffset;
    self.prop.angles = self.angles;
    applyxyzoffset();
    applyanglesoffset();
    self.prop linkto( self.propent, "J_prop_1" );
    self.prop.owner = self;
    self.prop.health = 10000;
    self.propent scriptmodelplayanim( "prop_hunt_prop_spin", "propSpinAnim", undefined, 1.5 );
    self.propent scriptmodelpauseanim( 1 );
    self.thirdpersonrange = propinfo.proprange;
    self.thirdpersonheightoffset = propinfo.propheight;
    self setcamerathirdperson( 1 );
    playersetispropgameextrainfo( 1 );
    self.prop.info = propinfo;
    self.propinfo = propinfo;
    
    if ( !isdefined( self.spawnedonce ) )
    {
        self.usedprops = [];
    }
    
    self.maxhealth = getprophealth( propinfo );
    self.health = self.maxhealth;
}

// Namespace br_gametype_prop
// Params 1
// Checksum 0xa8f45e66, Offset: 0x4447
// Size: 0xc
function playersetispropgameextrainfo( value )
{
    
}

// Namespace br_gametype_prop
// Params 1
// Checksum 0xfd993f2d, Offset: 0x445b
// Size: 0x1b
function getprophealth( propinfo )
{
    return int( propinfo.propsize );
}

// Namespace br_gametype_prop
// Params 1
// Checksum 0xd8660247, Offset: 0x447f
// Size: 0xf0
function getpropsize( propsizetext )
{
    /#
        if ( propsizetext == "<dev string:x65>" )
        {
            return 0;
        }
    #/
    
    propsize = 0;
    
    switch ( propsizetext )
    {
        case #"hash_9edc0a2fbdb3ef36":
            propsize = 50;
            break;
        case #"hash_5971965ed985a26c":
            propsize = 100;
            break;
        case #"hash_c71b112fe04823d6":
            propsize = 250;
            break;
        case #"hash_4bf33d595d8f4894":
            propsize = 450;
            break;
        case #"hash_ec5c69f572eb5fa2":
            propsize = 550;
            break;
        default:
            mapname = game_utility::getmapname();
            var_d320d22e65fb158a = "mp/" + mapname + "_ph.csv";
            assertmsg( "<dev string:x6c>" + propsizetext + "<dev string:x80>" + var_d320d22e65fb158a + "<dev string:x92>" );
            propsize = 100;
            break;
    }
    
    return propsize;
}

// Namespace br_gametype_prop
// Params 8
// Checksum 0xb9cc5b6d, Offset: 0x4578
// Size: 0x1c8
function addproptolist( modelname, propsize, xyzoffset, anglesoffset, propsizetext, propheight, proprange, location )
{
    if ( !isdefined( level.ph.proplist[ location ] ) )
    {
        level.ph.proplist[ location ] = [];
    }
    
    if ( !isdefined( level.ph.proplist[ location ][ propsize ] ) )
    {
        level.ph.proplist[ location ][ propsize ] = [];
    }
    
    propinfo = spawnstruct();
    propinfo.modelname = modelname;
    propinfo.propsize = int( propsize );
    propinfo.propsizetext = propsizetext;
    propinfo.location = location;
    
    if ( isdefined( xyzoffset ) )
    {
        propinfo.xyzoffset = xyzoffset;
    }
    
    if ( isdefined( anglesoffset ) )
    {
        propinfo.anglesoffset = anglesoffset;
    }
    
    propinfo.proprange = proprange;
    propinfo.propheight = propheight;
    
    /#
        propindex = level.ph.propindex.size;
        propinfo.propindex = propindex;
        level.ph.propindex[ propindex ] = propinfo;
    #/
    
    nextindex = level.ph.proplist[ location ][ propsize ].size;
    level.ph.proplist[ location ][ propsize ][ nextindex ] = propinfo;
}

// Namespace br_gametype_prop
// Params 2
// Checksum 0x3c90ab5f, Offset: 0x4748
// Size: 0x4a
function ph_endgame( winningteam, endreasontext )
{
    if ( level.endingph )
    {
        return;
    }
    
    level.endingph = 1;
    ph_setfinalkillcamwinner( winningteam );
    thread gamelogic_mp::endgame( winningteam, endreasontext );
    level thread givephteamscore( winningteam );
}

// Namespace br_gametype_prop
// Params 1
// Checksum 0x54d636f4, Offset: 0x479a
// Size: 0x36
function ph_setfinalkillcamwinner( winningteam )
{
    level.finalkillcam_winner = winningteam;
    
    if ( level.finalkillcam_winner == game[ "defenders" ] )
    {
        level.skipfinalkillcamfx = 1;
    }
}

// Namespace br_gametype_prop
// Params 1
// Checksum 0xd147f0a0, Offset: 0x47d8
// Size: 0x39
function givephteamscore( team )
{
    level endon( #"game_ended" );
    var_a0eb69f725e50069 = game[ "roundsWon" ][ team ] + 1;
    setteamscore( team, var_a0eb69f725e50069 );
}

// Namespace br_gametype_prop
// Params 0
// Checksum 0x26d47a09, Offset: 0x4819
// Size: 0x5e
function setphteamscores()
{
    level endon( #"game_ended" );
    var_7de9f2097dcb6746 = game[ "roundsWon" ][ game[ "defenders" ] ];
    var_bd55b783b47da68a = game[ "roundsWon" ][ game[ "attackers" ] ];
    setteamscore( game[ "defenders" ], var_7de9f2097dcb6746 );
    setteamscore( game[ "attackers" ], var_bd55b783b47da68a );
}

// Namespace br_gametype_prop
// Params 1
// Checksum 0xd1fad8a5, Offset: 0x487f
// Size: 0xf5
function ononeleftevent( team )
{
    if ( level.gameended )
    {
        return;
    }
    
    if ( team == game[ "attackers" ] )
    {
        return;
    }
    
    lastplayer = undefined;
    
    foreach ( player in level.players )
    {
        if ( isdefined( team ) && player.team != team )
        {
            continue;
        }
        
        if ( !player::isreallyalive( player ) && !player playerlogic::mayspawn() )
        {
            continue;
        }
        
        if ( isdefined( lastplayer ) )
        {
            return;
        }
        
        lastplayer = player;
    }
    
    if ( !isdefined( lastplayer ) )
    {
        return;
    }
    
    lastplayer thread givelastonteamwarning();
}

// Namespace br_gametype_prop
// Params 0
// Checksum 0x70739648, Offset: 0x497c
// Size: 0xa6
function givelastonteamwarning()
{
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    player_utility::waittillrecoveredhealth( 3 );
    otherteam = team_utility::getotherteam( self.pers[ "team" ] );
    level thread hud_util::teamplayercardsplash( #"last_teammate_alive_callout", self, self.pers[ "team" ] );
    level thread hud_util::teamplayercardsplash( #"last_enemy_alive_callout", self, otherteam );
    
    if ( playerisprop() )
    {
        level notify( #"nopropstospectate" );
        level.nopropsspectate = 1;
    }
    
    level notify( #"last_alive", self );
}

// Namespace br_gametype_prop
// Params 0
// Checksum 0xeda374f4, Offset: 0x4a2a
// Size: 0x87
function ontimelimit()
{
    if ( !level.gameending )
    {
        timepassed = game_utility::gettimepassed();
        game[ "propSurvivalTime" ][ game[ "defenders" ] ] = game[ "propSurvivalTime" ][ game[ "defenders" ] ] + timepassed;
        game[ "hunterKillTime" ][ game[ "attackers" ] ] = game[ "hunterKillTime" ][ game[ "attackers" ] ] + timepassed;
        choosefinalkillcam();
        ph_endgame( game[ "defenders" ], game[ "end_reason" ][ "time_limit_reached" ] );
    }
}

// Namespace br_gametype_prop
// Params 0
// Checksum 0x63c53feb, Offset: 0x4ab9
// Size: 0xc0
function choosefinalkillcam()
{
    livingprops = getlivingplayersonteam( game[ "defenders" ] );
    
    if ( livingprops.size < 1 )
    {
        return;
    }
    
    livinghunters = getlivingplayersonteam( game[ "attackers" ] );
    
    if ( livinghunters.size < 1 )
    {
        return;
    }
    
    killcamprop = choosebestpropforkillcam( livingprops, livinghunters );
    
    if ( game_utility_common::isgameparticipant( killcamprop ) )
    {
        attackernum = killcamprop getentitynumber();
    }
    else
    {
        attackernum = -1;
    }
    
    victim = livinghunters[ 0 ];
    victim.deathtime = gettime() - 1000;
    final_killcam::recordfinalkillcam( 5, victim, killcamprop, attackernum, -1, 0, "none", 0, 0, "none", "normal" );
}

// Namespace br_gametype_prop
// Params 2
// Checksum 0xf23ab6c4, Offset: 0x4b81
// Size: 0x17c
function choosebestpropforkillcam( livingprops, livinghunters )
{
    bestprop = undefined;
    var_de3f29547ac68624 = 1073741824;
    
    foreach ( prop in livingprops )
    {
        assert( player::isreallyalive( prop ) );
        closesthunter = undefined;
        shortestpathdist = 1073741824;
        
        foreach ( hunter in livinghunters )
        {
            pathdist = distance( prop.origin, hunter.origin );
            
            if ( pathdist < shortestpathdist )
            {
                shortestpathdist = pathdist;
                closesthunter = hunter;
            }
        }
        
        if ( shortestpathdist < var_de3f29547ac68624 )
        {
            var_de3f29547ac68624 = shortestpathdist;
            bestprop = prop;
        }
    }
    
    if ( !isdefined( bestprop ) )
    {
        bestprop = utility::array_random( livingprops );
    }
    
    return bestprop;
}

// Namespace br_gametype_prop
// Params 0
// Checksum 0x4d825fc7, Offset: 0x4d06
// Size: 0x45, Type: bool
function ph_checkforovertime()
{
    if ( game[ "roundsWon" ][ "allies" ] == dvars::getwatcheddvar( "winlimit" ) - 1 && game[ "roundsWon" ][ "axis" ] == dvars::getwatcheddvar( "winlimit" ) - 1 )
    {
        return true;
    }
    
    return false;
}

// Namespace br_gametype_prop
// Params 0
// Checksum 0xdbd106c8, Offset: 0x4d54
// Size: 0x1a
function playerhunterpostloadout()
{
    equipment_mp::incrementequipmentammo( "equip_concussion" );
    class::loadout_removeperk( "specialty_selectivehearing" );
}

// Namespace br_gametype_prop
// Params 0
// Checksum 0x39b38758, Offset: 0x4d76
// Size: 0x9d
function givecustomloadout()
{
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    self waittill( #"giveloadout" );
    
    if ( !self.gulag )
    {
        playerhunterpostloadout();
    }
    
    self.thirdpersonrange = undefined;
    self setcamerathirdperson( 0 );
    playersetispropgameextrainfo( 0 );
    self allowprone( 1 );
    self allowsprint( 1 );
    weapons::updatemovespeedscale();
    self enableweaponpickup();
    player_utility::function_b54a1e23734ef07();
    player_utility::function_4688d689820ff1ed( "br_gametype_prop::giveCustomLoadout()" );
    self.concussionimmune = 1;
    attackerinitammo();
    thread attackerregenammo();
}

// Namespace br_gametype_prop
// Params 0
// Checksum 0x6e125fcc, Offset: 0x4e1b
// Size: 0x18a
function stillalivexp()
{
    level endon( #"game_ended" );
    level.scoreinfo[ "kill" ][ "value" ] = 300;
    flags::gameflagwait( "props_hide_over" );
    
    while ( true )
    {
        wait 10;
        
        foreach ( player in level.players )
        {
            if ( !isdefined( player.team ) )
            {
                continue;
            }
            
            if ( !player playerisprop() )
            {
                continue;
            }
            
            if ( !player::isreallyalive( player ) )
            {
                continue;
            }
            
            player thread giveawardfake( #"still_alive" );
            
            switch ( player.prop.info.propsize )
            {
                case 250:
                    player thread giveawardfake( #"still_alive_medium_bonus" );
                    break;
                case 450:
                    player thread giveawardfake( #"still_alive_large_bonus" );
                    break;
                case 550:
                    player thread giveawardfake( #"still_alive_extra_large_bonus" );
                    break;
                default:
                    break;
            }
        }
    }
}

// Namespace br_gametype_prop
// Params 0
// Checksum 0x19659f50, Offset: 0x4fad
// Size: 0xf2
function tracktimealive()
{
    level endon( #"game_ended" );
    waittillhuntersdrop();
    
    while ( true )
    {
        foreach ( player in level.players )
        {
            if ( !isdefined( player.team ) )
            {
                continue;
            }
            
            if ( player.team == game[ "attackers" ] )
            {
                continue;
            }
            
            if ( !player::isreallyalive( player ) )
            {
                continue;
            }
            
            if ( isdefined( player.pers[ "propSeconds" ] ) )
            {
                player.pers[ "propSeconds" ]++;
            }
        }
        
        wait 1;
    }
}

// Namespace br_gametype_prop
// Params 1
// Checksum 0x1b58056d, Offset: 0x50a7
// Size: 0x16e
function gamemodemodifyplayerdamage( damagedata )
{
    idamage = damagedata.damage;
    
    if ( self.propspectating )
    {
        self notify( #"hash_37d0803fbf7b52e0" );
        
        if ( damagedata.meansofdeath == "MOD_TRIGGER_HURT" )
        {
            return 0;
        }
    }
    
    if ( isdefined( damagedata.victim.team ) )
    {
        if ( damagedata.victim playerisprop() )
        {
            idamage = modifydamagetoprop( damagedata );
        }
        else
        {
            idamage = modifydamagetohunter( damagedata );
        }
        
        if ( idamage == 0 )
        {
            return 0;
        }
    }
    
    if ( isplayer( damagedata.attacker ) && isalive( damagedata.attacker ) )
    {
        if ( !isdefined( damagedata.attacker.hashitplayer ) )
        {
            damagedata.attacker.hashitplayer = 1;
        }
        
        if ( level.matchrules_damagemultiplier )
        {
            idamage *= level.matchrules_damagemultiplier;
        }
        
        if ( level.matchrules_vampirism )
        {
            damagedata.attacker.health = int( min( float( damagedata.attacker.maxhealth ), float( damagedata.attacker.health + 20 ) ) );
        }
    }
    
    return idamage;
}

// Namespace br_gametype_prop
// Params 1
// Checksum 0x79a6d2d9, Offset: 0x521e
// Size: 0x2d
function modifydamagetoprop( damagedata )
{
    if ( damagedata.meansofdeath == "MOD_FALLING" )
    {
        return 0;
    }
    
    return damagedata.damage;
}

// Namespace br_gametype_prop
// Params 1
// Checksum 0xee7c2fb5, Offset: 0x5254
// Size: 0x70
function modifydamagetohunter( damagedata )
{
    if ( damagedata.meansofdeath == "MOD_FALLING" )
    {
        return 0;
    }
    
    if ( damagedata.objweapon.basename == "concussion_grenade_mp" )
    {
        return 0;
    }
    
    if ( issubstr( damagedata.objweapon.basename, "destructible" ) )
    {
        return 0;
    }
    
    return damagedata.damage;
}

// Namespace br_gametype_prop
// Params 0
// Checksum 0xee2c51bd, Offset: 0x52cd
// Size: 0xbe
function attackerinitammo()
{
    primaryweapons = self getweaponslistprimaries();
    
    foreach ( weapon in primaryweapons )
    {
        self givemaxammo( weapon );
    }
    
    tacticalcount = self getweaponammostock( "concussion_grenade_mp" );
    tacticalcount -= self.thrownspecialcount;
    tacticalcount = int( max( tacticalcount, 0 ) );
    self setweaponammostock( "concussion_grenade_mp", tacticalcount );
}

// Namespace br_gametype_prop
// Params 0
// Checksum 0xed48d2b8, Offset: 0x5393
// Size: 0x7e
function attackerregenammo()
{
    self endon( #"death_or_disconnect" );
    self notify( #"attackerregenammo" );
    self endon( #"attackerregenammo" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        self waittill( #"reload_ammo_added" );
        primaryweapon = self getcurrentprimaryweapon();
        maxammo = weaponmaxammo( primaryweapon );
        
        if ( self getweaponammostock( primaryweapon ) < maxammo )
        {
            self setweaponammostock( primaryweapon, maxammo );
        }
    }
}

// Namespace br_gametype_prop
// Params 0
// Checksum 0x91a60d04, Offset: 0x5419
// Size: 0x6d
function checkkillrespawn()
{
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    wait 0.1;
    
    if ( self.pers[ "lives" ] == 1 )
    {
        self.pers[ "lives" ]--;
        level.livescount[ self.team ]--;
        gamelogic_mp::updategameevents();
        level notify( #"propcountchanged" );
        return;
    }
}

// Namespace br_gametype_prop
// Params 0
// Checksum 0xfe176b2b, Offset: 0x548e
// Size: 0x3b
function playerswapteam()
{
    newteam = game[ "attackers" ];
    
    if ( self.team == game[ "attackers" ] )
    {
        newteam = game[ "defenders" ];
    }
    
    menus::addtoteam( newteam );
}

// Namespace br_gametype_prop
// Params 1
// Checksum 0xf3c26c2, Offset: 0x54d1
// Size: 0x1ec
function onplayerkilled( damagedata )
{
    killedbyenemy = 0;
    level notify( #"playercountchanged" );
    
    if ( !flags::gameflag( "prematch_done" ) )
    {
        playerswapteam();
        return;
    }
    
    if ( !damagedata.victim playerisprop() )
    {
        thread respawnplayer();
    }
    else if ( !flags::gameflag( "props_hide_over" ) )
    {
        thread respawnplayer();
        return;
    }
    
    if ( isplayer( damagedata.attacker ) && damagedata.attacker != damagedata.victim && damagedata.victim.team != damagedata.attacker.team )
    {
        killedbyenemy = 1;
    }
    
    if ( killedbyenemy )
    {
        damagedata.attacker thread playerfakesplash( "prop_finalblow" );
    }
    
    foreach ( player in level.players )
    {
        if ( player.propspectating && isdefined( player.spectatingthisplayer ) && damagedata.victim == player.spectatingthisplayer )
        {
            player notify( #"hash_37d0803fbf7b52e0" );
        }
        
        if ( player != damagedata.attacker && player playerisprop() && isalive( player ) && damagedata.victim playerisprop() )
        {
            player thread playerfakesplash( "prop_survived" );
        }
    }
}

// Namespace br_gametype_prop
// Params 1
// Checksum 0x5854cd73, Offset: 0x56c5
// Size: 0x118
function playerfakesplash( splashref )
{
    localizedtext = undefined;
    
    switch ( splashref )
    {
        case #"hash_fa96c8e323b892e3":
            localizedtext = &"hash_3615babc6fe281e0";
            break;
        case #"hash_49aaf466425c5c43":
            localizedtext = &"hash_1de7a6b90bcaa3cd";
            break;
        case #"hash_4eaebc04b9ce0d9b":
            localizedtext = &"hash_5b05eacc249dfa38";
            break;
        case #"hash_70debde1965eada":
            localizedtext = &"hash_8635f92f14cf891";
            break;
        case #"hash_27f508cf05ea8106":
            localizedtext = &"hash_67fb542485f10cfc";
            break;
        case #"hash_c6ec665a408b5174":
            localizedtext = &"hash_79f6f5a5cbd43652";
            break;
        case #"hash_f0c8a9dc9649972f":
            localizedtext = &"hash_361e76eb84c08b5d";
            break;
        case #"hash_eae290238775f253":
            localizedtext = &"hash_2bf183c65419a5e9";
            break;
        default:
            assertmsg( "<dev string:x95>" + splashref );
            return;
    }
    
    self iprintlnbold( localizedtext );
}

// Namespace br_gametype_prop
// Params 0
// Checksum 0x9cceca1d, Offset: 0x57e5
// Size: 0x9
function respawnplayer()
{
    thread waitillcanspawnclient();
}

// Namespace br_gametype_prop
// Params 0
// Checksum 0x31d8abba, Offset: 0x57f6
// Size: 0x70
function waitillcanspawnclient()
{
    self endon( #"started_spawnplayer" );
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    
    for ( ;; )
    {
        wait 0.05;
        
        if ( isdefined( self ) && ( self.sessionstate == "spectator" || !player::isreallyalive( self ) ) )
        {
            self.pers[ "lives" ] = 1;
            playerlogic::spawnclient();
            continue;
        }
        
        return;
    }
}

// Namespace br_gametype_prop
// Params 1
// Checksum 0xbc88cca2, Offset: 0x586e
// Size: 0x21
function ondeadevent( team )
{
    if ( team == game[ "defenders" ] )
    {
        level thread propkilledend();
    }
}

// Namespace br_gametype_prop
// Params 1
// Checksum 0xe4cc7524, Offset: 0x5897
// Size: 0x62
function onplayerjointeam( player )
{
    if ( level.teambased )
    {
        player br::function_6b4dda86ffb422cf( 1 );
    }
    
    if ( !player playerisprop() )
    {
        if ( isdefined( player.proplocationindex ) )
        {
            player propremovefromlocation();
            return;
        }
        
        if ( isdefined( player.propcircleindex ) )
        {
            player propremovefromcircle();
        }
    }
}

// Namespace br_gametype_prop
// Params 0
// Checksum 0xdddb226f, Offset: 0x5901
// Size: 0xae
function propkilledend()
{
    if ( level.hunterswonending )
    {
        return;
    }
    
    if ( level.gameending )
    {
        return;
    }
    
    level.hunterswonending = 1;
    timepassed = game_utility::gettimepassed();
    game[ "propSurvivalTime" ][ game[ "defenders" ] ] = game[ "propSurvivalTime" ][ game[ "defenders" ] ] + timepassed;
    game[ "hunterKillTime" ][ game[ "attackers" ] ] = game[ "hunterKillTime" ][ game[ "attackers" ] ] + timepassed;
    level.gameending = 1;
    wait 3;
    thread ph_endgame( game[ "attackers" ], game[ "end_reason" ][ game[ "defenders" ] + "_eliminated" ] );
}

// Namespace br_gametype_prop
// Params 1
// Checksum 0x203b7d92, Offset: 0x59b7
// Size: 0x19, Type: bool
function function_2786fa8e2c98141a( params )
{
    if ( playerisprop() )
    {
        return false;
    }
    
    return true;
}

// Namespace br_gametype_prop
// Params 5
// Checksum 0x3063c93f, Offset: 0x59d9
// Size: 0x16b, Type: bool
function gametyperoundendscoresetomnvar( winner, isround, endreasontext, isgameover, team )
{
    if ( isgameover && isdefined( level.proptiebreaker ) )
    {
        if ( level.proptiebreaker == "kills" )
        {
            self setclientomnvar( "ui_round_end_reason", game[ "end_reason" ][ "prop_tiebreaker_kills" ] );
            self setclientomnvar( "ui_round_end_friendly_score", game[ "propScore" ][ team ] );
            self setclientomnvar( "ui_round_end_enemy_score", game[ "propScore" ][ level.otherteam[ team ] ] );
        }
        else if ( level.proptiebreaker == "time" )
        {
            teamseconds = game[ "hunterKillTime" ][ team ] / 1000;
            otherteamseconds = game[ "hunterKillTime" ][ level.otherteam[ team ] ] / 1000;
            var_23b93371f92a3ef5 = int( math::round_float( teamseconds ) );
            var_f4f15d6ca84b4783 = int( math::round_float( otherteamseconds ) );
            
            if ( var_23b93371f92a3ef5 == var_f4f15d6ca84b4783 )
            {
                if ( teamseconds > otherteamseconds )
                {
                    var_23b93371f92a3ef5++;
                }
                else
                {
                    var_f4f15d6ca84b4783++;
                }
            }
            
            self setclientomnvar( "ui_round_end_reason", game[ "end_reason" ][ "prop_tiebreaker_time" ] );
            self setclientomnvar( "ui_round_end_friendly_score", var_23b93371f92a3ef5 );
            self setclientomnvar( "ui_round_end_enemy_score", var_f4f15d6ca84b4783 );
        }
        
        return true;
    }
    
    return false;
}

// Namespace br_gametype_prop
// Params 0
// Checksum 0xd81de953, Offset: 0x5b4d
// Size: 0x6b
function playerwatchspectate()
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    
    while ( true )
    {
        msg = utility::waittill_any_return( "joined_spectators", "spectating_cycle", "death" );
        
        if ( msg == "death" )
        {
            continue;
        }
        
        waittillframeend();
        spectatedplayer = self getspectatingplayer();
        
        if ( !isdefined( spectatedplayer ) )
        {
            continue;
        }
    }
}

// Namespace br_gametype_prop
// Params 4
// Checksum 0x87521515, Offset: 0x5bc0
// Size: 0x11c
function highlighttoteamonce( team, color, ignoreplayer, bincludespectators = 1 )
{
    self hudoutlinedisable();
    
    foreach ( player in level.players )
    {
        if ( isdefined( ignoreplayer ) && ignoreplayer == player )
        {
            continue;
        }
        
        isspectator = player.sessionstate == "spectator";
        
        if ( player.team == team && !isspectator )
        {
            self hudoutlineenableforclient( player, color );
        }
        
        if ( bincludespectators && ( player.team == "spectator" || isspectator ) )
        {
            self hudoutlineenableforclient( player, color );
        }
    }
}

// Namespace br_gametype_prop
// Params 4
// Checksum 0x88f5b0d1, Offset: 0x5ce4
// Size: 0x96
function highlighttoteam( team, color, ignoreplayer, bincludespectators )
{
    self notify( #"hash_a1f9635f90a7cbdc" );
    self endon( #"hash_a1f9635f90a7cbdc" );
    self endon( #"clear" );
    self endon( #"death" );
    self endon( #"maxdelete" );
    
    if ( !isdefined( bincludespectators ) )
    {
        bincludespectators = 1;
    }
    
    highlighttoteamonce( team, color, ignoreplayer, bincludespectators );
    
    for ( ;; )
    {
        level waittill( #"add_to_team" );
        highlighttoteamonce( team, color, ignoreplayer, bincludespectators );
    }
}

// Namespace br_gametype_prop
// Params 1
// Checksum 0xc627d59d, Offset: 0x5d82
// Size: 0xb6, Type: bool
function checkunscoredspawnpoint( spawnpoint )
{
    foreach ( player in level.players )
    {
        if ( player playerisprop() )
        {
            if ( isdefined( player.spawninfo ) && player.spawninfo.spawnpoint == spawnpoint )
            {
                return false;
            }
        }
    }
    
    return true;
}

// Namespace br_gametype_prop
// Params 2
// Checksum 0x4fc1e326, Offset: 0x5e41
// Size: 0x48, Type: bool
function disablespawningforplayer( player, revivespawn )
{
    if ( flags::gameflag( "prematch_done" ) )
    {
        return false;
    }
    
    if ( !game_utility_mp::gamehasstarted() )
    {
        return false;
    }
    
    if ( player playerisprop() )
    {
        return !level.ingraceperiod;
    }
    
    return false;
}

// Namespace br_gametype_prop
// Params 0
// Checksum 0x71a7bb7b, Offset: 0x5e92
// Size: 0x21, Type: bool
function playerisprop()
{
    return isdefined( self.team ) && self.team == game[ "defenders" ];
}

// Namespace br_gametype_prop
// Params 2
// Checksum 0xb81b04d4, Offset: 0x5ebc
// Size: 0x28, Type: bool
function playerskiplootpickup( instance, autouse )
{
    return playerisprop() || level.infilcinematicactive;
}

// Namespace br_gametype_prop
// Params 1
// Checksum 0xba2d5d, Offset: 0x5eed
// Size: 0x6f
function giveawardfake( event )
{
    xp = rank::getscoreinfoxp( event );
    rank::giverankxp( event, xp );
    points::giveunifiedpoints( event, undefined, undefined, -1 );
    
    if ( isdefined( self.awardsthislife[ event ] ) )
    {
        self.awardsthislife[ event ]++;
    }
    else
    {
        self.awardsthislife[ event ] = 1;
    }
    
    playerfakesplash( event );
}

// Namespace br_gametype_prop
// Params 0
// Checksum 0xaa43e99d, Offset: 0x5f64
// Size: 0x12
function playerprespawngulagjail()
{
    if ( playerisprop() )
    {
        playerswapteam();
    }
}

// Namespace br_gametype_prop
// Params 0
// Checksum 0xee3b1b46, Offset: 0x5f7e
// Size: 0xab
function playernakeddroploadout()
{
    phclass();
    self.prevweaponobj = undefined;
    struct = class::loadout_getclassstruct();
    struct = class::loadout_updateclass( struct, "gamemode" );
    class::preloadandqueueclassstruct( struct, 1, 1 );
    self takeallweapons();
    class::giveloadout( self.team, "gamemode", 1, 1 );
    self givestartammo( struct.loadoutprimaryobject );
    
    if ( isdefined( struct.loadoutsecondaryobject ) )
    {
        self givestartammo( struct.loadoutsecondaryobject );
    }
    
    br_weapons::br_ammo_player_clear();
    self notify( #"ammo_update" );
    playerhunterpostloadout();
}

// Namespace br_gametype_prop
// Params 4
// Checksum 0x73cb8bad, Offset: 0x6031
// Size: 0x47
function vehicle_occupancy_mp_onentervehicle( vehicle, newseatid, player, data )
{
    vehicle_occupancy_mp::vehicle_occupancy_mp_onentervehicle( vehicle, newseatid, player, data );
    
    if ( player playerisprop() )
    {
        player setcamerathirdperson( 0 );
    }
}

// Namespace br_gametype_prop
// Params 4
// Checksum 0x18b4f530, Offset: 0x6080
// Size: 0x68
function vehicle_occupancy_mp_onexitvehicle( vehicle, oldseatid, player, data )
{
    vehicle_occupancy_mp::vehicle_occupancy_mp_onexitvehicle( vehicle, oldseatid, player, data );
    
    if ( !data.playerdisconnect && !data.playerdeath && player playerisprop() )
    {
        player setcamerathirdperson( 1 );
    }
}

// Namespace br_gametype_prop
// Params 1
// Checksum 0x7e6d3928, Offset: 0x60f0
// Size: 0x32, Type: bool
function droponplayerdeath( attacker )
{
    if ( level.usegulag && br_public::isplayeringulag() )
    {
        return true;
    }
    
    if ( playerisprop() )
    {
        return true;
    }
    
    return false;
}

// Namespace br_gametype_prop
// Params 0
// Checksum 0x5ec34ade, Offset: 0x612b
// Size: 0x16f
function getinfilplayers()
{
    playersrandomized = arrayrandomize( level.players );
    numhunters = level.ph.settings.numhunters;
    
    if ( level.players.size < numhunters )
    {
        numhunters = 1;
    }
    
    count = 0;
    hunters = [];
    props = [];
    
    foreach ( player in playersrandomized )
    {
        /#
            host = gamelogic_mp::gethostplayer();
            
            if ( host == player && getdvarint( @"hash_42ba012cc84dd157", 0 ) )
            {
                hunters[ hunters.size ] = player;
                count++;
                continue;
            }
            else if ( host == player && getdvarint( @"hash_c55faa30da4c2cd4", 0 ) )
            {
                props[ props.size ] = player;
                count++;
                continue;
            }
        #/
        
        if ( count < numhunters )
        {
            hunters[ hunters.size ] = player;
        }
        else
        {
            props[ props.size ] = player;
        }
        
        count++;
    }
    
    thread setuphunters( hunters );
    thread setupprops( props );
    return hunters;
}

// Namespace br_gametype_prop
// Params 0
// Checksum 0xbc81071b, Offset: 0x62a3
// Size: 0x2e
function playerforcespawn()
{
    self endon( #"disconnect" );
    self notify( #"death_or_disconnect" );
    self notify( #"death" );
    waittillframeend();
    br_infils_legacy::c130forcespawnplayer();
}

// Namespace br_gametype_prop
// Params 1
// Checksum 0x9956ab87, Offset: 0x62d9
// Size: 0x121
function setuphunters( players )
{
    if ( !level.br_infils_disabled )
    {
        flags::gameflagwait( "prematch_fade_done" );
        waitframe();
    }
    
    foreach ( player in players )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        if ( player playerisprop() )
        {
            player playerswapteam();
            player phclass();
            player.forcespawnorigin = player.origin;
            player.forcespawnangles = player.angles;
            player thread playerforcespawn();
        }
        
        if ( level.br_infils_disabled )
        {
            player br_weapons::br_ammo_player_clear();
            player br_weapons::br_ammo_give_type( player, "brloot_ammo_762", 200, 0 );
            player notify( #"ammo_update" );
        }
    }
}

// Namespace br_gametype_prop
// Params 0
// Checksum 0x3abf917, Offset: 0x6402
// Size: 0xef
function getpropnextstartlocation()
{
    if ( !isdefined( level.ph.settings.randomstartindex ) )
    {
        level.ph.settings.randomstartindex = randomint( level.ph.locationcircles.size );
    }
    else
    {
        level.ph.settings.randomstartindex = ( level.ph.settings.randomstartindex + 1 ) % level.ph.locationcircles.size;
    }
    
    location = level.ph.locationcircles[ level.ph.settings.randomstartindex ];
    return location;
}

// Namespace br_gametype_prop
// Params 2
// Checksum 0x10da9985, Offset: 0x64fa
// Size: 0xf0
function getpropspawnlocation( index, baseorigin )
{
    ring_item_count = 10;
    var_6b4eba0d0802f652 = 200;
    var_625ed844eeb42047 = 100;
    ring_yaw = 10;
    slot_yaw = 360 / ring_item_count;
    ring = int( index / ring_item_count );
    slot = index - ring * ring_item_count;
    yaw = slot * slot_yaw + ring * ring_yaw;
    dist = var_6b4eba0d0802f652 + ring * var_625ed844eeb42047;
    angles = ( 0, yaw, 0 );
    dir = anglestoforward( angles );
    origin = baseorigin + dir * dist;
    origin = getgroundposition( origin, 15, 12000, 12000 );
    return origin;
}

// Namespace br_gametype_prop
// Params 1
// Checksum 0xe6103edf, Offset: 0x65f3
// Size: 0x1c
function playerteleportprop( origin )
{
    self cancelmantle();
    self setorigin( origin, 1 );
}

// Namespace br_gametype_prop
// Params 1
// Checksum 0xf3941272, Offset: 0x6617
// Size: 0x11c
function waitandspawnprops( players )
{
    foreach ( player in players )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        player br_infils_util::endprematchskydiving();
        
        if ( !player playerisprop() )
        {
            player playerswapteam();
            player.forcespawnorigin = player.propspawnorigin;
            player thread playerforcespawn();
        }
        else if ( !isalive( player ) )
        {
            player.forcespawnorigin = player.propspawnorigin;
            player br_infils_legacy::c130forcespawnplayer();
        }
        else
        {
            player playerteleportprop( player.propspawnorigin );
            player.br_infilstarted = 1;
        }
        
        player notify( #"beginC130" );
    }
}

// Namespace br_gametype_prop
// Params 1
// Checksum 0xf562c5e0, Offset: 0x673b
// Size: 0x2ad
function setupprops( players )
{
    startlocation = getpropnextstartlocation();
    index = 0;
    
    foreach ( player in players )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        player utility::hidehudenable();
        
        /#
            if ( player isnoclip() )
            {
                player noclip();
            }
            
            if ( player isufo() )
            {
                player ufo();
            }
        #/
        
        spawnorigin = getpropspawnlocation( index, startlocation.origin );
        player.propspawnorigin = spawnorigin;
        index++;
        
        if ( index >= level.ph.settings.numpropsperarea )
        {
            startlocation = getpropnextstartlocation();
            index = 0;
        }
    }
    
    fade_in_time = 1;
    black_hold_time = 1.5;
    fade_out_time = 1;
    thread br_infils_legacy::infilallfadetoblack( fade_in_time, black_hold_time, fade_out_time, "prop_respawn_finished", players, 1 );
    
    foreach ( player in players )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        player predictstreamposuntilcleared( player.propspawnorigin );
    }
    
    wait fade_in_time;
    waitframe();
    cleanupallclones();
    waitandspawnprops( players );
    level notify( #"prop_respawn_finished" );
    wait black_hold_time;
    
    foreach ( player in players )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        player clearpredictedstreampos();
        player br_infils_util::endprematchskydiving();
        
        if ( utility::get_int_or_0( player.hidehudenabled ) > 0 )
        {
            player utility::hidehuddisable();
        }
        
        player.br_isininfil = 1;
    }
    
    flags::gameflagset( "props_hide_start" );
}

// Namespace br_gametype_prop
// Params 4
// Checksum 0xf640039b, Offset: 0x69f0
// Size: 0x12e
function initlocationcircle( location, xcoord, ycoord, radius )
{
    locationcircle = spawnstruct();
    locationcircle game_utility::questcircle_create( "Prop_Br", ( xcoord, ycoord, 0 ), radius );
    locationcircle game_utility::questcircle_hidefromall();
    locationcircle.inuse = 0;
    locationcircle.count = 0;
    locationcircle.name = location;
    locationcircle.radius = radius;
    locationcircle.radiussq = radius * radius;
    objectiveiconid = objidpoolmanager::requestobjectiveid( 1 );
    locationcircle.objectiveiconid = objectiveiconid;
    
    if ( objectiveiconid != -1 )
    {
        objidpoolmanager::objective_add_objective( objectiveiconid, "active", ( 0, 0, 0 ), "ui_mp_br_compass_icon_quest_assassin" );
        objidpoolmanager::update_objective_setbackground( objectiveiconid, 1 );
        objective_showtoplayersinmask( objectiveiconid );
        objidpoolmanager::update_objective_position( objectiveiconid, ( xcoord, ycoord, 0 ) );
    }
    
    level.ph.locationcircles[ level.ph.locationcircles.size ] = locationcircle;
}

// Namespace br_gametype_prop
// Params 0
// Checksum 0xadf8640e, Offset: 0x6b26
// Size: 0x15a
function initpropcircles()
{
    level.ph.propcircles = [];
    var_f9d9f7c6068bc86a = level.maxteamsize - level.ph.settings.numhunters;
    
    for ( i = 0; i < var_f9d9f7c6068bc86a ; i++ )
    {
        level.ph.propcircles[ i ] = spawnstruct();
        level.ph.propcircles[ i ] game_utility::questcircle_create( "Prop_Circle_Br", ( 0, 0, 0 ), 500 );
        level.ph.propcircles[ i ] game_utility::questcircle_hidefromall();
        level.ph.propcircles[ i ].inuse = 0;
        level.ph.propcircles[ i ].count = 0;
        level.ph.propcircles[ i ].radius = 500;
        level.ph.propcircles[ i ].radiussq = 250000;
    }
}

// Namespace br_gametype_prop
// Params 0
// Checksum 0x23ebf286, Offset: 0x6c88
// Size: 0x2b5
function startpropcirclelogic()
{
    propteam = game[ "defenders" ];
    
    while ( level.teamdata[ propteam ][ "players" ].size == 0 )
    {
        waitframe();
    }
    
    while ( true )
    {
        proplist = level.teamdata[ propteam ][ "players" ];
        
        if ( isdefined( level.ph.fakeprops ) )
        {
            proplist = level.ph.fakeprops;
        }
        
        foreach ( player in proplist )
        {
            if ( isdefined( player.proplocationindex ) )
            {
                locationcircle = level.ph.locationcircles[ player.proplocationindex ];
                distsq = distance2dsquared( locationcircle.origin, player.origin );
                
                if ( distsq <= locationcircle.radiussq )
                {
                    continue;
                }
                else
                {
                    player propremovefromlocation();
                }
            }
            else if ( isdefined( player.propcircleindex ) )
            {
                propcircle = level.ph.propcircles[ player.propcircleindex ];
                distsq = distance2dsquared( propcircle game_utility::questcircle_getorigin(), player.origin );
                
                if ( distsq > propcircle.radiussq )
                {
                    player propremovefromcircle();
                }
            }
            
            var_faf56f301aa3c65 = undefined;
            bestdistsq = undefined;
            
            for ( i = 0; i < level.ph.locationcircles.size ; i++ )
            {
                locationcircle = level.ph.locationcircles[ i ];
                distsq = distance2dsquared( locationcircle.origin, player.origin );
                
                if ( distsq <= locationcircle.radiussq && ( !isdefined( bestdistsq ) || distsq < bestdistsq ) )
                {
                    bestdistsq = distsq;
                    var_faf56f301aa3c65 = i;
                }
            }
            
            if ( isdefined( var_faf56f301aa3c65 ) )
            {
                if ( isdefined( player.propcircleindex ) )
                {
                    player propremovefromcircle();
                }
                
                player propaddtolocation( var_faf56f301aa3c65 );
                continue;
            }
            
            if ( !isdefined( player.propcircleindex ) )
            {
                player propaddtocircle();
            }
        }
        
        waitframe();
    }
}

// Namespace br_gametype_prop
// Params 0
// Checksum 0x6dfd7f01, Offset: 0x6f45
// Size: 0x3c
function propgetlocation()
{
    if ( isdefined( self.proplocationindex ) )
    {
        return level.ph.locationcircles[ self.proplocationindex ].name;
    }
    
    return "any";
}

// Namespace br_gametype_prop
// Params 1
// Checksum 0xc0f66822, Offset: 0x6f8a
// Size: 0x86
function propaddtolocation( index )
{
    self.proplocationindex = index;
    locationcircle = level.ph.locationcircles[ index ];
    locationcircle.count++;
    
    if ( locationcircle.count == 1 )
    {
        locationcircle.inuse = 1;
        locationcircle game_utility::questcircle_showtoall();
        objidpoolmanager::update_objective_ownerteam( locationcircle.objectiveiconid, game[ "defenders" ] );
    }
}

// Namespace br_gametype_prop
// Params 0
// Checksum 0xb00d2f2c, Offset: 0x7018
// Size: 0x9b
function propremovefromlocation()
{
    index = self.proplocationindex;
    locationcircle = level.ph.locationcircles[ index ];
    assert( locationcircle.count > 0 );
    locationcircle.count--;
    
    if ( locationcircle.count == 0 )
    {
        locationcircle.inuse = 0;
        locationcircle game_utility::questcircle_hidefromall();
        objidpoolmanager::update_objective_ownerteam( locationcircle.objectiveiconid, undefined );
    }
    
    self.proplocationindex = undefined;
}

// Namespace br_gametype_prop
// Params 0
// Checksum 0x72b67020, Offset: 0x70bb
// Size: 0xcf
function propaddtocircle()
{
    index = getnextcircleindex();
    
    if ( !isdefined( index ) )
    {
        return;
    }
    
    self.propcircleindex = index;
    propcircle = level.ph.propcircles[ index ];
    propcircle.count++;
    
    if ( propcircle.count == 1 )
    {
        propcircle.inuse = 1;
        propcircle game_utility::questcircle_showtoall();
        propcircle.radiussq = 250000;
    }
    
    randomloc = ( self.origin[ 0 ], self.origin[ 1 ], 500 );
    randomloc += math::random_vector_2d() * randomfloatrange( 0, 500 );
    propcircle game_utility::questcircle_move( randomloc );
}

// Namespace br_gametype_prop
// Params 0
// Checksum 0xfa836be5, Offset: 0x7192
// Size: 0x61
function getnextcircleindex()
{
    for ( i = 0; i < level.ph.propcircles.size ; i++ )
    {
        propcircle = level.ph.propcircles[ i ];
        
        if ( !propcircle.inuse )
        {
            return i;
        }
    }
}

// Namespace br_gametype_prop
// Params 0
// Checksum 0xe54d779e, Offset: 0x71fb
// Size: 0x88
function propremovefromcircle()
{
    index = self.propcircleindex;
    propcircle = level.ph.propcircles[ index ];
    assert( propcircle.count > 0 );
    propcircle.count--;
    
    if ( propcircle.count == 0 )
    {
        propcircle.inuse = 0;
        propcircle game_utility::questcircle_hidefromall();
    }
    
    self.propcircleindex = undefined;
}

