// scripts\mp\br\gametypes\br_gametype_kingslayer.gsc  (hash_27813b9be83cdd08.gscc) (size: 35296 Bytes / 0x89e0 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xf1ee0a93 (4058909331)
// size ...... 35296 (0x89e0)
// includes .. 39  (offset: 0x8380)
// strings ... 88  (offset: 0x84b8)
// dev strs .. 4   (offset: 0x89ac)
// exports ... 76  (offset: 0x5ae0)
// cseg ...... 0x79b + 0x5345 (0x5ae0)
// imports ... 225 (offset: 0x66c0)
// animtree1 . 0   (offset: 0x89e0)
// animtree2 . 0   (offset: 0x89e0)
#using script_16ea1b94f0f381b3;
#using scripts\common\math;
#using scripts\common\omnvar_utility;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\mp\battlechatter_mp;
#using scripts\mp\br\gametypes\br;
#using scripts\mp\br\gametypes\br_c130;
#using scripts\mp\br\gametypes\br_c130airdrop;
#using scripts\mp\br\gametypes\br_circle;
#using scripts\mp\br\gametypes\br_contract_manager;
#using scripts\mp\br\gametypes\br_gametypes;
#using scripts\mp\br\gametypes\br_gulag;
#using scripts\mp\br\gametypes\br_infils_util;
#using scripts\mp\br\gametypes\br_pickups;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\br\gametypes\br_spawnrespawn;
#using scripts\mp\br\gametypes\br_spectate;
#using scripts\mp\br\gametypes\br_utility;
#using scripts\mp\common\killstreaks\airdrop;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\lower_message;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\stats;
#using scripts\mp\common\utility\teams;
#using scripts\mp\execution;
#using scripts\mp\flags;
#using scripts\mp\gamelogic;
#using scripts\mp\gamescore;
#using scripts\mp\hud_message;
#using scripts\mp\hud_util;
#using scripts\mp\music_br;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\parachute;
#using scripts\mp\playerlogic;
#using scripts\mp\rank;
#using scripts\mp\spectating;

#namespace br_gametype_kingslayer;

// Namespace br_gametype_kingslayer
// Params 0
// Checksum 0x456a0724, Offset: 0x7b9
// Size: 0x17
function main()
{
    level.var_dd10333ade220938 = &init;
    br::main();
}

// Namespace br_gametype_kingslayer
// Params 0
// Checksum 0xf23f0882, Offset: 0x7d8
// Size: 0x3c
function init()
{
    level thread function_e0743baee4025e81();
    level thread brking_initfeatures();
    level thread brking_initpostmain();
    level thread brking_initdialog();
    level thread brking_initexternalfeatures();
    
    /#
        setdevdvarifuninitialized( @"scr_brking_debug", 0 );
    #/
}

// Namespace br_gametype_kingslayer
// Params 0
// Checksum 0xf0488310, Offset: 0x81c
// Size: 0x824
function brking_initfeatures()
{
    if ( getdvarint( @"scr_brking_debug", 0 ) == 1 )
    {
        br_gametypes::enablefeature( #"allowlatejoiners" );
    }
    
    setdvar( @"scr_br_moving_circle_enabled", 1 );
    setomnvar( "ui_gulag_state", 1 );
    setomnvar( "ui_hide_redeploy_timer", 1 );
    level.forcedisablelaststand = getdvarint( @"hash_b7d1eb5f054111c3", 0 ) == 1;
    level.giveloadouteverytime = getdvarint( @"hash_2efff4c3f474f5c7", 1 );
    level.instantbleedoutsquadwipe = getdvarint( @"hash_c6acab01f606ff92", 1 );
    level.var_43a48d7594b1b278 = getdvarint( @"hash_5b32c84486d02636", 1 );
    level.var_12340d06a63599f5 = getdvarint( @"hash_5cf68437a2b713ab", 0 );
    level.ks_pointstowin = getdvarint( @"scr_kingslayer_pointstowin", 50 );
    level.ks_pointbonusforteam = getdvarint( @"scr_kingslayer_pointbonusforteam", 1 ) == 1;
    level.ks_pointkingsgetnobonus = getdvarint( @"scr_kingslayer_pointkingsgetnobonus", 1 ) == 1;
    level.ks_pointsperkingslain = getdvarint( @"hash_3d4c65ce5366ec58", 5 );
    setdvar( @"hash_5072385f6119ff87", level.ks_pointstowin );
    level.hideleaderhashuntilpercent = getdvarint( @"hash_c124a7a4afb14348", 0 );
    level.dmzlootleaderupdateonpickup = getdvarint( @"hash_9efdb377e7ae2dff", 0 ) == 1;
    level.showplacementsplashesandmusic = getdvarint( @"hash_63908c5e06402524", 1 );
    level.secondsbeforeplacementupdates = getdvarint( @"hash_e616cb0e727859dd", 60 );
    level.disablepercentageannouncements = getdvarint( @"hash_69e6435403e5c322", 0 );
    level.lootleadermarkcount = getdvarint( @"scr_plunder_loot_leader_mark_count", 3 );
    level.maxlootleadermarkcount = getdvarint( @"scr_plunder_loot_leader_mark_count", 3 );
    level.lootleadermarksize = getdvarint( @"hash_1650346812659df2", 1000 );
    level.lootleaderoneperteam = getdvarint( @"hash_5fd1126ec81d6b0b", 1 ) == 1;
    level.lootleadermarksizedynamic = getdvarint( @"hash_1b7554a04b02683c", 0 );
    level.lootleadermarkstrongsize = getdvarint( @"hash_210471fb05950431", 2000 );
    level.lootleadermarkstrongvalue = getdvarint( @"hash_f53e6f6fddbbbc11", 5000 );
    level.lootleadermarkweaksize = getdvarint( @"hash_fc8b22a888365974", 5000 );
    level.lootleadermarkweakvalue = getdvarint( @"hash_43d67f5054412e02", 1000 );
    level.lootleadermarksontopteams = getdvarint( @"scr_plunder_loot_leader_mark_top_teams", 3 );
    level.var_57a481d5824a220b = getdvarint( @"hash_2e8375198ed09e2a", 0 );
    level.plundermusicfirst = getdvarfloat( @"hash_24c7c305d1ead986", 0.3 );
    level.plundermusicsecond = getdvarfloat( @"hash_3f1f73f0aeec8fd4", 0.5 );
    level.plundermusicthird = getdvarfloat( @"hash_25360b6a507d1e21", 0.75 );
    level.plundermusicfourth = getdvarfloat( @"hash_11b704eda4d01a78", 0.9 );
    level.var_9010a3d9d2f1c4ad = getdvarfloat( @"hash_3dcc41767cb14120", 20 );
    level.var_c65d360ae9b3f43a = [];
    level.useautorespawn = getdvarint( @"hash_9ea6558e3fdc02d8", 1 );
    level.autorespawnwaittime = getdvarint( @"hash_4beac336193a373d", 1 );
    level.tokenrespawnwaittime = getdvarint( @"hash_728cba7a2adc64db", level.autorespawnwaittime );
    level.incrementalrespawnpunish = getdvarint( @"hash_fc3a0f4f0cdd615e", 0 );
    level.incrementalrespawnpunishmax = getdvarfloat( @"hash_5eb645f42926f53b", 15 );
    level.respawnheightoverride = getdvarint( @"scr_plunder_respawnheightoverride", 5000 );
    level.respawntimedisable = getdvarint( @"hash_73dbc19ad4c85d57", 0 );
    level.parachutedeploydelay = getdvarfloat( @"hash_12027360b079c1db", 0.5 );
    level.var_ece3c643b8f0fb95 = getdvarint( @"hash_d851ff5831a4337f", 1 ) == 1;
    level.ks_spawnprotection = getdvarint( @"scr_kingslayer_spawnprotection", 1 ) == 1;
    level.ks_spawnprotectionmodifier = getdvarfloat( @"hash_bc575bed6a3b9354", 0.5 );
    level.var_143000384a75721d = getdvarfloat( @"hash_ef6ae3f9fa140ab3", 0.5 );
    level.skipweapondropondeath = getdvarint( @"hash_8d982a8e8331b9f7", 1 );
    level.skipequipmentdropondeath = getdvarint( @"hash_370fb0965baf2ad5", 1 );
    level.ks_circlemovedist = getdvarint( @"hash_10c20627fb5fc19d", 18000 );
    level.ks_airdroppercircle = getdvarint( @"scr_kingslayer_airdroppercircle", 1 );
    level.ks_airdropcrateusetime = getdvarint( @"scr_kingslayer_airdropcrateusetime", 3 );
    level.ks_airdropcratearmor = getdvarint( @"scr_kingslayer_airdropcratearmor", 3 );
    level.ks_circlecount = getdvarint( @"scr_kingslayer_circlecount", 20 );
    level.ks_circleradius = getdvarfloat( @"scr_kingslayer_circleradius", 10100 );
    
    if ( level.var_326746b41ba6efe1 )
    {
        level.ks_circleradius = 12500;
    }
    
    level.ks_circleclosetime = getdvarfloat( @"scr_kingslayer_circleclosetime", 50 );
    level.ks_circledelaytime = getdvarfloat( @"scr_kingslayer_circledelaytime", 50 );
    level.ks_circleminimapradius = getdvarint( @"scr_kingslayer_circleminimapradius", 4750 );
    level.ks_circlemoving = getdvarint( @"hash_70fbf384d2ff2b5d", 1 ) == 1;
    level.var_3636bdf6f31bf1b2 = getdvarint( @"hash_717b3f55f18c8d28", 1 );
    level.var_c530f740e5b95fd8 = getdvarint( @"hash_720b0b024ae6a9d6", 1 );
    level.modespawnendofgame = &playerspawnendofgame;
    level.endmatchcameratransitions = getdvarint( @"hash_ec4443371f0f6367", 1 );
    level.topteamsever = [];
    level.lootleaders = [];
    level.called50percentprogress = 0;
    level.called75percentprogress = 0;
    level.called90percentprogress = 0;
    
    if ( getdvarint( @"hash_7379375b4c81548d", 0 ) == 1 )
    {
        br_gametypes::disablefeature( #"kiosk" );
    }
    
    br_gametypes::disablefeature( #"gulag" );
    br_gametypes::disablefeature( #"dropbag" );
    br_gametypes::disablefeature( #"onelife" );
    br_gametypes::disablefeature( #"plundersites" );
    br_gametypes::disablefeature( #"missions" );
    br_gametypes::disablefeature( #"randomizecirclecenter" );
    br_gametypes::disablefeature( #"planesnaptooob" );
    br_gametypes::enablefeature( #"tabletreplace" );
    br_gametypes::enablefeature( #"planeusecircleradius" );
    br_gametypes::enablefeature( #"circleearlystart" );
    
    if ( getdvarint( @"hash_1a792bd0a9a80c0b", 0 ) == 1 )
    {
        br_gametypes::disablefeature( #"loot" );
    }
    
    if ( getdvarint( @"hash_cde05f5f3924be50", 0 ) == 1 )
    {
        br_gametypes::disablefeature( #"armor" );
    }
    
    level.onstartgametype = &onstartgametype;
    level.modespawnclient = &modespawn;
    level.ononeleftevent = &ononeleftevent;
    utility::registersharedfunc( #"gametype", #"playershouldrespawn", &playershouldrespawn );
    utility::registersharedfunc( #"gametype", #"hash_251cc1c137f65b9e", &spawnhandled );
    utility::registersharedfunc( #"gametype", #"hash_a407cc94ad2c6279", &brking_onplayerconnect );
    utility::registersharedfunc( #"gametype", #"hash_e5952e921a56e06a", &brking_ondeadevent );
    level.br_circle_init_func = &alternatebrcircle;
    level.ks_killleaders = [];
    level.shownonspectatingwinnersplash = 1;
}

// Namespace br_gametype_kingslayer
// Params 1
// Checksum 0x826c8cd3, Offset: 0x1048
// Size: 0x26, Type: bool
function spawnhandled( player )
{
    return player.br_infilstarted && flags::gameflag( "prematch_done" );
}

// Namespace br_gametype_kingslayer
// Params 1
// Checksum 0x475a614, Offset: 0x1077
// Size: 0xe, Type: bool
function playershouldrespawn( data )
{
    return true;
}

// Namespace br_gametype_kingslayer
// Params 0
// Checksum 0x49dd5d8e, Offset: 0x108e
// Size: 0x7b
function function_e0743baee4025e81()
{
    killstreakdata = spawnstruct();
    killstreakdata.weights = [];
    level.kingkillstreakdata = killstreakdata;
    function_f4bdc29db633ab6c( "toma_strike", getdvarint( @"hash_f9549037967baa32", 50 ) );
    function_f4bdc29db633ab6c( "precision_airstrike", getdvarint( @"hash_2c0ca56d5f18da83", 10 ) );
    function_f4bdc29db633ab6c( "directional_uav", getdvarint( @"hash_77b6803e6319d004", 40 ) );
}

// Namespace br_gametype_kingslayer
// Params 0
// Checksum 0x37af8c3f, Offset: 0x1111
// Size: 0x1a5
function brking_initpostmain()
{
    utility::registersharedfunc( #"gametype", #"createc130pathstruct", &brking_createc130pathstruct );
    utility::registersharedfunc( #"gametype", #"addtoc130infil", &brking_addtoc130infil );
    utility::registersharedfunc( #"gametype", #"playerwelcomesplashes", &brking_playerwelcomesplashes );
    utility::registersharedfunc( #"gametype", #"packclientmatchdata", &packclientmatchdata );
    waittillframeend();
    flags::gameflaginit( "placement_updates_allowed", 0 );
    level.ontimelimit = &brking_ontimelimit;
    level.onplayerkilled = &brking_onplayerkilled;
    level.modeplayerkilledspawn = &playerkilledspawn;
    level.modifyplayerdamage = &brking_modifyplayerdamage;
    level.assists_disabled = undefined;
    utility::registersharedfunc( #"br_c130airdrop", #"c130airdrop_oncrateuse", &brking_oncrateuse );
    brking_cleanupents();
    initteamdatafields();
    level.lootleadermarks = [];
    level.validautoassignquests = [];
    level.validautoassignquests[ 0 ] = "assassination";
    level.validautoassignquests[ 1 ] = "domination";
    level.validautoassignquests[ 2 ] = "scavenger";
    level thread eomawardplayerxp();
    level thread function_610471b316c32aa5();
    level thread brking_managecratedrops();
    level thread brking_managecircles();
    thread waitandstartscorepolling();
    level thread placementupdatewait();
    
    if ( getdvarfloat( @"scr_plunder_loot_leader_update_interval", 15 ) > 0 )
    {
        level thread updatelootleadersonfixedinterval();
    }
    
    if ( level.endmatchcameratransitions )
    {
        level thread initendcameralocations();
    }
}

// Namespace br_gametype_kingslayer
// Params 0
// Checksum 0xb91e0606, Offset: 0x12be
// Size: 0x2e
function brking_initdialog()
{
    level endon( #"game_ended" );
    level waittill( #"hash_bb95e0eb0e85637" );
    game[ "dialog" ][ "match_start" ] = "gametype_tdm";
}

// Namespace br_gametype_kingslayer
// Params 0
// Checksum 0x93390171, Offset: 0x12f4
// Size: 0x3d
function brking_cleanupents()
{
    game_utility::removematchingents_bykey( "delete_on_load", "targetname" );
    game_utility::removematchingents_bymodel( "door_prison_cell_metal_mp", 1 );
    game_utility::removematchingents_bymodel( "door_wooden_panel_mp_01", 1 );
    game_utility::removematchingents_bymodel( "me_electrical_box_street_01", 1 );
}

// Namespace br_gametype_kingslayer
// Params 0
// Checksum 0x6b1816b5, Offset: 0x1339
// Size: 0x2
function brking_initexternalfeatures()
{
    
}

// Namespace br_gametype_kingslayer
// Params 0
// Checksum 0x6e3d65e5, Offset: 0x1343
// Size: 0x9a
function initteamdatafields()
{
    foreach ( team in level.teamnamelist )
    {
        level.teamdata[ team ][ "teamTotalScore" ] = 0;
        level.teamdata[ team ][ "tokensTeamTotal" ] = 0;
    }
}

// Namespace br_gametype_kingslayer
// Params 2
// Checksum 0xe31d9494, Offset: 0x13e5
// Size: 0x2d
function function_f4bdc29db633ab6c( streakname, weight )
{
    level.kingkillstreakdata.weights[ streakname ] = weight;
}

// Namespace br_gametype_kingslayer
// Params 1
// Checksum 0x4777c40b, Offset: 0x141a
// Size: 0x12a
function function_989a118c727ff6fb( player )
{
    var_3e0c8c6bf8c2fcbb = [];
    maxval = 0;
    
    foreach ( key, weight in level.kingkillstreakdata.weights )
    {
        maxval += weight;
        var_3e0c8c6bf8c2fcbb[ key ] = maxval;
    }
    
    randint = randomint( maxval );
    ksref = undefined;
    
    foreach ( key, maxval in var_3e0c8c6bf8c2fcbb )
    {
        if ( randint < maxval )
        {
            ksref = key;
            break;
        }
    }
    
    return ksref;
}

// Namespace br_gametype_kingslayer
// Params 1
// Checksum 0x934a2204, Offset: 0x154d
// Size: 0x6b
function brking_playerwelcomesplashes( data )
{
    self endon( #"disconnect" );
    self waittill( #"spawned_player" );
    wait 1;
    hud_message::showsplash( "br_gametype_kingslayer_prematch_welcome" );
    
    if ( !self.infil_landing_done )
    {
        self waittill( #"infil_landing_done" );
    }
    
    wait 1;
    hud_message::showsplash( "br_gametype_kingslayer_welcome" );
    br_public::brleaderdialogplayer( "primary_objective", self, 0 );
}

// Namespace br_gametype_kingslayer
// Params 0
// Checksum 0xcb3258de, Offset: 0x15c0
// Size: 0x23
function brking_ontimelimit()
{
    if ( isdefined( level.numendgame ) )
    {
        level thread br::startendgame( 1 );
    }
    
    level.numendgame = undefined;
}

// Namespace br_gametype_kingslayer
// Params 0
// Checksum 0xd2203488, Offset: 0x15eb
// Size: 0xc9
function onstartgametype()
{
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
}

// Namespace br_gametype_kingslayer
// Params 1
// Checksum 0x95adc022, Offset: 0x16bc
// Size: 0x15, Type: bool
function modespawn( revivespawn )
{
    thread playerrespawn();
    return true;
}

// Namespace br_gametype_kingslayer
// Params 2
// Checksum 0x1c80613, Offset: 0x16da
// Size: 0x3a, Type: bool
function playerkilledspawn( deathdata, finaldeath )
{
    if ( !flags::gameflag( "prematch_done" ) )
    {
        return false;
    }
    
    deathdata.victim thread playerrespawn();
    return true;
}

// Namespace br_gametype_kingslayer
// Params 0
// Checksum 0x79eccaef, Offset: 0x171d
// Size: 0x5e
function function_4ce4c795036d0807()
{
    self endon( #"death_or_disconnect" );
    self endon( #"hash_b6ae78975f248906" );
    self.ks_spawnprotection = 1;
    
    while ( !self isonground() )
    {
        waitframe();
    }
    
    if ( level.var_ece3c643b8f0fb95 )
    {
        self.var_9eab553e66fe1de3 = 0;
    }
    
    self.ks_spawnprotection = 0;
    self notify( #"hash_b6ae78975f248906" );
}

// Namespace br_gametype_kingslayer
// Params 0
// Checksum 0x570a917, Offset: 0x1783
// Size: 0x5e
function function_db1dd047cacf5ea2()
{
    self endon( #"death_or_disconnect" );
    self endon( #"hash_b6ae78975f248906" );
    self.ks_spawnprotection = 1;
    self waittill( #"weapon_fired" );
    
    if ( level.var_ece3c643b8f0fb95 )
    {
        self.var_9eab553e66fe1de3 = 0;
    }
    
    self.ks_spawnprotection = 0;
    self notify( #"hash_b6ae78975f248906" );
}

// Namespace br_gametype_kingslayer
// Params 0
// Checksum 0x13dab802, Offset: 0x17e9
// Size: 0x30
function function_415b58c9877a4952()
{
    self endon( #"death_or_disconnect" );
    self.var_dfdedd7baeaedf62 = 1;
    
    while ( !self isonground() )
    {
        waitframe();
    }
    
    self.var_dfdedd7baeaedf62 = 0;
}

// Namespace br_gametype_kingslayer
// Params 12
// Checksum 0x1a0b843a, Offset: 0x1821
// Size: 0x116
function brking_modifyplayerdamage( einflictor, victim, eattacker, idamage, smeansofdeath, objweapon, vpoint, vdir, shitloc, idflags, var_cdd29ad5d1362c2, lightarmordamage )
{
    if ( level.ks_spawnprotection )
    {
        if ( victim.ks_spawnprotection == 1 )
        {
            idamage *= level.ks_spawnprotectionmodifier;
        }
        
        if ( isdefined( eattacker ) && eattacker.var_dfdedd7baeaedf62 == 1 )
        {
            switch ( smeansofdeath )
            {
                case #"hash_3c20f39c73a1422b":
                case #"hash_66cb246f3e55fbe2":
                case #"hash_a911a1880d996edb":
                case #"hash_c22b13f81bed11f0":
                    idamage *= level.var_143000384a75721d;
                    break;
            }
        }
    }
    
    idamage = br::brmodifyplayerdamage( einflictor, victim, eattacker, idamage, smeansofdeath, objweapon, vpoint, vdir, shitloc, idflags, var_cdd29ad5d1362c2 );
    return idamage;
}

// Namespace br_gametype_kingslayer
// Params 0
// Checksum 0xdaf33d87, Offset: 0x1940
// Size: 0x44f
function playerrespawn()
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    
    if ( level.gameended )
    {
        return;
    }
    
    if ( getdvarint( @"hash_fe3afd6ead4aa523", 1 ) == 1 )
    {
        self endon( #"hash_36e455a1fbf78b10" );
    }
    
    teamcount = teams::getteamdata( self.team, "teamCount" );
    
    if ( !self.squadwiped || teamcount == 1 )
    {
        var_17f3151ec6647b00 = 1;
        wait var_17f3151ec6647b00;
    }
    
    spawnwait = level.autorespawnwaittime;
    var_7ae41cb151b43258 = getdvarfloat( @"hash_de0dfc4549393ba2", 5 );
    
    if ( spawnwait < var_7ae41cb151b43258 )
    {
        spawnwait = var_7ae41cb151b43258;
    }
    
    if ( level.respawntimedisable != 0 )
    {
        spawnwait = 0;
    }
    
    var_887d7794502fe6a0 = getdvarfloat( @"hash_cc53a64fa6e4897b", 3 );
    utility::ent_flag_init( "playerRespawn_intermission_spawned" );
    self.intermissionspawnorigin = undefined;
    self.intermissionspawntime = undefined;
    
    if ( self.squadwiped || teamcount == 1 )
    {
        spawnpoint = brking_getspawnpoint();
        streamorigin = br_spawnrespawn::playerprestreamrespawnorigin( spawnpoint );
        thread fadetogearingup( 0, teamcount > 1 );
        wait var_887d7794502fe6a0;
    }
    else if ( !br_public::function_379fb7b09f4ef13e() )
    {
        lower_message::setlowermessageomnvar( "waiting_to_spawn", int( gettime() + spawnwait * 1000 ) );
        prestreamwait = spawnwait - var_7ae41cb151b43258;
        var_5061bd2ffc2167a1 = spawnwait - prestreamwait;
        blackscreenwait = spawnwait - getdvarfloat( @"hash_879a2fde5543837", 6 );
        thread fadetogearingup( blackscreenwait );
        result = utility::waittill_notify_or_timeout_return( "squad_wipe_death", prestreamwait );
        
        if ( result == "squad_wipe_death" )
        {
            spawnpoint = brking_getspawnpoint();
            streamorigin = br_spawnrespawn::playerprestreamrespawnorigin( spawnpoint );
            thread fadetogearingup( 0, 1 );
            wait var_887d7794502fe6a0;
        }
        else
        {
            thread updateprestreamrespawn();
            result = utility::waittill_notify_or_timeout_return( "squad_wipe_death", var_5061bd2ffc2167a1 );
            
            if ( result == "squad_wipe_death" )
            {
                spawnpoint = brking_getspawnpoint();
                streamorigin = br_spawnrespawn::playerprestreamrespawnorigin( spawnpoint );
                thread fadetogearingup( 0, 1 );
                wait var_887d7794502fe6a0;
            }
        }
    }
    
    self notify( #"hash_90ac94f1376250d4" );
    spawnpoint = brking_getspawnpoint();
    streamorigin = br_spawnrespawn::playerprestreamrespawnorigin( spawnpoint );
    
    if ( self.squadwiped )
    {
        self.squadwiped = 0;
        
        if ( teamcount > 1 && !br_public::function_379fb7b09f4ef13e() )
        {
            hud_message::showsplash( "bm_your_squad_wiped" );
        }
    }
    
    if ( !brking_ispointinmovingcircle( spawnpoint.origin ) )
    {
        newpos = brking_getrandompointinmovingcircle( 0, 0.7 );
        spawnpoint.origin = ( newpos[ 0 ], newpos[ 1 ], spawnpoint.origin[ 2 ] );
    }
    
    utility::ent_flag_clear( "playerRespawn_intermission_spawned" );
    self.intermissionspawnorigin = undefined;
    self.intermissionspawntime = undefined;
    lower_message::setlowermessageomnvar( "clear_lower_msg" );
    playerlogic::spawnplayer( undefined, 0 );
    execution::_clearexecution();
    br_pickups::initplayer();
    
    if ( br_public::function_379fb7b09f4ef13e() && isdefined( level.player_respawn_struct ) )
    {
        spawnpoint = utility::getstruct( level.player_respawn_struct, "targetname" );
    }
    
    br_gulag::gulagwinnerrespawn( 1, undefined, spawnpoint, 1, streamorigin, 1 );
    br_utility::unmarkplayeraseliminated( self );
    level thread battlechatter_mp::trysaylocalsound( self, #"bc_status_player_respawn" );
    omnvar_utility::setcachedclientomnvar( "ui_br_transition_type", 0 );
    
    if ( level.ks_spawnprotection )
    {
        thread function_db1dd047cacf5ea2();
        thread function_4ce4c795036d0807();
        thread function_415b58c9877a4952();
    }
    
    self setclientomnvar( "ui_flag_player_hud_icon", 0 );
    
    foreach ( player in level.lootleaders )
    {
        if ( player == self )
        {
            br::function_f2d49b5c22624ea2();
            break;
        }
    }
}

// Namespace br_gametype_kingslayer
// Params 0
// Checksum 0x18302cb2, Offset: 0x1d97
// Size: 0x506
function brking_getspawnpoint()
{
    spawnorigin = undefined;
    spawnangles = undefined;
    height = undefined;
    offsetheight = 1;
    
    if ( isdefined( self.setspawnpoint ) )
    {
        spawnorigin = self.setspawnpoint.playerspawnpos;
        spawnangles = self.setspawnpoint.playerspawnangles;
    }
    
    minradiuspct = getdvarfloat( @"hash_4777c755b1abd912", 0.8 );
    maxradiuspct = getdvarfloat( @"hash_86074cd22447d704", 0.9 );
    var_3bbe4cbaaa0f5d43 = getdvarfloat( @"hash_ebae131f0a852fdf", 100 );
    
    if ( !isdefined( spawnorigin ) && var_3bbe4cbaaa0f5d43 >= 0 )
    {
        var_837112ff5ff3188b = br_spawnrespawn::playergetbestrespawnteammate();
        
        if ( isdefined( var_837112ff5ff3188b ) )
        {
            centerofcircle = brking_getcenterofcircle();
            circleradius = br_circle::getsafecircleradius();
            toedge = vectornormalize( var_837112ff5ff3188b.origin - centerofcircle ) * circleradius * minradiuspct + centerofcircle;
            spawnorigin = br_circle::getrandompointincircle( toedge, var_3bbe4cbaaa0f5d43, minradiuspct, maxradiuspct );
            
            if ( isdefined( spawnorigin ) )
            {
                spawnorigin = br_public::droptogroundmultitrace( spawnorigin );
                spawnangles = br_spawnrespawn::function_46f3bef64ca7cfca( spawnorigin, var_837112ff5ff3188b.origin );
            }
        }
    }
    
    if ( !isdefined( spawnorigin ) )
    {
        if ( isdefined( level.br_circle ) && isdefined( level.br_circle.safecircleent ) )
        {
            origin = brking_getcenterofcircle();
            radius = br_circle::getsafecircleradius();
            droptoground = getdvarint( @"hash_951c7b13ffdd6905", 1 );
            var_f5661efe10a6d8d5 = getdvarint( @"hash_7017ad29dbedc8b1", 1 );
            spawnorigin = br_circle::getrandompointincircle( origin, radius, minradiuspct, maxradiuspct );
            spawnangles = br_spawnrespawn::function_46f3bef64ca7cfca( spawnorigin, origin );
        }
        else if ( isdefined( level.prematchspawnorigins ) )
        {
            if ( isdefined( level.teamdata[ self.team ][ "chosenSpawnWipeOrigin" ] ) && isdefined( level.teamdata[ self.team ][ "spawnWipeOriginUseStartTime" ] ) && isdefined( level.autorespawnwaittime ) && level.teamdata[ self.team ][ "spawnWipeOriginUseStartTime" ] + level.autorespawnwaittime * 1000 > gettime() )
            {
                spawnorigin = level.teamdata[ self.team ][ "chosenSpawnWipeOrigin" ];
            }
            else
            {
                potentialspawnloc = [];
                
                foreach ( struct in level.prematchspawnorigins )
                {
                    if ( distance2dsquared( struct.origin, self.origin ) > var_3bbe4cbaaa0f5d43 )
                    {
                        potentialspawnloc[ potentialspawnloc.size ] = struct;
                    }
                }
                
                if ( potentialspawnloc.size == 0 )
                {
                    potentialspawnloc = level.prematchspawnorigins;
                }
                
                potentialspawnloc = arrayrandomize( potentialspawnloc );
                spawnorigin = potentialspawnloc[ 0 ].origin;
                spawnorigin += math::random_vector_2d() * randomfloatrange( 100, 500 );
                level.teamdata[ self.team ][ "chosenSpawnWipeOrigin" ] = spawnorigin;
                level.teamdata[ self.team ][ "spawnWipeOriginUseStartTime" ] = gettime();
            }
            
            spawnangles = ( 0, 0, 0 );
            
            if ( spawnorigin[ 2 ] > 10000 )
            {
                offsetheight = 0;
                height = br_infils_util::getinfilspawnoffset();
            }
        }
        else
        {
            spawnorigin = ( 0, 0, 0 );
            spawnangles = ( 0, 0, 0 );
        }
    }
    
    if ( !isdefined( spawnangles ) )
    {
        circleorigin = br_circle::getsafecircleorigin();
        var_1bc7de998fb61520 = vectortoyaw( circleorigin - spawnorigin );
        spawnangles = ( 0, var_1bc7de998fb61520, 0 );
    }
    
    if ( offsetheight )
    {
        if ( !isdefined( height ) )
        {
            height = parachute::getc130height();
        }
        
        if ( isdefined( level.br_circle ) )
        {
            circleindex = level.br_circle.circleindex;
            closedindex = br_gulag::getgulagclosedcircleindex();
            var_dd144592495bd4e6 = isdefined( circleindex ) && circleindex >= closedindex;
            
            if ( var_dd144592495bd4e6 )
            {
                height *= getdvarfloat( @"hash_a1c2d6b19bb6a568", 0.55 );
            }
        }
        
        if ( isdefined( level.respawnheightoverride ) )
        {
            height = level.respawnheightoverride;
        }
        
        dropspawnoffset = ( 0, 0, height );
        spawnorigin = br::getoffsetspawnorigin( spawnorigin, dropspawnoffset );
    }
    
    spawnpoint = spawnstruct();
    spawnpoint.origin = spawnorigin;
    spawnpoint.angles = spawnangles;
    spawnpoint.height = height;
    return spawnpoint;
}

// Namespace br_gametype_kingslayer
// Params 2
// Checksum 0x6c0ee49f, Offset: 0x22a6
// Size: 0x131
function fadetogearingup( waittime, squadwiped )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    self endon( #"spawned_player" );
    self notify( #"hash_910faf4d1446a162" );
    self endon( #"hash_910faf4d1446a162" );
    
    if ( waittime > 0 )
    {
        wait waittime;
    }
    
    pre_spawn_delay = 1;
    thread fadeoutin();
    wait pre_spawn_delay - 0.25;
    br::function_db10c8f42ea08ad5();
    
    if ( squadwiped )
    {
        omnvar_utility::setcachedclientomnvar( "ui_br_transition_type", 6 );
    }
    else
    {
        omnvar_utility::setcachedclientomnvar( "ui_br_transition_type", 2 );
    }
    
    wait 0.25;
    
    if ( getdvarint( @"hash_f006294ef8b720a4", 1 ) == 1 )
    {
        br_public::playerclearstreamhintorigin();
        spawnpoint = brking_getspawnpoint();
        br_spectate::playerclearspectatekillchainsystem();
        br::spawnintermission( spawnpoint.origin, spawnpoint.angles );
        spectating::setdisabled();
        self.intermissionspawnorigin = spawnpoint.origin;
        self.intermissionspawntime = gettime();
        utility::ent_flag_set( "playerRespawn_intermission_spawned" );
    }
}

// Namespace br_gametype_kingslayer
// Params 0
// Checksum 0xbb3e9f05, Offset: 0x23df
// Size: 0x35
function fadeoutin()
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    br_spawnrespawn::function_1d2f70d591e967bc();
    self waittill( #"spawned_player" );
    br_spawnrespawn::function_24b79e9319c6f02f();
}

// Namespace br_gametype_kingslayer
// Params 0
// Checksum 0x4d8c2ab4, Offset: 0x241c
// Size: 0xdd
function updateprestreamrespawn()
{
    self endon( #"disconnect" );
    self endon( #"spawned_player" );
    self endon( #"hash_90ac94f1376250d4" );
    
    while ( true )
    {
        if ( utility::ent_flag( "playerRespawn_intermission_spawned" ) )
        {
            spawnpoint = brking_getspawnpoint();
            currenttime = gettime();
            assert( isdefined( self.intermissionspawntime ) );
            assert( self.intermissionspawntime <= currenttime );
            
            if ( currenttime - self.intermissionspawntime >= getdvarfloat( @"hash_57fbcc1bae0f210a", 2 ) * 1000 )
            {
                spawnpoint = brking_getspawnpoint();
                streamorigin = br_spawnrespawn::playerprestreamrespawnorigin( spawnpoint );
            }
        }
        else
        {
            spawnpoint = brking_getspawnpoint();
            streamorigin = br_spawnrespawn::playerprestreamrespawnorigin( spawnpoint );
        }
        
        wait 1;
    }
}

// Namespace br_gametype_kingslayer
// Params 0
// Checksum 0x50ca3496, Offset: 0x2501
// Size: 0x100
function brking_createc130pathstruct()
{
    assert( isdefined( level.br_level ) && isdefined( level.br_level.br_circlecenters ) && isdefined( level.br_level.br_circleradii ), "<dev string:x24>" );
    
    if ( level.ks_circlemoving )
    {
        level.br_level.br_circlecenters[ 0 ] = br_circle::getrandompointincircle( level.br_level.br_circlecenters[ 0 ], 30000 );
        brking_movenextcirclecenter( 0 );
    }
    
    originoverride = ( level.br_level.br_circlecenters[ 0 ][ 0 ], level.br_level.br_circlecenters[ 0 ][ 1 ], 0 );
    radiusoverride = level.br_level.br_circleradii[ 0 ];
    c130pathstruct = br_c130::createtestc130path( originoverride, radiusoverride );
    return c130pathstruct;
}

// Namespace br_gametype_kingslayer
// Params 0
// Checksum 0xb5ff928e, Offset: 0x260a
// Size: 0x9
function brking_addtoc130infil()
{
    thread br_public::kickplayersatcircleedge();
}

// Namespace br_gametype_kingslayer
// Params 0
// Checksum 0x5b94250, Offset: 0x261b
// Size: 0x2f
function brking_managecratedrops()
{
    level endon( #"game_ended" );
    
    if ( br_public::function_379fb7b09f4ef13e() )
    {
        return;
    }
    
    utility::flag_wait( "br_prematchEnded" );
    wait 20;
    level thread startdeliveries();
}

// Namespace br_gametype_kingslayer
// Params 0
// Checksum 0x68276ac3, Offset: 0x2652
// Size: 0xf3
function startdeliveries()
{
    level endon( #"game_ended" );
    
    /#
        if ( level.mapname == "<dev string:x8e>" )
        {
            setdvar( @"hash_d313f3ed75dbff0f", 100 );
        }
    #/
    
    hud_util::showsplashtoall( "br_juggdrop_incoming" );
    
    while ( true )
    {
        for ( i = 0; i < level.ks_airdroppercircle ; i++ )
        {
            loc = brking_getrandompointinmovingcircle( 0, 0.6 );
            dropcircle = spawnstruct();
            dropcircle.origin = loc;
            dropcircle.beacon = spawn( "script_model", dropcircle.origin );
            dropcircle.beacon setmodel( "ks_airdrop_crate_br" );
            level thread dropdeliveryatpos( dropcircle, "gametype_kingslayer" );
        }
        
        wait level.ks_circleclosetime + level.ks_circledelaytime;
    }
}

// Namespace br_gametype_kingslayer
// Params 2
// Checksum 0x566bd524, Offset: 0x274d
// Size: 0x10f
function dropdeliveryatpos( dropcircle, source )
{
    level endon( #"game_ended" );
    
    if ( !isdefined( dropcircle.dropradius ) )
    {
        dropcircle.dropradius = level.ks_circleradius;
    }
    
    droppoint = br_circle::getrandompointinboundscircle( dropcircle.origin, dropcircle.dropradius );
    pathstruct = br_c130airdrop::c130airdrop_createpath( undefined, droppoint, 1 );
    dist = distance( pathstruct.startpt, pathstruct.endpt );
    travelspeed = br_c130::getc130speed();
    time = dist / travelspeed;
    c130airdrop = br_c130airdrop::c130airdrop_spawn( pathstruct, dist, travelspeed, time );
    c130airdrop.dropfunc = &dropfunc;
    c130airdrop.source = source;
    c130airdrop br_c130airdrop::c130airdrop_startdelivery( 1, "battle_royale_c130_loot", "kingslayer_world", dropcircle );
}

// Namespace br_gametype_kingslayer
// Params 4
// Checksum 0x6d20995e, Offset: 0x2864
// Size: 0x164
function dropfunc( var_83f61b028ba05342, var_4e6ac319ac3c8a28, var_50f673dd2f486dbb, dropcircle )
{
    var_9c5ee645dd7543f6 = self.startpt;
    droppoint = self.centerpt;
    planespeed = self.speed;
    dropwaittime = distance2d( var_9c5ee645dd7543f6, droppoint ) / planespeed;
    numcrates = 0;
    var_cf0b609df784666f = 0;
    level.numactivejuggdrops += var_83f61b028ba05342;
    
    while ( numcrates < var_83f61b028ba05342 )
    {
        wait dropwaittime;
        droplocation = br_c130airdrop::c130airdrop_findvaliddroplocation( self.origin, 1 );
        crate = airdrop::dropbrc130airdropcrate( droplocation + ( 0, 0, level.c130airdrop_heightoverride - 100 ), droplocation, self.angles, var_4e6ac319ac3c8a28, var_50f673dd2f486dbb, dropcircle.nodropanim );
        numcrates++;
        crate.dropcircle = dropcircle;
        crate.source = self.source;
        level.c130successfulairdrops[ level.c130successfulairdrops.size ] = crate;
        triggerobject = airdrop::gettriggerobject( crate );
        triggerobject.usetimeoverride = getcrateusetime();
    }
}

// Namespace br_gametype_kingslayer
// Params 1
// Checksum 0xbb630c72, Offset: 0x29d0
// Size: 0xc4
function brking_oncrateuse( player )
{
    spawnoptions = namespace_9d8e359c3b1041e5::function_39104c6ed6c82786( self.origin, self.angles );
    namespace_9d8e359c3b1041e5::spawnitemfromscriptablesharedfunc( "brloot_killstreak_uav", undefined, spawnoptions );
    namespace_9d8e359c3b1041e5::spawnitemfromscriptablesharedfunc( "brloot_killstreak_clusterstrike", undefined, spawnoptions );
    namespace_9d8e359c3b1041e5::spawnitemfromscriptablesharedfunc( "brloot_killstreak_precision_airstrike", undefined, spawnoptions );
    
    if ( !isdefined( player.lootcachesopened ) )
    {
        player.lootcachesopened = 1;
    }
    else
    {
        player.lootcachesopened++;
    }
    
    if ( game_utility::getgametype() == "plunder" )
    {
        player br_public::updatebrscoreboardstat( "lootCachesOpened", player.lootcachesopened );
    }
    
    player thread points::doscoreevent( #"hash_d9180ca5c5dc7b88" );
}

// Namespace br_gametype_kingslayer
// Params 0
// Checksum 0xca864caf, Offset: 0x2a9c
// Size: 0xb
function getcrateusetime()
{
    return level.ks_airdropcrateusetime;
}

// Namespace br_gametype_kingslayer
// Params 0
// Checksum 0x3022a185, Offset: 0x2ab0
// Size: 0x1c9
function alternatebrcircle()
{
    level.br_level.br_circleclosetimes = [ level.ks_circleclosetime, level.ks_circleclosetime ];
    level.br_level.br_circledelaytimes = [ level.ks_circledelaytime + 40, level.ks_circledelaytime ];
    level.br_level.br_circleshowdelaydanger = [ 1, 0 ];
    level.br_level.br_circleshowdelaysafe = [ 0, 0 ];
    level.br_level.br_circleminimapradii = [ level.ks_circleminimapradius, level.ks_circleminimapradius ];
    level.br_level.br_circleradii = [ level.ks_circleradius, level.ks_circleradius, level.ks_circleradius ];
    
    if ( level.ks_circlemoving )
    {
        circleradius = [];
        circleclosetime = [];
        delaytime = [];
        minimapradius = [];
        
        for ( i = 0; i < level.ks_circlecount ; i++ )
        {
            circleradius[ circleradius.size ] = level.ks_circleradius;
            circleclosetime[ circleclosetime.size ] = level.ks_circleclosetime;
            delaytime[ delaytime.size ] = level.ks_circledelaytime;
            minimapradius[ minimapradius.size ] = level.ks_circleminimapradius;
        }
        
        br_circle::extendcirclelist( circleradius, circleclosetime, delaytime, minimapradius );
        return;
    }
    
    level.br_level.staticcircle = 1;
}

// Namespace br_gametype_kingslayer
// Params 0
// Checksum 0xd05a9773, Offset: 0x2c81
// Size: 0x21
function waitandstartscorepolling()
{
    level endon( #"game_ended" );
    flags::gameflagwait( "prematch_done" );
    thread brking_rankupdate();
}

// Namespace br_gametype_kingslayer
// Params 1
// Checksum 0x222398bc, Offset: 0x2caa
// Size: 0x33
function brking_onplayerconnect( player )
{
    player.personalscorecount = 0;
    player.kingslayerkills = 0;
    player.kingslayerdeaths = 0;
}

// Namespace br_gametype_kingslayer
// Params 10
// Checksum 0xee333c98, Offset: 0x2ce5
// Size: 0xb3
function brking_onplayerkilled( einflictor, attacker, idamage, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, deathanimduration, killid )
{
    br::onplayerkilled( einflictor, attacker, idamage, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, deathanimduration, killid );
    
    if ( level.var_ece3c643b8f0fb95 )
    {
        self.var_9eab553e66fe1de3 = 1;
    }
    
    br::function_ccd86d629929e144();
    
    if ( br_public::function_379fb7b09f4ef13e() )
    {
        return;
    }
    
    if ( isdefined( attacker ) && isplayer( self ) )
    {
        brking_givepoints( attacker, self );
    }
}

// Namespace br_gametype_kingslayer
// Params 2
// Checksum 0x5058bd31, Offset: 0x2da0
// Size: 0x2f4
function brking_givepoints( killer, killed )
{
    if ( !flags::gameflag( "prematch_done" ) )
    {
        return;
    }
    
    if ( killer != killed && isdefined( killer.team ) )
    {
        var_37aa1f7a6700f740 = killer.team;
        var_45e4a7ab0069b3b1 = 1;
        var_baeecef5f860efb4 = 1;
        
        if ( level.ks_pointkingsgetnobonus )
        {
            foreach ( player in level.lootleaders )
            {
                if ( player.team == var_37aa1f7a6700f740 )
                {
                    var_baeecef5f860efb4 = 0;
                    break;
                }
            }
        }
        
        if ( level.var_12340d06a63599f5 == 0 && !flags::gameflag( "placement_updates_allowed" ) )
        {
            var_baeecef5f860efb4 = 0;
        }
        
        if ( var_baeecef5f860efb4 == 1 )
        {
            foreach ( player in level.lootleaders )
            {
                bonuspoints = level.ks_pointbonusforteam ? player.team == killed.team : player == killed;
                
                if ( bonuspoints )
                {
                    var_45e4a7ab0069b3b1 = level.ks_pointsperkingslain;
                    killer.kingslayerkills++;
                    killer packextrascore0();
                    killed.kingslayerdeaths++;
                    killed packextrascore0();
                    haskillstreak = isdefined( killer.streakdata.streaks[ 1 ] );
                    rndkillstreak = function_989a118c727ff6fb( killer );
                    killer br_pickups::forcegivekillstreak( rndkillstreak, haskillstreak, 1 );
                    killer thread hud_message::showsplash( "kingslayer_" + rndkillstreak );
                    killer thread rank::scoreeventpopup( #"hvt_kill" );
                    killer thread rank::scoreeventpopup( hashcat( #"hash_2c8bcbb02ec7ff9b", var_45e4a7ab0069b3b1 ) );
                    break;
                }
            }
        }
        
        level.teamdata[ var_37aa1f7a6700f740 ][ "teamTotalScore" ] = level.teamdata[ var_37aa1f7a6700f740 ][ "teamTotalScore" ] + var_45e4a7ab0069b3b1;
        killer.personalscorecount += var_45e4a7ab0069b3b1;
        
        if ( level.var_43a48d7594b1b278 > 0 )
        {
            if ( level.teamdata[ var_37aa1f7a6700f740 ][ "teamTotalScore" ] >= level.var_43a48d7594b1b278 )
            {
                level notify( #"hash_1c706c508b3db77d" );
            }
        }
    }
}

// Namespace br_gametype_kingslayer
// Params 1
// Checksum 0xc5b3b721, Offset: 0x309c
// Size: 0x5e
function packextrascore0( data )
{
    packedvalue = self.kingslayerkills;
    
    if ( packedvalue > 255 )
    {
        packedvalue = 255;
    }
    
    deathsvalue = self.kingslayerdeaths;
    
    if ( deathsvalue > 255 )
    {
        deathsvalue = 255;
    }
    
    packedvalue += deathsvalue << 8;
    stats::setextrascore0( packedvalue );
}

// Namespace br_gametype_kingslayer
// Params 0
// Checksum 0x165eba42, Offset: 0x3102
// Size: 0xdb
function packclientmatchdata()
{
    packedvalue = self.kingslayerkills;
    
    if ( packedvalue > 255 )
    {
        packedvalue = 255;
    }
    
    deathsvalue = self.kingslayerdeaths;
    
    if ( deathsvalue > 255 )
    {
        deathsvalue = 255;
    }
    
    packedvalue += deathsvalue << 8;
    placements = gamescore::getteamscoreplacements();
    placement = placements[ self.team ];
    
    if ( isdefined( placement ) )
    {
        setclientmatchdata( "players", self.clientmatchdataid, "placement", placement );
    }
    
    setclientmatchdata( "players", self.clientmatchdataid, "extrascore4", packedvalue );
    lootcachesopened = self.lootcachesopened ?? 0;
    setclientmatchdata( "players", self.clientmatchdataid, "extrascore5", lootcachesopened );
}

// Namespace br_gametype_kingslayer
// Params 0
// Checksum 0x28aeb236, Offset: 0x31e5
// Size: 0x52a
function eomawardplayerxp()
{
    level waittill( #"give_match_bonus" );
    waitframe();
    var_1c54589b7332d705 = getdvarfloat( @"hash_624dff063fdc19e4", 1 );
    var_9148a6210e2ab1f5 = getdvarfloat( @"hash_5776e92fc7e990f4", 1 );
    var_dc69e59dbefd12a4 = getdvarint( @"hash_a0c1b8638163484e", 10000 );
    var_99c563bc16322d5 = getdvarint( @"hash_7845f9181d5707ba", 7500 );
    var_bc8c0cd3f01662ef = getdvarint( @"hash_163aca343e614b6e", 5000 );
    
    foreach ( team in level.teamnamelist )
    {
        teamplunder = 0;
        var_6852db71ff10f7af = 0;
        placement = game[ "teamPlacements" ][ team ];
        placementscore = 0;
        
        if ( var_6852db71ff10f7af )
        {
            placementscore = var_99c563bc16322d5;
        }
        else if ( placement <= 10 )
        {
            placementscore = var_bc8c0cd3f01662ef;
        }
        else
        {
            placementscore = 2500;
        }
        
        players = teams::getteamdata( team, "players" );
        
        foreach ( player in players )
        {
            if ( !player game_utility_mp::rankingenabled() || !player hasplayerdata() )
            {
                continue;
            }
            
            if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( player ) ) )
            {
                if ( isdefined( player.leaderboarddata[ "cash" ] ) )
                {
                    player.leaderboarddata[ "cash" ] = player.leaderboarddata[ "cash" ] + int( teamplunder / 10000 );
                }
                
                if ( isdefined( level.leaderboardfunc[ "cash" ] ) )
                {
                    [[ level.leaderboardfunc[ "cash" ] ]]( player, int( teamplunder / 10000 ) );
                }
                
                assert( isint( int( teamplunder / 10000 ) ) || isfloat( int( teamplunder / 10000 ) ), "<dev string:x9e>" );
                
                if ( isdefined( player.pers[ "cash" ] ) )
                {
                    player.pers[ "cash" ] = player.pers[ "cash" ] + int( teamplunder / 10000 );
                }
            }
            
            combatxp = player.pers[ "combatXP" ];
            
            if ( !isdefined( combatxp ) )
            {
                combatxp = 0;
            }
            
            player setplayerdata( level.var_6f9b00680ed002d8, "aarValue", 0, combatxp );
            missionxp = player.pers[ "missionXP" ];
            
            if ( !isdefined( missionxp ) )
            {
                missionxp = 0;
            }
            
            player setplayerdata( level.var_6f9b00680ed002d8, "aarValue", 1, missionxp );
            lootingxp = player.pers[ "lootingXP" ];
            
            if ( !isdefined( lootingxp ) )
            {
                lootingxp = 0;
            }
            
            player setplayerdata( level.var_6f9b00680ed002d8, "aarValue", 2, lootingxp );
            heldscore = 0;
            
            if ( isdefined( player.plundercount ) )
            {
                heldscore = int( player.plundercount * var_1c54589b7332d705 );
            }
            
            bankedscore = 0;
            
            if ( isdefined( player.plunderbanked ) )
            {
                bankedscore = int( player.plunderbanked * var_9148a6210e2ab1f5 );
            }
            
            score = heldscore + bankedscore;
            
            if ( score > 0 )
            {
                player rank::giverankxp( #"hash_31a9f06f2a47aeff", score, undefined, 1, 1 );
            }
            
            player setplayerdata( level.var_6f9b00680ed002d8, "aarValue", 3, 0 );
            matchbonus = 0;
            
            if ( isdefined( player.matchbonus ) )
            {
                matchbonus = int( player.matchbonus );
            }
            
            player setplayerdata( level.var_6f9b00680ed002d8, "aarValue", 4, matchbonus );
            
            if ( placementscore > 0 )
            {
                player rank::giverankxp( #"placement_bonus", placementscore, undefined, 1, 1 );
            }
            
            player setplayerdata( level.var_6f9b00680ed002d8, "aarValue", 5, placementscore );
            initialxp = player getplayerdata( level.var_6f9b00680ed002d8, "aarValue", 6 );
            finalxp = initialxp + player.pers[ "summary" ][ "xp" ];
            player setplayerdata( level.var_6f9b00680ed002d8, "aarValue", 7, finalxp );
        }
    }
}

// Namespace br_gametype_kingslayer
// Params 3
// Checksum 0xa08b9f72, Offset: 0x3717
// Size: 0x78
function brking_updateteamscore( kingslayerteamscore, team, var_b24ab0ef98745bd8 )
{
    oldscore = int( game[ "teamScores" ][ team ] );
    delta = kingslayerteamscore - oldscore;
    
    if ( delta != 0 )
    {
        skipvo = br_public::function_379fb7b09f4ef13e() ? 1 : undefined;
        level thread gamescore::giveteamscoreforobjective( team, delta, 0, undefined, skipvo, var_b24ab0ef98745bd8 );
    }
    
    return delta;
}

// Namespace br_gametype_kingslayer
// Params 1
// Checksum 0xddae88da, Offset: 0x3798
// Size: 0x1e
function function_88e982ca85379c68( neworigin )
{
    objidpoolmanager::update_objective_position( self.objectiveiconid, neworigin );
}

// Namespace br_gametype_kingslayer
// Params 0
// Checksum 0x2200a33b, Offset: 0x37be
// Size: 0x858
function brking_rankupdate()
{
    level endon( #"game_ended" );
    var_27aac539cdead110 = 0;
    var_f45c2be7325ffe84 = [];
    var_37a08098fe75abf5 = level.hideleaderhashuntilpercent != 0;
    var_dcebe3fe0a1d7d3b = 0;
    
    while ( true )
    {
        waittillframeend();
        var_f22c8f0f0772c6f8 = level.called50percentprogress && level.called75percentprogress && level.called90percentprogress;
        wincost = level.ks_pointstowin;
        var_27aac539cdead110 += level.framedurationseconds;
        
        if ( level.usemilestonephases )
        {
            var_5c58b0b02fe77ca5 = flags::gameflag( "placement_updates_allowed" );
        }
        else
        {
            var_5c58b0b02fe77ca5 = var_27aac539cdead110 > level.secondsbeforeplacementupdates;
        }
        
        splashesallowed = level.showplacementsplashesandmusic && var_5c58b0b02fe77ca5;
        placements = gamescore::getteamscoreplacements();
        var_1ddc65377fbc06a1 = level.teamplunderscoremechanic;
        team90 = undefined;
        team75 = undefined;
        team50 = undefined;
        var_6989b73224d99e93 = [];
        playerscores = [];
        playerlookup = [];
        winningteam = "none";
        secondplaceteam = "none";
        highscore = -1;
        secondplacescore = 0;
        
        foreach ( team in level.teamnamelist )
        {
            kingslayerteamscore = level.teamdata[ team ][ "teamTotalScore" ];
            delta = brking_updateteamscore( kingslayerteamscore, team, level.brgametype.firstteam );
            previousplacement = getpreviousplacement( team );
            placement = placements[ team ];
            
            if ( kingslayerteamscore > highscore )
            {
                if ( highscore > secondplacescore )
                {
                    secondplacescore = highscore;
                    secondplaceteam = winningteam;
                }
                
                highscore = kingslayerteamscore;
                winningteam = team;
            }
            else if ( winningteam != "none" )
            {
                if ( kingslayerteamscore > secondplacescore )
                {
                    secondplacescore = kingslayerteamscore;
                    secondplaceteam = team;
                }
            }
            
            pockets = kingslayerteamscore;
            total = kingslayerteamscore;
            banked = 0;
            
            if ( total >= wincost * 0.9 )
            {
                team90 = team;
            }
            else if ( total >= wincost * 0.75 )
            {
                team75 = team;
            }
            else if ( total >= wincost * 0.5 )
            {
                team50 = team;
            }
            
            level thread music_br::function_62cd7abed575c794( total, wincost );
            players = teams::getfriendlyplayers( team, 0 );
            updateplacements( placements, players );
            
            foreach ( player in players )
            {
                playerscores[ player.guid ] = player.personalscorecount;
                playerlookup[ player.guid ] = player;
            }
            
            if ( splashesallowed )
            {
                if ( placement == 1 )
                {
                    var_6989b73224d99e93[ var_6989b73224d99e93.size ] = team;
                }
                else if ( placement <= 5 )
                {
                    if ( previousplacement > 5 )
                    {
                        hud_util::showsplashtoteam( team, "bm_top_5" );
                    }
                }
                else if ( placement <= 10 )
                {
                    if ( previousplacement > 10 )
                    {
                        hud_util::showsplashtoteam( team, "bm_top_10" );
                    }
                }
            }
            
            if ( total >= wincost )
            {
                level thread givewincondition( team );
            }
        }
        
        foreach ( player in level.players )
        {
            teamscore = level.teamdata[ player.team ][ "teamTotalScore" ];
            player setclientomnvar( "ui_br_team_cash_banked", int( teamscore ) );
            player setclientomnvar( "ui_br_team_cash_pockets", int( teamscore >= highscore ? secondplacescore : highscore ) );
        }
        
        teamsorted = [];
        playersorted = [];
        
        if ( level.lootleadermarksontopteams == 1 )
        {
            teamsorted = tablesort( game[ "teamPlacements" ] );
        }
        else
        {
            if ( level.lootleadermarksontopteams == 2 )
            {
                teamsorted[ 0 ] = winningteam;
            }
            
            playersorted = tablesort( playerscores, 1 );
        }
        
        level.brgametype.firstteam = winningteam;
        
        if ( winningteam == "none" )
        {
            var_f45c2be7325ffe84 = [];
            waitframe();
            continue;
        }
        
        if ( !var_37a08098fe75abf5 && highscore >= wincost * level.hideleaderhashuntilpercent * 0.1 )
        {
            setomnvar( "ui_br_leader_hash_percentage_hit", 1 );
            var_37a08098fe75abf5 = 1;
        }
        
        if ( !splashesallowed || highscore == 0 )
        {
            waitframe();
            continue;
        }
        
        if ( level.lootleadermarksontopteams > 0 )
        {
            if ( level.dmzlootleaderupdateonpickup || level.plunderupdatelootleadermarks )
            {
                updatelootleadermarks( playerscores, playersorted, playerlookup, teamsorted );
                level.plunderupdatelootleadermarks = 0;
            }
        }
        else if ( level.dmzlootleaderupdateonpickup || level.plunderupdatelootleadermarks )
        {
            updatelootleadermarks( playerscores, playersorted, playerlookup );
            level.plunderupdatelootleadermarks = 0;
        }
        
        foreach ( team in var_6989b73224d99e93 )
        {
            if ( !arraycontains( var_f45c2be7325ffe84, team ) )
            {
                if ( level.topteamsever[ team ] )
                {
                    if ( !br_public::function_379fb7b09f4ef13e() )
                    {
                        hud_util::showsplashtoteam( team, "bm_top_team_regained" );
                    }
                    
                    continue;
                }
                
                if ( !br_public::function_379fb7b09f4ef13e() )
                {
                    hud_util::showsplashtoteam( team, "bm_top_team" );
                }
                
                level.topteamsever[ team ] = 1;
            }
        }
        
        if ( var_6989b73224d99e93.size > 0 )
        {
            foreach ( team in var_f45c2be7325ffe84 )
            {
                if ( !arraycontains( var_6989b73224d99e93, team ) )
                {
                    hud_util::showsplashtoteam( team, "bm_top_team_lost" );
                }
            }
        }
        
        var_f45c2be7325ffe84 = var_6989b73224d99e93;
        level.topteam = winningteam;
        level.previousplacements = placements;
        
        if ( !var_f22c8f0f0772c6f8 )
        {
            if ( !level.called90percentprogress && isdefined( team90 ) )
            {
                level.called90percentprogress = 1;
                
                if ( !br_public::function_379fb7b09f4ef13e() )
                {
                    if ( !level.disablepercentageannouncements )
                    {
                        hud_util::showsplashtoallexceptteam( team90, "bm_first_to_90_them" );
                        hud_util::showsplashtoteam( team90, "bm_first_to_90_us" );
                        level thread br_public::brleaderdialog( "final_circle", 0, undefined, undefined, 2 );
                    }
                }
            }
            else if ( !level.called75percentprogress && isdefined( team75 ) )
            {
                level.called75percentprogress = 1;
                
                if ( !br_public::function_379fb7b09f4ef13e() )
                {
                    if ( !level.disablepercentageannouncements )
                    {
                        hud_util::showsplashtoallexceptteam( team75, "bm_first_to_75_them" );
                        hud_util::showsplashtoteam( team75, "bm_first_to_75_us" );
                    }
                }
            }
            else if ( !level.called50percentprogress && isdefined( team50 ) )
            {
                level.called50percentprogress = 1;
                
                if ( !br_public::function_379fb7b09f4ef13e() )
                {
                    if ( !level.disablepercentageannouncements )
                    {
                        hud_util::showsplashtoallexceptteam( team50, "bm_first_to_50_them" );
                        hud_util::showsplashtoteam( team50, "bm_first_to_50_us" );
                    }
                }
            }
        }
        
        waitframe();
    }
}

// Namespace br_gametype_kingslayer
// Params 2
// Checksum 0xb300f6cc, Offset: 0x401e
// Size: 0xbf
function updateplacements( placements, players )
{
    foreach ( player in players )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        placement = placements[ player.team ];
        player omnvar_utility::setcachedclientomnvar( "ui_br_team_placement", placement );
        player omnvar_utility::setcachedclientomnvar( "ui_br_player_position", placement );
    }
}

// Namespace br_gametype_kingslayer
// Params 1
// Checksum 0xd48ec190, Offset: 0x40e5
// Size: 0x28
function getpreviousplacement( team )
{
    if ( isdefined( level.previousplacements ) )
    {
        return level.previousplacements[ team ];
    }
    
    return -1;
}

// Namespace br_gametype_kingslayer
// Params 2
// Checksum 0xac1b3687, Offset: 0x4116
// Size: 0x4d
function hackclientomnvarclamp( omnvar, val )
{
    valclamp = int( min( val, 131072 ) );
    assert( val == valclamp, "<dev string:xc4>" + val );
    self setclientomnvar( omnvar, valclamp );
}

// Namespace br_gametype_kingslayer
// Params 2
// Checksum 0x137239cd, Offset: 0x416b
// Size: 0x4c
function hackomnvarclamp( omnvar, val )
{
    valclamp = int( min( val, 131072 ) );
    assert( val == valclamp, "<dev string:xc4>" + val );
    setomnvar( omnvar, valclamp );
}

// Namespace br_gametype_kingslayer
// Params 4
// Checksum 0xc469324b, Offset: 0x41bf
// Size: 0x583
function updatelootleadermarks( playerscores, playersorted, playerlookup, teamsorted )
{
    level.lootleadersprev = level.lootleaders;
    level.lootleaders = [];
    
    if ( level.lootleadermarksontopteams == 1 )
    {
        for ( i = 0; i < level.lootleadermarkcount ; i++ )
        {
            lootleaderplayer = getlootteamleader( i, playerscores, teamsorted );
            
            if ( isdefined( lootleaderplayer ) )
            {
                level.lootleaders[ level.lootleaders.size ] = playerlookup[ lootleaderplayer ];
            }
        }
    }
    else if ( level.lootleadermarksontopteams == 2 )
    {
        lootleaderplayer = getlootteamleader( 0, playerscores, teamsorted );
        
        if ( isdefined( lootleaderplayer ) )
        {
            level.lootleaders[ 0 ] = playerlookup[ lootleaderplayer ];
        }
        
        foreach ( playerkey in playersorted )
        {
            player = playerlookup[ playerkey ];
            tokens = playerscores[ playerkey ];
            
            if ( tokens == 0 )
            {
                break;
            }
            
            if ( tokens == level.risktokenstokeep )
            {
                continue;
            }
            
            if ( arraycontains( level.lootleaders, player ) )
            {
                continue;
            }
            
            level.lootleaders[ level.lootleaders.size ] = player;
            
            if ( level.lootleaders.size == level.lootleadermarkcount )
            {
                break;
            }
        }
    }
    else
    {
        foreach ( player in playersorted )
        {
            tokens = playerscores[ player ];
            
            if ( tokens == 0 )
            {
                break;
            }
            
            level.lootleaders[ level.lootleaders.size ] = playerlookup[ player ];
            
            if ( level.lootleaders.size == level.lootleadermarkcount )
            {
                break;
            }
        }
    }
    
    foreach ( player in level.lootleadersprev )
    {
        if ( isdefined( player ) && !arraycontains( level.lootleaders, player ) )
        {
            removeplayeraslootleader( player );
        }
    }
    
    level notify( #"hash_8ea89e3f5091ca52" );
    
    if ( level.lootleadermarks.size < level.lootleadermarkcount )
    {
        for ( i = 0; i < level.lootleadermarkcount ; i++ )
        {
            instance = spawnstruct();
            instance.hidden = 0;
            instance br_contract_manager::createquestobjicon( "ui_mp_br_mapmenu_icon_assassin_objective_enemy", "active" );
            level.lootleadermarks[ i ] = instance;
        }
    }
    
    for ( i = 0; i < level.lootleadermarkcount ; i++ )
    {
        instance = level.lootleadermarks[ i ];
        
        if ( isdefined( level.lootleaders[ i ] ) )
        {
            instance.targetplayer = level.lootleaders[ i ];
            instance.targetplayer.lootleaderinstance = instance;
            location = instance.targetplayer.origin;
            newmark = arraycontains( level.lootleaders, instance.targetplayer ) && !arraycontains( level.lootleadersprev, instance.targetplayer );
            
            if ( instance.hidden == 0 )
            {
                showtoplayers = teams::getenemyplayers( instance.targetplayer.team, 0 );
                
                foreach ( player in showtoplayers )
                {
                    instance function_27729d45b3506b6e( player );
                }
                
                hidefromplayers = teams::getfriendlyplayers( instance.targetplayer.team, 0 );
                
                foreach ( player in hidefromplayers )
                {
                    instance function_4db5cae43aefa7ea( player );
                }
            }
            
            if ( newmark )
            {
                addplayeraslootleader( instance );
            }
            
            continue;
        }
        
        instance.targetplayer = undefined;
        objective_removeallfrommask( instance.objectiveiconid );
    }
}

// Namespace br_gametype_kingslayer
// Params 0
// Checksum 0xe9f84ff9, Offset: 0x474a
// Size: 0x225
function function_610471b316c32aa5()
{
    level endon( #"game_ended" );
    level waittill( #"hash_8ea89e3f5091ca52" );
    
    while ( true )
    {
        for ( i = 0; i < level.lootleadermarkcount ; i++ )
        {
            instance = level.lootleadermarks[ i ];
            
            if ( isdefined( instance.targetplayer ) )
            {
                if ( !player::isreallyalive( instance.targetplayer ) && instance.hidden == 0 )
                {
                    instance.hidden = 1;
                    objective_removeallfrommask( instance.objectiveiconid );
                    level notify( #"Objective_Delete", instance.objectiveiconid );
                }
                else if ( player::isreallyalive( instance.targetplayer ) && instance.hidden == 1 )
                {
                    if ( !level.var_ece3c643b8f0fb95 || instance.targetplayer.var_9eab553e66fe1de3 == 0 )
                    {
                        instance.hidden = 0;
                        showtoplayers = teams::getenemyplayers( instance.targetplayer.team, 0 );
                        
                        foreach ( player in showtoplayers )
                        {
                            instance function_27729d45b3506b6e( player );
                        }
                    }
                }
                
                instance function_88e982ca85379c68( instance.targetplayer.origin );
                continue;
            }
            
            if ( instance.hidden == 0 )
            {
                instance.hidden = 1;
                objective_removeallfrommask( instance.objectiveiconid );
            }
        }
        
        if ( level.var_57a481d5824a220b > 0 )
        {
            wait level.var_57a481d5824a220b;
            continue;
        }
        
        waitframe();
    }
}

// Namespace br_gametype_kingslayer
// Params 1
// Checksum 0xc01c209b, Offset: 0x4977
// Size: 0x15
function function_27729d45b3506b6e( player )
{
    br_contract_manager::showquestobjicontoplayer( player );
}

// Namespace br_gametype_kingslayer
// Params 1
// Checksum 0x881acfe0, Offset: 0x4994
// Size: 0x15
function function_4db5cae43aefa7ea( player )
{
    br_contract_manager::hidequestobjiconfromplayer( player );
}

// Namespace br_gametype_kingslayer
// Params 3
// Checksum 0x722b902f, Offset: 0x49b1
// Size: 0x125
function getlootteamleader( index, playerscores, teamsorted )
{
    team = teamsorted[ index ];
    newplunder = 0;
    plunder = 0;
    
    if ( level.teamdata[ team ][ "players" ].size == 0 )
    {
        return;
    }
    
    lootleaderplayer = level.teamdata[ team ][ "players" ][ 0 ].guid;
    
    foreach ( player in level.teamdata[ team ][ "players" ] )
    {
        newplunder = playerscores[ player.guid ];
        
        if ( newplunder > plunder )
        {
            plunder = newplunder;
            lootleaderplayer = player.guid;
        }
    }
    
    return lootleaderplayer;
}

// Namespace br_gametype_kingslayer
// Params 1
// Checksum 0xf034c18f, Offset: 0x4adf
// Size: 0x4f
function addplayeraslootleader( instance )
{
    player = instance.targetplayer;
    
    if ( player::isreallyalive( player ) )
    {
        player br::function_f2d49b5c22624ea2();
        
        if ( !br_public::function_379fb7b09f4ef13e() )
        {
            player hud_message::showsplash( "bm_player_marked" );
        }
    }
}

// Namespace br_gametype_kingslayer
// Params 0
// Checksum 0xb7be3ccd, Offset: 0x4b36
// Size: 0xce
function updatelootleadersonfixedinterval()
{
    level notify( #"hash_6aefe4a48ef99ab8" );
    level endon( #"hash_6aefe4a48ef99ab8" );
    level endon( #"game_ended" );
    interval = getdvarfloat( @"scr_plunder_loot_leader_update_interval", 15 );
    blinkinterval = getdvarfloat( @"hash_b82244f91b963437", 5 );
    initialvalue = getdvarint( @"hash_114aa0db563f4c19", 800 );
    finalvalue = getdvarint( @"hash_4f47f4bd5cfef308", 200 );
    solidinterval = interval - blinkinterval;
    flags::gameflagwait( "placement_updates_allowed" );
    
    while ( true )
    {
        level.plunderupdatelootleadermarks = 1;
        utility::waittill_notify_or_timeout( "bmo_overtime_start", solidinterval );
    }
}

// Namespace br_gametype_kingslayer
// Params 0
// Checksum 0x50fcfb8b, Offset: 0x4c0c
// Size: 0x4c
function placementupdatewait()
{
    flags::gameflagwait( "prematch_done" );
    
    if ( isdefined( level.secondsbeforeplacementupdates ) )
    {
        wait level.secondsbeforeplacementupdates;
    }
    
    if ( level.var_43a48d7594b1b278 > 0 )
    {
        level waittill( #"hash_1c706c508b3db77d" );
    }
    
    flags::gameflagset( "placement_updates_allowed" );
}

// Namespace br_gametype_kingslayer
// Params 1
// Checksum 0xdac4b055, Offset: 0x4c60
// Size: 0xe0
function removeplayeraslootleader( player )
{
    player br::function_ccd86d629929e144();
    
    if ( isdefined( player.lootleaderinstance ) )
    {
        foreach ( entry in level.players )
        {
            player.lootleaderinstance function_4db5cae43aefa7ea( entry );
        }
        
        player.lootleaderinstance.targetplayer = undefined;
        player.lootleaderinstance = undefined;
    }
    
    level.lootleaders = arrayremove( level.lootleaders, player );
}

// Namespace br_gametype_kingslayer
// Params 1
// Checksum 0x5643ddb6, Offset: 0x4d48
// Size: 0x80
function givewincondition( winteam )
{
    waitframe();
    updateplacements( gamescore::getteamscoreplacements(), level.players );
    
    if ( level.triggeredwincondition )
    {
        return;
    }
    
    level.triggeredwincondition = 1;
    level thread gamelogic_mp::endgame( winteam, game[ "end_reason" ][ "objective_completed" ] );
    winnerplayers = [];
    
    if ( isdefined( winteam ) && winteam != "tie" )
    {
        winnerplayers = teams::getteamdata( winteam, "players" );
    }
}

// Namespace br_gametype_kingslayer
// Params 1
// Checksum 0xc9c61c06, Offset: 0x4dd0
// Size: 0xc
function ononeleftevent( team )
{
    
}

// Namespace br_gametype_kingslayer
// Params 0
// Checksum 0x3d296aa, Offset: 0x4de4
// Size: 0xfa, Type: bool
function playerspawnendofgame()
{
    if ( !self.controlsfrozen )
    {
        player::_freezecontrols( 1, undefined, "spawnEndOfGame" );
    }
    
    spawnpoint = spawnstruct();
    player = self getspectatingplayer();
    
    if ( !isdefined( player ) )
    {
        player = self;
    }
    
    spawnpoint.origin = player.origin;
    spawnpoint.angles = player.angles;
    
    if ( !player isonground() )
    {
        tracecontents = trace::create_default_contents( 1 );
        spawnpoint.origin = br_public::droptogroundmultitrace( spawnpoint.origin, 0, -20000, tracecontents );
    }
    
    spawnpoint.origin += ( 0, 0, 100 );
    
    if ( !isdefined( level.endmatchcamerastriggered ) )
    {
        level.endmatchcamerastriggered = 1;
        level thread triggerbloodmoneyendcameras();
    }
    
    return true;
}

// Namespace br_gametype_kingslayer
// Params 0
// Checksum 0x8a111f5, Offset: 0x4ee7
// Size: 0x57c
function initendcameralocations()
{
    var_557fdd6aa92d5469 = [];
    level.endcameraorigins = [];
    level.endcameraangles = [];
    
    if ( level.mapname == "mp_br_mechanics" )
    {
        level.endcameraorigins[ 0 ] = ( 8682, -1036, 427 );
        level.endcameraangles[ 0 ] = ( 14, 163, 0 );
        level.endcameraorigins[ 1 ] = ( -1139, -3425, 1116 );
        level.endcameraangles[ 1 ] = ( 33, 75, 0 );
        level.endcameraorigins[ 2 ] = ( -5567, -4786, 1116 );
        level.endcameraangles[ 2 ] = ( 37, 192, 0 );
        return;
    }
    
    level.endcameraorigins[ 0 ] = ( -36548, -31983, 2400 );
    level.endcameraangles[ 0 ] = ( 12, 72, 0 );
    level.endcameraorigins[ 1 ] = ( -17592, -36440, 1379 );
    level.endcameraangles[ 1 ] = ( 17, 90, 0 );
    level.endcameraorigins[ 2 ] = ( -3520, -34298, 1217 );
    level.endcameraangles[ 2 ] = ( 11, 110, 0 );
    level.endcameraorigins[ 3 ] = ( -9577, -25957, 360 );
    level.endcameraangles[ 3 ] = ( 357, 82, 0 );
    level.endcameraorigins[ 4 ] = ( 23022, -26926, 1359 );
    level.endcameraangles[ 4 ] = ( 16, 101, 0 );
    level.endcameraorigins[ 5 ] = ( 31261, -29753, 1359 );
    level.endcameraangles[ 5 ] = ( 27, 52, 0 );
    level.endcameraorigins[ 6 ] = ( 44843, -41261, 3220 );
    level.endcameraangles[ 6 ] = ( 16, 52, 0 );
    level.endcameraorigins[ 7 ] = ( 44229, -15403, 1331 );
    level.endcameraangles[ 7 ] = ( 13, 72, 0 );
    level.endcameraorigins[ 8 ] = ( 44491, 3484, 1638 );
    level.endcameraangles[ 8 ] = ( 23, 11, 0 );
    level.endcameraorigins[ 9 ] = ( 16047, -3206, 2613 );
    level.endcameraangles[ 9 ] = ( 27, 309, 0 );
    level.endcameraorigins[ 10 ] = ( 5668, -5905, 1614 );
    level.endcameraangles[ 10 ] = ( 23, 304, 0 );
    level.endcameraorigins[ 11 ] = ( -13412, -20443, 1033 );
    level.endcameraangles[ 11 ] = ( 11, 109, 0 );
    level.endcameraorigins[ 12 ] = ( -30369, -7811, 1680 );
    level.endcameraangles[ 12 ] = ( 31, 339, 0 );
    level.endcameraorigins[ 13 ] = ( -26278, 4081, 142 );
    level.endcameraangles[ 13 ] = ( 6, 110, 0 );
    level.endcameraorigins[ 14 ] = ( -16429, 6021, 847 );
    level.endcameraangles[ 14 ] = ( 21, 57, 0 );
    level.endcameraorigins[ 15 ] = ( -7525, 11672, 1082 );
    level.endcameraangles[ 15 ] = ( 14, 46, 0 );
    level.endcameraorigins[ 16 ] = ( 8356, 15296, 2021 );
    level.endcameraangles[ 16 ] = ( 12, 38, 0 );
    level.endcameraorigins[ 17 ] = ( 26010, 29975, 2716 );
    level.endcameraangles[ 17 ] = ( 13, 68, 0 );
    level.endcameraorigins[ 18 ] = ( 12043, 30910, 3081 );
    level.endcameraangles[ 18 ] = ( 21, 88, 0 );
    level.endcameraorigins[ 19 ] = ( 7127, 52592, 2100 );
    level.endcameraangles[ 19 ] = ( 28, 241, 0 );
    level.endcameraorigins[ 20 ] = ( -6693, 56481, 4026 );
    level.endcameraangles[ 20 ] = ( 16, 246, 0 );
    level.endcameraorigins[ 21 ] = ( -21394, 37175, 757 );
    level.endcameraangles[ 21 ] = ( 2, 124, 0 );
    level.endcameraorigins[ 22 ] = ( -26151, 25577, 271 );
    level.endcameraangles[ 22 ] = ( 357, 10, 0 );
}

// Namespace br_gametype_kingslayer
// Params 0
// Checksum 0x9b446161, Offset: 0x546b
// Size: 0x9e
function triggerbloodmoneyendcameras()
{
    playerscalculated = 0;
    
    foreach ( player in level.players )
    {
        player thread playmatchendcamera( player, getbestcameraindex( player ) );
        playerscalculated++;
        
        if ( playerscalculated == 5 )
        {
            waitframe();
            playerscalculated = 0;
        }
    }
}

// Namespace br_gametype_kingslayer
// Params 1
// Checksum 0x32f073df, Offset: 0x5511
// Size: 0xd4
function getbestcameraindex( player )
{
    var_871bd590a6a75d91 = undefined;
    shortestdist = undefined;
    
    foreach ( index, origin in level.endcameraorigins )
    {
        dist = distance2dsquared( player.origin, origin );
        
        if ( dist <= 9000000 )
        {
            return index;
        }
        
        if ( !isdefined( shortestdist ) || shortestdist > dist )
        {
            shortestdist = dist;
            var_871bd590a6a75d91 = index;
        }
    }
    
    return var_871bd590a6a75d91;
}

// Namespace br_gametype_kingslayer
// Params 2
// Checksum 0xfc330ddf, Offset: 0x55ee
// Size: 0xb6
function playmatchendcamera( player, cameraindex )
{
    originstart = level.endcameraorigins[ cameraindex ];
    anglesstart = level.endcameraangles[ cameraindex ];
    originend = originstart + anglestoright( anglesstart ) * 1000;
    anglesend = anglesstart;
    cament = spawn( "script_model", originstart );
    cament setmodel( "tag_origin" );
    cament.angles = anglesstart;
    player cameralinkto( cament, "tag_origin" );
    cament moveto( originend, 60 );
    cament rotateto( anglesend, 60 );
}

// Namespace br_gametype_kingslayer
// Params 0
// Checksum 0xf3e325ab, Offset: 0x56ac
// Size: 0x32
function brking_managecircles()
{
    level endon( #"game_ended" );
    level thread brking_watchcircletimers();
    
    while ( true )
    {
        level waittill( #"br_circle_set" );
        brking_movenextcirclecenter();
    }
}

// Namespace br_gametype_kingslayer
// Params 1
// Checksum 0x326e0f7e, Offset: 0x56e6
// Size: 0x16d
function brking_movenextcirclecenter( index = level.br_circle.circleindex + 1 )
{
    if ( level.br_level.br_circlecenters.size <= index || !level.ks_circlemoving )
    {
        return;
    }
    
    var_7cf992adb04ee8a9 = level.br_level.br_circlecenters[ index ];
    nextcircledistance = level.ks_circlemovedist;
    newcenter = var_7cf992adb04ee8a9;
    randompoint = br_circle::getrandompointincircle( var_7cf992adb04ee8a9, nextcircledistance, 0.8, 1 );
    circledirection = randompoint - var_7cf992adb04ee8a9;
    
    if ( level.lootleaders.size > 0 )
    {
        circledirection = level.var_3636bdf6f31bf1b2 ? var_7cf992adb04ee8a9 - level.lootleaders[ 0 ].origin : level.lootleaders[ 0 ].origin - var_7cf992adb04ee8a9;
    }
    
    circledirection = vectornormalize( circledirection ) * nextcircledistance;
    newcenter += circledirection;
    
    if ( !function_28fb5745e6ac1991( newcenter + circledirection ) )
    {
        circledirection = vectornormalize( level.br_level.br_mapcenter - var_7cf992adb04ee8a9 ) * nextcircledistance;
        newcenter = var_7cf992adb04ee8a9 + circledirection;
    }
    
    level.br_level.br_circlecenters[ index + 1 ] = newcenter;
}

// Namespace br_gametype_kingslayer
// Params 1
// Checksum 0x389d3c5b, Offset: 0x585b
// Size: 0x8c
function function_28fb5745e6ac1991( pt )
{
    bounds = level.br_level.br_mapbounds;
    pad = level.var_c530f740e5b95fd8;
    inmapbounds = pt[ 0 ] < bounds[ 0 ][ 0 ] * pad && pt[ 0 ] > bounds[ 1 ][ 0 ] * pad && pt[ 1 ] < bounds[ 0 ][ 1 ] * pad && pt[ 1 ] > bounds[ 1 ][ 1 ] * pad;
    return inmapbounds;
}

// Namespace br_gametype_kingslayer
// Params 0
// Checksum 0xce080660, Offset: 0x58f0
// Size: 0x3d
function brking_watchcircletimers()
{
    level endon( #"game_ended" );
    level.circleclosestarttime = gettime();
    
    while ( true )
    {
        level waittill( #"br_circle_started" );
        level.circleclosestarttime = gettime();
    }
}

// Namespace br_gametype_kingslayer
// Params 0
// Checksum 0xfab5b340, Offset: 0x5935
// Size: 0x1e
function brking_getcirclepercentmoved()
{
    return ( gettime() - level.circleclosestarttime ) / 1000 / level.ks_circleclosetime;
}

// Namespace br_gametype_kingslayer
// Params 0
// Checksum 0x5e85785a, Offset: 0x595c
// Size: 0xe4
function brking_getcenterofcircle()
{
    circlepercent = brking_getcirclepercentmoved();
    
    if ( level.br_circle.circleindex < 0 )
    {
        return level.br_level.br_circlecenters[ 0 ];
    }
    
    if ( circlepercent > 1 )
    {
        return level.br_level.br_circlecenters[ level.br_circle.circleindex ];
    }
    
    curcircle = level.br_level.br_circlecenters[ level.br_circle.circleindex + 1 ];
    prevcircle = level.br_level.br_circlecenters[ level.br_circle.circleindex ];
    return vectorlerp( prevcircle, curcircle, brking_getcirclepercentmoved() );
}

// Namespace br_gametype_kingslayer
// Params 1
// Checksum 0xfeabe48c, Offset: 0x5a49
// Size: 0x3b, Type: bool
function brking_ispointinmovingcircle( point )
{
    center = brking_getcenterofcircle();
    disttopoint = distance2d( point, center );
    return disttopoint < level.ks_circleradius;
}

// Namespace br_gametype_kingslayer
// Params 2
// Checksum 0x51769255, Offset: 0x5a8d
// Size: 0x3b
function brking_getrandompointinmovingcircle( percentmin, percentmax )
{
    center = brking_getcenterofcircle();
    return br_circle::getrandompointincircle( center, level.ks_circleradius, percentmin, percentmax );
}

// Namespace br_gametype_kingslayer
// Params 1, eflags: 0x4
// Checksum 0x3f5d640b, Offset: 0x5ad1
// Size: 0xe, Type: bool
function private brking_ondeadevent( team )
{
    return true;
}

